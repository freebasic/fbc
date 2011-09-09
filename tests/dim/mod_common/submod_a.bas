' TEST_MODE : MULTI_MODULE_TEST


#include once "submod.bi"

declare sub test_extdyn( )

''
	init_b( )
	
	test_extdyn( )
	
  ASSERT( ext_nonshared_dynarray(1,1) = -1 )
  ASSERT( ext_nonshared_dynarray(1,2) = -2 )
	
  ASSERT( ext_nonshared_var = 1234 )
	

''
sub test_extdyn( )
	
	ASSERT( ext_dynarray(1,1) = 1 )
	ASSERT( ext_dynarray(1,2) = 2 )
	
end sub

