from pathlib import Path

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


def write_jlmod(pymod: str):
    filename_base = pymod_name.replace(".", "/")
    pymod_name = operator.__name__
    filename_base = Path(pymod_name.replace(".", "/"))
    jlmod_name = filename_base.stem.capitalize() + ".jl"

    jlmod_file_path = filename_base.parent.joinpath(jlmod_name)
    with open(jlmod_file_path, "w") as f:
        template = Template(source=source)
        rendered_txt = template.render(pymod=pymod)
        f.write(rendered_txt)
