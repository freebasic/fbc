/* printer access stubs */

#include "fb.h"

int fb_PrinterOpen( struct _DEV_LPT_INFO *devInfo, int iPort, const char *pszDevice )
{
	return fb_ErrorSetNum( FB_RTERROR_FILENOTFOUND );
}

int fb_PrinterWrite( struct _DEV_LPT_INFO *devInfo, const void *data, size_t length )
{
	return fb_ErrorSetNum( FB_RTERROR_FILEIO );
}

int fb_PrinterWriteWstr( struct _DEV_LPT_INFO *devInfo, const FB_WCHAR *data, size_t length )
{
	return fb_ErrorSetNum( FB_RTERROR_FILEIO );
}

int fb_PrinterClose( struct _DEV_LPT_INFO *devInfo )
{
	return fb_ErrorSetNum( FB_RTERROR_FILEIO );
}
