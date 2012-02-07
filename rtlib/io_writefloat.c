/* write [#] functions */

#include "fb.h"

/*:::::*/
FBCALL void fb_WriteSingle ( int fnum, float val, int mask )
{
	char buffer[8+1+8+1+2];

	fb_hFloat2Str( (double)val, buffer, 7, 0 );

	if( mask & FB_PRINT_BIN_NEWLINE )
    	strcat( buffer, FB_BINARY_NEWLINE );
	else if( mask & FB_PRINT_NEWLINE )
    	strcat( buffer, FB_NEWLINE );
	else
    	strcat( buffer, "," );

	fb_hFilePrintBufferEx( FB_FILE_TO_HANDLE( fnum ), buffer, strlen( buffer ) );

}

/*:::::*/
FBCALL void fb_WriteDouble ( int fnum, double val, int mask )
{
	char buffer[16+1+8+1];

	fb_hFloat2Str( val, buffer, 16, 0 );

	if( mask & FB_PRINT_BIN_NEWLINE )
    	strcat( buffer, FB_BINARY_NEWLINE );
	else if( mask & FB_PRINT_NEWLINE )
    	strcat( buffer, FB_NEWLINE );
	else
    	strcat( buffer, "," );

	fb_hFilePrintBufferEx( FB_FILE_TO_HANDLE( fnum ), buffer, strlen( buffer ) );
}
