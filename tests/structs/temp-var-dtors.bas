#include "fbcunit.bi"

SUITE( fbc_tests.structs.temp_var_dtors )

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

	TEST_GROUP( classlikeIntegerUdt )
		type ClassUdt
			i as integer

			declare constructor( )
			declare constructor( byref as ClassUdt )
			declare destructor( )

			const CONST1 = 1
			static staticvar1 as integer
			declare static sub staticsub1( )
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

		dim shared ClassUdt.staticvar1 as integer = 1
		static sub ClassUdt.staticsub1( )
		end sub

		function test1( byval x as ClassUdt ) as ClassUdt
			function = x
		end function

		sub test2( byval x as ClassUdt = test1( ClassUdt( ) ) )
		end sub

		TEST( testParamInit )
			begin( )
				test2( )
			check( 2, 1, 3 )

			begin( )
				dim x as ClassUdt = test1( ClassUdt( ) )
			check( 2, 1, 3 )
		END_TEST

		TEST( testAnon )
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
		END_TEST

		function f1( ) as ClassUdt
			function = type( )
		end function

		TEST( testResult )
			begin( )
				CU_ASSERT( f1( ).i = 123 )
			check( 2, 0, 2 )
		END_TEST

		function f2( byval i as integer ) as ClassUdt
			dim x as ClassUdt
			x.i = i
			function = x
		end function

		TEST( testIfBranch )
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

			begin( )
				dim i as integer = 0
				if( (ClassUdt( )).i = 123 ) then
					i = 1
				else
					i = 2
				end if
				CU_ASSERT( i = 1 )
			check( 1, 0, 1 )

			begin( )
				dim i as integer = 0
				if( (ClassUdt( )).i = 0 ) then
					i = 1
				else
					i = 2
				end if
				CU_ASSERT( i = 2 )
			check( 1, 0, 1 )
		END_TEST

		TEST( testIifBranch )
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
		END_TEST

		TEST( testWhileBranch )
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
		END_TEST

		TEST( testUntilBranch )
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
		END_TEST

		TEST( testIifUnreached )
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
		END_TEST

		TEST( testAndAlsoUnreached )
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
				CU_ASSERT( ((type<ClassUdt>( )).i andalso i) = 0 )
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
		END_TEST

		TEST( testOrElseUnreached )
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
		END_TEST

		TEST( testIifTempVar )
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
		END_TEST

		TEST( testIifTrueFalseExpressions )
			dim c as integer

			begin( ) : c = -1 : CU_ASSERT( iif(  c, (ClassUdt( )).i, (ClassUdt( )).i ) = 123 ) : check( 1, 0, 1 )
			begin( ) : c =  0 : CU_ASSERT( iif(  c, (ClassUdt( )).i, (ClassUdt( )).i ) = 123 ) : check( 1, 0, 1 )

			begin( ) : c = -1 : CU_ASSERT( (iif(  c, ClassUdt( ), ClassUdt( ) )).i = 123 ) : check( 1, 0, 1 )
			begin( ) : c =  0 : CU_ASSERT( (iif(  c, ClassUdt( ), ClassUdt( ) )).i = 123 ) : check( 1, 0, 1 )

			begin( ) : CU_ASSERT( iif( -1, (ClassUdt( )).i, (ClassUdt( )).i ) = 123 ) : check( 1, 0, 1 )
			begin( ) : CU_ASSERT( iif(  0, (ClassUdt( )).i, (ClassUdt( )).i ) = 123 ) : check( 1, 0, 1 )

			begin( ) : CU_ASSERT( (iif( -1, ClassUdt( ), ClassUdt( ) )).i = 123 ) : check( 1, 0, 1 )
			begin( ) : CU_ASSERT( (iif(  0, ClassUdt( ), ClassUdt( ) )).i = 123 ) : check( 1, 0, 1 )
		END_TEST

		sub hPassByval( byval x as ClassUdt )
		end sub

		TEST( testByval )
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
		END_TEST

		sub hPassByref( byref x as ClassUdt )
		end sub

		TEST( testByref )
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
		END_TEST

		function fByvalUdtToInt( byval x as ClassUdt ) as integer
			function = x.i
		end function

		function fByrefUdtToInt( byref x as ClassUdt ) as integer
			function = x.i
		end function

		function fByvalUdtToStr( byval x as ClassUdt ) as string
			function = str( x.i )
		end function

		function fByrefUdtToStr( byref x as ClassUdt ) as string
			function = str( x.i )
		end function

		TEST( testTypeof )
			dim c as integer = -1

			begin( )
				dim i as typeof( fByvalUdtToInt( ClassUdt( ) ) )
			check( 0, 0, 0 )

			begin( )
				dim i as typeof( fByrefUdtToInt( ClassUdt( ) ) )
			check( 0, 0, 0 )

			begin( )
				dim i as typeof( fByvalUdtToInt( iif( c, ClassUdt( ), ClassUdt( ) ) ) )
			check( 0, 0, 0 )

			begin( )
				dim i as typeof( fByrefUdtToInt( iif( c, ClassUdt( ), ClassUdt( ) ) ) )
			check( 0, 0, 0 )

			begin( )
				dim x as typeof( ClassUdt( ) )
			check( 1, 0, 1 )

			begin( )
				dim x as typeof( iif( c, ClassUdt( ), ClassUdt( ) ) )
			check( 1, 0, 1 )
		END_TEST

		TEST( testLen )
			dim c as integer = -1

			begin( )
				CU_ASSERT( len( fByvalUdtToStr( ClassUdt( ) ) ) = 3 )
			check( 1, 0, 1 )

			begin( )
				CU_ASSERT( len( fByrefUdtToStr( ClassUdt( ) ) ) = 3 )
			check( 1, 0, 1 )

			begin( )
				CU_ASSERT( len( fByvalUdtToStr( iif( c, ClassUdt( ), ClassUdt( ) ) ) ) = 3 ) '' "123"
			check( 1, 1, 2 )

			begin( )
				CU_ASSERT( len( fByrefUdtToStr( iif( c, ClassUdt( ), ClassUdt( ) ) ) ) = 3 ) '' "123"
			check( 1, 0, 1 )
		END_TEST

		TEST( testSizeOf )
			dim c as integer = -1

			begin( )
				CU_ASSERT( sizeof( fByvalUdtToInt( ClassUdt( ) ) ) = sizeof( integer ) )
			check( 0, 0, 0 )

			begin( )
				CU_ASSERT( sizeof( fByrefUdtToInt( ClassUdt( ) ) ) = sizeof( integer ) )
			check( 0, 0, 0 )

			begin( )
				CU_ASSERT( sizeof( fByvalUdtToInt( iif( c, ClassUdt( ), ClassUdt( ) ) ) ) = sizeof( integer ) )
			check( 0, 0, 0 )

			begin( )
				CU_ASSERT( sizeof( fByrefUdtToInt( iif( c, ClassUdt( ), ClassUdt( ) ) ) ) = sizeof( integer ) )
			check( 0, 0, 0 )

			begin( )
				CU_ASSERT( sizeof( ClassUdt( ) ) = sizeof( ClassUdt ) )
			check( 0, 0, 0 )

			begin( )
				CU_ASSERT( sizeof( iif( c, ClassUdt( ), ClassUdt( ) ) ) = sizeof( ClassUdt ) )
			check( 0, 0, 0 )

			begin( )
				CU_ASSERT( len( ClassUdt( ) ) = sizeof( ClassUdt ) )
			check( 0, 0, 0 )

			begin( )
				CU_ASSERT( len( iif( c, ClassUdt( ), ClassUdt( ) ) ) = sizeof( ClassUdt ) )
			check( 0, 0, 0 )

			begin( )
				CU_ASSERT( ((ClassUdt( )).i + sizeof( ClassUdt( ) )) = (123 + sizeof( ClassUdt )) )
			check( 1, 0, 1 )

			begin( )
				CU_ASSERT( (sizeof( ClassUdt( ) ) + (ClassUdt( )).i) = (sizeof( ClassUdt ) + 123) )
			check( 1, 0, 1 )
		END_TEST

		TEST( testStaticMemberAccess )
			begin( )
				CU_ASSERT( f1( ).CONST1 = 1 )
			check( 0, 0, 0 )

			begin( )
				CU_ASSERT( f1( ).staticvar1 = 1 )
			check( 0, 0, 0 )

			begin( )
				f1( ).staticsub1( )
			check( 0, 0, 0 )

			begin( )
				CU_ASSERT( (type<ClassUdt>( )).CONST1 = 1 )
			check( 0, 0, 0 )

			begin( )
				CU_ASSERT( (type<ClassUdt>( )).staticvar1 = 1 )
			check( 0, 0, 0 )

			begin( )
				(type<ClassUdt>( )).staticsub1( )
			check( 0, 0, 0 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( classlikeDoubleIntUdt )
		type ClassUdt
			as integer i, j

			declare constructor( )
			declare constructor( byref as ClassUdt )
			declare destructor( )

			const CONST1 = 1
			static staticvar1 as integer
			declare static sub staticsub1( )
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

		dim shared ClassUdt.staticvar1 as integer = 1
		static sub ClassUdt.staticsub1( )
		end sub

		function test1( byval x as ClassUdt ) as ClassUdt
			function = x
		end function

		sub test2( byval x as ClassUdt = test1( ClassUdt( ) ) )
		end sub

		TEST( testParamInit )
			begin( )
				test2( )
			check( 2, 1, 3 )

			begin( )
				dim x as ClassUdt = test1( ClassUdt( ) )
			check( 2, 1, 3 )
		END_TEST

		TEST( testAnon )
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
		END_TEST

		function f1( ) as ClassUdt
			function = type( )
		end function

		TEST( testResult )
			begin( )
				CU_ASSERT( f1( ).i = 123 )
			check( 2, 0, 2 )
		END_TEST

		function f2( byval i as integer ) as ClassUdt
			dim x as ClassUdt
			x.i = i
			function = x
		end function

		TEST( testIfBranch )
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

			begin( )
				dim i as integer = 0
				if( (ClassUdt( )).i = 123 ) then
					i = 1
				else
					i = 2
				end if
				CU_ASSERT( i = 1 )
			check( 1, 0, 1 )

			begin( )
				dim i as integer = 0
				if( (ClassUdt( )).i = 0 ) then
					i = 1
				else
					i = 2
				end if
				CU_ASSERT( i = 2 )
			check( 1, 0, 1 )
		END_TEST

		TEST( testIifBranch )
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
		END_TEST

		TEST( testWhileBranch )
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
		END_TEST

		TEST( testUntilBranch )
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
		END_TEST

		TEST( testIifTempVar )
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
		END_TEST

		TEST( testIifTrueFalseExpressions )
			dim c as integer

			begin( ) : c = -1 : CU_ASSERT( iif(  c, (ClassUdt( )).i, (ClassUdt( )).j ) = 123 ) : check( 1, 0, 1 )
			begin( ) : c = -1 : CU_ASSERT( iif(  c, (ClassUdt( )).j, (ClassUdt( )).i ) = 456 ) : check( 1, 0, 1 )
			begin( ) : c =  0 : CU_ASSERT( iif(  c, (ClassUdt( )).i, (ClassUdt( )).j ) = 456 ) : check( 1, 0, 1 )
			begin( ) : c =  0 : CU_ASSERT( iif(  c, (ClassUdt( )).j, (ClassUdt( )).i ) = 123 ) : check( 1, 0, 1 )

			begin( ) : c = -1 : CU_ASSERT( (iif(  c, ClassUdt( ), ClassUdt( ) )).i = 123 ) : check( 1, 0, 1 )
			begin( ) : c = -1 : CU_ASSERT( (iif(  c, ClassUdt( ), ClassUdt( ) )).j = 456 ) : check( 1, 0, 1 )
			begin( ) : c =  0 : CU_ASSERT( (iif(  c, ClassUdt( ), ClassUdt( ) )).i = 123 ) : check( 1, 0, 1 )
			begin( ) : c =  0 : CU_ASSERT( (iif(  c, ClassUdt( ), ClassUdt( ) )).j = 456 ) : check( 1, 0, 1 )

			begin( ) : CU_ASSERT( iif( -1, (ClassUdt( )).i, (ClassUdt( )).j ) = 123 ) : check( 1, 0, 1 )
			begin( ) : CU_ASSERT( iif( -1, (ClassUdt( )).j, (ClassUdt( )).i ) = 456 ) : check( 1, 0, 1 )
			begin( ) : CU_ASSERT( iif(  0, (ClassUdt( )).i, (ClassUdt( )).j ) = 456 ) : check( 1, 0, 1 )
			begin( ) : CU_ASSERT( iif(  0, (ClassUdt( )).j, (ClassUdt( )).i ) = 123 ) : check( 1, 0, 1 )

			begin( ) : CU_ASSERT( (iif( -1, ClassUdt( ), ClassUdt( ) )).i = 123 ) : check( 1, 0, 1 )
			begin( ) : CU_ASSERT( (iif( -1, ClassUdt( ), ClassUdt( ) )).j = 456 ) : check( 1, 0, 1 )
			begin( ) : CU_ASSERT( (iif(  0, ClassUdt( ), ClassUdt( ) )).i = 123 ) : check( 1, 0, 1 )
			begin( ) : CU_ASSERT( (iif(  0, ClassUdt( ), ClassUdt( ) )).j = 456 ) : check( 1, 0, 1 )
		END_TEST

		sub hPassByval( byval x as ClassUdt )
		end sub

		TEST( testByval )
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
		END_TEST

		sub hPassByref( byref x as ClassUdt )
		end sub

		TEST( testByref )
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
		END_TEST

		function fByvalUdtToInt( byval x as ClassUdt ) as integer
			function = x.i
		end function

		function fByrefUdtToInt( byref x as ClassUdt ) as integer
			function = x.i
		end function

		function fByvalUdtToStr( byval x as ClassUdt ) as string
			function = str( x.i )
		end function

		function fByrefUdtToStr( byref x as ClassUdt ) as string
			function = str( x.i )
		end function

		TEST( testTypeof )
			dim c as integer = -1

			begin( )
				dim i as typeof( fByvalUdtToInt( ClassUdt( ) ) )
			check( 0, 0, 0 )

			begin( )
				dim i as typeof( fByrefUdtToInt( ClassUdt( ) ) )
			check( 0, 0, 0 )

			begin( )
				dim i as typeof( fByvalUdtToInt( iif( c, ClassUdt( ), ClassUdt( ) ) ) )
			check( 0, 0, 0 )

			begin( )
				dim i as typeof( fByrefUdtToInt( iif( c, ClassUdt( ), ClassUdt( ) ) ) )
			check( 0, 0, 0 )

			begin( )
				dim x as typeof( ClassUdt( ) )
			check( 1, 0, 1 )

			begin( )
				dim x as typeof( iif( c, ClassUdt( ), ClassUdt( ) ) )
			check( 1, 0, 1 )
		END_TEST

		TEST( testLen )
			dim c as integer = -1

			begin( )
				CU_ASSERT( len( fByvalUdtToStr( ClassUdt( ) ) ) = 3 )
			check( 1, 0, 1 )

			begin( )
				CU_ASSERT( len( fByrefUdtToStr( ClassUdt( ) ) ) = 3 )
			check( 1, 0, 1 )

			begin( )
				CU_ASSERT( len( fByvalUdtToStr( iif( c, ClassUdt( ), ClassUdt( ) ) ) ) = 3 ) '' "123"
			check( 1, 1, 2 )

			begin( )
				CU_ASSERT( len( fByrefUdtToStr( iif( c, ClassUdt( ), ClassUdt( ) ) ) ) = 3 ) '' "123"
			check( 1, 0, 1 )
		END_TEST

		TEST( testSizeOf )
			dim c as integer = -1

			begin( )
				CU_ASSERT( sizeof( fByvalUdtToInt( ClassUdt( ) ) ) = sizeof( integer ) )
			check( 0, 0, 0 )

			begin( )
				CU_ASSERT( sizeof( fByrefUdtToInt( ClassUdt( ) ) ) = sizeof( integer ) )
			check( 0, 0, 0 )

			begin( )
				CU_ASSERT( sizeof( fByvalUdtToInt( iif( c, ClassUdt( ), ClassUdt( ) ) ) ) = sizeof( integer ) )
			check( 0, 0, 0 )

			begin( )
				CU_ASSERT( sizeof( fByrefUdtToInt( iif( c, ClassUdt( ), ClassUdt( ) ) ) ) = sizeof( integer ) )
			check( 0, 0, 0 )

			begin( )
				CU_ASSERT( sizeof( ClassUdt( ) ) = sizeof( ClassUdt ) )
			check( 0, 0, 0 )

			begin( )
				CU_ASSERT( sizeof( iif( c, ClassUdt( ), ClassUdt( ) ) ) = sizeof( ClassUdt ) )
			check( 0, 0, 0 )

			begin( )
				CU_ASSERT( len( ClassUdt( ) ) = sizeof( ClassUdt ) )
			check( 0, 0, 0 )

			begin( )
				CU_ASSERT( len( iif( c, ClassUdt( ), ClassUdt( ) ) ) = sizeof( ClassUdt ) )
			check( 0, 0, 0 )

			begin( )
				CU_ASSERT( ((ClassUdt( )).i + sizeof( ClassUdt( ) )) = (123 + sizeof( ClassUdt )) )
			check( 1, 0, 1 )

			begin( )
				CU_ASSERT( (sizeof( ClassUdt( ) ) + (ClassUdt( )).i) = (sizeof( ClassUdt ) + 123) )
			check( 1, 0, 1 )
		END_TEST

		TEST( testStaticMemberAccess )
			begin( )
				CU_ASSERT( f1( ).CONST1 = 1 )
			check( 0, 0, 0 )

			begin( )
				CU_ASSERT( f1( ).staticvar1 = 1 )
			check( 0, 0, 0 )

			begin( )
				f1( ).staticsub1( )
			check( 0, 0, 0 )

			begin( )
				CU_ASSERT( (type<ClassUdt>( )).CONST1 = 1 )
			check( 0, 0, 0 )

			begin( )
				CU_ASSERT( (type<ClassUdt>( )).staticvar1 = 1 )
			check( 0, 0, 0 )

			begin( )
				(type<ClassUdt>( )).staticsub1( )
			check( 0, 0, 0 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( dtorOnlyIntegerUdt )
		type DtorUdt
			i as integer

			declare destructor( )

			const CONST1 = 1
			static staticvar1 as integer
			declare static sub staticsub1( )
		end type

		destructor DtorUdt( )
			totaldtors += 1
			with( status(hFindSlot( @this )) )
				'' DtorUdt has no ctor, so fake it
				totalctors += 1
			end with
		end destructor

		dim shared DtorUdt.staticvar1 as integer = 1
		static sub DtorUdt.staticsub1( )
		end sub

		function test1( byval x as DtorUdt ) as DtorUdt
			function = x
		end function

		sub test2( byval x as DtorUdt = test1( type<DtorUdt>( 123 ) ) )
		end sub

		TEST( testParamInit )
			begin( )
				test2( )
			check( 3, 0, 3 )

			begin( )
				dim x as DtorUdt = test1( type<DtorUdt>( 123 ) )
			check( 3, 0, 3 )
		END_TEST

		TEST( testAnon )
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
		END_TEST

		function f1( ) as DtorUdt
			function = type( 123 )
		end function

		TEST( testResult )
			begin( )
				CU_ASSERT( f1( ).i = 123 )
			check( 2, 0, 2 )
		END_TEST

		function f2( byval i as integer ) as DtorUdt
			function = type( i )
		end function

		TEST( testIfBranch )
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

			begin( )
				dim i as integer = 0
				if( (type<DtorUdt>( 123 )).i = 123 ) then
					i = 1
				else
					i = 2
				end if
				CU_ASSERT( i = 1 )
			check( 1, 0, 1 )

			begin( )
				dim i as integer = 0
				if( (type<DtorUdt>( 123 )).i = 0 ) then
					i = 1
				else
					i = 2
				end if
				CU_ASSERT( i = 2 )
			check( 1, 0, 1 )
		END_TEST

		TEST( testIifBranch )
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
		END_TEST

		TEST( testWhileBranch )
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
		END_TEST

		TEST( testUntilBranch )
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
		END_TEST

		TEST( testIifTempVar )
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
		END_TEST

		TEST( testIifTrueFalseExpressions )
			dim c as integer

			begin( ) : c = -1 : CU_ASSERT( iif(  c, (type<DtorUdt>( 1 )).i, (type<DtorUdt>( 2 )).i ) = 1 ) : check( 1, 0, 1 )
			begin( ) : c =  0 : CU_ASSERT( iif(  c, (type<DtorUdt>( 1 )).i, (type<DtorUdt>( 2 )).i ) = 2 ) : check( 1, 0, 1 )

			begin( ) : c = -1 : CU_ASSERT( (iif(  c, type<DtorUdt>( 1 ), type<DtorUdt>( 2 ) )).i = 1 ) : check( 2, 0, 2 )
			begin( ) : c =  0 : CU_ASSERT( (iif(  c, type<DtorUdt>( 1 ), type<DtorUdt>( 2 ) )).i = 2 ) : check( 2, 0, 2 )

			begin( ) : CU_ASSERT( iif( -1, (type<DtorUdt>( 1 )).i, (type<DtorUdt>( 2 )).i ) = 1 ) : check( 1, 0, 1 )
			begin( ) : CU_ASSERT( iif(  0, (type<DtorUdt>( 1 )).i, (type<DtorUdt>( 2 )).i ) = 2 ) : check( 1, 0, 1 )

			begin( ) : CU_ASSERT( (iif( -1, type<DtorUdt>( 1 ), type<DtorUdt>( 2 ) )).i = 1 ) : check( 1, 0, 1 )
			begin( ) : CU_ASSERT( (iif(  0, type<DtorUdt>( 1 ), type<DtorUdt>( 2 ) )).i = 2 ) : check( 1, 0, 1 )
		END_TEST

		sub hPassByval( byval x as DtorUdt )
		end sub

		TEST( testByval )
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
		END_TEST

		sub hPassByref( byref x as DtorUdt )
		end sub

		TEST( testByref )
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
		END_TEST

		function fByvalUdtToInt( byval x as DtorUdt ) as integer
			function = x.i
		end function

		function fByrefUdtToInt( byref x as DtorUdt ) as integer
			function = x.i
		end function

		function fByvalUdtToStr( byval x as DtorUdt ) as string
			function = str( x.i )
		end function

		function fByrefUdtToStr( byref x as DtorUdt ) as string
			function = str( x.i )
		end function

		TEST( testTypeof )
			dim c as integer = -1

			begin( )
				dim i as typeof( fByvalUdtToInt( type<DtorUdt>( 123 ) ) )
			check( 0, 0, 0 )

			begin( )
				dim i as typeof( fByrefUdtToInt( type<DtorUdt>( 123 ) ) )
			check( 0, 0, 0 )

			begin( )
				dim i as typeof( fByvalUdtToInt( iif( c, type<DtorUdt>( 123 ), type<DtorUdt>( 123 ) ) ) )
			check( 0, 0, 0 )

			begin( )
				dim i as typeof( fByrefUdtToInt( iif( c, type<DtorUdt>( 123 ), type<DtorUdt>( 123 ) ) ) )
			check( 0, 0, 0 )

			begin( )
				dim x as typeof( type<DtorUdt>( 123 ) )
			check( 1, 0, 1 )

			begin( )
				dim x as typeof( iif( c, type<DtorUdt>( 123 ), type<DtorUdt>( 123 ) ) )
			check( 1, 0, 1 )
		END_TEST

		TEST( testLen )
			dim c as integer = -1

			begin( )
				CU_ASSERT( len( fByvalUdtToStr( type<DtorUdt>( 123 ) ) ) = 3 )
			check( 1, 0, 1 )

			begin( )
				CU_ASSERT( len( fByrefUdtToStr( type<DtorUdt>( 123 ) ) ) = 3 )
			check( 1, 0, 1 )

			begin( )
				CU_ASSERT( len( fByvalUdtToStr( iif( c, type<DtorUdt>( 111 ), type<DtorUdt>( 111222 ) ) ) ) = 3 ) '' "111"
			check( 3, 0, 3 )

			begin( )
				CU_ASSERT( len( fByvalUdtToStr( iif( c, type<DtorUdt>( 111222 ), type<DtorUdt>( 111 ) ) ) ) = 6 ) '' "111222"
			check( 3, 0, 3 )

			begin( )
				CU_ASSERT( len( fByrefUdtToStr( iif( c, type<DtorUdt>( 111 ), type<DtorUdt>( 111222 ) ) ) ) = 3 ) '' "111"
			check( 2, 0, 2 )

			begin( )
				CU_ASSERT( len( fByrefUdtToStr( iif( c, type<DtorUdt>( 111222 ), type<DtorUdt>( 111 ) ) ) ) = 6 ) '' "111222"
			check( 2, 0, 2 )
		END_TEST

		TEST( testSizeOf )
			dim c as integer = -1

			begin( )
				CU_ASSERT( sizeof( fByvalUdtToInt( type<DtorUdt>( 123 ) ) ) = sizeof( integer ) )
			check( 0, 0, 0 )

			begin( )
				CU_ASSERT( sizeof( fByrefUdtToInt( type<DtorUdt>( 123 ) ) ) = sizeof( integer ) )
			check( 0, 0, 0 )

			begin( )
				CU_ASSERT( sizeof( fByvalUdtToInt( iif( c, type<DtorUdt>( 123 ), type<DtorUdt>( 123 ) ) ) ) = sizeof( integer ) )
			check( 0, 0, 0 )

			begin( )
				CU_ASSERT( sizeof( fByrefUdtToInt( iif( c, type<DtorUdt>( 123 ), type<DtorUdt>( 123 ) ) ) ) = sizeof( integer ) )
			check( 0, 0, 0 )

			begin( )
				CU_ASSERT( sizeof( type<DtorUdt>( 123 ) ) = sizeof( DtorUdt ) )
			check( 0, 0, 0 )

			begin( )
				CU_ASSERT( sizeof( iif( c, type<DtorUdt>( 123 ), type<DtorUdt>( 123 ) ) ) = sizeof( DtorUdt ) )
			check( 0, 0, 0 )

			begin( )
				CU_ASSERT( len( type<DtorUdt>( 123 ) ) = sizeof( DtorUdt ) )
			check( 0, 0, 0 )

			begin( )
				CU_ASSERT( len( iif( c, type<DtorUdt>( 123 ), type<DtorUdt>( 123 ) ) ) = sizeof( DtorUdt ) )
			check( 0, 0, 0 )

			begin( )
				CU_ASSERT( ((type<DtorUdt>( 123 )).i + sizeof( type<DtorUdt>( 123 ) )) = (123 + sizeof( DtorUdt )) )
			check( 1, 0, 1 )

			begin( )
				CU_ASSERT( (sizeof( type<DtorUdt>( 123 ) ) + (type<DtorUdt>( 123 )).i) = (sizeof( DtorUdt ) + 123) )
			check( 1, 0, 1 )
		END_TEST

		TEST( testStaticMemberAccess )
			begin( )
				CU_ASSERT( f1( ).CONST1 = 1 )
			check( 0, 0, 0 )

			begin( )
				CU_ASSERT( f1( ).staticvar1 = 1 )
			check( 0, 0, 0 )

			begin( )
				f1( ).staticsub1( )
			check( 0, 0, 0 )

			begin( )
				CU_ASSERT( (type<DtorUdt>( 123 )).CONST1 = 1 )
			check( 0, 0, 0 )

			begin( )
				CU_ASSERT( (type<DtorUdt>( 123 )).staticvar1 = 1 )
			check( 0, 0, 0 )

			begin( )
				(type<DtorUdt>( 123 )).staticsub1( )
			check( 0, 0, 0 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( dtorOnlyDoubleIntUdt )
		type DtorUdt
			as integer i, j

			declare destructor( )

			const CONST1 = 1
			static staticvar1 as integer
			declare static sub staticsub1( )
		end type

		destructor DtorUdt( )
			totaldtors += 1
			with( status(hFindSlot( @this )) )
				'' DtorUdt has no ctor, so fake it
				totalctors += 1
			end with
		end destructor

		dim shared DtorUdt.staticvar1 as integer = 1
		static sub DtorUdt.staticsub1( )
		end sub

		function test1( byval x as DtorUdt ) as DtorUdt
			function = x
		end function

		sub test2( byval x as DtorUdt = test1( type<DtorUdt>( 123, 456 ) ) )
		end sub

		TEST( testParamInit )
			begin( )
				test2( )
			check( 3, 0, 3 )

			begin( )
				dim x as DtorUdt = test1( type<DtorUdt>( 123 ) )
			check( 3, 0, 3 )
		END_TEST

		TEST( testAnon )
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
		END_TEST

		function f1( ) as DtorUdt
			function = type( 123 )
		end function

		TEST( testResult )
			begin( )
				CU_ASSERT( f1( ).i = 123 )
			check( 2, 0, 2 )
		END_TEST

		function f2( byval i as integer ) as DtorUdt
			function = type( i )
		end function

		TEST( testIfBranch )
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

			begin( )
				dim i as integer = 0
				if( (type<DtorUdt>( 123 )).i = 123 ) then
					i = 1
				else
					i = 2
				end if
				CU_ASSERT( i = 1 )
			check( 1, 0, 1 )

			begin( )
				dim i as integer = 0
				if( (type<DtorUdt>( 123 )).i = 0 ) then
					i = 1
				else
					i = 2
				end if
				CU_ASSERT( i = 2 )
			check( 1, 0, 1 )
		END_TEST

		TEST( testIifBranch )
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
		END_TEST

		TEST( testWhileBranch )
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
		END_TEST

		TEST( testUntilBranch )
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
		END_TEST

		TEST( testIifTempVar )
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
		END_TEST

		TEST( testIifTrueFalseExpressions )
			dim c as integer

			begin( ) : c = -1 : CU_ASSERT( iif(  c, (type<DtorUdt>( 1, 11 )).i, (type<DtorUdt>( 2, 22 )).j ) =  1 ) : check( 1, 0, 1 )
			begin( ) : c = -1 : CU_ASSERT( iif(  c, (type<DtorUdt>( 1, 11 )).j, (type<DtorUdt>( 2, 22 )).i ) = 11 ) : check( 1, 0, 1 )
			begin( ) : c =  0 : CU_ASSERT( iif(  c, (type<DtorUdt>( 1, 11 )).i, (type<DtorUdt>( 2, 22 )).j ) = 22 ) : check( 1, 0, 1 )
			begin( ) : c =  0 : CU_ASSERT( iif(  c, (type<DtorUdt>( 1, 11 )).j, (type<DtorUdt>( 2, 22 )).i ) =  2 ) : check( 1, 0, 1 )

			begin( ) : c = -1 : CU_ASSERT( (iif(  c, type<DtorUdt>( 1, 11 ), type<DtorUdt>( 2, 22 ) )).i =  1 ) : check( 2, 0, 2 )
			begin( ) : c = -1 : CU_ASSERT( (iif(  c, type<DtorUdt>( 1, 11 ), type<DtorUdt>( 2, 22 ) )).j = 11 ) : check( 2, 0, 2 )
			begin( ) : c =  0 : CU_ASSERT( (iif(  c, type<DtorUdt>( 1, 11 ), type<DtorUdt>( 2, 22 ) )).i =  2 ) : check( 2, 0, 2 )
			begin( ) : c =  0 : CU_ASSERT( (iif(  c, type<DtorUdt>( 1, 11 ), type<DtorUdt>( 2, 22 ) )).j = 22 ) : check( 2, 0, 2 )

			begin( ) : CU_ASSERT( iif( -1, (type<DtorUdt>( 1, 11 )).i, (type<DtorUdt>( 2, 22 )).j ) =  1 ) : check( 1, 0, 1 )
			begin( ) : CU_ASSERT( iif( -1, (type<DtorUdt>( 1, 11 )).j, (type<DtorUdt>( 2, 22 )).i ) = 11 ) : check( 1, 0, 1 )
			begin( ) : CU_ASSERT( iif(  0, (type<DtorUdt>( 1, 11 )).i, (type<DtorUdt>( 2, 22 )).j ) = 22 ) : check( 1, 0, 1 )
			begin( ) : CU_ASSERT( iif(  0, (type<DtorUdt>( 1, 11 )).j, (type<DtorUdt>( 2, 22 )).i ) =  2 ) : check( 1, 0, 1 )

			begin( ) : CU_ASSERT( (iif( -1, type<DtorUdt>( 1, 11 ), type<DtorUdt>( 2, 22 ) )).i =  1 ) : check( 1, 0, 1 )
			begin( ) : CU_ASSERT( (iif( -1, type<DtorUdt>( 1, 11 ), type<DtorUdt>( 2, 22 ) )).j = 11 ) : check( 1, 0, 1 )
			begin( ) : CU_ASSERT( (iif(  0, type<DtorUdt>( 1, 11 ), type<DtorUdt>( 2, 22 ) )).i =  2 ) : check( 1, 0, 1 )
			begin( ) : CU_ASSERT( (iif(  0, type<DtorUdt>( 1, 11 ), type<DtorUdt>( 2, 22 ) )).j = 22 ) : check( 1, 0, 1 )
		END_TEST

		sub hPassByval( byval x as DtorUdt )
		end sub

		TEST( testByval )
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
		END_TEST

		sub hPassByref( byref x as DtorUdt )
		end sub

		TEST( testByref )
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
		END_TEST

		function fByvalUdtToInt( byval x as DtorUdt ) as integer
			function = x.i
		end function

		function fByrefUdtToInt( byref x as DtorUdt ) as integer
			function = x.i
		end function

		function fByvalUdtToStr( byval x as DtorUdt ) as string
			function = str( x.i )
		end function

		function fByrefUdtToStr( byref x as DtorUdt ) as string
			function = str( x.i )
		end function

		TEST( testTypeof )
			dim c as integer = -1

			begin( )
				dim i as typeof( fByvalUdtToInt( type<DtorUdt>( 123 ) ) )
			check( 0, 0, 0 )

			begin( )
				dim i as typeof( fByrefUdtToInt( type<DtorUdt>( 123 ) ) )
			check( 0, 0, 0 )

			begin( )
				dim i as typeof( fByvalUdtToInt( iif( c, type<DtorUdt>( 123 ), type<DtorUdt>( 123 ) ) ) )
			check( 0, 0, 0 )

			begin( )
				dim i as typeof( fByrefUdtToInt( iif( c, type<DtorUdt>( 123 ), type<DtorUdt>( 123 ) ) ) )
			check( 0, 0, 0 )

			begin( )
				dim x as typeof( type<DtorUdt>( 123 ) )
			check( 1, 0, 1 )

			begin( )
				dim x as typeof( iif( c, type<DtorUdt>( 123 ), type<DtorUdt>( 123 ) ) )
			check( 1, 0, 1 )
		END_TEST

		TEST( testLen )
			dim c as integer = -1

			begin( )
				CU_ASSERT( len( fByvalUdtToStr( type<DtorUdt>( 123 ) ) ) = 3 )
			check( 1, 0, 1 )

			begin( )
				CU_ASSERT( len( fByrefUdtToStr( type<DtorUdt>( 123 ) ) ) = 3 )
			check( 1, 0, 1 )

			begin( )
				CU_ASSERT( len( fByvalUdtToStr( iif( c, type<DtorUdt>( 111 ), type<DtorUdt>( 111222 ) ) ) ) = 3 ) '' "111"
			check( 3, 0, 3 )

			begin( )
				CU_ASSERT( len( fByvalUdtToStr( iif( c, type<DtorUdt>( 111222 ), type<DtorUdt>( 111 ) ) ) ) = 6 ) '' "111222"
			check( 3, 0, 3 )

			begin( )
				CU_ASSERT( len( fByrefUdtToStr( iif( c, type<DtorUdt>( 111 ), type<DtorUdt>( 111222 ) ) ) ) = 3 ) '' "111"
			check( 2, 0, 2 )

			begin( )
				CU_ASSERT( len( fByrefUdtToStr( iif( c, type<DtorUdt>( 111222 ), type<DtorUdt>( 111 ) ) ) ) = 6 ) '' "111222"
			check( 2, 0, 2 )
		END_TEST

		TEST( testSizeOf )
			dim c as integer = -1

			begin( )
				CU_ASSERT( sizeof( fByvalUdtToInt( type<DtorUdt>( 123 ) ) ) = sizeof( integer ) )
			check( 0, 0, 0 )

			begin( )
				CU_ASSERT( sizeof( fByrefUdtToInt( type<DtorUdt>( 123 ) ) ) = sizeof( integer ) )
			check( 0, 0, 0 )

			begin( )
				CU_ASSERT( sizeof( fByvalUdtToInt( iif( c, type<DtorUdt>( 123 ), type<DtorUdt>( 123 ) ) ) ) = sizeof( integer ) )
			check( 0, 0, 0 )

			begin( )
				CU_ASSERT( sizeof( fByrefUdtToInt( iif( c, type<DtorUdt>( 123 ), type<DtorUdt>( 123 ) ) ) ) = sizeof( integer ) )
			check( 0, 0, 0 )

			begin( )
				CU_ASSERT( sizeof( type<DtorUdt>( 123 ) ) = sizeof( DtorUdt ) )
			check( 0, 0, 0 )

			begin( )
				CU_ASSERT( sizeof( iif( c, type<DtorUdt>( 123 ), type<DtorUdt>( 123 ) ) ) = sizeof( DtorUdt ) )
			check( 0, 0, 0 )

			begin( )
				CU_ASSERT( len( type<DtorUdt>( 123 ) ) = sizeof( DtorUdt ) )
			check( 0, 0, 0 )

			begin( )
				CU_ASSERT( len( iif( c, type<DtorUdt>( 123 ), type<DtorUdt>( 123 ) ) ) = sizeof( DtorUdt ) )
			check( 0, 0, 0 )

			begin( )
				CU_ASSERT( ((type<DtorUdt>( 123 )).i + sizeof( type<DtorUdt>( 123 ) )) = (123 + sizeof( DtorUdt )) )
			check( 1, 0, 1 )

			begin( )
				CU_ASSERT( (sizeof( type<DtorUdt>( 123 ) ) + (type<DtorUdt>( 123 )).i) = (sizeof( DtorUdt ) + 123) )
			check( 1, 0, 1 )
		END_TEST

		TEST( testStaticMemberAccess )
			begin( )
				CU_ASSERT( f1( ).CONST1 = 1 )
			check( 0, 0, 0 )

			begin( )
				CU_ASSERT( f1( ).staticvar1 = 1 )
			check( 0, 0, 0 )

			begin( )
				f1( ).staticsub1( )
			check( 0, 0, 0 )

			begin( )
				CU_ASSERT( (type<DtorUdt>( 123 )).CONST1 = 1 )
			check( 0, 0, 0 )

			begin( )
				CU_ASSERT( (type<DtorUdt>( 123 )).staticvar1 = 1 )
			check( 0, 0, 0 )

			begin( )
				(type<DtorUdt>( 123 )).staticsub1( )
			check( 0, 0, 0 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( copyctorWith2ndParam )
		'' The AST must ensure that temp vars created in true/false expressions
		'' of an iif() are only constructed/destructed if the true/false code
		'' path actually is reached. This also affects constructor calls used
		'' to construct the iif temp var from the true/false expressions.
		''
		'' For example, it could be a call to a copy constructor, with a 2nd
		'' parameter (with a parameter initializer) which results in an ARG
		'' that uses a temp var.

		type A
			i as integer
			declare constructor( byval i as integer )
			declare destructor( )
		end type

		constructor A( byval i as integer )
			totalctors += 1
			with( status(hFindSlot( @this )) )
				.instance = @this
				CU_ASSERT( .refcount = 0 )
				.refcount += 1
			end with
		end constructor

		destructor A( )
			totaldtors += 1
			with( status(hFindSlot( @this )) )
				CU_ASSERT( .refcount = 1 )
				.refcount -= 1
			end with
		end destructor

		type B
			i as integer
			declare constructor( byval i as integer )

			'' Copy constructor with 2nd parameter that requires a temp var.
			'' It could also be an integer contant passed to a BYREF AS INTEGER
			'' parameter, but using an UDT with destructor is easiest for this
			'' test, since we can check whether the destructor was called.
			'' In fact, the destructor calling is the most important part.
			'' If it was just an integer param, the worst thing that could
			'' happen would be that the temp var is allocated on stack but
			'' never used, i.e. wasted memory.
			declare constructor( byref rhs as B, byref x as A = type<A>( 123 ) )
			declare destructor( )
		end type

		constructor B( byval i as integer )
			this.i = i
			totalctors += 1
			with( status(hFindSlot( @this )) )
				.instance = @this
				CU_ASSERT( .refcount = 0 )
				.refcount += 1
			end with
		end constructor

		constructor B( byref rhs as B, byref x as A )
			this.i = rhs.i
			totalcopyctors += 1
			with( status(hFindSlot( @this )) )
				.instance = @this
				CU_ASSERT( .refcount = 0 )
				.refcount += 1
			end with
		end constructor

		destructor B( )
			totaldtors += 1
			with( status(hFindSlot( @this )) )
				CU_ASSERT( .refcount = 1 )
				.refcount -= 1
			end with
		end destructor

		TEST( )
			dim c as integer

			begin( )
				c = -1
				dim as B b1 = B( 1 ), b2 = B( 2 )
				CU_ASSERT( (iif( c, b1, b2 )).i = 1 )
			check( 3, 1, 4 )

			begin( )
				c = 0
				dim as B b1 = B( 1 ), b2 = B( 2 )
				CU_ASSERT( (iif( c, b1, b2 )).i = 2 )
			check( 3, 1, 4 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( swapUdts )
		dim shared as integer ctors, dtors, fcalls

		type UDT
			i as integer
			declare constructor( i as integer )
			declare destructor( )
		end type

		constructor UDT( i as integer )
			'' dtors shouldn't be called too early
			CU_ASSERT( dtors = 0 )
			CU_ASSERT( this.i = 0 )
			ctors += 1
			this.i = i
		end constructor

		destructor UDT( )
			'' ctors must have been called first
			CU_ASSERT( ctors = 2 )
			CU_ASSERT( (this.i = 0) or (this.i = 1) )
			dtors += 1
			this.i = &hDEADBEEF
		end destructor

		function f( byval i as integer ) as UDT
			fcalls += 1
			return type( i )
		end function

		TEST( default )
			ctors = 0
			dtors = 0
			fcalls = 0
			scope
				dim array(0 to 1) as integer => { 1, 2 }
				CU_ASSERT( array(0) = 1 )
				CU_ASSERT( array(1) = 2 )
				CU_ASSERT( ctors = 0 )
				CU_ASSERT( dtors = 0 )

				swap array(type<UDT>(0).i), array(type<UDT>(1).i)
				CU_ASSERT( array(0) = 2 )
				CU_ASSERT( array(1) = 1 )
				CU_ASSERT( ctors = 2 )
				CU_ASSERT( dtors = 2 )
			end scope

			ctors = 0
			dtors = 0
			fcalls = 0
			scope
				dim array(0 to 1) as integer => { 1, 2 }
				CU_ASSERT( array(0) = 1 )
				CU_ASSERT( array(1) = 2 )
				CU_ASSERT( ctors = 0 )
				CU_ASSERT( dtors = 0 )
				CU_ASSERT( fcalls = 0 )

				swap array(f(0).i), array(f(1).i)
				CU_ASSERT( array(0) = 2 )
				CU_ASSERT( array(1) = 1 )
				CU_ASSERT( ctors = 2 )
				CU_ASSERT( dtors = 2 )
				CU_ASSERT( fcalls = 2 )
			end scope
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( localArrayInit1 )
		type UDT
			i as integer
			declare constructor(byref rhs as string)
		end type

		constructor UDT(byref rhs as string)
			this.i = valint(rhs)
		end constructor

		TEST( )
			dim c(0 to 0) as UDT = { "123" }
			CU_ASSERT( c(0).i = 123 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( localArrayInit2 )
		dim shared as integer ctors, dtors

		type A
			i as integer
			declare constructor()
			declare destructor()
		end type

		constructor A()
			CU_ASSERT( ctors = 0 )
			CU_ASSERT( dtors = 0 )
			ctors += 1
			this.i = 123
		end constructor

		destructor A()
			CU_ASSERT( ctors = 1 )
			CU_ASSERT( dtors = 0 )
			dtors += 1
		end destructor

		type UDT
			i as integer
			declare constructor(byref rhs as A)
		end type

		constructor UDT(byref rhs as A)
			this.i = rhs.i
		end constructor

		TEST( default )
			CU_ASSERT( ctors = 0 )
			CU_ASSERT( dtors = 0 )
			scope
				dim c(0 to 0) as UDT = { A() }
				CU_ASSERT( ctors = 1 )
				CU_ASSERT( dtors = 1 )
				CU_ASSERT( c(0).i = 123 )
				CU_ASSERT( ctors = 1 )
				CU_ASSERT( dtors = 1 )
			end scope
			CU_ASSERT( ctors = 1 )
			CU_ASSERT( dtors = 1 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( localArrayInit3 )
		dim shared as integer ctors, dtors

		type A
			i as integer
			declare constructor()
			declare destructor()
		end type

		constructor A()
			CU_ASSERT( ctors = 0 )
			CU_ASSERT( dtors = 0 )
			ctors += 1
			this.i = 123
		end constructor

		destructor A()
			CU_ASSERT( ctors = 1 )
			CU_ASSERT( dtors = 0 )
			dtors += 1
		end destructor

		TEST( default )
			CU_ASSERT( ctors = 0 )
			CU_ASSERT( dtors = 0 )
			scope
				dim c(0 to 0) as integer = { (A()).i }
				CU_ASSERT( ctors = 1 )
				CU_ASSERT( dtors = 1 )
				CU_ASSERT( c(0) = 123 )
				CU_ASSERT( ctors = 1 )
				CU_ASSERT( dtors = 1 )
			end scope
			CU_ASSERT( ctors = 1 )
			CU_ASSERT( dtors = 1 )
		END_TEST
	END_TEST_GROUP

	''
	'' Constructs such as SELECT CASE, FOR, SWAP, WITH need to parse operand
	'' expressions and create implicit vars. While doing that they must take care to
	'' handle temporaries in the expression properly.
	''
	'' Specifically, the temp vars from the expression mustn't be destructed too
	'' early, before the expression is even used. They must be destructed behind the
	'' expression. Some language constructs such as the ones mentioned above must be
	'' extra careful about this because they implicitly consist of multiple
	'' statements.
	''
	'' This affects both UDTs with constructors/destructors and dynamic strings.
	'' (UDT => destructor call, string => fb_StrDelete() call)
	''
	TEST_GROUP( tempUdtArg )
		type PodUdt
			i as integer
		end type

		type ClassUdt
			i as integer

			declare constructor( )
			declare constructor( byval as integer )
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

		constructor ClassUdt( byval i as integer )
			this.i = i
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

		function fInteger( byref x as ClassUdt ) as integer
			function = x.i
		end function

		function fString( byref x as ClassUdt ) as string
			function = str( x.i )
		end function

		function fWstring( byref x as ClassUdt ) as wstring ptr
			static w as wstring * 32
			w = wstr( x.i )
			function = @w
		end function

		function fPodUdt( byref x as ClassUdt ) as PodUdt
			function = type( x.i )
		end function

		type MyStaticVar
			i as integer
			declare constructor( byref as ClassUdt )
		end type

		constructor MyStaticVar( byref rhs as ClassUdt )
		end constructor

		sub staticVarInitExpr( )
			'' Static var initialization is wrapped in an If block that
			'' ensures that the static var is only initialized during the
			'' first call. This must handle temp vars in the initialization
			'' code properly.
			static x1 as MyStaticVar = MyStaticVar( ClassUdt( 123 ) )
		end sub

		sub staticRedimBoundsExpr( )
			'' Static dynamic arrays with non-constant array bounds
			'' expressions, that will be initialized with a Redim call,
			'' are also affected
			static array(0 to fInteger( ClassUdt( 1 ) )) as integer
		end sub

		TEST( default )
			begin( )
				select case( fInteger( ClassUdt( 111 ) ) )
				case 111
				case else
					CU_FAIL( )
				end select
			check( 1, 0, 1 )

			begin( )
				select case( fString( ClassUdt( 111 ) ) )
				case "111"
				case else
					CU_FAIL( )
				end select
			check( 1, 0, 1 )

			begin( )
				select case( *fWstring( ClassUdt( 111 ) ) )
				case wstr( "111" )
				case else
					CU_FAIL( )
				end select
			check( 1, 0, 1 )

			begin( )
				select case as const( fInteger( ClassUdt( 111 ) ) )
				case 111
				case else
					CU_FAIL( )
				end select
			check( 1, 0, 1 )

			begin( )
				with( fPodUdt( ClassUdt( 111 ) ) )
					CU_ASSERT( .i = 111 )
				end with
			check( 1, 0, 1 )

			begin( )
				var count = 0
				for i as integer = fInteger( ClassUdt( 1 ) ) to 2
					count += 1
				next
				CU_ASSERT( count = 2 )
			check( 1, 0, 1 )

			begin( )
				var count = 0
				for i as integer = 1 to fInteger( ClassUdt( 3 ) )
					count += 1
				next
				CU_ASSERT( count = 3 )
			check( 1, 0, 1 )

			begin( )
				var count = 0
				for i as integer = 1 to 10 step fInteger( ClassUdt( 2 ) )
					count += 1
				next
				CU_ASSERT( count = 5 )
			check( 1, 0, 1 )

			begin( )
				staticVarInitExpr( )  '' 1st call (init done here)
				staticVarInitExpr( )  '' 2nd call (no init anymore)
			check( 1, 0, 1 )

			begin( )
				staticRedimBoundsExpr( )  '' 1st call (init done here)
				staticRedimBoundsExpr( )  '' 2nd call (no init anymore)
			check( 1, 0, 1 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( tempStringArg )
		type PodUdt
			i as integer
		end type

		function fInteger( byref s as string ) as integer
			function = valint( s )
		end function

		function fString( byref s as string ) as string
			function = s
		end function

		function fWstring( byref s as string ) as wstring ptr
			static w as wstring * 32
			w = s
			function = @w
		end function

		function fPodUdt( byref s as string ) as PodUdt
			function = type( valint( s ) )
		end function

		type MyStaticVar
			i as integer
			declare constructor( byref as string )
		end type

		constructor MyStaticVar( byref rhs as string )
		end constructor

		sub staticVarInitExpr( )
			'' Static var initialization is wrapped in an If block that
			'' ensures that the static var is only initialized during the
			'' first call. This must handle temp vars in the initialization
			'' code properly.
			static x1 as MyStaticVar = MyStaticVar( "abc" )

			'' This was fairly reliable in triggering a crash, so it's probably a good test
			static x2(0 to ...) as MyStaticVar => { _
				"1", "2", "3", "4", "5", "6", "7", "8", "9", "10", _
				"1", "2", "3", "4", "5", "6", "7", "8", "9", "10", _
				"1", "2", "3", "4", "5", "6", "7", "8", "9", "10"  _
			}
		end sub

		sub staticRedimBoundsExpr( )
			'' Static dynamic arrays with non-constant array bounds
			'' expressions, that will be initialized with a Redim call,
			'' are also affected
			static array(0 to fInteger( "1" )) as integer
		end sub

		TEST( default )
			select case( fInteger( "111" ) )
			case 111
			case else
				CU_FAIL( )
			end select

			select case( fString( "111" ) )
			case "111"
			case else
				CU_FAIL( )
			end select

			select case( *fWstring( "111" ) )
			case wstr( "111" )
			case else
				CU_FAIL( )
			end select

			select case as const( fInteger( "111" ) )
			case 111
			case else
				CU_FAIL( )
			end select

			with( fPodUdt( "111" ) )
				CU_ASSERT( .i = 111 )
			end with

			scope
				var count = 0
				for i as integer = fInteger( "1" ) to 2
					count += 1
				next
				CU_ASSERT( count = 2 )
			end scope

			scope
				var count = 0
				for i as integer = 1 to fInteger( "3" )
					count += 1
				next
				CU_ASSERT( count = 3 )
			end scope

			scope
				var count = 0
				for i as integer = 1 to 10 step fInteger( "2" )
					count += 1
				next
				CU_ASSERT( count = 5 )
			end scope

			'' Static initialization tests with temp strings: the code here
			'' shouldn't crash (other than that we can't test much, since
			'' we can't count calls to fb_StrDelete() etc. - but we have
			'' the tempUdtArg tests for that anyways)
			staticVarInitExpr( )  '' 1st call (init done here)
			staticVarInitExpr( )  '' 2nd call (no init anymore)

			staticRedimBoundsExpr( )  '' 1st call (init done here)
			staticRedimBoundsExpr( )  '' 2nd call (no init anymore)
		END_TEST
	END_TEST_GROUP

END_SUITE
