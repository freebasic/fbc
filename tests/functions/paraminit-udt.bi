'' UDT params (because they are/were treated differently than non-UDT params
'' by the initializer expression parser)

TEST_GROUP( PARAM_NS.anon )
	sub tester( PARAM_MODE x as UDT = type<UDT>( 123 ) )
		CU_ASSERT( x.i = 123 )
	end sub

	hScopeChecks( tester( ) )
END_TEST_GROUP

TEST_GROUP( PARAM_NS.global )
	dim shared globalx as UDT = ( 123 )

	sub tester( PARAM_MODE x as UDT = globalx )
		CU_ASSERT( x.i = 123 )
	end sub

	hScopeChecks( tester( ) )
END_TEST_GROUP

TEST_GROUP( PARAM_NS.addrofGlobal )
	dim shared globalx as UDT = ( 456 )

	sub tester( PARAM_MODE px as UDT ptr = @globalx )
		CU_ASSERT( px->i = 456 )
	end sub

	hScopeChecks( tester( ) )
END_TEST_GROUP

TEST_GROUP( PARAM_NS.callResultUdt )
	'' UDT result temp var (function returns result on stack)

	function f( ) as BigUDT
		function = type( { 1 } )
	end function

	sub tester( PARAM_MODE x as BigUDT = f( ) )
		CU_ASSERT( x.i(0) = 1 )
	end sub

	hScopeChecks( tester( ) )
END_TEST_GROUP

TEST_GROUP( PARAM_NS.callArgIif )
	'' iif() temp var
	function f( byval i as integer ) as UDT
		function = type( i )
	end function

	sub tester( PARAM_MODE x as UDT = f( iif( cond, 1, 2 ) ) )
		CU_ASSERT( x.i = 2 )
	end sub

	hScopeChecks( tester( ) )
END_TEST_GROUP

TEST_GROUP( PARAM_NS.callArgByrefConstant )
	'' temp var to hold constants passed to byref params
	function f( byref i as integer ) as UDT
		function = type( i )
	end function

	sub tester( PARAM_MODE x as UDT = f( 123 ) )
		CU_ASSERT( x.i = 123 )
	end sub

	hScopeChecks( tester( ) )
END_TEST_GROUP

TEST_GROUP( PARAM_NS.callArgByvalNonTrivialUDT )
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
END_TEST_GROUP

TEST_GROUP( PARAM_NS.callArgBydescStatic )
	'' temp array descriptor when passing static array BYDESC
	dim shared as integer globalarray(0 to 3) = { 1, 2, 3, 4 }

	function f( array() as integer ) as UDT
		function = type( array(3) )
	end function

	sub tester( PARAM_MODE x as UDT = f( globalarray() ) )
		CU_ASSERT( x.i = 4 )
	end sub

	hScopeChecks( tester( ) )
END_TEST_GROUP

TEST_GROUP( PARAM_NS.callArgBydescField )
	'' temp array descriptor when passing field array BYDESC

	type ArrayFieldUDT
		array(0 to 3) as integer
	end type

	dim shared as ArrayFieldUDT global1 = ( { 123, 456, 789, 321 } )

	function f( array() as integer ) as UDT
		function = type( array(2) )
	end function

	sub tester( PARAM_MODE x as UDT = f( global1.array() ) )
		CU_ASSERT( x.i = 789 )
	end sub

	hScopeChecks( tester( ) )
END_TEST_GROUP

TEST_GROUP( PARAM_NS.callArgStringLiteral )
	'' temp string when passing a literal to a BYREF AS STRING
	dim shared as integer calls

	function f( byref s as string ) as UDT
		function = type( len( s ) )
	end function

	sub tester( PARAM_MODE x as UDT = f( "1234567" ) )
		CU_ASSERT( x.i = 7 )
	end sub

	hScopeChecks( tester( ) )
END_TEST_GROUP

TEST_GROUP( PARAM_NS.callArgIntResultInRegsToByref )
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
END_TEST_GROUP

TEST_GROUP( PARAM_NS.callArgUdtResultInRegsToByref )
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
END_TEST_GROUP

TEST_GROUP( PARAM_NS.ptrchk )
	'' PTRCHKs (under -exx) use temp vars too
	dim shared as UDT globalx = ( 456 )
	dim shared as UDT ptr globalpx = @globalx

	sub tester( PARAM_MODE x as UDT = *globalpx )
		CU_ASSERT( x.i = 456 )
	end sub

	hScopeChecks( tester( ) )
END_TEST_GROUP

TEST_GROUP( PARAM_NS.boundchk )
	'' BOUNDCHKs, ditto
	dim shared as UDT globalxarray(0 to 1) = { ( 12 ), ( 34 ) }
	dim shared as integer globali = 1

	sub tester( PARAM_MODE x as UDT = globalxarray(globali) )
		CU_ASSERT( x.i = 34 )
	end sub

	hScopeChecks( tester( ) )
END_TEST_GROUP

