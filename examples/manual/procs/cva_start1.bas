'' examples/manual/procs/cva_start1.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCvaStart
'' --------

'' typical usage of iterating through all arguments

Sub proc cdecl(count As Integer, ... )
	Dim args As cva_list
	cva_start( args, count )
	For i As Integer = 1 To count
		Print cva_arg( args, Integer )
	Next
	cva_end( args )
End Sub

proc( 4, 4000, 300, 20, 1 )
