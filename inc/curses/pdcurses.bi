'' FreeBASIC binding for PDCurses-3.4
''
'' based on the C header files:
''   The core package is in the public domain, but small portions of PDCurses 
''   are subject to copyright under various licenses.  Each directory 
''   contains a README file, with a section titled "Distribution Status" 
''   which describes the status of the files in that directory.
''
''   If you use PDCurses in an application, an acknowledgement would be 
''   appreciated, but is not mandatory. If you make corrections or 
''   enhancements to PDCurses, please forward them to the current maintainer 
''   for the benefit of other users.
''
''   This software is provided AS IS with NO WARRANTY whatsoever.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "pdcurses"

#include once "crt/long.bi"
#include once "crt/stdarg.bi"
#include once "crt/stddef.bi"
#include once "crt/stdio.bi"

#ifdef PDC_WIDE
	#include once "crt/wchar.bi"
#endif

'' The following symbols have been renamed:
''     constant TRUE => CTRUE
''     constant ERR => ERR_
''     typedef WINDOW => WINDOW_
''     struct SCREEN => SCREEN_
''     procedure beep => beep_
''     procedure clear => clear_
''     procedure erase => erase_
''     procedure instr => instr_
''     procedure getmouse => getmouse_

extern "C"

const __PDCURSES__ = 1
const PDC_BUILD = 3401
const PDCURSES = 1
const XOPEN = 1
const SYSVcurses = 1
const BSDcurses = 1
const CHTYPE_LONG = 1
#ifndef FALSE
	const FALSE = 0
#endif
#ifndef CTRUE
	const CTRUE = 1
#endif
#ifndef TRUE
	const TRUE = 1
#endif
const ERR_ = -1
const OK = 0
type bool as ubyte
type chtype as ulong

#ifdef PDC_WIDE
	type cchar_t as chtype
#endif

type attr_t as chtype

type MOUSE_STATUS
	x as long
	y as long
	button(0 to 2) as short
	changes as long
end type

const BUTTON_RELEASED = &h0000
const BUTTON_PRESSED = &h0001
const BUTTON_CLICKED = &h0002
const BUTTON_DOUBLE_CLICKED = &h0003
const BUTTON_TRIPLE_CLICKED = &h0004
const BUTTON_MOVED = &h0005
const WHEEL_SCROLLED = &h0006
const BUTTON_ACTION_MASK = &h0007
const PDC_BUTTON_SHIFT = &h0008
const PDC_BUTTON_CONTROL = &h0010
const PDC_BUTTON_ALT = &h0020
const BUTTON_MODIFIER_MASK = &h0038
#define MOUSE_X_POS Mouse_status.x
#define MOUSE_Y_POS Mouse_status.y
const PDC_MOUSE_MOVED = &h0008
const PDC_MOUSE_POSITION = &h0010
const PDC_MOUSE_WHEEL_UP = &h0020
const PDC_MOUSE_WHEEL_DOWN = &h0040
#define A_BUTTON_CHANGED (Mouse_status.changes and 7)
#define MOUSE_MOVED (Mouse_status.changes and PDC_MOUSE_MOVED)
#define MOUSE_POS_REPORT (Mouse_status.changes and PDC_MOUSE_POSITION)
#define BUTTON_CHANGED(x) (Mouse_status.changes and (1 shl ((x) - 1)))
#define BUTTON_STATUS(x) (Mouse_status.button((x) - 1))
#define MOUSE_WHEEL_UP (Mouse_status.changes and PDC_MOUSE_WHEEL_UP)
#define MOUSE_WHEEL_DOWN (Mouse_status.changes and PDC_MOUSE_WHEEL_DOWN)
const BUTTON1_RELEASED = cast(clong, &h00000001)
const BUTTON1_PRESSED = cast(clong, &h00000002)
const BUTTON1_CLICKED = cast(clong, &h00000004)
const BUTTON1_DOUBLE_CLICKED = cast(clong, &h00000008)
const BUTTON1_TRIPLE_CLICKED = cast(clong, &h00000010)
const BUTTON1_MOVED = cast(clong, &h00000010)
const BUTTON2_RELEASED = cast(clong, &h00000020)
const BUTTON2_PRESSED = cast(clong, &h00000040)
const BUTTON2_CLICKED = cast(clong, &h00000080)
const BUTTON2_DOUBLE_CLICKED = cast(clong, &h00000100)
const BUTTON2_TRIPLE_CLICKED = cast(clong, &h00000200)
const BUTTON2_MOVED = cast(clong, &h00000200)
const BUTTON3_RELEASED = cast(clong, &h00000400)
const BUTTON3_PRESSED = cast(clong, &h00000800)
const BUTTON3_CLICKED = cast(clong, &h00001000)
const BUTTON3_DOUBLE_CLICKED = cast(clong, &h00002000)
const BUTTON3_TRIPLE_CLICKED = cast(clong, &h00004000)
const BUTTON3_MOVED = cast(clong, &h00004000)
const BUTTON4_RELEASED = cast(clong, &h00008000)
const BUTTON4_PRESSED = cast(clong, &h00010000)
const BUTTON4_CLICKED = cast(clong, &h00020000)
const BUTTON4_DOUBLE_CLICKED = cast(clong, &h00040000)
const BUTTON4_TRIPLE_CLICKED = cast(clong, &h00080000)
const BUTTON5_RELEASED = cast(clong, &h00100000)
const BUTTON5_PRESSED = cast(clong, &h00200000)
const BUTTON5_CLICKED = cast(clong, &h00400000)
const BUTTON5_DOUBLE_CLICKED = cast(clong, &h00800000)
const BUTTON5_TRIPLE_CLICKED = cast(clong, &h01000000)
const MOUSE_WHEEL_SCROLL = cast(clong, &h02000000)
const BUTTON_MODIFIER_SHIFT = cast(clong, &h04000000)
const BUTTON_MODIFIER_CONTROL = cast(clong, &h08000000)
const BUTTON_MODIFIER_ALT = cast(clong, &h10000000)
const ALL_MOUSE_EVENTS = cast(clong, &h1fffffff)
const REPORT_MOUSE_POSITION = cast(clong, &h20000000)
type mmask_t as culong

type MEVENT
	id as short
	x as long
	y as long
	z as long
	bstate as mmask_t
end type

const BUTTON_SHIFT = PDC_BUTTON_SHIFT
const BUTTON_CONTROL = PDC_BUTTON_CONTROL
const BUTTON_ALT = PDC_BUTTON_ALT

type _win
	_cury as long
	_curx as long
	_maxy as long
	_maxx as long
	_begy as long
	_begx as long
	_flags as long
	_attrs as chtype
	_bkgd as chtype
	_clear as bool
	_leaveit as bool
	_scroll as bool
	_nodelay as bool
	_immed as bool
	_sync as bool
	_use_keypad as bool
	_y as chtype ptr ptr
	_firstch as long ptr
	_lastch as long ptr
	_tmarg as long
	_bmarg as long
	_delayms as long
	_parx as long
	_pary as long
	_parent as _win ptr
end type

type WINDOW_ as _win

