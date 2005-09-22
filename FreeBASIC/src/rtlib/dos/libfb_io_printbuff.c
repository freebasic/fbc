/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2005 Andre V. T. Vicentini (av1ctor@yahoo.com.br) and others.
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

void (*fb_ConsolePrintBufferProc) (const void *buffer, size_t len, int mask);

typedef struct _fb_PrintInfo {
    fb_Rect rWindow;
    FILE   *hOutput;
    int     fViewSet;
} fb_PrintInfo;

static
void fb_hHookConScroll(struct _fb_ConHooks *handle,
                       int x1,
                       int y1,
                       int x2,
                       int y2,
                       int rows)
{
    fb_ConsoleScroll_BIOS( x1, y1, x2, y2, rows );
}

static
void fb_hHookConLocate( struct _fb_ConHooks *handle )
{
}

static
int  fb_hHookConWrite (struct _fb_ConHooks *handle,
                       const void *buffer,
                       size_t length,
                       size_t *written )
{
    const char *pachText = (const char *)buffer;
    size_t write_count = length;
    __dpmi_regs regs;
    unsigned char uchAttr = (unsigned char) fb_ConsoleGetColorAtt();
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

    if( written )
        *written = write_count;

    return TRUE;
}

/*:::::*/
void fb_ConsolePrintBufferEx_BIOS( const void *buffer, size_t len, int mask )
{
    const char *pachText = (const char *) buffer;
    int win_left, win_top, win_cols, win_rows;
    int view_top, view_bottom;
    fb_PrintInfo info;
    fb_ConHooks hooks;

    /* Do we want to correct the Win32 console cursor position? */
    if( (mask & FB_PRINT_FORCE_ADJUST)==0 ) {
        /* No, we can check for the length to avoid unnecessary stuff ... */
        if( len==0 )
            return;
    }

    FB_LOCK();

    fb_ConsoleGetSize( &win_cols, &win_rows );
    fb_ConsoleGetView( &view_top, &view_bottom );
    win_left = win_top = 0;

    hooks.Opaque        = &info;
    hooks.Scroll        = fb_hHookConScroll;
    hooks.Locate        = fb_hHookConLocate;
    hooks.Write         = fb_hHookConWrite ;
    hooks.Border.Left   = win_left;
    hooks.Border.Top    = win_top + view_top - 1;
    hooks.Border.Right  = win_left + win_cols - 1;
    hooks.Border.Bottom = win_top + view_bottom - 1;

    info.hOutput        = stdout;
    info.rWindow.Left   = win_left;
    info.rWindow.Top    = win_top;
    info.rWindow.Right  = win_left + win_cols - 1;
    info.rWindow.Bottom = win_top + win_rows - 1;
    info.fViewSet       = hooks.Border.Top!=info.rWindow.Top
        || hooks.Border.Bottom!=info.rWindow.Bottom;

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
	fb_ConsolePrintBufferProc(buffer, len, mask);
}

/*:::::*/
void fb_ConsolePrintBuffer( const char *buffer, int mask )
{
	fb_ConsolePrintBufferProc(buffer, strlen(buffer), mask);
}
