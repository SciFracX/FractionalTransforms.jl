using LinearAlgebra, ToeplitzMatrices, FFTW

"""
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
"""

"""
    frct(signal, α, p)

Computing the α order fractional cosine transform of the input **signal**.
"""
function frct(signal, α, p)
    N = length(signal)
    signal = signal[:]
    p=min(max(2, p), N-1)
    E=dFRCT(N,p)
    result = E *(exp.(-im*pi*α*collect(0:N-1)) .*(E' *signal))
    return result
end

function dFRCT(N, p)
    N1 = 2*N-2
    d2 = [1, -2, 1]

    d_p = 1
    s=0
    st=zeros(1, N1)

    for k = 1:Int64(floor(p/2))
        if typeof(d_p) <: Number
            d_p = d2.*d_p
        else
            d_p = DSP.conv(d2, d_p)
        end
        st[vcat(collect(N1-k+1:N1), collect(1:k+1))] = d_p
        st[1]=0
        temp=vcat(union(1, collect(1:k-1)), union(1,collect(1:k-1)))
        temp = temp[:] ./collect(1:2*k)
        s=s.+(-1)^(k-1)*prod(temp)*2*st
    end

    H = Toeplitz(s[:], s[:]) +diagm(real.(fft(s[:])))

    V = hcat(zeros(N-2), zeros(N-2, N-2)+I, zeros(N-2), reverse(zeros(N-2, N-2)+I, dims=1)) ./sqrt(2)
    V = vcat([1 zeros(1, N1-1)], V, [zeros(1, N-1) 1 zeros(1, N-2)])

    Ev = V*H*V'

    _, ee = eigen(Ev)

    E = reverse(ee, dims=2)
    E[end,:] = E[end,:]/sqrt(2)
    return E
end