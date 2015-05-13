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

#undef WINDOW
#undef SCREEN
#undef BEEP
#undef GETMOUSE

#inclib "curses"

#ifdef __FB_WIN32__
	#inclib "user32"
	#inclib "coldname"
#endif

#ifndef FALSE
	#define FALSE 0
	#define TRUE 1
#endif
#ifndef NULL
	#define NULL cast(any ptr, 0)
#endif

#define __PDCURSES__ 1
#define PDC_BUILD 3401
#define PDCURSES 1
#define XOPEN 1
#define SYSVcurses 1
#define BSDcurses 1
#define CHTYPE_LONG 1
#define ERR (-1)
#define OK 0

type chtype as uinteger
type cchar_t as chtype
type attr_t as chtype

type MOUSE_STATUS
	x as integer
	y as integer
	button(0 to 2) as short
	changes as integer
end type

#define MOUSE_X_POS (Mouse_status_.x)
#define MOUSE_Y_POS (Mouse_status_.y)
#define A_BUTTON_CHANGED ((Mouse_status_.changes and 7) <> 0)
#define MOUSE_MOVED ((Mouse_status_.changes and 8) <> 0)
#define MOUSE_POS_REPORT ((Mouse_status_.changes and 16) <> 0)
#define BUTTON_CHANGED(x) ((Mouse_status_.changes and (1 shl ((x) - 1))) <> 0)
#define BUTTON_STATUS(x) (Mouse_status_.button((x)-1))

#define BUTTON_RELEASED &h0000
#define BUTTON_PRESSED &h0001
#define BUTTON_CLICKED &h0002
#define BUTTON_DOUBLE_CLICKED &h0003
#define BUTTON_TRIPLE_CLICKED &h0004
#define BUTTON_MOVED &h0005
#define WHEEL_SCROLLED &h0006
#define BUTTON_ACTION_MASK &h0007
#define PDC_BUTTON_SHIFT &h0008
#define PDC_BUTTON_CONTROL &h0010
#define PDC_BUTTON_ALT &h0020
#define BUTTON_MODIFIER_MASK &h0038
#define PDC_MOUSE_MOVED &h0008
#define PDC_MOUSE_POSITION &h0010
#define PDC_MOUSE_WHEEL_UP &h0020
#define PDC_MOUSE_WHEEL_DOWN &h0040
#define BUTTON1_RELEASED &h00000001L
#define BUTTON1_PRESSED &h00000002L
#define BUTTON1_CLICKED &h00000004L
#define BUTTON1_DOUBLE_CLICKED &h00000008L
#define BUTTON1_TRIPLE_CLICKED &h00000010L
#define BUTTON1_MOVED &h00000010L
#define BUTTON2_RELEASED &h00000020L
#define BUTTON2_PRESSED &h00000040L
#define BUTTON2_CLICKED &h00000080L
#define BUTTON2_DOUBLE_CLICKED &h00000100L
#define BUTTON2_TRIPLE_CLICKED &h00000200L
#define BUTTON2_MOVED &h00000200L
#define BUTTON3_RELEASED &h00000400L
#define BUTTON3_PRESSED &h00000800L
#define BUTTON3_CLICKED &h00001000L
#define BUTTON3_DOUBLE_CLICKED &h00002000L
#define BUTTON3_TRIPLE_CLICKED &h00004000L
#define BUTTON3_MOVED &h00004000L
#define BUTTON4_RELEASED &h00008000L
#define BUTTON4_PRESSED &h00010000L
#define BUTTON4_CLICKED &h00020000L
#define BUTTON4_DOUBLE_CLICKED &h00040000L
#define BUTTON4_TRIPLE_CLICKED &h00080000L
#define BUTTON5_RELEASED &h00100000L
#define BUTTON5_PRESSED &h00200000L
#define BUTTON5_CLICKED &h00400000L
#define BUTTON5_DOUBLE_CLICKED &h00800000L
#define BUTTON5_TRIPLE_CLICKED &h01000000L
#define MOUSE_WHEEL_SCROLL &h02000000L
#define BUTTON_MODIFIER_SHIFT &h04000000L
#define BUTTON_MODIFIER_CONTROL &h08000000L
#define BUTTON_MODIFIER_ALT &h10000000L
#define ALL_MOUSE_EVENTS &h1fffffffL
#define REPORT_MOUSE_POSITION &h20000000L

type mmask_t as uinteger

type MEVENT
	id as short
	x as integer
	y as integer
	z as integer
	bstate as mmask_t
end type

#define BUTTON_SHIFT &h0008
#define BUTTON_CONTROL &h0010
#define BUTTON_ALT &h0020

type WINDOW
	_cury as integer
	_curx as integer
	_maxy as integer
	_maxx as integer
	_begy as integer
	_begx as integer
	_flags as integer
	_attrs as chtype
	_bkgd as chtype
	_clear as integer
	_leaveit as integer
	_scroll as integer
	_nodelay as integer
	_immed as integer
	_sync as integer
	_use_keypad as integer
	_y as chtype ptr ptr
	_firstch as integer ptr
	_lastch as integer ptr
	_tmarg as integer
	_bmarg as integer
	_delayms as integer
	_parx as integer
	_pary as integer
	_parent as _win ptr
end type

type SCREEN
	alive as integer
	autocr as integer
	cbreak as integer
	echo as integer
	raw_inp as integer
	raw_out as integer
	audible as integer
	mono as integer
	resized as integer
	orig_attr as integer
	orig_fore as short
	orig_back as short
	cursrow as integer
	curscol as integer
	visibility as integer
	orig_cursor as integer
	lines as integer
	cols as integer
	_trap_mbe as uinteger
	_map_mbe_to_key as uinteger
	mouse_wait as integer
	slklines as integer
	slk_winptr as WINDOW ptr
	linesrippedoff as integer
	linesrippedoffontop as integer
	delaytenths as integer
	_preserve as integer
	_restore as integer
	save_key_modifiers as integer
	return_key_modifiers as integer
	key_code as integer
	line_color as short
end type

extern LINES alias "LINES" as integer
extern COLS alias "COLS" as integer
extern stdscr alias "stdscr" as WINDOW ptr
extern curscr alias "curscr" as WINDOW ptr
extern SP alias "SP" as SCREEN ptr
extern Mouse_status alias "Mouse_status" as MOUSE_STATUS
extern COLORS alias "COLORS" as integer
extern COLOR_PAIRS alias "COLOR_PAIRS" as integer
extern TABSIZE alias "TABSIZE" as integer
extern acs_map(0 to -1) alias "acs_map" as chtype
extern ttytype alias "ttytype" as zstring * 

#define A_NORMAL &h00000000
#define A_UNDERLINE &h00100000
#define A_REVERSE &h00200000
#define A_BLINK &h00400000
#define A_BOLD &h00800000
#define A_RIGHTLINE &h00010000
#define A_DIM A_NORMAL
#define A_ALTCHARSET &h00040000
#define A_INVIS &h00080000
#define A_ATTRIBUTES &hFFFF0000
#define A_CHARTEXT &h0000FFFF
#define A_COLOR &hFF000000
#define A_LEFTLINE &h00020000
#define A_ITALIC &h00080000
#define A_STANDOUT (&h00800000 or &h00200000)
#define A_PROTECT (&h00100000 or &h00020000 or &h00010000)

#define PDC_ATTR_SHIFT 19
#define PDC_COLOR_SHIFT 24

#define WA_ALTCHARSET A_ALTCHARSET
#define WA_BLINK      A_BLINK
#define WA_BOLD       A_BOLD
#define WA_DIM        A_DIM
#define WA_INVIS      A_INVIS
#define WA_LEFT       A_LEFTLINE
#define WA_PROTECT    A_PROTECT
#define WA_REVERSE    A_REVERSE
#define WA_RIGHT      A_RIGHTLINE
#define WA_STANDOUT   A_STANDOUT
#define WA_UNDERLINE  A_UNDERLINE

