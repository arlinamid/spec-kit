# LLM / Agent Security Guide

**Scope:** Apply when your system uses LLMs, agents, function/tool calling, or RAG.

## Top Risks (OWASP LLM Top 10)
- **LLM01 Prompt Injection**: Strict input isolation, instruction hierarchy, and allow‑list tools.
- **LLM02 Insecure Output Handling**: Treat model output as **untrusted**; validate/sanitize before execution.
- **LLM03 Training Data Poisoning**: Verify sources, dataset integrity, and signatures.
- **LLM04 Model Denial of Service**: Rate limits, quotas, per‑tenant budgets.
- **LLM05 Supply Chain**: Verify model/provider attestations; pin versions; SBOM for models if available.
- … see full list in OWASP docs.

## Controls
- **Policy sandbox**: No raw FS/NET unless required. Use per‑request capabilities.
- **Data privacy**: Redact PII/PHI; tenant isolation; retention policies.
- **Eval & red‑team**: Include jailbreak suites; track pass/fail.
- **Auditability**: Log prompts, tool calls, outputs with PII‑safe redaction.
