"""
    frft(signal, α)

By entering the signal and the order, we can obtain the Fractional Fourier transform value.

# Example

```julia-repl
julia> frft([1,2,3], 0.5)
0.2184858049179108 - 0.48050718989735614im
3.1682634817489754 + 0.38301661364477946im
1.3827766087134183 - 1.1551815500981393im
```
"""
function frft(f, α)
    f = vec(f)
    N = length(f)
    shft = mod1.((0:N-1) .+ fld(N, 2) .+ 1, N)
    T = promote_type(float(real(eltype(f))), float(typeof(α)))
    f = complex.(convert.(T, f))
    sN = sqrt(convert(T, N))
    α = mod(α, 4)

    if α == 0
        return f
    elseif α == 2
        reverse!(f)
        return f
    elseif α == 1
        signal = similar(f)
        signal[shft] = fft(f[shft]) / sN
        return signal
    elseif α == 3
        signal = similar(f)
        signal[shft] = ifft(f[shft]) * sN
        return signal
    end

    if α > 2.0
        α -= 2
        reverse!(f)
    end
    if α > 1.5
        α -= 1
        f[shft] = fft(f[shft]) / sN
    elseif α < 0.5
        α += 1
        f[shft] = ifft(f[shft]) * sN
    end

    alpha = α * pi / 2
    tana2 = tan(alpha/2)
    sina = sin(alpha)

    interpolated = interp(f)
    padded = zeros(complex(T), 4 * N - 3)
    @views padded[N:3*N-2] .= interpolated

    chrp = exp.((-im * pi * tana2 / (4 * N)) .* ((-2 * N + 2):(2 * N - 2)).^2)
    padded .*= chrp

    c = pi / (4 * N * sina)
    signal = fconv(exp.((im * c) .* (-(4 * N - 4):(4 * N - 4)).^2), padded)
    signal = signal[4 * N - 3:8 * N - 7] .* sqrt(c / pi)
    signal .*= chrp

    phase = exp(-im * (1 - α) * pi / 4)
    result = similar(f)
    @inbounds for i in eachindex(result)
        result[i] = phase * signal[N + 2 * (i - 1)]
    end

    return result
end

function interp(x)
    N = length(x)
    T = eltype(x)
    y = zeros(T, 2 * N - 1)
    y[1:2:2*N-1] = x
    xint = fconv(y, sinc.((-(2 * N - 3):(2 * N - 3)) ./ 2))
    return xint[2 * N - 2:end - 2 * N + 3]
end

function fconv(x, y)
    N = length(x) + length(y) - 1
    P::Int = nextpow(2, N)
    T = promote_type(eltype(x), eltype(y))
    z = ifft(ourfft(x, P, T) .* ourfft(y, P, T))
    return z[1:N]
end

function ourfft(x, n, ::Type{T}) where {T}
    xvec = vec(x)
    s = length(xvec)

    if s == n
        return fft(xvec)
    end

    padded = Vector{complex(T)}(undef, n)
    copyto!(padded, 1, xvec, 1, min(s, n))
    if s < n
        fill!(@view(padded[s+1:n]), zero(complex(T)))
    end

    return fft(padded)
end

function ourifft(x, n, ::Type{T}) where {T}
    xvec = vec(x)
    s = length(xvec)

    if s == n
        return ifft(xvec)
    end

    padded = Vector{complex(T)}(undef, n)
    copyto!(padded, 1, xvec, 1, min(s, n))
    if s < n
        fill!(@view(padded[s+1:n]), zero(complex(T)))
    end

    return ifft(padded)
end