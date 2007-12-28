''
''
'' pdcurses -- header translated with help of SWIG FB wrapper
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

#ifdef __FB_WIN32__
	#inclib "user32"
	#inclib "coldname"
#endif

#ifndef FALSE
	#define FALSE 0
	#define TRUE 1
#endif
#ifndef NULL
	#define NULL 0
#endif

#define __PDCURSES__ 1
#define PDC_BUILD 2601
#define PDCURSES 1
#define XOPEN 1
#define SYSVcurses 1
#define BSDcurses 1
#define CHTYPE_LONG 1
#define PDC_ERR 0
#define PDC_OK 1

type chtype as uinteger
type attr_t as chtype

type FILE_ as FILE

type MOUSE_STATUS
	x as integer
	y as integer
	button(0 to 3-1) as short
	changes as integer
end type

#define MOUSE_X_POS (Mouse_status_.x)
#define MOUSE_Y_POS (Mouse_status_.y)
#define A_BUTTON_CHANGED ((Mouse_status_.changes and 7) <> 0)
#define MOUSE_MOVED ((Mouse_status_.changes and 8) <> 0)
#define MOUSE_POS_REPORT ((Mouse_status_.changes and 16) <> 0)
#define BUTTON_CHANGED(x) ((Mouse_status_.changes and (1 shl ((x) - 1))) <> 0)
#define BUTTON_STATUS(x) (Mouse_status_.button((x)-1))

#define BUTTON_RELEASED &o000
#define BUTTON_PRESSED &o001
#define BUTTON_CLICKED &o002
#define BUTTON_DOUBLE_CLICKED &o003
#define BUTTON_TRIPLE_CLICKED &o004
#define BUTTON_MOVED &o005
#define BUTTON_ACTION_MASK &o007
#define BUTTON_SHIFT &o010
#define BUTTON_CONTROL &o020
#define BUTTON_ALT &o040
#define BUTTON_MODIFIER_MASK &o070
#define BUTTON1_RELEASED &o00000000001
#define BUTTON1_PRESSED &o00000000002
#define BUTTON1_CLICKED &o00000000004
#define BUTTON1_DOUBLE_CLICKED &o00000000010
#define BUTTON1_TRIPLE_CLICKED &o00000000020
#define BUTTON1_MOVED &o00000000020
#define BUTTON2_RELEASED &o00000000040
#define BUTTON2_PRESSED &o00000000100
#define BUTTON2_CLICKED &o00000000200
#define BUTTON2_DOUBLE_CLICKED &o00000000400
#define BUTTON2_TRIPLE_CLICKED &o00000001000
#define BUTTON2_MOVED &o00000001000
#define BUTTON3_RELEASED &o00000002000
#define BUTTON3_PRESSED &o00000004000
#define BUTTON3_CLICKED &o00000010000
#define BUTTON3_DOUBLE_CLICKED &o00000020000
#define BUTTON3_TRIPLE_CLICKED &o00000040000
#define BUTTON3_MOVED &o00000040000
#define BUTTON_MODIFIER_SHIFT &o00000100000
#define BUTTON_MODIFIER_CONTROL &o00000200000
#define BUTTON_MODIFIER_ALT &o00000400000
#define ALL_MOUSE_EVENTS &o00000777777
#define REPORT_MOUSE_POSITION &o00001000000

type WINDOW as _win

type _win
	_cury as integer
	_curx as integer
	_maxy as integer
	_maxx as integer
	_pmaxy as integer
	_pmaxx as integer
	_begy as integer
	_begx as integer
	_lastpy as integer
	_lastpx as integer
	_lastsy1 as integer
	_lastsx1 as integer
	_lastsy2 as integer
	_lastsx2 as integer
	_flags as integer
	_attrs as attr_t
	_bkgd as chtype
	_tabsize as integer
	_clear as integer
	_leaveit as integer
	_scroll as integer
	_nodelay as integer
	_immed as integer
	_sync as integer
	_use_keypad as integer
	_use_idl as integer
	_use_idc as integer
	_y as chtype ptr ptr
	_firstch as integer ptr
	_lastch as integer ptr
	_tmarg as integer
	_bmarg as integer
	_title as zstring ptr
	_title_ofs as byte
	_title_attr as attr_t
	_blank as chtype
	_parx as integer
	_pary as integer
	_parent as _win ptr
