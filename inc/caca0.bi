/'
 *  libcaca       Colour ASCII-Art library
 *  Copyright (c) 2002-2010 Sam Hocevar <sam@hocevar.net>
 *                All Rights Reserved
 *
 *  This library is free software. It comes without any warranty, to
 *  the extent permitted by applicable law. You can redistribute it
 *  and/or modify it under the terms of the Do What The Fuck You Want
 *  To Public License, Version 2, as published by Sam Hocevar. See
 *  http://sam.zoy.org/wtfpl/COPYING for more details.
 '/

/'
 *  This header contains glue code for applications using the pre-1.0
 *  libcaca API.
 '/

'' Note: the __CACA0_BI__ define is used by caca.bi to leave out some
'' declarations, in order to avoid duplicate definitions here
#ifndef __CACA0_BI__
#define __CACA0_BI__

#include once "caca.bi"

extern "C"

declare function __caca0_init() as integer
declare sub __caca0_end()
declare function __caca0_get_event(byval as uinteger, byval as integer) as uinteger
declare function __caca0_sqrt(byval as uinteger) as uinteger
declare function __caca0_get_feature(byval as integer) as integer
declare sub __caca0_set_feature(byval as integer)
declare function __caca0_get_feature_name(byval as integer) as const zstring ptr
declare function __caca0_load_sprite(byval as const zstring ptr) as caca_canvas_t ptr
declare function __caca0_create_bitmap(byval as uinteger, byval as uinteger, byval as uinteger, byval as uinteger, byval as ulong, byval as ulong, byval as ulong, byval as ulong) as caca_dither_t ptr
declare sub __caca0_free_bitmap(byval as caca_dither_t ptr)
declare function __caca0_get_color_name(byval as ubyte) as const zstring ptr

extern __caca0_cv as caca_canvas_t ptr
extern __caca0_dp as caca_display_t ptr
extern __caca0_fg as ubyte
extern __caca0_bg as ubyte

#define CACA_COLOR_BLACK        CACA_BLACK
#define CACA_COLOR_BLUE         CACA_BLUE
#define CACA_COLOR_GREEN        CACA_GREEN
#define CACA_COLOR_CYAN         CACA_CYAN
#define CACA_COLOR_RED          CACA_RED
#define CACA_COLOR_MAGENTA      CACA_MAGENTA
#define CACA_COLOR_BROWN        CACA_BROWN
#define CACA_COLOR_LIGHTGRAY    CACA_LIGHTGRAY
#define CACA_COLOR_DARKGRAY     CACA_DARKGRAY
#define CACA_COLOR_LIGHTBLUE    CACA_LIGHTBLUE
#define CACA_COLOR_LIGHTGREEN   CACA_LIGHTGREEN
#define CACA_COLOR_LIGHTCYAN    CACA_LIGHTCYAN
#define CACA_COLOR_LIGHTRED     CACA_LIGHTRED
#define CACA_COLOR_LIGHTMAGENTA CACA_LIGHTMAGENTA
#define CACA_COLOR_YELLOW       CACA_YELLOW
#define CACA_COLOR_WHITE        CACA_WHITE

enum caca_feature
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

#define CACA_BACKGROUND_MIN &h11
#define CACA_BACKGROUND_MAX &h12
#define CACA_ANTIALIASING_MIN &h21
#define CACA_ANTIALIASING_MAX &h22
#define CACA_DITHERING_MIN &h31
#define CACA_DITHERING_MAX &h35

#define CACA_EVENT_NONE          &h00000000
#define CACA_EVENT_KEY_PRESS     &h01000000
#define CACA_EVENT_KEY_RELEASE   &h02000000
#define CACA_EVENT_MOUSE_PRESS   &h04000000
#define CACA_EVENT_MOUSE_RELEASE &h08000000
#define CACA_EVENT_MOUSE_MOTION  &h10000000
#define CACA_EVENT_RESIZE        &h20000000
#define CACA_EVENT_ANY           &hff000000

''#define caca_dithering caca_feature
#define caca_set_dithering caca_set_feature
#define caca_get_dithering_name caca_get_feature_name
#define CACA_DITHER_NONE    CACA_DITHERING_NONE
#define CACA_DITHER_ORDERED CACA_DITHERING_ORDERED8
#define CACA_DITHER_RANDOM  CACA_DITHERING_RANDOM