TEST_GROUP( PARAM_NS.ctors1 )
	type UDT1
		i as integer
		declare constructor( PARAM_MODE i as integer = 123 )
	end type

	constructor UDT1( PARAM_MODE i as integer )
		CU_ASSERT( this.i = 0 )
		this.i = i
		CU_ASSERT( (this.i = 123) or (this.i = 456) or (this.i = 789) )
	end constructor

	type UDT2
		x1 as UDT1
		declare constructor( PARAM_MODE x1 as UDT1 = UDT1( 456 ) )
	end type

	constructor UDT2( PARAM_MODE x1 as UDT1 )
		CU_ASSERT( this.x1.i = 123 )
		this.x1 = x1
		CU_ASSERT( (this.x1.i = 456) or (this.x1.i = 789) )
	end constructor

	type UDT3
		x2 as UDT2
		declare constructor( PARAM_MODE x2 as UDT2 = UDT2( UDT1( 789 ) ) )
	end type

	constructor UDT3( PARAM_MODE x2 as UDT2 )
		CU_ASSERT( this.x2.x1.i = 456 )
		this.x2 = x2
		CU_ASSERT( this.x2.x1.i = 789 )
	end constructor

	dim shared p as UDT3 ptr
	hScopeChecks( p = new UDT3 : CU_ASSERT( p->x2.x1.i = 789 ) : delete p : p = NULL )
END_TEST_GROUP

TEST_GROUP( PARAM_NS.ctors2 )
	'' Same as ctors1 but with the param initializer expressions on both
	'' ctor declarations and bodies

	type UDT1
		i as integer
		declare constructor( PARAM_MODE i as integer = 123 )
	end type

	constructor UDT1( PARAM_MODE i as integer = 123 )
		CU_ASSERT( this.i = 0 )
		this.i = i
		CU_ASSERT( (this.i = 123) or (this.i = 456) or (this.i = 789) )
	end constructor

	type UDT2
		x1 as UDT1
		declare constructor( PARAM_MODE x1 as UDT1 = UDT1( 456 ) )
	end type

	constructor UDT2( PARAM_MODE x1 as UDT1 = UDT1( 456 ) )
		CU_ASSERT( this.x1.i = 123 )
		this.x1 = x1
		CU_ASSERT( (this.x1.i = 456) or (this.x1.i = 789) )
	end constructor

	type UDT3
		x2 as UDT2
		declare constructor( PARAM_MODE x2 as UDT2 = UDT2( UDT1( 789 ) ) )
	end type

	constructor UDT3( PARAM_MODE x2 as UDT2 = UDT2( UDT1( 789 ) ) )
		CU_ASSERT( this.x2.x1.i = 456 )
		this.x2 = x2
		CU_ASSERT( this.x2.x1.i = 789 )
	end constructor

	dim shared p as UDT3 ptr
	hScopeChecks( p = new UDT3 : CU_ASSERT( p->x2.x1.i = 789 ) : delete p : p = NULL )
END_TEST_GROUP

TEST_GROUP( PARAM_NS.ctors5 )
	type UDT
		dummy as integer
		declare constructor( )
		declare constructor( byref as UDT )
	end type

	constructor UDT( )
		this.dummy = 123
	end constructor

	constructor UDT( byref rhs as UDT )
		this.dummy = rhs.dummy
	end constructor

	function f( byval x as UDT = UDT( ) ) as UDT
		function = x
	end function

	sub tester( PARAM_MODE x as UDT = f( ) )
		CU_ASSERT( x.dummy = 123 )
	end sub

	hScopeChecks( tester( ) )
END_TEST_GROUP

TEST_GROUP( PARAM_NS.ctorTempArrayDesc )
	type BydescCtorUDT
		declare constructor( array() as integer )
		dummy as integer
	end type
	 
	constructor BydescCtorUDT( array() as integer )
		this.dummy = array(3)
	end constructor
	 
	type ArrayFieldUDT
		array(0 to 3) as integer
	end type

	dim shared as ArrayFieldUDT global1 = ( { 123, 456, 789, 321 } )

	sub tester( PARAM_MODE x as BydescCtorUDT = BydescCtorUDT( global1.array() ) )
		CU_ASSERT( x.dummy = 321 )
	end sub

	hScopeChecks( tester( ) )
END_TEST_GROUP

TEST_GROUP( PARAM_NS.vectorNewCtorList )
	dim shared as integer calls

	function sidefx( ) as integer
		calls += 1
		function = 4
	end function

	function f( byval p as ClassUDT ptr ) as UDT
		function = type( p[0].i )
		delete[] p
	end function

	sub tester( PARAM_MODE x as UDT = f( new ClassUDT[sidefx( )] ) )
		CU_ASSERT( x.i = 123 )
	end sub

	hScopeChecks( CU_ASSERT( calls = 0 ) : tester( ) : CU_ASSERT( calls = 1 ) : calls = 0 )
END_TEST_GROUP

TEST_GROUP( PARAM_NS.iif_ )
	dim shared as UDT globalx1 = ( 123 ), globalx2 = ( 456 )

	sub tester( PARAM_MODE x as UDT = iif( cond, globalx1, globalx2 ) )
		CU_ASSERT( x.i = 456 )
	end sub

	hScopeChecks( tester( ) )
END_TEST_GROUP

TEST_GROUP( PARAM_NS.iifAnon )
	sub tester( PARAM_MODE x as UDT = iif( cond, type<UDT>( 123 ), type<UDT>( 456 ) ) )
		CU_ASSERT( x.i = 456 )
	end sub

	hScopeChecks( tester( ) )
END_TEST_GROUP
