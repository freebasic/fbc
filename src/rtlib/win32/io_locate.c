/* console LOCATE statement */

#include "../fb.h"
#include "fb_private_console.h"

int fb_ConsoleLocate( int row, int col, int cursor )
{
    int ret_val;
    CONSOLE_CURSOR_INFO info;

    if( col < 1 )
        col = fb_ConsoleGetX();
    if( row < 1 )
        row = fb_ConsoleGetY();

    GetConsoleCursorInfo( __fb_out_handle, &info );
    ret_val =
        (col & 0xFF) | ((row & 0xFF) << 8) | (info.bVisible ? 0x10000 : 0);

    fb_hConvertToConsole( &col, &row, NULL, NULL );

    fb_ConsoleLocateRawEx( __fb_out_handle, row, col, cursor );

    return ret_val;
}

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

FBCALL void fb_ConsoleLocateRaw( int row, int col, int cursor )
{
	fb_ConsoleLocateRawEx( __fb_out_handle, row, col, cursor );
}
