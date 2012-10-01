#include "../fb.h"
#include "fb_private_console.h"

FBCALL void fb_ConsoleGetSize( int *cols, int *rows )
{
	if (cols) {
		if (__fb_con.inited)
			*cols = __fb_con.w;
		else
			*cols = 80;
	}

    if (rows) {
		if (__fb_con.inited)
			*rows = __fb_con.h;
		else
			*rows = 24;
    }
}
