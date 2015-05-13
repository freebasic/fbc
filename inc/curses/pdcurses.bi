'' PDCurses 3.4
'' #define PDC_DLL_BUILD when using the PDCurses DLL,
'' leave it undefined when using the static library.
#pragma once

#inclib "pdcurses"

#ifdef __FB_WIN32__
	#ifndef PDC_DLL_BUILD
		#inclib "user32"
		#inclib "advapi32"
	#endif
#endif

''man-start**************************************************************
''
''PDCurses definitions list:  (Only define those needed)
''
''    XCURSES         True if compiling for X11.
''    PDC_RGB         True if you want to use RGB color definitions
''                    (Red = 1, Green = 2, Blue = 4) instead of BGR.
''    PDC_WIDE        True if building wide-character support.
''    PDC_DLL_BUILD   True if building a Win32 DLL.
''    NCURSES_MOUSE_VERSION   Use the ncurses mouse API instead
''                            of PDCurses' traditional mouse API.
''
''PDCurses portable platform definitions list:
''
''    PDC_BUILD       Defines API build version.
''    PDCURSES        Enables access to PDCurses-only routines.
''    XOPEN           Always true.
''    SYSVcurses      True if you are compiling for SYSV portability.
''    BSDcurses       True if you are compiling for BSD portability.
''
''**man-end***************************************************************
#define PDC_BUILD 3401
#define PDCURSES 1
#define XOPEN 1
#define SYSVcurses 1
#define BSDcurses 1
#define CHTYPE_LONG 1

''----------------------------------------------------------------------
'' *
'' *  PDCurses Manifest Constants
'' *
''
#ifndef FALSE
	#define FALSE 0
#endif
#ifndef TRUE
	#define TRUE 1
#endif
#ifndef NULL
	#define NULL cast(any ptr, 0)
#endif
#ifndef ERR
	#define ERR (-1)
#endif
#ifndef OK
	#define OK 0
#endif

''----------------------------------------------------------------------
'' *
'' *  PDCurses Type Declarations
'' *
''
type bool as ubyte '' PDCurses Boolean type

#ifdef CHTYPE_LONG
type chtype as ulong
#else
type chtype as ushort '' 8-bit attr + 8-bit char
#endif

#ifdef PDC_WIDE
type cchar_t as chtype
#include once "crt/wchar.bi"  '' wchar_t
#endif

type attr_t as chtype

#include once "crt/stdio.bi" '' FILE

extern "C"

''----------------------------------------------------------------------
'' *
'' *  PDCurses Mouse Interface -- SYSVR4, with extensions
'' *
''
type PDCMOUSE_STATUS
	x as long '' absolute column, 0 based, measured in characters
	y as long '' absolute row, 0 based, measured in characters
	button(0 to 2) as short '' state of each button
	changes as long '' flags indicating what has changed with the mouse
end type

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

#define MOUSE_X_POS (Mouse_status.x)
#define MOUSE_Y_POS (Mouse_status.y)

''
'' * Bits associated with the .changes field:
'' *   3         2         1         0
'' * 210987654321098765432109876543210
'' *                                 1 <- button 1 has changed
'' *                                10 <- button 2 has changed
'' *                               100 <- button 3 has changed
'' *                              1000 <- mouse has moved
'' *                             10000 <- mouse position report
'' *                            100000 <- mouse wheel up
'' *                           1000000 <- mouse wheel down
''
#define PDC_MOUSE_MOVED &h0008
#define PDC_MOUSE_POSITION &h0010
#define PDC_MOUSE_WHEEL_UP &h0020
#define PDC_MOUSE_WHEEL_DOWN &h0040

#define A_BUTTON_CHANGED (Mouse_status.changes and 7)
#define MOUSE_MOVED (Mouse_status.changes and PDC_MOUSE_MOVED)
#define MOUSE_POS_REPORT (Mouse_status.changes and PDC_MOUSE_POSITION)
#define BUTTON_CHANGED(x)       (Mouse_status.changes and (1 shl ((x) - 1)))
#define BUTTON_STATUS(x)        (Mouse_status.button((x)-1))
#define MOUSE_WHEEL_UP (Mouse_status.changes and PDC_MOUSE_WHEEL_UP)
#define MOUSE_WHEEL_DOWN (Mouse_status.changes and PDC_MOUSE_WHEEL_DOWN)

'' mouse bit-masks
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

'' For the ncurses-compatible functions only, BUTTON4_PRESSED and
'' BUTTON5_PRESSED are returned for mouse scroll wheel up and down;
'' otherwise PDCurses doesn't support buttons 4 and 5
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

#define ALL_MOUSE_EVENTS &h1FFFFFFFL
#define REPORT_MOUSE_POSITION &h20000000L

'' ncurses mouse interface
type mmask_t as ulong

type MEVENT
	id as short '' unused, always 0
	x as long
	y as long
	z as long '' x, y same as MOUSE_STATUS; z unused
	'' equivalent to changes + button[], but
	'' in the same format as used for mousemask()
	bstate as mmask_t
end type

#ifdef NCURSES_MOUSE_VERSION
#define BUTTON_SHIFT BUTTON_MODIFIER_SHIFT
#define BUTTON_CONTROL BUTTON_MODIFIER_CONTROL
#define BUTTON_CTRL BUTTON_MODIFIER_CONTROL
#define BUTTON_ALT BUTTON_MODIFIER_ALT
#else
#define BUTTON_SHIFT PDC_BUTTON_SHIFT
#define BUTTON_CONTROL PDC_BUTTON_CONTROL
#define BUTTON_ALT PDC_BUTTON_ALT
#endif

''----------------------------------------------------------------------
'' *
'' *  PDCurses Structure Definitions
'' *
''

