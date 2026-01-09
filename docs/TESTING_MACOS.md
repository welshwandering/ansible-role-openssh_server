# Testing on macOS with Docker Desktop

This guide provides macOS-specific instructions for running Molecule tests locally.

## Quick Start (macOS)

### 1. Install Docker Desktop

Download and install Docker Desktop for Mac:
- **URL**: https://www.docker.com/products/docker-desktop/
- **Requirements**: macOS 11+ (Big Sur or later)
- **Architecture**: Supports both Intel and Apple Silicon (M1/M2/M3)

After installation:
1. Open Docker Desktop from Applications
2. Wait for Docker engine to start (whale icon in menu bar should be steady)
3. Verify installation:
   ```bash
   docker ps
   # Should show empty list (no containers running)
   ```

### 2. Install Python Dependencies

Using pip3 (recommended):
```bash
# Install Molecule and dependencies
pip3 install molecule molecule-plugins[docker] ansible-core>=2.15

# Install Ansible collections
ansible-galaxy collection install ansible.posix>=1.5.0
ansible-galaxy collection install community.general>=8.0.0
```

Using virtual environment (alternative):
```bash
# Create virtual environment
python3 -m venv ~/molecule-env
source ~/molecule-env/bin/activate

# Install dependencies
pip install molecule molecule-plugins[docker] ansible-core>=2.15
ansible-galaxy collection install ansible.posix>=1.5.0
ansible-galaxy collection install community.general>=8.0.0
```

### 3. Run Tests

```bash
# Navigate to role directory
cd /path/to/ansible-role-openssh_server

# Run default test (Debian 12)
molecule test

# Test specific distribution
MOLECULE_DISTRO=ubuntu2404 \
MOLECULE_IMAGE=ubuntu:noble \
MOLECULE_OPENSSH_VERSION=9.6p1 \
molecule test
```

## macOS-Specific Configuration

### Docker Desktop Settings

For optimal performance, configure Docker Desktop:

**Settings → Resources:**
- **CPUs**: 4+ cores (8+ recommended for parallel testing)
- **Memory**: 8GB+ (16GB recommended for running multiple tests)
- **Disk**: 64GB+ (container images can be large)

**Settings → General:**
- ✅ Enable "Use VirtioFS" (better file system performance)
- ✅ Enable "Use Rosetta for x86/AMD64 emulation on Apple Silicon" (if on M1/M2/M3)

### Apple Silicon (M1/M2/M3) Notes

Docker Desktop supports ARM64 architecture, but some distribution images may require emulation:

**Native ARM64 (fastest):**
- ✅ Ubuntu 20.04+ (arm64 images available)
- ✅ Debian 11+ (arm64 images available)

**x86/AMD64 Emulation (slower):**
- ⚠️ Older distributions (Debian Stretch, Ubuntu Xenial)
- Uses QEMU emulation via Rosetta or built-in emulation
- Tests will run but may be 2-3x slower

**Running tests on Apple Silicon:**
```bash
# Tests automatically use native ARM64 images when available
molecule test

# Force x86 emulation (if needed for compatibility testing)
docker run --platform linux/amd64 debian:bookworm
```

## Performance Considerations

### Expected Test Duration (macOS)

| System | Single Test | All 15 Distributions (parallel) |
|--------|-------------|----------------------------------|
| Intel Mac (4 cores, 8GB) | 3-5 min | 40-60 min |
| Intel Mac (8 cores, 16GB) | 2-3 min | 20-30 min |
| M1/M2 Mac (8 cores, 16GB) | 2-4 min | 15-25 min |
| M3 Mac (12 cores, 24GB) | 1-2 min | 10-15 min |

**Note**: Times include pulling Docker images on first run. Subsequent runs are faster.

### Optimization Tips

