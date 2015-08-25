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

#include once "crt/long.bi"
#define __CACA0_H__
#include once "caca.bi"

'' The following symbols have been renamed:
''     typedef caca_dithering => caca_dithering_

extern "C"

declare function __caca0_init() as long
declare sub __caca0_end()
declare function __caca0_get_event(byval as ulong, byval as long) as ulong
declare function __caca0_sqrt(byval as ulong) as ulong
declare function __caca0_get_feature(byval as long) as long
declare sub __caca0_set_feature(byval as long)
declare function __caca0_get_feature_name(byval as long) as const zstring ptr
declare function __caca0_load_sprite(byval as const zstring ptr) as caca_canvas_t ptr
declare function __caca0_create_bitmap(byval as ulong, byval as ulong, byval as ulong, byval as ulong, byval as culong, byval as culong, byval as culong, byval as culong) as caca_dither_t ptr
declare sub __caca0_free_bitmap(byval as caca_dither_t ptr)
declare function __caca0_get_color_name(byval as ubyte) as const zstring ptr

#ifdef __FB_WIN32__
	extern import __caca0_cv as caca_canvas_t ptr
	extern import __caca0_dp as caca_display_t ptr
	extern import __caca0_fg as ubyte
	extern import __caca0_bg as ubyte
#else
	extern __caca0_cv as caca_canvas_t ptr
	extern __caca0_dp as caca_display_t ptr
	extern __caca0_fg as ubyte
	extern __caca0_bg as ubyte
#endif

const CACA_COLOR_BLACK = CACA_BLACK
const CACA_COLOR_BLUE = CACA_BLUE
const CACA_COLOR_GREEN = CACA_GREEN
const CACA_COLOR_CYAN = CACA_CYAN
const CACA_COLOR_RED = CACA_RED
const CACA_COLOR_MAGENTA = CACA_MAGENTA
const CACA_COLOR_BROWN = CACA_BROWN
const CACA_COLOR_LIGHTGRAY = CACA_LIGHTGRAY
const CACA_COLOR_DARKGRAY = CACA_DARKGRAY
const CACA_COLOR_LIGHTBLUE = CACA_LIGHTBLUE
const CACA_COLOR_LIGHTGREEN = CACA_LIGHTGREEN
const CACA_COLOR_LIGHTCYAN = CACA_LIGHTCYAN
const CACA_COLOR_LIGHTRED = CACA_LIGHTRED
const CACA_COLOR_LIGHTMAGENTA = CACA_LIGHTMAGENTA
const CACA_COLOR_YELLOW = CACA_YELLOW
const CACA_COLOR_WHITE = CACA_WHITE

type caca_feature as long
enum
	CACA_BACKGROUND = &h10
	CACA_BACKGROUND_BLACK = &h11
	CACA_BACKGROUND_SOLID = &h12
	CACA_ANTIALIASING = &h20
	CACA_ANTIALIASING_NONE = &h21
	CACA_ANTIALIASING_PREFILTER = &h22
	CACA_DITHERING = &h30
	CACA_DITHERING_NONE = &h31
	CACA_DITHERING_ORDERED2 = &h32
	CACA_DITHERING_ORDERED4 = &h33
	CACA_DITHERING_ORDERED8 = &h34
	CACA_DITHERING_RANDOM = &h35
	CACA_FEATURE_UNKNOWN = &hffff
end enum

const CACA_BACKGROUND_MIN = &h11
const CACA_BACKGROUND_MAX = &h12
const CACA_ANTIALIASING_MIN = &h21
const CACA_ANTIALIASING_MAX = &h22
const CACA_DITHERING_MIN = &h31
const CACA_DITHERING_MAX = &h35
#undef CACA_EVENT_NONE
const CACA_EVENT_NONE = &h00000000
#undef CACA_EVENT_KEY_PRESS
const CACA_EVENT_KEY_PRESS = &h01000000
#undef CACA_EVENT_KEY_RELEASE
const CACA_EVENT_KEY_RELEASE = &h02000000
#undef CACA_EVENT_MOUSE_PRESS
const CACA_EVENT_MOUSE_PRESS = &h04000000
#undef CACA_EVENT_MOUSE_RELEASE
const CACA_EVENT_MOUSE_RELEASE = &h08000000
#undef CACA_EVENT_MOUSE_MOTION
const CACA_EVENT_MOUSE_MOTION = &h10000000
#undef CACA_EVENT_RESIZE
const CACA_EVENT_RESIZE = &h20000000
#undef CACA_EVENT_ANY
const CACA_EVENT_ANY = &hff000000
type caca_dithering_ as caca_feature
const CACA_DITHER_NONE = CACA_DITHERING_NONE
const CACA_DITHER_ORDERED = CACA_DITHERING_ORDERED8
const CACA_DITHER_RANDOM = CACA_DITHERING_RANDOM
declare function caca_init alias "__caca0_init"() as long
#define caca_set_delay(x) caca_set_display_time(__caca0_dp, x)

declare function caca_get_feature alias "__caca0_get_feature"(byval as long) as long
declare sub caca_set_feature alias "__caca0_set_feature"(byval as long)
declare sub caca_set_dithering alias "__caca0_set_feature"(byval as long)
declare function caca_get_feature_name alias "__caca0_get_feature_name"(byval as long) as const zstring ptr
declare function caca_get_dithering_name alias "__caca0_get_feature_name"(byval as long) as const zstring ptr

