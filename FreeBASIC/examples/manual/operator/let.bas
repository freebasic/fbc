'' examples/manual/operator/let.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpLet
'' --------

Type T
  x As Integer
  y As Integer
  Declare Operator Let( ByRef rhs As T )
End Type

Operator T.let( ByRef rhs As T )
  x = rhs.x
  y = rhs.y
End Operator

Dim a As T = ( 5, 7 )
Dim b As T

'' Do the assignment invoking the LET
'' operator procedure
b = a

Print "a.x = "; a.x
Print "a.y = "; a.y
Print
Print "b.x = "; b.x
Print "b.y = "; b.y
