'' examples/manual/strings/trim.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'TRIM'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgTrim
'' --------

Dim s1 As String = " ... Stuck in the middle ... "
Print "'" + Trim(s1) + "'"
Print "'" + Trim(s1, Any " .") + "'"

Dim s2 As String = "BaaBaaaaB With You aaBBaaBaa"
Print "'" + Trim(s2, "Baa") + "'"
Print "'" + Trim(s2, Any "Ba") + "'"
