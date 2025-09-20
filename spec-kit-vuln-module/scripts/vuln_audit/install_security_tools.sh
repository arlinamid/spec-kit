#!/usr/bin/env bash
set -euo pipefail

# Multi-Language Security Tools Installation Script
# Installs comprehensive security scanning tools for all supported languages

echo "🔧 Installing Multi-Language Security Tools"
echo "=========================================="

# Detect operating system
OS=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)

echo "🖥️  Detected OS: $OS"
echo "🏗️  Detected Architecture: $ARCH"

# Create tools directory
mkdir -p ~/.local/bin
export PATH="$HOME/.local/bin:$PATH"

# Universal tools (work for all languages)
echo ""
echo "🌐 Installing Universal Security Tools"

# Gitleaks (secrets detection)
if ! command -v gitleaks >/dev/null 2>&1; then
    echo "[+] Installing Gitleaks..."
    curl -s https://raw.githubusercontent.com/gitleaks/gitleaks/master/install.sh | bash
    sudo mv gitleaks /usr/local/bin/ || mv gitleaks ~/.local/bin/
else
    echo "  ✅ Gitleaks already installed"
fi

# Semgrep (universal SAST)
if ! command -v semgrep >/dev/null 2>&1; then
    echo "[+] Installing Semgrep..."
    curl -sL https://github.com/returntocorp/semgrep/releases/latest/download/semgrep-${OS}-${ARCH} -o /tmp/semgrep
    chmod +x /tmp/semgrep
    sudo mv /tmp/semgrep /usr/local/bin/semgrep || mv /tmp/semgrep ~/.local/bin/semgrep
else
    echo "  ✅ Semgrep already installed"
fi

# Trivy (container and filesystem security)
if ! command -v trivy >/dev/null 2>&1; then
    echo "[+] Installing Trivy..."
    curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin
else
    echo "  ✅ Trivy already installed"
fi

# Syft (SBOM generation)
if ! command -v syft >/dev/null 2>&1; then
    echo "[+] Installing Syft..."
    curl -sL https://github.com/anchore/syft/releases/latest/download/syft_${OS}_${ARCH}.tar.gz | tar -xz
    sudo mv syft /usr/local/bin/ || mv syft ~/.local/bin/
else
    echo "  ✅ Syft already installed"
fi

# Language-specific tools
echo ""
echo "🐍 Installing Python Security Tools"

# Python tools
if command -v pip >/dev/null 2>&1; then
    echo "[+] Installing Python security tools..."
    pip install --user bandit pip-audit safety semgrep
    echo "  ✅ Python tools installed"
else
    echo "  ❌ pip not found, skipping Python tools"
fi

# Node.js/JavaScript tools
echo ""
echo "🟨 Installing JavaScript/TypeScript Security Tools"

if command -v npm >/dev/null 2>&1; then
    echo "[+] Installing Node.js security tools..."
    npm install -g audit-ci eslint-plugin-security
    echo "  ✅ JavaScript/TypeScript tools installed"
else
    echo "  ❌ npm not found, skipping JavaScript/TypeScript tools"
fi

# Go tools
echo ""
echo "🐹 Installing Go Security Tools"

if command -v go >/dev/null 2>&1; then
    echo "[+] Installing Go security tools..."
    go install github.com/securecodewarrior/gosec/v2/cmd/gosec@latest
    go install golang.org/x/vuln/cmd/govulncheck@latest
    go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
    echo "  ✅ Go tools installed"
else
    echo "  ❌ Go not found, skipping Go tools"
fi

# Rust tools
echo ""
echo "🦀 Installing Rust Security Tools"

if command -v cargo >/dev/null 2>&1; then
    echo "[+] Installing Rust security tools..."
    cargo install cargo-audit cargo-deny
    echo "  ✅ Rust tools installed"
else
    echo "  ❌ Cargo not found, skipping Rust tools"
fi

# Java tools
echo ""
echo "☕ Installing Java Security Tools"

