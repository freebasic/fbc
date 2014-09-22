/* console SCREEN() function (character/color query) */

#include "../fb.h"
#include "fb_private_console.h"
#include <go32.h>
#include <dpmi.h>
#include <sys/farptr.h>

unsigned int fb_ConsoleReadXY_BIOS( int col, int row, int colorflag )
{
    unsigned short usPosOld = fb_hSetCursorPos( col, row );

    __dpmi_regs regs;
    regs.x.ax = 0x0800;
    regs.x.bx = __fb_con.active;
    __dpmi_int(0x10, &regs);

    fb_hSetCursorPos( usPosOld, -1 );

    if( colorflag )
        return (unsigned int)regs.h.ah;
    else
    	return (unsigned int)regs.h.al;
}

FBCALL unsigned int fb_ConsoleReadXY( int col, int row, int colorflag )
{
    return fb_ConsoleReadXY_BIOS( col - 1, row - 1, colorflag );
}
