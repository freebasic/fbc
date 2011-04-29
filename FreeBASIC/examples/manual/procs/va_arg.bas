'' examples/manual/procs/va_arg.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgVaArg
'' --------


' Note that CDECL is used here --> it must be used with an ellipsis argument (...).
Function Avg cdecl (Count As Integer, ... ) As Double
	Dim ARG As Any Ptr 
	Dim SUM As Double = 0
	Dim i As Integer
	
	ARG = va_first()

	For i = 1 To COUNT
	    SUM += va_arg(ARG, Double)
	    ARG = va_next(ARG,Double)
	Next i
	Return SUM/COUNT
End Function

Print AVG (4, 3.4,5.0,3.2,4.1)
Print AVG (2, 65.2,454.65481)

Sleep
