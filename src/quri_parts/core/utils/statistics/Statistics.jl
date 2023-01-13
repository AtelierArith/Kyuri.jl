module statistics

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const pymod_statistics = PyNULL()

# submodules



# customize _ignore_xxx in statistics_custom.jl as necessary
_ignore_classes = Symbol[]
_ignore_functions = Symbol[]

@static if isfile(joinpath(@__DIR__, "statistics_custom.jl"))
    include("statistics_custom.jl")
end

# attributes
include("statistics_functions.jl")
include("statistics_classes.jl")

for class in statistics_classes
    class in _ignore_classes && continue
    @eval begin
        @pyclass pymod_statistics $(class)
        export $(class)
    end
end

for func in statistics_functions
    func in _ignore_functions && continue
    @eval begin
        @pyfunc pymod_statistics $(func)
        export $(func)
    end
end

function __init__()
    copy!(pymod_statistics, pyimport("quri_parts.core.utils.statistics"))
end

end