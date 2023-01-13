module Estimator

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const estimator = PyNULL()

# submodules



@static if isfile("estimator_custom.jl")
    include("estimator_custom.jl")
end

# attributes
include("estimator_functions.jl")
include("estimator_classes.jl")

for class in estimator_classes
    @eval begin
        @pyclass estimator $(class)
        export $(class)
    end
end

for func in estimator_functions
    @eval begin
        @pyfunc estimator $(func)
        export $(func)
    end
end

function __init__()
    copy!(estimator, pyimport("quri_parts.core.estimator.sampling.estimator"))
end

end