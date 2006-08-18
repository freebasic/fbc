

const TEST_LC = "hello!"
const TEST_UC = "HELLO!"

sub ucaseme(s as string)
	s = ucase( s )
end sub


sub test_1
	dim as string * 20 s
	
	s = TEST_LC
	ucaseme( s )
	assert( s = TEST_UC )
	
end sub	

type foo
	f1 as integer
 	s as string * 20
end type

sub test_2
	dim as foo f(0)
	
	f(0).s = TEST_LC
	ucaseme( f(0).s )
	assert( f(0).s = TEST_UC )
	
end sub	



	test_1
	test_2