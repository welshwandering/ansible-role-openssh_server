# macOS Testing Limitation and Solution

## Current Status

The Molecule tests as configured for CI (using base Debian/Ubuntu images with systemd) **do not work out-of-the-box on macOS** due to the following issues:

1. **Base images lack systemd**: `debian:bookworm` and `ubuntu:noble` don't include systemd
2. **Base images lack sudo**: Required for Ansible `become` operations
3. **systemd in containers**: Requires special Docker configuration that base images don't have

## Why This Works in CI but Not Locally

- **GitHub Actions CI**: Uses systemd-enabled container images or builds custom images with systemd
- **macOS Docker Desktop**: Base images don't have systemd pre-configured

## Solutions for macOS Testing

### Option 1: Use Pre-built systemd Images (Recommended)

Use Docker images that already have systemd enabled:

```bash
# Install in virtual environment
python3 -m venv .venv
source .venv/bin/activate
pip install molecule 'molecule-plugins[docker]' ansible-core

# Use geerlingguy's systemd-enabled images
MOLECULE_DISTRO=debian12 \
MOLECULE_IMAGE=geerlingguy/docker-debian12-ansible:latest \
molecule test

# Or Ubuntu
MOLECULE_DISTRO=ubuntu2404 \
MOLECULE_IMAGE=geerlingguy/docker-ubuntu2404-ansible:latest \
molecule test
```

### Option 2: Build Custom Systemd Images

Create a custom Dockerfile that adds systemd:

```dockerfile
# Dockerfile.debian
FROM debian:bookworm
RUN apt-get update && \
    apt-get install -y systemd sudo python3 && \
    rm -rf /var/lib/apt/lists/*
CMD ["/lib/systemd/systemd"]
```

Then build and use:

```bash
docker build -t debian-systemd:bookworm -f Dockerfile.debian .
MOLECULE_DISTRO=debian12 \
MOLECULE_IMAGE=debian-systemd:bookworm \
molecule test
```

### Option 3: Simplified Testing Without systemd

For quick validation without full systemd:

1. Test only configuration generation (not service management)
2. Use `molecule converge` instead of `molecule test`
3. Manually verify `/etc/ssh/sshd_config` is generated correctly

```bash
# Run role application only
molecule converge

# Verify configuration
molecule verify

# Cleanup
molecule destroy
```

## Recommendation

**For local macOS development**: Use Option 1 with pre-built images from geerlingguy or similar.

**For CI**: Continue using base images with systemd configuration (already working).

## Updating CI for macOS Compatibility

To make CI tests also work locally on macOS, we would need to:

1. Add logic to detect local vs CI environment
2. Use different images based on environment
3. Or build custom systemd images in CI

This adds complexity, so the current approach (optimized for CI) is acceptable with documented workarounds for local testing.

## Testing Impact

- ✅ **CI Tests**: Fully working with systemd verification
- ⚠️ **macOS Local Tests**: Require pre-built systemd images or simplified testing
- ✅ **Role Functionality**: Not affected - role works correctly when deployed

---

*Last updated: 2025-10-05*
