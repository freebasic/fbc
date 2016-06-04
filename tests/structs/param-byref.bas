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

	dim shared as UDT x0

	function hPassByref1( byref x as UDT ) as integer
		function = x.i
		x.i = 111
	end function

	function hPassByref2( byref x as UDT = x0 ) as integer
		function = x.i
		x.i = 222
	end function

	function hPassByref3( byref x as UDT = UDT( ) ) as integer
		function = x.i
		x.i = 333
	end function

	sub test cdecl( )
		CU_ASSERT( ctors = 1 )

		dim as UDT x
		CU_ASSERT( ctors = 2 )

		x.i = 123
		CU_ASSERT( hPassByref1( x ) = 123 )
		CU_ASSERT( x.i = 111 )
		CU_ASSERT( ctors = 2 )

		CU_ASSERT( hPassByref1( UDT( ) ) = 0 )
		CU_ASSERT( ctors = 3 )

		x0.i = 456
		CU_ASSERT( hPassByref2( ) = 456 )
		CU_ASSERT( x0.i = 222 )
		CU_ASSERT( ctors = 3 )

		CU_ASSERT( hPassByref3( ) = 0 )
		CU_ASSERT( ctors = 4 )
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

	dim shared as UDT x0

	function hPassByref1( byref x as UDT ) as integer
		function = x.i
		x.i = 111
	end function

	function hPassByref2( byref x as UDT = x0 ) as integer
		function = x.i
		x.i = 222
	end function

	function hPassByref3( byref x as UDT = UDT( ) ) as integer
		function = x.i
		x.i = 333
	end function

	sub test cdecl( )
		CU_ASSERT(  defctors = 1 )
		CU_ASSERT( copyctors = 0 )

		dim as UDT x
		CU_ASSERT(  defctors = 2 )
		CU_ASSERT( copyctors = 0 )

		x.i = 123
		CU_ASSERT( hPassByref1( x ) = 123 )
		CU_ASSERT( x.i = 111 )
		CU_ASSERT(  defctors = 2 )
		CU_ASSERT( copyctors = 0 )

		CU_ASSERT( hPassByref1( UDT( ) ) = 0 )
		CU_ASSERT(  defctors = 3 )
		CU_ASSERT( copyctors = 0 )

		x0.i = 456
		CU_ASSERT( hPassByref2( ) = 456 )
		CU_ASSERT( x0.i = 222 )
		CU_ASSERT(  defctors = 3 )
		CU_ASSERT( copyctors = 0 )

		CU_ASSERT( hPassByref3( ) = 0 )
		CU_ASSERT(  defctors = 4 )
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

	dim shared as UDT x0 = UDT( 456 )

	function hPassByref1( byref x as UDT ) as integer
		function = x.i
		x.i = 111
	end function

	function hPassByref2( byref x as UDT = x0 ) as integer
		function = x.i
		x.i = 222
	end function

	function hPassByref3( byref x as UDT = UDT( 789 ) ) as integer
		function = x.i
		x.i = 333
	end function

	'' implicit construction
	function hPassByref4( byref x as UDT = 3344 ) as integer
		function = x.i
		x.i = 444
	end function

	sub test cdecl( )
		CU_ASSERT( ctors = 1 )

		dim as UDT x = UDT( 123 )
		CU_ASSERT( ctors = 2 )

		CU_ASSERT( hPassByref1( x ) = 123 )
		CU_ASSERT( x.i = 111 )
		CU_ASSERT( ctors = 2 )

		CU_ASSERT( hPassByref1( UDT( 456 ) ) = 456 )
		CU_ASSERT( ctors = 3 )

		CU_ASSERT( hPassByref2( ) = 456 )
		CU_ASSERT( x0.i = 222 )
		CU_ASSERT( ctors = 3 )

		CU_ASSERT( hPassByref3( ) = 789 )
		CU_ASSERT( ctors = 4 )

		'' implicit construction
		CU_ASSERT( hPassByref1( 1122 ) = 1122 )
		CU_ASSERT( ctors = 5 )

		CU_ASSERT( hPassByref4( ) = 3344 )
		CU_ASSERT( ctors = 6 )
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

	dim shared as UDT x0 = UDT( 456 )

	function hPassByref1( byref x as UDT ) as integer
		function = x.i
		x.i = 111
	end function

	function hPassByref2( byref x as UDT = x0 ) as integer
		function = x.i
		x.i = 222
	end function

	function hPassByref3( byref x as UDT = UDT( 789 ) ) as integer
		function = x.i
		x.i = 333
	end function

	'' implicit construction
	function hPassByref4( byref x as UDT = 3344 ) as integer
		function = x.i
		x.i = 444
	end function

	sub test cdecl( )
		CU_ASSERT(  intctors = 1 )
		CU_ASSERT( copyctors = 0 )

		dim as UDT x = UDT( 123 )
		CU_ASSERT(  intctors = 2 )
		CU_ASSERT( copyctors = 0 )

		CU_ASSERT( hPassByref1( x ) = 123 )
		CU_ASSERT( x.i = 111 )
		CU_ASSERT(  intctors = 2 )
		CU_ASSERT( copyctors = 0 )

		CU_ASSERT( hPassByref1( UDT( 456 ) ) = 456 )
		CU_ASSERT(  intctors = 3 )
		CU_ASSERT( copyctors = 0 )

		CU_ASSERT( hPassByref2( ) = 456 )
		CU_ASSERT( x0.i = 222 )
		CU_ASSERT(  intctors = 3 )
		CU_ASSERT( copyctors = 0 )

		CU_ASSERT( hPassByref3( ) = 789 )
		CU_ASSERT(  intctors = 4 )
		CU_ASSERT( copyctors = 0 )

		'' implicit construction
		CU_ASSERT( hPassByref1( 1122 ) = 1122 )
		CU_ASSERT(  intctors = 5 )
		CU_ASSERT( copyctors = 0 )

		CU_ASSERT( hPassByref4( ) = 3344 )
		CU_ASSERT(  intctors = 6 )
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

	dim shared as UDT x0 = UDT( 456 )

	function hPassByref1( byref x as UDT ) as integer
		function = x.i
		x.i = 111
	end function

	function hPassByref2( byref x as UDT = x0 ) as integer
		function = x.i
		x.i = 222
	end function

	function hPassByref3( byref x as UDT = UDT( 789 ) ) as integer
		function = x.i
		x.i = 333
	end function

	'' implicit construction
	function hPassByref4( byref x as UDT = 3344 ) as integer
		function = x.i
		x.i = 444
	end function

	sub test cdecl( )
		CU_ASSERT( defctors = 0 )
		CU_ASSERT( intctors = 1 )

		dim as UDT x = UDT( 123 )
		CU_ASSERT( defctors = 0 )
		CU_ASSERT( intctors = 2 )

		CU_ASSERT( hPassByref1( x ) = 123 )
		CU_ASSERT( x.i = 111 )
		CU_ASSERT( defctors = 0 )
		CU_ASSERT( intctors = 2 )

		CU_ASSERT( hPassByref1( UDT( 456 ) ) = 456 )
		CU_ASSERT( defctors = 0 )
		CU_ASSERT( intctors = 3 )

		CU_ASSERT( hPassByref2( ) = 456 )
		CU_ASSERT( x0.i = 222 )
		CU_ASSERT( defctors = 0 )
		CU_ASSERT( intctors = 3 )

		CU_ASSERT( hPassByref3( ) = 789 )
		CU_ASSERT( defctors = 0 )
		CU_ASSERT( intctors = 4 )

		'' implicit construction
		CU_ASSERT( hPassByref1( 1122 ) = 1122 )
		CU_ASSERT( defctors = 0 )
		CU_ASSERT( intctors = 5 )

		CU_ASSERT( hPassByref4( ) = 3344 )
		CU_ASSERT( defctors = 0 )
		CU_ASSERT( intctors = 6 )
	end sub
end namespace

private sub ctor( ) constructor
	fbcu.add_suite( "fbc_tests.structs.param-byref" )
	fbcu.add_test( "1", @defCtor.test )
	fbcu.add_test( "2", @defCtorAndCopyCtor.test )
	fbcu.add_test( "3", @intCtor.test )
	fbcu.add_test( "4", @intCtorAndCopyCtor.test )
	fbcu.add_test( "5", @defCtorAndIntCtor.test )
end sub

end namespace
