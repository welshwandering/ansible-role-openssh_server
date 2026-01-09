---
name: 🐛 Bug Report
about: Report a bug or unexpected behavior
title: '[BUG] '
labels: bug
assignees: ''
---

## Bug Description

<!-- Provide a clear and concise description of the bug -->

## Current Behavior

<!-- What is happening? Be specific. -->

## Expected Behavior

<!-- What should happen instead? -->

## Steps to Reproduce

<!-- Provide detailed steps to reproduce the issue -->

1.
2.
3.

## Environment

**Distribution:**
- [ ] Debian (version: ___)
- [ ] Ubuntu (version: ___)

**OpenSSH Version:**
```bash
# Output of: ssh -V

```

**Ansible Version:**
```bash
# Output of: ansible --version

```

**Role Version:**
<!-- Git commit, release tag, or "latest from main" -->

## Configuration

**Relevant Role Variables:**
```yaml
# Include relevant variables from your playbook
# ⚠️ REMOVE ANY SENSITIVE DATA (passwords, keys, IP addresses)

```

## Error Output

<!-- If applicable, include error messages or logs -->

```
Paste error messages here
```

## Additional Context

<!-- Add any other context about the problem -->

- Does this affect a specific compliance framework? (PCI DSS, HIPAA, etc.)
- Is this related to a specific CVE?
- Any relevant links or references?

## Checklist

- [ ] I have searched existing issues to avoid duplicates
- [ ] I have read the [documentation](https://github.com/agh/ansible-role-openssh_server/blob/main/README.md)
- [ ] I have checked [TROUBLESHOOTING.md](https://github.com/agh/ansible-role-openssh_server/blob/main/docs/TROUBLESHOOTING.md)
- [ ] I have removed sensitive data from examples
