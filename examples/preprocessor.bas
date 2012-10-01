''
'' Defines/macros can be used for compile-time text replacement:
''
	#define number 123
	print number

	#define foo( x ) print x, x
	foo( number )

	#macro bar( x )
		for i as integer = 0 to 3
			foo( x )
		next
	#endmacro
	bar( number )

	#define myMin( a, b ) iif( a <= b, a, b )
	#define myMax( a, b ) iif( a >= b, a, b )

	randomize( timer( ) )
	dim as integer x = rnd( ) * 100
	dim as integer y = rnd( ) * 100

	print "min( "; x; ", "; y; " ) ="; myMin( x, y )
	print "max( "; x; ", "; y; " ) ="; myMax( x, y )

''
'' Some common #defines:
''
	#define TRUE (-1)
	#define FALSE 0
	#define NULL cast(any ptr, 0)

''
'' #if provides a way to conditionally compile code:
''

	#if defined( __FB_WIN32__ )
		print "compiled for Windows"
	#elseif defined( __FB_LINUX__ )
		print "compiled for Linux"
	#elseif defined( __FB_DOS__ )
		print "compiled for DOS"
	#endif

	#define ENABLE_FOO
	#ifdef ENABLE_FOO
		print "foo was enabled at compile time!"
	#endif

	#if 1 + 1 = 2
		#print "yes, 1 + 1 = 2"
	#endif

	#if 0
		this text will be skipped, as if it was commented out
	#endif

	#define MY_DEBUG_MODE
	#ifdef MY_DEBUG_MODE
		#define myassert( condition ) _
			if (condition) = 0 then : _
				print "my example error at " & __FILE__ & "(" & __LINE__ & "): " & #condition : _
			end if
	#else
		#define myassert( condition )
	#endif

	myassert( 1 = 1 )
	myassert( 2 = 2 )
	myassert( 1 = 2 )

sleep