if command -v java >/dev/null 2>&1; then
    echo "[+] Installing Java security tools..."
    # SpotBugs
    wget -q https://github.com/spotbugs/spotbugs/releases/latest/download/spotbugs.zip
    unzip -q spotbugs.zip
    sudo mv spotbugs /opt/ || mv spotbugs ~/.local/
    rm spotbugs.zip
    
    # OWASP Dependency Check
    wget -q https://github.com/jeremylong/DependencyCheck/releases/latest/download/dependency-check-8.4.0-release.zip
    unzip -q dependency-check-8.4.0-release.zip
    sudo mv dependency-check /opt/ || mv dependency-check ~/.local/
    rm dependency-check-8.4.0-release.zip
    
    echo "  ✅ Java tools installed"
else
    echo "  ❌ Java not found, skipping Java tools"
fi

# C# tools
echo ""
echo "🔷 Installing C# Security Tools"

if command -v dotnet >/dev/null 2>&1; then
    echo "[+] Installing C# security tools..."
    dotnet tool install --global security-scan
    dotnet tool install --global dotnet-outdated
    echo "  ✅ C# tools installed"
else
    echo "  ❌ .NET not found, skipping C# tools"
fi

# C/C++ tools
echo ""
echo "⚙️ Installing C/C++ Security Tools"

if command -v gcc >/dev/null 2>&1 || command -v clang >/dev/null 2>&1; then
    echo "[+] Installing C/C++ security tools..."
    
    # cppcheck
    if [ "$OS" = "linux" ]; then
        sudo apt-get update && sudo apt-get install -y cppcheck
    elif [ "$OS" = "darwin" ]; then
        brew install cppcheck
    fi
    
    # flawfinder
    pip install --user flawfinder
    
    # clang-tidy
    if [ "$OS" = "linux" ]; then
        sudo apt-get install -y clang-tidy
    elif [ "$OS" = "darwin" ]; then
        brew install llvm
    fi
    
    echo "  ✅ C/C++ tools installed"
else
    echo "  ❌ C/C++ compiler not found, skipping C/C++ tools"
fi

# PHP tools
echo ""
echo "🐘 Installing PHP Security Tools"

if command -v php >/dev/null 2>&1; then
    echo "[+] Installing PHP security tools..."
    composer global require squizlabs/php_codesniffer
    composer global require phpstan/phpstan
    echo "  ✅ PHP tools installed"
else
    echo "  ❌ PHP not found, skipping PHP tools"
fi

# Ruby tools
echo ""
echo "💎 Installing Ruby Security Tools"

if command -v ruby >/dev/null 2>&1; then
    echo "[+] Installing Ruby security tools..."
    gem install brakeman bundler-audit rubocop
    echo "  ✅ Ruby tools installed"
else
    echo "  ❌ Ruby not found, skipping Ruby tools"
fi

# Shell tools
echo ""
echo "🐚 Installing Shell Security Tools"

if [ "$OS" = "linux" ]; then
    sudo apt-get install -y shellcheck
elif [ "$OS" = "darwin" ]; then
    brew install shellcheck
fi

# PowerShell tools
echo ""
echo "💻 Installing PowerShell Security Tools"

if command -v pwsh >/dev/null 2>&1; then
    echo "[+] Installing PowerShell security tools..."
    pwsh -Command "Install-Module -Name PSScriptAnalyzer -Force"
    echo "  ✅ PowerShell tools installed"
else
    echo "  ❌ PowerShell not found, skipping PowerShell tools"
fi

# YAML tools
echo ""
echo "📄 Installing YAML Security Tools"

pip install --user yamllint
if command -v kubectl >/dev/null 2>&1; then
    # kube-score for Kubernetes YAML
    wget -q https://github.com/zegl/kube-score/releases/latest/download/kube-score_${OS}_${ARCH}.tar.gz
    tar -xzf kube-score_${OS}_${ARCH}.tar.gz
    sudo mv kube-score /usr/local/bin/ || mv kube-score ~/.local/bin/
    rm kube-score_${OS}_${ARCH}.tar.gz
fi

# Dockerfile tools
echo ""
echo "🐳 Installing Dockerfile Security Tools"

# Hadolint
wget -q https://github.com/hadolint/hadolint/releases/latest/download/hadolint-${OS}-${ARCH}
chmod +x hadolint-${OS}-${ARCH}
sudo mv hadolint-${OS}-${ARCH} /usr/local/bin/hadolint || mv hadolint-${OS}-${ARCH} ~/.local/bin/hadolint