'' definition of a window
type PDCWINDOW
	_cury as long '' current pseudo-cursor
	_curx as long
	_maxy as long '' max window coordinates
	_maxx as long
	_begy as long '' origin on screen
	_begx as long
	_flags as long '' window properties
	_attrs as chtype '' standard attributes and colors
	_bkgd as chtype '' background, normally blank
	_clear as bool '' causes clear at next refresh
	_leaveit as bool '' leaves cursor where it is
	_scroll as bool '' allows window scrolling
	_nodelay as bool '' input character wait flag
	_immed as bool '' immediate update flag
	_sync as bool '' synchronise window ancestors
	_use_keypad as bool '' flags keypad key mode active
	_y as chtype ptr ptr '' pointer to line pointer array
	_firstch as long ptr '' first changed character in line
	_lastch as long ptr '' last changed character in line
	_tmarg as long '' top of scrolling region
	_bmarg as long '' bottom of scrolling region
	_delayms as long '' milliseconds of delay for getch()
	_parx as long
	_pary as long '' coords relative to parent (0,0)
	_parent as PDCWINDOW ptr '' subwin's pointer to parent win
end type

'' Avoid using the PDCSCREEN struct directly -- use the corresponding
'' functions if possible. This struct may eventually be made private.
type PDCSCREEN
	alive as bool '' if initscr() called, and not endwin()
	autocr as bool '' if cr -> lf
	cbreak as bool '' if terminal unbuffered
	echo as bool '' if terminal echo
	raw_inp as bool '' raw input mode (v. cooked input)
	raw_out as bool '' raw output mode (7 v. 8 bits)
	audible as bool '' FALSE if the bell is visual
	mono as bool '' TRUE if current screen is mono
	resized as bool '' TRUE if TERM has been resized
	orig_attr as bool '' TRUE if we have the original colors
	orig_fore as short '' original screen foreground color
	orig_back as short '' original screen foreground color
	cursrow as long '' position of physical cursor
	curscol as long '' position of physical cursor
	visibility as long '' visibility of cursor
	orig_cursor as long '' original cursor size
	lines as long '' new value for LINES
	cols as long '' new value for COLS
	_trap_mbe as ulong
	_map_mbe_to_key as ulong
	'' time to wait (in ms) for a button release after a press, in
	'' order to count it as a click
	mouse_wait as long
	slklines as long '' lines in use by slk_init()
	slk_winptr as PDCWINDOW ptr '' window for slk
	linesrippedoff as long '' lines ripped off via ripoffline()
	linesrippedoffontop as long '' lines ripped off on top via ripoffline()
	delaytenths as long '' 1/10ths second to wait block getch() for
	_preserve as bool '' TRUE if screen background to be preserved
	_restore as long '' specifies if screen background to be restored, and how
	save_key_modifiers as bool '' TRUE if each key modifiers saved with each key press
	return_key_modifiers as bool '' TRUE if modifier keys are returned as "real" keys
	key_code as bool '' TRUE if last key is a special key; used internally by get_wch()
#ifdef XCURSES
	XcurscrSize as long '' size of Xcurscr shared memory block
	sb_on as bool
	sb_viewport_y as long
	sb_viewport_x as long
	sb_total_y as long
	sb_total_x as long
	sb_cur_y as long
	sb_cur_x as long
#endif
	line_color as short '' color of line attributes - default -1
end type

''----------------------------------------------------------------------
'' *
'' *  PDCurses External Variables
'' *
''

#ifdef PDC_DLL_BUILD
	#define PDCEX import
#else
	#define PDCEX
#endif

extern PDCEX LINES as long
extern PDCEX COLS as long
extern PDCEX stdscr as PDCWINDOW ptr
extern PDCEX curscr as PDCWINDOW ptr
extern PDCEX SP as PDCSCREEN ptr
extern PDCEX Mouse_status as PDCMOUSE_STATUS
extern PDCEX COLORS as long
extern PDCEX COLOR_PAIRS as long
extern PDCEX TABSIZE as long
extern PDCEX acs_map(0 to 127) as chtype
extern PDCEX ttytype as zstring * 128

''man-start**************************************************************
''
''PDCurses Text Attributes
''========================
''
''Originally, PDCurses used a short (16 bits) for its chtype. To include
''color, a number of things had to be sacrificed from the strict Unix and
''System V support. The main problem was fitting all character attributes
''and color into an unsigned char (all 8 bits!).
''
''Today, PDCurses by default uses a long (32 bits) for its chtype, as in
''System V. The short chtype is still available, by undefining CHTYPE_LONG
''and rebuilding the library.
''
''The following is the structure of a win->_attrs chtype:
''
''short form:
''
''-------------------------------------------------
''|15|14|13|12|11|10| 9| 8| 7| 6| 5| 4| 3| 2| 1| 0|
''-------------------------------------------------
''  color number |  attrs |   character eg 'a'
''
''The available non-color attributes are bold, reverse and blink. Others
''have no effect. The high order char is an index into an array of
''physical colors (defined in color.c) -- 32 foreground/background color
''pairs (5 bits) plus 3 bits for other attributes.
''
''long form:
''
''----------------------------------------------------------------------------
''|31|30|29|28|27|26|25|24|23|22|21|20|19|18|17|16|15|14|13|12|..| 3| 2| 1| 0|
''----------------------------------------------------------------------------
''      color number      |     modifiers         |      character eg 'a'
''
''The available non-color attributes are bold, underline, invisible,
''right-line, left-line, protect, reverse and blink. 256 color pairs (8
''bits), 8 bits for other attributes, and 16 bits for character data.
''
''**man-end***************************************************************

''** Video attribute macros **
#define A_NORMAL cast(chtype, 0)

#ifdef CHTYPE_LONG
#define A_ALTCHARSET cast(chtype, &h00010000)
#define A_RIGHTLINE cast(chtype, &h00020000)
#define A_LEFTLINE cast(chtype, &h00040000)
#define A_INVIS cast(chtype, &h00080000)
#define A_UNDERLINE cast(chtype, &h00100000)
#define A_REVERSE cast(chtype, &h00200000)
#define A_BLINK cast(chtype, &h00400000)
#define A_BOLD cast(chtype, &h00800000)

#define A_ATTRIBUTES cast(chtype, &hFFFF0000)
#define A_CHARTEXT cast(chtype, &h0000FFFF)
#define A_COLOR cast(chtype, &hFF000000)

