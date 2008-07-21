'' examples/manual/prepro/noescape.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpPpNoescape
'' --------

'' Compile with -lang fblite or qb

#lang "fblite"

Print "Default"
Print "Backslash  : \\"
Print !"Backslash !: \\"
Print $"Backslash $: \\"
Print

Option Escape

Print "Option Escape"
Print "Backslash  : \\"
Print !"Backslash !: \\"
Print $"Backslash $: \\"
Print

'' OUTPUT:

'' Default
'' Backslash  : \\
'' Backslash !: \
'' Backslash $: \\

'' Option Escape
'' Backslash  : \
'' Backslash !: \
'' Backslash $: \\
