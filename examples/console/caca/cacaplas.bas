/'
 *  cacaplas      plasma effect for libcaca
 *  Copyright (c) 2004 Sam Hocevar <sam@zoy.org>
 *                1998 Michele Bini <mibin@tin.it>
 *                All Rights Reserved
 *
 *  Id: cacaplas.bas,v 1.1 2005/03/27 07:21:59 i_am_drv Exp 
 *
 *  This program is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU Lesser General Public
 *  License as published by the Free Software Foundation; either
 *  version 2 of the License, or (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *  Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public
 *  License along with this program; if not, write to the Free Software
 *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
 *  02111-1301  USA
 '/

#undef screen

#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif

#include "caca0.bi"

' Virtual buffer size
#define XSIZ 256
#define YSIZ 256

#define TABLEX (XSIZ * 2)
#define TABLEY (YSIZ * 2)

dim shared screen(0 to XSIZ * YSIZ - 1) as ubyte
dim shared table(0 to TABLEX * TABLEY - 1) as ubyte

declare sub do_plasma ( byval as ubyte ptr, byval as double, byval as double, byval as double, byval as double, byval as double, byval as double )

dim as integer red(0 to 255), green(0 to 255), blue(0 to 255), alpha(0 to 255)
dim as double r(0 to 2), R_(0 to 5)
dim bitmap as caca_bitmap ptr
dim as integer i, x, y, frame

if caca_init() < 0 then
	end 1
end if

locate , , 0

caca_set_delay( 20000 )

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
	R_(i) = cdbl(caca_rand(1, 1000)) / 5000
next i

for y = 0 to TABLEY - 1
	for x = 0 to TABLEX - 1
		dim as double tmp = ((cdbl((x - (TABLEX / 2)) * (x - (TABLEX / 2)) _
		                         + (y - (TABLEX / 2)) * (y - (TABLEX / 2)))) _
		                     * (M_PI / (TABLEX * TABLEX + TABLEY * TABLEY)))

		table(x + y * TABLEX) = 1.0 + sin(12.0 * sqr(tmp)) * 256 / 6

	next x
next y

' create a libcaca bitmap
bitmap = caca_create_bitmap(8, XSIZ, YSIZ, XSIZ, 0, 0, 0, 0)

' main loop
frame = 0
do until caca_get_event(CACA_EVENT_KEY_PRESS)
	for i = 0 to 255
		dim as double z = cdbl(i) / 256 * 6 * M_PI

		red(i) = (1.0 + cos(z + r(0) * frame)) / 2 * &Hfff
		green(i) = (1.0 + sin(z + r(1) * frame)) / 2 * &Hfff
		blue(i) = (1.0 + cos(z + r(2) * frame)) / 2 * &Hfff
	next i

	' set the palette
	caca_set_bitmap_palette bitmap, @red(0), @green(0), @blue(0), @alpha(0)

	do_plasma( @screen(0), _
	           (1.0 + sin((cdbl(frame)) * R_(0))) / 2, _
	           (1.0 + sin((cdbl(frame)) * R_(1))) / 2, _
	           (1.0 + sin((cdbl(frame)) * R_(2))) / 2, _
	           (1.0 + sin((cdbl(frame)) * R_(3))) / 2, _
	           (1.0 + sin((cdbl(frame)) * R_(4))) / 2, _
	           (1.0 + sin((cdbl(frame)) * R_(5))) / 2 )

	caca_draw_bitmap( 0, 0, caca_get_width() - 1, caca_get_height() - 1, _
	                  bitmap, @screen(0) )
	caca_refresh()

	frame += 1
loop

caca_free_bitmap( bitmap )
caca_end()

end 0


sub do_plasma ( byval pixels as ubyte ptr, byval x_1 as double, byval y_1 as double, _
                byval x_2 as double, byval y_2 as double, byval x_3 as double, byval y_3 as double )
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

