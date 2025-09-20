# Tasks: [FEATURE NAME] (Security-Enhanced)

**Input**: Design documents from `/specs/[###-feature-name]/`
**Prerequisites**: plan.md (required), research.md, security-research.md, data-model.md, security-architecture.md, contracts/
**Security Level**: [LOW/MEDIUM/HIGH/CRITICAL] (inherited from plan)
**Project Type**: [single/web/mobile] (from plan.md)
**Tech Stack**: [LANGUAGE/FRAMEWORK] (from plan.md)

## Execution Flow (main)
```
1. Load plan.md from feature directory
   → If not found: ERROR "No implementation plan found"
   → Extract: tech stack, libraries, structure, security requirements, project type
2. Load optional design documents:
   → data-model.md: Extract entities → model tasks
   → security-architecture.md: Extract security requirements → security tasks
   → contracts/: Each file → contract test task
   → research.md: Extract decisions → setup tasks
   → security-research.md: Extract security decisions → security setup tasks
3. Generate tasks by category (ADAPTIVE based on project type and tech stack):
   → Setup: project init, dependencies, linting, security tools
   → Security Setup: authentication, authorization, encryption, monitoring
   → Tests: contract tests, integration tests, security tests
   → Core: models, services, CLI commands, API endpoints, UI components
   → Security Core: security modules, security services
   → Integration: DB, middleware, logging, security middleware
   → Security Integration: security monitoring, incident response
   → Polish: unit tests, performance, docs, security documentation
4. Apply task rules:
   → Different files = mark [P] for parallel
   → Same file = sequential (no [P])
   → Tests before implementation (TDD)
   → Security controls before features
   → Language-specific tools and patterns
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

## Path Conventions (Adaptive)
- **Single project**: `src/`, `tests/` at repository root
- **Web app**: `backend/`, `frontend/` (or `api/`, `web/`)
- **Mobile**: `api/`, `ios/`, `android/` (or `mobile/`)
- **Security modules**: `src/security/`, `tests/security/` (or language-specific paths)
- **Language-specific**: Adjust paths based on tech stack (e.g., `src/` for Python, `lib/` for Rust, `components/` for React)

## Task Generation Rules (Adaptive)
*Tasks are generated based on project type, tech stack, and available design documents*

### 1. Project Setup (Always Required)
- [ ] T001 Create project structure per implementation plan
- [ ] T002 Initialize [LANGUAGE] project with [FRAMEWORK] dependencies
- [ ] T003 [P] Configure linting and formatting tools for [LANGUAGE]
- [ ] T004 [S] [P] Configure security scanning tools for [LANGUAGE]
- [ ] T005 [S] [P] Setup security monitoring and logging infrastructure

### 2. Security Foundation (Security-First Approach)
**CRITICAL: Security controls MUST be implemented before any feature development**
- [ ] T006 [S] [P] Implement authentication service
- [ ] T007 [S] [P] Implement authorization service  
- [ ] T008 [S] [P] Implement input validation service
- [ ] T009 [S] [P] Implement security monitoring service
- [ ] T010 [S] [P] Setup security test framework

### 3. Tests First (TDD) ⚠️ MUST COMPLETE BEFORE IMPLEMENTATION
**CRITICAL: These tests MUST be written and MUST FAIL before ANY implementation**

*Generate based on contracts and data model:*
- [ ] T011 [P] Contract test [ENDPOINT] in tests/contract/test_[endpoint].[ext]
- [ ] T012 [P] Integration test [FEATURE] in tests/integration/test_[feature].[ext]
- [ ] T013 [S] [P] Security test [SECURITY_REQUIREMENT] in tests/security/test_[requirement].[ext]

### 4. Core Implementation (ONLY after tests are failing)
*Generate based on data model and contracts:*

**For each entity in data-model.md:**
- [ ] T014 [P] [ENTITY] model in [PATH]/models/[entity].[ext]
- [ ] T015 [P] [ENTITY]Service CRUD in [PATH]/services/[entity]_service.[ext]

**For each endpoint in contracts/:**
- [ ] T016 [P] [METHOD] [ENDPOINT] in [PATH]/api/[endpoint].[ext]

**For web applications:**
- [ ] T017 [P] [COMPONENT] component in [PATH]/components/[Component].[ext]

**For CLI applications:**
- [ ] T018 [P] CLI [COMMAND] in [PATH]/cli/[command]_commands.[ext]

### 5. Security Integration
- [ ] T019 [S] Connect services to security services
- [ ] T020 [S] Implement security logging and monitoring
- [ ] T021 [S] Implement security event alerting
- [ ] T022 [S] Connect security services to external monitoring

### 6. Integration
- [ ] T023 Connect services to database/external APIs
- [ ] T024 Auth middleware integration
- [ ] T025 Request/response logging
- [ ] T026 CORS and security headers
- [ ] T027 [S] Security middleware integration

### 7. Security Testing
- [ ] T028 [S] [P] Penetration testing setup
- [ ] T029 [S] [P] Vulnerability scanning setup
- [ ] T030 [S] [P] Compliance testing setup
- [ ] T031 [S] [P] Security performance testing

### 8. Polish & Documentation
- [ ] T032 [P] Unit tests for [COMPONENT] in tests/unit/test_[component].[ext]
- [ ] T033 [P] Performance tests ([PERFORMANCE_TARGET])
- [ ] T034 [S] Security performance tests ([SECURITY_TARGET])
- [ ] T035 [P] Update documentation
- [ ] T036 [S] [P] Update security documentation
- [ ] T037 [S] [P] Create security runbook
- [ ] T038 [S] [P] Create incident response procedures
- [ ] T039 Remove duplication
- [ ] T040 Run manual testing
- [ ] T041 [S] Run security testing

## Dependencies (Adaptive)
*Dependencies are determined by project type and tech stack*

### Core Dependencies
- Security setup (T006-T010) before any feature development
- Tests (T011-T013) before implementation (T014-T018)
- Security tests before security implementation
- Implementation before polish (T032-T041)

### Language-Specific Dependencies
- **Python**: Models before services, services before endpoints
- **JavaScript/TypeScript**: Components before pages, API routes before frontend
- **Rust**: Structs before implementations, implementations before main
- **Go**: Types before functions, functions before handlers
- **Java**: Classes before services, services before controllers

### Project-Type Dependencies
- **Web apps**: Backend before frontend, API before UI
- **Mobile apps**: API before mobile, core before platform-specific
- **CLI tools**: Core logic before CLI interface
- **Libraries**: Core before wrappers, internal before external

## Parallel Execution Examples
*Generate based on actual tasks created*

```
# Example for web application:
Task: "Contract test POST /api/posts in tests/contract/test_posts_post.js"
Task: "Contract test GET /api/posts in tests/contract/test_posts_get.js"
Task: "Integration test auth flow in tests/integration/test_auth.js"
Task: "Security test authentication bypass in tests/security/test_auth_bypass.js"
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
- **Adaptive**: Tasks adjust to project type and tech stack

## Task Generation Rules (Adaptive)
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
   
5. **Adaptive Ordering**:
   - Security setup → Tests → Security tests → Models → Security models → Services → Security services → Endpoints → Security endpoints → Polish → Security polish
   - Dependencies block parallel execution
   - Security tasks have priority over feature tasks
   - **Language-specific**: Adjust based on tech stack patterns
   - **Project-specific**: Adjust based on project type

## Validation Checklist (Adaptive)
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
- [ ] **Tasks adapt to project type and tech stack**
- [ ] **Language-specific patterns followed**
- [ ] **Project-specific structure respected**