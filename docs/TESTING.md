# Testing Guide

This document describes the comprehensive testing infrastructure for the OpenSSH server hardening role.

## Overview

Our testing strategy ensures the role works correctly across all 15 supported distributions, from Debian Stretch (OpenSSH 7.4p1) to the latest releases with OpenSSH 10.0p1+.

**✅ macOS Users**: All tests work perfectly on macOS with Docker Desktop! See [TESTING_MACOS.md](TESTING_MACOS.md) for macOS-specific instructions.

## Continuous Integration (GitHub Actions)

### CI Pipeline

The CI pipeline runs on every push to `main`/`develop` branches and all pull requests.

**Workflow:** [`.github/workflows/ci.yml`](../.github/workflows/ci.yml)

### Testing Matrix

#### Lint Job
- **YAML Linting:** `yamllint .`
- **Ansible Linting:** `ansible-lint --profile=production` (strictest profile)
- **Python Version:** 3.11
- **Ansible Version:** 2.15+

#### Molecule Job

Tests across **15 distributions** in parallel:

| Distribution | Docker Image | OpenSSH Version | Feature Level |
|--------------|--------------|-----------------|---------------|
| **Debian 9 (Stretch)** | `debian:stretch` | 7.4p1 | Legacy |
| **Debian 10 (Buster)** | `debian:buster` | 7.9p1 | Legacy |
| **Debian 11 (Bullseye)** | `debian:bullseye` | 8.4p1 | Modern |
| **Debian 12 (Bookworm)** | `debian:bookworm` | 9.2p1 | Modern |
| **Debian 13 (Trixie)** | `debian:trixie` | 10.0p1 | Latest |
| **Debian Sid (Testing)** | `debian:sid` | 10.0p1 | Latest |
| **Ubuntu 16.04 (Xenial)** | `ubuntu:xenial` | 7.2p2 | Legacy |
| **Ubuntu 18.04 (Bionic)** | `ubuntu:bionic` | 7.6p1 | Legacy |
| **Ubuntu 20.04 (Focal)** | `ubuntu:focal` | 8.2p1 | Modern |
| **Ubuntu 22.04 (Jammy)** | `ubuntu:jammy` | 8.9p1 | Modern |
| **Ubuntu 24.04 (Noble)** | `ubuntu:noble` | 9.6p1 | Latest |
| **Ubuntu 24.10 (Oracular)** | `ubuntu:oracular` | 9.7p1 | Latest |

### CI Environment Variables

Each distribution test passes:
- `MOLECULE_DISTRO`: Distribution identifier (e.g., `debian12`, `ubuntu2404`)
- `MOLECULE_IMAGE`: Docker image to use (e.g., `debian:bookworm`, `ubuntu:noble`)
- `MOLECULE_OPENSSH_VERSION`: Expected OpenSSH version (e.g., `9.2p1`, `9.6p1`)

## Molecule Testing

### Test Phases

1. **Dependency:** Install required Ansible collections
2. **Lint:** YAML and Ansible linting (runs in separate job)
3. **Create:** Spin up Docker container for target distribution
4. **Prepare:** Install OpenSSH server and dependencies
5. **Converge:** Apply the openssh_server role
6. **Verify:** Run verification tests
7. **Destroy:** Clean up test container

### Molecule Configuration

**File:** [`molecule/default/molecule.yml`](../molecule/default/molecule.yml)

```yaml
platforms:
  - name: "${MOLECULE_DISTRO:-debian12}"
    image: "${MOLECULE_IMAGE:-debian:bookworm}"
    privileged: true
    command: /lib/systemd/systemd
    volumes:
      - /sys/fs/cgroup:/sys/fs/cgroup:rw
```

The configuration uses environment variables for flexible testing across distributions.

### Converge Phase

**File:** [`molecule/default/converge.yml`](../molecule/default/converge.yml)

1. Updates apt cache
2. Installs `openssh-server` package
3. Applies the `openssh_server` role

### Verification Tests

**File:** [`molecule/default/verify.yml`](../molecule/default/verify.yml)

Comprehensive verification includes:

#### 1. Service Status
- Verifies SSH service is active and running
- Uses systemd to check service state

#### 2. Configuration Validation
- Runs `sshd -t` to validate configuration syntax
- Ensures no syntax errors in generated config