#define WA_HORIZONTAL A_NORMAL
#define WA_LOW        A_NORMAL
#define WA_TOP        A_NORMAL
#define WA_VERTICAL   A_NORMAL

#define ACS_ULCORNER cast(chtype,&hda)
#define ACS_LLCORNER cast(chtype,&hc0)
#define ACS_URCORNER cast(chtype,&hbf)
#define ACS_LRCORNER cast(chtype,&hd9)
#define ACS_RTEE cast(chtype,&hb4)
#define ACS_LTEE cast(chtype,&hc3)
#define ACS_BTEE cast(chtype,&hc1)
#define ACS_TTEE cast(chtype,&hc2)
#define ACS_HLINE cast(chtype,&hc4)
#define ACS_VLINE cast(chtype,&hb3)
#define ACS_PLUS cast(chtype,&hc5)
#define ACS_S1	cast(chtype,&h2d)
#define ACS_S9	cast(chtype,&h5f)
#define ACS_DIAMOND cast(chtype,&hc5)
#define ACS_CKBOARD cast(chtype,&hb2)
#define ACS_DEGREE	cast(chtype,&hf8)
#define ACS_PLMINUS cast(chtype,&hf1)
#define ACS_BULLET	cast(chtype,&hf9)
#define ACS_LARROW	cast(chtype,&h3c)
#define ACS_RARROW	cast(chtype,&h3e)
#define ACS_DARROW	cast(chtype,&h76)
#define ACS_UARROW	cast(chtype,&h5e)
#define ACS_BOARD cast(chtype,&h23)
#define ACS_LANTERN cast(chtype,&h23)
#define ACS_BLOCK cast(chtype,&h23)

#define ACS_BSSB      ACS_ULCORNER
#define ACS_SSBB      ACS_LLCORNER
#define ACS_BBSS      ACS_URCORNER
#define ACS_SBBS      ACS_LRCORNER
#define ACS_SBSS      ACS_RTEE
#define ACS_SSSB      ACS_LTEE
#define ACS_SSBS      ACS_BTEE
#define ACS_BSSS      ACS_TTEE
#define ACS_BSBS      ACS_HLINE
#define ACS_SBSB      ACS_VLINE
#define ACS_SSSS      ACS_PLUS

#define COLOR_BLACK 0
#define COLOR_BLUE 1
#define COLOR_GREEN 2
#define COLOR_RED 4
#define COLOR_CYAN (1 or 2)
#define COLOR_MAGENTA (4 or 1)
#define COLOR_YELLOW (4 or 2)
#define COLOR_WHITE 7
#define KEY_CODE_YES &h100
#define KEY_BREAK &h101
#define KEY_DOWN &h102
#define KEY_UP &h103
#define KEY_LEFT &h104
#define KEY_RIGHT &h105
#define KEY_HOME &h106
#define KEY_BACKSPACE &h107
#define KEY_F0 &h108
#define KEY_DL &h148
#define KEY_IL &h149
#define KEY_DC &h14a
#define KEY_IC &h14b
#define KEY_EIC &h14c
#define KEY_CLEAR &h14d
#define KEY_EOS &h14e
#define KEY_EOL &h14f
#define KEY_SF &h150
#define KEY_SR &h151
#define KEY_NPAGE &h152
#define KEY_PPAGE &h153
#define KEY_STAB &h154
#define KEY_CTAB &h155
#define KEY_CATAB &h156
#define KEY_ENTER &h157
#define KEY_SRESET &h158
#define KEY_RESET &h159
#define KEY_PRINT &h15a
#define KEY_LL &h15b
#define KEY_ABORT &h15c
#define KEY_SHELP &h15d
#define KEY_LHELP &h15e
#define KEY_BTAB &h15f
#define KEY_BEG &h160
#define KEY_CANCEL &h161
#define KEY_CLOSE &h162
#define KEY_COMMAND &h163
#define KEY_COPY &h164
#define KEY_CREATE &h165
#define KEY_END &h166
#define KEY_EXIT &h167
#define KEY_FIND &h168
#define KEY_HELP &h169
#define KEY_MARK &h16a
#define KEY_MESSAGE &h16b
#define KEY_MOVE &h16c
#define KEY_NEXT &h16d
#define KEY_OPEN &h16e
#define KEY_OPTIONS &h16f
#define KEY_PREVIOUS &h170
#define KEY_REDO &h171
#define KEY_REFERENCE &h172
#define KEY_REFRESH &h173
#define KEY_REPLACE &h174
#define KEY_RESTART &h175
#define KEY_RESUME &h176
#define KEY_SAVE &h177
#define KEY_SBEG &h178
#define KEY_SCANCEL &h179
#define KEY_SCOMMAND &h17a
#define KEY_SCOPY &h17b
#define KEY_SCREATE &h17c
#define KEY_SDC &h17d
#define KEY_SDL &h17e
#define KEY_SELECT &h17f
#define KEY_SEND &h180
#define KEY_SEOL &h181
#define KEY_SEXIT &h182
#define KEY_SFIND &h183
#define KEY_SHOME &h184
#define KEY_SIC &h185
#define KEY_SLEFT &h187
#define KEY_SMESSAGE &h188
#define KEY_SMOVE &h189
#define KEY_SNEXT &h18a
#define KEY_SOPTIONS &h18b
#define KEY_SPREVIOUS &h18c
#define KEY_SPRINT &h18d
#define KEY_SREDO &h18e
#define KEY_SREPLACE &h18f
#define KEY_SRIGHT &h190
#define KEY_SRSUME &h191
#define KEY_SSAVE &h192
#define KEY_SSUSPEND &h193
#define KEY_SUNDO &h194
#define KEY_SUSPEND &h195
#define KEY_UNDO &h196
#define ALT_0 &h197
#define ALT_1 &h198
#define ALT_2 &h199
#define ALT_3 &h19a
#define ALT_4 &h19b
#define ALT_5 &h19c
#define ALT_6 &h19d
#define ALT_7 &h19e
#define ALT_8 &h19f
#define ALT_9 &h1a0
#define ALT_A &h1a1
#define ALT_B &h1a2
#define ALT_C &h1a3
#define ALT_D &h1a4
#define ALT_E &h1a5
#define ALT_F &h1a6
#define ALT_G &h1a7
#define ALT_H &h1a8
#define ALT_I &h1a9
#define ALT_J &h1aa
#define ALT_K &h1ab
#define ALT_L &h1ac
#define ALT_M &h1ad
#define ALT_N &h1ae
#define ALT_O &h1af
#define ALT_P &h1b0
#define ALT_Q &h1b1
#define ALT_R &h1b2
#define ALT_S &h1b3
#define ALT_T &h1b4
#define ALT_U &h1b5
#define ALT_V &h1b6
#define ALT_W &h1b7
#define ALT_X &h1b8
#define ALT_Y &h1b9
#define ALT_Z &h1ba
#define CTL_LEFT &h1bb
#define CTL_RIGHT &h1bc
#define CTL_PGUP &h1bd
#define CTL_PGDN &h1be
#define CTL_HOME &h1bf
#define CTL_END &h1c0
#define KEY_A1 &h1c1
#define KEY_A2 &h1c2
#define KEY_A3 &h1c3
#define KEY_B1 &h1c4
#define KEY_B2 &h1c5
#define KEY_B3 &h1c6
#define KEY_C1 &h1c7
#define KEY_C2 &h1c8
#define KEY_C3 &h1c9
#define PADSLASH &h1ca
#define PADENTER &h1cb
#define CTL_PADENTER &h1cc
#define ALT_PADENTER &h1cd
#define PADSTOP &h1ce
#define PADSTAR &h1cf
#define PADMINUS &h1d0
#define PADPLUS &h1d1
#define CTL_PADSTOP &h1d2
#define CTL_PADCENTER &h1d3
#define CTL_PADPLUS &h1d4
#define CTL_PADMINUS &h1d5
#define CTL_PADSLASH &h1d6
#define CTL_PADSTAR &h1d7
#define ALT_PADPLUS &h1d8
#define ALT_PADMINUS &h1d9
#define ALT_PADSLASH &h1da
#define ALT_PADSTAR &h1db
#define ALT_PADSTOP &h1dc
#define CTL_INS &h1dd
#define ALT_DEL &h1de
#define ALT_INS &h1df
#define CTL_UP &h1e0
#define CTL_DOWN &h1e1
#define CTL_TAB &h1e2
#define ALT_TAB &h1e3
#define ALT_MINUS &h1e4
#define ALT_EQUAL &h1e5
#define ALT_HOME &h1e6
#define ALT_PGUP &h1e7
#define ALT_PGDN &h1e8
#define ALT_END &h1e9
#define ALT_UP &h1ea
#define ALT_DOWN &h1eb
#define ALT_RIGHT &h1ec
#define ALT_LEFT &h1ed
#define ALT_ENTER &h1ee
#define ALT_ESC &h1ef
#define ALT_BQUOTE &h1f0
#define ALT_LBRACKET &h1f1
#define ALT_RBRACKET &h1f2
#define ALT_SEMICOLON &h1f3
#define ALT_FQUOTE &h1f4
#define ALT_COMMA &h1f5
#define ALT_STOP &h1f6
#define ALT_FSLASH &h1f7
#define ALT_BKSP &h1f8
#define CTL_BKSP &h1f9
#define PAD0 &h1fa
#define CTL_PAD0 &h1fb
#define CTL_PAD1 &h1fc
#define CTL_PAD2 &h1fd
#define CTL_PAD3 &h1fe
#define CTL_PAD4 &h1ff
#define CTL_PAD5 &h200
#define CTL_PAD6 &h201
#define CTL_PAD7 &h202
#define CTL_PAD8 &h203
#define CTL_PAD9 &h204
#define ALT_PAD0 &h205
#define ALT_PAD1 &h206
#define ALT_PAD2 &h207
#define ALT_PAD3 &h208
#define ALT_PAD4 &h209
#define ALT_PAD5 &h20a
#define ALT_PAD6 &h2&b
#define ALT_PAD7 &h20c
#define ALT_PAD8 &h20d
#define ALT_PAD9 &h20e
#define CTL_DEL &h20f
#define ALT_BSLASH &h210
#define CTL_ENTER &h211
#define SHF_PADENTER &h212
#define SHF_PADSLASH &h213
#define SHF_PADSTAR &h214
#define SHF_PADPLUS &h215
#define SHF_PADMINUS &h216
#define SHF_UP &h217
#define SHF_DOWN &h218
#define SHF_IC &h219
#define SHF_DC &h21a
#define KEY_MOUSE &h21b
#define KEY_SHIFT_L &h21c
#define KEY_SHIFT_R &h21d
#define KEY_CONTROL_L &h21e
#define KEY_CONTROL_R &h21f
#define KEY_ALT_L &h220
#define KEY_ALT_R &h221
#define KEY_RESIZE &h222
#define KEY_SUP &h223
#define KEY_SDOWN &h224
#define KEY_MIN &h101
#define KEY_MAX &h224

