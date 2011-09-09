'' examples/manual/udt/public.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgVisPublic
'' --------

Type testing
  Private:
	nome As String
  Public:
	number As Integer
  Declare Sub setNome( ByRef newnome As String )
End Type

Sub testing.setnome( ByRef newnome As String )
  this.nome = newnome 
End Sub

Dim As testing myVariable

'' We can access these members anywhere since
'' they're public
myVariable.number = 69 ''
myVariable.setNome( "FreeBASIC" )

