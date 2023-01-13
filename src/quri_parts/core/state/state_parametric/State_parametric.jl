module State_parametric

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const state_parametric = PyNULL()

# submodules



@static if isfile("state_parametric_custom.jl")
    include("state_parametric_custom.jl")
end

# attributes
include("state_parametric_functions.jl")
include("state_parametric_classes.jl")

for class in state_parametric_classes
    @eval begin
        @pyclass state_parametric $(class)
        export $(class)
    end
end

for func in state_parametric_functions
    @eval begin
        @pyfunc state_parametric $(func)
        export $(func)
    end
end

function __init__()
    copy!(state_parametric, pyimport("quri_parts.core.state.state_parametric"))
end

end