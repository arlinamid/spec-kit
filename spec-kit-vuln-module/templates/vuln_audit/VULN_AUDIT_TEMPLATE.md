# Security & Vulnerability Audit — ${PROJECT_NAME}

**Owner:** ${OWNER}  
**Repo:** ${REPO_URL}  
**Version/Date:** ${DATE}

## 1) Scope & Context
- **System overview:** ${SYSTEM_OVERVIEW}
- **Data classification:** ${DATA_CATEGORIES}
- **Environments:** ${ENVIRONMENTS}
- **Tech stack:** ${TECH_STACK}

## 2) Trust Boundaries & Data Flows
- Components: ${COMPONENTS}
- Trust boundaries: ${TRUST_BOUNDARIES}
- External services: ${EXTERNALS}
- Attach DFD sketch / diagram link.

## 3) Threat Model (STRIDE)
List threats per component (Spoofing, Tampering, Repudiation, Information disclosure, Denial of service, Elevation of privilege).  
See `THREAT_MODEL_TEMPLATE.md` for a structured table.

## 4) Control Baselines
- **OWASP ASVS mapping (levels 1–3)**: Identify applicable controls and verification items.
- **NIST SSDF (SP 800‑218):** Map lifecycle practices (PS, PW, RV, BO) you meet today vs target.
- **Supply chain:** SLSA level target; SBOM (CycloneDX) generated per release.

> References: OWASP ASVS, OWASP Top 10, NIST SSDF, SLSA, CycloneDX.

## 5) Static & Composition Analysis Plan (SAST/SCA)
- **Semgrep** rulesets: `auto` + project‑specific
- **CodeQL** languages: ${CODEQL_LANGS}
- **Python:** Bandit + pip‑audit
- **Secrets:** Gitleaks
- **SBOM:** Syft (CycloneDX JSON)
- **IaC/Containers:** Trivy (filesys/image/iac)

Include commands and CI workflow (`.github/workflows/security.yml`).

## 6) Dynamic & Interactive Testing (DAST/IAST)
- **Web:** OWASP ZAP baseline/active scan against staging
- **Fuzzing (optional):** OSS‑Fuzz/ClusterFuzzLite if C/C++/Rust parts exist

## 7) LLM/Agent Security (if applicable)
Use `LLM_SECURITY_GUIDE.md`. Cover:
- Prompt injection defenses (input/output handling, tool sandbox)
- Sensitive data controls (PII scrubbing, redaction)
- Model & tool permissions, network/file system policies
- Training data provenance, evals, jailbreak resilience

## 8) Findings & Risk Register
Track findings in `RISK_REGISTER.csv` with **CVSS v4.0** fields.  
Record: ID, Title, Affected, Evidence, CVSS vector, Score, Exploitability, Status, Owner, Due.

## 9) Remediation & Verification
- Fix plan, code owner, deadline
- Verification evidence (test IDs, commit SHA, CI run URL)
- Backporting/patching policy

## 10) Sign‑off & Audit Log
- Security review sign‑off checklist
- Links to CI artifacts (SARIF, SBOM, Trivy, ZAP reports)
- Date/time‑stamped log entries
