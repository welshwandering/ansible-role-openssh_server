# Acknowledgements

This OpenSSH server hardening role stands on the shoulders of giants. We are deeply grateful to the projects, organizations, and individuals whose work made this role possible.

## Core Technologies

### OpenSSH Project

**[OpenSSH](https://www.openssh.com/)** - The foundation of secure remote access.

- **Project**: OpenBSD SSH - Open-source SSH protocol implementation
- **Maintained by**: The OpenBSD Project and global contributors
- **Since**: 1999 (25+ years of security excellence)
- **Impact**: Powers secure communication for millions of systems worldwide
- **License**: BSD License

OpenSSH's commitment to security-first development, comprehensive auditing, and rapid vulnerability response sets the standard for secure remote access. This role simply helps administrators configure OpenSSH to maximize its security potential.

**Special recognition**: The OpenSSH team's dedication to publishing detailed security advisories and maintaining backward compatibility across decades of releases enables projects like this to exist.

### Ansible

**[Ansible](https://www.ansible.com/)** - Automation that powers infrastructure as code.

- **Project**: Ansible automation platform
- **Maintained by**: Red Hat and the Ansible community
- **License**: GPL-3.0
- **Impact**: Enables declarative, idempotent infrastructure management

Ansible's elegant YAML-based syntax and extensive module ecosystem make complex security configurations manageable and repeatable. The `ansible.builtin`, `ansible.posix`, and `community.general` collections provide the building blocks for this role.

## Operating System Distributions

### Debian Project

**[Debian](https://www.debian.org/)** - The Universal Operating System.

- **Commitment to stability**: Long-term support releases with security backports
- **Security team**: Proactive vulnerability tracking and rapid patch distribution
- **Impact on this role**: 7 Debian distributions supported (Stretch through Forky)

Debian's security tracker (https://security-tracker.debian.org/) provides transparent, detailed vulnerability status that enables accurate CVE tracking in this role.

### Ubuntu / Canonical

**[Ubuntu](https://ubuntu.com/)** - Linux for human beings.

- **LTS support**: Extended Security Maintenance for critical deployments
- **Security team**: Comprehensive patch backporting and CVE tracking
- **Impact on this role**: 8 Ubuntu distributions supported (16.04 through 25.10)

Ubuntu's commitment to long-term support (up to 12 years with ESM) and detailed security bulletins (https://ubuntu.com/security/cves) enables confident deployment across diverse environments.

## Security Research & Standards Organizations

### Government Cybersecurity Agencies

#### United States

- **[NSA](https://www.nsa.gov/)** & **[CISA](https://www.cisa.gov/)**: Network Infrastructure Security Guide (December 2024) - NSA/CISA cryptographic recommendations inform our RSA key size requirements (3072-bit minimum)
- **[NIST](https://csrc.nist.gov/)**: Special Publications (SP 800-207, SP 800-53, SP 800-52) - Zero Trust Architecture and cryptographic standards

#### Canada

- **[CCCS](https://www.cyber.gc.ca/)**: Canadian Centre for Cyber Security - ITSP.40.062 Secure Network Protocols guidance shapes our session re-keying and AEAD cipher preferences

#### Australia

- **[ACSC](https://www.cyber.gov.au/)**: Australian Cyber Security Centre - Communications infrastructure hardening guidance (Five Eyes collaboration)

#### United Kingdom

- **[NCSC](https://www.ncsc.gov.uk/)**: National Cyber Security Centre - Secure system administration principles

#### New Zealand

- **[GCSB](https://www.gcsb.govt.nz/)**: Government Communications Security Bureau - NZISM v3.9 information security controls

#### Germany

- **[BSI](https://www.bsi.bund.de/)**: Bundesamt für Sicherheit in der Informationstechnik - TR-02102-4 Version 2025-1 provides the most comprehensive cryptographic guidance for SSH, including AES-GCM validity through 2029+

#### France

- **[ANSSI](https://cyber.gouv.fr/)**: Agence nationale de la sécurité des systèmes d'information - NT_OpenSSH technical note and post-quantum cryptography roadmap

### Industry Standards Organizations

- **[Mozilla](https://infosec.mozilla.org/)**: OpenSSH Modern Profile - Our cipher, KEX, and MAC preferences build upon Mozilla's excellent security guidelines
- **[CIS](https://www.cisecurity.org/)**: Center for Internet Security - CIS Benchmarks Section 5.2 SSH hardening
- **[OWASP](https://owasp.org/)**: Open Web Application Security Project - General security principles

## Compliance & Regulatory Frameworks

This role supports 16 compliance frameworks. We acknowledge the organizations that maintain these standards:

### Financial Services

- **[PCI Security Standards Council](https://www.pcisecuritystandards.org/)**: PCI DSS 4.0
- **[U.S. Congress](https://www.congress.gov/)**: Sarbanes-Oxley Act (SOX)
- **[SAMA](https://www.sama.gov.sa/)**: Saudi Arabian Monetary Authority - Cyber Security Framework

### Healthcare & Privacy

- **[U.S. Department of Health and Human Services](https://www.hhs.gov/)**: HIPAA regulations
- **[HITRUST Alliance](https://hitrustalliance.net/)**: HITRUST CSF
- **[European Union](https://gdpr.eu/)**: General Data Protection Regulation (GDPR)

### Cloud & Technology

- **[ISO](https://www.iso.org/)**: International Organization for Standardization - ISO/IEC 27017, 27018, 27037, 27040, 27701

### Government & Critical Infrastructure

- **[FedRAMP](https://www.fedramp.gov/)**: Federal Risk and Authorization Management Program
- **[FISMA](https://www.cisa.gov/topics/cyber-threats-and-advisories/federal-information-security-modernization-act)**: Federal Information Security Management Act
- **[NERC](https://www.nerc.com/)**: North American Electric Reliability Corporation - CIP standards
- **[NCA](https://nca.gov.sa/)**: Saudi Arabia National Cybersecurity Authority - Essential Cybersecurity Controls
- **[UAE Government](https://u.ae/)**: UAE Information Assurance framework

### Trust & Assurance

- **[AICPA](https://www.aicpa.org/)**: American Institute of CPAs - SOC 2 Trust Services Criteria

## Research & Documentation Resources

### CVE & Vulnerability Tracking

- **[MITRE CVE Program](https://cve.mitre.org/)**: Common Vulnerabilities and Exposures database
- **[NVD](https://nvd.nist.gov/)**: National Vulnerability Database - NIST's comprehensive CVE analysis
- **[Debian Security Tracker](https://security-tracker.debian.org/)**: Distribution-specific vulnerability status
- **[Ubuntu Security](https://ubuntu.com/security)**: Ubuntu CVE tracking and security bulletins

### Security Research

- **Qualys**: Regular OpenSSH security research and vulnerability discovery
- **Trail of Bits**: Cryptographic engineering and security auditing
- **OpenSSF**: Open Source Security Foundation - Best practices for open source projects

## Development Tools & Infrastructure

### Code Quality

- **[yamllint](https://github.com/adrienverge/yamllint)** by Adrien Vergé - YAML syntax validation
- **[ansible-lint](https://github.com/ansible/ansible-lint)** by Ansible Community - Ansible best practices enforcement
- **[Molecule](https://github.com/ansible-community/molecule)** by Ansible Community - Testing framework for Ansible roles

### Documentation

- **[Keep a Changelog](https://keepachangelog.com/)** by Olivier Lacan - Changelog format standard
- **[Semantic Versioning](https://semver.org/)** by Tom Preston-Werner - Version numbering standard
- **[Citation File Format](https://citation-file-format.github.io/)** - Software citation standard

### Version Control

- **[Git](https://git-scm.com/)** by Linus Torvalds and the Git community
- **[GitHub](https://github.com/)** - Platform for collaboration and open source

## Inspiration & Prior Art

### SSH Hardening Resources

- **[ssh-audit](https://github.com/jtesta/ssh-audit)** by Joe Testa - SSH configuration auditing tool that validates many of the same security principles
- **[Mozilla SSH Guidelines](https://infosec.mozilla.org/guidelines/openssh)** - Foundation for our cryptographic preferences
- **[dev-sec/ansible-ssh-hardening](https://github.com/dev-sec/ansible-ssh-hardening)** - Another excellent SSH hardening role with different design choices

### Community Knowledge

- **Stack Exchange**: Countless sysadmins sharing SSH configuration knowledge
- **Reddit**: r/sysadmin, r/ansible, r/netsec communities
- **Ansible Galaxy**: Community roles that demonstrate best practices

## Special Thanks

### OpenSSH Security Researchers

To the security researchers who responsibly disclose vulnerabilities and help make OpenSSH more secure with each release.

### Distribution Security Teams

To the Debian and Ubuntu security teams who tirelessly backport security patches, enabling older distributions to remain secure without requiring disruptive upgrades.

### Compliance Framework Authors

To the countless security professionals, lawyers, and technical writers who create and maintain compliance frameworks that help organizations implement security systematically.

### Open Source Contributors

To everyone who has ever:
- Reported a bug in OpenSSH or Ansible
- Contributed to security documentation
- Shared knowledge in forums and discussions
- Maintained open source infrastructure

## Contributing to This Project

Want to add your name to this list? See [CONTRIBUTING.md](CONTRIBUTING.md) for how to contribute to this role.

Significant contributors will be recognized here in future releases.

## About This Role

- **Project**: ansible-role-openssh_server
- **Version**: 1.0.0
- **Author**: Gravitino LLC
- **License**: MIT License
- **Repository**: https://github.com/welshwandering/ansible-role-openssh_server

## License & Attribution

This role is released under the MIT License, allowing free use, modification, and distribution. If you use this role in your infrastructure or build upon it for other projects, we appreciate (but do not require) attribution.

See [CITATION.cff](../CITATION.cff) for academic/professional citation format.

---

**"If I have seen further, it is by standing on the shoulders of giants."** - Isaac Newton

This role represents the collective knowledge and expertise of the security community. Thank you to everyone who contributes to making the internet more secure.

---

*Last updated: 2025-10-05*
*If we've missed acknowledging a project or resource, please open an issue or pull request.*
