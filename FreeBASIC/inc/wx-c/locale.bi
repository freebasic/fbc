''
''
'' locale -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __locale_bi__
#define __locale_bi__

#include once "wx-c/wx.bi"

declare function wxLocale cdecl alias "wxLocale_ctor" () as wxLocale ptr
declare function wxLocale_ctor2 cdecl alias "wxLocale_ctor2" (byval language as integer, byval flags as integer) as wxLocale ptr
declare sub wxLocale_dtor cdecl alias "wxLocale_dtor" (byval self as wxLocale ptr)
declare function wxLocale_Init cdecl alias "wxLocale_Init" (byval self as wxLocale ptr, byval language as integer, byval flags as integer) as integer
declare function wxLocale_AddCatalog cdecl alias "wxLocale_AddCatalog" (byval self as wxLocale ptr, byval szDomain as string) as integer
declare function wxLocale_AddCatalog2 cdecl alias "wxLocale_AddCatalog2" (byval self as wxLocale ptr, byval szDomain as string, byval msgIdLanguage as wxLanguage, byval msgIdCharset as string) as integer
declare sub wxLocale_AddCatalogLookupPathPrefix cdecl alias "wxLocale_AddCatalogLookupPathPrefix" (byval self as wxLocale ptr, byval prefix as string)
declare sub wxLocale_AddLanguage cdecl alias "wxLocale_AddLanguage" (byval info as wxLanguageInfo ptr)
declare function wxLocale_FindLanguageInfo cdecl alias "wxLocale_FindLanguageInfo" (byval locale as string) as wxLanguageInfo ptr
declare function wxLocale_GetCanonicalName cdecl alias "wxLocale_GetCanonicalName" (byval self as wxLocale ptr) as wxString ptr
declare function wxLocale_GetLanguage cdecl alias "wxLocale_GetLanguage" (byval self as wxLocale ptr) as integer
declare function wxLocale_GetLanguageInfo cdecl alias "wxLocale_GetLanguageInfo" (byval lang as integer) as wxLanguageInfo ptr
declare function wxLocale_GetLanguageName cdecl alias "wxLocale_GetLanguageName" (byval lang as integer) as wxString ptr
declare function wxLocale_GetLocale cdecl alias "wxLocale_GetLocale" (byval self as wxLocale ptr) as wxString ptr
declare function wxLocale_GetName cdecl alias "wxLocale_GetName" (byval self as wxLocale ptr) as wxString ptr
declare function wxLocale_GetString cdecl alias "wxLocale_GetString" (byval self as wxLocale ptr, byval szOrigString as string, byval szDomain as string) as wxString ptr
declare function wxLocale_GetHeaderValue cdecl alias "wxLocale_GetHeaderValue" (byval self as wxLocale ptr, byval szHeader as string, byval szDomain as string) as wxString ptr
declare function wxLocale_GetSysName cdecl alias "wxLocale_GetSysName" (byval self as wxLocale ptr) as wxString ptr
declare function wxLocale_GetSystemEncoding cdecl alias "wxLocale_GetSystemEncoding" () as wxFontEncoding
declare function wxLocale_GetSystemEncodingName cdecl alias "wxLocale_GetSystemEncodingName" () as wxString ptr
declare function wxLocale_GetSystemLanguage cdecl alias "wxLocale_GetSystemLanguage" () as integer
declare function wxLocale_IsLoaded cdecl alias "wxLocale_IsLoaded" (byval self as wxLocale ptr, byval domain as string) as integer
declare function wxLocale_IsOk cdecl alias "wxLocale_IsOk" (byval self as wxLocale ptr) as integer
declare function wxLanguageInfo cdecl alias "wxLanguageInfo_ctor" () as wxLanguageInfo ptr
declare sub wxLanguageInfo_dtor cdecl alias "wxLanguageInfo_dtor" (byval self as wxLanguageInfo ptr)
declare sub wxLanguageInfo_SetLanguage cdecl alias "wxLanguageInfo_SetLanguage" (byval self as wxLanguageInfo ptr, byval value as integer)
declare function wxLanguageInfo_GetLanguage cdecl alias "wxLanguageInfo_GetLanguage" (byval self as wxLanguageInfo ptr) as integer
declare sub wxLanguageInfo_SetCanonicalName cdecl alias "wxLanguageInfo_SetCanonicalName" (byval self as wxLanguageInfo ptr, byval name as string)
declare function wxLanguageInfo_GetCanonicalName cdecl alias "wxLanguageInfo_GetCanonicalName" (byval self as wxLanguageInfo ptr) as wxString ptr
declare sub wxLanguageInfo_SetDescription cdecl alias "wxLanguageInfo_SetDescription" (byval self as wxLanguageInfo ptr, byval name as string)
declare function wxLanguageInfo_GetDescription cdecl alias "wxLanguageInfo_GetDescription" (byval self as wxLanguageInfo ptr) as wxString ptr

#endif
