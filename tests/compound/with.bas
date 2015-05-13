#include "fbcu.bi"

namespace fbc_tests.compound.with_

namespace basics
	dim shared i as integer = 123

	type UDT
		i as integer
	end type

	sub test cdecl( )
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
	end sub
end namespace

namespace tempvarVsRecursion
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

	sub test cdecl( )
		f1( )
	end sub
end namespace

namespace implicitAddrOfPeek
	type NormalUdt
		i as integer
	end type

	type DerivedUdt extends object
		j as integer
	end type

	sub test cdecl( )
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
	end sub
end namespace

private sub ctor( ) constructor
	fbcu.add_suite( "tests/compound/with" )
	fbcu.add_test( "basics", @basics.test )
	fbcu.add_test( "recursion", @tempvarVsRecursion.test )
	fbcu.add_test( "PEEK", @implicitAddrOfPeek.test )
end sub

end namespace
