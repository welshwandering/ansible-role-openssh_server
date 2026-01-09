# Configuration Examples

## Configuration Examples

### Enable Post-Quantum Cryptography

Post-quantum KEX is automatically enabled on OpenSSH 9.9+. To verify:

```yaml
openssh_enable_mlkem: true  # Default, auto-enables when supported
```

### Maximum Security Hardening

```yaml
- hosts: high_security_servers
  roles:
    - role: openssh_server
      vars:
        openssh_password_authentication: false
        openssh_permit_root_login: "no"
        openssh_enable_persourcepenalties: true  # Auto-enabled on 9.8+
        openssh_enable_verbose_logging: true
        openssh_disable_forwarding_comprehensive: true
        openssh_max_auth_tries: 3
        openssh_rekey_limit: "512M 30m"  # Re-key every 512MB or 30min
```

### Enable FIDO2 Hardware Security Keys

```yaml
openssh_enable_security_keys: true
openssh_pubkey_accepted_key_types:
  - sk-ssh-ed25519@openssh.com      # FIDO2 Ed25519
  - ssh-ed25519                      # Standard Ed25519
  - sk-ecdsa-sha2-nistp256@openssh.com  # FIDO2 ECDSA
```

### Certificate Authority Configuration

```yaml
openssh_enable_ca: true
openssh_trusted_user_ca_keys:
  - /etc/ssh/ca/user_ca.pub
openssh_host_certificate: /etc/ssh/ssh_host_ed25519_key-cert.pub
```
