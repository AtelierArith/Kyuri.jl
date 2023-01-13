module _State

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const state = PyNULL()

# submodules



@static if isfile("state_custom.jl")
    include("state_custom.jl")
end

# attributes
include("state_functions.jl")
include("state_classes.jl")

for class in state_classes
    @eval begin
        @pyclass state $(class)
        export $(class)
    end
end

for func in state_functions
    @eval begin
        @pyfunc state $(func)
        export $(func)
    end
end

function __init__()
    copy!(state, pyimport("quri_parts.core.state.state"))
end

end