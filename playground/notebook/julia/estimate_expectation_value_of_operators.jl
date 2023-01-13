# %%
using Kyuri.Core.Operator
using PyCall
const pyprintln = pybuiltin("print")

# %%
label = pauli_label("X0 Y2 Z4")
pyprintln(label)

# %%
pyprintln(Operator.operator.PAULI_IDENTITY)

# %%
for pair in label
    println(pair)
end

# %%
for (index, matrix) in label
    print("qubit index: $index, Pauli matrix: $matrix")
end
