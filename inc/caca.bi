'' FreeBASIC binding for libcaca-0.99.beta19
''
'' based on the C header files:
''   libcaca       Colour ASCII-Art library
''   Copyright (c) 2002-2012 Sam Hocevar <sam@hocevar.net>
''                 All Rights Reserved
''
''   This library is free software. It comes without any warranty, to
''   the extent permitted by applicable law. You can redistribute it
''   and/or modify it under the terms of the Do What the Fuck You Want
''   to Public License, Version 2, as published by Sam Hocevar. See
''   http://www.wtfpl.net/ for more details.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "caca"

#include once "crt/long.bi"
#include once "crt/stdint.bi"
#include once "crt/stdarg.bi"

#ifdef __CACA0_H__
	'' The following symbols have been renamed:
	''     procedure caca_rand => caca1_rand
	''     procedure caca_printf => caca1_printf
	''     procedure caca_draw_line => caca1_draw_line
	''     procedure caca_draw_polyline => caca1_draw_polyline
	''     procedure caca_draw_thin_line => caca1_draw_thin_line
	''     procedure caca_draw_thin_polyline => caca1_draw_thin_polyline
	''     procedure caca_draw_circle => caca1_draw_circle
	''     procedure caca_draw_ellipse => caca1_draw_ellipse
	''     procedure caca_draw_thin_ellipse => caca1_draw_thin_ellipse
	''     procedure caca_fill_ellipse => caca1_fill_ellipse
	''     procedure caca_draw_box => caca1_draw_box
	''     procedure caca_draw_thin_box => caca1_draw_thin_box
	''     procedure caca_fill_box => caca1_fill_box
	''     procedure caca_draw_triangle => caca1_draw_triangle
	''     procedure caca_draw_thin_triangle => caca1_draw_thin_triangle
	''     procedure caca_fill_triangle => caca1_fill_triangle
	''     procedure caca_get_event => caca1_get_event
	''     procedure caca_get_mouse_x => caca1_get_mouse_x
	''     procedure caca_get_mouse_y => caca1_get_mouse_y
#endif

extern "C"

#define __CACA_H__
#define __CACA_TYPES_H__
#define CACA_API_VERSION_1

type caca_canvas_t as caca_canvas
type caca_dither_t as caca_dither
type caca_charfont_t as caca_charfont
type caca_font_t as caca_font
type caca_file_t as caca_file
type caca_display_t as caca_display
type caca_event_t as caca_event

type caca_color as long
enum
	CACA_BLACK = &h00
	CACA_BLUE = &h01
	CACA_GREEN = &h02
	CACA_CYAN = &h03
	CACA_RED = &h04
	CACA_MAGENTA = &h05
	CACA_BROWN = &h06
	CACA_LIGHTGRAY = &h07
	CACA_DARKGRAY = &h08
	CACA_LIGHTBLUE = &h09
	CACA_LIGHTGREEN = &h0a
	CACA_LIGHTCYAN = &h0b
	CACA_LIGHTRED = &h0c
	CACA_LIGHTMAGENTA = &h0d
	CACA_YELLOW = &h0e
	CACA_WHITE = &h0f
	CACA_DEFAULT = &h10
	CACA_TRANSPARENT = &h20
end enum

type caca_style as long
enum
	CACA_BOLD = &h01
	CACA_ITALICS = &h02
	CACA_UNDERLINE = &h04
	CACA_BLINK = &h08
end enum

type caca_event_type as long
enum
	CACA_EVENT_NONE = &h0000
	CACA_EVENT_KEY_PRESS = &h0001
	CACA_EVENT_KEY_RELEASE = &h0002
	CACA_EVENT_MOUSE_PRESS = &h0004
	CACA_EVENT_MOUSE_RELEASE = &h0008
	CACA_EVENT_MOUSE_MOTION = &h0010
	CACA_EVENT_RESIZE = &h0020
	CACA_EVENT_QUIT = &h0040
	CACA_EVENT_ANY = &hffff
end enum

type caca_event_data_mouse
	x as long
	y as long
	button as long
end type

type caca_event_data_resize
	w as long
	h as long
end type

type caca_event_data_key
	ch as long
	utf32 as ulong
	utf8 as zstring * 8
end type

union caca_event_data
	mouse as caca_event_data_mouse
	resize as caca_event_data_resize
	key as caca_event_data_key
end union

type caca_event
	as caca_event_type type
	data as caca_event_data
	padding(0 to 15) as ubyte
end type

type caca_option
	name as const zstring ptr
	has_arg as long
	flag as long ptr
	val as long
end type

type caca_key as long
enum
	CACA_KEY_UNKNOWN = &h00
	CACA_KEY_CTRL_A = &h01
	CACA_KEY_CTRL_B = &h02
	CACA_KEY_CTRL_C = &h03
	CACA_KEY_CTRL_D = &h04
	CACA_KEY_CTRL_E = &h05
	CACA_KEY_CTRL_F = &h06
	CACA_KEY_CTRL_G = &h07
	CACA_KEY_BACKSPACE = &h08
	CACA_KEY_TAB = &h09
	CACA_KEY_CTRL_J = &h0a
	CACA_KEY_CTRL_K = &h0b
	CACA_KEY_CTRL_L = &h0c
	CACA_KEY_RETURN = &h0d
	CACA_KEY_CTRL_N = &h0e
	CACA_KEY_CTRL_O = &h0f
	CACA_KEY_CTRL_P = &h10
	CACA_KEY_CTRL_Q = &h11
	CACA_KEY_CTRL_R = &h12
	CACA_KEY_PAUSE = &h13
	CACA_KEY_CTRL_T = &h14
	CACA_KEY_CTRL_U = &h15
	CACA_KEY_CTRL_V = &h16
	CACA_KEY_CTRL_W = &h17
	CACA_KEY_CTRL_X = &h18
	CACA_KEY_CTRL_Y = &h19
	CACA_KEY_CTRL_Z = &h1a
	CACA_KEY_ESCAPE = &h1b
	CACA_KEY_DELETE = &h7f
	CACA_KEY_UP = &h111
	CACA_KEY_DOWN = &h112
	CACA_KEY_LEFT = &h113
	CACA_KEY_RIGHT = &h114
	CACA_KEY_INSERT = &h115
	CACA_KEY_HOME = &h116
	CACA_KEY_END = &h117
	CACA_KEY_PAGEUP = &h118
	CACA_KEY_PAGEDOWN = &h119
	CACA_KEY_F1 = &h11a
	CACA_KEY_F2 = &h11b
	CACA_KEY_F3 = &h11c
	CACA_KEY_F4 = &h11d
	CACA_KEY_F5 = &h11e
	CACA_KEY_F6 = &h11f
	CACA_KEY_F7 = &h120
	CACA_KEY_F8 = &h121
	CACA_KEY_F9 = &h122
	CACA_KEY_F10 = &h123
	CACA_KEY_F11 = &h124
	CACA_KEY_F12 = &h125
	CACA_KEY_F13 = &h126
	CACA_KEY_F14 = &h127
	CACA_KEY_F15 = &h128
