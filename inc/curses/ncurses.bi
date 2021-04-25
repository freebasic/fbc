'' FreeBASIC binding for ncurses-5.9
''
'' based on the C header files:
''   /****************************************************************************
''    * Copyright (c) 1998-2010,2011 Free Software Foundation, Inc.              *
''    *                                                                          *
''    * Permission is hereby granted, free of charge, to any person obtaining a  *
''    * copy of this software and associated documentation files (the            *
''    * "Software"), to deal in the Software without restriction, including      *
''    * without limitation the rights to use, copy, modify, merge, publish,      *
''    * distribute, distribute with modifications, sublicense, and/or sell       *
''    * copies of the Software, and to permit persons to whom the Software is    *
''    * furnished to do so, subject to the following conditions:                 *
''    *                                                                          *
''    * The above copyright notice and this permission notice shall be included  *
''    * in all copies or substantial portions of the Software.                   *
''    *                                                                          *
''    * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS  *
''    * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF               *
''    * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.   *
''    * IN NO EVENT SHALL THE ABOVE COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,   *
''    * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR    *
''    * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR    *
''    * THE USE OR OTHER DEALINGS IN THE SOFTWARE.                               *
''    *                                                                          *
''    * Except as contained in this notice, the name(s) of the above copyright   *
''    * holders shall not be used in advertising or otherwise to promote the     *
''    * sale, use or other dealings in this Software without prior written       *
''    * authorization.                                                           *
''    ****************************************************************************/
''
'' translated to FreeBASIC by:
''   Copyright © 2021 FreeBASIC development team

#pragma once

#inclib "curses"

#include once "crt/long.bi"
#include once "crt/stdio.bi"
#include once "crt/stdarg.bi"

'' The following symbols have been renamed:
''     constant TRUE => CTRUE
''     #define NCURSES_BOOL => NCURSES_BOOL_
''     constant ERR => ERR_
''     typedef SCREEN => SCREEN_
''     typedef WINDOW => WINDOW_
''     procedure beep => beep_
''     #define clear => clear_
''     #define erase => erase_
''     #define instr => instr_
''     #define slk_attr_off => slk_attr_off_
''     #define slk_attr_on => slk_attr_on_
''     procedure getmouse => getmouse_
''     procedure mouse_trafo => mouse_trafo_

extern "C"

#define __NCURSES_H
const CURSES = 1
const CURSES_H = 1
const NCURSES_VERSION_MAJOR = 5
const NCURSES_VERSION_MINOR = 9
const NCURSES_VERSION_PATCH = 20110404
#undef NCURSES_VERSION
#define NCURSES_VERSION "5.9"
const NCURSES_MOUSE_VERSION = 1
const NCURSES_DLL_H_incl = 1
#undef NCURSES_DLL
const NCURSES_ENABLE_STDBOOL_H = 1
type NCURSES_ATTR_T as long
#undef NCURSES_COLOR_T
type NCURSES_COLOR_T as short
const NCURSES_OPAQUE = 0
const NCURSES_REENTRANT = 0
#undef NCURSES_INTEROP_FUNCS
const NCURSES_INTEROP_FUNCS = 0
#undef NCURSES_SIZE_T
type NCURSES_SIZE_T as short
#undef NCURSES_TPARM_VARARGS
const NCURSES_TPARM_VARARGS = 1
#undef NCURSES_CH_T

type NCURSES_CH_T as chtype
type chtype as ulong
type mmask_t as culong
#undef NCURSES_WIDECHAR
#ifndef CTRUE
	const CTRUE = 1
#endif
#ifndef TRUE
	const TRUE = 1
#endif
#ifndef FALSE
	const FALSE = 0
#endif
type NCURSES_BOOL as ubyte

#define NCURSES_BOOL_ bool
#define NCURSES_CAST(type, value) cast(type, value)
#define WA_ATTRIBUTES A_ATTRIBUTES
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
#define WA_VERTICAL A_VERTICAL
const COLOR_BLACK = 0
const COLOR_RED = 1
const COLOR_GREEN = 2
const COLOR_YELLOW = 3
const COLOR_BLUE = 4
const COLOR_MAGENTA = 5
const COLOR_CYAN = 6
const COLOR_WHITE = 7
#define acs_map(i) ((@__acs_map)[i])
extern __acs_map alias "acs_map" as chtype
#define NCURSES_ACS(c) (acs_map(cubyte(c)))
#define ACS_ULCORNER NCURSES_ACS(asc("l"))
#define ACS_LLCORNER NCURSES_ACS(asc("m"))
#define ACS_URCORNER NCURSES_ACS(asc("k"))
#define ACS_LRCORNER NCURSES_ACS(asc("j"))
#define ACS_LTEE NCURSES_ACS(asc("t"))
#define ACS_RTEE NCURSES_ACS(asc("u"))
#define ACS_BTEE NCURSES_ACS(asc("v"))
#define ACS_TTEE NCURSES_ACS(asc("w"))
#define ACS_HLINE NCURSES_ACS(asc("q"))
#define ACS_VLINE NCURSES_ACS(asc("x"))
#define ACS_PLUS NCURSES_ACS(asc("n"))
#define ACS_S1 NCURSES_ACS(asc("o"))
#define ACS_S9 NCURSES_ACS(asc("s"))
#define ACS_DIAMOND NCURSES_ACS(asc("`"))
#define ACS_CKBOARD NCURSES_ACS(asc("a"))
#define ACS_DEGREE NCURSES_ACS(asc("f"))
#define ACS_PLMINUS NCURSES_ACS(asc("g"))
#define ACS_BULLET NCURSES_ACS(asc("~"))
#define ACS_LARROW NCURSES_ACS(asc(","))
#define ACS_RARROW NCURSES_ACS(asc("+"))
#define ACS_DARROW NCURSES_ACS(asc("."))
#define ACS_UARROW NCURSES_ACS(asc("-"))
#define ACS_BOARD NCURSES_ACS(asc("h"))
#define ACS_LANTERN NCURSES_ACS(asc("i"))
#define ACS_BLOCK NCURSES_ACS(asc("0"))
#define ACS_S3 NCURSES_ACS(asc("p"))
#define ACS_S7 NCURSES_ACS(asc("r"))
#define ACS_LEQUAL NCURSES_ACS(asc("y"))
#define ACS_GEQUAL NCURSES_ACS(asc("z"))
#define ACS_PI NCURSES_ACS(asc("{"))
#define ACS_NEQUAL NCURSES_ACS(asc("|"))
#define ACS_STERLING NCURSES_ACS(asc("}"))
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
#undef ERR_
const ERR_ = -1
#undef OK
const OK = 0
const _SUBWIN = &h01
const _ENDLINE = &h02
const _FULLWIN = &h04
const _SCROLLWIN = &h08
const _ISPAD = &h10
const _HASMOVED = &h20
const _WRAPPED = &h40
const _NOCHANGE = -1
const _NEWINDEX = -1
type WINDOW_ as _win_st
type attr_t as chtype

