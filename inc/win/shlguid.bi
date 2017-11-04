'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   This Software is provided under the Zope Public License (ZPL) Version 2.1.
''
''   Copyright (c) 2009, 2010 by the mingw-w64 project
''
''   See the AUTHORS file for the list of contributors to the mingw-w64 project.
''
''   This license has been certified as open source. It has also been designated
''   as GPL compatible by the Free Software Foundation (FSF).
''
''   Redistribution and use in source and binary forms, with or without
''   modification, are permitted provided that the following conditions are met:
''
''     1. Redistributions in source code must retain the accompanying copyright
''        notice, this list of conditions, and the following disclaimer.
''     2. Redistributions in binary form must reproduce the accompanying
''        copyright notice, this list of conditions, and the following disclaimer
''        in the documentation and/or other materials provided with the
''        distribution.
''     3. Names of the copyright holders must not be used to endorse or promote
''        products derived from this software without prior written permission
''        from the copyright holders.
''     4. The right to distribute this software or to use it for any purpose does
''        not give you the right to use Servicemarks (sm) or Trademarks (tm) of
''        the copyright holders.  Use of them is covered by separate agreement
''        with the copyright holders.
''     5. If any files are modified, you must cause the modified files to carry
''        prominent notices stating that you changed the files and the date of
''        any change.
''
''   Disclaimer
''
''   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS ``AS IS'' AND ANY EXPRESSED
''   OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
''   OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
''   EVENT SHALL THE COPYRIGHT HOLDERS BE LIABLE FOR ANY DIRECT, INDIRECT,
''   INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
''   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, 
''   OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
''   LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
''   NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
''   EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "uuid"
#inclib "shell32"

#include once "winapifamily.bi"
#include once "_mingw_unicode.bi"
#include once "isguids.bi"
#include once "exdisp.bi"
#include once "shldisp.bi"
#include once "knownfolders.bi"

extern "C"

#define STR_MYDOCS_CLSID "{450D8FBA-AD25-11D0-98A8-0800361B1103}"
#define PSGUID_INTERNETSHORTCUT (&h000214a0, 0, 0, &hc0, 0, 0, 0, 0, 0, 0, &h46)
#define PSGUID_INTERNETSITE (&h000214a1, 0, 0, &hc0, 0, 0, 0, 0, 0, 0, &h46)
type IDefViewID as IUnknown

extern CLSID_NetworkDomain as const GUID
extern CLSID_NetworkServer as const GUID
extern CLSID_NetworkShare as const GUID
extern CLSID_MyComputer as const GUID
extern CLSID_Internet as const GUID
extern CLSID_RecycleBin as const GUID
extern CLSID_ControlPanel as const GUID
extern CLSID_Printers as const GUID
extern CLSID_MyDocuments as const GUID
extern CATID_BrowsableShellExt as const GUID
extern CATID_BrowseInPlace as const GUID
extern CATID_DeskBand as const GUID
extern CATID_InfoBand as const GUID
extern CATID_CommBand as const GUID
extern FMTID_Intshcut as const GUID
extern FMTID_InternetSite as const GUID
extern CGID_Explorer as const GUID
extern CGID_ShellDocView as const GUID
extern CGID_ShellServiceObject as const GUID
extern CGID_ExplorerBarDoc as const GUID
extern IID_INewShortcutHookA as const GUID
extern IID_IExtractIconA as const GUID
extern IID_IShellDetails as const GUID
extern IID_ICopyHookA as const GUID
extern IID_IShellCopyHookA alias "IID_ICopyHookA" as const GUID
extern IID_IFileViewerA as const GUID
extern IID_IFileViewerSite as const GUID
extern IID_IShellExecuteHookA as const GUID
extern IID_IPropSheetPage as const GUID
extern IID_INewShortcutHookW as const GUID
extern IID_IFileViewerW as const GUID
extern IID_IExtractIconW as const GUID
extern IID_IShellExecuteHookW as const GUID
extern IID_ICopyHookW as const GUID
extern IID_IShellCopyHookW alias "IID_ICopyHookW" as const GUID
extern IID_IQueryInfo as const GUID
extern IID_IBriefcaseStg as const GUID
extern IID_IURLSearchHook as const GUID
extern IID_ISearchContext as const GUID
extern IID_IURLSearchHook2 as const GUID
extern IID_IDefViewID as const GUID
extern CLSID_FolderShortcut as const GUID
extern IID_IDockingWindowSite as const GUID
extern IID_IDockingWindowFrame as const GUID
extern IID_IShellIconOverlay as const GUID
extern IID_IShellIconOverlayIdentifier as const GUID
extern IID_IShellFolderViewCB as const GUID
extern SID_ShellFolderViewCB alias "IID_IShellFolderViewCB" as const GUID
extern CLSID_CFSIconOverlayManager as const GUID
extern IID_IShellIconOverlayManager as const GUID
extern IID_IThumbnailCapture as const GUID
extern IID_IShellImageStore as const GUID