#define A_ITALIC A_INVIS
#define A_PROTECT (A_UNDERLINE or A_LEFTLINE or A_RIGHTLINE)

#define PDC_ATTR_SHIFT 19
#define PDC_COLOR_SHIFT 24
#else
#define A_BOLD cast(chtype, &h0100)
#define A_REVERSE cast(chtype, &h0200)
#define A_BLINK cast(chtype, &h0400)

#define A_ATTRIBUTES cast(chtype, &hFF00)
#define A_CHARTEXT cast(chtype, &h00FF)
#define A_COLOR cast(chtype, &hF800)

#define A_ALTCHARSET A_NORMAL
#define A_PROTECT A_NORMAL
#define A_UNDERLINE A_NORMAL

#define A_LEFTLINE A_NORMAL
#define A_RIGHTLINE A_NORMAL
#define A_ITALIC A_NORMAL
#define A_INVIS A_NORMAL

#define PDC_ATTR_SHIFT 8
#define PDC_COLOR_SHIFT 11
#endif

#define A_STANDOUT (A_REVERSE or A_BOLD)
#define A_DIM A_NORMAL

#define CHR_MSK A_CHARTEXT
#define ATR_MSK A_ATTRIBUTES
#define ATR_NRM A_NORMAL

'' For use with attr_t -- X/Open says, "these shall be distinct", so
'' this is a non-conforming implementation.
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
#define WA_LOW A_NORMAL
#define WA_TOP A_NORMAL
#define WA_VERTICAL A_NORMAL

''** Alternate character set macros **

'' 'w' = 32-bit chtype; acs_map[] index | A_ALTCHARSET
'' 'n' = 16-bit chtype; it gets the fallback set because no bit is
''       available for A_ALTCHARSET
#ifdef CHTYPE_LONG
#define ACS_PICK(w, n) (cast(chtype, (w)) or A_ALTCHARSET)
#else
#define ACS_PICK(w, n) cast(chtype, (n))
#endif

'' VT100-compatible symbols -- box chars
#define ACS_ULCORNER ACS_PICK("l", "+")
#define ACS_LLCORNER ACS_PICK("m", "+")
#define ACS_URCORNER ACS_PICK("k", "+")
#define ACS_LRCORNER ACS_PICK("j", "+")
#define ACS_RTEE ACS_PICK("u", "+")
#define ACS_LTEE ACS_PICK("t", "+")
#define ACS_BTEE ACS_PICK("v", "+")
#define ACS_TTEE ACS_PICK("w", "+")
#define ACS_HLINE ACS_PICK("q", "-")
#define ACS_VLINE ACS_PICK("x", "|")
#define ACS_PLUS ACS_PICK("n", "+")

'' VT100-compatible symbols -- other
#define ACS_S1 ACS_PICK("o", "-")
#define ACS_S9 ACS_PICK("s", "_")
#define ACS_DIAMOND ACS_PICK("`", "+")
#define ACS_CKBOARD ACS_PICK("a", ":")
#define ACS_DEGREE ACS_PICK("f", "\'")
#define ACS_PLMINUS ACS_PICK("g", "#")
#define ACS_BULLET ACS_PICK("~", "o")

'' Teletype 5410v1 symbols -- these are defined in SysV curses, but
'' are not well-supported by most terminals. Stick to VT100 characters
'' for optimum portability.
#define ACS_LARROW ACS_PICK(",", "<")
#define ACS_RARROW ACS_PICK("+", ">")
#define ACS_DARROW ACS_PICK(".", "v")
#define ACS_UARROW ACS_PICK("-", "^")
#define ACS_BOARD ACS_PICK("h", "#")
#define ACS_LANTERN ACS_PICK("i", "*")
#define ACS_BLOCK ACS_PICK("0", "#")

'' That goes double for these -- undocumented SysV symbols. Don't use them.
#define ACS_S3 ACS_PICK("p", "-")
#define ACS_S7 ACS_PICK("r", "-")
#define ACS_LEQUAL ACS_PICK("y", "<")
#define ACS_GEQUAL ACS_PICK("z", ">")
#define ACS_PI ACS_PICK("{", "n")
#define ACS_NEQUAL ACS_PICK("|", "+")
#define ACS_STERLING ACS_PICK("}", "L")

'' Box char aliases
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

'' cchar_t aliases
#ifdef PDC_WIDE
#define WACS_ULCORNER (@(acs_map(asc("l"))))
#define WACS_LLCORNER (@(acs_map(asc("m"))))
#define WACS_URCORNER (@(acs_map(asc("k"))))
#define WACS_LRCORNER (@(acs_map(asc("j"))))
#define WACS_RTEE (@(acs_map(asc("u"))))
#define WACS_LTEE (@(acs_map(asc("t"))))
#define WACS_BTEE (@(acs_map(asc("v"))))
#define WACS_TTEE (@(acs_map(asc("w"))))
#define WACS_HLINE (@(acs_map(asc("q"))))
#define WACS_VLINE (@(acs_map(asc("x"))))
#define WACS_PLUS (@(acs_map(asc("n"))))

#define WACS_S1 (@(acs_map(asc("o"))))
#define WACS_S9 (@(acs_map(asc("s"))))
#define WACS_DIAMOND (@(acs_map(asc("`"))))
#define WACS_CKBOARD (@(acs_map(asc("a"))))
#define WACS_DEGREE (@(acs_map(asc("f"))))
#define WACS_PLMINUS (@(acs_map(asc("g"))))
#define WACS_BULLET (@(acs_map(asc("~"))))

#define WACS_LARROW (@(acs_map(asc(","))))
#define WACS_RARROW (@(acs_map(asc("+"))))
#define WACS_DARROW (@(acs_map(asc("."))))
#define WACS_UARROW (@(acs_map(asc("-"))))
#define WACS_BOARD (@(acs_map(asc("h"))))
#define WACS_LANTERN (@(acs_map(asc("i"))))
#define WACS_BLOCK (@(acs_map(asc("0"))))

