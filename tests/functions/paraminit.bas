#include "fbcu.bi"

namespace fbc_tests.functions.paraminit

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

	private sub test cdecl( )
		check1( )
		check2( )
		check3( )
		check4( )
		check5( )
		check6( )
	end sub
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

namespace udtByref
	#define PARAM_MODE byref
	#include "paraminit-udt.bi"
	#undef PARAM_MODE
end namespace

namespace udtByval
	#define PARAM_MODE byval
	#include "paraminit-udt.bi"
	#undef PARAM_MODE
end namespace

namespace intByref
	#define PARAM_MODE byref
	#include "paraminit-int.bi"
	#undef PARAM_MODE
end namespace

namespace intByval
	#define PARAM_MODE byval
	#include "paraminit-int.bi"
	#undef PARAM_MODE
end namespace

namespace strings
	namespace byrefLiteral
		sub tester( byref s as string = "abc" )
			CU_ASSERT( s = "abc" )
		end sub

		hScopeChecks( tester( ) )
	end namespace

	namespace addrofGlobal
		dim shared globals as string

		sub tester( byval ps as string ptr = @globals )
			globals = "abc"
			CU_ASSERT( *ps = "abc" )
		end sub

		hScopeChecks( tester( ) )
	end namespace

	namespace stringResult
		function f( ) as string
			function = "123"
		end function

		sub tester( byref s as string = f( ) )
			CU_ASSERT( s = "123" )
		end sub

		hScopeChecks( tester( ) )
	end namespace

	namespace byrefStringFromIif0
		dim shared as integer c = 0

		sub tester( byref s as string = iif( c, "a", "bb" ) )
			CU_ASSERT( s = "bb" )
		end sub

		hScopeChecks( tester( ) )
	end namespace

	namespace byrefStringFromIif1
		dim shared as integer c = 1

		sub tester( byref s as string = iif( c, "a", "bb" ) )
			CU_ASSERT( s = "a" )
		end sub

		hScopeChecks( tester( ) )
	end namespace

	namespace addrofZstrLiteral
		sub tester( byval pz as const zstring ptr = @"z1" )
			CU_ASSERT( *pz = "z1" )
		end sub

		hScopeChecks( tester( ) )
	end namespace

	namespace addrofZstrGlobal
		dim shared z as zstring * 32 = "z2"

		sub tester( byval pz as zstring ptr = @z )
			CU_ASSERT( *pz = "z2" )
		end sub

		hScopeChecks( tester( ) )
	end namespace

	namespace byrefZstringFromIif0
		dim shared as integer c = 0

		sub tester( byref z as zstring = iif( c, "a", "bb" ) )
			CU_ASSERT( z = "bb" )
		end sub

		hScopeChecks( tester( ) )
	end namespace

	namespace byrefZstringFromIif1
		dim shared as integer c = 1

		sub tester( byref z as zstring = iif( c, "a", "bb" ) )
			CU_ASSERT( z = "a" )
		end sub

		hScopeChecks( tester( ) )
	end namespace

	namespace addrofWstrLiteral
		sub tester( byval pw as const wstring ptr = @wstr( "w1" ) )
			CU_ASSERT( *pw = wstr( "w1" ) )
		end sub

		hScopeChecks( tester( ) )
	end namespace

	namespace addrofWstrGlobal
		dim shared w as wstring * 32 = wstr( "w2" )

		sub tester( byval pw as wstring ptr = @w )
			CU_ASSERT( *pw = "w2" )
		end sub

		hScopeChecks( tester( ) )
	end namespace

	namespace byrefWstringFromIif0
		dim shared as integer c = 0

		sub tester( byref w as wstring = iif( c, wstr( "a" ), wstr( "bb" ) ) )
			CU_ASSERT( w = wstr( "bb" ) )
		end sub

		hScopeChecks( tester( ) )
	end namespace

	namespace byrefWstringFromIif1
		dim shared as integer c = 1

		sub tester( byref w as wstring = iif( c, wstr( "a" ), wstr( "bb" ) ) )
			CU_ASSERT( w = wstr( "a" ) )
		end sub

		hScopeChecks( tester( ) )
	end namespace
end namespace

namespace vectorNewCtorList
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

	sub test cdecl( )
		CU_ASSERT( calls = 0 )
		tester( )
		CU_ASSERT( calls = 3 )
		tester( )
		CU_ASSERT( calls = 6 )
	end sub
end namespace

