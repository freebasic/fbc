'' examples/manual/defines/fbquote2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '__FB_QUOTE__'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfbquote
'' --------

#macro m( arg1, arg2 )
	Scope
		'Dim s0 As String = #arg1##arg2  ' does not work because arg1##arg2 is not developped before applying #
		Dim s1 As String = #arg1###arg2  ' workaround because #arg => $"arg" and not only "arg"
										 '    (otherwise the result would be "arg1""arg2" => "arg1"arg2")
		Print s1
		Dim s2 As String = __FB_QUOTE__( arg1##arg2 )
		Print s2
	End Scope
#endmacro

m(Free, BASIC)

Sleep

/' Output:
FreeBASIC
FreeBASIC
'/
	
