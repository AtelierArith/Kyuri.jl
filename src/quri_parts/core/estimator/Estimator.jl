module Estimator

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const estimator = PyNULL()

# submodules


include("sampling/Sampling.jl")


# customize _ignore_xxx in estimator_custom.jl as necessary
_ignore_classes = Symbol[]
_ignore_functions = Symbol[]

@static if isfile(joinpath(@__DIR__, "estimator_custom.jl"))
    include("estimator_custom.jl")
end

# attributes
include("estimator_functions.jl")
include("estimator_classes.jl")

for class in estimator_classes
    class in _ignore_classes && continue
    @eval begin
        @pyclass estimator $(class)
        export $(class)
    end
end

for func in estimator_functions
    func in _ignore_functions && continue
    @eval begin
        @pyfunc estimator $(func)
        export $(func)
    end
end

function __init__()
    copy!(estimator, pyimport("quri_parts.core.estimator"))
end

end