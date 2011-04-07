# include "fbcu.bi"

namespace fbc_tests.structs.obj_ptrto_static

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
	dim as function(as integer) as integer fn = @foo.bar
	CU_ASSERT_EQUAL( fn(1), -1234 )
end sub

private sub ctor () constructor

	fbcu.add_suite("fb-tests-structs:obj-ptrto-static")
	fbcu.add_test( "#1", @test_1)

end sub
	
end namespace	