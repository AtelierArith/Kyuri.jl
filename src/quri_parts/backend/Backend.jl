module Backend

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const backend = PyNULL()

# submodules



# customize _ignore_xxx in backend_custom.jl as necessary
_ignore_classes = Symbol[]
_ignore_functions = Symbol[]

@static if isfile(joinpath(@__DIR__, "backend_custom.jl"))
    include("backend_custom.jl")
end

# attributes
include("backend_functions.jl")
include("backend_classes.jl")

for class in backend_classes
    class in _ignore_classes && continue
    @eval begin
        @pyclass backend $(class)
        export $(class)
    end
end

for func in backend_functions
    func in _ignore_functions && continue
    @eval begin
        @pyfunc backend $(func)
        export $(func)
    end
end

function __init__()
    copy!(backend, pyimport("quri_parts.backend"))
end

end