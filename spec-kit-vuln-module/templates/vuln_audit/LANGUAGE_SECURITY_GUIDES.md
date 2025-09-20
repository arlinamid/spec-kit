# Language-Specific Security Guides

This document provides comprehensive security guidelines for different programming languages, including common vulnerabilities, best practices, and tool recommendations.

## 🐍 Python Security

### Common Vulnerabilities
- **SQL Injection**: Use parameterized queries with SQLAlchemy/psycopg2
- **Code Injection**: Avoid `eval()`, `exec()`, `subprocess` with user input
- **Deserialization**: Use `pickle` carefully, prefer JSON for untrusted data
- **Path Traversal**: Validate file paths, use `os.path.join()`
- **Dependency Vulnerabilities**: Regular `pip-audit` and `safety` checks

### Security Tools
```bash
# Static Analysis
bandit -r . -f sarif -o bandit.sarif
semgrep --config=python . -o semgrep-python.sarif

# Dependency Scanning
pip-audit -r requirements.txt -f json -o pip-audit.json
safety check --json --output safety.json

# Runtime Security
python -m pydocstyle --security .
```

### Best Practices
- Use virtual environments (`venv`, `poetry`)
- Pin dependency versions in `requirements.txt`
- Implement input validation with `pydantic`
- Use HTTPS for all external connections
- Enable security headers with `django-security` or `flask-talisman`

## 🟨 JavaScript/TypeScript Security

### Common Vulnerabilities
- **XSS (Cross-Site Scripting)**: Sanitize user input, use CSP headers
- **Prototype Pollution**: Avoid `Object.assign()` with user input
- **Dependency Confusion**: Use private registries, verify package integrity
- **Insecure Deserialization**: Avoid `eval()`, use JSON.parse() carefully
- **Weak Authentication**: Implement proper JWT handling

### Security Tools
```bash
# Static Analysis
npm audit --json > npm-audit.json
yarn audit --json > yarn-audit.json
npx eslint-plugin-security . --format json

# Dependency Scanning
npm install -g audit-ci
audit-ci --config audit-ci.json

# Runtime Security
npx helmet --help  # Security headers
```

### Best Practices
- Use `helmet.js` for security headers
- Implement Content Security Policy (CSP)
- Use `express-rate-limit` for API protection
- Validate input with `joi` or `yup`
- Use `bcrypt` for password hashing

## 🐹 Go Security

### Common Vulnerabilities
- **Buffer Overflow**: Use bounds checking, avoid `unsafe` package
- **Race Conditions**: Use proper synchronization with `sync` package
- **Insecure Random**: Use `crypto/rand` instead of `math/rand`
- **SQL Injection**: Use prepared statements
- **Dependency Vulnerabilities**: Regular `govulncheck`

### Security Tools
```bash
# Static Analysis
gosec -fmt sarif -out gosec.sarif ./...
golangci-lint run --enable=gosec
semgrep --config=go . -o semgrep-go.sarif

# Vulnerability Scanning
govulncheck ./... > govulncheck.txt
gosec -fmt json -out gosec.json ./...

# Dependency Scanning
go list -json -m all | nancy sleuth
```

### Best Practices
- Use `gofmt` and `golint` for code quality
- Implement proper error handling
- Use `context` for cancellation and timeouts
- Validate all external inputs
- Use `crypto/tls` for secure connections

## 🦀 Rust Security

### Common Vulnerabilities
- **Memory Safety**: Rust prevents most memory issues, but beware of `unsafe` code
- **Panic Handling**: Use `Result<T, E>` instead of `panic!`
- **Integer Overflow**: Use checked arithmetic methods
- **Dependency Vulnerabilities**: Regular `cargo audit`

### Security Tools
```bash
# Static Analysis
cargo audit --json > cargo-audit.json
cargo deny check --format json > cargo-deny.json
cargo clippy -- -D warnings
semgrep --config=rust . -o semgrep-rust.sarif

# Dependency Scanning
cargo audit
cargo deny check
```

### Best Practices
- Use `cargo-audit` for dependency scanning
- Implement proper error handling with `Result`
- Use `serde` for safe serialization
- Validate all external inputs
- Use `tokio-tls` for secure networking

