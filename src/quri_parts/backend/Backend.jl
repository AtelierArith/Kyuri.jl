module Backend

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const backend = PyNULL()

# submodules



@static if isfile("backend_custom.jl")
    include("backend_custom.jl")
end

# attributes
include("backend_functions.jl")
include("backend_classes.jl")

for class in backend_classes
    @eval begin
        @pyclass backend $(class)
        export $(class)
    end
end

for func in backend_functions
    @eval begin
        @pyfunc backend $(func)
        export $(func)
    end
end

function __init__()
    copy!(backend, pyimport("quri_parts.backend"))
end

end