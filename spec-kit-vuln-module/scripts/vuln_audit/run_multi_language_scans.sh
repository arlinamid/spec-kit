#!/usr/bin/env bash
set -euo pipefail

# Multi-Language Security Scanning Script
# Automatically detects languages and runs appropriate security tools

echo "🔍 Multi-Language Security Audit Starting..."
echo "=============================================="

# Create artifacts directory
mkdir -p artifacts

# Run language detection
echo "📋 Step 1: Language Detection"
python3 scripts/vuln_audit/language_detector.py --output artifacts/language_detection.json --format json

# Parse detected languages
DETECTED_LANGUAGES=$(python3 -c "
import json
with open('artifacts/language_detection.json', 'r') as f:
    data = json.load(f)
    print(' '.join(data['project_info']['languages_detected']))
")

echo "🎯 Detected Languages: $DETECTED_LANGUAGES"

# Universal security scans (run regardless of language)
echo ""
echo "🌐 Step 2: Universal Security Scans"

# Secrets detection (Gitleaks)
if command -v gitleaks >/dev/null 2>&1; then
    echo "[+] Gitleaks (secrets detection)"
    gitleaks detect --source . --report-format sarif --report-path artifacts/gitleaks.sarif || true
else
    echo "[!] gitleaks not found. Install: https://gitleaks.io/"
fi

# Universal SAST (Semgrep)
if command -v semgrep >/dev/null 2>&1; then
    echo "[+] Semgrep (universal SAST)"
    semgrep scan --config=auto --error --sarif --output artifacts/semgrep-universal.sarif || true
else
    echo "[!] semgrep not found. Install: https://semgrep.dev/"
fi

# Filesystem and container security (Trivy)
if command -v trivy >/dev/null 2>&1; then
    echo "[+] Trivy (filesystem & container security)"
    trivy fs --security-checks vuln,config,secret --format sarif --output artifacts/trivy-fs.sarif . || true
    
    if [ -f Dockerfile ]; then
        echo "[+] Trivy (Dockerfile analysis)"
        trivy config --format sarif --output artifacts/trivy-dockerfile.sarif . || true
    fi
else
    echo "[!] trivy not found. Install: https://trivy.dev/"
fi

# SBOM generation (Syft)
if command -v syft >/dev/null 2>&1; then
    echo "[+] Syft (SBOM generation)"
    syft packages dir:. -o cyclonedx-json > artifacts/sbom.cdx.json || true
else
    echo "[!] syft not found. Install: https://github.com/anchore/syft"
fi

# Language-specific scans
echo ""
echo "🔧 Step 3: Language-Specific Security Scans"

# Python security scans
if echo "$DETECTED_LANGUAGES" | grep -q "python"; then
    echo "🐍 Python Security Scans"
    
    # Bandit (Python SAST)
    if command -v bandit >/dev/null 2>&1; then
        echo "[+] Bandit (Python SAST)"
        bandit -r . -f sarif -o artifacts/bandit.sarif || true
    else
        echo "[!] bandit not found. Install: pip install bandit"
    fi
    
    # Python dependency audit
    if command -v pip-audit >/dev/null 2>&1; then
        echo "[+] pip-audit (Python dependencies)"
        pip-audit -r requirements.txt -f json -o artifacts/pip-audit.json || true
    else
        echo "[!] pip-audit not found. Install: pip install pip-audit"
    fi
    
    # Safety (alternative Python dependency scanner)
    if command -v safety >/dev/null 2>&1; then
        echo "[+] Safety (Python dependencies)"
        safety check --json --output artifacts/safety.json || true
    else
        echo "[!] safety not found. Install: pip install safety"
    fi
fi

# JavaScript/TypeScript security scans
if echo "$DETECTED_LANGUAGES" | grep -qE "(javascript|typescript)"; then
    echo "🟨 JavaScript/TypeScript Security Scans"
    
    # npm audit
    if [ -f package.json ]; then
        echo "[+] npm audit (Node.js dependencies)"
        npm audit --json > artifacts/npm-audit.json || true
    fi
    
    # yarn audit
    if [ -f yarn.lock ]; then
        echo "[+] yarn audit (Node.js dependencies)"
        yarn audit --json > artifacts/yarn-audit.json || true
    fi
    
    # ESLint security plugin
    if command -v eslint >/dev/null 2>&1; then
        echo "[+] ESLint security rules"
        npx eslint-plugin-security . --format json > artifacts/eslint-security.json || true
    else
        echo "[!] eslint not found. Install: npm install -g eslint"
    fi
fi

# Go security scans
if echo "$DETECTED_LANGUAGES" | grep -q "go"; then
    echo "🐹 Go Security Scans"
    
    # gosec (Go security checker)
    if command -v gosec >/dev/null 2>&1; then
        echo "[+] gosec (Go security)"
        gosec -fmt sarif -out artifacts/gosec.sarif ./... || true
    else
        echo "[!] gosec not found. Install: go install github.com/securecodewarrior/gosec/v2/cmd/gosec@latest"
    fi
    
    # govulncheck (Go vulnerability checker)
    if command -v govulncheck >/dev/null 2>&1; then
        echo "[+] govulncheck (Go vulnerabilities)"
        govulncheck ./... > artifacts/govulncheck.txt || true
    else
        echo "[!] govulncheck not found. Install: go install golang.org/x/vuln/cmd/govulncheck@latest"
    fi
fi

# Rust security scans
if echo "$DETECTED_LANGUAGES" | grep -q "rust"; then
    echo "🦀 Rust Security Scans"
    
    # cargo audit
    if command -v cargo-audit >/dev/null 2>&1; then
        echo "[+] cargo-audit (Rust dependencies)"
        cargo audit --json > artifacts/cargo-audit.json || true
    else
        echo "[!] cargo-audit not found. Install: cargo install cargo-audit"
    fi
    
    # cargo deny
    if command -v cargo-deny >/dev/null 2>&1; then
        echo "[+] cargo-deny (Rust security policies)"
        cargo deny check --format json > artifacts/cargo-deny.json || true
    else
        echo "[!] cargo-deny not found. Install: cargo install cargo-deny"
    fi
fi

# Java security scans
if echo "$DETECTED_LANGUAGES" | grep -q "java"; then
    echo "☕ Java Security Scans"
    
    # SpotBugs
    if command -v spotbugs >/dev/null 2>&1; then
        echo "[+] SpotBugs (Java static analysis)"
        spotbugs -sarif -output artifacts/spotbugs.sarif . || true
    else
        echo "[!] spotbugs not found. Install: https://spotbugs.github.io/"
    fi
    
    # OWASP Dependency Check
    if command -v dependency-check.sh >/dev/null 2>&1; then
        echo "[+] OWASP Dependency Check (Java dependencies)"
        dependency-check.sh --project "Java Project" --scan . --format JSON --out artifacts/owasp-dependency-check.json || true
    else
        echo "[!] dependency-check not found. Install: https://owasp.org/www-project-dependency-check/"
    fi
fi

# C# security scans
if echo "$DETECTED_LANGUAGES" | grep -q "csharp"; then
    echo "🔷 C# Security Scans"
    
    # Security Code Scan
    if command -v security-scan >/dev/null 2>&1; then
        echo "[+] Security Code Scan (C#)"
        security-scan --format sarif --output artifacts/security-code-scan.sarif . || true
    else
        echo "[!] security-scan not found. Install: https://github.com/security-code-scan/security-code-scan"
    fi
fi

# C/C++ security scans
if echo "$DETECTED_LANGUAGES" | grep -qE "(cpp|c)"; then
    echo "⚙️ C/C++ Security Scans"
    
    # cppcheck
    if command -v cppcheck >/dev/null 2>&1; then
        echo "[+] cppcheck (C/C++ static analysis)"
        cppcheck --enable=all --xml --xml-version=2 . 2> artifacts/cppcheck.xml || true
    else
        echo "[!] cppcheck not found. Install: https://cppcheck.sourceforge.io/"
    fi
    
    # flawfinder
    if command -v flawfinder >/dev/null 2>&1; then
        echo "[+] flawfinder (C/C++ security)"
        flawfinder --csv --output artifacts/flawfinder.csv . || true
    else
        echo "[!] flawfinder not found. Install: pip install flawfinder"
    fi
fi

# PHP security scans
if echo "$DETECTED_LANGUAGES" | grep -q "php"; then
    echo "🐘 PHP Security Scans"
    
    # PHPCS Security Audit
    if command -v phpcs >/dev/null 2>&1; then
        echo "[+] PHPCS Security Audit (PHP)"
        phpcs --standard=Security --report=json --report-file=artifacts/phpcs-security.json . || true
    else
        echo "[!] phpcs not found. Install: composer global require squizlabs/php_codesniffer"
    fi
fi

# Ruby security scans
if echo "$DETECTED_LANGUAGES" | grep -q "ruby"; then
    echo "💎 Ruby Security Scans"
    
    # Brakeman
    if command -v brakeman >/dev/null 2>&1; then
        echo "[+] Brakeman (Ruby security)"
        brakeman --format json --output artifacts/brakeman.json . || true
    else
        echo "[!] brakeman not found. Install: gem install brakeman"
    fi
    
    # Bundler Audit
    if command -v bundle-audit >/dev/null 2>&1; then
        echo "[+] Bundler Audit (Ruby dependencies)"
        bundle-audit --format json > artifacts/bundler-audit.json || true
    else
        echo "[!] bundle-audit not found. Install: gem install bundler-audit"
    fi
fi

# Shell script security scans
if echo "$DETECTED_LANGUAGES" | grep -q "shell"; then
    echo "🐚 Shell Script Security Scans"
    
    # ShellCheck
    if command -v shellcheck >/dev/null 2>&1; then
        echo "[+] ShellCheck (Shell script analysis)"
        find . -name "*.sh" -exec shellcheck -f json {} \; > artifacts/shellcheck.json || true
    else
        echo "[!] shellcheck not found. Install: https://github.com/koalaman/shellcheck"
    fi
fi

# PowerShell security scans
if echo "$DETECTED_LANGUAGES" | grep -q "powershell"; then
    echo "💻 PowerShell Security Scans"
    
    # PSScriptAnalyzer
    if command -v Invoke-ScriptAnalyzer >/dev/null 2>&1; then
        echo "[+] PSScriptAnalyzer (PowerShell analysis)"
        Get-ChildItem -Recurse -Include "*.ps1" | Invoke-ScriptAnalyzer -ReportFormat JSON | ConvertTo-Json > artifacts/psscriptanalyzer.json || true
    else
        echo "[!] PSScriptAnalyzer not found. Install: Install-Module -Name PSScriptAnalyzer"
    fi
fi

# YAML security scans
if echo "$DETECTED_LANGUAGES" | grep -q "yaml"; then
    echo "📄 YAML Security Scans"
    
    # kube-score (for Kubernetes YAML)
    if command -v kube-score >/dev/null 2>&1; then
        echo "[+] kube-score (Kubernetes YAML analysis)"
        find . -name "*.yaml" -o -name "*.yml" | xargs kube-score score --output-format json > artifacts/kube-score.json || true
    else
        echo "[!] kube-score not found. Install: https://github.com/zegl/kube-score"
    fi
fi

# Dockerfile security scans
if echo "$DETECTED_LANGUAGES" | grep -q "dockerfile"; then
    echo "🐳 Dockerfile Security Scans"
    
    # Hadolint
    if command -v hadolint >/dev/null 2>&1; then
        echo "[+] Hadolint (Dockerfile analysis)"
        find . -name "Dockerfile*" -exec hadolint {} \; > artifacts/hadolint.txt || true
    else
        echo "[!] hadolint not found. Install: https://github.com/hadolint/hadolint"
    fi
fi

# Generate comprehensive report
echo ""
echo "📊 Step 4: Generating Security Report"

# Create summary report
cat > artifacts/security_summary.md << EOF
# Security Audit Summary

**Scan Date:** $(date)
**Languages Detected:** $DETECTED_LANGUAGES
**Total Artifacts:** $(find artifacts -name "*.sarif" -o -name "*.json" -o -name "*.txt" | wc -l)

## Scan Results

### Universal Scans
- ✅ Gitleaks (Secrets Detection)
- ✅ Semgrep (Universal SAST)
- ✅ Trivy (Filesystem & Container Security)
- ✅ Syft (SBOM Generation)

### Language-Specific Scans
$(for lang in $DETECTED_LANGUAGES; do
    echo "- ✅ $lang security scans completed"
done)

## Artifacts Generated
$(ls -la artifacts/ | grep -E "\.(sarif|json|txt)$" | awk '{print "- " $9 " (" $5 " bytes)"}')

## Next Steps
1. Review all SARIF files in your security dashboard
2. Address high and critical findings
3. Integrate security scans into CI/CD pipeline
4. Set up automated security monitoring

EOF

echo "✅ Multi-Language Security Audit Complete!"
echo "📁 Artifacts saved to: ./artifacts/"
echo "📊 Summary report: ./artifacts/security_summary.md"
echo ""
echo "🔍 Detected Languages: $DETECTED_LANGUAGES"
echo "📈 Total Security Tools Used: $(find artifacts -name "*.sarif" -o -name "*.json" -o -name "*.txt" | wc -l)"
