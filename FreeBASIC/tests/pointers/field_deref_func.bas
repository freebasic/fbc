# include "fbcu.bi"

namespace fbc_tests.pointers.field_deref_func

type foo
   a as integer
   b as integer
   c as integer
end type
 
function docast(byval dataptr as any ptr) as foo ptr
	function = cast( foo ptr, dataptr )
end function 
  
sub test cdecl ()
	dim myvar as foo
	dim anyptr as any ptr
 
	anyptr = @myvar
 
	docast(anyptr)->a = 1234
	docast(anyptr)->b = 5678
  
	CU_ASSERT_EQUAL( docast(anyptr)->a, 1234 )
	CU_ASSERT_EQUAL( docast(anyptr)->b, 5678 )
 
end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.pointers.field_deref_func")
	fbcu.add_test("1", @test)

end sub

end namespace
	
	