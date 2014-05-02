# include "fbcu.bi"

namespace fbc_tests.overload_.arg_upcasting

namespace main
	type T1 extends object
	end type

	type T2 extends T1
	end type

	type T3 extends T2
	end type

	function a overload( byref x as object ) as integer : function = 0 : end function
	function a overload( byref x as T1     ) as integer : function = 1 : end function
	function a overload( byref x as T2     ) as integer : function = 2 : end function
	function a overload( byref x as T3     ) as integer : function = 3 : end function

	function b overload( byref x as object ) as integer : function = 0 : end function
	function b overload( byref x as T1     ) as integer : function = 1 : end function
	function b overload( byref x as T2     ) as integer : function = 2 : end function

	function c overload( byref x as object ) as integer : function = 0 : end function
	function c overload( byref x as T1     ) as integer : function = 1 : end function

	function d overload( byref x as const T1 ) as integer : function = &hC1 : end function
	function d overload( byref x as       T1 ) as integer : function = &h01 : end function
	function d overload( byref x as const T2 ) as integer : function = &hC2 : end function
	function d overload( byref x as       T2 ) as integer : function = &h02 : end function
	function d overload( byref x as const T3 ) as integer : function = &hC3 : end function
	function d overload( byref x as       T3 ) as integer : function = &h03 : end function

	function e overload( byref x as const T1 ) as integer : function = &hC1 : end function
	function e overload( byref x as const T2 ) as integer : function = &hC2 : end function
	function e overload( byref x as const T3 ) as integer : function = &hC3 : end function

	function f overload( byref x as const T1 ) as integer : function = &hC1 : end function
	function f overload( byref x as const T2 ) as integer : function = &hC2 : end function

	sub test cdecl( )
		dim x1 as T1
		dim x2 as T2
		dim x3 as T3

		dim cx1 as const T1 = T1( )
		dim cx2 as const T2 = T2( )
		dim cx3 as const T3 = T3( )

		CU_ASSERT( a( x1 ) = 1 )
		CU_ASSERT( a( x2 ) = 2 )
		CU_ASSERT( a( x3 ) = 3 )

		CU_ASSERT( b( x1 ) = 1 )
		CU_ASSERT( b( x2 ) = 2 )
		CU_ASSERT( b( x3 ) = 2 )

		CU_ASSERT( c( x1 ) = 1 )
		CU_ASSERT( c( x2 ) = 1 )
		CU_ASSERT( c( x3 ) = 1 )

		CU_ASSERT( d( x1 ) = &h01 )
		CU_ASSERT( d( x2 ) = &h02 )
		CU_ASSERT( d( x3 ) = &h03 )
		CU_ASSERT( d( cx1 ) = &hC1 )
		CU_ASSERT( d( cx2 ) = &hC2 )
		CU_ASSERT( d( cx3 ) = &hC3 )

		CU_ASSERT( e( x1 ) = &hC1 )
		CU_ASSERT( e( x2 ) = &hC2 )
		CU_ASSERT( e( x3 ) = &hC3 )
		CU_ASSERT( e( cx1 ) = &hC1 )
		CU_ASSERT( e( cx2 ) = &hC2 )
		CU_ASSERT( e( cx3 ) = &hC3 )

		CU_ASSERT( f( x1 ) = &hC1 )
		CU_ASSERT( f( x2 ) = &hC2 )
		CU_ASSERT( f( x3 ) = &hC2 )
		CU_ASSERT( f( cx1 ) = &hC1 )
		CU_ASSERT( f( cx2 ) = &hC2 )
		CU_ASSERT( f( cx3 ) = &hC2 )
	end sub
end namespace

namespace copyctor
	dim shared as integer ctors, copyctors

	type A
		i as integer
		declare constructor( )
		declare constructor( byref as A )
	end type

	constructor A( )
		ctors += 1
	end constructor

	constructor A( byref rhs as A )
		copyctors += 1
	end constructor

	type B extends A
	end type

	sub test cdecl( )
		CU_ASSERT( ctors = 0 )
		CU_ASSERT( copyctors = 0 )

		dim as B b1
		CU_ASSERT( ctors = 1 )
		CU_ASSERT( copyctors = 0 )

		dim as A a1 = b1
		CU_ASSERT( ctors = 1 )
		CU_ASSERT( copyctors = 1 )
	end sub
end namespace

namespace constcopyctor
	dim shared as integer ctors, copyctors

	type A
		i as integer
		declare constructor( )
		declare constructor( byref as const A )
	end type

	constructor A( )
		ctors += 1
	end constructor

	constructor A( byref rhs as const A )
		copyctors += 1
	end constructor

	type B extends A
	end type

	sub test cdecl( )
		CU_ASSERT( ctors = 0 )
		CU_ASSERT( copyctors = 0 )

		dim as B b1
		CU_ASSERT( ctors = 1 )
		CU_ASSERT( copyctors = 0 )

		dim as A a1 = b1
		CU_ASSERT( ctors = 1 )
		CU_ASSERT( copyctors = 1 )

		dim as const B b2 = B( )
		CU_ASSERT( ctors = 2 )
		CU_ASSERT( copyctors = 1 )

		dim as const A a2 = b2
		CU_ASSERT( ctors = 2 )
		CU_ASSERT( copyctors = 2 )
	end sub
end namespace

private sub ctor( ) constructor
	fbcu.add_suite( "tests/overload/arg-upcasting" )
	fbcu.add_test( "main", @main.test )
	fbcu.add_test( "copyctor", @copyctor.test )
	fbcu.add_test( "constcopyctor", @constcopyctor.test )
end sub

end namespace
