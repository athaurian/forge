<div align="center">
<img src="docs/favicon.svg" alt="forge monogram" width="128">

# forge

</div>

Hi. This is my custom Arch Linux package repository.

Packages are built, signed with _GNU Privacy Guard (GPG)_, and published to
GitHub Pages automatically. Install the packages with `pacman`.

> [!CAUTION]
>
> - **Native packages:** Compile to native machine code, target `x86-64-v3`, and require a compatible CPU.
> - **Other packages:** Run on any `x86_64` machine.

## Setup

1. Import and trust the signing key:

   ```sh
   curl -fsSL https://athaurian.github.io/forge/signing_key.asc -o /tmp/forge-signing-key.asc
   sudo pacman-key --add /tmp/forge-signing-key.asc
   sudo pacman-key --lsign-key 6E299CB692113F71A3ABC006EAC1C444324DD6C6
   ```

2. Add this block to `/etc/pacman.conf`:

   ```ini
   [forge]
   SigLevel = Required DatabaseOptional
   Server = https://athaurian.github.io/forge
   ```

3. Sync and install:

   ```sh
   sudo pacman -Sy
   sudo pacman -S PACKAGE_NAME
   ```

To see everything that's published, run `pacman -Sl forge`.

## Packages

Each package is defined under `packages/<name>/`:

| Package                     | Description                                                                                                                 |
| --------------------------- | --------------------------------------------------------------------------------------------------------------------------- |
| calpdf-git                  | PDF toolkit to run alongside Calibre: download and swap covers, shrink PDFs, and export or rewrite bookmarks (git)          |
| exercism-bin                | Download exercises from exercism.org, solve them locally, and submit solutions (prebuilt binary)                            |
| lutgen-cli-git              | Recolor images to match a color theme such as Catppuccin, Gruvbox, or Nord (git)                                            |
| orchis-theme-4px            | Orchis GTK theme built with 4px rounded corners                                                                             |
| otf-geist-mono-nerd-trimmed | Geist Mono Nerd Font Mono with only the four styles the desktop uses                                                        |
| polybar-pinned              | Polybar with the right modules pinned to the bar edge, so a long window title cannot push the clock and systray off the bar |
| swayfx-git                  | Sway compositor with shadows, blur, and rounded corners, built against wlroots 0.20 (git)                                   |
| wayfreeze-git               | Freeze the screen to draw a selection and take a screenshot without movement underneath (git)                               |
| xdg-terminal-exec-git       | Open the user's preferred terminal emulator from apps and scripts (git)                                                     |

## Patches

When upstream has not released a change, the change is stored as a patch file
next to the `PKGBUILD` and applied in `prepare()`. Patching avoids forking the
whole repository or waiting for a pull request.

| Package        | Patch                               | Effect                                                                                  |
| -------------- | ----------------------------------- | --------------------------------------------------------------------------------------- |
| polybar-pinned | `polybar-pin-right-block.patch`     | Pin the right modules to the bar edge, so a long title is drawn under them              |
| swayfx-git     | `libinput-scroll-circular.patch`    | Report `circular` as the libinput scroll method in the IPC JSON                         |
| swayfx-git     | `swayfx-layer-resize.patch`         | Rearrange a layer when its buffer changes size, so the layer shadow follows the surface |
| swayfx-git     | `swayfx-swaybg-no-background.patch` | Do not start `swaybg` when no output has a background configured                        |

Delete a patch when upstream includes the same change.

## Development

Run `make check` before committing. It requires the `shfmt` and Node
toolchains and a Python environment managed by `uv`.

### Skipping a package

To skip a package temporarily, create an empty `packages/NAME/HOLD`. The
package stays out of the next build and returns to the repository on the next
publish.

## Build pipeline

- **Push to `main`:** Rebuilds only the package definitions the diff touched.
- **Scheduled run:** Rebuilds every package at 04:37 UTC each day.
- **Manual dispatch:** Rebuilds every package on `workflow_dispatch`.
- **Version bumps:** Git packages recompute `pkgver` at build time, so their
  versions advance only when upstream moves.
- **Publishing:** A package is published only when every job in the run
  succeeds.

## License

Released under the MIT license. See [LICENSE](LICENSE) for the full text.

---

Enjoy.
