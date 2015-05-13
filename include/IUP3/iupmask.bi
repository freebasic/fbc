/'** \file
 * \brief iupmask functions.
 *
 * See Copyright Notice in "iup.bi"
 *'/

#ifndef __iupmask_bi__
#define __iupmask_bi__

#warning "Warning: Using OLD iupMask definitions, use the MASK attribute in IupText or IupMatrix."

extern "C"

declare function iupmaskSet (byval h as Ihandle ptr, byval mask as zstring ptr, byval autofill as integer, byval casei as integer) as integer
declare function iupmaskSetInt (byval h as Ihandle ptr, byval autofill as integer, byval min as integer, byval max as integer) as integer
declare function iupmaskSetFloat (byval h as Ihandle ptr, byval autofill as integer, byval min as single, byval max as single) as integer
declare sub iupmaskRemove (byval h as Ihandle ptr)
declare function iupmaskCheck (byval h as Ihandle ptr) as integer
declare function iupmaskGet (byval h as Ihandle ptr, byval val as byte ptr ptr) as integer
declare function iupmaskGetFloat (byval h as Ihandle ptr, byval fval as single ptr) as integer
declare function iupmaskGetDouble (byval h as Ihandle ptr, byval dval as double ptr) as integer
declare function iupmaskGetInt (byval h as Ihandle ptr, byval ival as integer ptr) as integer
declare function iupmaskMatSet (byval h as Ihandle ptr, byval mask as zstring ptr, byval autofill as integer, byval casei as integer, byval lin as integer, byval col as integer) as integer
declare function iupmaskMatSetInt (byval h as Ihandle ptr, byval autofill as integer, byval min as integer, byval max as integer, byval lin as integer, byval col as integer) as integer
declare function iupmaskMatSetFloat (byval h as Ihandle ptr, byval autofill as integer, byval min as single, byval max as single, byval lin as integer, byval col as integer) as integer
declare sub iupmaskMatRemove (byval h as Ihandle ptr, byval lin as integer, byval col as integer)
declare function iupmaskMatCheck (byval h as Ihandle ptr, byval lin as integer, byval col as integer) as integer
declare function iupmaskMatGet (byval h as Ihandle ptr, byval val as byte ptr ptr, byval lin as integer, byval col as integer) as integer
declare function iupmaskMatGetFloat (byval h as Ihandle ptr, byval fval as single ptr, byval lin as integer, byval col as integer) as integer
declare function iupmaskMatGetDouble (byval h as Ihandle ptr, byval dval as double ptr, byval lin as integer, byval col as integer) as integer
declare function iupmaskMatGetInt (byval h as Ihandle ptr, byval ival as integer ptr, byval lin as integer, byval col as integer) as integer

end extern

#endif
