#Ifndef __html_bi__
#Define __html_bi__

#Include Once "common.bi"

Type Virtual_OnLinkClicked    As Sub      WXCALL (As wxHtmlLinkInfo Ptr)
Type Virtual_OnSetTitle       As Sub      WXCALL (As wxString Ptr )
Type Virtual_OnCellMouseHover As Sub      WXCALL (As wxHtmlCell Ptr, As wxCoord, As wxCoord)
Type Virtual_OnCellClicked    As Function WXCALL (As wxHtmlCell Ptr, As wxCoord, As wxCoord, As wxMouseEvent Ptr) As wxBool
Type Virtual_OnOpeningURL     As Function WXCALL (As wxHtmlURLType, As wxString Ptr, As wxString Ptr) As wxHtmlOpeningStatus
Type Virtual_LoadFile         As Function WXCALL (filename As wxString Ptr) As wxInt
Type Virtual_LoadPage         As Function WXCALL (location As wxString Ptr) As wxInt

Type Virtual_GetSupportedTags As Function WXCALL As _DisposableStringBox Ptr
Type Virtual_GetHandleTag     As Function WXCALL (varib As wxHtmlTag Ptr) As wxInt


Declare Function wxHtmlWindow_ctor WXCALL Alias "wxHtmlWindow_ctor" () As wxHtmlWindow Ptr
Declare Function wxHtmlWindow_ctor2 WXCALL Alias "wxHtmlWindow_ctor2" (parent As wxWindow Ptr, id As wxWindowID, p As wxPoint Ptr, size As wxSize Ptr, style As wxUInt, nam As wxString Ptr) As wxHtmlWindow Ptr
Declare Sub wxHtmlWindow_RegisterVirtual WXCALL Alias "wxHtmlWindow_RegisterVirtual" (self As wxHtmlWindow Ptr, _
                                  on_LinkClicked    As Virtual_OnLinkClicked, _
                                  on_SetTitle       As Virtual_OnSetTitle, _
                                  on_CellMouseHover As Virtual_OnCellMouseHover, _
                                  on_CellClicked    As Virtual_OnCellClicked, _
                                  on_OpeningURL     As Virtual_OnOpeningURL, _
                                  fLoadFile         As Virtual_LoadFile, _
                                  fLoadPage         As Virtual_LoadPage)
Declare Function wxHtmlWindow_Create WXCALL Alias "wxHtmlWindow_Create" (self As wxHtmlWindow Ptr, parent As wxWindow Ptr, id As wxWindowID, p As wxPoint Ptr, size As wxSize Ptr, style As wxUInt, nam As wxString Ptr) As wxBool
Declare Function wxHtmlWindow_SetPage WXCALL Alias "wxHtmlWindow_SetPage" (self As wxHtmlWindow Ptr, source As wxString Ptr) As wxBool
Declare Function wxHtmlWindow_AppendToPage WXCALL Alias "wxHtmlWindow_AppendToPage" (self As wxHtmlWindow Ptr, source As wxString Ptr) As wxBool
Declare Function wxHtmlWindow_LoadPage WXCALL Alias "wxHtmlWindow_LoadPage" (self As wxHtmlWindow Ptr, location As wxString Ptr) As wxBool

