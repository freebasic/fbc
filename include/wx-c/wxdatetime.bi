#Ifndef __wxdatetime_bi__
#Define __wxdatetime_bi__

#Include Once "common.bi"

' class wxDateTime
Declare Function wxDateTime_ctor WXCALL Alias "wxDateTime_ctor" () As wxDateTime Ptr
Declare Sub wxDateTime_dtor WXCALL Alias "wxDateTime_dtor" (self As wxDateTime Ptr)
Declare Sub wxDateTime_Set WXCALL Alias "wxDateTime_Set" (self As wxDateTime Ptr, d As UShort, m As wxInt, y As wxInt, h As UShort, m As UShort, s As UShort, ms As UShort)
Declare Function wxDateTime_GetYear WXCALL Alias "wxDateTime_GetYear" (self As wxDateTime Ptr) As UShort
Declare Function wxDateTime_GetMonth WXCALL Alias "wxDateTime_GetMonth" (self As wxDateTime Ptr) As wxInt
Declare Function wxDateTime_GetDay WXCALL Alias "wxDateTime_GetDay" (self As wxDateTime Ptr) As UShort
Declare Function wxDateTime_GetHour WXCALL Alias "wxDateTime_GetHour" (self As wxDateTime Ptr) As UShort
Declare Function wxDateTime_GetMinute WXCALL Alias "wxDateTime_GetMinute" (self As wxDateTime Ptr) As UShort
Declare Function wxDateTime_GetSecond WXCALL Alias "wxDateTime_GetSecond" (self As wxDateTime Ptr) As UShort
Declare Function wxDateTime_GetMillisecond WXCALL Alias "wxDateTime_GetMillisecond" (self As wxDateTime Ptr) As UShort

#EndIf ' __wxdatetime_bi__


