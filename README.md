# Kyuri [![Build Status](https://github.com/AtelierArith/Kyuri.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/AtelierArith/Kyuri.jl/actions/workflows/CI.yml?query=branch%3Amain) [![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://AtelierArith.github.io/Kyuri.jl/stable/) [![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://AtelierArith.github.io/Kyuri.jl/dev/)

![BFB00750-40A5-4D15-BF7F-68CFFB010C42_1_201_a](https://user-images.githubusercontent.com/16760547/212356653-7460c70e-0407-4926-af28-0b5c44afc4df.jpeg)

This is an unofficial julia interface for [quri-parts](https://quri-parts.qunasys.com/).

Extending the software methodology of Kyulacs.jl, we wondered if we could create a wrapper for complex projects. 80 percent of what we had planned was successful, but the remaining 20 percent (which included critical requirements) is not easy than we expected. Therefore, the reader should note that the current implementation does not provide comfortable software for us.

# How to use

## Install quri-parts

```console
$ pip3 install quri-parts
```

## Call quri-parts from Julia

```console
git clone https://github.com/AtelierArith/Kyuri.jl.git
cd Kyuri.jl
julia --project=@. -e 'using Pkg; Pkg.instantiate()'
julia -q --project=@.
julia> using Kyuri.core.operator
julia> label = pauli_label("X0 Y2 Z4")
```

# How do we generate files located under `src/quri_parts`?

Most files located under `src/quri_parts/` are generated automatically using `src/gen_quri_parts_api.py`.

```console
$ cd src
$ python gen_quri_parts_api.py
```

The implementation is messy, but it actually works.

Files in the form of `<pymod>_custom.jl` are created by hand. This mechanism allows customization of the behavior of each module.
