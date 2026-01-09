## Description

<!-- Provide a clear and concise description of what this PR does -->

## Related Issues

<!-- Link to related issues using "Fixes #123" or "Closes #456" -->

Fixes #

## Type of Change

<!-- Check all that apply -->

- [ ] 🐛 Bug fix (non-breaking change that fixes an issue)
- [ ] ✨ New feature (non-breaking change that adds functionality)
- [ ] 💥 Breaking change (fix or feature that would cause existing functionality to change)
- [ ] 📝 Documentation update
- [ ] 🔐 Security fix or improvement
- [ ] 🧹 Refactoring (no functional changes)
- [ ] ⚡ Performance improvement

## Changes Summary

<!-- Briefly describe the changes -->

-
-
-

## Testing

**Distribution(s) Tested:**
- [ ] Debian (version: ___)
- [ ] Ubuntu (version: ___)

**Validation:**
```bash
# yamllint output
yamllint .

# ansible-lint output
ansible-lint --profile=production
```

## Impact Assessment

**Backwards Compatibility:**
- [ ] Fully backwards compatible
- [ ] Requires documentation update
- [ ] Breaking change

**Affected Components:**
- [ ] Core role (tasks/defaults/templates)
- [ ] Documentation
- [ ] Examples
- [ ] Compliance frameworks
- [ ] Security/CVE tracking

## Documentation

<!-- Required for all changes -->

- [ ] Updated docs/CHANGELOG.md (REQUIRED)
- [ ] Updated README.md (if needed)
- [ ] Updated docs/ files (if needed)
- [ ] Updated examples/ (if needed)

**docs/CHANGELOG.md Entry:**
```markdown
## [Unreleased]

### Added/Changed/Fixed/Security
-

```

## Code Quality Checklist

- [ ] ✅ Passes `yamllint .`
- [ ] ✅ Passes `ansible-lint --profile=production`
- [ ] ✅ FQCN used throughout
- [ ] ✅ Booleans use `true`/`false` (not `yes`/`no`)
- [ ] ✅ Self-reviewed for errors
- [ ] ✅ Comments added for complex logic
- [ ] ✅ Follows [CONTRIBUTING.md](docs/CONTRIBUTING.md) standards

## Security Checklist

<!-- For security-related changes -->

- [ ] Security claims backed by authoritative sources
- [ ] CVE status verified on distribution security trackers
- [ ] No sensitive data in examples
- [ ] Backwards compatibility maintained

**Sources (if applicable):**
-

## Pre-Submission Checklist

- [ ] I have read [CONTRIBUTING.md](docs/CONTRIBUTING.md)
- [ ] I have searched existing PRs to avoid duplicates
- [ ] I have tested my changes
- [ ] All validation checks pass
- [ ] docs/CHANGELOG.md is updated
- [ ] I am ready for review

---

Thank you for contributing to ansible-role-openssh_server! 🚀
