option explicit
	
function str1 as any ptr
	function = @"common lit string"
end function

function str2 as any ptr
	function = @"common lit string"
end function

	assert( str1 = str2 )
	