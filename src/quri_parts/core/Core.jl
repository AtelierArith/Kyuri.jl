module Core

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const core = PyNULL()

# submodules
include("operator/Operator.jl")

# attributes
include("core_functions.jl")
include("core_classes.jl")
include("core_alias_classes.jl")
include("core_alias_functions.jl")

for class in core_classes
    @eval begin
        @pyclass qulacs $(class)
        export $(class)
    end
end

for func in core_functions
    @eval begin
        @pyfunc operator $(func)
        export $(func)
    end
end

function __init__()
    copy!(core, pyimport("quri_parts.core"))
end

end
