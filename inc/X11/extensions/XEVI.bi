'' FreeBASIC binding for libXext-1.3.3
''
'' based on the C header files:
''   **********************************************************
''   Copyright (c) 1997 by Silicon Graphics Computer Systems, Inc.
''   Permission to use, copy, modify, and distribute this
''   software and its documentation for any purpose and without
''   fee is hereby granted, provided that the above copyright
''   notice appear in all copies and that both that copyright
''   notice and this permission notice appear in supporting
''   documentation, and that the name of Silicon Graphics not be
''   used in advertising or publicity pertaining to distribution
''   of the software without specific prior written permission.
''   Silicon Graphics makes no representation about the suitability
''   of this software for any purpose. It is provided "as is"
''   without any express or implied warranty.
''   SILICON GRAPHICS DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS
''   SOFTWARE, INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
''   AND FITNESS FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL SILICON
''   GRAPHICS BE LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL
''   DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE,
''   DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE
''   OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION  WITH
''   THE USE OR PERFORMANCE OF THIS SOFTWARE.
''   *******************************************************
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "X11/Xfuncproto.bi"
#include once "X11/extensions/EVI.bi"

extern "C"

#define _XEVI_H_

type ExtendedVisualInfo
	core_visual_id as VisualID
	screen as long
	level as long
	transparency_type as ulong
	transparency_value as ulong
	min_hw_colormaps as ulong
	max_hw_colormaps as ulong
	num_colormap_conflicts as ulong
	colormap_conflicts as VisualID ptr
end type

declare function XeviQueryExtension(byval as Display ptr) as long
declare function XeviQueryVersion(byval as Display ptr, byval as long ptr, byval as long ptr) as long
declare function XeviGetVisualInfo(byval as Display ptr, byval as VisualID ptr, byval as long, byval as ExtendedVisualInfo ptr ptr, byval as long ptr) as long

end extern
