'' examples/manual/system/setdate.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'SETDATE'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgSetdate
'' --------

Dim m As String, d As String, y As String
m = "03" 'march
d = "13" 'the 13th
y = "1994" 'good ol' days
SetDate m + "/" + d + "/" + y
