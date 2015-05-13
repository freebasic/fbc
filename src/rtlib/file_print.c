/* print # function (formating is done at io_prn) */

#include "fb.h"

/*:::::*/
int fb_hFilePrintBufferEx( FB_FILE *handle, const void *buffer, size_t len )
{
    int res;

    fb_DevScrnInit_Write( );

    if( !FB_HANDLE_USED(handle) )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

    res = fb_FilePutDataEx( handle, 0, buffer, len, TRUE, TRUE, FALSE );

    return res;
}

/*:::::*/
int fb_hFilePrintBuffer( int fnum, const char *buffer )
{
    return fb_hFilePrintBufferEx( FB_FILE_TO_HANDLE(fnum),
                                  buffer, strlen( buffer ) );
}
