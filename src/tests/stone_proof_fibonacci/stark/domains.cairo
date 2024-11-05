use integrity::domains::StarkDomains;

fn get() -> StarkDomains {
    return StarkDomains {
        log_eval_domain_size: 0x16,
        eval_domain_size: 0x400000,
        eval_generator: 0x3e4383531eeac7c9822fb108d24a344d841544dd6482f17ead331453e3a2f4b,
        log_trace_domain_size: 0x12,
        trace_domain_size: 0x40000,
        trace_generator: 0x4768803ef85256034f67453635f87997ff61841e411ee63ce7b0a8b9745a046,
    };
}
