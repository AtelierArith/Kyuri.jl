module pauli_grouping

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const pymod_pauli_grouping = PyNULL()

# submodules



# customize _ignore_xxx in pauli_grouping_custom.jl as necessary
_ignore_classes = Symbol[]
_ignore_functions = Symbol[]

@static if isfile(joinpath(@__DIR__, "pauli_grouping_custom.jl"))
    include("pauli_grouping_custom.jl")
end

# attributes
include("pauli_grouping_functions.jl")
include("pauli_grouping_classes.jl")

for class in pauli_grouping_classes
    class in _ignore_classes && continue
    @eval begin
        @pyclass pymod_pauli_grouping $(class)
        export $(class)
    end
end

for func in pauli_grouping_functions
    func in _ignore_functions && continue
    @eval begin
        @pyfunc pymod_pauli_grouping $(func)
        export $(func)
    end
end

function __init__()
    copy!(pymod_pauli_grouping, pyimport("quri_parts.core.operator.grouping.pauli_grouping"))
end

end