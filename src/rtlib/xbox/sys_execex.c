#include "../fb.h"

FBCALL int fb_ExecEx( FBSTRING *program, FBSTRING *args, int do_fork )
{
	XLaunchXBE(program->data);
	return fb_ErrorSetNum(FB_RTERROR_FILENOTFOUND);
}
