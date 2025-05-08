#[cfg(feature: '_verifier_logic')]
mod fact_registry;
mod fact_registry_interface;
mod mocked_fact_registry;

#[cfg(feature: '_verifier_logic')]
mod proxy;
#[cfg(feature: '_verifier_logic')]
mod verifier;
