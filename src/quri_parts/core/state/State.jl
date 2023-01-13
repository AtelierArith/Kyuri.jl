module State

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const state = PyNULL()

# submodules


include("comp_basis/Comp_basis.jl")

include("state/_State.jl")

include("state_parametric/State_parametric.jl")

include("state_vector/State_vector.jl")

include("state_vector_parametric/State_vector_parametric.jl")


# customize _ignore_xxx in state_custom.jl as necessary
_ignore_classes = Symbol[]
_ignore_functions = Symbol[]

@static if isfile(joinpath(@__DIR__, "state_custom.jl"))
    include("state_custom.jl")
end

# attributes
include("state_functions.jl")
include("state_classes.jl")

for class in state_classes
    class in _ignore_classes && continue
    @eval begin
        @pyclass state $(class)
        export $(class)
    end
end

for func in state_functions
    func in _ignore_functions && continue
    @eval begin
        @pyfunc state $(func)
        export $(func)
    end
end

function __init__()
    copy!(state, pyimport("quri_parts.core.state"))
end

end