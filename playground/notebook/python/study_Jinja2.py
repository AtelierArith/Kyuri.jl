# %% [markdown]
# # Study jinja2
#
# https://jinja.palletsprojects.com/en/3.1.x/api/

# %%
from jinja2 import Template

source: str = """
{%-set pymod_name = pymod.split('.')[-1] -%}
module {{pymod_name.capitalize()}}

using PyCall
using Reexport

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const {{pymod_name}} = PyNULL()

# custom file
include("{{pymod_name}}_custom.jl")


@static if isfile("{{pymod_name}}_custom.jl")
    include("{{pymod_name}}_custom.jl")
end

# attributes
include("{{pymod_name}}_functions.jl")
include("{{pymod_name}}_classes.jl")

for class in {{pymod_name}}_classes
    @eval begin
        @pyclass {{pymod_name}} $(class)
        export $(class)
    end
end

for func in {{pymod_name}}_functions
    @eval begin
        @pyfunc {{pymod_name}} $(func)
        export $(func)
    end
end

function __init__()
    copy!({{pymod_name}}, pyimport("{{pymod}}"))
end

end
"""
template: Template = Template(source=source)
rendered_txt: str = template.render(pymod="quri_parts.core.operator")
print(rendered_txt)
