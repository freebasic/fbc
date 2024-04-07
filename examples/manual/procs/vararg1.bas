'' examples/manual/procs/vararg1.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'VA_FIRST'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgVaFirst
'' --------

Function average cdecl(count As Integer, ... ) As Double
	Dim arg As Any Ptr
	Dim sum As Double = 0
	Dim i As Integer
	
	arg = va_first()

	For i = 1 To count
		sum += va_arg(arg, Double)
		arg = va_next(arg, Double)
	Next
	
	Return sum / count
End Function

Print average(4, 3.4,5.0,3.2,4.1)  '' all passed variable arguments must be of type double
Print average(2, 65.2,454.65481)   '' all passed variable arguments must be of type double
Sleep
