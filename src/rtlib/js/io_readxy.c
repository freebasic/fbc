/* console SCREEN() function (character/color query) */

#include "../fb.h"
#include "fb_private_console.h"

FBCALL unsigned int fb_ConsoleReadXY( int col, int row, int colorflag )
{
    unsigned int res = 0;

    if( colorflag ) {
        res = EM_ASM_INT({
            __fb_rtlib.console.charAt($0, $1)
        }, col-1, row-1);
    } else {
        res = EM_ASM_INT({
            __fb_rtlib.console.colorAt($0, $1)
        }, col-1, row-1);
	}
	return res;
}
