/* QB compatible OPEN */

#include "fb.h"

FBCALL int fb_FileOpenQB
	(
		FBSTRING *str,
		unsigned int mode,
		unsigned int access,
		unsigned int lock,
		int fnum,
		int len
	)
{
	if( !FB_FILE_INDEX_VALID( fnum ) )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

	ssize_t str_len = FB_STRSIZE( str );

	if( !str_len || (str->data == NULL) )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );		
		
	/* serial? */
	if( (str_len > 3) && (strncasecmp( str->data, "COM", 3 ) == 0) )
	{
		ssize_t i = 3;
		while( (i < str_len) && (str->data[i] >= '0') && (str->data[i] <= '9' ) )
			++i;

		if( str->data[i] == ':' )
		{
			return fb_FileOpenVfsEx( FB_FILE_TO_HANDLE(fnum),
									 str,
									 mode,
									 access,
									 lock,
									 len,
									 FB_FILE_ENCOD_ASCII,
									 fb_DevComOpen );
		}
	}
	/* parallel? */
	else if( (str_len > 3) && (strncasecmp( str->data, "LPT", 3 ) == 0) )
	{
		ssize_t i = 3;
		while( (i < str_len) && (str->data[i] >= '0') && (str->data[i] <= '9' ) )
			++i;

		if( str->data[i] == ':' )
		{
			return fb_FileOpenVfsEx( FB_FILE_TO_HANDLE(fnum),
									 str,
									 mode,
									 access,
									 lock,
									 len,
									 FB_FILE_ENCOD_ASCII,
									 fb_DevLptOpen );
		}
	}
	/* default printer? */
	else if( (str_len == 4) && (strcasecmp( str->data, "PRN:" ) == 0) )
	{
		return fb_FileOpenVfsEx( FB_FILE_TO_HANDLE(fnum),
								 str,
								 mode,
								 access,
								 lock,
								 len,
								 FB_FILE_ENCOD_ASCII,
								 fb_DevLptOpen );
	}
	/* console? */
	else if( (str_len == 5) && (strcasecmp( str->data, "CONS:" ) == 0) )
	{
		return fb_FileOpenVfsEx( FB_FILE_TO_HANDLE(fnum),
								 str,
								 mode,
								 access,
								 lock,
								 len,
								 FB_FILE_ENCOD_ASCII,
								 fb_DevConsOpen );

	}
	/* screen? */
	else if( (str_len == 5) && (strcasecmp( str->data, "SCRN:" ) == 0) )
	{
		fb_DevScrnInit( );
	
		return fb_FileOpenVfsEx( FB_FILE_TO_HANDLE(fnum),
								 str,
								 mode,
								 access,
								 lock,
								 len,
								 FB_FILE_ENCOD_ASCII,
								 fb_DevScrnOpen );
	}
	/* pipe? */
	else if( (str_len >= 5) && (strncasecmp( str->data, "PIPE:", 5 ) == 0) )
	{
		return fb_FileOpenVfsEx( FB_FILE_TO_HANDLE(fnum),
								 fb_StrMid( str, 6, str_len - 5 ),
								 mode,
								 access,
								 lock,
								 len,
								 FB_FILE_ENCOD_ASCII,
								 fb_DevPipeOpen );
	}
	
	/* ordinary file */
	return fb_FileOpenEx( FB_FILE_TO_HANDLE(fnum), str, mode, access, lock, len );
}
