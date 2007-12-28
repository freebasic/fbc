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

#include once "wx.bi"


declare function wxTextAttr alias "wxTextAttr_ctor" (byval colText as wxColour ptr, byval colBack as wxColour ptr, byval font as wxFont ptr, byval alignment as wxTextAttrAlignment) as wxTextAttr ptr
declare function wxTextAttr_ctor2 () as wxTextAttr ptr
declare sub wxTextAttr_dtor (byval self as wxTextAttr ptr)
declare sub wxTextAttr_Init (byval self as wxTextAttr ptr)
declare sub wxTextAttr_SetTextColour (byval self as wxTextAttr ptr, byval colText as wxColour ptr)
declare function wxTextAttr_GetTextColour (byval self as wxTextAttr ptr) as wxColour ptr
declare sub wxTextAttr_SetBackgroundColour (byval self as wxTextAttr ptr, byval colBack as wxColour ptr)
declare sub wxTextAttr_SetFont (byval self as wxTextAttr ptr, byval font as wxFont ptr)
declare function wxTextAttr_HasTextColour (byval self as wxTextAttr ptr) as integer
declare function wxTextAttr_HasBackgroundColour (byval self as wxTextAttr ptr) as integer
declare function wxTextAttr_HasFont (byval self as wxTextAttr ptr) as integer
declare function wxTextAttr_HasAlignment (byval self as wxTextAttr ptr) as integer
declare function wxTextAttr_HasTabs (byval self as wxTextAttr ptr) as integer
declare function wxTextAttr_HasLeftIndent (byval self as wxTextAttr ptr) as integer
declare function wxTextAttr_HasRightIndent (byval self as wxTextAttr ptr) as integer
declare function wxTextAttr_HasFlag (byval self as wxTextAttr ptr, byval flag as integer) as integer
declare function wxTextAttr_IsDefault (byval self as wxTextAttr ptr) as integer
declare sub wxTextAttr_SetAlignment (byval self as wxTextAttr ptr, byval alignment as wxTextAttrAlignment)
declare function wxTextAttr_GetAlignment (byval self as wxTextAttr ptr) as wxTextAttrAlignment
declare function wxTextAttr_GetBackgroundColour (byval self as wxTextAttr ptr) as wxColour ptr
declare function wxTextAttr_GetFont (byval self as wxTextAttr ptr) as wxFont ptr
declare function wxTextAttr_GetLeftIndent (byval self as wxTextAttr ptr) as integer
declare function wxTextAttr_GetLeftSubIndent (byval self as wxTextAttr ptr) as integer
declare sub wxTextAttr_SetTabs (byval self as wxTextAttr ptr, byval tabs as wxArrayInt ptr)
declare function wxTextAttr_GetTabs (byval self as wxTextAttr ptr) as wxArrayInt ptr
declare sub wxTextAttr_SetLeftIndent (byval self as wxTextAttr ptr, byval indent as integer, byval subIndent as integer)
declare sub wxTextAttr_SetRightIndent (byval self as wxTextAttr ptr, byval indent as integer)
declare function wxTextAttr_GetRightIndent (byval self as wxTextAttr ptr) as integer
declare sub wxTextAttr_SetFlags (byval self as wxTextAttr ptr, byval flags as integer)
declare function wxTextAttr_GetFlags (byval self as wxTextAttr ptr) as integer

