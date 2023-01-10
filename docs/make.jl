using Kyuri
using Documenter

DocMeta.setdocmeta!(Kyuri, :DocTestSetup, :(using Kyuri); recursive=true)

makedocs(;
    modules=[Kyuri],
    authors="Satoshi Terasaki <terasakisatoshi.math@gmail.com> and contributors",
    repo="https://github.com/AtelierArith/Kyuri.jl/blob/{commit}{path}#{line}",
    sitename="Kyuri.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://AtelierArith.github.io/Kyuri.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/AtelierArith/Kyuri.jl",
    devbranch="main",
)
