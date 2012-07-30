/* console scrolling for when VIEW is used */

#include "../fb.h"
#include "fb_private_console.h"
#include <dpmi.h>
#include <go32.h>

static void hFillRect( int x1, int y1, int x2, int y2 )
{
	int cols, rows;
	fb_ConsoleGetSize( &cols, &rows );

	int chars = (x2 - x1 + 1) * (y2 - y1 + 1);

	unsigned long physAddr = fb_hGetPageAddr( __fb_con.active, cols, rows );
	if( physAddr == 0 )
	{
    	/* change the cursor pos (faster than using LOCATE) */
    	unsigned short oldPos = fb_hSetCursorPos( x1, y1 );

		__dpmi_regs regs;
		regs.x.ax = 0x0920;
		regs.h.bh = __fb_con.active;
		regs.h.bl = fb_ConsoleGetColorAtt();
		regs.x.cx = chars;
		__dpmi_int(0x10, &regs);

		/* restore old pos */
		fb_hSetCursorPos( oldPos, -1 );
	}
	else
	{
    	unsigned short attr = fb_ConsoleGetColorAtt() << 8;
    	if( (x2 - x1 + 1) == cols )
    	{
    		unsigned short *buffer = alloca( chars * sizeof( short ) );
    		int i;
    		for( i = 0, buffer += chars; i < chars; ++i )
        		*--buffer = attr | 0x20;

    		_movedataw( _my_ds(), (int)buffer,
                		_dos_ds, physAddr + (cols << 1) * y1,
                		chars );
		}
		else
		{
    		chars = x2 - x1 + 1;
    		unsigned short *buffer = alloca( chars * sizeof( short ) );
    		int i;
    		for( i = 0, buffer += chars; i < chars; ++i )
        		*--buffer = attr | 0x20;

    		for( i = y1; i < y2; i++ )
    			_movedataw( _my_ds(), (int)buffer,
                			_dos_ds, physAddr + (cols << 1) * i + (x1 << 1),
                			chars );
		}
    }
}

static void hMoveRect( int x1, int y1, int x2, int y2, int nrows )
{
	int cols, rows;
	fb_ConsoleGetSize( &cols, &rows );

	int chars = (x2 - x1 + 1) * (y2 - y1 + 1 - nrows);

	unsigned long physAddr = fb_hGetPageAddr( __fb_con.active, cols, rows );
	if( physAddr == 0 )
	{
		/* !!!WRITEME!!!*/
	}
	else
	{
    	if( (x2 - x1 + 1) == cols )
    	{
    		_movedataw( _dos_ds, physAddr + (cols << 1) * (y1+nrows),
                		_dos_ds, physAddr + (cols << 1) * y1,
                		chars );
		}
		else
		{
    		chars = x2 - x1 + 1;
    		int i;
    		for( i = y1; i < y2 - nrows; i++ )
    			_movedataw( _dos_ds, physAddr + (cols << 1) * (i+1) + (x1 << 1),
                			_dos_ds, physAddr + (cols << 1) * i + (x1 << 1),
                			chars );
        }
	}

}

void fb_ConsoleScroll_BIOS( int x1, int y1, int x2, int y2, int nrows )
{
    __dpmi_regs regs;

    /* stupid BIOS can't scroll a specific page */
	if( __fb_con.active != __fb_con.visible )
	{
		if( nrows == 0 )
		{
			hFillRect( x1, y1, x2, y2 );
		}
		else
		{
			hMoveRect( x1, y1, x2, y2, nrows );
			hFillRect( x1, y2-(nrows-1), x2, y2 );
		}

		return;
	}

    regs.h.bl = 0;
    regs.h.bh = (unsigned char) fb_ConsoleGetColorAtt();
    regs.h.cl = (unsigned char) x1;
    regs.h.ch = (unsigned char) y1;
    regs.h.dl = (unsigned char) x2;
    regs.h.dh = (unsigned char) y2;

    if( nrows >= 0 ) {
        regs.x.ax = (unsigned short) (0x0600 + nrows);
    } else {
        regs.x.ax = (unsigned short) (0x0700 + -nrows);
    }
    __dpmi_int(0x10, &regs);
}

void fb_ConsoleScrollEx( int x1, int y1, int x2, int y2, int nrows )
{
    int rows;

	if( nrows == 0 )
        return;

	fb_ConsoleGetSize( NULL, &rows );

    if( nrows <= -rows || nrows >= rows )
        nrows = 0;

    fb_ConsoleScroll_BIOS( x1-1, y1-1, x2-1, y2-1, nrows );

#if 0
    if( nrows > 0 ) {
        fb_ConsoleLocate_BIOS( y2 - 1 - nrows, x1, -1 );
    } else if( nrows < 0 ) {
        fb_ConsoleLocate_BIOS( y1 - 1 - nrows, x1, -1 );
    } else {
        fb_ConsoleLocate_BIOS( y1 - 1, x1 - 1, -1 );
    }
#endif
}

void fb_ConsoleScroll( int nrows )
{
	int toprow, botrow;
    int cols;

	if( nrows == 0 )
        return;

	fb_ConsoleGetSize( &cols, NULL );
    fb_ConsoleGetView( &toprow, &botrow );

    return fb_ConsoleScrollEx( 1, toprow, cols, botrow, nrows );
}
