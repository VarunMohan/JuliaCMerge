module MyCopy

function unsafe_copy!{T}(dest::Ptr{T}, src::Ptr{T}, N)
    ccall(:memmove, Ptr{Void}, (Ptr{Void}, Ptr{Void}, Uint),
          dest, src, N*sizeof(T))
    return dest
end

function unsafe_copy!{T}(dest::Array{T}, dsto, src::Array{T}, so, N)
    if isbits(T)
        unsafe_copy!(pointer(dest, dsto), pointer(src, so), N)
    else
        for i=0:N-1
            @inbounds arrayset(dest, src[i+so], i+dsto)
        end
    end
    return dest
end

function copy!{T}(dest::Array{T}, dsto::Integer, src::Array{T}, so::Integer, N::Integer)
    if so+N-1 > length(src) || dsto+N-1 > length(dest) || dsto < 1 || so < 1
        throw(BoundsError())
    end
    unsafe_copy!(dest, dsto, src, so, N)
end

end