#define WACS_S3 (@(acs_map(asc("p"))))
#define WACS_S7 (@(acs_map(asc("r"))))
#define WACS_LEQUAL (@(acs_map(asc("y"))))
#define WACS_GEQUAL (@(acs_map(asc("z"))))
#define WACS_PI (@(acs_map(asc("{"))))
#define WACS_NEQUAL (@(acs_map(asc("|"))))
#define WACS_STERLING (@(acs_map(asc("}"))))

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

''** Color macros **
#define COLOR_BLACK 0

#ifdef PDC_RGB
#define COLOR_RED 1
#define COLOR_GREEN 2
#define COLOR_BLUE 4
#else
#define COLOR_BLUE 1
#define COLOR_GREEN 2
#define COLOR_RED 4
#endif

#define COLOR_CYAN (COLOR_BLUE or COLOR_GREEN)
#define COLOR_MAGENTA (COLOR_RED or COLOR_BLUE)
#define COLOR_YELLOW (COLOR_RED or COLOR_GREEN)

#define COLOR_WHITE 7

''----------------------------------------------------------------------
'' *
'' *  Function and Keypad Key Definitions.
'' *  Many are just for compatibility.
'' *
''
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

'' PDCurses-specific key definitions -- PC only
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
#define ALT_PAD6 &h20b
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

#define KEY_MIN KEY_BREAK
#define KEY_MAX KEY_SDOWN

#define KEY_F(n)      (KEY_F0 + (n))

''----------------------------------------------------------------------
'' *
'' *  PDCurses Function Declarations
'' *
''

