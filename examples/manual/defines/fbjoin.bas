'' examples/manual/defines/fbjoin.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '__FB_JOIN__'
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
	
