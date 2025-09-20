# Spec Kit Multi-Language Vulnerability Audit Module

Comprehensive, multi-language vulnerability auditing for spec-kit projects. Supports 15+ programming languages with automated security scanning and compliance mapping.

## 🌟 Features

### 🔍 Multi-Language Support
- **15+ Languages**: Python, JavaScript, TypeScript, Go, Rust, Java, C#, C/C++, PHP, Ruby, Swift, Kotlin, Scala, Dart, Shell, PowerShell, YAML, Dockerfile
- **Automatic Detection**: AI-powered language detection and tool selection
- **Comprehensive Scanning**: 50+ security tools across all languages
- **Universal Coverage**: Works with any technology stack

### 🛡️ Security Capabilities
- **Automated Security Scanning**: Semgrep, CodeQL, Bandit, pip-audit, Gitleaks, Trivy, Syft
- **Language-Specific Tools**: gosec (Go), cargo-audit (Rust), spotbugs (Java), cppcheck (C/C++), brakeman (Ruby)
- **OWASP Compliance**: ASVS mapping, Top 10 coverage, threat modeling
- **CI/CD Integration**: GitHub Actions, Dependabot, pre-commit hooks
- **Security Standards**: CVSS v4.0, SLSA, CycloneDX SBOM
- **LLM Security**: OWASP LLM Top-10 compliance

### 🚀 Advanced Features
- **Intelligent Scanning**: Only runs relevant tools for detected languages
- **Parallel Execution**: Multi-language scans run concurrently
- **Comprehensive Reporting**: SARIF, JSON, and human-readable formats
- **Compliance Mapping**: Multiple security frameworks supported
- **Risk Assessment**: CVSS v4.0 scoring and prioritization

## 🚀 Quick Start

### 1. **Copy the Module**
```bash
cp -r spec-kit-vuln-module/ your-project/
cd your-project/
```

### 2. **Install Security Tools**
```bash
# Install all tools for detected languages
./scripts/vuln_audit/install_security_tools.sh

# Verify installation
~/.local/bin/verify-security-tools.sh
```

### 3. **Run Multi-Language Scans**
```bash
# Automatic language detection and scanning
./scripts/vuln_audit/run_multi_language_scans.sh

# Language-specific scanning
python3 scripts/vuln_audit/language_detector.py --output artifacts/languages.json
```

### 4. **Integrate with CI/CD**
```bash
# Copy GitHub Actions workflow
cp .github/workflows/security.yml your-project/.github/workflows/

# Enable Dependabot
cp .github/dependabot.yml your-project/.github/

# Add pre-commit hooks
cp .pre-commit-config.yaml your-project/
```

## 🔧 Supported Languages & Tools

### 🐍 Python
- **SAST**: Bandit, Semgrep, Safety
- **Dependencies**: pip-audit, Safety
- **Security**: Pydocstyle, Flake8-security

### 🟨 JavaScript/TypeScript
- **Dependencies**: npm audit, yarn audit
- **Security**: ESLint-plugin-security, audit-ci
- **Analysis**: Semgrep, CodeQL

### 🐹 Go
- **SAST**: gosec, golangci-lint
- **Vulnerabilities**: govulncheck
- **Dependencies**: nancy sleuth

### 🦀 Rust
- **Dependencies**: cargo-audit, cargo-deny
- **Security**: Clippy, Semgrep
- **Analysis**: CodeQL

### ☕ Java
- **SAST**: SpotBugs, Checkmarx
- **Dependencies**: OWASP Dependency Check
- **Security**: SonarQube, Semgrep

### 🔷 C#
- **SAST**: Security Code Scan, SonarQube
- **Dependencies**: NuGet audit
- **Security**: Semgrep, CodeQL

### ⚙️ C/C++
- **SAST**: cppcheck, clang-tidy, flawfinder
- **Security**: Semgrep, CodeQL
- **Memory**: AddressSanitizer, Valgrind

### 🐘 PHP
- **SAST**: PHPCS Security Audit, Psalm
- **Dependencies**: Composer audit
- **Security**: Semgrep

### 💎 Ruby
- **SAST**: Brakeman, RuboCop
- **Dependencies**: Bundler audit
- **Security**: Semgrep

### 🐚 Shell/PowerShell
- **Analysis**: ShellCheck, PSScriptAnalyzer
- **Security**: Semgrep
- **Best Practices**: Script validation

### 📄 YAML/Dockerfile
- **Analysis**: yamllint, kube-score, hadolint
- **Security**: Trivy, Semgrep
- **Compliance**: Kubernetes security

## 📋 Security Frameworks

### Compliance Standards
- **OWASP ASVS** - Application Security Verification Standard
- **OWASP Top 10** - Most Critical Web Application Security Risks
- **NIST SSDF** - Secure Software Development Framework
- **ISO 27001** - Information Security Management
- **SOC 2** - Service Organization Control
- **GDPR** - General Data Protection Regulation
- **HIPAA** - Health Insurance Portability and Accountability
- **PCI DSS** - Payment Card Industry Data Security Standard
- **CIS Controls** - Center for Internet Security Controls
- **NIST Cybersecurity Framework** - Cybersecurity Framework

