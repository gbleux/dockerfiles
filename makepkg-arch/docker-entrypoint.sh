#!/bin/sh
set -eu

case "${1:-makepkg}" in
    -*)
        exec gosu "${MAKEPKG_USER}" makepkg "$@"
        ;;
    makepkg)
        exec gosu "${MAKEPKG_USER}" "$@"
        ;;
    *)
        exec "$@"
        ;;
esac
