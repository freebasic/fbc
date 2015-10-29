/* dos printer driver */

#include "../fb.h"

/* DEV_LPT_INFO->driver_opaque := (FILE *) file_handle */

int fb_PrinterOpen( DEV_LPT_INFO *devInfo, int iPort, const char *pszDevice )
{
    int result;
    char filename[64];
    FILE *fp;
		
    if( iPort==0 ) {
				/* "LPT:" selects default "LPT1:" */
				devInfo->iPort = 1;
		} else {
				devInfo->iPort = iPort;
		}

		sprintf(filename, "LPT%d", devInfo->iPort);
		fp = fopen(filename, "wb");

		devInfo->driver_opaque = fp;

		if( fp==NULL ) {
				result = fb_ErrorSetNum( FB_RTERROR_FILENOTFOUND );
		} else {
				result = fb_ErrorSetNum( FB_RTERROR_OK );
		}

    return result;
}

int fb_PrinterWrite( DEV_LPT_INFO *devInfo, const void *data, size_t length )
{
    FILE *fp = (FILE*) devInfo->driver_opaque;
    if( fwrite( data, length, 1, fp ) != 1 ) {
        return fb_ErrorSetNum( FB_RTERROR_FILEIO );
    }
    return fb_ErrorSetNum( FB_RTERROR_OK );
}

int fb_PrinterWriteWstr( DEV_LPT_INFO *devInfo, const FB_WCHAR *data, size_t length )
{
    /* !!!FIXME!!! no support for unicode output */

    char *temp = alloca( length + 1 );

    if( length > 0 )
        fb_wstr_ConvToA( temp, length, data );
    else
    	*temp = '\0';

    return fb_PrinterWrite( devInfo, (void *)temp, length );
}

int fb_PrinterClose( DEV_LPT_INFO *devInfo )
{
    FILE *fp = (FILE*) devInfo->driver_opaque;

    fclose(fp);
		devInfo->driver_opaque = NULL;

    return fb_ErrorSetNum( FB_RTERROR_OK );
}