#if _WIN32_WINNT <= &h0502
	extern CLSID_ShellThumbnailDiskCache as const GUID
#endif

extern SID_DefView as const GUID
extern CGID_DefView as const GUID
extern CLSID_MenuBand as const GUID
extern IID_IShellFolderBand as const GUID
extern IID_IDefViewFrame as const GUID
extern VID_LargeIcons as const GUID
extern VID_SmallIcons as const GUID
extern VID_List as const GUID
extern VID_Details as const GUID
extern VID_Tile as const GUID
extern VID_Content as const GUID
extern VID_Thumbnails as const GUID
extern VID_ThumbStrip as const GUID
extern SID_SInPlaceBrowser as const GUID

#if _WIN32_WINNT >= &h0601
	extern SID_SSearchBoxInfo as const GUID
	extern SID_CommandsPropertyBag as const GUID
#endif

extern IID_IDiscardableBrowserProperty as const GUID
extern IID_IShellChangeNotify as const GUID

#ifdef UNICODE
	extern IID_IFileViewer alias "IID_IFileViewerW" as const GUID
	extern IID_IExtractIcon alias "IID_IExtractIconW" as const GUID
	extern IID_IShellCopyHook alias "IID_ICopyHookW" as const GUID
	extern IID_IShellExecuteHook alias "IID_IShellExecuteHookW" as const GUID
	extern IID_INewShortcutHook alias "IID_INewShortcutHookW" as const GUID
#else
	extern IID_IFileViewer alias "IID_IFileViewerA" as const GUID
	extern IID_IExtractIcon alias "IID_IExtractIconA" as const GUID
	extern IID_IShellCopyHook alias "IID_ICopyHookA" as const GUID
	extern IID_IShellExecuteHook alias "IID_IShellExecuteHookA" as const GUID
	extern IID_INewShortcutHook alias "IID_INewShortcutHookA" as const GUID
#endif

extern SID_SInternetExplorer alias "IID_IWebBrowserApp" as const IID
extern SID_SWebBrowserApp alias "IID_IWebBrowserApp" as const IID
#define SID_SWebBrowserEventsService IID_IWebBrowserEventsService
extern CLSID_CUrlHistory as const GUID
extern SID_SUrlHistory alias "CLSID_CUrlHistory" as const GUID
extern CLSID_CURLSearchHook as const GUID
extern IID_IObjMgr as const GUID
extern IID_IACList as const GUID
extern IID_IACList2 as const GUID
extern IID_ICurrentWorkingDirectory as const GUID
extern CLSID_AutoComplete as const GUID
extern CLSID_ACLHistory as const GUID
extern CLSID_ACListISF as const GUID
extern CLSID_ACLMRU as const GUID
extern CLSID_ACLMulti as const GUID

#if _WIN32_WINNT >= &h0501
	extern CLSID_ACLCustomMRU as const GUID
#endif

extern CLSID_ProgressDialog as const GUID
extern SID_SProgressUI alias "CLSID_ProgressDialog" as const GUID
extern IID_IProgressDialog as const GUID
extern SID_STopLevelBrowser as const GUID

