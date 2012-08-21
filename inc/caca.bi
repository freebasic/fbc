/'
 *  libcaca       Colour ASCII-Art library
 *  Copyright (c) 2002-2012 Sam Hocevar <sam@hocevar.net>
 *                All Rights Reserved
 *
 *  This library is free software. It comes without any warranty, to
 *  the extent permitted by applicable law. You can redistribute it
 *  and/or modify it under the terms of the Do What The Fuck You Want
 *  To Public License, Version 2, as published by Sam Hocevar. See
 *  http://sam.zoy.org/wtfpl/COPYING for more details.
 '/

#ifndef __CACA_BI__
#define __CACA_BI__

#inclib "caca"

#include "crt/stdint.bi"

#define CACA_API_VERSION_1

extern "C"

type caca_canvas_t as caca_canvas
type caca_dither_t as caca_dither
type caca_charfont_t as caca_charfont
type caca_font_t as caca_font
type caca_file_t as caca_file
type caca_display_t as caca_display
type caca_event_t as caca_event

enum caca_color
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

enum caca_style
	CACA_BOLD = &h01
	CACA_ITALICS = &h02
	CACA_UNDERLINE = &h04
	CACA_BLINK = &h08
end enum

enum caca_event_type
#ifdef __CACA0_BI__
	'' Prevent collisions with caca0.bi #defines
	__DUMMY
#else
	CACA_EVENT_NONE = &h0000
	CACA_EVENT_KEY_PRESS = &h0001
	CACA_EVENT_KEY_RELEASE = &h0002
	CACA_EVENT_MOUSE_PRESS = &h0004
	CACA_EVENT_MOUSE_RELEASE = &h0008
	CACA_EVENT_MOUSE_MOTION = &h0010
	CACA_EVENT_RESIZE = &h0020
	CACA_EVENT_QUIT = &h0040
	CACA_EVENT_ANY = &hffff
#endif
end enum

type caca_event_data_mouse
	as integer x, y, button
end type

type caca_event_data_resize
	as integer w, h
end type

type caca_event_data_key
	ch as integer
	utf32 as uint32_t
	utf8(0 to 7) as byte
end type

union caca_event_data
	mouse as caca_event_data_mouse
	resize as caca_event_data_resize
	key as caca_event_data_key
end union

type caca_event
	type as caca_event_type
	data as caca_event_data
	padding(0 to 15) as uint8_t
end type

type caca_option
	name as const zstring ptr
	has_arg as integer
	flag as integer ptr
	val as integer
end type

enum caca_key
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

declare function caca_create_canvas(byval as integer, byval as integer) as caca_canvas_t ptr
declare function caca_manage_canvas(byval as caca_canvas_t ptr, byval as function(byval as any ptr) as integer, byval as any ptr) as integer
declare function caca_unmanage_canvas(byval as caca_canvas_t ptr, byval as function(byval as any ptr) as integer, byval as any ptr) as integer
declare function caca_set_canvas_size(byval as caca_canvas_t ptr, byval as integer, byval as integer) as integer
declare function caca_get_canvas_width(byval as const caca_canvas_t ptr) as integer
declare function caca_get_canvas_height(byval as const caca_canvas_t ptr) as integer
declare function caca_get_canvas_chars(byval as const caca_canvas_t ptr) as const uint32_t ptr
declare function caca_get_canvas_attrs(byval as const caca_canvas_t ptr) as const uint32_t ptr
declare function caca_free_canvas(byval as caca_canvas_t ptr) as integer
#ifdef __CACA0_BI__
declare function caca1_rand alias "caca_rand"(byval as integer, byval as integer) as integer
#else
declare function caca_rand(byval as integer, byval as integer) as integer
#endif
declare function caca_get_version() as const zstring ptr

#define CACA_MAGIC_FULLWIDTH &h000ffffe

