# AGENTS.md

## Repository

Custom Arch Linux package repository. Packages live in `packages/<name>/`, are
built and signed with GPG in CI, and are published to GitHub Pages at
`https://athaurian.github.io/forge`. `signing_key.asc` is the public key.

## Commands

```bash
make check     # prettier, shfmt, ruff, mypy, py_compile
make format    # apply the formatters
```

A push to `main` rebuilds only the packages that changed. The scheduled run at
04:37 UTC and a manual dispatch rebuild everything. Nothing publishes unless
every job succeeds.

## Rules

- Never export, print, or copy the private signing key. `signing_key.asc` is
  public; the private key is not in this repository.
- Bump `pkgrel` for a packaging change and `pkgver` for an upstream change.
- Do not hand-edit built packages or the published database; change the
  `PKGBUILD` and let CI rebuild.
- Run `make check` before committing.
- Keep the signing key ID in the README in sync with the key that actually
  signs the packages.

## Constraints

- Native packages target `x86-64-v3`. Prebuilt binaries, Python packages,
  scripts, and themes run on any `x86_64` machine.
- `make check` needs `shfmt`, Node, Python, and `uv`.
- Git packages recompute `pkgver` at build time; their versions advance only
  when upstream moves.
