# include "fbcu.bi"

namespace fbc_tests.structs.obj_redim

dim shared as integer bar_cnt = 0

type bar
	value as integer
	declare constructor()
	declare destructor()
end type

constructor bar()
	value = bar_cnt
	bar_cnt += 1
end constructor

destructor bar( )
	bar_cnt -= 1
end destructor

#macro test_chk()
	scope
		dim as integer i
		for i = lbound( array ) to ubound( array )
			CU_ASSERT_EQUAL( array(i).value, i )
		next
	end scope
#endmacro

sub test cdecl	
	
	redim as bar array(0 to 1)
	test_chk()
	
	redim array(0 to 2)
	test_chk()

	redim array(0 to 1)
	test_chk()

	redim array(0 to 3)
	test_chk()

end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.structs.obj_redim")
	fbcu.add_test( "test", @test)

end sub
	
end namespace