module Bit

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const bit = PyNULL()

# submodules



@static if isfile("bit_custom.jl")
    include("bit_custom.jl")
end

# attributes
include("bit_functions.jl")
include("bit_classes.jl")

for class in bit_classes
    @eval begin
        @pyclass bit $(class)
        export $(class)
    end
end

for func in bit_functions
    @eval begin
        @pyfunc bit $(func)
        export $(func)
    end
end

function __init__()
    copy!(bit, pyimport("quri_parts.core.utils.bit"))
end

end