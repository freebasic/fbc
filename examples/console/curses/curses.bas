#ifdef __FB_WIN32__
	'' When using the pdcurses.dll (through libpdcurses.dll.a), instead of
	'' the libpdcurses.a static lib, PDC_DLL_BUILD must be defined, for the
	'' curses/pdcurses.bi header to change some EXTERN statements over
	'' to EXTERN IMPORT, or else the program will crash:
	'#define PDC_DLL_BUILD
#endif

#include once "curses.bi"

initscr()

cbreak()

'' Disable echoing -- characters entered by user won't be shown in the console
noecho()

'' Terminal supports colors?
if (has_colors()) then
	start_color()

	'' Pair 0 should be the console's default colors
	dim as short f, b
	pair_content( 0, @f, @b )
	printw(!"pair 0 (default colors) contains: (%d,%d)\n", f, b)

	printw(!"Initializing pair 1 to red/black\n")
	init_pair(1, COLOR_RED, COLOR_BLACK)

	printw(!"Initializing pair 2 to white/blue\n")
	init_pair(2, COLOR_WHITE, COLOR_BLUE)

	'' Print some text using pair 1's colors
	attrset(COLOR_PAIR(1))
	printw(!"RED/BLACK\n")

	'' Print some text using pair 2's colors
	attrset(COLOR_PAIR(2))
	printw(!"WHITE/BLUE\n")

	'' Reset to default colors (pair 0)
	attrset(COLOR_PAIR(0))
	printw(!"Default Colors\n")
else
	printw("This demo is only fun in a color terminal!")
end if

'' Sleep
printw(!"Waiting for keypress...\n")
getch()

endwin()
