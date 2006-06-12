option explicit 

const TEST_W = 123
const TEST_H = 77
	
type foo_1 field=1 
	as short                 bpp :3
	as short                 w   :8 
	as short                 h   :8
end type 

type foo_2 field=1 
	as short                 bpp :3
	as short                 w   :8
	as short                 h
end type 

type foo_3 field=1 
	as short                 bpp :3
	as integer               w   :8 
	as integer               h
end type 

#define testw(_type)								_
	dim as _type w_##_type = f.w					:_
	assert( w_##_type = TEST_W )

#define testh(_type)								_
	dim as _type h_##_type = f.h					:_
	assert( h_##_type = TEST_H )

#define dotest_w()									_
	testw(byte)										:_
	testw(ubyte)									:_
	testw(short)									:_
	testw(ushort)									:_
	testw(integer)									:_
	testw(uinteger)									:_
	testw(longint)									:_
	testw(ulongint)									:_
	testw(single)									:_
	testw(double)

#define dotest_h()									_
	testh(byte)										:_
	testh(ubyte)									:_
	testh(short)									:_
	testh(ushort)									:_
	testh(integer)									:_
	testh(uinteger)									:_
	testh(longint)									:_
	testh(ulongint)									:_
	testh(single)									:_
	testh(double)

sub test_1

	dim as foo_1 f
	
	f.w = TEST_W
	f.h = TEST_H
	
	dotest_w()
	dotest_h()

end sub

sub test_2

	dim as foo_2 f
	
	f.w = TEST_W
	f.h = TEST_H
	
	dotest_w()
	dotest_h()

end sub

sub test_3

	dim as foo_3 f
	
	f.w = TEST_W
	f.h = TEST_H
	
	dotest_w()
	dotest_h()

end sub

	test_1
	test_2
	test_3