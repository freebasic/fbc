' remember:
' this file is far from finished...
'
#ifdef __FB_WIN32__
#inclib "libwx-c"
#elseif defined(__FB_LINUX__)
#inclib "wx-c"
#else
#error Platform not supported!
#endif
'$include: "wxdefs.bi"
'because i'm lazy...

' normally flag value &h1000 is free, but without &h1000 
' there is no close button (X) so I named it wxCLOSE_BOX ... (by fsw)
const wxCLOSE_BOX             = &h1000  

'function protos auto-genned by dumbledore, aka the unknown qb programmer :P
declare function wxAcceleratorEntry_ctor cdecl alias "wxAcceleratorEntry_ctor" (byval flags as integer,byval keyCode as integer,byval cmd as integer,byval item as integer) as integer
declare function wxAcceleratorEntry_RegisterDisposable cdecl alias "wxAcceleratorEntry_RegisterDisposable" (byval self as integer,byval onDispose as integer) as integer
declare function wxAcceleratorEntry_dtor cdecl alias "wxAcceleratorEntry_dtor" (byval self as integer) as integer
declare function wxAcceleratorEntry_Set cdecl alias "wxAcceleratorEntry_Set" (byval self as integer,byval flags as integer,byval keyCode as integer,byval cmd as integer,byval item as integer) as integer
declare function wxAcceleratorEntry_SetMenuItem cdecl alias "wxAcceleratorEntry_SetMenuItem" (byval self as integer,byval item as integer) as integer
declare function wxAcceleratorEntry_GetFlags cdecl alias "wxAcceleratorEntry_GetFlags" (byval self as integer) as integer
declare function wxAcceleratorEntry_GetKeyCode cdecl alias "wxAcceleratorEntry_GetKeyCode" (byval self as integer) as integer
declare function wxAcceleratorEntry_GetCommand cdecl alias "wxAcceleratorEntry_GetCommand" (byval self as integer) as integer
declare function wxAcceleratorEntry_GetMenuItem cdecl alias "wxAcceleratorEntry_GetMenuItem" (byval self as integer) as integer
declare function wxAcceleratorEntry_GetAccelFromString cdecl alias "wxAcceleratorEntry_GetAccelFromString" (byval label as string) as integer
declare function wxAcceleratorTable_ctor cdecl alias "wxAcceleratorTable_ctor" () as integer
declare function wxAcceleratorTable_Ok cdecl alias "wxAcceleratorTable_Ok" (byval self as integer) as integer
declare function wxActivateEvent_ctor cdecl alias "wxActivateEvent_ctor" (byval type as integer) as integer
declare function wxActivateEvent_GetActive cdecl alias "wxActivateEvent_GetActive" (byval self as integer) as integer
declare function wxCreateApp cdecl alias "wxCreateApp" () as integer
declare function wxApp_ctor cdecl alias "wxApp_ctor" () as integer
declare function wxApp_RegisterVirtual cdecl alias "wxApp_RegisterVirtual" (byval self as integer,byval onInit as integer,byval onExit as integer) as integer
declare function wxApp_OnInit cdecl alias "wxApp_OnInit" (byval self as integer) as integer
declare function wxApp_OnExit cdecl alias "wxApp_OnExit" (byval self as integer) as integer
declare function wxApp_GetVendorName cdecl alias "wxApp_GetVendorName" (byval self as integer) as byte ptr
declare function wxApp_SetVendorName cdecl alias "wxApp_SetVendorName" (byval self as integer,byval name as string) as integer
declare function wxApp_GetAppName cdecl alias "wxApp_GetAppName" (byval self as integer) as byte ptr
declare function wxApp_SetAppName cdecl alias "wxApp_SetAppName" (byval self as integer,byval name as string) as integer
declare function wxApp_SafeYield cdecl alias "wxApp_SafeYield" (byval win as integer,byval onlyIfNeeded as integer) as integer
declare function wxApp_Yield cdecl alias "wxApp_Yield" (byval self as integer,byval onlyIfNeeded as integer) as integer
declare function wxApp_WakeUpIdle cdecl alias "wxApp_WakeUpIdle" () as integer
declare function wxApp_Run cdecl alias "wxApp_Run" (byval argc as integer,byval argv as byte ptr ptr) as integer
declare function GetArtId cdecl alias "GetArtId" (byval id as integer) as integer
declare function GetArtClient cdecl alias "GetArtClient" (byval id as integer) as integer
declare function wxArtProvider_GetBitmap cdecl alias "wxArtProvider_GetBitmap" (byval artid as integer,byval artclient as integer,byval size as integer) as integer
declare function wxArtProvider_GetIcon cdecl alias "wxArtProvider_GetIcon" (byval artid as integer,byval artclient as integer,byval size as integer) as integer
declare function wxBitmap_ctor cdecl alias "wxBitmap_ctor" () as integer
declare function wxBitmap_ctorByImage cdecl alias "wxBitmap_ctorByImage" (byval image as integer,byval depth as integer) as integer
declare function wxBitmap_ctorByName cdecl alias "wxBitmap_ctorByName" (byval name as string,byval type as integer) as integer
declare function wxBitmap_ctorBySize cdecl alias "wxBitmap_ctorBySize" (byval width as integer,byval height as integer,byval depth as integer) as integer
declare function wxBitmap_ctorByBitmap cdecl alias "wxBitmap_ctorByBitmap" (byval bitmap as integer) as integer
declare function wxBitmap_ConvertToImage cdecl alias "wxBitmap_ConvertToImage" (byval self as integer) as integer
declare function wxBitmap_GetHeight cdecl alias "wxBitmap_GetHeight" (byval self as integer) as integer
declare function wxBitmap_SetHeight cdecl alias "wxBitmap_SetHeight" (byval self as integer,byval height as integer) as integer
declare function wxBitmap_GetWidth cdecl alias "wxBitmap_GetWidth" (byval self as integer) as integer
declare function wxBitmap_SetWidth cdecl alias "wxBitmap_SetWidth" (byval self as integer,byval width as integer) as integer
declare function wxBitmap_LoadFile cdecl alias "wxBitmap_LoadFile" (byval self as integer,byval name as string,byval type as integer) as integer
declare function wxBitmap_SaveFile cdecl alias "wxBitmap_SaveFile" (byval self as integer,byval name as string,byval type as integer,byval palette as integer) as integer
declare function wxBitmap_Ok cdecl alias "wxBitmap_Ok" (byval self as integer) as integer
declare function wxBitmap_GetDepth cdecl alias "wxBitmap_GetDepth" (byval self as integer) as integer
declare function wxBitmap_SetDepth cdecl alias "wxBitmap_SetDepth" (byval self as integer,byval depth as integer) as integer
declare function wxBitmap_GetSubBitmap cdecl alias "wxBitmap_GetSubBitmap" (byval self as integer,byval rect as integer) as integer
declare function wxBitmap_GetMask cdecl alias "wxBitmap_GetMask" (byval self as integer) as integer
declare function wxBitmap_SetMask cdecl alias "wxBitmap_SetMask" (byval self as integer,byval mask as integer) as integer
declare function wxBitmap_GetPalette cdecl alias "wxBitmap_GetPalette" (byval self as integer) as integer
declare function wxBitmap_GetColourMap cdecl alias "wxBitmap_GetColourMap" (byval self as integer) as integer
declare function wxBitmap_CopyFromIcon cdecl alias "wxBitmap_CopyFromIcon" (byval self as integer,byval icon as integer) as integer
declare function wxMask_ctor cdecl alias "wxMask_ctor" () as integer
declare function wxMask_ctorByBitmpaColour cdecl alias "wxMask_ctorByBitmpaColour" (byval bitmap as integer,byval colour as integer) as integer
declare function wxMask_ctorByBitmapIndex cdecl alias "wxMask_ctorByBitmapIndex" (byval bitmap as integer,byval paletteIndex as integer) as integer
declare function wxMask_ctorByBitmap cdecl alias "wxMask_ctorByBitmap" (byval bitmap as integer) as integer
declare function wxMask_CreateByBitmapColour cdecl alias "wxMask_CreateByBitmapColour" (byval self as integer,byval bitmap as integer,byval colour as integer) as integer
declare function wxMask_CreateByBitmapIndex cdecl alias "wxMask_CreateByBitmapIndex" (byval self as integer,byval bitmap as integer,byval paletteIndex as integer) as integer
declare function wxMask_CreateByBitmap cdecl alias "wxMask_CreateByBitmap" (byval self as integer,byval bitmap as integer) as integer
declare function wxBitmapButton_ctor cdecl alias "wxBitmapButton_ctor" () as integer
declare function wxBitmapButton_RegisterVirtual cdecl alias "wxBitmapButton_RegisterVirtual" (byval self as integer,byval onSetBitmap as integer) as integer
declare function wxBitmapButton_Create cdecl alias "wxBitmapButton_Create" (byval self as integer,byval parent as integer,byval id as integer,byval bitmap as integer,byval pos as integer,byval size as integer,byval style as long,byval validator as integer,byval name as string) as integer
declare function wxBitmapButton_OnSetBitmap cdecl alias "wxBitmapButton_OnSetBitmap" (byval self as integer) as integer
declare function wxBitmapButton_SetLabel cdecl alias "wxBitmapButton_SetLabel" (byval self as integer,byval label as string) as integer
declare function wxBitmapButton_GetLabel cdecl alias "wxBitmapButton_GetLabel" (byval self as integer) as byte ptr
declare function wxBitmapButton_Enable cdecl alias "wxBitmapButton_Enable" (byval self as integer,byval enable as integer) as integer
declare function wxBitmapButton_SetBitmapLabel cdecl alias "wxBitmapButton_SetBitmapLabel" (byval self as integer,byval bitmap as integer) as integer
declare function wxBitmapButton_GetBitmapLabel cdecl alias "wxBitmapButton_GetBitmapLabel" (byval self as integer) as integer
declare function wxBitmapButton_SetBitmapSelected cdecl alias "wxBitmapButton_SetBitmapSelected" (byval self as integer,byval sel as integer) as integer
declare function wxBitmapButton_GetBitmapSelected cdecl alias "wxBitmapButton_GetBitmapSelected" (byval self as integer) as integer
declare function wxBitmapButton_SetBitmapDisabled cdecl alias "wxBitmapButton_SetBitmapDisabled" (byval self as integer,byval disabled as integer) as integer
declare function wxBitmapButton_GetBitmapDisabled cdecl alias "wxBitmapButton_GetBitmapDisabled" (byval self as integer) as integer
declare function wxBitmapButton_SetBitmapFocus cdecl alias "wxBitmapButton_SetBitmapFocus" (byval self as integer,byval focus as integer) as integer
declare function wxBitmapButton_GetBitmapFocus cdecl alias "wxBitmapButton_GetBitmapFocus" (byval self as integer) as integer
declare function wxBitmapButton_SetDefault cdecl alias "wxBitmapButton_SetDefault" (byval self as integer) as integer
declare function wxBitmapButton_SetMargins cdecl alias "wxBitmapButton_SetMargins" (byval self as integer,byval x as integer,byval y as integer) as integer
declare function wxBitmapButton_GetMarginX cdecl alias "wxBitmapButton_GetMarginX" (byval self as integer) as integer
declare function wxBitmapButton_GetMarginY cdecl alias "wxBitmapButton_GetMarginY" (byval self as integer) as integer
declare function wxBitmapButton_ApplyParentThemeBackground cdecl alias "wxBitmapButton_ApplyParentThemeBackground" (byval self as integer,byval colour as integer) as integer
declare function wxBoxSizer_RegisterVirtual cdecl alias "wxBoxSizer_RegisterVirtual" (byval self as integer,byval recalcSizes as integer,byval calcMin as integer) as integer
declare function wxBoxSizer_ctor cdecl alias "wxBoxSizer_ctor" (byval orient as integer) as integer
declare function wxBoxSizer_RegisterDisposable cdecl alias "wxBoxSizer_RegisterDisposable" (byval self as integer,byval onDispose as integer) as integer
declare function wxBoxSizer_RecalcSizes cdecl alias "wxBoxSizer_RecalcSizes" (byval self as integer) as integer
declare function wxBoxSizer_CalcMin cdecl alias "wxBoxSizer_CalcMin" (byval self as integer) as integer
declare function wxBoxSizer_GetOrientation cdecl alias "wxBoxSizer_GetOrientation" (byval self as integer) as integer
declare function wxBoxSizer_SetOrientation cdecl alias "wxBoxSizer_SetOrientation" (byval self as integer,byval orient as integer) as integer
declare function wxBrush_ctor cdecl alias "wxBrush_ctor" () as integer
declare function wxBrush_Ok cdecl alias "wxBrush_Ok" (byval self as integer) as integer
declare function wxBrush_GetStyle cdecl alias "wxBrush_GetStyle" (byval self as integer) as integer
declare function wxBrush_GetStipple cdecl alias "wxBrush_GetStipple" (byval self as integer) as integer
declare function wxBrush_SetColour cdecl alias "wxBrush_SetColour" (byval self as integer,byval col as integer) as integer
declare function wxBrush_GetColour cdecl alias "wxBrush_GetColour" (byval self as integer) as integer
declare function wxBrush_SetStyle cdecl alias "wxBrush_SetStyle" (byval self as integer,byval style as integer) as integer
declare function wxBrush_SetStipple cdecl alias "wxBrush_SetStipple" (byval self as integer,byval stipple as integer) as integer
declare function wxButton_ctor cdecl alias "wxButton_ctor" () as integer
declare function wxButton_Create cdecl alias "wxButton_Create" (byval self as integer,byval parent as integer,byval id as integer,byval label as string,byval pos as integer,byval size as integer,byval style as long,byval validator as integer,byval name as string) as integer
declare function wxButton_SetDefault cdecl alias "wxButton_SetDefault" (byval self as integer) as integer
declare function wxButton_GetDefaultSize cdecl alias "wxButton_GetDefaultSize" (byval size as integer) as integer
declare function wxButton_SetImageLabel cdecl alias "wxButton_SetImageLabel" (byval self as integer,byval bitmap as integer) as integer
declare function wxButton_SetImageMargins cdecl alias "wxButton_SetImageMargins" (byval self as integer,byval x as integer,byval y as integer) as integer
declare function wxButton_SetLabel cdecl alias "wxButton_SetLabel" (byval self as integer,byval label as string) as integer
declare function wxCalendarCtrl_ctor cdecl alias "wxCalendarCtrl_ctor" () as integer
declare function wxCalendarCtrl_Create cdecl alias "wxCalendarCtrl_Create" (byval self as integer,byval parent as integer,byval id as integer,byval date as integer,byval pos as integer,byval size as integer,byval style as integer,byval name as string) as integer
declare function wxCalendarCtrl_SetDate cdecl alias "wxCalendarCtrl_SetDate" (byval self as integer,byval date as integer) as integer
declare function wxCalendarCtrl_GetDate cdecl alias "wxCalendarCtrl_GetDate" (byval self as integer) as integer
declare function wxCalendarCtrl_SetLowerDateLimit cdecl alias "wxCalendarCtrl_SetLowerDateLimit" (byval self as integer,byval date as integer) as integer
declare function wxCalendarCtrl_GetLowerDateLimit cdecl alias "wxCalendarCtrl_GetLowerDateLimit" (byval self as integer) as integer
declare function wxCalendarCtrl_SetUpperDateLimit cdecl alias "wxCalendarCtrl_SetUpperDateLimit" (byval self as integer,byval date as integer) as integer
declare function wxCalendarCtrl_GetUpperDateLimit cdecl alias "wxCalendarCtrl_GetUpperDateLimit" (byval self as integer) as integer
declare function wxCalendarCtrl_SetDateRange cdecl alias "wxCalendarCtrl_SetDateRange" (byval self as integer,byval lowerdate as integer,byval upperdate as integer) as integer
declare function wxCalendarCtrl_EnableYearChange cdecl alias "wxCalendarCtrl_EnableYearChange" (byval self as integer,byval enable as integer) as integer
declare function wxCalendarCtrl_EnableMonthChange cdecl alias "wxCalendarCtrl_EnableMonthChange" (byval self as integer,byval enable as integer) as integer
declare function wxCalendarCtrl_EnableHolidayDisplay cdecl alias "wxCalendarCtrl_EnableHolidayDisplay" (byval self as integer,byval display as integer) as integer
declare function wxCalendarCtrl_SetHeaderColours cdecl alias "wxCalendarCtrl_SetHeaderColours" (byval self as integer,byval colFg as integer,byval colBg as integer) as integer
declare function wxCalendarCtrl_GetHeaderColourFg cdecl alias "wxCalendarCtrl_GetHeaderColourFg" (byval self as integer) as integer
declare function wxCalendarCtrl_GetHeaderColourBg cdecl alias "wxCalendarCtrl_GetHeaderColourBg" (byval self as integer) as integer
declare function wxCalendarCtrl_SetHighlightColours cdecl alias "wxCalendarCtrl_SetHighlightColours" (byval self as integer,byval colFg as integer,byval colBg as integer) as integer
declare function wxCalendarCtrl_GetHighlightColourFg cdecl alias "wxCalendarCtrl_GetHighlightColourFg" (byval self as integer) as integer
declare function wxCalendarCtrl_GetHighlightColourBg cdecl alias "wxCalendarCtrl_GetHighlightColourBg" (byval self as integer) as integer
declare function wxCalendarCtrl_SetHolidayColours cdecl alias "wxCalendarCtrl_SetHolidayColours" (byval self as integer,byval colFg as integer,byval colBg as integer) as integer
declare function wxCalendarCtrl_GetHolidayColourFg cdecl alias "wxCalendarCtrl_GetHolidayColourFg" (byval self as integer) as integer
declare function wxCalendarCtrl_GetHolidayColourBg cdecl alias "wxCalendarCtrl_GetHolidayColourBg" (byval self as integer) as integer
declare function wxCalendarCtrl_GetAttr cdecl alias "wxCalendarCtrl_GetAttr" (byval self as integer,byval day as integer) as integer
declare function wxCalendarCtrl_SetAttr cdecl alias "wxCalendarCtrl_SetAttr" (byval self as integer,byval day as integer,byval attr as integer) as integer
declare function wxCalendarCtrl_SetHoliday cdecl alias "wxCalendarCtrl_SetHoliday" (byval self as integer,byval day as integer) as integer
declare function wxCalendarCtrl_ResetAttr cdecl alias "wxCalendarCtrl_ResetAttr" (byval self as integer,byval day as integer) as integer
declare function wxCalendarDateAttr_ctor cdecl alias "wxCalendarDateAttr_ctor" () as integer
declare function wxCalendarDateAttr_dtor cdecl alias "wxCalendarDateAttr_dtor" (byval self as integer) as integer
declare function wxCalendarDateAttr_RegisterDisposable cdecl alias "wxCalendarDateAttr_RegisterDisposable" (byval self as integer,byval onDispose as integer) as integer
declare function wxCalendarDateAttr_SetTextColour cdecl alias "wxCalendarDateAttr_SetTextColour" (byval self as integer,byval colText as integer) as integer
declare function wxCalendarDateAttr_SetBackgroundColour cdecl alias "wxCalendarDateAttr_SetBackgroundColour" (byval self as integer,byval colBack as integer) as integer
declare function wxCalendarDateAttr_SetBorderColour cdecl alias "wxCalendarDateAttr_SetBorderColour" (byval self as integer,byval col as integer) as integer
declare function wxCalendarDateAttr_SetFont cdecl alias "wxCalendarDateAttr_SetFont" (byval self as integer,byval font as integer) as integer
declare function wxCalendarDateAttr_SetBorder cdecl alias "wxCalendarDateAttr_SetBorder" (byval self as integer,byval border as integer) as integer
declare function wxCalendarDateAttr_SetHoliday cdecl alias "wxCalendarDateAttr_SetHoliday" (byval self as integer,byval holiday as integer) as integer
declare function wxCalendarDateAttr_HasTextColour cdecl alias "wxCalendarDateAttr_HasTextColour" (byval self as integer) as integer
declare function wxCalendarDateAttr_HasBackgroundColour cdecl alias "wxCalendarDateAttr_HasBackgroundColour" (byval self as integer) as integer
declare function wxCalendarDateAttr_HasBorderColour cdecl alias "wxCalendarDateAttr_HasBorderColour" (byval self as integer) as integer
declare function wxCalendarDateAttr_HasFont cdecl alias "wxCalendarDateAttr_HasFont" (byval self as integer) as integer
declare function wxCalendarDateAttr_HasBorder cdecl alias "wxCalendarDateAttr_HasBorder" (byval self as integer) as integer
declare function wxCalendarDateAttr_IsHoliday cdecl alias "wxCalendarDateAttr_IsHoliday" (byval self as integer) as integer
declare function wxCalendarDateAttr_GetTextColour cdecl alias "wxCalendarDateAttr_GetTextColour" (byval self as integer) as integer
declare function wxCalendarDateAttr_GetBackgroundColour cdecl alias "wxCalendarDateAttr_GetBackgroundColour" (byval self as integer) as integer
declare function wxCalendarDateAttr_GetBorderColour cdecl alias "wxCalendarDateAttr_GetBorderColour" (byval self as integer) as integer
declare function wxCalendarDateAttr_GetFont cdecl alias "wxCalendarDateAttr_GetFont" (byval self as integer) as integer
declare function wxCalendarDateAttr_GetBorder cdecl alias "wxCalendarDateAttr_GetBorder" (byval self as integer) as integer
declare function wxCalendarEvent_ctor cdecl alias "wxCalendarEvent_ctor" (byval cal as integer,byval type as integer) as integer
declare function wxCalendarEvent_GetDate cdecl alias "wxCalendarEvent_GetDate" (byval self as integer) as integer
declare function wxCaret_ctor cdecl alias "wxCaret_ctor" () as integer
declare function wxCaret_dtor cdecl alias "wxCaret_dtor" (byval self as integer) as integer
declare function wxCaret_Create cdecl alias "wxCaret_Create" (byval self as integer,byval window as integer,byval width as integer,byval height as integer) as integer
declare function wxCaret_IsOk cdecl alias "wxCaret_IsOk" (byval self as integer) as integer
declare function wxCaret_IsVisible cdecl alias "wxCaret_IsVisible" (byval self as integer) as integer
declare function wxCaret_GetPosition cdecl alias "wxCaret_GetPosition" (byval self as integer,byval x as integer,byval y as integer) as integer
declare function wxCaret_GetSize cdecl alias "wxCaret_GetSize" (byval self as integer,byval width as integer,byval height as integer) as integer
declare function wxCaret_GetWindow cdecl alias "wxCaret_GetWindow" (byval self as integer) as integer
declare function wxCaret_SetSize cdecl alias "wxCaret_SetSize" (byval self as integer,byval width as integer,byval height as integer) as integer
declare function wxCaret_Move cdecl alias "wxCaret_Move" (byval self as integer,byval x as integer,byval y as integer) as integer
declare function wxCaret_Show cdecl alias "wxCaret_Show" (byval self as integer,byval show as integer) as integer
declare function wxCaret_Hide cdecl alias "wxCaret_Hide" (byval self as integer) as integer
declare function wxCaret_GetBlinkTime cdecl alias "wxCaret_GetBlinkTime" () as integer
declare function wxCaret_SetBlinkTime cdecl alias "wxCaret_SetBlinkTime" (byval milliseconds as integer) as integer
declare function wxCaretSuspend_ctor cdecl alias "wxCaretSuspend_ctor" (byval win as integer) as integer
declare function wxCaretSuspend_dtor cdecl alias "wxCaretSuspend_dtor" (byval self as integer) as integer
declare function wxCheckBox_ctor cdecl alias "wxCheckBox_ctor" () as integer
declare function wxCheckBox_Create cdecl alias "wxCheckBox_Create" (byval self as integer,byval parent as integer,byval id as integer,byval label as string,byval pos as integer,byval size as integer,byval style as integer,byval val as integer,byval name as string) as integer
declare function wxCheckBox_GetValue cdecl alias "wxCheckBox_GetValue" (byval self as integer) as integer
declare function wxCheckBox_SetValue cdecl alias "wxCheckBox_SetValue" (byval self as integer,byval state as integer) as integer
declare function wxCheckBox_IsChecked cdecl alias "wxCheckBox_IsChecked" (byval self as integer) as integer
declare function wxCheckBox_Get3StateValue cdecl alias "wxCheckBox_Get3StateValue" (byval self as integer) as integer
declare function wxCheckBox_Set3StateValue cdecl alias "wxCheckBox_Set3StateValue" (byval self as integer,byval state as integer) as integer
declare function wxCheckBox_Is3State cdecl alias "wxCheckBox_Is3State" (byval self as integer) as integer
declare function wxCheckBox_Is3rdStateAllowedForUser cdecl alias "wxCheckBox_Is3rdStateAllowedForUser" (byval self as integer) as integer
declare function wxChildFocusEvent_ctor cdecl alias "wxChildFocusEvent_ctor" (byval win as integer) as integer
declare function wxChildFocusEvent_GetWindow cdecl alias "wxChildFocusEvent_GetWindow" (byval self as integer) as integer
declare function wxChoice_ctor cdecl alias "wxChoice_ctor" () as integer
declare function wxChoice_Create cdecl alias "wxChoice_Create" (byval self as integer,byval parent as integer,byval id as integer,byval pos as integer,byval size as integer,byval n as integer,byval choices as byte ptr ptr,byval style as long,byval validator as integer,byval name as string) as integer
declare function wxChoice_dtor cdecl alias "wxChoice_dtor" (byval self as integer) as integer
declare function wxChoice_SetString cdecl alias "wxChoice_SetString" (byval self as integer,byval n as integer,byval text as string) as integer
declare function wxChoice_GetStringSelection cdecl alias "wxChoice_GetStringSelection" (byval self as integer) as byte ptr
declare function wxChoice_GetString cdecl alias "wxChoice_GetString" (byval self as integer,byval n as integer) as byte ptr
declare function wxChoice_GetSelection cdecl alias "wxChoice_GetSelection" (byval self as integer) as integer
declare function wxChoice_GetCount cdecl alias "wxChoice_GetCount" (byval self as integer) as integer
declare function wxChoice_GetClientData cdecl alias "wxChoice_GetClientData" (byval self as integer,byval n as integer) as integer
declare function wxChoice_SetClientData cdecl alias "wxChoice_SetClientData" (byval self as integer,byval n as integer,byval data as integer) as integer
declare function wxChoice_FindString cdecl alias "wxChoice_FindString" (byval self as integer,byval string as string) as integer
declare function wxChoice_Delete cdecl alias "wxChoice_Delete" (byval self as integer,byval n as integer) as integer
declare function wxChoice_Clear cdecl alias "wxChoice_Clear" (byval self as integer) as integer
declare function wxChoice_Append cdecl alias "wxChoice_Append" (byval self as integer,byval item as string) as integer
declare function wxChoice_AppendData cdecl alias "wxChoice_AppendData" (byval self as integer,byval item as string,byval clientData as integer) as integer
declare function wxChoice_AppendString cdecl alias "wxChoice_AppendString" (byval self as integer,byval item as string) as integer
declare function wxChoice_AppendArrayString cdecl alias "wxChoice_AppendArrayString" (byval self as integer,byval n as integer,byval strings as byte ptr ptr) as integer
declare function wxChoice_Insert cdecl alias "wxChoice_Insert" (byval self as integer,byval item as string,byval pos as integer) as integer
declare function wxChoice_InsertClientData cdecl alias "wxChoice_InsertClientData" (byval self as integer,byval item as string,byval pos as integer,byval clientData as integer) as integer
declare function wxChoice_GetStrings cdecl alias "wxChoice_GetStrings" (byval self as integer) as integer
declare function wxChoice_SetClientObject cdecl alias "wxChoice_SetClientObject" (byval self as integer,byval n as integer,byval clientData as integer) as integer
declare function wxChoice_GetClientObject cdecl alias "wxChoice_GetClientObject" (byval self as integer,byval n as integer) as integer
declare function wxChoice_HasClientObjectData cdecl alias "wxChoice_HasClientObjectData" (byval self as integer) as integer
declare function wxChoice_HasClientUntypedData cdecl alias "wxChoice_HasClientUntypedData" (byval self as integer) as integer
declare function wxChoice_SetSelection cdecl alias "wxChoice_SetSelection" (byval self as integer,byval n as integer) as integer
declare function wxChoice_SetStringSelection cdecl alias "wxChoice_SetStringSelection" (byval self as integer,byval s as string) as integer
declare function wxChoice_SetColumns cdecl alias "wxChoice_SetColumns" (byval self as integer,byval n as integer) as integer
declare function wxChoice_GetColumns cdecl alias "wxChoice_GetColumns" (byval self as integer) as integer
declare function wxChoice_Command cdecl alias "wxChoice_Command" (byval self as integer,byval event as integer) as integer
declare function wxChoice_Select cdecl alias "wxChoice_Select" (byval self as integer,byval n as integer) as integer
declare function wxChoice_ShouldInheritColours cdecl alias "wxChoice_ShouldInheritColours" (byval self as integer) as integer
declare function wxChoice_IsEmpty cdecl alias "wxChoice_IsEmpty" (byval self as integer) as integer
declare function wxSingleChoiceDialog_ctor cdecl alias "wxSingleChoiceDialog_ctor" (byval parent as integer,byval message as string,byval caption as string,byval n as integer,byval choices as byte ptr ptr,byval clientData as integer,byval style as integer,byval pos as integer) as integer
declare function wxSingleChoiceDialog_dtor cdecl alias "wxSingleChoiceDialog_dtor" (byval self as integer) as integer
declare function wxSingleChoiceDialog_SetSelection cdecl alias "wxSingleChoiceDialog_SetSelection" (byval self as integer,byval sel as integer) as integer
declare function wxSingleChoiceDialog_GetSelection cdecl alias "wxSingleChoiceDialog_GetSelection" (byval self as integer) as integer
declare function wxSingleChoiceDialog_GetStringSelection cdecl alias "wxSingleChoiceDialog_GetStringSelection" (byval self as integer) as byte ptr
declare function wxSingleChoiceDialog_GetSelectionClientData cdecl alias "wxSingleChoiceDialog_GetSelectionClientData" (byval self as integer) as integer
declare function wxMultiChoiceDialog_ctor cdecl alias "wxMultiChoiceDialog_ctor" (byval parent as integer,byval message as string,byval caption as string,byval n as integer,byval choices as byte ptr ptr,byval style as integer,byval pos as integer) as integer
declare function wxMultiChoiceDialog_dtor cdecl alias "wxMultiChoiceDialog_dtor" (byval self as integer) as integer
declare function wxMultiChoiceDialog_SetSelections cdecl alias "wxMultiChoiceDialog_SetSelections" (byval self as integer,byval sel as integer ptr,byval numsel as integer) as integer
declare function wxMultiChoiceDialog_GetSelections cdecl alias "wxMultiChoiceDialog_GetSelections" (byval self as integer) as integer
declare function wxGetSingleChoice_func cdecl alias "wxGetSingleChoice_func" (byval message as string,byval caption as string,byval n as integer,byval choices as byte ptr ptr,byval parent as integer,byval x as integer,byval y as integer,byval centre as integer,byval width as integer,byval height as integer) as byte ptr
declare function wxGetSingleChoiceIndex_func cdecl alias "wxGetSingleChoiceIndex_func" (byval message as string,byval caption as string,byval n as integer,byval choices as byte ptr ptr,byval parent as integer,byval x as integer,byval y as integer,byval centre as integer,byval width as integer,byval height as integer) as integer
declare function wxClientData_ctor cdecl alias "wxClientData_ctor" () as integer
declare function wxClientData_dtor cdecl alias "wxClientData_dtor" (byval self as integer) as integer
declare function wxClientData_RegisterDisposable cdecl alias "wxClientData_RegisterDisposable" (byval self as integer,byval onDispose as integer) as integer
declare function wxStringClientData_ctor cdecl alias "wxStringClientData_ctor" (byval data as string) as integer
declare function wxStringClientData_dtor cdecl alias "wxStringClientData_dtor" (byval self as integer) as integer
declare function wxStringClientData_SetData cdecl alias "wxStringClientData_SetData" (byval self as integer,byval data as string) as integer
declare function wxStringClientData_GetData cdecl alias "wxStringClientData_GetData" (byval self as integer) as byte ptr
declare function wxClipboard_ctor cdecl alias "wxClipboard_ctor" () as integer
declare function wxClipboard_Open cdecl alias "wxClipboard_Open" (byval self as integer) as integer
declare function wxClipboard_Close cdecl alias "wxClipboard_Close" (byval self as integer) as integer
declare function wxClipboard_IsOpened cdecl alias "wxClipboard_IsOpened" (byval self as integer) as integer
declare function wxClipboard_AddData cdecl alias "wxClipboard_AddData" (byval self as integer,byval data as integer) as integer
declare function wxClipboard_SetData cdecl alias "wxClipboard_SetData" (byval self as integer,byval data as integer) as integer
declare function wxClipboard_IsSupported cdecl alias "wxClipboard_IsSupported" (byval self as integer,byval format as integer) as integer
declare function wxClipboard_GetData cdecl alias "wxClipboard_GetData" (byval self as integer,byval data as integer) as integer
declare function wxClipboard_Clear cdecl alias "wxClipboard_Clear" (byval self as integer) as integer
declare function wxClipboard_Flush cdecl alias "wxClipboard_Flush" (byval self as integer) as integer
declare function wxClipboard_UsePrimarySelection cdecl alias "wxClipboard_UsePrimarySelection" (byval self as integer,byval primary as integer) as integer
declare function wxTheClipboard_static cdecl alias "wxTheClipboard_static" () as integer
declare function wxClipBoardLocker_ctor cdecl alias "wxClipBoardLocker_ctor" (byval clipboard as integer) as integer
declare function wxClipBoardLocker_dtor cdecl alias "wxClipBoardLocker_dtor" (byval self as integer) as integer
declare function wxClipboardLocker_IsOpen cdecl alias "wxClipboardLocker_IsOpen" (byval self as integer) as integer
declare function wxCloseEvent_ctor cdecl alias "wxCloseEvent_ctor" (byval type as integer) as integer
declare function wxCloseEvent_SetLoggingOff cdecl alias "wxCloseEvent_SetLoggingOff" (byval self as integer,byval logOff as integer) as integer
declare function wxCloseEvent_GetLoggingOff cdecl alias "wxCloseEvent_GetLoggingOff" (byval self as integer) as integer
declare function wxCloseEvent_Veto cdecl alias "wxCloseEvent_Veto" (byval self as integer,byval veto as integer) as integer
declare function wxCloseEvent_SetCanVeto cdecl alias "wxCloseEvent_SetCanVeto" (byval self as integer,byval canVeto as integer) as integer
declare function wxCloseEvent_CanVeto cdecl alias "wxCloseEvent_CanVeto" (byval self as integer) as integer
declare function wxCloseEvent_GetVeto cdecl alias "wxCloseEvent_GetVeto" (byval self as integer) as integer
declare function wxColour_ctor cdecl alias "wxColour_ctor" () as integer
declare function wxColour_dtor cdecl alias "wxColour_dtor" (byval self as integer) as integer
declare function wxColour_ctorByName cdecl alias "wxColour_ctorByName" (byval name as string) as integer
declare function wxColour_ctorByParts cdecl alias "wxColour_ctorByParts" (byval red as ubyte,byval green as ubyte,byval blue as ubyte) as integer
declare function wxColour_Blue cdecl alias "wxColour_Blue" (byval self as integer) as ubyte
declare function wxColour_Red cdecl alias "wxColour_Red" (byval self as integer) as ubyte
declare function wxColour_Green cdecl alias "wxColour_Green" (byval self as integer) as ubyte
declare function wxColour_Ok cdecl alias "wxColour_Ok" (byval self as integer) as integer
declare function wxColour_Set cdecl alias "wxColour_Set" (byval self as integer,byval red as ubyte,byval green as ubyte,byval blue as ubyte) as integer
declare function wxColourDialog_ctor cdecl alias "wxColourDialog_ctor" () as integer
declare function wxColourDialog_Create cdecl alias "wxColourDialog_Create" (byval self as integer,byval parent as integer,byval data as integer) as integer
declare function wxColourDialog_GetColourData cdecl alias "wxColourDialog_GetColourData" (byval self as integer) as integer
declare function wxColourDialog_ShowModal cdecl alias "wxColourDialog_ShowModal" (byval self as integer) as integer
declare function wxColourDialog_GetColourFromUser cdecl alias "wxColourDialog_GetColourFromUser" (byval parent as integer,byval colInit as integer) as integer
declare function wxColourData_ctor cdecl alias "wxColourData_ctor" () as integer
declare function wxColourData_SetChooseFull cdecl alias "wxColourData_SetChooseFull" (byval self as integer,byval flag as integer) as integer
declare function wxColourData_GetChooseFull cdecl alias "wxColourData_GetChooseFull" (byval self as integer) as integer
declare function wxColourData_SetColour cdecl alias "wxColourData_SetColour" (byval self as integer,byval colour as integer) as integer
declare function wxColourData_GetColour cdecl alias "wxColourData_GetColour" (byval self as integer) as integer
declare function wxColourData_SetCustomColour cdecl alias "wxColourData_SetCustomColour" (byval self as integer,byval i as integer,byval colour as integer) as integer
declare function wxColourData_GetCustomColour cdecl alias "wxColourData_GetCustomColour" (byval self as integer,byval i as integer) as integer
declare function wxComboBox_ctor cdecl alias "wxComboBox_ctor" () as integer
declare function wxComboBox_Create cdecl alias "wxComboBox_Create" (byval self as integer,byval window as integer,byval id as integer,byval value as string,byval pos as integer,byval size as integer,byval n as integer,byval choices as byte ptr ptr,byval style as long,byval validator as integer,byval name as string) as integer
declare function wxComboBox_Append cdecl alias "wxComboBox_Append" (byval self as integer,byval item as string) as integer
declare function wxComboBox_AppendData cdecl alias "wxComboBox_AppendData" (byval self as integer,byval item as string,byval data as integer) as integer
declare function wxComboBox_Clear cdecl alias "wxComboBox_Clear" (byval self as integer) as integer
declare function wxComboBox_Delete cdecl alias "wxComboBox_Delete" (byval self as integer,byval n as integer) as integer
declare function wxComboBox_FindString cdecl alias "wxComboBox_FindString" (byval self as integer,byval str as string) as integer
declare function wxComboBox_GetCount cdecl alias "wxComboBox_GetCount" (byval self as integer) as integer
declare function wxComboBox_GetSelection cdecl alias "wxComboBox_GetSelection" (byval self as integer) as integer
declare function wxComboBox_GetString cdecl alias "wxComboBox_GetString" (byval self as integer,byval n as integer) as byte ptr
declare function wxComboBox_GetStringSelection cdecl alias "wxComboBox_GetStringSelection" (byval self as integer) as byte ptr
declare function wxComboBox_SetStringSelection cdecl alias "wxComboBox_SetStringSelection" (byval self as integer,byval str as string) as integer
declare function wxComboBox_GetClientData cdecl alias "wxComboBox_GetClientData" (byval self as integer,byval n as integer) as integer
declare function wxComboBox_SetClientData cdecl alias "wxComboBox_SetClientData" (byval self as integer,byval n as integer,byval data as integer) as integer
declare function wxComboBox_SetSelectionSingle cdecl alias "wxComboBox_SetSelectionSingle" (byval self as integer,byval n as integer) as integer
declare function wxComboBox_Copy cdecl alias "wxComboBox_Copy" (byval self as integer) as integer
declare function wxComboBox_Cut cdecl alias "wxComboBox_Cut" (byval self as integer) as integer
declare function wxComboBox_Paste cdecl alias "wxComboBox_Paste" (byval self as integer) as integer
declare function wxComboBox_SetInsertionPoint cdecl alias "wxComboBox_SetInsertionPoint" (byval self as integer,byval pos as long) as integer
declare function wxComboBox_GetInsertionPoint cdecl alias "wxComboBox_GetInsertionPoint" (byval self as integer) as long
declare function wxComboBox_GetLastPosition cdecl alias "wxComboBox_GetLastPosition" (byval self as integer) as long
declare function wxComboBox_Replace cdecl alias "wxComboBox_Replace" (byval self as integer,byval from as long,byval to as long,byval value as string) as integer
declare function wxComboBox_SetSelectionMult cdecl alias "wxComboBox_SetSelectionMult" (byval self as integer,byval from as long,byval to as long) as integer
declare function wxComboBox_SetEditable cdecl alias "wxComboBox_SetEditable" (byval self as integer,byval editable as integer) as integer
declare function wxComboBox_SetInsertionPointEnd cdecl alias "wxComboBox_SetInsertionPointEnd" (byval self as integer) as integer
declare function wxComboBox_Remove cdecl alias "wxComboBox_Remove" (byval self as integer,byval from as long,byval to as long) as integer
declare function wxComboBox_GetValue cdecl alias "wxComboBox_GetValue" (byval self as integer) as byte ptr
declare function wxComboBox_SetValue cdecl alias "wxComboBox_SetValue" (byval self as integer,byval text as string) as integer
declare function wxComboBox_SetSelection cdecl alias "wxComboBox_SetSelection" (byval self as integer,byval n as integer) as integer
declare function wxComboBox_Select cdecl alias "wxComboBox_Select" (byval self as integer,byval n as integer) as integer
declare function wxCommandEvent_GetSelection cdecl alias "wxCommandEvent_GetSelection" (byval self as integer) as integer
declare function wxCommandEvent_GetString cdecl alias "wxCommandEvent_GetString" (byval self as integer) as byte ptr
declare function wxCommandEvent_SetString cdecl alias "wxCommandEvent_SetString" (byval self as integer,byval s as string) as integer
declare function wxCommandEvent_IsChecked cdecl alias "wxCommandEvent_IsChecked" (byval self as integer) as integer
declare function wxCommandEvent_IsSelection cdecl alias "wxCommandEvent_IsSelection" (byval self as integer) as integer
declare function wxCommandEvent_GetInt cdecl alias "wxCommandEvent_GetInt" (byval self as integer) as integer
declare function wxCommandEvent_SetInt cdecl alias "wxCommandEvent_SetInt" (byval self as integer,byval i as integer) as integer
declare function wxCommandEvent_GetClientObject cdecl alias "wxCommandEvent_GetClientObject" (byval self as integer) as integer
declare function wxCommandEvent_SetClientObject cdecl alias "wxCommandEvent_SetClientObject" (byval self as integer,byval data as integer) as integer
declare function wxCommandEvent_SetExtraLong cdecl alias "wxCommandEvent_SetExtraLong" (byval self as integer,byval extralong as long) as integer
declare function wxCommandEvent_GetExtraLong cdecl alias "wxCommandEvent_GetExtraLong" (byval self as integer) as long
declare function wxConfigBase_Set cdecl alias "wxConfigBase_Set" (byval pConfig as integer) as integer
declare function wxConfigBase_Get cdecl alias "wxConfigBase_Get" (byval createOnDemand as integer) as integer
declare function wxConfigBase_Create cdecl alias "wxConfigBase_Create" () as integer
declare function wxConfigBase_DontCreateOnDemand cdecl alias "wxConfigBase_DontCreateOnDemand" () as integer
declare function wxConfigBase_dtor cdecl alias "wxConfigBase_dtor" (byval self as integer) as integer
declare function wxConfigBase_SetPath cdecl alias "wxConfigBase_SetPath" (byval self as integer,byval strPath as string) as integer
declare function wxConfigBase_GetPath cdecl alias "wxConfigBase_GetPath" (byval self as integer) as byte ptr
declare function wxConfigBase_GetFirstGroup cdecl alias "wxConfigBase_GetFirstGroup" (byval self as integer,byval str as byte ptr,byval lIndex as integer) as integer
declare function wxConfigBase_GetNextGroup cdecl alias "wxConfigBase_GetNextGroup" (byval self as integer,byval str as byte ptr,byval lIndex as integer) as integer
declare function wxConfigBase_GetFirstEntry cdecl alias "wxConfigBase_GetFirstEntry" (byval self as integer,byval str as byte ptr,byval lIndex as integer) as integer
declare function wxConfigBase_GetNextEntry cdecl alias "wxConfigBase_GetNextEntry" (byval self as integer,byval str as byte ptr,byval lIndex as integer) as integer
declare function wxConfigBase_GetNumberOfEntries cdecl alias "wxConfigBase_GetNumberOfEntries" (byval self as integer,byval bRecursive as integer) as integer
declare function wxConfigBase_GetNumberOfGroups cdecl alias "wxConfigBase_GetNumberOfGroups" (byval self as integer,byval bRecursive as integer) as integer
declare function wxConfigBase_HasGroup cdecl alias "wxConfigBase_HasGroup" (byval self as integer,byval strName as string) as integer
declare function wxConfigBase_HasEntry cdecl alias "wxConfigBase_HasEntry" (byval self as integer,byval strName as string) as integer
declare function wxConfigBase_Exists cdecl alias "wxConfigBase_Exists" (byval self as integer,byval strName as string) as integer
declare function wxConfigBase_GetEntryType cdecl alias "wxConfigBase_GetEntryType" (byval self as integer,byval name as string) as integer
declare function wxConfigBase_ReadStr cdecl alias "wxConfigBase_ReadStr" (byval self as integer,byval key as string,byval pStr as byte ptr) as integer
declare function wxConfigBase_ReadStrDef cdecl alias "wxConfigBase_ReadStrDef" (byval self as integer,byval key as string,byval pStr as byte ptr,byval defVal as string) as integer
declare function wxConfigBase_ReadInt cdecl alias "wxConfigBase_ReadInt" (byval self as integer,byval key as string,byval pl as integer) as integer
declare function wxConfigBase_ReadIntDef cdecl alias "wxConfigBase_ReadIntDef" (byval self as integer,byval key as string,byval pl as integer,byval defVal as integer) as integer
declare function wxConfigBase_ReadDbl cdecl alias "wxConfigBase_ReadDbl" (byval self as integer,byval key as string,byval val as integer) as integer
declare function wxConfigBase_ReadDblDef cdecl alias "wxConfigBase_ReadDblDef" (byval self as integer,byval key as string,byval val as integer,byval defVal as integer) as integer
declare function wxConfigBase_ReadBool cdecl alias "wxConfigBase_ReadBool" (byval self as integer,byval key as string,byval val as integer) as integer
declare function wxConfigBase_ReadBoolDef cdecl alias "wxConfigBase_ReadBoolDef" (byval self as integer,byval key as string,byval val as integer,byval defVal as integer) as integer
declare function wxConfigBase_ReadStrRet cdecl alias "wxConfigBase_ReadStrRet" (byval self as integer,byval key as string,byval defVal as string) as byte ptr
declare function wxConfigBase_ReadIntRet cdecl alias "wxConfigBase_ReadIntRet" (byval self as integer,byval key as string,byval defVal as integer) as integer
declare function wxConfigBase_WriteStr cdecl alias "wxConfigBase_WriteStr" (byval self as integer,byval key as string,byval value as string) as integer
declare function wxConfigBase_WriteInt cdecl alias "wxConfigBase_WriteInt" (byval self as integer,byval key as string,byval value as integer) as integer
declare function wxConfigBase_WriteDbl cdecl alias "wxConfigBase_WriteDbl" (byval self as integer,byval key as string,byval value as integer) as integer
declare function wxConfigBase_WriteBool cdecl alias "wxConfigBase_WriteBool" (byval self as integer,byval key as string,byval value as integer) as integer
declare function wxConfigBase_Flush cdecl alias "wxConfigBase_Flush" (byval self as integer,byval bCurrentOnly as integer) as integer
declare function wxConfigBase_RenameEntry cdecl alias "wxConfigBase_RenameEntry" (byval self as integer,byval oldName as string,byval newName as string) as integer
declare function wxConfigBase_RenameGroup cdecl alias "wxConfigBase_RenameGroup" (byval self as integer,byval oldName as string,byval newName as string) as integer
declare function wxConfigBase_DeleteEntry cdecl alias "wxConfigBase_DeleteEntry" (byval self as integer,byval key as string,byval bDeleteGroupIfEmpty as integer) as integer
declare function wxConfigBase_DeleteGroup cdecl alias "wxConfigBase_DeleteGroup" (byval self as integer,byval key as string) as integer
declare function wxConfigBase_DeleteAll cdecl alias "wxConfigBase_DeleteAll" (byval self as integer) as integer
declare function wxConfigBase_IsExpandingEnvVars cdecl alias "wxConfigBase_IsExpandingEnvVars" (byval self as integer) as integer
declare function wxConfigBase_SetExpandEnvVars cdecl alias "wxConfigBase_SetExpandEnvVars" (byval self as integer,byval bDoIt as integer) as integer
declare function wxConfigBase_ExpandEnvVars cdecl alias "wxConfigBase_ExpandEnvVars" (byval self as integer,byval str as string) as byte ptr
declare function wxConfigBase_SetRecordDefaults cdecl alias "wxConfigBase_SetRecordDefaults" (byval self as integer,byval bDoIt as integer) as integer
declare function wxConfigBase_IsRecordingDefaults cdecl alias "wxConfigBase_IsRecordingDefaults" (byval self as integer) as integer
declare function wxConfigBase_GetAppName cdecl alias "wxConfigBase_GetAppName" (byval self as integer) as byte ptr
declare function wxConfigBase_SetAppName cdecl alias "wxConfigBase_SetAppName" (byval self as integer,byval appName as string) as integer
declare function wxConfigBase_GetVendorName cdecl alias "wxConfigBase_GetVendorName" (byval self as integer) as byte ptr
declare function wxConfigBase_SetVendorName cdecl alias "wxConfigBase_SetVendorName" (byval self as integer,byval vendorName as string) as integer
declare function wxConfigBase_SetStyle cdecl alias "wxConfigBase_SetStyle" (byval self as integer,byval style as integer) as integer
declare function wxConfigBase_GetStyle cdecl alias "wxConfigBase_GetStyle" (byval self as integer) as integer
declare function wxContextMenuEvent_ctor cdecl alias "wxContextMenuEvent_ctor" (byval type as integer) as integer
declare function wxContextMenuEvent_GetPosition cdecl alias "wxContextMenuEvent_GetPosition" (byval self as integer,byval inp as integer) as integer
declare function wxContextMenuEvent_SetPosition cdecl alias "wxContextMenuEvent_SetPosition" (byval self as integer,byval inp as integer) as integer
declare function wxControl_Command cdecl alias "wxControl_Command" (byval self as integer,byval event as integer) as integer
declare function wxControl_SetLabel cdecl alias "wxControl_SetLabel" (byval self as integer,byval label as string) as integer
declare function wxControl_GetLabel cdecl alias "wxControl_GetLabel" (byval self as integer) as byte ptr
declare function wxControl_GetAlignment cdecl alias "wxControl_GetAlignment" (byval self as integer) as integer
declare function wxControl_SetFont cdecl alias "wxControl_SetFont" (byval self as integer,byval font as integer) as integer
declare function wxCursor_ctorImage cdecl alias "wxCursor_ctorImage" (byval image as integer) as integer
declare function wxCursor_ctorCopy cdecl alias "wxCursor_ctorCopy" (byval cursor as integer) as integer
declare function wxCursor_ctorById cdecl alias "wxCursor_ctorById" (byval id as integer) as integer
declare function wxCursor_Ok cdecl alias "wxCursor_Ok" (byval self as integer) as integer
declare function wxCursor_SetCursor cdecl alias "wxCursor_SetCursor" (byval cursor as integer) as integer
declare function wxDataFormat_ctor cdecl alias "wxDataFormat_ctor" () as integer
declare function wxDataFormat_dtor cdecl alias "wxDataFormat_dtor" (byval self as integer) as integer
declare function wxDataFormat_ctorByType cdecl alias "wxDataFormat_ctorByType" (byval type as integer) as integer
declare function wxDataFormat_ctorById cdecl alias "wxDataFormat_ctorById" (byval id as string) as integer
declare function wxDataFormat_GetId cdecl alias "wxDataFormat_GetId" (byval self as integer) as byte ptr
declare function wxDataFormat_SetId cdecl alias "wxDataFormat_SetId" (byval self as integer,byval id as string) as integer
declare function wxDataFormat_GetType cdecl alias "wxDataFormat_GetType" (byval self as integer) as integer
declare function wxDataFormat_SetType cdecl alias "wxDataFormat_SetType" (byval self as integer,byval type as integer) as integer
declare function wxDataObject_dtor cdecl alias "wxDataObject_dtor" (byval self as integer) as integer
declare function wxDataObject_GetDataSize cdecl alias "wxDataObject_GetDataSize" (byval self as integer,byval format as integer) as integer
declare function wxDataObject_GetDataHere cdecl alias "wxDataObject_GetDataHere" (byval self as integer,byval format as integer,byval buf as integer) as integer
declare function wxDataObject_SetData cdecl alias "wxDataObject_SetData" (byval self as integer,byval format as integer,byval len as integer,byval buf as integer) as integer
declare function wxDataObjectSimple_ctor cdecl alias "wxDataObjectSimple_ctor" (byval format as integer) as integer
declare function wxDataObjectSimple_dtor cdecl alias "wxDataObjectSimple_dtor" (byval self as integer) as integer
declare function wxDataObjectSimple_SetFormat cdecl alias "wxDataObjectSimple_SetFormat" (byval self as integer,byval format as integer) as integer
declare function wxDataObjectSimple_GetDataSize cdecl alias "wxDataObjectSimple_GetDataSize" (byval self as integer) as integer
declare function wxDataObjectSimple_GetDataHere cdecl alias "wxDataObjectSimple_GetDataHere" (byval self as integer,byval buf as integer) as integer
declare function wxDataObjectSimple_SetData cdecl alias "wxDataObjectSimple_SetData" (byval self as integer,byval len as integer,byval buf as integer) as integer
declare function wxTextDataObject_ctor cdecl alias "wxTextDataObject_ctor" (byval text as string) as integer
declare function wxTextDataObject_dtor cdecl alias "wxTextDataObject_dtor" (byval self as integer) as integer
declare function wxTextDataObject_RegisterDisposable cdecl alias "wxTextDataObject_RegisterDisposable" (byval self as integer,byval onDispose as integer) as integer
declare function wxTextDataObject_GetTextLength cdecl alias "wxTextDataObject_GetTextLength" (byval self as integer) as integer
declare function wxTextDataObject_GetText cdecl alias "wxTextDataObject_GetText" (byval self as integer) as byte ptr
declare function wxTextDataObject_SetText cdecl alias "wxTextDataObject_SetText" (byval self as integer,byval text as string) as integer
declare function wxFileDataObject_ctor cdecl alias "wxFileDataObject_ctor" () as integer
declare function wxFileDataObject_dtor cdecl alias "wxFileDataObject_dtor" (byval self as integer) as integer
declare function wxFileDataObject_RegisterDisposable cdecl alias "wxFileDataObject_RegisterDisposable" (byval self as integer,byval onDispose as integer) as integer
declare function wxFileDataObject_AddFile cdecl alias "wxFileDataObject_AddFile" (byval self as integer,byval filename as string) as integer
declare function wxFileDataObject_GetFilenames cdecl alias "wxFileDataObject_GetFilenames" (byval self as integer) as integer
declare function wxDC_dtor cdecl alias "wxDC_dtor" (byval dc as integer) as integer
declare function wxDC_DrawBitmap cdecl alias "wxDC_DrawBitmap" (byval self as integer,byval bmp as integer,byval x as integer,byval y as integer,byval transparent as integer) as integer
declare function wxDC_DrawPolygon cdecl alias "wxDC_DrawPolygon" (byval self as integer,byval n as integer,byval points as integer ptr,byval xoffset as integer,byval yoffset as integer,byval fill_style as integer) as integer
declare function wxDC_DrawLine cdecl alias "wxDC_DrawLine" (byval self as integer,byval x1 as integer,byval y1 as integer,byval x2 as integer,byval y2 as integer) as integer
declare function wxDC_DrawRectangle cdecl alias "wxDC_DrawRectangle" (byval self as integer,byval x1 as integer,byval y1 as integer,byval x2 as integer,byval y2 as integer) as integer
declare function wxDC_DrawText cdecl alias "wxDC_DrawText" (byval self as integer,byval text as string,byval x as integer,byval y as integer) as integer
declare function wxDC_DrawEllipse cdecl alias "wxDC_DrawEllipse" (byval self as integer,byval x as integer,byval y as integer,byval width as integer,byval height as integer) as integer
declare function wxDC_DrawPoint cdecl alias "wxDC_DrawPoint" (byval self as integer,byval x as integer,byval y as integer) as integer
declare function wxDC_DrawRoundedRectangle cdecl alias "wxDC_DrawRoundedRectangle" (byval self as integer,byval x as integer,byval y as integer,byval width as integer,byval height as integer,byval radius as integer) as integer
declare function wxDC_SetBackgroundMode cdecl alias "wxDC_SetBackgroundMode" (byval self as integer,byval mode as integer) as integer
declare function wxDC_SetBrush cdecl alias "wxDC_SetBrush" (byval self as integer,byval brush as integer) as integer
declare function wxDC_GetBrush cdecl alias "wxDC_GetBrush" (byval self as integer) as integer
declare function wxDC_SetBackground cdecl alias "wxDC_SetBackground" (byval self as integer,byval brush as integer) as integer
declare function wxDC_GetBackground cdecl alias "wxDC_GetBackground" (byval self as integer) as integer
declare function wxDC_SetPen cdecl alias "wxDC_SetPen" (byval self as integer,byval pen as integer) as integer
declare function wxDC_GetPen cdecl alias "wxDC_GetPen" (byval self as integer) as integer
declare function wxDC_GetTextForeground cdecl alias "wxDC_GetTextForeground" (byval self as integer) as integer
declare function wxDC_SetTextForeground cdecl alias "wxDC_SetTextForeground" (byval self as integer,byval colour as integer) as integer
declare function wxDC_GetTextBackground cdecl alias "wxDC_GetTextBackground" (byval self as integer) as integer
declare function wxDC_SetTextBackground cdecl alias "wxDC_SetTextBackground" (byval self as integer,byval colour as integer) as integer
declare function wxDC_GetFont cdecl alias "wxDC_GetFont" (byval self as integer) as integer
declare function wxDC_SetFont cdecl alias "wxDC_SetFont" (byval self as integer,byval font as integer) as integer
declare function wxDC_Clear cdecl alias "wxDC_Clear" (byval self as integer) as integer
declare function wxDC_DestroyClippingRegion cdecl alias "wxDC_DestroyClippingRegion" (byval self as integer) as integer
declare function wxDC_SetClippingRegion cdecl alias "wxDC_SetClippingRegion" (byval self as integer,byval x as integer,byval y as integer,byval width as integer,byval height as integer) as integer
declare function wxDC_SetClippingRegionPos cdecl alias "wxDC_SetClippingRegionPos" (byval self as integer,byval pos as integer,byval size as integer) as integer
declare function wxDC_SetClippingRegionRect cdecl alias "wxDC_SetClippingRegionRect" (byval self as integer,byval rect as integer) as integer
declare function wxDC_SetClippingRegionReg cdecl alias "wxDC_SetClippingRegionReg" (byval self as integer,byval reg as integer) as integer
declare function wxDC_GetLogicalFunction cdecl alias "wxDC_GetLogicalFunction" (byval self as integer) as integer
declare function wxDC_SetLogicalFunction cdecl alias "wxDC_SetLogicalFunction" (byval self as integer,byval function as integer) as integer
declare function wxDC_BeginDrawing cdecl alias "wxDC_BeginDrawing" (byval self as integer) as integer
declare function wxDC_Blit cdecl alias "wxDC_Blit" (byval self as integer,byval xdest as integer,byval ydest as integer,byval width as integer,byval height as integer,byval source as integer,byval xsrc as integer,byval ysrc as integer,byval rop as integer= wxCOPY,byval useMask as integer= FALSE,byval xsrcMask as integer= -1,byval ysrcMask as integer= -1) as integer
declare function wxDC_EndDrawing cdecl alias "wxDC_EndDrawing" (byval self as integer) as integer
declare function wxDC_FloodFill cdecl alias "wxDC_FloodFill" (byval self as integer,byval x as integer,byval y as integer,byval col as integer,byval style as integer) as integer
declare function wxDC_GetPixel cdecl alias "wxDC_GetPixel" (byval self as integer,byval x as integer,byval y as integer,byval col as integer) as integer
declare function wxDC_CrossHair cdecl alias "wxDC_CrossHair" (byval self as integer,byval x as integer,byval y as integer) as integer
declare function wxDC_DrawArc cdecl alias "wxDC_DrawArc" (byval self as integer,byval x1 as integer,byval y1 as integer,byval x2 as integer,byval y2 as integer,byval xc as integer,byval yc as integer) as integer
declare function wxDC_DrawCheckMark cdecl alias "wxDC_DrawCheckMark" (byval self as integer,byval x as integer,byval y as integer,byval width as integer,byval height as integer) as integer
declare function wxDC_DrawEllipticArc cdecl alias "wxDC_DrawEllipticArc" (byval self as integer,byval x as integer,byval y as integer,byval w as integer,byval h as integer,byval sa as integer,byval ea as integer) as integer
declare function wxDC_DrawLines cdecl alias "wxDC_DrawLines" (byval self as integer,byval n as integer,byval points as integer ptr,byval xoffset as integer,byval yoffset as integer) as integer
declare function wxDC_DrawCircle cdecl alias "wxDC_DrawCircle" (byval self as integer,byval x as integer,byval y as integer,byval radius as integer) as integer
declare function wxDC_DrawIcon cdecl alias "wxDC_DrawIcon" (byval self as integer,byval icon as integer,byval x as integer,byval y as integer) as integer
declare function wxDC_DrawRotatedText cdecl alias "wxDC_DrawRotatedText" (byval self as integer,byval text as string,byval x as integer,byval y as integer,byval angle as integer) as integer
declare function wxDC_DrawLabel cdecl alias "wxDC_DrawLabel" (byval self as integer,byval text as string,byval image as integer,byval rect as integer,byval alignment as integer,byval indexAccel as integer,byval rectBounding as integer) as integer
declare function wxDC_DrawLabel2 cdecl alias "wxDC_DrawLabel2" (byval self as integer,byval text as string,byval rect as integer,byval alignment as integer,byval indexAccel as integer) as integer
declare function wxDC_DrawSpline cdecl alias "wxDC_DrawSpline" (byval self as integer,byval x1 as integer,byval y1 as integer,byval x2 as integer,byval y2 as integer,byval x3 as integer,byval y3 as integer) as integer
declare function wxDC_DrawSpline2 cdecl alias "wxDC_DrawSpline2" (byval self as integer,byval n as integer,byval points as integer ptr) as integer
declare function wxDC_StartDoc cdecl alias "wxDC_StartDoc" (byval self as integer,byval message as string) as integer
declare function wxDC_EndDoc cdecl alias "wxDC_EndDoc" (byval self as integer) as integer
declare function wxDC_StartPage cdecl alias "wxDC_StartPage" (byval self as integer) as integer
declare function wxDC_EndPage cdecl alias "wxDC_EndPage" (byval self as integer) as integer
declare function wxDC_GetClippingBox cdecl alias "wxDC_GetClippingBox" (byval self as integer,byval x as integer,byval y as integer,byval w as integer,byval h as integer) as integer
declare function wxDC_GetClippingBox2 cdecl alias "wxDC_GetClippingBox2" (byval self as integer,byval rect as integer) as integer
declare function wxDC_GetMultiLineTextExtent cdecl alias "wxDC_GetMultiLineTextExtent" (byval self as integer,byval text as string,byval width as integer,byval height as integer,byval heightLine as integer,byval font as integer) as integer
declare function wxDC_GetPartialTextExtents cdecl alias "wxDC_GetPartialTextExtents" (byval self as integer,byval text as string,byval widths as integer) as integer
declare function wxDC_GetSize cdecl alias "wxDC_GetSize" (byval self as integer,byval width as integer,byval height as integer) as integer
declare function wxDC_GetSize2 cdecl alias "wxDC_GetSize2" (byval self as integer,byval size as integer) as integer
declare function wxDC_GetSizeMM cdecl alias "wxDC_GetSizeMM" (byval self as integer,byval width as integer,byval height as integer) as integer
declare function wxDC_GetSizeMM2 cdecl alias "wxDC_GetSizeMM2" (byval self as integer,byval size as integer) as integer
declare function wxDC_DeviceToLogicalX cdecl alias "wxDC_DeviceToLogicalX" (byval self as integer,byval x as integer) as integer
declare function wxDC_DeviceToLogicalY cdecl alias "wxDC_DeviceToLogicalY" (byval self as integer,byval y as integer) as integer
declare function wxDC_DeviceToLogicalXRel cdecl alias "wxDC_DeviceToLogicalXRel" (byval self as integer,byval x as integer) as integer
declare function wxDC_DeviceToLogicalYRel cdecl alias "wxDC_DeviceToLogicalYRel" (byval self as integer,byval y as integer) as integer
declare function wxDC_LogicalToDeviceX cdecl alias "wxDC_LogicalToDeviceX" (byval self as integer,byval x as integer) as integer
declare function wxDC_LogicalToDeviceY cdecl alias "wxDC_LogicalToDeviceY" (byval self as integer,byval y as integer) as integer
declare function wxDC_LogicalToDeviceXRel cdecl alias "wxDC_LogicalToDeviceXRel" (byval self as integer,byval x as integer) as integer
declare function wxDC_LogicalToDeviceYRel cdecl alias "wxDC_LogicalToDeviceYRel" (byval self as integer,byval y as integer) as integer
declare function wxDC_Ok cdecl alias "wxDC_Ok" (byval self as integer) as integer
declare function wxDC_GetBackgroundMode cdecl alias "wxDC_GetBackgroundMode" (byval self as integer) as integer
declare function wxDC_GetMapMode cdecl alias "wxDC_GetMapMode" (byval self as integer) as integer
declare function wxDC_SetMapMode cdecl alias "wxDC_SetMapMode" (byval self as integer,byval mode as integer) as integer
declare function wxDC_GetUserScale cdecl alias "wxDC_GetUserScale" (byval self as integer,byval x as integer,byval y as integer) as integer
declare function wxDC_SetUserScale cdecl alias "wxDC_SetUserScale" (byval self as integer,byval x as integer,byval y as integer) as integer
declare function wxDC_GetLogicalScale cdecl alias "wxDC_GetLogicalScale" (byval self as integer,byval x as integer,byval y as integer) as integer
declare function wxDC_SetLogicalScale cdecl alias "wxDC_SetLogicalScale" (byval self as integer,byval x as integer,byval y as integer) as integer
declare function wxDC_GetLogicalOrigin cdecl alias "wxDC_GetLogicalOrigin" (byval self as integer,byval x as integer,byval y as integer) as integer
declare function wxDC_GetLogicalOrigin2 cdecl alias "wxDC_GetLogicalOrigin2" (byval self as integer,byval pt as integer) as integer
declare function wxDC_SetLogicalOrigin cdecl alias "wxDC_SetLogicalOrigin" (byval self as integer,byval x as integer,byval y as integer) as integer
declare function wxDC_GetDeviceOrigin cdecl alias "wxDC_GetDeviceOrigin" (byval self as integer,byval x as integer,byval y as integer) as integer
declare function wxDC_GetDeviceOrigin2 cdecl alias "wxDC_GetDeviceOrigin2" (byval self as integer,byval pt as integer) as integer
declare function wxDC_SetDeviceOrigin cdecl alias "wxDC_SetDeviceOrigin" (byval self as integer,byval x as integer,byval y as integer) as integer
declare function wxDC_SetAxisOrientation cdecl alias "wxDC_SetAxisOrientation" (byval self as integer,byval xLeftRight as integer,byval yBottomUp as integer) as integer
declare function wxDC_CalcBoundingBox cdecl alias "wxDC_CalcBoundingBox" (byval self as integer,byval x as integer,byval y as integer) as integer
declare function wxDC_ResetBoundingBox cdecl alias "wxDC_ResetBoundingBox" (byval self as integer) as integer
declare function wxDC_MinX cdecl alias "wxDC_MinX" (byval self as integer) as integer
declare function wxDC_MaxX cdecl alias "wxDC_MaxX" (byval self as integer) as integer
declare function wxDC_MinY cdecl alias "wxDC_MinY" (byval self as integer) as integer
declare function wxDC_MaxY cdecl alias "wxDC_MaxY" (byval self as integer) as integer
declare function wxWindowDC_ctor cdecl alias "wxWindowDC_ctor" () as integer
declare function wxWindowDC_ctor2 cdecl alias "wxWindowDC_ctor2" (byval win as integer) as integer
declare function wxWindowDC_CanDrawBitmap cdecl alias "wxWindowDC_CanDrawBitmap" (byval self as integer) as integer
declare function wxWindowDC_CanGetTextExtent cdecl alias "wxWindowDC_CanGetTextExtent" (byval self as integer) as integer
declare function wxWindowDC_GetCharWidth cdecl alias "wxWindowDC_GetCharWidth" (byval self as integer) as integer
declare function wxWindowDC_GetCharHeight cdecl alias "wxWindowDC_GetCharHeight" (byval self as integer) as integer
declare function wxWindowDC_Clear cdecl alias "wxWindowDC_Clear" (byval self as integer) as integer
declare function wxWindowDC_SetFont cdecl alias "wxWindowDC_SetFont" (byval self as integer,byval font as integer) as integer
declare function wxWindowDC_GetFont cdecl alias "wxWindowDC_GetFont" (byval self as integer) as integer
declare function wxWindowDC_SetPen cdecl alias "wxWindowDC_SetPen" (byval self as integer,byval pen as integer) as integer
declare function wxWindowDC_GetPen cdecl alias "wxWindowDC_GetPen" (byval self as integer) as integer
declare function wxWindowDC_SetBrush cdecl alias "wxWindowDC_SetBrush" (byval self as integer,byval brush as integer) as integer
declare function wxWindowDC_SetBackground cdecl alias "wxWindowDC_SetBackground" (byval self as integer,byval brush as integer) as integer
declare function wxWindowDC_GetBackground cdecl alias "wxWindowDC_GetBackground" (byval self as integer) as integer
declare function wxWindowDC_SetLogicalFunction cdecl alias "wxWindowDC_SetLogicalFunction" (byval self as integer,byval function as integer) as integer
declare function wxWindowDC_SetTextForeground cdecl alias "wxWindowDC_SetTextForeground" (byval self as integer,byval colour as integer) as integer
declare function wxWindowDC_GetTextForeground cdecl alias "wxWindowDC_GetTextForeground" (byval self as integer) as integer
declare function wxWindowDC_SetTextBackground cdecl alias "wxWindowDC_SetTextBackground" (byval self as integer,byval colour as integer) as integer
declare function wxWindowDC_SetBackgroundMode cdecl alias "wxWindowDC_SetBackgroundMode" (byval self as integer,byval mode as integer) as integer
declare function wxWindowDC_GetBackgroundMode cdecl alias "wxWindowDC_GetBackgroundMode" (byval self as integer) as integer
declare function wxWindowDC_SetPalette cdecl alias "wxWindowDC_SetPalette" (byval self as integer,byval palette as integer) as integer
declare function wxWindowDC_GetPPI cdecl alias "wxWindowDC_GetPPI" (byval self as integer,byval size as integer) as integer
declare function wxWindowDC_GetDepth cdecl alias "wxWindowDC_GetDepth" (byval self as integer) as integer
declare function wxClientDC_ctor cdecl alias "wxClientDC_ctor" () as integer
declare function wxClientDC_ctor2 cdecl alias "wxClientDC_ctor2" (byval win as integer) as integer
declare function wxPaintDC_ctor cdecl alias "wxPaintDC_ctor" () as integer
declare function wxPaintDC_ctor2 cdecl alias "wxPaintDC_ctor2" (byval window as integer) as integer
declare function wxDialog_ctor cdecl alias "wxDialog_ctor" () as integer
declare function wxDialog_dtor cdecl alias "wxDialog_dtor" (byval self as integer) as integer
declare function wxDialog_Create cdecl alias "wxDialog_Create" (byval self as integer,byval parent as integer,byval id as integer,byval title as string,byval pos as integer,byval size as integer,byval style as long,byval name as string) as integer
declare function wxDialog_SetReturnCode cdecl alias "wxDialog_SetReturnCode" (byval self as integer,byval returnCode as integer) as integer
declare function wxDialog_GetReturnCode cdecl alias "wxDialog_GetReturnCode" (byval self as integer) as integer
declare function wxDialog_GetTitle cdecl alias "wxDialog_GetTitle" (byval self as integer) as byte ptr
declare function wxDialog_SetTitle cdecl alias "wxDialog_SetTitle" (byval self as integer,byval title as string) as integer
declare function wxDialog_EndModal cdecl alias "wxDialog_EndModal" (byval self as integer,byval retCode as integer) as integer
declare function wxDialog_IsModal cdecl alias "wxDialog_IsModal" (byval self as integer) as integer
declare function wxDialog_SetModal cdecl alias "wxDialog_SetModal" (byval self as integer,byval modal as integer) as integer
declare function wxDialog_SetIcon cdecl alias "wxDialog_SetIcon" (byval self as integer,byval icon as integer) as integer
declare function wxDialog_SetIcons cdecl alias "wxDialog_SetIcons" (byval self as integer,byval icons as integer) as integer
declare function wxDialog_ShowModal cdecl alias "wxDialog_ShowModal" (byval self as integer) as integer
declare function wxDirDialog_ctor cdecl alias "wxDirDialog_ctor" (byval parent as integer,byval message as string,byval defaultPath as string,byval style as integer,byval pos as integer,byval size as integer,byval name as string) as integer
declare function wxDirDialog_GetStyle cdecl alias "wxDirDialog_GetStyle" (byval self as integer) as integer
declare function wxDirDialog_SetStyle cdecl alias "wxDirDialog_SetStyle" (byval self as integer,byval style as integer) as integer
declare function wxDirDialog_SetMessage cdecl alias "wxDirDialog_SetMessage" (byval self as integer,byval message as string) as integer
declare function wxDirDialog_GetMessage cdecl alias "wxDirDialog_GetMessage" (byval self as integer) as byte ptr
declare function wxDirDialog_ShowModal cdecl alias "wxDirDialog_ShowModal" (byval self as integer) as integer
declare function wxDirDialog_SetPath cdecl alias "wxDirDialog_SetPath" (byval self as integer,byval path as string) as integer
declare function wxDirDialog_GetPath cdecl alias "wxDirDialog_GetPath" (byval self as integer) as byte ptr
declare function wxDisplayChangedEvent_ctor cdecl alias "wxDisplayChangedEvent_ctor" () as integer
declare function wxDropSource_Win_ctor cdecl alias "wxDropSource_Win_ctor" (byval win as integer) as integer
declare function wxDropSource_DataObject_ctor cdecl alias "wxDropSource_DataObject_ctor" (byval dataObject as integer,byval win as integer) as integer
declare function wxDropSource_dtor cdecl alias "wxDropSource_dtor" (byval self as integer) as integer
declare function wxDropSource_RegisterVirtual cdecl alias "wxDropSource_RegisterVirtual" (byval self as integer,byval doDragDrop as integer) as integer
declare function wxDropSource_DoDragDrop cdecl alias "wxDropSource_DoDragDrop" (byval self as integer,byval flags as integer) as integer
declare function wxDropSource_SetData cdecl alias "wxDropSource_SetData" (byval self as integer,byval data as integer) as integer
declare function wxDropSource_GetDataObject cdecl alias "wxDropSource_GetDataObject" (byval self as integer) as integer
declare function wxDropSource_SetCursor cdecl alias "wxDropSource_SetCursor" (byval self as integer,byval res as integer,byval cursor as integer) as integer
declare function wxDropSource_GiveFeedback cdecl alias "wxDropSource_GiveFeedback" (byval self as integer,byval effect as integer) as integer
declare function wxDropTarget_ctor cdecl alias "wxDropTarget_ctor" (byval dataObject as integer) as integer
declare function wxDropTarget_dtor cdecl alias "wxDropTarget_dtor" (byval self as integer) as integer
declare function wxDropTarget_RegisterVirtual cdecl alias "wxDropTarget_RegisterVirtual" (byval self as integer,byval onDragOver as integer,byval onDrop as integer,byval onData as integer,byval getData as integer,byval onLeave as integer,byval onEnter as integer) as integer
declare function wxDropTarget_RegisterDisposable cdecl alias "wxDropTarget_RegisterDisposable" (byval self as integer,byval onDispose as integer) as integer
declare function wxDropTarget_SetDataObject cdecl alias "wxDropTarget_SetDataObject" (byval self as integer,byval dataObject as integer) as integer
declare function wxDropTarget_OnEnter cdecl alias "wxDropTarget_OnEnter" (byval self as integer,byval x as integer,byval y as integer,byval def as integer) as integer
declare function wxDropTarget_OnDragOver cdecl alias "wxDropTarget_OnDragOver" (byval self as integer,byval x as integer,byval y as integer,byval def as integer) as integer
declare function wxDropTarget_OnLeave cdecl alias "wxDropTarget_OnLeave" (byval self as integer) as integer
declare function wxDropTarget_OnDrop cdecl alias "wxDropTarget_OnDrop" (byval self as integer,byval x as integer,byval y as integer) as integer
declare function wxDropTarget_GetData cdecl alias "wxDropTarget_GetData" (byval self as integer) as integer
declare function wxTextDropTarget_ctor cdecl alias "wxTextDropTarget_ctor" () as integer
declare function wxTextDropTarget_RegisterVirtual cdecl alias "wxTextDropTarget_RegisterVirtual" (byval self as integer,byval onDropText as integer,byval onData as integer) as integer
declare function wxTextDropTarget_OnData cdecl alias "wxTextDropTarget_OnData" (byval self as integer,byval x as integer,byval y as integer,byval def as integer) as integer
declare function wxTextDropTarget_OnDrop cdecl alias "wxTextDropTarget_OnDrop" (byval self as integer,byval x as integer,byval y as integer) as integer
declare function wxTextDropTarget_GetData cdecl alias "wxTextDropTarget_GetData" (byval self as integer) as integer
declare function wxFileDropTarget_ctor cdecl alias "wxFileDropTarget_ctor" () as integer
declare function wxFileDropTarget_RegisterVirtual cdecl alias "wxFileDropTarget_RegisterVirtual" (byval self as integer,byval onDropFiles as integer,byval onData as integer) as integer
declare function wxFileDropTarget_OnData cdecl alias "wxFileDropTarget_OnData" (byval self as integer,byval x as integer,byval y as integer,byval def as integer) as integer
declare function wxFileDropTarget_OnDrop cdecl alias "wxFileDropTarget_OnDrop" (byval self as integer,byval x as integer,byval y as integer) as integer
declare function wxFileDropTarget_GetData cdecl alias "wxFileDropTarget_GetData" (byval self as integer) as integer
declare function wxDocument_ctor cdecl alias "wxDocument_ctor" (byval parent as integer) as integer
declare function wxDocument_SetFilename cdecl alias "wxDocument_SetFilename" (byval self as integer,byval filename as string,byval notifyViews as integer) as integer
declare function wxDocument_GetFilename cdecl alias "wxDocument_GetFilename" (byval self as integer) as byte ptr
declare function wxDocument_SetTitle cdecl alias "wxDocument_SetTitle" (byval self as integer,byval title as string) as integer
declare function wxDocument_GetTitle cdecl alias "wxDocument_GetTitle" (byval self as integer) as byte ptr
declare function wxDocument_SetDocumentName cdecl alias "wxDocument_SetDocumentName" (byval self as integer,byval name as string) as integer
declare function wxDocument_GetDocumentName cdecl alias "wxDocument_GetDocumentName" (byval self as integer) as byte ptr
declare function wxDocument_GetDocumentSaved cdecl alias "wxDocument_GetDocumentSaved" (byval self as integer) as integer
declare function wxDocument_SetDocumentSaved cdecl alias "wxDocument_SetDocumentSaved" (byval self as integer,byval saved as integer) as integer
declare function wxDocument_Close cdecl alias "wxDocument_Close" (byval self as integer) as integer
declare function wxDocument_Save cdecl alias "wxDocument_Save" (byval self as integer) as integer
declare function wxDocument_SaveAs cdecl alias "wxDocument_SaveAs" (byval self as integer) as integer
declare function wxDocument_Revert cdecl alias "wxDocument_Revert" (byval self as integer) as integer
declare function wxDocument_SaveObject cdecl alias "wxDocument_SaveObject" (byval self as integer,byval stream as integer) as integer
declare function wxDocument_LoadObject cdecl alias "wxDocument_LoadObject" (byval self as integer,byval stream as integer) as integer
declare function wxDocument_GetCommandProcessor cdecl alias "wxDocument_GetCommandProcessor" (byval self as integer) as integer
declare function wxDocument_SetCommandProcessor cdecl alias "wxDocument_SetCommandProcessor" (byval self as integer,byval proc as integer) as integer
declare function wxDocument_DeleteContents cdecl alias "wxDocument_DeleteContents" (byval self as integer) as integer
declare function wxDocument_Draw cdecl alias "wxDocument_Draw" (byval self as integer,byval dc as integer) as integer
declare function wxDocument_IsModified cdecl alias "wxDocument_IsModified" (byval self as integer) as integer
declare function wxDocument_Modify cdecl alias "wxDocument_Modify" (byval self as integer,byval mood as integer) as integer
declare function wxDocument_AddView cdecl alias "wxDocument_AddView" (byval self as integer,byval view as integer) as integer
declare function wxDocument_RemoveView cdecl alias "wxDocument_RemoveView" (byval self as integer,byval view as integer) as integer
declare function wxDocument_GetViews cdecl alias "wxDocument_GetViews" (byval self as integer) as integer
declare function wxDocument_GetFirstView cdecl alias "wxDocument_GetFirstView" (byval self as integer) as integer
declare function wxDocument_UpdateAllViews cdecl alias "wxDocument_UpdateAllViews" (byval self as integer,byval sender as integer,byval hint as integer) as integer
declare function wxDocument_NotifyClosing cdecl alias "wxDocument_NotifyClosing" (byval self as integer) as integer
declare function wxDocument_DeleteAllViews cdecl alias "wxDocument_DeleteAllViews" (byval self as integer) as integer
declare function wxDocument_GetDocumentManager cdecl alias "wxDocument_GetDocumentManager" (byval self as integer) as integer
declare function wxDocument_GetDocumentTemplate cdecl alias "wxDocument_GetDocumentTemplate" (byval self as integer) as integer
declare function wxDocument_SetDocumentTemplate cdecl alias "wxDocument_SetDocumentTemplate" (byval self as integer,byval temp as integer) as integer
declare function wxDocument_GetPrintableName cdecl alias "wxDocument_GetPrintableName" (byval self as integer,byval name as byte ptr) as integer
declare function wxDocument_GetDocumentWindow cdecl alias "wxDocument_GetDocumentWindow" (byval self as integer) as integer
declare function wxEraseEvent_ctor cdecl alias "wxEraseEvent_ctor" (byval type as integer) as integer
declare function wxEraseEvent_GetDC cdecl alias "wxEraseEvent_GetDC" (byval self as integer) as integer
declare function wxEvent_EVT_COMMAND_BUTTON_CLICKED cdecl alias "wxEvent_EVT_COMMAND_BUTTON_CLICKED" () as integer
declare function wxEvent_EVT_COMMAND_CHECKBOX_CLICKED cdecl alias "wxEvent_EVT_COMMAND_CHECKBOX_CLICKED" () as integer
declare function wxEvent_EVT_COMMAND_CHOICE_SELECTED cdecl alias "wxEvent_EVT_COMMAND_CHOICE_SELECTED" () as integer
declare function wxEvent_EVT_COMMAND_LISTBOX_SELECTED cdecl alias "wxEvent_EVT_COMMAND_LISTBOX_SELECTED" () as integer
declare function wxEvent_EVT_COMMAND_LISTBOX_DOUBLECLICKED cdecl alias "wxEvent_EVT_COMMAND_LISTBOX_DOUBLECLICKED" () as integer
declare function wxEvent_EVT_COMMAND_CHECKLISTBOX_TOGGLED cdecl alias "wxEvent_EVT_COMMAND_CHECKLISTBOX_TOGGLED" () as integer
declare function wxEvent_EVT_COMMAND_TEXT_UPDATED cdecl alias "wxEvent_EVT_COMMAND_TEXT_UPDATED" () as integer
declare function wxEvent_EVT_COMMAND_TEXT_ENTER cdecl alias "wxEvent_EVT_COMMAND_TEXT_ENTER" () as integer
declare function wxEvent_EVT_COMMAND_TEXT_URL cdecl alias "wxEvent_EVT_COMMAND_TEXT_URL" () as integer
declare function wxEvent_EVT_COMMAND_TEXT_MAXLEN cdecl alias "wxEvent_EVT_COMMAND_TEXT_MAXLEN" () as integer
declare function wxEvent_EVT_COMMAND_MENU_SELECTED cdecl alias "wxEvent_EVT_COMMAND_MENU_SELECTED" () as integer
declare function wxEvent_EVT_COMMAND_SLIDER_UPDATED cdecl alias "wxEvent_EVT_COMMAND_SLIDER_UPDATED" () as integer
declare function wxEvent_EVT_COMMAND_RADIOBOX_SELECTED cdecl alias "wxEvent_EVT_COMMAND_RADIOBOX_SELECTED" () as integer
declare function wxEvent_EVT_COMMAND_RADIOBUTTON_SELECTED cdecl alias "wxEvent_EVT_COMMAND_RADIOBUTTON_SELECTED" () as integer
declare function wxEvent_EVT_COMMAND_SCROLLBAR_UPDATED cdecl alias "wxEvent_EVT_COMMAND_SCROLLBAR_UPDATED" () as integer
declare function wxEvent_EVT_COMMAND_VLBOX_SELECTED cdecl alias "wxEvent_EVT_COMMAND_VLBOX_SELECTED" () as integer
declare function wxEvent_EVT_COMMAND_COMBOBOX_SELECTED cdecl alias "wxEvent_EVT_COMMAND_COMBOBOX_SELECTED" () as integer
declare function wxEvent_EVT_COMMAND_TOOL_RCLICKED cdecl alias "wxEvent_EVT_COMMAND_TOOL_RCLICKED" () as integer
declare function wxEvent_EVT_COMMAND_TOOL_ENTER cdecl alias "wxEvent_EVT_COMMAND_TOOL_ENTER" () as integer
declare function wxEvent_EVT_COMMAND_SPINCTRL_UPDATED cdecl alias "wxEvent_EVT_COMMAND_SPINCTRL_UPDATED" () as integer
declare function wxEvent_EVT_SOCKET cdecl alias "wxEvent_EVT_SOCKET" () as integer
declare function wxEvent_EVT_TIMER cdecl alias "wxEvent_EVT_TIMER" () as integer
declare function wxEvent_EVT_LEFT_DOWN cdecl alias "wxEvent_EVT_LEFT_DOWN" () as integer
declare function wxEvent_EVT_LEFT_UP cdecl alias "wxEvent_EVT_LEFT_UP" () as integer
declare function wxEvent_EVT_MIDDLE_DOWN cdecl alias "wxEvent_EVT_MIDDLE_DOWN" () as integer
declare function wxEvent_EVT_MIDDLE_UP cdecl alias "wxEvent_EVT_MIDDLE_UP" () as integer
declare function wxEvent_EVT_RIGHT_DOWN cdecl alias "wxEvent_EVT_RIGHT_DOWN" () as integer
declare function wxEvent_EVT_RIGHT_UP cdecl alias "wxEvent_EVT_RIGHT_UP" () as integer
declare function wxEvent_EVT_MOTION cdecl alias "wxEvent_EVT_MOTION" () as integer
declare function wxEvent_EVT_ENTER_WINDOW cdecl alias "wxEvent_EVT_ENTER_WINDOW" () as integer
declare function wxEvent_EVT_LEAVE_WINDOW cdecl alias "wxEvent_EVT_LEAVE_WINDOW" () as integer
declare function wxEvent_EVT_LEFT_DCLICK cdecl alias "wxEvent_EVT_LEFT_DCLICK" () as integer
declare function wxEvent_EVT_MIDDLE_DCLICK cdecl alias "wxEvent_EVT_MIDDLE_DCLICK" () as integer
declare function wxEvent_EVT_RIGHT_DCLICK cdecl alias "wxEvent_EVT_RIGHT_DCLICK" () as integer
declare function wxEvent_EVT_SET_FOCUS cdecl alias "wxEvent_EVT_SET_FOCUS" () as integer
declare function wxEvent_EVT_KILL_FOCUS cdecl alias "wxEvent_EVT_KILL_FOCUS" () as integer
declare function wxEvent_EVT_CHILD_FOCUS cdecl alias "wxEvent_EVT_CHILD_FOCUS" () as integer
declare function wxEvent_EVT_MOUSEWHEEL cdecl alias "wxEvent_EVT_MOUSEWHEEL" () as integer
declare function wxEvent_EVT_NC_LEFT_DOWN cdecl alias "wxEvent_EVT_NC_LEFT_DOWN" () as integer
declare function wxEvent_EVT_NC_LEFT_UP cdecl alias "wxEvent_EVT_NC_LEFT_UP" () as integer
declare function wxEvent_EVT_NC_MIDDLE_DOWN cdecl alias "wxEvent_EVT_NC_MIDDLE_DOWN" () as integer
declare function wxEvent_EVT_NC_MIDDLE_UP cdecl alias "wxEvent_EVT_NC_MIDDLE_UP" () as integer
declare function wxEvent_EVT_NC_RIGHT_DOWN cdecl alias "wxEvent_EVT_NC_RIGHT_DOWN" () as integer
declare function wxEvent_EVT_NC_RIGHT_UP cdecl alias "wxEvent_EVT_NC_RIGHT_UP" () as integer
declare function wxEvent_EVT_NC_MOTION cdecl alias "wxEvent_EVT_NC_MOTION" () as integer
declare function wxEvent_EVT_NC_ENTER_WINDOW cdecl alias "wxEvent_EVT_NC_ENTER_WINDOW" () as integer
declare function wxEvent_EVT_NC_LEAVE_WINDOW cdecl alias "wxEvent_EVT_NC_LEAVE_WINDOW" () as integer
declare function wxEvent_EVT_NC_LEFT_DCLICK cdecl alias "wxEvent_EVT_NC_LEFT_DCLICK" () as integer
declare function wxEvent_EVT_NC_MIDDLE_DCLICK cdecl alias "wxEvent_EVT_NC_MIDDLE_DCLICK" () as integer
declare function wxEvent_EVT_NC_RIGHT_DCLICK cdecl alias "wxEvent_EVT_NC_RIGHT_DCLICK" () as integer
declare function wxEvent_EVT_CHAR cdecl alias "wxEvent_EVT_CHAR" () as integer
declare function wxEvent_EVT_CHAR_HOOK cdecl alias "wxEvent_EVT_CHAR_HOOK" () as integer
declare function wxEvent_EVT_NAVIGATION_KEY cdecl alias "wxEvent_EVT_NAVIGATION_KEY" () as integer
declare function wxEvent_EVT_KEY_DOWN cdecl alias "wxEvent_EVT_KEY_DOWN" () as integer
declare function wxEvent_EVT_KEY_UP cdecl alias "wxEvent_EVT_KEY_UP" () as integer
declare function wxEvent_EVT_SET_CURSOR cdecl alias "wxEvent_EVT_SET_CURSOR" () as integer
declare function wxEvent_EVT_SCROLL_TOP cdecl alias "wxEvent_EVT_SCROLL_TOP" () as integer
declare function wxEvent_EVT_SCROLL_BOTTOM cdecl alias "wxEvent_EVT_SCROLL_BOTTOM" () as integer
declare function wxEvent_EVT_SCROLL_LINEUP cdecl alias "wxEvent_EVT_SCROLL_LINEUP" () as integer
declare function wxEvent_EVT_SCROLL_LINEDOWN cdecl alias "wxEvent_EVT_SCROLL_LINEDOWN" () as integer
declare function wxEvent_EVT_SCROLL_PAGEUP cdecl alias "wxEvent_EVT_SCROLL_PAGEUP" () as integer
declare function wxEvent_EVT_SCROLL_PAGEDOWN cdecl alias "wxEvent_EVT_SCROLL_PAGEDOWN" () as integer
declare function wxEvent_EVT_SCROLL_THUMBTRACK cdecl alias "wxEvent_EVT_SCROLL_THUMBTRACK" () as integer
declare function wxEvent_EVT_SCROLL_THUMBRELEASE cdecl alias "wxEvent_EVT_SCROLL_THUMBRELEASE" () as integer
declare function wxEvent_EVT_SCROLL_ENDSCROLL cdecl alias "wxEvent_EVT_SCROLL_ENDSCROLL" () as integer
declare function wxEvent_EVT_SCROLLWIN_TOP cdecl alias "wxEvent_EVT_SCROLLWIN_TOP" () as integer
declare function wxEvent_EVT_SCROLLWIN_BOTTOM cdecl alias "wxEvent_EVT_SCROLLWIN_BOTTOM" () as integer
declare function wxEvent_EVT_SCROLLWIN_LINEUP cdecl alias "wxEvent_EVT_SCROLLWIN_LINEUP" () as integer
declare function wxEvent_EVT_SCROLLWIN_LINEDOWN cdecl alias "wxEvent_EVT_SCROLLWIN_LINEDOWN" () as integer
declare function wxEvent_EVT_SCROLLWIN_PAGEUP cdecl alias "wxEvent_EVT_SCROLLWIN_PAGEUP" () as integer
declare function wxEvent_EVT_SCROLLWIN_PAGEDOWN cdecl alias "wxEvent_EVT_SCROLLWIN_PAGEDOWN" () as integer
declare function wxEvent_EVT_SCROLLWIN_THUMBTRACK cdecl alias "wxEvent_EVT_SCROLLWIN_THUMBTRACK" () as integer
declare function wxEvent_EVT_SCROLLWIN_THUMBRELEASE cdecl alias "wxEvent_EVT_SCROLLWIN_THUMBRELEASE" () as integer
declare function wxEvent_EVT_SIZE cdecl alias "wxEvent_EVT_SIZE" () as integer
declare function wxEvent_EVT_MOVE cdecl alias "wxEvent_EVT_MOVE" () as integer
declare function wxEvent_EVT_CLOSE_WINDOW cdecl alias "wxEvent_EVT_CLOSE_WINDOW" () as integer
declare function wxEvent_EVT_END_SESSION cdecl alias "wxEvent_EVT_END_SESSION" () as integer
declare function wxEvent_EVT_QUERY_END_SESSION cdecl alias "wxEvent_EVT_QUERY_END_SESSION" () as integer
declare function wxEvent_EVT_ACTIVATE_APP cdecl alias "wxEvent_EVT_ACTIVATE_APP" () as integer
declare function wxEvent_EVT_POWER cdecl alias "wxEvent_EVT_POWER" () as integer
declare function wxEvent_EVT_ACTIVATE cdecl alias "wxEvent_EVT_ACTIVATE" () as integer
declare function wxEvent_EVT_CREATE cdecl alias "wxEvent_EVT_CREATE" () as integer
declare function wxEvent_EVT_DESTROY cdecl alias "wxEvent_EVT_DESTROY" () as integer
declare function wxEvent_EVT_SHOW cdecl alias "wxEvent_EVT_SHOW" () as integer
declare function wxEvent_EVT_ICONIZE cdecl alias "wxEvent_EVT_ICONIZE" () as integer
declare function wxEvent_EVT_MAXIMIZE cdecl alias "wxEvent_EVT_MAXIMIZE" () as integer
declare function wxEvent_EVT_MOUSE_CAPTURE_CHANGED cdecl alias "wxEvent_EVT_MOUSE_CAPTURE_CHANGED" () as integer
declare function wxEvent_EVT_PAINT cdecl alias "wxEvent_EVT_PAINT" () as integer
declare function wxEvent_EVT_ERASE_BACKGROUND cdecl alias "wxEvent_EVT_ERASE_BACKGROUND" () as integer
declare function wxEvent_EVT_NC_PAINT cdecl alias "wxEvent_EVT_NC_PAINT" () as integer
declare function wxEvent_EVT_PAINT_ICON cdecl alias "wxEvent_EVT_PAINT_ICON" () as integer
declare function wxEvent_EVT_MENU_OPEN cdecl alias "wxEvent_EVT_MENU_OPEN" () as integer
declare function wxEvent_EVT_MENU_CLOSE cdecl alias "wxEvent_EVT_MENU_CLOSE" () as integer
declare function wxEvent_EVT_MENU_HIGHLIGHT cdecl alias "wxEvent_EVT_MENU_HIGHLIGHT" () as integer
declare function wxEvent_EVT_CONTEXT_MENU cdecl alias "wxEvent_EVT_CONTEXT_MENU" () as integer
declare function wxEvent_EVT_SYS_COLOUR_CHANGED cdecl alias "wxEvent_EVT_SYS_COLOUR_CHANGED" () as integer
declare function wxEvent_EVT_DISPLAY_CHANGED cdecl alias "wxEvent_EVT_DISPLAY_CHANGED" () as integer
declare function wxEvent_EVT_SETTING_CHANGED cdecl alias "wxEvent_EVT_SETTING_CHANGED" () as integer
declare function wxEvent_EVT_QUERY_NEW_PALETTE cdecl alias "wxEvent_EVT_QUERY_NEW_PALETTE" () as integer
declare function wxEvent_EVT_PALETTE_CHANGED cdecl alias "wxEvent_EVT_PALETTE_CHANGED" () as integer
declare function wxEvent_EVT_JOY_BUTTON_DOWN cdecl alias "wxEvent_EVT_JOY_BUTTON_DOWN" () as integer
declare function wxEvent_EVT_JOY_BUTTON_UP cdecl alias "wxEvent_EVT_JOY_BUTTON_UP" () as integer
declare function wxEvent_EVT_JOY_MOVE cdecl alias "wxEvent_EVT_JOY_MOVE" () as integer
declare function wxEvent_EVT_JOY_ZMOVE cdecl alias "wxEvent_EVT_JOY_ZMOVE" () as integer
declare function wxEvent_EVT_DROP_FILES cdecl alias "wxEvent_EVT_DROP_FILES" () as integer
declare function wxEvent_EVT_DRAW_ITEM cdecl alias "wxEvent_EVT_DRAW_ITEM" () as integer
declare function wxEvent_EVT_MEASURE_ITEM cdecl alias "wxEvent_EVT_MEASURE_ITEM" () as integer
declare function wxEvent_EVT_COMPARE_ITEM cdecl alias "wxEvent_EVT_COMPARE_ITEM" () as integer
declare function wxEvent_EVT_INIT_DIALOG cdecl alias "wxEvent_EVT_INIT_DIALOG" () as integer
declare function wxEvent_EVT_IDLE cdecl alias "wxEvent_EVT_IDLE" () as integer
declare function wxEvent_EVT_UPDATE_UI cdecl alias "wxEvent_EVT_UPDATE_UI" () as integer
declare function wxEvent_EVT_SIZING cdecl alias "wxEvent_EVT_SIZING" () as integer
declare function wxEvent_EVT_MOVING cdecl alias "wxEvent_EVT_MOVING" () as integer
declare function wxEvent_EVT_COMMAND_LEFT_CLICK cdecl alias "wxEvent_EVT_COMMAND_LEFT_CLICK" () as integer
declare function wxEvent_EVT_COMMAND_LEFT_DCLICK cdecl alias "wxEvent_EVT_COMMAND_LEFT_DCLICK" () as integer
declare function wxEvent_EVT_COMMAND_RIGHT_CLICK cdecl alias "wxEvent_EVT_COMMAND_RIGHT_CLICK" () as integer
declare function wxEvent_EVT_COMMAND_RIGHT_DCLICK cdecl alias "wxEvent_EVT_COMMAND_RIGHT_DCLICK" () as integer
declare function wxEvent_EVT_COMMAND_SET_FOCUS cdecl alias "wxEvent_EVT_COMMAND_SET_FOCUS" () as integer
declare function wxEvent_EVT_COMMAND_KILL_FOCUS cdecl alias "wxEvent_EVT_COMMAND_KILL_FOCUS" () as integer
declare function wxEvent_EVT_COMMAND_ENTER cdecl alias "wxEvent_EVT_COMMAND_ENTER" () as integer
declare function wxEvent_EVT_HELP cdecl alias "wxEvent_EVT_HELP" () as integer
declare function wxEvent_EVT_DETAILED_HELP cdecl alias "wxEvent_EVT_DETAILED_HELP" () as integer
declare function wxEvent_EVT_COMMAND_TOGGLEBUTTON_CLICKED cdecl alias "wxEvent_EVT_COMMAND_TOGGLEBUTTON_CLICKED" () as integer
declare function wxEvent_EVT_OBJECTDELETED cdecl alias "wxEvent_EVT_OBJECTDELETED" () as integer
declare function wxEvent_EVT_CALENDAR_SEL_CHANGED cdecl alias "wxEvent_EVT_CALENDAR_SEL_CHANGED" () as integer
declare function wxEvent_EVT_CALENDAR_DAY_CHANGED cdecl alias "wxEvent_EVT_CALENDAR_DAY_CHANGED" () as integer
declare function wxEvent_EVT_CALENDAR_MONTH_CHANGED cdecl alias "wxEvent_EVT_CALENDAR_MONTH_CHANGED" () as integer
declare function wxEvent_EVT_CALENDAR_YEAR_CHANGED cdecl alias "wxEvent_EVT_CALENDAR_YEAR_CHANGED" () as integer
declare function wxEvent_EVT_CALENDAR_DOUBLECLICKED cdecl alias "wxEvent_EVT_CALENDAR_DOUBLECLICKED" () as integer
declare function wxEvent_EVT_CALENDAR_WEEKDAY_CLICKED cdecl alias "wxEvent_EVT_CALENDAR_WEEKDAY_CLICKED" () as integer
declare function wxEvent_EVT_COMMAND_FIND cdecl alias "wxEvent_EVT_COMMAND_FIND" () as integer
declare function wxEvent_EVT_COMMAND_FIND_NEXT cdecl alias "wxEvent_EVT_COMMAND_FIND_NEXT" () as integer
declare function wxEvent_EVT_COMMAND_FIND_REPLACE cdecl alias "wxEvent_EVT_COMMAND_FIND_REPLACE" () as integer
declare function wxEvent_EVT_COMMAND_FIND_REPLACE_ALL cdecl alias "wxEvent_EVT_COMMAND_FIND_REPLACE_ALL" () as integer
declare function wxEvent_EVT_COMMAND_FIND_CLOSE cdecl alias "wxEvent_EVT_COMMAND_FIND_CLOSE" () as integer
declare function wxEvent_EVT_COMMAND_TREE_BEGIN_DRAG cdecl alias "wxEvent_EVT_COMMAND_TREE_BEGIN_DRAG" () as integer
declare function wxEvent_EVT_COMMAND_TREE_BEGIN_RDRAG cdecl alias "wxEvent_EVT_COMMAND_TREE_BEGIN_RDRAG" () as integer
declare function wxEvent_EVT_COMMAND_TREE_BEGIN_LABEL_EDIT cdecl alias "wxEvent_EVT_COMMAND_TREE_BEGIN_LABEL_EDIT" () as integer
declare function wxEvent_EVT_COMMAND_TREE_END_LABEL_EDIT cdecl alias "wxEvent_EVT_COMMAND_TREE_END_LABEL_EDIT" () as integer
declare function wxEvent_EVT_COMMAND_TREE_DELETE_ITEM cdecl alias "wxEvent_EVT_COMMAND_TREE_DELETE_ITEM" () as integer
declare function wxEvent_EVT_COMMAND_TREE_GET_INFO cdecl alias "wxEvent_EVT_COMMAND_TREE_GET_INFO" () as integer
declare function wxEvent_EVT_COMMAND_TREE_SET_INFO cdecl alias "wxEvent_EVT_COMMAND_TREE_SET_INFO" () as integer
declare function wxEvent_EVT_COMMAND_TREE_ITEM_EXPANDED cdecl alias "wxEvent_EVT_COMMAND_TREE_ITEM_EXPANDED" () as integer
declare function wxEvent_EVT_COMMAND_TREE_ITEM_EXPANDING cdecl alias "wxEvent_EVT_COMMAND_TREE_ITEM_EXPANDING" () as integer
declare function wxEvent_EVT_COMMAND_TREE_ITEM_COLLAPSED cdecl alias "wxEvent_EVT_COMMAND_TREE_ITEM_COLLAPSED" () as integer
declare function wxEvent_EVT_COMMAND_TREE_ITEM_COLLAPSING cdecl alias "wxEvent_EVT_COMMAND_TREE_ITEM_COLLAPSING" () as integer
declare function wxEvent_EVT_COMMAND_TREE_SEL_CHANGED cdecl alias "wxEvent_EVT_COMMAND_TREE_SEL_CHANGED" () as integer
declare function wxEvent_EVT_COMMAND_TREE_SEL_CHANGING cdecl alias "wxEvent_EVT_COMMAND_TREE_SEL_CHANGING" () as integer
declare function wxEvent_EVT_COMMAND_TREE_KEY_DOWN cdecl alias "wxEvent_EVT_COMMAND_TREE_KEY_DOWN" () as integer
declare function wxEvent_EVT_COMMAND_TREE_ITEM_ACTIVATED cdecl alias "wxEvent_EVT_COMMAND_TREE_ITEM_ACTIVATED" () as integer
declare function wxEvent_EVT_COMMAND_TREE_ITEM_RIGHT_CLICK cdecl alias "wxEvent_EVT_COMMAND_TREE_ITEM_RIGHT_CLICK" () as integer
declare function wxEvent_EVT_COMMAND_TREE_ITEM_MIDDLE_CLICK cdecl alias "wxEvent_EVT_COMMAND_TREE_ITEM_MIDDLE_CLICK" () as integer
declare function wxEvent_EVT_COMMAND_TREE_END_DRAG cdecl alias "wxEvent_EVT_COMMAND_TREE_END_DRAG" () as integer
declare function wxEvent_EVT_COMMAND_LIST_BEGIN_DRAG cdecl alias "wxEvent_EVT_COMMAND_LIST_BEGIN_DRAG" () as integer
declare function wxEvent_EVT_COMMAND_LIST_BEGIN_RDRAG cdecl alias "wxEvent_EVT_COMMAND_LIST_BEGIN_RDRAG" () as integer
declare function wxEvent_EVT_COMMAND_LIST_BEGIN_LABEL_EDIT cdecl alias "wxEvent_EVT_COMMAND_LIST_BEGIN_LABEL_EDIT" () as integer
declare function wxEvent_EVT_COMMAND_LIST_END_LABEL_EDIT cdecl alias "wxEvent_EVT_COMMAND_LIST_END_LABEL_EDIT" () as integer
declare function wxEvent_EVT_COMMAND_LIST_DELETE_ITEM cdecl alias "wxEvent_EVT_COMMAND_LIST_DELETE_ITEM" () as integer
declare function wxEvent_EVT_COMMAND_LIST_DELETE_ALL_ITEMS cdecl alias "wxEvent_EVT_COMMAND_LIST_DELETE_ALL_ITEMS" () as integer
declare function wxEvent_EVT_COMMAND_LIST_GET_INFO cdecl alias "wxEvent_EVT_COMMAND_LIST_GET_INFO" () as integer
declare function wxEvent_EVT_COMMAND_LIST_SET_INFO cdecl alias "wxEvent_EVT_COMMAND_LIST_SET_INFO" () as integer
declare function wxEvent_EVT_COMMAND_LIST_ITEM_SELECTED cdecl alias "wxEvent_EVT_COMMAND_LIST_ITEM_SELECTED" () as integer
declare function wxEvent_EVT_COMMAND_LIST_ITEM_DESELECTED cdecl alias "wxEvent_EVT_COMMAND_LIST_ITEM_DESELECTED" () as integer
declare function wxEvent_EVT_COMMAND_LIST_ITEM_ACTIVATED cdecl alias "wxEvent_EVT_COMMAND_LIST_ITEM_ACTIVATED" () as integer
declare function wxEvent_EVT_COMMAND_LIST_ITEM_FOCUSED cdecl alias "wxEvent_EVT_COMMAND_LIST_ITEM_FOCUSED" () as integer
declare function wxEvent_EVT_COMMAND_LIST_ITEM_MIDDLE_CLICK cdecl alias "wxEvent_EVT_COMMAND_LIST_ITEM_MIDDLE_CLICK" () as integer
declare function wxEvent_EVT_COMMAND_LIST_ITEM_RIGHT_CLICK cdecl alias "wxEvent_EVT_COMMAND_LIST_ITEM_RIGHT_CLICK" () as integer
declare function wxEvent_EVT_COMMAND_LIST_KEY_DOWN cdecl alias "wxEvent_EVT_COMMAND_LIST_KEY_DOWN" () as integer
declare function wxEvent_EVT_COMMAND_LIST_INSERT_ITEM cdecl alias "wxEvent_EVT_COMMAND_LIST_INSERT_ITEM" () as integer
declare function wxEvent_EVT_COMMAND_LIST_COL_CLICK cdecl alias "wxEvent_EVT_COMMAND_LIST_COL_CLICK" () as integer
declare function wxEvent_EVT_COMMAND_LIST_COL_RIGHT_CLICK cdecl alias "wxEvent_EVT_COMMAND_LIST_COL_RIGHT_CLICK" () as integer
declare function wxEvent_EVT_COMMAND_LIST_COL_BEGIN_DRAG cdecl alias "wxEvent_EVT_COMMAND_LIST_COL_BEGIN_DRAG" () as integer
declare function wxEvent_EVT_COMMAND_LIST_COL_DRAGGING cdecl alias "wxEvent_EVT_COMMAND_LIST_COL_DRAGGING" () as integer
declare function wxEvent_EVT_COMMAND_LIST_COL_END_DRAG cdecl alias "wxEvent_EVT_COMMAND_LIST_COL_END_DRAG" () as integer
declare function wxEvent_EVT_COMMAND_LIST_CACHE_HINT cdecl alias "wxEvent_EVT_COMMAND_LIST_CACHE_HINT" () as integer
declare function wxEvent_EVT_COMMAND_NOTEBOOK_PAGE_CHANGED cdecl alias "wxEvent_EVT_COMMAND_NOTEBOOK_PAGE_CHANGED" () as integer
declare function wxEvent_EVT_COMMAND_NOTEBOOK_PAGE_CHANGING cdecl alias "wxEvent_EVT_COMMAND_NOTEBOOK_PAGE_CHANGING" () as integer
declare function wxEvent_EVT_COMMAND_LISTBOOK_PAGE_CHANGED cdecl alias "wxEvent_EVT_COMMAND_LISTBOOK_PAGE_CHANGED" () as integer
declare function wxEvent_EVT_COMMAND_LISTBOOK_PAGE_CHANGING cdecl alias "wxEvent_EVT_COMMAND_LISTBOOK_PAGE_CHANGING" () as integer
declare function wxEvent_EVT_GRID_CELL_LEFT_CLICK cdecl alias "wxEvent_EVT_GRID_CELL_LEFT_CLICK" () as integer
declare function wxEvent_EVT_GRID_CELL_RIGHT_CLICK cdecl alias "wxEvent_EVT_GRID_CELL_RIGHT_CLICK" () as integer
declare function wxEvent_EVT_GRID_CELL_LEFT_DCLICK cdecl alias "wxEvent_EVT_GRID_CELL_LEFT_DCLICK" () as integer
declare function wxEvent_EVT_GRID_CELL_RIGHT_DCLICK cdecl alias "wxEvent_EVT_GRID_CELL_RIGHT_DCLICK" () as integer
declare function wxEvent_EVT_GRID_LABEL_LEFT_CLICK cdecl alias "wxEvent_EVT_GRID_LABEL_LEFT_CLICK" () as integer
declare function wxEvent_EVT_GRID_LABEL_RIGHT_CLICK cdecl alias "wxEvent_EVT_GRID_LABEL_RIGHT_CLICK" () as integer
declare function wxEvent_EVT_GRID_LABEL_LEFT_DCLICK cdecl alias "wxEvent_EVT_GRID_LABEL_LEFT_DCLICK" () as integer
declare function wxEvent_EVT_GRID_LABEL_RIGHT_DCLICK cdecl alias "wxEvent_EVT_GRID_LABEL_RIGHT_DCLICK" () as integer
declare function wxEvent_EVT_GRID_ROW_SIZE cdecl alias "wxEvent_EVT_GRID_ROW_SIZE" () as integer
declare function wxEvent_EVT_GRID_COL_SIZE cdecl alias "wxEvent_EVT_GRID_COL_SIZE" () as integer
declare function wxEvent_EVT_GRID_RANGE_SELECT cdecl alias "wxEvent_EVT_GRID_RANGE_SELECT" () as integer
declare function wxEvent_EVT_GRID_CELL_CHANGE cdecl alias "wxEvent_EVT_GRID_CELL_CHANGE" () as integer
declare function wxEvent_EVT_GRID_SELECT_CELL cdecl alias "wxEvent_EVT_GRID_SELECT_CELL" () as integer
declare function wxEvent_EVT_GRID_EDITOR_SHOWN cdecl alias "wxEvent_EVT_GRID_EDITOR_SHOWN" () as integer
declare function wxEvent_EVT_GRID_EDITOR_HIDDEN cdecl alias "wxEvent_EVT_GRID_EDITOR_HIDDEN" () as integer
declare function wxEvent_EVT_GRID_EDITOR_CREATED cdecl alias "wxEvent_EVT_GRID_EDITOR_CREATED" () as integer
declare function wxEvent_EVT_SASH_DRAGGED cdecl alias "wxEvent_EVT_SASH_DRAGGED" () as integer
declare function wxEvent_EVT_QUERY_LAYOUT_INFO cdecl alias "wxEvent_EVT_QUERY_LAYOUT_INFO" () as integer
declare function wxEvent_EVT_CALCULATE_LAYOUT cdecl alias "wxEvent_EVT_CALCULATE_LAYOUT" () as integer
declare function wxEvent_GetEventType cdecl alias "wxEvent_GetEventType" (byval self as integer) as integer
declare function wxEvent_GetId cdecl alias "wxEvent_GetId" (byval self as integer) as integer
declare function wxEvent_GetSkipped cdecl alias "wxEvent_GetSkipped" (byval self as integer) as integer
declare function wxEvent_GetTimestamp cdecl alias "wxEvent_GetTimestamp" (byval self as integer) as integer
declare function wxEvent_Skip cdecl alias "wxEvent_Skip" (byval self as integer,byval skip as integer) as integer
declare function wxEvent_GetEventObject cdecl alias "wxEvent_GetEventObject" (byval self as integer) as integer
declare function wxEvtHandler_proxy cdecl alias "wxEvtHandler_proxy" (byval self as integer,byval listener as integer) as integer
declare function wxEvtHandler_Connect cdecl alias "wxEvtHandler_Connect" (byval self as integer,byval evtType as integer,byval id as integer,byval lastId as integer,byval iListener as integer) as integer
declare function wxEvtHandler_ProcessEvent cdecl alias "wxEvtHandler_ProcessEvent" (byval self as integer,byval event as integer) as integer
declare function wxEvtHandler_AddPendingEvent cdecl alias "wxEvtHandler_AddPendingEvent" (byval self as integer,byval event as integer) as integer
declare function wxFileDialog_ctor cdecl alias "wxFileDialog_ctor" (byval parent as integer,byval message as string,byval defaultDir as string,byval defaultFile as string,byval wildcard as string,byval style as long,byval pos as integer) as integer
declare function wxFileDialog_dtor cdecl alias "wxFileDialog_dtor" (byval self as integer) as integer
declare function wxFileDialog_ShowModal cdecl alias "wxFileDialog_ShowModal" (byval self as integer) as integer
declare function wxFileDialog_GetDirectory cdecl alias "wxFileDialog_GetDirectory" (byval self as integer) as byte ptr
declare function wxFileDialog_SetDirectory cdecl alias "wxFileDialog_SetDirectory" (byval self as integer,byval dir as string) as integer
declare function wxFileDialog_GetFilename cdecl alias "wxFileDialog_GetFilename" (byval self as integer) as byte ptr
declare function wxFileDialog_SetFilename cdecl alias "wxFileDialog_SetFilename" (byval self as integer,byval filename as string) as integer
declare function wxFileDialog_GetPath cdecl alias "wxFileDialog_GetPath" (byval self as integer) as byte ptr
declare function wxFileDialog_SetPath cdecl alias "wxFileDialog_SetPath" (byval self as integer,byval path as string) as integer
declare function wxFileDialog_SetFilterIndex cdecl alias "wxFileDialog_SetFilterIndex" (byval self as integer,byval filterindex as integer) as integer
declare function wxFileDialog_GetFilterIndex cdecl alias "wxFileDialog_GetFilterIndex" (byval self as integer) as integer
declare function wxFileDialog_SetMessage cdecl alias "wxFileDialog_SetMessage" (byval self as integer,byval message as string) as integer
declare function wxFileDialog_GetMessage cdecl alias "wxFileDialog_GetMessage" (byval self as integer) as byte ptr
declare function wxFileDialog_GetWildcard cdecl alias "wxFileDialog_GetWildcard" (byval self as integer) as byte ptr
declare function wxFileDialog_SetWildcard cdecl alias "wxFileDialog_SetWildcard" (byval self as integer,byval wildcard as string) as integer
declare function wxFileDialog_SetStyle cdecl alias "wxFileDialog_SetStyle" (byval self as integer,byval style as integer) as integer
declare function wxFileDialog_GetStyle cdecl alias "wxFileDialog_GetStyle" (byval self as integer) as integer
declare function wxFileDialog_GetPaths cdecl alias "wxFileDialog_GetPaths" (byval self as integer) as integer
declare function wxFileDialog_GetFilenames cdecl alias "wxFileDialog_GetFilenames" (byval self as integer) as integer
declare function wxFindReplaceDialog_ctor cdecl alias "wxFindReplaceDialog_ctor" () as integer
declare function wxFindReplaceDialog_Create cdecl alias "wxFindReplaceDialog_Create" (byval self as integer,byval parent as integer,byval data as integer,byval title as string,byval style as integer) as integer
declare function wxFindReplaceDialog_GetData cdecl alias "wxFindReplaceDialog_GetData" (byval self as integer) as integer
declare function wxFindReplaceDialog_SetData cdecl alias "wxFindReplaceDialog_SetData" (byval self as integer,byval data as integer) as integer
declare function wxFindDialogEvent_ctor cdecl alias "wxFindDialogEvent_ctor" (byval commandType as integer,byval id as integer) as integer
declare function wxFindDialogEvent_GetFlags cdecl alias "wxFindDialogEvent_GetFlags" (byval self as integer) as integer
declare function wxFindDialogEvent_GetFindString cdecl alias "wxFindDialogEvent_GetFindString" (byval self as integer) as byte ptr
declare function wxFindDialogEvent_GetReplaceString cdecl alias "wxFindDialogEvent_GetReplaceString" (byval self as integer) as byte ptr
declare function wxFindDialogEvent_GetDialog cdecl alias "wxFindDialogEvent_GetDialog" (byval self as integer) as integer
declare function wxFindDialogEvent_SetFlags cdecl alias "wxFindDialogEvent_SetFlags" (byval self as integer,byval flags as integer) as integer
declare function wxFindDialogEvent_SetFindString cdecl alias "wxFindDialogEvent_SetFindString" (byval self as integer,byval str as string) as integer
declare function wxFindDialogEvent_SetReplaceString cdecl alias "wxFindDialogEvent_SetReplaceString" (byval self as integer,byval str as string) as integer
declare function wxFindReplaceData_ctor cdecl alias "wxFindReplaceData_ctor" () as integer
declare function wxFindReplaceData_GetFindString cdecl alias "wxFindReplaceData_GetFindString" (byval self as integer) as byte ptr
declare function wxFindReplaceData_GetReplaceString cdecl alias "wxFindReplaceData_GetReplaceString" (byval self as integer) as byte ptr
declare function wxFindReplaceData_GetFlags cdecl alias "wxFindReplaceData_GetFlags" (byval self as integer) as integer
declare function wxFindReplaceData_SetFlags cdecl alias "wxFindReplaceData_SetFlags" (byval self as integer,byval flags as integer) as integer
declare function wxFindReplaceData_SetFindString cdecl alias "wxFindReplaceData_SetFindString" (byval self as integer,byval str as string) as integer
declare function wxFindReplaceData_SetReplaceString cdecl alias "wxFindReplaceData_SetReplaceString" (byval self as integer,byval str as string) as integer
declare function wxFlexGridSizer_ctor cdecl alias "wxFlexGridSizer_ctor" (byval rows as integer,byval cols as integer,byval vgap as integer,byval hgap as integer) as integer
declare function wxFlexGridSizer_dtor cdecl alias "wxFlexGridSizer_dtor" (byval self as integer) as integer
declare function wxFlexGridSizer_RecalcSizes cdecl alias "wxFlexGridSizer_RecalcSizes" (byval self as integer) as integer
declare function wxFlexGridSizer_CalcMin cdecl alias "wxFlexGridSizer_CalcMin" (byval self as integer,byval size as integer) as integer
declare function wxFlexGridSizer_AddGrowableRow cdecl alias "wxFlexGridSizer_AddGrowableRow" (byval self as integer,byval idx as integer) as integer
declare function wxFlexGridSizer_RemoveGrowableRow cdecl alias "wxFlexGridSizer_RemoveGrowableRow" (byval self as integer,byval idx as integer) as integer
declare function wxFlexGridSizer_AddGrowableCol cdecl alias "wxFlexGridSizer_AddGrowableCol" (byval self as integer,byval idx as integer) as integer
declare function wxFlexGridSizer_RemoveGrowableCol cdecl alias "wxFlexGridSizer_RemoveGrowableCol" (byval self as integer,byval idx as integer) as integer
declare function wxFocusEvent_ctor cdecl alias "wxFocusEvent_ctor" (byval type as integer) as integer
declare function wxFocusEvent_GetWindow cdecl alias "wxFocusEvent_GetWindow" (byval self as integer) as integer
declare function wxFocusEvent_SetWindow cdecl alias "wxFocusEvent_SetWindow" (byval self as integer,byval win as integer) as integer
declare function wxFont_NORMAL_FONT cdecl alias "wxFont_NORMAL_FONT" () as integer
declare function wxFont_SMALL_FONT cdecl alias "wxFont_SMALL_FONT" () as integer
declare function wxFont_ITALIC_FONT cdecl alias "wxFont_ITALIC_FONT" () as integer
declare function wxFont_SWISS_FONT cdecl alias "wxFont_SWISS_FONT" () as integer
declare function wxFont_ctorDef cdecl alias "wxFont_ctorDef" () as integer
declare function wxFont_ctor cdecl alias "wxFont_ctor" (byval pointSize as integer,byval family as integer,byval style as integer,byval weight as integer,byval underline as integer,byval faceName as string,byval encoding as integer) as integer
declare function wxFont_dtor cdecl alias "wxFont_dtor" (byval self as integer) as integer
declare function wxFont_Ok cdecl alias "wxFont_Ok" (byval self as integer) as integer
declare function wxFont_GetPointSize cdecl alias "wxFont_GetPointSize" (byval self as integer) as integer
declare function wxFont_GetFamily cdecl alias "wxFont_GetFamily" (byval self as integer) as integer
declare function wxFont_GetStyle cdecl alias "wxFont_GetStyle" (byval self as integer) as integer
declare function wxFont_GetWeight cdecl alias "wxFont_GetWeight" (byval self as integer) as integer
declare function wxFont_GetUnderlined cdecl alias "wxFont_GetUnderlined" (byval self as integer) as integer
declare function wxFont_GetFaceName cdecl alias "wxFont_GetFaceName" (byval self as integer) as byte ptr
declare function wxFont_GetEncoding cdecl alias "wxFont_GetEncoding" (byval self as integer) as integer
declare function wxFont_GetNativeFontInfo cdecl alias "wxFont_GetNativeFontInfo" (byval self as integer) as integer
declare function wxFont_IsFixedWidth cdecl alias "wxFont_IsFixedWidth" (byval self as integer) as integer
declare function wxFont_GetNativeFontInfoDesc cdecl alias "wxFont_GetNativeFontInfoDesc" (byval self as integer) as byte ptr
declare function wxFont_GetNativeFontInfoUserDesc cdecl alias "wxFont_GetNativeFontInfoUserDesc" (byval self as integer) as byte ptr
declare function wxFont_SetPointSize cdecl alias "wxFont_SetPointSize" (byval self as integer,byval pointSize as integer) as integer
declare function wxFont_SetFamily cdecl alias "wxFont_SetFamily" (byval self as integer,byval family as integer) as integer
declare function wxFont_SetStyle cdecl alias "wxFont_SetStyle" (byval self as integer,byval style as integer) as integer
declare function wxFont_SetWeight cdecl alias "wxFont_SetWeight" (byval self as integer,byval weight as integer) as integer
declare function wxFont_SetFaceName cdecl alias "wxFont_SetFaceName" (byval self as integer,byval faceName as string) as integer
declare function wxFont_SetUnderlined cdecl alias "wxFont_SetUnderlined" (byval self as integer,byval underlined as integer) as integer
declare function wxFont_SetEncoding cdecl alias "wxFont_SetEncoding" (byval self as integer,byval encoding as integer) as integer
declare function wxFont_SetNativeFontInfoUserDesc cdecl alias "wxFont_SetNativeFontInfoUserDesc" (byval self as integer,byval info as string) as integer
declare function wxFont_GetFamilyString cdecl alias "wxFont_GetFamilyString" (byval self as integer) as byte ptr
declare function wxFont_GetStyleString cdecl alias "wxFont_GetStyleString" (byval self as integer) as byte ptr
declare function wxFont_GetWeightString cdecl alias "wxFont_GetWeightString" (byval self as integer) as byte ptr
declare function wxFont_SetNoAntiAliasing cdecl alias "wxFont_SetNoAntiAliasing" (byval self as integer,byval no as integer) as integer
declare function wxFont_GetNoAntiAliasing cdecl alias "wxFont_GetNoAntiAliasing" (byval self as integer) as integer
declare function wxFont_GetDefaultEncoding cdecl alias "wxFont_GetDefaultEncoding" () as integer
declare function wxFont_SetDefaultEncoding cdecl alias "wxFont_SetDefaultEncoding" (byval encoding as integer) as integer
declare function wxFont_New cdecl alias "wxFont_New" (byval strNativeFontDesc as string) as integer
declare function wxFontDialog_ctor cdecl alias "wxFontDialog_ctor" () as integer
declare function wxFontDialog_Create cdecl alias "wxFontDialog_Create" (byval self as integer,byval parent as integer,byval data as integer) as integer
declare function wxFontDialog_dtor cdecl alias "wxFontDialog_dtor" (byval self as integer) as integer
declare function wxFontDialog_ShowModal cdecl alias "wxFontDialog_ShowModal" (byval self as integer) as integer
declare function wxFontDialog_GetFontData cdecl alias "wxFontDialog_GetFontData" (byval self as integer) as integer
declare function wxFontData_ctor cdecl alias "wxFontData_ctor" () as integer
declare function wxFontData_dtor cdecl alias "wxFontData_dtor" (byval self as integer) as integer
declare function wxFontData_SetAllowSymbols cdecl alias "wxFontData_SetAllowSymbols" (byval self as integer,byval flag as integer) as integer
declare function wxFontData_GetAllowSymbols cdecl alias "wxFontData_GetAllowSymbols" (byval self as integer) as integer
declare function wxFontData_SetColour cdecl alias "wxFontData_SetColour" (byval self as integer,byval colour as integer) as integer
declare function wxFontData_GetColour cdecl alias "wxFontData_GetColour" (byval self as integer) as integer
declare function wxFontData_SetShowHelp cdecl alias "wxFontData_SetShowHelp" (byval self as integer,byval flag as integer) as integer
declare function wxFontData_GetShowHelp cdecl alias "wxFontData_GetShowHelp" (byval self as integer) as integer
declare function wxFontData_EnableEffects cdecl alias "wxFontData_EnableEffects" (byval self as integer,byval flag as integer) as integer
declare function wxFontData_GetEnableEffects cdecl alias "wxFontData_GetEnableEffects" (byval self as integer) as integer
declare function wxFontData_SetInitialFont cdecl alias "wxFontData_SetInitialFont" (byval self as integer,byval font as integer) as integer
declare function wxFontData_GetInitialFont cdecl alias "wxFontData_GetInitialFont" (byval self as integer) as integer
declare function wxFontData_SetChosenFont cdecl alias "wxFontData_SetChosenFont" (byval self as integer,byval font as integer) as integer
declare function wxFontData_GetChosenFont cdecl alias "wxFontData_GetChosenFont" (byval self as integer) as integer
declare function wxFontData_SetRange cdecl alias "wxFontData_SetRange" (byval self as integer,byval minRange as integer,byval maxRange as integer) as integer
declare function wxFontMapper_ctor cdecl alias "wxFontMapper_ctor" () as integer
declare function wxFontMapper_dtor cdecl alias "wxFontMapper_dtor" (byval self as integer) as integer
declare function wxFontMapper_Get cdecl alias "wxFontMapper_Get" () as integer
declare function wxFontMapper_Set cdecl alias "wxFontMapper_Set" (byval mapper as integer) as integer
declare function wxFontMapper_GetSupportedEncodingsCount cdecl alias "wxFontMapper_GetSupportedEncodingsCount" () as integer
declare function wxFontMapper_GetEncoding cdecl alias "wxFontMapper_GetEncoding" (byval n as integer) as integer
declare function wxFontMapper_GetEncodingName cdecl alias "wxFontMapper_GetEncodingName" (byval encoding as integer) as byte ptr
declare function wxFontMapper_GetEncodingFromName cdecl alias "wxFontMapper_GetEncodingFromName" (byval name as string) as integer
declare function wxFontMapper_CharsetToEncoding cdecl alias "wxFontMapper_CharsetToEncoding" (byval self as integer,byval charset as string,byval interactive as integer) as integer
declare function wxFontMapper_IsEncodingAvailable cdecl alias "wxFontMapper_IsEncodingAvailable" (byval self as integer,byval encoding as integer,byval facename as string) as integer
declare function wxFontMapper_GetAltForEncoding cdecl alias "wxFontMapper_GetAltForEncoding" (byval self as integer,byval encoding as integer,byval alt_encoding as integer,byval facename as string,byval interactive as integer) as integer
declare function wxFontMapper_GetEncodingDescription cdecl alias "wxFontMapper_GetEncodingDescription" (byval encoding as integer) as byte ptr
declare function wxFontMapper_SetDialogParent cdecl alias "wxFontMapper_SetDialogParent" (byval self as integer,byval parent as integer) as integer
declare function wxFontMapper_SetDialogTitle cdecl alias "wxFontMapper_SetDialogTitle" (byval self as integer,byval title as string) as integer
declare function wxEncodingConverter_ctor cdecl alias "wxEncodingConverter_ctor" () as integer
declare function wxEncodingConverter_Init cdecl alias "wxEncodingConverter_Init" (byval self as integer,byval input_enc as integer,byval output_enc as integer,byval method as integer) as integer
declare function wxEncodingConverter_Convert cdecl alias "wxEncodingConverter_Convert" (byval self as integer,byval input as string) as byte ptr
declare function wxFontEnumerator_ctor cdecl alias "wxFontEnumerator_ctor" () as integer
declare function wxFontEnumerator_dtor cdecl alias "wxFontEnumerator_dtor" (byval self as integer) as integer
declare function wxFontEnumerator_RegisterVirtual cdecl alias "wxFontEnumerator_RegisterVirtual" (byval self as integer,byval enumerateFacenames as integer,byval enumerateEncodings as integer,byval onFacename as integer,byval onFontEncoding as integer) as integer
declare function wxFontEnumerator_GetFacenames cdecl alias "wxFontEnumerator_GetFacenames" (byval self as integer) as integer
declare function wxFontEnumerator_GetEncodings cdecl alias "wxFontEnumerator_GetEncodings" (byval self as integer) as integer
declare function wxFontEnumerator_OnFacename cdecl alias "wxFontEnumerator_OnFacename" (byval self as integer,byval facename as string) as integer
declare function wxFontEnumerator_OnFontEncoding cdecl alias "wxFontEnumerator_OnFontEncoding" (byval self as integer,byval facename as string,byval encoding as string) as integer
declare function wxFontEnumerator_EnumerateFacenames cdecl alias "wxFontEnumerator_EnumerateFacenames" (byval self as integer,byval encoding as integer,byval fixedWidthOnly as integer) as integer
declare function wxFontEnumerator_EnumerateEncodings cdecl alias "wxFontEnumerator_EnumerateEncodings" (byval self as integer,byval facename as string) as integer
declare function wxFrame_ctor cdecl alias "wxFrame_ctor" () as integer
declare function wxFrame_Create cdecl alias "wxFrame_Create" (byval self as integer,byval parent as integer,byval id as integer,byval title as string,byval pos as integer,byval size as integer,byval style as integer,byval name as string) as integer
declare function wxFrame_ShowFullScreen cdecl alias "wxFrame_ShowFullScreen" (byval self as integer,byval show as integer,byval style as integer) as integer
declare function wxFrame_IsFullScreen cdecl alias "wxFrame_IsFullScreen" (byval self as integer) as integer
declare function wxFrame_CreateStatusBar cdecl alias "wxFrame_CreateStatusBar" (byval self as integer,byval number as integer,byval style as integer,byval id as integer,byval name as string) as integer
declare function wxFrame_GetStatusBar cdecl alias "wxFrame_GetStatusBar" (byval self as integer) as integer
declare function wxFrame_SetStatusBar cdecl alias "wxFrame_SetStatusBar" (byval self as integer,byval statusbar as integer) as integer
declare function wxFrame_SetStatusBarPane cdecl alias "wxFrame_SetStatusBarPane" (byval self as integer,byval n as integer) as integer
declare function wxFrame_GetStatusBarPane cdecl alias "wxFrame_GetStatusBarPane" (byval self as integer) as integer
declare function wxFrame_SendSizeEvent cdecl alias "wxFrame_SendSizeEvent" (byval self as integer) as integer
declare function wxFrame_SetIcon cdecl alias "wxFrame_SetIcon" (byval self as integer,byval icon as integer) as integer
declare function wxFrame_SetMenuBar cdecl alias "wxFrame_SetMenuBar" (byval self as integer,byval menuBar as integer) as integer
declare function wxFrame_GetMenuBar cdecl alias "wxFrame_GetMenuBar" (byval self as integer) as integer
declare function wxFrame_SetStatusText cdecl alias "wxFrame_SetStatusText" (byval self as integer,byval text as string,byval number as integer) as integer
declare function wxFrame_CreateToolBar cdecl alias "wxFrame_CreateToolBar" (byval self as integer,byval style as integer,byval id as integer,byval name as string) as integer
declare function wxFrame_GetToolBar cdecl alias "wxFrame_GetToolBar" (byval self as integer) as integer
declare function wxFrame_SetToolBar cdecl alias "wxFrame_SetToolBar" (byval self as integer,byval toolbar as integer) as integer
declare function wxFrame_Maximize cdecl alias "wxFrame_Maximize" (byval self as integer,byval iconize as integer) as integer
declare function wxFrame_IsMaximized cdecl alias "wxFrame_IsMaximized" (byval self as integer) as integer
declare function wxFrame_Iconize cdecl alias "wxFrame_Iconize" (byval self as integer,byval iconize as integer) as integer
declare function wxFrame_IsIconized cdecl alias "wxFrame_IsIconized" (byval self as integer) as integer
declare function wxFrame_SetStatusWidths cdecl alias "wxFrame_SetStatusWidths" (byval self as integer,byval n as integer,byval widths as integer ptr) as integer
declare function wxFrame_GetClientAreaOrigin cdecl alias "wxFrame_GetClientAreaOrigin" (byval self as integer,byval pt as integer) as integer
declare function wxGauge_ctor cdecl alias "wxGauge_ctor" () as integer
declare function wxGauge_dtor cdecl alias "wxGauge_dtor" (byval self as integer) as integer
declare function wxGauge_Create cdecl alias "wxGauge_Create" (byval self as integer,byval parent as integer,byval id as integer,byval range as integer,byval pos as integer,byval size as integer,byval style as long,byval validator as integer,byval name as string) as integer
declare function wxGauge_SetRange cdecl alias "wxGauge_SetRange" (byval self as integer,byval range as integer) as integer
declare function wxGauge_GetRange cdecl alias "wxGauge_GetRange" (byval self as integer) as integer
declare function wxGauge_SetValue cdecl alias "wxGauge_SetValue" (byval self as integer,byval pos as integer) as integer
declare function wxGauge_GetValue cdecl alias "wxGauge_GetValue" (byval self as integer) as integer
declare function wxGauge_SetShadowWidth cdecl alias "wxGauge_SetShadowWidth" (byval self as integer,byval w as integer) as integer
declare function wxGauge_GetShadowWidth cdecl alias "wxGauge_GetShadowWidth" (byval self as integer) as integer
declare function wxGauge_SetBezelFace cdecl alias "wxGauge_SetBezelFace" (byval self as integer,byval w as integer) as integer
declare function wxGauge_GetBezelFace cdecl alias "wxGauge_GetBezelFace" (byval self as integer) as integer
declare function wxGauge_AcceptsFocus cdecl alias "wxGauge_AcceptsFocus" (byval self as integer) as integer
declare function wxGauge_IsVertical cdecl alias "wxGauge_IsVertical" (byval self as integer) as integer
declare function wxGDIObj_GetRedPen cdecl alias "wxGDIObj_GetRedPen" () as integer
declare function wxGDIObj_GetCyanPen cdecl alias "wxGDIObj_GetCyanPen" () as integer
declare function wxGDIObj_GetGreenPen cdecl alias "wxGDIObj_GetGreenPen" () as integer
declare function wxGDIObj_GetBlackPen cdecl alias "wxGDIObj_GetBlackPen" () as integer
declare function wxGDIObj_GetWhitePen cdecl alias "wxGDIObj_GetWhitePen" () as integer
declare function wxGDIObj_GetTransparentPen cdecl alias "wxGDIObj_GetTransparentPen" () as integer
declare function wxGDIObj_GetBlackDashedPen cdecl alias "wxGDIObj_GetBlackDashedPen" () as integer
declare function wxGDIObj_GetGreyPen cdecl alias "wxGDIObj_GetGreyPen" () as integer
declare function wxGDIObj_GetMediumGreyPen cdecl alias "wxGDIObj_GetMediumGreyPen" () as integer
declare function wxGDIObj_GetLightGreyPen cdecl alias "wxGDIObj_GetLightGreyPen" () as integer
declare function wxNullBitmap_Get cdecl alias "wxNullBitmap_Get" () as integer
declare function wxNullIcon_Get cdecl alias "wxNullIcon_Get" () as integer
declare function wxNullCursor_Get cdecl alias "wxNullCursor_Get" () as integer
declare function wxNullPen_Get cdecl alias "wxNullPen_Get" () as integer
declare function wxNullBrush_Get cdecl alias "wxNullBrush_Get" () as integer
declare function wxNullPalette_Get cdecl alias "wxNullPalette_Get" () as integer
declare function wxNullFont_Get cdecl alias "wxNullFont_Get" () as integer
declare function wxNullColour_Get cdecl alias "wxNullColour_Get" () as integer
declare function wxBLUE_BRUSH_Get cdecl alias "wxBLUE_BRUSH_Get" () as integer
declare function wxGREEN_BRUSH_Get cdecl alias "wxGREEN_BRUSH_Get" () as integer
declare function wxWHITE_BRUSH_Get cdecl alias "wxWHITE_BRUSH_Get" () as integer
declare function wxBLACK_BRUSH_Get cdecl alias "wxBLACK_BRUSH_Get" () as integer
declare function wxGREY_BRUSH_Get cdecl alias "wxGREY_BRUSH_Get" () as integer
declare function wxMEDIUM_GREY_BRUSH_Get cdecl alias "wxMEDIUM_GREY_BRUSH_Get" () as integer
declare function wxLIGHT_GREY_BRUSH_Get cdecl alias "wxLIGHT_GREY_BRUSH_Get" () as integer
declare function wxTRANSPARENT_BRUSH_Get cdecl alias "wxTRANSPARENT_BRUSH_Get" () as integer
declare function wxCYAN_BRUSH_Get cdecl alias "wxCYAN_BRUSH_Get" () as integer
declare function wxRED_BRUSH_Get cdecl alias "wxRED_BRUSH_Get" () as integer
declare function wxColourDatabase_ctor cdecl alias "wxColourDatabase_ctor" () as integer
declare function wxColourDataBase_dtor cdecl alias "wxColourDataBase_dtor" (byval self as integer) as integer
declare function wxColourDatabase_Find cdecl alias "wxColourDatabase_Find" (byval self as integer,byval name as string) as integer
declare function wxColourDatabase_FindName cdecl alias "wxColourDatabase_FindName" (byval self as integer,byval colour as integer) as byte ptr
declare function wxColourDatabase_AddColour cdecl alias "wxColourDatabase_AddColour" (byval self as integer,byval name as string,byval colour as integer) as integer
declare function wxPenList_ctor cdecl alias "wxPenList_ctor" () as integer
declare function wxPenList_AddPen cdecl alias "wxPenList_AddPen" (byval self as integer,byval pen as integer) as integer
declare function wxPenList_RemovePen cdecl alias "wxPenList_RemovePen" (byval self as integer,byval pen as integer) as integer
declare function wxPenList_FindOrCreatePen cdecl alias "wxPenList_FindOrCreatePen" (byval self as integer,byval colour as integer,byval width as integer,byval style as integer) as integer
declare function wxBrushList_ctor cdecl alias "wxBrushList_ctor" () as integer
declare function wxBrushList_AddPen cdecl alias "wxBrushList_AddPen" (byval self as integer,byval brush as integer) as integer
declare function wxBrushList_RemovePen cdecl alias "wxBrushList_RemovePen" (byval self as integer,byval brush as integer) as integer
declare function wxBrushList_FindOrCreateBrush cdecl alias "wxBrushList_FindOrCreateBrush" (byval self as integer,byval colour as integer,byval style as integer) as integer
declare function wxFontList_ctor cdecl alias "wxFontList_ctor" () as integer
declare function wxFontList_AddFont cdecl alias "wxFontList_AddFont" (byval self as integer,byval font as integer) as integer
declare function wxFontList_RemoveFont cdecl alias "wxFontList_RemoveFont" (byval self as integer,byval font as integer) as integer
declare function wxFontList_FindOrCreateFont cdecl alias "wxFontList_FindOrCreateFont" (byval self as integer,byval pointSize as integer,byval family as integer,byval style as integer,byval weight as integer,byval underline as integer,byval face as string,byval encoding as integer) as integer
declare function wxBitmapList_ctor cdecl alias "wxBitmapList_ctor" () as integer
declare function wxBitmapList_AddBitmap cdecl alias "wxBitmapList_AddBitmap" (byval self as integer,byval bitmap as integer) as integer
declare function wxBitmapList_RemoveBitmap cdecl alias "wxBitmapList_RemoveBitmap" (byval self as integer,byval bitmap as integer) as integer
declare function wxSTANDARD_CURSOR_Get cdecl alias "wxSTANDARD_CURSOR_Get" () as integer
declare function wxHOURGLASS_CURSOR_Get cdecl alias "wxHOURGLASS_CURSOR_Get" () as integer
declare function wxCROSS_CURSOR_Get cdecl alias "wxCROSS_CURSOR_Get" () as integer
declare function wxGDIObj_dtor cdecl alias "wxGDIObj_dtor" (byval self as integer) as integer
declare function wxGlobal_GetNumberFromUser cdecl alias "wxGlobal_GetNumberFromUser" (byval msg as string,byval prompt as string,byval caption as string,byval value as integer,byval min as integer,byval max as integer,byval parent as integer,byval pos as integer) as integer
declare function wxGlobal_GetHomeDir cdecl alias "wxGlobal_GetHomeDir" () as byte ptr
declare function wxGlobal_FileSelector cdecl alias "wxGlobal_FileSelector" (byval message as string,byval default_path as string,byval default_filename as string,byval default_extension as string,byval wildcard as string,byval flags as integer,byval parent as integer,byval x as integer,byval y as integer) as byte ptr
declare function wxArrayInt_ctor cdecl alias "wxArrayInt_ctor" () as integer
declare function wxArrayInt_dtor cdecl alias "wxArrayInt_dtor" (byval self as integer) as integer
declare function wxArrayInt_RegisterDisposable cdecl alias "wxArrayInt_RegisterDisposable" (byval self as integer,byval onDispose as integer) as integer
declare function wxArrayInt_Add cdecl alias "wxArrayInt_Add" (byval self as integer,byval toadd as integer) as integer
declare function wxArrayInt_Item cdecl alias "wxArrayInt_Item" (byval self as integer,byval num as integer) as integer
declare function wxArrayInt_GetCount cdecl alias "wxArrayInt_GetCount" (byval self as integer) as integer
declare function wxArrayString_ctor cdecl alias "wxArrayString_ctor" () as integer
declare function wxArrayString_dtor cdecl alias "wxArrayString_dtor" (byval self as integer) as integer
declare function wxArrayString_RegisterDisposable cdecl alias "wxArrayString_RegisterDisposable" (byval self as integer,byval onDispose as integer) as integer
declare function wxArrayString_Add cdecl alias "wxArrayString_Add" (byval self as integer,byval toadd as string) as integer
declare function wxArrayString_Item cdecl alias "wxArrayString_Item" (byval self as integer,byval num as integer) as byte ptr
declare function wxArrayString_GetCount cdecl alias "wxArrayString_GetCount" (byval self as integer) as integer
declare function wxSleep_func cdecl alias "wxSleep_func" (byval num as integer) as integer
declare function wxYield_func cdecl alias "wxYield_func" () as integer
declare function wxBeginBusyCursor_func cdecl alias "wxBeginBusyCursor_func" () as integer
declare function wxEndBusyCursor_func cdecl alias "wxEndBusyCursor_func" () as integer
declare function wxWindowDisabler_ctor cdecl alias "wxWindowDisabler_ctor" (byval winToSkip as integer) as integer
declare function wxWindowDisabler_dtor cdecl alias "wxWindowDisabler_dtor" (byval self as integer) as integer
declare function wxBusyInfo_ctor cdecl alias "wxBusyInfo_ctor" (byval message as string,byval parent as integer) as integer
declare function wxBusyInfo_dtor cdecl alias "wxBusyInfo_dtor" (byval self as integer) as integer
declare function wxMutexGuiEnter_func cdecl alias "wxMutexGuiEnter_func" () as integer
declare function wxMutexGuiLeave_func cdecl alias "wxMutexGuiLeave_func" () as integer
declare function wxSize_ctor cdecl alias "wxSize_ctor" (byval x as integer,byval y as integer) as integer
declare function wxSize_dtor cdecl alias "wxSize_dtor" (byval self as integer) as integer
declare function wxSize_SetWidth cdecl alias "wxSize_SetWidth" (byval self as integer,byval w as integer) as integer
declare function wxSize_SetHeight cdecl alias "wxSize_SetHeight" (byval self as integer,byval h as integer) as integer
declare function wxSize_GetWidth cdecl alias "wxSize_GetWidth" (byval self as integer) as integer
declare function wxSize_GetHeight cdecl alias "wxSize_GetHeight" (byval self as integer) as integer
declare function wxRect_ctor cdecl alias "wxRect_ctor" (byval x as integer,byval y as integer,byval w as integer,byval h as integer) as integer
declare function wxRect_dtor cdecl alias "wxRect_dtor" (byval self as integer) as integer
declare function wxRect_RegisterDisposable cdecl alias "wxRect_RegisterDisposable" (byval self as integer,byval onDispose as integer) as integer
declare function wxRect_GetX cdecl alias "wxRect_GetX" (byval self as integer) as integer
declare function wxRect_SetX cdecl alias "wxRect_SetX" (byval self as integer,byval x as integer) as integer
declare function wxRect_GetY cdecl alias "wxRect_GetY" (byval self as integer) as integer
declare function wxRect_SetY cdecl alias "wxRect_SetY" (byval self as integer,byval y as integer) as integer
declare function wxRect_GetWidth cdecl alias "wxRect_GetWidth" (byval self as integer) as integer
declare function wxRect_SetWidth cdecl alias "wxRect_SetWidth" (byval self as integer,byval w as integer) as integer
declare function wxRect_GetHeight cdecl alias "wxRect_GetHeight" (byval self as integer) as integer
declare function wxRect_SetHeight cdecl alias "wxRect_SetHeight" (byval self as integer,byval h as integer) as integer
declare function wxGridEvent_ctor cdecl alias "wxGridEvent_ctor" (byval id as integer,byval type as integer,byval obj as integer,byval row as integer,byval col as integer,byval x as integer,byval y as integer,byval sel as integer,byval control as integer,byval shift as integer,byval alt as integer,byval meta as integer) as integer
declare function wxGridEvent_GetRow cdecl alias "wxGridEvent_GetRow" (byval self as integer) as integer
declare function wxGridEvent_GetCol cdecl alias "wxGridEvent_GetCol" (byval self as integer) as integer
declare function wxGridEvent_GetPosition cdecl alias "wxGridEvent_GetPosition" (byval self as integer,byval pt as integer) as integer
declare function wxGridEvent_Selecting cdecl alias "wxGridEvent_Selecting" (byval self as integer) as integer
declare function wxGridEvent_ControlDown cdecl alias "wxGridEvent_ControlDown" (byval self as integer) as integer
declare function wxGridEvent_MetaDown cdecl alias "wxGridEvent_MetaDown" (byval self as integer) as integer
declare function wxGridEvent_ShiftDown cdecl alias "wxGridEvent_ShiftDown" (byval self as integer) as integer
declare function wxGridEvent_AltDown cdecl alias "wxGridEvent_AltDown" (byval self as integer) as integer
declare function wxGridEvent_Veto cdecl alias "wxGridEvent_Veto" (byval self as integer) as integer
declare function wxGridEvent_Allow cdecl alias "wxGridEvent_Allow" (byval self as integer) as integer
declare function wxGridEvent_IsAllowed cdecl alias "wxGridEvent_IsAllowed" (byval self as integer) as integer
declare function wxGridRangeSelectEvent_ctor cdecl alias "wxGridRangeSelectEvent_ctor" (byval id as integer,byval type as integer,byval obj as integer,byval topLeft as integer,byval bottomRight as integer,byval sel as integer,byval control as integer,byval shift as integer,byval alt as integer,byval meta as integer) as integer
declare function wxGridRangeSelectEvent_GetTopLeftCoords cdecl alias "wxGridRangeSelectEvent_GetTopLeftCoords" (byval self as integer) as integer
declare function wxGridRangeSelectEvent_GetBottomRightCoords cdecl alias "wxGridRangeSelectEvent_GetBottomRightCoords" (byval self as integer) as integer
declare function wxGridRangeSelectEvent_GetTopRow cdecl alias "wxGridRangeSelectEvent_GetTopRow" (byval self as integer) as integer
declare function wxGridRangeSelectEvent_GetBottomRow cdecl alias "wxGridRangeSelectEvent_GetBottomRow" (byval self as integer) as integer
declare function wxGridRangeSelectEvent_GetLeftCol cdecl alias "wxGridRangeSelectEvent_GetLeftCol" (byval self as integer) as integer
declare function wxGridRangeSelectEvent_GetRightCol cdecl alias "wxGridRangeSelectEvent_GetRightCol" (byval self as integer) as integer
declare function wxGridRangeSelectEvent_Selecting cdecl alias "wxGridRangeSelectEvent_Selecting" (byval self as integer) as integer
declare function wxGridRangeSelectEvent_ControlDown cdecl alias "wxGridRangeSelectEvent_ControlDown" (byval self as integer) as integer
declare function wxGridRangeSelectEvent_MetaDown cdecl alias "wxGridRangeSelectEvent_MetaDown" (byval self as integer) as integer
declare function wxGridRangeSelectEvent_ShiftDown cdecl alias "wxGridRangeSelectEvent_ShiftDown" (byval self as integer) as integer
declare function wxGridRangeSelectEvent_AltDown cdecl alias "wxGridRangeSelectEvent_AltDown" (byval self as integer) as integer
declare function wxGridRangeSelectEvent_Veto cdecl alias "wxGridRangeSelectEvent_Veto" (byval self as integer) as integer
declare function wxGridRangeSelectEvent_Allow cdecl alias "wxGridRangeSelectEvent_Allow" (byval self as integer) as integer
declare function wxGridRangeSelectEvent_IsAllowed cdecl alias "wxGridRangeSelectEvent_IsAllowed" (byval self as integer) as integer
declare function wxGridCellWorker_ctor cdecl alias "wxGridCellWorker_ctor" () as integer
declare function wxGridCellWorker_RegisterVirtual cdecl alias "wxGridCellWorker_RegisterVirtual" (byval self as integer,byval setParameters as integer) as integer
declare function wxGridCellWorker_IncRef cdecl alias "wxGridCellWorker_IncRef" (byval self as integer) as integer
declare function wxGridCellWorker_DecRef cdecl alias "wxGridCellWorker_DecRef" (byval self as integer) as integer
declare function wxGridCellWorker_SetParameters cdecl alias "wxGridCellWorker_SetParameters" (byval self as integer,byval params as string) as integer
declare function wxGridEditorCreatedEvent_ctor cdecl alias "wxGridEditorCreatedEvent_ctor" (byval id as integer,byval type as integer,byval obj as integer,byval row as integer,byval col as integer,byval ctrl as integer) as integer
declare function wxGridEditorCreatedEvent_GetRow cdecl alias "wxGridEditorCreatedEvent_GetRow" (byval self as integer) as integer
declare function wxGridEditorCreatedEvent_GetCol cdecl alias "wxGridEditorCreatedEvent_GetCol" (byval self as integer) as integer
declare function wxGridEditorCreatedEvent_GetControl cdecl alias "wxGridEditorCreatedEvent_GetControl" (byval self as integer) as integer
declare function wxGridEditorCreatedEvent_SetRow cdecl alias "wxGridEditorCreatedEvent_SetRow" (byval self as integer,byval row as integer) as integer
declare function wxGridEditorCreatedEvent_SetCol cdecl alias "wxGridEditorCreatedEvent_SetCol" (byval self as integer,byval col as integer) as integer
declare function wxGridEditorCreatedEvent_SetControl cdecl alias "wxGridEditorCreatedEvent_SetControl" (byval self as integer,byval ctrl as integer) as integer
declare function wxGrid_ctor cdecl alias "wxGrid_ctor" () as integer
declare function wxGrid_ctorFull cdecl alias "wxGrid_ctorFull" (byval parent as integer,byval id as integer,byval pos as integer,byval size as integer,byval style as integer,byval name as string) as integer
declare function wxGrid_dtor cdecl alias "wxGrid_dtor" (byval self as integer) as integer
declare function wxGrid_GetNumberRows cdecl alias "wxGrid_GetNumberRows" (byval self as integer) as integer
declare function wxGrid_GetNumberCols cdecl alias "wxGrid_GetNumberCols" (byval self as integer) as integer
declare function wxGrid_ProcessRowLabelMouseEvent cdecl alias "wxGrid_ProcessRowLabelMouseEvent" (byval self as integer,byval event as integer) as integer
declare function wxGrid_ProcessColLabelMouseEvent cdecl alias "wxGrid_ProcessColLabelMouseEvent" (byval self as integer,byval event as integer) as integer
declare function wxGrid_ProcessCornerLabelMouseEvent cdecl alias "wxGrid_ProcessCornerLabelMouseEvent" (byval self as integer,byval event as integer) as integer
declare function wxGrid_ProcessGridCellMouseEvent cdecl alias "wxGrid_ProcessGridCellMouseEvent" (byval self as integer,byval event as integer) as integer
declare function wxGrid_GetTable cdecl alias "wxGrid_GetTable" (byval self as integer) as integer
declare function wxGrid_ClearGrid cdecl alias "wxGrid_ClearGrid" (byval self as integer) as integer
declare function wxGrid_InsertRows cdecl alias "wxGrid_InsertRows" (byval self as integer,byval pos as integer,byval numRows as integer,byval updateLabels as integer) as integer
declare function wxGrid_AppendRows cdecl alias "wxGrid_AppendRows" (byval self as integer,byval numRows as integer,byval updateLabels as integer) as integer
declare function wxGrid_DeleteRows cdecl alias "wxGrid_DeleteRows" (byval self as integer,byval pos as integer,byval numRows as integer,byval updateLabels as integer) as integer
declare function wxGrid_InsertCols cdecl alias "wxGrid_InsertCols" (byval self as integer,byval pos as integer,byval numCols as integer,byval updateLabels as integer) as integer
declare function wxGrid_AppendCols cdecl alias "wxGrid_AppendCols" (byval self as integer,byval numCols as integer,byval updateLabels as integer) as integer
declare function wxGrid_DeleteCols cdecl alias "wxGrid_DeleteCols" (byval self as integer,byval pos as integer,byval numCols as integer,byval updateLabels as integer) as integer
declare function wxGrid_DrawGridCellArea cdecl alias "wxGrid_DrawGridCellArea" (byval self as integer,byval dc as integer,byval cells as integer) as integer
declare function wxGrid_DrawGridSpace cdecl alias "wxGrid_DrawGridSpace" (byval self as integer,byval dc as integer) as integer
declare function wxGrid_BeginBatch cdecl alias "wxGrid_BeginBatch" (byval self as integer) as integer
declare function wxGrid_EndBatch cdecl alias "wxGrid_EndBatch" (byval self as integer) as integer
declare function wxGrid_GetBatchCount cdecl alias "wxGrid_GetBatchCount" (byval self as integer) as integer
declare function wxGrid_ForceRefresh cdecl alias "wxGrid_ForceRefresh" (byval self as integer) as integer
declare function wxGrid_IsEditable cdecl alias "wxGrid_IsEditable" (byval self as integer) as integer
declare function wxGrid_EnableEditing cdecl alias "wxGrid_EnableEditing" (byval self as integer,byval edit as integer) as integer
declare function wxGrid_EnableCellEditControl cdecl alias "wxGrid_EnableCellEditControl" (byval self as integer,byval enable as integer) as integer
declare function wxGrid_DisableCellEditControl cdecl alias "wxGrid_DisableCellEditControl" (byval self as integer) as integer
declare function wxGrid_CanEnableCellControl cdecl alias "wxGrid_CanEnableCellControl" (byval self as integer) as integer
declare function wxGrid_IsCellEditControlEnabled cdecl alias "wxGrid_IsCellEditControlEnabled" (byval self as integer) as integer
declare function wxGrid_IsCellEditControlShown cdecl alias "wxGrid_IsCellEditControlShown" (byval self as integer) as integer
declare function wxGrid_IsCurrentCellReadOnly cdecl alias "wxGrid_IsCurrentCellReadOnly" (byval self as integer) as integer
declare function wxGrid_ShowCellEditControl cdecl alias "wxGrid_ShowCellEditControl" (byval self as integer) as integer
declare function wxGrid_HideCellEditControl cdecl alias "wxGrid_HideCellEditControl" (byval self as integer) as integer
declare function wxGrid_SaveEditControlValue cdecl alias "wxGrid_SaveEditControlValue" (byval self as integer) as integer
declare function wxGrid_YToRow cdecl alias "wxGrid_YToRow" (byval self as integer,byval y as integer) as integer
declare function wxGrid_XToCol cdecl alias "wxGrid_XToCol" (byval self as integer,byval x as integer) as integer
declare function wxGrid_YToEdgeOfRow cdecl alias "wxGrid_YToEdgeOfRow" (byval self as integer,byval y as integer) as integer
declare function wxGrid_XToEdgeOfCol cdecl alias "wxGrid_XToEdgeOfCol" (byval self as integer,byval x as integer) as integer
declare function wxGrid_CellToRect cdecl alias "wxGrid_CellToRect" (byval self as integer,byval row as integer,byval col as integer,byval rc as integer) as integer
declare function wxGrid_GetGridCursorRow cdecl alias "wxGrid_GetGridCursorRow" (byval self as integer) as integer
declare function wxGrid_GetGridCursorCol cdecl alias "wxGrid_GetGridCursorCol" (byval self as integer) as integer
declare function wxGrid_IsVisible cdecl alias "wxGrid_IsVisible" (byval self as integer,byval row as integer,byval col as integer,byval wholeCellVisible as integer) as integer
declare function wxGrid_MakeCellVisible cdecl alias "wxGrid_MakeCellVisible" (byval self as integer,byval row as integer,byval col as integer) as integer
declare function wxGrid_SetGridCursor cdecl alias "wxGrid_SetGridCursor" (byval self as integer,byval row as integer,byval col as integer) as integer
declare function wxGrid_MoveCursorUp cdecl alias "wxGrid_MoveCursorUp" (byval self as integer,byval expandSelection as integer) as integer
declare function wxGrid_MoveCursorDown cdecl alias "wxGrid_MoveCursorDown" (byval self as integer,byval expandSelection as integer) as integer
declare function wxGrid_MoveCursorLeft cdecl alias "wxGrid_MoveCursorLeft" (byval self as integer,byval expandSelection as integer) as integer
declare function wxGrid_MoveCursorRight cdecl alias "wxGrid_MoveCursorRight" (byval self as integer,byval expandSelection as integer) as integer
declare function wxGrid_MovePageDown cdecl alias "wxGrid_MovePageDown" (byval self as integer) as integer
declare function wxGrid_MovePageUp cdecl alias "wxGrid_MovePageUp" (byval self as integer) as integer
declare function wxGrid_MoveCursorUpBlock cdecl alias "wxGrid_MoveCursorUpBlock" (byval self as integer,byval expandSelection as integer) as integer
declare function wxGrid_MoveCursorDownBlock cdecl alias "wxGrid_MoveCursorDownBlock" (byval self as integer,byval expandSelection as integer) as integer
declare function wxGrid_MoveCursorLeftBlock cdecl alias "wxGrid_MoveCursorLeftBlock" (byval self as integer,byval expandSelection as integer) as integer
declare function wxGrid_MoveCursorRightBlock cdecl alias "wxGrid_MoveCursorRightBlock" (byval self as integer,byval expandSelection as integer) as integer
declare function wxGrid_GetDefaultRowLabelSize cdecl alias "wxGrid_GetDefaultRowLabelSize" (byval self as integer) as integer
declare function wxGrid_GetRowLabelSize cdecl alias "wxGrid_GetRowLabelSize" (byval self as integer) as integer
declare function wxGrid_GetDefaultColLabelSize cdecl alias "wxGrid_GetDefaultColLabelSize" (byval self as integer) as integer
declare function wxGrid_GetColLabelSize cdecl alias "wxGrid_GetColLabelSize" (byval self as integer) as integer
declare function wxGrid_GetLabelBackgroundColour cdecl alias "wxGrid_GetLabelBackgroundColour" (byval self as integer) as integer
declare function wxGrid_GetLabelTextColour cdecl alias "wxGrid_GetLabelTextColour" (byval self as integer) as integer
declare function wxGrid_GetLabelFont cdecl alias "wxGrid_GetLabelFont" (byval self as integer) as integer
declare function wxGrid_GetRowLabelAlignment cdecl alias "wxGrid_GetRowLabelAlignment" (byval self as integer,byval horiz as integer,byval vert as integer) as integer
declare function wxGrid_GetColLabelAlignment cdecl alias "wxGrid_GetColLabelAlignment" (byval self as integer,byval horiz as integer,byval vert as integer) as integer
declare function wxGrid_GetRowLabelValue cdecl alias "wxGrid_GetRowLabelValue" (byval self as integer,byval row as integer) as byte ptr
declare function wxGrid_GetColLabelValue cdecl alias "wxGrid_GetColLabelValue" (byval self as integer,byval col as integer) as byte ptr
declare function wxGrid_GetGridLineColour cdecl alias "wxGrid_GetGridLineColour" (byval self as integer) as integer
declare function wxGrid_GetCellHighlightColour cdecl alias "wxGrid_GetCellHighlightColour" (byval self as integer) as integer
declare function wxGrid_GetCellHighlightPenWidth cdecl alias "wxGrid_GetCellHighlightPenWidth" (byval self as integer) as integer
declare function wxGrid_GetCellHighlightROPenWidth cdecl alias "wxGrid_GetCellHighlightROPenWidth" (byval self as integer) as integer
declare function wxGrid_SetRowLabelSize cdecl alias "wxGrid_SetRowLabelSize" (byval self as integer,byval width as integer) as integer
declare function wxGrid_SetColLabelSize cdecl alias "wxGrid_SetColLabelSize" (byval self as integer,byval height as integer) as integer
declare function wxGrid_SetLabelBackgroundColour cdecl alias "wxGrid_SetLabelBackgroundColour" (byval self as integer,byval col as integer) as integer
declare function wxGrid_SetLabelTextColour cdecl alias "wxGrid_SetLabelTextColour" (byval self as integer,byval col as integer) as integer
declare function wxGrid_SetLabelFont cdecl alias "wxGrid_SetLabelFont" (byval self as integer,byval font as integer) as integer
declare function wxGrid_SetRowLabelAlignment cdecl alias "wxGrid_SetRowLabelAlignment" (byval self as integer,byval horiz as integer,byval vert as integer) as integer
declare function wxGrid_SetColLabelAlignment cdecl alias "wxGrid_SetColLabelAlignment" (byval self as integer,byval horiz as integer,byval vert as integer) as integer
declare function wxGrid_SetRowLabelValue cdecl alias "wxGrid_SetRowLabelValue" (byval self as integer,byval row as integer,byval val as string) as integer
declare function wxGrid_SetColLabelValue cdecl alias "wxGrid_SetColLabelValue" (byval self as integer,byval col as integer,byval val as string) as integer
declare function wxGrid_SetGridLineColour cdecl alias "wxGrid_SetGridLineColour" (byval self as integer,byval col as integer) as integer
declare function wxGrid_SetCellHighlightColour cdecl alias "wxGrid_SetCellHighlightColour" (byval self as integer,byval col as integer) as integer
declare function wxGrid_SetCellHighlightPenWidth cdecl alias "wxGrid_SetCellHighlightPenWidth" (byval self as integer,byval width as integer) as integer
declare function wxGrid_SetCellHighlightROPenWidth cdecl alias "wxGrid_SetCellHighlightROPenWidth" (byval self as integer,byval width as integer) as integer
declare function wxGrid_EnableDragRowSize cdecl alias "wxGrid_EnableDragRowSize" (byval self as integer,byval enable as integer) as integer
declare function wxGrid_DisableDragRowSize cdecl alias "wxGrid_DisableDragRowSize" (byval self as integer) as integer
declare function wxGrid_CanDragRowSize cdecl alias "wxGrid_CanDragRowSize" (byval self as integer) as integer
declare function wxGrid_EnableDragColSize cdecl alias "wxGrid_EnableDragColSize" (byval self as integer,byval enable as integer) as integer
declare function wxGrid_DisableDragColSize cdecl alias "wxGrid_DisableDragColSize" (byval self as integer) as integer
declare function wxGrid_CanDragColSize cdecl alias "wxGrid_CanDragColSize" (byval self as integer) as integer
declare function wxGrid_EnableDragGridSize cdecl alias "wxGrid_EnableDragGridSize" (byval self as integer,byval enable as integer) as integer
declare function wxGrid_DisableDragGridSize cdecl alias "wxGrid_DisableDragGridSize" (byval self as integer) as integer
declare function wxGrid_CanDragGridSize cdecl alias "wxGrid_CanDragGridSize" (byval self as integer) as integer
declare function wxGrid_SetAttr cdecl alias "wxGrid_SetAttr" (byval self as integer,byval row as integer,byval col as integer,byval attr as integer) as integer
declare function wxGrid_SetRowAttr cdecl alias "wxGrid_SetRowAttr" (byval self as integer,byval row as integer,byval attr as integer) as integer
declare function wxGrid_SetColAttr cdecl alias "wxGrid_SetColAttr" (byval self as integer,byval col as integer,byval attr as integer) as integer
declare function wxGrid_SetColFormatBool cdecl alias "wxGrid_SetColFormatBool" (byval self as integer,byval col as integer) as integer
declare function wxGrid_SetColFormatNumber cdecl alias "wxGrid_SetColFormatNumber" (byval self as integer,byval col as integer) as integer
declare function wxGrid_SetColFormatFloat cdecl alias "wxGrid_SetColFormatFloat" (byval self as integer,byval col as integer,byval width as integer,byval precision as integer) as integer
declare function wxGrid_SetColFormatCustom cdecl alias "wxGrid_SetColFormatCustom" (byval self as integer,byval col as integer,byval typeName as string) as integer
declare function wxGrid_EnableGridLines cdecl alias "wxGrid_EnableGridLines" (byval self as integer,byval enable as integer) as integer
declare function wxGrid_GridLinesEnabled cdecl alias "wxGrid_GridLinesEnabled" (byval self as integer) as integer
declare function wxGrid_GetDefaultRowSize cdecl alias "wxGrid_GetDefaultRowSize" (byval self as integer) as integer
declare function wxGrid_GetRowSize cdecl alias "wxGrid_GetRowSize" (byval self as integer,byval row as integer) as integer
declare function wxGrid_GetDefaultColSize cdecl alias "wxGrid_GetDefaultColSize" (byval self as integer) as integer
declare function wxGrid_GetColSize cdecl alias "wxGrid_GetColSize" (byval self as integer,byval col as integer) as integer
declare function wxGrid_GetDefaultCellBackgroundColour cdecl alias "wxGrid_GetDefaultCellBackgroundColour" (byval self as integer) as integer
declare function wxGrid_GetCellBackgroundColour cdecl alias "wxGrid_GetCellBackgroundColour" (byval self as integer,byval row as integer,byval col as integer) as integer
declare function wxGrid_GetDefaultCellTextColour cdecl alias "wxGrid_GetDefaultCellTextColour" (byval self as integer) as integer
declare function wxGrid_GetCellTextColour cdecl alias "wxGrid_GetCellTextColour" (byval self as integer,byval row as integer,byval col as integer) as integer
declare function wxGrid_GetDefaultCellFont cdecl alias "wxGrid_GetDefaultCellFont" (byval self as integer) as integer
declare function wxGrid_GetCellFont cdecl alias "wxGrid_GetCellFont" (byval self as integer,byval row as integer,byval col as integer) as integer
declare function wxGrid_GetDefaultCellAlignment cdecl alias "wxGrid_GetDefaultCellAlignment" (byval self as integer,byval horiz as integer,byval vert as integer) as integer
declare function wxGrid_GetCellAlignment cdecl alias "wxGrid_GetCellAlignment" (byval self as integer,byval row as integer,byval col as integer,byval horiz as integer,byval vert as integer) as integer
declare function wxGrid_GetDefaultCellOverflow cdecl alias "wxGrid_GetDefaultCellOverflow" (byval self as integer) as integer
declare function wxGrid_GetCellOverflow cdecl alias "wxGrid_GetCellOverflow" (byval self as integer,byval row as integer,byval col as integer) as integer
declare function wxGrid_GetCellSize cdecl alias "wxGrid_GetCellSize" (byval self as integer,byval row as integer,byval col as integer,byval num_rows as integer,byval num_cols as integer) as integer
declare function wxGrid_SetDefaultRowSize cdecl alias "wxGrid_SetDefaultRowSize" (byval self as integer,byval height as integer,byval resizeExistingRows as integer) as integer
declare function wxGrid_SetRowSize cdecl alias "wxGrid_SetRowSize" (byval self as integer,byval row as integer,byval height as integer) as integer
declare function wxGrid_SetDefaultColSize cdecl alias "wxGrid_SetDefaultColSize" (byval self as integer,byval width as integer,byval resizeExistingCols as integer) as integer
declare function wxGrid_SetColSize cdecl alias "wxGrid_SetColSize" (byval self as integer,byval col as integer,byval width as integer) as integer
declare function wxGrid_AutoSizeColumn cdecl alias "wxGrid_AutoSizeColumn" (byval self as integer,byval col as integer,byval setAsMin as integer) as integer
declare function wxGrid_AutoSizeRow cdecl alias "wxGrid_AutoSizeRow" (byval self as integer,byval row as integer,byval setAsMin as integer) as integer
declare function wxGrid_AutoSizeColumns cdecl alias "wxGrid_AutoSizeColumns" (byval self as integer,byval setAsMin as integer) as integer
declare function wxGrid_AutoSizeRows cdecl alias "wxGrid_AutoSizeRows" (byval self as integer,byval setAsMin as integer) as integer
declare function wxGrid_AutoSize cdecl alias "wxGrid_AutoSize" (byval self as integer) as integer
declare function wxGrid_SetColMinimalWidth cdecl alias "wxGrid_SetColMinimalWidth" (byval self as integer,byval col as integer,byval width as integer) as integer
declare function wxGrid_SetRowMinimalHeight cdecl alias "wxGrid_SetRowMinimalHeight" (byval self as integer,byval row as integer,byval width as integer) as integer
declare function wxGrid_SetColMinimalAcceptableWidth cdecl alias "wxGrid_SetColMinimalAcceptableWidth" (byval self as integer,byval width as integer) as integer
declare function wxGrid_SetRowMinimalAcceptableHeight cdecl alias "wxGrid_SetRowMinimalAcceptableHeight" (byval self as integer,byval width as integer) as integer
declare function wxGrid_GetColMinimalAcceptableWidth cdecl alias "wxGrid_GetColMinimalAcceptableWidth" (byval self as integer) as integer
declare function wxGrid_GetRowMinimalAcceptableHeight cdecl alias "wxGrid_GetRowMinimalAcceptableHeight" (byval self as integer) as integer
declare function wxGrid_SetDefaultCellBackgroundColour cdecl alias "wxGrid_SetDefaultCellBackgroundColour" (byval self as integer,byval col as integer) as integer
declare function wxGrid_SetDefaultCellTextColour cdecl alias "wxGrid_SetDefaultCellTextColour" (byval self as integer,byval col as integer) as integer
declare function wxGrid_SetDefaultCellFont cdecl alias "wxGrid_SetDefaultCellFont" (byval self as integer,byval font as integer) as integer
declare function wxGrid_SetCellFont cdecl alias "wxGrid_SetCellFont" (byval self as integer,byval row as integer,byval col as integer,byval font as integer) as integer
declare function wxGrid_SetDefaultCellAlignment cdecl alias "wxGrid_SetDefaultCellAlignment" (byval self as integer,byval horiz as integer,byval vert as integer) as integer
declare function wxGrid_SetCellAlignmentHV cdecl alias "wxGrid_SetCellAlignmentHV" (byval self as integer,byval row as integer,byval col as integer,byval horiz as integer,byval vert as integer) as integer
declare function wxGrid_SetDefaultCellOverflow cdecl alias "wxGrid_SetDefaultCellOverflow" (byval self as integer,byval allow as integer) as integer
declare function wxGrid_SetCellOverflow cdecl alias "wxGrid_SetCellOverflow" (byval self as integer,byval row as integer,byval col as integer,byval allow as integer) as integer
declare function wxGrid_SetCellSize cdecl alias "wxGrid_SetCellSize" (byval self as integer,byval row as integer,byval col as integer,byval num_rows as integer,byval num_cols as integer) as integer
declare function wxGrid_SetDefaultRenderer cdecl alias "wxGrid_SetDefaultRenderer" (byval self as integer,byval renderer as integer) as integer
declare function wxGrid_SetCellRenderer cdecl alias "wxGrid_SetCellRenderer" (byval self as integer,byval row as integer,byval col as integer,byval renderer as integer) as integer
declare function wxGrid_GetDefaultRenderer cdecl alias "wxGrid_GetDefaultRenderer" (byval self as integer) as integer
declare function wxGrid_GetCellRenderer cdecl alias "wxGrid_GetCellRenderer" (byval self as integer,byval row as integer,byval col as integer) as integer
declare function wxGrid_SetDefaultEditor cdecl alias "wxGrid_SetDefaultEditor" (byval self as integer,byval editor as integer) as integer
declare function wxGrid_SetCellEditor cdecl alias "wxGrid_SetCellEditor" (byval self as integer,byval row as integer,byval col as integer,byval editor as integer) as integer
declare function wxGrid_GetDefaultEditor cdecl alias "wxGrid_GetDefaultEditor" (byval self as integer) as integer
declare function wxGrid_GetCellEditor cdecl alias "wxGrid_GetCellEditor" (byval self as integer,byval row as integer,byval col as integer) as integer
declare function wxGrid_GetCellValue cdecl alias "wxGrid_GetCellValue" (byval self as integer,byval row as integer,byval col as integer) as byte ptr
declare function wxGrid_SetCellValue cdecl alias "wxGrid_SetCellValue" (byval self as integer,byval row as integer,byval col as integer,byval s as string) as integer
declare function wxGrid_IsReadOnly cdecl alias "wxGrid_IsReadOnly" (byval self as integer,byval row as integer,byval col as integer) as integer
declare function wxGrid_SetReadOnly cdecl alias "wxGrid_SetReadOnly" (byval self as integer,byval row as integer,byval col as integer,byval isReadOnly as integer) as integer
declare function wxGrid_SelectRow cdecl alias "wxGrid_SelectRow" (byval self as integer,byval row as integer,byval addToSelected as integer) as integer
declare function wxGrid_SelectCol cdecl alias "wxGrid_SelectCol" (byval self as integer,byval col as integer,byval addToSelected as integer) as integer
declare function wxGrid_SelectBlock cdecl alias "wxGrid_SelectBlock" (byval self as integer,byval topRow as integer,byval leftCol as integer,byval bottomRow as integer,byval rightCol as integer,byval addToSelected as integer) as integer
declare function wxGrid_SelectAll cdecl alias "wxGrid_SelectAll" (byval self as integer) as integer
declare function wxGrid_IsSelection cdecl alias "wxGrid_IsSelection" (byval self as integer) as integer
declare function wxGrid_DeselectRow cdecl alias "wxGrid_DeselectRow" (byval self as integer,byval row as integer) as integer
declare function wxGrid_DeselectCol cdecl alias "wxGrid_DeselectCol" (byval self as integer,byval col as integer) as integer
declare function wxGrid_DeselectCell cdecl alias "wxGrid_DeselectCell" (byval self as integer,byval row as integer,byval col as integer) as integer
declare function wxGrid_ClearSelection cdecl alias "wxGrid_ClearSelection" (byval self as integer) as integer
declare function wxGrid_IsInSelection cdecl alias "wxGrid_IsInSelection" (byval self as integer,byval row as integer,byval col as integer) as integer
declare function wxGrid_BlockToDeviceRect cdecl alias "wxGrid_BlockToDeviceRect" (byval self as integer,byval topLeft as integer,byval bottomRight as integer,byval rc as integer) as integer
declare function wxGrid_GetSelectionBackground cdecl alias "wxGrid_GetSelectionBackground" (byval self as integer) as integer
declare function wxGrid_GetSelectionForeground cdecl alias "wxGrid_GetSelectionForeground" (byval self as integer) as integer
declare function wxGrid_SetSelectionBackground cdecl alias "wxGrid_SetSelectionBackground" (byval self as integer,byval c as integer) as integer
declare function wxGrid_SetSelectionForeground cdecl alias "wxGrid_SetSelectionForeground" (byval self as integer,byval c as integer) as integer
declare function wxGrid_RegisterDataType cdecl alias "wxGrid_RegisterDataType" (byval self as integer,byval typeName as string,byval renderer as integer,byval editor as integer) as integer
declare function wxGrid_GetDefaultEditorForCell cdecl alias "wxGrid_GetDefaultEditorForCell" (byval self as integer,byval row as integer,byval col as integer) as integer
declare function wxGrid_GetDefaultRendererForCell cdecl alias "wxGrid_GetDefaultRendererForCell" (byval self as integer,byval row as integer,byval col as integer) as integer
declare function wxGrid_GetDefaultEditorForType cdecl alias "wxGrid_GetDefaultEditorForType" (byval self as integer,byval typeName as string) as integer
declare function wxGrid_GetDefaultRendererForType cdecl alias "wxGrid_GetDefaultRendererForType" (byval self as integer,byval typeName as string) as integer
declare function wxGrid_SetMargins cdecl alias "wxGrid_SetMargins" (byval self as integer,byval extraWidth as integer,byval extraHeight as integer) as integer
declare function wxGrid_GetGridWindow cdecl alias "wxGrid_GetGridWindow" (byval self as integer) as integer
declare function wxGrid_GetGridRowLabelWindow cdecl alias "wxGrid_GetGridRowLabelWindow" (byval self as integer) as integer
declare function wxGrid_GetGridColLabelWindow cdecl alias "wxGrid_GetGridColLabelWindow" (byval self as integer) as integer
declare function wxGrid_GetGridCornerLabelWindow cdecl alias "wxGrid_GetGridCornerLabelWindow" (byval self as integer) as integer
declare function wxGrid_UpdateDimensions cdecl alias "wxGrid_UpdateDimensions" (byval self as integer) as integer
declare function wxGrid_GetRows cdecl alias "wxGrid_GetRows" (byval self as integer) as integer
declare function wxGrid_GetCols cdecl alias "wxGrid_GetCols" (byval self as integer) as integer
declare function wxGrid_GetCursorRow cdecl alias "wxGrid_GetCursorRow" (byval self as integer) as integer
declare function wxGrid_GetCursorColumn cdecl alias "wxGrid_GetCursorColumn" (byval self as integer) as integer
declare function wxGrid_GetScrollPosX cdecl alias "wxGrid_GetScrollPosX" (byval self as integer) as integer
declare function wxGrid_GetScrollPosY cdecl alias "wxGrid_GetScrollPosY" (byval self as integer) as integer
declare function wxGrid_SetScrollX cdecl alias "wxGrid_SetScrollX" (byval self as integer,byval x as integer) as integer
declare function wxGrid_SetScrollY cdecl alias "wxGrid_SetScrollY" (byval self as integer,byval y as integer) as integer
declare function wxGrid_SetColumnWidth cdecl alias "wxGrid_SetColumnWidth" (byval self as integer,byval col as integer,byval width as integer) as integer
declare function wxGrid_GetColumnWidth cdecl alias "wxGrid_GetColumnWidth" (byval self as integer,byval col as integer) as integer
declare function wxGrid_SetRowHeight cdecl alias "wxGrid_SetRowHeight" (byval self as integer,byval row as integer,byval height as integer) as integer
declare function wxGrid_GetViewHeight cdecl alias "wxGrid_GetViewHeight" (byval self as integer) as integer
declare function wxGrid_GetViewWidth cdecl alias "wxGrid_GetViewWidth" (byval self as integer) as integer
declare function wxGrid_SetLabelSize cdecl alias "wxGrid_SetLabelSize" (byval self as integer,byval orientation as integer,byval sz as integer) as integer
declare function wxGrid_GetLabelSize cdecl alias "wxGrid_GetLabelSize" (byval self as integer,byval orientation as integer) as integer
declare function wxGrid_SetLabelAlignment cdecl alias "wxGrid_SetLabelAlignment" (byval self as integer,byval orientation as integer,byval align as integer) as integer
declare function wxGrid_GetLabelAlignment cdecl alias "wxGrid_GetLabelAlignment" (byval self as integer,byval orientation as integer,byval align as integer) as integer
declare function wxGrid_SetLabelValue cdecl alias "wxGrid_SetLabelValue" (byval self as integer,byval orientation as integer,byval val as string,byval pos as integer) as integer
declare function wxGrid_GetLabelValue cdecl alias "wxGrid_GetLabelValue" (byval self as integer,byval orientation as integer,byval pos as integer) as byte ptr
declare function wxGrid_GetCellTextFontGrid cdecl alias "wxGrid_GetCellTextFontGrid" (byval self as integer) as integer
declare function wxGrid_GetCellTextFont cdecl alias "wxGrid_GetCellTextFont" (byval self as integer,byval row as integer,byval col as integer) as integer
declare function wxGrid_SetCellTextFontGrid cdecl alias "wxGrid_SetCellTextFontGrid" (byval self as integer,byval fnt as integer) as integer
declare function wxGrid_SetCellTextFont cdecl alias "wxGrid_SetCellTextFont" (byval self as integer,byval fnt as integer,byval row as integer,byval col as integer) as integer
declare function wxGrid_SetCellTextColour cdecl alias "wxGrid_SetCellTextColour" (byval self as integer,byval row as integer,byval col as integer,byval val as integer) as integer
declare function wxGrid_SetCellTextColourGrid cdecl alias "wxGrid_SetCellTextColourGrid" (byval self as integer,byval col as integer) as integer
declare function wxGrid_SetCellBackgroundColourGrid cdecl alias "wxGrid_SetCellBackgroundColourGrid" (byval self as integer,byval col as integer) as integer
declare function wxGrid_SetCellBackgroundColour cdecl alias "wxGrid_SetCellBackgroundColour" (byval self as integer,byval row as integer,byval col as integer,byval colour as integer) as integer
declare function wxGrid_GetEditable cdecl alias "wxGrid_GetEditable" (byval self as integer) as integer
declare function wxGrid_SetEditable cdecl alias "wxGrid_SetEditable" (byval self as integer,byval edit as integer) as integer
declare function wxGrid_GetEditInPlace cdecl alias "wxGrid_GetEditInPlace" (byval self as integer) as integer
declare function wxGrid_SetCellAlignment cdecl alias "wxGrid_SetCellAlignment" (byval self as integer,byval align as integer,byval row as integer,byval col as integer) as integer
declare function wxGrid_SetCellAlignmentGrid cdecl alias "wxGrid_SetCellAlignmentGrid" (byval self as integer,byval align as integer) as integer
declare function wxGrid_SetCellBitmap cdecl alias "wxGrid_SetCellBitmap" (byval self as integer,byval bitmap as integer,byval row as integer,byval col as integer) as integer
declare function wxGrid_SetDividerPen cdecl alias "wxGrid_SetDividerPen" (byval self as integer,byval pen as integer) as integer
declare function wxGrid_GetDividerPen cdecl alias "wxGrid_GetDividerPen" (byval self as integer) as integer
declare function wxGrid_OnActivate cdecl alias "wxGrid_OnActivate" (byval self as integer,byval active as integer) as integer
declare function wxGrid_GetRowHeight cdecl alias "wxGrid_GetRowHeight" (byval self as integer,byval row as integer) as integer
declare function wxGridCellCoords_ctor cdecl alias "wxGridCellCoords_ctor" () as integer
declare function wxGridCellCoords_dtor cdecl alias "wxGridCellCoords_dtor" (byval self as integer) as integer
declare function wxGridCellCoords_GetRow cdecl alias "wxGridCellCoords_GetRow" (byval self as integer) as integer
declare function wxGridCellCoords_SetRow cdecl alias "wxGridCellCoords_SetRow" (byval self as integer,byval n as integer) as integer
declare function wxGridCellCoords_GetCol cdecl alias "wxGridCellCoords_GetCol" (byval self as integer) as integer
declare function wxGridCellCoords_SetCol cdecl alias "wxGridCellCoords_SetCol" (byval self as integer,byval n as integer) as integer
declare function wxGridCellCoords_Set cdecl alias "wxGridCellCoords_Set" (byval self as integer,byval row as integer,byval col as integer) as integer
declare function wxGridCellAttr_ctor cdecl alias "wxGridCellAttr_ctor" (byval colText as integer,byval colBack as integer,byval font as integer,byval hAlign as integer,byval vAlign as integer) as integer
declare function wxGridCellAttr_ctor2 cdecl alias "wxGridCellAttr_ctor2" () as integer
declare function wxGridCellAttr_ctor3 cdecl alias "wxGridCellAttr_ctor3" (byval attrDefault as integer) as integer
declare function wxGridCellAttr_Clone cdecl alias "wxGridCellAttr_Clone" (byval self as integer) as integer
declare function wxGridCellAttr_MergeWith cdecl alias "wxGridCellAttr_MergeWith" (byval self as integer,byval mergefrom as integer) as integer
declare function wxGridCellAttr_IncRef cdecl alias "wxGridCellAttr_IncRef" (byval self as integer) as integer
declare function wxGridCellAttr_DecRef cdecl alias "wxGridCellAttr_DecRef" (byval self as integer) as integer
declare function wxGridCellAttr_SetTextColour cdecl alias "wxGridCellAttr_SetTextColour" (byval self as integer,byval colText as integer) as integer
declare function wxGridCellAttr_SetBackgroundColour cdecl alias "wxGridCellAttr_SetBackgroundColour" (byval self as integer,byval colBack as integer) as integer
declare function wxGridCellAttr_SetFont cdecl alias "wxGridCellAttr_SetFont" (byval self as integer,byval font as integer) as integer
declare function wxGridCellAttr_SetAlignment cdecl alias "wxGridCellAttr_SetAlignment" (byval self as integer,byval hAlign as integer,byval vAlign as integer) as integer
declare function wxGridCellAttr_SetSize cdecl alias "wxGridCellAttr_SetSize" (byval self as integer,byval num_rows as integer,byval num_cols as integer) as integer
declare function wxGridCellAttr_SetOverflow cdecl alias "wxGridCellAttr_SetOverflow" (byval self as integer,byval allow as integer) as integer
declare function wxGridCellAttr_SetReadOnly cdecl alias "wxGridCellAttr_SetReadOnly" (byval self as integer,byval isReadOnly as integer) as integer
declare function wxGridCellAttr_SetRenderer cdecl alias "wxGridCellAttr_SetRenderer" (byval self as integer,byval renderer as integer) as integer
declare function wxGridCellAttr_SetEditor cdecl alias "wxGridCellAttr_SetEditor" (byval self as integer,byval editor as integer) as integer
declare function wxGridCellAttr_HasTextColour cdecl alias "wxGridCellAttr_HasTextColour" (byval self as integer) as integer
declare function wxGridCellAttr_HasBackgroundColour cdecl alias "wxGridCellAttr_HasBackgroundColour" (byval self as integer) as integer
declare function wxGridCellAttr_HasFont cdecl alias "wxGridCellAttr_HasFont" (byval self as integer) as integer
declare function wxGridCellAttr_HasAlignment cdecl alias "wxGridCellAttr_HasAlignment" (byval self as integer) as integer
declare function wxGridCellAttr_HasRenderer cdecl alias "wxGridCellAttr_HasRenderer" (byval self as integer) as integer
declare function wxGridCellAttr_HasEditor cdecl alias "wxGridCellAttr_HasEditor" (byval self as integer) as integer
declare function wxGridCellAttr_HasReadWriteMode cdecl alias "wxGridCellAttr_HasReadWriteMode" (byval self as integer) as integer
declare function wxGridCellAttr_GetTextColour cdecl alias "wxGridCellAttr_GetTextColour" (byval self as integer) as integer
declare function wxGridCellAttr_GetBackgroundColour cdecl alias "wxGridCellAttr_GetBackgroundColour" (byval self as integer) as integer
declare function wxGridCellAttr_GetFont cdecl alias "wxGridCellAttr_GetFont" (byval self as integer) as integer
declare function wxGridCellAttr_GetAlignment cdecl alias "wxGridCellAttr_GetAlignment" (byval self as integer,byval hAlign as integer,byval vAlign as integer) as integer
declare function wxGridCellAttr_GetSize cdecl alias "wxGridCellAttr_GetSize" (byval self as integer,byval num_rows as integer,byval num_cols as integer) as integer
declare function wxGridCellAttr_GetOverflow cdecl alias "wxGridCellAttr_GetOverflow" (byval self as integer) as integer
declare function wxGridCellAttr_GetRenderer cdecl alias "wxGridCellAttr_GetRenderer" (byval self as integer,byval grid as integer,byval row as integer,byval col as integer) as integer
declare function wxGridCellAttr_GetEditor cdecl alias "wxGridCellAttr_GetEditor" (byval self as integer,byval grid as integer,byval row as integer,byval col as integer) as integer
declare function wxGridCellAttr_IsReadOnly cdecl alias "wxGridCellAttr_IsReadOnly" (byval self as integer) as integer
declare function wxGridCellAttr_SetDefAttr cdecl alias "wxGridCellAttr_SetDefAttr" (byval self as integer,byval defAttr as integer) as integer
declare function wxGridSizeEvent_ctor cdecl alias "wxGridSizeEvent_ctor" () as integer
declare function wxGridSizeEvent_ctorParam cdecl alias "wxGridSizeEvent_ctorParam" (byval id as integer,byval type as integer,byval obj as integer,byval rowOrCol as integer,byval x as integer,byval y as integer,byval control as integer,byval shift as integer,byval alt as integer,byval meta as integer) as integer
declare function wxGridSizeEvent_GetRowOrCol cdecl alias "wxGridSizeEvent_GetRowOrCol" (byval self as integer) as integer
declare function wxGridSizeEvent_GetPosition cdecl alias "wxGridSizeEvent_GetPosition" (byval self as integer,byval pt as integer) as integer
declare function wxGridSizeEvent_ControlDown cdecl alias "wxGridSizeEvent_ControlDown" (byval self as integer) as integer
declare function wxGridSizeEvent_MetaDown cdecl alias "wxGridSizeEvent_MetaDown" (byval self as integer) as integer
declare function wxGridSizeEvent_ShiftDown cdecl alias "wxGridSizeEvent_ShiftDown" (byval self as integer) as integer
declare function wxGridSizeEvent_AltDown cdecl alias "wxGridSizeEvent_AltDown" (byval self as integer) as integer
declare function wxGridSizeEvent_Veto cdecl alias "wxGridSizeEvent_Veto" (byval self as integer) as integer
declare function wxGridSizeEvent_Allow cdecl alias "wxGridSizeEvent_Allow" (byval self as integer) as integer
declare function wxGridSizeEvent_IsAllowed cdecl alias "wxGridSizeEvent_IsAllowed" (byval self as integer) as integer
declare function wxGridCellEditor_RegisterVirtual cdecl alias "wxGridCellEditor_RegisterVirtual" (byval self as integer,byval create as integer,byval beginEdit as integer,byval endEdit as integer,byval reset as integer,byval clone as integer,byval setSize as integer,byval show as integer,byval paintBackground as integer,byval isAcceptedKey as integer,byval startingKey as integer,byval startingClick as integer,byval handleReturn as integer,byval destroy as integer,byval getvalue as integer) as integer
declare function wxGridCellEditor_ctor cdecl alias "wxGridCellEditor_ctor" () as integer
declare function wxGridCellEditor_dtor cdecl alias "wxGridCellEditor_dtor" (byval self as integer) as integer
declare function wxGridCellEditor_Create cdecl alias "wxGridCellEditor_Create" (byval self as integer,byval parent as integer,byval id as integer,byval evtHandler as integer) as integer
declare function wxGridCellEditor_IsCreated cdecl alias "wxGridCellEditor_IsCreated" (byval self as integer) as integer
declare function wxGridCellEditor_IsAcceptedKey cdecl alias "wxGridCellEditor_IsAcceptedKey" (byval self as integer,byval event as integer) as integer
declare function wxGridCellEditor_SetSize cdecl alias "wxGridCellEditor_SetSize" (byval self as integer,byval rect as integer) as integer
declare function wxGridCellEditor_Show cdecl alias "wxGridCellEditor_Show" (byval self as integer,byval show as integer,byval attr as integer) as integer
declare function wxGridCellEditor_PaintBackground cdecl alias "wxGridCellEditor_PaintBackground" (byval self as integer,byval rectCell as integer,byval attr as integer) as integer
declare function wxGridCellEditor_StartingKey cdecl alias "wxGridCellEditor_StartingKey" (byval self as integer,byval event as integer) as integer
declare function wxGridCellEditor_StartingClick cdecl alias "wxGridCellEditor_StartingClick" (byval self as integer) as integer
declare function wxGridCellEditor_HandleReturn cdecl alias "wxGridCellEditor_HandleReturn" (byval self as integer,byval event as integer) as integer
declare function wxGridCellEditor_Destroy cdecl alias "wxGridCellEditor_Destroy" (byval self as integer) as integer
declare function wxGridTableBase_ctor cdecl alias "wxGridTableBase_ctor" () as integer
declare function wxGridTableBase_RegisterVirtual cdecl alias "wxGridTableBase_RegisterVirtual" (byval self as integer,byval getNumberRows as integer,byval getNumberCols as integer,byval isEmptyCell as integer,byval getValue as integer,byval setValue as integer,byval getTypeName as integer,byval canGetValueAs as integer,byval canSetValueAs as integer,byval getValueAsLong as integer,byval getValueAsDouble as integer,byval getValueAsBool as integer,byval setValueAsLong as integer,byval setValueAsDouble as integer,byval setValueAsBool as integer,byval getValueAsCustom as integer,byval setValueAsCustom as integer,byval setView as integer,byval getView as integer,byval clear as integer,byval insertRows as integer,byval appendRows as integer,byval deleteRows as integer,byval insertCols as integer,byval appendCols as integer,byval deleteCols as integer,byval getRowLabelValue as integer,byval getColLabelValue as integer,byval setRowLabelValue as integer,byval setColLabelValue as integer,byval setAttrProvider as integer,byval getAttrProvider as integer,byval canHaveAttributes as integer,byval getAttr as integer,byval setAttr as integer,byval setRowAttr as integer,byval setColAttr as integer) as integer
declare function wxGridTableBase_GetTypeName cdecl alias "wxGridTableBase_GetTypeName" (byval self as integer,byval row as integer,byval col as integer) as byte ptr
declare function wxGridTableBase_CanGetValueAs cdecl alias "wxGridTableBase_CanGetValueAs" (byval self as integer,byval row as integer,byval col as integer,byval typeName as string) as integer
declare function wxGridTableBase_CanSetValueAs cdecl alias "wxGridTableBase_CanSetValueAs" (byval self as integer,byval row as integer,byval col as integer,byval typeName as string) as integer
declare function wxGridTableBase_GetValueAsLong cdecl alias "wxGridTableBase_GetValueAsLong" (byval self as integer,byval row as integer,byval col as integer) as long
declare function wxGridTableBase_GetValueAsDouble cdecl alias "wxGridTableBase_GetValueAsDouble" (byval self as integer,byval row as integer,byval col as integer) as integer
declare function wxGridTableBase_GetValueAsBool cdecl alias "wxGridTableBase_GetValueAsBool" (byval self as integer,byval row as integer,byval col as integer) as integer
declare function wxGridTableBase_SetValueAsLong cdecl alias "wxGridTableBase_SetValueAsLong" (byval self as integer,byval row as integer,byval col as integer,byval value as long) as integer
declare function wxGridTableBase_SetValueAsDouble cdecl alias "wxGridTableBase_SetValueAsDouble" (byval self as integer,byval row as integer,byval col as integer,byval value as integer) as integer
declare function wxGridTableBase_SetValueAsBool cdecl alias "wxGridTableBase_SetValueAsBool" (byval self as integer,byval row as integer,byval col as integer,byval value as integer) as integer
declare function wxGridTableBase_GetValueAsCustom cdecl alias "wxGridTableBase_GetValueAsCustom" (byval self as integer,byval row as integer,byval col as integer,byval typeName as string) as integer
declare function wxGridTableBase_SetValueAsCustom cdecl alias "wxGridTableBase_SetValueAsCustom" (byval self as integer,byval row as integer,byval col as integer,byval typeName as string,byval value as integer) as integer
declare function wxGridTableBase_SetView cdecl alias "wxGridTableBase_SetView" (byval self as integer,byval grid as integer) as integer
declare function wxGridTableBase_GetView cdecl alias "wxGridTableBase_GetView" (byval self as integer) as integer
declare function wxGridTableBase_Clear cdecl alias "wxGridTableBase_Clear" (byval self as integer) as integer
declare function wxGridTableBase_InsertRows cdecl alias "wxGridTableBase_InsertRows" (byval self as integer,byval pos as integer,byval numRows as integer) as integer
declare function wxGridTableBase_AppendRows cdecl alias "wxGridTableBase_AppendRows" (byval self as integer,byval numRows as integer) as integer
declare function wxGridTableBase_DeleteRows cdecl alias "wxGridTableBase_DeleteRows" (byval self as integer,byval pos as integer,byval numRows as integer) as integer
declare function wxGridTableBase_InsertCols cdecl alias "wxGridTableBase_InsertCols" (byval self as integer,byval pos as integer,byval numCols as integer) as integer
declare function wxGridTableBase_AppendCols cdecl alias "wxGridTableBase_AppendCols" (byval self as integer,byval numCols as integer) as integer
declare function wxGridTableBase_DeleteCols cdecl alias "wxGridTableBase_DeleteCols" (byval self as integer,byval pos as integer,byval numCols as integer) as integer
declare function wxGridTableBase_GetRowLabelValue cdecl alias "wxGridTableBase_GetRowLabelValue" (byval self as integer,byval row as integer) as byte ptr
declare function wxGridTableBase_GetColLabelValue cdecl alias "wxGridTableBase_GetColLabelValue" (byval self as integer,byval col as integer) as byte ptr
declare function wxGridTableBase_SetRowLabelValue cdecl alias "wxGridTableBase_SetRowLabelValue" (byval self as integer,byval row as integer,byval value as string) as integer
declare function wxGridTableBase_SetColLabelValue cdecl alias "wxGridTableBase_SetColLabelValue" (byval self as integer,byval col as integer,byval value as string) as integer
declare function wxGridTableBase_SetAttrProvider cdecl alias "wxGridTableBase_SetAttrProvider" (byval self as integer,byval attrProvider as integer) as integer
declare function wxGridTableBase_GetAttrProvider cdecl alias "wxGridTableBase_GetAttrProvider" (byval self as integer) as integer
declare function wxGridTableBase_CanHaveAttributes cdecl alias "wxGridTableBase_CanHaveAttributes" (byval self as integer) as integer
declare function wxGridTableBase_SetAttr cdecl alias "wxGridTableBase_SetAttr" (byval self as integer,byval attr as integer,byval row as integer,byval col as integer) as integer
declare function wxGridTableBase_SetRowAttr cdecl alias "wxGridTableBase_SetRowAttr" (byval self as integer,byval attr as integer,byval row as integer) as integer
declare function wxGridTableBase_SetColAttr cdecl alias "wxGridTableBase_SetColAttr" (byval self as integer,byval attr as integer,byval col as integer) as integer
declare function wxGridCellTextEditor_ctor cdecl alias "wxGridCellTextEditor_ctor" () as integer
declare function wxGridCellTextEditor_dtor cdecl alias "wxGridCellTextEditor_dtor" (byval self as integer) as integer
declare function wxGridCellTextEditor_Create cdecl alias "wxGridCellTextEditor_Create" (byval self as integer,byval parent as integer,byval id as integer,byval evtHandler as integer) as integer
declare function wxGridCellTextEditor_SetSize cdecl alias "wxGridCellTextEditor_SetSize" (byval self as integer,byval rect as integer) as integer
declare function wxGridCellTextEditor_PaintBackground cdecl alias "wxGridCellTextEditor_PaintBackground" (byval self as integer,byval rectCell as integer,byval attr as integer) as integer
declare function wxGridCellTextEditor_IsAcceptedKey cdecl alias "wxGridCellTextEditor_IsAcceptedKey" (byval self as integer,byval event as integer) as integer
declare function wxGridCellTextEditor_BeginEdit cdecl alias "wxGridCellTextEditor_BeginEdit" (byval self as integer,byval row as integer,byval col as integer,byval grid as integer) as integer
declare function wxGridCellTextEditor_EndEdit cdecl alias "wxGridCellTextEditor_EndEdit" (byval self as integer,byval row as integer,byval col as integer,byval grid as integer) as integer
declare function wxGridCellTextEditor_Reset cdecl alias "wxGridCellTextEditor_Reset" (byval self as integer) as integer
declare function wxGridCellTextEditor_StartingKey cdecl alias "wxGridCellTextEditor_StartingKey" (byval self as integer,byval event as integer) as integer
declare function wxGridCellTextEditor_SetParameters cdecl alias "wxGridCellTextEditor_SetParameters" (byval self as integer,byval params as string) as integer
declare function wxGridCellTextEditor_Clone cdecl alias "wxGridCellTextEditor_Clone" (byval self as integer) as integer
declare function wxGridCellAttrProvider_ctor cdecl alias "wxGridCellAttrProvider_ctor" () as integer
declare function wxGridCellAttrProvider_dtor cdecl alias "wxGridCellAttrProvider_dtor" (byval self as integer) as integer
declare function wxGridCellAttrProvider_RegisterVirtual cdecl alias "wxGridCellAttrProvider_RegisterVirtual" (byval self as integer,byval getAttr as integer,byval setAttr as integer,byval setRowAttr as integer,byval setColAttr as integer) as integer
declare function wxGridCellAttrProvider_SetAttr cdecl alias "wxGridCellAttrProvider_SetAttr" (byval self as integer,byval attr as integer,byval row as integer,byval col as integer) as integer
declare function wxGridCellAttrProvider_SetRowAttr cdecl alias "wxGridCellAttrProvider_SetRowAttr" (byval self as integer,byval attr as integer,byval row as integer) as integer
declare function wxGridCellAttrProvider_SetColAttr cdecl alias "wxGridCellAttrProvider_SetColAttr" (byval self as integer,byval attr as integer,byval col as integer) as integer
declare function wxGridCellAttrProvider_UpdateAttrRows cdecl alias "wxGridCellAttrProvider_UpdateAttrRows" (byval self as integer,byval pos as integer,byval numRows as integer) as integer
declare function wxGridCellAttrProvider_UpdateAttrCols cdecl alias "wxGridCellAttrProvider_UpdateAttrCols" (byval self as integer,byval pos as integer,byval numCols as integer) as integer
declare function wxGridCellNumberEditor_ctor cdecl alias "wxGridCellNumberEditor_ctor" (byval min as integer,byval max as integer) as integer
declare function wxGridCellNumberEditor_dtor cdecl alias "wxGridCellNumberEditor_dtor" (byval self as integer) as integer
declare function wxGridCellNumberEditor_RegisterDisposable cdecl alias "wxGridCellNumberEditor_RegisterDisposable" (byval self as integer,byval onDispose as integer) as integer
declare function wxGridCellNumberEditor_Create cdecl alias "wxGridCellNumberEditor_Create" (byval self as integer,byval parent as integer,byval id as integer,byval evtHandler as integer) as integer
declare function wxGridCellNumberEditor_IsAcceptedKey cdecl alias "wxGridCellNumberEditor_IsAcceptedKey" (byval self as integer,byval event as integer) as integer
declare function wxGridCellNumberEditor_BeginEdit cdecl alias "wxGridCellNumberEditor_BeginEdit" (byval self as integer,byval row as integer,byval col as integer,byval grid as integer) as integer
declare function wxGridCellNumberEditor_EndEdit cdecl alias "wxGridCellNumberEditor_EndEdit" (byval self as integer,byval row as integer,byval col as integer,byval grid as integer) as integer
declare function wxGridCellNumberEditor_Reset cdecl alias "wxGridCellNumberEditor_Reset" (byval self as integer) as integer
declare function wxGridCellNumberEditor_StartingKey cdecl alias "wxGridCellNumberEditor_StartingKey" (byval self as integer,byval event as integer) as integer
declare function wxGridCellNumberEditor_SetParameters cdecl alias "wxGridCellNumberEditor_SetParameters" (byval self as integer,byval params as string) as integer
declare function wxGridCellNumberEditor_Clone cdecl alias "wxGridCellNumberEditor_Clone" (byval self as integer) as integer
declare function wxGridCellFloatEditor_ctor cdecl alias "wxGridCellFloatEditor_ctor" (byval width as integer,byval precision as integer) as integer
declare function wxGridCellFloatEditor_dtor cdecl alias "wxGridCellFloatEditor_dtor" (byval self as integer) as integer
declare function wxGridCellFloatEditor_Create cdecl alias "wxGridCellFloatEditor_Create" (byval self as integer,byval parent as integer,byval id as integer,byval evtHandler as integer) as integer
declare function wxGridCellFloatEditor_IsAcceptedKey cdecl alias "wxGridCellFloatEditor_IsAcceptedKey" (byval self as integer,byval event as integer) as integer
declare function wxGridCellFloatEditor_BeginEdit cdecl alias "wxGridCellFloatEditor_BeginEdit" (byval self as integer,byval row as integer,byval col as integer,byval grid as integer) as integer
declare function wxGridCellFloatEditor_EndEdit cdecl alias "wxGridCellFloatEditor_EndEdit" (byval self as integer,byval row as integer,byval col as integer,byval grid as integer) as integer
declare function wxGridCellFloatEditor_Reset cdecl alias "wxGridCellFloatEditor_Reset" (byval self as integer) as integer
declare function wxGridCellFloatEditor_StartingKey cdecl alias "wxGridCellFloatEditor_StartingKey" (byval self as integer,byval event as integer) as integer
declare function wxGridCellFloatEditor_SetParameters cdecl alias "wxGridCellFloatEditor_SetParameters" (byval self as integer,byval params as string) as integer
declare function wxGridCellFloatEditor_Clone cdecl alias "wxGridCellFloatEditor_Clone" (byval self as integer) as integer
declare function wxGridCellBoolEditor_ctor cdecl alias "wxGridCellBoolEditor_ctor" () as integer
declare function wxGridCellBoolEditor_dtor cdecl alias "wxGridCellBoolEditor_dtor" (byval self as integer) as integer
declare function wxGridCellBoolEditor_RegisterDisposable cdecl alias "wxGridCellBoolEditor_RegisterDisposable" (byval self as integer,byval onDispose as integer) as integer
declare function wxGridCellBoolEditor_Create cdecl alias "wxGridCellBoolEditor_Create" (byval self as integer,byval parent as integer,byval id as integer,byval evtHandler as integer) as integer
declare function wxGridCellBoolEditor_SetSize cdecl alias "wxGridCellBoolEditor_SetSize" (byval self as integer,byval rect as integer) as integer
declare function wxGridCellBoolEditor_IsAcceptedKey cdecl alias "wxGridCellBoolEditor_IsAcceptedKey" (byval self as integer,byval event as integer) as integer
declare function wxGridCellBoolEditor_BeginEdit cdecl alias "wxGridCellBoolEditor_BeginEdit" (byval self as integer,byval row as integer,byval col as integer,byval grid as integer) as integer
declare function wxGridCellBoolEditor_EndEdit cdecl alias "wxGridCellBoolEditor_EndEdit" (byval self as integer,byval row as integer,byval col as integer,byval grid as integer) as integer
declare function wxGridCellBoolEditor_Reset cdecl alias "wxGridCellBoolEditor_Reset" (byval self as integer) as integer
declare function wxGridCellBoolEditor_StartingClick cdecl alias "wxGridCellBoolEditor_StartingClick" (byval self as integer) as integer
declare function wxGridCellBoolEditor_Clone cdecl alias "wxGridCellBoolEditor_Clone" (byval self as integer) as integer
declare function wxGridCellChoiceEditor_ctor cdecl alias "wxGridCellChoiceEditor_ctor" (byval n as integer,byval choices as byte ptr ptr,byval allowOthers as integer) as integer
declare function wxGridCellChoiceEditor_dtor cdecl alias "wxGridCellChoiceEditor_dtor" (byval self as integer) as integer
declare function wxGridCellChoiceEditor_RegisterDisposable cdecl alias "wxGridCellChoiceEditor_RegisterDisposable" (byval self as integer,byval onDispose as integer) as integer
declare function wxGridCellChoiceEditor_Create cdecl alias "wxGridCellChoiceEditor_Create" (byval self as integer,byval parent as integer,byval id as integer,byval evtHandler as integer) as integer
declare function wxGridCellChoiceEditor_PaintBackground cdecl alias "wxGridCellChoiceEditor_PaintBackground" (byval self as integer,byval rect as integer,byval attr as integer) as integer
declare function wxGridCellChoiceEditor_BeginEdit cdecl alias "wxGridCellChoiceEditor_BeginEdit" (byval self as integer,byval row as integer,byval col as integer,byval grid as integer) as integer
declare function wxGridCellChoiceEditor_EndEdit cdecl alias "wxGridCellChoiceEditor_EndEdit" (byval self as integer,byval row as integer,byval col as integer,byval grid as integer) as integer
declare function wxGridCellChoiceEditor_Reset cdecl alias "wxGridCellChoiceEditor_Reset" (byval self as integer) as integer
declare function wxGridCellChoiceEditor_SetParameters cdecl alias "wxGridCellChoiceEditor_SetParameters" (byval self as integer,byval params as string) as integer
declare function wxGridCellChoiceEditor_Clone cdecl alias "wxGridCellChoiceEditor_Clone" (byval self as integer) as integer
declare function wxGridCellStringRenderer_ctor cdecl alias "wxGridCellStringRenderer_ctor" () as integer
declare function wxGridCellStringRenderer_dtor cdecl alias "wxGridCellStringRenderer_dtor" (byval self as integer) as integer
declare function wxGridCellStringRenderer_RegisterDisposable cdecl alias "wxGridCellStringRenderer_RegisterDisposable" (byval self as integer,byval onDispose as integer) as integer
declare function wxGridCellStringRenderer_Draw cdecl alias "wxGridCellStringRenderer_Draw" (byval self as integer,byval grid as integer,byval attr as integer,byval dc as integer,byval rect as integer,byval row as integer,byval col as integer,byval isSelected as integer) as integer
declare function wxGridCellStringRenderer_GetBestSize cdecl alias "wxGridCellStringRenderer_GetBestSize" (byval self as integer,byval grid as integer,byval attr as integer,byval dc as integer,byval row as integer,byval col as integer,byval size as integer) as integer
declare function wxGridCellStringRenderer_Clone cdecl alias "wxGridCellStringRenderer_Clone" (byval self as integer) as integer
declare function wxGridCellNumberRenderer_ctor cdecl alias "wxGridCellNumberRenderer_ctor" () as integer
declare function wxGridCellNumberRenderer_dtor cdecl alias "wxGridCellNumberRenderer_dtor" (byval self as integer) as integer
declare function wxGridCellNumberRenderer_Draw cdecl alias "wxGridCellNumberRenderer_Draw" (byval self as integer,byval grid as integer,byval attr as integer,byval dc as integer,byval rect as integer,byval row as integer,byval col as integer,byval isSelected as integer) as integer
declare function wxGridCellNumberRenderer_GetBestSize cdecl alias "wxGridCellNumberRenderer_GetBestSize" (byval self as integer,byval grid as integer,byval attr as integer,byval dc as integer,byval row as integer,byval col as integer,byval size as integer) as integer
declare function wxGridCellNumberRenderer_Clone cdecl alias "wxGridCellNumberRenderer_Clone" (byval self as integer) as integer
declare function wxGridCellFloatRenderer_ctor cdecl alias "wxGridCellFloatRenderer_ctor" (byval width as integer,byval precision as integer) as integer
declare function wxGridCellFloatRenderer_dtor cdecl alias "wxGridCellFloatRenderer_dtor" (byval self as integer) as integer
declare function wxGridCellFloatRenderer_Draw cdecl alias "wxGridCellFloatRenderer_Draw" (byval self as integer,byval grid as integer,byval attr as integer,byval dc as integer,byval rect as integer,byval row as integer,byval col as integer,byval isSelected as integer) as integer
declare function wxGridCellFloatRenderer_GetBestSize cdecl alias "wxGridCellFloatRenderer_GetBestSize" (byval self as integer,byval grid as integer,byval attr as integer,byval dc as integer,byval row as integer,byval col as integer,byval size as integer) as integer
declare function wxGridCellFloatRenderer_Clone cdecl alias "wxGridCellFloatRenderer_Clone" (byval self as integer) as integer
declare function wxGridCellFloatRenderer_GetWidth cdecl alias "wxGridCellFloatRenderer_GetWidth" (byval self as integer) as integer
declare function wxGridCellFloatRenderer_SetWidth cdecl alias "wxGridCellFloatRenderer_SetWidth" (byval self as integer,byval width as integer) as integer
declare function wxGridCellFloatRenderer_GetPrecision cdecl alias "wxGridCellFloatRenderer_GetPrecision" (byval self as integer) as integer
declare function wxGridCellFloatRenderer_SetPrecision cdecl alias "wxGridCellFloatRenderer_SetPrecision" (byval self as integer,byval precision as integer) as integer
declare function wxGridCellFloatRenderer_SetParameters cdecl alias "wxGridCellFloatRenderer_SetParameters" (byval self as integer,byval params as string) as integer
declare function wxGridCellBoolRenderer_ctor cdecl alias "wxGridCellBoolRenderer_ctor" () as integer
declare function wxGridCellBoolRenderer_dtor cdecl alias "wxGridCellBoolRenderer_dtor" (byval self as integer) as integer
declare function wxGridCellBoolRenderer_RegisterDisposable cdecl alias "wxGridCellBoolRenderer_RegisterDisposable" (byval self as integer,byval onDispose as integer) as integer
declare function wxGridCellBoolRenderer_Draw cdecl alias "wxGridCellBoolRenderer_Draw" (byval self as integer,byval grid as integer,byval attr as integer,byval dc as integer,byval rect as integer,byval row as integer,byval col as integer,byval isSelected as integer) as integer
declare function wxGridCellBoolRenderer_GetBestSize cdecl alias "wxGridCellBoolRenderer_GetBestSize" (byval self as integer,byval grid as integer,byval attr as integer,byval dc as integer,byval row as integer,byval col as integer,byval size as integer) as integer
declare function wxGridCellBoolRenderer_Clone cdecl alias "wxGridCellBoolRenderer_Clone" (byval self as integer) as integer
declare function wxGridCellRenderer_ctor cdecl alias "wxGridCellRenderer_ctor" () as integer
declare function wxGridCellRenderer_dtor cdecl alias "wxGridCellRenderer_dtor" (byval self as integer) as integer
declare function wxGridCellRenderer_RegisterVirtual cdecl alias "wxGridCellRenderer_RegisterVirtual" (byval self as integer,byval draw as integer,byval getBestSize as integer,byval clone as integer) as integer
declare function wxGBSizerItem_ctor cdecl alias "wxGBSizerItem_ctor" (byval width as integer,byval height as integer,byval pos as integer,byval span as integer,byval flag as integer,byval border as integer,byval userData as integer) as integer
declare function wxGBSizerItem_ctorWindow cdecl alias "wxGBSizerItem_ctorWindow" (byval window as integer,byval pos as integer,byval span as integer,byval flag as integer,byval border as integer,byval userData as integer) as integer
declare function wxGBSizerItem_ctorSizer cdecl alias "wxGBSizerItem_ctorSizer" (byval sizer as integer,byval pos as integer,byval span as integer,byval flag as integer,byval border as integer,byval userData as integer) as integer
declare function wxGBSizerItem_ctorDefault cdecl alias "wxGBSizerItem_ctorDefault" () as integer
declare function wxGBSizerItem_GetPos cdecl alias "wxGBSizerItem_GetPos" (byval self as integer) as integer
declare function wxGBSizerItem_GetSpan cdecl alias "wxGBSizerItem_GetSpan" (byval self as integer) as integer
declare function wxGBSizerItem_SetPos cdecl alias "wxGBSizerItem_SetPos" (byval self as integer,byval pos as integer) as integer
declare function wxGBSizerItem_SetSpan cdecl alias "wxGBSizerItem_SetSpan" (byval self as integer,byval span as integer) as integer
declare function wxGBSizerItem_IntersectsSizer cdecl alias "wxGBSizerItem_IntersectsSizer" (byval self as integer,byval other as integer) as integer
declare function wxGBSizerItem_IntersectsSpan cdecl alias "wxGBSizerItem_IntersectsSpan" (byval self as integer,byval pos as integer,byval span as integer) as integer
declare function wxGBSizerItem_GetEndPos cdecl alias "wxGBSizerItem_GetEndPos" (byval self as integer,byval row as integer,byval col as integer) as integer
declare function wxGBSizerItem_GetGBSizer cdecl alias "wxGBSizerItem_GetGBSizer" (byval self as integer) as integer
declare function wxGBSizerItem_SetGBSizer cdecl alias "wxGBSizerItem_SetGBSizer" (byval self as integer,byval sizer as integer) as integer
declare function wxGBSpan_ctorDefault cdecl alias "wxGBSpan_ctorDefault" () as integer
declare function wxGBSpan_ctor cdecl alias "wxGBSpan_ctor" (byval rowspan as integer,byval colspan as integer) as integer
declare function wxGBSpan_GetRowspan cdecl alias "wxGBSpan_GetRowspan" (byval self as integer) as integer
declare function wxGBSpan_GetColspan cdecl alias "wxGBSpan_GetColspan" (byval self as integer) as integer
declare function wxGBSpan_SetRowspan cdecl alias "wxGBSpan_SetRowspan" (byval self as integer,byval rowspan as integer) as integer
declare function wxGBSpan_SetColspan cdecl alias "wxGBSpan_SetColspan" (byval self as integer,byval colspan as integer) as integer
declare function wxGridBagSizer_ctor cdecl alias "wxGridBagSizer_ctor" (byval vgap as integer,byval hgap as integer) as integer
declare function wxGridBagSizer_AddWindow cdecl alias "wxGridBagSizer_AddWindow" (byval self as integer,byval window as integer,byval pos as integer,byval span as integer,byval flag as integer,byval border as integer,byval userData as integer) as integer
declare function wxGridBagSizer_AddSizer cdecl alias "wxGridBagSizer_AddSizer" (byval self as integer,byval sizer as integer,byval pos as integer,byval span as integer,byval flag as integer,byval border as integer,byval userData as integer) as integer
declare function wxGridBagSizer_Add cdecl alias "wxGridBagSizer_Add" (byval self as integer,byval width as integer,byval height as integer,byval pos as integer,byval span as integer,byval flag as integer,byval border as integer,byval userData as integer) as integer
declare function wxGridBagSizer_AddItem cdecl alias "wxGridBagSizer_AddItem" (byval self as integer,byval item as integer) as integer
declare function wxGridBagSizer_GetEmptyCellSize cdecl alias "wxGridBagSizer_GetEmptyCellSize" (byval self as integer,byval size as integer) as integer
declare function wxGridBagSizer_SetEmptyCellSize cdecl alias "wxGridBagSizer_SetEmptyCellSize" (byval self as integer,byval sz as integer) as integer
declare function wxGridBagSizer_GetCellSize cdecl alias "wxGridBagSizer_GetCellSize" (byval self as integer,byval row as integer,byval col as integer,byval size as integer) as integer
declare function wxGridBagSizer_GetItemPosition cdecl alias "wxGridBagSizer_GetItemPosition" (byval self as integer,byval window as integer) as integer
declare function wxGridBagSizer_GetItemPositionSizer cdecl alias "wxGridBagSizer_GetItemPositionSizer" (byval self as integer,byval sizer as integer) as integer
declare function wxGridBagSizer_GetItemPositionIndex cdecl alias "wxGridBagSizer_GetItemPositionIndex" (byval self as integer,byval index as integer) as integer
declare function wxGridBagSizer_SetItemPosition cdecl alias "wxGridBagSizer_SetItemPosition" (byval self as integer,byval window as integer,byval pos as integer) as integer
declare function wxGridBagSizer_SetItemPositionSizer cdecl alias "wxGridBagSizer_SetItemPositionSizer" (byval self as integer,byval sizer as integer,byval pos as integer) as integer
declare function wxGridBagSizer_SetItemPositionIndex cdecl alias "wxGridBagSizer_SetItemPositionIndex" (byval self as integer,byval index as integer,byval pos as integer) as integer
declare function wxGridBagSizer_GetItemSpan cdecl alias "wxGridBagSizer_GetItemSpan" (byval self as integer,byval window as integer) as integer
declare function wxGridBagSizer_GetItemSpanSizer cdecl alias "wxGridBagSizer_GetItemSpanSizer" (byval self as integer,byval sizer as integer) as integer
declare function wxGridBagSizer_GetItemSpanIndex cdecl alias "wxGridBagSizer_GetItemSpanIndex" (byval self as integer,byval index as integer) as integer
declare function wxGridBagSizer_SetItemSpan cdecl alias "wxGridBagSizer_SetItemSpan" (byval self as integer,byval window as integer,byval span as integer) as integer
declare function wxGridBagSizer_SetItemSpanSizer cdecl alias "wxGridBagSizer_SetItemSpanSizer" (byval self as integer,byval sizer as integer,byval span as integer) as integer
declare function wxGridBagSizer_SetItemSpanIndex cdecl alias "wxGridBagSizer_SetItemSpanIndex" (byval self as integer,byval index as integer,byval span as integer) as integer
declare function wxGridBagSizer_FindItem cdecl alias "wxGridBagSizer_FindItem" (byval self as integer,byval window as integer) as integer
declare function wxGridBagSizer_FindItemSizer cdecl alias "wxGridBagSizer_FindItemSizer" (byval self as integer,byval sizer as integer) as integer
declare function wxGridBagSizer_FindItemAtPosition cdecl alias "wxGridBagSizer_FindItemAtPosition" (byval self as integer,byval pos as integer) as integer
declare function wxGridBagSizer_FindItemAtPoint cdecl alias "wxGridBagSizer_FindItemAtPoint" (byval self as integer,byval pt as integer) as integer
declare function wxGridBagSizer_FindItemWithData cdecl alias "wxGridBagSizer_FindItemWithData" (byval self as integer,byval userData as integer) as integer
declare function wxGridBagSizer_CheckForIntersectionItem cdecl alias "wxGridBagSizer_CheckForIntersectionItem" (byval self as integer,byval item as integer,byval excludeItem as integer) as integer
declare function wxGridBagSizer_CheckForIntersectionPos cdecl alias "wxGridBagSizer_CheckForIntersectionPos" (byval self as integer,byval pos as integer,byval span as integer,byval excludeItem as integer) as integer
declare function wxGBPosition_ctor cdecl alias "wxGBPosition_ctor" () as integer
declare function wxGBPosition_ctorPos cdecl alias "wxGBPosition_ctorPos" (byval row as integer,byval col as integer) as integer
declare function wxGBPosition_GetRow cdecl alias "wxGBPosition_GetRow" (byval self as integer) as integer
declare function wxGBPosition_GetCol cdecl alias "wxGBPosition_GetCol" (byval self as integer) as integer
declare function wxGBPosition_SetRow cdecl alias "wxGBPosition_SetRow" (byval self as integer,byval row as integer) as integer
declare function wxGBPosition_SetCol cdecl alias "wxGBPosition_SetCol" (byval self as integer,byval col as integer) as integer
declare function wxGridCellDateTimeRenderer_ctor cdecl alias "wxGridCellDateTimeRenderer_ctor" (byval outformat as string,byval informat as string) as integer
declare function wxGridCellDateTimeRenderer_dtor cdecl alias "wxGridCellDateTimeRenderer_dtor" (byval self as integer) as integer
declare function wxGridCellDateTimeRenderer_Draw cdecl alias "wxGridCellDateTimeRenderer_Draw" (byval self as integer,byval grid as integer,byval attr as integer,byval dc as integer,byval rect as integer,byval row as integer,byval col as integer,byval isSelected as integer) as integer
declare function wxGridCellDateTimeRenderer_GetBestSize cdecl alias "wxGridCellDateTimeRenderer_GetBestSize" (byval self as integer,byval grid as integer,byval attr as integer,byval dc as integer,byval row as integer,byval col as integer,byval size as integer) as integer
declare function wxGridCellDateTimeRenderer_Clone cdecl alias "wxGridCellDateTimeRenderer_Clone" (byval self as integer) as integer
declare function wxGridCellDateTimeRenderer_SetParameters cdecl alias "wxGridCellDateTimeRenderer_SetParameters" (byval self as integer,byval params as string) as integer
declare function wxGridCellEnumRenderer_ctor cdecl alias "wxGridCellEnumRenderer_ctor" (byval n as integer,byval choices as byte ptr ptr) as integer
declare function wxGridCellEnumRenderer_dtor cdecl alias "wxGridCellEnumRenderer_dtor" (byval self as integer) as integer
declare function wxGridCellEnumRenderer_Draw cdecl alias "wxGridCellEnumRenderer_Draw" (byval self as integer,byval grid as integer,byval attr as integer,byval dc as integer,byval rect as integer,byval row as integer,byval col as integer,byval isSelected as integer) as integer
declare function wxGridCellEnumRenderer_GetBestSize cdecl alias "wxGridCellEnumRenderer_GetBestSize" (byval self as integer,byval grid as integer,byval attr as integer,byval dc as integer,byval row as integer,byval col as integer,byval size as integer) as integer
declare function wxGridCellEnumRenderer_Clone cdecl alias "wxGridCellEnumRenderer_Clone" (byval self as integer) as integer
declare function wxGridCellEnumRenderer_SetParameters cdecl alias "wxGridCellEnumRenderer_SetParameters" (byval self as integer,byval params as string) as integer
declare function wxGridCellAutoWrapStringRenderer_ctor cdecl alias "wxGridCellAutoWrapStringRenderer_ctor" () as integer
declare function wxGridCellAutoWrapStringRenderer_dtor cdecl alias "wxGridCellAutoWrapStringRenderer_dtor" (byval self as integer) as integer
declare function wxGridCellAutoWrapStringRenderer_RegisterDisposable cdecl alias "wxGridCellAutoWrapStringRenderer_RegisterDisposable" (byval self as integer,byval onDispose as integer) as integer
declare function wxGridCellAutoWrapStringRenderer_Draw cdecl alias "wxGridCellAutoWrapStringRenderer_Draw" (byval self as integer,byval grid as integer,byval attr as integer,byval dc as integer,byval rect as integer,byval row as integer,byval col as integer,byval isSelected as integer) as integer
declare function wxGridCellAutoWrapStringRenderer_GetBestSize cdecl alias "wxGridCellAutoWrapStringRenderer_GetBestSize" (byval self as integer,byval grid as integer,byval attr as integer,byval dc as integer,byval row as integer,byval col as integer,byval size as integer) as integer
declare function wxGridCellAutoWrapStringRenderer_Clone cdecl alias "wxGridCellAutoWrapStringRenderer_Clone" (byval self as integer) as integer
declare function wxGridCellEnumEditor_ctor cdecl alias "wxGridCellEnumEditor_ctor" (byval n as integer,byval choices as byte ptr ptr) as integer
declare function wxGridCellEnumEditor_dtor cdecl alias "wxGridCellEnumEditor_dtor" (byval self as integer) as integer
declare function wxGridCellEnumEditor_BeginEdit cdecl alias "wxGridCellEnumEditor_BeginEdit" (byval self as integer,byval row as integer,byval col as integer,byval grid as integer) as integer
declare function wxGridCellEnumEditor_EndEdit cdecl alias "wxGridCellEnumEditor_EndEdit" (byval self as integer,byval row as integer,byval col as integer,byval grid as integer) as integer
declare function wxGridCellEnumEditor_Clone cdecl alias "wxGridCellEnumEditor_Clone" (byval self as integer) as integer
declare function wxGridCellAutoWrapStringEditor_ctor cdecl alias "wxGridCellAutoWrapStringEditor_ctor" () as integer
declare function wxGridCellAutoWrapStringEditor_dtor cdecl alias "wxGridCellAutoWrapStringEditor_dtor" (byval self as integer) as integer
declare function wxGridCellAutoWrapStringEditor_RegisterDisposable cdecl alias "wxGridCellAutoWrapStringEditor_RegisterDisposable" (byval self as integer,byval onDispose as integer) as integer
declare function wxGridCellAutoWrapStringEditor_Create cdecl alias "wxGridCellAutoWrapStringEditor_Create" (byval self as integer,byval parent as integer,byval id as integer,byval evtHandler as integer) as integer
declare function wxGridCellAutoWrapStringEditor_Clone cdecl alias "wxGridCellAutoWrapStringEditor_Clone" (byval self as integer) as integer
declare function wxGridSizer_ctor cdecl alias "wxGridSizer_ctor" (byval rows as integer,byval cols as integer,byval vgap as integer,byval hgap as integer) as integer
declare function wxGridSizer_RecalcSizes cdecl alias "wxGridSizer_RecalcSizes" (byval self as integer) as integer
declare function wxGridSizer_CalcMin cdecl alias "wxGridSizer_CalcMin" (byval self as integer,byval size as integer) as integer
declare function wxGridSizer_SetCols cdecl alias "wxGridSizer_SetCols" (byval self as integer,byval cols as integer) as integer
declare function wxGridSizer_SetRows cdecl alias "wxGridSizer_SetRows" (byval self as integer,byval rows as integer) as integer
declare function wxGridSizer_SetVGap cdecl alias "wxGridSizer_SetVGap" (byval self as integer,byval gap as integer) as integer
declare function wxGridSizer_SetHGap cdecl alias "wxGridSizer_SetHGap" (byval self as integer,byval gap as integer) as integer
declare function wxGridSizer_GetCols cdecl alias "wxGridSizer_GetCols" (byval self as integer) as integer
declare function wxGridSizer_GetRows cdecl alias "wxGridSizer_GetRows" (byval self as integer) as integer
declare function wxGridSizer_GetVGap cdecl alias "wxGridSizer_GetVGap" (byval self as integer) as integer
declare function wxGridSizer_GetHGap cdecl alias "wxGridSizer_GetHGap" (byval self as integer) as integer
declare function wxHelpEvent_ctor cdecl alias "wxHelpEvent_ctor" (byval type as integer) as integer
declare function wxHelpEvent_GetPosition cdecl alias "wxHelpEvent_GetPosition" (byval self as integer,byval inp as integer) as integer
declare function wxHelpEvent_SetPosition cdecl alias "wxHelpEvent_SetPosition" (byval self as integer,byval pos as integer) as integer
declare function wxHelpEvent_GetLink cdecl alias "wxHelpEvent_GetLink" (byval self as integer) as byte ptr
declare function wxHelpEvent_SetLink cdecl alias "wxHelpEvent_SetLink" (byval self as integer,byval link as string) as integer
declare function wxHelpEvent_GetTarget cdecl alias "wxHelpEvent_GetTarget" (byval self as integer) as byte ptr
declare function wxHelpEvent_SetTarget cdecl alias "wxHelpEvent_SetTarget" (byval self as integer,byval target as string) as integer
declare function wxHtmlWindow_ctor cdecl alias "wxHtmlWindow_ctor" () as integer
declare function wxHtmlWindow_ctor2 cdecl alias "wxHtmlWindow_ctor2" (byval parent as integer,byval id as integer,byval pos as integer,byval size as integer,byval style as long,byval name as string) as integer
declare function wxHtmlWindow_RegisterVirtual cdecl alias "wxHtmlWindow_RegisterVirtual" (byval self as integer,byval onLinkClicked as integer,byval onSetTitle as integer,byval onCellMouseHover as integer,byval onCellClicked as integer,byval onOpeningURL as integer) as integer
declare function wxHtmlWindow_Create cdecl alias "wxHtmlWindow_Create" (byval self as integer,byval parent as integer,byval id as integer,byval pos as integer,byval size as integer,byval style as long,byval name as string) as integer
declare function wxHtmlWindow_SetPage cdecl alias "wxHtmlWindow_SetPage" (byval self as integer,byval source as string) as integer
declare function wxHtmlWindow_AppendToPage cdecl alias "wxHtmlWindow_AppendToPage" (byval self as integer,byval source as string) as integer
declare function wxHtmlWindow_LoadPage cdecl alias "wxHtmlWindow_LoadPage" (byval self as integer,byval location as string) as integer
declare function wxHtmlWindow_LoadFile cdecl alias "wxHtmlWindow_LoadFile" (byval self as integer,byval filename as string) as integer
declare function wxHtmlWindow_GetOpenedPage cdecl alias "wxHtmlWindow_GetOpenedPage" (byval self as integer) as byte ptr
declare function wxHtmlWindow_GetOpenedAnchor cdecl alias "wxHtmlWindow_GetOpenedAnchor" (byval self as integer) as byte ptr
declare function wxHtmlWindow_GetOpenedPageTitle cdecl alias "wxHtmlWindow_GetOpenedPageTitle" (byval self as integer) as byte ptr
declare function wxHtmlWindow_SetRelatedFrame cdecl alias "wxHtmlWindow_SetRelatedFrame" (byval self as integer,byval frame as integer,byval format as string) as integer
declare function wxHtmlWindow_GetRelatedFrame cdecl alias "wxHtmlWindow_GetRelatedFrame" (byval self as integer) as integer
declare function wxHtmlWindow_SetRelatedStatusBar cdecl alias "wxHtmlWindow_SetRelatedStatusBar" (byval self as integer,byval bar as integer) as integer
declare function wxHtmlWindow_SetFonts cdecl alias "wxHtmlWindow_SetFonts" (byval self as integer,byval normal_face as string,byval fixed_face as string,byval sizes as integer) as integer
declare function wxHtmlWindow_SetBorders cdecl alias "wxHtmlWindow_SetBorders" (byval self as integer,byval b as integer) as integer
declare function wxHtmlWindow_ReadCustomization cdecl alias "wxHtmlWindow_ReadCustomization" (byval self as integer,byval cfg as integer,byval path as string) as integer
declare function wxHtmlWindow_WriteCustomization cdecl alias "wxHtmlWindow_WriteCustomization" (byval self as integer,byval cfg as integer,byval path as string) as integer
declare function wxHtmlWindow_HistoryBack cdecl alias "wxHtmlWindow_HistoryBack" (byval self as integer) as integer
declare function wxHtmlWindow_HistoryForward cdecl alias "wxHtmlWindow_HistoryForward" (byval self as integer) as integer
declare function wxHtmlWindow_HistoryCanBack cdecl alias "wxHtmlWindow_HistoryCanBack" (byval self as integer) as integer
declare function wxHtmlWindow_HistoryCanForward cdecl alias "wxHtmlWindow_HistoryCanForward" (byval self as integer) as integer
declare function wxHtmlWindow_HistoryClear cdecl alias "wxHtmlWindow_HistoryClear" (byval self as integer) as integer
declare function wxHtmlWindow_GetInternalRepresentation cdecl alias "wxHtmlWindow_GetInternalRepresentation" (byval self as integer) as integer
declare function wxHtmlWindow_AddFilter cdecl alias "wxHtmlWindow_AddFilter" (byval filter as integer) as integer
declare function wxHtmlWindow_GetParser cdecl alias "wxHtmlWindow_GetParser" (byval self as integer) as integer
declare function wxHtmlWindow_AddProcessor cdecl alias "wxHtmlWindow_AddProcessor" (byval self as integer,byval processor as integer) as integer
declare function wxHtmlWindow_AddGlobalProcessor cdecl alias "wxHtmlWindow_AddGlobalProcessor" (byval processor as integer) as integer
declare function wxHtmlWindow_AcceptsFocusFromKeyboard cdecl alias "wxHtmlWindow_AcceptsFocusFromKeyboard" (byval self as integer) as integer
declare function wxHtmlWindow_OnSetTitle cdecl alias "wxHtmlWindow_OnSetTitle" (byval self as integer,byval title as string) as integer
declare function wxHtmlWindow_OnCellClicked cdecl alias "wxHtmlWindow_OnCellClicked" (byval self as integer,byval cell as integer,byval x as integer,byval y as integer,byval event as integer) as integer
declare function wxHtmlWindow_OnLinkClicked cdecl alias "wxHtmlWindow_OnLinkClicked" (byval self as integer,byval link as integer) as integer
declare function wxHtmlWindow_OnOpeningURL cdecl alias "wxHtmlWindow_OnOpeningURL" (byval self as integer,byval type as integer,byval url as string,byval redirect as string) as integer
declare function wxHtmlWindow_SelectAll cdecl alias "wxHtmlWindow_SelectAll" (byval self as integer) as integer
declare function wxHtmlWindow_SelectWord cdecl alias "wxHtmlWindow_SelectWord" (byval self as integer,byval pos as integer) as integer
declare function wxHtmlWindow_SelectLine cdecl alias "wxHtmlWindow_SelectLine" (byval self as integer,byval pos as integer) as integer
declare function wxHtmlWindow_ToText cdecl alias "wxHtmlWindow_ToText" (byval self as integer) as byte ptr
declare function wxHtmlWindow_SelectionToText cdecl alias "wxHtmlWindow_SelectionToText" (byval self as integer) as byte ptr
declare function wxHtmlFontCell_ctor cdecl alias "wxHtmlFontCell_ctor" (byval font as integer) as integer
declare function wxHtmlFontCell_Draw cdecl alias "wxHtmlFontCell_Draw" (byval self as integer,byval dc as integer,byval x as integer,byval y as integer,byval view_y1 as integer,byval view_y2 as integer,byval info as integer) as integer
declare function wxHtmlFontCell_DrawInvisible cdecl alias "wxHtmlFontCell_DrawInvisible" (byval self as integer,byval dc as integer,byval x as integer,byval y as integer,byval info as integer) as integer
declare function wxHtmlColourCell_ctor cdecl alias "wxHtmlColourCell_ctor" (byval clr as integer,byval flags as integer) as integer
declare function wxHtmlColourCell_Draw cdecl alias "wxHtmlColourCell_Draw" (byval self as integer,byval dc as integer,byval x as integer,byval y as integer,byval view_y1 as integer,byval view_y2 as integer,byval info as integer) as integer
declare function wxHtmlColourCell_DrawInvisible cdecl alias "wxHtmlColourCell_DrawInvisible" (byval self as integer,byval dc as integer,byval x as integer,byval y as integer,byval info as integer) as integer
declare function wxHtmlLinkInfo_ctor cdecl alias "wxHtmlLinkInfo_ctor" () as integer
declare function wxHtmlLinkInfo_SetEvent cdecl alias "wxHtmlLinkInfo_SetEvent" (byval self as integer,byval e as integer) as integer
declare function wxHtmlLinkInfo_SetHtmlCell cdecl alias "wxHtmlLinkInfo_SetHtmlCell" (byval self as integer,byval e as integer) as integer
declare function wxHtmlLinkInfo_GetHref cdecl alias "wxHtmlLinkInfo_GetHref" (byval self as integer) as byte ptr
declare function wxHtmlLinkInfo_GetTarget cdecl alias "wxHtmlLinkInfo_GetTarget" (byval self as integer) as byte ptr
declare function wxHtmlLinkInfo_GetEvent cdecl alias "wxHtmlLinkInfo_GetEvent" (byval self as integer) as integer
declare function wxHtmlLinkInfo_GetHtmlCell cdecl alias "wxHtmlLinkInfo_GetHtmlCell" (byval self as integer) as integer
declare function wxHtmlWidgetCell_ctor cdecl alias "wxHtmlWidgetCell_ctor" (byval wnd as integer,byval w as integer) as integer
declare function wxHtmlWidgetCell_Draw cdecl alias "wxHtmlWidgetCell_Draw" (byval self as integer,byval dc as integer,byval x as integer,byval y as integer,byval view_y1 as integer,byval view_y2 as integer,byval info as integer) as integer
declare function wxHtmlWidgetCell_DrawInvisible cdecl alias "wxHtmlWidgetCell_DrawInvisible" (byval self as integer,byval dc as integer,byval x as integer,byval y as integer,byval info as integer) as integer
declare function wxHtmlWidgetCell_Layout cdecl alias "wxHtmlWidgetCell_Layout" (byval self as integer,byval w as integer) as integer
declare function wxHtmlCell_ctor cdecl alias "wxHtmlCell_ctor" () as integer
declare function wxHtmlCell_SetParent cdecl alias "wxHtmlCell_SetParent" (byval self as integer,byval p as integer) as integer
declare function wxHtmlCell_GetParent cdecl alias "wxHtmlCell_GetParent" (byval self as integer) as integer
declare function wxHtmlCell_GetPosX cdecl alias "wxHtmlCell_GetPosX" (byval self as integer) as integer
declare function wxHtmlCell_GetPosY cdecl alias "wxHtmlCell_GetPosY" (byval self as integer) as integer
declare function wxHtmlCell_GetWidth cdecl alias "wxHtmlCell_GetWidth" (byval self as integer) as integer
declare function wxHtmlCell_GetHeight cdecl alias "wxHtmlCell_GetHeight" (byval self as integer) as integer
declare function wxHtmlCell_GetDescent cdecl alias "wxHtmlCell_GetDescent" (byval self as integer) as integer
declare function wxHtmlCell_GetId cdecl alias "wxHtmlCell_GetId" (byval self as integer) as byte ptr
declare function wxHtmlCell_SetId cdecl alias "wxHtmlCell_SetId" (byval self as integer,byval id as string) as integer
declare function wxHtmlCell_GetNext cdecl alias "wxHtmlCell_GetNext" (byval self as integer) as integer
declare function wxHtmlCell_SetPos cdecl alias "wxHtmlCell_SetPos" (byval self as integer,byval x as integer,byval y as integer) as integer
declare function wxHtmlCell_SetLink cdecl alias "wxHtmlCell_SetLink" (byval self as integer,byval link as integer) as integer
declare function wxHtmlCell_SetNext cdecl alias "wxHtmlCell_SetNext" (byval self as integer,byval cell as integer) as integer
declare function wxHtmlCell_Layout cdecl alias "wxHtmlCell_Layout" (byval self as integer,byval w as integer) as integer
declare function wxHtmlCell_Draw cdecl alias "wxHtmlCell_Draw" (byval self as integer,byval dc as integer,byval x as integer,byval y as integer,byval view_y1 as integer,byval view_y2 as integer,byval info as integer) as integer
declare function wxHtmlCell_DrawInvisible cdecl alias "wxHtmlCell_DrawInvisible" (byval self as integer,byval dc as integer,byval x as integer,byval y as integer,byval info as integer) as integer
declare function wxHtmlCell_Find cdecl alias "wxHtmlCell_Find" (byval self as integer,byval condition as integer,byval param as integer) as integer
declare function wxHtmlCell_OnMouseClick cdecl alias "wxHtmlCell_OnMouseClick" (byval self as integer,byval parent as integer,byval x as integer,byval y as integer,byval event as integer) as integer
declare function wxHtmlCell_AdjustPagebreak cdecl alias "wxHtmlCell_AdjustPagebreak" (byval self as integer,byval pagebreak as integer) as integer
declare function wxHtmlCell_SetCanLiveOnPagebreak cdecl alias "wxHtmlCell_SetCanLiveOnPagebreak" (byval self as integer,byval can as integer) as integer
declare function wxHtmlCell_IsTerminalCell cdecl alias "wxHtmlCell_IsTerminalCell" (byval self as integer) as integer
declare function wxHtmlCell_FindCellByPos cdecl alias "wxHtmlCell_FindCellByPos" (byval self as integer,byval x as integer,byval y as integer) as integer
declare function wxHtmlWordCell_ctor cdecl alias "wxHtmlWordCell_ctor" (byval word as string,byval dc as integer) as integer
declare function wxHtmlWordCell_Draw cdecl alias "wxHtmlWordCell_Draw" (byval self as integer,byval dc as integer,byval x as integer,byval y as integer,byval view_y1 as integer,byval view_y2 as integer,byval info as integer) as integer
declare function wxHtmlContainerCell_ctor cdecl alias "wxHtmlContainerCell_ctor" (byval parent as integer) as integer
declare function wxHtmlContainerCell_Layout cdecl alias "wxHtmlContainerCell_Layout" (byval self as integer,byval w as integer) as integer
declare function wxHtmlContainerCell_Draw cdecl alias "wxHtmlContainerCell_Draw" (byval self as integer,byval dc as integer,byval x as integer,byval y as integer,byval view_y1 as integer,byval view_y2 as integer,byval info as integer) as integer
declare function wxHtmlContainerCell_DrawInvisible cdecl alias "wxHtmlContainerCell_DrawInvisible" (byval self as integer,byval dc as integer,byval x as integer,byval y as integer,byval info as integer) as integer
declare function wxHtmlContainerCell_AdjustPagebreak cdecl alias "wxHtmlContainerCell_AdjustPagebreak" (byval self as integer,byval pagebreak as integer) as integer
declare function wxHtmlContainerCell_InsertCell cdecl alias "wxHtmlContainerCell_InsertCell" (byval self as integer,byval cell as integer) as integer
declare function wxHtmlContainerCell_SetAlignHor cdecl alias "wxHtmlContainerCell_SetAlignHor" (byval self as integer,byval al as integer) as integer
declare function wxHtmlContainerCell_GetAlignHor cdecl alias "wxHtmlContainerCell_GetAlignHor" (byval self as integer) as integer
declare function wxHtmlContainerCell_SetAlignVer cdecl alias "wxHtmlContainerCell_SetAlignVer" (byval self as integer,byval al as integer) as integer
declare function wxHtmlContainerCell_GetAlignVer cdecl alias "wxHtmlContainerCell_GetAlignVer" (byval self as integer) as integer
declare function wxHtmlContainerCell_SetIndent cdecl alias "wxHtmlContainerCell_SetIndent" (byval self as integer,byval i as integer,byval what as integer,byval units as integer) as integer
declare function wxHtmlContainerCell_GetIndent cdecl alias "wxHtmlContainerCell_GetIndent" (byval self as integer,byval ind as integer) as integer
declare function wxHtmlContainerCell_GetIndentUnits cdecl alias "wxHtmlContainerCell_GetIndentUnits" (byval self as integer,byval ind as integer) as integer
declare function wxHtmlContainerCell_SetAlign cdecl alias "wxHtmlContainerCell_SetAlign" (byval self as integer,byval tag as integer) as integer
declare function wxHtmlContainerCell_SetWidthFloat cdecl alias "wxHtmlContainerCell_SetWidthFloat" (byval self as integer,byval w as integer,byval units as integer) as integer
declare function wxHtmlContainerCell_SetWidthFloatTag cdecl alias "wxHtmlContainerCell_SetWidthFloatTag" (byval self as integer,byval tag as integer,byval pixel_scale as integer) as integer
declare function wxHtmlContainerCell_SetMinHeight cdecl alias "wxHtmlContainerCell_SetMinHeight" (byval self as integer,byval h as integer,byval align as integer) as integer
declare function wxHtmlContainerCell_SetBackgroundColour cdecl alias "wxHtmlContainerCell_SetBackgroundColour" (byval self as integer,byval clr as integer) as integer
declare function wxHtmlContainerCell_GetBackgroundColour cdecl alias "wxHtmlContainerCell_GetBackgroundColour" (byval self as integer) as integer
declare function wxHtmlContainerCell_SetBorder cdecl alias "wxHtmlContainerCell_SetBorder" (byval self as integer,byval clr1 as integer,byval clr2 as integer) as integer
declare function wxHtmlContainerCell_GetLink cdecl alias "wxHtmlContainerCell_GetLink" (byval self as integer,byval x as integer,byval y as integer) as integer
declare function wxHtmlContainerCell_Find cdecl alias "wxHtmlContainerCell_Find" (byval self as integer,byval condition as integer,byval param as integer) as integer
declare function wxHtmlContainerCell_OnMouseClick cdecl alias "wxHtmlContainerCell_OnMouseClick" (byval self as integer,byval parent as integer,byval x as integer,byval y as integer,byval event as integer) as integer
declare function wxHtmlContainerCell_IsTerminalCell cdecl alias "wxHtmlContainerCell_IsTerminalCell" (byval self as integer) as integer
declare function wxHtmlContainerCell_FindCellByPos cdecl alias "wxHtmlContainerCell_FindCellByPos" (byval self as integer,byval x as integer,byval y as integer) as integer
declare function wxHtmlTag_GetParent cdecl alias "wxHtmlTag_GetParent" (byval self as integer) as integer
declare function wxHtmlTag_GetFirstSibling cdecl alias "wxHtmlTag_GetFirstSibling" (byval self as integer) as integer
declare function wxHtmlTag_GetLastSibling cdecl alias "wxHtmlTag_GetLastSibling" (byval self as integer) as integer
declare function wxHtmlTag_GetChildren cdecl alias "wxHtmlTag_GetChildren" (byval self as integer) as integer
declare function wxHtmlTag_GetPreviousSibling cdecl alias "wxHtmlTag_GetPreviousSibling" (byval self as integer) as integer
declare function wxHtmlTag_GetNextSibling cdecl alias "wxHtmlTag_GetNextSibling" (byval self as integer) as integer
declare function wxHtmlTag_GetNextTag cdecl alias "wxHtmlTag_GetNextTag" (byval self as integer) as integer
declare function wxHtmlTag_GetName cdecl alias "wxHtmlTag_GetName" (byval self as integer) as byte ptr
declare function wxHtmlTag_HasParam cdecl alias "wxHtmlTag_HasParam" (byval self as integer,byval par as string) as integer
declare function wxHtmlTag_GetParam cdecl alias "wxHtmlTag_GetParam" (byval self as integer,byval par as string,byval with_commas as integer) as byte ptr
declare function wxHtmlTag_GetParamAsColour cdecl alias "wxHtmlTag_GetParamAsColour" (byval self as integer,byval par as string,byval clr as integer) as integer
declare function wxHtmlTag_GetParamAsInt cdecl alias "wxHtmlTag_GetParamAsInt" (byval self as integer,byval par as string,byval clr as integer) as integer
declare function wxHtmlTag_ScanParam cdecl alias "wxHtmlTag_ScanParam" (byval self as integer,byval par as string,byval format as string,byval param as integer) as integer
declare function wxHtmlTag_GetAllParams cdecl alias "wxHtmlTag_GetAllParams" (byval self as integer) as byte ptr
declare function wxHtmlTag_HasEnding cdecl alias "wxHtmlTag_HasEnding" (byval self as integer) as integer
declare function wxHtmlTag_GetBeginPos cdecl alias "wxHtmlTag_GetBeginPos" (byval self as integer) as integer
declare function wxHtmlTag_GetEndPos1 cdecl alias "wxHtmlTag_GetEndPos1" (byval self as integer) as integer
declare function wxHtmlTag_GetEndPos2 cdecl alias "wxHtmlTag_GetEndPos2" (byval self as integer) as integer
declare function wxHtmlFilter_CanRead cdecl alias "wxHtmlFilter_CanRead" (byval self as integer,byval file as integer) as integer
declare function wxHtmlFilter_ReadFile cdecl alias "wxHtmlFilter_ReadFile" (byval self as integer,byval file as integer) as byte ptr
declare function wxHtmlFilterPlainText_CanRead cdecl alias "wxHtmlFilterPlainText_CanRead" (byval self as integer,byval file as integer) as integer
declare function wxHtmlFilterPlainText_ReadFile cdecl alias "wxHtmlFilterPlainText_ReadFile" (byval self as integer,byval file as integer) as byte ptr
declare function wxHtmlFilterHTML_CanRead cdecl alias "wxHtmlFilterHTML_CanRead" (byval self as integer,byval file as integer) as integer
declare function wxHtmlFilterHTML_ReadFile cdecl alias "wxHtmlFilterHTML_ReadFile" (byval self as integer,byval file as integer) as byte ptr
declare function wxHtmlTagsModule_ctor cdecl alias "wxHtmlTagsModule_ctor" () as integer
declare function wxHtmlTagsModule_OnInit cdecl alias "wxHtmlTagsModule_OnInit" (byval self as integer) as integer
declare function wxHtmlTagsModule_OnExit cdecl alias "wxHtmlTagsModule_OnExit" (byval self as integer) as integer
declare function wxHtmlTagsModule_FillHandlersTable cdecl alias "wxHtmlTagsModule_FillHandlersTable" (byval self as integer,byval parser as integer) as integer
declare function wxHtmlWinParser_ctor cdecl alias "wxHtmlWinParser_ctor" (byval wnd as integer) as integer
declare function wxHtmlWinParser_InitParser cdecl alias "wxHtmlWinParser_InitParser" (byval self as integer,byval source as string) as integer
declare function wxHtmlWinParser_DoneParser cdecl alias "wxHtmlWinParser_DoneParser" (byval self as integer) as integer
declare function wxHtmlWinParser_GetProduct cdecl alias "wxHtmlWinParser_GetProduct" (byval self as integer) as integer
declare function wxHtmlWinParser_OpenURL cdecl alias "wxHtmlWinParser_OpenURL" (byval self as integer,byval type as integer,byval url as string) as integer
declare function wxHtmlWinParser_SetDC cdecl alias "wxHtmlWinParser_SetDC" (byval self as integer,byval dc as integer,byval pixel_scale as integer) as integer
declare function wxHtmlWinParser_GetDC cdecl alias "wxHtmlWinParser_GetDC" (byval self as integer) as integer
declare function wxHtmlWinParser_GetPixelScale cdecl alias "wxHtmlWinParser_GetPixelScale" (byval self as integer) as integer
declare function wxHtmlWinParser_GetCharHeight cdecl alias "wxHtmlWinParser_GetCharHeight" (byval self as integer) as integer
declare function wxHtmlWinParser_GetCharWidth cdecl alias "wxHtmlWinParser_GetCharWidth" (byval self as integer) as integer
declare function wxHtmlWinParser_GetWindow cdecl alias "wxHtmlWinParser_GetWindow" (byval self as integer) as integer
declare function wxHtmlWinParser_SetFonts cdecl alias "wxHtmlWinParser_SetFonts" (byval self as integer,byval normal_face as string,byval fixed_face as string,byval sizes as integer) as integer
declare function wxHtmlWinParser_AddModule cdecl alias "wxHtmlWinParser_AddModule" (byval self as integer,byval module as integer) as integer
declare function wxHtmlWinParser_RemoveModule cdecl alias "wxHtmlWinParser_RemoveModule" (byval self as integer,byval module as integer) as integer
declare function wxHtmlWinParser_GetContainer cdecl alias "wxHtmlWinParser_GetContainer" (byval self as integer) as integer
declare function wxHtmlWinParser_OpenContainer cdecl alias "wxHtmlWinParser_OpenContainer" (byval self as integer) as integer
declare function wxHtmlWinParser_SetContainer cdecl alias "wxHtmlWinParser_SetContainer" (byval self as integer,byval c as integer) as integer
declare function wxHtmlWinParser_CloseContainer cdecl alias "wxHtmlWinParser_CloseContainer" (byval self as integer) as integer
declare function wxHtmlWinParser_GetFontSize cdecl alias "wxHtmlWinParser_GetFontSize" (byval self as integer) as integer
declare function wxHtmlWinParser_SetFontSize cdecl alias "wxHtmlWinParser_SetFontSize" (byval self as integer,byval s as integer) as integer
declare function wxHtmlWinParser_GetFontBold cdecl alias "wxHtmlWinParser_GetFontBold" (byval self as integer) as integer
declare function wxHtmlWinParser_SetFontBold cdecl alias "wxHtmlWinParser_SetFontBold" (byval self as integer,byval x as integer) as integer
declare function wxHtmlWinParser_GetFontItalic cdecl alias "wxHtmlWinParser_GetFontItalic" (byval self as integer) as integer
declare function wxHtmlWinParser_SetFontItalic cdecl alias "wxHtmlWinParser_SetFontItalic" (byval self as integer,byval x as integer) as integer
declare function wxHtmlWinParser_GetFontUnderlined cdecl alias "wxHtmlWinParser_GetFontUnderlined" (byval self as integer) as integer
declare function wxHtmlWinParser_SetFontUnderlined cdecl alias "wxHtmlWinParser_SetFontUnderlined" (byval self as integer,byval x as integer) as integer
declare function wxHtmlWinParser_GetFontFixed cdecl alias "wxHtmlWinParser_GetFontFixed" (byval self as integer) as integer
declare function wxHtmlWinParser_SetFontFixed cdecl alias "wxHtmlWinParser_SetFontFixed" (byval self as integer,byval x as integer) as integer
declare function wxHtmlWinParser_GetFontFace cdecl alias "wxHtmlWinParser_GetFontFace" (byval self as integer) as byte ptr
declare function wxHtmlWinParser_SetFontFace cdecl alias "wxHtmlWinParser_SetFontFace" (byval self as integer,byval face as string) as integer
declare function wxHtmlWinParser_GetAlign cdecl alias "wxHtmlWinParser_GetAlign" (byval self as integer) as integer
declare function wxHtmlWinParser_SetAlign cdecl alias "wxHtmlWinParser_SetAlign" (byval self as integer,byval a as integer) as integer
declare function wxHtmlWinParser_GetLinkColor cdecl alias "wxHtmlWinParser_GetLinkColor" (byval self as integer) as integer
declare function wxHtmlWinParser_SetLinkColor cdecl alias "wxHtmlWinParser_SetLinkColor" (byval self as integer,byval clr as integer) as integer
declare function wxHtmlWinParser_GetActualColor cdecl alias "wxHtmlWinParser_GetActualColor" (byval self as integer) as integer
declare function wxHtmlWinParser_SetActualColor cdecl alias "wxHtmlWinParser_SetActualColor" (byval self as integer,byval clr as integer) as integer
declare function wxHtmlWinParser_GetLink cdecl alias "wxHtmlWinParser_GetLink" (byval self as integer) as integer
declare function wxHtmlWinParser_SetLink cdecl alias "wxHtmlWinParser_SetLink" (byval self as integer,byval link as integer) as integer
declare function wxHtmlWinParser_CreateCurrentFont cdecl alias "wxHtmlWinParser_CreateCurrentFont" (byval self as integer) as integer
declare function wxHtmlTagHandler_SetParser cdecl alias "wxHtmlTagHandler_SetParser" (byval self as integer,byval parser as integer) as integer
declare function wxHtmlTagHandler_HandleTag cdecl alias "wxHtmlTagHandler_HandleTag" (byval self as integer,byval tag as integer) as integer
declare function wxHtmlEntitiesParser_ctor cdecl alias "wxHtmlEntitiesParser_ctor" () as integer
declare function wxHtmlEntitiesParser_dtor cdecl alias "wxHtmlEntitiesParser_dtor" (byval self as integer) as integer
declare function wxHtmlEntitiesParser_SetEncoding cdecl alias "wxHtmlEntitiesParser_SetEncoding" (byval self as integer,byval encoding as integer) as integer
declare function wxHtmlEntitiesParser_Parse cdecl alias "wxHtmlEntitiesParser_Parse" (byval self as integer,byval input as string) as byte ptr
declare function wxHtmlEntitiesParser_GetEntityChar cdecl alias "wxHtmlEntitiesParser_GetEntityChar" (byval self as integer,byval entity as string) as byte
declare function wxHtmlEntitiesParser_GetCharForCode cdecl alias "wxHtmlEntitiesParser_GetCharForCode" (byval self as integer,byval code as integer) as byte
declare function wxHtmlParser_SetFS cdecl alias "wxHtmlParser_SetFS" (byval self as integer,byval fs as integer) as integer
declare function wxHtmlParser_GetFS cdecl alias "wxHtmlParser_GetFS" (byval self as integer) as integer
declare function wxHtmlParser_OpenURL cdecl alias "wxHtmlParser_OpenURL" (byval self as integer,byval type as integer,byval url as string) as integer
declare function wxHtmlParser_Parse cdecl alias "wxHtmlParser_Parse" (byval self as integer,byval source as string) as integer
declare function wxHtmlParser_InitParser cdecl alias "wxHtmlParser_InitParser" (byval self as integer,byval source as string) as integer
declare function wxHtmlParser_DoneParser cdecl alias "wxHtmlParser_DoneParser" (byval self as integer) as integer
declare function wxHtmlParser_StopParsing cdecl alias "wxHtmlParser_StopParsing" (byval self as integer) as integer
declare function wxHtmlParser_DoParsing cdecl alias "wxHtmlParser_DoParsing" (byval self as integer,byval begin_pos as integer,byval end_pos as integer) as integer
declare function wxHtmlParser_DoParsingAll cdecl alias "wxHtmlParser_DoParsingAll" (byval self as integer) as integer
declare function wxHtmlParser_GetCurrentTag cdecl alias "wxHtmlParser_GetCurrentTag" (byval self as integer) as integer
declare function wxHtmlParser_GetProduct cdecl alias "wxHtmlParser_GetProduct" (byval self as integer) as integer
declare function wxHtmlParser_AddTagHandler cdecl alias "wxHtmlParser_AddTagHandler" (byval self as integer,byval handler as integer) as integer
declare function wxHtmlParser_PushTagHandler cdecl alias "wxHtmlParser_PushTagHandler" (byval self as integer,byval handler as integer,byval tags as string) as integer
declare function wxHtmlParser_PopTagHandler cdecl alias "wxHtmlParser_PopTagHandler" (byval self as integer) as integer
declare function wxHtmlParser_GetSource cdecl alias "wxHtmlParser_GetSource" (byval self as integer) as byte ptr
declare function wxHtmlParser_SetSource cdecl alias "wxHtmlParser_SetSource" (byval self as integer,byval src as string) as integer
declare function wxHtmlParser_SetSourceAndSaveState cdecl alias "wxHtmlParser_SetSourceAndSaveState" (byval self as integer,byval src as string) as integer
declare function wxHtmlParser_RestoreState cdecl alias "wxHtmlParser_RestoreState" (byval self as integer) as integer
declare function wxHtmlParser_ExtractCharsetInformation cdecl alias "wxHtmlParser_ExtractCharsetInformation" (byval self as integer,byval markup as string) as byte ptr
declare function wxHtmlProcessor_GetPriority cdecl alias "wxHtmlProcessor_GetPriority" (byval self as integer) as integer
declare function wxHtmlProcessor_Enable cdecl alias "wxHtmlProcessor_Enable" (byval self as integer,byval enable as integer) as integer
declare function wxHtmlProcessor_IsEnabled cdecl alias "wxHtmlProcessor_IsEnabled" (byval self as integer) as integer
declare function wxHtmlRenderingInfo_ctor cdecl alias "wxHtmlRenderingInfo_ctor" () as integer
declare function wxHtmlRenderingInfo_dtor cdecl alias "wxHtmlRenderingInfo_dtor" (byval self as integer) as integer
declare function wxHtmlRenderingInfo_SetSelection cdecl alias "wxHtmlRenderingInfo_SetSelection" (byval self as integer,byval s as integer) as integer
declare function wxHtmlRenderingInfo_GetSelection cdecl alias "wxHtmlRenderingInfo_GetSelection" (byval self as integer) as integer
declare function wxHtmlSelection_ctor cdecl alias "wxHtmlSelection_ctor" () as integer
declare function wxHtmlSelection_dtor cdecl alias "wxHtmlSelection_dtor" (byval self as integer) as integer
declare function wxHtmlSelection_Set cdecl alias "wxHtmlSelection_Set" (byval self as integer,byval fromPos as integer,byval fromCell as integer,byval toPos as integer,byval toCell as integer) as integer
declare function wxHtmlSelection_Set2 cdecl alias "wxHtmlSelection_Set2" (byval self as integer,byval fromCell as integer,byval toCell as integer) as integer
declare function wxHtmlSelection_GetFromCell cdecl alias "wxHtmlSelection_GetFromCell" (byval self as integer) as integer
declare function wxHtmlSelection_GetToCell cdecl alias "wxHtmlSelection_GetToCell" (byval self as integer) as integer
declare function wxHtmlSelection_GetFromPos cdecl alias "wxHtmlSelection_GetFromPos" (byval self as integer,byval fromPos as integer) as integer
declare function wxHtmlSelection_GetToPos cdecl alias "wxHtmlSelection_GetToPos" (byval self as integer,byval toPos as integer) as integer
declare function wxHtmlSelection_GetFromPrivPos cdecl alias "wxHtmlSelection_GetFromPrivPos" (byval self as integer,byval fromPrivPos as integer) as integer
declare function wxHtmlSelection_GetToPrivPos cdecl alias "wxHtmlSelection_GetToPrivPos" (byval self as integer,byval toPrivPos as integer) as integer
declare function wxHtmlSelection_SetFromPrivPos cdecl alias "wxHtmlSelection_SetFromPrivPos" (byval self as integer,byval pos as integer) as integer
declare function wxHtmlSelection_SetToPrivPos cdecl alias "wxHtmlSelection_SetToPrivPos" (byval self as integer,byval pos as integer) as integer
declare function wxHtmlSelection_ClearPrivPos cdecl alias "wxHtmlSelection_ClearPrivPos" (byval self as integer) as integer
declare function wxHtmlSelection_IsEmpty cdecl alias "wxHtmlSelection_IsEmpty" (byval self as integer) as integer
declare function wxHtmlEasyPrinting_ctor cdecl alias "wxHtmlEasyPrinting_ctor" (byval name as string,byval parent as integer) as integer
declare function wxHtmlEasyPrinting_PreviewFile cdecl alias "wxHtmlEasyPrinting_PreviewFile" (byval self as integer,byval htmlfile as string) as integer
declare function wxHtmlEasyPrinting_PreviewText cdecl alias "wxHtmlEasyPrinting_PreviewText" (byval self as integer,byval htmltext as string,byval basepath as string) as integer
declare function wxHtmlEasyPrinting_PrintFile cdecl alias "wxHtmlEasyPrinting_PrintFile" (byval self as integer,byval htmlfile as string) as integer
declare function wxHtmlEasyPrinting_PrintText cdecl alias "wxHtmlEasyPrinting_PrintText" (byval self as integer,byval htmltext as string,byval basepath as string) as integer
declare function wxHtmlEasyPrinting_PrinterSetup cdecl alias "wxHtmlEasyPrinting_PrinterSetup" (byval self as integer) as integer
declare function wxHtmlEasyPrinting_PageSetup cdecl alias "wxHtmlEasyPrinting_PageSetup" (byval self as integer) as integer
declare function wxHtmlEasyPrinting_SetHeader cdecl alias "wxHtmlEasyPrinting_SetHeader" (byval self as integer,byval header as string,byval pg as integer) as integer
declare function wxHtmlEasyPrinting_SetFooter cdecl alias "wxHtmlEasyPrinting_SetFooter" (byval self as integer,byval footer as string,byval pg as integer) as integer
declare function wxHtmlEasyPrinting_SetFonts cdecl alias "wxHtmlEasyPrinting_SetFonts" (byval self as integer,byval normal_face as string,byval fixed_face as string,byval sizes as integer) as integer
declare function wxHtmlEasyPrinting_SetStandardFonts cdecl alias "wxHtmlEasyPrinting_SetStandardFonts" (byval self as integer,byval size as integer,byval normal_face as string,byval fixed_face as string) as integer
declare function wxHtmlEasyPrinting_GetPrintData cdecl alias "wxHtmlEasyPrinting_GetPrintData" (byval self as integer) as integer
declare function wxHtmlEasyPrinting_GetPageSetupData cdecl alias "wxHtmlEasyPrinting_GetPageSetupData" (byval self as integer) as integer
declare function wxHtmlHelpController_ctor cdecl alias "wxHtmlHelpController_ctor" (byval style as integer) as integer
declare function wxHtmlHelpController_SetTitleFormat cdecl alias "wxHtmlHelpController_SetTitleFormat" (byval self as integer,byval format as string) as integer
declare function wxHtmlHelpController_SetTempDir cdecl alias "wxHtmlHelpController_SetTempDir" (byval self as integer,byval path as string) as integer
declare function wxHtmlHelpController_AddBook cdecl alias "wxHtmlHelpController_AddBook" (byval self as integer,byval book_url as string) as integer
declare function wxHtmlHelpController_Display cdecl alias "wxHtmlHelpController_Display" (byval self as integer,byval x as string) as integer
declare function wxHtmlHelpController_DisplayInt cdecl alias "wxHtmlHelpController_DisplayInt" (byval self as integer,byval id as integer) as integer
declare function wxHtmlHelpController_DisplayContents cdecl alias "wxHtmlHelpController_DisplayContents" (byval self as integer) as integer
declare function wxHtmlHelpController_DisplayIndex cdecl alias "wxHtmlHelpController_DisplayIndex" (byval self as integer) as integer
declare function wxHtmlHelpController_KeywordSearch cdecl alias "wxHtmlHelpController_KeywordSearch" (byval self as integer,byval keyword as string,byval mode as integer) as integer
declare function wxHtmlHelpController_UseConfig cdecl alias "wxHtmlHelpController_UseConfig" (byval self as integer,byval config as integer,byval rootpath as string) as integer
declare function wxHtmlHelpController_ReadCustomization cdecl alias "wxHtmlHelpController_ReadCustomization" (byval self as integer,byval cfg as integer,byval path as string) as integer
declare function wxHtmlHelpController_WriteCustomization cdecl alias "wxHtmlHelpController_WriteCustomization" (byval self as integer,byval cfg as integer,byval path as string) as integer
declare function wxHtmlHelpController_GetFrame cdecl alias "wxHtmlHelpController_GetFrame" (byval self as integer) as integer
declare function wxHtmlListBox_ctor2 cdecl alias "wxHtmlListBox_ctor2" (byval parent as integer,byval id as integer,byval pos as integer,byval size as integer,byval style as integer,byval name as string) as integer
declare function wxHtmlListBox_RegisterVirtual cdecl alias "wxHtmlListBox_RegisterVirtual" (byval self as integer,byval refreshAll as integer,byval setItemCount as integer,byval onGetItem as integer,byval onGetItemMarkup as integer,byval getSelectedTextColour as integer,byval getSelectedTextBgColour as integer,byval onDrawItem as integer,byval onMeasureItem as integer,byval onDrawSeparator as integer,byval onDrawBackground as integer,byval onGetLineHeight as integer) as integer
declare function wxHtmlListBox_Create cdecl alias "wxHtmlListBox_Create" (byval self as integer,byval parent as integer,byval id as integer,byval pos as integer,byval size as integer,byval style as integer,byval name as string) as integer
declare function wxHtmlListBox_RefreshAll cdecl alias "wxHtmlListBox_RefreshAll" (byval self as integer) as integer
declare function wxHtmlListBox_SetItemCount cdecl alias "wxHtmlListBox_SetItemCount" (byval self as integer,byval count as integer) as integer
declare function wxHtmlListBox_OnGetItemMarkup cdecl alias "wxHtmlListBox_OnGetItemMarkup" (byval self as integer,byval n as integer) as byte ptr
declare function wxHtmlListBox_GetSelectedTextColour cdecl alias "wxHtmlListBox_GetSelectedTextColour" (byval self as integer,byval colFg as integer) as integer
declare function wxHtmlListBox_GetSelectedTextBgColour cdecl alias "wxHtmlListBox_GetSelectedTextBgColour" (byval self as integer,byval colBg as integer) as integer
declare function wxHtmlListBox_OnDrawItem cdecl alias "wxHtmlListBox_OnDrawItem" (byval self as integer,byval dc as integer,byval rect as integer,byval n as integer) as integer
declare function wxHtmlListBox_OnMeasureItem cdecl alias "wxHtmlListBox_OnMeasureItem" (byval self as integer,byval n as integer) as integer
declare function wxHtmlListBox_OnSize cdecl alias "wxHtmlListBox_OnSize" (byval self as integer,byval event as integer) as integer
declare function wxHtmlListBox_Init cdecl alias "wxHtmlListBox_Init" (byval self as integer) as integer
declare function wxHtmlListBox_CacheItem cdecl alias "wxHtmlListBox_CacheItem" (byval self as integer,byval n as integer) as integer
declare function wxHtmlListBox_OnDrawSeparator cdecl alias "wxHtmlListBox_OnDrawSeparator" (byval self as integer,byval dc as integer,byval rect as integer,byval n as integer) as integer
declare function wxHtmlListBox_OnDrawBackground cdecl alias "wxHtmlListBox_OnDrawBackground" (byval self as integer,byval dc as integer,byval rect as integer,byval n as integer) as integer
declare function wxHtmlListBox_OnGetLineHeight cdecl alias "wxHtmlListBox_OnGetLineHeight" (byval self as integer,byval line as integer) as integer
declare function wxIcon_ctor cdecl alias "wxIcon_ctor" () as integer
declare function wxIcon_CopyFromBitmap cdecl alias "wxIcon_CopyFromBitmap" (byval self as integer,byval bitmap as integer) as integer
declare function wxIcon_LoadFile cdecl alias "wxIcon_LoadFile" (byval self as integer,byval name as string,byval type as integer) as integer
declare function wxIconizeEvent_ctor cdecl alias "wxIconizeEvent_ctor" (byval type as integer) as integer
declare function wxIconizeEvent_Iconized cdecl alias "wxIconizeEvent_Iconized" (byval self as integer) as integer
declare function wxIdleEvent_ctor cdecl alias "wxIdleEvent_ctor" () as integer
declare function wxIdleEvent_RequestMore cdecl alias "wxIdleEvent_RequestMore" (byval self as integer,byval needMore as integer) as integer
declare function wxIdleEvent_MoreRequested cdecl alias "wxIdleEvent_MoreRequested" (byval self as integer) as integer
declare function wxIdleEvent_SetMode cdecl alias "wxIdleEvent_SetMode" (byval mode as integer) as integer
declare function wxIdleEvent_GetMode cdecl alias "wxIdleEvent_GetMode" () as integer
declare function wxIdleEvent_CanSend cdecl alias "wxIdleEvent_CanSend" (byval win as integer) as integer
declare function wxImage_ctor cdecl alias "wxImage_ctor" () as integer
declare function wxImage_ctorByName cdecl alias "wxImage_ctorByName" (byval name as string,byval type as integer) as integer
declare function wxImage_ctorintintbool cdecl alias "wxImage_ctorintintbool" (byval width as integer,byval height as integer,byval clear as integer) as integer
declare function wxImage_ctorByImage cdecl alias "wxImage_ctorByImage" (byval image as integer) as integer
declare function wxImage_dtor cdecl alias "wxImage_dtor" (byval self as integer) as integer
declare function wxImage_Destroy cdecl alias "wxImage_Destroy" (byval self as integer) as integer
declare function wxImage_GetHeight cdecl alias "wxImage_GetHeight" (byval self as integer) as integer
declare function wxImage_GetWidth cdecl alias "wxImage_GetWidth" (byval self as integer) as integer
declare function wxImage_InitAllHandlers cdecl alias "wxImage_InitAllHandlers" () as integer
declare function wxImage_LoadFileByTypeId cdecl alias "wxImage_LoadFileByTypeId" (byval self as integer,byval name as string,byval type as integer,byval index as integer) as integer
declare function wxImage_LoadFileByMimeTypeId cdecl alias "wxImage_LoadFileByMimeTypeId" (byval self as integer,byval name as string,byval mimetype as string,byval index as integer) as integer
declare function wxImage_SaveFileByType cdecl alias "wxImage_SaveFileByType" (byval self as integer,byval name as string,byval type as integer) as integer
declare function wxImage_SaveFileByMimeType cdecl alias "wxImage_SaveFileByMimeType" (byval self as integer,byval name as string,byval mimetype as string) as integer
declare function wxImage_Rescale cdecl alias "wxImage_Rescale" (byval self as integer,byval width as integer,byval height as integer) as integer
declare function wxImage_Scale cdecl alias "wxImage_Scale" (byval self as integer,byval width as integer,byval height as integer) as integer
declare function wxImage_SetMaskColour cdecl alias "wxImage_SetMaskColour" (byval self as integer,byval r as ubyte,byval g as ubyte,byval b as ubyte) as integer
declare function wxImage_SetMask cdecl alias "wxImage_SetMask" (byval self as integer,byval mask as integer) as integer
declare function wxImage_HasMask cdecl alias "wxImage_HasMask" (byval self as integer) as integer
declare function wxImage_Copy cdecl alias "wxImage_Copy" (byval self as integer) as integer
declare function wxImage_GetSubImage cdecl alias "wxImage_GetSubImage" (byval self as integer,byval rect as integer) as integer
declare function wxImage_Paste cdecl alias "wxImage_Paste" (byval self as integer,byval image as integer,byval x as integer,byval y as integer) as integer
declare function wxImage_ShrinkBy cdecl alias "wxImage_ShrinkBy" (byval self as integer,byval xFactor as integer,byval yFactor as integer) as integer
declare function wxImage_Rotate cdecl alias "wxImage_Rotate" (byval self as integer,byval angle as integer,byval centre_of_rotation as integer,byval interpolating as integer,byval offset_after_rotation as integer) as integer
declare function wxImage_Rotate90 cdecl alias "wxImage_Rotate90" (byval self as integer,byval clockwise as integer) as integer
declare function wxImage_Mirror cdecl alias "wxImage_Mirror" (byval self as integer,byval horizontally as integer) as integer
declare function wxImage_Replace cdecl alias "wxImage_Replace" (byval self as integer,byval r1 as ubyte,byval g1 as ubyte,byval b1 as ubyte,byval r2 as ubyte,byval g2 as ubyte,byval b2 as ubyte) as integer
declare function wxImage_ConvertToMono cdecl alias "wxImage_ConvertToMono" (byval self as integer,byval r as ubyte,byval g as ubyte,byval b as ubyte) as integer
declare function wxImage_SetRGB cdecl alias "wxImage_SetRGB" (byval self as integer,byval x as integer,byval y as integer,byval r as ubyte,byval g as ubyte,byval b as ubyte) as integer
declare function wxImage_GetRed cdecl alias "wxImage_GetRed" (byval self as integer,byval x as integer,byval y as integer) as ubyte
declare function wxImage_GetGreen cdecl alias "wxImage_GetGreen" (byval self as integer,byval x as integer,byval y as integer) as ubyte
declare function wxImage_GetBlue cdecl alias "wxImage_GetBlue" (byval self as integer,byval x as integer,byval y as integer) as ubyte
declare function wxImage_SetAlpha cdecl alias "wxImage_SetAlpha" (byval self as integer,byval x as integer,byval y as integer,byval alpha as ubyte) as integer
declare function wxImage_GetAlpha cdecl alias "wxImage_GetAlpha" (byval self as integer,byval x as integer,byval y as integer) as ubyte
declare function wxImage_FindFirstUnusedColour cdecl alias "wxImage_FindFirstUnusedColour" (byval self as integer,byval r as integer,byval g as integer,byval b as integer,byval startR as ubyte,byval startG as ubyte,byval startB as ubyte) as integer
declare function wxImage_SetMaskFromImage cdecl alias "wxImage_SetMaskFromImage" (byval self as integer,byval mask as integer,byval mr as ubyte,byval mg as ubyte,byval mb as ubyte) as integer
declare function wxImage_ConvertAlphaToMask cdecl alias "wxImage_ConvertAlphaToMask" (byval self as integer,byval threshold as ubyte) as integer
declare function wxImage_CanRead cdecl alias "wxImage_CanRead" (byval name as string) as integer
declare function wxImage_GetImageCount cdecl alias "wxImage_GetImageCount" (byval name as string,byval type as integer) as integer
declare function wxImage_Ok cdecl alias "wxImage_Ok" (byval self as integer) as integer
declare function wxImage_GetMaskRed cdecl alias "wxImage_GetMaskRed" (byval self as integer) as ubyte
declare function wxImage_GetMaskGreen cdecl alias "wxImage_GetMaskGreen" (byval self as integer) as ubyte
declare function wxImage_GetMaskBlue cdecl alias "wxImage_GetMaskBlue" (byval self as integer) as ubyte
declare function wxImage_HasPalette cdecl alias "wxImage_HasPalette" (byval self as integer) as integer
declare function wxImage_GetPalette cdecl alias "wxImage_GetPalette" (byval self as integer) as integer
declare function wxImage_SetPalette cdecl alias "wxImage_SetPalette" (byval self as integer,byval palette as integer) as integer
declare function wxImage_SetOption cdecl alias "wxImage_SetOption" (byval self as integer,byval name as string,byval value as string) as integer
declare function wxImage_SetOption2 cdecl alias "wxImage_SetOption2" (byval self as integer,byval name as string,byval value as integer) as integer
declare function wxImage_GetOption cdecl alias "wxImage_GetOption" (byval self as integer,byval name as string) as byte ptr
declare function wxImage_GetOptionInt cdecl alias "wxImage_GetOptionInt" (byval self as integer,byval name as string) as integer
declare function wxImage_HasOption cdecl alias "wxImage_HasOption" (byval self as integer,byval name as string) as integer
declare function wxImage_CountColours cdecl alias "wxImage_CountColours" (byval self as integer,byval stopafter as unsigned long) as unsigned long
declare function wxImage_ComputeHistogram cdecl alias "wxImage_ComputeHistogram" (byval self as integer,byval h as integer) as unsigned long
declare function wxImage_GetHandlers cdecl alias "wxImage_GetHandlers" () as integer
declare function wxImage_AddHandler cdecl alias "wxImage_AddHandler" (byval handler as integer) as integer
declare function wxImage_InsertHandler cdecl alias "wxImage_InsertHandler" (byval handler as integer) as integer
declare function wxImage_RemoveHandler cdecl alias "wxImage_RemoveHandler" (byval name as string) as integer
declare function wxImage_FindHandler cdecl alias "wxImage_FindHandler" (byval name as string) as integer
declare function wxImage_FindHandler2 cdecl alias "wxImage_FindHandler2" (byval name as string,byval imageType as long) as integer
declare function wxImage_FindHandler3 cdecl alias "wxImage_FindHandler3" (byval imageType as long) as integer
declare function wxImage_FindHandlerMime cdecl alias "wxImage_FindHandlerMime" (byval mimetype as string) as integer
declare function wxImage_GetImageExtWildcard cdecl alias "wxImage_GetImageExtWildcard" () as byte ptr
declare function wxImage_CleanUpHandlers cdecl alias "wxImage_CleanUpHandlers" () as integer
declare function wxImage_InitStandardHandlers cdecl alias "wxImage_InitStandardHandlers" () as integer
declare function wxImageHandler_SetName cdecl alias "wxImageHandler_SetName" (byval self as integer,byval name as string) as integer
declare function wxImageHandler_SetExtension cdecl alias "wxImageHandler_SetExtension" (byval self as integer,byval ext as string) as integer
declare function wxImageHandler_SetType cdecl alias "wxImageHandler_SetType" (byval self as integer,byval type as long) as integer
declare function wxImageHandler_SetMimeType cdecl alias "wxImageHandler_SetMimeType" (byval self as integer,byval type as string) as integer
declare function wxImageHandler_GetName cdecl alias "wxImageHandler_GetName" (byval self as integer) as byte ptr
declare function wxImageHandler_GetExtension cdecl alias "wxImageHandler_GetExtension" (byval self as integer) as byte ptr
declare function wxImageHandler_GetType cdecl alias "wxImageHandler_GetType" (byval self as integer) as long
declare function wxImageHandler_GetMimeType cdecl alias "wxImageHandler_GetMimeType" (byval self as integer) as byte ptr
declare function wxImageHistogramEntry_ctor cdecl alias "wxImageHistogramEntry_ctor" () as integer
declare function wxImageHistogramEntry_dtor cdecl alias "wxImageHistogramEntry_dtor" (byval self as integer) as integer
declare function wxImageHistogramEntry_index cdecl alias "wxImageHistogramEntry_index" (byval self as integer) as unsigned long
declare function wxImageHistogramEntry_Setindex cdecl alias "wxImageHistogramEntry_Setindex" (byval self as integer,byval v as unsigned long) as integer
declare function wxImageHistogramEntry_value cdecl alias "wxImageHistogramEntry_value" (byval self as integer) as unsigned long
declare function wxImageHistogramEntry_Setvalue cdecl alias "wxImageHistogramEntry_Setvalue" (byval self as integer,byval v as unsigned long) as integer
declare function wxImageHistogram_ctor cdecl alias "wxImageHistogram_ctor" () as integer
declare function wxImageHistogram_dtor cdecl alias "wxImageHistogram_dtor" (byval self as integer) as integer
declare function wxImageHistogram_MakeKey cdecl alias "wxImageHistogram_MakeKey" (byval r as ubyte,byval g as ubyte,byval b as ubyte) as unsigned long
declare function wxImageHistogram_FindFirstUnusedColour cdecl alias "wxImageHistogram_FindFirstUnusedColour" (byval self as integer,byval r as integer,byval g as integer,byval b as integer,byval startR as ubyte,byval startG as ubyte,byval startB as ubyte) as integer
declare function wxImageList_ctor cdecl alias "wxImageList_ctor" (byval width as integer,byval height as integer,byval mask as integer,byval initialCount as integer) as integer
declare function wxImageList_ctor2 cdecl alias "wxImageList_ctor2" () as integer
declare function wxImageList_AddBitmap1 cdecl alias "wxImageList_AddBitmap1" (byval self as integer,byval bmp as integer,byval mask as integer) as integer
declare function wxImageList_AddBitmap cdecl alias "wxImageList_AddBitmap" (byval self as integer,byval bmp as integer,byval maskColour as integer) as integer
declare function wxImageList_AddIcon cdecl alias "wxImageList_AddIcon" (byval self as integer,byval icon as integer) as integer
declare function wxImageList_GetImageCount cdecl alias "wxImageList_GetImageCount" (byval self as integer) as integer
declare function wxImageList_Draw cdecl alias "wxImageList_Draw" (byval self as integer,byval index as integer,byval dc as integer,byval x as integer,byval y as integer,byval flags as integer,byval solidBackground as integer) as integer
declare function wxImageList_Create cdecl alias "wxImageList_Create" (byval self as integer,byval width as integer,byval height as integer,byval mask as integer,byval initialCount as integer) as integer
declare function wxImageList_Replace cdecl alias "wxImageList_Replace" (byval self as integer,byval index as integer,byval bitmap as integer) as integer
declare function wxImageList_Remove cdecl alias "wxImageList_Remove" (byval self as integer,byval index as integer) as integer
declare function wxImageList_RemoveAll cdecl alias "wxImageList_RemoveAll" (byval self as integer) as integer
declare function wxImageList_GetSize cdecl alias "wxImageList_GetSize" (byval self as integer,byval index as integer,byval width as integer,byval height as integer) as integer
declare function CSharp_new_BMPHandler cdecl alias "CSharp_new_BMPHandler" () as integer
declare function CSharp_new_ICOHandler cdecl alias "CSharp_new_ICOHandler" () as integer
declare function CSharp_new_CURHandler cdecl alias "CSharp_new_CURHandler" () as integer
declare function CSharp_new_ANIHandler cdecl alias "CSharp_new_ANIHandler" () as integer
declare function CSharp_new_PNGHandler cdecl alias "CSharp_new_PNGHandler" () as integer
declare function CSharp_new_GIFHandler cdecl alias "CSharp_new_GIFHandler" () as integer
declare function CSharp_new_PCXHandler cdecl alias "CSharp_new_PCXHandler" () as integer
declare function CSharp_new_JPEGHandler cdecl alias "CSharp_new_JPEGHandler" () as integer
declare function CSharp_new_PNMHandler cdecl alias "CSharp_new_PNMHandler" () as integer
declare function CSharp_new_XPMHandler cdecl alias "CSharp_new_XPMHandler" () as integer
declare function CSharp_new_TIFFHandler cdecl alias "CSharp_new_TIFFHandler" () as integer
declare function wxInitDialogEvent_ctor cdecl alias "wxInitDialogEvent_ctor" (byval Id as integer) as integer
declare function wxKeyEvent_ctor cdecl alias "wxKeyEvent_ctor" (byval type as integer) as integer
declare function wxKeyEvent_ControlDown cdecl alias "wxKeyEvent_ControlDown" (byval self as integer) as integer
declare function wxKeyEvent_ShiftDown cdecl alias "wxKeyEvent_ShiftDown" (byval self as integer) as integer
declare function wxKeyEvent_AltDown cdecl alias "wxKeyEvent_AltDown" (byval self as integer) as integer
declare function wxKeyEvent_MetaDown cdecl alias "wxKeyEvent_MetaDown" (byval self as integer) as integer
declare function wxKeyEvent_GetRawKeyCode cdecl alias "wxKeyEvent_GetRawKeyCode" (byval self as integer) as integer
declare function wxKeyEvent_GetKeyCode cdecl alias "wxKeyEvent_GetKeyCode" (byval self as integer) as integer
declare function wxKeyEvent_GetRawKeyFlags cdecl alias "wxKeyEvent_GetRawKeyFlags" (byval self as integer) as integer
declare function wxKeyEvent_HasModifiers cdecl alias "wxKeyEvent_HasModifiers" (byval self as integer) as integer
declare function wxKeyEvent_GetPosition cdecl alias "wxKeyEvent_GetPosition" (byval self as integer,byval pt as integer) as integer
declare function wxKeyEvent_GetX cdecl alias "wxKeyEvent_GetX" (byval self as integer) as integer
declare function wxKeyEvent_GetY cdecl alias "wxKeyEvent_GetY" (byval self as integer) as integer
declare function wxKeyEvent_CmdDown cdecl alias "wxKeyEvent_CmdDown" (byval self as integer) as integer
declare function wxSashLayoutWindow_ctor cdecl alias "wxSashLayoutWindow_ctor" () as integer
declare function wxSashLayoutWindow_Create cdecl alias "wxSashLayoutWindow_Create" (byval self as integer,byval parent as integer,byval id as integer,byval pos as integer,byval size as integer,byval style as long,byval name as string) as integer
declare function wxSashLayoutWindow_GetAlignment cdecl alias "wxSashLayoutWindow_GetAlignment" (byval self as integer) as integer
declare function wxSashLayoutWindow_SetAlignment cdecl alias "wxSashLayoutWindow_SetAlignment" (byval self as integer,byval align as integer) as integer
declare function wxSashLayoutWindow_GetOrientation cdecl alias "wxSashLayoutWindow_GetOrientation" (byval self as integer) as integer
declare function wxSashLayoutWindow_SetOrientation cdecl alias "wxSashLayoutWindow_SetOrientation" (byval self as integer,byval orient as integer) as integer
declare function wxSashLayoutWindow_SetDefaultSize cdecl alias "wxSashLayoutWindow_SetDefaultSize" (byval self as integer,byval size as integer) as integer
declare function wxLayoutAlgorithm_ctor cdecl alias "wxLayoutAlgorithm_ctor" () as integer
declare function wxLayoutAlgorithm_LayoutMDIFrame cdecl alias "wxLayoutAlgorithm_LayoutMDIFrame" (byval self as integer,byval frame as integer,byval rect as integer) as integer
declare function wxLayoutAlgorithm_LayoutFrame cdecl alias "wxLayoutAlgorithm_LayoutFrame" (byval self as integer,byval frame as integer,byval mainWindow as integer) as integer
declare function wxLayoutAlgorithm_LayoutWindow cdecl alias "wxLayoutAlgorithm_LayoutWindow" (byval self as integer,byval frame as integer,byval mainWindow as integer) as integer
declare function wxQueryLayoutInfoEvent_ctor cdecl alias "wxQueryLayoutInfoEvent_ctor" (byval id as integer) as integer
declare function wxQueryLayoutInfoEvent_SetRequestedLength cdecl alias "wxQueryLayoutInfoEvent_SetRequestedLength" (byval self as integer,byval length as integer) as integer
declare function wxQueryLayoutInfoEvent_GetRequestedLength cdecl alias "wxQueryLayoutInfoEvent_GetRequestedLength" (byval self as integer) as integer
declare function wxQueryLayoutInfoEvent_SetFlags cdecl alias "wxQueryLayoutInfoEvent_SetFlags" (byval self as integer,byval flags as integer) as integer
declare function wxQueryLayoutInfoEvent_GetFlags cdecl alias "wxQueryLayoutInfoEvent_GetFlags" (byval self as integer) as integer
declare function wxQueryLayoutInfoEvent_SetSize cdecl alias "wxQueryLayoutInfoEvent_SetSize" (byval self as integer,byval size as integer) as integer
declare function wxQueryLayoutInfoEvent_GetSize cdecl alias "wxQueryLayoutInfoEvent_GetSize" (byval self as integer,byval size as integer) as integer
declare function wxQueryLayoutInfoEvent_SetOrientation cdecl alias "wxQueryLayoutInfoEvent_SetOrientation" (byval self as integer,byval orient as integer) as integer
declare function wxQueryLayoutInfoEvent_GetOrientation cdecl alias "wxQueryLayoutInfoEvent_GetOrientation" (byval self as integer) as integer
declare function wxQueryLayoutInfoEvent_SetAlignment cdecl alias "wxQueryLayoutInfoEvent_SetAlignment" (byval self as integer,byval align as integer) as integer
declare function wxQueryLayoutInfoEvent_GetAlignment cdecl alias "wxQueryLayoutInfoEvent_GetAlignment" (byval self as integer) as integer
declare function wxCalculateLayoutEvent_ctor cdecl alias "wxCalculateLayoutEvent_ctor" (byval id as integer) as integer
declare function wxCalculateLayoutEvent_SetFlags cdecl alias "wxCalculateLayoutEvent_SetFlags" (byval self as integer,byval flags as integer) as integer
declare function wxCalculateLayoutEvent_GetFlags cdecl alias "wxCalculateLayoutEvent_GetFlags" (byval self as integer) as integer
declare function wxCalculateLayoutEvent_SetRect cdecl alias "wxCalculateLayoutEvent_SetRect" (byval self as integer,byval rect as integer) as integer
declare function wxCalculateLayoutEvent_GetRect cdecl alias "wxCalculateLayoutEvent_GetRect" (byval self as integer,byval rect as integer) as integer
declare function wxListbook_ctor cdecl alias "wxListbook_ctor" () as integer
declare function wxListbook_Create cdecl alias "wxListbook_Create" (byval self as integer,byval parent as integer,byval id as integer,byval pos as integer,byval size as integer,byval style as long,byval name as string) as integer
declare function wxListbook_GetSelection cdecl alias "wxListbook_GetSelection" (byval self as integer) as integer
declare function wxListbook_SetPageText cdecl alias "wxListbook_SetPageText" (byval self as integer,byval n as integer,byval strText as string) as integer
declare function wxListbook_GetPageText cdecl alias "wxListbook_GetPageText" (byval self as integer,byval n as integer) as byte ptr
declare function wxListbook_GetPageImage cdecl alias "wxListbook_GetPageImage" (byval self as integer,byval n as integer) as integer
declare function wxListbook_SetPageImage cdecl alias "wxListbook_SetPageImage" (byval self as integer,byval n as integer,byval imageId as integer) as integer
declare function wxListbook_CalcSizeFromPage cdecl alias "wxListbook_CalcSizeFromPage" (byval self as integer,byval sizePage as integer,byval outSize as integer) as integer
declare function wxListbook_InsertPage cdecl alias "wxListbook_InsertPage" (byval self as integer,byval n as integer,byval page as integer,byval text as string,byval bSelect as integer,byval imageId as integer) as integer
declare function wxListbook_SetSelection cdecl alias "wxListbook_SetSelection" (byval self as integer,byval n as integer) as integer
declare function wxListbook_SetImageList cdecl alias "wxListbook_SetImageList" (byval self as integer,byval imageList as integer) as integer
declare function wxListbook_IsVertical cdecl alias "wxListbook_IsVertical" (byval self as integer) as integer
declare function wxListbook_GetPageCount cdecl alias "wxListbook_GetPageCount" (byval self as integer) as integer
declare function wxListbook_GetPage cdecl alias "wxListbook_GetPage" (byval self as integer,byval n as integer) as integer
declare function wxListbook_AssignImageList cdecl alias "wxListbook_AssignImageList" (byval self as integer,byval imageList as integer) as integer
declare function wxListbook_GetImageList cdecl alias "wxListbook_GetImageList" (byval self as integer) as integer
declare function wxListbook_SetPageSize cdecl alias "wxListbook_SetPageSize" (byval self as integer,byval size as integer) as integer
declare function wxListbook_DeletePage cdecl alias "wxListbook_DeletePage" (byval self as integer,byval nPage as integer) as integer
declare function wxListbook_RemovePage cdecl alias "wxListbook_RemovePage" (byval self as integer,byval nPage as integer) as integer
declare function wxListbook_DeleteAllPages cdecl alias "wxListbook_DeleteAllPages" (byval self as integer) as integer
declare function wxListbook_AddPage cdecl alias "wxListbook_AddPage" (byval self as integer,byval page as integer,byval text as string,byval bselect as integer,byval imageId as integer) as integer
declare function wxListbook_AdvanceSelection cdecl alias "wxListbook_AdvanceSelection" (byval self as integer,byval forward as integer) as integer
declare function wxListbookEvent_ctor cdecl alias "wxListbookEvent_ctor" (byval commandType as integer,byval id as integer,byval nSel as integer,byval nOldSel as integer) as integer
declare function wxListbookEvent_GetSelection cdecl alias "wxListbookEvent_GetSelection" (byval self as integer) as integer
declare function wxListbookEvent_SetSelection cdecl alias "wxListbookEvent_SetSelection" (byval self as integer,byval nSel as integer) as integer
declare function wxListbookEvent_GetOldSelection cdecl alias "wxListbookEvent_GetOldSelection" (byval self as integer) as integer
declare function wxListbookEvent_SetOldSelection cdecl alias "wxListbookEvent_SetOldSelection" (byval self as integer,byval nOldSel as integer) as integer
declare function wxListbookEvent_Veto cdecl alias "wxListbookEvent_Veto" (byval self as integer) as integer
declare function wxListbookEvent_Allow cdecl alias "wxListbookEvent_Allow" (byval self as integer) as integer
declare function wxListbookEvent_IsAllowed cdecl alias "wxListbookEvent_IsAllowed" (byval self as integer) as integer
declare function wxListBox_ctor cdecl alias "wxListBox_ctor" () as integer
declare function wxListBox_dtor cdecl alias "wxListBox_dtor" (byval self as integer) as integer
declare function wxListBox_Create cdecl alias "wxListBox_Create" (byval self as integer,byval parent as integer,byval id as integer,byval pos as integer,byval size as integer,byval n as integer,byval items as byte ptr ptr,byval style as long,byval validator as integer,byval name as string) as integer
declare function wxListBox_Clear cdecl alias "wxListBox_Clear" (byval self as integer) as integer
declare function wxListBox_Delete cdecl alias "wxListBox_Delete" (byval self as integer,byval n as integer) as integer
declare function wxListBox_GetCount cdecl alias "wxListBox_GetCount" (byval self as integer) as integer
declare function wxListBox_GetSingleString cdecl alias "wxListBox_GetSingleString" (byval self as integer,byval n as integer) as byte ptr
declare function wxListBox_SetSingleString cdecl alias "wxListBox_SetSingleString" (byval self as integer,byval n as integer,byval s as string) as integer
declare function wxListBox_FindString cdecl alias "wxListBox_FindString" (byval self as integer,byval s as string) as integer
declare function wxListBox_SetSelection cdecl alias "wxListBox_SetSelection" (byval self as integer,byval n as integer,byval select as integer) as integer
declare function wxListBox_GetSelection cdecl alias "wxListBox_GetSelection" (byval self as integer) as integer
declare function wxListBox_GetSelections cdecl alias "wxListBox_GetSelections" (byval self as integer) as integer
declare function wxListBox_InsertText cdecl alias "wxListBox_InsertText" (byval self as integer,byval item as string,byval pos as integer) as integer
declare function wxListBox_InsertTextData cdecl alias "wxListBox_InsertTextData" (byval self as integer,byval item as string,byval pos as integer,byval clientData as integer) as integer
declare function wxListBox_InsertTextClientData cdecl alias "wxListBox_InsertTextClientData" (byval self as integer,byval item as string,byval pos as integer,byval clientData as integer) as integer
declare function wxListBox_InsertItems cdecl alias "wxListBox_InsertItems" (byval self as integer,byval nItems as integer,byval items as byte ptr ptr,byval pos as integer) as integer
declare function wxListBox_Set cdecl alias "wxListBox_Set" (byval self as integer,byval n as integer,byval items as byte ptr ptr,byval clientData as integer) as integer
declare function wxListBox_Select cdecl alias "wxListBox_Select" (byval self as integer,byval n as integer) as integer
declare function wxListBox_Deselect cdecl alias "wxListBox_Deselect" (byval self as integer,byval n as integer) as integer
declare function wxListBox_DeselectAll cdecl alias "wxListBox_DeselectAll" (byval self as integer,byval itemToLeaveSelected as integer) as integer
declare function wxListBox_SetStringSelection cdecl alias "wxListBox_SetStringSelection" (byval self as integer,byval s as string,byval select as integer) as integer
declare function wxListBox_SetFirstItem cdecl alias "wxListBox_SetFirstItem" (byval self as integer,byval n as integer) as integer
declare function wxListBox_SetFirstItemText cdecl alias "wxListBox_SetFirstItemText" (byval self as integer,byval s as string) as integer
declare function wxListBox_HasMultipleSelection cdecl alias "wxListBox_HasMultipleSelection" (byval self as integer) as integer
declare function wxListBox_IsSorted cdecl alias "wxListBox_IsSorted" (byval self as integer) as integer
declare function wxListBox_Command cdecl alias "wxListBox_Command" (byval self as integer,byval event as integer) as integer
declare function wxListBox_Selected cdecl alias "wxListBox_Selected" (byval self as integer,byval n as integer) as integer
declare function wxListBox_GetStringSelection cdecl alias "wxListBox_GetStringSelection" (byval self as integer) as byte ptr
declare function wxListBox_Append cdecl alias "wxListBox_Append" (byval self as integer,byval item as string) as integer
declare function wxListBox_AppendClientData cdecl alias "wxListBox_AppendClientData" (byval self as integer,byval item as string,byval clientData as integer) as integer
declare function wxCheckListBox_ctor1 cdecl alias "wxCheckListBox_ctor1" () as integer
declare function wxCheckListBox_ctor2 cdecl alias "wxCheckListBox_ctor2" (byval parent as integer,byval id as integer,byval pos as integer,byval size as integer,byval nStrings as integer,byval choices as byte ptr ptr,byval style as long,byval validator as integer,byval name as string) as integer
declare function wxCheckListBox_IsChecked cdecl alias "wxCheckListBox_IsChecked" (byval self as integer,byval index as integer) as integer
declare function wxCheckListBox_Check cdecl alias "wxCheckListBox_Check" (byval self as integer,byval index as integer,byval check as integer) as integer
declare function wxListCtrl_ctor cdecl alias "wxListCtrl_ctor" () as integer
declare function wxListCtrl_Create cdecl alias "wxListCtrl_Create" (byval self as integer,byval parent as integer,byval id as integer,byval pos as integer,byval size as integer,byval style as integer,byval validator as integer,byval name as string) as integer
declare function wxListCtrl_dtor cdecl alias "wxListCtrl_dtor" (byval self as integer) as integer
declare function wxListCtrl_GetColumn cdecl alias "wxListCtrl_GetColumn" (byval self as integer,byval col as integer,byval item as integer) as integer
declare function wxListCtrl_SetColumn cdecl alias "wxListCtrl_SetColumn" (byval self as integer,byval col as integer,byval item as integer) as integer
declare function wxListCtrl_GetColumnWidth cdecl alias "wxListCtrl_GetColumnWidth" (byval self as integer,byval col as integer) as integer
declare function wxListCtrl_SetColumnWidth cdecl alias "wxListCtrl_SetColumnWidth" (byval self as integer,byval col as integer,byval width as integer) as integer
declare function wxListCtrl_GetCountPerPage cdecl alias "wxListCtrl_GetCountPerPage" (byval self as integer) as integer
declare function wxListCtrl_GetItem cdecl alias "wxListCtrl_GetItem" (byval self as integer,byval info as integer,byval retval as integer) as integer
declare function wxListCtrl_SetItem cdecl alias "wxListCtrl_SetItem" (byval self as integer,byval info as integer) as integer
declare function wxListCtrl_SetItem_By_Row_Col cdecl alias "wxListCtrl_SetItem_By_Row_Col" (byval self as integer,byval index as integer,byval col as integer,byval label as string,byval imageId as integer) as integer
declare function wxListCtrl_SetTextImageItem cdecl alias "wxListCtrl_SetTextImageItem" (byval self as integer,byval index as integer,byval col as integer,byval label as string,byval imageId as integer) as integer
declare function wxListCtrl_GetItemState cdecl alias "wxListCtrl_GetItemState" (byval self as integer,byval item as integer,byval stateMask as integer) as integer
declare function wxListCtrl_SetItemState cdecl alias "wxListCtrl_SetItemState" (byval self as integer,byval item as integer,byval state as integer,byval stateMask as integer) as integer
declare function wxListCtrl_SetItemImage cdecl alias "wxListCtrl_SetItemImage" (byval self as integer,byval item as integer,byval image as integer,byval selImage as integer) as integer
declare function wxListCtrl_GetItemText cdecl alias "wxListCtrl_GetItemText" (byval self as integer,byval item as integer) as byte ptr
declare function wxListCtrl_SetItemText cdecl alias "wxListCtrl_SetItemText" (byval self as integer,byval item as integer,byval str as string) as integer
declare function wxListCtrl_GetItemData cdecl alias "wxListCtrl_GetItemData" (byval self as integer,byval item as integer) as integer
declare function wxListCtrl_SetItemData cdecl alias "wxListCtrl_SetItemData" (byval self as integer,byval item as integer,byval data as integer) as integer
declare function wxListCtrl_SetItemData2 cdecl alias "wxListCtrl_SetItemData2" (byval self as integer,byval item as integer,byval data as integer) as integer
declare function wxListCtrl_GetItemRect cdecl alias "wxListCtrl_GetItemRect" (byval self as integer,byval item as integer,byval rect as integer,byval code as integer) as integer
declare function wxListCtrl_GetItemPosition cdecl alias "wxListCtrl_GetItemPosition" (byval self as integer,byval item as integer,byval pos as integer) as integer
declare function wxListCtrl_SetItemPosition cdecl alias "wxListCtrl_SetItemPosition" (byval self as integer,byval item as integer,byval pos as integer) as integer
declare function wxListCtrl_GetItemCount cdecl alias "wxListCtrl_GetItemCount" (byval self as integer) as integer
declare function wxListCtrl_GetColumnCount cdecl alias "wxListCtrl_GetColumnCount" (byval self as integer) as integer
declare function wxListCtrl_SetItemTextColour cdecl alias "wxListCtrl_SetItemTextColour" (byval self as integer,byval item as integer,byval col as integer) as integer
declare function wxListCtrl_GetItemTextColour cdecl alias "wxListCtrl_GetItemTextColour" (byval self as integer,byval item as integer) as integer
declare function wxListCtrl_SetItemBackgroundColour cdecl alias "wxListCtrl_SetItemBackgroundColour" (byval self as integer,byval item as integer,byval col as integer) as integer
declare function wxListCtrl_GetItemBackgroundColour cdecl alias "wxListCtrl_GetItemBackgroundColour" (byval self as integer,byval item as integer) as integer
declare function wxListCtrl_GetSelectedItemCount cdecl alias "wxListCtrl_GetSelectedItemCount" (byval self as integer) as integer
declare function wxListCtrl_GetTextColour cdecl alias "wxListCtrl_GetTextColour" (byval self as integer) as integer
declare function wxListCtrl_SetTextColour cdecl alias "wxListCtrl_SetTextColour" (byval self as integer,byval col as integer) as integer
declare function wxListCtrl_GetTopItem cdecl alias "wxListCtrl_GetTopItem" (byval self as integer) as integer
declare function wxListCtrl_SetSingleStyle cdecl alias "wxListCtrl_SetSingleStyle" (byval self as integer,byval style as integer,byval add as integer) as integer
declare function wxListCtrl_SetWindowStyleFlag cdecl alias "wxListCtrl_SetWindowStyleFlag" (byval self as integer,byval style as integer) as integer
declare function wxListCtrl_GetNextItem cdecl alias "wxListCtrl_GetNextItem" (byval self as integer,byval item as integer,byval geometry as integer,byval state as integer) as integer
declare function wxListCtrl_GetImageList cdecl alias "wxListCtrl_GetImageList" (byval self as integer,byval which as integer) as integer
declare function wxListCtrl_SetImageList cdecl alias "wxListCtrl_SetImageList" (byval self as integer,byval imageList as integer,byval which as integer) as integer
declare function wxListCtrl_AssignImageList cdecl alias "wxListCtrl_AssignImageList" (byval self as integer,byval imageList as integer,byval which as integer) as integer
declare function wxListCtrl_Arrange cdecl alias "wxListCtrl_Arrange" (byval self as integer,byval flag as integer) as integer
declare function wxListCtrl_ClearAll cdecl alias "wxListCtrl_ClearAll" (byval self as integer) as integer
declare function wxListCtrl_DeleteItem cdecl alias "wxListCtrl_DeleteItem" (byval self as integer,byval item as integer) as integer
declare function wxListCtrl_DeleteAllItems cdecl alias "wxListCtrl_DeleteAllItems" (byval self as integer) as integer
declare function wxListCtrl_DeleteAllColumns cdecl alias "wxListCtrl_DeleteAllColumns" (byval self as integer) as integer
declare function wxListCtrl_DeleteColumn cdecl alias "wxListCtrl_DeleteColumn" (byval self as integer,byval col as integer) as integer
declare function wxListCtrl_SetItemCount cdecl alias "wxListCtrl_SetItemCount" (byval self as integer,byval count as integer) as integer
declare function wxListCtrl_EditLabel cdecl alias "wxListCtrl_EditLabel" (byval self as integer,byval item as integer) as integer
declare function wxListCtrl_EnsureVisible cdecl alias "wxListCtrl_EnsureVisible" (byval self as integer,byval item as integer) as integer
declare function wxListCtrl_FindItem cdecl alias "wxListCtrl_FindItem" (byval self as integer,byval start as integer,byval str as string,byval partial as integer) as integer
declare function wxListCtrl_FindItemData cdecl alias "wxListCtrl_FindItemData" (byval self as integer,byval start as integer,byval data as integer) as integer
declare function wxListCtrl_FindItemPoint cdecl alias "wxListCtrl_FindItemPoint" (byval self as integer,byval start as integer,byval pt as integer,byval direction as integer) as integer
declare function wxListCtrl_HitTest cdecl alias "wxListCtrl_HitTest" (byval self as integer,byval point as integer,byval flags as integer) as integer
declare function wxListCtrl_InsertItem cdecl alias "wxListCtrl_InsertItem" (byval self as integer,byval info as integer) as integer
declare function wxListCtrl_InsertTextItem cdecl alias "wxListCtrl_InsertTextItem" (byval self as integer,byval index as integer,byval label as string) as integer
declare function wxListCtrl_InsertImageItem cdecl alias "wxListCtrl_InsertImageItem" (byval self as integer,byval index as integer,byval imageIndex as integer) as integer
declare function wxListCtrl_InsertTextImageItem cdecl alias "wxListCtrl_InsertTextImageItem" (byval self as integer,byval index as integer,byval label as string,byval imageIndex as integer) as integer
declare function wxListCtrl_InsertColumn cdecl alias "wxListCtrl_InsertColumn" (byval self as integer,byval col as integer,byval info as integer) as integer
declare function wxListCtrl_InsertTextColumn cdecl alias "wxListCtrl_InsertTextColumn" (byval self as integer,byval col as integer,byval heading as string,byval format as integer,byval width as integer) as integer
declare function wxListCtrl_ScrollList cdecl alias "wxListCtrl_ScrollList" (byval self as integer,byval dx as integer,byval dy as integer) as integer
declare function wxListCtrl_SortItems cdecl alias "wxListCtrl_SortItems" (byval self as integer,byval fn as integer,byval data as long) as integer
declare function wxListCtrl_GetViewRect cdecl alias "wxListCtrl_GetViewRect" (byval self as integer,byval rect as integer) as integer
declare function wxListCtrl_RefreshItem cdecl alias "wxListCtrl_RefreshItem" (byval self as integer,byval item as long) as integer
declare function wxListCtrl_RefreshItems cdecl alias "wxListCtrl_RefreshItems" (byval self as integer,byval itemFrom as long,byval itemTo as long) as integer
declare function wxListItem_ctor cdecl alias "wxListItem_ctor" () as integer
declare function wxListItem_Clear cdecl alias "wxListItem_Clear" (byval self as integer) as integer
declare function wxListItem_ClearAttributes cdecl alias "wxListItem_ClearAttributes" (byval self as integer) as integer
declare function wxListItem_GetAlign cdecl alias "wxListItem_GetAlign" (byval self as integer) as integer
declare function wxListItem_GetBackgroundColour cdecl alias "wxListItem_GetBackgroundColour" (byval self as integer) as integer
declare function wxListItem_GetColumn cdecl alias "wxListItem_GetColumn" (byval self as integer) as integer
declare function wxListItem_GetData cdecl alias "wxListItem_GetData" (byval self as integer) as integer
declare function wxListItem_GetFont cdecl alias "wxListItem_GetFont" (byval self as integer) as integer
declare function wxListItem_GetId cdecl alias "wxListItem_GetId" (byval self as integer) as integer
declare function wxListItem_GetImage cdecl alias "wxListItem_GetImage" (byval self as integer) as integer
declare function wxListItem_GetMask cdecl alias "wxListItem_GetMask" (byval self as integer) as integer
declare function wxListItem_GetState cdecl alias "wxListItem_GetState" (byval self as integer) as integer
declare function wxListItem_GetText cdecl alias "wxListItem_GetText" (byval self as integer) as byte ptr
declare function wxListItem_GetTextColour cdecl alias "wxListItem_GetTextColour" (byval self as integer) as integer
declare function wxListItem_GetWidth cdecl alias "wxListItem_GetWidth" (byval self as integer) as integer
declare function wxListItem_SetAlign cdecl alias "wxListItem_SetAlign" (byval self as integer,byval align as integer) as integer
declare function wxListItem_SetBackgroundColour cdecl alias "wxListItem_SetBackgroundColour" (byval self as integer,byval col as integer) as integer
declare function wxListItem_SetColumn cdecl alias "wxListItem_SetColumn" (byval self as integer,byval col as integer) as integer
declare function wxListItem_SetData cdecl alias "wxListItem_SetData" (byval self as integer,byval data as integer) as integer
declare function wxListItem_SetFont cdecl alias "wxListItem_SetFont" (byval self as integer,byval font as integer) as integer
declare function wxListItem_SetId cdecl alias "wxListItem_SetId" (byval self as integer,byval id as integer) as integer
declare function wxListItem_SetImage cdecl alias "wxListItem_SetImage" (byval self as integer,byval image as integer) as integer
declare function wxListItem_SetMask cdecl alias "wxListItem_SetMask" (byval self as integer,byval mask as integer) as integer
declare function wxListItem_SetState cdecl alias "wxListItem_SetState" (byval self as integer,byval state as integer) as integer
declare function wxListItem_SetStateMask cdecl alias "wxListItem_SetStateMask" (byval self as integer,byval stateMask as integer) as integer
declare function wxListItem_SetText cdecl alias "wxListItem_SetText" (byval self as integer,byval text as string) as integer
declare function wxListItem_SetTextColour cdecl alias "wxListItem_SetTextColour" (byval self as integer,byval col as integer) as integer
declare function wxListItem_SetWidth cdecl alias "wxListItem_SetWidth" (byval self as integer,byval width as integer) as integer
declare function wxListItem_GetAttributes cdecl alias "wxListItem_GetAttributes" (byval self as integer) as integer
declare function wxListItem_HasAttributes cdecl alias "wxListItem_HasAttributes" (byval self as integer) as integer
declare function wxListEvent_ctor cdecl alias "wxListEvent_ctor" (byval commandType as integer,byval id as integer) as integer
declare function wxListEvent_GetCacheFrom cdecl alias "wxListEvent_GetCacheFrom" (byval self as integer) as integer
declare function wxListEvent_GetCacheTo cdecl alias "wxListEvent_GetCacheTo" (byval self as integer) as integer
declare function wxListEvent_GetKeyCode cdecl alias "wxListEvent_GetKeyCode" (byval self as integer) as integer
declare function wxListEvent_GetIndex cdecl alias "wxListEvent_GetIndex" (byval self as integer) as long
declare function wxListEvent_GetColumn cdecl alias "wxListEvent_GetColumn" (byval self as integer) as integer
declare function wxListEvent_IsEditCancelled cdecl alias "wxListEvent_IsEditCancelled" (byval self as integer) as integer
declare function wxListEvent_SetEditCanceled cdecl alias "wxListEvent_SetEditCanceled" (byval self as integer,byval editCancelled as integer) as integer
declare function wxListEvent_GetLabel cdecl alias "wxListEvent_GetLabel" (byval self as integer) as byte ptr
declare function wxListEvent_GetPoint cdecl alias "wxListEvent_GetPoint" (byval self as integer,byval pt as integer) as integer
declare function wxListEvent_GetImage cdecl alias "wxListEvent_GetImage" (byval self as integer) as integer
declare function wxListEvent_GetText cdecl alias "wxListEvent_GetText" (byval self as integer) as byte ptr
declare function wxListEvent_GetMask cdecl alias "wxListEvent_GetMask" (byval self as integer) as integer
declare function wxListEvent_GetItem cdecl alias "wxListEvent_GetItem" (byval self as integer) as integer
declare function wxListEvent_GetData cdecl alias "wxListEvent_GetData" (byval self as integer) as integer
declare function wxListEvent_Veto cdecl alias "wxListEvent_Veto" (byval self as integer) as integer
declare function wxListEvent_Allow cdecl alias "wxListEvent_Allow" (byval self as integer) as integer
declare function wxListEvent_IsAllowed cdecl alias "wxListEvent_IsAllowed" (byval self as integer) as integer
declare function wxListView_ctor cdecl alias "wxListView_ctor" () as integer
declare function wxListView_Create cdecl alias "wxListView_Create" (byval self as integer,byval parent as integer,byval id as integer,byval pos as integer,byval size as integer,byval style as integer,byval validator as integer,byval name as string) as integer
declare function wxListView_Select cdecl alias "wxListView_Select" (byval self as integer,byval n as long,byval on as integer) as integer
declare function wxListView_Focus cdecl alias "wxListView_Focus" (byval self as integer,byval index as long) as integer
declare function wxListView_GetFocusedItem cdecl alias "wxListView_GetFocusedItem" (byval self as integer) as long
declare function wxListView_GetNextSelected cdecl alias "wxListView_GetNextSelected" (byval self as integer,byval item as long) as long
declare function wxListView_GetFirstSelected cdecl alias "wxListView_GetFirstSelected" (byval self as integer) as long
declare function wxListView_IsSelected cdecl alias "wxListView_IsSelected" (byval self as integer,byval index as long) as long
declare function wxListView_SetColumnImage cdecl alias "wxListView_SetColumnImage" (byval self as integer,byval col as integer,byval image as integer) as integer
declare function wxListView_ClearColumnImage cdecl alias "wxListView_ClearColumnImage" (byval self as integer,byval col as integer) as integer
declare function wxListItemAttr_ctor cdecl alias "wxListItemAttr_ctor" () as integer
declare function wxListItemAttr_ctor2 cdecl alias "wxListItemAttr_ctor2" (byval colText as integer,byval colBack as integer,byval font as integer) as integer
declare function wxListItemAttr_dtor cdecl alias "wxListItemAttr_dtor" (byval self as integer) as integer
declare function wxListItemAttr_RegisterDisposable cdecl alias "wxListItemAttr_RegisterDisposable" (byval self as integer,byval onDispose as integer) as integer
declare function wxListItemAttr_SetTextColour cdecl alias "wxListItemAttr_SetTextColour" (byval self as integer,byval colText as integer) as integer
declare function wxListItemAttr_SetBackgroundColour cdecl alias "wxListItemAttr_SetBackgroundColour" (byval self as integer,byval colBack as integer) as integer
declare function wxListItemAttr_SetFont cdecl alias "wxListItemAttr_SetFont" (byval self as integer,byval font as integer) as integer
declare function wxListItemAttr_HasTextColour cdecl alias "wxListItemAttr_HasTextColour" (byval self as integer) as integer
declare function wxListItemAttr_HasBackgroundColour cdecl alias "wxListItemAttr_HasBackgroundColour" (byval self as integer) as integer
declare function wxListItemAttr_HasFont cdecl alias "wxListItemAttr_HasFont" (byval self as integer) as integer
declare function wxListItemAttr_GetTextColour cdecl alias "wxListItemAttr_GetTextColour" (byval self as integer) as integer
declare function wxListItemAttr_GetBackgroundColour cdecl alias "wxListItemAttr_GetBackgroundColour" (byval self as integer) as integer
declare function wxListItemAttr_GetFont cdecl alias "wxListItemAttr_GetFont" (byval self as integer) as integer
declare function wxLocale_ctor cdecl alias "wxLocale_ctor" () as integer
declare function wxLocale_ctor2 cdecl alias "wxLocale_ctor2" (byval language as integer,byval flags as integer) as integer
declare function wxLocale_dtor cdecl alias "wxLocale_dtor" (byval self as integer) as integer
declare function wxLocale_Init cdecl alias "wxLocale_Init" (byval self as integer,byval language as integer,byval flags as integer) as integer
declare function wxLocale_AddCatalog cdecl alias "wxLocale_AddCatalog" (byval self as integer,byval szDomain as string) as integer
declare function wxLocale_AddCatalog2 cdecl alias "wxLocale_AddCatalog2" (byval self as integer,byval szDomain as string,byval msgIdLanguage as integer,byval msgIdCharset as string) as integer
declare function wxLocale_AddCatalogLookupPathPrefix cdecl alias "wxLocale_AddCatalogLookupPathPrefix" (byval self as integer,byval prefix as string) as integer
declare function wxLocale_AddLanguage cdecl alias "wxLocale_AddLanguage" (byval info as integer) as integer
declare function wxLocale_FindLanguageInfo cdecl alias "wxLocale_FindLanguageInfo" (byval locale as string) as integer
declare function wxLocale_GetCanonicalName cdecl alias "wxLocale_GetCanonicalName" (byval self as integer) as byte ptr
declare function wxLocale_GetLanguage cdecl alias "wxLocale_GetLanguage" (byval self as integer) as integer
declare function wxLocale_GetLanguageInfo cdecl alias "wxLocale_GetLanguageInfo" (byval lang as integer) as integer
declare function wxLocale_GetLanguageName cdecl alias "wxLocale_GetLanguageName" (byval lang as integer) as byte ptr
declare function wxLocale_GetLocale cdecl alias "wxLocale_GetLocale" (byval self as integer) as byte ptr
declare function wxLocale_GetName cdecl alias "wxLocale_GetName" (byval self as integer) as byte ptr
declare function wxLocale_GetString cdecl alias "wxLocale_GetString" (byval self as integer,byval szOrigString as string,byval szDomain as string) as byte ptr
declare function wxLocale_GetHeaderValue cdecl alias "wxLocale_GetHeaderValue" (byval self as integer,byval szHeader as string,byval szDomain as string) as byte ptr
declare function wxLocale_GetSysName cdecl alias "wxLocale_GetSysName" (byval self as integer) as byte ptr
declare function wxLocale_GetSystemEncoding cdecl alias "wxLocale_GetSystemEncoding" () as integer
declare function wxLocale_GetSystemEncodingName cdecl alias "wxLocale_GetSystemEncodingName" () as byte ptr
declare function wxLocale_GetSystemLanguage cdecl alias "wxLocale_GetSystemLanguage" () as integer
declare function wxLocale_IsLoaded cdecl alias "wxLocale_IsLoaded" (byval self as integer,byval domain as string) as integer
declare function wxLocale_IsOk cdecl alias "wxLocale_IsOk" (byval self as integer) as integer
declare function wxLanguageInfo_ctor cdecl alias "wxLanguageInfo_ctor" () as integer
declare function wxLanguageInfo_dtor cdecl alias "wxLanguageInfo_dtor" (byval self as integer) as integer
declare function wxLanguageInfo_SetLanguage cdecl alias "wxLanguageInfo_SetLanguage" (byval self as integer,byval value as integer) as integer
declare function wxLanguageInfo_GetLanguage cdecl alias "wxLanguageInfo_GetLanguage" (byval self as integer) as integer
declare function wxLanguageInfo_SetCanonicalName cdecl alias "wxLanguageInfo_SetCanonicalName" (byval self as integer,byval name as string) as integer
declare function wxLanguageInfo_GetCanonicalName cdecl alias "wxLanguageInfo_GetCanonicalName" (byval self as integer) as byte ptr
declare function wxLanguageInfo_SetDescription cdecl alias "wxLanguageInfo_SetDescription" (byval self as integer,byval name as string) as integer
declare function wxLanguageInfo_GetDescription cdecl alias "wxLanguageInfo_GetDescription" (byval self as integer) as byte ptr
declare function wxLog_ctor cdecl alias "wxLog_ctor" () as integer
declare function wxLog_dtor cdecl alias "wxLog_dtor" (byval self as integer) as integer
declare function wxLog_IsEnabled cdecl alias "wxLog_IsEnabled" () as integer
declare function wxLog_EnableLogging cdecl alias "wxLog_EnableLogging" (byval doit as integer) as integer
declare function wxLog_OnLog cdecl alias "wxLog_OnLog" (byval level as unsigned long,byval szString as string,byval t as long) as integer
declare function wxLog_Flush cdecl alias "wxLog_Flush" (byval self as integer) as integer
declare function wxLog_HasPendingMessages cdecl alias "wxLog_HasPendingMessages" (byval self as integer) as integer
declare function wxLog_FlushActive cdecl alias "wxLog_FlushActive" () as integer
declare function wxLog_GetActiveTarget cdecl alias "wxLog_GetActiveTarget" () as integer
declare function wxLog_SetActiveTargetTextCtrl cdecl alias "wxLog_SetActiveTargetTextCtrl" (byval pLogger as integer) as integer
declare function wxLog_DeleteActiveTarget cdecl alias "wxLog_DeleteActiveTarget" () as integer
declare function wxLog_Suspend cdecl alias "wxLog_Suspend" () as integer
declare function wxLog_Resume cdecl alias "wxLog_Resume" () as integer
declare function wxLog_SetVerbose cdecl alias "wxLog_SetVerbose" (byval bVerbose as integer) as integer
declare function wxLog_SetLogLevel cdecl alias "wxLog_SetLogLevel" (byval logLevel as integer) as integer
declare function wxLog_DontCreateOnDemand cdecl alias "wxLog_DontCreateOnDemand" () as integer
declare function wxLog_SetTraceMask cdecl alias "wxLog_SetTraceMask" (byval ulMask as integer) as integer
declare function wxLog_AddTraceMask cdecl alias "wxLog_AddTraceMask" (byval str as string) as integer
declare function wxLog_RemoveTraceMask cdecl alias "wxLog_RemoveTraceMask" (byval str as string) as integer
declare function wxLog_ClearTraceMasks cdecl alias "wxLog_ClearTraceMasks" () as integer
declare function wxLog_GetTraceMasks cdecl alias "wxLog_GetTraceMasks" () as integer
declare function wxLog_SetTimestamp cdecl alias "wxLog_SetTimestamp" (byval ts as string) as integer
declare function wxLog_GetVerbose cdecl alias "wxLog_GetVerbose" () as integer
declare function wxLog_GetTraceMask cdecl alias "wxLog_GetTraceMask" () as integer
declare function wxLog_IsAllowedTraceMask cdecl alias "wxLog_IsAllowedTraceMask" (byval mask as string) as integer
declare function wxLog_GetLogLevel cdecl alias "wxLog_GetLogLevel" () as integer
declare function wxLog_GetTimestamp cdecl alias "wxLog_GetTimestamp" () as byte ptr
declare function wxLog_TimeStamp cdecl alias "wxLog_TimeStamp" (byval str as string) as integer
declare function wxLog_Log_Function cdecl alias "wxLog_Log_Function" (byval what as integer,byval szFormat as string) as integer
declare function wxMaximizeEvent_ctor cdecl alias "wxMaximizeEvent_ctor" (byval id as integer) as integer
declare function wxMDIParentFrame_ctor cdecl alias "wxMDIParentFrame_ctor" () as integer
declare function wxMDIParentFrame_RegisterVirtual cdecl alias "wxMDIParentFrame_RegisterVirtual" (byval self as integer,byval onCreateClient as integer) as integer
declare function wxMDIParentFrame_OnCreateClient cdecl alias "wxMDIParentFrame_OnCreateClient" (byval self as integer) as integer
declare function wxMDIParentFrame_Create cdecl alias "wxMDIParentFrame_Create" (byval self as integer,byval parent as integer,byval id as integer,byval title as string,byval pos as integer,byval size as integer,byval style as integer,byval name as string) as integer
declare function wxMDIParentFrame_GetActiveChild cdecl alias "wxMDIParentFrame_GetActiveChild" (byval self as integer) as integer
declare function wxMDIParentFrame_GetClientWindow cdecl alias "wxMDIParentFrame_GetClientWindow" (byval self as integer) as integer
declare function wxMDIParentFrame_Cascade cdecl alias "wxMDIParentFrame_Cascade" (byval self as integer) as integer
declare function wxMDIParentFrame_Tile cdecl alias "wxMDIParentFrame_Tile" (byval self as integer) as integer
declare function wxMDIParentFrame_ArrangeIcons cdecl alias "wxMDIParentFrame_ArrangeIcons" (byval self as integer) as integer
declare function wxMDIParentFrame_ActivateNext cdecl alias "wxMDIParentFrame_ActivateNext" (byval self as integer) as integer
declare function wxMDIParentFrame_ActivatePrevious cdecl alias "wxMDIParentFrame_ActivatePrevious" (byval self as integer) as integer
declare function wxMDIParentFrame_GetClientSize cdecl alias "wxMDIParentFrame_GetClientSize" (byval self as integer,byval width as integer,byval height as integer) as integer
declare function wxMDIChildFrame_ctor cdecl alias "wxMDIChildFrame_ctor" () as integer
declare function wxMDIChildFrame_Activate cdecl alias "wxMDIChildFrame_Activate" (byval self as integer) as integer
declare function wxMDIChildFrame_Create cdecl alias "wxMDIChildFrame_Create" (byval self as integer,byval parent as integer,byval id as integer,byval title as string,byval pos as integer,byval size as integer,byval style as long,byval name as string) as integer
declare function wxMDIChildFrame_Restore cdecl alias "wxMDIChildFrame_Restore" (byval self as integer) as integer
declare function wxMDIChildFrame_Maximize cdecl alias "wxMDIChildFrame_Maximize" (byval self as integer,byval maximize as integer) as integer
declare function wxMDIClientWindow_ctor cdecl alias "wxMDIClientWindow_ctor" () as integer
declare function wxMDIClientWindow_CreateClient cdecl alias "wxMDIClientWindow_CreateClient" (byval self as integer,byval parent as integer,byval style as integer) as integer
declare function wxMemoryDC_ctor cdecl alias "wxMemoryDC_ctor" () as integer
declare function wxMemoryDC_ctorByDC cdecl alias "wxMemoryDC_ctorByDC" (byval dc as integer) as integer
declare function wxMemoryDC_SelectObject cdecl alias "wxMemoryDC_SelectObject" (byval self as integer,byval bitmap as integer) as integer
declare function wxBufferedDC_ctor cdecl alias "wxBufferedDC_ctor" () as integer
declare function wxBufferedDC_ctorByBitmap cdecl alias "wxBufferedDC_ctorByBitmap" (byval dc as integer,byval buffer as integer) as integer
declare function wxBufferedDC_ctorBySize cdecl alias "wxBufferedDC_ctorBySize" (byval dc as integer,byval area as integer) as integer
declare function wxBufferedDC_InitByBitmap cdecl alias "wxBufferedDC_InitByBitmap" (byval self as integer,byval dc as integer,byval bitmap as integer) as integer
declare function wxBufferedDC_InitBySize cdecl alias "wxBufferedDC_InitBySize" (byval self as integer,byval dc as integer,byval area as integer) as integer
declare function wxBufferedDC_UnMask cdecl alias "wxBufferedDC_UnMask" (byval self as integer) as integer
declare function wxBufferedPaintDC_ctor cdecl alias "wxBufferedPaintDC_ctor" (byval window as integer,byval buffer as integer) as integer
declare function wxMenuBase_ctor1 cdecl alias "wxMenuBase_ctor1" (byval title as string,byval style as long) as integer
declare function wxMenuBase_ctor2 cdecl alias "wxMenuBase_ctor2" (byval style as long) as integer
declare function wxMenuBase_Append cdecl alias "wxMenuBase_Append" (byval self as integer,byval id as integer,byval item as string,byval helpString as string,byval kind as integer) as integer
declare function wxMenuBase_AppendSeparator cdecl alias "wxMenuBase_AppendSeparator" (byval self as integer) as integer
declare function wxMenuBase_AppendCheckItem cdecl alias "wxMenuBase_AppendCheckItem" (byval self as integer,byval itemid as integer,byval text as string,byval help as string) as integer
declare function wxMenuBase_AppendRadioItem cdecl alias "wxMenuBase_AppendRadioItem" (byval self as integer,byval itemid as integer,byval text as string,byval help as string) as integer
declare function wxMenuBase_AppendSubMenu cdecl alias "wxMenuBase_AppendSubMenu" (byval self as integer,byval id as integer,byval item as string,byval subMenu as integer,byval helpString as string) as integer
declare function wxMenuBase_AppendItem cdecl alias "wxMenuBase_AppendItem" (byval self as integer,byval item as integer) as integer
declare function wxMenuBase_Break cdecl alias "wxMenuBase_Break" (byval self as integer) as integer
declare function wxMenuBase_Insert cdecl alias "wxMenuBase_Insert" (byval self as integer,byval pos as integer,byval item as integer) as integer
declare function wxMenuBase_Insert2 cdecl alias "wxMenuBase_Insert2" (byval self as integer,byval pos as integer,byval itemid as integer,byval text as string,byval help as string,byval kind as integer) as integer
declare function wxMenuBase_InsertSeparator cdecl alias "wxMenuBase_InsertSeparator" (byval self as integer,byval pos as integer) as integer
declare function wxMenuBase_InsertCheckItem cdecl alias "wxMenuBase_InsertCheckItem" (byval self as integer,byval pos as integer,byval itemid as integer,byval text as string,byval help as string) as integer
declare function wxMenuBase_InsertRadioItem cdecl alias "wxMenuBase_InsertRadioItem" (byval self as integer,byval pos as integer,byval itemid as integer,byval text as string,byval help as string) as integer
declare function wxMenuBase_InsertSubMenu cdecl alias "wxMenuBase_InsertSubMenu" (byval self as integer,byval pos as integer,byval itemid as integer,byval text as string,byval submenu as integer,byval help as string) as integer
declare function wxMenuBase_Prepend cdecl alias "wxMenuBase_Prepend" (byval self as integer,byval item as integer) as integer
declare function wxMenuBase_Prepend2 cdecl alias "wxMenuBase_Prepend2" (byval self as integer,byval itemid as integer,byval text as string,byval help as string,byval kind as integer) as integer
declare function wxMenuBase_PrependSeparator cdecl alias "wxMenuBase_PrependSeparator" (byval self as integer) as integer
declare function wxMenuBase_PrependCheckItem cdecl alias "wxMenuBase_PrependCheckItem" (byval self as integer,byval itemid as integer,byval text as string,byval help as string) as integer
declare function wxMenuBase_PrependRadioItem cdecl alias "wxMenuBase_PrependRadioItem" (byval self as integer,byval itemid as integer,byval text as string,byval help as string) as integer
declare function wxMenuBase_PrependSubMenu cdecl alias "wxMenuBase_PrependSubMenu" (byval self as integer,byval itemid as integer,byval text as string,byval submenu as integer,byval help as string) as integer
declare function wxMenuBase_Remove cdecl alias "wxMenuBase_Remove" (byval self as integer,byval itemid as integer) as integer
declare function wxMenuBase_Remove2 cdecl alias "wxMenuBase_Remove2" (byval self as integer,byval item as integer) as integer
declare function wxMenuBase_Delete cdecl alias "wxMenuBase_Delete" (byval self as integer,byval itemid as integer) as integer
declare function wxMenuBase_Delete2 cdecl alias "wxMenuBase_Delete2" (byval self as integer,byval item as integer) as integer
declare function wxMenuBase_Destroy cdecl alias "wxMenuBase_Destroy" (byval self as integer,byval itemid as integer) as integer
declare function wxMenuBase_Destroy2 cdecl alias "wxMenuBase_Destroy2" (byval self as integer,byval item as integer) as integer
declare function wxMenuBase_GetMenuItemCount cdecl alias "wxMenuBase_GetMenuItemCount" (byval self as integer) as integer
declare function wxMenuBase_FindItem cdecl alias "wxMenuBase_FindItem" (byval self as integer,byval item as string) as integer
declare function wxMenuBase_FindItem2 cdecl alias "wxMenuBase_FindItem2" (byval self as integer,byval itemid as integer,byval  menu as integer) as integer
declare function wxMenuBase_FindItemByPosition cdecl alias "wxMenuBase_FindItemByPosition" (byval self as integer,byval position as integer) as integer
declare function wxMenuBase_Enable cdecl alias "wxMenuBase_Enable" (byval self as integer,byval itemid as integer,byval enable as integer) as integer
declare function wxMenuBase_IsEnabled cdecl alias "wxMenuBase_IsEnabled" (byval self as integer,byval itemid as integer) as integer
declare function wxMenuBase_Check cdecl alias "wxMenuBase_Check" (byval self as integer,byval itemid as integer,byval check as integer) as integer
declare function wxMenuBase_IsChecked cdecl alias "wxMenuBase_IsChecked" (byval self as integer,byval itemid as integer) as integer
declare function wxMenuBase_SetLabel cdecl alias "wxMenuBase_SetLabel" (byval self as integer,byval itemid as integer,byval label as string) as integer
declare function wxMenuBase_GetLabel cdecl alias "wxMenuBase_GetLabel" (byval self as integer,byval itemid as integer) as byte ptr
declare function wxMenuBase_SetHelpString cdecl alias "wxMenuBase_SetHelpString" (byval self as integer,byval itemid as integer,byval helpString as string) as integer
declare function wxMenuBase_GetHelpString cdecl alias "wxMenuBase_GetHelpString" (byval self as integer,byval itemid as integer) as byte ptr
declare function wxMenuBase_SetTitle cdecl alias "wxMenuBase_SetTitle" (byval self as integer,byval title as string) as integer
declare function wxMenuBase_GetTitle cdecl alias "wxMenuBase_GetTitle" (byval self as integer) as byte ptr
declare function wxMenuBase_SetEventHandler cdecl alias "wxMenuBase_SetEventHandler" (byval self as integer,byval handler as integer) as integer
declare function wxMenuBase_GetEventHandler cdecl alias "wxMenuBase_GetEventHandler" (byval self as integer) as integer
declare function wxMenuBase_SetInvokingWindow cdecl alias "wxMenuBase_SetInvokingWindow" (byval self as integer,byval win as integer) as integer
declare function wxMenuBase_GetInvokingWindow cdecl alias "wxMenuBase_GetInvokingWindow" (byval self as integer) as integer
declare function wxMenuBase_GetStyle cdecl alias "wxMenuBase_GetStyle" (byval self as integer) as long
declare function wxMenuBase_UpdateUI cdecl alias "wxMenuBase_UpdateUI" (byval self as integer,byval source as integer) as integer
declare function wxMenuBase_GetMenuBar cdecl alias "wxMenuBase_GetMenuBar" (byval self as integer) as integer
declare function wxMenuBase_IsAttached cdecl alias "wxMenuBase_IsAttached" (byval self as integer) as integer
declare function wxMenuBase_SetParent cdecl alias "wxMenuBase_SetParent" (byval self as integer,byval parent as integer) as integer
declare function wxMenuBase_GetParent cdecl alias "wxMenuBase_GetParent" (byval self as integer) as integer
declare function wxMenuBase_FindChildItem cdecl alias "wxMenuBase_FindChildItem" (byval self as integer,byval itemid as integer,byval pos as integer) as integer
declare function wxMenuBase_FindChildItem2 cdecl alias "wxMenuBase_FindChildItem2" (byval self as integer,byval itemid as integer) as integer
declare function wxMenuBase_SendEvent cdecl alias "wxMenuBase_SendEvent" (byval self as integer,byval itemid as integer,byval checked as integer) as integer
declare function wxMenu_ctor cdecl alias "wxMenu_ctor" (byval titel as string,byval style as long) as integer
declare function wxMenu_ctor2 cdecl alias "wxMenu_ctor2" (byval style as long) as integer
declare function wxMenuBar_ctor cdecl alias "wxMenuBar_ctor" () as integer
declare function wxMenuBar_ctor2 cdecl alias "wxMenuBar_ctor2" (byval style as long) as integer
declare function wxMenuBar_Append cdecl alias "wxMenuBar_Append" (byval self as integer,byval menu as integer,byval title as string) as integer
declare function wxMenuBar_Check cdecl alias "wxMenuBar_Check" (byval self as integer,byval id as integer,byval check as integer) as integer
declare function wxMenuBar_IsChecked cdecl alias "wxMenuBar_IsChecked" (byval self as integer,byval id as integer) as integer
declare function wxMenuBar_Insert cdecl alias "wxMenuBar_Insert" (byval self as integer,byval pos as integer,byval menu as integer,byval title as string) as integer
declare function wxMenuBar_FindItem cdecl alias "wxMenuBar_FindItem" (byval self as integer,byval id as integer,byval  menu as integer) as integer
declare function wxMenuBar_GetMenuCount cdecl alias "wxMenuBar_GetMenuCount" (byval self as integer) as integer
declare function wxMenuBar_GetMenu cdecl alias "wxMenuBar_GetMenu" (byval self as integer,byval pos as integer) as integer
declare function wxMenuBar_Replace cdecl alias "wxMenuBar_Replace" (byval self as integer,byval pos as integer,byval menu as integer,byval title as string) as integer
declare function wxMenuBar_Remove cdecl alias "wxMenuBar_Remove" (byval self as integer,byval pos as integer) as integer
declare function wxMenuBar_EnableTop cdecl alias "wxMenuBar_EnableTop" (byval self as integer,byval pos as integer,byval enable as integer) as integer
declare function wxMenuBar_Enable cdecl alias "wxMenuBar_Enable" (byval self as integer,byval id as integer,byval enable as integer) as integer
declare function wxMenuBar_FindMenu cdecl alias "wxMenuBar_FindMenu" (byval self as integer,byval title as string) as integer
declare function wxMenuBar_FindMenuItem cdecl alias "wxMenuBar_FindMenuItem" (byval self as integer,byval menustring as string,byval itemString as string) as integer
declare function wxMenuBar_GetHelpString cdecl alias "wxMenuBar_GetHelpString" (byval self as integer,byval id as integer) as byte ptr
declare function wxMenuBar_GetLabel cdecl alias "wxMenuBar_GetLabel" (byval self as integer,byval id as integer) as byte ptr
declare function wxMenuBar_GetLabelTop cdecl alias "wxMenuBar_GetLabelTop" (byval self as integer,byval pos as integer) as byte ptr
declare function wxMenuBar_IsEnabled cdecl alias "wxMenuBar_IsEnabled" (byval self as integer,byval id as integer) as integer
declare function wxMenuBar_Refresh cdecl alias "wxMenuBar_Refresh" (byval self as integer) as integer
declare function wxMenuBar_SetHelpString cdecl alias "wxMenuBar_SetHelpString" (byval self as integer,byval id as integer,byval helpstring as string) as integer
declare function wxMenuBar_SetLabel cdecl alias "wxMenuBar_SetLabel" (byval self as integer,byval id as integer,byval label as string) as integer
declare function wxMenuBar_SetLabelTop cdecl alias "wxMenuBar_SetLabelTop" (byval self as integer,byval pos as integer,byval label as string) as integer
declare function wxMenuItem_ctor cdecl alias "wxMenuItem_ctor" (byval parentMenu as integer,byval id as integer,byval text as string,byval help as string,byval kind as integer,byval subMenu as integer) as integer
declare function wxMenuItem_GetMenu cdecl alias "wxMenuItem_GetMenu" (byval self as integer) as integer
declare function wxMenuItem_SetMenu cdecl alias "wxMenuItem_SetMenu" (byval self as integer,byval menu as integer) as integer
declare function wxMenuItem_SetId cdecl alias "wxMenuItem_SetId" (byval self as integer,byval id as integer) as integer
declare function wxMenuItem_GetId cdecl alias "wxMenuItem_GetId" (byval self as integer) as integer
declare function wxMenuItem_IsSeparator cdecl alias "wxMenuItem_IsSeparator" (byval self as integer) as integer
declare function wxMenuItem_SetText cdecl alias "wxMenuItem_SetText" (byval self as integer,byval str as string) as integer
declare function wxMenuItem_GetLabel cdecl alias "wxMenuItem_GetLabel" (byval self as integer) as byte ptr
declare function wxMenuItem_GetText cdecl alias "wxMenuItem_GetText" (byval self as integer) as byte ptr
declare function wxMenuItem_GetLabelFromText cdecl alias "wxMenuItem_GetLabelFromText" (byval self as integer,byval text as string) as byte ptr
declare function wxMenuItem_GetKind cdecl alias "wxMenuItem_GetKind" (byval self as integer) as integer
declare function wxMenuItem_SetCheckable cdecl alias "wxMenuItem_SetCheckable" (byval self as integer,byval checkable as integer) as integer
declare function wxMenuItem_IsCheckable cdecl alias "wxMenuItem_IsCheckable" (byval self as integer) as integer
declare function wxMenuItem_IsSubMenu cdecl alias "wxMenuItem_IsSubMenu" (byval self as integer) as integer
declare function wxMenuItem_SetSubMenu cdecl alias "wxMenuItem_SetSubMenu" (byval self as integer,byval menu as integer) as integer
declare function wxMenuItem_GetSubMenu cdecl alias "wxMenuItem_GetSubMenu" (byval self as integer) as integer
declare function wxMenuItem_Enable cdecl alias "wxMenuItem_Enable" (byval self as integer,byval enable as integer) as integer
declare function wxMenuItem_IsEnabled cdecl alias "wxMenuItem_IsEnabled" (byval self as integer) as integer
declare function wxMenuItem_Check cdecl alias "wxMenuItem_Check" (byval self as integer,byval check as integer) as integer
declare function wxMenuItem_IsChecked cdecl alias "wxMenuItem_IsChecked" (byval self as integer) as integer
declare function wxMenuItem_Toggle cdecl alias "wxMenuItem_Toggle" (byval self as integer) as integer
declare function wxMenuItem_SetHelp cdecl alias "wxMenuItem_SetHelp" (byval self as integer,byval str as string) as integer
declare function wxMenuItem_GetHelp cdecl alias "wxMenuItem_GetHelp" (byval self as integer) as byte ptr
declare function wxMenuItem_GetAccel cdecl alias "wxMenuItem_GetAccel" (byval self as integer) as integer
declare function wxMenuItem_SetAccel cdecl alias "wxMenuItem_SetAccel" (byval self as integer,byval accel as integer) as integer
declare function wxMenuItem_SetName cdecl alias "wxMenuItem_SetName" (byval self as integer,byval str as string) as integer
declare function wxMenuItem_GetName cdecl alias "wxMenuItem_GetName" (byval self as integer) as byte ptr
declare function wxMenuItem_NewCheck cdecl alias "wxMenuItem_NewCheck" (byval parentMenu as integer,byval id as integer,byval text as string,byval help as string,byval isCheckable as integer,byval subMenu as integer) as integer
declare function wxMenuItem_New cdecl alias "wxMenuItem_New" (byval parentMenu as integer,byval id as integer,byval text as string,byval help as string,byval kind as integer,byval subMenu as integer) as integer
declare function wxMenuItem_SetBitmap cdecl alias "wxMenuItem_SetBitmap" (byval self as integer,byval bitmap as integer) as integer
declare function wxMenuItem_GetBitmap cdecl alias "wxMenuItem_GetBitmap" (byval self as integer) as integer
declare function wxMsgBox cdecl alias "wxMsgBox" (byval parent as integer,byval msg as string,byval cap as string,byval style as integer,byval pos as integer) as integer
declare function wxMessageDialog_ctor cdecl alias "wxMessageDialog_ctor" (byval parent as integer,byval message as string,byval caption as string,byval style as integer,byval pos as integer) as integer
declare function wxMessageDialog_ShowModal cdecl alias "wxMessageDialog_ShowModal" (byval self as integer) as integer
declare function wxMiniFrame_ctor cdecl alias "wxMiniFrame_ctor" () as integer
declare function wxMiniFrame_Create cdecl alias "wxMiniFrame_Create" (byval self as integer,byval parent as integer,byval id as integer,byval title as string,byval pos as integer,byval size as integer,byval style as integer,byval name as string) as integer
declare function wxMouseCaptureChangedEvent_ctor cdecl alias "wxMouseCaptureChangedEvent_ctor" (byval type as integer) as integer
declare function wxMouseCaptureChangedEvent_GetCapturedWindow cdecl alias "wxMouseCaptureChangedEvent_GetCapturedWindow" (byval self as integer) as integer
declare function wxMouseEvent_ctor cdecl alias "wxMouseEvent_ctor" (byval mouseType as integer) as integer
declare function wxMouseEvent_IsButton cdecl alias "wxMouseEvent_IsButton" (byval self as integer) as integer
declare function wxMouseEvent_ButtonDown cdecl alias "wxMouseEvent_ButtonDown" (byval self as integer) as integer
declare function wxMouseEvent_ButtonDown2 cdecl alias "wxMouseEvent_ButtonDown2" (byval self as integer,byval button as integer) as integer
declare function wxMouseEvent_ButtonDClick cdecl alias "wxMouseEvent_ButtonDClick" (byval self as integer,byval but as integer) as integer
declare function wxMouseEvent_ButtonUp cdecl alias "wxMouseEvent_ButtonUp" (byval self as integer,byval but as integer) as integer
declare function wxMouseEvent_Button cdecl alias "wxMouseEvent_Button" (byval self as integer,byval but as integer) as integer
declare function wxMouseEvent_ButtonIsDown cdecl alias "wxMouseEvent_ButtonIsDown" (byval self as integer,byval but as integer) as integer
declare function wxMouseEvent_GetButton cdecl alias "wxMouseEvent_GetButton" (byval self as integer) as integer
declare function wxMouseEvent_ControlDown cdecl alias "wxMouseEvent_ControlDown" (byval self as integer) as integer
declare function wxMouseEvent_MetaDown cdecl alias "wxMouseEvent_MetaDown" (byval self as integer) as integer
declare function wxMouseEvent_AltDown cdecl alias "wxMouseEvent_AltDown" (byval self as integer) as integer
declare function wxMouseEvent_ShiftDown cdecl alias "wxMouseEvent_ShiftDown" (byval self as integer) as integer
declare function wxMouseEvent_LeftDown cdecl alias "wxMouseEvent_LeftDown" (byval self as integer) as integer
declare function wxMouseEvent_MiddleDown cdecl alias "wxMouseEvent_MiddleDown" (byval self as integer) as integer
declare function wxMouseEvent_RightDown cdecl alias "wxMouseEvent_RightDown" (byval self as integer) as integer
declare function wxMouseEvent_LeftUp cdecl alias "wxMouseEvent_LeftUp" (byval self as integer) as integer
declare function wxMouseEvent_MiddleUp cdecl alias "wxMouseEvent_MiddleUp" (byval self as integer) as integer
declare function wxMouseEvent_RightUp cdecl alias "wxMouseEvent_RightUp" (byval self as integer) as integer
declare function wxMouseEvent_LeftDClick cdecl alias "wxMouseEvent_LeftDClick" (byval self as integer) as integer
declare function wxMouseEvent_MiddleDClick cdecl alias "wxMouseEvent_MiddleDClick" (byval self as integer) as integer
declare function wxMouseEvent_RightDClick cdecl alias "wxMouseEvent_RightDClick" (byval self as integer) as integer
declare function wxMouseEvent_LeftIsDown cdecl alias "wxMouseEvent_LeftIsDown" (byval self as integer) as integer
declare function wxMouseEvent_MiddleIsDown cdecl alias "wxMouseEvent_MiddleIsDown" (byval self as integer) as integer
declare function wxMouseEvent_RightIsDown cdecl alias "wxMouseEvent_RightIsDown" (byval self as integer) as integer
declare function wxMouseEvent_Dragging cdecl alias "wxMouseEvent_Dragging" (byval self as integer) as integer
declare function wxMouseEvent_Moving cdecl alias "wxMouseEvent_Moving" (byval self as integer) as integer
declare function wxMouseEvent_Entering cdecl alias "wxMouseEvent_Entering" (byval self as integer) as integer
declare function wxMouseEvent_Leaving cdecl alias "wxMouseEvent_Leaving" (byval self as integer) as integer
declare function wxMouseEvent_GetPosition cdecl alias "wxMouseEvent_GetPosition" (byval self as integer,byval pos as integer) as integer
declare function wxMouseEvent_LogicalPosition cdecl alias "wxMouseEvent_LogicalPosition" (byval self as integer,byval dc as integer,byval pos as integer) as integer
declare function wxMouseEvent_GetWheelRotation cdecl alias "wxMouseEvent_GetWheelRotation" (byval self as integer) as integer
declare function wxMouseEvent_GetWheelDelta cdecl alias "wxMouseEvent_GetWheelDelta" (byval self as integer) as integer
declare function wxMouseEvent_GetLinesPerAction cdecl alias "wxMouseEvent_GetLinesPerAction" (byval self as integer) as integer
declare function wxMouseEvent_IsPageScroll cdecl alias "wxMouseEvent_IsPageScroll" (byval self as integer) as integer
declare function wxMoveEvent_ctor cdecl alias "wxMoveEvent_ctor" () as integer
declare function wxMoveEvent_GetPosition cdecl alias "wxMoveEvent_GetPosition" (byval self as integer,byval point as integer) as integer
declare function wxNavigationKeyEvent_ctor cdecl alias "wxNavigationKeyEvent_ctor" () as integer
declare function wxNavigationKeyEvent_GetDirection cdecl alias "wxNavigationKeyEvent_GetDirection" (byval self as integer) as integer
declare function wxNavigationKeyEvent_SetDirection cdecl alias "wxNavigationKeyEvent_SetDirection" (byval self as integer,byval bForward as integer) as integer
declare function wxNavigationKeyEvent_IsWindowChange cdecl alias "wxNavigationKeyEvent_IsWindowChange" (byval self as integer) as integer
declare function wxNavigationKeyEvent_SetWindowChange cdecl alias "wxNavigationKeyEvent_SetWindowChange" (byval self as integer,byval bIs as integer) as integer
declare function wxNavigationKeyEvent_GetCurrentFocus cdecl alias "wxNavigationKeyEvent_GetCurrentFocus" (byval self as integer) as integer
declare function wxNavigationKeyEvent_SetCurrentFocus cdecl alias "wxNavigationKeyEvent_SetCurrentFocus" (byval self as integer,byval win as integer) as integer
declare function wxNavigationKeyEvent_SetFlags cdecl alias "wxNavigationKeyEvent_SetFlags" (byval self as integer,byval flags as long) as integer
declare function wxNcPaintEvent_ctor cdecl alias "wxNcPaintEvent_ctor" (byval Id as integer) as integer
declare function wxNotebook_ctor cdecl alias "wxNotebook_ctor" () as integer
declare function wxNotebook_AddPage cdecl alias "wxNotebook_AddPage" (byval self as integer,byval page as integer,byval text as string,byval select as integer,byval imageId as integer) as integer
declare function wxNotebook_Create cdecl alias "wxNotebook_Create" (byval self as integer,byval parent as integer,byval id as integer,byval pos as integer,byval size as integer,byval style as long,byval name as string) as integer
declare function wxNotebook_SetImageList cdecl alias "wxNotebook_SetImageList" (byval self as integer,byval imageList as integer) as integer
declare function wxNotebook_GetPageCount cdecl alias "wxNotebook_GetPageCount" (byval self as integer) as integer
declare function wxNotebook_GetPage cdecl alias "wxNotebook_GetPage" (byval self as integer,byval nPage as integer) as integer
declare function wxNotebook_GetSelection cdecl alias "wxNotebook_GetSelection" (byval self as integer) as integer
declare function wxNotebook_SetPageText cdecl alias "wxNotebook_SetPageText" (byval self as integer,byval nPage as integer,byval strText as string) as integer
declare function wxNotebook_GetPageText cdecl alias "wxNotebook_GetPageText" (byval self as integer,byval nPage as integer) as byte ptr
declare function wxNotebook_AssignImageList cdecl alias "wxNotebook_AssignImageList" (byval self as integer,byval imageList as integer) as integer
declare function wxNotebook_GetImageList cdecl alias "wxNotebook_GetImageList" (byval self as integer) as integer
declare function wxNotebook_GetPageImage cdecl alias "wxNotebook_GetPageImage" (byval self as integer,byval nPage as integer) as integer
declare function wxNotebook_SetPageImage cdecl alias "wxNotebook_SetPageImage" (byval self as integer,byval nPage as integer,byval nImage as integer) as integer
declare function wxNotebook_GetRowCount cdecl alias "wxNotebook_GetRowCount" (byval self as integer) as integer
declare function wxNotebook_SetPageSize cdecl alias "wxNotebook_SetPageSize" (byval self as integer,byval size as integer) as integer
declare function wxNotebook_SetPadding cdecl alias "wxNotebook_SetPadding" (byval self as integer,byval padding as integer) as integer
declare function wxNotebook_SetTabSize cdecl alias "wxNotebook_SetTabSize" (byval self as integer,byval sz as integer) as integer
declare function wxNotebook_DeletePage cdecl alias "wxNotebook_DeletePage" (byval self as integer,byval nPage as integer) as integer
declare function wxNotebook_RemovePage cdecl alias "wxNotebook_RemovePage" (byval self as integer,byval nPage as integer) as integer
declare function wxNotebook_DeleteAllPages cdecl alias "wxNotebook_DeleteAllPages" (byval self as integer) as integer
declare function wxNotebook_InsertPage cdecl alias "wxNotebook_InsertPage" (byval self as integer,byval nPage as integer,byval pPage as integer,byval strText as string,byval bSelect as integer,byval imageId as integer) as integer
declare function wxNotebook_SetSelection cdecl alias "wxNotebook_SetSelection" (byval self as integer,byval nPage as integer) as integer
declare function wxNotebook_AdvanceSelection cdecl alias "wxNotebook_AdvanceSelection" (byval self as integer,byval forward as integer) as integer
declare function wxNotebookEvent_ctor cdecl alias "wxNotebookEvent_ctor" (byval commandType as integer,byval id as integer,byval nSel as integer,byval nOldSel as integer) as integer
declare function wxNotebookEvent_GetSelection cdecl alias "wxNotebookEvent_GetSelection" (byval self as integer) as integer
declare function wxNotebookEvent_SetSelection cdecl alias "wxNotebookEvent_SetSelection" (byval self as integer,byval nSel as integer) as integer
declare function wxNotebookEvent_GetOldSelection cdecl alias "wxNotebookEvent_GetOldSelection" (byval self as integer) as integer
declare function wxNotebookEvent_SetOldSelection cdecl alias "wxNotebookEvent_SetOldSelection" (byval self as integer,byval nOldSel as integer) as integer
declare function wxNotebookEvent_Veto cdecl alias "wxNotebookEvent_Veto" (byval self as integer) as integer
declare function wxNotebookEvent_Allow cdecl alias "wxNotebookEvent_Allow" (byval self as integer) as integer
declare function wxNotebookEvent_IsAllowed cdecl alias "wxNotebookEvent_IsAllowed" (byval self as integer) as integer
declare function wxNotebookSizer_ctor cdecl alias "wxNotebookSizer_ctor" (byval nb as integer) as integer
declare function wxNotebookSizer_RecalcSizes cdecl alias "wxNotebookSizer_RecalcSizes" (byval self as integer) as integer
declare function wxNotebookSizer_CalcMin cdecl alias "wxNotebookSizer_CalcMin" (byval self as integer,byval size as integer) as integer
declare function wxNotebookSizer_GetNotebook cdecl alias "wxNotebookSizer_GetNotebook" (byval self as integer) as integer
declare function wxObject_GetTypeName cdecl alias "wxObject_GetTypeName" (byval obj as integer) as byte ptr
declare function wxObject_dtor cdecl alias "wxObject_dtor" (byval self as integer) as integer
declare function wxGetTranslation_func cdecl alias "wxGetTranslation_func" (byval str as string) as byte ptr
declare function wxPaintEvent_ctor cdecl alias "wxPaintEvent_ctor" (byval Id as integer) as integer
declare function wxPalette_ctor cdecl alias "wxPalette_ctor" () as integer
declare function wxPalette_dtor cdecl alias "wxPalette_dtor" (byval self as integer) as integer
declare function wxPalette_Ok cdecl alias "wxPalette_Ok" (byval self as integer) as integer
declare function wxPalette_Create cdecl alias "wxPalette_Create" (byval self as integer,byval n as integer,byval red as integer,byval green as integer,byval blue as integer) as integer
declare function wxPalette_GetPixel cdecl alias "wxPalette_GetPixel" (byval self as integer,byval red as integer,byval green as integer,byval blue as integer) as integer
declare function wxPalette_GetRGB cdecl alias "wxPalette_GetRGB" (byval self as integer,byval pixel as integer,byval red as integer,byval green as integer,byval blue as integer) as integer
declare function wxPaletteChangedEvent_ctor cdecl alias "wxPaletteChangedEvent_ctor" (byval type as integer) as integer
declare function wxPaletteChangedEvent_SetChangedWindow cdecl alias "wxPaletteChangedEvent_SetChangedWindow" (byval self as integer,byval win as integer) as integer
declare function wxPaletteChangedEvent_GetChangedWindow cdecl alias "wxPaletteChangedEvent_GetChangedWindow" (byval self as integer) as integer
declare function wxPanel_ctor cdecl alias "wxPanel_ctor" () as integer
declare function wxPanel_ctor2 cdecl alias "wxPanel_ctor2" (byval parent as integer,byval id as integer,byval pos as integer,byval size as integer,byval style as long,byval name as string) as integer
declare function wxPanel_Create cdecl alias "wxPanel_Create" (byval self as integer,byval parent as integer,byval id as integer,byval pos as integer,byval size as integer,byval style as long,byval name as string) as integer
declare function wxPanel_InitDialog cdecl alias "wxPanel_InitDialog" (byval self as integer) as integer
declare function wxPanel_SetDefaultItem cdecl alias "wxPanel_SetDefaultItem" (byval self as integer,byval btn as integer) as integer
declare function wxPanel_GetDefaultItem cdecl alias "wxPanel_GetDefaultItem" (byval self as integer) as integer
declare function wxPen_ctorByName cdecl alias "wxPen_ctorByName" (byval name as string,byval width as integer,byval style as integer) as integer
declare function wxPen_ctor cdecl alias "wxPen_ctor" (byval col as integer,byval width as integer,byval style as integer) as integer
declare function wxPen_SetWidth cdecl alias "wxPen_SetWidth" (byval self as integer,byval width as integer) as integer
declare function wxPen_GetWidth cdecl alias "wxPen_GetWidth" (byval self as integer) as integer
declare function wxPen_GetColour cdecl alias "wxPen_GetColour" (byval self as integer) as integer
declare function wxPen_SetColour cdecl alias "wxPen_SetColour" (byval self as integer,byval col as integer) as integer
declare function wxPen_GetCap cdecl alias "wxPen_GetCap" (byval self as integer) as integer
declare function wxPen_GetJoin cdecl alias "wxPen_GetJoin" (byval self as integer) as integer
declare function wxPen_GetStyle cdecl alias "wxPen_GetStyle" (byval self as integer) as integer
declare function wxPen_Ok cdecl alias "wxPen_Ok" (byval self as integer) as integer
declare function wxPen_SetCap cdecl alias "wxPen_SetCap" (byval self as integer,byval capStyle as integer) as integer
declare function wxPen_SetJoin cdecl alias "wxPen_SetJoin" (byval self as integer,byval join_style as integer) as integer
declare function wxPen_SetStyle cdecl alias "wxPen_SetStyle" (byval self as integer,byval style as integer) as integer
declare function wxPageSetupDialogData_ctor cdecl alias "wxPageSetupDialogData_ctor" () as integer
declare function wxPageSetupDialogData_ctorPrintSetup cdecl alias "wxPageSetupDialogData_ctorPrintSetup" (byval dialogData as integer) as integer
declare function wxPageSetupDialogData_ctorPrintData cdecl alias "wxPageSetupDialogData_ctorPrintData" (byval printData as integer) as integer
declare function wxPageSetupDialogData_GetPaperSize cdecl alias "wxPageSetupDialogData_GetPaperSize" (byval self as integer,byval size as integer) as integer
declare function wxPageSetupDialogData_GetPaperId cdecl alias "wxPageSetupDialogData_GetPaperId" (byval self as integer) as integer
declare function wxPageSetupDialogData_GetMinMarginTopLeft cdecl alias "wxPageSetupDialogData_GetMinMarginTopLeft" (byval self as integer,byval pt as integer) as integer
declare function wxPageSetupDialogData_GetMinMarginBottomRight cdecl alias "wxPageSetupDialogData_GetMinMarginBottomRight" (byval self as integer,byval pt as integer) as integer
declare function wxPageSetupDialogData_GetMarginTopLeft cdecl alias "wxPageSetupDialogData_GetMarginTopLeft" (byval self as integer,byval pt as integer) as integer
declare function wxPageSetupDialogData_GetMarginBottomRight cdecl alias "wxPageSetupDialogData_GetMarginBottomRight" (byval self as integer,byval pt as integer) as integer
declare function wxPageSetupDialogData_GetDefaultMinMargins cdecl alias "wxPageSetupDialogData_GetDefaultMinMargins" (byval self as integer) as integer
declare function wxPageSetupDialogData_GetEnableMargins cdecl alias "wxPageSetupDialogData_GetEnableMargins" (byval self as integer) as integer
declare function wxPageSetupDialogData_GetEnableOrientation cdecl alias "wxPageSetupDialogData_GetEnableOrientation" (byval self as integer) as integer
declare function wxPageSetupDialogData_GetEnablePaper cdecl alias "wxPageSetupDialogData_GetEnablePaper" (byval self as integer) as integer
declare function wxPageSetupDialogData_GetEnablePrinter cdecl alias "wxPageSetupDialogData_GetEnablePrinter" (byval self as integer) as integer
declare function wxPageSetupDialogData_GetDefaultInfo cdecl alias "wxPageSetupDialogData_GetDefaultInfo" (byval self as integer) as integer
declare function wxPageSetupDialogData_GetEnableHelp cdecl alias "wxPageSetupDialogData_GetEnableHelp" (byval self as integer) as integer
declare function wxPageSetupDialogData_Ok cdecl alias "wxPageSetupDialogData_Ok" (byval self as integer) as integer
declare function wxPageSetupDialogData_SetPaperSizeSize cdecl alias "wxPageSetupDialogData_SetPaperSizeSize" (byval self as integer,byval sz as integer) as integer
declare function wxPageSetupDialogData_SetPaperId cdecl alias "wxPageSetupDialogData_SetPaperId" (byval self as integer,byval id as integer) as integer
declare function wxPageSetupDialogData_SetPaperSize cdecl alias "wxPageSetupDialogData_SetPaperSize" (byval self as integer,byval id as integer) as integer
declare function wxPageSetupDialogData_SetMinMarginTopLeft cdecl alias "wxPageSetupDialogData_SetMinMarginTopLeft" (byval self as integer,byval pt as integer) as integer
declare function wxPageSetupDialogData_SetMinMarginBottomRight cdecl alias "wxPageSetupDialogData_SetMinMarginBottomRight" (byval self as integer,byval pt as integer) as integer
declare function wxPageSetupDialogData_SetMarginTopLeft cdecl alias "wxPageSetupDialogData_SetMarginTopLeft" (byval self as integer,byval pt as integer) as integer
declare function wxPageSetupDialogData_SetMarginBottomRight cdecl alias "wxPageSetupDialogData_SetMarginBottomRight" (byval self as integer,byval pt as integer) as integer
declare function wxPageSetupDialogData_SetDefaultMinMargins cdecl alias "wxPageSetupDialogData_SetDefaultMinMargins" (byval self as integer,byval flag as integer) as integer
declare function wxPageSetupDialogData_SetDefaultInfo cdecl alias "wxPageSetupDialogData_SetDefaultInfo" (byval self as integer,byval flag as integer) as integer
declare function wxPageSetupDialogData_EnableMargins cdecl alias "wxPageSetupDialogData_EnableMargins" (byval self as integer,byval flag as integer) as integer
declare function wxPageSetupDialogData_EnableOrientation cdecl alias "wxPageSetupDialogData_EnableOrientation" (byval self as integer,byval flag as integer) as integer
declare function wxPageSetupDialogData_EnablePaper cdecl alias "wxPageSetupDialogData_EnablePaper" (byval self as integer,byval flag as integer) as integer
declare function wxPageSetupDialogData_EnablePrinter cdecl alias "wxPageSetupDialogData_EnablePrinter" (byval self as integer,byval flag as integer) as integer
declare function wxPageSetupDialogData_EnableHelp cdecl alias "wxPageSetupDialogData_EnableHelp" (byval self as integer,byval flag as integer) as integer
declare function wxPageSetupDialogData_CalculateIdFromPaperSize cdecl alias "wxPageSetupDialogData_CalculateIdFromPaperSize" (byval self as integer) as integer
declare function wxPageSetupDialogData_CalculatePaperSizeFromId cdecl alias "wxPageSetupDialogData_CalculatePaperSizeFromId" (byval self as integer) as integer
declare function wxPageSetupDialogData_GetPrintData cdecl alias "wxPageSetupDialogData_GetPrintData" (byval self as integer) as integer
declare function wxPageSetupDialogData_SetPrintData cdecl alias "wxPageSetupDialogData_SetPrintData" (byval self as integer,byval printData as integer) as integer
declare function wxPrintDialogData_ctor cdecl alias "wxPrintDialogData_ctor" () as integer
declare function wxPrintDialogData_ctorDialogData cdecl alias "wxPrintDialogData_ctorDialogData" (byval dialogData as integer) as integer
declare function wxPrintDialogData_ctorPrintData cdecl alias "wxPrintDialogData_ctorPrintData" (byval printData as integer) as integer
declare function wxPrintDialogData_GetFromPage cdecl alias "wxPrintDialogData_GetFromPage" (byval self as integer) as integer
declare function wxPrintDialogData_GetToPage cdecl alias "wxPrintDialogData_GetToPage" (byval self as integer) as integer
declare function wxPrintDialogData_GetMinPage cdecl alias "wxPrintDialogData_GetMinPage" (byval self as integer) as integer
declare function wxPrintDialogData_GetMaxPage cdecl alias "wxPrintDialogData_GetMaxPage" (byval self as integer) as integer
declare function wxPrintDialogData_GetNoCopies cdecl alias "wxPrintDialogData_GetNoCopies" (byval self as integer) as integer
declare function wxPrintDialogData_GetAllPages cdecl alias "wxPrintDialogData_GetAllPages" (byval self as integer) as integer
declare function wxPrintDialogData_GetSelection cdecl alias "wxPrintDialogData_GetSelection" (byval self as integer) as integer
declare function wxPrintDialogData_GetCollate cdecl alias "wxPrintDialogData_GetCollate" (byval self as integer) as integer
declare function wxPrintDialogData_GetPrintToFile cdecl alias "wxPrintDialogData_GetPrintToFile" (byval self as integer) as integer
declare function wxPrintDialogData_GetSetupDialog cdecl alias "wxPrintDialogData_GetSetupDialog" (byval self as integer) as integer
declare function wxPrintDialogData_SetFromPage cdecl alias "wxPrintDialogData_SetFromPage" (byval self as integer,byval v as integer) as integer
declare function wxPrintDialogData_SetToPage cdecl alias "wxPrintDialogData_SetToPage" (byval self as integer,byval v as integer) as integer
declare function wxPrintDialogData_SetMinPage cdecl alias "wxPrintDialogData_SetMinPage" (byval self as integer,byval v as integer) as integer
declare function wxPrintDialogData_SetMaxPage cdecl alias "wxPrintDialogData_SetMaxPage" (byval self as integer,byval v as integer) as integer
declare function wxPrintDialogData_SetNoCopies cdecl alias "wxPrintDialogData_SetNoCopies" (byval self as integer,byval v as integer) as integer
declare function wxPrintDialogData_SetAllPages cdecl alias "wxPrintDialogData_SetAllPages" (byval self as integer,byval flag as integer) as integer
declare function wxPrintDialogData_SetSelection cdecl alias "wxPrintDialogData_SetSelection" (byval self as integer,byval flag as integer) as integer
declare function wxPrintDialogData_SetCollate cdecl alias "wxPrintDialogData_SetCollate" (byval self as integer,byval flag as integer) as integer
declare function wxPrintDialogData_SetPrintToFile cdecl alias "wxPrintDialogData_SetPrintToFile" (byval self as integer,byval flag as integer) as integer
declare function wxPrintDialogData_SetSetupDialog cdecl alias "wxPrintDialogData_SetSetupDialog" (byval self as integer,byval flag as integer) as integer
declare function wxPrintDialogData_EnablePrintToFile cdecl alias "wxPrintDialogData_EnablePrintToFile" (byval self as integer,byval flag as integer) as integer
declare function wxPrintDialogData_EnableSelection cdecl alias "wxPrintDialogData_EnableSelection" (byval self as integer,byval flag as integer) as integer
declare function wxPrintDialogData_EnablePageNumbers cdecl alias "wxPrintDialogData_EnablePageNumbers" (byval self as integer,byval flag as integer) as integer
declare function wxPrintDialogData_EnableHelp cdecl alias "wxPrintDialogData_EnableHelp" (byval self as integer,byval flag as integer) as integer
declare function wxPrintDialogData_GetEnablePrintToFile cdecl alias "wxPrintDialogData_GetEnablePrintToFile" (byval self as integer) as integer
declare function wxPrintDialogData_GetEnableSelection cdecl alias "wxPrintDialogData_GetEnableSelection" (byval self as integer) as integer
declare function wxPrintDialogData_GetEnablePageNumbers cdecl alias "wxPrintDialogData_GetEnablePageNumbers" (byval self as integer) as integer
declare function wxPrintDialogData_GetEnableHelp cdecl alias "wxPrintDialogData_GetEnableHelp" (byval self as integer) as integer
declare function wxPrintDialogData_Ok cdecl alias "wxPrintDialogData_Ok" (byval self as integer) as integer
declare function wxPrintDialogData_GetPrintData cdecl alias "wxPrintDialogData_GetPrintData" (byval self as integer) as integer
declare function wxPrintDialogData_SetPrintData cdecl alias "wxPrintDialogData_SetPrintData" (byval self as integer,byval printData as integer) as integer
declare function wxPrintData_ctor cdecl alias "wxPrintData_ctor" () as integer
declare function wxPrintData_ctorPrintData cdecl alias "wxPrintData_ctorPrintData" (byval printData as integer) as integer
declare function wxPrintData_GetNoCopies cdecl alias "wxPrintData_GetNoCopies" (byval self as integer) as integer
declare function wxPrintData_GetCollate cdecl alias "wxPrintData_GetCollate" (byval self as integer) as integer
declare function wxPrintData_GetOrientation cdecl alias "wxPrintData_GetOrientation" (byval self as integer) as integer
declare function wxPrintData_Ok cdecl alias "wxPrintData_Ok" (byval self as integer) as integer
declare function wxPrintData_GetPrinterName cdecl alias "wxPrintData_GetPrinterName" (byval self as integer) as byte ptr
declare function wxPrintData_GetColour cdecl alias "wxPrintData_GetColour" (byval self as integer) as integer
declare function wxPrintData_GetDuplex cdecl alias "wxPrintData_GetDuplex" (byval self as integer) as integer
declare function wxPrintData_GetPaperId cdecl alias "wxPrintData_GetPaperId" (byval self as integer) as integer
declare function wxPrintData_GetPaperSize cdecl alias "wxPrintData_GetPaperSize" (byval self as integer,byval size as integer) as integer
declare function wxPrintData_GetQuality cdecl alias "wxPrintData_GetQuality" (byval self as integer) as integer
declare function wxPrintData_SetNoCopies cdecl alias "wxPrintData_SetNoCopies" (byval self as integer,byval v as integer) as integer
declare function wxPrintData_SetCollate cdecl alias "wxPrintData_SetCollate" (byval self as integer,byval flag as integer) as integer
declare function wxPrintData_SetOrientation cdecl alias "wxPrintData_SetOrientation" (byval self as integer,byval orient as integer) as integer
declare function wxPrintData_SetPrinterName cdecl alias "wxPrintData_SetPrinterName" (byval self as integer,byval name as string) as integer
declare function wxPrintData_SetColour cdecl alias "wxPrintData_SetColour" (byval self as integer,byval colour as integer) as integer
declare function wxPrintData_SetDuplex cdecl alias "wxPrintData_SetDuplex" (byval self as integer,byval duplex as integer) as integer
declare function wxPrintData_SetPaperId cdecl alias "wxPrintData_SetPaperId" (byval self as integer,byval sizeId as integer) as integer
declare function wxPrintData_SetPaperSize cdecl alias "wxPrintData_SetPaperSize" (byval self as integer,byval sz as integer) as integer
declare function wxPrintData_SetQuality cdecl alias "wxPrintData_SetQuality" (byval self as integer,byval quality as integer) as integer
declare function wxPrintData_GetPrinterCommand cdecl alias "wxPrintData_GetPrinterCommand" (byval self as integer) as byte ptr
declare function wxPrintData_GetPrinterOptions cdecl alias "wxPrintData_GetPrinterOptions" (byval self as integer) as byte ptr
declare function wxPrintData_GetPreviewCommand cdecl alias "wxPrintData_GetPreviewCommand" (byval self as integer) as byte ptr
declare function wxPrintData_GetFilename cdecl alias "wxPrintData_GetFilename" (byval self as integer) as byte ptr
declare function wxPrintData_GetFontMetricPath cdecl alias "wxPrintData_GetFontMetricPath" (byval self as integer) as byte ptr
declare function wxPrintData_GetPrinterScaleX cdecl alias "wxPrintData_GetPrinterScaleX" (byval self as integer) as integer
declare function wxPrintData_GetPrinterScaleY cdecl alias "wxPrintData_GetPrinterScaleY" (byval self as integer) as integer
declare function wxPrintData_GetPrinterTranslateX cdecl alias "wxPrintData_GetPrinterTranslateX" (byval self as integer) as integer
declare function wxPrintData_GetPrinterTranslateY cdecl alias "wxPrintData_GetPrinterTranslateY" (byval self as integer) as integer
declare function wxPrintData_GetPrintMode cdecl alias "wxPrintData_GetPrintMode" (byval self as integer) as integer
declare function wxPrintData_SetPrinterCommand cdecl alias "wxPrintData_SetPrinterCommand" (byval self as integer,byval command as string) as integer
declare function wxPrintData_SetPrinterOptions cdecl alias "wxPrintData_SetPrinterOptions" (byval self as integer,byval options as string) as integer
declare function wxPrintData_SetPreviewCommand cdecl alias "wxPrintData_SetPreviewCommand" (byval self as integer,byval command as string) as integer
declare function wxPrintData_SetFilename cdecl alias "wxPrintData_SetFilename" (byval self as integer,byval filename as string) as integer
declare function wxPrintData_SetFontMetricPath cdecl alias "wxPrintData_SetFontMetricPath" (byval self as integer,byval path as string) as integer
declare function wxPrintData_SetPrinterScaleX cdecl alias "wxPrintData_SetPrinterScaleX" (byval self as integer,byval x as integer) as integer
declare function wxPrintData_SetPrinterScaleY cdecl alias "wxPrintData_SetPrinterScaleY" (byval self as integer,byval y as integer) as integer
declare function wxPrintData_SetPrinterScaling cdecl alias "wxPrintData_SetPrinterScaling" (byval self as integer,byval x as integer,byval y as integer) as integer
declare function wxPrintData_SetPrinterTranslateX cdecl alias "wxPrintData_SetPrinterTranslateX" (byval self as integer,byval x as integer) as integer
declare function wxPrintData_SetPrinterTranslateY cdecl alias "wxPrintData_SetPrinterTranslateY" (byval self as integer,byval y as integer) as integer
declare function wxPrintData_SetPrinterTranslation cdecl alias "wxPrintData_SetPrinterTranslation" (byval self as integer,byval x as integer,byval y as integer) as integer
declare function wxPrintData_SetPrintMode cdecl alias "wxPrintData_SetPrintMode" (byval self as integer,byval printMode as integer) as integer
declare function wxPageSetupDialog_ctor cdecl alias "wxPageSetupDialog_ctor" (byval parent as integer,byval data as integer) as integer
declare function wxPageSetupDialog_GetPageSetupData cdecl alias "wxPageSetupDialog_GetPageSetupData" (byval self as integer) as integer
declare function wxPrintDialog_ctor cdecl alias "wxPrintDialog_ctor" (byval parent as integer,byval data as integer) as integer
declare function wxPrintDialog_ctorPrintData cdecl alias "wxPrintDialog_ctorPrintData" (byval parent as integer,byval data as integer) as integer
declare function wxPrintDialog_ShowModal cdecl alias "wxPrintDialog_ShowModal" (byval self as integer) as integer
declare function wxPrintDialog_GetPrintData cdecl alias "wxPrintDialog_GetPrintData" (byval self as integer) as integer
declare function wxPrintDialog_GetPrintDialogData cdecl alias "wxPrintDialog_GetPrintDialogData" (byval self as integer) as integer
declare function wxPrintDialog_GetPrintDC cdecl alias "wxPrintDialog_GetPrintDC" (byval self as integer) as integer
declare function wxPrinter_ctor cdecl alias "wxPrinter_ctor" (byval data as integer) as integer
declare function wxPrinter_CreateAbortWindow cdecl alias "wxPrinter_CreateAbortWindow" (byval self as integer,byval parent as integer,byval printout as integer) as integer
declare function wxPrinter_ReportError cdecl alias "wxPrinter_ReportError" (byval self as integer,byval parent as integer,byval printout as integer,byval message as string) as integer
declare function wxPrinter_GetPrintDialogData cdecl alias "wxPrinter_GetPrintDialogData" (byval self as integer) as integer
declare function wxPrinter_GetAbort cdecl alias "wxPrinter_GetAbort" (byval self as integer) as integer
declare function wxPrinter_GetLastError cdecl alias "wxPrinter_GetLastError" (byval self as integer) as integer
declare function wxPrinter_Setup cdecl alias "wxPrinter_Setup" (byval self as integer,byval parent as integer) as integer
declare function wxPrinter_Print cdecl alias "wxPrinter_Print" (byval self as integer,byval parent as integer,byval printout as integer,byval prompt as integer) as integer
declare function wxPrinter_PrintDialog cdecl alias "wxPrinter_PrintDialog" (byval self as integer,byval parent as integer) as integer
declare function wxPrintout_ctor cdecl alias "wxPrintout_ctor" (byval title as string) as integer
declare function wxPrintout_RegisterVirtual cdecl alias "wxPrintout_RegisterVirtual" (byval self as integer,byval onBeginDocument as integer,byval onEndDocument as integer,byval onBeginPrinting as integer,byval onEndPrinting as integer,byval onPreparePrinting as integer,byval hasPage as integer,byval onPrintPage as integer,byval getPageInfo as integer) as integer
declare function wxPrintout_OnBeginDocument cdecl alias "wxPrintout_OnBeginDocument" (byval self as integer,byval startPage as integer,byval endPage as integer) as integer
declare function wxPrintout_OnEndDocument cdecl alias "wxPrintout_OnEndDocument" (byval self as integer) as integer
declare function wxPrintout_OnBeginPrinting cdecl alias "wxPrintout_OnBeginPrinting" (byval self as integer) as integer
declare function wxPrintout_OnEndPrinting cdecl alias "wxPrintout_OnEndPrinting" (byval self as integer) as integer
declare function wxPrintout_OnPreparePrinting cdecl alias "wxPrintout_OnPreparePrinting" (byval self as integer) as integer
declare function wxPrintout_HasPage cdecl alias "wxPrintout_HasPage" (byval self as integer,byval page as integer) as integer
declare function wxPrintout_GetPageInfo cdecl alias "wxPrintout_GetPageInfo" (byval self as integer,byval minPage as integer,byval maxPage as integer,byval pageFrom as integer,byval pageTo as integer) as integer
declare function wxPrintout_GetTitle cdecl alias "wxPrintout_GetTitle" (byval self as integer) as byte ptr
declare function wxPrintout_GetDC cdecl alias "wxPrintout_GetDC" (byval self as integer) as integer
declare function wxPrintout_SetDC cdecl alias "wxPrintout_SetDC" (byval self as integer,byval dc as integer) as integer
declare function wxPrintout_SetPageSizePixels cdecl alias "wxPrintout_SetPageSizePixels" (byval self as integer,byval w as integer,byval h as integer) as integer
declare function wxPrintout_GetPageSizePixels cdecl alias "wxPrintout_GetPageSizePixels" (byval self as integer,byval w as integer,byval h as integer) as integer
declare function wxPrintout_SetPageSizeMM cdecl alias "wxPrintout_SetPageSizeMM" (byval self as integer,byval w as integer,byval h as integer) as integer
declare function wxPrintout_GetPageSizeMM cdecl alias "wxPrintout_GetPageSizeMM" (byval self as integer,byval w as integer,byval h as integer) as integer
declare function wxPrintout_SetPPIScreen cdecl alias "wxPrintout_SetPPIScreen" (byval self as integer,byval x as integer,byval y as integer) as integer
declare function wxPrintout_GetPPIScreen cdecl alias "wxPrintout_GetPPIScreen" (byval self as integer,byval x as integer,byval y as integer) as integer
declare function wxPrintout_SetPPIPrinter cdecl alias "wxPrintout_SetPPIPrinter" (byval self as integer,byval x as integer,byval y as integer) as integer
declare function wxPrintout_GetPPIPrinter cdecl alias "wxPrintout_GetPPIPrinter" (byval self as integer,byval x as integer,byval y as integer) as integer
declare function wxPrintout_IsPreview cdecl alias "wxPrintout_IsPreview" (byval self as integer) as integer
declare function wxPrintout_SetIsPreview cdecl alias "wxPrintout_SetIsPreview" (byval self as integer,byval p as integer) as integer
declare function wxPrintPreview_ctor cdecl alias "wxPrintPreview_ctor" (byval printout as integer,byval printoutForPrinting as integer,byval data as integer) as integer
declare function wxPrintPreview_ctorPrintData cdecl alias "wxPrintPreview_ctorPrintData" (byval printout as integer,byval printoutForPrinting as integer,byval data as integer) as integer
declare function wxPrintPreview_SetCurrentPage cdecl alias "wxPrintPreview_SetCurrentPage" (byval self as integer,byval pageNum as integer) as integer
declare function wxPrintPreview_GetCurrentPage cdecl alias "wxPrintPreview_GetCurrentPage" (byval self as integer) as integer
declare function wxPrintPreview_SetPrintout cdecl alias "wxPrintPreview_SetPrintout" (byval self as integer,byval printout as integer) as integer
declare function wxPrintPreview_GetPrintout cdecl alias "wxPrintPreview_GetPrintout" (byval self as integer) as integer
declare function wxPrintPreview_GetPrintoutForPrinting cdecl alias "wxPrintPreview_GetPrintoutForPrinting" (byval self as integer) as integer
declare function wxPrintPreview_SetFrame cdecl alias "wxPrintPreview_SetFrame" (byval self as integer,byval frame as integer) as integer
declare function wxPrintPreview_SetCanvas cdecl alias "wxPrintPreview_SetCanvas" (byval self as integer,byval canvas as integer) as integer
declare function wxPrintPreview_GetFrame cdecl alias "wxPrintPreview_GetFrame" (byval self as integer) as integer
declare function wxPrintPreview_GetCanvas cdecl alias "wxPrintPreview_GetCanvas" (byval self as integer) as integer
declare function wxPrintPreview_PaintPage cdecl alias "wxPrintPreview_PaintPage" (byval self as integer,byval canvas as integer,byval dc as integer) as integer
declare function wxPrintPreview_DrawBlankPage cdecl alias "wxPrintPreview_DrawBlankPage" (byval self as integer,byval canvas as integer,byval dc as integer) as integer
declare function wxPrintPreview_RenderPage cdecl alias "wxPrintPreview_RenderPage" (byval self as integer,byval pageNum as integer) as integer
declare function wxPrintPreview_GetPrintDialogData cdecl alias "wxPrintPreview_GetPrintDialogData" (byval self as integer) as integer
declare function wxPrintPreview_SetZoom cdecl alias "wxPrintPreview_SetZoom" (byval self as integer,byval percent as integer) as integer
declare function wxPrintPreview_GetZoom cdecl alias "wxPrintPreview_GetZoom" (byval self as integer) as integer
declare function wxPrintPreview_GetMaxPage cdecl alias "wxPrintPreview_GetMaxPage" (byval self as integer) as integer
declare function wxPrintPreview_GetMinPage cdecl alias "wxPrintPreview_GetMinPage" (byval self as integer) as integer
declare function wxPrintPreview_Ok cdecl alias "wxPrintPreview_Ok" (byval self as integer) as integer
declare function wxPrintPreview_SetOk cdecl alias "wxPrintPreview_SetOk" (byval self as integer,byval ok as integer) as integer
declare function wxPrintPreview_Print cdecl alias "wxPrintPreview_Print" (byval self as integer,byval interactive as integer) as integer
declare function wxPrintPreview_DetermineScaling cdecl alias "wxPrintPreview_DetermineScaling" (byval self as integer) as integer
declare function wxPreviewFrame_ctor cdecl alias "wxPreviewFrame_ctor" (byval preview as integer,byval parent as integer,byval title as string,byval pos as integer,byval size as integer,byval style as integer,byval name as string) as integer
declare function wxPreviewFrame_Initialize cdecl alias "wxPreviewFrame_Initialize" (byval self as integer) as integer
declare function wxPreviewFrame_CreateCanvas cdecl alias "wxPreviewFrame_CreateCanvas" (byval self as integer) as integer
declare function wxPreviewFrame_CreateControlBar cdecl alias "wxPreviewFrame_CreateControlBar" (byval self as integer) as integer
declare function wxPreviewCanvas_ctor cdecl alias "wxPreviewCanvas_ctor" (byval preview as integer,byval parent as integer,byval pos as integer,byval size as integer,byval style as integer,byval name as string) as integer
declare function wxProgressDialog_ctor cdecl alias "wxProgressDialog_ctor" (byval title as string,byval message as string,byval maximum as integer,byval parent as integer,byval style as integer) as integer
declare function wxProgressDialog_dtor cdecl alias "wxProgressDialog_dtor" (byval self as integer) as integer
declare function wxProgressDialog_Update cdecl alias "wxProgressDialog_Update" (byval self as integer,byval value as integer,byval newmsg as string) as integer
declare function wxProgressDialog_Resume cdecl alias "wxProgressDialog_Resume" (byval self as integer) as integer
declare function wxProgressDialog_Show cdecl alias "wxProgressDialog_Show" (byval self as integer,byval show as integer) as integer
declare function wxQueryNewPaletteEvent_ctor cdecl alias "wxQueryNewPaletteEvent_ctor" (byval type as integer) as integer
declare function wxQueryNewPaletteEvent_GetPaletteRealized cdecl alias "wxQueryNewPaletteEvent_GetPaletteRealized" (byval self as integer) as integer
declare function wxQueryNewPaletteEvent_SetPaletteRelized cdecl alias "wxQueryNewPaletteEvent_SetPaletteRelized" (byval self as integer,byval realized as integer) as integer
declare function wxRadioBox_ctor cdecl alias "wxRadioBox_ctor" () as integer
declare function wxRadioBox_Create cdecl alias "wxRadioBox_Create" (byval self as integer,byval parent as integer,byval id as integer,byval label as string,byval pos as integer,byval size as integer,byval n as integer,byval choices as byte ptr ptr,byval majorDimension as integer,byval style as long,byval val as integer,byval name as string) as integer
declare function wxRadioBox_SetSelection cdecl alias "wxRadioBox_SetSelection" (byval self as integer,byval n as integer) as integer
declare function wxRadioBox_GetSelection cdecl alias "wxRadioBox_GetSelection" (byval self as integer) as integer
declare function wxRadioBox_GetStringSelection cdecl alias "wxRadioBox_GetStringSelection" (byval self as integer) as byte ptr
declare function wxRadioBox_SetStringSelection cdecl alias "wxRadioBox_SetStringSelection" (byval self as integer,byval s as string) as integer
declare function wxRadioBox_GetCount cdecl alias "wxRadioBox_GetCount" (byval self as integer) as integer
declare function wxRadioBox_FindString cdecl alias "wxRadioBox_FindString" (byval self as integer,byval s as string) as integer
declare function wxRadioBox_GetString cdecl alias "wxRadioBox_GetString" (byval self as integer,byval n as integer) as byte ptr
declare function wxRadioBox_SetString cdecl alias "wxRadioBox_SetString" (byval self as integer,byval n as integer,byval label as string) as integer
declare function wxRadioBox_Enable cdecl alias "wxRadioBox_Enable" (byval self as integer,byval n as integer,byval enable as integer) as integer
declare function wxRadioBox_Show cdecl alias "wxRadioBox_Show" (byval self as integer,byval n as integer,byval show as integer) as integer
declare function wxRadioBox_GetLabel cdecl alias "wxRadioBox_GetLabel" (byval self as integer) as byte ptr
declare function wxRadioBox_SetLabel cdecl alias "wxRadioBox_SetLabel" (byval self as integer,byval label as string) as integer
declare function wxRadioButton_ctor cdecl alias "wxRadioButton_ctor" () as integer
declare function wxRadioButton_Create cdecl alias "wxRadioButton_Create" (byval self as integer,byval parent as integer,byval id as integer,byval label as string,byval pos as integer,byval size as integer,byval style as integer,byval val as integer,byval name as string) as integer
declare function wxRadioButton_GetValue cdecl alias "wxRadioButton_GetValue" (byval self as integer) as integer
declare function wxRadioButton_SetValue cdecl alias "wxRadioButton_SetValue" (byval self as integer,byval state as integer) as integer
declare function wxRegion_ctor cdecl alias "wxRegion_ctor" () as integer
declare function wxRegion_ctorByCoords cdecl alias "wxRegion_ctorByCoords" (byval x as integer,byval y as integer,byval w as integer,byval h as integer) as integer
declare function wxRegion_ctorByCorners cdecl alias "wxRegion_ctorByCorners" (byval topLeft as integer,byval bottomRight as integer) as integer
declare function wxRegion_ctorByRect cdecl alias "wxRegion_ctorByRect" (byval rect as integer) as integer
declare function wxRegion_ctorByBitmap cdecl alias "wxRegion_ctorByBitmap" (byval bmp as integer,byval transColour as integer,byval tolerance as integer) as integer
declare function wxRegion_ctorByRegion cdecl alias "wxRegion_ctorByRegion" (byval region as integer) as integer
declare function wxRegion_dtor cdecl alias "wxRegion_dtor" (byval self as integer) as integer
declare function wxRegion_Clear cdecl alias "wxRegion_Clear" (byval self as integer) as integer
declare function wxRegion_Union cdecl alias "wxRegion_Union" (byval self as integer,byval x as integer,byval y as integer,byval width as integer,byval height as integer) as integer
declare function wxRegion_UnionRect cdecl alias "wxRegion_UnionRect" (byval self as integer,byval rect as integer) as integer
declare function wxRegion_UnionRegion cdecl alias "wxRegion_UnionRegion" (byval self as integer,byval region as integer) as integer
declare function wxRegion_Intersect cdecl alias "wxRegion_Intersect" (byval self as integer,byval x as integer,byval y as integer,byval width as integer,byval height as integer) as integer
declare function wxRegion_IntersectRect cdecl alias "wxRegion_IntersectRect" (byval self as integer,byval rect as integer) as integer
declare function wxRegion_IntersectRegion cdecl alias "wxRegion_IntersectRegion" (byval self as integer,byval region as integer) as integer
declare function wxRegion_Subtract cdecl alias "wxRegion_Subtract" (byval self as integer,byval x as integer,byval y as integer,byval width as integer,byval height as integer) as integer
declare function wxRegion_SubtractRect cdecl alias "wxRegion_SubtractRect" (byval self as integer,byval rect as integer) as integer
declare function wxRegion_SubtractRegion cdecl alias "wxRegion_SubtractRegion" (byval self as integer,byval region as integer) as integer
declare function wxRegion_Xor cdecl alias "wxRegion_Xor" (byval self as integer,byval x as integer,byval y as integer,byval width as integer,byval height as integer) as integer
declare function wxRegion_XorRect cdecl alias "wxRegion_XorRect" (byval self as integer,byval rect as integer) as integer
declare function wxRegion_XorRegion cdecl alias "wxRegion_XorRegion" (byval self as integer,byval region as integer) as integer
declare function wxRegion_ContainsCoords cdecl alias "wxRegion_ContainsCoords" (byval self as integer,byval x as integer,byval y as integer) as integer
declare function wxRegion_ContainsPoint cdecl alias "wxRegion_ContainsPoint" (byval self as integer,byval pt as integer) as integer
declare function wxRegion_ContainsRectCoords cdecl alias "wxRegion_ContainsRectCoords" (byval self as integer,byval x as integer,byval y as integer,byval width as integer,byval height as integer) as integer
declare function wxRegion_ContainsRect cdecl alias "wxRegion_ContainsRect" (byval self as integer,byval rect as integer) as integer
declare function wxRegion_GetBox cdecl alias "wxRegion_GetBox" (byval self as integer,byval rect as integer) as integer
declare function wxRegion_IsEmpty cdecl alias "wxRegion_IsEmpty" (byval self as integer) as integer
declare function wxRegion_ConvertToBitmap cdecl alias "wxRegion_ConvertToBitmap" (byval self as integer) as integer
declare function wxRegion_UnionBitmap cdecl alias "wxRegion_UnionBitmap" (byval self as integer,byval bmp as integer,byval transColour as integer,byval tolerance as integer) as integer
declare function wxRegionIterator_ctor cdecl alias "wxRegionIterator_ctor" () as integer
declare function wxRegionIterator_ctorByRegion cdecl alias "wxRegionIterator_ctorByRegion" (byval region as integer) as integer
declare function wxRegionIterator_Reset cdecl alias "wxRegionIterator_Reset" (byval self as integer) as integer
declare function wxRegionIterator_ResetToRegion cdecl alias "wxRegionIterator_ResetToRegion" (byval self as integer,byval region as integer) as integer
declare function wxRegionIterator_HaveRects cdecl alias "wxRegionIterator_HaveRects" (byval self as integer) as integer
declare function wxRegionIterator_GetX cdecl alias "wxRegionIterator_GetX" (byval self as integer) as integer
declare function wxRegionIterator_GetY cdecl alias "wxRegionIterator_GetY" (byval self as integer) as integer
declare function wxRegionIterator_GetW cdecl alias "wxRegionIterator_GetW" (byval self as integer) as integer
declare function wxRegionIterator_GetWidth cdecl alias "wxRegionIterator_GetWidth" (byval self as integer) as integer
declare function wxRegionIterator_GetH cdecl alias "wxRegionIterator_GetH" (byval self as integer) as integer
declare function wxRegionIterator_GetHeight cdecl alias "wxRegionIterator_GetHeight" (byval self as integer) as integer
declare function wxRegionIterator_GetRect cdecl alias "wxRegionIterator_GetRect" (byval self as integer,byval rect as integer) as integer
declare function wxSashEdge_ctor cdecl alias "wxSashEdge_ctor" () as integer
declare function wxSashEdge_dtor cdecl alias "wxSashEdge_dtor" (byval self as integer) as integer
declare function wxSashEdge_m_show cdecl alias "wxSashEdge_m_show" (byval self as integer) as integer
declare function wxSashEdge_m_border cdecl alias "wxSashEdge_m_border" (byval self as integer) as integer
declare function wxSashEdge_m_margin cdecl alias "wxSashEdge_m_margin" (byval self as integer) as integer
declare function wxSashWindow_ctor cdecl alias "wxSashWindow_ctor" () as integer
declare function wxSashWindow_Create cdecl alias "wxSashWindow_Create" (byval self as integer,byval parent as integer,byval id as integer,byval pos as integer,byval size as integer,byval style as integer,byval name as string) as integer
declare function wxSashWindow_SetSashVisible cdecl alias "wxSashWindow_SetSashVisible" (byval self as integer,byval edge as integer,byval sash as integer) as integer
declare function wxSashWindow_GetSashVisible cdecl alias "wxSashWindow_GetSashVisible" (byval self as integer,byval edge as integer) as integer
declare function wxSashWindow_SetSashBorder cdecl alias "wxSashWindow_SetSashBorder" (byval self as integer,byval edge as integer,byval border as integer) as integer
declare function wxSashWindow_HasBorder cdecl alias "wxSashWindow_HasBorder" (byval self as integer,byval edge as integer) as integer
declare function wxSashWindow_GetEdgeMargin cdecl alias "wxSashWindow_GetEdgeMargin" (byval self as integer,byval edge as integer) as integer
declare function wxSashWindow_SetDefaultBorderSize cdecl alias "wxSashWindow_SetDefaultBorderSize" (byval self as integer,byval with as integer) as integer
declare function wxSashWindow_GetDefaultBorderSize cdecl alias "wxSashWindow_GetDefaultBorderSize" (byval self as integer) as integer
declare function wxSashWindow_SetExtraBorderSize cdecl alias "wxSashWindow_SetExtraBorderSize" (byval self as integer,byval width as integer) as integer
declare function wxSashWindow_GetExtraBorderSize cdecl alias "wxSashWindow_GetExtraBorderSize" (byval self as integer) as integer
declare function wxSashWindow_SetMinimumSizeX cdecl alias "wxSashWindow_SetMinimumSizeX" (byval self as integer,byval min as integer) as integer
declare function wxSashWindow_SetMinimumSizeY cdecl alias "wxSashWindow_SetMinimumSizeY" (byval self as integer,byval min as integer) as integer
declare function wxSashWindow_GetMinimumSizeX cdecl alias "wxSashWindow_GetMinimumSizeX" (byval self as integer) as integer
declare function wxSashWindow_GetMinimumSizeY cdecl alias "wxSashWindow_GetMinimumSizeY" (byval self as integer) as integer
declare function wxSashWindow_SetMaximumSizeX cdecl alias "wxSashWindow_SetMaximumSizeX" (byval self as integer,byval max as integer) as integer
declare function wxSashWindow_SetMaximumSizeY cdecl alias "wxSashWindow_SetMaximumSizeY" (byval self as integer,byval max as integer) as integer
declare function wxSashWindow_GetMaximumSizeX cdecl alias "wxSashWindow_GetMaximumSizeX" (byval self as integer) as integer
declare function wxSashWindow_GetMaximumSizeY cdecl alias "wxSashWindow_GetMaximumSizeY" (byval self as integer) as integer
declare function wxSashEvent_ctor cdecl alias "wxSashEvent_ctor" (byval id as integer,byval edge as integer) as integer
declare function wxSashEvent_SetEdge cdecl alias "wxSashEvent_SetEdge" (byval self as integer,byval edge as integer) as integer
declare function wxSashEvent_GetEdge cdecl alias "wxSashEvent_GetEdge" (byval self as integer) as integer
declare function wxSashEvent_SetDragRect cdecl alias "wxSashEvent_SetDragRect" (byval self as integer,byval rect as integer) as integer
declare function wxSashEvent_GetDragRect cdecl alias "wxSashEvent_GetDragRect" (byval self as integer,byval rect as integer) as integer
declare function wxSashEvent_SetDragStatus cdecl alias "wxSashEvent_SetDragStatus" (byval self as integer,byval status as integer) as integer
declare function wxSashEvent_GetDragStatus cdecl alias "wxSashEvent_GetDragStatus" (byval self as integer) as integer
declare function wxScrollBar_ctor cdecl alias "wxScrollBar_ctor" () as integer
declare function wxScrollBar_Create cdecl alias "wxScrollBar_Create" (byval self as integer,byval parent as integer,byval id as integer,byval pos as integer,byval size as integer,byval style as integer,byval validator as integer,byval name as string) as integer
declare function wxScrollBar_GetThumbPosition cdecl alias "wxScrollBar_GetThumbPosition" (byval self as integer) as integer
declare function wxScrollBar_GetThumbSize cdecl alias "wxScrollBar_GetThumbSize" (byval self as integer) as integer
declare function wxScrollBar_GetPageSize cdecl alias "wxScrollBar_GetPageSize" (byval self as integer) as integer
declare function wxScrollBar_GetRange cdecl alias "wxScrollBar_GetRange" (byval self as integer) as integer
declare function wxScrollBar_IsVertical cdecl alias "wxScrollBar_IsVertical" (byval self as integer) as integer
declare function wxScrollBar_SetThumbPosition cdecl alias "wxScrollBar_SetThumbPosition" (byval self as integer,byval viewStart as integer) as integer
declare function wxScrollBar_SetScrollbar cdecl alias "wxScrollBar_SetScrollbar" (byval self as integer,byval position as integer,byval thumbSize as integer,byval range as integer,byval pageSize as integer,byval refresh as integer) as integer
declare function wxScrollWnd_ctor cdecl alias "wxScrollWnd_ctor" (byval parent as integer,byval id as integer,byval pos as integer,byval size as integer,byval style as long,byval name as string) as integer
declare function wxScrollWnd_PrepareDC cdecl alias "wxScrollWnd_PrepareDC" (byval self as integer,byval dc as integer) as integer
declare function wxScrollWnd_SetScrollbars cdecl alias "wxScrollWnd_SetScrollbars" (byval self as integer,byval pixelsPerUnitX as integer,byval pixelsPerUnitY as integer,byval noUnitsX as integer,byval noUnitsY as integer,byval xPos as integer,byval yPos as integer,byval noRefresh as integer) as integer
declare function wxScrollWnd_GetViewStart cdecl alias "wxScrollWnd_GetViewStart" (byval self as integer,byval x as integer,byval y as integer) as integer
declare function wxScrollWnd_GetScrollPixelsPerUnit cdecl alias "wxScrollWnd_GetScrollPixelsPerUnit" (byval self as integer,byval xUnit as integer,byval yUnit as integer) as integer
declare function wxScrollWnd_CalcScrolledPosition cdecl alias "wxScrollWnd_CalcScrolledPosition" (byval self as integer,byval x as integer,byval y as integer,byval xx as integer,byval yy as integer) as integer
declare function wxScrollWnd_CalcUnscrolledPosition cdecl alias "wxScrollWnd_CalcUnscrolledPosition" (byval self as integer,byval x as integer,byval y as integer,byval xx as integer,byval yy as integer) as integer
declare function wxScrollWnd_GetVirtualSize cdecl alias "wxScrollWnd_GetVirtualSize" (byval self as integer,byval x as integer,byval y as integer) as integer
declare function wxScrollWnd_Scroll cdecl alias "wxScrollWnd_Scroll" (byval self as integer,byval x as integer,byval y as integer) as integer
declare function wxScrollWnd_SetScrollRate cdecl alias "wxScrollWnd_SetScrollRate" (byval self as integer,byval xstep as integer,byval ystep as integer) as integer
declare function wxScrollWnd_SetTargetWindow cdecl alias "wxScrollWnd_SetTargetWindow" (byval self as integer,byval window as integer) as integer
declare function wxSetCursorEvent_ctor cdecl alias "wxSetCursorEvent_ctor" (byval type as integer) as integer
declare function wxSetCursorEvent_GetX cdecl alias "wxSetCursorEvent_GetX" (byval self as integer) as integer
declare function wxSetCursorEvent_GetY cdecl alias "wxSetCursorEvent_GetY" (byval self as integer) as integer
declare function wxSetCursorEvent_SetCursor cdecl alias "wxSetCursorEvent_SetCursor" (byval self as integer,byval cursor as integer) as integer
declare function wxSetCursorEvent_GetCursor cdecl alias "wxSetCursorEvent_GetCursor" (byval self as integer) as integer
declare function wxSetCursorEvent_HasCursor cdecl alias "wxSetCursorEvent_HasCursor" (byval self as integer) as integer
declare function wxShowEvent_ctor cdecl alias "wxShowEvent_ctor" (byval type as integer) as integer
declare function wxShowEvent_GetShow cdecl alias "wxShowEvent_GetShow" (byval self as integer) as integer
declare function wxShowEvent_SetShow cdecl alias "wxShowEvent_SetShow" (byval self as integer,byval show as integer) as integer
declare function wxSizeEvent_ctor cdecl alias "wxSizeEvent_ctor" () as integer
declare function wxSizeEvent_GetSize cdecl alias "wxSizeEvent_GetSize" (byval self as integer,byval size as integer) as integer
declare function wxSizer_AddWindow cdecl alias "wxSizer_AddWindow" (byval self as integer,byval window as integer,byval proportion as integer,byval flag as integer,byval border as integer,byval userData as integer) as integer
declare function wxSizer_AddSizer cdecl alias "wxSizer_AddSizer" (byval self as integer,byval sizer as integer,byval proportion as integer,byval flag as integer,byval border as integer,byval userData as integer) as integer
declare function wxSizer_Add cdecl alias "wxSizer_Add" (byval self as integer,byval width as integer,byval height as integer,byval proportion as integer,byval flag as integer,byval border as integer,byval userData as integer) as integer
declare function wxSizer_Fit cdecl alias "wxSizer_Fit" (byval self as integer,byval window as integer,byval size as integer) as integer
declare function wxSizer_FitInside cdecl alias "wxSizer_FitInside" (byval self as integer,byval window as integer) as integer
declare function wxSizer_InsertWindow cdecl alias "wxSizer_InsertWindow" (byval self as integer,byval before as integer,byval window as integer,byval option as integer,byval flag as integer,byval border as integer,byval userData as integer) as integer
declare function wxSizer_InsertSizer cdecl alias "wxSizer_InsertSizer" (byval self as integer,byval before as integer,byval sizer as integer,byval option as integer,byval flag as integer,byval border as integer,byval userData as integer) as integer
declare function wxSizer_Insert cdecl alias "wxSizer_Insert" (byval self as integer,byval before as integer,byval width as integer,byval height as integer,byval option as integer,byval flag as integer,byval border as integer,byval userData as integer) as integer
declare function wxSizer_PrependWindow cdecl alias "wxSizer_PrependWindow" (byval self as integer,byval window as integer,byval option as integer,byval flag as integer,byval border as integer,byval userData as integer) as integer
declare function wxSizer_PrependSizer cdecl alias "wxSizer_PrependSizer" (byval self as integer,byval sizer as integer,byval option as integer,byval flag as integer,byval border as integer,byval userData as integer) as integer
declare function wxSizer_Prepend cdecl alias "wxSizer_Prepend" (byval self as integer,byval width as integer,byval height as integer,byval option as integer,byval flag as integer,byval border as integer,byval userData as integer) as integer
declare function wxSizer_RemoveWindow cdecl alias "wxSizer_RemoveWindow" (byval self as integer,byval window as integer) as integer
declare function wxSizer_RemoveSizer cdecl alias "wxSizer_RemoveSizer" (byval self as integer,byval sizer as integer) as integer
declare function wxSizer_Remove cdecl alias "wxSizer_Remove" (byval self as integer,byval pos as integer) as integer
declare function wxSizer_Clear cdecl alias "wxSizer_Clear" (byval self as integer,byval delete_windows as integer) as integer
declare function wxSizer_DeleteWindows cdecl alias "wxSizer_DeleteWindows" (byval self as integer) as integer
declare function wxSizer_SetMinSize cdecl alias "wxSizer_SetMinSize" (byval self as integer,byval size as integer) as integer
declare function wxSizer_SetItemMinSizeWindow cdecl alias "wxSizer_SetItemMinSizeWindow" (byval self as integer,byval window as integer,byval size as integer) as integer
declare function wxSizer_SetItemMinSizeSizer cdecl alias "wxSizer_SetItemMinSizeSizer" (byval self as integer,byval sizer as integer,byval size as integer) as integer
declare function wxSizer_SetItemMinSize cdecl alias "wxSizer_SetItemMinSize" (byval self as integer,byval pos as integer,byval size as integer) as integer
declare function wxSizer_GetSize cdecl alias "wxSizer_GetSize" (byval self as integer,byval size as integer) as integer
declare function wxSizer_GetPosition cdecl alias "wxSizer_GetPosition" (byval self as integer,byval pt as integer) as integer
declare function wxSizer_GetMinSize cdecl alias "wxSizer_GetMinSize" (byval self as integer,byval size as integer) as integer
declare function wxSizer_RecalcSizes cdecl alias "wxSizer_RecalcSizes" (byval self as integer) as integer
declare function wxSizer_CalcMin cdecl alias "wxSizer_CalcMin" (byval self as integer,byval size as integer) as integer
declare function wxSizer_Layout cdecl alias "wxSizer_Layout" (byval self as integer) as integer
declare function wxSizer_SetSizeHints cdecl alias "wxSizer_SetSizeHints" (byval self as integer,byval window as integer) as integer
declare function wxSizer_SetVirtualSizeHints cdecl alias "wxSizer_SetVirtualSizeHints" (byval self as integer,byval window as integer) as integer
declare function wxSizer_SetDimension cdecl alias "wxSizer_SetDimension" (byval self as integer,byval x as integer,byval y as integer,byval width as integer,byval height as integer) as integer
declare function wxSizer_ShowWindow cdecl alias "wxSizer_ShowWindow" (byval self as integer,byval window as integer,byval show as integer) as integer
declare function wxSizer_HideWindow cdecl alias "wxSizer_HideWindow" (byval self as integer,byval window as integer) as integer
declare function wxSizer_ShowSizer cdecl alias "wxSizer_ShowSizer" (byval self as integer,byval sizer as integer,byval show as integer) as integer
declare function wxSizer_HideSizer cdecl alias "wxSizer_HideSizer" (byval self as integer,byval sizer as integer) as integer
declare function wxSizer_IsShownWindow cdecl alias "wxSizer_IsShownWindow" (byval self as integer,byval window as integer) as integer
declare function wxSizer_IsShownSizer cdecl alias "wxSizer_IsShownSizer" (byval self as integer,byval sizer as integer) as integer
declare function wxSizer_Detach cdecl alias "wxSizer_Detach" (byval self as integer,byval window as integer) as integer
declare function wxSizer_Detach2 cdecl alias "wxSizer_Detach2" (byval self as integer,byval sizer as integer) as integer
declare function wxSizer_Detach3 cdecl alias "wxSizer_Detach3" (byval self as integer,byval index as integer) as integer
declare function wxSizerItem_ctorSpace cdecl alias "wxSizerItem_ctorSpace" (byval width as integer,byval height as integer,byval proportion as integer,byval flag as integer,byval border as integer,byval userData as integer) as integer
declare function wxSizerItem_ctorWindow cdecl alias "wxSizerItem_ctorWindow" (byval window as integer,byval proportion as integer,byval flag as integer,byval border as integer,byval userData as integer) as integer
declare function wxSizerItem_ctorSizer cdecl alias "wxSizerItem_ctorSizer" (byval sizer as integer,byval proportion as integer,byval flag as integer,byval border as integer,byval userData as integer) as integer
declare function wxSizerItem_ctor cdecl alias "wxSizerItem_ctor" () as integer
declare function wxSizerItem_DeleteWindows cdecl alias "wxSizerItem_DeleteWindows" (byval self as integer) as integer
declare function wxSizerItem_DetachSizer cdecl alias "wxSizerItem_DetachSizer" (byval self as integer) as integer
declare function wxSizerItem_GetSize cdecl alias "wxSizerItem_GetSize" (byval self as integer,byval size as integer) as integer
declare function wxSizerItem_CalcMin cdecl alias "wxSizerItem_CalcMin" (byval self as integer,byval min as integer) as integer
declare function wxSizerItem_SetDimension cdecl alias "wxSizerItem_SetDimension" (byval self as integer,byval pos as integer,byval size as integer) as integer
declare function wxSizerItem_GetMinSize cdecl alias "wxSizerItem_GetMinSize" (byval self as integer,byval size as integer) as integer
declare function wxSizerItem_SetInitSize cdecl alias "wxSizerItem_SetInitSize" (byval self as integer,byval x as integer,byval y as integer) as integer
declare function wxSizerItem_SetRatio cdecl alias "wxSizerItem_SetRatio" (byval self as integer,byval width as integer,byval height as integer) as integer
declare function wxSizerItem_SetRatioFloat cdecl alias "wxSizerItem_SetRatioFloat" (byval self as integer,byval ratio as integer) as integer
declare function wxSizerItem_GetRatioFloat cdecl alias "wxSizerItem_GetRatioFloat" (byval self as integer) as integer
declare function wxSizerItem_IsWindow cdecl alias "wxSizerItem_IsWindow" (byval self as integer) as integer
declare function wxSizerItem_IsSizer cdecl alias "wxSizerItem_IsSizer" (byval self as integer) as integer
declare function wxSizerItem_IsSpacer cdecl alias "wxSizerItem_IsSpacer" (byval self as integer) as integer
declare function wxSizerItem_SetProportion cdecl alias "wxSizerItem_SetProportion" (byval self as integer,byval proportion as integer) as integer
declare function wxSizerItem_GetProportion cdecl alias "wxSizerItem_GetProportion" (byval self as integer) as integer
declare function wxSizerItem_SetFlag cdecl alias "wxSizerItem_SetFlag" (byval self as integer,byval flag as integer) as integer
declare function wxSizerItem_GetFlag cdecl alias "wxSizerItem_GetFlag" (byval self as integer) as integer
declare function wxSizerItem_SetBorder cdecl alias "wxSizerItem_SetBorder" (byval self as integer,byval border as integer) as integer
declare function wxSizerItem_GetBorder cdecl alias "wxSizerItem_GetBorder" (byval self as integer) as integer
declare function wxSizerItem_GetWindow cdecl alias "wxSizerItem_GetWindow" (byval self as integer) as integer
declare function wxSizerItem_SetWindow cdecl alias "wxSizerItem_SetWindow" (byval self as integer,byval window as integer) as integer
declare function wxSizerItem_GetSizer cdecl alias "wxSizerItem_GetSizer" (byval self as integer) as integer
declare function wxSizerItem_SetSizer cdecl alias "wxSizerItem_SetSizer" (byval self as integer,byval sizer as integer) as integer
declare function wxSizerItem_GetSpacer cdecl alias "wxSizerItem_GetSpacer" (byval self as integer,byval size as integer) as integer
declare function wxSizerItem_SetSpacer cdecl alias "wxSizerItem_SetSpacer" (byval self as integer,byval size as integer) as integer
declare function wxSizerItem_Show cdecl alias "wxSizerItem_Show" (byval self as integer,byval show as integer) as integer
declare function wxSizerItem_IsShown cdecl alias "wxSizerItem_IsShown" (byval self as integer) as integer
declare function wxSizerItem_GetUserData cdecl alias "wxSizerItem_GetUserData" (byval self as integer) as integer
declare function wxSizerItem_GetPosition cdecl alias "wxSizerItem_GetPosition" (byval self as integer,byval pos as integer) as integer
declare function wxSlider_ctor cdecl alias "wxSlider_ctor" () as integer
declare function wxSlider_Create cdecl alias "wxSlider_Create" (byval self as integer,byval parent as integer,byval id as integer,byval value as integer,byval minValue as integer,byval maxValue as integer,byval pos as integer,byval size as integer,byval style as long,byval validator as integer,byval name as string) as integer
declare function wxSlider_GetValue cdecl alias "wxSlider_GetValue" (byval self as integer) as integer
declare function wxSlider_SetValue cdecl alias "wxSlider_SetValue" (byval self as integer,byval value as integer) as integer
declare function wxSlider_SetRange cdecl alias "wxSlider_SetRange" (byval self as integer,byval minValue as integer,byval maxValue as integer) as integer
declare function wxSlider_GetMin cdecl alias "wxSlider_GetMin" (byval self as integer) as integer
declare function wxSlider_GetMax cdecl alias "wxSlider_GetMax" (byval self as integer) as integer
declare function wxSlider_SetLineSize cdecl alias "wxSlider_SetLineSize" (byval self as integer,byval lineSize as integer) as integer
declare function wxSlider_SetPageSize cdecl alias "wxSlider_SetPageSize" (byval self as integer,byval pageSize as integer) as integer
declare function wxSlider_GetLineSize cdecl alias "wxSlider_GetLineSize" (byval self as integer) as integer
declare function wxSlider_GetPageSize cdecl alias "wxSlider_GetPageSize" (byval self as integer) as integer
declare function wxSlider_SetThumbLength cdecl alias "wxSlider_SetThumbLength" (byval self as integer,byval lenPixels as integer) as integer
declare function wxSlider_GetThumbLength cdecl alias "wxSlider_GetThumbLength" (byval self as integer) as integer
declare function wxSlider_SetTickFreq cdecl alias "wxSlider_SetTickFreq" (byval self as integer,byval n as integer,byval pos as integer) as integer
declare function wxSlider_GetTickFreq cdecl alias "wxSlider_GetTickFreq" (byval self as integer) as integer
declare function wxSlider_ClearTicks cdecl alias "wxSlider_ClearTicks" (byval self as integer) as integer
declare function wxSlider_SetTick cdecl alias "wxSlider_SetTick" (byval self as integer,byval tickPos as integer) as integer
declare function wxSlider_ClearSel cdecl alias "wxSlider_ClearSel" (byval self as integer) as integer
declare function wxSlider_GetSelEnd cdecl alias "wxSlider_GetSelEnd" (byval self as integer) as integer
declare function wxSlider_GetSelStart cdecl alias "wxSlider_GetSelStart" (byval self as integer) as integer
declare function wxSlider_SetSelection cdecl alias "wxSlider_SetSelection" (byval self as integer,byval min as integer,byval max as integer) as integer
declare function wxSpinButton_ctor cdecl alias "wxSpinButton_ctor" () as integer
declare function wxSpinButton_Create cdecl alias "wxSpinButton_Create" (byval self as integer,byval parent as integer,byval id as integer,byval pos as integer,byval size as integer,byval style as long,byval name as string) as integer
declare function wxSpinButton_GetValue cdecl alias "wxSpinButton_GetValue" (byval self as integer) as integer
declare function wxSpinButton_GetMin cdecl alias "wxSpinButton_GetMin" (byval self as integer) as integer
declare function wxSpinButton_GetMax cdecl alias "wxSpinButton_GetMax" (byval self as integer) as integer
declare function wxSpinButton_SetValue cdecl alias "wxSpinButton_SetValue" (byval self as integer,byval val as integer) as integer
declare function wxSpinButton_SetRange cdecl alias "wxSpinButton_SetRange" (byval self as integer,byval minVal as integer,byval maxVal as integer) as integer
declare function wxSpinEvent_ctor cdecl alias "wxSpinEvent_ctor" (byval commandType as integer,byval id as integer) as integer
declare function wxSpinEvent_GetPosition cdecl alias "wxSpinEvent_GetPosition" (byval self as integer) as integer
declare function wxSpinEvent_SetPosition cdecl alias "wxSpinEvent_SetPosition" (byval self as integer,byval pos as integer) as integer
declare function wxSpinEvent_Veto cdecl alias "wxSpinEvent_Veto" (byval self as integer) as integer
declare function wxSpinEvent_Allow cdecl alias "wxSpinEvent_Allow" (byval self as integer) as integer
declare function wxSpinEvent_IsAllowed cdecl alias "wxSpinEvent_IsAllowed" (byval self as integer) as integer
declare function wxSpinCtrl_ctor cdecl alias "wxSpinCtrl_ctor" () as integer
declare function wxSpinCtrl_Create cdecl alias "wxSpinCtrl_Create" (byval self as integer,byval parent as integer,byval id as integer,byval value as string,byval pos as integer,byval size as integer,byval style as long,byval min as integer,byval max as integer,byval initial as integer,byval name as string) as integer
declare function wxSpinCtrl_dtor cdecl alias "wxSpinCtrl_dtor" (byval self as integer) as integer
declare function wxSpinCtrl_SetValue cdecl alias "wxSpinCtrl_SetValue" (byval self as integer,byval val as integer) as integer
declare function wxSpinCtrl_SetValueStr cdecl alias "wxSpinCtrl_SetValueStr" (byval self as integer,byval text as string) as integer
declare function wxSpinCtrl_SetRange cdecl alias "wxSpinCtrl_SetRange" (byval self as integer,byval min as integer,byval max as integer) as integer
declare function wxSpinCtrl_GetValue cdecl alias "wxSpinCtrl_GetValue" (byval self as integer) as integer
declare function wxSpinCtrl_GetMin cdecl alias "wxSpinCtrl_GetMin" (byval self as integer) as integer
declare function wxSpinCtrl_GetMax cdecl alias "wxSpinCtrl_GetMax" (byval self as integer) as integer
declare function wxSplashScreen_ctor cdecl alias "wxSplashScreen_ctor" (byval bitmap as integer,byval splashStyle as integer,byval milliseconds as integer,byval parent as integer,byval id as integer,byval pos as integer,byval size as integer,byval style as integer) as integer
declare function wxSplashScreen_GetSplashStyle cdecl alias "wxSplashScreen_GetSplashStyle" (byval self as integer) as integer
declare function wxSplashScreen_GetSplashWindow cdecl alias "wxSplashScreen_GetSplashWindow" (byval self as integer) as integer
declare function wxSplashScreen_GetTimeout cdecl alias "wxSplashScreen_GetTimeout" (byval self as integer) as integer
declare function wxSplashScreenWindow_ctor cdecl alias "wxSplashScreenWindow_ctor" (byval bitmap as integer,byval parent as integer,byval id as integer,byval pos as integer,byval size as integer,byval style as integer) as integer
declare function wxSplashScreenWindow_SetBitmap cdecl alias "wxSplashScreenWindow_SetBitmap" (byval self as integer,byval bitmap as integer) as integer
declare function wxSplashScreenWindow_GetBitmap cdecl alias "wxSplashScreenWindow_GetBitmap" (byval self as integer) as integer
declare function wxSplitWnd_ctor cdecl alias "wxSplitWnd_ctor" (byval parent as integer,byval id as integer,byval pos as integer,byval size as integer,byval style as long,byval name as integer) as integer
declare function wxSplitWnd_RegisterVirtual cdecl alias "wxSplitWnd_RegisterVirtual" (byval self as integer,byval onDoubleClickSash as integer,byval onUnsplit as integer,byval onSashPositionChange as integer) as integer
declare function wxSplitWnd_OnDoubleClickSash cdecl alias "wxSplitWnd_OnDoubleClickSash" (byval self as integer,byval x as integer,byval y as integer) as integer
declare function wxSplitWnd_OnUnsplit cdecl alias "wxSplitWnd_OnUnsplit" (byval self as integer,byval removed as integer) as integer
declare function wxSplitWnd_OnSashPositionChange cdecl alias "wxSplitWnd_OnSashPositionChange" (byval self as integer,byval newSashPosition as integer) as integer
declare function wxSplitWnd_GetSplitMode cdecl alias "wxSplitWnd_GetSplitMode" (byval self as integer) as integer
declare function wxSplitWnd_IsSplit cdecl alias "wxSplitWnd_IsSplit" (byval self as integer) as integer
declare function wxSplitWnd_SplitHorizontally cdecl alias "wxSplitWnd_SplitHorizontally" (byval self as integer,byval window1 as integer,byval window2 as integer,byval sashPosition as integer) as integer
declare function wxSplitWnd_SplitVertically cdecl alias "wxSplitWnd_SplitVertically" (byval self as integer,byval window1 as integer,byval window2 as integer,byval sashPosition as integer) as integer
declare function wxSplitWnd_Unsplit cdecl alias "wxSplitWnd_Unsplit" (byval self as integer,byval toRemove as integer) as integer
declare function wxSplitWnd_SetSashPosition cdecl alias "wxSplitWnd_SetSashPosition" (byval self as integer,byval position as integer,byval redraw as integer) as integer
declare function wxSplitWnd_GetSashPosition cdecl alias "wxSplitWnd_GetSashPosition" (byval self as integer) as integer
declare function wxSplitWnd_GetMinimumPaneSize cdecl alias "wxSplitWnd_GetMinimumPaneSize" (byval self as integer) as integer
declare function wxSplitWnd_GetWindow1 cdecl alias "wxSplitWnd_GetWindow1" (byval self as integer) as integer
declare function wxSplitWnd_GetWindow2 cdecl alias "wxSplitWnd_GetWindow2" (byval self as integer) as integer
declare function wxSplitWnd_Initialize cdecl alias "wxSplitWnd_Initialize" (byval self as integer,byval window as integer) as integer
declare function wxSplitWnd_ReplaceWindow cdecl alias "wxSplitWnd_ReplaceWindow" (byval self as integer,byval winOld as integer,byval winNew as integer) as integer
declare function wxSplitWnd_SetMinimumPaneSize cdecl alias "wxSplitWnd_SetMinimumPaneSize" (byval self as integer,byval paneSize as integer) as integer
declare function wxSplitWnd_SetSplitMode cdecl alias "wxSplitWnd_SetSplitMode" (byval self as integer,byval mode as integer) as integer
declare function wxSplitWnd_UpdateSize cdecl alias "wxSplitWnd_UpdateSize" (byval self as integer) as integer
declare function wxStaticBitmap_ctor cdecl alias "wxStaticBitmap_ctor" () as integer
declare function wxStaticBitmap_Create cdecl alias "wxStaticBitmap_Create" (byval self as integer,byval parent as integer,byval id as integer,byval bitmap as integer,byval pos as integer,byval size as integer,byval style as long,byval name as string) as integer
declare function wxStaticBitmap_dtor cdecl alias "wxStaticBitmap_dtor" (byval self as integer) as integer
declare function wxStaticBitmap_SetIcon cdecl alias "wxStaticBitmap_SetIcon" (byval self as integer,byval icon as integer) as integer
declare function wxStaticBitmap_SetBitmap cdecl alias "wxStaticBitmap_SetBitmap" (byval self as integer,byval bitmap as integer) as integer
declare function wxStaticBitmap_GetBitmap cdecl alias "wxStaticBitmap_GetBitmap" (byval self as integer) as integer
declare function wxStaticBox_ctor cdecl alias "wxStaticBox_ctor" () as integer
declare function wxStaticBox_dtor cdecl alias "wxStaticBox_dtor" (byval self as integer) as integer
declare function wxStaticBox_Create cdecl alias "wxStaticBox_Create" (byval self as integer,byval parent as integer,byval id as integer,byval label as string,byval pos as integer,byval size as integer,byval style as long,byval name as string) as integer
declare function wxStaticBoxSizer_ctor cdecl alias "wxStaticBoxSizer_ctor" (byval box as integer,byval orient as integer) as integer
declare function wxStaticBoxSizer_GetStaticBox cdecl alias "wxStaticBoxSizer_GetStaticBox" (byval self as integer) as integer
declare function wxStaticLine_ctor cdecl alias "wxStaticLine_ctor" () as integer
declare function wxStaticLine_Create cdecl alias "wxStaticLine_Create" (byval self as integer,byval parent as integer,byval id as integer,byval pos as integer,byval size as integer,byval style as long,byval name as string) as integer
declare function wxStaticLine_IsVertical cdecl alias "wxStaticLine_IsVertical" (byval self as integer) as integer
declare function wxStaticLine_GetDefaultSize cdecl alias "wxStaticLine_GetDefaultSize" (byval self as integer) as integer
declare function wxStaticText_ctor cdecl alias "wxStaticText_ctor" () as integer
declare function wxStaticText_Create cdecl alias "wxStaticText_Create" (byval self as integer,byval parent as integer,byval id as integer,byval label as string,byval pos as integer,byval size as integer,byval style as long,byval name as string) as integer
declare function wxStatusBar_ctor cdecl alias "wxStatusBar_ctor" () as integer
declare function wxStatusBar_Create cdecl alias "wxStatusBar_Create" (byval self as integer,byval parent as integer,byval id as integer,byval style as integer,byval name as string) as integer
declare function wxStatusBar_SetFieldsCount cdecl alias "wxStatusBar_SetFieldsCount" (byval self as integer,byval number as integer,byval widths as integer) as integer
declare function wxStatusBar_GetFieldRect cdecl alias "wxStatusBar_GetFieldRect" (byval self as integer,byval i as integer,byval rect as integer) as integer
declare function wxStatusBar_GetBorderY cdecl alias "wxStatusBar_GetBorderY" (byval self as integer) as integer
declare function wxStatusBar_GetStatusText cdecl alias "wxStatusBar_GetStatusText" (byval self as integer,byval number as integer) as byte ptr
declare function wxStatusBar_GetBorderX cdecl alias "wxStatusBar_GetBorderX" (byval self as integer) as integer
declare function wxStatusBar_SetStatusText cdecl alias "wxStatusBar_SetStatusText" (byval self as integer,byval text as string,byval number as integer) as integer
declare function wxStatusBar_SetStatusWidths cdecl alias "wxStatusBar_SetStatusWidths" (byval self as integer,byval n as integer,byval widths_field as integer) as integer
declare function wxStatusBar_GetFieldsCount cdecl alias "wxStatusBar_GetFieldsCount" (byval self as integer) as integer
declare function wxStatusBar_PopStatusText cdecl alias "wxStatusBar_PopStatusText" (byval self as integer,byval field as integer) as integer
declare function wxStatusBar_PushStatusText cdecl alias "wxStatusBar_PushStatusText" (byval self as integer,byval xstring as string,byval field as integer) as integer
declare function wxStatusBar_SetMinHeight cdecl alias "wxStatusBar_SetMinHeight" (byval self as integer,byval height as integer) as integer
declare function wxStatusBar_SetStatusStyles cdecl alias "wxStatusBar_SetStatusStyles" (byval self as integer,byval n as integer,byval styles as integer ptr) as integer
declare function wxStyledTextCtrl_EVT_STC_CHANGE cdecl alias "wxStyledTextCtrl_EVT_STC_CHANGE" () as integer
declare function wxStyledTextCtrl_EVT_STC_STYLENEEDED cdecl alias "wxStyledTextCtrl_EVT_STC_STYLENEEDED" () as integer
declare function wxStyledTextCtrl_EVT_STC_CHARADDED cdecl alias "wxStyledTextCtrl_EVT_STC_CHARADDED" () as integer
declare function wxStyledTextCtrl_EVT_STC_SAVEPOINTREACHED cdecl alias "wxStyledTextCtrl_EVT_STC_SAVEPOINTREACHED" () as integer
declare function wxStyledTextCtrl_EVT_STC_SAVEPOINTLEFT cdecl alias "wxStyledTextCtrl_EVT_STC_SAVEPOINTLEFT" () as integer
declare function wxStyledTextCtrl_EVT_STC_ROMODIFYATTEMPT cdecl alias "wxStyledTextCtrl_EVT_STC_ROMODIFYATTEMPT" () as integer
declare function wxStyledTextCtrl_EVT_STC_KEY cdecl alias "wxStyledTextCtrl_EVT_STC_KEY" () as integer
declare function wxStyledTextCtrl_EVT_STC_DOUBLECLICK cdecl alias "wxStyledTextCtrl_EVT_STC_DOUBLECLICK" () as integer
declare function wxStyledTextCtrl_EVT_STC_UPDATEUI cdecl alias "wxStyledTextCtrl_EVT_STC_UPDATEUI" () as integer
declare function wxStyledTextCtrl_EVT_STC_MODIFIED cdecl alias "wxStyledTextCtrl_EVT_STC_MODIFIED" () as integer
declare function wxStyledTextCtrl_EVT_STC_MACRORECORD cdecl alias "wxStyledTextCtrl_EVT_STC_MACRORECORD" () as integer
declare function wxStyledTextCtrl_EVT_STC_MARGINCLICK cdecl alias "wxStyledTextCtrl_EVT_STC_MARGINCLICK" () as integer
declare function wxStyledTextCtrl_EVT_STC_NEEDSHOWN cdecl alias "wxStyledTextCtrl_EVT_STC_NEEDSHOWN" () as integer
'declare function wxStyledTextCtrl_EVT_STC_POSCHANGED cdecl alias "wxStyledTextCtrl_EVT_STC_POSCHANGED" () as integer
'commented in source >_<
declare function wxStyledTextCtrl_EVT_STC_PAINTED cdecl alias "wxStyledTextCtrl_EVT_STC_PAINTED" () as integer
declare function wxStyledTextCtrl_EVT_STC_USERLISTSELECTION cdecl alias "wxStyledTextCtrl_EVT_STC_USERLISTSELECTION" () as integer
declare function wxStyledTextCtrl_EVT_STC_URIDROPPED cdecl alias "wxStyledTextCtrl_EVT_STC_URIDROPPED" () as integer
declare function wxStyledTextCtrl_EVT_STC_DWELLSTART cdecl alias "wxStyledTextCtrl_EVT_STC_DWELLSTART" () as integer
declare function wxStyledTextCtrl_EVT_STC_DWELLEND cdecl alias "wxStyledTextCtrl_EVT_STC_DWELLEND" () as integer
declare function wxStyledTextCtrl_EVT_STC_START_DRAG cdecl alias "wxStyledTextCtrl_EVT_STC_START_DRAG" () as integer
declare function wxStyledTextCtrl_EVT_STC_DRAG_OVER cdecl alias "wxStyledTextCtrl_EVT_STC_DRAG_OVER" () as integer
declare function wxStyledTextCtrl_EVT_STC_DO_DROP cdecl alias "wxStyledTextCtrl_EVT_STC_DO_DROP" () as integer
declare function wxStyledTextCtrl_EVT_STC_ZOOM cdecl alias "wxStyledTextCtrl_EVT_STC_ZOOM" () as integer
declare function wxStyledTextCtrl_EVT_STC_HOTSPOT_CLICK cdecl alias "wxStyledTextCtrl_EVT_STC_HOTSPOT_CLICK" () as integer
declare function wxStyledTextCtrl_EVT_STC_HOTSPOT_DCLICK cdecl alias "wxStyledTextCtrl_EVT_STC_HOTSPOT_DCLICK" () as integer
declare function wxStyledTextCtrl_EVT_STC_CALLTIP_CLICK cdecl alias "wxStyledTextCtrl_EVT_STC_CALLTIP_CLICK" () as integer
declare function wxStyledTextCtrl_ctor cdecl alias "wxStyledTextCtrl_ctor" (byval parent as integer,byval id as integer,byval pos as integer,byval size as integer,byval style as long,byval name as string) as integer
declare function wxStyledTextCtrl_AddText cdecl alias "wxStyledTextCtrl_AddText" (byval self as integer,byval text as string) as integer
declare function wxStyledTextCtrl_AddStyledText cdecl alias "wxStyledTextCtrl_AddStyledText" (byval self as integer,byval data as integer) as integer
declare function wxStyledTextCtrl_InsertText cdecl alias "wxStyledTextCtrl_InsertText" (byval self as integer,byval pos as integer,byval text as string) as integer
declare function wxStyledTextCtrl_ClearAll cdecl alias "wxStyledTextCtrl_ClearAll" (byval self as integer) as integer
declare function wxStyledTextCtrl_ClearDocumentStyle cdecl alias "wxStyledTextCtrl_ClearDocumentStyle" (byval self as integer) as integer
declare function wxStyledTextCtrl_GetLength cdecl alias "wxStyledTextCtrl_GetLength" (byval self as integer) as integer
declare function wxStyledTextCtrl_GetCharAt cdecl alias "wxStyledTextCtrl_GetCharAt" (byval self as integer,byval pos as integer) as integer
declare function wxStyledTextCtrl_GetCurrentPos cdecl alias "wxStyledTextCtrl_GetCurrentPos" (byval self as integer) as integer
declare function wxStyledTextCtrl_GetAnchor cdecl alias "wxStyledTextCtrl_GetAnchor" (byval self as integer) as integer
declare function wxStyledTextCtrl_GetStyleAt cdecl alias "wxStyledTextCtrl_GetStyleAt" (byval self as integer,byval pos as integer) as integer
declare function wxStyledTextCtrl_Redo cdecl alias "wxStyledTextCtrl_Redo" (byval self as integer) as integer
declare function wxStyledTextCtrl_SetUndoCollection cdecl alias "wxStyledTextCtrl_SetUndoCollection" (byval self as integer,byval collectUndo as integer) as integer
declare function wxStyledTextCtrl_SelectAll cdecl alias "wxStyledTextCtrl_SelectAll" (byval self as integer) as integer
declare function wxStyledTextCtrl_SetSavePoint cdecl alias "wxStyledTextCtrl_SetSavePoint" (byval self as integer) as integer
declare function wxStyledTextCtrl_GetStyledText cdecl alias "wxStyledTextCtrl_GetStyledText" (byval self as integer,byval startPos as integer,byval endPos as integer) as integer
declare function wxStyledTextCtrl_CanRedo cdecl alias "wxStyledTextCtrl_CanRedo" (byval self as integer) as integer
declare function wxStyledTextCtrl_MarkerLineFromHandle cdecl alias "wxStyledTextCtrl_MarkerLineFromHandle" (byval self as integer,byval handle as integer) as integer
declare function wxStyledTextCtrl_MarkerDeleteHandle cdecl alias "wxStyledTextCtrl_MarkerDeleteHandle" (byval self as integer,byval handle as integer) as integer
declare function wxStyledTextCtrl_GetUndoCollection cdecl alias "wxStyledTextCtrl_GetUndoCollection" (byval self as integer) as integer
declare function wxStyledTextCtrl_GetViewWhiteSpace cdecl alias "wxStyledTextCtrl_GetViewWhiteSpace" (byval self as integer) as integer
declare function wxStyledTextCtrl_SetViewWhiteSpace cdecl alias "wxStyledTextCtrl_SetViewWhiteSpace" (byval self as integer,byval viewWS as integer) as integer
declare function wxStyledTextCtrl_PositionFromPoint cdecl alias "wxStyledTextCtrl_PositionFromPoint" (byval self as integer,byval pt as integer) as integer
declare function wxStyledTextCtrl_PositionFromPointClose cdecl alias "wxStyledTextCtrl_PositionFromPointClose" (byval self as integer,byval x as integer,byval y as integer) as integer
declare function wxStyledTextCtrl_GotoLine cdecl alias "wxStyledTextCtrl_GotoLine" (byval self as integer,byval line as integer) as integer
declare function wxStyledTextCtrl_GotoPos cdecl alias "wxStyledTextCtrl_GotoPos" (byval self as integer,byval pos as integer) as integer
declare function wxStyledTextCtrl_SetAnchor cdecl alias "wxStyledTextCtrl_SetAnchor" (byval self as integer,byval posAnchor as integer) as integer
declare function wxStyledTextCtrl_GetCurLine cdecl alias "wxStyledTextCtrl_GetCurLine" (byval self as integer,byval linePos as integer) as byte ptr
declare function wxStyledTextCtrl_GetEndStyled cdecl alias "wxStyledTextCtrl_GetEndStyled" (byval self as integer) as integer
declare function wxStyledTextCtrl_ConvertEOLs cdecl alias "wxStyledTextCtrl_ConvertEOLs" (byval self as integer,byval eolMode as integer) as integer
declare function wxStyledTextCtrl_GetEOLMode cdecl alias "wxStyledTextCtrl_GetEOLMode" (byval self as integer) as integer
declare function wxStyledTextCtrl_SetEOLMode cdecl alias "wxStyledTextCtrl_SetEOLMode" (byval self as integer,byval eolMode as integer) as integer
declare function wxStyledTextCtrl_StartStyling cdecl alias "wxStyledTextCtrl_StartStyling" (byval self as integer,byval pos as integer,byval mask as integer) as integer
declare function wxStyledTextCtrl_SetStyling cdecl alias "wxStyledTextCtrl_SetStyling" (byval self as integer,byval length as integer,byval style as integer) as integer
declare function wxStyledTextCtrl_GetBufferedDraw cdecl alias "wxStyledTextCtrl_GetBufferedDraw" (byval self as integer) as integer
declare function wxStyledTextCtrl_SetBufferedDraw cdecl alias "wxStyledTextCtrl_SetBufferedDraw" (byval self as integer,byval buffered as integer) as integer
declare function wxStyledTextCtrl_SetTabWidth cdecl alias "wxStyledTextCtrl_SetTabWidth" (byval self as integer,byval tabWidth as integer) as integer
declare function wxStyledTextCtrl_GetTabWidth cdecl alias "wxStyledTextCtrl_GetTabWidth" (byval self as integer) as integer
declare function wxStyledTextCtrl_SetCodePage cdecl alias "wxStyledTextCtrl_SetCodePage" (byval self as integer,byval codePage as integer) as integer
declare function wxStyledTextCtrl_MarkerDefine cdecl alias "wxStyledTextCtrl_MarkerDefine" (byval self as integer,byval markerNumber as integer,byval markerSymbol as integer,byval foreground as integer,byval background as integer) as integer
declare function wxStyledTextCtrl_MarkerSetForeground cdecl alias "wxStyledTextCtrl_MarkerSetForeground" (byval self as integer,byval markerNumber as integer,byval fore as integer) as integer
declare function wxStyledTextCtrl_MarkerSetBackground cdecl alias "wxStyledTextCtrl_MarkerSetBackground" (byval self as integer,byval markerNumber as integer,byval back as integer) as integer
declare function wxStyledTextCtrl_MarkerAdd cdecl alias "wxStyledTextCtrl_MarkerAdd" (byval self as integer,byval line as integer,byval markerNumber as integer) as integer
declare function wxStyledTextCtrl_MarkerDelete cdecl alias "wxStyledTextCtrl_MarkerDelete" (byval self as integer,byval line as integer,byval markerNumber as integer) as integer
declare function wxStyledTextCtrl_MarkerDeleteAll cdecl alias "wxStyledTextCtrl_MarkerDeleteAll" (byval self as integer,byval markerNumber as integer) as integer
declare function wxStyledTextCtrl_MarkerGet cdecl alias "wxStyledTextCtrl_MarkerGet" (byval self as integer,byval line as integer) as integer
declare function wxStyledTextCtrl_MarkerNext cdecl alias "wxStyledTextCtrl_MarkerNext" (byval self as integer,byval lineStart as integer,byval markerMask as integer) as integer
declare function wxStyledTextCtrl_MarkerPrevious cdecl alias "wxStyledTextCtrl_MarkerPrevious" (byval self as integer,byval lineStart as integer,byval markerMask as integer) as integer
declare function wxStyledTextCtrl_MarkerDefineBitmap cdecl alias "wxStyledTextCtrl_MarkerDefineBitmap" (byval self as integer,byval markerNumber as integer,byval bmp as integer) as integer
declare function wxStyledTextCtrl_SetMarginType cdecl alias "wxStyledTextCtrl_SetMarginType" (byval self as integer,byval margin as integer,byval marginType as integer) as integer
declare function wxStyledTextCtrl_GetMarginType cdecl alias "wxStyledTextCtrl_GetMarginType" (byval self as integer,byval margin as integer) as integer
declare function wxStyledTextCtrl_SetMarginWidth cdecl alias "wxStyledTextCtrl_SetMarginWidth" (byval self as integer,byval margin as integer,byval pixelWidth as integer) as integer
declare function wxStyledTextCtrl_GetMarginWidth cdecl alias "wxStyledTextCtrl_GetMarginWidth" (byval self as integer,byval margin as integer) as integer
declare function wxStyledTextCtrl_SetMarginMask cdecl alias "wxStyledTextCtrl_SetMarginMask" (byval self as integer,byval margin as integer,byval mask as integer) as integer
declare function wxStyledTextCtrl_GetMarginMask cdecl alias "wxStyledTextCtrl_GetMarginMask" (byval self as integer,byval margin as integer) as integer
declare function wxStyledTextCtrl_SetMarginSensitive cdecl alias "wxStyledTextCtrl_SetMarginSensitive" (byval self as integer,byval margin as integer,byval sensitive as integer) as integer
declare function wxStyledTextCtrl_GetMarginSensitive cdecl alias "wxStyledTextCtrl_GetMarginSensitive" (byval self as integer,byval margin as integer) as integer
declare function wxStyledTextCtrl_StyleClearAll cdecl alias "wxStyledTextCtrl_StyleClearAll" (byval self as integer) as integer
declare function wxStyledTextCtrl_StyleSetForeground cdecl alias "wxStyledTextCtrl_StyleSetForeground" (byval self as integer,byval style as integer,byval fore as integer) as integer
declare function wxStyledTextCtrl_StyleSetBackground cdecl alias "wxStyledTextCtrl_StyleSetBackground" (byval self as integer,byval style as integer,byval back as integer) as integer
declare function wxStyledTextCtrl_StyleSetBold cdecl alias "wxStyledTextCtrl_StyleSetBold" (byval self as integer,byval style as integer,byval bold as integer) as integer
declare function wxStyledTextCtrl_StyleSetItalic cdecl alias "wxStyledTextCtrl_StyleSetItalic" (byval self as integer,byval style as integer,byval italic as integer) as integer
declare function wxStyledTextCtrl_StyleSetSize cdecl alias "wxStyledTextCtrl_StyleSetSize" (byval self as integer,byval style as integer,byval sizePoints as integer) as integer
declare function wxStyledTextCtrl_StyleSetFaceName cdecl alias "wxStyledTextCtrl_StyleSetFaceName" (byval self as integer,byval style as integer,byval fontName as string) as integer
declare function wxStyledTextCtrl_StyleSetEOLFilled cdecl alias "wxStyledTextCtrl_StyleSetEOLFilled" (byval self as integer,byval style as integer,byval filled as integer) as integer
declare function wxStyledTextCtrl_StyleResetDefault cdecl alias "wxStyledTextCtrl_StyleResetDefault" (byval self as integer) as integer
declare function wxStyledTextCtrl_StyleSetUnderline cdecl alias "wxStyledTextCtrl_StyleSetUnderline" (byval self as integer,byval style as integer,byval underline as integer) as integer
declare function wxStyledTextCtrl_StyleSetCase cdecl alias "wxStyledTextCtrl_StyleSetCase" (byval self as integer,byval style as integer,byval caseForce as integer) as integer
declare function wxStyledTextCtrl_StyleSetCharacterSet cdecl alias "wxStyledTextCtrl_StyleSetCharacterSet" (byval self as integer,byval style as integer,byval characterSet as integer) as integer
declare function wxStyledTextCtrl_StyleSetHotSpot cdecl alias "wxStyledTextCtrl_StyleSetHotSpot" (byval self as integer,byval style as integer,byval hotspot as integer) as integer
declare function wxStyledTextCtrl_SetSelForeground cdecl alias "wxStyledTextCtrl_SetSelForeground" (byval self as integer,byval useSetting as integer,byval fore as integer) as integer
declare function wxStyledTextCtrl_SetSelBackground cdecl alias "wxStyledTextCtrl_SetSelBackground" (byval self as integer,byval useSetting as integer,byval back as integer) as integer
declare function wxStyledTextCtrl_SetCaretForeground cdecl alias "wxStyledTextCtrl_SetCaretForeground" (byval self as integer,byval fore as integer) as integer
declare function wxStyledTextCtrl_CmdKeyAssign cdecl alias "wxStyledTextCtrl_CmdKeyAssign" (byval self as integer,byval key as integer,byval modifiers as integer,byval cmd as integer) as integer
declare function wxStyledTextCtrl_CmdKeyClear cdecl alias "wxStyledTextCtrl_CmdKeyClear" (byval self as integer,byval key as integer,byval modifiers as integer) as integer
declare function wxStyledTextCtrl_CmdKeyClearAll cdecl alias "wxStyledTextCtrl_CmdKeyClearAll" (byval self as integer) as integer
declare function wxStyledTextCtrl_SetStyleBytes cdecl alias "wxStyledTextCtrl_SetStyleBytes" (byval self as integer,byval length as integer,byval styleBytes as string) as integer
declare function wxStyledTextCtrl_StyleSetVisible cdecl alias "wxStyledTextCtrl_StyleSetVisible" (byval self as integer,byval style as integer,byval visible as integer) as integer
declare function wxStyledTextCtrl_GetCaretPeriod cdecl alias "wxStyledTextCtrl_GetCaretPeriod" (byval self as integer) as integer
declare function wxStyledTextCtrl_SetCaretPeriod cdecl alias "wxStyledTextCtrl_SetCaretPeriod" (byval self as integer,byval periodMilliseconds as integer) as integer
declare function wxStyledTextCtrl_SetWordChars cdecl alias "wxStyledTextCtrl_SetWordChars" (byval self as integer,byval characters as string) as integer
declare function wxStyledTextCtrl_BeginUndoAction cdecl alias "wxStyledTextCtrl_BeginUndoAction" (byval self as integer) as integer
declare function wxStyledTextCtrl_EndUndoAction cdecl alias "wxStyledTextCtrl_EndUndoAction" (byval self as integer) as integer
declare function wxStyledTextCtrl_IndicatorSetStyle cdecl alias "wxStyledTextCtrl_IndicatorSetStyle" (byval self as integer,byval indic as integer,byval style as integer) as integer
declare function wxStyledTextCtrl_IndicatorGetStyle cdecl alias "wxStyledTextCtrl_IndicatorGetStyle" (byval self as integer,byval indic as integer) as integer
declare function wxStyledTextCtrl_IndicatorSetForeground cdecl alias "wxStyledTextCtrl_IndicatorSetForeground" (byval self as integer,byval indic as integer,byval fore as integer) as integer
declare function wxStyledTextCtrl_IndicatorGetForeground cdecl alias "wxStyledTextCtrl_IndicatorGetForeground" (byval self as integer,byval indic as integer) as integer
declare function wxStyledTextCtrl_SetWhitespaceForeground cdecl alias "wxStyledTextCtrl_SetWhitespaceForeground" (byval self as integer,byval useSetting as integer,byval fore as integer) as integer
declare function wxStyledTextCtrl_SetWhitespaceBackground cdecl alias "wxStyledTextCtrl_SetWhitespaceBackground" (byval self as integer,byval useSetting as integer,byval back as integer) as integer
declare function wxStyledTextCtrl_SetStyleBits cdecl alias "wxStyledTextCtrl_SetStyleBits" (byval self as integer,byval bits as integer) as integer
declare function wxStyledTextCtrl_GetStyleBits cdecl alias "wxStyledTextCtrl_GetStyleBits" (byval self as integer) as integer
declare function wxStyledTextCtrl_SetLineState cdecl alias "wxStyledTextCtrl_SetLineState" (byval self as integer,byval line as integer,byval state as integer) as integer
declare function wxStyledTextCtrl_GetLineState cdecl alias "wxStyledTextCtrl_GetLineState" (byval self as integer,byval line as integer) as integer
declare function wxStyledTextCtrl_GetMaxLineState cdecl alias "wxStyledTextCtrl_GetMaxLineState" (byval self as integer) as integer
declare function wxStyledTextCtrl_GetCaretLineVisible cdecl alias "wxStyledTextCtrl_GetCaretLineVisible" (byval self as integer) as integer
declare function wxStyledTextCtrl_SetCaretLineVisible cdecl alias "wxStyledTextCtrl_SetCaretLineVisible" (byval self as integer,byval show as integer) as integer
declare function wxStyledTextCtrl_GetCaretLineBack cdecl alias "wxStyledTextCtrl_GetCaretLineBack" (byval self as integer) as integer
declare function wxStyledTextCtrl_SetCaretLineBack cdecl alias "wxStyledTextCtrl_SetCaretLineBack" (byval self as integer,byval back as integer) as integer
declare function wxStyledTextCtrl_StyleSetChangeable cdecl alias "wxStyledTextCtrl_StyleSetChangeable" (byval self as integer,byval style as integer,byval changeable as integer) as integer
declare function wxStyledTextCtrl_AutoCompShow cdecl alias "wxStyledTextCtrl_AutoCompShow" (byval self as integer,byval lenEntered as integer,byval itemList as string) as integer
declare function wxStyledTextCtrl_AutoCompCancel cdecl alias "wxStyledTextCtrl_AutoCompCancel" (byval self as integer) as integer
declare function wxStyledTextCtrl_AutoCompActive cdecl alias "wxStyledTextCtrl_AutoCompActive" (byval self as integer) as integer
declare function wxStyledTextCtrl_AutoCompPosStart cdecl alias "wxStyledTextCtrl_AutoCompPosStart" (byval self as integer) as integer
declare function wxStyledTextCtrl_AutoCompComplete cdecl alias "wxStyledTextCtrl_AutoCompComplete" (byval self as integer) as integer
declare function wxStyledTextCtrl_AutoCompStops cdecl alias "wxStyledTextCtrl_AutoCompStops" (byval self as integer,byval characterSet as string) as integer
declare function wxStyledTextCtrl_AutoCompSetSeparator cdecl alias "wxStyledTextCtrl_AutoCompSetSeparator" (byval self as integer,byval separatorCharacter as integer) as integer
declare function wxStyledTextCtrl_AutoCompGetSeparator cdecl alias "wxStyledTextCtrl_AutoCompGetSeparator" (byval self as integer) as integer
declare function wxStyledTextCtrl_AutoCompSelect cdecl alias "wxStyledTextCtrl_AutoCompSelect" (byval self as integer,byval text as string) as integer
declare function wxStyledTextCtrl_AutoCompSetCancelAtStart cdecl alias "wxStyledTextCtrl_AutoCompSetCancelAtStart" (byval self as integer,byval cancel as integer) as integer
declare function wxStyledTextCtrl_AutoCompGetCancelAtStart cdecl alias "wxStyledTextCtrl_AutoCompGetCancelAtStart" (byval self as integer) as integer
declare function wxStyledTextCtrl_AutoCompSetFillUps cdecl alias "wxStyledTextCtrl_AutoCompSetFillUps" (byval self as integer,byval characterSet as string) as integer
declare function wxStyledTextCtrl_AutoCompSetChooseSingle cdecl alias "wxStyledTextCtrl_AutoCompSetChooseSingle" (byval self as integer,byval chooseSingle as integer) as integer
declare function wxStyledTextCtrl_AutoCompGetChooseSingle cdecl alias "wxStyledTextCtrl_AutoCompGetChooseSingle" (byval self as integer) as integer
declare function wxStyledTextCtrl_AutoCompSetIgnoreCase cdecl alias "wxStyledTextCtrl_AutoCompSetIgnoreCase" (byval self as integer,byval ignoreCase as integer) as integer
declare function wxStyledTextCtrl_AutoCompGetIgnoreCase cdecl alias "wxStyledTextCtrl_AutoCompGetIgnoreCase" (byval self as integer) as integer
declare function wxStyledTextCtrl_UserListShow cdecl alias "wxStyledTextCtrl_UserListShow" (byval self as integer,byval listType as integer,byval itemList as string) as integer
declare function wxStyledTextCtrl_AutoCompSetAutoHide cdecl alias "wxStyledTextCtrl_AutoCompSetAutoHide" (byval self as integer,byval autoHide as integer) as integer
declare function wxStyledTextCtrl_AutoCompGetAutoHide cdecl alias "wxStyledTextCtrl_AutoCompGetAutoHide" (byval self as integer) as integer
declare function wxStyledTextCtrl_AutoCompSetDropRestOfWord cdecl alias "wxStyledTextCtrl_AutoCompSetDropRestOfWord" (byval self as integer,byval dropRestOfWord as integer) as integer
declare function wxStyledTextCtrl_AutoCompGetDropRestOfWord cdecl alias "wxStyledTextCtrl_AutoCompGetDropRestOfWord" (byval self as integer) as integer
declare function wxStyledTextCtrl_RegisterImage cdecl alias "wxStyledTextCtrl_RegisterImage" (byval self as integer,byval type as integer,byval bmp as integer) as integer
declare function wxStyledTextCtrl_ClearRegisteredImages cdecl alias "wxStyledTextCtrl_ClearRegisteredImages" (byval self as integer) as integer
declare function wxStyledTextCtrl_AutoCompGetTypeSeparator cdecl alias "wxStyledTextCtrl_AutoCompGetTypeSeparator" (byval self as integer) as integer
declare function wxStyledTextCtrl_AutoCompSetTypeSeparator cdecl alias "wxStyledTextCtrl_AutoCompSetTypeSeparator" (byval self as integer,byval separatorCharacter as integer) as integer
declare function wxStyledTextCtrl_SetIndent cdecl alias "wxStyledTextCtrl_SetIndent" (byval self as integer,byval indentSize as integer) as integer
declare function wxStyledTextCtrl_GetIndent cdecl alias "wxStyledTextCtrl_GetIndent" (byval self as integer) as integer
declare function wxStyledTextCtrl_SetUseTabs cdecl alias "wxStyledTextCtrl_SetUseTabs" (byval self as integer,byval useTabs as integer) as integer
declare function wxStyledTextCtrl_GetUseTabs cdecl alias "wxStyledTextCtrl_GetUseTabs" (byval self as integer) as integer
declare function wxStyledTextCtrl_SetLineIndentation cdecl alias "wxStyledTextCtrl_SetLineIndentation" (byval self as integer,byval line as integer,byval indentSize as integer) as integer
declare function wxStyledTextCtrl_GetLineIndentation cdecl alias "wxStyledTextCtrl_GetLineIndentation" (byval self as integer,byval line as integer) as integer
declare function wxStyledTextCtrl_GetLineIndentPosition cdecl alias "wxStyledTextCtrl_GetLineIndentPosition" (byval self as integer,byval line as integer) as integer
declare function wxStyledTextCtrl_GetColumn cdecl alias "wxStyledTextCtrl_GetColumn" (byval self as integer,byval pos as integer) as integer
declare function wxStyledTextCtrl_SetUseHorizontalScrollBar cdecl alias "wxStyledTextCtrl_SetUseHorizontalScrollBar" (byval self as integer,byval show as integer) as integer
declare function wxStyledTextCtrl_GetUseHorizontalScrollBar cdecl alias "wxStyledTextCtrl_GetUseHorizontalScrollBar" (byval self as integer) as integer
declare function wxStyledTextCtrl_SetIndentationGuides cdecl alias "wxStyledTextCtrl_SetIndentationGuides" (byval self as integer,byval show as integer) as integer
declare function wxStyledTextCtrl_GetIndentationGuides cdecl alias "wxStyledTextCtrl_GetIndentationGuides" (byval self as integer) as integer
declare function wxStyledTextCtrl_SetHighlightGuide cdecl alias "wxStyledTextCtrl_SetHighlightGuide" (byval self as integer,byval column as integer) as integer
declare function wxStyledTextCtrl_GetHighlightGuide cdecl alias "wxStyledTextCtrl_GetHighlightGuide" (byval self as integer) as integer
declare function wxStyledTextCtrl_GetLineEndPosition cdecl alias "wxStyledTextCtrl_GetLineEndPosition" (byval self as integer,byval line as integer) as integer
declare function wxStyledTextCtrl_GetCodePage cdecl alias "wxStyledTextCtrl_GetCodePage" (byval self as integer) as integer
declare function wxStyledTextCtrl_GetCaretForeground cdecl alias "wxStyledTextCtrl_GetCaretForeground" (byval self as integer) as integer
declare function wxStyledTextCtrl_GetReadOnly cdecl alias "wxStyledTextCtrl_GetReadOnly" (byval self as integer) as integer
declare function wxStyledTextCtrl_SetCurrentPos cdecl alias "wxStyledTextCtrl_SetCurrentPos" (byval self as integer,byval pos as integer) as integer
declare function wxStyledTextCtrl_SetSelectionStart cdecl alias "wxStyledTextCtrl_SetSelectionStart" (byval self as integer,byval pos as integer) as integer
declare function wxStyledTextCtrl_GetSelectionStart cdecl alias "wxStyledTextCtrl_GetSelectionStart" (byval self as integer) as integer
declare function wxStyledTextCtrl_SetSelectionEnd cdecl alias "wxStyledTextCtrl_SetSelectionEnd" (byval self as integer,byval pos as integer) as integer
declare function wxStyledTextCtrl_GetSelectionEnd cdecl alias "wxStyledTextCtrl_GetSelectionEnd" (byval self as integer) as integer
declare function wxStyledTextCtrl_SetPrintMagnification cdecl alias "wxStyledTextCtrl_SetPrintMagnification" (byval self as integer,byval magnification as integer) as integer
declare function wxStyledTextCtrl_GetPrintMagnification cdecl alias "wxStyledTextCtrl_GetPrintMagnification" (byval self as integer) as integer
declare function wxStyledTextCtrl_SetPrintColourMode cdecl alias "wxStyledTextCtrl_SetPrintColourMode" (byval self as integer,byval mode as integer) as integer
declare function wxStyledTextCtrl_GetPrintColourMode cdecl alias "wxStyledTextCtrl_GetPrintColourMode" (byval self as integer) as integer
declare function wxStyledTextCtrl_FindText cdecl alias "wxStyledTextCtrl_FindText" (byval self as integer,byval minPos as integer,byval maxPos as integer,byval text as string,byval flags as integer) as integer
declare function wxStyledTextCtrl_FormatRange cdecl alias "wxStyledTextCtrl_FormatRange" (byval self as integer,byval doDraw as integer,byval startPos as integer,byval endPos as integer,byval draw as integer,byval target as integer,byval renderRect as integer,byval pageRect as integer) as integer
declare function wxStyledTextCtrl_GetFirstVisibleLine cdecl alias "wxStyledTextCtrl_GetFirstVisibleLine" (byval self as integer) as integer
declare function wxStyledTextCtrl_GetLine cdecl alias "wxStyledTextCtrl_GetLine" (byval self as integer,byval line as integer) as byte ptr
declare function wxStyledTextCtrl_GetLineCount cdecl alias "wxStyledTextCtrl_GetLineCount" (byval self as integer) as integer
declare function wxStyledTextCtrl_SetMarginLeft cdecl alias "wxStyledTextCtrl_SetMarginLeft" (byval self as integer,byval pixelWidth as integer) as integer
declare function wxStyledTextCtrl_GetMarginLeft cdecl alias "wxStyledTextCtrl_GetMarginLeft" (byval self as integer) as integer
declare function wxStyledTextCtrl_SetMarginRight cdecl alias "wxStyledTextCtrl_SetMarginRight" (byval self as integer,byval pixelWidth as integer) as integer
declare function wxStyledTextCtrl_GetMarginRight cdecl alias "wxStyledTextCtrl_GetMarginRight" (byval self as integer) as integer
declare function wxStyledTextCtrl_GetModify cdecl alias "wxStyledTextCtrl_GetModify" (byval self as integer) as integer
declare function wxStyledTextCtrl_SetSelection cdecl alias "wxStyledTextCtrl_SetSelection" (byval self as integer,byval start as integer,byval end as integer) as integer
declare function wxStyledTextCtrl_GetSelectedText cdecl alias "wxStyledTextCtrl_GetSelectedText" (byval self as integer) as byte ptr
declare function wxStyledTextCtrl_GetTextRange cdecl alias "wxStyledTextCtrl_GetTextRange" (byval self as integer,byval startPos as integer,byval endPos as integer) as byte ptr
declare function wxStyledTextCtrl_HideSelection cdecl alias "wxStyledTextCtrl_HideSelection" (byval self as integer,byval normal as integer) as integer
declare function wxStyledTextCtrl_LineFromPosition cdecl alias "wxStyledTextCtrl_LineFromPosition" (byval self as integer,byval pos as integer) as integer
declare function wxStyledTextCtrl_PositionFromLine cdecl alias "wxStyledTextCtrl_PositionFromLine" (byval self as integer,byval line as integer) as integer
declare function wxStyledTextCtrl_LineScroll cdecl alias "wxStyledTextCtrl_LineScroll" (byval self as integer,byval columns as integer,byval lines as integer) as integer
declare function wxStyledTextCtrl_EnsureCaretVisible cdecl alias "wxStyledTextCtrl_EnsureCaretVisible" (byval self as integer) as integer
declare function wxStyledTextCtrl_ReplaceSelection cdecl alias "wxStyledTextCtrl_ReplaceSelection" (byval self as integer,byval text as string) as integer
declare function wxStyledTextCtrl_SetReadOnly cdecl alias "wxStyledTextCtrl_SetReadOnly" (byval self as integer,byval readOnly as integer) as integer
declare function wxStyledTextCtrl_CanPaste cdecl alias "wxStyledTextCtrl_CanPaste" (byval self as integer) as integer
declare function wxStyledTextCtrl_CanUndo cdecl alias "wxStyledTextCtrl_CanUndo" (byval self as integer) as integer
declare function wxStyledTextCtrl_EmptyUndoBuffer cdecl alias "wxStyledTextCtrl_EmptyUndoBuffer" (byval self as integer) as integer
declare function wxStyledTextCtrl_Undo cdecl alias "wxStyledTextCtrl_Undo" (byval self as integer) as integer
declare function wxStyledTextCtrl_Cut cdecl alias "wxStyledTextCtrl_Cut" (byval self as integer) as integer
declare function wxStyledTextCtrl_Copy cdecl alias "wxStyledTextCtrl_Copy" (byval self as integer) as integer
declare function wxStyledTextCtrl_Paste cdecl alias "wxStyledTextCtrl_Paste" (byval self as integer) as integer
declare function wxStyledTextCtrl_Clear cdecl alias "wxStyledTextCtrl_Clear" (byval self as integer) as integer
declare function wxStyledTextCtrl_SetText cdecl alias "wxStyledTextCtrl_SetText" (byval self as integer,byval text as string) as integer
declare function wxStyledTextCtrl_GetText cdecl alias "wxStyledTextCtrl_GetText" (byval self as integer) as byte ptr
declare function wxStyledTextCtrl_GetTextLength cdecl alias "wxStyledTextCtrl_GetTextLength" (byval self as integer) as integer
declare function wxStyledTextCtrl_SetOvertype cdecl alias "wxStyledTextCtrl_SetOvertype" (byval self as integer,byval overtype as integer) as integer
declare function wxStyledTextCtrl_GetOvertype cdecl alias "wxStyledTextCtrl_GetOvertype" (byval self as integer) as integer
declare function wxStyledTextCtrl_SetCaretWidth cdecl alias "wxStyledTextCtrl_SetCaretWidth" (byval self as integer,byval pixelWidth as integer) as integer
declare function wxStyledTextCtrl_GetCaretWidth cdecl alias "wxStyledTextCtrl_GetCaretWidth" (byval self as integer) as integer
declare function wxStyledTextCtrl_SetTargetStart cdecl alias "wxStyledTextCtrl_SetTargetStart" (byval self as integer,byval pos as integer) as integer
declare function wxStyledTextCtrl_GetTargetStart cdecl alias "wxStyledTextCtrl_GetTargetStart" (byval self as integer) as integer
declare function wxStyledTextCtrl_SetTargetEnd cdecl alias "wxStyledTextCtrl_SetTargetEnd" (byval self as integer,byval pos as integer) as integer
declare function wxStyledTextCtrl_GetTargetEnd cdecl alias "wxStyledTextCtrl_GetTargetEnd" (byval self as integer) as integer
declare function wxStyledTextCtrl_ReplaceTarget cdecl alias "wxStyledTextCtrl_ReplaceTarget" (byval self as integer,byval text as string) as integer
declare function wxStyledTextCtrl_ReplaceTargetRE cdecl alias "wxStyledTextCtrl_ReplaceTargetRE" (byval self as integer,byval text as string) as integer
declare function wxStyledTextCtrl_SearchInTarget cdecl alias "wxStyledTextCtrl_SearchInTarget" (byval self as integer,byval text as string) as integer
declare function wxStyledTextCtrl_SetSearchFlags cdecl alias "wxStyledTextCtrl_SetSearchFlags" (byval self as integer,byval flags as integer) as integer
declare function wxStyledTextCtrl_GetSearchFlags cdecl alias "wxStyledTextCtrl_GetSearchFlags" (byval self as integer) as integer
declare function wxStyledTextCtrl_CallTipShow cdecl alias "wxStyledTextCtrl_CallTipShow" (byval self as integer,byval pos as integer,byval definition as string) as integer
declare function wxStyledTextCtrl_CallTipCancel cdecl alias "wxStyledTextCtrl_CallTipCancel" (byval self as integer) as integer
declare function wxStyledTextCtrl_CallTipActive cdecl alias "wxStyledTextCtrl_CallTipActive" (byval self as integer) as integer
declare function wxStyledTextCtrl_CallTipPosAtStart cdecl alias "wxStyledTextCtrl_CallTipPosAtStart" (byval self as integer) as integer
declare function wxStyledTextCtrl_CallTipSetHighlight cdecl alias "wxStyledTextCtrl_CallTipSetHighlight" (byval self as integer,byval start as integer,byval end as integer) as integer
declare function wxStyledTextCtrl_CallTipSetBackground cdecl alias "wxStyledTextCtrl_CallTipSetBackground" (byval self as integer,byval back as integer) as integer
declare function wxStyledTextCtrl_CallTipSetForeground cdecl alias "wxStyledTextCtrl_CallTipSetForeground" (byval self as integer,byval fore as integer) as integer
declare function wxStyledTextCtrl_CallTipSetForegroundHighlight cdecl alias "wxStyledTextCtrl_CallTipSetForegroundHighlight" (byval self as integer,byval fore as integer) as integer
declare function wxStyledTextCtrl_VisibleFromDocLine cdecl alias "wxStyledTextCtrl_VisibleFromDocLine" (byval self as integer,byval line as integer) as integer
declare function wxStyledTextCtrl_DocLineFromVisible cdecl alias "wxStyledTextCtrl_DocLineFromVisible" (byval self as integer,byval lineDisplay as integer) as integer
declare function wxStyledTextCtrl_SetFoldLevel cdecl alias "wxStyledTextCtrl_SetFoldLevel" (byval self as integer,byval line as integer,byval level as integer) as integer
declare function wxStyledTextCtrl_GetFoldLevel cdecl alias "wxStyledTextCtrl_GetFoldLevel" (byval self as integer,byval line as integer) as integer
declare function wxStyledTextCtrl_GetLastChild cdecl alias "wxStyledTextCtrl_GetLastChild" (byval self as integer,byval line as integer,byval level as integer) as integer
declare function wxStyledTextCtrl_GetFoldParent cdecl alias "wxStyledTextCtrl_GetFoldParent" (byval self as integer,byval line as integer) as integer
declare function wxStyledTextCtrl_ShowLines cdecl alias "wxStyledTextCtrl_ShowLines" (byval self as integer,byval lineStart as integer,byval lineEnd as integer) as integer
declare function wxStyledTextCtrl_HideLines cdecl alias "wxStyledTextCtrl_HideLines" (byval self as integer,byval lineStart as integer,byval lineEnd as integer) as integer
declare function wxStyledTextCtrl_GetLineVisible cdecl alias "wxStyledTextCtrl_GetLineVisible" (byval self as integer,byval line as integer) as integer
declare function wxStyledTextCtrl_SetFoldExpanded cdecl alias "wxStyledTextCtrl_SetFoldExpanded" (byval self as integer,byval line as integer,byval expanded as integer) as integer
declare function wxStyledTextCtrl_GetFoldExpanded cdecl alias "wxStyledTextCtrl_GetFoldExpanded" (byval self as integer,byval line as integer) as integer
declare function wxStyledTextCtrl_ToggleFold cdecl alias "wxStyledTextCtrl_ToggleFold" (byval self as integer,byval line as integer) as integer
declare function wxStyledTextCtrl_EnsureVisible cdecl alias "wxStyledTextCtrl_EnsureVisible" (byval self as integer,byval line as integer) as integer
declare function wxStyledTextCtrl_SetFoldFlags cdecl alias "wxStyledTextCtrl_SetFoldFlags" (byval self as integer,byval flags as integer) as integer
declare function wxStyledTextCtrl_EnsureVisibleEnforcePolicy cdecl alias "wxStyledTextCtrl_EnsureVisibleEnforcePolicy" (byval self as integer,byval line as integer) as integer
declare function wxStyledTextCtrl_SetTabIndents cdecl alias "wxStyledTextCtrl_SetTabIndents" (byval self as integer,byval tabIndents as integer) as integer
declare function wxStyledTextCtrl_GetTabIndents cdecl alias "wxStyledTextCtrl_GetTabIndents" (byval self as integer) as integer
declare function wxStyledTextCtrl_SetBackSpaceUnIndents cdecl alias "wxStyledTextCtrl_SetBackSpaceUnIndents" (byval self as integer,byval bsUnIndents as integer) as integer
declare function wxStyledTextCtrl_GetBackSpaceUnIndents cdecl alias "wxStyledTextCtrl_GetBackSpaceUnIndents" (byval self as integer) as integer
declare function wxStyledTextCtrl_SetMouseDwellTime cdecl alias "wxStyledTextCtrl_SetMouseDwellTime" (byval self as integer,byval periodMilliseconds as integer) as integer
declare function wxStyledTextCtrl_GetMouseDwellTime cdecl alias "wxStyledTextCtrl_GetMouseDwellTime" (byval self as integer) as integer
declare function wxStyledTextCtrl_WordStartPosition cdecl alias "wxStyledTextCtrl_WordStartPosition" (byval self as integer,byval pos as integer,byval onlyWordCharacters as integer) as integer
declare function wxStyledTextCtrl_WordEndPosition cdecl alias "wxStyledTextCtrl_WordEndPosition" (byval self as integer,byval pos as integer,byval onlyWordCharacters as integer) as integer
declare function wxStyledTextCtrl_SetWrapMode cdecl alias "wxStyledTextCtrl_SetWrapMode" (byval self as integer,byval mode as integer) as integer
declare function wxStyledTextCtrl_GetWrapMode cdecl alias "wxStyledTextCtrl_GetWrapMode" (byval self as integer) as integer
declare function wxStyledTextCtrl_SetLayoutCache cdecl alias "wxStyledTextCtrl_SetLayoutCache" (byval self as integer,byval mode as integer) as integer
declare function wxStyledTextCtrl_GetLayoutCache cdecl alias "wxStyledTextCtrl_GetLayoutCache" (byval self as integer) as integer
declare function wxStyledTextCtrl_SetScrollWidth cdecl alias "wxStyledTextCtrl_SetScrollWidth" (byval self as integer,byval pixelWidth as integer) as integer
declare function wxStyledTextCtrl_GetScrollWidth cdecl alias "wxStyledTextCtrl_GetScrollWidth" (byval self as integer) as integer
declare function wxStyledTextCtrl_TextWidth cdecl alias "wxStyledTextCtrl_TextWidth" (byval self as integer,byval style as integer,byval text as string) as integer
declare function wxStyledTextCtrl_SetEndAtLastLine cdecl alias "wxStyledTextCtrl_SetEndAtLastLine" (byval self as integer,byval endAtLastLine as integer) as integer
declare function wxStyledTextCtrl_GetEndAtLastLine cdecl alias "wxStyledTextCtrl_GetEndAtLastLine" (byval self as integer) as integer
declare function wxStyledTextCtrl_TextHeight cdecl alias "wxStyledTextCtrl_TextHeight" (byval self as integer,byval line as integer) as integer
declare function wxStyledTextCtrl_SetUseVerticalScrollBar cdecl alias "wxStyledTextCtrl_SetUseVerticalScrollBar" (byval self as integer,byval show as integer) as integer
declare function wxStyledTextCtrl_GetUseVerticalScrollBar cdecl alias "wxStyledTextCtrl_GetUseVerticalScrollBar" (byval self as integer) as integer
declare function wxStyledTextCtrl_AppendText cdecl alias "wxStyledTextCtrl_AppendText" (byval self as integer,byval length as integer,byval text as string) as integer
declare function wxStyledTextCtrl_GetTwoPhaseDraw cdecl alias "wxStyledTextCtrl_GetTwoPhaseDraw" (byval self as integer) as integer
declare function wxStyledTextCtrl_SetTwoPhaseDraw cdecl alias "wxStyledTextCtrl_SetTwoPhaseDraw" (byval self as integer,byval twoPhase as integer) as integer
declare function wxStyledTextCtrl_TargetFromSelection cdecl alias "wxStyledTextCtrl_TargetFromSelection" (byval self as integer) as integer
declare function wxStyledTextCtrl_LinesJoin cdecl alias "wxStyledTextCtrl_LinesJoin" (byval self as integer) as integer
declare function wxStyledTextCtrl_LinesSplit cdecl alias "wxStyledTextCtrl_LinesSplit" (byval self as integer,byval pixelWidth as integer) as integer
declare function wxStyledTextCtrl_SetFoldMarginColour cdecl alias "wxStyledTextCtrl_SetFoldMarginColour" (byval self as integer,byval useSetting as integer,byval back as integer) as integer
declare function wxStyledTextCtrl_SetFoldMarginHiColour cdecl alias "wxStyledTextCtrl_SetFoldMarginHiColour" (byval self as integer,byval useSetting as integer,byval fore as integer) as integer
declare function wxStyledTextCtrl_LineDuplicate cdecl alias "wxStyledTextCtrl_LineDuplicate" (byval self as integer) as integer
declare function wxStyledTextCtrl_HomeDisplay cdecl alias "wxStyledTextCtrl_HomeDisplay" (byval self as integer) as integer
declare function wxStyledTextCtrl_HomeDisplayExtend cdecl alias "wxStyledTextCtrl_HomeDisplayExtend" (byval self as integer) as integer
declare function wxStyledTextCtrl_LineEndDisplay cdecl alias "wxStyledTextCtrl_LineEndDisplay" (byval self as integer) as integer
declare function wxStyledTextCtrl_LineEndDisplayExtend cdecl alias "wxStyledTextCtrl_LineEndDisplayExtend" (byval self as integer) as integer
declare function wxStyledTextCtrl_MoveCaretInsideView cdecl alias "wxStyledTextCtrl_MoveCaretInsideView" (byval self as integer) as integer
declare function wxStyledTextCtrl_LineLength cdecl alias "wxStyledTextCtrl_LineLength" (byval self as integer,byval line as integer) as integer
declare function wxStyledTextCtrl_BraceHighlight cdecl alias "wxStyledTextCtrl_BraceHighlight" (byval self as integer,byval pos1 as integer,byval pos2 as integer) as integer
declare function wxStyledTextCtrl_BraceBadLight cdecl alias "wxStyledTextCtrl_BraceBadLight" (byval self as integer,byval pos as integer) as integer
declare function wxStyledTextCtrl_BraceMatch cdecl alias "wxStyledTextCtrl_BraceMatch" (byval self as integer,byval pos as integer) as integer
declare function wxStyledTextCtrl_GetViewEOL cdecl alias "wxStyledTextCtrl_GetViewEOL" (byval self as integer) as integer
declare function wxStyledTextCtrl_SetViewEOL cdecl alias "wxStyledTextCtrl_SetViewEOL" (byval self as integer,byval visible as integer) as integer
declare function wxStyledTextCtrl_GetDocPointer cdecl alias "wxStyledTextCtrl_GetDocPointer" (byval self as integer) as integer
declare function wxStyledTextCtrl_SetDocPointer cdecl alias "wxStyledTextCtrl_SetDocPointer" (byval self as integer,byval docPointer as integer) as integer
declare function wxStyledTextCtrl_SetModEventMask cdecl alias "wxStyledTextCtrl_SetModEventMask" (byval self as integer,byval mask as integer) as integer
declare function wxStyledTextCtrl_GetEdgeColumn cdecl alias "wxStyledTextCtrl_GetEdgeColumn" (byval self as integer) as integer
declare function wxStyledTextCtrl_SetEdgeColumn cdecl alias "wxStyledTextCtrl_SetEdgeColumn" (byval self as integer,byval column as integer) as integer
declare function wxStyledTextCtrl_GetEdgeMode cdecl alias "wxStyledTextCtrl_GetEdgeMode" (byval self as integer) as integer
declare function wxStyledTextCtrl_SetEdgeMode cdecl alias "wxStyledTextCtrl_SetEdgeMode" (byval self as integer,byval mode as integer) as integer
declare function wxStyledTextCtrl_GetEdgeColour cdecl alias "wxStyledTextCtrl_GetEdgeColour" (byval self as integer) as integer
declare function wxStyledTextCtrl_SetEdgeColour cdecl alias "wxStyledTextCtrl_SetEdgeColour" (byval self as integer,byval edgeColour as integer) as integer
declare function wxStyledTextCtrl_SearchAnchor cdecl alias "wxStyledTextCtrl_SearchAnchor" (byval self as integer) as integer
declare function wxStyledTextCtrl_SearchNext cdecl alias "wxStyledTextCtrl_SearchNext" (byval self as integer,byval flags as integer,byval text as string) as integer
declare function wxStyledTextCtrl_SearchPrev cdecl alias "wxStyledTextCtrl_SearchPrev" (byval self as integer,byval flags as integer,byval text as string) as integer
declare function wxStyledTextCtrl_LinesOnScreen cdecl alias "wxStyledTextCtrl_LinesOnScreen" (byval self as integer) as integer
declare function wxStyledTextCtrl_UsePopUp cdecl alias "wxStyledTextCtrl_UsePopUp" (byval self as integer,byval allowPopUp as integer) as integer
declare function wxStyledTextCtrl_SelectionIsRectangle cdecl alias "wxStyledTextCtrl_SelectionIsRectangle" (byval self as integer) as integer
declare function wxStyledTextCtrl_SetZoom cdecl alias "wxStyledTextCtrl_SetZoom" (byval self as integer,byval zoom as integer) as integer
declare function wxStyledTextCtrl_GetZoom cdecl alias "wxStyledTextCtrl_GetZoom" (byval self as integer) as integer
declare function wxStyledTextCtrl_CreateDocument cdecl alias "wxStyledTextCtrl_CreateDocument" (byval self as integer) as integer
declare function wxStyledTextCtrl_AddRefDocument cdecl alias "wxStyledTextCtrl_AddRefDocument" (byval self as integer,byval docPointer as integer) as integer
declare function wxStyledTextCtrl_ReleaseDocument cdecl alias "wxStyledTextCtrl_ReleaseDocument" (byval self as integer,byval docPointer as integer) as integer
declare function wxStyledTextCtrl_GetModEventMask cdecl alias "wxStyledTextCtrl_GetModEventMask" (byval self as integer) as integer
declare function wxStyledTextCtrl_SetSTCFocus cdecl alias "wxStyledTextCtrl_SetSTCFocus" (byval self as integer,byval focus as integer) as integer
declare function wxStyledTextCtrl_GetSTCFocus cdecl alias "wxStyledTextCtrl_GetSTCFocus" (byval self as integer) as integer
declare function wxStyledTextCtrl_SetStatus cdecl alias "wxStyledTextCtrl_SetStatus" (byval self as integer,byval statusCode as integer) as integer
declare function wxStyledTextCtrl_GetStatus cdecl alias "wxStyledTextCtrl_GetStatus" (byval self as integer) as integer
declare function wxStyledTextCtrl_SetMouseDownCaptures cdecl alias "wxStyledTextCtrl_SetMouseDownCaptures" (byval self as integer,byval captures as integer) as integer
declare function wxStyledTextCtrl_GetMouseDownCaptures cdecl alias "wxStyledTextCtrl_GetMouseDownCaptures" (byval self as integer) as integer
declare function wxStyledTextCtrl_SetSTCCursor cdecl alias "wxStyledTextCtrl_SetSTCCursor" (byval self as integer,byval cursorType as integer) as integer
declare function wxStyledTextCtrl_GetSTCCursor cdecl alias "wxStyledTextCtrl_GetSTCCursor" (byval self as integer) as integer
declare function wxStyledTextCtrl_SetControlCharSymbol cdecl alias "wxStyledTextCtrl_SetControlCharSymbol" (byval self as integer,byval symbol as integer) as integer
declare function wxStyledTextCtrl_GetControlCharSymbol cdecl alias "wxStyledTextCtrl_GetControlCharSymbol" (byval self as integer) as integer
declare function wxStyledTextCtrl_WordPartLeft cdecl alias "wxStyledTextCtrl_WordPartLeft" (byval self as integer) as integer
declare function wxStyledTextCtrl_WordPartLeftExtend cdecl alias "wxStyledTextCtrl_WordPartLeftExtend" (byval self as integer) as integer
declare function wxStyledTextCtrl_WordPartRight cdecl alias "wxStyledTextCtrl_WordPartRight" (byval self as integer) as integer
declare function wxStyledTextCtrl_WordPartRightExtend cdecl alias "wxStyledTextCtrl_WordPartRightExtend" (byval self as integer) as integer
declare function wxStyledTextCtrl_SetVisiblePolicy cdecl alias "wxStyledTextCtrl_SetVisiblePolicy" (byval self as integer,byval visiblePolicy as integer,byval visibleSlop as integer) as integer
declare function wxStyledTextCtrl_DelLineLeft cdecl alias "wxStyledTextCtrl_DelLineLeft" (byval self as integer) as integer
declare function wxStyledTextCtrl_DelLineRight cdecl alias "wxStyledTextCtrl_DelLineRight" (byval self as integer) as integer
declare function wxStyledTextCtrl_SetXOffset cdecl alias "wxStyledTextCtrl_SetXOffset" (byval self as integer,byval newOffset as integer) as integer
declare function wxStyledTextCtrl_GetXOffset cdecl alias "wxStyledTextCtrl_GetXOffset" (byval self as integer) as integer
declare function wxStyledTextCtrl_ChooseCaretX cdecl alias "wxStyledTextCtrl_ChooseCaretX" (byval self as integer) as integer
declare function wxStyledTextCtrl_SetXCaretPolicy cdecl alias "wxStyledTextCtrl_SetXCaretPolicy" (byval self as integer,byval caretPolicy as integer,byval caretSlop as integer) as integer
declare function wxStyledTextCtrl_SetYCaretPolicy cdecl alias "wxStyledTextCtrl_SetYCaretPolicy" (byval self as integer,byval caretPolicy as integer,byval caretSlop as integer) as integer
declare function wxStyledTextCtrl_SetPrintWrapMode cdecl alias "wxStyledTextCtrl_SetPrintWrapMode" (byval self as integer,byval mode as integer) as integer
declare function wxStyledTextCtrl_GetPrintWrapMode cdecl alias "wxStyledTextCtrl_GetPrintWrapMode" (byval self as integer) as integer
declare function wxStyledTextCtrl_SetHotspotActiveForeground cdecl alias "wxStyledTextCtrl_SetHotspotActiveForeground" (byval self as integer,byval useSetting as integer,byval fore as integer) as integer
declare function wxStyledTextCtrl_SetHotspotActiveBackground cdecl alias "wxStyledTextCtrl_SetHotspotActiveBackground" (byval self as integer,byval useSetting as integer,byval back as integer) as integer
declare function wxStyledTextCtrl_SetHotspotActiveUnderline cdecl alias "wxStyledTextCtrl_SetHotspotActiveUnderline" (byval self as integer,byval underline as integer) as integer
declare function wxStyledTextCtrl_StartRecord cdecl alias "wxStyledTextCtrl_StartRecord" (byval self as integer) as integer
declare function wxStyledTextCtrl_StopRecord cdecl alias "wxStyledTextCtrl_StopRecord" (byval self as integer) as integer
declare function wxStyledTextCtrl_SetLexer cdecl alias "wxStyledTextCtrl_SetLexer" (byval self as integer,byval lexer as integer) as integer
declare function wxStyledTextCtrl_GetLexer cdecl alias "wxStyledTextCtrl_GetLexer" (byval self as integer) as integer
declare function wxStyledTextCtrl_Colourise cdecl alias "wxStyledTextCtrl_Colourise" (byval self as integer,byval start as integer,byval end as integer) as integer
declare function wxStyledTextCtrl_SetProperty cdecl alias "wxStyledTextCtrl_SetProperty" (byval self as integer,byval key as string,byval value as string) as integer
declare function wxStyledTextCtrl_SetKeyWords cdecl alias "wxStyledTextCtrl_SetKeyWords" (byval self as integer,byval keywordSet as integer,byval keyWords as string) as integer
declare function wxStyledTextCtrl_SetLexerLanguage cdecl alias "wxStyledTextCtrl_SetLexerLanguage" (byval self as integer,byval language as string) as integer
declare function wxStyledTextCtrl_GetCurrentLine cdecl alias "wxStyledTextCtrl_GetCurrentLine" (byval self as integer) as integer
declare function wxStyledTextCtrl_StyleSetSpec cdecl alias "wxStyledTextCtrl_StyleSetSpec" (byval self as integer,byval styleNum as integer,byval spec as string) as integer
declare function wxStyledTextCtrl_StyleSetFont cdecl alias "wxStyledTextCtrl_StyleSetFont" (byval self as integer,byval styleNum as integer,byval font as integer) as integer
declare function wxStyledTextCtrl_StyleSetFontAttr cdecl alias "wxStyledTextCtrl_StyleSetFontAttr" (byval self as integer,byval styleNum as integer,byval size as integer,byval faceName as string,byval bold as integer,byval italic as integer,byval underline as integer) as integer
declare function wxStyledTextCtrl_CmdKeyExecute cdecl alias "wxStyledTextCtrl_CmdKeyExecute" (byval self as integer,byval cmd as integer) as integer
declare function wxStyledTextCtrl_SetMargins cdecl alias "wxStyledTextCtrl_SetMargins" (byval self as integer,byval left as integer,byval right as integer) as integer
declare function wxStyledTextCtrl_GetSelection cdecl alias "wxStyledTextCtrl_GetSelection" (byval self as integer,byval startPos as integer,byval endPos as integer) as integer
declare function wxStyledTextCtrl_PointFromPosition cdecl alias "wxStyledTextCtrl_PointFromPosition" (byval self as integer,byval pos as integer,byval pt as integer) as integer
declare function wxStyledTextCtrl_ScrollToLine cdecl alias "wxStyledTextCtrl_ScrollToLine" (byval self as integer,byval line as integer) as integer
declare function wxStyledTextCtrl_ScrollToColumn cdecl alias "wxStyledTextCtrl_ScrollToColumn" (byval self as integer,byval column as integer) as integer
declare function wxStyledTextCtrl_SendMsg cdecl alias "wxStyledTextCtrl_SendMsg" (byval self as integer,byval msg as integer,byval wp as long,byval lp as long) as long
declare function wxStyledTextCtrl_SetVScrollBar cdecl alias "wxStyledTextCtrl_SetVScrollBar" (byval self as integer,byval bar as integer) as integer
declare function wxStyledTextCtrl_SetHScrollBar cdecl alias "wxStyledTextCtrl_SetHScrollBar" (byval self as integer,byval bar as integer) as integer
declare function wxStyledTextCtrl_GetLastKeydownProcessed cdecl alias "wxStyledTextCtrl_GetLastKeydownProcessed" (byval self as integer) as integer
declare function wxStyledTextCtrl_SetLastKeydownProcessed cdecl alias "wxStyledTextCtrl_SetLastKeydownProcessed" (byval self as integer,byval val as integer) as integer
declare function wxStyledTextCtrl_SaveFile cdecl alias "wxStyledTextCtrl_SaveFile" (byval self as integer,byval filename as string) as integer
declare function wxStyledTextCtrl_LoadFile cdecl alias "wxStyledTextCtrl_LoadFile" (byval self as integer,byval filename as string) as integer
declare function wxStyledTextEvent_ctor cdecl alias "wxStyledTextEvent_ctor" (byval commandType as integer,byval id as integer) as integer
declare function wxStyledTextEvent_SetPosition cdecl alias "wxStyledTextEvent_SetPosition" (byval self as integer,byval pos as integer) as integer
declare function wxStyledTextEvent_SetKey cdecl alias "wxStyledTextEvent_SetKey" (byval self as integer,byval k as integer) as integer
declare function wxStyledTextEvent_SetModifiers cdecl alias "wxStyledTextEvent_SetModifiers" (byval self as integer,byval m as integer) as integer
declare function wxStyledTextEvent_SetModificationType cdecl alias "wxStyledTextEvent_SetModificationType" (byval self as integer,byval t as integer) as integer
declare function wxStyledTextEvent_SetText cdecl alias "wxStyledTextEvent_SetText" (byval self as integer,byval t as string) as integer
declare function wxStyledTextEvent_SetLength cdecl alias "wxStyledTextEvent_SetLength" (byval self as integer,byval len as integer) as integer
declare function wxStyledTextEvent_SetLinesAdded cdecl alias "wxStyledTextEvent_SetLinesAdded" (byval self as integer,byval num as integer) as integer
declare function wxStyledTextEvent_SetLine cdecl alias "wxStyledTextEvent_SetLine" (byval self as integer,byval val as integer) as integer
declare function wxStyledTextEvent_SetFoldLevelNow cdecl alias "wxStyledTextEvent_SetFoldLevelNow" (byval self as integer,byval val as integer) as integer
declare function wxStyledTextEvent_SetFoldLevelPrev cdecl alias "wxStyledTextEvent_SetFoldLevelPrev" (byval self as integer,byval val as integer) as integer
declare function wxStyledTextEvent_SetMargin cdecl alias "wxStyledTextEvent_SetMargin" (byval self as integer,byval val as integer) as integer
declare function wxStyledTextEvent_SetMessage cdecl alias "wxStyledTextEvent_SetMessage" (byval self as integer,byval val as integer) as integer
declare function wxStyledTextEvent_SetWParam cdecl alias "wxStyledTextEvent_SetWParam" (byval self as integer,byval val as integer) as integer
declare function wxStyledTextEvent_SetLParam cdecl alias "wxStyledTextEvent_SetLParam" (byval self as integer,byval val as integer) as integer
declare function wxStyledTextEvent_SetListType cdecl alias "wxStyledTextEvent_SetListType" (byval self as integer,byval val as integer) as integer
declare function wxStyledTextEvent_SetX cdecl alias "wxStyledTextEvent_SetX" (byval self as integer,byval val as integer) as integer
declare function wxStyledTextEvent_SetY cdecl alias "wxStyledTextEvent_SetY" (byval self as integer,byval val as integer) as integer
declare function wxStyledTextEvent_SetDragText cdecl alias "wxStyledTextEvent_SetDragText" (byval self as integer,byval val as string) as integer
declare function wxStyledTextEvent_SetDragAllowMove cdecl alias "wxStyledTextEvent_SetDragAllowMove" (byval self as integer,byval val as integer) as integer
declare function wxStyledTextEvent_SetDragResult cdecl alias "wxStyledTextEvent_SetDragResult" (byval self as integer,byval val as integer) as integer
declare function wxStyledTextEvent_GetPosition cdecl alias "wxStyledTextEvent_GetPosition" (byval self as integer) as integer
declare function wxStyledTextEvent_GetKey cdecl alias "wxStyledTextEvent_GetKey" (byval self as integer) as integer
declare function wxStyledTextEvent_GetModifiers cdecl alias "wxStyledTextEvent_GetModifiers" (byval self as integer) as integer
declare function wxStyledTextEvent_GetModificationType cdecl alias "wxStyledTextEvent_GetModificationType" (byval self as integer) as integer
declare function wxStyledTextEvent_GetText cdecl alias "wxStyledTextEvent_GetText" (byval self as integer) as byte ptr
declare function wxStyledTextEvent_GetLength cdecl alias "wxStyledTextEvent_GetLength" (byval self as integer) as integer
declare function wxStyledTextEvent_GetLinesAdded cdecl alias "wxStyledTextEvent_GetLinesAdded" (byval self as integer) as integer
declare function wxStyledTextEvent_GetLine cdecl alias "wxStyledTextEvent_GetLine" (byval self as integer) as integer
declare function wxStyledTextEvent_GetFoldLevelNow cdecl alias "wxStyledTextEvent_GetFoldLevelNow" (byval self as integer) as integer
declare function wxStyledTextEvent_GetFoldLevelPrev cdecl alias "wxStyledTextEvent_GetFoldLevelPrev" (byval self as integer) as integer
declare function wxStyledTextEvent_GetMargin cdecl alias "wxStyledTextEvent_GetMargin" (byval self as integer) as integer
declare function wxStyledTextEvent_GetMessage cdecl alias "wxStyledTextEvent_GetMessage" (byval self as integer) as integer
declare function wxStyledTextEvent_GetWParam cdecl alias "wxStyledTextEvent_GetWParam" (byval self as integer) as integer
declare function wxStyledTextEvent_GetLParam cdecl alias "wxStyledTextEvent_GetLParam" (byval self as integer) as integer
declare function wxStyledTextEvent_GetListType cdecl alias "wxStyledTextEvent_GetListType" (byval self as integer) as integer
declare function wxStyledTextEvent_GetX cdecl alias "wxStyledTextEvent_GetX" (byval self as integer) as integer
declare function wxStyledTextEvent_GetY cdecl alias "wxStyledTextEvent_GetY" (byval self as integer) as integer
declare function wxStyledTextEvent_GetDragText cdecl alias "wxStyledTextEvent_GetDragText" (byval self as integer) as byte ptr
declare function wxStyledTextEvent_GetDragAllowMove cdecl alias "wxStyledTextEvent_GetDragAllowMove" (byval self as integer) as integer
declare function wxStyledTextEvent_GetDragResult cdecl alias "wxStyledTextEvent_GetDragResult" (byval self as integer) as integer
declare function wxStyledTextEvent_GetShift cdecl alias "wxStyledTextEvent_GetShift" (byval self as integer) as integer
declare function wxStyledTextEvent_GetControl cdecl alias "wxStyledTextEvent_GetControl" (byval self as integer) as integer
declare function wxStyledTextEvent_GetAlt cdecl alias "wxStyledTextEvent_GetAlt" (byval self as integer) as integer
declare function wxSysColourChangedEvent_ctor cdecl alias "wxSysColourChangedEvent_ctor" () as integer
declare function wxSystemSettings_GetColour cdecl alias "wxSystemSettings_GetColour" (byval index as integer) as integer
declare function wxSystemSettings_GetFont cdecl alias "wxSystemSettings_GetFont" (byval index as integer) as integer
declare function wxSystemSettings_GetMetric cdecl alias "wxSystemSettings_GetMetric" (byval index as integer) as integer
declare function wxSystemSettings_HasFeature cdecl alias "wxSystemSettings_HasFeature" (byval index as integer) as integer
declare function wxSystemSettings_GetScreenType cdecl alias "wxSystemSettings_GetScreenType" () as integer
declare function wxSystemSettings_SetScreenType cdecl alias "wxSystemSettings_SetScreenType" (byval screen as integer) as integer
declare function wxTextAttr_ctor cdecl alias "wxTextAttr_ctor" (byval colText as integer,byval colBack as integer,byval font as integer,byval alignment as integer) as integer
declare function wxTextAttr_ctor2 cdecl alias "wxTextAttr_ctor2" () as integer
declare function wxTextAttr_dtor cdecl alias "wxTextAttr_dtor" (byval self as integer) as integer
declare function wxTextAttr_Init cdecl alias "wxTextAttr_Init" (byval self as integer) as integer
declare function wxTextAttr_SetTextColour cdecl alias "wxTextAttr_SetTextColour" (byval self as integer,byval colText as integer) as integer
declare function wxTextAttr_GetTextColour cdecl alias "wxTextAttr_GetTextColour" (byval self as integer) as integer
declare function wxTextAttr_SetBackgroundColour cdecl alias "wxTextAttr_SetBackgroundColour" (byval self as integer,byval colBack as integer) as integer
declare function wxTextAttr_SetFont cdecl alias "wxTextAttr_SetFont" (byval self as integer,byval font as integer) as integer
declare function wxTextAttr_HasTextColour cdecl alias "wxTextAttr_HasTextColour" (byval self as integer) as integer
declare function wxTextAttr_HasBackgroundColour cdecl alias "wxTextAttr_HasBackgroundColour" (byval self as integer) as integer
declare function wxTextAttr_HasFont cdecl alias "wxTextAttr_HasFont" (byval self as integer) as integer
declare function wxTextAttr_HasAlignment cdecl alias "wxTextAttr_HasAlignment" (byval self as integer) as integer
declare function wxTextAttr_HasTabs cdecl alias "wxTextAttr_HasTabs" (byval self as integer) as integer
declare function wxTextAttr_HasLeftIndent cdecl alias "wxTextAttr_HasLeftIndent" (byval self as integer) as integer
declare function wxTextAttr_HasRightIndent cdecl alias "wxTextAttr_HasRightIndent" (byval self as integer) as integer
declare function wxTextAttr_HasFlag cdecl alias "wxTextAttr_HasFlag" (byval self as integer,byval flag as long) as integer
declare function wxTextAttr_IsDefault cdecl alias "wxTextAttr_IsDefault" (byval self as integer) as integer
declare function wxTextAttr_SetAlignment cdecl alias "wxTextAttr_SetAlignment" (byval self as integer,byval alignment as integer) as integer
declare function wxTextAttr_GetAlignment cdecl alias "wxTextAttr_GetAlignment" (byval self as integer) as integer
declare function wxTextAttr_GetBackgroundColour cdecl alias "wxTextAttr_GetBackgroundColour" (byval self as integer) as integer
declare function wxTextAttr_GetFont cdecl alias "wxTextAttr_GetFont" (byval self as integer) as integer
declare function wxTextAttr_GetLeftIndent cdecl alias "wxTextAttr_GetLeftIndent" (byval self as integer) as integer
declare function wxTextAttr_GetLeftSubIndent cdecl alias "wxTextAttr_GetLeftSubIndent" (byval self as integer) as integer
declare function wxTextAttr_SetTabs cdecl alias "wxTextAttr_SetTabs" (byval self as integer,byval tabs as integer) as integer
declare function wxTextAttr_GetTabs cdecl alias "wxTextAttr_GetTabs" (byval self as integer) as integer
declare function wxTextAttr_SetLeftIndent cdecl alias "wxTextAttr_SetLeftIndent" (byval self as integer,byval indent as integer,byval subIndent as integer) as integer
declare function wxTextAttr_SetRightIndent cdecl alias "wxTextAttr_SetRightIndent" (byval self as integer,byval indent as integer) as integer
declare function wxTextAttr_GetRightIndent cdecl alias "wxTextAttr_GetRightIndent" (byval self as integer) as integer
declare function wxTextAttr_SetFlags cdecl alias "wxTextAttr_SetFlags" (byval self as integer,byval flags as long) as integer
declare function wxTextAttr_GetFlags cdecl alias "wxTextAttr_GetFlags" (byval self as integer) as long
declare function wxTextCtrl_GetValue cdecl alias "wxTextCtrl_GetValue" (byval self as integer) as byte ptr
declare function wxTextCtrl_SetValue cdecl alias "wxTextCtrl_SetValue" (byval self as integer,byval value as string) as integer
declare function wxTextCtrl_GetRange cdecl alias "wxTextCtrl_GetRange" (byval self as integer,byval from as long,byval to as long) as byte ptr
declare function wxTextCtrl_GetLineLength cdecl alias "wxTextCtrl_GetLineLength" (byval self as integer,byval lineNo as long) as integer
declare function wxTextCtrl_GetLineText cdecl alias "wxTextCtrl_GetLineText" (byval self as integer,byval lineNo as long) as byte ptr
declare function wxTextCtrl_GetNumberOfLines cdecl alias "wxTextCtrl_GetNumberOfLines" (byval self as integer) as integer
declare function wxTextCtrl_IsModified cdecl alias "wxTextCtrl_IsModified" (byval self as integer) as integer
declare function wxTextCtrl_IsEditable cdecl alias "wxTextCtrl_IsEditable" (byval self as integer) as integer
declare function wxTextCtrl_IsSingleLine cdecl alias "wxTextCtrl_IsSingleLine" (byval self as integer) as integer
declare function wxTextCtrl_IsMultiLine cdecl alias "wxTextCtrl_IsMultiLine" (byval self as integer) as integer
declare function wxTextCtrl_GetSelection cdecl alias "wxTextCtrl_GetSelection" (byval self as integer,byval from as integer,byval to as integer) as integer
declare function wxTextCtrl_GetStringSelection cdecl alias "wxTextCtrl_GetStringSelection" (byval self as integer) as byte ptr
declare function wxTextCtrl_Clear cdecl alias "wxTextCtrl_Clear" (byval self as integer) as integer
declare function wxTextCtrl_Replace cdecl alias "wxTextCtrl_Replace" (byval self as integer,byval from as long,byval to as long,byval value as string) as integer
declare function wxTextCtrl_Remove cdecl alias "wxTextCtrl_Remove" (byval self as integer,byval from as long,byval to as long) as integer
declare function wxTextCtrl_LoadFile cdecl alias "wxTextCtrl_LoadFile" (byval self as integer,byval file as string) as integer
declare function wxTextCtrl_SaveFile cdecl alias "wxTextCtrl_SaveFile" (byval self as integer,byval file as string) as integer
declare function wxTextCtrl_DiscardEdits cdecl alias "wxTextCtrl_DiscardEdits" (byval self as integer) as integer
declare function wxTextCtrl_SetMaxLength cdecl alias "wxTextCtrl_SetMaxLength" (byval self as integer,byval len as unsigned long) as integer
declare function wxTextCtrl_WriteText cdecl alias "wxTextCtrl_WriteText" (byval self as integer,byval text as string) as integer
declare function wxTextCtrl_AppendText cdecl alias "wxTextCtrl_AppendText" (byval self as integer,byval text as string) as integer
declare function wxTextCtrl_EmulateKeyPress cdecl alias "wxTextCtrl_EmulateKeyPress" (byval self as integer,byval event as integer) as integer
declare function wxTextCtrl_SetStyle cdecl alias "wxTextCtrl_SetStyle" (byval self as integer,byval start as long,byval end as long,byval style as integer) as integer
declare function wxTextCtrl_GetStyle cdecl alias "wxTextCtrl_GetStyle" (byval self as integer,byval position as long,byval style as integer) as integer
declare function wxTextCtrl_SetDefaultStyle cdecl alias "wxTextCtrl_SetDefaultStyle" (byval self as integer,byval style as integer) as integer
declare function wxTextCtrl_GetDefaultStyle cdecl alias "wxTextCtrl_GetDefaultStyle" (byval self as integer) as integer
declare function wxTextCtrl_XYToPosition cdecl alias "wxTextCtrl_XYToPosition" (byval self as integer,byval x as long,byval y as long) as long
declare function wxTextCtrl_PositionToXY cdecl alias "wxTextCtrl_PositionToXY" (byval self as integer,byval pos as long,byval x as integer,byval y as integer) as integer
declare function wxTextCtrl_ShowPosition cdecl alias "wxTextCtrl_ShowPosition" (byval self as integer,byval pos as long) as integer
declare function wxTextCtrl_Copy cdecl alias "wxTextCtrl_Copy" (byval self as integer) as integer
declare function wxTextCtrl_Cut cdecl alias "wxTextCtrl_Cut" (byval self as integer) as integer
declare function wxTextCtrl_Paste cdecl alias "wxTextCtrl_Paste" (byval self as integer) as integer
declare function wxTextCtrl_CanCopy cdecl alias "wxTextCtrl_CanCopy" (byval self as integer) as integer
declare function wxTextCtrl_CanCut cdecl alias "wxTextCtrl_CanCut" (byval self as integer) as integer
declare function wxTextCtrl_CanPaste cdecl alias "wxTextCtrl_CanPaste" (byval self as integer) as integer
declare function wxTextCtrl_Undo cdecl alias "wxTextCtrl_Undo" (byval self as integer) as integer
declare function wxTextCtrl_Redo cdecl alias "wxTextCtrl_Redo" (byval self as integer) as integer
declare function wxTextCtrl_CanUndo cdecl alias "wxTextCtrl_CanUndo" (byval self as integer) as integer
declare function wxTextCtrl_CanRedo cdecl alias "wxTextCtrl_CanRedo" (byval self as integer) as integer
declare function wxTextCtrl_SetInsertionPoint cdecl alias "wxTextCtrl_SetInsertionPoint" (byval self as integer,byval pos as long) as integer
declare function wxTextCtrl_SetInsertionPointEnd cdecl alias "wxTextCtrl_SetInsertionPointEnd" (byval self as integer) as integer
declare function wxTextCtrl_GetInsertionPoint cdecl alias "wxTextCtrl_GetInsertionPoint" (byval self as integer) as long
declare function wxTextCtrl_GetLastPosition cdecl alias "wxTextCtrl_GetLastPosition" (byval self as integer) as long
declare function wxTextCtrl_SetSelection cdecl alias "wxTextCtrl_SetSelection" (byval self as integer,byval from as long,byval to as long) as integer
declare function wxTextCtrl_SelectAll cdecl alias "wxTextCtrl_SelectAll" (byval self as integer) as integer
declare function wxTextCtrl_SetEditable cdecl alias "wxTextCtrl_SetEditable" (byval self as integer,byval editable as integer) as integer
declare function wxTextUrlEvent_ctor cdecl alias "wxTextUrlEvent_ctor" (byval id as integer,byval evtMouse as integer,byval start as long,byval end as long) as integer
declare function wxTextUrlEvent_GetURLStart cdecl alias "wxTextUrlEvent_GetURLStart" (byval self as integer) as long
declare function wxTextUrlEvent_GetURLEnd cdecl alias "wxTextUrlEvent_GetURLEnd" (byval self as integer) as long
declare function wxTextCtrl_ctor cdecl alias "wxTextCtrl_ctor" () as integer
declare function wxTextCtrl_Create cdecl alias "wxTextCtrl_Create" (byval self as integer,byval parent as integer,byval id as integer,byval value as string,byval pos as integer,byval size as integer,byval style as long,byval validator as integer,byval name as string) as integer
declare function wxTextCtrl_Enable cdecl alias "wxTextCtrl_Enable" (byval self as integer,byval enable as integer) as integer
declare function wxTextCtrl_OnDropFiles cdecl alias "wxTextCtrl_OnDropFiles" (byval self as integer,byval event as integer) as integer
declare function wxTextCtrl_SetFont cdecl alias "wxTextCtrl_SetFont" (byval self as integer,byval font as integer) as integer
declare function wxTextCtrl_SetForegroundColour cdecl alias "wxTextCtrl_SetForegroundColour" (byval self as integer,byval colour as integer) as integer
declare function wxTextCtrl_SetBackgroundColour cdecl alias "wxTextCtrl_SetBackgroundColour" (byval self as integer,byval colour as integer) as integer
declare function wxTextCtrl_Freeze cdecl alias "wxTextCtrl_Freeze" (byval self as integer) as integer
declare function wxTextCtrl_Thaw cdecl alias "wxTextCtrl_Thaw" (byval self as integer) as integer
declare function wxTextCtrl_ScrollLines cdecl alias "wxTextCtrl_ScrollLines" (byval self as integer,byval lines as integer) as integer
declare function wxTextCtrl_ScrollPages cdecl alias "wxTextCtrl_ScrollPages" (byval self as integer,byval pages as integer) as integer
declare function wxTextCtrl_MarkDirty cdecl alias "wxTextCtrl_MarkDirty" (byval self as integer) as integer
declare function wxTextCtrl_HitTest cdecl alias "wxTextCtrl_HitTest" (byval self as integer,byval pt as integer,byval pos as integer) as integer
declare function wxTextCtrl_HitTest2 cdecl alias "wxTextCtrl_HitTest2" (byval self as integer,byval pt as integer,byval col as integer,byval row as integer) as integer
declare function wxTextEntryDialog_ctor cdecl alias "wxTextEntryDialog_ctor" (byval parent as integer,byval message as string,byval caption as string,byval value as string,byval style as integer,byval pos as integer) as integer
declare function wxTextEntryDialog_dtor cdecl alias "wxTextEntryDialog_dtor" (byval self as integer) as integer
declare function wxTextEntryDialog_ShowModal cdecl alias "wxTextEntryDialog_ShowModal" (byval self as integer) as integer
declare function wxTextEntryDialog_SetValue cdecl alias "wxTextEntryDialog_SetValue" (byval self as integer,byval val as string) as integer
declare function wxTextEntryDialog_GetValue cdecl alias "wxTextEntryDialog_GetValue" (byval self as integer) as byte ptr
declare function wxGetPasswordFromUser_func cdecl alias "wxGetPasswordFromUser_func" (byval message as string,byval caption as string,byval defaultValue as string,byval parent as integer) as byte ptr
declare function wxGetTextFromUser_func cdecl alias "wxGetTextFromUser_func" (byval message as string,byval caption as string,byval defaultValue as string,byval parent as integer,byval x as integer,byval y as integer,byval centre as integer) as byte ptr
declare function wxTipProvider_GetCurrentTip cdecl alias "wxTipProvider_GetCurrentTip" () as integer
declare function wxCreateFileTipProvider_func cdecl alias "wxCreateFileTipProvider_func" (byval filename as string,byval currentTip as integer) as integer
declare function wxShowTip_func cdecl alias "wxShowTip_func" (byval parent as integer,byval tipProvider as integer,byval showAtStartup as integer) as integer
declare function wxTipWindow_ctor cdecl alias "wxTipWindow_ctor" (byval parent as integer,byval text as string,byval maxLength as integer,byval rectBound as integer) as integer
declare function wxTipWindow_ctorNoRect cdecl alias "wxTipWindow_ctorNoRect" (byval parent as integer,byval text as string,byval maxLength as integer) as integer
declare function wxTipWindow_SetBoundingRect cdecl alias "wxTipWindow_SetBoundingRect" (byval self as integer,byval rectBound as integer) as integer
declare function wxToggleButton_ctor cdecl alias "wxToggleButton_ctor" () as integer
declare function wxToggleButton_Create cdecl alias "wxToggleButton_Create" (byval self as integer,byval parent as integer,byval id as integer,byval label as string,byval pos as integer,byval size as integer,byval style as long,byval validator as integer,byval name as string) as integer
declare function wxToggleButton_GetValue cdecl alias "wxToggleButton_GetValue" (byval self as integer) as integer
declare function wxToggleButton_SetValue cdecl alias "wxToggleButton_SetValue" (byval self as integer,byval state as integer) as integer
declare function wxToolBarToolBase_ctor cdecl alias "wxToolBarToolBase_ctor" (byval tbar as integer,byval toolid as integer,byval label as string,byval bmpNormal as integer,byval bmpDisabled as integer,byval kind as integer,byval clientData as integer,byval shortHelpString as string,byval longHelpString as string) as integer
declare function wxToolBarToolBase_ctorCtrl cdecl alias "wxToolBarToolBase_ctorCtrl" (byval tbar as integer,byval control as integer) as integer
declare function wxToolBarToolBase_GetId cdecl alias "wxToolBarToolBase_GetId" (byval self as integer) as integer
declare function wxToolBarToolBase_GetControl cdecl alias "wxToolBarToolBase_GetControl" (byval self as integer) as integer
declare function wxToolBarToolBase_GetToolBar cdecl alias "wxToolBarToolBase_GetToolBar" (byval self as integer) as integer
declare function wxToolBarToolBase_IsButton cdecl alias "wxToolBarToolBase_IsButton" (byval self as integer) as integer
declare function wxToolBarToolBase_IsControl cdecl alias "wxToolBarToolBase_IsControl" (byval self as integer) as integer
declare function wxToolBarToolBase_IsSeparator cdecl alias "wxToolBarToolBase_IsSeparator" (byval self as integer) as integer
declare function wxToolBarToolBase_GetStyle cdecl alias "wxToolBarToolBase_GetStyle" (byval self as integer) as integer
declare function wxToolBarToolBase_GetKind cdecl alias "wxToolBarToolBase_GetKind" (byval self as integer) as integer
declare function wxToolBarToolBase_IsEnabled cdecl alias "wxToolBarToolBase_IsEnabled" (byval self as integer) as integer
declare function wxToolBarToolBase_IsToggled cdecl alias "wxToolBarToolBase_IsToggled" (byval self as integer) as integer
declare function wxToolBarToolBase_CanBeToggled cdecl alias "wxToolBarToolBase_CanBeToggled" (byval self as integer) as integer
declare function wxToolBarToolBase_GetLabel cdecl alias "wxToolBarToolBase_GetLabel" (byval self as integer) as byte ptr
declare function wxToolBarToolBase_GetShortHelp cdecl alias "wxToolBarToolBase_GetShortHelp" (byval self as integer) as byte ptr
declare function wxToolBarToolBase_GetLongHelp cdecl alias "wxToolBarToolBase_GetLongHelp" (byval self as integer) as byte ptr
declare function wxToolBarToolBase_GetClientData cdecl alias "wxToolBarToolBase_GetClientData" (byval self as integer) as integer
declare function wxToolBarToolBase_Enable cdecl alias "wxToolBarToolBase_Enable" (byval self as integer,byval enable as integer) as integer
declare function wxToolBarToolBase_Toggle cdecl alias "wxToolBarToolBase_Toggle" (byval self as integer,byval toggle as integer) as integer
declare function wxToolBarToolBase_SetToggle cdecl alias "wxToolBarToolBase_SetToggle" (byval self as integer,byval toggle as integer) as integer
declare function wxToolBarToolBase_SetShortHelp cdecl alias "wxToolBarToolBase_SetShortHelp" (byval self as integer,byval help as string) as integer
declare function wxToolBarToolBase_SetLongHelp cdecl alias "wxToolBarToolBase_SetLongHelp" (byval self as integer,byval help as string) as integer
declare function wxToolBarToolBase_SetNormalBitmap cdecl alias "wxToolBarToolBase_SetNormalBitmap" (byval self as integer,byval bmp as integer) as integer
declare function wxToolBarToolBase_SetDisabledBitmap cdecl alias "wxToolBarToolBase_SetDisabledBitmap" (byval self as integer,byval bmp as integer) as integer
declare function wxToolBarToolBase_SetLabel cdecl alias "wxToolBarToolBase_SetLabel" (byval self as integer,byval label as string) as integer
declare function wxToolBarToolBase_SetClientData cdecl alias "wxToolBarToolBase_SetClientData" (byval self as integer,byval clientData as integer) as integer
declare function wxToolBarToolBase_Detach cdecl alias "wxToolBarToolBase_Detach" (byval self as integer) as integer
declare function wxToolBarToolBase_Attach cdecl alias "wxToolBarToolBase_Attach" (byval self as integer,byval tbar as integer) as integer
declare function wxToolBar_ctor cdecl alias "wxToolBar_ctor" (byval parent as integer,byval id as integer,byval pos as integer,byval size as integer,byval style as integer) as integer
declare function wxToolBar_AddTool1 cdecl alias "wxToolBar_AddTool1" (byval self as integer,byval toolid as integer,byval label as string,byval bitmap as integer,byval bmpDisabled as integer,byval kind as integer,byval shortHelp as string,byval longHelp as string,byval data as integer) as integer
declare function wxToolBar_AddTool2 cdecl alias "wxToolBar_AddTool2" (byval self as integer,byval toolid as integer,byval label as string,byval bitmap as integer,byval shortHelp as string,byval kind as integer) as integer
declare function wxToolBar_AddCheckTool cdecl alias "wxToolBar_AddCheckTool" (byval self as integer,byval toolid as integer,byval label as string,byval bitmap as integer,byval bmpDisabled as integer,byval shortHelp as string,byval longHelp as string,byval data as integer) as integer
declare function wxToolBar_AddRadioTool cdecl alias "wxToolBar_AddRadioTool" (byval self as integer,byval toolid as integer,byval label as string,byval bitmap as integer,byval bmpDisabled as integer,byval shortHelp as string,byval longHelp as string,byval data as integer) as integer
declare function wxToolBar_AddControl cdecl alias "wxToolBar_AddControl" (byval self as integer,byval control as integer) as integer
declare function wxToolBar_InsertControl cdecl alias "wxToolBar_InsertControl" (byval self as integer,byval pos as integer,byval control as integer) as integer
declare function wxToolBar_FindControl cdecl alias "wxToolBar_FindControl" (byval self as integer,byval toolid as integer) as integer
declare function wxToolBar_AddSeparator cdecl alias "wxToolBar_AddSeparator" (byval self as integer) as integer
declare function wxToolBar_InsertSeparator cdecl alias "wxToolBar_InsertSeparator" (byval self as integer,byval pos as integer) as integer
declare function wxToolBar_RemoveTool cdecl alias "wxToolBar_RemoveTool" (byval self as integer,byval toolid as integer) as integer
declare function wxToolBar_DeleteToolByPos cdecl alias "wxToolBar_DeleteToolByPos" (byval self as integer,byval pos as integer) as integer
declare function wxToolBar_DeleteTool cdecl alias "wxToolBar_DeleteTool" (byval self as integer,byval toolid as integer) as integer
declare function wxToolBar_ClearTools cdecl alias "wxToolBar_ClearTools" (byval self as integer) as integer
declare function wxToolBar_Realize cdecl alias "wxToolBar_Realize" (byval self as integer) as integer
declare function wxToolBar_EnableTool cdecl alias "wxToolBar_EnableTool" (byval self as integer,byval toolid as integer,byval enable as integer) as integer
declare function wxToolBar_ToggleTool cdecl alias "wxToolBar_ToggleTool" (byval self as integer,byval toolid as integer,byval toggle as integer) as integer
declare function wxToolBar_GetToolClientData cdecl alias "wxToolBar_GetToolClientData" (byval self as integer,byval toolid as integer) as integer
declare function wxToolBar_SetToolClientData cdecl alias "wxToolBar_SetToolClientData" (byval self as integer,byval toolid as integer,byval clientData as integer) as integer
declare function wxToolBar_GetToolState cdecl alias "wxToolBar_GetToolState" (byval self as integer,byval toolid as integer) as integer
declare function wxToolBar_GetToolEnabled cdecl alias "wxToolBar_GetToolEnabled" (byval self as integer,byval toolid as integer) as integer
declare function wxToolBar_SetToolShortHelp cdecl alias "wxToolBar_SetToolShortHelp" (byval self as integer,byval toolid as integer,byval helpString as string) as integer
declare function wxToolBar_GetToolShortHelp cdecl alias "wxToolBar_GetToolShortHelp" (byval self as integer,byval toolid as integer) as byte ptr
declare function wxToolBar_SetToolLongHelp cdecl alias "wxToolBar_SetToolLongHelp" (byval self as integer,byval toolid as integer,byval helpString as string) as integer
declare function wxToolBar_GetToolLongHelp cdecl alias "wxToolBar_GetToolLongHelp" (byval self as integer,byval toolid as integer) as byte ptr
declare function wxToolBar_SetMargins cdecl alias "wxToolBar_SetMargins" (byval self as integer,byval x as integer,byval y as integer) as integer
declare function wxToolBar_SetToolPacking cdecl alias "wxToolBar_SetToolPacking" (byval self as integer,byval packing as integer) as integer
declare function wxToolBar_SetToolSeparation cdecl alias "wxToolBar_SetToolSeparation" (byval self as integer,byval separation as integer) as integer
declare function wxToolBar_GetToolMargins cdecl alias "wxToolBar_GetToolMargins" (byval self as integer,byval size as integer) as integer
declare function wxToolBar_GetToolPacking cdecl alias "wxToolBar_GetToolPacking" (byval self as integer) as integer
declare function wxToolBar_GetToolSeparation cdecl alias "wxToolBar_GetToolSeparation" (byval self as integer) as integer
declare function wxToolBar_SetRows cdecl alias "wxToolBar_SetRows" (byval self as integer,byval nRows as integer) as integer
declare function wxToolBar_SetMaxRowsCols cdecl alias "wxToolBar_SetMaxRowsCols" (byval self as integer,byval rows as integer,byval cols as integer) as integer
declare function wxToolBar_GetMaxRows cdecl alias "wxToolBar_GetMaxRows" (byval self as integer) as integer
declare function wxToolBar_GetMaxCols cdecl alias "wxToolBar_GetMaxCols" (byval self as integer) as integer
declare function wxToolBar_SetToolBitmapSize cdecl alias "wxToolBar_SetToolBitmapSize" (byval self as integer,byval size as integer) as integer
declare function wxToolBar_GetToolBitmapSize cdecl alias "wxToolBar_GetToolBitmapSize" (byval self as integer,byval size as integer) as integer
declare function wxToolBar_GetToolSize cdecl alias "wxToolBar_GetToolSize" (byval self as integer,byval size as integer) as integer
declare function wxToolBar_FindToolForPosition cdecl alias "wxToolBar_FindToolForPosition" (byval self as integer,byval x as integer,byval y as integer) as integer
declare function wxToolBar_IsVertical cdecl alias "wxToolBar_IsVertical" (byval self as integer) as integer
declare function wxToolBar_AddTool3 cdecl alias "wxToolBar_AddTool3" (byval self as integer,byval toolid as integer,byval bitmap as integer,byval bmpDisabled as integer,byval toggle as integer,byval clientData as integer,byval shortHelpString as string,byval longHelpString as string) as integer
declare function wxToolBar_AddTool4 cdecl alias "wxToolBar_AddTool4" (byval self as integer,byval toolid as integer,byval bitmap as integer,byval shortHelpString as string,byval longHelpString as string) as integer
declare function wxToolBar_AddTool5 cdecl alias "wxToolBar_AddTool5" (byval self as integer,byval toolid as integer,byval bitmap as integer,byval bmpDisabled as integer,byval toggle as integer,byval xPos as integer,byval yPos as integer,byval clientData as integer,byval shortHelp as string,byval longHelp as string) as integer
declare function wxToolBar_InsertTool cdecl alias "wxToolBar_InsertTool" (byval self as integer,byval pos as integer,byval toolid as integer,byval bitmap as integer,byval bmpDisabled as integer,byval toggle as integer,byval clientData as integer,byval shortHelp as string,byval longHelp as string) as integer
declare function wxToolBar_GetMargins cdecl alias "wxToolBar_GetMargins" (byval self as integer,byval size as integer) as integer
declare function wxToolBar_GetToolsCount cdecl alias "wxToolBar_GetToolsCount" (byval self as integer) as integer
declare function wxToolBar_AcceptsFocus cdecl alias "wxToolBar_AcceptsFocus" (byval self as integer) as integer
declare function wxToolTip_Enable cdecl alias "wxToolTip_Enable" (byval flag as integer) as integer
declare function wxToolTip_SetDelay cdecl alias "wxToolTip_SetDelay" (byval msecs as long) as integer
declare function wxToolTip_ctor cdecl alias "wxToolTip_ctor" (byval tip as string) as integer
declare function wxToolTip_SetTip cdecl alias "wxToolTip_SetTip" (byval self as integer,byval tip as string) as integer
declare function wxToolTip_GetTip cdecl alias "wxToolTip_GetTip" (byval self as integer) as byte ptr
declare function wxToolTip_GetWindow cdecl alias "wxToolTip_GetWindow" (byval self as integer) as integer
declare function wxTreeCtrl_ctor cdecl alias "wxTreeCtrl_ctor" () as integer
declare function wxTreeCtrl_RegisterVirtual cdecl alias "wxTreeCtrl_RegisterVirtual" (byval self as integer,byval onCompareItems as integer) as integer
declare function wxTreeCtrl_OnCompareItems cdecl alias "wxTreeCtrl_OnCompareItems" (byval self as integer,byval item1 as integer,byval item2 as integer) as integer
declare function wxTreeCtrl_SortChildren cdecl alias "wxTreeCtrl_SortChildren" (byval self as integer,byval item as integer) as integer
declare function wxTreeCtrl_AddRoot cdecl alias "wxTreeCtrl_AddRoot" (byval self as integer,byval text as string,byval image as integer,byval selImage as integer,byval data as integer) as integer
declare function wxTreeCtrl_AppendItem cdecl alias "wxTreeCtrl_AppendItem" (byval self as integer,byval parent as integer,byval text as string,byval image as integer,byval selImage as integer,byval data as integer) as integer
declare function wxTreeCtrl_AssignImageList cdecl alias "wxTreeCtrl_AssignImageList" (byval self as integer,byval imageList as integer) as integer
declare function wxTreeCtrl_AssignStateImageList cdecl alias "wxTreeCtrl_AssignStateImageList" (byval self as integer,byval imageList as integer) as integer
declare function wxTreeCtrl_Create cdecl alias "wxTreeCtrl_Create" (byval self as integer,byval parent as integer,byval id as integer,byval pos as integer,byval size as integer,byval style as integer,byval val as integer,byval name as string) as integer
declare function wxTreeCtrl_GetDefaultStyle cdecl alias "wxTreeCtrl_GetDefaultStyle" () as integer
declare function wxTreeCtrl_GetIndent cdecl alias "wxTreeCtrl_GetIndent" (byval self as integer) as integer
declare function wxTreeCtrl_SetIndent cdecl alias "wxTreeCtrl_SetIndent" (byval self as integer,byval indent as integer) as integer
declare function wxTreeCtrl_GetSpacing cdecl alias "wxTreeCtrl_GetSpacing" (byval self as integer) as integer
declare function wxTreeCtrl_SetSpacing cdecl alias "wxTreeCtrl_SetSpacing" (byval self as integer,byval indent as integer) as integer
declare function wxTreeCtrl_GetStateImageList cdecl alias "wxTreeCtrl_GetStateImageList" (byval self as integer) as integer
declare function wxTreeCtrl_SetStateImageList cdecl alias "wxTreeCtrl_SetStateImageList" (byval self as integer,byval imageList as integer) as integer
declare function wxTreeCtrl_GetImageList cdecl alias "wxTreeCtrl_GetImageList" (byval self as integer) as integer
declare function wxTreeCtrl_SetImageList cdecl alias "wxTreeCtrl_SetImageList" (byval self as integer,byval imageList as integer) as integer
declare function wxTreeCtrl_SetItemImage cdecl alias "wxTreeCtrl_SetItemImage" (byval self as integer,byval item as integer,byval image as integer,byval which as integer) as integer
declare function wxTreeCtrl_GetItemImage cdecl alias "wxTreeCtrl_GetItemImage" (byval self as integer,byval item as integer,byval which as integer) as integer
declare function wxTreeCtrl_DeleteAllItems cdecl alias "wxTreeCtrl_DeleteAllItems" (byval self as integer) as integer
declare function wxTreeCtrl_DeleteChildren cdecl alias "wxTreeCtrl_DeleteChildren" (byval self as integer,byval item as integer) as integer
declare function wxTreeCtrl_Delete cdecl alias "wxTreeCtrl_Delete" (byval self as integer,byval item as integer) as integer
declare function wxTreeCtrl_Unselect cdecl alias "wxTreeCtrl_Unselect" (byval self as integer) as integer
declare function wxTreeCtrl_UnselectAll cdecl alias "wxTreeCtrl_UnselectAll" (byval self as integer) as integer
declare function wxTreeCtrl_SelectItem cdecl alias "wxTreeCtrl_SelectItem" (byval self as integer,byval item as integer) as integer
declare function wxTreeCtrl_GetSelection cdecl alias "wxTreeCtrl_GetSelection" (byval self as integer) as integer
declare function wxTreeCtrl_IsSelected cdecl alias "wxTreeCtrl_IsSelected" (byval self as integer,byval item as integer) as integer
declare function wxTreeCtrl_GetSelections cdecl alias "wxTreeCtrl_GetSelections" (byval self as integer) as integer
declare function wxTreeCtrl_SetItemText cdecl alias "wxTreeCtrl_SetItemText" (byval self as integer,byval item as integer,byval text as string) as integer
declare function wxTreeCtrl_GetItemText cdecl alias "wxTreeCtrl_GetItemText" (byval self as integer,byval item as integer) as byte ptr
declare function wxTreeCtrl_SetItemData cdecl alias "wxTreeCtrl_SetItemData" (byval self as integer,byval item as integer,byval data as integer) as integer
declare function wxTreeCtrl_GetItemData cdecl alias "wxTreeCtrl_GetItemData" (byval self as integer,byval item as integer) as integer
declare function wxTreeCtrl_SetItemHasChildren cdecl alias "wxTreeCtrl_SetItemHasChildren" (byval self as integer,byval item as integer,byval has as integer) as integer
declare function wxTreeCtrl_HitTest cdecl alias "wxTreeCtrl_HitTest" (byval self as integer,byval pt as integer,byval flags as integer) as integer
declare function wxTreeCtrl_GetItemParent cdecl alias "wxTreeCtrl_GetItemParent" (byval self as integer,byval item as integer) as integer
declare function wxTreeCtrl_GetMyCookie cdecl alias "wxTreeCtrl_GetMyCookie" (byval self as integer) as integer
declare function wxTreeCtrl_SetMyCookie cdecl alias "wxTreeCtrl_SetMyCookie" (byval self as integer,byval newval as integer) as integer
declare function wxTreeCtrl_GetFirstChild cdecl alias "wxTreeCtrl_GetFirstChild" (byval self as integer,byval item as integer) as integer
declare function wxTreeCtrl_GetNextChild cdecl alias "wxTreeCtrl_GetNextChild" (byval self as integer,byval item as integer) as integer
declare function wxTreeCtrl_GetLastChild cdecl alias "wxTreeCtrl_GetLastChild" (byval self as integer,byval item as integer) as integer
declare function wxTreeCtrl_GetNextSibling cdecl alias "wxTreeCtrl_GetNextSibling" (byval self as integer,byval item as integer) as integer
declare function wxTreeCtrl_GetPrevSibling cdecl alias "wxTreeCtrl_GetPrevSibling" (byval self as integer,byval item as integer) as integer
declare function wxTreeCtrl_GetFirstVisibleItem cdecl alias "wxTreeCtrl_GetFirstVisibleItem" (byval self as integer) as integer
declare function wxTreeCtrl_GetNextVisible cdecl alias "wxTreeCtrl_GetNextVisible" (byval self as integer,byval item as integer) as integer
declare function wxTreeCtrl_GetPrevVisible cdecl alias "wxTreeCtrl_GetPrevVisible" (byval self as integer,byval item as integer) as integer
declare function wxTreeCtrl_PrependItem cdecl alias "wxTreeCtrl_PrependItem" (byval self as integer,byval parent as integer,byval text as string,byval image as integer,byval selectedImage as integer,byval data as integer) as integer
declare function wxTreeCtrl_InsertItem cdecl alias "wxTreeCtrl_InsertItem" (byval self as integer,byval parent as integer,byval idPrevious as integer,byval text as string,byval image as integer,byval selectedImage as integer,byval data as integer) as integer
declare function wxTreeCtrl_InsertItem2 cdecl alias "wxTreeCtrl_InsertItem2" (byval self as integer,byval parent as integer,byval before as integer,byval text as string,byval image as integer,byval selectedImage as integer,byval data as integer) as integer
declare function wxTreeCtrl_Expand cdecl alias "wxTreeCtrl_Expand" (byval self as integer,byval item as integer) as integer
declare function wxTreeCtrl_Collapse cdecl alias "wxTreeCtrl_Collapse" (byval self as integer,byval item as integer) as integer
declare function wxTreeCtrl_CollapseAndReset cdecl alias "wxTreeCtrl_CollapseAndReset" (byval self as integer,byval item as integer) as integer
declare function wxTreeCtrl_Toggle cdecl alias "wxTreeCtrl_Toggle" (byval self as integer,byval item as integer) as integer
declare function wxTreeCtrl_EnsureVisible cdecl alias "wxTreeCtrl_EnsureVisible" (byval self as integer,byval item as integer) as integer
declare function wxTreeCtrl_ScrollTo cdecl alias "wxTreeCtrl_ScrollTo" (byval self as integer,byval item as integer) as integer
declare function wxTreeCtrl_GetChildrenCount cdecl alias "wxTreeCtrl_GetChildrenCount" (byval self as integer,byval item as integer,byval recursively as integer) as integer
declare function wxTreeCtrl_GetCount cdecl alias "wxTreeCtrl_GetCount" (byval self as integer) as integer
declare function wxTreeCtrl_IsVisible cdecl alias "wxTreeCtrl_IsVisible" (byval self as integer,byval item as integer) as integer
declare function wxTreeCtrl_ItemHasChildren cdecl alias "wxTreeCtrl_ItemHasChildren" (byval self as integer,byval item as integer) as integer
declare function wxTreeCtrl_IsExpanded cdecl alias "wxTreeCtrl_IsExpanded" (byval self as integer,byval item as integer) as integer
declare function wxTreeCtrl_GetRootItem cdecl alias "wxTreeCtrl_GetRootItem" (byval self as integer) as integer
declare function wxTreeCtrl_GetItemTextColour cdecl alias "wxTreeCtrl_GetItemTextColour" (byval self as integer,byval item as integer) as integer
declare function wxTreeCtrl_GetItemBackgroundColour cdecl alias "wxTreeCtrl_GetItemBackgroundColour" (byval self as integer,byval item as integer) as integer
declare function wxTreeCtrl_GetItemFont cdecl alias "wxTreeCtrl_GetItemFont" (byval self as integer,byval item as integer) as integer
declare function wxTreeCtrl_SetItemBold cdecl alias "wxTreeCtrl_SetItemBold" (byval self as integer,byval item as integer,byval bold as integer) as integer
declare function wxTreeCtrl_SetItemTextColour cdecl alias "wxTreeCtrl_SetItemTextColour" (byval self as integer,byval item as integer,byval col as integer) as integer
declare function wxTreeCtrl_SetItemBackgroundColour cdecl alias "wxTreeCtrl_SetItemBackgroundColour" (byval self as integer,byval item as integer,byval col as integer) as integer
declare function wxTreeCtrl_SetItemFont cdecl alias "wxTreeCtrl_SetItemFont" (byval self as integer,byval item as integer,byval font as integer) as integer
declare function wxTreeCtrl_EditLabel cdecl alias "wxTreeCtrl_EditLabel" (byval self as integer,byval item as integer) as integer
declare function wxTreeCtrl_GetBoundingRect cdecl alias "wxTreeCtrl_GetBoundingRect" (byval self as integer,byval item as integer,byval rect as integer,byval textOnly as integer) as integer
declare function wxTreeCtrl_IsBold cdecl alias "wxTreeCtrl_IsBold" (byval self as integer,byval item as integer) as integer
declare function wxTreeCtrl_SetItemSelectedImage cdecl alias "wxTreeCtrl_SetItemSelectedImage" (byval self as integer,byval item as integer,byval selImage as integer) as integer
declare function wxTreeCtrl_ToggleItemSelection cdecl alias "wxTreeCtrl_ToggleItemSelection" (byval self as integer,byval item as integer) as integer
declare function wxTreeCtrl_UnselectItem cdecl alias "wxTreeCtrl_UnselectItem" (byval self as integer,byval item as integer) as integer
declare function wxTreeItemId_ctor cdecl alias "wxTreeItemId_ctor" () as integer
declare function wxTreeItemId_ctor2 cdecl alias "wxTreeItemId_ctor2" (byval pItem as integer) as integer
declare function wxTreeItemId_dtor cdecl alias "wxTreeItemId_dtor" (byval self as integer) as integer
declare function wxTreeItemId_RegisterDisposable cdecl alias "wxTreeItemId_RegisterDisposable" (byval self as integer,byval onDispose as integer) as integer
declare function wxTreeItemId_Equal cdecl alias "wxTreeItemId_Equal" (byval item1 as integer,byval item2 as integer) as integer
declare function wxTreeItemId_IsOk cdecl alias "wxTreeItemId_IsOk" (byval self as integer) as integer
declare function wxTreeEvent_ctor cdecl alias "wxTreeEvent_ctor" (byval commandType as integer,byval id as integer) as integer
declare function wxTreeEvent_GetItem cdecl alias "wxTreeEvent_GetItem" (byval self as integer) as integer
declare function wxTreeEvent_SetItem cdecl alias "wxTreeEvent_SetItem" (byval self as integer,byval item as integer) as integer
declare function wxTreeEvent_GetOldItem cdecl alias "wxTreeEvent_GetOldItem" (byval self as integer) as integer
declare function wxTreeEvent_SetOldItem cdecl alias "wxTreeEvent_SetOldItem" (byval self as integer,byval item as integer) as integer
declare function wxTreeEvent_GetPoint cdecl alias "wxTreeEvent_GetPoint" (byval self as integer,byval pt as integer) as integer
declare function wxTreeEvent_SetPoint cdecl alias "wxTreeEvent_SetPoint" (byval self as integer,byval pt as integer) as integer
declare function wxTreeEvent_GetKeyEvent cdecl alias "wxTreeEvent_GetKeyEvent" (byval self as integer) as integer
declare function wxTreeEvent_GetKeyCode cdecl alias "wxTreeEvent_GetKeyCode" (byval self as integer) as integer
declare function wxTreeEvent_SetKeyEvent cdecl alias "wxTreeEvent_SetKeyEvent" (byval self as integer,byval evt as integer) as integer
declare function wxTreeEvent_GetLabel cdecl alias "wxTreeEvent_GetLabel" (byval self as integer) as byte ptr
declare function wxTreeEvent_SetLabel cdecl alias "wxTreeEvent_SetLabel" (byval self as integer,byval label as string) as integer
declare function wxTreeEvent_IsEditCancelled cdecl alias "wxTreeEvent_IsEditCancelled" (byval self as integer) as integer
declare function wxTreeEvent_SetEditCanceled cdecl alias "wxTreeEvent_SetEditCanceled" (byval self as integer,byval editCancelled as integer) as integer
declare function wxTreeEvent_Veto cdecl alias "wxTreeEvent_Veto" (byval self as integer) as integer
declare function wxTreeEvent_Allow cdecl alias "wxTreeEvent_Allow" (byval self as integer) as integer
declare function wxTreeEvent_IsAllowed cdecl alias "wxTreeEvent_IsAllowed" (byval self as integer) as integer
declare function wxTreeEvent_SetToolTip cdecl alias "wxTreeEvent_SetToolTip" (byval self as integer,byval toolTip as string) as integer
declare function wxTreeItemData_ctor cdecl alias "wxTreeItemData_ctor" () as integer
declare function wxTreeItemData_dtor cdecl alias "wxTreeItemData_dtor" (byval self as integer) as integer
declare function wxTreeItemData_RegisterDisposable cdecl alias "wxTreeItemData_RegisterDisposable" (byval self as integer,byval onDispose as integer) as integer
declare function wxTreeItemData_GetId cdecl alias "wxTreeItemData_GetId" (byval self as integer) as integer
declare function wxTreeItemData_SetId cdecl alias "wxTreeItemData_SetId" (byval self as integer,byval param as integer) as integer
declare function wxTreeItemAttr_ctor cdecl alias "wxTreeItemAttr_ctor" () as integer
declare function wxTreeItemAttr_ctor2 cdecl alias "wxTreeItemAttr_ctor2" (byval colText as integer,byval colBack as integer,byval font as integer) as integer
declare function wxTreeItemAttr_dtor cdecl alias "wxTreeItemAttr_dtor" (byval self as integer) as integer
declare function wxTreeItemAttr_RegisterDisposable cdecl alias "wxTreeItemAttr_RegisterDisposable" (byval self as integer,byval onDispose as integer) as integer
declare function wxTreeItemAttr_SetTextColour cdecl alias "wxTreeItemAttr_SetTextColour" (byval self as integer,byval colText as integer) as integer
declare function wxTreeItemAttr_SetBackgroundColour cdecl alias "wxTreeItemAttr_SetBackgroundColour" (byval self as integer,byval colBack as integer) as integer
declare function wxTreeItemAttr_SetFont cdecl alias "wxTreeItemAttr_SetFont" (byval self as integer,byval font as integer) as integer
declare function wxTreeItemAttr_HasTextColour cdecl alias "wxTreeItemAttr_HasTextColour" (byval self as integer) as integer
declare function wxTreeItemAttr_HasBackgroundColour cdecl alias "wxTreeItemAttr_HasBackgroundColour" (byval self as integer) as integer
declare function wxTreeItemAttr_HasFont cdecl alias "wxTreeItemAttr_HasFont" (byval self as integer) as integer
declare function wxTreeItemAttr_GetTextColour cdecl alias "wxTreeItemAttr_GetTextColour" (byval self as integer) as integer
declare function wxTreeItemAttr_GetBackgroundColour cdecl alias "wxTreeItemAttr_GetBackgroundColour" (byval self as integer) as integer
declare function wxTreeItemAttr_GetFont cdecl alias "wxTreeItemAttr_GetFont" (byval self as integer) as integer
declare function wxArrayTreeItemIds_ctor cdecl alias "wxArrayTreeItemIds_ctor" () as integer
declare function wxArrayTreeItemIds_dtor cdecl alias "wxArrayTreeItemIds_dtor" (byval self as integer) as integer
declare function wxArrayTreeItemIds_RegisterDisposable cdecl alias "wxArrayTreeItemIds_RegisterDisposable" (byval self as integer,byval onDispose as integer) as integer
declare function wxArrayTreeItemIds_Add cdecl alias "wxArrayTreeItemIds_Add" (byval self as integer,byval toadd as integer) as integer
declare function wxArrayTreeItemIds_Item cdecl alias "wxArrayTreeItemIds_Item" (byval self as integer,byval num as integer) as integer
declare function wxArrayTreeItemIds_GetCount cdecl alias "wxArrayTreeItemIds_GetCount" (byval self as integer) as integer
declare function wxUpdateUIEvent_ctor cdecl alias "wxUpdateUIEvent_ctor" (byval commandId as integer) as integer
declare function wxUpdateUIEvent_CanUpdate cdecl alias "wxUpdateUIEvent_CanUpdate" (byval window as integer) as integer
declare function wxUpdUIEvt_Enable cdecl alias "wxUpdUIEvt_Enable" (byval self as integer,byval enable as integer) as integer
declare function wxUpdUIEvt_Check cdecl alias "wxUpdUIEvt_Check" (byval self as integer,byval check as integer) as integer
declare function wxUpdateUIEvent_GetChecked cdecl alias "wxUpdateUIEvent_GetChecked" (byval self as integer) as integer
declare function wxUpdateUIEvent_GetEnabled cdecl alias "wxUpdateUIEvent_GetEnabled" (byval self as integer) as integer
declare function wxUpdateUIEvent_GetSetChecked cdecl alias "wxUpdateUIEvent_GetSetChecked" (byval self as integer) as integer
declare function wxUpdateUIEvent_GetSetEnabled cdecl alias "wxUpdateUIEvent_GetSetEnabled" (byval self as integer) as integer
declare function wxUpdateUIEvent_GetSetText cdecl alias "wxUpdateUIEvent_GetSetText" (byval self as integer) as integer
declare function wxUpdateUIEvent_GetText cdecl alias "wxUpdateUIEvent_GetText" (byval self as integer) as byte ptr
declare function wxUpdateUIEvent_GetMode cdecl alias "wxUpdateUIEvent_GetMode" () as integer
declare function wxUpdateUIEvent_GetUpdateInterval cdecl alias "wxUpdateUIEvent_GetUpdateInterval" () as long
declare function wxUpdateUIEvent_ResetUpdateTime cdecl alias "wxUpdateUIEvent_ResetUpdateTime" () as integer
declare function wxUpdateUIEvent_SetMode cdecl alias "wxUpdateUIEvent_SetMode" (byval mode as integer) as integer
declare function wxUpdateUIEvent_SetText cdecl alias "wxUpdateUIEvent_SetText" (byval self as integer,byval text as string) as integer
declare function wxUpdateUIEvent_SetUpdateInterval cdecl alias "wxUpdateUIEvent_SetUpdateInterval" (byval updateInterval as long) as integer
declare function wxValidator_ctor cdecl alias "wxValidator_ctor" () as integer
declare function wxVListBox_ctor cdecl alias "wxVListBox_ctor" (byval parent as integer,byval id as integer,byval pos as integer,byval size as integer,byval style as long,byval name as string) as integer
declare function wxVListBox_RegisterVirtual cdecl alias "wxVListBox_RegisterVirtual" (byval self as integer,byval onDrawItem as integer,byval onMeasureItem as integer,byval onDrawSeparator as integer,byval onDrawBackground as integer,byval onGetLineHeight as integer) as integer
declare function wxVListBox_Create cdecl alias "wxVListBox_Create" (byval self as integer,byval parent as integer,byval id as integer,byval pos as integer,byval size as integer,byval style as long,byval name as string) as integer
declare function wxVListBox_OnDrawSeparator cdecl alias "wxVListBox_OnDrawSeparator" (byval self as integer,byval dc as integer,byval rect as integer,byval n as integer) as integer
declare function wxVListBox_OnDrawBackground cdecl alias "wxVListBox_OnDrawBackground" (byval self as integer,byval dc as integer,byval rect as integer,byval n as integer) as integer
declare function wxVListBox_OnGetLineHeight cdecl alias "wxVListBox_OnGetLineHeight" (byval self as integer,byval line as integer) as integer
declare function wxVListBox_GetItemCount cdecl alias "wxVListBox_GetItemCount" (byval self as integer) as integer
declare function wxVListBox_HasMultipleSelection cdecl alias "wxVListBox_HasMultipleSelection" (byval self as integer) as integer
declare function wxVListBox_GetSelection cdecl alias "wxVListBox_GetSelection" (byval self as integer) as integer
declare function wxVListBox_IsCurrent cdecl alias "wxVListBox_IsCurrent" (byval self as integer,byval item as integer) as integer
declare function wxVListBox_IsSelected cdecl alias "wxVListBox_IsSelected" (byval self as integer,byval item as integer) as integer
declare function wxVListBox_GetSelectedCount cdecl alias "wxVListBox_GetSelectedCount" (byval self as integer) as integer
declare function wxVListBox_GetFirstSelected cdecl alias "wxVListBox_GetFirstSelected" (byval self as integer,byval cookie as integer) as integer
declare function wxVListBox_GetNextSelected cdecl alias "wxVListBox_GetNextSelected" (byval self as integer,byval cookie as integer) as integer
declare function wxVListBox_GetMargins cdecl alias "wxVListBox_GetMargins" (byval self as integer,byval pt as integer) as integer
declare function wxVListBox_GetSelectionBackground cdecl alias "wxVListBox_GetSelectionBackground" (byval self as integer) as integer
declare function wxVListBox_SetItemCount cdecl alias "wxVListBox_SetItemCount" (byval self as integer,byval count as integer) as integer
declare function wxVListBox_Clear cdecl alias "wxVListBox_Clear" (byval self as integer) as integer
declare function wxVListBox_SetSelection cdecl alias "wxVListBox_SetSelection" (byval self as integer,byval selection as integer) as integer
declare function wxVListBox_Select cdecl alias "wxVListBox_Select" (byval self as integer,byval item as integer,byval select as integer) as integer
declare function wxVListBox_SelectRange cdecl alias "wxVListBox_SelectRange" (byval self as integer,byval from as integer,byval to as integer) as integer
declare function wxVListBox_Toggle cdecl alias "wxVListBox_Toggle" (byval self as integer,byval item as integer) as integer
declare function wxVListBox_SelectAll cdecl alias "wxVListBox_SelectAll" (byval self as integer) as integer
declare function wxVListBox_DeselectAll cdecl alias "wxVListBox_DeselectAll" (byval self as integer) as integer
declare function wxVListBox_SetMargins cdecl alias "wxVListBox_SetMargins" (byval self as integer,byval pt as integer) as integer
declare function wxVListBox_SetMargins2 cdecl alias "wxVListBox_SetMargins2" (byval self as integer,byval x as integer,byval y as integer) as integer
declare function wxVListBox_SetSelectionBackground cdecl alias "wxVListBox_SetSelectionBackground" (byval self as integer,byval col as integer) as integer
declare function wxVScrollWnd_ctor cdecl alias "wxVScrollWnd_ctor" (byval parent as integer,byval id as integer,byval pos as integer,byval size as integer,byval style as long,byval name as string) as integer
declare function wxVScrolledWindow_RegisterVirtual cdecl alias "wxVScrolledWindow_RegisterVirtual" (byval self as integer,byval onGetLineHeight as integer) as integer
declare function wxVScrolledWindow_Create cdecl alias "wxVScrolledWindow_Create" (byval self as integer,byval parent as integer,byval id as integer,byval pos as integer,byval size as integer,byval style as long,byval name as string) as integer
declare function wxVScrolledWindow_SetLineCount cdecl alias "wxVScrolledWindow_SetLineCount" (byval self as integer,byval count as integer) as integer
declare function wxVScrolledWindow_ScrollToLine cdecl alias "wxVScrolledWindow_ScrollToLine" (byval self as integer,byval line as integer) as integer
declare function wxVScrolledWindow_ScrollLines cdecl alias "wxVScrolledWindow_ScrollLines" (byval self as integer,byval lines as integer) as integer
declare function wxVScrolledWindow_ScrollPages cdecl alias "wxVScrolledWindow_ScrollPages" (byval self as integer,byval pages as integer) as integer
declare function wxVScrolledWindow_RefreshLine cdecl alias "wxVScrolledWindow_RefreshLine" (byval self as integer,byval line as integer) as integer
declare function wxVScrolledWindow_RefreshLines cdecl alias "wxVScrolledWindow_RefreshLines" (byval self as integer,byval from as integer,byval to as integer) as integer
declare function wxVScrolledWindow_HitTest cdecl alias "wxVScrolledWindow_HitTest" (byval self as integer,byval x as integer,byval y as integer) as integer
declare function wxVScrolledWindow_HitTest2 cdecl alias "wxVScrolledWindow_HitTest2" (byval self as integer,byval pt as integer) as integer
declare function wxVScrolledWindow_RefreshAll cdecl alias "wxVScrolledWindow_RefreshAll" (byval self as integer) as integer
declare function wxVScrolledWindow_GetLineCount cdecl alias "wxVScrolledWindow_GetLineCount" (byval self as integer) as integer
declare function wxVScrolledWindow_GetFirstVisisbleLine cdecl alias "wxVScrolledWindow_GetFirstVisisbleLine" (byval self as integer) as integer
declare function wxVScrolledWindow_GetLastVisibleLine cdecl alias "wxVScrolledWindow_GetLastVisibleLine" (byval self as integer) as integer
declare function wxVScrolledWindow_IsVisible cdecl alias "wxVScrolledWindow_IsVisible" (byval self as integer,byval line as integer) as integer
declare function wxWindow_EVT_TRANSFERDATAFROMWINDOW cdecl alias "wxWindow_EVT_TRANSFERDATAFROMWINDOW" () as integer
declare function wxWindow_ctor cdecl alias "wxWindow_ctor" (byval parent as integer,byval id as integer,byval pos as integer,byval size as integer,byval style as integer,byval name as integer) as integer
declare function wxWindow_Close cdecl alias "wxWindow_Close" (byval self as integer,byval force as integer) as integer
declare function wxWindow_GetClientSize cdecl alias "wxWindow_GetClientSize" (byval self as integer,byval size as integer) as integer
declare function wxWindow_SetSize cdecl alias "wxWindow_SetSize" (byval self as integer,byval x as integer,byval y as integer,byval width as integer,byval height as integer,byval flags as integer) as integer
declare function wxWindow_SetSize2 cdecl alias "wxWindow_SetSize2" (byval self as integer,byval width as integer,byval height as integer) as integer
declare function wxWindow_SetSize3 cdecl alias "wxWindow_SetSize3" (byval self as integer,byval size as integer) as integer
declare function wxWindow_Move cdecl alias "wxWindow_Move" (byval self as integer,byval x as integer,byval y as integer,byval flags as integer) as integer
declare function wxWindow_Show cdecl alias "wxWindow_Show" (byval self as integer,byval show as integer) as integer
declare function wxWindow_GetBestSize cdecl alias "wxWindow_GetBestSize" (byval self as integer,byval size as integer) as integer
declare function wxWindow_GetId cdecl alias "wxWindow_GetId" (byval self as integer) as integer
declare function wxWindow_SetId cdecl alias "wxWindow_SetId" (byval self as integer,byval id as integer) as integer
declare function wxWindow_GetWindowStyleFlag cdecl alias "wxWindow_GetWindowStyleFlag" (byval self as integer) as integer
declare function wxWindow_Layout cdecl alias "wxWindow_Layout" (byval self as integer) as integer
declare function wxWindow_SetAutoLayout cdecl alias "wxWindow_SetAutoLayout" (byval self as integer,byval autoLayout as integer) as integer
declare function wxWindow_SetBackgroundColour cdecl alias "wxWindow_SetBackgroundColour" (byval self as integer,byval colour as integer) as integer
declare function wxWindow_SetForegroundColour cdecl alias "wxWindow_SetForegroundColour" (byval self as integer,byval colour as integer) as integer
declare function wxWindow_SetCursor cdecl alias "wxWindow_SetCursor" (byval self as integer,byval cursor as integer) as integer
declare function wxWindow_SetSizer cdecl alias "wxWindow_SetSizer" (byval self as integer,byval sizer as integer,byval deleteOld as integer) as integer
declare function wxWindow_SetWindowStyleFlag cdecl alias "wxWindow_SetWindowStyleFlag" (byval self as integer,byval style as integer) as integer
declare function wxWindow_SetFont cdecl alias "wxWindow_SetFont" (byval self as integer,byval font as integer) as integer
declare function wxWindow_GetFont cdecl alias "wxWindow_GetFont" (byval self as integer) as integer
declare function wxWindow_SetToolTip cdecl alias "wxWindow_SetToolTip" (byval self as integer,byval tip as string) as integer
declare function wxWindow_Enable cdecl alias "wxWindow_Enable" (byval self as integer,byval enable as integer) as integer
declare function wxWindow_IsEnabled cdecl alias "wxWindow_IsEnabled" (byval self as integer) as integer
declare function wxWindow_Destroy cdecl alias "wxWindow_Destroy" (byval self as integer) as integer
declare function wxWindow_DestroyChildren cdecl alias "wxWindow_DestroyChildren" (byval self as integer) as integer
declare function wxWindow_SetTitle cdecl alias "wxWindow_SetTitle" (byval self as integer,byval title as string) as integer
declare function wxWindow_GetTitle cdecl alias "wxWindow_GetTitle" (byval self as integer) as byte ptr
declare function wxWindow_SetName cdecl alias "wxWindow_SetName" (byval self as integer,byval name as string) as integer
declare function wxWindow_GetName cdecl alias "wxWindow_GetName" (byval self as integer) as byte ptr
declare function wxWindow_NewControlId cdecl alias "wxWindow_NewControlId" () as integer
declare function wxWindow_NextControlId cdecl alias "wxWindow_NextControlId" (byval id as integer) as integer
declare function wxWindow_PrevControlId cdecl alias "wxWindow_PrevControlId" (byval id as integer) as integer
declare function wxWindow_Raise cdecl alias "wxWindow_Raise" (byval self as integer) as integer
declare function wxWindow_Lower cdecl alias "wxWindow_Lower" (byval self as integer) as integer
declare function wxWindow_SetClientSize cdecl alias "wxWindow_SetClientSize" (byval self as integer,byval width as integer,byval height as integer) as integer
declare function wxWindow_GetPosition cdecl alias "wxWindow_GetPosition" (byval self as integer,byval point as integer) as integer
declare function wxWindow_GetSize cdecl alias "wxWindow_GetSize" (byval self as integer,byval size as integer) as integer
declare function wxWindow_GetRect cdecl alias "wxWindow_GetRect" (byval self as integer,byval rect as integer) as integer
declare function wxWindow_GetClientAreaOrigin cdecl alias "wxWindow_GetClientAreaOrigin" (byval self as integer,byval point as integer) as integer
declare function wxWindow_GetClientRect cdecl alias "wxWindow_GetClientRect" (byval self as integer,byval rect as integer) as integer
declare function wxWindow_GetAdjustedBestSize cdecl alias "wxWindow_GetAdjustedBestSize" (byval self as integer,byval size as integer) as integer
declare function wxWindow_Center cdecl alias "wxWindow_Center" (byval self as integer,byval direction as integer) as integer
declare function wxWindow_CenterOnScreen cdecl alias "wxWindow_CenterOnScreen" (byval self as integer,byval dir as integer) as integer
declare function wxWindow_CenterOnParent cdecl alias "wxWindow_CenterOnParent" (byval self as integer,byval dir as integer) as integer
declare function wxWindow_Fit cdecl alias "wxWindow_Fit" (byval self as integer) as integer
declare function wxWindow_FitInside cdecl alias "wxWindow_FitInside" (byval self as integer) as integer
declare function wxWindow_SetSizeHints cdecl alias "wxWindow_SetSizeHints" (byval self as integer,byval minW as integer,byval minH as integer,byval maxW as integer,byval maxH as integer,byval incW as integer,byval incH as integer) as integer
declare function wxWindow_SetVirtualSizeHints cdecl alias "wxWindow_SetVirtualSizeHints" (byval self as integer,byval minW as integer,byval minH as integer,byval maxW as integer,byval maxH as integer) as integer
declare function wxWindow_GetMinWidth cdecl alias "wxWindow_GetMinWidth" (byval self as integer) as integer
declare function wxWindow_GetMinHeight cdecl alias "wxWindow_GetMinHeight" (byval self as integer) as integer
declare function wxWindow_GetMaxWidth cdecl alias "wxWindow_GetMaxWidth" (byval self as integer) as integer
declare function wxWindow_GetMaxHeight cdecl alias "wxWindow_GetMaxHeight" (byval self as integer) as integer
declare function wxWindow_GetMaxSize cdecl alias "wxWindow_GetMaxSize" (byval self as integer,byval size as integer) as integer
declare function wxWindow_SetVirtualSize cdecl alias "wxWindow_SetVirtualSize" (byval self as integer,byval size as integer) as integer
declare function wxWindow_GetVirtualSize cdecl alias "wxWindow_GetVirtualSize" (byval self as integer,byval size as integer) as integer
declare function wxWindow_GetBestVirtualSize cdecl alias "wxWindow_GetBestVirtualSize" (byval self as integer,byval size as integer) as integer
declare function wxWindow_Hide cdecl alias "wxWindow_Hide" (byval self as integer) as integer
declare function wxWindow_Disable cdecl alias "wxWindow_Disable" (byval self as integer) as integer
declare function wxWindow_IsShown cdecl alias "wxWindow_IsShown" (byval self as integer) as integer
declare function wxWindow_SetWindowStyle cdecl alias "wxWindow_SetWindowStyle" (byval self as integer,byval style as long) as integer
declare function wxWindow_GetWindowStyle cdecl alias "wxWindow_GetWindowStyle" (byval self as integer) as long
declare function wxWindow_HasFlag cdecl alias "wxWindow_HasFlag" (byval self as integer,byval flag as integer) as integer
declare function wxWindow_IsRetained cdecl alias "wxWindow_IsRetained" (byval self as integer) as integer
declare function wxWindow_SetExtraStyle cdecl alias "wxWindow_SetExtraStyle" (byval self as integer,byval exStyle as long) as integer
declare function wxWindow_GetExtraStyle cdecl alias "wxWindow_GetExtraStyle" (byval self as integer) as long
declare function wxWindow_MakeModal cdecl alias "wxWindow_MakeModal" (byval self as integer,byval modal as integer) as integer
declare function wxWindow_SetThemeEnabled cdecl alias "wxWindow_SetThemeEnabled" (byval self as integer,byval enableTheme as integer) as integer
declare function wxWindow_GetThemeEnabled cdecl alias "wxWindow_GetThemeEnabled" (byval self as integer) as integer
declare function wxWindow_SetFocus cdecl alias "wxWindow_SetFocus" (byval self as integer) as integer
declare function wxWindow_SetFocusFromKbd cdecl alias "wxWindow_SetFocusFromKbd" (byval self as integer) as integer
declare function wxWindow_FindFocus cdecl alias "wxWindow_FindFocus" () as integer
declare function wxWindow_AcceptsFocus cdecl alias "wxWindow_AcceptsFocus" (byval self as integer) as integer
declare function wxWindow_AcceptsFocusFromKeyboard cdecl alias "wxWindow_AcceptsFocusFromKeyboard" (byval self as integer) as integer
declare function wxWindow_GetDefaultItem cdecl alias "wxWindow_GetDefaultItem" (byval self as integer) as integer
declare function wxWindow_SetDefaultItem cdecl alias "wxWindow_SetDefaultItem" (byval self as integer,byval child as integer) as integer
declare function wxWindow_SetTmpDefaultItem cdecl alias "wxWindow_SetTmpDefaultItem" (byval self as integer,byval win as integer) as integer
declare function wxWindow_GetParent cdecl alias "wxWindow_GetParent" (byval self as integer) as integer
declare function wxWindow_GetGrandParent cdecl alias "wxWindow_GetGrandParent" (byval self as integer) as integer
declare function wxWindow_IsTopLevel cdecl alias "wxWindow_IsTopLevel" (byval self as integer) as integer
declare function wxWindow_SetParent cdecl alias "wxWindow_SetParent" (byval self as integer,byval parent as integer) as integer
declare function wxWindow_Reparent cdecl alias "wxWindow_Reparent" (byval self as integer,byval newParent as integer) as integer
declare function wxWindow_AddChild cdecl alias "wxWindow_AddChild" (byval self as integer,byval child as integer) as integer
declare function wxWindow_RemoveChild cdecl alias "wxWindow_RemoveChild" (byval self as integer,byval child as integer) as integer
declare function wxWindow_FindWindowId cdecl alias "wxWindow_FindWindowId" (byval self as integer,byval id as long) as integer
declare function wxWindow_FindWindowName cdecl alias "wxWindow_FindWindowName" (byval self as integer,byval name as string) as integer
declare function wxWindow_FindWindowById cdecl alias "wxWindow_FindWindowById" (byval id as long,byval parent as integer) as integer
declare function wxWindow_FindWindowByName cdecl alias "wxWindow_FindWindowByName" (byval name as string,byval parent as integer) as integer
declare function wxWindow_FindWindowByLabel cdecl alias "wxWindow_FindWindowByLabel" (byval label as string,byval parent as integer) as integer
declare function wxWindow_GetEventHandler cdecl alias "wxWindow_GetEventHandler" (byval self as integer) as integer
declare function wxWindow_SetEventHandler cdecl alias "wxWindow_SetEventHandler" (byval self as integer,byval handler as integer) as integer
declare function wxWindow_PushEventHandler cdecl alias "wxWindow_PushEventHandler" (byval self as integer,byval handler as integer) as integer
declare function wxWindow_PopEventHandler cdecl alias "wxWindow_PopEventHandler" (byval self as integer,byval deleteHandler as integer) as integer
declare function wxWindow_RemoveEventHandler cdecl alias "wxWindow_RemoveEventHandler" (byval self as integer,byval handler as integer) as integer
declare function wxWindow_SetValidator cdecl alias "wxWindow_SetValidator" (byval self as integer,byval validator as integer) as integer
declare function wxWindow_GetValidator cdecl alias "wxWindow_GetValidator" (byval self as integer) as integer
declare function wxWindow_Validate cdecl alias "wxWindow_Validate" (byval self as integer) as integer
declare function wxWindow_TransferDataToWindow cdecl alias "wxWindow_TransferDataToWindow" (byval self as integer) as integer
declare function wxWindow_TransferDataFromWindow cdecl alias "wxWindow_TransferDataFromWindow" (byval self as integer) as integer
declare function wxWindow_InitDialog cdecl alias "wxWindow_InitDialog" (byval self as integer) as integer
declare function wxWindow_SetAcceleratorTable cdecl alias "wxWindow_SetAcceleratorTable" (byval self as integer,byval accel as integer) as integer
declare function wxWindow_GetAcceleratorTable cdecl alias "wxWindow_GetAcceleratorTable" (byval self as integer) as integer
declare function wxWindow_ConvertPixelsToDialogPoint cdecl alias "wxWindow_ConvertPixelsToDialogPoint" (byval self as integer,byval pt as integer,byval point as integer) as integer
declare function wxWindow_ConvertDialogToPixelsPoint cdecl alias "wxWindow_ConvertDialogToPixelsPoint" (byval self as integer,byval pt as integer,byval point as integer) as integer
declare function wxWindow_ConvertPixelsToDialogSize cdecl alias "wxWindow_ConvertPixelsToDialogSize" (byval self as integer,byval sz as integer,byval size as integer) as integer
declare function wxWindow_ConvertDialogToPixelsSize cdecl alias "wxWindow_ConvertDialogToPixelsSize" (byval self as integer,byval sz as integer,byval size as integer) as integer
declare function wxWindow_WarpPointer cdecl alias "wxWindow_WarpPointer" (byval self as integer,byval x as integer,byval y as integer) as integer
declare function wxWindow_CaptureMouse cdecl alias "wxWindow_CaptureMouse" (byval self as integer) as integer
declare function wxWindow_ReleaseMouse cdecl alias "wxWindow_ReleaseMouse" (byval self as integer) as integer
declare function wxWindow_GetCapture cdecl alias "wxWindow_GetCapture" () as integer
declare function wxWindow_HasCapture cdecl alias "wxWindow_HasCapture" (byval self as integer) as integer
declare function wxWindow_Refresh cdecl alias "wxWindow_Refresh" (byval self as integer,byval eraseBackground as integer,byval rect as integer) as integer
declare function wxWindow_RefreshRect cdecl alias "wxWindow_RefreshRect" (byval self as integer,byval rect as integer) as integer
declare function wxWindow_Update cdecl alias "wxWindow_Update" (byval self as integer) as integer
declare function wxWindow_ClearBackground cdecl alias "wxWindow_ClearBackground" (byval self as integer) as integer
declare function wxWindow_Freeze cdecl alias "wxWindow_Freeze" (byval self as integer) as integer
declare function wxWindow_Thaw cdecl alias "wxWindow_Thaw" (byval self as integer) as integer
declare function wxWindow_PrepareDC cdecl alias "wxWindow_PrepareDC" (byval self as integer,byval dc as integer) as integer
declare function wxWindow_IsExposed cdecl alias "wxWindow_IsExposed" (byval self as integer,byval x as integer,byval y as integer,byval w as integer,byval h as integer) as integer
declare function wxWindow_GetBackgroundColour cdecl alias "wxWindow_GetBackgroundColour" (byval self as integer) as integer
declare function wxWindow_GetForegroundColour cdecl alias "wxWindow_GetForegroundColour" (byval self as integer) as integer
declare function wxWindow_SetCaret cdecl alias "wxWindow_SetCaret" (byval self as integer,byval caret as integer) as integer
declare function wxWindow_GetCaret cdecl alias "wxWindow_GetCaret" (byval self as integer) as integer
declare function wxWindow_GetCharHeight cdecl alias "wxWindow_GetCharHeight" (byval self as integer) as integer
declare function wxWindow_GetCharWidth cdecl alias "wxWindow_GetCharWidth" (byval self as integer) as integer
declare function wxWindow_ClientToScreen cdecl alias "wxWindow_ClientToScreen" (byval self as integer,byval pt as integer,byval point as integer) as integer
declare function wxWindow_ScreenToClient cdecl alias "wxWindow_ScreenToClient" (byval self as integer,byval pt as integer,byval point as integer) as integer
declare function wxWindow_HitTest cdecl alias "wxWindow_HitTest" (byval self as integer,byval pt as integer,byval hittest as integer) as integer
declare function wxWindow_GetBorder cdecl alias "wxWindow_GetBorder" (byval self as integer) as integer
declare function wxWindow_GetBorderByFlags cdecl alias "wxWindow_GetBorderByFlags" (byval self as integer,byval flags as long) as integer
declare function wxWindow_UpdateWindowUI cdecl alias "wxWindow_UpdateWindowUI" (byval self as integer) as integer
declare function wxWindow_PopupMenu cdecl alias "wxWindow_PopupMenu" (byval self as integer,byval menu as integer,byval pos as integer) as integer
declare function wxWindow_HasScrollbar cdecl alias "wxWindow_HasScrollbar" (byval self as integer,byval orient as integer) as integer
declare function wxWindow_SetScrollbar cdecl alias "wxWindow_SetScrollbar" (byval self as integer,byval orient as integer,byval pos as integer,byval thumbvisible as integer,byval range as integer,byval refresh as integer) as integer
declare function wxWindow_SetScrollPos cdecl alias "wxWindow_SetScrollPos" (byval self as integer,byval orient as integer,byval pos as integer,byval refresh as integer) as integer
declare function wxWindow_GetScrollPos cdecl alias "wxWindow_GetScrollPos" (byval self as integer,byval orient as integer) as integer
declare function wxWindow_GetScrollThumb cdecl alias "wxWindow_GetScrollThumb" (byval self as integer,byval orient as integer) as integer
declare function wxWindow_GetScrollRange cdecl alias "wxWindow_GetScrollRange" (byval self as integer,byval orient as integer) as integer
declare function wxWindow_ScrollWindow cdecl alias "wxWindow_ScrollWindow" (byval self as integer,byval dx as integer,byval dy as integer,byval rect as integer) as integer
declare function wxWindow_ScrollLines cdecl alias "wxWindow_ScrollLines" (byval self as integer,byval lines as integer) as integer
declare function wxWindow_ScrollPages cdecl alias "wxWindow_ScrollPages" (byval self as integer,byval pages as integer) as integer
declare function wxWindow_LineUp cdecl alias "wxWindow_LineUp" (byval self as integer) as integer
declare function wxWindow_LineDown cdecl alias "wxWindow_LineDown" (byval self as integer) as integer
declare function wxWindow_PageUp cdecl alias "wxWindow_PageUp" (byval self as integer) as integer
declare function wxWindow_PageDown cdecl alias "wxWindow_PageDown" (byval self as integer) as integer
declare function wxWindow_SetHelpText cdecl alias "wxWindow_SetHelpText" (byval self as integer,byval text as string) as integer
declare function wxWindow_SetHelpTextForId cdecl alias "wxWindow_SetHelpTextForId" (byval self as integer,byval text as string) as integer
declare function wxWindow_GetHelpText cdecl alias "wxWindow_GetHelpText" (byval self as integer) as byte ptr
declare function wxWindow_GetToolTip cdecl alias "wxWindow_GetToolTip" (byval self as integer) as integer
declare function wxWindow_GetAncestorWithCustomPalette cdecl alias "wxWindow_GetAncestorWithCustomPalette" (byval self as integer) as integer
declare function wxWindow_SetDropTarget cdecl alias "wxWindow_SetDropTarget" (byval self as integer,byval dropTarget as integer) as integer
declare function wxWindow_GetDropTarget cdecl alias "wxWindow_GetDropTarget" (byval self as integer) as integer
declare function wxWindow_SetConstraints cdecl alias "wxWindow_SetConstraints" (byval self as integer,byval constraints as integer) as integer
declare function wxWindow_GetConstraints cdecl alias "wxWindow_GetConstraints" (byval self as integer) as integer
declare function wxWindow_GetAutoLayout cdecl alias "wxWindow_GetAutoLayout" (byval self as integer) as integer
declare function wxWindow_SetSizerAndFit cdecl alias "wxWindow_SetSizerAndFit" (byval self as integer,byval sizer as integer,byval deleteOld as integer) as integer
declare function wxWindow_GetSizer cdecl alias "wxWindow_GetSizer" (byval self as integer) as integer
declare function wxWindow_SetContainingSizer cdecl alias "wxWindow_SetContainingSizer" (byval self as integer,byval sizer as integer) as integer
declare function wxWindow_GetContainingSizer cdecl alias "wxWindow_GetContainingSizer" (byval self as integer) as integer
declare function wxWindow_GetPalette cdecl alias "wxWindow_GetPalette" (byval self as integer) as integer
declare function wxWindow_SetPalette cdecl alias "wxWindow_SetPalette" (byval self as integer,byval pal as integer) as integer
declare function wxWindow_HasCustomPalette cdecl alias "wxWindow_HasCustomPalette" (byval self as integer) as integer
declare function wxWindow_GetUpdateRegion cdecl alias "wxWindow_GetUpdateRegion" (byval self as integer) as integer
declare function wxWindow_SetWindowVariant cdecl alias "wxWindow_SetWindowVariant" (byval self as integer,byval variant as integer) as integer
declare function wxWindow_GetWindowVariant cdecl alias "wxWindow_GetWindowVariant" (byval self as integer) as integer
declare function wxWindow_IsBeingDeleted cdecl alias "wxWindow_IsBeingDeleted" (byval self as integer) as integer
declare function wxWindow_InvalidateBestSize cdecl alias "wxWindow_InvalidateBestSize" (byval self as integer) as integer
declare function wxWindow_CacheBestSize cdecl alias "wxWindow_CacheBestSize" (byval self as integer,byval size as integer) as integer
declare function wxWindow_GetBestFittingSize cdecl alias "wxWindow_GetBestFittingSize" (byval self as integer,byval size as integer) as integer
declare function wxWindow_SetBestFittingSize cdecl alias "wxWindow_SetBestFittingSize" (byval self as integer,byval size as integer) as integer
declare function wxWindow_GetChildren cdecl alias "wxWindow_GetChildren" (byval self as integer,byval num as integer) as integer
declare function wxWindow_GetChildrenCount cdecl alias "wxWindow_GetChildrenCount" (byval self as integer) as integer
declare function wxWindow_GetDefaultAttributes cdecl alias "wxWindow_GetDefaultAttributes" (byval self as integer) as integer
declare function wxWindow_GetClassDefaultAttributes cdecl alias "wxWindow_GetClassDefaultAttributes" (byval variant as integer) as integer
declare function wxWindow_SetBackgroundStyle cdecl alias "wxWindow_SetBackgroundStyle" (byval self as integer,byval style as integer) as integer
declare function wxWindow_GetBackgroundStyle cdecl alias "wxWindow_GetBackgroundStyle" (byval self as integer) as integer
declare function wxWindow_InheritAttributes cdecl alias "wxWindow_InheritAttributes" (byval self as integer) as integer
declare function wxWindow_ShouldInheritColours cdecl alias "wxWindow_ShouldInheritColours" (byval self as integer) as integer
declare function wxVisualAttributes_ctor cdecl alias "wxVisualAttributes_ctor" () as integer
declare function wxVisualAttributes_dtor cdecl alias "wxVisualAttributes_dtor" (byval self as integer) as integer
declare function wxVisualAttributes_RegisterDisposable cdecl alias "wxVisualAttributes_RegisterDisposable" (byval self as integer,byval onDispose as integer) as integer
declare function wxVisualAttributes_SetFont cdecl alias "wxVisualAttributes_SetFont" (byval self as integer,byval font as integer) as integer
declare function wxVisualAttributes_GetFont cdecl alias "wxVisualAttributes_GetFont" (byval self as integer) as integer
declare function wxVisualAttributes_SetColourFg cdecl alias "wxVisualAttributes_SetColourFg" (byval self as integer,byval colour as integer) as integer
declare function wxVisualAttributes_GetColourFg cdecl alias "wxVisualAttributes_GetColourFg" (byval self as integer) as integer
declare function wxVisualAttributes_SetColourBg cdecl alias "wxVisualAttributes_SetColourBg" (byval self as integer,byval colour as integer) as integer
declare function wxVisualAttributes_GetColourBg cdecl alias "wxVisualAttributes_GetColourBg" (byval self as integer) as integer
declare function wxWindowCreateEvent_ctor cdecl alias "wxWindowCreateEvent_ctor" (byval win as integer) as integer
declare function wxWindowCreateEvent_GetWindow cdecl alias "wxWindowCreateEvent_GetWindow" (byval self as integer) as integer
declare function wxWindowDestroyEvent_ctor cdecl alias "wxWindowDestroyEvent_ctor" (byval win as integer) as integer
declare function wxWindowDestroyEvent_GetWindow cdecl alias "wxWindowDestroyEvent_GetWindow" (byval self as integer) as integer
declare function wxWizard_ctor cdecl alias "wxWizard_ctor" (byval parent as integer,byval id as integer,byval title as string,byval bitmap as integer,byval pos as integer) as integer
declare function wxWizard_RunWizard cdecl alias "wxWizard_RunWizard" (byval self as integer,byval firstPage as integer) as integer
declare function wxWizard_SetPageSize cdecl alias "wxWizard_SetPageSize" (byval self as integer,byval size as integer) as integer
declare function wxWizPageSimp_ctor cdecl alias "wxWizPageSimp_ctor" (byval parent as integer,byval prev as integer,byval next as integer) as integer
declare function wxWizPageSimp_Chain cdecl alias "wxWizPageSimp_Chain" (byval page1 as integer,byval page2 as integer) as integer
declare function wxDateTime_ctor cdecl alias "wxDateTime_ctor" () as integer
declare function wxDateTime_dtor cdecl alias "wxDateTime_dtor" (byval self as integer) as integer
declare function wxDateTime_Set cdecl alias "wxDateTime_Set" (byval self as integer,byval day as integer,byval month as integer,byval year as integer,byval hour as integer,byval minute as integer,byval second as integer,byval millisec as integer) as integer
declare function wxDateTime_GetYear cdecl alias "wxDateTime_GetYear" (byval self as integer) as integer
declare function wxDateTime_GetMonth cdecl alias "wxDateTime_GetMonth" (byval self as integer) as integer
declare function wxDateTime_GetDay cdecl alias "wxDateTime_GetDay" (byval self as integer) as integer
declare function wxDateTime_GetHour cdecl alias "wxDateTime_GetHour" (byval self as integer) as integer
declare function wxDateTime_GetMinute cdecl alias "wxDateTime_GetMinute" (byval self as integer) as integer
declare function wxDateTime_GetSecond cdecl alias "wxDateTime_GetSecond" (byval self as integer) as integer
declare function wxDateTime_GetMillisecond cdecl alias "wxDateTime_GetMillisecond" (byval self as integer) as integer
declare function wxString_ctor cdecl alias "wxString_ctor" (byval str as string) as byte ptr
declare function wxString_dtor cdecl alias "wxString_dtor" (byval self as byte ptr) as integer
declare function wxString_mb_str cdecl alias "wxString_mb_str" (byval self as byte ptr) as string
declare function wxString_Length cdecl alias "wxString_Length" (byval self as byte ptr) as integer
declare function wxString_CharAt cdecl alias "wxString_CharAt" (byval self as byte ptr,byval i as integer) as byte
declare function wxString_CharAtInt cdecl alias "wxString_CharAtInt" (byval self as byte ptr,byval i as integer) as integer
declare function wxXmlResource_ctorByFilemask cdecl alias "wxXmlResource_ctorByFilemask" (byval filemask as string,byval flags as integer= wxXRC_USE_LOCALE) as integer
declare function wxXmlResource_ctor cdecl alias "wxXmlResource_ctor" (byval flags as integer) as integer
declare function wxXmlResource_InitAllHandlers cdecl alias "wxXmlResource_InitAllHandlers" (byval self as integer) as integer
declare function wxXmlResource_Load cdecl alias "wxXmlResource_Load" (byval self as integer,byval filemask as string) as integer
declare function wxXmlResource_LoadDialog cdecl alias "wxXmlResource_LoadDialog" (byval self as integer,byval parent as integer,byval name as string) as integer
declare function wxXmlResource_LoadDialogDlg cdecl alias "wxXmlResource_LoadDialogDlg" (byval self as integer,byval dlg as integer,byval parent as integer,byval name as string) as integer
declare function wxXmlResource_GetXRCID cdecl alias "wxXmlResource_GetXRCID" (byval str_id as string) as integer
declare function wxXmlResource_GetVersion cdecl alias "wxXmlResource_GetVersion" (byval self as integer) as long
declare function wxXmlResource_LoadFrameWithFrame cdecl alias "wxXmlResource_LoadFrameWithFrame" (byval self as integer,byval frame as integer,byval parent as integer,byval name as string) as integer
declare function wxXmlResource_LoadFrame cdecl alias "wxXmlResource_LoadFrame" (byval self as integer,byval parent as integer,byval name as string) as integer
declare function wxXmlResource_LoadBitmap cdecl alias "wxXmlResource_LoadBitmap" (byval self as integer,byval name as string) as integer
declare function wxXmlResource_LoadIcon cdecl alias "wxXmlResource_LoadIcon" (byval self as integer,byval name as string) as integer
declare function wxXmlResource_LoadMenu cdecl alias "wxXmlResource_LoadMenu" (byval self as integer,byval name as string) as integer
declare function wxXmlResource_LoadMenuBarWithParent cdecl alias "wxXmlResource_LoadMenuBarWithParent" (byval self as integer,byval parent as integer,byval name as string) as integer
declare function wxXmlResource_LoadMenuBar cdecl alias "wxXmlResource_LoadMenuBar" (byval self as integer,byval name as string) as integer
declare function wxXmlResource_LoadPanelWithPanel cdecl alias "wxXmlResource_LoadPanelWithPanel" (byval self as integer,byval panel as integer,byval parent as integer,byval name as string) as integer
declare function wxXmlResource_LoadPanel cdecl alias "wxXmlResource_LoadPanel" (byval self as integer,byval parent as integer,byval name as string) as integer
declare function wxXmlResource_LoadToolBar cdecl alias "wxXmlResource_LoadToolBar" (byval self as integer,byval parent as integer,byval name as string) as integer
declare function wxXmlResource_SetFlags cdecl alias "wxXmlResource_SetFlags" (byval self as integer,byval flags as integer) as integer
declare function wxXmlResource_GetFlags cdecl alias "wxXmlResource_GetFlags" (byval self as integer) as integer
declare function wxXmlResource_CompareVersion cdecl alias "wxXmlResource_CompareVersion" (byval self as integer,byval major as integer,byval minor as integer,byval release as integer,byval revision as integer) as integer
declare function wxXmlResource_AttachUnknownControl cdecl alias "wxXmlResource_AttachUnknownControl" (byval self as integer,byval name as string,byval control as integer,byval parent as integer) as integer
