/* console 'screen , pg, pg' function */

#include "../fb.h"
#include "fb_private_console.h"
#include <dpmi.h>

int fb_ConsolePageSet ( int active, int visible )
{
	int res = __fb_con.active | (__fb_con.visible << 8);

	if( active >= 0 )
	{
		__fb_con.active = active;
	}

	if( visible >= 0 )
	{
		if( __fb_con.visible != visible )
		{
        	__dpmi_regs regs;
        	regs.h.ah = 0x05;
        	regs.h.al = visible;
        	__dpmi_int(0x10, &regs);

			__fb_con.visible = visible;
		}
	}

	return res;
}
