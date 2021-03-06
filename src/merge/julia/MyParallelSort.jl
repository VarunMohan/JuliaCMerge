module MyParallelSort


#=

Implementation of Julia's Default Stable Sort from Base.Sort Module

=#

const SMALL_THRESHOLD = 20 # Julia's Base.Sort uses 20

# Base.Sort implementation of InsertionSort with UInt32
function InsertionSort!(v::Array{UInt32,1}, lo::Int, hi::Int)
    @inbounds for i = lo+1:hi
        j = i
        x = v[i]
        while j > lo
            if x < v[j-1]
                v[j] = v[j-1]
                j -= 1
                continue
            end
            break
        end
        v[j] = x
    end
    return v
end

# Base.Sort implementation of MergeSort with UInt32
#  - Calls InsertionSort for problems of size <= 32
function MergeSortSerial!(v::Array{UInt32,1}, lo::Int, hi::Int, t=similar(v,0))
    @inbounds if lo < hi
        hi-lo <= SMALL_THRESHOLD && return InsertionSort!(v, lo, hi)

        m = (lo+hi)>>>1
        isempty(t) && resize!(t, m-lo+1)

        MergeSortSerial!(v, lo,  m, t)
        MergeSortSerial!(v, m+1, hi, t)

	m = (lo+hi)>>>1

	i, j = 1, lo
	while j <= m
	    t[i] = v[j]
	    i += 1
	    j += 1
	end

	i, k = 1, lo
	while k < j <= hi
	    if v[j] < t[i]
		v[k] = v[j]
		j += 1
	    else
		v[k] = t[i]
		i += 1
	    end
	    k += 1
	end
	while k < j
	    v[k] = t[i]
	    k += 1
	    i += 1
	end
    end

    return v
end

function MergeSortSpawn!(v::Array{UInt32,1}, lo::Int, hi::Int)
    x = v[lo:hi]
    MergeSortSerial!(x, lo, hi)
    return x
end
# Base.Sort implementation of MergeSort with UInt32
#  - Calls InsertionSort for problems of size <= 32
function MergeSort!(v::Array{UInt32,1}, lo::Int, hi::Int)
    @inbounds if lo < hi
        hi-lo <= SMALL_THRESHOLD && return InsertionSort!(v, lo, hi)

        m = (lo+hi)>>>1
        r = @spawnat 2 MergeSortSpawn!(v, lo,  m)
        MergeSortSerial!(v, m+1, hi)
	newt = fetch(r)
	m = (lo+hi)>>>1
	j = m+1
	i, k = 1, lo
	while k < j <= hi
	    if v[j] < newt[i]
		v[k] = v[j]
		j += 1
	    else
		v[k] = newt[i]
		i += 1
	    end
	    k += 1
	end
	while k < j
	    v[k] = newt[i]
	    k += 1
	    i += 1
	end
    end

    return v
end

# Interface method
function sort!(A::Array{UInt32,1})
    MergeSort!(A, 1, length(A))
end

end
