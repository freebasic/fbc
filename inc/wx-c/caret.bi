#Ifndef __caret_bi__
#Define __caret_bi__

#Include Once "common.bi"

' class wxCaret
Declare Function wxCaret_ctor WXCALL Alias "wxCaret_ctor" () As wxCaret Ptr
Declare Sub wxCaret_dtor WXCALL Alias "wxCaret_dtor" (self As wxCaret Ptr)
Declare Function wxCaret_Create WXCALL Alias "wxCaret_Create" (self As wxCaret Ptr, win As wxWindow Ptr, w As wxInt, h As wxInt) As wxBool
Declare Function wxCaret_IsOk WXCALL Alias "wxCaret_IsOk" (self As wxCaret Ptr) As wxBool
Declare Function wxCaret_IsVisible WXCALL Alias "wxCaret_IsVisible" (self As wxCaret Ptr) As wxBool
Declare Sub wxCaret_GetPosition WXCALL Alias "wxCaret_GetPosition" (self As wxCaret Ptr, pX As wxInt Ptr, pY As wxInt Ptr)
Declare Sub wxCaret_SetSize WXCALL Alias "wxCaret_SetSize" (self As wxCaret Ptr, w As wxInt, h As wxInt)
Declare Sub wxCaret_GetSize WXCALL Alias "wxCaret_GetSize" (self As wxCaret Ptr, pW As wxInt Ptr, pH As wxInt Ptr)
Declare Function wxCaret_GetWindow WXCALL Alias "wxCaret_GetWindow" (self As wxCaret Ptr) As wxWindow Ptr
Declare Sub wxCaret_Move WXCALL Alias "wxCaret_Move" (self As wxCaret Ptr, x As wxInt, y As wxInt)
Declare Sub wxCaret_Show WXCALL Alias "wxCaret_Show" (self As wxCaret Ptr,show As wxBool)
Declare Sub wxCaret_Hide WXCALL Alias "wxCaret_Hide" (self As wxCaret Ptr)
Declare Sub wxCaret_SetBlinkTime WXCALL Alias "wxCaret_SetBlinkTime" (milliseconds As wxInt)
Declare Function wxCaret_GetBlinkTime WXCALL Alias "wxCaret_GetBlinkTime" () As wxInt

' class wxCaretSuspend
Declare Function wxCaretSuspend_ctor WXCALL Alias "wxCaretSuspend_ctor" (win As wxWindow Ptr) As wxCaretSuspend Ptr
Declare Sub wxCaretSuspend_dtor WXCALL Alias "wxCaretSuspend_dtor" (sel As wxCaretSuspend Ptr)

#EndIf ' __caret_bi__

