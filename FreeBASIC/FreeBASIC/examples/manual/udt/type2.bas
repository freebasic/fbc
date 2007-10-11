'' examples/manual/udt/type2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgType
'' --------

Type bar
  Declare Constructor()
  Declare Destructor()
  Declare Property x() As Integer
  Declare Property x(ByVal n As Integer)
  Declare Sub Mul5()
  Declare Function Addr() As Integer Ptr
Private:
  p_x As Integer Ptr
End Type
