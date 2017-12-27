'' examples/manual/array/ubound4.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgUbound
'' --------

'' determining whether an array is empty
Dim array() As Integer

Print "lbound: "; LBound( array ), "ubound: "; UBound( array )  '' 1 and 0

If LBound( array ) > UBound( array ) Then
	Print "array is empty"
Else
	Print "array is not empty"
End If
