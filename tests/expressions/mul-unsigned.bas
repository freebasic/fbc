# include once "fbcu.bi"

namespace fbc_tests.expressions.mulunsigned

private sub testUlongint cdecl( )
	#macro test( NA, NB, NR )
		scope
			dim as ulongint a, b, r

			CU_ASSERT( (NA * NB) = NR )

			a = NA
			b = NB
			CU_ASSERT( (a * b) = NR )

			a = NA
			b = NB
			r = a * b
			CU_ASSERT( r = NR )

			CU_ASSERT( (culngint( NA ) * culngint( NB )) = culngint( NR ) )

			a = culngint( NA )
			b = culngint( NB )
			CU_ASSERT( (a * b) = culngint( NR ) )

			a = culngint( NA )
			b = culngint( NB )
			r = a * b
			CU_ASSERT( r = culngint( NR ) )
		end scope
	#endmacro

	test( 0ull, 0ull, 0ull )
	test( 1ull, 1ull, 1ull )
	test( 1ull, 0ull, 0ull )
	test( 0ull, 1ull, 0ull )
	test( 2ull, 2ull, 4ull )
	test( 3ull, 3ull, 9ull )
	test( 2ull, 5ull, 10ull )
	test( &h7FFFFFFFFFFFFFFFull, 1ull, &h7FFFFFFFFFFFFFFFull )
	test( &h8000000000000000ull, 1ull, &h8000000000000000ull )
	test( &hFFFFFFFFFFFFFFFFull, 1ull, &hFFFFFFFFFFFFFFFFull )
	test( &h8000000000000000ull, &h8000000000000000ull, 0ull )
	test( &h7FFFFFFFFFFFFFFFull, &h7FFFFFFFFFFFFFFFull, 1ull )
	test( &hFFFFFFFFFFFFFFFFull, &hFFFFFFFFFFFFFFFFull, 1ull )
	test( 5000ull, 5000ull, 25000000ull )
	test( 50000ull, 50000ull, 2500000000ull )
	test( 500000ull, 500000ull, 250000000000ull )
	test( &h12A05F200ull, &h12A05F200ull, &h5af1d78b58c40000ull )
end sub

private sub testUinteger cdecl( )
	#macro test( NA, NB, NR )
		scope
			dim as uinteger a, b, r

			CU_ASSERT( (NA * NB) = NR )

			a = NA
			b = NB
			CU_ASSERT( (a * b) = NR )

			a = NA
			b = NB
			r = a * b
			CU_ASSERT( r = NR )

			CU_ASSERT( (cuint( NA ) * cuint( NB )) = cuint( NR ) )

			a = cuint( NA )
			b = cuint( NB )
			CU_ASSERT( (a * b) = cuint( NR ) )

			a = cuint( NA )
			b = cuint( NB )
			r = a * b
			CU_ASSERT( r = cuint( NR ) )
		end scope
	#endmacro

	test( 0u, 0u, 0u )
	test( 1u, 1u, 1u )
	test( 1u, 0u, 0u )
	test( 0u, 1u, 0u )
	test( 2u, 2u, 4u )
	test( 3u, 3u, 9u )
	test( 2u, 5u, 10u )
#ifdef __FB_64BIT__
	test( &h7FFFFFFFFFFFFFFFull, 1ull, &h7FFFFFFFFFFFFFFFull )
	test( &h8000000000000000ull, 1ull, &h8000000000000000ull )
	test( &hFFFFFFFFFFFFFFFFull, 1ull, &hFFFFFFFFFFFFFFFFull )
	test( &h8000000000000000ull, &h8000000000000000ull, 0ull )
	test( &h7FFFFFFFFFFFFFFFull, &h7FFFFFFFFFFFFFFFull, 1ull )
	test( &hFFFFFFFFFFFFFFFFull, &hFFFFFFFFFFFFFFFFull, 1ull )
#else
	test( &h7FFFFFFFu, 1u, &h7FFFFFFFu )
	test( &h80000000u, 1u, &h80000000u )
	test( &hFFFFFFFFu, 1u, &hFFFFFFFFu )
	test( &h80000000u, &h80000000u, 0u )
	test( &h7FFFFFFFu, &h7FFFFFFFu, 1u )
	test( &hFFFFFFFFu, &hFFFFFFFFu, 1u )
#endif
	test( 5000u, 5000u, 25000000u )
	test( 50000u, 50000u, 2500000000u )
