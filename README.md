# Forge

My custom Arch Linux package repository, built with GitHub Actions and served via GitHub Pages.

All packages are compiled with `x86-64-v3` optimizations and signed with GPG.

## Setup

Import the signing key:

```bash
sudo pacman-key --add <(curl -fsSL https://athaurian.github.io/forge/signing_key.asc)
sudo pacman-key --lsign-key 6E299CB692113F71A3ABC006EAC1C444324DD6C6
```

Add the repository to `/etc/pacman.conf`:

```ini
[forge]
SigLevel = Required DatabaseOptional
Server = https://athaurian.github.io/forge
```

Sync and install packages:

```bash
sudo pacman -Syu
sudo pacman -S <package-name>
```

## Available packages

| Package          | Description (from `PKGBUILD`)                                                              |
| ---------------- | ------------------------------------------------------------------------------------------ |
| `wayfreeze-git`  | `Tool to freeze the screen of a wayland compositor `                                       |
| `lutgen-cli-git` | `A blazingly fast interpolated lut utility for arbitrary and popular color palettes (git)` |
| `wl-screenrec`   | `High performance hardware accelerated wlroots screen recorder`                            |

## Adding a package

1. Create `packages/<package-name>/PKGBUILD`.
2. Push to `main`.
3. The workflow detects the new package, builds it, signs it, and deploys it automatically.

## How it works

1. **`changed-packages`:** Determines which packages need rebuilding based on the trigger type and changed files.
2. **`build`:** Builds each package in an Arch Linux container, signs it with GPG.
3. **`repo`:** Collects all built packages, generates a signed `repo-add` database.
4. **`deploy`:** Publishes the repository to GitHub Pages.

Scheduled builds run daily at 04:37 UTC to pick up upstream changes for `-git` packages.

---

Enjoy.
