using FractionalTransforms
using Test

@testset "Test FRFT" begin
    @test isapprox(real(frft([1, 2, 3], 0.5)), [0.100464613588213, 3.07460010423315, 1.31566432887283], atol=1e-5)
    @test isapprox(imag(frft([1, 2, 3], 0.5)), [-0.259409480977277, 0.199349381540632, -0.93645356561191], atol=1e-5)

    @test isapprox(real(frft([1, 2, 3, 4, 5], 0.3)), [0.6219417958205868
    1.9285647455299149
    2.930147902457687
    4.781892308544647
    1.1657970121710457]; atol=1e-6)
    @test isapprox(imag(frft([1, 2, 3, 4, 5], 0.3)), [-0.620033106942918
    -0.3534712784226586
     1.0387260647856131
    -1.0039877236507386
    -3.2564984970643764]; atol=1e-6)

    @test isapprox(real(frft([1, 2, 3, 4, 5], 1)), [0.0
    0.0
    6.7082039324993685
    0.0
    0.0]; atol=1e-6)
end

@testset "Test FRFT auxillary functions" begin
    @testset "Test Sinc Interpolation" begin
        @test isapprox(real(sinc_interp([1, 2, 3], 3)), [1.0, 1.1577906803857638, 1.4472383504822042, 2.0, 2.6877283651812367, 3.1425747039042147, 3.0]; atol=1e-5)
        @test isapprox(imag(sinc_interp([1, 2, 3], 3)), [-4.0696311822644287e-17, -2.4671622769447922e-17, -2.522336560207922e-16, -3.331855648569948e-17, 0.0, 1.9624582529744518e-17, 3.331855648569948e-17]; atol=1e-5)
    end

    @testset "Test Frequency Shear" begin
        @test isapprox(real(freq_shear([1, 2, 3], 3)), [0.0707372016677029, 2.0, 0.2122116050031087]; atol=1e-5)
        @test isapprox(imag(freq_shear([1, 2, 3], 3)), [0.9974949866040544, 0.0, 2.9924849598121632]; atol=1e-5)
    end
end