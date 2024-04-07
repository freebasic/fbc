'' examples/manual/procs/cva_copy2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'CVA_COPY'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCvaCopy
'' --------

'' example of using cva_copy to create
'' a copy of the variable argument list
'' and pass it to another procedure

Sub vproc cdecl(count As Integer, ByRef args As Cva_List )

	'' if we don't know that caller made a copy
	'' of args, it is safe to make our own copy
	'' and leave the passed in args untouched

	Dim a As Cva_List
	Cva_Copy( a, args )

	Print "vproc"
	For i As Integer = 1 To count
		Print Cva_Arg( a, Integer )
	Next
	
	'' clean-up
	Cva_End( a )

End Sub

Sub proc cdecl(count As Integer, ... )

	Dim args As Cva_List
	Cva_Start( args, count )

	'' if don't know that the called procedure
	'' will make it's own copy, it is safe to
	'' make a copy here and pass that instead

	Dim tmp As Cva_List
	Cva_Copy( tmp, args )
	vproc( count, tmp )
	Cva_End( tmp )

	'' args is still valid, we can use it
	Print "proc"
	For i As Integer = 1 To count
		Print Cva_Arg( args, Integer )
	Next
	
	'' clean-up
	Cva_End( args )

End Sub

proc( 4, 4000, 300, 20, 1 )
