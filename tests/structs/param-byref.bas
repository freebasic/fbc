#include "fbcu.bi"

namespace fbc_tests.structs.param_byref

namespace defCtor
	dim shared as integer ctors

	type UDT
		i as integer
		declare constructor( )
	end type

	constructor UDT( )
		ctors += 1
	end constructor

	function hPassByref( byref x as UDT ) as integer
		function = x.i
	end function

	sub test cdecl( )
		CU_ASSERT( ctors = 0 )

		dim as UDT x
		CU_ASSERT( ctors = 1 )

		x.i = 123
		CU_ASSERT( hPassByref( x ) = 123 )
		CU_ASSERT( ctors = 1 )

		CU_ASSERT( hPassByref( UDT( ) ) = 0 )
		CU_ASSERT( ctors = 2 )
	end sub
end namespace

namespace defCtorAndCopyCtor
	dim shared as integer defctors, copyctors

	type UDT
		i as integer
		declare constructor( )
		declare constructor( as UDT )
	end type

	constructor UDT( )
		defctors += 1
	end constructor

	constructor UDT( rhs as UDT )
		copyctors += 1
		this.i = rhs.i
	end constructor

	function hPassByref( byref x as UDT ) as integer
		function = x.i
	end function

	sub test cdecl( )
		CU_ASSERT(  defctors = 0 )
		CU_ASSERT( copyctors = 0 )

		dim as UDT x
		CU_ASSERT(  defctors = 1 )
		CU_ASSERT( copyctors = 0 )

		x.i = 123
		CU_ASSERT( hPassByref( x ) = 123 )
		CU_ASSERT(  defctors = 1 )
		CU_ASSERT( copyctors = 0 )

		CU_ASSERT( hPassByref( UDT( ) ) = 0 )
		CU_ASSERT(  defctors = 2 )
		CU_ASSERT( copyctors = 0 )
	end sub
end namespace

namespace intCtor
	dim shared as integer ctors

	type UDT
		i as integer
		declare constructor( as integer )
	end type

	constructor UDT( i as integer )
		ctors += 1
		this.i = i
	end constructor

	function hPassByref( byref x as UDT ) as integer
		function = x.i
	end function

	sub test cdecl( )
		CU_ASSERT( ctors = 0 )

		dim as UDT x = UDT( 123 )
		CU_ASSERT( ctors = 1 )

		CU_ASSERT( hPassByref( x ) = 123 )
		CU_ASSERT( ctors = 1 )

		CU_ASSERT( hPassByref( UDT( 456 ) ) = 456 )
		CU_ASSERT( ctors = 2 )
	end sub
end namespace

namespace intCtorAndCopyCtor
	dim shared as integer intctors, copyctors

	type UDT
		i as integer
		declare constructor( as integer )
		declare constructor( as UDT )
	end type

	constructor UDT( i as integer )
		intctors += 1
		this.i = i
	end constructor

	constructor UDT( rhs as UDT )
		copyctors += 1
		this.i = rhs.i
	end constructor

	function hPassByref( byref x as UDT ) as integer
		function = x.i
	end function

	sub test cdecl( )
		CU_ASSERT(  intctors = 0 )
		CU_ASSERT( copyctors = 0 )

		dim as UDT x = UDT( 123 )
		CU_ASSERT(  intctors = 1 )
		CU_ASSERT( copyctors = 0 )

		CU_ASSERT( hPassByref( x ) = 123 )
		CU_ASSERT(  intctors = 1 )
		CU_ASSERT( copyctors = 0 )

		CU_ASSERT( hPassByref( UDT( 456 ) ) = 456 )
		CU_ASSERT(  intctors = 2 )
		CU_ASSERT( copyctors = 0 )
	end sub
end namespace

namespace defCtorAndIntCtor
	dim shared as integer defctors, intctors

	type UDT
		i as integer
		declare constructor( )
		declare constructor( as integer )
	end type

	constructor UDT( )
		defctors += 1
	end constructor

	constructor UDT( i as integer )
		intctors += 1
		this.i = i
	end constructor

	function hPassByref( byref x as UDT ) as integer
		function = x.i
	end function

	sub test cdecl( )
		CU_ASSERT( defctors = 0 )
		CU_ASSERT( intctors = 0 )

		dim as UDT x = UDT( 123 )
		CU_ASSERT( defctors = 0 )
		CU_ASSERT( intctors = 1 )

		CU_ASSERT( hPassByref( x ) = 123 )
		CU_ASSERT( defctors = 0 )
		CU_ASSERT( intctors = 1 )

		CU_ASSERT( hPassByref( UDT( 456 ) ) = 456 )
		CU_ASSERT( defctors = 0 )
		CU_ASSERT( intctors = 2 )
	end sub
end namespace

private sub ctor( ) constructor
	fbcu.add_suite( "tests/structs/param-byref" )
	fbcu.add_test( "1", @defCtor.test )
	fbcu.add_test( "2", @defCtorAndCopyCtor.test )
	fbcu.add_test( "3", @intCtor.test )
	fbcu.add_test( "4", @intCtorAndCopyCtor.test )
	fbcu.add_test( "5", @defCtorAndIntCtor.test )
end sub

end namespace
