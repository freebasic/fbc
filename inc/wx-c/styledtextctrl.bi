#Ifndef __styledtextctrl_bi__
#Define __styledtextctrl_bi__

#Include Once "common.bi"

' Event types
Declare Function wxStyledTextCtrl_EVT_STC_CHANGE WXCALL Alias "wxStyledTextCtrl_EVT_STC_CHANGE" () As wxInt
Declare Function wxStyledTextCtrl_EVT_STC_STYLENEEDED WXCALL Alias "wxStyledTextCtrl_EVT_STC_STYLENEEDED" () As wxInt
Declare Function wxStyledTextCtrl_EVT_STC_CHARADDED WXCALL Alias "wxStyledTextCtrl_EVT_STC_CHARADDED" () As wxInt
Declare Function wxStyledTextCtrl_EVT_STC_SAVEPOINTREACHED WXCALL Alias "wxStyledTextCtrl_EVT_STC_SAVEPOINTREACHED" () As wxInt
Declare Function wxStyledTextCtrl_EVT_STC_SAVEPOINTLEFT WXCALL Alias "wxStyledTextCtrl_EVT_STC_SAVEPOINTLEFT" () As wxInt
Declare Function wxStyledTextCtrl_EVT_STC_ROMODIFYATTEMPT WXCALL Alias "wxStyledTextCtrl_EVT_STC_ROMODIFYATTEMPT" () As wxInt
Declare Function wxStyledTextCtrl_EVT_STC_KEY WXCALL Alias "wxStyledTextCtrl_EVT_STC_KEY" () As wxInt
Declare Function wxStyledTextCtrl_EVT_STC_DOUBLECLICK WXCALL Alias "wxStyledTextCtrl_EVT_STC_DOUBLECLICK" () As wxInt
Declare Function wxStyledTextCtrl_EVT_STC_UPDATEUI WXCALL Alias "wxStyledTextCtrl_EVT_STC_UPDATEUI" () As wxInt
Declare Function wxStyledTextCtrl_EVT_STC_MODIFIED WXCALL Alias "wxStyledTextCtrl_EVT_STC_MODIFIED" ()  As wxInt
Declare Function wxStyledTextCtrl_EVT_STC_MACRORECORD WXCALL Alias "wxStyledTextCtrl_EVT_STC_MACRORECORD" ()  As wxInt
Declare Function wxStyledTextCtrl_EVT_STC_MARGINCLICK WXCALL Alias "wxStyledTextCtrl_EVT_STC_MARGINCLICK" () As wxInt
Declare Function wxStyledTextCtrl_EVT_STC_NEEDSHOWN WXCALL Alias "wxStyledTextCtrl_EVT_STC_NEEDSHOWN" () As wxInt
Declare Function wxStyledTextCtrl_EVT_STC_PAINTED WXCALL Alias "wxStyledTextCtrl_EVT_STC_PAINTED" () As wxInt
Declare Function wxStyledTextCtrl_EVT_STC_USERLISTSELECTION WXCALL Alias "wxStyledTextCtrl_EVT_STC_USERLISTSELECTION" ()  As wxInt
Declare Function wxStyledTextCtrl_EVT_STC_URIDROPPED WXCALL Alias "wxStyledTextCtrl_EVT_STC_URIDROPPED" () As wxInt
Declare Function wxStyledTextCtrl_EVT_STC_DWELLSTART WXCALL Alias "wxStyledTextCtrl_EVT_STC_DWELLSTART" () As wxInt
Declare Function wxStyledTextCtrl_EVT_STC_DWELLEND WXCALL Alias "wxStyledTextCtrl_EVT_STC_DWELLEND" () As wxInt
Declare Function wxStyledTextCtrl_EVT_STC_START_DRAG WXCALL Alias "wxStyledTextCtrl_EVT_STC_START_DRAG" () As wxInt
Declare Function wxStyledTextCtrl_EVT_STC_DRAG_OVER WXCALL Alias "wxStyledTextCtrl_EVT_STC_DRAG_OVER" () As wxInt
Declare Function wxStyledTextCtrl_EVT_STC_DO_DROP WXCALL Alias "wxStyledTextCtrl_EVT_STC_DO_DROP" () As wxInt
Declare Function wxStyledTextCtrl_EVT_STC_ZOOM WXCALL Alias "wxStyledTextCtrl_EVT_STC_ZOOM" () As wxInt
Declare Function wxStyledTextCtrl_EVT_STC_HOTSPOT_CLICK WXCALL Alias "wxStyledTextCtrl_EVT_STC_HOTSPOT_CLICK" () As wxInt
Declare Function wxStyledTextCtrl_EVT_STC_HOTSPOT_DCLICK WXCALL Alias "wxStyledTextCtrl_EVT_STC_HOTSPOT_DCLICK" () As wxInt
Declare Function wxStyledTextCtrl_EVT_STC_CALLTIP_CLICK WXCALL Alias "wxStyledTextCtrl_EVT_STC_CALLTIP_CLICK" () As wxInt

' class wxStyledTextCtrl
Declare Function wxStyledTextCtrl_ctor WXCALL Alias "wxStyledTextCtrl_ctor" (parent As wxWindow Ptr, _
                           id      As  wxWindowID, _
                           x       As  wxInt, _
                           y       As  wxInt, _
                           w       As  wxInt, _
                           h       As  wxInt, _
                           style   As  wxUInt, _
                           nameArg As wxString Ptr) As wxStyledTextCtrl Ptr
