#include "fbcunit.bi"

SUITE( fbc_tests.structs.op_access_mode )

	type foo
		as byte pad
		
	private:
		declare operator cast ( ) as integer
		declare operator += ( i as integer )
		
	public:
		declare operator += ( i as double )
		declare operator cast ( ) as double
		
	end type

	operator foo.+= ( i as double )
	end operator

	operator foo.cast ( ) as double
		return 0
	end operator

	TEST( all )
		dim f as foo
		
		dim as double d = cdbl(f)
		
		f += 1.0
	END_TEST

END_SUITE
