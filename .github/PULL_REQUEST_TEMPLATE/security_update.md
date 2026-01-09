<!-- Use this template for security-related changes: CVE fixes, security improvements, compliance updates -->

## Security Update Description

<!-- What security issue does this address? -->

## Security Context

**Type:**
- [ ] CVE fix
- [ ] Security improvement (no CVE)
- [ ] Compliance framework update
- [ ] Cryptographic standard update
- [ ] Security feature addition

**Urgency:**
- [ ] Critical (active exploitation)
- [ ] High (publicly disclosed vulnerability)
- [ ] Medium (security improvement)
- [ ] Low (proactive hardening)

## CVE Information (if applicable)

**CVE Number(s):**

**CVSS Score:**

**Affected OpenSSH Versions:**

**Fixed in OpenSSH Version:**

## Distribution Patch Status

<!-- Verify patch status on all supported distributions -->

**Debian:**
- [ ] Stretch: ___
- [ ] Buster: ___
- [ ] Bullseye: ___
- [ ] Bookworm: ___
- [ ] Trixie/Forky: ___

**Ubuntu:**
- [ ] 16.04 Xenial: ___
- [ ] 18.04 Bionic: ___
- [ ] 20.04 Focal: ___
- [ ] 22.04 Jammy: ___
- [ ] 24.04 Noble: ___

## Security Research & Verification

**Official Sources:**
- OpenSSH Advisory:
- NVD/CVE Database:
- Vendor Security Bulletin:

**Distribution Security Trackers:**
- Debian: https://security-tracker.debian.org/tracker/CVE-
- Ubuntu: https://ubuntu.com/security/CVE-

**Additional Research:**
-

## Changes Made

### Security Mitigation

<!-- How does this PR mitigate the security issue? -->

### Implementation Details

<!-- Technical details of the security fix -->

### Configuration Changes

<!-- What configuration defaults changed? -->

```yaml
# Before


# After

```

## Testing

**Tested On:**
- [ ] Legacy (Debian Bullseye or Ubuntu 20.04)
- [ ] Modern (Debian Bookworm or Ubuntu 22.04)
- [ ] Latest (Debian Trixie or Ubuntu 24.04)

**Verification Steps:**

1.
2.
3.

**Test Results:**
```bash
# Evidence that mitigation is effective

```

## Impact Assessment

### User Impact

<!-- How does this affect existing deployments? -->

- [ ] No action required (automatic mitigation)
- [ ] Requires role variable update
- [ ] Requires playbook re-run
- [ ] Breaking change (see migration below)

### Compliance Impact

**Frameworks Affected:**
-

### Backwards Compatibility

- [ ] Fully backwards compatible
- [ ] Compatible with version-aware fallback
- [ ] Requires minimum OpenSSH version: ___
- [ ] Breaking change

## Documentation Updates

- [ ] docs/CVE-TRACKING.md updated with this CVE
- [ ] docs/COMPLIANCE.md updated (if applicable)
- [ ] docs/CHANGELOG.md updated under `### Security`
- [ ] README.md updated (if needed)
- [ ] Security advisory created (if critical)

**docs/CHANGELOG.md Entry:**
```markdown
## [Unreleased]

### Security
- Fixed CVE-YYYY-XXXXX: [description]
  - Affects: [distributions/versions]
  - Mitigation: [approach]
  - References: [links to security trackers]

```

## Code Quality

### Validation

- [ ] ✅ Passes `yamllint .`
- [ ] ✅ Passes `ansible-lint --profile=production`
- [ ] ✅ Security claims verified with authoritative sources
- [ ] ✅ All security tracker links valid
- [ ] ✅ No sensitive data in examples

## Communication Plan

<!-- For critical security issues -->

- [ ] Security advisory draft prepared
- [ ] Severity assessment complete
- [ ] User notification plan ready
- [ ] Coordinated disclosure timeline established (if applicable)

## Pre-Submission Security Checklist

- [ ] All security claims backed by authoritative sources
- [ ] CVE status verified on official distribution trackers
- [ ] Patch status confirmed for all supported distributions
- [ ] No false vulnerability claims
- [ ] Security researchers credited (if applicable)
- [ ] Coordinated disclosure respected (if applicable)
- [ ] Documentation accurate and complete
- [ ] Ready for expedited security review

---

Thank you for improving the security of this project! 🔒
