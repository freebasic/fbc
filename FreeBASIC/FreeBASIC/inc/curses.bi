''
''
'' curses -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __curses_bi__
#define __curses_bi__

#if defined(__FB_LINUX__) or defined(USE_NCURSES)
# include once "curses/ncurses.bi"
#else
# include once "curses/pdcurses.bi"
#endif

#endif