end enum

declare function caca_create_canvas(byval as long, byval as long) as caca_canvas_t ptr
declare function caca_manage_canvas(byval as caca_canvas_t ptr, byval as function(byval as any ptr) as long, byval as any ptr) as long
declare function caca_unmanage_canvas(byval as caca_canvas_t ptr, byval as function(byval as any ptr) as long, byval as any ptr) as long
declare function caca_set_canvas_size(byval as caca_canvas_t ptr, byval as long, byval as long) as long
declare function caca_get_canvas_width(byval as const caca_canvas_t ptr) as long
declare function caca_get_canvas_height(byval as const caca_canvas_t ptr) as long
declare function caca_get_canvas_chars(byval as const caca_canvas_t ptr) as const ulong ptr
declare function caca_get_canvas_attrs(byval as const caca_canvas_t ptr) as const ulong ptr
declare function caca_free_canvas(byval as caca_canvas_t ptr) as long

#ifdef __CACA0_H__
	declare function caca1_rand alias "caca_rand"(byval as long, byval as long) as long
#else
	declare function caca_rand(byval as long, byval as long) as long
#endif

declare function caca_get_version() as const zstring ptr
const CACA_MAGIC_FULLWIDTH = &h000ffffe
declare function caca_gotoxy(byval as caca_canvas_t ptr, byval as long, byval as long) as long
declare function caca_wherex(byval as const caca_canvas_t ptr) as long
declare function caca_wherey(byval as const caca_canvas_t ptr) as long
declare function caca_put_char(byval as caca_canvas_t ptr, byval as long, byval as long, byval as ulong) as long
declare function caca_get_char(byval as const caca_canvas_t ptr, byval as long, byval as long) as ulong
declare function caca_put_str(byval as caca_canvas_t ptr, byval as long, byval as long, byval as const zstring ptr) as long

#ifdef __CACA0_H__
	declare function caca1_printf alias "caca_printf"(byval as caca_canvas_t ptr, byval as long, byval as long, byval as const zstring ptr, ...) as long
#else
	declare function caca_printf(byval as caca_canvas_t ptr, byval as long, byval as long, byval as const zstring ptr, ...) as long
#endif

declare function caca_vprintf(byval as caca_canvas_t ptr, byval as long, byval as long, byval as const zstring ptr, byval as va_list) as long
declare function caca_clear_canvas(byval as caca_canvas_t ptr) as long
declare function caca_set_canvas_handle(byval as caca_canvas_t ptr, byval as long, byval as long) as long
declare function caca_get_canvas_handle_x(byval as const caca_canvas_t ptr) as long
declare function caca_get_canvas_handle_y(byval as const caca_canvas_t ptr) as long
declare function caca_blit(byval as caca_canvas_t ptr, byval as long, byval as long, byval as const caca_canvas_t ptr, byval as const caca_canvas_t ptr) as long
declare function caca_set_canvas_boundaries(byval as caca_canvas_t ptr, byval as long, byval as long, byval as long, byval as long) as long
declare function caca_disable_dirty_rect(byval as caca_canvas_t ptr) as long
declare function caca_enable_dirty_rect(byval as caca_canvas_t ptr) as long
declare function caca_get_dirty_rect_count(byval as caca_canvas_t ptr) as long
declare function caca_get_dirty_rect(byval as caca_canvas_t ptr, byval as long, byval as long ptr, byval as long ptr, byval as long ptr, byval as long ptr) as long
declare function caca_add_dirty_rect(byval as caca_canvas_t ptr, byval as long, byval as long, byval as long, byval as long) as long
declare function caca_remove_dirty_rect(byval as caca_canvas_t ptr, byval as long, byval as long, byval as long, byval as long) as long
declare function caca_clear_dirty_rect_list(byval as caca_canvas_t ptr) as long
declare function caca_invert(byval as caca_canvas_t ptr) as long
declare function caca_flip(byval as caca_canvas_t ptr) as long
declare function caca_flop(byval as caca_canvas_t ptr) as long
declare function caca_rotate_180(byval as caca_canvas_t ptr) as long
declare function caca_rotate_left(byval as caca_canvas_t ptr) as long
declare function caca_rotate_right(byval as caca_canvas_t ptr) as long
declare function caca_stretch_left(byval as caca_canvas_t ptr) as long
declare function caca_stretch_right(byval as caca_canvas_t ptr) as long
declare function caca_get_attr(byval as const caca_canvas_t ptr, byval as long, byval as long) as ulong
declare function caca_set_attr(byval as caca_canvas_t ptr, byval as ulong) as long
declare function caca_unset_attr(byval as caca_canvas_t ptr, byval as ulong) as long
declare function caca_toggle_attr(byval as caca_canvas_t ptr, byval as ulong) as long
declare function caca_put_attr(byval as caca_canvas_t ptr, byval as long, byval as long, byval as ulong) as long
declare function caca_set_color_ansi(byval as caca_canvas_t ptr, byval as ubyte, byval as ubyte) as long
declare function caca_set_color_argb(byval as caca_canvas_t ptr, byval as ushort, byval as ushort) as long
declare function caca_attr_to_ansi(byval as ulong) as ubyte
declare function caca_attr_to_ansi_fg(byval as ulong) as ubyte
declare function caca_attr_to_ansi_bg(byval as ulong) as ubyte
declare function caca_attr_to_rgb12_fg(byval as ulong) as ushort
declare function caca_attr_to_rgb12_bg(byval as ulong) as ushort
declare sub caca_attr_to_argb64(byval as ulong, byval as ubyte ptr)
declare function caca_utf8_to_utf32(byval as const zstring ptr, byval as uinteger ptr) as ulong
declare function caca_utf32_to_utf8(byval as zstring ptr, byval as ulong) as uinteger
declare function caca_utf32_to_cp437(byval as ulong) as ubyte
declare function caca_cp437_to_utf32(byval as ubyte) as ulong
declare function caca_utf32_to_ascii(byval as ulong) as byte
declare function caca_utf32_is_fullwidth(byval as ulong) as long

