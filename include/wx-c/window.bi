#Ifndef __window_bi__
#Define __window_bi__

#Include Once "common.bi"

Type Virtual_Validator As Function WXCALL As wxBool


' class wxVisualAttributes
Declare Function wxVisualAttributes_ctor WXCALL Alias "wxVisualAttributes_ctor" () As wxVisualAttributes Ptr
Declare Sub wxVisualAttributes_dtor WXCALL Alias "wxVisualAttributes_dtor" (self As wxVisualAttributes Ptr)
Declare Sub wxVisualAttributes_RegisterDisposable WXCALL Alias "wxVisualAttributes_RegisterDisposable" (self As wxVisualAttributes Ptr, on_dispose As Virtual_Dispose)
Declare Sub wxVisualAttributes_SetFont WXCALL Alias "wxVisualAttributes_SetFont" (self As wxVisualAttributes Ptr, font As wxFont Ptr)
Declare Function wxVisualAttributes_GetFont WXCALL Alias "wxVisualAttributes_GetFont" (self As wxVisualAttributes Ptr) As wxFont Ptr
Declare Sub wxVisualAttributes_SetColourFg WXCALL Alias "wxVisualAttributes_SetColourFg" (self As wxVisualAttributes Ptr, col As wxColour Ptr)
Declare Function wxVisualAttributes_GetColourFg WXCALL Alias "wxVisualAttributes_GetColourFg" (self As wxVisualAttributes Ptr) As wxColour Ptr
Declare Sub wxVisualAttributes_SetColourBg WXCALL Alias "wxVisualAttributes_SetColourBg" (self As wxVisualAttributes Ptr, col As wxColour Ptr)
Declare Function wxVisualAttributes_GetColourBg WXCALL Alias "wxVisualAttributes_GetColourBg" (self As wxVisualAttributes Ptr) As wxColour Ptr

' class wxWindow
Declare Function wxWindow_ctor WXCALL Alias "wxWindow_ctor" (parent  As wxWindow Ptr = WX_NULL, _
                   id      As  wxWindowID = -1, _
                   x       As  wxInt = -1, _
                   y       As  wxInt = -1, _
                   w       As  wxInt = -1, _
                   h       As  wxInt = -1, _
                   style   As  wxUInt = 0, _
                   nameArg As wxString Ptr = WX_NULL) As wxWindow Ptr
