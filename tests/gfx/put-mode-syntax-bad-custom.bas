' TEST_MODE : COMPILE_ONLY_FAIL

dim image as any ptr

function customCallback _
	( _
		byval source_pixel as ulong, _
		byval destination_pixel as ulong, _
		byval parameter as any ptr _
	) as ulong
	function = 0
end function

put (0, 0), image, "custom", @customCallback, 0