type pdat
	_pad_y as short
	_pad_x as short
	_pad_top as short
	_pad_left as short
	_pad_bottom as short
	_pad_right as short
end type

type ldat as ldat_

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
	_notimeout as byte
	_clear as byte
	_leaveok as byte
	_scroll as byte
	_idlok as byte
	_idcok as byte
	_immed as byte
	_sync as byte
	_use_keypad as byte
	_delay as long
	_line as ldat ptr
	_regtop as short
	_regbottom as short
	_parx as long
	_pary as long
	_parent as WINDOW_ ptr
	_pad as pdat
	_yoffset as short
end type

type NCURSES_OUTC as function(byval as long) as long
declare function baudrate() as long
declare function beep_ alias "beep"() as long
declare function can_change_color() as byte
declare function cbreak() as long
declare function clearok(byval as WINDOW_ ptr, byval as byte) as long
declare function color_content(byval as short, byval as short ptr, byval as short ptr, byval as short ptr) as long
declare function copywin(byval as const WINDOW_ ptr, byval as WINDOW_ ptr, byval as long, byval as long, byval as long, byval as long, byval as long, byval as long, byval as long) as long
declare function curs_set(byval as long) as long
declare function def_prog_mode() as long
declare function def_shell_mode() as long
declare function delay_output(byval as long) as long
type SCREEN_ as SCREEN__
declare sub delscreen(byval as SCREEN_ ptr)
declare function delwin(byval as WINDOW_ ptr) as long
declare function derwin(byval as WINDOW_ ptr, byval as long, byval as long, byval as long, byval as long) as WINDOW_ ptr
declare function doupdate() as long
declare function dupwin(byval as WINDOW_ ptr) as WINDOW_ ptr
declare function echo() as long
declare function endwin() as long
declare function erasechar() as byte
declare sub filter()
declare function flash() as long
declare function flushinp() as long
declare function getwin(byval as FILE ptr) as WINDOW_ ptr
declare function halfdelay(byval as long) as long
declare function has_colors() as byte
declare function has_ic() as byte
declare function has_il() as byte
declare sub idcok(byval as WINDOW_ ptr, byval as byte)
declare function idlok(byval as WINDOW_ ptr, byval as byte) as long
declare sub immedok(byval as WINDOW_ ptr, byval as byte)
declare function initscr() as WINDOW_ ptr
declare function init_color(byval as short, byval as short, byval as short, byval as short) as long
declare function init_pair(byval as short, byval as short, byval as short) as long
declare function intrflush(byval as WINDOW_ ptr, byval as byte) as long
declare function isendwin() as byte
declare function is_linetouched(byval as WINDOW_ ptr, byval as long) as byte
declare function is_wintouched(byval as WINDOW_ ptr) as byte
declare function keyname(byval as long) as zstring ptr
declare function keypad(byval as WINDOW_ ptr, byval as byte) as long
declare function killchar() as byte
declare function leaveok(byval as WINDOW_ ptr, byval as byte) as long
declare function longname() as zstring ptr
declare function meta(byval as WINDOW_ ptr, byval as byte) as long
declare function mvcur(byval as long, byval as long, byval as long, byval as long) as long
declare function mvderwin(byval as WINDOW_ ptr, byval as long, byval as long) as long
declare function mvprintw(byval as long, byval as long, byval as const zstring ptr, ...) as long
declare function mvscanw(byval as long, byval as long, byval as zstring ptr, ...) as long
declare function mvwin(byval as WINDOW_ ptr, byval as long, byval as long) as long
declare function mvwprintw(byval as WINDOW_ ptr, byval as long, byval as long, byval as const zstring ptr, ...) as long
declare function mvwscanw(byval as WINDOW_ ptr, byval as long, byval as long, byval as zstring ptr, ...) as long
declare function napms(byval as long) as long
declare function newpad(byval as long, byval as long) as WINDOW_ ptr
declare function newterm(byval as zstring ptr, byval as FILE ptr, byval as FILE ptr) as SCREEN_ ptr
declare function newwin(byval as long, byval as long, byval as long, byval as long) as WINDOW_ ptr
declare function nl() as long
declare function nocbreak() as long
declare function nodelay(byval as WINDOW_ ptr, byval as byte) as long
declare function noecho() as long
declare function nonl() as long
declare sub noqiflush()
declare function noraw() as long
declare function notimeout(byval as WINDOW_ ptr, byval as byte) as long
declare function overlay(byval as const WINDOW_ ptr, byval as WINDOW_ ptr) as long
declare function overwrite(byval as const WINDOW_ ptr, byval as WINDOW_ ptr) as long
declare function pair_content(byval as short, byval as short ptr, byval as short ptr) as long
declare function pechochar(byval as WINDOW_ ptr, byval as const chtype) as long
declare function pnoutrefresh(byval as WINDOW_ ptr, byval as long, byval as long, byval as long, byval as long, byval as long, byval as long) as long
declare function prefresh(byval as WINDOW_ ptr, byval as long, byval as long, byval as long, byval as long, byval as long, byval as long) as long
declare function printw(byval as const zstring ptr, ...) as long
declare function putwin(byval as WINDOW_ ptr, byval as FILE ptr) as long
declare sub qiflush()
declare function raw() as long
declare function resetty() as long
declare function reset_prog_mode() as long
declare function reset_shell_mode() as long
declare function ripoffline(byval as long, byval as function(byval as WINDOW_ ptr, byval as long) as long) as long
declare function savetty() as long
declare function scanw(byval as zstring ptr, ...) as long
declare function scr_dump(byval as const zstring ptr) as long
declare function scr_init(byval as const zstring ptr) as long
declare function scrollok(byval as WINDOW_ ptr, byval as byte) as long
declare function scr_restore(byval as const zstring ptr) as long
declare function scr_set(byval as const zstring ptr) as long
declare function set_term(byval as SCREEN_ ptr) as SCREEN_ ptr
declare function slk_attroff(byval as const chtype) as long
declare function slk_attr_off(byval as const attr_t, byval as any ptr) as long
declare function slk_attron(byval as const chtype) as long
declare function slk_attr_on(byval as attr_t, byval as any ptr) as long
declare function slk_attrset(byval as const chtype) as long
declare function slk_attr() as attr_t
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
declare function start_color() as long
declare function subpad(byval as WINDOW_ ptr, byval as long, byval as long, byval as long, byval as long) as WINDOW_ ptr
declare function subwin(byval as WINDOW_ ptr, byval as long, byval as long, byval as long, byval as long) as WINDOW_ ptr
declare function syncok(byval as WINDOW_ ptr, byval as byte) as long
declare function termattrs() as chtype
declare function termname() as zstring ptr
declare function typeahead(byval as long) as long
declare function ungetch(byval as long) as long
declare sub use_env(byval as byte)
declare function vidattr(byval as chtype) as long
declare function vidputs(byval as chtype, byval as NCURSES_OUTC) as long
declare function vwprintw(byval as WINDOW_ ptr, byval as const zstring ptr, byval as va_list) as long
declare function vwscanw(byval as WINDOW_ ptr, byval as zstring ptr, byval as va_list) as long
declare function waddch(byval as WINDOW_ ptr, byval as const chtype) as long
declare function waddchnstr(byval as WINDOW_ ptr, byval as const chtype ptr, byval as long) as long
declare function waddnstr(byval as WINDOW_ ptr, byval as const zstring ptr, byval as long) as long
declare function wattr_on(byval as WINDOW_ ptr, byval as attr_t, byval as any ptr) as long
declare function wattr_off(byval as WINDOW_ ptr, byval as attr_t, byval as any ptr) as long
declare function wbkgd(byval as WINDOW_ ptr, byval as chtype) as long
declare sub wbkgdset(byval as WINDOW_ ptr, byval as chtype)
declare function wborder(byval as WINDOW_ ptr, byval as chtype, byval as chtype, byval as chtype, byval as chtype, byval as chtype, byval as chtype, byval as chtype, byval as chtype) as long
declare function wchgat(byval as WINDOW_ ptr, byval as long, byval as attr_t, byval as short, byval as const any ptr) as long
declare function wclear(byval as WINDOW_ ptr) as long
declare function wclrtobot(byval as WINDOW_ ptr) as long
declare function wclrtoeol(byval as WINDOW_ ptr) as long
declare function wcolor_set(byval as WINDOW_ ptr, byval as short, byval as any ptr) as long
declare sub wcursyncup(byval as WINDOW_ ptr)
declare function wdelch(byval as WINDOW_ ptr) as long
declare function wechochar(byval as WINDOW_ ptr, byval as const chtype) as long
declare function werase(byval as WINDOW_ ptr) as long
declare function wgetch(byval as WINDOW_ ptr) as long
declare function wgetnstr(byval as WINDOW_ ptr, byval as zstring ptr, byval as long) as long
declare function whline(byval as WINDOW_ ptr, byval as chtype, byval as long) as long
declare function winch(byval as WINDOW_ ptr) as chtype
declare function winchnstr(byval as WINDOW_ ptr, byval as chtype ptr, byval as long) as long
declare function winnstr(byval as WINDOW_ ptr, byval as zstring ptr, byval as long) as long
declare function winsch(byval as WINDOW_ ptr, byval as chtype) as long
declare function winsdelln(byval as WINDOW_ ptr, byval as long) as long
declare function winsnstr(byval as WINDOW_ ptr, byval as const zstring ptr, byval as long) as long
declare function wmove(byval as WINDOW_ ptr, byval as long, byval as long) as long
declare function wnoutrefresh(byval as WINDOW_ ptr) as long
declare function wprintw(byval as WINDOW_ ptr, byval as const zstring ptr, ...) as long
declare function wredrawln(byval as WINDOW_ ptr, byval as long, byval as long) as long
declare function wrefresh(byval as WINDOW_ ptr) as long
declare function wscanw(byval as WINDOW_ ptr, byval as zstring ptr, ...) as long
declare function wscrl(byval as WINDOW_ ptr, byval as long) as long
declare function wsetscrreg(byval as WINDOW_ ptr, byval as long, byval as long) as long
declare sub wsyncdown(byval as WINDOW_ ptr)
declare sub wsyncup(byval as WINDOW_ ptr)
declare sub wtimeout(byval as WINDOW_ ptr, byval as long)
declare function wtouchln(byval as WINDOW_ ptr, byval as long, byval as long, byval as long) as long
declare function wvline(byval as WINDOW_ ptr, byval as chtype, byval as long) as long
declare function tigetflag(byval as zstring ptr) as long
declare function tigetnum(byval as zstring ptr) as long
declare function tigetstr(byval as zstring ptr) as zstring ptr
declare function putp(byval as const zstring ptr) as long
declare function tparm(byval as zstring ptr, ...) as zstring ptr
declare function tiparm(byval as const zstring ptr, ...) as zstring ptr
#define vid_attr(a, pair, opts) vidattr(a)
#undef NCURSES_EXT_FUNCS
const NCURSES_EXT_FUNCS = 20110404
type NCURSES_WINDOW_CB as function(byval as WINDOW_ ptr, byval as any ptr) as long
type NCURSES_SCREEN_CB as function(byval as SCREEN_ ptr, byval as any ptr) as long
declare function is_term_resized(byval as long, byval as long) as byte
declare function keybound(byval as long, byval as long) as zstring ptr
declare function curses_version() as const zstring ptr
declare function assume_default_colors(byval as long, byval as long) as long
declare function define_key(byval as const zstring ptr, byval as long) as long
declare function get_escdelay() as long
declare function key_defined(byval as const zstring ptr) as long
declare function keyok(byval as long, byval as byte) as long
declare function resize_term(byval as long, byval as long) as long
declare function resizeterm(byval as long, byval as long) as long
declare function set_escdelay(byval as long) as long
declare function set_tabsize(byval as long) as long
declare function use_default_colors() as long
declare function use_extended_names(byval as byte) as long
declare function use_legacy_coding(byval as long) as long
declare function use_screen(byval as SCREEN_ ptr, byval as NCURSES_SCREEN_CB, byval as any ptr) as long
declare function use_window(byval as WINDOW_ ptr, byval as NCURSES_WINDOW_CB, byval as any ptr) as long
declare function wresize(byval as WINDOW_ ptr, byval as long, byval as long) as long
declare sub nofilter()
#undef NCURSES_SP_FUNCS
const NCURSES_SP_FUNCS = 0
#define NCURSES_SP_NAME(name) name
type NCURSES_SP_OUTC as NCURSES_OUTC

