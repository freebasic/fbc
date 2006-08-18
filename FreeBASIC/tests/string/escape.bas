
sub test_esc
#define d !"\64abc\65"
	const c = d
	dim v as string = d
	static s as zstring * 32 => d
	
	assert( d = !"\64abc\65" )
	assert( c = d )
	assert( v = d )	
	assert( s = d )	
	
end sub

sub test_noesc
#define d "\64abc\65"
	const c = d
	dim v as string = d
	static s as zstring * 32 => d

	assert( d = "\64abc\65" )
	assert( c = d )
	assert( v = d )
	assert( s = d )	
	
end sub

sub test_num	
	assert( !"\65\66\67" = "ABC" )
	assert( !"\&h41\&h42\&h43" = "ABC" )
	assert( !"\&o101\&o102\&o103" = "ABC" )
	assert( !"\&b1000001\&b1000010\&b1000011" = "ABC" )
end sub

	test_esc
	test_noesc
	test_num