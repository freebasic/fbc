#Ifndef __dataformat_bi__
#Define __dataformat_bi__

#Include Once "common.bi"

' class wxDataFormat
Declare Function wxDataFormat_ctor WXCALL Alias "wxDataFormat_ctor" () As wxDataFormat Ptr
Declare Function wxDataFormat_ctorByType WXCALL Alias "wxDataFormat_ctorByType" (typ As wxDataFormatId) As wxDataFormat Ptr
Declare Function wxDataFormat_ctorById WXCALL Alias "wxDataFormat_ctorById" (id As wxString Ptr) As wxDataFormat Ptr
Declare Sub wxDataFormat_dtor WXCALL Alias "wxDataFormat_dtor" (self As wxDataFormat Ptr)
Declare Function wxDataFormat_GetId WXCALL Alias "wxDataFormat_GetId" (self As wxDataFormat Ptr) As wxString Ptr
Declare Sub wxDataFormat_SetId WXCALL Alias "wxDataFormat_SetId" (self As wxDataFormat Ptr, id As wxString Ptr)
Declare Function wxDataFormat_GetType WXCALL Alias "wxDataFormat_GetType" (self As wxDataFormat Ptr) As wxDataFormatId
Declare Sub wxDataFormat_SetType WXCALL Alias "wxDataFormat_SetType" (self As wxDataFormat Ptr, typ As wxDataFormatId)


#EndIf ' __dataformat_bi__

