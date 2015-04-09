'' FreeBASIC binding for libX11-1.6.3

#pragma once

extern "C"

#define _X11_IMUTIL_H_
declare function _XGetScanlinePad(byval dpy as Display ptr, byval depth as long) as long
declare function _XGetBitsPerPixel(byval dpy as Display ptr, byval depth as long) as long
declare function _XSetImage(byval srcimg as XImage ptr, byval dstimg as XImage ptr, byval x as long, byval y as long) as long
declare function _XReverse_Bytes(byval bpt as ubyte ptr, byval nb as long) as long
declare sub _XInitImageFuncPtrs(byval image as XImage ptr)

end extern
