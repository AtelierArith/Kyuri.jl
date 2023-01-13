module Representation

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const representation = PyNULL()

# submodules


include("bsf/Bsf.jl")


@static if isfile("representation_custom.jl")
    include("representation_custom.jl")
end

# attributes
include("representation_functions.jl")
include("representation_classes.jl")

for class in representation_classes
    @eval begin
        @pyclass representation $(class)
        export $(class)
    end
end

for func in representation_functions
    @eval begin
        @pyfunc representation $(func)
        export $(func)
    end
end

function __init__()
    copy!(representation, pyimport("quri_parts.core.operator.representation"))
end

end