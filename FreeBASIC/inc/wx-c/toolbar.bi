''
''
'' toolbar -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_toolbar_bi__
#define __wxc_toolbar_bi__

#include once "wx.bi"


declare function wxToolBarToolBase alias "wxToolBarToolBase_ctor" (byval tbar as wxToolBar ptr, byval toolid as integer, byval label as zstring ptr, byval bmpNormal as wxBitmap ptr, byval bmpDisabled as wxBitmap ptr, byval kind as wxItemKind, byval clientData as wxObject ptr, byval shortHelpString as zstring ptr, byval longHelpString as zstring ptr) as wxToolBarToolBase ptr
declare function wxToolBarToolBase_ctorCtrl (byval tbar as wxToolBar ptr, byval control as wxControl ptr) as wxToolBarToolBase ptr
declare function wxToolBarToolBase_GetId (byval self as wxToolBarToolBase ptr) as integer
declare function wxToolBarToolBase_GetControl (byval self as wxToolBarToolBase ptr) as wxControl ptr
declare function wxToolBarToolBase_GetToolBar (byval self as wxToolBarToolBase ptr) as wxToolBar ptr
declare function wxToolBarToolBase_IsButton (byval self as wxToolBarToolBase ptr) as integer
declare function wxToolBarToolBase_IsControl (byval self as wxToolBarToolBase ptr) as integer
declare function wxToolBarToolBase_IsSeparator (byval self as wxToolBarToolBase ptr) as integer
declare function wxToolBarToolBase_GetStyle (byval self as wxToolBarToolBase ptr) as integer
declare function wxToolBarToolBase_GetKind (byval self as wxToolBarToolBase ptr) as wxItemKind
declare function wxToolBarToolBase_IsEnabled (byval self as wxToolBarToolBase ptr) as integer
declare function wxToolBarToolBase_IsToggled (byval self as wxToolBarToolBase ptr) as integer
declare function wxToolBarToolBase_CanBeToggled (byval self as wxToolBarToolBase ptr) as integer
declare function wxToolBarToolBase_GetLabel (byval self as wxToolBarToolBase ptr) as wxString ptr
declare function wxToolBarToolBase_GetShortHelp (byval self as wxToolBarToolBase ptr) as wxString ptr
declare function wxToolBarToolBase_GetLongHelp (byval self as wxToolBarToolBase ptr) as wxString ptr
declare function wxToolBarToolBase_GetClientData (byval self as wxToolBarToolBase ptr) as wxObject ptr
declare function wxToolBarToolBase_Enable (byval self as wxToolBarToolBase ptr, byval enable as integer) as integer
declare function wxToolBarToolBase_Toggle (byval self as wxToolBarToolBase ptr, byval toggle as integer) as integer
declare function wxToolBarToolBase_SetToggle (byval self as wxToolBarToolBase ptr, byval toggle as integer) as integer
declare function wxToolBarToolBase_SetShortHelp (byval self as wxToolBarToolBase ptr, byval help as zstring ptr) as integer
declare function wxToolBarToolBase_SetLongHelp (byval self as wxToolBarToolBase ptr, byval help as zstring ptr) as integer
declare sub wxToolBarToolBase_SetNormalBitmap (byval self as wxToolBarToolBase ptr, byval bmp as wxBitmap ptr)
declare sub wxToolBarToolBase_SetDisabledBitmap (byval self as wxToolBarToolBase ptr, byval bmp as wxBitmap ptr)
declare sub wxToolBarToolBase_SetLabel (byval self as wxToolBarToolBase ptr, byval label as zstring ptr)
declare sub wxToolBarToolBase_SetClientData (byval self as wxToolBarToolBase ptr, byval clientData as wxObject ptr)
declare sub wxToolBarToolBase_Detach (byval self as wxToolBarToolBase ptr)
declare sub wxToolBarToolBase_Attach (byval self as wxToolBarToolBase ptr, byval tbar as wxToolBar ptr)