#ifdef __CACA0_H__
	declare function caca1_draw_line alias "caca_draw_line"(byval as caca_canvas_t ptr, byval as long, byval as long, byval as long, byval as long, byval as ulong) as long
	declare function caca1_draw_polyline alias "caca_draw_polyline"(byval as caca_canvas_t ptr, byval x as const long ptr, byval y as const long ptr, byval as long, byval as ulong) as long
	declare function caca1_draw_thin_line alias "caca_draw_thin_line"(byval as caca_canvas_t ptr, byval as long, byval as long, byval as long, byval as long) as long
	declare function caca1_draw_thin_polyline alias "caca_draw_thin_polyline"(byval as caca_canvas_t ptr, byval x as const long ptr, byval y as const long ptr, byval as long) as long
	declare function caca1_draw_circle alias "caca_draw_circle"(byval as caca_canvas_t ptr, byval as long, byval as long, byval as long, byval as ulong) as long
	declare function caca1_draw_ellipse alias "caca_draw_ellipse"(byval as caca_canvas_t ptr, byval as long, byval as long, byval as long, byval as long, byval as ulong) as long
	declare function caca1_draw_thin_ellipse alias "caca_draw_thin_ellipse"(byval as caca_canvas_t ptr, byval as long, byval as long, byval as long, byval as long) as long
	declare function caca1_fill_ellipse alias "caca_fill_ellipse"(byval as caca_canvas_t ptr, byval as long, byval as long, byval as long, byval as long, byval as ulong) as long
	declare function caca1_draw_box alias "caca_draw_box"(byval as caca_canvas_t ptr, byval as long, byval as long, byval as long, byval as long, byval as ulong) as long
	declare function caca1_draw_thin_box alias "caca_draw_thin_box"(byval as caca_canvas_t ptr, byval as long, byval as long, byval as long, byval as long) as long
#else
	declare function caca_draw_line(byval as caca_canvas_t ptr, byval as long, byval as long, byval as long, byval as long, byval as ulong) as long
	declare function caca_draw_polyline(byval as caca_canvas_t ptr, byval x as const long ptr, byval y as const long ptr, byval as long, byval as ulong) as long
	declare function caca_draw_thin_line(byval as caca_canvas_t ptr, byval as long, byval as long, byval as long, byval as long) as long
	declare function caca_draw_thin_polyline(byval as caca_canvas_t ptr, byval x as const long ptr, byval y as const long ptr, byval as long) as long
	declare function caca_draw_circle(byval as caca_canvas_t ptr, byval as long, byval as long, byval as long, byval as ulong) as long
	declare function caca_draw_ellipse(byval as caca_canvas_t ptr, byval as long, byval as long, byval as long, byval as long, byval as ulong) as long
	declare function caca_draw_thin_ellipse(byval as caca_canvas_t ptr, byval as long, byval as long, byval as long, byval as long) as long
	declare function caca_fill_ellipse(byval as caca_canvas_t ptr, byval as long, byval as long, byval as long, byval as long, byval as ulong) as long
	declare function caca_draw_box(byval as caca_canvas_t ptr, byval as long, byval as long, byval as long, byval as long, byval as ulong) as long
	declare function caca_draw_thin_box(byval as caca_canvas_t ptr, byval as long, byval as long, byval as long, byval as long) as long
#endif

declare function caca_draw_cp437_box(byval as caca_canvas_t ptr, byval as long, byval as long, byval as long, byval as long) as long

#ifdef __CACA0_H__
	declare function caca1_fill_box alias "caca_fill_box"(byval as caca_canvas_t ptr, byval as long, byval as long, byval as long, byval as long, byval as ulong) as long
	declare function caca1_draw_triangle alias "caca_draw_triangle"(byval as caca_canvas_t ptr, byval as long, byval as long, byval as long, byval as long, byval as long, byval as long, byval as ulong) as long
	declare function caca1_draw_thin_triangle alias "caca_draw_thin_triangle"(byval as caca_canvas_t ptr, byval as long, byval as long, byval as long, byval as long, byval as long, byval as long) as long
	declare function caca1_fill_triangle alias "caca_fill_triangle"(byval as caca_canvas_t ptr, byval as long, byval as long, byval as long, byval as long, byval as long, byval as long, byval as ulong) as long
#else
	declare function caca_fill_box(byval as caca_canvas_t ptr, byval as long, byval as long, byval as long, byval as long, byval as ulong) as long
	declare function caca_draw_triangle(byval as caca_canvas_t ptr, byval as long, byval as long, byval as long, byval as long, byval as long, byval as long, byval as ulong) as long
	declare function caca_draw_thin_triangle(byval as caca_canvas_t ptr, byval as long, byval as long, byval as long, byval as long, byval as long, byval as long) as long
	declare function caca_fill_triangle(byval as caca_canvas_t ptr, byval as long, byval as long, byval as long, byval as long, byval as long, byval as long, byval as ulong) as long
#endif

