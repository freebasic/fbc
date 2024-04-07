'' examples/manual/datatype/const-ovl.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'CONST (Qualifier)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgConstQualifier
'' --------

'' Const Parameters in an Overloaded Procedure

'' procedure with non-const parameter
Sub foo Overload( ByRef n As Integer )
  Print "called 'foo( byref n as integer )'"
End Sub

'' procedure with const parameter
Sub foo Overload( ByRef n As Const Integer )
  Print "called 'foo( byref n as const integer )'"
End Sub

Dim x As Integer = 1
Dim y As Const Integer = 2

foo( x )
foo( y )

'' OUTPUT:
'' called 'foo( byref n as integer )'
'' called 'foo( byref n as const integer )'
