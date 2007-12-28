# include "fbcu.bi"




namespace fbc_tests.pointers.funcptr_array1

enum TEST_RES
	TEST_1	= 1
end enum

type foo 
    bar(0 to 1) as function () as TEST_RES
end type 

function bar() as TEST_RES
    function = TEST_1
end function

	dim shared fp as foo ptr

sub test1 cdecl ()
	CU_ASSERT_EQUAL( fp->bar(1)(), TEST_1 )
end sub

function init cdecl () as integer

	fp = callocate(sizeof(foo))
	if (0 = fp) then
		return -1
	end if
	
	fp->bar(1) = @bar
	return 0

end function

function cleanup cdecl () as integer

	deallocate(fp)

	return 0

end function

sub ctor () constructor

	fbcu.add_suite("fbc_tests.pointers.funcptr_array1", @init, @cleanup)
	fbcu.add_test("test1", @test1)

end sub

end namespace