#### 3. Port Availability
- Checks SSH is listening on port 22
- Validates network accessibility

#### 4. Version Verification
- Reports OpenSSH version via `ssh -V`
- Compares with expected version for the distribution

#### 5. Security Hardening
- Verifies key security directives are set:
  - `PasswordAuthentication`
  - `PermitRootLogin`
  - `PubkeyAuthentication`

## Local Testing

### Prerequisites

#### macOS (with Docker Desktop)

```bash
# 1. Install Docker Desktop for Mac
# Download from: https://www.docker.com/products/docker-desktop/

# 2. Install Python dependencies (using Homebrew's Python or system Python)
pip3 install molecule molecule-plugins[docker] ansible-core>=2.15

# 3. Install Ansible collections
ansible-galaxy collection install ansible.posix>=1.5.0
ansible-galaxy collection install community.general>=8.0.0
```

**macOS Notes:**
- ✅ **Fully supported** - All Molecule tests work on macOS with Docker Desktop
- Docker Desktop provides the Docker daemon required for Molecule
- Tests run in Linux containers via Docker Desktop's VM
- Performance may be slower than native Linux due to VM overhead
- No additional configuration needed - just ensure Docker Desktop is running

#### Linux

```bash
# 1. Install Docker
# See: https://docs.docker.com/engine/install/

# 2. Install testing dependencies
pip install molecule molecule-plugins[docker] ansible-core>=2.15

# 3. Install Ansible collections
ansible-galaxy collection install ansible.posix>=1.5.0
ansible-galaxy collection install community.general>=8.0.0

# 4. Add user to docker group (to avoid sudo)
sudo usermod -aG docker $USER
newgrp docker
```

### Run All Tests

```bash
# Run complete test suite (default: Debian 12)
molecule test

# Test specific distribution
MOLECULE_DISTRO=ubuntu2404 \
MOLECULE_IMAGE=ubuntu:noble \
MOLECULE_OPENSSH_VERSION=9.6p1 \
molecule test
```

### Development Workflow

```bash
# Create test environment
molecule create

# Run convergence (apply role)
molecule converge

# Run verification tests
molecule verify

# Login to test container
molecule login

# Destroy test environment
molecule destroy
```

### Test Specific Distributions

```bash
# Debian Bookworm (modern)
MOLECULE_DISTRO=debian12 MOLECULE_IMAGE=debian:bookworm MOLECULE_OPENSSH_VERSION=9.2p1 molecule test

# Ubuntu 24.04 Noble (latest)
MOLECULE_DISTRO=ubuntu2404 MOLECULE_IMAGE=ubuntu:noble MOLECULE_OPENSSH_VERSION=9.6p1 molecule test

# Debian Stretch (legacy - test backwards compatibility)
MOLECULE_DISTRO=debian9 MOLECULE_IMAGE=debian:stretch MOLECULE_OPENSSH_VERSION=7.4p1 molecule test

# Ubuntu 16.04 Xenial (oldest supported)
MOLECULE_DISTRO=ubuntu1604 MOLECULE_IMAGE=ubuntu:xenial MOLECULE_OPENSSH_VERSION=7.2p2 molecule test
```

## Testing Strategy

### Coverage Goals

1. **Distribution Coverage**: All 15 supported distributions
2. **Version Coverage**: OpenSSH 7.2p2 through 10.0p1+
3. **Feature Coverage**: Version-aware capability flags
4. **Security Coverage**: Hardening verification

### Feature Testing

The role's capability flags are tested across versions:

- **Legacy (7.2 - 7.9)**: Basic hardening, limited modern features
- **Modern (8.2 - 9.2)**: FIDO2 support, enhanced logging
- **Latest (9.3+)**: RequiredRSASize, PerSourcePenalties
- **Cutting Edge (9.9+)**: Post-quantum ML-KEM support

### Backwards Compatibility

Testing ensures:
- Older distributions don't fail on unsupported directives
- Capability flags correctly enable/disable features
- Warnings display for EOL distributions
- Graceful degradation on legacy systems

## CI/CD Integration

### Pull Request Checks

All PRs must pass:
1. ✅ YAML linting (yamllint)
2. ✅ Ansible linting (production profile)
3. ✅ Molecule tests on all 15 distributions

