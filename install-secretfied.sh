#!/bin/sh
# Usage:
#  install-secretfied.sh <input> <install(1) flags> <target>
#
# This script will create a tmp file as its output, and use install(1)
# to copy that file to the specified target.
#
# This script is expected to be run via the 1Password CLI's "run"
# command, ie 'op run -- sh install-secretfied.sh'.
#
# For each string in the form XXX_SOMETHING_XXX in the input file, the
# script assumes the presence of a matching env variable containing a
# secret fetched by op. See .env files near the Makefiles for a mapping
# of variable names to vault locations.
#
# The "SOMETHING" in XXX_SOMETHING_XXX must not contain whitespace or
# "XXX". It may contain "_".
#
# Secrets are substituted literally, so they may contain any character
# except a newline. If any token's variable is unset or empty, nothing
# is installed. Secrets never appear on a command line, and the
# temporary file is removed however the script exits.

#set -x
set -e

if ! [ -f "$1" ]; then
  echo "Usage: "
  echo '  install-secretfied.sh <input> <install(1) flags> <target>'
  exit 1
fi

TMPFILE=$(mktemp) || exit 1
trap 'rm -f "$TMPFILE"' EXIT
trap 'exit 1' HUP INT TERM

awk '
{
  rest = $0
  out = ""
  while (match(rest, /XXX_[^ ]*_XXX/)) {
    tok = substr(rest, RSTART, RLENGTH)
    if (!(tok in ENVIRON) || ENVIRON[tok] == "") {
      printf "install-secretfied.sh: %s is unset or empty\n", tok > "/dev/stderr"
      exit 1
    }
    out = out substr(rest, 1, RSTART - 1) ENVIRON[tok]
    rest = substr(rest, RSTART + RLENGTH)
  }
  print out rest
}' "$1" > "$TMPFILE"

/usr/bin/doas /usr/bin/install $2 "$TMPFILE" "$3"
