# Feature Specification: [FEATURE NAME] (Security-Enhanced)

**Feature Branch**: `[###-feature-name]`  
**Created**: [DATE]  
**Status**: Draft  
**Input**: User description: "$ARGUMENTS"
**Security Level**: [LOW/MEDIUM/HIGH/CRITICAL] (AI-determined)

## Execution Flow (main)
```
1. Parse user description from Input
   → If empty: ERROR "No feature description provided"
2. Extract key concepts from description
   → Identify: actors, actions, data, constraints
3. AI Security Analysis:
   → Determine security level based on data sensitivity
   → Identify potential attack vectors
   → Map to OWASP Top 10 categories
4. For each unclear aspect:
   → Mark with [NEEDS CLARIFICATION: specific question]
5. Fill User Scenarios & Testing section
   → If no clear user flow: ERROR "Cannot determine user scenarios"
6. Generate Functional Requirements
   → Each requirement must be testable
   → Mark ambiguous requirements
7. Generate Security Requirements (AI-driven)
   → Map to OWASP ASVS controls
   → Identify authentication/authorization needs
   → Define data protection requirements
8. Identify Key Entities (if data involved)
9. Run Review Checklist
   → If any [NEEDS CLARIFICATION]: WARN "Spec has uncertainties"
   → If implementation details found: ERROR "Remove tech details"
10. Return: SUCCESS (spec ready for planning)
```

---

## ⚡ Quick Guidelines
- ✅ Focus on WHAT users need and WHY
- ❌ Avoid HOW to implement (no tech stack, APIs, code structure)
- 👥 Written for business stakeholders, not developers
- 🔒 Security requirements integrated by default

### Section Requirements
- **Mandatory sections**: Must be completed for every feature
- **Optional sections**: Include only when relevant to the feature
- When a section doesn't apply, remove it entirely (don't leave as "N/A")

### For AI Generation
When creating this spec from a user prompt:
1. **Mark all ambiguities**: Use [NEEDS CLARIFICATION: specific question] for any assumption you'd need to make
2. **Don't guess**: If the prompt doesn't specify something (e.g., "login system" without auth method), mark it
3. **Think like a tester**: Every vague requirement should fail the "testable and unambiguous" checklist item
4. **Security-first thinking**: Automatically consider security implications
5. **Common underspecified areas**:
   - User types and permissions
   - Data retention/deletion policies  
   - Performance targets and scale
   - Error handling behaviors
   - Integration requirements
   - Security/compliance needs
   - Authentication/authorization flows
   - Data encryption requirements

---

## User Scenarios & Testing *(mandatory)*

### Primary User Story
[Describe the main user journey in plain language]

### Acceptance Scenarios
1. **Given** [initial state], **When** [action], **Then** [expected outcome]
2. **Given** [initial state], **When** [action], **Then** [expected outcome]

### Edge Cases
- What happens when [boundary condition]?
- How does system handle [error scenario]?
- Security edge cases: [injection attempts, privilege escalation, data exposure]

### Security Test Scenarios
1. **Given** [unauthenticated user], **When** [attempts restricted action], **Then** [access denied]
2. **Given** [malicious input], **When** [submitted to system], **Then** [properly sanitized/rejected]

## Requirements *(mandatory)*

### Functional Requirements
- **FR-001**: System MUST [specific capability, e.g., "allow users to create accounts"]
- **FR-002**: System MUST [specific capability, e.g., "validate email addresses"]  
- **FR-003**: Users MUST be able to [key interaction, e.g., "reset their password"]
- **FR-004**: System MUST [data requirement, e.g., "persist user preferences"]
- **FR-005**: System MUST [behavior, e.g., "log all security events"]

*Example of marking unclear requirements:*
- **FR-006**: System MUST authenticate users via [NEEDS CLARIFICATION: auth method not specified - email/password, SSO, OAuth?]
- **FR-007**: System MUST retain user data for [NEEDS CLARIFICATION: retention period not specified]

### Security Requirements *(AI-generated based on security level)*
- **SR-001**: System MUST authenticate all users before access [OWASP ASVS 2.1.1]
- **SR-002**: System MUST validate all user inputs [OWASP ASVS 5.1.1]
- **SR-003**: System MUST encrypt sensitive data at rest [OWASP ASVS 8.1.1]
- **SR-004**: System MUST log all security events [OWASP ASVS 7.1.1]
- **SR-005**: System MUST implement rate limiting [OWASP ASVS 4.1.1]

*Security level-specific requirements:*
- **HIGH/CRITICAL**: Additional requirements for sensitive data handling
- **MEDIUM**: Standard security controls
- **LOW**: Basic security controls

### Key Entities *(include if feature involves data)*
- **[Entity 1]**: [What it represents, key attributes without implementation]
- **[Entity 2]**: [What it represents, relationships to other entities]

### Data Classification *(mandatory if data involved)*
- **Public**: [Data that can be freely shared]
- **Internal**: [Data for internal use only]
- **Confidential**: [Sensitive business data]
- **Restricted**: [Highly sensitive data requiring special protection]

---

## Review & Acceptance Checklist
*GATE: Automated checks run during main() execution*

### Content Quality
- [ ] No implementation details (languages, frameworks, APIs)
- [ ] Focused on user value and business needs
- [ ] Written for non-technical stakeholders
- [ ] All mandatory sections completed

### Requirement Completeness
- [ ] No [NEEDS CLARIFICATION] markers remain
- [ ] Requirements are testable and unambiguous  
- [ ] Success criteria are measurable
- [ ] Scope is clearly bounded
- [ ] Dependencies and assumptions identified

### Security Completeness
- [ ] Security level appropriately determined
- [ ] Security requirements cover identified threats
- [ ] Data classification completed
- [ ] Threat model addresses key risks
- [ ] External security templates integrated

---

## Execution Status
*Updated by main() during processing*

- [ ] User description parsed
- [ ] Key concepts extracted
- [ ] Security analysis completed
- [ ] Ambiguities marked
- [ ] User scenarios defined
- [ ] Requirements generated
- [ ] Security requirements generated
- [ ] Entities identified
- [ ] Threat model created
- [ ] External templates integrated
- [ ] Review checklist passed

## AI Security Analysis Summary
*Generated by AI during spec creation*

**Security Level Determination**: [LOW/MEDIUM/HIGH/CRITICAL]
**Primary Threats**: [List of top 3 threats]
**Key Security Controls**: [List of essential security controls]
**Compliance Requirements**: [Any regulatory requirements]
**Risk Assessment**: [Overall risk level and justification]

---

*Based on Constitution v2.1.1 + Security Enhancement v1.0 - See `/memory/constitution.md`*
