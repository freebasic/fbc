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

#inclib "iupglcontrols"

extern "C"

#define __IUPGLCONTROLS_H
declare function IupGLControlsOpen() as long
declare function IupGLCanvasBoxv(byval children as Ihandle ptr ptr) as Ihandle ptr
declare function IupGLCanvasBox(byval child as Ihandle ptr, ...) as Ihandle ptr
declare function IupGLSubCanvas() as Ihandle ptr
declare function IupGLLabel(byval title as const zstring ptr) as Ihandle ptr
declare function IupGLSeparator() as Ihandle ptr
declare function IupGLButton(byval title as const zstring ptr) as Ihandle ptr
declare function IupGLToggle(byval title as const zstring ptr) as Ihandle ptr
declare function IupGLLink(byval url as const zstring ptr, byval title as const zstring ptr) as Ihandle ptr
declare function IupGLProgressBar() as Ihandle ptr
declare function IupGLVal() as Ihandle ptr
declare function IupGLFrame(byval child as Ihandle ptr) as Ihandle ptr
declare function IupGLExpander(byval child as Ihandle ptr) as Ihandle ptr
declare function IupGLScrollBox(byval child as Ihandle ptr) as Ihandle ptr
declare function IupGLSizeBox(byval child as Ihandle ptr) as Ihandle ptr

end extern
