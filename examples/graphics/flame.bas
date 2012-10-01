''
'' This fbgfx example deals with:
'' - palette
'' - multiple pages and double buffering
'' - direct access to the screen memory
'' - drawing to GET/PUT buffers
''

#define MAX_EXPLOSIONS     32
#define MAX_EXPLOSION_SIZE 100

#include "fbgfx.bi"

const FALSE = 0
const TRUE = (-1)

type EXPLOSION_TYPE
	sprite as ubyte ptr
	x as integer
	y as integer
	used as integer
	count as integer
end type

sub animate_fire(byval buffer as ubyte ptr, byval new_ as integer = 0)
	dim w as integer, h as integer, pitch as integer
	dim c0 as integer, c1 as integer, c2 as integer, c3 as integer
	dim header as FB.PUT_HEADER ptr

	header = cast(FB.PUT_HEADER ptr, buffer)
	w = header->width
	h = header->height
	pitch = header->pitch

	if new_ then
		line buffer, (0, 0)-(w-1, h-1), 0, bf
		for i as integer = 0 to 5
			circle buffer, ((w\4)+(rnd*(w\2)), (h\4)+(rnd*(h\2))), (w\6), 191,,,,F
		next
	else
		for y as integer = 1 to h-2
			for x as integer = 1 to w-2
				c0 = buffer[32 + (y * pitch) + x - 1]
				c1 = buffer[32 + (y * pitch) + x + 1]
				c2 = buffer[32 + ((y - 1) * pitch) + x]
				c3 = buffer[32 + ((y + 1) * pitch) + x]
				c0 = ((c0 + c1 + c2 + c3) \ 4) - rnd*2
				if (cint(c0) < 0) then c0 = 0
				buffer[32 + (y * pitch) + x] = c0
			next
		next
	end if
end sub


	dim pal(256) as integer, r as integer, g as integer, b as integer
	dim explosion(MAX_EXPLOSIONS) as EXPLOSION_TYPE
	dim work_page as integer

	screen 14, 8, 3
	randomize timer

	'' load image and get palette
	screenset 2
	bload exepath() & "/../fblogo.bmp"
	palette get using pal

	'' image uses first 64 colors; since we need colors 0-191, we need to move
	'' these 64 colors into colors 192-255.
	screenlock
	dim as byte ptr pixel = screenptr()
	for i as integer = 0 to (320*240)-1
		pixel[i] = 192 + pixel[i]
	next
	screenunlock
	for i as integer = 0 to 63
		pal(192+i) = pal(i)
	next

	'' create fire palette
	for i as integer = 0 to 63
		pal(i) = i
		pal(64+i) = &h3F or (i shl 8)
		pal(128+i) = &h3F3F or (i shl 16)
	next
	palette using pal

	'' start demo
	screenset 1, 0
	work_page = 1

	do
		screencopy 2, work_page

		for i as integer = 0 to MAX_EXPLOSIONS-1
			if (explosion(i).used = FALSE) and ((rnd*50) < 1) then
				dim as integer size = (MAX_EXPLOSION_SIZE\4) + (rnd*((MAX_EXPLOSION_SIZE*3)/4))

				with explosion(i)
					.sprite = imagecreate( size, size )
					.x = rnd*320
					.y = rnd*240
					.used = TRUE
					.count = 192
				end with

				animate_fire( explosion(i).sprite, TRUE )
			end if

			if explosion(i).used then
				animate_fire( explosion(i).sprite )

				put (explosion(i).x, explosion(i).y), explosion(i).sprite, trans

				explosion(i).count -= 1
				if explosion(i).count <= 0 then
					explosion(i).used = FALSE
				end if
			end if
		next

		screensync
		work_page xor= 1
		screenset work_page, work_page xor 1
	loop while inkey = ""
