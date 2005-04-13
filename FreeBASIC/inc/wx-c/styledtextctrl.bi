''
''
'' styledtextctrl -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __styledtextctrl_bi__
#define __styledtextctrl_bi__

#include once "wx-c/wx.bi"

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

declare function wxStyledTextCtrl cdecl alias "wxStyledTextCtrl_ctor" (byval parent as wxWindow ptr, byval id as wxWindowID, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval name as string) as wxStyledTextCtrl ptr
declare sub wxStyledTextCtrl_AddText cdecl alias "wxStyledTextCtrl_AddText" (byval self as wxStyledTextCtrl ptr, byval text as string)
declare sub wxStyledTextCtrl_AddStyledText cdecl alias "wxStyledTextCtrl_AddStyledText" (byval self as wxStyledTextCtrl ptr, byval data as wxMemoryBuffer ptr)
declare sub wxStyledTextCtrl_InsertText cdecl alias "wxStyledTextCtrl_InsertText" (byval self as wxStyledTextCtrl ptr, byval pos as integer, byval text as string)
declare sub wxStyledTextCtrl_ClearAll cdecl alias "wxStyledTextCtrl_ClearAll" (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_ClearDocumentStyle cdecl alias "wxStyledTextCtrl_ClearDocumentStyle" (byval self as wxStyledTextCtrl ptr)
declare function wxStyledTextCtrl_GetLength cdecl alias "wxStyledTextCtrl_GetLength" (byval self as wxStyledTextCtrl ptr) as integer
declare function wxStyledTextCtrl_GetCharAt cdecl alias "wxStyledTextCtrl_GetCharAt" (byval self as wxStyledTextCtrl ptr, byval pos as integer) as integer
declare function wxStyledTextCtrl_GetCurrentPos cdecl alias "wxStyledTextCtrl_GetCurrentPos" (byval self as wxStyledTextCtrl ptr) as integer
declare function wxStyledTextCtrl_GetAnchor cdecl alias "wxStyledTextCtrl_GetAnchor" (byval self as wxStyledTextCtrl ptr) as integer
declare function wxStyledTextCtrl_GetStyleAt cdecl alias "wxStyledTextCtrl_GetStyleAt" (byval self as wxStyledTextCtrl ptr, byval pos as integer) as integer
declare sub wxStyledTextCtrl_Redo cdecl alias "wxStyledTextCtrl_Redo" (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_SetUndoCollection cdecl alias "wxStyledTextCtrl_SetUndoCollection" (byval self as wxStyledTextCtrl ptr, byval collectUndo as integer)
declare sub wxStyledTextCtrl_SelectAll cdecl alias "wxStyledTextCtrl_SelectAll" (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_SetSavePoint cdecl alias "wxStyledTextCtrl_SetSavePoint" (byval self as wxStyledTextCtrl ptr)
declare function wxStyledTextCtrl_GetStyledText cdecl alias "wxStyledTextCtrl_GetStyledText" (byval self as wxStyledTextCtrl ptr, byval startPos as integer, byval endPos as integer) as wxMemoryBuffer ptr
declare function wxStyledTextCtrl_CanRedo cdecl alias "wxStyledTextCtrl_CanRedo" (byval self as wxStyledTextCtrl ptr) as integer
declare function wxStyledTextCtrl_MarkerLineFromHandle cdecl alias "wxStyledTextCtrl_MarkerLineFromHandle" (byval self as wxStyledTextCtrl ptr, byval handle as integer) as integer
declare sub wxStyledTextCtrl_MarkerDeleteHandle cdecl alias "wxStyledTextCtrl_MarkerDeleteHandle" (byval self as wxStyledTextCtrl ptr, byval handle as integer)
declare function wxStyledTextCtrl_GetUndoCollection cdecl alias "wxStyledTextCtrl_GetUndoCollection" (byval self as wxStyledTextCtrl ptr) as integer
declare function wxStyledTextCtrl_GetViewWhiteSpace cdecl alias "wxStyledTextCtrl_GetViewWhiteSpace" (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetViewWhiteSpace cdecl alias "wxStyledTextCtrl_SetViewWhiteSpace" (byval self as wxStyledTextCtrl ptr, byval viewWS as integer)
declare function wxStyledTextCtrl_PositionFromPoint cdecl alias "wxStyledTextCtrl_PositionFromPoint" (byval self as wxStyledTextCtrl ptr, byval pt as wxPoint) as integer
declare function wxStyledTextCtrl_PositionFromPointClose cdecl alias "wxStyledTextCtrl_PositionFromPointClose" (byval self as wxStyledTextCtrl ptr, byval x as integer, byval y as integer) as integer
declare sub wxStyledTextCtrl_GotoLine cdecl alias "wxStyledTextCtrl_GotoLine" (byval self as wxStyledTextCtrl ptr, byval line as integer)
declare sub wxStyledTextCtrl_GotoPos cdecl alias "wxStyledTextCtrl_GotoPos" (byval self as wxStyledTextCtrl ptr, byval pos as integer)
declare sub wxStyledTextCtrl_SetAnchor cdecl alias "wxStyledTextCtrl_SetAnchor" (byval self as wxStyledTextCtrl ptr, byval posAnchor as integer)
declare function wxStyledTextCtrl_GetCurLine cdecl alias "wxStyledTextCtrl_GetCurLine" (byval self as wxStyledTextCtrl ptr, byval linePos as integer ptr) as wxString ptr
declare function wxStyledTextCtrl_GetEndStyled cdecl alias "wxStyledTextCtrl_GetEndStyled" (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_ConvertEOLs cdecl alias "wxStyledTextCtrl_ConvertEOLs" (byval self as wxStyledTextCtrl ptr, byval eolMode as integer)
declare function wxStyledTextCtrl_GetEOLMode cdecl alias "wxStyledTextCtrl_GetEOLMode" (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetEOLMode cdecl alias "wxStyledTextCtrl_SetEOLMode" (byval self as wxStyledTextCtrl ptr, byval eolMode as integer)
declare sub wxStyledTextCtrl_StartStyling cdecl alias "wxStyledTextCtrl_StartStyling" (byval self as wxStyledTextCtrl ptr, byval pos as integer, byval mask as integer)
declare sub wxStyledTextCtrl_SetStyling cdecl alias "wxStyledTextCtrl_SetStyling" (byval self as wxStyledTextCtrl ptr, byval length as integer, byval style as integer)
declare function wxStyledTextCtrl_GetBufferedDraw cdecl alias "wxStyledTextCtrl_GetBufferedDraw" (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetBufferedDraw cdecl alias "wxStyledTextCtrl_SetBufferedDraw" (byval self as wxStyledTextCtrl ptr, byval buffered as integer)
declare sub wxStyledTextCtrl_SetTabWidth cdecl alias "wxStyledTextCtrl_SetTabWidth" (byval self as wxStyledTextCtrl ptr, byval tabWidth as integer)
declare function wxStyledTextCtrl_GetTabWidth cdecl alias "wxStyledTextCtrl_GetTabWidth" (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetCodePage cdecl alias "wxStyledTextCtrl_SetCodePage" (byval self as wxStyledTextCtrl ptr, byval codePage as integer)
declare sub wxStyledTextCtrl_MarkerDefine cdecl alias "wxStyledTextCtrl_MarkerDefine" (byval self as wxStyledTextCtrl ptr, byval markerNumber as integer, byval markerSymbol as integer, byval foreground as wxColour ptr, byval background as wxColour ptr)
declare sub wxStyledTextCtrl_MarkerSetForeground cdecl alias "wxStyledTextCtrl_MarkerSetForeground" (byval self as wxStyledTextCtrl ptr, byval markerNumber as integer, byval fore as wxColour ptr)
declare sub wxStyledTextCtrl_MarkerSetBackground cdecl alias "wxStyledTextCtrl_MarkerSetBackground" (byval self as wxStyledTextCtrl ptr, byval markerNumber as integer, byval back as wxColour ptr)
declare function wxStyledTextCtrl_MarkerAdd cdecl alias "wxStyledTextCtrl_MarkerAdd" (byval self as wxStyledTextCtrl ptr, byval line as integer, byval markerNumber as integer) as integer
declare sub wxStyledTextCtrl_MarkerDelete cdecl alias "wxStyledTextCtrl_MarkerDelete" (byval self as wxStyledTextCtrl ptr, byval line as integer, byval markerNumber as integer)
declare sub wxStyledTextCtrl_MarkerDeleteAll cdecl alias "wxStyledTextCtrl_MarkerDeleteAll" (byval self as wxStyledTextCtrl ptr, byval markerNumber as integer)
declare function wxStyledTextCtrl_MarkerGet cdecl alias "wxStyledTextCtrl_MarkerGet" (byval self as wxStyledTextCtrl ptr, byval line as integer) as integer
declare function wxStyledTextCtrl_MarkerNext cdecl alias "wxStyledTextCtrl_MarkerNext" (byval self as wxStyledTextCtrl ptr, byval lineStart as integer, byval markerMask as integer) as integer
declare function wxStyledTextCtrl_MarkerPrevious cdecl alias "wxStyledTextCtrl_MarkerPrevious" (byval self as wxStyledTextCtrl ptr, byval lineStart as integer, byval markerMask as integer) as integer
declare sub wxStyledTextCtrl_MarkerDefineBitmap cdecl alias "wxStyledTextCtrl_MarkerDefineBitmap" (byval self as wxStyledTextCtrl ptr, byval markerNumber as integer, byval bmp as wxBitmap ptr)
declare sub wxStyledTextCtrl_SetMarginType cdecl alias "wxStyledTextCtrl_SetMarginType" (byval self as wxStyledTextCtrl ptr, byval margin as integer, byval marginType as integer)
declare function wxStyledTextCtrl_GetMarginType cdecl alias "wxStyledTextCtrl_GetMarginType" (byval self as wxStyledTextCtrl ptr, byval margin as integer) as integer
declare sub wxStyledTextCtrl_SetMarginWidth cdecl alias "wxStyledTextCtrl_SetMarginWidth" (byval self as wxStyledTextCtrl ptr, byval margin as integer, byval pixelWidth as integer)
declare function wxStyledTextCtrl_GetMarginWidth cdecl alias "wxStyledTextCtrl_GetMarginWidth" (byval self as wxStyledTextCtrl ptr, byval margin as integer) as integer
declare sub wxStyledTextCtrl_SetMarginMask cdecl alias "wxStyledTextCtrl_SetMarginMask" (byval self as wxStyledTextCtrl ptr, byval margin as integer, byval mask as integer)
declare function wxStyledTextCtrl_GetMarginMask cdecl alias "wxStyledTextCtrl_GetMarginMask" (byval self as wxStyledTextCtrl ptr, byval margin as integer) as integer
declare sub wxStyledTextCtrl_SetMarginSensitive cdecl alias "wxStyledTextCtrl_SetMarginSensitive" (byval self as wxStyledTextCtrl ptr, byval margin as integer, byval sensitive as integer)
declare function wxStyledTextCtrl_GetMarginSensitive cdecl alias "wxStyledTextCtrl_GetMarginSensitive" (byval self as wxStyledTextCtrl ptr, byval margin as integer) as integer
declare sub wxStyledTextCtrl_StyleClearAll cdecl alias "wxStyledTextCtrl_StyleClearAll" (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_StyleSetForeground cdecl alias "wxStyledTextCtrl_StyleSetForeground" (byval self as wxStyledTextCtrl ptr, byval style as integer, byval fore as wxColour ptr)
declare sub wxStyledTextCtrl_StyleSetBackground cdecl alias "wxStyledTextCtrl_StyleSetBackground" (byval self as wxStyledTextCtrl ptr, byval style as integer, byval back as wxColour ptr)
declare sub wxStyledTextCtrl_StyleSetBold cdecl alias "wxStyledTextCtrl_StyleSetBold" (byval self as wxStyledTextCtrl ptr, byval style as integer, byval bold as integer)
declare sub wxStyledTextCtrl_StyleSetItalic cdecl alias "wxStyledTextCtrl_StyleSetItalic" (byval self as wxStyledTextCtrl ptr, byval style as integer, byval italic as integer)
declare sub wxStyledTextCtrl_StyleSetSize cdecl alias "wxStyledTextCtrl_StyleSetSize" (byval self as wxStyledTextCtrl ptr, byval style as integer, byval sizePoints as integer)
declare sub wxStyledTextCtrl_StyleSetFaceName cdecl alias "wxStyledTextCtrl_StyleSetFaceName" (byval self as wxStyledTextCtrl ptr, byval style as integer, byval fontName as string)
declare sub wxStyledTextCtrl_StyleSetEOLFilled cdecl alias "wxStyledTextCtrl_StyleSetEOLFilled" (byval self as wxStyledTextCtrl ptr, byval style as integer, byval filled as integer)
declare sub wxStyledTextCtrl_StyleResetDefault cdecl alias "wxStyledTextCtrl_StyleResetDefault" (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_StyleSetUnderline cdecl alias "wxStyledTextCtrl_StyleSetUnderline" (byval self as wxStyledTextCtrl ptr, byval style as integer, byval underline as integer)
declare sub wxStyledTextCtrl_StyleSetCase cdecl alias "wxStyledTextCtrl_StyleSetCase" (byval self as wxStyledTextCtrl ptr, byval style as integer, byval caseForce as integer)
declare sub wxStyledTextCtrl_StyleSetCharacterSet cdecl alias "wxStyledTextCtrl_StyleSetCharacterSet" (byval self as wxStyledTextCtrl ptr, byval style as integer, byval characterSet as integer)
declare sub wxStyledTextCtrl_StyleSetHotSpot cdecl alias "wxStyledTextCtrl_StyleSetHotSpot" (byval self as wxStyledTextCtrl ptr, byval style as integer, byval hotspot as integer)
declare sub wxStyledTextCtrl_SetSelForeground cdecl alias "wxStyledTextCtrl_SetSelForeground" (byval self as wxStyledTextCtrl ptr, byval useSetting as integer, byval fore as wxColour ptr)
declare sub wxStyledTextCtrl_SetSelBackground cdecl alias "wxStyledTextCtrl_SetSelBackground" (byval self as wxStyledTextCtrl ptr, byval useSetting as integer, byval back as wxColour ptr)
declare sub wxStyledTextCtrl_SetCaretForeground cdecl alias "wxStyledTextCtrl_SetCaretForeground" (byval self as wxStyledTextCtrl ptr, byval fore as wxColour ptr)
declare sub wxStyledTextCtrl_CmdKeyAssign cdecl alias "wxStyledTextCtrl_CmdKeyAssign" (byval self as wxStyledTextCtrl ptr, byval key as integer, byval modifiers as integer, byval cmd as integer)
declare sub wxStyledTextCtrl_CmdKeyClear cdecl alias "wxStyledTextCtrl_CmdKeyClear" (byval self as wxStyledTextCtrl ptr, byval key as integer, byval modifiers as integer)
declare sub wxStyledTextCtrl_CmdKeyClearAll cdecl alias "wxStyledTextCtrl_CmdKeyClearAll" (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_SetStyleBytes cdecl alias "wxStyledTextCtrl_SetStyleBytes" (byval self as wxStyledTextCtrl ptr, byval length as integer, byval styleBytes as string)
declare sub wxStyledTextCtrl_StyleSetVisible cdecl alias "wxStyledTextCtrl_StyleSetVisible" (byval self as wxStyledTextCtrl ptr, byval style as integer, byval visible as integer)
declare function wxStyledTextCtrl_GetCaretPeriod cdecl alias "wxStyledTextCtrl_GetCaretPeriod" (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetCaretPeriod cdecl alias "wxStyledTextCtrl_SetCaretPeriod" (byval self as wxStyledTextCtrl ptr, byval periodMilliseconds as integer)
declare sub wxStyledTextCtrl_SetWordChars cdecl alias "wxStyledTextCtrl_SetWordChars" (byval self as wxStyledTextCtrl ptr, byval characters as string)
declare sub wxStyledTextCtrl_BeginUndoAction cdecl alias "wxStyledTextCtrl_BeginUndoAction" (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_EndUndoAction cdecl alias "wxStyledTextCtrl_EndUndoAction" (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_IndicatorSetStyle cdecl alias "wxStyledTextCtrl_IndicatorSetStyle" (byval self as wxStyledTextCtrl ptr, byval indic as integer, byval style as integer)
declare function wxStyledTextCtrl_IndicatorGetStyle cdecl alias "wxStyledTextCtrl_IndicatorGetStyle" (byval self as wxStyledTextCtrl ptr, byval indic as integer) as integer
declare sub wxStyledTextCtrl_IndicatorSetForeground cdecl alias "wxStyledTextCtrl_IndicatorSetForeground" (byval self as wxStyledTextCtrl ptr, byval indic as integer, byval fore as wxColour ptr)
declare function wxStyledTextCtrl_IndicatorGetForeground cdecl alias "wxStyledTextCtrl_IndicatorGetForeground" (byval self as wxStyledTextCtrl ptr, byval indic as integer) as wxColour ptr
declare sub wxStyledTextCtrl_SetWhitespaceForeground cdecl alias "wxStyledTextCtrl_SetWhitespaceForeground" (byval self as wxStyledTextCtrl ptr, byval useSetting as integer, byval fore as wxColour ptr)
declare sub wxStyledTextCtrl_SetWhitespaceBackground cdecl alias "wxStyledTextCtrl_SetWhitespaceBackground" (byval self as wxStyledTextCtrl ptr, byval useSetting as integer, byval back as wxColour ptr)
declare sub wxStyledTextCtrl_SetStyleBits cdecl alias "wxStyledTextCtrl_SetStyleBits" (byval self as wxStyledTextCtrl ptr, byval bits as integer)
declare function wxStyledTextCtrl_GetStyleBits cdecl alias "wxStyledTextCtrl_GetStyleBits" (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetLineState cdecl alias "wxStyledTextCtrl_SetLineState" (byval self as wxStyledTextCtrl ptr, byval line as integer, byval state as integer)
declare function wxStyledTextCtrl_GetLineState cdecl alias "wxStyledTextCtrl_GetLineState" (byval self as wxStyledTextCtrl ptr, byval line as integer) as integer
declare function wxStyledTextCtrl_GetMaxLineState cdecl alias "wxStyledTextCtrl_GetMaxLineState" (byval self as wxStyledTextCtrl ptr) as integer
declare function wxStyledTextCtrl_GetCaretLineVisible cdecl alias "wxStyledTextCtrl_GetCaretLineVisible" (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetCaretLineVisible cdecl alias "wxStyledTextCtrl_SetCaretLineVisible" (byval self as wxStyledTextCtrl ptr, byval show as integer)
declare function wxStyledTextCtrl_GetCaretLineBack cdecl alias "wxStyledTextCtrl_GetCaretLineBack" (byval self as wxStyledTextCtrl ptr) as wxColour ptr
declare sub wxStyledTextCtrl_SetCaretLineBack cdecl alias "wxStyledTextCtrl_SetCaretLineBack" (byval self as wxStyledTextCtrl ptr, byval back as wxColour ptr)
declare sub wxStyledTextCtrl_StyleSetChangeable cdecl alias "wxStyledTextCtrl_StyleSetChangeable" (byval self as wxStyledTextCtrl ptr, byval style as integer, byval changeable as integer)
declare sub wxStyledTextCtrl_AutoCompShow cdecl alias "wxStyledTextCtrl_AutoCompShow" (byval self as wxStyledTextCtrl ptr, byval lenEntered as integer, byval itemList as string)
declare sub wxStyledTextCtrl_AutoCompCancel cdecl alias "wxStyledTextCtrl_AutoCompCancel" (byval self as wxStyledTextCtrl ptr)
declare function wxStyledTextCtrl_AutoCompActive cdecl alias "wxStyledTextCtrl_AutoCompActive" (byval self as wxStyledTextCtrl ptr) as integer
declare function wxStyledTextCtrl_AutoCompPosStart cdecl alias "wxStyledTextCtrl_AutoCompPosStart" (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_AutoCompComplete cdecl alias "wxStyledTextCtrl_AutoCompComplete" (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_AutoCompStops cdecl alias "wxStyledTextCtrl_AutoCompStops" (byval self as wxStyledTextCtrl ptr, byval characterSet as string)
declare sub wxStyledTextCtrl_AutoCompSetSeparator cdecl alias "wxStyledTextCtrl_AutoCompSetSeparator" (byval self as wxStyledTextCtrl ptr, byval separatorCharacter as integer)
declare function wxStyledTextCtrl_AutoCompGetSeparator cdecl alias "wxStyledTextCtrl_AutoCompGetSeparator" (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_AutoCompSelect cdecl alias "wxStyledTextCtrl_AutoCompSelect" (byval self as wxStyledTextCtrl ptr, byval text as string)
declare sub wxStyledTextCtrl_AutoCompSetCancelAtStart cdecl alias "wxStyledTextCtrl_AutoCompSetCancelAtStart" (byval self as wxStyledTextCtrl ptr, byval cancel as integer)
declare function wxStyledTextCtrl_AutoCompGetCancelAtStart cdecl alias "wxStyledTextCtrl_AutoCompGetCancelAtStart" (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_AutoCompSetFillUps cdecl alias "wxStyledTextCtrl_AutoCompSetFillUps" (byval self as wxStyledTextCtrl ptr, byval characterSet as string)
declare sub wxStyledTextCtrl_AutoCompSetChooseSingle cdecl alias "wxStyledTextCtrl_AutoCompSetChooseSingle" (byval self as wxStyledTextCtrl ptr, byval chooseSingle as integer)
declare function wxStyledTextCtrl_AutoCompGetChooseSingle cdecl alias "wxStyledTextCtrl_AutoCompGetChooseSingle" (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_AutoCompSetIgnoreCase cdecl alias "wxStyledTextCtrl_AutoCompSetIgnoreCase" (byval self as wxStyledTextCtrl ptr, byval ignoreCase as integer)
declare function wxStyledTextCtrl_AutoCompGetIgnoreCase cdecl alias "wxStyledTextCtrl_AutoCompGetIgnoreCase" (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_UserListShow cdecl alias "wxStyledTextCtrl_UserListShow" (byval self as wxStyledTextCtrl ptr, byval listType as integer, byval itemList as string)
declare sub wxStyledTextCtrl_AutoCompSetAutoHide cdecl alias "wxStyledTextCtrl_AutoCompSetAutoHide" (byval self as wxStyledTextCtrl ptr, byval autoHide as integer)
declare function wxStyledTextCtrl_AutoCompGetAutoHide cdecl alias "wxStyledTextCtrl_AutoCompGetAutoHide" (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_AutoCompSetDropRestOfWord cdecl alias "wxStyledTextCtrl_AutoCompSetDropRestOfWord" (byval self as wxStyledTextCtrl ptr, byval dropRestOfWord as integer)
declare function wxStyledTextCtrl_AutoCompGetDropRestOfWord cdecl alias "wxStyledTextCtrl_AutoCompGetDropRestOfWord" (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_RegisterImage cdecl alias "wxStyledTextCtrl_RegisterImage" (byval self as wxStyledTextCtrl ptr, byval type as integer, byval bmp as wxBitmap ptr)
declare sub wxStyledTextCtrl_ClearRegisteredImages cdecl alias "wxStyledTextCtrl_ClearRegisteredImages" (byval self as wxStyledTextCtrl ptr)
declare function wxStyledTextCtrl_AutoCompGetTypeSeparator cdecl alias "wxStyledTextCtrl_AutoCompGetTypeSeparator" (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_AutoCompSetTypeSeparator cdecl alias "wxStyledTextCtrl_AutoCompSetTypeSeparator" (byval self as wxStyledTextCtrl ptr, byval separatorCharacter as integer)
declare sub wxStyledTextCtrl_SetIndent cdecl alias "wxStyledTextCtrl_SetIndent" (byval self as wxStyledTextCtrl ptr, byval indentSize as integer)
declare function wxStyledTextCtrl_GetIndent cdecl alias "wxStyledTextCtrl_GetIndent" (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetUseTabs cdecl alias "wxStyledTextCtrl_SetUseTabs" (byval self as wxStyledTextCtrl ptr, byval useTabs as integer)
declare function wxStyledTextCtrl_GetUseTabs cdecl alias "wxStyledTextCtrl_GetUseTabs" (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetLineIndentation cdecl alias "wxStyledTextCtrl_SetLineIndentation" (byval self as wxStyledTextCtrl ptr, byval line as integer, byval indentSize as integer)
declare function wxStyledTextCtrl_GetLineIndentation cdecl alias "wxStyledTextCtrl_GetLineIndentation" (byval self as wxStyledTextCtrl ptr, byval line as integer) as integer
declare function wxStyledTextCtrl_GetLineIndentPosition cdecl alias "wxStyledTextCtrl_GetLineIndentPosition" (byval self as wxStyledTextCtrl ptr, byval line as integer) as integer
declare function wxStyledTextCtrl_GetColumn cdecl alias "wxStyledTextCtrl_GetColumn" (byval self as wxStyledTextCtrl ptr, byval pos as integer) as integer
declare sub wxStyledTextCtrl_SetUseHorizontalScrollBar cdecl alias "wxStyledTextCtrl_SetUseHorizontalScrollBar" (byval self as wxStyledTextCtrl ptr, byval show as integer)
declare function wxStyledTextCtrl_GetUseHorizontalScrollBar cdecl alias "wxStyledTextCtrl_GetUseHorizontalScrollBar" (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetIndentationGuides cdecl alias "wxStyledTextCtrl_SetIndentationGuides" (byval self as wxStyledTextCtrl ptr, byval show as integer)
declare function wxStyledTextCtrl_GetIndentationGuides cdecl alias "wxStyledTextCtrl_GetIndentationGuides" (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetHighlightGuide cdecl alias "wxStyledTextCtrl_SetHighlightGuide" (byval self as wxStyledTextCtrl ptr, byval column as integer)
declare function wxStyledTextCtrl_GetHighlightGuide cdecl alias "wxStyledTextCtrl_GetHighlightGuide" (byval self as wxStyledTextCtrl ptr) as integer
declare function wxStyledTextCtrl_GetLineEndPosition cdecl alias "wxStyledTextCtrl_GetLineEndPosition" (byval self as wxStyledTextCtrl ptr, byval line as integer) as integer
declare function wxStyledTextCtrl_GetCodePage cdecl alias "wxStyledTextCtrl_GetCodePage" (byval self as wxStyledTextCtrl ptr) as integer
declare function wxStyledTextCtrl_GetCaretForeground cdecl alias "wxStyledTextCtrl_GetCaretForeground" (byval self as wxStyledTextCtrl ptr) as wxColour ptr
declare function wxStyledTextCtrl_GetReadOnly cdecl alias "wxStyledTextCtrl_GetReadOnly" (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetCurrentPos cdecl alias "wxStyledTextCtrl_SetCurrentPos" (byval self as wxStyledTextCtrl ptr, byval pos as integer)
declare sub wxStyledTextCtrl_SetSelectionStart cdecl alias "wxStyledTextCtrl_SetSelectionStart" (byval self as wxStyledTextCtrl ptr, byval pos as integer)
declare function wxStyledTextCtrl_GetSelectionStart cdecl alias "wxStyledTextCtrl_GetSelectionStart" (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetSelectionEnd cdecl alias "wxStyledTextCtrl_SetSelectionEnd" (byval self as wxStyledTextCtrl ptr, byval pos as integer)
declare function wxStyledTextCtrl_GetSelectionEnd cdecl alias "wxStyledTextCtrl_GetSelectionEnd" (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetPrintMagnification cdecl alias "wxStyledTextCtrl_SetPrintMagnification" (byval self as wxStyledTextCtrl ptr, byval magnification as integer)
declare function wxStyledTextCtrl_GetPrintMagnification cdecl alias "wxStyledTextCtrl_GetPrintMagnification" (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetPrintColourMode cdecl alias "wxStyledTextCtrl_SetPrintColourMode" (byval self as wxStyledTextCtrl ptr, byval mode as integer)
declare function wxStyledTextCtrl_GetPrintColourMode cdecl alias "wxStyledTextCtrl_GetPrintColourMode" (byval self as wxStyledTextCtrl ptr) as integer
declare function wxStyledTextCtrl_FindText cdecl alias "wxStyledTextCtrl_FindText" (byval self as wxStyledTextCtrl ptr, byval minPos as integer, byval maxPos as integer, byval text as string, byval flags as integer) as integer
declare function wxStyledTextCtrl_FormatRange cdecl alias "wxStyledTextCtrl_FormatRange" (byval self as wxStyledTextCtrl ptr, byval doDraw as integer, byval startPos as integer, byval endPos as integer, byval draw as wxDC ptr, byval target as wxDC ptr, byval renderRect as wxRect, byval pageRect as wxRect) as integer
declare function wxStyledTextCtrl_GetFirstVisibleLine cdecl alias "wxStyledTextCtrl_GetFirstVisibleLine" (byval self as wxStyledTextCtrl ptr) as integer
declare function wxStyledTextCtrl_GetLine cdecl alias "wxStyledTextCtrl_GetLine" (byval self as wxStyledTextCtrl ptr, byval line as integer) as wxString ptr
declare function wxStyledTextCtrl_GetLineCount cdecl alias "wxStyledTextCtrl_GetLineCount" (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetMarginLeft cdecl alias "wxStyledTextCtrl_SetMarginLeft" (byval self as wxStyledTextCtrl ptr, byval pixelWidth as integer)
declare function wxStyledTextCtrl_GetMarginLeft cdecl alias "wxStyledTextCtrl_GetMarginLeft" (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetMarginRight cdecl alias "wxStyledTextCtrl_SetMarginRight" (byval self as wxStyledTextCtrl ptr, byval pixelWidth as integer)
declare function wxStyledTextCtrl_GetMarginRight cdecl alias "wxStyledTextCtrl_GetMarginRight" (byval self as wxStyledTextCtrl ptr) as integer
declare function wxStyledTextCtrl_GetModify cdecl alias "wxStyledTextCtrl_GetModify" (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetSelection cdecl alias "wxStyledTextCtrl_SetSelection" (byval self as wxStyledTextCtrl ptr, byval start as integer, byval end as integer)
declare function wxStyledTextCtrl_GetSelectedText cdecl alias "wxStyledTextCtrl_GetSelectedText" (byval self as wxStyledTextCtrl ptr) as wxString ptr
declare function wxStyledTextCtrl_GetTextRange cdecl alias "wxStyledTextCtrl_GetTextRange" (byval self as wxStyledTextCtrl ptr, byval startPos as integer, byval endPos as integer) as wxString ptr
declare sub wxStyledTextCtrl_HideSelection cdecl alias "wxStyledTextCtrl_HideSelection" (byval self as wxStyledTextCtrl ptr, byval normal as integer)
declare function wxStyledTextCtrl_LineFromPosition cdecl alias "wxStyledTextCtrl_LineFromPosition" (byval self as wxStyledTextCtrl ptr, byval pos as integer) as integer
declare function wxStyledTextCtrl_PositionFromLine cdecl alias "wxStyledTextCtrl_PositionFromLine" (byval self as wxStyledTextCtrl ptr, byval line as integer) as integer
declare sub wxStyledTextCtrl_LineScroll cdecl alias "wxStyledTextCtrl_LineScroll" (byval self as wxStyledTextCtrl ptr, byval columns as integer, byval lines as integer)
declare sub wxStyledTextCtrl_EnsureCaretVisible cdecl alias "wxStyledTextCtrl_EnsureCaretVisible" (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_ReplaceSelection cdecl alias "wxStyledTextCtrl_ReplaceSelection" (byval self as wxStyledTextCtrl ptr, byval text as string)
declare sub wxStyledTextCtrl_SetReadOnly cdecl alias "wxStyledTextCtrl_SetReadOnly" (byval self as wxStyledTextCtrl ptr, byval readOnly as integer)
declare function wxStyledTextCtrl_CanPaste cdecl alias "wxStyledTextCtrl_CanPaste" (byval self as wxStyledTextCtrl ptr) as integer
declare function wxStyledTextCtrl_CanUndo cdecl alias "wxStyledTextCtrl_CanUndo" (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_EmptyUndoBuffer cdecl alias "wxStyledTextCtrl_EmptyUndoBuffer" (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_Undo cdecl alias "wxStyledTextCtrl_Undo" (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_Cut cdecl alias "wxStyledTextCtrl_Cut" (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_Copy cdecl alias "wxStyledTextCtrl_Copy" (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_Paste cdecl alias "wxStyledTextCtrl_Paste" (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_Clear cdecl alias "wxStyledTextCtrl_Clear" (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_SetText cdecl alias "wxStyledTextCtrl_SetText" (byval self as wxStyledTextCtrl ptr, byval text as string)
declare function wxStyledTextCtrl_GetText cdecl alias "wxStyledTextCtrl_GetText" (byval self as wxStyledTextCtrl ptr) as wxString ptr
declare function wxStyledTextCtrl_GetTextLength cdecl alias "wxStyledTextCtrl_GetTextLength" (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetOvertype cdecl alias "wxStyledTextCtrl_SetOvertype" (byval self as wxStyledTextCtrl ptr, byval overtype as integer)
declare function wxStyledTextCtrl_GetOvertype cdecl alias "wxStyledTextCtrl_GetOvertype" (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetCaretWidth cdecl alias "wxStyledTextCtrl_SetCaretWidth" (byval self as wxStyledTextCtrl ptr, byval pixelWidth as integer)
declare function wxStyledTextCtrl_GetCaretWidth cdecl alias "wxStyledTextCtrl_GetCaretWidth" (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetTargetStart cdecl alias "wxStyledTextCtrl_SetTargetStart" (byval self as wxStyledTextCtrl ptr, byval pos as integer)
declare function wxStyledTextCtrl_GetTargetStart cdecl alias "wxStyledTextCtrl_GetTargetStart" (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetTargetEnd cdecl alias "wxStyledTextCtrl_SetTargetEnd" (byval self as wxStyledTextCtrl ptr, byval pos as integer)
declare function wxStyledTextCtrl_GetTargetEnd cdecl alias "wxStyledTextCtrl_GetTargetEnd" (byval self as wxStyledTextCtrl ptr) as integer
declare function wxStyledTextCtrl_ReplaceTarget cdecl alias "wxStyledTextCtrl_ReplaceTarget" (byval self as wxStyledTextCtrl ptr, byval text as string) as integer
declare function wxStyledTextCtrl_ReplaceTargetRE cdecl alias "wxStyledTextCtrl_ReplaceTargetRE" (byval self as wxStyledTextCtrl ptr, byval text as string) as integer
declare function wxStyledTextCtrl_SearchInTarget cdecl alias "wxStyledTextCtrl_SearchInTarget" (byval self as wxStyledTextCtrl ptr, byval text as string) as integer
declare sub wxStyledTextCtrl_SetSearchFlags cdecl alias "wxStyledTextCtrl_SetSearchFlags" (byval self as wxStyledTextCtrl ptr, byval flags as integer)
declare function wxStyledTextCtrl_GetSearchFlags cdecl alias "wxStyledTextCtrl_GetSearchFlags" (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_CallTipShow cdecl alias "wxStyledTextCtrl_CallTipShow" (byval self as wxStyledTextCtrl ptr, byval pos as integer, byval definition as string)
declare sub wxStyledTextCtrl_CallTipCancel cdecl alias "wxStyledTextCtrl_CallTipCancel" (byval self as wxStyledTextCtrl ptr)
declare function wxStyledTextCtrl_CallTipActive cdecl alias "wxStyledTextCtrl_CallTipActive" (byval self as wxStyledTextCtrl ptr) as integer
declare function wxStyledTextCtrl_CallTipPosAtStart cdecl alias "wxStyledTextCtrl_CallTipPosAtStart" (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_CallTipSetHighlight cdecl alias "wxStyledTextCtrl_CallTipSetHighlight" (byval self as wxStyledTextCtrl ptr, byval start as integer, byval end as integer)
declare sub wxStyledTextCtrl_CallTipSetBackground cdecl alias "wxStyledTextCtrl_CallTipSetBackground" (byval self as wxStyledTextCtrl ptr, byval back as wxColour ptr)
declare sub wxStyledTextCtrl_CallTipSetForeground cdecl alias "wxStyledTextCtrl_CallTipSetForeground" (byval self as wxStyledTextCtrl ptr, byval fore as wxColour ptr)
declare sub wxStyledTextCtrl_CallTipSetForegroundHighlight cdecl alias "wxStyledTextCtrl_CallTipSetForegroundHighlight" (byval self as wxStyledTextCtrl ptr, byval fore as wxColour ptr)
declare function wxStyledTextCtrl_VisibleFromDocLine cdecl alias "wxStyledTextCtrl_VisibleFromDocLine" (byval self as wxStyledTextCtrl ptr, byval line as integer) as integer
declare function wxStyledTextCtrl_DocLineFromVisible cdecl alias "wxStyledTextCtrl_DocLineFromVisible" (byval self as wxStyledTextCtrl ptr, byval lineDisplay as integer) as integer
declare sub wxStyledTextCtrl_SetFoldLevel cdecl alias "wxStyledTextCtrl_SetFoldLevel" (byval self as wxStyledTextCtrl ptr, byval line as integer, byval level as integer)
declare function wxStyledTextCtrl_GetFoldLevel cdecl alias "wxStyledTextCtrl_GetFoldLevel" (byval self as wxStyledTextCtrl ptr, byval line as integer) as integer
declare function wxStyledTextCtrl_GetLastChild cdecl alias "wxStyledTextCtrl_GetLastChild" (byval self as wxStyledTextCtrl ptr, byval line as integer, byval level as integer) as integer
declare function wxStyledTextCtrl_GetFoldParent cdecl alias "wxStyledTextCtrl_GetFoldParent" (byval self as wxStyledTextCtrl ptr, byval line as integer) as integer
declare sub wxStyledTextCtrl_ShowLines cdecl alias "wxStyledTextCtrl_ShowLines" (byval self as wxStyledTextCtrl ptr, byval lineStart as integer, byval lineEnd as integer)
declare sub wxStyledTextCtrl_HideLines cdecl alias "wxStyledTextCtrl_HideLines" (byval self as wxStyledTextCtrl ptr, byval lineStart as integer, byval lineEnd as integer)
declare function wxStyledTextCtrl_GetLineVisible cdecl alias "wxStyledTextCtrl_GetLineVisible" (byval self as wxStyledTextCtrl ptr, byval line as integer) as integer
declare sub wxStyledTextCtrl_SetFoldExpanded cdecl alias "wxStyledTextCtrl_SetFoldExpanded" (byval self as wxStyledTextCtrl ptr, byval line as integer, byval expanded as integer)
declare function wxStyledTextCtrl_GetFoldExpanded cdecl alias "wxStyledTextCtrl_GetFoldExpanded" (byval self as wxStyledTextCtrl ptr, byval line as integer) as integer
declare sub wxStyledTextCtrl_ToggleFold cdecl alias "wxStyledTextCtrl_ToggleFold" (byval self as wxStyledTextCtrl ptr, byval line as integer)
declare sub wxStyledTextCtrl_EnsureVisible cdecl alias "wxStyledTextCtrl_EnsureVisible" (byval self as wxStyledTextCtrl ptr, byval line as integer)
declare sub wxStyledTextCtrl_SetFoldFlags cdecl alias "wxStyledTextCtrl_SetFoldFlags" (byval self as wxStyledTextCtrl ptr, byval flags as integer)
declare sub wxStyledTextCtrl_EnsureVisibleEnforcePolicy cdecl alias "wxStyledTextCtrl_EnsureVisibleEnforcePolicy" (byval self as wxStyledTextCtrl ptr, byval line as integer)
declare sub wxStyledTextCtrl_SetTabIndents cdecl alias "wxStyledTextCtrl_SetTabIndents" (byval self as wxStyledTextCtrl ptr, byval tabIndents as integer)
declare function wxStyledTextCtrl_GetTabIndents cdecl alias "wxStyledTextCtrl_GetTabIndents" (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetBackSpaceUnIndents cdecl alias "wxStyledTextCtrl_SetBackSpaceUnIndents" (byval self as wxStyledTextCtrl ptr, byval bsUnIndents as integer)
declare function wxStyledTextCtrl_GetBackSpaceUnIndents cdecl alias "wxStyledTextCtrl_GetBackSpaceUnIndents" (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetMouseDwellTime cdecl alias "wxStyledTextCtrl_SetMouseDwellTime" (byval self as wxStyledTextCtrl ptr, byval periodMilliseconds as integer)
declare function wxStyledTextCtrl_GetMouseDwellTime cdecl alias "wxStyledTextCtrl_GetMouseDwellTime" (byval self as wxStyledTextCtrl ptr) as integer
declare function wxStyledTextCtrl_WordStartPosition cdecl alias "wxStyledTextCtrl_WordStartPosition" (byval self as wxStyledTextCtrl ptr, byval pos as integer, byval onlyWordCharacters as integer) as integer
declare function wxStyledTextCtrl_WordEndPosition cdecl alias "wxStyledTextCtrl_WordEndPosition" (byval self as wxStyledTextCtrl ptr, byval pos as integer, byval onlyWordCharacters as integer) as integer
declare sub wxStyledTextCtrl_SetWrapMode cdecl alias "wxStyledTextCtrl_SetWrapMode" (byval self as wxStyledTextCtrl ptr, byval mode as integer)
declare function wxStyledTextCtrl_GetWrapMode cdecl alias "wxStyledTextCtrl_GetWrapMode" (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetLayoutCache cdecl alias "wxStyledTextCtrl_SetLayoutCache" (byval self as wxStyledTextCtrl ptr, byval mode as integer)
declare function wxStyledTextCtrl_GetLayoutCache cdecl alias "wxStyledTextCtrl_GetLayoutCache" (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetScrollWidth cdecl alias "wxStyledTextCtrl_SetScrollWidth" (byval self as wxStyledTextCtrl ptr, byval pixelWidth as integer)
declare function wxStyledTextCtrl_GetScrollWidth cdecl alias "wxStyledTextCtrl_GetScrollWidth" (byval self as wxStyledTextCtrl ptr) as integer
declare function wxStyledTextCtrl_TextWidth cdecl alias "wxStyledTextCtrl_TextWidth" (byval self as wxStyledTextCtrl ptr, byval style as integer, byval text as string) as integer
declare sub wxStyledTextCtrl_SetEndAtLastLine cdecl alias "wxStyledTextCtrl_SetEndAtLastLine" (byval self as wxStyledTextCtrl ptr, byval endAtLastLine as integer)
declare function wxStyledTextCtrl_GetEndAtLastLine cdecl alias "wxStyledTextCtrl_GetEndAtLastLine" (byval self as wxStyledTextCtrl ptr) as integer
declare function wxStyledTextCtrl_TextHeight cdecl alias "wxStyledTextCtrl_TextHeight" (byval self as wxStyledTextCtrl ptr, byval line as integer) as integer
declare sub wxStyledTextCtrl_SetUseVerticalScrollBar cdecl alias "wxStyledTextCtrl_SetUseVerticalScrollBar" (byval self as wxStyledTextCtrl ptr, byval show as integer)
declare function wxStyledTextCtrl_GetUseVerticalScrollBar cdecl alias "wxStyledTextCtrl_GetUseVerticalScrollBar" (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_AppendText cdecl alias "wxStyledTextCtrl_AppendText" (byval self as wxStyledTextCtrl ptr, byval length as integer, byval text as string)
declare function wxStyledTextCtrl_GetTwoPhaseDraw cdecl alias "wxStyledTextCtrl_GetTwoPhaseDraw" (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetTwoPhaseDraw cdecl alias "wxStyledTextCtrl_SetTwoPhaseDraw" (byval self as wxStyledTextCtrl ptr, byval twoPhase as integer)
declare sub wxStyledTextCtrl_TargetFromSelection cdecl alias "wxStyledTextCtrl_TargetFromSelection" (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_LinesJoin cdecl alias "wxStyledTextCtrl_LinesJoin" (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_LinesSplit cdecl alias "wxStyledTextCtrl_LinesSplit" (byval self as wxStyledTextCtrl ptr, byval pixelWidth as integer)
declare sub wxStyledTextCtrl_SetFoldMarginColour cdecl alias "wxStyledTextCtrl_SetFoldMarginColour" (byval self as wxStyledTextCtrl ptr, byval useSetting as integer, byval back as wxColour ptr)
declare sub wxStyledTextCtrl_SetFoldMarginHiColour cdecl alias "wxStyledTextCtrl_SetFoldMarginHiColour" (byval self as wxStyledTextCtrl ptr, byval useSetting as integer, byval fore as wxColour ptr)
declare sub wxStyledTextCtrl_LineDuplicate cdecl alias "wxStyledTextCtrl_LineDuplicate" (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_HomeDisplay cdecl alias "wxStyledTextCtrl_HomeDisplay" (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_HomeDisplayExtend cdecl alias "wxStyledTextCtrl_HomeDisplayExtend" (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_LineEndDisplay cdecl alias "wxStyledTextCtrl_LineEndDisplay" (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_LineEndDisplayExtend cdecl alias "wxStyledTextCtrl_LineEndDisplayExtend" (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_MoveCaretInsideView cdecl alias "wxStyledTextCtrl_MoveCaretInsideView" (byval self as wxStyledTextCtrl ptr)
declare function wxStyledTextCtrl_LineLength cdecl alias "wxStyledTextCtrl_LineLength" (byval self as wxStyledTextCtrl ptr, byval line as integer) as integer
declare sub wxStyledTextCtrl_BraceHighlight cdecl alias "wxStyledTextCtrl_BraceHighlight" (byval self as wxStyledTextCtrl ptr, byval pos1 as integer, byval pos2 as integer)
declare sub wxStyledTextCtrl_BraceBadLight cdecl alias "wxStyledTextCtrl_BraceBadLight" (byval self as wxStyledTextCtrl ptr, byval pos as integer)
declare function wxStyledTextCtrl_BraceMatch cdecl alias "wxStyledTextCtrl_BraceMatch" (byval self as wxStyledTextCtrl ptr, byval pos as integer) as integer
declare function wxStyledTextCtrl_GetViewEOL cdecl alias "wxStyledTextCtrl_GetViewEOL" (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetViewEOL cdecl alias "wxStyledTextCtrl_SetViewEOL" (byval self as wxStyledTextCtrl ptr, byval visible as integer)
declare sub wxStyledTextCtrl_GetDocPointer cdecl alias "wxStyledTextCtrl_GetDocPointer" (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_SetDocPointer cdecl alias "wxStyledTextCtrl_SetDocPointer" (byval self as wxStyledTextCtrl ptr, byval docPointer as any ptr)
declare sub wxStyledTextCtrl_SetModEventMask cdecl alias "wxStyledTextCtrl_SetModEventMask" (byval self as wxStyledTextCtrl ptr, byval mask as integer)
declare function wxStyledTextCtrl_GetEdgeColumn cdecl alias "wxStyledTextCtrl_GetEdgeColumn" (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetEdgeColumn cdecl alias "wxStyledTextCtrl_SetEdgeColumn" (byval self as wxStyledTextCtrl ptr, byval column as integer)
declare function wxStyledTextCtrl_GetEdgeMode cdecl alias "wxStyledTextCtrl_GetEdgeMode" (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetEdgeMode cdecl alias "wxStyledTextCtrl_SetEdgeMode" (byval self as wxStyledTextCtrl ptr, byval mode as integer)
declare function wxStyledTextCtrl_GetEdgeColour cdecl alias "wxStyledTextCtrl_GetEdgeColour" (byval self as wxStyledTextCtrl ptr) as wxColour ptr
declare sub wxStyledTextCtrl_SetEdgeColour cdecl alias "wxStyledTextCtrl_SetEdgeColour" (byval self as wxStyledTextCtrl ptr, byval edgeColour as wxColour ptr)
declare sub wxStyledTextCtrl_SearchAnchor cdecl alias "wxStyledTextCtrl_SearchAnchor" (byval self as wxStyledTextCtrl ptr)
declare function wxStyledTextCtrl_SearchNext cdecl alias "wxStyledTextCtrl_SearchNext" (byval self as wxStyledTextCtrl ptr, byval flags as integer, byval text as string) as integer
declare function wxStyledTextCtrl_SearchPrev cdecl alias "wxStyledTextCtrl_SearchPrev" (byval self as wxStyledTextCtrl ptr, byval flags as integer, byval text as string) as integer
declare function wxStyledTextCtrl_LinesOnScreen cdecl alias "wxStyledTextCtrl_LinesOnScreen" (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_UsePopUp cdecl alias "wxStyledTextCtrl_UsePopUp" (byval self as wxStyledTextCtrl ptr, byval allowPopUp as integer)
declare function wxStyledTextCtrl_SelectionIsRectangle cdecl alias "wxStyledTextCtrl_SelectionIsRectangle" (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetZoom cdecl alias "wxStyledTextCtrl_SetZoom" (byval self as wxStyledTextCtrl ptr, byval zoom as integer)
declare function wxStyledTextCtrl_GetZoom cdecl alias "wxStyledTextCtrl_GetZoom" (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_CreateDocument cdecl alias "wxStyledTextCtrl_CreateDocument" (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_AddRefDocument cdecl alias "wxStyledTextCtrl_AddRefDocument" (byval self as wxStyledTextCtrl ptr, byval docPointer as any ptr)
declare sub wxStyledTextCtrl_ReleaseDocument cdecl alias "wxStyledTextCtrl_ReleaseDocument" (byval self as wxStyledTextCtrl ptr, byval docPointer as any ptr)
declare function wxStyledTextCtrl_GetModEventMask cdecl alias "wxStyledTextCtrl_GetModEventMask" (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetSTCFocus cdecl alias "wxStyledTextCtrl_SetSTCFocus" (byval self as wxStyledTextCtrl ptr, byval focus as integer)
declare function wxStyledTextCtrl_GetSTCFocus cdecl alias "wxStyledTextCtrl_GetSTCFocus" (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetStatus cdecl alias "wxStyledTextCtrl_SetStatus" (byval self as wxStyledTextCtrl ptr, byval statusCode as integer)
declare function wxStyledTextCtrl_GetStatus cdecl alias "wxStyledTextCtrl_GetStatus" (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetMouseDownCaptures cdecl alias "wxStyledTextCtrl_SetMouseDownCaptures" (byval self as wxStyledTextCtrl ptr, byval captures as integer)
declare function wxStyledTextCtrl_GetMouseDownCaptures cdecl alias "wxStyledTextCtrl_GetMouseDownCaptures" (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetSTCCursor cdecl alias "wxStyledTextCtrl_SetSTCCursor" (byval self as wxStyledTextCtrl ptr, byval cursorType as integer)
declare function wxStyledTextCtrl_GetSTCCursor cdecl alias "wxStyledTextCtrl_GetSTCCursor" (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetControlCharSymbol cdecl alias "wxStyledTextCtrl_SetControlCharSymbol" (byval self as wxStyledTextCtrl ptr, byval symbol as integer)
declare function wxStyledTextCtrl_GetControlCharSymbol cdecl alias "wxStyledTextCtrl_GetControlCharSymbol" (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_WordPartLeft cdecl alias "wxStyledTextCtrl_WordPartLeft" (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_WordPartLeftExtend cdecl alias "wxStyledTextCtrl_WordPartLeftExtend" (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_WordPartRight cdecl alias "wxStyledTextCtrl_WordPartRight" (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_WordPartRightExtend cdecl alias "wxStyledTextCtrl_WordPartRightExtend" (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_SetVisiblePolicy cdecl alias "wxStyledTextCtrl_SetVisiblePolicy" (byval self as wxStyledTextCtrl ptr, byval visiblePolicy as integer, byval visibleSlop as integer)
declare sub wxStyledTextCtrl_DelLineLeft cdecl alias "wxStyledTextCtrl_DelLineLeft" (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_DelLineRight cdecl alias "wxStyledTextCtrl_DelLineRight" (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_SetXOffset cdecl alias "wxStyledTextCtrl_SetXOffset" (byval self as wxStyledTextCtrl ptr, byval newOffset as integer)
declare function wxStyledTextCtrl_GetXOffset cdecl alias "wxStyledTextCtrl_GetXOffset" (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_ChooseCaretX cdecl alias "wxStyledTextCtrl_ChooseCaretX" (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_SetXCaretPolicy cdecl alias "wxStyledTextCtrl_SetXCaretPolicy" (byval self as wxStyledTextCtrl ptr, byval caretPolicy as integer, byval caretSlop as integer)
declare sub wxStyledTextCtrl_SetYCaretPolicy cdecl alias "wxStyledTextCtrl_SetYCaretPolicy" (byval self as wxStyledTextCtrl ptr, byval caretPolicy as integer, byval caretSlop as integer)
declare sub wxStyledTextCtrl_SetPrintWrapMode cdecl alias "wxStyledTextCtrl_SetPrintWrapMode" (byval self as wxStyledTextCtrl ptr, byval mode as integer)
declare function wxStyledTextCtrl_GetPrintWrapMode cdecl alias "wxStyledTextCtrl_GetPrintWrapMode" (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetHotspotActiveForeground cdecl alias "wxStyledTextCtrl_SetHotspotActiveForeground" (byval self as wxStyledTextCtrl ptr, byval useSetting as integer, byval fore as wxColour ptr)
declare sub wxStyledTextCtrl_SetHotspotActiveBackground cdecl alias "wxStyledTextCtrl_SetHotspotActiveBackground" (byval self as wxStyledTextCtrl ptr, byval useSetting as integer, byval back as wxColour ptr)
declare sub wxStyledTextCtrl_SetHotspotActiveUnderline cdecl alias "wxStyledTextCtrl_SetHotspotActiveUnderline" (byval self as wxStyledTextCtrl ptr, byval underline as integer)
declare sub wxStyledTextCtrl_StartRecord cdecl alias "wxStyledTextCtrl_StartRecord" (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_StopRecord cdecl alias "wxStyledTextCtrl_StopRecord" (byval self as wxStyledTextCtrl ptr)
declare sub wxStyledTextCtrl_SetLexer cdecl alias "wxStyledTextCtrl_SetLexer" (byval self as wxStyledTextCtrl ptr, byval lexer as integer)
declare function wxStyledTextCtrl_GetLexer cdecl alias "wxStyledTextCtrl_GetLexer" (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_Colourise cdecl alias "wxStyledTextCtrl_Colourise" (byval self as wxStyledTextCtrl ptr, byval start as integer, byval end as integer)
declare sub wxStyledTextCtrl_SetProperty cdecl alias "wxStyledTextCtrl_SetProperty" (byval self as wxStyledTextCtrl ptr, byval key as string, byval value as string)
declare sub wxStyledTextCtrl_SetKeyWords cdecl alias "wxStyledTextCtrl_SetKeyWords" (byval self as wxStyledTextCtrl ptr, byval keywordSet as integer, byval keyWords as string)
declare sub wxStyledTextCtrl_SetLexerLanguage cdecl alias "wxStyledTextCtrl_SetLexerLanguage" (byval self as wxStyledTextCtrl ptr, byval language as string)
declare function wxStyledTextCtrl_GetCurrentLine cdecl alias "wxStyledTextCtrl_GetCurrentLine" (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_StyleSetSpec cdecl alias "wxStyledTextCtrl_StyleSetSpec" (byval self as wxStyledTextCtrl ptr, byval styleNum as integer, byval spec as string)
declare sub wxStyledTextCtrl_StyleSetFont cdecl alias "wxStyledTextCtrl_StyleSetFont" (byval self as wxStyledTextCtrl ptr, byval styleNum as integer, byval font as wxFont ptr)
declare sub wxStyledTextCtrl_StyleSetFontAttr cdecl alias "wxStyledTextCtrl_StyleSetFontAttr" (byval self as wxStyledTextCtrl ptr, byval styleNum as integer, byval size as integer, byval faceName as string, byval bold as integer, byval italic as integer, byval underline as integer)
declare sub wxStyledTextCtrl_CmdKeyExecute cdecl alias "wxStyledTextCtrl_CmdKeyExecute" (byval self as wxStyledTextCtrl ptr, byval cmd as integer)
declare sub wxStyledTextCtrl_SetMargins cdecl alias "wxStyledTextCtrl_SetMargins" (byval self as wxStyledTextCtrl ptr, byval left as integer, byval right as integer)
declare sub wxStyledTextCtrl_GetSelection cdecl alias "wxStyledTextCtrl_GetSelection" (byval self as wxStyledTextCtrl ptr, byval startPos as integer ptr, byval endPos as integer ptr)
declare sub wxStyledTextCtrl_PointFromPosition cdecl alias "wxStyledTextCtrl_PointFromPosition" (byval self as wxStyledTextCtrl ptr, byval pos as integer, byval pt as wxPoint ptr)
declare sub wxStyledTextCtrl_ScrollToLine cdecl alias "wxStyledTextCtrl_ScrollToLine" (byval self as wxStyledTextCtrl ptr, byval line as integer)
declare sub wxStyledTextCtrl_ScrollToColumn cdecl alias "wxStyledTextCtrl_ScrollToColumn" (byval self as wxStyledTextCtrl ptr, byval column as integer)
declare function wxStyledTextCtrl_SendMsg cdecl alias "wxStyledTextCtrl_SendMsg" (byval self as wxStyledTextCtrl ptr, byval msg as integer, byval wp as integer, byval lp as integer) as integer
declare sub wxStyledTextCtrl_SetVScrollBar cdecl alias "wxStyledTextCtrl_SetVScrollBar" (byval self as wxStyledTextCtrl ptr, byval bar as wxScrollBar ptr)
declare sub wxStyledTextCtrl_SetHScrollBar cdecl alias "wxStyledTextCtrl_SetHScrollBar" (byval self as wxStyledTextCtrl ptr, byval bar as wxScrollBar ptr)
declare function wxStyledTextCtrl_GetLastKeydownProcessed cdecl alias "wxStyledTextCtrl_GetLastKeydownProcessed" (byval self as wxStyledTextCtrl ptr) as integer
declare sub wxStyledTextCtrl_SetLastKeydownProcessed cdecl alias "wxStyledTextCtrl_SetLastKeydownProcessed" (byval self as wxStyledTextCtrl ptr, byval val as integer)
declare function wxStyledTextCtrl_SaveFile cdecl alias "wxStyledTextCtrl_SaveFile" (byval self as wxStyledTextCtrl ptr, byval filename as string) as integer
declare function wxStyledTextCtrl_LoadFile cdecl alias "wxStyledTextCtrl_LoadFile" (byval self as wxStyledTextCtrl ptr, byval filename as string) as integer
declare function wxStyledTextEvent cdecl alias "wxStyledTextEvent_ctor" (byval commandType as wxEventType, byval id as integer) as wxStyledTextEvent ptr
declare sub wxStyledTextEvent_SetPosition cdecl alias "wxStyledTextEvent_SetPosition" (byval self as wxStyledTextEvent ptr, byval pos as integer)
declare sub wxStyledTextEvent_SetKey cdecl alias "wxStyledTextEvent_SetKey" (byval self as wxStyledTextEvent ptr, byval k as integer)
declare sub wxStyledTextEvent_SetModifiers cdecl alias "wxStyledTextEvent_SetModifiers" (byval self as wxStyledTextEvent ptr, byval m as integer)
declare sub wxStyledTextEvent_SetModificationType cdecl alias "wxStyledTextEvent_SetModificationType" (byval self as wxStyledTextEvent ptr, byval t as integer)
declare sub wxStyledTextEvent_SetText cdecl alias "wxStyledTextEvent_SetText" (byval self as wxStyledTextEvent ptr, byval t as string)
declare sub wxStyledTextEvent_SetLength cdecl alias "wxStyledTextEvent_SetLength" (byval self as wxStyledTextEvent ptr, byval len as integer)
declare sub wxStyledTextEvent_SetLinesAdded cdecl alias "wxStyledTextEvent_SetLinesAdded" (byval self as wxStyledTextEvent ptr, byval num as integer)
declare sub wxStyledTextEvent_SetLine cdecl alias "wxStyledTextEvent_SetLine" (byval self as wxStyledTextEvent ptr, byval val as integer)
declare sub wxStyledTextEvent_SetFoldLevelNow cdecl alias "wxStyledTextEvent_SetFoldLevelNow" (byval self as wxStyledTextEvent ptr, byval val as integer)
declare sub wxStyledTextEvent_SetFoldLevelPrev cdecl alias "wxStyledTextEvent_SetFoldLevelPrev" (byval self as wxStyledTextEvent ptr, byval val as integer)
declare sub wxStyledTextEvent_SetMargin cdecl alias "wxStyledTextEvent_SetMargin" (byval self as wxStyledTextEvent ptr, byval val as integer)
declare sub wxStyledTextEvent_SetMessage cdecl alias "wxStyledTextEvent_SetMessage" (byval self as wxStyledTextEvent ptr, byval val as integer)
declare sub wxStyledTextEvent_SetWParam cdecl alias "wxStyledTextEvent_SetWParam" (byval self as wxStyledTextEvent ptr, byval val as integer)
declare sub wxStyledTextEvent_SetLParam cdecl alias "wxStyledTextEvent_SetLParam" (byval self as wxStyledTextEvent ptr, byval val as integer)
declare sub wxStyledTextEvent_SetListType cdecl alias "wxStyledTextEvent_SetListType" (byval self as wxStyledTextEvent ptr, byval val as integer)
declare sub wxStyledTextEvent_SetX cdecl alias "wxStyledTextEvent_SetX" (byval self as wxStyledTextEvent ptr, byval val as integer)
declare sub wxStyledTextEvent_SetY cdecl alias "wxStyledTextEvent_SetY" (byval self as wxStyledTextEvent ptr, byval val as integer)
declare sub wxStyledTextEvent_SetDragText cdecl alias "wxStyledTextEvent_SetDragText" (byval self as wxStyledTextEvent ptr, byval val as string)
declare sub wxStyledTextEvent_SetDragAllowMove cdecl alias "wxStyledTextEvent_SetDragAllowMove" (byval self as wxStyledTextEvent ptr, byval val as integer)
declare sub wxStyledTextEvent_SetDragResult cdecl alias "wxStyledTextEvent_SetDragResult" (byval self as wxStyledTextEvent ptr, byval val as wxDragResult)
declare function wxStyledTextEvent_GetPosition cdecl alias "wxStyledTextEvent_GetPosition" (byval self as wxStyledTextEvent ptr) as integer
declare function wxStyledTextEvent_GetKey cdecl alias "wxStyledTextEvent_GetKey" (byval self as wxStyledTextEvent ptr) as integer
declare function wxStyledTextEvent_GetModifiers cdecl alias "wxStyledTextEvent_GetModifiers" (byval self as wxStyledTextEvent ptr) as integer
declare function wxStyledTextEvent_GetModificationType cdecl alias "wxStyledTextEvent_GetModificationType" (byval self as wxStyledTextEvent ptr) as integer
declare function wxStyledTextEvent_GetText cdecl alias "wxStyledTextEvent_GetText" (byval self as wxStyledTextEvent ptr) as wxString ptr
declare function wxStyledTextEvent_GetLength cdecl alias "wxStyledTextEvent_GetLength" (byval self as wxStyledTextEvent ptr) as integer
declare function wxStyledTextEvent_GetLinesAdded cdecl alias "wxStyledTextEvent_GetLinesAdded" (byval self as wxStyledTextEvent ptr) as integer
declare function wxStyledTextEvent_GetLine cdecl alias "wxStyledTextEvent_GetLine" (byval self as wxStyledTextEvent ptr) as integer
declare function wxStyledTextEvent_GetFoldLevelNow cdecl alias "wxStyledTextEvent_GetFoldLevelNow" (byval self as wxStyledTextEvent ptr) as integer
declare function wxStyledTextEvent_GetFoldLevelPrev cdecl alias "wxStyledTextEvent_GetFoldLevelPrev" (byval self as wxStyledTextEvent ptr) as integer
declare function wxStyledTextEvent_GetMargin cdecl alias "wxStyledTextEvent_GetMargin" (byval self as wxStyledTextEvent ptr) as integer
declare function wxStyledTextEvent_GetMessage cdecl alias "wxStyledTextEvent_GetMessage" (byval self as wxStyledTextEvent ptr) as integer
declare function wxStyledTextEvent_GetWParam cdecl alias "wxStyledTextEvent_GetWParam" (byval self as wxStyledTextEvent ptr) as integer
declare function wxStyledTextEvent_GetLParam cdecl alias "wxStyledTextEvent_GetLParam" (byval self as wxStyledTextEvent ptr) as integer
declare function wxStyledTextEvent_GetListType cdecl alias "wxStyledTextEvent_GetListType" (byval self as wxStyledTextEvent ptr) as integer
declare function wxStyledTextEvent_GetX cdecl alias "wxStyledTextEvent_GetX" (byval self as wxStyledTextEvent ptr) as integer
declare function wxStyledTextEvent_GetY cdecl alias "wxStyledTextEvent_GetY" (byval self as wxStyledTextEvent ptr) as integer
declare function wxStyledTextEvent_GetDragText cdecl alias "wxStyledTextEvent_GetDragText" (byval self as wxStyledTextEvent ptr) as wxString ptr
declare function wxStyledTextEvent_GetDragAllowMove cdecl alias "wxStyledTextEvent_GetDragAllowMove" (byval self as wxStyledTextEvent ptr) as integer
declare function wxStyledTextEvent_GetDragResult cdecl alias "wxStyledTextEvent_GetDragResult" (byval self as wxStyledTextEvent ptr) as wxDragResult ptr
declare function wxStyledTextEvent_GetShift cdecl alias "wxStyledTextEvent_GetShift" (byval self as wxStyledTextEvent ptr) as integer
declare function wxStyledTextEvent_GetControl cdecl alias "wxStyledTextEvent_GetControl" (byval self as wxStyledTextEvent ptr) as integer
declare function wxStyledTextEvent_GetAlt cdecl alias "wxStyledTextEvent_GetAlt" (byval self as wxStyledTextEvent ptr) as integer

#endif
