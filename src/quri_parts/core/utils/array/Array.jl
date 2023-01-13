module Array

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const array = PyNULL()

# submodules



@static if isfile("array_custom.jl")
    include("array_custom.jl")
end

# attributes
include("array_functions.jl")
include("array_classes.jl")

for class in array_classes
    @eval begin
        @pyclass array $(class)
        export $(class)
    end
end

for func in array_functions
    @eval begin
        @pyfunc array $(func)
        export $(func)
    end
end

function __init__()
    copy!(array, pyimport("quri_parts.core.utils.array"))
end

end