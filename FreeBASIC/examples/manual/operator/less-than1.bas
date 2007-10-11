'' examples/manual/operator/less-than1.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpLessThan
'' --------

Const size As Integer = 4
Dim array(size - 1) As Integer = { 1, 2, 3, 4 }

Dim index As Integer = 0
While (index < size)
   Print array(index)
   index += 1
Wend
