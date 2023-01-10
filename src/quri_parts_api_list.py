"""

This is a python script to show API for each submodules of quri_parts

"""
from importlib import metadata

import isort

import quri_parts
import quri_parts.core
import quri_parts.core.operator
import quri_parts.core.operator.trotter_suzuki
import quri_parts.core.operator.representation
import quri_parts.core.operator.representation.bsf
import quri_parts.core.utils.bit

WHITE_SPACE = " "

"""

This is a python script to show API for each submodules of quri_parts

"""
import importlib
import inspect


def print_pymod_api(pymod, level=0):
    if isinstance(pymod, str):
        pymod = importlib.import_module(f"{pymod}")

    pymod_name = pymod.__name__
    classes = []
    functions = []
    for attr_str in sorted(pymod.__dir__()):
        attr = getattr(pymod, attr_str)
        if inspect.ismodule(attr):
            continue
        if attr_str.startswith("_"):
            continue
        if inspect.isclass(attr):
            classes.append(attr_str)
        if inspect.isfunction(attr):
            functions.append(attr_str)

    indent = 4 * level * WHITE_SPACE
    print(indent + f"# --- {pymod_name} ---")
    print(indent + f"const {pymod_name}_classes = [")
    for c in classes:
        print(indent + 4 * WHITE_SPACE + ":" + c + ",")
    print(indent + "]")
    print()
    print(indent + f"const {pymod_name}_functions = [")
    for c in functions:
        print(indent + 4 * WHITE_SPACE + ":" + c + ",")
    print(indent + "]")
    print()


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
            print(indent + f"# --- print-module-{attr.__name__} ---")
            print_module(pymod=pymod_name, level=level + 1)
            print_pymod_api(pymod=pymod_name, level=level + 1)


def print_all():
    print_module(pymod=quri_parts)