## ☕ Java Security

### Common Vulnerabilities
- **SQL Injection**: Use PreparedStatement, JPA/Hibernate
- **XSS**: Sanitize output, use OWASP Java Encoder
- **Deserialization**: Avoid `ObjectInputStream`, use JSON
- **Path Traversal**: Validate file paths, use `Path.normalize()`
- **Dependency Vulnerabilities**: Regular OWASP Dependency Check

### Security Tools
```bash
# Static Analysis
spotbugs -sarif -output spotbugs.sarif .
checkmarx scan --project "Java Project" --scan .
semgrep --config=java . -o semgrep-java.sarif

# Dependency Scanning
dependency-check.sh --project "Java Project" --scan . --format JSON
mvn org.owasp:dependency-check-maven:check
```

### Best Practices
- Use Spring Security for authentication/authorization
- Implement input validation with Bean Validation
- Use HTTPS for all communications
- Enable security headers with Spring Security
- Regular dependency updates with `mvn versions:display-dependency-updates`

## 🔷 C# Security

### Common Vulnerabilities
- **SQL Injection**: Use parameterized queries, Entity Framework
- **XSS**: Encode output, use AntiXSS library
- **Deserialization**: Avoid `BinaryFormatter`, use JSON.NET
- **Path Traversal**: Use `Path.GetFullPath()` and validation
- **Dependency Vulnerabilities**: Regular NuGet security scanning

### Security Tools
```bash
# Static Analysis
security-scan --format sarif --output security-scan.sarif .
semgrep --config=csharp . -o semgrep-csharp.sarif
sonarqube-scanner -Dsonar.projectKey=project

# Dependency Scanning
dotnet list package --vulnerable
nuget audit
```

### Best Practices
- Use ASP.NET Core security features
- Implement proper authentication with Identity
- Use HTTPS enforcement
- Validate all inputs with Data Annotations
- Regular security updates with `dotnet list package --outdated`

## ⚙️ C/C++ Security

### Common Vulnerabilities
- **Buffer Overflow**: Use bounds checking, avoid `strcpy()`
- **Memory Leaks**: Use RAII, smart pointers
- **Integer Overflow**: Use checked arithmetic
- **Format String**: Avoid `printf()` with user input
- **Use After Free**: Proper memory management

### Security Tools
```bash
# Static Analysis
cppcheck --enable=all --xml --xml-version=2 . 2> cppcheck.xml
clang-tidy --checks='*' --format-style=file
flawfinder --csv --output flawfinder.csv .
semgrep --config=cpp . -o semgrep-cpp.sarif

# Memory Analysis
valgrind --tool=memcheck ./program
AddressSanitizer (ASan) compilation
```

### Best Practices
- Use modern C++ features (C++11+)
- Implement RAII for resource management
- Use smart pointers (`std::unique_ptr`, `std::shared_ptr`)
- Validate all inputs and bounds
- Use secure coding practices (CERT C++)

## 🐘 PHP Security

### Common Vulnerabilities
- **SQL Injection**: Use PDO prepared statements
- **XSS**: Use `htmlspecialchars()`, Content Security Policy
- **File Upload**: Validate file types, scan for malware
- **Session Security**: Use secure session configuration
- **Dependency Vulnerabilities**: Regular Composer security scanning

### Security Tools
```bash
# Static Analysis
phpcs --standard=Security --report=json --report-file=phpcs-security.json .
psalm --security-analysis
semgrep --config=php . -o semgrep-php.sarif

# Dependency Scanning
composer audit
symfony security:check
```

### Best Practices
- Use modern PHP (8.0+)
- Implement proper input validation
- Use HTTPS for all communications
- Enable security headers
- Regular security updates

## 💎 Ruby Security

### Common Vulnerabilities
- **SQL Injection**: Use ActiveRecord, parameterized queries
- **XSS**: Use `html_safe`, Content Security Policy
- **Mass Assignment**: Use strong parameters
- **Dependency Vulnerabilities**: Regular `bundle audit`

