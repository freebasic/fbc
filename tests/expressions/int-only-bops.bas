# include once "fbcunit.bi"

SUITE( fbc_tests.expressions.int_only_bops )

	TEST( testproc )
		#macro testCommutativeBop( a, bop, b, result )
			CU_ASSERT( ((a) bop (b)) = (result) )
			CU_ASSERT( ((b) bop (a)) = (result) )
			scope
				dim aa as typeof(a) = a
				dim bb as typeof(b) = b
				CU_ASSERT( ((aa) bop (bb)) = (result) )
				CU_ASSERT( ((bb) bop (aa)) = (result) )
			end scope
		#endmacro

		testCommutativeBop( 0   , or, 2147483647.0, 2147483647  )
		testCommutativeBop( 0u  , or, 2147483647.0, 2147483647u )
		testCommutativeBop( 0u  , or, 2147483648.0, 2147483648u )
		testCommutativeBop( 0u  , or, 4294967295.0, 4294967295u )
		testCommutativeBop( 0ll , or,          4294967296.0 , 4294967296ll  )
		testCommutativeBop( 0ll , or,  clngint(4294967296.0), 4294967296ll  )
		testCommutativeBop( 0ull, or,          4294967296.0 , 4294967296ull )
		testCommutativeBop( 0ull, or, culngint(4294967296.0), 4294967296ull )

		#macro testBop( l, bop, r, result )
			CU_ASSERT( ((l) bop (r)) = (result) )
			scope
				dim ll as typeof(l) = l
				dim rr as typeof(r) = r
				CU_ASSERT( ((ll) bop (rr)) = (result) )
			end scope
		#endmacro

		testBop( 1230000000000ll, \, 10 ^ 10, 123 )
		testBop( (10 ^ 10) * 123, \, 10000000000ll, 123 )
	END_TEST

END_SUITE
