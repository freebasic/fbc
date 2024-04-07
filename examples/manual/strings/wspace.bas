'' examples/manual/strings/wspace.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'WSPACE'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgWspace
'' --------

Dim a As WString * 10
a = "x" + WSpace(3) + "x"
Print a ' prints: x   x
