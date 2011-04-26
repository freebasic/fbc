/*
 * io_printusg - print using function
 *
 * chng: nov/2004 written [v1ctor]
 *
 */

#include <stdlib.h>
#include <string.h>
#include "fb.h"

int LPrintInit(void);
FBCALL int fb_PrintUsingInit( FBSTRING *fmtstr );

/*:::::*/
FBCALL int fb_LPrintUsingInit( FBSTRING *fmtstr )
{
    int res = LPrintInit();
    if( res!=FB_RTERROR_OK )
        return res;
	return fb_PrintUsingInit( fmtstr );
}

