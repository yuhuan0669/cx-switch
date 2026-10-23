# cx-switch

> **A Safe, Seamless Multi-Account Switcher for OpenAI Codex CLI & Desktop.**
> 
> 针对 OpenAI Codex CLI 与 Desktop 设计的安全、无感多账号切换工具，原生兼容 macOS / Linux 上的 Bash 与 Zsh。

<p align="left">
  <a href="README_EN.md">English</a> | <b>简体中文</b>
</p>

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-macOS%20%7C%20Linux-lightgrey.svg)]()
[![Shell](https://img.shields.io/badge/Shell-Bash%20%7C%20Zsh-4EAA25.svg)]()

---

## 🌟 特性亮点 (Features)

- 🔒 **杜绝凭据污染**：严格区分“切换已有账号”与“绑定新账号”，杜绝因重复登录导致旧账号凭据被静默覆盖的经典陷阱。
- 🛡️ **生产级安全防御**：所有凭据写入均强制 `umask 077`（仅当前用户只读只写），杜绝系统多用户嗅探敏感 Token。
- ⚡ **原子替换 (Atomic Swap)**：采用 `.tmp` + `mv` 同分区重命名，保证断电或异常中止时凭据不损坏。
- 🔄 **原地自动同步**：在同名账号下执行时，自动检测并同步 Codex 自动 Refresh 的最新凭据，无需切换即可更新本地备份。
- 🛑 **防并发冲突拦截**：精准检测 Codex 正在运行的进程，防止热切换引起的文件锁冲突与读写覆盖（支持 `-f / --force`）。
- 🚀 **双模运行**：既可以作为独立可执行脚本放入 `PATH`，也可以直接 `source` 作为 Shell 内部函数使用。

---

## 📦 安装方法 (Installation)

### 方法 1: 一键安装 (推荐)

```bash
curl -fsSL https://raw.githubusercontent.com/yuhuan0669/cx-switch/main/install.sh | bash
```

> 默认安装至 `~/.local/bin/cx-switch`。如果该目录尚未在 `$PATH` 中，请在 `~/.zshrc` 或 `~/.bashrc` 添加：
> ```bash
> export PATH="$HOME/.local/bin:$PATH"
> ```

### 方法 2: 手动克隆与软链接

```bash
git clone https://github.com/yuhuan0669/cx-switch.git
cd cx-switch
chmod +x cx-switch
mkdir -p ~/.local/bin
ln -sf "$(pwd)/cx-switch" ~/.local/bin/cx-switch
```

### 方法 3: 作为 Shell 函数引入 (.zshrc / .bashrc)

在你的 `~/.zshrc` 或 `~/.bashrc` 末尾添加：

```bash
source /path/to/cx-switch/cx-switch
```

---

## 🚀 快速上手 (Quick Start)

### 1. 首次绑定当前正在使用的账号

登录你的 Codex 账号后，将其命名并绑定：

```bash
cx-switch save work
```

### 2. 添加并切换至全新账号

当你需要添加新账号时，运行：

```bash
cx-switch new
```
> 脚本会自动为你安全封存旧账号，并重置当前的登录环境。启动 Codex 并登录新账号后，执行：
> ```bash
> cx-switch save personal
> ```

### 3. 在不同账号间切换

```bash
# 切换至 work
cx-switch work

# 切换至 personal
cx-switch personal
```

### 4. 查看当前状态与所有备份

```bash
cx-switch
# 或
cx-switch status
```

输出示例：
```text
=== Codex 账号管理 (cx-switch v1.0.0) ===
当前激活账号: work

已保存的账号备份:
    personal
  * work (当前激活)

常用指令:
  cx-switch <账号名>          切换到指定账号 (若已在当前账号则自动同步刷新凭据)
  cx-switch save <账号名>     将当前活跃登录凭据另存/绑定为指定账号
  cx-switch new               安全封存当前账号并清空凭据，以便启动 Codex 登录新账号
  cx-switch rm <账号名>       删除指定的账号备份
  cx-switch status            查看当前账号与所有备份状态
```

---

## 📖 完整命令速查 (Command Reference)

| 命令 | 说明 |
| :--- | :--- |
| `cx-switch` | 列出当前激活账号及所有已保存账号 |
| `cx-switch <name>` | 切换到指定账号；若当前已是该账号，则自动同步刷新最新 Token |
| `cx-switch -f <name>` | 强制切换（即便检测到 Codex 正在运行） |
| `cx-switch save <name>` | 将当前 `auth.json` 里的有效凭据另存为指定名称 |
| `cx-switch new` | 归档当前账号并清理登录态，准备登录全新账号 |
| `cx-switch rm <name>` | 删除指定的账号备份文件 |
| `cx-switch -v` | 查看版本信息 |
| `cx-switch -h` | 显示帮助手册 |

---

## 🔧 自定义配置 (Environment Variables)

- `CODEX_HOME`：Codex 配置文件存放根目录，默认值为 `$HOME/.codex`。
  如需使用自定义配置路径：
  ```bash
  export CODEX_HOME="/path/to/your/codex"
  ```

---

## 📄 开源许可证 (License)

本项目采用 [MIT 许可证](LICENSE)。
