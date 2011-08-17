/* print [#] functions */

#include <stdlib.h>
#include "fb.h"

int LPrintInit(void);

/*:::::*/
FBCALL void fb_LPrintWstr
	(
		int fnum,
		const FB_WCHAR *s,
		int mask
	)
{
    LPrintInit( );

    fb_PrintWstrEx( FB_FILE_TO_HANDLE(fnum),
                    s,
                    FB_PRINT_CONVERT_BIN_NEWLINE(mask) );
}
