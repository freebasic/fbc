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

#inclib "iupcontrols"

extern "C"

#define __IUPCONTROLS_H
declare function IupControlsOpen() as long
declare sub IupControlsClose()
declare function IupColorbar() as Ihandle ptr
declare function IupCells() as Ihandle ptr
declare function IupColorBrowser() as Ihandle ptr
declare function IupGauge() as Ihandle ptr
declare function IupDial(byval type as const zstring ptr) as Ihandle ptr
declare function IupMatrix(byval action as const zstring ptr) as Ihandle ptr
declare function IupMatrixList() as Ihandle ptr
declare sub IupMatSetAttribute(byval ih as Ihandle ptr, byval name as const zstring ptr, byval lin as long, byval col as long, byval value as const zstring ptr)
declare sub IupMatStoreAttribute(byval ih as Ihandle ptr, byval name as const zstring ptr, byval lin as long, byval col as long, byval value as const zstring ptr)
declare function IupMatGetAttribute(byval ih as Ihandle ptr, byval name as const zstring ptr, byval lin as long, byval col as long) as zstring ptr
declare function IupMatGetInt(byval ih as Ihandle ptr, byval name as const zstring ptr, byval lin as long, byval col as long) as long
declare function IupMatGetFloat(byval ih as Ihandle ptr, byval name as const zstring ptr, byval lin as long, byval col as long) as single
declare sub IupMatSetfAttribute(byval ih as Ihandle ptr, byval name as const zstring ptr, byval lin as long, byval col as long, byval format as const zstring ptr, ...)
const IUP_PRIMARY = -1
const IUP_SECONDARY = -2
declare sub IupMatrixSetFormula(byval ih as Ihandle ptr, byval col as long, byval formula as const zstring ptr, byval init as const zstring ptr)
declare sub IupMatrixSetDynamic(byval ih as Ihandle ptr, byval init as const zstring ptr)

end extern
