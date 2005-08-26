''
''
'' toolbar -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __toolbar_bi__
#define __toolbar_bi__

#include once "wx-c/wx.bi"


declare function wxToolBarToolBase cdecl alias "wxToolBarToolBase_ctor" (byval tbar as wxToolBar ptr, byval toolid as integer, byval label as zstring ptr, byval bmpNormal as wxBitmap ptr, byval bmpDisabled as wxBitmap ptr, byval kind as wxItemKind, byval clientData as wxObject ptr, byval shortHelpString as zstring ptr, byval longHelpString as zstring ptr) as wxToolBarToolBase ptr
declare function wxToolBarToolBase_ctorCtrl cdecl alias "wxToolBarToolBase_ctorCtrl" (byval tbar as wxToolBar ptr, byval control as wxControl ptr) as wxToolBarToolBase ptr
declare function wxToolBarToolBase_GetId cdecl alias "wxToolBarToolBase_GetId" (byval self as wxToolBarToolBase ptr) as integer
declare function wxToolBarToolBase_GetControl cdecl alias "wxToolBarToolBase_GetControl" (byval self as wxToolBarToolBase ptr) as wxControl ptr
declare function wxToolBarToolBase_GetToolBar cdecl alias "wxToolBarToolBase_GetToolBar" (byval self as wxToolBarToolBase ptr) as wxToolBar ptr
declare function wxToolBarToolBase_IsButton cdecl alias "wxToolBarToolBase_IsButton" (byval self as wxToolBarToolBase ptr) as integer
declare function wxToolBarToolBase_IsControl cdecl alias "wxToolBarToolBase_IsControl" (byval self as wxToolBarToolBase ptr) as integer
declare function wxToolBarToolBase_IsSeparator cdecl alias "wxToolBarToolBase_IsSeparator" (byval self as wxToolBarToolBase ptr) as integer
declare function wxToolBarToolBase_GetStyle cdecl alias "wxToolBarToolBase_GetStyle" (byval self as wxToolBarToolBase ptr) as integer
declare function wxToolBarToolBase_GetKind cdecl alias "wxToolBarToolBase_GetKind" (byval self as wxToolBarToolBase ptr) as wxItemKind
declare function wxToolBarToolBase_IsEnabled cdecl alias "wxToolBarToolBase_IsEnabled" (byval self as wxToolBarToolBase ptr) as integer
declare function wxToolBarToolBase_IsToggled cdecl alias "wxToolBarToolBase_IsToggled" (byval self as wxToolBarToolBase ptr) as integer
declare function wxToolBarToolBase_CanBeToggled cdecl alias "wxToolBarToolBase_CanBeToggled" (byval self as wxToolBarToolBase ptr) as integer
declare function wxToolBarToolBase_GetLabel cdecl alias "wxToolBarToolBase_GetLabel" (byval self as wxToolBarToolBase ptr) as wxString ptr
declare function wxToolBarToolBase_GetShortHelp cdecl alias "wxToolBarToolBase_GetShortHelp" (byval self as wxToolBarToolBase ptr) as wxString ptr
declare function wxToolBarToolBase_GetLongHelp cdecl alias "wxToolBarToolBase_GetLongHelp" (byval self as wxToolBarToolBase ptr) as wxString ptr
declare function wxToolBarToolBase_GetClientData cdecl alias "wxToolBarToolBase_GetClientData" (byval self as wxToolBarToolBase ptr) as wxObject ptr
declare function wxToolBarToolBase_Enable cdecl alias "wxToolBarToolBase_Enable" (byval self as wxToolBarToolBase ptr, byval enable as integer) as integer
declare function wxToolBarToolBase_Toggle cdecl alias "wxToolBarToolBase_Toggle" (byval self as wxToolBarToolBase ptr, byval toggle as integer) as integer
declare function wxToolBarToolBase_SetToggle cdecl alias "wxToolBarToolBase_SetToggle" (byval self as wxToolBarToolBase ptr, byval toggle as integer) as integer
declare function wxToolBarToolBase_SetShortHelp cdecl alias "wxToolBarToolBase_SetShortHelp" (byval self as wxToolBarToolBase ptr, byval help as zstring ptr) as integer
declare function wxToolBarToolBase_SetLongHelp cdecl alias "wxToolBarToolBase_SetLongHelp" (byval self as wxToolBarToolBase ptr, byval help as zstring ptr) as integer
declare sub wxToolBarToolBase_SetNormalBitmap cdecl alias "wxToolBarToolBase_SetNormalBitmap" (byval self as wxToolBarToolBase ptr, byval bmp as wxBitmap ptr)
declare sub wxToolBarToolBase_SetDisabledBitmap cdecl alias "wxToolBarToolBase_SetDisabledBitmap" (byval self as wxToolBarToolBase ptr, byval bmp as wxBitmap ptr)
declare sub wxToolBarToolBase_SetLabel cdecl alias "wxToolBarToolBase_SetLabel" (byval self as wxToolBarToolBase ptr, byval label as zstring ptr)
declare sub wxToolBarToolBase_SetClientData cdecl alias "wxToolBarToolBase_SetClientData" (byval self as wxToolBarToolBase ptr, byval clientData as wxObject ptr)
declare sub wxToolBarToolBase_Detach cdecl alias "wxToolBarToolBase_Detach" (byval self as wxToolBarToolBase ptr)
declare sub wxToolBarToolBase_Attach cdecl alias "wxToolBarToolBase_Attach" (byval self as wxToolBarToolBase ptr, byval tbar as wxToolBar ptr)