declare function caca_gotoxy(byval as caca_canvas_t ptr, byval as integer, byval as integer) as integer
declare function caca_wherex(byval as const caca_canvas_t ptr) as integer
declare function caca_wherey(byval as const caca_canvas_t ptr) as integer
declare function caca_put_char(byval as caca_canvas_t ptr, byval as integer, byval as integer, byval as uint32_t) as integer
declare function caca_get_char(byval as const caca_canvas_t ptr, byval as integer, byval as integer) as uint32_t
declare function caca_put_str(byval as caca_canvas_t ptr, byval as integer, byval as integer, byval as const zstring ptr) as integer
#ifdef __CACA0_BI__
declare function caca1_printf alias "caca_printf"(byval as caca_canvas_t ptr, byval as integer, byval as integer, byval as const zstring ptr, ...) as integer
#else
declare function caca_printf(byval as caca_canvas_t ptr, byval as integer, byval as integer, byval as const zstring ptr, ...) as integer
#endif
declare function caca_vprintf(byval as caca_canvas_t ptr, byval as integer, byval as integer, byval as const zstring ptr, byval as va_list) as integer
declare function caca_clear_canvas(byval as caca_canvas_t ptr) as integer
declare function caca_set_canvas_handle(byval as caca_canvas_t ptr, byval as integer, byval as integer) as integer
declare function caca_get_canvas_handle_x(byval as const caca_canvas_t ptr) as integer
declare function caca_get_canvas_handle_y(byval as const caca_canvas_t ptr) as integer
declare function caca_blit(byval as caca_canvas_t ptr, byval as integer, byval as integer, byval as const caca_canvas_t ptr, byval as const caca_canvas_t ptr) as integer
declare function caca_set_canvas_boundaries(byval as caca_canvas_t ptr, byval as integer, byval as integer, byval as integer, byval as integer) as integer

declare function caca_disable_dirty_rect(byval as caca_canvas_t ptr) as integer
declare function caca_enable_dirty_rect(byval as caca_canvas_t ptr) as integer
declare function caca_get_dirty_rect_count(byval as caca_canvas_t ptr) as integer
declare function caca_get_dirty_rect(byval as caca_canvas_t ptr, byval as integer, byval as integer ptr, byval as integer ptr, byval as integer ptr, byval as integer ptr) as integer
declare function caca_add_dirty_rect(byval as caca_canvas_t ptr, byval as integer, byval as integer, byval as integer, byval as integer) as integer
declare function caca_remove_dirty_rect(byval as caca_canvas_t ptr, byval as integer, byval as integer, byval as integer, byval as integer) as integer
declare function caca_clear_dirty_rect_list(byval as caca_canvas_t ptr) as integer

declare function caca_invert(byval as caca_canvas_t ptr) as integer
declare function caca_flip(byval as caca_canvas_t ptr) as integer
declare function caca_flop(byval as caca_canvas_t ptr) as integer
declare function caca_rotate_180(byval as caca_canvas_t ptr) as integer
declare function caca_rotate_left(byval as caca_canvas_t ptr) as integer
declare function caca_rotate_right(byval as caca_canvas_t ptr) as integer
declare function caca_stretch_left(byval as caca_canvas_t ptr) as integer
declare function caca_stretch_right(byval as caca_canvas_t ptr) as integer

declare function caca_get_attr(byval as const caca_canvas_t ptr, byval as integer, byval as integer) as uint32_t
declare function caca_set_attr(byval as caca_canvas_t ptr, byval as uint32_t) as integer
declare function caca_unset_attr(byval as caca_canvas_t ptr, byval as uint32_t) as integer
declare function caca_toggle_attr(byval as caca_canvas_t ptr, byval as uint32_t) as integer
declare function caca_put_attr(byval as caca_canvas_t ptr, byval as integer, byval as integer, byval as uint32_t) as integer
declare function caca_set_color_ansi(byval as caca_canvas_t ptr, byval as uint8_t, byval as uint8_t) as integer
declare function caca_set_color_argb(byval as caca_canvas_t ptr, byval as uint16_t, byval as uint16_t) as integer
declare function caca_attr_to_ansi(byval as uint32_t) as uint8_t
declare function caca_attr_to_ansi_fg(byval as uint32_t) as uint8_t
declare function caca_attr_to_ansi_bg(byval as uint32_t) as uint8_t
declare function caca_attr_to_rgb12_fg(byval as uint32_t) as uint16_t
declare function caca_attr_to_rgb12_bg(byval as uint32_t) as uint16_t
declare sub caca_attr_to_argb64(byval as uint32_t, byval as uint8_t ptr)

declare function caca_utf8_to_utf32(byval as const zstring ptr, byval as size_t ptr) as uint32_t
declare function caca_utf32_to_utf8(byval as zstring ptr, byval as uint32_t) as size_t
declare function caca_utf32_to_cp437(byval as uint32_t) as uint8_t
declare function caca_cp437_to_utf32(byval as uint8_t) as uint32_t
declare function caca_utf32_to_ascii(byval as uint32_t) as byte
declare function caca_utf32_is_fullwidth(byval as uint32_t) as integer

