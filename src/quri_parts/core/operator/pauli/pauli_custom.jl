const PAULI_IDENTITY = PyNULL()

function __init__()
    copy!(pymod_pauli, pyimport("quri_parts.core.operator.pauli"))
    copy!(PAULI_IDENTITY, pymod_pauli.PauliLabel())
end