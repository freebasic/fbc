#include "fbcunit.bi"

SUITE( fbc_tests.overload_.access_mode )

	type foo
		as byte pad
		
		private:
		declare function bar() as integer
		declare constructor ()
		
		public:
		declare function bar(i as integer) as integer
		declare constructor (i as integer)
	end type

	function foo.bar(i as integer) as integer
		function = 0
	end function

	constructor foo(i as integer)
	end constructor

	TEST( all )
		dim f as foo = foo(1)
		
		f.bar(1)
		
	END_TEST

END_SUITE
