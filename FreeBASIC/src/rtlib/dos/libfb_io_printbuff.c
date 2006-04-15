/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2006 Andre V. T. Vicentini (av1ctor@yahoo.com.br) and
 *  the FreeBASIC development team.
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
 *
 *  As a special exception, the copyright holders of this library give
 *  you permission to link this library with independent modules to
 *  produce an executable, regardless of the license terms of these
 *  independent modules, and to copy and distribute the resulting
 *  executable under terms of your choice, provided that you also meet,
 *  for each linked independent module, the terms and conditions of the
 *  license of that module. An independent module is a module which is
 *  not derived from or based on this library. If you modify this library,
 *  you may extend this exception to your version of the library, but
 *  you are not obligated to do so. If you do not wish to do so, delete
 *  this exception statement from your version.
 */

/*
 * io_printbuff.c -- low-level print to console function for DOS
 *
 * chng: jan/2005 written [DrV]
 *
 */

#include "fb.h"
#include "fb_con.h"
#include <unistd.h>
#include <string.h>
#include <malloc.h>
#include <sys/farptr.h>
#include <go32.h>
#include <pc.h>

typedef struct _fb_PrintInfo {
    unsigned short usAttr;
} fb_PrintInfo;

static
void fb_hHookConScroll_BIOS(struct _fb_ConHooks *handle,
                            int x1, int y1,
                            int x2, int y2,
                            int rows)
{
    fb_ConsoleScroll_BIOS( x1, y1, x2, y2, rows );
    handle->Coord.Y = handle->Border.Bottom;
}

static
int  fb_hHookConWrite_BIOS (struct _fb_ConHooks *handle,
                            const void *buffer,
                            size_t length )
{
    fb_PrintInfo *pInfo = (fb_PrintInfo*) handle->Opaque;
    const char *pachText = (const char *)buffer;
    __dpmi_regs regs;
    unsigned char uchAttr = (unsigned char) pInfo->usAttr;
    int tmp_x = handle->Coord.X;
    int tmp_y = handle->Coord.Y;

    while( length-- ) {
        unsigned short usPos = (unsigned short) (tmp_y << 8) + tmp_x++;
        _movedataw( _my_ds(), (int) &usPos, _dos_ds, 0x450, 1 );
        regs.h.ah = 0x09;
        regs.h.al = *pachText++;
        regs.h.bh = 0x00;
        regs.h.bl = uchAttr;
        regs.x.cx = 1;
        __dpmi_int(0x10, &regs);
    }

    return TRUE;
}

static
int  fb_hHookConWrite_MEM (struct _fb_ConHooks *handle,
                           const void *buffer,
                           size_t length )
{
    fb_PrintInfo *pInfo = (fb_PrintInfo*) handle->Opaque;
    const char *pachText = (const char *)buffer;
    unsigned short usAttr = pInfo->usAttr << 8;
    int tmp_x = handle->Coord.X;
    int tmp_y = handle->Coord.Y;
    unsigned char *puchBuffer = alloca( length * 2 );
    unsigned short *pusBuffer = (unsigned short*) puchBuffer;
    size_t i;

    i = length;
    pusBuffer += length;
    while( i-- ) {
        *--pusBuffer = usAttr + (unsigned short) (unsigned char) pachText[i];
    }

    _movedataw( _my_ds(), (int) puchBuffer,
                _dos_ds, fb_dos_txtmode.phys_addr + (fb_dos_txtmode.w << 1) * tmp_y + (tmp_x << 1),
                length );

    return TRUE;
}

/*:::::*/
void fb_ConsolePrintBufferEx_SCRN( const void *buffer, size_t len, int mask )
{
    const char *pachText = (const char *) buffer;
    int win_left, win_top, win_cols, win_rows;
    int view_top, view_bottom;
    fb_PrintInfo info;
    fb_ConHooks hooks;

    /* Do we want to correct the console cursor position? */
    if( (mask & FB_PRINT_FORCE_ADJUST)==0 ) {
        /* No, we can check for the length to avoid unnecessary stuff ... */
        if( len==0 )
            return;
    }

    FB_LOCK();

    fb_ConsoleGetSize( &win_cols, &win_rows );
    fb_ConsoleGetView( &view_top, &view_bottom );
    win_left = win_top = 0;

    {
        unsigned char uchCurrentMode = _farpeekb( _dos_ds, 0x465 );
        fb_dos_txtmode.w = win_cols;
        fb_dos_txtmode.h = win_rows;
        if( uchCurrentMode & 0x02 ) {
            fb_dos_txtmode.phys_addr = 0x00000;
        } else if( uchCurrentMode & 0x04 ) {
            fb_dos_txtmode.phys_addr = 0xB0000;
        } else {
            fb_dos_txtmode.phys_addr = 0xB8000;
        }

    }

    hooks.Opaque        = &info;
    if( fb_dos_txtmode.phys_addr ) {
        hooks.Scroll        = fb_hHookConScroll_BIOS;
        hooks.Write         = fb_hHookConWrite_MEM;
    } else {
        hooks.Scroll        = fb_hHookConScroll_BIOS;
        hooks.Write         = fb_hHookConWrite_BIOS;
    }
    hooks.Border.Left   = win_left;
    hooks.Border.Top    = win_top + view_top - 1;
    hooks.Border.Right  = win_left + win_cols - 1;
    hooks.Border.Bottom = win_top + view_bottom - 1;

    info.usAttr         = (unsigned short) (unsigned char) fb_ConsoleGetColorAtt();

    {
        fb_ConsoleGetXY_BIOS( &hooks.Coord.X, &hooks.Coord.Y );

        if( ScrollWasOff ) {
            ScrollWasOff = FALSE;
            ++hooks.Coord.Y;
            hooks.Coord.X = hooks.Border.Left;
            fb_hConCheckScroll( &hooks );
        }

        fb_ConPrintTTY( &hooks,
                        pachText,
                        len,
                        TRUE );

        if( hooks.Coord.X != hooks.Border.Left
            || hooks.Coord.Y != (hooks.Border.Bottom+1) )
        {
            fb_hConCheckScroll( &hooks );
        } else {
            ScrollWasOff = TRUE;
            hooks.Coord.X = hooks.Border.Right;
            hooks.Coord.Y = hooks.Border.Bottom;
        }
        fb_ConsoleLocate_BIOS( hooks.Coord.Y, hooks.Coord.X, -1 );
    }

    FB_UNLOCK();
}

/*:::::*/
void fb_ConsolePrintBufferEx_STDIO(const void *buffer, size_t len, int mask)
{
    fwrite(buffer, len, 1, stdout);
    fflush(stdout);
}

/*:::::*/
void fb_ConsolePrintBufferEx( const void *buffer, size_t len, int mask )
{
	static void (*fn)(const void *buffer, size_t len, int mask) = NULL;

	if( fn == NULL )
	{
		/* use cprintf() if STDOUT is the console;
       	   otherwise (with shell I/O redirection) use printf() */
    	if( isatty( fileno( stdout ) ) )
        	fn = fb_ConsolePrintBufferEx_SCRN;
    	else
        	fn = fb_ConsolePrintBufferEx_STDIO;
    }

    fn( buffer, len, mask );
}

/*:::::*/
void fb_ConsolePrintBuffer( const char *buffer, int mask )
{
	fb_ConsolePrintBufferEx( buffer, strlen( buffer ), mask );
}
