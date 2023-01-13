# %%
using Kyuri.circuit: QuantumGate

gates = [
    # X gate acting on qubit 0
    QuantumGate("X", target_indices=(0,)),
    # Rotation gate acting on qubit 1 with angle pi/3
    QuantumGate("RX", target_indices=(1,), params=(pi/3,)),
    # CNOT gate on control qubit 2 and target qubit 1
    QuantumGate("CNOT", target_indices=(1,), control_indices=(2,)),
]

for gate in gates
    print(gate)
end

# %%
