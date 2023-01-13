module Sampling

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const sampling = PyNULL()

# submodules



@static if isfile("sampling_custom.jl")
    include("sampling_custom.jl")
end

# attributes
include("sampling_functions.jl")
include("sampling_classes.jl")

for class in sampling_classes
    @eval begin
        @pyclass sampling $(class)
        export $(class)
    end
end

for func in sampling_functions
    @eval begin
        @pyfunc sampling $(func)
        export $(func)
    end
end

function __init__()
    copy!(sampling, pyimport("quri_parts.core.sampling"))
end

end