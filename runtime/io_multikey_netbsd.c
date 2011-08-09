/* NetBSD console multikey function implementation */

#include "fb.h"

/*:::::*/
int fb_ConsoleMultikey(int scancode)
{
	return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
}
