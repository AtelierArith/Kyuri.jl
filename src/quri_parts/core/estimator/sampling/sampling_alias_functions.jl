# --- quri_parts/core/estimator/sampling_alias_functions.jl
const sampling_alias_functions = [
    :concurrent_sampling_estimate => "quri_parts.core.estimator.sampling.estimator",
    :create_sampling_concurrent_estimator => "quri_parts.core.estimator.sampling.estimator",
    :create_sampling_estimator => "quri_parts.core.estimator.sampling.estimator",
    :general_pauli_covariance_estimator => "quri_parts.core.estimator.sampling.pauli",
    :general_pauli_expectation_estimator => "quri_parts.core.estimator.sampling.pauli",
    :general_pauli_sum_expectation_estimator => "quri_parts.core.estimator.sampling.pauli",
    :general_pauli_sum_sample_variance => "quri_parts.core.estimator.sampling.pauli",
    :sampling_estimate => "quri_parts.core.estimator.sampling.estimator",
    :trivial_pauli_covariance_estimator => "quri_parts.core.estimator.sampling.pauli",
    :trivial_pauli_expectation_estimator => "quri_parts.core.estimator.sampling.pauli",
]