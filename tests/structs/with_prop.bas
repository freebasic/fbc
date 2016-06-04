# include "fbcu.bi"

namespace fbc_tests.structs.with_prop

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
	
	sub test_stuff cdecl( )
		dim as foo bar
		bar.the_pointer = new foo
		with *( bar.the_pointer )
			.the_pointer = new foo
			delete .the_pointer
		end with
		delete bar.the_pointer
	end sub
	
	private sub ctor () constructor
	
		fbcu.add_suite("fbc_tests.structs.with_prop")
		fbcu.add_test("properties and with", @test_stuff)
	
	end sub

end namespace
