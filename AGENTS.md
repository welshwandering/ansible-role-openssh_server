# Agent Instructions: OpenSSH Server Ansible Role

This document provides guidance for AI agents (Claude, etc.) working on this OpenSSH server hardening Ansible role. It captures the principles, methodology, and quality standards established during the development of this project.

## Project Overview

This is a **security-first Ansible role** for hardening OpenSSH server configurations on Debian and Ubuntu systems. It provides:

- **Comprehensive security hardening** with modern cryptography
- **16 compliance frameworks** (PCI DSS, HIPAA, FedRAMP, FISMA, SOC 2, GDPR, ISO 27001+)
- **20+ CVE mitigations** with distribution-specific patch tracking
- **10 supported distributions** (Debian 11-14, Ubuntu 22.04+, Rocky 8-10)
- **Version-aware capability detection** (13 feature flags)
- **Post-quantum cryptography** (ML-KEM) and FIDO2/WebAuthn support

This is a **standalone, independent open source project** that can be composed into other infrastructure management systems.

## Quick Reference for Agents

**Before every task:**
- [ ] Read existing files before editing (`Read` before `Edit`/`Write`)
- [ ] Update docs/docs/CHANGELOG.md for ALL changes
- [ ] Run `yamllint .` and `ansible-lint --profile=production`

**Key commands:**
- Validate YAML: `yamllint .`
- Validate Ansible: `ansible-lint --profile=production`
- Check CVE status: `curl -s https://security-tracker.debian.org/tracker/CVE-YYYY-XXXXX`

**Never do:**
- ❌ Make security claims without verification
- ❌ Break backwards compatibility with Debian Stretch (OpenSSH 7.4p1)
- ❌ Use `yes`/`no` in YAML files (use `true`/`false`)
- ❌ Forget to update docs/CHANGELOG.md

## Development Workflow

### Local Testing Environment
- **Linting**: Use `yamllint .` for YAML validation
- **Best practices**: Use `ansible-lint --profile=production` (strict mode)
- **CVE verification**: Check distribution security trackers before claims
- **Documentation**: Build locally by editing markdown files

### Pre-commit Validation
All changes must pass:
1. `yamllint .` - YAML syntax and style
2. `ansible-lint --profile=production` - Ansible best practices
3. Documentation links verified
4. docs/CHANGELOG.md updated

### File Editing Pattern
```bash
# 1. Read first (REQUIRED)
Read templates/sshd_config.j2

# 2. Make changes with Edit tool
Edit templates/sshd_config.j2

# 3. Validate
yamllint . && ansible-lint --profile=production

# 4. Update docs/CHANGELOG.md
Edit docs/CHANGELOG.md
```

## Tool Usage Priorities

### Research and Verification
1. **WebFetch**: For official documentation (OpenSSH, NIST, BSI, ANSSI)
2. **WebSearch**: For finding authoritative sources
3. **Bash**: For CVE verification commands (`curl -s https://security-tracker.debian.org/...`)

### File Operations
1. **Read**: ALWAYS read before editing (required by Edit tool)
2. **Edit**: For targeted changes to existing files
3. **Write**: Only for new files (not for modifying existing ones)
4. **Glob**: For finding files matching patterns

### Code Quality
1. **Bash**: Run `yamllint .` and `ansible-lint --profile=production`
2. **Read**: Review validation output
3. **Edit**: Fix issues found by linters

### Documentation Updates
Every code change requires updating:
1. docs/CHANGELOG.md (MANDATORY)
2. Relevant docs/ file (e.g., DISTRIBUTIONS.md, CVE-TRACKING.md)
3. README.md (if features/capabilities change)
4. examples/ (if usage patterns change)

## Core Principles

### 1. Security Through Research, Not Assumptions

**CRITICAL**: Never make claims about security without verification.

- **Always verify CVE patch status** using official security trackers:
  - Debian: `https://security-tracker.debian.org/tracker/CVE-XXXX-XXXXX`
  - Ubuntu: `https://ubuntu.com/security/CVE-XXXX-XXXXX`

