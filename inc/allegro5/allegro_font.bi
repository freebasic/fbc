'' FreeBASIC binding for allegro-5.0.11
''
'' based on the C header files:
''   Copyright (c) 2004-2011 the Allegro 5 Development Team
''
''   This software is provided 'as-is', without any express or implied
''   warranty. In no event will the authors be held liable for any damages
''   arising from the use of this software.
''
''   Permission is granted to anyone to use this software for any purpose,
''   including commercial applications, and to alter it and redistribute it
''   freely, subject to the following restrictions:
''
''       1. The origin of this software must not be misrepresented; you must not
''       claim that you wrote the original software. If you use this software
''       in a product, an acknowledgment in the product documentation would be
''       appreciated but is not required.
''
''       2. Altered source versions must be plainly marked as such, and must not be
''       misrepresented as being the original software.
''
''       3. This notice may not be removed or altered from any source
''       distribution.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#ifdef __FB_UNIX__
	#inclib "allegro_font"
#elseif defined(__FB_WIN32__) and defined(ALLEGRO_STATICLINK)
	#inclib "allegro_font-5.0.10-static-md"
#else
	#inclib "allegro_font-5.0.10-md"
#endif

#include once "allegro5/allegro.bi"

extern "C"

#define __al_included_allegro5_allegro_font_h
type ALLEGRO_FONT_VTABLE as ALLEGRO_FONT_VTABLE_

type ALLEGRO_FONT
	data as any ptr
	height as long
	vtable as ALLEGRO_FONT_VTABLE ptr
end type

type ALLEGRO_FONT_VTABLE_
	font_height as function(byval f as const ALLEGRO_FONT ptr) as long
	font_ascent as function(byval f as const ALLEGRO_FONT ptr) as long
	font_descent as function(byval f as const ALLEGRO_FONT ptr) as long
	char_length as function(byval f as const ALLEGRO_FONT ptr, byval ch as long) as long
	text_length as function(byval f as const ALLEGRO_FONT ptr, byval text as const ALLEGRO_USTR ptr) as long
	render_char as function(byval f as const ALLEGRO_FONT ptr, byval color as ALLEGRO_COLOR, byval ch as long, byval x as single, byval y as single) as long
	render as function(byval f as const ALLEGRO_FONT ptr, byval color as ALLEGRO_COLOR, byval text as const ALLEGRO_USTR ptr, byval x as single, byval y as single) as long
	destroy as sub(byval f as ALLEGRO_FONT ptr)
	get_text_dimensions as sub(byval f as const ALLEGRO_FONT ptr, byval text as const ALLEGRO_USTR ptr, byval bbx as long ptr, byval bby as long ptr, byval bbw as long ptr, byval bbh as long ptr)
end type

enum
	ALLEGRO_ALIGN_LEFT = 0
	ALLEGRO_ALIGN_CENTRE = 1
	ALLEGRO_ALIGN_CENTER = 1
	ALLEGRO_ALIGN_RIGHT = 2
	ALLEGRO_ALIGN_INTEGER = 4
end enum

declare function al_register_font_loader(byval ext as const zstring ptr, byval load as function(byval filename as const zstring ptr, byval size as long, byval flags as long) as ALLEGRO_FONT ptr) as byte
declare function al_load_bitmap_font(byval filename as const zstring ptr) as ALLEGRO_FONT ptr
declare function al_load_font(byval filename as const zstring ptr, byval size as long, byval flags as long) as ALLEGRO_FONT ptr
declare function al_grab_font_from_bitmap(byval bmp as ALLEGRO_BITMAP ptr, byval n as long, byval ranges as const long ptr) as ALLEGRO_FONT ptr
declare function al_create_builtin_font() as ALLEGRO_FONT ptr
declare sub al_draw_ustr(byval font as const ALLEGRO_FONT ptr, byval color as ALLEGRO_COLOR, byval x as single, byval y as single, byval flags as long, byval ustr as const ALLEGRO_USTR ptr)
declare sub al_draw_text(byval font as const ALLEGRO_FONT ptr, byval color as ALLEGRO_COLOR, byval x as single, byval y as single, byval flags as long, byval text as const zstring ptr)
declare sub al_draw_justified_text(byval font as const ALLEGRO_FONT ptr, byval color as ALLEGRO_COLOR, byval x1 as single, byval x2 as single, byval y as single, byval diff as single, byval flags as long, byval text as const zstring ptr)
declare sub al_draw_justified_ustr(byval font as const ALLEGRO_FONT ptr, byval color as ALLEGRO_COLOR, byval x1 as single, byval x2 as single, byval y as single, byval diff as single, byval flags as long, byval text as const ALLEGRO_USTR ptr)
declare sub al_draw_textf(byval font as const ALLEGRO_FONT ptr, byval color as ALLEGRO_COLOR, byval x as single, byval y as single, byval flags as long, byval format as const zstring ptr, ...)
declare sub al_draw_justified_textf(byval font as const ALLEGRO_FONT ptr, byval color as ALLEGRO_COLOR, byval x1 as single, byval x2 as single, byval y as single, byval diff as single, byval flags as long, byval format as const zstring ptr, ...)
declare function al_get_text_width(byval f as const ALLEGRO_FONT ptr, byval str as const zstring ptr) as long
declare function al_get_ustr_width(byval f as const ALLEGRO_FONT ptr, byval ustr as const ALLEGRO_USTR ptr) as long
declare function al_get_font_line_height(byval f as const ALLEGRO_FONT ptr) as long
declare function al_get_font_ascent(byval f as const ALLEGRO_FONT ptr) as long
declare function al_get_font_descent(byval f as const ALLEGRO_FONT ptr) as long
declare sub al_destroy_font(byval f as ALLEGRO_FONT ptr)
declare sub al_get_ustr_dimensions(byval f as const ALLEGRO_FONT ptr, byval text as const ALLEGRO_USTR ptr, byval bbx as long ptr, byval bby as long ptr, byval bbw as long ptr, byval bbh as long ptr)
declare sub al_get_text_dimensions(byval f as const ALLEGRO_FONT ptr, byval text as const zstring ptr, byval bbx as long ptr, byval bby as long ptr, byval bbw as long ptr, byval bbh as long ptr)
declare sub al_init_font_addon()
declare sub al_shutdown_font_addon()
declare function al_get_allegro_font_version() as ulong

end extern
