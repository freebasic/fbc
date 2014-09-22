/* console SCREEN() function (character/color query) */

#include "../fb.h"
#include "fb_private_console.h"

FBCALL unsigned int fb_ConsoleReadXY( int col, int row, int colorflag )
{
    TCHAR character;
    WORD attribute;
    DWORD res;
    COORD coord;

    fb_hConvertToConsole( &col, &row, NULL, NULL );

    coord.X = (SHORT) col;
    coord.Y = (SHORT) row;

    if( colorflag ) {
        ReadConsoleOutputAttribute( __fb_out_handle, &attribute, 1, coord, &res);
        return ((unsigned int)attribute) & 0xfffful;
    }
    else {
    	ReadConsoleOutputCharacter( __fb_out_handle, &character, 1, coord, &res);
    	return ((unsigned int)character) & (sizeof(TCHAR) == 1? 0xfful : 0xfffful);
    }
}
