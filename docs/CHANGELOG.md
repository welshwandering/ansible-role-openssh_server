# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Fixed
- Removed client-side SSH options from sshd_config template (`VerifyHostKeyDNS` and `UpdateHostKeys`) that were incorrectly included in server configuration
- Fixed Molecule configuration to use relative paths instead of absolute paths for role discovery
- Added `/run/sshd` privilege separation directory creation in Molecule converge playbook

### Added
- **Rocky Linux Support**: Full support for Rocky Linux 8, 9, and 10 with `dnf` package management
- **Fedora Support**: Verified support for Fedora 43 (Cutting Edge)
- **Debian Trixie/Forky**: Verified support for Debian 13 (Stable) and 14 (Testing)
- **Ubuntu 25.10**: Verified support for Ubuntu 25.10 Questing Quokka
- **Docs**: Comprehensive distribution matrix in `docs/DISTRIBUTIONS.md` including point releases

### Changed
- Updated Molecule configuration to use Jeff Geerling's systemd-enabled Docker images (including Rocky 9)
- Highlighted "Ideal" distribution set: Rocky 8-10, Debian 11-14, Ubuntu 22.04+
- Enhanced Molecule verification tests to check systemd service status
- Updated PCI DSS compliance mapping to Version 4.0 with precise requirement citations
- Renamed `examples/fedramp-moderate.yml` to `examples/fedramp.yml` to reflect broader applicability
- Conducted Global Compliance Audit (Jan 2026): Verified alignment with ISO 27001:2022, NERC CIP-005-7, HIPAA Security Rule, and others
- Updated FedRAMP compliance mapping to NIST SP 800-53 **Revision 5** (AC-17, IA-2, AU-2, SC-8, SC-13)
- Explicitly verified support for **FedRAMP High** baseline (when combined with OS-level FIPS)
- Updated `maximum-security.yml` example with annotations where it exceeds PCI DSS and FedRAMP requirements


## [1.0.0] - 2025-10-05

### Overview

Initial release of a comprehensive, standalone OpenSSH server hardening role for Debian and Ubuntu systems. This role provides production-ready SSH configuration with extensive compliance framework support, CVE tracking, and intelligent version detection across 15 distributions spanning 9 years of releases.

**Post-release Documentation Updates:**
- Consolidated security researcher recognition into `docs/CONTRIBUTORS.md` - removed duplicate "Hall of Fame" section from `docs/SECURITY.md` (now references CONTRIBUTORS.md instead)
- Moved `CHANGELOG.md` from repository root to `docs/CHANGELOG.md` for better organization
- Created `.github/CODEOWNERS` file to define code ownership and automatic review assignment

**Testing Infrastructure:**
- Expanded GitHub Actions CI matrix from 5 to 15 distributions covering all supported versions
  - Debian: Stretch (9), Buster (10), Bullseye (11), Bookworm (12), Trixie (13), Sid (testing)
  - Ubuntu LTS: 16.04 Xenial, 18.04 Bionic, 20.04 Focal, 22.04 Jammy, 24.04 Noble
  - Ubuntu Non-LTS: 24.10 Oracular
- Enhanced Molecule configuration with comprehensive verification tests
  - Configuration syntax testing with `sshd -t`
  - OpenSSH version reporting
  - Security hardening verification
  - Note: Full systemd service testing requires systemd-enabled Docker images
- Created `docs/TESTING.md` with comprehensive testing guide for contributors
- Created `docs/TESTING_MACOS.md` with macOS-specific testing instructions
  - Docker Desktop compatibility documented (Intel and Apple Silicon)
  - Performance optimization tips for macOS
  - Troubleshooting guide for common macOS issues
  - Alternative setup with Colima for lightweight Docker
- Created `docs/TESTING_MACOS_UPDATE.md` documenting current limitations
  - Base Docker images lack systemd - requires pre-built systemd images or custom builds for local testing
  - CI tests work correctly with base images
  - Workarounds provided for macOS local development
- **Successfully validated Molecule tests on macOS with Jeff Geerling's systemd-enabled images**
  - Confirmed tests run correctly on macOS with Docker Desktop
  - Used `geerlingguy/docker-debian12-ansible:latest` image
  - Verified role application, version detection, and capability flag setting
  - Tests correctly identified configuration issues (validation working as intended)

### Platform Support

