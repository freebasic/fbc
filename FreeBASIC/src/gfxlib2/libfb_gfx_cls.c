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
 * cls.c -- screen clearing routine
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include "fb_gfx.h"


/*:::::*/
void fb_GfxClear(int mode)
{
    int i, dirty, dirty_len;
    int reset_gfx_pos;
    int reset_console_start = 0, reset_console_end = 0;
    int new_x = -1, new_y = -1;
	
	fb_hPrepareTarget(NULL);
	
	DRIVER_LOCK();
	
	switch (mode) {
		
		case 0:
			/* Clear entire screen */
            {
                int cursor_y = fb_ConsoleGetTopRow();

                fb_hPixelSet(fb_mode->line[0], fb_mode->bg_color, fb_mode->w * fb_mode->h);
                dirty = 0;
                dirty_len = fb_mode->h;

                new_x = 0;
                new_y = cursor_y;

                reset_console_end = fb_mode->text_h;

                reset_gfx_pos = TRUE;
            }
			break;
		
		case 2:
            /* Clear text viewport */
            {
                int con_y_start = fb_ConsoleGetTopRow();
                int con_y_end = fb_ConsoleGetBotRow();
                int y_start = con_y_start * fb_mode->font->h;
                int y_end = (con_y_end + 1) * fb_mode->font->h;
                int view_height = y_end - y_start;

                fb_hPixelSet(fb_mode->line[y_start],
                             fb_mode->bg_color,
                             fb_mode->w * view_height);
                dirty = y_start;
                dirty_len = view_height;

                new_x = 0;
                new_y = con_y_start;

                reset_console_start = con_y_start;
                reset_console_end = con_y_end + 1;

                reset_gfx_pos = FALSE;
            }
            break;

		case 1:
		default:
            /* Clear graphics viewport if set */
            {
                unsigned char *dest = fb_mode->line[fb_mode->view_y] + (fb_mode->view_x * fb_mode->bpp);
                for (i = 0; i < fb_mode->view_h; i++) {
                    fb_hPixelSet(dest, fb_mode->bg_color, fb_mode->view_w);
                    dest += fb_mode->pitch;
                }
                dirty = fb_mode->view_y;
                dirty_len = fb_mode->view_h;

                reset_gfx_pos = TRUE;
            }
			break;
	}
	SET_DIRTY(dirty, dirty_len);
	
    if( reset_gfx_pos ) {
        fb_mode->last_x = fb_mode->view_x + (fb_mode->view_w >> 1);
        fb_mode->last_y = fb_mode->view_y + (fb_mode->view_h >> 1);
    }

    fb_hClearCharCells( 0, reset_console_start,
                        fb_mode->text_w, reset_console_end,
                        fb_mode->work_page,
                        32,
                        fb_mode->fg_color, fb_mode->bg_color );

    if( new_x!=-1 || new_y!=-1 ) {
        fb_GfxLocate( new_y + 1, new_x + 1, -1 );
    }

    DRIVER_UNLOCK();
}
