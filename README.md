# create-ublue-image

This is a small containerized tool to automatically create a functional Github repository custom ostree native container image based on [ublue-os/startingpoint](https://github.com/ublue-os/startingpoint).

## Running

`create-ublue-image` should run on any computer with [Podman](https://podman.io/) installed. If you are already running an immutable Fedora variant, you shouldn't have to install anything.

Run the following command in a directory that you have write access to, your repo will be created as a subdirectory. The script will ask you further questions.

```
podman run -v "$(pwd)":/host:z -it ghcr.io/einohr/create-ublue-image
```

This command runs the OCI container built in this repo using `podman` mounting your working directory `pwd` into the container under the path `/host`. `:z` makes it possible for multiple containers to use the volume at the same time, which is useful when running a Distrobox. If you run into issues with "relabeling" when running the command, you should try removing `:z` from the end of the mount command.  
**It is not recommended to run the tool inside your home directory, but rather a subdirectory, as that can cause errors.** However, if the command tool starts in your home dir without any errors, it should probably function. You do not need to run the tool in an empty directory, it will create a new one with the name that you input.

## Can I trust you?

This tool uses `github-cli` to authenticate to your account, which could be a security concern.
You can read all of the code in `wizard.sh` (<100 loc) and see for yourself everything this tool does.
You can also just set up the repository manually.
