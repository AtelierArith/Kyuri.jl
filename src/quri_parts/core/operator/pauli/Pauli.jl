module pauli

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const pymod_pauli = PyNULL()

# submodules



# customize _ignore_xxx in pauli_custom.jl as necessary
_ignore_classes = Symbol[]
_ignore_functions = Symbol[]

@static if isfile(joinpath(@__DIR__, "pauli_custom.jl"))
    include("pauli_custom.jl")
end

# attributes
include("pauli_functions.jl")
include("pauli_classes.jl")

for class in pauli_classes
    class in _ignore_classes && continue
    @eval begin
        @pyclass pymod_pauli $(class)
        export $(class)
    end
end

for func in pauli_functions
    func in _ignore_functions && continue
    @eval begin
        @pyfunc pymod_pauli $(func)
        export $(func)
    end
end

if !isdefined(@__MODULE__, :__init__)
    @eval function __init__()
        copy!(pymod_pauli, pyimport("quri_parts.core.operator.pauli"))
    end
end

end