module Circuit_parametric

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const circuit_parametric = PyNULL()

# submodules



@static if isfile("circuit_parametric_custom.jl")
    include("circuit_parametric_custom.jl")
end

# attributes
include("circuit_parametric_functions.jl")
include("circuit_parametric_classes.jl")

for class in circuit_parametric_classes
    @eval begin
        @pyclass circuit_parametric $(class)
        export $(class)
    end
end

for func in circuit_parametric_functions
    @eval begin
        @pyfunc circuit_parametric $(func)
        export $(func)
    end
end

function __init__()
    copy!(circuit_parametric, pyimport("quri_parts.circuit.circuit_parametric"))
end

end