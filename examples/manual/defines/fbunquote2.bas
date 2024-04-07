'' examples/manual/defines/fbunquote2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '__FB_UNQUOTE__'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfbunquote
'' --------

#define X __FB_QUOTE__( Print "hello" )
#macro Y( arg )
  __FB_UNQUOTE__( arg )
#endmacro

Print X
Y( X )

/' Output:
print "hello"
hello
'/
	
