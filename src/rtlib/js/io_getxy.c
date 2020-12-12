#include "../fb.h"
#include "fb_private_console.h"

FBCALL void fb_ConsoleGetXY( int *col, int *row )
{
	int res = EM_ASM_INT({
        return __fb_rtlib.console.pos_get();
    },NULL);

    if( col != NULL )
        *col = 1+(res & 0xFF);

    if( row != NULL )
        *row = 1+((res >> 8) & 0xFF);
}
