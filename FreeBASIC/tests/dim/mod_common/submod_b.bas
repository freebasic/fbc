option explicit
option private

#include once "submod.bi"

	redim ext_dynarray(1 to 21, 1 to 2)

public sub init_b( )

	ext_dynarray(1,1) = 1
	ext_dynarray(1,2) = 2

end sub