declare function caca_fill_triangle_textured(byval cv as caca_canvas_t ptr, byval coords as long ptr, byval tex as caca_canvas_t ptr, byval uv as single ptr) as long
declare function caca_get_frame_count(byval as const caca_canvas_t ptr) as long
declare function caca_set_frame(byval as caca_canvas_t ptr, byval as long) as long
declare function caca_get_frame_name(byval as const caca_canvas_t ptr) as const zstring ptr
declare function caca_set_frame_name(byval as caca_canvas_t ptr, byval as const zstring ptr) as long
declare function caca_create_frame(byval as caca_canvas_t ptr, byval as long) as long
declare function caca_free_frame(byval as caca_canvas_t ptr, byval as long) as long
declare function caca_create_dither(byval as long, byval as long, byval as long, byval as long, byval as ulong, byval as ulong, byval as ulong, byval as ulong) as caca_dither_t ptr
declare function caca_set_dither_palette(byval as caca_dither_t ptr, byval r as ulong ptr, byval g as ulong ptr, byval b as ulong ptr, byval a as ulong ptr) as long
declare function caca_set_dither_brightness(byval as caca_dither_t ptr, byval as single) as long
declare function caca_get_dither_brightness(byval as const caca_dither_t ptr) as single
declare function caca_set_dither_gamma(byval as caca_dither_t ptr, byval as single) as long
declare function caca_get_dither_gamma(byval as const caca_dither_t ptr) as single
declare function caca_set_dither_contrast(byval as caca_dither_t ptr, byval as single) as long
declare function caca_get_dither_contrast(byval as const caca_dither_t ptr) as single
declare function caca_set_dither_antialias(byval as caca_dither_t ptr, byval as const zstring ptr) as long
declare function caca_get_dither_antialias_list(byval as const caca_dither_t ptr) as const zstring const ptr ptr
declare function caca_get_dither_antialias(byval as const caca_dither_t ptr) as const zstring ptr
declare function caca_set_dither_color(byval as caca_dither_t ptr, byval as const zstring ptr) as long
declare function caca_get_dither_color_list(byval as const caca_dither_t ptr) as const zstring const ptr ptr
declare function caca_get_dither_color(byval as const caca_dither_t ptr) as const zstring ptr
declare function caca_set_dither_charset(byval as caca_dither_t ptr, byval as const zstring ptr) as long
declare function caca_get_dither_charset_list(byval as const caca_dither_t ptr) as const zstring const ptr ptr
declare function caca_get_dither_charset(byval as const caca_dither_t ptr) as const zstring ptr
declare function caca_set_dither_algorithm(byval as caca_dither_t ptr, byval as const zstring ptr) as long
declare function caca_get_dither_algorithm_list(byval as const caca_dither_t ptr) as const zstring const ptr ptr
declare function caca_get_dither_algorithm(byval as const caca_dither_t ptr) as const zstring ptr
declare function caca_dither_bitmap(byval as caca_canvas_t ptr, byval as long, byval as long, byval as long, byval as long, byval as const caca_dither_t ptr, byval as const any ptr) as long
declare function caca_free_dither(byval as caca_dither_t ptr) as long
declare function caca_load_charfont(byval as const any ptr, byval as uinteger) as caca_charfont_t ptr
declare function caca_free_charfont(byval as caca_charfont_t ptr) as long
declare function caca_load_font(byval as const any ptr, byval as uinteger) as caca_font_t ptr
declare function caca_get_font_list() as const zstring const ptr ptr
declare function caca_get_font_width(byval as const caca_font_t ptr) as long
declare function caca_get_font_height(byval as const caca_font_t ptr) as long
declare function caca_get_font_blocks(byval as const caca_font_t ptr) as const ulong ptr
declare function caca_render_canvas(byval as const caca_canvas_t ptr, byval as const caca_font_t ptr, byval as any ptr, byval as long, byval as long, byval as long) as long
declare function caca_free_font(byval as caca_font_t ptr) as long
declare function caca_canvas_set_figfont(byval as caca_canvas_t ptr, byval as const zstring ptr) as long
declare function caca_set_figfont_smush(byval as caca_canvas_t ptr, byval as const zstring ptr) as long
declare function caca_set_figfont_width(byval as caca_canvas_t ptr, byval as long) as long
declare function caca_put_figchar(byval as caca_canvas_t ptr, byval as ulong) as long
declare function caca_flush_figlet(byval as caca_canvas_t ptr) as long
declare function caca_file_open(byval as const zstring ptr, byval as const zstring ptr) as caca_file_t ptr
declare function caca_file_close(byval as caca_file_t ptr) as long
declare function caca_file_tell(byval as caca_file_t ptr) as ulongint
declare function caca_file_read(byval as caca_file_t ptr, byval as any ptr, byval as uinteger) as uinteger
declare function caca_file_write(byval as caca_file_t ptr, byval as const any ptr, byval as uinteger) as uinteger
declare function caca_file_gets(byval as caca_file_t ptr, byval as zstring ptr, byval as long) as zstring ptr
declare function caca_file_eof(byval as caca_file_t ptr) as long
declare function caca_import_canvas_from_memory(byval as caca_canvas_t ptr, byval as const any ptr, byval as uinteger, byval as const zstring ptr) as integer
declare function caca_import_canvas_from_file(byval as caca_canvas_t ptr, byval as const zstring ptr, byval as const zstring ptr) as integer
declare function caca_import_area_from_memory(byval as caca_canvas_t ptr, byval as long, byval as long, byval as const any ptr, byval as uinteger, byval as const zstring ptr) as integer
declare function caca_import_area_from_file(byval as caca_canvas_t ptr, byval as long, byval as long, byval as const zstring ptr, byval as const zstring ptr) as integer
declare function caca_get_import_list() as const zstring const ptr ptr
declare function caca_export_canvas_to_memory(byval as const caca_canvas_t ptr, byval as const zstring ptr, byval as uinteger ptr) as any ptr
declare function caca_export_area_to_memory(byval as const caca_canvas_t ptr, byval as long, byval as long, byval as long, byval as long, byval as const zstring ptr, byval as uinteger ptr) as any ptr
declare function caca_get_export_list() as const zstring const ptr ptr
declare function caca_create_display(byval as caca_canvas_t ptr) as caca_display_t ptr
declare function caca_create_display_with_driver(byval as caca_canvas_t ptr, byval as const zstring ptr) as caca_display_t ptr
declare function caca_get_display_driver_list() as const zstring const ptr ptr
declare function caca_get_display_driver(byval as caca_display_t ptr) as const zstring ptr
declare function caca_set_display_driver(byval as caca_display_t ptr, byval as const zstring ptr) as long
declare function caca_free_display(byval as caca_display_t ptr) as long
declare function caca_get_canvas(byval as caca_display_t ptr) as caca_canvas_t ptr
declare function caca_refresh_display(byval as caca_display_t ptr) as long
declare function caca_set_display_time(byval as caca_display_t ptr, byval as long) as long
declare function caca_get_display_time(byval as const caca_display_t ptr) as long
declare function caca_get_display_width(byval as const caca_display_t ptr) as long
declare function caca_get_display_height(byval as const caca_display_t ptr) as long
declare function caca_set_display_title(byval as caca_display_t ptr, byval as const zstring ptr) as long
declare function caca_set_mouse(byval as caca_display_t ptr, byval as long) as long
declare function caca_set_cursor(byval as caca_display_t ptr, byval as long) as long

#ifdef __CACA0_H__
	declare function caca1_get_event alias "caca_get_event"(byval as caca_display_t ptr, byval as long, byval as caca_event_t ptr, byval as long) as long
	declare function caca1_get_mouse_x alias "caca_get_mouse_x"(byval as const caca_display_t ptr) as long
	declare function caca1_get_mouse_y alias "caca_get_mouse_y"(byval as const caca_display_t ptr) as long
#else
	declare function caca_get_event(byval as caca_display_t ptr, byval as long, byval as caca_event_t ptr, byval as long) as long
	declare function caca_get_mouse_x(byval as const caca_display_t ptr) as long
	declare function caca_get_mouse_y(byval as const caca_display_t ptr) as long
#endif

declare function caca_get_event_type(byval as const caca_event_t ptr) as caca_event_type
declare function caca_get_event_key_ch(byval as const caca_event_t ptr) as long
declare function caca_get_event_key_utf32(byval as const caca_event_t ptr) as ulong
declare function caca_get_event_key_utf8(byval as const caca_event_t ptr, byval as zstring ptr) as long
declare function caca_get_event_mouse_button(byval as const caca_event_t ptr) as long
declare function caca_get_event_mouse_x(byval as const caca_event_t ptr) as long
declare function caca_get_event_mouse_y(byval as const caca_event_t ptr) as long
declare function caca_get_event_resize_width(byval as const caca_event_t ptr) as long
declare function caca_get_event_resize_height(byval as const caca_event_t ptr) as long

