module Core

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const core = PyNULL()

# submodules


include("circuit/Circuit.jl")

include("estimator/Estimator.jl")

include("measurement/Measurement.jl")

include("operator/Operator.jl")

include("sampling/Sampling.jl")

include("state/State.jl")

include("utils/Utils.jl")


@static if isfile("core_custom.jl")
    include("core_custom.jl")
end

# attributes
include("core_functions.jl")
include("core_classes.jl")

for class in core_classes
    @eval begin
        @pyclass core $(class)
        export $(class)
    end
end

for func in core_functions
    @eval begin
        @pyfunc core $(func)
        export $(func)
    end
end

function __init__()
    copy!(core, pyimport("quri_parts.core"))
end

end