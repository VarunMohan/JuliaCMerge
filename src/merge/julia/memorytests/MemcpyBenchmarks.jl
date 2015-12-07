NUM_TRIALS = 10 
N = 2^25

# Benchmark Copying Methods
function benchmark_memcpy(num_trials, n)
    A = rand(UInt32, n)
    B = similar(A)
    tic()
    for k = 1:num_trials
        j = 1
        for j = 1:n
            B[j] = A[j]
        end
    end
    naive_copy = toq()
    tic()
    for k = 1:num_trials
        copy!(B, A)
    end
    inplace_copy = toq()
    tic()
    for k = 1:num_trials
       ccall(:memcpy, Ptr{Void}, (Ptr{Void}, Ptr{Void}, UInt), B, A, n*sizeof(UInt32))
    end
    memcpy_copy = toq()
    tic()
    for k = 1:num_trials
        copy!(B, 65, A, 65, n - 64)
    end
    copy_aligned_offset = toq()
    tic()
    for k = 1:num_trials
        copy!(B, k, A, 65, n - 64)
    end
    copy_unaligned_offset = toq()
    tic()
    for k = 1:num_trials
       ccall(:memcpy, Ptr{Void}, (Ptr{Void}, Ptr{Void}, UInt), pointer(B, k), pointer(A, 1), (n - 64)*sizeof(UInt32))
    end
    memcpy_unaligned_offset = toq()
    println("NAIVE COPY TIME: ", naive_copy/num_trials)
    println("INPLACE JULIA MEMMOVE COPY: ", inplace_copy/num_trials)
    println("INPLACE JULIA MEMCPY: ", memcpy_copy/num_trials)
    println("INPLACE JULIA MEMCPY UNALIGNED OFFSET: ", memcpy_unaligned_offset/num_trials)
    println("INPLACE JULIA COPY ALIGNED OFFSET: ", copy_aligned_offset/num_trials)
    println("INPLACE JULIA COPY UNALIGNED OFFSET: ", copy_unaligned_offset/num_trials)
end

benchmark_memcpy(NUM_TRIALS, N)
