# include "fbcu.bi"

namespace fbc_tests.pointers.prop_new_del

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
	
	sub test_stuff cdecl( )
		
		dim as foo bar
		
		for i as integer = 0 to 9999
			bar.the_pointer = new integer
			delete bar.the_pointer
		next
	
	end sub

	
	private sub ctor () constructor
	
		fbcu.add_suite("fbc_tests.pointers.prop_new_del")
		fbcu.add_test("Properties with new/delete", @test_stuff)
	
	end sub

end namespace