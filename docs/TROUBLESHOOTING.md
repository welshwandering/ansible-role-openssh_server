# Troubleshooting Guide

## Post-Installation

### Add SSH Keys

```bash
# On your local machine
ssh-copy-id user@server

# Or manually
cat ~/.ssh/id_ed25519.pub | ssh user@server "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"
```

### Test Configuration

```bash
# Validate config
sudo sshd -t

# Check service status
sudo systemctl status ssh

# View logs
sudo journalctl -u ssh -f
```

## Troubleshooting

### Locked Out?

If you've locked yourself out:

1. Access via console (physical/IPMI/cloud console)
2. Edit `/etc/ssh/sshd_config`
3. Temporarily enable: `PasswordAuthentication yes`
4. Restart: `sudo systemctl restart ssh`
5. Fix your SSH keys
6. Re-disable password auth

### Connection Refused?

```bash
# Check if SSH is running
sudo systemctl status ssh

# Check if port is open
sudo ss -tulpn | grep ssh

# Check firewall
sudo ufw status
```
