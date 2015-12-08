NUM_TESTS  = 1
NUM_TRIALS = 1
N = 2^16 # Array Size
N_CORES = 8
addprocs(N_CORES - 1)

@everywhere include("../merge/julia/MySerialSort.jl")
@everywhere include("../merge/julia/MySerialOptSort.jl")
@everywhere include("../merge/julia/MyParallelSort.jl")
@everywhere include("../merge/julia/MyParallelSASort.jl")

using Base.Test
using Base.Sort
using MySerialSort
using MySerialOptSort
using MyParallelSort
using MyParallelSASort


# Generates an array for serial sorting
function gen_serial_test(n)
    A = zeros(UInt32, n)
    for i in 1:n
        A[i] = rand(UInt32)
    end
    A
end

# Generates an array for parallel sorting
function gen_parallel_test(n)
    A = SharedArray(UInt32, n)
    for i in 1:n
        A[i] = rand(UInt32)
    end
    A
end

# Test Serial Sorting Algorithm
function test_serial_sort(sort_fnc, num_tests, n)
    for i in 1:num_tests
        A = gen_serial_test(n)
        B = copy(A)
        @test sort_fnc(A) == sort!(B, alg=Sort.MergeSort)
    end
end

# Test Parallel Sorting Algorithm
function test_parallel_sort(sort_fnc, num_tests, n)
    for i in 1:num_tests
        A = gen_parallel_test(n)
        B = copy(A)
        @test sort_fnc(A) == sort!(B, alg=Sort.MergeSort)
    end
end

# Benchmark Sorting Methods
function benchmark_sort(num_trials, n)
    # Init all benchmark times
    basesort_t = 0
    serial_t = 0
    serial_opt_t = 0
    parallel_t = 0
    parallel_sa_t = 0

    for i in 1:num_trials
        A = gen_serial_test(n)
        B = copy(A)
        C = copy(B)

        # Base.Sort
        tic()
        sort!(A, alg=MergeSort)
        basesort_t += toq()

        # MySerialSort
        tic()
        MySerialSort.sort!(B)
        serial_t += toq()

        # MySerialOptSort
        tic()
        MySerialOptSort.sort!(C)
        serial_opt_t += toq()
    end
    
    parallel_t = 0
    for i in 1:num_trials
        A = gen_serial_test(n)

        tic()
        MyParallelSort.sort!(A) 
        parallel_t += toq() 
    end 

    println("Base.Sort ", basesort_t / num_trials)
    println("MySerialSort ", serial_t / num_trials)
    println("MySerialOptSort ", serial_opt_t / num_trials)
    println("MyParallelSort ", parallel_t / num_trials)

    for cores in 1:N_CORES
        parallel_sa_t = 0
        for i in 1:num_trials
            A = gen_parallel_test(n)

            # Parallel Sort with SharedArray
            tic()
            MyParallelSASort.sort!(A, cores)
            parallel_sa_t += toq() 
        end
        println("MyParallelSASort ", cores, " ", parallel_sa_t / num_trials)
    end
end

test_parallel_sort(MyParallelSASort.sort!, NUM_TRIALS, N)
test_serial_sort(MyParallelSort.sort!, NUM_TRIALS, N)
benchmark_sort(NUM_TRIALS, N)
