# Tasks: [FEATURE NAME] (Security-Enhanced)

**Input**: Design documents from `/specs/[###-feature-name]/`
**Prerequisites**: plan.md (required), research.md, security-research.md, data-model.md, security-architecture.md, contracts/
**Security Level**: [LOW/MEDIUM/HIGH/CRITICAL] (inherited from plan)

## Execution Flow (main)
```
1. Load plan.md from feature directory
   → If not found: ERROR "No implementation plan found"
   → Extract: tech stack, libraries, structure, security requirements
2. Load optional design documents:
   → data-model.md: Extract entities → model tasks
   → security-architecture.md: Extract security requirements → security tasks
   → contracts/: Each file → contract test task
   → research.md: Extract decisions → setup tasks
   → security-research.md: Extract security decisions → security setup tasks
3. Generate tasks by category:
   → Setup: project init, dependencies, linting, security tools
   → Security Setup: authentication, authorization, encryption, monitoring
   → Tests: contract tests, integration tests, security tests
   → Core: models, services, CLI commands
   → Security Core: security modules, security services
   → Integration: DB, middleware, logging, security middleware
   → Security Integration: security monitoring, incident response
   → Polish: unit tests, performance, docs, security documentation
4. Apply task rules:
   → Different files = mark [P] for parallel
   → Same file = sequential (no [P])
   → Tests before implementation (TDD)
   → Security controls before features
5. Number tasks sequentially (T001, T002...)
6. Generate dependency graph
7. Create parallel execution examples
8. Validate task completeness:
   → All contracts have tests?
   → All entities have models?
   → All endpoints implemented?
   → All security requirements implemented?
9. Return: SUCCESS (tasks ready for execution)
```

## Format: `[ID] [P?] Description`
- **[P]**: Can run in parallel (different files, no dependencies)
- Include exact file paths in descriptions
- **[S]**: Security-specific task
- **[C]**: Compliance-specific task

## Path Conventions
- **Single project**: `src/`, `tests/` at repository root
- **Web app**: `backend/src/`, `frontend/src/`
- **Mobile**: `api/src/`, `ios/src/` or `android/src/`
- **Security modules**: `src/security/`, `tests/security/`
- Paths shown below assume single project - adjust based on plan.md structure

## Phase 3.1: Setup
- [ ] T001 Create project structure per implementation plan
- [ ] T002 Initialize [language] project with [framework] dependencies
- [ ] T003 [P] Configure linting and formatting tools
- [ ] T004 [S] [P] Configure security scanning tools (Bandit, Semgrep, Trivy)
- [ ] T005 [S] [P] Setup security monitoring and logging infrastructure
- [ ] T006 [S] [P] Configure authentication and authorization framework

## Phase 3.2: Security Foundation (Security-First Approach)
**CRITICAL: Security controls MUST be implemented before any feature development**
- [ ] T007 [S] [P] Implement authentication service in src/security/auth/
- [ ] T008 [S] [P] Implement authorization service in src/security/authorization/
- [ ] T009 [S] [P] Implement encryption service in src/security/encryption/
- [ ] T010 [S] [P] Implement input validation service in src/security/validation/
- [ ] T011 [S] [P] Implement security monitoring service in src/security/monitoring/
- [ ] T012 [S] [P] Setup security test framework in tests/security/

## Phase 3.3: Tests First (TDD) ⚠️ MUST COMPLETE BEFORE 3.4
**CRITICAL: These tests MUST be written and MUST FAIL before ANY implementation**
- [ ] T013 [P] Contract test POST /api/users in tests/contract/test_users_post.py
- [ ] T014 [P] Contract test GET /api/users/{id} in tests/contract/test_users_get.py
- [ ] T015 [P] Integration test user registration in tests/integration/test_registration.py
- [ ] T016 [P] Integration test auth flow in tests/integration/test_auth.py
- [ ] T017 [S] [P] Security test authentication bypass in tests/security/test_auth_bypass.py
- [ ] T018 [S] [P] Security test injection attacks in tests/security/test_injection.py
- [ ] T019 [S] [P] Security test authorization bypass in tests/security/test_authz_bypass.py
- [ ] T020 [S] [P] Security test data exposure in tests/security/test_data_exposure.py

## Phase 3.4: Core Implementation (ONLY after tests are failing)
- [ ] T021 [P] User model in src/models/user.py
- [ ] T022 [P] UserService CRUD in src/services/user_service.py
- [ ] T023 [P] CLI --create-user in src/cli/user_commands.py
- [ ] T024 POST /api/users endpoint
- [ ] T025 GET /api/users/{id} endpoint
- [ ] T026 Input validation
- [ ] T027 Error handling and logging
- [ ] T028 [S] [P] Security middleware implementation in src/security/middleware/
- [ ] T029 [S] [P] Security headers implementation in src/security/headers/
- [ ] T030 [S] [P] Rate limiting implementation in src/security/rate_limiting/

