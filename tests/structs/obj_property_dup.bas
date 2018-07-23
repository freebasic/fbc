#include "fbcunit.bi"

SUITE( fbc_tests.structs.obj_property_dup )

	type foo
		'' set
		declare property bar ( v as integer )
    
		'' get, indexed
		declare property bar ( index as integer ) as integer
    
	private:
		m_bar(0) as integer
	end type

	property foo.bar ( v as integer )
		m_bar(0) = v
	end property

	property foo.bar ( index as integer ) as integer
		property = m_bar(0)
	end property

	TEST( all )
		dim f as foo
		
		f.bar = 1234
		CU_ASSERT_EQUAL( f.bar(0), 1234 )

	END_TEST
	
END_SUITE
