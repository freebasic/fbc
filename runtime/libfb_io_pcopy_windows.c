/*
 * io_pcopy.c -- pcopy (console, no gfx) function for Windows
 *
 * chng: sep/2007 written [v1ctor]
 *
 */

#include "fb.h"

HANDLE fb_hConsoleCreateBuffer( void );

/*:::::*/
int fb_ConsolePageCopy ( int src, int dst )
{
	fb_hConsoleGetHandle( FALSE );

	/* use current? */
	if( src < 0 )
		src = __fb_con.active;

	/* not allocated yet? */
	if( __fb_con.pgHandleTb[src] == NULL )
	{
    	HANDLE hnd = fb_hConsoleCreateBuffer( );
        if( hnd == NULL )
           	return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
		else
			__fb_con.pgHandleTb[src] = hnd;
	}

	/* use current? */
	if( dst < 0 )
		dst = __fb_con.visible;

	if( src == dst )
		return fb_ErrorSetNum( FB_RTERROR_OK );

	/* not allocated yet? */
	if( __fb_con.pgHandleTb[dst] == NULL )
	{
    	HANDLE hnd = fb_hConsoleCreateBuffer( );
        if( hnd == NULL )
           	return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
		else
			__fb_con.pgHandleTb[dst] = hnd;
	}

	/* do the copy */
	static COORD pos = { 0, 0 };

	CONSOLE_SCREEN_BUFFER_INFO csbi;
	GetConsoleScreenBufferInfo( __fb_con.pgHandleTb[src], &csbi );
	PCHAR_INFO buff = alloca( csbi.dwSize.X * csbi.dwSize.Y * sizeof( CHAR_INFO ) );

	ReadConsoleOutput( __fb_con.pgHandleTb[src], buff, csbi.dwSize, pos, &csbi.srWindow );

	GetConsoleScreenBufferInfo( __fb_con.pgHandleTb[dst], &csbi );
	WriteConsoleOutput( __fb_con.pgHandleTb[dst], buff, csbi.dwSize, pos, &csbi.srWindow );

	return fb_ErrorSetNum( FB_RTERROR_OK );
}


