/*
 * io_multikey.c -- FreeBSD console multikey function implementation
 *
 * chng: / written []
 *
 */

#include "fb.h"


/*:::::*/
int fb_ConsoleMultikey(int scancode)
{
	return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
}
