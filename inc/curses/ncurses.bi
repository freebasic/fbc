''
''
'' ncurses -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __curses_ncurses_bi__
#define __curses_ncurses_bi__

#undef WINDOW
#undef SCREEN
#undef BEEP
#undef GETMOUSE

#inclib "curses"

#ifndef FALSE
	#define FALSE 0
	#define TRUE 1
#endif
#ifndef NULL
	#define NULL 0
#endif

#define CURSES 1
#define NCURSES_VERSION_MAJOR 5
#define NCURSES_VERSION_MINOR 4
#define NCURSES_VERSION_PATCH 20050619
#define NCURSES_VERSION "5.4"
#define NCURSES_MOUSE_VERSION 1
#define NCURSES_ENABLE_STDBOOL_H 1

type chtype as uinteger
type mmask_t as uinteger

type NCURSES_BOOL as ubyte

type FILE_ as FILE

#define NCURSES_CAST(type_,value) cast(type_,value)

#define WA_ATTRIBUTES A_ATTRIBUTES
#define WA_NORMAL A_NORMAL
#define WA_STANDOUT A_STANDOUT
#define WA_UNDERLINE A_UNDERLINE
#define WA_REVERSE A_REVERSE
#define WA_BLINK A_BLINK
#define WA_DIM A_DIM
#define WA_BOLD A_BOLD
#define WA_ALTCHARSET A_ALTCHARSET
#define WA_INVIS A_INVIS
#define WA_PROTECT A_PROTECT
#define WA_HORIZONTAL A_HORIZONTAL
#define WA_LEFT A_LEFT
#define WA_LOW A_LOW
#define WA_RIGHT A_RIGHT
#define WA_TOP A_TOP
#define WA_VERTICAL	A_VERTICAL

#define COLOR_BLACK 0
#define COLOR_RED 1
#define COLOR_GREEN 2
#define COLOR_YELLOW 3
#define COLOR_BLUE 4
#define COLOR_MAGENTA 5
#define COLOR_CYAN 6
#define COLOR_WHITE 7

#define NCURSES_ACS(c) (acs_map[asc(c)])

#define ACS_ULCORNER NCURSES_ACS("l")
#define ACS_LLCORNER NCURSES_ACS("m")
#define ACS_URCORNER NCURSES_ACS("k")
#define ACS_LRCORNER NCURSES_ACS("j")
#define ACS_LTEE NCURSES_ACS("t")
#define ACS_RTEE NCURSES_ACS("u")
#define ACS_BTEE NCURSES_ACS("v")
#define ACS_TTEE NCURSES_ACS("w")
#define ACS_HLINE NCURSES_ACS("q")
#define ACS_VLINE NCURSES_ACS("x")
#define ACS_PLUS NCURSES_ACS("n")
#define ACS_S1 NCURSES_ACS("o")
#define ACS_S9 NCURSES_ACS("s")
#define ACS_DIAMOND NCURSES_ACS("`")
#define ACS_CKBOARD NCURSES_ACS("a")
#define ACS_DEGREE NCURSES_ACS("f")
#define ACS_PLMINUS NCURSES_ACS("g")
#define ACS_BULLET NCURSES_ACS("~")
#define ACS_LARROW NCURSES_ACS(",")
#define ACS_RARROW NCURSES_ACS("+")
#define ACS_DARROW NCURSES_ACS(".")
#define ACS_UARROW NCURSES_ACS("-")
#define ACS_BOARD NCURSES_ACS("h")
#define ACS_LANTERN NCURSES_ACS("i")
#define ACS_BLOCK NCURSES_ACS("0")
#define ACS_S3 NCURSES_ACS("p")
#define ACS_S7 NCURSES_ACS("r")
#define ACS_LEQUAL NCURSES_ACS("y")
#define ACS_GEQUAL NCURSES_ACS("z")
#define ACS_PI NCURSES_ACS("{")
#define ACS_NEQUAL NCURSES_ACS("|")
#define ACS_STERLING NCURSES_ACS("}")
#define ACS_BSSB ACS_ULCORNER
#define ACS_SSBB ACS_LLCORNER
#define ACS_BBSS ACS_URCORNER
#define ACS_SBBS ACS_LRCORNER
#define ACS_SBSS ACS_RTEE
#define ACS_SSSB ACS_LTEE
#define ACS_SSBS ACS_BTEE
#define ACS_BSSS ACS_TTEE
#define ACS_BSBS ACS_HLINE
#define ACS_SBSB ACS_VLINE
#define ACS_SSSS ACS_PLUS

#define NCURSES_ERR (-1)
#define MCURSES_OK (0)

#define _SUBWIN &h01
#define _ENDLINE &h02
#define _FULLWIN &h04
#define _SCROLLWIN &h08
#define _ISPAD &h10
#define _HASMOVED &h20
#define _WRAPPED &h40
#define _NOCHANGE -1
#define _NEWINDEX -1

type SCREEN as any
type WINDOW as _win_st
type attr_t as chtype
type ldat as any

type _win_st_pad
	_pad_y as short
	_pad_x as short
	_pad_top as short
	_pad_left as short
	_pad_bottom as short
	_pad_right as short
end type

type _win_st
	_cury as short
	_curx as short
	_maxy as short
	_maxx as short
	_begy as short
	_begx as short
	_flags as short
	_attrs as attr_t
	_bkgd as chtype
	_notimeout as integer
	_clear as integer
	_leaveok as integer
	_scroll as integer
	_idlok as integer
	_idcok as integer
	_immed as integer
	_sync as integer
	_use_keypad as integer
	_delay as integer
	_line as ldat ptr
	_regtop as short
	_regbottom as short
	_parx as integer
	_pary as integer
	_parent as WINDOW ptr
	_pad as _win_st_pad
	_yoffset as short
end type

extern COLORS alias "COLORS" as integer
extern COLOR_PAIRS alias "COLOR_PAIRS" as integer
extern acs_map alias "acs_map" as chtype ptr
extern stdscr alias "stdscr" as WINDOW ptr
extern curscr alias "curscr" as WINDOW ptr
extern newscr alias "newscr" as WINDOW ptr
extern LINES alias "LINES" as integer
extern COLS alias "COLS" as integer
extern TABSIZE alias "TABSIZE" as integer
extern ESCDELAY alias "ESCDELAY" as integer
extern ttytype alias "ttytype" as zstring ptr

