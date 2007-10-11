''
''
'' html -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_html_bi__
#define __wxc_html_bi__

#include once "wx.bi"


type Virtual_OnLinkClicked as sub WXCALL (byval as wxHtmlLinkInfo ptr)
type Virtual_OnSetTitle as sub WXCALL (byval as wxString ptr)
type Virtual_OnCellMouseHover as sub WXCALL (byval as wxHtmlCell ptr, byval as wxCoord, byval as wxCoord)
type Virtual_OnCellClicked as sub WXCALL (byval as wxHtmlCell ptr, byval as wxCoord, byval as wxCoord, byval as wxMouseEvent ptr)
type Virtual_OnOpeningURL as function WXCALL (byval as wxHtmlURLType, byval as wxString ptr, byval as wxString ptr) as wxHtmlOpeningStatus

declare function wxHtmlWindow alias "wxHtmlWindow_ctor" () as wxHtmlWindow ptr
declare function wxHtmlWindow_ctor2 (byval parent as wxWindow ptr, byval id as wxWindowID, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval name as zstring ptr) as wxHtmlWindow ptr
declare sub wxHtmlWindow_RegisterVirtual (byval self as _HtmlWindow ptr, byval onLinkClicked as Virtual_OnLinkClicked, byval onSetTitle as Virtual_OnSetTitle, byval onCellMouseHover as Virtual_OnCellMouseHover, byval onCellClicked as Virtual_OnCellClicked, byval onOpeningURL as Virtual_OnOpeningURL)
declare function wxHtmlWindow_Create (byval self as _HtmlWindow ptr, byval parent as wxWindow ptr, byval id as wxWindowID, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval name as zstring ptr) as integer
declare function wxHtmlWindow_SetPage (byval self as _HtmlWindow ptr, byval source as zstring ptr) as integer
declare function wxHtmlWindow_AppendToPage (byval self as _HtmlWindow ptr, byval source as zstring ptr) as integer
declare function wxHtmlWindow_LoadPage (byval self as _HtmlWindow ptr, byval location as zstring ptr) as integer
declare function wxHtmlWindow_LoadFile (byval self as _HtmlWindow ptr, byval filename as zstring ptr) as integer
declare function wxHtmlWindow_GetOpenedPage (byval self as _HtmlWindow ptr) as wxString ptr
declare function wxHtmlWindow_GetOpenedAnchor (byval self as _HtmlWindow ptr) as wxString ptr
declare function wxHtmlWindow_GetOpenedPageTitle (byval self as _HtmlWindow ptr) as wxString ptr
declare sub wxHtmlWindow_SetRelatedFrame (byval self as _HtmlWindow ptr, byval frame as wxFrame ptr, byval format as zstring ptr)
declare function wxHtmlWindow_GetRelatedFrame (byval self as _HtmlWindow ptr) as wxFrame ptr
declare sub wxHtmlWindow_SetRelatedStatusBar (byval self as _HtmlWindow ptr, byval bar as integer)
declare sub wxHtmlWindow_SetFonts (byval self as _HtmlWindow ptr, byval normal_face as zstring ptr, byval fixed_face as zstring ptr, byval sizes as integer ptr)
declare sub wxHtmlWindow_SetBorders (byval self as _HtmlWindow ptr, byval b as integer)
declare sub wxHtmlWindow_ReadCustomization (byval self as _HtmlWindow ptr, byval cfg as wxConfigBase ptr, byval path as zstring ptr)
declare sub wxHtmlWindow_WriteCustomization (byval self as _HtmlWindow ptr, byval cfg as wxConfigBase ptr, byval path as zstring ptr)
declare function wxHtmlWindow_HistoryBack (byval self as _HtmlWindow ptr) as integer
declare function wxHtmlWindow_HistoryForward (byval self as _HtmlWindow ptr) as integer
declare function wxHtmlWindow_HistoryCanBack (byval self as _HtmlWindow ptr) as integer
declare function wxHtmlWindow_HistoryCanForward (byval self as _HtmlWindow ptr) as integer
declare sub wxHtmlWindow_HistoryClear (byval self as _HtmlWindow ptr)
declare function wxHtmlWindow_GetInternalRepresentation (byval self as _HtmlWindow ptr) as wxHtmlContainerCell ptr
declare sub wxHtmlWindow_AddFilter (byval filter as wxHtmlFilter ptr)
declare function wxHtmlWindow_GetParser (byval self as _HtmlWindow ptr) as wxHtmlWinParser ptr
declare sub wxHtmlWindow_AddProcessor (byval self as _HtmlWindow ptr, byval processor as wxHtmlProcessor ptr)
declare sub wxHtmlWindow_AddGlobalProcessor (byval processor as wxHtmlProcessor ptr)
declare function wxHtmlWindow_AcceptsFocusFromKeyboard (byval self as _HtmlWindow ptr) as integer
declare sub wxHtmlWindow_OnSetTitle (byval self as _HtmlWindow ptr, byval title as zstring ptr)
declare sub wxHtmlWindow_OnCellClicked (byval self as _HtmlWindow ptr, byval cell as wxHtmlCell ptr, byval x as wxCoord, byval y as wxCoord, byval event as wxMouseEvent ptr)
declare sub wxHtmlWindow_OnLinkClicked (byval self as _HtmlWindow ptr, byval link as wxHtmlLinkInfo ptr)
declare function wxHtmlWindow_OnOpeningURL (byval self as _HtmlWindow ptr, byval type as wxHtmlURLType, byval url as zstring ptr, byval redirect as zstring ptr) as wxHtmlOpeningStatus
declare sub wxHtmlWindow_SelectAll (byval self as _HtmlWindow ptr)
declare sub wxHtmlWindow_SelectWord (byval self as _HtmlWindow ptr, byval pos as wxPoint ptr)
declare sub wxHtmlWindow_SelectLine (byval self as _HtmlWindow ptr, byval pos as wxPoint ptr)
declare function wxHtmlWindow_ToText (byval self as _HtmlWindow ptr) as wxString ptr
declare function wxHtmlWindow_SelectionToText (byval self as _HtmlWindow ptr) as wxString ptr
declare function wxHtmlFontCell alias "wxHtmlFontCell_ctor" (byval font as wxFont ptr) as wxHtmlFontCell ptr
declare sub wxHtmlFontCell_Draw (byval self as wxHtmlFontCell ptr, byval dc as wxDC ptr, byval x as integer, byval y as integer, byval view_y1 as integer, byval view_y2 as integer, byval info as wxHtmlRenderingInfo ptr)
declare sub wxHtmlFontCell_DrawInvisible (byval self as wxHtmlFontCell ptr, byval dc as wxDC ptr, byval x as integer, byval y as integer, byval info as wxHtmlRenderingInfo ptr)
declare function wxHtmlColourCell alias "wxHtmlColourCell_ctor" (byval clr as wxColour ptr, byval flags as integer) as wxHtmlColourCell ptr
declare sub wxHtmlColourCell_Draw (byval self as wxHtmlColourCell ptr, byval dc as wxDC ptr, byval x as integer, byval y as integer, byval view_y1 as integer, byval view_y2 as integer, byval info as wxHtmlRenderingInfo ptr)
declare sub wxHtmlColourCell_DrawInvisible (byval self as wxHtmlColourCell ptr, byval dc as wxDC ptr, byval x as integer, byval y as integer, byval info as wxHtmlRenderingInfo ptr)
declare function wxHtmlLinkInfo alias "wxHtmlLinkInfo_ctor" () as wxHtmlLinkInfo ptr
declare sub wxHtmlLinkInfo_SetEvent (byval self as wxHtmlLinkInfo ptr, byval e as wxMouseEvent ptr)
declare sub wxHtmlLinkInfo_SetHtmlCell (byval self as wxHtmlLinkInfo ptr, byval e as wxHtmlCell ptr)
declare function wxHtmlLinkInfo_GetHref (byval self as wxHtmlLinkInfo ptr) as wxString ptr
declare function wxHtmlLinkInfo_GetTarget (byval self as wxHtmlLinkInfo ptr) as wxString ptr
declare function wxHtmlLinkInfo_GetEvent (byval self as wxHtmlLinkInfo ptr) as wxMouseEvent ptr
declare function wxHtmlLinkInfo_GetHtmlCell (byval self as wxHtmlLinkInfo ptr) as wxHtmlCell ptr
declare function wxHtmlWidgetCell alias "wxHtmlWidgetCell_ctor" (byval wnd as wxWindow ptr, byval w as integer) as wxHtmlWidgetCell ptr
declare sub wxHtmlWidgetCell_Draw (byval self as wxHtmlWidgetCell ptr, byval dc as wxDC ptr, byval x as integer, byval y as integer, byval view_y1 as integer, byval view_y2 as integer, byval info as wxHtmlRenderingInfo ptr)
declare sub wxHtmlWidgetCell_DrawInvisible (byval self as wxHtmlWidgetCell ptr, byval dc as wxDC ptr, byval x as integer, byval y as integer, byval info as wxHtmlRenderingInfo ptr)
declare sub wxHtmlWidgetCell_Layout (byval self as wxHtmlWidgetCell ptr, byval w as integer)
declare function wxHtmlCell alias "wxHtmlCell_ctor" () as wxHtmlCell ptr
declare sub wxHtmlCell_SetParent (byval self as wxHtmlCell ptr, byval p as wxHtmlContainerCell ptr)
declare function wxHtmlCell_GetParent (byval self as wxHtmlCell ptr) as wxHtmlContainerCell ptr
declare function wxHtmlCell_GetPosX (byval self as wxHtmlCell ptr) as integer
declare function wxHtmlCell_GetPosY (byval self as wxHtmlCell ptr) as integer
declare function wxHtmlCell_GetWidth (byval self as wxHtmlCell ptr) as integer
declare function wxHtmlCell_GetHeight (byval self as wxHtmlCell ptr) as integer
declare function wxHtmlCell_GetDescent (byval self as wxHtmlCell ptr) as integer
declare function wxHtmlCell_GetId (byval self as wxHtmlCell ptr) as wxString ptr
declare sub wxHtmlCell_SetId (byval self as wxHtmlCell ptr, byval id as zstring ptr)
declare function wxHtmlCell_GetNext (byval self as wxHtmlCell ptr) as wxHtmlCell ptr
declare sub wxHtmlCell_SetPos (byval self as wxHtmlCell ptr, byval x as integer, byval y as integer)
declare sub wxHtmlCell_SetLink (byval self as wxHtmlCell ptr, byval link as wxHtmlLinkInfo ptr)
declare sub wxHtmlCell_SetNext (byval self as wxHtmlCell ptr, byval cell as wxHtmlCell ptr)
declare sub wxHtmlCell_Layout (byval self as wxHtmlCell ptr, byval w as integer)
declare sub wxHtmlCell_Draw (byval self as wxHtmlCell ptr, byval dc as wxDC ptr, byval x as integer, byval y as integer, byval view_y1 as integer, byval view_y2 as integer, byval info as wxHtmlRenderingInfo ptr)
declare sub wxHtmlCell_DrawInvisible (byval self as wxHtmlCell ptr, byval dc as wxDC ptr, byval x as integer, byval y as integer, byval info as wxHtmlRenderingInfo ptr)
declare function wxHtmlCell_Find (byval self as wxHtmlCell ptr, byval condition as integer, byval param as any ptr) as wxHtmlCell ptr
declare sub wxHtmlCell_OnMouseClick (byval self as wxHtmlCell ptr, byval parent as wxWindow ptr, byval x as integer, byval y as integer, byval event as wxMouseEvent ptr)
declare function wxHtmlCell_AdjustPagebreak (byval self as wxHtmlCell ptr, byval pagebreak as integer ptr) as integer
declare sub wxHtmlCell_SetCanLiveOnPagebreak (byval self as wxHtmlCell ptr, byval can as integer)
declare function wxHtmlCell_IsTerminalCell (byval self as wxHtmlCell ptr) as integer
declare function wxHtmlCell_FindCellByPos (byval self as wxHtmlCell ptr, byval x as wxCoord, byval y as wxCoord) as wxHtmlCell ptr
declare function wxHtmlWordCell alias "wxHtmlWordCell_ctor" (byval word as zstring ptr, byval dc as wxDC ptr) as wxHtmlWordCell ptr
declare sub wxHtmlWordCell_Draw (byval self as wxHtmlWordCell ptr, byval dc as wxDC ptr, byval x as integer, byval y as integer, byval view_y1 as integer, byval view_y2 as integer, byval info as wxHtmlRenderingInfo ptr)
declare function wxHtmlContainerCell alias "wxHtmlContainerCell_ctor" (byval parent as wxHtmlContainerCell ptr) as wxHtmlContainerCell ptr
declare sub wxHtmlContainerCell_Layout (byval self as wxHtmlContainerCell ptr, byval w as integer)
declare sub wxHtmlContainerCell_Draw (byval self as wxHtmlContainerCell ptr, byval dc as wxDC ptr, byval x as integer, byval y as integer, byval view_y1 as integer, byval view_y2 as integer, byval info as wxHtmlRenderingInfo ptr)
declare sub wxHtmlContainerCell_DrawInvisible (byval self as wxHtmlContainerCell ptr, byval dc as wxDC ptr, byval x as integer, byval y as integer, byval info as wxHtmlRenderingInfo ptr)
declare function wxHtmlContainerCell_AdjustPagebreak (byval self as wxHtmlContainerCell ptr, byval pagebreak as integer ptr) as integer
declare sub wxHtmlContainerCell_InsertCell (byval self as wxHtmlContainerCell ptr, byval cell as wxHtmlCell ptr)
declare sub wxHtmlContainerCell_SetAlignHor (byval self as wxHtmlContainerCell ptr, byval al as integer)
declare function wxHtmlContainerCell_GetAlignHor (byval self as wxHtmlContainerCell ptr) as integer
declare sub wxHtmlContainerCell_SetAlignVer (byval self as wxHtmlContainerCell ptr, byval al as integer)
declare function wxHtmlContainerCell_GetAlignVer (byval self as wxHtmlContainerCell ptr) as integer
declare sub wxHtmlContainerCell_SetIndent (byval self as wxHtmlContainerCell ptr, byval i as integer, byval what as integer, byval units as integer)
declare function wxHtmlContainerCell_GetIndent (byval self as wxHtmlContainerCell ptr, byval ind as integer) as integer
declare function wxHtmlContainerCell_GetIndentUnits (byval self as wxHtmlContainerCell ptr, byval ind as integer) as integer
declare sub wxHtmlContainerCell_SetAlign (byval self as wxHtmlContainerCell ptr, byval tag as wxHtmlTag ptr)
declare sub wxHtmlContainerCell_SetWidthFloat (byval self as wxHtmlContainerCell ptr, byval w as integer, byval units as integer)
declare sub wxHtmlContainerCell_SetWidthFloatTag (byval self as wxHtmlContainerCell ptr, byval tag as wxHtmlTag ptr, byval pixel_scale as double)
declare sub wxHtmlContainerCell_SetMinHeight (byval self as wxHtmlContainerCell ptr, byval h as integer, byval align as integer)
declare sub wxHtmlContainerCell_SetBackgroundColour (byval self as wxHtmlContainerCell ptr, byval clr as wxColour ptr)
declare function wxHtmlContainerCell_GetBackgroundColour (byval self as wxHtmlContainerCell ptr) as wxColour ptr
declare sub wxHtmlContainerCell_SetBorder (byval self as wxHtmlContainerCell ptr, byval clr1 as wxColour ptr, byval clr2 as wxColour ptr)
declare function wxHtmlContainerCell_GetLink (byval self as wxHtmlContainerCell ptr, byval x as integer, byval y as integer) as wxHtmlLinkInfo ptr
declare function wxHtmlContainerCell_Find (byval self as wxHtmlContainerCell ptr, byval condition as integer, byval param as any ptr) as wxHtmlCell ptr
declare sub wxHtmlContainerCell_OnMouseClick (byval self as wxHtmlContainerCell ptr, byval parent as wxWindow ptr, byval x as integer, byval y as integer, byval event as wxMouseEvent ptr)
declare function wxHtmlContainerCell_IsTerminalCell (byval self as wxHtmlContainerCell ptr) as integer
declare function wxHtmlContainerCell_FindCellByPos (byval self as wxHtmlContainerCell ptr, byval x as wxCoord, byval y as wxCoord) as wxHtmlCell ptr
declare function wxHtmlTag_GetParent (byval self as wxHtmlTag ptr) as wxHtmlTag ptr
declare function wxHtmlTag_GetFirstSibling (byval self as wxHtmlTag ptr) as wxHtmlTag ptr
declare function wxHtmlTag_GetLastSibling (byval self as wxHtmlTag ptr) as wxHtmlTag ptr
declare function wxHtmlTag_GetChildren (byval self as wxHtmlTag ptr) as wxHtmlTag ptr
declare function wxHtmlTag_GetPreviousSibling (byval self as wxHtmlTag ptr) as wxHtmlTag ptr
declare function wxHtmlTag_GetNextSibling (byval self as wxHtmlTag ptr) as wxHtmlTag ptr
declare function wxHtmlTag_GetNextTag (byval self as wxHtmlTag ptr) as wxHtmlTag ptr
declare function wxHtmlTag_GetName (byval self as wxHtmlTag ptr) as wxString ptr
declare function wxHtmlTag_HasParam (byval self as wxHtmlTag ptr, byval par as zstring ptr) as integer
declare function wxHtmlTag_GetParam (byval self as wxHtmlTag ptr, byval par as zstring ptr, byval with_commas as integer) as wxString ptr
declare function wxHtmlTag_GetParamAsColour (byval self as wxHtmlTag ptr, byval par as zstring ptr, byval clr as wxColour ptr) as integer
declare function wxHtmlTag_GetParamAsInt (byval self as wxHtmlTag ptr, byval par as zstring ptr, byval clr as integer ptr) as integer
declare function wxHtmlTag_ScanParam (byval self as wxHtmlTag ptr, byval par as zstring ptr, byval format as zstring ptr, byval param as any ptr) as integer
declare function wxHtmlTag_GetAllParams (byval self as wxHtmlTag ptr) as wxString ptr
declare function wxHtmlTag_HasEnding (byval self as wxHtmlTag ptr) as integer
declare function wxHtmlTag_GetBeginPos (byval self as wxHtmlTag ptr) as integer
declare function wxHtmlTag_GetEndPos1 (byval self as wxHtmlTag ptr) as integer
declare function wxHtmlTag_GetEndPos2 (byval self as wxHtmlTag ptr) as integer
declare function wxHtmlFilter_CanRead (byval self as wxHtmlFilter ptr, byval file as wxFSFile ptr) as integer
declare function wxHtmlFilter_ReadFile (byval self as wxHtmlFilter ptr, byval file as wxFSFile ptr) as wxString ptr
declare function wxHtmlFilterPlainText_CanRead (byval self as wxHtmlFilterPlainText ptr, byval file as wxFSFile ptr) as integer
declare function wxHtmlFilterPlainText_ReadFile (byval self as wxHtmlFilterPlainText ptr, byval file as wxFSFile ptr) as wxString ptr
declare function wxHtmlFilterHTML_CanRead (byval self as wxHtmlFilterHTML ptr, byval file as wxFSFile ptr) as integer
declare function wxHtmlFilterHTML_ReadFile (byval self as wxHtmlFilterHTML ptr, byval file as wxFSFile ptr) as wxString ptr
declare function wxHtmlTagsModule alias "wxHtmlTagsModule_ctor" () as wxHtmlTagsModule ptr
declare function wxHtmlTagsModule_OnInit (byval self as wxHtmlTagsModule ptr) as integer
declare sub wxHtmlTagsModule_OnExit (byval self as wxHtmlTagsModule ptr)
declare sub wxHtmlTagsModule_FillHandlersTable (byval self as wxHtmlTagsModule ptr, byval parser as wxHtmlWinParser ptr)
declare function wxHtmlWinParser alias "wxHtmlWinParser_ctor" (byval wnd as wxHtmlWindow ptr) as wxHtmlWinParser ptr
declare sub wxHtmlWinParser_InitParser (byval self as wxHtmlWinParser ptr, byval source as zstring ptr)
declare sub wxHtmlWinParser_DoneParser (byval self as wxHtmlWinParser ptr)
declare function wxHtmlWinParser_GetProduct (byval self as wxHtmlWinParser ptr) as wxObject ptr
declare function wxHtmlWinParser_OpenURL (byval self as wxHtmlWinParser ptr, byval type as wxHtmlURLType, byval url as zstring ptr) as wxFSFile ptr
declare sub wxHtmlWinParser_SetDC (byval self as wxHtmlWinParser ptr, byval dc as wxDC ptr, byval pixel_scale as double)
declare function wxHtmlWinParser_GetDC (byval self as wxHtmlWinParser ptr) as wxDC ptr
declare function wxHtmlWinParser_GetPixelScale (byval self as wxHtmlWinParser ptr) as double
declare function wxHtmlWinParser_GetCharHeight (byval self as wxHtmlWinParser ptr) as integer
declare function wxHtmlWinParser_GetCharWidth (byval self as wxHtmlWinParser ptr) as integer
declare function wxHtmlWinParser_GetWindow (byval self as wxHtmlWinParser ptr) as wxHtmlWindow ptr
declare sub wxHtmlWinParser_SetFonts (byval self as wxHtmlWinParser ptr, byval normal_face as zstring ptr, byval fixed_face as zstring ptr, byval sizes as integer ptr)
declare sub wxHtmlWinParser_AddModule (byval self as wxHtmlWinParser ptr, byval module as wxHtmlTagsModule ptr)
declare sub wxHtmlWinParser_RemoveModule (byval self as wxHtmlWinParser ptr, byval module as wxHtmlTagsModule ptr)
declare function wxHtmlWinParser_GetContainer (byval self as wxHtmlWinParser ptr) as wxHtmlContainerCell ptr
declare function wxHtmlWinParser_OpenContainer (byval self as wxHtmlWinParser ptr) as wxHtmlContainerCell ptr
declare function wxHtmlWinParser_SetContainer (byval self as wxHtmlWinParser ptr, byval c as wxHtmlContainerCell ptr) as wxHtmlContainerCell ptr
declare function wxHtmlWinParser_CloseContainer (byval self as wxHtmlWinParser ptr) as wxHtmlContainerCell ptr
declare function wxHtmlWinParser_GetFontSize (byval self as wxHtmlWinParser ptr) as integer
declare sub wxHtmlWinParser_SetFontSize (byval self as wxHtmlWinParser ptr, byval s as integer)
declare function wxHtmlWinParser_GetFontBold (byval self as wxHtmlWinParser ptr) as integer
declare sub wxHtmlWinParser_SetFontBold (byval self as wxHtmlWinParser ptr, byval x as integer)
declare function wxHtmlWinParser_GetFontItalic (byval self as wxHtmlWinParser ptr) as integer
declare sub wxHtmlWinParser_SetFontItalic (byval self as wxHtmlWinParser ptr, byval x as integer)
declare function wxHtmlWinParser_GetFontUnderlined (byval self as wxHtmlWinParser ptr) as integer
declare sub wxHtmlWinParser_SetFontUnderlined (byval self as wxHtmlWinParser ptr, byval x as integer)
declare function wxHtmlWinParser_GetFontFixed (byval self as wxHtmlWinParser ptr) as integer
declare sub wxHtmlWinParser_SetFontFixed (byval self as wxHtmlWinParser ptr, byval x as integer)
declare function wxHtmlWinParser_GetFontFace (byval self as wxHtmlWinParser ptr) as wxString ptr
declare sub wxHtmlWinParser_SetFontFace (byval self as wxHtmlWinParser ptr, byval face as zstring ptr)
declare function wxHtmlWinParser_GetAlign (byval self as wxHtmlWinParser ptr) as integer
declare sub wxHtmlWinParser_SetAlign (byval self as wxHtmlWinParser ptr, byval a as integer)
declare function wxHtmlWinParser_GetLinkColor (byval self as wxHtmlWinParser ptr) as wxColour ptr
declare sub wxHtmlWinParser_SetLinkColor (byval self as wxHtmlWinParser ptr, byval clr as wxColour ptr)
declare function wxHtmlWinParser_GetActualColor (byval self as wxHtmlWinParser ptr) as wxColour ptr
declare sub wxHtmlWinParser_SetActualColor (byval self as wxHtmlWinParser ptr, byval clr as wxColour ptr)
declare function wxHtmlWinParser_GetLink (byval self as wxHtmlWinParser ptr) as wxHtmlLinkInfo ptr
declare sub wxHtmlWinParser_SetLink (byval self as wxHtmlWinParser ptr, byval link as wxHtmlLinkInfo ptr)
declare function wxHtmlWinParser_CreateCurrentFont (byval self as wxHtmlWinParser ptr) as wxFont ptr
declare sub wxHtmlTagHandler_SetParser (byval self as wxHtmlTagHandler ptr, byval parser as wxHtmlParser ptr)
declare function wxHtmlTagHandler_HandleTag (byval self as wxHtmlTagHandler ptr, byval tag as wxHtmlTag ptr) as integer
declare function wxHtmlEntitiesParser alias "wxHtmlEntitiesParser_ctor" () as wxHtmlEntitiesParser ptr
declare sub wxHtmlEntitiesParser_dtor (byval self as wxHtmlEntitiesParser ptr)
declare sub wxHtmlEntitiesParser_SetEncoding (byval self as wxHtmlEntitiesParser ptr, byval encoding as wxFontEncoding)
declare function wxHtmlEntitiesParser_Parse (byval self as wxHtmlEntitiesParser ptr, byval input as zstring ptr) as wxString ptr
declare function wxHtmlEntitiesParser_GetEntityChar (byval self as wxHtmlEntitiesParser ptr, byval entity as zstring ptr) as byte
declare function wxHtmlEntitiesParser_GetCharForCode (byval self as wxHtmlEntitiesParser ptr, byval code as uinteger) as byte
declare sub wxHtmlParser_SetFS (byval self as wxHtmlParser ptr, byval fs as wxFileSystem ptr)
declare function wxHtmlParser_GetFS (byval self as wxHtmlParser ptr) as wxFileSystem ptr
declare function wxHtmlParser_OpenURL (byval self as wxHtmlParser ptr, byval type as wxHtmlURLType, byval url as zstring ptr) as wxFSFile ptr
declare function wxHtmlParser_Parse (byval self as wxHtmlParser ptr, byval source as zstring ptr) as wxObject ptr
declare sub wxHtmlParser_InitParser (byval self as wxHtmlParser ptr, byval source as zstring ptr)
declare sub wxHtmlParser_DoneParser (byval self as wxHtmlParser ptr)
declare sub wxHtmlParser_StopParsing (byval self as wxHtmlParser ptr)
declare sub wxHtmlParser_DoParsing (byval self as wxHtmlParser ptr, byval begin_pos as integer, byval end_pos as integer)
declare sub wxHtmlParser_DoParsingAll (byval self as wxHtmlParser ptr)
declare function wxHtmlParser_GetCurrentTag (byval self as wxHtmlParser ptr) as wxHtmlTag ptr
declare function wxHtmlParser_GetProduct (byval self as wxHtmlParser ptr) as wxObject ptr
declare sub wxHtmlParser_AddTagHandler (byval self as wxHtmlParser ptr, byval handler as wxHtmlTagHandler ptr)
declare sub wxHtmlParser_PushTagHandler (byval self as wxHtmlParser ptr, byval handler as wxHtmlTagHandler ptr, byval tags as zstring ptr)
declare sub wxHtmlParser_PopTagHandler (byval self as wxHtmlParser ptr)
declare function wxHtmlParser_GetSource (byval self as wxHtmlParser ptr) as wxString ptr
declare sub wxHtmlParser_SetSource (byval self as wxHtmlParser ptr, byval src as zstring ptr)
declare sub wxHtmlParser_SetSourceAndSaveState (byval self as wxHtmlParser ptr, byval src as zstring ptr)
declare function wxHtmlParser_RestoreState (byval self as wxHtmlParser ptr) as integer
declare function wxHtmlParser_ExtractCharsetInformation (byval self as wxHtmlParser ptr, byval markup as zstring ptr) as wxString ptr
declare function wxHtmlProcessor_GetPriority (byval self as wxHtmlProcessor ptr) as integer
declare sub wxHtmlProcessor_Enable (byval self as wxHtmlProcessor ptr, byval enable as integer)
declare function wxHtmlProcessor_IsEnabled (byval self as wxHtmlProcessor ptr) as integer
declare function wxHtmlRenderingInfo alias "wxHtmlRenderingInfo_ctor" () as wxHtmlRenderingInfo ptr
declare sub wxHtmlRenderingInfo_dtor (byval self as wxHtmlRenderingInfo ptr)
declare sub wxHtmlRenderingInfo_SetSelection (byval self as wxHtmlRenderingInfo ptr, byval s as wxHtmlSelection ptr)
declare function wxHtmlRenderingInfo_GetSelection (byval self as wxHtmlRenderingInfo ptr) as wxHtmlSelection ptr
declare function wxHtmlSelection alias "wxHtmlSelection_ctor" () as wxHtmlSelection ptr
declare sub wxHtmlSelection_dtor (byval self as wxHtmlSelection ptr)
declare sub wxHtmlSelection_Set (byval self as wxHtmlSelection ptr, byval fromPos as wxPoint ptr, byval fromCell as wxHtmlCell ptr, byval toPos as wxPoint ptr, byval toCell as wxHtmlCell ptr)
declare sub wxHtmlSelection_Set2 (byval self as wxHtmlSelection ptr, byval fromCell as wxHtmlCell ptr, byval toCell as wxHtmlCell ptr)
declare function wxHtmlSelection_GetFromCell (byval self as wxHtmlSelection ptr) as wxHtmlCell ptr
declare function wxHtmlSelection_GetToCell (byval self as wxHtmlSelection ptr) as wxHtmlCell ptr
declare sub wxHtmlSelection_GetFromPos (byval self as wxHtmlSelection ptr, byval fromPos as wxPoint ptr)
declare sub wxHtmlSelection_GetToPos (byval self as wxHtmlSelection ptr, byval toPos as wxPoint ptr)
declare sub wxHtmlSelection_GetFromPrivPos (byval self as wxHtmlSelection ptr, byval fromPrivPos as wxPoint ptr)
declare sub wxHtmlSelection_GetToPrivPos (byval self as wxHtmlSelection ptr, byval toPrivPos as wxPoint ptr)
declare sub wxHtmlSelection_SetFromPrivPos (byval self as wxHtmlSelection ptr, byval pos as wxPoint ptr)
declare sub wxHtmlSelection_SetToPrivPos (byval self as wxHtmlSelection ptr, byval pos as wxPoint ptr)
declare sub wxHtmlSelection_ClearPrivPos (byval self as wxHtmlSelection ptr)
declare function wxHtmlSelection_IsEmpty (byval self as wxHtmlSelection ptr) as integer
declare function wxHtmlEasyPrinting alias "wxHtmlEasyPrinting_ctor" (byval name as zstring ptr, byval parent as wxWindow ptr) as wxHtmlEasyPrinting ptr
declare function wxHtmlEasyPrinting_PreviewFile (byval self as wxHtmlEasyPrinting ptr, byval htmlfile as zstring ptr) as integer
declare function wxHtmlEasyPrinting_PreviewText (byval self as wxHtmlEasyPrinting ptr, byval htmltext as zstring ptr, byval basepath as zstring ptr) as integer
declare function wxHtmlEasyPrinting_PrintFile (byval self as wxHtmlEasyPrinting ptr, byval htmlfile as zstring ptr) as integer
declare function wxHtmlEasyPrinting_PrintText (byval self as wxHtmlEasyPrinting ptr, byval htmltext as zstring ptr, byval basepath as zstring ptr) as integer
declare sub wxHtmlEasyPrinting_PrinterSetup (byval self as wxHtmlEasyPrinting ptr)
declare sub wxHtmlEasyPrinting_PageSetup (byval self as wxHtmlEasyPrinting ptr)
declare sub wxHtmlEasyPrinting_SetHeader (byval self as wxHtmlEasyPrinting ptr, byval header as zstring ptr, byval pg as integer)
declare sub wxHtmlEasyPrinting_SetFooter (byval self as wxHtmlEasyPrinting ptr, byval footer as zstring ptr, byval pg as integer)
declare sub wxHtmlEasyPrinting_SetFonts (byval self as wxHtmlEasyPrinting ptr, byval normal_face as zstring ptr, byval fixed_face as zstring ptr, byval sizes as integer ptr)
declare sub wxHtmlEasyPrinting_SetStandardFonts (byval self as wxHtmlEasyPrinting ptr, byval size as integer, byval normal_face as zstring ptr, byval fixed_face as zstring ptr)
declare function wxHtmlEasyPrinting_GetPrintData (byval self as wxHtmlEasyPrinting ptr) as wxPrintData ptr
declare function wxHtmlEasyPrinting_GetPageSetupData (byval self as wxHtmlEasyPrinting ptr) as wxPageSetupDialogData ptr

#endif
