# %%
using Kyuri.core.operator
using PyCall
const pyprintln = pybuiltin("print")

# %%
label = pauli_label("X0 Y2 Z4")
pyprintln(label)

# %%
pyprintln(PAULI_IDENTITY)

# %%
for pair in label
    println(pair)
end

# %%
for (index, matrix) in label
    println("qubit index: $index, Pauli matrix: $matrix")
end

# %%
#=
op = Operator(Dict(
    pauli_label("X0 Y1")=> 0.5 + 0.5im,
    pauli_label("Z0 Z2")=> 0.2im,
    PAULI_IDENTITY=> 0.3 + 0.4im,
))

op.add_term(pauli_label("X0 Y1"), 0.5 + 0.5j)
op.add_term(pauli_label("Z0 Z2"), 0.2j)
op.constant = 0.3 + 0.4j
=#

# %%
using Kyuri.core.state

state1 = ComputationalBasisState(5, bits=0b10100)
print(state1)

state2 = ComputationalBasisState(5, bits=0b01011)
sp_state = comp_basis_superposition(state1, state2, pi/2, pi/4)
print(sp_state)

# %%
# create_qulacs_vector_estimator
