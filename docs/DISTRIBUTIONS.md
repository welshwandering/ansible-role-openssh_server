# Supported Distributions

This role automatically detects your distribution and OpenSSH version, enabling advanced features when supported while maintaining backwards compatibility.

## Target Distribution List
 
| Distribution | Required Versions | Current Support Status | OpenSSH Version |
|--------------|-------------------|-------------------------|-----------------|
| **Debian**   | 11, 12, 13, 14    | 11, 12, 13 (Stable), 14 (Testing) | 8.4p1 - 10.2p1+ |
| **Ubuntu**   | 22.04, 24.04, 25.10 | 22.04 LTS, 24.04 LTS, 25.10 (Interim) | 8.9p1 - 10.0p1 |
| **Rocky**    | 8, 9, 10          | 8, 9, 10 (Current)      | 8.0p1 - 9.9p1   |
| **Fedora**   | 43                | 43 (Current)            | 9.9p1+          |

## Debian Releases

| Distribution | Release Date | Support Until | OpenSSH Version | Feature Level |
|--------------|--------------|---------------|-----------------|---------------|
| **Stretch (9)** | 2017-06 | 2022-06 (EOL) | 7.4p1 | ⚠️ Legacy - Limited features |
| **Buster (10)** | 2019-07 | 2024-06 (LTS) | 7.9p1 | ⚠️ Legacy - No FIDO2 |
| **Bullseye (11)** | 2021-08 | 2026-08 (LTS) | 8.4p1 | ✅ Modern - FIDO2 support |
| **Bookworm (12)** | 2023-06 | 2028-06 (LTS) | 9.2p1 | ✅ Modern - Full featured |
| **Trixie (13)** | 2025-08 | 2030-08 | 10.0p1 | ✅ Latest - All features |
| **Forky (14)** | TBD | Testing | 10.2p1+ | ✅ Latest - Cutting edge |

## Ubuntu LTS Releases

| Distribution | Release Date | Support Until | OpenSSH Version | Feature Level |
|--------------|--------------|---------------|-----------------|---------------|
| **22.04 Jammy** | 2022-04 | 2032-04 (ESM) | 8.9p1 | ✅ Modern - Full featured |
| **24.04 Noble** | 2024-04 | 2034-04 (ESM) | 9.6p1 | ✅ Latest - Advanced features |

## Rocky Linux (RHEL Compatible)

| Distribution | Release Date | Support Until | OpenSSH Version | Feature Level |
|--------------|--------------|---------------|-----------------|---------------|
| **Rocky Linux 8** | 2021-06 | 2029-05 | 8.0p1 | ⚠️ Legacy - No FIDO2 |
| **Rocky Linux 9** | 2022-07 | 2032-05 | 8.7p1 | ✅ Modern - FIDO2 + LogVerbose |
| **Rocky Linux 10** | 2025-06 | 2035-05 | 9.9p1 | ✅ Latest - Post-quantum ready |

## Fedora Releases

| Distribution | Release Date | Support Until | OpenSSH Version | Feature Level |
|--------------|--------------|---------------|-----------------|---------------|
| **Fedora 43** | 2025-10 | 2026-11 | 9.9p1+ | ✅ Latest - Cutting edge |

### Point Release Status (Jan 2026)
- **Debian**: 11.11, 12.12, 13.2
- **Rocky Linux**: 8.10, 9.7, 10.1

## Ubuntu Non-LTS Releases (Current Only)

| Distribution | Release Date | Support Until | OpenSSH Version | Feature Level |
|--------------|--------------|---------------|-----------------|---------------|
| **25.10 Questing** | 2025-10 | 2026-07 | 10.0p1 | ✅ Latest - Cutting edge |

### Non-LTS Support Policy

- ✅ We support **current and upcoming** non-LTS releases only
- ❌ We do **NOT** support EOL non-LTS releases (no security updates)
- ⏰ Non-LTS releases have a **9-month support window**
- 📋 For production use, we **strongly recommend Ubuntu LTS releases**

## Legend

- ✅ **Latest**: OpenSSH 9.6+ with post-quantum crypto readiness
- ✅ **Modern**: OpenSSH 8.2+ with FIDO2 hardware key support
- ⚠️ **Legacy**: Older OpenSSH with limited modern features (still supported)
- **ESM**: Extended Security Maintenance (Ubuntu Pro required for 16.04/18.04)

## Version Detection

The role automatically detects your OpenSSH version using `ssh -V` and sets capability flags that control which features are enabled. This ensures older distributions don't encounter errors when using directives they don't support.

**Note**: The role will display warnings when running on EOL or ESM distributions and automatically disable unsupported features.

## Capability Flags

The role sets 13 version-specific capability flags:

| Flag | Minimum Version | Feature Enabled |
|------|-----------------|-----------------|
| `openssh_has_disable_forwarding` | 7.4 | DisableForwarding directive |
| `openssh_has_ca_signature_algorithms` | 7.9 | CASignatureAlgorithms directive |
| `openssh_has_fido2` | 8.2 | FIDO2/WebAuthn security keys |
| `openssh_has_include` | 8.2 | Include directive support |
| `openssh_has_log_verbose` | 8.5 | LogVerbose directive |
| `openssh_has_required_rsa_size` | 9.3 | RequiredRSASize directive |
| `openssh_has_persourcepenalties` | 9.8 | PerSourcePenalties directive |
| `openssh_has_mlkem` | 9.9 | ML-KEM post-quantum KEX |
| `openssh_has_rsa_sha2` | 7.2 | RSA-SHA2 signature algorithms |
| `openssh_has_modern_kex` | 7.4 | Modern key exchange algorithms |
| `openssh_blocks_dsa_ca` | 7.9 | DSA CA keys blocked |
| `openssh_removes_dsa` | 9.6 | DSA completely removed |
| `openssh_dh_disabled_default` | 10.0 | DH disabled by default |

These flags are set automatically in [tasks/main.yml](../tasks/main.yml) and used throughout [templates/sshd_config.j2](../templates/sshd_config.j2) to enable features only when supported.
