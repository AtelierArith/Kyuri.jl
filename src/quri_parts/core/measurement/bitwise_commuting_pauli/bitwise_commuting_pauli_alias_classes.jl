# --- quri_parts/core/measurement/bitwise_commuting_pauli_alias_classes.jl
const bitwise_commuting_pauli_alias_classes = [
    :CommutablePauliSetMeasurement => "quri_parts.core.measurement.interface",
    :CommutablePauliSetMeasurementTuple => "quri_parts.core.measurement.interface",
    :Operator => "quri_parts.core.operator.operator",
    :PauliLabel => "quri_parts.core.operator.pauli",
    :QuantumGate => "quri_parts.circuit.gate",
    :SinglePauli => "quri_parts.core.operator.pauli",
]