type SCREEN_
	alive as bool
	autocr as bool
	cbreak as bool
	echo as bool
	raw_inp as bool
	raw_out as bool
	audible as bool
	mono as bool
	resized as bool
	orig_attr as bool
	orig_fore as short
	orig_back as short
	cursrow as long
	curscol as long
	visibility as long
	orig_cursor as long
	lines as long
	cols as long
	_trap_mbe as culong
	_map_mbe_to_key as culong
	mouse_wait as long
	slklines as long
	slk_winptr as WINDOW_ ptr
	linesrippedoff as long
	linesrippedoffontop as long
	delaytenths as long
	_preserve as bool
	_restore as long
	save_key_modifiers as bool
	return_key_modifiers as bool
	key_code as bool
	line_color as short
end type

#if defined(__FB_WIN32__) and defined(PDC_DLL_BUILD)
	extern import LINES as long
	extern import COLS as long
	extern import stdscr as WINDOW_ ptr
	extern import curscr as WINDOW_ ptr
	extern import SP as SCREEN_ ptr
	extern import Mouse_status as MOUSE_STATUS
	extern import COLORS as long
	extern import COLOR_PAIRS as long
	extern import TABSIZE as long
#else
	extern LINES as long
	extern COLS as long
	extern stdscr as WINDOW_ ptr
	extern curscr as WINDOW_ ptr
	extern SP as SCREEN_ ptr
	extern Mouse_status as MOUSE_STATUS
	extern COLORS as long
	extern COLOR_PAIRS as long
	extern TABSIZE as long
#endif

#define acs_map(i) ((@__acs_map)[i])

#if defined(__FB_WIN32__) and defined(PDC_DLL_BUILD)
	extern import __acs_map alias "acs_map" as chtype
	extern import __ttytype alias "ttytype" as byte
#else
	extern __acs_map alias "acs_map" as chtype
	extern __ttytype alias "ttytype" as byte
#endif

#define ttytype (*cptr(zstring ptr, @__ttytype))
const A_NORMAL = cast(chtype, 0)
const A_ALTCHARSET = cast(chtype, &h00010000)
const A_RIGHTLINE = cast(chtype, &h00020000)
const A_LEFTLINE = cast(chtype, &h00040000)
const A_INVIS = cast(chtype, &h00080000)
const A_UNDERLINE = cast(chtype, &h00100000)
const A_REVERSE = cast(chtype, &h00200000)
const A_BLINK = cast(chtype, &h00400000)
const A_BOLD = cast(chtype, &h00800000)
const A_ATTRIBUTES = cast(chtype, &hffff0000)
const A_CHARTEXT = cast(chtype, &h0000ffff)
const A_COLOR = cast(chtype, &hff000000)
const A_ITALIC = A_INVIS
const A_PROTECT = (A_UNDERLINE or A_LEFTLINE) or A_RIGHTLINE
const PDC_ATTR_SHIFT = 19
const PDC_COLOR_SHIFT = 24
const A_STANDOUT = A_REVERSE or A_BOLD
const A_DIM = A_NORMAL
const CHR_MSK = A_CHARTEXT
const ATR_MSK = A_ATTRIBUTES
const ATR_NRM = A_NORMAL
const WA_ALTCHARSET = A_ALTCHARSET
const WA_BLINK = A_BLINK
const WA_BOLD = A_BOLD
const WA_DIM = A_DIM
const WA_INVIS = A_INVIS
const WA_LEFT = A_LEFTLINE
const WA_PROTECT = A_PROTECT
const WA_REVERSE = A_REVERSE
const WA_RIGHT = A_RIGHTLINE
const WA_STANDOUT = A_STANDOUT
const WA_UNDERLINE = A_UNDERLINE
const WA_HORIZONTAL = A_NORMAL
const WA_LOW = A_NORMAL
const WA_TOP = A_NORMAL
const WA_VERTICAL = A_NORMAL
#define ACS_PICK(w, n) (cast(chtype, w) or A_ALTCHARSET)
#define ACS_ULCORNER ACS_PICK(asc("l"), asc("+"))
#define ACS_LLCORNER ACS_PICK(asc("m"), asc("+"))
#define ACS_URCORNER ACS_PICK(asc("k"), asc("+"))
#define ACS_LRCORNER ACS_PICK(asc("j"), asc("+"))
#define ACS_RTEE ACS_PICK(asc("u"), asc("+"))
#define ACS_LTEE ACS_PICK(asc("t"), asc("+"))
#define ACS_BTEE ACS_PICK(asc("v"), asc("+"))
#define ACS_TTEE ACS_PICK(asc("w"), asc("+"))
#define ACS_HLINE ACS_PICK(asc("q"), asc("-"))
#define ACS_VLINE ACS_PICK(asc("x"), asc("|"))
#define ACS_PLUS ACS_PICK(asc("n"), asc("+"))
#define ACS_S1 ACS_PICK(asc("o"), asc("-"))
#define ACS_S9 ACS_PICK(asc("s"), asc("_"))
#define ACS_DIAMOND ACS_PICK(asc("`"), asc("+"))
#define ACS_CKBOARD ACS_PICK(asc("a"), asc(":"))
#define ACS_DEGREE ACS_PICK(asc("f"), asc("'"))
#define ACS_PLMINUS ACS_PICK(asc("g"), asc("#"))
#define ACS_BULLET ACS_PICK(asc("~"), asc("o"))
#define ACS_LARROW ACS_PICK(asc(","), asc("<"))
#define ACS_RARROW ACS_PICK(asc("+"), asc(">"))
#define ACS_DARROW ACS_PICK(asc("."), asc("v"))
#define ACS_UARROW ACS_PICK(asc("-"), asc("^"))
#define ACS_BOARD ACS_PICK(asc("h"), asc("#"))
#define ACS_LANTERN ACS_PICK(asc("i"), asc("*"))
#define ACS_BLOCK ACS_PICK(asc("0"), asc("#"))
#define ACS_S3 ACS_PICK(asc("p"), asc("-"))
#define ACS_S7 ACS_PICK(asc("r"), asc("-"))
#define ACS_LEQUAL ACS_PICK(asc("y"), asc("<"))
#define ACS_GEQUAL ACS_PICK(asc("z"), asc(">"))
#define ACS_PI ACS_PICK(asc("{"), asc("n"))
#define ACS_NEQUAL ACS_PICK(asc("|"), asc("+"))
#define ACS_STERLING ACS_PICK(asc("}"), asc("L"))
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