declare function is_term_resized cdecl alias "is_term_resized" (byval as integer, byval as integer) as integer
declare function keybound cdecl alias "keybound" (byval as integer, byval as integer) as zstring ptr
declare function curses_version cdecl alias "curses_version" () as zstring ptr
declare function assume_default_colors cdecl alias "assume_default_colors" (byval as integer, byval as integer) as integer
declare function define_key cdecl alias "define_key" (byval as zstring ptr, byval as integer) as integer
declare function key_defined cdecl alias "key_defined" (byval as zstring ptr) as integer
declare function keyok cdecl alias "keyok" (byval as integer, byval as integer) as integer
declare function resize_term cdecl alias "resize_term" (byval as integer, byval as integer) as integer
declare function resizeterm cdecl alias "resizeterm" (byval as integer, byval as integer) as integer
declare function use_default_colors cdecl alias "use_default_colors" () as integer
declare function use_extended_names cdecl alias "use_extended_names" (byval as integer) as integer
declare function wresize cdecl alias "wresize" (byval as WINDOW ptr, byval as integer, byval as integer) as integer
''''''' declare function addch cdecl alias "addch" (byval as chtype) as integer
''''''' declare function addchnstr cdecl alias "addchnstr" (byval as chtype ptr, byval as integer) as integer
''''''' declare function addchstr cdecl alias "addchstr" (byval as chtype ptr) as integer
''''''' declare function addnstr cdecl alias "addnstr" (byval as zstring ptr, byval as integer) as integer
''''''' declare function addstr cdecl alias "addstr" (byval as zstring ptr) as integer
''''''' declare function attroff cdecl alias "attroff" (byval as integer) as integer
''''''' declare function attron cdecl alias "attron" (byval as integer) as integer
''''''' declare function attrset cdecl alias "attrset" (byval as integer) as integer
''''''' declare function attr_get cdecl alias "attr_get" (byval as attr_t ptr, byval as short ptr, byval as any ptr) as integer
''''''' declare function attr_off cdecl alias "attr_off" (byval as attr_t, byval as any ptr) as integer
''''''' declare function attr_on cdecl alias "attr_on" (byval as attr_t, byval as any ptr) as integer
''''''' declare function attr_set cdecl alias "attr_set" (byval as attr_t, byval as short, byval as any ptr) as integer
declare function baudrate cdecl alias "baudrate" () as integer
declare function beep cdecl alias "beep" () as integer
''''''' declare function bkgd cdecl alias "bkgd" (byval as chtype) as integer
''''''' declare sub bkgdset cdecl alias "bkgdset" (byval as chtype)
''''''' declare function border cdecl alias "border" (byval as chtype, byval as chtype, byval as chtype, byval as chtype, byval as chtype, byval as chtype, byval as chtype, byval as chtype) as integer
''''''' declare function box cdecl alias "box" (byval as WINDOW ptr, byval as chtype, byval as chtype) as integer
declare function can_change_color cdecl alias "can_change_color" () as integer
declare function cbreak cdecl alias "cbreak" () as integer
''''''' declare function chgat cdecl alias "chgat" (byval as integer, byval as attr_t, byval as short, byval as any ptr) as integer
''''''' declare function clear_ cdecl alias "clear" () as integer
''''''' declare function clearok cdecl alias "clearok" (byval as WINDOW ptr, byval as integer) as integer
''''''' declare function clrtobot cdecl alias "clrtobot" () as integer
''''''' declare function clrtoeol cdecl alias "clrtoeol" () as integer
declare function color_content cdecl alias "color_content" (byval as short, byval as short ptr, byval as short ptr, byval as short ptr) as integer
''''''' declare function color_set cdecl alias "color_set" (byval as short, byval as any ptr) as integer
''''''' declare function COLOR_PAIR cdecl alias "COLOR_PAIR" (byval as integer) as integer
declare function copywin cdecl alias "copywin" (byval as WINDOW ptr, byval as WINDOW ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer) as integer
declare function curs_set cdecl alias "curs_set" (byval as integer) as integer
declare function def_prog_mode cdecl alias "def_prog_mode" () as integer
declare function def_shell_mode cdecl alias "def_shell_mode" () as integer
declare function delay_output cdecl alias "delay_output" (byval as integer) as integer
''''''' declare function delch cdecl alias "delch" () as integer
declare sub delscreen cdecl alias "delscreen" (byval as SCREEN ptr)
declare function delwin cdecl alias "delwin" (byval as WINDOW ptr) as integer
''''''' declare function deleteln cdecl alias "deleteln" () as integer
declare function derwin cdecl alias "derwin" (byval as WINDOW ptr, byval as integer, byval as integer, byval as integer, byval as integer) as WINDOW ptr
declare function doupdate cdecl alias "doupdate" () as integer
declare function dupwin cdecl alias "dupwin" (byval as WINDOW ptr) as WINDOW ptr
declare function echo cdecl alias "echo" () as integer
''''''' declare function echochar cdecl alias "echochar" (byval as chtype) as integer
''''''' declare function erase_ cdecl alias "erase" () as integer
declare function endwin cdecl alias "endwin" () as integer
declare function erasechar cdecl alias "erasechar" () as byte
declare sub filter cdecl alias "filter" ()
declare function flash cdecl alias "flash" () as integer
declare function flushinp cdecl alias "flushinp" () as integer
declare function getbkgd cdecl alias "getbkgd" (byval as WINDOW ptr) as chtype
''''''' declare function getch cdecl alias "getch" () as integer
''''''' declare function getnstr cdecl alias "getnstr" (byval as zstring ptr, byval as integer) as integer
''''''' declare function getstr cdecl alias "getstr" (byval as zstring ptr) as integer
declare function getwin cdecl alias "getwin" (byval as FILE_ ptr) as WINDOW ptr
declare function halfdelay cdecl alias "halfdelay" (byval as integer) as integer
declare function has_colors cdecl alias "has_colors" () as integer
declare function has_ic cdecl alias "has_ic" () as integer
declare function has_il cdecl alias "has_il" () as integer
''''''' declare function hline cdecl alias "hline" (byval as chtype, byval as integer) as integer
declare sub idcok cdecl alias "idcok" (byval as WINDOW ptr, byval as integer)
declare function idlok cdecl alias "idlok" (byval as WINDOW ptr, byval as integer) as integer
declare sub immedok cdecl alias "immedok" (byval as WINDOW ptr, byval as integer)
''''''' declare function inch cdecl alias "inch" () as chtype
''''''' declare function inchnstr cdecl alias "inchnstr" (byval as chtype ptr, byval as integer) as integer
''''''' declare function inchstr cdecl alias "inchstr" (byval as chtype ptr) as integer
declare function initscr cdecl alias "initscr" () as WINDOW ptr
declare function init_color cdecl alias "init_color" (byval as short, byval as short, byval as short, byval as short) as integer
declare function init_pair cdecl alias "init_pair" (byval as short, byval as short, byval as short) as integer
''''''' declare function innstr cdecl alias "innstr" (byval as zstring ptr, byval as integer) as integer
''''''' declare function insch cdecl alias "insch" (byval as chtype) as integer
''''''' declare function insdelln cdecl alias "insdelln" (byval as integer) as integer
''''''' declare function insertln cdecl alias "insertln" () as integer
''''''' declare function insnstr cdecl alias "insnstr" (byval as zstring ptr, byval as integer) as integer
''''''' declare function insstr cdecl alias "insstr" (byval as zstring ptr) as integer
''''''' declare function instr_ cdecl alias "instr" (byval as zstring ptr) as integer
declare function intrflush cdecl alias "intrflush" (byval as WINDOW ptr, byval as integer) as integer
declare function isendwin cdecl alias "isendwin" () as integer
declare function is_linetouched cdecl alias "is_linetouched" (byval as WINDOW ptr, byval as integer) as integer
declare function is_wintouched cdecl alias "is_wintouched" (byval as WINDOW ptr) as integer
declare function keyname cdecl alias "keyname" (byval as integer) as zstring ptr
declare function keypad cdecl alias "keypad" (byval as WINDOW ptr, byval as integer) as integer
declare function killchar cdecl alias "killchar" () as byte
declare function leaveok cdecl alias "leaveok" (byval as WINDOW ptr, byval as integer) as integer
declare function longname cdecl alias "longname" () as zstring ptr
declare function meta cdecl alias "meta" (byval as WINDOW ptr, byval as integer) as integer
''''''' declare function move cdecl alias "move" (byval as integer, byval as integer) as integer
declare function mvaddch cdecl alias "mvaddch" (byval as integer, byval as integer, byval as chtype) as integer
declare function mvaddchnstr cdecl alias "mvaddchnstr" (byval as integer, byval as integer, byval as chtype ptr, byval as integer) as integer
declare function mvaddchstr cdecl alias "mvaddchstr" (byval as integer, byval as integer, byval as chtype ptr) as integer
declare function mvaddnstr cdecl alias "mvaddnstr" (byval as integer, byval as integer, byval as zstring ptr, byval as integer) as integer
declare function mvaddstr cdecl alias "mvaddstr" (byval as integer, byval as integer, byval as zstring ptr) as integer
declare function mvchgat cdecl alias "mvchgat" (byval as integer, byval as integer, byval as integer, byval as attr_t, byval as short, byval as any ptr) as integer
declare function mvcur cdecl alias "mvcur" (byval as integer, byval as integer, byval as integer, byval as integer) as integer
declare function mvdelch cdecl alias "mvdelch" (byval as integer, byval as integer) as integer
declare function mvderwin cdecl alias "mvderwin" (byval as WINDOW ptr, byval as integer, byval as integer) as integer
declare function mvgetch cdecl alias "mvgetch" (byval as integer, byval as integer) as integer
declare function mvgetnstr cdecl alias "mvgetnstr" (byval as integer, byval as integer, byval as zstring ptr, byval as integer) as integer
declare function mvgetstr cdecl alias "mvgetstr" (byval as integer, byval as integer, byval as zstring ptr) as integer
declare function mvhline cdecl alias "mvhline" (byval as integer, byval as integer, byval as chtype, byval as integer) as integer
declare function mvinch cdecl alias "mvinch" (byval as integer, byval as integer) as chtype
declare function mvinchnstr cdecl alias "mvinchnstr" (byval as integer, byval as integer, byval as chtype ptr, byval as integer) as integer
declare function mvinchstr cdecl alias "mvinchstr" (byval as integer, byval as integer, byval as chtype ptr) as integer
declare function mvinnstr cdecl alias "mvinnstr" (byval as integer, byval as integer, byval as zstring ptr, byval as integer) as integer
declare function mvinsch cdecl alias "mvinsch" (byval as integer, byval as integer, byval as chtype) as integer
declare function mvinsnstr cdecl alias "mvinsnstr" (byval as integer, byval as integer, byval as zstring ptr, byval as integer) as integer
declare function mvinsstr cdecl alias "mvinsstr" (byval as integer, byval as integer, byval as zstring ptr) as integer
declare function mvinstr cdecl alias "mvinstr" (byval as integer, byval as integer, byval as zstring ptr) as integer
declare function mvprintw cdecl alias "mvprintw" (byval as integer, byval as integer, byval as zstring ptr, ...) as integer
declare function mvscanw cdecl alias "mvscanw" (byval as integer, byval as integer, byval as zstring ptr, ...) as integer
declare function mvvline cdecl alias "mvvline" (byval as integer, byval as integer, byval as chtype, byval as integer) as integer
declare function mvwaddch cdecl alias "mvwaddch" (byval as WINDOW ptr, byval as integer, byval as integer, byval as chtype) as integer
declare function mvwaddchnstr cdecl alias "mvwaddchnstr" (byval as WINDOW ptr, byval as integer, byval as integer, byval as chtype ptr, byval as integer) as integer
declare function mvwaddchstr cdecl alias "mvwaddchstr" (byval as WINDOW ptr, byval as integer, byval as integer, byval as chtype ptr) as integer
declare function mvwaddnstr cdecl alias "mvwaddnstr" (byval as WINDOW ptr, byval as integer, byval as integer, byval as zstring ptr, byval as integer) as integer
declare function mvwaddstr cdecl alias "mvwaddstr" (byval as WINDOW ptr, byval as integer, byval as integer, byval as zstring ptr) as integer
declare function mvwchgat cdecl alias "mvwchgat" (byval as WINDOW ptr, byval as integer, byval as integer, byval as integer, byval as attr_t, byval as short, byval as any ptr) as integer
declare function mvwdelch cdecl alias "mvwdelch" (byval as WINDOW ptr, byval as integer, byval as integer) as integer
declare function mvwgetch cdecl alias "mvwgetch" (byval as WINDOW ptr, byval as integer, byval as integer) as integer
declare function mvwgetnstr cdecl alias "mvwgetnstr" (byval as WINDOW ptr, byval as integer, byval as integer, byval as zstring ptr, byval as integer) as integer
declare function mvwgetstr cdecl alias "mvwgetstr" (byval as WINDOW ptr, byval as integer, byval as integer, byval as zstring ptr) as integer
declare function mvwhline cdecl alias "mvwhline" (byval as WINDOW ptr, byval as integer, byval as integer, byval as chtype, byval as integer) as integer
declare function mvwin cdecl alias "mvwin" (byval as WINDOW ptr, byval as integer, byval as integer) as integer
declare function mvwinch cdecl alias "mvwinch" (byval as WINDOW ptr, byval as integer, byval as integer) as chtype
declare function mvwinchnstr cdecl alias "mvwinchnstr" (byval as WINDOW ptr, byval as integer, byval as integer, byval as chtype ptr, byval as integer) as integer
declare function mvwinchstr cdecl alias "mvwinchstr" (byval as WINDOW ptr, byval as integer, byval as integer, byval as chtype ptr) as integer
declare function mvwinnstr cdecl alias "mvwinnstr" (byval as WINDOW ptr, byval as integer, byval as integer, byval as zstring ptr, byval as integer) as integer
declare function mvwinsch cdecl alias "mvwinsch" (byval as WINDOW ptr, byval as integer, byval as integer, byval as chtype) as integer
declare function mvwinsnstr cdecl alias "mvwinsnstr" (byval as WINDOW ptr, byval as integer, byval as integer, byval as zstring ptr, byval as integer) as integer
declare function mvwinsstr cdecl alias "mvwinsstr" (byval as WINDOW ptr, byval as integer, byval as integer, byval as zstring ptr) as integer
declare function mvwinstr cdecl alias "mvwinstr" (byval as WINDOW ptr, byval as integer, byval as integer, byval as zstring ptr) as integer
declare function mvwprintw cdecl alias "mvwprintw" (byval as WINDOW ptr, byval as integer, byval as integer, byval as zstring ptr, ...) as integer
declare function mvwscanw cdecl alias "mvwscanw" (byval as WINDOW ptr, byval as integer, byval as integer, byval as zstring ptr, ...) as integer
declare function mvwvline cdecl alias "mvwvline" (byval as WINDOW ptr, byval as integer, byval as integer, byval as chtype, byval as integer) as integer
declare function napms cdecl alias "napms" (byval as integer) as integer
declare function newpad cdecl alias "newpad" (byval as integer, byval as integer) as WINDOW ptr
declare function newterm cdecl alias "newterm" (byval as zstring ptr, byval as FILE_ ptr, byval as FILE_ ptr) as SCREEN ptr
declare function newwin cdecl alias "newwin" (byval as integer, byval as integer, byval as integer, byval as integer) as WINDOW ptr
declare function nl cdecl alias "nl" () as integer
declare function nocbreak cdecl alias "nocbreak" () as integer
declare function nodelay cdecl alias "nodelay" (byval as WINDOW ptr, byval as integer) as integer
declare function noecho cdecl alias "noecho" () as integer
declare function nonl cdecl alias "nonl" () as integer
declare sub noqiflush cdecl alias "noqiflush" ()
declare function noraw cdecl alias "noraw" () as integer
declare function notimeout cdecl alias "notimeout" (byval as WINDOW ptr, byval as integer) as integer
declare function overlay cdecl alias "overlay" (byval as WINDOW ptr, byval as WINDOW ptr) as integer
declare function overwrite cdecl alias "overwrite" (byval as WINDOW ptr, byval as WINDOW ptr) as integer
declare function pair_content cdecl alias "pair_content" (byval as short, byval as short ptr, byval as short ptr) as integer
''''''' declare function PAIR_NUMBER cdecl alias "PAIR_NUMBER" (byval as integer) as integer
declare function pechochar cdecl alias "pechochar" (byval as WINDOW ptr, byval as chtype) as integer
declare function pnoutrefresh cdecl alias "pnoutrefresh" (byval as WINDOW ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer) as integer
declare function prefresh cdecl alias "prefresh" (byval as WINDOW ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer) as integer
declare function printw cdecl alias "printw" (byval as zstring ptr, ...) as integer
declare function putp cdecl alias "putp" (byval as zstring ptr) as integer
declare function putwin cdecl alias "putwin" (byval as WINDOW ptr, byval as FILE_ ptr) as integer
declare sub qiflush cdecl alias "qiflush" ()
declare function raw cdecl alias "raw" () as integer
declare function redrawwin cdecl alias "redrawwin" (byval as WINDOW ptr) as integer
''''''' declare function refresh cdecl alias "refresh" () as integer
declare function resetty cdecl alias "resetty" () as integer
declare function reset_prog_mode cdecl alias "reset_prog_mode" () as integer
declare function reset_shell_mode cdecl alias "reset_shell_mode" () as integer
declare function ripoffline cdecl alias "ripoffline" (byval as integer, byval as function cdecl(byval as WINDOW ptr, byval as integer) as integer) as integer
declare function savetty cdecl alias "savetty" () as integer
declare function scanw cdecl alias "scanw" (byval as zstring ptr, ...) as integer
declare function scr_dump cdecl alias "scr_dump" (byval as zstring ptr) as integer
declare function scr_init cdecl alias "scr_init" (byval as zstring ptr) as integer
''''''' declare function scrl cdecl alias "scrl" (byval as integer) as integer
''''''' declare function scroll cdecl alias "scroll" (byval as WINDOW ptr) as integer
declare function scrollok cdecl alias "scrollok" (byval as WINDOW ptr, byval as integer) as integer
declare function scr_restore cdecl alias "scr_restore" (byval as zstring ptr) as integer
declare function scr_set cdecl alias "scr_set" (byval as zstring ptr) as integer
''''''' declare function setscrreg cdecl alias "setscrreg" (byval as integer, byval as integer) as integer
declare function set_term cdecl alias "set_term" (byval as SCREEN ptr) as SCREEN ptr
declare function slk_attroff cdecl alias "slk_attroff" (byval as chtype) as integer
declare function slk_attr_off cdecl alias "slk_attr_off" (byval as attr_t, byval as any ptr) as integer
declare function slk_attron cdecl alias "slk_attron" (byval as chtype) as integer
declare function slk_attr_on cdecl alias "slk_attr_on" (byval as attr_t, byval as any ptr) as integer
declare function slk_attrset cdecl alias "slk_attrset" (byval as chtype) as integer
declare function slk_attr cdecl alias "slk_attr" () as attr_t
declare function slk_attr_set cdecl alias "slk_attr_set" (byval as attr_t, byval as short, byval as any ptr) as integer
declare function slk_clear cdecl alias "slk_clear" () as integer
declare function slk_color cdecl alias "slk_color" (byval as short) as integer
declare function slk_init cdecl alias "slk_init" (byval as integer) as integer
declare function slk_label cdecl alias "slk_label" (byval as integer) as zstring ptr
declare function slk_noutrefresh cdecl alias "slk_noutrefresh" () as integer
declare function slk_refresh cdecl alias "slk_refresh" () as integer
declare function slk_restore cdecl alias "slk_restore" () as integer
declare function slk_set cdecl alias "slk_set" (byval as integer, byval as zstring ptr, byval as integer) as integer
declare function slk_touch cdecl alias "slk_touch" () as integer
''''''' declare function standout cdecl alias "standout" () as integer
''''''' declare function standend cdecl alias "standend" () as integer
declare function start_color cdecl alias "start_color" () as integer
declare function subpad cdecl alias "subpad" (byval as WINDOW ptr, byval as integer, byval as integer, byval as integer, byval as integer) as WINDOW ptr
declare function subwin cdecl alias "subwin" (byval as WINDOW ptr, byval as integer, byval as integer, byval as integer, byval as integer) as WINDOW ptr
declare function syncok cdecl alias "syncok" (byval as WINDOW ptr, byval as integer) as integer
declare function termattrs cdecl alias "termattrs" () as chtype
declare function termname cdecl alias "termname" () as zstring ptr
declare function tigetflag cdecl alias "tigetflag" (byval as zstring ptr) as integer
declare function tigetnum cdecl alias "tigetnum" (byval as zstring ptr) as integer
declare function tigetstr cdecl alias "tigetstr" (byval as zstring ptr) as zstring ptr
''''''' declare sub timeout cdecl alias "timeout" (byval as integer)
declare function touchline cdecl alias "touchline" (byval as WINDOW ptr, byval as integer, byval as integer) as integer
declare function touchwin cdecl alias "touchwin" (byval as WINDOW ptr) as integer
declare function tparm cdecl alias "tparm" (byval as zstring ptr, ...) as zstring ptr
declare function typeahead cdecl alias "typeahead" (byval as integer) as integer
declare function ungetch cdecl alias "ungetch" (byval as integer) as integer
declare function untouchwin cdecl alias "untouchwin" (byval as WINDOW ptr) as integer
declare sub use_env cdecl alias "use_env" (byval as integer)
declare function vidattr cdecl alias "vidattr" (byval as chtype) as integer
declare function vidputs cdecl alias "vidputs" (byval as chtype, byval as function cdecl(byval as integer) as integer) as integer
''''''' declare function vline cdecl alias "vline" (byval as chtype, byval as integer) as integer
declare function vwprintw cdecl alias "vwprintw" (byval as WINDOW ptr, byval as zstring ptr, byval as any ptr) as integer
declare function vw_printw cdecl alias "vw_printw" (byval as WINDOW ptr, byval as zstring ptr, byval as any ptr) as integer
declare function vwscanw cdecl alias "vwscanw" (byval as WINDOW ptr, byval as zstring ptr, byval as any ptr) as integer
declare function vw_scanw cdecl alias "vw_scanw" (byval as WINDOW ptr, byval as zstring ptr, byval as any ptr) as integer
declare function waddch cdecl alias "waddch" (byval as WINDOW ptr, byval as chtype) as integer
declare function waddchnstr cdecl alias "waddchnstr" (byval as WINDOW ptr, byval as chtype ptr, byval as integer) as integer
''''''' declare function waddchstr cdecl alias "waddchstr" (byval as WINDOW ptr, byval as chtype ptr) as integer
declare function waddnstr cdecl alias "waddnstr" (byval as WINDOW ptr, byval as zstring ptr, byval as integer) as integer
''''''' declare function waddstr cdecl alias "waddstr" (byval as WINDOW ptr, byval as zstring ptr) as integer
''''''' declare function wattron cdecl alias "wattron" (byval as WINDOW ptr, byval as integer) as integer
''''''' declare function wattroff cdecl alias "wattroff" (byval as WINDOW ptr, byval as integer) as integer
''''''' declare function wattrset cdecl alias "wattrset" (byval as WINDOW ptr, byval as integer) as integer
declare function wattr_get cdecl alias "wattr_get" (byval as WINDOW ptr, byval as attr_t ptr, byval as short ptr, byval as any ptr) as integer
declare function wattr_on cdecl alias "wattr_on" (byval as WINDOW ptr, byval as attr_t, byval as any ptr) as integer
declare function wattr_off cdecl alias "wattr_off" (byval as WINDOW ptr, byval as attr_t, byval as any ptr) as integer
declare function wattr_set cdecl alias "wattr_set" (byval as WINDOW ptr, byval as attr_t, byval as short, byval as any ptr) as integer
declare function wbkgd cdecl alias "wbkgd" (byval as WINDOW ptr, byval as chtype) as integer
declare sub wbkgdset cdecl alias "wbkgdset" (byval as WINDOW ptr, byval as chtype)
declare function wborder cdecl alias "wborder" (byval as WINDOW ptr, byval as chtype, byval as chtype, byval as chtype, byval as chtype, byval as chtype, byval as chtype, byval as chtype, byval as chtype) as integer
declare function wchgat cdecl alias "wchgat" (byval as WINDOW ptr, byval as integer, byval as attr_t, byval as short, byval as any ptr) as integer
declare function wclear cdecl alias "wclear" (byval as WINDOW ptr) as integer
declare function wclrtobot cdecl alias "wclrtobot" (byval as WINDOW ptr) as integer
declare function wclrtoeol cdecl alias "wclrtoeol" (byval as WINDOW ptr) as integer
declare function wcolor_set cdecl alias "wcolor_set" (byval as WINDOW ptr, byval as short, byval as any ptr) as integer
declare sub wcursyncup cdecl alias "wcursyncup" (byval as WINDOW ptr)
declare function wdelch cdecl alias "wdelch" (byval as WINDOW ptr) as integer
''''''' declare function wdeleteln cdecl alias "wdeleteln" (byval as WINDOW ptr) as integer
declare function wechochar cdecl alias "wechochar" (byval as WINDOW ptr, byval as chtype) as integer
declare function werase cdecl alias "werase" (byval as WINDOW ptr) as integer
declare function wgetch cdecl alias "wgetch" (byval as WINDOW ptr) as integer
declare function wgetnstr cdecl alias "wgetnstr" (byval as WINDOW ptr, byval as zstring ptr, byval as integer) as integer
''''''' declare function wgetstr cdecl alias "wgetstr" (byval as WINDOW ptr, byval as zstring ptr) as integer
declare function whline cdecl alias "whline" (byval as WINDOW ptr, byval as chtype, byval as integer) as integer
declare function winch cdecl alias "winch" (byval as WINDOW ptr) as chtype
declare function winchnstr cdecl alias "winchnstr" (byval as WINDOW ptr, byval as chtype ptr, byval as integer) as integer
''''''' declare function winchstr cdecl alias "winchstr" (byval as WINDOW ptr, byval as chtype ptr) as integer
declare function winnstr cdecl alias "winnstr" (byval as WINDOW ptr, byval as zstring ptr, byval as integer) as integer
declare function winsch cdecl alias "winsch" (byval as WINDOW ptr, byval as chtype) as integer
declare function winsdelln cdecl alias "winsdelln" (byval as WINDOW ptr, byval as integer) as integer
''''''' declare function winsertln cdecl alias "winsertln" (byval as WINDOW ptr) as integer
declare function winsnstr cdecl alias "winsnstr" (byval as WINDOW ptr, byval as zstring ptr, byval as integer) as integer
''''''' declare function winsstr cdecl alias "winsstr" (byval as WINDOW ptr, byval as zstring ptr) as integer
''''''' declare function winstr cdecl alias "winstr" (byval as WINDOW ptr, byval as zstring ptr) as integer
declare function wmove cdecl alias "wmove" (byval as WINDOW ptr, byval as integer, byval as integer) as integer
declare function wnoutrefresh cdecl alias "wnoutrefresh" (byval as WINDOW ptr) as integer
declare function wprintw cdecl alias "wprintw" (byval as WINDOW ptr, byval as zstring ptr, ...) as integer
declare function wredrawln cdecl alias "wredrawln" (byval as WINDOW ptr, byval as integer, byval as integer) as integer
declare function wrefresh cdecl alias "wrefresh" (byval as WINDOW ptr) as integer
declare function wscanw cdecl alias "wscanw" (byval as WINDOW ptr, byval as zstring ptr, ...) as integer
declare function wscrl cdecl alias "wscrl" (byval as WINDOW ptr, byval as integer) as integer
declare function wsetscrreg cdecl alias "wsetscrreg" (byval as WINDOW ptr, byval as integer, byval as integer) as integer
''''''' declare function wstandout cdecl alias "wstandout" (byval as WINDOW ptr) as integer
''''''' declare function wstandend cdecl alias "wstandend" (byval as WINDOW ptr) as integer
declare sub wsyncdown cdecl alias "wsyncdown" (byval as WINDOW ptr)
declare sub wsyncup cdecl alias "wsyncup" (byval as WINDOW ptr)
declare sub wtimeout cdecl alias "wtimeout" (byval as WINDOW ptr, byval as integer)
declare function wtouchln cdecl alias "wtouchln" (byval as WINDOW ptr, byval as integer, byval as integer, byval as integer) as integer
declare function wvline cdecl alias "wvline" (byval as WINDOW ptr, byval as chtype, byval as integer) as integer

