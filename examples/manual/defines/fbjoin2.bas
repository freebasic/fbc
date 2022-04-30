'' examples/manual/defines/fbjoin2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '__FB_JOIN__'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfbjoin
'' --------

#define PREFIX p
#define SUFFIX _T

'' this won't work - arguments not expanded
#define   makename1( x )  PREFIX##x##SUFFIX

'' this will work - can do this in older versions of fbc too
#define join( a, b ) a##b
#define makename2( x ) join( PREFIX, join( x, SUFFIX ) )

'' built in __FB_JOIN__() -- works pretty much like join() above
#define   makename3( x )  __FB_JOIN__( PREFIX, __FB_JOIN__( x, SUFFIX ) )

#macro dump( arg )
	#print #arg
#endmacro

dump( makename1(text) )
dump( makename2(text) )
dump( makename3(text) )

/' Compiler output:
PREFIXtextSUFFIX
ptext_T
ptext_T
'/
	
