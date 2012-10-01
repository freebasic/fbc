/* console COLOR statement */

#include "../fb.h"
#include "fb_private_console.h"

static int colorlut[16] = { FB_COLOR_BLACK, FB_COLOR_BLUE,
					 		FB_COLOR_GREEN, FB_COLOR_CYAN,
					 		FB_COLOR_RED, FB_COLOR_MAGENTA,
					 		FB_COLOR_BROWN, FB_COLOR_WHITE,
					 		FB_COLOR_GREY, FB_COLOR_LBLUE,
					 		FB_COLOR_LGREEN, FB_COLOR_LCYAN,
					 		FB_COLOR_LRED, FB_COLOR_LMAGENTA,
					 		FB_COLOR_YELLOW, FB_COLOR_BWHITE };

static int last_bc = FB_COLOR_BLACK, last_fc = FB_COLOR_WHITE;

void fb_ConsoleColorEx( HANDLE hConsole, int fc, int bc )
{
    int last_attr = fb_ConsoleGetColorAttEx( hConsole );
    int last_bc = (last_attr >> 4) & 0xF, last_fc = (last_attr & 0xF);

    if( fc >= 0 ) {
        fc = colorlut[fc & 15];
    } else {
        fc = last_fc;
    }

    if( bc >= 0 ) {
        bc = colorlut[bc & 15];
    } else {
        bc = last_bc;
    }

    SetConsoleTextAttribute( hConsole, fc + (bc << 4) );
}

int fb_ConsoleColor( int fc, int bc, int flags )
{
    int cur = last_fc | (last_bc << 16);

    if( !( flags & FB_COLOR_FG_DEFAULT ) ) {
        last_fc = (fc & 0xF);
        fc = colorlut[last_fc];
    } else {
        fc = last_fc;
    }

    if( !( flags & FB_COLOR_BG_DEFAULT ) ) {
        last_bc = (bc & 0xF);
        bc = colorlut[last_bc];
    } else {
        bc = last_bc;
    }

    SetConsoleTextAttribute( __fb_out_handle, fc + (bc << 4) );

	return cur;
}

int fb_ConsoleGetColorAttEx( HANDLE hConsole )
{
    CONSOLE_SCREEN_BUFFER_INFO info;
    if( GetConsoleScreenBufferInfo( hConsole, &info )==0 )
        return 7;
	return info.wAttributes;

}

int fb_ConsoleGetColorAtt( void )
{
    return fb_ConsoleGetColorAttEx( __fb_out_handle );
}
