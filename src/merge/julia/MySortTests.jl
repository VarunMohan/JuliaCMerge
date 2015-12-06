include("MySerialSort.jl")

using MySerialSort

using Base.Test
using Base.Sort

N = 2^23
NUM_TESTS = 1
NUM_TRIALS = 10

function gen_test(n)
    A = zeros(UInt32, n)
    for i in 1:n
        A[i] = rand(UInt32)
    end
    A
end

println("Testing MergeSort")
for i in 1:NUM_TESTS
    A = gen_test(N)
    B = copy(A)
    @test MySerialSort.sort!(A) == sort!(B, alg=Sort.MergeSort)
end

lib_time = 0
my_time = 0
for i in 1:NUM_TRIALS
    A = gen_test(N)
    B = copy(A)
    tic()
    MySerialSort.sort!(A)
    lib_time += toq()
    tic()
    sort!(B, alg=Sort.MergeSort)
    my_time += toq()
end

println("Library Method Time")
println(lib_time / NUM_TRIALS)
println("My Method Time")
println(my_time / NUM_TRIALS)
