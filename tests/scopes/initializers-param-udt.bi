'' UDT params (because they are/were treated differently than non-UDT params
'' by the initializer expression parser)

namespace callResultUdt
	'' UDT result temp var (function returns result on stack)

	function f( ) as BigUDT
		function = type( { 1 } )
	end function

	sub tester( PARAM_MODE x as BigUDT = f( ) )
		CU_ASSERT( x.i(0) = 1 )
	end sub

	hScopeChecks( tester( ) )
end namespace

namespace callArgIif
	'' iif() temp var
	function f( byval i as integer ) as UDT
		function = type( i )
	end function

	sub tester( PARAM_MODE x as UDT = f( iif( cond, 1, 2 ) ) )
		CU_ASSERT( x.i = 2 )
	end sub

	hScopeChecks( tester( ) )
end namespace

namespace callArgByrefConstant
	'' temp var to hold constants passed to byref params
	function f( byref i as integer ) as UDT
		function = type( i )
	end function

	sub tester( PARAM_MODE x as UDT = f( 123 ) )
		CU_ASSERT( x.i = 123 )
	end sub

	hScopeChecks( tester( ) )
end namespace

namespace callArgByvalNonTrivialUDT
	'' When passing an UDT with dtor/copyctor/virtual members BYVAL,
	'' there will actually be a temp var created which is passed BYREF
	'' implicitly as in C++.

	dim shared as ClassUDT globaldtorx

	function f( byval x as ClassUDT ) as UDT
		function = type( x.i )
	end function

	sub tester( PARAM_MODE x as UDT = f( globaldtorx ) )
		CU_ASSERT( x.i = 123 )
		CU_ASSERT( globaldtorx.i = 123 )
	end sub

	hScopeChecks( tester( ) )
end namespace

namespace callArgBydesc
	'' temp array descriptor when passing static array BYDESC
	dim shared as integer globalarray(0 to 3) = { 1, 2, 3, 4 }

	function f( array() as integer ) as UDT
		function = type( array(3) )
	end function

	sub tester( PARAM_MODE x as UDT = f( globalarray() ) )
		CU_ASSERT( x.i = 4 )
	end sub

	hScopeChecks( tester( ) )
end namespace

namespace callArgStringLiteral
	'' temp string when passing a literal to a BYREF AS STRING
	dim shared as integer calls

	function f( byref s as string ) as UDT
		function = type( len( s ) )
	end function

	sub tester( PARAM_MODE x as UDT = f( "1234567" ) )
		CU_ASSERT( x.i = 7 )
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
	function f( byref i as integer ) as UDT
		function = type( i )
	end function

	sub tester( PARAM_MODE x as UDT = f( f1( ) ) )
		CU_ASSERT( x.i = 123 )
	end sub

	hScopeChecks( tester( ) )
end namespace

namespace callArgUdtResultInRegsToByref
	'' Same, but with UDT result in regs, being passed to a BYREF param

	function f1( ) as UDT
		function = type( 123 )
	end function

	function f( byref x as UDT ) as UDT
		function = x
	end function

	sub tester( PARAM_MODE x as UDT = f( f1( ) ) )
		CU_ASSERT( x.i = 123 )
	end sub

	hScopeChecks( tester( ) )
end namespace

namespace ptrchk
	'' PTRCHKs (under -exx) use temp vars too
	dim shared as UDT globalx = ( 456 )
	dim shared as UDT ptr globalpx = @globalx

	sub tester( PARAM_MODE x as UDT = *globalpx )
		CU_ASSERT( x.i = 456 )
	end sub

	hScopeChecks( tester( ) )
end namespace

namespace boundchk
	'' BOUNDCHKs, ditto
	dim shared as UDT globalxarray(0 to 1) = { ( 12 ), ( 34 ) }
	dim shared as integer globali = 1

	sub tester( PARAM_MODE x as UDT = globalxarray(globali) )
		CU_ASSERT( x.i = 34 )
	end sub

	hScopeChecks( tester( ) )
end namespace
