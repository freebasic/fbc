/* console line input function for Windows */

#include <stdio.h>
#include <stdlib.h>
#include "fb.h"

/*:::::*/
char *fb_ConsoleReadStr( char *buffer, int len )
{
    char *res;
    fb_hRestoreConsoleWindow( );
    FB_CON_CORRECT_POSITION();
    fb_hConsolePutBackEvents( );
    res = fgets( buffer, len, stdin );
    fb_hUpdateConsoleWindow( );
    return res;
}

