module Clifford_gate

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const clifford_gate = PyNULL()

# submodules



@static if isfile("clifford_gate_custom.jl")
    include("clifford_gate_custom.jl")
end

# attributes
include("clifford_gate_functions.jl")
include("clifford_gate_classes.jl")

for class in clifford_gate_classes
    @eval begin
        @pyclass clifford_gate $(class)
        export $(class)
    end
end

for func in clifford_gate_functions
    @eval begin
        @pyfunc clifford_gate $(func)
        export $(func)
    end
end

function __init__()
    copy!(clifford_gate, pyimport("quri_parts.circuit.clifford_gate"))
end

end