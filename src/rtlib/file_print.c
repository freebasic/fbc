/* print # function (formating is done at io_prn) */

#include "fb.h"

/*:::::*/
int fb_hFilePrintBufferEx( FB_FILE *handle, const void *buffer, size_t len )
{
    fb_DevScrnInit_Write( );
	return fb_FilePutDataEx( handle, 0, buffer, len, TRUE, TRUE, FALSE );
}

/*:::::*/
int fb_hFilePrintBuffer( int fnum, const char *buffer )
{
    return fb_hFilePrintBufferEx( FB_FILE_TO_HANDLE(fnum),
                                  buffer, strlen( buffer ) );
}
