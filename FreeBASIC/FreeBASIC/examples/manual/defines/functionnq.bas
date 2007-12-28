'' examples/manual/defines/functionnq.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfunctionnq
'' --------


Sub MySub
  Print "Address of " + __FUNCTION__ + " is ";
  Print Hex( @__FUNCTION_NQ__ )
End Sub

MySub
