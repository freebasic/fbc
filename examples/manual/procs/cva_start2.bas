'' examples/manual/procs/cva_start2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'CVA_START'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCvaStart
'' --------

'' example of using cva_start to get the first argument
'' then restarting to get all the arguments

Sub proc cdecl(count As Integer, ... )
	Dim args As Cva_List

	'' get the first argument only
	Cva_Start( args, count )
	Print Cva_Arg( args, Integer )
	Cva_End( args )

	'' restart and get all the arguments
	Cva_Start( args, count )
	For i As Integer = 1 To count
		Print Cva_Arg( args, Integer )
	Next
	Cva_End( args )

End Sub

proc( 4, 4000, 300, 20, 1 )
