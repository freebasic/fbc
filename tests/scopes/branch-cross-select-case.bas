#include "fbcunit.bi"

SUITE( fbc_tests.scopes.branch_cross_select_case )

	'' GOTO over SELECT CASE integer 1
	TEST( branchCrossingSelectInteger1 )
		dim as integer i

		'' Jumping over SELECT's integer temp var, should be allowed,
		'' without warning, because it's safe (the integer var doesn't have
		'' any clean up code at scope end, so it won't be used anymore once
		'' a CASE block has been reached)
		goto label1

		select case( i + 1 )  '' an expression that requires the use of a temp var
		case 1
			label1:
		end select
	END_TEST

	'' GOTO over SELECT CASE integer 2
	TEST( branchCrossingSelectInteger2 )
		dim as integer i

		goto label1

		'' Same but with an extra scope around SELECT CASE
		'' (this would trigger the branch crossing warning in previous versions
		'' of FB where SELECT CASE didn't have the implicit outer scope)
		scope
			select case( i + 1 )
			case 1
				label1:
			end select
		end scope
	END_TEST
	
END_SUITE
