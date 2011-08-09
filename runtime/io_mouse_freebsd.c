/* FreeBSD console mouse functions implementation */

#include "fb.h"

/*:::::*/
int fb_ConsoleGetMouse(int *x, int *y, int *z, int *buttons, int *clip)
{
	return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
}


/*:::::*/
int fb_ConsoleSetMouse(int x, int y, int cursor, int clip)
{
	return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
}
