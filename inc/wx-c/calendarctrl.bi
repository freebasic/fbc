#Ifndef __calendarctrl_bi__
#Define __calendarctrl_bi__

#Include Once "common.bi"

Declare Function wxCalendarCtrl_ctor WXCALL Alias "wxCalendarCtrl_ctor" () As wxCalendarCtrl Ptr
Declare Function wxCalendarCtrl_Create WXCALL Alias "wxCalendarCtrl_Create" ( _
						   self    As wxCalendarCtrl Ptr     , _
                           parent  As wxWindow       Ptr     , _
                           id      As  wxWindowID         = -1, _
                           pDate   As wxDateTime     Ptr     , _
                           x       As  wxInt              = -1, _
                           y       As  wxInt              = -1, _
                           w       As  wxInt              = -1, _
                           h       As  wxInt              = -1, _
                           style   As  wxUInt             =  0, _
                           nameArg As wxString       Ptr = WX_NULL) As wxBool
Declare Function wxCalendarCtrl_SetDate WXCALL Alias "wxCalendarCtrl_SetDate" (self As wxCalendarCtrl Ptr, pDate As wxDateTime Ptr) As wxBool
Declare Function wxCalendarCtrl_GetDate WXCALL Alias "wxCalendarCtrl_GetDate" (self As wxCalendarCtrl Ptr) As wxDatetime Ptr
Declare Function wxCalendarCtrl_SetLowerDateLimit WXCALL Alias "wxCalendarCtrl_SetLowerDateLimit" (self As wxCalendarCtrl Ptr, pDate As wxDateTime Ptr) As wxBool
Declare Function wxCalendarCtrl_GetLowerDateLimit WXCALL Alias "wxCalendarCtrl_GetLowerDateLimit" (self As wxCalendarCtrl Ptr) As wxDatetime Ptr
Declare Function wxCalendarCtrl_SetUpperDateLimit WXCALL Alias "wxCalendarCtrl_SetUpperDateLimit" (self As wxCalendarCtrl Ptr, pDate As wxDateTime Ptr) As wxBool
Declare Function wxCalendarCtrl_GetUpperDateLimit WXCALL Alias "wxCalendarCtrl_GetUpperDateLimit" (self As wxCalendarCtrl Ptr) As wxDatetime Ptr
Declare Function wxCalendarCtrl_SetDateRange WXCALL Alias "wxCalendarCtrl_SetDateRange" (self As wxCalendarCtrl Ptr, lowerDate As wxDateTime Ptr, upperDate As wxDateTime Ptr) As wxBool
Declare Sub wxCalendarCtrl_EnableYearChange WXCALL Alias "wxCalendarCtrl_EnableYearChange" (self As wxCalendarCtrl Ptr, enable As wxBool)
Declare Sub wxCalendarCtrl_EnableMonthChange WXCALL Alias "wxCalendarCtrl_EnableMonthChange" (self As wxCalendarCtrl Ptr, enable As wxBool)
Declare Sub wxCalendarCtrl_EnableHolidayDisplay WXCALL Alias "wxCalendarCtrl_EnableHolidayDisplay" (self As wxCalendarCtrl Ptr, hdDisplay As wxBool)
Declare Sub wxCalendarCtrl_SetHeaderColours WXCALL Alias "wxCalendarCtrl_SetHeaderColours" (self As wxCalendarCtrl Ptr, fg As wxColour Ptr, bg As wxColour Ptr)
Declare Function wxCalendarCtrl_GetHeaderColourFg WXCALL Alias "wxCalendarCtrl_GetHeaderColourFg" (self As wxCalendarCtrl Ptr) As wxColour Ptr
Declare Function wxCalendarCtrl_GetHeaderColourBg WXCALL Alias "wxCalendarCtrl_GetHeaderColourBg" (self As wxCalendarCtrl Ptr) As wxColour Ptr
Declare Sub wxCalendarCtrl_SetHighlightColours WXCALL Alias "wxCalendarCtrl_SetHighlightColours" (self As wxCalendarCtrl Ptr, fg As wxColour Ptr, bg As wxColour Ptr)
Declare Function wxCalendarCtrl_GetHighlightColourFg WXCALL Alias "wxCalendarCtrl_GetHighlightColourFg" (self As wxCalendarCtrl Ptr) As wxColour Ptr
Declare Function wxCalendarCtrl_GetHighlightColourBg WXCALL Alias "wxCalendarCtrl_GetHighlightColourBg" (self As wxCalendarCtrl Ptr) As wxColour Ptr
Declare Sub wxCalendarCtrl_SetHolidayColours WXCALL Alias "wxCalendarCtrl_SetHolidayColours" (self As wxCalendarCtrl Ptr, fg As wxColour Ptr, bg As wxColour Ptr)
Declare Function wxCalendarCtrl_GetHolidayColourFg WXCALL Alias "wxCalendarCtrl_GetHolidayColourFg" (self As wxCalendarCtrl Ptr) As wxColour Ptr
Declare Function wxCalendarCtrl_GetHolidayColourBg WXCALL Alias "wxCalendarCtrl_GetHolidayColourBg" (self As wxCalendarCtrl Ptr) As wxColour Ptr
Declare Function wxCalendarCtrl_GetAttr WXCALL Alias "wxCalendarCtrl_GetAttr" (self As wxCalendarCtrl Ptr,iDay As wxInt) As wxCalendarDateAttr Ptr
Declare Sub wxCalendarCtrl_SetAttr WXCALL Alias "wxCalendarCtrl_SetAttr" (self As wxCalendarCtrl Ptr,iDay As wxInt, attr  As wxCalendarDateAttr Ptr)
Declare Sub wxCalendarCtrl_SetHoliday WXCALL Alias "wxCalendarCtrl_SetHoliday" (self As wxCalendarCtrl Ptr,iDay As wxInt)
Declare Sub wxCalendarCtrl_ResetAttr WXCALL Alias "wxCalendarCtrl_ResetAttr" (self As wxCalendarCtrl Ptr,iDay As wxInt)
Declare Function wxCalendarCtrl_HitTest WXCALL Alias "wxCalendarCtrl_HitTest" (self As wxCalendarCtrl Ptr, x As wxInt, y As wxInt, pDate As wxDateTime Ptr, pWeekDay As wxWeekDay Ptr) As wxCalendarHitTestResult
Declare Function wxCalendarDateAttr_ctor WXCALL Alias "wxCalendarDateAttr_ctor" () As wxCalendarDateAttr Ptr
Declare Function wxCalendarDateAttr_ctor2 WXCALL Alias "wxCalendarDateAttr_ctor2" (colText As wxColour Ptr, colBack As wxColour Ptr, colBorder As wxColour Ptr, fontArg As wxFont Ptr, border As wxCalendarDateBorder) As wxCalendarDateAttr Ptr
Declare Function wxCalendarDateAttr_ctor3 WXCALL Alias "wxCalendarDateAttr_ctor3" (border As wxCalendarDateBorder,colBorder As wxColour Ptr) As wxCalendarDateAttr Ptr
Declare Sub wxCalendarDateAttr_SetTextColour WXCALL Alias "wxCalendarDateAttr_SetTextColour" (self As wxCalendarDateAttr Ptr, colText As wxColour Ptr)
Declare Sub wxCalendarDateAttr_SetBackgroundColour WXCALL Alias "wxCalendarDateAttr_SetBackgroundColour" (self As wxCalendarDateAttr Ptr, colBack As wxColour Ptr)
Declare Sub wxCalendarDateAttr_SetBorderColour WXCALL Alias "wxCalendarDateAttr_SetBorderColour" (self As wxCalendarDateAttr Ptr, col As wxColour Ptr)
Declare Sub wxCalendarDateAttr_SetFont WXCALL Alias "wxCalendarDateAttr_SetFont" (self As wxCalendarDateAttr Ptr, font As wxFont Ptr)
Declare Sub wxCalendarDateAttr_SetBorder WXCALL Alias "wxCalendarDateAttr_SetBorder" (self As wxCalendarDateAttr Ptr, border As wxCalendarDateBorder)
Declare Sub wxCalendarDateAttr_SetHoliday WXCALL Alias "wxCalendarDateAttr_SetHoliday" (self As wxCalendarDateAttr Ptr, hd As wxBool)
Declare Function wxCalendarDateAttr_HasTextColour WXCALL Alias "wxCalendarDateAttr_HasTextColour" (self As wxCalendarDateAttr Ptr) As wxBool
Declare Function wxCalendarDateAttr_HasBackgroundColour WXCALL Alias "wxCalendarDateAttr_HasBackgroundColour" (self As wxCalendarDateAttr Ptr) As wxBool
Declare Function wxCalendarDateAttr_HasBorderColour WXCALL Alias "wxCalendarDateAttr_HasBorderColour" (self As wxCalendarDateAttr Ptr) As wxBool
Declare Function wxCalendarDateAttr_HasFont WXCALL Alias "wxCalendarDateAttr_HasFont" (self As wxCalendarDateAttr Ptr) As wxBool
Declare Function wxCalendarDateAttr_HasBorder WXCALL Alias "wxCalendarDateAttr_HasBorder" (self As wxCalendarDateAttr Ptr) As wxBool
Declare Function wxCalendarDateAttr_IsHoliday WXCALL Alias "wxCalendarDateAttr_IsHoliday" (self As wxCalendarDateAttr Ptr) As wxBool
Declare Function wxCalendarDateAttr_GetTextColour WXCALL Alias "wxCalendarDateAttr_GetTextColour" (self As wxCalendarDateAttr Ptr) As wxColour Ptr
Declare Function wxCalendarDateAttr_GetBackgroundColour WXCALL Alias "wxCalendarDateAttr_GetBackgroundColour" (self As wxCalendarDateAttr Ptr) As wxColour Ptr
Declare Function wxCalendarDateAttr_GetBorderColour WXCALL Alias "wxCalendarDateAttr_GetBorderColour" (self As wxCalendarDateAttr Ptr) As wxColour Ptr
Declare Function wxCalendarDateAttr_GetFont WXCALL Alias "wxCalendarDateAttr_GetFont" (self As wxCalendarDateAttr Ptr) As wxFont Ptr
Declare Function wxCalendarDateAttr_GetBorder WXCALL Alias "wxCalendarDateAttr_GetBorder" (self As wxCalendarDateAttr Ptr) As wxCalendarDateBorder
Declare Function wxDateEvent_GetDate WXCALL Alias "wxDateEvent_GetDate" (self As wxDateEvent Ptr) As wxDatetime Ptr
Declare Function wxCalendarEvent_ctor WXCALL Alias "wxCalendarEvent_ctor" (self As wxCalendarCtrl Ptr, typ As wxEventType) As wxCalendarEvent Ptr
Declare Function GetWeekDay WXCALL Alias "GetWeekDay" (self As wxCalendarEvent Ptr) As wxWeekDay

#EndIf ' __calendarctrl_bi__