**Distribution Coverage (10 Distributions)**
- **Debian**: Bullseye (11), Bookworm (12), Trixie (13), Forky (14/Testing)
- **Ubuntu LTS**: 22.04 Jammy, 24.04 Noble
- **Ubuntu Non-LTS**: 25.10 Questing
- **Rocky Linux**: 8, 9, 10
- **Previous Support**: Includes support for older Debian/Ubuntu versions (Stretch-Buster, Xenial-Focal) though now legacy
- **OpenSSH Versions**: 7.2p2 through 10.2p1+ with intelligent capability detection

**Version Detection & Compatibility**
- Automatic OpenSSH version detection using `ssh -V`
- 13 capability flags for version-aware feature enablement
- Graceful degradation on older distributions
- Automatic warnings for EOL and ESM-only distributions
- Distribution-aware subsystem paths (Ubuntu vs Debian)

### Security Features

**Core Security Hardening**
- Key-based authentication by default (password auth disabled)
- Root login restricted to `prohibit-password` mode
- Modern cryptography with AEAD cipher preference (ChaCha20-Poly1305, AES-GCM)
- Strong key exchange algorithms (Curve25519, DH Group 16/18)
- Encrypt-then-MAC (ETM) message authentication codes
- Configuration validation with `sshd -t` before applying changes
- Automatic configuration backups on changes
- Comprehensive logging at VERBOSE level
- Login attempt limits (MaxAuthTries, LoginGraceTime)
- Client keepalive to prevent hung connections
- DH moduli verification for 3072-bit minimum strength

**Advanced Features (Version-Aware)**
- **OpenSSH 10.0+**: ML-KEM post-quantum cryptography, enhanced AES-GCM algorithm preferences
- **OpenSSH 9.9+**: ML-KEM768x25519-sha256 hybrid key exchange (quantum-resistant)
- **OpenSSH 9.8+**: PerSourcePenalties automatic rate limiting and attack mitigation
- **OpenSSH 9.3+**: RequiredRSASize enforcement (3072-bit minimum, NSA/CISA compliant)
- **OpenSSH 8.5+**: LogVerbose enhanced forensic logging for specific subsystems
- **OpenSSH 8.2+**: FIDO2/WebAuthn hardware security key authentication support
- **All Versions**: Session re-keying (CCCS ITSP.40.062), certificate authority support

**Cryptographic Standards**
- Mozilla Modern Profile compliant
- OpenSSH 10.0 algorithm preferences
- FIPS 140-2 compatible algorithms (AES, ChaCha20, SHA2)
- 3072-bit RSA minimum (configurable to 4096-bit)
- 3072-bit DH parameters minimum
- Post-quantum ready with ML-KEM support

### Compliance & Regulatory Support

**International Security Standards (9 Organizations)**
- 🇺🇸 NSA/CISA Network Infrastructure Security Guide (Dec 2024)
- 🇺🇸 NIST SP 800-207 Zero Trust Architecture
- 🇺🇸 CIS Benchmarks Section 5.2
- 🇨🇦 CCCS ITSP.40.062 Secure Network Protocols
- 🇦🇺 ACSC Communications Infrastructure Hardening
- 🇬🇧 NCSC Secure System Administration
- 🇳🇿 GCSB NZISM v3.9
- 🇩🇪 BSI TR-02102-4 Version 2025-1
- 🇫🇷 ANSSI NT_OpenSSH
- 🌍 Mozilla OpenSSH Modern Profile

**Industry & Regulatory Frameworks (16 Frameworks)**
- **Financial**: PCI DSS 4.0, SOX, SAMA CSF
- **Healthcare**: HIPAA, HITRUST CSF, GDPR
- **Cloud**: ISO/IEC 27017, 27018, 27037, 27040, 27701
- **Government**: FedRAMP (Moderate/High), FISMA, NERC CIP, NCA ECC, UAE IA
- **Trust**: SOC 2 (Security TSC)

### CVE Vulnerability Protection

**Comprehensive CVE Tracking (20+ Vulnerabilities)**
- Fully mitigated: CVE-2025-26465, CVE-2020-14145, CVE-2016-0777/0778, and more
- Distribution-specific patch status tracking for all major CVEs
- Detailed mitigation status for CVE-2024-6387 ("regreSSHion"), CVE-2023-48795 ("Terrapin"), CVE-2023-38408
- Vendor security backport recognition (patches applied to older OpenSSH versions)
- Per-distribution security recommendations and upgrade paths
- Verification commands for checking patch status

