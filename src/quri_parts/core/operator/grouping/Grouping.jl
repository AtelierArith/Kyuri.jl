module grouping

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const pymod_grouping = PyNULL()

# submodules


include("pauli_grouping/pauli_grouping.jl")


# customize _ignore_xxx in grouping_custom.jl as necessary
_ignore_classes = Symbol[]
_ignore_functions = Symbol[]

@static if isfile(joinpath(@__DIR__, "grouping_custom.jl"))
    include("grouping_custom.jl")
end

# attributes
include("grouping_functions.jl")
include("grouping_classes.jl")

for class in grouping_classes
    class in _ignore_classes && continue
    @eval begin
        @pyclass pymod_grouping $(class)
        export $(class)
    end
end

for func in grouping_functions
    func in _ignore_functions && continue
    @eval begin
        @pyfunc pymod_grouping $(func)
        export $(func)
    end
end

if !isdefined(@__MODULE__, :__init__)
    @eval function __init__()
        copy!(pymod_grouping, pyimport("quri_parts.core.operator.grouping"))
    end
end

end