const NCURSES_ATTR_SHIFT = 8
#define NCURSES_BITS(mask, shift) ((mask) shl ((shift) + NCURSES_ATTR_SHIFT))
const A_NORMAL = culng(1u - 1u)
const WA_NORMAL = A_NORMAL
#define A_ATTRIBUTES NCURSES_BITS(culng(not culng(1u - 1u)), 0)
#define A_CHARTEXT (NCURSES_BITS(1u, 0) - 1u)
#define A_COLOR NCURSES_BITS(culng(culng(1u shl 8) - 1u), 0)
#define A_STANDOUT NCURSES_BITS(1u, 8)
#define A_UNDERLINE NCURSES_BITS(1u, 9)
#define A_REVERSE NCURSES_BITS(1u, 10)
#define A_BLINK NCURSES_BITS(1u, 11)
#define A_DIM NCURSES_BITS(1u, 12)
#define A_BOLD NCURSES_BITS(1u, 13)
#define A_ALTCHARSET NCURSES_BITS(1u, 14)
#define A_INVIS NCURSES_BITS(1u, 15)
#define A_PROTECT NCURSES_BITS(1u, 16)
#define A_HORIZONTAL NCURSES_BITS(1u, 17)
#define A_LEFT NCURSES_BITS(1u, 18)
#define A_LOW NCURSES_BITS(1u, 19)
#define A_RIGHT NCURSES_BITS(1u, 20)
#define A_TOP NCURSES_BITS(1u, 21)
#define A_VERTICAL NCURSES_BITS(1u, 22)
#macro getyx(win, y, x)
	scope
		y = getcury(win)
		x = getcurx(win)
	end scope
