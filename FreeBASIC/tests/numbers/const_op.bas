# include "fbcu.bi"

'' checks 8/16-bit ops to make sure constant values are truncated/folded correctly

namespace fbc_tests.numbers.const_op

sub test_1 cdecl ()

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

end sub

sub test_2 cdecl ()

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

end sub

sub ctor () constructor

	fbcu.add_suite("fb-tests-numbers:const_op")
	fbcu.add_test("test_1", @test_1)
	fbcu.add_test("test_2", @test_2)

end sub

end namespace
