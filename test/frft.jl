using FractionalTransforms
using Test

@testset "Test FRFT" begin
    @test isapprox(real(frft([1,2,3], 0.5)), [0.100464613588213, 3.07460010423315, 1.31566432887283], atol=1e-5)
    @test isapprox(imag(frft([1,2,3], 0.5)), [-0.259409480977277, 0.199349381540632, -0.93645356561191], atol=1e-5)
end