#pragma once

extern "C"

#define __IUP_OLDMASK_H

declare function iupmaskSet(byval h as Ihandle ptr, byval mask as const zstring ptr, byval autofill as long, byval casei as long) as long
declare function iupmaskSetInt(byval h as Ihandle ptr, byval autofill as long, byval min as long, byval max as long) as long
declare function iupmaskSetFloat(byval h as Ihandle ptr, byval autofill as long, byval min as single, byval max as single) as long
declare sub iupmaskRemove(byval h as Ihandle ptr)
declare function iupmaskCheck(byval h as Ihandle ptr) as long
declare function iupmaskGet(byval h as Ihandle ptr, byval val_ as zstring ptr ptr) as long
declare function iupmaskGetFloat(byval h as Ihandle ptr, byval fval as single ptr) as long
declare function iupmaskGetDouble(byval h as Ihandle ptr, byval dval as double ptr) as long
declare function iupmaskGetInt(byval h as Ihandle ptr, byval ival as long ptr) as long
declare function iupmaskMatSet(byval h as Ihandle ptr, byval mask as const zstring ptr, byval autofill as long, byval casei as long, byval lin as long, byval col as long) as long
declare function iupmaskMatSetInt(byval h as Ihandle ptr, byval autofill as long, byval min as long, byval max as long, byval lin as long, byval col as long) as long
declare function iupmaskMatSetFloat(byval h as Ihandle ptr, byval autofill as long, byval min as single, byval max as single, byval lin as long, byval col as long) as long
declare sub iupmaskMatRemove(byval h as Ihandle ptr, byval lin as long, byval col as long)
declare function iupmaskMatCheck(byval h as Ihandle ptr, byval lin as long, byval col as long) as long
declare function iupmaskMatGet(byval h as Ihandle ptr, byval val_ as zstring ptr ptr, byval lin as long, byval col as long) as long
declare function iupmaskMatGetFloat(byval h as Ihandle ptr, byval fval as single ptr, byval lin as long, byval col as long) as long
declare function iupmaskMatGetDouble(byval h as Ihandle ptr, byval dval as double ptr, byval lin as long, byval col as long) as long
declare function iupmaskMatGetInt(byval h as Ihandle ptr, byval ival as long ptr, byval lin as long, byval col as long) as long

end extern
