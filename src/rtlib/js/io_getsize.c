#include "../fb.h"

FBCALL void fb_ConsoleGetSize( int *cols, int *rows )
{
	*cols = 80;
	*rows = 25;
}
