#Ifndef __log_bi__
#Define __log_bi__

#Include Once "common.bi"

' different standard log levels (you may also define your own)
Enum wxLogLevel
  wxLOG_FatalError ' program can't continue, abort immediately
  wxLOG_Error      ' a serious error, user must be informed about it
  wxLOG_Warning    ' user is normally informed about it but may be ignored
  wxLOG_Message    ' normal message (i.e. normal output of a non GUI app)
  wxLOG_Status     ' informational: might go to the status line of GUI app
  wxLOG_Info       ' informational message (a.k.a. 'Verbose')
  wxLOG_Debug      ' never shown to the user, disabled in release mode
  wxLOG_Trace      ' trace messages are also only enabled in debug mode
  wxLOG_Progress   ' used for progress indicator (not yet)
  wxLOG_User = 100 ' user defined levels start here
  wxLOG_Max = 10000
End Enum
' trace mask bits
#Define wxTraceMemAlloc &H0001  ' trace memory allocation (new/delete)
#Define wxTraceMessages &H0002  ' trace window messages/X callbacks
#Define wxTraceResAlloc &H0004  ' trace GDI resource allocation
#Define wxTraceRefCount &H0008 

Type wxTraceMask As wxUint

Declare Function wxLog_ctor WXCALL Alias "wxLog_ctor" () As wxLog Ptr
Declare Sub wxLog_dtor WXCALL Alias "wxLog_dtor" (self As wxLog Ptr)
Declare Sub wxLog_Flush WXCALL Alias "wxLog_Flush" (self As wxLog Ptr)
Declare Function wxLog_HasPendingMessages WXCALL Alias "wxLog_HasPendingMessages" (self As wxLog Ptr) As wxBool
Declare Function wxLog_GetActiveTarget WXCALL Alias "wxLog_GetActiveTarget" () As wxLog Ptr
Declare Function wxLog_SetActiveTargetTextCtrl WXCALL Alias "wxLog_SetActiveTargetTextCtrl" (pLogger As wxTextCtrl Ptr) As wxLog Ptr
Declare Function wxLog_IsEnabled WXCALL Alias "wxLog_IsEnabled" () As wxBool
Declare Function wxLog_EnableLogging WXCALL Alias "wxLog_EnableLogging" (doit As wxBool) As wxBool
Declare Sub wxLog_FlushActive WXCALL Alias "wxLog_FlushActive" ()
Declare Sub wxLog_Suspend WXCALL Alias "wxLog_Suspend" ()
Declare Sub wxLog_Resume WXCALL Alias "wxLog_Resume" ()
Declare Sub wxLog_SetVerbose WXCALL Alias "wxLog_SetVerbose" (bVerbose As wxBool)
Declare Sub wxLog_SetLogLevel WXCALL Alias "wxLog_SetLogLevel" (logLevel As wxLogLevel)
Declare Sub wxLog_DontCreateOnDemand WXCALL Alias "wxLog_DontCreateOnDemand" ()
Declare Sub wxLog_LogTraceStringMask WXCALL Alias "wxLog_LogTraceStringMask" (mask As wxString Ptr, msg As wxString Ptr)
Declare Sub wxLog_SetTraceMask WXCALL Alias "wxLog_SetTraceMask" (ulMask As wxTraceMask)
Declare Sub wxLog_AddTraceMask WXCALL Alias "wxLog_AddTraceMask" (tMask As wxString Ptr)
Declare Sub wxLog_RemoveTraceMask WXCALL Alias "wxLog_RemoveTraceMask" (tMask As wxString Ptr)
Declare Sub wxLog_ClearTraceMasks WXCALL Alias "wxLog_ClearTraceMasks" ()
Declare Function wxLog_GetTraceMasks WXCALL Alias "wxLog_GetTraceMasks" () As wxArrayString Ptr
Declare Sub wxLog_SetTimestamp WXCALL Alias "wxLog_SetTimestamp" (ts As wxString Ptr)
Declare Function wxLog_GetVerbose WXCALL Alias "wxLog_GetVerbose" () As wxBool
Declare Function xLog_GetTraceMask WXCALL Alias "xLog_GetTraceMask" () As wxTraceMask
Declare Function wxLog_IsAllowedTraceMask WXCALL Alias "wxLog_IsAllowedTraceMask" (mask As wxString Ptr) As wxBool
Declare Function wxLog_GetLogLevel WXCALL Alias "wxLog_GetLogLevel" () As wxLogLevel
Declare Function wxLog_GetTimestamp WXCALL Alias "wxLog_GetTimestamp" () As wxString Ptr
Declare Sub wxLog_Log_Function WXCALL Alias "wxLog_Log_Function" (iWhat As wxInt, szFormat As wxString Ptr)

#EndIf ' __log_bi__