#ifdef __FB_64BIT__
	test( 50000u, 500000u, 25000000000u )
#else
	test( 50000u, 500000u, 3525163520u )
#endif
end sub

private sub testUlong cdecl( )
	#macro test( NA, NB, NR )
		scope
			dim as ulong a, b, r

			CU_ASSERT( (NA * NB) = NR )

			a = NA
			b = NB
			CU_ASSERT( (a * b) = NR )

			a = NA
			b = NB
			r = a * b
			CU_ASSERT( r = NR )

			CU_ASSERT( (culng( NA ) * culng( NB )) = culng( NR ) )

			a = culng( NA )
			b = culng( NB )
			CU_ASSERT( (a * b) = culng( NR ) )

			a = culng( NA )
			b = culng( NB )
			r = a * b
			CU_ASSERT( r = culng( NR ) )
		end scope
	#endmacro

	#macro test64bitResult( NA, NB, NR )
		scope
			dim as ulong a, b
			dim as ulongint r

			CU_ASSERT( (NA * NB) = culngint( NR ) )

			a = NA
			b = NB
			CU_ASSERT( (a * b) = culngint( NR ) )

			a = NA
			b = NB
			r = a * b
			CU_ASSERT( r = culngint( NR ) )

			CU_ASSERT( (culng( NA ) * culng( NB )) = culngint( NR ) )

			a = culng( NA )
			b = culng( NB )
			CU_ASSERT( (a * b) = culngint( NR ) )

			a = culng( NA )
			b = culng( NB )
			r = a * b
			CU_ASSERT( r = culngint( NR ) )
		end scope
	#endmacro

	test( 0ul, 0ul, 0ul )
	test( 1ul, 1ul, 1ul )
	test( 1ul, 0ul, 0ul )
	test( 0ul, 1ul, 0ul )
	test( 2ul, 2ul, 4ul )
	test( 3ul, 3ul, 9ul )
	test( 2ul, 5ul, 10ul )
	test( &h7FFFFFFFul, 1ul, &h7FFFFFFFul )
	test( &h80000000ul, 1ul, &h80000000ul )
	test( &hFFFFFFFFul, 1ul, &hFFFFFFFFul )
#ifdef __FB_64BIT__
	'' On 64bit, the multiplication returns a 64bit uinteger; the 32bit
	'' operands are promoted to 64bit
	test64bitResult( &h80000000ul, &h80000000ul, &h4000000000000000u )
	test64bitResult( &h7FFFFFFFul, &h7FFFFFFFul, &h3FFFFFFF00000001u )
	test64bitResult( &hFFFFFFFFul, &hFFFFFFFFul, &hFFFFFFFE00000001u )
#else
	test( &h80000000ul, &h80000000ul, 0ul )
	test( &h7FFFFFFFul, &h7FFFFFFFul, 1ul )
	test( &hFFFFFFFFul, &hFFFFFFFFul, 1ul )
#endif
	test( 5000ul, 5000ul, 25000000ul )
	test( 50000ul, 50000ul, 2500000000ul )
#ifdef __FB_64BIT__
	test64bitResult( 50000ul, 500000ul, 25000000000u )
#else
	test( 50000ul, 500000ul, 3525163520ul )
#endif
end sub

private sub testUshort cdecl( )
	#macro test1( NA, NB, NR )
		scope
			dim as ushort a, b

			CU_ASSERT( (NA * NB) = NR )
			CU_ASSERT( (cushort( NA ) * cushort( NB )) = NR )

			a = NA
			b = NB
			CU_ASSERT( (a * b) = NR )
		end scope
	#endmacro

	#macro test2( NA, NB, NR )
		scope
			dim as ushort a, b, r

			'' Truncating the result
			CU_ASSERT( cushort( NA * NB ) = NR )
			CU_ASSERT( cushort( cushort( NA ) * cushort( NB ) ) = NR )

			a = NA
			b = NB
			r = a * b
			CU_ASSERT( r = NR )

			a = NA
			b = NB
			CU_ASSERT( cushort( a * b ) = NR )
		end scope
	#endmacro

	test1( 0u, 0u, 0u )
	test1( 1u, 1u, 1u )
	test1( 1u, 0u, 0u )
	test1( 0u, 1u, 0u )
	test1( 2u, 2u, 4u )
	test1( 3u, 3u, 9u )
	test1( 2u, 5u, 10u )
	test1( &h7FFFu, 1u, &h7FFFu )
	test1( &h8000u, 1u, &h8000u )
	test1( &hFFFFu, 1u, &hFFFFu )
	test1( &h8000u, &h8000u, &h40000000u )
	test1( &h7FFFu, &h7FFFu, &h3FFF0001u )
	test1( &hFFFFu, &hFFFFu, &hFFFE0001u )
	test1( 5u, 5u, 25u )
	test1( 50u, 5u, 250u )
	test1( 50u, 50u, 2500u )

	test2( 0u, 0u, 0u )
	test2( 1u, 1u, 1u )
	test2( 1u, 0u, 0u )
	test2( 0u, 1u, 0u )
	test2( 2u, 2u, 4u )
	test2( 3u, 3u, 9u )
	test2( 2u, 5u, 10u )
	test2( &h7FFFu, 1u, &h7FFFu )
	test2( &h8000u, 1u, &h8000u )
	test2( &hFFFFu, 1u, &hFFFFu )
	test2( &h8000u, &h8000u, &h0000u )
	test2( &h7FFFu, &h7FFFu, &h0001u )
	test2( &hFFFFu, &hFFFFu, &h0001u )
	test2( 5u, 5u, 25u )
	test2( 50u, 5u, 250u )
	test2( 50u, 50u, 2500u )