#define PSGUID_SHELLDETAILS (&h28636aa6, &h953d, &h11d2, &hb5, &hd6, &h0, &hc0, &h4f, &hd9, &h18, &hd0)
const PID_FINDDATA = 0
const PID_NETRESOURCE = 1
const PID_DESCRIPTIONID = 2
const PID_WHICHFOLDER = 3
const PID_NETWORKLOCATION = 4
const PID_COMPUTERNAME = 5
const PID_DISPLAY_PROPERTIES = 0
const PID_INTROTEXT = 1
const PID_SYNC_COPY_IN = 2
const PIDSI_ARTIST = 2
const PIDSI_SONGTITLE = 3
const PIDSI_ALBUM = 4
const PIDSI_YEAR = 5
const PIDSI_COMMENT = 6
const PIDSI_TRACK = 7
const PIDSI_GENRE = 11
const PIDSI_LYRICS = 12
const PID_MISC_STATUS = 2
const PID_MISC_ACCESSCOUNT = 3
const PID_MISC_OWNER = 4
const PID_HTMLINFOTIPFILE = 5
const PID_MISC_PICS = 6
const PIDDRSI_PROTECTED = 2
const PIDDRSI_DESCRIPTION = 3
const PIDDRSI_PLAYCOUNT = 4
const PIDDRSI_PLAYSTARTS = 5
const PIDDRSI_PLAYEXPIRES = 6
const PID_DISPLACED_FROM = 2
const PID_DISPLACED_DATE = 3
#define PSGUID_BRIEFCASE (&h328d8b21, &h7729, &h4bfc, &h95, &h4c, &h90, &h2b, &h32, &h9d, &h56, &hb0)
#define PSGUID_MISC (&h9b174b34, &h40ff, &h11d2, &ha2, &h7e, &h0, &hc0, &h4f, &hc3, &h8, &h71)
#define PSGUID_WEBVIEW (&hf2275480, &hf782, &h4291, &hbd, &h94, &hf1, &h36, &h93, &h51, &h3a, &hec)
#define PSGUID_MUSIC (&h56a3372e, &hce9c, &h11d2, &h9f, &he, &h0, &h60, &h97, &hc6, &h86, &hf6)
#define PSGUID_DRM (&haeac19e4, &h89ae, &h4508, &hb9, &hb7, &hbb, &h86, &h7a, &hbe, &he2, &hed)
#define PSGUID_VIDEO (&h64440491, &h4c8b, &h11d1, &h8b, &h70, &h8, &h0, &h36, &hb1, &h1a, &h3)
#define PSGUID_IMAGEPROPERTIES (&h14b81da1, &h0135, &h4d31, &h96, &hd9, &h6c, &hbf, &hc9, &h67, &h1a, &h99)
#define PSGUID_CUSTOMIMAGEPROPERTIES (&h7ecd8b0e, &hc136, &h4a9b, &h94, &h11, &h4e, &hbd, &h66, &h73, &hcc, &hc3)
#define PSGUID_LIBRARYPROPERTIES (&h5d76b67f, &h9b3d, &h44bb, &hb6, &hae, &h25, &hda, &h4f, &h63, &h8a, &h67)
#define PSGUID_DISPLACED (&h9b174b33, &h40ff, &h11d2, &ha2, &h7e, &h0, &hc0, &h4f, &hc3, &h8, &h71)

extern CLSID_FileTypes as const GUID
extern CLSID_ActiveDesktop as const GUID
extern IID_IActiveDesktop as const GUID
extern IID_IActiveDesktopP as const GUID
extern IID_IADesktopP2 as const GUID
extern IID_ISynchronizedCallBack as const GUID
extern IID_IQueryAssociations as const GUID
extern CLSID_QueryAssociations as const GUID
extern IID_IColumnProvider as const GUID
extern CLSID_LinkColumnProvider as const GUID
extern CGID_ShortCut as const GUID
extern IID_INamedPropertyBag as const GUID
extern CLSID_InternetButtons as const GUID
extern CLSID_MSOButtons as const GUID
extern CLSID_ToolbarExtButtons as const GUID
extern CLSID_DarwinAppPublisher as const GUID
extern CLSID_DocHostUIHandler as const GUID
extern FMTID_ShellDetails as const GUID
extern FMTID_Storage as const GUID
extern FMTID_ImageProperties as const GUID
extern FMTID_CustomImageProperties as const GUID
extern FMTID_LibraryProperties as const GUID
extern FMTID_Displaced as const GUID
extern FMTID_Briefcase as const GUID
extern FMTID_Misc as const GUID
extern FMTID_WebView as const GUID
extern FMTID_MUSIC as const GUID
extern FMTID_DRM as const GUID

