# dotfiles

My development environment for macOS, managed with **Nix + Home Manager**.

The goal is simple: keep the workstation reproducible, keep configuration versioned, and make rebuilding the environment considerably less painful than remembering what I installed six months ago.

Most of the actual work happens in **Neovim**, surrounded by terminal tooling and a growing collection of AI-assisted development integrations.

## What's inside

```text
.
├── agent-skills/          # Reusable agent skills
├── copilot/.copilot/      # GitHub Copilot configuration
├── git/                   # Git configuration
├── nvim/.config/nvim/     # Neovim configuration
├── tmux/                  # tmux configuration
├── wezterm/.config/       # WezTerm configuration
├── flake.nix              # Nix flake
├── flake.lock
├── home.nix               # Home Manager environment
├── first-run.sh
├── install-nix.sh
├── post-install.sh
└── reload-home.sh
```

## Environment

### Nix + Home Manager

The base development environment is declared through a Nix flake and Home Manager.

It manages the tools I use across different projects and keeps the machine setup reproducible instead of relying on an ever-growing pile of manually installed packages.

```bash
./install-nix.sh
./first-run.sh
```

Existing installations can be updated through:

```bash
./reload-home.sh
```

> These are personal dotfiles. Read the scripts before executing them on your machine — blindly running shell scripts from the internet remains an exciting but suboptimal configuration strategy.

## Neovim

Neovim is the center of the environment rather than just a text editor.

The configuration includes tooling for:

- LSP and code navigation
- fuzzy finding and project navigation
- debugging
- Git workflows
- terminal integration
- AI-assisted development
- MCP-based tools
- project-specific workflows

The configuration lives under:

```text
nvim/.config/nvim/
```

Some of the tooling used here eventually escapes containment and becomes a standalone plugin.

See also:

- [nvim-gitlab](https://github.com/mm4cN/nvim-gitlab)
- [nvim-conan](https://github.com/mm4cN/nvim-conan)

## Terminal

The terminal environment is built around:

- **WezTerm** — terminal emulator
- **tmux** — persistent terminal sessions and multiplexing
- **Neovim** — editor and primary development interface
- **Git** — version control
- common CLI development tools managed through Nix

The intention is to keep the workflow usable without depending on a traditional IDE.

## AI tooling

The repository also contains configuration and reusable components for AI-assisted development:

```text
agent-skills/
copilot/.copilot/
```

These are used to experiment with agent workflows, reusable instructions and tool-assisted development while keeping the configuration itself versioned alongside the rest of the environment.

## Structure

The repository follows a layout suitable for symlink/stow-style configuration where useful, while the development environment itself is primarily described through Nix and Home Manager.

This keeps application configuration separate from package/environment management:

```text
Nix / Home Manager
        │
        ├── packages
        ├── development tools
        └── environment
                 │
                 ▼
            dotfiles
        ┌────────┼────────┐
        ▼        ▼        ▼
      Neovim   WezTerm   tmux
```

## Notes

This repository represents my actual working environment and changes with it.

It is published primarily as a reference rather than as a generic dotfiles distribution. Feel free to borrow individual pieces, but expect opinions.

Strong opinions.

Mostly about editors.

---

*Yes, this is an elaborate way of configuring Neovim.*
