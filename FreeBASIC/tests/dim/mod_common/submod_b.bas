' TEST_MODE : MULTI_MODULE_TEST


#include once "submod.bi"

	redim ext_dynarray(1 to 2, 1 to 2)
	
	redim ext_nonshared_dynarray(1 to 2, 1 to 2)
	
	ext_nonshared_dynarray(1,1) = -1
	ext_nonshared_dynarray(1,2) = -2

	ext_nonshared_var = 1234

public sub init_b( )

	ext_dynarray(1,1) = 1
	ext_dynarray(1,2) = 2

end sub
