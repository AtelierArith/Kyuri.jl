module Bsf

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const bsf = PyNULL()

# submodules



@static if isfile("bsf_custom.jl")
    include("bsf_custom.jl")
end

# attributes
include("bsf_functions.jl")
include("bsf_classes.jl")

for class in bsf_classes
    @eval begin
        @pyclass bsf $(class)
        export $(class)
    end
end

for func in bsf_functions
    @eval begin
        @pyfunc bsf $(func)
        export $(func)
    end
end

function __init__()
    copy!(bsf, pyimport("quri_parts.core.operator.representation.bsf"))
end

end