end type


type RIPPEDOFFLINE
	line as integer
	init as function cdecl() as integer
end type

type SCREEN
	alive as integer
	autocr as integer
	cbreak as integer
	echo as integer
	raw_inp as integer
	raw_out as integer
	refrbrk as integer
	orgcbr as integer
	visible_cursor as integer
	audible as integer
	full_redraw as integer
	direct_video as integer
	mono as integer
	sizeable as integer
	resized as integer
	bogus_adapter as integer
	shell as integer
	blank as chtype
	orig_attr as attr_t
	cursrow as integer
	curscol as integer
	cursor as integer
	visibility as integer
	video_page as integer
	orig_emulation as integer
	orig_cursor as integer
	font as integer
	orig_font as integer
	lines as integer
	cols as integer
	_trap_mbe as uinteger
	_map_mbe_to_key as uinteger
	slklines as integer
	slk_winptr as WINDOW ptr
	linesrippedoff as integer
	linesrippedoffontop as integer
	delaytenths as integer
	_preserve as integer
	_restore as integer
	save_key_modifiers as integer
	return_key_modifiers as integer
	adapter as integer
	line_color as short
end type

extern LINES alias "LINES" as integer
extern COLS alias "COLS" as integer
extern stdscr alias "stdscr" as WINDOW ptr
extern curscr alias "curscr" as WINDOW ptr
extern SP alias "SP" as SCREEN ptr
extern use_emalloc alias "use_emalloc" as integer
extern Mouse_status_ alias "Mouse_status" as MOUSE_STATUS
extern COLORS alias "COLORS" as integer
extern COLOR_PAIRS alias "COLOR_PAIRS" as integer

#define A_NORMAL &h00000000
#define A_UNDERLINE &h00100000
#define A_REVERSE &h00200000
#define A_BLINK &h00400000
#define A_BOLD &h00800000
#define A_RIGHTLINE &h00010000
#define A_DIM &h00020000
#define A_ALTCHARSET &h00040000
#define A_INVIS &h00080000
#define A_ATTRIBUTES &hFFFF0000
#define A_CHARTEXT &h0000FFFF
#define A_COLOR &hFF000000
#define A_LEFTLINE &h00020000
#define A_ITALIC &h00080000
#define A_STANDOUT (&h00800000 or &h00200000)
#define A_PROTECT (&h00100000 or &h00020000 or &h00010000)

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

#define COLOR_BLACK 0
#define COLOR_BLUE 1
#define COLOR_GREEN 2
#define COLOR_CYAN 3
#define COLOR_RED 4
#define COLOR_MAGENTA 5
#define COLOR_YELLOW 6
#define COLOR_WHITE 7

#define COLOR_PAIR(n) ((n) shl 24)
#define PAIR_NUMBER(n) (((n) and A_COLOR) shr 24)

#define CHR_MSK &h0000FFFF
#define ATR_MSK &hFFFF0000
#define ATR_NRM &h00000000
#define KEY_MIN &h101
#define KEY_BREAK &h101
#define KEY_DOWN &h102
#define KEY_UP &h103
#define KEY_LEFT &h104
#define KEY_RIGHT &h105
#define KEY_HOME &h106
#define KEY_BACKSPACE &h107
#define KEY_F0 &h108
#define KEY_F(n) (KEY_F0+(n))
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
#define KEY_MAX &h224

