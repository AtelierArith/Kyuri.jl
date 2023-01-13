module bitwise_commuting_pauli

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const pymod_bitwise_commuting_pauli = PyNULL()

# submodules



# customize _ignore_xxx in bitwise_commuting_pauli_custom.jl as necessary
_ignore_classes = Symbol[]
_ignore_functions = Symbol[]

@static if isfile(joinpath(@__DIR__, "bitwise_commuting_pauli_custom.jl"))
    include("bitwise_commuting_pauli_custom.jl")
end

# attributes
include("bitwise_commuting_pauli_functions.jl")
include("bitwise_commuting_pauli_classes.jl")

for class in bitwise_commuting_pauli_classes
    class in _ignore_classes && continue
    @eval begin
        @pyclass pymod_bitwise_commuting_pauli $(class)
        export $(class)
    end
end

for func in bitwise_commuting_pauli_functions
    func in _ignore_functions && continue
    @eval begin
        @pyfunc pymod_bitwise_commuting_pauli $(func)
        export $(func)
    end
end

function __init__()
    copy!(pymod_bitwise_commuting_pauli, pyimport("quri_parts.core.measurement.bitwise_commuting_pauli"))
end

end