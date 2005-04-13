''
''
'' fontmisc -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __fontmisc_bi__
#define __fontmisc_bi__

#include once "wx-c/wx.bi"

declare function wxFontMapper cdecl alias "wxFontMapper_ctor" () as wxFontMapper ptr
declare sub wxFontMapper_dtor cdecl alias "wxFontMapper_dtor" (byval self as wxFontMapper ptr)
declare function wxFontMapper_Get cdecl alias "wxFontMapper_Get" () as wxFontMapper ptr
declare function wxFontMapper_Set cdecl alias "wxFontMapper_Set" (byval mapper as wxFontMapper ptr) as wxFontMapper ptr
declare function wxFontMapper_GetSupportedEncodingsCount cdecl alias "wxFontMapper_GetSupportedEncodingsCount" () as integer
declare function wxFontMapper_GetEncoding cdecl alias "wxFontMapper_GetEncoding" (byval n as integer) as wxFontEncoding
declare function wxFontMapper_GetEncodingName cdecl alias "wxFontMapper_GetEncodingName" (byval encoding as wxFontEncoding) as wxString ptr
declare function wxFontMapper_GetEncodingFromName cdecl alias "wxFontMapper_GetEncodingFromName" (byval name as string) as wxFontEncoding
declare function wxFontMapper_CharsetToEncoding cdecl alias "wxFontMapper_CharsetToEncoding" (byval self as wxFontMapper ptr, byval charset as string, byval interactive as integer) as wxFontEncoding
declare function wxFontMapper_IsEncodingAvailable cdecl alias "wxFontMapper_IsEncodingAvailable" (byval self as wxFontMapper ptr, byval encoding as wxFontEncoding, byval facename as string) as integer
declare function wxFontMapper_GetAltForEncoding cdecl alias "wxFontMapper_GetAltForEncoding" (byval self as wxFontMapper ptr, byval encoding as wxFontEncoding, byval alt_encoding as wxFontEncoding ptr, byval facename as string, byval interactive as integer) as integer
declare function wxFontMapper_GetEncodingDescription cdecl alias "wxFontMapper_GetEncodingDescription" (byval encoding as wxFontEncoding) as wxString ptr
declare sub wxFontMapper_SetDialogParent cdecl alias "wxFontMapper_SetDialogParent" (byval self as wxFontMapper ptr, byval parent as wxWindow ptr)
declare sub wxFontMapper_SetDialogTitle cdecl alias "wxFontMapper_SetDialogTitle" (byval self as wxFontMapper ptr, byval title as string)
declare function wxEncodingConverter cdecl alias "wxEncodingConverter_ctor" () as wxEncodingConverter ptr
declare function wxEncodingConverter_Init cdecl alias "wxEncodingConverter_Init" (byval self as wxEncodingConverter ptr, byval input_enc as wxFontEncoding, byval output_enc as wxFontEncoding, byval method as integer) as integer
declare function wxEncodingConverter_Convert cdecl alias "wxEncodingConverter_Convert" (byval self as wxEncodingConverter ptr, byval input as string) as wxString ptr

type Virtual_EnumerateFacenames as function cdecl(byval as wxFontEncoding, byval as integer) as integer
type Virtual_EnumerateEncodings as function cdecl(byval as wxString ptr) as integer
type Virtual_OnFacename as function cdecl(byval as wxString ptr) as integer
type Virtual_OnFontEncoding as function cdecl(byval as wxString ptr, byval as wxString ptr) as integer

declare function wxFontEnumerator cdecl alias "wxFontEnumerator_ctor" () as wxFontEnumerator ptr
declare sub wxFontEnumerator_dtor cdecl alias "wxFontEnumerator_dtor" (byval self as _FontEnumerator ptr)
declare sub wxFontEnumerator_RegisterVirtual cdecl alias "wxFontEnumerator_RegisterVirtual" (byval self as _FontEnumerator ptr, byval enumerateFacenames as Virtual_EnumerateFacenames, byval enumerateEncodings as Virtual_EnumerateEncodings, byval onFacename as Virtual_OnFacename, byval onFontEncoding as Virtual_OnFontEncoding)
declare function wxFontEnumerator_GetFacenames cdecl alias "wxFontEnumerator_GetFacenames" (byval self as _FontEnumerator ptr) as wxArrayString ptr
declare function wxFontEnumerator_GetEncodings cdecl alias "wxFontEnumerator_GetEncodings" (byval self as _FontEnumerator ptr) as wxArrayString ptr
declare function wxFontEnumerator_OnFacename cdecl alias "wxFontEnumerator_OnFacename" (byval self as _FontEnumerator ptr, byval facename as string) as integer
declare function wxFontEnumerator_OnFontEncoding cdecl alias "wxFontEnumerator_OnFontEncoding" (byval self as _FontEnumerator ptr, byval facename as string, byval encoding as string) as integer
declare function wxFontEnumerator_EnumerateFacenames cdecl alias "wxFontEnumerator_EnumerateFacenames" (byval self as _FontEnumerator ptr, byval encoding as wxFontEncoding, byval fixedWidthOnly as integer) as integer
declare function wxFontEnumerator_EnumerateEncodings cdecl alias "wxFontEnumerator_EnumerateEncodings" (byval self as _FontEnumerator ptr, byval facename as string) as integer

#endif
