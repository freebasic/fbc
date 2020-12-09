'' examples/manual/defines/fbjoin.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfbjoin
'' --------

#macro m ( arg1, arg2 )
	#print arg1##arg2
	#print __FB_JOIN__( arg1, arg2 )
#endmacro

m(Free, BASIC)

/' Compiler output:
FreeBASIC
FreeBASIC
'/
	
