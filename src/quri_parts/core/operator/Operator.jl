module Operator

using PyCall
using Reexport

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const operator = PyNULL()

# custom file
include("operator_custom.jl")


@static if isfile("operator_custom.jl")
    include("operator_custom.jl")
end

# attributes
include("operator_functions.jl")
include("operator_classes.jl")

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
    copy!(operator, pyimport("quri_parts.core.operator.operator"))
end

end