#endmacro
#macro getbegyx(win, y, x)
	scope
		y = getbegy(win)
		x = getbegx(win)
	end scope
#endmacro
#macro getmaxyx(win, y, x)
	scope
		y = getmaxy(win)
		x = getmaxx(win)
	end scope
#endmacro
#macro getparyx(win, y, x)
	scope
		y = getpary(win)
		x = getparx(win)
	end scope
#endmacro
#macro getsyx(y, x)
	if newscr then
		if is_leaveok(newscr) then
			(x) = -1
			(y) = -1
		else
			getyx(newscr, (y), (x))
		end if
	end if
#endmacro
#macro setsyx(y, x)
	if newscr then
		if ((y) = (-1)) andalso ((x) = (-1)) then
			leaveok(newscr, CTRUE)
		else
			leaveok(newscr, FALSE)
			wmove(newscr, (y), (x))
		end if
	end if
#endmacro
#define wgetstr(w, s) wgetnstr(w, s, -1)
#define getnstr(s, n) wgetnstr(stdscr, s, n)
#define setterm(term) setupterm(term, 1, cptr(long ptr, 0))
#define fixterm() reset_prog_mode()
#define resetterm() reset_shell_mode()
#define saveterm() def_prog_mode()
#define crmode() cbreak()
#define nocrmode() nocbreak()
#define gettmode()
#define getattrs(win) clng(iif((win), (win)->_attrs, A_NORMAL))
#define getcurx(win) iif((win), (win)->_curx, ERR_)
#define getcury(win) iif((win), (win)->_cury, ERR_)
#define getbegx(win) iif((win), (win)->_begx, ERR_)
#define getbegy(win) iif((win), (win)->_begy, ERR_)
#define getmaxx(win) iif((win), (win)->_maxx + 1, ERR_)
#define getmaxy(win) iif((win), (win)->_maxy + 1, ERR_)
#define getparx(win) iif((win), (win)->_parx, ERR_)
#define getpary(win) iif((win), (win)->_pary, ERR_)
#define wstandout(win) wattrset(win, A_STANDOUT)
#define wstandend(win) wattrset(win, A_NORMAL)
#define wattron(win, at) wattr_on(win, NCURSES_CAST(attr_t, at), NULL)
#define wattroff(win, at) wattr_off(win, NCURSES_CAST(attr_t, at), NULL)
#macro wattrset(win,at)
	if (win) then
		(win)->_attrs = NCURSES_CAST(attr_t, at)
	end if
