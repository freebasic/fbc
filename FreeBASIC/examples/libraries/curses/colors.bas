
#include once "curses.bi"

#define NULL 0

    dim as short f, b

    initscr( )
    cbreak( )
    noecho( )

    if (has_colors( )) then
		start_color( )

		pair_content( 0, @f, @b )
		printw( !"pair 0 contains (%d,%d)\n", f, b )
		getch( )

		printw( !"Initializing pair 1 to red/black\n" )
		init_pair( 1, COLOR_RED, COLOR_BLACK )
		attrset( COLOR_PAIR(1) )
		printw( !"RED/BLACK\n" )
		getch( )

		printw( !"Initializing pair 2 to white/blue\n" )
		init_pair( 2, COLOR_WHITE, COLOR_BLUE )
		attrset( COLOR_PAIR(2) )
		printw( !"WHITE/BLUE\n" )
		getch( )
		
		printw( !"Resetting colors to pair 0\n" )
		attrset( COLOR_PAIR(0) )
		printw( !"Default Colors\n" )
		getch( )

		printw( !"Resetting colors to pair 1\n" )
		attrset( COLOR_PAIR(1) )
		printw( !"RED/BLACK\n")
		getch( )

    else
		printw( "This demo requires a color terminal" )
		getch( )
    end if
    
    endwin( )
