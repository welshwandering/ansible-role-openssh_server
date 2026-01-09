<!-- Use this template for substantial changes: features, security updates, breaking changes -->

## Description

<!-- Comprehensive description of what this PR does -->

## Related Issues

Fixes #
Related to #

## Type of Change

- [ ] ✨ New feature
- [ ] 💥 Breaking change
- [ ] 🔐 Security fix/improvement
- [ ] ⚡ Performance improvement
- [ ] 🐛 Bug fix (complex)
- [ ] 🧹 Major refactoring

## Detailed Changes

### What Changed

<!-- Technical details of the changes -->

### Why These Changes

<!-- Motivation and context -->

### How It Was Implemented

<!-- Implementation approach and decisions made -->

## Testing

### Test Environment

**Distribution(s) Tested:**
- [ ] Debian Stretch (7.4p1)
- [ ] Debian Buster (7.9p1)
- [ ] Debian Bullseye (8.4p1)
- [ ] Debian Bookworm (9.2p1)
- [ ] Debian Trixie/Forky (10.0p1)
- [ ] Ubuntu 16.04 Xenial (7.2p2)
- [ ] Ubuntu 18.04 Bionic (7.6p1)
- [ ] Ubuntu 20.04 Focal (8.2p1)
- [ ] Ubuntu 22.04 Jammy (8.9p1)
- [ ] Ubuntu 24.04 Noble (9.6p1)

### Test Procedure

1.
2.
3.

### Test Results

```bash
# Paste relevant test output

```

## Impact Assessment

### Backwards Compatibility

- [ ] Fully backwards compatible
- [ ] May require configuration updates
- [ ] Breaking change (describe migration path below)

**Migration Path (if breaking):**

### Affected Components

- [ ] Core role (tasks/main.yml)
- [ ] Variables (defaults/main.yml)
- [ ] Templates (templates/sshd_config.j2)
- [ ] Capability flags (version detection)
- [ ] Documentation
- [ ] Examples

### Compliance Impact

- [ ] No compliance impact
- [ ] Affects compliance framework(s): ___
- [ ] Adds compliance support: ___
- [ ] Requires docs/COMPLIANCE.md update

### Security Impact

- [ ] No security impact
- [ ] Improves security
- [ ] Fixes CVE: ___
- [ ] Changes security defaults
- [ ] Requires docs/CVE-TRACKING.md update

**Security Research (if applicable):**

**CVE Numbers:**

**Authoritative Sources:**
-
-

**Distribution Security Tracker Verification:**
-

## Documentation Updates

- [ ] README.md updated
- [ ] docs/CHANGELOG.md updated (REQUIRED)
- [ ] docs/DISTRIBUTIONS.md updated
- [ ] docs/COMPLIANCE.md updated
- [ ] docs/CVE-TRACKING.md updated
- [ ] docs/CONFIGURATION.md updated
- [ ] docs/EXAMPLES.md updated
- [ ] examples/ playbooks updated

**docs/CHANGELOG.md Entry:**
```markdown
## [Unreleased]

### Added/Changed/Fixed/Security
-

```

## Code Quality

### Validation Results

```bash
# yamllint output
yamllint .

# ansible-lint output
ansible-lint --profile=production
```

### Standards Compliance

- [ ] FQCN used throughout
- [ ] Booleans use `true`/`false`
- [ ] Line length < 160 characters
- [ ] YAML files start with `---`
- [ ] Proper comments for complex logic
- [ ] Follows CONTRIBUTING.md standards

## Breaking Changes Details

<!-- If breaking change, provide comprehensive details -->

**What Breaks:**

**Why This Break Is Necessary:**

**Deprecation Timeline:**

**User Action Required:**

## Performance Considerations

<!-- For performance-related changes -->

**Benchmarks:**

**Resource Impact:**

## Additional Context

<!-- Screenshots, links, references, etc. -->

## Reviewer Guidance

<!-- What should reviewers focus on? Any specific concerns? -->

## Pre-Submission Checklist

- [ ] Read CONTRIBUTING.md
- [ ] Searched existing PRs
- [ ] Tested on multiple distributions
- [ ] All validation passes
- [ ] docs/CHANGELOG.md updated
- [ ] Documentation complete
- [ ] Security claims verified
- [ ] Ready for review

---

Thank you for your comprehensive contribution! 🎉
