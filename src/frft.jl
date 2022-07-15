"""
    frft(signal, α)

By entering the signal and the order, we can obtain the Fractional Fourier transform value.

# Example

```julia-repl
julia> frft([1,2,3], 0.5)
0.10046461358821344 - 0.25940948097727745im
3.0746001042331557 + 0.19934938154063286im
1.3156643288728376 - 0.9364535656119107im
```
"""
function frft(signal, α)::Vector{ComplexF64}
    
    #Ensure the input signal is proper
    isa(signal, AbstractArray) ? nothing : error("Please input a proper signal")

    N = length(signal)
    M = Int64((N-1)/2)

    if rem(N, 2)==0
        error("Signal must be odd")
    end

    ##For α special cases
    #If the order is an integer, the fourier transform would be its n-th order Fourier transform.
    α = mod(α, 4)
    if α == 0
        return signal
    elseif α == 1
        y = fft([signal[M+1:N]; signal[1:M]])/sqrt(N)
        y = [y[M+2 : N]; y[1:M+1]]
        return y
    elseif α == 2
        y = reverse(signal, dims=1)
        return y
    elseif α == 3
        y = ifft([signal[M+1:N]; signal[1:M]])*sqrt(N)
        y = [y[M+2:N]; y[1:M+1]]
        return y
    end

    if α > 2
        signal = reverse(signal, dims=1)
        α = α-2
    end
    if α > 1.5
        signal = fft([signal[M+1:N]; signal[1:M]]) ./sqrt(N)
        signal = [signal[M+2 : N]; signal[1:M+1]]
        α = α-1
    end
    if α < 0.5
        signal = ifft([signal[M+1:N]; signal[1:M]]) .*sqrt(N)
        signal = [signal[M+2:N]; signal[1:M+1]]
        α = α+1
    end

    # We need to distinguish **order** and **angle**
    ϕ = α*π/2

    # Set the sampling rate as 3.
    signal = sinc_interp(signal, 3)
    signal = [zeros(ComplexF64, 2*M); signal; zeros(ComplexF64, 2*M)]

    x2 = freq_shear(signal, 2*pi/N*(cot(ϕ)-csc(ϕ))/3^2)
    x3 = time_shear(x2, 2*pi/N*csc(ϕ)/3^2)
    y = freq_shear(x3, 2*pi/N*(cot(ϕ)-csc(ϕ))/3^2)

    y = y[2*M+1:end-2*M]
    y = y[1:3:end]
    y = @. exp(-im*(pi*sign(sin(ϕ))/4-ϕ/2))*y

    return y
end

function freq_shear(x, c)
    x = x[:]
    N = length(x)
    if rem(N, 2) == 0
        error("Signal must be odd")
    end

    M = (N-1)/2
    N = collect(-M:M)

    y = @. x*exp(im*c/2*N^2)
    return y
end

function time_shear(x, c)
    x = x[:]
    N = length(x)

    if rem(N, 2) == 0
        error("Signal must be odd")
    end
    M = Int64((N-1)/2)
    
    interp = ceil(Int, 2*abs(c)/(2*pi/N))
    xx = sinc_interp(x, interp) ./interp
    n = collect(-2*M:1/interp:2*M)
    z = @. exp(im*c/2*n^2)
    y = conv(xx, z)
    center = (length(y)+1)/2
    y = y[Int64(center-interp*M):Int64(interp):Int64(center+interp*M)]
    y = @. y*sqrt(c/2/pi)
end

"""
    sinc_interp(signal, rate)

```Sinc interpolation``` of **signal** at rate **rate**.

For more details, please refer to [Whittaker-Shannon interpolation](https://en.wikipedia.org/wiki/Whittaker%E2%80%93Shannon_interpolation_formula).
"""
function sinc_interp(x, rate)
    x = x[:]
    N = length(x)
    M = rate*N - rate + 1

    y = zeros(ComplexF64, M)
    y[1:rate:M] = x

    h =  sinc.(collect(-(N-1-1/rate):1/rate:(N-1-1/rate)))
    out = conv(y, h)
    out = out[(rate*N-rate):(end-rate*N+rate+1)]
end