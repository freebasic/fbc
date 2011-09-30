	dim shared ctor_cnt as integer, dtor_cnt as integer 

type TObject
	declare constructor
	declare destructor
 
 public:
	dim value as integer = 1234
end type

constructor TObject
	ctor_cnt += 1
end constructor

destructor TObject
	dtor_cnt += 1
end destructor

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
	
sub main	
	
	scope
		dim d as TDerived
		
		test_byref d
		assert( d.value = 1 )
		
		test_ptr cast( TBase ptr, @d )
		assert( d.value = 2 )
		
		'' this will cause the dtor to be called
		assert( test_byval(d) = 3 )
	end scope
	
	'' one for "d", other for test_byval
	assert( ctor_cnt = 2 )
	assert( dtor_cnt = 2 )
	
	print "all tests ok"
end sub

	main