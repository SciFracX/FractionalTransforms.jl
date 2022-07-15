using FractionalTransforms
using Test

@testset "Test FRFT" begin
    @test isapprox(real(frft([1, 2, 3], 0.5)), [0.2184858049179108
    3.1682634817489754
    1.3827766087134183], atol=1e-5)
    @test isapprox(imag(frft([1, 2, 3], 0.5)), [-0.48050718989735614
    0.38301661364477946
   -1.1551815500981393], atol=1e-5)

    @test isapprox(real(frft([1, 2, 3, 4, 5], 0.3)), [0.6317225402281863
    1.921850573794287
    2.9473079123194106
    4.7693889446948665
    1.1215925410506982]; atol=1e-6)
    @test isapprox(imag(frft([1, 2, 3, 4, 5], 0.3)), [-0.6482786115154652
    -0.3257271769214941
     0.9987425650468786
    -0.951165035143666
    -3.2965111836383025]; atol=1e-6)

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