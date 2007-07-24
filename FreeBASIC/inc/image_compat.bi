#pragma once

#include "fbgfx.bi"

namespace FB
	
	function image_is_new( byval img as any ptr ) as integer
		function = (cast(IMAGE ptr, img)->type = PUT_HEADER_NEW)
	end function
	
	function image_width( byval img as any ptr ) as integer
		if( image_is_new( img ) ) then
			function = img->width
		else
			function = img->old.width
		end if
	end function
	
	function image_height( byval img as any ptr ) as integer
		if( image_is_new( img ) ) then
			function = img->height
		else
			function = img->old.height
		end if
	end function
	
	function image_bpp( byval img as any ptr ) as integer
		if( image_is_new( img ) ) then
			function = img->bpp
		else
			function = img->old.bpp
		end if
	end function
	
	function image_pitch( byval img as any ptr ) as integer
		if( image_is_new( img ) ) then
			function = img->pitch
		else
			function = img->old.width
		end if
	end function
	
	function image_data( byval img as any ptr ) as any ptr
		if( image_is_new( img ) ) then
			function = img + len(IMAGE)
		else
			function = img + len(_OLD_HEADER)
		end if
	end function
	
end namespace