## Phase 3.5: Security Integration
- [ ] T031 [S] Connect UserService to security services
- [ ] T032 [S] Implement security logging and monitoring
- [ ] T033 [S] Implement security event alerting
- [ ] T034 [S] Connect security services to external monitoring
- [ ] T035 [S] Implement security incident response procedures
- [ ] T036 [S] Implement security audit trails

## Phase 3.6: Integration
- [ ] T037 Connect UserService to DB
- [ ] T038 Auth middleware
- [ ] T039 Request/response logging
- [ ] T040 CORS and security headers
- [ ] T041 [S] Security middleware integration
- [ ] T042 [S] Security monitoring integration

## Phase 3.7: Security Testing
- [ ] T043 [S] [P] Penetration testing setup in tests/security/penetration/
- [ ] T044 [S] [P] Vulnerability scanning setup in tests/security/vulnerability/
- [ ] T045 [S] [P] Compliance testing setup in tests/security/compliance/
- [ ] T046 [S] [P] Security performance testing in tests/security/performance/
- [ ] T047 [S] [P] Security regression testing in tests/security/regression/

## Phase 3.8: Polish
- [ ] T048 [P] Unit tests for validation in tests/unit/test_validation.py
- [ ] T049 [P] Unit tests for security in tests/unit/test_security.py
- [ ] T050 Performance tests (<200ms)
- [ ] T051 [S] Security performance tests (<100ms auth response)
- [ ] T052 [P] Update docs/api.md
- [ ] T053 [S] [P] Update security documentation in docs/security/
- [ ] T054 [S] [P] Create security runbook in docs/security/runbook.md
- [ ] T055 [S] [P] Create incident response procedures in docs/security/incident-response.md
- [ ] T056 Remove duplication
- [ ] T057 Run manual-testing.md
- [ ] T058 [S] Run security-testing.md

## Security-Specific Dependencies
- Security setup (T007-T012) before any feature development
- Security tests (T017-T020) before implementation
- Security middleware (T028-T030) before feature integration
- Security integration (T031-T036) before general integration
- Security testing (T043-T047) before polish phase

## Dependencies
- Tests (T013-T020) before implementation (T021-T030)
- Security setup (T007-T012) before all other tasks
- T021 blocks T022, T037
- T028 blocks T040
- T031 blocks T041
- Implementation before polish (T048-T058)

## Parallel Example
```
# Launch T013-T020 together (all tests):
Task: "Contract test POST /api/users in tests/contract/test_users_post.py"
Task: "Contract test GET /api/users/{id} in tests/contract/test_users_get.py"
Task: "Integration test registration in tests/integration/test_registration.py"
Task: "Integration test auth in tests/integration/test_auth.py"
Task: "Security test authentication bypass in tests/security/test_auth_bypass.py"
Task: "Security test injection attacks in tests/security/test_injection.py"
Task: "Security test authorization bypass in tests/security/test_authz_bypass.py"
Task: "Security test data exposure in tests/security/test_data_exposure.py"
```

## Notes
- [P] tasks = different files, no dependencies
- [S] tasks = security-specific, may have security dependencies
- [C] tasks = compliance-specific, may have compliance dependencies
- Verify tests fail before implementing
- Security controls before features (security-first approach)
- Commit after each task
- Avoid: vague tasks, same file conflicts
- Security tasks must be completed before feature tasks

## Task Generation Rules
*Applied during main() execution*

1. **From Contracts**:
   - Each contract file → contract test task [P]
   - Each endpoint → implementation task
   - Each security requirement → security test task [S]
   
2. **From Data Model**:
   - Each entity → model creation task [P]
   - Relationships → service layer tasks
   - Security attributes → security implementation tasks [S]
   
3. **From Security Architecture**:
   - Each security control → security implementation task [S]
   - Each security requirement → security test task [S]
   - Each compliance requirement → compliance task [C]
   
4. **From User Stories**:
   - Each story → integration test [P]
   - Each security story → security test [S]
   - Quickstart scenarios → validation tasks
   
5. **Ordering**:
   - Security setup → Tests → Security tests → Models → Security models → Services → Security services → Endpoints → Security endpoints → Polish → Security polish
   - Dependencies block parallel execution
   - Security tasks have priority over feature tasks

## Validation Checklist
*GATE: Checked by main() before returning*

- [ ] All contracts have corresponding tests
- [ ] All entities have model tasks
- [ ] All security requirements have security tasks
- [ ] All tests come before implementation
- [ ] All security tests come before security implementation
- [ ] Security tasks come before feature tasks
- [ ] Parallel tasks truly independent
- [ ] Each task specifies exact file path
- [ ] No task modifies same file as another [P] task
- [ ] Security tasks properly categorized and prioritized