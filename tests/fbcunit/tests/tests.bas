/'
	tests -- run the unit tests for libfbcunit.a

	compile all test modules with:
		$ fbc tests.bas fbcu_sanity.bas fbcu_multiple.bas fbcu_global.bas fbcu_many_tests.bas \
			fbcu_append.bas fbcu_append2.bas fbcu_float.bas fbcu_namespace.bas fbcu_default.bas \
			-i ../inc -p ../lib

	or compile just a single test module with:
		$ fbc tests.bas fbcu_sanity.bas -i ../inc -p ../lib

	and run with
		$ tests
'/

#include once "fbcunit.bi"

fbcu.run_tests
