/* Linux printer driver */

#include "../fb.h"

/* DEV_LPT_INFO->driver_opaque := (FILE *) file_handle */

static char lp_buf[256];

static int exec_lp_cmd( const char *cmd, int test_default )
{
	int have_default = TRUE; // Assume a default printer
	int result = -1;

	FILE *fp = popen( cmd, "r" );
	if( fp ) {
		while( !feof( fp ) ) {
			if( !fgets( lp_buf, 256, fp ) ) {
				if( test_default && have_default && (strlen( lp_buf ) > 2) )
					if( (lp_buf[0] == 'n' || lp_buf[0] == 'N') &&
					    (lp_buf[1] == 'o' || lp_buf[1] == 'O') )
						have_default = FALSE;
			}
		}

		result = pclose( fp ) >> 8;

		if( test_default && !have_default )
			result = -1;
	}

	return result;
}

int fb_PrinterOpen( DEV_LPT_INFO *devInfo, int iPort, const char *pszDeviceRaw )
{
	int result;
	char *filename = NULL;
	FILE *fp;

	DEV_LPT_PROTOCOL *lpt_proto;
	if ( !fb_DevLptParseProtocol( &lpt_proto, pszDeviceRaw, strlen(pszDeviceRaw), TRUE ) )
	{
		if( lpt_proto!=NULL )
			free(lpt_proto);
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
	}

	devInfo->iPort = iPort;

	if( devInfo->iPort==0 ) {
		/* Use spooler */

		/* create a buffer for our commands */
		filename = alloca( strlen(pszDeviceRaw) + 64 );

		/* set destination, if not default */
		if( lpt_proto->name && *lpt_proto->name )	
		{
			/* does printer exist */
			strcpy(filename, "lpstat -v \"");
			strcat(filename, lpt_proto->name);
			strcat(filename, "\" 2>&1 ");	
			if( exec_lp_cmd( filename, FALSE ) != 0 )
			{
				if( lpt_proto!=NULL )
					free(lpt_proto);
				return fb_ErrorSetNum( FB_RTERROR_FILENOTFOUND );
			}

			/* build command for spooler */
			strcpy(filename, "lp ");
			strcat(filename, "-d \"");	
			strcat(filename, lpt_proto->name);
			strcat(filename, "\" ");	
		}
		else
		{
			/* is there a default printer */
			strcpy(filename, "lpstat -d 2>&1");
			if( exec_lp_cmd( filename, TRUE ) != 0 )
			{
				if( lpt_proto!=NULL )
					free(lpt_proto);
				return fb_ErrorSetNum( FB_RTERROR_FILENOTFOUND );
			}
			/* build command for spooler */
			strcpy(filename, "lp ");
		}

		/* set title, if not default */
		if( *lpt_proto->title )
		{
			strcat(filename, "-t \"");	
			strcat(filename, lpt_proto->title);
			strcat(filename, "\"");	
		}
		else
		{
			strcat(filename, "-t \"FreeBASIC document\"");
		}

		/* do not print job id */
		strcat(filename, " -s -");

		{
			char *ptr = filename;
			while ((ptr = strpbrk(ptr, "`&;|>^$\\")) != NULL)
				*ptr = '_';
		}

		/* do not print error messages */
		strcat(filename, " &> /dev/null");

		fp = popen( filename, "w" );
		if(fp == NULL )
		{
			devInfo->driver_opaque = NULL;
			result = fb_ErrorSetNum( FB_RTERROR_FILENOTFOUND );
		}
		else
		{
			devInfo->driver_opaque = fp;
			result = fb_ErrorSetNum( FB_RTERROR_OK );
		}

	} else {
		/* use direct port io */
		filename = alloca( 7 + 11 + 1 );
		sprintf(filename, "/dev/lp%d", (devInfo->iPort-1));
		fp = fopen(filename, "wb");

		if( fp==NULL ) {
			devInfo->driver_opaque = NULL;
			result = fb_ErrorSetNum( FB_RTERROR_FILENOTFOUND );
		} else {
			devInfo->driver_opaque = fp;
			result = fb_ErrorSetNum( FB_RTERROR_OK );
		}

	}

	if( lpt_proto!=NULL )
		free(lpt_proto);

	return result;
}

int fb_PrinterWrite( DEV_LPT_INFO *devInfo, const void *data, size_t length )
{
	FILE *fp = (FILE*)  devInfo->driver_opaque;
	if( fwrite( data, length, 1, fp ) != 1 ) {
		return fb_ErrorSetNum( FB_RTERROR_FILEIO );
	}
	return fb_ErrorSetNum( FB_RTERROR_OK );
}

int fb_PrinterWriteWstr( DEV_LPT_INFO *devInfo, const FB_WCHAR *buffer, size_t chars )
{
	FILE *fp = (FILE *) devInfo->driver_opaque;

	/* !!!FIXME!!! is this ok? */
	ssize_t bytes;
	char *temp = alloca( chars * 4 + 1 );

	fb_WCharToUTF( FB_FILE_ENCOD_UTF8, buffer, chars, temp, &bytes );
	/* add null-term */
	temp[bytes] = '\0';

	if( fwrite( temp, bytes, 1, fp ) != 1 )
		return fb_ErrorSetNum( FB_RTERROR_FILEIO );

	return fb_ErrorSetNum( FB_RTERROR_OK );
}


int fb_PrinterClose( DEV_LPT_INFO *devInfo )
{
	if( devInfo->iPort == 0 )
	{
		/* close spooler */
		int result = ( pclose( (FILE *) devInfo->driver_opaque ) >> 8 );
		devInfo->driver_opaque = NULL;
		if( result )
			return fb_ErrorSetNum( FB_RTERROR_FILEIO );
	}
	else 
	{
		/* close direct port io */
		fclose( (FILE *) devInfo->driver_opaque );
		devInfo->driver_opaque = NULL;
	}

	return fb_ErrorSetNum( FB_RTERROR_OK );
}
