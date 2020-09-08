# include "fbcunit.bi"

SUITE( fbc_tests.pp.macro_no_parentheses )

	# macro m1 ? ( foo, bar )
		foo + bar
	# endmacro

	TEST( initializer )

		var hello = m1 "hello", "!"
		var world = m1 "world", "!"
  
  	END_TEST

END_SUITE
