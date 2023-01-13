module comp_basis

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const pymod_comp_basis = PyNULL()

# submodules



# customize _ignore_xxx in comp_basis_custom.jl as necessary
_ignore_classes = Symbol[]
_ignore_functions = Symbol[]

@static if isfile(joinpath(@__DIR__, "comp_basis_custom.jl"))
    include("comp_basis_custom.jl")
end

# attributes
include("comp_basis_functions.jl")
include("comp_basis_classes.jl")

for class in comp_basis_classes
    class in _ignore_classes && continue
    @eval begin
        @pyclass pymod_comp_basis $(class)
        export $(class)
    end
end

for func in comp_basis_functions
    func in _ignore_functions && continue
    @eval begin
        @pyfunc pymod_comp_basis $(func)
        export $(func)
    end
end

if !isdefined(@__MODULE__, :__init__)
    @eval function __init__()
        copy!(pymod_comp_basis, pyimport("quri_parts.core.state.comp_basis"))
    end
end

end