#include "fbcunit.bi"

SUITE( fbc_tests.pp.macro_nested2 )

	# macro create_macro( name_, params_, body_ )
		# undef name_
		# macro name_ params_
			body_
		# endmacro
	# endmacro

	  create_macro( join, (), 1234 )

	TEST( nestedTest )

		CU_ASSERT_EQUAL( join( ), 1234 )

	END_TEST
  
	# undef create_macro

	# macro create_macro /' define a new macro '/ _
		( _
			name_, _ ' name
			params_, _ ' params
			body_ _ ' body 
		) ' macro

		# undef name_
		# macro name_ params_ ' params_
			body_	' body_
		# endmacro 	' name_
	# endmacro ' create_macro

	  create_macro( join, (), -5678 ) ' white-space

	TEST( commentsInParamsTest )

		CU_ASSERT_EQUAL( join( ), -5678 )
  
	END_TEST

END_SUITE
