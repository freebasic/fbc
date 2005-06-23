option explicit
option private

'$include once: "submod_c.bi"

defint a-z

	dim shared ext_statarray(1 to 21, 1 to 2)

public sub init_b( )

	redim ext_dynarray(1 to 21, 1 to 2)

	ext_dynarray(1,1) = 1
	ext_dynarray(1,2) = 2
	
	ext_statarray(1,1) = 3
	ext_statarray(1,2) = 4

end sub
