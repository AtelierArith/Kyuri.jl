module Bitwise_commuting_pauli

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const bitwise_commuting_pauli = PyNULL()

# submodules



@static if isfile("bitwise_commuting_pauli_custom.jl")
    include("bitwise_commuting_pauli_custom.jl")
end

# attributes
include("bitwise_commuting_pauli_functions.jl")
include("bitwise_commuting_pauli_classes.jl")

for class in bitwise_commuting_pauli_classes
    @eval begin
        @pyclass bitwise_commuting_pauli $(class)
        export $(class)
    end
end

for func in bitwise_commuting_pauli_functions
    @eval begin
        @pyfunc bitwise_commuting_pauli $(func)
        export $(func)
    end
end

function __init__()
    copy!(bitwise_commuting_pauli, pyimport("quri_parts.core.measurement.bitwise_commuting_pauli"))
end

end