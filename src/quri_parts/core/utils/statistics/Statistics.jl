module Statistics

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const statistics = PyNULL()

# submodules



@static if isfile("statistics_custom.jl")
    include("statistics_custom.jl")
end

# attributes
include("statistics_functions.jl")
include("statistics_classes.jl")

for class in statistics_classes
    @eval begin
        @pyclass statistics $(class)
        export $(class)
    end
end

for func in statistics_functions
    @eval begin
        @pyfunc statistics $(func)
        export $(func)
    end
end

function __init__()
    copy!(statistics, pyimport("quri_parts.core.utils.statistics"))
end

end