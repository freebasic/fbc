#include "fbcu.bi"

namespace fbc_tests.pp.typeof_

#macro clear_func(__type__)
	sub clear_thing overload ( byref t as __type__ )
		#if typeof(t) = "STRING"
			t = ""
		#else
			t = 0
		#endif
	end sub
#endmacro

clear_func(integer)
clear_func(string)

sub test cdecl( )
	dim as integer i = 69
	dim as string s = "R&E 2007"
	dim as integer ptr                             pi
	dim as integer ptr ptr                         ppi
	dim as integer ptr ptr ptr                     pppi
	dim as integer ptr ptr ptr ptr                 ppppi
	dim as integer ptr ptr ptr ptr ptr             pppppi
	dim as integer ptr ptr ptr ptr ptr ptr         ppppppi
	dim as integer ptr ptr ptr ptr ptr ptr ptr     pppppppi
	dim as integer ptr ptr ptr ptr ptr ptr ptr ptr ppppppppi
	dim as const integer ptr                       pci
	dim as integer const ptr                       cpi = 0
	dim as const integer const ptr                 cpci = 0

	clear_thing(i)
	clear_thing(s)

	CU_ASSERT( i = 0 )
	CU_ASSERT( strptr(s) = NULL )

	'' PP typeof()'s result is upper-cased
	#if typeof( s ) = "string"
		CU_FAIL( )
		i = 1
	#else
		CU_PASS( )
		i = 2
	#endif
	CU_ASSERT( i = 2 )

	i = 0
	#if typeof( s ) = "STRING"
		CU_PASS( )
		i = 1
	#else
		CU_FAIL( )
		i = 2
	#endif
	CU_ASSERT( i = 1 )

	#if typeof( i ) = "INTEGER"
		CU_PASS( )
	#else
		CU_FAIL( )
	#endif

	#if typeof( pi ) = "INTEGER PTR"
		CU_PASS( )
	#else
		CU_FAIL( )
	#endif

	#if typeof( ppi ) = "INTEGER PTR PTR"
		CU_PASS( )
	#else
		CU_FAIL( )
	#endif

	#if typeof( pppi ) = "INTEGER PTR PTR PTR"
		CU_PASS( )
	#else
		CU_FAIL( )
	#endif

	#if typeof( ppppi ) = "INTEGER PTR PTR PTR PTR"
		CU_PASS( )
	#else
		CU_FAIL( )
	#endif

	#if typeof( pppppi ) = "INTEGER PTR PTR PTR PTR PTR"
		CU_PASS( )
	#else
		CU_FAIL( )
	#endif

	#if typeof( ppppppi ) = "INTEGER PTR PTR PTR PTR PTR PTR"
		CU_PASS( )
	#else
		CU_FAIL( )
	#endif

	#if typeof( pppppppi ) = "INTEGER PTR PTR PTR PTR PTR PTR PTR"
		CU_PASS( )
	#else
		CU_FAIL( )
	#endif

	#if typeof( ppppppppi ) = "INTEGER PTR PTR PTR PTR PTR PTR PTR PTR"
		CU_PASS( )
	#else
		CU_FAIL( )
	#endif

	#if typeof( pci ) = "CONST INTEGER PTR"
		CU_PASS( )
	#else
		CU_FAIL( )
	#endif

	#if typeof( cpi ) = "INTEGER CONST PTR"
		CU_PASS( )
	#else
		CU_FAIL( )
	#endif

	#if typeof( cpci ) = "CONST INTEGER CONST PTR"
		CU_PASS( )
	#else
		CU_FAIL( )
	#endif

	#if typeof( integer ) = typeof( const integer )
		CU_FAIL( )
	#endif

	#if typeof( integer const ptr ) = typeof( integer ptr )
		CU_FAIL( )
	#endif

	#if typeof( integer const ptr ) = typeof( const integer ptr )
		CU_FAIL( )
	#endif

	#if typeof( integer const ptr ) = typeof( const integer const ptr )
		CU_FAIL( )
	#endif

	#if typeof( integer const ptr ) <> typeof( integer const ptr )
		CU_FAIL( )
	#endif

	#if typeof( sub( ) ) <> typeof( sub( ) )
		CU_FAIL( )
	#endif

	'' sub vs. function
	#if typeof( sub( ) ) = typeof( function( ) as integer )
		CU_FAIL( )
	#endif

	'' Calling convention
	#if typeof( sub cdecl( ) ) = typeof( sub stdcall( ) )
		CU_FAIL( )
	#endif
	#if typeof( sub cdecl( ) ) = typeof( sub pascal( ) )
		CU_FAIL( )
	#endif
	#if typeof( sub pascal( ) ) = typeof( sub stdcall( ) )
		CU_FAIL( )
	#endif

	'' Also compare against the default calling convention
	#if defined( __FB_WIN32__ ) or defined( __FB_CYGWIN__ ) or defined( __FB_XBOX__ )
		#if typeof( sub cdecl( ) ) = typeof( sub( ) )
			CU_FAIL( )
		#endif
	#else
		#if typeof( sub stdcall( ) ) = typeof( sub( ) )
			CU_FAIL( )
		#endif
	#endif

	'' Parameters
	#if typeof( sub( as integer ) ) <> typeof( sub( as integer ) )
		CU_FAIL( )
	#endif
	#if typeof( sub( as byte ) ) = typeof( sub( as short ) )
		CU_FAIL( )
	#endif
	#if typeof( sub( as single ) ) = typeof( sub( as double ) )
		CU_FAIL( )
	#endif
	#if typeof( sub( as integer, as integer ) ) <> typeof( sub( as integer, as integer ) )
		CU_FAIL( )
	#endif
	#if typeof( sub( as integer, as integer ) ) = typeof( sub( as integer ) )
		CU_FAIL( )
	#endif

	'' Parameter modes
	#if typeof( sub( byval as integer ) ) = typeof( sub( byref as integer ) )
		CU_FAIL( )
	#endif
	#if typeof( sub( () as integer ) ) = typeof( sub( byref as integer ) )
		CU_FAIL( )
	#endif
	#if typeof( sub( () as integer ) ) = typeof( sub( byval as integer ) )
		CU_FAIL( )
	#endif
	#if typeof( sub( as integer, byval as integer ) ) = typeof( sub( as integer, byref as integer ) )
		CU_FAIL( )
	#endif
	#if typeof( sub cdecl( as integer, ... ) ) <> typeof( sub cdecl( as integer, ... ) )
		CU_FAIL( )
	#endif
	'' -lang fb defaults to BYVAL, so this should be the same
	#if typeof( sub( as integer ) ) <> typeof( sub( byval as integer ) )
		CU_FAIL( )
	#endif

	'' Result type
	#if typeof( function( ) as short ) = typeof( function( ) as integer )
		CU_FAIL( )
	#endif

	'' Return Byref
	#if typeof( function( ) byref as integer ) = typeof( function( ) as integer )
		CU_FAIL( )
	#endif
	#if typeof( function( ) byref as integer ) <> typeof( function( ) byref as integer )
		CU_FAIL( )
	#endif

	'' Macro expansion of PP typeof()'s argument
	#define myInteger integer
	#if typeof(myInteger) <> typeof(integer)
		CU_FAIL( )
	#endif
	'' myInteger should be expanded instead of being treated as
	'' undeclared identifier. Any undeclared identifiers are implicitly
	'' converted to string literals, so if myInteger wouldn't be expanded,
	'' we'd get typeof("MYINTEGER") which is <> typeof(integer).
	#assert typeof(myInteger) = typeof(integer)

	#define myString string
	#assert typeof(myString) = typeof(string)

	#define nopMacro(x) x
	#assert typeof(nopMacro(byte)) = typeof(byte)
	#assert typeof(nopMacro(longint)) = typeof(longint)
	#assert typeof(nopMacro(integer)) = typeof(integer)
	#assert typeof(nopMacro(double)) = typeof(double)
	#assert typeof(nopMacro(string)) = typeof(string)

	'' Not only the 1st token should be macro expanded; also the following ones.
	#define myPtr ptr
	#assert typeof(myInteger myPtr) = typeof(integer ptr)
	#assert typeof(myInteger myPtr) <> typeof(integer)
	#assert typeof(myInteger myPtr) <> typeof(any ptr)
end sub

private sub ctor( ) constructor
	fbcu.add_suite( "tests/pp/typeof" )
	fbcu.add_test( "typeof() with PP", @test )
end sub

end namespace
