module State_vector

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const state_vector = PyNULL()

# submodules



@static if isfile("state_vector_custom.jl")
    include("state_vector_custom.jl")
end

# attributes
include("state_vector_functions.jl")
include("state_vector_classes.jl")

for class in state_vector_classes
    @eval begin
        @pyclass state_vector $(class)
        export $(class)
    end
end

for func in state_vector_functions
    @eval begin
        @pyfunc state_vector $(func)
        export $(func)
    end
end

function __init__()
    copy!(state_vector, pyimport("quri_parts.core.state.state_vector"))
end

end