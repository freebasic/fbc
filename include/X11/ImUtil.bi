''
''
'' ImUtil -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __ImUtil_bi__
#define __ImUtil_bi__

declare function _XGetScanlinePad cdecl alias "_XGetScanlinePad" (byval dpy as Display ptr, byval depth as integer) as integer
declare function _XGetBitsPerPixel cdecl alias "_XGetBitsPerPixel" (byval dpy as Display ptr, byval depth as integer) as integer
declare function _XSetImage cdecl alias "_XSetImage" (byval srcimg as XImage ptr, byval dstimg as XImage ptr, byval x as integer, byval y as integer) as integer
declare function _XReverse_Bytes cdecl alias "_XReverse_Bytes" (byval bpt as ubyte ptr, byval nb as integer) as integer
declare sub _XInitImageFuncPtrs cdecl alias "_XInitImageFuncPtrs" (byval image as XImage ptr)

#endif
