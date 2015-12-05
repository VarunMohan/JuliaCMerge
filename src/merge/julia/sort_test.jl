include("sort.jl")

using MySort

using Base.Test
using Base.Sort

N = 2^23
NUM_TESTS = 1

function gen_test(n)
    A = zeros(UInt32, n)
    for i in 1:n
        A[i] = rand(UInt32)
    end
    A
end

println("Testing InsertionSort")
for i in 1:NUM_TESTS
    A = gen_test(N)
    B = copy(A)
    @test MySort.InsertionSort!(A, 1, N) == sort!(B, alg=Sort.InsertionSort)
end

println("Testing MergeSort")
for i in 1:NUM_TESTS
    A = gen_test(N)
    B = copy(A)
    @test MySort.MergeSort!(A, 1, N) == sort!(B, alg=Sort.MergeSort)
end

A = gen_test(N)
B = copy(A)
tic()
MySort.MergeSort!(A, 1, N)
toc()

tic()
sort!(B, alg=Sort.MergeSort)
toc()
