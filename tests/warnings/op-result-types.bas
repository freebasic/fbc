dim as byte b
dim as ubyte ub
dim as short sh
dim as ushort ush
dim as integer i
dim as uinteger ui
dim as long l
dim as ulong ul
dim as longint ll
dim as ulongint ull

dim as single f
dim as double d

type UDT
	i as integer
end type

dim as integer ptr pi
dim as integer ptr ptr ppi
dim as UDT ptr pudt

enum enum1
	enum1a = 1
end enum

enum enum2
	enum2a = 1
end enum

#print
#print "----------------------------------------------------------------------"
#print "integers/floats:"
#print "----------------------------------------------------------------------"
#print

#macro testBops( A, B )
	#print
	#print math ops (A, B):
	#print

	#print A + B = max =
	#print typeof( A + B )

	#print A - B = max =
	#print typeof( A - B )

	#print A * B = max =
	#print typeof( A * B )

	#print A / B = float =
	#print typeof( A / B )

	#print A ^ B = float =
	#print typeof( A ^ B )

	#print A \ B = non-float =
	#print typeof( A \ B )

	#print A mod B = non-float =
	#print typeof( A mod B )

	#print
	#print bitops (A, B):
	#print

	#print A shl B = non-float =
	#print typeof( A shl B )

	#print A shr B = non-float =
	#print typeof( A shr B )

	#print A and B = non-float =
	#print typeof( A and B )

	#print A or B = non-float =
	#print typeof( A or B )

	#print A xor B = non-float =
	#print typeof( A xor B )

	#print A eqv B = non-float =
	#print typeof( A eqv B )

	#print A imp B = non-float =
	#print typeof( A imp B )

	#print
	#print relational ops (A, B):
	#print
	#print A = B = integer =
	#print typeof( A = B )

	#print A > B = integer =
	#print typeof( A > B )

	#print A < B = integer =
	#print typeof( A < B )

	#print A <> B = integer =
	#print typeof( A <> B )

	#print A <= B = integer =
	#print typeof( A <= B )

	#print A >= B = integer =
	#print typeof( A >= B )

	#print A andalso B = integer =
	#print typeof( A andalso B )

	#print A orelse B = integer =
	#print typeof( A orelse B )
#endmacro

#macro testAgainstInt( X )
	#print
	#print ----- X -----------------------------------------------------
	#print
	testBops( X, b   )
	testBops( X, ub  )
	testBops( X, sh  )
	testBops( X, ush )
	testBops( X, i   )
	testBops( X, ui  )
	testBops( X, l   )
	testBops( X, ul  )
	testBops( X, ll  )
	testBops( X, ull )
	testBops( X, enum1a )

	testBops( b  , X )
	testBops( ub , X )
	testBops( sh , X )
	testBops( ush, X )
	testBops( i  , X )
	testBops( ui , X )
	testBops( l  , X )
	testBops( ul , X )
	testBops( ll , X )
	testBops( ull, X )
	testBops( enum1a, X )
#endmacro

#macro testAgainstIntAndFloat( X )
	testAgainstInt( X )

	testBops( X, f )
	testBops( X, d )

	testBops( f, X )
	testBops( d, X )
#endmacro

testAgainstIntAndFloat( b   )
testAgainstIntAndFloat( ub  )
testAgainstIntAndFloat( sh  )
testAgainstIntAndFloat( ush )
testAgainstIntAndFloat( i   )
testAgainstIntAndFloat( ui  )
testAgainstIntAndFloat( l   )
testAgainstIntAndFloat( ul  )
testAgainstIntAndFloat( ll  )
testAgainstIntAndFloat( ull )
testAgainstIntAndFloat( f   )
testAgainstIntAndFloat( d   )

#print
#print "----------------------------------------------------------------------"
#print "enums:"
#print "----------------------------------------------------------------------"
#print

testAgainstInt( enum1a )
#print
#print "enum1 + enum2 ="
#print typeof( enum1a + enum2a )

#print
#print "----------------------------------------------------------------------"
#print "pointers:"
#print "----------------------------------------------------------------------"
#print

'' Pointers: only allowed with +, -, and relational bops
'' pointer + float or float + pointer is disallowed,
'' same for pointer + pointer.

