/*
 * con_lineinp - console line input function
 *
 * chng: nov/2004 written [v1ctor]
 *       sep/2005 split into two files, file_lineinp.c and con_lineinp.c
 *
 */

#include "fb.h"

/*:::::*/
FBCALL int fb_LineInputWstr( const FB_WCHAR *text, FB_WCHAR *dst, int max_chars,
				  			 int addquestion, int addnewline )
{
    FB_LINEINPUTWPROC fn;

    FB_LOCK();
    fn = __fb_ctx.hooks.lineinputwproc;
    FB_UNLOCK();

    if( fn )
        return fn( text, dst, max_chars, addquestion, addnewline );
    else
        return fb_ConsoleLineInputWstr( text, dst, max_chars, addquestion, addnewline );
}
