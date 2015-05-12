''
''
'' XEVI -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __XEVI_bi__
#define __XEVI_bi__

#define X_EVIQueryVersion 0
#define X_EVIGetVisualInfo 1
#define XEVI_TRANSPARENCY_NONE 0
#define XEVI_TRANSPARENCY_PIXEL 1
#define XEVI_TRANSPARENCY_MASK 2

type ExtendedVisualInfo
	core_visual_id as VisualID
	screen as integer
	level as integer
	transparency_type as uinteger
	transparency_value as uinteger
	min_hw_colormaps as uinteger
	max_hw_colormaps as uinteger
	num_colormap_conflicts as uinteger
	colormap_conflicts as VisualID ptr
end type

declare function XeviGetVisualInfo cdecl alias "XeviGetVisualInfo" (byval as Display ptr, byval as VisualID ptr, byval as integer, byval as ExtendedVisualInfo ptr ptr, byval as integer ptr) as Status

#endif
