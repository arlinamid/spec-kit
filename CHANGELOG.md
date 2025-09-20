# Changelog

All notable changes to this project will be documented in this file.

## [0.1.4] - 2025-09-20

### Fixed
- **Plan Template Documentation**: Fixed missing security research files in plan template documentation structure
- **Template Consistency**: Updated plan template to accurately reflect all files created by setup scripts
- **Phase Documentation**: Added security-research.md and security-architecture.md to Phase 0 and Phase 1 outputs
- **Prerequisites**: Updated Phase 1 prerequisites to require both research.md and security-research.md

### Enhanced
- **Documentation Structure**: Plan template now shows complete file structure including all security research files
- **Workflow Clarity**: Phase descriptions now accurately reflect the security-enhanced workflow
- **Template Propagation**: All AI agent packages updated with corrected plan template

## [0.1.3] - 2025-09-20

### Fixed
- **Security Research File Generation**: Fixed missing `research.md` and `security-research.md` file creation in setup scripts
- **Template Integration**: Added missing research templates that were referenced in security-enhanced workflow
- **Script Updates**: Updated `setup-plan.sh` and `setup-plan.ps1` to automatically create research files from templates

### Added
- **Research Template**: New `research-template.md` for general technical research documentation
- **Security Research Template**: New `security-research-template.md` for security-specific research and threat modeling
- **Template Propagation**: All AI agent packages (Claude, Copilot, Gemini) now include the new research templates

### Changed
- **Setup Scripts**: Enhanced to create both `research.md` and `security-research.md` during plan setup
- **Package Structure**: All release packages updated with new templates and scripts

### Technical Details
- Scripts now properly generate research files during Phase 0 of the security-enhanced workflow
- Templates provide comprehensive structures for technical and security research
- All AI agent packages synchronized with latest templates and scripts

## [0.1.2] - 2025-09-20

### Added
- **Multi-Language Security Support**: Comprehensive security scanning for 15+ programming languages
- **Automatic Language Detection**: Intelligent detection and tool selection based on project languages
- **Enhanced Security Tools**: 50+ security tools across all supported languages
- **AI-Driven Security Templates**: Security-enhanced spec, plan, and task templates
- **Comprehensive Documentation**: Language-specific security guides and best practices

### Enhanced
- **Security Workflow**: Security-first approach with integrated threat modeling
- **CI/CD Integration**: Advanced GitHub Actions workflows with language detection
- **Compliance Mapping**: OWASP, NIST, ISO, SOC 2, GDPR, HIPAA, PCI DSS support
- **Risk Assessment**: CVSS v4.0 scoring and comprehensive risk management

## [0.1.1] - 2025-09-20

### Added
- **Vulnerability Audit Module**: Drop-in security auditing solution
- **Security Templates**: OWASP ASVS-mapped security checklists
- **Multi-Language Support**: Security scanning for Python, JavaScript, Go, Rust, Java, C#, C/C++, PHP, Ruby
- **CI/CD Integration**: GitHub Actions workflows for automated security scanning
- **Pre-commit Hooks**: Client-side security checks

## [0.1.0] - 2025-09-20

### Added
- **Spec-Driven Development Framework**: Core SDD methodology implementation
- **Multi-Agent Support**: Templates for Claude, GitHub Copilot, and Gemini AI assistants
- **Cross-Platform Scripts**: PowerShell and Bash scripts for Windows and Unix systems
- **Constitution System**: Development principles enforcement
- **Template System**: Comprehensive templates for specs, plans, and tasks