- **Understand vendor backports**: A distribution running OpenSSH 8.4p1 may be protected against vulnerabilities fixed in upstream 9.8p1 due to vendor security patches. NEVER assume vulnerability status based solely on version numbers.

- **Research compliance frameworks thoroughly**: When asked about compliance (PCI DSS, HIPAA, FedRAMP, etc.), fetch official documentation and understand actual requirements, not generic security advice.

- **Cite sources**: Every security claim should reference:
  - Official OpenSSH security advisories
  - CVE database entries
  - Government/industry standards (NSA/CISA, BSI, ANSSI, etc.)
  - Distribution security trackers

**Example of correct approach**:
```
❌ WRONG: "Debian Bookworm is vulnerable to CVE-2024-6387"
✅ RIGHT: "Debian Bookworm PATCHED CVE-2024-6387 via 1:9.2p1-2+deb12u3
          (verified at https://security-tracker.debian.org/tracker/CVE-2024-6387)"
```

### 2. Version-Aware Capability Detection

This role supports 10 key distributions spanning OpenSSH versions 8.0p1 through 10.2p1+. **Never break older distributions** (even if not officially listed).

**13 Capability Flags** (set in [tasks/main.yml](tasks/main.yml)):
- `openssh_has_disable_forwarding` (7.4+)
- `openssh_has_ca_signature_algorithms` (7.9+)
- `openssh_has_fido2` (8.2+)
- `openssh_has_include` (8.2+)
- `openssh_has_log_verbose` (8.5+)
- `openssh_has_required_rsa_size` (9.3+)
- `openssh_has_persourcepenalties` (9.8+)
- `openssh_has_mlkem` (9.9+)
- `openssh_has_rsa_sha2` (7.2+)
- `openssh_has_modern_kex` (7.4+)
- `openssh_blocks_dsa_ca` (7.9+)
- `openssh_removes_dsa` (9.6+)
- `openssh_dh_disabled_default` (10.0+)

**Implementation pattern** in [templates/sshd_config.j2](templates/sshd_config.j2):
```jinja2
{% if openssh_has_persourcepenalties | default(false) and openssh_enable_persourcepenalties %}
PerSourcePenalties yes
{% endif %}
```

**When adding new features**:
1. Check OpenSSH version requirement in release notes
2. Add capability flag to tasks/main.yml
3. Use conditional logic in templates/sshd_config.j2
4. Test on both old (Debian Stretch 7.4p1) and new (Debian Forky 10.0p1) versions

### 3. Compliance Framework Accuracy

**16 frameworks supported**: PCI DSS 4.0, SOX, SAMA CSF, HIPAA, HITRUST CSF, GDPR, ISO 27017/27018/27037/27040/27701, FedRAMP, FISMA, NERC CIP, NCA ECC, UAE IA, SOC 2

**When working with compliance**:

1. **Research the actual framework requirements**:
   - PCI DSS 4.0: Multi-factor auth, 12+ char passwords, session timeout, audit logging
   - FedRAMP: FIPS 140-2 compatible crypto, NIST 800-53 controls (AC-17, SC-8, SC-13)
   - HIPAA: Encryption in transit (NIST SP 800-52), audit trails, addressable encryption

2. **Document which role features satisfy requirements**:
   - Map specific role variables to compliance controls
   - Show configuration examples (see [examples/](examples/) directory)
   - Note limitations (e.g., "FIPS 140-2 compatible algorithms, but full compliance requires OS-level FIPS mode")

3. **Link to authoritative sources** in [docs/COMPLIANCE.md](docs/COMPLIANCE.md)

### 4. Documentation Quality Standards

**Documentation is split into focused topics**:
- `README.md` (~150 lines): Quick start, features, navigation
- `docs/DISTRIBUTIONS.md`: Distribution matrix and capability flags
- `docs/COMPLIANCE.md`: All 16 frameworks with requirements mapping
- `docs/CVE-TRACKING.md`: Vulnerability status by distribution
- `docs/CONFIGURATION.md`: Complete variable reference
- `docs/EXAMPLES.md`: Configuration examples
- `docs/TROUBLESHOOTING.md`: Common issues

