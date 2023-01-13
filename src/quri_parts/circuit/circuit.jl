module circuit

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const pymod_circuit = PyNULL()

# submodules


include("circuit/circuit.jl")

include("circuit_linear_mapped/circuit_linear_mapped.jl")

include("circuit_parametric/circuit_parametric.jl")

include("clifford_gate/clifford_gate.jl")

include("gate/gate.jl")

include("gate_names/gate_names.jl")

include("gates/gates.jl")

include("parameter_mapping/parameter_mapping.jl")


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
        @pyclass pymod_circuit $(class)
        export $(class)
    end
end

for func in circuit_functions
    func in _ignore_functions && continue
    @eval begin
        @pyfunc pymod_circuit $(func)
        export $(func)
    end
end

if !isdefined(@__MODULE__, :__init__)
    @eval function __init__()
        copy!(pymod_circuit, pyimport("quri_parts.circuit"))
    end
end

end