#ifdef __CACA0_BI__
declare function caca1_draw_line          alias "caca_draw_line"         (byval as caca_canvas_t ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as uint32_t) as integer
declare function caca1_draw_polyline      alias "caca_draw_polyline"     (byval as caca_canvas_t ptr, byval x as const integer ptr, byval y as const integer ptr, byval as integer, byval as uint32_t) as integer
declare function caca1_draw_thin_line     alias "caca_draw_thin_line"    (byval as caca_canvas_t ptr, byval as integer, byval as integer, byval as integer, byval as integer) as integer
declare function caca1_draw_thin_polyline alias "caca_draw_thin_polyline"(byval as caca_canvas_t ptr, byval x as const integer ptr, byval y as const integer ptr, byval as integer) as integer
declare function caca1_draw_circle        alias "caca_draw_circle"       (byval as caca_canvas_t ptr, byval as integer, byval as integer, byval as integer, byval as uint32_t) as integer
declare function caca1_draw_ellipse       alias "caca_draw_ellipse"      (byval as caca_canvas_t ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as uint32_t) as integer
declare function caca1_draw_thin_ellipse  alias "caca_draw_thin_ellipse" (byval as caca_canvas_t ptr, byval as integer, byval as integer, byval as integer, byval as integer) as integer
declare function caca1_fill_ellipse       alias "caca_fill_ellipse"      (byval as caca_canvas_t ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as uint32_t) as integer
declare function caca1_draw_box           alias "caca_draw_box"          (byval as caca_canvas_t ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as uint32_t) as integer
declare function caca1_draw_thin_box      alias "caca_draw_thin_box"     (byval as caca_canvas_t ptr, byval as integer, byval as integer, byval as integer, byval as integer) as integer
declare function caca1_fill_box           alias "caca_fill_box"          (byval as caca_canvas_t ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as uint32_t) as integer
declare function caca1_draw_triangle      alias "caca_draw_triangle"     (byval as caca_canvas_t ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as uint32_t) as integer
declare function caca1_draw_thin_triangle alias "caca_draw_thin_triangle"(byval as caca_canvas_t ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer) as integer
declare function caca1_fill_triangle      alias "caca_fill_triangle"     (byval as caca_canvas_t ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as uint32_t) as integer
#else
declare function caca_draw_line         (byval as caca_canvas_t ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as uint32_t) as integer
declare function caca_draw_polyline     (byval as caca_canvas_t ptr, byval x as const integer ptr, byval y as const integer ptr, byval as integer, byval as uint32_t) as integer
declare function caca_draw_thin_line    (byval as caca_canvas_t ptr, byval as integer, byval as integer, byval as integer, byval as integer) as integer
declare function caca_draw_thin_polyline(byval as caca_canvas_t ptr, byval x as const integer ptr, byval y as const integer ptr, byval as integer) as integer
declare function caca_draw_circle       (byval as caca_canvas_t ptr, byval as integer, byval as integer, byval as integer, byval as uint32_t) as integer
declare function caca_draw_ellipse      (byval as caca_canvas_t ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as uint32_t) as integer
declare function caca_draw_thin_ellipse (byval as caca_canvas_t ptr, byval as integer, byval as integer, byval as integer, byval as integer) as integer
declare function caca_fill_ellipse      (byval as caca_canvas_t ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as uint32_t) as integer
declare function caca_draw_box          (byval as caca_canvas_t ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as uint32_t) as integer
declare function caca_draw_thin_box     (byval as caca_canvas_t ptr, byval as integer, byval as integer, byval as integer, byval as integer) as integer
declare function caca_fill_box          (byval as caca_canvas_t ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as uint32_t) as integer
declare function caca_draw_triangle     (byval as caca_canvas_t ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as uint32_t) as integer
declare function caca_draw_thin_triangle(byval as caca_canvas_t ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer) as integer
declare function caca_fill_triangle     (byval as caca_canvas_t ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as uint32_t) as integer
#endif
declare function caca_draw_cp437_box(byval as caca_canvas_t ptr, byval as integer, byval as integer, byval as integer, byval as integer) as integer
declare function caca_fill_triangle_textured(byval cv as caca_canvas_t ptr, byval coords as integer ptr, byval tex as caca_canvas_t ptr, byval uv as single ptr) as integer

declare function caca_get_frame_count(byval as const caca_canvas_t ptr) as integer
declare function caca_set_frame(byval as caca_canvas_t ptr, byval as integer) as integer
declare function caca_get_frame_name(byval as const caca_canvas_t ptr) as const zstring ptr
declare function caca_set_frame_name(byval as caca_canvas_t ptr, byval as const zstring ptr) as integer
declare function caca_create_frame(byval as caca_canvas_t ptr, byval as integer) as integer
declare function caca_free_frame(byval as caca_canvas_t ptr, byval as integer) as integer