#### 1. Test Only What You Need
```bash
# Instead of testing all 15, test representative samples:

# Test oldest supported (backwards compatibility)
MOLECULE_DISTRO=ubuntu1604 MOLECULE_IMAGE=ubuntu:xenial molecule test

# Test current LTS (most common)
MOLECULE_DISTRO=ubuntu2204 MOLECULE_IMAGE=ubuntu:jammy molecule test

# Test latest (newest features)
MOLECULE_DISTRO=ubuntu2404 MOLECULE_IMAGE=ubuntu:noble molecule test
```

#### 2. Use Development Workflow
```bash
# Create environment once, test multiple times
molecule create
molecule converge  # Apply changes
molecule verify    # Run tests
# Make code changes...
molecule converge  # Re-apply
molecule verify    # Re-test
molecule destroy   # Clean up when done
```

#### 3. Pre-pull Images
```bash
# Download all images in background before testing
docker pull debian:stretch &
docker pull debian:buster &
docker pull debian:bullseye &
docker pull debian:bookworm &
docker pull ubuntu:xenial &
docker pull ubuntu:bionic &
docker pull ubuntu:focal &
docker pull ubuntu:jammy &
docker pull ubuntu:noble &
wait
```

## Common macOS Issues & Solutions

### Issue: "Cannot connect to Docker daemon"

**Symptoms:**
```
ERROR: Couldn't connect to Docker daemon at unix:///var/run/docker.sock
```

**Solution:**
```bash
# Ensure Docker Desktop is running
open -a Docker

# Wait for startup (watch menu bar icon)
# Try again once whale icon is steady

# Verify Docker is running
docker ps
```

### Issue: "pip3: command not found"

**Symptoms:**
```
zsh: command not found: pip3
```

**Solution:**
```bash
# Install Python 3 via Homebrew
brew install python3

# Verify installation
python3 --version
pip3 --version

# Then install Molecule
pip3 install molecule molecule-plugins[docker]
```

### Issue: Permission Denied on pip Install

**Symptoms:**
```
ERROR: Could not install packages due to an OSError: [Errno 13] Permission denied
```

**Solution:**
```bash
# Use user installation (recommended)
pip3 install --user molecule molecule-plugins[docker] ansible-core>=2.15

# Or use virtual environment
python3 -m venv ~/molecule-env
source ~/molecule-env/bin/activate
pip install molecule molecule-plugins[docker] ansible-core>=2.15
```

### Issue: Slow Test Performance

**Symptoms:**
- Tests take 5-10 minutes each
- High CPU usage during tests

**Solutions:**

1. **Increase Docker Resources:**
   - Docker Desktop → Settings → Resources
   - Increase CPUs to 8+ and Memory to 16GB+

2. **Enable VirtioFS:**
   - Docker Desktop → Settings → General
   - ✅ Enable "Use VirtioFS"

3. **On Apple Silicon - Enable Rosetta:**
   - Docker Desktop → Settings → General (Features in development)
   - ✅ Enable "Use Rosetta for x86/AMD64 emulation"

4. **Use Native ARM64 Images:**
   ```bash
   # Prefer newer distributions with ARM support
   MOLECULE_DISTRO=ubuntu2404 molecule test  # Fast (native ARM)
   MOLECULE_DISTRO=ubuntu1604 molecule test  # Slower (x86 emulation)
   ```

### Issue: Container Fails to Start with systemd

**Symptoms:**
```
Failed to create bus connection: No such file or directory
System has not been booted with systemd as init system
```

**Solution:**
```bash
# This usually means Docker Desktop needs updating
# Update to Docker Desktop 4.0+ which supports systemd in containers

# Check Docker Desktop version
docker --version

# Update via Docker Desktop → Check for Updates
# Or download latest from: https://www.docker.com/products/docker-desktop/
```

### Issue: Port Already in Use

**Symptoms:**
```
Error: bind: address already in use
```

