#pragma once

#include once "crt/long.bi"
#include once "X11/Xfuncproto.bi"

extern "C"

#define _XMU_STDCMAP_H_
declare function XmuAllStandardColormaps(byval dpy as Display ptr) as long
declare function XmuCreateColormap(byval dpy as Display ptr, byval colormap as XStandardColormap ptr) as long
declare sub XmuDeleteStandardColormap(byval dpy as Display ptr, byval screen as long, byval property as XAtom)
declare function XmuGetColormapAllocation(byval vinfo as XVisualInfo ptr, byval property as XAtom, byval red_max_return as culong ptr, byval green_max_return as culong ptr, byval blue_max_return as culong ptr) as long
declare function XmuLookupStandardColormap(byval dpy as Display ptr, byval screen as long, byval visualid as VisualID, byval depth as ulong, byval property as XAtom, byval replace as long, byval retain as long) as long
declare function XmuStandardColormap(byval dpy as Display ptr, byval screen as long, byval visualid as VisualID, byval depth as ulong, byval property as XAtom, byval cmap as Colormap, byval red_max as culong, byval green_max as culong, byval blue_max as culong) as XStandardColormap ptr
declare function XmuVisualStandardColormaps(byval dpy as Display ptr, byval screen as long, byval visualid as VisualID, byval depth as ulong, byval replace as long, byval retain as long) as long
declare function XmuDistinguishableColors(byval colors as XColor ptr, byval count as long) as long
declare function XmuDistinguishablePixels(byval dpy as Display ptr, byval cmap as Colormap, byval pixels as culong ptr, byval count as long) as long

end extern
