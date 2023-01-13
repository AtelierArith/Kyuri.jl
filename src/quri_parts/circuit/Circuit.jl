module Circuit

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const circuit = PyNULL()

# submodules


include("circuit/Circuit.jl")

include("circuit_linear_mapped/Circuit_linear_mapped.jl")

include("circuit_parametric/Circuit_parametric.jl")

include("clifford_gate/Clifford_gate.jl")

include("gate/Gate.jl")

include("gate_names/Gate_names.jl")

include("gates/Gates.jl")

include("parameter_mapping/Parameter_mapping.jl")


# customize _ignore_xxx in circuit_custom.jl as necessary
_ignore_classes = Symbol[]
_ignore_functions = Symbol[]

@static if isfile(joinpath(@__DIR__, "circuit_custom.jl"))
    include("circuit_custom.jl")
end

# attributes
include("circuit_functions.jl")
include("circuit_classes.jl")

for class in circuit_classes
    class in _ignore_classes && continue
    @eval begin
        @pyclass circuit $(class)
        export $(class)
    end
end

for func in circuit_functions
    func in _ignore_functions && continue
    @eval begin
        @pyfunc circuit $(func)
        export $(func)
    end
end

function __init__()
    copy!(circuit, pyimport("quri_parts.circuit"))
end

end