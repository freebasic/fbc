# include "fbcunit.bi"

SUITE( fbc_tests.compound.for_ptr )

	TEST( for_pointer_counter )
		#macro buildTest( __TYPE__ )
			scope
				dim as __TYPE__ buff( 9 )
				dim as __TYPE__ ptr iBuffer = @buff( 0 )

				dim as integer c, stp
				for i as integer = 0 to 9
					iBuffer[i] = i
				next
				c = 0
				for i as __TYPE__ ptr = iBuffer to iBuffer + 9
					CU_ASSERT( *i = c )
					CU_ASSERT( i = ( c + iBuffer ) )
					c += 1
				next
				c = 9
				for i as __TYPE__ ptr = iBuffer + 9 to iBuffer step -1
					CU_ASSERT( *i = c )
					CU_ASSERT( i = ( c + iBuffer ) )
					c -= 1
				next
				c = 0
				stp = 2
				for i as __TYPE__ ptr = iBuffer + 9 to iBuffer step stp
					CU_ASSERT( *i = c )
					CU_ASSERT( i = ( c + iBuffer ) )
					c += 2
				next
			end scope
		#endmacro

		buildTest( byte )
		buildTest( short )
		buildTest( single )
		buildTest( double )
		buildTest( longint )

		type foo
			as any ptr x, y
		end type

		dim as foo buff( 9 )
		dim as foo ptr fBuffer  = @buff( 0 )
		dim as integer c
		'' Fill the x/y fields in the buffer with their own addresses
		for i as foo ptr = fBuffer to fBuffer + 9
			i->x = i
			i->y = i->x + offsetof( foo, y )
			CU_ASSERT( i = ( fBuffer +  c) )
			c += 1
		next

		'' Check the fields against their addresses
		dim as integer stp = 2
		for i as foo ptr = fBuffer to fBuffer + 9 step stp
			CU_ASSERT( i->x = @i->x )
			CU_ASSERT( i->y = @i->y )
		next
	END_TEST

	TEST( for_any_pointer )
		dim as integer array(0 to 3)

		for i as ubyte ptr = 0 to 3
			CU_ASSERT( cint( i ) >= 0 )
			CU_ASSERT( cint( i ) <= 3 )
			array(cint( i )) = cint( i )
		next

		'' Any Ptr should be treated as Byte Ptr, as in BOP pointer arithmetic
		for i as any ptr = 0 to 3
			CU_ASSERT( cint( i ) >= 0 )
			CU_ASSERT( cint( i ) <= 3 )
			CU_ASSERT( array(cint( i )) = cint( i ) )
		next

		type foo as bar

		'' Iterating on "foo ptr" isn't possible because sizeof( foo ) is
		'' unknown, but "foo ptr ptr" should work because sizeof( foo ptr )
		'' is known.
		for i as foo ptr ptr = 0 to 3
			CU_ASSERT( cint( i ) >= 0 )
			CU_ASSERT( cint( i ) <= 3 )
			CU_ASSERT( array(cint( i )) = cint( i ) )
		next
	END_TEST

END_SUITE
