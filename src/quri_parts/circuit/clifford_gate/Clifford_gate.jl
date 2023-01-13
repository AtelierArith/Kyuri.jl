module Clifford_gate

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const clifford_gate = PyNULL()

# submodules



# customize _ignore_xxx in clifford_gate_custom.jl as necessary
_ignore_classes = Symbol[]
_ignore_functions = Symbol[]

@static if isfile(joinpath(@__DIR__, "clifford_gate_custom.jl"))
    include("clifford_gate_custom.jl")
end

# attributes
include("clifford_gate_functions.jl")
include("clifford_gate_classes.jl")

for class in clifford_gate_classes
    class in _ignore_classes && continue
    @eval begin
        @pyclass clifford_gate $(class)
        export $(class)
    end
end

for func in clifford_gate_functions
    func in _ignore_functions && continue
    @eval begin
        @pyfunc clifford_gate $(func)
        export $(func)
    end
end

function __init__()
    copy!(clifford_gate, pyimport("quri_parts.circuit.clifford_gate"))
end

end