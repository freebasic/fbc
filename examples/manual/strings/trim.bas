'' examples/manual/strings/trim.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgTrim
'' --------

Dim s1 As String = " ... Stuck in the middle ... "
Print "'" + Trim(s1) + "'"
Print "'" + Trim(s1, Any " .") + "'"

Dim s2 As String = "BaaBaaaaB With You aaBBaaBaa"
Print "'" + Trim(s2, "Baa") + "'"
Print "'" + Trim(s2, Any "Ba") + "'"
