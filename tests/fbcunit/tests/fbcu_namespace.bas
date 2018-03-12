#include once "fbcunit.bi"

SUITE( fbcunit.nested.namespaces )

	TEST( do_test )
		CU_ASSERT( true )
	END_TEST

END_SUITE

namespace scoped
	SUITE( scoped_namespace )
		TEST( proc )
			CU_ASSERT( true )
		END_TEST
	END_SUITE
end namespace

SUITE( fbcunit.parent )

	dim called as integer = 0
	dim flag as boolean = false
	dim flag_a as boolean = false
	dim flag_b as boolean = false

	sub do_check()
		if( called = 3 ) then
			if( flag and flag_a and flag_b ) then
				CU_PASS()
			else
				CU_FAIL()
			end if
		end if
	end sub

	TEST( proc )
		called += 1
		flag = true
		CU_ASSERT( true )
		do_check()
	END_TEST

	namespace child_a	
		TEST( proc )
			called += 1
			flag_a = true
			CU_ASSERT( true )
			do_check()
		END_TEST
	end namespace

	namespace child_b
		TEST( proc )
			called += 1
			flag_b = true
			CU_ASSERT( true )
			do_check()
		END_TEST
	end namespace

END_SUITE
