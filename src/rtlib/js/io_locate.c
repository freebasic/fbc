/* console LOCATE statement */

#include "../fb.h"
#include "fb_private_console.h"

int fb_ConsoleLocate( int row, int col, int cursor )
{
	EM_ASM_ARGS({
        fbrt_term.position_set($0, $1);
    }, row-1, col-1);

	return (col & 0xFF) | ((row & 0xFF) << 8);
}
