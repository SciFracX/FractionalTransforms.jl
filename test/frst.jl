using FractionalTransforms
using Test

@testset "Test FRST" begin
    @test isapprox(real(frst([1,2,3], 0.5, 2)), [1.707106781186548, 2, -1.1213203435596437], atol=1e-5)
    @test isapprox(imag(frst([1,2,3], 0.5, 2)), [1.207106781186547, -1.7071067811865481, -1.2071067811865468], atol=1e-5)
end