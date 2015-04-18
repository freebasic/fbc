'' FreeBASIC binding for libXt-1.1.4
''
'' based on the C header files:
''
''   Copyright 1985, 1986, 1987, 1988, 1989, 1998  The Open Group
''
''   Permission to use, copy, modify, distribute, and sell this software and its
''   documentation for any purpose is hereby granted without fee, provided that
''   the above copyright notice appear in all copies and that both that
''   copyright notice and this permission notice appear in supporting
''   documentation.
''
''   The above copyright notice and this permission notice shall be included in
''   all copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
''   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
''   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
''   OPEN GROUP BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
''   AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
''   CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
''
''   Except as contained in this notice, the name of The Open Group shall not be
''   used in advertising or otherwise to promote the sale, use or other dealings
''   in this Software without prior written authorization from The Open Group.
''
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/stdarg.bi"

extern "C"

#define _VarargsI_h_
declare sub _XtCountVaList(byval as va_list, byval as long ptr, byval as long ptr)
declare sub _XtVaToArgList(byval as Widget, byval as va_list, byval as long, byval as ArgList ptr, byval as Cardinal ptr)
declare sub _XtVaToTypedArgList(byval as va_list, byval as long, byval as XtTypedArgList ptr, byval as Cardinal ptr)
declare function _XtVaCreateTypedArgList(byval as va_list, byval as long) as XtTypedArgList
declare sub _XtFreeArgList(byval as ArgList, byval as long, byval as long)
declare sub _XtGetApplicationResources(byval as Widget, byval as XtPointer, byval as XtResourceList, byval as Cardinal, byval as ArgList, byval as Cardinal, byval as XtTypedArgList, byval as Cardinal)
declare sub _XtGetSubresources(byval as Widget, byval as XtPointer, byval as const zstring ptr, byval as const zstring ptr, byval as XtResourceList, byval as Cardinal, byval as ArgList, byval as Cardinal, byval as XtTypedArgList, byval as Cardinal)

end extern
