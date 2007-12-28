''
''
'' font -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_font_bi__
#define __wxc_font_bi__

#include once "wx.bi"

declare function wxFont_NORMAL_FONT () as wxFont ptr
declare function wxFont_SMALL_FONT () as wxFont ptr
declare function wxFont_ITALIC_FONT () as wxFont ptr
declare function wxFont_SWISS_FONT () as wxFont ptr
declare function wxFont_ctorDef () as wxFont ptr
declare function wxFont alias "wxFont_ctor" (byval pointSize as integer, byval family as integer, byval style as integer, byval weight as integer, byval underline as integer, byval faceName as zstring ptr, byval encoding as wxFontEncoding) as wxFont ptr
declare sub wxFont_dtor (byval self as wxFont ptr)
declare function wxFont_Ok (byval self as wxFont ptr) as integer
declare function wxFont_GetPointSize (byval self as wxFont ptr) as integer
declare function wxFont_GetFamily (byval self as wxFont ptr) as integer
declare function wxFont_GetStyle (byval self as wxFont ptr) as integer
declare function wxFont_GetWeight (byval self as wxFont ptr) as integer
declare function wxFont_GetUnderlined (byval self as wxFont ptr) as integer
declare function wxFont_GetFaceName (byval self as wxFont ptr) as wxString ptr
declare function wxFont_GetEncoding (byval self as wxFont ptr) as wxFontEncoding
declare function wxFont_GetNativeFontInfo (byval self as wxFont ptr) as wxNativeFontInfo ptr
declare function wxFont_IsFixedWidth (byval self as wxFont ptr) as integer
declare function wxFont_GetNativeFontInfoDesc (byval self as wxFont ptr) as wxString ptr
declare function wxFont_GetNativeFontInfoUserDesc (byval self as wxFont ptr) as wxString ptr
declare sub wxFont_SetPointSize (byval self as wxFont ptr, byval pointSize as integer)
declare sub wxFont_SetFamily (byval self as wxFont ptr, byval family as integer)
declare sub wxFont_SetStyle (byval self as wxFont ptr, byval style as integer)
declare sub wxFont_SetWeight (byval self as wxFont ptr, byval weight as integer)
declare sub wxFont_SetFaceName (byval self as wxFont ptr, byval faceName as zstring ptr)
declare sub wxFont_SetUnderlined (byval self as wxFont ptr, byval underlined as integer)
declare sub wxFont_SetEncoding (byval self as wxFont ptr, byval encoding as wxFontEncoding)
declare sub wxFont_SetNativeFontInfoUserDesc (byval self as wxFont ptr, byval info as zstring ptr)
declare function wxFont_GetFamilyString (byval self as wxFont ptr) as wxString ptr
declare function wxFont_GetStyleString (byval self as wxFont ptr) as wxString ptr
declare function wxFont_GetWeightString (byval self as wxFont ptr) as wxString ptr
declare sub wxFont_SetNoAntiAliasing (byval self as wxFont ptr, byval no as integer)
declare function wxFont_GetNoAntiAliasing (byval self as wxFont ptr) as integer
declare function wxFont_GetDefaultEncoding () as wxFontEncoding
declare sub wxFont_SetDefaultEncoding (byval encoding as wxFontEncoding)
declare function wxFont_New (byval strNativeFontDesc as zstring ptr) as wxFont ptr

#endif