#ifdef PDC_WIDE
	#define WACS_ULCORNER (@acs_map[asc("l")])
	#define WACS_LLCORNER (@acs_map[asc("m")])
	#define WACS_URCORNER (@acs_map[asc("k")])
	#define WACS_LRCORNER (@acs_map[asc("j")])
	#define WACS_RTEE (@acs_map[asc("u")])
	#define WACS_LTEE (@acs_map[asc("t")])
	#define WACS_BTEE (@acs_map[asc("v")])
	#define WACS_TTEE (@acs_map[asc("w")])
	#define WACS_HLINE (@acs_map[asc("q")])
	#define WACS_VLINE (@acs_map[asc("x")])
	#define WACS_PLUS (@acs_map[asc("n")])
	#define WACS_S1 (@acs_map[asc("o")])
	#define WACS_S9 (@acs_map[asc("s")])
	#define WACS_DIAMOND (@acs_map[asc("`")])
	#define WACS_CKBOARD (@acs_map[asc("a")])
	#define WACS_DEGREE (@acs_map[asc("f")])
	#define WACS_PLMINUS (@acs_map[asc("g")])
	#define WACS_BULLET (@acs_map[asc("~")])
	#define WACS_LARROW (@acs_map[asc(",")])
	#define WACS_RARROW (@acs_map[asc("+")])
	#define WACS_DARROW (@acs_map[asc(".")])
	#define WACS_UARROW (@acs_map[asc("-")])
	#define WACS_BOARD (@acs_map[asc("h")])
	#define WACS_LANTERN (@acs_map[asc("i")])
	#define WACS_BLOCK (@acs_map[asc("0")])
	#define WACS_S3 (@acs_map[asc("p")])
	#define WACS_S7 (@acs_map[asc("r")])
	#define WACS_LEQUAL (@acs_map[asc("y")])
	#define WACS_GEQUAL (@acs_map[asc("z")])
	#define WACS_PI (@acs_map[asc("{")])
	#define WACS_NEQUAL (@acs_map[asc("|")])
	#define WACS_STERLING (@acs_map[asc("}")])
	#define WACS_BSSB WACS_ULCORNER
	#define WACS_SSBB WACS_LLCORNER
	#define WACS_BBSS WACS_URCORNER
	#define WACS_SBBS WACS_LRCORNER
	#define WACS_SBSS WACS_RTEE
	#define WACS_SSSB WACS_LTEE
	#define WACS_SSBS WACS_BTEE
	#define WACS_BSSS WACS_TTEE
	#define WACS_BSBS WACS_HLINE
	#define WACS_SBSB WACS_VLINE
	#define WACS_SSSS WACS_PLUS
#endif

const COLOR_BLACK = 0
const COLOR_BLUE = 1
const COLOR_GREEN = 2
const COLOR_RED = 4
const COLOR_CYAN = COLOR_BLUE or COLOR_GREEN
const COLOR_MAGENTA = COLOR_RED or COLOR_BLUE
const COLOR_YELLOW = COLOR_RED or COLOR_GREEN
const COLOR_WHITE = 7
const KEY_CODE_YES = &h100
const KEY_BREAK = &h101
const KEY_DOWN = &h102
const KEY_UP = &h103
const KEY_LEFT = &h104
const KEY_RIGHT = &h105
const KEY_HOME = &h106
const KEY_BACKSPACE = &h107
const KEY_F0 = &h108
const KEY_DL = &h148
const KEY_IL = &h149
const KEY_DC = &h14a
const KEY_IC = &h14b
const KEY_EIC = &h14c
const KEY_CLEAR = &h14d
const KEY_EOS = &h14e
const KEY_EOL = &h14f
const KEY_SF = &h150
const KEY_SR = &h151
const KEY_NPAGE = &h152
const KEY_PPAGE = &h153
const KEY_STAB = &h154
const KEY_CTAB = &h155
const KEY_CATAB = &h156
const KEY_ENTER = &h157
const KEY_SRESET = &h158
const KEY_RESET = &h159
const KEY_PRINT = &h15a
const KEY_LL = &h15b
const KEY_ABORT = &h15c
const KEY_SHELP = &h15d
const KEY_LHELP = &h15e
const KEY_BTAB = &h15f
const KEY_BEG = &h160
const KEY_CANCEL = &h161
const KEY_CLOSE = &h162
const KEY_COMMAND = &h163
const KEY_COPY = &h164
const KEY_CREATE = &h165
const KEY_END = &h166
const KEY_EXIT = &h167
const KEY_FIND = &h168
const KEY_HELP = &h169
const KEY_MARK = &h16a
const KEY_MESSAGE = &h16b
const KEY_MOVE = &h16c
const KEY_NEXT = &h16d
const KEY_OPEN = &h16e
const KEY_OPTIONS = &h16f
const KEY_PREVIOUS = &h170
const KEY_REDO = &h171
const KEY_REFERENCE = &h172
const KEY_REFRESH = &h173
const KEY_REPLACE = &h174
const KEY_RESTART = &h175
const KEY_RESUME = &h176
const KEY_SAVE = &h177
const KEY_SBEG = &h178
const KEY_SCANCEL = &h179
const KEY_SCOMMAND = &h17a
const KEY_SCOPY = &h17b
const KEY_SCREATE = &h17c
const KEY_SDC = &h17d
const KEY_SDL = &h17e
const KEY_SELECT = &h17f
const KEY_SEND = &h180
const KEY_SEOL = &h181
const KEY_SEXIT = &h182
const KEY_SFIND = &h183
const KEY_SHOME = &h184
const KEY_SIC = &h185
const KEY_SLEFT = &h187
const KEY_SMESSAGE = &h188
const KEY_SMOVE = &h189
const KEY_SNEXT = &h18a
const KEY_SOPTIONS = &h18b
const KEY_SPREVIOUS = &h18c
const KEY_SPRINT = &h18d
const KEY_SREDO = &h18e
const KEY_SREPLACE = &h18f
const KEY_SRIGHT = &h190
const KEY_SRSUME = &h191
const KEY_SSAVE = &h192
const KEY_SSUSPEND = &h193
const KEY_SUNDO = &h194
const KEY_SUSPEND = &h195
const KEY_UNDO = &h196
const ALT_0 = &h197
const ALT_1 = &h198
const ALT_2 = &h199
const ALT_3 = &h19a
const ALT_4 = &h19b
const ALT_5 = &h19c
const ALT_6 = &h19d
const ALT_7 = &h19e
const ALT_8 = &h19f
const ALT_9 = &h1a0
const ALT_A = &h1a1
const ALT_B = &h1a2
const ALT_C = &h1a3
const ALT_D = &h1a4
const ALT_E = &h1a5
const ALT_F = &h1a6
const ALT_G = &h1a7
const ALT_H = &h1a8
const ALT_I = &h1a9
const ALT_J = &h1aa
const ALT_K = &h1ab
const ALT_L = &h1ac
const ALT_M = &h1ad
const ALT_N = &h1ae
const ALT_O = &h1af
const ALT_P = &h1b0
const ALT_Q = &h1b1
const ALT_R = &h1b2
const ALT_S = &h1b3
const ALT_T = &h1b4
const ALT_U = &h1b5
const ALT_V = &h1b6
const ALT_W = &h1b7
const ALT_X = &h1b8
const ALT_Y = &h1b9
const ALT_Z = &h1ba
const CTL_LEFT = &h1bb
const CTL_RIGHT = &h1bc
const CTL_PGUP = &h1bd
const CTL_PGDN = &h1be
const CTL_HOME = &h1bf
const CTL_END = &h1c0
const KEY_A1 = &h1c1
const KEY_A2 = &h1c2
const KEY_A3 = &h1c3
const KEY_B1 = &h1c4
const KEY_B2 = &h1c5
const KEY_B3 = &h1c6
const KEY_C1 = &h1c7
const KEY_C2 = &h1c8
const KEY_C3 = &h1c9
const PADSLASH = &h1ca
const PADENTER = &h1cb
const CTL_PADENTER = &h1cc
const ALT_PADENTER = &h1cd
const PADSTOP = &h1ce
const PADSTAR = &h1cf
const PADMINUS = &h1d0
const PADPLUS = &h1d1
const CTL_PADSTOP = &h1d2
const CTL_PADCENTER = &h1d3
const CTL_PADPLUS = &h1d4
const CTL_PADMINUS = &h1d5
const CTL_PADSLASH = &h1d6
const CTL_PADSTAR = &h1d7
const ALT_PADPLUS = &h1d8
const ALT_PADMINUS = &h1d9
const ALT_PADSLASH = &h1da
const ALT_PADSTAR = &h1db
const ALT_PADSTOP = &h1dc
const CTL_INS = &h1dd
const ALT_DEL = &h1de
const ALT_INS = &h1df
const CTL_UP = &h1e0
const CTL_DOWN = &h1e1
const CTL_TAB = &h1e2
const ALT_TAB = &h1e3
const ALT_MINUS = &h1e4
const ALT_EQUAL = &h1e5
const ALT_HOME = &h1e6
const ALT_PGUP = &h1e7
const ALT_PGDN = &h1e8
const ALT_END = &h1e9
const ALT_UP = &h1ea
const ALT_DOWN = &h1eb
const ALT_RIGHT = &h1ec
const ALT_LEFT = &h1ed
const ALT_ENTER = &h1ee
const ALT_ESC = &h1ef
const ALT_BQUOTE = &h1f0
const ALT_LBRACKET = &h1f1
const ALT_RBRACKET = &h1f2
const ALT_SEMICOLON = &h1f3
const ALT_FQUOTE = &h1f4
const ALT_COMMA = &h1f5
const ALT_STOP = &h1f6
const ALT_FSLASH = &h1f7
const ALT_BKSP = &h1f8
const CTL_BKSP = &h1f9
const PAD0 = &h1fa
const CTL_PAD0 = &h1fb
const CTL_PAD1 = &h1fc
const CTL_PAD2 = &h1fd
const CTL_PAD3 = &h1fe
const CTL_PAD4 = &h1ff
const CTL_PAD5 = &h200
const CTL_PAD6 = &h201
const CTL_PAD7 = &h202
const CTL_PAD8 = &h203
const CTL_PAD9 = &h204
const ALT_PAD0 = &h205
const ALT_PAD1 = &h206
const ALT_PAD2 = &h207
const ALT_PAD3 = &h208
const ALT_PAD4 = &h209
const ALT_PAD5 = &h20a
const ALT_PAD6 = &h20b
const ALT_PAD7 = &h20c
const ALT_PAD8 = &h20d
const ALT_PAD9 = &h20e
const CTL_DEL = &h20f
const ALT_BSLASH = &h210
const CTL_ENTER = &h211
const SHF_PADENTER = &h212
const SHF_PADSLASH = &h213
const SHF_PADSTAR = &h214
const SHF_PADPLUS = &h215
const SHF_PADMINUS = &h216
const SHF_UP = &h217
const SHF_DOWN = &h218
const SHF_IC = &h219
const SHF_DC = &h21a
const KEY_MOUSE = &h21b
const KEY_SHIFT_L = &h21c
const KEY_SHIFT_R = &h21d
const KEY_CONTROL_L = &h21e
const KEY_CONTROL_R = &h21f
const KEY_ALT_L = &h220
const KEY_ALT_R = &h221
const KEY_RESIZE = &h222
const KEY_SUP = &h223
const KEY_SDOWN = &h224
const KEY_MIN = KEY_BREAK
const KEY_MAX = KEY_SDOWN
#define KEY_F(n) (KEY_F0 + (n))

