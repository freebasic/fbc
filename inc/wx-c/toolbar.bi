#Ifndef __toolbar_bi__
#Define __toolbar_bi__

#Include Once "common.bi"

' class wxToolBar
Declare Function wxToolBar_ctor WXCALL Alias "wxToolBar_ctor" ( _
					parent As wxWindow Ptr, _
                    id     As  wxWindowID = -1, _
                    pos    As  wxPoint Ptr, _
                    size   As  wxSize  Ptr, _
                    style  As  wxUInt     =  0) As wxToolBar Ptr
Declare Function wxToolBar_AddTool1 WXCALL Alias "wxToolBar_AddTool1" (self As wxToolBar Ptr, toolID As wxInt, labelArg As wxString Ptr, bitmap As wxBitmap Ptr, bitmapDisabled As wxBitmap Ptr, kind As wxItemKind, shortHelpArg As wxString Ptr, helpArg As wxString Ptr, pData As wxObject Ptr) As wxToolBarToolBase Ptr 
Declare Function wxToolBar_AddTool2 WXCALL Alias "wxToolBar_AddTool2" (self As wxToolBar Ptr, toolID As wxInt, labelArg As wxString Ptr, bitmap As wxBitmap Ptr, shortHelpArg As wxString Ptr, kind As wxItemKind) As wxToolBarToolBase Ptr
Declare Function wxToolBar_AddTool3 WXCALL Alias "wxToolBar_AddTool3" (self As wxToolBar Ptr, toolID As wxInt, bitmap As wxBitmap Ptr, bitmapDisabled As wxBitmap Ptr, toggle As wxBool, clientData As wxObject Ptr, shortHelpArg As wxString Ptr, helpArg As wxString Ptr) As wxToolBarToolBase Ptr
Declare Function wxToolBar_AddTool4 WXCALL Alias "wxToolBar_AddTool4" (self As wxToolBar Ptr, toolID As wxInt, bitmap As wxBitmap Ptr, shortHelpArg As wxString Ptr, helpArg As wxString Ptr) As wxToolBarToolBase Ptr
Declare Function wxToolBar_AddTool5 WXCALL Alias "wxToolBar_AddTool5" (self As wxToolBar Ptr, toolID As wxInt, bitmap As wxBitmap Ptr, bitmapDisabled As wxBitmap Ptr, toggle As wxBool, x As wxCoord, y As wxCoord, clientData As wxObject Ptr, shortHelpArg As wxString Ptr, helpArg As wxString Ptr) As wxToolBarToolBase Ptr
Declare Function wxToolBar_AddCheckTool WXCALL Alias "wxToolBar_AddCheckTool" (self As wxToolBar Ptr, toolID As wxInt, labelArg As wxString Ptr, bitmap As wxBitmap Ptr, bitmapDisabled As wxBitmap Ptr, shortHelpArg As wxString Ptr, helpArg As wxString Ptr, pData As wxObject Ptr) As wxToolBarToolBase Ptr
Declare Function wxToolBar_AddRadioTool WXCALL Alias "wxToolBar_AddRadioTool" (self As wxToolBar Ptr, toolID As wxInt, labelArg As wxString Ptr, bitmap As wxBitmap Ptr, bitmapDisabled As wxBitmap Ptr, shortHelpArg As wxString Ptr, helpArg As wxString Ptr, pData As wxObject Ptr) As wxToolBarToolBase Ptr
Declare Function wxToolBar_AddControl WXCALL Alias "wxToolBar_AddControl" (self As wxToolBar Ptr, control As wxControl Ptr) As wxToolBarToolBase Ptr
Declare Function wxToolBar_InsertControl WXCALL Alias "wxToolBar_InsertControl" (self As wxToolBar Ptr, sPos As size_t, control As wxControl Ptr) As wxToolBarToolBase Ptr
Declare Function wxToolBar_FindControl WXCALL Alias "wxToolBar_FindControl" (self As wxToolBar Ptr, toolID As wxInt) As wxControl Ptr 
Declare Function wxToolBar_AddSeparator WXCALL Alias "wxToolBar_AddSeparator" (self As wxToolBar Ptr) As wxToolBarToolBase Ptr
Declare Function wxToolBar_InsertSeparator WXCALL Alias "wxToolBar_InsertSeparator" (self As wxToolBar Ptr, sPos As size_t) As wxToolBarToolBase Ptr
Declare Function wxToolBar_RemoveTool WXCALL Alias "wxToolBar_RemoveTool" (self As wxToolBar Ptr, toolID As wxInt) As wxToolBarToolBase Ptr
Declare Function wxToolBar_DeleteToolByPos WXCALL Alias "wxToolBar_DeleteToolByPos" (self As wxToolBar Ptr, sPos As size_t) As wxBool
Declare Function wxToolBar_DeleteTool WXCALL Alias "wxToolBar_DeleteTool" (self As wxToolBar Ptr, toolID As wxInt) As wxBool
Declare Sub wxToolBar_ClearTools WXCALL Alias "wxToolBar_ClearTools" (self As wxToolBar Ptr)
Declare Function wxToolBar_Realize WXCALL Alias "wxToolBar_Realize" (self As wxToolBar Ptr) As wxBool
Declare Sub wxToolBar_EnableTool WXCALL Alias "wxToolBar_EnableTool" (self As wxToolBar Ptr, toolID As wxInt, enable As wxBool)
Declare Sub wxToolBar_ToggleTool WXCALL Alias "wxToolBar_ToggleTool" (self As wxToolBar Ptr, toolID As wxInt, toggle As wxBool)
Declare Function wxToolBar_GetToolClientData WXCALL Alias "wxToolBar_GetToolClientData" (self As wxToolBar Ptr, toolID As wxInt) As wxObject Ptr
Declare Sub wxToolBar_SetToolClientData WXCALL Alias "wxToolBar_SetToolClientData" (self As wxToolBar Ptr, toolID As wxInt, clientData As wxObject Ptr)
Declare Function wxToolBar_GetToolState WXCALL Alias "wxToolBar_GetToolState" (self As wxToolBar Ptr, toolID As wxInt) As wxBool
Declare Function wxToolBar_GetToolEnabled WXCALL Alias "wxToolBar_GetToolEnabled" (self As wxToolBar Ptr, toolID As wxInt) As wxBool
Declare Sub wxToolBar_SetToolShortHelp WXCALL Alias "wxToolBar_SetToolShortHelp" (self As wxToolBar Ptr, toolID As wxInt, helpString As wxString Ptr)
Declare Function wxToolBar_GetToolShortHelp WXCALL Alias "wxToolBar_GetToolShortHelp" (self As wxToolBar Ptr, toolID As wxInt) As wxString Ptr
Declare Sub wxToolBar_SetToolLongHelp WXCALL Alias "wxToolBar_SetToolLongHelp" (self As wxToolBar Ptr, toolID As wxInt, helpString As wxString Ptr)
Declare Function wxToolBar_GetToolLongHelp WXCALL Alias "wxToolBar_GetToolLongHelp" (self As wxToolBar Ptr, toolID As wxInt) As wxString Ptr
Declare Sub wxToolBar_SetMargins WXCALL Alias "wxToolBar_SetMargins" (self As wxToolBar Ptr, x As wxInt, y As wxInt)
Declare Sub wxToolBar_SetToolPacking WXCALL Alias "wxToolBar_SetToolPacking" (self As wxToolBar Ptr, packing As wxInt)
Declare Sub wxToolBar_SetToolSeparation WXCALL Alias "wxToolBar_SetToolSeparation" (self As wxToolBar Ptr, seperation As wxInt)
Declare Sub wxToolBar_GetToolMargins WXCALL Alias "wxToolBar_GetToolMargins" (self As wxToolBar Ptr, w As wxInt Ptr, h As wxInt Ptr)
Declare Function wxToolBar_GetToolPacking WXCALL Alias "wxToolBar_GetToolPacking" (self As wxToolBar Ptr) As wxInt
Declare Function wxToolBar_GetToolSeparation WXCALL Alias "wxToolBar_GetToolSeparation" (self As wxToolBar Ptr) As wxInt
Declare Sub wxToolBar_SetRows WXCALL Alias "wxToolBar_SetRows" (self As wxToolBar Ptr, rows As wxInt)
Declare Sub wxToolBar_SetMaxRowsCols WXCALL Alias "wxToolBar_SetMaxRowsCols" (self As wxToolBar Ptr, rows As wxInt, cols As wxInt)
Declare Function wxToolBar_GetMaxRows WXCALL Alias "wxToolBar_GetMaxRows" (self As wxToolBar Ptr) As wxInt
Declare Function wxToolBar_GetMaxCols WXCALL Alias "wxToolBar_GetMaxCols" (self As wxToolBar Ptr) As wxInt
Declare Sub wxToolBar_SetToolBitmapSize WXCALL Alias "wxToolBar_SetToolBitmapSize" (self As wxToolBar Ptr, x As wxInt, y As wxInt)
Declare Sub wxToolBar_GetToolBitmapSize WXCALL Alias "wxToolBar_GetToolBitmapSize" (self As wxToolBar Ptr, w As wxInt Ptr, h As wxInt Ptr)
Declare Sub wxToolBar_GetToolSize WXCALL Alias "wxToolBar_GetToolSize" (self As wxToolBar Ptr, w As wxInt Ptr, h As wxInt Ptr)
Declare Function wxToolBar_FindToolForPosition WXCALL Alias "wxToolBar_FindToolForPosition" (self As wxToolBar Ptr, x As wxCoord, y As wxCoord) As wxToolBarBase Ptr
Declare Function wxToolBar_IsVertical WXCALL Alias "wxToolBar_IsVertical" (self As wxToolBar Ptr) As wxBool
Declare Function wxToolBar_InsertTool WXCALL Alias "wxToolBar_InsertTool" (self As wxToolBar Ptr, sPos As size_t, toolID As wxInt, bitmap As wxBitmap Ptr, bitmapDisabled As wxBitmap Ptr, toggle As wxBool, clientData As wxObject Ptr, shortHelpArg As wxString Ptr, helpArg As wxString Ptr) As wxToolBarToolBase Ptr
Declare Sub wxToolBar_GetMargins WXCALL Alias "wxToolBar_GetMargins" (self As wxToolBar Ptr, size As wxSize Ptr)
Declare Function wxToolBar_GetToolsCount WXCALL Alias "wxToolBar_GetToolsCount" (self As wxToolBar Ptr) As size_t
Declare Function wxToolBar_AcceptsFocus WXCALL Alias "wxToolBar_AcceptsFocus" (self As wxToolBar Ptr) As wxBool

