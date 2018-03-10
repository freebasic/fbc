# include "fbcu.bi"

# macro m1( foo, bar )
	foo + bar
# endmacro

namespace fbc_tests.macros.macro_no_parentheses

sub withArgTest cdecl ()

  var hello = m1 "hello", "!"
  var world = m1 "world", "!"
  
  CU_ASSERT_EQUAL( hello + world, "hello!world!" ) 

end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.pp.macro_no_parentheses")
	fbcu.add_test("withArgTest", @withArgTest)

end sub

end namespace
