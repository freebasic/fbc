'' examples/manual/strings/val.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'VAL'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgVal
'' --------

Dim a As String, b As Double
a = "2.1E+30xa211"
b = Val(a)
Print a, b
