<div align="center">
<img src="docs/favicon.svg" alt="forge monogram" width="128">

# forge

</div>

Hi. This is my custom Arch Linux package repository.

The packages are built, signed with _GNU Privacy Guard (GPG)_, and published
automatically. They're hosted on GitHub Pages. If you run Arch Linux, you can
install these packages with `pacman`.

> [!CAUTION]
> Packages that compile to native machine code target `x86-64-v3` and need a
> compatible CPU. Prebuilt binaries, Python packages, scripts, and themes run
> on any `x86_64` machine.

## Setup

1. Import and trust the signing key:

   ```sh
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

   ```sh
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

## Patches

Some packages need a change that upstream has not released yet. I keep that
change as a patch file next to the `PKGBUILD` and apply it in `prepare()`. This
way I do not have to fork the whole repository or wait for a pull request.

| Package    | Patch                            | Effect                                                                                  |
| ---------- | -------------------------------- | --------------------------------------------------------------------------------------- |
| swayfx-git | `libinput-scroll-circular.patch` | Report `circular` as the libinput scroll method in the IPC JSON                         |
| swayfx-git | `swayfx-layer-resize.patch`      | Rearrange a layer when its buffer changes size, so the layer shadow follows the surface |

Delete a patch when upstream includes the same change.

## Development

Run `make check` before committing. The check needs `shfmt`, Node, Python, and
`uv` on your machine.

To skip a package temporarily, create an empty `packages/NAME/HOLD`. The
package stays out of the next build and returns to the repository on the next
publish.

## Build pipeline

A push to `main` rebuilds only the packages that changed. The scheduled run at
04:37 UTC and a manual dispatch rebuild every package. Git packages recompute
`pkgver` at build time, so their versions advance only when upstream moves.
Nothing publishes unless every job succeeds.

## License

Released under the MIT license. See [LICENSE](LICENSE) for the full text.

---

Enjoy.
