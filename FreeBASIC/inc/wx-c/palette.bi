''
''
'' palette -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_palette_bi__
#define __wxc_palette_bi__

#include once "wx.bi"

declare function wxPalette alias "wxPalette_ctor" () as wxPalette ptr
declare sub wxPalette_dtor (byval self as wxPalette ptr)
declare function wxPalette_Ok (byval self as wxPalette ptr) as integer
declare function wxPalette_Create (byval self as wxPalette ptr, byval n as integer, byval red as ubyte ptr, byval green as ubyte ptr, byval blue as ubyte ptr) as integer
declare function wxPalette_GetPixel (byval self as wxPalette ptr, byval red as ubyte, byval green as ubyte, byval blue as ubyte) as integer
declare function wxPalette_GetRGB (byval self as wxPalette ptr, byval pixel as integer, byval red as ubyte ptr, byval green as ubyte ptr, byval blue as ubyte ptr) as integer

#endif