extern "C"

declare function addch(byval as chtype) as integer
declare function addchnstr(byval as chtype ptr, byval as integer) as integer
declare function addchstr(byval as chtype ptr) as integer
declare function addnstr(byval as zstring ptr, byval as integer) as integer
declare function addstr(byval as zstring ptr) as integer
declare function attroff(byval as chtype) as integer
declare function attron(byval as chtype) as integer
declare function attrset(byval as chtype) as integer
declare function attr_get(byval as attr_t ptr, byval as short ptr, byval as any ptr) as integer
declare function attr_off(byval as attr_t, byval as any ptr) as integer
declare function attr_on(byval as attr_t, byval as any ptr) as integer
declare function attr_set(byval as attr_t, byval as short, byval as any ptr) as integer
declare function baudrate() as integer
declare function beep() as integer
declare function bkgd(byval as chtype) as integer
declare sub bkgdset(byval as chtype)
declare function border(byval as chtype, byval as chtype, byval as chtype, byval as chtype, byval as chtype, byval as chtype, byval as chtype, byval as chtype) as integer
declare function box(byval as WINDOW ptr, byval as chtype, byval as chtype) as integer
declare function can_change_color() as integer
declare function cbreak() as integer
declare function chgat(byval as integer, byval as attr_t, byval as short, byval as any ptr) as integer
declare function clearok(byval as WINDOW ptr, byval as integer) as integer
declare function clear() as integer
declare function clrtobot() as integer
declare function clrtoeol() as integer
declare function color_content(byval as short, byval as short ptr, byval as short ptr, byval as short ptr) as integer
declare function color_set(byval as short, byval as any ptr) as integer
declare function copywin(byval as WINDOW ptr, byval as WINDOW ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer) as integer
declare function curs_set(byval as integer) as integer
declare function def_prog_mode() as integer
declare function def_shell_mode() as integer
declare function delay_output(byval as integer) as integer
declare function delch() as integer
declare function deleteln() as integer
declare sub delscreen(byval as SCREEN ptr)
declare function delwin(byval as WINDOW ptr) as integer
declare function derwin(byval as WINDOW ptr, byval as integer, byval as integer, byval as integer, byval as integer) as WINDOW ptr
declare function doupdate() as integer
declare function dupwin(byval as WINDOW ptr) as WINDOW ptr
declare function echochar(byval as chtype) as integer
declare function echo() as integer
declare function endwin() as integer
declare function erasechar() as byte
declare function erase() as integer
declare sub filter()
declare function flash() as integer
declare function flushinp() as integer
declare function getbkgd(byval as WINDOW ptr) as chtype
declare function getnstr(byval as zstring ptr, byval as integer) as integer
declare function getstr(byval as zstring ptr) as integer
declare function getwin(byval as FILE ptr) as WINDOW ptr
declare function halfdelay(byval as integer) as integer
declare function has_colors() as integer
declare function has_ic() as integer
declare function has_il() as integer
declare function hline(byval as chtype, byval as integer) as integer
declare sub idcok(byval as WINDOW ptr, byval as integer)
declare function idlok(byval as WINDOW ptr, byval as integer) as integer
declare sub immedok(byval as WINDOW ptr, byval as integer)
declare function inchnstr(byval as chtype ptr, byval as integer) as integer
declare function inchstr(byval as chtype ptr) as integer
declare function inch() as chtype
declare function init_color(byval as short, byval as short, byval as short, byval as short) as integer
declare function init_pair(byval as short, byval as short, byval as short) as integer
declare function initscr() as WINDOW ptr
declare function innstr(byval as zstring ptr, byval as integer) as integer
declare function insch(byval as chtype) as integer
declare function insdelln(byval as integer) as integer
declare function insertln() as integer
declare function insnstr(byval as zstring ptr, byval as integer) as integer
declare function insstr(byval as zstring ptr) as integer
declare function instr(byval as zstring ptr) as integer
declare function intrflush(byval as WINDOW ptr, byval as integer) as integer
declare function isendwin() as integer
declare function is_linetouched(byval as WINDOW ptr, byval as integer) as integer
declare function is_wintouched(byval as WINDOW ptr) as integer
declare function keyname(byval as integer) as zstring ptr
declare function keypad(byval as WINDOW ptr, byval as integer) as integer
declare function killchar() as byte
declare function leaveok(byval as WINDOW ptr, byval as integer) as integer
declare function longname() as zstring ptr
declare function meta(byval as WINDOW ptr, byval as integer) as integer
declare function move(byval as integer, byval as integer) as integer
declare function mvaddch(byval as integer, byval as integer, byval as chtype) as integer
declare function mvaddchnstr(byval as integer, byval as integer, byval as chtype ptr, byval as integer) as integer
declare function mvaddchstr(byval as integer, byval as integer, byval as chtype ptr) as integer
declare function mvaddnstr(byval as integer, byval as integer, byval as zstring ptr, byval as integer) as integer
declare function mvaddstr(byval as integer, byval as integer, byval as zstring ptr) as integer
declare function mvchgat(byval as integer, byval as integer, byval as integer, byval as attr_t, byval as short, byval as any ptr) as integer
declare function mvcur(byval as integer, byval as integer, byval as integer, byval as integer) as integer
declare function mvdelch(byval as integer, byval as integer) as integer
declare function mvderwin(byval as WINDOW ptr, byval as integer, byval as integer) as integer
declare function mvgetch(byval as integer, byval as integer) as integer
declare function mvgetnstr(byval as integer, byval as integer, byval as zstring ptr, byval as integer) as integer
declare function mvgetstr(byval as integer, byval as integer, byval as zstring ptr) as integer
declare function mvhline(byval as integer, byval as integer, byval as chtype, byval as integer) as integer
declare function mvinch(byval as integer, byval as integer) as chtype
declare function mvinchnstr(byval as integer, byval as integer, byval as chtype ptr, byval as integer) as integer
declare function mvinchstr(byval as integer, byval as integer, byval as chtype ptr) as integer
declare function mvinnstr(byval as integer, byval as integer, byval as zstring ptr, byval as integer) as integer
declare function mvinsch(byval as integer, byval as integer, byval as chtype) as integer
declare function mvinsnstr(byval as integer, byval as integer, byval as zstring ptr, byval as integer) as integer
declare function mvinsstr(byval as integer, byval as integer, byval as zstring ptr) as integer
declare function mvinstr(byval as integer, byval as integer, byval as zstring ptr) as integer
declare function mvprintw(byval as integer, byval as integer, byval as zstring ptr, ...) as integer
declare function mvscanw(byval as integer, byval as integer, byval as zstring ptr, ...) as integer
declare function mvvline(byval as integer, byval as integer, byval as chtype, byval as integer) as integer
declare function mvwaddchnstr(byval as WINDOW ptr, byval as integer, byval as integer, byval as chtype ptr, byval as integer) as integer
declare function mvwaddchstr(byval as WINDOW ptr, byval as integer, byval as integer, byval as chtype ptr) as integer
declare function mvwaddch(byval as WINDOW ptr, byval as integer, byval as integer, byval as chtype) as integer
declare function mvwaddnstr(byval as WINDOW ptr, byval as integer, byval as integer, byval as zstring ptr, byval as integer) as integer
declare function mvwaddstr(byval as WINDOW ptr, byval as integer, byval as integer, byval as zstring ptr) as integer
declare function mvwchgat(byval as WINDOW ptr, byval as integer, byval as integer, byval as integer, byval as attr_t, byval as short, byval as any ptr) as integer
declare function mvwdelch(byval as WINDOW ptr, byval as integer, byval as integer) as integer
declare function mvwgetch(byval as WINDOW ptr, byval as integer, byval as integer) as integer
declare function mvwgetnstr(byval as WINDOW ptr, byval as integer, byval as integer, byval as zstring ptr, byval as integer) as integer
declare function mvwgetstr(byval as WINDOW ptr, byval as integer, byval as integer, byval as zstring ptr) as integer
declare function mvwhline(byval as WINDOW ptr, byval as integer, byval as integer, byval as chtype, byval as integer) as integer
declare function mvwinchnstr(byval as WINDOW ptr, byval as integer, byval as integer, byval as chtype ptr, byval as integer) as integer
declare function mvwinchstr(byval as WINDOW ptr, byval as integer, byval as integer, byval as chtype ptr) as integer
declare function mvwinch(byval as WINDOW ptr, byval as integer, byval as integer) as chtype
declare function mvwinnstr(byval as WINDOW ptr, byval as integer, byval as integer, byval as zstring ptr, byval as integer) as integer
declare function mvwinsch(byval as WINDOW ptr, byval as integer, byval as integer, byval as chtype) as integer
declare function mvwinsnstr(byval as WINDOW ptr, byval as integer, byval as integer, byval as zstring ptr, byval as integer) as integer
declare function mvwinsstr(byval as WINDOW ptr, byval as integer, byval as integer, byval as zstring ptr) as integer
declare function mvwinstr(byval as WINDOW ptr, byval as integer, byval as integer, byval as zstring ptr) as integer
declare function mvwin(byval as WINDOW ptr, byval as integer, byval as integer) as integer
declare function mvwprintw(byval as WINDOW ptr, byval as integer, byval as integer, byval as zstring ptr, ...) as integer
declare function mvwscanw(byval as WINDOW ptr, byval as integer, byval as integer, byval as zstring ptr, ...) as integer
declare function mvwvline(byval as WINDOW ptr, byval as integer, byval as integer, byval as chtype, byval as integer) as integer
declare function napms(byval as integer) as integer
declare function newpad(byval as integer, byval as integer) as WINDOW ptr
declare function newterm(byval as zstring ptr, byval as FILE ptr, byval as FILE ptr) as SCREEN ptr
declare function newwin(byval as integer, byval as integer, byval as integer, byval as integer) as WINDOW ptr
declare function nl() as integer
declare function nocbreak() as integer
declare function nodelay(byval as WINDOW ptr, byval as integer) as integer
declare function noecho() as integer
declare function nonl() as integer
declare sub noqiflush()
declare function noraw() as integer
declare function notimeout(byval as WINDOW ptr, byval as integer) as integer
declare function overlay(byval as WINDOW ptr, byval as WINDOW ptr) as integer
declare function overwrite(byval as WINDOW ptr, byval as WINDOW ptr) as integer
declare function pair_content(byval as short, byval as short ptr, byval as short ptr) as integer
declare function pechochar(byval as WINDOW ptr, byval as chtype) as integer
declare function pnoutrefresh(byval as WINDOW ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer) as integer
declare function prefresh(byval as WINDOW ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer) as integer
declare function printw(byval as zstring ptr, ...) as integer
declare function putwin(byval as WINDOW ptr, byval as FILE ptr) as integer
declare sub qiflush()
declare function raw() as integer
declare function redrawwin(byval as WINDOW ptr) as integer
declare function refresh() as integer
declare function reset_prog_mode() as integer
declare function reset_shell_mode() as integer
declare function resetty() as integer
declare function ripoffline(byval as integer, byval as function cdecl(byval as WINDOW ptr, byval as integer) as integer) as integer
declare function savetty() as integer
declare function scanw(byval as zstring ptr, ...) as integer
declare function scr_dump(byval as zstring ptr) as integer
declare function scr_init(byval as zstring ptr) as integer
declare function scr_restore(byval as zstring ptr) as integer
declare function scr_set(byval as zstring ptr) as integer
declare function scrl(byval as integer) as integer
declare function scroll(byval as WINDOW ptr) as integer
declare function scrollok(byval as WINDOW ptr, byval as integer) as integer
declare function set_term(byval as SCREEN ptr) as SCREEN ptr
declare function setscrreg(byval as integer, byval as integer) as integer
declare function slk_attroff(byval as chtype) as integer
declare function slk_attr_off(byval as attr_t, byval as any ptr) as integer
declare function slk_attron(byval as chtype) as integer
declare function slk_attr_on(byval as attr_t, byval as any ptr) as integer
declare function slk_attrset(byval as chtype) as integer
declare function slk_attr_set(byval as attr_t, byval as short, byval as any ptr) as integer
declare function slk_clear() as integer
declare function slk_color(byval as short) as integer
declare function slk_init(byval as integer) as integer
declare function slk_label(byval as integer) as zstring ptr
declare function slk_noutrefresh() as integer
declare function slk_refresh() as integer
declare function slk_restore() as integer
declare function slk_set(byval as integer, byval as zstring ptr, byval as integer) as integer
declare function slk_touch() as integer
declare function standend() as integer
declare function standout() as integer
declare function start_color() as integer
declare function subpad(byval as WINDOW ptr, byval as integer, byval as integer, byval as integer, byval as integer) as WINDOW ptr
declare function subwin(byval as WINDOW ptr, byval as integer, byval as integer, byval as integer, byval as integer) as WINDOW ptr
declare function syncok(byval as WINDOW ptr, byval as integer) as integer
declare function termattrs() as chtype
declare function term_attrs() as attr_t
declare function termname() as zstring ptr
declare sub timeout(byval as integer)
declare function touchline(byval as WINDOW ptr, byval as integer, byval as integer) as integer
declare function touchwin(byval as WINDOW ptr) as integer
declare function typeahead(byval as integer) as integer
declare function untouchwin(byval as WINDOW ptr) as integer
declare sub use_env(byval as integer)
declare function vidattr(byval as chtype) as integer
declare function vid_attr(byval as attr_t, byval as short, byval as any ptr) as integer
declare function vidputs(byval as chtype, byval as function cdecl(byval as integer) as integer) as integer
declare function vid_puts(byval as attr_t, byval as short, byval as any ptr, byval as function cdecl(byval as integer) as integer) as integer
declare function vline(byval as chtype, byval as integer) as integer
declare function vw_printw(byval as WINDOW ptr, byval as zstring ptr, byval as va_list) as integer
declare function vwprintw(byval as WINDOW ptr, byval as zstring ptr, byval as va_list) as integer
declare function vw_scanw(byval as WINDOW ptr, byval as zstring ptr, byval as va_list) as integer
declare function vwscanw(byval as WINDOW ptr, byval as zstring ptr, byval as va_list) as integer
declare function waddchnstr(byval as WINDOW ptr, byval as chtype ptr, byval as integer) as integer
declare function waddchstr(byval as WINDOW ptr, byval as chtype ptr) as integer
declare function waddch(byval as WINDOW ptr, byval as chtype) as integer
declare function waddnstr(byval as WINDOW ptr, byval as zstring ptr, byval as integer) as integer
declare function waddstr(byval as WINDOW ptr, byval as zstring ptr) as integer
declare function wattroff(byval as WINDOW ptr, byval as chtype) as integer
declare function wattron(byval as WINDOW ptr, byval as chtype) as integer
declare function wattrset(byval as WINDOW ptr, byval as chtype) as integer
declare function wattr_get(byval as WINDOW ptr, byval as attr_t ptr, byval as short ptr, byval as any ptr) as integer
declare function wattr_off(byval as WINDOW ptr, byval as attr_t, byval as any ptr) as integer
declare function wattr_on(byval as WINDOW ptr, byval as attr_t, byval as any ptr) as integer
declare function wattr_set(byval as WINDOW ptr, byval as attr_t, byval as short, byval as any ptr) as integer
declare sub wbkgdset(byval as WINDOW ptr, byval as chtype)
declare function wbkgd(byval as WINDOW ptr, byval as chtype) as integer
declare function wborder(byval as WINDOW ptr, byval as chtype, byval as chtype, byval as chtype, byval as chtype, byval as chtype, byval as chtype, byval as chtype, byval as chtype) as integer
declare function wchgat(byval as WINDOW ptr, byval as integer, byval as attr_t, byval as short, byval as any ptr) as integer
declare function wclear(byval as WINDOW ptr) as integer
declare function wclrtobot(byval as WINDOW ptr) as integer
declare function wclrtoeol(byval as WINDOW ptr) as integer
declare function wcolor_set(byval as WINDOW ptr, byval as short, byval as any ptr) as integer
declare sub wcursyncup(byval as WINDOW ptr)
declare function wdelch(byval as WINDOW ptr) as integer
declare function wdeleteln(byval as WINDOW ptr) as integer
declare function wechochar(byval as WINDOW ptr, byval as chtype) as integer
declare function werase(byval as WINDOW ptr) as integer
declare function wgetch(byval as WINDOW ptr) as integer
declare function wgetnstr(byval as WINDOW ptr, byval as zstring ptr, byval as integer) as integer
declare function wgetstr(byval as WINDOW ptr, byval as zstring ptr) as integer
declare function whline(byval as WINDOW ptr, byval as chtype, byval as integer) as integer
declare function winchnstr(byval as WINDOW ptr, byval as chtype ptr, byval as integer) as integer
declare function winchstr(byval as WINDOW ptr, byval as chtype ptr) as integer
declare function winch(byval as WINDOW ptr) as chtype
declare function winnstr(byval as WINDOW ptr, byval as zstring ptr, byval as integer) as integer
declare function winsch(byval as WINDOW ptr, byval as chtype) as integer
declare function winsdelln(byval as WINDOW ptr, byval as integer) as integer
declare function winsertln(byval as WINDOW ptr) as integer
declare function winsnstr(byval as WINDOW ptr, byval as zstring ptr, byval as integer) as integer
declare function winsstr(byval as WINDOW ptr, byval as zstring ptr) as integer
declare function winstr(byval as WINDOW ptr, byval as zstring ptr) as integer
declare function wmove(byval as WINDOW ptr, byval as integer, byval as integer) as integer
declare function wnoutrefresh(byval as WINDOW ptr) as integer
declare function wprintw(byval as WINDOW ptr, byval as zstring ptr, ...) as integer
declare function wredrawln(byval as WINDOW ptr, byval as integer, byval as integer) as integer
declare function wrefresh(byval as WINDOW ptr) as integer
declare function wscanw(byval as WINDOW ptr, byval as zstring ptr, ...) as integer
declare function wscrl(byval as WINDOW ptr, byval as integer) as integer
declare function wsetscrreg(byval as WINDOW ptr, byval as integer, byval as integer) as integer
declare function wstandend(byval as WINDOW ptr) as integer
declare function wstandout(byval as WINDOW ptr) as integer
declare sub wsyncdown(byval as WINDOW ptr)
declare sub wsyncup(byval as WINDOW ptr)
declare sub wtimeout(byval as WINDOW ptr, byval as integer)
declare function wtouchln(byval as WINDOW ptr, byval as integer, byval as integer, byval as integer) as integer
declare function wvline(byval as WINDOW ptr, byval as chtype, byval as integer) as integer
declare function addnwstr(byval as wchar_t ptr, byval as integer) as integer
declare function addwstr(byval as wchar_t ptr) as integer
declare function add_wch(byval as cchar_t ptr) as integer
declare function add_wchnstr(byval as cchar_t ptr, byval as integer) as integer
declare function add_wchstr(byval as cchar_t ptr) as integer
declare function border_set(byval as cchar_t ptr, byval as cchar_t ptr, byval as cchar_t ptr, byval as cchar_t ptr, byval as cchar_t ptr, byval as cchar_t ptr, byval as cchar_t ptr, byval as cchar_t ptr) as integer
declare function box_set(byval as WINDOW ptr, byval as cchar_t ptr, byval as cchar_t ptr) as integer
declare function echo_wchar(byval as cchar_t ptr) as integer
declare function erasewchar(byval as wchar_t ptr) as integer
declare function getbkgrnd(byval as cchar_t ptr) as integer
declare function getcchar(byval as cchar_t ptr, byval as wchar_t ptr, byval as attr_t ptr, byval as short ptr, byval as any ptr) as integer
declare function getn_wstr(byval as wint_t ptr, byval as integer) as integer
declare function get_wch(byval as wint_t ptr) as integer
declare function get_wstr(byval as wint_t ptr) as integer
declare function hline_set(byval as cchar_t ptr, byval as integer) as integer
declare function innwstr(byval as wchar_t ptr, byval as integer) as integer
declare function ins_nwstr(byval as wchar_t ptr, byval as integer) as integer
declare function ins_wch(byval as cchar_t ptr) as integer
declare function ins_wstr(byval as wchar_t ptr) as integer
declare function inwstr(byval as wchar_t ptr) as integer
declare function in_wch(byval as cchar_t ptr) as integer
declare function in_wchnstr(byval as cchar_t ptr, byval as integer) as integer
declare function in_wchstr(byval as cchar_t ptr) as integer
declare function key_name(byval as wchar_t) as zstring ptr
declare function killwchar(byval as wchar_t ptr) as integer
declare function mvaddnwstr(byval as integer, byval as integer, byval as wchar_t ptr, byval as integer) as integer
declare function mvaddwstr(byval as integer, byval as integer, byval as wchar_t ptr) as integer
declare function mvadd_wch(byval as integer, byval as integer, byval as cchar_t ptr) as integer
declare function mvadd_wchnstr(byval as integer, byval as integer, byval as cchar_t ptr, byval as integer) as integer
declare function mvadd_wchstr(byval as integer, byval as integer, byval as cchar_t ptr) as integer
declare function mvgetn_wstr(byval as integer, byval as integer, byval as wint_t ptr, byval as integer) as integer
declare function mvget_wch(byval as integer, byval as integer, byval as wint_t ptr) as integer
declare function mvget_wstr(byval as integer, byval as integer, byval as wint_t ptr) as integer
declare function mvhline_set(byval as integer, byval as integer, byval as cchar_t ptr, byval as integer) as integer
declare function mvinnwstr(byval as integer, byval as integer, byval as wchar_t ptr, byval as integer) as integer
declare function mvins_nwstr(byval as integer, byval as integer, byval as wchar_t ptr, byval as integer) as integer
declare function mvins_wch(byval as integer, byval as integer, byval as cchar_t ptr) as integer
declare function mvins_wstr(byval as integer, byval as integer, byval as wchar_t ptr) as integer
declare function mvinwstr(byval as integer, byval as integer, byval as wchar_t ptr) as integer
declare function mvin_wch(byval as integer, byval as integer, byval as cchar_t ptr) as integer
declare function mvin_wchnstr(byval as integer, byval as integer, byval as cchar_t ptr, byval as integer) as integer
declare function mvin_wchstr(byval as integer, byval as integer, byval as cchar_t ptr) as integer
declare function mvvline_set(byval as integer, byval as integer, byval as cchar_t ptr, byval as integer) as integer
declare function mvwaddnwstr(byval as WINDOW ptr, byval as integer, byval as integer, byval as wchar_t ptr, byval as integer) as integer
declare function mvwaddwstr(byval as WINDOW ptr, byval as integer, byval as integer, byval as wchar_t ptr) as integer
declare function mvwadd_wch(byval as WINDOW ptr, byval as integer, byval as integer, byval as cchar_t ptr) as integer
declare function mvwadd_wchnstr(byval as WINDOW ptr, byval as integer, byval as integer, byval as cchar_t ptr, byval as integer) as integer
declare function mvwadd_wchstr(byval as WINDOW ptr, byval as integer, byval as integer, byval as cchar_t ptr) as integer
declare function mvwgetn_wstr(byval as WINDOW ptr, byval as integer, byval as integer, byval as wint_t ptr, byval as integer) as integer
declare function mvwget_wch(byval as WINDOW ptr, byval as integer, byval as integer, byval as wint_t ptr) as integer
declare function mvwget_wstr(byval as WINDOW ptr, byval as integer, byval as integer, byval as wint_t ptr) as integer
declare function mvwhline_set(byval as WINDOW ptr, byval as integer, byval as integer, byval as cchar_t ptr, byval as integer) as integer
declare function mvwinnwstr(byval as WINDOW ptr, byval as integer, byval as integer, byval as wchar_t ptr, byval as integer) as integer
declare function mvwins_nwstr(byval as WINDOW ptr, byval as integer, byval as integer, byval as wchar_t ptr, byval as integer) as integer
declare function mvwins_wch(byval as WINDOW ptr, byval as integer, byval as integer, byval as cchar_t ptr) as integer
declare function mvwins_wstr(byval as WINDOW ptr, byval as integer, byval as integer, byval as wchar_t ptr) as integer
declare function mvwin_wch(byval as WINDOW ptr, byval as integer, byval as integer, byval as cchar_t ptr) as integer
declare function mvwin_wchnstr(byval as WINDOW ptr, byval as integer, byval as integer, byval as cchar_t ptr, byval as integer) as integer
declare function mvwin_wchstr(byval as WINDOW ptr, byval as integer, byval as integer, byval as cchar_t ptr) as integer
declare function mvwinwstr(byval as WINDOW ptr, byval as integer, byval as integer, byval as wchar_t ptr) as integer
declare function mvwvline_set(byval as WINDOW ptr, byval as integer, byval as integer, byval as cchar_t ptr, byval as integer) as integer
declare function pecho_wchar(byval as WINDOW ptr, byval as cchar_t ptr) as integer
declare function setcchar(byval as cchar_t ptr, byval as wchar_t ptr, byval as attr_t, byval as short, byval as any ptr) as integer
declare function slk_wset(byval as integer, byval as wchar_t ptr, byval as integer) as integer
declare function unget_wch(byval as wchar_t) as integer
declare function vline_set(byval as cchar_t ptr, byval as integer) as integer
declare function waddnwstr(byval as WINDOW ptr, byval as wchar_t ptr, byval as integer) as integer
declare function waddwstr(byval as WINDOW ptr, byval as wchar_t ptr) as integer
declare function wadd_wch(byval as WINDOW ptr, byval as cchar_t ptr) as integer
declare function wadd_wchnstr(byval as WINDOW ptr, byval as cchar_t ptr, byval as integer) as integer
declare function wadd_wchstr(byval as WINDOW ptr, byval as cchar_t ptr) as integer
declare function wbkgrnd(byval as WINDOW ptr, byval as cchar_t ptr) as integer
declare sub wbkgrndset(byval as WINDOW ptr, byval as cchar_t ptr)
declare function wborder_set(byval as WINDOW ptr, byval as cchar_t ptr, byval as cchar_t ptr, byval as cchar_t ptr, byval as cchar_t ptr, byval as cchar_t ptr, byval as cchar_t ptr, byval as cchar_t ptr, byval as cchar_t ptr) as integer
declare function wecho_wchar(byval as WINDOW ptr, byval as cchar_t ptr) as integer
declare function wgetbkgrnd(byval as WINDOW ptr, byval as cchar_t ptr) as integer
declare function wgetn_wstr(byval as WINDOW ptr, byval as wint_t ptr, byval as integer) as integer
declare function wget_wch(byval as WINDOW ptr, byval as wint_t ptr) as integer
declare function wget_wstr(byval as WINDOW ptr, byval as wint_t ptr) as integer
declare function whline_set(byval as WINDOW ptr, byval as cchar_t ptr, byval as integer) as integer
declare function winnwstr(byval as WINDOW ptr, byval as wchar_t ptr, byval as integer) as integer
declare function wins_nwstr(byval as WINDOW ptr, byval as wchar_t ptr, byval as integer) as integer
declare function wins_wch(byval as WINDOW ptr, byval as cchar_t ptr) as integer
declare function wins_wstr(byval as WINDOW ptr, byval as wchar_t ptr) as integer
declare function winwstr(byval as WINDOW ptr, byval as wchar_t ptr) as integer
declare function win_wch(byval as WINDOW ptr, byval as cchar_t ptr) as integer
declare function win_wchnstr(byval as WINDOW ptr, byval as cchar_t ptr, byval as integer) as integer
declare function win_wchstr(byval as WINDOW ptr, byval as cchar_t ptr) as integer
declare function wunctrl(byval as cchar_t ptr) as wchar_t ptr
declare function wvline_set(byval as WINDOW ptr, byval as cchar_t ptr, byval as integer) as integer
declare function getattrs(byval as WINDOW ptr) as chtype
declare function getbegx(byval as WINDOW ptr) as integer
declare function getbegy(byval as WINDOW ptr) as integer
declare function getmaxx(byval as WINDOW ptr) as integer
declare function getmaxy(byval as WINDOW ptr) as integer
declare function getparx(byval as WINDOW ptr) as integer
declare function getpary(byval as WINDOW ptr) as integer
declare function getcurx(byval as WINDOW ptr) as integer
declare function getcury(byval as WINDOW ptr) as integer
declare sub traceoff()
declare sub traceon()
declare function unctrl(byval as chtype) as zstring ptr
declare function crmode() as integer
declare function nocrmode() as integer
declare function draino(byval as integer) as integer
declare function resetterm() as integer
declare function fixterm() as integer
declare function saveterm() as integer
declare function setsyx(byval as integer, byval as integer) as integer
declare function mouse_set(byval as uinteger) as integer
declare function mouse_on(byval as uinteger) as integer
declare function mouse_off(byval as uinteger) as integer
declare function request_mouse_pos() as integer
declare function map_button(byval as uinteger) as integer
declare sub wmouse_position(byval as WINDOW ptr, byval as integer ptr, byval as integer ptr)
declare function getmouse() as uinteger
declare function getbmap() as uinteger
declare function assume_default_colors(byval as integer, byval as integer) as integer
declare function curses_version() as zstring ptr
declare function has_key(byval as integer) as integer
declare function use_default_colors() as integer
declare function wresize(byval as WINDOW ptr, byval as integer, byval as integer) as integer
declare function mouseinterval(byval as integer) as integer
declare function mousemask(byval as mmask_t, byval as mmask_t ptr) as mmask_t
declare function mouse_trafo(byval as integer ptr, byval as integer ptr, byval as integer) as integer
declare function nc_getmouse(byval as MEVENT ptr) as integer
declare function ungetmouse(byval as MEVENT ptr) as integer
declare function wenclose(byval as WINDOW ptr, byval as integer, byval as integer) as integer
declare function wmouse_trafo(byval as WINDOW ptr, byval as integer ptr, byval as integer ptr, byval as integer) as integer
declare function addrawch(byval as chtype) as integer
declare function insrawch(byval as chtype) as integer
declare function is_termresized() as integer
declare function mvaddrawch(byval as integer, byval as integer, byval as chtype) as integer
declare function mvdeleteln(byval as integer, byval as integer) as integer
declare function mvinsertln(byval as integer, byval as integer) as integer
declare function mvinsrawch(byval as integer, byval as integer, byval as chtype) as integer
declare function mvwaddrawch(byval as WINDOW ptr, byval as integer, byval as integer, byval as chtype) as integer
declare function mvwdeleteln(byval as WINDOW ptr, byval as integer, byval as integer) as integer
declare function mvwinsertln(byval as WINDOW ptr, byval as integer, byval as integer) as integer
declare function mvwinsrawch(byval as WINDOW ptr, byval as integer, byval as integer, byval as chtype) as integer
declare function raw_output(byval as integer) as integer
declare function resize_term(byval as integer, byval as integer) as integer
declare function resize_window(byval as WINDOW ptr, byval as integer, byval as integer) as WINDOW ptr
declare function waddrawch(byval as WINDOW ptr, byval as chtype) as integer
declare function winsrawch(byval as WINDOW ptr, byval as chtype) as integer
declare function wordchar() as byte
declare function slk_wlabel(byval as integer) as wchar_t ptr
declare sub PDC_debug(byval as zstring ptr, ...)
declare function PDC_ungetch(byval as integer) as integer
declare function PDC_set_blink(byval as integer) as integer
declare function PDC_set_line_color(byval as short) as integer
declare sub PDC_set_title(byval as zstring ptr)
declare function PDC_clearclipboard() as integer
declare function PDC_freeclipboard(byval as zstring ptr) as integer
declare function PDC_getclipboard(byval as byte ptr ptr, byval as integer ptr) as integer
declare function PDC_setclipboard(byval as zstring ptr, byval as integer) as integer
declare function PDC_get_input_fd() as uinteger
declare function PDC_get_key_modifiers() as uinteger
declare function PDC_return_key_modifiers(byval as integer) as integer
declare function PDC_save_key_modifiers(byval as integer) as integer

