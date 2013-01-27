#include "fbcu.bi"

namespace fbc_tests.structs.temp_var_dtors

type ObjStatus
	instance	as any ptr
	refcount	as integer
end type

dim shared as ObjStatus status(0 to 9)
dim shared as integer totalctors, totalcopyctors, totaldtors

function hFindSlot( byval instance as any ptr ) as integer
	dim as integer i = any

	for i = lbound( status ) to ubound( status )
		if( status(i).instance = instance ) then
			return i
		end if
	next

	'' Not found? Add new instead
	for i = lbound( status ) to ubound( status )
		if( status(i).instance = 0 ) then
			status(i).instance = instance
			return i
		end if
	next

	CU_FAIL( "more objects than expected, please increase the status() array's size" )
	function = 0
end function

#macro begin( )
	'' Reset everything
	clear( status(0), 0, sizeof( status(0) ) * (ubound( status ) - lbound( status ) + 1) )
	totalctors = 0
	totalcopyctors = 0
	totaldtors = 0

	scope
#endmacro

#macro check( expectctors, expectcopyctors, expectdtors )
	end scope

	'' Every registered object must always have either 1 ctorcall
	'' or 1 copyctorcall, and always 1 dtorcall.
	for i as integer = lbound( status ) to ubound( status )
		with( status(i) )
			CU_ASSERT( .refcount = 0 )
		end with
	next

	CU_ASSERT( (totalctors + totalcopyctors) = totaldtors )
	CU_ASSERT( totalctors = (expectctors) )
	CU_ASSERT( totalcopyctors = (expectcopyctors) )
	CU_ASSERT( totaldtors = (expectdtors) )
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
		with( status(hFindSlot( @this )) )
			.instance = @this
			CU_ASSERT( .refcount = 0 )
			.refcount += 1
		end with
	end constructor

	constructor ClassUdt( byref rhs as ClassUdt )
		this.i = rhs.i
		totalcopyctors += 1
		with( status(hFindSlot( @this )) )
			.instance = @this
			CU_ASSERT( .refcount = 0 )
			.refcount += 1
		end with
	end constructor

	destructor ClassUdt( )
		totaldtors += 1
		with( status(hFindSlot( @this )) )
			CU_ASSERT( .refcount = 1 )
			.refcount -= 1
		end with
	end destructor

	function test1( byval x as ClassUdt ) as ClassUdt
		function = x
	end function

	sub test2( byval x as ClassUdt = test1( ClassUdt( ) ) )
	end sub

	sub testParamInit cdecl( )
		begin( )
			test2( )
		check( 2, 3, 5 )

		begin( )
			dim x as ClassUdt = test1( ClassUdt( ) )
		check( 2, 2, 4 )
	end sub

	sub testAnon cdecl( )
		begin( )
			CU_ASSERT( (type<ClassUdt>( )).i = 123 )
		check( 1, 0, 1 )

		begin( )
			dim x as ClassUdt
			CU_ASSERT( x.i = 123 )
			x.i = 11111
			x = type<ClassUdt>( )
			CU_ASSERT( x.i = 123 )
		check( 2, 0, 2 )

		begin( )
			dim x as ClassUdt
			CU_ASSERT( x.i = 123 )
			x.i = 11111
			x = type( )
			CU_ASSERT( x.i = 123 )
		check( 2, 0, 2 )

		begin( )
			dim x as ClassUdt
			CU_ASSERT( iif( x.i = (type<ClassUdt>( )).i, 1, 2 ) = 1 )  '' field at offset 0
		check( 2, 0, 2 )
	end sub

	function f1( ) as ClassUdt
		function = type( )
	end function

	sub testResult cdecl( )
		begin( )
			CU_ASSERT( f1( ).i = 123 )
		check( 2, 0, 2 )
	end sub

	function f2( byval i as integer ) as ClassUdt
		dim x as ClassUdt
		x.i = i
		function = x
	end function

	sub testWhileBranch cdecl( )
		begin( )
			dim as integer i = 5
			while( f2( i ).i )
				i -= 1
			wend
		check( 6*2, 0, 6*2 )

		begin( )
			dim x as ClassUdt
			dim as integer i = 1
			x.i = 1
			while( x.i = f2( i ).i )
				i += 1
			wend
		check( 2*2 + 1, 0, 2*2 + 1 )

		begin( )
			dim x as ClassUdt
			dim as integer i = 1
			x.i = 5
			while( x.i <> f2( i ).i )
				i += 1
			wend
		check( 5*2 + 1, 0, 5*2 + 1 )

		begin( )
			dim as integer i = 5
			do while( f2( i ).i )
				i -= 1
			loop
		check( 6*2, 0, 6*2 )

		begin( )
			dim x as ClassUdt
			dim as integer i = 1
			x.i = 1
			do while( x.i = f2( i ).i )
				i += 1
			loop
		check( 2*2 + 1, 0, 2*2 + 1 )

		begin( )
			dim x as ClassUdt
			dim as integer i = 1
			x.i = 5
			do while( x.i <> f2( i ).i )
				i += 1
			loop
		check( 5*2 + 1, 0, 5*2 + 1 )

		begin( )
			dim as integer i = 5
			do
				i -= 1
			loop while( f2( i ).i )
		check( 5*2, 0, 5*2 )

		begin( )
			dim x as ClassUdt
			dim as integer i = 1
			x.i = 1
			do
				i += 1
			loop while( x.i = f2( i ).i )
		check( 1*2 + 1, 0, 1*2 + 1 )

		begin( )
			dim x as ClassUdt
			dim as integer i = 5
			x.i = 1
			do
				i -= 1
			loop while( x.i <> f2( i ).i )
		check( 4*2 + 1, 0, 4*2 + 1 )
	end sub

	sub testUntilBranch cdecl( )
		begin( )
			dim as integer i = 0
			do until( f2( i ).i )
				i += 1
			loop
		check( 2*2, 0, 2*2 )

		begin( )
			dim x as ClassUdt
			dim as integer i = 1
			x.i = 5
			do until( x.i = f2( i ).i )
				i += 1
			loop
		check( 5*2 + 1, 0, 5*2 + 1 )

		begin( )
			dim x as ClassUdt
			dim as integer i = 1
			x.i = 1
			do until( x.i <> f2( i ).i )
				i += 1
			loop
		check( 2*2 + 1, 0, 2*2 + 1 )

		begin( )
			dim as integer i = 0
			do
				i += 1
			loop until( f2( i ).i )
		check( 1*2, 0, 1*2 )

		begin( )
			dim x as ClassUdt
			dim as integer i = 1
			x.i = 5
			do
				i += 1
			loop until( x.i = f2( i ).i )
		check( 4*2 + 1, 0, 4*2 + 1 )

		begin( )
			dim x as ClassUdt
			dim as integer i = 1
			x.i = 1
			do
				i += 1
			loop until( x.i <> f2( i ).i )
		check( 1*2 + 1, 0, 1*2 + 1 )
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
		with( status(hFindSlot( @this )) )
			.instance = @this
			CU_ASSERT( .refcount = 0 )
			.refcount += 1
		end with
	end constructor

	constructor ClassUdt( byref rhs as ClassUdt )
		this.i = rhs.i
		this.j = rhs.j
		totalcopyctors += 1
		with( status(hFindSlot( @this )) )
			.instance = @this
			CU_ASSERT( .refcount = 0 )
			.refcount += 1
		end with
	end constructor

	destructor ClassUdt( )
		totaldtors += 1
		with( status(hFindSlot( @this )) )
			CU_ASSERT( .refcount = 1 )
			.refcount -= 1
		end with
	end destructor

	function test1( byval x as ClassUdt ) as ClassUdt
		function = x
	end function

	sub test2( byval x as ClassUdt = test1( ClassUdt( ) ) )
	end sub

	sub testParamInit cdecl( )
		begin( )
			test2( )
		check( 2, 3, 5 )

		begin( )
			dim x as ClassUdt = test1( ClassUdt( ) )
		check( 2, 2, 4 )
	end sub

	sub testAnon cdecl( )
		begin( )
			CU_ASSERT( (type<ClassUdt>( )).i = 123 )
		check( 1, 0, 1 )

		begin( )
			dim x as ClassUdt
			CU_ASSERT( x.i = 123 )
			x.i = 11111
			x = type<ClassUdt>( )
			CU_ASSERT( x.i = 123 )
		check( 2, 0, 2 )

		begin( )
			dim x as ClassUdt
			CU_ASSERT( x.i = 123 )
			x.i = 11111
			x = type( )
			CU_ASSERT( x.i = 123 )
		check( 2, 0, 2 )

		begin( )
			dim x as ClassUdt
			CU_ASSERT( iif( x.i = (type<ClassUdt>( )).i, 1, 2 ) = 1 )  '' field at offset 0
			CU_ASSERT( iif( x.j = (type<ClassUdt>( )).j, 2, 1 ) = 2 )  '' field at non-0 offset
		check( 3, 0, 3 )
	end sub

	function f1( ) as ClassUdt
		function = type( )
	end function

	sub testResult cdecl( )
		begin( )
			CU_ASSERT( f1( ).i = 123 )
		check( 2, 0, 2 )
	end sub

	function f2( byval i as integer ) as ClassUdt
		dim x as ClassUdt
		x.i = i
		function = x
	end function

	sub testWhileBranch cdecl( )
		begin( )
			dim as integer i = 5
			while( f2( i ).i )
				i -= 1
			wend
		check( 6*2, 0, 6*2 )

		begin( )
			dim x as ClassUdt
			dim as integer i = 1
			x.i = 1
			while( x.i = f2( i ).i )
				i += 1
			wend
		check( 2*2 + 1, 0, 2*2 + 1 )

		begin( )
			dim x as ClassUdt
			dim as integer i = 1
			x.i = 5
			while( x.i <> f2( i ).i )
				i += 1
			wend
		check( 5*2 + 1, 0, 5*2 + 1 )

		begin( )
			dim as integer i = 5
			do while( f2( i ).i )
				i -= 1
			loop
		check( 6*2, 0, 6*2 )

		begin( )
			dim x as ClassUdt
			dim as integer i = 1
			x.i = 1
			do while( x.i = f2( i ).i )
				i += 1
			loop
		check( 2*2 + 1, 0, 2*2 + 1 )

		begin( )
			dim x as ClassUdt
			dim as integer i = 1
			x.i = 5
			do while( x.i <> f2( i ).i )
				i += 1
			loop
		check( 5*2 + 1, 0, 5*2 + 1 )

		begin( )
			dim as integer i = 5
			do
				i -= 1
			loop while( f2( i ).i )
		check( 5*2, 0, 5*2 )

		begin( )
			dim x as ClassUdt
			dim as integer i = 1
			x.i = 1
			do
				i += 1
			loop while( x.i = f2( i ).i )
		check( 1*2 + 1, 0, 1*2 + 1 )

		begin( )
			dim x as ClassUdt
			dim as integer i = 5
			x.i = 1
			do
				i -= 1
			loop while( x.i <> f2( i ).i )
		check( 4*2 + 1, 0, 4*2 + 1 )
	end sub

	sub testUntilBranch cdecl( )
		begin( )
			dim as integer i = 0
			do until( f2( i ).i )
				i += 1
			loop
		check( 2*2, 0, 2*2 )

		begin( )
			dim x as ClassUdt
			dim as integer i = 1
			x.i = 5
			do until( x.i = f2( i ).i )
				i += 1
			loop
		check( 5*2 + 1, 0, 5*2 + 1 )

		begin( )
			dim x as ClassUdt
			dim as integer i = 1
			x.i = 1
			do until( x.i <> f2( i ).i )
				i += 1
			loop
		check( 2*2 + 1, 0, 2*2 + 1 )

		begin( )
			dim as integer i = 0
			do
				i += 1
			loop until( f2( i ).i )
		check( 1*2, 0, 1*2 )

		begin( )
			dim x as ClassUdt
			dim as integer i = 1
			x.i = 5
			do
				i += 1
			loop until( x.i = f2( i ).i )
		check( 4*2 + 1, 0, 4*2 + 1 )

		begin( )
			dim x as ClassUdt
			dim as integer i = 1
			x.i = 1
			do
				i += 1
			loop until( x.i <> f2( i ).i )
		check( 1*2 + 1, 0, 1*2 + 1 )
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
			totalctors += 1
		end with
	end destructor

	function test1( byval x as DtorUdt ) as DtorUdt
		function = x
	end function

	sub test2( byval x as DtorUdt = test1( type<DtorUdt>( 123 ) ) )
	end sub

	sub testParamInit cdecl( )
		begin( )
			test2( )
		check( 5, 0, 5 )

		begin( )
			dim x as DtorUdt = test1( type<DtorUdt>( 123 ) )
		check( 4, 0, 4 )
	end sub

	sub testAnon cdecl( )
		begin( )
			CU_ASSERT( (type<DtorUdt>( 123 )).i = 123 )
		check( 1, 0, 1 )

		begin( )
			dim x as DtorUdt = ( 123 )
			CU_ASSERT( x.i = 123 )
			x.i = 11111
			x = type<DtorUdt>( 123 )
			CU_ASSERT( x.i = 123 )
		check( 2, 0, 2 )

		begin( )
			dim x as DtorUdt = ( 123 )
			CU_ASSERT( x.i = 123 )
			x.i = 11111
			x = type( 123 )
			CU_ASSERT( x.i = 123 )
		check( 2, 0, 2 )

		begin( )
			dim x as DtorUdt = ( 123 )
			CU_ASSERT( iif( x.i = (type<DtorUdt>( 123 )).i, 1, 2 ) = 1 )
		check( 2, 0, 2 )
	end sub

	function f1( ) as DtorUdt
		function = type( 123 )
	end function

	sub testResult cdecl( )
		begin( )
			CU_ASSERT( f1( ).i = 123 )
		check( 2, 0, 2 )
	end sub

	function f2( byval i as integer ) as DtorUdt
		function = type( i )
	end function

	sub testWhileBranch cdecl( )
		begin( )
			dim as integer i = 5
			while( f2( i ).i )
				i -= 1
			wend
		check( 6*2, 0, 6*2 )

		begin( )
			dim x as DtorUdt
			dim as integer i = 1
			x.i = 1
			while( x.i = f2( i ).i )
				i += 1
			wend
		check( 2*2 + 1, 0, 2*2 + 1 )

		begin( )
			dim x as DtorUdt
			dim as integer i = 1
			x.i = 5
			while( x.i <> f2( i ).i )
				i += 1
			wend
		check( 5*2 + 1, 0, 5*2 + 1 )

		begin( )
			dim as integer i = 5
			do while( f2( i ).i )
				i -= 1
			loop
		check( 6*2, 0, 6*2 )

		begin( )
			dim x as DtorUdt
			dim as integer i = 1
			x.i = 1
			do while( x.i = f2( i ).i )
				i += 1
			loop
		check( 2*2 + 1, 0, 2*2 + 1 )

		begin( )
			dim x as DtorUdt
			dim as integer i = 1
			x.i = 5
			do while( x.i <> f2( i ).i )
				i += 1
			loop
		check( 5*2 + 1, 0, 5*2 + 1 )

		begin( )
			dim as integer i = 5
			do
				i -= 1
			loop while( f2( i ).i )
		check( 5*2, 0, 5*2 )

		begin( )
			dim x as DtorUdt
			dim as integer i = 1
			x.i = 1
			do
				i += 1
			loop while( x.i = f2( i ).i )
		check( 1*2 + 1, 0, 1*2 + 1 )

		begin( )
			dim x as DtorUdt
			dim as integer i = 5
			x.i = 1
			do
				i -= 1
			loop while( x.i <> f2( i ).i )
		check( 4*2 + 1, 0, 4*2 + 1 )
	end sub

	sub testUntilBranch cdecl( )
		begin( )
			dim as integer i = 0
			do until( f2( i ).i )
				i += 1
			loop
		check( 2*2, 0, 2*2 )

		begin( )
			dim x as DtorUdt
			dim as integer i = 1
			x.i = 5
			do until( x.i = f2( i ).i )
				i += 1
			loop
		check( 5*2 + 1, 0, 5*2 + 1 )

		begin( )
			dim x as DtorUdt
			dim as integer i = 1
			x.i = 1
			do until( x.i <> f2( i ).i )
				i += 1
			loop
		check( 2*2 + 1, 0, 2*2 + 1 )

		begin( )
			dim as integer i = 0
			do
				i += 1
			loop until( f2( i ).i )
		check( 1*2, 0, 1*2 )

		begin( )
			dim x as DtorUdt
			dim as integer i = 1
			x.i = 5
			do
				i += 1
			loop until( x.i = f2( i ).i )
		check( 4*2 + 1, 0, 4*2 + 1 )

		begin( )
			dim x as DtorUdt
			dim as integer i = 1
			x.i = 1
			do
				i += 1
			loop until( x.i <> f2( i ).i )
		check( 1*2 + 1, 0, 1*2 + 1 )
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
			totalctors += 1
		end with
	end destructor

	function test1( byval x as DtorUdt ) as DtorUdt
		function = x
	end function

	sub test2( byval x as DtorUdt = test1( type<DtorUdt>( 123, 456 ) ) )
	end sub

	sub testParamInit cdecl( )
		begin( )
			test2( )
		check( 5, 0, 5 )

		begin( )
			dim x as DtorUdt = test1( type<DtorUdt>( 123 ) )
		check( 4, 0, 4 )
	end sub

	sub testAnon cdecl( )
		begin( )
			CU_ASSERT( (type<DtorUdt>( 123, 456 )).i = 123 )
		check( 1, 0, 1 )

		begin( )
			dim x as DtorUdt = ( 123, 456 )
			CU_ASSERT( x.i = 123 )
			CU_ASSERT( x.j = 456 )
			x.i = 11111
			x.j = 22222
			x = type<DtorUdt>( 123, 456 )
			CU_ASSERT( x.i = 123 )
			CU_ASSERT( x.j = 456 )
		check( 2, 0, 2 )

		begin( )
			dim x as DtorUdt = ( 123, 456 )
			CU_ASSERT( x.i = 123 )
			CU_ASSERT( x.j = 456 )
			x.i = 11111
			x.j = 22222
			x = type( 123, 456 )
			CU_ASSERT( x.i = 123 )
			CU_ASSERT( x.j = 456 )
		check( 2, 0, 2 )

		begin( )
			dim x as DtorUdt = ( 123, 456 )
			CU_ASSERT( iif( x.i = (type<DtorUdt>( 123, 456 )).i, 1, 2 ) = 1 )
			CU_ASSERT( iif( x.j = (type<DtorUdt>( 123, 456 )).j, 2, 1 ) = 2 )
		check( 3, 0, 3 )
	end sub

	function f1( ) as DtorUdt
		function = type( 123 )
	end function

	sub testResult cdecl( )
		begin( )
			CU_ASSERT( f1( ).i = 123 )
		check( 2, 0, 2 )
	end sub

	function f2( byval i as integer ) as DtorUdt
		function = type( i )
	end function

	sub testWhileBranch cdecl( )
		begin( )
			dim as integer i = 5
			while( f2( i ).i )
				i -= 1
			wend
		check( 6*2, 0, 6*2 )

		begin( )
			dim x as DtorUdt
			dim as integer i = 1
			x.i = 1
			while( x.i = f2( i ).i )
				i += 1
			wend
		check( 2*2 + 1, 0, 2*2 + 1 )

		begin( )
			dim x as DtorUdt
			dim as integer i = 1
			x.i = 5
			while( x.i <> f2( i ).i )
				i += 1
			wend
		check( 5*2 + 1, 0, 5*2 + 1 )

		begin( )
			dim as integer i = 5
			do while( f2( i ).i )
				i -= 1
			loop
		check( 6*2, 0, 6*2 )

		begin( )
			dim x as DtorUdt
			dim as integer i = 1
			x.i = 1
			do while( x.i = f2( i ).i )
				i += 1
			loop
		check( 2*2 + 1, 0, 2*2 + 1 )

		begin( )
			dim x as DtorUdt
			dim as integer i = 1
			x.i = 5
			do while( x.i <> f2( i ).i )
				i += 1
			loop
		check( 5*2 + 1, 0, 5*2 + 1 )

		begin( )
			dim as integer i = 5
			do
				i -= 1
			loop while( f2( i ).i )
		check( 5*2, 0, 5*2 )

		begin( )
			dim x as DtorUdt
			dim as integer i = 1
			x.i = 1
			do
				i += 1
			loop while( x.i = f2( i ).i )
		check( 1*2 + 1, 0, 1*2 + 1 )

		begin( )
			dim x as DtorUdt
			dim as integer i = 5
			x.i = 1
			do
				i -= 1
			loop while( x.i <> f2( i ).i )
		check( 4*2 + 1, 0, 4*2 + 1 )
	end sub

	sub testUntilBranch cdecl( )
		begin( )
			dim as integer i = 0
			do until( f2( i ).i )
				i += 1
			loop
		check( 2*2, 0, 2*2 )

		begin( )
			dim x as DtorUdt
			dim as integer i = 1
			x.i = 5
			do until( x.i = f2( i ).i )
				i += 1
			loop
		check( 5*2 + 1, 0, 5*2 + 1 )

		begin( )
			dim x as DtorUdt
			dim as integer i = 1
			x.i = 1
			do until( x.i <> f2( i ).i )
				i += 1
			loop
		check( 2*2 + 1, 0, 2*2 + 1 )

		begin( )
			dim as integer i = 0
			do
				i += 1
			loop until( f2( i ).i )
		check( 1*2, 0, 1*2 )

		begin( )
			dim x as DtorUdt
			dim as integer i = 1
			x.i = 5
			do
				i += 1
			loop until( x.i = f2( i ).i )
		check( 4*2 + 1, 0, 4*2 + 1 )

		begin( )
			dim x as DtorUdt
			dim as integer i = 1
			x.i = 1
			do
				i += 1
			loop until( x.i <> f2( i ).i )
		check( 1*2 + 1, 0, 1*2 + 1 )
	end sub
