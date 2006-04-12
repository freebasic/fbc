''
''
'' textctrl -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_textctrl_bi__
#define __wxc_textctrl_bi__

#include once "wx-c/wx.bi"


declare function wxTextAttr cdecl alias "wxTextAttr_ctor" (byval colText as wxColour ptr, byval colBack as wxColour ptr, byval font as wxFont ptr, byval alignment as wxTextAttrAlignment) as wxTextAttr ptr
declare function wxTextAttr_ctor2 cdecl alias "wxTextAttr_ctor2" () as wxTextAttr ptr
declare sub wxTextAttr_dtor cdecl alias "wxTextAttr_dtor" (byval self as wxTextAttr ptr)
declare sub wxTextAttr_Init cdecl alias "wxTextAttr_Init" (byval self as wxTextAttr ptr)
declare sub wxTextAttr_SetTextColour cdecl alias "wxTextAttr_SetTextColour" (byval self as wxTextAttr ptr, byval colText as wxColour ptr)
declare function wxTextAttr_GetTextColour cdecl alias "wxTextAttr_GetTextColour" (byval self as wxTextAttr ptr) as wxColour ptr
declare sub wxTextAttr_SetBackgroundColour cdecl alias "wxTextAttr_SetBackgroundColour" (byval self as wxTextAttr ptr, byval colBack as wxColour ptr)
declare sub wxTextAttr_SetFont cdecl alias "wxTextAttr_SetFont" (byval self as wxTextAttr ptr, byval font as wxFont ptr)
declare function wxTextAttr_HasTextColour cdecl alias "wxTextAttr_HasTextColour" (byval self as wxTextAttr ptr) as integer
declare function wxTextAttr_HasBackgroundColour cdecl alias "wxTextAttr_HasBackgroundColour" (byval self as wxTextAttr ptr) as integer
declare function wxTextAttr_HasFont cdecl alias "wxTextAttr_HasFont" (byval self as wxTextAttr ptr) as integer
declare function wxTextAttr_HasAlignment cdecl alias "wxTextAttr_HasAlignment" (byval self as wxTextAttr ptr) as integer
declare function wxTextAttr_HasTabs cdecl alias "wxTextAttr_HasTabs" (byval self as wxTextAttr ptr) as integer
declare function wxTextAttr_HasLeftIndent cdecl alias "wxTextAttr_HasLeftIndent" (byval self as wxTextAttr ptr) as integer
declare function wxTextAttr_HasRightIndent cdecl alias "wxTextAttr_HasRightIndent" (byval self as wxTextAttr ptr) as integer
declare function wxTextAttr_HasFlag cdecl alias "wxTextAttr_HasFlag" (byval self as wxTextAttr ptr, byval flag as integer) as integer
declare function wxTextAttr_IsDefault cdecl alias "wxTextAttr_IsDefault" (byval self as wxTextAttr ptr) as integer
declare sub wxTextAttr_SetAlignment cdecl alias "wxTextAttr_SetAlignment" (byval self as wxTextAttr ptr, byval alignment as wxTextAttrAlignment)
declare function wxTextAttr_GetAlignment cdecl alias "wxTextAttr_GetAlignment" (byval self as wxTextAttr ptr) as wxTextAttrAlignment
declare function wxTextAttr_GetBackgroundColour cdecl alias "wxTextAttr_GetBackgroundColour" (byval self as wxTextAttr ptr) as wxColour ptr
declare function wxTextAttr_GetFont cdecl alias "wxTextAttr_GetFont" (byval self as wxTextAttr ptr) as wxFont ptr
declare function wxTextAttr_GetLeftIndent cdecl alias "wxTextAttr_GetLeftIndent" (byval self as wxTextAttr ptr) as integer
declare function wxTextAttr_GetLeftSubIndent cdecl alias "wxTextAttr_GetLeftSubIndent" (byval self as wxTextAttr ptr) as integer
declare sub wxTextAttr_SetTabs cdecl alias "wxTextAttr_SetTabs" (byval self as wxTextAttr ptr, byval tabs as wxArrayInt ptr)
declare function wxTextAttr_GetTabs cdecl alias "wxTextAttr_GetTabs" (byval self as wxTextAttr ptr) as wxArrayInt ptr
declare sub wxTextAttr_SetLeftIndent cdecl alias "wxTextAttr_SetLeftIndent" (byval self as wxTextAttr ptr, byval indent as integer, byval subIndent as integer)
declare sub wxTextAttr_SetRightIndent cdecl alias "wxTextAttr_SetRightIndent" (byval self as wxTextAttr ptr, byval indent as integer)
declare function wxTextAttr_GetRightIndent cdecl alias "wxTextAttr_GetRightIndent" (byval self as wxTextAttr ptr) as integer
declare sub wxTextAttr_SetFlags cdecl alias "wxTextAttr_SetFlags" (byval self as wxTextAttr ptr, byval flags as integer)
declare function wxTextAttr_GetFlags cdecl alias "wxTextAttr_GetFlags" (byval self as wxTextAttr ptr) as integer