' class wxToolBarToolBase 
Declare Function wxToolBarToolBase_ctor WXCALL Alias "wxToolBarToolBase_ctor" (tBar As wxToolBar Ptr, toolID As wxInt, labelArg As wxString Ptr, bitmap As wxBitmap Ptr, bitmapDisabled As wxBitmap Ptr, kind As wxItemKind, clientData As wxObject Ptr, shortHelpArg As wxString Ptr, helpStringArg As wxString Ptr) As wxToolBarToolBase Ptr
Declare Function wxToolBarToolBase_ctorCtrl WXCALL Alias "wxToolBarToolBase_ctorCtrl" (tBar As wxToolBar Ptr, control As wxControl Ptr) As wxToolBarBase Ptr
Declare Function wxToolBarToolBase_GetId WXCALL Alias "wxToolBarToolBase_GetId" (self As wxToolBarToolBase Ptr) As wxInt
Declare Function wxToolBarToolBase_GetControl WXCALL Alias "wxToolBarToolBase_GetControl" (self As wxToolBarToolBase Ptr) As wxControl Ptr
Declare Function wxToolBarToolBase_GetToolBar WXCALL Alias "wxToolBarToolBase_GetToolBar" (self As wxToolBarToolBase Ptr) As wxToolBar Ptr
Declare Function wxToolBarToolBase_IsButton WXCALL Alias "wxToolBarToolBase_IsButton" (self As wxToolBarToolBase Ptr) As wxBool
Declare Function wxToolBarToolBase_IsControl WXCALL Alias "wxToolBarToolBase_IsControl" (self As wxToolBarToolBase Ptr) As wxBool
Declare Function wxToolBarToolBase_IsSeparator WXCALL Alias "wxToolBarToolBase_IsSeparator" (self As wxToolBarToolBase Ptr) As wxBool
Declare Function wxToolBarToolBase_GetStyle WXCALL Alias "wxToolBarToolBase_GetStyle" (self As wxToolBarToolBase Ptr) As wxInt
Declare Function wxToolBarToolBase_GetKind WXCALL Alias "wxToolBarToolBase_GetKind" (self As wxToolBarToolBase Ptr) As wxItemKind
Declare Function wxToolBarToolBase_IsEnabled WXCALL Alias "wxToolBarToolBase_IsEnabled" (self As wxToolBarToolBase Ptr) As wxBool
Declare Function wxToolBarToolBase_IsToggled WXCALL Alias "wxToolBarToolBase_IsToggled" (self As wxToolBarToolBase Ptr) As wxBool
Declare Function wxToolBarToolBase_CanBeToggled WXCALL Alias "wxToolBarToolBase_CanBeToggled" (self As wxToolBarToolBase Ptr) As wxBool
Declare Function wxToolBarToolBase_GetLabel WXCALL Alias "wxToolBarToolBase_GetLabel" (self As wxToolBarToolBase Ptr) As wxString Ptr
Declare Function wxToolBarToolBase_GetShortHelp WXCALL Alias "wxToolBarToolBase_GetShortHelp" (self As wxToolBarToolBase Ptr) As wxString Ptr
Declare Function wxToolBarToolBase_GetLongHelp WXCALL Alias "wxToolBarToolBase_GetLongHelp" (self As wxToolBarToolBase Ptr) As wxString Ptr
Declare Function wxToolBarToolBase_GetClientData WXCALL Alias "wxToolBarToolBase_GetClientData" (self As wxToolBarToolBase Ptr) As wxObject Ptr
Declare Function wxToolBarToolBase_Enable WXCALL Alias "wxToolBarToolBase_Enable" (self As wxToolBarToolBase Ptr, enable As wxBool) As wxBool
Declare Function wxToolBarToolBase_Toggle WXCALL Alias "wxToolBarToolBase_Toggle" (self As wxToolBarToolBase Ptr, toggle As wxBool) As wxBool
Declare Function wxToolBarToolBase_SetToggle WXCALL Alias "wxToolBarToolBase_SetToggle" (self As wxToolBarToolBase Ptr, toggle As wxBool) As wxBool
Declare Function wxToolBarToolBase_SetShortHelp WXCALL Alias "wxToolBarToolBase_SetShortHelp" (self As wxToolBarToolBase Ptr, sHelp As wxString Ptr) As wxBool
Declare Function wxToolBarToolBase_SetLongHelp WXCALL Alias "wxToolBarToolBase_SetLongHelp" (self As wxToolBarToolBase Ptr, lHelp As wxString Ptr) As wxBool
Declare Sub wxToolBarToolBase_SetNormalBitmap WXCALL Alias "wxToolBarToolBase_SetNormalBitmap" (self As wxToolBarToolBase Ptr, bitmap As wxBitmap Ptr)
Declare Sub wxToolBarToolBase_SetDisabledBitmap WXCALL Alias "wxToolBarToolBase_SetDisabledBitmap" (self As wxToolBarToolBase Ptr, bitmap As wxBitmap Ptr)
Declare Sub wxToolBarToolBase_SetLabel WXCALL Alias "wxToolBarToolBase_SetLabel" (self As wxToolBarToolBase Ptr, label As wxString Ptr)
Declare Sub wxToolBarToolBase_SetClientData WXCALL Alias "wxToolBarToolBase_SetClientData" (self As wxToolBarToolBase Ptr, clientData As wxObject Ptr)
Declare Sub wxToolBarToolBase_Detach WXCALL Alias "wxToolBarToolBase_Detach" (self As wxToolBarToolBase Ptr)
Declare Sub wxToolBarToolBase_Attach WXCALL Alias "wxToolBarToolBase_Attach" (self As wxToolBarToolBase Ptr, tBar As wxToolBar Ptr)

#EndIf ' __toolbar_bi__

