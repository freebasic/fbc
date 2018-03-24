#include "fbcunit.bi"

SUITE( fbc_tests.pointers.prop_new_del )

	type foo
	
		declare property the_pointer() as integer ptr
		declare property the_pointer(byval i as integer ptr) 
		
		private:
			core as integer ptr
		
	end type
	
	property foo.the_pointer() as integer ptr
		return core
	end property
	property foo.the_pointer(byval i as integer ptr) 
		core = i
	end property
	
	TEST( all )
		
		dim as foo bar
		
		for i as integer = 0 to 9999
			bar.the_pointer = new integer
			delete bar.the_pointer
		next
	
	END_TEST

END_SUITE
