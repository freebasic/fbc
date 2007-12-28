''
''
'' styledtextctrl -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_styledtextctrl_bi__
#define __wxc_styledtextctrl_bi__

#include once "wx.bi"

declare function wxStyledTextCtrl_EVT_STC_CHANGE () as integer
declare function wxStyledTextCtrl_EVT_STC_STYLENEEDED () as integer
declare function wxStyledTextCtrl_EVT_STC_CHARADDED () as integer
declare function wxStyledTextCtrl_EVT_STC_SAVEPOINTREACHED () as integer
declare function wxStyledTextCtrl_EVT_STC_SAVEPOINTLEFT () as integer
declare function wxStyledTextCtrl_EVT_STC_ROMODIFYATTEMPT () as integer
declare function wxStyledTextCtrl_EVT_STC_KEY () as integer
declare function wxStyledTextCtrl_EVT_STC_DOUBLECLICK () as integer
declare function wxStyledTextCtrl_EVT_STC_UPDATEUI () as integer
declare function wxStyledTextCtrl_EVT_STC_MODIFIED () as integer
declare function wxStyledTextCtrl_EVT_STC_MACRORECORD () as integer
declare function wxStyledTextCtrl_EVT_STC_MARGINCLICK () as integer
declare function wxStyledTextCtrl_EVT_STC_NEEDSHOWN () as integer
declare function wxStyledTextCtrl_EVT_STC_PAINTED () as integer
declare function wxStyledTextCtrl_EVT_STC_USERLISTSELECTION () as integer
declare function wxStyledTextCtrl_EVT_STC_URIDROPPED () as integer
declare function wxStyledTextCtrl_EVT_STC_DWELLSTART () as integer
declare function wxStyledTextCtrl_EVT_STC_DWELLEND () as integer
declare function wxStyledTextCtrl_EVT_STC_START_DRAG () as integer
declare function wxStyledTextCtrl_EVT_STC_DRAG_OVER () as integer
declare function wxStyledTextCtrl_EVT_STC_DO_DROP () as integer
declare function wxStyledTextCtrl_EVT_STC_ZOOM () as integer
declare function wxStyledTextCtrl_EVT_STC_HOTSPOT_CLICK () as integer
declare function wxStyledTextCtrl_EVT_STC_HOTSPOT_DCLICK () as integer
declare function wxStyledTextCtrl_EVT_STC_CALLTIP_CLICK () as integer

