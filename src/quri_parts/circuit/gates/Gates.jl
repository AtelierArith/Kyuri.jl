module Gates

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const gates = PyNULL()

# submodules



# customize _ignore_xxx in gates_custom.jl as necessary
_ignore_classes = Symbol[]
_ignore_functions = Symbol[]

@static if isfile(joinpath(@__DIR__, "gates_custom.jl"))
    include("gates_custom.jl")
end

# attributes
include("gates_functions.jl")
include("gates_classes.jl")

for class in gates_classes
    class in _ignore_classes && continue
    @eval begin
        @pyclass gates $(class)
        export $(class)
    end
end

for func in gates_functions
    func in _ignore_functions && continue
    @eval begin
        @pyfunc gates $(func)
        export $(func)
    end
end

function __init__()
    copy!(gates, pyimport("quri_parts.circuit.gates"))
end

end