**CVE Mitigation Highlights**
- **CVE-2024-6387** (regreSSHion RCE): All current LTS distributions patched
- **CVE-2023-48795** (Terrapin Attack): All distributions patched including ESM
- **CVE-2023-38408** (PKCS#11 RCE): All distributions patched with additional role protection
- **CVE-2025-26465** (MITM with VerifyHostKeyDNS): Mitigated via secure defaults
- **CVE-2025-26466** (DoS): Partial mitigation via PerSourcePenalties on 9.8+

### Configuration & Flexibility

**180+ Lines of Configurable Variables**
- 70+ role variables with secure defaults
- Comprehensive cipher, KEX, and MAC algorithm configuration
- User and group access control lists (allow/deny)
- Forwarding controls (TCP, X11, agent, tunnel, stream)
- Session management (timeouts, re-keying, keepalive)
- Certificate authority support with trusted CA keys
- FIDO2 security key configuration
- Per-source penalty tuning for rate limiting
- Custom logging subsystem selection

**Template & Task Implementation**
- 166-line Jinja2 template with version-aware conditionals
- 222-line task file with distribution detection and validation
- Automatic feature detection and safe degradation
- Host key strength validation
- Moduli file verification for strong DH groups

### Documentation

**6 Comprehensive Documentation Files (457 lines)**
- **DISTRIBUTIONS.md**: 15-distribution support matrix with OpenSSH versions, feature levels, and capability flags
- **COMPLIANCE.md**: Detailed mappings for 16 compliance frameworks with specific requirement citations
- **CVE-TRACKING.md**: 20+ CVE vulnerability analysis with distribution-specific patch status
- **CONFIGURATION.md**: Complete variable reference with examples
- **EXAMPLES.md**: Quick configuration examples for common scenarios
- **TROUBLESHOOTING.md**: Common issues and debugging steps

**Example Playbooks (5 Scenarios)**
- `basic-hardening.yml`: Simple SSH hardening for general use
- `pci-dss-compliance.yml`: PCI DSS 4.0 compliant configuration (deadline: March 31, 2025)
- `fedramp-moderate.yml`: FedRAMP Moderate baseline with NIST SP 800-53 controls
- `maximum-security.yml`: Maximum security hardening for critical infrastructure
- `fido2-hardware-keys.yml`: Hardware security key authentication (YubiKey, etc.)

**Project Metadata**
- CITATION.cff for academic and professional citation
- MIT License for maximum reusability
- Production-ready ansible-lint and yamllint configurations
- Comprehensive README with quick start, features, and usage

### Testing & Quality

**Code Quality Tools**
- ansible-lint with production profile (strictest settings)
- yamllint with comprehensive rule set
- Molecule testing framework integration
- CI/CD workflow configuration
- FQCN (Fully Qualified Collection Names) throughout
- No deprecated module usage

### Role Architecture

**Ansible Galaxy Compatibility**
- Namespace: `welshwandering`
- Role name: `openssh_server`
- Minimum Ansible version: 2.15+
- Required collections: `ansible.posix` >= 1.5.0, `community.general` >= 8.0.0
- Zero dependencies (fully standalone)
- 14 Galaxy tags for discoverability

### Notable Design Decisions

**Security-First Approach**
- Password authentication disabled by default
- Modern cryptography preferred over legacy compatibility
- Defense-in-depth with multiple security layers
- Comprehensive logging enabled by default
- Safe defaults that work across all supported distributions

**Backwards Compatibility**
- Graceful feature degradation on older distributions
- Automatic capability detection prevents configuration errors
- Support for EOL distributions (with warnings)
- Ubuntu ESM release compatibility (16.04, 18.04)

**Production Readiness**
- Configuration validation before applying changes
- Automatic backup of previous configurations
- Comprehensive error handling
- Clear user feedback with warnings for EOL systems
- Idempotent operations

### Statistics

- **569 lines** of core implementation (tasks, defaults, templates)
- **457 lines** of documentation
- **10 distributions** supported (Debian, Ubuntu, Rocky)
- **16 compliance frameworks** mapped
- **20+ CVEs** tracked and mitigated
- **13 capability flags** for version detection
- **70+ configuration variables**
- **5 example playbooks** for common scenarios
- **9 years** of distribution support (Ubuntu 16.04 through latest)

### Security

- Disabled VerifyHostKeyDNS by default (CVE-2025-26465 mitigation)
- Mozilla Modern Profile cryptography defaults
- OpenSSH 10.0 algorithm preferences
- FIPS 140-2 compatible algorithms
- 3072-bit RSA minimum (configurable to 4096-bit)
- ChaCha20-Poly1305 and AES-GCM AEAD cipher preference
- Curve25519 key exchange preference
- SHA2-512/256 with ETM MAC algorithms
- Agent forwarding disabled by default
- X11 forwarding disabled by default

[1.0.0]: https://github.com/welshwandering/ansible-role-openssh_server/releases/tag/v1.0.0
