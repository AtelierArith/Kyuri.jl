module sampling

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const pymod_sampling = PyNULL()

# submodules


include("estimator/estimator.jl")

include("pauli/pauli.jl")


# customize _ignore_xxx in sampling_custom.jl as necessary
_ignore_classes = Symbol[]
_ignore_functions = Symbol[]

@static if isfile(joinpath(@__DIR__, "sampling_custom.jl"))
    include("sampling_custom.jl")
end

# attributes
include("sampling_functions.jl")
include("sampling_classes.jl")

for class in sampling_classes
    class in _ignore_classes && continue
    @eval begin
        @pyclass pymod_sampling $(class)
        export $(class)
    end
end

for func in sampling_functions
    func in _ignore_functions && continue
    @eval begin
        @pyfunc pymod_sampling $(func)
        export $(func)
    end
end

function __init__()
    copy!(pymod_sampling, pyimport("quri_parts.core.estimator.sampling"))
end

end