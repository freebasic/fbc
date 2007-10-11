''
''
'' staticbitmap -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_staticbitmap_bi__
#define __wxc_staticbitmap_bi__

#include once "wx.bi"


declare function wxStaticBitmap alias "wxStaticBitmap_ctor" () as wxStaticBitmap ptr
declare function wxStaticBitmap_Create (byval self as wxStaticBitmap ptr, byval parent as wxWindow ptr, byval id as wxWindowID, byval bitmap as wxBitmap ptr, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval name as zstring ptr) as integer
declare sub wxStaticBitmap_dtor (byval self as wxStaticBitmap ptr)
declare sub wxStaticBitmap_SetIcon (byval self as wxStaticBitmap ptr, byval icon as wxIcon ptr)
declare sub wxStaticBitmap_SetBitmap (byval self as wxStaticBitmap ptr, byval bitmap as wxBitmap ptr)
declare function wxStaticBitmap_GetBitmap (byval self as wxStaticBitmap ptr) as wxBitmap ptr

#endif
