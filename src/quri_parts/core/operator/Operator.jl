module Operator

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const operator = PyNULL()

# submodules
include("pauli/Pauli.jl")
# alias
@reexport using .Pauli: PauliLabel, SinglePauli
@reexport using .Pauli: pauli_label, pauli_name, pauli_product

# attributes
include("operator_functions.jl")
include("operator_classes.jl")
include("operator_alias_classes.jl")
include("operator_alias_functions.jl")

for class in operator_classes
    @eval begin
        @pyclass operator $(class)
        export $(class)
    end
end

for func in operator_functions
    @eval begin
        @pyfunc operator $(func)
        export $(func)
    end
end

function __init__()
    copy!(operator, pyimport("quri_parts.core.operator"))
end

end
