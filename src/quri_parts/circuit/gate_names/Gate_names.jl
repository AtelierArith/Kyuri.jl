module Gate_names

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const gate_names = PyNULL()

# submodules



@static if isfile("gate_names_custom.jl")
    include("gate_names_custom.jl")
end

# attributes
include("gate_names_functions.jl")
include("gate_names_classes.jl")

for class in gate_names_classes
    @eval begin
        @pyclass gate_names $(class)
        export $(class)
    end
end

for func in gate_names_functions
    @eval begin
        @pyfunc gate_names $(func)
        export $(func)
    end
end

function __init__()
    copy!(gate_names, pyimport("quri_parts.circuit.gate_names"))
end

end