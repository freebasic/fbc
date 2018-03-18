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
