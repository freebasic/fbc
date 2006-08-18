

const strconst = "12345"

type foo
	zstrfield as zstring * len(strconst)+1
	fstrfield as string * len(strconst)
end type

	dim f as foo
	
	assert( sizeof( f.zstrfield ) = len(strconst)+1 )
	
	assert( len( f.fstrfield ) = len(strconst) )