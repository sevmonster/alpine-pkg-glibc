#!/bin/sh
if [ -z "$1" -o -z "$2" ]; then
    echo 'error: must specify package version

usage: build.sh <glibc-version> <pkgrel>
example: build.sh 2.41 0' >&2
    exit 1
fi

docker run --rm --env STDOUT=1 \
  sgerrand/glibc-builder $1 /usr/glibc-compat \
  > "glibc-bin-$1-r$2.tar.gz"

# vim: sts=4 sw=4 et
