''
''
'' splashscreen -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_splashscreen_bi__
#define __wxc_splashscreen_bi__

#include once "wx.bi"


declare function wxSplashScreen alias "wxSplashScreen_ctor" (byval bitmap as wxBitmap ptr, byval splashStyle as integer, byval milliseconds as integer, byval parent as wxWindow ptr, byval id as wxWindowID, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer) as wxSplashScreen ptr
declare function wxSplashScreen_GetSplashStyle (byval self as wxSplashScreen ptr) as integer
declare function wxSplashScreen_GetSplashWindow (byval self as wxSplashScreen ptr) as wxSplashScreenWindow ptr
declare function wxSplashScreen_GetTimeout (byval self as wxSplashScreen ptr) as integer

declare function wxSplashScreenWindow alias "wxSplashScreenWindow_ctor" (byval bitmap as wxBitmap ptr, byval parent as wxWindow ptr, byval id as wxWindowID, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer) as wxSplashScreenWindow ptr
declare sub wxSplashScreenWindow_SetBitmap (byval self as wxSplashScreenWindow ptr, byval bitmap as wxBitmap ptr)
declare function wxSplashScreenWindow_GetBitmap (byval self as wxSplashScreenWindow ptr) as wxBitmap ptr

#endif
