module Gate

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const gate = PyNULL()

# submodules



# customize _ignore_xxx in gate_custom.jl as necessary
_ignore_classes = Symbol[]
_ignore_functions = Symbol[]

@static if isfile(joinpath(@__DIR__, "gate_custom.jl"))
    include("gate_custom.jl")
end

# attributes
include("gate_functions.jl")
include("gate_classes.jl")

for class in gate_classes
    class in _ignore_classes && continue
    @eval begin
        @pyclass gate $(class)
        export $(class)
    end
end

for func in gate_functions
    func in _ignore_functions && continue
    @eval begin
        @pyfunc gate $(func)
        export $(func)
    end
end

function __init__()
    copy!(gate, pyimport("quri_parts.circuit.gate"))
end

end