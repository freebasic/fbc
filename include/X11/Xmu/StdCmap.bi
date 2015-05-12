''
''
'' StdCmap -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __StdCmap_bi__
#define __StdCmap_bi__

declare sub XmuDeleteStandardColormap cdecl alias "XmuDeleteStandardColormap" (byval dpy as Display ptr, byval screen as integer, byval property as Atom)
declare function XmuGetColormapAllocation cdecl alias "XmuGetColormapAllocation" (byval vinfo as XVisualInfo ptr, byval property as Atom, byval red_max_return as uinteger ptr, byval green_max_return as uinteger ptr, byval blue_max_return as uinteger ptr) as Status
declare function XmuLookupStandardColormap cdecl alias "XmuLookupStandardColormap" (byval dpy as Display ptr, byval screen as integer, byval visualid as VisualID, byval depth as uinteger, byval property as Atom, byval replace as Bool, byval retain as Bool) as Status
declare function XmuStandardColormap cdecl alias "XmuStandardColormap" (byval dpy as Display ptr, byval screen as integer, byval visualid as VisualID, byval depth as uinteger, byval property as Atom, byval cmap as Colormap, byval red_max as uinteger, byval green_max as uinteger, byval blue_max as uinteger) as XStandardColormap ptr
declare function XmuVisualStandardColormaps cdecl alias "XmuVisualStandardColormaps" (byval dpy as Display ptr, byval screen as integer, byval visualid as VisualID, byval depth as uinteger, byval replace as Bool, byval retain as Bool) as Status
declare function XmuDistinguishableColors cdecl alias "XmuDistinguishableColors" (byval colors as XColor ptr, byval count as integer) as Bool
declare function XmuDistinguishablePixels cdecl alias "XmuDistinguishablePixels" (byval dpy as Display ptr, byval cmap as Colormap, byval pixels as uinteger ptr, byval count as integer) as Bool

#endif
