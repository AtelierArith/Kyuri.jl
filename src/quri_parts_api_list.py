"""

This is a python script to show API for each submodules of quri_parts

"""
import importlib
import inspect
from importlib import metadata

import isort
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
import quri_parts.core.state
import quri_parts.core.utils

WHITE_SPACE = " "
MAX_NEXT_LEVEL = 3


def print_pymod_api(pymod, level=0):
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

    indent = 4 * level * WHITE_SPACE
    print(indent + f"# --- {pymod_name} ---")
    for (objs, obj_name) in [
        (classes, "classes"),
        (functions, "functions"),
        (alias_classes, "alias_classes"),
        (alias_functions, "alias_functions"),
    ]:
        print(indent + f"const {pymod_name}_{obj_name} = [")
        for c in objs:
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
            if level + 1 > MAX_NEXT_LEVEL:
                # do not take a deep dive on python module too much.
                continue
            if pymod_name in ["numpy"]:
                # do not study third party libraries other than quri_parts
                continue
            print(indent + f"# --- print-module-{attr.__name__} ---")
            print_module(pymod=pymod_name, level=level + 1)
            print_pymod_api(pymod=pymod_name, level=level + 1)


def print_all():
    print_module(pymod=quri_parts)
