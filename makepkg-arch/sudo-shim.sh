#!/bin/sh
set -eu

exec gosu root "$@"