declare function caca_create_dither(byval as integer, byval as integer, byval as integer, byval as integer, byval as uint32_t, byval as uint32_t, byval as uint32_t, byval as uint32_t) as caca_dither_t ptr
declare function caca_set_dither_palette(byval as caca_dither_t ptr, byval r as uint32_t ptr, byval g as uint32_t ptr, byval b as uint32_t ptr, byval a as uint32_t ptr) as integer
declare function caca_set_dither_brightness(byval as caca_dither_t ptr, byval as single) as integer
declare function caca_get_dither_brightness(byval as const caca_dither_t ptr) as single
declare function caca_set_dither_gamma(byval as caca_dither_t ptr, byval as single) as integer
declare function caca_get_dither_gamma(byval as const caca_dither_t ptr) as single
declare function caca_set_dither_contrast(byval as caca_dither_t ptr, byval as single) as integer
declare function caca_get_dither_contrast(byval as const caca_dither_t ptr) as single
declare function caca_set_dither_antialias(byval as caca_dither_t ptr, byval as const zstring ptr) as integer
declare function caca_get_dither_antialias_list(byval as const caca_dither_t ptr) as const zstring const ptr ptr
declare function caca_get_dither_antialias(byval as const caca_dither_t ptr) as const zstring ptr
declare function caca_set_dither_color(byval as caca_dither_t ptr, byval as const zstring ptr) as integer
declare function caca_get_dither_color_list(byval as const caca_dither_t ptr) as const zstring const ptr ptr
declare function caca_get_dither_color(byval as const caca_dither_t ptr) as const zstring ptr
declare function caca_set_dither_charset(byval as caca_dither_t ptr, byval as const zstring ptr) as integer
declare function caca_get_dither_charset_list(byval as const caca_dither_t ptr) as const zstring const ptr ptr
declare function caca_get_dither_charset(byval as const caca_dither_t ptr) as const zstring ptr
declare function caca_set_dither_algorithm(byval as caca_dither_t ptr, byval as const zstring ptr) as integer
declare function caca_get_dither_algorithm_list(byval as const caca_dither_t ptr) as const zstring const ptr ptr
declare function caca_get_dither_algorithm(byval as const caca_dither_t ptr) as const zstring ptr
declare function caca_dither_bitmap(byval as caca_canvas_t ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as const caca_dither_t ptr, byval as const any ptr) as integer
declare function caca_free_dither(byval as caca_dither_t ptr) as integer

declare function caca_load_charfont(byval as const any ptr, byval as size_t) as caca_charfont_t ptr
declare function caca_free_charfont(byval as caca_charfont_t ptr) as integer

declare function caca_load_font(byval as const any ptr, byval as size_t) as caca_font_t ptr
declare function caca_get_font_list() as const zstring const ptr ptr
declare function caca_get_font_width(byval as const caca_font_t ptr) as integer
declare function caca_get_font_height(byval as const caca_font_t ptr) as integer
declare function caca_get_font_blocks(byval as const caca_font_t ptr) as const uint32_t ptr
declare function caca_render_canvas(byval as const caca_canvas_t ptr, byval as const caca_font_t ptr, byval as any ptr, byval as integer, byval as integer, byval as integer) as integer
declare function caca_free_font(byval as caca_font_t ptr) as integer

declare function caca_canvas_set_figfont(byval as caca_canvas_t ptr, byval as const zstring ptr) as integer
declare function caca_set_figfont_smush(byval as caca_canvas_t ptr, byval as const zstring ptr) as integer
declare function caca_set_figfont_width(byval as caca_canvas_t ptr, byval as integer) as integer
declare function caca_put_figchar(byval as caca_canvas_t ptr, byval as uint32_t) as integer
declare function caca_flush_figlet(byval as caca_canvas_t ptr) as integer

declare function caca_file_open(byval as const zstring ptr, byval as const zstring ptr) as caca_file_t ptr
declare function caca_file_close(byval as caca_file_t ptr) as integer
declare function caca_file_tell(byval as caca_file_t ptr) as uint64_t
declare function caca_file_read(byval as caca_file_t ptr, byval as any ptr, byval as size_t) as size_t
declare function caca_file_write(byval as caca_file_t ptr, byval as const any ptr, byval as size_t) as size_t
declare function caca_file_gets(byval as caca_file_t ptr, byval as zstring ptr, byval as integer) as zstring ptr
declare function caca_file_eof(byval as caca_file_t ptr) as integer

