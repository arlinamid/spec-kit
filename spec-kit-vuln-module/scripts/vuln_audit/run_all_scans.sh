#!/usr/bin/env bash
set -euo pipefail

echo "[vuln-audit] Starting scans…"

# Secrets (Gitleaks)
if command -v gitleaks >/dev/null 2>&1; then
  echo "[+] Gitleaks (secrets)"
  gitleaks detect --source . --report-format sarif --report-path artifacts/gitleaks.sarif || true
else
  echo "[!] gitleaks not found. See: https://gitleaks.io/"
fi

# Python SAST (Bandit)
if command -v bandit >/dev/null 2>&1; then
  echo "[+] Bandit (Python)"
  bandit -r . -f sarif -o artifacts/bandit.sarif || true
else
  echo "[!] bandit not found. See: https://bandit.readthedocs.io/"
fi

# Python deps (pip-audit)
if command -v pip-audit >/dev/null 2>&1; then
  echo "[+] pip-audit (Python deps)"
  pip-audit -r requirements.txt -f json -o artifacts/pip-audit.json || true
else
  echo "[!] pip-audit not found. See: https://pypi.org/project/pip-audit/"
fi

# Semgrep generic
if command -v semgrep >/dev/null 2>&1; then
  echo "[+] Semgrep (rules: auto)"
  semgrep scan --error --sarif --output artifacts/semgrep.sarif || true
else
  echo "[!] semgrep not found. See: https://semgrep.dev/"
fi

# Trivy (fs + config + container if Dockerfile present)
if command -v trivy >/dev/null 2>&1; then
  echo "[+] Trivy filesystem scan"
  trivy fs --security-checks vuln,config,secret --format sarif --output artifacts/trivy-fs.sarif . || true
  if [ -f Dockerfile ]; then
    echo "[+] Trivy Dockerfile/image scan (if image available)"
    trivy config --format sarif --output artifacts/trivy-dockerfile.sarif . || true
  fi
else
  echo "[!] trivy not found. See: https://trivy.dev/"
fi

# SBOM via Syft (CycloneDX JSON)
if command -v syft >/dev/null 2>&1; then
  echo "[+] Syft SBOM (CycloneDX JSON)"
  mkdir -p artifacts
  syft packages dir:. -o cyclonedx-json > artifacts/sbom.cdx.json || true
else
  echo "[!] syft not found. See: https://github.com/anchore/syft"
fi

echo "[vuln-audit] Done. Artifacts in ./artifacts"
