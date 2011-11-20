type TObject
 public:
	dim value as integer
end type

type TBase extends TObject
end type

type TDerived extends TBase
end type


sub test_byref( byref b as TBase )
	b.value = 1
end sub	

sub test_ptr( b as TBase ptr )
	b->value = 2
end sub	

function test_byval( byval b as TBase ) as integer
	return b.value + 1
end function

function test_derived( pb as TDerived ptr ) as integer
	return pb->value + 1
end function
	
sub main	
	dim d as TDerived
	
	test_byref d
	assert( d.value = 1 )
	
	test_ptr @d
	assert( d.value = 2 )
	
	test_ptr cast( TBase ptr, @d )
	assert( d.value = 2 )

	assert( test_byval(d) = 3 )
	
	dim pb as TBase ptr
	'test_derived pb  '' --- shouldn't be allowed, same as in C++
	
	print "all tests ok"
end sub

	main