declare function wxStyledTextCtrl alias "wxStyledTextCtrl_ctor" (byval parent as wxWindow ptr, byval id as wxWindowID, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval name as zstring ptr) as wxStyledTextCtrl ptr
declare sub wxStyledTextCtrl_AddText (byval self as wxStyledTextCtrl ptr, byval text as zstring ptr)
declare sub wxStyledTextCtrl_AddStyledText (byval self as wxStyledTextCtrl ptr, byval data as wxMemoryBuffer ptr)
declare sub wxStyledTextCtrl_InsertText (byval self as wxStyledTextCtrl ptr, byval pos as integer, byval text as zstring ptr)
declare sub wxStyledTextCtrl_ClearAll (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_ClearDocumentStyle (byval self as wxStyledTextCtrl ptr)
declare function wxStyledTextCtrl_GetLength (byval self as wxStyledTextCtrl ptr) as integer
declare function wxStyledTextCtrl_GetCharAt (byval self as wxStyledTextCtrl ptr, byval pos as integer) as integer
declare function wxStyledTextCtrl_GetCurrentPos (byval self as wxStyledTextCtrl ptr) as integer
declare function wxStyledTextCtrl_GetAnchor (byval self as wxStyledTextCtrl ptr) as integer
declare function wxStyledTextCtrl_GetStyleAt (byval self as wxStyledTextCtrl ptr, byval pos as integer) as integer
declare sub wxStyledTextCtrl_Redo (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_SetUndoCollection (byval self as wxStyledTextCtrl ptr, byval collectUndo as integer)
declare sub wxStyledTextCtrl_SelectAll (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_SetSavePoint (byval self as wxStyledTextCtrl ptr)
declare function wxStyledTextCtrl_GetStyledText (byval self as wxStyledTextCtrl ptr, byval startPos as integer, byval endPos as integer) as wxMemoryBuffer ptr
declare function wxStyledTextCtrl_CanRedo (byval self as wxStyledTextCtrl ptr) as integer
declare function wxStyledTextCtrl_MarkerLineFromHandle (byval self as wxStyledTextCtrl ptr, byval handle as integer) as integer
declare sub wxStyledTextCtrl_MarkerDeleteHandle (byval self as wxStyledTextCtrl ptr, byval handle as integer)
declare function wxStyledTextCtrl_GetUndoCollection (byval self as wxStyledTextCtrl ptr) as integer
declare function wxStyledTextCtrl_GetViewWhiteSpace (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetViewWhiteSpace (byval self as wxStyledTextCtrl ptr, byval viewWS as integer)
''''''' declare function wxStyledTextCtrl_PositionFromPoint (byval self as wxStyledTextCtrl ptr, byval pt as wxPoint) as integer
declare function wxStyledTextCtrl_PositionFromPointClose (byval self as wxStyledTextCtrl ptr, byval x as integer, byval y as integer) as integer
declare sub wxStyledTextCtrl_GotoLine (byval self as wxStyledTextCtrl ptr, byval line as integer)
declare sub wxStyledTextCtrl_GotoPos (byval self as wxStyledTextCtrl ptr, byval pos as integer)
declare sub wxStyledTextCtrl_SetAnchor (byval self as wxStyledTextCtrl ptr, byval posAnchor as integer)
declare function wxStyledTextCtrl_GetCurLine (byval self as wxStyledTextCtrl ptr, byval linePos as integer ptr) as wxString ptr
declare function wxStyledTextCtrl_GetEndStyled (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_ConvertEOLs (byval self as wxStyledTextCtrl ptr, byval eolMode as integer)
declare function wxStyledTextCtrl_GetEOLMode (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetEOLMode (byval self as wxStyledTextCtrl ptr, byval eolMode as integer)
declare sub wxStyledTextCtrl_StartStyling (byval self as wxStyledTextCtrl ptr, byval pos as integer, byval mask as integer)
declare sub wxStyledTextCtrl_SetStyling (byval self as wxStyledTextCtrl ptr, byval length as integer, byval style as integer)
declare function wxStyledTextCtrl_GetBufferedDraw (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetBufferedDraw (byval self as wxStyledTextCtrl ptr, byval buffered as integer)
declare sub wxStyledTextCtrl_SetTabWidth (byval self as wxStyledTextCtrl ptr, byval tabWidth as integer)
declare function wxStyledTextCtrl_GetTabWidth (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetCodePage (byval self as wxStyledTextCtrl ptr, byval codePage as integer)
declare sub wxStyledTextCtrl_MarkerDefine (byval self as wxStyledTextCtrl ptr, byval markerNumber as integer, byval markerSymbol as integer, byval foreground as wxColour ptr, byval background as wxColour ptr)
declare sub wxStyledTextCtrl_MarkerSetForeground (byval self as wxStyledTextCtrl ptr, byval markerNumber as integer, byval fore as wxColour ptr)
declare sub wxStyledTextCtrl_MarkerSetBackground (byval self as wxStyledTextCtrl ptr, byval markerNumber as integer, byval back as wxColour ptr)
declare function wxStyledTextCtrl_MarkerAdd (byval self as wxStyledTextCtrl ptr, byval line as integer, byval markerNumber as integer) as integer
declare sub wxStyledTextCtrl_MarkerDelete (byval self as wxStyledTextCtrl ptr, byval line as integer, byval markerNumber as integer)
declare sub wxStyledTextCtrl_MarkerDeleteAll (byval self as wxStyledTextCtrl ptr, byval markerNumber as integer)
declare function wxStyledTextCtrl_MarkerGet (byval self as wxStyledTextCtrl ptr, byval line as integer) as integer
declare function wxStyledTextCtrl_MarkerNext (byval self as wxStyledTextCtrl ptr, byval lineStart as integer, byval markerMask as integer) as integer
declare function wxStyledTextCtrl_MarkerPrevious (byval self as wxStyledTextCtrl ptr, byval lineStart as integer, byval markerMask as integer) as integer
declare sub wxStyledTextCtrl_MarkerDefineBitmap (byval self as wxStyledTextCtrl ptr, byval markerNumber as integer, byval bmp as wxBitmap ptr)
declare sub wxStyledTextCtrl_SetMarginType (byval self as wxStyledTextCtrl ptr, byval margin as integer, byval marginType as integer)
declare function wxStyledTextCtrl_GetMarginType (byval self as wxStyledTextCtrl ptr, byval margin as integer) as integer
declare sub wxStyledTextCtrl_SetMarginWidth (byval self as wxStyledTextCtrl ptr, byval margin as integer, byval pixelWidth as integer)
declare function wxStyledTextCtrl_GetMarginWidth (byval self as wxStyledTextCtrl ptr, byval margin as integer) as integer
declare sub wxStyledTextCtrl_SetMarginMask (byval self as wxStyledTextCtrl ptr, byval margin as integer, byval mask as integer)
declare function wxStyledTextCtrl_GetMarginMask (byval self as wxStyledTextCtrl ptr, byval margin as integer) as integer
declare sub wxStyledTextCtrl_SetMarginSensitive (byval self as wxStyledTextCtrl ptr, byval margin as integer, byval sensitive as integer)
declare function wxStyledTextCtrl_GetMarginSensitive (byval self as wxStyledTextCtrl ptr, byval margin as integer) as integer
declare sub wxStyledTextCtrl_StyleClearAll (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_StyleSetForeground (byval self as wxStyledTextCtrl ptr, byval style as integer, byval fore as wxColour ptr)
declare sub wxStyledTextCtrl_StyleSetBackground (byval self as wxStyledTextCtrl ptr, byval style as integer, byval back as wxColour ptr)
declare sub wxStyledTextCtrl_StyleSetBold (byval self as wxStyledTextCtrl ptr, byval style as integer, byval bold as integer)
declare sub wxStyledTextCtrl_StyleSetItalic (byval self as wxStyledTextCtrl ptr, byval style as integer, byval italic as integer)
declare sub wxStyledTextCtrl_StyleSetSize (byval self as wxStyledTextCtrl ptr, byval style as integer, byval sizePoints as integer)
declare sub wxStyledTextCtrl_StyleSetFaceName (byval self as wxStyledTextCtrl ptr, byval style as integer, byval fontName as zstring ptr)
declare sub wxStyledTextCtrl_StyleSetEOLFilled (byval self as wxStyledTextCtrl ptr, byval style as integer, byval filled as integer)
declare sub wxStyledTextCtrl_StyleResetDefault (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_StyleSetUnderline (byval self as wxStyledTextCtrl ptr, byval style as integer, byval underline as integer)
declare sub wxStyledTextCtrl_StyleSetCase (byval self as wxStyledTextCtrl ptr, byval style as integer, byval caseForce as integer)
declare sub wxStyledTextCtrl_StyleSetCharacterSet (byval self as wxStyledTextCtrl ptr, byval style as integer, byval characterSet as integer)
declare sub wxStyledTextCtrl_StyleSetHotSpot (byval self as wxStyledTextCtrl ptr, byval style as integer, byval hotspot as integer)
declare sub wxStyledTextCtrl_SetSelForeground (byval self as wxStyledTextCtrl ptr, byval useSetting as integer, byval fore as wxColour ptr)
declare sub wxStyledTextCtrl_SetSelBackground (byval self as wxStyledTextCtrl ptr, byval useSetting as integer, byval back as wxColour ptr)
declare sub wxStyledTextCtrl_SetCaretForeground (byval self as wxStyledTextCtrl ptr, byval fore as wxColour ptr)
declare sub wxStyledTextCtrl_CmdKeyAssign (byval self as wxStyledTextCtrl ptr, byval key as integer, byval modifiers as integer, byval cmd as integer)
declare sub wxStyledTextCtrl_CmdKeyClear (byval self as wxStyledTextCtrl ptr, byval key as integer, byval modifiers as integer)
declare sub wxStyledTextCtrl_CmdKeyClearAll (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_SetStyleBytes (byval self as wxStyledTextCtrl ptr, byval length as integer, byval styleBytes as zstring ptr)
declare sub wxStyledTextCtrl_StyleSetVisible (byval self as wxStyledTextCtrl ptr, byval style as integer, byval visible as integer)
declare function wxStyledTextCtrl_GetCaretPeriod (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetCaretPeriod (byval self as wxStyledTextCtrl ptr, byval periodMilliseconds as integer)
declare sub wxStyledTextCtrl_SetWordChars (byval self as wxStyledTextCtrl ptr, byval characters as zstring ptr)
declare sub wxStyledTextCtrl_BeginUndoAction (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_EndUndoAction (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_IndicatorSetStyle (byval self as wxStyledTextCtrl ptr, byval indic as integer, byval style as integer)
declare function wxStyledTextCtrl_IndicatorGetStyle (byval self as wxStyledTextCtrl ptr, byval indic as integer) as integer
declare sub wxStyledTextCtrl_IndicatorSetForeground (byval self as wxStyledTextCtrl ptr, byval indic as integer, byval fore as wxColour ptr)
declare function wxStyledTextCtrl_IndicatorGetForeground (byval self as wxStyledTextCtrl ptr, byval indic as integer) as wxColour ptr
declare sub wxStyledTextCtrl_SetWhitespaceForeground (byval self as wxStyledTextCtrl ptr, byval useSetting as integer, byval fore as wxColour ptr)
declare sub wxStyledTextCtrl_SetWhitespaceBackground (byval self as wxStyledTextCtrl ptr, byval useSetting as integer, byval back as wxColour ptr)
declare sub wxStyledTextCtrl_SetStyleBits (byval self as wxStyledTextCtrl ptr, byval bits as integer)
declare function wxStyledTextCtrl_GetStyleBits (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetLineState (byval self as wxStyledTextCtrl ptr, byval line as integer, byval state as integer)
declare function wxStyledTextCtrl_GetLineState (byval self as wxStyledTextCtrl ptr, byval line as integer) as integer
declare function wxStyledTextCtrl_GetMaxLineState (byval self as wxStyledTextCtrl ptr) as integer
declare function wxStyledTextCtrl_GetCaretLineVisible (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetCaretLineVisible (byval self as wxStyledTextCtrl ptr, byval show as integer)
declare function wxStyledTextCtrl_GetCaretLineBack (byval self as wxStyledTextCtrl ptr) as wxColour ptr
declare sub wxStyledTextCtrl_SetCaretLineBack (byval self as wxStyledTextCtrl ptr, byval back as wxColour ptr)
declare sub wxStyledTextCtrl_StyleSetChangeable (byval self as wxStyledTextCtrl ptr, byval style as integer, byval changeable as integer)
declare sub wxStyledTextCtrl_AutoCompShow (byval self as wxStyledTextCtrl ptr, byval lenEntered as integer, byval itemList as zstring ptr)
declare sub wxStyledTextCtrl_AutoCompCancel (byval self as wxStyledTextCtrl ptr)
declare function wxStyledTextCtrl_AutoCompActive (byval self as wxStyledTextCtrl ptr) as integer
declare function wxStyledTextCtrl_AutoCompPosStart (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_AutoCompComplete (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_AutoCompStops (byval self as wxStyledTextCtrl ptr, byval characterSet as zstring ptr)
declare sub wxStyledTextCtrl_AutoCompSetSeparator (byval self as wxStyledTextCtrl ptr, byval separatorCharacter as integer)
declare function wxStyledTextCtrl_AutoCompGetSeparator (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_AutoCompSelect (byval self as wxStyledTextCtrl ptr, byval text as zstring ptr)
declare sub wxStyledTextCtrl_AutoCompSetCancelAtStart (byval self as wxStyledTextCtrl ptr, byval cancel as integer)
declare function wxStyledTextCtrl_AutoCompGetCancelAtStart (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_AutoCompSetFillUps (byval self as wxStyledTextCtrl ptr, byval characterSet as zstring ptr)
declare sub wxStyledTextCtrl_AutoCompSetChooseSingle (byval self as wxStyledTextCtrl ptr, byval chooseSingle as integer)
declare function wxStyledTextCtrl_AutoCompGetChooseSingle (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_AutoCompSetIgnoreCase (byval self as wxStyledTextCtrl ptr, byval ignoreCase as integer)
declare function wxStyledTextCtrl_AutoCompGetIgnoreCase (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_UserListShow (byval self as wxStyledTextCtrl ptr, byval listType as integer, byval itemList as zstring ptr)
declare sub wxStyledTextCtrl_AutoCompSetAutoHide (byval self as wxStyledTextCtrl ptr, byval autoHide as integer)
declare function wxStyledTextCtrl_AutoCompGetAutoHide (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_AutoCompSetDropRestOfWord (byval self as wxStyledTextCtrl ptr, byval dropRestOfWord as integer)
declare function wxStyledTextCtrl_AutoCompGetDropRestOfWord (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_RegisterImage (byval self as wxStyledTextCtrl ptr, byval type as integer, byval bmp as wxBitmap ptr)
declare sub wxStyledTextCtrl_ClearRegisteredImages (byval self as wxStyledTextCtrl ptr)
declare function wxStyledTextCtrl_AutoCompGetTypeSeparator (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_AutoCompSetTypeSeparator (byval self as wxStyledTextCtrl ptr, byval separatorCharacter as integer)
declare sub wxStyledTextCtrl_SetIndent (byval self as wxStyledTextCtrl ptr, byval indentSize as integer)
declare function wxStyledTextCtrl_GetIndent (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetUseTabs (byval self as wxStyledTextCtrl ptr, byval useTabs as integer)
declare function wxStyledTextCtrl_GetUseTabs (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetLineIndentation (byval self as wxStyledTextCtrl ptr, byval line as integer, byval indentSize as integer)
declare function wxStyledTextCtrl_GetLineIndentation (byval self as wxStyledTextCtrl ptr, byval line as integer) as integer
declare function wxStyledTextCtrl_GetLineIndentPosition (byval self as wxStyledTextCtrl ptr, byval line as integer) as integer
declare function wxStyledTextCtrl_GetColumn (byval self as wxStyledTextCtrl ptr, byval pos as integer) as integer
declare sub wxStyledTextCtrl_SetUseHorizontalScrollBar (byval self as wxStyledTextCtrl ptr, byval show as integer)
declare function wxStyledTextCtrl_GetUseHorizontalScrollBar (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetIndentationGuides (byval self as wxStyledTextCtrl ptr, byval show as integer)
declare function wxStyledTextCtrl_GetIndentationGuides (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetHighlightGuide (byval self as wxStyledTextCtrl ptr, byval column as integer)
declare function wxStyledTextCtrl_GetHighlightGuide (byval self as wxStyledTextCtrl ptr) as integer
declare function wxStyledTextCtrl_GetLineEndPosition (byval self as wxStyledTextCtrl ptr, byval line as integer) as integer
declare function wxStyledTextCtrl_GetCodePage (byval self as wxStyledTextCtrl ptr) as integer
declare function wxStyledTextCtrl_GetCaretForeground (byval self as wxStyledTextCtrl ptr) as wxColour ptr
declare function wxStyledTextCtrl_GetReadOnly (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetCurrentPos (byval self as wxStyledTextCtrl ptr, byval pos as integer)
declare sub wxStyledTextCtrl_SetSelectionStart (byval self as wxStyledTextCtrl ptr, byval pos as integer)
declare function wxStyledTextCtrl_GetSelectionStart (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetSelectionEnd (byval self as wxStyledTextCtrl ptr, byval pos as integer)
declare function wxStyledTextCtrl_GetSelectionEnd (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetPrintMagnification (byval self as wxStyledTextCtrl ptr, byval magnification as integer)
declare function wxStyledTextCtrl_GetPrintMagnification (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetPrintColourMode (byval self as wxStyledTextCtrl ptr, byval mode as integer)
declare function wxStyledTextCtrl_GetPrintColourMode (byval self as wxStyledTextCtrl ptr) as integer
declare function wxStyledTextCtrl_FindText (byval self as wxStyledTextCtrl ptr, byval minPos as integer, byval maxPos as integer, byval text as zstring ptr, byval flags as integer) as integer
''''''' declare function wxStyledTextCtrl_FormatRange (byval self as wxStyledTextCtrl ptr, byval doDraw as integer, byval startPos as integer, byval endPos as integer, byval draw as wxDC ptr, byval target as wxDC ptr, byval renderRect as wxRect, byval pageRect as wxRect) as integer
declare function wxStyledTextCtrl_GetFirstVisibleLine (byval self as wxStyledTextCtrl ptr) as integer
declare function wxStyledTextCtrl_GetLine (byval self as wxStyledTextCtrl ptr, byval line as integer) as wxString ptr
declare function wxStyledTextCtrl_GetLineCount (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetMarginLeft (byval self as wxStyledTextCtrl ptr, byval pixelWidth as integer)
declare function wxStyledTextCtrl_GetMarginLeft (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetMarginRight (byval self as wxStyledTextCtrl ptr, byval pixelWidth as integer)
declare function wxStyledTextCtrl_GetMarginRight (byval self as wxStyledTextCtrl ptr) as integer
declare function wxStyledTextCtrl_GetModify (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetSelection (byval self as wxStyledTextCtrl ptr, byval start as integer, byval end as integer)
declare function wxStyledTextCtrl_GetSelectedText (byval self as wxStyledTextCtrl ptr) as wxString ptr
declare function wxStyledTextCtrl_GetTextRange (byval self as wxStyledTextCtrl ptr, byval startPos as integer, byval endPos as integer) as wxString ptr
declare sub wxStyledTextCtrl_HideSelection (byval self as wxStyledTextCtrl ptr, byval normal as integer)
declare function wxStyledTextCtrl_LineFromPosition (byval self as wxStyledTextCtrl ptr, byval pos as integer) as integer
declare function wxStyledTextCtrl_PositionFromLine (byval self as wxStyledTextCtrl ptr, byval line as integer) as integer
declare sub wxStyledTextCtrl_LineScroll (byval self as wxStyledTextCtrl ptr, byval columns as integer, byval lines as integer)
declare sub wxStyledTextCtrl_EnsureCaretVisible (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_ReplaceSelection (byval self as wxStyledTextCtrl ptr, byval text as zstring ptr)
declare sub wxStyledTextCtrl_SetReadOnly (byval self as wxStyledTextCtrl ptr, byval readOnly as integer)
declare function wxStyledTextCtrl_CanPaste (byval self as wxStyledTextCtrl ptr) as integer
declare function wxStyledTextCtrl_CanUndo (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_EmptyUndoBuffer (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_Undo (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_Cut (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_Copy (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_Paste (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_Clear (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_SetText (byval self as wxStyledTextCtrl ptr, byval text as zstring ptr)
declare function wxStyledTextCtrl_GetText (byval self as wxStyledTextCtrl ptr) as wxString ptr
declare function wxStyledTextCtrl_GetTextLength (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetOvertype (byval self as wxStyledTextCtrl ptr, byval overtype as integer)
declare function wxStyledTextCtrl_GetOvertype (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetCaretWidth (byval self as wxStyledTextCtrl ptr, byval pixelWidth as integer)
declare function wxStyledTextCtrl_GetCaretWidth (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetTargetStart (byval self as wxStyledTextCtrl ptr, byval pos as integer)
declare function wxStyledTextCtrl_GetTargetStart (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetTargetEnd (byval self as wxStyledTextCtrl ptr, byval pos as integer)
declare function wxStyledTextCtrl_GetTargetEnd (byval self as wxStyledTextCtrl ptr) as integer
declare function wxStyledTextCtrl_ReplaceTarget (byval self as wxStyledTextCtrl ptr, byval text as zstring ptr) as integer
declare function wxStyledTextCtrl_ReplaceTargetRE (byval self as wxStyledTextCtrl ptr, byval text as zstring ptr) as integer
declare function wxStyledTextCtrl_SearchInTarget (byval self as wxStyledTextCtrl ptr, byval text as zstring ptr) as integer
declare sub wxStyledTextCtrl_SetSearchFlags (byval self as wxStyledTextCtrl ptr, byval flags as integer)
declare function wxStyledTextCtrl_GetSearchFlags (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_CallTipShow (byval self as wxStyledTextCtrl ptr, byval pos as integer, byval definition as zstring ptr)
declare sub wxStyledTextCtrl_CallTipCancel (byval self as wxStyledTextCtrl ptr)
declare function wxStyledTextCtrl_CallTipActive (byval self as wxStyledTextCtrl ptr) as integer
declare function wxStyledTextCtrl_CallTipPosAtStart (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_CallTipSetHighlight (byval self as wxStyledTextCtrl ptr, byval start as integer, byval end as integer)
declare sub wxStyledTextCtrl_CallTipSetBackground (byval self as wxStyledTextCtrl ptr, byval back as wxColour ptr)
declare sub wxStyledTextCtrl_CallTipSetForeground (byval self as wxStyledTextCtrl ptr, byval fore as wxColour ptr)
declare sub wxStyledTextCtrl_CallTipSetForegroundHighlight (byval self as wxStyledTextCtrl ptr, byval fore as wxColour ptr)
declare function wxStyledTextCtrl_VisibleFromDocLine (byval self as wxStyledTextCtrl ptr, byval line as integer) as integer
declare function wxStyledTextCtrl_DocLineFromVisible (byval self as wxStyledTextCtrl ptr, byval lineDisplay as integer) as integer
declare sub wxStyledTextCtrl_SetFoldLevel (byval self as wxStyledTextCtrl ptr, byval line as integer, byval level as integer)
declare function wxStyledTextCtrl_GetFoldLevel (byval self as wxStyledTextCtrl ptr, byval line as integer) as integer
declare function wxStyledTextCtrl_GetLastChild (byval self as wxStyledTextCtrl ptr, byval line as integer, byval level as integer) as integer
declare function wxStyledTextCtrl_GetFoldParent (byval self as wxStyledTextCtrl ptr, byval line as integer) as integer
declare sub wxStyledTextCtrl_ShowLines (byval self as wxStyledTextCtrl ptr, byval lineStart as integer, byval lineEnd as integer)
declare sub wxStyledTextCtrl_HideLines (byval self as wxStyledTextCtrl ptr, byval lineStart as integer, byval lineEnd as integer)
declare function wxStyledTextCtrl_GetLineVisible (byval self as wxStyledTextCtrl ptr, byval line as integer) as integer
declare sub wxStyledTextCtrl_SetFoldExpanded (byval self as wxStyledTextCtrl ptr, byval line as integer, byval expanded as integer)
declare function wxStyledTextCtrl_GetFoldExpanded (byval self as wxStyledTextCtrl ptr, byval line as integer) as integer
declare sub wxStyledTextCtrl_ToggleFold (byval self as wxStyledTextCtrl ptr, byval line as integer)
declare sub wxStyledTextCtrl_EnsureVisible (byval self as wxStyledTextCtrl ptr, byval line as integer)
declare sub wxStyledTextCtrl_SetFoldFlags (byval self as wxStyledTextCtrl ptr, byval flags as integer)
declare sub wxStyledTextCtrl_EnsureVisibleEnforcePolicy (byval self as wxStyledTextCtrl ptr, byval line as integer)
declare sub wxStyledTextCtrl_SetTabIndents (byval self as wxStyledTextCtrl ptr, byval tabIndents as integer)
declare function wxStyledTextCtrl_GetTabIndents (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetBackSpaceUnIndents (byval self as wxStyledTextCtrl ptr, byval bsUnIndents as integer)
declare function wxStyledTextCtrl_GetBackSpaceUnIndents (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetMouseDwellTime (byval self as wxStyledTextCtrl ptr, byval periodMilliseconds as integer)
declare function wxStyledTextCtrl_GetMouseDwellTime (byval self as wxStyledTextCtrl ptr) as integer
declare function wxStyledTextCtrl_WordStartPosition (byval self as wxStyledTextCtrl ptr, byval pos as integer, byval onlyWordCharacters as integer) as integer
declare function wxStyledTextCtrl_WordEndPosition (byval self as wxStyledTextCtrl ptr, byval pos as integer, byval onlyWordCharacters as integer) as integer
declare sub wxStyledTextCtrl_SetWrapMode (byval self as wxStyledTextCtrl ptr, byval mode as integer)
declare function wxStyledTextCtrl_GetWrapMode (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetLayoutCache (byval self as wxStyledTextCtrl ptr, byval mode as integer)
declare function wxStyledTextCtrl_GetLayoutCache (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetScrollWidth (byval self as wxStyledTextCtrl ptr, byval pixelWidth as integer)
declare function wxStyledTextCtrl_GetScrollWidth (byval self as wxStyledTextCtrl ptr) as integer
declare function wxStyledTextCtrl_TextWidth (byval self as wxStyledTextCtrl ptr, byval style as integer, byval text as zstring ptr) as integer
declare sub wxStyledTextCtrl_SetEndAtLastLine (byval self as wxStyledTextCtrl ptr, byval endAtLastLine as integer)
declare function wxStyledTextCtrl_GetEndAtLastLine (byval self as wxStyledTextCtrl ptr) as integer
declare function wxStyledTextCtrl_TextHeight (byval self as wxStyledTextCtrl ptr, byval line as integer) as integer
declare sub wxStyledTextCtrl_SetUseVerticalScrollBar (byval self as wxStyledTextCtrl ptr, byval show as integer)
declare function wxStyledTextCtrl_GetUseVerticalScrollBar (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_AppendText (byval self as wxStyledTextCtrl ptr, byval length as integer, byval text as zstring ptr)
declare function wxStyledTextCtrl_GetTwoPhaseDraw (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetTwoPhaseDraw (byval self as wxStyledTextCtrl ptr, byval twoPhase as integer)
declare sub wxStyledTextCtrl_TargetFromSelection (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_LinesJoin (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_LinesSplit (byval self as wxStyledTextCtrl ptr, byval pixelWidth as integer)
declare sub wxStyledTextCtrl_SetFoldMarginColour (byval self as wxStyledTextCtrl ptr, byval useSetting as integer, byval back as wxColour ptr)
declare sub wxStyledTextCtrl_SetFoldMarginHiColour (byval self as wxStyledTextCtrl ptr, byval useSetting as integer, byval fore as wxColour ptr)
declare sub wxStyledTextCtrl_LineDuplicate (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_HomeDisplay (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_HomeDisplayExtend (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_LineEndDisplay (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_LineEndDisplayExtend (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_MoveCaretInsideView (byval self as wxStyledTextCtrl ptr)
declare function wxStyledTextCtrl_LineLength (byval self as wxStyledTextCtrl ptr, byval line as integer) as integer
declare sub wxStyledTextCtrl_BraceHighlight (byval self as wxStyledTextCtrl ptr, byval pos1 as integer, byval pos2 as integer)
declare sub wxStyledTextCtrl_BraceBadLight (byval self as wxStyledTextCtrl ptr, byval pos as integer)
declare function wxStyledTextCtrl_BraceMatch (byval self as wxStyledTextCtrl ptr, byval pos as integer) as integer
declare function wxStyledTextCtrl_GetViewEOL (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetViewEOL (byval self as wxStyledTextCtrl ptr, byval visible as integer)
declare sub wxStyledTextCtrl_GetDocPointer (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_SetDocPointer (byval self as wxStyledTextCtrl ptr, byval docPointer as any ptr)
declare sub wxStyledTextCtrl_SetModEventMask (byval self as wxStyledTextCtrl ptr, byval mask as integer)
declare function wxStyledTextCtrl_GetEdgeColumn (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetEdgeColumn (byval self as wxStyledTextCtrl ptr, byval column as integer)
declare function wxStyledTextCtrl_GetEdgeMode (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetEdgeMode (byval self as wxStyledTextCtrl ptr, byval mode as integer)
declare function wxStyledTextCtrl_GetEdgeColour (byval self as wxStyledTextCtrl ptr) as wxColour ptr
declare sub wxStyledTextCtrl_SetEdgeColour (byval self as wxStyledTextCtrl ptr, byval edgeColour as wxColour ptr)
declare sub wxStyledTextCtrl_SearchAnchor (byval self as wxStyledTextCtrl ptr)
declare function wxStyledTextCtrl_SearchNext (byval self as wxStyledTextCtrl ptr, byval flags as integer, byval text as zstring ptr) as integer
declare function wxStyledTextCtrl_SearchPrev (byval self as wxStyledTextCtrl ptr, byval flags as integer, byval text as zstring ptr) as integer
declare function wxStyledTextCtrl_LinesOnScreen (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_UsePopUp (byval self as wxStyledTextCtrl ptr, byval allowPopUp as integer)
declare function wxStyledTextCtrl_SelectionIsRectangle (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetZoom (byval self as wxStyledTextCtrl ptr, byval zoom as integer)
declare function wxStyledTextCtrl_GetZoom (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_CreateDocument (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_AddRefDocument (byval self as wxStyledTextCtrl ptr, byval docPointer as any ptr)
declare sub wxStyledTextCtrl_ReleaseDocument (byval self as wxStyledTextCtrl ptr, byval docPointer as any ptr)
declare function wxStyledTextCtrl_GetModEventMask (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetSTCFocus (byval self as wxStyledTextCtrl ptr, byval focus as integer)
declare function wxStyledTextCtrl_GetSTCFocus (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetStatus (byval self as wxStyledTextCtrl ptr, byval statusCode as integer)
declare function wxStyledTextCtrl_GetStatus (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetMouseDownCaptures (byval self as wxStyledTextCtrl ptr, byval captures as integer)
declare function wxStyledTextCtrl_GetMouseDownCaptures (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetSTCCursor (byval self as wxStyledTextCtrl ptr, byval cursorType as integer)
declare function wxStyledTextCtrl_GetSTCCursor (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetControlCharSymbol (byval self as wxStyledTextCtrl ptr, byval symbol as integer)
declare function wxStyledTextCtrl_GetControlCharSymbol (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_WordPartLeft (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_WordPartLeftExtend (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_WordPartRight (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_WordPartRightExtend (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_SetVisiblePolicy (byval self as wxStyledTextCtrl ptr, byval visiblePolicy as integer, byval visibleSlop as integer)
declare sub wxStyledTextCtrl_DelLineLeft (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_DelLineRight (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_SetXOffset (byval self as wxStyledTextCtrl ptr, byval newOffset as integer)
declare function wxStyledTextCtrl_GetXOffset (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_ChooseCaretX (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_SetXCaretPolicy (byval self as wxStyledTextCtrl ptr, byval caretPolicy as integer, byval caretSlop as integer)
declare sub wxStyledTextCtrl_SetYCaretPolicy (byval self as wxStyledTextCtrl ptr, byval caretPolicy as integer, byval caretSlop as integer)
declare sub wxStyledTextCtrl_SetPrintWrapMode (byval self as wxStyledTextCtrl ptr, byval mode as integer)
declare function wxStyledTextCtrl_GetPrintWrapMode (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetHotspotActiveForeground (byval self as wxStyledTextCtrl ptr, byval useSetting as integer, byval fore as wxColour ptr)
declare sub wxStyledTextCtrl_SetHotspotActiveBackground (byval self as wxStyledTextCtrl ptr, byval useSetting as integer, byval back as wxColour ptr)
declare sub wxStyledTextCtrl_SetHotspotActiveUnderline (byval self as wxStyledTextCtrl ptr, byval underline as integer)
declare sub wxStyledTextCtrl_StartRecord (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_StopRecord (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_SetLexer (byval self as wxStyledTextCtrl ptr, byval lexer as integer)
declare function wxStyledTextCtrl_GetLexer (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_Colourise (byval self as wxStyledTextCtrl ptr, byval start as integer, byval end as integer)
declare sub wxStyledTextCtrl_SetProperty (byval self as wxStyledTextCtrl ptr, byval key as zstring ptr, byval value as zstring ptr)
declare sub wxStyledTextCtrl_SetKeyWords (byval self as wxStyledTextCtrl ptr, byval keywordSet as integer, byval keyWords as zstring ptr)
declare sub wxStyledTextCtrl_SetLexerLanguage (byval self as wxStyledTextCtrl ptr, byval language as zstring ptr)
declare function wxStyledTextCtrl_GetCurrentLine (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_StyleSetSpec (byval self as wxStyledTextCtrl ptr, byval styleNum as integer, byval spec as zstring ptr)
declare sub wxStyledTextCtrl_StyleSetFont (byval self as wxStyledTextCtrl ptr, byval styleNum as integer, byval font as wxFont ptr)
declare sub wxStyledTextCtrl_StyleSetFontAttr (byval self as wxStyledTextCtrl ptr, byval styleNum as integer, byval size as integer, byval faceName as zstring ptr, byval bold as integer, byval italic as integer, byval underline as integer)
declare sub wxStyledTextCtrl_CmdKeyExecute (byval self as wxStyledTextCtrl ptr, byval cmd as integer)
declare sub wxStyledTextCtrl_SetMargins (byval self as wxStyledTextCtrl ptr, byval left as integer, byval right as integer)
declare sub wxStyledTextCtrl_GetSelection (byval self as wxStyledTextCtrl ptr, byval startPos as integer ptr, byval endPos as integer ptr)
declare sub wxStyledTextCtrl_PointFromPosition (byval self as wxStyledTextCtrl ptr, byval pos as integer, byval pt as wxPoint ptr)
declare sub wxStyledTextCtrl_ScrollToLine (byval self as wxStyledTextCtrl ptr, byval line as integer)
declare sub wxStyledTextCtrl_ScrollToColumn (byval self as wxStyledTextCtrl ptr, byval column as integer)
declare function wxStyledTextCtrl_SendMsg (byval self as wxStyledTextCtrl ptr, byval msg as integer, byval wp as integer, byval lp as integer) as integer
declare sub wxStyledTextCtrl_SetVScrollBar (byval self as wxStyledTextCtrl ptr, byval bar as wxScrollBar ptr)
declare sub wxStyledTextCtrl_SetHScrollBar (byval self as wxStyledTextCtrl ptr, byval bar as wxScrollBar ptr)
declare function wxStyledTextCtrl_GetLastKeydownProcessed (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetLastKeydownProcessed (byval self as wxStyledTextCtrl ptr, byval val as integer)
declare function wxStyledTextCtrl_SaveFile (byval self as wxStyledTextCtrl ptr, byval filename as zstring ptr) as integer
declare function wxStyledTextCtrl_LoadFile (byval self as wxStyledTextCtrl ptr, byval filename as zstring ptr) as integer
declare function wxStyledTextEvent alias "wxStyledTextEvent_ctor" (byval commandType as wxEventType, byval id as integer) as wxStyledTextEvent ptr
declare sub wxStyledTextEvent_SetPosition (byval self as wxStyledTextEvent ptr, byval pos as integer)
declare sub wxStyledTextEvent_SetKey (byval self as wxStyledTextEvent ptr, byval k as integer)
declare sub wxStyledTextEvent_SetModifiers (byval self as wxStyledTextEvent ptr, byval m as integer)
declare sub wxStyledTextEvent_SetModificationType (byval self as wxStyledTextEvent ptr, byval t as integer)
declare sub wxStyledTextEvent_SetText (byval self as wxStyledTextEvent ptr, byval t as zstring ptr)
declare sub wxStyledTextEvent_SetLength (byval self as wxStyledTextEvent ptr, byval len as integer)
declare sub wxStyledTextEvent_SetLinesAdded (byval self as wxStyledTextEvent ptr, byval num as integer)
declare sub wxStyledTextEvent_SetLine (byval self as wxStyledTextEvent ptr, byval val as integer)
declare sub wxStyledTextEvent_SetFoldLevelNow (byval self as wxStyledTextEvent ptr, byval val as integer)
declare sub wxStyledTextEvent_SetFoldLevelPrev (byval self as wxStyledTextEvent ptr, byval val as integer)
declare sub wxStyledTextEvent_SetMargin (byval self as wxStyledTextEvent ptr, byval val as integer)
declare sub wxStyledTextEvent_SetMessage (byval self as wxStyledTextEvent ptr, byval val as integer)
declare sub wxStyledTextEvent_SetWParam (byval self as wxStyledTextEvent ptr, byval val as integer)
declare sub wxStyledTextEvent_SetLParam (byval self as wxStyledTextEvent ptr, byval val as integer)
declare sub wxStyledTextEvent_SetListType (byval self as wxStyledTextEvent ptr, byval val as integer)
declare sub wxStyledTextEvent_SetX (byval self as wxStyledTextEvent ptr, byval val as integer)
declare sub wxStyledTextEvent_SetY (byval self as wxStyledTextEvent ptr, byval val as integer)
declare sub wxStyledTextEvent_SetDragText (byval self as wxStyledTextEvent ptr, byval val as zstring ptr)
declare sub wxStyledTextEvent_SetDragAllowMove (byval self as wxStyledTextEvent ptr, byval val as integer)
declare sub wxStyledTextEvent_SetDragResult (byval self as wxStyledTextEvent ptr, byval val as wxDragResult)
declare function wxStyledTextEvent_GetPosition (byval self as wxStyledTextEvent ptr) as integer
declare function wxStyledTextEvent_GetKey (byval self as wxStyledTextEvent ptr) as integer
declare function wxStyledTextEvent_GetModifiers (byval self as wxStyledTextEvent ptr) as integer
declare function wxStyledTextEvent_GetModificationType (byval self as wxStyledTextEvent ptr) as integer
declare function wxStyledTextEvent_GetText (byval self as wxStyledTextEvent ptr) as wxString ptr
declare function wxStyledTextEvent_GetLength (byval self as wxStyledTextEvent ptr) as integer
declare function wxStyledTextEvent_GetLinesAdded (byval self as wxStyledTextEvent ptr) as integer
declare function wxStyledTextEvent_GetLine (byval self as wxStyledTextEvent ptr) as integer
declare function wxStyledTextEvent_GetFoldLevelNow (byval self as wxStyledTextEvent ptr) as integer
declare function wxStyledTextEvent_GetFoldLevelPrev (byval self as wxStyledTextEvent ptr) as integer
declare function wxStyledTextEvent_GetMargin (byval self as wxStyledTextEvent ptr) as integer
declare function wxStyledTextEvent_GetMessage (byval self as wxStyledTextEvent ptr) as integer
declare function wxStyledTextEvent_GetWParam (byval self as wxStyledTextEvent ptr) as integer
declare function wxStyledTextEvent_GetLParam (byval self as wxStyledTextEvent ptr) as integer
declare function wxStyledTextEvent_GetListType (byval self as wxStyledTextEvent ptr) as integer
declare function wxStyledTextEvent_GetX (byval self as wxStyledTextEvent ptr) as integer
declare function wxStyledTextEvent_GetY (byval self as wxStyledTextEvent ptr) as integer
declare function wxStyledTextEvent_GetDragText (byval self as wxStyledTextEvent ptr) as wxString ptr
declare function wxStyledTextEvent_GetDragAllowMove (byval self as wxStyledTextEvent ptr) as integer
declare function wxStyledTextEvent_GetDragResult (byval self as wxStyledTextEvent ptr) as wxDragResult ptr
declare function wxStyledTextEvent_GetShift (byval self as wxStyledTextEvent ptr) as integer
declare function wxStyledTextEvent_GetControl (byval self as wxStyledTextEvent ptr) as integer
declare function wxStyledTextEvent_GetAlt (byval self as wxStyledTextEvent ptr) as integer

#endif