**Solution:**
```bash
# Find process using port 22 (SSH)
sudo lsof -i :22

# Kill existing containers
docker ps -a
docker rm -f $(docker ps -aq)

# Or stop your local SSH service temporarily
sudo launchctl unload /System/Library/LaunchDaemons/ssh.plist
```

## Development Tips for macOS

### Use direnv for Environment Variables

Install direnv to automatically load test configuration:
```bash
# Install direnv
brew install direnv

# Add to ~/.zshrc (for zsh)
eval "$(direnv hook zsh)"

# Create .envrc in role directory
cat > .envrc <<EOF
export MOLECULE_DISTRO=ubuntu2404
export MOLECULE_IMAGE=ubuntu:noble
export MOLECULE_OPENSSH_VERSION=9.6p1
EOF

# Allow direnv
direnv allow .

# Now molecule commands use these variables automatically
molecule test
```

### Use iTerm2 Split Panes

Run multiple tests in parallel:
1. Open iTerm2
2. Split pane horizontally (Cmd+D)
3. Split each pane vertically (Cmd+Shift+D)
4. Run different distribution tests in each pane

### Cleanup Docker Resources

Docker can consume significant disk space:
```bash
# Remove all stopped containers
docker container prune -f

# Remove all unused images
docker image prune -a -f

# Remove all unused volumes
docker volume prune -f

# Nuclear option - remove everything
docker system prune -a --volumes -f

# Check disk usage
docker system df
```

## Testing Workflow Example

Complete workflow for macOS development:

```bash
# 1. Setup (one time)
brew install docker  # If using Colima instead of Docker Desktop
pip3 install --user molecule molecule-plugins[docker] ansible-core
ansible-galaxy collection install ansible.posix community.general

# 2. Start Docker Desktop
open -a Docker
sleep 10  # Wait for startup

# 3. Pull common images (optional, for speed)
docker pull debian:bookworm
docker pull ubuntu:noble

# 4. Run quick test on modern distribution
MOLECULE_DISTRO=ubuntu2404 MOLECULE_IMAGE=ubuntu:noble molecule test

# 5. Development cycle
molecule create
molecule converge
# Edit role files...
molecule converge  # Re-apply changes
molecule verify    # Verify changes
molecule destroy   # Cleanup

# 6. Before PR - test key distributions
for distro in debian9:stretch:7.4p1 ubuntu2004:focal:8.2p1 ubuntu2404:noble:9.6p1; do
  IFS=: read -r name image version <<< "$distro"
  echo "Testing $name..."
  MOLECULE_DISTRO=$name MOLECULE_IMAGE=$image MOLECULE_OPENSSH_VERSION=$version molecule test
done
```

## Alternative: Colima (Lightweight Docker)

For a lighter alternative to Docker Desktop:

```bash
# Install Colima (Docker Desktop alternative)
brew install colima docker

# Start Colima with sufficient resources
colima start --cpu 8 --memory 16

# Use Molecule as normal
molecule test

# Stop Colima when done
colima stop
```

**Colima Benefits:**
- ✅ Lighter weight than Docker Desktop
- ✅ Free for all use cases
- ✅ Better resource management
- ✅ CLI-focused workflow

**Colima Limitations:**
- ❌ No GUI
- ❌ Requires manual resource configuration
- ❌ May need additional setup for systemd

## Summary

✅ **Molecule tests work perfectly on macOS with Docker Desktop**
- All 15 distributions are supported
- Performance is good on modern Macs
- No special configuration needed beyond Docker Desktop installation
- Apple Silicon (M1/M2/M3) is fully supported with native ARM64 images

📌 **Key Points:**
1. Install Docker Desktop first
2. Use pip3 for Python dependencies
3. Allocate sufficient resources in Docker Desktop settings
4. On Apple Silicon, newer distributions run faster (native ARM64)
5. Pre-pull images for faster subsequent runs

🚀 **Ready to test?**
```bash
molecule test
```

---

*Last updated: 2025-10-05*
