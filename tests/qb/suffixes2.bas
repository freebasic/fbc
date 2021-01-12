' TEST_MODE : COMPILE_AND_RUN_OK

#define ASSERT(e) if (e) = 0 then fb_Assert(__FILE__, __LINE__, __FUNCTION__, #e)

sub test1
	dim left as integer
	left = 5678
	assert( left = 5678 )
	assert( left% = 5678 )
	assert( left$( "abc", 1 ) = "a" )

	dim ltrim
	ltrim = -5678
	assert( ltrim = -5678 )
	assert( ltrim! = -5678 )
	assert( ltrim$( " b" ) = "b" )

	dim mod$
	mod$ = "1234"
	assert( mod$ = "1234" )
	assert( 3 mod 4 = 3 )

end sub	
	
defint a-z
sub test2
	left = 5678
	assert( left = 5678 )
	assert( left% = 5678 )
	assert( left$( "abc", 1 ) = "a" )

	ltrim! = -5678
	assert( ltrim! = -5678 )

	mod$ = "1234"
	assert( mod$ = "1234" )
	assert( 3 mod 4 = 3 )
	
end sub
defsng a-z

sub test3
	dim dim%
	dim% = 1234
	assert( dim% = 1234 )
	
	dim rem&
	rem& = 564356
	assert( rem& = 564356 )

	dim rem$
	rem$ = "qwerty"
	assert( rem$ = "qwerty" )	

end sub

sub test4
	dim% = 1234
	assert( dim% = 1234 )
	
	rem& = 564356
	assert( rem& = 564356 )

	rem$ = "qwerty"
	assert( rem$ = "qwerty" )	
	
end sub

const mid% = 1234
const sin$ = "5678"
const mod$ = "1234"
const const! = 1234.5

sub test5
	assert( mid = 1234 )
	assert( mid% = 1234 )
	assert( mid$( "abc", 1, 1 ) = "a" )

	assert( sin$ = "5678" )
	
	assert( mod$ = "1234" )
	assert( 3 mod 4 = 3 )
	
	assert( const! = 1234.5 )

	dim dim&
	assert( dim% = 0 )
	
	dim rem%
	assert( rem& = 0 )
	
end sub

	test1
	test2
	test3
	test4
	test5