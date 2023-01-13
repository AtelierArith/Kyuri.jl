module Interface

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const interface = PyNULL()

# submodules



@static if isfile("interface_custom.jl")
    include("interface_custom.jl")
end

# attributes
include("interface_functions.jl")
include("interface_classes.jl")

for class in interface_classes
    @eval begin
        @pyclass interface $(class)
        export $(class)
    end
end

for func in interface_functions
    @eval begin
        @pyfunc interface $(func)
        export $(func)
    end
end

function __init__()
    copy!(interface, pyimport("quri_parts.core.measurement.interface"))
end

end