declare function wxTextCtrl_GetValue cdecl alias "wxTextCtrl_GetValue" (byval self as wxTextCtrl ptr) as wxString ptr
declare sub wxTextCtrl_SetValue cdecl alias "wxTextCtrl_SetValue" (byval self as wxTextCtrl ptr, byval value as zstring ptr)
declare function wxTextCtrl_GetRange cdecl alias "wxTextCtrl_GetRange" (byval self as wxTextCtrl ptr, byval from as integer, byval to as integer) as wxString ptr
declare function wxTextCtrl_GetLineLength cdecl alias "wxTextCtrl_GetLineLength" (byval self as wxTextCtrl ptr, byval lineNo as integer) as integer
declare function wxTextCtrl_GetLineText cdecl alias "wxTextCtrl_GetLineText" (byval self as wxTextCtrl ptr, byval lineNo as integer) as wxString ptr
declare function wxTextCtrl_GetNumberOfLines cdecl alias "wxTextCtrl_GetNumberOfLines" (byval self as wxTextCtrl ptr) as integer
declare function wxTextCtrl_IsModified cdecl alias "wxTextCtrl_IsModified" (byval self as wxTextCtrl ptr) as integer
declare function wxTextCtrl_IsEditable cdecl alias "wxTextCtrl_IsEditable" (byval self as wxTextCtrl ptr) as integer
declare function wxTextCtrl_IsSingleLine cdecl alias "wxTextCtrl_IsSingleLine" (byval self as wxTextCtrl ptr) as integer
declare function wxTextCtrl_IsMultiLine cdecl alias "wxTextCtrl_IsMultiLine" (byval self as wxTextCtrl ptr) as integer
declare sub wxTextCtrl_GetSelection cdecl alias "wxTextCtrl_GetSelection" (byval self as wxTextCtrl ptr, byval from as integer ptr, byval to as integer ptr)
declare function wxTextCtrl_GetStringSelection cdecl alias "wxTextCtrl_GetStringSelection" (byval self as wxTextCtrl ptr) as wxString ptr
declare sub wxTextCtrl_Clear cdecl alias "wxTextCtrl_Clear" (byval self as wxTextCtrl ptr)
declare sub wxTextCtrl_Replace cdecl alias "wxTextCtrl_Replace" (byval self as wxTextCtrl ptr, byval from as integer, byval to as integer, byval value as zstring ptr)
declare sub wxTextCtrl_Remove cdecl alias "wxTextCtrl_Remove" (byval self as wxTextCtrl ptr, byval from as integer, byval to as integer)
declare function wxTextCtrl_LoadFile cdecl alias "wxTextCtrl_LoadFile" (byval self as wxTextCtrl ptr, byval file as zstring ptr) as integer
declare function wxTextCtrl_SaveFile cdecl alias "wxTextCtrl_SaveFile" (byval self as wxTextCtrl ptr, byval file as zstring ptr) as integer
declare sub wxTextCtrl_DiscardEdits cdecl alias "wxTextCtrl_DiscardEdits" (byval self as wxTextCtrl ptr)
declare sub wxTextCtrl_SetMaxLength cdecl alias "wxTextCtrl_SetMaxLength" (byval self as wxTextCtrl ptr, byval len as uinteger)
declare sub wxTextCtrl_WriteText cdecl alias "wxTextCtrl_WriteText" (byval self as wxTextCtrl ptr, byval text as zstring ptr)
declare sub wxTextCtrl_AppendText cdecl alias "wxTextCtrl_AppendText" (byval self as wxTextCtrl ptr, byval text as zstring ptr)
declare function wxTextCtrl_EmulateKeyPress cdecl alias "wxTextCtrl_EmulateKeyPress" (byval self as wxTextCtrl ptr, byval event as wxKeyEvent ptr) as integer
declare function wxTextCtrl_SetStyle cdecl alias "wxTextCtrl_SetStyle" (byval self as wxTextCtrl ptr, byval start as integer, byval end as integer, byval style as wxTextAttr ptr) as integer
declare function wxTextCtrl_GetStyle cdecl alias "wxTextCtrl_GetStyle" (byval self as wxTextCtrl ptr, byval position as integer, byval style as wxTextAttr ptr) as integer
declare function wxTextCtrl_SetDefaultStyle cdecl alias "wxTextCtrl_SetDefaultStyle" (byval self as wxTextCtrl ptr, byval style as wxTextAttr ptr) as integer
declare function wxTextCtrl_GetDefaultStyle cdecl alias "wxTextCtrl_GetDefaultStyle" (byval self as wxTextCtrl ptr) as wxTextAttr ptr
declare function wxTextCtrl_XYToPosition cdecl alias "wxTextCtrl_XYToPosition" (byval self as wxTextCtrl ptr, byval x as integer, byval y as integer) as integer
declare function wxTextCtrl_PositionToXY cdecl alias "wxTextCtrl_PositionToXY" (byval self as wxTextCtrl ptr, byval pos as integer, byval x as integer ptr, byval y as integer ptr) as integer
declare sub wxTextCtrl_ShowPosition cdecl alias "wxTextCtrl_ShowPosition" (byval self as wxTextCtrl ptr, byval pos as integer)
declare sub wxTextCtrl_Copy cdecl alias "wxTextCtrl_Copy" (byval self as wxTextCtrl ptr)
declare sub wxTextCtrl_Cut cdecl alias "wxTextCtrl_Cut" (byval self as wxTextCtrl ptr)
declare sub wxTextCtrl_Paste cdecl alias "wxTextCtrl_Paste" (byval self as wxTextCtrl ptr)
declare function wxTextCtrl_CanCopy cdecl alias "wxTextCtrl_CanCopy" (byval self as wxTextCtrl ptr) as integer
declare function wxTextCtrl_CanCut cdecl alias "wxTextCtrl_CanCut" (byval self as wxTextCtrl ptr) as integer
declare function wxTextCtrl_CanPaste cdecl alias "wxTextCtrl_CanPaste" (byval self as wxTextCtrl ptr) as integer
declare sub wxTextCtrl_Undo cdecl alias "wxTextCtrl_Undo" (byval self as wxTextCtrl ptr)
declare sub wxTextCtrl_Redo cdecl alias "wxTextCtrl_Redo" (byval self as wxTextCtrl ptr)
declare function wxTextCtrl_CanUndo cdecl alias "wxTextCtrl_CanUndo" (byval self as wxTextCtrl ptr) as integer
declare function wxTextCtrl_CanRedo cdecl alias "wxTextCtrl_CanRedo" (byval self as wxTextCtrl ptr) as integer
declare sub wxTextCtrl_SetInsertionPoint cdecl alias "wxTextCtrl_SetInsertionPoint" (byval self as wxTextCtrl ptr, byval pos as integer)
declare sub wxTextCtrl_SetInsertionPointEnd cdecl alias "wxTextCtrl_SetInsertionPointEnd" (byval self as wxTextCtrl ptr)
declare function wxTextCtrl_GetInsertionPoint cdecl alias "wxTextCtrl_GetInsertionPoint" (byval self as wxTextCtrl ptr) as integer
declare function wxTextCtrl_GetLastPosition cdecl alias "wxTextCtrl_GetLastPosition" (byval self as wxTextCtrl ptr) as integer
declare sub wxTextCtrl_SetSelection cdecl alias "wxTextCtrl_SetSelection" (byval self as wxTextCtrl ptr, byval from as integer, byval to as integer)
declare sub wxTextCtrl_SelectAll cdecl alias "wxTextCtrl_SelectAll" (byval self as wxTextCtrl ptr)
declare sub wxTextCtrl_SetEditable cdecl alias "wxTextCtrl_SetEditable" (byval self as wxTextCtrl ptr, byval editable as integer)
declare function wxTextUrlEvent cdecl alias "wxTextUrlEvent_ctor" (byval id as integer, byval evtMouse as wxMouseEvent ptr, byval start as integer, byval end as integer) as wxTextUrlEvent ptr
declare function wxTextUrlEvent_GetURLStart cdecl alias "wxTextUrlEvent_GetURLStart" (byval self as wxTextUrlEvent ptr) as integer
declare function wxTextUrlEvent_GetURLEnd cdecl alias "wxTextUrlEvent_GetURLEnd" (byval self as wxTextUrlEvent ptr) as integer
declare function wxTextCtrl cdecl alias "wxTextCtrl_ctor" () as wxTextCtrl ptr
declare function wxTextCtrl_Create cdecl alias "wxTextCtrl_Create" (byval self as wxTextCtrl ptr, byval parent as wxWindow ptr, byval id as wxWindowID, byval value as zstring ptr, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval validator as wxValidator ptr, byval name as zstring ptr) as integer
declare function wxTextCtrl_Enable cdecl alias "wxTextCtrl_Enable" (byval self as wxTextCtrl ptr, byval enable as integer) as integer
declare sub wxTextCtrl_OnDropFiles cdecl alias "wxTextCtrl_OnDropFiles" (byval self as wxTextCtrl ptr, byval event as wxDropFilesEvent ptr)
declare function wxTextCtrl_SetFont cdecl alias "wxTextCtrl_SetFont" (byval self as wxTextCtrl ptr, byval font as wxFont ptr) as integer
declare function wxTextCtrl_SetForegroundColour cdecl alias "wxTextCtrl_SetForegroundColour" (byval self as wxTextCtrl ptr, byval colour as wxColour ptr) as integer
declare function wxTextCtrl_SetBackgroundColour cdecl alias "wxTextCtrl_SetBackgroundColour" (byval self as wxTextCtrl ptr, byval colour as wxColour ptr) as integer
declare sub wxTextCtrl_Freeze cdecl alias "wxTextCtrl_Freeze" (byval self as wxTextCtrl ptr)
declare sub wxTextCtrl_Thaw cdecl alias "wxTextCtrl_Thaw" (byval self as wxTextCtrl ptr)
declare function wxTextCtrl_ScrollLines cdecl alias "wxTextCtrl_ScrollLines" (byval self as wxTextCtrl ptr, byval lines as integer) as integer
declare function wxTextCtrl_ScrollPages cdecl alias "wxTextCtrl_ScrollPages" (byval self as wxTextCtrl ptr, byval pages as integer) as integer
declare sub wxTextCtrl_MarkDirty cdecl alias "wxTextCtrl_MarkDirty" (byval self as wxTextCtrl ptr)
declare function wxTextCtrl_HitTest cdecl alias "wxTextCtrl_HitTest" (byval self as wxTextCtrl ptr, byval pt as wxPoint ptr, byval pos as integer ptr) as wxTextCtrlHitTestResult
declare function wxTextCtrl_HitTest2 cdecl alias "wxTextCtrl_HitTest2" (byval self as wxTextCtrl ptr, byval pt as wxPoint ptr, byval col as wxTextCoord ptr, byval row as wxTextCoord ptr) as wxTextCtrlHitTestResult

#endif
