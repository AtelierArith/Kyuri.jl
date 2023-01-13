module representation

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const pymod_representation = PyNULL()

# submodules


include("bsf/bsf.jl")


# customize _ignore_xxx in representation_custom.jl as necessary
_ignore_classes = Symbol[]
_ignore_functions = Symbol[]

@static if isfile(joinpath(@__DIR__, "representation_custom.jl"))
    include("representation_custom.jl")
end

# attributes
include("representation_functions.jl")
include("representation_classes.jl")

for class in representation_classes
    class in _ignore_classes && continue
    @eval begin
        @pyclass pymod_representation $(class)
        export $(class)
    end
end

for func in representation_functions
    func in _ignore_functions && continue
    @eval begin
        @pyfunc pymod_representation $(func)
        export $(func)
    end
end

function __init__()
    copy!(pymod_representation, pyimport("quri_parts.core.operator.representation"))
end

end