#define NCURSES_ATTR_SHIFT 8
#define NCURSES_BITS(mask,shift) ((mask) shl ((shift) + NCURSES_ATTR_SHIFT))

#define A_NORMAL 0
#define A_ATTRIBUTES NCURSES_BITS(not(1 - 1),0)
#define A_CHARTEXT (NCURSES_BITS(1,0) - 1)
#define A_COLOR NCURSES_BITS(((1) shl 8) - 1,0)
#define A_STANDOUT NCURSES_BITS(1,8)
#define A_UNDERLINE NCURSES_BITS(1,9)
#define A_REVERSE NCURSES_BITS(1,10)
#define A_BLINK NCURSES_BITS(1,11)
#define A_DIM NCURSES_BITS(1,12)
#define A_BOLD NCURSES_BITS(1,13)
#define A_ALTCHARSET NCURSES_BITS(1,14)
#define A_INVIS NCURSES_BITS(1,15)
#define A_PROTECT NCURSES_BITS(1,16)
#define A_HORIZONTAL NCURSES_BITS(1,17)
#define A_LEFT NCURSES_BITS(1,18)
#define A_LOW NCURSES_BITS(1,19)
#define A_RIGHT NCURSES_BITS(1,20)
#define A_TOP NCURSES_BITS(1,21)
#define A_VERTICAL NCURSES_BITS(1,22)

