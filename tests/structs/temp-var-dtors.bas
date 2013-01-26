#include "fbcu.bi"

namespace fbc_tests.structs.temp_var_dtors

type ObjStatus
	instance	as any ptr
	ctors		as integer
	copyctors	as integer
	dtors		as integer
end type

'' Assuming the exact number of temp objects created cannot be
'' predicted accurately, but 10 slots should be enough for the
'' test code below...
dim shared as ObjStatus status(0 to 9)
dim shared as integer totalctors, totalcopyctors, totaldtors

function hFindSlot( byval instance as any ptr ) as integer
	dim as integer i = any

	for i = lbound( status ) to ubound( status )
		if( status(i).instance = instance ) then
			return i
		end if
	next

	'' Dtor called but object entry not found? Add new instead
	if( instance ) then
		i = hFindSlot( 0 )
		status(i).instance = instance
		return i
	end if

	CU_FAIL( "more objects than expected" )
	function = 0
end function

#macro hClearStatus( )
	clear( status(0), 0, sizeof( status(0) ) * (ubound( status ) - lbound( status ) + 1) )

	'' Everything should be zero
	for i as integer = lbound( status ) to ubound( status )
		with( status(i) )
			CU_ASSERT( .instance = 0 )
			CU_ASSERT( .ctors = 0 )
			CU_ASSERT( .copyctors = 0 )
			CU_ASSERT( .dtors = 0 )
		end with
	next

	totalctors = 0
	totalcopyctors = 0
	totaldtors = 0
#endmacro

#macro hCheckStatus( minctors, mincopyctors, mindtors )
	'' Every registered object must always have either 1 ctorcall
	'' or 1 copyctorcall, and always 1 dtorcall.
	for i as integer = lbound( status ) to ubound( status )
		with( status(i) )
			if( .instance ) then
				if( .copyctors ) then
					CU_ASSERT( .copyctors = 1 )
				else
					CU_ASSERT( .ctors = 1 )
				end if
				CU_ASSERT( .dtors = 1 )
			else
				CU_ASSERT( .ctors = 0 )
				CU_ASSERT( .copyctors = 0 )
				CU_ASSERT( .dtors = 0 )
			end if
		end with
	next

	CU_ASSERT( (totalctors + totalcopyctors) = totaldtors )
	CU_ASSERT( totalctors >= minctors )
	CU_ASSERT( totalcopyctors >= mincopyctors )
	CU_ASSERT( totaldtors >= mindtors )
#endmacro

namespace classlikeIntegerUdt
	type ClassUdt
		i as integer
		declare constructor( )
		declare constructor( byref as ClassUdt )
		declare destructor( )
	end type

	constructor ClassUdt( )
		this.i = 123
		totalctors += 1
		with( status(hFindSlot( 0 )) )
			.instance = @this
			.ctors += 1
		end with
	end constructor

	constructor ClassUdt( byref rhs as ClassUdt )
		this.i = rhs.i
		totalcopyctors += 1
		with( status(hFindSlot( 0 )) )
			.instance = @this
			.copyctors += 1
		end with
	end constructor

	destructor ClassUdt( )
		totaldtors += 1
		with( status(hFindSlot( @this )) )
			.dtors += 1
		end with
	end destructor

	function test1( byval x as ClassUdt ) as ClassUdt
		function = x
	end function

	sub test2( byval x as ClassUdt = test1( ClassUdt( ) ) )
	end sub

	sub testParamInit cdecl( )
		hClearStatus( )
		scope
			test2( )
		end scope
		hCheckStatus( 1, 1, 2 )

		hClearStatus( )
		scope
			dim x as ClassUdt = test1( ClassUdt( ) )
		end scope
		hCheckStatus( 1, 1, 2 )
	end sub

	sub testAnon cdecl( )
		hClearStatus( )
		scope
			CU_ASSERT( (type<ClassUdt>( )).i = 123 )
		end scope
		hCheckStatus( 1, 0, 1 )

		hClearStatus( )
		scope
			dim x as ClassUdt
			CU_ASSERT( x.i = 123 )
			x.i = 11111
			x = type<ClassUdt>( )
			CU_ASSERT( x.i = 123 )
		end scope
		hCheckStatus( 2, 0, 2 )

		hClearStatus( )
		scope
			dim x as ClassUdt
			CU_ASSERT( x.i = 123 )
			x.i = 11111
			x = type( )
			CU_ASSERT( x.i = 123 )
		end scope
		hCheckStatus( 2, 0, 2 )

		hClearStatus( )
		scope
			dim x as ClassUdt
			CU_ASSERT( iif( x.i = (type<ClassUdt>( )).i, 1, 2 ) = 1 )  '' field at offset 0
		end scope
		hCheckStatus( 2, 0, 2 )
	end sub

	function f( ) as ClassUdt
		function = type( )
	end function

	sub testResult cdecl( )
		hClearStatus( )
		scope
			CU_ASSERT( f( ).i = 123 )
		end scope
		hCheckStatus( 2, 0, 2 )
	end sub