declare function addchnstr cdecl alias "addchnstr" (byval as chtype ptr, byval as integer) as integer
declare function baudrate cdecl alias "baudrate" () as integer
declare function beep cdecl alias "beep" () as integer
declare function border cdecl alias "border" (byval as chtype, byval as chtype, byval as chtype, byval as chtype, byval as chtype, byval as chtype, byval as chtype, byval as chtype) as integer
declare function can_change_color cdecl alias "can_change_color" () as integer
declare function clearok cdecl alias "clearok" (byval as WINDOW ptr, byval as integer) as integer
declare function color_content cdecl alias "color_content" (byval as short, byval as short ptr, byval as short ptr, byval as short ptr) as integer
declare function copywin cdecl alias "copywin" (byval as WINDOW ptr, byval as WINDOW ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer) as integer
declare function curs_set cdecl alias "curs_set" (byval as integer) as integer
declare function def_prog_mode cdecl alias "def_prog_mode" () as integer
declare function def_shell_mode cdecl alias "def_shell_mode" () as integer
declare function delay_output cdecl alias "delay_output" (byval as integer) as integer
declare function delwin cdecl alias "delwin" (byval as WINDOW ptr) as integer
declare function derwin cdecl alias "derwin" (byval as WINDOW ptr, byval as integer, byval as integer, byval as integer, byval as integer) as WINDOW ptr
declare function doupdate cdecl alias "doupdate" () as integer
declare function dupwin cdecl alias "dupwin" (byval as WINDOW ptr) as WINDOW ptr
declare function endwin cdecl alias "endwin" () as integer
declare function erase_ cdecl alias "erase" () as integer
declare function erasechar cdecl alias "erasechar" () as byte
declare function flash cdecl alias "flash" () as integer
declare function flushinp cdecl alias "flushinp" () as integer
declare function getsyx cdecl alias "getsyx" (byval as integer ptr, byval as integer ptr) as integer
declare function halfdelay cdecl alias "halfdelay" (byval as integer) as integer
declare function has_colors cdecl alias "has_colors" () as integer
declare function hline cdecl alias "hline" (byval as chtype, byval as integer) as integer
declare function immedok cdecl alias "immedok" (byval as WINDOW ptr, byval as integer) as integer
declare function inchnstr cdecl alias "inchnstr" (byval as chtype ptr, byval as integer) as integer
declare function init_color cdecl alias "init_color" (byval as short, byval as short, byval as short, byval as short) as integer
declare function init_pair cdecl alias "init_pair" (byval as short, byval as short, byval as short) as integer
declare function initscr cdecl alias "initscr" () as WINDOW ptr
declare function intrflush cdecl alias "intrflush" (byval as WINDOW ptr, byval as integer) as integer
declare function is_linetouched cdecl alias "is_linetouched" (byval as WINDOW ptr, byval as integer) as integer
declare function is_wintouched cdecl alias "is_wintouched" (byval as WINDOW ptr) as integer
declare function keyname cdecl alias "keyname" (byval as integer) as zstring ptr
declare function killchar cdecl alias "killchar" () as byte
declare function longname cdecl alias "longname" () as zstring ptr
declare function meta cdecl alias "meta" (byval as WINDOW ptr, byval as integer) as integer
declare function mvcur cdecl alias "mvcur" (byval as integer, byval as integer, byval as integer, byval as integer) as integer
declare function mvderwin cdecl alias "mvderwin" (byval as WINDOW ptr, byval as integer, byval as integer) as integer
declare function mvwaddnstr cdecl alias "mvwaddnstr" (byval as WINDOW ptr, byval as integer, byval as integer, byval as zstring ptr, byval as integer) as integer
declare function mvwin cdecl alias "mvwin" (byval as WINDOW ptr, byval as integer, byval as integer) as integer
declare function mvwinsertln cdecl alias "mvwinsertln" (byval as WINDOW ptr, byval as integer, byval as integer) as integer
declare function mvprintw cdecl alias "mvprintw" (byval as integer, byval as integer, byval as zstring ptr, ...) as integer
declare function mvscanw cdecl alias "mvscanw" (byval as integer, byval as integer, byval as zstring ptr, ...) as integer
declare function mvwprintw cdecl alias "mvwprintw" (byval as WINDOW ptr, byval as integer, byval as integer, byval as zstring ptr, ...) as integer
declare function mvwscanw cdecl alias "mvwscanw" (byval as WINDOW ptr, byval as integer, byval as integer, byval as zstring ptr, ...) as integer
declare function newpad cdecl alias "newpad" (byval as integer, byval as integer) as WINDOW ptr
declare function newterm cdecl alias "newterm" (byval as zstring ptr, byval as FILE_ ptr, byval as FILE_ ptr) as SCREEN ptr
declare function newwin cdecl alias "newwin" (byval as integer, byval as integer, byval as integer, byval as integer) as WINDOW ptr
declare function noraw cdecl alias "noraw" () as integer
declare function notimeout cdecl alias "notimeout" (byval as WINDOW ptr, byval as integer) as integer
declare function overlay cdecl alias "overlay" (byval as WINDOW ptr, byval as WINDOW ptr) as integer
declare function overwrite cdecl alias "overwrite" (byval as WINDOW ptr, byval as WINDOW ptr) as integer
declare function pair_content cdecl alias "pair_content" (byval as integer, byval as short ptr, byval as short ptr) as integer
declare function pechochar cdecl alias "pechochar" (byval as WINDOW ptr, byval as chtype) as integer
declare function pnoutrefresh cdecl alias "pnoutrefresh" (byval as WINDOW ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer) as integer
declare function prefresh cdecl alias "prefresh" (byval as WINDOW ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer) as integer
declare function printw cdecl alias "printw" (byval as zstring ptr, ...) as integer
declare function scanw cdecl alias "scanw" (byval as zstring ptr, ...) as integer
declare function raw cdecl alias "raw" () as integer
declare function refresh cdecl alias "refresh" () as integer
declare function reset_prog_mode cdecl alias "reset_prog_mode" () as integer
declare function reset_shell_mode cdecl alias "reset_shell_mode" () as integer
declare function resetty cdecl alias "resetty" () as integer
declare function ripoffline cdecl alias "ripoffline" (byval as integer, byval as function cdecl(byval as WINDOW ptr, byval as integer) as integer) as integer
declare function savetty cdecl alias "savetty" () as integer
declare function sb_init cdecl alias "sb_init" () as integer
declare function sb_set_horz cdecl alias "sb_set_horz" (byval as integer, byval as integer, byval as integer) as integer
declare function sb_set_vert cdecl alias "sb_set_vert" (byval as integer, byval as integer, byval as integer) as integer
declare function sb_get_horz cdecl alias "sb_get_horz" (byval as integer ptr, byval as integer ptr, byval as integer ptr) as integer
declare function sb_get_vert cdecl alias "sb_get_vert" (byval as integer ptr, byval as integer ptr, byval as integer ptr) as integer
declare function sb_refresh cdecl alias "sb_refresh" () as integer
declare function scroll cdecl alias "scroll" (byval as WINDOW ptr) as integer
declare function set_term cdecl alias "set_term" (byval as SCREEN ptr) as SCREEN ptr
declare function setsyx cdecl alias "setsyx" (byval as integer, byval as integer) as integer
declare function start_color cdecl alias "start_color" () as integer
declare function slk_init cdecl alias "slk_init" (byval as integer) as integer
declare function slk_set cdecl alias "slk_set" (byval as integer, byval as zstring ptr, byval as integer) as integer
declare function slk_refresh cdecl alias "slk_refresh" () as integer
declare function slk_noutrefresh cdecl alias "slk_noutrefresh" () as integer
declare function slk_label cdecl alias "slk_label" (byval as integer) as zstring ptr
declare function slk_clear cdecl alias "slk_clear" () as integer
declare function slk_restore cdecl alias "slk_restore" () as integer
declare function slk_touch cdecl alias "slk_touch" () as integer
declare function slk_attron cdecl alias "slk_attron" (byval as attr_t) as integer
declare function slk_attrset cdecl alias "slk_attrset" (byval as attr_t) as integer
declare function slk_attroff cdecl alias "slk_attroff" (byval as attr_t) as integer
declare function subpad cdecl alias "subpad" (byval as WINDOW ptr, byval as integer, byval as integer, byval as integer, byval as integer) as WINDOW ptr
declare function subwin cdecl alias "subwin" (byval as WINDOW ptr, byval as integer, byval as integer, byval as integer, byval as integer) as WINDOW ptr
declare function syncok cdecl alias "syncok" (byval as WINDOW ptr, byval as integer) as integer
declare function termattrs cdecl alias "termattrs" () as attr_t
declare function termname cdecl alias "termname" () as zstring ptr
declare function touchline cdecl alias "touchline" (byval as WINDOW ptr, byval as integer, byval as integer) as integer
declare function touchwin cdecl alias "touchwin" (byval as WINDOW ptr) as integer
declare sub traceoff cdecl alias "traceoff" ()
declare sub traceon cdecl alias "traceon" ()
declare function typeahead cdecl alias "typeahead" (byval as integer) as integer
declare function unctrl cdecl alias "unctrl" (byval as chtype) as zstring ptr
declare function vline cdecl alias "vline" (byval as chtype, byval as integer) as integer
declare function waddchnstr cdecl alias "waddchnstr" (byval as WINDOW ptr, byval as chtype ptr, byval as integer) as integer
declare function waddnstr cdecl alias "waddnstr" (byval as WINDOW ptr, byval as zstring ptr, byval as integer) as integer
declare function waddstr cdecl alias "waddstr" (byval as WINDOW ptr, byval as zstring ptr) as integer
declare function wattroff cdecl alias "wattroff" (byval as WINDOW ptr, byval as attr_t) as integer
declare function wattron cdecl alias "wattron" (byval as WINDOW ptr, byval as attr_t) as integer
declare function wattrset cdecl alias "wattrset" (byval as WINDOW ptr, byval as attr_t) as integer
declare function wbkgd cdecl alias "wbkgd" (byval as WINDOW ptr, byval as chtype) as integer
declare sub wbkgdset cdecl alias "wbkgdset" (byval as WINDOW ptr, byval as chtype)
declare function wborder cdecl alias "wborder" (byval as WINDOW ptr, byval as chtype, byval as chtype, byval as chtype, byval as chtype, byval as chtype, byval as chtype, byval as chtype, byval as chtype) as integer
declare function wclear cdecl alias "wclear" (byval as WINDOW ptr) as integer
declare function wclrtobot cdecl alias "wclrtobot" (byval as WINDOW ptr) as integer
declare function wclrtoeol cdecl alias "wclrtoeol" (byval as WINDOW ptr) as integer
declare sub wcursyncup cdecl alias "wcursyncup" (byval as WINDOW ptr)
declare function wdelch cdecl alias "wdelch" (byval as WINDOW ptr) as integer
declare function wdeleteln cdecl alias "wdeleteln" (byval as WINDOW ptr) as integer
declare function werase cdecl alias "werase" (byval as WINDOW ptr) as integer
declare function wgetch cdecl alias "wgetch" (byval as WINDOW ptr) as integer
declare function wgetnstr cdecl alias "wgetnstr" (byval as WINDOW ptr, byval as zstring ptr, byval as integer) as integer
declare function wgetstr cdecl alias "wgetstr" (byval as WINDOW ptr, byval as zstring ptr) as integer
declare function whline cdecl alias "whline" (byval as WINDOW ptr, byval as chtype, byval as integer) as integer
declare function winchnstr cdecl alias "winchnstr" (byval as WINDOW ptr, byval as chtype ptr, byval as integer) as integer
declare function winnstr cdecl alias "winnstr" (byval as WINDOW ptr, byval as zstring ptr, byval as integer) as integer
declare function winsch cdecl alias "winsch" (byval as WINDOW ptr, byval as chtype) as integer
declare function winsdelln cdecl alias "winsdelln" (byval as WINDOW ptr, byval as integer) as integer
declare function winsertln cdecl alias "winsertln" (byval as WINDOW ptr) as integer
declare function winsnstr cdecl alias "winsnstr" (byval as WINDOW ptr, byval as zstring ptr, byval as integer) as integer
declare function wmove cdecl alias "wmove" (byval as WINDOW ptr, byval as integer, byval as integer) as integer
declare function wnoutrefresh cdecl alias "wnoutrefresh" (byval as WINDOW ptr) as integer
declare function wordchar cdecl alias "wordchar" () as byte
declare function wredrawln cdecl alias "wredrawln" (byval as WINDOW ptr, byval as integer, byval as integer) as integer
declare function wrefresh cdecl alias "wrefresh" (byval as WINDOW ptr) as integer
declare function wscrl cdecl alias "wscrl" (byval as WINDOW ptr, byval as integer) as integer
declare function wsetscrreg cdecl alias "wsetscrreg" (byval as WINDOW ptr, byval as integer, byval as integer) as integer
declare function wtimeout cdecl alias "wtimeout" (byval as WINDOW ptr, byval as integer) as integer
declare function wtouchln cdecl alias "wtouchln" (byval as WINDOW ptr, byval as integer, byval as integer, byval as integer) as integer
declare sub wsyncdown cdecl alias "wsyncdown" (byval as WINDOW ptr)
declare sub wsyncup cdecl alias "wsyncup" (byval as WINDOW ptr)
declare function wvline cdecl alias "wvline" (byval as WINDOW ptr, byval as chtype, byval as integer) as integer
declare function wprintw cdecl alias "wprintw" (byval as WINDOW ptr, byval as zstring ptr, ...) as integer
declare function wscanw cdecl alias "wscanw" (byval as WINDOW ptr, byval as zstring ptr, ...) as integer
declare function raw_output cdecl alias "raw_output" (byval as integer) as integer
declare function resize_term cdecl alias "resize_term" (byval as integer, byval as integer) as integer
declare function resize_window cdecl alias "resize_window" (byval as WINDOW ptr, byval as integer, byval as integer) as WINDOW ptr
declare function mouse_set cdecl alias "mouse_set" (byval as uinteger) as integer
declare function mouse_on cdecl alias "mouse_on" (byval as uinteger) as integer
declare function mouse_off cdecl alias "mouse_off" (byval as uinteger) as integer
declare function request_mouse_pos cdecl alias "request_mouse_pos" () as integer
declare function map_button cdecl alias "map_button" (byval as uinteger) as integer
declare sub wmouse_position cdecl alias "wmouse_position" (byval as WINDOW ptr, byval as integer ptr, byval as integer ptr)
declare function getmouse cdecl alias "getmouse" () as uinteger
declare function getbmap cdecl alias "getbmap" () as uinteger

