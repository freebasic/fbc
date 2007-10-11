/*
 *  libgfx2 - FreeBASIC's alternative gfx library
 *	Copyright (C) 2005 Angelo Mottola (a.mottola@libero.it)
 *
 *  This library is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU Lesser General Public
 *  License as published by the Free Software Foundation; either
 *  version 2.1 of the License, or (at your option) any later version.
 *
 *  This library is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *  Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public
 *  License along with this library; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/

/*
 * joystick.c -- joystick handling, dos
 *
 * chng: jun/2005 written [DrV]
 *
 */

#include "fb_gfx.h"
#include "fb_gfx_dos.h"

#define JOY_PORT 0x201
#define JOY_AXIS1 0x1
#define JOY_AXIS2 0x2
#define JOY_AXIS3 0x4
#define JOY_AXIS4 0x8
#define JOY_COUNT 100000

#define CALCPOS(pos, min, max)	(((((float)(pos) - (float)(min)) * 2.0) / ((float)(max) - (float)(min) + 1.0)) - 1.0)

static int detected = TRUE;

static int min_x1 = JOY_COUNT, min_y1 = JOY_COUNT, min_x2 = JOY_COUNT, min_y2 = JOY_COUNT;
static int max_x1 = 0, max_y1 = 0, max_x2 = 0, max_y2 = 0;

__dpmi_regs regs;

/*:::::*/
FBCALL int fb_GfxGetJoystick(int id, int *buttons, float *a1, float *a2, float *a3, float *a4, float *a5, float *a6, float *a7, float *a8)
{
	unsigned char status;
	int count;
	int x1 = 0, y1 = 0, x2 = 0, y2 = 0;

	if (!detected) {
		*buttons = -1;
		*a1 = *a2 = *a3 = *a4 = *a5 = *a6 = *a7 = *a8 = -1000.0;
		return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
	}

	fb_dos_cli();

	outportb(0x201, 0);

	for (count = 0; count < JOY_COUNT; count++) {
		status = inportb(0x201);

		if (status & JOY_AXIS1)
			x1++;

		if (status & JOY_AXIS2)
			y1++;

		if (status & JOY_AXIS3)
			x2++;

		if (status & JOY_AXIS4)
			y2++;

		if ((status & 0xF) == 0)
			break;
	}

	fb_dos_sti();

	if ((x1 >= JOY_COUNT) || (y1 >= JOY_COUNT)) {
		detected = FALSE;
		*buttons = -1;
		*a1 = *a2 = *a3 = *a4 = *a5 = *a6 = -1000.0;
		return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
	}

	if (x1 < min_x1)
		min_x1 = x1;

	if (y1 < min_y1)
		min_y1 = y1;

	if (x2 < min_x2)
		min_x2 = x2;

	if (y2 < min_y2)
		min_y2 = y2;


	if (x1 > max_x1)
		max_x1 = x1;

	if (y1 > max_y1)
		max_y1 = y1;

	if (x2 > max_x2)
		max_x2 = x2;

	if (y2 > max_y2)
		max_y2 = y2;

	*a1 = CALCPOS(x1, min_x1, max_x1);
	*a2 = CALCPOS(y1, min_y1, max_y1);
	*a3 = CALCPOS(x2, min_x2, max_x2);
	*a4 = CALCPOS(y2, min_y2, max_y2);

	status = inportb(JOY_PORT);

	*buttons = (~status >> 4) & 0xF;

	*a5 = *a6 = *a7 = *a8 = -1000.0;

	return fb_ErrorSetNum( FB_RTERROR_OK );

}
