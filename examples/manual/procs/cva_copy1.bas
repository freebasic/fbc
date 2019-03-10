'' examples/manual/procs/cva_copy1.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCvaCopy
'' --------

'' example of using cva_copy to create
'' a copy of the variable argument list

Sub proc cdecl(count As Integer, ... )
	Dim args1 As cva_list
	Dim args2 As cva_list

	'' first list
	cva_start( args1, count )

	'' create a copy
	cva_copy( args2, args1 )

	For i As Integer = 1 To count
		Print cva_arg( args1, Integer ), cva_arg( args2, Integer )
	Next
	
	'' clean-up
	cva_end( args2 )
	cva_end( args1 )

End Sub

proc( 4, 4000, 300, 20, 1 )