declare function addch(byval as const chtype) as long
declare function addchnstr(byval as const chtype ptr, byval as long) as long
declare function addchstr(byval as const chtype ptr) as long
declare function addnstr(byval as const zstring ptr, byval as long) as long
declare function addstr(byval as const zstring ptr) as long
declare function attroff(byval as chtype) as long
declare function attron(byval as chtype) as long
declare function attrset(byval as chtype) as long
declare function attr_get(byval as attr_t ptr, byval as short ptr, byval as any ptr) as long
declare function attr_off(byval as attr_t, byval as any ptr) as long
declare function attr_on(byval as attr_t, byval as any ptr) as long
declare function attr_set(byval as attr_t, byval as short, byval as any ptr) as long
declare function baudrate() as long
declare function beep_ alias "beep"() as long
declare function bkgd(byval as chtype) as long
declare sub bkgdset(byval as chtype)
declare function border(byval as chtype, byval as chtype, byval as chtype, byval as chtype, byval as chtype, byval as chtype, byval as chtype, byval as chtype) as long
declare function box(byval as WINDOW_ ptr, byval as chtype, byval as chtype) as long
declare function can_change_color() as bool
declare function cbreak() as long
declare function chgat(byval as long, byval as attr_t, byval as short, byval as const any ptr) as long
declare function clearok(byval as WINDOW_ ptr, byval as bool) as long
declare function clear_ alias "clear"() as long
declare function clrtobot() as long
declare function clrtoeol() as long
declare function color_content(byval as short, byval as short ptr, byval as short ptr, byval as short ptr) as long
declare function color_set(byval as short, byval as any ptr) as long
declare function copywin(byval as const WINDOW_ ptr, byval as WINDOW_ ptr, byval as long, byval as long, byval as long, byval as long, byval as long, byval as long, byval as long) as long
declare function curs_set(byval as long) as long
declare function def_prog_mode() as long
declare function def_shell_mode() as long
declare function delay_output(byval as long) as long
declare function delch() as long
declare function deleteln() as long
declare sub delscreen(byval as SCREEN_ ptr)
declare function delwin(byval as WINDOW_ ptr) as long
declare function derwin(byval as WINDOW_ ptr, byval as long, byval as long, byval as long, byval as long) as WINDOW_ ptr
declare function doupdate() as long
declare function dupwin(byval as WINDOW_ ptr) as WINDOW_ ptr
declare function echochar(byval as const chtype) as long
declare function echo() as long
declare function endwin() as long
declare function erasechar() as byte
declare function erase_ alias "erase"() as long
declare sub filter()
declare function flash() as long
declare function flushinp() as long
declare function getbkgd(byval as WINDOW_ ptr) as chtype
declare function getnstr(byval as zstring ptr, byval as long) as long
declare function getstr(byval as zstring ptr) as long
declare function getwin(byval as FILE ptr) as WINDOW_ ptr
declare function halfdelay(byval as long) as long
declare function has_colors() as bool
declare function has_ic() as bool
declare function has_il() as bool
declare function hline(byval as chtype, byval as long) as long
declare sub idcok(byval as WINDOW_ ptr, byval as bool)
declare function idlok(byval as WINDOW_ ptr, byval as bool) as long
declare sub immedok(byval as WINDOW_ ptr, byval as bool)
declare function inchnstr(byval as chtype ptr, byval as long) as long
declare function inchstr(byval as chtype ptr) as long
declare function inch() as chtype
declare function init_color(byval as short, byval as short, byval as short, byval as short) as long
declare function init_pair(byval as short, byval as short, byval as short) as long
declare function initscr() as WINDOW_ ptr
declare function innstr(byval as zstring ptr, byval as long) as long
declare function insch(byval as chtype) as long
declare function insdelln(byval as long) as long
declare function insertln() as long
declare function insnstr(byval as const zstring ptr, byval as long) as long
declare function insstr(byval as const zstring ptr) as long
declare function instr_ alias "instr"(byval as zstring ptr) as long
declare function intrflush(byval as WINDOW_ ptr, byval as bool) as long
declare function isendwin() as bool
declare function is_linetouched(byval as WINDOW_ ptr, byval as long) as bool
declare function is_wintouched(byval as WINDOW_ ptr) as bool
declare function keyname(byval as long) as zstring ptr
declare function keypad(byval as WINDOW_ ptr, byval as bool) as long
declare function killchar() as byte
declare function leaveok(byval as WINDOW_ ptr, byval as bool) as long
declare function longname() as zstring ptr
declare function meta(byval as WINDOW_ ptr, byval as bool) as long
declare function move(byval as long, byval as long) as long
declare function mvaddch(byval as long, byval as long, byval as const chtype) as long
declare function mvaddchnstr(byval as long, byval as long, byval as const chtype ptr, byval as long) as long
declare function mvaddchstr(byval as long, byval as long, byval as const chtype ptr) as long
declare function mvaddnstr(byval as long, byval as long, byval as const zstring ptr, byval as long) as long
declare function mvaddstr(byval as long, byval as long, byval as const zstring ptr) as long
declare function mvchgat(byval as long, byval as long, byval as long, byval as attr_t, byval as short, byval as const any ptr) as long
declare function mvcur(byval as long, byval as long, byval as long, byval as long) as long
declare function mvdelch(byval as long, byval as long) as long
declare function mvderwin(byval as WINDOW_ ptr, byval as long, byval as long) as long
declare function mvgetch(byval as long, byval as long) as long
declare function mvgetnstr(byval as long, byval as long, byval as zstring ptr, byval as long) as long
declare function mvgetstr(byval as long, byval as long, byval as zstring ptr) as long
declare function mvhline(byval as long, byval as long, byval as chtype, byval as long) as long
declare function mvinch(byval as long, byval as long) as chtype
declare function mvinchnstr(byval as long, byval as long, byval as chtype ptr, byval as long) as long
declare function mvinchstr(byval as long, byval as long, byval as chtype ptr) as long
declare function mvinnstr(byval as long, byval as long, byval as zstring ptr, byval as long) as long
declare function mvinsch(byval as long, byval as long, byval as chtype) as long
declare function mvinsnstr(byval as long, byval as long, byval as const zstring ptr, byval as long) as long
declare function mvinsstr(byval as long, byval as long, byval as const zstring ptr) as long
declare function mvinstr(byval as long, byval as long, byval as zstring ptr) as long
declare function mvprintw(byval as long, byval as long, byval as const zstring ptr, ...) as long
declare function mvscanw(byval as long, byval as long, byval as const zstring ptr, ...) as long
declare function mvvline(byval as long, byval as long, byval as chtype, byval as long) as long
declare function mvwaddchnstr(byval as WINDOW_ ptr, byval as long, byval as long, byval as const chtype ptr, byval as long) as long
declare function mvwaddchstr(byval as WINDOW_ ptr, byval as long, byval as long, byval as const chtype ptr) as long
declare function mvwaddch(byval as WINDOW_ ptr, byval as long, byval as long, byval as const chtype) as long
declare function mvwaddnstr(byval as WINDOW_ ptr, byval as long, byval as long, byval as const zstring ptr, byval as long) as long
declare function mvwaddstr(byval as WINDOW_ ptr, byval as long, byval as long, byval as const zstring ptr) as long
declare function mvwchgat(byval as WINDOW_ ptr, byval as long, byval as long, byval as long, byval as attr_t, byval as short, byval as const any ptr) as long
declare function mvwdelch(byval as WINDOW_ ptr, byval as long, byval as long) as long
declare function mvwgetch(byval as WINDOW_ ptr, byval as long, byval as long) as long
declare function mvwgetnstr(byval as WINDOW_ ptr, byval as long, byval as long, byval as zstring ptr, byval as long) as long
declare function mvwgetstr(byval as WINDOW_ ptr, byval as long, byval as long, byval as zstring ptr) as long
declare function mvwhline(byval as WINDOW_ ptr, byval as long, byval as long, byval as chtype, byval as long) as long
declare function mvwinchnstr(byval as WINDOW_ ptr, byval as long, byval as long, byval as chtype ptr, byval as long) as long
declare function mvwinchstr(byval as WINDOW_ ptr, byval as long, byval as long, byval as chtype ptr) as long
declare function mvwinch(byval as WINDOW_ ptr, byval as long, byval as long) as chtype
declare function mvwinnstr(byval as WINDOW_ ptr, byval as long, byval as long, byval as zstring ptr, byval as long) as long
declare function mvwinsch(byval as WINDOW_ ptr, byval as long, byval as long, byval as chtype) as long
declare function mvwinsnstr(byval as WINDOW_ ptr, byval as long, byval as long, byval as const zstring ptr, byval as long) as long
declare function mvwinsstr(byval as WINDOW_ ptr, byval as long, byval as long, byval as const zstring ptr) as long
declare function mvwinstr(byval as WINDOW_ ptr, byval as long, byval as long, byval as zstring ptr) as long
declare function mvwin(byval as WINDOW_ ptr, byval as long, byval as long) as long
declare function mvwprintw(byval as WINDOW_ ptr, byval as long, byval as long, byval as const zstring ptr, ...) as long
declare function mvwscanw(byval as WINDOW_ ptr, byval as long, byval as long, byval as const zstring ptr, ...) as long
declare function mvwvline(byval as WINDOW_ ptr, byval as long, byval as long, byval as chtype, byval as long) as long
declare function napms(byval as long) as long
declare function newpad(byval as long, byval as long) as WINDOW_ ptr
declare function newterm(byval as const zstring ptr, byval as FILE ptr, byval as FILE ptr) as SCREEN_ ptr
declare function newwin(byval as long, byval as long, byval as long, byval as long) as WINDOW_ ptr
declare function nl() as long
declare function nocbreak() as long
declare function nodelay(byval as WINDOW_ ptr, byval as bool) as long
declare function noecho() as long
declare function nonl() as long
declare sub noqiflush()
declare function noraw() as long
declare function notimeout(byval as WINDOW_ ptr, byval as bool) as long
declare function overlay(byval as const WINDOW_ ptr, byval as WINDOW_ ptr) as long
declare function overwrite(byval as const WINDOW_ ptr, byval as WINDOW_ ptr) as long
declare function pair_content(byval as short, byval as short ptr, byval as short ptr) as long
declare function pechochar(byval as WINDOW_ ptr, byval as chtype) as long
declare function pnoutrefresh(byval as WINDOW_ ptr, byval as long, byval as long, byval as long, byval as long, byval as long, byval as long) as long
declare function prefresh(byval as WINDOW_ ptr, byval as long, byval as long, byval as long, byval as long, byval as long, byval as long) as long
declare function printw(byval as const zstring ptr, ...) as long
declare function putwin(byval as WINDOW_ ptr, byval as FILE ptr) as long
declare sub qiflush()
declare function raw() as long
declare function redrawwin(byval as WINDOW_ ptr) as long
declare function refresh() as long
declare function reset_prog_mode() as long
declare function reset_shell_mode() as long
declare function resetty() as long
declare function ripoffline(byval as long, byval as function(byval as WINDOW_ ptr, byval as long) as long) as long
declare function savetty() as long
declare function scanw(byval as const zstring ptr, ...) as long
declare function scr_dump(byval as const zstring ptr) as long
declare function scr_init(byval as const zstring ptr) as long
declare function scr_restore(byval as const zstring ptr) as long
declare function scr_set(byval as const zstring ptr) as long
declare function scrl(byval as long) as long
declare function scroll(byval as WINDOW_ ptr) as long
declare function scrollok(byval as WINDOW_ ptr, byval as bool) as long
declare function set_term(byval as SCREEN_ ptr) as SCREEN_ ptr
declare function setscrreg(byval as long, byval as long) as long
declare function slk_attroff(byval as const chtype) as long
declare function slk_attr_off(byval as const attr_t, byval as any ptr) as long
declare function slk_attron(byval as const chtype) as long
declare function slk_attr_on(byval as const attr_t, byval as any ptr) as long
declare function slk_attrset(byval as const chtype) as long
declare function slk_attr_set(byval as const attr_t, byval as short, byval as any ptr) as long
declare function slk_clear() as long
declare function slk_color(byval as short) as long
declare function slk_init(byval as long) as long
declare function slk_label(byval as long) as zstring ptr
declare function slk_noutrefresh() as long
declare function slk_refresh() as long
declare function slk_restore() as long
declare function slk_set(byval as long, byval as const zstring ptr, byval as long) as long
declare function slk_touch() as long
declare function standend() as long
declare function standout() as long
declare function start_color() as long
declare function subpad(byval as WINDOW_ ptr, byval as long, byval as long, byval as long, byval as long) as WINDOW_ ptr
declare function subwin(byval as WINDOW_ ptr, byval as long, byval as long, byval as long, byval as long) as WINDOW_ ptr
declare function syncok(byval as WINDOW_ ptr, byval as bool) as long
declare function termattrs() as chtype
declare function term_attrs() as attr_t
declare function termname() as zstring ptr
declare sub timeout(byval as long)
declare function touchline(byval as WINDOW_ ptr, byval as long, byval as long) as long
declare function touchwin(byval as WINDOW_ ptr) as long
declare function typeahead(byval as long) as long
declare function untouchwin(byval as WINDOW_ ptr) as long
declare sub use_env(byval as bool)
declare function vidattr(byval as chtype) as long
declare function vid_attr(byval as attr_t, byval as short, byval as any ptr) as long
declare function vidputs(byval as chtype, byval as function(byval as long) as long) as long
declare function vid_puts(byval as attr_t, byval as short, byval as any ptr, byval as function(byval as long) as long) as long
declare function vline(byval as chtype, byval as long) as long
declare function vw_printw(byval as WINDOW_ ptr, byval as const zstring ptr, byval as va_list) as long
declare function vwprintw(byval as WINDOW_ ptr, byval as const zstring ptr, byval as va_list) as long
declare function vw_scanw(byval as WINDOW_ ptr, byval as const zstring ptr, byval as va_list) as long
declare function vwscanw(byval as WINDOW_ ptr, byval as const zstring ptr, byval as va_list) as long
declare function waddchnstr(byval as WINDOW_ ptr, byval as const chtype ptr, byval as long) as long
declare function waddchstr(byval as WINDOW_ ptr, byval as const chtype ptr) as long
declare function waddch(byval as WINDOW_ ptr, byval as const chtype) as long
declare function waddnstr(byval as WINDOW_ ptr, byval as const zstring ptr, byval as long) as long
declare function waddstr(byval as WINDOW_ ptr, byval as const zstring ptr) as long
declare function wattroff(byval as WINDOW_ ptr, byval as chtype) as long
declare function wattron(byval as WINDOW_ ptr, byval as chtype) as long
declare function wattrset(byval as WINDOW_ ptr, byval as chtype) as long
declare function wattr_get(byval as WINDOW_ ptr, byval as attr_t ptr, byval as short ptr, byval as any ptr) as long
declare function wattr_off(byval as WINDOW_ ptr, byval as attr_t, byval as any ptr) as long
declare function wattr_on(byval as WINDOW_ ptr, byval as attr_t, byval as any ptr) as long
declare function wattr_set(byval as WINDOW_ ptr, byval as attr_t, byval as short, byval as any ptr) as long
declare sub wbkgdset(byval as WINDOW_ ptr, byval as chtype)
declare function wbkgd(byval as WINDOW_ ptr, byval as chtype) as long
declare function wborder(byval as WINDOW_ ptr, byval as chtype, byval as chtype, byval as chtype, byval as chtype, byval as chtype, byval as chtype, byval as chtype, byval as chtype) as long
declare function wchgat(byval as WINDOW_ ptr, byval as long, byval as attr_t, byval as short, byval as const any ptr) as long
declare function wclear(byval as WINDOW_ ptr) as long
declare function wclrtobot(byval as WINDOW_ ptr) as long
declare function wclrtoeol(byval as WINDOW_ ptr) as long
declare function wcolor_set(byval as WINDOW_ ptr, byval as short, byval as any ptr) as long
declare sub wcursyncup(byval as WINDOW_ ptr)
declare function wdelch(byval as WINDOW_ ptr) as long
declare function wdeleteln(byval as WINDOW_ ptr) as long
declare function wechochar(byval as WINDOW_ ptr, byval as const chtype) as long
declare function werase(byval as WINDOW_ ptr) as long
declare function wgetch(byval as WINDOW_ ptr) as long
declare function wgetnstr(byval as WINDOW_ ptr, byval as zstring ptr, byval as long) as long
declare function wgetstr(byval as WINDOW_ ptr, byval as zstring ptr) as long
declare function whline(byval as WINDOW_ ptr, byval as chtype, byval as long) as long
declare function winchnstr(byval as WINDOW_ ptr, byval as chtype ptr, byval as long) as long
declare function winchstr(byval as WINDOW_ ptr, byval as chtype ptr) as long
declare function winch(byval as WINDOW_ ptr) as chtype
declare function winnstr(byval as WINDOW_ ptr, byval as zstring ptr, byval as long) as long
declare function winsch(byval as WINDOW_ ptr, byval as chtype) as long
declare function winsdelln(byval as WINDOW_ ptr, byval as long) as long
declare function winsertln(byval as WINDOW_ ptr) as long
declare function winsnstr(byval as WINDOW_ ptr, byval as const zstring ptr, byval as long) as long
declare function winsstr(byval as WINDOW_ ptr, byval as const zstring ptr) as long
declare function winstr(byval as WINDOW_ ptr, byval as zstring ptr) as long
declare function wmove(byval as WINDOW_ ptr, byval as long, byval as long) as long
declare function wnoutrefresh(byval as WINDOW_ ptr) as long
declare function wprintw(byval as WINDOW_ ptr, byval as const zstring ptr, ...) as long
declare function wredrawln(byval as WINDOW_ ptr, byval as long, byval as long) as long
declare function wrefresh(byval as WINDOW_ ptr) as long
declare function wscanw(byval as WINDOW_ ptr, byval as const zstring ptr, ...) as long
declare function wscrl(byval as WINDOW_ ptr, byval as long) as long
declare function wsetscrreg(byval as WINDOW_ ptr, byval as long, byval as long) as long
declare function wstandend(byval as WINDOW_ ptr) as long
declare function wstandout(byval as WINDOW_ ptr) as long
declare sub wsyncdown(byval as WINDOW_ ptr)
declare sub wsyncup(byval as WINDOW_ ptr)
declare sub wtimeout(byval as WINDOW_ ptr, byval as long)
declare function wtouchln(byval as WINDOW_ ptr, byval as long, byval as long, byval as long) as long
declare function wvline(byval as WINDOW_ ptr, byval as chtype, byval as long) as long

