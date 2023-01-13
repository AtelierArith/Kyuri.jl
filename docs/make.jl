using Markdown
using Documenter
import Documenter.Utilities.MDFlatten: mdflatten

using Kyuri
using Kyuri: LazyHelp

function Documenter.Writers.HTMLWriter.mdconvert(
    h::LazyHelp,
    parent;
    kwargs...,
)
    s = Kyuri.gendocstr(h)
    # quote docstring `s` to prevent changing display result
    m = Markdown.parse(
        """
        ```
        $s
        ```
        """,
    )
    Documenter.Writers.HTMLWriter.mdconvert(m, parent; kwargs...)
end

mdflatten(io::IOBuffer, h::LazyHelp, md::Markdown.MD) = nothing

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
