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

#include once "wx-c/wx.bi"

declare function wxFont_NORMAL_FONT cdecl alias "wxFont_NORMAL_FONT" () as wxFont ptr
declare function wxFont_SMALL_FONT cdecl alias "wxFont_SMALL_FONT" () as wxFont ptr
declare function wxFont_ITALIC_FONT cdecl alias "wxFont_ITALIC_FONT" () as wxFont ptr
declare function wxFont_SWISS_FONT cdecl alias "wxFont_SWISS_FONT" () as wxFont ptr
declare function wxFont_ctorDef cdecl alias "wxFont_ctorDef" () as wxFont ptr
declare function wxFont cdecl alias "wxFont_ctor" (byval pointSize as integer, byval family as integer, byval style as integer, byval weight as integer, byval underline as integer, byval faceName as zstring ptr, byval encoding as wxFontEncoding) as wxFont ptr
declare sub wxFont_dtor cdecl alias "wxFont_dtor" (byval self as wxFont ptr)
declare function wxFont_Ok cdecl alias "wxFont_Ok" (byval self as wxFont ptr) as integer
declare function wxFont_GetPointSize cdecl alias "wxFont_GetPointSize" (byval self as wxFont ptr) as integer
declare function wxFont_GetFamily cdecl alias "wxFont_GetFamily" (byval self as wxFont ptr) as integer
declare function wxFont_GetStyle cdecl alias "wxFont_GetStyle" (byval self as wxFont ptr) as integer
declare function wxFont_GetWeight cdecl alias "wxFont_GetWeight" (byval self as wxFont ptr) as integer
declare function wxFont_GetUnderlined cdecl alias "wxFont_GetUnderlined" (byval self as wxFont ptr) as integer
declare function wxFont_GetFaceName cdecl alias "wxFont_GetFaceName" (byval self as wxFont ptr) as wxString ptr
declare function wxFont_GetEncoding cdecl alias "wxFont_GetEncoding" (byval self as wxFont ptr) as wxFontEncoding
declare function wxFont_GetNativeFontInfo cdecl alias "wxFont_GetNativeFontInfo" (byval self as wxFont ptr) as wxNativeFontInfo ptr
declare function wxFont_IsFixedWidth cdecl alias "wxFont_IsFixedWidth" (byval self as wxFont ptr) as integer
declare function wxFont_GetNativeFontInfoDesc cdecl alias "wxFont_GetNativeFontInfoDesc" (byval self as wxFont ptr) as wxString ptr
declare function wxFont_GetNativeFontInfoUserDesc cdecl alias "wxFont_GetNativeFontInfoUserDesc" (byval self as wxFont ptr) as wxString ptr
declare sub wxFont_SetPointSize cdecl alias "wxFont_SetPointSize" (byval self as wxFont ptr, byval pointSize as integer)
declare sub wxFont_SetFamily cdecl alias "wxFont_SetFamily" (byval self as wxFont ptr, byval family as integer)
declare sub wxFont_SetStyle cdecl alias "wxFont_SetStyle" (byval self as wxFont ptr, byval style as integer)
declare sub wxFont_SetWeight cdecl alias "wxFont_SetWeight" (byval self as wxFont ptr, byval weight as integer)
declare sub wxFont_SetFaceName cdecl alias "wxFont_SetFaceName" (byval self as wxFont ptr, byval faceName as zstring ptr)
declare sub wxFont_SetUnderlined cdecl alias "wxFont_SetUnderlined" (byval self as wxFont ptr, byval underlined as integer)
declare sub wxFont_SetEncoding cdecl alias "wxFont_SetEncoding" (byval self as wxFont ptr, byval encoding as wxFontEncoding)
declare sub wxFont_SetNativeFontInfoUserDesc cdecl alias "wxFont_SetNativeFontInfoUserDesc" (byval self as wxFont ptr, byval info as zstring ptr)
declare function wxFont_GetFamilyString cdecl alias "wxFont_GetFamilyString" (byval self as wxFont ptr) as wxString ptr
declare function wxFont_GetStyleString cdecl alias "wxFont_GetStyleString" (byval self as wxFont ptr) as wxString ptr
declare function wxFont_GetWeightString cdecl alias "wxFont_GetWeightString" (byval self as wxFont ptr) as wxString ptr
declare sub wxFont_SetNoAntiAliasing cdecl alias "wxFont_SetNoAntiAliasing" (byval self as wxFont ptr, byval no as integer)
declare function wxFont_GetNoAntiAliasing cdecl alias "wxFont_GetNoAntiAliasing" (byval self as wxFont ptr) as integer
declare function wxFont_GetDefaultEncoding cdecl alias "wxFont_GetDefaultEncoding" () as wxFontEncoding
declare sub wxFont_SetDefaultEncoding cdecl alias "wxFont_SetDefaultEncoding" (byval encoding as wxFontEncoding)
declare function wxFont_New cdecl alias "wxFont_New" (byval strNativeFontDesc as zstring ptr) as wxFont ptr

#endif
