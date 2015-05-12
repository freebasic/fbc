/* print # function (formating is done at io_prn) */

#include "fb.h"

/*:::::*/
int fb_hFilePrintBufferWstrEx
	(
		FB_FILE *handle,
		const FB_WCHAR *buffer,
		size_t len
	)
{
    int res;

    fb_DevScrnInit_WriteWstr( );

    if( !FB_HANDLE_USED(handle) )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

    res = fb_FilePutDataEx( handle, 0, buffer, len, TRUE, TRUE, TRUE );

    return res;
}

/*:::::*/
int fb_hFilePrintBufferWstr
	(
		int fnum,
		const FB_WCHAR *buffer
	)
{
    return fb_hFilePrintBufferWstrEx( FB_FILE_TO_HANDLE(fnum),
                                  	  buffer, fb_wstr_Len( buffer ) );
}
