const TEST_VAL = 1234

type udt : __ as byte : end type 

function foo overload (byval udt as udt) as udt 
	assert( 2 + 2 = 5 )
end function 

sub foo overload (byval i as integer) 
	assert( i = TEST_VAL )
end sub 

	foo( TEST_VAL )
