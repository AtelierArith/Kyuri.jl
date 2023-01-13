const PAULI_IDENTITY = PyNULL()

module SinglePauli
    @enum _SinglePauli X=1 Y=2 Z=3
end

_ignore_classes = [:SinglePauli]

function __init__()
    copy!(pymod_pauli, pyimport("quri_parts.core.operator.pauli"))
    copy!(PAULI_IDENTITY, pymod_pauli.PauliLabel())
end