# Dockerfile lint
npm install -g dockerfile-lint

echo "  ✅ Dockerfile tools installed"

# Create tool verification script
echo ""
echo "🔍 Creating Tool Verification Script"

cat > ~/.local/bin/verify-security-tools.sh << 'EOF'
#!/usr/bin/env bash
echo "🔍 Verifying Security Tools Installation"
echo "========================================"

tools=(
    "gitleaks:Secrets Detection"
    "semgrep:Universal SAST"
    "trivy:Container Security"
    "syft:SBOM Generation"
    "bandit:Python SAST"
    "pip-audit:Python Dependencies"
    "safety:Python Dependencies"
    "audit-ci:Node.js Dependencies"
    "gosec:Go Security"
    "govulncheck:Go Vulnerabilities"
    "cargo-audit:Rust Dependencies"
    "cargo-deny:Rust Security"
    "spotbugs:Java Static Analysis"
    "security-scan:C# Security"
    "cppcheck:C/C++ Static Analysis"
    "flawfinder:C/C++ Security"
    "phpcs:PHP Code Analysis"
    "brakeman:Ruby Security"
    "bundler-audit:Ruby Dependencies"
    "shellcheck:Shell Script Analysis"
    "hadolint:Dockerfile Analysis"
    "yamllint:YAML Analysis"
)

for tool_info in "${tools[@]}"; do
    tool=$(echo "$tool_info" | cut -d: -f1)
    description=$(echo "$tool_info" | cut -d: -f2)
    
    if command -v "$tool" >/dev/null 2>&1; then
        echo "  ✅ $tool ($description)"
    else
        echo "  ❌ $tool ($description) - NOT FOUND"
    fi
done

echo ""
echo "🎯 Installation Summary"
echo "======================"
echo "Total tools checked: ${#tools[@]}"
echo "Installed tools: $(for tool_info in "${tools[@]}"; do tool=$(echo "$tool_info" | cut -d: -f1); if command -v "$tool" >/dev/null 2>&1; then echo "$tool"; fi; done | wc -l)"
echo ""
echo "📚 Next Steps:"
echo "1. Run: ./scripts/vuln_audit/run_multi_language_scans.sh"
echo "2. Check: ~/.local/bin/verify-security-tools.sh"
echo "3. Review: Language-specific security guides"
EOF

chmod +x ~/.local/bin/verify-security-tools.sh

echo ""
echo "✅ Multi-Language Security Tools Installation Complete!"
echo ""
echo "📊 Installation Summary:"
echo "========================"
echo "🌐 Universal Tools: Gitleaks, Semgrep, Trivy, Syft"
echo "🐍 Python: Bandit, pip-audit, Safety"
echo "🟨 JavaScript/TypeScript: audit-ci, eslint-plugin-security"
echo "🐹 Go: gosec, govulncheck, golangci-lint"
echo "🦀 Rust: cargo-audit, cargo-deny"
echo "☕ Java: SpotBugs, OWASP Dependency Check"
echo "🔷 C#: security-scan, dotnet-outdated"
echo "⚙️ C/C++: cppcheck, flawfinder, clang-tidy"
echo "🐘 PHP: phpcs, phpstan"
echo "💎 Ruby: brakeman, bundler-audit, rubocop"
echo "🐚 Shell: shellcheck"
echo "💻 PowerShell: PSScriptAnalyzer"
echo "📄 YAML: yamllint, kube-score"
echo "🐳 Dockerfile: hadolint, dockerfile-lint"
echo ""
echo "🔍 Verify installation: ~/.local/bin/verify-security-tools.sh"
echo "🚀 Run security scans: ./scripts/vuln_audit/run_multi_language_scans.sh"
echo ""
echo "📚 Documentation:"
echo "- Language Security Guides: templates/vuln_audit/LANGUAGE_SECURITY_GUIDES.md"
echo "- Multi-language scanning: scripts/vuln_audit/run_multi_language_scans.sh"
echo "- Language detection: scripts/vuln_audit/language_detector.py"
