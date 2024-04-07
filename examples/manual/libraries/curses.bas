'' examples/manual/libraries/curses.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Curses'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ExtLibcurses
'' --------

#include Once "curses.bi"

initscr()
cbreak()
noecho()
start_color()

'' The default pair 0 will have the console's default colors

'' Set pair 1 to be white/blue
init_pair(1, COLOR_WHITE, COLOR_BLUE)

'' Select pair 1, so from now on output will be white text on blue background
attrset(COLOR_PAIR(1))

printw(!"Hello, world!\n")

'' Reset to pair 0
attrset(COLOR_PAIR(0))

'' Sleep
printw(!"Waiting for keypress...\n")
getch()

endwin()