**Quality standards**:

1. **Use tables for structured data**: Distribution matrices, CVE status, compliance mappings
2. **Provide specific package versions**: "Debian Bookworm 1:9.2p1-2+deb12u3" not "Debian Bookworm is patched"
3. **Include verification commands**: Show users how to check their status
4. **Link between documents**: Cross-reference related topics
5. **Keep README concise**: Link to detailed docs rather than embedding everything

**Bad example**:
```markdown
## Supported Distributions
Debian and Ubuntu are supported.
```

**Good example**:
```markdown
## Supported Distributions

| Distribution | OpenSSH Version | Feature Level | Security Status |
|--------------|-----------------|---------------|-----------------|
| Debian Bookworm | 9.2p1 | ✅ Modern | PATCHED for CVE-2024-6387 via 1:9.2p1-2+deb12u3 |
```

### 5. Testing and Validation

**ALWAYS run validation** before claiming work is complete:

```bash
# YAML syntax
yamllint .

# Ansible best practices (production profile is strict)
ansible-lint --profile=production

# All must pass with 0 failures, 0 warnings
```

**Common validation failures**:

1. **Truthy values**: Use `true`/`false` not `yes`/`no` in YAML, convert in templates
   ```yaml
   # defaults/main.yml
   openssh_verify_host_key_dns: false  # boolean

   # templates/sshd_config.j2
   VerifyHostKeyDNS {{ 'yes' if openssh_verify_host_key_dns else 'no' }}
   ```

2. **Galaxy role naming**: Must include `namespace` in meta/main.yml
   ```yaml
   galaxy_info:
     role_name: openssh_server
     namespace: agh  # REQUIRED
   ```

3. **Line length**: Keep YAML lines under 160 characters (yamllint rule)

### 6. Cryptographic Preferences

**Algorithm priority order** (Mozilla Modern + OpenSSH 10.0):

1. **Ciphers** (AEAD preferred):
   - `chacha20-poly1305@openssh.com` (highest priority)
   - `aes256-gcm@openssh.com`, `aes128-gcm@openssh.com` (AEAD)
   - `aes256-ctr`, `aes192-ctr`, `aes128-ctr` (fallback for ANSSI/BSI)

2. **Key Exchange**:
   - `mlkem768x25519-sha256` (post-quantum, 9.9+ only)
   - `curve25519-sha256` (preferred)
   - `ecdh-sha2-nistp521/384/256` (NIST curves)
   - `diffie-hellman-group16-sha512`, `diffie-hellman-group18-sha512` (4096-bit DH)

3. **MACs**:
   - `hmac-sha2-512-etm@openssh.com` (ETM preferred)
   - `hmac-sha2-256-etm@openssh.com`
   - `umac-128-etm@openssh.com`

