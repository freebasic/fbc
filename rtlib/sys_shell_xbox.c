/* SHELL command for Xbox */

#include "fb.h"

/*:::::*/
FBCALL int fb_Shell ( FBSTRING *program )
{
	XLaunchXBE(program->data);
	
	return fb_ErrorSetNum(FB_RTERROR_FILENOTFOUND);
}