#define caca_get_rendertime() caca_get_display_time(__caca0_dp)
#define caca_get_width() caca_get_canvas_width(__caca0_cv)
#define caca_get_height() caca_get_canvas_height(__caca0_cv)
#define caca_set_window_title(s) caca_set_display_title(__caca0_dp, s)
#define caca_get_window_width() caca_get_display_width(__caca0_dp)
#define caca_get_window_height() caca_get_display_height(__caca0_dp)
#define caca_refresh() caca_refresh_display(__caca0_dp)
declare sub caca_end alias "__caca0_end"()
#define caca_get_event(x) __caca0_get_event(x, 0)
#define caca_wait_event(x) __caca0_get_event(x, -1)
#define caca_get_mouse_x() caca1_get_mouse_x(__caca0_dp)
#define caca_get_mouse_y() caca1_get_mouse_y(__caca0_dp)
#macro caca_set_color(x, y)
	scope
		__caca0_fg = (x)
		__caca0_bg = (y)
		caca_set_color_ansi(__caca0_cv, x, y)
	end scope
#endmacro
#define caca_get_fg_color() __caca0_fg
#define caca_get_bg_color() __caca0_bg
declare function caca_get_color_name alias "__caca0_get_color_name"(byval as ubyte) as const zstring ptr
#define caca_putchar(x, y, c) caca_put_char(__caca0_cv, x, y, c)
#define caca_putstr(x, y, s) caca_put_str(__caca0_cv, x, y, s)
#define caca_printf(x, y, f...) caca1_printf(__caca0_cv, x, y, f)
#define caca_clear() caca_clear_canvas(__caca0_cv)
#define caca_draw_line(x, y, z, t, c) caca1_draw_line(__caca0_cv, x, y, z, t, c)
#define caca_draw_polyline(x, y, z, c) caca1_draw_polyline(__caca0_cv, x, y, z, c)
#define caca_draw_thin_line(x, y, z, t) caca1_draw_thin_line(__caca0_cv, x, y, z, t)
#define caca_draw_thin_polyline(x, y, z) caca1_draw_thin_polyline(__caca0_cv, x, y, z)
#define caca_draw_circle(x, y, z, c) caca1_draw_circle(__caca0_cv, x, y, z, c)
#define caca_draw_ellipse(x, y, z, t, c) caca1_draw_ellipse(__caca0_cv, x, y, z, t, c)
#define caca_draw_thin_ellipse(x, y, z, t) caca1_draw_thin_ellipse(__caca0_cv, x, y, z, t)
#define caca_fill_ellipse(x, y, z, t, c) caca1_fill_ellipse(__caca0_cv, x, y, z, t, c)
#define caca_draw_box(x, y, z, t, c) caca1_draw_box(__caca0_cv, x, y, z, t, c)
#define caca_draw_thin_box(x, y, z, t) caca1_draw_thin_box(__caca0_cv, x, y, z, t)
#define caca_fill_box(x, y, z, t, c) caca1_fill_box(__caca0_cv, x, y, z, t, c)
#define caca_draw_triangle(x, y, z, t, u, v, c) caca1_draw_triangle(__caca0_cv, x, y, z, t, u, v, c)
#define caca_draw_thin_triangle(x, y, z, t, u, v) caca1_draw_thin_triangle(__caca0_cv, x, y, z, t, u, v)
#define caca_fill_triangle(x, y, z, t, u, v, c) caca1_fill_triangle(__caca0_cv, x, y, z, t, u, v, c)
#define caca_rand(a, b) caca1_rand(a, (b) + 1)
declare function caca_sqrt alias "__caca0_sqrt"(byval as ulong) as ulong
#define caca_sprite caca_canvas_t
declare function caca_load_sprite alias "__caca0_load_sprite"(byval as const zstring ptr) as caca_canvas_t ptr
#define caca_get_sprite_frames(c) 1
#define caca_get_sprite_width(c, f) caca_get_canvas_width(c)
#define caca_get_sprite_height(c, f) caca_get_canvas_height(c)
#define caca_get_sprite_dx(c, f) 0
#define caca_draw_sprite(x, y, c, f) caca_blit(__caca0_cv, x, y, c, NULL)
declare function caca_free_sprite alias "caca_free_canvas"(byval as caca_canvas_t ptr) as long
#define caca_bitmap caca_dither_t
declare function caca_create_bitmap alias "__caca0_create_bitmap"(byval as ulong, byval as ulong, byval as ulong, byval as ulong, byval as culong, byval as culong, byval as culong, byval as culong) as caca_dither_t ptr
declare function caca_set_bitmap_palette alias "caca_set_dither_palette"(byval as caca_dither_t ptr, byval r as ulong ptr, byval g as ulong ptr, byval b as ulong ptr, byval a as ulong ptr) as long
#define caca_draw_bitmap(x, y, z, t, b, p) caca_dither_bitmap(__caca0_cv, x, y, z, t, b, p)
declare sub caca_free_bitmap alias "__caca0_free_bitmap"(byval as caca_dither_t ptr)

end extern