Declare Sub wxWindow_RegisterValidator WXCALL Alias "wxWindow_RegisterValidator" (self As wxWindow Ptr, validator As Virtual_Validator)
Declare Function wxWindow_GetId WXCALL Alias "wxWindow_GetId" (self As wxWindow Ptr) As wxInt
Declare Sub wxWindow_SetId WXCALL Alias "wxWindow_SetId" (self As wxWindow Ptr, id As wxInt)
Declare Sub wxWindow_SetWindowStyle WXCALL Alias "wxWindow_SetWindowStyle" (self As wxWindow Ptr, style As wxInt)
Declare Function wxWindow_GetWindowStyle WXCALL Alias "wxWindow_GetWindowStyle" (self As wxWindow Ptr) As wxInt
Declare Sub wxWindow_SetCursor WXCALL Alias "wxWindow_SetCursor" (self As wxWindow Ptr, cur As wxCursor Ptr)
Declare Function wxWindow_GetCursor WXCALL Alias "wxWindow_GetCursor" (self As wxWindow Ptr) As wxCursor Ptr
Declare Sub wxWindow_SetVirtualSize WXCALL Alias "wxWindow_SetVirtualSize" (self As wxWindow Ptr, w As wxInt, h As wxInt)
Declare Sub wxWindow_GetVirtualSize WXCALL Alias "wxWindow_GetVirtualSize" (self As wxWindow Ptr, size As wxSize Ptr)
Declare Sub wxWindow_SetMinSize WXCALL Alias "wxWindow_SetMinSize" (self As wxWindow Ptr, w As wxInt, h As wxInt)
Declare Function wxWindow_GetMinWidth WXCALL Alias "wxWindow_GetMinWidth" (self As wxWindow Ptr) As wxInt
Declare Function wxWindow_GetMinHeight WXCALL Alias "wxWindow_GetMinHeight" (self As wxWindow Ptr) As wxInt
Declare Sub wxWindow_SetMaxSize WXCALL Alias "wxWindow_SetMaxSize" (self As wxWindow Ptr, w As wxInt, h As wxInt)
Declare Function wxWindow_GetMaxWidth WXCALL Alias "wxWindow_GetMaxWidth" (self As wxWindow Ptr) As wxInt
Declare Function wxWindow_GetMaxHeight WXCALL Alias "wxWindow_GetMaxHeight" (self As wxWindow Ptr) As wxInt
Declare Sub wxWindow_GetMaxSize WXCALL Alias "wxWindow_GetMaxSize" (self As wxWindow Ptr, size As wxSize Ptr)
Declare Function wxWindow_SetFont WXCALL Alias "wxWindow_SetFont" (self As wxWindow Ptr, font As wxFont Ptr) As wxChar
Declare Function wxWindow_GetFont WXCALL Alias "wxWindow_GetFont" (self As wxWindow Ptr) As wxFont Ptr
Declare Sub wxWindow_SetToolTip WXCALL Alias "wxWindow_SetToolTip" (self As wxWindow Ptr, tip As wxString Ptr)
Declare Function wxWindow_GetToolTip WXCALL Alias "wxWindow_GetToolTip" (self As wxWindow Ptr) As wxString Ptr
Declare Function wxWindow_Enable WXCALL Alias "wxWindow_Enable" (self As wxWindow Ptr,enable As wxBool) As wxBool
Declare Function wxWindow_IsEnabled WXCALL Alias "wxWindow_IsEnabled" (self As wxWindow Ptr) As wxBool
Declare Function wxWindow_Disable WXCALL Alias "wxWindow_Disable" (self As wxWindow Ptr) As wxChar
Declare Sub wxWindow_SetThemeEnabled WXCALL Alias "wxWindow_SetThemeEnabled" (self As wxWindow Ptr, enableTheme As wxBool)
Declare Function wxWindow_GetThemeEnabled WXCALL Alias "wxWindow_GetThemeEnabled" (self As wxWindow Ptr) As wxChar
Declare Sub wxWindow_SetTitle WXCALL Alias "wxWindow_SetTitle" (self As wxWindow Ptr, title As wxString Ptr)
Declare Function wxWindow_GetTitle WXCALL Alias "wxWindow_GetTitle" (self As wxWindow Ptr) As wxString Ptr
Declare Sub wxWindow_SetLabel WXCALL Alias "wxWindow_SetLabel" (self As wxWindow Ptr, title As wxString Ptr)
Declare Function wxWindow_GetLabel WXCALL Alias "wxWindow_GetLabel" (self As wxWindow Ptr) As wxString Ptr
Declare Sub wxWindow_SetName WXCALL Alias "wxWindow_SetName" (self As wxWindow Ptr, nam As wxString Ptr)
Declare Function wxWindow_GetName WXCALL Alias "wxWindow_GetName" (self As wxWindow Ptr) As wxString Ptr
Declare Function wxWindow_SetDefaultItem WXCALL Alias "wxWindow_SetDefaultItem" (self As wxWindow Ptr, child As wxWindow Ptr) As wxWindow Ptr
Declare Function wxWindow_GetDefaultItem WXCALL Alias "wxWindow_GetDefaultItem" (self As wxWindow Ptr) As wxWindow Ptr
Declare Sub wxWindow_SetParent WXCALL Alias "wxWindow_SetParent" (self As wxWindow Ptr, parent As wxWindow Ptr)
Declare Function wxWindow_GetParent WXCALL Alias "wxWindow_GetParent" (self As wxWindow Ptr) As wxWindow Ptr
Declare Sub wxWindow_SetEventHandler WXCALL Alias "wxWindow_SetEventHandler" (self As wxWindow Ptr, handler As wxEventHandler Ptr)
Declare Function wxWindow_GetEventHandler WXCALL Alias "wxWindow_GetEventHandler" (self As wxWindow Ptr) As wxEventHandler Ptr
Declare Sub wxWindow_SetValidator WXCALL Alias "wxWindow_SetValidator" (self As wxWindow Ptr, validator As wxValidator Ptr)
Declare Function wxWindow_GetValidator WXCALL Alias "wxWindow_GetValidator" (self As wxWindow Ptr) As wxValidator Ptr
Declare Sub wxWindow_SetAcceleratorTable WXCALL Alias "wxWindow_SetAcceleratorTable" (self As wxWindow Ptr, accel As wxAcceleratorTable Ptr)
Declare Function wxWindow_GetAcceleratorTable WXCALL Alias "wxWindow_GetAcceleratorTable" (self As wxWindow Ptr) As wxAcceleratorTable Ptr
Declare Sub wxWindow_SetScrollPos WXCALL Alias "wxWindow_SetScrollPos" (self As wxWindow Ptr, orient As wxInt, po As wxInt, refresh As wxBool)
Declare Function wxWindow_GetScrollPos WXCALL Alias "wxWindow_GetScrollPos" (self As wxWindow Ptr, orient As wxInt)  As wxInt
Declare Sub wxWindow_SetHelpText WXCALL Alias "wxWindow_SetHelpText" (self As wxWindow Ptr, txt As wxString Ptr)
Declare Function wxWindow_GetHelpText WXCALL Alias "wxWindow_GetHelpText" (self As wxWindow Ptr) As wxString Ptr
Declare Sub wxWindow_SetDropTarget WXCALL Alias "wxWindow_SetDropTarget" (self As wxWindow Ptr, dropTarget As wxDropTarget Ptr)
Declare Function wxWindow_GetDropTarget WXCALL Alias "wxWindow_GetDropTarget" (self As wxWindow Ptr) As wxDropTarget Ptr
Declare Sub wxWindow_SetConstraints WXCALL Alias "wxWindow_SetConstraints" (self As wxWindow Ptr, constraints As wxLayoutConstraints Ptr)
Declare Function wxWindow_GetConstraints WXCALL Alias "wxWindow_GetConstraints" (self As wxWindow Ptr) As wxLayoutConstraints Ptr
Declare Sub wxWindow_SetContainingSizer WXCALL Alias "wxWindow_SetContainingSizer" (self As wxWindow Ptr, sizer As wxSizer Ptr)
Declare Function wxWindow_GetContainingSizer WXCALL Alias "wxWindow_GetContainingSizer" (self As wxWindow Ptr) As wxSizer Ptr
Declare Sub wxWindow_SetPalette WXCALL Alias "wxWindow_SetPalette" (self As wxWindow Ptr, pal As wxPalette Ptr)
Declare Function wxWindow_GetPalette WXCALL Alias "wxWindow_GetPalette" (self As wxWindow Ptr) As wxPalette Ptr
Declare Sub wxWindow_SetWindowVariant WXCALL Alias "wxWindow_SetWindowVariant" (self As wxWindow Ptr, variant As wxWindowVariant)
Declare Function wxWindow_GetWindowVariant WXCALL Alias "wxWindow_GetWindowVariant" (self As wxWindow Ptr) As wxWindowVariant
Declare Sub wxWindow_SetBackgroundStyle WXCALL Alias "wxWindow_SetBackgroundStyle" (self As wxWindow Ptr, style As wxInt)
Declare Function wxWindow_GetBackgroundStyle WXCALL Alias "wxWindow_GetBackgroundStyle" (self As wxWindow Ptr) As wxInt
Declare Sub wxWindow_SetCaret WXCALL Alias "wxWindow_SetCaret" (self As wxWindow Ptr, caret As wxCaret Ptr)
Declare Function wxWindow_GetCaret WXCALL Alias "wxWindow_GetCaret" (self As wxWindow Ptr) As wxCaret Ptr
Declare Sub wxWindow_SetBackgroundColour WXCALL Alias "wxWindow_SetBackgroundColour" (self As wxWindow Ptr, col As wxColour Ptr)
Declare Function wxWindow_GetBackgroundColour WXCALL Alias "wxWindow_GetBackgroundColour" (self As wxWindow Ptr) As wxColour Ptr
Declare Sub wxWindow_SetForegroundColour WXCALL Alias "wxWindow_SetForegroundColour" (self As wxWindow Ptr, col As wxColour Ptr)
Declare Function wxWindow_GetForegroundColour WXCALL Alias "wxWindow_GetForegroundColour" (self As wxWindow Ptr) As wxColour Ptr
Declare Function wxWindow_Close WXCALL Alias "wxWindow_Close" (self As wxWindow Ptr, force As wxBool) As wxChar
Declare Sub wxWindow_GetClientSize WXCALL Alias "wxWindow_GetClientSize" (self As wxWindow Ptr, size As wxSize Ptr)
Declare Sub wxWindow_SetSize WXCALL Alias "wxWindow_SetSize" (self As wxWindow Ptr, x As wxInt, y As wxInt, w As wxInt, h As wxInt, flags As wxInt)
Declare Sub wxWindow_SetSize2 WXCALL Alias "wxWindow_SetSize2" (self As wxWindow Ptr, w As wxInt, h As wxInt)
Declare Sub wxWindow_SetSize3 WXCALL Alias "wxWindow_SetSize3" (self As wxWindow Ptr, size As wxSize Ptr)
Declare Sub wxWindow_Move WXCALL Alias "wxWindow_Move" (self As wxWindow Ptr, x As wxInt, y As wxInt, flags As wxInt)
Declare Function wxWindow_Show WXCALL Alias "wxWindow_Show" (self As wxWindow Ptr, show As wxBool=WX_TRUE) As wxChar
Declare Sub wxWindow_GetBestSize WXCALL Alias "wxWindow_GetBestSize" (self As wxWindow Ptr, size As wxSize Ptr)
Declare Function wxWindow_GetWindowStyleFlag WXCALL Alias "wxWindow_GetWindowStyleFlag" (self As wxWindow Ptr) As wxInt
Declare Sub wxWindow_Layout WXCALL Alias "wxWindow_Layout" (self As wxWindow Ptr)
Declare Sub wxWindow_SetAutoLayout WXCALL Alias "wxWindow_SetAutoLayout" (self As wxWindow Ptr, autoLayout As wxBool)
Declare Sub wxWindow_SetSizer WXCALL Alias "wxWindow_SetSizer" (self As wxWindow Ptr, sizer As wxSizer Ptr, deleteOld As wxBool)
Declare Sub wxWindow_SetWindowStyleFlag WXCALL Alias "wxWindow_SetWindowStyleFlag" (self As wxWindow Ptr, style As wxUint)
Declare Function wxWindow_Destroy WXCALL Alias "wxWindow_Destroy" (self As wxWindow Ptr) As wxChar
Declare Function wxWindow_DestroyChildren WXCALL Alias "wxWindow_DestroyChildren" (self As wxWindow Ptr) As wxChar
Declare Function wxWindow_NewControlId WXCALL Alias "wxWindow_NewControlId" () As wxInt
Declare Function wxWindow_NextControlId WXCALL Alias "wxWindow_NextControlId" (id As wxInt) As wxInt
Declare Function wxWindow_PrevControlId WXCALL Alias "wxWindow_PrevControlId" (id As wxInt) As wxInt
Declare Sub wxWindow_Raise WXCALL Alias "wxWindow_Raise" (self As wxWindow Ptr)
Declare Sub wxWindow_Lower WXCALL Alias "wxWindow_Lower" (self As wxWindow Ptr)
Declare Sub wxWindow_SetClientSize WXCALL Alias "wxWindow_SetClientSize" (self As wxWindow Ptr, w As wxInt, h As wxInt)
Declare Sub wxWindow_GetPosition WXCALL Alias "wxWindow_GetPosition" (self As wxWindow Ptr, po As wxPoint Ptr)
Declare Sub wxWindow_GetSize WXCALL Alias "wxWindow_GetSize" (self As wxWindow Ptr, size As wxSize Ptr)
Declare Sub wxWindow_GetRect WXCALL Alias "wxWindow_GetRect" (self As wxWindow Ptr, r As wxRect Ptr)
Declare Sub wxWindow_GetClientAreaOrigin WXCALL Alias "wxWindow_GetClientAreaOrigin" (self As wxWindow Ptr, p As wxPoint Ptr)
Declare Sub wxWindow_GetClientRect WXCALL Alias "wxWindow_GetClientRect" (self As wxWindow Ptr, r As wxRect Ptr)
Declare Sub wxWindow_GetAdjustedBestSize WXCALL Alias "wxWindow_GetAdjustedBestSize" (self As wxWindow Ptr, size As wxSize Ptr)
Declare Sub wxWindow_Center WXCALL Alias "wxWindow_Center" (self As wxWindow Ptr, direction As wxInt)
Declare Sub wxWindow_CenterOnScreen WXCALL Alias "wxWindow_CenterOnScreen" (self As wxWindow Ptr, d As wxInt)
Declare Sub wxWindow_CenterOnParent WXCALL Alias "wxWindow_CenterOnParent" (self As wxWindow Ptr, d As wxInt)
Declare Sub wxWindow_Fit WXCALL Alias "wxWindow_Fit" (self As wxWindow Ptr)
Declare Sub wxWindow_FitInside WXCALL Alias "wxWindow_FitInside" (self As wxWindow Ptr)
Declare Sub wxWindow_SetSizeHints WXCALL Alias "wxWindow_SetSizeHints" (self As wxWindow Ptr, minW As wxInt, minH As wxInt, maxW As wxInt, maxH As wxInt, incW As wxInt, incH As wxInt)
Declare Sub wxWindow_SetVirtualSizeHints WXCALL Alias "wxWindow_SetVirtualSizeHints" (self As wxWindow Ptr, minW As wxInt, minH As wxInt, maxW As wxInt, maxH As wxInt)
Declare Sub wxWindow_GetBestVirtualSize WXCALL Alias "wxWindow_GetBestVirtualSize" (self As wxWindow Ptr, size As wxSize Ptr)
Declare Function wxWindow_Hide WXCALL Alias "wxWindow_Hide" (self As wxWindow Ptr) As wxChar
Declare Function wxWindow_IsShown WXCALL Alias "wxWindow_IsShown" (self As wxWindow Ptr) As wxChar
Declare Function wxWindow_HasFlag WXCALL Alias "wxWindow_HasFlag" (self As wxWindow Ptr, flag As wxInt) As wxChar
Declare Function wxWindow_IsRetained WXCALL Alias "wxWindow_IsRetained" (self As wxWindow Ptr) As wxChar
Declare Function wxWindow_GetExtraStyle WXCALL Alias "wxWindow_GetExtraStyle" (self As wxWindow Ptr) As wxInt
Declare Sub wxWindow_MakeModal WXCALL Alias "wxWindow_MakeModal" (self As wxWindow Ptr, modal As wxBool)
Declare Sub wxWindow_SetFocus WXCALL Alias "wxWindow_SetFocus" (self As wxWindow Ptr)
Declare Sub wxWindow_SetFocusFromKbd WXCALL Alias "wxWindow_SetFocusFromKbd" (self As wxWindow Ptr)
Declare Function wxWindow_FindFocus WXCALL Alias "wxWindow_FindFocus" () As wxWindow Ptr
Declare Function wxWindow_AcceptsFocus WXCALL Alias "wxWindow_AcceptsFocus" (self As wxWindow Ptr) As wxChar
Declare Function wxWindow_AcceptsFocusFromKeyboard WXCALL Alias "wxWindow_AcceptsFocusFromKeyboard" (self As wxWindow Ptr) As wxChar
Declare Sub wxWindow_SetTmpDefaultItem WXCALL Alias "wxWindow_SetTmpDefaultItem" (self As wxWindow Ptr, win As wxWindow Ptr)
Declare Function wxWindow_GetGrandParent WXCALL Alias "wxWindow_GetGrandParent" (self As wxWindow Ptr) As wxWindow Ptr
Declare Function wxWindow_IsTopLevel WXCALL Alias "wxWindow_IsTopLevel" (self As wxWindow Ptr) As wxChar
Declare Function wxWindow_Reparent WXCALL Alias "wxWindow_Reparent" (self As wxWindow Ptr, newparent As wxWindow Ptr) As wxChar
Declare Sub wxWindow_AddChild WXCALL Alias "wxWindow_AddChild" (self As wxWindow Ptr, child As wxWindow Ptr)
Declare Sub wxWindow_RemoveChild WXCALL Alias "wxWindow_RemoveChild" (self As wxWindow Ptr, child As wxWindow Ptr)
Declare Function wxWindow_FindWindowId WXCALL Alias "wxWindow_FindWindowId" (self As wxWindow Ptr, id As wxInt) As wxWindow Ptr
Declare Function wxWindow_FindWindowName WXCALL Alias "wxWindow_FindWindowName" (self As wxWindow Ptr, nam As wxString Ptr)  As wxWindow Ptr
Declare Function wxWindow_FindWindowById WXCALL Alias "wxWindow_FindWindowById" (id As wxInt, parent As wxWindow Ptr) As wxWindow Ptr
Declare Function wxWindow_FindWindowByName WXCALL Alias "wxWindow_FindWindowByName" (nam As wxString Ptr, parent As wxWindow Ptr) As wxWindow Ptr
Declare Function wxWindow_FindWindowByLabel WXCALL Alias "wxWindow_FindWindowByLabel" (label As wxString Ptr, parent As wxWindow Ptr)  As wxWindow Ptr
Declare Sub wxWindow_PushEventHandler WXCALL Alias "wxWindow_PushEventHandler" (self As wxWindow Ptr, handler As wxEventHandler Ptr)
Declare Function wxWindow_PopEventHandler WXCALL Alias "wxWindow_PopEventHandler" (self As wxWindow Ptr, deleteHandler As wxBool) As wxEventHandler Ptr
Declare Function wxWindow_RemoveEventHandler WXCALL Alias "wxWindow_RemoveEventHandler" (self As wxWindow Ptr, handler As wxEventHandler Ptr) As wxChar
Declare Function wxWindow_Validate WXCALL Alias "wxWindow_Validate" (self As wxWindow Ptr) As wxChar
Declare Function wxWindow_TransferDataToWindow WXCALL Alias "wxWindow_TransferDataToWindow" (self As wxWindow Ptr) As wxChar
Declare Function wxWindow_TransferDataFromWindow WXCALL Alias "wxWindow_TransferDataFromWindow" (self As wxWindow Ptr) As wxChar
Declare Sub wxWindow_InitDialog WXCALL Alias "wxWindow_InitDialog" (self As wxWindow Ptr)
Declare Sub wxWindow_ConvertPixelsToDialogPoint WXCALL Alias "wxWindow_ConvertPixelsToDialogPoint" (self As wxWindow Ptr, p1 As wxPoint Ptr, p2 As wxPoint Ptr)
Declare Sub wxWindow_ConvertDialogToPixelsPoint WXCALL Alias "wxWindow_ConvertDialogToPixelsPoint" (self As wxWindow Ptr, p1 As wxPoint Ptr, p2 As wxPoint Ptr)
Declare Sub wxWindow_ConvertPixelsToDialogSize WXCALL Alias "wxWindow_ConvertPixelsToDialogSize" (self As wxWindow Ptr, s1 As wxSize Ptr, s2 As wxSize Ptr)
Declare Sub wxWindow_ConvertDialogToPixelsSize WXCALL Alias "wxWindow_ConvertDialogToPixelsSize" (self As wxWindow Ptr, s1 As wxSize Ptr, s2 As wxSize Ptr)
Declare Sub wxWindow_WarpPointer WXCALL Alias "wxWindow_WarpPointer" (self As wxWindow Ptr, x As wxInt, y As wxInt)
Declare Sub wxWindow_CaptureMouse WXCALL Alias "wxWindow_CaptureMouse" (self As wxWindow Ptr)
Declare Sub wxWindow_ReleaseMouse WXCALL Alias "wxWindow_ReleaseMouse" (self As wxWindow Ptr)
Declare Function wxWindow_GetCapture WXCALL Alias "wxWindow_GetCapture" () As wxWindow Ptr
Declare Function wxWindow_HasCapture WXCALL Alias "wxWindow_HasCapture" (self As wxWindow Ptr) As wxChar
Declare Sub wxWindow_Refresh WXCALL Alias "wxWindow_Refresh" (self As wxWindow Ptr, eraseBackground As wxBool, r As wxRect Ptr)
Declare Sub wxWindow_RefreshRect WXCALL Alias "wxWindow_RefreshRect" (self As wxWindow Ptr, r As wxRect Ptr)
Declare Sub wxWindow_Update WXCALL Alias "wxWindow_Update" (self As wxWindow Ptr)
Declare Sub wxWindow_ClearBackground WXCALL Alias "wxWindow_ClearBackground" (self As wxWindow Ptr)
Declare Sub wxWindow_Freeze WXCALL Alias "wxWindow_Freeze" (self As wxWindow Ptr)
Declare Sub wxWindow_Thaw WXCALL Alias "wxWindow_Thaw" (self As wxWindow Ptr)
Declare Sub wxWindow_PrepareDC WXCALL Alias "wxWindow_PrepareDC" (self As wxWindow Ptr, dc As wxDC Ptr)
Declare Function wxWindow_IsExposed WXCALL Alias "wxWindow_IsExposed" (self As wxWindow Ptr, x As wxInt, y As wxInt, w As wxInt, h As wxInt) As wxChar
Declare Function wxWindow_GetCharHeight WXCALL Alias "wxWindow_GetCharHeight" (self As wxWindow Ptr) As wxInt
Declare Function wxWindow_GetCharWidth WXCALL Alias "wxWindow_GetCharWidth" (self As wxWindow Ptr) As wxInt
Declare Sub wxWindow_GetTextExtent WXCALL Alias "wxWindow_GetTextExtent" (self As wxWindow Ptr, s As wxString Ptr, x As wxInt Ptr, y As wxInt Ptr, descent As wxInt Ptr, externalLeading As wxInt Ptr, f As wxFont Ptr)
Declare Sub wxWindow_ClientToScreen WXCALL Alias "wxWindow_ClientToScreen" (self As wxWindow Ptr, p1 As wxPoint Ptr, p2 As wxPoint Ptr)
Declare Sub wxWindow_ScreenToClient WXCALL Alias "wxWindow_ScreenToClient" (self As wxWindow Ptr, p1 As wxPoint Ptr, p2 As wxPoint Ptr)
Declare Sub wxWindow_HitTest WXCALL Alias "wxWindow_HitTest" (self As wxWindow Ptr, p As wxPoint Ptr, hittest As wxHitTest Ptr)
Declare Function wxWindow_GetBorder WXCALL Alias "wxWindow_GetBorder" (self As wxWindow Ptr) As wxInt
Declare Function wxWindow_GetBorderByFlags WXCALL Alias "wxWindow_GetBorderByFlags" (self As wxWindow Ptr, flags As wxInt) As wxInt
Declare Sub wxWindow_UpdateWindowUI WXCALL Alias "wxWindow_UpdateWindowUI" (self As wxWindow Ptr)
Declare Function wxWindow_PopupMenu WXCALL Alias "wxWindow_PopupMenu" (self As wxWindow Ptr, m As wxMenu Ptr, p As wxPoint Ptr) As wxChar
Declare Function wxWindow_HasScrollbar WXCALL Alias "wxWindow_HasScrollbar" (self As wxWindow Ptr, orient As wxInt) As wxBool
Declare Sub wxWindow_SetScrollbar WXCALL Alias "wxWindow_SetScrollbar" (self As wxWindow Ptr, orient As wxInt, po As wxInt, thumbvisible As wxInt, range As wxInt, refresh As wxBool)
Declare Function wxWindow_GetScrollThumb WXCALL Alias "wxWindow_GetScrollThumb" (self As wxWindow Ptr, orient As wxInt)  As wxInt
Declare Function wxWindow_GetScrollRange WXCALL Alias "wxWindow_GetScrollRange" (self As wxWindow Ptr, orient As wxInt)  As wxInt
Declare Sub wxWindow_ScrollWindow WXCALL Alias "wxWindow_ScrollWindow" (self As wxWindow Ptr, dx As wxInt, dy As wxInt, r As wxRect Ptr)
Declare Function wxWindow_ScrollLines WXCALL Alias "wxWindow_ScrollLines" (self As wxWindow Ptr, lines As wxInt) As wxChar
Declare Function wxWindow_ScrollPages WXCALL Alias "wxWindow_ScrollPages" (self As wxWindow Ptr, pages As wxInt) As wxChar
Declare Function wxWindow_LineUp WXCALL Alias "wxWindow_LineUp" (self As wxWindow Ptr) As wxChar
Declare Function wxWindow_LineDown WXCALL Alias "wxWindow_LineDown" (self As wxWindow Ptr) As wxChar
Declare Function wxWindow_PageUp WXCALL Alias "wxWindow_PageUp" (self As wxWindow Ptr) As wxChar
Declare Function wxWindow_PageDown WXCALL Alias "wxWindow_PageDown" (self As wxWindow Ptr) As wxChar
Declare Sub wxWindow_SetHelpTextForId WXCALL Alias "wxWindow_SetHelpTextForId" (self As wxWindow Ptr, txt As wxString Ptr)
Declare Function wxWindow_GetAncestorWithCustomPalette WXCALL Alias "wxWindow_GetAncestorWithCustomPalette" (self As wxWindow Ptr) As wxWindow Ptr
Declare Function wxWindow_GetAutoLayout WXCALL Alias "wxWindow_GetAutoLayout" (self As wxWindow Ptr) As wxChar
Declare Sub wxWindow_SetSizerAndFit WXCALL Alias "wxWindow_SetSizerAndFit" (self As wxWindow Ptr, sizer As wxSizer Ptr, deleteOld As wxBool)
Declare Function wxWindow_GetSizer WXCALL Alias "wxWindow_GetSizer" (self As wxWindow Ptr) As wxSizer Ptr
Declare Function wxWindow_HasCustomPalette WXCALL Alias "wxWindow_HasCustomPalette" (self As wxWindow Ptr) As wxChar
Declare Function wxWindow_GetUpdateRegion WXCALL Alias "wxWindow_GetUpdateRegion" (self As wxWindow Ptr) As wxRegion Ptr
Declare Function wxWindow_IsBeingDeleted WXCALL Alias "wxWindow_IsBeingDeleted" (self As wxWindow Ptr) As wxChar
Declare Sub wxWindow_InvalidateBestSize WXCALL Alias "wxWindow_InvalidateBestSize" (self As wxWindow Ptr)
Declare Sub wxWindow_CacheBestSize WXCALL Alias "wxWindow_CacheBestSize" (self As wxWindow Ptr, size As wxSize Ptr)
Declare Sub wxWindow_GetEffectiveMinSize WXCALL Alias "wxWindow_GetEffectiveMinSize" (self As wxWindow Ptr, size As wxSize Ptr)
Declare Sub wxWindow_SetInitialSize WXCALL Alias "wxWindow_SetInitialSize" (self As wxWindow Ptr, size As wxSize Ptr)
Declare Function wxWindow_GetChildren WXCALL Alias "wxWindow_GetChildren" (self As wxWindow Ptr, num As wxInt) As wxWindow Ptr
Declare Function wxWindow_GetChildrenCount WXCALL Alias "wxWindow_GetChildrenCount" (self As wxWindow Ptr) As wxInt
Declare Function wxWindow_GetDefaultAttributes WXCALL Alias "wxWindow_GetDefaultAttributes" (self As wxWindow Ptr) As wxVisualAttributes Ptr
Declare Function wxWindow_GetClassDefaultAttributes WXCALL Alias "wxWindow_GetClassDefaultAttributes" (variant As wxWindowVariant Ptr) As wxVisualAttributes Ptr
Declare Sub wxWindow_InheritAttributes WXCALL Alias "wxWindow_InheritAttributes" (self As wxWindow Ptr)
Declare Function wxWindow_ShouldInheritColours WXCALL Alias "wxWindow_ShouldInheritColours" (self As wxWindow Ptr) As wxChar

#EndIf ' __window_bi__

