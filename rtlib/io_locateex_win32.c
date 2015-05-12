/* locate (console, no gfx) function for Windows */

#include "fb.h"
#include "fb_private_console.h"

/*:::::*/
void fb_ConsoleLocateRawEx( HANDLE hConsole, int row, int col, int cursor )
{
	COORD c;

    if( col < 0 )
        col = fb_ConsoleGetRawXEx( hConsole );
    if( row < 0 )
        row = fb_ConsoleGetRawYEx( hConsole );

    c.X = (SHORT) col;
    c.Y = (SHORT) row;

  	if( cursor >= 0 ) {
        CONSOLE_CURSOR_INFO info;
        GetConsoleCursorInfo( __fb_out_handle, &info );
  		info.bVisible = ( cursor ? TRUE : FALSE );
  		SetConsoleCursorInfo( hConsole, &info );
  	}

    __fb_con.scrollWasOff = FALSE;
    SetConsoleCursorPosition( hConsole, c );
}

/*:::::*/
FBCALL void fb_ConsoleLocateRaw( int row, int col, int cursor )
{
	fb_ConsoleLocateRawEx( __fb_out_handle, row, col, cursor );
}


