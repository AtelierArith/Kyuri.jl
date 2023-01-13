module Utils

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const utils = PyNULL()

# submodules


include("bit/Bit.jl")

include("statistics/Statistics.jl")


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
        @pyclass utils $(class)
        export $(class)
    end
end

for func in utils_functions
    func in _ignore_functions && continue
    @eval begin
        @pyfunc utils $(func)
        export $(func)
    end
end

function __init__()
    copy!(utils, pyimport("quri_parts.core.utils"))
end

end