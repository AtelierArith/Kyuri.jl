# %%
import importlib
from importlib import metadata
import inspect
import isort
import os

# %%
import quri_parts
import quri_parts.core
import quri_parts.core.circuit
import quri_parts.core.estimator
import quri_parts.core.estimator.sampling
import quri_parts.core.measurement
import quri_parts.core.operator
import quri_parts.core.operator.grouping
import quri_parts.core.operator.representation
import quri_parts.core.sampling
import quri_parts.core.state
import quri_parts.core.utils

# %%
from dataclasses import dataclass

# %%
from quri_parts.circuit.clifford_gate import is_clifford

# %%
is_clifford.__module__

# %%
from quri_parts.core.operator.pauli import PauliLabel

PauliLabel.__module__

# %%
from quri_parts.core.measurement.interface import PauliLabel

PauliLabel.__module__

# %%
isort.place_module(is_clifford.__module__)

# %%
isort.place_module(dataclass.__module__) == "STDLIB"

# %%
metadata.distribution("quri_parts").version

# %%
WHITE_SPACE = " "
MAX_NEXT_LEVEL = 3


# %%
def collect_target_objects(pymod):
    if isinstance(pymod, str):
        pymod = importlib.import_module(f"{pymod}")

    pymod_name = pymod.__name__
    classes = []
    functions = []
    alias_classes = []
    alias_functions = []
    for attr_str in sorted(pymod.__dir__()):
        attr = getattr(pymod, attr_str)
        if attr_str.startswith("_"):
            # do not include private objects
            continue
        if inspect.isclass(attr):
            if isort.place_module(attr.__module__) == "STDLIB":
                # ignore Python classes that are provided by some Python standard libraries
                continue
            if attr.__module__ != pymod_name:
                alias_classes.append(
                    attr_str + " => " + '"' + str(attr.__module__) + '"'
                )
                continue
            classes.append(attr_str)
        if inspect.isfunction(attr):
            if isort.place_module(attr.__module__) == "STDLIB":
                # ignore Python functions that are provided by some Python standard libraries
                continue
            if attr.__module__ != pymod_name:
                alias_functions.append(
                    attr_str + " => " + '"' + str(attr.__module__) + '"'
                )
                continue
            functions.append(attr_str)
    return dict(
        functions=functions,
        alias_functions=alias_functions,
        classes=classes,
        alias_classes= classes,
    )

def print_pymod_api(pymod, level=0):
    if isinstance(pymod, str):
        pymod = importlib.import_module(f"{pymod}")
    pymod_name = pymod.__name__
    ret = collect_target_objects(pymod)
    indent = 4 * level * WHITE_SPACE
    print(indent + f"# --- {pymod_name} ---")
    for (obj_name, objs) in ret.items():
        print(indent + f"const {pymod_name}_{obj_name} = [")
        for c in objs:
            print(indent + 4 * WHITE_SPACE + ":" + c + ",")
        print(indent + "]")
        print()
        
def write_pymod_api(pymod):
    if isinstance(pymod, str):
        pymod = importlib.import_module(f"{pymod}")
    pymod_name = pymod.__name__
    filename_base = pymod_name.replace(".", "/")
    print(pymod_name)
    ret = collect_target_objects(pymod)
    print(f"# --- {pymod_name} ---")
    for (obj_name, objs) in ret.items():
        jlfile_name = filename_base + "_" + obj_name + ".jl"
        os.makedirs(os.path.dirname(filename_base), exist_ok=True)
        with open(jlfile_name, "w") as f:
            f.write(f"# --- {filename_base}_{obj_name}.jl\n")
            f.write(f"const {pymod_name}_{obj_name} = [\n")
            for c in objs:
                f.write(4 * WHITE_SPACE + ":" + c + ",\n")
            f.write("]\n")
                                                    


# %%
write_pymod_api("quri_parts.core.operator.pauli")


# %%
def print_module(pymod="quri_parts", level=0):
    if isinstance(pymod, str):
        pymod = importlib.import_module(f"{pymod}")
    for attr_str in sorted(pymod.__dir__()):
        attr = getattr(pymod, attr_str)
        if inspect.ismodule(attr):
            if isort.place_module(attr.__name__) == "STDLIB":
                # "ignore standard lib e.g. `re`
                continue
            indent = 4 * level * WHITE_SPACE
            pymod_name = attr.__name__
            if level + 1 > MAX_NEXT_LEVEL:
                continue
            if pymod_name in ["numpy"]:
                continue
            print(indent + f"# --- print-module-{attr.__name__} ---")
            print_module(pymod=pymod_name, level=level + 1)
            print_pymod_api(pymod=pymod_name, level=level + 1)


# %%
def print_all():
    print_module(pymod=quri_parts)


# %%
print_all()


# %%
def generate_api(pymod="quri_parts", level=0):
    if isinstance(pymod, str):
        pymod = importlib.import_module(f"{pymod}")
    for attr_str in sorted(pymod.__dir__()):
        attr = getattr(pymod, attr_str)
        if inspect.ismodule(attr):
            if isort.place_module(attr.__name__) == "STDLIB":
                # "ignore standard lib e.g. `re`
                continue
            indent = 4 * level * WHITE_SPACE
            pymod_name = attr.__name__
            if level + 1 > MAX_NEXT_LEVEL:
                continue
            if pymod_name in ["numpy"]:
                continue
            #print(indent + f"# --- print-module-{attr.__name__} ---")
            generate_api(pymod=pymod_name, level=level + 1)
            write_pymod_api(pymod=pymod_name)


# %%
generate_api("quri_parts")

# %%
