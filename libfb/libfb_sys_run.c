/*
 * sys_run.c -- RUN function
 *
 * chng: jan/2005 written [v1ctor]
 *
 */

#include "fb.h"

/*:::::*/
FBCALL int fb_RunEx ( FBSTRING *program, FBSTRING *args )
{
	if( fb_ExecEx( program, args, FALSE ) != -1 )
		fb_End( 0 );

    return -1;
}

/*:::::*/
FBCALL int fb_Run ( FBSTRING *program )
{
	return fb_RunEx( program, NULL );
}
