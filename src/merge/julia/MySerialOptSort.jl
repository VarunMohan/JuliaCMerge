module MySerialOptSort

#=

Implementation of Julia's Default Stable Sort from Base.Sort Module

with Optimizations

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
function MergeSort!(v::Array{UInt32,1}, lo::Int, hi::Int, t=similar(v,0))
    @inbounds if lo < hi
        hi-lo <= SMALL_THRESHOLD && return InsertionSort!(v, lo, hi)

        m = (lo+hi)>>>1
        isempty(t) && resize!(t, m-lo+1)

        MergeSort!(v, lo,  m, t)
        MergeSort!(v, m+1, hi, t)

	merge(v, lo, hi, t)
    end

    return v
end

# Base.Sort implementation of merge routine with UInt32
#  - Moved to separate method for ease of reading
@inline function merge(v::Array{UInt32,1}, lo::Int, hi::Int, t::Array{UInt32,1})
    m = (lo+hi)>>>1

    j = m + 1
    copy!(t, 1, v, lo, m - lo + 1)

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

# Interface method
function sort!(A::Array{UInt32,1})
    MergeSort!(A, 1, length(A))
end

end
