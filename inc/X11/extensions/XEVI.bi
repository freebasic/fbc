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