'' Standard
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
declare function pdcbeep() as long
declare function bkgd(byval as chtype) as long
declare sub bkgdset(byval as chtype)
declare function border(byval as chtype, byval as chtype, byval as chtype, byval as chtype, byval as chtype, byval as chtype, byval as chtype, byval as chtype) as long
declare function box(byval as PDCWINDOW ptr, byval as chtype, byval as chtype) as long
declare function can_change_color() as bool
declare function cbreak() as long
declare function chgat(byval as long, byval as attr_t, byval as short, byval as const any ptr) as long
declare function clearok(byval as PDCWINDOW ptr, byval as bool) as long
declare function pdcclear() as long
declare function clrtobot() as long
declare function clrtoeol() as long
declare function color_content(byval as short, byval as short ptr, byval as short ptr, byval as short ptr) as long
declare function color_set(byval as short, byval as any ptr) as long
declare function copywin(byval as const PDCWINDOW ptr, byval as PDCWINDOW ptr, byval as long, byval as long, byval as long, byval as long, byval as long, byval as long, byval as long) as long
declare function curs_set(byval as long) as long
declare function def_prog_mode() as long
declare function def_shell_mode() as long
declare function delay_output(byval as long) as long
declare function delch() as long
declare function deleteln() as long
declare sub delscreen(byval as PDCSCREEN ptr)
declare function delwin(byval as PDCWINDOW ptr) as long
declare function derwin(byval as PDCWINDOW ptr, byval as long, byval as long, byval as long, byval as long) as PDCWINDOW ptr
declare function doupdate() as long
declare function dupwin(byval as PDCWINDOW ptr) as PDCWINDOW ptr
declare function echochar(byval as const chtype) as long
declare function echo() as long
declare function endwin() as long
declare function erasechar() as byte
declare function pdcerase() as long
declare sub filter()
declare function flash() as long
declare function flushinp() as long
declare function getbkgd(byval as PDCWINDOW ptr) as chtype
declare function getnstr(byval as zstring ptr, byval as long) as long
declare function getstr(byval as zstring ptr) as long
declare function getwin(byval as FILE ptr) as PDCWINDOW ptr
declare function halfdelay(byval as long) as long
declare function has_colors() as bool
declare function has_ic() as bool
declare function has_il() as bool
declare function hline(byval as chtype, byval as long) as long
declare sub idcok(byval as PDCWINDOW ptr, byval as bool)
declare function idlok(byval as PDCWINDOW ptr, byval as bool) as long
declare sub immedok(byval as PDCWINDOW ptr, byval as bool)
declare function inchnstr(byval as chtype ptr, byval as long) as long
declare function inchstr(byval as chtype ptr) as long
declare function inch() as chtype
declare function init_color(byval as short, byval as short, byval as short, byval as short) as long
declare function init_pair(byval as short, byval as short, byval as short) as long
declare function initscr() as PDCWINDOW ptr
declare function innstr(byval as zstring ptr, byval as long) as long
declare function insch(byval as chtype) as long
declare function insdelln(byval as long) as long
declare function insertln() as long
declare function insnstr(byval as const zstring ptr, byval as long) as long
declare function insstr(byval as const zstring ptr) as long
declare function pdcinstr(byval as zstring ptr) as long
declare function intrflush(byval as PDCWINDOW ptr, byval as bool) as long
declare function isendwin() as bool
declare function is_linetouched(byval as PDCWINDOW ptr, byval as long) as bool
declare function is_wintouched(byval as PDCWINDOW ptr) as bool
declare function keyname(byval as long) as zstring ptr
declare function keypad(byval as PDCWINDOW ptr, byval as bool) as long
declare function killchar() as byte
declare function leaveok(byval as PDCWINDOW ptr, byval as bool) as long
declare function longname() as zstring ptr
declare function meta(byval as PDCWINDOW ptr, byval as bool) as long
declare function move(byval as long, byval as long) as long
declare function mvaddch(byval as long, byval as long, byval as const chtype) as long
declare function mvaddchnstr(byval as long, byval as long, byval as const chtype ptr, byval as long) as long
declare function mvaddchstr(byval as long, byval as long, byval as const chtype ptr) as long
declare function mvaddnstr(byval as long, byval as long, byval as const zstring ptr, byval as long) as long
declare function mvaddstr(byval as long, byval as long, byval as const zstring ptr) as long
declare function mvchgat(byval as long, byval as long, byval as long, byval as attr_t, byval as short, byval as const any ptr) as long
declare function mvcur(byval as long, byval as long, byval as long, byval as long) as long
declare function mvdelch(byval as long, byval as long) as long
declare function mvderwin(byval as PDCWINDOW ptr, byval as long, byval as long) as long
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
declare function mvwaddchnstr(byval as PDCWINDOW ptr, byval as long, byval as long, byval as const chtype ptr, byval as long) as long
declare function mvwaddchstr(byval as PDCWINDOW ptr, byval as long, byval as long, byval as const chtype ptr) as long
declare function mvwaddch(byval as PDCWINDOW ptr, byval as long, byval as long, byval as const chtype) as long
declare function mvwaddnstr(byval as PDCWINDOW ptr, byval as long, byval as long, byval as const zstring ptr, byval as long) as long
declare function mvwaddstr(byval as PDCWINDOW ptr, byval as long, byval as long, byval as const zstring ptr) as long
declare function mvwchgat(byval as PDCWINDOW ptr, byval as long, byval as long, byval as long, byval as attr_t, byval as short, byval as const any ptr) as long
declare function mvwdelch(byval as PDCWINDOW ptr, byval as long, byval as long) as long
declare function mvwgetch(byval as PDCWINDOW ptr, byval as long, byval as long) as long
declare function mvwgetnstr(byval as PDCWINDOW ptr, byval as long, byval as long, byval as zstring ptr, byval as long) as long
declare function mvwgetstr(byval as PDCWINDOW ptr, byval as long, byval as long, byval as zstring ptr) as long
declare function mvwhline(byval as PDCWINDOW ptr, byval as long, byval as long, byval as chtype, byval as long) as long
declare function mvwinchnstr(byval as PDCWINDOW ptr, byval as long, byval as long, byval as chtype ptr, byval as long) as long
declare function mvwinchstr(byval as PDCWINDOW ptr, byval as long, byval as long, byval as chtype ptr) as long
declare function mvwinch(byval as PDCWINDOW ptr, byval as long, byval as long) as chtype
declare function mvwinnstr(byval as PDCWINDOW ptr, byval as long, byval as long, byval as zstring ptr, byval as long) as long
declare function mvwinsch(byval as PDCWINDOW ptr, byval as long, byval as long, byval as chtype) as long
declare function mvwinsnstr(byval as PDCWINDOW ptr, byval as long, byval as long, byval as const zstring ptr, byval as long) as long
declare function mvwinsstr(byval as PDCWINDOW ptr, byval as long, byval as long, byval as const zstring ptr) as long
declare function mvwinstr(byval as PDCWINDOW ptr, byval as long, byval as long, byval as zstring ptr) as long
declare function mvwin(byval as PDCWINDOW ptr, byval as long, byval as long) as long
declare function mvwprintw(byval as PDCWINDOW ptr, byval as long, byval as long, byval as const zstring ptr, ...) as long
declare function mvwscanw(byval as PDCWINDOW ptr, byval as long, byval as long, byval as const zstring ptr, ...) as long
declare function mvwvline(byval as PDCWINDOW ptr, byval as long, byval as long, byval as chtype, byval as long) as long
declare function napms(byval as long) as long
declare function newpad(byval as long, byval as long) as PDCWINDOW ptr
declare function newterm(byval as const zstring ptr, byval as FILE ptr, byval as FILE ptr) as PDCSCREEN ptr
declare function newwin(byval as long, byval as long, byval as long, byval as long) as PDCWINDOW ptr
declare function nl() as long
declare function nocbreak() as long
declare function nodelay(byval as PDCWINDOW ptr, byval as bool) as long
declare function noecho() as long
declare function nonl() as long
declare sub noqiflush()
declare function noraw() as long
declare function notimeout(byval as PDCWINDOW ptr, byval as bool) as long
declare function overlay(byval as const PDCWINDOW ptr, byval as PDCWINDOW ptr) as long
declare function overwrite(byval as const PDCWINDOW ptr, byval as PDCWINDOW ptr) as long
declare function pair_content(byval as short, byval as short ptr, byval as short ptr) as long
declare function pechochar(byval as PDCWINDOW ptr, byval as chtype) as long
declare function pnoutrefresh(byval as PDCWINDOW ptr, byval as long, byval as long, byval as long, byval as long, byval as long, byval as long) as long
declare function prefresh(byval as PDCWINDOW ptr, byval as long, byval as long, byval as long, byval as long, byval as long, byval as long) as long
declare function printw(byval as const zstring ptr, ...) as long
declare function putwin(byval as PDCWINDOW ptr, byval as FILE ptr) as long
declare sub qiflush()
declare function raw() as long
declare function redrawwin(byval as PDCWINDOW ptr) as long
declare function refresh() as long
declare function reset_prog_mode() as long
declare function reset_shell_mode() as long
declare function resetty() as long
declare function ripoffline(byval as long, byval as function(byval as PDCWINDOW ptr, byval as long) as long) as long
declare function savetty() as long
declare function scanw(byval as const zstring ptr, ...) as long
declare function scr_dump(byval as const zstring ptr) as long
declare function scr_init(byval as const zstring ptr) as long
declare function scr_restore(byval as const zstring ptr) as long
declare function scr_set(byval as const zstring ptr) as long
declare function scrl(byval as long) as long
declare function scroll(byval as PDCWINDOW ptr) as long
declare function scrollok(byval as PDCWINDOW ptr, byval as bool) as long
declare function set_term(byval as PDCSCREEN ptr) as PDCSCREEN ptr
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
declare function subpad(byval as PDCWINDOW ptr, byval as long, byval as long, byval as long, byval as long) as PDCWINDOW ptr
declare function subwin(byval as PDCWINDOW ptr, byval as long, byval as long, byval as long, byval as long) as PDCWINDOW ptr
declare function syncok(byval as PDCWINDOW ptr, byval as bool) as long
declare function termattrs() as chtype
declare function term_attrs() as attr_t
declare function termname() as zstring ptr
declare sub timeout(byval as long)
declare function touchline(byval as PDCWINDOW ptr, byval as long, byval as long) as long
declare function touchwin(byval as PDCWINDOW ptr) as long
declare function typeahead(byval as long) as long
declare function untouchwin(byval as PDCWINDOW ptr) as long
declare sub use_env(byval as bool)
declare function vidattr(byval as chtype) as long
declare function vid_attr(byval as attr_t, byval as short, byval as any ptr) as long
declare function vidputs(byval as chtype, byval as function(byval as long) as long) as long
declare function vid_puts(byval as attr_t, byval as short, byval as any ptr, byval as function(byval as long) as long) as long
declare function vline(byval as chtype, byval as long) as long
declare function vw_printw(byval as PDCWINDOW ptr, byval as const zstring ptr, byval as va_list) as long
declare function vwprintw(byval as PDCWINDOW ptr, byval as const zstring ptr, byval as va_list) as long
declare function vw_scanw(byval as PDCWINDOW ptr, byval as const zstring ptr, byval as va_list) as long
declare function vwscanw(byval as PDCWINDOW ptr, byval as const zstring ptr, byval as va_list) as long
declare function waddchnstr(byval as PDCWINDOW ptr, byval as const chtype ptr, byval as long) as long
declare function waddchstr(byval as PDCWINDOW ptr, byval as const chtype ptr) as long
declare function waddch(byval as PDCWINDOW ptr, byval as const chtype) as long
declare function waddnstr(byval as PDCWINDOW ptr, byval as const zstring ptr, byval as long) as long
declare function waddstr(byval as PDCWINDOW ptr, byval as const zstring ptr) as long
declare function wattroff(byval as PDCWINDOW ptr, byval as chtype) as long
declare function wattron(byval as PDCWINDOW ptr, byval as chtype) as long
declare function wattrset(byval as PDCWINDOW ptr, byval as chtype) as long
declare function wattr_get(byval as PDCWINDOW ptr, byval as attr_t ptr, byval as short ptr, byval as any ptr) as long
declare function wattr_off(byval as PDCWINDOW ptr, byval as attr_t, byval as any ptr) as long
declare function wattr_on(byval as PDCWINDOW ptr, byval as attr_t, byval as any ptr) as long
declare function wattr_set(byval as PDCWINDOW ptr, byval as attr_t, byval as short, byval as any ptr) as long
declare sub wbkgdset(byval as PDCWINDOW ptr, byval as chtype)
declare function wbkgd(byval as PDCWINDOW ptr, byval as chtype) as long
declare function wborder(byval as PDCWINDOW ptr, byval as chtype, byval as chtype, byval as chtype, byval as chtype, byval as chtype, byval as chtype, byval as chtype, byval as chtype) as long
declare function wchgat(byval as PDCWINDOW ptr, byval as long, byval as attr_t, byval as short, byval as const any ptr) as long
declare function wclear(byval as PDCWINDOW ptr) as long
declare function wclrtobot(byval as PDCWINDOW ptr) as long
declare function wclrtoeol(byval as PDCWINDOW ptr) as long
declare function wcolor_set(byval as PDCWINDOW ptr, byval as short, byval as any ptr) as long
declare sub wcursyncup(byval as PDCWINDOW ptr)
declare function wdelch(byval as PDCWINDOW ptr) as long
declare function wdeleteln(byval as PDCWINDOW ptr) as long
declare function wechochar(byval as PDCWINDOW ptr, byval as const chtype) as long
declare function werase(byval as PDCWINDOW ptr) as long
declare function wgetch(byval as PDCWINDOW ptr) as long
declare function wgetnstr(byval as PDCWINDOW ptr, byval as zstring ptr, byval as long) as long
declare function wgetstr(byval as PDCWINDOW ptr, byval as zstring ptr) as long
declare function whline(byval as PDCWINDOW ptr, byval as chtype, byval as long) as long
declare function winchnstr(byval as PDCWINDOW ptr, byval as chtype ptr, byval as long) as long
declare function winchstr(byval as PDCWINDOW ptr, byval as chtype ptr) as long
declare function winch(byval as PDCWINDOW ptr) as chtype
declare function winnstr(byval as PDCWINDOW ptr, byval as zstring ptr, byval as long) as long
declare function winsch(byval as PDCWINDOW ptr, byval as chtype) as long
declare function winsdelln(byval as PDCWINDOW ptr, byval as long) as long
declare function winsertln(byval as PDCWINDOW ptr) as long
declare function winsnstr(byval as PDCWINDOW ptr, byval as const zstring ptr, byval as long) as long
declare function winsstr(byval as PDCWINDOW ptr, byval as const zstring ptr) as long
declare function winstr(byval as PDCWINDOW ptr, byval as zstring ptr) as long
declare function wmove(byval as PDCWINDOW ptr, byval as long, byval as long) as long
declare function wnoutrefresh(byval as PDCWINDOW ptr) as long
declare function wprintw(byval as PDCWINDOW ptr, byval as const zstring ptr, ...) as long
declare function wredrawln(byval as PDCWINDOW ptr, byval as long, byval as long) as long
declare function wrefresh(byval as PDCWINDOW ptr) as long
declare function wscanw(byval as PDCWINDOW ptr, byval as const zstring ptr, ...) as long
declare function wscrl(byval as PDCWINDOW ptr, byval as long) as long
declare function wsetscrreg(byval as PDCWINDOW ptr, byval as long, byval as long) as long
declare function wstandend(byval as PDCWINDOW ptr) as long
declare function wstandout(byval as PDCWINDOW ptr) as long
declare sub wsyncdown(byval as PDCWINDOW ptr)
declare sub wsyncup(byval as PDCWINDOW ptr)
declare sub wtimeout(byval as PDCWINDOW ptr, byval as long)
declare function wtouchln(byval as PDCWINDOW ptr, byval as long, byval as long, byval as long) as long
declare function wvline(byval as PDCWINDOW ptr, byval as chtype, byval as long) as long

