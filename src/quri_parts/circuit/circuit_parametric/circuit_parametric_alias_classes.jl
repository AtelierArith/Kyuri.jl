# --- quri_parts/circuit/circuit_parametric_alias_classes.jl
const circuit_parametric_alias_classes = [
    :ImmutableQuantumCircuit => "quri_parts.circuit.circuit",
    :MutableQuantumCircuitProtocol => "quri_parts.circuit.circuit",
    :NonParametricQuantumCircuit => "quri_parts.circuit.circuit",
    :ParametricQuantumGate => "quri_parts.circuit.gate",
    :QuantumCircuit => "quri_parts.circuit.circuit",
    :QuantumCircuitProtocol => "quri_parts.circuit.circuit",
    :QuantumGate => "quri_parts.circuit.gate",
]
