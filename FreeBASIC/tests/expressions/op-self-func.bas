
function foo as integer
    static as integer cnt
    function = cnt
    cnt += 1
end function

	dim as integer bar(0 To 1) = { 1, 1234 }
	
	assert( bar(0) = 1 )
	
	bar(foo()) += 1
	
	assert( bar(0) = 2 )