#if defined(__FB_WIN32__) and (not defined(CACA_STATIC))
	extern import caca_optind as long
	extern import caca_optarg as zstring ptr
#else
	extern caca_optind as long
	extern caca_optarg as zstring ptr
#endif

declare function caca_getopt(byval as long, byval as zstring const ptr ptr, byval as const zstring ptr, byval as const caca_option ptr, byval as long ptr) as long

type CACA_CONIO_COLORS as long
enum
	CACA_CONIO_BLINK = 128
	CACA_CONIO_BLACK = 0
	CACA_CONIO_BLUE = 1
	CACA_CONIO_GREEN = 2
	CACA_CONIO_CYAN = 3
	CACA_CONIO_RED = 4
	CACA_CONIO_MAGENTA = 5
	CACA_CONIO_BROWN = 6
	CACA_CONIO_LIGHTGRAY = 7
	CACA_CONIO_DARKGRAY = 8
	CACA_CONIO_LIGHTBLUE = 9
	CACA_CONIO_LIGHTGREEN = 10
	CACA_CONIO_LIGHTCYAN = 11
	CACA_CONIO_LIGHTRED = 12
	CACA_CONIO_LIGHTMAGENTA = 13
	CACA_CONIO_YELLOW = 14
	CACA_CONIO_WHITE = 15
end enum

type CACA_CONIO_CURSOR as long
enum
	CACA_CONIO__NOCURSOR = 0
	CACA_CONIO__SOLIDCURSOR = 1
	CACA_CONIO__NORMALCURSOR = 2
end enum

type CACA_CONIO_MODE as long
enum
	CACA_CONIO_LASTMODE = -1
	CACA_CONIO_BW40 = 0
	CACA_CONIO_C40 = 1
	CACA_CONIO_BW80 = 2
	CACA_CONIO_C80 = 3
	CACA_CONIO_MONO = 7
	CACA_CONIO_C4350 = 64
end enum

type caca_conio_text_info
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

#if defined(__FB_WIN32__) and (not defined(CACA_STATIC))
	extern import caca_conio_directvideo as long
	extern import caca_conio__wscroll as long
#else
	extern caca_conio_directvideo as long
	extern caca_conio__wscroll as long
#endif

declare function caca_conio_cgets(byval str as zstring ptr) as zstring ptr
declare sub caca_conio_clreol()
declare sub caca_conio_clrscr()
declare function caca_conio_cprintf(byval format as const zstring ptr, ...) as long
declare function caca_conio_cputs(byval str as const zstring ptr) as long
declare function caca_conio_cscanf(byval format as zstring ptr, ...) as long
declare sub caca_conio_delay(byval as ulong)
declare sub caca_conio_delline()
declare function caca_conio_getch() as long
declare function caca_conio_getche() as long
declare function caca_conio_getpass(byval prompt as const zstring ptr) as zstring ptr
declare function caca_conio_gettext(byval left as long, byval top as long, byval right as long, byval bottom as long, byval destin as any ptr) as long
declare sub caca_conio_gettextinfo(byval r as caca_conio_text_info ptr)
declare sub caca_conio_gotoxy(byval x as long, byval y as long)
declare sub caca_conio_highvideo()
declare sub caca_conio_insline()
declare function caca_conio_kbhit() as long
declare sub caca_conio_lowvideo()
declare function caca_conio_movetext(byval left as long, byval top as long, byval right as long, byval bottom as long, byval destleft as long, byval desttop as long) as long
declare sub caca_conio_normvideo()
declare sub caca_conio_nosound()
declare function caca_conio_printf(byval format as const zstring ptr, ...) as long
declare function caca_conio_putch(byval ch as long) as long
declare function caca_conio_puttext(byval left as long, byval top as long, byval right as long, byval bottom as long, byval destin as any ptr) as long
declare sub caca_conio__setcursortype(byval cur_t as long)
declare sub caca_conio_sleep(byval as ulong)
declare sub caca_conio_sound(byval as ulong)
declare sub caca_conio_textattr(byval newattr as long)
declare sub caca_conio_textbackground(byval newcolor as long)
declare sub caca_conio_textcolor(byval newcolor as long)
declare sub caca_conio_textmode(byval newmode as long)
declare function caca_conio_ungetch(byval ch as long) as long
declare function caca_conio_wherex() as long
declare function caca_conio_wherey() as long
declare sub caca_conio_window(byval left as long, byval top as long, byval right as long, byval bottom as long)
type cucul_buffer_t as cucul_buffer
#undef cucul_putchar
declare function cucul_putchar(byval as caca_canvas_t ptr, byval as long, byval as long, byval as culong) as long
#undef cucul_getchar
declare function cucul_getchar(byval as caca_canvas_t ptr, byval as long, byval as long) as culong
declare function cucul_putstr(byval as caca_canvas_t ptr, byval as long, byval as long, byval as const zstring ptr) as long
declare function cucul_set_color(byval as caca_canvas_t ptr, byval as ubyte, byval as ubyte) as long
declare function cucul_set_truecolor(byval as caca_canvas_t ptr, byval as ulong, byval as ulong) as long
declare function cucul_get_canvas_frame_count(byval as caca_canvas_t ptr) as ulong
declare function cucul_set_canvas_frame(byval as caca_canvas_t ptr, byval as ulong) as long
declare function cucul_create_canvas_frame(byval as caca_canvas_t ptr, byval as ulong) as long
declare function cucul_free_canvas_frame(byval as caca_canvas_t ptr, byval as ulong) as long
declare function cucul_load_memory(byval as any ptr, byval as culong) as cucul_buffer_t ptr
declare function cucul_load_file(byval as const zstring ptr) as cucul_buffer_t ptr
declare function cucul_get_buffer_size(byval as cucul_buffer_t ptr) as culong
declare function cucul_get_buffer_data(byval as cucul_buffer_t ptr) as any ptr
declare function cucul_free_buffer(byval as cucul_buffer_t ptr) as long
declare function cucul_export_canvas(byval as caca_canvas_t ptr, byval as const zstring ptr) as cucul_buffer_t ptr
declare function cucul_import_canvas(byval as cucul_buffer_t ptr, byval as const zstring ptr) as caca_canvas_t ptr

