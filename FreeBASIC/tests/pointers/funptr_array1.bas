

enum TEST_RES
	TEST_1	= 1
end enum

type foo 
    bar(0 to 1) as function () as TEST_RES
end type 

function bar() as TEST_RES
    function = TEST_1
end function


sub test1
	dim fp as foo ptr = callocate( len(foo) ) 

	fp->bar(1) = @bar

	assert( fp->bar(1)() = TEST_1 )
end sub

	test1