# --- quri_parts/core/state_alias_classes.jl
const state_alias_classes = [
    :CircuitQuantumState => "quri_parts.core.state.state",
    :ComputationalBasisState => "quri_parts.core.state.comp_basis",
    :GeneralCircuitQuantumState => "quri_parts.core.state.state",
    :ParametricCircuitQuantumState => "quri_parts.core.state.state_parametric",
    :ParametricQuantumStateVector => "quri_parts.core.state.state_vector_parametric",
    :QuantumState => "quri_parts.core.state.state",
    :QuantumStateVector => "quri_parts.core.state.state_vector",
]
