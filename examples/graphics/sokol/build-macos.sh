#!/bin/sh
# Build sokol_triangle on macOS.
#
# sokol is header-only, so there is no library to install: this script fetches
# the pinned C headers into ./sokol/ (verified by sha256), compiles the sokol
# implementation as Objective-C, and links the FreeBASIC program against it.
set -eu

here=$(cd "$(dirname "$0")" && pwd)
root=$(cd "$here/../../.." && pwd)
fbc=${FBC:-}
if [ -z "$fbc" ]; then
	if [ -x "$root/bin/fbc" ]; then fbc="$root/bin/fbc"; else fbc=fbc; fi
fi
cd "$here"

fetch() { # url sha256 file
	if [ ! -f "$3" ]; then
		echo "fetching $3"
		curl -fsSL "$1" -o "$3"
	fi
	echo "$2  $3" | shasum -a 256 -c - >/dev/null || {
		echo "checksum mismatch: $3" >&2
		exit 1
	}
}

mkdir -p sokol
gfx_commit=79611ab0d5e90d838f048e60d99aeca0a1bd187a
app_commit=13554f665ebf32522b9e0323b35f08fb836b98b2
base=https://raw.githubusercontent.com/floooh/sokol

fetch "$base/$gfx_commit/sokol_gfx.h" \
	34dcb2c5e0df3904bbe1e3da3f045b5a87a6a39531eea425bc03d16c0d15743e sokol/sokol_gfx.h
fetch "$base/$app_commit/sokol_app.h" \
	9c8b071e4b1d5f9692cb636216ad688dbf905f99f6fbc920d808a477c9a49437 sokol/sokol_app.h
fetch "$base/$gfx_commit/sokol_time.h" \
	0eeb8c1bc9ac2ec4438090f68e2ab0eb85d1daf10643158dec11383a8e8b1872 sokol/sokol_time.h
fetch "$base/$gfx_commit/sokol_log.h" \
	008999c5cd000adfbce47866423b751180ca24d2acf00db81d842747aad88152 sokol/sokol_log.h

echo "compiling the sokol implementation (Objective-C / Metal)"
clang -c -O2 -o sokol_impl.o sokol_impl.m -Isokol

echo "compiling sokol_triangle.bas"
"$fbc" -i "$root/inc" sokol_triangle.bas sokol_impl.o \
	-Wl -framework,Cocoa,-framework,Metal,-framework,MetalKit,-framework,QuartzCore

echo "built $here/sokol_triangle"
