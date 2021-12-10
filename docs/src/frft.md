# Fractional Fourier Transform

```@contents
Pages = ["frft.md"]
```

## Definition

While we are already familiar with the Fourier transform, which is defined by the integral of the product of the original function and a kernel function ``e^{-2\pi ix\xi}​``:

```math
\hat{f}(\xi)=\mathcal{F}[f(x)]=\int_{-\infty}^\infty f(x)e^{-2\pi ix\xi}dx
```

The Fractional Fourier transform has the similar definition:

```math
\hat{f}(\xi)=\mathcal{F}^{\alpha}[f(x)]=\int_{-\infty}^\infty K(\xi,x)f(x)dx
```

```math
K(\xi,x)=A_\phi \exp[i\pi(x^2\cot\phi-2x\xi\csc\phi+\xi^2\cot\phi)]
```

```math
A_\phi=\frac{\exp(-i\pi\ \mathrm{sgn}(\sin\phi)/4+i\phi/2)}{|\sin\phi|^{1/2}}
```

```math
\phi=\frac{\alpha\pi}{2}
```

To compute the α-order Fractional Fourier transform of a signal, you can directly compute using **frft** function: 

```@docs
FractionalTransforms.frft
```

## Features

The fractional Fourier transform algorithm is ``O(N\log N)`` time complexity algorithm.

## Algorithm details

The numerical algorithm can be treated as as follows:

The definition of [Fractional Fourier Transform](https://en.wikipedia.org/wiki/Fractional_Fourier_transform) being interpolated using [Shannon interpolation](https://en.wikipedia.org/wiki/Whittaker%E2%80%93Shannon_interpolation_formula), after limit the range, the formulation can be recognized as the [convolution](https://en.wikipedia.org/wiki/Convolution) of the kernel function and the chirp-modulated function. Then we can use [FFT](https://en.wikipedia.org/wiki/Fast_Fourier_transform) to compute the convolution in $O(N\ \log N)$ time. Finally, process the above output using the [chirp modulation](https://en.wikipedia.org/wiki/Chirp).

## Acknowledge:

The Fractional Fourier Transform algorithm is taken from [Digital computation of the fractional Fourier transform](https://ieeexplore.ieee.org/document/536672) by [H.M. Ozaktas](https://ieeexplore.ieee.org/author/37294843100); [O. Arikan](https://ieeexplore.ieee.org/author/37350304900); [M.A. Kutay](https://ieeexplore.ieee.org/author/37350303800); [G. Bozdagt](https://ieeexplore.ieee.org/author/37086987430) and *Jeffrey C. O'Neill* for what he has done in [DiscreteTFDs](http://tfd.sourceforge.net/).

!!! tip "Value of α"
	In FractionalTransforms.jl, α is processed as order, while in some books or papers, α would mean **angle**, which is **order\*π/2**