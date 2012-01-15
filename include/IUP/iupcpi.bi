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

#include once "iupcbs.bi"

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

extern "c"
declare function iupCpiDefaultSetNaturalSize (byval self as Ihandle ptr) as integer
declare sub iupCpiDefaultSetCurrentSize (byval self as Ihandle ptr, byval w as integer, byval h as integer)
declare function iupCpiDefaultGetSize (byval self as Ihandle ptr, byval w as integer ptr, byval h as integer ptr) as integer
declare function iupCpiDefaultGetSizevar (byval self as Ihandle ptr, byval w as integer ptr, byval h as integer ptr) as integer
declare sub iupCpiDefaultSetPosition (byval self as Ihandle ptr, byval w as integer, byval h as integer)
declare function iupCpiDefaultCreate (byval self as Iclass ptr, byval array as Ihandle ptr ptr) as Ihandle ptr
declare sub iupCpiDefaultDestroy (byval self as Ihandle ptr)
declare sub iupCpiDefaultMap (byval self as Ihandle ptr, byval parent as Ihandle ptr)
declare sub iupCpiDefaultUnmap (byval self as Ihandle ptr)
declare sub iupCpiDefaultSetAttr (byval self as Ihandle ptr, byval attr as zstring ptr, byval value as zstring ptr)
declare function iupCpiDefaultGetAttr (byval self as Ihandle ptr, byval attr as zstring ptr) as zstring ptr
declare function iupCpiDefaultGetDefaultAttr (byval self as Ihandle ptr, byval attr as zstring ptr) as zstring ptr
declare function iupCpiSetNaturalSize (byval self as Ihandle ptr) as integer
declare sub iupCpiSetCurrentSize (byval self as Ihandle ptr, byval w as integer, byval h as integer)
declare function iupCpiGetSize (byval self as Ihandle ptr, byval w as integer ptr, byval h as integer ptr) as integer
declare sub iupCpiSetPosition (byval self as Ihandle ptr, byval w as integer, byval h as integer)
declare sub iupCpiDestroy (byval self as Ihandle ptr)
declare sub iupCpiMap (byval self as Ihandle ptr, byval parent as Ihandle ptr)
declare sub iupCpiUnmap (byval self as Ihandle ptr)
declare sub iupCpiSetAttribute (byval self as Ihandle ptr, byval attr as zstring ptr, byval value as zstring ptr)
declare function iupCpiGetAttribute (byval self as Ihandle ptr, byval attr as zstring ptr) as zstring ptr
declare function iupCpiGetDefaultAttr (byval self as Ihandle ptr, byval attr as zstring ptr) as zstring ptr
declare function iupCpiPopup (byval self as Ihandle ptr, byval x as integer, byval y as integer) as integer
declare function iupCpiCreate (byval ic as Iclass ptr, byval params as Ihandle ptr ptr) as Ihandle ptr
declare sub iupCpiFinish ()
declare sub iupCpiInit ()
declare function iupCpiGetClassName (byval ic as Iclass ptr) as zstring ptr
declare function iupCpiGetClass (byval name as zstring ptr) as Iclass ptr
declare function iupCpiGetClassFormat (byval ic as Iclass ptr) as zstring ptr
declare function iupCpiGetClassMethod (byval ic as Iclass ptr, byval method as zstring ptr) as Imethod
declare function iupCpiSetClassMethod (byval ic as Iclass ptr, byval method as zstring ptr, byval func as Imethod) as integer
declare function iupCpiCreateNewClass (byval name as zstring ptr, byval format as zstring ptr) as Iclass ptr
declare sub iupCpiFreeClass (byval a as Iclass ptr)
declare function iupstricmp (byval s1 as zstring ptr, byval s2 as zstring ptr) as integer
end extern

#endif