#define caca_init __caca0_init
#define caca_set_delay(x) caca_set_display_time(__caca0_dp, x)
#define caca_get_feature __caca0_get_feature
#define caca_set_feature __caca0_set_feature
#define caca_get_feature_name __caca0_get_feature_name
#define caca_get_rendertime() caca_get_display_time(__caca0_dp)
#define caca_get_width() caca_get_canvas_width(__caca0_cv)
#define caca_get_height() caca_get_canvas_height(__caca0_cv)
#define caca_set_window_title(s) caca_set_display_title(__caca0_dp, s)
#define caca_get_window_width() caca_get_display_width(__caca0_dp)
#define caca_get_window_height() caca_get_display_height(__caca0_dp)
#define caca_refresh() caca_refresh_display(__caca0_dp)
#define caca_end __caca0_end

#define caca_get_event(x) __caca0_get_event(x, 0)
#define caca_wait_event(x) __caca0_get_event(x, -1)
#define caca_get_mouse_x() caca1_get_mouse_x(__caca0_dp)
#define caca_get_mouse_y() caca1_get_mouse_y(__caca0_dp)

#define caca_set_color(x, y) _
    (__caca0_fg = (x), __caca0_bg = (y), caca_set_color_ansi(__caca0_cv, x, y))
#define caca_get_fg_color() __caca0_fg
#define caca_get_bg_color() __caca0_bg
#define caca_get_color_name __caca0_get_color_name
#define caca_putchar(x, y, c) caca_put_char(__caca0_cv, x, y, c)
#define caca_putstr(x, y, s) caca_put_str(__caca0_cv, x, y, s)
#define caca_printf(x, y, f, z...) caca1_printf(__caca0_cv, x, y, f, ##z)
#define caca_clear() caca_clear_canvas(__caca0_cv)

#define caca_draw_line(x, y, z, t, c)             caca1_draw_line(__caca0_cv, x, y, z, t, c)
#define caca_draw_polyline(x, y, z, c)            caca1_draw_polyline(__caca0_cv, x, y, z, c)
#define caca_draw_thin_line(x, y, z, t)           caca1_draw_thin_line(__caca0_cv, x, y, z, t)
#define caca_draw_thin_polyline(x, y, z)          caca1_draw_thin_polyline(__caca0_cv, x, y, z)
#define caca_draw_circle(x, y, z, c)              caca1_draw_circle(__caca0_cv, x, y, z, c)
#define caca_draw_ellipse(x, y, z, t, c)          caca1_draw_ellipse(__caca0_cv, x, y, z, t, c)
#define caca_draw_thin_ellipse(x, y, z, t)        caca1_draw_thin_ellipse(__caca0_cv, x, y, z, t)
#define caca_fill_ellipse(x, y, z, t, c)          caca1_fill_ellipse(__caca0_cv, x, y, z, t, c)
#define caca_draw_box(x, y, z, t, c)              caca1_draw_box(__caca0_cv, x, y, z, t, c)
#define caca_draw_thin_box(x, y, z, t)            caca1_draw_thin_box(__caca0_cv, x, y, z, t)
#define caca_fill_box(x, y, z, t, c)              caca1_fill_box(__caca0_cv, x, y, z, t, c)
#define caca_draw_triangle(x, y, z, t, u, v, c)   caca_draw_triangle(__caca0_cv, x, y, z, t, u, v, c)
#define caca_draw_thin_triangle(x, y, z, t, u, v) caca_draw_thin_triangle(__caca0_cv, x, y, z, t, u, v)
#define caca_fill_triangle(x, y, z, t, u, v, c)   caca_fill_triangle(__caca0_cv, x, y, z, t, u, v, c)

#define caca_rand(a, b) caca1_rand(a, (b)+1)
#define caca_sqrt __caca0_sqrt

#define caca_sprite caca_canvas
#define caca_load_sprite __caca0_load_sprite
#define caca_get_sprite_frames(c) 1
#define caca_get_sprite_width(c, f) caca_get_canvas_width(c)
#define caca_get_sprite_height(c, f) caca_get_canvas_height(c)
#define caca_get_sprite_dx(c, f) 0
#define caca_draw_sprite(x, y, c, f) caca_blit(__caca0_cv, x, y, c, NULL)
#define caca_free_sprite caca_free_canvas

#define caca_bitmap caca_dither_t
#define caca_create_bitmap __caca0_create_bitmap
#define caca_set_bitmap_palette caca_set_dither_palette
#define caca_draw_bitmap(x, y, z, t, b, p) _
    caca_dither_bitmap(__caca0_cv, x, y, z, t, b, p)
#define caca_free_bitmap __caca0_free_bitmap

end extern

#endif /' __CACA0_BI__ '/
