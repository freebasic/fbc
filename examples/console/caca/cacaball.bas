/'
 *  cacaball      metaballs effect for libcaca
 *  Copyright (c) 2003-2004 Jean-Yves Lamoureux <jylam@lnxscene.org>
 *                All Rights Reserved
 *
 *  Id: cacaball.bas,v 1.2 2005/07/23 17:39:53 v1ctor Exp 
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

#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif

#include "caca0.bi"

/' Virtual buffer size '/
#define XSIZ 256
#define YSIZ 256

#define METASIZE 100
#define METABALLS 16

/' Colour index where to crop balls '/
#define CROPBALL 160

declare sub create_ball()
declare sub draw_ball(byval as uinteger, byval as uinteger)

dim shared pixels(0 to XSIZ * YSIZ - 1) as ubyte
dim shared metaball(0 to METASIZE * METASIZE - 1) as ubyte

dim as integer r(0 to 255), g(0 to 255), b(0 to 255), a(0 to 255)
dim as single d(0 to METABALLS - 1), di(0 to METABALLS - 1), dj(0 to METABALLS - 1), dk(0 to METABALLS - 1)
dim as uinteger x(0 to METABALLS - 1), y(0 to METABALLS - 1)
dim as single i = 10.0, j = 17.0, k = 11.0
dim as integer frame

	if (caca_init()) then
		end 1
	end if

	caca_set_delay(20000)

	/' Make the palette eatable by libcaca '/
	for p as integer = 0 to 255
		r(p) = 0
		g(p) = 0
		b(p) = 0
		a(p) = 0
	next

	r(255) = &HFFF
	g(255) = &HFFF
	b(255) = &HFFF

	/' Create a libcaca bitmap smaller than our pixel buffer, so that we
	 * display only the interesting part of it '/
	dim bitmap as caca_bitmap ptr = _
		caca_create_bitmap(8, XSIZ - METASIZE, YSIZ - METASIZE, XSIZ, _
						0, 0, 0, 0)

	/' Generate ball sprite '/
	create_ball()

	for p as integer = 0 to METABALLS - 1
		d(p) = caca_rand(0, 100)
		di(p) = csng(caca_rand(500, 4000)) / 6000.0
		dj(p) = csng(caca_rand(500, 4000)) / 6000.0
		dk(p) = csng(caca_rand(500, 4000)) / 6000.0
	next

	'' Go !
	do until caca_get_event(CACA_EVENT_KEY_PRESS)
		frame += 1

		/' Crop the palette '/
		for p as integer = CROPBALL to 254
			dim as integer t1, t2, t3
			t1 = iif(p < &H40 , 0 , iif(p < &Hc0 , (p - &H40) * &H20 , &Hfff))
			t2 = iif(p < &He0 , 0 , (p - &He0) * &H80)
			t3 = iif(p < &H40 , p * &H40 , &Hfff)

			r(p) = (1.0 + sin(cdbl(frame) * M_PI / 60)) * t1 \ 4 _
			     + (1.0 + sin(cdbl(frame + 40) * M_PI / 60)) * t2 \ 4 _
			     + (1.0 + sin(cdbl(frame + 80) * M_PI / 60)) * t3 \ 4
			g(p) = (1.0 + sin(cdbl(frame) * M_PI / 60)) * t2 \ 4 _
			     + (1.0 + sin(cdbl(frame + 40) * M_PI / 60)) * t3 \ 4 _
			     + (1.0 + sin(cdbl(frame + 80) * M_PI / 60)) * t1 \ 4
			b(p) = (1.0 + sin(cdbl(frame) * M_PI / 60)) * t3 \ 4 _
			     + (1.0 + sin(cdbl(frame + 40) * M_PI / 60)) * t1 \ 4 _
			     + (1.0 + sin(cdbl(frame + 80) * M_PI / 60)) * t2 \ 4
		next

		/' Set the palette '/
		caca_set_bitmap_palette(bitmap, @r(0), @g(0), @b(0), @a(0))

		/' Silly paths for our balls '/
		for p as integer = 0 to METABALLS - 1
			dim as single u, v
			u = di(p) * i + dj(p) * j + dk(p) * sin(di(p) * k)
			v = d(p) + di(p) * j + dj(p) * k + dk(p) * sin(dk(p) * i)
			u = sin(i + u * 2.1) * (1.0 + sin(u))
			v = sin(j + v * 1.9) * (1.0 + sin(v))
			x(p) = (XSIZ - METASIZE) \ 2 + u * (XSIZ - METASIZE) \ 4
			y(p) = (YSIZ - METASIZE) \ 2 + v * (YSIZ - METASIZE) \ 4
		next

		i += 0.011
		j += 0.017
		k += 0.019

		clear pixels(0), 0, XSIZ * YSIZ

		/' Here is all the trick. Maybe if you're that
		 * clever you'll understand. '/
		for p as integer = 0 to METABALLS - 1
			draw_ball(x(p), y(p))
		next

		/' Draw our virtual buffer to screen, letting libcaca resize it '/
		caca_draw_bitmap(0, 0, caca_get_width() - 1, caca_get_height() - 1, _
		                 bitmap, @pixels(0) + (METASIZE \ 2) * (1 + XSIZ))
		caca_refresh()
	loop

	/' End, bye folks '/
	caca_end()

	end 0


/' Generate ball sprite
 * You should read the comments, I already wrote that before ... '/
sub create_ball()
	for y as integer = 0 to METASIZE - 1
		for x as integer = 0 to METASIZE - 1
			dim distance as single
			distance = ((METASIZE\2) - x) * ((METASIZE\2) - x) _
			         + ((METASIZE\2) - y) * ((METASIZE\2) - y)
			distance = sqr(distance) * 64 / METASIZE
			metaball(x + y * METASIZE) = iif(distance > 15 , 0 , cint(((255.0 - distance) * 15)))
		next
	next
end sub

/' You missed the trick? '/
sub draw_ball(byval bx as uinteger, byval by as uinteger)
	dim b as uinteger = (by * XSIZ) + bx
	dim e as uinteger

	for i as integer = 0 to METASIZE * METASIZE - 1
		dim colr as uinteger = pixels(b) + metaball(i)
		if (colr > 255) then
			colr = 255
		end if

		pixels(b) = colr
		if (e = METASIZE) then
			e = 0
			b += XSIZ - METASIZE
		end if
		b += 1
		e += 1
	next
end sub
