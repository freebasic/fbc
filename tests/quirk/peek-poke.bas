#include "fbcunit.bi"

SUITE( fbc_tests.quirk.peek_poke )

	TEST( peek_ )
		dim as ubyte b = 123
		dim as ubyte ptr pb = @b

		'' Simple cases
		CU_ASSERT( peek( @b ) = 123 )
		CU_ASSERT( peek( pb ) = 123 )
		CU_ASSERT( peek( ubyte, pb ) = 123 )
		CU_ASSERT( peek( typeof( b ), pb ) = 123 )

		'' Typedef vs. variable of same name
		type pb as ubyte
		CU_ASSERT( peek( pb, @b ) = 123 )
		CU_ASSERT( peek( pb, pb ) = 123 )

		'' Simple array access
		dim as ubyte ptr array(0 to 1)
		array(0) = pb
		CU_ASSERT( peek( array(0) ) = 123 )

		'' Typedef/array access disambiguation
		type array as ubyte
		CU_ASSERT( peek( array(0) ) = 123 )
		CU_ASSERT( peek( array, array(0) ) = 123 )

		'' Same for [] indexing
		dim as ubyte ptr ptr ppb = @pb
		CU_ASSERT( peek( ppb[0] ) = 123 )

		type ppb as ubyte
		CU_ASSERT( peek( ppb[0] ) = 123 )
		CU_ASSERT( peek( ppb, ppb[0] ) = 123 )

		'' Typedef vs. variable of same name, but this is an expression,
		'' not a type, due to the '+' operator.
		CU_ASSERT( peek( pb + 0 ) = 123 )
		CU_ASSERT( peek( pb, pb + 0 ) = 123 )

		dim as uinteger ui = &hAABBCCDDu
		CU_ASSERT( peek( @ui ) = &hDDu )  '' Treated as Byte Ptr -- assuming little endian
		CU_ASSERT( peek( uinteger, @ui ) = &hAABBCCDDu )
	END_TEST

	TEST( poke_ )
		dim as ubyte b
		dim as ubyte ptr pb = @b

		#macro check( pokeargs... )
			b = 0
			poke pokeargs, 123
			CU_ASSERT( b = 123 )
		#endmacro

		'' Simple cases
		check( @b )
		check( pb )
		check( ubyte, pb )
		check( typeof( b ), pb )

		'' Typedef vs. variable of same name
		type pb as ubyte
		check( pb, @b )
		check( pb, pb )

		'' Simple array access
		dim as ubyte ptr array(0 to 1)
		array(0) = pb
		check( array(0) )

		'' Typedef/array access disambiguation
		type array as ubyte
		check( array(0) )
		check( array, array(0) )

		'' Same for [] indexing
		dim as ubyte ptr ptr ppb = @pb
		check( ppb[0] )

		type ppb as ubyte
		check( ppb[0] )
		check( ppb, ppb[0] )

		'' Typedef vs. variable of same name, but this is an expression,
		'' not a type, due to the '+' operator.
		check( pb + 0 )
		check( pb, pb + 0 )

		dim as uinteger ui
		poke @ui, &hAABBCCDDu     '' Treated as Byte Ptr,
		CU_ASSERT( ui = &hDDu )   '' assuming little endian

		ui = 0
		poke uinteger, @ui, &hAABBCCDDu
		CU_ASSERT( ui = &hAABBCCDDu )
	END_TEST

END_SUITE
