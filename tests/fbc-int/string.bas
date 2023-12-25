#include "fbcunit.bi"
#include "fbc-int/string.bi"

'' tests for string descriptor internals and low level string functions

#ifndef NULL
#define NULL cast( const any ptr, 0 )
#endif

SUITE( fbc_tests.fbc_int.string_ )


	TEST( struct )
		dim sd as fbc.FBSTRING
		CU_ASSERT( sizeof(sd.data) = sizeof(any ptr) )
		CU_ASSERT( sizeof(sd.len) = sizeof(integer) )
		CU_ASSERT( sizeof(sd.size) = sizeof(integer) )
		CU_ASSERT( sizeof(fbc.FBSTRING) = sizeof(any ptr) + 2*sizeof(integer) )
	END_TEST

	#macro check_string( s, hasdata, expected_len )
		if( s ) then
			if( hasdata ) then
				CU_ASSERT( s->data <> 0 )
				CU_ASSERT( s->size > 0 )
				CU_ASSERT( s->len = expected_len )
			else
				CU_ASSERT( s->data = 0 )
				CU_ASSERT( s->size = 0 )
				CU_ASSERT( s->len = 0 )
			end if
			CU_ASSERT( s->size >= s->len )
		else
			CU_FAIL()
		end if
	#endmacro

	TEST( init )
		dim s as string
		var s1 = @s
		var s2 = cast( fbc.FBSTRING ptr, @s )

		CU_ASSERT( s1 = s2 )

		CU_ASSERT( s2->data = NULL )
		CU_ASSERT( s2->len = 0 )
		CU_ASSERT( s2->size = 0 )
	END_TEST

	TEST( dim_ )
		dim s as string
		check_string( cast(fbc.FBSTRING ptr, @s), FALSE, 0 )

		s = ""
		check_string( cast(fbc.FBSTRING ptr, @s), FALSE, 0 )

		s = "hello"
		check_string( cast(fbc.FBSTRING ptr, @s), TRUE, 5 )

		s = ""
		check_string( cast(fbc.FBSTRING ptr, @s), FALSE, 0 )

		s = "hello"
		check_string( cast(fbc.FBSTRING ptr, @s), TRUE, 5 )

		fbc.fb_strDelete( cast(fbc.FBSTRING ptr, @s) )
		check_string( cast(fbc.FBSTRING ptr, @s), FALSE, 0 )

	END_TEST

	TEST( leftSelf_ )
		dim s as string
		var p = cast(fbc.FBSTRING ptr, @s)
		dim size as integer

		s = "abcdef"
		CU_ASSERT( p->data <> NULL )
		CU_ASSERT( p->len = 6 )
		CU_ASSERT( p->size > 0 )
		CU_ASSERT( s = "abcdef" )
		size = p->size

		FBC.LeftSelf( s, len(s) - 1 )
		CU_ASSERT( p->data <> NULL )
		CU_ASSERT( p->len = 5 )
		CU_ASSERT( p->size = size )
		CU_ASSERT( s = "abcde" )

		FBC.LeftSelf( s, len(s) - 1 )
		CU_ASSERT( p->data <> NULL )
		CU_ASSERT( p->len = 4 )
		CU_ASSERT( p->size = size )
		CU_ASSERT( s = "abcd" )

		FBC.LeftSelf( s, len(s) - 1 )
		CU_ASSERT( p->data <> NULL )
		CU_ASSERT( p->len = 3 )
		CU_ASSERT( p->size = size )
		CU_ASSERT( s = "abc" )

		FBC.LeftSelf( s, len(s) - 1 )
		CU_ASSERT( p->data <> NULL )
		CU_ASSERT( p->len = 2 )
		CU_ASSERT( p->size = size )
		CU_ASSERT( s = "ab" )

		FBC.LeftSelf( s, len(s) - 1 )
		CU_ASSERT( p->data <> NULL )
		CU_ASSERT( p->len = 1 )
		CU_ASSERT( p->size = size )
		CU_ASSERT( s = "a" )

		FBC.LeftSelf( s, len(s) - 1 )
		CU_ASSERT( p->data <> NULL )
		CU_ASSERT( p->len = 0 )
		CU_ASSERT( p->size = size )
		CU_ASSERT( s = "" )

		FBC.LeftSelf( s, len(s) - 1 )
		CU_ASSERT( p->data <> NULL )
		CU_ASSERT( p->len = 0 )
		CU_ASSERT( p->size = size )
		CU_ASSERT( s = "" )

		FBC.LeftSelf( s, 0 )
		CU_ASSERT( p->data <> NULL )
		CU_ASSERT( p->len = 0 )
		CU_ASSERT( p->size = size )
		CU_ASSERT( s = "" )

		'' delete string
		s = ""
		CU_ASSERT( p->data = NULL )
		CU_ASSERT( p->len = 0 )
		CU_ASSERT( p->size = 0 )

		FBC.LeftSelf( s, 0 )
		CU_ASSERT( p->data = NULL )
		CU_ASSERT( p->len = 0 )
		CU_ASSERT( p->size = 0 )

	END_TEST

	TEST( concat_no_resize )
		dim s as string = string( 100, 32 )
		var p = cast(fbc.FBSTRING ptr, @s)
		dim size as integer

		CU_ASSERT( p->data <> NULL )
		CU_ASSERT( p->len = 100 )
		CU_ASSERT( p->size > 100 )
		size = p->size 

		FBC.LeftSelf( s, 0 )
		CU_ASSERT( p->data <> NULL )
		CU_ASSERT( p->len = 0 )
		CU_ASSERT( p->size = size )

		for i as integer = 1 to 100
			s += "A"
			CU_ASSERT( p->data <> NULL )
			CU_ASSERT( p->len = i )
			CU_ASSERT( p->size = size )
		next

	END_TEST

END_SUITE
