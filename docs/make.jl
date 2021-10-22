using FractionalTransforms
using Documenter

DocMeta.setdocmeta!(FractionalTransforms, :DocTestSetup, :(using FractionalTransforms); recursive=true)

makedocs(;
    modules=[FractionalTransforms],
    authors="Qingyu Qu",
    repo="https://github.com/ErikQQY/FractionalTransforms.jl/blob/{commit}{path}#{line}",
    sitename="FractionalTransforms.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://ErikQQY.github.io/FractionalTransforms.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/ErikQQY/FractionalTransforms.jl",
)
