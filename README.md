
---
# Tools
---

Collection of useful scripts and utilities for system setup and configuration.

## 📋 Contents
---

### docker_install.sh

Automated script for installing Docker Engine on Ubuntu/Debian systems following official Docker installation guidelines.

**Features:**
- Automated installation of Docker CE and all components
- Prerequisites verification and installation
- Official Docker GPG key configuration
- Repository setup with automatic architecture detection
- Docker group configuration for non-sudo usage
- Installation verification with hello-world test
- Pre-installation check to avoid duplicate installations
- Comprehensive error handling with `set -euo pipefail`
- Informative progress messages throughout the process

**Installed components:**
- `docker-ce`: Docker Community Edition (main engine)
- `docker-ce-cli`: Docker command-line interface
- `containerd.io`: Container runtime
- `docker-buildx-plugin`: Advanced image builder
- `docker-compose-plugin`: Multi-container orchestration

**How to use:**

1. Download the script:
   ```bash
   git clone git@github.com:Hag-Zilla/tools.git
   cd tools
   ```

2. Make the script executable:
   ```bash
   chmod +x docker_install.sh
   ```

3. Run the installation:
   ```bash
   ./docker_install.sh
   ```

4. After installation, log out and log back in (or run `newgrp docker`) to use Docker without sudo.

**Requirements:**
- Ubuntu or Debian-based Linux distribution
- Sudo privileges
- Internet connection

**Note:** The script will prompt for confirmation if Docker is already installed on your system.

## 🤝 Contributing
---

Contributions are welcome! If you have scripts, tools, or improvements to share:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-tool`)
3. Commit your changes (`git commit -m 'Add some amazing tool'`)
4. Push to the branch (`git push origin feature/amazing-tool`)
5. Open a Pull Request

Please ensure your scripts include:
- Clear documentation
- Error handling
- Usage instructions
- Comments in English

## Support
---

> Maintained by [Hag-Zilla](https://github.com/Hag-Zilla)

## License
---

See [LICENSE](LICENSE) file for details.