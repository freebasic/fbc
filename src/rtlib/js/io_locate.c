/* console LOCATE statement */

#include "../fb.h"
#include "fb_private_console.h"

int fb_ConsoleLocate( int row, int col, int cursor )
{
	if( row > 0 || col > 0 )
    {
        EM_ASM_ARGS({
            __fb_rtlib.console.pos_set($0, $1);
        }, row-1, col-1);
    }

    if( cursor != -1 )
    {
        if( cursor == 0 )
        {
            EM_ASM({
                __fb_rtlib.console.cursor_hide();
            });
        }
        else
        {
            EM_ASM({
                __fb_rtlib.console.cursor_show();
            });
        }
    }

	return (col & 0xFF) | ((row & 0xFF) << 8);
}
