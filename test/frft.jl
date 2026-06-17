using FractionalTransforms
using Test

@testset "Test FRFT" begin
    # Test case 1: Basic test with N=3, α=0.5
    @test isapprox(real(frft([1, 2, 3], 0.5)), [0.2184858049179108, 3.1682634817489754, 1.3827766087134183], atol=1e-5)
    @test isapprox(imag(frft([1, 2, 3], 0.5)), [-0.48050718989735614, 0.38301661364477946, -1.1551815500981393], atol=1e-5)

    # Test case 2: Different signal length (N=4) with α=0.5
    result_len4 = frft([1, 2, 3, 4], 0.5)
    @test isapprox(real(result_len4), [0.4829024672483966, 1.2944347381750236, 3.773648006668036, 0.8522358480275665], atol=1e-5)
    @test isapprox(imag(result_len4), [-0.03478723224567437, 0.8544347533074108, -0.5119232452009218, -1.8949313314513843], atol=1e-5)

    # Test case 3: Longer test with N=5, α=0.3
    @test isapprox(real(frft([1, 2, 3, 4, 5], 0.3)), [0.6317225402281863, 1.921850573794287, 2.9473079123194106, 4.7693889446948665, 1.1215925410506982], atol=1e-6)
    @test isapprox(imag(frft([1, 2, 3, 4, 5], 0.3)), [-0.6482786115154652, -0.3257271769214941, 0.9987425650468786, -0.951165035143666, -3.2965111836383025], atol=1e-6)

    # Test case 4: Different α value (α=0.25) with N=3
    result_alpha025 = frft([1, 2, 3], 0.25)
    @test isapprox(real(result_alpha025), [0.7435338036079301, 2.3399290157326136, 2.3344342923436603], atol=1e-5)
    @test isapprox(imag(result_alpha025), [0.008343057554295458, 0.3192668849326344, -0.878080090313238], atol=1e-5)

    # Test case 5: Identity case (α=0.0) - should return input unchanged
    result_identity = frft([1, 2, 3], 0.0)
    @test isapprox(real(result_identity), [1.0, 2.0, 3.0], atol=1e-5)
    @test isapprox(imag(result_identity), [0.0, 0.0, 0.0], atol=1e-5)

    # Test case 6: Double pass (α=2.0) - should approximate reverse
    result_alpha2 = frft([1, 2, 3], 2.0)
    @test isapprox(real(result_alpha2), [3.0, 2.0, 1.0], atol=1e-5)
    @test isapprox(imag(result_alpha2), [0.0, 0.0, 0.0], atol=1e-5)

    # Test case 7: Triple pass (α=3.0)
    result_alpha3 = frft([1, 2, 3], 3.0)
    @test isapprox(real(result_alpha3), [0.0, 3.4641016151377544, 0.0], atol=1e-5)
    @test isapprox(imag(result_alpha3), [-1.0, 0.0, 1.0], atol=1e-5)

    # Test case 8: Float32 precision - verify type generalization
    result_f32 = frft(Float32[1, 2, 3], 0.5f0)
    @test eltype(result_f32) == ComplexF32
    @test isapprox(real(result_f32), [0.21848604f0, 3.1682634f0, 1.3827765f0], atol=1e-5)
    @test isapprox(imag(result_f32), [-0.4805073f0, 0.3830167f0, -1.1551816f0], atol=1e-5)

    # Test case 9: Minimal signal length (N=2)
    result_min = frft([1.0, 2.0], 0.5)
    @test isapprox(real(result_min), [1.1762539598479957, 1.46459027867653], atol=1e-5)
    @test isapprox(imag(result_min), [0.5623772579950352, -0.13372819344554487], atol=1e-5)

    # Test case 10: Larger signal (N=6) with α=0.7
    result_len6 = frft([1, 2, 3, 4, 5, 6], 0.7)
    @test isapprox(real(result_len6), [-1.077412703487896, 1.4185941640460318, 2.6586748671216456, 6.7104381543596658, -0.08694080972349616, -2.0022358676551724], atol=1e-5)
    @test isapprox(imag(result_len6), [-0.06642750708836148, -1.5372336626108636, 2.296283694760667, -0.4775571828999101, -3.6126024046860605, 0.6187292765564391], atol=1e-5)

    # Test case 11: Special case α=1 (FFT-like)
    @test isapprox(real(frft([1, 2, 3, 4, 5], 1)), [0.0, 0.0, 6.7082039324993685, 0.0, 0.0], atol=1e-6)
end