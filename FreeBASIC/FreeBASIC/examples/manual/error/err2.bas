'' examples/manual/error/err2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgErr
'' --------

Dim a As String
Do
Input "Input filename ";a
If a="" Then Exit Do
Open a For Input As #1
Loop Until Err=0
