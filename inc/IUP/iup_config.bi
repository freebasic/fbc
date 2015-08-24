'' FreeBASIC binding for iup-3.15
''
'' based on the C header files:
''   Copyright (C) 1994-2015 Tecgraf, PUC-Rio.
''
''   Permission is hereby granted, free of charge, to any person obtaining
''   a copy of this software and associated documentation files (the
''   "Software"), to deal in the Software without restriction, including
''   without limitation the rights to use, copy, modify, merge, publish,
''   distribute, sublicense, and/or sell copies of the Software, and to
''   permit persons to whom the Software is furnished to do so, subject to
''   the following conditions:
''
''   The above copyright notice and this permission notice shall be
''   included in all copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
''   EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
''   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
''   IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
''   CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
''   TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
''   SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

extern "C"

#define IUP_CONFIG_H
declare function IupConfig() as Ihandle ptr
declare function IupConfigLoad(byval ih as Ihandle ptr) as long
declare function IupConfigSave(byval ih as Ihandle ptr) as long
declare sub IupConfigSetVariableStr(byval ih as Ihandle ptr, byval group as const zstring ptr, byval key as const zstring ptr, byval value as const zstring ptr)
declare sub IupConfigSetVariableStrId(byval ih as Ihandle ptr, byval group as const zstring ptr, byval key as const zstring ptr, byval id as long, byval value as const zstring ptr)
declare sub IupConfigSetVariableInt(byval ih as Ihandle ptr, byval group as const zstring ptr, byval key as const zstring ptr, byval value as long)
declare sub IupConfigSetVariableIntId(byval ih as Ihandle ptr, byval group as const zstring ptr, byval key as const zstring ptr, byval id as long, byval value as long)
declare sub IupConfigSetVariableDouble(byval ih as Ihandle ptr, byval group as const zstring ptr, byval key as const zstring ptr, byval value as double)
declare sub IupConfigSetVariableDoubleId(byval ih as Ihandle ptr, byval group as const zstring ptr, byval key as const zstring ptr, byval id as long, byval value as double)
declare function IupConfigGetVariableStr(byval ih as Ihandle ptr, byval group as const zstring ptr, byval key as const zstring ptr) as const zstring ptr
declare function IupConfigGetVariableStrId(byval ih as Ihandle ptr, byval group as const zstring ptr, byval key as const zstring ptr, byval id as long) as const zstring ptr
declare function IupConfigGetVariableInt(byval ih as Ihandle ptr, byval group as const zstring ptr, byval key as const zstring ptr) as long
declare function IupConfigGetVariableIntId(byval ih as Ihandle ptr, byval group as const zstring ptr, byval key as const zstring ptr, byval id as long) as long
declare function IupConfigGetVariableDouble(byval ih as Ihandle ptr, byval group as const zstring ptr, byval key as const zstring ptr) as double
declare function IupConfigGetVariableDoubleId(byval ih as Ihandle ptr, byval group as const zstring ptr, byval key as const zstring ptr, byval id as long) as double
declare function IupConfigGetVariableStrDef(byval ih as Ihandle ptr, byval group as const zstring ptr, byval key as const zstring ptr, byval def as const zstring ptr) as const zstring ptr
declare function IupConfigGetVariableStrIdDef(byval ih as Ihandle ptr, byval group as const zstring ptr, byval key as const zstring ptr, byval id as long, byval def as const zstring ptr) as const zstring ptr
declare function IupConfigGetVariableIntDef(byval ih as Ihandle ptr, byval group as const zstring ptr, byval key as const zstring ptr, byval def as long) as long
declare function IupConfigGetVariableIntIdDef(byval ih as Ihandle ptr, byval group as const zstring ptr, byval key as const zstring ptr, byval id as long, byval def as long) as long
declare function IupConfigGetVariableDoubleDef(byval ih as Ihandle ptr, byval group as const zstring ptr, byval key as const zstring ptr, byval def as double) as double
declare function IupConfigGetVariableDoubleIdDef(byval ih as Ihandle ptr, byval group as const zstring ptr, byval key as const zstring ptr, byval id as long, byval def as double) as double
declare sub IupConfigRecentInit(byval ih as Ihandle ptr, byval menu as Ihandle ptr, byval recent_cb as Icallback, byval max_recent as long)
declare sub IupConfigRecentUpdate(byval ih as Ihandle ptr, byval filename as const zstring ptr)
declare sub IupConfigDialogShow(byval ih as Ihandle ptr, byval dialog as Ihandle ptr, byval name as const zstring ptr)
declare sub IupConfigDialogClosed(byval ih as Ihandle ptr, byval dialog as Ihandle ptr, byval name as const zstring ptr)

end extern
