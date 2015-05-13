# include "fbcu.bi"

namespace fbc_tests.structs.bitfield_init

type foo
	z:2 as integer
	a:4 as integer
	b:5 as integer
	c:6 as integer
	d:7 as integer
	e:8 as integer
end type

sub typeiniWithBitfields cdecl( )
	dim as foo bar = (1, 2, 3, 4)

	with bar
		CU_ASSERT( .z = 1 )
		CU_ASSERT( .a = 2 )
		CU_ASSERT( .b = 3 )
		CU_ASSERT( .c = 4 )
		CU_ASSERT( .d = 0 )
		CU_ASSERT( .e = 0 )
	end with
end sub

sub paddingBitsAreCleared cdecl( )
	type T
		as integer f1 : 1
		as integer f2 : 1
		as integer f3 : 1
		as integer f4 : 1
		as integer f5 : 28
		as integer f6 : 1
		as integer f7 : 1
		as integer f8 : 1
		as integer f9 : 1
	end type

	CU_ASSERT( sizeof( T ) = (sizeof( uinteger ) * 2) )

	scope
		dim as uinteger trash_the_stack_a_little1 = &hFFFFFFFFu
		dim as uinteger trash_the_stack_a_little2 = &hFFFFFFFFu
		CU_ASSERT( trash_the_stack_a_little1 = &hFFFFFFFFu )
		CU_ASSERT( trash_the_stack_a_little2 = &hFFFFFFFFu )
	end scope

	scope
		dim as T x = ( 0, 1, 0, 1, &b111, 0, 1, 0, 1 )

		CU_ASSERT( x.f1 = 0 )
		CU_ASSERT( x.f2 = 1 )
		CU_ASSERT( x.f3 = 0 )
		CU_ASSERT( x.f4 = 1 )
		CU_ASSERT( x.f5 = &b111 )
		CU_ASSERT( x.f6 = 0 )
		CU_ASSERT( x.f7 = 1 )
		CU_ASSERT( x.f8 = 0 )
		CU_ASSERT( x.f9 = 1 )

		dim as uinteger ptr p = cptr( uinteger ptr, @x )
		CU_ASSERT( p[0] = &b1111010 )
		CU_ASSERT( p[1] = &b1010 )
	end scope

	scope
		dim as uinteger i(0 to 1) = { &hFFFFFFFFu, &hFFFFFFFFu }
		CU_ASSERT( i(0) = &hFFFFFFFFu )
		CU_ASSERT( i(1) = &hFFFFFFFFu )

		dim as T ptr x = cptr( T ptr, @i(0) )
		*x = type<T>( 0, 1, 0, 1, &b111, 0, 1, 0, 1 )

		CU_ASSERT( x->f1 = 0 )
		CU_ASSERT( x->f2 = 1 )
		CU_ASSERT( x->f3 = 0 )
		CU_ASSERT( x->f4 = 1 )
		CU_ASSERT( x->f5 = &b111 )
		CU_ASSERT( x->f6 = 0 )
		CU_ASSERT( x->f7 = 1 )
		CU_ASSERT( x->f8 = 0 )
		CU_ASSERT( x->f9 = 1 )

		CU_ASSERT( i(0) = &b1111010 )
		CU_ASSERT( i(1) = &b1010 )
	end scope
end sub

private sub ctor( ) constructor
	fbcu.add_suite( "fbc_tests.structs.bitfield_init" )
	fbcu.add_test( "type initializers with bitfields", @typeiniWithBitfields )
	fbcu.add_test( "clearing of padding bits", @paddingBitsAreCleared )
end sub

end namespace