end namespace

namespace classlikeDoubleIntUdt
	type ClassUdt
		as integer i, j
		declare constructor( )
		declare constructor( byref as ClassUdt )
		declare destructor( )
	end type

	constructor ClassUdt( )
		this.i = 123
		this.j = 456
		totalctors += 1
		with( status(hFindSlot( 0 )) )
			.instance = @this
			.ctors += 1
		end with
	end constructor

	constructor ClassUdt( byref rhs as ClassUdt )
		this.i = rhs.i
		this.j = rhs.j
		totalcopyctors += 1
		with( status(hFindSlot( 0 )) )
			.instance = @this
			.copyctors += 1
		end with
	end constructor

	destructor ClassUdt( )
		totaldtors += 1
		with( status(hFindSlot( @this )) )
			.dtors += 1
		end with
	end destructor

	function test1( byval x as ClassUdt ) as ClassUdt
		function = x
	end function

	sub test2( byval x as ClassUdt = test1( ClassUdt( ) ) )
	end sub

	sub testParamInit cdecl( )
		hClearStatus( )
		scope
			test2( )
		end scope
		hCheckStatus( 1, 1, 2 )

		hClearStatus( )
		scope
			dim x as ClassUdt = test1( ClassUdt( ) )
		end scope
		hCheckStatus( 1, 1, 2 )
	end sub

	sub testAnon cdecl( )
		hClearStatus( )
		scope
			CU_ASSERT( (type<ClassUdt>( )).i = 123 )
		end scope
		hCheckStatus( 1, 0, 1 )

		hClearStatus( )
		scope
			dim x as ClassUdt
			CU_ASSERT( x.i = 123 )
			x.i = 11111
			x = type<ClassUdt>( )
			CU_ASSERT( x.i = 123 )
		end scope
		hCheckStatus( 2, 0, 2 )

		hClearStatus( )
		scope
			dim x as ClassUdt
			CU_ASSERT( x.i = 123 )
			x.i = 11111
			x = type( )
			CU_ASSERT( x.i = 123 )
		end scope
		hCheckStatus( 2, 0, 2 )

		hClearStatus( )
		scope
			dim x as ClassUdt
			CU_ASSERT( iif( x.i = (type<ClassUdt>( )).i, 1, 2 ) = 1 )  '' field at offset 0
			CU_ASSERT( iif( x.j = (type<ClassUdt>( )).j, 2, 1 ) = 2 )  '' field at non-0 offset
		end scope
		hCheckStatus( 3, 0, 3 )
	end sub

	function f( ) as ClassUdt
		function = type( )
	end function

	sub testResult cdecl( )
		hClearStatus( )
		scope
			CU_ASSERT( f( ).i = 123 )
		end scope
		hCheckStatus( 2, 0, 2 )
	end sub
end namespace

namespace dtorOnlyIntegerUdt
	type DtorUdt
		i as integer
		declare destructor( )
	end type

	destructor DtorUdt( )
		totaldtors += 1
		with( status(hFindSlot( @this )) )
			'' DtorUdt has no ctor, so fake it
			if( .ctors = 0 ) then
				totalctors += 1
				.ctors += 1
			end if
			.dtors += 1
		end with
	end destructor

	function test1( byval x as DtorUdt ) as DtorUdt
		function = x
	end function

	sub test2( byval x as DtorUdt = test1( type<DtorUdt>( 123 ) ) )
	end sub

	sub testParamInit cdecl( )
		hClearStatus( )
		scope
			test2( )
		end scope
		hCheckStatus( 0, 0, 2 )

		hClearStatus( )
		scope
			dim x as DtorUdt = test1( type<DtorUdt>( 123 ) )
		end scope
		hCheckStatus( 0, 0, 2 )
	end sub

	sub testAnon cdecl( )
		hClearStatus( )
		scope
			CU_ASSERT( (type<DtorUdt>( 123 )).i = 123 )
		end scope
		hCheckStatus( 0, 0, 1 )

		hClearStatus( )
		scope
			dim x as DtorUdt = ( 123 )
			CU_ASSERT( x.i = 123 )
			x.i = 11111
			x = type<DtorUdt>( 123 )
			CU_ASSERT( x.i = 123 )
		end scope
		hCheckStatus( 0, 0, 2 )

		hClearStatus( )
		scope
			dim x as DtorUdt = ( 123 )
			CU_ASSERT( x.i = 123 )
			x.i = 11111
			x = type( 123 )
			CU_ASSERT( x.i = 123 )
		end scope
		hCheckStatus( 0, 0, 2 )

		hClearStatus( )
		scope
			dim x as DtorUdt = ( 123 )
			CU_ASSERT( iif( x.i = (type<DtorUdt>( 123 )).i, 1, 2 ) = 1 )
		end scope
		hCheckStatus( 0, 0, 2 )
	end sub

	function f( ) as DtorUdt
		function = type( 123 )
	end function

	sub testResult cdecl( )
		hClearStatus( )
		scope
			CU_ASSERT( f( ).i = 123 )
		end scope
		hCheckStatus( 0, 0, 2 )
	end sub
