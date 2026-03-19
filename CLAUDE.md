# CLAUDE.md — AI Assistant Guide for kellenff/home

This is a **personal dotfiles repository** for Kellen Frodelius-Fujimoto. It contains shell configuration, editor settings, and development environment setup scripts for macOS/Linux workstations.

---

## Repository Overview

```
home/
├── install              # Bootstrap script — symlinks dotfiles and installs tools
├── gitconfig            # Git configuration (aliases, signing, merge strategy)
├── zshenv               # Zsh env vars and PATH (sourced for all shells)
├── zprofile             # Zsh login shell init (Homebrew, NVM on macOS)
├── zshrc                # Interactive shell config (prompt, aliases, history)
├── zsh_plugins.txt      # Antibody plugin list (Powerlevel10k, completions, etc.)
├── nvimrc               # Neovim configuration (Pathogen, CoC LSP, vim-test)
├── starship.toml        # Starship prompt configuration
├── umatrix_rules.txt    # uMatrix browser extension rules
├── boop/
│   └── sarcasm-case.js  # Boop app script for sarcastic case transformation
└── LICENSE              # Unlicense (public domain)
```

---

## Installation

The `install` script is the single entry point for bootstrapping a new machine:

```zsh
./install
```

It performs the following in order:
1. Detects OS (FreeBSD, OpenBSD, Darwin, SunOS, Linux)
2. Creates symlinks from `$HOME` pointing to files in this repo
3. Installs `vim-plug` for Neovim
4. On macOS: installs Homebrew, then `node`, `wget`, `ripgrep`, `n`, `neovim`, `zsh`, `antibody`
5. Installs `pyenv` via `pyenv-installer`
6. Installs `Starship` prompt
7. Generates the antibody plugin bundle from `zsh_plugins.txt`

The script uses `#!/usr/bin/env zsh -r -v -e` — restricted mode, verbose, and exits on any error.

---

## Development Environments Configured

The dotfiles configure the following toolchains via PATH and environment variables (primarily in `zshenv`):

| Language / Tool | Version Manager | Notes |
|-----------------|----------------|-------|
| Node.js         | NVM (via Homebrew) | Initialized in `zprofile` |
| Python          | pyenv + pyenv-virtualenv | Poetry also available |
| Go              | System install | GOPATH configured; GODEBUG set for restic |
| Rust            | Cargo          | `~/.cargo/bin` on PATH |
| Ruby            | (chruby removed) | Historical only |
| OCaml           | OPAM           | Switch path configured |
| .NET            | System install | Telemetry disabled |
| PostgreSQL      | v12            | Paths configured |

---

## Key Conventions

### Shell (Zsh)
- Configuration load order: `zshenv` → `zprofile` → `zshrc`
- `zshenv` is sourced for **all** shells (login, non-login, scripts) — keep it lean and side-effect-free
- `zprofile` handles login-shell-only init (Homebrew, NVM) — macOS specific
- `zshrc` handles interactive-shell config (prompt, completions, aliases, history)
- Prompt: **Powerlevel10k** (installed via antibody from `zsh_plugins.txt`)
- Plugins managed by **antibody** (static bundle generated at install time)

### Neovim (`nvimrc`)
- Plugin manager: **Pathogen** (runtime path manipulation)
- Indentation: **2 spaces**, `expandtab` (no literal tabs in code)
- Encoding: UTF-8
- LSP: **CoC (Conquer of Completion)** with `coc-tsserver`
  - Go: `gopls`
  - Python: configured for pytest runner
  - TypeScript: `coc-tsserver`
- Testing: **vim-test** plugin; Python uses `pytest`
- File navigation: **CtrlP** backed by `ripgrep`
- Regex: uses very magic mode (`/\v` prefix in searches)

### Git (`gitconfig`)
- **GPG signing is enabled by default** for all commits
  - Key: `B5F6EE85A5E6BBB75925D225C6BE28B394230690`
  - Use `git cin` alias (`commit --no-gpg-sign`) when signing is unavailable
- Pull strategy: **rebase** (not merge)
- Default branch name: `main`
- Useful aliases:
  - `git s` — status
  - `git a` — add
  - `git aa` — add all
  - `git ci` — commit
  - `git cim` — commit -m
  - `git cin` — commit without GPG signing

---

## No Build System / No Tests

This is a dotfiles repo — there is no test suite, no build pipeline, and no package manager (npm, pip, cargo, etc.) at the repo root. Validation is implicit: the `install` script must run without error.

---

## Adding New Dotfiles

1. Add the file to the repo root (or a subdirectory like `boop/`)
2. Add a symlink step in `install` (following the existing pattern)
3. Commit with a descriptive message

---

## Sensitive Data

`zshenv` contains credentials for personal services (Backblaze B2, Jira, GitHub). These are intentional for a private dotfiles repo but should **never** be copied into shared or public repositories. When reviewing or modifying `zshenv`, do not log or expose these values.

---

## Git Workflow for This Repo

- **Remote**: `http://local_proxy@127.0.0.1:40309/git/kellenff/home`
- **Main branch**: `master`
- Feature/AI branches: prefixed with `claude/`
- Commits should be signed (or use `git cin` if GPG is unavailable in the environment)
