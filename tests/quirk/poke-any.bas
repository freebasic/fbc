#include "fbcunit.bi"

'' tests for low level memory function

SUITE( fbc_tests.quirk.poke_any )

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

		check_type( ubyte ptr  , cast( any ptr, &h12345678) )
		check_type( any ptr    , cast( any ptr, &h12345678) )
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

	#macro chk_string( s, n, didx, sidx, count, v1, v2 )

		s = v1
		poke any, s[didx], s[sidx], 10
		CU_ASSERT( s = v2 )

	#endmacro

	TEST( zstrings )
		dim a as zstring * 25

		chk_string( a, 20, 0, 0, 10, "ABCDE1234567890VWXYZ", _
		                             "ABCDE1234567890VWXYZ" )

		chk_string( a, 20, 0, 5, 10, "ABCDE1234567890VWXYZ", _
		                             "123456789067890VWXYZ" )

		chk_string( a, 20, 5, 0, 10, "ABCDE1234567890VWXYZ", _
		                             "ABCDEABCDE12345VWXYZ" )

		chk_string( a, 20, 2, 7, 10, "ABCDE1234567890VWXYZ", _
		                             "AB34567890VW890VWXYZ" )

		chk_string( a, 20, 7, 2, 10, "ABCDE1234567890VWXYZ", _
		                             "ABCDE12CDE1234567XYZ" )

	END_TEST

	TEST( strings )
		dim a as string

		chk_string( a, 20, 0, 0, 10, "ABCDE1234567890VWXYZ", _
		                             "ABCDE1234567890VWXYZ" )

		chk_string( a, 20, 0, 5, 10, "ABCDE1234567890VWXYZ", _
		                             "123456789067890VWXYZ" )

		chk_string( a, 20, 5, 0, 10, "ABCDE1234567890VWXYZ", _
		                             "ABCDEABCDE12345VWXYZ" )

		chk_string( a, 20, 2, 7, 10, "ABCDE1234567890VWXYZ", _
		                             "AB34567890VW890VWXYZ" )

		chk_string( a, 20, 7, 2, 10, "ABCDE1234567890VWXYZ", _
		                             "ABCDE12CDE1234567XYZ" )

	END_TEST

	TEST( string_copy )

		dim a as string = "0123456789ABCDEF"
		dim b as string = space( len(a) )

		poke any, b[0], a[0], len(a)
		CU_ASSERT( a = b )
		
	END_TEST

	TEST( array )

		#macro init_array( a, s, e )
			for i as integer = s to e
				a(i) = i
			next
		#endmacro

		#macro move_array( a, d, s, n )
			if( d < s ) then
				for i as integer = 0 to n-1
					a( d+i ) = a( s+i )
				next
			else
				for i as integer = n-1 to 0 step -1
					a( d+i ) = a( s+i )
				next 
			end if
		#endmacro

		#macro check_array( a, b, s, e )
			scope
				var same = 0
				for i as integer = s to e
					if( a(i) = b(i) ) then
						same += 1
					end if
				next
				if( same = (e-s+1) ) then
					CU_PASS( )
				else
					CU_FAIL( )
				end if
			end scope

		#endmacro

		dim a( 1 to 100 ) as integer
		dim b( 1 to 100 ) as integer

		init_array( a, 1, 100 )
		init_array( b, 1, 100 )

		'' move to higher overlapping location
		poke any, a(20), a(30), 40*sizeof(integer)
		move_array( b, 20, 30, 40 )
		check_array( a, b, 1, 100 )

		init_array( a, 1, 100 )
		init_array( b, 1, 100 )

		'' move to higher overlapping location
		poke any, a(30), a(20), 40*sizeof(integer)
		move_array( b, 30, 20, 40 )
		check_array( a, b, 1, 100 )

	END_TEST

END_SUITE
