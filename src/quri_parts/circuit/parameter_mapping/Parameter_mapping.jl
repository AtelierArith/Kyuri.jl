module Parameter_mapping

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const parameter_mapping = PyNULL()

# submodules



@static if isfile("parameter_mapping_custom.jl")
    include("parameter_mapping_custom.jl")
end

# attributes
include("parameter_mapping_functions.jl")
include("parameter_mapping_classes.jl")

for class in parameter_mapping_classes
    @eval begin
        @pyclass parameter_mapping $(class)
        export $(class)
    end
end

for func in parameter_mapping_functions
    @eval begin
        @pyfunc parameter_mapping $(func)
        export $(func)
    end
end

function __init__()
    copy!(parameter_mapping, pyimport("quri_parts.circuit.parameter_mapping"))
end

end