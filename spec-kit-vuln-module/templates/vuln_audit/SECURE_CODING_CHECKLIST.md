# Secure Coding Checklist (ASVS‑mapped)

> Use as a living checklist during development & review.

## Authentication & Session
- [ ] Enforce MFA for admin paths (ASVS 2.1)
- [ ] Session cookies: `HttpOnly`, `Secure`, `SameSite` (ASVS 3.4)
- [ ] Password storage: Argon2/BCrypt with proper params (ASVS 2.5)

## Access Control
- [ ] Server‑side authorization for every request (ASVS 4.x)
- [ ] Deny‑by‑default, least privilege roles

## Input / Output
- [ ] Centralized validation & encoding (ASVS 5.x)
- [ ] Parameterized queries (no string‑built SQL) (ASVS 5.3)

## Secrets & Config
- [ ] No secrets in code; use vaults. Rotate regularly.
- [ ] `.gitignore` sensitive files; enable secret scanning.

## Cryptography
- [ ] TLS 1.2+ only; modern cipher suites (ASVS 9.x)
- [ ] Use vetted crypto libs; no home‑grown crypto.

## Logging & Monitoring
- [ ] Structured logs; privacy‑aware; tamper‑evident (ASVS 7.x)
- [ ] Alerting on authz/authn failures, policy violations.

## Supply Chain
- [ ] SBOM generated and stored with artifacts
- [ ] Pin dependencies; auto‑update vulnerable packages.

## LLM/Agent (if used)
- [ ] Tool sandboxing, output‑validation, PII redaction.
- [ ] Prompt templates reviewed; jailbreak tests included.
