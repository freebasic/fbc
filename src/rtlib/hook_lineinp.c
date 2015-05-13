/* console line input function */

#include "fb.h"

FBCALL int fb_LineInput
	(
		FBSTRING *text,
		void *dst,
		ssize_t dst_len,
		int fillrem,
		int addquestion,
		int addnewline
	)
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
