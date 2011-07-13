/*
 * sys_chain.c -- chain function
 *
 * chng: jan/2005 written [v1ctor]
 *
 */

#include "fb.h"

/*:::::*/
FBCALL int fb_Chain ( FBSTRING *program )
{
    return fb_ExecEx( program, NULL, TRUE );
}
