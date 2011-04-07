'' examples/manual/system/setdate.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgSetdate
'' --------

Dim m As String, d As String, y As String
m = "03" 'march
d = "13" 'the 13th
y = "1994" 'good ol' days
SetDate m + "/" + d + "/" + y