#ifdef PDC_WIDE
	declare function addnwstr(byval as const wstring ptr, byval as long) as long
	declare function addwstr(byval as const wstring ptr) as long
	declare function add_wch(byval as const cchar_t ptr) as long
	declare function add_wchnstr(byval as const cchar_t ptr, byval as long) as long
	declare function add_wchstr(byval as const cchar_t ptr) as long
	declare function border_set(byval as const cchar_t ptr, byval as const cchar_t ptr, byval as const cchar_t ptr, byval as const cchar_t ptr, byval as const cchar_t ptr, byval as const cchar_t ptr, byval as const cchar_t ptr, byval as const cchar_t ptr) as long
	declare function box_set(byval as WINDOW_ ptr, byval as const cchar_t ptr, byval as const cchar_t ptr) as long
	declare function echo_wchar(byval as const cchar_t ptr) as long
	declare function erasewchar(byval as wstring ptr) as long
	declare function getbkgrnd(byval as cchar_t ptr) as long
	declare function getcchar(byval as const cchar_t ptr, byval as wstring ptr, byval as attr_t ptr, byval as short ptr, byval as any ptr) as long
	declare function getn_wstr(byval as wint_t ptr, byval as long) as long
	declare function get_wch(byval as wint_t ptr) as long
	declare function get_wstr(byval as wint_t ptr) as long
	declare function hline_set(byval as const cchar_t ptr, byval as long) as long
	declare function innwstr(byval as wstring ptr, byval as long) as long
	declare function ins_nwstr(byval as const wstring ptr, byval as long) as long
	declare function ins_wch(byval as const cchar_t ptr) as long
	declare function ins_wstr(byval as const wstring ptr) as long
	declare function inwstr(byval as wstring ptr) as long
	declare function in_wch(byval as cchar_t ptr) as long
	declare function in_wchnstr(byval as cchar_t ptr, byval as long) as long
	declare function in_wchstr(byval as cchar_t ptr) as long
	declare function key_name(byval as wchar_t) as zstring ptr
	declare function killwchar(byval as wstring ptr) as long
	declare function mvaddnwstr(byval as long, byval as long, byval as const wstring ptr, byval as long) as long
	declare function mvaddwstr(byval as long, byval as long, byval as const wstring ptr) as long
	declare function mvadd_wch(byval as long, byval as long, byval as const cchar_t ptr) as long
	declare function mvadd_wchnstr(byval as long, byval as long, byval as const cchar_t ptr, byval as long) as long
	declare function mvadd_wchstr(byval as long, byval as long, byval as const cchar_t ptr) as long
	declare function mvgetn_wstr(byval as long, byval as long, byval as wint_t ptr, byval as long) as long
	declare function mvget_wch(byval as long, byval as long, byval as wint_t ptr) as long
	declare function mvget_wstr(byval as long, byval as long, byval as wint_t ptr) as long
	declare function mvhline_set(byval as long, byval as long, byval as const cchar_t ptr, byval as long) as long
	declare function mvinnwstr(byval as long, byval as long, byval as wstring ptr, byval as long) as long
	declare function mvins_nwstr(byval as long, byval as long, byval as const wstring ptr, byval as long) as long
	declare function mvins_wch(byval as long, byval as long, byval as const cchar_t ptr) as long
	declare function mvins_wstr(byval as long, byval as long, byval as const wstring ptr) as long
	declare function mvinwstr(byval as long, byval as long, byval as wstring ptr) as long
	declare function mvin_wch(byval as long, byval as long, byval as cchar_t ptr) as long
	declare function mvin_wchnstr(byval as long, byval as long, byval as cchar_t ptr, byval as long) as long
	declare function mvin_wchstr(byval as long, byval as long, byval as cchar_t ptr) as long
	declare function mvvline_set(byval as long, byval as long, byval as const cchar_t ptr, byval as long) as long
	declare function mvwaddnwstr(byval as WINDOW_ ptr, byval as long, byval as long, byval as const wstring ptr, byval as long) as long
	declare function mvwaddwstr(byval as WINDOW_ ptr, byval as long, byval as long, byval as const wstring ptr) as long
	declare function mvwadd_wch(byval as WINDOW_ ptr, byval as long, byval as long, byval as const cchar_t ptr) as long
	declare function mvwadd_wchnstr(byval as WINDOW_ ptr, byval as long, byval as long, byval as const cchar_t ptr, byval as long) as long
	declare function mvwadd_wchstr(byval as WINDOW_ ptr, byval as long, byval as long, byval as const cchar_t ptr) as long
	declare function mvwgetn_wstr(byval as WINDOW_ ptr, byval as long, byval as long, byval as wint_t ptr, byval as long) as long
	declare function mvwget_wch(byval as WINDOW_ ptr, byval as long, byval as long, byval as wint_t ptr) as long
	declare function mvwget_wstr(byval as WINDOW_ ptr, byval as long, byval as long, byval as wint_t ptr) as long
	declare function mvwhline_set(byval as WINDOW_ ptr, byval as long, byval as long, byval as const cchar_t ptr, byval as long) as long
	declare function mvwinnwstr(byval as WINDOW_ ptr, byval as long, byval as long, byval as wstring ptr, byval as long) as long
	declare function mvwins_nwstr(byval as WINDOW_ ptr, byval as long, byval as long, byval as const wstring ptr, byval as long) as long
	declare function mvwins_wch(byval as WINDOW_ ptr, byval as long, byval as long, byval as const cchar_t ptr) as long
	declare function mvwins_wstr(byval as WINDOW_ ptr, byval as long, byval as long, byval as const wstring ptr) as long
	declare function mvwin_wch(byval as WINDOW_ ptr, byval as long, byval as long, byval as cchar_t ptr) as long
	declare function mvwin_wchnstr(byval as WINDOW_ ptr, byval as long, byval as long, byval as cchar_t ptr, byval as long) as long
	declare function mvwin_wchstr(byval as WINDOW_ ptr, byval as long, byval as long, byval as cchar_t ptr) as long
	declare function mvwinwstr(byval as WINDOW_ ptr, byval as long, byval as long, byval as wstring ptr) as long
	declare function mvwvline_set(byval as WINDOW_ ptr, byval as long, byval as long, byval as const cchar_t ptr, byval as long) as long
	declare function pecho_wchar(byval as WINDOW_ ptr, byval as const cchar_t ptr) as long
	declare function setcchar(byval as cchar_t ptr, byval as const wstring ptr, byval as const attr_t, byval as short, byval as const any ptr) as long
	declare function slk_wset(byval as long, byval as const wstring ptr, byval as long) as long
	declare function unget_wch(byval as const wchar_t) as long
	declare function vline_set(byval as const cchar_t ptr, byval as long) as long
	declare function waddnwstr(byval as WINDOW_ ptr, byval as const wstring ptr, byval as long) as long
	declare function waddwstr(byval as WINDOW_ ptr, byval as const wstring ptr) as long
	declare function wadd_wch(byval as WINDOW_ ptr, byval as const cchar_t ptr) as long
	declare function wadd_wchnstr(byval as WINDOW_ ptr, byval as const cchar_t ptr, byval as long) as long
	declare function wadd_wchstr(byval as WINDOW_ ptr, byval as const cchar_t ptr) as long
	declare function wbkgrnd(byval as WINDOW_ ptr, byval as const cchar_t ptr) as long
	declare sub wbkgrndset(byval as WINDOW_ ptr, byval as const cchar_t ptr)
	declare function wborder_set(byval as WINDOW_ ptr, byval as const cchar_t ptr, byval as const cchar_t ptr, byval as const cchar_t ptr, byval as const cchar_t ptr, byval as const cchar_t ptr, byval as const cchar_t ptr, byval as const cchar_t ptr, byval as const cchar_t ptr) as long
	declare function wecho_wchar(byval as WINDOW_ ptr, byval as const cchar_t ptr) as long
	declare function wgetbkgrnd(byval as WINDOW_ ptr, byval as cchar_t ptr) as long
	declare function wgetn_wstr(byval as WINDOW_ ptr, byval as wint_t ptr, byval as long) as long
	declare function wget_wch(byval as WINDOW_ ptr, byval as wint_t ptr) as long
	declare function wget_wstr(byval as WINDOW_ ptr, byval as wint_t ptr) as long
	declare function whline_set(byval as WINDOW_ ptr, byval as const cchar_t ptr, byval as long) as long
	declare function winnwstr(byval as WINDOW_ ptr, byval as wstring ptr, byval as long) as long
	declare function wins_nwstr(byval as WINDOW_ ptr, byval as const wstring ptr, byval as long) as long
	declare function wins_wch(byval as WINDOW_ ptr, byval as const cchar_t ptr) as long
	declare function wins_wstr(byval as WINDOW_ ptr, byval as const wstring ptr) as long
	declare function winwstr(byval as WINDOW_ ptr, byval as wstring ptr) as long
	declare function win_wch(byval as WINDOW_ ptr, byval as cchar_t ptr) as long
	declare function win_wchnstr(byval as WINDOW_ ptr, byval as cchar_t ptr, byval as long) as long
	declare function win_wchstr(byval as WINDOW_ ptr, byval as cchar_t ptr) as long
	declare function wunctrl(byval as cchar_t ptr) as wstring ptr
	declare function wvline_set(byval as WINDOW_ ptr, byval as const cchar_t ptr, byval as long) as long
