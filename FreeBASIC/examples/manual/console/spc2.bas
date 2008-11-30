'' examples/manual/console/spc2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgSpc
'' --------

'' Uses Spc to justify text instead of Tab

Dim As String A1, B1, A2, B2

A1 = "Jane"
B1 = "DOE"
A2 = "Bob"
B2 = "Smith"

Print "FIRST NAME"; Spc(35 - 10); "LAST NAME"
Print "----------"; Spc(35 - 10); "----------"
Print A1; Spc(35 - Len(A1)); B1
Print A2; Spc(35 - Len(A2)); B2
