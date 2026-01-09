# Configuration Reference

## Role Variables

### Security Settings

```yaml
# Authentication
openssh_permit_root_login: "prohibit-password"  # no, prohibit-password, yes
openssh_password_authentication: false           # Use key-based auth only
openssh_pubkey_authentication: true
openssh_permit_empty_passwords: false
openssh_challenge_response_auth: false

# Login limits
openssh_max_auth_tries: 3
openssh_login_grace_time: "30s"
```

### Network Configuration

```yaml
openssh_port: 22
openssh_listen_addresses:
  - "0.0.0.0"
  - "::"
```

### Cryptography (Secure Defaults)

```yaml
openssh_ciphers:
  - chacha20-poly1305@openssh.com
  - aes256-gcm@openssh.com
  - aes128-gcm@openssh.com

openssh_kex_algorithms:
  - curve25519-sha256
  - diffie-hellman-group16-sha512

openssh_macs:
  - hmac-sha2-512-etm@openssh.com
  - hmac-sha2-256-etm@openssh.com
```

### Access Control

```yaml
openssh_allow_users: []      # List of allowed users
openssh_deny_users: []       # List of denied users
openssh_allow_groups: []     # List of allowed groups
openssh_deny_groups: []      # List of denied groups
```
