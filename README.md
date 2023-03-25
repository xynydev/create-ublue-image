# create-ublue-image

This is a small containerized tool to automatically create a functional Github repository custom ostree native container image based on [ublue-os/startingpoint](https://github.com/ublue-os/startingpoint).

## Running

`create-ublue-image` should run on any computer with [Podman](https://podman.io/) installed. If you are already running an immutable Fedora variant, you shouldn't have to install anything.

```
podman run -v "$(pwd)":/host:z -it localhost/ubluewizard-test
```