#if defined(__FB_DOS__) or defined(__FB_UNIX__)
	declare function caca_import_memory(byval as caca_canvas_t ptr, byval as const any ptr, byval as uinteger, byval as const zstring ptr) as integer
	declare function caca_import_file(byval as caca_canvas_t ptr, byval as const zstring ptr, byval as const zstring ptr) as integer
	declare function caca_export_memory(byval as const caca_canvas_t ptr, byval as const zstring ptr, byval as uinteger ptr) as any ptr
#endif

declare function cucul_rotate(byval as caca_canvas_t ptr) as long
declare function cucul_set_dither_invert(byval as caca_dither_t ptr, byval as long) as long
declare function cucul_set_dither_mode(byval as caca_dither_t ptr, byval as const zstring ptr) as long
declare function cucul_get_dither_mode_list(byval as const caca_dither_t ptr) as const zstring const ptr ptr

const CUCUL_COLOR_BLACK = CACA_BLACK
const CUCUL_COLOR_BLUE = CACA_BLUE
const CUCUL_COLOR_GREEN = CACA_GREEN
const CUCUL_COLOR_CYAN = CACA_CYAN
const CUCUL_COLOR_RED = CACA_RED
const CUCUL_COLOR_MAGENTA = CACA_MAGENTA
const CUCUL_COLOR_BROWN = CACA_BROWN
const CUCUL_COLOR_LIGHTGRAY = CACA_LIGHTGRAY
const CUCUL_COLOR_DARKGRAY = CACA_DARKGRAY
const CUCUL_COLOR_LIGHTBLUE = CACA_LIGHTBLUE
const CUCUL_COLOR_LIGHTGREEN = CACA_LIGHTGREEN
const CUCUL_COLOR_LIGHTCYAN = CACA_LIGHTCYAN
const CUCUL_COLOR_LIGHTRED = CACA_LIGHTRED
const CUCUL_COLOR_LIGHTMAGENTA = CACA_LIGHTMAGENTA
const CUCUL_COLOR_YELLOW = CACA_YELLOW
const CUCUL_COLOR_WHITE = CACA_YELLOW
const CUCUL_COLOR_DEFAULT = CACA_DEFAULT
const CUCUL_COLOR_TRANSPARENT = CACA_TRANSPARENT

type cucul_canvas_t as caca_canvas_t
type cucul_dither_t as caca_dither_t
type cucul_font_t as caca_font_t
type cucul_file_t as caca_file_t
type cucul_display_t as caca_display_t
type cucul_event_t as caca_event_t

const CUCUL_BLACK = CACA_BLACK
const CUCUL_BLUE = CACA_BLUE
const CUCUL_GREEN = CACA_GREEN
const CUCUL_CYAN = CACA_CYAN
const CUCUL_RED = CACA_RED
const CUCUL_MAGENTA = CACA_MAGENTA
const CUCUL_BROWN = CACA_BROWN
const CUCUL_LIGHTGRAY = CACA_LIGHTGRAY
const CUCUL_DARKGRAY = CACA_DARKGRAY
const CUCUL_LIGHTBLUE = CACA_LIGHTBLUE
const CUCUL_LIGHTGREEN = CACA_LIGHTGREEN
const CUCUL_LIGHTCYAN = CACA_LIGHTCYAN
const CUCUL_LIGHTRED = CACA_LIGHTRED
const CUCUL_LIGHTMAGENTA = CACA_LIGHTMAGENTA
const CUCUL_YELLOW = CACA_YELLOW
const CUCUL_WHITE = CACA_YELLOW
const CUCUL_DEFAULT = CACA_DEFAULT
const CUCUL_TRANSPARENT = CACA_TRANSPARENT
const CUCUL_BOLD = CACA_BOLD
const CUCUL_ITALICS = CACA_ITALICS
const CUCUL_UNDERLINE = CACA_UNDERLINE
const CUCUL_BLINK = CACA_BLINK

declare function caca_get_cursor_x alias "caca_wherex"(byval as const caca_canvas_t ptr) as long
declare function caca_get_cursor_y alias "caca_wherey"(byval as const caca_canvas_t ptr) as long
declare function cucul_draw_triangle alias "caca_draw_triangle"(byval as caca_canvas_t ptr, byval as long, byval as long, byval as long, byval as long, byval as long, byval as long, byval as ulong) as long
declare function cucul_draw_thin_triangle alias "caca_draw_thin_triangle"(byval as caca_canvas_t ptr, byval as long, byval as long, byval as long, byval as long, byval as long, byval as long) as long
declare function cucul_fill_triangle alias "caca_fill_triangle"(byval as caca_canvas_t ptr, byval as long, byval as long, byval as long, byval as long, byval as long, byval as long, byval as ulong) as long
declare function cucul_load_font alias "caca_load_font"(byval as const any ptr, byval as uinteger) as caca_font_t ptr
declare function cucul_get_font_list alias "caca_get_font_list"() as const zstring const ptr ptr
declare function cucul_get_font_width alias "caca_get_font_width"(byval as const caca_font_t ptr) as long
declare function cucul_get_font_height alias "caca_get_font_height"(byval as const caca_font_t ptr) as long
declare function cucul_get_font_blocks alias "caca_get_font_blocks"(byval as const caca_font_t ptr) as const ulong ptr
declare function cucul_render_canvas alias "caca_render_canvas"(byval as const caca_canvas_t ptr, byval as const caca_font_t ptr, byval as any ptr, byval as long, byval as long, byval as long) as long
declare function cucul_free_font alias "caca_free_font"(byval as caca_font_t ptr) as long
declare function cucul_gotoxy alias "caca_gotoxy"(byval as caca_canvas_t ptr, byval as long, byval as long) as long
declare function cucul_get_cursor_x alias "caca_wherex"(byval as const caca_canvas_t ptr) as long
declare function cucul_get_cursor_y alias "caca_wherey"(byval as const caca_canvas_t ptr) as long
declare function cucul_put_char alias "caca_put_char"(byval as caca_canvas_t ptr, byval as long, byval as long, byval as ulong) as long
declare function cucul_get_char alias "caca_get_char"(byval as const caca_canvas_t ptr, byval as long, byval as long) as ulong
declare function cucul_put_str alias "caca_put_str"(byval as caca_canvas_t ptr, byval as long, byval as long, byval as const zstring ptr) as long
declare function cucul_printf alias "caca_printf"(byval as caca_canvas_t ptr, byval as long, byval as long, byval as const zstring ptr, ...) as long
declare function cucul_clear_canvas alias "caca_clear_canvas"(byval as caca_canvas_t ptr) as long
declare function cucul_set_canvas_handle alias "caca_set_canvas_handle"(byval as caca_canvas_t ptr, byval as long, byval as long) as long
declare function cucul_get_canvas_handle_x alias "caca_get_canvas_handle_x"(byval as const caca_canvas_t ptr) as long
declare function cucul_get_canvas_handle_y alias "caca_get_canvas_handle_y"(byval as const caca_canvas_t ptr) as long
declare function cucul_blit alias "caca_blit"(byval as caca_canvas_t ptr, byval as long, byval as long, byval as const caca_canvas_t ptr, byval as const caca_canvas_t ptr) as long
declare function cucul_set_canvas_boundaries alias "caca_set_canvas_boundaries"(byval as caca_canvas_t ptr, byval as long, byval as long, byval as long, byval as long) as long

