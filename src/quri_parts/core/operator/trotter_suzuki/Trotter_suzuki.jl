module Trotter_suzuki

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const trotter_suzuki = PyNULL()

# submodules



# customize _ignore_xxx in trotter_suzuki_custom.jl as necessary
_ignore_classes = Symbol[]
_ignore_functions = Symbol[]

@static if isfile(joinpath(@__DIR__, "trotter_suzuki_custom.jl"))
    include("trotter_suzuki_custom.jl")
end

# attributes
include("trotter_suzuki_functions.jl")
include("trotter_suzuki_classes.jl")

for class in trotter_suzuki_classes
    class in _ignore_classes && continue
    @eval begin
        @pyclass trotter_suzuki $(class)
        export $(class)
    end
end

for func in trotter_suzuki_functions
    func in _ignore_functions && continue
    @eval begin
        @pyfunc trotter_suzuki $(func)
        export $(func)
    end
end

function __init__()
    copy!(trotter_suzuki, pyimport("quri_parts.core.operator.trotter_suzuki"))
end

end