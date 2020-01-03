#include "fbcunit.bi"

'' tests for low level memory function

SUITE( fbc_tests.fbc_int.poke_any )

	const BUFF_SIZE = 20

	#macro check( b1, b2, count )
		scope
			var same = 0
			for i as integer = 0 to count-1
				if( b2[i] = b2[i] ) then
					same += 1
				end if
			next
			if( same = count ) then
				CU_PASS( )
			else
				CU_FAIL( )
			end if
		end scope
	#endmacro

	#macro check_type( T, value )
		scope
			dim x as T = value
			dim y as T
			poke any, x, y, sizeof( t )
			check( cast( ubyte ptr, @x), cast( ubyte ptr, @y), sizeof(t) )
		end scope
	#endmacro

	TEST( types )
		check_type( byte    , &h12 )
		check_type( ubyte   , &h12 )
		check_type( short   , &h1234 )
		check_type( ushort  , &h1234 )
		check_type( long    , &h12345678 )
		check_type( ulong   , &h12345678 )
		check_type( integer , 1 )
		check_type( uinteger, 1 )
		check_type( longint , &h123456789abcdef )
		check_type( ulongint, &h123456789abcdef )
		check_type( double  , 123.456 )
		check_type( single  , 123.456 )
	END_TEST


	TEST( memmove_ )

		#macro init_buffer( p )
			for i as integer = 0 to BUFF_SIZE-1
				p[i] = i
			next
		#endmacro

		#macro move_to_idx( p, idx, count )
			for i as integer = count-1 to 0 step -1
				p[idx+i] = p[i]
			next
		#endmacro

		#macro move_from_idx( p, idx, count )
			for i as integer = 0 to count-1
				p[i] = p[idx+i]
			next
		#endmacro

		const index = BUFF_SIZE \ 4
		const bytes = BUFF_SIZE \ 2

		dim p1 as ubyte ptr = callocate( BUFF_SIZE )
		dim p2 as ubyte ptr = callocate( BUFF_SIZE )

		init_buffer( p1 )
		init_buffer( p2 )

		'' move to higher overlapping location
		poke any, *(p1 + index), *p1, bytes
		move_to_idx( p2, index, bytes )
		check( p1, p2, BUFF_SIZE )

		init_buffer( p1 )
		init_buffer( p2 )
		
		'' move to lower overlapping location
		poke any, *p1, *(p1 + index), bytes
		move_from_idx( p2, index, bytes )
		check( p1, p2, BUFF_SIZE )

		deallocate( p1 )
		deallocate( p2 )

	END_TEST

END_SUITE