#ifdef __FB_WIN32__
	#define cucul_import_memory caca_import_memory
	#define cucul_import_file caca_import_file
#else
	declare function cucul_import_memory alias "caca_import_memory"(byval as caca_canvas_t ptr, byval as const any ptr, byval as uinteger, byval as const zstring ptr) as integer
	declare function cucul_import_file alias "caca_import_file"(byval as caca_canvas_t ptr, byval as const zstring ptr, byval as const zstring ptr) as integer
#endif

declare function cucul_get_import_list alias "caca_get_import_list"() as const zstring const ptr ptr
declare function cucul_create_canvas alias "caca_create_canvas"(byval as long, byval as long) as caca_canvas_t ptr
declare function cucul_manage_canvas alias "caca_manage_canvas"(byval as caca_canvas_t ptr, byval as function(byval as any ptr) as long, byval as any ptr) as long
declare function cucul_unmanage_canvas alias "caca_unmanage_canvas"(byval as caca_canvas_t ptr, byval as function(byval as any ptr) as long, byval as any ptr) as long
declare function cucul_set_canvas_size alias "caca_set_canvas_size"(byval as caca_canvas_t ptr, byval as long, byval as long) as long
declare function cucul_get_canvas_width alias "caca_get_canvas_width"(byval as const caca_canvas_t ptr) as long
declare function cucul_get_canvas_height alias "caca_get_canvas_height"(byval as const caca_canvas_t ptr) as long
declare function cucul_get_canvas_chars alias "caca_get_canvas_chars"(byval as const caca_canvas_t ptr) as const ulong ptr
declare function cucul_get_canvas_attrs alias "caca_get_canvas_attrs"(byval as const caca_canvas_t ptr) as const ulong ptr
declare function cucul_free_canvas alias "caca_free_canvas"(byval as caca_canvas_t ptr) as long
declare function cucul_rand alias "caca_rand"(byval as long, byval as long) as long

#ifdef __FB_WIN32__
	#define cucul_export_memory caca_export_memory
#else
	declare function cucul_export_memory alias "caca_export_memory"(byval as const caca_canvas_t ptr, byval as const zstring ptr, byval as uinteger ptr) as any ptr
#endif

