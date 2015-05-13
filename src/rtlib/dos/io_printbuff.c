/* low-level print to console function */

#include "../fb.h"
#include "fb_private_console.h"
#include <unistd.h>
#include <go32.h>
#include <dpmi.h>
#include <sys/farptr.h>

typedef struct _fb_PrintInfo {
    unsigned short usAttr;
} fb_PrintInfo;

static void fb_hHookConScroll_BIOS
	(
		fb_ConHooks *handle,
		int x1, int y1,
		int x2, int y2,
		int rows
	)
{
    fb_ConsoleScroll_BIOS( x1, y1, x2, y2, rows );
    handle->Coord.Y = handle->Border.Bottom;
}

static int fb_hHookConWrite_BIOS
	(
		fb_ConHooks *handle,
		const void *buffer,
		size_t length
	)
{
    fb_PrintInfo *pInfo = (fb_PrintInfo*) handle->Opaque;
    const char *pachText = (const char *)buffer;
    __dpmi_regs regs;
    unsigned char uchAttr = (unsigned char) pInfo->usAttr;
    int pos = (handle->Coord.Y << 8) | handle->Coord.X;

    while( length-- ) {
        fb_hSetCursorPos( pos, -1 );
        ++pos;
        regs.h.ah = 0x09;
        regs.h.al = *pachText++;
        regs.h.bh = __fb_con.active;
        regs.h.bl = uchAttr;
        regs.x.cx = 1;
        __dpmi_int(0x10, &regs);

    }

    return TRUE;
}

static int fb_hHookConWrite_MEM
	(
		fb_ConHooks *handle,
		const void *buffer,
		size_t length
	)
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
                _dos_ds, __fb_con.phys_addr + (__fb_con.w << 1) * tmp_y + (tmp_x << 1),
                length );

    return TRUE;
}

unsigned long fb_hGetPageAddr( int pg, int cols, int rows )
{
	unsigned long physAddr;
    unsigned char mode = _farpeekb( _dos_ds, 0x465 );

    if( mode & 0x02 )
		return 0;

	if( mode & 0x04 )
    	physAddr = 0xB0000;
	else
    	physAddr = 0xB8000;

	if( pg != 0 ) {
		if( (cols == 0) || (rows == 0) )
			fb_ConsoleGetSize( &cols, &rows );

		int pageSize = cols * rows * (sizeof( char ) * 2);
		if( rows == 25 )
			pageSize += 96;

		physAddr += pg * pageSize;
	}

	return physAddr;
}

static void fb_ConsolePrintBufferEx_SCRN
	(
		const void *buffer,
		size_t len,
		int mask
	)
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

    __fb_con.w = win_cols;
    __fb_con.h = win_rows;
    __fb_con.phys_addr = fb_hGetPageAddr( __fb_con.active, win_cols, win_rows );

    hooks.Opaque        = &info;
    if( __fb_con.phys_addr ) {
        hooks.Scroll = fb_hHookConScroll_BIOS;
        hooks.Write  = fb_hHookConWrite_MEM;
    } else {
        hooks.Scroll = fb_hHookConScroll_BIOS;
        hooks.Write  = fb_hHookConWrite_BIOS;
    }
    hooks.Border.Left   = win_left;
    hooks.Border.Top    = win_top + view_top - 1;
    hooks.Border.Right  = win_left + win_cols - 1;
    hooks.Border.Bottom = win_top + view_bottom - 1;

    info.usAttr = (unsigned short) (unsigned char) fb_ConsoleGetColorAtt();

    {
        fb_ConsoleGetXY_BIOS( &hooks.Coord.X, &hooks.Coord.Y );

        if( __fb_con.scrollWasOff ) {
            __fb_con.scrollWasOff = FALSE;
            ++hooks.Coord.Y;
            hooks.Coord.X = hooks.Border.Left;
            fb_hConCheckScroll( &hooks );
        }

        fb_ConPrintTTY( &hooks, pachText, len, TRUE );

        if( hooks.Coord.X != hooks.Border.Left
            || hooks.Coord.Y != (hooks.Border.Bottom+1) )
        {
            fb_hConCheckScroll( &hooks );
        } else {
            __fb_con.scrollWasOff = TRUE;
            hooks.Coord.X = hooks.Border.Right;
            hooks.Coord.Y = hooks.Border.Bottom;
        }
        fb_ConsoleLocate_BIOS( hooks.Coord.Y, hooks.Coord.X, -1 );
    }

    FB_UNLOCK();
}

static void fb_ConsolePrintBufferEx_STDIO
	(
		const void *buffer,
		size_t len,
		int mask
	)
{
    fwrite(buffer, len, 1, stdout);
    fflush(stdout);
}

void fb_ConsolePrintBufferEx( const void *buffer, size_t len, int mask )
{
	static void (*fn)(const void *buffer, size_t len, int mask) = NULL;

	if( fn == NULL ) {
		/* use cprintf() if STDOUT is the console;
       	   otherwise (with shell I/O redirection) use printf() */
    	if( isatty( fileno( stdout ) ) )
        	fn = fb_ConsolePrintBufferEx_SCRN;
    	else
        	fn = fb_ConsolePrintBufferEx_STDIO;
    }

    fn( buffer, len, mask );
}

void fb_ConsolePrintBuffer( const char *buffer, int mask )
{
	fb_ConsolePrintBufferEx( buffer, strlen( buffer ), mask );
}
