# include "fbcunit.bi"

SUITE( fbc_tests.dim_.array_static_init )

	type foo
		bar(0 to 3) as integer
	end type

	TEST( pointer_to_arrray )
		static arr(0 to 10) as foo
		static pf as foo ptr = @arr(10)

		arr(10).bar(3) = -1234

		CU_ASSERT_EQUAL( pf->bar(3), -1234 )
	END_TEST

	TEST_GROUP( regression3544952 )
		'' Regression test for #3544952; this should compile fine
		type Parent
			a as integer
		end type

		type Child as FwdrefChild

		dim shared array() as Child ptr

		type FwdrefChild extends Parent
		end type

		TEST( default )
			'' This REDIM ensures the array is used/referenced,
			'' forcing the static array desciptor to be emitted,
			'' which caused the problem.
			redim array(0 to 0)
		END_TEST
	END_TEST_GROUP

END_SUITE