'' Wide-character functions
#ifdef PDC_WIDE
declare function addnwstr(byval as const wstring ptr, byval as long) as long
declare function addwstr(byval as const wstring ptr) as long
declare function add_wch(byval as const cchar_t ptr) as long
declare function add_wchnstr(byval as const cchar_t ptr, byval as long) as long
declare function add_wchstr(byval as const cchar_t ptr) as long
declare function border_set(byval as const cchar_t ptr, byval as const cchar_t ptr, byval as const cchar_t ptr, byval as const cchar_t ptr, byval as const cchar_t ptr, byval as const cchar_t ptr, byval as const cchar_t ptr, byval as const cchar_t ptr) as long
declare function box_set(byval as PDCWINDOW ptr, byval as const cchar_t ptr, byval as const cchar_t ptr) as long
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
declare function mvwaddnwstr(byval as PDCWINDOW ptr, byval as long, byval as long, byval as const wstring ptr, byval as long) as long
declare function mvwaddwstr(byval as PDCWINDOW ptr, byval as long, byval as long, byval as const wstring ptr) as long
declare function mvwadd_wch(byval as PDCWINDOW ptr, byval as long, byval as long, byval as const cchar_t ptr) as long
declare function mvwadd_wchnstr(byval as PDCWINDOW ptr, byval as long, byval as long, byval as const cchar_t ptr, byval as long) as long
declare function mvwadd_wchstr(byval as PDCWINDOW ptr, byval as long, byval as long, byval as const cchar_t ptr) as long
declare function mvwgetn_wstr(byval as PDCWINDOW ptr, byval as long, byval as long, byval as wint_t ptr, byval as long) as long
declare function mvwget_wch(byval as PDCWINDOW ptr, byval as long, byval as long, byval as wint_t ptr) as long
declare function mvwget_wstr(byval as PDCWINDOW ptr, byval as long, byval as long, byval as wint_t ptr) as long
declare function mvwhline_set(byval as PDCWINDOW ptr, byval as long, byval as long, byval as const cchar_t ptr, byval as long) as long
declare function mvwinnwstr(byval as PDCWINDOW ptr, byval as long, byval as long, byval as wstring ptr, byval as long) as long
declare function mvwins_nwstr(byval as PDCWINDOW ptr, byval as long, byval as long, byval as const wstring ptr, byval as long) as long
declare function mvwins_wch(byval as PDCWINDOW ptr, byval as long, byval as long, byval as const cchar_t ptr) as long
declare function mvwins_wstr(byval as PDCWINDOW ptr, byval as long, byval as long, byval as const wstring ptr) as long
declare function mvwin_wch(byval as PDCWINDOW ptr, byval as long, byval as long, byval as cchar_t ptr) as long
declare function mvwin_wchnstr(byval as PDCWINDOW ptr, byval as long, byval as long, byval as cchar_t ptr, byval as long) as long
declare function mvwin_wchstr(byval as PDCWINDOW ptr, byval as long, byval as long, byval as cchar_t ptr) as long
declare function mvwinwstr(byval as PDCWINDOW ptr, byval as long, byval as long, byval as wstring ptr) as long
declare function mvwvline_set(byval as PDCWINDOW ptr, byval as long, byval as long, byval as const cchar_t ptr, byval as long) as long
declare function pecho_wchar(byval as PDCWINDOW ptr, byval as const cchar_t ptr) as long
declare function setcchar(byval as cchar_t ptr, byval as const wstring ptr, byval as const attr_t, byval as short, byval as const any ptr) as long
declare function slk_wset(byval as long, byval as const wstring ptr, byval as long) as long
declare function unget_wch(byval as const wchar_t) as long
declare function vline_set(byval as const cchar_t ptr, byval as long) as long
declare function waddnwstr(byval as PDCWINDOW ptr, byval as const wstring ptr, byval as long) as long
declare function waddwstr(byval as PDCWINDOW ptr, byval as const wstring ptr) as long
declare function wadd_wch(byval as PDCWINDOW ptr, byval as const cchar_t ptr) as long
declare function wadd_wchnstr(byval as PDCWINDOW ptr, byval as const cchar_t ptr, byval as long) as long
declare function wadd_wchstr(byval as PDCWINDOW ptr, byval as const cchar_t ptr) as long
declare function wbkgrnd(byval as PDCWINDOW ptr, byval as const cchar_t ptr) as long
declare sub wbkgrndset(byval as PDCWINDOW ptr, byval as const cchar_t ptr)
declare function wborder_set(byval as PDCWINDOW ptr, byval as const cchar_t ptr, byval as const cchar_t ptr, byval as const cchar_t ptr, byval as const cchar_t ptr, byval as const cchar_t ptr, byval as const cchar_t ptr, byval as const cchar_t ptr, byval as const cchar_t ptr) as long
declare function wecho_wchar(byval as PDCWINDOW ptr, byval as const cchar_t ptr) as long
declare function wgetbkgrnd(byval as PDCWINDOW ptr, byval as cchar_t ptr) as long
declare function wgetn_wstr(byval as PDCWINDOW ptr, byval as wint_t ptr, byval as long) as long
declare function wget_wch(byval as PDCWINDOW ptr, byval as wint_t ptr) as long
declare function wget_wstr(byval as PDCWINDOW ptr, byval as wint_t ptr) as long
declare function whline_set(byval as PDCWINDOW ptr, byval as const cchar_t ptr, byval as long) as long
declare function winnwstr(byval as PDCWINDOW ptr, byval as wstring ptr, byval as long) as long
declare function wins_nwstr(byval as PDCWINDOW ptr, byval as const wstring ptr, byval as long) as long
declare function wins_wch(byval as PDCWINDOW ptr, byval as const cchar_t ptr) as long
declare function wins_wstr(byval as PDCWINDOW ptr, byval as const wstring ptr) as long
declare function winwstr(byval as PDCWINDOW ptr, byval as wstring ptr) as long
declare function win_wch(byval as PDCWINDOW ptr, byval as cchar_t ptr) as long
declare function win_wchnstr(byval as PDCWINDOW ptr, byval as cchar_t ptr, byval as long) as long
declare function win_wchstr(byval as PDCWINDOW ptr, byval as cchar_t ptr) as long
declare function wunctrl(byval as cchar_t ptr) as wstring ptr
declare function wvline_set(byval as PDCWINDOW ptr, byval as const cchar_t ptr, byval as long) as long
#endif

