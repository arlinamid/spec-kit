# Vulnerability Audit Module (spec-kit extension)

This module adds **security-by-default** documentation templates and automation to your `spec-kit` workflows.

## What you get
- **Templates (Markdown):** Vulnerability audit doc, threat model (STRIDE), secure coding checklist (ASVS‑mapped),
  LLM security guide (OWASP LLM Top‑10), SBOM & supply-chain notes (CycloneDX/SLSA), risk register.
- **Scripts (Bash/Python):** One‑shot scanner orchestrator + language/stack specific scanners (Python, Bash, IaC),
  SBOM generation, secrets scanning, CVSS helper stubs, doc generator.
- **CI (GitHub Actions):** CodeQL, Semgrep, Bandit, pip‑audit, Gitleaks, Trivy; artifacts attach to releases/PRs.
- **Pre‑commit hooks:** Light security gates to catch issues before they land on `main`.

> Drop the `templates/`, `scripts/`, `.github/`, `prompts/`, and `config/` folders into the root of your repo.
> Then run: `pre-commit install` and (optionally) enable the provided GitHub Actions workflow.

## Quick start
1. **Fill `config/project_meta.yaml`** with basic project facts.
2. **Generate the audit doc**:
   ```bash
   python3 scripts/vuln_audit/gen_vuln_doc.py --meta config/project_meta.yaml --out SECURITY_AUDIT.md
   ```
3. **Run local scans** (requires Docker for some tools):
   ```bash
   bash scripts/vuln_audit/run_all_scans.sh
   ```
4. **Enable CI**: commit `.github/workflows/security.yml`.

## Notes
- CVSS v4.0 calculation is referenced to FIRST; this module includes a helper stub + links.
- SBOM generation uses Syft (CycloneDX JSON). Trivy covers deps/containers/IaC. Secrets via Gitleaks.
- For LLM‑powered apps, start with `templates/vuln_audit/LLM_SECURITY_GUIDE.md`.

