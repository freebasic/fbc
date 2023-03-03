' TEST_MODE : COMPILE_ONLY_OK

#macro check_Y( symbol )
	#if not defined( symbol )
		#print __fb_quote__( failed(__LINE__): symbol )
		#error
	#endif

	#ifndef symbol
		#print __fb_quote__( failed(__LINE__): symbol )
		#error
	#endif

	#ifdef symbol
	#else
		#print __fb_quote__( failed(__LINE__): symbol )
		#error
	#endif
#endmacro

#macro check_N( symbol )
	#if defined( symbol )
		#print __fb_quote__( failed(__LINE__): symbol )
		#error
	#endif

	#ifdef symbol
		#print __fb_quote__( failed(__LINE__): symbol )
		#error
	#endif

	#ifndef symbol
	#else
		#print __fb_quote__( failed(__LINE__): symbol )
		#error
	#endif
#endmacro

check_N( datafield )
check_N( staticfield )
check_N( proc )
check_N( staticproc )
check_N( prop )
check_Y( constructor )     '' keyword
check_Y( destructor )      '' keyword
check_Y( let )             '' keyword

check_N( T )

'' all of these would cause an error because T is not defined
'' check_N( T.datafield )
'' check_N( T.staticfield )
'' check_N( T.proc )
'' check_N( T.staticproc )
'' check_N( T.prop )
'' check_N( T.constructor )
'' check_N( T.destructor )
'' check_N( T.let )

type T
	check_N( datafield )
	check_N( staticfield )
	check_N( proc )
	check_N( staticproc )
	check_N( prop )
	check_Y( constructor )  '' it's a keyword
	check_Y( destructor )   '' it's a keyword
	check_Y( let )          '' it's a keyword

	check_Y( T )

	'' these will cause error because it is not yet known that T has members
	'' check_N( T.datafield )
	'' check_N( T.staticfield )
	'' check_N( T.proc )
	'' check_N( T.staticproc )
	'' check_N( T.prop )
	'' check_Y( T.constructor )
	'' check_Y( T.destructor )
	'' check_Y( T.let )

	'' errors? because T is not yet fully parsed
	check_N( T.member )
	check_N( T.datafield )
	check_N( T.staticfield )
	check_N( T.proc )
	check_N( T.staticproc )
	check_N( T.prop )
	check_N( T.constructor )
	check_N( T.destructor )
	check_N( T.let )

	datafield as byte
	static staticfield as short
	declare sub proc()
	declare sub staticproc()
	declare property prop() as long
	declare constructor()
	declare destructor()
	declare operator let( byref arg as const T )

	check_Y( datafield )
	check_Y( staticfield )
	check_Y( proc )
	check_Y( staticproc )
	check_Y( prop )
	check_Y( constructor )
	check_Y( destructor )
	check_Y( let )

	check_Y( T )

	check_Y( T.datafield )
	check_Y( T.staticfield )
	check_Y( T.proc )
	check_Y( T.staticproc )
	check_Y( T.prop )
	check_Y( T.constructor )
	check_Y( T.destructor )
	check_Y( T.let )
end type

check_N( datafield )
check_N( staticfield )
check_N( proc )
check_N( staticproc )
check_N( prop )
check_Y( constructor )     '' still a keyword
check_Y( destructor )      '' still a keyword
check_Y( let )             '' still a keyword

check_Y( T )
check_Y( T.datafield )
check_Y( T.staticfield )
check_Y( T.proc )
check_Y( T.staticproc )
check_Y( T.prop )
check_Y( T.constructor )
check_Y( T.destructor )
check_Y( T.let )
