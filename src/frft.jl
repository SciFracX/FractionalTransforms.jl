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
    
    f = f[:]
    f=ComplexF64.(f)
    N = length(f)
    signal = zeros(ComplexF64, N)
    shft = rem.(collect(Int64, 0:N-1).+floor(Int64, N/2), N).+1
    sN = sqrt(N)
    α = mod(α, 4)
    
    if α==0
        signal = f
        return signal
    end
    if α==2
        signal = reverse(f, dims=1)
        return signal
    end
    if α==1
        signal[shft,1] = fft(f[shft])/sN
        return signal
    end 
    if α==3
        signal[shft, 1] = ifft(f[shft])*sN
        return signal
    end
    

    if α>2.0
        α = α-2
        f = reverse(f, dims=1)
    end
    if α>1.5
        α = α-1
        f[shft] = fft(f[shft])/sN
    end
    if α<0.5
        α = α+1
        f[shft, 1] = ifft(f[shft])*sN
    end
    
    alpha = α*pi/2
    tana2 = tan(alpha/2)
    sina = sin(alpha)
    f = [zeros(N-1,1) ; interp(f) ; zeros(N-1,1)]
    

    chrp = exp.(-im*pi/N*tana2/4*collect(-2*N+2:2*N-2).^2)
    f = chrp.*f
    

    c = pi/N/sina/4;
    signal = fconv(exp.(im*c*collect(-(4*N-4):4*N-4).^2), f)
    signal = signal[4*N-3:8*N-7]*sqrt(c/pi)
    

    signal = chrp.*signal
    
    signal = @. exp(-im*(1-α)*pi/4)*signal[N:2:end-N+1]

    return signal
end

function interp(x)
    N = length(x)
    y = zeros(ComplexF64, 2*N-1, 1)
    y[1:2:2*N-1] = x
    xint = fconv(y[1:2*N-1], sinc.(collect(-(2*N-3):(2*N-3))'/2))
    xint = xint[2*N-2:end-2*N+3]
    return xint
end

function fconv(x,y)

    N = length([x[:];  y[:]])-1
    P::Int = nextpow(2, N)
    z = ifft(ourfft(x, P) .* ourfft(y, P))
    z = z[1:N]
    return z
end

function ourfft(x, n)
    s=length(x)
    x=x[:]
    if s > n
        return fft(x[1:n])
    elseif s < n
        return fft([x; zeros(n-s)])
    else
        return fft(x)
    end
end

function ourifft(x, n)
    s=length(x)
    x=x[:]
    if s > n
        return ifft(x[1:n])
    elseif s < n
        return ifft([x; zeros(n-s)])
    else
        return ifft(x)
    end
end