#define COLOR_PAIR(n) NCURSES_BITS(n, 0)
#define PAIR_NUMBER(a) (NCURSES_CAST(integer,(((a) and A_COLOR) shr NCURSES_ATTR_SHIFT)))

#define wgetstr(w, s) wgetnstr(w, s, -1)
#define getnstr(s, n) wgetnstr(stdscr, s, n)

#define setterm(term) setupterm(term, 1, cast(integer ptr,0))

#define fixterm() reset_prog_mode()
#define resetterm() reset_shell_mode()
#define saveterm() def_prog_mode()
#define crmode() cbreak()
#define nocrmode() nocbreak()
#define gettmode()

#define getyx(win,y,x) y = getcury(win): x = getcurx(win)
#define getbegyx(win,y,x) y = getbegy(win): x = getbegx(win)
#define getmaxyx(win,y,x) y = getmaxy(win): x = getmaxx(win)
#define getparyx(win,y,x) y = getpary(win): x = getparx(win)

#define getsyx(y,x) if(newscr->_leaveok) then : y= -1: x = -1 : else : getyx(newscr,y,x) : end if
#define setsyx(y,x) if( (y = -1) and (x = -1) ) then : newscr->_leaveok = TRUE : else : newscr->_leaveok = FALSE : wmove(newscr, y, x) : end if

