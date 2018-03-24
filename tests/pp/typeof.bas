#include "fbcunit.bi"

#define NULL 0

SUITE( fbc_tests.pp.typeof_ )

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

	'' typeof() with PP
	TEST( test_typeof )
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
		#assert typeof( s ) <> "string"

		#assert typeof( s ) = "STRING"
		#assert typeof( i ) = "INTEGER"
		#assert typeof( pi ) = "INTEGER PTR"
		#assert typeof( ppi ) = "INTEGER PTR PTR"
		#assert typeof( pppi ) = "INTEGER PTR PTR PTR"
		#assert typeof( ppppi ) = "INTEGER PTR PTR PTR PTR"
		#assert typeof( pppppi ) = "INTEGER PTR PTR PTR PTR PTR"
		#assert typeof( ppppppi ) = "INTEGER PTR PTR PTR PTR PTR PTR"
		#assert typeof( pppppppi ) = "INTEGER PTR PTR PTR PTR PTR PTR PTR"
		#assert typeof( ppppppppi ) = "INTEGER PTR PTR PTR PTR PTR PTR PTR PTR"
		#assert typeof( pci ) = "CONST INTEGER PTR"
		#assert typeof( cpi ) = "INTEGER CONST PTR"
		#assert typeof( cpci ) = "CONST INTEGER CONST PTR"

		#assert typeof( integer ) <> typeof( const integer )
		#assert typeof( integer const ptr ) <> typeof( integer ptr )
		#assert typeof( integer const ptr ) <> typeof( const integer ptr )
		#assert typeof( integer const ptr ) <> typeof( const integer const ptr )
		#assert typeof( integer const ptr ) = typeof( integer const ptr )

		#assert typeof( sub( ) ) = typeof( sub( ) )

		'' sub vs. function
		#assert typeof( sub( ) ) <> typeof( function( ) as integer )

		'' Calling convention
		#assert typeof( sub cdecl( ) ) <> typeof( sub stdcall( ) )
		#assert typeof( sub cdecl( ) ) <> typeof( sub pascal( ) )
		#assert typeof( sub pascal( ) ) <> typeof( sub stdcall( ) )

		'' Also compare against the default calling convention
		#if defined( __FB_WIN32__ ) or defined( __FB_CYGWIN__ ) or defined( __FB_XBOX__ )
			#assert typeof( sub cdecl( ) ) <> typeof( sub( ) )
			#assert typeof( sub stdcall( ) ) = typeof( sub( ) )
		#else
			#assert typeof( sub cdecl( ) ) = typeof( sub( ) )
			#assert typeof( sub stdcall( ) ) <> typeof( sub( ) )
		#endif

		'' Parameters
		#assert typeof( sub( as integer ) ) = typeof( sub( as integer ) )
		#assert typeof( sub( as byte ) ) <> typeof( sub( as short ) )
		#assert typeof( sub( as single ) ) <> typeof( sub( as double ) )
		#assert typeof( sub( as integer, as integer ) ) = typeof( sub( as integer, as integer ) )
		#assert typeof( sub( as integer, as integer ) ) <> typeof( sub( as integer ) )

		'' Parameter modes
		#assert typeof( sub( byval as integer ) ) <> typeof( sub( byref as integer ) )
		#assert typeof( sub( () as integer ) ) <> typeof( sub( byref as integer ) )
		#assert typeof( sub( () as integer ) ) <> typeof( sub( byval as integer ) )
		#assert typeof( sub( as integer, byval as integer ) ) <> typeof( sub( as integer, byref as integer ) )
		#assert typeof( sub cdecl( as integer, ... ) ) = typeof( sub cdecl( as integer, ... ) )
		'' -lang fb defaults to BYVAL, so this should be the same
		#assert typeof( sub( as integer ) ) = typeof( sub( byval as integer ) )

		'' Result type
		#assert typeof( function( ) as short ) <> typeof( function( ) as integer )

		'' Return Byref
		#assert typeof( function( ) byref as integer ) <> typeof( function( ) as integer )
		#assert typeof( function( ) byref as integer ) = typeof( function( ) byref as integer )

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

		'' typeof() should do macro expansion when skipping its closing ')'
		#define isInteger = typeof(integer)
		#assert typeof(integer) isInteger

		#define isntInteger <> typeof(integer)
		#if typeof(integer) isntInteger
			CU_FAIL( )
		#endif
	END_TEST

	TEST_GROUP( namespaces )
		namespace a
			type T
				i as integer
			end type
		end namespace

		namespace b
			type T
				s as single
			end type
		end namespace

		'' The namespace prefix should be encoded in the typeof() result,
		'' to allow the two T's to be differentiated
		#assert typeof(a.T) = "TESTS.FBC_TESTS.PP.TYPEOF_.NAMESPACES.A.T"
		#assert typeof(b.T) = "TESTS.FBC_TESTS.PP.TYPEOF_.NAMESPACES.B.T"
		#assert typeof(a.T) <> typeof(b.T)

		TEST( default )
			scope
				using a
				#assert typeof(T) = typeof(a.T)
				#assert typeof(T) <> typeof(b.T)
			end scope

			scope
				using b
				#assert typeof(T) <> typeof(a.T)
				#assert typeof(T) = typeof(b.T)
			end scope
		END_TEST
	END_TEST_GROUP

END_SUITE
