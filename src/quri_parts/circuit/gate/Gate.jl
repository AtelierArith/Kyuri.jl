module Gate

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const gate = PyNULL()

# submodules



@static if isfile("gate_custom.jl")
    include("gate_custom.jl")
end

# attributes
include("gate_functions.jl")
include("gate_classes.jl")

for class in gate_classes
    @eval begin
        @pyclass gate $(class)
        export $(class)
    end
end

for func in gate_functions
    @eval begin
        @pyfunc gate $(func)
        export $(func)
    end
end

function __init__()
    copy!(gate, pyimport("quri_parts.circuit.gate"))
end

end