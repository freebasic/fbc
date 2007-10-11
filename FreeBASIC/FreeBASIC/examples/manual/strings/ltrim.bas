'' examples/manual/strings/ltrim.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgLtrim
'' --------

Dim s1 As String = "  101 Things to do."
Print "'" + LTrim(s1) + "'"
Print "'" + LTrim(s1, " 01") + "'"
Print "'" + LTrim(s1, Any " 01") + "'"

Dim s2 As String = "BaaBaaBAA Test Pattern"
Print "'" + LTrim(s2, "Baa") + "'"
Print "'" + LTrim(s2, Any "BaA") + "'"