declare function wxTextCtrl_GetValue (byval self as wxTextCtrl ptr) as wxString ptr
declare sub wxTextCtrl_SetValue (byval self as wxTextCtrl ptr, byval value as zstring ptr)
declare function wxTextCtrl_GetRange (byval self as wxTextCtrl ptr, byval from as integer, byval to as integer) as wxString ptr
declare function wxTextCtrl_GetLineLength (byval self as wxTextCtrl ptr, byval lineNo as integer) as integer
declare function wxTextCtrl_GetLineText (byval self as wxTextCtrl ptr, byval lineNo as integer) as wxString ptr
declare function wxTextCtrl_GetNumberOfLines (byval self as wxTextCtrl ptr) as integer
declare function wxTextCtrl_IsModified (byval self as wxTextCtrl ptr) as integer
declare function wxTextCtrl_IsEditable (byval self as wxTextCtrl ptr) as integer
declare function wxTextCtrl_IsSingleLine (byval self as wxTextCtrl ptr) as integer
declare function wxTextCtrl_IsMultiLine (byval self as wxTextCtrl ptr) as integer
declare sub wxTextCtrl_GetSelection (byval self as wxTextCtrl ptr, byval from as integer ptr, byval to as integer ptr)
declare function wxTextCtrl_GetStringSelection (byval self as wxTextCtrl ptr) as wxString ptr
declare sub wxTextCtrl_Clear (byval self as wxTextCtrl ptr)
declare sub wxTextCtrl_Replace (byval self as wxTextCtrl ptr, byval from as integer, byval to as integer, byval value as zstring ptr)
declare sub wxTextCtrl_Remove (byval self as wxTextCtrl ptr, byval from as integer, byval to as integer)
declare function wxTextCtrl_LoadFile (byval self as wxTextCtrl ptr, byval file as zstring ptr) as integer
declare function wxTextCtrl_SaveFile (byval self as wxTextCtrl ptr, byval file as zstring ptr) as integer
declare sub wxTextCtrl_DiscardEdits (byval self as wxTextCtrl ptr)
declare sub wxTextCtrl_SetMaxLength (byval self as wxTextCtrl ptr, byval len as uinteger)
declare sub wxTextCtrl_WriteText (byval self as wxTextCtrl ptr, byval text as zstring ptr)
declare sub wxTextCtrl_AppendText (byval self as wxTextCtrl ptr, byval text as zstring ptr)
declare function wxTextCtrl_EmulateKeyPress (byval self as wxTextCtrl ptr, byval event as wxKeyEvent ptr) as integer
declare function wxTextCtrl_SetStyle (byval self as wxTextCtrl ptr, byval start as integer, byval end as integer, byval style as wxTextAttr ptr) as integer
declare function wxTextCtrl_GetStyle (byval self as wxTextCtrl ptr, byval position as integer, byval style as wxTextAttr ptr) as integer
declare function wxTextCtrl_SetDefaultStyle (byval self as wxTextCtrl ptr, byval style as wxTextAttr ptr) as integer
declare function wxTextCtrl_GetDefaultStyle (byval self as wxTextCtrl ptr) as wxTextAttr ptr
declare function wxTextCtrl_XYToPosition (byval self as wxTextCtrl ptr, byval x as integer, byval y as integer) as integer
declare function wxTextCtrl_PositionToXY (byval self as wxTextCtrl ptr, byval pos as integer, byval x as integer ptr, byval y as integer ptr) as integer
declare sub wxTextCtrl_ShowPosition (byval self as wxTextCtrl ptr, byval pos as integer)
declare sub wxTextCtrl_Copy (byval self as wxTextCtrl ptr)
declare sub wxTextCtrl_Cut (byval self as wxTextCtrl ptr)
declare sub wxTextCtrl_Paste (byval self as wxTextCtrl ptr)
declare function wxTextCtrl_CanCopy (byval self as wxTextCtrl ptr) as integer
declare function wxTextCtrl_CanCut (byval self as wxTextCtrl ptr) as integer
declare function wxTextCtrl_CanPaste (byval self as wxTextCtrl ptr) as integer
declare sub wxTextCtrl_Undo (byval self as wxTextCtrl ptr)
declare sub wxTextCtrl_Redo (byval self as wxTextCtrl ptr)
declare function wxTextCtrl_CanUndo (byval self as wxTextCtrl ptr) as integer
declare function wxTextCtrl_CanRedo (byval self as wxTextCtrl ptr) as integer
declare sub wxTextCtrl_SetInsertionPoint (byval self as wxTextCtrl ptr, byval pos as integer)
declare sub wxTextCtrl_SetInsertionPointEnd (byval self as wxTextCtrl ptr)
declare function wxTextCtrl_GetInsertionPoint (byval self as wxTextCtrl ptr) as integer
declare function wxTextCtrl_GetLastPosition (byval self as wxTextCtrl ptr) as integer
declare sub wxTextCtrl_SetSelection (byval self as wxTextCtrl ptr, byval from as integer, byval to as integer)
declare sub wxTextCtrl_SelectAll (byval self as wxTextCtrl ptr)
declare sub wxTextCtrl_SetEditable (byval self as wxTextCtrl ptr, byval editable as integer)
declare function wxTextUrlEvent alias "wxTextUrlEvent_ctor" (byval id as integer, byval evtMouse as wxMouseEvent ptr, byval start as integer, byval end as integer) as wxTextUrlEvent ptr
declare function wxTextUrlEvent_GetURLStart (byval self as wxTextUrlEvent ptr) as integer
declare function wxTextUrlEvent_GetURLEnd (byval self as wxTextUrlEvent ptr) as integer
declare function wxTextCtrl alias "wxTextCtrl_ctor" () as wxTextCtrl ptr
declare function wxTextCtrl_Create (byval self as wxTextCtrl ptr, byval parent as wxWindow ptr, byval id as wxWindowID, byval value as zstring ptr, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval validator as wxValidator ptr, byval name as zstring ptr) as integer
declare function wxTextCtrl_Enable (byval self as wxTextCtrl ptr, byval enable as integer) as integer
declare sub wxTextCtrl_OnDropFiles (byval self as wxTextCtrl ptr, byval event as wxDropFilesEvent ptr)
declare function wxTextCtrl_SetFont (byval self as wxTextCtrl ptr, byval font as wxFont ptr) as integer
declare function wxTextCtrl_SetForegroundColour (byval self as wxTextCtrl ptr, byval colour as wxColour ptr) as integer
declare function wxTextCtrl_SetBackgroundColour (byval self as wxTextCtrl ptr, byval colour as wxColour ptr) as integer
declare sub wxTextCtrl_Freeze (byval self as wxTextCtrl ptr)
declare sub wxTextCtrl_Thaw (byval self as wxTextCtrl ptr)
declare function wxTextCtrl_ScrollLines (byval self as wxTextCtrl ptr, byval lines as integer) as integer
declare function wxTextCtrl_ScrollPages (byval self as wxTextCtrl ptr, byval pages as integer) as integer
declare sub wxTextCtrl_MarkDirty (byval self as wxTextCtrl ptr)
declare function wxTextCtrl_HitTest (byval self as wxTextCtrl ptr, byval pt as wxPoint ptr, byval pos as integer ptr) as wxTextCtrlHitTestResult
declare function wxTextCtrl_HitTest2 (byval self as wxTextCtrl ptr, byval pt as wxPoint ptr, byval col as wxTextCoord ptr, byval row as wxTextCoord ptr) as wxTextCtrlHitTestResult

#endif