Declare Sub wxStyledtextCtrl_dtor WXCALL Alias "wxStyledtextCtrl_dtor" (obj As wxStyledTextCtrl Ptr)
Declare Sub wxStyledTextCtrl_AddText WXCALL Alias "wxStyledTextCtrl_AddText" (self As wxStyledTextCtrl Ptr, txt As wxString Ptr)
Declare Sub wxStyledTextCtrl_AddStyledText WXCALL Alias "wxStyledTextCtrl_AddStyledText" (self As wxStyledTextCtrl Ptr,pData As wxMemoryBuffer Ptr)
Declare Sub wxStyledTextCtrl_InsertText WXCALL Alias "wxStyledTextCtrl_InsertText" (self As wxStyledTextCtrl Ptr, p As wxInt, txt As wxString Ptr)
Declare Sub wxStyledTextCtrl_ClearAll WXCALL Alias "wxStyledTextCtrl_ClearAll" (self As wxStyledTextCtrl Ptr)
Declare Sub wxStyledTextCtrl_ClearDocumentStyle WXCALL Alias "wxStyledTextCtrl_ClearDocumentStyle" (self As wxStyledTextCtrl Ptr)
Declare Function wxStyledTextCtrl_GetLength WXCALL Alias "wxStyledTextCtrl_GetLength" (self As wxStyledTextCtrl Ptr) As wxInt
Declare Function wxStyledTextCtrl_GetCharAt WXCALL Alias "wxStyledTextCtrl_GetCharAt" (self As wxStyledTextCtrl Ptr, p As wxInt) As wxInt
Declare Function wxStyledTextCtrl_GetCurrentPos WXCALL Alias "wxStyledTextCtrl_GetCurrentPos" (self As wxStyledTextCtrl Ptr) As wxInt
Declare Function wxStyledTextCtrl_GetAnchor WXCALL Alias "wxStyledTextCtrl_GetAnchor" (self As wxStyledTextCtrl Ptr) As wxInt
Declare Function wxStyledTextCtrl_GetStyleAt WXCALL Alias "wxStyledTextCtrl_GetStyleAt" (self As wxStyledTextCtrl Ptr, p As wxInt) As wxInt
Declare Function wxStyledTextCtrl_CanRedo WXCALL Alias "wxStyledTextCtrl_CanRedo" (self As wxStyledTextCtrl Ptr) As wxBool
Declare Sub wxStyledTextCtrl_Redo WXCALL Alias "wxStyledTextCtrl_Redo" (self As wxStyledTextCtrl Ptr)
Declare Sub wxStyledTextCtrl_SetUndoCollection WXCALL Alias "wxStyledTextCtrl_SetUndoCollection" (self As wxStyledTextCtrl Ptr, collectUndo As wxBool)
Declare Sub wxStyledTextCtrl_SelectAll WXCALL Alias "wxStyledTextCtrl_SelectAll" (self As wxStyledTextCtrl Ptr)
Declare Sub wxStyledTextCtrl_SetSavePoint WXCALL Alias "wxStyledTextCtrl_SetSavePoint" (self As wxStyledTextCtrl Ptr)
Declare Function wxStyledTextCtrl_GetStyledText WXCALL Alias "wxStyledTextCtrl_GetStyledText" (self As wxStyledTextCtrl Ptr, startPos As wxInt, endPos As wxInt) As wxMemoryBuffer Ptr
Declare Function wxStyledTextCtrl_MarkerLineFromHandle WXCALL Alias "wxStyledTextCtrl_MarkerLineFromHandle" (self As wxStyledTextCtrl Ptr, handle As wxInt) As wxInt
Declare Sub wxStyledTextCtrl_MarkerDeleteHandle WXCALL Alias "wxStyledTextCtrl_MarkerDeleteHandle" (self As wxStyledTextCtrl Ptr, handle As wxInt)
Declare Function wxStyledTextCtrl_GetUndoCollection WXCALL Alias "wxStyledTextCtrl_GetUndoCollection" (self As wxStyledTextCtrl Ptr) As wxBool 
Declare Sub wxStyledTextCtrl_SetViewWhiteSpace WXCALL Alias "wxStyledTextCtrl_SetViewWhiteSpace" (self As wxStyledTextCtrl Ptr, viewWS As wxInt)
Declare Function wxStyledTextCtrl_GetViewWhiteSpace WXCALL Alias "wxStyledTextCtrl_GetViewWhiteSpace" (self As wxStyledTextCtrl Ptr) As wxInt
Declare Function wxStyledTextCtrl_PositionFromPoint WXCALL Alias "wxStyledTextCtrl_PositionFromPoint" (self As wxStyledTextCtrl Ptr, pt As wxPoint Ptr) As wxInt
Declare Function wxStyledTextCtrl_PositionFromPointClose WXCALL Alias "wxStyledTextCtrl_PositionFromPointClose" (self As wxStyledTextCtrl Ptr, x As wxInt, y As wxInt) As wxInt
Declare Sub wxStyledTextCtrl_GotoLine WXCALL Alias "wxStyledTextCtrl_GotoLine" (self As wxStyledTextCtrl Ptr, line_ As wxInt)
Declare Sub wxStyledTextCtrl_GotoPos WXCALL Alias "wxStyledTextCtrl_GotoPos" (self As wxStyledTextCtrl Ptr, p As wxInt)
Declare Sub wxStyledTextCtrl_SetAnchor WXCALL Alias "wxStyledTextCtrl_SetAnchor" (self As wxStyledTextCtrl Ptr, AnchorPos As wxInt)
Declare Function wxStyledTextCtrl_GetCurLine WXCALL Alias "wxStyledTextCtrl_GetCurLine" (self As wxStyledTextCtrl Ptr, linePos As wxInt Ptr) As wxString Ptr
Declare Function wxStyledTextCtrl_GetEndStyled WXCALL Alias "wxStyledTextCtrl_GetEndStyled" (self As wxStyledTextCtrl Ptr) As wxInt
Declare Sub wxStyledTextCtrl_ConvertEOLs WXCALL Alias "wxStyledTextCtrl_ConvertEOLs" (self As wxStyledTextCtrl Ptr, eolMode As wxInt)
Declare Sub wxStyledTextCtrl_SetEOLMode WXCALL Alias "wxStyledTextCtrl_SetEOLMode" (self As wxStyledTextCtrl Ptr, eolMode As wxInt)
Declare Function wxStyledTextCtrl_GetEOLMode WXCALL Alias "wxStyledTextCtrl_GetEOLMode" (self As wxStyledTextCtrl Ptr) As wxInt
Declare Sub wxStyledTextCtrl_StartStyling WXCALL Alias "wxStyledTextCtrl_StartStyling" (self As wxStyledTextCtrl Ptr, p As wxInt, mask As wxInt)
Declare Sub wxStyledTextCtrl_SetStyling WXCALL Alias "wxStyledTextCtrl_SetStyling" (self As wxStyledTextCtrl Ptr, length As wxInt, style As wxInt)
Declare Sub wxStyledTextCtrl_SetBufferedDraw WXCALL Alias "wxStyledTextCtrl_SetBufferedDraw" (self As wxStyledTextCtrl Ptr, buffered As wxBool)
Declare Function wxStyledTextCtrl_GetBufferedDraw WXCALL Alias "wxStyledTextCtrl_GetBufferedDraw" (self As wxStyledTextCtrl Ptr) As wxBool
Declare Function wxStyledTextCtrl_GetTabWidth WXCALL Alias "wxStyledTextCtrl_GetTabWidth" (self As wxStyledTextCtrl Ptr) As wxInt
Declare Sub wxStyledTextCtrl_SetTabWidth WXCALL Alias "wxStyledTextCtrl_SetTabWidth" (self As wxStyledTextCtrl Ptr, tabWidth As wxInt)
Declare Sub wxStyledTextCtrl_SetCodePage WXCALL Alias "wxStyledTextCtrl_SetCodePage" (self As wxStyledTextCtrl Ptr, codePage As wxInt)
Declare Sub wxStyledTextCtrl_MarkerDefine WXCALL Alias "wxStyledTextCtrl_MarkerDefine" (self As wxStyledTextCtrl Ptr, markerNumber As wxInt, markerSymbol As wxInt, fg As wxColour Ptr, bg As wxColour Ptr)
Declare Sub wxStyledTextCtrl_MarkerSetForeground WXCALL Alias "wxStyledTextCtrl_MarkerSetForeground" (self As wxStyledTextCtrl Ptr, markerNumber As wxInt, fg As wxColour Ptr)
Declare Sub wxStyledTextCtrl_MarkerSetBackground WXCALL Alias "wxStyledTextCtrl_MarkerSetBackground" (self As wxStyledTextCtrl Ptr, markerNumber As wxInt, bg As wxColour Ptr)
Declare Function wxStyledTextCtrl_MarkerAdd WXCALL Alias "wxStyledTextCtrl_MarkerAdd" (self As wxStyledTextCtrl Ptr, line_ As wxInt, markerNumber As wxInt) As wxInt
Declare Sub wxStyledTextCtrl_MarkerDelete WXCALL Alias "wxStyledTextCtrl_MarkerDelete" (self As wxStyledTextCtrl Ptr, line_ As wxInt, markerNumber As wxInt)
Declare Sub wxStyledTextCtrl_MarkerDeleteAll WXCALL Alias "wxStyledTextCtrl_MarkerDeleteAll" (self As wxStyledTextCtrl Ptr, markerNumber As wxInt)
Declare Function wxStyledTextCtrl_MarkerGet WXCALL Alias "wxStyledTextCtrl_MarkerGet" (self As wxStyledTextCtrl Ptr, line_ As wxInt) As wxInt
Declare Function wxStyledTextCtrl_MarkerNext WXCALL Alias "wxStyledTextCtrl_MarkerNext" (self As wxStyledTextCtrl Ptr, lineStart As wxInt, markerMask As wxInt) As wxInt
Declare Function wxStyledTextCtrl_MarkerPrevious WXCALL Alias "wxStyledTextCtrl_MarkerPrevious" (self As wxStyledTextCtrl Ptr, lineStart As wxInt, markerMask As wxInt) As wxInt
Declare Sub wxStyledTextCtrl_MarkerDefineBitmap WXCALL Alias "wxStyledTextCtrl_MarkerDefineBitmap" (self As wxStyledTextCtrl Ptr, markerNumber As wxInt, bitmap As wxBitmap Ptr)
Declare Sub wxStyledTextCtrl_SetMarginType WXCALL Alias "wxStyledTextCtrl_SetMarginType" (self As wxStyledTextCtrl Ptr, margin As wxInt, marginType As wxInt)
Declare Function wxStyledTextCtrl_GetMarginType WXCALL Alias "wxStyledTextCtrl_GetMarginType" (self As wxStyledTextCtrl Ptr, margin As wxInt) As wxInt
Declare Sub wxStyledTextCtrl_SetMarginWidth WXCALL Alias "wxStyledTextCtrl_SetMarginWidth" (self As wxStyledTextCtrl Ptr, margin As wxInt, pixelWidth As wxInt)
Declare Function wxStyledTextCtrl_GetMarginWidth WXCALL Alias "wxStyledTextCtrl_GetMarginWidth" (self As wxStyledTextCtrl Ptr, margin As wxInt) As wxInt
Declare Sub wxStyledTextCtrl_SetMarginMask WXCALL Alias "wxStyledTextCtrl_SetMarginMask" (self As wxStyledTextCtrl Ptr, margin As wxInt, mask As wxInt)
Declare Function wxStyledTextCtrl_GetMarginMask WXCALL Alias "wxStyledTextCtrl_GetMarginMask" (self As wxStyledTextCtrl Ptr, margin As wxInt) As wxInt
Declare Sub wxStyledTextCtrl_SetMarginSensitive WXCALL Alias "wxStyledTextCtrl_SetMarginSensitive" (self As wxStyledTextCtrl Ptr, margin As wxInt, sensitive As wxInt)
Declare Function wxStyledTextCtrl_GetMarginSensitive WXCALL Alias "wxStyledTextCtrl_GetMarginSensitive" (self As wxStyledTextCtrl Ptr, margin As wxInt) As wxBool
Declare Sub wxStyledTextCtrl_StyleClearAll WXCALL Alias "wxStyledTextCtrl_StyleClearAll" (self As wxStyledTextCtrl Ptr)
Declare Sub wxStyledTextCtrl_StyleSetForeground WXCALL Alias "wxStyledTextCtrl_StyleSetForeground" (self As wxStyledTextCtrl Ptr, style As wxInt, fg As wxColour Ptr)
Declare Sub wxStyledTextCtrl_StyleSetBackground WXCALL Alias "wxStyledTextCtrl_StyleSetBackground" (self As wxStyledTextCtrl Ptr, style As wxInt, bg As wxColour Ptr)
Declare Sub wxStyledTextCtrl_StyleSetBold WXCALL Alias "wxStyledTextCtrl_StyleSetBold" (self As wxStyledTextCtrl Ptr, style As wxInt, boold As wxBool)
Declare Sub wxStyledTextCtrl_StyleSetItalic WXCALL Alias "wxStyledTextCtrl_StyleSetItalic" (self As wxStyledTextCtrl Ptr, style As wxInt, italic As wxBool)
Declare Sub wxStyledTextCtrl_StyleSetSize WXCALL Alias "wxStyledTextCtrl_StyleSetSize" (self As wxStyledTextCtrl Ptr, style As wxInt, sizePoints As wxInt)
Declare Sub wxStyledTextCtrl_StyleSetFaceName WXCALL Alias "wxStyledTextCtrl_StyleSetFaceName" (self As wxStyledTextCtrl Ptr, style As wxInt, fontName As wxString Ptr)
Declare Sub wxStyledTextCtrl_StyleSetEOLFilled WXCALL Alias "wxStyledTextCtrl_StyleSetEOLFilled" (self As wxStyledTextCtrl Ptr, style As wxInt, filled As wxBool)
Declare Sub wxStyledTextCtrl_StyleResetDefault WXCALL Alias "wxStyledTextCtrl_StyleResetDefault" (self As wxStyledTextCtrl Ptr)
Declare Sub wxStyledTextCtrl_StyleSetUnderline WXCALL Alias "wxStyledTextCtrl_StyleSetUnderline" (self As wxStyledTextCtrl Ptr, style As wxInt, underline As wxBool)
Declare Sub wxStyledTextCtrl_StyleSetCase WXCALL Alias "wxStyledTextCtrl_StyleSetCase" (self As wxStyledTextCtrl Ptr, style As wxInt, caseForce As wxInt)
Declare Sub wxStyledTextCtrl_StyleSetCharacterSet WXCALL Alias "wxStyledTextCtrl_StyleSetCharacterSet" (self As wxStyledTextCtrl Ptr, style As wxInt, characterSet As wxInt)
Declare Sub wxStyledTextCtrl_StyleSetHotSpot WXCALL Alias "wxStyledTextCtrl_StyleSetHotSpot" (self As wxStyledTextCtrl Ptr, style As wxInt, hotspot As wxBool)
Declare Sub wxStyledTextCtrl_SetSelForeground WXCALL Alias "wxStyledTextCtrl_SetSelForeground" (self As wxStyledTextCtrl Ptr, useSetting As wxBool, fg As wxColour Ptr)
Declare Sub wxStyledTextCtrl_SetSelBackground WXCALL Alias "wxStyledTextCtrl_SetSelBackground" (self As wxStyledTextCtrl Ptr, useSetting As wxBool, bg As wxColour Ptr)
Declare Sub wxStyledTextCtrl_SetCaretForeground WXCALL Alias "wxStyledTextCtrl_SetCaretForeground" (self As wxStyledTextCtrl Ptr, fg As wxColour Ptr)
Declare Sub wxStyledTextCtrl_CmdKeyAssign WXCALL Alias "wxStyledTextCtrl_CmdKeyAssign" (self As wxStyledTextCtrl Ptr, key As wxInt, modifiers As wxInt, cmd As wxInt)
Declare Sub wxStyledTextCtrl_CmdKeyClear WXCALL Alias "wxStyledTextCtrl_CmdKeyClear" (self As wxStyledTextCtrl Ptr, key As wxInt, modifiers As wxInt)
Declare Sub wxStyledTextCtrl_CmdKeyClearAll WXCALL Alias "wxStyledTextCtrl_CmdKeyClearAll" (self As wxStyledTextCtrl Ptr)
Declare Sub wxStyledTextCtrl_SetStyleBytes WXCALL Alias "wxStyledTextCtrl_SetStyleBytes" (self As wxStyledTextCtrl Ptr, length As wxInt, styleBytes As wxChar Ptr)
Declare Sub wxStyledTextCtrl_StyleSetVisible WXCALL Alias "wxStyledTextCtrl_StyleSetVisible" (self As wxStyledTextCtrl Ptr, style As wxInt, visible As wxBool)
Declare Function wxStyledTextCtrl_GetCaretPeriod WXCALL Alias "wxStyledTextCtrl_GetCaretPeriod" (self As wxStyledTextCtrl Ptr) As wxInt
Declare Sub wxStyledTextCtrl_SetCaretPeriod WXCALL Alias "wxStyledTextCtrl_SetCaretPeriod" (self As wxStyledTextCtrl Ptr, periodMilliseconds As wxInt)
Declare Sub wxStyledTextCtrl_SetWordChars WXCALL Alias "wxStyledTextCtrl_SetWordChars" (self As wxStyledTextCtrl Ptr, charsacters As wxString Ptr)
Declare Sub wxStyledTextCtrl_BeginUndoAction WXCALL Alias "wxStyledTextCtrl_BeginUndoAction" (self As wxStyledTextCtrl Ptr)
Declare Sub wxStyledTextCtrl_EndUndoAction WXCALL Alias "wxStyledTextCtrl_EndUndoAction" (self As wxStyledTextCtrl Ptr)
Declare Sub wxStyledTextCtrl_IndicatorSetStyle WXCALL Alias "wxStyledTextCtrl_IndicatorSetStyle" (self As wxStyledTextCtrl Ptr, indic As wxInt, style As wxInt)
Declare Function wxStyledTextCtrl_IndicatorGetStyle WXCALL Alias "wxStyledTextCtrl_IndicatorGetStyle" (self As wxStyledTextCtrl Ptr, indic As wxInt) As wxInt
Declare Sub wxStyledTextCtrl_IndicatorSetForeground WXCALL Alias "wxStyledTextCtrl_IndicatorSetForeground" (self As wxStyledTextCtrl Ptr, indic As wxInt, fg As wxColour Ptr)
Declare Function wxStyledTextCtrl_IndicatorGetForeground WXCALL Alias "wxStyledTextCtrl_IndicatorGetForeground" (self As wxStyledTextCtrl Ptr, indic As wxInt) As wxColour Ptr
Declare Sub wxStyledTextCtrl_SetWhitespaceForeground WXCALL Alias "wxStyledTextCtrl_SetWhitespaceForeground" (self As wxStyledTextCtrl Ptr, useSetting As wxBool, fg As wxColour Ptr)
Declare Sub wxStyledTextCtrl_SetWhitespaceBackground WXCALL Alias "wxStyledTextCtrl_SetWhitespaceBackground" (self As wxStyledTextCtrl Ptr, useSetting As wxBool, bg As wxColour Ptr)
Declare Sub wxStyledTextCtrl_SetStyleBits WXCALL Alias "wxStyledTextCtrl_SetStyleBits" (self As wxStyledTextCtrl Ptr, bits As wxInt)
Declare Function wxStyledTextCtrl_GetStyleBits WXCALL Alias "wxStyledTextCtrl_GetStyleBits" (self As wxStyledTextCtrl Ptr) As wxInt
Declare Sub wxStyledTextCtrl_SetLineState WXCALL Alias "wxStyledTextCtrl_SetLineState" (self As wxStyledTextCtrl Ptr, line_ As wxInt, state As wxInt)
Declare Function wxStyledTextCtrl_GetLineState WXCALL Alias "wxStyledTextCtrl_GetLineState" (self As wxStyledTextCtrl Ptr, line_ As wxInt) As wxInt
Declare Function wxStyledTextCtrl_GetMaxLineState WXCALL Alias "wxStyledTextCtrl_GetMaxLineState" (self As wxStyledTextCtrl Ptr) As wxInt
Declare Function wxStyledTextCtrl_GetCaretLineVisible WXCALL Alias "wxStyledTextCtrl_GetCaretLineVisible" (self As wxStyledTextCtrl Ptr) As wxBool
Declare Sub wxStyledTextCtrl_SetCaretLineVisible WXCALL Alias "wxStyledTextCtrl_SetCaretLineVisible" (self As wxStyledTextCtrl Ptr, show As wxBool)
Declare Sub wxStyledTextCtrl_SetCaretLineBack WXCALL Alias "wxStyledTextCtrl_SetCaretLineBack" (self As wxStyledTextCtrl Ptr, bg As wxColour Ptr)
Declare Function wxStyledTextCtrl_GetCaretLineBack WXCALL Alias "wxStyledTextCtrl_GetCaretLineBack" (self As wxStyledTextCtrl Ptr) As wxColour Ptr
Declare Sub wxStyledTextCtrl_StyleSetChangeable WXCALL Alias "wxStyledTextCtrl_StyleSetChangeable" (self As wxStyledTextCtrl Ptr, style As wxInt, changeable As wxBool)
Declare Sub wxStyledTextCtrl_AutoCompShow WXCALL Alias "wxStyledTextCtrl_AutoCompShow" (self As wxStyledTextCtrl Ptr, lenEntered As wxInt, itemList As wxString Ptr)
Declare Sub wxStyledTextCtrl_AutoCompCancel WXCALL Alias "wxStyledTextCtrl_AutoCompCancel" (self As wxStyledTextCtrl Ptr)
Declare Function wxStyledTextCtrl_AutoCompActive WXCALL Alias "wxStyledTextCtrl_AutoCompActive" (self As wxStyledTextCtrl Ptr) As wxBool
Declare Function wxStyledTextCtrl_AutoCompPosStart WXCALL Alias "wxStyledTextCtrl_AutoCompPosStart" (self As wxStyledTextCtrl Ptr) As wxInt
Declare Sub wxStyledTextCtrl_AutoCompComplete WXCALL Alias "wxStyledTextCtrl_AutoCompComplete" (self As wxStyledTextCtrl Ptr)
Declare Sub wxStyledTextCtrl_AutoCompStops WXCALL Alias "wxStyledTextCtrl_AutoCompStops" (self As wxStyledTextCtrl Ptr, charsacters As wxString Ptr)
Declare Sub wxStyledTextCtrl_AutoCompSetSeparator WXCALL Alias "wxStyledTextCtrl_AutoCompSetSeparator" (self As wxStyledTextCtrl Ptr, separatorCharacter As wxInt)
Declare Function wxStyledTextCtrl_AutoCompGetSeparator WXCALL Alias "wxStyledTextCtrl_AutoCompGetSeparator" (self As wxStyledTextCtrl Ptr) As wxInt
Declare Sub wxStyledTextCtrl_AutoCompSelect WXCALL Alias "wxStyledTextCtrl_AutoCompSelect" (self As wxStyledTextCtrl Ptr, txt As wxString Ptr)
Declare Sub wxStyledTextCtrl_AutoCompSetCancelAtStart WXCALL Alias "wxStyledTextCtrl_AutoCompSetCancelAtStart" (self As wxStyledTextCtrl Ptr, cancel As wxBool)
Declare Function wxStyledTextCtrl_AutoCompGetCancelAtStart WXCALL Alias "wxStyledTextCtrl_AutoCompGetCancelAtStart" (self As wxStyledTextCtrl Ptr) As wxBool
Declare Sub wxStyledTextCtrl_AutoCompSetFillUps WXCALL Alias "wxStyledTextCtrl_AutoCompSetFillUps" (self As wxStyledTextCtrl Ptr, charsacters As wxString Ptr)
Declare Sub wxStyledTextCtrl_AutoCompSetChooseSingle WXCALL Alias "wxStyledTextCtrl_AutoCompSetChooseSingle" (self As wxStyledTextCtrl Ptr, chooseSingle As wxBool)
Declare Function wxStyledTextCtrl_AutoCompGetChooseSingle WXCALL Alias "wxStyledTextCtrl_AutoCompGetChooseSingle" (self As wxStyledTextCtrl Ptr) As wxBool
Declare Sub wxStyledTextCtrl_AutoCompSetIgnoreCase WXCALL Alias "wxStyledTextCtrl_AutoCompSetIgnoreCase" (self As wxStyledTextCtrl Ptr, ignoreCase As wxBool)
Declare Function wxStyledTextCtrl_AutoCompGetIgnoreCase WXCALL Alias "wxStyledTextCtrl_AutoCompGetIgnoreCase" (self As wxStyledTextCtrl Ptr) As wxBool 
Declare Sub wxStyledTextCtrl_UserListShow WXCALL Alias "wxStyledTextCtrl_UserListShow" (self As wxStyledTextCtrl Ptr, listType As wxInt, itermlist As wxString Ptr)
Declare Sub wxStyledTextCtrl_AutoCompSetAutoHide WXCALL Alias "wxStyledTextCtrl_AutoCompSetAutoHide" (self As wxStyledTextCtrl Ptr, autoHide As wxBool)
Declare Function wxStyledTextCtrl_AutoCompGetAutoHide WXCALL Alias "wxStyledTextCtrl_AutoCompGetAutoHide" (self As wxStyledTextCtrl Ptr) As wxBool
Declare Sub wxStyledTextCtrl_AutoCompSetDropRestOfWord WXCALL Alias "wxStyledTextCtrl_AutoCompSetDropRestOfWord" (self As wxStyledTextCtrl Ptr, dropRestOfWord As wxBool)
Declare Function wxStyledTextCtrl_AutoCompGetDropRestOfWord WXCALL Alias "wxStyledTextCtrl_AutoCompGetDropRestOfWord" (self As wxStyledTextCtrl Ptr) As wxBool
Declare Sub wxStyledTextCtrl_RegisterImage WXCALL Alias "wxStyledTextCtrl_RegisterImage" (self As wxStyledTextCtrl Ptr, typ As wxInt, bitmap As wxBitmap Ptr)
Declare Sub wxStyledTextCtrl_ClearRegisteredImages WXCALL Alias "wxStyledTextCtrl_ClearRegisteredImages" (self As wxStyledTextCtrl Ptr)
Declare Sub wxStyledTextCtrl_AutoCompSetTypeSeparator WXCALL Alias "wxStyledTextCtrl_AutoCompSetTypeSeparator" (self As wxStyledTextCtrl Ptr, separatorCharacter As wxInt)
Declare Function wxStyledTextCtrl_AutoCompGetTypeSeparator WXCALL Alias "wxStyledTextCtrl_AutoCompGetTypeSeparator" (self As wxStyledTextCtrl Ptr) As wxInt
Declare Sub wxStyledTextCtrl_SetIndent WXCALL Alias "wxStyledTextCtrl_SetIndent" (self As wxStyledTextCtrl Ptr, indentSize As wxInt)
Declare Function wxStyledTextCtrl_GetIndent WXCALL Alias "wxStyledTextCtrl_GetIndent" (self As wxStyledTextCtrl Ptr) As wxInt
Declare Sub wxStyledTextCtrl_SetUseTabs WXCALL Alias "wxStyledTextCtrl_SetUseTabs" (self As wxStyledTextCtrl Ptr, useTab As wxBool)
Declare Function wxStyledTextCtrl_GetUseTabs WXCALL Alias "wxStyledTextCtrl_GetUseTabs" (self As wxStyledTextCtrl Ptr) As wxBool
Declare Sub wxStyledTextCtrl_SetLineIndentation WXCALL Alias "wxStyledTextCtrl_SetLineIndentation" (self As wxStyledTextCtrl Ptr, line_ As wxInt, indentSize As wxInt)
Declare Function wxStyledTextCtrl_GetLineIndentation WXCALL Alias "wxStyledTextCtrl_GetLineIndentation" (self As wxStyledTextCtrl Ptr, line_ As wxInt) As wxInt
Declare Function wxStyledTextCtrl_GetLineIndentPosition WXCALL Alias "wxStyledTextCtrl_GetLineIndentPosition" (self As wxStyledTextCtrl Ptr, line_ As wxInt) As wxInt
Declare Function wxStyledTextCtrl_GetColumn WXCALL Alias "wxStyledTextCtrl_GetColumn" (self As wxStyledTextCtrl Ptr, p As wxInt) As wxInt
Declare Sub wxStyledTextCtrl_SetUseHorizontalScrollBar WXCALL Alias "wxStyledTextCtrl_SetUseHorizontalScrollBar" (self As wxStyledTextCtrl Ptr, show As wxBool)
Declare Function wxStyledTextCtrl_GetUseHorizontalScrollBar WXCALL Alias "wxStyledTextCtrl_GetUseHorizontalScrollBar" (self As wxStyledTextCtrl Ptr) As wxBool
Declare Sub wxStyledTextCtrl_SetIndentationGuides WXCALL Alias "wxStyledTextCtrl_SetIndentationGuides" (self As wxStyledTextCtrl Ptr, show As wxBool)
Declare Function wxStyledTextCtrl_GetIndentationGuides WXCALL Alias "wxStyledTextCtrl_GetIndentationGuides" (self As wxStyledTextCtrl Ptr) As wxBool
Declare Sub wxStyledTextCtrl_SetHighlightGuide WXCALL Alias "wxStyledTextCtrl_SetHighlightGuide" (self As wxStyledTextCtrl Ptr, column As wxInt)
Declare Function wxStyledTextCtrl_GetHighlightGuide WXCALL Alias "wxStyledTextCtrl_GetHighlightGuide" (self As wxStyledTextCtrl Ptr) As wxInt
Declare Function wxStyledTextCtrl_GetLineEndPosition WXCALL Alias "wxStyledTextCtrl_GetLineEndPosition" (self As wxStyledTextCtrl Ptr, line_ As wxInt) As wxInt
Declare Function wxStyledTextCtrl_GetCodePage WXCALL Alias "wxStyledTextCtrl_GetCodePage" (self As wxStyledTextCtrl Ptr) As wxInt
Declare Function wxStyledTextCtrl_GetCaretForeground WXCALL Alias "wxStyledTextCtrl_GetCaretForeground" (self As wxStyledTextCtrl Ptr) As wxColour Ptr
Declare Function wxStyledTextCtrl_GetReadOnly WXCALL Alias "wxStyledTextCtrl_GetReadOnly" (self As wxStyledTextCtrl Ptr) As wxBool
Declare Sub wxStyledTextCtrl_SetCurrentPos WXCALL Alias "wxStyledTextCtrl_SetCurrentPos" (self As wxStyledTextCtrl Ptr, p As wxInt)
Declare Sub wxStyledTextCtrl_SetSelectionStart WXCALL Alias "wxStyledTextCtrl_SetSelectionStart" (self As wxStyledTextCtrl Ptr, p As wxInt)
Declare Function wxStyledTextCtrl_GetSelectionStart WXCALL Alias "wxStyledTextCtrl_GetSelectionStart" (self As wxStyledTextCtrl Ptr) As wxInt
Declare Sub wxStyledTextCtrl_SetSelectionEnd WXCALL Alias "wxStyledTextCtrl_SetSelectionEnd" (self As wxStyledTextCtrl Ptr, p As wxInt)
Declare Function wxStyledTextCtrl_GetSelectionEnd WXCALL Alias "wxStyledTextCtrl_GetSelectionEnd" (self As wxStyledTextCtrl Ptr) As wxInt
Declare Sub wxStyledTextCtrl_SetPrintMagnification WXCALL Alias "wxStyledTextCtrl_SetPrintMagnification" (self As wxStyledTextCtrl Ptr, magnification As wxInt)
Declare Function wxStyledTextCtrl_GetPrintMagnification WXCALL Alias "wxStyledTextCtrl_GetPrintMagnification" (self As wxStyledTextCtrl Ptr) As wxInt
Declare Sub wxStyledTextCtrl_SetPrintColourMode WXCALL Alias "wxStyledTextCtrl_SetPrintColourMode" (self As wxStyledTextCtrl Ptr, mode As wxInt)
Declare Function wxStyledTextCtrl_GetPrintColourMode WXCALL Alias "wxStyledTextCtrl_GetPrintColourMode" (self As wxStyledTextCtrl Ptr) As wxInt
Declare Function wxStyledTextCtrl_FindText WXCALL Alias "wxStyledTextCtrl_FindText" (self As wxStyledTextCtrl Ptr, minPos As wxInt, maxPos As wxInt, txt As wxString Ptr, flags As wxInt) As wxInt
Declare Function wxStyledTextCtrl_FormatRange WXCALL Alias "wxStyledTextCtrl_FormatRange" (self As wxStyledTextCtrl Ptr, doDraw As wxBool, startPos As wxInt, endPos As wxInt, drawDC As wxDC Ptr, targetDC As wxDC Ptr, renderRect As wxRect Ptr, pageRect As wxRect Ptr) As wxInt
Declare Function wxStyledTextCtrl_GetFirstVisibleLine WXCALL Alias "wxStyledTextCtrl_GetFirstVisibleLine" (self As wxStyledTextCtrl Ptr) As wxInt
Declare Function wxStyledTextCtrl_GetLine WXCALL Alias "wxStyledTextCtrl_GetLine" (self As wxStyledTextCtrl Ptr, line_ As wxInt) As wxString Ptr
Declare Function wxStyledTextCtrl_GetLineCount WXCALL Alias "wxStyledTextCtrl_GetLineCount" (self As wxStyledTextCtrl Ptr) As wxInt
Declare Sub wxStyledTextCtrl_SetMarginLeft WXCALL Alias "wxStyledTextCtrl_SetMarginLeft" (self As wxStyledTextCtrl Ptr, pixelWidth As wxInt)
Declare Function wxStyledTextCtrl_GetMarginLeft WXCALL Alias "wxStyledTextCtrl_GetMarginLeft" (self As wxStyledTextCtrl Ptr) As wxInt
Declare Sub wxStyledTextCtrl_SetMarginRight WXCALL Alias "wxStyledTextCtrl_SetMarginRight" (self As wxStyledTextCtrl Ptr, pixelWidth As wxInt)
Declare Function wxStyledTextCtrl_GetMarginRight WXCALL Alias "wxStyledTextCtrl_GetMarginRight" (self As wxStyledTextCtrl Ptr) As wxInt
Declare Function wxStyledTextCtrl_GetModify WXCALL Alias "wxStyledTextCtrl_GetModify" (self As wxStyledTextCtrl Ptr) As wxBool
Declare Sub wxStyledTextCtrl_SetSelection WXCALL Alias "wxStyledTextCtrl_SetSelection" (self As wxStyledTextCtrl Ptr, startPos As wxInt, endPos As wxInt)
Declare Function wxStyledTextCtrl_GetSelectedText WXCALL Alias "wxStyledTextCtrl_GetSelectedText" (self As wxStyledTextCtrl Ptr) As wxString Ptr
Declare Function wxStyledTextCtrl_GetTextRange WXCALL Alias "wxStyledTextCtrl_GetTextRange" (self As wxStyledTextCtrl Ptr, startPos As wxInt, endPos As wxInt) As wxString Ptr
Declare Sub wxStyledTextCtrl_HideSelection WXCALL Alias "wxStyledTextCtrl_HideSelection" (self As wxStyledTextCtrl Ptr, normal As wxBool)
Declare Function wxStyledTextCtrl_LineFromPosition WXCALL Alias "wxStyledTextCtrl_LineFromPosition" (self As wxStyledTextCtrl Ptr, p As wxInt) As wxInt
Declare Function wxStyledTextCtrl_PositionFromLine WXCALL Alias "wxStyledTextCtrl_PositionFromLine" (self As wxStyledTextCtrl Ptr, line_ As wxInt) As wxInt
Declare Sub wxStyledTextCtrl_LineScroll WXCALL Alias "wxStyledTextCtrl_LineScroll" (self As wxStyledTextCtrl Ptr, columns As wxInt, lines As wxInt)
Declare Sub wxStyledTextCtrl_EnsureCaretVisible WXCALL Alias "wxStyledTextCtrl_EnsureCaretVisible" (self As wxStyledTextCtrl Ptr)
Declare Sub wxStyledTextCtrl_ReplaceSelection WXCALL Alias "wxStyledTextCtrl_ReplaceSelection" (self As wxStyledTextCtrl Ptr, txt As wxString Ptr)
Declare Sub wxStyledTextCtrl_SetReadOnly WXCALL Alias "wxStyledTextCtrl_SetReadOnly" (self As wxStyledTextCtrl Ptr, readOnly As wxBool)
Declare Function wxStyledTextCtrl_CanPaste WXCALL Alias "wxStyledTextCtrl_CanPaste" (self As wxStyledTextCtrl Ptr) As wxBool
Declare Function wxStyledTextCtrl_CanUndo WXCALL Alias "wxStyledTextCtrl_CanUndo" (self As wxStyledTextCtrl Ptr) As wxBool
Declare Sub wxStyledTextCtrl_EmptyUndoBuffer WXCALL Alias "wxStyledTextCtrl_EmptyUndoBuffer" (self As wxStyledTextCtrl Ptr)
Declare Sub wxStyledTextCtrl_Undo WXCALL Alias "wxStyledTextCtrl_Undo" (self As wxStyledTextCtrl Ptr)
Declare Sub wxStyledTextCtrl_Cut WXCALL Alias "wxStyledTextCtrl_Cut" (self As wxStyledTextCtrl Ptr)
Declare Sub wxStyledTextCtrl_Copy WXCALL Alias "wxStyledTextCtrl_Copy" (self As wxStyledTextCtrl Ptr)
Declare Sub wxStyledTextCtrl_Paste WXCALL Alias "wxStyledTextCtrl_Paste" (self As wxStyledTextCtrl Ptr)
Declare Sub wxStyledTextCtrl_Clear WXCALL Alias "wxStyledTextCtrl_Clear" (self As wxStyledTextCtrl Ptr)
Declare Sub wxStyledTextCtrl_SetText WXCALL Alias "wxStyledTextCtrl_SetText" (self As wxStyledTextCtrl Ptr, txt As wxString Ptr)
Declare Function wxStyledTextCtrl_GetText WXCALL Alias "wxStyledTextCtrl_GetText" (self As wxStyledTextCtrl Ptr) As wxString Ptr
Declare Function wxStyledTextCtrl_GetTextLength WXCALL Alias "wxStyledTextCtrl_GetTextLength" (self As wxStyledTextCtrl Ptr) As wxInt
Declare Sub wxStyledTextCtrl_SetOvertype WXCALL Alias "wxStyledTextCtrl_SetOvertype" (self As wxStyledTextCtrl Ptr, overType As wxBool)
Declare Function wxStyledTextCtrl_GetOvertype WXCALL Alias "wxStyledTextCtrl_GetOvertype" (self As wxStyledTextCtrl Ptr) As wxBool
Declare Sub wxStyledTextCtrl_SetCaretWidth WXCALL Alias "wxStyledTextCtrl_SetCaretWidth" (self As wxStyledTextCtrl Ptr, pixelWidth As wxInt)
Declare Function wxStyledTextCtrl_GetCaretWidth WXCALL Alias "wxStyledTextCtrl_GetCaretWidth" (self As wxStyledTextCtrl Ptr) As wxInt
Declare Sub wxStyledTextCtrl_SetTargetStart WXCALL Alias "wxStyledTextCtrl_SetTargetStart" (self As wxStyledTextCtrl Ptr, p As wxInt)
Declare Function wxStyledTextCtrl_GetTargetStart WXCALL Alias "wxStyledTextCtrl_GetTargetStart" (self As wxStyledTextCtrl Ptr) As wxInt
Declare Sub wxStyledTextCtrl_SetTargetEnd WXCALL Alias "wxStyledTextCtrl_SetTargetEnd" (self As wxStyledTextCtrl Ptr, p As wxInt)
Declare Function wxStyledTextCtrl_GetTargetEnd WXCALL Alias "wxStyledTextCtrl_GetTargetEnd" (self As wxStyledTextCtrl Ptr) As wxInt
Declare Function wxStyledTextCtrl_ReplaceTarget WXCALL Alias "wxStyledTextCtrl_ReplaceTarget" (self As wxStyledTextCtrl Ptr, txt As wxString Ptr) As wxInt
Declare Function wxStyledTextCtrl_ReplaceTargetRE WXCALL Alias "wxStyledTextCtrl_ReplaceTargetRE" (self As wxStyledTextCtrl Ptr, txt As wxString Ptr) As wxInt
Declare Function wxStyledTextCtrl_SearchInTarget WXCALL Alias "wxStyledTextCtrl_SearchInTarget" (self As wxStyledTextCtrl Ptr, txt As wxString Ptr) As wxInt
Declare Sub wxStyledTextCtrl_SetSearchFlags WXCALL Alias "wxStyledTextCtrl_SetSearchFlags" (self As wxStyledTextCtrl Ptr, flags As wxInt)
Declare Function wxStyledTextCtrl_GetSearchFlags WXCALL Alias "wxStyledTextCtrl_GetSearchFlags" (self As wxStyledTextCtrl Ptr) As wxInt
Declare Sub wxStyledTextCtrl_CallTipShow WXCALL Alias "wxStyledTextCtrl_CallTipShow" (self As wxStyledTextCtrl Ptr, p As wxInt, definition As wxString Ptr)
Declare Sub wxStyledTextCtrl_CallTipCancel WXCALL Alias "wxStyledTextCtrl_CallTipCancel" (self As wxStyledTextCtrl Ptr)
Declare Function wxStyledTextCtrl_CallTipActive WXCALL Alias "wxStyledTextCtrl_CallTipActive" (self As wxStyledTextCtrl Ptr) As wxBool
Declare Function wxStyledTextCtrl_CallTipPosAtStart WXCALL Alias "wxStyledTextCtrl_CallTipPosAtStart" (self As wxStyledTextCtrl Ptr) As wxInt
Declare Sub wxStyledTextCtrl_CallTipSetHighlight WXCALL Alias "wxStyledTextCtrl_CallTipSetHighlight" (self As wxStyledTextCtrl Ptr, startPos As wxInt, endPos As wxInt)
Declare Sub wxStyledTextCtrl_CallTipSetBackground WXCALL Alias "wxStyledTextCtrl_CallTipSetBackground" (self As wxStyledTextCtrl Ptr, bg As wxColour Ptr)
Declare Sub wxStyledTextCtrl_CallTipSetForeground WXCALL Alias "wxStyledTextCtrl_CallTipSetForeground" (self As wxStyledTextCtrl Ptr, fg As wxColour Ptr)
Declare Sub wxStyledTextCtrl_CallTipSetForegroundHighlight WXCALL Alias "wxStyledTextCtrl_CallTipSetForegroundHighlight" (self As wxStyledTextCtrl Ptr, fg As wxColour Ptr)
Declare Sub wxStyledTextCtrl_CallTipUseStyle WXCALL Alias "wxStyledTextCtrl_CallTipUseStyle" (self As wxStyledTextCtrl Ptr, tabSize As wxInt)
Declare Function wxStyledTextCtrl_VisibleFromDocLine WXCALL Alias "wxStyledTextCtrl_VisibleFromDocLine" (self As wxStyledTextCtrl Ptr, line_ As wxInt) As wxInt
Declare Function wxStyledTextCtrl_DocLineFromVisible WXCALL Alias "wxStyledTextCtrl_DocLineFromVisible" (self As wxStyledTextCtrl Ptr, displayLine As wxInt) As wxInt
Declare Sub wxStyledTextCtrl_SetFoldLevel WXCALL Alias "wxStyledTextCtrl_SetFoldLevel" (self As wxStyledTextCtrl Ptr, line_ As wxInt, level As wxInt)
Declare Function wxStyledTextCtrl_GetFoldLevel WXCALL Alias "wxStyledTextCtrl_GetFoldLevel" (self As wxStyledTextCtrl Ptr, line_ As wxInt) As wxInt
Declare Function wxStyledTextCtrl_GetLastChild WXCALL Alias "wxStyledTextCtrl_GetLastChild" (self As wxStyledTextCtrl Ptr, line_ As wxInt, level As wxInt) As wxInt
Declare Function wxStyledTextCtrl_GetFoldParent WXCALL Alias "wxStyledTextCtrl_GetFoldParent" (self As wxStyledTextCtrl Ptr, line_ As wxInt) As wxInt
Declare Sub wxStyledTextCtrl_ShowLines WXCALL Alias "wxStyledTextCtrl_ShowLines" (self As wxStyledTextCtrl Ptr, lineStart As wxInt, lineEnd As wxInt)
Declare Sub wxStyledTextCtrl_HideLines WXCALL Alias "wxStyledTextCtrl_HideLines" (self As wxStyledTextCtrl Ptr, lineStart As wxInt, lineEnd As wxInt)
Declare Function wxStyledTextCtrl_GetLineVisible WXCALL Alias "wxStyledTextCtrl_GetLineVisible" (self As wxStyledTextCtrl Ptr, line_ As wxInt) As wxBool
Declare Sub wxStyledTextCtrl_SetFoldExpanded WXCALL Alias "wxStyledTextCtrl_SetFoldExpanded" (self As wxStyledTextCtrl Ptr, line_ As wxInt, expanded As wxBool)
Declare Function wxStyledTextCtrl_GetFoldExpanded WXCALL Alias "wxStyledTextCtrl_GetFoldExpanded" (self As wxStyledTextCtrl Ptr, line_ As wxInt) As wxBool
Declare Sub wxStyledTextCtrl_ToggleFold WXCALL Alias "wxStyledTextCtrl_ToggleFold" (self As wxStyledTextCtrl Ptr, line_ As wxInt)
Declare Sub wxStyledTextCtrl_EnsureVisible WXCALL Alias "wxStyledTextCtrl_EnsureVisible" (self As wxStyledTextCtrl Ptr, line_ As wxInt)
Declare Sub wxStyledTextCtrl_SetFoldFlags WXCALL Alias "wxStyledTextCtrl_SetFoldFlags" (self As wxStyledTextCtrl Ptr, flags As wxInt)
Declare Sub wxStyledTextCtrl_EnsureVisibleEnforcePolicy WXCALL Alias "wxStyledTextCtrl_EnsureVisibleEnforcePolicy" (self As wxStyledTextCtrl Ptr, line_ As wxInt)
Declare Sub wxStyledTextCtrl_SetTabIndents WXCALL Alias "wxStyledTextCtrl_SetTabIndents" (self As wxStyledTextCtrl Ptr, tabIdents As wxBool)
Declare Function wxStyledTextCtrl_GetTabIndents WXCALL Alias "wxStyledTextCtrl_GetTabIndents" (self As wxStyledTextCtrl Ptr) As wxBool
Declare Sub wxStyledTextCtrl_SetBackSpaceUnIndents WXCALL Alias "wxStyledTextCtrl_SetBackSpaceUnIndents" (self As wxStyledTextCtrl Ptr, spaceUnIndents As wxBool)
Declare Function wxStyledTextCtrl_GetBackSpaceUnIndents WXCALL Alias "wxStyledTextCtrl_GetBackSpaceUnIndents" (self As wxStyledTextCtrl Ptr) As wxBool
Declare Sub wxStyledTextCtrl_SetMouseDwellTime WXCALL Alias "wxStyledTextCtrl_SetMouseDwellTime" (self As wxStyledTextCtrl Ptr, periodMilliseconds As wxInt)
Declare Function wxStyledTextCtrl_GetMouseDwellTime WXCALL Alias "wxStyledTextCtrl_GetMouseDwellTime" (self As wxStyledTextCtrl Ptr) As wxInt
Declare Function wxStyledTextCtrl_WordStartPosition WXCALL Alias "wxStyledTextCtrl_WordStartPosition" (self As wxStyledTextCtrl Ptr, p As wxInt, onlyWordCharacters As wxBool) As wxInt
Declare Function wxStyledTextCtrl_WordEndPosition WXCALL Alias "wxStyledTextCtrl_WordEndPosition" (self As wxStyledTextCtrl Ptr, p As wxInt, onlyWordCharacters As wxBool) As wxInt
Declare Sub wxStyledTextCtrl_SetWrapMode WXCALL Alias "wxStyledTextCtrl_SetWrapMode" (self As wxStyledTextCtrl Ptr, mode As wxInt)
Declare Function wxStyledTextCtrl_GetWrapMode WXCALL Alias "wxStyledTextCtrl_GetWrapMode" (self As wxStyledTextCtrl Ptr) As wxInt
Declare Sub wxStyledTextCtrl_SetLayoutCache WXCALL Alias "wxStyledTextCtrl_SetLayoutCache" (self As wxStyledTextCtrl Ptr, mode As wxInt)
Declare Function wxStyledTextCtrl_GetLayoutCache WXCALL Alias "wxStyledTextCtrl_GetLayoutCache" (self As wxStyledTextCtrl Ptr) As wxInt
Declare Sub wxStyledTextCtrl_SetScrollWidth WXCALL Alias "wxStyledTextCtrl_SetScrollWidth" (self As wxStyledTextCtrl Ptr, pixelWidth As wxInt)
Declare Function wxStyledTextCtrl_GetScrollWidth WXCALL Alias "wxStyledTextCtrl_GetScrollWidth" (self As wxStyledTextCtrl Ptr) As wxInt
Declare Function wxStyledTextCtrl_TextWidth WXCALL Alias "wxStyledTextCtrl_TextWidth" (self As wxStyledTextCtrl Ptr, style As wxInt, txt As wxString Ptr) As wxInt
Declare Sub wxStyledTextCtrl_SetEndAtLastLine WXCALL Alias "wxStyledTextCtrl_SetEndAtLastLine" (self As wxStyledTextCtrl Ptr, endAtLastLine As wxBool)
Declare Function wxStyledTextCtrl_GetEndAtLastLine WXCALL Alias "wxStyledTextCtrl_GetEndAtLastLine" (self As wxStyledTextCtrl Ptr) As wxBool
Declare Function wxStyledTextCtrl_TextHeight WXCALL Alias "wxStyledTextCtrl_TextHeight" (self As wxStyledTextCtrl Ptr, line_ As wxInt) As wxInt
Declare Sub wxStyledTextCtrl_SetUseVerticalScrollBar WXCALL Alias "wxStyledTextCtrl_SetUseVerticalScrollBar" (self As wxStyledTextCtrl Ptr, show As wxBool)
Declare Function wxStyledTextCtrl_GetUseVerticalScrollBar WXCALL Alias "wxStyledTextCtrl_GetUseVerticalScrollBar" (self As wxStyledTextCtrl Ptr) As wxBool
Declare Sub wxStyledTextCtrl_AppendText WXCALL Alias "wxStyledTextCtrl_AppendText" (self As wxStyledTextCtrl Ptr, txt As wxString Ptr)
Declare Sub wxStyledTextCtrl_SetTwoPhaseDraw WXCALL Alias "wxStyledTextCtrl_SetTwoPhaseDraw" (self As wxStyledTextCtrl Ptr, twoPhase As wxBool)
Declare Function wxStyledTextCtrl_GetTwoPhaseDraw WXCALL Alias "wxStyledTextCtrl_GetTwoPhaseDraw" (self As wxStyledTextCtrl Ptr) As wxBool
Declare Sub wxStyledTextCtrl_TargetFromSelection WXCALL Alias "wxStyledTextCtrl_TargetFromSelection" (self As wxStyledTextCtrl Ptr)
Declare Sub wxStyledTextCtrl_LinesJoin WXCALL Alias "wxStyledTextCtrl_LinesJoin" (self As wxStyledTextCtrl Ptr)
Declare Sub wxStyledTextCtrl_LinesSplit WXCALL Alias "wxStyledTextCtrl_LinesSplit" (self As wxStyledTextCtrl Ptr, pixelWidth As wxInt)
Declare Sub wxStyledTextCtrl_SetFoldMarginColour WXCALL Alias "wxStyledTextCtrl_SetFoldMarginColour" (self As wxStyledTextCtrl Ptr, useSetting As wxBool, bg As wxColour Ptr)
Declare Sub wxStyledTextCtrl_SetFoldMarginHiColour WXCALL Alias "wxStyledTextCtrl_SetFoldMarginHiColour" (self As wxStyledTextCtrl Ptr, useSetting As wxBool, fg As wxColour Ptr)
Declare Sub wxStyledTextCtrl_LineDuplicate WXCALL Alias "wxStyledTextCtrl_LineDuplicate" (self As wxStyledTextCtrl Ptr)
Declare Sub wxStyledTextCtrl_HomeDisplay WXCALL Alias "wxStyledTextCtrl_HomeDisplay" (self As wxStyledTextCtrl Ptr)
Declare Sub wxStyledTextCtrl_HomeDisplayExtend WXCALL Alias "wxStyledTextCtrl_HomeDisplayExtend" (self As wxStyledTextCtrl Ptr)
Declare Sub wxStyledTextCtrl_LineEndDisplay WXCALL Alias "wxStyledTextCtrl_LineEndDisplay" (self As wxStyledTextCtrl Ptr)
Declare Sub wxStyledTextCtrl_LineEndDisplayExtend WXCALL Alias "wxStyledTextCtrl_LineEndDisplayExtend" (self As wxStyledTextCtrl Ptr)
Declare Sub wxStyledTextCtrl_MoveCaretInsideView WXCALL Alias "wxStyledTextCtrl_MoveCaretInsideView" (self As wxStyledTextCtrl Ptr)
Declare Function wxStyledTextCtrl_LineLength WXCALL Alias "wxStyledTextCtrl_LineLength" (self As wxStyledTextCtrl Ptr, line_ As wxInt) As wxInt
Declare Sub wxStyledTextCtrl_BraceHighlight WXCALL Alias "wxStyledTextCtrl_BraceHighlight" (self As wxStyledTextCtrl Ptr, p1 As wxInt, p2 As wxInt)
Declare Sub wxStyledTextCtrl_BraceBadLight WXCALL Alias "wxStyledTextCtrl_BraceBadLight" (self As wxStyledTextCtrl Ptr, p As wxInt)
Declare Function wxStyledTextCtrl_BraceMatch WXCALL Alias "wxStyledTextCtrl_BraceMatch" (self As wxStyledTextCtrl Ptr, p As wxInt) As wxInt
Declare Sub wxStyledTextCtrl_SetViewEOL WXCALL Alias "wxStyledTextCtrl_SetViewEOL" (self As wxStyledTextCtrl Ptr, visible As wxBool)
Declare Function wxStyledTextCtrl_GetViewEOL WXCALL Alias "wxStyledTextCtrl_GetViewEOL" (self As wxStyledTextCtrl Ptr) As wxBool
Declare Sub wxStyledTextCtrl_SetDocPointer WXCALL Alias "wxStyledTextCtrl_SetDocPointer" (self As wxStyledTextCtrl Ptr, docPointer As Any Ptr)
Declare Sub wxStyledTextCtrl_GetDocPointer WXCALL Alias "wxStyledTextCtrl_GetDocPointer" (self As wxStyledTextCtrl Ptr)
Declare Sub wxStyledTextCtrl_SetModEventMask WXCALL Alias "wxStyledTextCtrl_SetModEventMask" (self As wxStyledTextCtrl Ptr, mask As wxInt)
Declare Sub wxStyledTextCtrl_SetEdgeColumn WXCALL Alias "wxStyledTextCtrl_SetEdgeColumn" (self As wxStyledTextCtrl Ptr, column As wxInt)
Declare Function wxStyledTextCtrl_GetEdgeColumn WXCALL Alias "wxStyledTextCtrl_GetEdgeColumn" (self As wxStyledTextCtrl Ptr) As wxInt
Declare Sub wxStyledTextCtrl_SetEdgeMode WXCALL Alias "wxStyledTextCtrl_SetEdgeMode" (self As wxStyledTextCtrl Ptr, mode As wxInt)
Declare Function wxStyledTextCtrl_GetEdgeMode WXCALL Alias "wxStyledTextCtrl_GetEdgeMode" (self As wxStyledTextCtrl Ptr) As wxInt
Declare Sub wxStyledTextCtrl_SetEdgeColour WXCALL Alias "wxStyledTextCtrl_SetEdgeColour" (self As wxStyledTextCtrl Ptr, edgeColour As wxColour Ptr)
Declare Function wxStyledTextCtrl_GetEdgeColour WXCALL Alias "wxStyledTextCtrl_GetEdgeColour" (self As wxStyledTextCtrl Ptr) As wxColour Ptr
Declare Sub wxStyledTextCtrl_SearchAnchor WXCALL Alias "wxStyledTextCtrl_SearchAnchor" (self As wxStyledTextCtrl Ptr)
Declare Function wxStyledTextCtrl_SearchNext WXCALL Alias "wxStyledTextCtrl_SearchNext" (self As wxStyledTextCtrl Ptr, flags As wxInt, txt As wxString Ptr) As wxInt
Declare Function wxStyledTextCtrl_SearchPrev WXCALL Alias "wxStyledTextCtrl_SearchPrev" (self As wxStyledTextCtrl Ptr, flags As wxInt, txt As wxString Ptr) As wxInt
Declare Function wxStyledTextCtrl_LinesOnScreen WXCALL Alias "wxStyledTextCtrl_LinesOnScreen" (self As wxStyledTextCtrl Ptr) As wxInt
Declare Sub wxStyledTextCtrl_UsePopUp WXCALL Alias "wxStyledTextCtrl_UsePopUp" (self As wxStyledTextCtrl Ptr, allowPopUp As wxBool)
Declare Function wxStyledTextCtrl_SelectionIsRectangle WXCALL Alias "wxStyledTextCtrl_SelectionIsRectangle" (self As wxStyledTextCtrl Ptr) As wxBool
Declare Sub wxStyledTextCtrl_SetZoom WXCALL Alias "wxStyledTextCtrl_SetZoom" (self As wxStyledTextCtrl Ptr, zoom As wxInt)
Declare Function wxStyledTextCtrl_GetZoom WXCALL Alias "wxStyledTextCtrl_GetZoom" (self As wxStyledTextCtrl Ptr) As wxInt
Declare Sub wxStyledTextCtrl_CreateDocument WXCALL Alias "wxStyledTextCtrl_CreateDocument" (self As wxStyledTextCtrl Ptr)
Declare Sub wxStyledTextCtrl_AddRefDocument WXCALL Alias "wxStyledTextCtrl_AddRefDocument" (self As wxStyledTextCtrl Ptr, docPointer As Any Ptr)
Declare Sub wxStyledTextCtrl_ReleaseDocument WXCALL Alias "wxStyledTextCtrl_ReleaseDocument" (self As wxStyledTextCtrl Ptr, docPointer As Any Ptr)
Declare Function wxStyledTextCtrl_GetModEventMask WXCALL Alias "wxStyledTextCtrl_GetModEventMask" (self As wxStyledTextCtrl Ptr) As wxInt
Declare Sub wxStyledTextCtrl_SetSTCFocus WXCALL Alias "wxStyledTextCtrl_SetSTCFocus" (self As wxStyledTextCtrl Ptr, focus As wxBool)
Declare Function wxStyledTextCtrl_GetSTCFocus WXCALL Alias "wxStyledTextCtrl_GetSTCFocus" (self As wxStyledTextCtrl Ptr) As wxBool
Declare Sub wxStyledTextCtrl_SetStatus WXCALL Alias "wxStyledTextCtrl_SetStatus" (self As wxStyledTextCtrl Ptr, statusCode As wxInt)
Declare Function wxStyledTextCtrl_GetStatus WXCALL Alias "wxStyledTextCtrl_GetStatus" (self As wxStyledTextCtrl Ptr) As wxInt
Declare Sub wxStyledTextCtrl_SetMouseDownCaptures WXCALL Alias "wxStyledTextCtrl_SetMouseDownCaptures" (self As wxStyledTextCtrl Ptr, captures As wxBool)
Declare Function wxStyledTextCtrl_GetMouseDownCaptures WXCALL Alias "wxStyledTextCtrl_GetMouseDownCaptures" (self As wxStyledTextCtrl Ptr) As wxBool
Declare Sub wxStyledTextCtrl_SetSTCCursor WXCALL Alias "wxStyledTextCtrl_SetSTCCursor" (self As wxStyledTextCtrl Ptr, cursorType As wxInt)
Declare Function wxStyledTextCtrl_GetSTCCursor WXCALL Alias "wxStyledTextCtrl_GetSTCCursor" (self As wxStyledTextCtrl Ptr) As wxInt
Declare Sub wxStyledTextCtrl_SetControlCharSymbol WXCALL Alias "wxStyledTextCtrl_SetControlCharSymbol" (self As wxStyledTextCtrl Ptr, symbol As wxInt)
Declare Function wxStyledTextCtrl_GetControlCharSymbol WXCALL Alias "wxStyledTextCtrl_GetControlCharSymbol" (self As wxStyledTextCtrl Ptr) As wxInt
Declare Sub wxStyledTextCtrl_WordPartLeft WXCALL Alias "wxStyledTextCtrl_WordPartLeft" (self As wxStyledTextCtrl Ptr)
Declare Sub wxStyledTextCtrl_WordPartLeftExtend WXCALL Alias "wxStyledTextCtrl_WordPartLeftExtend" (self As wxStyledTextCtrl Ptr)
Declare Sub wxStyledTextCtrl_WordPartRight WXCALL Alias "wxStyledTextCtrl_WordPartRight" (self As wxStyledTextCtrl Ptr)
Declare Sub wxStyledTextCtrl_WordPartRightExtend WXCALL Alias "wxStyledTextCtrl_WordPartRightExtend" (self As wxStyledTextCtrl Ptr)
Declare Sub wxStyledTextCtrl_SetVisiblePolicy WXCALL Alias "wxStyledTextCtrl_SetVisiblePolicy" (self As wxStyledTextCtrl Ptr, visiblePolicy As wxInt, visibleSlop As wxInt)
Declare Sub wxStyledTextCtrl_DelLineLeft WXCALL Alias "wxStyledTextCtrl_DelLineLeft" (self As wxStyledTextCtrl Ptr)
Declare Sub wxStyledTextCtrl_DelLineRight WXCALL Alias "wxStyledTextCtrl_DelLineRight" (self As wxStyledTextCtrl Ptr)
Declare Sub wxStyledTextCtrl_SetXOffset WXCALL Alias "wxStyledTextCtrl_SetXOffset" (self As wxStyledTextCtrl Ptr, offset As wxInt)
Declare Function wxStyledTextCtrl_GetXOffset WXCALL Alias "wxStyledTextCtrl_GetXOffset" (self As wxStyledTextCtrl Ptr) As wxInt
Declare Sub wxStyledTextCtrl_ChooseCaretX WXCALL Alias "wxStyledTextCtrl_ChooseCaretX" (self As wxStyledTextCtrl Ptr)
Declare Sub wxStyledTextCtrl_SetXCaretPolicy WXCALL Alias "wxStyledTextCtrl_SetXCaretPolicy" (self As wxStyledTextCtrl Ptr, caretPolicy As wxInt, caretSlop As wxInt)
Declare Sub wxStyledTextCtrl_SetYCaretPolicy WXCALL Alias "wxStyledTextCtrl_SetYCaretPolicy" (self As wxStyledTextCtrl Ptr, caretPolicy As wxInt, caretSlop As wxInt)
Declare Sub wxStyledTextCtrl_SetPrintWrapMode WXCALL Alias "wxStyledTextCtrl_SetPrintWrapMode" (self As wxStyledTextCtrl Ptr, mode As wxInt)
Declare Function wxStyledTextCtrl_GetPrintWrapMode WXCALL Alias "wxStyledTextCtrl_GetPrintWrapMode" (self As wxStyledTextCtrl Ptr) As wxInt
Declare Sub wxStyledTextCtrl_SetHotspotActiveForeground WXCALL Alias "wxStyledTextCtrl_SetHotspotActiveForeground" (self As wxStyledTextCtrl Ptr, useSetting As wxBool, fg As wxColour Ptr)
Declare Sub wxStyledTextCtrl_SetHotspotActiveBackground WXCALL Alias "wxStyledTextCtrl_SetHotspotActiveBackground" (self As wxStyledTextCtrl Ptr, useSetting As wxBool, bg As wxColour Ptr)
Declare Sub wxStyledTextCtrl_SetHotspotActiveUnderline WXCALL Alias "wxStyledTextCtrl_SetHotspotActiveUnderline" (self As wxStyledTextCtrl Ptr, underline As wxBool)
Declare Sub wxStyledTextCtrl_StartRecord WXCALL Alias "wxStyledTextCtrl_StartRecord" (self As wxStyledTextCtrl Ptr)
Declare Sub wxStyledTextCtrl_StopRecord WXCALL Alias "wxStyledTextCtrl_StopRecord" (self As wxStyledTextCtrl Ptr)
Declare Sub wxStyledTextCtrl_SetLexer WXCALL Alias "wxStyledTextCtrl_SetLexer" (self As wxStyledTextCtrl Ptr, lexer As wxInt)
Declare Function wxStyledTextCtrl_GetLexer WXCALL Alias "wxStyledTextCtrl_GetLexer" (self As wxStyledTextCtrl Ptr) As wxInt
Declare Sub wxStyledTextCtrl_Colourise WXCALL Alias "wxStyledTextCtrl_Colourise" (self As wxStyledTextCtrl Ptr, startPos As wxInt, endPos As wxInt)
Declare Sub wxStyledTextCtrl_SetProperty WXCALL Alias "wxStyledTextCtrl_SetProperty" (self As wxStyledTextCtrl Ptr, key As wxString Ptr, value As wxString Ptr)
Declare Sub wxStyledTextCtrl_SetKeyWords WXCALL Alias "wxStyledTextCtrl_SetKeyWords" (self As wxStyledTextCtrl Ptr, keyWordSet As wxInt, keyWords As wxString Ptr)
Declare Sub wxStyledTextCtrl_SetLexerLanguage WXCALL Alias "wxStyledTextCtrl_SetLexerLanguage" (self As wxStyledTextCtrl Ptr, language As wxString Ptr)
Declare Function wxStyledTextCtrl_GetCurrentLine WXCALL Alias "wxStyledTextCtrl_GetCurrentLine" (self As wxStyledTextCtrl Ptr) As wxInt
Declare Sub wxStyledTextCtrl_StyleSetSpec WXCALL Alias "wxStyledTextCtrl_StyleSetSpec" (self As wxStyledTextCtrl Ptr, styleNum As wxInt, spec As wxString Ptr)
Declare Sub wxStyledTextCtrl_StyleSetFont WXCALL Alias "wxStyledTextCtrl_StyleSetFont" (self As wxStyledTextCtrl Ptr, styleNum As wxInt, font As wxFont Ptr)
Declare Sub wxStyledTextCtrl_StyleSetFontAttr WXCALL Alias "wxStyledTextCtrl_StyleSetFontAttr" (self As wxStyledTextCtrl Ptr, styleNum As wxInt, size As wxInt, faceName As wxString Ptr, boold As wxBool, italic As wxBool, underline As wxBool)
Declare Sub wxStyledTextCtrl_CmdKeyExecute WXCALL Alias "wxStyledTextCtrl_CmdKeyExecute" (self As wxStyledTextCtrl Ptr, cmd As wxInt)
Declare Sub wxStyledTextCtrl_SetMargins WXCALL Alias "wxStyledTextCtrl_SetMargins" (self As wxStyledTextCtrl Ptr, left_ As wxInt, right_ As wxInt)
Declare Sub wxStyledTextCtrl_GetSelection WXCALL Alias "wxStyledTextCtrl_GetSelection" (self As wxStyledTextCtrl Ptr, startPos As wxInt Ptr, endPos As wxInt Ptr)
Declare Sub wxStyledTextCtrl_PointFromPosition WXCALL Alias "wxStyledTextCtrl_PointFromPosition" (self As wxStyledTextCtrl Ptr, p As wxInt, pt As wxPoint Ptr)
Declare Sub wxStyledTextCtrl_ScrollToLine WXCALL Alias "wxStyledTextCtrl_ScrollToLine" (self As wxStyledTextCtrl Ptr, line_ As wxInt)
Declare Sub wxStyledTextCtrl_ScrollToColumn WXCALL Alias "wxStyledTextCtrl_ScrollToColumn" (self As wxStyledTextCtrl Ptr, column As wxInt)
Declare Function wxStyledTextCtrl_SendMsg WXCALL Alias "wxStyledTextCtrl_SendMsg" (self As wxStyledTextCtrl Ptr, msg As wxInt, wp As wxInt, lp As wxInt) As wxInt
Declare Sub wxStyledTextCtrl_SetVScrollBar WXCALL Alias "wxStyledTextCtrl_SetVScrollBar" (self As wxStyledTextCtrl Ptr, bar As wxScrollBar Ptr)
Declare Sub wxStyledTextCtrl_SetHScrollBar WXCALL Alias "wxStyledTextCtrl_SetHScrollBar" (self As wxStyledTextCtrl Ptr, bar As wxScrollBar Ptr)
Declare Sub wxStyledTextCtrl_SetLastKeydownProcessed WXCALL Alias "wxStyledTextCtrl_SetLastKeydownProcessed" (self As wxStyledTextCtrl Ptr, value As wxBool)
Declare Function wxStyledTextCtrl_GetLastKeydownProcessed WXCALL Alias "wxStyledTextCtrl_GetLastKeydownProcessed" (self As wxStyledTextCtrl Ptr) As wxBool
Declare Function wxStyledTextCtrl_SaveFile WXCALL Alias "wxStyledTextCtrl_SaveFile" (self As wxStyledTextCtrl Ptr, fileName As wxString Ptr) As wxBool
Declare Function wxStyledTextCtrl_LoadFile WXCALL Alias "wxStyledTextCtrl_LoadFile" (self As wxStyledTextCtrl Ptr, fileName As wxString Ptr) As wxBool

