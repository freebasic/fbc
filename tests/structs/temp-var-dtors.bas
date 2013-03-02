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
		check( 2, 1, 3 )

		begin( )
			dim x as ClassUdt = test1( ClassUdt( ) )
		check( 2, 1, 3 )
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

	sub testIfBranch cdecl( )
		begin( )
			dim i as integer = 0
			if( f2( 1 ).i ) then
				i = 1
			end if
			CU_ASSERT( i = 1 )
		check( 2, 0, 2 )

		begin( )
			dim i as integer = 0
			if( f2( 0 ).i ) then
				i = 1
			end if
			CU_ASSERT( i = 0 )
		check( 2, 0, 2 )

		begin( )
			dim i as integer = 0
			if( f2( 1 ).i ) then
				i = 1
			else
				i = 2
			end if
			CU_ASSERT( i = 1 )
		check( 2, 0, 2 )

		begin( )
			dim i as integer = 0
			if( f2( 0 ).i ) then
				i = 1
			else
				i = 2
			end if
			CU_ASSERT( i = 2 )
		check( 2, 0, 2 )

		begin( )
			dim i as integer = 0
			if( f2( 123 ).i = 123 ) then
				i = 1
			end if
			CU_ASSERT( i = 1 )
		check( 2, 0, 2 )

		begin( )
			dim i as integer = 0
			if( f2( 123 ).i <> 123 ) then
				i = 1
			end if
			CU_ASSERT( i = 0 )
		check( 2, 0, 2 )

		begin( )
			dim i as integer = 0
			if( f2( 123 ).i = 123 ) then
				i = 1
			else
				i = 2
			end if
			CU_ASSERT( i = 1 )
		check( 2, 0, 2 )

		begin( )
			dim i as integer = 0
			if( f2( 123 ).i <> 123 ) then
				i = 1
			else
				i = 2
			end if
			CU_ASSERT( i = 2 )
		check( 2, 0, 2 )

		begin( )
			dim x as ClassUdt
			dim i as integer = 0
			x.i = 123
			if( x.i = f2( 123 ).i ) then
				i = 1
			end if
			CU_ASSERT( i = 1 )
		check( 3, 0, 3 )

		begin( )
			dim x as ClassUdt
			dim i as integer = 0
			x.i = 123
			if( x.i = f2( 456 ).i ) then
				i = 1
			end if
			CU_ASSERT( i = 0 )
		check( 3, 0, 3 )

		begin( )
			dim x as ClassUdt
			dim i as integer = 0
			x.i = 123
			if( x.i = f2( 123 ).i ) then
				i = 1
			else
				i = 2
			end if
			CU_ASSERT( i = 1 )
		check( 3, 0, 3 )

		begin( )
			dim x as ClassUdt
			dim i as integer = 0
			x.i = 123
			if( x.i = f2( 456 ).i ) then
				i = 1
			else
				i = 2
			end if
			CU_ASSERT( i = 2 )
		check( 3, 0, 3 )

		begin( )
			dim x as ClassUdt
			dim i as integer = 0
			x.i = 123
			if( x.i <> f2( 123 ).i ) then
				i = 1
			else
				i = 2
			end if
			CU_ASSERT( i = 2 )
		check( 3, 0, 3 )

		begin( )
			dim x as ClassUdt
			dim i as integer = 0
			x.i = 123
			if( x.i <> f2( 456 ).i ) then
				i = 1
			else
				i = 2
			end if
			CU_ASSERT( i = 1 )
		check( 3, 0, 3 )
	end sub

	sub testIifBranch cdecl( )
		begin( )
			CU_ASSERT( iif( f2( 1 ).i, 1, 2 ) = 1 )
		check( 2, 0, 2 )

		begin( )
			CU_ASSERT( iif( f2( 0 ).i, 1, 2 ) = 2 )
		check( 2, 0, 2 )

		begin( )
			dim x as ClassUdt
			x.i = 123
			CU_ASSERT( iif( x.i = f2( 123 ).i, 1, 2 ) = 1 )
		check( 3, 0, 3 )

		begin( )
			dim x as ClassUdt
			x.i = 123
			CU_ASSERT( iif( x.i = f2( 456 ).i, 1, 2 ) = 2 )
		check( 3, 0, 3 )

		begin( )
			dim x as ClassUdt
			x.i = 123
			CU_ASSERT( iif( x.i <> f2( 123 ).i, 1, 2 ) = 2 )
		check( 3, 0, 3 )

		begin( )
			dim x as ClassUdt
			x.i = 123
			CU_ASSERT( iif( x.i <> f2( 456 ).i, 1, 2 ) = 1 )
		check( 3, 0, 3 )
	end sub

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

	sub testIifUnreached cdecl( )
		begin( )
			dim as integer i = 0
			CU_ASSERT( iif( i, (type<ClassUdt>( )).i, 456 ) = 456 )
		check( 0, 0, 0 )

		begin( )
			dim as integer i = 1
			CU_ASSERT( iif( i, (type<ClassUdt>( )).i, 456 ) = 123 )
		check( 1, 0, 1 )

		begin( )
			dim as integer i = 1
			CU_ASSERT( iif( i, 456, (type<ClassUdt>( )).i ) = 456 )
		check( 0, 0, 0 )

		begin( )
			dim as integer i = 0
			CU_ASSERT( iif( i, 456, (type<ClassUdt>( )).i ) = 123 )
		check( 1, 0, 1 )

		begin( )
			dim as integer i = 0
			CU_ASSERT( iif( i, (type<ClassUdt>( )).i, (type<ClassUdt>( )).i ) = 123 )
		check( 1, 0, 1 )

		begin( )
			dim as integer i = 1
			CU_ASSERT( iif( i, (type<ClassUdt>( )).i, (type<ClassUdt>( )).i ) = 123 )
		check( 1, 0, 1 )

		begin( )
			dim as integer i = 0, j = 0
			CU_ASSERT( iif( i, iif( j, (type<ClassUdt>( )).i, 789 ), 456 ) = 456 )
		check( 0, 0, 0 )

		begin( )
			dim as integer i = 0, j = 1
			CU_ASSERT( iif( i, iif( j, (type<ClassUdt>( )).i, 789 ), 456 ) = 456 )
		check( 0, 0, 0 )

		begin( )
			dim as integer i = 1, j = 0
			CU_ASSERT( iif( i, iif( j, (type<ClassUdt>( )).i, 789 ), 456 ) = 789 )
		check( 0, 0, 0 )

		begin( )
			dim as integer i = 1, j = 1
			CU_ASSERT( iif( i, iif( j, (type<ClassUdt>( )).i, 789 ), 456 ) = 123 )
		check( 1, 0, 1 )

		begin( )
			dim as integer i = 0, j = 0
			CU_ASSERT( iif( i, iif( j, 789, (type<ClassUdt>( )).i ), 456 ) = 456 )
		check( 0, 0, 0 )

		begin( )
			dim as integer i = 0, j = 1
			CU_ASSERT( iif( i, iif( j, 789, (type<ClassUdt>( )).i ), 456 ) = 456 )
		check( 0, 0, 0 )

		begin( )
			dim as integer i = 1, j = 1
			CU_ASSERT( iif( i, iif( j, 789, (type<ClassUdt>( )).i ), 456 ) = 789 )
		check( 0, 0, 0 )

		begin( )
			dim as integer i = 1, j = 0
			CU_ASSERT( iif( i, iif( j, 789, (type<ClassUdt>( )).i ), 456 ) = 123 )
		check( 1, 0, 1 )

		begin( )
			dim as integer i = 0, j = 0
			CU_ASSERT( iif( i, _
					(type<ClassUdt>( )).i + iif( j, _
									789, _
									(type<ClassUdt>( )).i ), _
					456 ) = 456 )
		check( 0, 0, 0 )

		begin( )
			dim as integer i = 0, j = 1
			CU_ASSERT( iif( i, _
					(type<ClassUdt>( )).i + iif( j, _
									789, _
									(type<ClassUdt>( )).i ), _
					456 ) = 456 )
		check( 0, 0, 0 )

		begin( )
			dim as integer i = 1, j = 1
			CU_ASSERT( iif( i, _
					(type<ClassUdt>( )).i + iif( j, _
									789, _
									(type<ClassUdt>( )).i ), _
					456 ) = 123 + 789 )
		check( 1, 0, 1 )

		begin( )
			dim as integer i = 1, j = 0
			CU_ASSERT( iif( i, _
					(type<ClassUdt>( )).i + iif( j, _
									789, _
									(type<ClassUdt>( )).i ), _
					456 ) = 123 + 123 )
		check( 2, 0, 2 )

		begin( )
			dim as integer i = 1, j = 0
			CU_ASSERT( iif( i, _
					456, _
					(type<ClassUdt>( )).i + iif( j, _
									(type<ClassUdt>( )).i, _
									789 ) ) = 456 )
		check( 0, 0, 0 )

		begin( )
			dim as integer i = 1, j = 1
			CU_ASSERT( iif( i, _
					456, _
					(type<ClassUdt>( )).i + iif( j, _
									(type<ClassUdt>( )).i, _
									789 ) ) = 456 )
		check( 0, 0, 0 )

		begin( )
			dim as integer i = 0, j = 0
			CU_ASSERT( iif( i, _
					456, _
					(type<ClassUdt>( )).i + iif( j, _
									(type<ClassUdt>( )).i, _
									789 ) ) = 123 + 789 )
		check( 1, 0, 1 )

		begin( )
			dim as integer i = 0, j = 1
			CU_ASSERT( iif( i, _
					456, _
					(type<ClassUdt>( )).i + iif( j, _
									(type<ClassUdt>( )).i, _
									789 ) ) = 123 + 123 )
		check( 2, 0, 2 )
	end sub

	sub testAndAlsoUnreached cdecl( )
		begin( )
			dim as integer i = 0
			CU_ASSERT( (i andalso (type<ClassUdt>( )).i) = 0 )
		check( 0, 0, 0 )

		begin( )
			dim as integer i = 1
			CU_ASSERT( (i andalso (type<ClassUdt>( )).i) = -1 )
		check( 1, 0, 1 )

		begin( )
			dim as integer i = 0, j = 0
			CU_ASSERT( (i andalso (j andalso (type<ClassUdt>( )).i)) = 0 )
		check( 0, 0, 0 )

		begin( )
			dim as integer i = 1, j = 0
			CU_ASSERT( (i andalso (j andalso (type<ClassUdt>( )).i)) = 0 )
		check( 0, 0, 0 )

		begin( )
			dim as integer i = 1, j = 1
			CU_ASSERT( (i andalso (j andalso (type<ClassUdt>( )).i)) = -1 )
		check( 1, 0, 1 )

		begin( )
			dim as integer i = 0
			CU_ASSERT( ((type<ClassUdt>( )).i andalso i) = -1 )
		check( 1, 0, 1 )

		begin( )
			dim as integer i = 1
			CU_ASSERT( ((type<ClassUdt>( )).i andalso i) = -1 )
		check( 1, 0, 1 )

		begin( )
			dim as integer i = 0, j = 0
			CU_ASSERT( ((j andalso (type<ClassUdt>( )).i) andalso i) = 0 )
		check( 0, 0, 0 )

		begin( )
			dim as integer i = 1, j = 0
			CU_ASSERT( ((j andalso (type<ClassUdt>( )).i) andalso i) = 0 )
		check( 0, 0, 0 )

		begin( )
			dim as integer i = 0, j = 1
			CU_ASSERT( ((j andalso (type<ClassUdt>( )).i) andalso i) = 0 )
		check( 1, 0, 1 )

		begin( )
			dim as integer i = 1, j = 1
			CU_ASSERT( ((j andalso (type<ClassUdt>( )).i) andalso i) = -1 )
		check( 1, 0, 1 )
	end sub

	sub testOrElseUnreached cdecl( )
		begin( )
			dim as integer i = 1
			CU_ASSERT( (i orelse (type<ClassUdt>( )).i) = -1 )
		check( 0, 0, 0 )

		begin( )
			dim as integer i = 0
			CU_ASSERT( (i orelse (type<ClassUdt>( )).i) = -1 )
		check( 1, 0, 1 )

		begin( )
			dim as integer i = 1, j = 1
			CU_ASSERT( (i orelse (j orelse (type<ClassUdt>( )).i)) = -1 )
		check( 0, 0, 0 )

		begin( )
			dim as integer i = 1, j = 0
			CU_ASSERT( (i orelse (j orelse (type<ClassUdt>( )).i)) = -1 )
		check( 0, 0, 0 )

		begin( )
			dim as integer i = 0, j = 0
			CU_ASSERT( (i orelse (j orelse (type<ClassUdt>( )).i)) = -1 )
		check( 1, 0, 1 )

		begin( )
			dim as integer i = 0
			CU_ASSERT( ((type<ClassUdt>( )).i orelse i) = -1 )
		check( 1, 0, 1 )

		begin( )
			dim as integer i = 1
			CU_ASSERT( ((type<ClassUdt>( )).i orelse i) = -1 )
		check( 1, 0, 1 )

		begin( )
			dim as integer i = 0, j = 1
			CU_ASSERT( ((j orelse (type<ClassUdt>( )).i) orelse i) = -1 )
		check( 0, 0, 0 )

		begin( )
			dim as integer i = 1, j = 1
			CU_ASSERT( ((j orelse (type<ClassUdt>( )).i) orelse i) = -1 )
		check( 0, 0, 0 )

		begin( )
			dim as integer i = 0, j = 0
			CU_ASSERT( ((j orelse (type<ClassUdt>( )).i) orelse i) = -1 )
		check( 1, 0, 1 )

		begin( )
			dim as integer i = 1, j = 0
			CU_ASSERT( ((j orelse (type<ClassUdt>( )).i) orelse i) = -1 )
		check( 1, 0, 1 )
	end sub

	sub testIifTempVar cdecl( )
		begin( )
			dim as ClassUdt a, b
			dim i as integer = 0
			a.i = 123
			b.i = 456
			a = iif( i, a, b )
			CU_ASSERT( a.i = 456 )
		check( 2, 1, 3 )

		begin( )
			dim as ClassUdt a, b
			dim i as integer = 1
			a.i = 123
			b.i = 456
			a = iif( i, a, b )
			CU_ASSERT( a.i = 123 )
		check( 2, 1, 3 )
	end sub

	sub testIifTrueFalseExpressions cdecl( )
		dim c as integer

		begin( ) : c = -1 : CU_ASSERT( iif(  c, (ClassUdt( )).i, (ClassUdt( )).i ) = 123 ) : check( 1, 0, 1 )
		begin( ) : c =  0 : CU_ASSERT( iif(  c, (ClassUdt( )).i, (ClassUdt( )).i ) = 123 ) : check( 1, 0, 1 )

		begin( ) : c = -1 : CU_ASSERT( (iif(  c, ClassUdt( ), ClassUdt( ) )).i = 123 ) : check( 1, 0, 1 )
		begin( ) : c =  0 : CU_ASSERT( (iif(  c, ClassUdt( ), ClassUdt( ) )).i = 123 ) : check( 1, 0, 1 )
	end sub

	sub hPassByval( byval x as ClassUdt )
	end sub

	sub testByval cdecl( )
		begin( )
			dim x as ClassUdt
			hPassByval( x )
		check( 1, 1, 2 )

		begin( )
			hPassByval( ClassUdt( ) )
		check( 1, 0, 1 )

		begin( )
			hPassByval( type( ) )
		check( 1, 0, 1 )

		begin( )
			hPassByval( type<ClassUdt>( ) )
		check( 1, 0, 1 )
	end sub

	sub hPassByref( byref x as ClassUdt )
	end sub

	sub testByref cdecl( )
		begin( )
			dim x as ClassUdt
			hPassByref( x )
		check( 1, 0, 1 )

		begin( )
			hPassByref( ClassUdt( ) )
		check( 1, 0, 1 )

		begin( )
			hPassByref( type( ) )
		check( 1, 0, 1 )

		begin( )
			hPassByref( type<ClassUdt>( ) )
		check( 1, 0, 1 )
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
		check( 2, 1, 3 )

		begin( )
			dim x as ClassUdt = test1( ClassUdt( ) )
		check( 2, 1, 3 )
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

	sub testIfBranch cdecl( )
		begin( )
			dim i as integer = 0
			if( f2( 1 ).i ) then
				i = 1
			end if
			CU_ASSERT( i = 1 )
		check( 2, 0, 2 )

		begin( )
			dim i as integer = 0
			if( f2( 0 ).i ) then
				i = 1
			end if
			CU_ASSERT( i = 0 )
		check( 2, 0, 2 )

		begin( )
			dim i as integer = 0
			if( f2( 1 ).i ) then
				i = 1
			else
				i = 2
			end if
			CU_ASSERT( i = 1 )
		check( 2, 0, 2 )

		begin( )
			dim i as integer = 0
			if( f2( 0 ).i ) then
				i = 1
			else
				i = 2
			end if
			CU_ASSERT( i = 2 )
		check( 2, 0, 2 )

		begin( )
			dim i as integer = 0
			if( f2( 123 ).i = 123 ) then
				i = 1
			end if
			CU_ASSERT( i = 1 )
		check( 2, 0, 2 )

		begin( )
			dim i as integer = 0
			if( f2( 123 ).i <> 123 ) then
				i = 1
			end if
			CU_ASSERT( i = 0 )
		check( 2, 0, 2 )

		begin( )
			dim i as integer = 0
			if( f2( 123 ).i = 123 ) then
				i = 1
			else
				i = 2
			end if
			CU_ASSERT( i = 1 )
		check( 2, 0, 2 )

		begin( )
			dim i as integer = 0
			if( f2( 123 ).i <> 123 ) then
				i = 1
			else
				i = 2
			end if
			CU_ASSERT( i = 2 )
		check( 2, 0, 2 )

		begin( )
			dim x as ClassUdt
			dim i as integer = 0
			x.i = 123
			if( x.i = f2( 123 ).i ) then
				i = 1
			end if
			CU_ASSERT( i = 1 )
		check( 3, 0, 3 )

		begin( )
			dim x as ClassUdt
			dim i as integer = 0
			x.i = 123
			if( x.i = f2( 456 ).i ) then
				i = 1
			end if
			CU_ASSERT( i = 0 )
		check( 3, 0, 3 )

		begin( )
			dim x as ClassUdt
			dim i as integer = 0
			x.i = 123
			if( x.i = f2( 123 ).i ) then
				i = 1
			else
				i = 2
			end if
			CU_ASSERT( i = 1 )
		check( 3, 0, 3 )

		begin( )
			dim x as ClassUdt
			dim i as integer = 0
			x.i = 123
			if( x.i = f2( 456 ).i ) then
				i = 1
			else
				i = 2
			end if
			CU_ASSERT( i = 2 )
		check( 3, 0, 3 )

		begin( )
			dim x as ClassUdt
			dim i as integer = 0
			x.i = 123
			if( x.i <> f2( 123 ).i ) then
				i = 1
			else
				i = 2
			end if
			CU_ASSERT( i = 2 )
		check( 3, 0, 3 )

		begin( )
			dim x as ClassUdt
			dim i as integer = 0
			x.i = 123
			if( x.i <> f2( 456 ).i ) then
				i = 1
			else
				i = 2
			end if
			CU_ASSERT( i = 1 )
		check( 3, 0, 3 )
	end sub

	sub testIifBranch cdecl( )
		begin( )
			CU_ASSERT( iif( f2( 1 ).i, 1, 2 ) = 1 )
		check( 2, 0, 2 )

		begin( )
			CU_ASSERT( iif( f2( 0 ).i, 1, 2 ) = 2 )
		check( 2, 0, 2 )

		begin( )
			dim x as ClassUdt
			x.i = 123
			CU_ASSERT( iif( x.i = f2( 123 ).i, 1, 2 ) = 1 )
		check( 3, 0, 3 )

		begin( )
			dim x as ClassUdt
			x.i = 123
			CU_ASSERT( iif( x.i = f2( 456 ).i, 1, 2 ) = 2 )
		check( 3, 0, 3 )

		begin( )
			dim x as ClassUdt
			x.i = 123
			CU_ASSERT( iif( x.i <> f2( 123 ).i, 1, 2 ) = 2 )
		check( 3, 0, 3 )

		begin( )
			dim x as ClassUdt
			x.i = 123
			CU_ASSERT( iif( x.i <> f2( 456 ).i, 1, 2 ) = 1 )
		check( 3, 0, 3 )
	end sub

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

	sub testIifTempVar cdecl( )
		begin( )
			dim as ClassUdt a, b
			dim i as integer = 0
			a.i = 123
			b.i = 456
			a = iif( i, a, b )
			CU_ASSERT( a.i = 456 )
		check( 2, 1, 3 )

		begin( )
			dim as ClassUdt a, b
			dim i as integer = 1
			a.i = 123
			b.i = 456
			a = iif( i, a, b )
			CU_ASSERT( a.i = 123 )
		check( 2, 1, 3 )
	end sub

	sub testIifTrueFalseExpressions cdecl( )
		dim c as integer

		begin( ) : c = -1 : CU_ASSERT( iif(  c, (ClassUdt( )).i, (ClassUdt( )).j ) = 123 ) : check( 1, 0, 1 )
		begin( ) : c = -1 : CU_ASSERT( iif(  c, (ClassUdt( )).j, (ClassUdt( )).i ) = 456 ) : check( 1, 0, 1 )
		begin( ) : c =  0 : CU_ASSERT( iif(  c, (ClassUdt( )).i, (ClassUdt( )).j ) = 456 ) : check( 1, 0, 1 )
		begin( ) : c =  0 : CU_ASSERT( iif(  c, (ClassUdt( )).j, (ClassUdt( )).i ) = 123 ) : check( 1, 0, 1 )

		begin( ) : c = -1 : CU_ASSERT( (iif(  c, ClassUdt( ), ClassUdt( ) )).i = 123 ) : check( 1, 0, 1 )
		begin( ) : c = -1 : CU_ASSERT( (iif(  c, ClassUdt( ), ClassUdt( ) )).j = 456 ) : check( 1, 0, 1 )
		begin( ) : c =  0 : CU_ASSERT( (iif(  c, ClassUdt( ), ClassUdt( ) )).i = 123 ) : check( 1, 0, 1 )
		begin( ) : c =  0 : CU_ASSERT( (iif(  c, ClassUdt( ), ClassUdt( ) )).j = 456 ) : check( 1, 0, 1 )
	end sub

	sub hPassByval( byval x as ClassUdt )
	end sub

	sub testByval cdecl( )
		begin( )
			dim x as ClassUdt
			hPassByval( x )
		check( 1, 1, 2 )

		begin( )
			hPassByval( ClassUdt( ) )
		check( 1, 0, 1 )

		begin( )
			hPassByval( type( ) )
		check( 1, 0, 1 )

		begin( )
			hPassByval( type<ClassUdt>( ) )
		check( 1, 0, 1 )
	end sub

	sub hPassByref( byref x as ClassUdt )
	end sub

	sub testByref cdecl( )
		begin( )
			dim x as ClassUdt
			hPassByref( x )
		check( 1, 0, 1 )

		begin( )
			hPassByref( ClassUdt( ) )
		check( 1, 0, 1 )

		begin( )
			hPassByref( type( ) )
		check( 1, 0, 1 )

		begin( )
			hPassByref( type<ClassUdt>( ) )
		check( 1, 0, 1 )
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
		check( 3, 0, 3 )

		begin( )
			dim x as DtorUdt = test1( type<DtorUdt>( 123 ) )
		check( 3, 0, 3 )
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

	sub testIfBranch cdecl( )
		begin( )
			dim i as integer = 0
			if( f2( 1 ).i ) then
				i = 1
			end if
			CU_ASSERT( i = 1 )
		check( 2, 0, 2 )

		begin( )
			dim i as integer = 0
			if( f2( 0 ).i ) then
				i = 1
			end if
			CU_ASSERT( i = 0 )
		check( 2, 0, 2 )

		begin( )
			dim i as integer = 0
			if( f2( 1 ).i ) then
				i = 1
			else
				i = 2
			end if
			CU_ASSERT( i = 1 )
		check( 2, 0, 2 )

		begin( )
			dim i as integer = 0
			if( f2( 0 ).i ) then
				i = 1
			else
				i = 2
			end if
			CU_ASSERT( i = 2 )
		check( 2, 0, 2 )

		begin( )
			dim i as integer = 0
			if( f2( 123 ).i = 123 ) then
				i = 1
			end if
			CU_ASSERT( i = 1 )
		check( 2, 0, 2 )

		begin( )
			dim i as integer = 0
			if( f2( 123 ).i <> 123 ) then
				i = 1
			end if
			CU_ASSERT( i = 0 )
		check( 2, 0, 2 )

		begin( )
			dim i as integer = 0
			if( f2( 123 ).i = 123 ) then
				i = 1
			else
				i = 2
			end if
			CU_ASSERT( i = 1 )
		check( 2, 0, 2 )

		begin( )
			dim i as integer = 0
			if( f2( 123 ).i <> 123 ) then
				i = 1
			else
				i = 2
			end if
			CU_ASSERT( i = 2 )
		check( 2, 0, 2 )

		begin( )
			dim x as DtorUdt
			dim i as integer = 0
			x.i = 123
			if( x.i = f2( 123 ).i ) then
				i = 1
			end if
			CU_ASSERT( i = 1 )
		check( 3, 0, 3 )

		begin( )
			dim x as DtorUdt
			dim i as integer = 0
			x.i = 123
			if( x.i = f2( 456 ).i ) then
				i = 1
			end if
			CU_ASSERT( i = 0 )
		check( 3, 0, 3 )

		begin( )
			dim x as DtorUdt
			dim i as integer = 0
			x.i = 123
			if( x.i = f2( 123 ).i ) then
				i = 1
			else
				i = 2
			end if
			CU_ASSERT( i = 1 )
		check( 3, 0, 3 )

		begin( )
			dim x as DtorUdt
			dim i as integer = 0
			x.i = 123
			if( x.i = f2( 456 ).i ) then
				i = 1
			else
				i = 2
			end if
			CU_ASSERT( i = 2 )
		check( 3, 0, 3 )

		begin( )
			dim x as DtorUdt
			dim i as integer = 0
			x.i = 123
			if( x.i <> f2( 123 ).i ) then
				i = 1
			else
				i = 2
			end if
			CU_ASSERT( i = 2 )
		check( 3, 0, 3 )

		begin( )
			dim x as DtorUdt
			dim i as integer = 0
			x.i = 123
			if( x.i <> f2( 456 ).i ) then
				i = 1
			else
				i = 2
			end if
			CU_ASSERT( i = 1 )
		check( 3, 0, 3 )
	end sub

	sub testIifBranch cdecl( )
		begin( )
			CU_ASSERT( iif( f2( 1 ).i, 1, 2 ) = 1 )
		check( 2, 0, 2 )

		begin( )
			CU_ASSERT( iif( f2( 0 ).i, 1, 2 ) = 2 )
		check( 2, 0, 2 )

		begin( )
			dim x as DtorUdt
			x.i = 123
			CU_ASSERT( iif( x.i = f2( 123 ).i, 1, 2 ) = 1 )
		check( 3, 0, 3 )

		begin( )
			dim x as DtorUdt
			x.i = 123
			CU_ASSERT( iif( x.i = f2( 456 ).i, 1, 2 ) = 2 )
		check( 3, 0, 3 )

		begin( )
			dim x as DtorUdt
			x.i = 123
			CU_ASSERT( iif( x.i <> f2( 123 ).i, 1, 2 ) = 2 )
		check( 3, 0, 3 )

		begin( )
			dim x as DtorUdt
			x.i = 123
			CU_ASSERT( iif( x.i <> f2( 456 ).i, 1, 2 ) = 1 )
		check( 3, 0, 3 )
	end sub

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

	sub testIifTempVar cdecl( )
		begin( )
			dim as DtorUdt a, b
			dim i as integer = 0
			a.i = 123
			b.i = 456
			a = iif( i, a, b )
			CU_ASSERT( a.i = 456 )
		check( 3, 0, 3 )

		begin( )
			dim as DtorUdt a, b
			dim i as integer = 1
			a.i = 123
			b.i = 456
			a = iif( i, a, b )
			CU_ASSERT( a.i = 123 )
		check( 3, 0, 3 )
	end sub

	sub testIifTrueFalseExpressions cdecl( )
		dim c as integer

		begin( ) : c = -1 : CU_ASSERT( iif(  c, (type<DtorUdt>( 1 )).i, (type<DtorUdt>( 2 )).i ) = 1 ) : check( 1, 0, 1 )
		begin( ) : c =  0 : CU_ASSERT( iif(  c, (type<DtorUdt>( 1 )).i, (type<DtorUdt>( 2 )).i ) = 2 ) : check( 1, 0, 1 )

		begin( ) : c = -1 : CU_ASSERT( (iif(  c, type<DtorUdt>( 1 ), type<DtorUdt>( 2 ) )).i = 1 ) : check( 2, 0, 2 )
		begin( ) : c =  0 : CU_ASSERT( (iif(  c, type<DtorUdt>( 1 ), type<DtorUdt>( 2 ) )).i = 2 ) : check( 2, 0, 2 )
	end sub

	sub hPassByval( byval x as DtorUdt )
	end sub

	sub testByval cdecl( )
		begin( )
			dim x as DtorUdt
			hPassByval( x )
		check( 2, 0, 2 )

		begin( )
			hPassByval( type( 123 ) )
		check( 1, 0, 1 )

		begin( )
			hPassByval( type<DtorUdt>( 123 ) )
		check( 1, 0, 1 )
	end sub

	sub hPassByref( byref x as DtorUdt )
	end sub

	sub testByref cdecl( )
		begin( )
			dim x as DtorUdt
			hPassByref( x )
		check( 1, 0, 1 )

		begin( )
			hPassByref( type( 123 ) )
		check( 1, 0, 1 )

		begin( )
			hPassByref( type<DtorUdt>( 123 ) )
		check( 1, 0, 1 )
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
		check( 3, 0, 3 )

		begin( )
			dim x as DtorUdt = test1( type<DtorUdt>( 123 ) )
		check( 3, 0, 3 )
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

	sub testIfBranch cdecl( )
		begin( )
			dim i as integer = 0
			if( f2( 1 ).i ) then
				i = 1
			end if
			CU_ASSERT( i = 1 )
		check( 2, 0, 2 )

		begin( )
			dim i as integer = 0
			if( f2( 0 ).i ) then
				i = 1
			end if
			CU_ASSERT( i = 0 )
		check( 2, 0, 2 )

		begin( )
			dim i as integer = 0
			if( f2( 1 ).i ) then
				i = 1
			else
				i = 2
			end if
			CU_ASSERT( i = 1 )
		check( 2, 0, 2 )

		begin( )
			dim i as integer = 0
			if( f2( 0 ).i ) then
				i = 1
			else
				i = 2
			end if
			CU_ASSERT( i = 2 )
		check( 2, 0, 2 )

		begin( )
			dim i as integer = 0
			if( f2( 123 ).i = 123 ) then
				i = 1
			end if
			CU_ASSERT( i = 1 )
		check( 2, 0, 2 )

		begin( )
			dim i as integer = 0
			if( f2( 123 ).i <> 123 ) then
				i = 1
			end if
			CU_ASSERT( i = 0 )
		check( 2, 0, 2 )

		begin( )
			dim i as integer = 0
			if( f2( 123 ).i = 123 ) then
				i = 1
			else
				i = 2
			end if
			CU_ASSERT( i = 1 )
		check( 2, 0, 2 )

		begin( )
			dim i as integer = 0
			if( f2( 123 ).i <> 123 ) then
				i = 1
			else
				i = 2
			end if
			CU_ASSERT( i = 2 )
		check( 2, 0, 2 )

		begin( )
			dim x as DtorUdt
			dim i as integer = 0
			x.i = 123
			if( x.i = f2( 123 ).i ) then
				i = 1
			end if
			CU_ASSERT( i = 1 )
		check( 3, 0, 3 )

		begin( )
			dim x as DtorUdt
			dim i as integer = 0
			x.i = 123
			if( x.i = f2( 456 ).i ) then
				i = 1
			end if
			CU_ASSERT( i = 0 )
		check( 3, 0, 3 )

		begin( )
			dim x as DtorUdt
			dim i as integer = 0
			x.i = 123
			if( x.i = f2( 123 ).i ) then
				i = 1
			else
				i = 2
			end if
			CU_ASSERT( i = 1 )
		check( 3, 0, 3 )

		begin( )
			dim x as DtorUdt
			dim i as integer = 0
			x.i = 123
			if( x.i = f2( 456 ).i ) then
				i = 1
			else
				i = 2
			end if
			CU_ASSERT( i = 2 )
		check( 3, 0, 3 )

		begin( )
			dim x as DtorUdt
			dim i as integer = 0
			x.i = 123
			if( x.i <> f2( 123 ).i ) then
				i = 1
			else
				i = 2
			end if
			CU_ASSERT( i = 2 )
		check( 3, 0, 3 )

		begin( )
			dim x as DtorUdt
			dim i as integer = 0
			x.i = 123
			if( x.i <> f2( 456 ).i ) then
				i = 1
			else
				i = 2
			end if
			CU_ASSERT( i = 1 )
		check( 3, 0, 3 )
	end sub

	sub testIifBranch cdecl( )
		begin( )
			CU_ASSERT( iif( f2( 1 ).i, 1, 2 ) = 1 )
		check( 2, 0, 2 )

		begin( )
			CU_ASSERT( iif( f2( 0 ).i, 1, 2 ) = 2 )
		check( 2, 0, 2 )

		begin( )
			dim x as DtorUdt
			x.i = 123
			CU_ASSERT( iif( x.i = f2( 123 ).i, 1, 2 ) = 1 )
		check( 3, 0, 3 )

		begin( )
			dim x as DtorUdt
			x.i = 123
			CU_ASSERT( iif( x.i = f2( 456 ).i, 1, 2 ) = 2 )
		check( 3, 0, 3 )

		begin( )
			dim x as DtorUdt
			x.i = 123
			CU_ASSERT( iif( x.i <> f2( 123 ).i, 1, 2 ) = 2 )
		check( 3, 0, 3 )

		begin( )
			dim x as DtorUdt
			x.i = 123
			CU_ASSERT( iif( x.i <> f2( 456 ).i, 1, 2 ) = 1 )
		check( 3, 0, 3 )
	end sub

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

	sub testIifTempVar cdecl( )
		begin( )
			dim as DtorUdt a, b
			dim i as integer = 0
			a.i = 123
			b.i = 456
			a = iif( i, a, b )
			CU_ASSERT( a.i = 456 )
		check( 3, 0, 3 )

		begin( )
			dim as DtorUdt a, b
			dim i as integer = 1
			a.i = 123
			b.i = 456
			a = iif( i, a, b )
			CU_ASSERT( a.i = 123 )
		check( 3, 0, 3 )
	end sub

	sub testIifTrueFalseExpressions cdecl( )
		dim c as integer

		begin( ) : c = -1 : CU_ASSERT( iif(  c, (type<DtorUdt>( 1, 11 )).i, (type<DtorUdt>( 2, 22 )).j ) =  1 ) : check( 1, 0, 1 )
		begin( ) : c = -1 : CU_ASSERT( iif(  c, (type<DtorUdt>( 1, 11 )).j, (type<DtorUdt>( 2, 22 )).i ) = 11 ) : check( 1, 0, 1 )
		begin( ) : c =  0 : CU_ASSERT( iif(  c, (type<DtorUdt>( 1, 11 )).i, (type<DtorUdt>( 2, 22 )).j ) = 22 ) : check( 1, 0, 1 )
		begin( ) : c =  0 : CU_ASSERT( iif(  c, (type<DtorUdt>( 1, 11 )).j, (type<DtorUdt>( 2, 22 )).i ) =  2 ) : check( 1, 0, 1 )

		begin( ) : c = -1 : CU_ASSERT( (iif(  c, type<DtorUdt>( 1, 11 ), type<DtorUdt>( 2, 22 ) )).i =  1 ) : check( 2, 0, 2 )
		begin( ) : c = -1 : CU_ASSERT( (iif(  c, type<DtorUdt>( 1, 11 ), type<DtorUdt>( 2, 22 ) )).j = 11 ) : check( 2, 0, 2 )
		begin( ) : c =  0 : CU_ASSERT( (iif(  c, type<DtorUdt>( 1, 11 ), type<DtorUdt>( 2, 22 ) )).i =  2 ) : check( 2, 0, 2 )
		begin( ) : c =  0 : CU_ASSERT( (iif(  c, type<DtorUdt>( 1, 11 ), type<DtorUdt>( 2, 22 ) )).j = 22 ) : check( 2, 0, 2 )
	end sub

	sub hPassByval( byval x as DtorUdt )
	end sub

	sub testByval cdecl( )
		begin( )
			dim x as DtorUdt
			hPassByval( x )
		check( 2, 0, 2 )

		begin( )
			hPassByval( type( 123 ) )
		check( 1, 0, 1 )

		begin( )
			hPassByval( type<DtorUdt>( 123 ) )
		check( 1, 0, 1 )
	end sub

	sub hPassByref( byref x as DtorUdt )
	end sub

	sub testByref cdecl( )
		begin( )
			dim x as DtorUdt
			hPassByref( x )
		check( 1, 0, 1 )

		begin( )
			hPassByref( type( 123 ) )
		check( 1, 0, 1 )

		begin( )
			hPassByref( type<DtorUdt>( 123 ) )
		check( 1, 0, 1 )
	end sub
