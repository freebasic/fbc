''
''
'' splitterwindow -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_splitterwindow_bi__
#define __wxc_splitterwindow_bi__

#include once "wx.bi"


type Virtual_OnDoubleClickSash as sub WXCALL (byval as integer, byval as integer)
type Virtual_OnUnsplit as sub WXCALL (byval as wxWindow ptr)
type Virtual_OnSashPositionChange as function WXCALL (byval as integer) as integer

declare function wxSplitWnd (byval parent as wxWindow ptr, byval id as wxWindowID, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval name as wxChar ptr) as wxSplitterWindow ptr
declare sub wxSplitWnd_RegisterVirtual (byval self as _SplitterWindow ptr, byval onDoubleClickSash as Virtual_OnDoubleClickSash, byval onUnsplit as Virtual_OnUnsplit, byval onSashPositionChange as Virtual_OnSashPositionChange)
declare sub wxSplitWnd_OnDoubleClickSash (byval self as _SplitterWindow ptr, byval x as integer, byval y as integer)
declare sub wxSplitWnd_OnUnsplit (byval self as _SplitterWindow ptr, byval removed as wxWindow ptr)
declare function wxSplitWnd_OnSashPositionChange (byval self as _SplitterWindow ptr, byval newSashPosition as integer) as integer
declare function wxSplitWnd_GetSplitMode (byval self as _SplitterWindow ptr) as integer
declare function wxSplitWnd_IsSplit (byval self as _SplitterWindow ptr) as integer
declare function wxSplitWnd_SplitHorizontally (byval self as _SplitterWindow ptr, byval window1 as wxWindow ptr, byval window2 as wxWindow ptr, byval sashPosition as integer) as integer
declare function wxSplitWnd_SplitVertically (byval self as _SplitterWindow ptr, byval window1 as wxWindow ptr, byval window2 as wxWindow ptr, byval sashPosition as integer) as integer
declare function wxSplitWnd_Unsplit (byval self as _SplitterWindow ptr, byval toRemove as wxWindow ptr) as integer
declare sub wxSplitWnd_SetSashPosition (byval self as _SplitterWindow ptr, byval position as integer, byval redraw as integer)
declare function wxSplitWnd_GetSashPosition (byval self as _SplitterWindow ptr) as integer
declare function wxSplitWnd_GetMinimumPaneSize (byval self as _SplitterWindow ptr) as integer
declare function wxSplitWnd_GetWindow1 (byval self as _SplitterWindow ptr) as wxWindow ptr
declare function wxSplitWnd_GetWindow2 (byval self as _SplitterWindow ptr) as wxWindow ptr
declare sub wxSplitWnd_Initialize (byval self as _SplitterWindow ptr, byval window as wxWindow ptr)
declare function wxSplitWnd_ReplaceWindow (byval self as _SplitterWindow ptr, byval winOld as wxWindow ptr, byval winNew as wxWindow ptr) as integer
declare sub wxSplitWnd_SetMinimumPaneSize (byval self as _SplitterWindow ptr, byval paneSize as integer)
declare sub wxSplitWnd_SetSplitMode (byval self as _SplitterWindow ptr, byval mode as integer)
declare sub wxSplitWnd_UpdateSize (byval self as _SplitterWindow ptr)

#endif
