/* write [#] functions */

#include "fb.h"

/*:::::*/
FBCALL void fb_WriteVoid ( int fnum, int mask )
{
    const char *buffer;

    if( mask & FB_PRINT_NEWLINE )
    	buffer = FB_NEWLINE;

    else if( mask & FB_PRINT_PAD )
    	buffer = "\t";

    else
    	buffer = NULL;

    if( buffer != NULL )
        FB_PRINT(fnum, buffer, mask);
}
