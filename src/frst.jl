"""
    frst(signal, α, p)

Computing the α order fractional sine transform of the input **signal**.

# Example

```julia-repl
julia> frst([1,2,3], 0.5, 2)
3-element Vector{ComplexF64}:
1.707106781186548 + 1.207106781186547im
1.9999999999999998 - 1.7071067811865481im
-1.1213203435596437 - 1.2071067811865468im
```

### References

```tex
@article{article,
author = {Pei, Soo-Chang and Yeh, Min-Hung},
year = {2001},
month = {07},
pages = {1198 - 1207},
title = {The discrete fractional cosine and sine transforms},
volume = {49},
journal = {Signal Processing, IEEE Transactions on},
doi = {10.1109/78.923302}
}
```
"""
const DFRST_CACHE = Dict{Tuple{Int, Int, DataType}, Matrix}()

function frst(signal, α, p)
    N = length(signal)
    signal = vec(signal)
    p = clamp(p, 2, N - 1)
    T = promote_type(float(real(eltype(signal))), float(typeof(α)))
    signal = complex.(convert.(T, signal))
    E = dFRST(N, p, T)
    result = E' * signal
    result .*= cispi.(-α .* (0:N-1))
    return E * result
end

function dFRST(N, p, ::Type{T}) where {T}
    return get!(DFRST_CACHE, (N, p, T)) do
        _dFRST(N, p, T)
    end
end

function _dFRST(N, p, ::Type{T}) where {T}
    N1 = 2 * N + 2
    half_p = fld(p, 2)
    s = zeros(T, N1)
    st = zeros(T, N1)
    d_p = T[one(T), -2 * one(T), one(T)]
    coeff = 2 * one(T)

    for k in 1:half_p
        if k > 1
            d_p = second_difference(d_p)
            coeff *= -((k - 1)^2) * one(T) / ((2 * k) * (2 * k - 1))
        end

        @views st[N1-k+1:N1] .= d_p[1:k]
        @views st[1:k+1] .= d_p[k+1:end]
        st[1] = zero(T)
        s .+= coeff .* st
    end

    spectrum = real.(fft(s))
    H = Matrix(Toeplitz(s, s))
    @inbounds for i in eachindex(s)
        H[i, i] += spectrum[i]
    end

    invsqrt2 = inv(sqrt(T(2)))
    V = zeros(T, N, N1)
    @inbounds for i in 1:N
        V[i, N - i + 2] = invsqrt2
        V[i, N + i + 2] = -invsqrt2
    end

    Od = Symmetric(V * H * V')
    vo = eigen(Od).vectors
    return reverse(reverse(vo, dims = 2), dims = 1)
end

function second_difference(x::AbstractVector{T}) where {T}
    n = length(x)
    y = Vector{T}(undef, n + 2)
    y[1] = x[1]
    y[2] = x[2] - 2 * x[1]

    @inbounds for i in 3:n
        y[i] = x[i] - 2 * x[i - 1] + x[i - 2]
    end

    y[n + 1] = x[n - 1] - 2 * x[n]
    y[n + 2] = x[n]
    return y
end