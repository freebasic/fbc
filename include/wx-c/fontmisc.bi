''
''
'' fontmisc -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_fontmisc_bi__
#define __wxc_fontmisc_bi__

#include once "wx.bi"

declare function wxFontMapper alias "wxFontMapper_ctor" () as wxFontMapper ptr
declare sub wxFontMapper_dtor (byval self as wxFontMapper ptr)
declare function wxFontMapper_Get () as wxFontMapper ptr
declare function wxFontMapper_Set (byval mapper as wxFontMapper ptr) as wxFontMapper ptr
declare function wxFontMapper_GetSupportedEncodingsCount () as integer
declare function wxFontMapper_GetEncoding (byval n as integer) as wxFontEncoding
declare function wxFontMapper_GetEncodingName (byval encoding as wxFontEncoding) as wxString ptr
declare function wxFontMapper_GetEncodingFromName (byval name as zstring ptr) as wxFontEncoding
declare function wxFontMapper_CharsetToEncoding (byval self as wxFontMapper ptr, byval charset as zstring ptr, byval interactive as integer) as wxFontEncoding
declare function wxFontMapper_IsEncodingAvailable (byval self as wxFontMapper ptr, byval encoding as wxFontEncoding, byval facename as zstring ptr) as integer
declare function wxFontMapper_GetAltForEncoding (byval self as wxFontMapper ptr, byval encoding as wxFontEncoding, byval alt_encoding as wxFontEncoding ptr, byval facename as zstring ptr, byval interactive as integer) as integer
declare function wxFontMapper_GetEncodingDescription (byval encoding as wxFontEncoding) as wxString ptr
declare sub wxFontMapper_SetDialogParent (byval self as wxFontMapper ptr, byval parent as wxWindow ptr)
declare sub wxFontMapper_SetDialogTitle (byval self as wxFontMapper ptr, byval title as zstring ptr)
declare function wxEncodingConverter alias "wxEncodingConverter_ctor" () as wxEncodingConverter ptr
declare function wxEncodingConverter_Init (byval self as wxEncodingConverter ptr, byval input_enc as wxFontEncoding, byval output_enc as wxFontEncoding, byval method as integer) as integer
declare function wxEncodingConverter_Convert (byval self as wxEncodingConverter ptr, byval input as zstring ptr) as wxString ptr

type Virtual_EnumerateFacenames as function WXCALL (byval as wxFontEncoding, byval as integer) as integer
type Virtual_EnumerateEncodings as function WXCALL (byval as wxString ptr) as integer
type Virtual_OnFacename as function WXCALL (byval as wxString ptr) as integer
type Virtual_OnFontEncoding as function WXCALL (byval as wxString ptr, byval as wxString ptr) as integer

declare function wxFontEnumerator alias "wxFontEnumerator_ctor" () as wxFontEnumerator ptr
declare sub wxFontEnumerator_dtor (byval self as _FontEnumerator ptr)
declare sub wxFontEnumerator_RegisterVirtual (byval self as _FontEnumerator ptr, byval enumerateFacenames as Virtual_EnumerateFacenames, byval enumerateEncodings as Virtual_EnumerateEncodings, byval onFacename as Virtual_OnFacename, byval onFontEncoding as Virtual_OnFontEncoding)
declare function wxFontEnumerator_GetFacenames (byval self as _FontEnumerator ptr) as wxArrayString ptr
declare function wxFontEnumerator_GetEncodings (byval self as _FontEnumerator ptr) as wxArrayString ptr
declare function wxFontEnumerator_OnFacename (byval self as _FontEnumerator ptr, byval facename as zstring ptr) as integer
declare function wxFontEnumerator_OnFontEncoding (byval self as _FontEnumerator ptr, byval facename as zstring ptr, byval encoding as zstring ptr) as integer
declare function wxFontEnumerator_EnumerateFacenames (byval self as _FontEnumerator ptr, byval encoding as wxFontEncoding, byval fixedWidthOnly as integer) as integer
declare function wxFontEnumerator_EnumerateEncodings (byval self as _FontEnumerator ptr, byval facename as zstring ptr) as integer

#endif
