# Changelog

All notable changes to this project will be documented in this file.

## [0.1.0] - 2025-01-20

### 🚀 Major Security Enhancements

#### ✨ New Features
- **AI-Driven Security Analysis**: Automatic threat modeling and security level determination
- **Security-First Templates**: Enhanced spec, plan, and task templates with built-in security controls
- **Vulnerability Auditing**: Integrated security scanning with industry-standard tools
- **Compliance Mapping**: Support for OWASP ASVS, NIST SSDF, and security frameworks
- **Security Testing**: Automated security test generation and execution
- **Risk Assessment**: CVSS v4.0 scoring and risk prioritization

#### 🔧 Security Tools Integration
- **SAST/SCA**: Semgrep, CodeQL, Bandit, pip-audit
- **Secrets Detection**: Gitleaks, detect-secrets
- **Container Security**: Trivy for container and filesystem scanning
- **SBOM Generation**: CycloneDX SBOM with Syft
- **Pre-commit Hooks**: Automated security checks before commits

#### 📋 Enhanced Templates
- **Spec Template**: AI security analysis, threat modeling, security requirements, data classification
- **Plan Template**: Security architecture, security dependencies, security goals and constraints
- **Tasks Template**: Security-first task ordering, security setup, security testing, security integration

#### 🛠️ Script Enhancements
- **Common Scripts**: Added security file paths (`SECURITY_RESEARCH`, `SECURITY_ARCHITECTURE`)
- **Prerequisites Scripts**: Now checks for security files (`security-research.md`, `security-architecture.md`)
- **Agent Context Scripts**: Extract security context from plans for AI assistants
- **Cross-Platform Support**: Enhanced PowerShell and Bash scripts

#### 📦 Package Updates
- **Gemini Package**: Complete security-enhanced framework for Gemini CLI
- **Claude Package**: Complete security-enhanced framework for Claude Code
- **Copilot Package**: Complete security-enhanced framework for GitHub Copilot
- **Package READMEs**: Comprehensive documentation for each package

#### 🔄 Workflow Improvements
- **Security-First Development**: Security controls prioritized throughout development lifecycle
- **AI Security Integration**: Automatic security analysis and recommendations
- **Compliance Support**: Built-in support for security frameworks and standards
- **Risk Management**: Proactive security controls and monitoring

### 🐛 Bug Fixes
- Fixed template redundancy issues
- Improved script error handling
- Enhanced cross-platform compatibility

### 📚 Documentation
- Updated main README with security features
- Added comprehensive package documentation
- Enhanced security workflow documentation
- Added security tools integration guide

### 🔧 Technical Improvements
- Cleaned up redundant templates
- Synchronized package-specific scripts
- Enhanced error handling and validation
- Improved cross-platform support

---

## [0.0.2] - Previous Release

### Features
- Initial Windows PowerShell support
- Cross-platform script compatibility
- Basic Spec-Driven Development framework

---

**Full Changelog**: https://github.com/arlinamid/spec-kit/compare/v0.0.2...v0.1.0