declare function wxToolBar cdecl alias "wxToolBar_ctor" (byval parent as wxWindow ptr, byval id as wxWindowID, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer) as wxToolBar ptr
declare function wxToolBar_AddTool1 cdecl alias "wxToolBar_AddTool1" (byval self as wxToolBar ptr, byval toolid as integer, byval label as zstring ptr, byval bitmap as wxBitmap ptr, byval bmpDisabled as wxBitmap ptr, byval kind as wxItemKind, byval shortHelp as zstring ptr, byval longHelp as zstring ptr, byval data as wxObject ptr) as wxToolBarToolBase ptr
declare function wxToolBar_AddTool2 cdecl alias "wxToolBar_AddTool2" (byval self as wxToolBar ptr, byval toolid as integer, byval label as zstring ptr, byval bitmap as wxBitmap ptr, byval shortHelp as zstring ptr, byval kind as wxItemKind) as wxToolBarToolBase ptr
declare function wxToolBar_AddCheckTool cdecl alias "wxToolBar_AddCheckTool" (byval self as wxToolBar ptr, byval toolid as integer, byval label as zstring ptr, byval bitmap as wxBitmap ptr, byval bmpDisabled as wxBitmap ptr, byval shortHelp as zstring ptr, byval longHelp as zstring ptr, byval data as wxObject ptr) as wxToolBarToolBase ptr
declare function wxToolBar_AddRadioTool cdecl alias "wxToolBar_AddRadioTool" (byval self as wxToolBar ptr, byval toolid as integer, byval label as zstring ptr, byval bitmap as wxBitmap ptr, byval bmpDisabled as wxBitmap ptr, byval shortHelp as zstring ptr, byval longHelp as zstring ptr, byval data as wxObject ptr) as wxToolBarToolBase ptr
declare function wxToolBar_AddControl cdecl alias "wxToolBar_AddControl" (byval self as wxToolBar ptr, byval control as wxControl ptr) as wxToolBarToolBase ptr
declare function wxToolBar_InsertControl cdecl alias "wxToolBar_InsertControl" (byval self as wxToolBar ptr, byval pos as integer, byval control as wxControl ptr) as wxToolBarToolBase ptr
declare function wxToolBar_FindControl cdecl alias "wxToolBar_FindControl" (byval self as wxToolBar ptr, byval toolid as integer) as wxControl ptr
declare function wxToolBar_AddSeparator cdecl alias "wxToolBar_AddSeparator" (byval self as wxToolBar ptr) as wxToolBarToolBase ptr
declare function wxToolBar_InsertSeparator cdecl alias "wxToolBar_InsertSeparator" (byval self as wxToolBar ptr, byval pos as integer) as wxToolBarToolBase ptr
declare function wxToolBar_RemoveTool cdecl alias "wxToolBar_RemoveTool" (byval self as wxToolBar ptr, byval toolid as integer) as wxToolBarToolBase ptr
declare function wxToolBar_DeleteToolByPos cdecl alias "wxToolBar_DeleteToolByPos" (byval self as wxToolBar ptr, byval pos as integer) as integer
declare function wxToolBar_DeleteTool cdecl alias "wxToolBar_DeleteTool" (byval self as wxToolBar ptr, byval toolid as integer) as integer
declare sub wxToolBar_ClearTools cdecl alias "wxToolBar_ClearTools" (byval self as wxToolBar ptr)
declare function wxToolBar_Realize cdecl alias "wxToolBar_Realize" (byval self as wxToolBar ptr) as integer
declare sub wxToolBar_EnableTool cdecl alias "wxToolBar_EnableTool" (byval self as wxToolBar ptr, byval toolid as integer, byval enable as integer)
declare sub wxToolBar_ToggleTool cdecl alias "wxToolBar_ToggleTool" (byval self as wxToolBar ptr, byval toolid as integer, byval toggle as integer)
declare function wxToolBar_GetToolClientData cdecl alias "wxToolBar_GetToolClientData" (byval self as wxToolBar ptr, byval toolid as integer) as wxObject ptr
declare sub wxToolBar_SetToolClientData cdecl alias "wxToolBar_SetToolClientData" (byval self as wxToolBar ptr, byval toolid as integer, byval clientData as wxObject ptr)
declare function wxToolBar_GetToolState cdecl alias "wxToolBar_GetToolState" (byval self as wxToolBar ptr, byval toolid as integer) as integer
declare function wxToolBar_GetToolEnabled cdecl alias "wxToolBar_GetToolEnabled" (byval self as wxToolBar ptr, byval toolid as integer) as integer
declare sub wxToolBar_SetToolShortHelp cdecl alias "wxToolBar_SetToolShortHelp" (byval self as wxToolBar ptr, byval toolid as integer, byval helpString as zstring ptr)
declare function wxToolBar_GetToolShortHelp cdecl alias "wxToolBar_GetToolShortHelp" (byval self as wxToolBar ptr, byval toolid as integer) as wxString ptr
declare sub wxToolBar_SetToolLongHelp cdecl alias "wxToolBar_SetToolLongHelp" (byval self as wxToolBar ptr, byval toolid as integer, byval helpString as zstring ptr)
declare function wxToolBar_GetToolLongHelp cdecl alias "wxToolBar_GetToolLongHelp" (byval self as wxToolBar ptr, byval toolid as integer) as wxString ptr
declare sub wxToolBar_SetMargins cdecl alias "wxToolBar_SetMargins" (byval self as wxToolBar ptr, byval x as integer, byval y as integer)
declare sub wxToolBar_SetToolPacking cdecl alias "wxToolBar_SetToolPacking" (byval self as wxToolBar ptr, byval packing as integer)
declare sub wxToolBar_SetToolSeparation cdecl alias "wxToolBar_SetToolSeparation" (byval self as wxToolBar ptr, byval separation as integer)
declare sub wxToolBar_GetToolMargins cdecl alias "wxToolBar_GetToolMargins" (byval self as wxToolBar ptr, byval size as wxSize ptr)
declare function wxToolBar_GetToolPacking cdecl alias "wxToolBar_GetToolPacking" (byval self as wxToolBar ptr) as integer
declare function wxToolBar_GetToolSeparation cdecl alias "wxToolBar_GetToolSeparation" (byval self as wxToolBar ptr) as integer
declare sub wxToolBar_SetRows cdecl alias "wxToolBar_SetRows" (byval self as wxToolBar ptr, byval nRows as integer)
declare sub wxToolBar_SetMaxRowsCols cdecl alias "wxToolBar_SetMaxRowsCols" (byval self as wxToolBar ptr, byval rows as integer, byval cols as integer)
declare function wxToolBar_GetMaxRows cdecl alias "wxToolBar_GetMaxRows" (byval self as wxToolBar ptr) as integer
declare function wxToolBar_GetMaxCols cdecl alias "wxToolBar_GetMaxCols" (byval self as wxToolBar ptr) as integer
declare sub wxToolBar_SetToolBitmapSize cdecl alias "wxToolBar_SetToolBitmapSize" (byval self as wxToolBar ptr, byval size as wxSize ptr)
declare sub wxToolBar_GetToolBitmapSize cdecl alias "wxToolBar_GetToolBitmapSize" (byval self as wxToolBar ptr, byval size as wxSize ptr)
declare sub wxToolBar_GetToolSize cdecl alias "wxToolBar_GetToolSize" (byval self as wxToolBar ptr, byval size as wxSize ptr)
declare function wxToolBar_FindToolForPosition cdecl alias "wxToolBar_FindToolForPosition" (byval self as wxToolBar ptr, byval x as wxCoord, byval y as wxCoord) as wxToolBarToolBase ptr
declare function wxToolBar_IsVertical cdecl alias "wxToolBar_IsVertical" (byval self as wxToolBar ptr) as integer
declare function wxToolBar_AddTool3 cdecl alias "wxToolBar_AddTool3" (byval self as wxToolBar ptr, byval toolid as integer, byval bitmap as wxBitmap ptr, byval bmpDisabled as wxBitmap ptr, byval toggle as integer, byval clientData as wxObject ptr, byval shortHelpString as zstring ptr, byval longHelpString as zstring ptr) as wxToolBarToolBase ptr
declare function wxToolBar_AddTool4 cdecl alias "wxToolBar_AddTool4" (byval self as wxToolBar ptr, byval toolid as integer, byval bitmap as wxBitmap ptr, byval shortHelpString as zstring ptr, byval longHelpString as zstring ptr) as wxToolBarToolBase ptr
declare function wxToolBar_AddTool5 cdecl alias "wxToolBar_AddTool5" (byval self as wxToolBar ptr, byval toolid as integer, byval bitmap as wxBitmap ptr, byval bmpDisabled as wxBitmap ptr, byval toggle as integer, byval xPos as wxCoord, byval yPos as wxCoord, byval clientData as wxObject ptr, byval shortHelp as zstring ptr, byval longHelp as zstring ptr) as wxToolBarToolBase ptr
declare function wxToolBar_InsertTool cdecl alias "wxToolBar_InsertTool" (byval self as wxToolBar ptr, byval pos as integer, byval toolid as integer, byval bitmap as wxBitmap ptr, byval bmpDisabled as wxBitmap ptr, byval toggle as integer, byval clientData as wxObject ptr, byval shortHelp as zstring ptr, byval longHelp as zstring ptr) as wxToolBarToolBase ptr
declare sub wxToolBar_GetMargins cdecl alias "wxToolBar_GetMargins" (byval self as wxToolBar ptr, byval size as wxSize ptr)
declare function wxToolBar_GetToolsCount cdecl alias "wxToolBar_GetToolsCount" (byval self as wxToolBar ptr) as integer
declare function wxToolBar_AcceptsFocus cdecl alias "wxToolBar_AcceptsFocus" (byval self as wxToolBar ptr) as integer

#endif
