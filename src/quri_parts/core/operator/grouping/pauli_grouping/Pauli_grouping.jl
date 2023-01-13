module Pauli_grouping

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const pauli_grouping = PyNULL()

# submodules



@static if isfile("pauli_grouping_custom.jl")
    include("pauli_grouping_custom.jl")
end

# attributes
include("pauli_grouping_functions.jl")
include("pauli_grouping_classes.jl")

for class in pauli_grouping_classes
    @eval begin
        @pyclass pauli_grouping $(class)
        export $(class)
    end
end

for func in pauli_grouping_functions
    @eval begin
        @pyfunc pauli_grouping $(func)
        export $(func)
    end
end

function __init__()
    copy!(pauli_grouping, pyimport("quri_parts.core.operator.grouping.pauli_grouping"))
end

end