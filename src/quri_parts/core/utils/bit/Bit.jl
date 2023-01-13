module bit

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const pymod_bit = PyNULL()

# submodules



# customize _ignore_xxx in bit_custom.jl as necessary
_ignore_classes = Symbol[]
_ignore_functions = Symbol[]

@static if isfile(joinpath(@__DIR__, "bit_custom.jl"))
    include("bit_custom.jl")
end

# attributes
include("bit_functions.jl")
include("bit_classes.jl")

for class in bit_classes
    class in _ignore_classes && continue
    @eval begin
        @pyclass pymod_bit $(class)
        export $(class)
    end
end

for func in bit_functions
    func in _ignore_functions && continue
    @eval begin
        @pyfunc pymod_bit $(func)
        export $(func)
    end
end

function __init__()
    copy!(pymod_bit, pyimport("quri_parts.core.utils.bit"))
end

end