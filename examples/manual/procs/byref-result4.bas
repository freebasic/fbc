'' examples/manual/procs/byref-result4.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgByrefFunction
'' --------

Function min( ByRef I As Integer , ByRef J As Integer ) ByRef As Integer
	'' The smallest integer will be returned by reference, no copy will be created.
	If I < J Then
		Return I
	Else
		Return J
	End If
End Function

Dim As Integer A = 13, B = 7
Print A, B
Print min( A , B )
min( A , B ) = 0
Print A, B