#define getattrs(win) iif(win,(win)->_attrs,A_NORMAL)
#define getcurx(win) iif(win,cint((win)->_curx),NCURSES_ERR)
#define getcury(win) iif(win,cint((win)->_cury),NCURSES_ERR)
#define getbegx(win) iif(win,cint((win)->_begx),NCURSES_ERR)
#define getbegy(win) iif(win,cint((win)->_begy),NCURSES_ERR)
#define getmaxx(win) iif(win,cint((win)->_maxx + 1),NCURSES_ERR)
#define getmaxy(win) iif(win,cint((win)->_maxy + 1),NCURSES_ERR)
#define getparx(win) iif(win,cint((win)->_parx,NCURSES_ERR)
#define getpary(win) iif(win,cint((win)->_pary),NCURSES_ERR)

#define wstandout(win) wattrset(win,A_STANDOUT)
#define wstandend(win) wattrset(win,A_NORMAL)

#define wattron(win,at) wattr_on(win, NCURSES_CAST(attr_t, at), NULL)
#define wattroff(win,at) wattr_off(win, NCURSES_CAST(attr_t, at), NULL)

#define wattrset(win,at) (win)->_attrs = (at)

#define scroll(win) wscrl(win,1)

''''''' #define touchwin(win) wtouchln((win), 0, getmaxy(win), 1)
''''''' #define touchline(win, s, c) wtouchln((win), s, c, 1)
''''''' #define untouchwin(win) wtouchln((win), 0, getmaxy(win), 0)

