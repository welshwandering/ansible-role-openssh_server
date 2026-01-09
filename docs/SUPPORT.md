# Getting Support

Thank you for using **ansible-role-openssh_server**! This document explains how to get help with this OpenSSH server hardening role.

## Important Note

**This is a volunteer-run hobby project.** Maintainers contribute in their spare time. We appreciate your patience and understanding as we help where we can.

## Before Asking for Help

Please try these steps first—they often solve problems quickly:

### 1. Read the Documentation

Start with our comprehensive documentation:

- **[README.md](../README.md)**: Quick start, features, and overview
- **[docs/CONFIGURATION.md](CONFIGURATION.md)**: Complete variable reference
- **[docs/DISTRIBUTIONS.md](DISTRIBUTIONS.md)**: Supported distributions and version compatibility
- **[docs/EXAMPLES.md](EXAMPLES.md)**: Configuration examples for common scenarios
- **[docs/TROUBLESHOOTING.md](TROUBLESHOOTING.md)**: Common issues and solutions
- **[docs/CVE-TRACKING.md](CVE-TRACKING.md)**: CVE status and patch tracking
- **[docs/COMPLIANCE.md](COMPLIANCE.md)**: Compliance framework mappings

### 2. Search Existing Issues

Someone may have already encountered your problem:

