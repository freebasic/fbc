'' examples/manual/udt/const-proc.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'CONST (Member)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgConstMember
'' --------

'' Const Member Procedures

Type foo
  x As Integer
  c As Const Integer = 0
  Declare Const Sub Inspect1()
  Declare Const Sub Inspect2()
  Declare Sub Mutate1()
  Declare Sub Mutate2()
End Type

''
Sub foo.Mutate1()
  '' we can change non-const data fields
  x = 1

  '' but we still can't change const data
  '' fields, they are promised not to change
  '' c = 1 '' Compile error

End Sub

''
Sub foo.Mutate2()
  '' we can call const members
  Inspect1()

  '' and non-const members
  Mutate1()

End Sub

''
Sub foo.Inspect1()
  '' can use data members
  Dim y As Integer
  y = c + x

  '' but not change them because Inspect1()
  '' is const and promises not to change foo
  '' x = 10 '' Compile error

End Sub

''
Sub foo.Inspect2()
  '' we can call const members
  Inspect1()

  '' but not non-const members
  '' Mutate1() '' Compile error

End Sub
