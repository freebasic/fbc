#!/bin/sh
#
# fsyntax.sh - check the -fsyntax mode
#
# -fsyntax parses and type-checks a program but generates no code.  It must:
#
#   * exit 0 on a valid program, and create no output files
#   * exit 1 with a line number on a syntax error
#   * exit 1 with a line number on a semantic error
#   * follow #include
#   * still report an undefined label
#
# Usage:  FBC=".../bin/fbc -i .../inc" ./fsyntax.sh
#
# The directory is created fresh under the system temp dir and removed at the
# end, so the test leaves nothing behind.

set -e

FBC=${FBC:-fbc}
TMPBASE=${TMPDIR:-/tmp}
WORK="$TMPBASE/frej-fsyntax-$$"

rm -rf "$WORK"
mkdir -p "$WORK"
trap 'rm -rf "$WORK"' EXIT INT TERM

cd "$WORK"

pass=0
fail=0

ok() { pass=$((pass + 1)); printf '  PASS  %s\n' "$1"; }
no() { fail=$((fail + 1)); printf '  FAIL  %s\n' "$1"; }

# --- a valid program, and the promise that nothing is written ---------------
cat > good.bas <<'EOF'
dim as integer x, y
x = 1
y = x + 2
print y
EOF

if $FBC -fsyntax good.bas >/dev/null 2>&1; then
	ok "valid program exits 0"
else
	no "valid program exits 0"
fi

if [ -z "$(ls | grep -v '\.bas$')" ]; then
	ok "valid program creates no output files"
else
	no "valid program creates no output files: $(ls | grep -v '\.bas$')"
fi

# --- a syntax error --------------------------------------------------------
cat > bad.bas <<'EOF'
dim as integer x
x =
EOF

if $FBC -fsyntax bad.bas >/dev/null 2>&1; then
	no "syntax error exits non-zero"
else
	ok "syntax error exits non-zero"
fi

if $FBC -fsyntax bad.bas 2>&1 | grep -q 'bad\.bas(2)'; then
	ok "syntax error reports the line"
else
	no "syntax error reports the line"
fi

# --- a semantic error ------------------------------------------------------
cat > sem.bas <<'EOF'
dim as integer x
dim as string s
x = s
EOF

if $FBC -fsyntax sem.bas >/dev/null 2>&1; then
	no "type mismatch exits non-zero"
else
	ok "type mismatch exits non-zero"
fi

# --- includes --------------------------------------------------------------
cat > shared.bi <<'EOF'
type Point2D
	x as integer
	y as integer
end type
EOF

cat > withinc.bas <<'EOF'
#include once "shared.bi"
dim as Point2D p
p.x = 1
p.y = 2
print p.x + p.y
EOF

if $FBC -fsyntax withinc.bas >/dev/null 2>&1; then
	ok "follows #include"
else
	no "follows #include"
fi

# --- undefined label -------------------------------------------------------
cat > lbl.bas <<'EOF'
goto nolabel
EOF

if $FBC -fsyntax lbl.bas >/dev/null 2>&1; then
	no "undefined label is reported"
else
	ok "undefined label is reported"
fi

# --- the tests did not leave anything behind -------------------------------
leftover=$(ls | grep -v '\.bas$' | grep -v '\.bi$' || true)
if [ -z "$leftover" ]; then
	ok "no stray files after the suite"
else
	no "no stray files after the suite: $leftover"
fi

printf '\n%d pass, %d fail\n' "$pass" "$fail"
[ "$fail" -eq 0 ]
