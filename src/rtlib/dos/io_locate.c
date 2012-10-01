/* console LOCATE statement */

#include "../fb.h"
#include "fb_private_console.h"
#include <go32.h>
#include <dpmi.h>
#include <sys/farptr.h>

/* Raw DOS console cursor positioning function, faster than console LOCATE */
unsigned short fb_hSetCursorPos( int col, int row )
{
	unsigned long addr = 0x450 + __fb_con.active * sizeof( short );

	if( row >= 0 ) {
		unsigned short old = _farpeekw( _dos_ds, addr );
		_farpokew( _dos_ds, addr, (row << 8) | col );
		return old;
	} else {
		_farpokew( _dos_ds, addr, col );
		return 0;
	}
}

int fb_ConsoleLocate_BIOS( int row, int col, int cursor )
{
    __dpmi_regs regs;
    int x, y;
    int shape_visible;
    unsigned short usShapePos, usShapeSize;

    usShapePos = _farpeekw( _dos_ds, 0x450 + __fb_con.active * sizeof( short ) );
    usShapeSize = _farpeekw( _dos_ds, 0x460 );
    shape_visible = (usShapeSize & 0xC000)==0x0000;

    if( col >= 0 )
        x = col;
    else
        x = usShapePos & 0xFF;

    if( row >= 0 )
        y = row;
    else
        y = (usShapePos >> 8) & 0xFF;

    /* !!!FIXME!!! is this really needed? */
    regs.x.ax = 0x0200;
    regs.x.bx = __fb_con.active;
    regs.h.dh = (unsigned char) y;
    regs.h.dl = (unsigned char) x;
    __dpmi_int(0x10, &regs);

    _farpokew( _dos_ds, 0x450 + __fb_con.active * sizeof( short ), (y << 8) | x );

    if( cursor >= 0)
    {
        int shape_start, shape_end;

        shape_start = (usShapeSize >> 8) & 0x1F;
        shape_end = usShapeSize & 0x1F;
        shape_visible = cursor!=0;

        regs.x.ax = 0x0100;
        regs.h.ch = (unsigned char) (shape_start + (shape_visible ? 0x00 : 0x20));
        regs.h.cl = (unsigned char) shape_end;
        __dpmi_int(0x10, &regs);
    }

    return ( (x & 0xFF) | ((y & 0xFF) << 8) | (shape_visible ? 0x10000 : 0) );
}

int fb_ConsoleLocate( int row, int col, int cursor )
{
    int result = fb_ConsoleLocate_BIOS( row-1, col-1, cursor );
    __fb_con.scrollWasOff = FALSE;
    return result + 0x0101;
}
