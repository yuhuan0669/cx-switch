# cx-switch

> **A Safe, Seamless Multi-Account Switcher for OpenAI Codex CLI & Desktop.**

<p align="left">
  <b>English</b> | <a href="README.md">简体中文</a>
</p>

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-macOS%20%7C%20Linux-lightgrey.svg)]()
[![Shell](https://img.shields.io/badge/Shell-Bash%20%7C%20Zsh-4EAA25.svg)]()

---

## 🌟 Features

- 💡 **Simple & Risk-Free**: No complicated setups or black-box hooks that trip risk detections. Just clean, transparent local file management.
- 🔍 **Identity & Email Inspection**: Automatically parses internal JWT tokens to display the actual email address, display name, and subscription tier (e.g., prolite/plus/team) alongside the account alias.
- 🔒 **Zero Credential Pollution**: Strictly separates "switching existing accounts" from "binding new accounts (`save`)", eliminating the critical flaw where logging into a new session silently overwrites the previous account's backup.
- 🛡️ **Production-Grade Security**: Enforces `umask 077` (read/write only by the current user) on all credential backups and tag files, preventing multi-user privilege leakage.
- ⚡ **Atomic Replacement**: Utilizes `.tmp` staging + `mv` atomic replacement within the same filesystem, ensuring zero file corruption during power failures or sudden process termination.
- 🔄 **In-Place Sync & Auto-Refresh**: Running `cx-switch <current_account>` inspects whether Codex has refreshed its access tokens and synchronizes the local backup without needing to toggle between accounts.
- 🛑 **Concurrency Protection**: Detects running Codex CLI or Desktop processes to avoid race conditions or locked file overwrites (supports `-f / --force` override).
- 🚀 **Dual-Mode Runtime**: Works both as an executable standalone CLI binary in your `$PATH` and as a sourceable shell function in `.zshrc` / `.bashrc`.

---

## 📦 Installation

### Method 1: One-Line Installer (Recommended)

```bash
curl -fsSL https://raw.githubusercontent.com/yuhuan0669/cx-switch/main/install.sh | bash
```

> Defaults to installing at `~/.local/bin/cx-switch`. If this directory is not in your `$PATH`, append the following line to `~/.zshrc` or `~/.bashrc`:
> ```bash
> export PATH="$HOME/.local/bin:$PATH"
> ```

### Method 2: Manual Clone & Symlink

```bash
git clone https://github.com/yuhuan0669/cx-switch.git
cd cx-switch
chmod +x cx-switch
mkdir -p ~/.local/bin
ln -sf "$(pwd)/cx-switch" ~/.local/bin/cx-switch
```

### Method 3: Shell Function Integration

Add the following line to the end of your `~/.zshrc` or `~/.bashrc`:

```bash
source /path/to/cx-switch/cx-switch
```

---

## 🚀 Quick Start

### 1. Bind and Label Current Logged-in Account

After signing in with Codex, save and label your current credentials:

```bash
cx-switch save work
```

### 2. Add and Switch to a Fresh Account

When you want to log in to a second account without destroying the first one:

```bash
cx-switch new
```
> This automatically archives your current active credentials and clears the slot. Launch Codex, log in with your new account, and run:
> ```bash
> cx-switch save personal
> ```

### 3. Switch Between Accounts

```bash
# Switch to work
cx-switch work

# Switch to personal
cx-switch personal
```

### 4. Check Current Status & Backup List

```bash
cx-switch
# or
cx-switch status
```

Example Output:
```text
=== Codex Account Manager (cx-switch v1.1.0) ===
Current active alias: work
Current logged-in account: work.user@company.com (John Doe) [plus]

Saved account backups:
    personal -> personal.user@gmail.com [free]
  * work     -> work.user@company.com (John Doe) [plus] (current active)

Commands:
  cx-switch <account_name>     Switch to specified account (syncs tokens if already active)
  cx-switch save <account_name> Save current credentials as specified account
  cx-switch new                Safely archive current account and clear session for new login
  cx-switch rm <account_name>  Remove specified account backup
  cx-switch status             Display current status and list of backups
```

---

## 📖 Command Reference

| Command | Description |
| :--- | :--- |
| `cx-switch` | List current active account and all saved backups |
| `cx-switch <name>` | Switch to specified account; if already active, syncs refreshed tokens |
| `cx-switch -f <name>` | Force switch even if Codex processes are detected |
| `cx-switch save <name>` | Save current valid credentials in `auth.json` as `<name>` |
| `cx-switch new` | Archive current account and reset session for logging into a new account |
| `cx-switch rm <name>` | Delete a saved account backup |
| `cx-switch -v` | Print version information |
| `cx-switch -h` | Display help manual |

---

## 🔧 Environment Variables

- `CODEX_HOME`: Root directory for Codex configuration files. Defaults to `$HOME/.codex`.
  To customize:
  ```bash
  export CODEX_HOME="/path/to/your/codex"
  ```

---

## 📄 License

Distributed under the [MIT License](LICENSE).
