''
''
'' iupcpi -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __iupcpi_bi__
#define __iupcpi_bi__

#include once "IUP/iupcbs.bi"

type Iclass as Iclass_
type Imethod as sub cdecl(byval as Ihandle ptr, ...)

#define ICPI_SETNATURALSIZE "SETNATURALSIZE"
#define ICPI_SETCURRENTSIZE "SETCURRENTSIZE"
#define ICPI_GETSIZE "GETSIZE"
#define ICPI_SETPOSITION "SETPOSITION"
#define ICPI_CREATE "CREATE"
#define ICPI_DESTROY "DESTROY"
#define ICPI_MAP "MAP"
#define ICPI_UNMAP "UNMAP"
#define ICPI_SETATTR "SETATTR"
#define ICPI_GETATTR "GETATTR"
#define ICPI_GETDEFAULTATTR "GETDEFAULTATTR"
#define ICPI_POPUP "POPUP"

declare function iupCpiDefaultSetNaturalSize cdecl alias "iupCpiDefaultSetNaturalSize" (byval self as Ihandle ptr) as integer
declare sub iupCpiDefaultSetCurrentSize cdecl alias "iupCpiDefaultSetCurrentSize" (byval self as Ihandle ptr, byval w as integer, byval h as integer)
declare function iupCpiDefaultGetSize cdecl alias "iupCpiDefaultGetSize" (byval self as Ihandle ptr, byval w as integer ptr, byval h as integer ptr) as integer
declare function iupCpiDefaultGetSizevar cdecl alias "iupCpiDefaultGetSizevar" (byval self as Ihandle ptr, byval w as integer ptr, byval h as integer ptr) as integer
declare sub iupCpiDefaultSetPosition cdecl alias "iupCpiDefaultSetPosition" (byval self as Ihandle ptr, byval w as integer, byval h as integer)
declare function iupCpiDefaultCreate cdecl alias "iupCpiDefaultCreate" (byval self as Iclass ptr, byval array as Ihandle ptr ptr) as Ihandle ptr
declare sub iupCpiDefaultDestroy cdecl alias "iupCpiDefaultDestroy" (byval self as Ihandle ptr)
declare sub iupCpiDefaultMap cdecl alias "iupCpiDefaultMap" (byval self as Ihandle ptr, byval parent as Ihandle ptr)
declare sub iupCpiDefaultUnmap cdecl alias "iupCpiDefaultUnmap" (byval self as Ihandle ptr)
declare sub iupCpiDefaultSetAttr cdecl alias "iupCpiDefaultSetAttr" (byval self as Ihandle ptr, byval attr as zstring ptr, byval value as zstring ptr)
declare function iupCpiDefaultGetAttr cdecl alias "iupCpiDefaultGetAttr" (byval self as Ihandle ptr, byval attr as zstring ptr) as zstring ptr
declare function iupCpiDefaultGetDefaultAttr cdecl alias "iupCpiDefaultGetDefaultAttr" (byval self as Ihandle ptr, byval attr as zstring ptr) as zstring ptr
declare function iupCpiSetNaturalSize cdecl alias "iupCpiSetNaturalSize" (byval self as Ihandle ptr) as integer
declare sub iupCpiSetCurrentSize cdecl alias "iupCpiSetCurrentSize" (byval self as Ihandle ptr, byval w as integer, byval h as integer)
declare function iupCpiGetSize cdecl alias "iupCpiGetSize" (byval self as Ihandle ptr, byval w as integer ptr, byval h as integer ptr) as integer
declare sub iupCpiSetPosition cdecl alias "iupCpiSetPosition" (byval self as Ihandle ptr, byval w as integer, byval h as integer)
declare sub iupCpiDestroy cdecl alias "iupCpiDestroy" (byval self as Ihandle ptr)
declare sub iupCpiMap cdecl alias "iupCpiMap" (byval self as Ihandle ptr, byval parent as Ihandle ptr)
declare sub iupCpiUnmap cdecl alias "iupCpiUnmap" (byval self as Ihandle ptr)
declare sub iupCpiSetAttribute cdecl alias "iupCpiSetAttribute" (byval self as Ihandle ptr, byval attr as zstring ptr, byval value as zstring ptr)
declare function iupCpiGetAttribute cdecl alias "iupCpiGetAttribute" (byval self as Ihandle ptr, byval attr as zstring ptr) as zstring ptr
declare function iupCpiGetDefaultAttr cdecl alias "iupCpiGetDefaultAttr" (byval self as Ihandle ptr, byval attr as zstring ptr) as zstring ptr
declare function iupCpiPopup cdecl alias "iupCpiPopup" (byval self as Ihandle ptr, byval x as integer, byval y as integer) as integer
declare function iupCpiCreate cdecl alias "iupCpiCreate" (byval ic as Iclass ptr, byval params as Ihandle ptr ptr) as Ihandle ptr
declare sub iupCpiFinish cdecl alias "iupCpiFinish" ()
declare sub iupCpiInit cdecl alias "iupCpiInit" ()
declare function iupCpiGetClassName cdecl alias "iupCpiGetClassName" (byval ic as Iclass ptr) as zstring ptr
declare function iupCpiGetClass cdecl alias "iupCpiGetClass" (byval name as zstring ptr) as Iclass ptr
declare function iupCpiGetClassFormat cdecl alias "iupCpiGetClassFormat" (byval ic as Iclass ptr) as zstring ptr
declare function iupCpiGetClassMethod cdecl alias "iupCpiGetClassMethod" (byval ic as Iclass ptr, byval method as zstring ptr) as Imethod
declare function iupCpiSetClassMethod cdecl alias "iupCpiSetClassMethod" (byval ic as Iclass ptr, byval method as zstring ptr, byval func as Imethod) as integer
declare function iupCpiCreateNewClass cdecl alias "iupCpiCreateNewClass" (byval name as zstring ptr, byval format as zstring ptr) as Iclass ptr
declare sub iupCpiFreeClass cdecl alias "iupCpiFreeClass" (byval a as Iclass ptr)
declare function iupstricmp cdecl alias "iupstricmp" (byval s1 as zstring ptr, byval s2 as zstring ptr) as integer

#endif
