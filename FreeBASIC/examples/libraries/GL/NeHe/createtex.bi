#include "fbgfx.bi"
const TEX_MASKED = &h1
const TEX_MIPMAP = &h2
const TEX_NOFILTER = &h4
const TEX_HASALPHA = &h8

'------------------------------------------------------------------------
'' Create texture creates textures from BLOAD buffer
private function CreateTexture( byval buffer as any ptr, byval flags as integer = 0 ) as uinteger
	
	dim p as uinteger ptr
	dim as integer w, h, x, y, col
	dim tex as uinteger
	dim as GLenum format, minfilter, magfilter
	dim as FB.PUT_HEADER ptr header = buffer

	function = 0
    
    if header->type = FB.PUT_HEADER_NEW then
		w = header->width
		h = header->height
    else
		w = header->old.width
		h = header->old.height
    end if
    

	if( (w < 64) or (h < 64) ) then
		exit function
	end if
	if( (w and (w-1)) or (h and (h-1)) ) then
		'' Width/height not powers of 2
		exit function
	end if

	redim dat(0 to (w * h) - 1) as uinteger
	p = @dat(0)

	glGenTextures 1, @tex
	glBindTexture GL_TEXTURE_2D, tex

	for y = h-1 to 0 step -1
		for x = 0 to w-1
			col = point(x, y, buffer)
			'' Swap R and B so we can use the GL_RGBA texture format
			col = rgb(col and &hFF, _
				(col shr 8) and &hFF, _
				(col shr 16) and &hFF)
			if( (flags and TEX_MASKED) and (col = &hFF00FF) ) then
				*p = 0
			else
				*p = col or &hFF000000
			end if
			p += 1
		next x
	next y

	if (flags and (TEX_MASKED or TEX_HASALPHA)) then
		format = GL_RGBA
	else
		format = GL_RGB
	end if

	if (flags and TEX_NOFILTER) then
		magfilter = GL_NEAREST
	else
		magfilter = GL_LINEAR
	end if

	if( flags and TEX_MIPMAP) then
		gluBuild2DMipmaps GL_TEXTURE_2D, format, w, h, GL_RGBA, _
			GL_UNSIGNED_BYTE, @dat(0)

		if (flags and TEX_NOFILTER) then
			minfilter = GL_LINEAR_MIPMAP_NEAREST
		else
			minfilter = GL_LINEAR_MIPMAP_LINEAR
		end if
	else
		glTexImage2D GL_TEXTURE_2D, 0, format, w, h, 0, GL_RGBA, _
			GL_UNSIGNED_BYTE, @dat(0)
		minfilter = magfilter
	end if

	glTexParameteri GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, minfilter
	glTexParameteri GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, magfilter

	function = tex

end function
