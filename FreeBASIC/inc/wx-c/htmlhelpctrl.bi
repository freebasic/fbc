''
''
'' htmlhelpctrl -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_htmlhelpctrl_bi__
#define __wxc_htmlhelpctrl_bi__

#include once "wx-c/wx.bi"

declare function wxHtmlHelpController cdecl alias "wxHtmlHelpController_ctor" (byval style as integer) as wxHtmlHelpController ptr
declare sub wxHtmlHelpController_SetTitleFormat cdecl alias "wxHtmlHelpController_SetTitleFormat" (byval self as wxHtmlHelpController ptr, byval format as zstring ptr)
declare sub wxHtmlHelpController_SetTempDir cdecl alias "wxHtmlHelpController_SetTempDir" (byval self as wxHtmlHelpController ptr, byval path as zstring ptr)
declare function wxHtmlHelpController_AddBook cdecl alias "wxHtmlHelpController_AddBook" (byval self as wxHtmlHelpController ptr, byval book_url as zstring ptr) as integer
declare function wxHtmlHelpController_Display cdecl alias "wxHtmlHelpController_Display" (byval self as wxHtmlHelpController ptr, byval x as zstring ptr) as integer
declare function wxHtmlHelpController_DisplayInt cdecl alias "wxHtmlHelpController_DisplayInt" (byval self as wxHtmlHelpController ptr, byval id as integer) as integer
declare function wxHtmlHelpController_DisplayContents cdecl alias "wxHtmlHelpController_DisplayContents" (byval self as wxHtmlHelpController ptr) as integer
declare function wxHtmlHelpController_DisplayIndex cdecl alias "wxHtmlHelpController_DisplayIndex" (byval self as wxHtmlHelpController ptr) as integer
declare function wxHtmlHelpController_KeywordSearch cdecl alias "wxHtmlHelpController_KeywordSearch" (byval self as wxHtmlHelpController ptr, byval keyword as zstring ptr, byval mode as wxHelpSearchMode) as integer
declare sub wxHtmlHelpController_UseConfig cdecl alias "wxHtmlHelpController_UseConfig" (byval self as wxHtmlHelpController ptr, byval config as wxConfigBase ptr, byval rootpath as zstring ptr)
declare sub wxHtmlHelpController_ReadCustomization cdecl alias "wxHtmlHelpController_ReadCustomization" (byval self as wxHtmlHelpController ptr, byval cfg as wxConfigBase ptr, byval path as zstring ptr)
declare sub wxHtmlHelpController_WriteCustomization cdecl alias "wxHtmlHelpController_WriteCustomization" (byval self as wxHtmlHelpController ptr, byval cfg as wxConfigBase ptr, byval path as zstring ptr)
declare function wxHtmlHelpController_GetFrame cdecl alias "wxHtmlHelpController_GetFrame" (byval self as wxHtmlHelpController ptr) as wxHtmlHelpFrame ptr

#endif
