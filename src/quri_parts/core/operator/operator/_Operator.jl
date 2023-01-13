module _operator

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const pymod_operator = PyNULL()

# submodules



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
        @pyclass pymod_operator $(class)
        export $(class)
    end
end

for func in operator_functions
    func in _ignore_functions && continue
    @eval begin
        @pyfunc pymod_operator $(func)
        export $(func)
    end
end

if !isdefined(@__MODULE__, :__init__)
    @eval function __init__()
        copy!(pymod_operator, pyimport("quri_parts.core.operator.operator"))
    end
end

end