'/*
' *  cacaplas      plasma effect for libcaca
' *  Copyright (c) 2004 Sam Hocevar <sam@zoy.org>
' *                1998 Michele Bini <mibin@tin.it>
' *                All Rights Reserved
' *
' *  $Id$
' *
' *  This program is free software; you can redistribute it and/or
' *  modify it under the terms of the GNU Lesser General Public
' *  License as published by the Free Software Foundation; either
' *  version 2 of the License, or (at your option) any later version.
' *
' *  This program is distributed in the hope that it will be useful,
' *  but WITHOUT ANY WARRANTY; without even the implied warranty of
' *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
' *  Lesser General Public License for more details.
' *
' *  You should have received a copy of the GNU Lesser General Public
' *  License along with this program; if not, write to the Free Software
' *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
' *  02111-1307  USA
' */

option explicit
option nokeyword screen

#ifndef M_PI
#   define M_PI 3.14159265358979323846
#endif

#include "caca.bi"

' Virtual buffer size
#define XSIZ 256
#define YSIZ 256

#define TABLEX (XSIZ * 2)
#define TABLEY (YSIZ * 2)

dim shared screen(XSIZ * YSIZ - 1) as ubyte
dim shared table(TABLEX * TABLEY) as ubyte

declare sub do_plasma (byval as ubyte ptr, byval as double, byval as double, byval as double, byval as double, byval as double, byval as double )

dim red(255) as integer, green(255) as integer, blue(255) as integer, alpha(255) as integer
dim r(2) as double, big_r(5) as double
dim bitmap as caca_bitmap ptr
dim i as integer, x as integer, y as integer, frame as integer

if caca_init() < 0 then
	end 1
end if

locate , , 0

caca_set_delay 20000

' fill various tables
for i = 0 to 255
	red(i) = 0
	green(i) = 0
	blue(i) = 0
	alpha(i) = 0
next i

for i = 0 to 2
	r(i) = cdbl(caca_rand(1, 1000)) / 30000 * M_PI
next i

for i = 0 to 5
	big_r(i) = cdbl(caca_rand(1, 1000)) / 5000
next i

for y = 0 to TABLEY - 1
	for x = 0 to TABLEX - 1
		dim tmp as double
		tmp = ((cdbl((x - (TABLEX / 2)) * (x - (TABLEX / 2)) _
                              + (y - (TABLEX / 2)) * (y - (TABLEX / 2)))) _
                      * (M_PI / (TABLEX * TABLEX + TABLEY * TABLEY)))

		table(x + y * TABLEX) = 1.0 + sin(12.0 * sqr(tmp)) * 256 / 6

	next x
next y

' create a libcaca bitmap
bitmap = caca_create_bitmap(8, XSIZ, YSIZ, XSIZ, 0, 0, 0, 0)

' main loop
frame = 0
do while not caca_get_event(CACA_EVENT_KEY_PRESS)
	for i = 0 to 255
		dim z as double
		z = cdbl(i) / 256 * 6 * M_PI
	
		red(i) = (1.0 + cos(z + r(0) * frame)) / 2 * &Hfff
		green(i) = (1.0 + sin(z + r(1) * frame)) / 2 * &Hfff
		blue(i) = (1.0 + cos(z + r(2) * frame)) / 2 * &Hfff
	next i
	
	' set the palette
	caca_set_bitmap_palette bitmap, @red(0), @green(0), @blue(0), @alpha(0)
	
	do_plasma @screen(0), _
	          (1.0 + sin((cdbl(frame)) * R(0))) / 2, _
                  (1.0 + sin((cdbl(frame)) * R(1))) / 2, _
                  (1.0 + sin((cdbl(frame)) * R(2))) / 2, _
                  (1.0 + sin((cdbl(frame)) * R(3))) / 2, _
                  (1.0 + sin((cdbl(frame)) * R(4))) / 2, _
                  (1.0 + sin((cdbl(frame)) * R(5))) / 2

	caca_draw_bitmap 0, 0, caca_get_width() - 1, caca_get_height() - 1, bitmap, @screen(0)

	caca_refresh

	frame += 1
loop

caca_free_bitmap bitmap
caca_end

end 0

sub do_plasma ( byval pixels as ubyte ptr, byval x_1 as double, byval y_1 as double, byval x_2 as double, byval y_2 as double, byval x_3 as double, byval y_3 as double)
	dim as uinteger x1, y1, x2, y2, x3, y3
	
	x1 = x_1 * (TABLEX \ 2)
	y1 = y_1 * (TABLEY \ 2)
	x2 = x_2 * (TABLEX \ 2)
	y2 = y_2 * (TABLEY \ 2)
	x3 = x_3 * (TABLEX \ 2)
	y3 = y_3 * (TABLEY \ 2)
	
	dim y as uinteger
	dim as ubyte ptr t1, t2, t3
	
	t1 = @table(0) + x1 + y1 * TABLEX
	t2 = @table(0) + x2 + y2 * TABLEX
	t3 = @table(0) + x3 + y3 * TABLEX

	for y = 0 to YSIZ - 1
		dim x as uinteger
		dim tmp as ubyte ptr
	
		tmp = pixels + y * YSIZ
	
		dim as uinteger ty, tmax
	
		ty = y * TABLEX
		tmax = ty + XSIZ
		
		x = 0
		do while ty < tmax
			tmp[0] = t1[ty] + t2[ty] + t3[ty]
			ty += 1
			tmp += 1
		loop
	next y
end sub