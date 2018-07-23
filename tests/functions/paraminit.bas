#include "fbcunit.bi"

SUITE( fbc_tests.functions.paraminit )

	#define NULL 0

	#macro hScopeChecks( code )
		sub check1( )
			code
			code
		end sub

		sub check2( )
			scope
				code
				code
			end scope
		end sub

		sub check3( )
			scope
				code
			end scope
			code
		end sub

		sub check4( )
			code
			scope
				code
			end scope
		end sub

		sub check5( )
			code
			scope
				code
			end scope
			code
		end sub

		sub check6( )
			scope
				code
				code
			end scope

			code
			code

			scope
				code
				code
			end scope
		end sub

		TEST( default )
			check1( )
			check2( )
			check3( )
			check4( )
			check5( )
			check6( )
		END_TEST
	#endmacro

	type UDT
		i as integer
	end type

	'' UDT to be returned on stack
	type BigUDT
		i(0 to 64-1) as integer
	end type

	type ClassUDT
		i as integer
		declare constructor( )
		declare constructor( byref as ClassUDT )
		declare destructor( )
	end type

	constructor ClassUDT( )
		i = 123
	end constructor

	constructor ClassUDT( byref rhs as ClassUDT )
		i = rhs.i
	end constructor

	destructor ClassUDT( )
	end destructor

	dim shared as integer cond

	#define PARAM_NS udtByref
	#define PARAM_MODE byref
	#include "paraminit-udt.bi"
	#undef PARAM_MODE
	#undef PARAM_NS

	#define PARAM_NS udtByval
	#define PARAM_MODE byval
	#include "paraminit-udt.bi"
	#undef PARAM_MODE
	#undef PARAM_NS

	#define PARAM_NS intByref
	#define PARAM_MODE byref
	#include "paraminit-int.bi"
	#undef PARAM_MODE
	#undef PARAM_NS

	#define PARAM_NS intByval
	#define PARAM_MODE byval
	#include "paraminit-int.bi"
	#undef PARAM_MODE
	#undef PARAM_NS

	TEST_GROUP( strings.byrefLiteral )
		sub tester( byref s as string = "abc" )
			CU_ASSERT( s = "abc" )
		end sub

		hScopeChecks( tester( ) )
	END_TEST_GROUP

	TEST_GROUP( strings.addrofGlobal )
		dim shared globals as string

		sub tester( byval ps as string ptr = @globals )
			globals = "abc"
			CU_ASSERT( *ps = "abc" )
		end sub

		hScopeChecks( tester( ) )
	END_TEST_GROUP

	TEST_GROUP( strings.stringResult )
		function f( ) as string
			function = "123"
		end function

		sub tester( byref s as string = f( ) )
			CU_ASSERT( s = "123" )
		end sub

		hScopeChecks( tester( ) )
	END_TEST_GROUP

	TEST_GROUP( strings.byrefStringFromIif0 )
		dim shared as integer c = 0

		sub tester( byref s as string = iif( c, "a", "bb" ) )
			CU_ASSERT( s = "bb" )
		end sub

		hScopeChecks( tester( ) )
	END_TEST_GROUP

	TEST_GROUP( strings.byrefStringFromIif1 )
		dim shared as integer c = 1

		sub tester( byref s as string = iif( c, "a", "bb" ) )
			CU_ASSERT( s = "a" )
		end sub

		hScopeChecks( tester( ) )
	END_TEST_GROUP

	TEST_GROUP( strings.addrofZstrLiteral )
		sub tester( byval pz as const zstring ptr = @"z1" )
			CU_ASSERT( *pz = "z1" )
		end sub

		hScopeChecks( tester( ) )
	END_TEST_GROUP

	TEST_GROUP( strings.addrofZstrGlobal )
		dim shared z as zstring * 32 = "z2"

		sub tester( byval pz as zstring ptr = @z )
			CU_ASSERT( *pz = "z2" )
		end sub

		hScopeChecks( tester( ) )
	END_TEST_GROUP

	TEST_GROUP( strings.byrefZstringFromIif0 )
		dim shared as integer c = 0

		sub tester( byref z as zstring = iif( c, "a", "bb" ) )
			CU_ASSERT( z = "bb" )
		end sub

		hScopeChecks( tester( ) )
	END_TEST_GROUP

	TEST_GROUP( strings.byrefZstringFromIif1 )
		dim shared as integer c = 1

		sub tester( byref z as zstring = iif( c, "a", "bb" ) )
			CU_ASSERT( z = "a" )
		end sub

		hScopeChecks( tester( ) )
	END_TEST_GROUP

	TEST_GROUP( strings.addrofWstrLiteral )
		sub tester( byval pw as const wstring ptr = @wstr( "w1" ) )
			CU_ASSERT( *pw = wstr( "w1" ) )
		end sub

		hScopeChecks( tester( ) )
	END_TEST_GROUP

	TEST_GROUP( strings.addrofWstrGlobal )
		dim shared w as wstring * 32 = wstr( "w2" )

		sub tester( byval pw as wstring ptr = @w )
			CU_ASSERT( *pw = "w2" )
		end sub

		hScopeChecks( tester( ) )
	END_TEST_GROUP

	TEST_GROUP( strings.byrefWstringFromIif0 )
		dim shared as integer c = 0

		sub tester( byref w as wstring = iif( c, wstr( "a" ), wstr( "bb" ) ) )
			CU_ASSERT( w = wstr( "bb" ) )
		end sub

		hScopeChecks( tester( ) )
	END_TEST_GROUP

	TEST_GROUP( strings.byrefWstringFromIif1 )
		dim shared as integer c = 1

		sub tester( byref w as wstring = iif( c, wstr( "a" ), wstr( "bb" ) ) )
			CU_ASSERT( w = wstr( "a" ) )
		end sub

		hScopeChecks( tester( ) )
	END_TEST_GROUP

	'' new[] ctorlist
	TEST_GROUP( vectorNewCtorList )
		dim shared as integer calls

		type UDT
			i as integer
			declare constructor( )
		end type

		constructor UDT( )
			i = 123
			calls += 1
		end constructor

		sub tester( byval p as UDT ptr = new UDT[2] )
			calls += 1
			CU_ASSERT( p[0].i = 123 )
			CU_ASSERT( p[1].i = 123 )
			delete[] p
		end sub

		TEST( default )
			CU_ASSERT( calls = 0 )
			tester( )
			CU_ASSERT( calls = 3 )
			tester( )
			CU_ASSERT( calls = 6 )
		END_TEST
	END_TEST_GROUP

END_SUITE
