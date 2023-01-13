module State_parametric

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const state_parametric = PyNULL()

# submodules



# customize _ignore_xxx in state_parametric_custom.jl as necessary
_ignore_classes = Symbol[]
_ignore_functions = Symbol[]

@static if isfile(joinpath(@__DIR__, "state_parametric_custom.jl"))
    include("state_parametric_custom.jl")
end

# attributes
include("state_parametric_functions.jl")
include("state_parametric_classes.jl")

for class in state_parametric_classes
    class in _ignore_classes && continue
    @eval begin
        @pyclass state_parametric $(class)
        export $(class)
    end
end

for func in state_parametric_functions
    func in _ignore_functions && continue
    @eval begin
        @pyfunc state_parametric $(func)
        export $(func)
    end
end

function __init__()
    copy!(state_parametric, pyimport("quri_parts.core.state.state_parametric"))
end

end