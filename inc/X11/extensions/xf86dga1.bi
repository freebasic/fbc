'' FreeBASIC binding for libXxf86dga-1.1.4

#pragma once

#include once "X11/Xfuncproto.bi"
#include once "X11/extensions/xf86dga1const.bi"

extern "C"

#define _XF86DGA1_H_
declare function XF86DGAQueryVersion(byval as Display ptr, byval as long ptr, byval as long ptr) as long
declare function XF86DGAQueryExtension(byval as Display ptr, byval as long ptr, byval as long ptr) as long
declare function XF86DGAGetVideoLL(byval as Display ptr, byval as long, byval as ulong ptr, byval as long ptr, byval as long ptr, byval as long ptr) as long
declare function XF86DGAGetVideo(byval as Display ptr, byval as long, byval as zstring ptr ptr, byval as long ptr, byval as long ptr, byval as long ptr) as long
declare function XF86DGADirectVideo(byval as Display ptr, byval as long, byval as long) as long
declare function XF86DGADirectVideoLL(byval as Display ptr, byval as long, byval as long) as long
declare function XF86DGAGetViewPortSize(byval as Display ptr, byval as long, byval as long ptr, byval as long ptr) as long
declare function XF86DGASetViewPort(byval as Display ptr, byval as long, byval x as long, byval y as long) as long
declare function XF86DGAGetVidPage(byval as Display ptr, byval as long, byval as long ptr) as long
declare function XF86DGASetVidPage(byval as Display ptr, byval as long, byval as long) as long
declare function XF86DGAInstallColormap(byval as Display ptr, byval as long, byval as Colormap) as long
declare function XF86DGAForkApp(byval screen as long) as long
declare function XF86DGAQueryDirectVideo(byval as Display ptr, byval as long, byval as long ptr) as long
declare function XF86DGAViewPortChanged(byval as Display ptr, byval as long, byval as long) as long

end extern
