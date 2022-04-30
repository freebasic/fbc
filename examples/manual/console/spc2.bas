'' examples/manual/console/spc2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'SPC'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgSpc
'' --------

'' Uses Spc to justify text instead of Tab

Dim As String A1, B1, A2, B2

A1 = "Jane"
B1 = "Doe"
A2 = "Bob"
B2 = "Smith"

Print "FIRST NAME"; Spc(35 - 10); "LAST NAME"
Print "----------"; Spc(35 - 10); "----------"
Print A1; Spc(35 - Len(A1)); B1
Print A2; Spc(35 - Len(A2)); B2
