'' examples/manual/procs/cva_copy1.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'CVA_COPY'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCvaCopy
'' --------

'' example of using cva_copy to create
'' a copy of the variable argument list

Sub proc cdecl(count As Integer, ... )
	Dim args1 As Cva_List
	Dim args2 As Cva_List

	'' first list
	Cva_Start( args1, count )

	'' create a copy
	Cva_Copy( args2, args1 )

	For i As Integer = 1 To count
		Print Cva_Arg( args1, Integer ), Cva_Arg( args2, Integer )
	Next
	
	'' clean-up
	Cva_End( args2 )
	Cva_End( args1 )

End Sub

proc( 4, 4000, 300, 20, 1 )
