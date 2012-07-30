#Ifndef __dirdialog_bi__
#Define __dirdialog_bi__

#Include Once "common.bi"

' class wxDirDialog
Declare Function wxDirDialog_ctor WXCALL Alias "wxDirDialog_ctor" ( _
					  parent     As wxWindow Ptr     , _
                      messageArg As wxString Ptr     , _
                      pathArg    As wxString Ptr     , _
                      style      As  wxUInt       =  0, _
                      x          As  wxInt        = -1, _
                      y          As  wxInt        = -1, _
                      w          As  wxInt        = -1, _
                      h          As  wXInt        = -1, _
                      nameArg    As wxString Ptr = WX_NULL) As wxDirDialog Ptr
Declare Sub wxDirDialog_SetStyle WXCALL Alias "wxDirDialog_SetStyle" (self As wxDirDialog Ptr, style As wxUint)
Declare Function wxDirDialog_GetStyle WXCALL Alias "wxDirDialog_GetStyle" (self As wxDirDialog Ptr) As wxUInt
Declare Sub wxDirDialog_SetMessage WXCALL Alias "wxDirDialog_SetMessage" (self As wxDirDialog Ptr, msg As wxString Ptr)
Declare Function wxDirDialog_GetMessage WXCALL Alias "wxDirDialog_GetMessage" (self As wxDirDialog Ptr) As wxString Ptr
Declare Sub wxDirDialog_SetPath WXCALL Alias "wxDirDialog_SetPath" (self As wxDirDialog Ptr, path As wxString Ptr)
Declare Function wxDirDialog_GetPath WXCALL Alias "wxDirDialog_GetPath" (self As wxDirDialog Ptr)  As wxString Ptr
Declare Function wxDirDialog_ShowModal WXCALL Alias "wxDirDialog_ShowModal" (self As wxDirDialog Ptr) As wxInt

#EndIf ' __dirdialog_bi__

