using FractionalTransforms
using Test

@testset "Test FRST" begin
    # Test case 1: Basic test with N=3, α=0.5, p=2
    @test isapprox(real(frst([1,2,3], 0.5, 2)), [1.707106781186548, 2, -1.1213203435596437], atol=1e-5)
    @test isapprox(imag(frst([1,2,3], 0.5, 2)), [1.207106781186547, -1.7071067811865481, -1.2071067811865468], atol=1e-5)
    
    # Test case 2: Different signal length (N=4) with α=0.5, p=2
    result_len4 = frst([1, 2, 3, 4], 0.5, 2)
    @test isapprox(real(result_len4), [1.4606984249804928, 3.307763104892992, -0.889328136337913, -1.4445383347739846], atol=1e-5)
    @test isapprox(imag(result_len4), [1.7417371466337868, -1.3285490748536712, -2.9892876731505944, 0.5594069121361468], atol=1e-5)
    
    # Test case 3: Different α value (α=0.25) with N=3, p=2
    result_alpha025 = frst([1, 2, 3], 0.25, 2)
    @test isapprox(real(result_alpha025), [1.103553390593274, 2.353553390593274, 1.1893398282201781], atol=1e-5)
    @test isapprox(imag(result_alpha025), [0.6035533905932737, -0.3535533905932742, -2.3106601717798214], atol=1e-5)
    
    # Test case 4: Different p value (p=3) with N=4, α=0.5
    result_p3 = frst([1, 2, 3, 4], 0.5, 3)
    @test isapprox(real(result_p3), [1.4606984249804928, 3.307763104892992, -0.889328136337913, -1.4445383347739846], atol=1e-5)
    @test isapprox(imag(result_p3), [1.7417371466337868, -1.3285490748536712, -2.9892876731505944, 0.5594069121361468], atol=1e-5)
    
    # Test case 5: Identity case (α=0.0) - should return close to input in real part
    result_identity = frst([1, 2, 3], 0.0, 2)
    @test isapprox(real(result_identity), [1.0, 2.0, 3.0], atol=1e-5)
    @test isapprox(imag(result_identity), [0.0, 0.0, 0.0], atol=1e-5)
    
    # Test case 6: Fractional order α=1.0 with N=3, p=2
    result_alpha1 = frst([1, 2, 3], 1.0, 2)
    @test isapprox(real(result_alpha1), [3.414213562373094, -1.4142135623730951, 0.5857864376269075], atol=1e-5)
    @test isapprox(imag(result_alpha1), [0.0, 0.0, 0.0], atol=1e-5)
    
    # Test case 7: Float32 precision - verify type generalization
    result_f32 = frst(Float32[1, 2, 3], 0.5f0, 2)
    @test eltype(result_f32) == ComplexF32
    @test isapprox(real(result_f32), [1.7071068f0, 2.0f0, -1.121321f0], atol=1e-5)
    @test isapprox(imag(result_f32), [1.2071067f0, -1.7071066f0, -1.2071064f0], atol=1e-5)
    
    # Test case 8: Minimal signal length (N=2)
    result_min = frst([1.0, 2.0], 0.5, 2)
    @test isapprox(real(result_min), [1.0, 0.0], atol=1e-5)
    @test isapprox(imag(result_min), [0.0, -2.0], atol=1e-5)
end