module Circuit_parametric

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const circuit_parametric = PyNULL()

# submodules



# customize _ignore_xxx in circuit_parametric_custom.jl as necessary
_ignore_classes = Symbol[]
_ignore_functions = Symbol[]

@static if isfile(joinpath(@__DIR__, "circuit_parametric_custom.jl"))
    include("circuit_parametric_custom.jl")
end

# attributes
include("circuit_parametric_functions.jl")
include("circuit_parametric_classes.jl")

for class in circuit_parametric_classes
    class in _ignore_classes && continue
    @eval begin
        @pyclass circuit_parametric $(class)
        export $(class)
    end
end

for func in circuit_parametric_functions
    func in _ignore_functions && continue
    @eval begin
        @pyfunc circuit_parametric $(func)
        export $(func)
    end
end

function __init__()
    copy!(circuit_parametric, pyimport("quri_parts.circuit.circuit_parametric"))
end

end