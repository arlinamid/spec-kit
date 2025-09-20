# Security Research: [FEATURE NAME]

**Branch**: `[###-feature-name]` | **Date**: [DATE] | **Security Level**: [LOW/MEDIUM/HIGH/CRITICAL]

## Security Context
**Feature**: [Brief description of the feature]
**Security Level**: [LOW/MEDIUM/HIGH/CRITICAL] (inherited from spec)
**Data Sensitivity**: [Public/Internal/Confidential/Restricted]
**Compliance Requirements**: [GDPR/HIPAA/PCI-DSS/SOC2/ISO27001/None]

## Threat Model
### Primary Threats
- **[Threat 1]**: [Description and impact]
- **[Threat 2]**: [Description and impact]
- **[Threat 3]**: [Description and impact]

### Attack Vectors
- **[Vector 1]**: [How attackers might exploit this]
- **[Vector 2]**: [How attackers might exploit this]
- **[Vector 3]**: [How attackers might exploit this]

### Trust Boundaries
- **[Boundary 1]**: [What separates trusted from untrusted]
- **[Boundary 2]**: [What separates trusted from untrusted]

## Security Requirements Analysis
### Authentication & Authorization
- **Authentication Method**: [How users will be authenticated]
- **Authorization Model**: [How access will be controlled]
- **Session Management**: [How sessions will be handled]

### Data Protection
- **Data at Rest**: [Encryption requirements for stored data]
- **Data in Transit**: [Encryption requirements for network communication]
- **Data Processing**: [How sensitive data will be processed]

### Input Validation & Sanitization
- **Input Sources**: [Where user input comes from]
- **Validation Strategy**: [How inputs will be validated]
- **Sanitization Approach**: [How inputs will be sanitized]

## Security Controls
### Preventive Controls
- **[Control 1]**: [Description and implementation]
- **[Control 2]**: [Description and implementation]
- **[Control 3]**: [Description and implementation]

### Detective Controls
- **[Control 1]**: [Monitoring and logging approach]
- **[Control 2]**: [Anomaly detection strategy]
- **[Control 3]**: [Audit trail requirements]

### Responsive Controls
- **[Control 1]**: [Incident response procedures]
- **[Control 2]**: [Recovery mechanisms]
- **[Control 3]**: [Communication protocols]

## Security Tools & Frameworks
### Static Analysis
- **SAST Tools**: [Bandit, Semgrep, CodeQL, etc.]
- **Dependency Scanning**: [pip-audit, npm audit, etc.]
- **Secret Detection**: [Gitleaks, detect-secrets]

### Dynamic Analysis
- **DAST Tools**: [OWASP ZAP, Burp Suite]
- **Container Scanning**: [Trivy, Snyk]
- **Infrastructure Scanning**: [Terraform security checks]

### Security Testing
- **Unit Tests**: [Security-focused unit tests]
- **Integration Tests**: [Security integration tests]
- **Penetration Testing**: [Manual security testing]

## Compliance Mapping
### OWASP ASVS
- **Category 2**: Authentication
- **Category 5**: Input Validation
- **Category 8**: Data Protection
- **Category 7**: Logging and Monitoring

### NIST Cybersecurity Framework
- **Identify**: [Asset management, risk assessment]
- **Protect**: [Access control, data security]
- **Detect**: [Anomaly detection, continuous monitoring]
- **Respond**: [Response planning, communications]
- **Recover**: [Recovery planning, improvements]

### Industry Standards
- **[Standard 1]**: [Relevant requirements]
- **[Standard 2]**: [Relevant requirements]

## Risk Assessment
### High-Risk Areas
- **[Area 1]**: [Risk description and mitigation]
- **[Area 2]**: [Risk description and mitigation]

### Medium-Risk Areas
- **[Area 1]**: [Risk description and mitigation]
- **[Area 2]**: [Risk description and mitigation]

### Low-Risk Areas
- **[Area 1]**: [Risk description and mitigation]

## Security Architecture Decisions
### Security Patterns
- **[Pattern 1]**: [Security pattern to be used]
- **[Pattern 2]**: [Security pattern to be used]

### Security Services
- **[Service 1]**: [Security service requirements]
- **[Service 2]**: [Security service requirements]

### Security Infrastructure
- **[Component 1]**: [Security infrastructure needs]
- **[Component 2]**: [Security infrastructure needs]

## Implementation Notes
### Security-First Approach
- Security controls MUST be implemented before feature development
- Security testing MUST be included in the development cycle
- Security reviews MUST be conducted at each phase

### Security Dependencies
- **[Dependency 1]**: [Security dependency and impact]
- **[Dependency 2]**: [Security dependency and impact]

### Security Constraints
- **[Constraint 1]**: [Security constraint and workaround]
- **[Constraint 2]**: [Security constraint and workaround]

## Next Steps
1. **Review**: Security team review of this research
2. **Approval**: Security architecture approval
3. **Implementation**: Begin security control implementation
4. **Testing**: Security testing strategy execution
5. **Monitoring**: Security monitoring setup

## References
- [OWASP ASVS](https://owasp.org/www-project-application-security-verification-standard/)
- [NIST Cybersecurity Framework](https://www.nist.gov/cyberframework)
- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [Security by Design Principles](https://owasp.org/www-project-secure-coding-practices-quick-reference-guide/)

---
*Generated by spec-kit security research template v1.0*
