<div align="center">
  <img src="docs/favicon.svg" alt="forge monogram" width="128" />

# forge

</div>

Hi. This is my custom Arch Linux package repository.

The packages are built, signed with _GNU Privacy Guard (GPG)_, and published automatically. They're hosted on GitHub Pages. If you run Arch Linux, you can install these packages with `pacman`.

> [!CAUTION]
> Packages that compile to native machine code target `x86-64-v3` and need a compatible CPU. Prebuilt binaries, Python packages, scripts, and themes run on any `x86_64` machine.

## Setup

1. Import and trust the signing key:

   ```bash
   curl -fsSL https://athaurian.github.io/forge/signing_key.asc -o /tmp/forge-signing-key.asc
   sudo pacman-key --add /tmp/forge-signing-key.asc
   sudo pacman-key --lsign-key 6E299CB692113F71A3ABC006EAC1C444324DD6C6
   ```

2. Add the following block to your `/etc/pacman.conf`:

   ```ini
   [forge]
   SigLevel = Required DatabaseOptional
   Server = https://athaurian.github.io/forge
   ```

3. Sync and install:

   ```bash
   sudo pacman -Sy
   sudo pacman -S PACKAGE_NAME
   ```

To see everything that's published, run `pacman -Sl forge`.

## Packages

There are ten packages, each under the `packages/` directory:

| Package               | Description                                                                                                        |
| --------------------- | ------------------------------------------------------------------------------------------------------------------ |
| calpdf-git            | PDF toolkit to run alongside Calibre: download and swap covers, shrink PDFs, and export or rewrite bookmarks (git) |
| exercism-bin          | Download exercises from exercism.org, work on them locally, and submit your solutions (prebuilt binary)            |
| lutgen-cli-git        | Recolor images to match a color theme such as Catppuccin, Gruvbox, or Nord (git)                                   |
| orchis-theme-4px      | Orchis GTK theme built with 4px rounded corners                                                                    |
| orchis-theme-square   | Orchis GTK theme built with fully square corners                                                                   |
| swayfx-git            | Sway compositor with shadows, blur, and rounded corners, built against wlroots 0.20 (git)                          |
| ttf-google-sans       | Google Sans variable and static fonts from the official OFL release                                                |
| ttf-google-sans-code  | Google Sans Code variable fonts from the official OFL release                                                      |
| wayfreeze-git         | Freeze the screen to draw a selection and take a screenshot without movement underneath (git)                      |
| xdg-terminal-exec-git | Open the user's preferred terminal emulator from apps and scripts (git)                                            |

## Development

Run `make check` before committing. The check needs `shfmt`, Node, Python, and `uv` on your machine.

| Action                     | Details                                                                                            |
| -------------------------- | -------------------------------------------------------------------------------------------------- |
| Skip a package temporarily | Create empty `packages/NAME/HOLD`; package stays out of next build and leaves repo on next publish |

## Build pipeline

| Trigger / Rule                     | Behavior                                                                  |
| ---------------------------------- | ------------------------------------------------------------------------- |
| Push to `main`                     | Rebuilds only changed packages                                            |
| Push touching only docs or tooling | Builds nothing                                                            |
| Push changing `.github/`           | Rebuilds every package (except comment-only)                              |
| Scheduled run (04:37 UTC)          | Rebuilds every package                                                    |
| Manual dispatch from Actions       | Rebuilds every package                                                    |
| Git packages (`-git` suffix)       | `pkgver()` recomputed at build; versions advance only when upstream moved |
| Per-package isolation              | Each package builds in its own job                                        |
| Unrebuilt packages                 | Keep their published copy                                                 |
| Publish gate                       | Nothing publishes unless every job succeeds                               |

---

Enjoy.
