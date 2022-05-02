# FractionalTransforms.jl

<p align="center">
<img width="250px" src="https://raw.githubusercontent.com/SciFracX/FractionalTransforms.jl/master/docs/src/assets/logo.svg"/>
</p>

<p align="center">
  <a href="https://github.com/SciFracX/FractionalTransforms.jl/actions?query=workflow%3ACI">
    <img alt="building" src="https://github.com/SciFracX/FractionalTransforms.jl/workflows/CI/badge.svg">
  </a>
  <a href="https://codecov.io/gh/SciFracX/FractionalTransforms.jl">
    <img alt="codecov" src="https://codecov.io/gh/SciFracX/FractionalTransforms.jl/branch/master/graph/badge.svg">
  </a>
  <a href="https://www.erikqqy.xyz/FRFT.jl/dev/">
    <img src="https://img.shields.io/badge/docs-dev-blue.svg" alt="license">
  </a>
  <a href="https://github.com/SciFracX/FractionalTransforms.jl/blob/master/LICENSE">
    <img src="https://img.shields.io/github/license/SciFracX/FractionalTransforms.jl?style=flat-square" alt="license">
  </a>
</p>

<p align="center">
  <a href="https://github.com/SciFracX/FractionalTransforms.jl/issues">
    <img alt="GitHub issues" src="https://img.shields.io/github/issues/SciFracX/FractionalTransforms.jl?style=flat-square">
  </a>
  <a href="#">
    <img alt="GitHub stars" src="https://img.shields.io/github/stars/SciFracX/FractionalTransforms.jl?style=flat-square">
  </a>
  <a href="https://github.com/SciFracX/FractionalTransforms.jl/network">
    <img alt="GitHub forks" src="https://img.shields.io/github/forks/SciFracX/FractionalTransforms.jl?style=flat-square">
  </a>
</p>

## Installation

If you have already installed Julia, you can install FractionalTransforms.jl in REPL using Julia package manager:

```julia
pkg> add FractionalTransforms
```

## Quick start

### Fractional Fourier Transform

Compute the Fractional Fourier transform by the following command:

```julia
frft(signal, order)
```

### Fractional Sine Transform

Compute the Fractional Sine transform by the following command:

```julia
julia> frst(signal, order, p)
```

### Fractional Cosine Transform

Compute the Fractional Cosine transform by the following command:

```julia
julia> frct(signal, order, p)
```

## Introduce

The custom Fourier Transform transforms the input signal from time domain to frequency domain, the Fractional Fourier transform, in a more generalized aspect, can transform the input signal to the fractional domain, reveal more properties and features of the signal.

## Plans

* Add more examples relating to signal processing, image processing etc.
* Cover more algorithms, including Fractional Hadamard Transform, Fractional Gabor Transform...

## Acknowledgements

I would like to express gratitude to 

* *Jeffrey C. O'Neill* for what he has done in [DiscreteTFDs](http://tfd.sourceforge.net/).
* [Digital computation of the fractional Fourier transform](https://ieeexplore.ieee.org/document/536672) by [H.M. Ozaktas](https://ieeexplore.ieee.org/author/37294843100); [O. Arikan](https://ieeexplore.ieee.org/author/37350304900); [M.A. Kutay](https://ieeexplore.ieee.org/author/37350303800); [G. Bozdagt](https://ieeexplore.ieee.org/author/37086987430)
* [The discrete fractional cosine and sine transforms](http://dx.doi.org/10.1109/78.923302) by Pei, Soo-Chang and Yeh, Min-Hung.
* https://nalag.cs.kuleuven.be/research/software/FRFT/

> Please note that FRFT, FRST and FRCT are adapted from Matlab files, credits go to the original authors, bugs are my own.