### Security Tools by Category
- **SAST (Static Analysis)**: 20+ tools across all languages
- **SCA (Software Composition)**: 15+ dependency scanners
- **Secrets Detection**: Gitleaks, detect-secrets
- **Container Security**: Trivy, Hadolint, Dockerfile-lint
- **SBOM Generation**: Syft (CycloneDX), SPDX
- **Infrastructure**: Terraform security, Kubernetes security

## 📊 Usage Examples

### Language Detection
```bash
# Detect all languages in project
python3 scripts/vuln_audit/language_detector.py --output artifacts/languages.json

# Get detected languages
python3 -c "import json; data=json.load(open('artifacts/languages.json')); print(' '.join(data['project_info']['languages_detected']))"
```

### Multi-Language Scanning
```bash
# Run comprehensive security scan
./scripts/vuln_audit/run_multi_language_scans.sh

# Check results
ls -la artifacts/
cat artifacts/security_summary.md
```

### Language-Specific Scanning
```bash
# Python security
bandit -r . -f sarif -o artifacts/bandit.sarif
pip-audit -r requirements.txt -f json -o artifacts/pip-audit.json

# Go security
gosec -fmt sarif -out artifacts/gosec.sarif ./...
govulncheck ./... > artifacts/govulncheck.txt

# JavaScript security
npm audit --json > artifacts/npm-audit.json
yarn audit --json > artifacts/yarn-audit.json
```

## 📚 Templates & Documentation

### Security Templates
- `VULN_AUDIT_TEMPLATE.md` - Comprehensive security audit checklist
- `THREAT_MODEL_TEMPLATE.md` - STRIDE threat modeling framework
- `SECURE_CODING_CHECKLIST.md` - ASVS-mapped coding practices
- `LLM_SECURITY_GUIDE.md` - OWASP LLM Top-10 compliance
- `LANGUAGE_SECURITY_GUIDES.md` - Language-specific security practices
- `RISK_REGISTER.csv` - CVSS v4.0 risk tracking

### Documentation
- **Language Security Guides**: Comprehensive security practices for each language
- **Tool Documentation**: Installation and usage guides
- **Compliance Mapping**: Framework-specific requirements
- **Best Practices**: Security-first development practices

## 🔄 CI/CD Integration

### GitHub Actions
```yaml
# Multi-language security workflow
name: Multi-Language Security
on: [push, pull_request]
jobs:
  security:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Run multi-language security scans
        run: ./scripts/vuln_audit/run_multi_language_scans.sh
```

### Pre-commit Hooks
```yaml
# .pre-commit-config.yaml
repos:
  - repo: local
    hooks:
      - id: multi-language-security
        name: Multi-Language Security Scan
        entry: ./scripts/vuln_audit/run_multi_language_scans.sh
        language: system
        pass_filenames: false
```

## 🎯 Benefits

### For Development Teams
- **Comprehensive Coverage**: Security scanning for all languages in your project
- **Automated Detection**: No manual configuration required
- **Parallel Execution**: Fast scanning across multiple languages
- **Compliance Ready**: Built-in support for major security frameworks

### For Security Teams
- **Centralized Scanning**: Single tool for all languages
- **Standardized Reports**: Consistent SARIF and JSON outputs
- **Risk Prioritization**: CVSS v4.0 scoring and ranking
- **Compliance Mapping**: Framework-specific requirements

### For DevOps Teams
- **CI/CD Integration**: Seamless GitHub Actions integration
- **Container Security**: Dockerfile and container scanning
- **Infrastructure Security**: YAML and configuration scanning
- **SBOM Generation**: Software Bill of Materials for compliance

## 🔧 Advanced Configuration

### Custom Language Detection
```python
# scripts/vuln_audit/language_detector.py
detector = LanguageDetector(project_root=".")
config = detector.generate_scan_config()
```

### Custom Security Tools
```bash
# Add custom tools to scanning
echo "custom-tool" >> scripts/vuln_audit/run_multi_language_scans.sh
```

### Compliance Mapping
```yaml
# config/project_meta.yaml
security_frameworks:
  - OWASP_ASVS
  - NIST_SSDF
  - ISO_27001
compliance_requirements:
  - data_protection
  - privacy_by_design
  - security_by_design
```

## 📈 Performance

- **Parallel Execution**: Multi-language scans run concurrently
- **Intelligent Caching**: Only scan changed files
- **Incremental Scanning**: Skip unchanged languages
- **Resource Optimization**: Minimal memory and CPU usage

## 🔒 Security

- **Secure by Design**: All tools run in isolated environments
- **No Data Collection**: All scanning happens locally
- **Open Source**: Transparent and auditable code
- **Regular Updates**: Automatic security tool updates

---

**Built for modern, multi-language development with comprehensive security coverage.**