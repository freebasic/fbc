'' FreeBASIC binding for algif_1.3
''
'' based on the C header files:
''   Copyright (c) 2000-2004 algif contributors
''   Permission is hereby granted, free of charge, to any person obtaining a
''   copy of this software and associated documentation files (the "Software"),
''   to deal in the Software without restriction, including without limitation
''   the rights to use, copy, modify, merge, publish, distribute, sublicense,
''   and/or sell copies of the Software, and to permit persons to whom the
''   Software is furnished to do so, subject to the following conditions:
''   The above copyright notice and this permission notice shall be included in
''   all copies or substantial portions of the Software.
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
''   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
''   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
''   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
''   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
''   FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
''   DEALINGS IN THE SOFTWARE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "algif"

#include once "allegro.bi"

extern "C"

#define _GIF_H_
#define DAT_GIF DAT_ID(asc("G"), asc("I"), asc("F"), asc(" "))

type GIF_PALETTE
	colors_count as long
	colors(0 to 255) as RGB
end type

type GIF_FRAME as GIF_FRAME_

type GIF_ANIMATION
	width as long
	height as long
	frames_count as long
	background_index as long
	loop as long
	palette as GIF_PALETTE
	frames as GIF_FRAME ptr
	store as BITMAP ptr
end type

type GIF_FRAME_
	bitmap_8_bit as BITMAP ptr
	palette as GIF_PALETTE
	xoff as long
	yoff as long
	duration as long
	disposal_method as long
	transparent_index as long
end type

declare sub algif_init()
declare function algif_load_animation(byval filename as const zstring ptr, byval frames as BITMAP ptr ptr ptr, byval durations as long ptr ptr) as long
declare function load_gif(byval filename as const zstring ptr, byval pal as RGB ptr) as BITMAP ptr
declare function save_gif(byval filename as const zstring ptr, byval bmp as BITMAP ptr, byval pal as const RGB ptr) as long
declare function algif_load_raw_animation(byval filename as const zstring ptr) as GIF_ANIMATION ptr
declare sub algif_render_frame(byval gif as GIF_ANIMATION ptr, byval bitmap as BITMAP ptr, byval frame as long, byval xpos as long, byval ypos as long)
declare function algif_create_raw_animation(byval frames_count as long) as GIF_ANIMATION ptr
declare function algif_save_raw_animation(byval filename as const zstring ptr, byval gif as GIF_ANIMATION ptr) as long
declare sub algif_destroy_raw_animation(byval gif as GIF_ANIMATION ptr)

end extern