#endmacro
#define scroll(win) wscrl(win, 1)
#define touchwin(win) wtouchln((win), 0, getmaxy(win), 1)
#define touchline(win, s, c) wtouchln((win), s, c, 1)
#define untouchwin(win) wtouchln((win), 0, getmaxy(win), 0)
#define box(win, v, h) wborder(win, v, v, h, h, 0, 0, 0, 0)
#define border(ls, rs, ts, bs, tl, tr, bl, br) wborder(stdscr, ls, rs, ts, bs, tl, tr, bl, br)
#define hline(ch, n) whline(stdscr, ch, n)
#define vline(ch, n) wvline(stdscr, ch, n)
#define winstr(w, s) winnstr(w, s, -1)
#define winchstr(w, s) winchnstr(w, s, -1)
#define winsstr(w, s) winsnstr(w, s, -1)
#define redrawwin(win) wredrawln(win, 0, (win)->_maxy + 1)
#define waddstr(win, str) waddnstr(win, str, -1)
#define waddchstr(win, str) waddchnstr(win, str, -1)
#define COLOR_PAIR(n) NCURSES_BITS(n, 0)
#define PAIR_NUMBER(a) clng((cast(culong,a) and A_COLOR) shr NCURSES_ATTR_SHIFT)
#define addch(ch) waddch(stdscr, ch)
#define addchnstr(str, n) waddchnstr(stdscr, str, n)
#define addchstr(str) waddchstr(stdscr, str)
#define addnstr(str, n) waddnstr(stdscr, str, n)
#define addstr(str) waddnstr(stdscr, str, -1)
#define attroff(at) wattroff(stdscr, at)
#define attron(at) wattron(stdscr, at)
#define attrset(at) wattrset(stdscr, at)
#define attr_get(ap, cp, o) wattr_get(stdscr, ap, cp, o)
#define attr_off(a, o) wattr_off(stdscr, a, o)
#define attr_on(a, o) wattr_on(stdscr, a, o)
#define attr_set(a, c, o) wattr_set(stdscr, a, c, o)
#define bkgd(ch) wbkgd(stdscr, ch)
#define bkgdset(ch) wbkgdset(stdscr, ch)
#define chgat(n, a, c, o) wchgat(stdscr, n, a, c, o)
#define clear_() wclear(stdscr)
#define clrtobot() wclrtobot(stdscr)
#define clrtoeol() wclrtoeol(stdscr)
#define color_set(c, o) wcolor_set(stdscr, c, o)
#define delch() wdelch(stdscr)
#define deleteln() winsdelln(stdscr, -1)
#define echochar(c) wechochar(stdscr, c)
#define erase_() werase(stdscr)
#define getch() wgetch(stdscr)
#define getstr(str) wgetstr(stdscr, str)
#define inch() winch(stdscr)
#define inchnstr(s, n) winchnstr(stdscr, s, n)
#define inchstr(s) winchstr(stdscr, s)
#define innstr(s, n) winnstr(stdscr, s, n)
#define insch(c) winsch(stdscr, c)
#define insdelln(n) winsdelln(stdscr, n)
#define insertln() winsdelln(stdscr, 1)
#define insnstr(s, n) winsnstr(stdscr, s, n)
#define insstr(s) winsstr(stdscr, s)
#define instr_(s) winstr(stdscr, s)
#define move(y, x) wmove(stdscr, y, x)
#define refresh() wrefresh(stdscr)
#define scrl(n) wscrl(stdscr, n)
#define setscrreg(t, b) wsetscrreg(stdscr, t, b)
#define standend() wstandend(stdscr)
#define standout() wstandout(stdscr)
#define timeout(delay) wtimeout(stdscr, delay)
#define wdeleteln(win) winsdelln(win, -1)
#define winsertln(win) winsdelln(win, 1)
#define mvwaddch(win, y, x, ch) iif(wmove(win, y, x) = ERR_, ERR_, waddch(win, ch))
#define mvwaddchnstr(win, y, x, str, n) iif(wmove(win, y, x) = ERR_, ERR_, waddchnstr(win, str, n))
#define mvwaddchstr(win, y, x, str) iif(wmove(win, y, x) = ERR_, ERR_, waddchnstr(win, str, -1))
#define mvwaddnstr(win, y, x, str, n) iif(wmove(win, y, x) = ERR_, ERR_, waddnstr(win, str, n))
#define mvwaddstr(win, y, x, str) iif(wmove(win, y, x) = ERR_, ERR_, waddnstr(win, str, -1))
#define mvwdelch(win, y, x) iif(wmove(win, y, x) = ERR_, ERR_, wdelch(win))
#define mvwchgat(win, y, x, n, a, c, o) iif(wmove(win, y, x) = ERR_, ERR_, wchgat(win, n, a, c, o))
#define mvwgetch(win, y, x) iif(wmove(win, y, x) = ERR_, ERR_, wgetch(win))
#define mvwgetnstr(win, y, x, str, n) iif(wmove(win, y, x) = ERR_, ERR_, wgetnstr(win, str, n))
#define mvwgetstr(win, y, x, str) iif(wmove(win, y, x) = ERR_, ERR_, wgetstr(win, str))
#define mvwhline(win, y, x, c, n) iif(wmove(win, y, x) = ERR_, ERR_, whline(win, c, n))
#define mvwinch(win, y, x) iif(wmove(win, y, x) = ERR_, NCURSES_CAST(chtype, ERR_), winch(win))
#define mvwinchnstr(win, y, x, s, n) iif(wmove(win, y, x) = ERR_, ERR_, winchnstr(win, s, n))
#define mvwinchstr(win, y, x, s) iif(wmove(win, y, x) = ERR_, ERR_, winchstr(win, s))
#define mvwinnstr(win, y, x, s, n) iif(wmove(win, y, x) = ERR_, ERR_, winnstr(win, s, n))
#define mvwinsch(win, y, x, c) iif(wmove(win, y, x) = ERR_, ERR_, winsch(win, c))
#define mvwinsnstr(win, y, x, s, n) iif(wmove(win, y, x) = ERR_, ERR_, winsnstr(win, s, n))
#define mvwinsstr(win, y, x, s) iif(wmove(win, y, x) = ERR_, ERR_, winsstr(win, s))
#define mvwinstr(win, y, x, s) iif(wmove(win, y, x) = ERR_, ERR_, winstr(win, s))
#define mvwvline(win, y, x, c, n) iif(wmove(win, y, x) = ERR_, ERR_, wvline(win, c, n))
#define mvaddch(y, x, ch) mvwaddch(stdscr, y, x, ch)
#define mvaddchnstr(y, x, str, n) mvwaddchnstr(stdscr, y, x, str, n)
#define mvaddchstr(y, x, str) mvwaddchstr(stdscr, y, x, str)
#define mvaddnstr(y, x, str, n) mvwaddnstr(stdscr, y, x, str, n)
#define mvaddstr(y, x, str) mvwaddstr(stdscr, y, x, str)
#define mvchgat(y, x, n, a, c, o) mvwchgat(stdscr, y, x, n, a, c, o)
#define mvdelch(y, x) mvwdelch(stdscr, y, x)
#define mvgetch(y, x) mvwgetch(stdscr, y, x)
#define mvgetnstr(y, x, str, n) mvwgetnstr(stdscr, y, x, str, n)
#define mvgetstr(y, x, str) mvwgetstr(stdscr, y, x, str)
#define mvhline(y, x, c, n) mvwhline(stdscr, y, x, c, n)
#define mvinch(y, x) mvwinch(stdscr, y, x)
#define mvinchnstr(y, x, s, n) mvwinchnstr(stdscr, y, x, s, n)
#define mvinchstr(y, x, s) mvwinchstr(stdscr, y, x, s)
#define mvinnstr(y, x, s, n) mvwinnstr(stdscr, y, x, s, n)
#define mvinsch(y, x, c) mvwinsch(stdscr, y, x, c)
#define mvinsnstr(y, x, s, n) mvwinsnstr(stdscr, y, x, s, n)
#define mvinsstr(y, x, s) mvwinsstr(stdscr, y, x, s)
#define mvinstr(y, x, s) mvwinstr(stdscr, y, x, s)
#define mvvline(y, x, c, n) mvwvline(stdscr, y, x, c, n)
#define getbkgd(win) (win)->_bkgd
#define slk_attr_off_(a, v) iif((v), ERR_, slk_attroff(a))
#define slk_attr_on_(a, v) iif((v), ERR_, slk_attron(a))
#define wattr_set(win, a, p, opts) scope : (win)->_attrs = ((a) and (not A_COLOR)) or cast(attr_t, COLOR_PAIR(p)) : end scope
#macro wattr_get(win,a,p,opts)
	if a then
		*(a) = (win)->_attrs
	end if
	if p then
		*(p) = cshort(PAIR_NUMBER((win)->_attrs))
	end if
