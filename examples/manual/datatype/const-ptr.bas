'' examples/manual/datatype/const-ptr.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'CONST (Qualifier)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgConstQualifier
'' --------

'' Const Pointers

'' an integer
Dim x As Integer = 1
Dim y As Integer = 2
Dim z As Integer = 3

'' To check that the compiler generates errors
'' when attempting to reassign const variables,
'' uncomment the assignments below.

''
Scope
  '' a pointer to an integer
  Dim p As Integer Ptr = @x

  p = @y       /' OK - pointer can be changed '/
  *p = z       /' OK - data can be changed '/

End Scope

''
Scope
  '' a pointer to a constant integer
  Dim p As Const Integer Ptr = @x

  p = @y       /' OK - pointer can be changed '/
  '' *p = z    /' Error - data is const '/

End Scope

''
Scope
  '' a constant pointer to an integer
  Dim p As Integer Const Ptr = @x

  '' p = @y    /' Error - pointer is const '/
  *p = z       /' OK - data can be changed '/

End Scope

''
Scope
  '' a constant pointer to a constant integer
  Dim p As Const Integer Const Ptr = @x

  '' p = @y    /' Error - pointer is const '/
  '' *p = z    /' Error - data is const '/

End Scope
