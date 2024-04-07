'' examples/manual/prepro/noescape.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Operator $ (Non-Escaped String Literal)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpPpNoescape
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