' class wxStyledTextEvent
Declare Function wxStyledTextEvent_ctor WXCALL Alias "wxStyledTextEvent_ctor" (commandType As wxEventType, id As wxInt) As wxStyledTextEvent Ptr
Declare Sub wxStyledTextEvent_SetPosition WXCALL Alias "wxStyledTextEvent_SetPosition" (self As wxStyledTextEvent Ptr, p As wxInt)
Declare Function wxStyledTextEvent_GetPosition WXCALL Alias "wxStyledTextEvent_GetPosition" (self As wxStyledTextEvent Ptr) As wxInt
Declare Sub wxStyledTextEvent_SetKey WXCALL Alias "wxStyledTextEvent_SetKey" (self As wxStyledTextEvent Ptr, key As wxInt)
Declare Function wxStyledTextEvent_GetKey WXCALL Alias "wxStyledTextEvent_GetKey" (self As wxStyledTextEvent Ptr) As wxInt
Declare Sub wxStyledTextEvent_SetModifiers WXCALL Alias "wxStyledTextEvent_SetModifiers" (self As wxStyledTextEvent Ptr, modifiers As wxInt)
Declare Sub wxStyledTextEvent_SetModificationType WXCALL Alias "wxStyledTextEvent_SetModificationType" (self As wxStyledTextEvent Ptr, modifiersType As wxInt)
Declare Function wxStyledTextEvent_GetModifiers WXCALL Alias "wxStyledTextEvent_GetModifiers" (self As wxStyledTextEvent Ptr) As wxInt
Declare Sub wxStyledTextEvent_SetText WXCALL Alias "wxStyledTextEvent_SetText" (self As wxStyledTextEvent Ptr, txt As wxString Ptr)
Declare Function wxStyledTextEvent_GetText WXCALL Alias "wxStyledTextEvent_GetText" (self As wxStyledTextEvent Ptr) As wxString Ptr
Declare Sub wxStyledTextEvent_SetLength WXCALL Alias "wxStyledTextEvent_SetLength" (self As wxStyledTextEvent Ptr, lenngth As wxInt)
Declare Function wxStyledTextEvent_GetLength WXCALL Alias "wxStyledTextEvent_GetLength" (self As wxStyledTextEvent Ptr) As wxInt
Declare Sub wxStyledTextEvent_SetLinesAdded WXCALL Alias "wxStyledTextEvent_SetLinesAdded" (self As wxStyledTextEvent Ptr, nLines As wxInt)
Declare Function wxStyledTextEvent_GetLinesAdded WXCALL Alias "wxStyledTextEvent_GetLinesAdded" (self As wxStyledTextEvent Ptr) As wxInt
Declare Sub wxStyledTextEvent_SetLine WXCALL Alias "wxStyledTextEvent_SetLine" (self As wxStyledTextEvent Ptr, value As wxInt)
Declare Function wxStyledTextEvent_GetLine WXCALL Alias "wxStyledTextEvent_GetLine" (self As wxStyledTextEvent Ptr) As wxInt
Declare Sub wxStyledTextEvent_SetFoldLevelNow WXCALL Alias "wxStyledTextEvent_SetFoldLevelNow" (self As wxStyledTextEvent Ptr, value As wxInt)
Declare Function wxStyledTextEvent_GetFoldLevelNow WXCALL Alias "wxStyledTextEvent_GetFoldLevelNow" (self As wxStyledTextEvent Ptr) As wxInt
Declare Sub wxStyledTextEvent_SetFoldLevelPrev WXCALL Alias "wxStyledTextEvent_SetFoldLevelPrev" (self As wxStyledTextEvent Ptr, value As wxInt)
Declare Function wxStyledTextEvent_GetFoldLevelPrev WXCALL Alias "wxStyledTextEvent_GetFoldLevelPrev" (self As wxStyledTextEvent Ptr) As wxInt
Declare Sub wxStyledTextEvent_SetMargin WXCALL Alias "wxStyledTextEvent_SetMargin" (self As wxStyledTextEvent Ptr, value As wxInt)
Declare Function wxStyledTextEvent_GetMargin WXCALL Alias "wxStyledTextEvent_GetMargin" (self As wxStyledTextEvent Ptr) As wxInt
Declare Sub wxStyledTextEvent_SetMessage WXCALL Alias "wxStyledTextEvent_SetMessage" (self As wxStyledTextEvent Ptr, value As wxInt)
Declare Function wxStyledTextEvent_GetMessage WXCALL Alias "wxStyledTextEvent_GetMessage" (self As wxStyledTextEvent Ptr) As wxInt
Declare Sub wxStyledTextEvent_SetWParam WXCALL Alias "wxStyledTextEvent_SetWParam" (self As wxStyledTextEvent Ptr, value As wxInt)
Declare Function wxStyledTextEvent_GetWParam WXCALL Alias "wxStyledTextEvent_GetWParam" (self As wxStyledTextEvent Ptr) As wxInt
Declare Sub wxStyledTextEvent_SetLParam WXCALL Alias "wxStyledTextEvent_SetLParam" (self As wxStyledTextEvent Ptr, value As wxInt)
Declare Function wxStyledTextEvent_GetLParam WXCALL Alias "wxStyledTextEvent_GetLParam" (self As wxStyledTextEvent Ptr) As wxInt
Declare Sub wxStyledTextEvent_SetListType WXCALL Alias "wxStyledTextEvent_SetListType" (self As wxStyledTextEvent Ptr, value As wxInt)
Declare Function wxStyledTextEvent_GetListType WXCALL Alias "wxStyledTextEvent_GetListType" (self As wxStyledTextEvent Ptr) As wxInt
Declare Sub wxStyledTextEvent_SetX WXCALL Alias "wxStyledTextEvent_SetX" (self As wxStyledTextEvent Ptr, value As wxInt)
Declare Function wxStyledTextEvent_GetX WXCALL Alias "wxStyledTextEvent_GetX" (self As wxStyledTextEvent Ptr) As wxInt
Declare Sub wxStyledTextEvent_SetY WXCALL Alias "wxStyledTextEvent_SetY" (self As wxStyledTextEvent Ptr, value As wxInt)
Declare Function wxStyledTextEvent_GetY WXCALL Alias "wxStyledTextEvent_GetY" (self As wxStyledTextEvent Ptr) As wxInt
Declare Sub wxStyledTextEvent_SetDragText WXCALL Alias "wxStyledTextEvent_SetDragText" (self As wxStyledTextEvent Ptr, value As wxString Ptr)
Declare Function wxStyledTextEvent_GetDragText WXCALL Alias "wxStyledTextEvent_GetDragText" (self As wxStyledTextEvent Ptr) As wxString Ptr
Declare Sub wxStyledTextEvent_SetDragAllowMove WXCALL Alias "wxStyledTextEvent_SetDragAllowMove" (self As wxStyledTextEvent Ptr, value As wxBool)
Declare Function wxStyledTextEvent_GetDragAllowMove WXCALL Alias "wxStyledTextEvent_GetDragAllowMove" (self As wxStyledTextEvent Ptr) As wxBool
Declare Sub wxStyledTextEvent_SetDragResult WXCALL Alias "wxStyledTextEvent_SetDragResult" (self As wxStyledTextEvent Ptr, dr As wxDragResult)
Declare Function wxStyledTextEvent_GetDragResult WXCALL Alias "wxStyledTextEvent_GetDragResult" (self As wxStyledTextEvent Ptr) As wxDragResult Ptr
Declare Function wxStyledTextEvent_GetModificationType WXCALL Alias "wxStyledTextEvent_GetModificationType" (self As wxStyledTextEvent Ptr) As wxInt
Declare Function wxStyledTextEvent_GetShift WXCALL Alias "wxStyledTextEvent_GetShift" (self As wxStyledTextEvent Ptr) As wxBool
Declare Function wxStyledTextEvent_GetControl WXCALL Alias "wxStyledTextEvent_GetControl" (self As wxStyledTextEvent Ptr) As wxBool
Declare Function wxStyledTextEvent_GetAlt WXCALL Alias "wxStyledTextEvent_GetAlt" (self As wxStyledTextEvent Ptr) As wxBool

#EndIf ' __styledtextctrl_bi__

