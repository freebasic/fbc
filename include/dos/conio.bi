' Copyright (C) 1998 DJ Delorie, see COPYING.DJ for details
' Copyright (C) 1995 DJ Delorie, see COPYING.DJ for details
' converted by DrV for FreeBASIC 07-Feb-2005

#ifndef __dj_include_conio_h_
#define __dj_include_conio_h_

#inclib "c"

extern directvideo alias "directvideo" as integer ' ignored by gppconio
extern _wscroll alias "_wscroll" as integer

#define _NOCURSOR      0
#define _SOLIDCURSOR   1
#define _NORMALCURSOR  2

type text_info
	winleft as ubyte
	wintop as ubyte
	winright as ubyte
	winbottom as ubyte
	attribute as ubyte
	normattr as ubyte
	currmode as ubyte
	screenheight as ubyte
	screenwidth as ubyte
	curx as ubyte
	cury as ubyte
end type

enum text_modes
	LASTMODE = -1
	BW40 = 0
	C40
	BW80
	C80
	MONO = 7
	C4350 = 64
end enum

enum COLORS
	'  dark colors
	BLACK
	BLUE
	GREEN
	CYAN
	RED
	MAGENTA
	BROWN
	LIGHTGRAY
	'  light colors
	DARKGRAY ' "light black"
	LIGHTBLUE
	LIGHTGREEN
	LIGHTCYAN
	LIGHTRED
	LIGHTMAGENTA
	YELLOW
	WHITE
end enum

#define BLINK   &H80    ' blink bit


declare sub		blinkvideo		cdecl alias "blinkvideo"	()
declare function	cgets			cdecl alias "cgets"		(byval strn as byte ptr) as byte ptr
declare sub		clreol			cdecl alias "clreol"		()
declare sub		clrscr			cdecl alias "clrscr"		()
declare function	_conio_kbhit		cdecl alias "_conio_kbhit"	() as integer ' checks for ungetch char
declare function	cprintf			cdecl alias "cprintf"		(byval sformat as zstring ptr) as integer
declare function	cputs			cdecl alias "cputs"		(byval strn as zstring ptr) as integer
''''declare function	cscanf			cdecl alias "cscanf"		(byval sformat as zstring ptr) as integer
declare sub		delline			cdecl alias "delline"		()
declare function	getch			cdecl alias "getch"		() as integer
declare function	getche			cdecl alias "getche"		() as integer
declare function	_conio_gettext		cdecl alias "_conio_gettext"	(byval left_ as integer, byval top_ as integer, byval right_ as integer, byval bottom as integer, byval destin as any ptr) as integer
declare sub		gettextinfo		cdecl alias "gettextinfo"	(byval r as text_info ptr)
declare sub		gotoxy			cdecl alias "gotoxy"		(byval x as integer, byval y as integer)
declare sub		gppconio_init		cdecl alias "gppconio_init"	()
declare sub		highvideo		cdecl alias "highvideo"		()
declare sub		insline			cdecl alias "insline"		()
declare sub		intensevideo		cdecl alias "intensevideo"	()
declare sub		lowvideo		cdecl alias "lowvideo"		()
declare function	movetext		cdecl alias "movetext"		(byval left_ as integer, byval top as integer, byval right_ as integer, byval bottom as integer, byval destleft as integer, byval desttop as integer) as integer
declare sub		normvideo		cdecl alias "normvideo"		()
declare function	putch			cdecl alias "putch"		(byval c as integer) as integer
declare function	puttext			cdecl alias "puttext"		(byval left_ as integer, byval top as integer, byval right_ as integer, byval bottom as integer, byval source as any ptr) as integer
declare sub		_setcursortype		cdecl alias "_setcursortype"	(byval type_ as integer)
declare sub		_set_screen_lines	cdecl alias "_set_screen_lines"	(byval nlines as integer)
declare sub		textattr		cdecl alias "textattr"		(byval attr as integer)
declare sub		textbackground		cdecl alias "textbackground"	(byval colr as integer)
declare sub		textcolor		cdecl alias "textcolor"		(byval colr as integer)
declare sub		textmode		cdecl alias "textmode"		(byval mode as integer)
declare function	ungetch			cdecl alias "ungetch"		(byval c as integer) as integer
declare function	wherex			cdecl alias "wherex"		() as integer
declare function	wherey			cdecl alias "wherey"		() as integer
declare sub		conio_window		cdecl alias "window"		(byval left_ as integer, byval top as integer, byval right_ as integer, byval bottom as integer)

'#define kbhit conio_kbhit ' Who ever includes gppconio.h probably
'                          '    also wants _conio_kbhit and not kbhit
'                          '    from libc

#ifndef __USE_GNU_GETTEXT
# undef  gettext
# define gettext _conio_gettext
#endif

#endif ' !__dj_include_conio_h_