**When researching crypto updates**:
- Check OpenSSH release notes (https://www.openssh.com/releasenotes.html)
- Review Mozilla OpenSSH guidelines (https://infosec.mozilla.org/guidelines/openssh)
- Check international guidance (BSI TR-02102-4, ANSSI NT_OpenSSH)
- Understand algorithm lifecycle (deprecated → removed → blocked)

### 7. CVE Tracking Methodology

**When a new CVE is discovered**:

1. **Research official sources**:
   - OpenSSH security page: https://www.openssh.com/security.html
   - NVD/CVE database entry
   - Vendor security advisories (Qualys, etc.)

2. **Check distribution patch status**:
   ```bash
   # Debian
   curl -s https://security-tracker.debian.org/tracker/CVE-YYYY-XXXXX

   # Ubuntu
   curl -s https://ubuntu.com/security/CVE-YYYY-XXXXX
   ```

3. **Update docs/CVE-TRACKING.md** with:
   - CVE number, CVSS score, description
   - Upstream affected versions
   - Upstream fixed version
   - Distribution-specific patch status with package versions
   - Mitigation status (Fully Mitigated / Conditionally Mitigated / Open)
   - Configuration-based mitigations if any

4. **Update role if needed**:
   - Add/update role variables for mitigation
   - Add capability flags if version-specific
   - Update defaults for secure-by-default

### 8. International Research Standards

**When asked about international security guidance**:

1. **Five Eyes alliance** (English-speaking):
   - 🇺🇸 NSA/CISA (https://www.nsa.gov/, https://www.cisa.gov/)
   - 🇨🇦 CCCS (https://www.cyber.gc.ca/)
   - 🇦🇺 ACSC (https://www.cyber.gov.au/)
   - 🇬🇧 NCSC (https://www.ncsc.gov.uk/)
   - 🇳🇿 GCSB/NZISM (https://www.gcsb.govt.nz/)

2. **European standards**:
   - 🇩🇪 BSI (https://www.bsi.bund.de/) - TR-02102-4 is most comprehensive
   - 🇫🇷 ANSSI (https://cyber.gouv.fr/) - NT_OpenSSH
   - 🇪🇺 ENISA (defers to member states)

3. **Middle East**:
   - 🇸🇦 NCA ECC (Saudi Arabia National Cybersecurity Authority)
   - 🇦🇪 UAE IA (UAE Information Assurance)

**Research approach**:
- Use WebFetch to get actual framework documents
- Look for version-dated guidance (e.g., "BSI TR-02102-4 Version 2025-1")
- Check for post-quantum cryptography roadmaps
- Identify algorithm preferences and minimum key sizes

### 9. Error Correction and Fact-Checking

**CRITICAL LESSON**: During this project, we initially made incorrect claims about CVE-2024-6387 vulnerability status.

**Original incorrect claims**:
- ❌ Debian Bookworm vulnerable (WRONG - patched via backport)
- ❌ Ubuntu 22.04 Jammy vulnerable (WRONG - patched via backport)
- ❌ Ubuntu 20.04 Focal vulnerable (WRONG - not affected, version 8.2p1 predates vulnerable code)

**What we learned**:
1. **Always verify against official trackers** before making vulnerability claims
2. **Understand vendor backports** - don't trust version numbers alone
3. **When user questions accuracy, investigate thoroughly** - they may be right
4. **Update documentation when errors discovered** - accuracy > ego

**If you discover an error**:
1. Acknowledge it immediately
2. Research the correct information using official sources
3. Update ALL affected documentation
4. Explain what was wrong and why to help user understand

### 10. Change Management

**CRITICAL: docs/CHANGELOG.md is the source of truth for all changes to this project.**

**Before making ANY changes**:

1. **Read existing files first**: Use Read tool before Edit/Write
2. **Understand the context**: Check related files (defaults, tasks, templates, meta)
3. **Maintain backwards compatibility**: Test that changes work on Debian Stretch 7.4p1
4. **Update docs/CHANGELOG.md**: Document what changed and why (see below)
5. **Run validation**: yamllint + ansible-lint must pass

### 11. Commit Message Standards

**Format**: Follow [Conventional Commits](https://www.conventionalcommits.org/) style:

```
<type>(<scope>): <subject>

<body>

<footer>
```

**Types**:
- `feat`: New feature (triggers CHANGELOG Added section)
- `fix`: Bug fix (triggers CHANGELOG Fixed section)
- `docs`: Documentation only (triggers CHANGELOG Changed section)
- `security`: Security fix (triggers CHANGELOG Security section)
- `refactor`: Code refactoring (no functional change)
- `test`: Adding/updating tests
- `chore`: Maintenance (deps, tooling)

**Examples**:
```
feat(compliance): Add PCI DSS 4.0 support

- Added openssh_pci_dss_mode variable
- Created examples/pci-dss-4.0.yml playbook
- Updated docs/COMPLIANCE.md with requirement mappings

Addresses PCI DSS 4.0 deadline (March 31, 2025)
```

```
security(cve): Mitigate CVE-2025-26465 by disabling VerifyHostKeyDNS

- Changed default openssh_verify_host_key_dns: false
- Updated docs/CVE-TRACKING.md with vulnerability analysis
- Verified mitigation across all 15 distributions

CVE CVSS: 5.3 (Medium) - DNS spoofing attack vector
```

**Good commit messages**:
- ✅ Reference specific files/components
- ✅ Explain "why" not just "what"
- ✅ Include verification steps taken
- ✅ Link to official sources for security/compliance changes

**Bad commit messages**:
- ❌ "Update docs"
- ❌ "Fix stuff"
- ❌ "WIP"

**docs/CHANGELOG.md Update Requirements**:

Every code change, documentation update, security fix, or feature addition MUST be documented in docs/CHANGELOG.md following [Keep a Changelog](https://keepachangelog.com/) format.

**When to update docs/CHANGELOG.md**: Always. For every session, every change.

**How to update docs/CHANGELOG.md**:

1. **Create an Unreleased section** if one doesn't exist:
   ```markdown
   ## [Unreleased]

   ### Added
   ### Changed
   ### Deprecated
   ### Removed
   ### Fixed
   ### Security
   ```

2. **Choose the correct category**:
   - **Added**: New features, capabilities, distributions, compliance frameworks
   - **Changed**: Changes to existing functionality, documentation updates
   - **Deprecated**: Features marked for removal
   - **Removed**: Removed features or support
   - **Fixed**: Bug fixes, corrections to documentation
   - **Security**: Security-related changes, CVE mitigations

3. **Write clear, actionable entries**:
   - ✅ GOOD: "Added support for ML-KEM post-quantum key exchange on OpenSSH 9.9+"
   - ✅ GOOD: "Fixed CVE-2025-26465 mitigation by disabling VerifyHostKeyDNS by default"
   - ✅ GOOD: "Updated COMPLIANCE.md with PCI DSS 4.0 deadline (March 31, 2025)"
   - ❌ BAD: "Updated docs"
   - ❌ BAD: "Various fixes"
   - ❌ BAD: "Improvements"

4. **Reference specific files/components** when relevant:
   - "Updated `docs/CVE-TRACKING.md` with CVE-2024-6387 distribution patch status"
   - "Modified `templates/sshd_config.j2` to add PerSourcePenalties support"

5. **Link to issues/PRs** if applicable (future feature when GitHub issues are set up)

**Example CHANGELOG update for this session**:
```markdown
## [Unreleased]

### Changed
- Removed all references to Warden project for standalone release
- Updated terminology from "nation-state level" to "comprehensive" and "sophisticated attacks"
- Simplified license headers to "MIT License" from verbose form
- Enhanced docs/CHANGELOG.md with comprehensive 1.0.0 release summary (210 lines)

### Added
- Created CITATION.cff for academic and professional citation support
- Added detailed statistics section to docs/CHANGELOG.md (569 lines code, 457 lines docs)
- Added Rocky Linux 8 and 9 support including platform-specific sftp paths and package management

```

**Versioning trigger**: When ready to release:
1. Move `[Unreleased]` content to a new version section: `## [X.Y.Z] - YYYY-MM-DD`
2. Update version in `meta/main.yml`
3. Create git tag
4. Leave empty `[Unreleased]` section for future changes

**Making security changes**:

1. **Research first, implement second**: Don't implement based on general knowledge
2. **Check OpenSSH version requirements**: New directives may not work on old versions
3. **Add capability flags**: Use conditional logic for version-specific features
4. **Update documentation**: README, relevant docs/, and examples/
5. **Consider compliance impact**: Does this change affect any of the 16 frameworks?

### 11. Example Playbook Standards

**All examples** in [examples/](examples/) **must**:

1. **Include comprehensive header comments**:
   - What the playbook does
   - Which compliance framework it satisfies (if applicable)
   - Key security features enabled
   - Deadlines or important dates (e.g., "PCI DSS 4.0 deadline: March 31, 2025")

2. **Use descriptive variable names**:
   - Group related settings with comments
   - Explain non-obvious values (e.g., why `openssh_rekey_limit: "512M 30m"`)

3. **Be self-documenting**:
   - Comments should explain "why" not just "what"
   - Reference compliance requirements (e.g., "# Requirement 8.2.1: Multi-factor authentication")

4. **Be complete and runnable**:
   - Specify hosts
   - Include `become: true` if needed
   - Can be copied and run directly

5. **Reference role correctly**:
   - Use `welshwandering.openssh_server` (Galaxy-style full name)
   - Not `warden_role_openssh_server` (Warden-specific)

### 12. Professional Development Practices

**This role follows industry best practices**:

1. **Repository structure**:
   - Ansible Galaxy-compatible layout
   - Separate docs/ directory for topic-based documentation
   - examples/ directory with runnable playbooks
   - GitHub Actions CI/CD in .github/workflows/

2. **Semantic versioning**: v1.0.0 format (major.minor.patch)

3. **Changelog maintenance**: Keep a Changelog format (keepachangelog.com)

4. **License clarity**: MIT License, properly attributed

5. **Contribution readiness**: Though not yet created, plan for:
   - CONTRIBUTING.md (PR process, coding standards)
   - CODE_OF_CONDUCT.md
   - GitHub issue templates

### 13. Research Methodology

**When asked to research a topic**:

1. **Use WebSearch** for overview and finding authoritative sources
2. **Use WebFetch** to read actual documentation from official sources
3. **Cross-reference multiple sources**: Don't rely on a single article
4. **Prioritize official sources**:
   - Government cybersecurity agencies (NSA, BSI, ANSSI)
   - OpenSSH project (openssh.com)
   - Distribution security trackers (Debian, Ubuntu)
   - Standards bodies (NIST, ISO, CIS)

5. **Verify dates**: Standards evolve - check publication/revision dates

**Example research workflow**:
```
User: "Research FedRAMP SSH requirements"

1. WebSearch: "FedRAMP SSH FIPS 140-2 requirements"
   → Find FedRAMP uses NIST SP 800-53 controls

2. WebSearch: "NIST SP 800-53 SSH remote access AC-17 SC-8"
   → Identify specific controls: AC-17, SC-8, SC-13

3. WebFetch: Official FedRAMP documentation
   → Extract baseline requirements (Moderate: 325 controls)

4. Document findings with links to sources
```

### 14. Communication and Clarity

**When working with users**:

1. **Be concise but complete**: Don't over-explain, but provide necessary detail
2. **Use structured formats**: Tables, lists, code blocks for clarity
3. **Provide verification steps**: Show users how to check results
4. **Acknowledge uncertainty**: Say "I'll research that" rather than guessing
5. **Correct mistakes promptly**: If wrong, admit it and fix it

**Formatting standards**:
- Use emoji sparingly (✅ ❌ ⚠️ for status indicators)
- Code blocks with language hints (```yaml, ```bash)
- Tables for comparative data
- Clear section headers with ##

### 15. Testing Philosophy

**This role prioritizes**:

1. **Correctness over speed**: Better to research thoroughly than ship bugs
2. **Backwards compatibility**: Debian Stretch (EOL) should still work
3. **Secure defaults**: Users get security without configuration
4. **Validation before commit**: All code must pass yamllint + ansible-lint
5. **Documentation accuracy**: Every claim must be verifiable

**Molecule testing** (when available):
- Test on multiple distributions (Debian 11/12, Ubuntu 20.04/22.04/24.04)
- Verify capability flags work correctly
- Check that older versions don't break

## Common Tasks

### Adding a New Compliance Framework

1. Research official framework documentation
2. Identify SSH-related requirements
3. Map requirements to role variables
4. Update `docs/COMPLIANCE.md` with new table entry
5. Create example playbook in `examples/` if needed
6. Update README.md feature list
7. **Update docs/CHANGELOG.md** under `[Unreleased]` → `### Added`

### Adding a New Distribution

1. Check OpenSSH version shipped with distribution
2. Add to distribution tables in `docs/DISTRIBUTIONS.md`
3. Test capability flags work correctly
4. Check CVE patch status for that distribution
5. Update `docs/CVE-TRACKING.md` if needed
6. Add to `meta/main.yml` platforms list
7. Update README.md badges
8. **Update docs/CHANGELOG.md** under `[Unreleased]` → `### Added`

### Responding to a New CVE

1. Research CVE on openssh.com/security.html and NVD
2. Check all 15 distributions' patch status
3. Determine if role configuration provides mitigation
4. Update `docs/CVE-TRACKING.md` with comprehensive status
5. Update defaults/templates if mitigation needed
6. Create GitHub security advisory if critical
7. **Update docs/CHANGELOG.md** under `[Unreleased]` → `### Security`

### Updating Cryptographic Standards

1. Check OpenSSH release notes for new algorithms
2. Review Mozilla/NSA/BSI/ANSSI guidance updates
3. Test algorithm availability on Debian Stretch (oldest)
4. Update defaults/main.yml with new preferences
5. Add capability flags if version-specific
6. Update `docs/COMPLIANCE.md` if affects compliance
7. **Update docs/CHANGELOG.md** under `[Unreleased]` → `### Changed` or `### Security`

## Quality Checklist

Before completing any work, verify:

- [ ] All security claims verified against official sources
- [ ] CVE status checked on distribution security trackers
- [ ] Backwards compatibility maintained (test on Debian Stretch conceptually)
- [ ] Documentation updated (README + relevant docs/)
- [ ] Examples updated if behavior changes
- [ ] **docs/CHANGELOG.md updated with ALL changes** (most important!)
- [ ] CHANGELOG entries are clear, specific, and actionable
- [ ] Changes categorized correctly (Added/Changed/Deprecated/Removed/Fixed/Security)
- [ ] yamllint passes: `yamllint .`
- [ ] ansible-lint passes: `ansible-lint --profile=production`
- [ ] Cross-references between documents are valid
- [ ] All external links work and point to authoritative sources

## Key Expectations from This Session

Based on our work together on this project, here are the established patterns and expectations:

### Language and Terminology

1. **No buzzwords**: Avoid "enterprise-grade", "enterprise-level", "nation-state level", "Advanced Persistent Threats (APTs)"
2. **Use clear, direct language**: "comprehensive", "robust", "sophisticated attacks", "defense-in-depth"
3. **No marketing speak**: Technical accuracy over impressive-sounding claims

### Project Independence

1. **This is a standalone project**: No references to Warden or other parent projects
2. **Can be composed into anything**: Designed to be reusable and independent
3. **Clean attribution**: MIT License, proper copyright headers
4. **Professional citation support**: CITATION.cff included for academic/professional use

### Documentation Standards

1. **docs/CHANGELOG.md is mandatory**: Every change must be documented
2. **Clear, specific entries**: No vague "various fixes" or "improvements"
3. **Proper categorization**: Use Keep a Changelog categories correctly
4. **Reference specific files**: Help future maintainers understand impact

### Quality Over Speed

1. **Research before implementing**: Especially for security claims
2. **Verify CVE status**: Always check official distribution security trackers
3. **Test backwards compatibility**: Debian Stretch (oldest) must still work
4. **Run validation**: yamllint and ansible-lint must pass

### Communication

1. **Be concise but complete**: Don't over-explain, but provide necessary detail
2. **Acknowledge mistakes**: If wrong, admit it and fix it immediately
3. **Show verification steps**: Help users check their own systems
4. **Structure information**: Use tables, lists, code blocks for clarity

## Final Notes

**This role represents security research, not assumptions.**

Every claim about vulnerability status, compliance requirements, or cryptographic preferences is backed by research from authoritative sources. When in doubt, research more. When certain, still verify.

The goal is to provide administrators with a **trustworthy, accurate, and comprehensive** OpenSSH hardening solution that they can deploy with confidence in production environments, including those subject to regulatory compliance.

**Trust is earned through accuracy, not confidence.**

---

*Document created: 2025-10-05*
*Last updated: 2025-10-05*
*Role version: 1.0.0*
*For questions about this role: See docs/ directory or check git commit history*