''
''
'' palettechangedevent -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __palettechangedevent_bi__
#define __palettechangedevent_bi__

#include once "wx-c/wx.bi"

declare function wxPaletteChangedEvent cdecl alias "wxPaletteChangedEvent_ctor" (byval type as wxEventType) as wxPaletteChangedEvent ptr
declare sub wxPaletteChangedEvent_SetChangedWindow cdecl alias "wxPaletteChangedEvent_SetChangedWindow" (byval self as wxPaletteChangedEvent ptr, byval win as wxWindow ptr)
declare function wxPaletteChangedEvent_GetChangedWindow cdecl alias "wxPaletteChangedEvent_GetChangedWindow" (byval self as wxPaletteChangedEvent ptr) as wxWindow ptr

#endif
