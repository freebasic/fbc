option explicit

type sub1_t as sub () 
type sub2_t as sub ( byval as integer ) 

const TEST_SUB1 = 1
const TEST_SUB2 = 2

function foobar overload (byval s as sub1_t ptr ) as integer
   function = TEST_SUB1 
end function 

function foobar overload (byval s as sub2_t ptr ) as integer
   function = TEST_SUB2
end function 

sub sub1 ( )
end sub 

sub sub2 ( byval i as integer )
end sub 

sub test_1
	dim fn as sub1_t
	dim pfn as sub1_t ptr

	fn = @sub1
	pfn = @fn

	assert( foobar( pfn ) = TEST_SUB1 )
end sub

sub test_2
	dim fn as sub2_t
	dim pfn as sub2_t ptr

	fn = @sub2
	pfn = @fn

	assert( foobar( pfn ) = TEST_SUB2 )
end sub

	test_1
	test_2