private sub ctor( ) constructor
	fbcu.add_suite( "fbc_tests.functions.paraminit" )

	fbcu.add_test( "101", @udtByref.anon                         .test )
	fbcu.add_test( "102", @udtByref.global                       .test )
	fbcu.add_test( "103", @udtByref.addrofGlobal                 .test )
	fbcu.add_test( "104", @udtByref.callResultUdt                .test )
	fbcu.add_test( "105", @udtByref.callArgIif                   .test )
	fbcu.add_test( "106", @udtByref.callArgByrefConstant         .test )
	fbcu.add_test( "107", @udtByref.callArgByvalNonTrivialUDT    .test )
	fbcu.add_test( "108", @udtByref.callArgBydescStatic          .test )
	fbcu.add_test( "109", @udtByref.callArgBydescField           .test )
	fbcu.add_test( "110", @udtByref.callArgStringLiteral         .test )
	fbcu.add_test( "111", @udtByref.callArgIntResultInRegsToByref.test )
	fbcu.add_test( "112", @udtByref.callArgUdtResultInRegsToByref.test )
	fbcu.add_test( "113", @udtByref.ptrchk                       .test )
	fbcu.add_test( "114", @udtByref.boundchk                     .test )
	fbcu.add_test( "115", @udtByref.ctors1                       .test )
	fbcu.add_test( "116", @udtByref.ctors2                       .test )
	fbcu.add_test( "119", @udtByref.ctors5                       .test )
	fbcu.add_test( "120", @udtByref.ctorTempArrayDesc            .test )
	fbcu.add_test( "121", @udtByref.vectorNewCtorList            .test )
	fbcu.add_test( "122", @udtByref.iif_                         .test )
	fbcu.add_test( "123", @udtByref.iifAnon                      .test )

	fbcu.add_test( "201", @udtByval.anon                         .test )
	fbcu.add_test( "202", @udtByval.global                       .test )
	fbcu.add_test( "203", @udtByval.addrofGlobal                 .test )
	fbcu.add_test( "204", @udtByval.callResultUdt                .test )
	fbcu.add_test( "205", @udtByval.callArgIif                   .test )
	fbcu.add_test( "206", @udtByval.callArgByrefConstant         .test )
	fbcu.add_test( "207", @udtByval.callArgByvalNonTrivialUDT    .test )
	fbcu.add_test( "208", @udtByval.callArgBydescStatic          .test )
	fbcu.add_test( "209", @udtByval.callArgBydescField           .test )
	fbcu.add_test( "210", @udtByval.callArgStringLiteral         .test )
	fbcu.add_test( "211", @udtByval.callArgIntResultInRegsToByref.test )
	fbcu.add_test( "212", @udtByval.callArgUdtResultInRegsToByref.test )
	fbcu.add_test( "213", @udtByval.ptrchk                       .test )
	fbcu.add_test( "214", @udtByval.boundchk                     .test )
	fbcu.add_test( "215", @udtByval.ctors1                       .test )
	fbcu.add_test( "216", @udtByval.ctors2                       .test )
	fbcu.add_test( "219", @udtByval.ctors5                       .test )
	fbcu.add_test( "220", @udtByval.ctorTempArrayDesc            .test )
	fbcu.add_test( "221", @udtByval.vectorNewCtorList            .test )
	fbcu.add_test( "222", @udtByval.iif_                         .test )
	fbcu.add_test( "223", @udtByval.iifAnon                      .test )

	fbcu.add_test( "301", @intByref.constant                     .test )
	fbcu.add_test( "302", @intByref.global                       .test )
	fbcu.add_test( "303", @intByref.iif_                         .test )
	fbcu.add_test( "304", @intByref.intResult                    .test )
	fbcu.add_test( "305", @intByref.addrofGlobal                 .test )
	fbcu.add_test( "306", @intByref.callArgBigResultUdtToByref   .test )
	fbcu.add_test( "307", @intByref.callArgBigResultUdtToByval   .test )
	fbcu.add_test( "308", @intByref.callArgByvalNonTrivialUDT    .test )
	fbcu.add_test( "309", @intByref.callArgBydescStatic          .test )
	fbcu.add_test( "310", @intByref.callArgBydescField           .test )
	fbcu.add_test( "311", @intByref.callArgStringLiteral         .test )
	fbcu.add_test( "312", @intByref.callArgIntResultInRegsToByref.test )
	fbcu.add_test( "313", @intByref.callArgUdtResultInRegsToByref.test )
	fbcu.add_test( "314", @intByref.ptrchk                       .test )
	fbcu.add_test( "315", @intByref.boundchk                     .test )

	fbcu.add_test( "401", @intByval.constant                     .test )
	fbcu.add_test( "402", @intByval.global                       .test )
	fbcu.add_test( "403", @intByval.iif_                         .test )
	fbcu.add_test( "404", @intByval.intResult                    .test )
	fbcu.add_test( "405", @intByval.addrofGlobal                 .test )
	fbcu.add_test( "406", @intByval.callArgBigResultUdtToByref   .test )
	fbcu.add_test( "407", @intByval.callArgBigResultUdtToByval   .test )
	fbcu.add_test( "408", @intByval.callArgByvalNonTrivialUDT    .test )
	fbcu.add_test( "310", @intByval.callArgBydescStatic          .test )
	fbcu.add_test( "311", @intByval.callArgBydescField           .test )
	fbcu.add_test( "412", @intByval.callArgStringLiteral         .test )
	fbcu.add_test( "413", @intByval.callArgIntResultInRegsToByref.test )
	fbcu.add_test( "414", @intByval.callArgUdtResultInRegsToByref.test )
	fbcu.add_test( "415", @intByval.ptrchk                       .test )
	fbcu.add_test( "416", @intByval.boundchk                     .test )

	fbcu.add_test( "strings 01", @strings.byrefLiteral           .test )
	fbcu.add_test( "strings 02", @strings.addrofGlobal           .test )
	fbcu.add_test( "strings 03", @strings.stringResult           .test )
	fbcu.add_test( "strings 04", @strings.byrefStringFromIif0    .test )
	fbcu.add_test( "strings 05", @strings.byrefStringFromIif1    .test )
	fbcu.add_test( "strings 06", @strings.addrofZstrLiteral      .test )
	fbcu.add_test( "strings 07", @strings.addrofZstrGlobal       .test )
	fbcu.add_test( "strings 08", @strings.byrefZstringFromIif0   .test )
	fbcu.add_test( "strings 09", @strings.byrefZstringFromIif1   .test )
	fbcu.add_test( "strings 10", @strings.addrofWstrLiteral      .test )
	fbcu.add_test( "strings 11", @strings.addrofWstrGlobal       .test )
	fbcu.add_test( "strings 12", @strings.byrefWstringFromIif0   .test )
	fbcu.add_test( "strings 13", @strings.byrefWstringFromIif1   .test )

	fbcu.add_test( "new[] ctorlist", @vectorNewCtorList          .test )
end sub

end namespace
