# `alpine-pkg-glibc`
This is the [GNU C Library](https://gnu.org/software/libc/) as an Alpine Linux
package, so that you may run binaries linked against `glibc`. This package
uses as a source a custom-built `glibc` binary, built by
[**@sgerrand**](https://github.com/sgerrand)'s
[docker-glibc-builder](https://github.com/sgerrand/docker-glibc-builder).

This is a fork of his
[alpine-pkg-glibc](https://github.com/sgerrand/alpine-pkg-glibc), but updated
to the latest `glibc` version and with new CI. I did this as **@sgerrand** has
neglected to update the package in his repository for quite a long time now.

*Note:* I primarily started this project to learn how to use
[OneDev CI](https://onedev.io), and as such I am not particularly interested in
adding new features to or fixing the Docker build image, or making changes to
this repo.

If you have any features or fixes, PRs are accepted on
[GitHub](https://github.com/sevmonster/alpine-pkg-glibc/pulls). Submit issues
via [OneDev](https://git.sev.monster/sev/alpine-pkg-glibc/~issues) by
[sending an email](mailto:onedev+sev/alpine-pkg-glibc@git.sev.monster).

## Download
Binary tarball releases are built and made available via
[OneDev CI](https://git.sev.monster/sev/alpine-pkg-glibc/~builds?query=%22Job%22+is+%22build-glibc%22+and+successful)
build artifacts.

## Build
To build your own Alpine package, you first need a built binary tarball. You
can get one from the CI artifacts as mentioned above, or by building it:

```sh
# install prerequisites
sudo apk add docker abuild

git clone https://git.sev.monster/sev/alpine-pkg-glibc
cd alpine-pkg-glibc

# first arg is desired glibc version, second is the pkgrel
./build.sh 2.41 0 #builds glibc-bin-2.41-r0.tar.gz
# alternatively, put a pre-built glibc-bin-*.tar.gz in this directory

# use your favorite editor here to ensure the $pkgver and $pkgrel match the
# tarball version; if you don't do this, package creation will fail
vim APKBUILD

# recalculate checksums for the tarball
abuild checksum

# build apk
abuild -r
```

## Install
The tarballs are not intended to be installed directly, but in theory you could
manually extract them to `/usr` on an Alpine/musl libc system:

```sh
tar -C /usr -xzf glibc-bin-*.tar.gz
```

Pre-built Alpine packages are available in my
[Alpine repo](https://alpine.sev.monster/edge/testing/x86_64/glibc).
Installation instructions are available in the
[repo `README`](https://git.sev.monster/sev/aports).

If you are using tools like `localedef` you will need the `glibc-bin` and
`glibc-i18n` packages in addition to the `glibc` package.

### `gcompat`/`libc6-compat`?
Previously, if you wanted to also install `gcompat` (previously `libc6-compat`), which was also a dependency of `glibc-bin`, you had to:
1. Install `gcompat` *first*
2. Remove its `ld-linux-x86-64.so` loader from `/lib`
3. Install `glibc`/`glibc-bin` with `--force-overwrite`

This was a cumbersome and error-prone process. To avoid that issue, this
package will overwrite `gcompat` if it is installed, by setting
`replaces=gcompat`.

## Locales
You will need to generate your locale if you would like to use a specific one
for your glibc application. You can do this by installing the `glibc-i18n`
package and generating a locale using the `localedef` binary. An example for
`en_US.UTF-8` would be:

```
apk add glibc-bin glibc-i18n
/usr/glibc-compat/bin/localedef -i en_US -f UTF-8 en_US.UTF-8
```