end namespace

private sub ctor( ) constructor
	fbcu.add_suite( "tests/structs/temp-var-dtors" )

	#macro add( t )
		fbcu.add_test( #t, @t )
	#endmacro

	add( classlikeIntegerUdt.testParamInit )
	add( classlikeIntegerUdt.testAnon )
	add( classlikeIntegerUdt.testResult )
	add( classlikeIntegerUdt.testIfBranch )
	add( classlikeIntegerUdt.testIifBranch )
	add( classlikeIntegerUdt.testWhileBranch )
	add( classlikeIntegerUdt.testUntilBranch )
	add( classlikeIntegerUdt.testIifTempVar )
	add( classlikeIntegerUdt.testIifTrueFalseExpressions )
	add( classlikeIntegerUdt.testByval )
	add( classlikeIntegerUdt.testByref )

	add( classlikeDoubleIntUdt.testParamInit )
	add( classlikeDoubleIntUdt.testAnon )
	add( classlikeDoubleIntUdt.testResult )
	add( classlikeDoubleIntUdt.testIfBranch )
	add( classlikeDoubleIntUdt.testIifBranch )
	add( classlikeDoubleIntUdt.testWhileBranch )
	add( classlikeDoubleIntUdt.testUntilBranch )
	add( classlikeDoubleIntUdt.testIifTempVar )
	add( classlikeDoubleIntUdt.testIifTrueFalseExpressions )
	add( classlikeDoubleIntUdt.testByval )
	add( classlikeDoubleIntUdt.testByref )

	add( dtorOnlyIntegerUdt.testParamInit )
	add( dtorOnlyIntegerUdt.testAnon )
	add( dtorOnlyIntegerUdt.testResult )
	add( dtorOnlyIntegerUdt.testIfBranch )
	add( dtorOnlyIntegerUdt.testIifBranch )
	add( dtorOnlyIntegerUdt.testWhileBranch )
	add( dtorOnlyIntegerUdt.testUntilBranch )
	add( dtorOnlyIntegerUdt.testIifTempVar )
	add( dtorOnlyIntegerUdt.testIifTrueFalseExpressions )
	add( dtorOnlyIntegerUdt.testByval )
	add( dtorOnlyIntegerUdt.testByref )

	add( dtorOnlyDoubleIntUdt.testParamInit )
	add( dtorOnlyDoubleIntUdt.testAnon )
	add( dtorOnlyDoubleIntUdt.testResult )
	add( dtorOnlyDoubleIntUdt.testIfBranch )
	add( dtorOnlyDoubleIntUdt.testIifBranch )
	add( dtorOnlyDoubleIntUdt.testWhileBranch )
	add( dtorOnlyDoubleIntUdt.testUntilBranch )
	add( dtorOnlyDoubleIntUdt.testIifTempVar )
	add( dtorOnlyDoubleIntUdt.testIifTrueFalseExpressions )
	add( dtorOnlyDoubleIntUdt.testByval )
	add( dtorOnlyDoubleIntUdt.testByref )
end sub

end namespace
