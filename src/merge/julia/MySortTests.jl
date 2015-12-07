@everywhere include("MySerialSort.jl")
@everywhere include("MySerialOptSort.jl")
@everywhere include("MyParallelSort.jl")
@everywhere include("MyParallelSASort.jl")

using Base.Test
using Base.Sort
using MySerialSort
using MySerialOptSort
using MyParallelSort
using MyParallelSASort

N = 2^10 # Array Size

NUM_TESTS  = 1
NUM_TRIALS = 1

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
        D = copy(C)

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

    for i in 1:num_trials
        A = gen_parallel_test(n)

        # Parallel Sort with SharedArray
        tic()
        MyParallelSASort.sort!(A)
        parallel_sa_t += toq() 
    end

    println("Base.Sort")
    println("\t", basesort_t / num_trials)
    println("MySerialSort")
    println("\t", serial_t / num_trials)
    println("MySerialOptSort")
    println("\t", serial_opt_t / num_trials)
    println("MyParallelSASort")
    println("\t", parallel_sa_t / num_trials)
end

println("Testing Parallel SharedArray MergeSort...")
test_serial_sort(MySerialOptSort.sort!, NUM_TRIALS, N)
println("Testing Complete!")
println("Running Benchmark Suite...")
benchmark_sort(NUM_TRIALS, N)
