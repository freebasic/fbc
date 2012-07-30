/'** \file
 * \brief Contains all function pointer typedefs.
 *
 * See Copyright Notice in "iup.h"
 *'/

#ifndef __iupcbs_bi__
#define __iupcbs_bi__

type IFidle as function cdecl() as integer
type IFii as sub cdecl(byval as integer, byval as integer)
type IFiis as sub cdecl(byval as integer, byval as integer, byval as zstring ptr)
type IFiiiis as sub cdecl(byval as integer, byval as integer, byval as integer, byval as integer, byval as zstring ptr)
type IFfiis as sub cdecl(byval as single, byval as integer, byval as integer, byval as zstring ptr)
type IFn as function cdecl(byval as Ihandle ptr) as integer
type IFni as function cdecl(byval as Ihandle ptr, byval as integer) as integer
type IFnii as function cdecl(byval as Ihandle ptr, byval as integer, byval as integer) as integer
type IFniii as function cdecl(byval as Ihandle ptr, byval as integer, byval as integer, byval as integer) as integer
type IFniiii as function cdecl(byval as Ihandle ptr, byval as integer, byval as integer, byval as integer, byval as integer) as integer
type IFniiiiiiC as function cdecl(byval as Ihandle ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as any ptr) as integer
type IFniiiiii as function cdecl(byval as Ihandle ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer) as integer
type IFnff as function cdecl(byval as Ihandle ptr, byval as single, byval as single) as integer
type IFniff as function cdecl(byval as Ihandle ptr, byval as integer, byval as single, byval as single) as integer
type IFnfiis as function cdecl(byval as Ihandle ptr, byval as single, byval as integer, byval as integer, byval as zstring ptr) as integer
type IFnnii as function cdecl(byval as Ihandle ptr, byval as Ihandle ptr, byval as integer, byval as integer) as integer
type IFnnn as function cdecl(byval as Ihandle ptr, byval as Ihandle ptr, byval as Ihandle ptr) as integer
type IFnss as function cdecl(byval as Ihandle ptr, byval as zstring ptr, byval as zstring ptr) as integer
type IFns as function cdecl(byval as Ihandle ptr, byval as zstring ptr) as integer
type IFnsi as function cdecl(byval as Ihandle ptr, byval as zstring ptr, byval as integer) as integer
type IFnis as function cdecl(byval as Ihandle ptr, byval as integer, byval as zstring ptr) as integer
type IFnsii as function cdecl(byval as Ihandle ptr, byval as zstring ptr, byval as integer, byval as integer) as integer
type IFnsiii as function cdecl(byval as Ihandle ptr, byval as zstring ptr, byval as integer, byval as integer, byval as integer) as integer
type IFniis as function cdecl(byval as Ihandle ptr, byval as integer, byval as integer, byval as zstring ptr) as integer
type IFniiis as function cdecl(byval as Ihandle ptr, byval as integer, byval as integer, byval as integer, byval as zstring ptr) as integer
type IFniiiis as function cdecl(byval as Ihandle ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as zstring ptr) as integer
type IFniiiiiis as function cdecl(byval as Ihandle ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as zstring ptr) as integer
type IFnIi as function cdecl(byval as Ihandle ptr, byval as integer ptr, byval as integer) as integer
type IFnd as function cdecl(byval as Ihandle ptr, byval as double) as integer
type IFniiIII as function cdecl(byval as Ihandle ptr, byval as integer, byval as integer, byval as integer ptr, byval as integer ptr, byval as integer ptr) as integer
type IFniinsii as function cdecl(byval as Ihandle ptr, byval as integer, byval as integer, byval as Ihandle ptr, byval as zstring ptr, byval as integer, byval as integer) as integer
type IFnccc as function cdecl(byval as Ihandle ptr, byval as ubyte, byval as ubyte, byval as ubyte) as integer
type IFniIIII as function cdecl(byval as Ihandle ptr, byval as integer, byval as integer ptr, byval as integer ptr, byval as integer ptr, byval as integer ptr) as integer
type sIFnii as function cdecl(byval as Ihandle ptr, byval as integer, byval as integer) as byte ptr
type sIFni as function cdecl(byval as Ihandle ptr, byval as integer) as byte ptr

#endif
