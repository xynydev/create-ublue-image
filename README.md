# create-ublue-image

This is a small containerized tool to automatically create a functional Github repository custom ostree native container image based on [ublue-os/startingpoint](https://github.com/ublue-os/startingpoint).

## Running

`create-ublue-image` should run on any computer with [Podman](https://podman.io/) installed. If you are already running an immutable Fedora variant, you shouldn't have to install anything.

Run the following command in a directory that you have write access to, your repo will be created as a subdirectory. The script will ask you further questions.

```
podman run -v "$(pwd)":/host -it ghcr.io/einohr/create-ublue-image
```

## Can I trust you?

This tool uses `github-cli` to authenticate to your account, which could be a security concern.
You can read all of the code in `wizard.sh` (<100 loc) and see for yourself everything this tool does.
You can also just set up the repository manually.
