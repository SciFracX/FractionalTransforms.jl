using FractionalTransforms
using Documenter

DocMeta.setdocmeta!(FractionalTransforms, :DocTestSetup, :(using FractionalTransforms); recursive=true)

makedocs(;
    modules=[FractionalTransforms],
    authors="Qingyu Qu",
    repo="https://github.com/SciFracX/FractionalTransforms.jl/blob/{commit}{path}#{line}",
    sitename="FractionalTransforms.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://SciFracX.github.io/FractionalTransforms.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "Fractional Fourier Transform" => "frft.md"
        "Fractional Sine Transform" => "frst.md"
        "Fractional Cosine Transform" => "frct.md"
    ],
)

deploydocs(;
    repo="github.com/SciFracX/FractionalTransforms.jl",
)
