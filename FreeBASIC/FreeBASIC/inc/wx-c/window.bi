''
''
'' window -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_window_bi__
#define __wxc_window_bi__

#include once "wx.bi"


declare function wxWindow_EVT_TRANSFERDATAFROMWINDOW () as integer
declare function wxWindow alias "wxWindow_ctor" (byval parent as wxWindow ptr, byval id as wxWindowID, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval name as wxChar ptr) as wxWindow ptr
declare function wxWindow_Close (byval self as wxWindow ptr, byval force as integer) as integer
declare sub wxWindow_GetClientSize (byval self as wxWindow ptr, byval size as wxSize ptr)
declare sub wxWindow_SetSize (byval self as wxWindow ptr, byval x as integer, byval y as integer, byval width as integer, byval height as integer, byval flags as integer)
declare sub wxWindow_SetSize2 (byval self as wxWindow ptr, byval width as integer, byval height as integer)
declare sub wxWindow_SetSize3 (byval self as wxWindow ptr, byval size as wxSize ptr)
declare sub wxWindow_Move (byval self as wxWindow ptr, byval x as integer, byval y as integer, byval flags as integer)
declare function wxWindow_Show (byval self as wxWindow ptr, byval show as integer) as integer
declare sub wxWindow_GetBestSize (byval self as wxWindow ptr, byval size as wxSize ptr)
declare function wxWindow_GetId (byval self as wxWindow ptr) as integer
declare sub wxWindow_SetId (byval self as wxWindow ptr, byval id as integer)
declare function wxWindow_GetWindowStyleFlag (byval self as wxWindow ptr) as integer
declare sub wxWindow_Layout (byval self as wxWindow ptr)
declare sub wxWindow_SetAutoLayout (byval self as wxWindow ptr, byval autoLayout as integer)
declare sub wxWindow_SetBackgroundColour (byval self as wxWindow ptr, byval colour as wxColour ptr)
declare sub wxWindow_SetForegroundColour (byval self as wxWindow ptr, byval colour as wxColour ptr)
declare sub wxWindow_SetCursor (byval self as wxWindow ptr, byval cursor as wxCursor ptr)
declare sub wxWindow_SetSizer (byval self as wxWindow ptr, byval sizer as wxSizer ptr, byval deleteOld as integer)
declare sub wxWindow_SetWindowStyleFlag (byval self as wxWindow ptr, byval style as integer)
declare function wxWindow_SetFont (byval self as wxWindow ptr, byval font as wxFont ptr) as integer
declare function wxWindow_GetFont (byval self as wxWindow ptr) as wxFont ptr
declare sub wxWindow_SetToolTip (byval self as wxWindow ptr, byval tip as zstring ptr)
declare function wxWindow_Enable (byval self as wxWindow ptr, byval enable as integer) as integer
declare function wxWindow_IsEnabled (byval self as wxWindow ptr) as integer
declare function wxWindow_Destroy (byval self as wxWindow ptr) as integer
declare function wxWindow_DestroyChildren (byval self as wxWindow ptr) as integer
declare sub wxWindow_SetTitle (byval self as wxWindow ptr, byval title as zstring ptr)
declare function wxWindow_GetTitle (byval self as wxWindow ptr) as wxString ptr
declare sub wxWindow_SetName (byval self as wxWindow ptr, byval name as zstring ptr)
declare function wxWindow_GetName cdecl alias "wxWindow_GetName" (byval self as wxWindow ptr) as wxString ptr
declare function wxWindow_NewControlId () as integer
declare function wxWindow_NextControlId (byval id as integer) as integer
declare function wxWindow_PrevControlId (byval id as integer) as integer
declare sub wxWindow_Raise (byval self as wxWindow ptr)
declare sub wxWindow_Lower (byval self as wxWindow ptr)
declare sub wxWindow_SetClientSize (byval self as wxWindow ptr, byval width as integer, byval height as integer)
declare sub wxWindow_GetPosition (byval self as wxWindow ptr, byval point as wxPoint ptr)
declare sub wxWindow_GetSize (byval self as wxWindow ptr, byval size as wxSize ptr)
declare sub wxWindow_GetRect (byval self as wxWindow ptr, byval rect as wxRect ptr)
declare sub wxWindow_GetClientAreaOrigin (byval self as wxWindow ptr, byval point as wxPoint ptr)
declare sub wxWindow_GetClientRect (byval self as wxWindow ptr, byval rect as wxRect ptr)
declare sub wxWindow_GetAdjustedBestSize (byval self as wxWindow ptr, byval size as wxSize ptr)
declare sub wxWindow_Center (byval self as wxWindow ptr, byval direction as integer)
declare sub wxWindow_CenterOnScreen (byval self as wxWindow ptr, byval dir as integer)
declare sub wxWindow_CenterOnParent (byval self as wxWindow ptr, byval dir as integer)
declare sub wxWindow_Fit (byval self as wxWindow ptr)
declare sub wxWindow_FitInside (byval self as wxWindow ptr)
declare sub wxWindow_SetSizeHints (byval self as wxWindow ptr, byval minW as integer, byval minH as integer, byval maxW as integer, byval maxH as integer, byval incW as integer, byval incH as integer)
declare sub wxWindow_SetVirtualSizeHints (byval self as wxWindow ptr, byval minW as integer, byval minH as integer, byval maxW as integer, byval maxH as integer)
declare function wxWindow_GetMinWidth (byval self as wxWindow ptr) as integer
declare function wxWindow_GetMinHeight (byval self as wxWindow ptr) as integer
declare function wxWindow_GetMaxWidth (byval self as wxWindow ptr) as integer
declare function wxWindow_GetMaxHeight (byval self as wxWindow ptr) as integer
declare sub wxWindow_GetMaxSize (byval self as wxWindow ptr, byval size as wxSize ptr)
declare sub wxWindow_SetVirtualSize (byval self as wxWindow ptr, byval size as wxSize ptr)
declare sub wxWindow_GetVirtualSize (byval self as wxWindow ptr, byval size as wxSize ptr)
declare sub wxWindow_GetBestVirtualSize (byval self as wxWindow ptr, byval size as wxSize ptr)
declare function wxWindow_Hide (byval self as wxWindow ptr) as integer
declare function wxWindow_Disable (byval self as wxWindow ptr) as integer
declare function wxWindow_IsShown (byval self as wxWindow ptr) as integer
declare sub wxWindow_SetWindowStyle (byval self as wxWindow ptr, byval style as integer)
declare function wxWindow_GetWindowStyle (byval self as wxWindow ptr) as integer
declare function wxWindow_HasFlag (byval self as wxWindow ptr, byval flag as integer) as integer
declare function wxWindow_IsRetained (byval self as wxWindow ptr) as integer
declare sub wxWindow_SetExtraStyle (byval self as wxWindow ptr, byval exStyle as integer)
declare function wxWindow_GetExtraStyle (byval self as wxWindow ptr) as integer
declare sub wxWindow_MakeModal (byval self as wxWindow ptr, byval modal as integer)
declare sub wxWindow_SetThemeEnabled (byval self as wxWindow ptr, byval enableTheme as integer)
declare function wxWindow_GetThemeEnabled (byval self as wxWindow ptr) as integer
declare sub wxWindow_SetFocus (byval self as wxWindow ptr)
declare sub wxWindow_SetFocusFromKbd (byval self as wxWindow ptr)
declare function wxWindow_FindFocus () as wxWindow ptr
declare function wxWindow_AcceptsFocus (byval self as wxWindow ptr) as integer
declare function wxWindow_AcceptsFocusFromKeyboard (byval self as wxWindow ptr) as integer
declare function wxWindow_GetDefaultItem (byval self as wxWindow ptr) as wxWindow ptr
declare function wxWindow_SetDefaultItem (byval self as wxWindow ptr, byval child as wxWindow ptr) as wxWindow ptr
declare sub wxWindow_SetTmpDefaultItem (byval self as wxWindow ptr, byval win as wxWindow ptr)
declare function wxWindow_GetParent (byval self as wxWindow ptr) as wxWindow ptr
declare function wxWindow_GetGrandParent (byval self as wxWindow ptr) as wxWindow ptr
declare function wxWindow_IsTopLevel (byval self as wxWindow ptr) as integer
declare sub wxWindow_SetParent (byval self as wxWindow ptr, byval parent as wxWindow ptr)
declare function wxWindow_Reparent (byval self as wxWindow ptr, byval newParent as wxWindow ptr) as integer
declare sub wxWindow_AddChild (byval self as wxWindow ptr, byval child as wxWindow ptr)
declare sub wxWindow_RemoveChild (byval self as wxWindow ptr, byval child as wxWindow ptr)
declare function wxWindow_FindWindowId (byval self as wxWindow ptr, byval id as integer) as wxWindow ptr
declare function wxWindow_FindWindowName (byval self as wxWindow ptr, byval name as zstring ptr) as wxWindow ptr
declare function wxWindow_FindWindowById (byval id as integer, byval parent as wxWindow ptr) as wxWindow ptr
declare function wxWindow_FindWindowByName (byval name as zstring ptr, byval parent as wxWindow ptr) as wxWindow ptr
declare function wxWindow_FindWindowByLabel (byval label as zstring ptr, byval parent as wxWindow ptr) as wxWindow ptr
declare function wxWindow_GetEventHandler (byval self as wxWindow ptr) as wxEvtHandler ptr
declare sub wxWindow_SetEventHandler (byval self as wxWindow ptr, byval handler as wxEvtHandler ptr)
declare sub wxWindow_PushEventHandler (byval self as wxWindow ptr, byval handler as wxEvtHandler ptr)
declare function wxWindow_PopEventHandler (byval self as wxWindow ptr, byval deleteHandler as integer) as wxEvtHandler ptr
declare function wxWindow_RemoveEventHandler (byval self as wxWindow ptr, byval handler as wxEvtHandler ptr) as integer
declare sub wxWindow_SetValidator (byval self as wxWindow ptr, byval validator as wxValidator ptr)
declare function wxWindow_GetValidator (byval self as wxWindow ptr) as wxValidator ptr
declare function wxWindow_Validate (byval self as wxWindow ptr) as integer
declare function wxWindow_TransferDataToWindow (byval self as wxWindow ptr) as integer
declare function wxWindow_TransferDataFromWindow (byval self as wxWindow ptr) as integer
declare sub wxWindow_InitDialog (byval self as wxWindow ptr)
declare sub wxWindow_SetAcceleratorTable (byval self as wxWindow ptr, byval accel as wxAcceleratorTable ptr)
declare function wxWindow_GetAcceleratorTable (byval self as wxWindow ptr) as wxAcceleratorTable ptr
declare sub wxWindow_ConvertPixelsToDialogPoint (byval self as wxWindow ptr, byval pt as wxPoint ptr, byval point as wxPoint ptr)
declare sub wxWindow_ConvertDialogToPixelsPoint (byval self as wxWindow ptr, byval pt as wxPoint ptr, byval point as wxPoint ptr)
declare sub wxWindow_ConvertPixelsToDialogSize (byval self as wxWindow ptr, byval sz as wxSize ptr, byval size as wxSize ptr)
declare sub wxWindow_ConvertDialogToPixelsSize (byval self as wxWindow ptr, byval sz as wxSize ptr, byval size as wxSize ptr)
declare sub wxWindow_WarpPointer (byval self as wxWindow ptr, byval x as integer, byval y as integer)
declare sub wxWindow_CaptureMouse (byval self as wxWindow ptr)
declare sub wxWindow_ReleaseMouse (byval self as wxWindow ptr)
declare function wxWindow_GetCapture () as wxWindow ptr
declare function wxWindow_HasCapture (byval self as wxWindow ptr) as integer
declare sub wxWindow_Refresh (byval self as wxWindow ptr, byval eraseBackground as integer, byval rect as wxRect ptr)
declare sub wxWindow_RefreshRect (byval self as wxWindow ptr, byval rect as wxRect ptr)
declare sub wxWindow_Update (byval self as wxWindow ptr)
declare sub wxWindow_ClearBackground (byval self as wxWindow ptr)
declare sub wxWindow_Freeze (byval self as wxWindow ptr)
declare sub wxWindow_Thaw (byval self as wxWindow ptr)
declare sub wxWindow_PrepareDC (byval self as wxWindow ptr, byval dc as wxDC ptr)
declare function wxWindow_IsExposed (byval self as wxWindow ptr, byval x as integer, byval y as integer, byval w as integer, byval h as integer) as integer
declare function wxWindow_GetBackgroundColour (byval self as wxWindow ptr) as wxColour ptr
declare function wxWindow_GetForegroundColour (byval self as wxWindow ptr) as wxColour ptr
declare sub wxWindow_SetCaret (byval self as wxWindow ptr, byval caret as wxCaret ptr)
declare function wxWindow_GetCaret (byval self as wxWindow ptr) as wxCaret ptr
declare function wxWindow_GetCharHeight (byval self as wxWindow ptr) as integer
declare function wxWindow_GetCharWidth (byval self as wxWindow ptr) as integer
declare sub wxWindow_GetTextExtent (byval self as wxWindow ptr, byval string as zstring ptr, byval x as integer ptr, byval y as integer ptr, byval descent as integer ptr, byval externalLeading as integer ptr, byval theFont as wxFont ptr)
declare sub wxWindow_ClientToScreen (byval self as wxWindow ptr, byval pt as wxPoint ptr, byval point as wxPoint ptr)
declare sub wxWindow_ScreenToClient (byval self as wxWindow ptr, byval pt as wxPoint ptr, byval point as wxPoint ptr)
declare sub wxWindow_HitTest (byval self as wxWindow ptr, byval pt as wxPoint ptr, byval hittest as wxHitTest ptr)
declare function wxWindow_GetBorder (byval self as wxWindow ptr) as wxBorder
declare function wxWindow_GetBorderByFlags (byval self as wxWindow ptr, byval flags as integer) as wxBorder
declare sub wxWindow_UpdateWindowUI (byval self as wxWindow ptr)
declare function wxWindow_PopupMenu (byval self as wxWindow ptr, byval menu as wxMenu ptr, byval pos as wxPoint ptr) as integer
declare function wxWindow_HasScrollbar (byval self as wxWindow ptr, byval orient as integer) as integer
declare sub wxWindow_SetScrollbar (byval self as wxWindow ptr, byval orient as integer, byval pos as integer, byval thumbvisible as integer, byval range as integer, byval refresh as integer)
declare sub wxWindow_SetScrollPos (byval self as wxWindow ptr, byval orient as integer, byval pos as integer, byval refresh as integer)
declare function wxWindow_GetScrollPos (byval self as wxWindow ptr, byval orient as integer) as integer
declare function wxWindow_GetScrollThumb (byval self as wxWindow ptr, byval orient as integer) as integer
declare function wxWindow_GetScrollRange (byval self as wxWindow ptr, byval orient as integer) as integer
declare sub wxWindow_ScrollWindow (byval self as wxWindow ptr, byval dx as integer, byval dy as integer, byval rect as wxRect ptr)
declare function wxWindow_ScrollLines (byval self as wxWindow ptr, byval lines as integer) as integer
declare function wxWindow_ScrollPages (byval self as wxWindow ptr, byval pages as integer) as integer
declare function wxWindow_LineUp (byval self as wxWindow ptr) as integer
declare function wxWindow_LineDown (byval self as wxWindow ptr) as integer
declare function wxWindow_PageUp (byval self as wxWindow ptr) as integer
declare function wxWindow_PageDown (byval self as wxWindow ptr) as integer
declare sub wxWindow_SetHelpText (byval self as wxWindow ptr, byval text as zstring ptr)
declare sub wxWindow_SetHelpTextForId (byval self as wxWindow ptr, byval text as zstring ptr)
declare function wxWindow_GetHelpText (byval self as wxWindow ptr) as wxString ptr
declare function wxWindow_GetToolTip (byval self as wxWindow ptr) as wxToolTip ptr
declare function wxWindow_GetAncestorWithCustomPalette (byval self as wxWindow ptr) as wxWindow ptr
declare sub wxWindow_SetDropTarget (byval self as wxWindow ptr, byval dropTarget as wxDropTarget ptr)
declare function wxWindow_GetDropTarget (byval self as wxWindow ptr) as wxDropTarget ptr
declare sub wxWindow_SetConstraints (byval self as wxWindow ptr, byval constraints as wxLayoutConstraints ptr)
declare function wxWindow_GetConstraints (byval self as wxWindow ptr) as wxLayoutConstraints ptr
declare function wxWindow_GetAutoLayout (byval self as wxWindow ptr) as integer
declare sub wxWindow_SetSizerAndFit (byval self as wxWindow ptr, byval sizer as wxSizer ptr, byval deleteOld as integer)
declare function wxWindow_GetSizer (byval self as wxWindow ptr) as wxSizer ptr
declare sub wxWindow_SetContainingSizer (byval self as wxWindow ptr, byval sizer as wxSizer ptr)
declare function wxWindow_GetContainingSizer (byval self as wxWindow ptr) as wxSizer ptr
declare function wxWindow_GetPalette (byval self as wxWindow ptr) as wxPalette ptr
declare sub wxWindow_SetPalette (byval self as wxWindow ptr, byval pal as wxPalette ptr)
declare function wxWindow_HasCustomPalette (byval self as wxWindow ptr) as integer
declare function wxWindow_GetUpdateRegion (byval self as wxWindow ptr) as wxRegion ptr
declare sub wxWindow_SetWindowVariant (byval self as wxWindow ptr, byval variant as wxWindowVariant)
declare function wxWindow_GetWindowVariant (byval self as wxWindow ptr) as wxWindowVariant
declare function wxWindow_IsBeingDeleted (byval self as wxWindow ptr) as integer
declare sub wxWindow_InvalidateBestSize (byval self as wxWindow ptr)
declare sub wxWindow_CacheBestSize (byval self as wxWindow ptr, byval size as wxSize ptr)
declare sub wxWindow_GetBestFittingSize (byval self as wxWindow ptr, byval size as wxSize ptr)
declare sub wxWindow_SetBestFittingSize (byval self as wxWindow ptr, byval size as wxSize ptr)
declare function wxWindow_GetChildren (byval self as wxWindow ptr, byval num as integer) as wxWindow ptr
declare function wxWindow_GetChildrenCount (byval self as wxWindow ptr) as integer
declare function wxWindow_GetDefaultAttributes (byval self as wxWindow ptr) as wxVisualAttributes ptr
declare function wxWindow_GetClassDefaultAttributes (byval variant as wxWindowVariant) as wxVisualAttributes ptr
declare sub wxWindow_SetBackgroundStyle (byval self as wxWindow ptr, byval style as wxBackgroundStyle)
declare function wxWindow_GetBackgroundStyle (byval self as wxWindow ptr) as wxBackgroundStyle
declare sub wxWindow_InheritAttributes (byval self as wxWindow ptr)
declare function wxWindow_ShouldInheritColours (byval self as wxWindow ptr) as integer



declare function wxVisualAttributes alias "wxVisualAttributes_ctor" () as wxVisualAttributes ptr
declare sub wxVisualAttributes_dtor (byval self as wxVisualAttributes ptr)
declare sub wxVisualAttributes_RegisterDisposable (byval self as _VisualAttributes ptr, byval onDispose as Virtual_Dispose)
declare sub wxVisualAttributes_SetFont (byval self as wxVisualAttributes ptr, byval font as wxFont ptr)
declare function wxVisualAttributes_GetFont (byval self as wxVisualAttributes ptr) as wxFont ptr
declare sub wxVisualAttributes_SetColourFg (byval self as wxVisualAttributes ptr, byval colour as wxColour ptr)
declare function wxVisualAttributes_GetColourFg (byval self as wxVisualAttributes ptr) as wxColour ptr
declare sub wxVisualAttributes_SetColourBg (byval self as wxVisualAttributes ptr, byval colour as wxColour ptr)
declare function wxVisualAttributes_GetColourBg (byval self as wxVisualAttributes ptr) as wxColour ptr

#endif
