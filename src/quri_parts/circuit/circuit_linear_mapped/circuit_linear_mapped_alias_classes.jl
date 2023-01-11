# --- quri_parts/circuit/circuit_linear_mapped_alias_classes.jl
const circuit_linear_mapped_alias_classes = [
    :ImmutableBoundParametricQuantumCircuit => "quri_parts.circuit.circuit_parametric",
    :ImmutableUnboundParametricQuantumCircuit => "quri_parts.circuit.circuit_parametric",
    :LinearParameterMapping => "quri_parts.circuit.parameter_mapping",
    :MutableUnboundParametricQuantumCircuitProtocol => "quri_parts.circuit.circuit_parametric",
    :NonParametricQuantumCircuit => "quri_parts.circuit.circuit",
    :Parameter => "quri_parts.circuit.circuit_parametric",
    :ParametricQuantumGate => "quri_parts.circuit.gate",
    :QuantumGate => "quri_parts.circuit.gate",
    :UnboundParametricQuantumCircuit => "quri_parts.circuit.circuit_parametric",
    :UnboundParametricQuantumCircuitBase => "quri_parts.circuit.circuit_parametric",
    :UnboundParametricQuantumCircuitProtocol => "quri_parts.circuit.circuit_parametric",
]
