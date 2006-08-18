 

const TEST_W = 200
const TEST_H = 100
	
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


sub test_1

	dim as foo_1 f
	
	f.w = TEST_W
	f.h = TEST_H
	
	dim as integer res = f.w * f.h
	
	assert( res = (TEST_W * TEST_H) )

end sub

sub test_2

	dim as foo_2 f
	
	f.w = TEST_W
	f.h = TEST_H
	
	dim as integer res = f.w * f.h
	
	assert( res = (TEST_W * TEST_H) )

end sub

sub test_3

	dim as foo_3 f
	
	f.w = TEST_W
	f.h = TEST_H
	
	dim as integer res = f.w * f.h
	
	assert( res = (TEST_W * TEST_H) )

end sub

	test_1
	test_2
	test_3