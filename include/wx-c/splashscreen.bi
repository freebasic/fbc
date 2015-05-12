#Ifndef __splashscreen_bi__
#Define __splashscreen_bi__

#Include Once "common.bi"

' class wxSplashScreen
Declare Function wxSplashScreen_ctor WXCALL Alias "wxSplashScreen_ctor" (bitmap As wxBitmap Ptr, _
                         splashStyle  As  wxInt                 , _
                         milliseconds As  wxInt                 , _
                         parent       As wxWindow Ptr          , _
                         id           As  wxWindowID        = -1, _
                       	 pos          As  wxPoint      Ptr     , _
                       	 size         As  wxSize       Ptr     , _
                         style        As  wxUInt            =  0) As wxSplashScreen Ptr
Declare Function wxSplashScreen_GetSplashStyle WXCALL Alias "wxSplashScreen_GetSplashStyle" (self As wxSplashScreen Ptr) As wxInt
Declare Function wxSplashScreen_GetSplashWindow WXCALL Alias "wxSplashScreen_GetSplashWindow" (self As wxSplashScreen Ptr) As wxSplashScreenWindow Ptr
Declare Function wxSplashScreen_GetTimeout WXCALL Alias "wxSplashScreen_GetTimeout" (self As wxSplashScreen Ptr) As wxInt

' class wxSplashScreenWindow
Declare Function wxSplashScreenWindow_ctor WXCALL Alias "wxSplashScreenWindow_ctor" (bitmap As wxBitmap Ptr, _
                               parent As wxWindow   Ptr   , _
                               id     As  wxWindowID   = -1, _
                       		   pos    As  wxPoint   Ptr     , _
                       		   size   As  wxSize    Ptr     , _
                               style  As  wxUInt       =  0) As wxSplashScreenWindow Ptr
Declare Sub wxSplashScreenWindow_SetBitmap WXCALL Alias "wxSplashScreenWindow_SetBitmap" (self As wxSplashScreenWindow Ptr, bitmap As wxBitmap Ptr)
Declare Function wxSplashScreenWindow_GetBitmap WXCALL Alias "wxSplashScreenWindow_GetBitmap" (self As wxSplashScreenWindow Ptr) As wxBitmap Ptr

#EndIf ' __splashscreen_bi__