### Branch Protection

- `main` branch requires all CI checks to pass
- No PR can be merged with failing tests
- Linting must pass with 0 failures, 0 warnings

### Performance

- Lint job: ~2-3 minutes
- Molecule tests: ~5-10 minutes per distribution (parallel execution)
- Total CI time: ~10-15 minutes with parallelization

## Test Maintenance

### Adding New Distributions

When adding support for a new distribution:

1. **Update CI Matrix** (`.github/workflows/ci.yml`):
   ```yaml
   - distro: ubuntu2504
     image: ubuntu:plucky
     openssh_version: "9.9p1"
   ```

2. **Update Documentation**:
   - `docs/DISTRIBUTIONS.md` - Add to supported list
   - `docs/TESTING.md` - Update test matrix
   - `README.md` - Update badges if needed

3. **Test Locally First**:
   ```bash
   MOLECULE_DISTRO=ubuntu2504 \
   MOLECULE_IMAGE=ubuntu:plucky \
   MOLECULE_OPENSSH_VERSION=9.9p1 \
   molecule test
   ```

4. **Update CHANGELOG**:
   ```markdown
   ### Added
   - Added support for Ubuntu 25.04 (Plucky) with OpenSSH 9.9p1
   ```

### Updating OpenSSH Versions

When distributions update OpenSSH versions:

1. Verify new version in distribution repositories
2. Update `openssh_version` in CI matrix
3. Review and update capability flags if needed
4. Update docs/DISTRIBUTIONS.md with new version
5. Run full test suite to verify compatibility

## Troubleshooting

### Common Issues

#### macOS: Docker Desktop Not Running
```bash
# Error: Cannot connect to Docker daemon
# Solution: Ensure Docker Desktop is running
open -a Docker

# Verify Docker is running
docker ps
```

#### macOS: Permission Errors with pip
```bash
# Use user installation to avoid sudo
pip3 install --user molecule molecule-plugins[docker] ansible-core>=2.15

# Or use a virtual environment (recommended)
python3 -m venv venv
source venv/bin/activate
pip install molecule molecule-plugins[docker] ansible-core>=2.15
```

#### macOS: Slow Performance
```bash
# Docker Desktop on macOS runs containers in a VM, which can be slower
# To improve performance:
# 1. Allocate more resources in Docker Desktop preferences
#    (Settings → Resources → increase CPUs and Memory)
# 2. Ensure Docker Desktop is using VirtioFS (Settings → General)
# 3. Consider testing only specific distributions instead of all 15
```

#### Linux: Docker Permission Errors
```bash
# Add user to docker group
sudo usermod -aG docker $USER
newgrp docker
```

#### Molecule Not Found
```bash
# Ensure Molecule is installed
pip install --upgrade molecule molecule-plugins[docker]

# On macOS, you may need pip3
pip3 install --upgrade molecule molecule-plugins[docker]
```

#### Systemd in Containers
The role requires systemd for SSH service management. Our Molecule config enables this:
```yaml
privileged: true
command: /lib/systemd/systemd
volumes:
  - /sys/fs/cgroup:/sys/fs/cgroup:rw
```

**On macOS**: Docker Desktop supports privileged containers and cgroup mounting, so systemd works correctly.

#### Old Distribution Images
Some older distributions (Debian Stretch, Ubuntu Xenial) may have deprecated mirrors:
- Tests may be slower due to repository access
- Consider skipping EOL distributions in local development
- CI will still test them for compatibility

#### macOS: Platform-Specific Issues

**Issue: "cannot mount /sys/fs/cgroup" errors**
- Solution: This is expected on older Docker Desktop versions. Update to latest Docker Desktop (4.x+)

**Issue: Tests hang during systemd startup**
- Solution: Increase Docker Desktop memory allocation to at least 4GB
- Go to: Docker Desktop → Settings → Resources → Memory

**Issue: IPv6 related warnings**
- Solution: These warnings are harmless and can be ignored on macOS

## Resources

- **Molecule Documentation**: https://molecule.readthedocs.io/
- **GitHub Actions**: https://docs.github.com/en/actions
- **Docker Hub Images**: https://hub.docker.com/
- **Ansible Lint**: https://ansible.readthedocs.io/projects/lint/

---

*Last updated: 2025-10-05*
