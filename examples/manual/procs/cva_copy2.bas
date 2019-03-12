'' examples/manual/procs/cva_copy2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCvaCopy
'' --------

'' example of using cva_copy to create
'' a copy of the variable argument list
'' and pass it to another procedure

Sub vproc cdecl(count As Integer, ByRef args As cva_list )

	'' if we don't know that caller made a copy
	'' of args, it is safe to make our own copy
	'' and leave the passed in args untouched

	Dim a As cva_list
	cva_copy( a, args )

	Print "vproc"
	For i As Integer = 1 To count
		Print cva_arg( a, Integer )
	Next
	
	'' clean-up
	cva_end( a )

End Sub

Sub proc cdecl(count As Integer, ... )

	Dim args As cva_list
	cva_start( args, count )

	'' if don't know that the called procedure
	'' will make it's own copy, it is safe to
	'' make a copy here and pass that instead

	Dim tmp As cva_list
	cva_copy( tmp, args )
	vproc( count, tmp )
	cva_end( tmp )

	'' args is still valid, we can use it
	Print "proc"
	For i As Integer = 1 To count
		Print cva_arg( args, Integer )
	Next
	
	'' clean-up
	cva_end( args )

End Sub

proc( 4, 4000, 300, 20, 1 )
