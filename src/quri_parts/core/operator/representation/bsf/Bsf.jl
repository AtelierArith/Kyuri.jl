module bsf

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const pymod_bsf = PyNULL()

# submodules



# customize _ignore_xxx in bsf_custom.jl as necessary
_ignore_classes = Symbol[]
_ignore_functions = Symbol[]

@static if isfile(joinpath(@__DIR__, "bsf_custom.jl"))
    include("bsf_custom.jl")
end

# attributes
include("bsf_functions.jl")
include("bsf_classes.jl")

for class in bsf_classes
    class in _ignore_classes && continue
    @eval begin
        @pyclass pymod_bsf $(class)
        export $(class)
    end
end

for func in bsf_functions
    func in _ignore_functions && continue
    @eval begin
        @pyfunc pymod_bsf $(func)
        export $(func)
    end
end

if !isdefined(@__MODULE__, :__init__)
    @eval function __init__()
        copy!(pymod_bsf, pyimport("quri_parts.core.operator.representation.bsf"))
    end
end

end