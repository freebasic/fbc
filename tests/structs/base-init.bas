# include "fbcu.bi"

namespace fbc_tests.structs.based_init

namespace implicitBaseDefCtor
	dim shared as integer ctor_count

	type Parent
		as integer i
		declare constructor( )
	end type

	constructor Parent( )
		ctor_count += 1
		this.i = 123
	end constructor

	type Child extends Parent
		declare constructor( )
	end type

	constructor Child( )
	end constructor

	private sub test cdecl( )
		dim as Child c
		CU_ASSERT( c.i = 123 )
		CU_ASSERT( ctor_count = 1 )
	end sub
end namespace

namespace explicitBaseCtor
	type Parent
		as integer i
		declare constructor( )
		declare constructor( byval as integer )
	end type

	constructor Parent( )
		'' Shouldn't be called
		CU_FAIL( )
	end constructor

	constructor Parent( byval i as integer )
		this.i = 456
	end constructor

	type Child extends Parent
		declare constructor( )
	end type

	constructor Child( )
		base( 123 )
	end constructor

	private sub test cdecl( )
		dim as Child c
		CU_ASSERT( c.i = 456 )
	end sub
end namespace

namespace explicitBaseDefCtor
	dim shared as integer ctor_count

	type Parent
		as integer i
		declare constructor( )
	end type

	constructor Parent( )
		ctor_count += 1
		this.i = 456
	end constructor

	type Child extends Parent
		declare constructor( )
	end type

	constructor Child( )
		base( )
	end constructor

	private sub test cdecl( )
		dim as Child c
		CU_ASSERT( c.i = 456 )
		CU_ASSERT( ctor_count = 1 )
	end sub
end namespace

namespace explicitBaseInit
	type Parent
		as integer a, b, c
	end type

	type Child extends Parent
		declare constructor( )
	end type

	constructor Child( )
		base( 1, 2, 3 )
	end constructor

	private sub test cdecl( )
		dim as Child c
		CU_ASSERT( c.a = 1 )
		CU_ASSERT( c.b = 2 )
		CU_ASSERT( c.c = 3 )
	end sub
end namespace

namespace explicitBasePartialInit
	type Parent
		as integer a, b, c
	end type

	type Child extends Parent
		declare constructor( )
	end type

	constructor Child( )
		base( 123 )
	end constructor

	private sub test cdecl( )
		dim as Child c
		CU_ASSERT( c.a = 123 )
		CU_ASSERT( c.b = 0 )
		CU_ASSERT( c.c = 0 )
	end sub
end namespace

namespace rttiPreserved
	type Parent extends object
		as integer i
		declare constructor( byval as integer )
	end type

	constructor Parent( byval i as integer )
	end constructor

	type Child extends Parent
		declare constructor( )
	end type

	constructor Child( )
		base( 123 )
	end constructor

	private sub test cdecl( )
		dim as Child c
		dim as Parent ptr p = @c
		CU_ASSERT( *p is Child )
	end sub
end namespace

namespace podBase
	type Parent
		as integer a
	end type

	type Child extends Parent
		as integer b
		declare constructor( )
	end type

	constructor Child( )
		'' A POD base UDT should be cleared, just like any fields
	end constructor

	private sub test cdecl( )
		scope
			'' Try to trash the stack a little
			dim as integer a = 123, b = 456
			CU_ASSERT( a = 123 )
			CU_ASSERT( b = 456 )
		end scope
		scope
			dim as Child c
			CU_ASSERT( c.a = 0 )
			CU_ASSERT( c.b = 0 )
		end scope
	end sub
end namespace

private sub ctor( ) constructor
	fbcu.add_suite( "tests/structs/based-init" )
	fbcu.add_test( "Implicit base default ctor call", @implicitBaseDefCtor.test )
	fbcu.add_test( "BASE() with non-default ctor", @explicitBaseCtor.test )
	fbcu.add_test( "BASE() with default ctor", @explicitBaseDefCtor.test )
	fbcu.add_test( "BASE() as initializer", @explicitBaseInit.test )
	fbcu.add_test( "BASE() as partial initializer", @explicitBasePartialInit.test )
	fbcu.add_test( "BASE() shouldn't overwrite RTTI", @rttiPreserved.test )
	fbcu.add_test( "POD base UDTs must be cleared", @podBase.test )
end sub

end namespace
