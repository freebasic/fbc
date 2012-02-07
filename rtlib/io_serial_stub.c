/* serial port access stubs */

#include "fb.h"

int fb_SerialOpen( struct _FB_FILE *handle,
                   int iPort, FB_SERIAL_OPTIONS *options,
                   const char *pszDevice, void **ppvHandle )
{
    return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
}

int fb_SerialGetRemaining( struct _FB_FILE *handle, 
                           void *pvHandle, long *pLength )
{
    return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
}

int fb_SerialWrite( struct _FB_FILE *handle, 
                    void *pvHandle, const void *data, size_t length )
{
    return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
}

int fb_SerialRead( struct _FB_FILE *handle, 
                   void *pvHandle, void *data, size_t *pLength )
{
    return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
}

int fb_SerialClose( struct _FB_FILE *handle, 
                    void *pvHandle )
{
    return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
}