#endmacro
declare function vw_printw alias "vwprintw"(byval as WINDOW_ ptr, byval as const zstring ptr, byval as va_list) as long
declare function vw_scanw alias "vwscanw"(byval as WINDOW_ ptr, byval as zstring ptr, byval as va_list) as long
#define is_cleared(win) iif((win), (win)->_clear, FALSE)
#define is_idcok(win) iif((win), (win)->_idcok, FALSE)
#define is_idlok(win) iif((win), (win)->_idlok, FALSE)
#define is_immedok(win) iif((win), (win)->_immed, FALSE)
#define is_keypad(win) iif((win), (win)->_use_keypad, FALSE)
#define is_leaveok(win) iif((win), (win)->_leaveok, FALSE)
#define is_nodelay(win) iif((win), -((win)->_delay = 0), FALSE)
#define is_notimeout(win) iif((win), (win)->_notimeout, FALSE)
#define is_pad(win) iif((win), -(((win)->_flags and _ISPAD) <> 0), FALSE)
#define is_scrollok(win) iif((win), (win)->_scroll, FALSE)
#define is_subwin(win) iif((win), -(((win)->_flags and _SUBWIN) <> 0), FALSE)
#define is_syncok(win) iif((win), (win)->_sync, FALSE)
#define wgetparent(win) iif((win), (win)->_parent, 0)

private function wgetscrreg(byval win as WINDOW_ ptr, byval t as short ptr, byval b as short ptr) as integer
	if win then
		*t = win->_regtop
		*b = win->_regbottom
		function = OK
	else
		function = ERR_
	end if
end function

extern curscr as WINDOW_ ptr
extern newscr as WINDOW_ ptr
extern stdscr as WINDOW_ ptr
extern __ttytype alias "ttytype" as byte
#define ttytype (*cptr(zstring ptr, @__ttytype))
extern COLORS as long
extern COLOR_PAIRS as long
extern COLS as long
extern ESCDELAY as long
extern LINES as long
extern TABSIZE as long

