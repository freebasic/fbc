/* write [#] functions */

#include "fb.h"

static void hWriteStrEx( FB_FILE *handle, const char *s, size_t len, int mask )
{
    const char *buff;
	ssize_t bufflen;

    /* close quote + new-line or comma */
    if( mask & FB_PRINT_BIN_NEWLINE )
    {
		buff = "\"" FB_BINARY_NEWLINE;
		bufflen = strlen( "\"" FB_BINARY_NEWLINE );
	}
    else if( mask & FB_PRINT_NEWLINE )
    {
		buff = "\"" FB_NEWLINE;
		bufflen = strlen( "\"" FB_NEWLINE );
	}
    else
    {
		buff = "\",";
		bufflen = 2;
	}

    FB_LOCK( );

    /* open quote */
    fb_hFilePrintBufferEx( handle, "\"", 1 );

    if( len != 0 )
        FB_PRINT_EX( handle, s, len, 0 );

    fb_hFilePrintBufferEx( handle, buff, bufflen );

    FB_UNLOCK( );
}

FBCALL void fb_WriteString ( int fnum, FBSTRING *s, int mask )
{
	FB_FILE *handle = FB_FILE_TO_HANDLE( fnum );

	if( (s != NULL) && (s->data != NULL) )
		hWriteStrEx( handle, s->data, FB_STRSIZE(s), mask );
	else
	{
		if( mask & FB_PRINT_BIN_NEWLINE )
			fb_hFilePrintBufferEx( handle, "\"\"" FB_BINARY_NEWLINE, 1+1+sizeof(FB_BINARY_NEWLINE)-1 );
		else if( mask & FB_PRINT_NEWLINE )
			fb_hFilePrintBufferEx( handle, "\"\"" FB_NEWLINE, 1+1+sizeof(FB_NEWLINE)-1 );
		else
			fb_hFilePrintBufferEx( handle, "\"\",", 1+1+1 );
	}

	/* del if temp */
	fb_hStrDelTemp( s );
}

FBCALL void fb_WriteFixString ( int fnum, char *s, int mask )
{
	FB_FILE *handle = FB_FILE_TO_HANDLE( fnum );

	if( s != NULL )
		hWriteStrEx( handle, s, strlen( s ), mask );
	else
	{
		if( mask & FB_PRINT_BIN_NEWLINE )
			fb_hFilePrintBufferEx( handle, "\"\"" FB_BINARY_NEWLINE, 1+1+sizeof(FB_BINARY_NEWLINE)-1 );
		else if( mask & FB_PRINT_NEWLINE )
			fb_hFilePrintBufferEx( handle, "\"\"" FB_NEWLINE, 1+1+sizeof(FB_NEWLINE)-1 );
		else
			fb_hFilePrintBufferEx( handle, "\"\",", 1+1+1 );
	}
}
