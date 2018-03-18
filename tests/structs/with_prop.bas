#include "fbcunit.bi"

SUITE( fbc_tests.structs.with_prop )

	type foo
	
		declare property the_pointer() as foo ptr
		declare property the_pointer(byval i as foo ptr) 
		
		private:
			core as foo ptr
		
	end type
	
	property foo.the_pointer() as foo ptr
		return this.core
	end property
	property foo.the_pointer(byval i as foo ptr) 
		this.core = i
	end property
	
	'' properties and with
	TEST( properties )
		dim as foo bar
		bar.the_pointer = new foo
		with *( bar.the_pointer )
			.the_pointer = new foo
			delete .the_pointer
		end with
		delete bar.the_pointer
	END_TEST
	
END_SUITE
