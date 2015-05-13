/* console line input function */

#include "fb.h"

FBCALL int fb_LineInputWstr
	(
		const FB_WCHAR *text,
		FB_WCHAR *dst,
		ssize_t max_chars,
		int addquestion,
		int addnewline
	)
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
