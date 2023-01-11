# --- quri_parts/core/estimator_alias_classes.jl
const estimator_alias_classes = [
    :CircuitQuantumState => "quri_parts.core.state.state",
    :Operator => "quri_parts.core.operator.operator",
    :ParametricCircuitQuantumState => "quri_parts.core.state.state_parametric",
    :ParametricQuantumStateVector => "quri_parts.core.state.state_vector_parametric",
    :PauliLabel => "quri_parts.core.operator.pauli",
    :QuantumStateVector => "quri_parts.core.state.state_vector",
]
