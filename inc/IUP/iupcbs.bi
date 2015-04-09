'' FreeBASIC binding for iup-3.11.2

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
type IFniiiiiiC as function(byval as Ihandle ptr, byval as long, byval as long, byval as long, byval as long, byval as long, byval as long, byval as any ptr) as long
type IFniiiiii as function(byval as Ihandle ptr, byval as long, byval as long, byval as long, byval as long, byval as long, byval as long) as long
type IFnff as function(byval as Ihandle ptr, byval as single, byval as single) as long
type IFniff as function(byval as Ihandle ptr, byval as long, byval as single, byval as single) as long
type IFnfiis as function(byval as Ihandle ptr, byval as single, byval as long, byval as long, byval as zstring ptr) as long
type IFnsCi as function(byval as Ihandle ptr, byval as zstring ptr, byval as any ptr, byval as long) as long
type IFnsCiii as function(byval as Ihandle ptr, byval as zstring ptr, byval as any ptr, byval as long, byval as long, byval as long) as long
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
type IFnC as function(byval as Ihandle ptr, byval as any ptr) as long
type IFniiff as function(byval as Ihandle ptr, byval as long, byval as long, byval as single, byval as single) as long
type IFniiffi as function(byval as Ihandle ptr, byval as long, byval as long, byval as single, byval as single, byval as long) as long
type IFniiffff as function(byval as Ihandle ptr, byval as long, byval as long, byval as single, byval as single, byval as single ptr, byval as single ptr) as long
type IFniiffs as function(byval as Ihandle ptr, byval as long, byval as long, byval as single, byval as single, byval as zstring ptr) as long
type sIFnii as function(byval as Ihandle ptr, byval as long, byval as long) as zstring ptr
type sIFni as function(byval as Ihandle ptr, byval as long) as zstring ptr
type dIFnii as function(byval as Ihandle ptr, byval as long, byval as long) as double
type IFniid as sub(byval as Ihandle ptr, byval as long, byval as long, byval as double)

end extern
