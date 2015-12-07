NUM_TRIALS = 100
N = 2^26

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

    memcopy_time = toq()
    println("NAIVE COPY TIME: ", naive_copy/num_trials)
    println("INPLACE JULIA MEMMOVE COPY: ", inplace_copy/num_trials)
    println("INPLACE JULIA MEMCPY: ", inplace_copy/num_trials)
end

benchmark_memcpy(NUM_TRIALS, N)
