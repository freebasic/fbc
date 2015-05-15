'' FreeBASIC binding for libXmu-1.1.2
''
'' based on the C header files:
''   **********************************************************
''
''   Copyright 1999 by Thomas E. Dickey <dickey@clark.net>
''
''                           All Rights Reserved
''
''   Permission is hereby granted, free of charge, to any person obtaining a
''   copy of this software and associated documentation files (the
''   "Software"), to deal in the Software without restriction, including
''   without limitation the rights to use, copy, modify, merge, publish,
''   distribute, sublicense, and/or sell copies of the Software, and to
''   permit persons to whom the Software is furnished to do so, subject to
''   the following conditions:
''
''   The above copyright notice and this permission notice shall be included
''   in all copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
''   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
''   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
''   IN NO EVENT SHALL THE ABOVE LISTED COPYRIGHT HOLDER(S) BE LIABLE FOR ANY
''   CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
''   TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
''   SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
''
''   Except as contained in this notice, the name(s) of the above copyright
''   holders shall not be used in advertising or otherwise to promote the
''   sale, use or other dealings in this Software without prior written
''   authorization.
''
''   *******************************************************
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/long.bi"
#include once "X11/Xlib.bi"
#include once "X11/Xutil.bi"

extern "C"

const included_xmu_lookup_h = 1
declare function XmuLookupString(byval event as XKeyEvent ptr, byval buffer as ubyte ptr, byval nbytes as long, byval keysym as KeySym ptr, byval status as XComposeStatus ptr, byval keysymSet as culong) as long
declare function XmuLookupLatin1(byval event as XKeyEvent ptr, byval buffer as ubyte ptr, byval nbytes as long, byval keysym as KeySym ptr, byval status as XComposeStatus ptr) as long
declare function XmuLookupLatin2(byval event as XKeyEvent ptr, byval buffer as ubyte ptr, byval nbytes as long, byval keysym as KeySym ptr, byval status as XComposeStatus ptr) as long
declare function XmuLookupLatin3(byval event as XKeyEvent ptr, byval buffer as ubyte ptr, byval nbytes as long, byval keysym as KeySym ptr, byval status as XComposeStatus ptr) as long
declare function XmuLookupLatin4(byval event as XKeyEvent ptr, byval buffer as ubyte ptr, byval nbytes as long, byval keysym as KeySym ptr, byval status as XComposeStatus ptr) as long
declare function XmuLookupKana(byval event as XKeyEvent ptr, byval buffer as ubyte ptr, byval nbytes as long, byval keysym as KeySym ptr, byval status as XComposeStatus ptr) as long
declare function XmuLookupJISX0201(byval event as XKeyEvent ptr, byval buffer as ubyte ptr, byval nbytes as long, byval keysym as KeySym ptr, byval status as XComposeStatus ptr) as long
declare function XmuLookupArabic(byval event as XKeyEvent ptr, byval buffer as ubyte ptr, byval nbytes as long, byval keysym as KeySym ptr, byval status as XComposeStatus ptr) as long
declare function XmuLookupCyrillic(byval event as XKeyEvent ptr, byval buffer as ubyte ptr, byval nbytes as long, byval keysym as KeySym ptr, byval status as XComposeStatus ptr) as long
declare function XmuLookupGreek(byval event as XKeyEvent ptr, byval buffer as ubyte ptr, byval nbytes as long, byval keysym as KeySym ptr, byval status as XComposeStatus ptr) as long
declare function XmuLookupAPL(byval event as XKeyEvent ptr, byval buffer as ubyte ptr, byval nbytes as long, byval keysym as KeySym ptr, byval status as XComposeStatus ptr) as long
declare function XmuLookupHebrew(byval event as XKeyEvent ptr, byval buffer as ubyte ptr, byval nbytes as long, byval keysym as KeySym ptr, byval status as XComposeStatus ptr) as long

end extern
