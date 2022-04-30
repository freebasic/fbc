'' examples/manual/udt/private.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'PRIVATE: (Access Control)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgVisPrivate
'' --------

Type testing
  number As Integer
  Private:
	nome As String
  Declare Sub setNome( ByRef newnome As String )
End Type

Sub testing.setnome( ByRef newnome As String )
  '' This is OK. We're inside a member function for the type
  this.nome = newnome
End Sub

Dim As testing myVariable

'' This is OK, number is public
myVariable.number = 69

'' this would generate a compile error 
'' - nome is private and we're trying to access it outside any of this TYPE's member functions 
'' myVariable.nome = "FreeBASIC"
