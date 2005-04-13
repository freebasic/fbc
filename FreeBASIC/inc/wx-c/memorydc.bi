''
''
'' memorydc -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __memorydc_bi__
#define __memorydc_bi__

#include once "wx-c/wx.bi"

declare function wxMemoryDC cdecl alias "wxMemoryDC_ctor" () as wxMemoryDC ptr
declare function wxMemoryDC_ctorByDC cdecl alias "wxMemoryDC_ctorByDC" (byval dc as wxDC ptr) as wxMemoryDC ptr
declare sub wxMemoryDC_SelectObject cdecl alias "wxMemoryDC_SelectObject" (byval self as wxMemoryDC ptr, byval bitmap as wxBitmap ptr)
declare function wxBufferedDC cdecl alias "wxBufferedDC_ctor" () as wxBufferedDC ptr
declare function wxBufferedDC_ctorByBitmap cdecl alias "wxBufferedDC_ctorByBitmap" (byval dc as wxDC ptr, byval buffer as wxBitmap ptr) as wxBufferedDC ptr
declare function wxBufferedDC_ctorBySize cdecl alias "wxBufferedDC_ctorBySize" (byval dc as wxDC ptr, byval area as wxSize ptr) as wxBufferedDC ptr
declare sub wxBufferedDC_InitByBitmap cdecl alias "wxBufferedDC_InitByBitmap" (byval self as wxBufferedDC ptr, byval dc as wxDC ptr, byval bitmap as wxBitmap ptr)
declare sub wxBufferedDC_InitBySize cdecl alias "wxBufferedDC_InitBySize" (byval self as wxBufferedDC ptr, byval dc as wxDC ptr, byval area as wxSize ptr)
declare sub wxBufferedDC_UnMask cdecl alias "wxBufferedDC_UnMask" (byval self as wxBufferedDC ptr)
declare function wxBufferedPaintDC cdecl alias "wxBufferedPaintDC_ctor" (byval window as wxWindow ptr, byval buffer as wxBitmap ptr) as wxBufferedPaintDC ptr

#endif
