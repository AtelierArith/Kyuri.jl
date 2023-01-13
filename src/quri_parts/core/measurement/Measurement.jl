module Measurement

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const measurement = PyNULL()

# submodules


include("bitwise_commuting_pauli/Bitwise_commuting_pauli.jl")

include("interface/Interface.jl")


# customize _ignore_xxx in measurement_custom.jl as necessary
_ignore_classes = Symbol[]
_ignore_functions = Symbol[]

@static if isfile(joinpath(@__DIR__, "measurement_custom.jl"))
    include("measurement_custom.jl")
end

# attributes
include("measurement_functions.jl")
include("measurement_classes.jl")

for class in measurement_classes
    class in _ignore_classes && continue
    @eval begin
        @pyclass measurement $(class)
        export $(class)
    end
end

for func in measurement_functions
    func in _ignore_functions && continue
    @eval begin
        @pyfunc measurement $(func)
        export $(func)
    end
end

function __init__()
    copy!(measurement, pyimport("quri_parts.core.measurement"))
end

end