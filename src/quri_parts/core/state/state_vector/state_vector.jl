module state_vector

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const pymod_state_vector = PyNULL()

# submodules



# customize _ignore_xxx in state_vector_custom.jl as necessary
_ignore_classes = Symbol[]
_ignore_functions = Symbol[]

@static if isfile(joinpath(@__DIR__, "state_vector_custom.jl"))
    include("state_vector_custom.jl")
end

# attributes
include("state_vector_functions.jl")
include("state_vector_classes.jl")

for class in state_vector_classes
    class in _ignore_classes && continue
    @eval begin
        @pyclass pymod_state_vector $(class)
        export $(class)
    end
end

for func in state_vector_functions
    func in _ignore_functions && continue
    @eval begin
        @pyfunc pymod_state_vector $(func)
        export $(func)
    end
end

if !isdefined(@__MODULE__, :__init__)
    @eval function __init__()
        copy!(pymod_state_vector, pyimport("quri_parts.core.state.state_vector"))
    end
end

end