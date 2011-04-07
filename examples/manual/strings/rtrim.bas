'' examples/manual/strings/rtrim.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgRtrim
'' --------

Dim s1 As String = "Article 101  "
Print "'" + RTrim(s1) + "'"
Print "'" + RTrim(s1, " 01") + "'"
Print "'" + RTrim(s1, Any " 10") + "'"

Dim s2 As String = "Test Pattern aaBBaaBaa"
Print "'" + RTrim(s2, "Baa") + "'"
Print "'" + RTrim(s2, Any "Ba") + "'"
