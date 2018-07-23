#include "fbcunit.bi"

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

SUITE( fbc_tests.pp.macro_trim )

	TEST( noArgTest )

	  CU_ASSERT_EQUAL( hello1( ) + world1( ), "helloworld!" ) 

	END_TEST
  
	TEST( withArgTest )

	  CU_ASSERT_EQUAL( hello2( __ ) + world2( __ ), "helloworld!" ) 

	END_TEST

END_SUITE
