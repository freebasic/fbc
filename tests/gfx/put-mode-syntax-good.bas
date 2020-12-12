' TEST_MODE : COMPILE_ONLY_OK

dim image as any ptr

function customCallback _
	( _
		byval source_pixel as ulong, _
		byval destination_pixel as ulong, _
		byval parameter as any ptr _
	) as ulong
	function = 0
end function

put (0, 0), image, add
put (0, 0), image, alpha
put (0, 0), image, and
put (0, 0), image, custom, @customCallback, 0
put (0, 0), image, or
put (0, 0), image, preset
put (0, 0), image, pset
put (0, 0), image, trans
put (0, 0), image, xor

dim as integer add, alpha, custom, trans

put (0, 0), image, add
put (0, 0), image, alpha
put (0, 0), image, custom, @customCallback, 0
put (0, 0), image, trans
