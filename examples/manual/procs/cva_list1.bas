'' examples/manual/procs/cva_list1.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'CVA_LIST'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCvaList
'' --------

Function average cdecl(count As Integer, ... ) As Double

	Dim sum As Double = 0
	Dim i As Integer

	Dim args As Cva_List '' argument list object
	Cva_Start( args, count ) '' constructor
	For i = 1 To count
		sum += Cva_Arg(args, Double)
	Next
	Cva_End( args ) '' destructor
	
	Return sum / count
End Function

Print average(4, 3.4 ,5.0, 3.2, 4.1) '' all passed variable arguments must be of type double
Print average(2, 65.2, 454.65481)    '' all passed variable arguments must be of type double