declare function caca_import_canvas_from_memory(byval as caca_canvas_t ptr, byval as const any ptr, byval as size_t, byval as const zstring ptr) as ssize_t
declare function caca_import_canvas_from_file(byval as caca_canvas_t ptr, byval as const zstring ptr, byval as const zstring ptr) as ssize_t
declare function caca_import_area_from_memory(byval as caca_canvas_t ptr, byval as integer, byval as integer, byval as const any ptr, byval as size_t, byval as const zstring ptr) as ssize_t
declare function caca_import_area_from_file(byval as caca_canvas_t ptr, byval as integer, byval as integer, byval as const zstring ptr, byval as const zstring ptr) as ssize_t
declare function caca_get_import_list() as const zstring const ptr ptr
declare function caca_export_canvas_to_memory(byval as const caca_canvas_t ptr, byval as const zstring ptr, byval as size_t ptr) as any ptr
declare function caca_export_area_to_memory(byval as const caca_canvas_t ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as const zstring ptr, byval as size_t ptr) as any ptr
declare function caca_get_export_list() as const zstring const ptr ptr

declare function caca_create_display(byval as caca_canvas_t ptr) as caca_display_t ptr
declare function caca_create_display_with_driver(byval as caca_canvas_t ptr, byval as const zstring ptr) as caca_display_t ptr
declare function caca_get_display_driver_list() as const zstring const ptr ptr
declare function caca_get_display_driver(byval as caca_display_t ptr) as const zstring ptr
declare function caca_set_display_driver(byval as caca_display_t ptr, byval as const zstring ptr) as integer
declare function caca_free_display(byval as caca_display_t ptr) as integer
declare function caca_get_canvas(byval as caca_display_t ptr) as caca_canvas_t ptr
declare function caca_refresh_display(byval as caca_display_t ptr) as integer
declare function caca_set_display_time(byval as caca_display_t ptr, byval as integer) as integer
declare function caca_get_display_time(byval as const caca_display_t ptr) as integer
declare function caca_get_display_width(byval as const caca_display_t ptr) as integer
declare function caca_get_display_height(byval as const caca_display_t ptr) as integer
declare function caca_set_display_title(byval as caca_display_t ptr, byval as const zstring ptr) as integer
declare function caca_set_mouse(byval as caca_display_t ptr, byval as integer) as integer
declare function caca_set_cursor(byval as caca_display_t ptr, byval as integer) as integer

#ifdef __CACA0_BI__
'' Prevent collisions with caca0.bi #defines
declare function caca1_get_event alias "caca_get_event"(byval as caca_display_t ptr, byval as integer, byval as caca_event_t ptr, byval as integer) as integer
declare function caca1_get_mouse_x alias "caca_get_mouse_x"(byval as const caca_display_t ptr) as integer
declare function caca1_get_mouse_y alias "caca_get_mouse_y"(byval as const caca_display_t ptr) as integer
#else
declare function caca_get_event(byval as caca_display_t ptr, byval as integer, byval as caca_event_t ptr, byval as integer) as integer
declare function caca_get_mouse_x(byval as const caca_display_t ptr) as integer
declare function caca_get_mouse_y(byval as const caca_display_t ptr) as integer
#endif
declare function caca_get_event_type(byval as const caca_event_t ptr) as caca_event_type
declare function caca_get_event_key_ch(byval as const caca_event_t ptr) as integer
declare function caca_get_event_key_utf32(byval as const caca_event_t ptr) as uint32_t
declare function caca_get_event_key_utf8(byval as const caca_event_t ptr, byval as byte ptr) as integer
declare function caca_get_event_mouse_button(byval as const caca_event_t ptr) as integer
declare function caca_get_event_mouse_x(byval as const caca_event_t ptr) as integer
declare function caca_get_event_mouse_y(byval as const caca_event_t ptr) as integer
declare function caca_get_event_resize_width(byval as const caca_event_t ptr) as integer
declare function caca_get_event_resize_height(byval as const caca_event_t ptr) as integer

extern caca_optind as integer
extern caca_optarg as zstring ptr
declare function caca_getopt(byval as integer, byval as const zstring ptr ptr, byval as const zstring ptr, byval as const caca_option ptr, byval as integer ptr) as integer

enum CACA_CONIO_COLORS
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

enum CACA_CONIO_CURSOR
	CACA_CONIO__NOCURSOR = 0
	CACA_CONIO__SOLIDCURSOR = 1
	CACA_CONIO__NORMALCURSOR = 2
end enum

enum CACA_CONIO_MODE
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

extern caca_conio_directvideo as integer
extern caca_conio__wscroll as integer

