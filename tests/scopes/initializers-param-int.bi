namespace constant
	'' temp var to hold constants passed to BYREF params,
	'' and testing the BYVAL version too just to ensure it's still working.
	sub tester( PARAM_MODE i as integer = 123 )
		CU_ASSERT( i = 123 )
	end sub

	hScopeChecks( tester( ) )
end namespace

namespace iif_
	'' iif() temp var
	sub tester( PARAM_MODE i as integer = iif( cond, 1, 2 ) )
		CU_ASSERT( i = 2 )
	end sub

	hScopeChecks( tester( ) )
end namespace

namespace callArgBigResultUdtToByref
	'' UDT result temp var (function returns result on stack)

	function f1( ) as BigUDT
		function = type( { 1 } )
	end function

	function f2( byref x as BigUDT ) as integer
		function = x.i(0)
	end function

	sub tester( PARAM_MODE i as integer = f2( f1( ) ) )
		CU_ASSERT( i = 1 )
	end sub

	hScopeChecks( tester( ) )
end namespace

namespace callArgBigResultUdtToByval
	'' UDT result temp var (function returns result on stack)

	function f1( ) as BigUDT
		function = type( { 1 } )
	end function

	function f2( byval x as BigUDT ) as integer
		function = x.i(0)
	end function

	sub tester( PARAM_MODE i as integer = f2( f1( ) ) )
		CU_ASSERT( i = 1 )
	end sub

	hScopeChecks( tester( ) )
end namespace

namespace callArgByvalNonTrivialUDT
	'' When passing an UDT with dtor/copyctor/virtual members BYVAL,
	'' there will actually be a temp var created which is passed BYREF
	'' implicitly as in C++.

	dim shared as ClassUDT globaldtorx

	function f( byval x as ClassUDT ) as integer
		function = x.i
	end function

	sub tester( PARAM_MODE i as integer = f( globaldtorx ) )
		CU_ASSERT( i = 123 )
		CU_ASSERT( globaldtorx.i = 123 )
	end sub

	hScopeChecks( tester( ) )
end namespace

namespace callArgBydesc
	'' temp array descriptor when passing static array BYDESC
	dim shared as integer globalarray(0 to 3) = { 1, 2, 3, 4 }

	function f( array() as integer ) as integer
		function = type( array(3) )
	end function

	sub tester( PARAM_MODE i as integer = f( globalarray() ) )
		CU_ASSERT( i = 4 )
	end sub

	hScopeChecks( tester( ) )
end namespace

namespace callArgStringLiteral
	'' temp string when passing a literal to a BYREF AS STRING
	dim shared as integer calls

	function f( byref s as string ) as integer
		function = len( s )
	end function

	sub tester( PARAM_MODE i as integer = f( "1234567" ) )
		CU_ASSERT( i = 7 )
	end sub

	hScopeChecks( tester( ) )
end namespace

namespace callArgIntResultInRegsToByref
	'' When passing a function returning a value in registers to a BYREF
	'' param, a temp var is created to be able to do addrof for the BYREF.

	'' returning in regs
	function f1( ) as integer
		function = 123
	end function

	'' BYREF param
	function f( byref i as integer ) as integer
		function = i
	end function

	sub tester( PARAM_MODE i as integer = f( f1( ) ) )
		CU_ASSERT( i = 123 )
	end sub

	hScopeChecks( tester( ) )
end namespace

namespace callArgUdtResultInRegsToByref
	'' Same, but with UDT result in regs, being passed to a BYREF param

	function f1( ) as UDT
		function = type( 123 )
	end function

	function f( byref x as UDT ) as integer
		function = x.i
	end function

	sub tester( PARAM_MODE i as integer = f( f1( ) ) )
		CU_ASSERT( i = 123 )
	end sub

	hScopeChecks( tester( ) )
end namespace

namespace ptrchk
	'' PTRCHKs (under -exx) use temp vars too
	dim shared as integer globali = 456
	dim shared as integer ptr globalpi = @globali

	sub tester( PARAM_MODE i as integer = *globalpi )
		CU_ASSERT( i = 456 )
	end sub

	hScopeChecks( tester( ) )
end namespace

namespace boundchk
	'' BOUNDCHKs, ditto
	dim shared as integer globaliarray(0 to 1) = { 12, 34 }
	dim shared as integer globali = 1

	sub tester( PARAM_MODE i as integer = globaliarray(globali) )
		CU_ASSERT( i = 34 )
	end sub

	hScopeChecks( tester( ) )
end namespace
