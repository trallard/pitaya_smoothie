const onevec = 1:1
const emptyvec = 1:0
@inline inbounds(itp::AbstractInterpolation, x...) = _inbounds.(bounds(itp), x)
_inbounds((l,u)::Tuple{Number,Number}, x::Number) = ifelse(l <= x <= u, onevec, emptyvec)
function _inbounds((l,u)::Tuple{Number,Number}, x::AbstractVector)
    ret = Int[]
    for i in eachindex(x)
        l <= x[i] <= u && push!(ret, i)
    end
    ret
end

function getindex!(dest, itp, xs...)
    for (i, x) in zip(eachindex(dest), Iterators.product(xs...))
        dest[i] = itp(x...)
    end
    return dest
end