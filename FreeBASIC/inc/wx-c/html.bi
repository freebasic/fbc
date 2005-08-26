''
''
'' html -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __html_bi__
#define __html_bi__

#include once "wx-c/wx.bi"


type Virtual_OnLinkClicked as sub (byval as wxHtmlLinkInfo ptr)
type Virtual_OnSetTitle as sub (byval as wxString ptr)
type Virtual_OnCellMouseHover as sub (byval as wxHtmlCell ptr, byval as wxCoord, byval as wxCoord)
type Virtual_OnCellClicked as sub (byval as wxHtmlCell ptr, byval as wxCoord, byval as wxCoord, byval as wxMouseEvent ptr)
type Virtual_OnOpeningURL as function (byval as wxHtmlURLType, byval as wxString ptr, byval as wxString ptr) as wxHtmlOpeningStatus

declare function wxHtmlWindow cdecl alias "wxHtmlWindow_ctor" () as wxHtmlWindow ptr
declare function wxHtmlWindow_ctor2 cdecl alias "wxHtmlWindow_ctor2" (byval parent as wxWindow ptr, byval id as wxWindowID, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval name as zstring ptr) as wxHtmlWindow ptr
declare sub wxHtmlWindow_RegisterVirtual cdecl alias "wxHtmlWindow_RegisterVirtual" (byval self as _HtmlWindow ptr, byval onLinkClicked as Virtual_OnLinkClicked, byval onSetTitle as Virtual_OnSetTitle, byval onCellMouseHover as Virtual_OnCellMouseHover, byval onCellClicked as Virtual_OnCellClicked, byval onOpeningURL as Virtual_OnOpeningURL)
declare function wxHtmlWindow_Create cdecl alias "wxHtmlWindow_Create" (byval self as _HtmlWindow ptr, byval parent as wxWindow ptr, byval id as wxWindowID, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval name as zstring ptr) as integer
declare function wxHtmlWindow_SetPage cdecl alias "wxHtmlWindow_SetPage" (byval self as _HtmlWindow ptr, byval source as zstring ptr) as integer
declare function wxHtmlWindow_AppendToPage cdecl alias "wxHtmlWindow_AppendToPage" (byval self as _HtmlWindow ptr, byval source as zstring ptr) as integer
declare function wxHtmlWindow_LoadPage cdecl alias "wxHtmlWindow_LoadPage" (byval self as _HtmlWindow ptr, byval location as zstring ptr) as integer
declare function wxHtmlWindow_LoadFile cdecl alias "wxHtmlWindow_LoadFile" (byval self as _HtmlWindow ptr, byval filename as zstring ptr) as integer
declare function wxHtmlWindow_GetOpenedPage cdecl alias "wxHtmlWindow_GetOpenedPage" (byval self as _HtmlWindow ptr) as wxString ptr
declare function wxHtmlWindow_GetOpenedAnchor cdecl alias "wxHtmlWindow_GetOpenedAnchor" (byval self as _HtmlWindow ptr) as wxString ptr
declare function wxHtmlWindow_GetOpenedPageTitle cdecl alias "wxHtmlWindow_GetOpenedPageTitle" (byval self as _HtmlWindow ptr) as wxString ptr
declare sub wxHtmlWindow_SetRelatedFrame cdecl alias "wxHtmlWindow_SetRelatedFrame" (byval self as _HtmlWindow ptr, byval frame as wxFrame ptr, byval format as zstring ptr)
declare function wxHtmlWindow_GetRelatedFrame cdecl alias "wxHtmlWindow_GetRelatedFrame" (byval self as _HtmlWindow ptr) as wxFrame ptr
declare sub wxHtmlWindow_SetRelatedStatusBar cdecl alias "wxHtmlWindow_SetRelatedStatusBar" (byval self as _HtmlWindow ptr, byval bar as integer)
declare sub wxHtmlWindow_SetFonts cdecl alias "wxHtmlWindow_SetFonts" (byval self as _HtmlWindow ptr, byval normal_face as zstring ptr, byval fixed_face as zstring ptr, byval sizes as integer ptr)
declare sub wxHtmlWindow_SetBorders cdecl alias "wxHtmlWindow_SetBorders" (byval self as _HtmlWindow ptr, byval b as integer)
declare sub wxHtmlWindow_ReadCustomization cdecl alias "wxHtmlWindow_ReadCustomization" (byval self as _HtmlWindow ptr, byval cfg as wxConfigBase ptr, byval path as zstring ptr)
declare sub wxHtmlWindow_WriteCustomization cdecl alias "wxHtmlWindow_WriteCustomization" (byval self as _HtmlWindow ptr, byval cfg as wxConfigBase ptr, byval path as zstring ptr)
declare function wxHtmlWindow_HistoryBack cdecl alias "wxHtmlWindow_HistoryBack" (byval self as _HtmlWindow ptr) as integer
declare function wxHtmlWindow_HistoryForward cdecl alias "wxHtmlWindow_HistoryForward" (byval self as _HtmlWindow ptr) as integer
declare function wxHtmlWindow_HistoryCanBack cdecl alias "wxHtmlWindow_HistoryCanBack" (byval self as _HtmlWindow ptr) as integer
declare function wxHtmlWindow_HistoryCanForward cdecl alias "wxHtmlWindow_HistoryCanForward" (byval self as _HtmlWindow ptr) as integer
declare sub wxHtmlWindow_HistoryClear cdecl alias "wxHtmlWindow_HistoryClear" (byval self as _HtmlWindow ptr)
declare function wxHtmlWindow_GetInternalRepresentation cdecl alias "wxHtmlWindow_GetInternalRepresentation" (byval self as _HtmlWindow ptr) as wxHtmlContainerCell ptr
declare sub wxHtmlWindow_AddFilter cdecl alias "wxHtmlWindow_AddFilter" (byval filter as wxHtmlFilter ptr)
declare function wxHtmlWindow_GetParser cdecl alias "wxHtmlWindow_GetParser" (byval self as _HtmlWindow ptr) as wxHtmlWinParser ptr
declare sub wxHtmlWindow_AddProcessor cdecl alias "wxHtmlWindow_AddProcessor" (byval self as _HtmlWindow ptr, byval processor as wxHtmlProcessor ptr)
declare sub wxHtmlWindow_AddGlobalProcessor cdecl alias "wxHtmlWindow_AddGlobalProcessor" (byval processor as wxHtmlProcessor ptr)
declare function wxHtmlWindow_AcceptsFocusFromKeyboard cdecl alias "wxHtmlWindow_AcceptsFocusFromKeyboard" (byval self as _HtmlWindow ptr) as integer
declare sub wxHtmlWindow_OnSetTitle cdecl alias "wxHtmlWindow_OnSetTitle" (byval self as _HtmlWindow ptr, byval title as zstring ptr)
declare sub wxHtmlWindow_OnCellClicked cdecl alias "wxHtmlWindow_OnCellClicked" (byval self as _HtmlWindow ptr, byval cell as wxHtmlCell ptr, byval x as wxCoord, byval y as wxCoord, byval event as wxMouseEvent ptr)
declare sub wxHtmlWindow_OnLinkClicked cdecl alias "wxHtmlWindow_OnLinkClicked" (byval self as _HtmlWindow ptr, byval link as wxHtmlLinkInfo ptr)
declare function wxHtmlWindow_OnOpeningURL cdecl alias "wxHtmlWindow_OnOpeningURL" (byval self as _HtmlWindow ptr, byval type as wxHtmlURLType, byval url as zstring ptr, byval redirect as zstring ptr) as wxHtmlOpeningStatus
declare sub wxHtmlWindow_SelectAll cdecl alias "wxHtmlWindow_SelectAll" (byval self as _HtmlWindow ptr)
declare sub wxHtmlWindow_SelectWord cdecl alias "wxHtmlWindow_SelectWord" (byval self as _HtmlWindow ptr, byval pos as wxPoint ptr)
declare sub wxHtmlWindow_SelectLine cdecl alias "wxHtmlWindow_SelectLine" (byval self as _HtmlWindow ptr, byval pos as wxPoint ptr)
declare function wxHtmlWindow_ToText cdecl alias "wxHtmlWindow_ToText" (byval self as _HtmlWindow ptr) as wxString ptr
declare function wxHtmlWindow_SelectionToText cdecl alias "wxHtmlWindow_SelectionToText" (byval self as _HtmlWindow ptr) as wxString ptr
declare function wxHtmlFontCell cdecl alias "wxHtmlFontCell_ctor" (byval font as wxFont ptr) as wxHtmlFontCell ptr
declare sub wxHtmlFontCell_Draw cdecl alias "wxHtmlFontCell_Draw" (byval self as wxHtmlFontCell ptr, byval dc as wxDC ptr, byval x as integer, byval y as integer, byval view_y1 as integer, byval view_y2 as integer, byval info as wxHtmlRenderingInfo ptr)
declare sub wxHtmlFontCell_DrawInvisible cdecl alias "wxHtmlFontCell_DrawInvisible" (byval self as wxHtmlFontCell ptr, byval dc as wxDC ptr, byval x as integer, byval y as integer, byval info as wxHtmlRenderingInfo ptr)
declare function wxHtmlColourCell cdecl alias "wxHtmlColourCell_ctor" (byval clr as wxColour ptr, byval flags as integer) as wxHtmlColourCell ptr
declare sub wxHtmlColourCell_Draw cdecl alias "wxHtmlColourCell_Draw" (byval self as wxHtmlColourCell ptr, byval dc as wxDC ptr, byval x as integer, byval y as integer, byval view_y1 as integer, byval view_y2 as integer, byval info as wxHtmlRenderingInfo ptr)
declare sub wxHtmlColourCell_DrawInvisible cdecl alias "wxHtmlColourCell_DrawInvisible" (byval self as wxHtmlColourCell ptr, byval dc as wxDC ptr, byval x as integer, byval y as integer, byval info as wxHtmlRenderingInfo ptr)
declare function wxHtmlLinkInfo cdecl alias "wxHtmlLinkInfo_ctor" () as wxHtmlLinkInfo ptr
declare sub wxHtmlLinkInfo_SetEvent cdecl alias "wxHtmlLinkInfo_SetEvent" (byval self as wxHtmlLinkInfo ptr, byval e as wxMouseEvent ptr)
declare sub wxHtmlLinkInfo_SetHtmlCell cdecl alias "wxHtmlLinkInfo_SetHtmlCell" (byval self as wxHtmlLinkInfo ptr, byval e as wxHtmlCell ptr)
declare function wxHtmlLinkInfo_GetHref cdecl alias "wxHtmlLinkInfo_GetHref" (byval self as wxHtmlLinkInfo ptr) as wxString ptr
declare function wxHtmlLinkInfo_GetTarget cdecl alias "wxHtmlLinkInfo_GetTarget" (byval self as wxHtmlLinkInfo ptr) as wxString ptr
declare function wxHtmlLinkInfo_GetEvent cdecl alias "wxHtmlLinkInfo_GetEvent" (byval self as wxHtmlLinkInfo ptr) as wxMouseEvent ptr
declare function wxHtmlLinkInfo_GetHtmlCell cdecl alias "wxHtmlLinkInfo_GetHtmlCell" (byval self as wxHtmlLinkInfo ptr) as wxHtmlCell ptr
declare function wxHtmlWidgetCell cdecl alias "wxHtmlWidgetCell_ctor" (byval wnd as wxWindow ptr, byval w as integer) as wxHtmlWidgetCell ptr
declare sub wxHtmlWidgetCell_Draw cdecl alias "wxHtmlWidgetCell_Draw" (byval self as wxHtmlWidgetCell ptr, byval dc as wxDC ptr, byval x as integer, byval y as integer, byval view_y1 as integer, byval view_y2 as integer, byval info as wxHtmlRenderingInfo ptr)
declare sub wxHtmlWidgetCell_DrawInvisible cdecl alias "wxHtmlWidgetCell_DrawInvisible" (byval self as wxHtmlWidgetCell ptr, byval dc as wxDC ptr, byval x as integer, byval y as integer, byval info as wxHtmlRenderingInfo ptr)
declare sub wxHtmlWidgetCell_Layout cdecl alias "wxHtmlWidgetCell_Layout" (byval self as wxHtmlWidgetCell ptr, byval w as integer)
declare function wxHtmlCell cdecl alias "wxHtmlCell_ctor" () as wxHtmlCell ptr
declare sub wxHtmlCell_SetParent cdecl alias "wxHtmlCell_SetParent" (byval self as wxHtmlCell ptr, byval p as wxHtmlContainerCell ptr)
declare function wxHtmlCell_GetParent cdecl alias "wxHtmlCell_GetParent" (byval self as wxHtmlCell ptr) as wxHtmlContainerCell ptr
declare function wxHtmlCell_GetPosX cdecl alias "wxHtmlCell_GetPosX" (byval self as wxHtmlCell ptr) as integer
declare function wxHtmlCell_GetPosY cdecl alias "wxHtmlCell_GetPosY" (byval self as wxHtmlCell ptr) as integer
declare function wxHtmlCell_GetWidth cdecl alias "wxHtmlCell_GetWidth" (byval self as wxHtmlCell ptr) as integer
declare function wxHtmlCell_GetHeight cdecl alias "wxHtmlCell_GetHeight" (byval self as wxHtmlCell ptr) as integer
declare function wxHtmlCell_GetDescent cdecl alias "wxHtmlCell_GetDescent" (byval self as wxHtmlCell ptr) as integer
declare function wxHtmlCell_GetId cdecl alias "wxHtmlCell_GetId" (byval self as wxHtmlCell ptr) as wxString ptr
declare sub wxHtmlCell_SetId cdecl alias "wxHtmlCell_SetId" (byval self as wxHtmlCell ptr, byval id as zstring ptr)
declare function wxHtmlCell_GetNext cdecl alias "wxHtmlCell_GetNext" (byval self as wxHtmlCell ptr) as wxHtmlCell ptr
declare sub wxHtmlCell_SetPos cdecl alias "wxHtmlCell_SetPos" (byval self as wxHtmlCell ptr, byval x as integer, byval y as integer)
declare sub wxHtmlCell_SetLink cdecl alias "wxHtmlCell_SetLink" (byval self as wxHtmlCell ptr, byval link as wxHtmlLinkInfo ptr)
declare sub wxHtmlCell_SetNext cdecl alias "wxHtmlCell_SetNext" (byval self as wxHtmlCell ptr, byval cell as wxHtmlCell ptr)
declare sub wxHtmlCell_Layout cdecl alias "wxHtmlCell_Layout" (byval self as wxHtmlCell ptr, byval w as integer)
declare sub wxHtmlCell_Draw cdecl alias "wxHtmlCell_Draw" (byval self as wxHtmlCell ptr, byval dc as wxDC ptr, byval x as integer, byval y as integer, byval view_y1 as integer, byval view_y2 as integer, byval info as wxHtmlRenderingInfo ptr)
declare sub wxHtmlCell_DrawInvisible cdecl alias "wxHtmlCell_DrawInvisible" (byval self as wxHtmlCell ptr, byval dc as wxDC ptr, byval x as integer, byval y as integer, byval info as wxHtmlRenderingInfo ptr)
declare function wxHtmlCell_Find cdecl alias "wxHtmlCell_Find" (byval self as wxHtmlCell ptr, byval condition as integer, byval param as any ptr) as wxHtmlCell ptr
declare sub wxHtmlCell_OnMouseClick cdecl alias "wxHtmlCell_OnMouseClick" (byval self as wxHtmlCell ptr, byval parent as wxWindow ptr, byval x as integer, byval y as integer, byval event as wxMouseEvent ptr)
declare function wxHtmlCell_AdjustPagebreak cdecl alias "wxHtmlCell_AdjustPagebreak" (byval self as wxHtmlCell ptr, byval pagebreak as integer ptr) as integer
declare sub wxHtmlCell_SetCanLiveOnPagebreak cdecl alias "wxHtmlCell_SetCanLiveOnPagebreak" (byval self as wxHtmlCell ptr, byval can as integer)
declare function wxHtmlCell_IsTerminalCell cdecl alias "wxHtmlCell_IsTerminalCell" (byval self as wxHtmlCell ptr) as integer
declare function wxHtmlCell_FindCellByPos cdecl alias "wxHtmlCell_FindCellByPos" (byval self as wxHtmlCell ptr, byval x as wxCoord, byval y as wxCoord) as wxHtmlCell ptr
declare function wxHtmlWordCell cdecl alias "wxHtmlWordCell_ctor" (byval word as zstring ptr, byval dc as wxDC ptr) as wxHtmlWordCell ptr
declare sub wxHtmlWordCell_Draw cdecl alias "wxHtmlWordCell_Draw" (byval self as wxHtmlWordCell ptr, byval dc as wxDC ptr, byval x as integer, byval y as integer, byval view_y1 as integer, byval view_y2 as integer, byval info as wxHtmlRenderingInfo ptr)
declare function wxHtmlContainerCell cdecl alias "wxHtmlContainerCell_ctor" (byval parent as wxHtmlContainerCell ptr) as wxHtmlContainerCell ptr
declare sub wxHtmlContainerCell_Layout cdecl alias "wxHtmlContainerCell_Layout" (byval self as wxHtmlContainerCell ptr, byval w as integer)
declare sub wxHtmlContainerCell_Draw cdecl alias "wxHtmlContainerCell_Draw" (byval self as wxHtmlContainerCell ptr, byval dc as wxDC ptr, byval x as integer, byval y as integer, byval view_y1 as integer, byval view_y2 as integer, byval info as wxHtmlRenderingInfo ptr)
declare sub wxHtmlContainerCell_DrawInvisible cdecl alias "wxHtmlContainerCell_DrawInvisible" (byval self as wxHtmlContainerCell ptr, byval dc as wxDC ptr, byval x as integer, byval y as integer, byval info as wxHtmlRenderingInfo ptr)
declare function wxHtmlContainerCell_AdjustPagebreak cdecl alias "wxHtmlContainerCell_AdjustPagebreak" (byval self as wxHtmlContainerCell ptr, byval pagebreak as integer ptr) as integer
declare sub wxHtmlContainerCell_InsertCell cdecl alias "wxHtmlContainerCell_InsertCell" (byval self as wxHtmlContainerCell ptr, byval cell as wxHtmlCell ptr)
declare sub wxHtmlContainerCell_SetAlignHor cdecl alias "wxHtmlContainerCell_SetAlignHor" (byval self as wxHtmlContainerCell ptr, byval al as integer)
declare function wxHtmlContainerCell_GetAlignHor cdecl alias "wxHtmlContainerCell_GetAlignHor" (byval self as wxHtmlContainerCell ptr) as integer
declare sub wxHtmlContainerCell_SetAlignVer cdecl alias "wxHtmlContainerCell_SetAlignVer" (byval self as wxHtmlContainerCell ptr, byval al as integer)
declare function wxHtmlContainerCell_GetAlignVer cdecl alias "wxHtmlContainerCell_GetAlignVer" (byval self as wxHtmlContainerCell ptr) as integer
declare sub wxHtmlContainerCell_SetIndent cdecl alias "wxHtmlContainerCell_SetIndent" (byval self as wxHtmlContainerCell ptr, byval i as integer, byval what as integer, byval units as integer)
declare function wxHtmlContainerCell_GetIndent cdecl alias "wxHtmlContainerCell_GetIndent" (byval self as wxHtmlContainerCell ptr, byval ind as integer) as integer
declare function wxHtmlContainerCell_GetIndentUnits cdecl alias "wxHtmlContainerCell_GetIndentUnits" (byval self as wxHtmlContainerCell ptr, byval ind as integer) as integer
declare sub wxHtmlContainerCell_SetAlign cdecl alias "wxHtmlContainerCell_SetAlign" (byval self as wxHtmlContainerCell ptr, byval tag as wxHtmlTag ptr)
declare sub wxHtmlContainerCell_SetWidthFloat cdecl alias "wxHtmlContainerCell_SetWidthFloat" (byval self as wxHtmlContainerCell ptr, byval w as integer, byval units as integer)
declare sub wxHtmlContainerCell_SetWidthFloatTag cdecl alias "wxHtmlContainerCell_SetWidthFloatTag" (byval self as wxHtmlContainerCell ptr, byval tag as wxHtmlTag ptr, byval pixel_scale as double)
declare sub wxHtmlContainerCell_SetMinHeight cdecl alias "wxHtmlContainerCell_SetMinHeight" (byval self as wxHtmlContainerCell ptr, byval h as integer, byval align as integer)
declare sub wxHtmlContainerCell_SetBackgroundColour cdecl alias "wxHtmlContainerCell_SetBackgroundColour" (byval self as wxHtmlContainerCell ptr, byval clr as wxColour ptr)
declare function wxHtmlContainerCell_GetBackgroundColour cdecl alias "wxHtmlContainerCell_GetBackgroundColour" (byval self as wxHtmlContainerCell ptr) as wxColour ptr
declare sub wxHtmlContainerCell_SetBorder cdecl alias "wxHtmlContainerCell_SetBorder" (byval self as wxHtmlContainerCell ptr, byval clr1 as wxColour ptr, byval clr2 as wxColour ptr)
declare function wxHtmlContainerCell_GetLink cdecl alias "wxHtmlContainerCell_GetLink" (byval self as wxHtmlContainerCell ptr, byval x as integer, byval y as integer) as wxHtmlLinkInfo ptr
declare function wxHtmlContainerCell_Find cdecl alias "wxHtmlContainerCell_Find" (byval self as wxHtmlContainerCell ptr, byval condition as integer, byval param as any ptr) as wxHtmlCell ptr
declare sub wxHtmlContainerCell_OnMouseClick cdecl alias "wxHtmlContainerCell_OnMouseClick" (byval self as wxHtmlContainerCell ptr, byval parent as wxWindow ptr, byval x as integer, byval y as integer, byval event as wxMouseEvent ptr)
declare function wxHtmlContainerCell_IsTerminalCell cdecl alias "wxHtmlContainerCell_IsTerminalCell" (byval self as wxHtmlContainerCell ptr) as integer
declare function wxHtmlContainerCell_FindCellByPos cdecl alias "wxHtmlContainerCell_FindCellByPos" (byval self as wxHtmlContainerCell ptr, byval x as wxCoord, byval y as wxCoord) as wxHtmlCell ptr
declare function wxHtmlTag_GetParent cdecl alias "wxHtmlTag_GetParent" (byval self as wxHtmlTag ptr) as wxHtmlTag ptr
declare function wxHtmlTag_GetFirstSibling cdecl alias "wxHtmlTag_GetFirstSibling" (byval self as wxHtmlTag ptr) as wxHtmlTag ptr
declare function wxHtmlTag_GetLastSibling cdecl alias "wxHtmlTag_GetLastSibling" (byval self as wxHtmlTag ptr) as wxHtmlTag ptr
declare function wxHtmlTag_GetChildren cdecl alias "wxHtmlTag_GetChildren" (byval self as wxHtmlTag ptr) as wxHtmlTag ptr
declare function wxHtmlTag_GetPreviousSibling cdecl alias "wxHtmlTag_GetPreviousSibling" (byval self as wxHtmlTag ptr) as wxHtmlTag ptr
declare function wxHtmlTag_GetNextSibling cdecl alias "wxHtmlTag_GetNextSibling" (byval self as wxHtmlTag ptr) as wxHtmlTag ptr
declare function wxHtmlTag_GetNextTag cdecl alias "wxHtmlTag_GetNextTag" (byval self as wxHtmlTag ptr) as wxHtmlTag ptr
declare function wxHtmlTag_GetName cdecl alias "wxHtmlTag_GetName" (byval self as wxHtmlTag ptr) as wxString ptr
declare function wxHtmlTag_HasParam cdecl alias "wxHtmlTag_HasParam" (byval self as wxHtmlTag ptr, byval par as zstring ptr) as integer
declare function wxHtmlTag_GetParam cdecl alias "wxHtmlTag_GetParam" (byval self as wxHtmlTag ptr, byval par as zstring ptr, byval with_commas as integer) as wxString ptr
declare function wxHtmlTag_GetParamAsColour cdecl alias "wxHtmlTag_GetParamAsColour" (byval self as wxHtmlTag ptr, byval par as zstring ptr, byval clr as wxColour ptr) as integer
declare function wxHtmlTag_GetParamAsInt cdecl alias "wxHtmlTag_GetParamAsInt" (byval self as wxHtmlTag ptr, byval par as zstring ptr, byval clr as integer ptr) as integer
declare function wxHtmlTag_ScanParam cdecl alias "wxHtmlTag_ScanParam" (byval self as wxHtmlTag ptr, byval par as zstring ptr, byval format as zstring ptr, byval param as any ptr) as integer
declare function wxHtmlTag_GetAllParams cdecl alias "wxHtmlTag_GetAllParams" (byval self as wxHtmlTag ptr) as wxString ptr
declare function wxHtmlTag_HasEnding cdecl alias "wxHtmlTag_HasEnding" (byval self as wxHtmlTag ptr) as integer
declare function wxHtmlTag_GetBeginPos cdecl alias "wxHtmlTag_GetBeginPos" (byval self as wxHtmlTag ptr) as integer
declare function wxHtmlTag_GetEndPos1 cdecl alias "wxHtmlTag_GetEndPos1" (byval self as wxHtmlTag ptr) as integer
declare function wxHtmlTag_GetEndPos2 cdecl alias "wxHtmlTag_GetEndPos2" (byval self as wxHtmlTag ptr) as integer
declare function wxHtmlFilter_CanRead cdecl alias "wxHtmlFilter_CanRead" (byval self as wxHtmlFilter ptr, byval file as wxFSFile ptr) as integer
declare function wxHtmlFilter_ReadFile cdecl alias "wxHtmlFilter_ReadFile" (byval self as wxHtmlFilter ptr, byval file as wxFSFile ptr) as wxString ptr
declare function wxHtmlFilterPlainText_CanRead cdecl alias "wxHtmlFilterPlainText_CanRead" (byval self as wxHtmlFilterPlainText ptr, byval file as wxFSFile ptr) as integer
declare function wxHtmlFilterPlainText_ReadFile cdecl alias "wxHtmlFilterPlainText_ReadFile" (byval self as wxHtmlFilterPlainText ptr, byval file as wxFSFile ptr) as wxString ptr
declare function wxHtmlFilterHTML_CanRead cdecl alias "wxHtmlFilterHTML_CanRead" (byval self as wxHtmlFilterHTML ptr, byval file as wxFSFile ptr) as integer
declare function wxHtmlFilterHTML_ReadFile cdecl alias "wxHtmlFilterHTML_ReadFile" (byval self as wxHtmlFilterHTML ptr, byval file as wxFSFile ptr) as wxString ptr
declare function wxHtmlTagsModule cdecl alias "wxHtmlTagsModule_ctor" () as wxHtmlTagsModule ptr
declare function wxHtmlTagsModule_OnInit cdecl alias "wxHtmlTagsModule_OnInit" (byval self as wxHtmlTagsModule ptr) as integer
declare sub wxHtmlTagsModule_OnExit cdecl alias "wxHtmlTagsModule_OnExit" (byval self as wxHtmlTagsModule ptr)
declare sub wxHtmlTagsModule_FillHandlersTable cdecl alias "wxHtmlTagsModule_FillHandlersTable" (byval self as wxHtmlTagsModule ptr, byval parser as wxHtmlWinParser ptr)
declare function wxHtmlWinParser cdecl alias "wxHtmlWinParser_ctor" (byval wnd as wxHtmlWindow ptr) as wxHtmlWinParser ptr
declare sub wxHtmlWinParser_InitParser cdecl alias "wxHtmlWinParser_InitParser" (byval self as wxHtmlWinParser ptr, byval source as zstring ptr)
declare sub wxHtmlWinParser_DoneParser cdecl alias "wxHtmlWinParser_DoneParser" (byval self as wxHtmlWinParser ptr)
declare function wxHtmlWinParser_GetProduct cdecl alias "wxHtmlWinParser_GetProduct" (byval self as wxHtmlWinParser ptr) as wxObject ptr
declare function wxHtmlWinParser_OpenURL cdecl alias "wxHtmlWinParser_OpenURL" (byval self as wxHtmlWinParser ptr, byval type as wxHtmlURLType, byval url as zstring ptr) as wxFSFile ptr
declare sub wxHtmlWinParser_SetDC cdecl alias "wxHtmlWinParser_SetDC" (byval self as wxHtmlWinParser ptr, byval dc as wxDC ptr, byval pixel_scale as double)
declare function wxHtmlWinParser_GetDC cdecl alias "wxHtmlWinParser_GetDC" (byval self as wxHtmlWinParser ptr) as wxDC ptr
declare function wxHtmlWinParser_GetPixelScale cdecl alias "wxHtmlWinParser_GetPixelScale" (byval self as wxHtmlWinParser ptr) as double
declare function wxHtmlWinParser_GetCharHeight cdecl alias "wxHtmlWinParser_GetCharHeight" (byval self as wxHtmlWinParser ptr) as integer
declare function wxHtmlWinParser_GetCharWidth cdecl alias "wxHtmlWinParser_GetCharWidth" (byval self as wxHtmlWinParser ptr) as integer
declare function wxHtmlWinParser_GetWindow cdecl alias "wxHtmlWinParser_GetWindow" (byval self as wxHtmlWinParser ptr) as wxHtmlWindow ptr
declare sub wxHtmlWinParser_SetFonts cdecl alias "wxHtmlWinParser_SetFonts" (byval self as wxHtmlWinParser ptr, byval normal_face as zstring ptr, byval fixed_face as zstring ptr, byval sizes as integer ptr)
declare sub wxHtmlWinParser_AddModule cdecl alias "wxHtmlWinParser_AddModule" (byval self as wxHtmlWinParser ptr, byval module as wxHtmlTagsModule ptr)
declare sub wxHtmlWinParser_RemoveModule cdecl alias "wxHtmlWinParser_RemoveModule" (byval self as wxHtmlWinParser ptr, byval module as wxHtmlTagsModule ptr)
declare function wxHtmlWinParser_GetContainer cdecl alias "wxHtmlWinParser_GetContainer" (byval self as wxHtmlWinParser ptr) as wxHtmlContainerCell ptr
declare function wxHtmlWinParser_OpenContainer cdecl alias "wxHtmlWinParser_OpenContainer" (byval self as wxHtmlWinParser ptr) as wxHtmlContainerCell ptr
declare function wxHtmlWinParser_SetContainer cdecl alias "wxHtmlWinParser_SetContainer" (byval self as wxHtmlWinParser ptr, byval c as wxHtmlContainerCell ptr) as wxHtmlContainerCell ptr
declare function wxHtmlWinParser_CloseContainer cdecl alias "wxHtmlWinParser_CloseContainer" (byval self as wxHtmlWinParser ptr) as wxHtmlContainerCell ptr
declare function wxHtmlWinParser_GetFontSize cdecl alias "wxHtmlWinParser_GetFontSize" (byval self as wxHtmlWinParser ptr) as integer
declare sub wxHtmlWinParser_SetFontSize cdecl alias "wxHtmlWinParser_SetFontSize" (byval self as wxHtmlWinParser ptr, byval s as integer)
declare function wxHtmlWinParser_GetFontBold cdecl alias "wxHtmlWinParser_GetFontBold" (byval self as wxHtmlWinParser ptr) as integer
declare sub wxHtmlWinParser_SetFontBold cdecl alias "wxHtmlWinParser_SetFontBold" (byval self as wxHtmlWinParser ptr, byval x as integer)
declare function wxHtmlWinParser_GetFontItalic cdecl alias "wxHtmlWinParser_GetFontItalic" (byval self as wxHtmlWinParser ptr) as integer
declare sub wxHtmlWinParser_SetFontItalic cdecl alias "wxHtmlWinParser_SetFontItalic" (byval self as wxHtmlWinParser ptr, byval x as integer)
declare function wxHtmlWinParser_GetFontUnderlined cdecl alias "wxHtmlWinParser_GetFontUnderlined" (byval self as wxHtmlWinParser ptr) as integer
declare sub wxHtmlWinParser_SetFontUnderlined cdecl alias "wxHtmlWinParser_SetFontUnderlined" (byval self as wxHtmlWinParser ptr, byval x as integer)
declare function wxHtmlWinParser_GetFontFixed cdecl alias "wxHtmlWinParser_GetFontFixed" (byval self as wxHtmlWinParser ptr) as integer
declare sub wxHtmlWinParser_SetFontFixed cdecl alias "wxHtmlWinParser_SetFontFixed" (byval self as wxHtmlWinParser ptr, byval x as integer)
declare function wxHtmlWinParser_GetFontFace cdecl alias "wxHtmlWinParser_GetFontFace" (byval self as wxHtmlWinParser ptr) as wxString ptr
declare sub wxHtmlWinParser_SetFontFace cdecl alias "wxHtmlWinParser_SetFontFace" (byval self as wxHtmlWinParser ptr, byval face as zstring ptr)
declare function wxHtmlWinParser_GetAlign cdecl alias "wxHtmlWinParser_GetAlign" (byval self as wxHtmlWinParser ptr) as integer
declare sub wxHtmlWinParser_SetAlign cdecl alias "wxHtmlWinParser_SetAlign" (byval self as wxHtmlWinParser ptr, byval a as integer)
declare function wxHtmlWinParser_GetLinkColor cdecl alias "wxHtmlWinParser_GetLinkColor" (byval self as wxHtmlWinParser ptr) as wxColour ptr
declare sub wxHtmlWinParser_SetLinkColor cdecl alias "wxHtmlWinParser_SetLinkColor" (byval self as wxHtmlWinParser ptr, byval clr as wxColour ptr)
declare function wxHtmlWinParser_GetActualColor cdecl alias "wxHtmlWinParser_GetActualColor" (byval self as wxHtmlWinParser ptr) as wxColour ptr
declare sub wxHtmlWinParser_SetActualColor cdecl alias "wxHtmlWinParser_SetActualColor" (byval self as wxHtmlWinParser ptr, byval clr as wxColour ptr)
declare function wxHtmlWinParser_GetLink cdecl alias "wxHtmlWinParser_GetLink" (byval self as wxHtmlWinParser ptr) as wxHtmlLinkInfo ptr
declare sub wxHtmlWinParser_SetLink cdecl alias "wxHtmlWinParser_SetLink" (byval self as wxHtmlWinParser ptr, byval link as wxHtmlLinkInfo ptr)
declare function wxHtmlWinParser_CreateCurrentFont cdecl alias "wxHtmlWinParser_CreateCurrentFont" (byval self as wxHtmlWinParser ptr) as wxFont ptr
declare sub wxHtmlTagHandler_SetParser cdecl alias "wxHtmlTagHandler_SetParser" (byval self as wxHtmlTagHandler ptr, byval parser as wxHtmlParser ptr)
declare function wxHtmlTagHandler_HandleTag cdecl alias "wxHtmlTagHandler_HandleTag" (byval self as wxHtmlTagHandler ptr, byval tag as wxHtmlTag ptr) as integer
declare function wxHtmlEntitiesParser cdecl alias "wxHtmlEntitiesParser_ctor" () as wxHtmlEntitiesParser ptr
declare sub wxHtmlEntitiesParser_dtor cdecl alias "wxHtmlEntitiesParser_dtor" (byval self as wxHtmlEntitiesParser ptr)
declare sub wxHtmlEntitiesParser_SetEncoding cdecl alias "wxHtmlEntitiesParser_SetEncoding" (byval self as wxHtmlEntitiesParser ptr, byval encoding as wxFontEncoding)
declare function wxHtmlEntitiesParser_Parse cdecl alias "wxHtmlEntitiesParser_Parse" (byval self as wxHtmlEntitiesParser ptr, byval input as zstring ptr) as wxString ptr
declare function wxHtmlEntitiesParser_GetEntityChar cdecl alias "wxHtmlEntitiesParser_GetEntityChar" (byval self as wxHtmlEntitiesParser ptr, byval entity as zstring ptr) as byte
declare function wxHtmlEntitiesParser_GetCharForCode cdecl alias "wxHtmlEntitiesParser_GetCharForCode" (byval self as wxHtmlEntitiesParser ptr, byval code as uinteger) as byte
declare sub wxHtmlParser_SetFS cdecl alias "wxHtmlParser_SetFS" (byval self as wxHtmlParser ptr, byval fs as wxFileSystem ptr)
declare function wxHtmlParser_GetFS cdecl alias "wxHtmlParser_GetFS" (byval self as wxHtmlParser ptr) as wxFileSystem ptr
declare function wxHtmlParser_OpenURL cdecl alias "wxHtmlParser_OpenURL" (byval self as wxHtmlParser ptr, byval type as wxHtmlURLType, byval url as zstring ptr) as wxFSFile ptr
declare function wxHtmlParser_Parse cdecl alias "wxHtmlParser_Parse" (byval self as wxHtmlParser ptr, byval source as zstring ptr) as wxObject ptr
declare sub wxHtmlParser_InitParser cdecl alias "wxHtmlParser_InitParser" (byval self as wxHtmlParser ptr, byval source as zstring ptr)
declare sub wxHtmlParser_DoneParser cdecl alias "wxHtmlParser_DoneParser" (byval self as wxHtmlParser ptr)
declare sub wxHtmlParser_StopParsing cdecl alias "wxHtmlParser_StopParsing" (byval self as wxHtmlParser ptr)
declare sub wxHtmlParser_DoParsing cdecl alias "wxHtmlParser_DoParsing" (byval self as wxHtmlParser ptr, byval begin_pos as integer, byval end_pos as integer)
declare sub wxHtmlParser_DoParsingAll cdecl alias "wxHtmlParser_DoParsingAll" (byval self as wxHtmlParser ptr)
declare function wxHtmlParser_GetCurrentTag cdecl alias "wxHtmlParser_GetCurrentTag" (byval self as wxHtmlParser ptr) as wxHtmlTag ptr
declare function wxHtmlParser_GetProduct cdecl alias "wxHtmlParser_GetProduct" (byval self as wxHtmlParser ptr) as wxObject ptr
declare sub wxHtmlParser_AddTagHandler cdecl alias "wxHtmlParser_AddTagHandler" (byval self as wxHtmlParser ptr, byval handler as wxHtmlTagHandler ptr)
declare sub wxHtmlParser_PushTagHandler cdecl alias "wxHtmlParser_PushTagHandler" (byval self as wxHtmlParser ptr, byval handler as wxHtmlTagHandler ptr, byval tags as zstring ptr)
declare sub wxHtmlParser_PopTagHandler cdecl alias "wxHtmlParser_PopTagHandler" (byval self as wxHtmlParser ptr)
declare function wxHtmlParser_GetSource cdecl alias "wxHtmlParser_GetSource" (byval self as wxHtmlParser ptr) as wxString ptr
declare sub wxHtmlParser_SetSource cdecl alias "wxHtmlParser_SetSource" (byval self as wxHtmlParser ptr, byval src as zstring ptr)
declare sub wxHtmlParser_SetSourceAndSaveState cdecl alias "wxHtmlParser_SetSourceAndSaveState" (byval self as wxHtmlParser ptr, byval src as zstring ptr)
declare function wxHtmlParser_RestoreState cdecl alias "wxHtmlParser_RestoreState" (byval self as wxHtmlParser ptr) as integer
declare function wxHtmlParser_ExtractCharsetInformation cdecl alias "wxHtmlParser_ExtractCharsetInformation" (byval self as wxHtmlParser ptr, byval markup as zstring ptr) as wxString ptr
declare function wxHtmlProcessor_GetPriority cdecl alias "wxHtmlProcessor_GetPriority" (byval self as wxHtmlProcessor ptr) as integer
declare sub wxHtmlProcessor_Enable cdecl alias "wxHtmlProcessor_Enable" (byval self as wxHtmlProcessor ptr, byval enable as integer)
declare function wxHtmlProcessor_IsEnabled cdecl alias "wxHtmlProcessor_IsEnabled" (byval self as wxHtmlProcessor ptr) as integer
declare function wxHtmlRenderingInfo cdecl alias "wxHtmlRenderingInfo_ctor" () as wxHtmlRenderingInfo ptr
declare sub wxHtmlRenderingInfo_dtor cdecl alias "wxHtmlRenderingInfo_dtor" (byval self as wxHtmlRenderingInfo ptr)
declare sub wxHtmlRenderingInfo_SetSelection cdecl alias "wxHtmlRenderingInfo_SetSelection" (byval self as wxHtmlRenderingInfo ptr, byval s as wxHtmlSelection ptr)
declare function wxHtmlRenderingInfo_GetSelection cdecl alias "wxHtmlRenderingInfo_GetSelection" (byval self as wxHtmlRenderingInfo ptr) as wxHtmlSelection ptr
declare function wxHtmlSelection cdecl alias "wxHtmlSelection_ctor" () as wxHtmlSelection ptr
declare sub wxHtmlSelection_dtor cdecl alias "wxHtmlSelection_dtor" (byval self as wxHtmlSelection ptr)
declare sub wxHtmlSelection_Set cdecl alias "wxHtmlSelection_Set" (byval self as wxHtmlSelection ptr, byval fromPos as wxPoint ptr, byval fromCell as wxHtmlCell ptr, byval toPos as wxPoint ptr, byval toCell as wxHtmlCell ptr)
declare sub wxHtmlSelection_Set2 cdecl alias "wxHtmlSelection_Set2" (byval self as wxHtmlSelection ptr, byval fromCell as wxHtmlCell ptr, byval toCell as wxHtmlCell ptr)
declare function wxHtmlSelection_GetFromCell cdecl alias "wxHtmlSelection_GetFromCell" (byval self as wxHtmlSelection ptr) as wxHtmlCell ptr
declare function wxHtmlSelection_GetToCell cdecl alias "wxHtmlSelection_GetToCell" (byval self as wxHtmlSelection ptr) as wxHtmlCell ptr
declare sub wxHtmlSelection_GetFromPos cdecl alias "wxHtmlSelection_GetFromPos" (byval self as wxHtmlSelection ptr, byval fromPos as wxPoint ptr)
declare sub wxHtmlSelection_GetToPos cdecl alias "wxHtmlSelection_GetToPos" (byval self as wxHtmlSelection ptr, byval toPos as wxPoint ptr)
declare sub wxHtmlSelection_GetFromPrivPos cdecl alias "wxHtmlSelection_GetFromPrivPos" (byval self as wxHtmlSelection ptr, byval fromPrivPos as wxPoint ptr)
declare sub wxHtmlSelection_GetToPrivPos cdecl alias "wxHtmlSelection_GetToPrivPos" (byval self as wxHtmlSelection ptr, byval toPrivPos as wxPoint ptr)
declare sub wxHtmlSelection_SetFromPrivPos cdecl alias "wxHtmlSelection_SetFromPrivPos" (byval self as wxHtmlSelection ptr, byval pos as wxPoint ptr)
declare sub wxHtmlSelection_SetToPrivPos cdecl alias "wxHtmlSelection_SetToPrivPos" (byval self as wxHtmlSelection ptr, byval pos as wxPoint ptr)
declare sub wxHtmlSelection_ClearPrivPos cdecl alias "wxHtmlSelection_ClearPrivPos" (byval self as wxHtmlSelection ptr)
declare function wxHtmlSelection_IsEmpty cdecl alias "wxHtmlSelection_IsEmpty" (byval self as wxHtmlSelection ptr) as integer
declare function wxHtmlEasyPrinting cdecl alias "wxHtmlEasyPrinting_ctor" (byval name as zstring ptr, byval parent as wxWindow ptr) as wxHtmlEasyPrinting ptr
declare function wxHtmlEasyPrinting_PreviewFile cdecl alias "wxHtmlEasyPrinting_PreviewFile" (byval self as wxHtmlEasyPrinting ptr, byval htmlfile as zstring ptr) as integer
declare function wxHtmlEasyPrinting_PreviewText cdecl alias "wxHtmlEasyPrinting_PreviewText" (byval self as wxHtmlEasyPrinting ptr, byval htmltext as zstring ptr, byval basepath as zstring ptr) as integer
declare function wxHtmlEasyPrinting_PrintFile cdecl alias "wxHtmlEasyPrinting_PrintFile" (byval self as wxHtmlEasyPrinting ptr, byval htmlfile as zstring ptr) as integer
declare function wxHtmlEasyPrinting_PrintText cdecl alias "wxHtmlEasyPrinting_PrintText" (byval self as wxHtmlEasyPrinting ptr, byval htmltext as zstring ptr, byval basepath as zstring ptr) as integer
declare sub wxHtmlEasyPrinting_PrinterSetup cdecl alias "wxHtmlEasyPrinting_PrinterSetup" (byval self as wxHtmlEasyPrinting ptr)
declare sub wxHtmlEasyPrinting_PageSetup cdecl alias "wxHtmlEasyPrinting_PageSetup" (byval self as wxHtmlEasyPrinting ptr)
declare sub wxHtmlEasyPrinting_SetHeader cdecl alias "wxHtmlEasyPrinting_SetHeader" (byval self as wxHtmlEasyPrinting ptr, byval header as zstring ptr, byval pg as integer)
declare sub wxHtmlEasyPrinting_SetFooter cdecl alias "wxHtmlEasyPrinting_SetFooter" (byval self as wxHtmlEasyPrinting ptr, byval footer as zstring ptr, byval pg as integer)
declare sub wxHtmlEasyPrinting_SetFonts cdecl alias "wxHtmlEasyPrinting_SetFonts" (byval self as wxHtmlEasyPrinting ptr, byval normal_face as zstring ptr, byval fixed_face as zstring ptr, byval sizes as integer ptr)
declare sub wxHtmlEasyPrinting_SetStandardFonts cdecl alias "wxHtmlEasyPrinting_SetStandardFonts" (byval self as wxHtmlEasyPrinting ptr, byval size as integer, byval normal_face as zstring ptr, byval fixed_face as zstring ptr)
declare function wxHtmlEasyPrinting_GetPrintData cdecl alias "wxHtmlEasyPrinting_GetPrintData" (byval self as wxHtmlEasyPrinting ptr) as wxPrintData ptr
declare function wxHtmlEasyPrinting_GetPageSetupData cdecl alias "wxHtmlEasyPrinting_GetPageSetupData" (byval self as wxHtmlEasyPrinting ptr) as wxPageSetupDialogData ptr

#endif