end extern

#define PDC_CLIP_SUCCESS 0
#define PDC_CLIP_ACCESS_ERROR 1
#define PDC_CLIP_EMPTY 2
#define PDC_CLIP_MEMORY_ERROR 3
#define PDC_KEY_MODIFIER_SHIFT 1
#define PDC_KEY_MODIFIER_CONTROL 2
#define PDC_KEY_MODIFIER_ALT 4
#define PDC_KEY_MODIFIER_NUMLOCK 8

#define addchstr( c ) addchnstr( c, -1 )
#define addstr(s) waddstr( stdscr, s )
#define addnstr(s, n) waddnstr( stdscr, s, n )
#define attroff(attr) wattroff( stdscr, attr )
#define attron(attr) wattron( stdscr, attr )
#define attrset(attr) wattrset( stdscr, attr )
#define bkgd(c) wbkgd(stdscr,c)
#define bkgdset(c) wbkgdset(stdscr,c)
''''''' #define border(ls,rs,ts,bs,tl,tr,bl,br) wborder(stdscr,ls,rs,ts,bs,tl,tr,bl,br)
#define box( w, v, h ) wborder( w, v, v, h, h, 0, 0, 0, 0 )
#define clear_() wclear( stdscr )
#define clrtobot() wclrtobot( stdscr )
#define clrtoeol() wclrtoeol( stdscr )
#define delch() wdelch( stdscr )
#define deleteln() wdeleteln( stdscr )
''''''' #define derwin(w,nl,nc,by,bx) subwin(w,nl,nc,by+w->_begy,bx+w->_begx)
#define draino(ms) delay_output(ms)
#define echochar(c) addch(iif(c = PDC_ERR, PDC_ERR, refresh()) )
''''''' #define erase_() werase( stdscr )
#define fixterm() reset_prog_mode()
#define getbegx(w) w->_begx
#define getbegy(w) w->_begy
#define getbegyx(w,y,x) y = w->_begy: x = w->_begx
#define getbkgd(w) w->_bkgd
#define getch() wgetch(stdscr)
#define getmaxx(w) w->_maxx
#define getmaxy(w) w->_maxy
#define getmaxyx(w,y,x) y = w->_maxy: x = w->_maxx
#define getparx(w) w->_parx
#define getpary(w) w->_pary
#define getparyx(w,y,x) y = w->_pary: x = w->_parx
#define getstr(s) wgetstr( stdscr, s )
#define getnstr(s,num) wgetnstr( stdscr, s, num )
''''''' #define getsyx(y,x) if( curscr->_leaveit ) then y= -1: x= -1 else getyx(curscr,y,x) end if
#define getyx(w,y,x) y = w->_cury: x = w->_curx
''''''' #define has_colors() iif( SP->mono, FALSE, TRUE )
#define idcok(w,flag) PDC_OK
#define idlok(w,flag) PDC_OK
#define inch() stdscr->_y[stdscr->_cury][stdscr->_curx]
#define inchstr( c ) inchnstr( c, stdscr->_maxx-stdscr->_curx )
#define innstr(s,n) winnstr(stdscr,s,n)
#define insch( c ) winsch( stdscr, c )
#define insdelln(n) winsdelln(stdscr,n)
#define insertln() winsertln( stdscr )
#define insnstr(s,n) winsnstr(stdscr,s,n)
#define insstr(s) winsnstr(stdscr,s,(-1))
#define instr_(s) winnstr(stdscr,s,stdscr->_maxx)
#define isendwin() iif( SP->alive, FALSE, TRUE )
#define is_termresized() SP->resized
#define keypad(w,flag) w->_use_keypad = flag
#define leaveok(w,flag) w->_leaveit = flag
#define move(y,x) wmove( stdscr, y, x )
#define mvaddch(y,x,c) iif( move( y, x ) = PDC_ERR, PDC_ERR, addch( c ) )
#define mvaddchstr(y,x,c) iif( move( y, x ) = PDC_ERR, PDC_ERR, addchnstr( c, -1 ) )
#define mvaddchnstr(y,x,c,n) iif( move( y, x ) = PDC_ERR, PDC_ERR, addchnstr( c, n ) )
#define mvaddstr(y,x,s) iif( move( y, x ) = PDC_ERR, PDC_ERR, addstr( s ) )
#define mvaddnstr(y,x,s,n) iif( move( y, x ) = PDC_ERR, PDC_ERR, addnstr( s, n ) )
#define mvdelch(y,x) iif( move( y, x ) = PDC_ERR, PDC_ERR, wdelch( stdscr ) )
#define mvgetch(y,x) iif( move( y, x ) = PDC_ERR, PDC_ERR, wgetch(stdscr) )
#define mvgetstr(y,x,s) iif( move( y, x ) = PDC_ERR, PDC_ERR, wgetstr( stdscr, s ) )
#define mvinch(y,x) iif( move( y, x ) = PDC_ERR, PDC_ERR, (stdscr->_y[y][x]) )
#define mvinchstr(y,x,c) iif( move( y, x ) = PDC_ERR, PDC_ERR, inchnstr( c, stdscr->_maxx-stdscr->_curx ) )
#define mvinchnstr(y,x,c,n) iif( move( y, x ) = PDC_ERR, PDC_ERR, inchnstr( c, n ) )
#define mvinsch(y,x,c) iif( move( y, x ) = PDC_ERR, PDC_ERR, winsch( stdscr, c ) )
#define mvinsnstr(y,x,s,n) iif( move( y, x ) = PDC_ERR, PDC_ERR, winsnstr(stdscr,s,n) )
#define mvinsstr(y,x,s) iif( move( y, x ) = PDC_ERR, PDC_ERR, winsnstr(stdscr,s,-1) )
#define mvinstr(y,x,s) iif( move( y, x ) = PDC_ERR, PDC_ERR, winnstr(stdscr,s,stdscr->_maxx) )
#define mvinnstr(y,x,s,n) iif( move( y, x ) = PDC_ERR, PDC_ERR, winnstr(stdscr,s,n) )
#define mvwaddch(w,y,x,c) iif( wmove( w, y, x ) = PDC_ERR, PDC_ERR, waddch( w, c ) )
#define mvwaddchstr(w,y,x,c) iif( wmove( w, y, x ) = PDC_ERR, PDC_ERR, waddchnstr( w, c, -1 ) )
#define mvwaddchnstr(w,y,x,c,n) iif( wmove( w, y, x ) = PDC_ERR, PDC_ERR, waddchnstr( w, c, n ) )
#define mvwaddrawch(w,y,x,c) iif( wmove( w, y, x ) = PDC_ERR, PDC_ERR, waddrawch( w, c ) )
#define mvwaddrawstr(w,y,x,s) iif( wmove( w, y, x ) = PDC_ERR, PDC_ERR, waddrawstr( w, s ) )
#define mvwaddstr(w,y,x,s) iif( wmove( w, y, x ) = PDC_ERR, PDC_ERR, waddstr( w, s ) )
#define mvwdelch(w,y,x) iif( wmove( w, y, x ) = PDC_ERR, PDC_ERR, wdelch( w ) )
#define mvwgetch(w,y,x) iif( wmove( w, y, x ) = PDC_ERR, PDC_ERR, wgetch( w ) )
#define mvwgetstr(w,y,x,s) iif( wmove( w, y, x ) = PDC_ERR, PDC_ERR, wgetstr( w, s ) )
#define mvwinch(w,y,x) iif( wmove( w, y, x ) = PDC_ERR, PDC_ERR, (w->_y[y][x]) )
#define mvwinchstr(w,y,x,c) iif( wmove( w, y, x ) = PDC_ERR, PDC_ERR, winchnstr( w, c, w->_maxx-w->_curx ) )
#define mvwinchnstr(w,y,x,c,n) iif( wmove( w, y, x ) = PDC_ERR, PDC_ERR, winchnstr( w, c, n ) )
#define mvwinsch(w,y,x,c) iif( wmove( w, y, x ) = PDC_ERR, PDC_ERR, winsch( w, c ) )
#define mvwinstr(w,y,x,s) iif( wmove( w, y, x ) = PDC_ERR, PDC_ERR, winnstr(w,s,w->_maxx) )
#define mvwinnstr(w,y,x,s,n) iif( wmove( w, y, x ) = PDC_ERR, PDC_ERR, winnstr(w,s,n) )
#define mvwinsnstr(w,y,x,s,n) iif( wmove( w, y, x ) = PDC_ERR, PDC_ERR, winsnstr(w,s,n) )
#define mvwinsstr(w,y,x,s) iif( wmove( w, y, x ) = PDC_ERR, PDC_ERR, winsnstr(w,s,-1) )
#define napms(ms) delay_output(ms)
#define nl() SP->autocr = TRUE
#define nonl() SP->autocr = FALSE
#define redrawwin(w) wredrawln(w,0,w->_maxy)
''''''' #define refresh() wrefresh( stdscr )
#define resetterm() reset_shell_mode()
#define saveterm() def_prog_mode()
#define scrl(n) wscrl(stdscr,n)
''''''' #define scroll(w) wscrl(w,1)
#define scrollok(w,flag) w->_scroll = flag
#define setscrreg(top, bot) wsetscrreg( stdscr, top, bot )
''''''' #define setsyx(y,x) if( (y)=-1 and (x)=-1) then curscr->_leaveit=TRUE else curscr->_leaveit=FALSE : wmove(curscr,y,x) end if
#define standend() wattrset(stdscr, A_NORMAL)
#define standout() wattrset(stdscr, A_STANDOUT)
#define timeout(n) wtimeout( stdscr, n )
''''''' #define touchline(w,y,n) wtouchln(w,y,n,TRUE)
''''''' #define touchwin(w) wtouchln(w,0,w->_maxy,TRUE)
#define ungetch(ch) PDC_ungetch(ch)
#define untouchwin(w) wtouchln(w,0,w->_maxy,FALSE)
#define waddch(w, c) PDC_chadd( w, c, not SP->raw_out, TRUE )
#define waddchstr(w, c) waddchnstr( w, c, -1 )
''''''' #define werase(w) wmove((w),0,0): wclrtobot(w))
''''''' #define wclear(w) w->_clear = TRUE: werase(w)
#define wechochar(w,c) iif( waddch(w,c) = PDC_ERR, PDC_ERR, wrefresh(w) )
#define winch(w) w->_y[w->_cury][w->_curx]
#define winchstr(w, c) winchnstr( w, c, w->_maxx-w->_curx )
#define winsstr(w,s) winsnstr(w,s,-1)
#define winstr(w,s) winnstr(w,s,w->_maxx)
#define wstandend(w) wattrset(w, A_NORMAL)
#define wstandout(w) wattrset(w, A_STANDOUT)

#endif
