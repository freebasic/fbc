'' examples/manual/defines/functionnq.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '__FUNCTION_NQ__'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfunctionnq
'' --------


Sub MySub
  Print "Address of " + __FUNCTION__ + " is ";
  Print Hex( @__FUNCTION_NQ__ )
End Sub

MySub