declare function caca_conio_cgets(byval str as zstring ptr) as zstring ptr
declare sub caca_conio_clreol()
declare sub caca_conio_clrscr()
declare function caca_conio_cprintf(byval format as const zstring ptr, ...) as integer
declare function caca_conio_cputs(byval str as const zstring ptr) as integer
declare function caca_conio_cscanf(byval format as zstring ptr, ...) as integer
declare sub caca_conio_delay(byval as uinteger)
declare sub caca_conio_delline()
declare function caca_conio_getch() as integer
declare function caca_conio_getche() as integer
declare function caca_conio_getpass(byval prompt as const zstring ptr) as zstring ptr
declare function caca_conio_gettext(byval left as integer, byval top as integer, byval right as integer, byval bottom as integer, byval destin as any ptr) as integer
declare sub caca_conio_gettextinfo(byval r as caca_conio_text_info ptr)
declare sub caca_conio_gotoxy(byval x as integer, byval y as integer)
declare sub caca_conio_highvideo()
declare sub caca_conio_insline()
declare function caca_conio_kbhit() as integer
declare sub caca_conio_lowvideo()
declare function caca_conio_movetext(byval left as integer, byval top as integer, byval right as integer, byval bottom as integer, byval destleft as integer, byval desttop as integer) as integer
declare sub caca_conio_normvideo()
declare sub caca_conio_nosound()
declare function caca_conio_printf(byval format as const zstring ptr, ...) as integer
declare function caca_conio_putch(byval ch as integer) as integer
declare function caca_conio_puttext(byval left as integer, byval top as integer, byval right as integer, byval bottom as integer, byval destin as any ptr) as integer
declare sub caca_conio__setcursortype(byval cur_t as integer)
declare sub caca_conio_sleep(byval as uinteger)
declare sub caca_conio_sound(byval as uinteger)
declare sub caca_conio_textattr(byval newattr as integer)
declare sub caca_conio_textbackground(byval newcolor as integer)
declare sub caca_conio_textcolor(byval newcolor as integer)
declare sub caca_conio_textmode(byval newmode as integer)
declare function caca_conio_ungetch(byval ch as integer) as integer
declare function caca_conio_wherex() as integer
declare function caca_conio_wherey() as integer
declare sub caca_conio_window(byval left as integer, byval top as integer, byval right as integer, byval bottom as integer)

type cucul_buffer_t as cucul_buffer

#define CACA_DEPRECATED

declare function cucul_putchar(byval as caca_canvas_t ptr, byval as integer, byval as integer, byval as ulong) as integer
declare function cucul_getchar(byval as caca_canvas_t ptr, byval as integer, byval as integer) as ulong
declare function cucul_putstr(byval as caca_canvas_t ptr, byval as integer, byval as integer, byval as const zstring ptr) as integer
declare function cucul_set_color(byval as caca_canvas_t ptr, byval as ubyte, byval as ubyte) as integer
declare function cucul_set_truecolor(byval as caca_canvas_t ptr, byval as uinteger, byval as uinteger) as integer
declare function cucul_get_canvas_frame_count(byval as caca_canvas_t ptr) as uinteger
declare function cucul_set_canvas_frame(byval as caca_canvas_t ptr, byval as uinteger) as integer
declare function cucul_create_canvas_frame(byval as caca_canvas_t ptr, byval as uinteger) as integer
declare function cucul_free_canvas_frame(byval as caca_canvas_t ptr, byval as uinteger) as integer
declare function cucul_load_memory(byval as any ptr, byval as ulong) as cucul_buffer_t ptr
declare function cucul_load_file(byval as const zstring ptr) as cucul_buffer_t ptr
declare function cucul_get_buffer_size(byval as cucul_buffer_t ptr) as ulong
declare function cucul_get_buffer_data(byval as cucul_buffer_t ptr) as any ptr
declare function cucul_free_buffer(byval as cucul_buffer_t ptr) as integer
declare function cucul_export_canvas(byval as caca_canvas_t ptr, byval as const zstring ptr) as cucul_buffer_t ptr
declare function cucul_import_canvas(byval as cucul_buffer_t ptr, byval as const zstring ptr) as caca_canvas_t ptr
declare function caca_import_memory(byval as caca_canvas_t ptr, byval as const any ptr, byval as size_t, byval as const zstring ptr) as ssize_t
declare function caca_import_file(byval as caca_canvas_t ptr, byval as const zstring ptr, byval as const zstring ptr) as ssize_t
declare function caca_export_memory(byval as const caca_canvas_t ptr, byval as const zstring ptr, byval as size_t ptr) as any ptr
declare function cucul_rotate(byval as caca_canvas_t ptr) as integer
declare function cucul_set_dither_invert(byval as caca_dither_t ptr, byval as integer) as integer
declare function cucul_set_dither_mode(byval as caca_dither_t ptr, byval as const zstring ptr) as integer
declare function cucul_get_dither_mode_list(byval as const caca_dither_t ptr) as const zstring const ptr ptr

