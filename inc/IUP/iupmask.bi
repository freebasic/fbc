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

#define IUPMASK_ACTION "iupmaskACTION"
#define IUPMASK_K_DEL "iupmaskK_DEL"
#define IUPMASK_K_BS "iupmaskK_BS"
#define IUPMASK_MATACTION "iupmaskMATACTION"
#define IUPMASK_MATK_DEL "iupmaskMATK_DEL"
#define IUPMASK_MATK_BS "iupmaskMATK_BS"
#define IUPMASK_MATCH_CB "iupmaskMATCH_CB"
#define IUPMASK_MASK "iupmaskMASK"
#define IUPMASK_AUTOFILL "iupmaskAUTOFILL"
#define IUPMASK_CASE "iupmaskCASE"
#define IUPMASK_TYPE "iupmaskTYPE"
#define IUPMASK_MIN "iupmaskMIN"
#define IUPMASK_MAX "iupmaskMAX"
#define IUPMASK_TYPE_INT "I"
#define IUPMASK_TYPE_FLOAT "F"
#define IUPMASK_FLOAT "[+/-]?(/d+/.?/d*|/./d+)"
#define IUPMASK_UFLOAT "(/d+/.?/d*|/./d+)"
#define IUPMASK_EFLOAT "[+/-]?(/d+/.?/d*|/./d+)([eE][+/-]?/d+)?"
#define IUPMASK_INT "[+/-]?/d+"
#define IUPMASK_UINT "/d+"

extern "c"
declare sub iupmaskInit ()
declare function iupmaskSet (byval h as Ihandle ptr, byval mask as zstring ptr, byval autofill as integer, byval casei as integer) as integer
declare function iupmaskSetInt (byval h as Ihandle ptr, byval autofill as integer, byval min as integer, byval max as integer) as integer
declare function iupmaskSetFloat (byval h as Ihandle ptr, byval autofill as integer, byval min as single, byval max as single) as integer
declare function iupmaskCheck (byval h as Ihandle ptr) as integer
declare function iupmaskGet (byval h as Ihandle ptr, byval val as byte ptr ptr) as integer
declare function iupmaskGetFloat (byval h as Ihandle ptr, byval fval as single ptr) as integer
declare function iupmaskGetDouble (byval h as Ihandle ptr, byval dval as double ptr) as integer
declare function iupmaskGetInt (byval h as Ihandle ptr, byval ival as integer ptr) as integer
declare function iupmaskMatSet (byval h as Ihandle ptr, byval mask as zstring ptr, byval autofill as integer, byval casei as integer, byval lin as integer, byval col as integer) as integer
declare function iupmaskMatSetInt (byval h as Ihandle ptr, byval autofill as integer, byval min as integer, byval max as integer, byval lin as integer, byval col as integer) as integer
declare function iupmaskMatSetFloat (byval h as Ihandle ptr, byval autofill as integer, byval min as single, byval max as single, byval lin as integer, byval col as integer) as integer
declare function iupmaskMatCheck (byval h as Ihandle ptr, byval lin as integer, byval col as integer) as integer
declare function iupmaskMatGet (byval h as Ihandle ptr, byval val as byte ptr ptr, byval lin as integer, byval col as integer) as integer
declare function iupmaskMatGetFloat (byval h as Ihandle ptr, byval fval as single ptr, byval lin as integer, byval col as integer) as integer
declare function iupmaskMatGetDouble (byval h as Ihandle ptr, byval dval as double ptr, byval lin as integer, byval col as integer) as integer
declare function iupmaskMatGetInt (byval h as Ihandle ptr, byval ival as integer ptr, byval lin as integer, byval col as integer) as integer
end extern

#endif
