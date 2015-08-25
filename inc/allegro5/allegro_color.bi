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
	#inclib "allegro_color"
#elseif defined(__FB_WIN32__) and defined(ALLEGRO_STATICLINK)
	#inclib "allegro_color-5.0.10-static-md"
#else
	#inclib "allegro_color-5.0.10-md"
#endif

#include once "allegro5/allegro.bi"

extern "C"

#define __al_included_allegro5_allegro_color_h
declare function al_get_allegro_color_version() as ulong
declare sub al_color_hsv_to_rgb(byval hue as single, byval saturation as single, byval value as single, byval red as single ptr, byval green as single ptr, byval blue as single ptr)
declare sub al_color_rgb_to_hsl(byval red as single, byval green as single, byval blue as single, byval hue as single ptr, byval saturation as single ptr, byval lightness as single ptr)
declare sub al_color_rgb_to_hsv(byval red as single, byval green as single, byval blue as single, byval hue as single ptr, byval saturation as single ptr, byval value as single ptr)
declare sub al_color_hsl_to_rgb(byval hue as single, byval saturation as single, byval lightness as single, byval red as single ptr, byval green as single ptr, byval blue as single ptr)
declare function al_color_name_to_rgb(byval name as const zstring ptr, byval r as single ptr, byval g as single ptr, byval b as single ptr) as byte
declare function al_color_rgb_to_name(byval r as single, byval g as single, byval b as single) as const zstring ptr
declare sub al_color_cmyk_to_rgb(byval cyan as single, byval magenta as single, byval yellow as single, byval key as single, byval red as single ptr, byval green as single ptr, byval blue as single ptr)
declare sub al_color_rgb_to_cmyk(byval red as single, byval green as single, byval blue as single, byval cyan as single ptr, byval magenta as single ptr, byval yellow as single ptr, byval key as single ptr)
declare sub al_color_yuv_to_rgb(byval y as single, byval u as single, byval v as single, byval red as single ptr, byval green as single ptr, byval blue as single ptr)
declare sub al_color_rgb_to_yuv(byval red as single, byval green as single, byval blue as single, byval y as single ptr, byval u as single ptr, byval v as single ptr)
declare sub al_color_rgb_to_html(byval red as single, byval green as single, byval blue as single, byval string as zstring ptr)
declare sub al_color_html_to_rgb(byval string as const zstring ptr, byval red as single ptr, byval green as single ptr, byval blue as single ptr)
declare function al_color_yuv(byval y as single, byval u as single, byval v as single) as ALLEGRO_COLOR
declare function al_color_cmyk(byval c as single, byval m as single, byval y as single, byval k as single) as ALLEGRO_COLOR
declare function al_color_hsl(byval h as single, byval s as single, byval l as single) as ALLEGRO_COLOR
declare function al_color_hsv(byval h as single, byval s as single, byval v as single) as ALLEGRO_COLOR
declare function al_color_name(byval name as const zstring ptr) as ALLEGRO_COLOR
declare function al_color_html(byval string as const zstring ptr) as ALLEGRO_COLOR

end extern
