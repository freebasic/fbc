#include "fbcunit.bi"

SUITE( fbc_tests.scopes.shadow_inherit )

	'' SCOPE...END SCOPE creates a new local scope
	'' implicit variable scope is inherited
	TEST( opt_imp_scope_imp_inherit )
		dim as integer x = 1
		CU_ASSERT( x = 1 )
		scope
			x += 3
			CU_ASSERT( x = 4 )
			scope
				x += 5
				CU_ASSERT( x = 9 )
			end scope
			x += 3
			CU_ASSERT( x = 12 )
		end scope
		x += 1
		CU_ASSERT( x = 13 )
	END_TEST

	'' SCOPE...END SCOPE creates a new local scope
	'' DIM inside SCOPE shadows parent scope variable
	TEST( opt_imp_scope_exp_shadow )
		dim as integer x = 1
		CU_ASSERT( x = 1 )
		scope
			dim as integer x
			x += 3
			CU_ASSERT( x = 3 )
			scope
				dim as integer x
				x += 5
				CU_ASSERT( x = 5 )
			end scope
			x += 3
			CU_ASSERT( x = 6 )
		end scope
		x += 1
		CU_ASSERT( x = 2 )
	END_TEST

	'' IF...THEN creates a new local scope
	'' implicit variable scope is inherited
	TEST( opt_imp_if_imp_inherit )
		dim as integer x = 1
		CU_ASSERT( x = 1 )

		if 1 then
			x += 1
			CU_ASSERT( x = 2 )
		else
			CU_ASSERT( 0 )
		end if

		CU_ASSERT( x = 2 )

		if 0 then
			CU_ASSERT( 0 )
		else
			x += 1
			CU_ASSERT( x = 3 )
		end if

		CU_ASSERT( x = 3 )
	END_TEST

	'' IF...THEN creates a new local scope
	'' DIM inside SCOPE shadows parent scope variable
	TEST( opt_imp_if_exp_shadow )
		dim as integer x = 1
		CU_ASSERT( x = 1 )

		if 1 then
			dim as integer x
			x += 2
			CU_ASSERT( x = 2 )
		else
			CU_ASSERT( 0 )
		end if

		CU_ASSERT( x = 1 )

		if 0 then
			CU_ASSERT( 0 )
		else
			dim as integer x
			x += 2
			CU_ASSERT( x = 2 )
		end if

		CU_ASSERT( x = 1 )
	END_TEST

	'' DO...WHILE creates a new local scope
	'' implicit variable scope is inherited
	'' DIM inside SCOPE shadows parent scope variable
	TEST( opt_imp_do )
		dim as integer x = 1
		CU_ASSERT( x = 1 )

		do
			x += 1
			CU_ASSERT( x = 2 )
			exit do
		loop

		CU_ASSERT( x = 2 )

		x = 1
		CU_ASSERT( x = 1 )

		do
			dim as integer x
			x += 1
			CU_ASSERT( x = 1 )
			exit do
		loop

		dim as integer i = 0
		CU_ASSERT( i = 0 )

		x = 0
		CU_ASSERT( x = 0 )

		do
			dim as integer x
			x += 1
			i += 1

			CU_ASSERT( x = 1 )

			if( i > 10 ) then
				exit do
			end if
		loop

		CU_ASSERT( i = 11 )
		CU_ASSERT( x = 0 )

		i = 0
		x = 0

		do
			x += 1
			i += 1
			CU_ASSERT( x = i )
			if( i > 10 ) then
				exit do
			end if
		loop

		CU_ASSERT( i = 11 )
		CU_ASSERT( x = 11 )
	END_TEST

	'' WHILE...WEND creates a new local scope
	'' implicit variable scope is inherited
	'' DIM inside SCOPE shadows parent scope variable
	TEST( opt_imp_while )
		dim as integer x = 1
		CU_ASSERT( x = 1 )

		while 1
			x += 1
			CU_ASSERT( x = 2 )
			exit while
		wend

		CU_ASSERT( x = 2 )

		x = 1
		CU_ASSERT( x = 1 )

		while 1
			dim as integer x
			x += 1
			CU_ASSERT( x = 1 )
			exit while
		wend

		dim as integer i = 0
		CU_ASSERT( i = 0 )

		x = 0
		CU_ASSERT( x = 0 )

		while 1
			dim as integer x
			x += 1
			i += 1
  
			CU_ASSERT( x = 1 )

			if( i > 10 ) then
				exit while
			end if
		wend

		CU_ASSERT( i = 11 )
		CU_ASSERT( x = 0 )

		i = 0
		x = 0

		while 1
			x += 1
			i += 1
			CU_ASSERT( x = i )
			if( i > 10 ) then
				exit while
			end if
		wend

		CU_ASSERT( i = 11 )
		CU_ASSERT( x = 11 )
	END_TEST

	'' FOR...NEXT creates a new local scope
	'' implicit variable scope is inherited
	'' DIM inside SCOPE shadows parent scope variable
	TEST( opt_imp_for )
		dim as integer x = 1
		CU_ASSERT( x = 1 )

		dim as integer i
		for i = 1 to 10
			x += 1
			CU_ASSERT( x = 2 )
			exit for
		next i

		CU_ASSERT( x = 2 )

		x = 1
		CU_ASSERT( x = 1 )

		for i = 1 to 10
			dim as integer x
			x += 1
			CU_ASSERT( x = 1 )
			exit for
		next i

		i = 0
		CU_ASSERT( i = 0 )

		x = 0
		CU_ASSERT( x = 0 )

		for i = 1 to 10
			dim as integer x
			x += 1
			CU_ASSERT( x = 1 )
		next i

		CU_ASSERT( i = 11 )
		CU_ASSERT( x = 0 )

		for i = 1 to 10
			x += 1
			CU_ASSERT( x = i )
		next i

		CU_ASSERT( i = 11 )
		CU_ASSERT( x = 10 )
	END_TEST

	'' --------------------------------------

	'' Explicit Variable Scope Tests
	'' With/without inner explicit dim's
	'' and variable name shadowing.

	'' SCOPE...END SCOPE creates a new local scope
	'' implicit variable scope is inherited
	TEST( opt_exp_scope_imp_inherit )
		dim as integer x

		x = 1
		CU_ASSERT( x = 1 )

		scope
			x += 3
			CU_ASSERT( x = 4 )

			scope
				x += 5
				CU_ASSERT( x = 9 )
			end scope

			x += 3
			CU_ASSERT( x = 12 )
		end scope

		x += 1
		CU_ASSERT( x = 13 )
	END_TEST

	'' SCOPE...END SCOPE creates a new local scope
	'' DIM inside SCOPE shadows parent scope variable
	TEST( opt_exp_scope_exp_shadow )
		dim as integer x

		x = 1
		CU_ASSERT( x = 1 )

		scope
			dim as integer x
			x += 3
			CU_ASSERT( x = 3 )

			scope
				dim as integer x
				x += 5
				CU_ASSERT( x = 5 )
			end scope

			x += 3
			CU_ASSERT( x = 6 )
		end scope

		x += 1
		CU_ASSERT( x = 2 )
	END_TEST

	'' IF...THEN creates a new local scope
	'' implicit variable scope is inherited
	TEST( opt_exp_if_imp_inherit )
		dim as integer x

		x = 1
		CU_ASSERT( x = 1 )

		if 1 then
			x += 1
			CU_ASSERT( x = 2 )
		else
			CU_ASSERT( 0 )
		end if

		CU_ASSERT( x = 2 )

		if 0 then
			CU_ASSERT( 0 )
		else
			x += 1
			CU_ASSERT( x = 3 )
		end if

		CU_ASSERT( x = 3 )
	END_TEST

	'' IF...THEN creates a new local scope
	'' DIM inside SCOPE shadows parent scope variable
	TEST( opt_exp_if_exp_shadow )
		dim as integer x

		x = 1
		CU_ASSERT( x = 1 )

		if 1 then
			dim as integer x
			x += 2
			CU_ASSERT( x = 2 )
		else
			CU_ASSERT( 0 )
		end if

		CU_ASSERT( x = 1 )

		if 0 then
			CU_ASSERT( 0 )
		else
			dim as integer x
			x += 2
			CU_ASSERT( x = 2 )
		end if

		CU_ASSERT( x = 1 )
	END_TEST

	'' DO...WHILE creates a new local scope
	'' implicit variable scope is inherited
	'' DIM inside SCOPE shadows parent scope variable
	TEST( opt_exp_do )
		dim as integer x, i

		x = 1
		CU_ASSERT( x = 1 )

		do
			x += 1
			CU_ASSERT( x = 2 )
			exit do
		loop

		CU_ASSERT( x = 2 )

		x = 1
		CU_ASSERT( x = 1 )

		do
			dim as integer x
			x += 1
			CU_ASSERT( x = 1 )
			exit do
		loop

		i = 0
		CU_ASSERT( i = 0 )

		x = 0
		CU_ASSERT( x = 0 )

		do
			dim as integer x
			x += 1
			i += 1
			CU_ASSERT( x = 1 )
			if( i > 10 ) then
				exit do
			end if
		loop

		CU_ASSERT( i = 11 )
		CU_ASSERT( x = 0 )

		i = 0
		x = 0

		do
			x += 1
			i += 1
			CU_ASSERT( x = i )
			if( i > 10 ) then
				exit do
			end if
		loop

		CU_ASSERT( i = 11 )
		CU_ASSERT( x = 11 )
	END_TEST

	'' WHILE...WEND creates a new local scope
	'' implicit variable scope is inherited
	'' DIM inside SCOPE shadows parent scope variable
	TEST( opt_exp_while )
		dim as integer x, i

		x = 1
		CU_ASSERT( x = 1 )

		while 1
			x += 1
			CU_ASSERT( x = 2 )
			exit while
		wend

		CU_ASSERT( x = 2 )

		x = 1
		CU_ASSERT( x = 1 )

		while 1
			dim as integer x
			x += 1
			CU_ASSERT( x = 1 )
			exit while
		wend

		i = 0
		CU_ASSERT( i = 0 )
  
		x = 0
		CU_ASSERT( x = 0 )

		while 1
			dim as integer x
			x += 1
			i += 1
			CU_ASSERT( x = 1 )
			if( i > 10 ) then
				exit while
			end if
		wend

		CU_ASSERT( i = 11 )
		CU_ASSERT( x = 0 )

		i = 0
		x = 0

		while 1
			x += 1
			i += 1
			CU_ASSERT( x = i )
			if( i > 10 ) then
				exit while
			end if
		wend

		CU_ASSERT( i = 11 )
		CU_ASSERT( x = 11 )
	END_TEST

	'' FOR...NEXT creates a new local scope
	'' implicit variable scope is inherited
	'' DIM inside SCOPE shadows parent scope variable
	TEST( opt_exp_for )
		dim as integer x, i

		x = 1
		CU_ASSERT( x = 1 )

		for i = 1 to 10
			x += 1
			CU_ASSERT( x = 2 )
			exit for
		next i

		CU_ASSERT( x = 2 )

		x = 1
		CU_ASSERT( x = 1 )

		for i = 1 to 10
			dim as integer x
			x += 1
			CU_ASSERT( x = 1 )
			exit for
		next i

		i = 0
		CU_ASSERT( i = 0 )

		x = 0
		CU_ASSERT( x = 0 )

		for i = 1 to 10
			dim as integer x
			x += 1
			CU_ASSERT( x = 1 )
		next i

		CU_ASSERT( i = 11 )
		CU_ASSERT( x = 0 )

		for i = 1 to 10
			x += 1
			CU_ASSERT( x = i )
		next i

		CU_ASSERT( i = 11 )
		CU_ASSERT( x = 10 )
	END_TEST

	'' -gen gcc regression test
	TEST_GROUP( varShadowing )
		TEST( test1 )
			dim as integer i = 0
			CU_ASSERT( i = 0 )
			scope
				CU_ASSERT( i = 0 )
				dim as integer i = 1
				CU_ASSERT( i = 1 )
				scope
					CU_ASSERT( i = 1 )
					dim as integer i = 2
					CU_ASSERT( i = 2 )
					scope
						CU_ASSERT( i = 2 )
						static as integer i
						CU_ASSERT( i = 0 )
						i = 3
						CU_ASSERT( i = 3 )
					end scope
					CU_ASSERT( i = 2 )
				end scope
				CU_ASSERT( i = 1 )
			end scope
			CU_ASSERT( i = 0 )
		END_TEST

		dim shared as integer global = 1

		TEST( test2 )
			CU_ASSERT( global = 1 )
			dim as integer global = 2
			CU_ASSERT( global = 2 )
		END_TEST
	END_TEST_GROUP

END_SUITE