'' Quasi-standard
declare function getattrs(byval as PDCWINDOW ptr) as chtype
declare function getbegx(byval as PDCWINDOW ptr) as long
declare function getbegy(byval as PDCWINDOW ptr) as long
declare function getmaxx(byval as PDCWINDOW ptr) as long
declare function getmaxy(byval as PDCWINDOW ptr) as long
declare function getparx(byval as PDCWINDOW ptr) as long
declare function getpary(byval as PDCWINDOW ptr) as long
declare function getcurx(byval as PDCWINDOW ptr) as long
declare function getcury(byval as PDCWINDOW ptr) as long
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

declare function mouse_set(byval as ulong) as long
declare function mouse_on(byval as ulong) as long
declare function mouse_off(byval as ulong) as long
declare function request_mouse_pos() as long
declare function map_button(byval as ulong) as long
declare sub wmouse_position(byval as PDCWINDOW ptr, byval as long ptr, byval as long ptr)
declare function pdcgetmouse() as ulong
declare function getbmap() as ulong

'' ncurses
declare function assume_default_colors(byval as long, byval as long) as long
declare function curses_version() as const zstring ptr
declare function has_key(byval as long) as bool
declare function use_default_colors() as long
declare function wresize(byval as PDCWINDOW ptr, byval as long, byval as long) as long

