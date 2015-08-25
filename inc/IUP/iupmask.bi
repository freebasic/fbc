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

#define __IUP_OLDMASK_H
declare function iupmaskSet(byval h as Ihandle ptr, byval mask as const zstring ptr, byval autofill as long, byval casei as long) as long
declare function iupmaskSetInt(byval h as Ihandle ptr, byval autofill as long, byval min as long, byval max as long) as long
declare function iupmaskSetFloat(byval h as Ihandle ptr, byval autofill as long, byval min as single, byval max as single) as long
declare sub iupmaskRemove(byval h as Ihandle ptr)
declare function iupmaskCheck(byval h as Ihandle ptr) as long
declare function iupmaskGet(byval h as Ihandle ptr, byval val as zstring ptr ptr) as long
declare function iupmaskGetFloat(byval h as Ihandle ptr, byval fval as single ptr) as long
declare function iupmaskGetDouble(byval h as Ihandle ptr, byval dval as double ptr) as long
declare function iupmaskGetInt(byval h as Ihandle ptr, byval ival as long ptr) as long
declare function iupmaskMatSet(byval h as Ihandle ptr, byval mask as const zstring ptr, byval autofill as long, byval casei as long, byval lin as long, byval col as long) as long
declare function iupmaskMatSetInt(byval h as Ihandle ptr, byval autofill as long, byval min as long, byval max as long, byval lin as long, byval col as long) as long
declare function iupmaskMatSetFloat(byval h as Ihandle ptr, byval autofill as long, byval min as single, byval max as single, byval lin as long, byval col as long) as long
declare sub iupmaskMatRemove(byval h as Ihandle ptr, byval lin as long, byval col as long)
declare function iupmaskMatCheck(byval h as Ihandle ptr, byval lin as long, byval col as long) as long
declare function iupmaskMatGet(byval h as Ihandle ptr, byval val as zstring ptr ptr, byval lin as long, byval col as long) as long
declare function iupmaskMatGetFloat(byval h as Ihandle ptr, byval fval as single ptr, byval lin as long, byval col as long) as long
declare function iupmaskMatGetDouble(byval h as Ihandle ptr, byval dval as double ptr, byval lin as long, byval col as long) as long
declare function iupmaskMatGetInt(byval h as Ihandle ptr, byval ival as long ptr, byval lin as long, byval col as long) as long

end extern
