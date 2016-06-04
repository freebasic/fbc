# include "fbcu.bi"

namespace fbc_tests.structs.obj_vis_static

type foo
	pad as integer
	
	declare static function bar(i as integer) as integer
private:
	declare static function bar as integer
end type

function foo.bar as integer 
	return 1234 
end function

function foo.bar(i as integer) as integer 
	return -1234 
end function

sub test_1 cdecl	
	CU_ASSERT_EQUAL( foo.bar(1), -1234 )
end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.structs.obj_vis_static")
	fbcu.add_test( "#1", @test_1)

end sub
	
end namespace	