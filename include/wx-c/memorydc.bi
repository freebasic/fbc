''
''
'' memorydc -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_memorydc_bi__
#define __wxc_memorydc_bi__

#include once "wx.bi"

declare function wxMemoryDC alias "wxMemoryDC_ctor" () as wxMemoryDC ptr
declare function wxMemoryDC_ctorByDC (byval dc as wxDC ptr) as wxMemoryDC ptr
declare sub wxMemoryDC_SelectObject (byval self as wxMemoryDC ptr, byval bitmap as wxBitmap ptr)
declare function wxBufferedDC alias "wxBufferedDC_ctor" () as wxBufferedDC ptr
declare function wxBufferedDC_ctorByBitmap (byval dc as wxDC ptr, byval buffer as wxBitmap ptr) as wxBufferedDC ptr
declare function wxBufferedDC_ctorBySize (byval dc as wxDC ptr, byval area as wxSize ptr) as wxBufferedDC ptr
declare sub wxBufferedDC_InitByBitmap (byval self as wxBufferedDC ptr, byval dc as wxDC ptr, byval bitmap as wxBitmap ptr)
declare sub wxBufferedDC_InitBySize (byval self as wxBufferedDC ptr, byval dc as wxDC ptr, byval area as wxSize ptr)
declare sub wxBufferedDC_UnMask (byval self as wxBufferedDC ptr)
declare function wxBufferedPaintDC alias "wxBufferedPaintDC_ctor" (byval window as wxWindow ptr, byval buffer as wxBitmap ptr) as wxBufferedPaintDC ptr

#endif
