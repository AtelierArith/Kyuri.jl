module Trotter_suzuki

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const trotter_suzuki = PyNULL()

# submodules



@static if isfile("trotter_suzuki_custom.jl")
    include("trotter_suzuki_custom.jl")
end

# attributes
include("trotter_suzuki_functions.jl")
include("trotter_suzuki_classes.jl")

for class in trotter_suzuki_classes
    @eval begin
        @pyclass trotter_suzuki $(class)
        export $(class)
    end
end

for func in trotter_suzuki_functions
    @eval begin
        @pyfunc trotter_suzuki $(func)
        export $(func)
    end
end

function __init__()
    copy!(trotter_suzuki, pyimport("quri_parts.core.operator.trotter_suzuki"))
end

end