#define CUCUL_COLOR_BLACK CACA_BLACK
#define CUCUL_COLOR_BLUE CACA_BLUE
#define CUCUL_COLOR_GREEN CACA_GREEN
#define CUCUL_COLOR_CYAN CACA_CYAN
#define CUCUL_COLOR_RED CACA_RED
#define CUCUL_COLOR_MAGENTA CACA_MAGENTA
#define CUCUL_COLOR_BROWN CACA_BROWN
#define CUCUL_COLOR_LIGHTGRAY CACA_LIGHTGRAY
#define CUCUL_COLOR_DARKGRAY CACA_DARKGRAY
#define CUCUL_COLOR_LIGHTBLUE CACA_LIGHTBLUE
#define CUCUL_COLOR_LIGHTGREEN CACA_LIGHTGREEN
#define CUCUL_COLOR_LIGHTCYAN CACA_LIGHTCYAN
#define CUCUL_COLOR_LIGHTRED CACA_LIGHTRED
#define CUCUL_COLOR_LIGHTMAGENTA CACA_LIGHTMAGENTA
#define CUCUL_COLOR_YELLOW CACA_YELLOW
#define CUCUL_COLOR_WHITE CACA_YELLOW
#define CUCUL_COLOR_DEFAULT CACA_DEFAULT
#define CUCUL_COLOR_TRANSPARENT CACA_TRANSPARENT

#define cucul_canvas_t caca_canvas_t
#define cucul_dither_t caca_dither_t
#define cucul_font_t caca_font_t
#define cucul_file_t caca_file_t
#define cucul_display_t caca_display_t
#define cucul_event_t caca_event_t

#define CUCUL_BLACK CACA_BLACK
#define CUCUL_BLUE CACA_BLUE
#define CUCUL_GREEN CACA_GREEN
#define CUCUL_CYAN CACA_CYAN
#define CUCUL_RED CACA_RED
#define CUCUL_MAGENTA CACA_MAGENTA
#define CUCUL_BROWN CACA_BROWN
#define CUCUL_LIGHTGRAY CACA_LIGHTGRAY
#define CUCUL_DARKGRAY CACA_DARKGRAY
#define CUCUL_LIGHTBLUE CACA_LIGHTBLUE
#define CUCUL_LIGHTGREEN CACA_LIGHTGREEN
#define CUCUL_LIGHTCYAN CACA_LIGHTCYAN
#define CUCUL_LIGHTRED CACA_LIGHTRED
#define CUCUL_LIGHTMAGENTA CACA_LIGHTMAGENTA
#define CUCUL_YELLOW CACA_YELLOW
#define CUCUL_WHITE CACA_YELLOW
#define CUCUL_DEFAULT CACA_DEFAULT
#define CUCUL_TRANSPARENT CACA_TRANSPARENT

#define CUCUL_BOLD CACA_BOLD
#define CUCUL_ITALICS CACA_ITALICS
#define CUCUL_UNDERLINE CACA_UNDERLINE
#define CUCUL_BLINK CACA_BLINK

