''
''
'' calendarctrl -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_calendarctrl_bi__
#define __wxc_calendarctrl_bi__

#include once "wx.bi"


declare function wxCalendarCtrl alias "wxCalendarCtrl_ctor" () as wxCalendarCtrl ptr
declare function wxCalendarCtrl_Create (byval self as wxCalendarCtrl ptr, byval parent as wxWindow ptr, byval id as wxWindowID, byval date as wxDateTime ptr, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval name as zstring ptr) as integer
declare function wxCalendarCtrl_SetDate (byval self as wxCalendarCtrl ptr, byval date as wxDateTime ptr) as integer
declare function wxCalendarCtrl_GetDate (byval self as wxCalendarCtrl ptr) as wxDateTime ptr
declare function wxCalendarCtrl_SetLowerDateLimit (byval self as wxCalendarCtrl ptr, byval date as wxDateTime ptr) as integer
declare function wxCalendarCtrl_GetLowerDateLimit (byval self as wxCalendarCtrl ptr) as wxDateTime ptr
declare function wxCalendarCtrl_SetUpperDateLimit (byval self as wxCalendarCtrl ptr, byval date as wxDateTime ptr) as integer
declare function wxCalendarCtrl_GetUpperDateLimit (byval self as wxCalendarCtrl ptr) as wxDateTime ptr
declare function wxCalendarCtrl_SetDateRange (byval self as wxCalendarCtrl ptr, byval lowerdate as wxDateTime ptr, byval upperdate as wxDateTime ptr) as integer
declare sub wxCalendarCtrl_EnableYearChange (byval self as wxCalendarCtrl ptr, byval enable as integer)
declare sub wxCalendarCtrl_EnableMonthChange (byval self as wxCalendarCtrl ptr, byval enable as integer)
declare sub wxCalendarCtrl_EnableHolidayDisplay (byval self as wxCalendarCtrl ptr, byval display as integer)
declare sub wxCalendarCtrl_SetHeaderColours (byval self as wxCalendarCtrl ptr, byval colFg as wxColour ptr, byval colBg as wxColour ptr)
declare function wxCalendarCtrl_GetHeaderColourFg (byval self as wxCalendarCtrl ptr) as wxColour ptr
declare function wxCalendarCtrl_GetHeaderColourBg (byval self as wxCalendarCtrl ptr) as wxColour ptr
declare sub wxCalendarCtrl_SetHighlightColours (byval self as wxCalendarCtrl ptr, byval colFg as wxColour ptr, byval colBg as wxColour ptr)
declare function wxCalendarCtrl_GetHighlightColourFg (byval self as wxCalendarCtrl ptr) as wxColour ptr
declare function wxCalendarCtrl_GetHighlightColourBg (byval self as wxCalendarCtrl ptr) as wxColour ptr
declare sub wxCalendarCtrl_SetHolidayColours (byval self as wxCalendarCtrl ptr, byval colFg as wxColour ptr, byval colBg as wxColour ptr)
declare function wxCalendarCtrl_GetHolidayColourFg (byval self as wxCalendarCtrl ptr) as wxColour ptr
declare function wxCalendarCtrl_GetHolidayColourBg (byval self as wxCalendarCtrl ptr) as wxColour ptr
declare function wxCalendarCtrl_GetAttr (byval self as wxCalendarCtrl ptr, byval day as integer) as wxCalendarDateAttr ptr
declare sub wxCalendarCtrl_SetAttr (byval self as wxCalendarCtrl ptr, byval day as integer, byval attr as wxCalendarDateAttr ptr)
declare sub wxCalendarCtrl_SetHoliday (byval self as wxCalendarCtrl ptr, byval day as integer)
declare sub wxCalendarCtrl_ResetAttr (byval self as wxCalendarCtrl ptr, byval day as integer)
declare function wxCalendarCtrl_HitTest (byval self as wxCalendarCtrl ptr, byval pos as wxPoint ptr, byval date as wxDateTime ptr, byval wd as integer ptr) as wxCalendarHitTestResult

declare function wxCalendarDateAttr alias "wxCalendarDateAttr_ctor" () as wxCalendarDateAttr ptr
declare sub wxCalendarDateAttr_dtor (byval self as wxCalendarDateAttr ptr)
declare sub wxCalendarDateAttr_RegisterDisposable (byval self as _CalendarDateAttr ptr, byval onDispose as Virtual_Dispose)
declare sub wxCalendarDateAttr_SetTextColour (byval self as wxCalendarDateAttr ptr, byval colText as wxColour ptr)
declare sub wxCalendarDateAttr_SetBackgroundColour (byval self as wxCalendarDateAttr ptr, byval colBack as wxColour ptr)
declare sub wxCalendarDateAttr_SetBorderColour (byval self as wxCalendarDateAttr ptr, byval col as wxColour ptr)
declare sub wxCalendarDateAttr_SetFont (byval self as wxCalendarDateAttr ptr, byval font as wxFont ptr)
declare sub wxCalendarDateAttr_SetBorder (byval self as wxCalendarDateAttr ptr, byval border as wxCalendarDateBorder)
declare sub wxCalendarDateAttr_SetHoliday (byval self as wxCalendarDateAttr ptr, byval holiday as integer)
declare function wxCalendarDateAttr_HasTextColour (byval self as wxCalendarDateAttr ptr) as integer
declare function wxCalendarDateAttr_HasBackgroundColour (byval self as wxCalendarDateAttr ptr) as integer
declare function wxCalendarDateAttr_HasBorderColour (byval self as wxCalendarDateAttr ptr) as integer
declare function wxCalendarDateAttr_HasFont (byval self as wxCalendarDateAttr ptr) as integer
declare function wxCalendarDateAttr_HasBorder (byval self as wxCalendarDateAttr ptr) as integer
declare function wxCalendarDateAttr_IsHoliday (byval self as wxCalendarDateAttr ptr) as integer
declare function wxCalendarDateAttr_GetTextColour (byval self as wxCalendarDateAttr ptr) as wxColour ptr
declare function wxCalendarDateAttr_GetBackgroundColour (byval self as wxCalendarDateAttr ptr) as wxColour ptr
declare function wxCalendarDateAttr_GetBorderColour (byval self as wxCalendarDateAttr ptr) as wxColour ptr
declare function wxCalendarDateAttr_GetFont (byval self as wxCalendarDateAttr ptr) as wxFont ptr
declare function wxCalendarDateAttr_GetBorder (byval self as wxCalendarDateAttr ptr) as wxCalendarDateBorder
declare function wxCalendarEvent alias "wxCalendarEvent_ctor" (byval cal as wxCalendarCtrl ptr, byval type as wxEventType) as wxCalendarEvent ptr
declare function wxCalendarEvent_GetDate (byval self as wxCalendarEvent ptr) as wxDateTime ptr
declare function GetWeekDay (byval self as wxCalendarEvent ptr) as integer

#endif
