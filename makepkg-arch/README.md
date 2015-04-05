# ArchLinux makepkg image

This image contains the basic development environment required for building
packages for ArchLinux.

## Usage

The two most common usages are the building of an installable package and
the creation of a source distributable for submission to the [AUR][aur].

For creating a package for installation (*.pkg.tar.xz):

```
docker run \
    --rm --volume "$(pwd):/data" \
    gbleux/makepkg-arch:latest
```

For creating a archive of the sources (*.srv.tar.gz):

```
docker run \
    --rm --volume "$(pwd):/data" \
    gbleux/makepkg-arch:latest --source
```

[aur]: https://aur.archlinux.org
