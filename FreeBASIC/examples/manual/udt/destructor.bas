'' examples/manual/udt/destructor.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDestructor
'' --------

Type T
  value As ZString * 32
  Declare Constructor ( init_value As String )
  Declare Destructor ()
End Type

Constructor T ( init_value As String )
  value = init_value
  Print "Creating: "; value
End Constructor

Destructor T ()
  Print "Destroying: "; value
End Destructor

Sub MySub
  Dim x As T = ("A.x")
End Sub

Dim x As T = ("main.x")

Scope
  Dim x As T = ("main.scope.x")
End Scope

MySub
