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
 * memory.c -- scratch memory allocator
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include "fb_gfx.h"


/*:::::*/
void fb_hMemInit(int size)
{
	if (size > fb_mode->scratch_mem_size) {
		if (fb_mode->scratch_mem)
			free(fb_mode->scratch_mem);
		fb_mode->scratch_mem = malloc(size);
		fb_mode->scratch_mem_ptr = 0;
		fb_mode->scratch_mem_size = size;
	}
}


/*:::::*/
void *fb_hMemAlloc(int size)
{
	void *temp;
	
	if (fb_mode->scratch_mem_ptr + size > fb_mode->scratch_mem_size) {
		temp = malloc((fb_mode->scratch_mem_size + size) << 1);
		if (!temp)
			return NULL;
		fb_hMemCpy(temp, fb_mode->scratch_mem, fb_mode->scratch_mem_ptr);
		free(fb_mode->scratch_mem);
		fb_mode->scratch_mem = temp;
		fb_mode->scratch_mem_size = (fb_mode->scratch_mem_size + size) << 1;
	}
	temp = (void *)((unsigned char *)fb_mode->scratch_mem + fb_mode->scratch_mem_ptr);
	fb_mode->scratch_mem_ptr += size;
	
	return temp;
}
