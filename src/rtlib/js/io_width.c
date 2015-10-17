/* console width() function */

#include "../fb.h"
#include "fb_private_console.h"

int fb_ConsoleWidth( int cols, int rows )
{
	if( cols < 40 )
        cols = 40;

    if( rows < 10 )
        rows = 10;

	EM_ASM_ARGS({
        __fb_rtlib.console.size_set($0, $1);
    },cols, rows);

	return (rows << 16) | cols;
}
