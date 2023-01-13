module Gates

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const gates = PyNULL()

# submodules



@static if isfile("gates_custom.jl")
    include("gates_custom.jl")
end

# attributes
include("gates_functions.jl")
include("gates_classes.jl")

for class in gates_classes
    @eval begin
        @pyclass gates $(class)
        export $(class)
    end
end

for func in gates_functions
    @eval begin
        @pyfunc gates $(func)
        export $(func)
    end
end

function __init__()
    copy!(gates, pyimport("quri_parts.circuit.gates"))
end

end