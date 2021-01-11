#include "fbcunit.bi"

SUITE( fbc_tests.optimizations.vector )

	type FVec2
		as single x, y
	end type

	type FVec3
		as single x, y, z
	end type

	type FVec4
		as single x, y, z, w
	end type

	type DVec2
		as double x, y
	end type


	Dim As FVec2 a2, b2, c2
	Dim As FVec3 a3, b3, c3
	Dim As FVec4 a4, b4, c4
	Dim As DVec2 d, e, f


	''
	'' simple arithmetic (single precision)
	''

	'' -- FVec2 --

	TEST( fvec2_simple )

		a2 = type(1.5f,  0.75f)
		b2 = type(0.25f, 2.5f)

		c2.x = (a2.x + b2.x) * (a2.x - b2.x)
		c2.y = (a2.y + b2.y) * (a2.y - b2.y)

		CU_ASSERT_EQUAL( c2.x,  2.1875f )
		CU_ASSERT_EQUAL( c2.y, -5.6875f )

	END_TEST

	TEST( fvec2_swizzle )

		''tests swizzle

		a2 = type(0.8f,  1.2f)
		b2 = type(0.3f, -0.3f)

		c2.x = (a2.x - b2.x) / (a2.x + a2.y)
		c2.y = (a2.y - b2.y) / (a2.x + a2.y)

		CU_ASSERT_EQUAL( c2.x, 0.25f )
		CU_ASSERT_EQUAL( c2.y, 0.75f )

	END_TEST

	'' -- FVec3 --

	TEST( fvec3_simple )

		dim as FVec3 a3, b3, c3

		a3 = type(1.5f, 0.75f, 2.25f)
		b3 = type(0.25f, 2.5f, -1.75f)

		c3.x = (a3.x + b3.x) * (b3.x - a3.x)
		c3.y = (a3.y + b3.y) * (b3.y - a3.y)
		c3.z = (a3.z + b3.z) * (b3.z - a3.z)

		CU_ASSERT_EQUAL( c3.x, -2.1875f )
		CU_ASSERT_EQUAL( c3.y,  5.6875f )
		CU_ASSERT_EQUAL( c3.z, -2.0f	)

	END_TEST

	TEST( fvec3_swizzle )

		'' tests swizzle

		dim as FVec3 a3, b3, c3

		a3 = Type(1.5f, -4.5f, -4.5f)
		b3 = Type(2.5f, 1.5f,  0.5f)

		c3.x = (a3.x - b3.x) / (a3.x + b3.x)
		c3.y = (a3.y - b3.y) / (a3.y + b3.y)
		c3.z = (a3.z - b3.z) / (a3.z + b3.z)

		CU_ASSERT_EQUAL( c3.x, -0.25f )
		CU_ASSERT_EQUAL( c3.y,  2.0f  )
		CU_ASSERT_EQUAL( c3.z,  1.25f )

	END_TEST

	'' -- FVec4 --

	TEST( fvec4_simple )

		dim as FVec4 a4, b4, c4

		a4 = type(1.5f,  2.25f, -1.5f, -2.75f)
		b4 = type(0.25f, 3.5f,  -1.75f, 0.75f)

		c4.x = a4.x * b4.x + b4.x - a4.x
		c4.y = a4.y * b4.y + b4.y - a4.y
		c4.z = a4.z * b4.z + b4.z - a4.z
		c4.w = a4.w * b4.w + b4.w - a4.w

		CU_ASSERT_EQUAL( c4.x, -0.875f  )
		CU_ASSERT_EQUAL( c4.y,  9.125f  )
		CU_ASSERT_EQUAL( c4.z,  2.375f  )
		CU_ASSERT_EQUAL( c4.w,  1.4375f )

	END_TEST

	TEST( fvec4_swizzle )

		'' tests swizzle

		dim as FVec4 a4, b4, c4

		a4 = type(1.0f,   1.5f,  0.5f,  2.0f)
		b4 = type(0.25f, -0.25f, 2.0f, -1.75f)

		c4.x = (a4.x - b4.x) / (a4.x + b4.z)
		c4.y = (a4.y - b4.y) / (a4.y + b4.z)
		c4.z = (a4.z - b4.z) / (a4.z + b4.z)
		c4.w = (a4.w - b4.w) / (a4.w + b4.z)

		CU_ASSERT_EQUAL( c4.x,  0.25f   )
		CU_ASSERT_EQUAL( c4.y,  0.5f	)
		CU_ASSERT_EQUAL( c4.z, -0.6f	)
		CU_ASSERT_EQUAL( c4.w,  0.9375f )

	END_TEST

	''
	'' intra-expression vectorization (single precision)
	''
	TEST( fvec2_intra )

		dim as FVec2 a2, b2, c2

		a2 = type(1.5f,  0.25f)
		b2 = type(0.5f, -2.0f)

		c2.x = (a2.x + b2.x) + (a2.y + b2.y)
		c2.y = 0.0f

		CU_ASSERT_EQUAL( c2.x,  0.25f )
		CU_ASSERT_EQUAL( c2.y,  0.0f  )

	END_TEST

	TEST( fvec3_intra )

		dim as FVec3 a3, b3, c3
	
		#macro check( result, expr )
			c3.x = expr

			CU_ASSERT_EQUAL( c3.x,  result )
			CU_ASSERT_EQUAL( c3.y,  0f  )
			CU_ASSERT_EQUAL( c3.z,  0f  )
		#endmacro

		a3 = type(1f,  2f,  4f)
		b3 = type(8f, 16f, 32f)

		c3.y = 0.0f
		c3.z = 0.0f

		check(  1f, a3.x )
		check(  2f, a3.y )
		check(  3f, a3.x + a3.y )
		check(  3f, a3.y + a3.x )
		check(  4f, a3.z )
		check(  5f, a3.x + a3.z )
		check(  5f, a3.z + a3.x )
		check(  6f, a3.y + a3.z )
		check(  6f, a3.z + a3.y )
		check(  7f, a3.x + a3.y + a3.z )
		check(  7f, a3.y + a3.x + a3.z )
		check(  7f, a3.x + a3.z + a3.y )
		check(  7f, a3.z + a3.x + a3.y )
		check(  7f, a3.y + a3.z + a3.x )
		check(  7f, a3.z + a3.y + a3.x )

		'' mix in another source

		check( 17f, b3.y + a3.x )
		check( 18f, a3.y + b3.y )
		check( 19f, b3.y + a3.x + a3.y )
		check( 19f, a3.x + b3.y + a3.y )
		check( 19f, a3.x + a3.y + b3.y )
		check( 19f, b3.y + a3.y + a3.x )
		check( 19f, a3.y + b3.y + a3.x )
		check( 19f, a3.y + a3.x + b3.y )
		check( 20f, b3.y + a3.z )
		check( 20f, a3.z + b3.y )
		check( 21f, b3.y + a3.x + a3.z )
		check( 21f, a3.x + b3.y + a3.z )
		check( 21f, a3.x + a3.z + b3.y )
		check( 21f, b3.y + a3.z + a3.x )
		check( 21f, a3.z + b3.y + a3.x )
		check( 21f, a3.z + a3.x + b3.y )
		check( 22f, b3.y + a3.y + a3.z )
		check( 22f, a3.y + b3.y + a3.z )
		check( 22f, a3.y + a3.z + b3.y )
		check( 22f, b3.y + a3.z + a3.y )
		check( 22f, a3.z + b3.y + a3.y )
		check( 22f, a3.z + a3.y + b3.y )
		check( 23f, b3.y + a3.x + a3.y + a3.z )
		check( 23f, a3.x + b3.y + a3.y + a3.z )
		check( 23f, a3.x + a3.y + b3.y + a3.z )
		check( 23f, a3.x + a3.y + a3.z + b3.y )
		check( 23f, b3.y + a3.y + a3.x + a3.z )
		check( 23f, a3.y + b3.y + a3.x + a3.z )
		check( 23f, a3.y + a3.x + b3.y + a3.z )
		check( 23f, a3.y + a3.x + a3.z + b3.y )
		check( 23f, b3.y + a3.x + a3.z + a3.y )
		check( 23f, a3.x + b3.y + a3.z + a3.y )
		check( 23f, a3.x + a3.z + b3.y + a3.y )
		check( 23f, a3.x + a3.z + a3.y + b3.y )
		check( 23f, b3.y + a3.z + a3.x + a3.y )
		check( 23f, a3.z + b3.y + a3.x + a3.y )
		check( 23f, a3.z + a3.x + b3.y + a3.y )
		check( 23f, a3.z + a3.x + a3.y + b3.y )
		check( 23f, b3.y + a3.y + a3.z + a3.x )
		check( 23f, a3.y + b3.y + a3.z + a3.x )
		check( 23f, a3.y + a3.z + b3.y + a3.x )
		check( 23f, a3.y + a3.z + a3.x + b3.y )
		check( 23f, b3.y + a3.z + a3.y + a3.x )
		check( 23f, a3.z + b3.y + a3.y + a3.x )
		check( 23f, a3.z + a3.y + b3.y + a3.x )
		check( 23f, a3.z + a3.y + a3.x + b3.y )

	END_TEST

	TEST( fvec4_intra )

		dim as FVec4 a4, b4, c4
	
		#macro check( result, expr )
			c4.x = expr

			CU_ASSERT_EQUAL( c4.x,  result )
			CU_ASSERT_EQUAL( c4.y,  0f  )
			CU_ASSERT_EQUAL( c4.z,  0f  )
			CU_ASSERT_EQUAL( c4.w,  0f  )
		#endmacro

		#macro check3( r, a, b, c )
			check( r, a + b + c )
			check( r, b + a + c )
			check( r, a + c + b )
			check( r, c + a + b )
			check( r, b + c + a )
			check( r, c + b + a )
		#endmacro

		#macro check4( r, p, a, b, c )
			check( r, p + a + b + c )
			check( r, p + b + a + c )
			check( r, p + a + c + b )
			check( r, p + c + a + b )
			check( r, p + b + c + a )
			check( r, p + c + b + a )
		#endmacro

		a4 = type( 1f,  2f,  4f,   8f)
		b4 = type(16f, 32f, 64f, 128f)

		c4.y = 0.0f
		c4.z = 0.0f
		c4.w = 0.0f

		check (  1f, a4.x )
		check (  2f, a4.y )
		check (  3f, a4.x + a4.y )
		check (  3f, a4.y + a4.x )
		check (  4f, a4.z )
		check (  5f, a4.x + a4.z )
		check (  5f, a4.z + a4.x )
		check (  6f, a4.y + a4.z )
		check (  6f, a4.z + a4.y )
		check3(  7f, a4.x, a4.y, a4.z )
		check (  8f, a4.w )
		check (  9f, a4.x + a4.w )
		check (  9f, a4.w + a4.x )
		check ( 10f, a4.w + a4.y )
		check ( 10f, a4.y + a4.w )
		check3( 11f, a4.x, a4.y, a4.w )
		check ( 12f, a4.z + a4.w )
		check ( 12f, a4.w + a4.z )
		check3( 13f, a4.x, a4.z, a4.w )
		check3( 14f, a4.y, a4.z, a4.w )
		check4( 15f, a4.x, a4.y, a4.z, a4.w )
		check4( 15f, a4.y, a4.x, a4.z, a4.w )
		check4( 15f, a4.z, a4.x, a4.y, a4.w )
		check4( 15f, a4.w, a4.x, a4.y, a4.z )

		'' mix in another source

		check ( 33f, b4.y + a4.x )
		check ( 33f, a4.x + b4.y )

		check ( 34f, b4.y + a4.y )
		check ( 34f, a4.y + b4.y )

		check ( 35f, b4.y + a4.x + a4.y )
		check ( 35f, a4.x + b4.y + a4.y )
		check ( 35f, a4.x + a4.y + b4.y )

		check ( 35f, b4.y + a4.y + a4.x )
		check ( 35f, a4.y + b4.y + a4.x )
		check ( 35f, a4.y + a4.x + b4.y )

		check ( 36f, b4.y + a4.z )
		check ( 36f, a4.z + b4.y )

		check ( 37f, b4.y + a4.x + a4.z )
		check ( 37f, a4.x + b4.y + a4.z )
		check ( 37f, a4.x + a4.z + b4.y )

		check ( 37f, b4.y + a4.z + a4.x )
		check ( 37f, a4.z + b4.y + a4.x )
		check ( 37f, a4.z + a4.x + b4.y )

		check ( 38f, b4.y + a4.y + a4.z )
		check ( 38f, a4.y + b4.y + a4.z )
		check ( 38f, a4.y + a4.z + b4.y )

		check ( 38f, b4.y + a4.z + a4.y )
		check ( 38f, a4.z + b4.y + a4.y )
		check ( 38f, a4.z + a4.y + b4.y )

		check3( 39f, b4.y + a4.x, a4.y, a4.z )
		check3( 39f, a4.x, b4.y + a4.y, a4.z )
		check3( 39f, a4.x, a4.y, b4.y + a4.z )
		check3( 39f, a4.x, a4.y, a4.z + b4.y )

		check ( 40f, b4.y + a4.w )
		check ( 40f, a4.w + b4.y )

		check ( 41f, b4.y + a4.x + a4.w )
		check ( 41f, a4.x + b4.y + a4.w )
		check ( 41f, a4.x + a4.w + b4.y )

		check ( 41f, b4.y + a4.w + a4.x )
		check ( 41f, a4.w + b4.y + a4.x )
		check ( 41f, a4.w + a4.x + b4.y )

		check ( 42f, b4.y + a4.w + a4.y )
		check ( 42f, a4.w + b4.y + a4.y )
		check ( 42f, a4.w + a4.y + b4.y )

		check ( 42f, b4.y + a4.y + a4.w )
		check ( 42f, a4.y + b4.y + a4.w )
		check ( 42f, a4.y + a4.w + b4.y )

		check3( 43f, b4.y + a4.x, a4.y, a4.w )
		check3( 43f, a4.x, b4.y + a4.y, a4.w )
		check3( 43f, a4.x, a4.y, b4.y + a4.w )
		check3( 43f, a4.x, a4.y, a4.w + b4.y )

		check ( 44f, b4.y + a4.z + a4.w )
		check ( 44f, a4.z + b4.y + a4.w )
		check ( 44f, a4.z + a4.w + b4.y )

		check ( 44f, b4.y + a4.w + a4.z )
		check ( 44f, a4.w + b4.y + a4.z )
		check ( 44f, a4.w + a4.z + b4.y )

		check3( 45f, b4.y + a4.x, a4.z, a4.w )
		check3( 45f, a4.x, b4.y + a4.z, a4.w )
		check3( 45f, a4.x, a4.z, b4.y + a4.w )
		check3( 45f, a4.x, a4.z, a4.w + b4.y )

		check3( 46f, b4.y + a4.y, a4.z, a4.w )
		check3( 46f, a4.y, b4.y + a4.z, a4.w )
		check3( 46f, a4.y, a4.z, b4.y + a4.w )
		check3( 46f, a4.y, a4.z, a4.w + b4.y )

		check4( 47f, b4.y + a4.x, a4.y, a4.z, a4.w )
		check4( 47f, a4.x, b4.y + a4.y, a4.z, a4.w )
		check4( 47f, a4.x, a4.y, b4.y + a4.z, a4.w )
		check4( 47f, a4.x, a4.y, a4.z, b4.y + a4.w )
		check4( 47f, a4.x, a4.y, a4.z, a4.w + b4.y )

		check4( 47f, b4.y + a4.y, a4.x, a4.z, a4.w )
		check4( 47f, a4.y, b4.y + a4.x, a4.z, a4.w )
		check4( 47f, a4.y, a4.x, b4.y + a4.z, a4.w )
		check4( 47f, a4.y, a4.x, a4.z, b4.y + a4.w )
		check4( 47f, a4.y, a4.x, a4.z, a4.w + b4.y )

		check4( 47f, b4.y + a4.z, a4.x, a4.y, a4.w )
		check4( 47f, a4.z, b4.y + a4.x, a4.y, a4.w )
		check4( 47f, a4.z, a4.x, b4.y + a4.y, a4.w )
		check4( 47f, a4.z, a4.x, a4.y, b4.y + a4.w )
		check4( 47f, a4.z, a4.x, a4.y, a4.w + b4.y )

		check4( 47f, b4.y + a4.w, a4.x, a4.y, a4.z )
		check4( 47f, a4.w, b4.y + a4.x, a4.y, a4.z )
		check4( 47f, a4.w, a4.x, b4.y + a4.y, a4.z )
		check4( 47f, a4.w, a4.x, a4.y, b4.y + a4.z )
		check4( 47f, a4.w, a4.x, a4.y, a4.z + b4.y )

	END_TEST

	''
	'' simple arithmetic (double precision)
	''
	TEST( dvec2_simple )

		dim as DVec2 d, e, f

		d = type(1.5d,  0.75d)
		e = type(0.25d, 2.5d)

		f.x = (d.x + e.x) * (d.x - e.x)
		f.y = (d.y + e.y) * (d.y - e.y)

		CU_ASSERT_EQUAL( f.x,  2.1875d )
		CU_ASSERT_EQUAL( f.y, -5.6875d )

	END_TEST

	TEST( dvec2_swizzle )
		'' tests swizzle

		dim as DVec2 d, e, f

		d = type(0.5d, -2.0d)
		e = type(1.5d,  0.25d)

		f.x = (d.x + e.x) / (d.x * e.y)
		f.y = (d.y + e.y) / (d.y * e.y)

		CU_ASSERT_EQUAL( f.x, 16.0d )
		CU_ASSERT_EQUAL( f.y,  3.5d )

	END_TEST

	''
	'' intra-expression vectorization (double precision)
	''
	TEST( dvec2_intra )

		dim as DVec2 d, e, f

		d = type(1.5d, 0.25d)
		e = type(0.5d, 2.0d)
		f.x = (d.x * e.x) + (d.y * e.y)
		f.y = 0.0d

		CU_ASSERT_EQUAL( f.x, 1.25d )
		CU_ASSERT_EQUAL( f.y, 0.0d  )

	END_TEST


	''
	'' tests with a value returned on stack
	''
	function aux1f() as single option("fpu")
		return 1.0f
	end function

	function aux1d() as double option("fpu")
		return 1.0d
	end function

	TEST( negate )
		'' negate
		CU_ASSERT_EQUAL( -aux1f(), -1.0f )
	END_TEST

	TEST( sgn_ )
		'' sgn()
		CU_ASSERT_EQUAL( sgn(aux1f()), 1.0f )
	END_TEST

	TEST( sqr_ )
		'' sqr()
		CU_ASSERT_EQUAL( sqr(aux1d()), sqr(1.0d) )
	END_TEST

END_SUITE
