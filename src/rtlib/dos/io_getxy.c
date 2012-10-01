#include "../fb.h"
#include "fb_private_console.h"
#include <go32.h>
#include <dpmi.h>
#include <sys/farptr.h>

void fb_ConsoleGetXY_BIOS( int *col, int *row )
{
#if 0
    __dpmi_regs regs;
    regs.x.ax = 0x0300;
    regs.x.bx = __fb_con.active;
    __dpmi_int(0x10, &regs);
    if( col!=NULL )
        *col = regs.h.dl;
    if( row!=NULL )
        *row = regs.h.dh;
#else
    unsigned short usPos = _farpeekw( _dos_ds, 0x450 + __fb_con.active * sizeof( short ) );
    if( col )
        *col = usPos & 0xFF;
    if( row )
        *row = (usPos >> 8) & 0xFF;
#endif
}

FBCALL void fb_ConsoleGetXY( int *col, int *row )
{
    fb_ConsoleGetXY_BIOS( col, row );
    if( col )
        ++*col;
    if( row )
        ++*row;
}
