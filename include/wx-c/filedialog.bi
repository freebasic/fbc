#Ifndef __filedialog_bi__
#Define __filedialog_bi__

#Include Once "common.bi"

' class wxFileDialog
Declare Function wxFileDialog_ctor WXCALL Alias "wxFileDialog_ctor" ( _
					   parent         As wxWindow Ptr, _
                       messageArg     As wxString Ptr, _
                       defaultDirArg  As wxString Ptr, _
                       defaultFileArg As wxString Ptr, _
                       wildcardArg    As wxString Ptr, _
                       style          As wxUInt, _
                       x              As wxInt, _
                       y              As wxInt) As wxFileDialog Ptr
Declare Sub wxFileDialog_dtor WXCALL Alias "wxFileDialog_dtor" (self As wxFileDialog Ptr)
Declare Function wxFileDialog_ShowModal WXCALL Alias "wxFileDialog_ShowModal" (self As wxFileDialog Ptr) As wxInt
Declare Sub wxFileDialog_SetDirectory WXCALL Alias "wxFileDialog_SetDirectory" (self As wxFileDialog Ptr, Directory As wxString Ptr)
Declare Function wxFileDialog_GetDirectory WXCALL Alias "wxFileDialog_GetDirectory" (self As wxFileDialog Ptr) As wxString Ptr
Declare Sub wxFileDialog_SetFilename WXCALL Alias "wxFileDialog_SetFilename" (self As wxFileDialog Ptr, filename As wxString Ptr)
Declare Function wxFileDialog_GetFilename WXCALL Alias "wxFileDialog_GetFilename" (self As wxFileDialog Ptr) As wxString Ptr
Declare Function wxFileDialog_GetFilenames WXCALL Alias "wxFileDialog_GetFilenames" (self As wxFileDialog Ptr) As wxArrayString Ptr
Declare Sub wxFileDialog_SetPath WXCALL Alias "wxFileDialog_SetPath" (self As wxFileDialog Ptr, path As wxString Ptr)
Declare Function wxFileDialog_GetPath WXCALL Alias "wxFileDialog_GetPath" (self As wxFileDialog Ptr) As wxString Ptr
Declare Function wxFileDialog_GetPaths WXCALL Alias "wxFileDialog_GetPaths" (self As wxFileDialog Ptr) As wxArrayString Ptr
Declare Sub wxFileDialog_SetFilterIndex WXCALL Alias "wxFileDialog_SetFilterIndex" (self As wxFileDialog Ptr, filterindex As wxInt)
Declare Function wxFileDialog_GetFilterIndex WXCALL Alias "wxFileDialog_GetFilterIndex" (self As wxFileDialog Ptr) As wxInt
Declare Sub wxFileDialog_SetMessage WXCALL Alias "wxFileDialog_SetMessage" (self As wxFileDialog Ptr, msg As wxString Ptr)
Declare Function wxFileDialog_GetMessage WXCALL Alias "wxFileDialog_GetMessage" (self As wxFileDialog Ptr) As wxString Ptr
Declare Function wxFileDialog_GetWildcard WXCALL Alias "wxFileDialog_GetWildcard" (self As wxFileDialog Ptr) As wxString Ptr
Declare Sub wxFileDialog_SetWildcard WXCALL Alias "wxFileDialog_SetWildcard" (self As wxFileDialog Ptr, wildcard As wxString Ptr)
Declare Sub wxFileDialog_SetStyle WXCALL Alias "wxFileDialog_SetStyle" (self As wxFileDialog Ptr, style As wxUInt)
Declare Function wxFileDialog_GetStyle WXCALL Alias "wxFileDialog_GetStyle" (self As wxFileDialog Ptr) As wxUInt

#EndIf ' __filedialog_bi__

