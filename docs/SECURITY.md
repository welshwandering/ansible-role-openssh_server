# Security Policy

## Our Commitment to Security

The ansible-role-openssh_server project is dedicated to helping administrators secure their SSH infrastructure. We take security vulnerabilities in this role very seriously and appreciate responsible disclosure from the security research community.

This role helps protect critical infrastructure, compliance-regulated systems, and sensitive data worldwide. Security issues in this role could affect thousands of systems, so we handle vulnerability reports with urgency and care.

## Supported Versions

We provide security updates for the following versions of this role:

| Version | Supported          | Status |
| ------- | ------------------ | ------ |
| 1.x     | :white_check_mark: | Current stable release - actively maintained |
| < 1.0   | :x:                | Pre-release versions - not supported |

**Note**: We maintain only the latest major version. When 2.x is released, 1.x will receive security updates for 90 days before being deprecated.

## What Qualifies as a Security Vulnerability

We consider the following to be security vulnerabilities:

### High Priority

- **Configuration that weakens SSH security**: Role generates insecure SSH configurations (e.g., weak ciphers, disabled authentication)
- **Privilege escalation**: Role allows unauthorized privilege escalation on managed systems
- **Credential exposure**: Role logs, displays, or stores credentials insecurely
- **Arbitrary code execution**: Role allows execution of arbitrary code on managed systems
- **Authentication bypass**: Role configuration allows bypassing SSH authentication

### Medium Priority

- **Information disclosure**: Role exposes sensitive system information unnecessarily
- **Denial of service**: Role configuration makes SSH service unavailable
- **Insecure defaults**: Role defaults do not follow security best practices
- **CVE tracking errors**: Role documentation incorrectly reports CVE patch status

### Not Security Vulnerabilities

The following are **not** considered security vulnerabilities in this role:

- OpenSSH vulnerabilities (report to OpenSSH project: https://www.openssh.com/security.html)
- Distribution-specific SSH package vulnerabilities (report to Debian/Ubuntu security teams)
- Issues requiring physical access to the system
- Social engineering attacks
- Documentation typos or formatting issues (open a regular issue)
- Feature requests or enhancement suggestions (open a regular issue)

## Reporting a Vulnerability

**⚠️ DO NOT report security vulnerabilities through public GitHub issues.**

### Reporting a Vulnerability
 
We take security seriously. If you discover a vulnerability, please report it via [GitHub Security Advisories](https://github.com/welshwandering/ansible-role-openssh_server/security/advisories/new).
 
**DO NOT** open a public issue for sensitive security vulnerabilities.

### Alternative Method: Private Email

If you cannot use GitHub Security Advisories, email the maintainer directly:

- **Email**: See repository maintainer contact information
- **Subject line**: `[SECURITY] ansible-role-openssh_server: Brief description`
- **PGP Key**: Available upon request for encrypted communication

### What to Include in Your Report

To help us understand and address the issue quickly, please include:

1. **Vulnerability Description**
   - What is the vulnerability?
   - What is the impact?
   - Who is affected?

2. **Reproduction Steps**
   - Detailed steps to reproduce the issue
   - Example playbook or configuration
   - Distribution and OpenSSH version affected

3. **Proof of Concept**
   - If possible, provide a PoC (sanitized of any sensitive data)
   - Screenshots or terminal output (with sensitive data removed)

4. **Suggested Fix** (optional)
   - If you have ideas for remediation, we'd love to hear them
   - Pull requests for fixes are welcome after coordinated disclosure

5. **Your Contact Information**
   - How should we contact you for follow-up?
   - Do you want to be credited in the advisory?

## Our Response Process

### Response Process

**Important**: This is a volunteer-run hobby project. While we take security seriously, responses will happen as maintainer time permits.

1. **Acknowledgment**: We'll confirm receipt when we can
2. **Assessment**: We'll evaluate the severity and impact
3. **Updates**: We'll keep you informed as we work on it
4. **Fix Development**: Timeline depends on severity and maintainer availability
5. **Coordinated Disclosure**: We'll work with you on timing

### Our Commitment

We take security seriously and will prioritize critical issues, but please understand:
- This is maintained by volunteers in their spare time
- Response times will vary based on maintainer availability
- Critical issues will be addressed as quickly as possible
- Less severe issues may take longer

We appreciate your patience and understanding.

### What Happens After You Report

1. **We acknowledge your report** and confirm receipt
2. **We assess the vulnerability** and determine severity
3. **We work on a fix** in a private repository
4. **We keep you informed** of our progress
5. **We coordinate disclosure** with you on timing and details
6. **We release the fix** and publish a security advisory
7. **We credit you** in the advisory (if you wish)

## Security Advisory Process

When we fix a security vulnerability:

1. **Private fix development**: We develop the fix in a private fork
2. **Security testing**: We test the fix across all supported distributions
3. **Documentation update**: We update `docs/CVE-TRACKING.md` and `docs/CHANGELOG.md`
4. **Coordinated disclosure**: We coordinate with reporter on disclosure timing
5. **Public release**: We release the fix and publish a security advisory
6. **User notification**: We tag the release and update documentation

## Security Best Practices for Users

While we work to keep this role secure, users should also follow these practices:

### Before Using This Role

- **Review the role**: Read the code before running it in production
- **Test first**: Always test in non-production environments
- **Pin versions**: Use specific git tags or commits, not `main` branch
- **Review changes**: Check diffs when updating to new versions

### When Deploying

- **Use version control**: Store your playbooks in git with proper access controls
- **Protect credentials**: Use Ansible Vault for sensitive variables
- **Limit access**: Restrict who can modify your Ansible playbooks
- **Audit logs**: Enable logging for Ansible playbook runs

### After Deployment

- **Monitor advisories**: Watch this repository for security advisories
- **Stay updated**: Apply role updates promptly
- **Test updates**: Test updates in non-production before deploying
- **Review configurations**: Periodically review generated SSH configurations

## Scope of This Security Policy

### In Scope

- Security vulnerabilities in this Ansible role's code
- Insecure default configurations
- Documentation errors about security or CVE status
- Compliance framework mapping errors

### Out of Scope

- OpenSSH software vulnerabilities (report to OpenSSH project)
- Operating system vulnerabilities (report to Debian/Ubuntu)
- Ansible core vulnerabilities (report to Ansible project)
- Third-party module vulnerabilities (report to module maintainers)
- Infrastructure security (your Ansible control node, SSH keys, etc.)

## CVE Tracking and Updates

This role maintains comprehensive CVE tracking in [docs/CVE-TRACKING.md](docs/CVE-TRACKING.md). We monitor:

- OpenSSH security advisories: https://www.openssh.com/security.html
- Debian security tracker: https://security-tracker.debian.org/
- Ubuntu security bulletins: https://ubuntu.com/security/cves
- NVD database: https://nvd.nist.gov/

When new OpenSSH CVEs are published, we:

1. Assess impact on all supported distributions
2. Verify patch status on distribution security trackers
3. Update `docs/CVE-TRACKING.md` with accurate information
4. Implement configuration mitigations if needed
5. Update `docs/CHANGELOG.md` under `### Security`

**Note**: We track CVEs affecting OpenSSH, but we do not fix vulnerabilities in OpenSSH itself. Distribution security teams handle that.

## Recognition

Security researchers who responsibly disclose vulnerabilities are recognized in [docs/CONTRIBUTORS.md](CONTRIBUTORS.md) under "Security Researchers."

## Questions About Security?

- **General security questions**: Open a [discussion issue](https://github.com/welshwandering/ansible-role-openssh_server/issues/new?template=security.md)
- **Security vulnerabilities**: Use the reporting process above
- **CVE status questions**: Check [docs/CVE-TRACKING.md](docs/CVE-TRACKING.md) or open a discussion
- **Compliance questions**: Check [docs/COMPLIANCE.md](docs/COMPLIANCE.md) or open a discussion

## Additional Resources

- **OpenSSH Security**: https://www.openssh.com/security.html
- **CVE Tracking**: [docs/CVE-TRACKING.md](docs/CVE-TRACKING.md)
- **Compliance Frameworks**: [docs/COMPLIANCE.md](docs/COMPLIANCE.md)
- **Contributing Guidelines**: [docs/CONTRIBUTING.md](docs/CONTRIBUTING.md)
- **Security Discussion Template**: [.github/ISSUE_TEMPLATE/security.md](.github/ISSUE_TEMPLATE/security.md)

## Thank You

Thank you for helping keep ansible-role-openssh_server and the broader SSH ecosystem secure. Your responsible disclosure makes the internet safer for everyone.

---

*Last updated: 2025-10-05*
*Security Policy Version: 1.0*