#define caca_get_cursor_x caca_wherex
#define caca_get_cursor_y caca_wherey
#define cucul_draw_triangle caca_draw_triangle
#define cucul_draw_thin_triangle caca_draw_thin_triangle
#define cucul_fill_triangle caca_fill_triangle
#define cucul_load_font caca_load_font
#define cucul_get_font_list caca_get_font_list
#define cucul_get_font_width caca_get_font_width
#define cucul_get_font_height caca_get_font_height
#define cucul_get_font_blocks caca_get_font_blocks
#define cucul_render_canvas caca_render_canvas
#define cucul_free_font caca_free_font
#define cucul_gotoxy caca_gotoxy
#define cucul_get_cursor_x caca_wherex
#define cucul_get_cursor_y caca_wherey
#define cucul_put_char caca_put_char
#define cucul_get_char caca_get_char
#define cucul_put_str caca_put_str
#define cucul_printf caca_printf
#define cucul_clear_canvas caca_clear_canvas
#define cucul_set_canvas_handle caca_set_canvas_handle
#define cucul_get_canvas_handle_x caca_get_canvas_handle_x
#define cucul_get_canvas_handle_y caca_get_canvas_handle_y
#define cucul_blit caca_blit
#define cucul_set_canvas_boundaries caca_set_canvas_boundaries
#define cucul_import_memory caca_import_memory
#define cucul_import_file caca_import_file
#define cucul_get_import_list caca_get_import_list
#define cucul_create_canvas caca_create_canvas
#define cucul_manage_canvas caca_manage_canvas
#define cucul_unmanage_canvas caca_unmanage_canvas
#define cucul_set_canvas_size caca_set_canvas_size
#define cucul_get_canvas_width caca_get_canvas_width
#define cucul_get_canvas_height caca_get_canvas_height
#define cucul_get_canvas_chars caca_get_canvas_chars
#define cucul_get_canvas_attrs caca_get_canvas_attrs
#define cucul_free_canvas caca_free_canvas
#define cucul_rand caca_rand
#define cucul_export_memory caca_export_memory
#define cucul_get_export_list caca_get_export_list
#define cucul_get_version caca_get_version
#define cucul_utf8_to_utf32 caca_utf8_to_utf32
#define cucul_utf32_to_utf8 caca_utf32_to_utf8
#define cucul_utf32_to_cp437 caca_utf32_to_cp437
#define cucul_cp437_to_utf32 caca_cp437_to_utf32
#define cucul_utf32_to_ascii caca_utf32_to_ascii
#define cucul_utf32_is_fullwidth caca_utf32_is_fullwidth
#define cucul_draw_circle caca_draw_circle
#define cucul_draw_ellipse caca_draw_ellipse
#define cucul_draw_thin_ellipse caca_draw_thin_ellipse
#define cucul_fill_ellipse caca_fill_ellipse
#define cucul_canvas_set_figfont caca_canvas_set_figfont
#define cucul_put_figchar caca_put_figchar
#define cucul_flush_figlet caca_flush_figlet
''#define cucul_putchar caca_putchar
''#define cucul_getchar caca_getchar
#define cucul_get_attr caca_get_attr
#define cucul_set_attr caca_set_attr
#define cucul_put_attr caca_put_attr
#define cucul_set_color_ansi caca_set_color_ansi
#define cucul_set_color_argb caca_set_color_argb
#define cucul_attr_to_ansi caca_attr_to_ansi
#define cucul_attr_to_ansi_fg caca_attr_to_ansi_fg
#define cucul_attr_to_ansi_bg caca_attr_to_ansi_bg
#define cucul_attr_to_rgb12_fg caca_attr_to_rgb12_fg
#define cucul_attr_to_rgb12_bg caca_attr_to_rgb12_bg
#define cucul_attr_to_argb64 caca_attr_to_argb64
#define cucul_invert caca_invert
#define cucul_flip caca_flip
#define cucul_flop caca_flop
#define cucul_rotate_180 caca_rotate_180
#define cucul_rotate_left caca_rotate_left
#define cucul_rotate_right caca_rotate_right
#define cucul_stretch_left caca_stretch_left
#define cucul_stretch_right caca_stretch_right
#define cucul_file_open caca_file_open
#define cucul_file_close caca_file_close
#define cucul_file_tell caca_file_tell
#define cucul_file_read caca_file_read
#define cucul_file_write caca_file_write
#define cucul_file_gets caca_file_gets
#define cucul_file_eof caca_file_eof
#define cucul_create_dither caca_create_dither
#define cucul_set_dither_palette caca_set_dither_palette
#define cucul_set_dither_brightness caca_set_dither_brightness
#define cucul_get_dither_brightness caca_get_dither_brightness
#define cucul_set_dither_gamma caca_set_dither_gamma
#define cucul_get_dither_gamma caca_get_dither_gamma
#define cucul_set_dither_contrast caca_set_dither_contrast
#define cucul_get_dither_contrast caca_get_dither_contrast
#define cucul_set_dither_antialias caca_set_dither_antialias
#define cucul_get_dither_antialias_list caca_get_dither_antialias_list
#define cucul_get_dither_antialias caca_get_dither_antialias
#define cucul_set_dither_color caca_set_dither_color
#define cucul_get_dither_color_list caca_get_dither_color_list
#define cucul_get_dither_color caca_get_dither_color
#define cucul_set_dither_charset caca_set_dither_charset
#define cucul_get_dither_charset_list caca_get_dither_charset_list
#define cucul_get_dither_charset caca_get_dither_charset
#define cucul_set_dither_algorithm caca_set_dither_algorithm
#define cucul_get_dither_algorithm_list caca_get_dither_algorithm_list
#define cucul_get_dither_algorithm caca_get_dither_algorithm
#define cucul_dither_bitmap caca_dither_bitmap
#define cucul_free_dither caca_free_dither
#define cucul_draw_line caca_draw_line
#define cucul_draw_polyline caca_draw_polyline
#define cucul_draw_thin_line caca_draw_thin_line
#define cucul_draw_thin_polyline caca_draw_thin_polyline
#define cucul_draw_box caca_draw_box
#define cucul_draw_thin_box caca_draw_thin_box
#define cucul_draw_cp437_box caca_draw_cp437_box
#define cucul_fill_box caca_fill_box
#define cucul_get_frame_count caca_get_frame_count
#define cucul_set_frame caca_set_frame
#define cucul_get_frame_name caca_get_frame_name
#define cucul_set_frame_name caca_set_frame_name
#define cucul_create_frame caca_create_frame
#define cucul_free_frame caca_free_frame

end extern

#endif /' __CACA_BI__ '/
