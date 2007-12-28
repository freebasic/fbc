'' examples/manual/console/spc.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgSpc
'' --------

Dim As String A, B, N, M

A = "Jane"
B = "DOE"
N = "Bob"
M = "Smith"

Print "FIRST NAME"; Spc(25); "LAST NAME"
Print "----------"; Spc(25); "----------"
Print A; Spc(35-Len(A)); B
Print N; Spc(35-Len(N)); M
