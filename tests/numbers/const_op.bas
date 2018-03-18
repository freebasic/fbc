#include "fbcunit.bi"

'' checks 8/16-bit ops to make sure constant values are truncated/folded correctly

SUITE( fbc_tests.numbers.const_op )

	TEST( uop )

		#macro test_const_uop( dtype, val )
		scope

			const a as dtype = val
			const b as dtype = not a
			const ci as integer = b
			const cs as string = str(b)

			dim as dtype va = val
			dim as dtype vb = not va
			dim as integer vci = vb
			dim as string vcs = str(vb)

			CU_ASSERT_EQUAL( ci, vci )

			CU_ASSERT_EQUAL( cs, vcs )

		end scope
		#endmacro

		test_const_uop(byte, 0)
		test_const_uop(ubyte, 0)
		test_const_uop(short, 0)
		test_const_uop(ushort, 0)

	END_TEST

	TEST( bop )

		#macro test_const_bop( dtype, val )
		scope

			const a as dtype = val
			const b as dtype = a*a
			const ci as integer = b
			const cs as string = str(b)

			dim as dtype va = val
			dim as dtype vb = va*va
			dim as integer vci = vb
			dim as string vcs = str(vb)

			CU_ASSERT_EQUAL( ci, vci )

			CU_ASSERT_EQUAL( cs, vcs )

		end scope
		#endmacro

		test_const_bop(byte, 16)
		test_const_bop(ubyte, 16)
		test_const_bop(short, 256)
		test_const_bop(ushort, 256)

	END_TEST

END_SUITE
