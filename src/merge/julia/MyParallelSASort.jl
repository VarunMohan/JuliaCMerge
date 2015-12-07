module MyParallelSASort

#=

Implementation of Julia's Default Stable Sort from Base.Sort Module

with Optimizations

=#

const SMALL_THRESHOLD = 20 # Julia's Base.Sort uses 20
const NUM_CORES = CPU_CORES * 2 # factor of two because of hyperthreading

# Base.Sort implementation of InsertionSort with UInt32
function InsertionSort!(v::SharedArray{UInt32,1}, lo::Int, hi::Int)
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

function MergeSortHelper!(v::SharedArray{UInt32,1}, lo::Int, hi::Int, t=SharedArray(eltype(v), size(v)))
    @inbounds if lo < hi
        hi-lo <= SMALL_THRESHOLD && return InsertionSort!(v, lo, hi)

        m = (lo+hi)>>>1
        isempty(t) && resize!(t, m-lo+1)
        MergeSortHelper!(v, lo,  m, t)
        MergeSortHelper!(v, m+1, hi, t)
	m = (lo+hi)>>>1

	j = m + 1
        copy!(t, lo, v, lo, m - lo + 1)

	i, k = lo, lo
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

# Base.Sort implementation of MergeSort with UInt32
#  - Calls InsertionSort for problems of size <= 32
function MergeSort!(v::SharedArray{UInt32,1}, lo::Int, hi::Int, cur_proc::Int, num_procs::Int, t=SharedArray(eltype(v), size(v)))
    if num_procs < 2
        return MergeSortHelper!(v, lo, hi, t)
    end
    @inbounds if lo < hi
        hi-lo <= SMALL_THRESHOLD && return InsertionSort!(v, lo, hi)

        m = (lo+hi)>>>1
        isempty(t) && resize!(t, m-lo+1)

        next_proc = convert(Int, cur_proc + floor(num_procs/2))
        num_procs_remaining = convert(Int, floor(num_procs/2))
        r = @spawnat next_proc MergeSort!(v, lo, m, next_proc, num_procs - num_procs_remaining, t)
        MergeSort!(v, m+1, hi, cur_proc, num_procs_remaining, t)

        wait(r)
        j = m + 1
        copy!(t, lo, v, lo, m - lo + 1)
        i, k = lo, lo
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
        copy!(v, k, t, i, j - k)
    end

    return v
end

# Interface method
function sort!(A::SharedArray{UInt32,1})
    num_procs = 1
    MergeSort!(A, 1, length(A), 1, num_procs)
end

# Interface method
function sort!(A::SharedArray{UInt32,1}, num_procs::Int)
    MergeSort!(A, 1, length(A), 1, num_procs)
end

end
