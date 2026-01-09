# Contributing to ansible-role-openssh_server

**Want to help secure SSH servers across the internet? Awesome!** 🚀

This OpenSSH server hardening role protects systems running critical infrastructure, compliance-regulated workloads, and sensitive data worldwide. Your contributions help administrators deploy secure SSH configurations with confidence.

Whether you're fixing a typo, adding support for a new distribution, tracking a CVE, or implementing a compliance framework—**all contributions matter**.

## Table of Contents

- [Ways to Contribute](#ways-to-contribute)
- [Communication Channels](#communication-channels)
- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Workflow](#development-workflow)
- [Coding Standards](#coding-standards)
- [Documentation Standards](#documentation-standards)
- [Testing Requirements](#testing-requirements)
- [Pull Request Process](#pull-request-process)
- [Security Contributions](#security-contributions)
- [Recognition](#recognition)

## Ways to Contribute

You don't have to be a security expert to contribute! Here are ways to help:

### 🐛 Report Bugs
Found an issue? Let us know! See [Reporting Bugs](#reporting-bugs).

### 💡 Suggest Features
Have an idea? We'd love to hear it! Open an issue to discuss.

### 📝 Improve Documentation
Fix typos, clarify instructions, add examples—documentation contributions are invaluable.

### 🔐 Track Security Issues
Research CVE status, verify patch levels, update compliance mappings.

### 🧪 Add Distribution Support
Test on new Debian/Ubuntu releases and contribute compatibility updates.

### 🎯 Implement Compliance Frameworks
Map additional regulatory frameworks (ISO, NIST, etc.) to role configuration.

### 💬 Help Others
Answer questions in issues, review PRs, share your experience.

## Communication Channels

- **GitHub Issues**: Bug reports, feature requests, discussions
- **Pull Requests**: Code contributions and reviews
- **Security Issues**: Email maintainer directly (see repository contacts) or use GitHub Security Advisories

**Note**: This is a volunteer-run hobby project. We'll respond as time permits and appreciate your patience.

## Code of Conduct

This project follows a straightforward code of conduct based on mutual respect:

### Our Standards

- **Be respectful**: Treat all contributors with professionalism and courtesy
- **Be constructive**: Provide helpful, actionable feedback
- **Be accurate**: Back security claims with authoritative sources (links required)
- **Be collaborative**: Work together to improve security for everyone
- **Be inclusive**: Welcome contributors of all skill levels and backgrounds

### Not Acceptable

- Harassment, discriminatory language, or personal attacks
- False or unverified security claims
- Intentionally submitting vulnerable configurations
- Spam or off-topic discussions

### Enforcement

- **First offense**: Warning and request to correct behavior
- **Second offense**: Temporary ban from project participation (7-30 days)
- **Third offense**: Permanent ban from project participation

Maintainers will enforce standards fairly and transparently.

## Reporting Bugs

If you find a bug, please open an issue with:

- **Clear description**: What you expected vs. what happened
- **Environment details**: Distribution, OpenSSH version, Ansible version
- **Reproduction steps**: How to reproduce the issue
- **Configuration**: Relevant role variables (sanitize sensitive data)

### Suggesting Enhancements

We welcome suggestions for:

- New compliance framework support
- Additional security features
- Distribution support expansion
- Documentation improvements
- Performance optimizations

Please open an issue to discuss major changes before implementing them.

### Security Vulnerabilities

**DO NOT** open public issues for security vulnerabilities. Instead:

1. Email the maintainer directly (see repository contacts)
2. Use GitHub Security Advisories (if enabled)
3. Provide CVE numbers, affected versions, and proof of concept if available

## Getting Started

### Prerequisites

- Ansible 2.15+
- Python 3.8+
- Git
- yamllint
- ansible-lint

### Fork and Clone

```bash
# Fork the repository on GitHub, then clone your fork
git clone https://github.com/YOUR_USERNAME/ansible-role-openssh_server.git
cd ansible-role-openssh_server

# Add upstream remote
git remote add upstream https://github.com/welshwandering/ansible-role-openssh_server.git
```

### Install Development Tools

```bash
# Install Python dependencies
pip install yamllint ansible-lint ansible

# Install Ansible collections
ansible-galaxy collection install ansible.posix community.general
```

## Development Workflow

### 1. Create a Feature Branch

```bash
# Update your main branch
git checkout main
git pull upstream main

# Create feature branch
git checkout -b feature/your-feature-name
```

### 2. Make Your Changes

Follow the [Coding Standards](#coding-standards) and [Documentation Standards](#documentation-standards) below.

### 3. Test Your Changes

```bash
# Run YAML linting
yamllint .

# Run Ansible linting (production profile is strict)
ansible-lint --profile=production

# Both must pass with 0 failures, 0 warnings
```

### 4. Update Documentation

- Update relevant files in `docs/` directory
- Update `README.md` if adding features
- **REQUIRED**: Update `docs/CHANGELOG.md` (see below)

### 5. Commit Your Changes

```bash
# Stage your changes
git add .

# Commit with clear message
git commit -m "Add support for XYZ feature

- Detailed description of what changed
- Why the change was needed
- Any breaking changes or considerations"
```

### 6. Push and Create Pull Request

```bash
# Push to your fork
git push origin feature/your-feature-name

# Create pull request on GitHub
```

## Coding Standards

### Ansible Best Practices

1. **Use Fully Qualified Collection Names (FQCN)**:
   ```yaml
   # Good
   - ansible.builtin.apt:
       name: openssh-server

   # Bad
   - apt:
       name: openssh-server
   ```

2. **Boolean values as true/false**:
   ```yaml
   # defaults/main.yml
   openssh_password_authentication: false  # boolean

   # templates/sshd_config.j2
   PasswordAuthentication {{ 'yes' if openssh_password_authentication else 'no' }}
   ```

3. **Task naming**:
   - Use descriptive names
   - Start with verb (e.g., "Install", "Configure", "Verify")
   - Be specific about what the task does

4. **Line length**: Keep lines under 160 characters (yamllint rule)

5. **YAML document start**: All YAML files must start with `---`

### Version-Aware Development

This role supports 15 distributions with OpenSSH versions 7.2p2 through 10.0p1. **Never break older distributions**.

**When adding features that require specific OpenSSH versions**:

1. **Check version requirement** in OpenSSH release notes
2. **Add capability flag** in `tasks/main.yml`:
   ```yaml
   openssh_has_new_feature: "{{ openssh_version is defined and openssh_version >= 9.5 }}"
   ```
3. **Use conditional logic** in `templates/sshd_config.j2`:
   ```jinja2
   {% if openssh_has_new_feature | default(false) and openssh_enable_new_feature %}
   NewFeature yes
   {% endif %}
   ```
4. **Test on both old and new versions** conceptually

### Security Contributions

**CRITICAL**: Never make security claims without verification.

1. **Verify CVE patch status** using official trackers:
   - Debian: `https://security-tracker.debian.org/tracker/CVE-XXXX-XXXXX`
   - Ubuntu: `https://ubuntu.com/security/CVE-XXXX-XXXXX`

2. **Understand vendor backports**: Distribution package version ≠ vulnerability status

3. **Research compliance frameworks thoroughly**: Fetch official documentation

4. **Cite sources**: Reference official advisories, CVE databases, government standards

**Example**:
```markdown
❌ WRONG: "Debian Bookworm is vulnerable to CVE-2024-6387"
✅ RIGHT: "Debian Bookworm PATCHED CVE-2024-6387 via 1:9.2p1-2+deb12u3
          (verified at https://security-tracker.debian.org/tracker/CVE-2024-6387)"
```

## Documentation Standards

### File Organization

- `README.md`: Quick start, features, navigation (~150 lines)
- `docs/DISTRIBUTIONS.md`: Distribution matrix and capability flags
- `docs/COMPLIANCE.md`: Compliance framework mappings
- `docs/CVE-TRACKING.md`: Vulnerability status by distribution
- `docs/CONFIGURATION.md`: Complete variable reference
- `docs/EXAMPLES.md`: Configuration examples
- `docs/TROUBLESHOOTING.md`: Common issues

### Quality Standards

1. **Use tables for structured data**: Distribution matrices, CVE status, compliance mappings
2. **Provide specific versions**: "Debian Bookworm 1:9.2p1-2+deb12u3" not "Debian Bookworm is patched"
3. **Include verification commands**: Show users how to check their status
4. **Cross-reference documents**: Link to related topics
5. **Keep README concise**: Link to detailed docs rather than embedding everything

### docs/CHANGELOG.md (REQUIRED)

**Every contribution MUST update docs/CHANGELOG.md** following [Keep a Changelog](https://keepachangelog.com/) format.

1. **Add to Unreleased section**:
   ```markdown
   ## [Unreleased]

   ### Added
   - Your new feature

   ### Changed
   - What you modified

   ### Fixed
   - What you fixed

   ### Security
   - Security improvements
   ```

2. **Write clear entries**:
   - ✅ GOOD: "Added support for ML-KEM post-quantum key exchange on OpenSSH 9.9+"
   - ✅ GOOD: "Fixed CVE-2025-26465 mitigation by disabling VerifyHostKeyDNS by default"
   - ❌ BAD: "Updated docs"
   - ❌ BAD: "Various fixes"

3. **Reference specific files**:
   - "Updated `docs/CVE-TRACKING.md` with CVE-2024-6387 distribution patch status"

## Testing Requirements

### Linting (Required)

```bash
# YAML syntax validation
yamllint .

# Ansible best practices (production profile is strictest)
ansible-lint --profile=production
```

**Both must pass with 0 failures, 0 warnings.**

### Manual Testing (Recommended)

If possible, test your changes on:

- **Legacy**: Debian Bullseye (OpenSSH 8.4p1) or Ubuntu 20.04 (OpenSSH 8.2p1)
- **Modern**: Debian Bookworm (OpenSSH 9.2p1) or Ubuntu 22.04 (OpenSSH 8.9p1)
- **Latest**: Debian Trixie (OpenSSH 10.0p1) or Ubuntu 24.04 (OpenSSH 9.6p1)

### Molecule Testing (Future)

We plan to implement comprehensive Molecule tests. Contributions to testing infrastructure are welcome!

## Pull Request Process

### Before Submitting

- [ ] Code passes `yamllint .` with 0 failures
- [ ] Code passes `ansible-lint --profile=production` with 0 failures
- [ ] Documentation updated (relevant files in `docs/`)
- [ ] `docs/CHANGELOG.md` updated with clear, specific entries
- [ ] Examples updated if behavior changes
- [ ] Backwards compatibility maintained
- [ ] Security claims verified with authoritative sources

### PR Description Template

```markdown
## Description
Brief description of what this PR does.

## Motivation and Context
Why is this change needed? What problem does it solve?
If it fixes an open issue, link to it here.

## Type of Change
- [ ] Bug fix (non-breaking change which fixes an issue)
- [ ] New feature (non-breaking change which adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to change)
- [ ] Documentation update
- [ ] Security fix

## Testing
How was this tested? Include:
- Distribution(s) tested on
- OpenSSH version(s) tested with
- Test procedure

## Checklist
- [ ] yamllint passes
- [ ] ansible-lint passes
- [ ] Documentation updated
- [ ] docs/CHANGELOG.md updated
- [ ] Examples updated (if applicable)
- [ ] Security claims verified with sources
```

### Review Process

1. **Automated checks**: Linting must pass
2. **Maintainer review**: Code quality, security accuracy, documentation
3. **Community feedback**: Other contributors may provide feedback
4. **Approval and merge**: Once approved, maintainer will merge

### After Your PR is Merged

- Update your fork:
  ```bash
  git checkout main
  git pull upstream main
  git push origin main
  ```

- Delete your feature branch:
  ```bash
  git branch -d feature/your-feature-name
  git push origin --delete feature/your-feature-name
  ```

## Common Contribution Types

### Adding a New Compliance Framework

1. Research official framework documentation
2. Identify SSH-related requirements
3. Map requirements to role variables
4. Update `docs/COMPLIANCE.md` with new table entry
5. Create example playbook in `examples/` if needed
6. Update README.md feature list
7. Update `docs/CHANGELOG.md` under `[Unreleased]` → `### Added`

### Adding a New Distribution

1. Check OpenSSH version shipped with distribution
2. Add to distribution tables in `docs/DISTRIBUTIONS.md`
3. Test capability flags work correctly
4. Check CVE patch status for that distribution
5. Update `docs/CVE-TRACKING.md` if needed
6. Add to `meta/main.yml` platforms list
7. Update README.md badges
8. Update `docs/CHANGELOG.md` under `[Unreleased]` → `### Added`

### Responding to a New CVE

1. Research CVE on openssh.com/security.html and NVD
2. Check all 15 distributions' patch status
3. Determine if role configuration provides mitigation
4. Update `docs/CVE-TRACKING.md` with comprehensive status
5. Update defaults/templates if mitigation needed
6. Update `docs/CHANGELOG.md` under `[Unreleased]` → `### Security`

### Updating Cryptographic Standards

1. Check OpenSSH release notes for new algorithms
2. Review Mozilla/NSA/BSI/ANSSI guidance updates
3. Test algorithm availability on Debian Stretch (oldest)
4. Update `defaults/main.yml` with new preferences
5. Add capability flags if version-specific
6. Update `docs/COMPLIANCE.md` if affects compliance
7. Update `docs/CHANGELOG.md` under `[Unreleased]` → `### Changed` or `### Security`

## Language and Terminology

### Preferred Language

- Use **clear, direct language**: "comprehensive", "robust", "sophisticated attacks"
- Avoid **buzzwords**: "enterprise-grade", "enterprise-level", "nation-state level", "APTs"
- Prefer **technical accuracy** over impressive-sounding claims

### Code Comments

- Explain **why**, not just **what**
- Reference compliance requirements where applicable
- Use comments to make configuration self-documenting

## Questions?

- Check existing [documentation](../README.md)
- Review [AGENTS.md](../AGENTS.md) for detailed development guidelines
- Open an issue for discussion
- Check git commit history for examples

## Recognition

Contributors will be:

- Listed in git commit history
- Recognized in release notes
- Credited in docs/CHANGELOG.md for significant contributions

Thank you for helping make this project better! 🚀

---

*Last updated: 2025-10-05*
