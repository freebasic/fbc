''
''	This gfxlib example deals with:
''		- palette
''		- multiple pages and double buffering
''		- direct access to the screen memory
''		- drawing to GET/PUT buffers
''

#define MAX_EXPLOSIONS		32
#define MAX_EXPLOSION_SIZE	100

#include "fbgfx.bi"


const FALSE = 0
const TRUE = not FALSE

type EXPLOSION_TYPE
	sprite as ubyte ptr
	x as integer
	y as integer
	used as integer
	count as integer
end type


declare sub animate_fire(byval buffer as ubyte ptr, byval new_ as integer = 0)


sub animate_fire(byval buffer as ubyte ptr, byval new_ as integer = 0)
	
	dim w as integer, h as integer, pitch as integer
	dim x as integer, y as integer, i as integer
	dim c0 as integer, c1 as integer, c2 as integer, c3 as integer
	dim header as FB.PUT_HEADER ptr
	
	header = cast(FB.PUT_HEADER ptr, buffer)
	w = header->width
	h = header->height
	pitch = header->pitch
	
	if new_ then
		line buffer, (0, 0)-(w-1, h-1), 0, bf
		for i = 0 to 5
			circle buffer, ((w\4)+(rnd*(w\2)), (h\4)+(rnd*(h\2))), (w\6), 191,,,,F
		next i
	else
		for y = 1 to h-2
			for x = 1 to w-2
				c0 = buffer[32 + (y * pitch) + x - 1]
				c1 = buffer[32 + (y * pitch) + x + 1]
				c2 = buffer[32 + ((y - 1) * pitch) + x]
				c3 = buffer[32 + ((y + 1) * pitch) + x]
				c0 = ((c0 + c1 + c2 + c3) \ 4) - rnd*2
				if (cint(c0) < 0) then c0 = 0
				buffer[32 + (y * pitch) + x] = c0
			next x
		next y
	end if
	
end sub


	dim pal(256) as integer, r as integer, g as integer, b as integer
	dim i as integer, j as integer, size as integer
	dim pixel as byte ptr
	dim explosion(MAX_EXPLOSIONS) as EXPLOSION_TYPE
	dim work_page as integer
	
	screen 14, 8, 3
	randomize timer
	
	'' load image and get palette
	''
	screenset 2
	bload "fblogo.bmp"
	palette get using pal
	
	'' image uses first 64 colors; since we need colors 0-191, we need to move
	'' these 64 colors into colors 192-255.
	''
	screenlock
	pixel = screenptr
	for i = 0 to (320*240)-1
		pixel[i] = 192 + pixel[i]
	next i
	screenunlock
	for i = 0 to 63
		pal(192+i) = pal(i)
	next i
	
	'' create fire palette
	''
	for i = 0 to 63
		pal(i) = i
		pal(64+i) = &h3F or (i shl 8)
		pal(128+i) = &h3F3F or (i shl 16)
	next i
	palette using pal
	
	'' start demo
	''
	screenset 1, 0
	work_page = 1
	do
		screencopy 2, work_page
		for i = 0 to MAX_EXPLOSIONS-1
			if ((explosion(i).used = FALSE) and ((rnd*50) < 1)) then
				size = (MAX_EXPLOSION_SIZE\4) + (rnd*((MAX_EXPLOSION_SIZE*3)/4))
				
				with explosion(i)
					.sprite = imagecreate( size, size )
					.x = rnd*320
					.y = rnd*240
					.used = TRUE
					.count = 192
				end with
				animate_fire explosion(i).sprite, TRUE
			end if
			
			if (explosion(i).used = TRUE) then
				animate_fire explosion(i).sprite
				put (explosion(i).x, explosion(i).y), explosion(i).sprite, trans	
				explosion(i).count = explosion(i).count - 1
				if (explosion(i).count <= 0) then
					explosion(i).used = FALSE
				end if
			end if
			
		next i
		screensync
		work_page xor= 1
		screenset work_page, work_page xor 1
		
	loop while inkey = ""
