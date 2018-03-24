#include "fbcunit.bi"

SUITE( fbc_tests.compound.with_ )

	''
	TEST_GROUP( basics )

		dim shared i as integer = 123

		type UDT
			i as integer
		end type

		type CtorUdt
			i as integer
			declare constructor( byval as integer )
		end type

		constructor CtorUdt( byval i as integer )
			this.i = i + 1
		end constructor

		TEST( default )
			dim as UDT x1, x2
			x1.i = 456

			with( x1 )
				CU_ASSERT( .i = 456 )
			end with

			with( x2 )
				CU_ASSERT( .i = 0 )
			end with

			with( x1 )
				with( x2 )
					CU_ASSERT( .i = 0 )
				end with
			end with

			with( x2 )
				with( x1 )
					CU_ASSERT( .i = 456 )
				end with
			end with

			dim as UDT ptr p1 = @x1, p2 = @x2

			with( *p1 )
				CU_ASSERT( .i = 456 )
			end with

			with( *p2 )
				CU_ASSERT( .i = 0 )
			end with

			with( *p1 )
				with( *p2 )
					CU_ASSERT( .i = 0 )
				end with
			end with

			with( *p2 )
				with( *p1 )
					CU_ASSERT( .i = 456 )
				end with
			end with

			with( type<UDT>( 123 ) )
				CU_ASSERT( .i = 123 )
			end with

			with( type<CtorUdt>( 123 ) )
				CU_ASSERT( .i = 124 )
			end with

			with( CtorUdt( 123 ) )
				CU_ASSERT( .i = 124 )
			end with
		END_TEST

	END_TEST_GROUP

	''
	TEST_GROUP( tempvarVsRecursion )
		type UDT
			i as integer
		end type

		dim shared as UDT x1 = ( 1 ), x2 = ( 2 )
		dim shared as UDT ptr p = @x1

		sub f1( ) static
			static reclevel as integer

			with( *p )
				if( reclevel = 0 ) then
					'' 1. Prove that WITH uses a temp var to store the address,
					'' and changing p won't change the address used in this WITH.
					CU_ASSERT(   .i = 1 )
					CU_ASSERT( p->i = 1 )
					p = @x2
					CU_ASSERT(   .i = 1 )
					CU_ASSERT( p->i = 2 )
					p = @x1
					CU_ASSERT(   .i = 1 )
					CU_ASSERT( p->i = 1 )

					'' 2. Then we should also be able to change p and do a
					'' recursive call, without changing the current WITH context,
					'' even though the WITH in that recursive call will use the
					'' different p address.
					p = @x2
					reclevel += 1 : f1( ) : reclevel -= 1
					CU_ASSERT(   .i = 1 )
					CU_ASSERT( p->i = 2 )
				else
					'' In the recursive call, we're using x2...
					CU_ASSERT(   .i = 2 )
					CU_ASSERT( p->i = 2 )
				end if
			end with
		end sub

		TEST( default )
			f1( )
		END_TEST

	END_TEST_GROUP

	''
	TEST_GROUP( implicitAddrOfPeek )
		type NormalUdt
			i as integer
		end type

		type DerivedUdt extends object
			j as integer
		end type

		TEST( default )
			dim pany as any ptr
			dim pinteger as integer ptr
			dim pnormal1 as NormalUdt ptr
			dim pderived1 as DerivedUdt ptr

			dim normal1 as NormalUdt
			dim derived1 as DerivedUdt

			normal1.i = 111
			pany = @normal1
			with peek( NormalUdt, pany )
				if 0 = len( .i ) then
				end if
				CU_ASSERT( .i = 111 )
				CU_ASSERT( sizeof( .i ) = sizeof( integer ) )
			end with

			derived1.j = 222
			pany = @derived1
			with peek( DerivedUdt, pany )
				if 0 = len( .j ) then
				end if
				CU_ASSERT( .j = 222 )
				CU_ASSERT( sizeof( .j ) = sizeof( integer ) )
			end with

			normal1.i = 333
			pinteger = cptr( integer ptr, @normal1 )
			with peek( NormalUdt, pinteger )
				if 0 = len( .i ) then
				end if
				CU_ASSERT( .i = 333 )
				CU_ASSERT( sizeof( .i ) = sizeof( integer ) )
			end with

			derived1.j = 444
			pinteger = cptr( integer ptr, cptr( any ptr, @derived1 ) )
			with peek( DerivedUdt, pinteger )
				if 0 = len( .j ) then
				end if
				CU_ASSERT( .j = 444 )
				CU_ASSERT( sizeof( .j ) = sizeof( integer ) )
			end with
		END_TEST

	END_TEST_GROUP

	''
	TEST_GROUP( functionResult )
		'' WITH must take special care when given a function call which returns
		'' an UDT, because it may be returned in registers on Win32.

		type ByteUdt
			i as byte
		end type

		type ShortUdt
			i as integer
		end type

		type IntegerUdt
			i as integer
		end type

		type BigUdt
			i(0 to 9) as integer
		end type

		function fByteUdt( byval i as integer ) as ByteUdt
			return type( i )
		end function

		function fShortUdt( byval i as integer ) as ShortUdt
			return type( i )
		end function

		function fIntegerUdt( byval i as integer ) as IntegerUdt
			return type( i )
		end function

		function fBigUdt( byval i as integer ) as BigUdt
			return type( { 0, 1, 2, 3, i, 5, 6, 7, 8, 9 } )
		end function

		TEST( default )
			with( fByteUdt( 111 ) )
				CU_ASSERT( .i = 111 )
			end with

			with( fShortUdt( 222 ) )
				CU_ASSERT( .i = 222 )
			end with

			with( fIntegerUdt( 333 ) )
				CU_ASSERT( .i = 333 )
			end with

			with( fBigUdt( 444 ) )
				CU_ASSERT( .i(0) = 0 )
				CU_ASSERT( .i(1) = 1 )
				CU_ASSERT( .i(2) = 2 )
				CU_ASSERT( .i(3) = 3 )
				CU_ASSERT( .i(4) = 444 )
				CU_ASSERT( .i(5) = 5 )
				CU_ASSERT( .i(6) = 6 )
				CU_ASSERT( .i(7) = 7 )
				CU_ASSERT( .i(8) = 8 )
				CU_ASSERT( .i(9) = 9 )
			end with
		END_TEST
	END_TEST_GROUP

	''
	TEST_GROUP( CtorsDtors )
		'' WITH should extend the lifetime of any temp vars from the given
		'' expression, such that they're not destroyed until END WITH (or any
		'' other EXIT/RETURN/GOTO out of the WITH block)

		const TRUE = -1
		const FALSE = 0
		dim shared zero as integer = 0  '' Helper var to ensure '*(@foo + 0)' won't be optimized to 'foo'

		dim shared as integer ctors, dtors

		type UDT
			as integer i, alive
			declare constructor( )
			declare constructor( i as integer )
			declare destructor( )
		end type

		constructor UDT( )
			CU_ASSERT( this.alive = FALSE )
			this.alive = TRUE
			ctors += 1
		end constructor

		constructor UDT( i as integer )
			CU_ASSERT( this.alive = FALSE )
			this.alive = TRUE
			ctors += 1
			this.i = i
		end constructor

		destructor UDT( )
			CU_ASSERT( this.alive )
			this.alive = FALSE
			dtors += 1
			this.i = &hDEADBEEF
		end destructor

		function f( byval i as integer ) as UDT
			CU_ASSERT( ctors = 1 )
			CU_ASSERT( dtors = 0 )
			function = type( i )
			CU_ASSERT( ctors = 2 )
			CU_ASSERT( dtors = 1 )
		end function

		TEST( default )
			ctors = 0
			dtors = 0
			scope
				dim x as UDT = UDT( 123 )
				CU_ASSERT( ctors = 1 )
				CU_ASSERT( dtors = 0 )
				with x
					CU_ASSERT( ctors = 1 )
					CU_ASSERT( dtors = 0 )
					CU_ASSERT( .i = 123 )
				end with
				CU_ASSERT( ctors = 1 )
				CU_ASSERT( dtors = 0 )
			end scope
			CU_ASSERT( ctors = 1 )
			CU_ASSERT( dtors = 1 )

			ctors = 0
			dtors = 0
			scope
				with type<UDT>( 123 )
					CU_ASSERT( ctors = 1 )
					CU_ASSERT( dtors = 0 )
					CU_ASSERT( .i = 123 )
				end with
				CU_ASSERT( ctors = 1 )
				CU_ASSERT( dtors = 1 )
			end scope
			CU_ASSERT( ctors = 1 )
			CU_ASSERT( dtors = 1 )

			ctors = 0
			dtors = 0
			scope
				with *(@type<UDT>( 123 ) + zero)
					CU_ASSERT( ctors = 1 )
					CU_ASSERT( dtors = 0 )
					CU_ASSERT( .i = 123 )
				end with
				CU_ASSERT( ctors = 1 )
				CU_ASSERT( dtors = 1 )
			end scope
			CU_ASSERT( ctors = 1 )
			CU_ASSERT( dtors = 1 )

			ctors = 0
			dtors = 0
			scope
				with f( 123 )
					CU_ASSERT( ctors = 2 )
					CU_ASSERT( dtors = 1 )
					CU_ASSERT( .i = 123 )
				end with
				CU_ASSERT( ctors = 2 )
				CU_ASSERT( dtors = 2 )
			end scope
			CU_ASSERT( ctors = 2 )
			CU_ASSERT( dtors = 2 )
		END_TEST

		sub exitSubTest1( )
			CU_ASSERT( ctors = 0 )
			CU_ASSERT( dtors = 0 )
			dim x as UDT = UDT( 123 )
			CU_ASSERT( ctors = 1 )
			CU_ASSERT( dtors = 0 )
			with x
				CU_ASSERT( ctors = 1 )
				CU_ASSERT( dtors = 0 )
				CU_ASSERT( .i = 123 )
				exit sub
				CU_FAIL( )
			end with
			CU_FAIL( )
		end sub

		sub exitSubTest2( )
			CU_ASSERT( ctors = 0 )
			CU_ASSERT( dtors = 0 )
			with type<UDT>( 123 )
				CU_ASSERT( ctors = 1 )
				CU_ASSERT( dtors = 0 )
				CU_ASSERT( .i = 123 )
				exit sub
				CU_FAIL( )
			end with
			CU_FAIL( )
		end sub

		sub exitSubTest3( )
			CU_ASSERT( ctors = 0 )
			CU_ASSERT( dtors = 0 )
			with *(@type<UDT>( 123 ) + zero)
				CU_ASSERT( ctors = 1 )
				CU_ASSERT( dtors = 0 )
				CU_ASSERT( .i = 123 )
				exit sub
				CU_FAIL( )
			end with
			CU_FAIL( )
		end sub

		sub exitSubTest4( )
			CU_ASSERT( ctors = 0 )
			CU_ASSERT( dtors = 0 )
			with f( 123 )
				CU_ASSERT( ctors = 2 )
				CU_ASSERT( dtors = 1 )
				CU_ASSERT( .i = 123 )
				exit sub
				CU_FAIL( )
			end with
			CU_FAIL( )
		end sub

		TEST( ScopeBreaks )
			''
			'' EXIT DO
			''

			ctors = 0
			dtors = 0
			do
				dim x as UDT = UDT( 123 )
				CU_ASSERT( ctors = 1 )
				CU_ASSERT( dtors = 0 )
				with x
					CU_ASSERT( ctors = 1 )
					CU_ASSERT( dtors = 0 )
					CU_ASSERT( .i = 123 )
					exit do
					CU_FAIL( )
				end with
				CU_FAIL( )
			loop
			CU_ASSERT( ctors = 1 )
			CU_ASSERT( dtors = 1 )

			ctors = 0
			dtors = 0
			do
				with type<UDT>( 123 )
					CU_ASSERT( ctors = 1 )
					CU_ASSERT( dtors = 0 )
					CU_ASSERT( .i = 123 )
					exit do
					CU_FAIL( )
				end with
				CU_FAIL( )
			loop
			CU_ASSERT( ctors = 1 )
			CU_ASSERT( dtors = 1 )

			ctors = 0
			dtors = 0
			do
				with *(@type<UDT>( 123 ) + zero)
					CU_ASSERT( ctors = 1 )
					CU_ASSERT( dtors = 0 )
					CU_ASSERT( .i = 123 )
					exit do
					CU_FAIL( )
				end with
				CU_FAIL( )
			loop
			CU_ASSERT( ctors = 1 )
			CU_ASSERT( dtors = 1 )

			ctors = 0
			dtors = 0
			do
				with f( 123 )
					CU_ASSERT( ctors = 2 )
					CU_ASSERT( dtors = 1 )
					CU_ASSERT( .i = 123 )
					exit do
					CU_FAIL( )
				end with
				CU_FAIL( )
			loop
			CU_ASSERT( ctors = 2 )
			CU_ASSERT( dtors = 2 )

			''
			'' EXIT SUB
			''

			ctors = 0
			dtors = 0
			exitSubTest1( )
			CU_ASSERT( ctors = 1 )
			CU_ASSERT( dtors = 1 )

			ctors = 0
			dtors = 0
			exitSubTest2( )
			CU_ASSERT( ctors = 1 )
			CU_ASSERT( dtors = 1 )

			ctors = 0
			dtors = 0
			exitSubTest3( )
			CU_ASSERT( ctors = 1 )
			CU_ASSERT( dtors = 1 )

			ctors = 0
			dtors = 0
			exitSubTest4( )
			CU_ASSERT( ctors = 2 )
			CU_ASSERT( dtors = 2 )
		END_TEST

		dim shared as integer udt2ctors, udt2dtors

		type UDT2
			px as UDT ptr
			declare constructor( byref as UDT )
			declare destructor( )
		end type

		constructor UDT2( byref x as UDT )
			'' Store address of the argument object. UDT2 can only access it
			'' as long as the UDT object stays alive, so this is potentially
			'' unsafe.
			this.px = @x
			udt2ctors += 1
		end constructor

		destructor UDT2( )
			udt2dtors += 1
		end destructor

		TEST( MultipleTemps )
			'' The live of *both* temporaries should be extended, not just
			'' the "toplevel" one which is accessed by the WITH.
			ctors = 0
			dtors = 0
			udt2ctors = 0
			udt2dtors = 0
			with UDT2( UDT( 123 ) )
				CU_ASSERT( ctors = 1 )
				CU_ASSERT( dtors = 0 )
				CU_ASSERT( udt2ctors = 1 )
				CU_ASSERT( udt2dtors = 0 )
				CU_ASSERT( .px->alive )
				CU_ASSERT( .px->i = 123 )
			end with
			CU_ASSERT( ctors = 1 )
			CU_ASSERT( dtors = 1 )
			CU_ASSERT( udt2ctors = 1 )
			CU_ASSERT( udt2dtors = 1 )
		END_TEST

	END_TEST_GROUP

END_SUITE
