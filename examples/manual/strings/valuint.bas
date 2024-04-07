'' examples/manual/strings/valuint.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'VALUINT'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgValuint
'' --------

Dim a As String, b As ULong
a = "20xa211"
b = ValUInt(a)
Print a, b
