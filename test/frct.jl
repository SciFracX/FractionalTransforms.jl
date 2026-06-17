using FractionalTransforms
using Test

@testset "Test FRCT" begin
    # Test case 1: Basic test with N=3, α=0.5, p=2
    @test isapprox(real(frct([1,2,3], 0.5, 2)), [1.707106781186547, 1.5606601717798205, -0.3535533905932727], atol=1e-5)
    @test isapprox(imag(frct([1,2,3], 0.5, 2)), [0.9874368670764581, -1.3964466094067267, -0.6982233047033652], atol=1e-5)
    
    # Test case 2: Different signal length (N=4) with α=0.5, p=2
    result_len4 = frct([1, 2, 3, 4], 0.5, 2)
    @test isapprox(real(result_len4), [1.33178424813162, 2.8745694909700625, -0.7358987166189703, -0.7736664647984949], atol=1e-5)
    @test isapprox(imag(result_len4), [1.6638939414220273, -1.5123136107255237, -2.2287629369967386, -0.3174229863814598], atol=1e-5)
    
    # Test case 3: Different α value (α=0.25) with N=3, p=2
    result_alpha025 = frct([1, 2, 3], 0.25, 2)
    @test isapprox(real(result_alpha025), [1.149048519428139, 2.069543648263006, 0.717830085889912], atol=1e-5)
    @test isapprox(imag(result_alpha025), [0.5580582617584079, -0.5088834764831853, -1.0713834764831842], atol=1e-5)
    
    # Test case 4: Different p value (p=3) with N=4, α=0.5
    result_p3 = frct([1, 2, 3, 4], 0.5, 3)
    @test isapprox(real(result_p3), [1.33178424813162, 2.8745694909700625, -0.7358987166189703, -0.7736664647984949], atol=1e-5)
    @test isapprox(imag(result_p3), [1.6638939414220273, -1.5123136107255237, -2.2287629369967386, -0.3174229863814598], atol=1e-5)
    
    # Test case 5: Identity case (α=0.0) - should return close to input in real part
    result_identity = frct([1, 2, 3], 0.0, 2)
    @test isapprox(real(result_identity), [1.0, 2.0, 1.5], atol=1e-5)
    @test isapprox(imag(result_identity), [0.0, 0.0, 0.0], atol=1e-5)
    
    # Test case 6: Fractional order α=1.0 with N=3, p=2
    result_alpha1 = frct([1, 2, 3], 1.0, 2)
    @test isapprox(real(result_alpha1), [2.9748737341529163, -0.7928932188134534, 0.10355339059326994], atol=1e-5)
    @test isapprox(imag(result_alpha1), [0.0, 0.0, 0.0], atol=1e-5)
    
    # Test case 7: Float32 precision - verify type generalization
    result_f32 = frct(Float32[1, 2, 3], 0.5f0, 2)
    @test eltype(result_f32) == ComplexF32
    @test isapprox(real(result_f32), [1.7071067f0, 1.5606598f0, -0.3535529f0], atol=1e-5)
    @test isapprox(imag(result_f32), [0.98743695f0, -1.3964467f0, -0.6982239f0], atol=1e-5)
    
    # Test case 8: Minimal signal length (N=2)
    result_min = frct([1.0, 2.0], 0.5, 2)
    @test isapprox(real(result_min), [0.0, 1.0], atol=1e-5)
    @test isapprox(imag(result_min), [-1.0, 0.0], atol=1e-5)
end