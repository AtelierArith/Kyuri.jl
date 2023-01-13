module Pauli

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const pauli = PyNULL()

# submodules



# customize _ignore_xxx in pauli_custom.jl as necessary
_ignore_classes = Symbol[]
_ignore_functions = Symbol[]

@static if isfile(joinpath(@__DIR__, "pauli_custom.jl"))
    include("pauli_custom.jl")
end

# attributes
include("pauli_functions.jl")
include("pauli_classes.jl")

for class in pauli_classes
    class in _ignore_classes && continue
    @eval begin
        @pyclass pauli $(class)
        export $(class)
    end
end

for func in pauli_functions
    func in _ignore_functions && continue
    @eval begin
        @pyfunc pauli $(func)
        export $(func)
    end
end

function __init__()
    copy!(pauli, pyimport("quri_parts.core.estimator.sampling.pauli"))
end

end