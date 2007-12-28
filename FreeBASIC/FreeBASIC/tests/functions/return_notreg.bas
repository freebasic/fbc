# include "fbcu.bi"

namespace fbc_tests.dim_.return_notreg
	
	type foo
		x(63) as integer
		declare constructor( )
	end type
	
	function heh( ) as foo
		if( 0 = 1 ) then
			function = type()
		end if
	end function
	
	constructor foo( )
		for i as integer = 0 to 63
			x(i) = i
		next
	end constructor
	
	sub test1 cdecl ( )
		dim as foo thing
		thing = heh( )
		for i as integer = 0 to 63
			CU_ASSERT( thing.x(i) = i )
		next
	end sub
	
	private sub ctor () constructor
	
		fbcu.add_suite("fbc_tests.dim.array_init")
		fbcu.add_test("test 1", @test1)
	
	end sub
	
end namespace
			