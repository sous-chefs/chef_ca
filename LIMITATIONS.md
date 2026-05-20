# Limitations

As of April 21, 2026, this cookbook manages the `cacert.pem` trust bundle used by existing
Chef omnibus installs. It doesn't install Chef products; it only appends a CA bundle to an
already-present certificate store.

## Package Availability

### Chef Infra Client

- Red Hat Enterprise Linux: `8.x`, `9.x`, `10.x` on `x86_64`; `8.x` and `9.x` also support `aarch64`
- Ubuntu LTS: `20.04`, `22.04`, `24.04` on `x86_64`; `20.04+` also supports `aarch64`
- macOS: `13.x`, `14.x` on `aarch64`
- Windows: `2016`, `2019`, `2022`, `2025`, `10`, and `11` on `x86_64`

### Chef Workstation / Legacy ChefDK

- Chef Workstation omnibus packages support Red Hat Enterprise Linux / CentOS `7.x`, `8.x`, `9.x` on `x86_64`
- Chef Workstation omnibus packages support Ubuntu `18.04`, `20.04`, `22.04` on `x86_64`
- Chef Workstation omnibus packages support macOS `13.x`, `14.x` on `aarch64`
- Chef Workstation omnibus packages support Windows `10`, `11`, `Server 2016`, `Server 2019`, and `Server 2022` on `x64`
- Legacy `chefdk` installs used `/opt/chefdk` on Unix-like systems and `C:/opscode/chefdk` on Windows

## Architecture Limitations

- Chef Infra Client has broader architecture coverage than Chef Workstation; this cookbook only exposes file-path targeting and doesn't validate package availability itself
- Chef Workstation omnibus support is narrower than Chef Infra Client support and is primarily `x86_64` on Linux

## Source / Compiled Installation

- No source build flow applies here
- The cookbook assumes Chef Infra Client, Chef Workstation, or legacy ChefDK is already installed and that the target `cacert.pem` path exists or is intentionally overridden with `cacert_path`

## Known Issues

- Chef Workstation 26 moved to Habitat-based packaging and no longer ships the historical omnibus layout under `/opt/chef-workstation/embedded/...`; this cookbook targets the omnibus-style certificate path and keeps `:chefdk` support only for legacy installs
- This cookbook doesn't manage repository setup, package installation, or directory creation for missing Chef product paths
