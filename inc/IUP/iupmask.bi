''
''
'' iupmask -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __iupmask_bi__
#define __iupmask_bi__

declare function iupmaskSet cdecl alias "iupmaskSet" (byval h as Ihandle ptr, byval mask as zstring ptr, byval autofill as integer, byval casei as integer) as integer
declare function iupmaskSetInt cdecl alias "iupmaskSetInt" (byval h as Ihandle ptr, byval autofill as integer, byval min as integer, byval max as integer) as integer
declare function iupmaskSetFloat cdecl alias "iupmaskSetFloat" (byval h as Ihandle ptr, byval autofill as integer, byval min as single, byval max as single) as integer
declare sub iupmaskRemove cdecl alias "iupmaskRemove" (byval h as Ihandle ptr)
declare function iupmaskCheck cdecl alias "iupmaskCheck" (byval h as Ihandle ptr) as integer
declare function iupmaskGet cdecl alias "iupmaskGet" (byval h as Ihandle ptr, byval val as byte ptr ptr) as integer
declare function iupmaskGetFloat cdecl alias "iupmaskGetFloat" (byval h as Ihandle ptr, byval fval as single ptr) as integer
declare function iupmaskGetDouble cdecl alias "iupmaskGetDouble" (byval h as Ihandle ptr, byval dval as double ptr) as integer
declare function iupmaskGetInt cdecl alias "iupmaskGetInt" (byval h as Ihandle ptr, byval ival as integer ptr) as integer
declare function iupmaskMatSet cdecl alias "iupmaskMatSet" (byval h as Ihandle ptr, byval mask as zstring ptr, byval autofill as integer, byval casei as integer, byval lin as integer, byval col as integer) as integer
declare function iupmaskMatSetInt cdecl alias "iupmaskMatSetInt" (byval h as Ihandle ptr, byval autofill as integer, byval min as integer, byval max as integer, byval lin as integer, byval col as integer) as integer
declare function iupmaskMatSetFloat cdecl alias "iupmaskMatSetFloat" (byval h as Ihandle ptr, byval autofill as integer, byval min as single, byval max as single, byval lin as integer, byval col as integer) as integer
declare sub iupmaskMatRemove cdecl alias "iupmaskMatRemove" (byval h as Ihandle ptr, byval lin as integer, byval col as integer)
declare function iupmaskMatCheck cdecl alias "iupmaskMatCheck" (byval h as Ihandle ptr, byval lin as integer, byval col as integer) as integer
declare function iupmaskMatGet cdecl alias "iupmaskMatGet" (byval h as Ihandle ptr, byval val as byte ptr ptr, byval lin as integer, byval col as integer) as integer
declare function iupmaskMatGetFloat cdecl alias "iupmaskMatGetFloat" (byval h as Ihandle ptr, byval fval as single ptr, byval lin as integer, byval col as integer) as integer
declare function iupmaskMatGetDouble cdecl alias "iupmaskMatGetDouble" (byval h as Ihandle ptr, byval dval as double ptr, byval lin as integer, byval col as integer) as integer
declare function iupmaskMatGetInt cdecl alias "iupmaskMatGetInt" (byval h as Ihandle ptr, byval ival as integer ptr, byval lin as integer, byval col as integer) as integer

#endif
