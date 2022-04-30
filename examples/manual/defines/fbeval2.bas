'' examples/manual/defines/fbeval2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '__FB_EVAL__'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfbeval
'' --------

'   In this example, the three '__FB_EVAL__' are absolutely mandatory in this 'assign()' macro.
'   Even for '__FB_QUOTE__( __FB_EVAL__( expr ) )', because for the case of expr = cos(1/x),
'   'cos(1/x)' must be properly evaluated before be quoted (after the previous 'assign("x", x+1)'),
'   otherwise in that case 'cos(1/x+1)' is taken into account (giving 'cos(2)') instead of 'cos(1/(x+1))' (giving 'cos (1/2)')
'   because the operator precedence is not applied by '__FB_QUOTE__'.

#macro assign( sym, expr )
	__FB_UNQUOTE__( __FB_EVAL__( "#undef " + sym ) )
	__FB_UNQUOTE__( __FB_EVAL__( "#define " + sym + " " + __FB_QUOTE__( __FB_EVAL__( expr ) ) ) )
#endmacro

#define x

assign( "x", 1 )
Print x

assign( "x", x+1 )
Print x

assign( "x", Cos(1/x) )
Print x

assign( "x", "hello" )
Print x

assign( "x", x+x )
Print x

/' Output:
 1
 2
 0.877582...
hello
hellohello
'/
	
