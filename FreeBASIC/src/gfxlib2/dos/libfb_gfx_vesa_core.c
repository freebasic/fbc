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
 * vesa.c -- common VESA SVGA routines
 *
 * chng: apr/2005 written [DrV]
 *
 */

#include "fb_gfx_dos.h"

VesaPMInfo *fb_dos_vesa_pm_info = NULL;
void *fb_dos_vesa_pm_bank_switcher = NULL;

static int detected = FALSE;

/*:::::*/
void vesa_get_pm_functions(void)
{
	if (fb_dos.vesa_info.vbe_version < 0x200)
		return;
	
	fb_dos.regs.x.ax = 0x4F0A;
	fb_dos.regs.x.bx = 0;
	__dpmi_int(0x10, &fb_dos.regs);
	if (fb_dos.regs.h.ah)
		return;
	
	fb_dos_vesa_pm_info = malloc(fb_dos.regs.x.cx);
	
	dosmemget(fb_dos.regs.x.es * 16 + fb_dos.regs.x.di, fb_dos.regs.x.cx, fb_dos_vesa_pm_info);
	
	fb_dos_vesa_pm_bank_switcher = (char *)fb_dos_vesa_pm_info + fb_dos_vesa_pm_info->setWindow;
	
}


/*:::::*/
static int vesa_get_mode_info(int mode)
{
	int i;

	_farsetsel(_dos_ds);

	for (i = 0; i < sizeof(fb_dos.vesa_mode_info); i++) {
		_farnspokeb(MASK_LINEAR(__tb) + i, 0);
	}

	fb_dos.regs.x.ax = 0x4F01;
	fb_dos.regs.x.di = RM_OFFSET(__tb);
	fb_dos.regs.x.es = RM_SEGMENT(__tb);
	fb_dos.regs.x.cx = mode;
	__dpmi_int(0x10, &fb_dos.regs);
	if (fb_dos.regs.h.ah)
		return -1;

	dosmemget(MASK_LINEAR(__tb), sizeof(fb_dos.vesa_mode_info), &fb_dos.vesa_mode_info);
	return 0;
}


/*:::::*/
void fb_dos_vesa_detect(void)
{
	int i;
	int mode_list[256];
	int number_of_modes;
	long mode_ptr;
	int c;
	int attribs = VMI_MA_SUPPORTED | VMI_MA_COLOR | VMI_MA_GRAPHICS;
	
	if (detected)
		return;
	
	detected = TRUE;
		
	/* detect VESA */
	
	fb_dos.vesa_ok = FALSE;
	
	_farsetsel(_dos_ds);

	for (i = 4; i < (int)sizeof(VbeInfoBlock); i++)
		_farnspokeb(MASK_LINEAR(__tb) + i, 0);
	
	dosmemput("VBE2", 4, MASK_LINEAR(__tb)); /* get VESA 2 info if available */
	
	fb_dos.regs.x.ax = 0x4F00;
	fb_dos.regs.x.di = RM_OFFSET(__tb);
	fb_dos.regs.x.es = RM_SEGMENT(__tb);
	__dpmi_int(0x10, &fb_dos.regs);
	
	if (fb_dos.regs.h.ah == 0x00)
	{
		dosmemget(MASK_LINEAR(__tb), sizeof(VbeInfoBlock), &fb_dos.vesa_info);
		if (strncmp(fb_dos.vesa_info.vbe_signature, "VESA", 4) == 0)
			fb_dos.vesa_ok = TRUE;
	}
	
	/* get VESA modes */
	if (fb_dos.vesa_ok)
	{
		
		mode_ptr = RM_TO_LINEAR(fb_dos.vesa_info.video_mode_ptr);
		
		number_of_modes = 0;
		
		while (_farpeekw(_dos_ds, mode_ptr) != 0xFFFF)
		{
			mode_list[number_of_modes] = _farpeekw(_dos_ds, mode_ptr);
			number_of_modes++;
			mode_ptr += 2;
		}
		
		fb_dos.num_vesa_modes = number_of_modes;
		
		fb_dos.vesa_modes = malloc(number_of_modes * sizeof(VesaModeInfo));
		
		for (c = 0; c < number_of_modes; c++)
		{
			if ( (vesa_get_mode_info(mode_list[c]) == 0) &&
			     ((fb_dos.vesa_mode_info.ModeAttributes & attribs) == attribs) && /* color graphics mode and supported */
			     (fb_dos.vesa_mode_info.NumberOfPlanes == 1) &&
			     ((fb_dos.vesa_mode_info.MemoryModel == VMI_MM_PACK) || (fb_dos.vesa_mode_info.MemoryModel == VMI_MM_DIR)) )
			{
				/* clobber WinFuncPtr to hold mode number */
				fb_dos.vesa_mode_info.WinFuncPtr = mode_list[c];

				/* add to list */
				memcpy(&fb_dos.vesa_modes[c], &fb_dos.vesa_mode_info, sizeof(VesaModeInfo));
			}
		}
	}
}


/*:::::*/
int fb_dos_vesa_set_mode(int w, int h, int depth, int linear)
{
	int i, mode = 0;
	int bpp;

	for ( i = 0; i < fb_dos.num_vesa_modes; i++ )
	{
		if ( (fb_dos.vesa_modes[i].XResolution == w) && (fb_dos.vesa_modes[i].YResolution == h) )
		{
			bpp = fb_dos.vesa_modes[i].BitsPerPixel;
			if ( (bpp == depth) ||
			     (bpp == 15 && depth == 16) ||
			     (bpp == 16 && depth == 15) ||
			     (bpp == 24 && depth == 32) ||
			     (bpp == 32 && depth == 24) )
			{
				if ( !linear || (fb_dos.vesa_modes[i].ModeAttributes & VMI_MA_LFB) )
				{
					memcpy(&fb_dos.vesa_mode_info, &fb_dos.vesa_modes[i], sizeof(VesaModeInfo));
					mode = fb_dos.vesa_modes[i].WinFuncPtr;
					break;
				}
			}
		}
	}
	
	if (!mode)
		return -1;
	
	fb_dos.regs.x.ax = 0x13;
	__dpmi_int(0x10, &fb_dos.regs);
	
	fb_dos.regs.x.ax = 0x4F02;
	fb_dos.regs.x.bx = mode;
	if (linear) fb_dos.regs.x.bx |= 0x4000;
	__dpmi_int(0x10, &fb_dos.regs);
	
	return (fb_dos.regs.h.ah ? -1 : 0);
}


/*:::::*/
int *fb_dos_vesa_fetch_modes(int depth, int *size)
{
	int *modes;
	int count, i;
	int bpp;

	if (!fb_dos.detected) fb_dos_detect();
	if (!detected) fb_dos_vesa_detect();

	modes = malloc(sizeof(VesaModeInfo) * fb_dos.num_vesa_modes);

	for (i = 0, count = 0; i < fb_dos.num_vesa_modes; i++) {
		if (fb_dos.vesa_modes[i].XResolution != 0)
		{
			bpp = fb_dos.vesa_modes[i].BitsPerPixel;
			if ( (bpp == depth) ||
			     (bpp == 15 && depth == 16) ||
			     (bpp == 16 && depth == 15) ||
			     (bpp == 24 && depth == 32) ||
			     (bpp == 32 && depth == 24) )
			{
				modes[count++] = SCREENLIST(fb_dos.vesa_modes[i].XResolution, fb_dos.vesa_modes[i].YResolution);
			}
		}
	}
	*size = count;
	return modes;
}