### Security Tools
```bash
# Static Analysis
brakeman --format json --output brakeman.json .
bundle audit --format json > bundler-audit.json
rubocop --only Security
semgrep --config=ruby . -o semgrep-ruby.sarif
```

### Best Practices
- Use Rails security features
- Implement proper authentication with Devise
- Use HTTPS enforcement
- Regular security updates
- Use secure coding practices

## 🐚 Shell Script Security

### Common Vulnerabilities
- **Command Injection**: Quote variables, use `set -euo pipefail`
- **Path Traversal**: Validate file paths
- **Privilege Escalation**: Use least privilege principle
- **Insecure File Permissions**: Set proper file permissions

### Security Tools
```bash
# Static Analysis
shellcheck -f json *.sh > shellcheck.json
semgrep --config=shell . -o semgrep-shell.sarif
shfmt -d *.sh
```

### Best Practices
- Use `set -euo pipefail` at script start
- Quote all variables: `"$variable"`
- Validate all inputs
- Use `readonly` for constants
- Implement proper error handling

## 💻 PowerShell Security

### Common Vulnerabilities
- **Code Injection**: Avoid `Invoke-Expression` with user input
- **Path Traversal**: Validate file paths
- **Privilege Escalation**: Use least privilege principle
- **Insecure File Permissions**: Set proper file permissions

### Security Tools
```powershell
# Static Analysis
Invoke-ScriptAnalyzer -Path . -ReportFormat JSON
semgrep --config=powershell . -o semgrep-powershell.sarif
```

### Best Practices
- Use `Set-StrictMode -Version Latest`
- Validate all inputs with `ValidateScript`
- Use secure coding practices
- Implement proper error handling
- Use `ReadOnly` for constants

## 📄 YAML Security

### Common Vulnerabilities
- **YAML Injection**: Avoid `!!python/object` tags
- **Path Traversal**: Validate file paths in YAML
- **Insecure Deserialization**: Use safe YAML parsers
- **Kubernetes Security**: Misconfigured resources

### Security Tools
```bash
# Static Analysis
yamllint -f json *.yml > yamllint.json
kube-score score --output-format json *.yaml > kube-score.json
semgrep --config=yaml . -o semgrep-yaml.sarif
```

### Best Practices
- Use safe YAML parsers
- Validate YAML structure
- Use Kubernetes security best practices
- Implement proper RBAC
- Regular security scanning

## 🐳 Dockerfile Security

### Common Vulnerabilities
- **Base Image Vulnerabilities**: Use minimal, updated base images
- **Privilege Escalation**: Run as non-root user
- **Secrets in Images**: Use multi-stage builds, secrets management
- **Insecure Configurations**: Use security best practices

### Security Tools
```bash
# Static Analysis
hadolint Dockerfile > hadolint.txt
trivy config --format sarif --output trivy-dockerfile.sarif .
semgrep --config=dockerfile . -o semgrep-dockerfile.sarif
```

### Best Practices
- Use minimal base images (Alpine, Distroless)
- Run as non-root user
- Use multi-stage builds
- Implement proper secrets management
- Regular base image updates

## 🔧 Universal Security Practices

### All Languages
1. **Input Validation**: Validate all external inputs
2. **Output Encoding**: Encode output to prevent injection
3. **Authentication**: Implement strong authentication
4. **Authorization**: Use principle of least privilege
5. **Encryption**: Use encryption for sensitive data
6. **Logging**: Implement security logging
7. **Monitoring**: Set up security monitoring
8. **Updates**: Regular security updates
9. **Testing**: Security testing in CI/CD
10. **Documentation**: Document security practices

### Security Headers
```http
Content-Security-Policy: default-src 'self'
X-Frame-Options: DENY
X-Content-Type-Options: nosniff
X-XSS-Protection: 1; mode=block
Strict-Transport-Security: max-age=31536000; includeSubDomains
```

### Dependency Management
- Regular dependency updates
- Vulnerability scanning
- License compliance
- Supply chain security
- SBOM generation

---

**Remember**: Security is an ongoing process, not a one-time implementation. Regular security assessments, updates, and monitoring are essential for maintaining a secure codebase.
