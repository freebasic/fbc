/* console CLS statement */

#include "../fb.h"
#include "fb_private_console.h"

void fb_ConsoleClearViewRawEx( HANDLE hConsole, int x1, int y1, int x2, int y2 )
{
    WORD    attr = (WORD) fb_ConsoleGetColorAttEx( hConsole );
    int     width = x2 - x1 + 1, lines = y2 - y1 + 1;

    if( width==0 || lines==0 )
        return;

    DBG_ASSERT(width > 0);
    DBG_ASSERT(lines > 0);

    while (lines--) {
        DWORD written;
        COORD coord = { x1, y1 + lines };
        FillConsoleOutputAttribute( hConsole, attr, width, coord, &written);
        FillConsoleOutputCharacter( hConsole, ' ', width, coord, &written );
    }

    fb_ConsoleLocateRawEx( hConsole, y1, x1, -1 );
}

void fb_ConsoleClear( int mode )
{
    /* This is the view in screen buffer coordinates (0-based) */
    int		view_left, view_top, view_right, view_bottom;

    /* This is the window in screen buffer coordinates (0-based) */
    int     win_left, win_top, win_right, win_bottom;

    fb_InitConsoleWindow();

    if( FB_CONSOLE_WINDOW_EMPTY() || mode==1 )
        return;

    win_top = __fb_con.window.Top;
    win_left = __fb_con.window.Left;
    win_right = __fb_con.window.Right;
    win_bottom = __fb_con.window.Bottom;

	if( (mode == 2) || (mode == (int)0xFFFF0000) )	/* same as gfxlib's DEFAULT_COLOR */
    {
        /* Just fill the view */
        fb_ConsoleGetView( &view_top, &view_bottom );

        /* Translate the rows of the view to screen buffer coordinates (0-based) */
        fb_hConvertToConsole( NULL, &view_top, NULL, &view_bottom );
        view_left = win_left;
        view_right = win_right;

    } else {
        /* Fill the whole window? */
        view_top = win_top;
        view_left = win_left;
        view_right = win_right;
        view_bottom = win_bottom;
    }

    DBG_ASSERT(view_left <= view_right);
    DBG_ASSERT(view_top <= view_bottom);

    fb_ConsoleClearViewRawEx( __fb_out_handle, view_left, view_top, view_right, view_bottom );
}