declare function mouseinterval(byval as long) as long
declare function mousemask(byval as mmask_t, byval as mmask_t ptr) as mmask_t
declare function mouse_trafo(byval as long ptr, byval as long ptr, byval as bool) as bool
declare function nc_getmouse(byval as MEVENT ptr) as long
declare function ungetmouse(byval as MEVENT ptr) as long
declare function wenclose(byval as const PDCWINDOW ptr, byval as long, byval as long) as bool
declare function wmouse_trafo(byval as const PDCWINDOW ptr, byval as long ptr, byval as long ptr, byval as bool) as bool

'' PDCurses
declare function addrawch(byval as chtype) as long
declare function insrawch(byval as chtype) as long
declare function is_termresized() as bool
declare function mvaddrawch(byval as long, byval as long, byval as chtype) as long
declare function mvdeleteln(byval as long, byval as long) as long
declare function mvinsertln(byval as long, byval as long) as long
declare function mvinsrawch(byval as long, byval as long, byval as chtype) as long
declare function mvwaddrawch(byval as PDCWINDOW ptr, byval as long, byval as long, byval as chtype) as long
declare function mvwdeleteln(byval as PDCWINDOW ptr, byval as long, byval as long) as long
declare function mvwinsertln(byval as PDCWINDOW ptr, byval as long, byval as long) as long
declare function mvwinsrawch(byval as PDCWINDOW ptr, byval as long, byval as long, byval as chtype) as long
declare function raw_output(byval as bool) as long
declare function resize_term(byval as long, byval as long) as long
declare function resize_window(byval as PDCWINDOW ptr, byval as long, byval as long) as PDCWINDOW ptr
declare function waddrawch(byval as PDCWINDOW ptr, byval as chtype) as long
declare function winsrawch(byval as PDCWINDOW ptr, byval as chtype) as long
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
declare function PDC_getclipboard(byval as zstring ptr ptr, byval as long ptr) as long
declare function PDC_setclipboard(byval as const zstring ptr, byval as long) as long

declare function PDC_get_input_fd() as ulong
declare function PDC_get_key_modifiers() as ulong
declare function PDC_return_key_modifiers(byval as bool) as long
declare function PDC_save_key_modifiers(byval as bool) as long

#ifdef XCURSES
declare function Xinitscr(byval as long, byval as zstring ptr ptr) as PDCWINDOW ptr
declare sub XCursesExit()
declare function sb_init() as long
declare function sb_set_horz(byval as long, byval as long, byval as long) as long
declare function sb_set_vert(byval as long, byval as long, byval as long) as long
declare function sb_get_horz(byval as long ptr, byval as long ptr, byval as long ptr) as long
declare function sb_get_vert(byval as long ptr, byval as long ptr, byval as long ptr) as long
declare function sb_refresh() as long
#endif

''** Functions defined as macros **

'' getch() and ungetch() conflict with some DOS libraries
#define getch()            wgetch(stdscr)
#define ungetch(ch)        PDC_ungetch(ch)

#define COLOR_PAIR(n)      ((cast(chtype, (n)) shl PDC_COLOR_SHIFT) and A_COLOR)
#define PAIR_NUMBER(n)     (((n) and A_COLOR) shr PDC_COLOR_SHIFT)

'' These will _only_ work as macros
#define getbegyx(w, y, x)  y = getbegy(w) : x = getbegx(w)
#define getmaxyx(w, y, x)  y = getmaxy(w) : x = getmaxx(w)
#define getparyx(w, y, x)  y = getpary(w) : x = getparx(w)
#define getyx(w, y, x)     y = getcury(w) : x = getcurx(w)

#macro getsyx(y, x)
	if curscr->_leaveit then
		(y) = -1
		(x) = -1
	else
		getyx(curscr,(y),(x))
	end if
#endmacro

'' return codes from PDC_getclipboard() and PDC_setclipboard() calls
#define PDC_CLIP_SUCCESS 0
#define PDC_CLIP_ACCESS_ERROR 1
#define PDC_CLIP_EMPTY 2
#define PDC_CLIP_MEMORY_ERROR 3

'' PDCurses key modifier masks
#define PDC_KEY_MODIFIER_SHIFT 1
#define PDC_KEY_MODIFIER_CONTROL 2
#define PDC_KEY_MODIFIER_ALT 4
#define PDC_KEY_MODIFIER_NUMLOCK 8

end extern
