/*
 * con_lineinp - console line input function
 *
 * chng: nov/2004 written [v1ctor]
 *       sep/2005 split into two files, file_lineinp.c and con_lineinp.c
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include "fb.h"

FBCALL
int fb_LineInput( FBSTRING *text, void *dst, int dst_len, int fillrem,
				  int addquestion, int addnewline )
{
    FB_LINEINPUTPROC lineinputproc;

    FB_LOCK();
    lineinputproc = __fb_ctx.hooks.lineinputproc;
    FB_UNLOCK();

    if( lineinputproc )
        return lineinputproc( text, dst, dst_len, fillrem, addquestion, addnewline );
    else
        return fb_ConsoleLineInput( text, dst, dst_len, fillrem, addquestion, addnewline );
}
