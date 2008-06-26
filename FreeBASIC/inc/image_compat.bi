#pragma once

#include "fbgfx.bi"

# if __FB_LANG__ = "fb"
namespace FB
# endif
	
	function image_is_new( byval img as any ptr ) as integer
		function = (cast(IMAGE ptr, img)->type = PUT_HEADER_NEW)
	end function
	
	function image_width( byval img as any ptr ) as integer
		if( image_is_new( img ) ) then
			function = cast(IMAGE ptr, img)->width
		else
			function = cast(IMAGE ptr, img)->old.width
		end if
	end function
	
	function image_height( byval img as any ptr ) as integer
		if( image_is_new( img ) ) then
			function = cast(IMAGE ptr, img)->height
		else
			function = cast(IMAGE ptr, img)->old.height
		end if
	end function
	
	function image_bpp( byval img as any ptr ) as integer
		if( image_is_new( img ) ) then
			function = cast(IMAGE ptr, img)->bpp
		else
			function = cast(IMAGE ptr, img)->old.bpp
		end if
	end function
	
	function image_pitch( byval img as any ptr ) as integer
		if( image_is_new( img ) ) then
			function = cast(IMAGE ptr, img)->pitch
		else
			function = cast(IMAGE ptr, img)->old.width
		end if
	end function
	
	function image_data( byval img as any ptr ) as any ptr
		if( image_is_new( img ) ) then
			function = img + sizeof(IMAGE)
		else
			function = img + sizeof(_OLD_HEADER)
		end if
	end function
	
# if __FB_LANG__ = "fb"
end namespace
# endif


