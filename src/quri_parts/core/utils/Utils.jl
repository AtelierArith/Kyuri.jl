module Utils

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const utils = PyNULL()

# submodules


include("bit/Bit.jl")

include("statistics/Statistics.jl")


@static if isfile("utils_custom.jl")
    include("utils_custom.jl")
end

# attributes
include("utils_functions.jl")
include("utils_classes.jl")

for class in utils_classes
    @eval begin
        @pyclass utils $(class)
        export $(class)
    end
end

for func in utils_functions
    @eval begin
        @pyfunc utils $(func)
        export $(func)
    end
end

function __init__()
    copy!(utils, pyimport("quri_parts.core.utils"))
end

end