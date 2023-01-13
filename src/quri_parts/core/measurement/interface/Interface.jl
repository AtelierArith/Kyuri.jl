module Interface

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const interface = PyNULL()

# submodules



# customize _ignore_xxx in interface_custom.jl as necessary
_ignore_classes = Symbol[]
_ignore_functions = Symbol[]

@static if isfile(joinpath(@__DIR__, "interface_custom.jl"))
    include("interface_custom.jl")
end

# attributes
include("interface_functions.jl")
include("interface_classes.jl")

for class in interface_classes
    class in _ignore_classes && continue
    @eval begin
        @pyclass interface $(class)
        export $(class)
    end
end

for func in interface_functions
    func in _ignore_functions && continue
    @eval begin
        @pyfunc interface $(func)
        export $(func)
    end
end

function __init__()
    copy!(interface, pyimport("quri_parts.core.measurement.interface"))
end

end