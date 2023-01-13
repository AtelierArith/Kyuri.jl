module Circuit_linear_mapped

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const circuit_linear_mapped = PyNULL()

# submodules



@static if isfile("circuit_linear_mapped_custom.jl")
    include("circuit_linear_mapped_custom.jl")
end

# attributes
include("circuit_linear_mapped_functions.jl")
include("circuit_linear_mapped_classes.jl")

for class in circuit_linear_mapped_classes
    @eval begin
        @pyclass circuit_linear_mapped $(class)
        export $(class)
    end
end

for func in circuit_linear_mapped_functions
    @eval begin
        @pyfunc circuit_linear_mapped $(func)
        export $(func)
    end
end

function __init__()
    copy!(circuit_linear_mapped, pyimport("quri_parts.circuit.circuit_linear_mapped"))
end

end