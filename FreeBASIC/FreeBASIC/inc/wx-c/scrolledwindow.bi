''
''
'' scrolledwindow -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_scrolledwindow_bi__
#define __wxc_scrolledwindow_bi__

#include once "wx.bi"


declare function wxScrollWnd (byval parent as wxWindow ptr, byval id as wxWindowID, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval name as zstring ptr) as wxScrolledWindow ptr
declare sub wxScrollWnd_PrepareDC (byval self as wxScrolledWindow ptr, byval dc as wxDC ptr)
declare sub wxScrollWnd_SetScrollbars (byval self as wxScrolledWindow ptr, byval pixelsPerUnitX as integer, byval pixelsPerUnitY as integer, byval noUnitsX as integer, byval noUnitsY as integer, byval xPos as integer, byval yPos as integer, byval noRefresh as integer)
declare sub wxScrollWnd_GetViewStart (byval self as wxScrolledWindow ptr, byval x as integer ptr, byval y as integer ptr)
declare sub wxScrollWnd_GetScrollPixelsPerUnit (byval self as wxScrolledWindow ptr, byval xUnit as integer ptr, byval yUnit as integer ptr)
declare sub wxScrollWnd_CalcScrolledPosition (byval self as wxScrolledWindow ptr, byval x as integer, byval y as integer, byval xx as integer ptr, byval yy as integer ptr)
declare sub wxScrollWnd_CalcUnscrolledPosition (byval self as wxScrolledWindow ptr, byval x as integer, byval y as integer, byval xx as integer ptr, byval yy as integer ptr)
declare sub wxScrollWnd_GetVirtualSize (byval self as wxScrolledWindow ptr, byval x as integer ptr, byval y as integer ptr)
declare sub wxScrollWnd_Scroll (byval self as wxScrolledWindow ptr, byval x as integer, byval y as integer)
declare sub wxScrollWnd_SetScrollRate (byval self as wxScrolledWindow ptr, byval xstep as integer, byval ystep as integer)
declare sub wxScrollWnd_SetTargetWindow (byval self as wxScrolledWindow ptr, byval window as wxWindow ptr)

#endif
