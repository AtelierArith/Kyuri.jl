module Operator

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const operator = PyNULL()

# submodules


include("grouping/Grouping.jl")

include("operator/_Operator.jl")

include("pauli/Pauli.jl")

include("representation/Representation.jl")

include("trotter_suzuki/Trotter_suzuki.jl")


# customize _ignore_xxx in operator_custom.jl as necessary
_ignore_classes = Symbol[]
_ignore_functions = Symbol[]

@static if isfile(joinpath(@__DIR__, "operator_custom.jl"))
    include("operator_custom.jl")
end

# attributes
include("operator_functions.jl")
include("operator_classes.jl")

for class in operator_classes
    class in _ignore_classes && continue
    @eval begin
        @pyclass operator $(class)
        export $(class)
    end
end

for func in operator_functions
    func in _ignore_functions && continue
    @eval begin
        @pyfunc operator $(func)
        export $(func)
    end
end

function __init__()
    copy!(operator, pyimport("quri_parts.core.operator"))
end

end