# Compliance Frameworks

## International Security Compliance

This role meets or exceeds security requirements from leading international cybersecurity organizations:

| Organization | Standard/Guideline | Compliance Status | Reference |
|--------------|-------------------|-------------------|-----------|
| 🇺🇸 **NSA/CISA** | Network Infrastructure Security Guide (Dec 2024) | ✅ 3072-bit RSA, 4096-bit DH (Group 16) | [NSA.gov](https://www.nsa.gov/) / [CISA.gov](https://www.cisa.gov/) |
| 🇺🇸 **NIST** | SP 800-207 (Zero Trust Architecture) | ✅ Strong authentication, session controls | [NIST SP 800-207](https://csrc.nist.gov/publications/detail/sp/800-207/final) |
| 🇺🇸 **CIS** | Benchmarks Section 5.2 (SSH Configuration) | ✅ SSH hardening best practices | [CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks) |
| 🇨🇦 **CCCS** | ITSP.40.062 (Secure Network Protocols) | ✅ AEAD ciphers, no CBC, session re-keying | [Cyber.gc.ca](https://www.cyber.gc.ca/) |
| 🇦🇺 **ACSC** | Communications Infrastructure Hardening | ✅ SSH v2 only, strong crypto (Five Eyes) | [Cyber.gov.au](https://www.cyber.gov.au/) |
| 🇬🇧 **NCSC** | Secure System Administration | ✅ General admin security principles | [NCSC.gov.uk](https://www.ncsc.gov.uk/) |
| 🇳🇿 **GCSB** | NZISM v3.9 (April 2025) | ✅ Information security controls | [GCSB.govt.nz](https://www.gcsb.govt.nz/) |
| 🇩🇪 **BSI** | TR-02102-4 Version 2025-1 (March 2025) | ✅ AES-GCM, valid to 2029+ | [BSI.bund.de](https://www.bsi.bund.de/EN/Home/home_node.html) |
| 🇫🇷 **ANSSI** | NT_OpenSSH (Post-Quantum Roadmap) | ✅ AES-CTR, SHA2-ETM MACs | [ANSSI Cyber.gouv.fr](https://cyber.gouv.fr/en) |
| 🌍 **Mozilla** | OpenSSH Modern Profile | ✅ Complete algorithm suite | [Mozilla Guidelines](https://infosec.mozilla.org/guidelines/openssh) |

### Cryptographic Standards Met

- **Minimum Key Sizes**: 3072-bit RSA, 256-bit ECDSA (Ed25519), 3072-bit DH parameters
- **Cipher Preference**: AEAD (ChaCha20-Poly1305, AES-GCM) > CTR mode
- **MAC Algorithms**: SHA2-512/256 with ETM (Encrypt-then-MAC)
- **Key Exchange**: Curve25519, NIST P-curves, DH Group 16/18
- **Post-Quantum Ready**: ML-KEM768x25519-sha256 (OpenSSH 9.9+)

## Industry and Regulatory Compliance Frameworks

This role's SSH hardening supports compliance with major industry regulations and frameworks. While these frameworks don't prescribe specific SSH configurations, they mandate secure remote access controls that this role fulfills.
> **Verification**: Mappings verified against latest framework versions as of **January 2026**.

### Financial Services and Payment Card Industry

| Framework | Jurisdiction | SSH Requirements Met | Notes |
|-----------|--------------|---------------------|-------|
| **PCI DSS 4.0** | Global | ✅ **8.4.2**: Multi-factor auth support (public key + passphrase)<br>✅ **4.2.1**: Strong encryption (AES-256, ChaCha20)<br>✅ **8.2.8**: Automatic 15-min idle session timeout<br>✅ **10.2**: Comprehensive audit logging | **Deadline**: March 31, 2025 for full PCI DSS 4.0 compliance<br>**Key Requirements**: 12+ char passwords, MFA for remote access, encrypted transmission |
| **SOX** | 🇺🇸 USA | ✅ Access controls (§404)<br>✅ Change management audit trail<br>✅ Segregation of duties support | **Sarbanes-Oxley Act of 2002**<br>**Focus**: ICFR (Internal Control over Financial Reporting) |
| **SAMA CSF** | 🇸🇦 Saudi Arabia | ✅ Cyber security controls (3.3.1)<br>✅ Strong authentication and encryption | Saudi Arabian Monetary Authority Cyber Security Framework (v1.0+) |

### Healthcare and Privacy

| Framework | Jurisdiction | SSH Requirements Met | Notes |
|-----------|--------------|---------------------|-------|
| **HIPAA Security Rule** | 🇺🇸 USA | ✅ **§ 164.312(a)(1)**: Access Control<br>✅ **§ 164.312(a)(2)(iv)**: Encryption/Decryption<br>✅ **§ 164.312(d)**: Person or Entity Authentication | **Status**: 45 CFR Part 160/162/164<br>Technical Safeguards for ePHI |
| **HITRUST CSF v11+** | Global | ✅ Harmonized controls from 60+ standards<br>✅ ISO 27001/27002 based access controls<br>✅ Encryption at rest and in transit | HITRUST r2 Validated Assessment ready |
| **GDPR** | 🇪🇺 EU | ✅ **Art. 32(1)(a)**: Pseudonymisation and encryption<br>✅ **Art. 32(1)(b)**: Confidentiality and integrity | General Data Protection Regulation (EU) 2016/679 |

### Cloud and Technology Standards

| Framework | Jurisdiction | SSH Requirements Met | Notes |
|-----------|--------------|---------------------|-------|
| **ISO/IEC 27001:2022** | Global | ✅ **A.8.20**: Networks Security<br>✅ **A.8.24**: Use of Cryptography<br>✅ **A.5.15**: Access Control | Verified against 2022 Amendment (Annex A controls renumbered) |
| **ISO/IEC 27017:2015** | Global | ✅ CLD.6.3.1: Shared roles authentication<br>✅ CLD.9.5.1: Segregation in virtual environments | Code of practice for cloud information security controls |
| **ISO/IEC 27018:2019** | Global | ✅ Encryption of PII in transit<br>✅ Breach notification support (logging) | Protection of PII in public clouds |
| **ISO/IEC 27037** | Global | ✅ Digital evidence handling guidelines | Guidelines for digital evidence |
| **ISO/IEC 27040:2024** | Global | ✅ Storage security and encryption | **Updated**: 2024 revision of storage security guidelines |

### Government and Critical Infrastructure

| Framework | Jurisdiction | SSH Requirements Met | Notes |
|-----------|--------------|---------------------|-------|
| **FedRAMP Moderate / High** | 🇺🇸 USA Federal | ✅ FIPS 140-2 validated cryptography<br>✅ NIST SP 800-53 **Rev 5** controls:<br>• **AC-17** (Remote Access)<br>• **IA-2** (Authentication)<br>• **SC-8/13** (Crypto/Transmission)<br>• **AU-2** (Audit) | **Baselines**: Moderate (325 controls), High (421 controls)<br>**Cryptographic Protection**: SC-13 mandates FIPS-validated crypto |
| **FISMA** | 🇺🇸 USA Federal | ✅ NIST 800-53 security controls<br>✅ Remote access controls (AC-17)<br>✅ Transmission confidentiality (SC-8) | Federal Information Security Management Act (2014) |
| **NERC CIP-005-7** | 🇺🇸 USA/Canada | ✅ **CIP-005 R2**: Interactive Remote Access Management<br>✅ **CIP-007 R5**: System Security Management<br>✅ MFA & Encryption mandated | Critical Infrastructure Protection (Bulk Electric System) |
| **NCA ECC-1:2018** | 🇸🇦 Saudi Arabia | ✅ **2-3-3**: Remote Access<br>✅ **2-5-1**: Cryptography<br>✅ **2-5-3**: Communications Security | National Cybersecurity Authority Essential Cybersecurity Controls |
| **UAE IA v1.1** | 🇦🇪 UAE | ✅ Access Control & Cryptography<br>✅ Management of Information Security Operations | UAE Information Assurance Regulation |

### Trust and Assurance Frameworks

| Framework | Jurisdiction | SSH Requirements Met | Notes |
|-----------|--------------|---------------------|-------|
| **SOC 2** | Global | ✅ **CC6.1**: Logical Access<br>✅ **CC6.7**: Transmission Security<br>✅ **CC6.8**: Unauthorized Software Prevention | Based on AICPA Trust Services Criteria (2017) |

### Key Compliance Capabilities

This role provides the technical controls needed for compliance across all frameworks:

   - FIPS 140-2 compatible algorithms (AES, Triple-DES)
   - Modern ciphers (ChaCha20-Poly1305, AES-GCM)
   - TLS-equivalent encryption strength

2. **Access Control**
   - Public key authentication (default)
   - Multi-factor authentication support (key + passphrase)
   - User/group allow/deny lists
   - Root login restrictions

3. **Audit and Logging**
   - Comprehensive session logging (VERBOSE level)
   - Enhanced forensic logging (LogVerbose for specific subsystems)
   - Failed login attempt tracking
   - Change tracking capability

4. **Session Management**
   - Automatic session timeout (LoginGraceTime)
   - Maximum authentication attempts (MaxAuthTries)
   - Session re-keying (RekeyLimit)
   - Client keepalive with timeout

5. **Advanced Security Controls**
   - Per-source connection limits and penalties (9.8+)
   - Required RSA key size enforcement (9.3+)
   - Post-quantum cryptography readiness (9.9+)
   - Comprehensive forwarding controls

### Compliance Notes

- **FIPS 140-2**: While this role uses FIPS-compatible algorithms, achieving full FIPS 140-2 compliance requires OpenSSH compiled in FIPS mode and FIPS-validated cryptographic modules at the OS level
- **Framework Versions**: Compliance mappings based on current framework versions as of 2025
- **Audit Requirements**: Most frameworks require regular security assessments - this role provides the technical foundation but doesn't replace compliance audits
- **Documentation**: Maintain documentation of SSH configuration decisions for audit purposes
