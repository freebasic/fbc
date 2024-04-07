'' examples/manual/datatype/const-var.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'CONST (Qualifier)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgConstQualifier
'' --------

'' Const Variables

'' procedure taking a const parameter
Sub proc1( ByRef x As Const Integer )

  '' can't change x because it is const
  '' x = 10 '' compile error

  '' but we can use it in expressions and
  '' assign it to other variables
  Dim y As Integer
  y = x
  y = y * x + x

End Sub

'' procedure taking a non-const parameter
Sub proc2( ByRef x As Integer )
  '' we can change the value
  x = 10
End Sub

'' declare a non-const and const variable
Dim a As Integer
Dim b As Const Integer = 5

'' proc1() will accept a non-const or const
'' argument because proc1() promises not to
'' change the variable passed to it.
proc1( a )
proc1( b )

'' proc2() will accept a non-const argument
proc2( a )

'' but not a const argument because proc2()
'' might change the variable's data and we
'' promised that 'b' would not change.
'' proc2( b ) '' compile error
