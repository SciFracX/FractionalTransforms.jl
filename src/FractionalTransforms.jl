"""
    FractionalTransforms

A Julia package providing implementations of three types of discrete fractional transforms:
Fractional Fourier Transform (FRFT), Fractional Sine Transform (FRST), and Fractional Cosine Transform (FRCT).

These transforms are generalizations of classical transforms that introduce a fractional order parameter α,
allowing for intermediate frequency-domain representations between the time and frequency domains.

## Main Exported Functions

- `frft(signal, α)` - Fractional Fourier Transform
- `frst(signal, α, p)` - Fractional Sine Transform
- `frct(signal, α, p)` - Fractional Cosine Transform

## Features

- **Type Generic**: Supports Float32, Float64, and other numeric types for flexible precision
- **Optimized**: Includes caching of basis matrices for improved performance on repeated calls
- **Numerically Stable**: Proper type handling and promotion for reliable results

## References

See individual function docstrings for algorithm references.
"""
module FractionalTransforms

using LinearAlgebra, DSP, ToeplitzMatrices, FFTW

include("frft.jl")
include("frst.jl")
include("frct.jl")

# FRFT - Fractional Fourier Transform
# 
# frft(signal, α)
#
# Compute the Fractional Fourier Transform (FRFT) of the input signal.
#
# The FRFT is a generalization of the standard Fourier Transform with a fractional 
# parameter α that controls the rotation angle in the time-frequency plane:
#   • α=0: Returns the original signal unchanged
#   • α=1: Performs standard FFT (frequency domain)
#   • α=2: Approximates time reversal
#   • α=4: Full rotation, returns to original signal (periodic behavior)
#
# Parameters:
#   - signal: Input vector (any numeric type: Float32, Float64, etc.)
#   - α: Fractional order parameter (typically 0 ≤ α ≤ 4)
#
# Returns:
#   - Vector of complex numbers representing transform coefficients
#
# Implementation:
#   - Optimized FFT-based algorithm using chirp convolution
#   - Supports arbitrary numeric precision with type promotion
#   - Special-case handling for α ∈ {0, 1, 2, 3} for efficiency
#
# Example:
#   frft([1, 2, 3], 0.5) → [0.218... - 0.480...im, 3.168... + 0.383...im, ...]
#
# References:
#   Özaktas, H. M., & Kutay, M. A. (2001). The fractional Fourier transform.
#   In Advances in imaging and electron physics (Vol. 119, pp. 239-291). Elsevier.
export frft

# Reserved for future implementation
export freq_shear, time_shear, sinc_interp

# FRST - Fractional Sine Transform
#
# frst(signal, α, p)
#
# Compute the Fractional Sine Transform (FRST) of the input signal.
#
# The FRST uses an eigendecomposition approach based on finite-difference operators:
#   • Built on Toeplitz matrices derived from discrete finite-difference kernels
#   • Parameter p controls the order of finite-difference approximation
#   • Supports fractional orders α to interpolate between identity and sine transform
#   • When α=0: Returns signal (with certain normalization)
#   • When α=1: Approximates the standard sine transform
#
# Parameters:
#   - signal: Input vector (any numeric type: Float32, Float64, etc.)
#   - α: Fractional order parameter
#   - p: Finite-difference order (typically 2-3, auto-clamped to [2, N-1])
#
# Returns:
#   - Vector of complex numbers representing transform coefficients
#
# Performance:
#   - Basis matrices are automatically cached by (N, p, data_type) tuple
#   - Subsequent calls with identical parameters reuse cached matrices
#   - Significant speedup for repeated transforms on same-sized signals
#
# Implementation Details:
#   - Eigenvalue decomposition of Toeplitz matrices
#   - Type-aware matrix construction (preserves Float32 or Float64 precision)
#   - Intermediate allocation optimization via vectorized operations
#
# Example:
#   frst([1, 2, 3], 0.5, 2) → [1.707... + 1.207...im, 2.0 - 1.707...im, ...]
#
# References:
#   Pei, S. C., & Yeh, M. H. (2001). The discrete fractional sine and cosine transforms.
#   IEEE Transactions on Signal Processing, 49(7), 1198-1207.
export frst

# FRCT - Fractional Cosine Transform
#
# frct(signal, α, p)
#
# Compute the Fractional Cosine Transform (FRCT) of the input signal.
#
# Similar to FRST, the FRCT uses an eigendecomposition approach with modifications:
#   • Built on modified Toeplitz matrices with spectral corrections
#   • Parameter p controls the order of finite-difference approximation
#   • Supports fractional orders α to interpolate between identity and cosine transform
#   • When α=0: Returns signal (with certain normalization)
#   • When α=1: Approximates the standard cosine transform
#
# Parameters:
#   - signal: Input vector (any numeric type: Float32, Float64, etc.)
#   - α: Fractional order parameter
#   - p: Finite-difference order (typically 2-3, auto-clamped to [2, N-1])
#
# Returns:
#   - Vector of complex numbers representing transform coefficients
#
# Performance:
#   - Basis matrices are automatically cached by (N, p, data_type) tuple
#   - Subsequent calls with identical parameters reuse cached matrices
#   - Significant speedup for repeated transforms on same-sized signals
#
# Implementation Details:
#   - Eigenvalue decomposition of modified Toeplitz matrices with FFT corrections
#   - Type-aware matrix construction (preserves Float32 or Float64 precision)
#   - Optimized V matrix construction to minimize intermediate allocations
#
# Example:
#   frct([1, 2, 3], 0.5, 2) → [1.707... + 0.987...im, 1.560... - 1.396...im, ...]
#
# References:
#   Pei, S. C., & Yeh, M. H. (2001). The discrete fractional sine and cosine transforms.
#   IEEE Transactions on Signal Processing, 49(7), 1198-1207.
export frct

end