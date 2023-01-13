module state_parametric

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const pymod_state_parametric = PyNULL()

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
        @pyclass pymod_state_parametric $(class)
        export $(class)
    end
end

for func in state_parametric_functions
    func in _ignore_functions && continue
    @eval begin
        @pyfunc pymod_state_parametric $(func)
        export $(func)
    end
end

if !isdefined(@__MODULE__, :__init__)
    @eval function __init__()
        copy!(pymod_state_parametric, pyimport("quri_parts.core.state.state_parametric"))
    end
end

end