/* view print helpers (console, no gfx) */

#include "fb.h"

static int view_toprow = -1, view_botrow = -1;

/*:::::*/
int fb_ConsoleGetTopRow( void )
{
    if( view_toprow == -1 ) {
        view_toprow = 0;
    }
	return view_toprow;
}

/*:::::*/
int fb_ConsoleGetBotRow( void )
{
    if( view_botrow == -1 ) {
        fb_GetSize( NULL, &view_botrow );
        if( view_botrow!=0 ) {
            --view_botrow;
        } else {
            view_botrow = FB_SCRN_DEFAULT_HEIGHT - 1;
        }
    }

	return view_botrow;
}

/*:::::*/
void fb_ConsoleSetTopBotRows( int top, int bot )
{
    view_toprow = top;
    view_botrow = bot;
}

/*:::::*/
void fb_ConsoleGetView( int *toprow, int *botrow )
{
	*toprow = fb_ConsoleGetTopRow( ) + 1;
    *botrow = fb_ConsoleGetBotRow( ) + 1;
}


