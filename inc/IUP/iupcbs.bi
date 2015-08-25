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

'' The following symbols have been renamed:
''     typedef IFnIi => IFnIi_
''     typedef IFniIIII => IFniIIII_

extern "C"

#define __IUPCBS_H
type IFidle as function() as long
type IFi as sub(byval as long)
type IFii as sub(byval as long, byval as long)
type IFiis as sub(byval as long, byval as long, byval as zstring ptr)
type IFiiiis as sub(byval as long, byval as long, byval as long, byval as long, byval as zstring ptr)
type IFfiis as sub(byval as single, byval as long, byval as long, byval as zstring ptr)
type IFn as function(byval as Ihandle ptr) as long
type IFni as function(byval as Ihandle ptr, byval as long) as long
type IFnii as function(byval as Ihandle ptr, byval as long, byval as long) as long
type IFniii as function(byval as Ihandle ptr, byval as long, byval as long, byval as long) as long
type IFniiii as function(byval as Ihandle ptr, byval as long, byval as long, byval as long, byval as long) as long
type _cdCanvas as _cdCanvas_
type IFniiiiiiC as function(byval as Ihandle ptr, byval as long, byval as long, byval as long, byval as long, byval as long, byval as long, byval as _cdCanvas ptr) as long
type IFniiiiii as function(byval as Ihandle ptr, byval as long, byval as long, byval as long, byval as long, byval as long, byval as long) as long
type IFnff as function(byval as Ihandle ptr, byval as single, byval as single) as long
type IFniff as function(byval as Ihandle ptr, byval as long, byval as single, byval as single) as long
type IFnfiis as function(byval as Ihandle ptr, byval as single, byval as long, byval as long, byval as zstring ptr) as long
type IFnsVi as function(byval as Ihandle ptr, byval as zstring ptr, byval as any ptr, byval as long) as long
type IFnsViii as function(byval as Ihandle ptr, byval as zstring ptr, byval as any ptr, byval as long, byval as long, byval as long) as long
type IFnsiii as function(byval as Ihandle ptr, byval as zstring ptr, byval as long, byval as long, byval as long) as long
type IFnnii as function(byval as Ihandle ptr, byval as Ihandle ptr, byval as long, byval as long) as long
type IFnnn as function(byval as Ihandle ptr, byval as Ihandle ptr, byval as Ihandle ptr) as long
type IFnss as function(byval as Ihandle ptr, byval as zstring ptr, byval as zstring ptr) as long
type IFns as function(byval as Ihandle ptr, byval as zstring ptr) as long
type IFnsi as function(byval as Ihandle ptr, byval as zstring ptr, byval as long) as long
type IFnis as function(byval as Ihandle ptr, byval as long, byval as zstring ptr) as long
type IFnsii as function(byval as Ihandle ptr, byval as zstring ptr, byval as long, byval as long) as long
type IFniis as function(byval as Ihandle ptr, byval as long, byval as long, byval as zstring ptr) as long
type IFniiis as function(byval as Ihandle ptr, byval as long, byval as long, byval as long, byval as zstring ptr) as long
type IFniiiis as function(byval as Ihandle ptr, byval as long, byval as long, byval as long, byval as long, byval as zstring ptr) as long
type IFniiiiiis as function(byval as Ihandle ptr, byval as long, byval as long, byval as long, byval as long, byval as long, byval as long, byval as zstring ptr) as long
type IFnIi_ as function(byval as Ihandle ptr, byval as long ptr, byval as long) as long
type IFnd as function(byval as Ihandle ptr, byval as double) as long
type IFniiIII as function(byval as Ihandle ptr, byval as long, byval as long, byval as long ptr, byval as long ptr, byval as long ptr) as long
type IFniinsii as function(byval as Ihandle ptr, byval as long, byval as long, byval as Ihandle ptr, byval as zstring ptr, byval as long, byval as long) as long
type IFnccc as function(byval as Ihandle ptr, byval as ubyte, byval as ubyte, byval as ubyte) as long
type IFniIIII_ as function(byval as Ihandle ptr, byval as long, byval as long ptr, byval as long ptr, byval as long ptr, byval as long ptr) as long
type IFnC as function(byval as Ihandle ptr, byval as _cdCanvas ptr) as long
type IFniiff as function(byval as Ihandle ptr, byval as long, byval as long, byval as single, byval as single) as long
type IFniiffi as function(byval as Ihandle ptr, byval as long, byval as long, byval as single, byval as single, byval as long) as long
type IFniidd as function(byval as Ihandle ptr, byval as long, byval as long, byval as double, byval as double) as long
type IFniiddi as function(byval as Ihandle ptr, byval as long, byval as long, byval as double, byval as double, byval as long) as long
type IFniiffFF as function(byval as Ihandle ptr, byval as long, byval as long, byval as single, byval as single, byval as single ptr, byval as single ptr) as long
type IFniiffs as function(byval as Ihandle ptr, byval as long, byval as long, byval as single, byval as single, byval as zstring ptr) as long
type IFniidds as function(byval as Ihandle ptr, byval as long, byval as long, byval as double, byval as double, byval as zstring ptr) as long
type IFndds as function(byval as Ihandle ptr, byval as double, byval as double, byval as zstring ptr) as long
type sIFnii as function(byval as Ihandle ptr, byval as long, byval as long) as zstring ptr
type sIFni as function(byval as Ihandle ptr, byval as long) as zstring ptr
type sIFniis as function(byval as Ihandle ptr, byval as long, byval as long, byval as zstring ptr) as zstring ptr
type dIFnii as function(byval as Ihandle ptr, byval as long, byval as long) as double
type IFniid as function(byval as Ihandle ptr, byval as long, byval as long, byval as double) as long

end extern
