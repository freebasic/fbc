# include "fbcu.bi"

# macro hello1( )
	 	
	"hello"
	 
	 	
# endmacro

# macro world1( )

	 	
	"world!"
	 
# endmacro

'' with args

# macro hello2( foo )
	 	
	"hello"
	 
	 	
# endmacro

# macro world2( foo )

	 	
	"world!"
	 
# endmacro

namespace fbc_tests.macros.macro_trim

sub noArgTest cdecl ()

  CU_ASSERT_EQUAL( hello1( ) + world1( ), "helloworld!" ) 

end sub
  
sub withArgTest cdecl ()

  CU_ASSERT_EQUAL( hello2( __ ) + world2( __ ), "helloworld!" ) 

end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.pp.macro_trim")
	fbcu.add_test("noArgTest", @noArgTest)
	fbcu.add_test("withArgTest", @withArgTest)

end sub

end namespace
