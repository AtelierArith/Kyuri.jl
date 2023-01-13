module _state

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const pymod_state = PyNULL()

# submodules



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
        @pyclass pymod_state $(class)
        export $(class)
    end
end

for func in state_functions
    func in _ignore_functions && continue
    @eval begin
        @pyfunc pymod_state $(func)
        export $(func)
    end
end

function __init__()
    copy!(pymod_state, pyimport("quri_parts.core.state.state"))
end

end