end namespace

private sub ctor( ) constructor
	fbcu.add_suite( "tests/structs/temp-var-dtors" )

	fbcu.add_test( "11", @classlikeIntegerUdt.testParamInit )
	fbcu.add_test( "12", @classlikeIntegerUdt.testAnon )
	fbcu.add_test( "13", @classlikeIntegerUdt.testResult )
	fbcu.add_test( "16", @classlikeIntegerUdt.testWhileBranch )
	fbcu.add_test( "17", @classlikeIntegerUdt.testUntilBranch )

	fbcu.add_test( "21", @classlikeDoubleIntUdt.testParamInit )
	fbcu.add_test( "22", @classlikeDoubleIntUdt.testAnon )
	fbcu.add_test( "23", @classlikeDoubleIntUdt.testResult )
	fbcu.add_test( "26", @classlikeDoubleIntUdt.testWhileBranch )
	fbcu.add_test( "27", @classlikeDoubleIntUdt.testUntilBranch )

	fbcu.add_test( "31", @dtorOnlyIntegerUdt.testParamInit )
	fbcu.add_test( "32", @dtorOnlyIntegerUdt.testAnon )
	fbcu.add_test( "33", @dtorOnlyIntegerUdt.testResult )
	fbcu.add_test( "36", @dtorOnlyIntegerUdt.testWhileBranch )
	fbcu.add_test( "37", @dtorOnlyIntegerUdt.testUntilBranch )

	fbcu.add_test( "41", @dtorOnlyDoubleIntUdt.testParamInit )
	fbcu.add_test( "42", @dtorOnlyDoubleIntUdt.testAnon )
	fbcu.add_test( "43", @dtorOnlyDoubleIntUdt.testResult )
	fbcu.add_test( "46", @dtorOnlyDoubleIntUdt.testWhileBranch )
	fbcu.add_test( "47", @dtorOnlyDoubleIntUdt.testUntilBranch )
end sub

end namespace
