

const TEST_1 = 3
const TEST_2 = -3

	dim shared as byte _sbyte
	dim shared as ubyte _ubyte
	dim shared as short _sshort
	dim shared as ushort _ushort
	dim shared as integer _sint
	dim shared as uinteger _uint
	dim shared as integer div = 2
	
sub test1
	_sbyte = TEST_1
	_ubyte = TEST_1
	_sshort = TEST_1
	_ushort = TEST_1
	_sint = TEST_1
	_uint = TEST_1
	
	assert( _sbyte \ 2 = 1 )
	assert( _ubyte \ 2 = 1 )
	assert( _sshort \ 2 = 1 )
	assert( _ushort \ 2 = 1 )
	assert( _sint \ 2 = 1 )
	assert( _uint \ 2 = 1 )
	
	assert( _sbyte \ div = 1 )
	assert( _ubyte \ div = 1 )
	assert( _sshort \ div = 1 )
	assert( _ushort \ div = 1 )
	assert( _sint \ div = 1 )
	assert( _uint \ div = 1 )
end sub

sub test2
	_sbyte = TEST_2
	_ubyte = TEST_2
	_sshort = TEST_2
	_ushort = TEST_2
	_sint = TEST_2
	_uint = TEST_2
	
	assert( _sbyte \ 2 = -1 )
	assert( _ubyte \ 2 = &h7E )
	assert( _sshort \ 2 = -1 )
	assert( _ushort \ 2 = &h7FFE )
	assert( _sint \ 2 = -1 )
	assert( _uint \ 2 = &h7FFFFFFE )
	
	assert( _sbyte \ div = -1 )
	assert( _ubyte \ div = &h7E )
	assert( _sshort \ div = -1 )
	assert( _ushort \ div = &h7FFE )
	assert( _sint \ div = -1 )
	assert( _uint \ div = &h7FFFFFFE )
end sub

	test1
	test2