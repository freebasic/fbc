''
''
'' iupcbs -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __iupcbs_bi__
#define __iupcbs_bi__

type IFn as function cdecl(byval as Ihandle ptr) as integer
type IFni as function cdecl(byval as Ihandle ptr, byval as integer) as integer
type IFnii as function cdecl(byval as Ihandle ptr, byval as integer, byval as integer) as integer
type IFniii as function cdecl(byval as Ihandle ptr, byval as integer, byval as integer, byval as integer) as integer
type IFniiii as function cdecl(byval as Ihandle ptr, byval as integer, byval as integer, byval as integer, byval as integer) as integer
type IFnis as function cdecl(byval as Ihandle ptr, byval as integer, byval as string) as integer
type IFnsii as function cdecl(byval as Ihandle ptr, byval as string, byval as integer, byval as integer) as integer
type IFnsiii as function cdecl(byval as Ihandle ptr, byval as string, byval as integer, byval as integer, byval as integer) as integer
type IFniis as function cdecl(byval as Ihandle ptr, byval as integer, byval as integer, byval as string) as integer
type IFniiiis as function cdecl(byval as Ihandle ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as string) as integer

#endif
