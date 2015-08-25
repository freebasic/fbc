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

#inclib "iupgl"

extern "C"

#define __IUPGL_H
#define IUP_BUFFER "BUFFER"
#define IUP_STEREO "STEREO"
#define IUP_BUFFER_SIZE "BUFFER_SIZE"
#define IUP_RED_SIZE "RED_SIZE"
#define IUP_GREEN_SIZE "GREEN_SIZE"
#define IUP_BLUE_SIZE "BLUE_SIZE"
#define IUP_ALPHA_SIZE "ALPHA_SIZE"
#define IUP_DEPTH_SIZE "DEPTH_SIZE"
#define IUP_STENCIL_SIZE "STENCIL_SIZE"
#define IUP_ACCUM_RED_SIZE "ACCUM_RED_SIZE"
#define IUP_ACCUM_GREEN_SIZE "ACCUM_GREEN_SIZE"
#define IUP_ACCUM_BLUE_SIZE "ACCUM_BLUE_SIZE"
#define IUP_ACCUM_ALPHA_SIZE "ACCUM_ALPHA_SIZE"
#define IUP_DOUBLE "DOUBLE"
#define IUP_SINGLE "SINGLE"
#define IUP_INDEX "INDEX"
#define IUP_RGBA "RGBA"

declare sub IupGLCanvasOpen()
declare function IupGLCanvas(byval action as const zstring ptr) as Ihandle ptr
declare sub IupGLMakeCurrent(byval ih as Ihandle ptr)
declare function IupGLIsCurrent(byval ih as Ihandle ptr) as long
declare sub IupGLSwapBuffers(byval ih as Ihandle ptr)
declare sub IupGLPalette(byval ih as Ihandle ptr, byval index as long, byval r as single, byval g as single, byval b as single)
declare sub IupGLUseFont(byval ih as Ihandle ptr, byval first as long, byval count as long, byval list_base as long)
declare sub IupGLWait(byval gl as long)

end extern
