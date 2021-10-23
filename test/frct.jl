using FractionalTransforms
using Test

@testset "Test FRCT" begin
    @test isapprox(real(frct([1,2,3], 0.5, 2)), [1.707106781186547, 1.5606601717798205, -0.3535533905932727], atol=1e-5)
    @test isapprox(imag(frct([1,2,3], 0.5, 2)), [0.9874368670764581, -1.3964466094067267, -0.6982233047033652], atol=1e-5)
end