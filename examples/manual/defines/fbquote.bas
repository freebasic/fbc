'' examples/manual/defines/fbquote.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '__FB_QUOTE__'
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
	
