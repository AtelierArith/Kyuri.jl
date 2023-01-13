# %% [markdown]
# # Study jinja2
#
# https://jinja.palletsprojects.com/en/3.1.x/api/

# %%
import importlib
import inspect
import os
from pathlib import Path

from jinja2 import Template

# %%
import quri_parts
import quri_parts.backend
import quri_parts.core
import quri_parts.core.circuit
import quri_parts.core.estimator
import quri_parts.core.estimator.sampling
import quri_parts.core.measurement
import quri_parts.core.operator
import quri_parts.core.operator.grouping
import quri_parts.core.operator.representation
import quri_parts.core.sampling
import quri_parts.core.estimator.sampling.estimator
import quri_parts.core.state
import quri_parts.core.utils

# %%
source: str = """
{%-set pymod_base = pymod.split('.')[-1] -%}
module {{pymod_base.capitalize()}}

using PyCall
using Reexport

import ..@pyfunc
import ..@pyclass

const {{pymod_base}} = PyNULL()

# submodules

{% for submod in jl_submodules %}
include("{{submod}}")
{% endfor %}

@static if isfile("{{pymod_base}}_custom.jl")
    include("{{pymod_base}}_custom.jl")
end

# attributes
include("{{pymod_base}}_functions.jl")
include("{{pymod_base}}_classes.jl")

for class in {{pymod_base}}_classes
    @eval begin
        @pyclass {{pymod_base}} $(class)
        export $(class)
    end
end

for func in {{pymod_base}}_functions
    @eval begin
        @pyfunc {{pymod_base}} $(func)
        export $(func)
    end
end

function __init__()
    copy!({{pymod_base}}, pyimport("{{pymod}}"))
end

end
"""


def dosome(pymod):
    if isinstance(pymod, str):
        pymod = importlib.import_module(f"{pymod}")
    jl_submodules = []
    for attr_str in sorted(pymod.__dir__()):
        attr = getattr(pymod, attr_str)
        if inspect.ismodule(attr):
            submod_name = attr.__name__
            submod_base = submod_name.split(".")[-1]
            if submod_name == "quri_parts.core.operator.operator":
                jlmod_file = "_Operator.jl"
            else:
                jlmod_file = submod_base.capitalize() + ".jl"
            jl_submodules.append(submod_base + "/" + jlmod_file)

    template = Template(source=source)
    rendered_txt = template.render(
        pymod=pymod.__name__,
        jl_submodules=jl_submodules,
    )
    print(rendered_txt)
    
dosome("quri_parts.core.estimator.sampling.estimator")

# %%

# %%