#define box(win, v, h) wborder(win, v, v, h, h, 0, 0, 0, 0)
#define border(ls, rs, ts, bs, tl, tr, bl, br) wborder(stdscr, ls, rs, ts, bs, tl, tr, bl, br)
#define hline(ch, n) whline(stdscr, ch, n)
#define vline(ch, n) wvline(stdscr, ch, n)

#define winstr(w, s) winnstr(w, s, -1)
#define winchstr(w, s) winchnstr(w, s, -1)
#define winsstr(w, s) winsnstr(w, s, -1)

''''''' #define redrawwin(win) wredrawln(win, 0, (win)->_maxy+1)
#define waddstr(win,str_) waddnstr(win,str_,-1)
#define waddchstr(win,str_)	waddchnstr(win,str_,-1)

#define addch(ch) waddch(stdscr,ch)
#define addchnstr(str_,n) waddchnstr(stdscr,str_,n)
#define addchstr(str_) waddchstr(stdscr,str_)
#define addnstr(str_,n) waddnstr(stdscr,str_,n)
#define addstr(str_) waddnstr(stdscr,str_,-1)
#define attroff(at) wattroff(stdscr,at)
#define attron(at) wattron(stdscr,at)
#define attrset(at) wattrset(stdscr,at)
#define attr_get(ap,cp,o) wattr_get(stdscr,ap,cp,o)
#define attr_off(a,o) wattr_off(stdscr,a,o)
#define attr_on(a,o) wattr_on(stdscr,a,o)
#define attr_set(a,c,o) wattr_set(stdscr,a,c,o)
#define bkgd(ch) wbkgd(stdscr,ch)
#define bkgdset(ch) wbkgdset(stdscr,ch)
#define chgat(n,a,c,o) wchgat(stdscr,n,a,c,o)
#define clear_() wclear(stdscr)
#define clrtobot() wclrtobot(stdscr)
#define clrtoeol() wclrtoeol(stdscr)
#define color_set(c,o) wcolor_set(stdscr,c,o)
#define delch() wdelch(stdscr)
#define deleteln() winsdelln(stdscr,-1)
#define echochar(c) wechochar(stdscr,c)
#define erase_() werase(stdscr)
#define getch() wgetch(stdscr)
#define getstr(str_) wgetstr(stdscr,str_)
#define inch() winch(stdscr)
#define inchnstr(s,n) winchnstr(stdscr,s,n)
#define inchstr(s) winchstr(stdscr,s)
#define innstr(s,n) winnstr(stdscr,s,n)
#define insch(c) winsch(stdscr,c)
#define insdelln(n) winsdelln(stdscr,n)
#define insertln() winsdelln(stdscr,1)
#define insnstr(s,n) winsnstr(stdscr,s,n)
#define insstr(s) winsstr(stdscr,s)
#define instr_(s) winstr(stdscr,s)
#define move(y,x) wmove(stdscr,y,x)
#define refresh() wrefresh(stdscr)
#define scrl(n) wscrl(stdscr,n)
#define setscrreg(t,b) wsetscrreg(stdscr,t,b)
#define standend() wstandend(stdscr)
#define standout() wstandout(stdscr)
#define timeout(delay) wtimeout(stdscr,delay)
#define wdeleteln(win) winsdelln(win,-1)
#define winsertln(win) winsdelln(win,1)

