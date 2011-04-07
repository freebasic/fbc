''
''
'' locale -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_locale_bi__
#define __wxc_locale_bi__

#include once "wx.bi"

declare function wxLocale alias "wxLocale_ctor" () as wxLocale ptr
declare function wxLocale_ctor2 (byval language as integer, byval flags as integer) as wxLocale ptr
declare sub wxLocale_dtor (byval self as wxLocale ptr)
declare function wxLocale_Init (byval self as wxLocale ptr, byval language as integer, byval flags as integer) as integer
declare function wxLocale_AddCatalog (byval self as wxLocale ptr, byval szDomain as zstring ptr) as integer
declare function wxLocale_AddCatalog2 (byval self as wxLocale ptr, byval szDomain as zstring ptr, byval msgIdLanguage as wxLanguage, byval msgIdCharset as zstring ptr) as integer
declare sub wxLocale_AddCatalogLookupPathPrefix (byval self as wxLocale ptr, byval prefix as zstring ptr)
declare sub wxLocale_AddLanguage (byval info as wxLanguageInfo ptr)
declare function wxLocale_FindLanguageInfo (byval locale as zstring ptr) as wxLanguageInfo ptr
declare function wxLocale_GetCanonicalName (byval self as wxLocale ptr) as wxString ptr
declare function wxLocale_GetLanguage (byval self as wxLocale ptr) as integer
declare function wxLocale_GetLanguageInfo (byval lang as integer) as wxLanguageInfo ptr
declare function wxLocale_GetLanguageName (byval lang as integer) as wxString ptr
declare function wxLocale_GetLocale (byval self as wxLocale ptr) as wxString ptr
declare function wxLocale_GetName (byval self as wxLocale ptr) as wxString ptr
declare function wxLocale_GetString (byval self as wxLocale ptr, byval szOrigString as zstring ptr, byval szDomain as zstring ptr) as wxString ptr
declare function wxLocale_GetHeaderValue (byval self as wxLocale ptr, byval szHeader as zstring ptr, byval szDomain as zstring ptr) as wxString ptr
declare function wxLocale_GetSysName (byval self as wxLocale ptr) as wxString ptr
declare function wxLocale_GetSystemEncoding () as wxFontEncoding
declare function wxLocale_GetSystemEncodingName () as wxString ptr
declare function wxLocale_GetSystemLanguage () as integer
declare function wxLocale_IsLoaded (byval self as wxLocale ptr, byval domain as zstring ptr) as integer
declare function wxLocale_IsOk (byval self as wxLocale ptr) as integer
declare function wxLanguageInfo alias "wxLanguageInfo_ctor" () as wxLanguageInfo ptr
declare sub wxLanguageInfo_dtor (byval self as wxLanguageInfo ptr)
declare sub wxLanguageInfo_SetLanguage (byval self as wxLanguageInfo ptr, byval value as integer)
declare function wxLanguageInfo_GetLanguage (byval self as wxLanguageInfo ptr) as integer
declare sub wxLanguageInfo_SetCanonicalName (byval self as wxLanguageInfo ptr, byval name as zstring ptr)
declare function wxLanguageInfo_GetCanonicalName (byval self as wxLanguageInfo ptr) as wxString ptr
declare sub wxLanguageInfo_SetDescription (byval self as wxLanguageInfo ptr, byval name as zstring ptr)
declare function wxLanguageInfo_GetDescription (byval self as wxLanguageInfo ptr) as wxString ptr

#endif
