/* serial port access stubs */

#include "../fb.h"

int fb_SerialOpen
	(
		FB_FILE *handle,
		int iPort,
		FB_SERIAL_OPTIONS *options,
		const char *pszDevice,
		void **ppvHandle
	)
{
    return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
}

int fb_SerialGetRemaining( FB_FILE *handle, void *pvHandle, fb_off_t *pLength )
{
    return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
}

int fb_SerialWrite( FB_FILE *handle, void *pvHandle, const void *data, size_t length )
{
    return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
}

int fb_SerialRead( FB_FILE *handle, void *pvHandle, void *data, size_t *pLength )
{
    return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
}

int fb_SerialClose( FB_FILE *handle, void *pvHandle )
{
    return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
}
