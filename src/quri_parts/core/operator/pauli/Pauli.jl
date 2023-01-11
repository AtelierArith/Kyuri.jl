module Pauli

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const pauli = PyNULL()

# attributes
include("pauli_functions.jl")
include("pauli_classes.jl")
include("pauli_alias_classes.jl")
include("pauli_alias_functions.jl")

for class in pauli_classes
    @eval begin
        @pyclass pauli $(class)
        export $(class)
    end
end

for func in pauli_functions
    @eval begin
        @pyfunc pauli $(func)
        export $(func)
    end
end

function __init__()
    copy!(pauli, pyimport("quri_parts.core.operator.pauli"))
end

end