end sub

private sub testUbyte cdecl( )
	#macro test1( NA, NB, NR )
		scope
			dim as ubyte a, b

			CU_ASSERT( (NA * NB) = NR )
			CU_ASSERT( (cubyte( NA ) * cubyte( NB )) = NR )

			a = NA
			b = NB
			CU_ASSERT( (a * b) = NR )
		end scope
	#endmacro

	#macro test2( NA, NB, NR )
		scope
			dim as ubyte a, b, r

			'' Truncating the result
			CU_ASSERT( cubyte( NA * NB ) = NR )
			CU_ASSERT( cubyte( cubyte( NA ) * cubyte( NB ) ) = NR )

			a = NA
			b = NB
			r = a * b
			CU_ASSERT( r = NR )

			a = NA
			b = NB
			CU_ASSERT( cubyte( a * b ) = NR )
		end scope
	#endmacro

	test1( 0u, 0u, 0u )
	test1( 1u, 1u, 1u )
	test1( 1u, 0u, 0u )
	test1( 0u, 1u, 0u )
	test1( 2u, 2u, 4u )
	test1( 3u, 3u, 9u )
	test1( 2u, 5u, 10u )
	test1( &h7Fu, 1u, &h7Fu )
	test1( &h80u, 1u, &h80u )
	test1( &hFFu, 1u, &hFFu )
	test1( &h80u, &h80u, &h4000u )
	test1( &h7Fu, &h7Fu, &h3F01u )
	test1( &hFFu, &hFFu, &hFE01u )
	test1( 5u, 5u, 25u )
	test1( 50u, 5u, 250u )
	test1( &h32u, &h32u, &h9C4u )

	test2( 0u, 0u, 0u )
	test2( 1u, 1u, 1u )
	test2( 1u, 0u, 0u )
	test2( 0u, 1u, 0u )
	test2( 2u, 2u, 4u )
	test2( 3u, 3u, 9u )
	test2( 2u, 5u, 10u )
	test2( &h7Fu, 1u, &h7Fu )
	test2( &h80u, 1u, &h80u )
	test2( &hFFu, 1u, &hFFu )
	test2( &h80u, &h80u, &h00u )
	test2( &h7Fu, &h7Fu, &h01u )
	test2( &hFFu, &hFFu, &h01u )
	test2( 5u, 5u, 25u )
	test2( 50u, 5u, 250u )
	test2( &h32u, &h32u, &hC4u )
end sub

private sub testRegression1 cdecl( )
	'' This shouldn't crash
	type UDT
		i as uinteger
	end type

	dim as integer a
	dim as integer ptr p = @a
	dim as UDT x
	with x
		a = *p + .i * (*p + .i * *p)
		a = *p + .i * (*p + .i * *p)
	end with
end sub

private sub ctor( ) constructor
	fbcu.add_suite("fbc_tests.expressions.mul-unsigned")
	fbcu.add_test( "ulongint", @testUlongint )
	fbcu.add_test( "uinteger", @testUinteger )
	fbcu.add_test( "ulong", @testUlong )
	fbcu.add_test( "ushort", @testUshort )
	fbcu.add_test( "ubyte", @testUbyte )
	fbcu.add_test( "regression test #1", @testRegression1 )
end sub

end namespace 
