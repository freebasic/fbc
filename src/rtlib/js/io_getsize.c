#include "../fb.h"
#include "fb_private_console.h"

FBCALL void fb_ConsoleGetSize( int *cols, int *rows )
{
	int res = EM_ASM_INT({
        return __fb_rtlib.console.size_get();
    }, NULL);

	if( cols != NULL ) {
		*cols = res & 0xFF;
	}

	if( rows != NULL ) {
		*rows = (res >> 8) & 0xFF;
	}
}
