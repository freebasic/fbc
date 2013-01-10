#include "fbcu.bi"

namespace fbc_tests.scopes.initializers

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

namespace paramUdtByref
	#define PARAM_MODE byref
	#include "initializers-param-udt.bi"
	#undef PARAM_MODE
end namespace

namespace paramUdtByval
	#define PARAM_MODE byval
	#include "initializers-param-udt.bi"
	#undef PARAM_MODE
end namespace

private sub ctor( ) constructor
	fbcu.add_suite( "tests/scopes/initializers" )

	fbcu.add_test( "101", @paramUdtByref.callResultUdt                .test )
	fbcu.add_test( "102", @paramUdtByref.callArgIif                   .test )
	fbcu.add_test( "103", @paramUdtByref.callArgByrefConstant         .test )
	fbcu.add_test( "104", @paramUdtByref.callArgByvalNonTrivialUDT    .test )
	fbcu.add_test( "105", @paramUdtByref.callArgBydesc                .test )
	fbcu.add_test( "106", @paramUdtByref.callArgStringLiteral         .test )
	fbcu.add_test( "107", @paramUdtByref.callArgIntResultInRegsToByref.test )
	fbcu.add_test( "108", @paramUdtByref.callArgUdtResultInRegsToByref.test )
	fbcu.add_test( "109", @paramUdtByref.ptrchk                       .test )
	fbcu.add_test( "110", @paramUdtByref.boundchk                     .test )

	fbcu.add_test( "201", @paramUdtByval.callResultUdt                .test )
	fbcu.add_test( "202", @paramUdtByval.callArgIif                   .test )
	fbcu.add_test( "203", @paramUdtByval.callArgByrefConstant         .test )
	fbcu.add_test( "204", @paramUdtByval.callArgByvalNonTrivialUDT    .test )
	fbcu.add_test( "205", @paramUdtByval.callArgBydesc                .test )
	fbcu.add_test( "206", @paramUdtByval.callArgStringLiteral         .test )
	fbcu.add_test( "207", @paramUdtByval.callArgIntResultInRegsToByref.test )
	fbcu.add_test( "208", @paramUdtByval.callArgUdtResultInRegsToByref.test )
	fbcu.add_test( "209", @paramUdtByval.ptrchk                       .test )
	fbcu.add_test( "210", @paramUdtByval.boundchk                     .test )
end sub

end namespace