const PIDVSI_STREAM_NAME = &h00000002
const PIDVSI_FRAME_WIDTH = &h00000003
const PIDVSI_FRAME_HEIGHT = &h00000004
const PIDVSI_TIMELENGTH = &h00000007
const PIDVSI_FRAME_COUNT = &h00000005
const PIDVSI_FRAME_RATE = &h00000006
const PIDVSI_DATA_RATE = &h00000008
const PIDVSI_SAMPLE_SIZE = &h00000009
const PIDVSI_COMPRESSION = &h0000000a
const PIDVSI_STREAM_NUMBER = &h0000000b
#define PSGUID_AUDIO (&h64440490, &h4c8b, &h11d1, &h8b, &h70, &h8, &h0, &h36, &hb1, &h1a, &h3)
const PIDASI_FORMAT = &h00000002
const PIDASI_TIMELENGTH = &h00000003
const PIDASI_AVG_DATA_RATE = &h00000004
const PIDASI_SAMPLE_RATE = &h00000005
const PIDASI_SAMPLE_SIZE = &h00000006
const PIDASI_CHANNEL_COUNT = &h00000007
const PIDASI_STREAM_NUMBER = &h00000008
const PIDASI_STREAM_NAME = &h00000009
const PIDASI_COMPRESSION = &h0000000a
#define PSGUID_CONTROLPANEL (&h305ca226, &hd286, &h468e, &hb8, &h48, &h2b, &h2e, &h8e, &h69, &h7b, &h74)
const PID_CONTROLPANEL_CATEGORY = 2
#define PSGUID_VOLUME (&h9b174b35, &h40ff, &h11d2, &ha2, &h7e, &h0, &hc0, &h4f, &hc3, &h8, &h71)
#define PSGUID_SHARE (&hd8c3986f, &h813b, &h449c, &h84, &h5d, &h87, &hb9, &h5d, &h67, &h4a, &hde)
#define PSGUID_LINK (&hb9b4b3fc, &h2b51, &h4a42, &hb5, &hd8, &h32, &h41, &h46, &haf, &hcf, &h25)
#define PSGUID_QUERY_D (&h49691c90, &h7e17, &h101a, &ha9, &h1c, &h08, &h00, &h2b, &h2e, &hcd, &ha9)
#define PSGUID_SUMMARYINFORMATION (&hf29f85e0, &h4ff9, &h1068, &hab, &h91, &h08, &h00, &h2b, &h27, &hb3, &hd9)
#define PSGUID_DOCUMENTSUMMARYINFORMATION (&hd5cdd502, &h2e9c, &h101b, &h93, &h97, &h08, &h00, &h2b, &h2c, &hf9, &hae)
#define PSGUID_MEDIAFILESUMMARYINFORMATION (&h64440492, &h4c8b, &h11d1, &h8b, &h70, &h08, &h00, &h36, &hb1, &h1a, &h03)
#define PSGUID_IMAGESUMMARYINFORMATION (&h6444048f, &h4c8b, &h11d1, &h8b, &h70, &h8, &h00, &h36, &hb1, &h1a, &h03)
const PID_VOLUME_FREE = 2
const PID_VOLUME_CAPACITY = 3
const PID_VOLUME_FILESYSTEM = 4
const PID_SHARE_CSC_STATUS = 2
const PID_LINK_TARGET = 2
const PID_LINK_TARGET_TYPE = 3
const PID_QUERY_RANK = 2

extern FMTID_Volume as const GUID
extern FMTID_Query as const GUID
extern CLSID_HWShellExecute as const GUID
extern CLSID_DragDropHelper as const GUID
extern CLSID_CAnchorBrowsePropertyPage as const GUID
extern CLSID_CImageBrowsePropertyPage as const GUID
extern CLSID_CDocBrowsePropertyPage as const GUID
extern SID_STopWindow as const GUID
extern SID_SGetViewFromViewDual as const GUID
extern CLSID_FolderItem as const GUID
extern CLSID_FolderItemsMultiLevel as const GUID
extern CLSID_NewMenu as const GUID
extern BHID_SFObject as const GUID
extern BHID_SFUIObject as const GUID
extern BHID_SFViewObject as const GUID
extern BHID_Storage as const GUID
extern BHID_Stream as const GUID
extern BHID_RandomAccessStream as const GUID
extern BHID_LinkTargetItem as const GUID
extern BHID_StorageEnum as const GUID
extern BHID_Transfer as const GUID
extern BHID_PropertyStore as const GUID
extern BHID_ThumbnailHandler as const GUID
extern BHID_EnumItems as const GUID
extern BHID_DataObject as const GUID
extern BHID_AssociationArray as const GUID
extern BHID_Filter as const GUID
extern BHID_EnumAssocHandlers as const GUID

#if _WIN32_WINNT >= &h0501
	extern SID_CtxQueryAssociations as const GUID
#endif

