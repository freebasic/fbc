'' examples/manual/defines/fbargcount.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '__FB_ARG_COUNT__'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfbargcount
'' --------

#macro m( args... )
	Print __FB_ARG_COUNT__( args )
#endmacro

m()
m(a)
m(b,c)
m(,d)
m(,e,)
m(,,,)

Sleep

/' Output:
 0
 1
 2
 2
 3
 4
'/
	
