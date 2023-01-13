import importlib
import inspect
import os
from pathlib import Path
import isort

from jinja2 import Template

source: str = """
{%-set pymod_base = pymod.split('.')[-1] -%}
module {{jlmod_name}}

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const pymod_{{pymod_base}} = PyNULL()

# submodules

{% for submod in jl_submodules %}
include("{{submod}}")
{% endfor %}

# customize _ignore_xxx in {{pymod_base}}_custom.jl as necessary
_ignore_classes = Symbol[]
_ignore_functions = Symbol[]

@static if isfile(joinpath(@__DIR__, "{{pymod_base}}_custom.jl"))
    include("{{pymod_base}}_custom.jl")
end

# attributes
include("{{pymod_base}}_functions.jl")
include("{{pymod_base}}_classes.jl")

for class in {{pymod_base}}_classes
    class in _ignore_classes && continue
    @eval begin
        @pyclass pymod_{{pymod_base}} $(class)
        export $(class)
    end
end

for func in {{pymod_base}}_functions
    func in _ignore_functions && continue
    @eval begin
        @pyfunc pymod_{{pymod_base}} $(func)
        export $(func)
    end
end

if !isdefined(@__MODULE__, :__init__)
    @eval function __init__()
        copy!(pymod_{{pymod_base}}, pyimport("{{pymod}}"))
    end
end

end
"""


def write_jlmod(pymod):
    if isinstance(pymod, str):
        pymod = importlib.import_module(f"{pymod}")
    jl_submodules = []
    for attr_str in sorted(pymod.__dir__()):
        attr = getattr(pymod, attr_str)
        if inspect.ismodule(attr):
            submod_name = attr.__name__
            if isort.place_module(submod_name) == "STDLIB":
                continue
            if submod_name.split(".")[0] in ["numpy", "array"]:
                continue
            if submod_name.split(".")[-1] in ["numpy", "array"]:
                continue
            if submod_name.split(".")[:-1] != pymod.__name__.split("."):
                # avoid loading alias
                continue
            submod_base = submod_name.split(".")[-1]
            jlmod_file = submod_base + ".jl"
            if submod_name == "quri_parts.core.operator.operator":
                jlmod_file = "_operator.jl"
            if submod_name == "quri_parts.core.state.state":
                jlmod_file = "_state.jl"
            if submod_name == "quri_parts.circuit.circuit":
                jlmod_file = "_circuit.jl"
            jl_submodules.append(submod_base + "/" + jlmod_file)

    pymod_name = pymod.__name__
    jlmod_name = pymod_name.split('.')[-1]
    if pymod_name == "quri_parts.core.operator.operator":
        jlmod_name = "_operator"
    if pymod_name == "quri_parts.core.state.state":
        jlmod_name = "_state"
    if pymod_name == "quri_parts.circuit.circuit":
        jlmod_name = "_circuit"
    filename_base = Path(pymod_name.replace(".", "/"))
    os.makedirs(filename_base, exist_ok=True)
    jlmod_file_path = filename_base.joinpath(filename_base.stem + ".jl")

    if str(jlmod_file_path) == "quri_parts/core/operator/operator/operator.jl":
        jlmod_file_path = "quri_parts/core/operator/operator/_operator.jl"
    if str(jlmod_file_path) == "quri_parts/core/state/state/state.jl":
        jlmod_file_path = "quri_parts/core/state/state/_state.jl"
    if str(jlmod_file_path) == "quri_parts/circuit/circuit/circuit.jl":
        jlmod_file_path = "quri_parts/circuit/circuit/_circuit.jl"
    with open(jlmod_file_path, "w") as f:
        template = Template(source=source)
        rendered_txt = template.render(
            pymod=pymod_name,
            jlmod_name=jlmod_name,
            jl_submodules=jl_submodules,
        )
        f.write(rendered_txt)