#if 0
#define mvwaddch(win,y,x,ch) iif(wmove(win,y,x) = NCURSES_ERR, NCURSES_ERR, waddch(win,ch))
#define mvwaddchnstr(win,y,x,str_,n) iif(wmove(win,y,x) = NCURSES_ERR, NCURSES_ERR, waddchnstr(win,str_,n))
#define mvwaddchstr(win,y,x,str_) iif(wmove(win,y,x) = NCURSES_ERR, NCURSES_ERR, waddchnstr(win,str_,-1))
#define mvwaddnstr(win,y,x,str_,n) iif(wmove(win,y,x) = NCURSES_ERR, NCURSES_ERR, waddnstr(win,str_,n))
#define mvwaddstr(win,y,x,str_) iif(wmove(win,y,x) = NCURSES_ERR, NCURSES_ERR, waddnstr(win,str_,-1))
#define mvwdelch(win,y,x) iif(wmove(win,y,x) = NCURSES_ERR, NCURSES_ERR, wdelch(win))
#define mvwchgat(win,y,x,n,a,c,o) iif(wmove(win,y,x) = NCURSES_ERR, NCURSES_ERR, wchgat(win,n,a,c,o))
#define mvwgetch(win,y,x) iif(wmove(win,y,x) = NCURSES_ERR, NCURSES_ERR, wgetch(win))
#define mvwgetnstr(win,y,x,str_,n) iif(wmove(win,y,x) = NCURSES_ERR, NCURSES_ERR, wgetnstr(win,str_,n))
#define mvwgetstr(win,y,x,str_) iif(wmove(win,y,x) = NCURSES_ERR, NCURSES_ERR, wgetstr(win,str_))
#define mvwhline(win,y,x,c,n) iif(wmove(win,y,x) = NCURSES_ERR, NCURSES_ERR, whline(win,c,n))
#define mvwinch(win,y,x) iif(wmove(win,y,x) == NCURSES_ERR ? NCURSES_CAST(chtype, NCURSES_ERR) : winch(win))
#define mvwinchnstr(win,y,x,s,n) iif(wmove(win,y,x) = NCURSES_ERR, NCURSES_ERR, winchnstr(win,s,n))
#define mvwinchstr(win,y,x,s) iif(wmove(win,y,x) = NCURSES_ERR, NCURSES_ERR, winchstr(win,s))
#define mvwinnstr(win,y,x,s,n) iif(wmove(win,y,x) = NCURSES_ERR, NCURSES_ERR, winnstr(win,s,n))
#define mvwinsch(win,y,x,c) iif(wmove(win,y,x) = NCURSES_ERR, NCURSES_ERR, winsch(win,c))
#define mvwinsnstr(win,y,x,s,n) iif(wmove(win,y,x) = NCURSES_ERR, NCURSES_ERR, winsnstr(win,s,n))
#define mvwinsstr(win,y,x,s) iif(wmove(win,y,x) = NCURSES_ERR, NCURSES_ERR, winsstr(win,s))
#define mvwinstr(win,y,x,s) iif(wmove(win,y,x) = NCURSES_ERR, NCURSES_ERR, winstr(win,s))
#define mvwvline(win,y,x,c,n) iif(wmove(win,y,x) = NCURSES_ERR, NCURSES_ERR, wvline(win,c,n))

#define mvaddch(y,x,ch) mvwaddch(stdscr,y,x,ch)
#define mvaddchnstr(y,x,str_,n) mvwaddchnstr(stdscr,y,x,str_,n)
#define mvaddchstr(y,x,str_) mvwaddchstr(stdscr,y,x,str_)
#define mvaddnstr(y,x,str_,n) mvwaddnstr(stdscr,y,x,str_,n)
#define mvaddstr(y,x,str_) mvwaddstr(stdscr,y,x,str_)
#define mvchgat(y,x,n,a,c,o) mvwchgat(stdscr,y,x,n,a,c,o)
#define mvdelch(y,x) mvwdelch(stdscr,y,x)
#define mvgetch(y,x) mvwgetch(stdscr,y,x)
#define mvgetnstr(y,x,str_,n) mvwgetnstr(stdscr,y,x,str_,n)
#define mvgetstr(y,x,str_) mvwgetstr(stdscr,y,x,str_)
#define mvhline(y,x,c,n) mvwhline(stdscr,y,x,c,n)
#define mvinch(y,x) mvwinch(stdscr,y,x)
#define mvinchnstr(y,x,s,n) mvwinchnstr(stdscr,y,x,s,n)
#define mvinchstr(y,x,s) mvwinchstr(stdscr,y,x,s)
#define mvinnstr(y,x,s,n) mvwinnstr(stdscr,y,x,s,n)
#define mvinsch(y,x,c) mvwinsch(stdscr,y,x,c)
#define mvinsnstr(y,x,s,n) mvwinsnstr(stdscr,y,x,s,n)
#define mvinsstr(y,x,s) mvwinsstr(stdscr,y,x,s)
#define mvinstr(y,x,s) mvwinstr(stdscr,y,x,s)
#define mvvline(y,x,c,n) mvwvline(stdscr,y,x,c,n)

#define getbkgd(win) ((win)->_bkgd)

#define slk_attr_off(a,v) iif(v),NCURSES_ERR,slk_attroff(a))
#define slk_attr_on(a,v) iif(v,NCURSES_ERR,slk_attron(a))

#define wattr_set(win,a,p,opts)	(win)->_attrs = (((a) and not A_COLOR) or COLOR_PAIR(p))
#define wattr_get(win,a,p,opts)	if (a) <> 0 then : (*(a) = (win)->_attrs)) : end if : if (p) <> 0 then : (*(p) = PAIR_NUMBER((win)->_attrs)) : end if
#define vw_printw vwprintw
#define vw_scanw vwscanw
#endif