#endif

declare function getattrs(byval as WINDOW_ ptr) as chtype
declare function getbegx(byval as WINDOW_ ptr) as long
declare function getbegy(byval as WINDOW_ ptr) as long
declare function getmaxx(byval as WINDOW_ ptr) as long
declare function getmaxy(byval as WINDOW_ ptr) as long
declare function getparx(byval as WINDOW_ ptr) as long
declare function getpary(byval as WINDOW_ ptr) as long
declare function getcurx(byval as WINDOW_ ptr) as long
declare function getcury(byval as WINDOW_ ptr) as long
declare sub traceoff()
declare sub traceon()
declare function unctrl(byval as chtype) as zstring ptr
declare function crmode() as long
declare function nocrmode() as long
declare function draino(byval as long) as long
declare function resetterm() as long
declare function fixterm() as long
declare function saveterm() as long
declare function setsyx(byval as long, byval as long) as long
declare function mouse_set(byval as culong) as long
declare function mouse_on(byval as culong) as long
declare function mouse_off(byval as culong) as long
declare function request_mouse_pos() as long
declare function map_button(byval as culong) as long
declare sub wmouse_position(byval as WINDOW_ ptr, byval as long ptr, byval as long ptr)
declare function getmouse_ alias "getmouse"() as culong
declare function getbmap() as culong
declare function assume_default_colors(byval as long, byval as long) as long
declare function curses_version() as const zstring ptr
declare function has_key(byval as long) as bool
declare function use_default_colors() as long
declare function wresize(byval as WINDOW_ ptr, byval as long, byval as long) as long
declare function mouseinterval(byval as long) as long
declare function mousemask(byval as mmask_t, byval as mmask_t ptr) as mmask_t
declare function mouse_trafo(byval as long ptr, byval as long ptr, byval as bool) as bool
declare function nc_getmouse(byval as MEVENT ptr) as long
declare function ungetmouse(byval as MEVENT ptr) as long
declare function wenclose(byval as const WINDOW_ ptr, byval as long, byval as long) as bool
declare function wmouse_trafo(byval as const WINDOW_ ptr, byval as long ptr, byval as long ptr, byval as bool) as bool
declare function addrawch(byval as chtype) as long
declare function insrawch(byval as chtype) as long
declare function is_termresized() as bool
declare function mvaddrawch(byval as long, byval as long, byval as chtype) as long
declare function mvdeleteln(byval as long, byval as long) as long
declare function mvinsertln(byval as long, byval as long) as long
declare function mvinsrawch(byval as long, byval as long, byval as chtype) as long
declare function mvwaddrawch(byval as WINDOW_ ptr, byval as long, byval as long, byval as chtype) as long
declare function mvwdeleteln(byval as WINDOW_ ptr, byval as long, byval as long) as long
declare function mvwinsertln(byval as WINDOW_ ptr, byval as long, byval as long) as long
declare function mvwinsrawch(byval as WINDOW_ ptr, byval as long, byval as long, byval as chtype) as long
declare function raw_output(byval as bool) as long
declare function resize_term(byval as long, byval as long) as long
declare function resize_window(byval as WINDOW_ ptr, byval as long, byval as long) as WINDOW_ ptr
declare function waddrawch(byval as WINDOW_ ptr, byval as chtype) as long
declare function winsrawch(byval as WINDOW_ ptr, byval as chtype) as long
declare function wordchar() as byte

