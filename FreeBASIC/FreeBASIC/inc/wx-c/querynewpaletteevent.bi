''
''
'' querynewpaletteevent -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_querynewpaletteevent_bi__
#define __wxc_querynewpaletteevent_bi__

#include once "wx.bi"

declare function wxQueryNewPaletteEvent alias "wxQueryNewPaletteEvent_ctor" (byval type as wxEventType) as wxQueryNewPaletteEvent ptr
declare function wxQueryNewPaletteEvent_GetPaletteRealized (byval self as wxQueryNewPaletteEvent ptr) as integer
declare sub wxQueryNewPaletteEvent_SetPaletteRelized (byval self as wxQueryNewPaletteEvent ptr, byval realized as integer)

#endif
