# Setup Requirements

This template requires a few tools to be installed for full functionality.
All hooks fail gracefully if tools are missing — nothing will break, but
you'll lose validation features.

## Required

| Tool | Purpose | Install |
| ---- | ---- | ---- |
| **Git** | Version control, branch management | [git-scm.com](https://git-scm.com/) |
| **Cursor** | AI agent IDE | [cursor.com](https://cursor.com) |

## Recommended

| Tool | Used By | Purpose | Install |
| ---- | ---- | ---- | ---- |
| **jq** | Hooks | JSON parsing in commit/push/agent hooks | See below |
| **Python 3** | Hooks | JSON validation and hook stdout encoding | [python.org](https://www.python.org/) |
| **Bash** | All hooks | Shell script execution | Included with Git for Windows |

### Installing jq

**Windows** (any of these):
```
winget install jqlang.jq
choco install jq
scoop install jq
```

**macOS**:
```
brew install jq
```

**Linux**:
```
sudo apt install jq     # Debian/Ubuntu
sudo dnf install jq     # Fedora
sudo pacman -S jq       # Arch
```

## Platform Notes

### Windows
- Git for Windows includes **Git Bash**, which provides the `bash` command
  used by hooks in `.cursor/hooks.json`
- Ensure Git Bash is on your PATH (default if installed via the Git installer)

### macOS / Linux
- Bash is available natively
- Install `jq` via your package manager for full hook support

## Verifying Your Setup

Run these commands to check prerequisites:

```bash
git --version          # Should show git version
bash --version         # Should show bash version
jq --version           # Should show jq version (optional)
python3 --version      # Should show python version (optional)
```

## What Happens Without Optional Tools

| Missing Tool | Effect |
| ---- | ---- |
| **jq** | Commit/push/agent hooks fall back to grep parsing. Validation still runs. |
| **Python 3** | JSON data-file validation and some hook JSON output is skipped. |
| **Both** | Hooks still execute without error (exit 0) but provide weaker validation. |

## Recommended IDE

This template is built for **Cursor**. Open the project folder and start an
Agent chat, then run `/start`.