#macro testRelationalBops( A, B )
	#print
	#print relational (A, B):
	#print
	#print A = B = integer =
	#print typeof( A = B )

	#print A > B = integer =
	#print typeof( A > B )

	#print A < B = integer =
	#print typeof( A < B )

	#print A <> B = integer =
	#print typeof( A <> B )

	#print A <= B = integer =
	#print typeof( A <= B )

	#print A >= B = integer =
	#print typeof( A >= B )

	#print A andalso B = integer =
	#print typeof( A andalso B )

	#print A orelse B = integer =
	#print typeof( A orelse B )
#endmacro

#macro testPtr( A, B )
	#print
	#print ptr ops (A, B):
	#print

	#print A + B = ptr =
	#print typeof( A + B )

	#print B + A = ptr =
	#print typeof( B + A )

	#print A - B = ptr =
	#print typeof( A - B )

	testRelationalBops( A, B )
	testRelationalBops( B, A )
#endmacro

'testPtr( pi, b   )
'testPtr( pi, ub  )
'testPtr( pi, sh  )
'testPtr( pi, ush )
testPtr( pi, i   )
testPtr( pi, ui  )
'testPtr( pi, l   )
'testPtr( pi, ul  )
'testPtr( pi, ll  )
'testPtr( pi, ull )
testPtr( pi, enum1a )

'testPtr( ppi, b   )
'testPtr( ppi, ub  )
'testPtr( ppi, sh  )
'testPtr( ppi, ush )
testPtr( ppi, i   )
testPtr( ppi, ui  )
'testPtr( ppi, l   )
'testPtr( ppi, ul  )
'testPtr( ppi, ll  )
'testPtr( ppi, ull )
testPtr( ppi, enum1a )

'testPtr( pudt, b   )
'testPtr( pudt, ub  )
'testPtr( pudt, sh  )
'testPtr( pudt, ush )
testPtr( pudt, i   )
testPtr( pudt, ui  )
'testPtr( pudt, l   )
'testPtr( pudt, ul  )
'testPtr( pudt, ll  )
'testPtr( pudt, ull )
testPtr( pudt, enum1a )

#print
#print "UOPs"

#macro testUops( x )
	#print "not:"
	#print typeof(   not (x)   )
	#print "negation:"
	#print typeof(      -(x)   )
	#print "abs:"
	#print typeof(  abs( (x) ) )
	#print "sgn:"
	#print typeof(  sgn( (x) ) )
	#print "sin:"
	#print typeof(  sin( (x) ) )
	#print "asin:"
	#print typeof( asin( (x) ) )
	#print "cos:"
	#print typeof(  cos( (x) ) )
	#print "acos:"
	#print typeof( acos( (x) ) )
	#print "tan:"
	#print typeof(  tan( (x) ) )
	#print "atn:"
	#print typeof(  atn( (x) ) )
	#print "sqr:"
	#print typeof(  sqr( (x) ) )
	#print "log:"
	#print typeof(  log( (x) ) )
	#print "exp:"
	#print typeof(  exp( (x) ) )
	#print "int:"
	#print typeof(  int( (x) ) )
	#print "fix:"
	#print typeof(  fix( (x) ) )
	#print "frac:"
	#print typeof( frac( (x) ) )
#endmacro

#print
#print "cbyte(0):"
testUops( cbyte( 0 ) )

#print
#print "b:"
testUops( b )

#print
#print "cubyte(0):"
testUops( cubyte( 0 ) )

#print
#print "ub:"
testUops( ub )

#print
#print "cshort(0):"
testUops( cshort( 0 ) )

#print
#print "sh:"
testUops( sh )

#print
#print "cushort(0):"
testUops( cushort( 0 ) )

#print
#print "ush:"
testUops( ush )

#print
#print "0l:"
testUops( 0l )

#print
#print "l:"
testUops( l )

#print
#print "0ul:"
testUops( 0ul )

#print
#print "ul:"
testUops( ul )

#print
#print "0ll:"
testUops( 0ll )

#print
#print "ll:"
testUops( ll )

#print
#print "0ull:"
testUops( 0ull )

#print
#print "ull:"
testUops( ull )

#print
#print "0:"
testUops( 0 )

#print
#print "i:"
testUops( i )

#print
#print "0u:"
testUops( 0u )

#print
#print "ui:"
testUops( ui )

#print
#print "0.0f:"
testUops( 0.0f )

#print
#print "f:"
testUops( f )

#print
#print "0.0d:"
testUops( 0.0d )

#print
#print "d:"
testUops( d )
