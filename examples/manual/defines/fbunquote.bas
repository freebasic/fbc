'' examples/manual/defines/fbunquote.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfbunquote
'' --------

#macro m( arg )
	Scope
		Var v1 = arg
		#print TypeOf(v1)
		Print v1
		Var v2 = __FB_UNQUOTE__( arg )
		#print TypeOf(v2)
		Print v2
	End Scope
#endmacro

m("""Hello""")
m("1")

Sleep

/' Compiler output:
STRING
STRING
STRING
INTEGER
'/

/' Output:
"Hello"
Hello
1
 1
'/
	
