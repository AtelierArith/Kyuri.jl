module circuit_linear_mapped

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const pymod_circuit_linear_mapped = PyNULL()

# submodules



# customize _ignore_xxx in circuit_linear_mapped_custom.jl as necessary
_ignore_classes = Symbol[]
_ignore_functions = Symbol[]

@static if isfile(joinpath(@__DIR__, "circuit_linear_mapped_custom.jl"))
    include("circuit_linear_mapped_custom.jl")
end

# attributes
include("circuit_linear_mapped_functions.jl")
include("circuit_linear_mapped_classes.jl")

for class in circuit_linear_mapped_classes
    class in _ignore_classes && continue
    @eval begin
        @pyclass pymod_circuit_linear_mapped $(class)
        export $(class)
    end
end

for func in circuit_linear_mapped_functions
    func in _ignore_functions && continue
    @eval begin
        @pyfunc pymod_circuit_linear_mapped $(func)
        export $(func)
    end
end

if !isdefined(@__MODULE__, :__init__)
    @eval function __init__()
        copy!(pymod_circuit_linear_mapped, pyimport("quri_parts.circuit.circuit_linear_mapped"))
    end
end

end