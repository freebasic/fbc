#Ifndef __object_bi__
#Define __object_bi__

#Include Once "common.bi"

Declare Sub wxObject_dtor WXCALL Alias "wxObject_dtor" (self As wxObject Ptr)
Declare Function wxObject_GetClassInfo WXCALL Alias "wxObject_GetClassInfo" (obj As wxObject Ptr) As wxClassInfo Ptr
Declare Function wxClassInfo_GetName WXCALL Alias "wxClassInfo_GetName" (self As wxClassInfo Ptr) As wxString Ptr
Declare Function wxClassInfo_GetBaseClassName1 WXCALL Alias "wxClassInfo_GetBaseClassName1" (self As wxClassInfo Ptr) As wxString Ptr
Declare Function wxClassInfo_GetBaseClassName2 WXCALL Alias "wxClassInfo_GetBaseClassName2" (self As wxClassInfo Ptr) As wxString Ptr
Declare Function wxClassInfo_GetSize WXCALL Alias "wxClassInfo_GetSize" (self As wxClassInfo Ptr) As wxInt

' utils
Declare Function wxObject_GetTypeName WXCALL Alias "wxObject_GetTypeName" (obj As wxObject Ptr) As wxString Ptr
Declare Function wxGetTranslation_func WXCALL Alias "wxGetTranslation_func" (t As wxString Ptr) As wxString Ptr

#EndIf

