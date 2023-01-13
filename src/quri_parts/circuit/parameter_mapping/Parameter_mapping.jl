module parameter_mapping

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const pymod_parameter_mapping = PyNULL()

# submodules



# customize _ignore_xxx in parameter_mapping_custom.jl as necessary
_ignore_classes = Symbol[]
_ignore_functions = Symbol[]

@static if isfile(joinpath(@__DIR__, "parameter_mapping_custom.jl"))
    include("parameter_mapping_custom.jl")
end

# attributes
include("parameter_mapping_functions.jl")
include("parameter_mapping_classes.jl")

for class in parameter_mapping_classes
    class in _ignore_classes && continue
    @eval begin
        @pyclass pymod_parameter_mapping $(class)
        export $(class)
    end
end

for func in parameter_mapping_functions
    func in _ignore_functions && continue
    @eval begin
        @pyfunc pymod_parameter_mapping $(func)
        export $(func)
    end
end

if !isdefined(@__MODULE__, :__init__)
    @eval function __init__()
        copy!(pymod_parameter_mapping, pyimport("quri_parts.circuit.parameter_mapping"))
    end
end

end