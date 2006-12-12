''
''
'' palettechangedevent -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_palettechangedevent_bi__
#define __wxc_palettechangedevent_bi__

#include once "wx.bi"

declare function wxPaletteChangedEvent alias "wxPaletteChangedEvent_ctor" (byval type as wxEventType) as wxPaletteChangedEvent ptr
declare sub wxPaletteChangedEvent_SetChangedWindow (byval self as wxPaletteChangedEvent ptr, byval win as wxWindow ptr)
declare function wxPaletteChangedEvent_GetChangedWindow (byval self as wxPaletteChangedEvent ptr) as wxWindow ptr

#endif
