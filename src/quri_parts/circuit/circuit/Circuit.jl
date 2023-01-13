module Circuit

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const circuit = PyNULL()

# submodules



@static if isfile("circuit_custom.jl")
    include("circuit_custom.jl")
end

# attributes
include("circuit_functions.jl")
include("circuit_classes.jl")

for class in circuit_classes
    @eval begin
        @pyclass circuit $(class)
        export $(class)
    end
end

for func in circuit_functions
    @eval begin
        @pyfunc circuit $(func)
        export $(func)
    end
end

function __init__()
    copy!(circuit, pyimport("quri_parts.circuit.circuit"))
end

end