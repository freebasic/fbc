type TObject
 public:
	dim value as integer
end type

type TBase extends TObject
 public:
	dim value2 as integer
end type

type TDerived extends TBase
public:
	dim value3 as integer
	declare constructor( value as integer )
end type

constructor TDerived( value as integer )
	base.value = value
end constructor

sub main	
	dim pb as TBase ptr
	dim pd as TDerived ptr = new TDerived( 1234 )
	
	pb = pd  '' ok
	assert( pb->value = 1234 )
	
	'pd = pb  '' --- not allowed, same as in C++
	
	dim b as TBase
	dim d as TDerived = ( 5678 )
	
	b = d	'' ok
	assert( b.value = 5678 )
	
	'd = b  	'' --- not allowed, same as in C++
	
	print "all tests ok"
end sub

	main