#Ifndef __app_bi__
#Define __app_bi__

#Include Once "common.bi"


Declare Function OS_GetLastOSError WXCALL Alias "OS_GetLastOSError" () As wxInt
Declare Function wxApp_SafeYield WXCALL Alias "wxApp_SafeYield" (pWin As wxWindow Ptr, onlyIfNeeded As wxBool)  As  wxChar
Declare Function wxApp_SetHandleFatalExceptions WXCALL Alias "wxApp_SetHandleFatalExceptions" (doIt As wxBool) As wxChar
Declare Sub wxApp_WakeUpIdle WXCALL Alias "wxApp_WakeUpIdle" ()

Type Virtual_OnInit                As Function WXCALL As wxBool
Type Virtual_OnExceptionInMainLoop As Function WXCALL As wxBool
Type Virtual_OnFatalException      As Sub      WXCALL
Type Virtual_OnExit                As Function WXCALL As wxInt

Declare Function wxApp_ctor WXCALL Alias "wxApp_ctor" () As wxAPP Ptr
Declare Sub wxApp_RegisterVirtual WXCALL Alias "wxApp_RegisterVirtual" ( _
							self As wxAPP Ptr, _
                            onInit As Virtual_OnInit, _
                            onExit As Virtual_OnExit, _
                            OnExceptionInMainLoop As Virtual_OnExceptionInMainLoop = 0, _
                            OnFatalException      As Virtual_OnFatalException = 0)
Declare Function wxApp_IsActive WXCALL Alias "wxApp_IsActive" (self As wxApp Ptr) As wxChar
Declare Function wxApp_IsMainLoopRunning WXCALL Alias "wxApp_IsMainLoopRunning" (self As wxApp Ptr) As wxChar
Declare Function wxApp_OnExceptionInMainLoop WXCALL Alias "wxApp_OnExceptionInMainLoop" (self As wxApp Ptr) As wxChar
Declare Function wxApp_OnInit WXCALL Alias "wxApp_OnInit" (self As wxApp Ptr) As wxBool
Declare Function wxApp_OnExit WXCALL Alias "wxApp_OnExit" (self As wxApp Ptr) As wxInt
Declare Sub wxApp_Run WXCALL Alias "wxApp_Run" (argc As Integer = 0, argv As ZString Ptr Ptr = WX_NULL)
Declare Function wxApp_GetVendorName WXCALL Alias "wxApp_GetVendorName" (self As wxApp Ptr) As wxString Ptr
Declare Sub wxApp_SetVendorName WXCALL Alias "wxApp_SetVendorName" (self As wxApp Ptr, vendorname As wxString Ptr)
Declare Function wxApp_GetAppName WXCALL Alias "wxApp_GetAppName" (self As wxApp Ptr) As wxString Ptr
Declare Sub wxApp_SetAppName WXCALL Alias "wxApp_SetAppName" (self As wxApp Ptr, appname As wxString Ptr)
Declare Function wxApp_Yield WXCALL Alias "wxApp_Yield" (self As wxApp Ptr, onlyIfNeeded As wxBool) As wxChar

#EndIf '__app_bi__
