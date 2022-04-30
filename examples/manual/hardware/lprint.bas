'' examples/manual/hardware/lprint.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'LPRINT'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgLprint
'' --------

'' Compile with -lang fblite or qb

#lang "fblite"

'' new-line
LPrint "Hello World!"

'' no new-line
LPrint "Hello"; "World"; "!";

LPrint

'' column separator
LPrint "Hello!", "World!"

'' end of page
LPrint Chr$(12)
