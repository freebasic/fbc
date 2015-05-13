#Ifndef __clientdata_bi__
#Define __clientdata_bi__

#Include Once "common.bi"

' class wxStringClientData
Declare Function wxStringClientData_ctor WXCALL Alias "wxStringClientData_ctor" (pData As wxString Ptr) As wxStringClientData Ptr
Declare Sub wxClientData_dtor WXCALL Alias "wxClientData_dtor" (self As wxStringClientData Ptr)
Declare Sub wxClientData_RegisterDisposable WXCALL Alias "wxClientData_RegisterDisposable" (self As wxStringClientData Ptr,on_Dispose As Virtual_Dispose)
Declare Sub wxStringClientData_dtor WXCALL Alias "wxStringClientData_dtor" (self As wxStringClientData Ptr)
Declare Sub wxStringClientData_SetData WXCALL Alias "wxStringClientData_SetData" (self As wxStringClientData Ptr, pData As wxString Ptr)
Declare Function wxStringClientData_GetData WXCALL Alias "wxStringClientData_GetData" (self As wxStringClientData Ptr) As wxString Ptr

#EndIf ' __clientdata_bi__