const KEY_CODE_YES = &o400
const KEY_MIN = &o401
const KEY_BREAK = &o401
const KEY_SRESET = &o530
const KEY_RESET = &o531
const KEY_DOWN = &o402
const KEY_UP = &o403
const KEY_LEFT = &o404
const KEY_RIGHT = &o405
const KEY_HOME = &o406
const KEY_BACKSPACE = &o407
const KEY_F0 = &o410
#define KEY_F(n) (KEY_F0 + (n))
const KEY_DL = &o510
const KEY_IL = &o511
const KEY_DC = &o512
const KEY_IC = &o513
const KEY_EIC = &o514
const KEY_CLEAR = &o515
const KEY_EOS = &o516
const KEY_EOL = &o517
const KEY_SF = &o520
const KEY_SR = &o521
const KEY_NPAGE = &o522
const KEY_PPAGE = &o523
const KEY_STAB = &o524
const KEY_CTAB = &o525
const KEY_CATAB = &o526
const KEY_ENTER = &o527
const KEY_PRINT = &o532
const KEY_LL = &o533
const KEY_A1 = &o534
const KEY_A3 = &o535
const KEY_B2 = &o536
const KEY_C1 = &o537
const KEY_C3 = &o540
const KEY_BTAB = &o541
const KEY_BEG = &o542
const KEY_CANCEL = &o543
const KEY_CLOSE = &o544
const KEY_COMMAND = &o545
const KEY_COPY = &o546
const KEY_CREATE = &o547
const KEY_END = &o550
const KEY_EXIT = &o551
const KEY_FIND = &o552
const KEY_HELP = &o553
const KEY_MARK = &o554
const KEY_MESSAGE = &o555
const KEY_MOVE = &o556
const KEY_NEXT = &o557
const KEY_OPEN = &o560
const KEY_OPTIONS = &o561
const KEY_PREVIOUS = &o562
const KEY_REDO = &o563
const KEY_REFERENCE = &o564
const KEY_REFRESH = &o565
const KEY_REPLACE = &o566
const KEY_RESTART = &o567
const KEY_RESUME = &o570
const KEY_SAVE = &o571
const KEY_SBEG = &o572
const KEY_SCANCEL = &o573
const KEY_SCOMMAND = &o574
const KEY_SCOPY = &o575
const KEY_SCREATE = &o576
const KEY_SDC = &o577
const KEY_SDL = &o600
const KEY_SELECT = &o601
const KEY_SEND = &o602
const KEY_SEOL = &o603
const KEY_SEXIT = &o604
const KEY_SFIND = &o605
const KEY_SHELP = &o606
const KEY_SHOME = &o607
const KEY_SIC = &o610
const KEY_SLEFT = &o611
const KEY_SMESSAGE = &o612
const KEY_SMOVE = &o613
const KEY_SNEXT = &o614
const KEY_SOPTIONS = &o615
const KEY_SPREVIOUS = &o616
const KEY_SPRINT = &o617
const KEY_SREDO = &o620
const KEY_SREPLACE = &o621
const KEY_SRIGHT = &o622
const KEY_SRSUME = &o623
const KEY_SSAVE = &o624
const KEY_SSUSPEND = &o625
const KEY_SUNDO = &o626
const KEY_SUSPEND = &o627
const KEY_UNDO = &o630
const KEY_MOUSE = &o631
const KEY_RESIZE = &o632
const KEY_EVENT = &o633
const KEY_MAX = &o777
#define NCURSES_MOUSE_MASK(b, m) ((m) shl (((b) - 1) * 6))
const NCURSES_BUTTON_RELEASED = cast(clong, &o01)
const NCURSES_BUTTON_PRESSED = cast(clong, &o02)
const NCURSES_BUTTON_CLICKED = cast(clong, &o04)
const NCURSES_DOUBLE_CLICKED = cast(clong, &o10)
const NCURSES_TRIPLE_CLICKED = cast(clong, &o20)
const NCURSES_RESERVED_EVENT = cast(clong, &o40)
#define BUTTON1_RELEASED NCURSES_MOUSE_MASK(1, NCURSES_BUTTON_RELEASED)
#define BUTTON1_PRESSED NCURSES_MOUSE_MASK(1, NCURSES_BUTTON_PRESSED)
#define BUTTON1_CLICKED NCURSES_MOUSE_MASK(1, NCURSES_BUTTON_CLICKED)
#define BUTTON1_DOUBLE_CLICKED NCURSES_MOUSE_MASK(1, NCURSES_DOUBLE_CLICKED)
#define BUTTON1_TRIPLE_CLICKED NCURSES_MOUSE_MASK(1, NCURSES_TRIPLE_CLICKED)
#define BUTTON2_RELEASED NCURSES_MOUSE_MASK(2, NCURSES_BUTTON_RELEASED)
#define BUTTON2_PRESSED NCURSES_MOUSE_MASK(2, NCURSES_BUTTON_PRESSED)
#define BUTTON2_CLICKED NCURSES_MOUSE_MASK(2, NCURSES_BUTTON_CLICKED)
#define BUTTON2_DOUBLE_CLICKED NCURSES_MOUSE_MASK(2, NCURSES_DOUBLE_CLICKED)
#define BUTTON2_TRIPLE_CLICKED NCURSES_MOUSE_MASK(2, NCURSES_TRIPLE_CLICKED)
#define BUTTON3_RELEASED NCURSES_MOUSE_MASK(3, NCURSES_BUTTON_RELEASED)
#define BUTTON3_PRESSED NCURSES_MOUSE_MASK(3, NCURSES_BUTTON_PRESSED)
#define BUTTON3_CLICKED NCURSES_MOUSE_MASK(3, NCURSES_BUTTON_CLICKED)
#define BUTTON3_DOUBLE_CLICKED NCURSES_MOUSE_MASK(3, NCURSES_DOUBLE_CLICKED)
#define BUTTON3_TRIPLE_CLICKED NCURSES_MOUSE_MASK(3, NCURSES_TRIPLE_CLICKED)
#define BUTTON4_RELEASED NCURSES_MOUSE_MASK(4, NCURSES_BUTTON_RELEASED)
#define BUTTON4_PRESSED NCURSES_MOUSE_MASK(4, NCURSES_BUTTON_PRESSED)
#define BUTTON4_CLICKED NCURSES_MOUSE_MASK(4, NCURSES_BUTTON_CLICKED)
#define BUTTON4_DOUBLE_CLICKED NCURSES_MOUSE_MASK(4, NCURSES_DOUBLE_CLICKED)
#define BUTTON4_TRIPLE_CLICKED NCURSES_MOUSE_MASK(4, NCURSES_TRIPLE_CLICKED)
#define BUTTON1_RESERVED_EVENT NCURSES_MOUSE_MASK(1, NCURSES_RESERVED_EVENT)
#define BUTTON2_RESERVED_EVENT NCURSES_MOUSE_MASK(2, NCURSES_RESERVED_EVENT)
#define BUTTON3_RESERVED_EVENT NCURSES_MOUSE_MASK(3, NCURSES_RESERVED_EVENT)
#define BUTTON4_RESERVED_EVENT NCURSES_MOUSE_MASK(4, NCURSES_RESERVED_EVENT)
#define BUTTON_CTRL NCURSES_MOUSE_MASK(5, cast(clong, &o001))
#define BUTTON_SHIFT NCURSES_MOUSE_MASK(5, cast(clong, &o002))
#define BUTTON_ALT NCURSES_MOUSE_MASK(5, cast(clong, &o004))
#define REPORT_MOUSE_POSITION NCURSES_MOUSE_MASK(5, cast(clong, &o010))
#define ALL_MOUSE_EVENTS (REPORT_MOUSE_POSITION - 1)
#define BUTTON_RELEASE(e, x) ((e) and NCURSES_MOUSE_MASK(x, &o01))
#define BUTTON_PRESS(e, x) ((e) and NCURSES_MOUSE_MASK(x, &o02))
#define BUTTON_CLICK(e, x) ((e) and NCURSES_MOUSE_MASK(x, &o04))
#define BUTTON_DOUBLE_CLICK(e, x) ((e) and NCURSES_MOUSE_MASK(x, &o10))
#define BUTTON_TRIPLE_CLICK(e, x) ((e) and NCURSES_MOUSE_MASK(x, &o20))
#define BUTTON_RESERVED_EVENT(e, x) ((e) and NCURSES_MOUSE_MASK(x, &o40))

