/* print [#] functions */

#include "fb.h"

/*:::::*/
FBCALL void fb_LPrintWstr
	(
		int fnum,
		const FB_WCHAR *s,
		int mask
	)
{
    fb_LPrintInit();

    fb_PrintWstrEx( FB_FILE_TO_HANDLE(fnum),
                    s,
                    FB_PRINT_CONVERT_BIN_NEWLINE(mask) );
}
