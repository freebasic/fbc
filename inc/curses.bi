#if defined(__FB_LINUX__) or defined(USE_NCURSES)
	#include once "curses/ncurses.bi"
#else
	#include once "curses/pdcurses.bi"
#endif
