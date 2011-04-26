/*
 * sys_shell.c -- SHELL command for Win32
 *
 * chng: apr/2005 written [lillo]
 *
 */

#include "fb.h"

/*:::::*/
FBCALL int fb_Shell ( FBSTRING *program )
{
	XLaunchXBE(program->data);
	
	return fb_ErrorSetNum(FB_RTERROR_FILENOTFOUND);
}
