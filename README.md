# Ansible Role: openssh_server

[![CI](https://img.shields.io/badge/CI-ready-brightgreen)](https://github.com/welshwandering/ansible-role-openssh_server)
[![Debian](https://img.shields.io/badge/Debian-11%20to%2014-A81D33?style=for-the-badge&logo=debian&logoColor=white)](docs/DISTRIBUTIONS.md)
[![Ubuntu](https://img.shields.io/badge/Ubuntu-22.04%20to%2025.10-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)](docs/DISTRIBUTIONS.md)
[![Rocky Linux](https://img.shields.io/badge/Rocky_Linux-8%20to%2010-10B981?style=for-the-badge&logo=rocky-linux&logoColor=white)](docs/DISTRIBUTIONS.md)
[![Fedora](https://img.shields.io/badge/Fedora-43-51A2DA?style=for-the-badge&logo=fedora&logoColor=white)](docs/DISTRIBUTIONS.md)
![Ansible](https://img.shields.io/badge/Ansible-EE0000?style=for-the-badge&logo=ansible&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)](LICENSE)
[![Security](https://img.shields.io/badge/security-policy-blue.svg)](docs/SECURITY.md)
[![Debian](https://img.shields.io/badge/debian-9%20to%2013-red.svg)](docs/DISTRIBUTIONS.md)
[![Ubuntu](https://img.shields.io/badge/ubuntu-16.04%20to%2025.10-orange.svg)](docs/DISTRIBUTIONS.md)

Comprehensive OpenSSH server hardening for Debian and Ubuntu systems with support for 16 compliance frameworks, extensive CVE tracking, and version-aware capability detection.

## ✨ Features

- 🔒 **Security-First**: Comprehensive hardening with modern cryptography
- 📋 **16 Compliance Frameworks**: PCI DSS, HIPAA, FedRAMP, FISMA, SOC 2, GDPR, ISO 27001+
- 🛡️ **CVE Tracking**: Comprehensive mitigation status for 20+ OpenSSH vulnerabilities
- 🌍 **Supported Distributions**:
  - **Debian**: 11 (Bullseye), 12 (Bookworm), 13 (Trixie), 14 (Forky/Testing)
  - **Ubuntu**: 22.04 LTS, 24.04 LTS, 25.10
  - **Rocky Linux**: 8, 9, 10
- 🔐 **Post-Quantum Ready**: ML-KEM support for OpenSSH 9.9+
- 🔑 **FIDO2/WebAuthn**: Hardware security key authentication
- 📊 **13 Capability Flags**: Automatic feature detection and version-aware configuration

## 🚀 Quick Start

### Installation

Add to your `requirements.yml`:

```yaml
roles:
  - src: https://github.com/welshwandering/ansible-role-openssh_server
    name: openssh_server
    scm: git
```

Then install:

```bash
ansible-galaxy install -r requirements.yml
```

### Basic Usage

```yaml
---
- hosts: all
  become: true
  roles:
    - role: openssh_server
```

### Advanced Configuration

```yaml
---
- hosts: production_servers
  become: true
  roles:
    - role: openssh_server
      vars:
        # Disable password authentication
        openssh_password_authentication: false

        # Restrict root login
        openssh_permit_root_login: "prohibit-password"

        # Enable advanced security features (version-aware)
        openssh_enable_persourcepenalties: true
        openssh_enable_verbose_logging: true
        openssh_required_rsa_size: 3072

        # Limit access to specific users
        openssh_allow_users:
          - deploy
          - admin
```

## 📚 Documentation

- **[Distribution Support](docs/DISTRIBUTIONS.md)** - Debian/Ubuntu version matrix and capability flags
- **[Compliance Frameworks](docs/COMPLIANCE.md)** - PCI DSS, HIPAA, FedRAMP, SOC 2, GDPR, ISO 27001+
- **[CVE Tracking](docs/CVE-TRACKING.md)** - Vulnerability status by distribution with patch details
- **[Configuration Reference](docs/CONFIGURATION.md)** - Complete role variables documentation
- **[Examples](docs/EXAMPLES.md)** - Configuration examples for different use cases
- **[Troubleshooting](docs/TROUBLESHOOTING.md)** - Common issues and debugging

## 🔧 Requirements

- **Ansible**: 2.15+
- **Platform**: Debian 9+ or Ubuntu 16.04+
- **Collections**:
  - `ansible.posix` >= 1.5.0
  - `community.general` >= 8.0.0

## 🔐 Security Features

### Core Security

- ✅ **Key-based authentication only** (password auth disabled by default)
- ✅ **Modern cryptography** (ChaCha20-Poly1305, AES-GCM preferred over AES-CTR)
- ✅ **Strong key exchange** (Curve25519, DH Group 16/18)
- ✅ **Configuration validation** (sshd -t before applying)
- ✅ **Automatic backups** (previous config saved)
- ✅ **Login attempt limits** (MaxAuthTries, LoginGraceTime)
- ✅ **Client keepalive** (prevents hung connections)
- ✅ **Comprehensive logging** (VERBOSE level with optional LogVerbose)

### Advanced Security Features (Version-Aware)

- **OpenSSH 10.0+**: ML-KEM Post-Quantum Cryptography, Enhanced AES-GCM preference
- **OpenSSH 9.8+**: PerSourcePenalties (automatic rate limiting)
- **OpenSSH 9.3+**: RequiredRSASize (enforce 3072-bit RSA minimum)
- **OpenSSH 8.5+**: LogVerbose (enhanced forensic logging)
- **OpenSSH 8.2+**: FIDO2/WebAuthn hardware security key support
- **All Versions**: Session re-keying, certificate authority support, moduli verification

## 🌍 Compliance Support

This role supports compliance with 16 major regulatory frameworks and standards:

**Financial Services**: PCI DSS 4.0, SOX, SAMA CSF
**Healthcare & Privacy**: HIPAA, HITRUST CSF, GDPR
**Cloud Standards**: ISO/IEC 27017, 27018, 27037, 27040, 27701
**Government**: FedRAMP, FISMA, NERC CIP, NCA ECC, UAE IA
**Trust Frameworks**: SOC 2

See [docs/COMPLIANCE.md](docs/COMPLIANCE.md) for detailed compliance mappings.

## 🛡️ CVE Mitigation

The role provides comprehensive protection against 20+ OpenSSH vulnerabilities:

- **CVE-2024-6387** ("regreSSHion"): Patched on all current LTS distributions
- **CVE-2023-48795** (Terrapin Attack): Patched via vendor backports
- **CVE-2023-38408** (PKCS#11 RCE): Patched on all distributions
- **And many more...** See [docs/CVE-TRACKING.md](docs/CVE-TRACKING.md) for complete status

## 📋 Example Playbooks

See the [examples/](examples/) directory for complete playbooks:

- `basic-hardening.yml` - Simple SSH hardening
- `pci-dss-compliance.yml` - PCI DSS 4.0 configuration
- `fedramp.yml` - FedRAMP Moderate & High baseline
- `maximum-security.yml` - Maximum security hardening
- `fido2-hardware-keys.yml` - Security key authentication

## 🤝 Contributing

Contributions are welcome! This role is designed to be community-driven.

Please see [CONTRIBUTING.md](docs/CONTRIBUTING.md) for detailed guidelines on:

- Development workflow and coding standards
- Testing requirements and validation
- Documentation expectations
- Pull request process
- Security contribution guidelines

## 📝 License

MIT License - Copyright (c) 2025 Gravitino LLC

See [LICENSE](LICENSE) for full details.

---
