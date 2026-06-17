"""
    frct(signal, α, p)

Computing the α order fractional cosine transform of the input **signal**.

# Example

```julia-repl
julia> frct([1,2,3], 0.5, 2)
3-element Vector{ComplexF64}:
1.707106781186547 + 0.9874368670764581im
1.5606601717798205 - 1.3964466094067267im
-0.3535533905932727 - 0.6982233047033652im
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
const DFRCT_CACHE = Dict{Tuple{Int, Int, DataType}, Matrix}()

function frct(signal, α, p)
    N = length(signal)
    signal = vec(signal)
    p = clamp(p, 2, N - 1)
    T = promote_type(float(real(eltype(signal))), float(typeof(α)))
    signal = complex.(convert.(T, signal))
    E = dFRCT(N, p, T)
    result = E' * signal
    result .*= cispi.(-α .* (0:N-1))
    return E * result
end

function dFRCT(N, p, ::Type{T}) where {T}
    return get!(DFRCT_CACHE, (N, p, T)) do
        _dFRCT(N, p, T)
    end
end

function _dFRCT(N, p, ::Type{T}) where {T}
    N1 = 2 * N - 2
    half_p = fld(p, 2)
    s = zeros(T, N1)
    st = zeros(T, N1)
    d_p = T[one(T), -2 * one(T), one(T)]
    coeff = 2 * one(T)

    for k in 1:half_p
        if k > 1
            d_p = second_difference_frct(d_p)
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
    @inbounds for i in 1:N - 2
        V[i + 1, i + 1] = invsqrt2
        V[i + 1, N1 - i + 1] = invsqrt2
    end
    V[1, 1] = one(T)
    V[N, N] = one(T)

    Ev = Symmetric(V * H * V')
    vo = eigen(Ev).vectors

    E = reverse(vo, dims = 2)
    @views E[end, :] .*= invsqrt2
    return E
end

function second_difference_frct(x::AbstractVector{T}) where {T}
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