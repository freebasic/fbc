'' examples/manual/defines/fbquote.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfbquote
'' --------

#macro m( arg )
	Scope
		Dim s1 As String = #arg
		Print s1
		Dim s2 As String = __FB_QUOTE__( arg )
		Print s2
	End Scope
#endmacro

m(Hello)
Print
m("Hello")

Sleep

/' Output:
Hello
Hello

"Hello"
"Hello"
'/
	