#ifdef PDC_WIDE
	declare function slk_wlabel(byval as long) as wstring ptr
#endif

declare sub PDC_debug(byval as const zstring ptr, ...)
declare function PDC_ungetch(byval as long) as long
declare function PDC_set_blink(byval as bool) as long
declare function PDC_set_line_color(byval as short) as long
declare sub PDC_set_title(byval as const zstring ptr)
declare function PDC_clearclipboard() as long
declare function PDC_freeclipboard(byval as zstring ptr) as long
declare function PDC_getclipboard(byval as zstring ptr ptr, byval as clong ptr) as long
declare function PDC_setclipboard(byval as const zstring ptr, byval as clong) as long
declare function PDC_get_input_fd() as culong
declare function PDC_get_key_modifiers() as culong
declare function PDC_return_key_modifiers(byval as bool) as long
declare function PDC_save_key_modifiers(byval as bool) as long

#define getch() wgetch(stdscr)
#define ungetch(ch) PDC_ungetch(ch)
#define COLOR_PAIR(n) ((cast(chtype, (n)) shl PDC_COLOR_SHIFT) and A_COLOR)
#define PAIR_NUMBER(n) (((n) and A_COLOR) shr PDC_COLOR_SHIFT)
#macro getbegyx(w, y, x)
	scope
		y = getbegy(w)
		x = getbegx(w)
	end scope
#endmacro
#macro getmaxyx(w, y, x)
	scope
		y = getmaxy(w)
		x = getmaxx(w)
	end scope
#endmacro
#macro getparyx(w, y, x)
	scope
		y = getpary(w)
		x = getparx(w)
	end scope
#endmacro
#macro getyx(w, y, x)
	scope
		y = getcury(w)
		x = getcurx(w)
	end scope
#endmacro
#macro getsyx(y, x)
	if curscr->_leaveit then
		(x) = -1
		(y) = -1
	else
		getyx(curscr, (y), (x))
	end if
#endmacro
const PDC_CLIP_SUCCESS = 0
const PDC_CLIP_ACCESS_ERROR = 1
const PDC_CLIP_EMPTY = 2
const PDC_CLIP_MEMORY_ERROR = 3
const PDC_KEY_MODIFIER_SHIFT = 1
const PDC_KEY_MODIFIER_CONTROL = 2
const PDC_KEY_MODIFIER_ALT = 4
const PDC_KEY_MODIFIER_NUMLOCK = 8

end extern
