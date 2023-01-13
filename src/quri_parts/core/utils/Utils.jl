module utils

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const pymod_utils = PyNULL()

# submodules


include("bit/bit.jl")

include("statistics/statistics.jl")


# customize _ignore_xxx in utils_custom.jl as necessary
_ignore_classes = Symbol[]
_ignore_functions = Symbol[]

@static if isfile(joinpath(@__DIR__, "utils_custom.jl"))
    include("utils_custom.jl")
end

# attributes
include("utils_functions.jl")
include("utils_classes.jl")

for class in utils_classes
    class in _ignore_classes && continue
    @eval begin
        @pyclass pymod_utils $(class)
        export $(class)
    end
end

for func in utils_functions
    func in _ignore_functions && continue
    @eval begin
        @pyfunc pymod_utils $(func)
        export $(func)
    end
end

if !isdefined(@__MODULE__, :__init__)
    @eval function __init__()
        copy!(pymod_utils, pyimport("quri_parts.core.utils"))
    end
end

end