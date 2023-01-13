module Comp_basis

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const comp_basis = PyNULL()

# submodules



@static if isfile("comp_basis_custom.jl")
    include("comp_basis_custom.jl")
end

# attributes
include("comp_basis_functions.jl")
include("comp_basis_classes.jl")

for class in comp_basis_classes
    @eval begin
        @pyclass comp_basis $(class)
        export $(class)
    end
end

for func in comp_basis_functions
    @eval begin
        @pyfunc comp_basis $(func)
        export $(func)
    end
end

function __init__()
    copy!(comp_basis, pyimport("quri_parts.core.state.comp_basis"))
end

end