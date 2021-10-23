using FractionalTransforms
using Test

@testset "FractionalTransforms.jl" begin
    include("frft.jl")
    include("frst.jl")
    include("frct.jl")
end
