module core

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const pymod_core = PyNULL()

# submodules


include("circuit/circuit.jl")

include("estimator/estimator.jl")

include("measurement/measurement.jl")

include("operator/operator.jl")

include("sampling/sampling.jl")

include("state/state.jl")

include("utils/utils.jl")


# customize _ignore_xxx in core_custom.jl as necessary
_ignore_classes = Symbol[]
_ignore_functions = Symbol[]

@static if isfile(joinpath(@__DIR__, "core_custom.jl"))
    include("core_custom.jl")
end

# attributes
include("core_functions.jl")
include("core_classes.jl")

for class in core_classes
    class in _ignore_classes && continue
    @eval begin
        @pyclass pymod_core $(class)
        export $(class)
    end
end

for func in core_functions
    func in _ignore_functions && continue
    @eval begin
        @pyfunc pymod_core $(func)
        export $(func)
    end
end

function __init__()
    copy!(pymod_core, pyimport("quri_parts.core"))
end

end