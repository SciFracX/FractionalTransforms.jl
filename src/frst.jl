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
    frst(signal, α, p)

Computing the α order fractional sine transform of the input **signal**.
"""
function frst(signal, α, p)
    N = length(signal)
    signal = signal[:]
    p=min(max(2, p), N-1)
    E=dFRST(N,p)
    result = E *(exp.(-im*pi*α*collect(0:N-1)) .*(E' *signal))
    return result
end

function dFRST(N, p)
    N1 = 2*N+2
    d2 = [1, -2, 1]

    d_p = 1
    s=0
    st=zeros(1, N1)

    for k = 1:Int64(floor(p/2))
        if typeof(d_p) <: Int64
            d_p = d2.*d_p
        else
            d_p = DSP.conv(d2, d_p)
        end
        st[vcat(collect(N1-k+1:N1), collect(1:k+1))] = d_p
        st[1]=0
        temp=vcat(union(1, collect(1:k-1)), union(2,collect(1:k-1)))
        temp = temp[:] ./collect(1:2*k)
        s=s.+(-1)^(k-1)*prod(temp)*2*st
    end

    H = Toeplitz(s[:], s[:]) +diagm(real.(fft(s[:])))


    N=Int64(N)
    V = hcat(zeros(N), reverse(zeros(N, N)+I, dims=1), zeros(N), -zeros(N, N)+I) ./sqrt(2)

    Od = V*H*V'

    eo, vo = eigen(Od)

    return reverse(reverse(vo, dims=2), dims=1)

end