1. Go to [GitHub Issues](https://github.com/welshwandering/ansible-role-openssh_server/issues)
2. Search for keywords related to your issue
3. Check both open and closed issues
4. Look for the answer in issue comments

### 3. Check Your Configuration

Many issues are configuration-related:

- Verify your Ansible version: `ansible --version` (need 2.15+)
- Check your OpenSSH version: `ssh -V`
- Confirm your distribution is supported (see [docs/DISTRIBUTIONS.md](DISTRIBUTIONS.md))
- Review your role variables for typos or incorrect values
- Test with default variables to isolate the issue

### 4. Enable Verbose Output

Get more details about what's happening:

```bash
# Run playbook with verbose output
ansible-playbook -vvv your-playbook.yml

# Validate SSH configuration
sudo sshd -t
```

## How to Get Help

### For General Questions

**GitHub Discussions** (Coming Soon)
- General questions about using the role
- "How do I...?" questions
- Configuration advice
- Best practices discussions

Until Discussions are enabled, use the question issue template:

**GitHub Issues** - Use the Question Template
1. Go to [New Issue](https://github.com/welshwandering/ansible-role-openssh_server/issues/new/choose)
2. Select "Question / Discussion"
3. Provide context about what you're trying to do
4. Include your environment details

### For Bug Reports

If you've found a bug in the role:

1. Go to [New Issue](https://github.com/welshwandering/ansible-role-openssh_server/issues/new/choose)
2. Select "Bug Report"
3. Fill out the template completely
4. Include:
   - Distribution and version
   - OpenSSH version
   - Ansible version
   - Role version (git commit or tag)
   - Relevant role variables
   - Error messages
   - Steps to reproduce

**Please remove sensitive data** (passwords, keys, IP addresses) from examples!

### For Security Issues

**⚠️ DO NOT use GitHub Issues for security vulnerabilities!**

See [docs/SECURITY.md](SECURITY.md) for how to report security issues privately.

### For Feature Requests

Have an idea for improving the role?

1. Check if it's already requested in [GitHub Issues](https://github.com/welshwandering/ansible-role-openssh_server/issues)
2. Use the [Feature Request template](https://github.com/welshwandering/ansible-role-openssh_server/issues/new/choose)
3. Explain the use case and why it would be valuable
4. Consider contributing the feature yourself (see [CONTRIBUTING.md](CONTRIBUTING.md))

## How to Ask Good Questions

Help us help you! Good questions get faster, better answers.

### Include Key Information

Always include:
- **Distribution and version**: "Debian 12 Bookworm" or "Ubuntu 22.04 Jammy"
- **OpenSSH version**: Output of `ssh -V`
- **Ansible version**: Output of `ansible --version`
- **Role version**: Git commit hash, tag, or "latest from main"

### Provide Context

Explain:
- What you're trying to achieve
- What you expected to happen
- What actually happened
- What you've already tried

### Show Your Work

Include:
- Relevant parts of your playbook (sanitize sensitive data!)
- Role variables you've configured
- Error messages (full text, not screenshots when possible)
- Output from validation: `sudo sshd -t`

### Create a Minimal Example

Reduce your problem to the smallest example that demonstrates the issue:

```yaml
# Good: Minimal example
- hosts: test
  roles:
    - role: openssh_server
      vars:
        openssh_password_authentication: false
        openssh_port: 2222
```

This is better than posting your entire 500-line playbook!

### Use Code Blocks

Format code and output properly:

````markdown
```yaml
# Your YAML here
```

```bash
# Command output here
```
````

## What NOT to Use GitHub Issues For

Please **do not** use GitHub Issues for:

### Personal Configuration Help

GitHub Issues are for bugs and features in the **role itself**, not debugging your specific infrastructure.

**Instead**:
- Review [docs/TROUBLESHOOTING.md](TROUBLESHOOTING.md)
- Check [docs/EXAMPLES.md](EXAMPLES.md)
- Post a question using the question template (keep it focused on the role)

### OpenSSH Software Issues

This role configures OpenSSH—it doesn't fix bugs in OpenSSH itself.

**Instead**:
- OpenSSH bugs: https://www.openssh.com/report.html
- OpenSSH security: https://www.openssh.com/security.html

### Distribution-Specific Package Issues

We track CVE status, but we don't fix vulnerabilities in OS packages.

**Instead**:
- Debian bugs: https://www.debian.org/Bugs/
- Ubuntu bugs: https://bugs.launchpad.net/ubuntu
- Debian security: https://security-tracker.debian.org/
- Ubuntu security: https://ubuntu.com/security

### Ansible Core Issues

Problems with Ansible itself should go to the Ansible project.

**Instead**: https://github.com/ansible/ansible/issues

## Community Support

### Help Others

If you have experience with this role:
- Answer questions in issues
- Share your configurations (sanitized!)
- Review pull requests
- Improve documentation

Your contributions help build a stronger community!

### Share Your Success

Found a great way to use this role? Let us know:
- Share in discussions (when available)
- Write a blog post and tell us about it
- Contribute an example to [examples/](../examples/)

## Commercial Support

This is an open source hobby project. **No commercial support is available.**

However, you can:
- Hire Ansible consultants who can help with your infrastructure
- Engage security consultants familiar with SSH hardening
- Use this role as-is under the MIT License

## Response Time Expectations

**This is a volunteer-run hobby project.** Please understand:

- Responses will come as maintainer time permits
- There are no guaranteed response times
- Simple questions may get quick answers
- Complex issues may take longer
- Critical security issues will be prioritized

We appreciate your patience!

## Contributing

Want to help improve this project?

- See [docs/CONTRIBUTING.md](CONTRIBUTING.md) for how to contribute
- Review [AGENTS.md](../AGENTS.md) for development guidelines
- Check out [docs/PULL_REQUEST_TEMPLATE.md](PULL_REQUEST_TEMPLATE.md) for PR expectations

## Additional Resources

### SSH Security Resources

- **OpenSSH**: https://www.openssh.com/
- **Mozilla OpenSSH Guidelines**: https://infosec.mozilla.org/guidelines/openssh
- **NIST SP 800-52**: https://csrc.nist.gov/publications/detail/sp/800-52/rev-2/final

### Ansible Resources

- **Ansible Documentation**: https://docs.ansible.com/
- **Ansible Galaxy**: https://galaxy.ansible.com/
- **Best Practices**: https://docs.ansible.com/ansible/latest/tips_tricks/ansible_tips_tricks.html

### Compliance Resources

See [docs/COMPLIANCE.md](COMPLIANCE.md) for links to compliance frameworks and standards.

## Thank You

Thank you for using ansible-role-openssh_server! We're glad to have you in our community.

Remember:
- 📖 Documentation first
- 🔍 Search before asking
- 🎯 Provide details when asking
- 🤝 Help others when you can
- 💚 Be patient and kind

Happy hardening! 🔒

---

*Last updated: 2025-10-05*