extern IID_IDocViewSite as const GUID
extern CLSID_QuickLinks as const GUID
extern CLSID_ISFBand as const GUID
extern IID_CDefView as const GUID
extern CLSID_ShellFldSetExt as const GUID
extern SID_SMenuBandChild as const GUID
extern SID_SMenuBandParent as const GUID
extern SID_SMenuPopup as const GUID
extern SID_SMenuBandBottomSelected as const GUID
extern SID_SMenuBandBottom as const GUID
extern SID_MenuShellFolder as const GUID
extern SID_SMenuBandContextMenuModifier as const GUID
extern SID_SMenuBandBKContextMenu as const GUID
extern CGID_MENUDESKBAR as const GUID
extern SID_SMenuBandTop as const GUID
extern CLSID_MenuToolbarBase as const GUID
extern IID_IBanneredBar as const GUID
extern CLSID_MenuBandSite as const GUID
extern SID_SCommDlgBrowser as const GUID
extern CPFG_LOGON_USERNAME as const GUID
extern CPFG_LOGON_PASSWORD as const GUID
extern CPFG_SMARTCARD_USERNAME as const GUID
extern CPFG_SMARTCARD_PIN as const GUID
extern CPFG_CREDENTIAL_PROVIDER_LOGO as const GUID
extern CPFG_CREDENTIAL_PROVIDER_LABEL as const GUID
extern FOLDERTYPEID_Invalid as const GUID
extern FOLDERTYPEID_Generic as const GUID
extern FOLDERTYPEID_GenericSearchResults as const GUID
extern FOLDERTYPEID_GenericLibrary as const GUID
extern FOLDERTYPEID_Documents as const GUID
extern FOLDERTYPEID_Pictures as const GUID
extern FOLDERTYPEID_Music as const GUID
extern FOLDERTYPEID_Videos as const GUID
extern FOLDERTYPEID_UserFiles as const GUID
extern FOLDERTYPEID_UsersLibraries as const GUID
extern FOLDERTYPEID_OtherUsers as const GUID
extern FOLDERTYPEID_PublishedItems as const GUID
extern FOLDERTYPEID_Communications as const GUID
extern FOLDERTYPEID_Contacts as const GUID
extern FOLDERTYPEID_StartMenu as const GUID
extern FOLDERTYPEID_RecordedTV as const GUID
extern FOLDERTYPEID_SavedGames as const GUID
extern FOLDERTYPEID_OpenSearch as const GUID
extern FOLDERTYPEID_SearchConnector as const GUID
extern FOLDERTYPEID_AccountPictures as const GUID
extern FOLDERTYPEID_Games as const GUID
extern FOLDERTYPEID_ControlPanelCategory as const GUID
extern FOLDERTYPEID_ControlPanelClassic as const GUID
extern FOLDERTYPEID_Printers as const GUID
extern FOLDERTYPEID_RecycleBin as const GUID
extern FOLDERTYPEID_SoftwareExplorer as const GUID
extern FOLDERTYPEID_CompressedFolder as const GUID
extern FOLDERTYPEID_NetworkExplorer as const GUID
extern FOLDERTYPEID_Searches as const GUID
extern FOLDERTYPEID_SearchHome as const GUID
extern SYNCMGR_OBJECTID_Icon as const GUID
extern SYNCMGR_OBJECTID_EventStore as const GUID
extern SYNCMGR_OBJECTID_ConflictStore as const GUID
extern SYNCMGR_OBJECTID_BrowseContent as const GUID
extern SYNCMGR_OBJECTID_ShowSchedule as const GUID
extern SYNCMGR_OBJECTID_QueryBeforeActivate as const GUID
extern SYNCMGR_OBJECTID_QueryBeforeDeactivate as const GUID
extern SYNCMGR_OBJECTID_QueryBeforeEnable as const GUID
extern SYNCMGR_OBJECTID_QueryBeforeDisable as const GUID
extern SYNCMGR_OBJECTID_QueryBeforeDelete as const GUID
extern SYNCMGR_OBJECTID_EventLinkClick as const GUID
extern EP_NavPane as const GUID
extern EP_Commands as const GUID
extern EP_Commands_Organize as const GUID
extern EP_Commands_View as const GUID
extern EP_DetailsPane as const GUID
extern EP_PreviewPane as const GUID
extern EP_QueryPane as const GUID
extern EP_AdvQueryPane as const GUID
extern EP_StatusBar as const GUID
extern EP_Ribbon as const GUID
extern CATID_LocationFactory as const GUID
extern CATID_LocationProvider as const GUID
extern ItemCount_Property_GUID as const GUID
extern SelectedItemCount_Property_GUID as const GUID
extern ItemIndex_Property_GUID as const GUID
extern CATID_SearchableApplication as const GUID

end extern
