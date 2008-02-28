# include "fbcu.bi"

namespace fbc_tests.structs.bitfield_init
	
	type foo
		
		z:2 as integer
		a:4 as integer
		b:5 as integer
		c:6 as integer
		d:7 as integer
		e:8 as integer
		
	end type
	
	sub test cdecl ( )
		
		dim as foo bar = (1, 2, 3, 4)
		
		with bar
			cu_assert( .z = 1 )
			cu_assert( .a = 2 )
			cu_assert( .b = 3 )
			cu_assert( .c = 4 )
			cu_assert( .d = 0 )
			cu_assert( .e = 0 )
		end with
		
	end sub
	
	private sub ctor () constructor
	
		fbcu.add_suite("fbc_tests.structs.bitfield_init")
		fbcu.add_test( "test", @test)
	
	end sub
		
end namespace