type MEVENT
	id as short
	x as long
	y as long
	z as long
	bstate as mmask_t
end type

declare function has_mouse() as byte
declare function getmouse_ alias "getmouse"(byval as MEVENT ptr) as long
declare function ungetmouse(byval as MEVENT ptr) as long
declare function mousemask(byval as mmask_t, byval as mmask_t ptr) as mmask_t
declare function wenclose(byval as const WINDOW_ ptr, byval as long, byval as long) as byte
declare function mouseinterval(byval as long) as long
declare function wmouse_trafo(byval as const WINDOW_ ptr, byval as long ptr, byval as long ptr, byval as byte) as byte
declare function mouse_trafo_ alias "mouse_trafo"(byval as long ptr, byval as long ptr, byval as byte) as byte
#define mouse_trafo(y, x, to_screen) wmouse_trafo(stdscr, y, x, to_screen)
declare function mcprint(byval as zstring ptr, byval as long) as long
declare function has_key(byval as long) as long
declare sub _tracef(byval as const zstring ptr, ...)
declare sub _tracedump(byval as const zstring ptr, byval as WINDOW_ ptr)
declare function _traceattr(byval as attr_t) as zstring ptr
declare function _traceattr2(byval as long, byval as chtype) as zstring ptr
declare function _nc_tracebits() as zstring ptr
declare function _tracechar(byval as long) as zstring ptr
declare function _tracechtype(byval as chtype) as zstring ptr
declare function _tracechtype2(byval as long, byval as chtype) as zstring ptr
declare function _tracech_t alias "_tracechtype"(byval as chtype) as zstring ptr
declare function _tracech_t2 alias "_tracechtype2"(byval as long, byval as chtype) as zstring ptr
declare function _tracemouse(byval as const MEVENT ptr) as zstring ptr
declare sub trace(byval as const ulong)

const TRACE_DISABLE = &h0000
const TRACE_TIMES = &h0001
const TRACE_TPUTS = &h0002
const TRACE_UPDATE = &h0004
const TRACE_MOVE = &h0008
const TRACE_CHARPUT = &h0010
const TRACE_ORDINARY = &h001F
const TRACE_CALLS = &h0020
const TRACE_VIRTPUT = &h0040
const TRACE_IEVENT = &h0080
const TRACE_BITS = &h0100
const TRACE_ICALLS = &h0200
const TRACE_CCALLS = &h0400
const TRACE_DATABASE = &h0800
const TRACE_ATTRS = &h1000
const TRACE_SHIFT = 13
const TRACE_MAXIMUM = (1 shl TRACE_SHIFT) - 1
const NCURSES_UNCTRL_H_incl = 1
#undef NCURSES_VERSION
#define NCURSES_VERSION "5.9"
#undef unctrl
declare function unctrl(byval as chtype) as zstring ptr

end extern
