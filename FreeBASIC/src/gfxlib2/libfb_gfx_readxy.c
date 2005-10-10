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
 * readxy.c -- implementation of SCREEN function for graphics mode
 *
 * chng: sep/2005 written [mjs]
 *
 */

#include "fb_gfx.h"


/*:::::*/
int fb_GfxReadXY( int col, int row, int colorflag )
{
    GFX_CHAR_CELL *cell;

    if( fb_mode==NULL )
        return 0;

    if( col < 1 || col > fb_mode->text_w
        || row < 1 || row > fb_mode->text_h )
        return 0;

    cell =
        fb_mode->con_pages[ fb_mode->work_page ]
        + (row - 1) * fb_mode->text_w
        + col - 1;
    if( colorflag==0 ) {
        return cell->ch;
    }

    if( fb_mode->depth <= 4 ) {
        return cell->fg + (cell->bg << 4);
    } else if( fb_mode->depth <= 8 ) {
        return cell->fg + (cell->bg << 8);
    } else {
        if( colorflag==2 )
            return cell->bg;
        return cell->fg;
    }
}
