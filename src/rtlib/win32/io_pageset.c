/* console 'screen , pg, pg' function */

#include "../fb.h"
#include "fb_private_console.h"

HANDLE fb_hConsoleCreateBuffer( void )
{
	HANDLE hnd = CreateConsoleScreenBuffer( GENERIC_READ | GENERIC_WRITE,
									   		0,
									   		NULL,
									   		CONSOLE_TEXTMODE_BUFFER,
									   		NULL );
	if( hnd == NULL )
		return NULL;

	/* size must be the stdout ones */
	CONSOLE_SCREEN_BUFFER_INFO csbi;
	GetConsoleScreenBufferInfo( __fb_con.outHandle, &csbi );
	SetConsoleScreenBufferSize( hnd, csbi.dwSize );

	return hnd;
}

static void hHideCursor( int pg1, int pg2 )
{
	CONSOLE_CURSOR_INFO cci;

	GetConsoleCursorInfo( __fb_con.outHandle, &cci );
	cci.bVisible = FALSE;

	SetConsoleCursorInfo( __fb_con.pgHandleTb[pg1], &cci );
	if( pg2 >= 0 )
		SetConsoleCursorInfo( __fb_con.pgHandleTb[pg2], &cci );
}

int fb_ConsolePageSet ( int active, int visible )
{
	fb_hConsoleGetHandle( FALSE );

	int res = __fb_con.active | (__fb_con.visible << 8);

	if( active >= 0 )
	{
		if( __fb_con.pgHandleTb[active] == NULL )
		{
            HANDLE hnd = fb_hConsoleCreateBuffer( );
            if( hnd == NULL )
            	return -1;
			else
				__fb_con.pgHandleTb[active] = hnd;
		}

		/* if page isn't visible, hide the cursor */
		if( active != __fb_con.visible )
		{
			hHideCursor( active, -1 );
		}

		__fb_con.active = active;
	}

	if( visible >= 0 )
	{
		if( __fb_con.pgHandleTb[visible] == NULL )
		{
            HANDLE hnd = fb_hConsoleCreateBuffer( );
            if( hnd == NULL )
            	return -1;
			else
				__fb_con.pgHandleTb[visible] = hnd;
		}

		if( __fb_con.visible != visible )
		{
            SetConsoleActiveScreenBuffer( __fb_con.pgHandleTb[visible] );

			/* if pages aren't the same, hide the cursor */
			if( visible != __fb_con.active )
			{
				hHideCursor( __fb_con.active, visible );
			}

			__fb_con.visible = visible;
		}
	}

	return res;
}