#define KEY_CODE_YES &o400
#define KEY_MIN &o401
#define KEY_BREAK &o401
#define KEY_SRESET &o530
#define KEY_RESET &o531
#define KEY_DOWN &o402
#define KEY_UP &o403
#define KEY_LEFT &o404
#define KEY_RIGHT &o405
#define KEY_HOME &o406
#define KEY_BACKSPACE &o407
#define KEY_F0 &o410
#define KEY_DL &o510
#define KEY_IL &o511
#define KEY_DC &o512
#define KEY_IC &o513
#define KEY_EIC &o514
#define KEY_CLEAR &o515
#define KEY_EOS &o516
#define KEY_EOL &o517
#define KEY_SF &o520
#define KEY_SR &o521
#define KEY_NPAGE &o522
#define KEY_PPAGE &o523
#define KEY_STAB &o524
#define KEY_CTAB &o525
#define KEY_CATAB &o526
#define KEY_ENTER &o527
#define KEY_PRINT &o532
#define KEY_LL &o533
#define KEY_A1 &o534
#define KEY_A3 &o535
#define KEY_B2 &o536
#define KEY_C1 &o537
#define KEY_C3 &o540
#define KEY_BTAB &o541
#define KEY_BEG &o542
#define KEY_CANCEL &o543
#define KEY_CLOSE &o544
#define KEY_COMMAND &o545
#define KEY_COPY &o546
#define KEY_CREATE &o547
#define KEY_END &o550
#define KEY_EXIT &o551
#define KEY_FIND &o552
#define KEY_HELP &o553
#define KEY_MARK &o554
#define KEY_MESSAGE &o555
#define KEY_MOVE &o556
#define KEY_NEXT &o557
#define KEY_OPEN &o560
#define KEY_OPTIONS &o561
#define KEY_PREVIOUS &o562
#define KEY_REDO &o563
#define KEY_REFERENCE &o564
#define KEY_REFRESH &o565
#define KEY_REPLACE &o566
#define KEY_RESTART &o567
#define KEY_RESUME &o570
#define KEY_SAVE &o571
#define KEY_SBEG &o572
#define KEY_SCANCEL &o573
#define KEY_SCOMMAND &o574
#define KEY_SCOPY &o575
#define KEY_SCREATE &o576
#define KEY_SDC &o577
#define KEY_SDL &o600
#define KEY_SELECT &o601
#define KEY_SEND &o602
#define KEY_SEOL &o603
#define KEY_SEXIT &o604
#define KEY_SFIND &o605
#define KEY_SHELP &o606
#define KEY_SHOME &o607
#define KEY_SIC &o610
#define KEY_SLEFT &o611
#define KEY_SMESSAGE &o612
#define KEY_SMOVE &o613
#define KEY_SNEXT &o614
#define KEY_SOPTIONS &o615
#define KEY_SPREVIOUS &o616
#define KEY_SPRINT &o617
#define KEY_SREDO &o620
#define KEY_SREPLACE &o621
#define KEY_SRIGHT &o622
#define KEY_SRSUME &o623
#define KEY_SSAVE &o624
#define KEY_SSUSPEND &o625
#define KEY_SUNDO &o626
#define KEY_SUSPEND &o627
#define KEY_UNDO &o630
#define KEY_MOUSE &o631
#define KEY_RESIZE &o632
#define KEY_EVENT &o633
#define KEY_MAX &o777
#define NCURSES_BUTTON_RELEASED &o01
#define NCURSES_BUTTON_PRESSED &o02
#define NCURSES_BUTTON_CLICKED &o04
#define NCURSES_DOUBLE_CLICKED &o10
#define NCURSES_TRIPLE_CLICKED &o20
#define NCURSES_RESERVED_EVENT &o40
#define BUTTON1_RELEASED ((&o01) shl (((1) -1)*6))
#define BUTTON1_PRESSED ((&o02) shl (((1) -1)*6))
#define BUTTON1_CLICKED ((&o04) shl (((1) -1)*6))
#define BUTTON1_DOUBLE_CLICKED ((&o10) shl (((1) -1)*6))
#define BUTTON1_TRIPLE_CLICKED ((&o20) shl (((1) -1)*6))
#define BUTTON2_RELEASED ((&o01) shl (((2) -1)*6))
#define BUTTON2_PRESSED ((&o02) shl (((2) -1)*6))
#define BUTTON2_CLICKED ((&o04) shl (((2) -1)*6))
#define BUTTON2_DOUBLE_CLICKED ((&o10) shl (((2) -1)*6))
#define BUTTON2_TRIPLE_CLICKED ((&o20) shl (((2) -1)*6))
#define BUTTON3_RELEASED ((&o01) shl (((3) -1)*6))
#define BUTTON3_PRESSED ((&o02) shl (((3) -1)*6))
#define BUTTON3_CLICKED ((&o04) shl (((3) -1)*6))
#define BUTTON3_DOUBLE_CLICKED ((&o10) shl (((3) -1)*6))
#define BUTTON3_TRIPLE_CLICKED ((&o20) shl (((3) -1)*6))
#define BUTTON4_RELEASED ((&o01) shl (((4) -1)*6))
#define BUTTON4_PRESSED ((&o02) shl (((4) -1)*6))
#define BUTTON4_CLICKED ((&o04) shl (((4) -1)*6))
#define BUTTON4_DOUBLE_CLICKED ((&o10) shl (((4) -1)*6))
#define BUTTON4_TRIPLE_CLICKED ((&o20) shl (((4) -1)*6))
#define BUTTON1_RESERVED_EVENT ((&o40) shl (((1) -1)*6))
#define BUTTON2_RESERVED_EVENT ((&o40) shl (((2) -1)*6))
#define BUTTON3_RESERVED_EVENT ((&o40) shl (((3) -1)*6))
#define BUTTON4_RESERVED_EVENT ((&o40) shl (((4) -1)*6))
#define BUTTON_CTRL ((&o001) shl (((5) -1)*6))
#define BUTTON_SHIFT ((&o002) shl (((5) -1)*6))
#define BUTTON_ALT ((&o004) shl (((5) -1)*6))
#define REPORT_MOUSE_POSITION ((&o010) shl (((5) -1)*6))
#define	ALL_MOUSE_EVENTS	(REPORT_MOUSE_POSITION - 1)

type MEVENT
	id as short
	x as integer
	y as integer
	z as integer
	bstate as mmask_t
end type

declare function getmouse cdecl alias "getmouse" (byval as MEVENT ptr) as integer
declare function ungetmouse cdecl alias "ungetmouse" (byval as MEVENT ptr) as integer
declare function mousemask cdecl alias "mousemask" (byval as mmask_t, byval as mmask_t ptr) as mmask_t
declare function wenclose cdecl alias "wenclose" (byval as WINDOW ptr, byval as integer, byval as integer) as integer
declare function mouseinterval cdecl alias "mouseinterval" (byval as integer) as integer
declare function wmouse_trafo cdecl alias "wmouse_trafo" (byval as WINDOW ptr, byval as integer ptr, byval as integer ptr, byval as integer) as integer
declare function mouse_trafo cdecl alias "mouse_trafo" (byval as integer ptr, byval as integer ptr, byval as integer) as integer
declare function mcprint cdecl alias "mcprint" (byval as zstring ptr, byval as integer) as integer
declare function has_key cdecl alias "has_key" (byval as integer) as integer
declare sub _tracef cdecl alias "_tracef" (byval as zstring ptr, ...)
declare sub _tracedump cdecl alias "_tracedump" (byval as zstring ptr, byval as WINDOW ptr)
declare function _traceattr cdecl alias "_traceattr" (byval as attr_t) as zstring ptr
declare function _traceattr2 cdecl alias "_traceattr2" (byval as integer, byval as chtype) as zstring ptr
declare function _nc_tracebits cdecl alias "_nc_tracebits" () as zstring ptr
declare function _tracechar cdecl alias "_tracechar" (byval as integer) as zstring ptr
declare function _tracechtype cdecl alias "_tracechtype" (byval as chtype) as zstring ptr
declare function _tracechtype2 cdecl alias "_tracechtype2" (byval as integer, byval as chtype) as zstring ptr
declare function _tracemouse cdecl alias "_tracemouse" (byval as MEVENT ptr) as zstring ptr
declare sub trace cdecl alias "trace" (byval as uinteger)

#define TRACE_DISABLE &h0000
#define TRACE_TIMES &h0001
#define TRACE_TPUTS &h0002
#define TRACE_UPDATE &h0004
#define TRACE_MOVE &h0008
#define TRACE_CHARPUT &h0010
#define TRACE_ORDINARY &h001F
#define TRACE_CALLS &h0020
#define TRACE_VIRTPUT &h0040
#define TRACE_IEVENT &h0080
#define TRACE_BITS &h0100
#define TRACE_ICALLS &h0200
#define TRACE_CCALLS &h0400
#define TRACE_DATABASE &h0800
#define TRACE_ATTRS &h1000
#define TRACE_SHIFT 13
#define TRACE_MAXIMUM ((1 shl 13) -1)

#endif
