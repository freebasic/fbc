'' examples/manual/procs/cva_list1.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCvaList
'' --------

Function average cdecl(count As Integer, ... ) As Double

	Dim sum As Double = 0
	Dim i As Integer

	Dim args As cva_list '' argument list object
	cva_start( args, count ) '' constructor
	For i = 1 To count
		sum += cva_arg(args, Double)
	Next
	cva_end( args ) '' destructor
	
	Return sum / count
End Function

Print average(4, 3.4 ,5.0, 3.2, 4.1) '' all passed variable arguments must be of type double
Print average(2, 65.2, 454.65481)    '' all passed variable arguments must be of type double
