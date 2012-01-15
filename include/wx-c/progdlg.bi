#Ifndef __progdlg_bi__
#Define __progdlg_bi__

#Include Once "common.bi"

Declare Function wxProgressDialog_ctor WXCALL Alias "wxProgressDialog_ctor" (titleArg As wxString Ptr, msgArg As wxString Ptr, maximum As wxInt, parent As wxWindow Ptr, style As wxUInt) As wxProgressDialog Ptr
Declare Sub wxProgressDialog_dtor WXCALL Alias "wxProgressDialog_dtor" (self As wxProgressDialog Ptr)
Declare Function wxProgressDialog_Update WXCALL Alias "wxProgressDialog_Update" (self As wxProgressDialog Ptr, value As wxInt, newmsg As wxString Ptr) As wxBool
Declare Sub wxProgressDialog_Resume WXCALL Alias "wxProgressDialog_Resume" (self As wxProgressDialog Ptr)
Declare Function wxProgressDialog_Show WXCALL Alias "wxProgressDialog_Show" (self As wxProgressDialog Ptr, show As wxBool) As wxBool

#EndIf ' __progdlg_bi__