declare function wxToolBar alias "wxToolBar_ctor" (byval parent as wxWindow ptr, byval id as wxWindowID, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer) as wxToolBar ptr
declare function wxToolBar_AddTool1 (byval self as wxToolBar ptr, byval toolid as integer, byval label as zstring ptr, byval bitmap as wxBitmap ptr, byval bmpDisabled as wxBitmap ptr, byval kind as wxItemKind, byval shortHelp as zstring ptr, byval longHelp as zstring ptr, byval data as wxObject ptr) as wxToolBarToolBase ptr
declare function wxToolBar_AddTool2 (byval self as wxToolBar ptr, byval toolid as integer, byval label as zstring ptr, byval bitmap as wxBitmap ptr, byval shortHelp as zstring ptr, byval kind as wxItemKind) as wxToolBarToolBase ptr
declare function wxToolBar_AddCheckTool (byval self as wxToolBar ptr, byval toolid as integer, byval label as zstring ptr, byval bitmap as wxBitmap ptr, byval bmpDisabled as wxBitmap ptr, byval shortHelp as zstring ptr, byval longHelp as zstring ptr, byval data as wxObject ptr) as wxToolBarToolBase ptr
declare function wxToolBar_AddRadioTool (byval self as wxToolBar ptr, byval toolid as integer, byval label as zstring ptr, byval bitmap as wxBitmap ptr, byval bmpDisabled as wxBitmap ptr, byval shortHelp as zstring ptr, byval longHelp as zstring ptr, byval data as wxObject ptr) as wxToolBarToolBase ptr
declare function wxToolBar_AddControl (byval self as wxToolBar ptr, byval control as wxControl ptr) as wxToolBarToolBase ptr
declare function wxToolBar_InsertControl (byval self as wxToolBar ptr, byval pos as integer, byval control as wxControl ptr) as wxToolBarToolBase ptr
declare function wxToolBar_FindControl (byval self as wxToolBar ptr, byval toolid as integer) as wxControl ptr
declare function wxToolBar_AddSeparator (byval self as wxToolBar ptr) as wxToolBarToolBase ptr
declare function wxToolBar_InsertSeparator (byval self as wxToolBar ptr, byval pos as integer) as wxToolBarToolBase ptr
declare function wxToolBar_RemoveTool (byval self as wxToolBar ptr, byval toolid as integer) as wxToolBarToolBase ptr
declare function wxToolBar_DeleteToolByPos (byval self as wxToolBar ptr, byval pos as integer) as integer
declare function wxToolBar_DeleteTool (byval self as wxToolBar ptr, byval toolid as integer) as integer
declare sub wxToolBar_ClearTools (byval self as wxToolBar ptr)
declare function wxToolBar_Realize (byval self as wxToolBar ptr) as integer
declare sub wxToolBar_EnableTool (byval self as wxToolBar ptr, byval toolid as integer, byval enable as integer)
declare sub wxToolBar_ToggleTool (byval self as wxToolBar ptr, byval toolid as integer, byval toggle as integer)
declare function wxToolBar_GetToolClientData (byval self as wxToolBar ptr, byval toolid as integer) as wxObject ptr
declare sub wxToolBar_SetToolClientData (byval self as wxToolBar ptr, byval toolid as integer, byval clientData as wxObject ptr)
declare function wxToolBar_GetToolState (byval self as wxToolBar ptr, byval toolid as integer) as integer
declare function wxToolBar_GetToolEnabled (byval self as wxToolBar ptr, byval toolid as integer) as integer
declare sub wxToolBar_SetToolShortHelp (byval self as wxToolBar ptr, byval toolid as integer, byval helpString as zstring ptr)
declare function wxToolBar_GetToolShortHelp (byval self as wxToolBar ptr, byval toolid as integer) as wxString ptr
declare sub wxToolBar_SetToolLongHelp (byval self as wxToolBar ptr, byval toolid as integer, byval helpString as zstring ptr)
declare function wxToolBar_GetToolLongHelp (byval self as wxToolBar ptr, byval toolid as integer) as wxString ptr
declare sub wxToolBar_SetMargins (byval self as wxToolBar ptr, byval x as integer, byval y as integer)
declare sub wxToolBar_SetToolPacking (byval self as wxToolBar ptr, byval packing as integer)
declare sub wxToolBar_SetToolSeparation (byval self as wxToolBar ptr, byval separation as integer)
declare sub wxToolBar_GetToolMargins (byval self as wxToolBar ptr, byval size as wxSize ptr)
declare function wxToolBar_GetToolPacking (byval self as wxToolBar ptr) as integer
declare function wxToolBar_GetToolSeparation (byval self as wxToolBar ptr) as integer
declare sub wxToolBar_SetRows (byval self as wxToolBar ptr, byval nRows as integer)
declare sub wxToolBar_SetMaxRowsCols (byval self as wxToolBar ptr, byval rows as integer, byval cols as integer)
declare function wxToolBar_GetMaxRows (byval self as wxToolBar ptr) as integer
declare function wxToolBar_GetMaxCols (byval self as wxToolBar ptr) as integer
declare sub wxToolBar_SetToolBitmapSize (byval self as wxToolBar ptr, byval size as wxSize ptr)
declare sub wxToolBar_GetToolBitmapSize (byval self as wxToolBar ptr, byval size as wxSize ptr)
declare sub wxToolBar_GetToolSize (byval self as wxToolBar ptr, byval size as wxSize ptr)
declare function wxToolBar_FindToolForPosition (byval self as wxToolBar ptr, byval x as wxCoord, byval y as wxCoord) as wxToolBarToolBase ptr
declare function wxToolBar_IsVertical (byval self as wxToolBar ptr) as integer
declare function wxToolBar_AddTool3 (byval self as wxToolBar ptr, byval toolid as integer, byval bitmap as wxBitmap ptr, byval bmpDisabled as wxBitmap ptr, byval toggle as integer, byval clientData as wxObject ptr, byval shortHelpString as zstring ptr, byval longHelpString as zstring ptr) as wxToolBarToolBase ptr
declare function wxToolBar_AddTool4 (byval self as wxToolBar ptr, byval toolid as integer, byval bitmap as wxBitmap ptr, byval shortHelpString as zstring ptr, byval longHelpString as zstring ptr) as wxToolBarToolBase ptr
declare function wxToolBar_AddTool5 (byval self as wxToolBar ptr, byval toolid as integer, byval bitmap as wxBitmap ptr, byval bmpDisabled as wxBitmap ptr, byval toggle as integer, byval xPos as wxCoord, byval yPos as wxCoord, byval clientData as wxObject ptr, byval shortHelp as zstring ptr, byval longHelp as zstring ptr) as wxToolBarToolBase ptr
declare function wxToolBar_InsertTool (byval self as wxToolBar ptr, byval pos as integer, byval toolid as integer, byval bitmap as wxBitmap ptr, byval bmpDisabled as wxBitmap ptr, byval toggle as integer, byval clientData as wxObject ptr, byval shortHelp as zstring ptr, byval longHelp as zstring ptr) as wxToolBarToolBase ptr
declare sub wxToolBar_GetMargins (byval self as wxToolBar ptr, byval size as wxSize ptr)
declare function wxToolBar_GetToolsCount (byval self as wxToolBar ptr) as integer
declare function wxToolBar_AcceptsFocus (byval self as wxToolBar ptr) as integer

#endif