end namespace

namespace dtorOnlyDoubleIntUdt
	type DtorUdt
		as integer i, j
		declare destructor( )
	end type

	destructor DtorUdt( )
		totaldtors += 1
		with( status(hFindSlot( @this )) )
			'' DtorUdt has no ctor, so fake it
			if( .ctors = 0 ) then
				totalctors += 1
				.ctors += 1
			end if
			.dtors += 1
		end with
	end destructor

	function test1( byval x as DtorUdt ) as DtorUdt
		function = x
	end function

	sub test2( byval x as DtorUdt = test1( type<DtorUdt>( 123, 456 ) ) )
	end sub

	sub testParamInit cdecl( )
		hClearStatus( )
		scope
			test2( )
		end scope
		hCheckStatus( 0, 0, 2 )

		hClearStatus( )
		scope
			dim x as DtorUdt = test1( type<DtorUdt>( 123 ) )
		end scope
		hCheckStatus( 0, 0, 2 )
	end sub

	sub testAnon cdecl( )
		hClearStatus( )
		scope
			CU_ASSERT( (type<DtorUdt>( 123, 456 )).i = 123 )
		end scope
		hCheckStatus( 0, 0, 1 )

		hClearStatus( )
		scope
			dim x as DtorUdt = ( 123, 456 )
			CU_ASSERT( x.i = 123 )
			CU_ASSERT( x.j = 456 )
			x.i = 11111
			x.j = 22222
			x = type<DtorUdt>( 123, 456 )
			CU_ASSERT( x.i = 123 )
			CU_ASSERT( x.j = 456 )
		end scope
		hCheckStatus( 0, 0, 2 )

		hClearStatus( )
		scope
			dim x as DtorUdt = ( 123, 456 )
			CU_ASSERT( x.i = 123 )
			CU_ASSERT( x.j = 456 )
			x.i = 11111
			x.j = 22222
			x = type( 123, 456 )
			CU_ASSERT( x.i = 123 )
			CU_ASSERT( x.j = 456 )
		end scope
		hCheckStatus( 0, 0, 2 )

		hClearStatus( )
		scope
			dim x as DtorUdt = ( 123, 456 )
			CU_ASSERT( iif( x.i = (type<DtorUdt>( 123, 456 )).i, 1, 2 ) = 1 )
			CU_ASSERT( iif( x.j = (type<DtorUdt>( 123, 456 )).j, 2, 1 ) = 2 )
		end scope
		hCheckStatus( 0, 0, 3 )
	end sub

	function f( ) as DtorUdt
		function = type( 123 )
	end function

	sub testResult cdecl( )
		hClearStatus( )
		scope
			CU_ASSERT( f( ).i = 123 )
		end scope
		hCheckStatus( 0, 0, 2 )
	end sub
end namespace

private sub ctor( ) constructor
	fbcu.add_suite( "tests/structs/temp-var-dtors" )

	fbcu.add_test( "11", @classlikeIntegerUdt.testParamInit )
	fbcu.add_test( "12", @classlikeIntegerUdt.testAnon )
	fbcu.add_test( "13", @classlikeIntegerUdt.testResult )

	fbcu.add_test( "21", @classlikeDoubleIntUdt.testParamInit )
	fbcu.add_test( "22", @classlikeDoubleIntUdt.testAnon )
	fbcu.add_test( "23", @classlikeDoubleIntUdt.testResult )

	fbcu.add_test( "31", @dtorOnlyIntegerUdt.testParamInit )
	fbcu.add_test( "32", @dtorOnlyIntegerUdt.testAnon )
	fbcu.add_test( "33", @dtorOnlyIntegerUdt.testResult )

	fbcu.add_test( "41", @dtorOnlyDoubleIntUdt.testParamInit )
	fbcu.add_test( "42", @dtorOnlyDoubleIntUdt.testAnon )
	fbcu.add_test( "43", @dtorOnlyDoubleIntUdt.testResult )
end sub

end namespace