declare function cucul_get_export_list alias "caca_get_export_list"() as const zstring const ptr ptr
declare function cucul_get_version alias "caca_get_version"() as const zstring ptr
declare function cucul_utf8_to_utf32 alias "caca_utf8_to_utf32"(byval as const zstring ptr, byval as uinteger ptr) as ulong
declare function cucul_utf32_to_utf8 alias "caca_utf32_to_utf8"(byval as zstring ptr, byval as ulong) as uinteger
declare function cucul_utf32_to_cp437 alias "caca_utf32_to_cp437"(byval as ulong) as ubyte
declare function cucul_cp437_to_utf32 alias "caca_cp437_to_utf32"(byval as ubyte) as ulong
declare function cucul_utf32_to_ascii alias "caca_utf32_to_ascii"(byval as ulong) as byte
declare function cucul_utf32_is_fullwidth alias "caca_utf32_is_fullwidth"(byval as ulong) as long
declare function cucul_draw_circle alias "caca_draw_circle"(byval as caca_canvas_t ptr, byval as long, byval as long, byval as long, byval as ulong) as long
declare function cucul_draw_ellipse alias "caca_draw_ellipse"(byval as caca_canvas_t ptr, byval as long, byval as long, byval as long, byval as long, byval as ulong) as long
declare function cucul_draw_thin_ellipse alias "caca_draw_thin_ellipse"(byval as caca_canvas_t ptr, byval as long, byval as long, byval as long, byval as long) as long
declare function cucul_fill_ellipse alias "caca_fill_ellipse"(byval as caca_canvas_t ptr, byval as long, byval as long, byval as long, byval as long, byval as ulong) as long
declare function cucul_canvas_set_figfont alias "caca_canvas_set_figfont"(byval as caca_canvas_t ptr, byval as const zstring ptr) as long
declare function cucul_put_figchar alias "caca_put_figchar"(byval as caca_canvas_t ptr, byval as ulong) as long
declare function cucul_flush_figlet alias "caca_flush_figlet"(byval as caca_canvas_t ptr) as long
#undef cucul_putchar
#define cucul_putchar caca_putchar
#undef cucul_getchar
#define cucul_getchar caca_getchar
declare function cucul_get_attr alias "caca_get_attr"(byval as const caca_canvas_t ptr, byval as long, byval as long) as ulong
declare function cucul_set_attr alias "caca_set_attr"(byval as caca_canvas_t ptr, byval as ulong) as long
declare function cucul_put_attr alias "caca_put_attr"(byval as caca_canvas_t ptr, byval as long, byval as long, byval as ulong) as long
declare function cucul_set_color_ansi alias "caca_set_color_ansi"(byval as caca_canvas_t ptr, byval as ubyte, byval as ubyte) as long
declare function cucul_set_color_argb alias "caca_set_color_argb"(byval as caca_canvas_t ptr, byval as ushort, byval as ushort) as long
declare function cucul_attr_to_ansi alias "caca_attr_to_ansi"(byval as ulong) as ubyte
declare function cucul_attr_to_ansi_fg alias "caca_attr_to_ansi_fg"(byval as ulong) as ubyte
declare function cucul_attr_to_ansi_bg alias "caca_attr_to_ansi_bg"(byval as ulong) as ubyte
declare function cucul_attr_to_rgb12_fg alias "caca_attr_to_rgb12_fg"(byval as ulong) as ushort
declare function cucul_attr_to_rgb12_bg alias "caca_attr_to_rgb12_bg"(byval as ulong) as ushort
declare sub cucul_attr_to_argb64 alias "caca_attr_to_argb64"(byval as ulong, byval as ubyte ptr)
declare function cucul_invert alias "caca_invert"(byval as caca_canvas_t ptr) as long
declare function cucul_flip alias "caca_flip"(byval as caca_canvas_t ptr) as long
declare function cucul_flop alias "caca_flop"(byval as caca_canvas_t ptr) as long
declare function cucul_rotate_180 alias "caca_rotate_180"(byval as caca_canvas_t ptr) as long
declare function cucul_rotate_left alias "caca_rotate_left"(byval as caca_canvas_t ptr) as long
declare function cucul_rotate_right alias "caca_rotate_right"(byval as caca_canvas_t ptr) as long
declare function cucul_stretch_left alias "caca_stretch_left"(byval as caca_canvas_t ptr) as long
declare function cucul_stretch_right alias "caca_stretch_right"(byval as caca_canvas_t ptr) as long
declare function cucul_file_open alias "caca_file_open"(byval as const zstring ptr, byval as const zstring ptr) as caca_file_t ptr
declare function cucul_file_close alias "caca_file_close"(byval as caca_file_t ptr) as long
declare function cucul_file_tell alias "caca_file_tell"(byval as caca_file_t ptr) as ulongint
declare function cucul_file_read alias "caca_file_read"(byval as caca_file_t ptr, byval as any ptr, byval as uinteger) as uinteger
declare function cucul_file_write alias "caca_file_write"(byval as caca_file_t ptr, byval as const any ptr, byval as uinteger) as uinteger
declare function cucul_file_gets alias "caca_file_gets"(byval as caca_file_t ptr, byval as zstring ptr, byval as long) as zstring ptr
declare function cucul_file_eof alias "caca_file_eof"(byval as caca_file_t ptr) as long
declare function cucul_create_dither alias "caca_create_dither"(byval as long, byval as long, byval as long, byval as long, byval as ulong, byval as ulong, byval as ulong, byval as ulong) as caca_dither_t ptr
declare function cucul_set_dither_palette alias "caca_set_dither_palette"(byval as caca_dither_t ptr, byval r as ulong ptr, byval g as ulong ptr, byval b as ulong ptr, byval a as ulong ptr) as long
declare function cucul_set_dither_brightness alias "caca_set_dither_brightness"(byval as caca_dither_t ptr, byval as single) as long
declare function cucul_get_dither_brightness alias "caca_get_dither_brightness"(byval as const caca_dither_t ptr) as single
declare function cucul_set_dither_gamma alias "caca_set_dither_gamma"(byval as caca_dither_t ptr, byval as single) as long
declare function cucul_get_dither_gamma alias "caca_get_dither_gamma"(byval as const caca_dither_t ptr) as single
declare function cucul_set_dither_contrast alias "caca_set_dither_contrast"(byval as caca_dither_t ptr, byval as single) as long
declare function cucul_get_dither_contrast alias "caca_get_dither_contrast"(byval as const caca_dither_t ptr) as single
declare function cucul_set_dither_antialias alias "caca_set_dither_antialias"(byval as caca_dither_t ptr, byval as const zstring ptr) as long
declare function cucul_get_dither_antialias_list alias "caca_get_dither_antialias_list"(byval as const caca_dither_t ptr) as const zstring const ptr ptr
declare function cucul_get_dither_antialias alias "caca_get_dither_antialias"(byval as const caca_dither_t ptr) as const zstring ptr
declare function cucul_set_dither_color alias "caca_set_dither_color"(byval as caca_dither_t ptr, byval as const zstring ptr) as long
declare function cucul_get_dither_color_list alias "caca_get_dither_color_list"(byval as const caca_dither_t ptr) as const zstring const ptr ptr
declare function cucul_get_dither_color alias "caca_get_dither_color"(byval as const caca_dither_t ptr) as const zstring ptr
declare function cucul_set_dither_charset alias "caca_set_dither_charset"(byval as caca_dither_t ptr, byval as const zstring ptr) as long
declare function cucul_get_dither_charset_list alias "caca_get_dither_charset_list"(byval as const caca_dither_t ptr) as const zstring const ptr ptr
declare function cucul_get_dither_charset alias "caca_get_dither_charset"(byval as const caca_dither_t ptr) as const zstring ptr
declare function cucul_set_dither_algorithm alias "caca_set_dither_algorithm"(byval as caca_dither_t ptr, byval as const zstring ptr) as long
declare function cucul_get_dither_algorithm_list alias "caca_get_dither_algorithm_list"(byval as const caca_dither_t ptr) as const zstring const ptr ptr
declare function cucul_get_dither_algorithm alias "caca_get_dither_algorithm"(byval as const caca_dither_t ptr) as const zstring ptr
declare function cucul_dither_bitmap alias "caca_dither_bitmap"(byval as caca_canvas_t ptr, byval as long, byval as long, byval as long, byval as long, byval as const caca_dither_t ptr, byval as const any ptr) as long
declare function cucul_free_dither alias "caca_free_dither"(byval as caca_dither_t ptr) as long
declare function cucul_draw_line alias "caca_draw_line"(byval as caca_canvas_t ptr, byval as long, byval as long, byval as long, byval as long, byval as ulong) as long
declare function cucul_draw_polyline alias "caca_draw_polyline"(byval as caca_canvas_t ptr, byval x as const long ptr, byval y as const long ptr, byval as long, byval as ulong) as long
declare function cucul_draw_thin_line alias "caca_draw_thin_line"(byval as caca_canvas_t ptr, byval as long, byval as long, byval as long, byval as long) as long
declare function cucul_draw_thin_polyline alias "caca_draw_thin_polyline"(byval as caca_canvas_t ptr, byval x as const long ptr, byval y as const long ptr, byval as long) as long
declare function cucul_draw_box alias "caca_draw_box"(byval as caca_canvas_t ptr, byval as long, byval as long, byval as long, byval as long, byval as ulong) as long
declare function cucul_draw_thin_box alias "caca_draw_thin_box"(byval as caca_canvas_t ptr, byval as long, byval as long, byval as long, byval as long) as long
declare function cucul_draw_cp437_box alias "caca_draw_cp437_box"(byval as caca_canvas_t ptr, byval as long, byval as long, byval as long, byval as long) as long
declare function cucul_fill_box alias "caca_fill_box"(byval as caca_canvas_t ptr, byval as long, byval as long, byval as long, byval as long, byval as ulong) as long
declare function cucul_get_frame_count alias "caca_get_frame_count"(byval as const caca_canvas_t ptr) as long
declare function cucul_set_frame alias "caca_set_frame"(byval as caca_canvas_t ptr, byval as long) as long
declare function cucul_get_frame_name alias "caca_get_frame_name"(byval as const caca_canvas_t ptr) as const zstring ptr
declare function cucul_set_frame_name alias "caca_set_frame_name"(byval as caca_canvas_t ptr, byval as const zstring ptr) as long
declare function cucul_create_frame alias "caca_create_frame"(byval as caca_canvas_t ptr, byval as long) as long
declare function cucul_free_frame alias "caca_free_frame"(byval as caca_canvas_t ptr, byval as long) as long

end extern
