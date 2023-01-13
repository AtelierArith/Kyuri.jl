module Pauli

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const pauli = PyNULL()

# submodules



@static if isfile("pauli_custom.jl")
    include("pauli_custom.jl")
end

# attributes
include("pauli_functions.jl")
include("pauli_classes.jl")

for class in pauli_classes
    @eval begin
        @pyclass pauli $(class)
        export $(class)
    end
end

for func in pauli_functions
    @eval begin
        @pyfunc pauli $(func)
        export $(func)
    end
end

function __init__()
    copy!(pauli, pyimport("quri_parts.core.estimator.sampling.pauli"))
end

end