' This calls the original implementation, not the callback.
Declare Function wxHtmlWindow_LoadFile WXCALL Alias "wxHtmlWindow_LoadFile" (self As wxHtmlWindow Ptr, wfilename As wxString Ptr) As wxBool
Declare Function wxHtmlWindow_GetOpenedPage WXCALL Alias "wxHtmlWindow_GetOpenedPage" (self As wxHtmlWindow Ptr) As wxString Ptr
Declare Function wxHtmlWindow_GetOpenedAnchor WXCALL Alias "wxHtmlWindow_GetOpenedAnchor" (self As wxHtmlWindow Ptr) As wxString Ptr
Declare Function wxHtmlWindow_GetOpenedPageTitle WXCALL Alias "wxHtmlWindow_GetOpenedPageTitle" (self As wxHtmlWindow Ptr) As wxString Ptr
Declare Sub wxHtmlWindow_SetRelatedFrame WXCALL Alias "wxHtmlWindow_SetRelatedFrame" (self As wxHtmlWindow Ptr, frame As wxFrame Ptr, fmt As wxString Ptr)
Declare Function wxHtmlWindow_GetRelatedFrame WXCALL Alias "wxHtmlWindow_GetRelatedFrame" (self As wxHtmlWindow Ptr) As wxFrame Ptr
Declare Sub wxHtmlWindow_SetRelatedStatusBar WXCALL Alias "wxHtmlWindow_SetRelatedStatusBar" (self As wxHtmlWindow Ptr, sb As wxInt)
Declare Sub wxHtmlWindow_SetFonts WXCALL Alias "wxHtmlWindow_SetFonts" (self As wxHtmlWindow Ptr, normal_face As wxString Ptr, fixed_face As wxString Ptr, sizes As wxInt Ptr)
Declare Sub wxHtmlWindow_SetBorders WXCALL Alias "wxHtmlWindow_SetBorders" (self As wxHtmlWindow Ptr, border As wxInt)
Declare Sub wxHtmlWindow_ReadCustomization WXCALL Alias "wxHtmlWindow_ReadCustomization" (self As wxHtmlWindow Ptr, cfg As wxConfigBase Ptr, path As wxString Ptr)
Declare Sub wxHtmlWindow_WriteCustomization WXCALL Alias "wxHtmlWindow_WriteCustomization" (self As wxHtmlWindow Ptr, cfg As wxConfigBase Ptr, path As wxString Ptr)
Declare Function wxHtmlWindow_HistoryBack WXCALL Alias "wxHtmlWindow_HistoryBack" (self As wxHtmlWindow Ptr) As wxBool
Declare Function wxHtmlWindow_HistoryForward WXCALL Alias "wxHtmlWindow_HistoryForward" (self As wxHtmlWindow Ptr) As wxBool
Declare Function wxHtmlWindow_HistoryCanBack WXCALL Alias "wxHtmlWindow_HistoryCanBack" (self As wxHtmlWindow Ptr) As wxBool
Declare Function wxHtmlWindow_HistoryCanForward WXCALL Alias "wxHtmlWindow_HistoryCanForward" (self As wxHtmlWindow Ptr) As wxBool
Declare Sub wxHtmlWindow_HistoryClear WXCALL Alias "wxHtmlWindow_HistoryClear" (self As wxHtmlWindow Ptr)
Declare Function wxHtmlWindow_GetInternalRepresentation WXCALL Alias "wxHtmlWindow_GetInternalRepresentation" (self As wxHtmlWindow Ptr) As wxHtmlContainerCell Ptr 
Declare Sub wxHtmlWindow_AddFilter WXCALL Alias "wxHtmlWindow_AddFilter" (filter As wxHtmlFilter Ptr )
Declare Function wxHtmlWindow_GetParser WXCALL Alias "wxHtmlWindow_GetParser" (self As wxHtmlWindow Ptr) As wxHtmlWinParser Ptr
Declare Sub wxHtmlWindow_AddProcessor WXCALL Alias "wxHtmlWindow_AddProcessor" (self As wxHtmlWindow Ptr, processor As wxHtmlProcessor Ptr)
Declare Sub wxHtmlWindow_AddGlobalProcessor WXCALL Alias "wxHtmlWindow_AddGlobalProcessor" (processor As wxHtmlProcessor Ptr)
Declare Function wxHtmlWindow_AcceptsFocusFromKeyboard WXCALL Alias "wxHtmlWindow_AcceptsFocusFromKeyboard" (self As wxHtmlWindow Ptr) As wxBool
Declare Sub wxHtmlWindow_OnSetTitle WXCALL Alias "wxHtmlWindow_OnSetTitle" (self As wxHtmlWindow Ptr, title As wxString Ptr)
Declare Function wxHtmlWindow_OnCellClicked WXCALL Alias "wxHtmlWindow_OnCellClicked" (self As wxHtmlWindow Ptr, cell As wxHtmlCell Ptr, x As wxCoord, y As wxCoord, evnt As wxMouseEvent Ptr) As wxBool
Declare Sub wxHtmlWindow_OnLinkClicked WXCALL Alias "wxHtmlWindow_OnLinkClicked" (self As wxHtmlWindow Ptr, link As wxHtmlLinkInfo Ptr)
Declare Function wxHtmlWindow_OnOpeningURL WXCALL Alias "wxHtmlWindow_OnOpeningURL" (self As wxHtmlWindow Ptr, typ As wxHtmlURLType, url As wxString Ptr, redirect As wxString Ptr) As wxHtmlOpeningStatus
Declare Sub wxHtmlWindow_SelectAll WXCALL Alias "wxHtmlWindow_SelectAll" (self As wxHtmlWindow Ptr)
Declare Sub wxHtmlWindow_SelectCells WXCALL Alias "wxHtmlWindow_SelectCells" (self As wxHtmlWindow Ptr, cf As wxHtmlCell Ptr, cl As wxHtmlCell Ptr)
Declare Sub wxHtmlWindow_SelectWord WXCALL Alias "wxHtmlWindow_SelectWord" (self As wxHtmlWindow Ptr, p As wxPoint Ptr)
Declare Sub wxHtmlWindow_SelectLine WXCALL Alias "wxHtmlWindow_SelectLine" (self As wxHtmlWindow Ptr, p As wxPoint Ptr)
Declare Function wxHtmlWindow_HasSelection WXCALL Alias "wxHtmlWindow_HasSelection" (self As wxHtmlWindow Ptr) As wxBool
Declare Function wxHtmlWindow_SelectionFromCell WXCALL Alias "wxHtmlWindow_SelectionFromCell" (self As wxHtmlWindow Ptr) As wxHtmlCell Ptr
Declare Function wxHtmlWindow_SelectionToCell WXCALL Alias "wxHtmlWindow_SelectionToCell" (self As wxHtmlWindow Ptr) As wxHtmlCell Ptr
Declare Function wxHtmlWindow_SelectionPosition WXCALL Alias "wxHtmlWindow_SelectionPosition" (self As wxHtmlWindow Ptr, fromX As wxInt Ptr, fromY As wxInt Ptr, toX As wxInt Ptr, toY As wxInt Ptr) As wxBool
Declare Function wxHtmlWindow_ToText WXCALL Alias "wxHtmlWindow_ToText" (self As wxHtmlWindow Ptr) As wxString Ptr
Declare Function wxHtmlWindow_SelectionToText WXCALL Alias "wxHtmlWindow_SelectionToText" (self As wxHtmlWindow Ptr) As wxString Ptr
Declare Function HtmlFontCell_GetWxClassInfo WXCALL Alias "HtmlFontCell_GetWxClassInfo" () As wxClassInfo Ptr
Declare Function wxHtmlFontCell_ctor WXCALL Alias "wxHtmlFontCell_ctor" (font As wxFont Ptr) As wxHtmlFontCell Ptr
Declare Sub wxHtmlFontCell_Draw WXCALL Alias "wxHtmlFontCell_Draw" (self As wxHtmlFontCell Ptr, dc As wxDC Ptr, x As wxInt, y As wxInt, view_y1 As wxInt, view_y2 As wxInt, info As wxHtmlRenderingInfo Ptr)
Declare Sub wxHtmlFontCell_DrawInvisible WXCALL Alias "wxHtmlFontCell_DrawInvisible" (self As wxHtmlFontCell Ptr, dc As wxDC Ptr, x As wxInt, y As wxInt, info As wxHtmlRenderingInfo Ptr)
Declare Function HtmlColourCell_GetWxClassInfo WXCALL Alias "HtmlColourCell_GetWxClassInfo" () As wxClassInfo Ptr
Declare Function wxHtmlColourCell_ctor WXCALL Alias "wxHtmlColourCell_ctor" (col As wxColour Ptr, flags As wxInt) As wxHtmlColourCell Ptr
Declare Sub wxHtmlColourCell_Draw WXCALL Alias "wxHtmlColourCell_Draw" (self As wxHtmlColourCell Ptr, dc As wxDC Ptr, x As wxInt, y As wxInt, view_y1 As wxInt, view_y2 As wxInt, info As wxHtmlRenderingInfo Ptr)
Declare Sub wxHtmlColourCell_DrawInvisible WXCALL Alias "wxHtmlColourCell_DrawInvisible" (self As wxHtmlColourCell Ptr, dc As wxDC Ptr, x As wxInt, y As wxInt, info As wxHtmlRenderingInfo Ptr)
Declare Function wxHtmlLinkInfo_ctor WXCALL Alias "wxHtmlLinkInfo_ctor" () As wxHtmlLinkInfo Ptr
Declare Sub wxHtmlLinkInfo_SetEvent WXCALL Alias "wxHtmlLinkInfo_SetEvent" (self As wxHtmlLinkInfo Ptr, me As wxMouseEvent Ptr)
Declare Sub wxHtmlLinkInfo_SetHtmlCell WXCALL Alias "wxHtmlLinkInfo_SetHtmlCell" (self As wxHtmlLinkInfo Ptr, cell As wxHtmlCell Ptr)
Declare Function wxHtmlLinkInfo_GetHref WXCALL Alias "wxHtmlLinkInfo_GetHref" (self As wxHtmlLinkInfo Ptr) As wxString Ptr
Declare Function wxHtmlLinkInfo_GetTarget WXCALL Alias "wxHtmlLinkInfo_GetTarget" (self As wxHtmlLinkInfo Ptr) As wxString Ptr
Declare Function wxHtmlLinkInfo_GetEvent WXCALL Alias "wxHtmlLinkInfo_GetEvent" (self As wxHtmlLinkInfo Ptr) As wxMouseEvent Ptr
Declare Function wxHtmlLinkInfo_GetHtmlCell WXCALL Alias "wxHtmlLinkInfo_GetHtmlCell" (self As wxHtmlLinkInfo Ptr) As wxHtmlCell Ptr
Declare Function HtmlWidgetCell_GetWxClassInfo WXCALL Alias "HtmlWidgetCell_GetWxClassInfo" () As wxClassInfo Ptr
Declare Function wxHtmlWidgetCell_ctor WXCALL Alias "wxHtmlWidgetCell_ctor" (win As wxWindow Ptr, w As wxInt) As wxHtmlWidgetCell Ptr
Declare Sub wxHtmlWidgetCell_RegisterDispose WXCALL Alias "wxHtmlWidgetCell_RegisterDispose" (self As wxHtmlWidgetCell Ptr, on_dispose As Virtual_Dispose)
Declare Sub wxHtmlWidgetCell_Draw WXCALL Alias "wxHtmlWidgetCell_Draw" (self As wxHtmlWidgetCell Ptr, dc As wxDC Ptr, x As wxInt, y As wxInt, view_y1 As wxInt, view_y2 As wxInt, info As wxHtmlRenderingInfo Ptr)
Declare Sub wxHtmlWidgetCell_DrawInvisible WXCALL Alias "wxHtmlWidgetCell_DrawInvisible" (self As wxHtmlWidgetCell Ptr, dc As wxDC Ptr, x As wxInt, y As wxInt, info As wxHtmlRenderingInfo Ptr)
Declare Sub wxHtmlWidgetCell_Layout WXCALL Alias "wxHtmlWidgetCell_Layout" (self As wxHtmlWidgetCell Ptr, w As wxInt)
Declare Function wxHtmlWidgetCell_GetWindow WXCALL Alias "wxHtmlWidgetCell_GetWindow" (self As wxHtmlWidgetCell Ptr) As wxWindow Ptr
Declare Function wxHtmlWidgetCell_Destroy WXCALL Alias "wxHtmlWidgetCell_Destroy" (self As wxHtmlWidgetCell Ptr) As wxBool
Declare Function HtmlCell_GetWxClassInfo WXCALL Alias "HtmlCell_GetWxClassInfo" () As wxClassInfo Ptr
Declare Function wxHtmlCell_ctor WXCALL Alias "wxHtmlCell_ctor" () As wxHtmlCell Ptr
Declare Sub wxHtmlCell_SetParent WXCALL Alias "wxHtmlCell_SetParent" (self As wxHtmlCell Ptr, parent As wxHtmlContainerCell Ptr)
Declare Function wxHtmlCell_GetParent WXCALL Alias "wxHtmlCell_GetParent" (self As wxHtmlCell Ptr) As wxHtmlContainerCell Ptr
Declare Function wxHtmlCell_GetPosX WXCALL Alias "wxHtmlCell_GetPosX" (self As wxHtmlCell Ptr) As wxInt
Declare Function wxHtmlCell_GetPosY WXCALL Alias "wxHtmlCell_GetPosY" (self As wxHtmlCell Ptr) As wxInt
Declare Sub wxHtmlCell_GetAbsPos WXCALL Alias "wxHtmlCell_GetAbsPos" (self As wxHtmlCell Ptr, rootCell As wxHtmlCell Ptr, x As wxInt Ptr, y As wxInt Ptr)
Declare Function wxHtmlCell_GetWidth WXCALL Alias "wxHtmlCell_GetWidth" (self As wxHtmlCell Ptr) As wxInt
Declare Function wxHtmlCell_GetHeight WXCALL Alias "wxHtmlCell_GetHeight" (self As wxHtmlCell Ptr) As wxInt
Declare Function wxHtmlCell_GetDescent WXCALL Alias "wxHtmlCell_GetDescent" (self As wxHtmlCell Ptr) As wxInt
Declare Function wxHtmlCell_GetId WXCALL Alias "wxHtmlCell_GetId" (self As wxHtmlCell Ptr) As wxString Ptr
Declare Sub wxHtmlCell_SetId WXCALL Alias "wxHtmlCell_SetId" (self As wxHtmlCell Ptr, id As wxString Ptr)
Declare Function wxHtmlCell_GetNext WXCALL Alias "wxHtmlCell_GetNext" (self As wxHtmlCell Ptr) As wxHtmlCell Ptr
Declare Sub wxHtmlCell_SetPos WXCALL Alias "wxHtmlCell_SetPos" (self As wxHtmlCell Ptr, x As wxInt, y As wxInt)
Declare Function wxHtmlCell_GetLink WXCALL Alias "wxHtmlCell_GetLink" (self As wxHtmlCell Ptr) As wxHtmlLinkInfo Ptr
Declare Sub wxHtmlCell_SetLink WXCALL Alias "wxHtmlCell_SetLink" (self As wxHtmlCell Ptr, link As wxHtmlLinkInfo Ptr)
Declare Sub wxHtmlCell_SetNext WXCALL Alias "wxHtmlCell_SetNext" (self As wxHtmlCell Ptr, cell As wxHtmlCell Ptr)
Declare Sub wxHtmlCell_Layout WXCALL Alias "wxHtmlCell_Layout" (self As wxHtmlCell Ptr, w As wxInt)
Declare Sub wxHtmlCell_Draw WXCALL Alias "wxHtmlCell_Draw" (self As wxHtmlCell Ptr, dc As wxDC Ptr, x As wxInt, y As wxInt,  view_y1 As wxInt, view_y2 As wxInt, info As wxHtmlRenderingInfo Ptr)
Declare Sub wxHtmlCell_DrawInvisible WXCALL Alias "wxHtmlCell_DrawInvisible" (self As wxHtmlCell Ptr, dc As wxDC Ptr, x As wxInt, y As wxInt,  info As wxHtmlRenderingInfo Ptr)
Declare Function wxHtmlCell_Find WXCALL Alias "wxHtmlCell_Find" (self As wxHtmlCell Ptr, cond As wxInt, param As Any Ptr) As wxHtmlCell Ptr
Declare Sub wxHtmlCell_OnMouseClick WXCALL Alias "wxHtmlCell_OnMouseClick" (self As wxHtmlCell Ptr, parent As wxWindow Ptr, x As wxInt, y As wxInt, ev As wxMouseEvent Ptr)
Declare Function wxHtmlCell_AdjustPagebreak WXCALL Alias "wxHtmlCell_AdjustPagebreak" (self As wxHtmlCell Ptr, pagebreak As wxInt Ptr) As wxBool
Declare Sub wxHtmlCell_SetCanLiveOnPagebreak WXCALL Alias "wxHtmlCell_SetCanLiveOnPagebreak" (self As wxHtmlCell Ptr, can As wxBool)
Declare Function wxHtmlCell_IsTerminalCell WXCALL Alias "wxHtmlCell_IsTerminalCell" (self As wxHtmlCell Ptr) As wxBool
Declare Function wxHtmlCell_IsFormattingCell WXCALL Alias "wxHtmlCell_IsFormattingCell" (self As wxHtmlCell Ptr) As wxBool
Declare Function wxHtmlCell_FindCellByPos WXCALL Alias "wxHtmlCell_FindCellByPos" (self As wxHtmlCell Ptr, x As wxCoord, y As wxCoord, mode As wxInt) As wxHtmlCell Ptr
Declare Function wxHtmlCell_GetFirstChild WXCALL Alias "wxHtmlCell_GetFirstChild" (self As wxHtmlCell Ptr) As wxHtmlCell Ptr
Declare Function wxHtmlCell_GetFirstTerminal WXCALL Alias "wxHtmlCell_GetFirstTerminal" (self As wxHtmlCell Ptr) As wxHtmlCell Ptr
Declare Function wxHtmlCell_GetLastTerminal WXCALL Alias "wxHtmlCell_GetLastTerminal" (self As wxHtmlCell Ptr) As wxHtmlCell Ptr
Declare Function wxHtmlCell_GetRootCell WXCALL Alias "wxHtmlCell_GetRootCell" (self As wxHtmlCell Ptr) As wxHtmlCell Ptr
Declare Function wxHtmlCell_IsBefore WXCALL Alias "wxHtmlCell_IsBefore" (self As wxHtmlCell Ptr, other As wxHtmlCell Ptr) As wxBool
Declare Function wxHtmlWindow_ConvertToText WXCALL Alias "wxHtmlWindow_ConvertToText" (self As wxHtmlCell Ptr) As wxString Ptr
Declare Function HtmlWordCell_GetWxClassInfo WXCALL Alias "HtmlWordCell_GetWxClassInfo" () As wxClassInfo Ptr
Declare Function wxHtmlWordCell_ctor WXCALL Alias "wxHtmlWordCell_ctor" (word As wxString Ptr, dc As wxDC Ptr) As wxHtmlWordCell Ptr
Declare Sub wxHtmlWordCell_Draw WXCALL Alias "wxHtmlWordCell_Draw" (self As wxHtmlWordCell Ptr, dc As wxDC Ptr, x As wxInt, y As wxInt, view_y1 As wxInt, view_y2 As wxInt, info As wxHtmlRenderingInfo Ptr)
Declare Function HtmlContainerCell_GetWxClassInfo WXCALL Alias "HtmlContainerCell_GetWxClassInfo" () As wxClassInfo Ptr
Declare Function wxHtmlContainerCell_ctor WXCALL Alias "wxHtmlContainerCell_ctor" (parent As wxHtmlContainerCell Ptr) As wxHtmlContainerCell Ptr
Declare Sub wxHtmlContainerCell_Layout WXCALL Alias "wxHtmlContainerCell_Layout" (self As wxHtmlContainerCell Ptr, w As wxInt)
Declare Sub wxHtmlContainerCell_Draw WXCALL Alias "wxHtmlContainerCell_Draw" (self As wxHtmlContainerCell Ptr, dc As wxDC Ptr, x As wxInt, y As wxInt, view_y1 As wxInt, view_y2 As wxInt, info As wxHtmlRenderingInfo Ptr)
Declare Sub wxHtmlContainerCell_DrawInvisible WXCALL Alias "wxHtmlContainerCell_DrawInvisible" (self As wxHtmlContainerCell Ptr, dc As wxDC Ptr, x As wxInt, y As wxInt,  info As wxHtmlRenderingInfo Ptr)
Declare Function wxHtmlContainerCell_AdjustPagebreak WXCALL Alias "wxHtmlContainerCell_AdjustPagebreak" (self As wxHtmlContainerCell Ptr, pagebreak As wxInt Ptr) As wxBool
Declare Sub wxHtmlContainerCell_InsertCell WXCALL Alias "wxHtmlContainerCell_InsertCell" (self As wxHtmlContainerCell Ptr, cell As wxHtmlCell Ptr)
Declare Sub wxHtmlContainerCell_SetAlignHor WXCALL Alias "wxHtmlContainerCell_SetAlignHor" (self As wxHtmlContainerCell Ptr, alignH As wxInt)
Declare Function wxHtmlContainerCell_GetAlignHor WXCALL Alias "wxHtmlContainerCell_GetAlignHor" (self As wxHtmlContainerCell Ptr) As wxInt
Declare Sub wxHtmlContainerCell_SetAlignVer WXCALL Alias "wxHtmlContainerCell_SetAlignVer" (self As wxHtmlContainerCell Ptr, alignV As wxInt)
Declare Function wxHtmlContainerCell_GetAlignVer WXCALL Alias "wxHtmlContainerCell_GetAlignVer" (self As wxHtmlContainerCell Ptr) As wxInt
Declare Sub wxHtmlContainerCell_SetIndent WXCALL Alias "wxHtmlContainerCell_SetIndent" (self As wxHtmlContainerCell Ptr, i As wxInt, what As wxInt, units As wxInt)
Declare Function wxHtmlContainerCell_GetIndent WXCALL Alias "wxHtmlContainerCell_GetIndent" (self As wxHtmlContainerCell Ptr, indent As wxInt) As wxInt
Declare Function wxHtmlContainerCell_GetIndentUnits WXCALL Alias "wxHtmlContainerCell_GetIndentUnits" (self As wxHtmlContainerCell Ptr,idex As wxInt) As wxInt
Declare Sub wxHtmlContainerCell_SetAlign WXCALL Alias "wxHtmlContainerCell_SetAlign" (self As wxHtmlContainerCell Ptr, tag As wxHtmlTag Ptr)
Declare Sub wxHtmlContainerCell_SetWidthFloat WXCALL Alias "wxHtmlContainerCell_SetWidthFloat" (self As wxHtmlContainerCell Ptr, w As wxInt, units As wxInt)
Declare Sub wxHtmlContainerCell_SetWidthFloatTag WXCALL Alias "wxHtmlContainerCell_SetWidthFloatTag" (self As wxHtmlContainerCell Ptr, tag As wxHtmlTag Ptr, pixel_scale As wxDouble)
Declare Sub wxHtmlContainerCell_SetMinHeight WXCALL Alias "wxHtmlContainerCell_SetMinHeight" (self As wxHtmlContainerCell Ptr, h As wxInt, align As wxInt)
Declare Sub wxHtmlContainerCell_SetBackgroundColour WXCALL Alias "wxHtmlContainerCell_SetBackgroundColour" (self As wxHtmlContainerCell Ptr, col As wxColour Ptr)
Declare Function wxHtmlContainerCell_GetBackgroundColour WXCALL Alias "wxHtmlContainerCell_GetBackgroundColour" (self As wxHtmlContainerCell Ptr) As wxColour Ptr
Declare Sub wxHtmlContainerCell_SetBorder WXCALL Alias "wxHtmlContainerCell_SetBorder" (self As wxHtmlContainerCell Ptr, col1 As wxColour Ptr, col2 As wxColour Ptr)
Declare Function wxHtmlContainerCell_GetLink WXCALL Alias "wxHtmlContainerCell_GetLink" (self As wxHtmlContainerCell Ptr, x As wxInt, y As wxInt) As wxHtmlLinkInfo Ptr
Declare Function wxHtmlContainerCell_Find WXCALL Alias "wxHtmlContainerCell_Find" (self As wxHtmlContainerCell Ptr, cond As wxInt, param As Any Ptr) As wxHtmlCell Ptr
Declare Sub wxHtmlContainerCell_OnMouseClick WXCALL Alias "wxHtmlContainerCell_OnMouseClick" (self As wxHtmlContainerCell Ptr, parent As wxWindow Ptr, x As wxInt, y As wxInt, ev As wxMouseEvent Ptr)
Declare Sub wxHtmlTag_dtor WXCALL Alias "wxHtmlTag_dtor" (self As wxHtmlTag Ptr)
Declare Function wxHtmlTag_GetParent WXCALL Alias "wxHtmlTag_GetParent" (self As wxHtmlTag Ptr) As wxHtmlTag Ptr
Declare Function wxHtmlTag_GetFirstSibling WXCALL Alias "wxHtmlTag_GetFirstSibling" (self As wxHtmlTag Ptr) As wxHtmlTag Ptr
Declare Function wxHtmlTag_GetLastSibling WXCALL Alias "wxHtmlTag_GetLastSibling" (self As wxHtmlTag Ptr) As wxHtmlTag Ptr
Declare Function wxHtmlTag_GetChildren WXCALL Alias "wxHtmlTag_GetChildren" (self As wxHtmlTag Ptr) As wxHtmlTag Ptr
Declare Function wxHtmlTag_GetPreviousSibling WXCALL Alias "wxHtmlTag_GetPreviousSibling" (self As wxHtmlTag Ptr) As wxHtmlTag Ptr
Declare Function wxHtmlTag_GetNextSibling WXCALL Alias "wxHtmlTag_GetNextSibling" (self As wxHtmlTag Ptr) As wxHtmlTag Ptr
Declare Function wxHtmlTag_GetNextTag WXCALL Alias "wxHtmlTag_GetNextTag" (self As wxHtmlTag Ptr) As wxHtmlTag Ptr
Declare Function wxHtmlTag_GetName WXCALL Alias "wxHtmlTag_GetName" (self As wxHtmlTag Ptr) As wxString Ptr
Declare Function wxHtmlTag_HasParam WXCALL Alias "wxHtmlTag_HasParam" (self As wxHtmlTag Ptr, par As wxString Ptr) As wxBool
Declare Function wxHtmlTag_GetParam WXCALL Alias "wxHtmlTag_GetParam" (self As wxHtmlTag Ptr, par As wxString Ptr, with_commas As wxBool ) As wxString Ptr
Declare Function wxHtmlTag_GetParamAsColour WXCALL Alias "wxHtmlTag_GetParamAsColour" (self As wxHtmlTag Ptr, par As wxString Ptr, col As wxColour Ptr) As wxBool
Declare Function wxHtmlTag_GetParamAsInt WXCALL Alias "wxHtmlTag_GetParamAsInt" (self As wxHtmlTag Ptr, par As wxString Ptr, clr As wxInt Ptr) As wxBool
Declare Function wxHtmlTag_GetAllParams WXCALL Alias "wxHtmlTag_GetAllParams" (self As wxHtmlTag Ptr) As wxString Ptr
Declare Function wxHtmlTag_HasEnding WXCALL Alias "wxHtmlTag_HasEnding" (self As wxHtmlTag Ptr) As wxBool
Declare Function wxHtmlTag_GetBeginPos WXCALL Alias "wxHtmlTag_GetBeginPos" (self As wxHtmlTag Ptr) As wxInt
Declare Function wxHtmlTag_GetEndPos1 WXCALL Alias "wxHtmlTag_GetEndPos1" (self As wxHtmlTag Ptr)  As wxInt
Declare Function wxHtmlTag_GetEndPos2 WXCALL Alias "wxHtmlTag_GetEndPos2" (self As wxHtmlTag Ptr) As wxInt
Declare Function wxHtmlFilter_CanRead WXCALL Alias "wxHtmlFilter_CanRead" (self As wxHtmlFilter Ptr, file As wxFSFile Ptr) As wxBool
Declare Function wxHtmlFilter_ReadFile WXCALL Alias "wxHtmlFilter_ReadFile" (self As wxHtmlFilter Ptr, file As wxFSFile Ptr) As wxString Ptr
Declare Function wxHtmlFilterPlainText_CanRead WXCALL Alias "wxHtmlFilterPlainText_CanRead" (self As wxHtmlFilterPlainText Ptr, file As wxFSFile Ptr) As wxBool
Declare Function wxHtmlFilterPlainText_ReadFile WXCALL Alias "wxHtmlFilterPlainText_ReadFile" (self As wxHtmlFilterPlainText Ptr, file As wxFSFile Ptr) As wxString Ptr
Declare Function wxHtmlFilterHTML_CanRead WXCALL Alias "wxHtmlFilterHTML_CanRead" (self As wxHtmlFilterHTML Ptr, file As wxFSFile Ptr) As wxBool
Declare Function wxHtmlFilterHTML_ReadFile WXCALL Alias "wxHtmlFilterHTML_ReadFile" (self As wxHtmlFilterHTML Ptr, file As wxFSFile Ptr) As wxString Ptr
Declare Function wxHtmlTagsModule_ctor WXCALL Alias "wxHtmlTagsModule_ctor" () As wxHtmlTagsModule Ptr
Declare Function wxHtmlTagsModule_OnInit WXCALL Alias "wxHtmlTagsModule_OnInit" (self As wxHtmlTagsModule Ptr) As wxBool
Declare Sub wxHtmlTagsModule_OnExit WXCALL Alias "wxHtmlTagsModule_OnExit" (self As wxHtmlTagsModule Ptr)
Declare Sub wxHtmlTagsModule_FillHandlersTable WXCALL Alias "wxHtmlTagsModule_FillHandlersTable" (self As wxHtmlTagsModule Ptr, parser As wxHtmlWinParser Ptr)
Declare Function wxHtmlWinParser_ctor WXCALL Alias "wxHtmlWinParser_ctor" (win As wxHtmlWindow Ptr) As wxHtmlWinParser Ptr
Declare Sub wxHtmlWinParser_InitParser WXCALL Alias "wxHtmlWinParser_InitParser" (self As wxHtmlWinParser Ptr, src As wxString Ptr)
Declare Sub wxHtmlWinParser_DoneParser WXCALL Alias "wxHtmlWinParser_DoneParser" (self As wxHtmlWinParser Ptr)
Declare Function wxHtmlWinParser_GetProduct WXCALL Alias "wxHtmlWinParser_GetProduct" (self As wxHtmlWinParser Ptr) As wxObject Ptr
Declare Function wxHtmlWinParser_OpenURL WXCALL Alias "wxHtmlWinParser_OpenURL" (self As wxHtmlWinParser Ptr, typ As wxHtmlURLType, url As wxString Ptr) As wxFSFile Ptr 
Declare Sub wxHtmlWinParser_SetDC WXCALL Alias "wxHtmlWinParser_SetDC" (self As wxHtmlWinParser Ptr, dc As wxDC Ptr, pixelscale As wxDouble)
Declare Function wxHtmlWinParser_GetDC WXCALL Alias "wxHtmlWinParser_GetDC" (self As wxHtmlWinParser Ptr) As wxDC Ptr
Declare Function wxHtmlWinParser_GetPixelScale WXCALL Alias "wxHtmlWinParser_GetPixelScale" (self As wxHtmlWinParser Ptr) As wxDouble
Declare Function wxHtmlWinParser_GetCharHeight WXCALL Alias "wxHtmlWinParser_GetCharHeight" (self As wxHtmlWinParser Ptr) As wxInt
Declare Function wxHtmlWinParser_GetCharWidth WXCALL Alias "wxHtmlWinParser_GetCharWidth" (self As wxHtmlWinParser Ptr) As wxInt
Declare Function wxHtmlWinParser_GetWindow WXCALL Alias "wxHtmlWinParser_GetWindow" (self As wxHtmlWinParser Ptr) As wxHtmlWindow Ptr
Declare Sub wxHtmlWinParser_SetFonts WXCALL Alias "wxHtmlWinParser_SetFonts" (self As wxHtmlWinParser Ptr, normalFace As wxString Ptr, fixedFace As wxString Ptr, sizes As wxInt Ptr)
Declare Sub wxHtmlWinParser_AddModule WXCALL Alias "wxHtmlWinParser_AddModule" (self As wxHtmlWinParser Ptr, module As wxHtmlTagsModule Ptr)
Declare Sub wxHtmlWinParser_RemoveModule WXCALL Alias "wxHtmlWinParser_RemoveModule" (self As wxHtmlWinParser Ptr, module As wxHtmlTagsModule Ptr)
Declare Function wxHtmlWinParser_GetContainer WXCALL Alias "wxHtmlWinParser_GetContainer" (self As wxHtmlWinParser Ptr) As wxHtmlContainerCell Ptr
Declare Function wxHtmlWinParser_OpenContainer WXCALL Alias "wxHtmlWinParser_OpenContainer" (self As wxHtmlWinParser Ptr) As wxHtmlContainerCell Ptr
Declare Function wxHtmlWinParser_SetContainer WXCALL Alias "wxHtmlWinParser_SetContainer" (self As wxHtmlWinParser Ptr, cell As wxHtmlContainerCell Ptr) As wxHtmlContainerCell Ptr
Declare Function wxHtmlWinParser_CloseContainer WXCALL Alias "wxHtmlWinParser_CloseContainer" (self As wxHtmlWinParser Ptr) As wxHtmlContainerCell Ptr
Declare Function wxHtmlWinParser_GetFontSize WXCALL Alias "wxHtmlWinParser_GetFontSize" (self As wxHtmlWinParser Ptr) As wxInt
Declare Sub wxHtmlWinParser_SetFontSize WXCALL Alias "wxHtmlWinParser_SetFontSize" (self As wxHtmlWinParser Ptr, size As wxInt)
Declare Function wxHtmlWinParser_GetFontBold WXCALL Alias "wxHtmlWinParser_GetFontBold" (self As wxHtmlWinParser Ptr) As wxInt
Declare Sub wxHtmlWinParser_SetFontBold WXCALL Alias "wxHtmlWinParser_SetFontBold" (self As wxHtmlWinParser Ptr, b As wxInt)
Declare Function wxHtmlWinParser_GetFontItalic WXCALL Alias "wxHtmlWinParser_GetFontItalic" (self As wxHtmlWinParser Ptr) As wxInt
Declare Sub wxHtmlWinParser_SetFontItalic WXCALL Alias "wxHtmlWinParser_SetFontItalic" (self As wxHtmlWinParser Ptr, i As wxInt)
Declare Function wxHtmlWinParser_GetFontUnderlined WXCALL Alias "wxHtmlWinParser_GetFontUnderlined" (self As wxHtmlWinParser Ptr) As wxInt
Declare Sub wxHtmlWinParser_SetFontUnderlined WXCALL Alias "wxHtmlWinParser_SetFontUnderlined" (self As wxHtmlWinParser Ptr, u As wxInt)
Declare Function wxHtmlWinParser_GetFontFixed WXCALL Alias "wxHtmlWinParser_GetFontFixed" (self As wxHtmlWinParser Ptr) As wxInt
Declare Sub wxHtmlWinParser_SetFontFixed WXCALL Alias "wxHtmlWinParser_SetFontFixed" (self As wxHtmlWinParser Ptr, f As wxInt)
Declare Function wxHtmlWinParser_GetFontFace WXCALL Alias "wxHtmlWinParser_GetFontFace" (self As wxHtmlWinParser Ptr) As wxString Ptr
Declare Sub wxHtmlWinParser_SetFontFace WXCALL Alias "wxHtmlWinParser_SetFontFace" (self As wxHtmlWinParser Ptr, face As wxString Ptr)
Declare Function wxHtmlWinParser_GetAlign WXCALL Alias "wxHtmlWinParser_GetAlign" (self As wxHtmlWinParser Ptr) As wxInt
Declare Sub wxHtmlWinParser_SetAlign WXCALL Alias "wxHtmlWinParser_SetAlign" (self As wxHtmlWinParser Ptr, align As wxInt)
Declare Function wxHtmlWinParser_GetLinkColor WXCALL Alias "wxHtmlWinParser_GetLinkColor" (self As wxHtmlWinParser Ptr) As wxColour Ptr 
Declare Sub wxHtmlWinParser_SetLinkColor WXCALL Alias "wxHtmlWinParser_SetLinkColor" (self As wxHtmlWinParser Ptr, col As wxColour Ptr)
Declare Function wxHtmlWinParser_GetActualColor WXCALL Alias "wxHtmlWinParser_GetActualColor" (self As wxHtmlWinParser Ptr) As wxColour Ptr 
Declare Sub wxHtmlWinParser_SetActualColor WXCALL Alias "wxHtmlWinParser_SetActualColor" (self As wxHtmlWinParser Ptr, col As wxColour Ptr)
Declare Function wxHtmlWinParser_GetLink WXCALL Alias "wxHtmlWinParser_GetLink" (self As wxHtmlWinParser Ptr) As wxHtmlLinkInfo Ptr
Declare Sub wxHtmlWinParser_SetLink WXCALL Alias "wxHtmlWinParser_SetLink" (self As wxHtmlWinParser Ptr, link As wxHtmlLinkInfo Ptr)
Declare Function wxHtmlWinParser_CreateCurrentFont WXCALL Alias "wxHtmlWinParser_CreateCurrentFont" (self As wxHtmlWinParser Ptr) As wxFont Ptr
Declare Function wxHtmlTagHandler_CTor WXCALL Alias "wxHtmlTagHandler_CTor" () As wxHtmlTagHandler Ptr
Declare Sub wxHtmlTagHandler_RegisterVirtual WXCALL Alias "wxHtmlTagHandler_RegisterVirtual" (self As wxHtmlTagHandler Ptr, on_dispose As Virtual_Dispose, getSupportedTagsCall As Virtual_GetSupportedTags, getHandleTagCall As Virtual_GetHandleTag)
Declare Function wxHtmlTagHandler_GetParser WXCALL Alias "wxHtmlTagHandler_GetParser" (self As wxHtmlTagHandler Ptr) As wxHtmlParser Ptr
Declare Function wxHtmlTagHandler_GetWParser WXCALL Alias "wxHtmlTagHandler_GetWParser" (self As wxHtmlTagHandler Ptr) As wxHtmlParser Ptr
Declare Sub wxHtmlTagHandler_ParseInner WXCALL Alias "wxHtmlTagHandler_ParseInner" (self As wxHtmlTagHandler Ptr, tag As wxHtmlTag Ptr)
Declare Sub wxHtmlTagHandler_SetParser WXCALL Alias "wxHtmlTagHandler_SetParser" (self As wxHtmlTagHandler Ptr, parser As wxHtmlParser Ptr)
Declare Function wxHtmlEntitiesParser_ctor WXCALL Alias "wxHtmlEntitiesParser_ctor" () As wxHtmlEntitiesParser Ptr
Declare Sub wxHtmlEntitiesParser_dtor WXCALL Alias "wxHtmlEntitiesParser_dtor" (self As wxHtmlEntitiesParser Ptr)
Declare Sub wxHtmlEntitiesParser_SetEncoding WXCALL Alias "wxHtmlEntitiesParser_SetEncoding" (self As wxHtmlEntitiesParser Ptr, enc As wxFontEncoding)
Declare Function wxHtmlEntitiesParser_Parse WXCALL Alias "wxHtmlEntitiesParser_Parse" (self As wxHtmlEntitiesParser Ptr, in As wxString Ptr) As wxString Ptr
Declare Function wxHtmlEntitiesParser_GetEntityChar WXCALL Alias "wxHtmlEntitiesParser_GetEntityChar" (self As wxHtmlEntitiesParser Ptr, entity As wxString Ptr) As wxChar
Declare Function wxHtmlEntitiesParser_GetCharForCode WXCALL Alias "wxHtmlEntitiesParser_GetCharForCode" (self As wxHtmlEntitiesParser Ptr, code As wxChar) As wxChar
Declare Function wxHtmlParser_IsWinParser WXCALL Alias "wxHtmlParser_IsWinParser" (self As wxHtmlParser Ptr) As wxBool
Declare Sub wxHtmlParser_SetFS WXCALL Alias "wxHtmlParser_SetFS" (self As wxHtmlParser Ptr, fs As wxFileSystem Ptr)
Declare Function wxHtmlParser_GetFS WXCALL Alias "wxHtmlParser_GetFS" (self As wxHtmlParser Ptr) As wxFileSystem Ptr
Declare Function wxHtmlParser_OpenURL WXCALL Alias "wxHtmlParser_OpenURL" (self As wxHtmlParser Ptr, typ As wxHtmlURLType, url As wxString Ptr) As wxFSFile Ptr
Declare Function wxHtmlParser_Parse WXCALL Alias "wxHtmlParser_Parse" (self As wxHtmlParser Ptr, source As wxString Ptr) As wxObject Ptr
Declare Sub wxHtmlParser_InitParser WXCALL Alias "wxHtmlParser_InitParser" (self As wxHtmlParser Ptr, source As wxString Ptr)
Declare Sub wxHtmlParser_DoneParser WXCALL Alias "wxHtmlParser_DoneParser" (self As wxHtmlParser Ptr)
Declare Sub wxHtmlParser_StopParsing WXCALL Alias "wxHtmlParser_StopParsing" (self As wxHtmlParser Ptr)
Declare Sub wxHtmlParser_DoParsing WXCALL Alias "wxHtmlParser_DoParsing" (self As wxHtmlParser Ptr, beginPos As wxInt, endPos As wxInt)
Declare Sub wxHtmlParser_DoParsingAll WXCALL Alias "wxHtmlParser_DoParsingAll" (self As wxHtmlParser Ptr)
Declare Function wxHtmlParser_GetCurrentTag WXCALL Alias "wxHtmlParser_GetCurrentTag" (self As wxHtmlParser Ptr) As wxHtmlTag Ptr
Declare Function wxHtmlParser_GetProduct WXCALL Alias "wxHtmlParser_GetProduct" (self As wxHtmlParser Ptr) As wxObject Ptr
Declare Sub wxHtmlParser_AddTagHandler WXCALL Alias "wxHtmlParser_AddTagHandler" (self As wxHtmlParser Ptr, handler As wxHtmlTagHandler Ptr)
Declare Sub wxHtmlParser_PushTagHandler WXCALL Alias "wxHtmlParser_PushTagHandler" (self As wxHtmlParser Ptr, handler As wxHtmlTagHandler Ptr, tags As wxString Ptr)
Declare Sub wxHtmlParser_PopTagHandler WXCALL Alias "wxHtmlParser_PopTagHandler" (self As wxHtmlParser Ptr)
Declare Function wxHtmlParser_GetSource WXCALL Alias "wxHtmlParser_GetSource" (self As wxHtmlParser Ptr) As wxString Ptr 
Declare Sub wxHtmlParser_SetSource WXCALL Alias "wxHtmlParser_SetSource" (self As wxHtmlParser Ptr, src  As wxString Ptr)
Declare Sub wxHtmlParser_SetSourceAndSaveState WXCALL Alias "wxHtmlParser_SetSourceAndSaveState" (self As wxHtmlParser Ptr, src As wxString Ptr)
Declare Function wxHtmlParser_RestoreState WXCALL Alias "wxHtmlParser_RestoreState" (self As wxHtmlParser Ptr) As wxBool
Declare Function wxHtmlParser_ExtractCharsetInformation WXCALL Alias "wxHtmlParser_ExtractCharsetInformation" (self As wxHtmlParser Ptr, markup As wxString Ptr) As wxString Ptr
Declare Function wxHtmlProcessor_GetPriority WXCALL Alias "wxHtmlProcessor_GetPriority" (self As wxHtmlProcessor Ptr) As wxInt
Declare Sub wxHtmlProcessor_Enable WXCALL Alias "wxHtmlProcessor_Enable" (self As wxHtmlProcessor Ptr, enable As wxBool)
Declare Function wxHtmlProcessor_IsEnabled WXCALL Alias "wxHtmlProcessor_IsEnabled" (self As wxHtmlProcessor Ptr) As wxBool
Declare Function wxHtmlRenderingInfo_ctor WXCALL Alias "wxHtmlRenderingInfo_ctor" () As wxHtmlRenderingInfo Ptr
Declare Sub wxHtmlRenderingInfo_dtor WXCALL Alias "wxHtmlRenderingInfo_dtor" (self As wxHtmlRenderingInfo Ptr)
Declare Sub wxHtmlRenderingInfo_SetSelection WXCALL Alias "wxHtmlRenderingInfo_SetSelection" (self As wxHtmlRenderingInfo Ptr, selection As wxHtmlSelection Ptr)
Declare Function wxHtmlRenderingInfo_GetSelection WXCALL Alias "wxHtmlRenderingInfo_GetSelection" (self As wxHtmlRenderingInfo Ptr) As wxHtmlSelection Ptr
Declare Function wxHtmlSelection_ctor WXCALL Alias "wxHtmlSelection_ctor" () As wxHtmlSelection Ptr
Declare Sub wxHtmlSelection_dtor WXCALL Alias "wxHtmlSelection_dtor" (self As wxHtmlSelection Ptr)
Declare Sub wxHtmlSelection_Set WXCALL Alias "wxHtmlSelection_Set" (self As wxHtmlSelection Ptr, fromPos As wxPoint Ptr, fromCell As wxHtmlCell Ptr, toPos As wxPoint Ptr, toCell As wxHtmlCell Ptr)
Declare Sub wxHtmlSelection_Set2 WXCALL Alias "wxHtmlSelection_Set2" (self As wxHtmlSelection Ptr, fromCell As wxHtmlCell Ptr, toCell As wxHtmlCell Ptr)
Declare Function wxHtmlSelection_GetFromCell WXCALL Alias "wxHtmlSelection_GetFromCell" (self As wxHtmlSelection Ptr) As wxHtmlCell Ptr
Declare Function wxHtmlSelection_GetToCell WXCALL Alias "wxHtmlSelection_GetToCell" (self As wxHtmlSelection Ptr) As wxHtmlCell Ptr
Declare Sub wxHtmlSelection_GetFromPos WXCALL Alias "wxHtmlSelection_GetFromPos" (self As wxHtmlSelection Ptr, fromPos As wxPoint Ptr)
Declare Sub wxHtmlSelection_GetToPos WXCALL Alias "wxHtmlSelection_GetToPos" (self As wxHtmlSelection Ptr, toPos As wxPoint Ptr)
Declare Sub wxHtmlSelection_GetFromPrivPos WXCALL Alias "wxHtmlSelection_GetFromPrivPos" (self As wxHtmlSelection Ptr, fromPrivPos As wxPoint Ptr)
Declare Sub wxHtmlSelection_GetToPrivPos WXCALL Alias "wxHtmlSelection_GetToPrivPos" (self As wxHtmlSelection Ptr, toPrivPos As wxPoint Ptr)
Declare Sub wxHtmlSelection_SetFromPrivPos WXCALL Alias "wxHtmlSelection_SetFromPrivPos" (self As wxHtmlSelection Ptr, p As wxPoint Ptr)
Declare Sub wxHtmlSelection_SetToPrivPos WXCALL Alias "wxHtmlSelection_SetToPrivPos" (self As wxHtmlSelection Ptr, p As wxPoint Ptr)
Declare Sub wxHtmlSelection_ClearPrivPos WXCALL Alias "wxHtmlSelection_ClearPrivPos" (self As wxHtmlSelection Ptr)
Declare Function wxHtmlSelection_IsEmpty WXCALL Alias "wxHtmlSelection_IsEmpty" (self As wxHtmlSelection Ptr) As wxBool
Declare Function wxHtmlEasyPrinting_ctor WXCALL Alias "wxHtmlEasyPrinting_ctor" (nam As wxString Ptr, parent As wxWindow Ptr) As wxHtmlEasyPrinting Ptr 
Declare Function wxHtmlEasyPrinting_PreviewFile WXCALL Alias "wxHtmlEasyPrinting_PreviewFile" (self As wxHtmlEasyPrinting Ptr, htmlfile As wxString Ptr) As wxBool
Declare Function wxHtmlEasyPrinting_PreviewText WXCALL Alias "wxHtmlEasyPrinting_PreviewText" (self As wxHtmlEasyPrinting Ptr, htmltext As wxString Ptr, basepath As wxString Ptr) As wxBool
Declare Function wxHtmlEasyPrinting_PrintFile WXCALL Alias "wxHtmlEasyPrinting_PrintFile" (self As wxHtmlEasyPrinting Ptr, htmlfile As wxString Ptr) As wxBool
Declare Function wxHtmlEasyPrinting_PrintText WXCALL Alias "wxHtmlEasyPrinting_PrintText" (self As wxHtmlEasyPrinting Ptr, htmltext As wxString Ptr, basepath As wxString Ptr) As wxBool
Declare Sub wxHtmlEasyPrinting_PageSetup WXCALL Alias "wxHtmlEasyPrinting_PageSetup" (self As wxHtmlEasyPrinting Ptr)
Declare Sub wxHtmlEasyPrinting_SetHeader WXCALL Alias "wxHtmlEasyPrinting_SetHeader" (self As wxHtmlEasyPrinting Ptr, header As wxString Ptr, page As wxInt)
Declare Sub wxHtmlEasyPrinting_SetFooter WXCALL Alias "wxHtmlEasyPrinting_SetFooter" (self As wxHtmlEasyPrinting Ptr, footer As wxString Ptr, page As wxInt)
Declare Sub wxHtmlEasyPrinting_SetFonts WXCALL Alias "wxHtmlEasyPrinting_SetFonts" (self As wxHtmlEasyPrinting Ptr, normalFace As wxString Ptr, fixedFace As wxString Ptr, sizes As wxInt Ptr)
Declare Sub wxHtmlEasyPrinting_SetStandardFonts WXCALL Alias "wxHtmlEasyPrinting_SetStandardFonts" (self As wxHtmlEasyPrinting Ptr, size As wxInt, normalFace As wxString Ptr, fixedFace As wxString Ptr)
Declare Function wxHtmlEasyPrinting_GetPrintData WXCALL Alias "wxHtmlEasyPrinting_GetPrintData" (self As wxHtmlEasyPrinting Ptr) As wxPrintData Ptr
Declare Function wxHtmlEasyPrinting_GetPageSetupData WXCALL Alias "wxHtmlEasyPrinting_GetPageSetupData" (self As wxHtmlEasyPrinting Ptr) As wxPageSetupDialogData Ptr

#EndIf ' __html_bi__