declare function PDC_chadd cdecl alias "PDC_chadd" (byval as WINDOW ptr, byval as chtype, byval as integer, byval as integer) as integer
declare function PDC_chins cdecl alias "PDC_chins" (byval as WINDOW ptr, byval as chtype, byval as integer) as integer
declare function PDC_ungetch cdecl alias "PDC_ungetch" (byval as integer) as integer
declare sub PDC_set_title cdecl alias "PDC_set_title" (byval as zstring ptr)
declare function PDC_getclipboard cdecl alias "PDC_getclipboard" (byval as byte ptr ptr, byval as integer ptr) as integer
declare function PDC_setclipboard cdecl alias "PDC_setclipboard" (byval as zstring ptr, byval as integer) as integer
declare function PDC_freeclipboard cdecl alias "PDC_freeclipboard" (byval as zstring ptr) as integer
declare function PDC_clearclipboard cdecl alias "PDC_clearclipboard" () as integer
declare function PDC_get_input_fd cdecl alias "PDC_get_input_fd" () as uinteger
declare function PDC_curs_set cdecl alias "PDC_curs_set" (byval as integer) as integer
declare function PDC_get_key_modifiers cdecl alias "PDC_get_key_modifiers" () as uinteger
declare function PDC_wunderline cdecl alias "PDC_wunderline" (byval as WINDOW ptr, byval as integer, byval as integer) as integer
declare function PDC_wleftline cdecl alias "PDC_wleftline" (byval as WINDOW ptr, byval as integer, byval as integer) as integer
declare function PDC_wrightline cdecl alias "PDC_wrightline" (byval as WINDOW ptr, byval as integer, byval as integer) as integer
declare function PDC_set_line_color cdecl alias "PDC_set_line_color" (byval as short) as integer

declare function nocbreak cdecl alias "nocbreak" () as integer
declare function cbreak cdecl alias "cbreak" () as integer
declare function nocrmode cdecl alias "nocrmode" () as integer
declare function crmode cdecl alias "crmode" () as integer
declare function noecho cdecl alias "noecho" () as integer
declare function echo cdecl alias "echo" () as integer
declare function nodelay cdecl alias "nodelay" (byval as WINDOW ptr, byval as integer) as integer

#define PDC_CLIP_SUCCESS 0
#define PDC_CLIP_ACCESS_ERROR 1
#define PDC_CLIP_EMPTY 2
#define PDC_CLIP_MEMORY_ERROR 3
#define PDC_KEY_MODIFIER_SHIFT (1 shl 0)
#define PDC_KEY_MODIFIER_CONTROL (1 shl 1)
#define PDC_KEY_MODIFIER_ALT (1 shl 2)
#define PDC_KEY_MODIFIER_NUMLOCK (1 shl 3)

#define addch( c ) waddch( stdscr, c )
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
