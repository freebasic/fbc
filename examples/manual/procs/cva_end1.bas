'' examples/manual/procs/cva_end1.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'CVA_END'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCvaEnd
'' --------

Sub proc cdecl(count As Integer, ... )
	Dim args As Cva_List

	Cva_Start( args, count )

	For i As Integer = 1 To count
		Print Cva_Arg( args, Integer )
	Next
   
	Cva_End( args )
End Sub

proc( 4, 4000, 300, 20, 1 )
