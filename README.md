# P5-OS BASE

A base image with a mostly stock [Fedora Silverblue](https://silverblue.fedoraproject.org/) installation.

## Usage

:warning:
This is an experimental feature. It is not recommended to use this image in production. :warning:

```bash
  $ sudo rpm-ostree rebase --experimental ostree-unverified-registry:ghcr.io/p5-os/silverblue-base:stable
```

The `latest` tag will always point to the most recent build.
The `stable` tag will always point to the most recent stable build.

:construction:
Each tag will have a sister tag with the `-nvidia` suffix. This tag is the same as the base, but with the NVIDIA drivers
preinstalled.
:construction:

## Features

- Removes Firefox
- Replaces [`toolbox`](https://github.com/containers/toolbox) with [`distrobox`](https://github.com/89luca89/distrobox)
- Installs [`gnome-tweaks`](https://gitlab.gnome.org/GNOME/gnome-tweaks)
- Sets automatic staging of updates
- Sets automated [Flatpak](https://flatpak.org/) updates
- A mostly stock [GNOME](https://www.gnome.org/) desktop environment

## Verification

These images are signed using [`sigstore/cosign`](https://github.com/sigstore/cosign) and can be verified using the
following command:

```bash
  $ cosign verify -key .certs/cosign.pub ghcr.io/p5-os/silverblue-base
```
