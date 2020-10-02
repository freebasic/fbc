/* console pcopy function */

#include "../fb.h"
#include "fb_private_console.h"

int fb_ConsolePageCopy( int src, int dst )
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

	CONSOLE_SCREEN_BUFFER_INFO csbi;
	GetConsoleScreenBufferInfo( __fb_con.pgHandleTb[src], &csbi );
	PCHAR_INFO buff = malloc( csbi.dwSize.X * csbi.dwSize.Y * sizeof( CHAR_INFO ) );
	if(buff)
	{
		COORD pos = { 0, 0 };
		ReadConsoleOutput( __fb_con.pgHandleTb[src], buff, csbi.dwSize, pos, &csbi.srWindow );

		GetConsoleScreenBufferInfo( __fb_con.pgHandleTb[dst], &csbi );
		WriteConsoleOutput( __fb_con.pgHandleTb[dst], buff, csbi.dwSize, pos, &csbi.srWindow );
		free( buff );
	}
	return fb_ErrorSetNum( buff ? FB_RTERROR_OK : FB_RTERROR_OUTOFMEM );
}
