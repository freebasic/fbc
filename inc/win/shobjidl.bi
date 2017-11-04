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

#include once "rpc.bi"
#include once "rpcndr.bi"
#include once "windows.bi"
#include once "ole2.bi"
#include once "objidl.bi"
#include once "oleidl.bi"
#include once "oaidl.bi"
#include once "docobj.bi"
#include once "shtypes.bi"
#include once "servprov.bi"
#include once "comcat.bi"
#include once "propidl.bi"
#include once "prsht.bi"
#include once "msxml.bi"
#include once "wtypes.bi"
#include once "propsys.bi"
#include once "objectarray.bi"
#include once "structuredquerycondition.bi"
#include once "winapifamily.bi"
#include once "_mingw_unicode.bi"
#include once "sherrors.bi"
#include once "commctrl.bi"
#include once "shellapi.bi"

extern "Windows"

#define __shobjidl_h__
#define __IContextMenu_FWD_DEFINED__
#define __IContextMenu2_FWD_DEFINED__
#define __IContextMenu3_FWD_DEFINED__
#define __IExecuteCommand_FWD_DEFINED__
#define __IPersistFolder_FWD_DEFINED__
#define __IRunnableTask_FWD_DEFINED__
#define __IShellTaskScheduler_FWD_DEFINED__
#define __IQueryCodePage_FWD_DEFINED__
#define __IPersistFolder2_FWD_DEFINED__
#define __IPersistFolder3_FWD_DEFINED__
#define __IPersistIDList_FWD_DEFINED__
#define __IEnumIDList_FWD_DEFINED__
#define __IEnumFullIDList_FWD_DEFINED__
#define __IObjectWithFolderEnumMode_FWD_DEFINED__
#define __IParseAndCreateItem_FWD_DEFINED__
#define __IShellFolder_FWD_DEFINED__
#define __IEnumExtraSearch_FWD_DEFINED__
#define __IShellFolder2_FWD_DEFINED__
#define __IFolderViewOptions_FWD_DEFINED__
#define __IShellView_FWD_DEFINED__
#define __IShellView2_FWD_DEFINED__
#define __IShellView3_FWD_DEFINED__
#define __IFolderView_FWD_DEFINED__
#define __ISearchBoxInfo_FWD_DEFINED__
#define __IFolderView2_FWD_DEFINED__
#define __IFolderViewSettings_FWD_DEFINED__
#define __IPreviewHandlerVisuals_FWD_DEFINED__
#define __IVisualProperties_FWD_DEFINED__
#define __ICommDlgBrowser_FWD_DEFINED__
#define __ICommDlgBrowser2_FWD_DEFINED__
#define __ICommDlgBrowser3_FWD_DEFINED__
#define __IColumnManager_FWD_DEFINED__
#define __IFolderFilterSite_FWD_DEFINED__
#define __IFolderFilter_FWD_DEFINED__
#define __IInputObjectSite_FWD_DEFINED__
#define __IInputObject_FWD_DEFINED__
#define __IInputObject2_FWD_DEFINED__
#define __IShellIcon_FWD_DEFINED__
#define __IShellBrowser_FWD_DEFINED__
#define __IProfferService_FWD_DEFINED__
#define __IShellItem_FWD_DEFINED__
#define __IShellItem2_FWD_DEFINED__
#define __IShellItemImageFactory_FWD_DEFINED__
#define __IUserAccountChangeCallback_FWD_DEFINED__
#define __IEnumShellItems_FWD_DEFINED__
#define __ITransferAdviseSink_FWD_DEFINED__
#define __ITransferSource_FWD_DEFINED__
#define __IEnumResources_FWD_DEFINED__
#define __IShellItemResources_FWD_DEFINED__
#define __ITransferDestination_FWD_DEFINED__
#define __IStreamAsync_FWD_DEFINED__
#define __IStreamUnbufferedInfo_FWD_DEFINED__
#define __IFileOperationProgressSink_FWD_DEFINED__
#define __IShellItemArray_FWD_DEFINED__
#define __IInitializeWithItem_FWD_DEFINED__
#define __IObjectWithSelection_FWD_DEFINED__
#define __IObjectWithBackReferences_FWD_DEFINED__
#define __IPropertyUI_FWD_DEFINED__
#define __ICategoryProvider_FWD_DEFINED__
#define __ICategorizer_FWD_DEFINED__
#define __IDropTargetHelper_FWD_DEFINED__
#define __IDragSourceHelper_FWD_DEFINED__
#define __IDragSourceHelper2_FWD_DEFINED__
#define __IShellLinkA_FWD_DEFINED__
#define __IShellLinkW_FWD_DEFINED__
#define __IShellLinkDataList_FWD_DEFINED__
#define __IResolveShellLink_FWD_DEFINED__
#define __IActionProgressDialog_FWD_DEFINED__
#define __IHWEventHandler_FWD_DEFINED__
#define __IHWEventHandler2_FWD_DEFINED__
#define __IQueryCancelAutoPlay_FWD_DEFINED__
#define __IDynamicHWHandler_FWD_DEFINED__
#define __IActionProgress_FWD_DEFINED__
#define __IShellExtInit_FWD_DEFINED__
#define __IShellPropSheetExt_FWD_DEFINED__
#define __IRemoteComputer_FWD_DEFINED__
#define __IQueryContinue_FWD_DEFINED__
#define __IObjectWithCancelEvent_FWD_DEFINED__
#define __IUserNotification_FWD_DEFINED__
#define __IUserNotificationCallback_FWD_DEFINED__
#define __IUserNotification2_FWD_DEFINED__
#define __IItemNameLimits_FWD_DEFINED__
#define __ISearchFolderItemFactory_FWD_DEFINED__
#define __IExtractImage_FWD_DEFINED__
#define __IExtractImage2_FWD_DEFINED__
#define __IThumbnailHandlerFactory_FWD_DEFINED__
#define __IParentAndItem_FWD_DEFINED__
#define __IDockingWindow_FWD_DEFINED__
#define __IDeskBand_FWD_DEFINED__
#define __IDeskBandInfo_FWD_DEFINED__
#define __IDeskBand2_FWD_DEFINED__
#define __ITaskbarList_FWD_DEFINED__
#define __ITaskbarList2_FWD_DEFINED__
#define __ITaskbarList3_FWD_DEFINED__
#define __ITaskbarList4_FWD_DEFINED__
#define __IStartMenuPinnedList_FWD_DEFINED__
#define __ICDBurn_FWD_DEFINED__
#define __IWizardSite_FWD_DEFINED__
#define __IWizardExtension_FWD_DEFINED__
#define __IWebWizardExtension_FWD_DEFINED__
#define __IPublishingWizard_FWD_DEFINED__
#define __IFolderViewHost_FWD_DEFINED__
#define __IExplorerBrowserEvents_FWD_DEFINED__
#define __IExplorerBrowser_FWD_DEFINED__
#define __IAccessibleObject_FWD_DEFINED__
#define __IResultsFolder_FWD_DEFINED__
#define __IEnumObjects_FWD_DEFINED__
#define __IOperationsProgressDialog_FWD_DEFINED__
#define __IIOCancelInformation_FWD_DEFINED__
#define __IFileOperation_FWD_DEFINED__
#define __IObjectProvider_FWD_DEFINED__
#define __INamespaceWalkCB_FWD_DEFINED__
#define __INamespaceWalkCB2_FWD_DEFINED__
#define __INamespaceWalk_FWD_DEFINED__
#define __IAutoCompleteDropDown_FWD_DEFINED__
#define __IBandSite_FWD_DEFINED__
#define __IModalWindow_FWD_DEFINED__
#define __ICDBurnExt_FWD_DEFINED__
#define __IContextMenuSite_FWD_DEFINED__
#define __IEnumReadyCallback_FWD_DEFINED__
#define __IEnumerableView_FWD_DEFINED__
#define __IInsertItem_FWD_DEFINED__
#define __IMenuBand_FWD_DEFINED__
#define __IFolderBandPriv_FWD_DEFINED__
#define __IRegTreeItem_FWD_DEFINED__
#define __IImageRecompress_FWD_DEFINED__
#define __IDeskBar_FWD_DEFINED__
#define __IMenuPopup_FWD_DEFINED__
#define __IFileIsInUse_FWD_DEFINED__
#define __IFileDialogEvents_FWD_DEFINED__
#define __IFileDialog_FWD_DEFINED__
#define __IFileSaveDialog_FWD_DEFINED__
#define __IFileOpenDialog_FWD_DEFINED__
#define __IFileDialogCustomize_FWD_DEFINED__
#define __IFileDialogControlEvents_FWD_DEFINED__
#define __IFileDialog2_FWD_DEFINED__
#define __IApplicationAssociationRegistration_FWD_DEFINED__
#define __IApplicationAssociationRegistrationUI_FWD_DEFINED__
#define __IDelegateFolder_FWD_DEFINED__
#define __IBrowserFrameOptions_FWD_DEFINED__
#define __INewWindowManager_FWD_DEFINED__
#define __IAttachmentExecute_FWD_DEFINED__
#define __IShellMenuCallback_FWD_DEFINED__
#define __IShellMenu_FWD_DEFINED__
#define __IShellRunDll_FWD_DEFINED__
#define __IKnownFolder_FWD_DEFINED__
#define __IKnownFolderManager_FWD_DEFINED__
#define __ISharingConfigurationManager_FWD_DEFINED__
#define __IPreviousVersionsInfo_FWD_DEFINED__
#define __IRelatedItem_FWD_DEFINED__
#define __IIdentityName_FWD_DEFINED__
#define __IDelegateItem_FWD_DEFINED__
#define __ICurrentItem_FWD_DEFINED__
#define __ITransferMediumItem_FWD_DEFINED__
#define __IUseToBrowseItem_FWD_DEFINED__
#define __IDisplayItem_FWD_DEFINED__
#define __IViewStateIdentityItem_FWD_DEFINED__
#define __IPreviewItem_FWD_DEFINED__
#define __IDestinationStreamFactory_FWD_DEFINED__
#define __INewMenuClient_FWD_DEFINED__
#define __IInitializeWithBindCtx_FWD_DEFINED__
#define __IShellItemFilter_FWD_DEFINED__
#define __INameSpaceTreeControl_FWD_DEFINED__
#define __INameSpaceTreeControl2_FWD_DEFINED__
#define __INameSpaceTreeControlEvents_FWD_DEFINED__
#define __INameSpaceTreeControlDropHandler_FWD_DEFINED__
#define __INameSpaceTreeAccessible_FWD_DEFINED__
#define __INameSpaceTreeControlCustomDraw_FWD_DEFINED__
#define __INameSpaceTreeControlFolderCapabilities_FWD_DEFINED__
#define __IPreviewHandler_FWD_DEFINED__
#define __IPreviewHandlerFrame_FWD_DEFINED__
#define __ITrayDeskBand_FWD_DEFINED__
#define __IBandHost_FWD_DEFINED__
#define __IExplorerPaneVisibility_FWD_DEFINED__
#define __IContextMenuCB_FWD_DEFINED__
#define __IDefaultExtractIconInit_FWD_DEFINED__
#define __IExplorerCommand_FWD_DEFINED__
#define __IExplorerCommandState_FWD_DEFINED__
#define __IInitializeCommand_FWD_DEFINED__
#define __IEnumExplorerCommand_FWD_DEFINED__
#define __IExplorerCommandProvider_FWD_DEFINED__
#define __IInitializeNetworkFolder_FWD_DEFINED__
#define __IOpenControlPanel_FWD_DEFINED__
#define __IComputerInfoChangeNotify_FWD_DEFINED__
#define __IFileSystemBindData_FWD_DEFINED__
#define __IFileSystemBindData2_FWD_DEFINED__
#define __ICustomDestinationList_FWD_DEFINED__
#define __IApplicationDestinations_FWD_DEFINED__
#define __IApplicationDocumentLists_FWD_DEFINED__
#define __IObjectWithAppUserModelID_FWD_DEFINED__
#define __IObjectWithProgID_FWD_DEFINED__
#define __IUpdateIDList_FWD_DEFINED__
#define __IDesktopGadget_FWD_DEFINED__
#define __IDesktopWallpaper_FWD_DEFINED__
#define __IHomeGroup_FWD_DEFINED__
#define __IInitializeWithPropertyStore_FWD_DEFINED__
#define __IOpenSearchSource_FWD_DEFINED__
#define __IShellLibrary_FWD_DEFINED__
#define __IPlaybackManagerEvents_FWD_DEFINED__
#define __IPlaybackManager_FWD_DEFINED__
#define __IDefaultFolderMenuInitialize_FWD_DEFINED__
#define __IApplicationActivationManager_FWD_DEFINED__
#define __DesktopWallpaper_FWD_DEFINED__
#define __ShellDesktop_FWD_DEFINED__
#define __ShellFSFolder_FWD_DEFINED__
#define __NetworkPlaces_FWD_DEFINED__
#define __ShellLink_FWD_DEFINED__
#define __QueryCancelAutoPlay_FWD_DEFINED__
#define __DriveSizeCategorizer_FWD_DEFINED__
#define __DriveTypeCategorizer_FWD_DEFINED__
#define __FreeSpaceCategorizer_FWD_DEFINED__
#define __TimeCategorizer_FWD_DEFINED__
#define __SizeCategorizer_FWD_DEFINED__
#define __AlphabeticalCategorizer_FWD_DEFINED__
#define __MergedCategorizer_FWD_DEFINED__
#define __ImageProperties_FWD_DEFINED__
#define __PropertiesUI_FWD_DEFINED__
#define __UserNotification_FWD_DEFINED__
#define __CDBurn_FWD_DEFINED__
#define __TaskbarList_FWD_DEFINED__
#define __StartMenuPin_FWD_DEFINED__
#define __WebWizardHost_FWD_DEFINED__
#define __PublishDropTarget_FWD_DEFINED__
#define __PublishingWizard_FWD_DEFINED__
#define __InternetPrintOrdering_FWD_DEFINED__
#define __FolderViewHost_FWD_DEFINED__
#define __ExplorerBrowser_FWD_DEFINED__
#define __ImageRecompress_FWD_DEFINED__
#define __TrayBandSiteService_FWD_DEFINED__
#define __TrayDeskBand_FWD_DEFINED__
#define __AttachmentServices_FWD_DEFINED__
#define __DocPropShellExtension_FWD_DEFINED__
#define __ShellItem_FWD_DEFINED__
#define __NamespaceWalker_FWD_DEFINED__
#define __FileOperation_FWD_DEFINED__
#define __FileOpenDialog_FWD_DEFINED__
#define __FileSaveDialog_FWD_DEFINED__
#define __KnownFolderManager_FWD_DEFINED__
#define __FSCopyHandler_FWD_DEFINED__
#define __SharingConfigurationManager_FWD_DEFINED__
#define __PreviousVersions_FWD_DEFINED__
#define __NetworkConnections_FWD_DEFINED__
#define __NamespaceTreeControl_FWD_DEFINED__
#define __IENamespaceTreeControl_FWD_DEFINED__
#define __ScheduledTasks_FWD_DEFINED__
#define __ApplicationAssociationRegistration_FWD_DEFINED__
#define __ApplicationAssociationRegistrationUI_FWD_DEFINED__
#define __SearchFolderItemFactory_FWD_DEFINED__
#define __OpenControlPanel_FWD_DEFINED__
#define __MailRecipient_FWD_DEFINED__
#define __NetworkExplorerFolder_FWD_DEFINED__
#define __DestinationList_FWD_DEFINED__
#define __ApplicationDestinations_FWD_DEFINED__
#define __ApplicationDocumentLists_FWD_DEFINED__
#define __HomeGroup_FWD_DEFINED__
#define __ShellLibrary_FWD_DEFINED__
#define __AppStartupLink_FWD_DEFINED__
#define __EnumerableObjectCollection_FWD_DEFINED__
#define __DesktopGadget_FWD_DEFINED__
#define __PlaybackManager_FWD_DEFINED__
#define __AccessibilityDockingService_FWD_DEFINED__
#define __FrameworkInputPane_FWD_DEFINED__
#define __DefFolderMenu_FWD_DEFINED__
#define __AppVisibility_FWD_DEFINED__
#define __AppShellVerbHandler_FWD_DEFINED__
#define __ExecuteUnknown_FWD_DEFINED__
#define __PackageDebugSettings_FWD_DEFINED__
#define __ApplicationActivationManager_FWD_DEFINED__
#define __ApplicationDesignModeSettings_FWD_DEFINED__
#define __ExecuteFolder_FWD_DEFINED__
#define __IAssocHandlerInvoker_FWD_DEFINED__
#define __IAssocHandler_FWD_DEFINED__
#define __IEnumAssocHandlers_FWD_DEFINED__
#define __IDataObjectProvider_FWD_DEFINED__
#define __IDataTransferManagerInterop_FWD_DEFINED__
#define __IFrameworkInputPaneHandler_FWD_DEFINED__
#define __IFrameworkInputPane_FWD_DEFINED__
#define __ISearchableApplication_FWD_DEFINED__
#define __IAccessibilityDockingServiceCallback_FWD_DEFINED__
#define __IAccessibilityDockingService_FWD_DEFINED__
#define __IAppVisibilityEvents_FWD_DEFINED__
#define __IAppVisibility_FWD_DEFINED__
#define __IPackageExecutionStateChangeNotification_FWD_DEFINED__
#define __IPackageDebugSettings_FWD_DEFINED__
#define __IExecuteCommandApplicationHostEnvironment_FWD_DEFINED__
#define __IExecuteCommandHost_FWD_DEFINED__
#define __IApplicationDesignModeSettings_FWD_DEFINED__
#define __IInitializeWithWindow_FWD_DEFINED__
#define __IHandlerInfo_FWD_DEFINED__
#define __IHandlerActivationHost_FWD_DEFINED__
const CMF_NORMAL = &h0
const CMF_DEFAULTONLY = &h1
const CMF_VERBSONLY = &h2
const CMF_EXPLORE = &h4
const CMF_NOVERBS = &h8
const CMF_CANRENAME = &h10
const CMF_NODEFAULT = &h20

#if _WIN32_WINNT <= &h0502
	const CMF_INCLUDESTATIC = &h40
#else
	const CMF_ITEMMENU = &h80
#endif

const CMF_EXTENDEDVERBS = &h100

#if _WIN32_WINNT >= &h0600
	const CMF_DISABLEDVERBS = &h200
#endif

const CMF_ASYNCVERBSTATE = &h400
const CMF_OPTIMIZEFORINVOKE = &h800
const CMF_SYNCCASCADEMENU = &h1000
const CMF_DONOTPICKDEFAULT = &h2000
const CMF_RESERVED = &hffff0000
const GCS_VERBA = &h0
const GCS_HELPTEXTA = &h1
const GCS_VALIDATEA = &h2
const GCS_VERBW = &h4
const GCS_HELPTEXTW = &h5
const GCS_VALIDATEW = &h6
const GCS_VERBICONW = &h14
const GCS_UNICODE = &h4

#ifdef UNICODE
	const GCS_VERB = GCS_VERBW
	const GCS_HELPTEXT = GCS_HELPTEXTW
	const GCS_VALIDATE = GCS_VALIDATEW
#else
	const GCS_VERB = GCS_VERBA
	const GCS_HELPTEXT = GCS_HELPTEXTA
	const GCS_VALIDATE = GCS_VALIDATEA
#endif

#define CMDSTR_NEWFOLDERA "NewFolder"
#define CMDSTR_VIEWLISTA "ViewList"
#define CMDSTR_VIEWDETAILSA "ViewDetails"
#define CMDSTR_NEWFOLDERW wstr("NewFolder")
#define CMDSTR_VIEWLISTW wstr("ViewList")
#define CMDSTR_VIEWDETAILSW wstr("ViewDetails")

#ifdef UNICODE
	#define CMDSTR_NEWFOLDER CMDSTR_NEWFOLDERW
	#define CMDSTR_VIEWLIST CMDSTR_VIEWLISTW
	#define CMDSTR_VIEWDETAILS CMDSTR_VIEWDETAILSW
#else
	#define CMDSTR_NEWFOLDER CMDSTR_NEWFOLDERA
	#define CMDSTR_VIEWLIST CMDSTR_VIEWLISTA
	#define CMDSTR_VIEWDETAILS CMDSTR_VIEWDETAILSA
#endif

const CMIC_MASK_HOTKEY = SEE_MASK_HOTKEY

#if _WIN32_WINNT <= &h0502
	const CMIC_MASK_ICON = SEE_MASK_ICON
#else
	#define CMIC_MASK_ICON SEE_MASK_ICON
#endif

const CMIC_MASK_FLAG_NO_UI = SEE_MASK_FLAG_NO_UI
const CMIC_MASK_UNICODE = SEE_MASK_UNICODE
const CMIC_MASK_NO_CONSOLE = SEE_MASK_NO_CONSOLE

#if _WIN32_WINNT <= &h0502
	#define CMIC_MASK_HASLINKNAME SEE_MASK_HASLINKNAME
	#define CMIC_MASK_HASTITLE SEE_MASK_HASTITLE
#endif

#define CMIC_MASK_FLAG_SEP_VDM SEE_MASK_FLAG_SEPVDM
const CMIC_MASK_ASYNCOK = SEE_MASK_ASYNCOK

#if _WIN32_WINNT >= &h0600
	const CMIC_MASK_NOASYNC = SEE_MASK_NOASYNC
#endif

const CMIC_MASK_SHIFT_DOWN = &h10000000
const CMIC_MASK_CONTROL_DOWN = &h40000000
const CMIC_MASK_FLAG_LOG_USAGE = SEE_MASK_FLAG_LOG_USAGE
const CMIC_MASK_NOZONECHECKS = SEE_MASK_NOZONECHECKS
const CMIC_MASK_PTINVOKE = &h20000000

type _CMINVOKECOMMANDINFO
	cbSize as DWORD
	fMask as DWORD
	hwnd as HWND
	lpVerb as LPCSTR
	lpParameters as LPCSTR
	lpDirectory as LPCSTR
	nShow as long
	dwHotKey as DWORD
	hIcon as HANDLE
end type

type CMINVOKECOMMANDINFO as _CMINVOKECOMMANDINFO
type LPCMINVOKECOMMANDINFO as CMINVOKECOMMANDINFO ptr
type PCCMINVOKECOMMANDINFO as const CMINVOKECOMMANDINFO ptr

type _CMINVOKECOMMANDINFOEX
	cbSize as DWORD
	fMask as DWORD
	hwnd as HWND
	lpVerb as LPCSTR
	lpParameters as LPCSTR
	lpDirectory as LPCSTR
	nShow as long
	dwHotKey as DWORD
	hIcon as HANDLE
	lpTitle as LPCSTR
	lpVerbW as LPCWSTR
	lpParametersW as LPCWSTR
	lpDirectoryW as LPCWSTR
	lpTitleW as LPCWSTR
	ptInvoke as POINT
end type

type CMINVOKECOMMANDINFOEX as _CMINVOKECOMMANDINFOEX
type LPCMINVOKECOMMANDINFOEX as CMINVOKECOMMANDINFOEX ptr
type PCCMINVOKECOMMANDINFOEX as const CMINVOKECOMMANDINFOEX ptr
#define __IContextMenu_INTERFACE_DEFINED__
extern IID_IContextMenu as const GUID
type IContextMenu as IContextMenu_

type IContextMenuVtbl
	QueryInterface as function(byval This as IContextMenu ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IContextMenu ptr) as ULONG
	Release as function(byval This as IContextMenu ptr) as ULONG
	QueryContextMenu as function(byval This as IContextMenu ptr, byval hmenu as HMENU, byval indexMenu as UINT, byval idCmdFirst as UINT, byval idCmdLast as UINT, byval uFlags as UINT) as HRESULT
	InvokeCommand as function(byval This as IContextMenu ptr, byval pici as CMINVOKECOMMANDINFO ptr) as HRESULT
	GetCommandString as function(byval This as IContextMenu ptr, byval idCmd as UINT_PTR, byval uType as UINT, byval pReserved as UINT ptr, byval pszName as zstring ptr, byval cchMax as UINT) as HRESULT
end type

type IContextMenu_
	lpVtbl as IContextMenuVtbl ptr
end type

#define IContextMenu_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IContextMenu_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IContextMenu_Release(This) (This)->lpVtbl->Release(This)
#define IContextMenu_QueryContextMenu(This, hmenu, indexMenu, idCmdFirst, idCmdLast, uFlags) (This)->lpVtbl->QueryContextMenu(This, hmenu, indexMenu, idCmdFirst, idCmdLast, uFlags)
#define IContextMenu_InvokeCommand(This, pici) (This)->lpVtbl->InvokeCommand(This, pici)
#define IContextMenu_GetCommandString(This, idCmd, uType, pReserved, pszName, cchMax) (This)->lpVtbl->GetCommandString(This, idCmd, uType, pReserved, pszName, cchMax)

declare function IContextMenu_QueryContextMenu_Proxy(byval This as IContextMenu ptr, byval hmenu as HMENU, byval indexMenu as UINT, byval idCmdFirst as UINT, byval idCmdLast as UINT, byval uFlags as UINT) as HRESULT
declare sub IContextMenu_QueryContextMenu_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IContextMenu_InvokeCommand_Proxy(byval This as IContextMenu ptr, byval pici as CMINVOKECOMMANDINFO ptr) as HRESULT
declare sub IContextMenu_InvokeCommand_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IContextMenu_GetCommandString_Proxy(byval This as IContextMenu ptr, byval idCmd as UINT_PTR, byval uType as UINT, byval pReserved as UINT ptr, byval pszName as zstring ptr, byval cchMax as UINT) as HRESULT
declare sub IContextMenu_GetCommandString_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
type LPCONTEXTMENU as IContextMenu ptr
#define __IContextMenu2_INTERFACE_DEFINED__
extern IID_IContextMenu2 as const GUID
type IContextMenu2 as IContextMenu2_

type IContextMenu2Vtbl
	QueryInterface as function(byval This as IContextMenu2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IContextMenu2 ptr) as ULONG
	Release as function(byval This as IContextMenu2 ptr) as ULONG
	QueryContextMenu as function(byval This as IContextMenu2 ptr, byval hmenu as HMENU, byval indexMenu as UINT, byval idCmdFirst as UINT, byval idCmdLast as UINT, byval uFlags as UINT) as HRESULT
	InvokeCommand as function(byval This as IContextMenu2 ptr, byval pici as CMINVOKECOMMANDINFO ptr) as HRESULT
	GetCommandString as function(byval This as IContextMenu2 ptr, byval idCmd as UINT_PTR, byval uType as UINT, byval pReserved as UINT ptr, byval pszName as zstring ptr, byval cchMax as UINT) as HRESULT
	HandleMenuMsg as function(byval This as IContextMenu2 ptr, byval uMsg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as HRESULT
end type

type IContextMenu2_
	lpVtbl as IContextMenu2Vtbl ptr
end type

#define IContextMenu2_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IContextMenu2_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IContextMenu2_Release(This) (This)->lpVtbl->Release(This)
#define IContextMenu2_QueryContextMenu(This, hmenu, indexMenu, idCmdFirst, idCmdLast, uFlags) (This)->lpVtbl->QueryContextMenu(This, hmenu, indexMenu, idCmdFirst, idCmdLast, uFlags)
#define IContextMenu2_InvokeCommand(This, pici) (This)->lpVtbl->InvokeCommand(This, pici)
#define IContextMenu2_GetCommandString(This, idCmd, uType, pReserved, pszName, cchMax) (This)->lpVtbl->GetCommandString(This, idCmd, uType, pReserved, pszName, cchMax)
#define IContextMenu2_HandleMenuMsg(This, uMsg, wParam, lParam) (This)->lpVtbl->HandleMenuMsg(This, uMsg, wParam, lParam)
declare function IContextMenu2_HandleMenuMsg_Proxy(byval This as IContextMenu2 ptr, byval uMsg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as HRESULT
declare sub IContextMenu2_HandleMenuMsg_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
type LPCONTEXTMENU2 as IContextMenu2 ptr
#define __IContextMenu3_INTERFACE_DEFINED__
extern IID_IContextMenu3 as const GUID
type IContextMenu3 as IContextMenu3_

type IContextMenu3Vtbl
	QueryInterface as function(byval This as IContextMenu3 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IContextMenu3 ptr) as ULONG
	Release as function(byval This as IContextMenu3 ptr) as ULONG
	QueryContextMenu as function(byval This as IContextMenu3 ptr, byval hmenu as HMENU, byval indexMenu as UINT, byval idCmdFirst as UINT, byval idCmdLast as UINT, byval uFlags as UINT) as HRESULT
	InvokeCommand as function(byval This as IContextMenu3 ptr, byval pici as CMINVOKECOMMANDINFO ptr) as HRESULT
	GetCommandString as function(byval This as IContextMenu3 ptr, byval idCmd as UINT_PTR, byval uType as UINT, byval pReserved as UINT ptr, byval pszName as zstring ptr, byval cchMax as UINT) as HRESULT
	HandleMenuMsg as function(byval This as IContextMenu3 ptr, byval uMsg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as HRESULT
	HandleMenuMsg2 as function(byval This as IContextMenu3 ptr, byval uMsg as UINT, byval wParam as WPARAM, byval lParam as LPARAM, byval plResult as LRESULT ptr) as HRESULT
end type

type IContextMenu3_
	lpVtbl as IContextMenu3Vtbl ptr
end type

#define IContextMenu3_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IContextMenu3_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IContextMenu3_Release(This) (This)->lpVtbl->Release(This)
#define IContextMenu3_QueryContextMenu(This, hmenu, indexMenu, idCmdFirst, idCmdLast, uFlags) (This)->lpVtbl->QueryContextMenu(This, hmenu, indexMenu, idCmdFirst, idCmdLast, uFlags)
#define IContextMenu3_InvokeCommand(This, pici) (This)->lpVtbl->InvokeCommand(This, pici)
#define IContextMenu3_GetCommandString(This, idCmd, uType, pReserved, pszName, cchMax) (This)->lpVtbl->GetCommandString(This, idCmd, uType, pReserved, pszName, cchMax)
#define IContextMenu3_HandleMenuMsg(This, uMsg, wParam, lParam) (This)->lpVtbl->HandleMenuMsg(This, uMsg, wParam, lParam)
#define IContextMenu3_HandleMenuMsg2(This, uMsg, wParam, lParam, plResult) (This)->lpVtbl->HandleMenuMsg2(This, uMsg, wParam, lParam, plResult)
declare function IContextMenu3_HandleMenuMsg2_Proxy(byval This as IContextMenu3 ptr, byval uMsg as UINT, byval wParam as WPARAM, byval lParam as LPARAM, byval plResult as LRESULT ptr) as HRESULT
declare sub IContextMenu3_HandleMenuMsg2_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
type LPCONTEXTMENU3 as IContextMenu3 ptr
#define __IExecuteCommand_INTERFACE_DEFINED__
extern IID_IExecuteCommand as const GUID
type IExecuteCommand as IExecuteCommand_

type IExecuteCommandVtbl
	QueryInterface as function(byval This as IExecuteCommand ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IExecuteCommand ptr) as ULONG
	Release as function(byval This as IExecuteCommand ptr) as ULONG
	SetKeyState as function(byval This as IExecuteCommand ptr, byval grfKeyState as DWORD) as HRESULT
	SetParameters as function(byval This as IExecuteCommand ptr, byval pszParameters as LPCWSTR) as HRESULT
	SetPosition as function(byval This as IExecuteCommand ptr, byval pt as POINT) as HRESULT
	SetShowWindow as function(byval This as IExecuteCommand ptr, byval nShow as long) as HRESULT
	SetNoShowUI as function(byval This as IExecuteCommand ptr, byval fNoShowUI as WINBOOL) as HRESULT
	SetDirectory as function(byval This as IExecuteCommand ptr, byval pszDirectory as LPCWSTR) as HRESULT
	Execute as function(byval This as IExecuteCommand ptr) as HRESULT
end type

type IExecuteCommand_
	lpVtbl as IExecuteCommandVtbl ptr
end type

#define IExecuteCommand_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IExecuteCommand_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IExecuteCommand_Release(This) (This)->lpVtbl->Release(This)
#define IExecuteCommand_SetKeyState(This, grfKeyState) (This)->lpVtbl->SetKeyState(This, grfKeyState)
#define IExecuteCommand_SetParameters(This, pszParameters) (This)->lpVtbl->SetParameters(This, pszParameters)
#define IExecuteCommand_SetPosition(This, pt) (This)->lpVtbl->SetPosition(This, pt)
#define IExecuteCommand_SetShowWindow(This, nShow) (This)->lpVtbl->SetShowWindow(This, nShow)
#define IExecuteCommand_SetNoShowUI(This, fNoShowUI) (This)->lpVtbl->SetNoShowUI(This, fNoShowUI)
#define IExecuteCommand_SetDirectory(This, pszDirectory) (This)->lpVtbl->SetDirectory(This, pszDirectory)
#define IExecuteCommand_Execute(This) (This)->lpVtbl->Execute(This)

declare function IExecuteCommand_SetKeyState_Proxy(byval This as IExecuteCommand ptr, byval grfKeyState as DWORD) as HRESULT
declare sub IExecuteCommand_SetKeyState_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IExecuteCommand_SetParameters_Proxy(byval This as IExecuteCommand ptr, byval pszParameters as LPCWSTR) as HRESULT
declare sub IExecuteCommand_SetParameters_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IExecuteCommand_SetPosition_Proxy(byval This as IExecuteCommand ptr, byval pt as POINT) as HRESULT
declare sub IExecuteCommand_SetPosition_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IExecuteCommand_SetShowWindow_Proxy(byval This as IExecuteCommand ptr, byval nShow as long) as HRESULT
declare sub IExecuteCommand_SetShowWindow_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IExecuteCommand_SetNoShowUI_Proxy(byval This as IExecuteCommand ptr, byval fNoShowUI as WINBOOL) as HRESULT
declare sub IExecuteCommand_SetNoShowUI_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IExecuteCommand_SetDirectory_Proxy(byval This as IExecuteCommand ptr, byval pszDirectory as LPCWSTR) as HRESULT
declare sub IExecuteCommand_SetDirectory_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IExecuteCommand_Execute_Proxy(byval This as IExecuteCommand ptr) as HRESULT
declare sub IExecuteCommand_Execute_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IPersistFolder_INTERFACE_DEFINED__
extern IID_IPersistFolder as const GUID
type IPersistFolder as IPersistFolder_

type IPersistFolderVtbl
	QueryInterface as function(byval This as IPersistFolder ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPersistFolder ptr) as ULONG
	Release as function(byval This as IPersistFolder ptr) as ULONG
	GetClassID as function(byval This as IPersistFolder ptr, byval pClassID as CLSID ptr) as HRESULT
	Initialize as function(byval This as IPersistFolder ptr, byval pidl as LPCITEMIDLIST) as HRESULT
end type

type IPersistFolder_
	lpVtbl as IPersistFolderVtbl ptr
end type

#define IPersistFolder_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IPersistFolder_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IPersistFolder_Release(This) (This)->lpVtbl->Release(This)
#define IPersistFolder_GetClassID(This, pClassID) (This)->lpVtbl->GetClassID(This, pClassID)
#define IPersistFolder_Initialize(This, pidl) (This)->lpVtbl->Initialize(This, pidl)
declare function IPersistFolder_Initialize_Proxy(byval This as IPersistFolder ptr, byval pidl as LPCITEMIDLIST) as HRESULT
declare sub IPersistFolder_Initialize_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
type LPPERSISTFOLDER as IPersistFolder ptr
const IRTIR_TASK_NOT_RUNNING = 0
const IRTIR_TASK_RUNNING = 1
const IRTIR_TASK_SUSPENDED = 2
const IRTIR_TASK_PENDING = 3
const IRTIR_TASK_FINISHED = 4
#define __IRunnableTask_INTERFACE_DEFINED__
extern IID_IRunnableTask as const GUID
type IRunnableTask as IRunnableTask_

type IRunnableTaskVtbl
	QueryInterface as function(byval This as IRunnableTask ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IRunnableTask ptr) as ULONG
	Release as function(byval This as IRunnableTask ptr) as ULONG
	Run as function(byval This as IRunnableTask ptr) as HRESULT
	Kill as function(byval This as IRunnableTask ptr, byval bWait as WINBOOL) as HRESULT
	Suspend as function(byval This as IRunnableTask ptr) as HRESULT
	Resume as function(byval This as IRunnableTask ptr) as HRESULT
	IsRunning as function(byval This as IRunnableTask ptr) as ULONG
end type

type IRunnableTask_
	lpVtbl as IRunnableTaskVtbl ptr
end type

#define IRunnableTask_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IRunnableTask_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IRunnableTask_Release(This) (This)->lpVtbl->Release(This)
#define IRunnableTask_Run(This) (This)->lpVtbl->Run(This)
#define IRunnableTask_Kill(This, bWait) (This)->lpVtbl->Kill(This, bWait)
#define IRunnableTask_Suspend(This) (This)->lpVtbl->Suspend(This)
#define IRunnableTask_Resume(This) (This)->lpVtbl->Resume(This)
#define IRunnableTask_IsRunning(This) (This)->lpVtbl->IsRunning(This)

declare function IRunnableTask_Run_Proxy(byval This as IRunnableTask ptr) as HRESULT
declare sub IRunnableTask_Run_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IRunnableTask_Kill_Proxy(byval This as IRunnableTask ptr, byval bWait as WINBOOL) as HRESULT
declare sub IRunnableTask_Kill_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IRunnableTask_Suspend_Proxy(byval This as IRunnableTask ptr) as HRESULT
declare sub IRunnableTask_Suspend_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IRunnableTask_Resume_Proxy(byval This as IRunnableTask ptr) as HRESULT
declare sub IRunnableTask_Resume_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IRunnableTask_IsRunning_Proxy(byval This as IRunnableTask ptr) as ULONG
declare sub IRunnableTask_IsRunning_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
extern TOID_NULL alias "GUID_NULL" as const IID

const ITSAT_DEFAULT_LPARAM = cast(DWORD_PTR, -1)
const ITSAT_DEFAULT_PRIORITY = &h10000000
const ITSAT_MAX_PRIORITY = &h7fffffff
const ITSAT_MIN_PRIORITY = &h00000000
const ITSSFLAG_COMPLETE_ON_DESTROY = &h0
const ITSSFLAG_KILL_ON_DESTROY = &h1
const ITSSFLAG_FLAGS_MASK = &h3
const ITSS_THREAD_DESTROY_DEFAULT_TIMEOUT = 10 * 1000
const ITSS_THREAD_TERMINATE_TIMEOUT = INFINITE
const ITSS_THREAD_TIMEOUT_NO_CHANGE = INFINITE - 1
#define __IShellTaskScheduler_INTERFACE_DEFINED__
extern IID_IShellTaskScheduler as const GUID
type IShellTaskScheduler as IShellTaskScheduler_

type IShellTaskSchedulerVtbl
	QueryInterface as function(byval This as IShellTaskScheduler ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IShellTaskScheduler ptr) as ULONG
	Release as function(byval This as IShellTaskScheduler ptr) as ULONG
	AddTask as function(byval This as IShellTaskScheduler ptr, byval prt as IRunnableTask ptr, byval rtoid as const TASKOWNERID const ptr, byval lParam as DWORD_PTR, byval dwPriority as DWORD) as HRESULT
	RemoveTasks as function(byval This as IShellTaskScheduler ptr, byval rtoid as const TASKOWNERID const ptr, byval lParam as DWORD_PTR, byval bWaitIfRunning as WINBOOL) as HRESULT
	CountTasks as function(byval This as IShellTaskScheduler ptr, byval rtoid as const TASKOWNERID const ptr) as UINT
	Status as function(byval This as IShellTaskScheduler ptr, byval dwReleaseStatus as DWORD, byval dwThreadTimeout as DWORD) as HRESULT
end type

type IShellTaskScheduler_
	lpVtbl as IShellTaskSchedulerVtbl ptr
end type

#define IShellTaskScheduler_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IShellTaskScheduler_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IShellTaskScheduler_Release(This) (This)->lpVtbl->Release(This)
#define IShellTaskScheduler_AddTask(This, prt, rtoid, lParam, dwPriority) (This)->lpVtbl->AddTask(This, prt, rtoid, lParam, dwPriority)
#define IShellTaskScheduler_RemoveTasks(This, rtoid, lParam, bWaitIfRunning) (This)->lpVtbl->RemoveTasks(This, rtoid, lParam, bWaitIfRunning)
#define IShellTaskScheduler_CountTasks(This, rtoid) (This)->lpVtbl->CountTasks(This, rtoid)
#define IShellTaskScheduler_Status(This, dwReleaseStatus, dwThreadTimeout) (This)->lpVtbl->Status(This, dwReleaseStatus, dwThreadTimeout)

declare function IShellTaskScheduler_AddTask_Proxy(byval This as IShellTaskScheduler ptr, byval prt as IRunnableTask ptr, byval rtoid as const TASKOWNERID const ptr, byval lParam as DWORD_PTR, byval dwPriority as DWORD) as HRESULT
declare sub IShellTaskScheduler_AddTask_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellTaskScheduler_RemoveTasks_Proxy(byval This as IShellTaskScheduler ptr, byval rtoid as const TASKOWNERID const ptr, byval lParam as DWORD_PTR, byval bWaitIfRunning as WINBOOL) as HRESULT
declare sub IShellTaskScheduler_RemoveTasks_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellTaskScheduler_CountTasks_Proxy(byval This as IShellTaskScheduler ptr, byval rtoid as const TASKOWNERID const ptr) as UINT
declare sub IShellTaskScheduler_CountTasks_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellTaskScheduler_Status_Proxy(byval This as IShellTaskScheduler ptr, byval dwReleaseStatus as DWORD, byval dwThreadTimeout as DWORD) as HRESULT
declare sub IShellTaskScheduler_Status_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
extern SID_ShellTaskScheduler alias "IID_IShellTaskScheduler" as const GUID
#define __IQueryCodePage_INTERFACE_DEFINED__
extern IID_IQueryCodePage as const GUID
type IQueryCodePage as IQueryCodePage_

type IQueryCodePageVtbl
	QueryInterface as function(byval This as IQueryCodePage ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IQueryCodePage ptr) as ULONG
	Release as function(byval This as IQueryCodePage ptr) as ULONG
	GetCodePage as function(byval This as IQueryCodePage ptr, byval puiCodePage as UINT ptr) as HRESULT
	SetCodePage as function(byval This as IQueryCodePage ptr, byval uiCodePage as UINT) as HRESULT
end type

type IQueryCodePage_
	lpVtbl as IQueryCodePageVtbl ptr
end type

#define IQueryCodePage_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IQueryCodePage_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IQueryCodePage_Release(This) (This)->lpVtbl->Release(This)
#define IQueryCodePage_GetCodePage(This, puiCodePage) (This)->lpVtbl->GetCodePage(This, puiCodePage)
#define IQueryCodePage_SetCodePage(This, uiCodePage) (This)->lpVtbl->SetCodePage(This, uiCodePage)

declare function IQueryCodePage_GetCodePage_Proxy(byval This as IQueryCodePage ptr, byval puiCodePage as UINT ptr) as HRESULT
declare sub IQueryCodePage_GetCodePage_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IQueryCodePage_SetCodePage_Proxy(byval This as IQueryCodePage ptr, byval uiCodePage as UINT) as HRESULT
declare sub IQueryCodePage_SetCodePage_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IPersistFolder2_INTERFACE_DEFINED__
extern IID_IPersistFolder2 as const GUID
type IPersistFolder2 as IPersistFolder2_

type IPersistFolder2Vtbl
	QueryInterface as function(byval This as IPersistFolder2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPersistFolder2 ptr) as ULONG
	Release as function(byval This as IPersistFolder2 ptr) as ULONG
	GetClassID as function(byval This as IPersistFolder2 ptr, byval pClassID as CLSID ptr) as HRESULT
	Initialize as function(byval This as IPersistFolder2 ptr, byval pidl as LPCITEMIDLIST) as HRESULT
	GetCurFolder as function(byval This as IPersistFolder2 ptr, byval ppidl as LPITEMIDLIST ptr) as HRESULT
end type

type IPersistFolder2_
	lpVtbl as IPersistFolder2Vtbl ptr
end type

#define IPersistFolder2_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IPersistFolder2_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IPersistFolder2_Release(This) (This)->lpVtbl->Release(This)
#define IPersistFolder2_GetClassID(This, pClassID) (This)->lpVtbl->GetClassID(This, pClassID)
#define IPersistFolder2_Initialize(This, pidl) (This)->lpVtbl->Initialize(This, pidl)
#define IPersistFolder2_GetCurFolder(This, ppidl) (This)->lpVtbl->GetCurFolder(This, ppidl)
declare function IPersistFolder2_GetCurFolder_Proxy(byval This as IPersistFolder2 ptr, byval ppidl as LPITEMIDLIST ptr) as HRESULT
declare sub IPersistFolder2_GetCurFolder_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

type _PERSIST_FOLDER_TARGET_INFO
	pidlTargetFolder as LPITEMIDLIST
	szTargetParsingName as wstring * 260
	szNetworkProvider as wstring * 260
	dwAttributes as DWORD
	csidl as long
end type

type PERSIST_FOLDER_TARGET_INFO as _PERSIST_FOLDER_TARGET_INFO
#define __IPersistFolder3_INTERFACE_DEFINED__
extern IID_IPersistFolder3 as const GUID
type IPersistFolder3 as IPersistFolder3_

type IPersistFolder3Vtbl
	QueryInterface as function(byval This as IPersistFolder3 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPersistFolder3 ptr) as ULONG
	Release as function(byval This as IPersistFolder3 ptr) as ULONG
	GetClassID as function(byval This as IPersistFolder3 ptr, byval pClassID as CLSID ptr) as HRESULT
	Initialize as function(byval This as IPersistFolder3 ptr, byval pidl as LPCITEMIDLIST) as HRESULT
	GetCurFolder as function(byval This as IPersistFolder3 ptr, byval ppidl as LPITEMIDLIST ptr) as HRESULT
	InitializeEx as function(byval This as IPersistFolder3 ptr, byval pbc as IBindCtx ptr, byval pidlRoot as LPCITEMIDLIST, byval ppfti as const PERSIST_FOLDER_TARGET_INFO ptr) as HRESULT
	GetFolderTargetInfo as function(byval This as IPersistFolder3 ptr, byval ppfti as PERSIST_FOLDER_TARGET_INFO ptr) as HRESULT
end type

type IPersistFolder3_
	lpVtbl as IPersistFolder3Vtbl ptr
end type

#define IPersistFolder3_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IPersistFolder3_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IPersistFolder3_Release(This) (This)->lpVtbl->Release(This)
#define IPersistFolder3_GetClassID(This, pClassID) (This)->lpVtbl->GetClassID(This, pClassID)
#define IPersistFolder3_Initialize(This, pidl) (This)->lpVtbl->Initialize(This, pidl)
#define IPersistFolder3_GetCurFolder(This, ppidl) (This)->lpVtbl->GetCurFolder(This, ppidl)
#define IPersistFolder3_InitializeEx(This, pbc, pidlRoot, ppfti) (This)->lpVtbl->InitializeEx(This, pbc, pidlRoot, ppfti)
#define IPersistFolder3_GetFolderTargetInfo(This, ppfti) (This)->lpVtbl->GetFolderTargetInfo(This, ppfti)

declare function IPersistFolder3_InitializeEx_Proxy(byval This as IPersistFolder3 ptr, byval pbc as IBindCtx ptr, byval pidlRoot as LPCITEMIDLIST, byval ppfti as const PERSIST_FOLDER_TARGET_INFO ptr) as HRESULT
declare sub IPersistFolder3_InitializeEx_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPersistFolder3_GetFolderTargetInfo_Proxy(byval This as IPersistFolder3 ptr, byval ppfti as PERSIST_FOLDER_TARGET_INFO ptr) as HRESULT
declare sub IPersistFolder3_GetFolderTargetInfo_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IPersistIDList_INTERFACE_DEFINED__
extern IID_IPersistIDList as const GUID
type IPersistIDList as IPersistIDList_

type IPersistIDListVtbl
	QueryInterface as function(byval This as IPersistIDList ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPersistIDList ptr) as ULONG
	Release as function(byval This as IPersistIDList ptr) as ULONG
	GetClassID as function(byval This as IPersistIDList ptr, byval pClassID as CLSID ptr) as HRESULT
	SetIDList as function(byval This as IPersistIDList ptr, byval pidl as LPCITEMIDLIST) as HRESULT
	GetIDList as function(byval This as IPersistIDList ptr, byval ppidl as LPITEMIDLIST ptr) as HRESULT
end type

type IPersistIDList_
	lpVtbl as IPersistIDListVtbl ptr
end type

#define IPersistIDList_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IPersistIDList_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IPersistIDList_Release(This) (This)->lpVtbl->Release(This)
#define IPersistIDList_GetClassID(This, pClassID) (This)->lpVtbl->GetClassID(This, pClassID)
#define IPersistIDList_SetIDList(This, pidl) (This)->lpVtbl->SetIDList(This, pidl)
#define IPersistIDList_GetIDList(This, ppidl) (This)->lpVtbl->GetIDList(This, ppidl)

declare function IPersistIDList_SetIDList_Proxy(byval This as IPersistIDList ptr, byval pidl as LPCITEMIDLIST) as HRESULT
declare sub IPersistIDList_SetIDList_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPersistIDList_GetIDList_Proxy(byval This as IPersistIDList ptr, byval ppidl as LPITEMIDLIST ptr) as HRESULT
declare sub IPersistIDList_GetIDList_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IEnumIDList_INTERFACE_DEFINED__
extern IID_IEnumIDList as const GUID
type IEnumIDList as IEnumIDList_

type IEnumIDListVtbl
	QueryInterface as function(byval This as IEnumIDList ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IEnumIDList ptr) as ULONG
	Release as function(byval This as IEnumIDList ptr) as ULONG
	Next as function(byval This as IEnumIDList ptr, byval celt as ULONG, byval rgelt as LPITEMIDLIST ptr, byval pceltFetched as ULONG ptr) as HRESULT
	Skip as function(byval This as IEnumIDList ptr, byval celt as ULONG) as HRESULT
	Reset as function(byval This as IEnumIDList ptr) as HRESULT
	Clone as function(byval This as IEnumIDList ptr, byval ppenum as IEnumIDList ptr ptr) as HRESULT
end type

type IEnumIDList_
	lpVtbl as IEnumIDListVtbl ptr
end type

#define IEnumIDList_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IEnumIDList_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IEnumIDList_Release(This) (This)->lpVtbl->Release(This)
#define IEnumIDList_Next(This, celt, rgelt, pceltFetched) (This)->lpVtbl->Next(This, celt, rgelt, pceltFetched)
#define IEnumIDList_Skip(This, celt) (This)->lpVtbl->Skip(This, celt)
#define IEnumIDList_Reset(This) (This)->lpVtbl->Reset(This)
#define IEnumIDList_Clone(This, ppenum) (This)->lpVtbl->Clone(This, ppenum)

declare function IEnumIDList_RemoteNext_Proxy(byval This as IEnumIDList ptr, byval celt as ULONG, byval rgelt as LPITEMIDLIST ptr, byval pceltFetched as ULONG ptr) as HRESULT
declare sub IEnumIDList_RemoteNext_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumIDList_Skip_Proxy(byval This as IEnumIDList ptr, byval celt as ULONG) as HRESULT
declare sub IEnumIDList_Skip_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumIDList_Reset_Proxy(byval This as IEnumIDList ptr) as HRESULT
declare sub IEnumIDList_Reset_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumIDList_Clone_Proxy(byval This as IEnumIDList ptr, byval ppenum as IEnumIDList ptr ptr) as HRESULT
declare sub IEnumIDList_Clone_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumIDList_Next_Proxy(byval This as IEnumIDList ptr, byval celt as ULONG, byval rgelt as LPITEMIDLIST ptr, byval pceltFetched as ULONG ptr) as HRESULT
declare function IEnumIDList_Next_Stub(byval This as IEnumIDList ptr, byval celt as ULONG, byval rgelt as LPITEMIDLIST ptr, byval pceltFetched as ULONG ptr) as HRESULT
type LPENUMIDLIST as IEnumIDList ptr
#define __IEnumFullIDList_INTERFACE_DEFINED__
extern IID_IEnumFullIDList as const GUID
type IEnumFullIDList as IEnumFullIDList_

type IEnumFullIDListVtbl
	QueryInterface as function(byval This as IEnumFullIDList ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IEnumFullIDList ptr) as ULONG
	Release as function(byval This as IEnumFullIDList ptr) as ULONG
	Next as function(byval This as IEnumFullIDList ptr, byval celt as ULONG, byval rgelt as LPITEMIDLIST ptr, byval pceltFetched as ULONG ptr) as HRESULT
	Skip as function(byval This as IEnumFullIDList ptr, byval celt as ULONG) as HRESULT
	Reset as function(byval This as IEnumFullIDList ptr) as HRESULT
	Clone as function(byval This as IEnumFullIDList ptr, byval ppenum as IEnumFullIDList ptr ptr) as HRESULT
end type

type IEnumFullIDList_
	lpVtbl as IEnumFullIDListVtbl ptr
end type

#define IEnumFullIDList_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IEnumFullIDList_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IEnumFullIDList_Release(This) (This)->lpVtbl->Release(This)
#define IEnumFullIDList_Next(This, celt, rgelt, pceltFetched) (This)->lpVtbl->Next(This, celt, rgelt, pceltFetched)
#define IEnumFullIDList_Skip(This, celt) (This)->lpVtbl->Skip(This, celt)
#define IEnumFullIDList_Reset(This) (This)->lpVtbl->Reset(This)
#define IEnumFullIDList_Clone(This, ppenum) (This)->lpVtbl->Clone(This, ppenum)

declare function IEnumFullIDList_RemoteNext_Proxy(byval This as IEnumFullIDList ptr, byval celt as ULONG, byval rgelt as LPITEMIDLIST ptr, byval pceltFetched as ULONG ptr) as HRESULT
declare sub IEnumFullIDList_RemoteNext_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumFullIDList_Skip_Proxy(byval This as IEnumFullIDList ptr, byval celt as ULONG) as HRESULT
declare sub IEnumFullIDList_Skip_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumFullIDList_Reset_Proxy(byval This as IEnumFullIDList ptr) as HRESULT
declare sub IEnumFullIDList_Reset_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumFullIDList_Clone_Proxy(byval This as IEnumFullIDList ptr, byval ppenum as IEnumFullIDList ptr ptr) as HRESULT
declare sub IEnumFullIDList_Clone_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumFullIDList_Next_Proxy(byval This as IEnumFullIDList ptr, byval celt as ULONG, byval rgelt as LPITEMIDLIST ptr, byval pceltFetched as ULONG ptr) as HRESULT
declare function IEnumFullIDList_Next_Stub(byval This as IEnumFullIDList ptr, byval celt as ULONG, byval rgelt as LPITEMIDLIST ptr, byval pceltFetched as ULONG ptr) as HRESULT

type _SHGDNF as long
enum
	SHGDN_NORMAL = &h0
	SHGDN_INFOLDER = &h1
	SHGDN_FOREDITING = &h1000
	SHGDN_FORADDRESSBAR = &h4000
	SHGDN_FORPARSING = &h8000
end enum

type SHGDNF as DWORD

type _SHCONTF as long
enum
	SHCONTF_CHECKING_FOR_CHILDREN = &h10
	SHCONTF_FOLDERS = &h20
	SHCONTF_NONFOLDERS = &h40
	SHCONTF_INCLUDEHIDDEN = &h80
	SHCONTF_INIT_ON_FIRST_NEXT = &h100
	SHCONTF_NETPRINTERSRCH = &h200
	SHCONTF_SHAREABLE = &h400
	SHCONTF_STORAGE = &h800
	SHCONTF_NAVIGATION_ENUM = &h1000
	SHCONTF_FASTITEMS = &h2000
	SHCONTF_FLATLIST = &h4000
	SHCONTF_ENABLE_ASYNC = &h8000
	SHCONTF_INCLUDESUPERHIDDEN = &h10000
end enum

type SHCONTF as DWORD
const SHCIDS_ALLFIELDS = &h80000000
const SHCIDS_CANONICALONLY = &h10000000
const SHCIDS_BITMASK = &hffff0000
const SHCIDS_COLUMNMASK = &h0000ffff
const SFGAO_CANCOPY = DROPEFFECT_COPY
const SFGAO_CANMOVE = DROPEFFECT_MOVE
const SFGAO_CANLINK = DROPEFFECT_LINK
const SFGAO_STORAGE = &h8
const SFGAO_CANRENAME = &h10
const SFGAO_CANDELETE = &h20
const SFGAO_HASPROPSHEET = &h40
const SFGAO_DROPTARGET = &h100
const SFGAO_CAPABILITYMASK = &h177
const SFGAO_SYSTEM = &h1000
const SFGAO_ENCRYPTED = &h2000
const SFGAO_ISSLOW = &h4000
const SFGAO_GHOSTED = &h8000
const SFGAO_LINK = &h10000
const SFGAO_SHARE = &h20000
const SFGAO_READONLY = &h40000
const SFGAO_HIDDEN = &h80000
const SFGAO_DISPLAYATTRMASK = &hfc000
const SFGAO_FILESYSANCESTOR = &h10000000
const SFGAO_FOLDER = &h20000000
const SFGAO_FILESYSTEM = &h40000000
const SFGAO_HASSUBFOLDER = &h80000000
const SFGAO_CONTENTSMASK = &h80000000
const SFGAO_VALIDATE = &h1000000
const SFGAO_REMOVABLE = &h2000000
const SFGAO_COMPRESSED = &h4000000
const SFGAO_BROWSABLE = &h8000000
const SFGAO_NONENUMERATED = &h100000
const SFGAO_NEWCONTENT = &h200000
const SFGAO_CANMONIKER = &h400000
const SFGAO_HASSTORAGE = &h400000
const SFGAO_STREAM = &h400000
const SFGAO_STORAGEANCESTOR = &h00800000
const SFGAO_STORAGECAPMASK = &h70c50008
const SFGAO_PKEYSFGAOMASK = &h81044000
type SFGAOF as ULONG
#define STR_BIND_FORCE_FOLDER_SHORTCUT_RESOLVE wstr("Force Folder Shortcut Resolve")
#define STR_AVOID_DRIVE_RESTRICTION_POLICY wstr("Avoid Drive Restriction Policy")
#define STR_AVOID_DRIVE_RESTRICTION_POLICY wstr("Avoid Drive Restriction Policy")
#define STR_SKIP_BINDING_CLSID wstr("Skip Binding CLSID")
#define STR_PARSE_PREFER_FOLDER_BROWSING wstr("Parse Prefer Folder Browsing")
#define STR_DONT_PARSE_RELATIVE wstr("Don't Parse Relative")
#define STR_PARSE_TRANSLATE_ALIASES wstr("Parse Translate Aliases")
#define STR_PARSE_SKIP_NET_CACHE wstr("Skip Net Resource Cache")
#define STR_PARSE_SHELL_PROTOCOL_TO_FILE_OBJECTS wstr("Parse Shell Protocol To File Objects")

#if _WIN32_WINNT >= &h0600
	#define STR_TRACK_CLSID wstr("Track the CLSID")
	#define STR_INTERNAL_NAVIGATE wstr("Internal Navigation")
	#define STR_PARSE_PROPERTYSTORE wstr("DelegateNamedProperties")
	#define STR_NO_VALIDATE_FILENAME_CHARS wstr("NoValidateFilenameChars")
	#define STR_BIND_DELEGATE_CREATE_OBJECT wstr("Delegate Object Creation")
	#define STR_PARSE_ALLOW_INTERNET_SHELL_FOLDERS wstr("Allow binding to Internet shell folder handlers and negate STR_PARSE_PREFER_WEB_BROWSING")
	#define STR_PARSE_PREFER_WEB_BROWSING wstr("Do not bind to Internet shell folder handlers")
	#define STR_PARSE_SHOW_NET_DIAGNOSTICS_UI wstr("Show network diagnostics UI")
	#define STR_PARSE_DONT_REQUIRE_VALIDATED_URLS wstr("Do not require validated URLs")
	#define STR_INTERNETFOLDER_PARSE_ONLY_URLMON_BINDABLE wstr("Validate URL")
#endif

#if _WIN32_WINNT = &h0602
	const BIND_INTERRUPTABLE = &hffffffff
#endif

#if _WIN32_WINNT >= &h0601
	#define STR_BIND_FOLDERS_READ_ONLY wstr("Folders As Read Only")
	#define STR_BIND_FOLDER_ENUM_MODE wstr("Folder Enum Mode")

	type FOLDER_ENUM_MODE as long
	enum
		FEM_VIEWRESULT = 0
		FEM_NAVIGATION = 1
	end enum

	#define __IObjectWithFolderEnumMode_INTERFACE_DEFINED__
	extern IID_IObjectWithFolderEnumMode as const GUID
	type IObjectWithFolderEnumMode as IObjectWithFolderEnumMode_

	type IObjectWithFolderEnumModeVtbl
		QueryInterface as function(byval This as IObjectWithFolderEnumMode ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IObjectWithFolderEnumMode ptr) as ULONG
		Release as function(byval This as IObjectWithFolderEnumMode ptr) as ULONG
		SetMode as function(byval This as IObjectWithFolderEnumMode ptr, byval feMode as FOLDER_ENUM_MODE) as HRESULT
		GetMode as function(byval This as IObjectWithFolderEnumMode ptr, byval pfeMode as FOLDER_ENUM_MODE ptr) as HRESULT
	end type

	type IObjectWithFolderEnumMode_
		lpVtbl as IObjectWithFolderEnumModeVtbl ptr
	end type

	#define IObjectWithFolderEnumMode_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IObjectWithFolderEnumMode_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IObjectWithFolderEnumMode_Release(This) (This)->lpVtbl->Release(This)
	#define IObjectWithFolderEnumMode_SetMode(This, feMode) (This)->lpVtbl->SetMode(This, feMode)
	#define IObjectWithFolderEnumMode_GetMode(This, pfeMode) (This)->lpVtbl->GetMode(This, pfeMode)

	declare function IObjectWithFolderEnumMode_SetMode_Proxy(byval This as IObjectWithFolderEnumMode ptr, byval feMode as FOLDER_ENUM_MODE) as HRESULT
	declare sub IObjectWithFolderEnumMode_SetMode_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IObjectWithFolderEnumMode_GetMode_Proxy(byval This as IObjectWithFolderEnumMode ptr, byval pfeMode as FOLDER_ENUM_MODE ptr) as HRESULT
	declare sub IObjectWithFolderEnumMode_GetMode_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

	#define STR_PARSE_WITH_EXPLICIT_PROGID wstr("ExplicitProgid")
	#define STR_PARSE_WITH_EXPLICIT_ASSOCAPP wstr("ExplicitAssociationApp")
	#define STR_PARSE_EXPLICIT_ASSOCIATION_SUCCESSFUL wstr("ExplicitAssociationSuccessful")
	#define STR_PARSE_AND_CREATE_ITEM wstr("ParseAndCreateItem")
	#define STR_PROPERTYBAG_PARAM wstr("SHBindCtxPropertyBag")
	#define STR_ENUM_ITEMS_FLAGS wstr("SHCONTF")
	#define __IParseAndCreateItem_INTERFACE_DEFINED__
	extern IID_IParseAndCreateItem as const GUID
	type IParseAndCreateItem as IParseAndCreateItem_
	type IShellItem as IShellItem_

	type IParseAndCreateItemVtbl
		QueryInterface as function(byval This as IParseAndCreateItem ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IParseAndCreateItem ptr) as ULONG
		Release as function(byval This as IParseAndCreateItem ptr) as ULONG
		SetItem as function(byval This as IParseAndCreateItem ptr, byval psi as IShellItem ptr) as HRESULT
		GetItem as function(byval This as IParseAndCreateItem ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	end type

	type IParseAndCreateItem_
		lpVtbl as IParseAndCreateItemVtbl ptr
	end type

	#define IParseAndCreateItem_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IParseAndCreateItem_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IParseAndCreateItem_Release(This) (This)->lpVtbl->Release(This)
	#define IParseAndCreateItem_SetItem(This, psi) (This)->lpVtbl->SetItem(This, psi)
	#define IParseAndCreateItem_GetItem(This, riid, ppv) (This)->lpVtbl->GetItem(This, riid, ppv)

	declare function IParseAndCreateItem_SetItem_Proxy(byval This as IParseAndCreateItem ptr, byval psi as IShellItem ptr) as HRESULT
	declare sub IParseAndCreateItem_SetItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IParseAndCreateItem_GetItem_Proxy(byval This as IParseAndCreateItem ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	declare sub IParseAndCreateItem_GetItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	#define STR_ITEM_CACHE_CONTEXT wstr("ItemCacheContext")
#endif

#define __IShellFolder_INTERFACE_DEFINED__
extern IID_IShellFolder as const GUID
type IShellFolder as IShellFolder_

type IShellFolderVtbl
	QueryInterface as function(byval This as IShellFolder ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IShellFolder ptr) as ULONG
	Release as function(byval This as IShellFolder ptr) as ULONG
	ParseDisplayName as function(byval This as IShellFolder ptr, byval hwnd as HWND, byval pbc as IBindCtx ptr, byval pszDisplayName as LPWSTR, byval pchEaten as ULONG ptr, byval ppidl as LPITEMIDLIST ptr, byval pdwAttributes as ULONG ptr) as HRESULT
	EnumObjects as function(byval This as IShellFolder ptr, byval hwnd as HWND, byval grfFlags as SHCONTF, byval ppenumIDList as IEnumIDList ptr ptr) as HRESULT
	BindToObject as function(byval This as IShellFolder ptr, byval pidl as LPCITEMIDLIST, byval pbc as IBindCtx ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	BindToStorage as function(byval This as IShellFolder ptr, byval pidl as LPCITEMIDLIST, byval pbc as IBindCtx ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	CompareIDs as function(byval This as IShellFolder ptr, byval lParam as LPARAM, byval pidl1 as LPCITEMIDLIST, byval pidl2 as LPCITEMIDLIST) as HRESULT
	CreateViewObject as function(byval This as IShellFolder ptr, byval hwndOwner as HWND, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	GetAttributesOf as function(byval This as IShellFolder ptr, byval cidl as UINT, byval apidl as LPCITEMIDLIST ptr, byval rgfInOut as SFGAOF ptr) as HRESULT
	GetUIObjectOf as function(byval This as IShellFolder ptr, byval hwndOwner as HWND, byval cidl as UINT, byval apidl as LPCITEMIDLIST ptr, byval riid as const IID const ptr, byval rgfReserved as UINT ptr, byval ppv as any ptr ptr) as HRESULT
	GetDisplayNameOf as function(byval This as IShellFolder ptr, byval pidl as LPCITEMIDLIST, byval uFlags as SHGDNF, byval pName as STRRET ptr) as HRESULT
	SetNameOf as function(byval This as IShellFolder ptr, byval hwnd as HWND, byval pidl as LPCITEMIDLIST, byval pszName as LPCWSTR, byval uFlags as SHGDNF, byval ppidlOut as LPITEMIDLIST ptr) as HRESULT
end type

type IShellFolder_
	lpVtbl as IShellFolderVtbl ptr
end type

#define IShellFolder_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IShellFolder_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IShellFolder_Release(This) (This)->lpVtbl->Release(This)
#define IShellFolder_ParseDisplayName(This, hwnd, pbc, pszDisplayName, pchEaten, ppidl, pdwAttributes) (This)->lpVtbl->ParseDisplayName(This, hwnd, pbc, pszDisplayName, pchEaten, ppidl, pdwAttributes)
#define IShellFolder_EnumObjects(This, hwnd, grfFlags, ppenumIDList) (This)->lpVtbl->EnumObjects(This, hwnd, grfFlags, ppenumIDList)
#define IShellFolder_BindToObject(This, pidl, pbc, riid, ppv) (This)->lpVtbl->BindToObject(This, pidl, pbc, riid, ppv)
#define IShellFolder_BindToStorage(This, pidl, pbc, riid, ppv) (This)->lpVtbl->BindToStorage(This, pidl, pbc, riid, ppv)
#define IShellFolder_CompareIDs(This, lParam, pidl1, pidl2) (This)->lpVtbl->CompareIDs(This, lParam, pidl1, pidl2)
#define IShellFolder_CreateViewObject(This, hwndOwner, riid, ppv) (This)->lpVtbl->CreateViewObject(This, hwndOwner, riid, ppv)
#define IShellFolder_GetAttributesOf(This, cidl, apidl, rgfInOut) (This)->lpVtbl->GetAttributesOf(This, cidl, apidl, rgfInOut)
#define IShellFolder_GetUIObjectOf(This, hwndOwner, cidl, apidl, riid, rgfReserved, ppv) (This)->lpVtbl->GetUIObjectOf(This, hwndOwner, cidl, apidl, riid, rgfReserved, ppv)
#define IShellFolder_GetDisplayNameOf(This, pidl, uFlags, pName) (This)->lpVtbl->GetDisplayNameOf(This, pidl, uFlags, pName)
#define IShellFolder_SetNameOf(This, hwnd, pidl, pszName, uFlags, ppidlOut) (This)->lpVtbl->SetNameOf(This, hwnd, pidl, pszName, uFlags, ppidlOut)

declare function IShellFolder_ParseDisplayName_Proxy(byval This as IShellFolder ptr, byval hwnd as HWND, byval pbc as IBindCtx ptr, byval pszDisplayName as LPWSTR, byval pchEaten as ULONG ptr, byval ppidl as LPITEMIDLIST ptr, byval pdwAttributes as ULONG ptr) as HRESULT
declare sub IShellFolder_ParseDisplayName_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellFolder_EnumObjects_Proxy(byval This as IShellFolder ptr, byval hwnd as HWND, byval grfFlags as SHCONTF, byval ppenumIDList as IEnumIDList ptr ptr) as HRESULT
declare sub IShellFolder_EnumObjects_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellFolder_BindToObject_Proxy(byval This as IShellFolder ptr, byval pidl as LPCITEMIDLIST, byval pbc as IBindCtx ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare sub IShellFolder_BindToObject_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellFolder_BindToStorage_Proxy(byval This as IShellFolder ptr, byval pidl as LPCITEMIDLIST, byval pbc as IBindCtx ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare sub IShellFolder_BindToStorage_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellFolder_CompareIDs_Proxy(byval This as IShellFolder ptr, byval lParam as LPARAM, byval pidl1 as LPCITEMIDLIST, byval pidl2 as LPCITEMIDLIST) as HRESULT
declare sub IShellFolder_CompareIDs_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellFolder_CreateViewObject_Proxy(byval This as IShellFolder ptr, byval hwndOwner as HWND, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare sub IShellFolder_CreateViewObject_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellFolder_GetAttributesOf_Proxy(byval This as IShellFolder ptr, byval cidl as UINT, byval apidl as LPCITEMIDLIST ptr, byval rgfInOut as SFGAOF ptr) as HRESULT
declare sub IShellFolder_GetAttributesOf_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellFolder_GetUIObjectOf_Proxy(byval This as IShellFolder ptr, byval hwndOwner as HWND, byval cidl as UINT, byval apidl as LPCITEMIDLIST ptr, byval riid as const IID const ptr, byval rgfReserved as UINT ptr, byval ppv as any ptr ptr) as HRESULT
declare sub IShellFolder_GetUIObjectOf_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellFolder_GetDisplayNameOf_Proxy(byval This as IShellFolder ptr, byval pidl as LPCITEMIDLIST, byval uFlags as SHGDNF, byval pName as STRRET ptr) as HRESULT
declare sub IShellFolder_GetDisplayNameOf_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellFolder_RemoteSetNameOf_Proxy(byval This as IShellFolder ptr, byval hwnd as HWND, byval pidl as LPCITEMIDLIST, byval pszName as LPCWSTR, byval uFlags as SHGDNF, byval ppidlOut as LPITEMIDLIST ptr) as HRESULT
declare sub IShellFolder_RemoteSetNameOf_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellFolder_SetNameOf_Proxy(byval This as IShellFolder ptr, byval hwnd as HWND, byval pidl as LPCITEMIDLIST, byval pszName as LPCWSTR, byval uFlags as SHGDNF, byval ppidlOut as LPITEMIDLIST ptr) as HRESULT
declare function IShellFolder_SetNameOf_Stub(byval This as IShellFolder ptr, byval hwnd as HWND, byval pidl as LPCITEMIDLIST, byval pszName as LPCWSTR, byval uFlags as SHGDNF, byval ppidlOut as LPITEMIDLIST ptr) as HRESULT
type LPSHELLFOLDER as IShellFolder ptr

type EXTRASEARCH
	guidSearch as GUID
	wszFriendlyName as wstring * 80
	wszUrl as wstring * 2084
end type

type LPEXTRASEARCH as EXTRASEARCH ptr
#define __IEnumExtraSearch_INTERFACE_DEFINED__
extern IID_IEnumExtraSearch as const GUID
type IEnumExtraSearch as IEnumExtraSearch_

type IEnumExtraSearchVtbl
	QueryInterface as function(byval This as IEnumExtraSearch ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IEnumExtraSearch ptr) as ULONG
	Release as function(byval This as IEnumExtraSearch ptr) as ULONG
	Next as function(byval This as IEnumExtraSearch ptr, byval celt as ULONG, byval rgelt as EXTRASEARCH ptr, byval pceltFetched as ULONG ptr) as HRESULT
	Skip as function(byval This as IEnumExtraSearch ptr, byval celt as ULONG) as HRESULT
	Reset as function(byval This as IEnumExtraSearch ptr) as HRESULT
	Clone as function(byval This as IEnumExtraSearch ptr, byval ppenum as IEnumExtraSearch ptr ptr) as HRESULT
end type

type IEnumExtraSearch_
	lpVtbl as IEnumExtraSearchVtbl ptr
end type

#define IEnumExtraSearch_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IEnumExtraSearch_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IEnumExtraSearch_Release(This) (This)->lpVtbl->Release(This)
#define IEnumExtraSearch_Next(This, celt, rgelt, pceltFetched) (This)->lpVtbl->Next(This, celt, rgelt, pceltFetched)
#define IEnumExtraSearch_Skip(This, celt) (This)->lpVtbl->Skip(This, celt)
#define IEnumExtraSearch_Reset(This) (This)->lpVtbl->Reset(This)
#define IEnumExtraSearch_Clone(This, ppenum) (This)->lpVtbl->Clone(This, ppenum)

declare function IEnumExtraSearch_Next_Proxy(byval This as IEnumExtraSearch ptr, byval celt as ULONG, byval rgelt as EXTRASEARCH ptr, byval pceltFetched as ULONG ptr) as HRESULT
declare sub IEnumExtraSearch_Next_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumExtraSearch_Skip_Proxy(byval This as IEnumExtraSearch ptr, byval celt as ULONG) as HRESULT
declare sub IEnumExtraSearch_Skip_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumExtraSearch_Reset_Proxy(byval This as IEnumExtraSearch ptr) as HRESULT
declare sub IEnumExtraSearch_Reset_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumExtraSearch_Clone_Proxy(byval This as IEnumExtraSearch ptr, byval ppenum as IEnumExtraSearch ptr ptr) as HRESULT
declare sub IEnumExtraSearch_Clone_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
type LPENUMEXTRASEARCH as IEnumExtraSearch ptr
#define __IShellFolder2_INTERFACE_DEFINED__
extern IID_IShellFolder2 as const GUID
type IShellFolder2 as IShellFolder2_

type IShellFolder2Vtbl
	QueryInterface as function(byval This as IShellFolder2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IShellFolder2 ptr) as ULONG
	Release as function(byval This as IShellFolder2 ptr) as ULONG
	ParseDisplayName as function(byval This as IShellFolder2 ptr, byval hwnd as HWND, byval pbc as IBindCtx ptr, byval pszDisplayName as LPWSTR, byval pchEaten as ULONG ptr, byval ppidl as LPITEMIDLIST ptr, byval pdwAttributes as ULONG ptr) as HRESULT
	EnumObjects as function(byval This as IShellFolder2 ptr, byval hwnd as HWND, byval grfFlags as SHCONTF, byval ppenumIDList as IEnumIDList ptr ptr) as HRESULT
	BindToObject as function(byval This as IShellFolder2 ptr, byval pidl as LPCITEMIDLIST, byval pbc as IBindCtx ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	BindToStorage as function(byval This as IShellFolder2 ptr, byval pidl as LPCITEMIDLIST, byval pbc as IBindCtx ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	CompareIDs as function(byval This as IShellFolder2 ptr, byval lParam as LPARAM, byval pidl1 as LPCITEMIDLIST, byval pidl2 as LPCITEMIDLIST) as HRESULT
	CreateViewObject as function(byval This as IShellFolder2 ptr, byval hwndOwner as HWND, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	GetAttributesOf as function(byval This as IShellFolder2 ptr, byval cidl as UINT, byval apidl as LPCITEMIDLIST ptr, byval rgfInOut as SFGAOF ptr) as HRESULT
	GetUIObjectOf as function(byval This as IShellFolder2 ptr, byval hwndOwner as HWND, byval cidl as UINT, byval apidl as LPCITEMIDLIST ptr, byval riid as const IID const ptr, byval rgfReserved as UINT ptr, byval ppv as any ptr ptr) as HRESULT
	GetDisplayNameOf as function(byval This as IShellFolder2 ptr, byval pidl as LPCITEMIDLIST, byval uFlags as SHGDNF, byval pName as STRRET ptr) as HRESULT
	SetNameOf as function(byval This as IShellFolder2 ptr, byval hwnd as HWND, byval pidl as LPCITEMIDLIST, byval pszName as LPCWSTR, byval uFlags as SHGDNF, byval ppidlOut as LPITEMIDLIST ptr) as HRESULT
	GetDefaultSearchGUID as function(byval This as IShellFolder2 ptr, byval pguid as GUID ptr) as HRESULT
	EnumSearches as function(byval This as IShellFolder2 ptr, byval ppenum as IEnumExtraSearch ptr ptr) as HRESULT
	GetDefaultColumn as function(byval This as IShellFolder2 ptr, byval dwRes as DWORD, byval pSort as ULONG ptr, byval pDisplay as ULONG ptr) as HRESULT
	GetDefaultColumnState as function(byval This as IShellFolder2 ptr, byval iColumn as UINT, byval pcsFlags as SHCOLSTATEF ptr) as HRESULT
	GetDetailsEx as function(byval This as IShellFolder2 ptr, byval pidl as LPCITEMIDLIST, byval pscid as const SHCOLUMNID ptr, byval pv as VARIANT ptr) as HRESULT
	GetDetailsOf as function(byval This as IShellFolder2 ptr, byval pidl as LPCITEMIDLIST, byval iColumn as UINT, byval psd as SHELLDETAILS ptr) as HRESULT
	MapColumnToSCID as function(byval This as IShellFolder2 ptr, byval iColumn as UINT, byval pscid as SHCOLUMNID ptr) as HRESULT
end type

type IShellFolder2_
	lpVtbl as IShellFolder2Vtbl ptr
end type

#define IShellFolder2_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IShellFolder2_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IShellFolder2_Release(This) (This)->lpVtbl->Release(This)
#define IShellFolder2_ParseDisplayName(This, hwnd, pbc, pszDisplayName, pchEaten, ppidl, pdwAttributes) (This)->lpVtbl->ParseDisplayName(This, hwnd, pbc, pszDisplayName, pchEaten, ppidl, pdwAttributes)
#define IShellFolder2_EnumObjects(This, hwnd, grfFlags, ppenumIDList) (This)->lpVtbl->EnumObjects(This, hwnd, grfFlags, ppenumIDList)
#define IShellFolder2_BindToObject(This, pidl, pbc, riid, ppv) (This)->lpVtbl->BindToObject(This, pidl, pbc, riid, ppv)
#define IShellFolder2_BindToStorage(This, pidl, pbc, riid, ppv) (This)->lpVtbl->BindToStorage(This, pidl, pbc, riid, ppv)
#define IShellFolder2_CompareIDs(This, lParam, pidl1, pidl2) (This)->lpVtbl->CompareIDs(This, lParam, pidl1, pidl2)
#define IShellFolder2_CreateViewObject(This, hwndOwner, riid, ppv) (This)->lpVtbl->CreateViewObject(This, hwndOwner, riid, ppv)
#define IShellFolder2_GetAttributesOf(This, cidl, apidl, rgfInOut) (This)->lpVtbl->GetAttributesOf(This, cidl, apidl, rgfInOut)
#define IShellFolder2_GetUIObjectOf(This, hwndOwner, cidl, apidl, riid, rgfReserved, ppv) (This)->lpVtbl->GetUIObjectOf(This, hwndOwner, cidl, apidl, riid, rgfReserved, ppv)
#define IShellFolder2_GetDisplayNameOf(This, pidl, uFlags, pName) (This)->lpVtbl->GetDisplayNameOf(This, pidl, uFlags, pName)
#define IShellFolder2_SetNameOf(This, hwnd, pidl, pszName, uFlags, ppidlOut) (This)->lpVtbl->SetNameOf(This, hwnd, pidl, pszName, uFlags, ppidlOut)
#define IShellFolder2_GetDefaultSearchGUID(This, pguid) (This)->lpVtbl->GetDefaultSearchGUID(This, pguid)
#define IShellFolder2_EnumSearches(This, ppenum) (This)->lpVtbl->EnumSearches(This, ppenum)
#define IShellFolder2_GetDefaultColumn(This, dwRes, pSort, pDisplay) (This)->lpVtbl->GetDefaultColumn(This, dwRes, pSort, pDisplay)
#define IShellFolder2_GetDefaultColumnState(This, iColumn, pcsFlags) (This)->lpVtbl->GetDefaultColumnState(This, iColumn, pcsFlags)
#define IShellFolder2_GetDetailsEx(This, pidl, pscid, pv) (This)->lpVtbl->GetDetailsEx(This, pidl, pscid, pv)
#define IShellFolder2_GetDetailsOf(This, pidl, iColumn, psd) (This)->lpVtbl->GetDetailsOf(This, pidl, iColumn, psd)
#define IShellFolder2_MapColumnToSCID(This, iColumn, pscid) (This)->lpVtbl->MapColumnToSCID(This, iColumn, pscid)

declare function IShellFolder2_GetDefaultSearchGUID_Proxy(byval This as IShellFolder2 ptr, byval pguid as GUID ptr) as HRESULT
declare sub IShellFolder2_GetDefaultSearchGUID_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellFolder2_EnumSearches_Proxy(byval This as IShellFolder2 ptr, byval ppenum as IEnumExtraSearch ptr ptr) as HRESULT
declare sub IShellFolder2_EnumSearches_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellFolder2_GetDefaultColumn_Proxy(byval This as IShellFolder2 ptr, byval dwRes as DWORD, byval pSort as ULONG ptr, byval pDisplay as ULONG ptr) as HRESULT
declare sub IShellFolder2_GetDefaultColumn_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellFolder2_GetDefaultColumnState_Proxy(byval This as IShellFolder2 ptr, byval iColumn as UINT, byval pcsFlags as SHCOLSTATEF ptr) as HRESULT
declare sub IShellFolder2_GetDefaultColumnState_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellFolder2_GetDetailsEx_Proxy(byval This as IShellFolder2 ptr, byval pidl as LPCITEMIDLIST, byval pscid as const SHCOLUMNID ptr, byval pv as VARIANT ptr) as HRESULT
declare sub IShellFolder2_GetDetailsEx_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellFolder2_GetDetailsOf_Proxy(byval This as IShellFolder2 ptr, byval pidl as LPCITEMIDLIST, byval iColumn as UINT, byval psd as SHELLDETAILS ptr) as HRESULT
declare sub IShellFolder2_GetDetailsOf_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellFolder2_MapColumnToSCID_Proxy(byval This as IShellFolder2 ptr, byval iColumn as UINT, byval pscid as SHCOLUMNID ptr) as HRESULT
declare sub IShellFolder2_MapColumnToSCID_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
type LPVIEWSETTINGS as zstring ptr

type FOLDERFLAGS as long
enum
	FWF_NONE = &h0
	FWF_AUTOARRANGE = &h1
	FWF_ABBREVIATEDNAMES = &h2
	FWF_SNAPTOGRID = &h4
	FWF_OWNERDATA = &h8
	FWF_BESTFITWINDOW = &h10
	FWF_DESKTOP = &h20
	FWF_SINGLESEL = &h40
	FWF_NOSUBFOLDERS = &h80
	FWF_TRANSPARENT = &h100
	FWF_NOCLIENTEDGE = &h200
	FWF_NOSCROLL = &h400
	FWF_ALIGNLEFT = &h800
	FWF_NOICONS = &h1000
	FWF_SHOWSELALWAYS = &h2000
	FWF_NOVISIBLE = &h4000
	FWF_SINGLECLICKACTIVATE = &h8000
	FWF_NOWEBVIEW = &h10000
	FWF_HIDEFILENAMES = &h20000
	FWF_CHECKSELECT = &h40000
	FWF_NOENUMREFRESH = &h80000
	FWF_NOGROUPING = &h100000
	FWF_FULLROWSELECT = &h200000
	FWF_NOFILTERS = &h400000
	FWF_NOCOLUMNHEADER = &h800000
	FWF_NOHEADERINALLVIEWS = &h1000000
	FWF_EXTENDEDTILES = &h2000000
	FWF_TRICHECKSELECT = &h4000000
	FWF_AUTOCHECKSELECT = &h8000000
	FWF_NOBROWSERVIEWSTATE = &h10000000
	FWF_SUBSETGROUPS = &h20000000
	FWF_USESEARCHFOLDER = &h40000000
	FWF_ALLOWRTLREADING = &h80000000
end enum

type FOLDERVIEWMODE as long
enum
	FVM_AUTO = -1
	FVM_FIRST = 1
	FVM_ICON = 1
	FVM_SMALLICON = 2
	FVM_LIST = 3
	FVM_DETAILS = 4
	FVM_THUMBNAIL = 5
	FVM_TILE = 6
	FVM_THUMBSTRIP = 7
	FVM_CONTENT = 8
	FVM_LAST = 8
end enum

#if _WIN32_WINNT >= &h0600
	type FOLDERLOGICALVIEWMODE as long
	enum
		FLVM_UNSPECIFIED = -1
		FLVM_FIRST = 1
		FLVM_DETAILS = 1
		FLVM_TILES = 2
		FLVM_ICONS = 3
		FLVM_LIST = 4
		FLVM_CONTENT = 5
		FLVM_LAST = 5
	end enum
#endif

type FOLDERSETTINGS
	ViewMode as UINT
	fFlags as UINT
end type

type LPFOLDERSETTINGS as FOLDERSETTINGS ptr
type LPCFOLDERSETTINGS as const FOLDERSETTINGS ptr
type PFOLDERSETTINGS as FOLDERSETTINGS ptr
#define __IFolderViewOptions_INTERFACE_DEFINED__

type FOLDERVIEWOPTIONS as long
enum
	FVO_DEFAULT = &h0
	FVO_VISTALAYOUT = &h1
	FVO_CUSTOMPOSITION = &h2
	FVO_CUSTOMORDERING = &h4
	FVO_SUPPORTHYPERLINKS = &h8
	FVO_NOANIMATIONS = &h10
	FVO_NOSCROLLTIPS = &h20
end enum

extern IID_IFolderViewOptions as const GUID
type IFolderViewOptions as IFolderViewOptions_

type IFolderViewOptionsVtbl
	QueryInterface as function(byval This as IFolderViewOptions ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IFolderViewOptions ptr) as ULONG
	Release as function(byval This as IFolderViewOptions ptr) as ULONG
	SetFolderViewOptions as function(byval This as IFolderViewOptions ptr, byval fvoMask as FOLDERVIEWOPTIONS, byval fvoFlags as FOLDERVIEWOPTIONS) as HRESULT
	GetFolderViewOptions as function(byval This as IFolderViewOptions ptr, byval pfvoFlags as FOLDERVIEWOPTIONS ptr) as HRESULT
end type

type IFolderViewOptions_
	lpVtbl as IFolderViewOptionsVtbl ptr
end type

#define IFolderViewOptions_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IFolderViewOptions_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IFolderViewOptions_Release(This) (This)->lpVtbl->Release(This)
#define IFolderViewOptions_SetFolderViewOptions(This, fvoMask, fvoFlags) (This)->lpVtbl->SetFolderViewOptions(This, fvoMask, fvoFlags)
#define IFolderViewOptions_GetFolderViewOptions(This, pfvoFlags) (This)->lpVtbl->GetFolderViewOptions(This, pfvoFlags)

declare function IFolderViewOptions_SetFolderViewOptions_Proxy(byval This as IFolderViewOptions ptr, byval fvoMask as FOLDERVIEWOPTIONS, byval fvoFlags as FOLDERVIEWOPTIONS) as HRESULT
declare sub IFolderViewOptions_SetFolderViewOptions_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFolderViewOptions_GetFolderViewOptions_Proxy(byval This as IFolderViewOptions ptr, byval pfvoFlags as FOLDERVIEWOPTIONS ptr) as HRESULT
declare sub IFolderViewOptions_GetFolderViewOptions_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

type _SVSIF as long
enum
	SVSI_DESELECT = &h0
	SVSI_SELECT = &h1
	SVSI_EDIT = &h3
	SVSI_DESELECTOTHERS = &h4
	SVSI_ENSUREVISIBLE = &h8
	SVSI_FOCUSED = &h10
	SVSI_TRANSLATEPT = &h20
	SVSI_SELECTIONMARK = &h40
	SVSI_POSITIONITEM = &h80
	SVSI_CHECK = &h100
	SVSI_CHECK2 = &h200
	SVSI_KEYBOARDSELECT = &h401
	SVSI_NOTAKEFOCUS = &h40000000
end enum

const SVSI_NOSTATECHANGE = cast(UINT, &h80000000)
type SVSIF as UINT

type _SVGIO as long
enum
	SVGIO_BACKGROUND = &h0
	SVGIO_SELECTION = &h1
	SVGIO_ALLVIEW = &h2
	SVGIO_CHECKED = &h3
	SVGIO_TYPE_MASK = &hf
	SVGIO_FLAG_VIEWORDER = &h80000000
end enum

type SVGIO as long

type SVUIA_STATUS as long
enum
	SVUIA_DEACTIVATE = 0
	SVUIA_ACTIVATE_NOFOCUS = 1
	SVUIA_ACTIVATE_FOCUS = 2
	SVUIA_INPLACEACTIVATE = 3
end enum

type LPFNSVADDPROPSHEETPAGE as LPFNADDPROPSHEETPAGE
#define __IShellView_INTERFACE_DEFINED__
extern IID_IShellView as const GUID
type IShellView as IShellView_
type IShellBrowser as IShellBrowser_

type IShellViewVtbl
	QueryInterface as function(byval This as IShellView ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IShellView ptr) as ULONG
	Release as function(byval This as IShellView ptr) as ULONG
	GetWindow as function(byval This as IShellView ptr, byval phwnd as HWND ptr) as HRESULT
	ContextSensitiveHelp as function(byval This as IShellView ptr, byval fEnterMode as WINBOOL) as HRESULT
	TranslateAccelerator as function(byval This as IShellView ptr, byval pmsg as MSG ptr) as HRESULT
	EnableModeless as function(byval This as IShellView ptr, byval fEnable as WINBOOL) as HRESULT
	UIActivate as function(byval This as IShellView ptr, byval uState as UINT) as HRESULT
	Refresh as function(byval This as IShellView ptr) as HRESULT
	CreateViewWindow as function(byval This as IShellView ptr, byval psvPrevious as IShellView ptr, byval pfs as LPCFOLDERSETTINGS, byval psb as IShellBrowser ptr, byval prcView as RECT ptr, byval phWnd as HWND ptr) as HRESULT
	DestroyViewWindow as function(byval This as IShellView ptr) as HRESULT
	GetCurrentInfo as function(byval This as IShellView ptr, byval pfs as LPFOLDERSETTINGS) as HRESULT
	AddPropertySheetPages as function(byval This as IShellView ptr, byval dwReserved as DWORD, byval pfn as LPFNSVADDPROPSHEETPAGE, byval lparam as LPARAM) as HRESULT
	SaveViewState as function(byval This as IShellView ptr) as HRESULT
	SelectItem as function(byval This as IShellView ptr, byval pidlItem as LPCITEMIDLIST, byval uFlags as SVSIF) as HRESULT
	GetItemObject as function(byval This as IShellView ptr, byval uItem as UINT, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
end type

type IShellView_
	lpVtbl as IShellViewVtbl ptr
end type

#define IShellView_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IShellView_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IShellView_Release(This) (This)->lpVtbl->Release(This)
#define IShellView_GetWindow(This, phwnd) (This)->lpVtbl->GetWindow(This, phwnd)
#define IShellView_ContextSensitiveHelp(This, fEnterMode) (This)->lpVtbl->ContextSensitiveHelp(This, fEnterMode)
#define IShellView_TranslateAccelerator(This, pmsg) (This)->lpVtbl->TranslateAccelerator(This, pmsg)
#define IShellView_EnableModeless(This, fEnable) (This)->lpVtbl->EnableModeless(This, fEnable)
#define IShellView_UIActivate(This, uState) (This)->lpVtbl->UIActivate(This, uState)
#define IShellView_Refresh(This) (This)->lpVtbl->Refresh(This)
#define IShellView_CreateViewWindow(This, psvPrevious, pfs, psb, prcView, phWnd) (This)->lpVtbl->CreateViewWindow(This, psvPrevious, pfs, psb, prcView, phWnd)
#define IShellView_DestroyViewWindow(This) (This)->lpVtbl->DestroyViewWindow(This)
#define IShellView_GetCurrentInfo(This, pfs) (This)->lpVtbl->GetCurrentInfo(This, pfs)
#define IShellView_AddPropertySheetPages(This, dwReserved, pfn, lparam) (This)->lpVtbl->AddPropertySheetPages(This, dwReserved, pfn, lparam)
#define IShellView_SaveViewState(This) (This)->lpVtbl->SaveViewState(This)
#define IShellView_SelectItem(This, pidlItem, uFlags) (This)->lpVtbl->SelectItem(This, pidlItem, uFlags)
#define IShellView_GetItemObject(This, uItem, riid, ppv) (This)->lpVtbl->GetItemObject(This, uItem, riid, ppv)

declare function IShellView_TranslateAccelerator_Proxy(byval This as IShellView ptr, byval pmsg as MSG ptr) as HRESULT
declare sub IShellView_TranslateAccelerator_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellView_EnableModeless_Proxy(byval This as IShellView ptr, byval fEnable as WINBOOL) as HRESULT
declare sub IShellView_EnableModeless_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellView_UIActivate_Proxy(byval This as IShellView ptr, byval uState as UINT) as HRESULT
declare sub IShellView_UIActivate_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellView_Refresh_Proxy(byval This as IShellView ptr) as HRESULT
declare sub IShellView_Refresh_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellView_CreateViewWindow_Proxy(byval This as IShellView ptr, byval psvPrevious as IShellView ptr, byval pfs as LPCFOLDERSETTINGS, byval psb as IShellBrowser ptr, byval prcView as RECT ptr, byval phWnd as HWND ptr) as HRESULT
declare sub IShellView_CreateViewWindow_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellView_DestroyViewWindow_Proxy(byval This as IShellView ptr) as HRESULT
declare sub IShellView_DestroyViewWindow_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellView_GetCurrentInfo_Proxy(byval This as IShellView ptr, byval pfs as LPFOLDERSETTINGS) as HRESULT
declare sub IShellView_GetCurrentInfo_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellView_SaveViewState_Proxy(byval This as IShellView ptr) as HRESULT
declare sub IShellView_SaveViewState_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellView_SelectItem_Proxy(byval This as IShellView ptr, byval pidlItem as LPCITEMIDLIST, byval uFlags as SVSIF) as HRESULT
declare sub IShellView_SelectItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellView_GetItemObject_Proxy(byval This as IShellView ptr, byval uItem as UINT, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare sub IShellView_GetItemObject_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
type LPSHELLVIEW as IShellView ptr
#define __IShellView2_INTERFACE_DEFINED__
type SHELLVIEWID as GUID
const SV2GV_CURRENTVIEW = cast(UINT, -1)
const SV2GV_DEFAULTVIEW = cast(UINT, -2)

type _SV2CVW2_PARAMS
	cbSize as DWORD
	psvPrev as IShellView ptr
	pfs as LPCFOLDERSETTINGS
	psbOwner as IShellBrowser ptr
	prcView as RECT ptr
	pvid as const SHELLVIEWID ptr
	hwndView as HWND
end type

type SV2CVW2_PARAMS as _SV2CVW2_PARAMS
type LPSV2CVW2_PARAMS as _SV2CVW2_PARAMS ptr
extern IID_IShellView2 as const GUID
type IShellView2 as IShellView2_

type IShellView2Vtbl
	QueryInterface as function(byval This as IShellView2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IShellView2 ptr) as ULONG
	Release as function(byval This as IShellView2 ptr) as ULONG
	GetWindow as function(byval This as IShellView2 ptr, byval phwnd as HWND ptr) as HRESULT
	ContextSensitiveHelp as function(byval This as IShellView2 ptr, byval fEnterMode as WINBOOL) as HRESULT
	TranslateAccelerator as function(byval This as IShellView2 ptr, byval pmsg as MSG ptr) as HRESULT
	EnableModeless as function(byval This as IShellView2 ptr, byval fEnable as WINBOOL) as HRESULT
	UIActivate as function(byval This as IShellView2 ptr, byval uState as UINT) as HRESULT
	Refresh as function(byval This as IShellView2 ptr) as HRESULT
	CreateViewWindow as function(byval This as IShellView2 ptr, byval psvPrevious as IShellView ptr, byval pfs as LPCFOLDERSETTINGS, byval psb as IShellBrowser ptr, byval prcView as RECT ptr, byval phWnd as HWND ptr) as HRESULT
	DestroyViewWindow as function(byval This as IShellView2 ptr) as HRESULT
	GetCurrentInfo as function(byval This as IShellView2 ptr, byval pfs as LPFOLDERSETTINGS) as HRESULT
	AddPropertySheetPages as function(byval This as IShellView2 ptr, byval dwReserved as DWORD, byval pfn as LPFNSVADDPROPSHEETPAGE, byval lparam as LPARAM) as HRESULT
	SaveViewState as function(byval This as IShellView2 ptr) as HRESULT
	SelectItem as function(byval This as IShellView2 ptr, byval pidlItem as LPCITEMIDLIST, byval uFlags as SVSIF) as HRESULT
	GetItemObject as function(byval This as IShellView2 ptr, byval uItem as UINT, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	GetView as function(byval This as IShellView2 ptr, byval pvid as SHELLVIEWID ptr, byval uView as ULONG) as HRESULT
	CreateViewWindow2 as function(byval This as IShellView2 ptr, byval lpParams as LPSV2CVW2_PARAMS) as HRESULT
	HandleRename as function(byval This as IShellView2 ptr, byval pidlNew as LPCITEMIDLIST) as HRESULT
	SelectAndPositionItem as function(byval This as IShellView2 ptr, byval pidlItem as LPCITEMIDLIST, byval uFlags as UINT, byval ppt as POINT ptr) as HRESULT
end type

type IShellView2_
	lpVtbl as IShellView2Vtbl ptr
end type

#define IShellView2_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IShellView2_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IShellView2_Release(This) (This)->lpVtbl->Release(This)
#define IShellView2_GetWindow(This, phwnd) (This)->lpVtbl->GetWindow(This, phwnd)
#define IShellView2_ContextSensitiveHelp(This, fEnterMode) (This)->lpVtbl->ContextSensitiveHelp(This, fEnterMode)
#define IShellView2_TranslateAccelerator(This, pmsg) (This)->lpVtbl->TranslateAccelerator(This, pmsg)
#define IShellView2_EnableModeless(This, fEnable) (This)->lpVtbl->EnableModeless(This, fEnable)
#define IShellView2_UIActivate(This, uState) (This)->lpVtbl->UIActivate(This, uState)
#define IShellView2_Refresh(This) (This)->lpVtbl->Refresh(This)
#define IShellView2_CreateViewWindow(This, psvPrevious, pfs, psb, prcView, phWnd) (This)->lpVtbl->CreateViewWindow(This, psvPrevious, pfs, psb, prcView, phWnd)
#define IShellView2_DestroyViewWindow(This) (This)->lpVtbl->DestroyViewWindow(This)
#define IShellView2_GetCurrentInfo(This, pfs) (This)->lpVtbl->GetCurrentInfo(This, pfs)
#define IShellView2_AddPropertySheetPages(This, dwReserved, pfn, lparam) (This)->lpVtbl->AddPropertySheetPages(This, dwReserved, pfn, lparam)
#define IShellView2_SaveViewState(This) (This)->lpVtbl->SaveViewState(This)
#define IShellView2_SelectItem(This, pidlItem, uFlags) (This)->lpVtbl->SelectItem(This, pidlItem, uFlags)
#define IShellView2_GetItemObject(This, uItem, riid, ppv) (This)->lpVtbl->GetItemObject(This, uItem, riid, ppv)
#define IShellView2_GetView(This, pvid, uView) (This)->lpVtbl->GetView(This, pvid, uView)
#define IShellView2_CreateViewWindow2(This, lpParams) (This)->lpVtbl->CreateViewWindow2(This, lpParams)
#define IShellView2_HandleRename(This, pidlNew) (This)->lpVtbl->HandleRename(This, pidlNew)
#define IShellView2_SelectAndPositionItem(This, pidlItem, uFlags, ppt) (This)->lpVtbl->SelectAndPositionItem(This, pidlItem, uFlags, ppt)

declare function IShellView2_GetView_Proxy(byval This as IShellView2 ptr, byval pvid as SHELLVIEWID ptr, byval uView as ULONG) as HRESULT
declare sub IShellView2_GetView_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellView2_CreateViewWindow2_Proxy(byval This as IShellView2 ptr, byval lpParams as LPSV2CVW2_PARAMS) as HRESULT
declare sub IShellView2_CreateViewWindow2_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellView2_HandleRename_Proxy(byval This as IShellView2 ptr, byval pidlNew as LPCITEMIDLIST) as HRESULT
declare sub IShellView2_HandleRename_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellView2_SelectAndPositionItem_Proxy(byval This as IShellView2 ptr, byval pidlItem as LPCITEMIDLIST, byval uFlags as UINT, byval ppt as POINT ptr) as HRESULT
declare sub IShellView2_SelectAndPositionItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#if _WIN32_WINNT >= &h0600
	#define __IShellView3_INTERFACE_DEFINED__

	type _SV3CVW3_FLAGS as long
	enum
		SV3CVW3_DEFAULT = &h0
		SV3CVW3_NONINTERACTIVE = &h1
		SV3CVW3_FORCEVIEWMODE = &h2
		SV3CVW3_FORCEFOLDERFLAGS = &h4
	end enum

	type SV3CVW3_FLAGS as DWORD
	extern IID_IShellView3 as const GUID
	type IShellView3 as IShellView3_

	type IShellView3Vtbl
		QueryInterface as function(byval This as IShellView3 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IShellView3 ptr) as ULONG
		Release as function(byval This as IShellView3 ptr) as ULONG
		GetWindow as function(byval This as IShellView3 ptr, byval phwnd as HWND ptr) as HRESULT
		ContextSensitiveHelp as function(byval This as IShellView3 ptr, byval fEnterMode as WINBOOL) as HRESULT
		TranslateAccelerator as function(byval This as IShellView3 ptr, byval pmsg as MSG ptr) as HRESULT
		EnableModeless as function(byval This as IShellView3 ptr, byval fEnable as WINBOOL) as HRESULT
		UIActivate as function(byval This as IShellView3 ptr, byval uState as UINT) as HRESULT
		Refresh as function(byval This as IShellView3 ptr) as HRESULT
		CreateViewWindow as function(byval This as IShellView3 ptr, byval psvPrevious as IShellView ptr, byval pfs as LPCFOLDERSETTINGS, byval psb as IShellBrowser ptr, byval prcView as RECT ptr, byval phWnd as HWND ptr) as HRESULT
		DestroyViewWindow as function(byval This as IShellView3 ptr) as HRESULT
		GetCurrentInfo as function(byval This as IShellView3 ptr, byval pfs as LPFOLDERSETTINGS) as HRESULT
		AddPropertySheetPages as function(byval This as IShellView3 ptr, byval dwReserved as DWORD, byval pfn as LPFNSVADDPROPSHEETPAGE, byval lparam as LPARAM) as HRESULT
		SaveViewState as function(byval This as IShellView3 ptr) as HRESULT
		SelectItem as function(byval This as IShellView3 ptr, byval pidlItem as LPCITEMIDLIST, byval uFlags as SVSIF) as HRESULT
		GetItemObject as function(byval This as IShellView3 ptr, byval uItem as UINT, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
		GetView as function(byval This as IShellView3 ptr, byval pvid as SHELLVIEWID ptr, byval uView as ULONG) as HRESULT
		CreateViewWindow2 as function(byval This as IShellView3 ptr, byval lpParams as LPSV2CVW2_PARAMS) as HRESULT
		HandleRename as function(byval This as IShellView3 ptr, byval pidlNew as LPCITEMIDLIST) as HRESULT
		SelectAndPositionItem as function(byval This as IShellView3 ptr, byval pidlItem as LPCITEMIDLIST, byval uFlags as UINT, byval ppt as POINT ptr) as HRESULT
		CreateViewWindow3 as function(byval This as IShellView3 ptr, byval psbOwner as IShellBrowser ptr, byval psvPrev as IShellView ptr, byval dwViewFlags as SV3CVW3_FLAGS, byval dwMask as FOLDERFLAGS, byval dwFlags as FOLDERFLAGS, byval fvMode as FOLDERVIEWMODE, byval pvid as const SHELLVIEWID ptr, byval prcView as const RECT ptr, byval phwndView as HWND ptr) as HRESULT
	end type

	type IShellView3_
		lpVtbl as IShellView3Vtbl ptr
	end type

	#define IShellView3_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IShellView3_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IShellView3_Release(This) (This)->lpVtbl->Release(This)
	#define IShellView3_GetWindow(This, phwnd) (This)->lpVtbl->GetWindow(This, phwnd)
	#define IShellView3_ContextSensitiveHelp(This, fEnterMode) (This)->lpVtbl->ContextSensitiveHelp(This, fEnterMode)
	#define IShellView3_TranslateAccelerator(This, pmsg) (This)->lpVtbl->TranslateAccelerator(This, pmsg)
	#define IShellView3_EnableModeless(This, fEnable) (This)->lpVtbl->EnableModeless(This, fEnable)
	#define IShellView3_UIActivate(This, uState) (This)->lpVtbl->UIActivate(This, uState)
	#define IShellView3_Refresh(This) (This)->lpVtbl->Refresh(This)
	#define IShellView3_CreateViewWindow(This, psvPrevious, pfs, psb, prcView, phWnd) (This)->lpVtbl->CreateViewWindow(This, psvPrevious, pfs, psb, prcView, phWnd)
	#define IShellView3_DestroyViewWindow(This) (This)->lpVtbl->DestroyViewWindow(This)
	#define IShellView3_GetCurrentInfo(This, pfs) (This)->lpVtbl->GetCurrentInfo(This, pfs)
	#define IShellView3_AddPropertySheetPages(This, dwReserved, pfn, lparam) (This)->lpVtbl->AddPropertySheetPages(This, dwReserved, pfn, lparam)
	#define IShellView3_SaveViewState(This) (This)->lpVtbl->SaveViewState(This)
	#define IShellView3_SelectItem(This, pidlItem, uFlags) (This)->lpVtbl->SelectItem(This, pidlItem, uFlags)
	#define IShellView3_GetItemObject(This, uItem, riid, ppv) (This)->lpVtbl->GetItemObject(This, uItem, riid, ppv)
	#define IShellView3_GetView(This, pvid, uView) (This)->lpVtbl->GetView(This, pvid, uView)
	#define IShellView3_CreateViewWindow2(This, lpParams) (This)->lpVtbl->CreateViewWindow2(This, lpParams)
	#define IShellView3_HandleRename(This, pidlNew) (This)->lpVtbl->HandleRename(This, pidlNew)
	#define IShellView3_SelectAndPositionItem(This, pidlItem, uFlags, ppt) (This)->lpVtbl->SelectAndPositionItem(This, pidlItem, uFlags, ppt)
	#define IShellView3_CreateViewWindow3(This, psbOwner, psvPrev, dwViewFlags, dwMask, dwFlags, fvMode, pvid, prcView, phwndView) (This)->lpVtbl->CreateViewWindow3(This, psbOwner, psvPrev, dwViewFlags, dwMask, dwFlags, fvMode, pvid, prcView, phwndView)
	declare function IShellView3_CreateViewWindow3_Proxy(byval This as IShellView3 ptr, byval psbOwner as IShellBrowser ptr, byval psvPrev as IShellView ptr, byval dwViewFlags as SV3CVW3_FLAGS, byval dwMask as FOLDERFLAGS, byval dwFlags as FOLDERFLAGS, byval fvMode as FOLDERVIEWMODE, byval pvid as const SHELLVIEWID ptr, byval prcView as const RECT ptr, byval phwndView as HWND ptr) as HRESULT
	declare sub IShellView3_CreateViewWindow3_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#endif

#define __IFolderView_INTERFACE_DEFINED__
extern IID_IFolderView as const GUID
type IFolderView as IFolderView_

type IFolderViewVtbl
	QueryInterface as function(byval This as IFolderView ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IFolderView ptr) as ULONG
	Release as function(byval This as IFolderView ptr) as ULONG
	GetCurrentViewMode as function(byval This as IFolderView ptr, byval pViewMode as UINT ptr) as HRESULT
	SetCurrentViewMode as function(byval This as IFolderView ptr, byval ViewMode as UINT) as HRESULT
	GetFolder as function(byval This as IFolderView ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	Item as function(byval This as IFolderView ptr, byval iItemIndex as long, byval ppidl as LPITEMIDLIST ptr) as HRESULT
	ItemCount as function(byval This as IFolderView ptr, byval uFlags as UINT, byval pcItems as long ptr) as HRESULT
	Items as function(byval This as IFolderView ptr, byval uFlags as UINT, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	GetSelectionMarkedItem as function(byval This as IFolderView ptr, byval piItem as long ptr) as HRESULT
	GetFocusedItem as function(byval This as IFolderView ptr, byval piItem as long ptr) as HRESULT
	GetItemPosition as function(byval This as IFolderView ptr, byval pidl as LPCITEMIDLIST, byval ppt as POINT ptr) as HRESULT
	GetSpacing as function(byval This as IFolderView ptr, byval ppt as POINT ptr) as HRESULT
	GetDefaultSpacing as function(byval This as IFolderView ptr, byval ppt as POINT ptr) as HRESULT
	GetAutoArrange as function(byval This as IFolderView ptr) as HRESULT
	SelectItem as function(byval This as IFolderView ptr, byval iItem as long, byval dwFlags as DWORD) as HRESULT
	SelectAndPositionItems as function(byval This as IFolderView ptr, byval cidl as UINT, byval apidl as LPCITEMIDLIST ptr, byval apt as POINT ptr, byval dwFlags as DWORD) as HRESULT
end type

type IFolderView_
	lpVtbl as IFolderViewVtbl ptr
end type

#define IFolderView_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IFolderView_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IFolderView_Release(This) (This)->lpVtbl->Release(This)
#define IFolderView_GetCurrentViewMode(This, pViewMode) (This)->lpVtbl->GetCurrentViewMode(This, pViewMode)
#define IFolderView_SetCurrentViewMode(This, ViewMode) (This)->lpVtbl->SetCurrentViewMode(This, ViewMode)
#define IFolderView_GetFolder(This, riid, ppv) (This)->lpVtbl->GetFolder(This, riid, ppv)
#define IFolderView_Item(This, iItemIndex, ppidl) (This)->lpVtbl->Item(This, iItemIndex, ppidl)
#define IFolderView_ItemCount(This, uFlags, pcItems) (This)->lpVtbl->ItemCount(This, uFlags, pcItems)
#define IFolderView_Items(This, uFlags, riid, ppv) (This)->lpVtbl->Items(This, uFlags, riid, ppv)
#define IFolderView_GetSelectionMarkedItem(This, piItem) (This)->lpVtbl->GetSelectionMarkedItem(This, piItem)
#define IFolderView_GetFocusedItem(This, piItem) (This)->lpVtbl->GetFocusedItem(This, piItem)
#define IFolderView_GetItemPosition(This, pidl, ppt) (This)->lpVtbl->GetItemPosition(This, pidl, ppt)
#define IFolderView_GetSpacing(This, ppt) (This)->lpVtbl->GetSpacing(This, ppt)
#define IFolderView_GetDefaultSpacing(This, ppt) (This)->lpVtbl->GetDefaultSpacing(This, ppt)
#define IFolderView_GetAutoArrange(This) (This)->lpVtbl->GetAutoArrange(This)
#define IFolderView_SelectItem(This, iItem, dwFlags) (This)->lpVtbl->SelectItem(This, iItem, dwFlags)
#define IFolderView_SelectAndPositionItems(This, cidl, apidl, apt, dwFlags) (This)->lpVtbl->SelectAndPositionItems(This, cidl, apidl, apt, dwFlags)

declare function IFolderView_GetCurrentViewMode_Proxy(byval This as IFolderView ptr, byval pViewMode as UINT ptr) as HRESULT
declare sub IFolderView_GetCurrentViewMode_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFolderView_SetCurrentViewMode_Proxy(byval This as IFolderView ptr, byval ViewMode as UINT) as HRESULT
declare sub IFolderView_SetCurrentViewMode_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFolderView_GetFolder_Proxy(byval This as IFolderView ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare sub IFolderView_GetFolder_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFolderView_Item_Proxy(byval This as IFolderView ptr, byval iItemIndex as long, byval ppidl as LPITEMIDLIST ptr) as HRESULT
declare sub IFolderView_Item_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFolderView_ItemCount_Proxy(byval This as IFolderView ptr, byval uFlags as UINT, byval pcItems as long ptr) as HRESULT
declare sub IFolderView_ItemCount_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFolderView_Items_Proxy(byval This as IFolderView ptr, byval uFlags as UINT, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare sub IFolderView_Items_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFolderView_GetSelectionMarkedItem_Proxy(byval This as IFolderView ptr, byval piItem as long ptr) as HRESULT
declare sub IFolderView_GetSelectionMarkedItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFolderView_GetFocusedItem_Proxy(byval This as IFolderView ptr, byval piItem as long ptr) as HRESULT
declare sub IFolderView_GetFocusedItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFolderView_GetItemPosition_Proxy(byval This as IFolderView ptr, byval pidl as LPCITEMIDLIST, byval ppt as POINT ptr) as HRESULT
declare sub IFolderView_GetItemPosition_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFolderView_GetSpacing_Proxy(byval This as IFolderView ptr, byval ppt as POINT ptr) as HRESULT
declare sub IFolderView_GetSpacing_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFolderView_GetDefaultSpacing_Proxy(byval This as IFolderView ptr, byval ppt as POINT ptr) as HRESULT
declare sub IFolderView_GetDefaultSpacing_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFolderView_GetAutoArrange_Proxy(byval This as IFolderView ptr) as HRESULT
declare sub IFolderView_GetAutoArrange_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFolderView_SelectItem_Proxy(byval This as IFolderView ptr, byval iItem as long, byval dwFlags as DWORD) as HRESULT
declare sub IFolderView_SelectItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFolderView_SelectAndPositionItems_Proxy(byval This as IFolderView ptr, byval cidl as UINT, byval apidl as LPCITEMIDLIST ptr, byval apt as POINT ptr, byval dwFlags as DWORD) as HRESULT
declare sub IFolderView_SelectAndPositionItems_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
extern SID_SFolderView alias "IID_IFolderView" as const GUID

#if _WIN32_WINNT >= &h0601
	#define __ISearchBoxInfo_INTERFACE_DEFINED__
	extern IID_ISearchBoxInfo as const GUID
	type ISearchBoxInfo as ISearchBoxInfo_

	type ISearchBoxInfoVtbl
		QueryInterface as function(byval This as ISearchBoxInfo ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as ISearchBoxInfo ptr) as ULONG
		Release as function(byval This as ISearchBoxInfo ptr) as ULONG
		GetCondition as function(byval This as ISearchBoxInfo ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
		GetText as function(byval This as ISearchBoxInfo ptr, byval ppsz as LPWSTR ptr) as HRESULT
	end type

	type ISearchBoxInfo_
		lpVtbl as ISearchBoxInfoVtbl ptr
	end type

	#define ISearchBoxInfo_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define ISearchBoxInfo_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define ISearchBoxInfo_Release(This) (This)->lpVtbl->Release(This)
	#define ISearchBoxInfo_GetCondition(This, riid, ppv) (This)->lpVtbl->GetCondition(This, riid, ppv)
	#define ISearchBoxInfo_GetText(This, ppsz) (This)->lpVtbl->GetText(This, ppsz)

	declare function ISearchBoxInfo_GetCondition_Proxy(byval This as ISearchBoxInfo ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	declare sub ISearchBoxInfo_GetCondition_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function ISearchBoxInfo_GetText_Proxy(byval This as ISearchBoxInfo ptr, byval ppsz as LPWSTR ptr) as HRESULT
	declare sub ISearchBoxInfo_GetText_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#endif

#if _WIN32_WINNT >= &h0600
	type tagSORTDIRECTION as long
	enum
		SORT_DESCENDING = -1
		SORT_ASCENDING = 1
	end enum

	type SORTDIRECTION as long

	type SORTCOLUMN
		propkey as PROPERTYKEY
		direction as SORTDIRECTION
	end type

	type FVTEXTTYPE as long
	enum
		FVST_EMPTYTEXT = 0
	end enum

	type DEPRECATED_HRESULT as HRESULT
	#define __IFolderView2_INTERFACE_DEFINED__
	extern IID_IFolderView2 as const GUID
	type IFolderView2 as IFolderView2_
	type IShellItemArray as IShellItemArray_

	type IFolderView2Vtbl
		QueryInterface as function(byval This as IFolderView2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IFolderView2 ptr) as ULONG
		Release as function(byval This as IFolderView2 ptr) as ULONG
		GetCurrentViewMode as function(byval This as IFolderView2 ptr, byval pViewMode as UINT ptr) as HRESULT
		SetCurrentViewMode as function(byval This as IFolderView2 ptr, byval ViewMode as UINT) as HRESULT
		GetFolder as function(byval This as IFolderView2 ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
		Item as function(byval This as IFolderView2 ptr, byval iItemIndex as long, byval ppidl as LPITEMIDLIST ptr) as HRESULT
		ItemCount as function(byval This as IFolderView2 ptr, byval uFlags as UINT, byval pcItems as long ptr) as HRESULT
		Items as function(byval This as IFolderView2 ptr, byval uFlags as UINT, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
		GetSelectionMarkedItem as function(byval This as IFolderView2 ptr, byval piItem as long ptr) as HRESULT
		GetFocusedItem as function(byval This as IFolderView2 ptr, byval piItem as long ptr) as HRESULT
		GetItemPosition as function(byval This as IFolderView2 ptr, byval pidl as LPCITEMIDLIST, byval ppt as POINT ptr) as HRESULT
		GetSpacing as function(byval This as IFolderView2 ptr, byval ppt as POINT ptr) as HRESULT
		GetDefaultSpacing as function(byval This as IFolderView2 ptr, byval ppt as POINT ptr) as HRESULT
		GetAutoArrange as function(byval This as IFolderView2 ptr) as HRESULT
		SelectItem as function(byval This as IFolderView2 ptr, byval iItem as long, byval dwFlags as DWORD) as HRESULT
		SelectAndPositionItems as function(byval This as IFolderView2 ptr, byval cidl as UINT, byval apidl as LPCITEMIDLIST ptr, byval apt as POINT ptr, byval dwFlags as DWORD) as HRESULT
		SetGroupBy as function(byval This as IFolderView2 ptr, byval key as const PROPERTYKEY const ptr, byval fAscending as WINBOOL) as HRESULT
		GetGroupBy as function(byval This as IFolderView2 ptr, byval pkey as PROPERTYKEY ptr, byval pfAscending as WINBOOL ptr) as HRESULT
		SetViewProperty as function(byval This as IFolderView2 ptr, byval pidl as LPCITEMIDLIST, byval propkey as const PROPERTYKEY const ptr, byval propvar as const PROPVARIANT const ptr) as HRESULT
		GetViewProperty as function(byval This as IFolderView2 ptr, byval pidl as LPCITEMIDLIST, byval propkey as const PROPERTYKEY const ptr, byval ppropvar as PROPVARIANT ptr) as HRESULT
		SetTileViewProperties as function(byval This as IFolderView2 ptr, byval pidl as LPCITEMIDLIST, byval pszPropList as LPCWSTR) as HRESULT
		SetExtendedTileViewProperties as function(byval This as IFolderView2 ptr, byval pidl as LPCITEMIDLIST, byval pszPropList as LPCWSTR) as HRESULT
		SetText as function(byval This as IFolderView2 ptr, byval iType as FVTEXTTYPE, byval pwszText as LPCWSTR) as HRESULT
		SetCurrentFolderFlags as function(byval This as IFolderView2 ptr, byval dwMask as DWORD, byval dwFlags as DWORD) as HRESULT
		GetCurrentFolderFlags as function(byval This as IFolderView2 ptr, byval pdwFlags as DWORD ptr) as HRESULT
		GetSortColumnCount as function(byval This as IFolderView2 ptr, byval pcColumns as long ptr) as HRESULT
		SetSortColumns as function(byval This as IFolderView2 ptr, byval rgSortColumns as const SORTCOLUMN ptr, byval cColumns as long) as HRESULT
		GetSortColumns as function(byval This as IFolderView2 ptr, byval rgSortColumns as SORTCOLUMN ptr, byval cColumns as long) as HRESULT
		GetItem as function(byval This as IFolderView2 ptr, byval iItem as long, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
		GetVisibleItem as function(byval This as IFolderView2 ptr, byval iStart as long, byval fPrevious as WINBOOL, byval piItem as long ptr) as HRESULT
		GetSelectedItem as function(byval This as IFolderView2 ptr, byval iStart as long, byval piItem as long ptr) as HRESULT
		GetSelection as function(byval This as IFolderView2 ptr, byval fNoneImpliesFolder as WINBOOL, byval ppsia as IShellItemArray ptr ptr) as HRESULT
		GetSelectionState as function(byval This as IFolderView2 ptr, byval pidl as LPCITEMIDLIST, byval pdwFlags as DWORD ptr) as HRESULT
		InvokeVerbOnSelection as function(byval This as IFolderView2 ptr, byval pszVerb as LPCSTR) as HRESULT
		SetViewModeAndIconSize as function(byval This as IFolderView2 ptr, byval uViewMode as FOLDERVIEWMODE, byval iImageSize as long) as HRESULT
		GetViewModeAndIconSize as function(byval This as IFolderView2 ptr, byval puViewMode as FOLDERVIEWMODE ptr, byval piImageSize as long ptr) as HRESULT
		SetGroupSubsetCount as function(byval This as IFolderView2 ptr, byval cVisibleRows as UINT) as HRESULT
		GetGroupSubsetCount as function(byval This as IFolderView2 ptr, byval pcVisibleRows as UINT ptr) as HRESULT
		SetRedraw as function(byval This as IFolderView2 ptr, byval fRedrawOn as WINBOOL) as HRESULT
		IsMoveInSameFolder as function(byval This as IFolderView2 ptr) as HRESULT
		DoRename as function(byval This as IFolderView2 ptr) as HRESULT
	end type

	type IFolderView2_
		lpVtbl as IFolderView2Vtbl ptr
	end type

	#define IFolderView2_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IFolderView2_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IFolderView2_Release(This) (This)->lpVtbl->Release(This)
	#define IFolderView2_GetCurrentViewMode(This, pViewMode) (This)->lpVtbl->GetCurrentViewMode(This, pViewMode)
	#define IFolderView2_SetCurrentViewMode(This, ViewMode) (This)->lpVtbl->SetCurrentViewMode(This, ViewMode)
	#define IFolderView2_GetFolder(This, riid, ppv) (This)->lpVtbl->GetFolder(This, riid, ppv)
	#define IFolderView2_Item(This, iItemIndex, ppidl) (This)->lpVtbl->Item(This, iItemIndex, ppidl)
	#define IFolderView2_ItemCount(This, uFlags, pcItems) (This)->lpVtbl->ItemCount(This, uFlags, pcItems)
	#define IFolderView2_Items(This, uFlags, riid, ppv) (This)->lpVtbl->Items(This, uFlags, riid, ppv)
	#define IFolderView2_GetSelectionMarkedItem(This, piItem) (This)->lpVtbl->GetSelectionMarkedItem(This, piItem)
	#define IFolderView2_GetFocusedItem(This, piItem) (This)->lpVtbl->GetFocusedItem(This, piItem)
	#define IFolderView2_GetItemPosition(This, pidl, ppt) (This)->lpVtbl->GetItemPosition(This, pidl, ppt)
	#define IFolderView2_GetSpacing(This, ppt) (This)->lpVtbl->GetSpacing(This, ppt)
	#define IFolderView2_GetDefaultSpacing(This, ppt) (This)->lpVtbl->GetDefaultSpacing(This, ppt)
	#define IFolderView2_GetAutoArrange(This) (This)->lpVtbl->GetAutoArrange(This)
	#define IFolderView2_SelectItem(This, iItem, dwFlags) (This)->lpVtbl->SelectItem(This, iItem, dwFlags)
	#define IFolderView2_SelectAndPositionItems(This, cidl, apidl, apt, dwFlags) (This)->lpVtbl->SelectAndPositionItems(This, cidl, apidl, apt, dwFlags)
	#define IFolderView2_SetGroupBy(This, key, fAscending) (This)->lpVtbl->SetGroupBy(This, key, fAscending)
	#define IFolderView2_GetGroupBy(This, pkey, pfAscending) (This)->lpVtbl->GetGroupBy(This, pkey, pfAscending)
	#define IFolderView2_SetViewProperty(This, pidl, propkey, propvar) (This)->lpVtbl->SetViewProperty(This, pidl, propkey, propvar)
	#define IFolderView2_GetViewProperty(This, pidl, propkey, ppropvar) (This)->lpVtbl->GetViewProperty(This, pidl, propkey, ppropvar)
	#define IFolderView2_SetTileViewProperties(This, pidl, pszPropList) (This)->lpVtbl->SetTileViewProperties(This, pidl, pszPropList)
	#define IFolderView2_SetExtendedTileViewProperties(This, pidl, pszPropList) (This)->lpVtbl->SetExtendedTileViewProperties(This, pidl, pszPropList)
	#define IFolderView2_SetText(This, iType, pwszText) (This)->lpVtbl->SetText(This, iType, pwszText)
	#define IFolderView2_SetCurrentFolderFlags(This, dwMask, dwFlags) (This)->lpVtbl->SetCurrentFolderFlags(This, dwMask, dwFlags)
	#define IFolderView2_GetCurrentFolderFlags(This, pdwFlags) (This)->lpVtbl->GetCurrentFolderFlags(This, pdwFlags)
	#define IFolderView2_GetSortColumnCount(This, pcColumns) (This)->lpVtbl->GetSortColumnCount(This, pcColumns)
	#define IFolderView2_SetSortColumns(This, rgSortColumns, cColumns) (This)->lpVtbl->SetSortColumns(This, rgSortColumns, cColumns)
	#define IFolderView2_GetSortColumns(This, rgSortColumns, cColumns) (This)->lpVtbl->GetSortColumns(This, rgSortColumns, cColumns)
	#define IFolderView2_GetItem(This, iItem, riid, ppv) (This)->lpVtbl->GetItem(This, iItem, riid, ppv)
	#define IFolderView2_GetVisibleItem(This, iStart, fPrevious, piItem) (This)->lpVtbl->GetVisibleItem(This, iStart, fPrevious, piItem)
	#define IFolderView2_GetSelectedItem(This, iStart, piItem) (This)->lpVtbl->GetSelectedItem(This, iStart, piItem)
	#define IFolderView2_GetSelection(This, fNoneImpliesFolder, ppsia) (This)->lpVtbl->GetSelection(This, fNoneImpliesFolder, ppsia)
	#define IFolderView2_GetSelectionState(This, pidl, pdwFlags) (This)->lpVtbl->GetSelectionState(This, pidl, pdwFlags)
	#define IFolderView2_InvokeVerbOnSelection(This, pszVerb) (This)->lpVtbl->InvokeVerbOnSelection(This, pszVerb)
	#define IFolderView2_SetViewModeAndIconSize(This, uViewMode, iImageSize) (This)->lpVtbl->SetViewModeAndIconSize(This, uViewMode, iImageSize)
	#define IFolderView2_GetViewModeAndIconSize(This, puViewMode, piImageSize) (This)->lpVtbl->GetViewModeAndIconSize(This, puViewMode, piImageSize)
	#define IFolderView2_SetGroupSubsetCount(This, cVisibleRows) (This)->lpVtbl->SetGroupSubsetCount(This, cVisibleRows)
	#define IFolderView2_GetGroupSubsetCount(This, pcVisibleRows) (This)->lpVtbl->GetGroupSubsetCount(This, pcVisibleRows)
	#define IFolderView2_SetRedraw(This, fRedrawOn) (This)->lpVtbl->SetRedraw(This, fRedrawOn)
	#define IFolderView2_IsMoveInSameFolder(This) (This)->lpVtbl->IsMoveInSameFolder(This)
	#define IFolderView2_DoRename(This) (This)->lpVtbl->DoRename(This)

	declare function IFolderView2_SetGroupBy_Proxy(byval This as IFolderView2 ptr, byval key as const PROPERTYKEY const ptr, byval fAscending as WINBOOL) as HRESULT
	declare sub IFolderView2_SetGroupBy_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFolderView2_RemoteGetGroupBy_Proxy(byval This as IFolderView2 ptr, byval pkey as PROPERTYKEY ptr, byval pfAscending as WINBOOL ptr) as HRESULT
	declare sub IFolderView2_RemoteGetGroupBy_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFolderView2_SetViewProperty_Proxy(byval This as IFolderView2 ptr, byval pidl as LPCITEMIDLIST, byval propkey as const PROPERTYKEY const ptr, byval propvar as const PROPVARIANT const ptr) as HRESULT
	declare sub IFolderView2_SetViewProperty_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFolderView2_GetViewProperty_Proxy(byval This as IFolderView2 ptr, byval pidl as LPCITEMIDLIST, byval propkey as const PROPERTYKEY const ptr, byval ppropvar as PROPVARIANT ptr) as HRESULT
	declare sub IFolderView2_GetViewProperty_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFolderView2_SetTileViewProperties_Proxy(byval This as IFolderView2 ptr, byval pidl as LPCITEMIDLIST, byval pszPropList as LPCWSTR) as HRESULT
	declare sub IFolderView2_SetTileViewProperties_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFolderView2_SetExtendedTileViewProperties_Proxy(byval This as IFolderView2 ptr, byval pidl as LPCITEMIDLIST, byval pszPropList as LPCWSTR) as HRESULT
	declare sub IFolderView2_SetExtendedTileViewProperties_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFolderView2_SetText_Proxy(byval This as IFolderView2 ptr, byval iType as FVTEXTTYPE, byval pwszText as LPCWSTR) as HRESULT
	declare sub IFolderView2_SetText_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFolderView2_SetCurrentFolderFlags_Proxy(byval This as IFolderView2 ptr, byval dwMask as DWORD, byval dwFlags as DWORD) as HRESULT
	declare sub IFolderView2_SetCurrentFolderFlags_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFolderView2_GetCurrentFolderFlags_Proxy(byval This as IFolderView2 ptr, byval pdwFlags as DWORD ptr) as HRESULT
	declare sub IFolderView2_GetCurrentFolderFlags_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFolderView2_GetSortColumnCount_Proxy(byval This as IFolderView2 ptr, byval pcColumns as long ptr) as HRESULT
	declare sub IFolderView2_GetSortColumnCount_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFolderView2_SetSortColumns_Proxy(byval This as IFolderView2 ptr, byval rgSortColumns as const SORTCOLUMN ptr, byval cColumns as long) as HRESULT
	declare sub IFolderView2_SetSortColumns_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFolderView2_GetSortColumns_Proxy(byval This as IFolderView2 ptr, byval rgSortColumns as SORTCOLUMN ptr, byval cColumns as long) as HRESULT
	declare sub IFolderView2_GetSortColumns_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFolderView2_GetItem_Proxy(byval This as IFolderView2 ptr, byval iItem as long, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	declare sub IFolderView2_GetItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFolderView2_GetVisibleItem_Proxy(byval This as IFolderView2 ptr, byval iStart as long, byval fPrevious as WINBOOL, byval piItem as long ptr) as HRESULT
	declare sub IFolderView2_GetVisibleItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFolderView2_GetSelectedItem_Proxy(byval This as IFolderView2 ptr, byval iStart as long, byval piItem as long ptr) as HRESULT
	declare sub IFolderView2_GetSelectedItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFolderView2_GetSelection_Proxy(byval This as IFolderView2 ptr, byval fNoneImpliesFolder as WINBOOL, byval ppsia as IShellItemArray ptr ptr) as HRESULT
	declare sub IFolderView2_GetSelection_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFolderView2_GetSelectionState_Proxy(byval This as IFolderView2 ptr, byval pidl as LPCITEMIDLIST, byval pdwFlags as DWORD ptr) as HRESULT
	declare sub IFolderView2_GetSelectionState_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFolderView2_InvokeVerbOnSelection_Proxy(byval This as IFolderView2 ptr, byval pszVerb as LPCSTR) as HRESULT
	declare sub IFolderView2_InvokeVerbOnSelection_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFolderView2_SetViewModeAndIconSize_Proxy(byval This as IFolderView2 ptr, byval uViewMode as FOLDERVIEWMODE, byval iImageSize as long) as HRESULT
	declare sub IFolderView2_SetViewModeAndIconSize_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFolderView2_GetViewModeAndIconSize_Proxy(byval This as IFolderView2 ptr, byval puViewMode as FOLDERVIEWMODE ptr, byval piImageSize as long ptr) as HRESULT
	declare sub IFolderView2_GetViewModeAndIconSize_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFolderView2_SetGroupSubsetCount_Proxy(byval This as IFolderView2 ptr, byval cVisibleRows as UINT) as HRESULT
	declare sub IFolderView2_SetGroupSubsetCount_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFolderView2_GetGroupSubsetCount_Proxy(byval This as IFolderView2 ptr, byval pcVisibleRows as UINT ptr) as HRESULT
	declare sub IFolderView2_GetGroupSubsetCount_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFolderView2_SetRedraw_Proxy(byval This as IFolderView2 ptr, byval fRedrawOn as WINBOOL) as HRESULT
	declare sub IFolderView2_SetRedraw_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFolderView2_IsMoveInSameFolder_Proxy(byval This as IFolderView2 ptr) as HRESULT
	declare sub IFolderView2_IsMoveInSameFolder_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFolderView2_DoRename_Proxy(byval This as IFolderView2 ptr) as HRESULT
	declare sub IFolderView2_DoRename_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFolderView2_GetGroupBy_Proxy(byval This as IFolderView2 ptr, byval pkey as PROPERTYKEY ptr, byval pfAscending as WINBOOL ptr) as HRESULT
	declare function IFolderView2_GetGroupBy_Stub(byval This as IFolderView2 ptr, byval pkey as PROPERTYKEY ptr, byval pfAscending as WINBOOL ptr) as HRESULT
	#define __IFolderViewSettings_INTERFACE_DEFINED__
	extern IID_IFolderViewSettings as const GUID
	type IFolderViewSettings as IFolderViewSettings_

	type IFolderViewSettingsVtbl
		QueryInterface as function(byval This as IFolderViewSettings ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IFolderViewSettings ptr) as ULONG
		Release as function(byval This as IFolderViewSettings ptr) as ULONG
		GetColumnPropertyList as function(byval This as IFolderViewSettings ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
		GetGroupByProperty as function(byval This as IFolderViewSettings ptr, byval pkey as PROPERTYKEY ptr, byval pfGroupAscending as WINBOOL ptr) as HRESULT
		GetViewMode as function(byval This as IFolderViewSettings ptr, byval plvm as FOLDERLOGICALVIEWMODE ptr) as HRESULT
		GetIconSize as function(byval This as IFolderViewSettings ptr, byval puIconSize as UINT ptr) as HRESULT
		GetFolderFlags as function(byval This as IFolderViewSettings ptr, byval pfolderMask as FOLDERFLAGS ptr, byval pfolderFlags as FOLDERFLAGS ptr) as HRESULT
		GetSortColumns as function(byval This as IFolderViewSettings ptr, byval rgSortColumns as SORTCOLUMN ptr, byval cColumnsIn as UINT, byval pcColumnsOut as UINT ptr) as HRESULT
		GetGroupSubsetCount as function(byval This as IFolderViewSettings ptr, byval pcVisibleRows as UINT ptr) as HRESULT
	end type

	type IFolderViewSettings_
		lpVtbl as IFolderViewSettingsVtbl ptr
	end type

	#define IFolderViewSettings_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IFolderViewSettings_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IFolderViewSettings_Release(This) (This)->lpVtbl->Release(This)
	#define IFolderViewSettings_GetColumnPropertyList(This, riid, ppv) (This)->lpVtbl->GetColumnPropertyList(This, riid, ppv)
	#define IFolderViewSettings_GetGroupByProperty(This, pkey, pfGroupAscending) (This)->lpVtbl->GetGroupByProperty(This, pkey, pfGroupAscending)
	#define IFolderViewSettings_GetViewMode(This, plvm) (This)->lpVtbl->GetViewMode(This, plvm)
	#define IFolderViewSettings_GetIconSize(This, puIconSize) (This)->lpVtbl->GetIconSize(This, puIconSize)
	#define IFolderViewSettings_GetFolderFlags(This, pfolderMask, pfolderFlags) (This)->lpVtbl->GetFolderFlags(This, pfolderMask, pfolderFlags)
	#define IFolderViewSettings_GetSortColumns(This, rgSortColumns, cColumnsIn, pcColumnsOut) (This)->lpVtbl->GetSortColumns(This, rgSortColumns, cColumnsIn, pcColumnsOut)
	#define IFolderViewSettings_GetGroupSubsetCount(This, pcVisibleRows) (This)->lpVtbl->GetGroupSubsetCount(This, pcVisibleRows)

	declare function IFolderViewSettings_GetColumnPropertyList_Proxy(byval This as IFolderViewSettings ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	declare sub IFolderViewSettings_GetColumnPropertyList_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFolderViewSettings_GetGroupByProperty_Proxy(byval This as IFolderViewSettings ptr, byval pkey as PROPERTYKEY ptr, byval pfGroupAscending as WINBOOL ptr) as HRESULT
	declare sub IFolderViewSettings_GetGroupByProperty_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFolderViewSettings_GetViewMode_Proxy(byval This as IFolderViewSettings ptr, byval plvm as FOLDERLOGICALVIEWMODE ptr) as HRESULT
	declare sub IFolderViewSettings_GetViewMode_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFolderViewSettings_GetIconSize_Proxy(byval This as IFolderViewSettings ptr, byval puIconSize as UINT ptr) as HRESULT
	declare sub IFolderViewSettings_GetIconSize_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFolderViewSettings_GetFolderFlags_Proxy(byval This as IFolderViewSettings ptr, byval pfolderMask as FOLDERFLAGS ptr, byval pfolderFlags as FOLDERFLAGS ptr) as HRESULT
	declare sub IFolderViewSettings_GetFolderFlags_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFolderViewSettings_GetSortColumns_Proxy(byval This as IFolderViewSettings ptr, byval rgSortColumns as SORTCOLUMN ptr, byval cColumnsIn as UINT, byval pcColumnsOut as UINT ptr) as HRESULT
	declare sub IFolderViewSettings_GetSortColumns_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFolderViewSettings_GetGroupSubsetCount_Proxy(byval This as IFolderViewSettings ptr, byval pcVisibleRows as UINT ptr) as HRESULT
	declare sub IFolderViewSettings_GetGroupSubsetCount_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	#define __IPreviewHandlerVisuals_INTERFACE_DEFINED__
	extern IID_IPreviewHandlerVisuals as const GUID
	type IPreviewHandlerVisuals as IPreviewHandlerVisuals_

	type IPreviewHandlerVisualsVtbl
		QueryInterface as function(byval This as IPreviewHandlerVisuals ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IPreviewHandlerVisuals ptr) as ULONG
		Release as function(byval This as IPreviewHandlerVisuals ptr) as ULONG
		SetBackgroundColor as function(byval This as IPreviewHandlerVisuals ptr, byval color as COLORREF) as HRESULT
		SetFont as function(byval This as IPreviewHandlerVisuals ptr, byval plf as const LOGFONTW ptr) as HRESULT
		SetTextColor as function(byval This as IPreviewHandlerVisuals ptr, byval color as COLORREF) as HRESULT
	end type

	type IPreviewHandlerVisuals_
		lpVtbl as IPreviewHandlerVisualsVtbl ptr
	end type

	#define IPreviewHandlerVisuals_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IPreviewHandlerVisuals_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IPreviewHandlerVisuals_Release(This) (This)->lpVtbl->Release(This)
	#define IPreviewHandlerVisuals_SetBackgroundColor(This, color) (This)->lpVtbl->SetBackgroundColor(This, color)
	#define IPreviewHandlerVisuals_SetFont(This, plf) (This)->lpVtbl->SetFont(This, plf)
	#define IPreviewHandlerVisuals_SetTextColor(This, color) (This)->lpVtbl->SetTextColor(This, color)

	declare function IPreviewHandlerVisuals_SetBackgroundColor_Proxy(byval This as IPreviewHandlerVisuals ptr, byval color as COLORREF) as HRESULT
	declare sub IPreviewHandlerVisuals_SetBackgroundColor_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IPreviewHandlerVisuals_SetFont_Proxy(byval This as IPreviewHandlerVisuals ptr, byval plf as const LOGFONTW ptr) as HRESULT
	declare sub IPreviewHandlerVisuals_SetFont_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IPreviewHandlerVisuals_SetTextColor_Proxy(byval This as IPreviewHandlerVisuals ptr, byval color as COLORREF) as HRESULT
	declare sub IPreviewHandlerVisuals_SetTextColor_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	#define __IVisualProperties_INTERFACE_DEFINED__

	type VPWATERMARKFLAGS as long
	enum
		VPWF_DEFAULT = &h0
		VPWF_ALPHABLEND = &h1
	end enum

	type VPCOLORFLAGS as long
	enum
		VPCF_TEXT = 1
		VPCF_BACKGROUND = 2
		VPCF_SORTCOLUMN = 3
		VPCF_SUBTEXT = 4
		VPCF_TEXTBACKGROUND = 5
	end enum

	extern IID_IVisualProperties as const GUID
	type IVisualProperties as IVisualProperties_

	type IVisualPropertiesVtbl
		QueryInterface as function(byval This as IVisualProperties ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IVisualProperties ptr) as ULONG
		Release as function(byval This as IVisualProperties ptr) as ULONG
		SetWatermark as function(byval This as IVisualProperties ptr, byval hbmp as HBITMAP, byval vpwf as VPWATERMARKFLAGS) as HRESULT
		SetColor as function(byval This as IVisualProperties ptr, byval vpcf as VPCOLORFLAGS, byval cr as COLORREF) as HRESULT
		GetColor as function(byval This as IVisualProperties ptr, byval vpcf as VPCOLORFLAGS, byval pcr as COLORREF ptr) as HRESULT
		SetItemHeight as function(byval This as IVisualProperties ptr, byval cyItemInPixels as long) as HRESULT
		GetItemHeight as function(byval This as IVisualProperties ptr, byval cyItemInPixels as long ptr) as HRESULT
		SetFont as function(byval This as IVisualProperties ptr, byval plf as const LOGFONTW ptr, byval bRedraw as WINBOOL) as HRESULT
		GetFont as function(byval This as IVisualProperties ptr, byval plf as LOGFONTW ptr) as HRESULT
		SetTheme as function(byval This as IVisualProperties ptr, byval pszSubAppName as LPCWSTR, byval pszSubIdList as LPCWSTR) as HRESULT
	end type

	type IVisualProperties_
		lpVtbl as IVisualPropertiesVtbl ptr
	end type

	#define IVisualProperties_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IVisualProperties_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IVisualProperties_Release(This) (This)->lpVtbl->Release(This)
	#define IVisualProperties_SetWatermark(This, hbmp, vpwf) (This)->lpVtbl->SetWatermark(This, hbmp, vpwf)
	#define IVisualProperties_SetColor(This, vpcf, cr) (This)->lpVtbl->SetColor(This, vpcf, cr)
	#define IVisualProperties_GetColor(This, vpcf, pcr) (This)->lpVtbl->GetColor(This, vpcf, pcr)
	#define IVisualProperties_SetItemHeight(This, cyItemInPixels) (This)->lpVtbl->SetItemHeight(This, cyItemInPixels)
	#define IVisualProperties_GetItemHeight(This, cyItemInPixels) (This)->lpVtbl->GetItemHeight(This, cyItemInPixels)
	#define IVisualProperties_SetFont(This, plf, bRedraw) (This)->lpVtbl->SetFont(This, plf, bRedraw)
	#define IVisualProperties_GetFont(This, plf) (This)->lpVtbl->GetFont(This, plf)
	#define IVisualProperties_SetTheme(This, pszSubAppName, pszSubIdList) (This)->lpVtbl->SetTheme(This, pszSubAppName, pszSubIdList)

	declare function IVisualProperties_SetWatermark_Proxy(byval This as IVisualProperties ptr, byval hbmp as HBITMAP, byval vpwf as VPWATERMARKFLAGS) as HRESULT
	declare sub IVisualProperties_SetWatermark_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IVisualProperties_SetColor_Proxy(byval This as IVisualProperties ptr, byval vpcf as VPCOLORFLAGS, byval cr as COLORREF) as HRESULT
	declare sub IVisualProperties_SetColor_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IVisualProperties_GetColor_Proxy(byval This as IVisualProperties ptr, byval vpcf as VPCOLORFLAGS, byval pcr as COLORREF ptr) as HRESULT
	declare sub IVisualProperties_GetColor_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IVisualProperties_SetItemHeight_Proxy(byval This as IVisualProperties ptr, byval cyItemInPixels as long) as HRESULT
	declare sub IVisualProperties_SetItemHeight_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IVisualProperties_GetItemHeight_Proxy(byval This as IVisualProperties ptr, byval cyItemInPixels as long ptr) as HRESULT
	declare sub IVisualProperties_GetItemHeight_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IVisualProperties_SetFont_Proxy(byval This as IVisualProperties ptr, byval plf as const LOGFONTW ptr, byval bRedraw as WINBOOL) as HRESULT
	declare sub IVisualProperties_SetFont_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IVisualProperties_GetFont_Proxy(byval This as IVisualProperties ptr, byval plf as LOGFONTW ptr) as HRESULT
	declare sub IVisualProperties_GetFont_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IVisualProperties_SetTheme_Proxy(byval This as IVisualProperties ptr, byval pszSubAppName as LPCWSTR, byval pszSubIdList as LPCWSTR) as HRESULT
	declare sub IVisualProperties_SetTheme_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#endif

const CDBOSC_SETFOCUS = &h00000000
const CDBOSC_KILLFOCUS = &h00000001
const CDBOSC_SELCHANGE = &h00000002
const CDBOSC_RENAME = &h00000003
const CDBOSC_STATECHANGE = &h00000004
#define __ICommDlgBrowser_INTERFACE_DEFINED__
extern IID_ICommDlgBrowser as const GUID
type ICommDlgBrowser as ICommDlgBrowser_

type ICommDlgBrowserVtbl
	QueryInterface as function(byval This as ICommDlgBrowser ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ICommDlgBrowser ptr) as ULONG
	Release as function(byval This as ICommDlgBrowser ptr) as ULONG
	OnDefaultCommand as function(byval This as ICommDlgBrowser ptr, byval ppshv as IShellView ptr) as HRESULT
	OnStateChange as function(byval This as ICommDlgBrowser ptr, byval ppshv as IShellView ptr, byval uChange as ULONG) as HRESULT
	IncludeObject as function(byval This as ICommDlgBrowser ptr, byval ppshv as IShellView ptr, byval pidl as LPCITEMIDLIST) as HRESULT
end type

type ICommDlgBrowser_
	lpVtbl as ICommDlgBrowserVtbl ptr
end type

#define ICommDlgBrowser_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define ICommDlgBrowser_AddRef(This) (This)->lpVtbl->AddRef(This)
#define ICommDlgBrowser_Release(This) (This)->lpVtbl->Release(This)
#define ICommDlgBrowser_OnDefaultCommand(This, ppshv) (This)->lpVtbl->OnDefaultCommand(This, ppshv)
#define ICommDlgBrowser_OnStateChange(This, ppshv, uChange) (This)->lpVtbl->OnStateChange(This, ppshv, uChange)
#define ICommDlgBrowser_IncludeObject(This, ppshv, pidl) (This)->lpVtbl->IncludeObject(This, ppshv, pidl)

declare function ICommDlgBrowser_OnDefaultCommand_Proxy(byval This as ICommDlgBrowser ptr, byval ppshv as IShellView ptr) as HRESULT
declare sub ICommDlgBrowser_OnDefaultCommand_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICommDlgBrowser_OnStateChange_Proxy(byval This as ICommDlgBrowser ptr, byval ppshv as IShellView ptr, byval uChange as ULONG) as HRESULT
declare sub ICommDlgBrowser_OnStateChange_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICommDlgBrowser_IncludeObject_Proxy(byval This as ICommDlgBrowser ptr, byval ppshv as IShellView ptr, byval pidl as LPCITEMIDLIST) as HRESULT
declare sub ICommDlgBrowser_IncludeObject_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
type LPCOMMDLGBROWSER as ICommDlgBrowser ptr
extern SID_SExplorerBrowserFrame alias "IID_ICommDlgBrowser" as const GUID

const CDB2N_CONTEXTMENU_DONE = &h00000001
const CDB2N_CONTEXTMENU_START = &h00000002
const CDB2GVF_SHOWALLFILES = &h1

#if _WIN32_WINNT >= &h0600
	const CDB2GVF_ISFILESAVE = &h2
	const CDB2GVF_ALLOWPREVIEWPANE = &h4
	const CDB2GVF_NOSELECTVERB = &h8
	const CDB2GVF_NOINCLUDEITEM = &h10
	const CDB2GVF_ISFOLDERPICKER = &h20
	const CDB2GVF_ADDSHIELD = &h40
#endif

#define __ICommDlgBrowser2_INTERFACE_DEFINED__
extern IID_ICommDlgBrowser2 as const GUID
type ICommDlgBrowser2 as ICommDlgBrowser2_

type ICommDlgBrowser2Vtbl
	QueryInterface as function(byval This as ICommDlgBrowser2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ICommDlgBrowser2 ptr) as ULONG
	Release as function(byval This as ICommDlgBrowser2 ptr) as ULONG
	OnDefaultCommand as function(byval This as ICommDlgBrowser2 ptr, byval ppshv as IShellView ptr) as HRESULT
	OnStateChange as function(byval This as ICommDlgBrowser2 ptr, byval ppshv as IShellView ptr, byval uChange as ULONG) as HRESULT
	IncludeObject as function(byval This as ICommDlgBrowser2 ptr, byval ppshv as IShellView ptr, byval pidl as LPCITEMIDLIST) as HRESULT
	Notify as function(byval This as ICommDlgBrowser2 ptr, byval ppshv as IShellView ptr, byval dwNotifyType as DWORD) as HRESULT
	GetDefaultMenuText as function(byval This as ICommDlgBrowser2 ptr, byval ppshv as IShellView ptr, byval pszText as LPWSTR, byval cchMax as long) as HRESULT
	GetViewFlags as function(byval This as ICommDlgBrowser2 ptr, byval pdwFlags as DWORD ptr) as HRESULT
end type

type ICommDlgBrowser2_
	lpVtbl as ICommDlgBrowser2Vtbl ptr
end type

#define ICommDlgBrowser2_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define ICommDlgBrowser2_AddRef(This) (This)->lpVtbl->AddRef(This)
#define ICommDlgBrowser2_Release(This) (This)->lpVtbl->Release(This)
#define ICommDlgBrowser2_OnDefaultCommand(This, ppshv) (This)->lpVtbl->OnDefaultCommand(This, ppshv)
#define ICommDlgBrowser2_OnStateChange(This, ppshv, uChange) (This)->lpVtbl->OnStateChange(This, ppshv, uChange)
#define ICommDlgBrowser2_IncludeObject(This, ppshv, pidl) (This)->lpVtbl->IncludeObject(This, ppshv, pidl)
#define ICommDlgBrowser2_Notify(This, ppshv, dwNotifyType) (This)->lpVtbl->Notify(This, ppshv, dwNotifyType)
#define ICommDlgBrowser2_GetDefaultMenuText(This, ppshv, pszText, cchMax) (This)->lpVtbl->GetDefaultMenuText(This, ppshv, pszText, cchMax)
#define ICommDlgBrowser2_GetViewFlags(This, pdwFlags) (This)->lpVtbl->GetViewFlags(This, pdwFlags)

declare function ICommDlgBrowser2_Notify_Proxy(byval This as ICommDlgBrowser2 ptr, byval ppshv as IShellView ptr, byval dwNotifyType as DWORD) as HRESULT
declare sub ICommDlgBrowser2_Notify_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICommDlgBrowser2_GetDefaultMenuText_Proxy(byval This as ICommDlgBrowser2 ptr, byval ppshv as IShellView ptr, byval pszText as LPWSTR, byval cchMax as long) as HRESULT
declare sub ICommDlgBrowser2_GetDefaultMenuText_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICommDlgBrowser2_GetViewFlags_Proxy(byval This as ICommDlgBrowser2 ptr, byval pdwFlags as DWORD ptr) as HRESULT
declare sub ICommDlgBrowser2_GetViewFlags_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
type LPCOMMDLGBROWSER2 as ICommDlgBrowser2 ptr

#if _WIN32_WINNT >= &h0600
	#define __ICommDlgBrowser3_INTERFACE_DEFINED__
	extern IID_ICommDlgBrowser3 as const GUID
	type ICommDlgBrowser3 as ICommDlgBrowser3_

	type ICommDlgBrowser3Vtbl
		QueryInterface as function(byval This as ICommDlgBrowser3 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as ICommDlgBrowser3 ptr) as ULONG
		Release as function(byval This as ICommDlgBrowser3 ptr) as ULONG
		OnDefaultCommand as function(byval This as ICommDlgBrowser3 ptr, byval ppshv as IShellView ptr) as HRESULT
		OnStateChange as function(byval This as ICommDlgBrowser3 ptr, byval ppshv as IShellView ptr, byval uChange as ULONG) as HRESULT
		IncludeObject as function(byval This as ICommDlgBrowser3 ptr, byval ppshv as IShellView ptr, byval pidl as LPCITEMIDLIST) as HRESULT
		Notify as function(byval This as ICommDlgBrowser3 ptr, byval ppshv as IShellView ptr, byval dwNotifyType as DWORD) as HRESULT
		GetDefaultMenuText as function(byval This as ICommDlgBrowser3 ptr, byval ppshv as IShellView ptr, byval pszText as LPWSTR, byval cchMax as long) as HRESULT
		GetViewFlags as function(byval This as ICommDlgBrowser3 ptr, byval pdwFlags as DWORD ptr) as HRESULT
		OnColumnClicked as function(byval This as ICommDlgBrowser3 ptr, byval ppshv as IShellView ptr, byval iColumn as long) as HRESULT
		GetCurrentFilter as function(byval This as ICommDlgBrowser3 ptr, byval pszFileSpec as LPWSTR, byval cchFileSpec as long) as HRESULT
		OnPreViewCreated as function(byval This as ICommDlgBrowser3 ptr, byval ppshv as IShellView ptr) as HRESULT
	end type

	type ICommDlgBrowser3_
		lpVtbl as ICommDlgBrowser3Vtbl ptr
	end type

	#define ICommDlgBrowser3_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define ICommDlgBrowser3_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define ICommDlgBrowser3_Release(This) (This)->lpVtbl->Release(This)
	#define ICommDlgBrowser3_OnDefaultCommand(This, ppshv) (This)->lpVtbl->OnDefaultCommand(This, ppshv)
	#define ICommDlgBrowser3_OnStateChange(This, ppshv, uChange) (This)->lpVtbl->OnStateChange(This, ppshv, uChange)
	#define ICommDlgBrowser3_IncludeObject(This, ppshv, pidl) (This)->lpVtbl->IncludeObject(This, ppshv, pidl)
	#define ICommDlgBrowser3_Notify(This, ppshv, dwNotifyType) (This)->lpVtbl->Notify(This, ppshv, dwNotifyType)
	#define ICommDlgBrowser3_GetDefaultMenuText(This, ppshv, pszText, cchMax) (This)->lpVtbl->GetDefaultMenuText(This, ppshv, pszText, cchMax)
	#define ICommDlgBrowser3_GetViewFlags(This, pdwFlags) (This)->lpVtbl->GetViewFlags(This, pdwFlags)
	#define ICommDlgBrowser3_OnColumnClicked(This, ppshv, iColumn) (This)->lpVtbl->OnColumnClicked(This, ppshv, iColumn)
	#define ICommDlgBrowser3_GetCurrentFilter(This, pszFileSpec, cchFileSpec) (This)->lpVtbl->GetCurrentFilter(This, pszFileSpec, cchFileSpec)
	#define ICommDlgBrowser3_OnPreViewCreated(This, ppshv) (This)->lpVtbl->OnPreViewCreated(This, ppshv)

	declare function ICommDlgBrowser3_OnColumnClicked_Proxy(byval This as ICommDlgBrowser3 ptr, byval ppshv as IShellView ptr, byval iColumn as long) as HRESULT
	declare sub ICommDlgBrowser3_OnColumnClicked_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function ICommDlgBrowser3_GetCurrentFilter_Proxy(byval This as ICommDlgBrowser3 ptr, byval pszFileSpec as LPWSTR, byval cchFileSpec as long) as HRESULT
	declare sub ICommDlgBrowser3_GetCurrentFilter_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function ICommDlgBrowser3_OnPreViewCreated_Proxy(byval This as ICommDlgBrowser3 ptr, byval ppshv as IShellView ptr) as HRESULT
	declare sub ICommDlgBrowser3_OnPreViewCreated_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

	type CM_MASK as long
	enum
		CM_MASK_WIDTH = &h1
		CM_MASK_DEFAULTWIDTH = &h2
		CM_MASK_IDEALWIDTH = &h4
		CM_MASK_NAME = &h8
		CM_MASK_STATE = &h10
	end enum

	type CM_STATE as long
	enum
		CM_STATE_NONE = &h0
		CM_STATE_VISIBLE = &h1
		CM_STATE_FIXEDWIDTH = &h2
		CM_STATE_NOSORTBYFOLDERNESS = &h4
		CM_STATE_ALWAYSVISIBLE = &h8
	end enum

	type CM_ENUM_FLAGS as long
	enum
		CM_ENUM_ALL = &h1
		CM_ENUM_VISIBLE = &h2
	end enum

	type CM_SET_WIDTH_VALUE as long
	enum
		CM_WIDTH_USEDEFAULT = -1
		CM_WIDTH_AUTOSIZE = -2
	end enum

	type CM_COLUMNINFO
		cbSize as DWORD
		dwMask as DWORD
		dwState as DWORD
		uWidth as UINT
		uDefaultWidth as UINT
		uIdealWidth as UINT
		wszName as wstring * 80
	end type

	#define __IColumnManager_INTERFACE_DEFINED__
	extern IID_IColumnManager as const GUID
	type IColumnManager as IColumnManager_

	type IColumnManagerVtbl
		QueryInterface as function(byval This as IColumnManager ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IColumnManager ptr) as ULONG
		Release as function(byval This as IColumnManager ptr) as ULONG
		SetColumnInfo as function(byval This as IColumnManager ptr, byval propkey as const PROPERTYKEY const ptr, byval pcmci as const CM_COLUMNINFO ptr) as HRESULT
		GetColumnInfo as function(byval This as IColumnManager ptr, byval propkey as const PROPERTYKEY const ptr, byval pcmci as CM_COLUMNINFO ptr) as HRESULT
		GetColumnCount as function(byval This as IColumnManager ptr, byval dwFlags as CM_ENUM_FLAGS, byval puCount as UINT ptr) as HRESULT
		GetColumns as function(byval This as IColumnManager ptr, byval dwFlags as CM_ENUM_FLAGS, byval rgkeyOrder as PROPERTYKEY ptr, byval cColumns as UINT) as HRESULT
		SetColumns as function(byval This as IColumnManager ptr, byval rgkeyOrder as const PROPERTYKEY ptr, byval cVisible as UINT) as HRESULT
	end type

	type IColumnManager_
		lpVtbl as IColumnManagerVtbl ptr
	end type

	#define IColumnManager_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IColumnManager_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IColumnManager_Release(This) (This)->lpVtbl->Release(This)
	#define IColumnManager_SetColumnInfo(This, propkey, pcmci) (This)->lpVtbl->SetColumnInfo(This, propkey, pcmci)
	#define IColumnManager_GetColumnInfo(This, propkey, pcmci) (This)->lpVtbl->GetColumnInfo(This, propkey, pcmci)
	#define IColumnManager_GetColumnCount(This, dwFlags, puCount) (This)->lpVtbl->GetColumnCount(This, dwFlags, puCount)
	#define IColumnManager_GetColumns(This, dwFlags, rgkeyOrder, cColumns) (This)->lpVtbl->GetColumns(This, dwFlags, rgkeyOrder, cColumns)
	#define IColumnManager_SetColumns(This, rgkeyOrder, cVisible) (This)->lpVtbl->SetColumns(This, rgkeyOrder, cVisible)

	declare function IColumnManager_SetColumnInfo_Proxy(byval This as IColumnManager ptr, byval propkey as const PROPERTYKEY const ptr, byval pcmci as const CM_COLUMNINFO ptr) as HRESULT
	declare sub IColumnManager_SetColumnInfo_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IColumnManager_GetColumnInfo_Proxy(byval This as IColumnManager ptr, byval propkey as const PROPERTYKEY const ptr, byval pcmci as CM_COLUMNINFO ptr) as HRESULT
	declare sub IColumnManager_GetColumnInfo_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IColumnManager_GetColumnCount_Proxy(byval This as IColumnManager ptr, byval dwFlags as CM_ENUM_FLAGS, byval puCount as UINT ptr) as HRESULT
	declare sub IColumnManager_GetColumnCount_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IColumnManager_GetColumns_Proxy(byval This as IColumnManager ptr, byval dwFlags as CM_ENUM_FLAGS, byval rgkeyOrder as PROPERTYKEY ptr, byval cColumns as UINT) as HRESULT
	declare sub IColumnManager_GetColumns_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IColumnManager_SetColumns_Proxy(byval This as IColumnManager ptr, byval rgkeyOrder as const PROPERTYKEY ptr, byval cVisible as UINT) as HRESULT
	declare sub IColumnManager_SetColumns_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#endif

#define __IFolderFilterSite_INTERFACE_DEFINED__
extern IID_IFolderFilterSite as const GUID
type IFolderFilterSite as IFolderFilterSite_

type IFolderFilterSiteVtbl
	QueryInterface as function(byval This as IFolderFilterSite ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IFolderFilterSite ptr) as ULONG
	Release as function(byval This as IFolderFilterSite ptr) as ULONG
	SetFilter as function(byval This as IFolderFilterSite ptr, byval punk as IUnknown ptr) as HRESULT
end type

type IFolderFilterSite_
	lpVtbl as IFolderFilterSiteVtbl ptr
end type

#define IFolderFilterSite_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IFolderFilterSite_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IFolderFilterSite_Release(This) (This)->lpVtbl->Release(This)
#define IFolderFilterSite_SetFilter(This, punk) (This)->lpVtbl->SetFilter(This, punk)
declare function IFolderFilterSite_SetFilter_Proxy(byval This as IFolderFilterSite ptr, byval punk as IUnknown ptr) as HRESULT
declare sub IFolderFilterSite_SetFilter_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IFolderFilter_INTERFACE_DEFINED__
extern IID_IFolderFilter as const GUID
type IFolderFilter as IFolderFilter_

type IFolderFilterVtbl
	QueryInterface as function(byval This as IFolderFilter ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IFolderFilter ptr) as ULONG
	Release as function(byval This as IFolderFilter ptr) as ULONG
	ShouldShow as function(byval This as IFolderFilter ptr, byval psf as IShellFolder ptr, byval pidlFolder as LPCITEMIDLIST, byval pidlItem as LPCITEMIDLIST) as HRESULT
	GetEnumFlags as function(byval This as IFolderFilter ptr, byval psf as IShellFolder ptr, byval pidlFolder as LPCITEMIDLIST, byval phwnd as HWND ptr, byval pgrfFlags as DWORD ptr) as HRESULT
end type

type IFolderFilter_
	lpVtbl as IFolderFilterVtbl ptr
end type

#define IFolderFilter_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IFolderFilter_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IFolderFilter_Release(This) (This)->lpVtbl->Release(This)
#define IFolderFilter_ShouldShow(This, psf, pidlFolder, pidlItem) (This)->lpVtbl->ShouldShow(This, psf, pidlFolder, pidlItem)
#define IFolderFilter_GetEnumFlags(This, psf, pidlFolder, phwnd, pgrfFlags) (This)->lpVtbl->GetEnumFlags(This, psf, pidlFolder, phwnd, pgrfFlags)

declare function IFolderFilter_ShouldShow_Proxy(byval This as IFolderFilter ptr, byval psf as IShellFolder ptr, byval pidlFolder as LPCITEMIDLIST, byval pidlItem as LPCITEMIDLIST) as HRESULT
declare sub IFolderFilter_ShouldShow_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFolderFilter_GetEnumFlags_Proxy(byval This as IFolderFilter ptr, byval psf as IShellFolder ptr, byval pidlFolder as LPCITEMIDLIST, byval phwnd as HWND ptr, byval pgrfFlags as DWORD ptr) as HRESULT
declare sub IFolderFilter_GetEnumFlags_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IInputObjectSite_INTERFACE_DEFINED__
extern IID_IInputObjectSite as const GUID
type IInputObjectSite as IInputObjectSite_

type IInputObjectSiteVtbl
	QueryInterface as function(byval This as IInputObjectSite ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IInputObjectSite ptr) as ULONG
	Release as function(byval This as IInputObjectSite ptr) as ULONG
	OnFocusChangeIS as function(byval This as IInputObjectSite ptr, byval punkObj as IUnknown ptr, byval fSetFocus as WINBOOL) as HRESULT
end type

type IInputObjectSite_
	lpVtbl as IInputObjectSiteVtbl ptr
end type

#define IInputObjectSite_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IInputObjectSite_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IInputObjectSite_Release(This) (This)->lpVtbl->Release(This)
#define IInputObjectSite_OnFocusChangeIS(This, punkObj, fSetFocus) (This)->lpVtbl->OnFocusChangeIS(This, punkObj, fSetFocus)
declare function IInputObjectSite_OnFocusChangeIS_Proxy(byval This as IInputObjectSite ptr, byval punkObj as IUnknown ptr, byval fSetFocus as WINBOOL) as HRESULT
declare sub IInputObjectSite_OnFocusChangeIS_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IInputObject_INTERFACE_DEFINED__
extern IID_IInputObject as const GUID
type IInputObject as IInputObject_

type IInputObjectVtbl
	QueryInterface as function(byval This as IInputObject ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IInputObject ptr) as ULONG
	Release as function(byval This as IInputObject ptr) as ULONG
	UIActivateIO as function(byval This as IInputObject ptr, byval fActivate as WINBOOL, byval pMsg as MSG ptr) as HRESULT
	HasFocusIO as function(byval This as IInputObject ptr) as HRESULT
	TranslateAcceleratorIO as function(byval This as IInputObject ptr, byval pMsg as MSG ptr) as HRESULT
end type

type IInputObject_
	lpVtbl as IInputObjectVtbl ptr
end type

#define IInputObject_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IInputObject_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IInputObject_Release(This) (This)->lpVtbl->Release(This)
#define IInputObject_UIActivateIO(This, fActivate, pMsg) (This)->lpVtbl->UIActivateIO(This, fActivate, pMsg)
#define IInputObject_HasFocusIO(This) (This)->lpVtbl->HasFocusIO(This)
#define IInputObject_TranslateAcceleratorIO(This, pMsg) (This)->lpVtbl->TranslateAcceleratorIO(This, pMsg)

declare function IInputObject_UIActivateIO_Proxy(byval This as IInputObject ptr, byval fActivate as WINBOOL, byval pMsg as MSG ptr) as HRESULT
declare sub IInputObject_UIActivateIO_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IInputObject_HasFocusIO_Proxy(byval This as IInputObject ptr) as HRESULT
declare sub IInputObject_HasFocusIO_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IInputObject_TranslateAcceleratorIO_Proxy(byval This as IInputObject ptr, byval pMsg as MSG ptr) as HRESULT
declare sub IInputObject_TranslateAcceleratorIO_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IInputObject2_INTERFACE_DEFINED__
extern IID_IInputObject2 as const GUID
type IInputObject2 as IInputObject2_

type IInputObject2Vtbl
	QueryInterface as function(byval This as IInputObject2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IInputObject2 ptr) as ULONG
	Release as function(byval This as IInputObject2 ptr) as ULONG
	UIActivateIO as function(byval This as IInputObject2 ptr, byval fActivate as WINBOOL, byval pMsg as MSG ptr) as HRESULT
	HasFocusIO as function(byval This as IInputObject2 ptr) as HRESULT
	TranslateAcceleratorIO as function(byval This as IInputObject2 ptr, byval pMsg as MSG ptr) as HRESULT
	TranslateAcceleratorGlobal as function(byval This as IInputObject2 ptr, byval pMsg as MSG ptr) as HRESULT
end type

type IInputObject2_
	lpVtbl as IInputObject2Vtbl ptr
end type

#define IInputObject2_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IInputObject2_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IInputObject2_Release(This) (This)->lpVtbl->Release(This)
#define IInputObject2_UIActivateIO(This, fActivate, pMsg) (This)->lpVtbl->UIActivateIO(This, fActivate, pMsg)
#define IInputObject2_HasFocusIO(This) (This)->lpVtbl->HasFocusIO(This)
#define IInputObject2_TranslateAcceleratorIO(This, pMsg) (This)->lpVtbl->TranslateAcceleratorIO(This, pMsg)
#define IInputObject2_TranslateAcceleratorGlobal(This, pMsg) (This)->lpVtbl->TranslateAcceleratorGlobal(This, pMsg)
declare function IInputObject2_TranslateAcceleratorGlobal_Proxy(byval This as IInputObject2 ptr, byval pMsg as MSG ptr) as HRESULT
declare sub IInputObject2_TranslateAcceleratorGlobal_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IShellIcon_INTERFACE_DEFINED__
extern IID_IShellIcon as const GUID
type IShellIcon as IShellIcon_

type IShellIconVtbl
	QueryInterface as function(byval This as IShellIcon ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IShellIcon ptr) as ULONG
	Release as function(byval This as IShellIcon ptr) as ULONG
	GetIconOf as function(byval This as IShellIcon ptr, byval pidl as LPCITEMIDLIST, byval flags as UINT, byval pIconIndex as long ptr) as HRESULT
end type

type IShellIcon_
	lpVtbl as IShellIconVtbl ptr
end type

#define IShellIcon_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IShellIcon_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IShellIcon_Release(This) (This)->lpVtbl->Release(This)
#define IShellIcon_GetIconOf(This, pidl, flags, pIconIndex) (This)->lpVtbl->GetIconOf(This, pidl, flags, pIconIndex)
declare function IShellIcon_GetIconOf_Proxy(byval This as IShellIcon ptr, byval pidl as LPCITEMIDLIST, byval flags as UINT, byval pIconIndex as long ptr) as HRESULT
declare sub IShellIcon_GetIconOf_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
const SBSP_DEFBROWSER = &h0000
const SBSP_SAMEBROWSER = &h0001
const SBSP_NEWBROWSER = &h0002
const SBSP_DEFMODE = &h0000
const SBSP_OPENMODE = &h0010
const SBSP_EXPLOREMODE = &h0020
const SBSP_HELPMODE = &h0040
const SBSP_NOTRANSFERHIST = &h0080
const SBSP_ABSOLUTE = &h0000
const SBSP_RELATIVE = &h1000
const SBSP_PARENT = &h2000
const SBSP_NAVIGATEBACK = &h4000
const SBSP_NAVIGATEFORWARD = &h8000
const SBSP_ALLOW_AUTONAVIGATE = &h00010000

#if _WIN32_WINNT >= &h0600
	const SBSP_KEEPSAMETEMPLATE = &h00020000
	const SBSP_KEEPWORDWHEELTEXT = &h00040000
	const SBSP_ACTIVATE_NOFOCUS = &h00080000
	const SBSP_CREATENOHISTORY = &h00100000
	const SBSP_PLAYNOSOUND = &h00200000
	const SBSP_CALLERUNTRUSTED = &h00800000
	const SBSP_TRUSTFIRSTDOWNLOAD = &h01000000
	const SBSP_UNTRUSTEDFORDOWNLOAD = &h02000000
#endif

const SBSP_NOAUTOSELECT = &h04000000
const SBSP_WRITENOHISTORY = &h08000000

#if _WIN32_WINNT >= &h0600
	const SBSP_TRUSTEDFORACTIVEX = &h10000000
	const SBSP_FEEDNAVIGATION = &h20000000
#endif

const SBSP_REDIRECT = &h40000000
const SBSP_INITIATEDBYHLINKFRAME = &h80000000
const FCW_STATUS = &h0001
const FCW_TOOLBAR = &h0002
const FCW_TREE = &h0003
const FCW_INTERNETBAR = &h0006
const FCW_PROGRESS = &h0008
const FCT_MERGE = &h0001
const FCT_CONFIGABLE = &h0002
const FCT_ADDTOEND = &h0004
type LPTBBUTTONSB as LPTBBUTTON
#define __IShellBrowser_INTERFACE_DEFINED__
extern IID_IShellBrowser as const GUID
extern SID_SShellBrowser alias "IID_IShellBrowser" as const GUID

type IShellBrowserVtbl
	QueryInterface as function(byval This as IShellBrowser ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IShellBrowser ptr) as ULONG
	Release as function(byval This as IShellBrowser ptr) as ULONG
	GetWindow as function(byval This as IShellBrowser ptr, byval phwnd as HWND ptr) as HRESULT
	ContextSensitiveHelp as function(byval This as IShellBrowser ptr, byval fEnterMode as WINBOOL) as HRESULT
	InsertMenusSB as function(byval This as IShellBrowser ptr, byval hmenuShared as HMENU, byval lpMenuWidths as LPOLEMENUGROUPWIDTHS) as HRESULT
	SetMenuSB as function(byval This as IShellBrowser ptr, byval hmenuShared as HMENU, byval holemenuRes as HOLEMENU, byval hwndActiveObject as HWND) as HRESULT
	RemoveMenusSB as function(byval This as IShellBrowser ptr, byval hmenuShared as HMENU) as HRESULT
	SetStatusTextSB as function(byval This as IShellBrowser ptr, byval pszStatusText as LPCWSTR) as HRESULT
	EnableModelessSB as function(byval This as IShellBrowser ptr, byval fEnable as WINBOOL) as HRESULT
	TranslateAcceleratorSB as function(byval This as IShellBrowser ptr, byval pmsg as MSG ptr, byval wID as WORD) as HRESULT
	BrowseObject as function(byval This as IShellBrowser ptr, byval pidl as LPCITEMIDLIST, byval wFlags as UINT) as HRESULT
	GetViewStateStream as function(byval This as IShellBrowser ptr, byval grfMode as DWORD, byval ppStrm as IStream ptr ptr) as HRESULT
	GetControlWindow as function(byval This as IShellBrowser ptr, byval id as UINT, byval phwnd as HWND ptr) as HRESULT
	SendControlMsg as function(byval This as IShellBrowser ptr, byval id as UINT, byval uMsg as UINT, byval wParam as WPARAM, byval lParam as LPARAM, byval pret as LRESULT ptr) as HRESULT
	QueryActiveShellView as function(byval This as IShellBrowser ptr, byval ppshv as IShellView ptr ptr) as HRESULT
	OnViewWindowActive as function(byval This as IShellBrowser ptr, byval pshv as IShellView ptr) as HRESULT
	SetToolbarItems as function(byval This as IShellBrowser ptr, byval lpButtons as LPTBBUTTONSB, byval nButtons as UINT, byval uFlags as UINT) as HRESULT
end type

type IShellBrowser_
	lpVtbl as IShellBrowserVtbl ptr
end type

#define IShellBrowser_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IShellBrowser_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IShellBrowser_Release(This) (This)->lpVtbl->Release(This)
#define IShellBrowser_GetWindow(This, phwnd) (This)->lpVtbl->GetWindow(This, phwnd)
#define IShellBrowser_ContextSensitiveHelp(This, fEnterMode) (This)->lpVtbl->ContextSensitiveHelp(This, fEnterMode)
#define IShellBrowser_InsertMenusSB(This, hmenuShared, lpMenuWidths) (This)->lpVtbl->InsertMenusSB(This, hmenuShared, lpMenuWidths)
#define IShellBrowser_SetMenuSB(This, hmenuShared, holemenuRes, hwndActiveObject) (This)->lpVtbl->SetMenuSB(This, hmenuShared, holemenuRes, hwndActiveObject)
#define IShellBrowser_RemoveMenusSB(This, hmenuShared) (This)->lpVtbl->RemoveMenusSB(This, hmenuShared)
#define IShellBrowser_SetStatusTextSB(This, pszStatusText) (This)->lpVtbl->SetStatusTextSB(This, pszStatusText)
#define IShellBrowser_EnableModelessSB(This, fEnable) (This)->lpVtbl->EnableModelessSB(This, fEnable)
#define IShellBrowser_TranslateAcceleratorSB(This, pmsg, wID) (This)->lpVtbl->TranslateAcceleratorSB(This, pmsg, wID)
#define IShellBrowser_BrowseObject(This, pidl, wFlags) (This)->lpVtbl->BrowseObject(This, pidl, wFlags)
#define IShellBrowser_GetViewStateStream(This, grfMode, ppStrm) (This)->lpVtbl->GetViewStateStream(This, grfMode, ppStrm)
#define IShellBrowser_GetControlWindow(This, id, phwnd) (This)->lpVtbl->GetControlWindow(This, id, phwnd)
#define IShellBrowser_SendControlMsg(This, id, uMsg, wParam, lParam, pret) (This)->lpVtbl->SendControlMsg(This, id, uMsg, wParam, lParam, pret)
#define IShellBrowser_QueryActiveShellView(This, ppshv) (This)->lpVtbl->QueryActiveShellView(This, ppshv)
#define IShellBrowser_OnViewWindowActive(This, pshv) (This)->lpVtbl->OnViewWindowActive(This, pshv)
#define IShellBrowser_SetToolbarItems(This, lpButtons, nButtons, uFlags) (This)->lpVtbl->SetToolbarItems(This, lpButtons, nButtons, uFlags)

declare function IShellBrowser_InsertMenusSB_Proxy(byval This as IShellBrowser ptr, byval hmenuShared as HMENU, byval lpMenuWidths as LPOLEMENUGROUPWIDTHS) as HRESULT
declare sub IShellBrowser_InsertMenusSB_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellBrowser_SetMenuSB_Proxy(byval This as IShellBrowser ptr, byval hmenuShared as HMENU, byval holemenuRes as HOLEMENU, byval hwndActiveObject as HWND) as HRESULT
declare sub IShellBrowser_SetMenuSB_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellBrowser_RemoveMenusSB_Proxy(byval This as IShellBrowser ptr, byval hmenuShared as HMENU) as HRESULT
declare sub IShellBrowser_RemoveMenusSB_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellBrowser_SetStatusTextSB_Proxy(byval This as IShellBrowser ptr, byval pszStatusText as LPCWSTR) as HRESULT
declare sub IShellBrowser_SetStatusTextSB_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellBrowser_EnableModelessSB_Proxy(byval This as IShellBrowser ptr, byval fEnable as WINBOOL) as HRESULT
declare sub IShellBrowser_EnableModelessSB_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellBrowser_TranslateAcceleratorSB_Proxy(byval This as IShellBrowser ptr, byval pmsg as MSG ptr, byval wID as WORD) as HRESULT
declare sub IShellBrowser_TranslateAcceleratorSB_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellBrowser_BrowseObject_Proxy(byval This as IShellBrowser ptr, byval pidl as LPCITEMIDLIST, byval wFlags as UINT) as HRESULT
declare sub IShellBrowser_BrowseObject_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellBrowser_GetViewStateStream_Proxy(byval This as IShellBrowser ptr, byval grfMode as DWORD, byval ppStrm as IStream ptr ptr) as HRESULT
declare sub IShellBrowser_GetViewStateStream_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellBrowser_GetControlWindow_Proxy(byval This as IShellBrowser ptr, byval id as UINT, byval phwnd as HWND ptr) as HRESULT
declare sub IShellBrowser_GetControlWindow_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellBrowser_QueryActiveShellView_Proxy(byval This as IShellBrowser ptr, byval ppshv as IShellView ptr ptr) as HRESULT
declare sub IShellBrowser_QueryActiveShellView_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellBrowser_OnViewWindowActive_Proxy(byval This as IShellBrowser ptr, byval pshv as IShellView ptr) as HRESULT
declare sub IShellBrowser_OnViewWindowActive_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
type LPSHELLBROWSER as IShellBrowser ptr
#define __IProfferService_INTERFACE_DEFINED__
extern IID_IProfferService as const GUID
type IProfferService as IProfferService_

type IProfferServiceVtbl
	QueryInterface as function(byval This as IProfferService ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IProfferService ptr) as ULONG
	Release as function(byval This as IProfferService ptr) as ULONG
	ProfferService as function(byval This as IProfferService ptr, byval guidService as const GUID const ptr, byval psp as IServiceProvider ptr, byval pdwCookie as DWORD ptr) as HRESULT
	RevokeService as function(byval This as IProfferService ptr, byval dwCookie as DWORD) as HRESULT
end type

type IProfferService_
	lpVtbl as IProfferServiceVtbl ptr
end type

#define IProfferService_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IProfferService_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IProfferService_Release(This) (This)->lpVtbl->Release(This)
#define IProfferService_ProfferService(This, guidService, psp, pdwCookie) (This)->lpVtbl->ProfferService(This, guidService, psp, pdwCookie)
#define IProfferService_RevokeService(This, dwCookie) (This)->lpVtbl->RevokeService(This, dwCookie)

declare function IProfferService_ProfferService_Proxy(byval This as IProfferService ptr, byval guidService as const GUID const ptr, byval psp as IServiceProvider ptr, byval pdwCookie as DWORD ptr) as HRESULT
declare sub IProfferService_ProfferService_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IProfferService_RevokeService_Proxy(byval This as IProfferService ptr, byval dwCookie as DWORD) as HRESULT
declare sub IProfferService_RevokeService_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
extern SID_SProfferService alias "IID_IProfferService" as const GUID

#define STR_DONT_RESOLVE_LINK wstr("Don't Resolve Link")
#define STR_GET_ASYNC_HANDLER wstr("GetAsyncHandler")
#define __IShellItem_INTERFACE_DEFINED__

type _SIGDN as long
enum
	SIGDN_NORMALDISPLAY = &h0
	SIGDN_PARENTRELATIVEPARSING = clng(&h80018001)
	SIGDN_DESKTOPABSOLUTEPARSING = clng(&h80028000)
	SIGDN_PARENTRELATIVEEDITING = clng(&h80031001)
	SIGDN_DESKTOPABSOLUTEEDITING = clng(&h8004c000)
	SIGDN_FILESYSPATH = clng(&h80058000)
	SIGDN_URL = clng(&h80068000)
	SIGDN_PARENTRELATIVEFORADDRESSBAR = clng(&h8007c001)
	SIGDN_PARENTRELATIVE = clng(&h80080001)
	SIGDN_PARENTRELATIVEFORUI = clng(&h80094001)
end enum

type SIGDN as _SIGDN

type _SICHINTF as long
enum
	SICHINT_DISPLAY = &h0
	SICHINT_ALLFIELDS = clng(&h80000000)
	SICHINT_CANONICAL = &h10000000
	SICHINT_TEST_FILESYSPATH_IF_NOT_EQUAL = &h20000000
end enum

type SICHINTF as DWORD
extern IID_IShellItem as const GUID

#if _WIN32_WINNT <= &h0600
	type IShellItem as IShellItem_
#endif

type IShellItemVtbl
	QueryInterface as function(byval This as IShellItem ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IShellItem ptr) as ULONG
	Release as function(byval This as IShellItem ptr) as ULONG
	BindToHandler as function(byval This as IShellItem ptr, byval pbc as IBindCtx ptr, byval bhid as const GUID const ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	GetParent as function(byval This as IShellItem ptr, byval ppsi as IShellItem ptr ptr) as HRESULT
	GetDisplayName as function(byval This as IShellItem ptr, byval sigdnName as SIGDN, byval ppszName as LPWSTR ptr) as HRESULT
	GetAttributes as function(byval This as IShellItem ptr, byval sfgaoMask as SFGAOF, byval psfgaoAttribs as SFGAOF ptr) as HRESULT
	Compare as function(byval This as IShellItem ptr, byval psi as IShellItem ptr, byval hint as SICHINTF, byval piOrder as long ptr) as HRESULT
end type

type IShellItem_
	lpVtbl as IShellItemVtbl ptr
end type

#define IShellItem_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IShellItem_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IShellItem_Release(This) (This)->lpVtbl->Release(This)
#define IShellItem_BindToHandler(This, pbc, bhid, riid, ppv) (This)->lpVtbl->BindToHandler(This, pbc, bhid, riid, ppv)
#define IShellItem_GetParent(This, ppsi) (This)->lpVtbl->GetParent(This, ppsi)
#define IShellItem_GetDisplayName(This, sigdnName, ppszName) (This)->lpVtbl->GetDisplayName(This, sigdnName, ppszName)
#define IShellItem_GetAttributes(This, sfgaoMask, psfgaoAttribs) (This)->lpVtbl->GetAttributes(This, sfgaoMask, psfgaoAttribs)
#define IShellItem_Compare(This, psi, hint, piOrder) (This)->lpVtbl->Compare(This, psi, hint, piOrder)

declare function IShellItem_BindToHandler_Proxy(byval This as IShellItem ptr, byval pbc as IBindCtx ptr, byval bhid as const GUID const ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare sub IShellItem_BindToHandler_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellItem_GetParent_Proxy(byval This as IShellItem ptr, byval ppsi as IShellItem ptr ptr) as HRESULT
declare sub IShellItem_GetParent_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellItem_GetDisplayName_Proxy(byval This as IShellItem ptr, byval sigdnName as SIGDN, byval ppszName as LPWSTR ptr) as HRESULT
declare sub IShellItem_GetDisplayName_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellItem_GetAttributes_Proxy(byval This as IShellItem ptr, byval sfgaoMask as SFGAOF, byval psfgaoAttribs as SFGAOF ptr) as HRESULT
declare sub IShellItem_GetAttributes_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellItem_Compare_Proxy(byval This as IShellItem ptr, byval psi as IShellItem ptr, byval hint as SICHINTF, byval piOrder as long ptr) as HRESULT
declare sub IShellItem_Compare_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function SHSimpleIDListFromPath(byval pszPath as PCWSTR) as LPITEMIDLIST

#if _WIN32_WINNT >= &h0600
	declare function SHCreateItemFromIDList(byval pidl as LPCITEMIDLIST, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	declare function SHCreateItemFromParsingName(byval pszPath as PCWSTR, byval pbc as IBindCtx ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	declare function SHCreateItemWithParent(byval pidlParent as LPCITEMIDLIST, byval psfParent as IShellFolder ptr, byval pidl as LPCITEMIDLIST, byval riid as const IID const ptr, byval ppvItem as any ptr ptr) as HRESULT
	declare function SHCreateItemFromRelativeName(byval psiParent as IShellItem ptr, byval pszName as PCWSTR, byval pbc as IBindCtx ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	declare function SHCreateItemInKnownFolder(byval kfid as const KNOWNFOLDERID const ptr, byval dwKFFlags as DWORD, byval pszItem as PCWSTR, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	declare function SHGetIDListFromObject(byval punk as IUnknown ptr, byval ppidl as LPITEMIDLIST ptr) as HRESULT
	declare function SHGetItemFromObject(byval punk as IUnknown ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	declare function SHGetPropertyStoreFromIDList(byval pidl as LPCITEMIDLIST, byval flags as GETPROPERTYSTOREFLAGS, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	declare function SHGetPropertyStoreFromParsingName(byval pszPath as PCWSTR, byval pbc as IBindCtx ptr, byval flags as GETPROPERTYSTOREFLAGS, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	declare function SHGetNameFromIDList(byval pidl as LPCITEMIDLIST, byval sigdnName as SIGDN, byval ppszName as PWSTR ptr) as HRESULT
#endif

#if _WIN32_WINNT >= &h0601
	type DATAOBJ_GET_ITEM_FLAGS as long
	enum
		DOGIF_DEFAULT = &h0
		DOGIF_TRAVERSE_LINK = &h1
		DOGIF_NO_HDROP = &h2
		DOGIF_NO_URL = &h4
		DOGIF_ONLY_IF_ONE = &h8
	end enum

	declare function SHGetItemFromDataObject(byval pdtobj as IDataObject ptr, byval dwFlags as DATAOBJ_GET_ITEM_FLAGS, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
#endif

#define STR_GPS_HANDLERPROPERTIESONLY wstr("GPS_HANDLERPROPERTIESONLY")
#define STR_GPS_FASTPROPERTIESONLY wstr("GPS_FASTPROPERTIESONLY")
#define STR_GPS_OPENSLOWITEM wstr("GPS_OPENSLOWITEM")
#define STR_GPS_DELAYCREATION wstr("GPS_DELAYCREATION")
#define STR_GPS_BESTEFFORT wstr("GPS_BESTEFFORT")
#define STR_GPS_NO_OPLOCK wstr("GPS_NO_OPLOCK")
#define __IShellItem2_INTERFACE_DEFINED__
extern IID_IShellItem2 as const GUID
type IShellItem2 as IShellItem2_

type IShellItem2Vtbl
	QueryInterface as function(byval This as IShellItem2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IShellItem2 ptr) as ULONG
	Release as function(byval This as IShellItem2 ptr) as ULONG
	BindToHandler as function(byval This as IShellItem2 ptr, byval pbc as IBindCtx ptr, byval bhid as const GUID const ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	GetParent as function(byval This as IShellItem2 ptr, byval ppsi as IShellItem ptr ptr) as HRESULT
	GetDisplayName as function(byval This as IShellItem2 ptr, byval sigdnName as SIGDN, byval ppszName as LPWSTR ptr) as HRESULT
	GetAttributes as function(byval This as IShellItem2 ptr, byval sfgaoMask as SFGAOF, byval psfgaoAttribs as SFGAOF ptr) as HRESULT
	Compare as function(byval This as IShellItem2 ptr, byval psi as IShellItem ptr, byval hint as SICHINTF, byval piOrder as long ptr) as HRESULT
	GetPropertyStore as function(byval This as IShellItem2 ptr, byval flags as GETPROPERTYSTOREFLAGS, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	GetPropertyStoreWithCreateObject as function(byval This as IShellItem2 ptr, byval flags as GETPROPERTYSTOREFLAGS, byval punkCreateObject as IUnknown ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	GetPropertyStoreForKeys as function(byval This as IShellItem2 ptr, byval rgKeys as const PROPERTYKEY ptr, byval cKeys as UINT, byval flags as GETPROPERTYSTOREFLAGS, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	GetPropertyDescriptionList as function(byval This as IShellItem2 ptr, byval keyType as const PROPERTYKEY const ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	Update as function(byval This as IShellItem2 ptr, byval pbc as IBindCtx ptr) as HRESULT
	GetProperty as function(byval This as IShellItem2 ptr, byval key as const PROPERTYKEY const ptr, byval ppropvar as PROPVARIANT ptr) as HRESULT
	GetCLSID as function(byval This as IShellItem2 ptr, byval key as const PROPERTYKEY const ptr, byval pclsid as CLSID ptr) as HRESULT
	GetFileTime as function(byval This as IShellItem2 ptr, byval key as const PROPERTYKEY const ptr, byval pft as FILETIME ptr) as HRESULT
	GetInt32 as function(byval This as IShellItem2 ptr, byval key as const PROPERTYKEY const ptr, byval pi as long ptr) as HRESULT
	GetString as function(byval This as IShellItem2 ptr, byval key as const PROPERTYKEY const ptr, byval ppsz as LPWSTR ptr) as HRESULT
	GetUInt32 as function(byval This as IShellItem2 ptr, byval key as const PROPERTYKEY const ptr, byval pui as ULONG ptr) as HRESULT
	GetUInt64 as function(byval This as IShellItem2 ptr, byval key as const PROPERTYKEY const ptr, byval pull as ULONGLONG ptr) as HRESULT
	GetBool as function(byval This as IShellItem2 ptr, byval key as const PROPERTYKEY const ptr, byval pf as WINBOOL ptr) as HRESULT
end type

type IShellItem2_
	lpVtbl as IShellItem2Vtbl ptr
end type

#define IShellItem2_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IShellItem2_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IShellItem2_Release(This) (This)->lpVtbl->Release(This)
#define IShellItem2_BindToHandler(This, pbc, bhid, riid, ppv) (This)->lpVtbl->BindToHandler(This, pbc, bhid, riid, ppv)
#define IShellItem2_GetParent(This, ppsi) (This)->lpVtbl->GetParent(This, ppsi)
#define IShellItem2_GetDisplayName(This, sigdnName, ppszName) (This)->lpVtbl->GetDisplayName(This, sigdnName, ppszName)
#define IShellItem2_GetAttributes(This, sfgaoMask, psfgaoAttribs) (This)->lpVtbl->GetAttributes(This, sfgaoMask, psfgaoAttribs)
#define IShellItem2_Compare(This, psi, hint, piOrder) (This)->lpVtbl->Compare(This, psi, hint, piOrder)
#define IShellItem2_GetPropertyStore(This, flags, riid, ppv) (This)->lpVtbl->GetPropertyStore(This, flags, riid, ppv)
#define IShellItem2_GetPropertyStoreWithCreateObject(This, flags, punkCreateObject, riid, ppv) (This)->lpVtbl->GetPropertyStoreWithCreateObject(This, flags, punkCreateObject, riid, ppv)
#define IShellItem2_GetPropertyStoreForKeys(This, rgKeys, cKeys, flags, riid, ppv) (This)->lpVtbl->GetPropertyStoreForKeys(This, rgKeys, cKeys, flags, riid, ppv)
#define IShellItem2_GetPropertyDescriptionList(This, keyType, riid, ppv) (This)->lpVtbl->GetPropertyDescriptionList(This, keyType, riid, ppv)
#define IShellItem2_Update(This, pbc) (This)->lpVtbl->Update(This, pbc)
#define IShellItem2_GetProperty(This, key, ppropvar) (This)->lpVtbl->GetProperty(This, key, ppropvar)
#define IShellItem2_GetCLSID(This, key, pclsid) (This)->lpVtbl->GetCLSID(This, key, pclsid)
#define IShellItem2_GetFileTime(This, key, pft) (This)->lpVtbl->GetFileTime(This, key, pft)
#define IShellItem2_GetInt32(This, key, pi) (This)->lpVtbl->GetInt32(This, key, pi)
#define IShellItem2_GetString(This, key, ppsz) (This)->lpVtbl->GetString(This, key, ppsz)
#define IShellItem2_GetUInt32(This, key, pui) (This)->lpVtbl->GetUInt32(This, key, pui)
#define IShellItem2_GetUInt64(This, key, pull) (This)->lpVtbl->GetUInt64(This, key, pull)
#define IShellItem2_GetBool(This, key, pf) (This)->lpVtbl->GetBool(This, key, pf)

declare function IShellItem2_GetPropertyStore_Proxy(byval This as IShellItem2 ptr, byval flags as GETPROPERTYSTOREFLAGS, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare sub IShellItem2_GetPropertyStore_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellItem2_GetPropertyStoreWithCreateObject_Proxy(byval This as IShellItem2 ptr, byval flags as GETPROPERTYSTOREFLAGS, byval punkCreateObject as IUnknown ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare sub IShellItem2_GetPropertyStoreWithCreateObject_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellItem2_GetPropertyStoreForKeys_Proxy(byval This as IShellItem2 ptr, byval rgKeys as const PROPERTYKEY ptr, byval cKeys as UINT, byval flags as GETPROPERTYSTOREFLAGS, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare sub IShellItem2_GetPropertyStoreForKeys_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellItem2_GetPropertyDescriptionList_Proxy(byval This as IShellItem2 ptr, byval keyType as const PROPERTYKEY const ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare sub IShellItem2_GetPropertyDescriptionList_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellItem2_Update_Proxy(byval This as IShellItem2 ptr, byval pbc as IBindCtx ptr) as HRESULT
declare sub IShellItem2_Update_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellItem2_GetProperty_Proxy(byval This as IShellItem2 ptr, byval key as const PROPERTYKEY const ptr, byval ppropvar as PROPVARIANT ptr) as HRESULT
declare sub IShellItem2_GetProperty_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellItem2_GetCLSID_Proxy(byval This as IShellItem2 ptr, byval key as const PROPERTYKEY const ptr, byval pclsid as CLSID ptr) as HRESULT
declare sub IShellItem2_GetCLSID_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellItem2_GetFileTime_Proxy(byval This as IShellItem2 ptr, byval key as const PROPERTYKEY const ptr, byval pft as FILETIME ptr) as HRESULT
declare sub IShellItem2_GetFileTime_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellItem2_GetInt32_Proxy(byval This as IShellItem2 ptr, byval key as const PROPERTYKEY const ptr, byval pi as long ptr) as HRESULT
declare sub IShellItem2_GetInt32_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellItem2_GetString_Proxy(byval This as IShellItem2 ptr, byval key as const PROPERTYKEY const ptr, byval ppsz as LPWSTR ptr) as HRESULT
declare sub IShellItem2_GetString_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellItem2_GetUInt32_Proxy(byval This as IShellItem2 ptr, byval key as const PROPERTYKEY const ptr, byval pui as ULONG ptr) as HRESULT
declare sub IShellItem2_GetUInt32_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellItem2_GetUInt64_Proxy(byval This as IShellItem2 ptr, byval key as const PROPERTYKEY const ptr, byval pull as ULONGLONG ptr) as HRESULT
declare sub IShellItem2_GetUInt64_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellItem2_GetBool_Proxy(byval This as IShellItem2 ptr, byval key as const PROPERTYKEY const ptr, byval pf as WINBOOL ptr) as HRESULT
declare sub IShellItem2_GetBool_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

type _SIIGBF as long
enum
	SIIGBF_RESIZETOFIT = &h0
	SIIGBF_BIGGERSIZEOK = &h1
	SIIGBF_MEMORYONLY = &h2
	SIIGBF_ICONONLY = &h4
	SIIGBF_THUMBNAILONLY = &h8
	SIIGBF_INCACHEONLY = &h10
	SIIGBF_CROPTOSQUARE = &h20
	SIIGBF_WIDETHUMBNAILS = &h40
	SIIGBF_ICONBACKGROUND = &h80
	SIIGBF_SCALEUP = &h100
end enum

type SIIGBF as long
#define __IShellItemImageFactory_INTERFACE_DEFINED__
extern IID_IShellItemImageFactory as const GUID
type IShellItemImageFactory as IShellItemImageFactory_

type IShellItemImageFactoryVtbl
	QueryInterface as function(byval This as IShellItemImageFactory ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IShellItemImageFactory ptr) as ULONG
	Release as function(byval This as IShellItemImageFactory ptr) as ULONG
	GetImage as function(byval This as IShellItemImageFactory ptr, byval size as SIZE, byval flags as SIIGBF, byval phbm as HBITMAP ptr) as HRESULT
end type

type IShellItemImageFactory_
	lpVtbl as IShellItemImageFactoryVtbl ptr
end type

#define IShellItemImageFactory_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IShellItemImageFactory_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IShellItemImageFactory_Release(This) (This)->lpVtbl->Release(This)
#define IShellItemImageFactory_GetImage(This, size, flags, phbm) (This)->lpVtbl->GetImage(This, size, flags, phbm)
declare function IShellItemImageFactory_GetImage_Proxy(byval This as IShellItemImageFactory ptr, byval size as SIZE, byval flags as SIIGBF, byval phbm as HBITMAP ptr) as HRESULT
declare sub IShellItemImageFactory_GetImage_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IUserAccountChangeCallback_INTERFACE_DEFINED__
extern IID_IUserAccountChangeCallback as const GUID
type IUserAccountChangeCallback as IUserAccountChangeCallback_

type IUserAccountChangeCallbackVtbl
	QueryInterface as function(byval This as IUserAccountChangeCallback ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IUserAccountChangeCallback ptr) as ULONG
	Release as function(byval This as IUserAccountChangeCallback ptr) as ULONG
	OnPictureChange as function(byval This as IUserAccountChangeCallback ptr, byval pszUserName as LPCWSTR) as HRESULT
end type

type IUserAccountChangeCallback_
	lpVtbl as IUserAccountChangeCallbackVtbl ptr
end type

#define IUserAccountChangeCallback_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IUserAccountChangeCallback_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IUserAccountChangeCallback_Release(This) (This)->lpVtbl->Release(This)
#define IUserAccountChangeCallback_OnPictureChange(This, pszUserName) (This)->lpVtbl->OnPictureChange(This, pszUserName)
declare function IUserAccountChangeCallback_OnPictureChange_Proxy(byval This as IUserAccountChangeCallback ptr, byval pszUserName as LPCWSTR) as HRESULT
declare sub IUserAccountChangeCallback_OnPictureChange_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IEnumShellItems_INTERFACE_DEFINED__
extern IID_IEnumShellItems as const GUID
type IEnumShellItems as IEnumShellItems_

type IEnumShellItemsVtbl
	QueryInterface as function(byval This as IEnumShellItems ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IEnumShellItems ptr) as ULONG
	Release as function(byval This as IEnumShellItems ptr) as ULONG
	Next as function(byval This as IEnumShellItems ptr, byval celt as ULONG, byval rgelt as IShellItem ptr ptr, byval pceltFetched as ULONG ptr) as HRESULT
	Skip as function(byval This as IEnumShellItems ptr, byval celt as ULONG) as HRESULT
	Reset as function(byval This as IEnumShellItems ptr) as HRESULT
	Clone as function(byval This as IEnumShellItems ptr, byval ppenum as IEnumShellItems ptr ptr) as HRESULT
end type

type IEnumShellItems_
	lpVtbl as IEnumShellItemsVtbl ptr
end type

#define IEnumShellItems_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IEnumShellItems_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IEnumShellItems_Release(This) (This)->lpVtbl->Release(This)
#define IEnumShellItems_Next(This, celt, rgelt, pceltFetched) (This)->lpVtbl->Next(This, celt, rgelt, pceltFetched)
#define IEnumShellItems_Skip(This, celt) (This)->lpVtbl->Skip(This, celt)
#define IEnumShellItems_Reset(This) (This)->lpVtbl->Reset(This)
#define IEnumShellItems_Clone(This, ppenum) (This)->lpVtbl->Clone(This, ppenum)

declare function IEnumShellItems_RemoteNext_Proxy(byval This as IEnumShellItems ptr, byval celt as ULONG, byval rgelt as IShellItem ptr ptr, byval pceltFetched as ULONG ptr) as HRESULT
declare sub IEnumShellItems_RemoteNext_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumShellItems_Skip_Proxy(byval This as IEnumShellItems ptr, byval celt as ULONG) as HRESULT
declare sub IEnumShellItems_Skip_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumShellItems_Reset_Proxy(byval This as IEnumShellItems ptr) as HRESULT
declare sub IEnumShellItems_Reset_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumShellItems_Clone_Proxy(byval This as IEnumShellItems ptr, byval ppenum as IEnumShellItems ptr ptr) as HRESULT
declare sub IEnumShellItems_Clone_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumShellItems_Next_Proxy(byval This as IEnumShellItems ptr, byval celt as ULONG, byval rgelt as IShellItem ptr ptr, byval pceltFetched as ULONG ptr) as HRESULT
declare function IEnumShellItems_Next_Stub(byval This as IEnumShellItems ptr, byval celt as ULONG, byval rgelt as IShellItem ptr ptr, byval pceltFetched as ULONG ptr) as HRESULT
type STGTRANSCONFIRMATION as GUID
type LPSTGTRANSCONFIRMATION as GUID ptr

type STGOP as long
enum
	STGOP_MOVE = 1
	STGOP_COPY = 2
	STGOP_SYNC = 3
	STGOP_REMOVE = 5
	STGOP_RENAME = 6
	STGOP_APPLYPROPERTIES = 8
	STGOP_NEW = 10
end enum

type _TRANSFER_SOURCE_FLAGS as long
enum
	TSF_NORMAL = &h0
	TSF_FAIL_EXIST = &h0
	TSF_RENAME_EXIST = &h1
	TSF_OVERWRITE_EXIST = &h2
	TSF_ALLOW_DECRYPTION = &h4
	TSF_NO_SECURITY = &h8
	TSF_COPY_CREATION_TIME = &h10
	TSF_COPY_WRITE_TIME = &h20
	TSF_USE_FULL_ACCESS = &h40
	TSF_DELETE_RECYCLE_IF_POSSIBLE = &h80
	TSF_COPY_HARD_LINK = &h100
	TSF_COPY_LOCALIZED_NAME = &h200
	TSF_MOVE_AS_COPY_DELETE = &h400
	TSF_SUSPEND_SHELLEVENTS = &h800
end enum

type TRANSFER_SOURCE_FLAGS as DWORD

type ITransferAdviseSink as ITransferAdviseSink_

#if _WIN32_WINNT >= &h0600
	#define __ITransferAdviseSink_INTERFACE_DEFINED__

	type _TRANSFER_ADVISE_STATE as long
	enum
		TS_NONE = &h0
		TS_PERFORMING = &h1
		TS_PREPARING = &h2
		TS_INDETERMINATE = &h4
	end enum

	type TRANSFER_ADVISE_STATE as DWORD
	extern IID_ITransferAdviseSink as const GUID

	type ITransferAdviseSinkVtbl
		QueryInterface as function(byval This as ITransferAdviseSink ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as ITransferAdviseSink ptr) as ULONG
		Release as function(byval This as ITransferAdviseSink ptr) as ULONG
		UpdateProgress as function(byval This as ITransferAdviseSink ptr, byval ullSizeCurrent as ULONGLONG, byval ullSizeTotal as ULONGLONG, byval nFilesCurrent as long, byval nFilesTotal as long, byval nFoldersCurrent as long, byval nFoldersTotal as long) as HRESULT
		UpdateTransferState as function(byval This as ITransferAdviseSink ptr, byval ts as TRANSFER_ADVISE_STATE) as HRESULT
		ConfirmOverwrite as function(byval This as ITransferAdviseSink ptr, byval psiSource as IShellItem ptr, byval psiDestParent as IShellItem ptr, byval pszName as LPCWSTR) as HRESULT
		ConfirmEncryptionLoss as function(byval This as ITransferAdviseSink ptr, byval psiSource as IShellItem ptr) as HRESULT
		FileFailure as function(byval This as ITransferAdviseSink ptr, byval psi as IShellItem ptr, byval pszItem as LPCWSTR, byval hrError as HRESULT, byval pszRename as LPWSTR, byval cchRename as ULONG) as HRESULT
		SubStreamFailure as function(byval This as ITransferAdviseSink ptr, byval psi as IShellItem ptr, byval pszStreamName as LPCWSTR, byval hrError as HRESULT) as HRESULT
		PropertyFailure as function(byval This as ITransferAdviseSink ptr, byval psi as IShellItem ptr, byval pkey as const PROPERTYKEY ptr, byval hrError as HRESULT) as HRESULT
	end type

	type ITransferAdviseSink_
		lpVtbl as ITransferAdviseSinkVtbl ptr
	end type

	#define ITransferAdviseSink_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define ITransferAdviseSink_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define ITransferAdviseSink_Release(This) (This)->lpVtbl->Release(This)
	#define ITransferAdviseSink_UpdateProgress(This, ullSizeCurrent, ullSizeTotal, nFilesCurrent, nFilesTotal, nFoldersCurrent, nFoldersTotal) (This)->lpVtbl->UpdateProgress(This, ullSizeCurrent, ullSizeTotal, nFilesCurrent, nFilesTotal, nFoldersCurrent, nFoldersTotal)
	#define ITransferAdviseSink_UpdateTransferState(This, ts) (This)->lpVtbl->UpdateTransferState(This, ts)
	#define ITransferAdviseSink_ConfirmOverwrite(This, psiSource, psiDestParent, pszName) (This)->lpVtbl->ConfirmOverwrite(This, psiSource, psiDestParent, pszName)
	#define ITransferAdviseSink_ConfirmEncryptionLoss(This, psiSource) (This)->lpVtbl->ConfirmEncryptionLoss(This, psiSource)
	#define ITransferAdviseSink_FileFailure(This, psi, pszItem, hrError, pszRename, cchRename) (This)->lpVtbl->FileFailure(This, psi, pszItem, hrError, pszRename, cchRename)
	#define ITransferAdviseSink_SubStreamFailure(This, psi, pszStreamName, hrError) (This)->lpVtbl->SubStreamFailure(This, psi, pszStreamName, hrError)
	#define ITransferAdviseSink_PropertyFailure(This, psi, pkey, hrError) (This)->lpVtbl->PropertyFailure(This, psi, pkey, hrError)

	declare function ITransferAdviseSink_UpdateProgress_Proxy(byval This as ITransferAdviseSink ptr, byval ullSizeCurrent as ULONGLONG, byval ullSizeTotal as ULONGLONG, byval nFilesCurrent as long, byval nFilesTotal as long, byval nFoldersCurrent as long, byval nFoldersTotal as long) as HRESULT
	declare sub ITransferAdviseSink_UpdateProgress_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function ITransferAdviseSink_UpdateTransferState_Proxy(byval This as ITransferAdviseSink ptr, byval ts as TRANSFER_ADVISE_STATE) as HRESULT
	declare sub ITransferAdviseSink_UpdateTransferState_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function ITransferAdviseSink_ConfirmOverwrite_Proxy(byval This as ITransferAdviseSink ptr, byval psiSource as IShellItem ptr, byval psiDestParent as IShellItem ptr, byval pszName as LPCWSTR) as HRESULT
	declare sub ITransferAdviseSink_ConfirmOverwrite_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function ITransferAdviseSink_ConfirmEncryptionLoss_Proxy(byval This as ITransferAdviseSink ptr, byval psiSource as IShellItem ptr) as HRESULT
	declare sub ITransferAdviseSink_ConfirmEncryptionLoss_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function ITransferAdviseSink_FileFailure_Proxy(byval This as ITransferAdviseSink ptr, byval psi as IShellItem ptr, byval pszItem as LPCWSTR, byval hrError as HRESULT, byval pszRename as LPWSTR, byval cchRename as ULONG) as HRESULT
	declare sub ITransferAdviseSink_FileFailure_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function ITransferAdviseSink_SubStreamFailure_Proxy(byval This as ITransferAdviseSink ptr, byval psi as IShellItem ptr, byval pszStreamName as LPCWSTR, byval hrError as HRESULT) as HRESULT
	declare sub ITransferAdviseSink_SubStreamFailure_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function ITransferAdviseSink_PropertyFailure_Proxy(byval This as ITransferAdviseSink ptr, byval psi as IShellItem ptr, byval pkey as const PROPERTYKEY ptr, byval hrError as HRESULT) as HRESULT
	declare sub ITransferAdviseSink_PropertyFailure_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	#define __ITransferSource_INTERFACE_DEFINED__
	extern IID_ITransferSource as const GUID
	type ITransferSource as ITransferSource_

	type ITransferSourceVtbl
		QueryInterface as function(byval This as ITransferSource ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as ITransferSource ptr) as ULONG
		Release as function(byval This as ITransferSource ptr) as ULONG
		Advise as function(byval This as ITransferSource ptr, byval psink as ITransferAdviseSink ptr, byval pdwCookie as DWORD ptr) as HRESULT
		Unadvise as function(byval This as ITransferSource ptr, byval dwCookie as DWORD) as HRESULT
		SetProperties as function(byval This as ITransferSource ptr, byval pproparray as IPropertyChangeArray ptr) as HRESULT
		OpenItem as function(byval This as ITransferSource ptr, byval psi as IShellItem ptr, byval flags as TRANSFER_SOURCE_FLAGS, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
		MoveItem as function(byval This as ITransferSource ptr, byval psi as IShellItem ptr, byval psiParentDst as IShellItem ptr, byval pszNameDst as LPCWSTR, byval flags as TRANSFER_SOURCE_FLAGS, byval ppsiNew as IShellItem ptr ptr) as HRESULT
		RecycleItem as function(byval This as ITransferSource ptr, byval psiSource as IShellItem ptr, byval psiParentDest as IShellItem ptr, byval flags as TRANSFER_SOURCE_FLAGS, byval ppsiNewDest as IShellItem ptr ptr) as HRESULT
		RemoveItem as function(byval This as ITransferSource ptr, byval psiSource as IShellItem ptr, byval flags as TRANSFER_SOURCE_FLAGS) as HRESULT
		RenameItem as function(byval This as ITransferSource ptr, byval psiSource as IShellItem ptr, byval pszNewName as LPCWSTR, byval flags as TRANSFER_SOURCE_FLAGS, byval ppsiNewDest as IShellItem ptr ptr) as HRESULT
		LinkItem as function(byval This as ITransferSource ptr, byval psiSource as IShellItem ptr, byval psiParentDest as IShellItem ptr, byval pszNewName as LPCWSTR, byval flags as TRANSFER_SOURCE_FLAGS, byval ppsiNewDest as IShellItem ptr ptr) as HRESULT
		ApplyPropertiesToItem as function(byval This as ITransferSource ptr, byval psiSource as IShellItem ptr, byval ppsiNew as IShellItem ptr ptr) as HRESULT
		GetDefaultDestinationName as function(byval This as ITransferSource ptr, byval psiSource as IShellItem ptr, byval psiParentDest as IShellItem ptr, byval ppszDestinationName as LPWSTR ptr) as HRESULT
		EnterFolder as function(byval This as ITransferSource ptr, byval psiChildFolderDest as IShellItem ptr) as HRESULT
		LeaveFolder as function(byval This as ITransferSource ptr, byval psiChildFolderDest as IShellItem ptr) as HRESULT
	end type

	type ITransferSource_
		lpVtbl as ITransferSourceVtbl ptr
	end type

	#define ITransferSource_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define ITransferSource_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define ITransferSource_Release(This) (This)->lpVtbl->Release(This)
	#define ITransferSource_Advise(This, psink, pdwCookie) (This)->lpVtbl->Advise(This, psink, pdwCookie)
	#define ITransferSource_Unadvise(This, dwCookie) (This)->lpVtbl->Unadvise(This, dwCookie)
	#define ITransferSource_SetProperties(This, pproparray) (This)->lpVtbl->SetProperties(This, pproparray)
	#define ITransferSource_OpenItem(This, psi, flags, riid, ppv) (This)->lpVtbl->OpenItem(This, psi, flags, riid, ppv)
	#define ITransferSource_MoveItem(This, psi, psiParentDst, pszNameDst, flags, ppsiNew) (This)->lpVtbl->MoveItem(This, psi, psiParentDst, pszNameDst, flags, ppsiNew)
	#define ITransferSource_RecycleItem(This, psiSource, psiParentDest, flags, ppsiNewDest) (This)->lpVtbl->RecycleItem(This, psiSource, psiParentDest, flags, ppsiNewDest)
	#define ITransferSource_RemoveItem(This, psiSource, flags) (This)->lpVtbl->RemoveItem(This, psiSource, flags)
	#define ITransferSource_RenameItem(This, psiSource, pszNewName, flags, ppsiNewDest) (This)->lpVtbl->RenameItem(This, psiSource, pszNewName, flags, ppsiNewDest)
	#define ITransferSource_LinkItem(This, psiSource, psiParentDest, pszNewName, flags, ppsiNewDest) (This)->lpVtbl->LinkItem(This, psiSource, psiParentDest, pszNewName, flags, ppsiNewDest)
	#define ITransferSource_ApplyPropertiesToItem(This, psiSource, ppsiNew) (This)->lpVtbl->ApplyPropertiesToItem(This, psiSource, ppsiNew)
	#define ITransferSource_GetDefaultDestinationName(This, psiSource, psiParentDest, ppszDestinationName) (This)->lpVtbl->GetDefaultDestinationName(This, psiSource, psiParentDest, ppszDestinationName)
	#define ITransferSource_EnterFolder(This, psiChildFolderDest) (This)->lpVtbl->EnterFolder(This, psiChildFolderDest)
	#define ITransferSource_LeaveFolder(This, psiChildFolderDest) (This)->lpVtbl->LeaveFolder(This, psiChildFolderDest)

	declare function ITransferSource_Advise_Proxy(byval This as ITransferSource ptr, byval psink as ITransferAdviseSink ptr, byval pdwCookie as DWORD ptr) as HRESULT
	declare sub ITransferSource_Advise_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function ITransferSource_Unadvise_Proxy(byval This as ITransferSource ptr, byval dwCookie as DWORD) as HRESULT
	declare sub ITransferSource_Unadvise_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function ITransferSource_SetProperties_Proxy(byval This as ITransferSource ptr, byval pproparray as IPropertyChangeArray ptr) as HRESULT
	declare sub ITransferSource_SetProperties_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function ITransferSource_OpenItem_Proxy(byval This as ITransferSource ptr, byval psi as IShellItem ptr, byval flags as TRANSFER_SOURCE_FLAGS, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	declare sub ITransferSource_OpenItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function ITransferSource_MoveItem_Proxy(byval This as ITransferSource ptr, byval psi as IShellItem ptr, byval psiParentDst as IShellItem ptr, byval pszNameDst as LPCWSTR, byval flags as TRANSFER_SOURCE_FLAGS, byval ppsiNew as IShellItem ptr ptr) as HRESULT
	declare sub ITransferSource_MoveItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function ITransferSource_RecycleItem_Proxy(byval This as ITransferSource ptr, byval psiSource as IShellItem ptr, byval psiParentDest as IShellItem ptr, byval flags as TRANSFER_SOURCE_FLAGS, byval ppsiNewDest as IShellItem ptr ptr) as HRESULT
	declare sub ITransferSource_RecycleItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function ITransferSource_RemoveItem_Proxy(byval This as ITransferSource ptr, byval psiSource as IShellItem ptr, byval flags as TRANSFER_SOURCE_FLAGS) as HRESULT
	declare sub ITransferSource_RemoveItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function ITransferSource_RenameItem_Proxy(byval This as ITransferSource ptr, byval psiSource as IShellItem ptr, byval pszNewName as LPCWSTR, byval flags as TRANSFER_SOURCE_FLAGS, byval ppsiNewDest as IShellItem ptr ptr) as HRESULT
	declare sub ITransferSource_RenameItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function ITransferSource_LinkItem_Proxy(byval This as ITransferSource ptr, byval psiSource as IShellItem ptr, byval psiParentDest as IShellItem ptr, byval pszNewName as LPCWSTR, byval flags as TRANSFER_SOURCE_FLAGS, byval ppsiNewDest as IShellItem ptr ptr) as HRESULT
	declare sub ITransferSource_LinkItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function ITransferSource_ApplyPropertiesToItem_Proxy(byval This as ITransferSource ptr, byval psiSource as IShellItem ptr, byval ppsiNew as IShellItem ptr ptr) as HRESULT
	declare sub ITransferSource_ApplyPropertiesToItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function ITransferSource_GetDefaultDestinationName_Proxy(byval This as ITransferSource ptr, byval psiSource as IShellItem ptr, byval psiParentDest as IShellItem ptr, byval ppszDestinationName as LPWSTR ptr) as HRESULT
	declare sub ITransferSource_GetDefaultDestinationName_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function ITransferSource_EnterFolder_Proxy(byval This as ITransferSource ptr, byval psiChildFolderDest as IShellItem ptr) as HRESULT
	declare sub ITransferSource_EnterFolder_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function ITransferSource_LeaveFolder_Proxy(byval This as ITransferSource ptr, byval psiChildFolderDest as IShellItem ptr) as HRESULT
	declare sub ITransferSource_LeaveFolder_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#endif

type SHELL_ITEM_RESOURCE
	guidType as GUID
	szName as wstring * 260
end type

#define __IEnumResources_INTERFACE_DEFINED__
extern IID_IEnumResources as const GUID
type IEnumResources as IEnumResources_

type IEnumResourcesVtbl
	QueryInterface as function(byval This as IEnumResources ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IEnumResources ptr) as ULONG
	Release as function(byval This as IEnumResources ptr) as ULONG
	Next as function(byval This as IEnumResources ptr, byval celt as ULONG, byval psir as SHELL_ITEM_RESOURCE ptr, byval pceltFetched as ULONG ptr) as HRESULT
	Skip as function(byval This as IEnumResources ptr, byval celt as ULONG) as HRESULT
	Reset as function(byval This as IEnumResources ptr) as HRESULT
	Clone as function(byval This as IEnumResources ptr, byval ppenumr as IEnumResources ptr ptr) as HRESULT
end type

type IEnumResources_
	lpVtbl as IEnumResourcesVtbl ptr
end type

#define IEnumResources_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IEnumResources_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IEnumResources_Release(This) (This)->lpVtbl->Release(This)
#define IEnumResources_Next(This, celt, psir, pceltFetched) (This)->lpVtbl->Next(This, celt, psir, pceltFetched)
#define IEnumResources_Skip(This, celt) (This)->lpVtbl->Skip(This, celt)
#define IEnumResources_Reset(This) (This)->lpVtbl->Reset(This)
#define IEnumResources_Clone(This, ppenumr) (This)->lpVtbl->Clone(This, ppenumr)

declare function IEnumResources_Next_Proxy(byval This as IEnumResources ptr, byval celt as ULONG, byval psir as SHELL_ITEM_RESOURCE ptr, byval pceltFetched as ULONG ptr) as HRESULT
declare sub IEnumResources_Next_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumResources_Skip_Proxy(byval This as IEnumResources ptr, byval celt as ULONG) as HRESULT
declare sub IEnumResources_Skip_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumResources_Reset_Proxy(byval This as IEnumResources ptr) as HRESULT
declare sub IEnumResources_Reset_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumResources_Clone_Proxy(byval This as IEnumResources ptr, byval ppenumr as IEnumResources ptr ptr) as HRESULT
declare sub IEnumResources_Clone_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IShellItemResources_INTERFACE_DEFINED__
extern IID_IShellItemResources as const GUID
type IShellItemResources as IShellItemResources_

type IShellItemResourcesVtbl
	QueryInterface as function(byval This as IShellItemResources ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IShellItemResources ptr) as ULONG
	Release as function(byval This as IShellItemResources ptr) as ULONG
	GetAttributes as function(byval This as IShellItemResources ptr, byval pdwAttributes as DWORD ptr) as HRESULT
	GetSize as function(byval This as IShellItemResources ptr, byval pullSize as ULONGLONG ptr) as HRESULT
	GetTimes as function(byval This as IShellItemResources ptr, byval pftCreation as FILETIME ptr, byval pftWrite as FILETIME ptr, byval pftAccess as FILETIME ptr) as HRESULT
	SetTimes as function(byval This as IShellItemResources ptr, byval pftCreation as const FILETIME ptr, byval pftWrite as const FILETIME ptr, byval pftAccess as const FILETIME ptr) as HRESULT
	GetResourceDescription as function(byval This as IShellItemResources ptr, byval pcsir as const SHELL_ITEM_RESOURCE ptr, byval ppszDescription as LPWSTR ptr) as HRESULT
	EnumResources as function(byval This as IShellItemResources ptr, byval ppenumr as IEnumResources ptr ptr) as HRESULT
	SupportsResource as function(byval This as IShellItemResources ptr, byval pcsir as const SHELL_ITEM_RESOURCE ptr) as HRESULT
	OpenResource as function(byval This as IShellItemResources ptr, byval pcsir as const SHELL_ITEM_RESOURCE ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	CreateResource as function(byval This as IShellItemResources ptr, byval pcsir as const SHELL_ITEM_RESOURCE ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	MarkForDelete as function(byval This as IShellItemResources ptr) as HRESULT
end type

type IShellItemResources_
	lpVtbl as IShellItemResourcesVtbl ptr
end type

#define IShellItemResources_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IShellItemResources_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IShellItemResources_Release(This) (This)->lpVtbl->Release(This)
#define IShellItemResources_GetAttributes(This, pdwAttributes) (This)->lpVtbl->GetAttributes(This, pdwAttributes)
#define IShellItemResources_GetSize(This, pullSize) (This)->lpVtbl->GetSize(This, pullSize)
#define IShellItemResources_GetTimes(This, pftCreation, pftWrite, pftAccess) (This)->lpVtbl->GetTimes(This, pftCreation, pftWrite, pftAccess)
#define IShellItemResources_SetTimes(This, pftCreation, pftWrite, pftAccess) (This)->lpVtbl->SetTimes(This, pftCreation, pftWrite, pftAccess)
#define IShellItemResources_GetResourceDescription(This, pcsir, ppszDescription) (This)->lpVtbl->GetResourceDescription(This, pcsir, ppszDescription)
#define IShellItemResources_EnumResources(This, ppenumr) (This)->lpVtbl->EnumResources(This, ppenumr)
#define IShellItemResources_SupportsResource(This, pcsir) (This)->lpVtbl->SupportsResource(This, pcsir)
#define IShellItemResources_OpenResource(This, pcsir, riid, ppv) (This)->lpVtbl->OpenResource(This, pcsir, riid, ppv)
#define IShellItemResources_CreateResource(This, pcsir, riid, ppv) (This)->lpVtbl->CreateResource(This, pcsir, riid, ppv)
#define IShellItemResources_MarkForDelete(This) (This)->lpVtbl->MarkForDelete(This)

declare function IShellItemResources_GetAttributes_Proxy(byval This as IShellItemResources ptr, byval pdwAttributes as DWORD ptr) as HRESULT
declare sub IShellItemResources_GetAttributes_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellItemResources_GetSize_Proxy(byval This as IShellItemResources ptr, byval pullSize as ULONGLONG ptr) as HRESULT
declare sub IShellItemResources_GetSize_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellItemResources_GetTimes_Proxy(byval This as IShellItemResources ptr, byval pftCreation as FILETIME ptr, byval pftWrite as FILETIME ptr, byval pftAccess as FILETIME ptr) as HRESULT
declare sub IShellItemResources_GetTimes_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellItemResources_SetTimes_Proxy(byval This as IShellItemResources ptr, byval pftCreation as const FILETIME ptr, byval pftWrite as const FILETIME ptr, byval pftAccess as const FILETIME ptr) as HRESULT
declare sub IShellItemResources_SetTimes_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellItemResources_GetResourceDescription_Proxy(byval This as IShellItemResources ptr, byval pcsir as const SHELL_ITEM_RESOURCE ptr, byval ppszDescription as LPWSTR ptr) as HRESULT
declare sub IShellItemResources_GetResourceDescription_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellItemResources_EnumResources_Proxy(byval This as IShellItemResources ptr, byval ppenumr as IEnumResources ptr ptr) as HRESULT
declare sub IShellItemResources_EnumResources_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellItemResources_SupportsResource_Proxy(byval This as IShellItemResources ptr, byval pcsir as const SHELL_ITEM_RESOURCE ptr) as HRESULT
declare sub IShellItemResources_SupportsResource_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellItemResources_OpenResource_Proxy(byval This as IShellItemResources ptr, byval pcsir as const SHELL_ITEM_RESOURCE ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare sub IShellItemResources_OpenResource_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellItemResources_CreateResource_Proxy(byval This as IShellItemResources ptr, byval pcsir as const SHELL_ITEM_RESOURCE ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare sub IShellItemResources_CreateResource_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellItemResources_MarkForDelete_Proxy(byval This as IShellItemResources ptr) as HRESULT
declare sub IShellItemResources_MarkForDelete_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __ITransferDestination_INTERFACE_DEFINED__
extern IID_ITransferDestination as const GUID
type ITransferDestination as ITransferDestination_

type ITransferDestinationVtbl
	QueryInterface as function(byval This as ITransferDestination ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ITransferDestination ptr) as ULONG
	Release as function(byval This as ITransferDestination ptr) as ULONG
	Advise as function(byval This as ITransferDestination ptr, byval psink as ITransferAdviseSink ptr, byval pdwCookie as DWORD ptr) as HRESULT
	Unadvise as function(byval This as ITransferDestination ptr, byval dwCookie as DWORD) as HRESULT
	CreateItem as function(byval This as ITransferDestination ptr, byval pszName as LPCWSTR, byval dwAttributes as DWORD, byval ullSize as ULONGLONG, byval flags as TRANSFER_SOURCE_FLAGS, byval riidItem as const IID const ptr, byval ppvItem as any ptr ptr, byval riidResources as const IID const ptr, byval ppvResources as any ptr ptr) as HRESULT
end type

type ITransferDestination_
	lpVtbl as ITransferDestinationVtbl ptr
end type

#define ITransferDestination_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define ITransferDestination_AddRef(This) (This)->lpVtbl->AddRef(This)
#define ITransferDestination_Release(This) (This)->lpVtbl->Release(This)
#define ITransferDestination_Advise(This, psink, pdwCookie) (This)->lpVtbl->Advise(This, psink, pdwCookie)
#define ITransferDestination_Unadvise(This, dwCookie) (This)->lpVtbl->Unadvise(This, dwCookie)
#define ITransferDestination_CreateItem(This, pszName, dwAttributes, ullSize, flags, riidItem, ppvItem, riidResources, ppvResources) (This)->lpVtbl->CreateItem(This, pszName, dwAttributes, ullSize, flags, riidItem, ppvItem, riidResources, ppvResources)

declare function ITransferDestination_Advise_Proxy(byval This as ITransferDestination ptr, byval psink as ITransferAdviseSink ptr, byval pdwCookie as DWORD ptr) as HRESULT
declare sub ITransferDestination_Advise_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITransferDestination_Unadvise_Proxy(byval This as ITransferDestination ptr, byval dwCookie as DWORD) as HRESULT
declare sub ITransferDestination_Unadvise_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITransferDestination_CreateItem_Proxy(byval This as ITransferDestination ptr, byval pszName as LPCWSTR, byval dwAttributes as DWORD, byval ullSize as ULONGLONG, byval flags as TRANSFER_SOURCE_FLAGS, byval riidItem as const IID const ptr, byval ppvItem as any ptr ptr, byval riidResources as const IID const ptr, byval ppvResources as any ptr ptr) as HRESULT
declare sub ITransferDestination_CreateItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IStreamAsync_INTERFACE_DEFINED__
extern IID_IStreamAsync as const GUID
type IStreamAsync as IStreamAsync_

type IStreamAsyncVtbl
	QueryInterface as function(byval This as IStreamAsync ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IStreamAsync ptr) as ULONG
	Release as function(byval This as IStreamAsync ptr) as ULONG
	Read as function(byval This as IStreamAsync ptr, byval pv as any ptr, byval cb as ULONG, byval pcbRead as ULONG ptr) as HRESULT
	Write as function(byval This as IStreamAsync ptr, byval pv as const any ptr, byval cb as ULONG, byval pcbWritten as ULONG ptr) as HRESULT
	Seek as function(byval This as IStreamAsync ptr, byval dlibMove as LARGE_INTEGER, byval dwOrigin as DWORD, byval plibNewPosition as ULARGE_INTEGER ptr) as HRESULT
	SetSize as function(byval This as IStreamAsync ptr, byval libNewSize as ULARGE_INTEGER) as HRESULT
	CopyTo as function(byval This as IStreamAsync ptr, byval pstm as IStream ptr, byval cb as ULARGE_INTEGER, byval pcbRead as ULARGE_INTEGER ptr, byval pcbWritten as ULARGE_INTEGER ptr) as HRESULT
	Commit as function(byval This as IStreamAsync ptr, byval grfCommitFlags as DWORD) as HRESULT
	Revert as function(byval This as IStreamAsync ptr) as HRESULT
	LockRegion as function(byval This as IStreamAsync ptr, byval libOffset as ULARGE_INTEGER, byval cb as ULARGE_INTEGER, byval dwLockType as DWORD) as HRESULT
	UnlockRegion as function(byval This as IStreamAsync ptr, byval libOffset as ULARGE_INTEGER, byval cb as ULARGE_INTEGER, byval dwLockType as DWORD) as HRESULT
	Stat as function(byval This as IStreamAsync ptr, byval pstatstg as STATSTG ptr, byval grfStatFlag as DWORD) as HRESULT
	Clone as function(byval This as IStreamAsync ptr, byval ppstm as IStream ptr ptr) as HRESULT
	ReadAsync as function(byval This as IStreamAsync ptr, byval pv as any ptr, byval cb as DWORD, byval pcbRead as LPDWORD, byval lpOverlapped as LPOVERLAPPED) as HRESULT
	WriteAsync as function(byval This as IStreamAsync ptr, byval lpBuffer as const any ptr, byval cb as DWORD, byval pcbWritten as LPDWORD, byval lpOverlapped as LPOVERLAPPED) as HRESULT
	OverlappedResult as function(byval This as IStreamAsync ptr, byval lpOverlapped as LPOVERLAPPED, byval lpNumberOfBytesTransferred as LPDWORD, byval bWait as WINBOOL) as HRESULT
	CancelIo as function(byval This as IStreamAsync ptr) as HRESULT
end type

type IStreamAsync_
	lpVtbl as IStreamAsyncVtbl ptr
end type

#define IStreamAsync_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IStreamAsync_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IStreamAsync_Release(This) (This)->lpVtbl->Release(This)
#define IStreamAsync_Read(This, pv, cb, pcbRead) (This)->lpVtbl->Read(This, pv, cb, pcbRead)
#define IStreamAsync_Write(This, pv, cb, pcbWritten) (This)->lpVtbl->Write(This, pv, cb, pcbWritten)
#define IStreamAsync_Seek(This, dlibMove, dwOrigin, plibNewPosition) (This)->lpVtbl->Seek(This, dlibMove, dwOrigin, plibNewPosition)
#define IStreamAsync_SetSize(This, libNewSize) (This)->lpVtbl->SetSize(This, libNewSize)
#define IStreamAsync_CopyTo(This, pstm, cb, pcbRead, pcbWritten) (This)->lpVtbl->CopyTo(This, pstm, cb, pcbRead, pcbWritten)
#define IStreamAsync_Commit(This, grfCommitFlags) (This)->lpVtbl->Commit(This, grfCommitFlags)
#define IStreamAsync_Revert(This) (This)->lpVtbl->Revert(This)
#define IStreamAsync_LockRegion(This, libOffset, cb, dwLockType) (This)->lpVtbl->LockRegion(This, libOffset, cb, dwLockType)
#define IStreamAsync_UnlockRegion(This, libOffset, cb, dwLockType) (This)->lpVtbl->UnlockRegion(This, libOffset, cb, dwLockType)
#define IStreamAsync_Stat(This, pstatstg, grfStatFlag) (This)->lpVtbl->Stat(This, pstatstg, grfStatFlag)
#define IStreamAsync_Clone(This, ppstm) (This)->lpVtbl->Clone(This, ppstm)
#define IStreamAsync_ReadAsync(This, pv, cb, pcbRead, lpOverlapped) (This)->lpVtbl->ReadAsync(This, pv, cb, pcbRead, lpOverlapped)
#define IStreamAsync_WriteAsync(This, lpBuffer, cb, pcbWritten, lpOverlapped) (This)->lpVtbl->WriteAsync(This, lpBuffer, cb, pcbWritten, lpOverlapped)
#define IStreamAsync_OverlappedResult(This, lpOverlapped, lpNumberOfBytesTransferred, bWait) (This)->lpVtbl->OverlappedResult(This, lpOverlapped, lpNumberOfBytesTransferred, bWait)
#define IStreamAsync_CancelIo(This) (This)->lpVtbl->CancelIo(This)

declare function IStreamAsync_ReadAsync_Proxy(byval This as IStreamAsync ptr, byval pv as any ptr, byval cb as DWORD, byval pcbRead as LPDWORD, byval lpOverlapped as LPOVERLAPPED) as HRESULT
declare sub IStreamAsync_ReadAsync_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IStreamAsync_WriteAsync_Proxy(byval This as IStreamAsync ptr, byval lpBuffer as const any ptr, byval cb as DWORD, byval pcbWritten as LPDWORD, byval lpOverlapped as LPOVERLAPPED) as HRESULT
declare sub IStreamAsync_WriteAsync_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IStreamAsync_OverlappedResult_Proxy(byval This as IStreamAsync ptr, byval lpOverlapped as LPOVERLAPPED, byval lpNumberOfBytesTransferred as LPDWORD, byval bWait as WINBOOL) as HRESULT
declare sub IStreamAsync_OverlappedResult_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IStreamAsync_CancelIo_Proxy(byval This as IStreamAsync ptr) as HRESULT
declare sub IStreamAsync_CancelIo_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IStreamUnbufferedInfo_INTERFACE_DEFINED__
extern IID_IStreamUnbufferedInfo as const GUID
type IStreamUnbufferedInfo as IStreamUnbufferedInfo_

type IStreamUnbufferedInfoVtbl
	QueryInterface as function(byval This as IStreamUnbufferedInfo ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IStreamUnbufferedInfo ptr) as ULONG
	Release as function(byval This as IStreamUnbufferedInfo ptr) as ULONG
	GetSectorSize as function(byval This as IStreamUnbufferedInfo ptr, byval pcbSectorSize as ULONG ptr) as HRESULT
end type

type IStreamUnbufferedInfo_
	lpVtbl as IStreamUnbufferedInfoVtbl ptr
end type

#define IStreamUnbufferedInfo_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IStreamUnbufferedInfo_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IStreamUnbufferedInfo_Release(This) (This)->lpVtbl->Release(This)
#define IStreamUnbufferedInfo_GetSectorSize(This, pcbSectorSize) (This)->lpVtbl->GetSectorSize(This, pcbSectorSize)
declare function IStreamUnbufferedInfo_GetSectorSize_Proxy(byval This as IStreamUnbufferedInfo ptr, byval pcbSectorSize as ULONG ptr) as HRESULT
declare sub IStreamUnbufferedInfo_GetSectorSize_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#if _WIN32_WINNT >= &h0600
	#define __IFileOperationProgressSink_INTERFACE_DEFINED__
	extern IID_IFileOperationProgressSink as const GUID
	type IFileOperationProgressSink as IFileOperationProgressSink_

	type IFileOperationProgressSinkVtbl
		QueryInterface as function(byval This as IFileOperationProgressSink ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IFileOperationProgressSink ptr) as ULONG
		Release as function(byval This as IFileOperationProgressSink ptr) as ULONG
		StartOperations as function(byval This as IFileOperationProgressSink ptr) as HRESULT
		FinishOperations as function(byval This as IFileOperationProgressSink ptr, byval hrResult as HRESULT) as HRESULT
		PreRenameItem as function(byval This as IFileOperationProgressSink ptr, byval dwFlags as DWORD, byval psiItem as IShellItem ptr, byval pszNewName as LPCWSTR) as HRESULT
		PostRenameItem as function(byval This as IFileOperationProgressSink ptr, byval dwFlags as DWORD, byval psiItem as IShellItem ptr, byval pszNewName as LPCWSTR, byval hrRename as HRESULT, byval psiNewlyCreated as IShellItem ptr) as HRESULT
		PreMoveItem as function(byval This as IFileOperationProgressSink ptr, byval dwFlags as DWORD, byval psiItem as IShellItem ptr, byval psiDestinationFolder as IShellItem ptr, byval pszNewName as LPCWSTR) as HRESULT
		PostMoveItem as function(byval This as IFileOperationProgressSink ptr, byval dwFlags as DWORD, byval psiItem as IShellItem ptr, byval psiDestinationFolder as IShellItem ptr, byval pszNewName as LPCWSTR, byval hrMove as HRESULT, byval psiNewlyCreated as IShellItem ptr) as HRESULT
		PreCopyItem as function(byval This as IFileOperationProgressSink ptr, byval dwFlags as DWORD, byval psiItem as IShellItem ptr, byval psiDestinationFolder as IShellItem ptr, byval pszNewName as LPCWSTR) as HRESULT
		PostCopyItem as function(byval This as IFileOperationProgressSink ptr, byval dwFlags as DWORD, byval psiItem as IShellItem ptr, byval psiDestinationFolder as IShellItem ptr, byval pszNewName as LPCWSTR, byval hrCopy as HRESULT, byval psiNewlyCreated as IShellItem ptr) as HRESULT
		PreDeleteItem as function(byval This as IFileOperationProgressSink ptr, byval dwFlags as DWORD, byval psiItem as IShellItem ptr) as HRESULT
		PostDeleteItem as function(byval This as IFileOperationProgressSink ptr, byval dwFlags as DWORD, byval psiItem as IShellItem ptr, byval hrDelete as HRESULT, byval psiNewlyCreated as IShellItem ptr) as HRESULT
		PreNewItem as function(byval This as IFileOperationProgressSink ptr, byval dwFlags as DWORD, byval psiDestinationFolder as IShellItem ptr, byval pszNewName as LPCWSTR) as HRESULT
		PostNewItem as function(byval This as IFileOperationProgressSink ptr, byval dwFlags as DWORD, byval psiDestinationFolder as IShellItem ptr, byval pszNewName as LPCWSTR, byval pszTemplateName as LPCWSTR, byval dwFileAttributes as DWORD, byval hrNew as HRESULT, byval psiNewItem as IShellItem ptr) as HRESULT
		UpdateProgress as function(byval This as IFileOperationProgressSink ptr, byval iWorkTotal as UINT, byval iWorkSoFar as UINT) as HRESULT
		ResetTimer as function(byval This as IFileOperationProgressSink ptr) as HRESULT
		PauseTimer as function(byval This as IFileOperationProgressSink ptr) as HRESULT
		ResumeTimer as function(byval This as IFileOperationProgressSink ptr) as HRESULT
	end type

	type IFileOperationProgressSink_
		lpVtbl as IFileOperationProgressSinkVtbl ptr
	end type

	#define IFileOperationProgressSink_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IFileOperationProgressSink_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IFileOperationProgressSink_Release(This) (This)->lpVtbl->Release(This)
	#define IFileOperationProgressSink_StartOperations(This) (This)->lpVtbl->StartOperations(This)
	#define IFileOperationProgressSink_FinishOperations(This, hrResult) (This)->lpVtbl->FinishOperations(This, hrResult)
	#define IFileOperationProgressSink_PreRenameItem(This, dwFlags, psiItem, pszNewName) (This)->lpVtbl->PreRenameItem(This, dwFlags, psiItem, pszNewName)
	#define IFileOperationProgressSink_PostRenameItem(This, dwFlags, psiItem, pszNewName, hrRename, psiNewlyCreated) (This)->lpVtbl->PostRenameItem(This, dwFlags, psiItem, pszNewName, hrRename, psiNewlyCreated)
	#define IFileOperationProgressSink_PreMoveItem(This, dwFlags, psiItem, psiDestinationFolder, pszNewName) (This)->lpVtbl->PreMoveItem(This, dwFlags, psiItem, psiDestinationFolder, pszNewName)
	#define IFileOperationProgressSink_PostMoveItem(This, dwFlags, psiItem, psiDestinationFolder, pszNewName, hrMove, psiNewlyCreated) (This)->lpVtbl->PostMoveItem(This, dwFlags, psiItem, psiDestinationFolder, pszNewName, hrMove, psiNewlyCreated)
	#define IFileOperationProgressSink_PreCopyItem(This, dwFlags, psiItem, psiDestinationFolder, pszNewName) (This)->lpVtbl->PreCopyItem(This, dwFlags, psiItem, psiDestinationFolder, pszNewName)
	#define IFileOperationProgressSink_PostCopyItem(This, dwFlags, psiItem, psiDestinationFolder, pszNewName, hrCopy, psiNewlyCreated) (This)->lpVtbl->PostCopyItem(This, dwFlags, psiItem, psiDestinationFolder, pszNewName, hrCopy, psiNewlyCreated)
	#define IFileOperationProgressSink_PreDeleteItem(This, dwFlags, psiItem) (This)->lpVtbl->PreDeleteItem(This, dwFlags, psiItem)
	#define IFileOperationProgressSink_PostDeleteItem(This, dwFlags, psiItem, hrDelete, psiNewlyCreated) (This)->lpVtbl->PostDeleteItem(This, dwFlags, psiItem, hrDelete, psiNewlyCreated)
	#define IFileOperationProgressSink_PreNewItem(This, dwFlags, psiDestinationFolder, pszNewName) (This)->lpVtbl->PreNewItem(This, dwFlags, psiDestinationFolder, pszNewName)
	#define IFileOperationProgressSink_PostNewItem(This, dwFlags, psiDestinationFolder, pszNewName, pszTemplateName, dwFileAttributes, hrNew, psiNewItem) (This)->lpVtbl->PostNewItem(This, dwFlags, psiDestinationFolder, pszNewName, pszTemplateName, dwFileAttributes, hrNew, psiNewItem)
	#define IFileOperationProgressSink_UpdateProgress(This, iWorkTotal, iWorkSoFar) (This)->lpVtbl->UpdateProgress(This, iWorkTotal, iWorkSoFar)
	#define IFileOperationProgressSink_ResetTimer(This) (This)->lpVtbl->ResetTimer(This)
	#define IFileOperationProgressSink_PauseTimer(This) (This)->lpVtbl->PauseTimer(This)
	#define IFileOperationProgressSink_ResumeTimer(This) (This)->lpVtbl->ResumeTimer(This)

	declare function IFileOperationProgressSink_StartOperations_Proxy(byval This as IFileOperationProgressSink ptr) as HRESULT
	declare sub IFileOperationProgressSink_StartOperations_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileOperationProgressSink_FinishOperations_Proxy(byval This as IFileOperationProgressSink ptr, byval hrResult as HRESULT) as HRESULT
	declare sub IFileOperationProgressSink_FinishOperations_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileOperationProgressSink_PreRenameItem_Proxy(byval This as IFileOperationProgressSink ptr, byval dwFlags as DWORD, byval psiItem as IShellItem ptr, byval pszNewName as LPCWSTR) as HRESULT
	declare sub IFileOperationProgressSink_PreRenameItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileOperationProgressSink_PostRenameItem_Proxy(byval This as IFileOperationProgressSink ptr, byval dwFlags as DWORD, byval psiItem as IShellItem ptr, byval pszNewName as LPCWSTR, byval hrRename as HRESULT, byval psiNewlyCreated as IShellItem ptr) as HRESULT
	declare sub IFileOperationProgressSink_PostRenameItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileOperationProgressSink_PreMoveItem_Proxy(byval This as IFileOperationProgressSink ptr, byval dwFlags as DWORD, byval psiItem as IShellItem ptr, byval psiDestinationFolder as IShellItem ptr, byval pszNewName as LPCWSTR) as HRESULT
	declare sub IFileOperationProgressSink_PreMoveItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileOperationProgressSink_PostMoveItem_Proxy(byval This as IFileOperationProgressSink ptr, byval dwFlags as DWORD, byval psiItem as IShellItem ptr, byval psiDestinationFolder as IShellItem ptr, byval pszNewName as LPCWSTR, byval hrMove as HRESULT, byval psiNewlyCreated as IShellItem ptr) as HRESULT
	declare sub IFileOperationProgressSink_PostMoveItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileOperationProgressSink_PreCopyItem_Proxy(byval This as IFileOperationProgressSink ptr, byval dwFlags as DWORD, byval psiItem as IShellItem ptr, byval psiDestinationFolder as IShellItem ptr, byval pszNewName as LPCWSTR) as HRESULT
	declare sub IFileOperationProgressSink_PreCopyItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileOperationProgressSink_PostCopyItem_Proxy(byval This as IFileOperationProgressSink ptr, byval dwFlags as DWORD, byval psiItem as IShellItem ptr, byval psiDestinationFolder as IShellItem ptr, byval pszNewName as LPCWSTR, byval hrCopy as HRESULT, byval psiNewlyCreated as IShellItem ptr) as HRESULT
	declare sub IFileOperationProgressSink_PostCopyItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileOperationProgressSink_PreDeleteItem_Proxy(byval This as IFileOperationProgressSink ptr, byval dwFlags as DWORD, byval psiItem as IShellItem ptr) as HRESULT
	declare sub IFileOperationProgressSink_PreDeleteItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileOperationProgressSink_PostDeleteItem_Proxy(byval This as IFileOperationProgressSink ptr, byval dwFlags as DWORD, byval psiItem as IShellItem ptr, byval hrDelete as HRESULT, byval psiNewlyCreated as IShellItem ptr) as HRESULT
	declare sub IFileOperationProgressSink_PostDeleteItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileOperationProgressSink_PreNewItem_Proxy(byval This as IFileOperationProgressSink ptr, byval dwFlags as DWORD, byval psiDestinationFolder as IShellItem ptr, byval pszNewName as LPCWSTR) as HRESULT
	declare sub IFileOperationProgressSink_PreNewItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileOperationProgressSink_PostNewItem_Proxy(byval This as IFileOperationProgressSink ptr, byval dwFlags as DWORD, byval psiDestinationFolder as IShellItem ptr, byval pszNewName as LPCWSTR, byval pszTemplateName as LPCWSTR, byval dwFileAttributes as DWORD, byval hrNew as HRESULT, byval psiNewItem as IShellItem ptr) as HRESULT
	declare sub IFileOperationProgressSink_PostNewItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileOperationProgressSink_UpdateProgress_Proxy(byval This as IFileOperationProgressSink ptr, byval iWorkTotal as UINT, byval iWorkSoFar as UINT) as HRESULT
	declare sub IFileOperationProgressSink_UpdateProgress_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileOperationProgressSink_ResetTimer_Proxy(byval This as IFileOperationProgressSink ptr) as HRESULT
	declare sub IFileOperationProgressSink_ResetTimer_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileOperationProgressSink_PauseTimer_Proxy(byval This as IFileOperationProgressSink ptr) as HRESULT
	declare sub IFileOperationProgressSink_PauseTimer_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileOperationProgressSink_ResumeTimer_Proxy(byval This as IFileOperationProgressSink ptr) as HRESULT
	declare sub IFileOperationProgressSink_ResumeTimer_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#endif

#define __IShellItemArray_INTERFACE_DEFINED__

type SIATTRIBFLAGS as long
enum
	SIATTRIBFLAGS_AND = &h1
	SIATTRIBFLAGS_OR = &h2
	SIATTRIBFLAGS_APPCOMPAT = &h3
	SIATTRIBFLAGS_MASK = &h3
	SIATTRIBFLAGS_ALLITEMS = &h4000
end enum

extern IID_IShellItemArray as const GUID

#if _WIN32_WINNT <= &h0502
	type IShellItemArray as IShellItemArray_
#endif

type IShellItemArrayVtbl
	QueryInterface as function(byval This as IShellItemArray ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IShellItemArray ptr) as ULONG
	Release as function(byval This as IShellItemArray ptr) as ULONG
	BindToHandler as function(byval This as IShellItemArray ptr, byval pbc as IBindCtx ptr, byval bhid as const GUID const ptr, byval riid as const IID const ptr, byval ppvOut as any ptr ptr) as HRESULT
	GetPropertyStore as function(byval This as IShellItemArray ptr, byval flags as GETPROPERTYSTOREFLAGS, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	GetPropertyDescriptionList as function(byval This as IShellItemArray ptr, byval keyType as const PROPERTYKEY const ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	GetAttributes as function(byval This as IShellItemArray ptr, byval AttribFlags as SIATTRIBFLAGS, byval sfgaoMask as SFGAOF, byval psfgaoAttribs as SFGAOF ptr) as HRESULT
	GetCount as function(byval This as IShellItemArray ptr, byval pdwNumItems as DWORD ptr) as HRESULT
	GetItemAt as function(byval This as IShellItemArray ptr, byval dwIndex as DWORD, byval ppsi as IShellItem ptr ptr) as HRESULT
	EnumItems as function(byval This as IShellItemArray ptr, byval ppenumShellItems as IEnumShellItems ptr ptr) as HRESULT
end type

type IShellItemArray_
	lpVtbl as IShellItemArrayVtbl ptr
end type

#define IShellItemArray_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IShellItemArray_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IShellItemArray_Release(This) (This)->lpVtbl->Release(This)
#define IShellItemArray_BindToHandler(This, pbc, bhid, riid, ppvOut) (This)->lpVtbl->BindToHandler(This, pbc, bhid, riid, ppvOut)
#define IShellItemArray_GetPropertyStore(This, flags, riid, ppv) (This)->lpVtbl->GetPropertyStore(This, flags, riid, ppv)
#define IShellItemArray_GetPropertyDescriptionList(This, keyType, riid, ppv) (This)->lpVtbl->GetPropertyDescriptionList(This, keyType, riid, ppv)
#define IShellItemArray_GetAttributes(This, AttribFlags, sfgaoMask, psfgaoAttribs) (This)->lpVtbl->GetAttributes(This, AttribFlags, sfgaoMask, psfgaoAttribs)
#define IShellItemArray_GetCount(This, pdwNumItems) (This)->lpVtbl->GetCount(This, pdwNumItems)
#define IShellItemArray_GetItemAt(This, dwIndex, ppsi) (This)->lpVtbl->GetItemAt(This, dwIndex, ppsi)
#define IShellItemArray_EnumItems(This, ppenumShellItems) (This)->lpVtbl->EnumItems(This, ppenumShellItems)

declare function IShellItemArray_BindToHandler_Proxy(byval This as IShellItemArray ptr, byval pbc as IBindCtx ptr, byval bhid as const GUID const ptr, byval riid as const IID const ptr, byval ppvOut as any ptr ptr) as HRESULT
declare sub IShellItemArray_BindToHandler_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellItemArray_GetPropertyStore_Proxy(byval This as IShellItemArray ptr, byval flags as GETPROPERTYSTOREFLAGS, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare sub IShellItemArray_GetPropertyStore_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellItemArray_GetPropertyDescriptionList_Proxy(byval This as IShellItemArray ptr, byval keyType as const PROPERTYKEY const ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare sub IShellItemArray_GetPropertyDescriptionList_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellItemArray_GetAttributes_Proxy(byval This as IShellItemArray ptr, byval AttribFlags as SIATTRIBFLAGS, byval sfgaoMask as SFGAOF, byval psfgaoAttribs as SFGAOF ptr) as HRESULT
declare sub IShellItemArray_GetAttributes_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellItemArray_GetCount_Proxy(byval This as IShellItemArray ptr, byval pdwNumItems as DWORD ptr) as HRESULT
declare sub IShellItemArray_GetCount_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellItemArray_GetItemAt_Proxy(byval This as IShellItemArray ptr, byval dwIndex as DWORD, byval ppsi as IShellItem ptr ptr) as HRESULT
declare sub IShellItemArray_GetItemAt_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellItemArray_EnumItems_Proxy(byval This as IShellItemArray ptr, byval ppenumShellItems as IEnumShellItems ptr ptr) as HRESULT
declare sub IShellItemArray_EnumItems_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#if _WIN32_WINNT >= &h0600
	declare function SHCreateShellItemArray(byval pidlParent as LPCITEMIDLIST, byval psf as IShellFolder ptr, byval cidl as UINT, byval ppidl as LPCITEMIDLIST ptr, byval ppsiItemArray as IShellItemArray ptr ptr) as HRESULT
	declare function SHCreateShellItemArrayFromDataObject(byval pdo as IDataObject ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	declare function SHCreateShellItemArrayFromIDLists(byval cidl as UINT, byval rgpidl as LPCITEMIDLIST ptr, byval ppsiItemArray as IShellItemArray ptr ptr) as HRESULT
	declare function SHCreateShellItemArrayFromShellItem(byval psi as IShellItem ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
#endif

#define __IInitializeWithItem_INTERFACE_DEFINED__
extern IID_IInitializeWithItem as const GUID
type IInitializeWithItem as IInitializeWithItem_

type IInitializeWithItemVtbl
	QueryInterface as function(byval This as IInitializeWithItem ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IInitializeWithItem ptr) as ULONG
	Release as function(byval This as IInitializeWithItem ptr) as ULONG
	Initialize as function(byval This as IInitializeWithItem ptr, byval psi as IShellItem ptr, byval grfMode as DWORD) as HRESULT
end type

type IInitializeWithItem_
	lpVtbl as IInitializeWithItemVtbl ptr
end type

#define IInitializeWithItem_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IInitializeWithItem_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IInitializeWithItem_Release(This) (This)->lpVtbl->Release(This)
#define IInitializeWithItem_Initialize(This, psi, grfMode) (This)->lpVtbl->Initialize(This, psi, grfMode)
declare function IInitializeWithItem_Initialize_Proxy(byval This as IInitializeWithItem ptr, byval psi as IShellItem ptr, byval grfMode as DWORD) as HRESULT
declare sub IInitializeWithItem_Initialize_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IObjectWithSelection_INTERFACE_DEFINED__
extern IID_IObjectWithSelection as const GUID
type IObjectWithSelection as IObjectWithSelection_

type IObjectWithSelectionVtbl
	QueryInterface as function(byval This as IObjectWithSelection ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IObjectWithSelection ptr) as ULONG
	Release as function(byval This as IObjectWithSelection ptr) as ULONG
	SetSelection as function(byval This as IObjectWithSelection ptr, byval psia as IShellItemArray ptr) as HRESULT
	GetSelection as function(byval This as IObjectWithSelection ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
end type

type IObjectWithSelection_
	lpVtbl as IObjectWithSelectionVtbl ptr
end type

#define IObjectWithSelection_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IObjectWithSelection_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IObjectWithSelection_Release(This) (This)->lpVtbl->Release(This)
#define IObjectWithSelection_SetSelection(This, psia) (This)->lpVtbl->SetSelection(This, psia)
#define IObjectWithSelection_GetSelection(This, riid, ppv) (This)->lpVtbl->GetSelection(This, riid, ppv)

declare function IObjectWithSelection_SetSelection_Proxy(byval This as IObjectWithSelection ptr, byval psia as IShellItemArray ptr) as HRESULT
declare sub IObjectWithSelection_SetSelection_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IObjectWithSelection_GetSelection_Proxy(byval This as IObjectWithSelection ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare sub IObjectWithSelection_GetSelection_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IObjectWithBackReferences_INTERFACE_DEFINED__
extern IID_IObjectWithBackReferences as const GUID
type IObjectWithBackReferences as IObjectWithBackReferences_

type IObjectWithBackReferencesVtbl
	QueryInterface as function(byval This as IObjectWithBackReferences ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IObjectWithBackReferences ptr) as ULONG
	Release as function(byval This as IObjectWithBackReferences ptr) as ULONG
	RemoveBackReferences as function(byval This as IObjectWithBackReferences ptr) as HRESULT
end type

type IObjectWithBackReferences_
	lpVtbl as IObjectWithBackReferencesVtbl ptr
end type

#define IObjectWithBackReferences_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IObjectWithBackReferences_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IObjectWithBackReferences_Release(This) (This)->lpVtbl->Release(This)
#define IObjectWithBackReferences_RemoveBackReferences(This) (This)->lpVtbl->RemoveBackReferences(This)
declare function IObjectWithBackReferences_RemoveBackReferences_Proxy(byval This as IObjectWithBackReferences ptr) as HRESULT
declare sub IObjectWithBackReferences_RemoveBackReferences_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

type _PROPERTYUI_NAME_FLAGS as long
enum
	PUIFNF_DEFAULT = &h0
	PUIFNF_MNEMONIC = &h1
end enum

type PROPERTYUI_NAME_FLAGS as DWORD

type _PROPERTYUI_FLAGS as long
enum
	PUIF_DEFAULT = &h0
	PUIF_RIGHTALIGN = &h1
	PUIF_NOLABELININFOTIP = &h2
end enum

type PROPERTYUI_FLAGS as DWORD

type _PROPERTYUI_FORMAT_FLAGS as long
enum
	PUIFFDF_DEFAULT = &h0
	PUIFFDF_RIGHTTOLEFT = &h1
	PUIFFDF_SHORTFORMAT = &h2
	PUIFFDF_NOTIME = &h4
	PUIFFDF_FRIENDLYDATE = &h8
end enum

type PROPERTYUI_FORMAT_FLAGS as DWORD
#define __IPropertyUI_INTERFACE_DEFINED__
extern IID_IPropertyUI as const GUID
type IPropertyUI as IPropertyUI_

type IPropertyUIVtbl
	QueryInterface as function(byval This as IPropertyUI ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPropertyUI ptr) as ULONG
	Release as function(byval This as IPropertyUI ptr) as ULONG
	ParsePropertyName as function(byval This as IPropertyUI ptr, byval pszName as LPCWSTR, byval pfmtid as FMTID ptr, byval ppid as PROPID ptr, byval pchEaten as ULONG ptr) as HRESULT
	GetCannonicalName as function(byval This as IPropertyUI ptr, byval fmtid as const IID const ptr, byval pid as PROPID, byval pwszText as LPWSTR, byval cchText as DWORD) as HRESULT
	GetDisplayName as function(byval This as IPropertyUI ptr, byval fmtid as const IID const ptr, byval pid as PROPID, byval flags as PROPERTYUI_NAME_FLAGS, byval pwszText as LPWSTR, byval cchText as DWORD) as HRESULT
	GetPropertyDescription as function(byval This as IPropertyUI ptr, byval fmtid as const IID const ptr, byval pid as PROPID, byval pwszText as LPWSTR, byval cchText as DWORD) as HRESULT
	GetDefaultWidth as function(byval This as IPropertyUI ptr, byval fmtid as const IID const ptr, byval pid as PROPID, byval pcxChars as ULONG ptr) as HRESULT
	GetFlags as function(byval This as IPropertyUI ptr, byval fmtid as const IID const ptr, byval pid as PROPID, byval pflags as PROPERTYUI_FLAGS ptr) as HRESULT
	FormatForDisplay as function(byval This as IPropertyUI ptr, byval fmtid as const IID const ptr, byval pid as PROPID, byval ppropvar as const PROPVARIANT ptr, byval puiff as PROPERTYUI_FORMAT_FLAGS, byval pwszText as LPWSTR, byval cchText as DWORD) as HRESULT
	GetHelpInfo as function(byval This as IPropertyUI ptr, byval fmtid as const IID const ptr, byval pid as PROPID, byval pwszHelpFile as LPWSTR, byval cch as DWORD, byval puHelpID as UINT ptr) as HRESULT
end type

type IPropertyUI_
	lpVtbl as IPropertyUIVtbl ptr
end type

#define IPropertyUI_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IPropertyUI_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IPropertyUI_Release(This) (This)->lpVtbl->Release(This)
#define IPropertyUI_ParsePropertyName(This, pszName, pfmtid, ppid, pchEaten) (This)->lpVtbl->ParsePropertyName(This, pszName, pfmtid, ppid, pchEaten)
#define IPropertyUI_GetCannonicalName(This, fmtid, pid, pwszText, cchText) (This)->lpVtbl->GetCannonicalName(This, fmtid, pid, pwszText, cchText)
#define IPropertyUI_GetDisplayName(This, fmtid, pid, flags, pwszText, cchText) (This)->lpVtbl->GetDisplayName(This, fmtid, pid, flags, pwszText, cchText)
#define IPropertyUI_GetPropertyDescription(This, fmtid, pid, pwszText, cchText) (This)->lpVtbl->GetPropertyDescription(This, fmtid, pid, pwszText, cchText)
#define IPropertyUI_GetDefaultWidth(This, fmtid, pid, pcxChars) (This)->lpVtbl->GetDefaultWidth(This, fmtid, pid, pcxChars)
#define IPropertyUI_GetFlags(This, fmtid, pid, pflags) (This)->lpVtbl->GetFlags(This, fmtid, pid, pflags)
#define IPropertyUI_FormatForDisplay(This, fmtid, pid, ppropvar, puiff, pwszText, cchText) (This)->lpVtbl->FormatForDisplay(This, fmtid, pid, ppropvar, puiff, pwszText, cchText)
#define IPropertyUI_GetHelpInfo(This, fmtid, pid, pwszHelpFile, cch, puHelpID) (This)->lpVtbl->GetHelpInfo(This, fmtid, pid, pwszHelpFile, cch, puHelpID)

declare function IPropertyUI_ParsePropertyName_Proxy(byval This as IPropertyUI ptr, byval pszName as LPCWSTR, byval pfmtid as FMTID ptr, byval ppid as PROPID ptr, byval pchEaten as ULONG ptr) as HRESULT
declare sub IPropertyUI_ParsePropertyName_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyUI_GetCannonicalName_Proxy(byval This as IPropertyUI ptr, byval fmtid as const IID const ptr, byval pid as PROPID, byval pwszText as LPWSTR, byval cchText as DWORD) as HRESULT
declare sub IPropertyUI_GetCannonicalName_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyUI_GetDisplayName_Proxy(byval This as IPropertyUI ptr, byval fmtid as const IID const ptr, byval pid as PROPID, byval flags as PROPERTYUI_NAME_FLAGS, byval pwszText as LPWSTR, byval cchText as DWORD) as HRESULT
declare sub IPropertyUI_GetDisplayName_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyUI_GetPropertyDescription_Proxy(byval This as IPropertyUI ptr, byval fmtid as const IID const ptr, byval pid as PROPID, byval pwszText as LPWSTR, byval cchText as DWORD) as HRESULT
declare sub IPropertyUI_GetPropertyDescription_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyUI_GetDefaultWidth_Proxy(byval This as IPropertyUI ptr, byval fmtid as const IID const ptr, byval pid as PROPID, byval pcxChars as ULONG ptr) as HRESULT
declare sub IPropertyUI_GetDefaultWidth_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyUI_GetFlags_Proxy(byval This as IPropertyUI ptr, byval fmtid as const IID const ptr, byval pid as PROPID, byval pflags as PROPERTYUI_FLAGS ptr) as HRESULT
declare sub IPropertyUI_GetFlags_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyUI_FormatForDisplay_Proxy(byval This as IPropertyUI ptr, byval fmtid as const IID const ptr, byval pid as PROPID, byval ppropvar as const PROPVARIANT ptr, byval puiff as PROPERTYUI_FORMAT_FLAGS, byval pwszText as LPWSTR, byval cchText as DWORD) as HRESULT
declare sub IPropertyUI_FormatForDisplay_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyUI_GetHelpInfo_Proxy(byval This as IPropertyUI ptr, byval fmtid as const IID const ptr, byval pid as PROPID, byval pwszHelpFile as LPWSTR, byval cch as DWORD, byval puHelpID as UINT ptr) as HRESULT
declare sub IPropertyUI_GetHelpInfo_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#if _WIN32_WINNT >= &h0600
	declare function SHRemovePersonalPropertyValues(byval psia as IShellItemArray ptr) as HRESULT
	declare function SHAddDefaultPropertiesByExt(byval pszExt as PCWSTR, byval pPropStore as IPropertyStore ptr) as HRESULT
	type IFileOperation as IFileOperation_
	declare function SHCreateDefaultPropertiesOp(byval psi as IShellItem ptr, byval ppFileOp as IFileOperation ptr ptr) as HRESULT
	declare function SHSetDefaultProperties(byval hwnd as HWND, byval psi as IShellItem ptr, byval dwFileOpFlags as DWORD, byval pfops as IFileOperationProgressSink ptr) as HRESULT
#endif

#define __ICategoryProvider_INTERFACE_DEFINED__
extern IID_ICategoryProvider as const GUID
type ICategoryProvider as ICategoryProvider_

type ICategoryProviderVtbl
	QueryInterface as function(byval This as ICategoryProvider ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ICategoryProvider ptr) as ULONG
	Release as function(byval This as ICategoryProvider ptr) as ULONG
	CanCategorizeOnSCID as function(byval This as ICategoryProvider ptr, byval pscid as const SHCOLUMNID ptr) as HRESULT
	GetDefaultCategory as function(byval This as ICategoryProvider ptr, byval pguid as GUID ptr, byval pscid as SHCOLUMNID ptr) as HRESULT
	GetCategoryForSCID as function(byval This as ICategoryProvider ptr, byval pscid as const SHCOLUMNID ptr, byval pguid as GUID ptr) as HRESULT
	EnumCategories as function(byval This as ICategoryProvider ptr, byval penum as IEnumGUID ptr ptr) as HRESULT
	GetCategoryName as function(byval This as ICategoryProvider ptr, byval pguid as const GUID ptr, byval pszName as LPWSTR, byval cch as UINT) as HRESULT
	CreateCategory as function(byval This as ICategoryProvider ptr, byval pguid as const GUID ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
end type

type ICategoryProvider_
	lpVtbl as ICategoryProviderVtbl ptr
end type

#define ICategoryProvider_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define ICategoryProvider_AddRef(This) (This)->lpVtbl->AddRef(This)
#define ICategoryProvider_Release(This) (This)->lpVtbl->Release(This)
#define ICategoryProvider_CanCategorizeOnSCID(This, pscid) (This)->lpVtbl->CanCategorizeOnSCID(This, pscid)
#define ICategoryProvider_GetDefaultCategory(This, pguid, pscid) (This)->lpVtbl->GetDefaultCategory(This, pguid, pscid)
#define ICategoryProvider_GetCategoryForSCID(This, pscid, pguid) (This)->lpVtbl->GetCategoryForSCID(This, pscid, pguid)
#define ICategoryProvider_EnumCategories(This, penum) (This)->lpVtbl->EnumCategories(This, penum)
#define ICategoryProvider_GetCategoryName(This, pguid, pszName, cch) (This)->lpVtbl->GetCategoryName(This, pguid, pszName, cch)
#define ICategoryProvider_CreateCategory(This, pguid, riid, ppv) (This)->lpVtbl->CreateCategory(This, pguid, riid, ppv)

declare function ICategoryProvider_CanCategorizeOnSCID_Proxy(byval This as ICategoryProvider ptr, byval pscid as const SHCOLUMNID ptr) as HRESULT
declare sub ICategoryProvider_CanCategorizeOnSCID_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICategoryProvider_GetDefaultCategory_Proxy(byval This as ICategoryProvider ptr, byval pguid as GUID ptr, byval pscid as SHCOLUMNID ptr) as HRESULT
declare sub ICategoryProvider_GetDefaultCategory_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICategoryProvider_GetCategoryForSCID_Proxy(byval This as ICategoryProvider ptr, byval pscid as const SHCOLUMNID ptr, byval pguid as GUID ptr) as HRESULT
declare sub ICategoryProvider_GetCategoryForSCID_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICategoryProvider_EnumCategories_Proxy(byval This as ICategoryProvider ptr, byval penum as IEnumGUID ptr ptr) as HRESULT
declare sub ICategoryProvider_EnumCategories_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICategoryProvider_GetCategoryName_Proxy(byval This as ICategoryProvider ptr, byval pguid as const GUID ptr, byval pszName as LPWSTR, byval cch as UINT) as HRESULT
declare sub ICategoryProvider_GetCategoryName_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICategoryProvider_CreateCategory_Proxy(byval This as ICategoryProvider ptr, byval pguid as const GUID ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare sub ICategoryProvider_CreateCategory_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

type CATEGORYINFO_FLAGS as long
enum
	CATINFO_NORMAL = &h0
	CATINFO_COLLAPSED = &h1
	CATINFO_HIDDEN = &h2
	CATINFO_EXPANDED = &h4
	CATINFO_NOHEADER = &h8
	CATINFO_NOTCOLLAPSIBLE = &h10
	CATINFO_NOHEADERCOUNT = &h20
	CATINFO_SUBSETTED = &h40
end enum

type CATSORT_FLAGS as long
enum
	CATSORT_DEFAULT = &h0
	CATSORT_NAME = &h1
end enum

type CATEGORY_INFO
	cif as CATEGORYINFO_FLAGS
	wszName as wstring * 260
end type

#define __ICategorizer_INTERFACE_DEFINED__
extern IID_ICategorizer as const GUID
type ICategorizer as ICategorizer_

type ICategorizerVtbl
	QueryInterface as function(byval This as ICategorizer ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ICategorizer ptr) as ULONG
	Release as function(byval This as ICategorizer ptr) as ULONG
	GetDescription as function(byval This as ICategorizer ptr, byval pszDesc as LPWSTR, byval cch as UINT) as HRESULT
	GetCategory as function(byval This as ICategorizer ptr, byval cidl as UINT, byval apidl as LPCITEMIDLIST ptr, byval rgCategoryIds as DWORD ptr) as HRESULT
	GetCategoryInfo as function(byval This as ICategorizer ptr, byval dwCategoryId as DWORD, byval pci as CATEGORY_INFO ptr) as HRESULT
	CompareCategory as function(byval This as ICategorizer ptr, byval csfFlags as CATSORT_FLAGS, byval dwCategoryId1 as DWORD, byval dwCategoryId2 as DWORD) as HRESULT
end type

type ICategorizer_
	lpVtbl as ICategorizerVtbl ptr
end type

#define ICategorizer_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define ICategorizer_AddRef(This) (This)->lpVtbl->AddRef(This)
#define ICategorizer_Release(This) (This)->lpVtbl->Release(This)
#define ICategorizer_GetDescription(This, pszDesc, cch) (This)->lpVtbl->GetDescription(This, pszDesc, cch)
#define ICategorizer_GetCategory(This, cidl, apidl, rgCategoryIds) (This)->lpVtbl->GetCategory(This, cidl, apidl, rgCategoryIds)
#define ICategorizer_GetCategoryInfo(This, dwCategoryId, pci) (This)->lpVtbl->GetCategoryInfo(This, dwCategoryId, pci)
#define ICategorizer_CompareCategory(This, csfFlags, dwCategoryId1, dwCategoryId2) (This)->lpVtbl->CompareCategory(This, csfFlags, dwCategoryId1, dwCategoryId2)

declare function ICategorizer_GetDescription_Proxy(byval This as ICategorizer ptr, byval pszDesc as LPWSTR, byval cch as UINT) as HRESULT
declare sub ICategorizer_GetDescription_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICategorizer_GetCategory_Proxy(byval This as ICategorizer ptr, byval cidl as UINT, byval apidl as LPCITEMIDLIST ptr, byval rgCategoryIds as DWORD ptr) as HRESULT
declare sub ICategorizer_GetCategory_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICategorizer_GetCategoryInfo_Proxy(byval This as ICategorizer ptr, byval dwCategoryId as DWORD, byval pci as CATEGORY_INFO ptr) as HRESULT
declare sub ICategorizer_GetCategoryInfo_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICategorizer_CompareCategory_Proxy(byval This as ICategorizer ptr, byval csfFlags as CATSORT_FLAGS, byval dwCategoryId1 as DWORD, byval dwCategoryId2 as DWORD) as HRESULT
declare sub ICategorizer_CompareCategory_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

type SHDRAGIMAGE
	sizeDragImage as SIZE
	ptOffset as POINT
	hbmpDragImage as HBITMAP
	crColorKey as COLORREF
end type

type LPSHDRAGIMAGE as SHDRAGIMAGE ptr
#define DI_GETDRAGIMAGE __TEXT("ShellGetDragImage")
#define __IDropTargetHelper_INTERFACE_DEFINED__
extern IID_IDropTargetHelper as const GUID
type IDropTargetHelper as IDropTargetHelper_

type IDropTargetHelperVtbl
	QueryInterface as function(byval This as IDropTargetHelper ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDropTargetHelper ptr) as ULONG
	Release as function(byval This as IDropTargetHelper ptr) as ULONG
	DragEnter as function(byval This as IDropTargetHelper ptr, byval hwndTarget as HWND, byval pDataObject as IDataObject ptr, byval ppt as POINT ptr, byval dwEffect as DWORD) as HRESULT
	DragLeave as function(byval This as IDropTargetHelper ptr) as HRESULT
	DragOver as function(byval This as IDropTargetHelper ptr, byval ppt as POINT ptr, byval dwEffect as DWORD) as HRESULT
	Drop as function(byval This as IDropTargetHelper ptr, byval pDataObject as IDataObject ptr, byval ppt as POINT ptr, byval dwEffect as DWORD) as HRESULT
	Show as function(byval This as IDropTargetHelper ptr, byval fShow as WINBOOL) as HRESULT
end type

type IDropTargetHelper_
	lpVtbl as IDropTargetHelperVtbl ptr
end type

#define IDropTargetHelper_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IDropTargetHelper_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IDropTargetHelper_Release(This) (This)->lpVtbl->Release(This)
#define IDropTargetHelper_DragEnter(This, hwndTarget, pDataObject, ppt, dwEffect) (This)->lpVtbl->DragEnter(This, hwndTarget, pDataObject, ppt, dwEffect)
#define IDropTargetHelper_DragLeave(This) (This)->lpVtbl->DragLeave(This)
#define IDropTargetHelper_DragOver(This, ppt, dwEffect) (This)->lpVtbl->DragOver(This, ppt, dwEffect)
#define IDropTargetHelper_Drop(This, pDataObject, ppt, dwEffect) (This)->lpVtbl->Drop(This, pDataObject, ppt, dwEffect)
#define IDropTargetHelper_Show(This, fShow) (This)->lpVtbl->Show(This, fShow)

declare function IDropTargetHelper_DragEnter_Proxy(byval This as IDropTargetHelper ptr, byval hwndTarget as HWND, byval pDataObject as IDataObject ptr, byval ppt as POINT ptr, byval dwEffect as DWORD) as HRESULT
declare sub IDropTargetHelper_DragEnter_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDropTargetHelper_DragLeave_Proxy(byval This as IDropTargetHelper ptr) as HRESULT
declare sub IDropTargetHelper_DragLeave_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDropTargetHelper_DragOver_Proxy(byval This as IDropTargetHelper ptr, byval ppt as POINT ptr, byval dwEffect as DWORD) as HRESULT
declare sub IDropTargetHelper_DragOver_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDropTargetHelper_Drop_Proxy(byval This as IDropTargetHelper ptr, byval pDataObject as IDataObject ptr, byval ppt as POINT ptr, byval dwEffect as DWORD) as HRESULT
declare sub IDropTargetHelper_Drop_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDropTargetHelper_Show_Proxy(byval This as IDropTargetHelper ptr, byval fShow as WINBOOL) as HRESULT
declare sub IDropTargetHelper_Show_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IDragSourceHelper_INTERFACE_DEFINED__
extern IID_IDragSourceHelper as const GUID
type IDragSourceHelper as IDragSourceHelper_

type IDragSourceHelperVtbl
	QueryInterface as function(byval This as IDragSourceHelper ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDragSourceHelper ptr) as ULONG
	Release as function(byval This as IDragSourceHelper ptr) as ULONG
	InitializeFromBitmap as function(byval This as IDragSourceHelper ptr, byval pshdi as LPSHDRAGIMAGE, byval pDataObject as IDataObject ptr) as HRESULT
	InitializeFromWindow as function(byval This as IDragSourceHelper ptr, byval hwnd as HWND, byval ppt as POINT ptr, byval pDataObject as IDataObject ptr) as HRESULT
end type

type IDragSourceHelper_
	lpVtbl as IDragSourceHelperVtbl ptr
end type

#define IDragSourceHelper_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IDragSourceHelper_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IDragSourceHelper_Release(This) (This)->lpVtbl->Release(This)
#define IDragSourceHelper_InitializeFromBitmap(This, pshdi, pDataObject) (This)->lpVtbl->InitializeFromBitmap(This, pshdi, pDataObject)
#define IDragSourceHelper_InitializeFromWindow(This, hwnd, ppt, pDataObject) (This)->lpVtbl->InitializeFromWindow(This, hwnd, ppt, pDataObject)

declare function IDragSourceHelper_InitializeFromBitmap_Proxy(byval This as IDragSourceHelper ptr, byval pshdi as LPSHDRAGIMAGE, byval pDataObject as IDataObject ptr) as HRESULT
declare sub IDragSourceHelper_InitializeFromBitmap_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDragSourceHelper_InitializeFromWindow_Proxy(byval This as IDragSourceHelper ptr, byval hwnd as HWND, byval ppt as POINT ptr, byval pDataObject as IDataObject ptr) as HRESULT
declare sub IDragSourceHelper_InitializeFromWindow_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#if _WIN32_WINNT >= &h0600
	type DSH_FLAGS as long
	enum
		DSH_ALLOWDROPDESCRIPTIONTEXT = &h1
	end enum

	#define __IDragSourceHelper2_INTERFACE_DEFINED__
	extern IID_IDragSourceHelper2 as const GUID
	type IDragSourceHelper2 as IDragSourceHelper2_

	type IDragSourceHelper2Vtbl
		QueryInterface as function(byval This as IDragSourceHelper2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IDragSourceHelper2 ptr) as ULONG
		Release as function(byval This as IDragSourceHelper2 ptr) as ULONG
		InitializeFromBitmap as function(byval This as IDragSourceHelper2 ptr, byval pshdi as LPSHDRAGIMAGE, byval pDataObject as IDataObject ptr) as HRESULT
		InitializeFromWindow as function(byval This as IDragSourceHelper2 ptr, byval hwnd as HWND, byval ppt as POINT ptr, byval pDataObject as IDataObject ptr) as HRESULT
		SetFlags as function(byval This as IDragSourceHelper2 ptr, byval dwFlags as DWORD) as HRESULT
	end type

	type IDragSourceHelper2_
		lpVtbl as IDragSourceHelper2Vtbl ptr
	end type

	#define IDragSourceHelper2_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IDragSourceHelper2_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IDragSourceHelper2_Release(This) (This)->lpVtbl->Release(This)
	#define IDragSourceHelper2_InitializeFromBitmap(This, pshdi, pDataObject) (This)->lpVtbl->InitializeFromBitmap(This, pshdi, pDataObject)
	#define IDragSourceHelper2_InitializeFromWindow(This, hwnd, ppt, pDataObject) (This)->lpVtbl->InitializeFromWindow(This, hwnd, ppt, pDataObject)
	#define IDragSourceHelper2_SetFlags(This, dwFlags) (This)->lpVtbl->SetFlags(This, dwFlags)
	declare function IDragSourceHelper2_SetFlags_Proxy(byval This as IDragSourceHelper2 ptr, byval dwFlags as DWORD) as HRESULT
	declare sub IDragSourceHelper2_SetFlags_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#endif

#ifdef UNICODE
	type IShellLinkW as IShellLinkW_
	type IShellLink as IShellLinkW
#else
	type IShellLinkA as IShellLinkA_
	type IShellLink as IShellLinkA
#endif

type SLR_FLAGS as long
enum
	SLR_NO_UI = &h1
	SLR_ANY_MATCH = &h2
	SLR_UPDATE = &h4
	SLR_NOUPDATE = &h8
	SLR_NOSEARCH = &h10
	SLR_NOTRACK = &h20
	SLR_NOLINKINFO = &h40
	SLR_INVOKE_MSI = &h80
	SLR_NO_UI_WITH_MSG_PUMP = &h101
	SLR_OFFER_DELETE_WITHOUT_FILE = &h200
	SLR_KNOWNFOLDER = &h400
	SLR_MACHINE_IN_LOCAL_TARGET = &h800
	SLR_UPDATE_MACHINE_AND_SID = &h1000
end enum

type SLGP_FLAGS as long
enum
	SLGP_SHORTPATH = &h1
	SLGP_UNCPRIORITY = &h2
	SLGP_RAWPATH = &h4
	SLGP_RELATIVEPRIORITY = &h8
end enum

#define __IShellLinkA_INTERFACE_DEFINED__
extern IID_IShellLinkA as const GUID

#ifdef UNICODE
	type IShellLinkA as IShellLinkA_
#else
	extern IID_IShellLink alias "IID_IShellLinkA" as const GUID
#endif

type IShellLinkAVtbl
	QueryInterface as function(byval This as IShellLinkA ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IShellLinkA ptr) as ULONG
	Release as function(byval This as IShellLinkA ptr) as ULONG
	GetPath as function(byval This as IShellLinkA ptr, byval pszFile as LPSTR, byval cch as long, byval pfd as WIN32_FIND_DATAA ptr, byval fFlags as DWORD) as HRESULT
	GetIDList as function(byval This as IShellLinkA ptr, byval ppidl as LPITEMIDLIST ptr) as HRESULT
	SetIDList as function(byval This as IShellLinkA ptr, byval pidl as LPCITEMIDLIST) as HRESULT
	GetDescription as function(byval This as IShellLinkA ptr, byval pszName as LPSTR, byval cch as long) as HRESULT
	SetDescription as function(byval This as IShellLinkA ptr, byval pszName as LPCSTR) as HRESULT
	GetWorkingDirectory as function(byval This as IShellLinkA ptr, byval pszDir as LPSTR, byval cch as long) as HRESULT
	SetWorkingDirectory as function(byval This as IShellLinkA ptr, byval pszDir as LPCSTR) as HRESULT
	GetArguments as function(byval This as IShellLinkA ptr, byval pszArgs as LPSTR, byval cch as long) as HRESULT
	SetArguments as function(byval This as IShellLinkA ptr, byval pszArgs as LPCSTR) as HRESULT
	GetHotkey as function(byval This as IShellLinkA ptr, byval pwHotkey as WORD ptr) as HRESULT
	SetHotkey as function(byval This as IShellLinkA ptr, byval wHotkey as WORD) as HRESULT
	GetShowCmd as function(byval This as IShellLinkA ptr, byval piShowCmd as long ptr) as HRESULT
	SetShowCmd as function(byval This as IShellLinkA ptr, byval iShowCmd as long) as HRESULT
	GetIconLocation as function(byval This as IShellLinkA ptr, byval pszIconPath as LPSTR, byval cch as long, byval piIcon as long ptr) as HRESULT
	SetIconLocation as function(byval This as IShellLinkA ptr, byval pszIconPath as LPCSTR, byval iIcon as long) as HRESULT
	SetRelativePath as function(byval This as IShellLinkA ptr, byval pszPathRel as LPCSTR, byval dwReserved as DWORD) as HRESULT
	Resolve as function(byval This as IShellLinkA ptr, byval hwnd as HWND, byval fFlags as DWORD) as HRESULT
	SetPath as function(byval This as IShellLinkA ptr, byval pszFile as LPCSTR) as HRESULT
end type

type IShellLinkA_
	lpVtbl as IShellLinkAVtbl ptr
end type

#define IShellLinkA_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IShellLinkA_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IShellLinkA_Release(This) (This)->lpVtbl->Release(This)
#define IShellLinkA_GetPath(This, pszFile, cch, pfd, fFlags) (This)->lpVtbl->GetPath(This, pszFile, cch, pfd, fFlags)
#define IShellLinkA_GetIDList(This, ppidl) (This)->lpVtbl->GetIDList(This, ppidl)
#define IShellLinkA_SetIDList(This, pidl) (This)->lpVtbl->SetIDList(This, pidl)
#define IShellLinkA_GetDescription(This, pszName, cch) (This)->lpVtbl->GetDescription(This, pszName, cch)
#define IShellLinkA_SetDescription(This, pszName) (This)->lpVtbl->SetDescription(This, pszName)
#define IShellLinkA_GetWorkingDirectory(This, pszDir, cch) (This)->lpVtbl->GetWorkingDirectory(This, pszDir, cch)
#define IShellLinkA_SetWorkingDirectory(This, pszDir) (This)->lpVtbl->SetWorkingDirectory(This, pszDir)
#define IShellLinkA_GetArguments(This, pszArgs, cch) (This)->lpVtbl->GetArguments(This, pszArgs, cch)
#define IShellLinkA_SetArguments(This, pszArgs) (This)->lpVtbl->SetArguments(This, pszArgs)
#define IShellLinkA_GetHotkey(This, pwHotkey) (This)->lpVtbl->GetHotkey(This, pwHotkey)
#define IShellLinkA_SetHotkey(This, wHotkey) (This)->lpVtbl->SetHotkey(This, wHotkey)
#define IShellLinkA_GetShowCmd(This, piShowCmd) (This)->lpVtbl->GetShowCmd(This, piShowCmd)
#define IShellLinkA_SetShowCmd(This, iShowCmd) (This)->lpVtbl->SetShowCmd(This, iShowCmd)
#define IShellLinkA_GetIconLocation(This, pszIconPath, cch, piIcon) (This)->lpVtbl->GetIconLocation(This, pszIconPath, cch, piIcon)
#define IShellLinkA_SetIconLocation(This, pszIconPath, iIcon) (This)->lpVtbl->SetIconLocation(This, pszIconPath, iIcon)
#define IShellLinkA_SetRelativePath(This, pszPathRel, dwReserved) (This)->lpVtbl->SetRelativePath(This, pszPathRel, dwReserved)
#define IShellLinkA_Resolve(This, hwnd, fFlags) (This)->lpVtbl->Resolve(This, hwnd, fFlags)
#define IShellLinkA_SetPath(This, pszFile) (This)->lpVtbl->SetPath(This, pszFile)

declare function IShellLinkA_GetPath_Proxy(byval This as IShellLinkA ptr, byval pszFile as LPSTR, byval cch as long, byval pfd as WIN32_FIND_DATAA ptr, byval fFlags as DWORD) as HRESULT
declare sub IShellLinkA_GetPath_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLinkA_GetIDList_Proxy(byval This as IShellLinkA ptr, byval ppidl as LPITEMIDLIST ptr) as HRESULT
declare sub IShellLinkA_GetIDList_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLinkA_SetIDList_Proxy(byval This as IShellLinkA ptr, byval pidl as LPCITEMIDLIST) as HRESULT
declare sub IShellLinkA_SetIDList_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLinkA_GetDescription_Proxy(byval This as IShellLinkA ptr, byval pszName as LPSTR, byval cch as long) as HRESULT
declare sub IShellLinkA_GetDescription_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLinkA_SetDescription_Proxy(byval This as IShellLinkA ptr, byval pszName as LPCSTR) as HRESULT
declare sub IShellLinkA_SetDescription_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLinkA_GetWorkingDirectory_Proxy(byval This as IShellLinkA ptr, byval pszDir as LPSTR, byval cch as long) as HRESULT
declare sub IShellLinkA_GetWorkingDirectory_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLinkA_SetWorkingDirectory_Proxy(byval This as IShellLinkA ptr, byval pszDir as LPCSTR) as HRESULT
declare sub IShellLinkA_SetWorkingDirectory_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLinkA_GetArguments_Proxy(byval This as IShellLinkA ptr, byval pszArgs as LPSTR, byval cch as long) as HRESULT
declare sub IShellLinkA_GetArguments_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLinkA_SetArguments_Proxy(byval This as IShellLinkA ptr, byval pszArgs as LPCSTR) as HRESULT
declare sub IShellLinkA_SetArguments_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLinkA_GetHotkey_Proxy(byval This as IShellLinkA ptr, byval pwHotkey as WORD ptr) as HRESULT
declare sub IShellLinkA_GetHotkey_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLinkA_SetHotkey_Proxy(byval This as IShellLinkA ptr, byval wHotkey as WORD) as HRESULT
declare sub IShellLinkA_SetHotkey_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLinkA_GetShowCmd_Proxy(byval This as IShellLinkA ptr, byval piShowCmd as long ptr) as HRESULT
declare sub IShellLinkA_GetShowCmd_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLinkA_SetShowCmd_Proxy(byval This as IShellLinkA ptr, byval iShowCmd as long) as HRESULT
declare sub IShellLinkA_SetShowCmd_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLinkA_GetIconLocation_Proxy(byval This as IShellLinkA ptr, byval pszIconPath as LPSTR, byval cch as long, byval piIcon as long ptr) as HRESULT
declare sub IShellLinkA_GetIconLocation_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLinkA_SetIconLocation_Proxy(byval This as IShellLinkA ptr, byval pszIconPath as LPCSTR, byval iIcon as long) as HRESULT
declare sub IShellLinkA_SetIconLocation_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLinkA_SetRelativePath_Proxy(byval This as IShellLinkA ptr, byval pszPathRel as LPCSTR, byval dwReserved as DWORD) as HRESULT
declare sub IShellLinkA_SetRelativePath_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLinkA_Resolve_Proxy(byval This as IShellLinkA ptr, byval hwnd as HWND, byval fFlags as DWORD) as HRESULT
declare sub IShellLinkA_Resolve_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLinkA_SetPath_Proxy(byval This as IShellLinkA ptr, byval pszFile as LPCSTR) as HRESULT
declare sub IShellLinkA_SetPath_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IShellLinkW_INTERFACE_DEFINED__
extern IID_IShellLinkW as const GUID
extern SID_LinkSite alias "IID_IShellLinkW" as const GUID

#ifdef UNICODE
	extern IID_IShellLink alias "IID_IShellLinkW" as const GUID
#else
	type IShellLinkW as IShellLinkW_
#endif

type IShellLinkWVtbl
	QueryInterface as function(byval This as IShellLinkW ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IShellLinkW ptr) as ULONG
	Release as function(byval This as IShellLinkW ptr) as ULONG
	GetPath as function(byval This as IShellLinkW ptr, byval pszFile as LPWSTR, byval cch as long, byval pfd as WIN32_FIND_DATAW ptr, byval fFlags as DWORD) as HRESULT
	GetIDList as function(byval This as IShellLinkW ptr, byval ppidl as LPITEMIDLIST ptr) as HRESULT
	SetIDList as function(byval This as IShellLinkW ptr, byval pidl as LPCITEMIDLIST) as HRESULT
	GetDescription as function(byval This as IShellLinkW ptr, byval pszName as LPWSTR, byval cch as long) as HRESULT
	SetDescription as function(byval This as IShellLinkW ptr, byval pszName as LPCWSTR) as HRESULT
	GetWorkingDirectory as function(byval This as IShellLinkW ptr, byval pszDir as LPWSTR, byval cch as long) as HRESULT
	SetWorkingDirectory as function(byval This as IShellLinkW ptr, byval pszDir as LPCWSTR) as HRESULT
	GetArguments as function(byval This as IShellLinkW ptr, byval pszArgs as LPWSTR, byval cch as long) as HRESULT
	SetArguments as function(byval This as IShellLinkW ptr, byval pszArgs as LPCWSTR) as HRESULT
	GetHotkey as function(byval This as IShellLinkW ptr, byval pwHotkey as WORD ptr) as HRESULT
	SetHotkey as function(byval This as IShellLinkW ptr, byval wHotkey as WORD) as HRESULT
	GetShowCmd as function(byval This as IShellLinkW ptr, byval piShowCmd as long ptr) as HRESULT
	SetShowCmd as function(byval This as IShellLinkW ptr, byval iShowCmd as long) as HRESULT
	GetIconLocation as function(byval This as IShellLinkW ptr, byval pszIconPath as LPWSTR, byval cch as long, byval piIcon as long ptr) as HRESULT
	SetIconLocation as function(byval This as IShellLinkW ptr, byval pszIconPath as LPCWSTR, byval iIcon as long) as HRESULT
	SetRelativePath as function(byval This as IShellLinkW ptr, byval pszPathRel as LPCWSTR, byval dwReserved as DWORD) as HRESULT
	Resolve as function(byval This as IShellLinkW ptr, byval hwnd as HWND, byval fFlags as DWORD) as HRESULT
	SetPath as function(byval This as IShellLinkW ptr, byval pszFile as LPCWSTR) as HRESULT
end type

type IShellLinkW_
	lpVtbl as IShellLinkWVtbl ptr
end type

#define IShellLinkW_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IShellLinkW_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IShellLinkW_Release(This) (This)->lpVtbl->Release(This)
#define IShellLinkW_GetPath(This, pszFile, cch, pfd, fFlags) (This)->lpVtbl->GetPath(This, pszFile, cch, pfd, fFlags)
#define IShellLinkW_GetIDList(This, ppidl) (This)->lpVtbl->GetIDList(This, ppidl)
#define IShellLinkW_SetIDList(This, pidl) (This)->lpVtbl->SetIDList(This, pidl)
#define IShellLinkW_GetDescription(This, pszName, cch) (This)->lpVtbl->GetDescription(This, pszName, cch)
#define IShellLinkW_SetDescription(This, pszName) (This)->lpVtbl->SetDescription(This, pszName)
#define IShellLinkW_GetWorkingDirectory(This, pszDir, cch) (This)->lpVtbl->GetWorkingDirectory(This, pszDir, cch)
#define IShellLinkW_SetWorkingDirectory(This, pszDir) (This)->lpVtbl->SetWorkingDirectory(This, pszDir)
#define IShellLinkW_GetArguments(This, pszArgs, cch) (This)->lpVtbl->GetArguments(This, pszArgs, cch)
#define IShellLinkW_SetArguments(This, pszArgs) (This)->lpVtbl->SetArguments(This, pszArgs)
#define IShellLinkW_GetHotkey(This, pwHotkey) (This)->lpVtbl->GetHotkey(This, pwHotkey)
#define IShellLinkW_SetHotkey(This, wHotkey) (This)->lpVtbl->SetHotkey(This, wHotkey)
#define IShellLinkW_GetShowCmd(This, piShowCmd) (This)->lpVtbl->GetShowCmd(This, piShowCmd)
#define IShellLinkW_SetShowCmd(This, iShowCmd) (This)->lpVtbl->SetShowCmd(This, iShowCmd)
#define IShellLinkW_GetIconLocation(This, pszIconPath, cch, piIcon) (This)->lpVtbl->GetIconLocation(This, pszIconPath, cch, piIcon)
#define IShellLinkW_SetIconLocation(This, pszIconPath, iIcon) (This)->lpVtbl->SetIconLocation(This, pszIconPath, iIcon)
#define IShellLinkW_SetRelativePath(This, pszPathRel, dwReserved) (This)->lpVtbl->SetRelativePath(This, pszPathRel, dwReserved)
#define IShellLinkW_Resolve(This, hwnd, fFlags) (This)->lpVtbl->Resolve(This, hwnd, fFlags)
#define IShellLinkW_SetPath(This, pszFile) (This)->lpVtbl->SetPath(This, pszFile)

declare function IShellLinkW_GetPath_Proxy(byval This as IShellLinkW ptr, byval pszFile as LPWSTR, byval cch as long, byval pfd as WIN32_FIND_DATAW ptr, byval fFlags as DWORD) as HRESULT
declare sub IShellLinkW_GetPath_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLinkW_GetIDList_Proxy(byval This as IShellLinkW ptr, byval ppidl as LPITEMIDLIST ptr) as HRESULT
declare sub IShellLinkW_GetIDList_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLinkW_SetIDList_Proxy(byval This as IShellLinkW ptr, byval pidl as LPCITEMIDLIST) as HRESULT
declare sub IShellLinkW_SetIDList_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLinkW_GetDescription_Proxy(byval This as IShellLinkW ptr, byval pszName as LPWSTR, byval cch as long) as HRESULT
declare sub IShellLinkW_GetDescription_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLinkW_SetDescription_Proxy(byval This as IShellLinkW ptr, byval pszName as LPCWSTR) as HRESULT
declare sub IShellLinkW_SetDescription_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLinkW_GetWorkingDirectory_Proxy(byval This as IShellLinkW ptr, byval pszDir as LPWSTR, byval cch as long) as HRESULT
declare sub IShellLinkW_GetWorkingDirectory_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLinkW_SetWorkingDirectory_Proxy(byval This as IShellLinkW ptr, byval pszDir as LPCWSTR) as HRESULT
declare sub IShellLinkW_SetWorkingDirectory_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLinkW_GetArguments_Proxy(byval This as IShellLinkW ptr, byval pszArgs as LPWSTR, byval cch as long) as HRESULT
declare sub IShellLinkW_GetArguments_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLinkW_SetArguments_Proxy(byval This as IShellLinkW ptr, byval pszArgs as LPCWSTR) as HRESULT
declare sub IShellLinkW_SetArguments_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLinkW_GetHotkey_Proxy(byval This as IShellLinkW ptr, byval pwHotkey as WORD ptr) as HRESULT
declare sub IShellLinkW_GetHotkey_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLinkW_SetHotkey_Proxy(byval This as IShellLinkW ptr, byval wHotkey as WORD) as HRESULT
declare sub IShellLinkW_SetHotkey_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLinkW_GetShowCmd_Proxy(byval This as IShellLinkW ptr, byval piShowCmd as long ptr) as HRESULT
declare sub IShellLinkW_GetShowCmd_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLinkW_SetShowCmd_Proxy(byval This as IShellLinkW ptr, byval iShowCmd as long) as HRESULT
declare sub IShellLinkW_SetShowCmd_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLinkW_GetIconLocation_Proxy(byval This as IShellLinkW ptr, byval pszIconPath as LPWSTR, byval cch as long, byval piIcon as long ptr) as HRESULT
declare sub IShellLinkW_GetIconLocation_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLinkW_SetIconLocation_Proxy(byval This as IShellLinkW ptr, byval pszIconPath as LPCWSTR, byval iIcon as long) as HRESULT
declare sub IShellLinkW_SetIconLocation_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLinkW_SetRelativePath_Proxy(byval This as IShellLinkW ptr, byval pszPathRel as LPCWSTR, byval dwReserved as DWORD) as HRESULT
declare sub IShellLinkW_SetRelativePath_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLinkW_Resolve_Proxy(byval This as IShellLinkW ptr, byval hwnd as HWND, byval fFlags as DWORD) as HRESULT
declare sub IShellLinkW_Resolve_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLinkW_SetPath_Proxy(byval This as IShellLinkW ptr, byval pszFile as LPCWSTR) as HRESULT
declare sub IShellLinkW_SetPath_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IShellLinkDataList_INTERFACE_DEFINED__
extern IID_IShellLinkDataList as const GUID
type IShellLinkDataList as IShellLinkDataList_

type IShellLinkDataListVtbl
	QueryInterface as function(byval This as IShellLinkDataList ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IShellLinkDataList ptr) as ULONG
	Release as function(byval This as IShellLinkDataList ptr) as ULONG
	AddDataBlock as function(byval This as IShellLinkDataList ptr, byval pDataBlock as any ptr) as HRESULT
	CopyDataBlock as function(byval This as IShellLinkDataList ptr, byval dwSig as DWORD, byval ppDataBlock as any ptr ptr) as HRESULT
	RemoveDataBlock as function(byval This as IShellLinkDataList ptr, byval dwSig as DWORD) as HRESULT
	GetFlags as function(byval This as IShellLinkDataList ptr, byval pdwFlags as DWORD ptr) as HRESULT
	SetFlags as function(byval This as IShellLinkDataList ptr, byval dwFlags as DWORD) as HRESULT
end type

type IShellLinkDataList_
	lpVtbl as IShellLinkDataListVtbl ptr
end type

#define IShellLinkDataList_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IShellLinkDataList_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IShellLinkDataList_Release(This) (This)->lpVtbl->Release(This)
#define IShellLinkDataList_AddDataBlock(This, pDataBlock) (This)->lpVtbl->AddDataBlock(This, pDataBlock)
#define IShellLinkDataList_CopyDataBlock(This, dwSig, ppDataBlock) (This)->lpVtbl->CopyDataBlock(This, dwSig, ppDataBlock)
#define IShellLinkDataList_RemoveDataBlock(This, dwSig) (This)->lpVtbl->RemoveDataBlock(This, dwSig)
#define IShellLinkDataList_GetFlags(This, pdwFlags) (This)->lpVtbl->GetFlags(This, pdwFlags)
#define IShellLinkDataList_SetFlags(This, dwFlags) (This)->lpVtbl->SetFlags(This, dwFlags)

declare function IShellLinkDataList_RemoveDataBlock_Proxy(byval This as IShellLinkDataList ptr, byval dwSig as DWORD) as HRESULT
declare sub IShellLinkDataList_RemoveDataBlock_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLinkDataList_GetFlags_Proxy(byval This as IShellLinkDataList ptr, byval pdwFlags as DWORD ptr) as HRESULT
declare sub IShellLinkDataList_GetFlags_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLinkDataList_SetFlags_Proxy(byval This as IShellLinkDataList ptr, byval dwFlags as DWORD) as HRESULT
declare sub IShellLinkDataList_SetFlags_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IResolveShellLink_INTERFACE_DEFINED__
extern IID_IResolveShellLink as const GUID
type IResolveShellLink as IResolveShellLink_

type IResolveShellLinkVtbl
	QueryInterface as function(byval This as IResolveShellLink ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IResolveShellLink ptr) as ULONG
	Release as function(byval This as IResolveShellLink ptr) as ULONG
	ResolveShellLink as function(byval This as IResolveShellLink ptr, byval punkLink as IUnknown ptr, byval hwnd as HWND, byval fFlags as DWORD) as HRESULT
end type

type IResolveShellLink_
	lpVtbl as IResolveShellLinkVtbl ptr
end type

#define IResolveShellLink_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IResolveShellLink_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IResolveShellLink_Release(This) (This)->lpVtbl->Release(This)
#define IResolveShellLink_ResolveShellLink(This, punkLink, hwnd, fFlags) (This)->lpVtbl->ResolveShellLink(This, punkLink, hwnd, fFlags)
declare function IResolveShellLink_ResolveShellLink_Proxy(byval This as IResolveShellLink ptr, byval punkLink as IUnknown ptr, byval hwnd as HWND, byval fFlags as DWORD) as HRESULT
declare sub IResolveShellLink_ResolveShellLink_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IActionProgressDialog_INTERFACE_DEFINED__

type _SPINITF as long
enum
	SPINITF_NORMAL = &h0
	SPINITF_MODAL = &h1
	SPINITF_NOMINIMIZE = &h8
end enum

type SPINITF as DWORD
extern IID_IActionProgressDialog as const GUID
type IActionProgressDialog as IActionProgressDialog_

type IActionProgressDialogVtbl
	QueryInterface as function(byval This as IActionProgressDialog ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IActionProgressDialog ptr) as ULONG
	Release as function(byval This as IActionProgressDialog ptr) as ULONG
	Initialize as function(byval This as IActionProgressDialog ptr, byval flags as SPINITF, byval pszTitle as LPCWSTR, byval pszCancel as LPCWSTR) as HRESULT
	Stop as function(byval This as IActionProgressDialog ptr) as HRESULT
end type

type IActionProgressDialog_
	lpVtbl as IActionProgressDialogVtbl ptr
end type

#define IActionProgressDialog_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IActionProgressDialog_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IActionProgressDialog_Release(This) (This)->lpVtbl->Release(This)
#define IActionProgressDialog_Initialize(This, flags, pszTitle, pszCancel) (This)->lpVtbl->Initialize(This, flags, pszTitle, pszCancel)
#define IActionProgressDialog_Stop(This) (This)->lpVtbl->Stop(This)

declare function IActionProgressDialog_Initialize_Proxy(byval This as IActionProgressDialog ptr, byval flags as SPINITF, byval pszTitle as LPCWSTR, byval pszCancel as LPCWSTR) as HRESULT
declare sub IActionProgressDialog_Initialize_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IActionProgressDialog_Stop_Proxy(byval This as IActionProgressDialog ptr) as HRESULT
declare sub IActionProgressDialog_Stop_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IHWEventHandler_INTERFACE_DEFINED__
extern IID_IHWEventHandler as const GUID
type IHWEventHandler as IHWEventHandler_

type IHWEventHandlerVtbl
	QueryInterface as function(byval This as IHWEventHandler ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IHWEventHandler ptr) as ULONG
	Release as function(byval This as IHWEventHandler ptr) as ULONG
	Initialize as function(byval This as IHWEventHandler ptr, byval pszParams as LPCWSTR) as HRESULT
	HandleEvent as function(byval This as IHWEventHandler ptr, byval pszDeviceID as LPCWSTR, byval pszAltDeviceID as LPCWSTR, byval pszEventType as LPCWSTR) as HRESULT
	HandleEventWithContent as function(byval This as IHWEventHandler ptr, byval pszDeviceID as LPCWSTR, byval pszAltDeviceID as LPCWSTR, byval pszEventType as LPCWSTR, byval pszContentTypeHandler as LPCWSTR, byval pdataobject as IDataObject ptr) as HRESULT
end type

type IHWEventHandler_
	lpVtbl as IHWEventHandlerVtbl ptr
end type

#define IHWEventHandler_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IHWEventHandler_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IHWEventHandler_Release(This) (This)->lpVtbl->Release(This)
#define IHWEventHandler_Initialize(This, pszParams) (This)->lpVtbl->Initialize(This, pszParams)
#define IHWEventHandler_HandleEvent(This, pszDeviceID, pszAltDeviceID, pszEventType) (This)->lpVtbl->HandleEvent(This, pszDeviceID, pszAltDeviceID, pszEventType)
#define IHWEventHandler_HandleEventWithContent(This, pszDeviceID, pszAltDeviceID, pszEventType, pszContentTypeHandler, pdataobject) (This)->lpVtbl->HandleEventWithContent(This, pszDeviceID, pszAltDeviceID, pszEventType, pszContentTypeHandler, pdataobject)

declare function IHWEventHandler_Initialize_Proxy(byval This as IHWEventHandler ptr, byval pszParams as LPCWSTR) as HRESULT
declare sub IHWEventHandler_Initialize_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IHWEventHandler_HandleEvent_Proxy(byval This as IHWEventHandler ptr, byval pszDeviceID as LPCWSTR, byval pszAltDeviceID as LPCWSTR, byval pszEventType as LPCWSTR) as HRESULT
declare sub IHWEventHandler_HandleEvent_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IHWEventHandler_HandleEventWithContent_Proxy(byval This as IHWEventHandler ptr, byval pszDeviceID as LPCWSTR, byval pszAltDeviceID as LPCWSTR, byval pszEventType as LPCWSTR, byval pszContentTypeHandler as LPCWSTR, byval pdataobject as IDataObject ptr) as HRESULT
declare sub IHWEventHandler_HandleEventWithContent_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IHWEventHandler2_INTERFACE_DEFINED__
extern IID_IHWEventHandler2 as const GUID
type IHWEventHandler2 as IHWEventHandler2_

type IHWEventHandler2Vtbl
	QueryInterface as function(byval This as IHWEventHandler2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IHWEventHandler2 ptr) as ULONG
	Release as function(byval This as IHWEventHandler2 ptr) as ULONG
	Initialize as function(byval This as IHWEventHandler2 ptr, byval pszParams as LPCWSTR) as HRESULT
	HandleEvent as function(byval This as IHWEventHandler2 ptr, byval pszDeviceID as LPCWSTR, byval pszAltDeviceID as LPCWSTR, byval pszEventType as LPCWSTR) as HRESULT
	HandleEventWithContent as function(byval This as IHWEventHandler2 ptr, byval pszDeviceID as LPCWSTR, byval pszAltDeviceID as LPCWSTR, byval pszEventType as LPCWSTR, byval pszContentTypeHandler as LPCWSTR, byval pdataobject as IDataObject ptr) as HRESULT
	HandleEventWithHWND as function(byval This as IHWEventHandler2 ptr, byval pszDeviceID as LPCWSTR, byval pszAltDeviceID as LPCWSTR, byval pszEventType as LPCWSTR, byval hwndOwner as HWND) as HRESULT
end type

type IHWEventHandler2_
	lpVtbl as IHWEventHandler2Vtbl ptr
end type

#define IHWEventHandler2_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IHWEventHandler2_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IHWEventHandler2_Release(This) (This)->lpVtbl->Release(This)
#define IHWEventHandler2_Initialize(This, pszParams) (This)->lpVtbl->Initialize(This, pszParams)
#define IHWEventHandler2_HandleEvent(This, pszDeviceID, pszAltDeviceID, pszEventType) (This)->lpVtbl->HandleEvent(This, pszDeviceID, pszAltDeviceID, pszEventType)
#define IHWEventHandler2_HandleEventWithContent(This, pszDeviceID, pszAltDeviceID, pszEventType, pszContentTypeHandler, pdataobject) (This)->lpVtbl->HandleEventWithContent(This, pszDeviceID, pszAltDeviceID, pszEventType, pszContentTypeHandler, pdataobject)
#define IHWEventHandler2_HandleEventWithHWND(This, pszDeviceID, pszAltDeviceID, pszEventType, hwndOwner) (This)->lpVtbl->HandleEventWithHWND(This, pszDeviceID, pszAltDeviceID, pszEventType, hwndOwner)
declare function IHWEventHandler2_HandleEventWithHWND_Proxy(byval This as IHWEventHandler2 ptr, byval pszDeviceID as LPCWSTR, byval pszAltDeviceID as LPCWSTR, byval pszEventType as LPCWSTR, byval hwndOwner as HWND) as HRESULT
declare sub IHWEventHandler2_HandleEventWithHWND_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
const ARCONTENT_AUTORUNINF = &h00000002
const ARCONTENT_AUDIOCD = &h00000004
const ARCONTENT_DVDMOVIE = &h00000008
const ARCONTENT_BLANKCD = &h00000010
const ARCONTENT_BLANKDVD = &h00000020
const ARCONTENT_UNKNOWNCONTENT = &h00000040
const ARCONTENT_AUTOPLAYPIX = &h00000080
const ARCONTENT_AUTOPLAYMUSIC = &h00000100
const ARCONTENT_AUTOPLAYVIDEO = &h00000200

#if _WIN32_WINNT >= &h0600
	const ARCONTENT_VCD = &h00000400
	const ARCONTENT_SVCD = &h00000800
	const ARCONTENT_DVDAUDIO = &h00001000
	const ARCONTENT_BLANKBD = &h00002000
	const ARCONTENT_BLURAY = &h00004000
	const ARCONTENT_CAMERASTORAGE = &h00008000
	const ARCONTENT_CUSTOMEVENT = &h00010000
	const ARCONTENT_NONE = &h00000000
	const ARCONTENT_MASK = &h0001FFFE
	const ARCONTENT_PHASE_UNKNOWN = &h00000000
	const ARCONTENT_PHASE_PRESNIFF = &h10000000
	const ARCONTENT_PHASE_SNIFFING = &h20000000
	const ARCONTENT_PHASE_FINAL = &h40000000
	const ARCONTENT_PHASE_MASK = &h70000000
#endif

#define __IQueryCancelAutoPlay_INTERFACE_DEFINED__
extern IID_IQueryCancelAutoPlay as const GUID
type IQueryCancelAutoPlay as IQueryCancelAutoPlay_

type IQueryCancelAutoPlayVtbl
	QueryInterface as function(byval This as IQueryCancelAutoPlay ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IQueryCancelAutoPlay ptr) as ULONG
	Release as function(byval This as IQueryCancelAutoPlay ptr) as ULONG
	AllowAutoPlay as function(byval This as IQueryCancelAutoPlay ptr, byval pszPath as LPCWSTR, byval dwContentType as DWORD, byval pszLabel as LPCWSTR, byval dwSerialNumber as DWORD) as HRESULT
end type

type IQueryCancelAutoPlay_
	lpVtbl as IQueryCancelAutoPlayVtbl ptr
end type

#define IQueryCancelAutoPlay_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IQueryCancelAutoPlay_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IQueryCancelAutoPlay_Release(This) (This)->lpVtbl->Release(This)
#define IQueryCancelAutoPlay_AllowAutoPlay(This, pszPath, dwContentType, pszLabel, dwSerialNumber) (This)->lpVtbl->AllowAutoPlay(This, pszPath, dwContentType, pszLabel, dwSerialNumber)
declare function IQueryCancelAutoPlay_AllowAutoPlay_Proxy(byval This as IQueryCancelAutoPlay ptr, byval pszPath as LPCWSTR, byval dwContentType as DWORD, byval pszLabel as LPCWSTR, byval dwSerialNumber as DWORD) as HRESULT
declare sub IQueryCancelAutoPlay_AllowAutoPlay_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#if _WIN32_WINNT >= &h0600
	#define __IDynamicHWHandler_INTERFACE_DEFINED__
	extern IID_IDynamicHWHandler as const GUID
	type IDynamicHWHandler as IDynamicHWHandler_

	type IDynamicHWHandlerVtbl
		QueryInterface as function(byval This as IDynamicHWHandler ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IDynamicHWHandler ptr) as ULONG
		Release as function(byval This as IDynamicHWHandler ptr) as ULONG
		GetDynamicInfo as function(byval This as IDynamicHWHandler ptr, byval pszDeviceID as LPCWSTR, byval dwContentType as DWORD, byval ppszAction as LPWSTR ptr) as HRESULT
	end type

	type IDynamicHWHandler_
		lpVtbl as IDynamicHWHandlerVtbl ptr
	end type

	#define IDynamicHWHandler_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IDynamicHWHandler_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IDynamicHWHandler_Release(This) (This)->lpVtbl->Release(This)
	#define IDynamicHWHandler_GetDynamicInfo(This, pszDeviceID, dwContentType, ppszAction) (This)->lpVtbl->GetDynamicInfo(This, pszDeviceID, dwContentType, ppszAction)
	declare function IDynamicHWHandler_GetDynamicInfo_Proxy(byval This as IDynamicHWHandler ptr, byval pszDeviceID as LPCWSTR, byval dwContentType as DWORD, byval ppszAction as LPWSTR ptr) as HRESULT
	declare sub IDynamicHWHandler_GetDynamicInfo_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#endif

#define __IActionProgress_INTERFACE_DEFINED__

type _SPBEGINF as long
enum
	SPBEGINF_NORMAL = &h0
	SPBEGINF_AUTOTIME = &h2
	SPBEGINF_NOPROGRESSBAR = &h10
	SPBEGINF_MARQUEEPROGRESS = &h20
	SPBEGINF_NOCANCELBUTTON = &h40
end enum

type SPBEGINF as DWORD

type _SPACTION as long
enum
	SPACTION_NONE = 0
	SPACTION_MOVING = 1
	SPACTION_COPYING = 2
	SPACTION_RECYCLING = 3
	SPACTION_APPLYINGATTRIBS = 4
	SPACTION_DOWNLOADING = 5
	SPACTION_SEARCHING_INTERNET = 6
	SPACTION_CALCULATING = 7
	SPACTION_UPLOADING = 8
	SPACTION_SEARCHING_FILES = 9
	SPACTION_DELETING = 10
	SPACTION_RENAMING = 11
	SPACTION_FORMATTING = 12
	SPACTION_COPY_MOVING = 13
end enum

type SPACTION as _SPACTION

type _SPTEXT as long
enum
	SPTEXT_ACTIONDESCRIPTION = 1
	SPTEXT_ACTIONDETAIL = 2
end enum

type SPTEXT as _SPTEXT
extern IID_IActionProgress as const GUID
type IActionProgress as IActionProgress_

type IActionProgressVtbl
	QueryInterface as function(byval This as IActionProgress ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IActionProgress ptr) as ULONG
	Release as function(byval This as IActionProgress ptr) as ULONG
	Begin as function(byval This as IActionProgress ptr, byval action as SPACTION, byval flags as SPBEGINF) as HRESULT
	UpdateProgress as function(byval This as IActionProgress ptr, byval ulCompleted as ULONGLONG, byval ulTotal as ULONGLONG) as HRESULT
	UpdateText as function(byval This as IActionProgress ptr, byval sptext as SPTEXT, byval pszText as LPCWSTR, byval fMayCompact as WINBOOL) as HRESULT
	QueryCancel as function(byval This as IActionProgress ptr, byval pfCancelled as WINBOOL ptr) as HRESULT
	ResetCancel as function(byval This as IActionProgress ptr) as HRESULT
	as function(byval This as IActionProgress ptr) as HRESULT End
end type

type IActionProgress_
	lpVtbl as IActionProgressVtbl ptr
end type

#define IActionProgress_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IActionProgress_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IActionProgress_Release(This) (This)->lpVtbl->Release(This)
#define IActionProgress_Begin(This, action, flags) (This)->lpVtbl->Begin(This, action, flags)
#define IActionProgress_UpdateProgress(This, ulCompleted, ulTotal) (This)->lpVtbl->UpdateProgress(This, ulCompleted, ulTotal)
#define IActionProgress_UpdateText(This, sptext, pszText, fMayCompact) (This)->lpVtbl->UpdateText(This, sptext, pszText, fMayCompact)
#define IActionProgress_QueryCancel(This, pfCancelled) (This)->lpVtbl->QueryCancel(This, pfCancelled)
#define IActionProgress_ResetCancel(This) (This)->lpVtbl->ResetCancel(This)
#define IActionProgress_End(This) (This)->lpVtbl->End(This)

declare function IActionProgress_Begin_Proxy(byval This as IActionProgress ptr, byval action as SPACTION, byval flags as SPBEGINF) as HRESULT
declare sub IActionProgress_Begin_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IActionProgress_UpdateProgress_Proxy(byval This as IActionProgress ptr, byval ulCompleted as ULONGLONG, byval ulTotal as ULONGLONG) as HRESULT
declare sub IActionProgress_UpdateProgress_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IActionProgress_UpdateText_Proxy(byval This as IActionProgress ptr, byval sptext as SPTEXT, byval pszText as LPCWSTR, byval fMayCompact as WINBOOL) as HRESULT
declare sub IActionProgress_UpdateText_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IActionProgress_QueryCancel_Proxy(byval This as IActionProgress ptr, byval pfCancelled as WINBOOL ptr) as HRESULT
declare sub IActionProgress_QueryCancel_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IActionProgress_ResetCancel_Proxy(byval This as IActionProgress ptr) as HRESULT
declare sub IActionProgress_ResetCancel_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IActionProgress_End_Proxy(byval This as IActionProgress ptr) as HRESULT
declare sub IActionProgress_End_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IShellExtInit_INTERFACE_DEFINED__
extern IID_IShellExtInit as const GUID
type IShellExtInit as IShellExtInit_

type IShellExtInitVtbl
	QueryInterface as function(byval This as IShellExtInit ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IShellExtInit ptr) as ULONG
	Release as function(byval This as IShellExtInit ptr) as ULONG
	Initialize as function(byval This as IShellExtInit ptr, byval pidlFolder as LPCITEMIDLIST, byval pdtobj as IDataObject ptr, byval hkeyProgID as HKEY) as HRESULT
end type

type IShellExtInit_
	lpVtbl as IShellExtInitVtbl ptr
end type

#define IShellExtInit_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IShellExtInit_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IShellExtInit_Release(This) (This)->lpVtbl->Release(This)
#define IShellExtInit_Initialize(This, pidlFolder, pdtobj, hkeyProgID) (This)->lpVtbl->Initialize(This, pidlFolder, pdtobj, hkeyProgID)
declare function IShellExtInit_Initialize_Proxy(byval This as IShellExtInit ptr, byval pidlFolder as LPCITEMIDLIST, byval pdtobj as IDataObject ptr, byval hkeyProgID as HKEY) as HRESULT
declare sub IShellExtInit_Initialize_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
type LPSHELLEXTINIT as IShellExtInit ptr
#define __IShellPropSheetExt_INTERFACE_DEFINED__

type _EXPPS as long
enum
	EXPPS_FILETYPES = &h1
end enum

type EXPPS as UINT
extern IID_IShellPropSheetExt as const GUID
type IShellPropSheetExt as IShellPropSheetExt_

type IShellPropSheetExtVtbl
	QueryInterface as function(byval This as IShellPropSheetExt ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IShellPropSheetExt ptr) as ULONG
	Release as function(byval This as IShellPropSheetExt ptr) as ULONG
	AddPages as function(byval This as IShellPropSheetExt ptr, byval pfnAddPage as LPFNSVADDPROPSHEETPAGE, byval lParam as LPARAM) as HRESULT
	ReplacePage as function(byval This as IShellPropSheetExt ptr, byval uPageID as EXPPS, byval pfnReplaceWith as LPFNSVADDPROPSHEETPAGE, byval lParam as LPARAM) as HRESULT
end type

type IShellPropSheetExt_
	lpVtbl as IShellPropSheetExtVtbl ptr
end type

#define IShellPropSheetExt_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IShellPropSheetExt_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IShellPropSheetExt_Release(This) (This)->lpVtbl->Release(This)
#define IShellPropSheetExt_AddPages(This, pfnAddPage, lParam) (This)->lpVtbl->AddPages(This, pfnAddPage, lParam)
#define IShellPropSheetExt_ReplacePage(This, uPageID, pfnReplaceWith, lParam) (This)->lpVtbl->ReplacePage(This, uPageID, pfnReplaceWith, lParam)

declare function IShellPropSheetExt_AddPages_Proxy(byval This as IShellPropSheetExt ptr, byval pfnAddPage as LPFNSVADDPROPSHEETPAGE, byval lParam as LPARAM) as HRESULT
declare sub IShellPropSheetExt_AddPages_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellPropSheetExt_ReplacePage_Proxy(byval This as IShellPropSheetExt ptr, byval uPageID as EXPPS, byval pfnReplaceWith as LPFNSVADDPROPSHEETPAGE, byval lParam as LPARAM) as HRESULT
declare sub IShellPropSheetExt_ReplacePage_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
type LPSHELLPROPSHEETEXT as IShellPropSheetExt ptr
#define __IRemoteComputer_INTERFACE_DEFINED__
extern IID_IRemoteComputer as const GUID
type IRemoteComputer as IRemoteComputer_

type IRemoteComputerVtbl
	QueryInterface as function(byval This as IRemoteComputer ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IRemoteComputer ptr) as ULONG
	Release as function(byval This as IRemoteComputer ptr) as ULONG
	Initialize as function(byval This as IRemoteComputer ptr, byval pszMachine as LPCWSTR, byval bEnumerating as WINBOOL) as HRESULT
end type

type IRemoteComputer_
	lpVtbl as IRemoteComputerVtbl ptr
end type

#define IRemoteComputer_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IRemoteComputer_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IRemoteComputer_Release(This) (This)->lpVtbl->Release(This)
#define IRemoteComputer_Initialize(This, pszMachine, bEnumerating) (This)->lpVtbl->Initialize(This, pszMachine, bEnumerating)
declare function IRemoteComputer_Initialize_Proxy(byval This as IRemoteComputer ptr, byval pszMachine as LPCWSTR, byval bEnumerating as WINBOOL) as HRESULT
declare sub IRemoteComputer_Initialize_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IQueryContinue_INTERFACE_DEFINED__
extern IID_IQueryContinue as const GUID
type IQueryContinue as IQueryContinue_

type IQueryContinueVtbl
	QueryInterface as function(byval This as IQueryContinue ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IQueryContinue ptr) as ULONG
	Release as function(byval This as IQueryContinue ptr) as ULONG
	QueryContinue as function(byval This as IQueryContinue ptr) as HRESULT
end type

type IQueryContinue_
	lpVtbl as IQueryContinueVtbl ptr
end type

#define IQueryContinue_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IQueryContinue_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IQueryContinue_Release(This) (This)->lpVtbl->Release(This)
#define IQueryContinue_QueryContinue(This) (This)->lpVtbl->QueryContinue(This)
declare function IQueryContinue_QueryContinue_Proxy(byval This as IQueryContinue ptr) as HRESULT
declare sub IQueryContinue_QueryContinue_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IObjectWithCancelEvent_INTERFACE_DEFINED__
extern IID_IObjectWithCancelEvent as const GUID
type IObjectWithCancelEvent as IObjectWithCancelEvent_

type IObjectWithCancelEventVtbl
	QueryInterface as function(byval This as IObjectWithCancelEvent ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IObjectWithCancelEvent ptr) as ULONG
	Release as function(byval This as IObjectWithCancelEvent ptr) as ULONG
	GetCancelEvent as function(byval This as IObjectWithCancelEvent ptr, byval phEvent as HANDLE ptr) as HRESULT
end type

type IObjectWithCancelEvent_
	lpVtbl as IObjectWithCancelEventVtbl ptr
end type

#define IObjectWithCancelEvent_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IObjectWithCancelEvent_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IObjectWithCancelEvent_Release(This) (This)->lpVtbl->Release(This)
#define IObjectWithCancelEvent_GetCancelEvent(This, phEvent) (This)->lpVtbl->GetCancelEvent(This, phEvent)
declare function IObjectWithCancelEvent_GetCancelEvent_Proxy(byval This as IObjectWithCancelEvent ptr, byval phEvent as HANDLE ptr) as HRESULT
declare sub IObjectWithCancelEvent_GetCancelEvent_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IUserNotification_INTERFACE_DEFINED__
extern IID_IUserNotification as const GUID
type IUserNotification as IUserNotification_

type IUserNotificationVtbl
	QueryInterface as function(byval This as IUserNotification ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IUserNotification ptr) as ULONG
	Release as function(byval This as IUserNotification ptr) as ULONG
	SetBalloonInfo as function(byval This as IUserNotification ptr, byval pszTitle as LPCWSTR, byval pszText as LPCWSTR, byval dwInfoFlags as DWORD) as HRESULT
	SetBalloonRetry as function(byval This as IUserNotification ptr, byval dwShowTime as DWORD, byval dwInterval as DWORD, byval cRetryCount as UINT) as HRESULT
	SetIconInfo as function(byval This as IUserNotification ptr, byval hIcon as HICON, byval pszToolTip as LPCWSTR) as HRESULT
	Show as function(byval This as IUserNotification ptr, byval pqc as IQueryContinue ptr, byval dwContinuePollInterval as DWORD) as HRESULT

	#ifdef UNICODE
		PlaySoundW as function(byval This as IUserNotification ptr, byval pszSoundName as LPCWSTR) as HRESULT
	#else
		PlaySoundA as function(byval This as IUserNotification ptr, byval pszSoundName as LPCWSTR) as HRESULT
	#endif
end type

type IUserNotification_
	lpVtbl as IUserNotificationVtbl ptr
end type

#define IUserNotification_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IUserNotification_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IUserNotification_Release(This) (This)->lpVtbl->Release(This)
#define IUserNotification_SetBalloonInfo(This, pszTitle, pszText, dwInfoFlags) (This)->lpVtbl->SetBalloonInfo(This, pszTitle, pszText, dwInfoFlags)
#define IUserNotification_SetBalloonRetry(This, dwShowTime, dwInterval, cRetryCount) (This)->lpVtbl->SetBalloonRetry(This, dwShowTime, dwInterval, cRetryCount)
#define IUserNotification_SetIconInfo(This, hIcon, pszToolTip) (This)->lpVtbl->SetIconInfo(This, hIcon, pszToolTip)
#define IUserNotification_Show(This, pqc, dwContinuePollInterval) (This)->lpVtbl->Show(This, pqc, dwContinuePollInterval)
#define IUserNotification_PlaySound(This, pszSoundName) (This)->lpVtbl->PlaySound(This, pszSoundName)

declare function IUserNotification_SetBalloonInfo_Proxy(byval This as IUserNotification ptr, byval pszTitle as LPCWSTR, byval pszText as LPCWSTR, byval dwInfoFlags as DWORD) as HRESULT
declare sub IUserNotification_SetBalloonInfo_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IUserNotification_SetBalloonRetry_Proxy(byval This as IUserNotification ptr, byval dwShowTime as DWORD, byval dwInterval as DWORD, byval cRetryCount as UINT) as HRESULT
declare sub IUserNotification_SetBalloonRetry_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IUserNotification_SetIconInfo_Proxy(byval This as IUserNotification ptr, byval hIcon as HICON, byval pszToolTip as LPCWSTR) as HRESULT
declare sub IUserNotification_SetIconInfo_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IUserNotification_Show_Proxy(byval This as IUserNotification ptr, byval pqc as IQueryContinue ptr, byval dwContinuePollInterval as DWORD) as HRESULT
declare sub IUserNotification_Show_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IUserNotification_PlaySound_Proxy(byval This as IUserNotification ptr, byval pszSoundName as LPCWSTR) as HRESULT
declare sub IUserNotification_PlaySound_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IUserNotificationCallback_INTERFACE_DEFINED__
extern IID_IUserNotificationCallback as const GUID
type IUserNotificationCallback as IUserNotificationCallback_

type IUserNotificationCallbackVtbl
	QueryInterface as function(byval This as IUserNotificationCallback ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IUserNotificationCallback ptr) as ULONG
	Release as function(byval This as IUserNotificationCallback ptr) as ULONG
	OnBalloonUserClick as function(byval This as IUserNotificationCallback ptr, byval pt as POINT ptr) as HRESULT
	OnLeftClick as function(byval This as IUserNotificationCallback ptr, byval pt as POINT ptr) as HRESULT
	OnContextMenu as function(byval This as IUserNotificationCallback ptr, byval pt as POINT ptr) as HRESULT
end type

type IUserNotificationCallback_
	lpVtbl as IUserNotificationCallbackVtbl ptr
end type

#define IUserNotificationCallback_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IUserNotificationCallback_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IUserNotificationCallback_Release(This) (This)->lpVtbl->Release(This)
#define IUserNotificationCallback_OnBalloonUserClick(This, pt) (This)->lpVtbl->OnBalloonUserClick(This, pt)
#define IUserNotificationCallback_OnLeftClick(This, pt) (This)->lpVtbl->OnLeftClick(This, pt)
#define IUserNotificationCallback_OnContextMenu(This, pt) (This)->lpVtbl->OnContextMenu(This, pt)

declare function IUserNotificationCallback_OnBalloonUserClick_Proxy(byval This as IUserNotificationCallback ptr, byval pt as POINT ptr) as HRESULT
declare sub IUserNotificationCallback_OnBalloonUserClick_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IUserNotificationCallback_OnLeftClick_Proxy(byval This as IUserNotificationCallback ptr, byval pt as POINT ptr) as HRESULT
declare sub IUserNotificationCallback_OnLeftClick_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IUserNotificationCallback_OnContextMenu_Proxy(byval This as IUserNotificationCallback ptr, byval pt as POINT ptr) as HRESULT
declare sub IUserNotificationCallback_OnContextMenu_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IUserNotification2_INTERFACE_DEFINED__
extern IID_IUserNotification2 as const GUID
type IUserNotification2 as IUserNotification2_

type IUserNotification2Vtbl
	QueryInterface as function(byval This as IUserNotification2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IUserNotification2 ptr) as ULONG
	Release as function(byval This as IUserNotification2 ptr) as ULONG
	SetBalloonInfo as function(byval This as IUserNotification2 ptr, byval pszTitle as LPCWSTR, byval pszText as LPCWSTR, byval dwInfoFlags as DWORD) as HRESULT
	SetBalloonRetry as function(byval This as IUserNotification2 ptr, byval dwShowTime as DWORD, byval dwInterval as DWORD, byval cRetryCount as UINT) as HRESULT
	SetIconInfo as function(byval This as IUserNotification2 ptr, byval hIcon as HICON, byval pszToolTip as LPCWSTR) as HRESULT
	Show as function(byval This as IUserNotification2 ptr, byval pqc as IQueryContinue ptr, byval dwContinuePollInterval as DWORD, byval pSink as IUserNotificationCallback ptr) as HRESULT

	#ifdef UNICODE
		PlaySoundW as function(byval This as IUserNotification2 ptr, byval pszSoundName as LPCWSTR) as HRESULT
	#else
		PlaySoundA as function(byval This as IUserNotification2 ptr, byval pszSoundName as LPCWSTR) as HRESULT
	#endif
end type

type IUserNotification2_
	lpVtbl as IUserNotification2Vtbl ptr
end type

#define IUserNotification2_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IUserNotification2_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IUserNotification2_Release(This) (This)->lpVtbl->Release(This)
#define IUserNotification2_SetBalloonInfo(This, pszTitle, pszText, dwInfoFlags) (This)->lpVtbl->SetBalloonInfo(This, pszTitle, pszText, dwInfoFlags)
#define IUserNotification2_SetBalloonRetry(This, dwShowTime, dwInterval, cRetryCount) (This)->lpVtbl->SetBalloonRetry(This, dwShowTime, dwInterval, cRetryCount)
#define IUserNotification2_SetIconInfo(This, hIcon, pszToolTip) (This)->lpVtbl->SetIconInfo(This, hIcon, pszToolTip)
#define IUserNotification2_Show(This, pqc, dwContinuePollInterval, pSink) (This)->lpVtbl->Show(This, pqc, dwContinuePollInterval, pSink)
#define IUserNotification2_PlaySound(This, pszSoundName) (This)->lpVtbl->PlaySound(This, pszSoundName)

declare function IUserNotification2_SetBalloonInfo_Proxy(byval This as IUserNotification2 ptr, byval pszTitle as LPCWSTR, byval pszText as LPCWSTR, byval dwInfoFlags as DWORD) as HRESULT
declare sub IUserNotification2_SetBalloonInfo_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IUserNotification2_SetBalloonRetry_Proxy(byval This as IUserNotification2 ptr, byval dwShowTime as DWORD, byval dwInterval as DWORD, byval cRetryCount as UINT) as HRESULT
declare sub IUserNotification2_SetBalloonRetry_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IUserNotification2_SetIconInfo_Proxy(byval This as IUserNotification2 ptr, byval hIcon as HICON, byval pszToolTip as LPCWSTR) as HRESULT
declare sub IUserNotification2_SetIconInfo_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IUserNotification2_Show_Proxy(byval This as IUserNotification2 ptr, byval pqc as IQueryContinue ptr, byval dwContinuePollInterval as DWORD, byval pSink as IUserNotificationCallback ptr) as HRESULT
declare sub IUserNotification2_Show_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IUserNotification2_PlaySound_Proxy(byval This as IUserNotification2 ptr, byval pszSoundName as LPCWSTR) as HRESULT
declare sub IUserNotification2_PlaySound_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IItemNameLimits_INTERFACE_DEFINED__
extern IID_IItemNameLimits as const GUID
type IItemNameLimits as IItemNameLimits_

type IItemNameLimitsVtbl
	QueryInterface as function(byval This as IItemNameLimits ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IItemNameLimits ptr) as ULONG
	Release as function(byval This as IItemNameLimits ptr) as ULONG
	GetValidCharacters as function(byval This as IItemNameLimits ptr, byval ppwszValidChars as LPWSTR ptr, byval ppwszInvalidChars as LPWSTR ptr) as HRESULT
	GetMaxLength as function(byval This as IItemNameLimits ptr, byval pszName as LPCWSTR, byval piMaxNameLen as long ptr) as HRESULT
end type

type IItemNameLimits_
	lpVtbl as IItemNameLimitsVtbl ptr
end type

#define IItemNameLimits_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IItemNameLimits_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IItemNameLimits_Release(This) (This)->lpVtbl->Release(This)
#define IItemNameLimits_GetValidCharacters(This, ppwszValidChars, ppwszInvalidChars) (This)->lpVtbl->GetValidCharacters(This, ppwszValidChars, ppwszInvalidChars)
#define IItemNameLimits_GetMaxLength(This, pszName, piMaxNameLen) (This)->lpVtbl->GetMaxLength(This, pszName, piMaxNameLen)

declare function IItemNameLimits_GetValidCharacters_Proxy(byval This as IItemNameLimits ptr, byval ppwszValidChars as LPWSTR ptr, byval ppwszInvalidChars as LPWSTR ptr) as HRESULT
declare sub IItemNameLimits_GetValidCharacters_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IItemNameLimits_GetMaxLength_Proxy(byval This as IItemNameLimits ptr, byval pszName as LPCWSTR, byval piMaxNameLen as long ptr) as HRESULT
declare sub IItemNameLimits_GetMaxLength_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#if _WIN32_WINNT >= &h0600
	#define __ISearchFolderItemFactory_INTERFACE_DEFINED__
	extern IID_ISearchFolderItemFactory as const GUID
	type ISearchFolderItemFactory as ISearchFolderItemFactory_

	type ISearchFolderItemFactoryVtbl
		QueryInterface as function(byval This as ISearchFolderItemFactory ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as ISearchFolderItemFactory ptr) as ULONG
		Release as function(byval This as ISearchFolderItemFactory ptr) as ULONG
		SetDisplayName as function(byval This as ISearchFolderItemFactory ptr, byval pszDisplayName as LPCWSTR) as HRESULT
		SetFolderTypeID as function(byval This as ISearchFolderItemFactory ptr, byval ftid as FOLDERTYPEID) as HRESULT
		SetFolderLogicalViewMode as function(byval This as ISearchFolderItemFactory ptr, byval flvm as FOLDERLOGICALVIEWMODE) as HRESULT
		SetIconSize as function(byval This as ISearchFolderItemFactory ptr, byval iIconSize as long) as HRESULT
		SetVisibleColumns as function(byval This as ISearchFolderItemFactory ptr, byval cVisibleColumns as UINT, byval rgKey as PROPERTYKEY ptr) as HRESULT
		SetSortColumns as function(byval This as ISearchFolderItemFactory ptr, byval cSortColumns as UINT, byval rgSortColumns as SORTCOLUMN ptr) as HRESULT
		SetGroupColumn as function(byval This as ISearchFolderItemFactory ptr, byval keyGroup as const PROPERTYKEY const ptr) as HRESULT
		SetStacks as function(byval This as ISearchFolderItemFactory ptr, byval cStackKeys as UINT, byval rgStackKeys as PROPERTYKEY ptr) as HRESULT
		SetScope as function(byval This as ISearchFolderItemFactory ptr, byval psiaScope as IShellItemArray ptr) as HRESULT
		SetCondition as function(byval This as ISearchFolderItemFactory ptr, byval pCondition as ICondition ptr) as HRESULT
		GetShellItem as function(byval This as ISearchFolderItemFactory ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
		GetIDList as function(byval This as ISearchFolderItemFactory ptr, byval ppidl as LPITEMIDLIST ptr) as HRESULT
	end type

	type ISearchFolderItemFactory_
		lpVtbl as ISearchFolderItemFactoryVtbl ptr
	end type

	#define ISearchFolderItemFactory_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define ISearchFolderItemFactory_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define ISearchFolderItemFactory_Release(This) (This)->lpVtbl->Release(This)
	#define ISearchFolderItemFactory_SetDisplayName(This, pszDisplayName) (This)->lpVtbl->SetDisplayName(This, pszDisplayName)
	#define ISearchFolderItemFactory_SetFolderTypeID(This, ftid) (This)->lpVtbl->SetFolderTypeID(This, ftid)
	#define ISearchFolderItemFactory_SetFolderLogicalViewMode(This, flvm) (This)->lpVtbl->SetFolderLogicalViewMode(This, flvm)
	#define ISearchFolderItemFactory_SetIconSize(This, iIconSize) (This)->lpVtbl->SetIconSize(This, iIconSize)
	#define ISearchFolderItemFactory_SetVisibleColumns(This, cVisibleColumns, rgKey) (This)->lpVtbl->SetVisibleColumns(This, cVisibleColumns, rgKey)
	#define ISearchFolderItemFactory_SetSortColumns(This, cSortColumns, rgSortColumns) (This)->lpVtbl->SetSortColumns(This, cSortColumns, rgSortColumns)
	#define ISearchFolderItemFactory_SetGroupColumn(This, keyGroup) (This)->lpVtbl->SetGroupColumn(This, keyGroup)
	#define ISearchFolderItemFactory_SetStacks(This, cStackKeys, rgStackKeys) (This)->lpVtbl->SetStacks(This, cStackKeys, rgStackKeys)
	#define ISearchFolderItemFactory_SetScope(This, psiaScope) (This)->lpVtbl->SetScope(This, psiaScope)
	#define ISearchFolderItemFactory_SetCondition(This, pCondition) (This)->lpVtbl->SetCondition(This, pCondition)
	#define ISearchFolderItemFactory_GetShellItem(This, riid, ppv) (This)->lpVtbl->GetShellItem(This, riid, ppv)
	#define ISearchFolderItemFactory_GetIDList(This, ppidl) (This)->lpVtbl->GetIDList(This, ppidl)

	declare function ISearchFolderItemFactory_SetDisplayName_Proxy(byval This as ISearchFolderItemFactory ptr, byval pszDisplayName as LPCWSTR) as HRESULT
	declare sub ISearchFolderItemFactory_SetDisplayName_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function ISearchFolderItemFactory_SetFolderTypeID_Proxy(byval This as ISearchFolderItemFactory ptr, byval ftid as FOLDERTYPEID) as HRESULT
	declare sub ISearchFolderItemFactory_SetFolderTypeID_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function ISearchFolderItemFactory_SetFolderLogicalViewMode_Proxy(byval This as ISearchFolderItemFactory ptr, byval flvm as FOLDERLOGICALVIEWMODE) as HRESULT
	declare sub ISearchFolderItemFactory_SetFolderLogicalViewMode_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function ISearchFolderItemFactory_SetIconSize_Proxy(byval This as ISearchFolderItemFactory ptr, byval iIconSize as long) as HRESULT
	declare sub ISearchFolderItemFactory_SetIconSize_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function ISearchFolderItemFactory_SetVisibleColumns_Proxy(byval This as ISearchFolderItemFactory ptr, byval cVisibleColumns as UINT, byval rgKey as PROPERTYKEY ptr) as HRESULT
	declare sub ISearchFolderItemFactory_SetVisibleColumns_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function ISearchFolderItemFactory_SetSortColumns_Proxy(byval This as ISearchFolderItemFactory ptr, byval cSortColumns as UINT, byval rgSortColumns as SORTCOLUMN ptr) as HRESULT
	declare sub ISearchFolderItemFactory_SetSortColumns_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function ISearchFolderItemFactory_SetGroupColumn_Proxy(byval This as ISearchFolderItemFactory ptr, byval keyGroup as const PROPERTYKEY const ptr) as HRESULT
	declare sub ISearchFolderItemFactory_SetGroupColumn_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function ISearchFolderItemFactory_SetStacks_Proxy(byval This as ISearchFolderItemFactory ptr, byval cStackKeys as UINT, byval rgStackKeys as PROPERTYKEY ptr) as HRESULT
	declare sub ISearchFolderItemFactory_SetStacks_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function ISearchFolderItemFactory_SetScope_Proxy(byval This as ISearchFolderItemFactory ptr, byval psiaScope as IShellItemArray ptr) as HRESULT
	declare sub ISearchFolderItemFactory_SetScope_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function ISearchFolderItemFactory_SetCondition_Proxy(byval This as ISearchFolderItemFactory ptr, byval pCondition as ICondition ptr) as HRESULT
	declare sub ISearchFolderItemFactory_SetCondition_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function ISearchFolderItemFactory_GetShellItem_Proxy(byval This as ISearchFolderItemFactory ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	declare sub ISearchFolderItemFactory_GetShellItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function ISearchFolderItemFactory_GetIDList_Proxy(byval This as ISearchFolderItemFactory ptr, byval ppidl as LPITEMIDLIST ptr) as HRESULT
	declare sub ISearchFolderItemFactory_GetIDList_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#endif

const IEI_PRIORITY_MAX = ITSAT_MAX_PRIORITY
const IEI_PRIORITY_MIN = ITSAT_MIN_PRIORITY
const IEIT_PRIORITY_NORMAL = ITSAT_DEFAULT_PRIORITY
const IEIFLAG_ASYNC = &h0001
const IEIFLAG_CACHE = &h0002
const IEIFLAG_ASPECT = &h0004
const IEIFLAG_OFFLINE = &h0008
const IEIFLAG_GLEAM = &h0010
const IEIFLAG_SCREEN = &h0020
const IEIFLAG_ORIGSIZE = &h0040
const IEIFLAG_NOSTAMP = &h0080
const IEIFLAG_NOBORDER = &h0100
const IEIFLAG_QUALITY = &h0200
const IEIFLAG_REFRESH = &h0400
#define __IExtractImage_INTERFACE_DEFINED__
extern IID_IExtractImage as const GUID
type IExtractImage as IExtractImage_

type IExtractImageVtbl
	QueryInterface as function(byval This as IExtractImage ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IExtractImage ptr) as ULONG
	Release as function(byval This as IExtractImage ptr) as ULONG
	GetLocation as function(byval This as IExtractImage ptr, byval pszPathBuffer as LPWSTR, byval cch as DWORD, byval pdwPriority as DWORD ptr, byval prgSize as const SIZE ptr, byval dwRecClrDepth as DWORD, byval pdwFlags as DWORD ptr) as HRESULT
	Extract as function(byval This as IExtractImage ptr, byval phBmpThumbnail as HBITMAP ptr) as HRESULT
end type

type IExtractImage_
	lpVtbl as IExtractImageVtbl ptr
end type

#define IExtractImage_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IExtractImage_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IExtractImage_Release(This) (This)->lpVtbl->Release(This)
#define IExtractImage_GetLocation(This, pszPathBuffer, cch, pdwPriority, prgSize, dwRecClrDepth, pdwFlags) (This)->lpVtbl->GetLocation(This, pszPathBuffer, cch, pdwPriority, prgSize, dwRecClrDepth, pdwFlags)
#define IExtractImage_Extract(This, phBmpThumbnail) (This)->lpVtbl->Extract(This, phBmpThumbnail)

declare function IExtractImage_GetLocation_Proxy(byval This as IExtractImage ptr, byval pszPathBuffer as LPWSTR, byval cch as DWORD, byval pdwPriority as DWORD ptr, byval prgSize as const SIZE ptr, byval dwRecClrDepth as DWORD, byval pdwFlags as DWORD ptr) as HRESULT
declare sub IExtractImage_GetLocation_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IExtractImage_Extract_Proxy(byval This as IExtractImage ptr, byval phBmpThumbnail as HBITMAP ptr) as HRESULT
declare sub IExtractImage_Extract_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
type LPEXTRACTIMAGE as IExtractImage ptr
#define __IExtractImage2_INTERFACE_DEFINED__
extern IID_IExtractImage2 as const GUID
type IExtractImage2 as IExtractImage2_

type IExtractImage2Vtbl
	QueryInterface as function(byval This as IExtractImage2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IExtractImage2 ptr) as ULONG
	Release as function(byval This as IExtractImage2 ptr) as ULONG
	GetLocation as function(byval This as IExtractImage2 ptr, byval pszPathBuffer as LPWSTR, byval cch as DWORD, byval pdwPriority as DWORD ptr, byval prgSize as const SIZE ptr, byval dwRecClrDepth as DWORD, byval pdwFlags as DWORD ptr) as HRESULT
	Extract as function(byval This as IExtractImage2 ptr, byval phBmpThumbnail as HBITMAP ptr) as HRESULT
	GetDateStamp as function(byval This as IExtractImage2 ptr, byval pDateStamp as FILETIME ptr) as HRESULT
end type

type IExtractImage2_
	lpVtbl as IExtractImage2Vtbl ptr
end type

#define IExtractImage2_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IExtractImage2_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IExtractImage2_Release(This) (This)->lpVtbl->Release(This)
#define IExtractImage2_GetLocation(This, pszPathBuffer, cch, pdwPriority, prgSize, dwRecClrDepth, pdwFlags) (This)->lpVtbl->GetLocation(This, pszPathBuffer, cch, pdwPriority, prgSize, dwRecClrDepth, pdwFlags)
#define IExtractImage2_Extract(This, phBmpThumbnail) (This)->lpVtbl->Extract(This, phBmpThumbnail)
#define IExtractImage2_GetDateStamp(This, pDateStamp) (This)->lpVtbl->GetDateStamp(This, pDateStamp)
declare function IExtractImage2_GetDateStamp_Proxy(byval This as IExtractImage2 ptr, byval pDateStamp as FILETIME ptr) as HRESULT
declare sub IExtractImage2_GetDateStamp_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
type LPEXTRACTIMAGE2 as IExtractImage2 ptr
#define __IThumbnailHandlerFactory_INTERFACE_DEFINED__
extern IID_IThumbnailHandlerFactory as const GUID
type IThumbnailHandlerFactory as IThumbnailHandlerFactory_

type IThumbnailHandlerFactoryVtbl
	QueryInterface as function(byval This as IThumbnailHandlerFactory ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IThumbnailHandlerFactory ptr) as ULONG
	Release as function(byval This as IThumbnailHandlerFactory ptr) as ULONG
	GetThumbnailHandler as function(byval This as IThumbnailHandlerFactory ptr, byval pidlChild as LPCITEMIDLIST, byval pbc as IBindCtx ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
end type

type IThumbnailHandlerFactory_
	lpVtbl as IThumbnailHandlerFactoryVtbl ptr
end type

#define IThumbnailHandlerFactory_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IThumbnailHandlerFactory_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IThumbnailHandlerFactory_Release(This) (This)->lpVtbl->Release(This)
#define IThumbnailHandlerFactory_GetThumbnailHandler(This, pidlChild, pbc, riid, ppv) (This)->lpVtbl->GetThumbnailHandler(This, pidlChild, pbc, riid, ppv)
declare function IThumbnailHandlerFactory_GetThumbnailHandler_Proxy(byval This as IThumbnailHandlerFactory ptr, byval pidlChild as LPCITEMIDLIST, byval pbc as IBindCtx ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare sub IThumbnailHandlerFactory_GetThumbnailHandler_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IParentAndItem_INTERFACE_DEFINED__
extern IID_IParentAndItem as const GUID
type IParentAndItem as IParentAndItem_

type IParentAndItemVtbl
	QueryInterface as function(byval This as IParentAndItem ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IParentAndItem ptr) as ULONG
	Release as function(byval This as IParentAndItem ptr) as ULONG
	SetParentAndItem as function(byval This as IParentAndItem ptr, byval pidlParent as LPCITEMIDLIST, byval psf as IShellFolder ptr, byval pidlChild as LPCITEMIDLIST) as HRESULT
	GetParentAndItem as function(byval This as IParentAndItem ptr, byval ppidlParent as LPITEMIDLIST ptr, byval ppsf as IShellFolder ptr ptr, byval ppidlChild as LPITEMIDLIST ptr) as HRESULT
end type

type IParentAndItem_
	lpVtbl as IParentAndItemVtbl ptr
end type

#define IParentAndItem_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IParentAndItem_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IParentAndItem_Release(This) (This)->lpVtbl->Release(This)
#define IParentAndItem_SetParentAndItem(This, pidlParent, psf, pidlChild) (This)->lpVtbl->SetParentAndItem(This, pidlParent, psf, pidlChild)
#define IParentAndItem_GetParentAndItem(This, ppidlParent, ppsf, ppidlChild) (This)->lpVtbl->GetParentAndItem(This, ppidlParent, ppsf, ppidlChild)

declare function IParentAndItem_SetParentAndItem_Proxy(byval This as IParentAndItem ptr, byval pidlParent as LPCITEMIDLIST, byval psf as IShellFolder ptr, byval pidlChild as LPCITEMIDLIST) as HRESULT
declare sub IParentAndItem_SetParentAndItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IParentAndItem_RemoteGetParentAndItem_Proxy(byval This as IParentAndItem ptr, byval ppidlParent as LPITEMIDLIST ptr, byval ppsf as IShellFolder ptr ptr, byval ppidlChild as LPITEMIDLIST ptr) as HRESULT
declare sub IParentAndItem_RemoteGetParentAndItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IParentAndItem_GetParentAndItem_Proxy(byval This as IParentAndItem ptr, byval ppidlParent as LPITEMIDLIST ptr, byval ppsf as IShellFolder ptr ptr, byval ppidlChild as LPITEMIDLIST ptr) as HRESULT
declare function IParentAndItem_GetParentAndItem_Stub(byval This as IParentAndItem ptr, byval ppidlParent as LPITEMIDLIST ptr, byval ppsf as IShellFolder ptr ptr, byval ppidlChild as LPITEMIDLIST ptr) as HRESULT
#define __IDockingWindow_INTERFACE_DEFINED__
extern IID_IDockingWindow as const GUID
type IDockingWindow as IDockingWindow_

type IDockingWindowVtbl
	QueryInterface as function(byval This as IDockingWindow ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDockingWindow ptr) as ULONG
	Release as function(byval This as IDockingWindow ptr) as ULONG
	GetWindow as function(byval This as IDockingWindow ptr, byval phwnd as HWND ptr) as HRESULT
	ContextSensitiveHelp as function(byval This as IDockingWindow ptr, byval fEnterMode as WINBOOL) as HRESULT
	ShowDW as function(byval This as IDockingWindow ptr, byval fShow as WINBOOL) as HRESULT
	CloseDW as function(byval This as IDockingWindow ptr, byval dwReserved as DWORD) as HRESULT
	ResizeBorderDW as function(byval This as IDockingWindow ptr, byval prcBorder as LPCRECT, byval punkToolbarSite as IUnknown ptr, byval fReserved as WINBOOL) as HRESULT
end type

type IDockingWindow_
	lpVtbl as IDockingWindowVtbl ptr
end type

#define IDockingWindow_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IDockingWindow_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IDockingWindow_Release(This) (This)->lpVtbl->Release(This)
#define IDockingWindow_GetWindow(This, phwnd) (This)->lpVtbl->GetWindow(This, phwnd)
#define IDockingWindow_ContextSensitiveHelp(This, fEnterMode) (This)->lpVtbl->ContextSensitiveHelp(This, fEnterMode)
#define IDockingWindow_ShowDW(This, fShow) (This)->lpVtbl->ShowDW(This, fShow)
#define IDockingWindow_CloseDW(This, dwReserved) (This)->lpVtbl->CloseDW(This, dwReserved)
#define IDockingWindow_ResizeBorderDW(This, prcBorder, punkToolbarSite, fReserved) (This)->lpVtbl->ResizeBorderDW(This, prcBorder, punkToolbarSite, fReserved)

declare function IDockingWindow_ShowDW_Proxy(byval This as IDockingWindow ptr, byval fShow as WINBOOL) as HRESULT
declare sub IDockingWindow_ShowDW_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDockingWindow_CloseDW_Proxy(byval This as IDockingWindow ptr, byval dwReserved as DWORD) as HRESULT
declare sub IDockingWindow_CloseDW_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDockingWindow_ResizeBorderDW_Proxy(byval This as IDockingWindow ptr, byval prcBorder as LPCRECT, byval punkToolbarSite as IUnknown ptr, byval fReserved as WINBOOL) as HRESULT
declare sub IDockingWindow_ResizeBorderDW_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

const DBIM_MINSIZE = &h0001
const DBIM_MAXSIZE = &h0002
const DBIM_INTEGRAL = &h0004
const DBIM_ACTUAL = &h0008
const DBIM_TITLE = &h0010
const DBIM_MODEFLAGS = &h0020
const DBIM_BKCOLOR = &h0040

type DESKBANDINFO
	dwMask as DWORD
	ptMinSize as POINTL
	ptMaxSize as POINTL
	ptIntegral as POINTL
	ptActual as POINTL
	wszTitle as wstring * 256
	dwModeFlags as DWORD
	crBkgnd as COLORREF
end type

const DBIMF_NORMAL = &h0000
const DBIMF_FIXED = &h0001
const DBIMF_FIXEDBMP = &h0004
const DBIMF_VARIABLEHEIGHT = &h0008
const DBIMF_UNDELETEABLE = &h0010
const DBIMF_DEBOSSED = &h0020
const DBIMF_BKCOLOR = &h0040
const DBIMF_USECHEVRON = &h0080
const DBIMF_BREAK = &h0100
const DBIMF_ADDTOFRONT = &h0200
const DBIMF_TOPALIGN = &h0400

#if _WIN32_WINNT >= &h0600
	const DBIMF_NOGRIPPER = &h0800
	const DBIMF_ALWAYSGRIPPER = &h1000
	const DBIMF_NOMARGINS = &h2000
#endif

const DBIF_VIEWMODE_NORMAL = &h0000
const DBIF_VIEWMODE_VERTICAL = &h0001
const DBIF_VIEWMODE_FLOATING = &h0002
const DBIF_VIEWMODE_TRANSPARENT = &h0004

type tagDESKBANDCID as long
enum
	DBID_BANDINFOCHANGED = 0
	DBID_SHOWONLY = 1
	DBID_MAXIMIZEBAND = 2
	DBID_PUSHCHEVRON = 3
	DBID_DELAYINIT = 4
	DBID_FINISHINIT = 5
	DBID_SETWINDOWTHEME = 6
	DBID_PERMITAUTOHIDE = 7
end enum

const DBPC_SELECTFIRST = cast(DWORD, -1)
const DBPC_SELECTLAST = cast(DWORD, -2)
#define __IDeskBand_INTERFACE_DEFINED__
extern IID_IDeskBand as const GUID
extern CGID_DeskBand alias "IID_IDeskBand" as const GUID
type IDeskBand as IDeskBand_

type IDeskBandVtbl
	QueryInterface as function(byval This as IDeskBand ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDeskBand ptr) as ULONG
	Release as function(byval This as IDeskBand ptr) as ULONG
	GetWindow as function(byval This as IDeskBand ptr, byval phwnd as HWND ptr) as HRESULT
	ContextSensitiveHelp as function(byval This as IDeskBand ptr, byval fEnterMode as WINBOOL) as HRESULT
	ShowDW as function(byval This as IDeskBand ptr, byval fShow as WINBOOL) as HRESULT
	CloseDW as function(byval This as IDeskBand ptr, byval dwReserved as DWORD) as HRESULT
	ResizeBorderDW as function(byval This as IDeskBand ptr, byval prcBorder as LPCRECT, byval punkToolbarSite as IUnknown ptr, byval fReserved as WINBOOL) as HRESULT
	GetBandInfo as function(byval This as IDeskBand ptr, byval dwBandID as DWORD, byval dwViewMode as DWORD, byval pdbi as DESKBANDINFO ptr) as HRESULT
end type

type IDeskBand_
	lpVtbl as IDeskBandVtbl ptr
end type

#define IDeskBand_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IDeskBand_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IDeskBand_Release(This) (This)->lpVtbl->Release(This)
#define IDeskBand_GetWindow(This, phwnd) (This)->lpVtbl->GetWindow(This, phwnd)
#define IDeskBand_ContextSensitiveHelp(This, fEnterMode) (This)->lpVtbl->ContextSensitiveHelp(This, fEnterMode)
#define IDeskBand_ShowDW(This, fShow) (This)->lpVtbl->ShowDW(This, fShow)
#define IDeskBand_CloseDW(This, dwReserved) (This)->lpVtbl->CloseDW(This, dwReserved)
#define IDeskBand_ResizeBorderDW(This, prcBorder, punkToolbarSite, fReserved) (This)->lpVtbl->ResizeBorderDW(This, prcBorder, punkToolbarSite, fReserved)
#define IDeskBand_GetBandInfo(This, dwBandID, dwViewMode, pdbi) (This)->lpVtbl->GetBandInfo(This, dwBandID, dwViewMode, pdbi)
declare function IDeskBand_GetBandInfo_Proxy(byval This as IDeskBand ptr, byval dwBandID as DWORD, byval dwViewMode as DWORD, byval pdbi as DESKBANDINFO ptr) as HRESULT
declare sub IDeskBand_GetBandInfo_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#if _WIN32_WINNT >= &h0600
	#define __IDeskBandInfo_INTERFACE_DEFINED__
	extern IID_IDeskBandInfo as const GUID
	type IDeskBandInfo as IDeskBandInfo_

	type IDeskBandInfoVtbl
		QueryInterface as function(byval This as IDeskBandInfo ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IDeskBandInfo ptr) as ULONG
		Release as function(byval This as IDeskBandInfo ptr) as ULONG
		GetDefaultBandWidth as function(byval This as IDeskBandInfo ptr, byval dwBandID as DWORD, byval dwViewMode as DWORD, byval pnWidth as long ptr) as HRESULT
	end type

	type IDeskBandInfo_
		lpVtbl as IDeskBandInfoVtbl ptr
	end type

	#define IDeskBandInfo_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IDeskBandInfo_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IDeskBandInfo_Release(This) (This)->lpVtbl->Release(This)
	#define IDeskBandInfo_GetDefaultBandWidth(This, dwBandID, dwViewMode, pnWidth) (This)->lpVtbl->GetDefaultBandWidth(This, dwBandID, dwViewMode, pnWidth)
	declare function IDeskBandInfo_GetDefaultBandWidth_Proxy(byval This as IDeskBandInfo ptr, byval dwBandID as DWORD, byval dwViewMode as DWORD, byval pnWidth as long ptr) as HRESULT
	declare sub IDeskBandInfo_GetDefaultBandWidth_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	#define __IDeskBand2_INTERFACE_DEFINED__
	extern IID_IDeskBand2 as const GUID
	type IDeskBand2 as IDeskBand2_

	type IDeskBand2Vtbl
		QueryInterface as function(byval This as IDeskBand2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IDeskBand2 ptr) as ULONG
		Release as function(byval This as IDeskBand2 ptr) as ULONG
		GetWindow as function(byval This as IDeskBand2 ptr, byval phwnd as HWND ptr) as HRESULT
		ContextSensitiveHelp as function(byval This as IDeskBand2 ptr, byval fEnterMode as WINBOOL) as HRESULT
		ShowDW as function(byval This as IDeskBand2 ptr, byval fShow as WINBOOL) as HRESULT
		CloseDW as function(byval This as IDeskBand2 ptr, byval dwReserved as DWORD) as HRESULT
		ResizeBorderDW as function(byval This as IDeskBand2 ptr, byval prcBorder as LPCRECT, byval punkToolbarSite as IUnknown ptr, byval fReserved as WINBOOL) as HRESULT
		GetBandInfo as function(byval This as IDeskBand2 ptr, byval dwBandID as DWORD, byval dwViewMode as DWORD, byval pdbi as DESKBANDINFO ptr) as HRESULT
		CanRenderComposited as function(byval This as IDeskBand2 ptr, byval pfCanRenderComposited as WINBOOL ptr) as HRESULT
		SetCompositionState as function(byval This as IDeskBand2 ptr, byval fCompositionEnabled as WINBOOL) as HRESULT
		GetCompositionState as function(byval This as IDeskBand2 ptr, byval pfCompositionEnabled as WINBOOL ptr) as HRESULT
	end type

	type IDeskBand2_
		lpVtbl as IDeskBand2Vtbl ptr
	end type

	#define IDeskBand2_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IDeskBand2_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IDeskBand2_Release(This) (This)->lpVtbl->Release(This)
	#define IDeskBand2_GetWindow(This, phwnd) (This)->lpVtbl->GetWindow(This, phwnd)
	#define IDeskBand2_ContextSensitiveHelp(This, fEnterMode) (This)->lpVtbl->ContextSensitiveHelp(This, fEnterMode)
	#define IDeskBand2_ShowDW(This, fShow) (This)->lpVtbl->ShowDW(This, fShow)
	#define IDeskBand2_CloseDW(This, dwReserved) (This)->lpVtbl->CloseDW(This, dwReserved)
	#define IDeskBand2_ResizeBorderDW(This, prcBorder, punkToolbarSite, fReserved) (This)->lpVtbl->ResizeBorderDW(This, prcBorder, punkToolbarSite, fReserved)
	#define IDeskBand2_GetBandInfo(This, dwBandID, dwViewMode, pdbi) (This)->lpVtbl->GetBandInfo(This, dwBandID, dwViewMode, pdbi)
	#define IDeskBand2_CanRenderComposited(This, pfCanRenderComposited) (This)->lpVtbl->CanRenderComposited(This, pfCanRenderComposited)
	#define IDeskBand2_SetCompositionState(This, fCompositionEnabled) (This)->lpVtbl->SetCompositionState(This, fCompositionEnabled)
	#define IDeskBand2_GetCompositionState(This, pfCompositionEnabled) (This)->lpVtbl->GetCompositionState(This, pfCompositionEnabled)

	declare function IDeskBand2_CanRenderComposited_Proxy(byval This as IDeskBand2 ptr, byval pfCanRenderComposited as WINBOOL ptr) as HRESULT
	declare sub IDeskBand2_CanRenderComposited_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IDeskBand2_SetCompositionState_Proxy(byval This as IDeskBand2 ptr, byval fCompositionEnabled as WINBOOL) as HRESULT
	declare sub IDeskBand2_SetCompositionState_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IDeskBand2_GetCompositionState_Proxy(byval This as IDeskBand2 ptr, byval pfCompositionEnabled as WINBOOL ptr) as HRESULT
	declare sub IDeskBand2_GetCompositionState_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#endif

#define __ITaskbarList_INTERFACE_DEFINED__
extern IID_ITaskbarList as const GUID
type ITaskbarList as ITaskbarList_

type ITaskbarListVtbl
	QueryInterface as function(byval This as ITaskbarList ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ITaskbarList ptr) as ULONG
	Release as function(byval This as ITaskbarList ptr) as ULONG
	HrInit as function(byval This as ITaskbarList ptr) as HRESULT
	AddTab as function(byval This as ITaskbarList ptr, byval hwnd as HWND) as HRESULT
	DeleteTab as function(byval This as ITaskbarList ptr, byval hwnd as HWND) as HRESULT
	ActivateTab as function(byval This as ITaskbarList ptr, byval hwnd as HWND) as HRESULT
	SetActiveAlt as function(byval This as ITaskbarList ptr, byval hwnd as HWND) as HRESULT
end type

type ITaskbarList_
	lpVtbl as ITaskbarListVtbl ptr
end type

#define ITaskbarList_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define ITaskbarList_AddRef(This) (This)->lpVtbl->AddRef(This)
#define ITaskbarList_Release(This) (This)->lpVtbl->Release(This)
#define ITaskbarList_HrInit(This) (This)->lpVtbl->HrInit(This)
#define ITaskbarList_AddTab(This, hwnd) (This)->lpVtbl->AddTab(This, hwnd)
#define ITaskbarList_DeleteTab(This, hwnd) (This)->lpVtbl->DeleteTab(This, hwnd)
#define ITaskbarList_ActivateTab(This, hwnd) (This)->lpVtbl->ActivateTab(This, hwnd)
#define ITaskbarList_SetActiveAlt(This, hwnd) (This)->lpVtbl->SetActiveAlt(This, hwnd)

declare function ITaskbarList_HrInit_Proxy(byval This as ITaskbarList ptr) as HRESULT
declare sub ITaskbarList_HrInit_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITaskbarList_AddTab_Proxy(byval This as ITaskbarList ptr, byval hwnd as HWND) as HRESULT
declare sub ITaskbarList_AddTab_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITaskbarList_DeleteTab_Proxy(byval This as ITaskbarList ptr, byval hwnd as HWND) as HRESULT
declare sub ITaskbarList_DeleteTab_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITaskbarList_ActivateTab_Proxy(byval This as ITaskbarList ptr, byval hwnd as HWND) as HRESULT
declare sub ITaskbarList_ActivateTab_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITaskbarList_SetActiveAlt_Proxy(byval This as ITaskbarList ptr, byval hwnd as HWND) as HRESULT
declare sub ITaskbarList_SetActiveAlt_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __ITaskbarList2_INTERFACE_DEFINED__
extern IID_ITaskbarList2 as const GUID
type ITaskbarList2 as ITaskbarList2_

type ITaskbarList2Vtbl
	QueryInterface as function(byval This as ITaskbarList2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ITaskbarList2 ptr) as ULONG
	Release as function(byval This as ITaskbarList2 ptr) as ULONG
	HrInit as function(byval This as ITaskbarList2 ptr) as HRESULT
	AddTab as function(byval This as ITaskbarList2 ptr, byval hwnd as HWND) as HRESULT
	DeleteTab as function(byval This as ITaskbarList2 ptr, byval hwnd as HWND) as HRESULT
	ActivateTab as function(byval This as ITaskbarList2 ptr, byval hwnd as HWND) as HRESULT
	SetActiveAlt as function(byval This as ITaskbarList2 ptr, byval hwnd as HWND) as HRESULT
	MarkFullscreenWindow as function(byval This as ITaskbarList2 ptr, byval hwnd as HWND, byval fFullscreen as WINBOOL) as HRESULT
end type

type ITaskbarList2_
	lpVtbl as ITaskbarList2Vtbl ptr
end type

#define ITaskbarList2_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define ITaskbarList2_AddRef(This) (This)->lpVtbl->AddRef(This)
#define ITaskbarList2_Release(This) (This)->lpVtbl->Release(This)
#define ITaskbarList2_HrInit(This) (This)->lpVtbl->HrInit(This)
#define ITaskbarList2_AddTab(This, hwnd) (This)->lpVtbl->AddTab(This, hwnd)
#define ITaskbarList2_DeleteTab(This, hwnd) (This)->lpVtbl->DeleteTab(This, hwnd)
#define ITaskbarList2_ActivateTab(This, hwnd) (This)->lpVtbl->ActivateTab(This, hwnd)
#define ITaskbarList2_SetActiveAlt(This, hwnd) (This)->lpVtbl->SetActiveAlt(This, hwnd)
#define ITaskbarList2_MarkFullscreenWindow(This, hwnd, fFullscreen) (This)->lpVtbl->MarkFullscreenWindow(This, hwnd, fFullscreen)
declare function ITaskbarList2_MarkFullscreenWindow_Proxy(byval This as ITaskbarList2 ptr, byval hwnd as HWND, byval fFullscreen as WINBOOL) as HRESULT
declare sub ITaskbarList2_MarkFullscreenWindow_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

type THUMBBUTTONFLAGS as long
enum
	THBF_ENABLED = &h0
	THBF_DISABLED = &h1
	THBF_DISMISSONCLICK = &h2
	THBF_NOBACKGROUND = &h4
	THBF_HIDDEN = &h8
	THBF_NONINTERACTIVE = &h10
end enum

type THUMBBUTTONMASK as long
enum
	THB_BITMAP = &h1
	THB_ICON = &h2
	THB_TOOLTIP = &h4
	THB_FLAGS = &h8
end enum

type THUMBBUTTON
	dwMask as THUMBBUTTONMASK
	iId as UINT
	iBitmap as UINT
	hIcon as HICON
	szTip as wstring * 260
	dwFlags as THUMBBUTTONFLAGS
end type

type LPTHUMBBUTTON as THUMBBUTTON ptr
const THBN_CLICKED = &h1800
#define __ITaskbarList3_INTERFACE_DEFINED__

type TBPFLAG as long
enum
	TBPF_NOPROGRESS = &h0
	TBPF_INDETERMINATE = &h1
	TBPF_NORMAL = &h2
	TBPF_ERROR = &h4
	TBPF_PAUSED = &h8
end enum

extern IID_ITaskbarList3 as const GUID
type ITaskbarList3 as ITaskbarList3_

type ITaskbarList3Vtbl
	QueryInterface as function(byval This as ITaskbarList3 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ITaskbarList3 ptr) as ULONG
	Release as function(byval This as ITaskbarList3 ptr) as ULONG
	HrInit as function(byval This as ITaskbarList3 ptr) as HRESULT
	AddTab as function(byval This as ITaskbarList3 ptr, byval hwnd as HWND) as HRESULT
	DeleteTab as function(byval This as ITaskbarList3 ptr, byval hwnd as HWND) as HRESULT
	ActivateTab as function(byval This as ITaskbarList3 ptr, byval hwnd as HWND) as HRESULT
	SetActiveAlt as function(byval This as ITaskbarList3 ptr, byval hwnd as HWND) as HRESULT
	MarkFullscreenWindow as function(byval This as ITaskbarList3 ptr, byval hwnd as HWND, byval fFullscreen as WINBOOL) as HRESULT
	SetProgressValue as function(byval This as ITaskbarList3 ptr, byval hwnd as HWND, byval ullCompleted as ULONGLONG, byval ullTotal as ULONGLONG) as HRESULT
	SetProgressState as function(byval This as ITaskbarList3 ptr, byval hwnd as HWND, byval tbpFlags as TBPFLAG) as HRESULT
	RegisterTab as function(byval This as ITaskbarList3 ptr, byval hwndTab as HWND, byval hwndMDI as HWND) as HRESULT
	UnregisterTab as function(byval This as ITaskbarList3 ptr, byval hwndTab as HWND) as HRESULT
	SetTabOrder as function(byval This as ITaskbarList3 ptr, byval hwndTab as HWND, byval hwndInsertBefore as HWND) as HRESULT
	SetTabActive as function(byval This as ITaskbarList3 ptr, byval hwndTab as HWND, byval hwndMDI as HWND, byval dwReserved as DWORD) as HRESULT
	ThumbBarAddButtons as function(byval This as ITaskbarList3 ptr, byval hwnd as HWND, byval cButtons as UINT, byval pButton as LPTHUMBBUTTON) as HRESULT
	ThumbBarUpdateButtons as function(byval This as ITaskbarList3 ptr, byval hwnd as HWND, byval cButtons as UINT, byval pButton as LPTHUMBBUTTON) as HRESULT
	ThumbBarSetImageList as function(byval This as ITaskbarList3 ptr, byval hwnd as HWND, byval himl as HIMAGELIST) as HRESULT
	SetOverlayIcon as function(byval This as ITaskbarList3 ptr, byval hwnd as HWND, byval hIcon as HICON, byval pszDescription as LPCWSTR) as HRESULT
	SetThumbnailTooltip as function(byval This as ITaskbarList3 ptr, byval hwnd as HWND, byval pszTip as LPCWSTR) as HRESULT
	SetThumbnailClip as function(byval This as ITaskbarList3 ptr, byval hwnd as HWND, byval prcClip as RECT ptr) as HRESULT
end type

type ITaskbarList3_
	lpVtbl as ITaskbarList3Vtbl ptr
end type

#define ITaskbarList3_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define ITaskbarList3_AddRef(This) (This)->lpVtbl->AddRef(This)
#define ITaskbarList3_Release(This) (This)->lpVtbl->Release(This)
#define ITaskbarList3_HrInit(This) (This)->lpVtbl->HrInit(This)
#define ITaskbarList3_AddTab(This, hwnd) (This)->lpVtbl->AddTab(This, hwnd)
#define ITaskbarList3_DeleteTab(This, hwnd) (This)->lpVtbl->DeleteTab(This, hwnd)
#define ITaskbarList3_ActivateTab(This, hwnd) (This)->lpVtbl->ActivateTab(This, hwnd)
#define ITaskbarList3_SetActiveAlt(This, hwnd) (This)->lpVtbl->SetActiveAlt(This, hwnd)
#define ITaskbarList3_MarkFullscreenWindow(This, hwnd, fFullscreen) (This)->lpVtbl->MarkFullscreenWindow(This, hwnd, fFullscreen)
#define ITaskbarList3_SetProgressValue(This, hwnd, ullCompleted, ullTotal) (This)->lpVtbl->SetProgressValue(This, hwnd, ullCompleted, ullTotal)
#define ITaskbarList3_SetProgressState(This, hwnd, tbpFlags) (This)->lpVtbl->SetProgressState(This, hwnd, tbpFlags)
#define ITaskbarList3_RegisterTab(This, hwndTab, hwndMDI) (This)->lpVtbl->RegisterTab(This, hwndTab, hwndMDI)
#define ITaskbarList3_UnregisterTab(This, hwndTab) (This)->lpVtbl->UnregisterTab(This, hwndTab)
#define ITaskbarList3_SetTabOrder(This, hwndTab, hwndInsertBefore) (This)->lpVtbl->SetTabOrder(This, hwndTab, hwndInsertBefore)
#define ITaskbarList3_SetTabActive(This, hwndTab, hwndMDI, dwReserved) (This)->lpVtbl->SetTabActive(This, hwndTab, hwndMDI, dwReserved)
#define ITaskbarList3_ThumbBarAddButtons(This, hwnd, cButtons, pButton) (This)->lpVtbl->ThumbBarAddButtons(This, hwnd, cButtons, pButton)
#define ITaskbarList3_ThumbBarUpdateButtons(This, hwnd, cButtons, pButton) (This)->lpVtbl->ThumbBarUpdateButtons(This, hwnd, cButtons, pButton)
#define ITaskbarList3_ThumbBarSetImageList(This, hwnd, himl) (This)->lpVtbl->ThumbBarSetImageList(This, hwnd, himl)
#define ITaskbarList3_SetOverlayIcon(This, hwnd, hIcon, pszDescription) (This)->lpVtbl->SetOverlayIcon(This, hwnd, hIcon, pszDescription)
#define ITaskbarList3_SetThumbnailTooltip(This, hwnd, pszTip) (This)->lpVtbl->SetThumbnailTooltip(This, hwnd, pszTip)
#define ITaskbarList3_SetThumbnailClip(This, hwnd, prcClip) (This)->lpVtbl->SetThumbnailClip(This, hwnd, prcClip)

declare function ITaskbarList3_SetProgressValue_Proxy(byval This as ITaskbarList3 ptr, byval hwnd as HWND, byval ullCompleted as ULONGLONG, byval ullTotal as ULONGLONG) as HRESULT
declare sub ITaskbarList3_SetProgressValue_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITaskbarList3_SetProgressState_Proxy(byval This as ITaskbarList3 ptr, byval hwnd as HWND, byval tbpFlags as TBPFLAG) as HRESULT
declare sub ITaskbarList3_SetProgressState_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITaskbarList3_RegisterTab_Proxy(byval This as ITaskbarList3 ptr, byval hwndTab as HWND, byval hwndMDI as HWND) as HRESULT
declare sub ITaskbarList3_RegisterTab_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITaskbarList3_UnregisterTab_Proxy(byval This as ITaskbarList3 ptr, byval hwndTab as HWND) as HRESULT
declare sub ITaskbarList3_UnregisterTab_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITaskbarList3_SetTabOrder_Proxy(byval This as ITaskbarList3 ptr, byval hwndTab as HWND, byval hwndInsertBefore as HWND) as HRESULT
declare sub ITaskbarList3_SetTabOrder_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITaskbarList3_SetTabActive_Proxy(byval This as ITaskbarList3 ptr, byval hwndTab as HWND, byval hwndMDI as HWND, byval dwReserved as DWORD) as HRESULT
declare sub ITaskbarList3_SetTabActive_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITaskbarList3_ThumbBarAddButtons_Proxy(byval This as ITaskbarList3 ptr, byval hwnd as HWND, byval cButtons as UINT, byval pButton as LPTHUMBBUTTON) as HRESULT
declare sub ITaskbarList3_ThumbBarAddButtons_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITaskbarList3_ThumbBarUpdateButtons_Proxy(byval This as ITaskbarList3 ptr, byval hwnd as HWND, byval cButtons as UINT, byval pButton as LPTHUMBBUTTON) as HRESULT
declare sub ITaskbarList3_ThumbBarUpdateButtons_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITaskbarList3_ThumbBarSetImageList_Proxy(byval This as ITaskbarList3 ptr, byval hwnd as HWND, byval himl as HIMAGELIST) as HRESULT
declare sub ITaskbarList3_ThumbBarSetImageList_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITaskbarList3_SetOverlayIcon_Proxy(byval This as ITaskbarList3 ptr, byval hwnd as HWND, byval hIcon as HICON, byval pszDescription as LPCWSTR) as HRESULT
declare sub ITaskbarList3_SetOverlayIcon_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITaskbarList3_SetThumbnailTooltip_Proxy(byval This as ITaskbarList3 ptr, byval hwnd as HWND, byval pszTip as LPCWSTR) as HRESULT
declare sub ITaskbarList3_SetThumbnailTooltip_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITaskbarList3_SetThumbnailClip_Proxy(byval This as ITaskbarList3 ptr, byval hwnd as HWND, byval prcClip as RECT ptr) as HRESULT
declare sub ITaskbarList3_SetThumbnailClip_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __ITaskbarList4_INTERFACE_DEFINED__

type STPFLAG as long
enum
	STPF_NONE = &h0
	STPF_USEAPPTHUMBNAILALWAYS = &h1
	STPF_USEAPPTHUMBNAILWHENACTIVE = &h2
	STPF_USEAPPPEEKALWAYS = &h4
	STPF_USEAPPPEEKWHENACTIVE = &h8
end enum

extern IID_ITaskbarList4 as const GUID
type ITaskbarList4 as ITaskbarList4_

type ITaskbarList4Vtbl
	QueryInterface as function(byval This as ITaskbarList4 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ITaskbarList4 ptr) as ULONG
	Release as function(byval This as ITaskbarList4 ptr) as ULONG
	HrInit as function(byval This as ITaskbarList4 ptr) as HRESULT
	AddTab as function(byval This as ITaskbarList4 ptr, byval hwnd as HWND) as HRESULT
	DeleteTab as function(byval This as ITaskbarList4 ptr, byval hwnd as HWND) as HRESULT
	ActivateTab as function(byval This as ITaskbarList4 ptr, byval hwnd as HWND) as HRESULT
	SetActiveAlt as function(byval This as ITaskbarList4 ptr, byval hwnd as HWND) as HRESULT
	MarkFullscreenWindow as function(byval This as ITaskbarList4 ptr, byval hwnd as HWND, byval fFullscreen as WINBOOL) as HRESULT
	SetProgressValue as function(byval This as ITaskbarList4 ptr, byval hwnd as HWND, byval ullCompleted as ULONGLONG, byval ullTotal as ULONGLONG) as HRESULT
	SetProgressState as function(byval This as ITaskbarList4 ptr, byval hwnd as HWND, byval tbpFlags as TBPFLAG) as HRESULT
	RegisterTab as function(byval This as ITaskbarList4 ptr, byval hwndTab as HWND, byval hwndMDI as HWND) as HRESULT
	UnregisterTab as function(byval This as ITaskbarList4 ptr, byval hwndTab as HWND) as HRESULT
	SetTabOrder as function(byval This as ITaskbarList4 ptr, byval hwndTab as HWND, byval hwndInsertBefore as HWND) as HRESULT
	SetTabActive as function(byval This as ITaskbarList4 ptr, byval hwndTab as HWND, byval hwndMDI as HWND, byval dwReserved as DWORD) as HRESULT
	ThumbBarAddButtons as function(byval This as ITaskbarList4 ptr, byval hwnd as HWND, byval cButtons as UINT, byval pButton as LPTHUMBBUTTON) as HRESULT
	ThumbBarUpdateButtons as function(byval This as ITaskbarList4 ptr, byval hwnd as HWND, byval cButtons as UINT, byval pButton as LPTHUMBBUTTON) as HRESULT
	ThumbBarSetImageList as function(byval This as ITaskbarList4 ptr, byval hwnd as HWND, byval himl as HIMAGELIST) as HRESULT
	SetOverlayIcon as function(byval This as ITaskbarList4 ptr, byval hwnd as HWND, byval hIcon as HICON, byval pszDescription as LPCWSTR) as HRESULT
	SetThumbnailTooltip as function(byval This as ITaskbarList4 ptr, byval hwnd as HWND, byval pszTip as LPCWSTR) as HRESULT
	SetThumbnailClip as function(byval This as ITaskbarList4 ptr, byval hwnd as HWND, byval prcClip as RECT ptr) as HRESULT
	SetTabProperties as function(byval This as ITaskbarList4 ptr, byval hwndTab as HWND, byval stpFlags as STPFLAG) as HRESULT
end type

type ITaskbarList4_
	lpVtbl as ITaskbarList4Vtbl ptr
end type

#define ITaskbarList4_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define ITaskbarList4_AddRef(This) (This)->lpVtbl->AddRef(This)
#define ITaskbarList4_Release(This) (This)->lpVtbl->Release(This)
#define ITaskbarList4_HrInit(This) (This)->lpVtbl->HrInit(This)
#define ITaskbarList4_AddTab(This, hwnd) (This)->lpVtbl->AddTab(This, hwnd)
#define ITaskbarList4_DeleteTab(This, hwnd) (This)->lpVtbl->DeleteTab(This, hwnd)
#define ITaskbarList4_ActivateTab(This, hwnd) (This)->lpVtbl->ActivateTab(This, hwnd)
#define ITaskbarList4_SetActiveAlt(This, hwnd) (This)->lpVtbl->SetActiveAlt(This, hwnd)
#define ITaskbarList4_MarkFullscreenWindow(This, hwnd, fFullscreen) (This)->lpVtbl->MarkFullscreenWindow(This, hwnd, fFullscreen)
#define ITaskbarList4_SetProgressValue(This, hwnd, ullCompleted, ullTotal) (This)->lpVtbl->SetProgressValue(This, hwnd, ullCompleted, ullTotal)
#define ITaskbarList4_SetProgressState(This, hwnd, tbpFlags) (This)->lpVtbl->SetProgressState(This, hwnd, tbpFlags)
#define ITaskbarList4_RegisterTab(This, hwndTab, hwndMDI) (This)->lpVtbl->RegisterTab(This, hwndTab, hwndMDI)
#define ITaskbarList4_UnregisterTab(This, hwndTab) (This)->lpVtbl->UnregisterTab(This, hwndTab)
#define ITaskbarList4_SetTabOrder(This, hwndTab, hwndInsertBefore) (This)->lpVtbl->SetTabOrder(This, hwndTab, hwndInsertBefore)
#define ITaskbarList4_SetTabActive(This, hwndTab, hwndMDI, dwReserved) (This)->lpVtbl->SetTabActive(This, hwndTab, hwndMDI, dwReserved)
#define ITaskbarList4_ThumbBarAddButtons(This, hwnd, cButtons, pButton) (This)->lpVtbl->ThumbBarAddButtons(This, hwnd, cButtons, pButton)
#define ITaskbarList4_ThumbBarUpdateButtons(This, hwnd, cButtons, pButton) (This)->lpVtbl->ThumbBarUpdateButtons(This, hwnd, cButtons, pButton)
#define ITaskbarList4_ThumbBarSetImageList(This, hwnd, himl) (This)->lpVtbl->ThumbBarSetImageList(This, hwnd, himl)
#define ITaskbarList4_SetOverlayIcon(This, hwnd, hIcon, pszDescription) (This)->lpVtbl->SetOverlayIcon(This, hwnd, hIcon, pszDescription)
#define ITaskbarList4_SetThumbnailTooltip(This, hwnd, pszTip) (This)->lpVtbl->SetThumbnailTooltip(This, hwnd, pszTip)
#define ITaskbarList4_SetThumbnailClip(This, hwnd, prcClip) (This)->lpVtbl->SetThumbnailClip(This, hwnd, prcClip)
#define ITaskbarList4_SetTabProperties(This, hwndTab, stpFlags) (This)->lpVtbl->SetTabProperties(This, hwndTab, stpFlags)
declare function ITaskbarList4_SetTabProperties_Proxy(byval This as ITaskbarList4 ptr, byval hwndTab as HWND, byval stpFlags as STPFLAG) as HRESULT
declare sub ITaskbarList4_SetTabProperties_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IStartMenuPinnedList_INTERFACE_DEFINED__
extern IID_IStartMenuPinnedList as const GUID
type IStartMenuPinnedList as IStartMenuPinnedList_

type IStartMenuPinnedListVtbl
	QueryInterface as function(byval This as IStartMenuPinnedList ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IStartMenuPinnedList ptr) as ULONG
	Release as function(byval This as IStartMenuPinnedList ptr) as ULONG
	RemoveFromList as function(byval This as IStartMenuPinnedList ptr, byval pitem as IShellItem ptr) as HRESULT
end type

type IStartMenuPinnedList_
	lpVtbl as IStartMenuPinnedListVtbl ptr
end type

#define IStartMenuPinnedList_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IStartMenuPinnedList_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IStartMenuPinnedList_Release(This) (This)->lpVtbl->Release(This)
#define IStartMenuPinnedList_RemoveFromList(This, pitem) (This)->lpVtbl->RemoveFromList(This, pitem)
declare function IStartMenuPinnedList_RemoveFromList_Proxy(byval This as IStartMenuPinnedList ptr, byval pitem as IShellItem ptr) as HRESULT
declare sub IStartMenuPinnedList_RemoveFromList_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __ICDBurn_INTERFACE_DEFINED__
extern IID_ICDBurn as const GUID
type ICDBurn as ICDBurn_

type ICDBurnVtbl
	QueryInterface as function(byval This as ICDBurn ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ICDBurn ptr) as ULONG
	Release as function(byval This as ICDBurn ptr) as ULONG
	GetRecorderDriveLetter as function(byval This as ICDBurn ptr, byval pszDrive as LPWSTR, byval cch as UINT) as HRESULT
	Burn as function(byval This as ICDBurn ptr, byval hwnd as HWND) as HRESULT
	HasRecordableDrive as function(byval This as ICDBurn ptr, byval pfHasRecorder as WINBOOL ptr) as HRESULT
end type

type ICDBurn_
	lpVtbl as ICDBurnVtbl ptr
end type

#define ICDBurn_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define ICDBurn_AddRef(This) (This)->lpVtbl->AddRef(This)
#define ICDBurn_Release(This) (This)->lpVtbl->Release(This)
#define ICDBurn_GetRecorderDriveLetter(This, pszDrive, cch) (This)->lpVtbl->GetRecorderDriveLetter(This, pszDrive, cch)
#define ICDBurn_Burn(This, hwnd) (This)->lpVtbl->Burn(This, hwnd)
#define ICDBurn_HasRecordableDrive(This, pfHasRecorder) (This)->lpVtbl->HasRecordableDrive(This, pfHasRecorder)

declare function ICDBurn_GetRecorderDriveLetter_Proxy(byval This as ICDBurn ptr, byval pszDrive as LPWSTR, byval cch as UINT) as HRESULT
declare sub ICDBurn_GetRecorderDriveLetter_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICDBurn_Burn_Proxy(byval This as ICDBurn ptr, byval hwnd as HWND) as HRESULT
declare sub ICDBurn_Burn_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICDBurn_HasRecordableDrive_Proxy(byval This as ICDBurn ptr, byval pfHasRecorder as WINBOOL ptr) as HRESULT
declare sub ICDBurn_HasRecordableDrive_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

const IDD_WIZEXTN_FIRST = &h5000
const IDD_WIZEXTN_LAST = &h5100
#define __IWizardSite_INTERFACE_DEFINED__
extern IID_IWizardSite as const GUID
type IWizardSite as IWizardSite_

type IWizardSiteVtbl
	QueryInterface as function(byval This as IWizardSite ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IWizardSite ptr) as ULONG
	Release as function(byval This as IWizardSite ptr) as ULONG
	GetPreviousPage as function(byval This as IWizardSite ptr, byval phpage as HPROPSHEETPAGE ptr) as HRESULT
	GetNextPage as function(byval This as IWizardSite ptr, byval phpage as HPROPSHEETPAGE ptr) as HRESULT
	GetCancelledPage as function(byval This as IWizardSite ptr, byval phpage as HPROPSHEETPAGE ptr) as HRESULT
end type

type IWizardSite_
	lpVtbl as IWizardSiteVtbl ptr
end type

#define IWizardSite_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IWizardSite_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IWizardSite_Release(This) (This)->lpVtbl->Release(This)
#define IWizardSite_GetPreviousPage(This, phpage) (This)->lpVtbl->GetPreviousPage(This, phpage)
#define IWizardSite_GetNextPage(This, phpage) (This)->lpVtbl->GetNextPage(This, phpage)
#define IWizardSite_GetCancelledPage(This, phpage) (This)->lpVtbl->GetCancelledPage(This, phpage)

declare function IWizardSite_GetPreviousPage_Proxy(byval This as IWizardSite ptr, byval phpage as HPROPSHEETPAGE ptr) as HRESULT
declare sub IWizardSite_GetPreviousPage_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWizardSite_GetNextPage_Proxy(byval This as IWizardSite ptr, byval phpage as HPROPSHEETPAGE ptr) as HRESULT
declare sub IWizardSite_GetNextPage_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWizardSite_GetCancelledPage_Proxy(byval This as IWizardSite ptr, byval phpage as HPROPSHEETPAGE ptr) as HRESULT
declare sub IWizardSite_GetCancelledPage_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
extern SID_WizardSite alias "IID_IWizardSite" as const GUID
#define __IWizardExtension_INTERFACE_DEFINED__
extern IID_IWizardExtension as const GUID
type IWizardExtension as IWizardExtension_

type IWizardExtensionVtbl
	QueryInterface as function(byval This as IWizardExtension ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IWizardExtension ptr) as ULONG
	Release as function(byval This as IWizardExtension ptr) as ULONG
	AddPages as function(byval This as IWizardExtension ptr, byval aPages as HPROPSHEETPAGE ptr, byval cPages as UINT, byval pnPagesAdded as UINT ptr) as HRESULT
	GetFirstPage as function(byval This as IWizardExtension ptr, byval phpage as HPROPSHEETPAGE ptr) as HRESULT
	GetLastPage as function(byval This as IWizardExtension ptr, byval phpage as HPROPSHEETPAGE ptr) as HRESULT
end type

type IWizardExtension_
	lpVtbl as IWizardExtensionVtbl ptr
end type

#define IWizardExtension_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IWizardExtension_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IWizardExtension_Release(This) (This)->lpVtbl->Release(This)
#define IWizardExtension_AddPages(This, aPages, cPages, pnPagesAdded) (This)->lpVtbl->AddPages(This, aPages, cPages, pnPagesAdded)
#define IWizardExtension_GetFirstPage(This, phpage) (This)->lpVtbl->GetFirstPage(This, phpage)
#define IWizardExtension_GetLastPage(This, phpage) (This)->lpVtbl->GetLastPage(This, phpage)

declare function IWizardExtension_AddPages_Proxy(byval This as IWizardExtension ptr, byval aPages as HPROPSHEETPAGE ptr, byval cPages as UINT, byval pnPagesAdded as UINT ptr) as HRESULT
declare sub IWizardExtension_AddPages_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWizardExtension_GetFirstPage_Proxy(byval This as IWizardExtension ptr, byval phpage as HPROPSHEETPAGE ptr) as HRESULT
declare sub IWizardExtension_GetFirstPage_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWizardExtension_GetLastPage_Proxy(byval This as IWizardExtension ptr, byval phpage as HPROPSHEETPAGE ptr) as HRESULT
declare sub IWizardExtension_GetLastPage_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IWebWizardExtension_INTERFACE_DEFINED__
extern IID_IWebWizardExtension as const GUID
type IWebWizardExtension as IWebWizardExtension_

type IWebWizardExtensionVtbl
	QueryInterface as function(byval This as IWebWizardExtension ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IWebWizardExtension ptr) as ULONG
	Release as function(byval This as IWebWizardExtension ptr) as ULONG
	AddPages as function(byval This as IWebWizardExtension ptr, byval aPages as HPROPSHEETPAGE ptr, byval cPages as UINT, byval pnPagesAdded as UINT ptr) as HRESULT
	GetFirstPage as function(byval This as IWebWizardExtension ptr, byval phpage as HPROPSHEETPAGE ptr) as HRESULT
	GetLastPage as function(byval This as IWebWizardExtension ptr, byval phpage as HPROPSHEETPAGE ptr) as HRESULT
	SetInitialURL as function(byval This as IWebWizardExtension ptr, byval pszURL as LPCWSTR) as HRESULT
	SetErrorURL as function(byval This as IWebWizardExtension ptr, byval pszErrorURL as LPCWSTR) as HRESULT
end type

type IWebWizardExtension_
	lpVtbl as IWebWizardExtensionVtbl ptr
end type

#define IWebWizardExtension_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IWebWizardExtension_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IWebWizardExtension_Release(This) (This)->lpVtbl->Release(This)
#define IWebWizardExtension_AddPages(This, aPages, cPages, pnPagesAdded) (This)->lpVtbl->AddPages(This, aPages, cPages, pnPagesAdded)
#define IWebWizardExtension_GetFirstPage(This, phpage) (This)->lpVtbl->GetFirstPage(This, phpage)
#define IWebWizardExtension_GetLastPage(This, phpage) (This)->lpVtbl->GetLastPage(This, phpage)
#define IWebWizardExtension_SetInitialURL(This, pszURL) (This)->lpVtbl->SetInitialURL(This, pszURL)
#define IWebWizardExtension_SetErrorURL(This, pszErrorURL) (This)->lpVtbl->SetErrorURL(This, pszErrorURL)

declare function IWebWizardExtension_SetInitialURL_Proxy(byval This as IWebWizardExtension ptr, byval pszURL as LPCWSTR) as HRESULT
declare sub IWebWizardExtension_SetInitialURL_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWebWizardExtension_SetErrorURL_Proxy(byval This as IWebWizardExtension ptr, byval pszErrorURL as LPCWSTR) as HRESULT
declare sub IWebWizardExtension_SetErrorURL_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
extern SID_WebWizardHost alias "IID_IWebWizardExtension" as const GUID

const SHPWHF_NORECOMPRESS = &h00000001
const SHPWHF_NONETPLACECREATE = &h00000002
const SHPWHF_NOFILESELECTOR = &h00000004
const SHPWHF_USEMRU = &h00000008

#if _WIN32_WINNT >= &h0600
	const SHPWHF_ANYLOCATION = &h00000100
#endif

const SHPWHF_VALIDATEVIAWEBFOLDERS = &h00010000
#define __IPublishingWizard_INTERFACE_DEFINED__
extern IID_IPublishingWizard as const GUID
type IPublishingWizard as IPublishingWizard_

type IPublishingWizardVtbl
	QueryInterface as function(byval This as IPublishingWizard ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPublishingWizard ptr) as ULONG
	Release as function(byval This as IPublishingWizard ptr) as ULONG
	AddPages as function(byval This as IPublishingWizard ptr, byval aPages as HPROPSHEETPAGE ptr, byval cPages as UINT, byval pnPagesAdded as UINT ptr) as HRESULT
	GetFirstPage as function(byval This as IPublishingWizard ptr, byval phpage as HPROPSHEETPAGE ptr) as HRESULT
	GetLastPage as function(byval This as IPublishingWizard ptr, byval phpage as HPROPSHEETPAGE ptr) as HRESULT
	Initialize as function(byval This as IPublishingWizard ptr, byval pdo as IDataObject ptr, byval dwOptions as DWORD, byval pszServiceScope as LPCWSTR) as HRESULT
	GetTransferManifest as function(byval This as IPublishingWizard ptr, byval phrFromTransfer as HRESULT ptr, byval pdocManifest as IXMLDOMDocument ptr ptr) as HRESULT
end type

type IPublishingWizard_
	lpVtbl as IPublishingWizardVtbl ptr
end type

#define IPublishingWizard_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IPublishingWizard_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IPublishingWizard_Release(This) (This)->lpVtbl->Release(This)
#define IPublishingWizard_AddPages(This, aPages, cPages, pnPagesAdded) (This)->lpVtbl->AddPages(This, aPages, cPages, pnPagesAdded)
#define IPublishingWizard_GetFirstPage(This, phpage) (This)->lpVtbl->GetFirstPage(This, phpage)
#define IPublishingWizard_GetLastPage(This, phpage) (This)->lpVtbl->GetLastPage(This, phpage)
#define IPublishingWizard_Initialize(This, pdo, dwOptions, pszServiceScope) (This)->lpVtbl->Initialize(This, pdo, dwOptions, pszServiceScope)
#define IPublishingWizard_GetTransferManifest(This, phrFromTransfer, pdocManifest) (This)->lpVtbl->GetTransferManifest(This, phrFromTransfer, pdocManifest)

declare function IPublishingWizard_Initialize_Proxy(byval This as IPublishingWizard ptr, byval pdo as IDataObject ptr, byval dwOptions as DWORD, byval pszServiceScope as LPCWSTR) as HRESULT
declare sub IPublishingWizard_Initialize_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPublishingWizard_GetTransferManifest_Proxy(byval This as IPublishingWizard ptr, byval phrFromTransfer as HRESULT ptr, byval pdocManifest as IXMLDOMDocument ptr ptr) as HRESULT
declare sub IPublishingWizard_GetTransferManifest_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IFolderViewHost_INTERFACE_DEFINED__
extern IID_IFolderViewHost as const GUID
type IFolderViewHost as IFolderViewHost_

type IFolderViewHostVtbl
	QueryInterface as function(byval This as IFolderViewHost ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IFolderViewHost ptr) as ULONG
	Release as function(byval This as IFolderViewHost ptr) as ULONG
	Initialize as function(byval This as IFolderViewHost ptr, byval hwndParent as HWND, byval pdo as IDataObject ptr, byval prc as RECT ptr) as HRESULT
end type

type IFolderViewHost_
	lpVtbl as IFolderViewHostVtbl ptr
end type

#define IFolderViewHost_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IFolderViewHost_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IFolderViewHost_Release(This) (This)->lpVtbl->Release(This)
#define IFolderViewHost_Initialize(This, hwndParent, pdo, prc) (This)->lpVtbl->Initialize(This, hwndParent, pdo, prc)
declare function IFolderViewHost_Initialize_Proxy(byval This as IFolderViewHost ptr, byval hwndParent as HWND, byval pdo as IDataObject ptr, byval prc as RECT ptr) as HRESULT
declare sub IFolderViewHost_Initialize_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#if _WIN32_WINNT >= &h0600
	#define __IExplorerBrowserEvents_INTERFACE_DEFINED__
	extern IID_IExplorerBrowserEvents as const GUID
	type IExplorerBrowserEvents as IExplorerBrowserEvents_

	type IExplorerBrowserEventsVtbl
		QueryInterface as function(byval This as IExplorerBrowserEvents ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IExplorerBrowserEvents ptr) as ULONG
		Release as function(byval This as IExplorerBrowserEvents ptr) as ULONG
		OnNavigationPending as function(byval This as IExplorerBrowserEvents ptr, byval pidlFolder as LPCITEMIDLIST) as HRESULT
		OnViewCreated as function(byval This as IExplorerBrowserEvents ptr, byval psv as IShellView ptr) as HRESULT
		OnNavigationComplete as function(byval This as IExplorerBrowserEvents ptr, byval pidlFolder as LPCITEMIDLIST) as HRESULT
		OnNavigationFailed as function(byval This as IExplorerBrowserEvents ptr, byval pidlFolder as LPCITEMIDLIST) as HRESULT
	end type

	type IExplorerBrowserEvents_
		lpVtbl as IExplorerBrowserEventsVtbl ptr
	end type

	#define IExplorerBrowserEvents_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IExplorerBrowserEvents_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IExplorerBrowserEvents_Release(This) (This)->lpVtbl->Release(This)
	#define IExplorerBrowserEvents_OnNavigationPending(This, pidlFolder) (This)->lpVtbl->OnNavigationPending(This, pidlFolder)
	#define IExplorerBrowserEvents_OnViewCreated(This, psv) (This)->lpVtbl->OnViewCreated(This, psv)
	#define IExplorerBrowserEvents_OnNavigationComplete(This, pidlFolder) (This)->lpVtbl->OnNavigationComplete(This, pidlFolder)
	#define IExplorerBrowserEvents_OnNavigationFailed(This, pidlFolder) (This)->lpVtbl->OnNavigationFailed(This, pidlFolder)

	declare function IExplorerBrowserEvents_OnNavigationPending_Proxy(byval This as IExplorerBrowserEvents ptr, byval pidlFolder as LPCITEMIDLIST) as HRESULT
	declare sub IExplorerBrowserEvents_OnNavigationPending_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IExplorerBrowserEvents_OnViewCreated_Proxy(byval This as IExplorerBrowserEvents ptr, byval psv as IShellView ptr) as HRESULT
	declare sub IExplorerBrowserEvents_OnViewCreated_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IExplorerBrowserEvents_OnNavigationComplete_Proxy(byval This as IExplorerBrowserEvents ptr, byval pidlFolder as LPCITEMIDLIST) as HRESULT
	declare sub IExplorerBrowserEvents_OnNavigationComplete_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IExplorerBrowserEvents_OnNavigationFailed_Proxy(byval This as IExplorerBrowserEvents ptr, byval pidlFolder as LPCITEMIDLIST) as HRESULT
	declare sub IExplorerBrowserEvents_OnNavigationFailed_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

	type EXPLORER_BROWSER_OPTIONS as long
	enum
		EBO_NONE = &h0
		EBO_NAVIGATEONCE = &h1
		EBO_SHOWFRAMES = &h2
		EBO_ALWAYSNAVIGATE = &h4
		EBO_NOTRAVELLOG = &h8
		EBO_NOWRAPPERWINDOW = &h10
		EBO_HTMLSHAREPOINTVIEW = &h20
		EBO_NOBORDER = &h40
		EBO_NOPERSISTVIEWSTATE = &h80
	end enum

	type EXPLORER_BROWSER_FILL_FLAGS as long
	enum
		EBF_NONE = &h0
		EBF_SELECTFROMDATAOBJECT = &h100
		EBF_NODROPTARGET = &h200
	end enum

	#define __IExplorerBrowser_INTERFACE_DEFINED__
	extern IID_IExplorerBrowser as const GUID
	type IExplorerBrowser as IExplorerBrowser_

	type IExplorerBrowserVtbl
		QueryInterface as function(byval This as IExplorerBrowser ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IExplorerBrowser ptr) as ULONG
		Release as function(byval This as IExplorerBrowser ptr) as ULONG
		Initialize as function(byval This as IExplorerBrowser ptr, byval hwndParent as HWND, byval prc as const RECT ptr, byval pfs as const FOLDERSETTINGS ptr) as HRESULT
		Destroy as function(byval This as IExplorerBrowser ptr) as HRESULT
		SetRect as function(byval This as IExplorerBrowser ptr, byval phdwp as HDWP ptr, byval rcBrowser as RECT) as HRESULT
		SetPropertyBag as function(byval This as IExplorerBrowser ptr, byval pszPropertyBag as LPCWSTR) as HRESULT
		SetEmptyText as function(byval This as IExplorerBrowser ptr, byval pszEmptyText as LPCWSTR) as HRESULT
		SetFolderSettings as function(byval This as IExplorerBrowser ptr, byval pfs as const FOLDERSETTINGS ptr) as HRESULT
		Advise as function(byval This as IExplorerBrowser ptr, byval psbe as IExplorerBrowserEvents ptr, byval pdwCookie as DWORD ptr) as HRESULT
		Unadvise as function(byval This as IExplorerBrowser ptr, byval dwCookie as DWORD) as HRESULT
		SetOptions as function(byval This as IExplorerBrowser ptr, byval dwFlag as EXPLORER_BROWSER_OPTIONS) as HRESULT
		GetOptions as function(byval This as IExplorerBrowser ptr, byval pdwFlag as EXPLORER_BROWSER_OPTIONS ptr) as HRESULT
		BrowseToIDList as function(byval This as IExplorerBrowser ptr, byval pidl as LPCITEMIDLIST, byval uFlags as UINT) as HRESULT
		BrowseToObject as function(byval This as IExplorerBrowser ptr, byval punk as IUnknown ptr, byval uFlags as UINT) as HRESULT
		FillFromObject as function(byval This as IExplorerBrowser ptr, byval punk as IUnknown ptr, byval dwFlags as EXPLORER_BROWSER_FILL_FLAGS) as HRESULT
		RemoveAll as function(byval This as IExplorerBrowser ptr) as HRESULT
		GetCurrentView as function(byval This as IExplorerBrowser ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	end type

	type IExplorerBrowser_
		lpVtbl as IExplorerBrowserVtbl ptr
	end type

	#define IExplorerBrowser_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IExplorerBrowser_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IExplorerBrowser_Release(This) (This)->lpVtbl->Release(This)
	#define IExplorerBrowser_Initialize(This, hwndParent, prc, pfs) (This)->lpVtbl->Initialize(This, hwndParent, prc, pfs)
	#define IExplorerBrowser_Destroy(This) (This)->lpVtbl->Destroy(This)
	#define IExplorerBrowser_SetRect(This, phdwp, rcBrowser) (This)->lpVtbl->SetRect(This, phdwp, rcBrowser)
	#define IExplorerBrowser_SetPropertyBag(This, pszPropertyBag) (This)->lpVtbl->SetPropertyBag(This, pszPropertyBag)
	#define IExplorerBrowser_SetEmptyText(This, pszEmptyText) (This)->lpVtbl->SetEmptyText(This, pszEmptyText)
	#define IExplorerBrowser_SetFolderSettings(This, pfs) (This)->lpVtbl->SetFolderSettings(This, pfs)
	#define IExplorerBrowser_Advise(This, psbe, pdwCookie) (This)->lpVtbl->Advise(This, psbe, pdwCookie)
	#define IExplorerBrowser_Unadvise(This, dwCookie) (This)->lpVtbl->Unadvise(This, dwCookie)
	#define IExplorerBrowser_SetOptions(This, dwFlag) (This)->lpVtbl->SetOptions(This, dwFlag)
	#define IExplorerBrowser_GetOptions(This, pdwFlag) (This)->lpVtbl->GetOptions(This, pdwFlag)
	#define IExplorerBrowser_BrowseToIDList(This, pidl, uFlags) (This)->lpVtbl->BrowseToIDList(This, pidl, uFlags)
	#define IExplorerBrowser_BrowseToObject(This, punk, uFlags) (This)->lpVtbl->BrowseToObject(This, punk, uFlags)
	#define IExplorerBrowser_FillFromObject(This, punk, dwFlags) (This)->lpVtbl->FillFromObject(This, punk, dwFlags)
	#define IExplorerBrowser_RemoveAll(This) (This)->lpVtbl->RemoveAll(This)
	#define IExplorerBrowser_GetCurrentView(This, riid, ppv) (This)->lpVtbl->GetCurrentView(This, riid, ppv)

	declare function IExplorerBrowser_Destroy_Proxy(byval This as IExplorerBrowser ptr) as HRESULT
	declare sub IExplorerBrowser_Destroy_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IExplorerBrowser_SetPropertyBag_Proxy(byval This as IExplorerBrowser ptr, byval pszPropertyBag as LPCWSTR) as HRESULT
	declare sub IExplorerBrowser_SetPropertyBag_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IExplorerBrowser_SetEmptyText_Proxy(byval This as IExplorerBrowser ptr, byval pszEmptyText as LPCWSTR) as HRESULT
	declare sub IExplorerBrowser_SetEmptyText_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IExplorerBrowser_SetFolderSettings_Proxy(byval This as IExplorerBrowser ptr, byval pfs as const FOLDERSETTINGS ptr) as HRESULT
	declare sub IExplorerBrowser_SetFolderSettings_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IExplorerBrowser_Advise_Proxy(byval This as IExplorerBrowser ptr, byval psbe as IExplorerBrowserEvents ptr, byval pdwCookie as DWORD ptr) as HRESULT
	declare sub IExplorerBrowser_Advise_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IExplorerBrowser_Unadvise_Proxy(byval This as IExplorerBrowser ptr, byval dwCookie as DWORD) as HRESULT
	declare sub IExplorerBrowser_Unadvise_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IExplorerBrowser_SetOptions_Proxy(byval This as IExplorerBrowser ptr, byval dwFlag as EXPLORER_BROWSER_OPTIONS) as HRESULT
	declare sub IExplorerBrowser_SetOptions_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IExplorerBrowser_GetOptions_Proxy(byval This as IExplorerBrowser ptr, byval pdwFlag as EXPLORER_BROWSER_OPTIONS ptr) as HRESULT
	declare sub IExplorerBrowser_GetOptions_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IExplorerBrowser_BrowseToIDList_Proxy(byval This as IExplorerBrowser ptr, byval pidl as LPCITEMIDLIST, byval uFlags as UINT) as HRESULT
	declare sub IExplorerBrowser_BrowseToIDList_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IExplorerBrowser_BrowseToObject_Proxy(byval This as IExplorerBrowser ptr, byval punk as IUnknown ptr, byval uFlags as UINT) as HRESULT
	declare sub IExplorerBrowser_BrowseToObject_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IExplorerBrowser_FillFromObject_Proxy(byval This as IExplorerBrowser ptr, byval punk as IUnknown ptr, byval dwFlags as EXPLORER_BROWSER_FILL_FLAGS) as HRESULT
	declare sub IExplorerBrowser_FillFromObject_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IExplorerBrowser_RemoveAll_Proxy(byval This as IExplorerBrowser ptr) as HRESULT
	declare sub IExplorerBrowser_RemoveAll_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IExplorerBrowser_GetCurrentView_Proxy(byval This as IExplorerBrowser ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	declare sub IExplorerBrowser_GetCurrentView_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	#define __IAccessibleObject_INTERFACE_DEFINED__
	extern IID_IAccessibleObject as const GUID
	type IAccessibleObject as IAccessibleObject_

	type IAccessibleObjectVtbl
		QueryInterface as function(byval This as IAccessibleObject ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IAccessibleObject ptr) as ULONG
		Release as function(byval This as IAccessibleObject ptr) as ULONG
		SetAccessibleName as function(byval This as IAccessibleObject ptr, byval pszName as LPCWSTR) as HRESULT
	end type

	type IAccessibleObject_
		lpVtbl as IAccessibleObjectVtbl ptr
	end type

	#define IAccessibleObject_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IAccessibleObject_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IAccessibleObject_Release(This) (This)->lpVtbl->Release(This)
	#define IAccessibleObject_SetAccessibleName(This, pszName) (This)->lpVtbl->SetAccessibleName(This, pszName)
	declare function IAccessibleObject_SetAccessibleName_Proxy(byval This as IAccessibleObject ptr, byval pszName as LPCWSTR) as HRESULT
	declare sub IAccessibleObject_SetAccessibleName_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#endif

#define __IResultsFolder_INTERFACE_DEFINED__
extern IID_IResultsFolder as const GUID
type IResultsFolder as IResultsFolder_

type IResultsFolderVtbl
	QueryInterface as function(byval This as IResultsFolder ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IResultsFolder ptr) as ULONG
	Release as function(byval This as IResultsFolder ptr) as ULONG
	AddItem as function(byval This as IResultsFolder ptr, byval psi as IShellItem ptr) as HRESULT
	AddIDList as function(byval This as IResultsFolder ptr, byval pidl as LPCITEMIDLIST, byval ppidlAdded as LPITEMIDLIST ptr) as HRESULT
	RemoveItem as function(byval This as IResultsFolder ptr, byval psi as IShellItem ptr) as HRESULT
	RemoveIDList as function(byval This as IResultsFolder ptr, byval pidl as LPCITEMIDLIST) as HRESULT
	RemoveAll as function(byval This as IResultsFolder ptr) as HRESULT
end type

type IResultsFolder_
	lpVtbl as IResultsFolderVtbl ptr
end type

#define IResultsFolder_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IResultsFolder_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IResultsFolder_Release(This) (This)->lpVtbl->Release(This)
#define IResultsFolder_AddItem(This, psi) (This)->lpVtbl->AddItem(This, psi)
#define IResultsFolder_AddIDList(This, pidl, ppidlAdded) (This)->lpVtbl->AddIDList(This, pidl, ppidlAdded)
#define IResultsFolder_RemoveItem(This, psi) (This)->lpVtbl->RemoveItem(This, psi)
#define IResultsFolder_RemoveIDList(This, pidl) (This)->lpVtbl->RemoveIDList(This, pidl)
#define IResultsFolder_RemoveAll(This) (This)->lpVtbl->RemoveAll(This)

declare function IResultsFolder_AddItem_Proxy(byval This as IResultsFolder ptr, byval psi as IShellItem ptr) as HRESULT
declare sub IResultsFolder_AddItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IResultsFolder_RemoteAddIDList_Proxy(byval This as IResultsFolder ptr, byval pidl as LPCITEMIDLIST, byval ppidlAdded as LPITEMIDLIST ptr) as HRESULT
declare sub IResultsFolder_RemoteAddIDList_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IResultsFolder_RemoveItem_Proxy(byval This as IResultsFolder ptr, byval psi as IShellItem ptr) as HRESULT
declare sub IResultsFolder_RemoveItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IResultsFolder_RemoveIDList_Proxy(byval This as IResultsFolder ptr, byval pidl as LPCITEMIDLIST) as HRESULT
declare sub IResultsFolder_RemoveIDList_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IResultsFolder_RemoveAll_Proxy(byval This as IResultsFolder ptr) as HRESULT
declare sub IResultsFolder_RemoveAll_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IResultsFolder_AddIDList_Proxy(byval This as IResultsFolder ptr, byval pidl as LPCITEMIDLIST, byval ppidlAdded as LPITEMIDLIST ptr) as HRESULT
declare function IResultsFolder_AddIDList_Stub(byval This as IResultsFolder ptr, byval pidl as LPCITEMIDLIST, byval ppidlAdded as LPITEMIDLIST ptr) as HRESULT

#if _WIN32_WINNT >= &h0600
	#define __IEnumObjects_INTERFACE_DEFINED__
	extern IID_IEnumObjects as const GUID
	type IEnumObjects as IEnumObjects_

	type IEnumObjectsVtbl
		QueryInterface as function(byval This as IEnumObjects ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IEnumObjects ptr) as ULONG
		Release as function(byval This as IEnumObjects ptr) as ULONG
		Next as function(byval This as IEnumObjects ptr, byval celt as ULONG, byval riid as const IID const ptr, byval rgelt as any ptr ptr, byval pceltFetched as ULONG ptr) as HRESULT
		Skip as function(byval This as IEnumObjects ptr, byval celt as ULONG) as HRESULT
		Reset as function(byval This as IEnumObjects ptr) as HRESULT
		Clone as function(byval This as IEnumObjects ptr, byval ppenum as IEnumObjects ptr ptr) as HRESULT
	end type

	type IEnumObjects_
		lpVtbl as IEnumObjectsVtbl ptr
	end type

	#define IEnumObjects_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IEnumObjects_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IEnumObjects_Release(This) (This)->lpVtbl->Release(This)
	#define IEnumObjects_Next(This, celt, riid, rgelt, pceltFetched) (This)->lpVtbl->Next(This, celt, riid, rgelt, pceltFetched)
	#define IEnumObjects_Skip(This, celt) (This)->lpVtbl->Skip(This, celt)
	#define IEnumObjects_Reset(This) (This)->lpVtbl->Reset(This)
	#define IEnumObjects_Clone(This, ppenum) (This)->lpVtbl->Clone(This, ppenum)

	declare function IEnumObjects_RemoteNext_Proxy(byval This as IEnumObjects ptr, byval celt as ULONG, byval riid as const IID const ptr, byval rgelt as any ptr ptr, byval pceltFetched as ULONG ptr) as HRESULT
	declare sub IEnumObjects_RemoteNext_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IEnumObjects_Skip_Proxy(byval This as IEnumObjects ptr, byval celt as ULONG) as HRESULT
	declare sub IEnumObjects_Skip_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IEnumObjects_Reset_Proxy(byval This as IEnumObjects ptr) as HRESULT
	declare sub IEnumObjects_Reset_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IEnumObjects_Clone_Proxy(byval This as IEnumObjects ptr, byval ppenum as IEnumObjects ptr ptr) as HRESULT
	declare sub IEnumObjects_Clone_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IEnumObjects_Next_Proxy(byval This as IEnumObjects ptr, byval celt as ULONG, byval riid as const IID const ptr, byval rgelt as any ptr ptr, byval pceltFetched as ULONG ptr) as HRESULT
	declare function IEnumObjects_Next_Stub(byval This as IEnumObjects ptr, byval celt as ULONG, byval riid as const IID const ptr, byval rgelt as any ptr ptr, byval pceltFetched as ULONG ptr) as HRESULT

	type _OPPROGDLGF as long
	enum
		OPPROGDLG_DEFAULT = &h0
		OPPROGDLG_ENABLEPAUSE = &h80
		OPPROGDLG_ALLOWUNDO = &h100
		OPPROGDLG_DONTDISPLAYSOURCEPATH = &h200
		OPPROGDLG_DONTDISPLAYDESTPATH = &h400
		OPPROGDLG_NOMULTIDAYESTIMATES = &h800
		OPPROGDLG_DONTDISPLAYLOCATIONS = &h1000
	end enum

	type OPPROGDLGF as DWORD
	#define __IOperationsProgressDialog_INTERFACE_DEFINED__

	type _PDMODE as long
	enum
		PDM_DEFAULT = &h0
		PDM_RUN = &h1
		PDM_PREFLIGHT = &h2
		PDM_UNDOING = &h4
		PDM_ERRORSBLOCKING = &h8
		PDM_INDETERMINATE = &h10
	end enum

	type PDMODE as DWORD

	type PDOPSTATUS as long
	enum
		PDOPS_RUNNING = 1
		PDOPS_PAUSED = 2
		PDOPS_CANCELLED = 3
		PDOPS_STOPPED = 4
		PDOPS_ERRORS = 5
	end enum

	extern IID_IOperationsProgressDialog as const GUID
	type IOperationsProgressDialog as IOperationsProgressDialog_

	type IOperationsProgressDialogVtbl
		QueryInterface as function(byval This as IOperationsProgressDialog ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IOperationsProgressDialog ptr) as ULONG
		Release as function(byval This as IOperationsProgressDialog ptr) as ULONG
		StartProgressDialog as function(byval This as IOperationsProgressDialog ptr, byval hwndOwner as HWND, byval flags as OPPROGDLGF) as HRESULT
		StopProgressDialog as function(byval This as IOperationsProgressDialog ptr) as HRESULT
		SetOperation as function(byval This as IOperationsProgressDialog ptr, byval action as SPACTION) as HRESULT
		SetMode as function(byval This as IOperationsProgressDialog ptr, byval mode as PDMODE) as HRESULT
		UpdateProgress as function(byval This as IOperationsProgressDialog ptr, byval ullPointsCurrent as ULONGLONG, byval ullPointsTotal as ULONGLONG, byval ullSizeCurrent as ULONGLONG, byval ullSizeTotal as ULONGLONG, byval ullItemsCurrent as ULONGLONG, byval ullItemsTotal as ULONGLONG) as HRESULT
		UpdateLocations as function(byval This as IOperationsProgressDialog ptr, byval psiSource as IShellItem ptr, byval psiTarget as IShellItem ptr, byval psiItem as IShellItem ptr) as HRESULT
		ResetTimer as function(byval This as IOperationsProgressDialog ptr) as HRESULT
		PauseTimer as function(byval This as IOperationsProgressDialog ptr) as HRESULT
		ResumeTimer as function(byval This as IOperationsProgressDialog ptr) as HRESULT
		GetMilliseconds as function(byval This as IOperationsProgressDialog ptr, byval pullElapsed as ULONGLONG ptr, byval pullRemaining as ULONGLONG ptr) as HRESULT
		GetOperationStatus as function(byval This as IOperationsProgressDialog ptr, byval popstatus as PDOPSTATUS ptr) as HRESULT
	end type

	type IOperationsProgressDialog_
		lpVtbl as IOperationsProgressDialogVtbl ptr
	end type

	#define IOperationsProgressDialog_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IOperationsProgressDialog_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IOperationsProgressDialog_Release(This) (This)->lpVtbl->Release(This)
	#define IOperationsProgressDialog_StartProgressDialog(This, hwndOwner, flags) (This)->lpVtbl->StartProgressDialog(This, hwndOwner, flags)
	#define IOperationsProgressDialog_StopProgressDialog(This) (This)->lpVtbl->StopProgressDialog(This)
	#define IOperationsProgressDialog_SetOperation(This, action) (This)->lpVtbl->SetOperation(This, action)
	#define IOperationsProgressDialog_SetMode(This, mode) (This)->lpVtbl->SetMode(This, mode)
	#define IOperationsProgressDialog_UpdateProgress(This, ullPointsCurrent, ullPointsTotal, ullSizeCurrent, ullSizeTotal, ullItemsCurrent, ullItemsTotal) (This)->lpVtbl->UpdateProgress(This, ullPointsCurrent, ullPointsTotal, ullSizeCurrent, ullSizeTotal, ullItemsCurrent, ullItemsTotal)
	#define IOperationsProgressDialog_UpdateLocations(This, psiSource, psiTarget, psiItem) (This)->lpVtbl->UpdateLocations(This, psiSource, psiTarget, psiItem)
	#define IOperationsProgressDialog_ResetTimer(This) (This)->lpVtbl->ResetTimer(This)
	#define IOperationsProgressDialog_PauseTimer(This) (This)->lpVtbl->PauseTimer(This)
	#define IOperationsProgressDialog_ResumeTimer(This) (This)->lpVtbl->ResumeTimer(This)
	#define IOperationsProgressDialog_GetMilliseconds(This, pullElapsed, pullRemaining) (This)->lpVtbl->GetMilliseconds(This, pullElapsed, pullRemaining)
	#define IOperationsProgressDialog_GetOperationStatus(This, popstatus) (This)->lpVtbl->GetOperationStatus(This, popstatus)

	declare function IOperationsProgressDialog_StartProgressDialog_Proxy(byval This as IOperationsProgressDialog ptr, byval hwndOwner as HWND, byval flags as OPPROGDLGF) as HRESULT
	declare sub IOperationsProgressDialog_StartProgressDialog_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IOperationsProgressDialog_StopProgressDialog_Proxy(byval This as IOperationsProgressDialog ptr) as HRESULT
	declare sub IOperationsProgressDialog_StopProgressDialog_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IOperationsProgressDialog_SetOperation_Proxy(byval This as IOperationsProgressDialog ptr, byval action as SPACTION) as HRESULT
	declare sub IOperationsProgressDialog_SetOperation_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IOperationsProgressDialog_SetMode_Proxy(byval This as IOperationsProgressDialog ptr, byval mode as PDMODE) as HRESULT
	declare sub IOperationsProgressDialog_SetMode_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IOperationsProgressDialog_UpdateProgress_Proxy(byval This as IOperationsProgressDialog ptr, byval ullPointsCurrent as ULONGLONG, byval ullPointsTotal as ULONGLONG, byval ullSizeCurrent as ULONGLONG, byval ullSizeTotal as ULONGLONG, byval ullItemsCurrent as ULONGLONG, byval ullItemsTotal as ULONGLONG) as HRESULT
	declare sub IOperationsProgressDialog_UpdateProgress_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IOperationsProgressDialog_UpdateLocations_Proxy(byval This as IOperationsProgressDialog ptr, byval psiSource as IShellItem ptr, byval psiTarget as IShellItem ptr, byval psiItem as IShellItem ptr) as HRESULT
	declare sub IOperationsProgressDialog_UpdateLocations_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IOperationsProgressDialog_ResetTimer_Proxy(byval This as IOperationsProgressDialog ptr) as HRESULT
	declare sub IOperationsProgressDialog_ResetTimer_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IOperationsProgressDialog_PauseTimer_Proxy(byval This as IOperationsProgressDialog ptr) as HRESULT
	declare sub IOperationsProgressDialog_PauseTimer_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IOperationsProgressDialog_ResumeTimer_Proxy(byval This as IOperationsProgressDialog ptr) as HRESULT
	declare sub IOperationsProgressDialog_ResumeTimer_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IOperationsProgressDialog_GetMilliseconds_Proxy(byval This as IOperationsProgressDialog ptr, byval pullElapsed as ULONGLONG ptr, byval pullRemaining as ULONGLONG ptr) as HRESULT
	declare sub IOperationsProgressDialog_GetMilliseconds_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IOperationsProgressDialog_GetOperationStatus_Proxy(byval This as IOperationsProgressDialog ptr, byval popstatus as PDOPSTATUS ptr) as HRESULT
	declare sub IOperationsProgressDialog_GetOperationStatus_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	#define __IIOCancelInformation_INTERFACE_DEFINED__
	extern IID_IIOCancelInformation as const GUID
	type IIOCancelInformation as IIOCancelInformation_

	type IIOCancelInformationVtbl
		QueryInterface as function(byval This as IIOCancelInformation ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IIOCancelInformation ptr) as ULONG
		Release as function(byval This as IIOCancelInformation ptr) as ULONG
		SetCancelInformation as function(byval This as IIOCancelInformation ptr, byval dwThreadID as DWORD, byval uMsgCancel as UINT) as HRESULT
		GetCancelInformation as function(byval This as IIOCancelInformation ptr, byval pdwThreadID as DWORD ptr, byval puMsgCancel as UINT ptr) as HRESULT
	end type

	type IIOCancelInformation_
		lpVtbl as IIOCancelInformationVtbl ptr
	end type

	#define IIOCancelInformation_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IIOCancelInformation_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IIOCancelInformation_Release(This) (This)->lpVtbl->Release(This)
	#define IIOCancelInformation_SetCancelInformation(This, dwThreadID, uMsgCancel) (This)->lpVtbl->SetCancelInformation(This, dwThreadID, uMsgCancel)
	#define IIOCancelInformation_GetCancelInformation(This, pdwThreadID, puMsgCancel) (This)->lpVtbl->GetCancelInformation(This, pdwThreadID, puMsgCancel)

	declare function IIOCancelInformation_SetCancelInformation_Proxy(byval This as IIOCancelInformation ptr, byval dwThreadID as DWORD, byval uMsgCancel as UINT) as HRESULT
	declare sub IIOCancelInformation_SetCancelInformation_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IIOCancelInformation_GetCancelInformation_Proxy(byval This as IIOCancelInformation ptr, byval pdwThreadID as DWORD ptr, byval puMsgCancel as UINT ptr) as HRESULT
	declare sub IIOCancelInformation_GetCancelInformation_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

	const FOFX_NOSKIPJUNCTIONS = &h00010000
	const FOFX_PREFERHARDLINK = &h00020000
	const FOFX_SHOWELEVATIONPROMPT = &h00040000
	const FOFX_RECYCLEONDELETE = &h00080000
	const FOFX_EARLYFAILURE = &h00100000
	const FOFX_PRESERVEFILEEXTENSIONS = &h00200000
	const FOFX_KEEPNEWERFILE = &h00400000
	const FOFX_NOCOPYHOOKS = &h00800000
	const FOFX_NOMINIMIZEBOX = &h01000000
	const FOFX_MOVEACLSACROSSVOLUMES = &h02000000
	const FOFX_DONTDISPLAYSOURCEPATH = &h04000000
	const FOFX_DONTDISPLAYDESTPATH = &h08000000
	const FOFX_REQUIREELEVATION = &h10000000
	const FOFX_ADDUNDORECORD = &h20000000
	const FOFX_COPYASDOWNLOAD = &h40000000
	const FOFX_DONTDISPLAYLOCATIONS = &h80000000
	#define __IFileOperation_INTERFACE_DEFINED__
	extern IID_IFileOperation as const GUID

	type IFileOperationVtbl
		QueryInterface as function(byval This as IFileOperation ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IFileOperation ptr) as ULONG
		Release as function(byval This as IFileOperation ptr) as ULONG
		Advise as function(byval This as IFileOperation ptr, byval pfops as IFileOperationProgressSink ptr, byval pdwCookie as DWORD ptr) as HRESULT
		Unadvise as function(byval This as IFileOperation ptr, byval dwCookie as DWORD) as HRESULT
		SetOperationFlags as function(byval This as IFileOperation ptr, byval dwOperationFlags as DWORD) as HRESULT
		SetProgressMessage as function(byval This as IFileOperation ptr, byval pszMessage as LPCWSTR) as HRESULT
		SetProgressDialog as function(byval This as IFileOperation ptr, byval popd as IOperationsProgressDialog ptr) as HRESULT
		SetProperties as function(byval This as IFileOperation ptr, byval pproparray as IPropertyChangeArray ptr) as HRESULT
		SetOwnerWindow as function(byval This as IFileOperation ptr, byval hwndOwner as HWND) as HRESULT
		ApplyPropertiesToItem as function(byval This as IFileOperation ptr, byval psiItem as IShellItem ptr) as HRESULT
		ApplyPropertiesToItems as function(byval This as IFileOperation ptr, byval punkItems as IUnknown ptr) as HRESULT
		RenameItem as function(byval This as IFileOperation ptr, byval psiItem as IShellItem ptr, byval pszNewName as LPCWSTR, byval pfopsItem as IFileOperationProgressSink ptr) as HRESULT
		RenameItems as function(byval This as IFileOperation ptr, byval pUnkItems as IUnknown ptr, byval pszNewName as LPCWSTR) as HRESULT
		MoveItem as function(byval This as IFileOperation ptr, byval psiItem as IShellItem ptr, byval psiDestinationFolder as IShellItem ptr, byval pszNewName as LPCWSTR, byval pfopsItem as IFileOperationProgressSink ptr) as HRESULT
		MoveItems as function(byval This as IFileOperation ptr, byval punkItems as IUnknown ptr, byval psiDestinationFolder as IShellItem ptr) as HRESULT
		CopyItem as function(byval This as IFileOperation ptr, byval psiItem as IShellItem ptr, byval psiDestinationFolder as IShellItem ptr, byval pszCopyName as LPCWSTR, byval pfopsItem as IFileOperationProgressSink ptr) as HRESULT
		CopyItems as function(byval This as IFileOperation ptr, byval punkItems as IUnknown ptr, byval psiDestinationFolder as IShellItem ptr) as HRESULT
		DeleteItem as function(byval This as IFileOperation ptr, byval psiItem as IShellItem ptr, byval pfopsItem as IFileOperationProgressSink ptr) as HRESULT
		DeleteItems as function(byval This as IFileOperation ptr, byval punkItems as IUnknown ptr) as HRESULT
		NewItem as function(byval This as IFileOperation ptr, byval psiDestinationFolder as IShellItem ptr, byval dwFileAttributes as DWORD, byval pszName as LPCWSTR, byval pszTemplateName as LPCWSTR, byval pfopsItem as IFileOperationProgressSink ptr) as HRESULT
		PerformOperations as function(byval This as IFileOperation ptr) as HRESULT
		GetAnyOperationsAborted as function(byval This as IFileOperation ptr, byval pfAnyOperationsAborted as WINBOOL ptr) as HRESULT
	end type

	type IFileOperation_
		lpVtbl as IFileOperationVtbl ptr
	end type

	#define IFileOperation_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IFileOperation_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IFileOperation_Release(This) (This)->lpVtbl->Release(This)
	#define IFileOperation_Advise(This, pfops, pdwCookie) (This)->lpVtbl->Advise(This, pfops, pdwCookie)
	#define IFileOperation_Unadvise(This, dwCookie) (This)->lpVtbl->Unadvise(This, dwCookie)
	#define IFileOperation_SetOperationFlags(This, dwOperationFlags) (This)->lpVtbl->SetOperationFlags(This, dwOperationFlags)
	#define IFileOperation_SetProgressMessage(This, pszMessage) (This)->lpVtbl->SetProgressMessage(This, pszMessage)
	#define IFileOperation_SetProgressDialog(This, popd) (This)->lpVtbl->SetProgressDialog(This, popd)
	#define IFileOperation_SetProperties(This, pproparray) (This)->lpVtbl->SetProperties(This, pproparray)
	#define IFileOperation_SetOwnerWindow(This, hwndOwner) (This)->lpVtbl->SetOwnerWindow(This, hwndOwner)
	#define IFileOperation_ApplyPropertiesToItem(This, psiItem) (This)->lpVtbl->ApplyPropertiesToItem(This, psiItem)
	#define IFileOperation_ApplyPropertiesToItems(This, punkItems) (This)->lpVtbl->ApplyPropertiesToItems(This, punkItems)
	#define IFileOperation_RenameItem(This, psiItem, pszNewName, pfopsItem) (This)->lpVtbl->RenameItem(This, psiItem, pszNewName, pfopsItem)
	#define IFileOperation_RenameItems(This, pUnkItems, pszNewName) (This)->lpVtbl->RenameItems(This, pUnkItems, pszNewName)
	#define IFileOperation_MoveItem(This, psiItem, psiDestinationFolder, pszNewName, pfopsItem) (This)->lpVtbl->MoveItem(This, psiItem, psiDestinationFolder, pszNewName, pfopsItem)
	#define IFileOperation_MoveItems(This, punkItems, psiDestinationFolder) (This)->lpVtbl->MoveItems(This, punkItems, psiDestinationFolder)
	#define IFileOperation_CopyItem(This, psiItem, psiDestinationFolder, pszCopyName, pfopsItem) (This)->lpVtbl->CopyItem(This, psiItem, psiDestinationFolder, pszCopyName, pfopsItem)
	#define IFileOperation_CopyItems(This, punkItems, psiDestinationFolder) (This)->lpVtbl->CopyItems(This, punkItems, psiDestinationFolder)
	#define IFileOperation_DeleteItem(This, psiItem, pfopsItem) (This)->lpVtbl->DeleteItem(This, psiItem, pfopsItem)
	#define IFileOperation_DeleteItems(This, punkItems) (This)->lpVtbl->DeleteItems(This, punkItems)
	#define IFileOperation_NewItem(This, psiDestinationFolder, dwFileAttributes, pszName, pszTemplateName, pfopsItem) (This)->lpVtbl->NewItem(This, psiDestinationFolder, dwFileAttributes, pszName, pszTemplateName, pfopsItem)
	#define IFileOperation_PerformOperations(This) (This)->lpVtbl->PerformOperations(This)
	#define IFileOperation_GetAnyOperationsAborted(This, pfAnyOperationsAborted) (This)->lpVtbl->GetAnyOperationsAborted(This, pfAnyOperationsAborted)

	declare function IFileOperation_Advise_Proxy(byval This as IFileOperation ptr, byval pfops as IFileOperationProgressSink ptr, byval pdwCookie as DWORD ptr) as HRESULT
	declare sub IFileOperation_Advise_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileOperation_Unadvise_Proxy(byval This as IFileOperation ptr, byval dwCookie as DWORD) as HRESULT
	declare sub IFileOperation_Unadvise_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileOperation_SetOperationFlags_Proxy(byval This as IFileOperation ptr, byval dwOperationFlags as DWORD) as HRESULT
	declare sub IFileOperation_SetOperationFlags_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileOperation_SetProgressMessage_Proxy(byval This as IFileOperation ptr, byval pszMessage as LPCWSTR) as HRESULT
	declare sub IFileOperation_SetProgressMessage_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileOperation_SetProgressDialog_Proxy(byval This as IFileOperation ptr, byval popd as IOperationsProgressDialog ptr) as HRESULT
	declare sub IFileOperation_SetProgressDialog_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileOperation_SetProperties_Proxy(byval This as IFileOperation ptr, byval pproparray as IPropertyChangeArray ptr) as HRESULT
	declare sub IFileOperation_SetProperties_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileOperation_SetOwnerWindow_Proxy(byval This as IFileOperation ptr, byval hwndOwner as HWND) as HRESULT
	declare sub IFileOperation_SetOwnerWindow_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileOperation_ApplyPropertiesToItem_Proxy(byval This as IFileOperation ptr, byval psiItem as IShellItem ptr) as HRESULT
	declare sub IFileOperation_ApplyPropertiesToItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileOperation_ApplyPropertiesToItems_Proxy(byval This as IFileOperation ptr, byval punkItems as IUnknown ptr) as HRESULT
	declare sub IFileOperation_ApplyPropertiesToItems_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileOperation_RenameItem_Proxy(byval This as IFileOperation ptr, byval psiItem as IShellItem ptr, byval pszNewName as LPCWSTR, byval pfopsItem as IFileOperationProgressSink ptr) as HRESULT
	declare sub IFileOperation_RenameItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileOperation_RenameItems_Proxy(byval This as IFileOperation ptr, byval pUnkItems as IUnknown ptr, byval pszNewName as LPCWSTR) as HRESULT
	declare sub IFileOperation_RenameItems_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileOperation_MoveItem_Proxy(byval This as IFileOperation ptr, byval psiItem as IShellItem ptr, byval psiDestinationFolder as IShellItem ptr, byval pszNewName as LPCWSTR, byval pfopsItem as IFileOperationProgressSink ptr) as HRESULT
	declare sub IFileOperation_MoveItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileOperation_MoveItems_Proxy(byval This as IFileOperation ptr, byval punkItems as IUnknown ptr, byval psiDestinationFolder as IShellItem ptr) as HRESULT
	declare sub IFileOperation_MoveItems_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileOperation_CopyItem_Proxy(byval This as IFileOperation ptr, byval psiItem as IShellItem ptr, byval psiDestinationFolder as IShellItem ptr, byval pszCopyName as LPCWSTR, byval pfopsItem as IFileOperationProgressSink ptr) as HRESULT
	declare sub IFileOperation_CopyItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileOperation_CopyItems_Proxy(byval This as IFileOperation ptr, byval punkItems as IUnknown ptr, byval psiDestinationFolder as IShellItem ptr) as HRESULT
	declare sub IFileOperation_CopyItems_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileOperation_DeleteItem_Proxy(byval This as IFileOperation ptr, byval psiItem as IShellItem ptr, byval pfopsItem as IFileOperationProgressSink ptr) as HRESULT
	declare sub IFileOperation_DeleteItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileOperation_DeleteItems_Proxy(byval This as IFileOperation ptr, byval punkItems as IUnknown ptr) as HRESULT
	declare sub IFileOperation_DeleteItems_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileOperation_NewItem_Proxy(byval This as IFileOperation ptr, byval psiDestinationFolder as IShellItem ptr, byval dwFileAttributes as DWORD, byval pszName as LPCWSTR, byval pszTemplateName as LPCWSTR, byval pfopsItem as IFileOperationProgressSink ptr) as HRESULT
	declare sub IFileOperation_NewItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileOperation_PerformOperations_Proxy(byval This as IFileOperation ptr) as HRESULT
	declare sub IFileOperation_PerformOperations_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileOperation_GetAnyOperationsAborted_Proxy(byval This as IFileOperation ptr, byval pfAnyOperationsAborted as WINBOOL ptr) as HRESULT
	declare sub IFileOperation_GetAnyOperationsAborted_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	#define __IObjectProvider_INTERFACE_DEFINED__
	extern IID_IObjectProvider as const GUID
	type IObjectProvider as IObjectProvider_

	type IObjectProviderVtbl
		QueryInterface as function(byval This as IObjectProvider ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IObjectProvider ptr) as ULONG
		Release as function(byval This as IObjectProvider ptr) as ULONG
		QueryObject as function(byval This as IObjectProvider ptr, byval guidObject as const GUID const ptr, byval riid as const IID const ptr, byval ppvOut as any ptr ptr) as HRESULT
	end type

	type IObjectProvider_
		lpVtbl as IObjectProviderVtbl ptr
	end type

	#define IObjectProvider_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IObjectProvider_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IObjectProvider_Release(This) (This)->lpVtbl->Release(This)
	#define IObjectProvider_QueryObject(This, guidObject, riid, ppvOut) (This)->lpVtbl->QueryObject(This, guidObject, riid, ppvOut)
	declare function IObjectProvider_QueryObject_Proxy(byval This as IObjectProvider ptr, byval guidObject as const GUID const ptr, byval riid as const IID const ptr, byval ppvOut as any ptr ptr) as HRESULT
	declare sub IObjectProvider_QueryObject_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#endif

#define __INamespaceWalkCB_INTERFACE_DEFINED__
extern IID_INamespaceWalkCB as const GUID
type INamespaceWalkCB as INamespaceWalkCB_

type INamespaceWalkCBVtbl
	QueryInterface as function(byval This as INamespaceWalkCB ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as INamespaceWalkCB ptr) as ULONG
	Release as function(byval This as INamespaceWalkCB ptr) as ULONG
	FoundItem as function(byval This as INamespaceWalkCB ptr, byval psf as IShellFolder ptr, byval pidl as LPCITEMIDLIST) as HRESULT
	EnterFolder as function(byval This as INamespaceWalkCB ptr, byval psf as IShellFolder ptr, byval pidl as LPCITEMIDLIST) as HRESULT
	LeaveFolder as function(byval This as INamespaceWalkCB ptr, byval psf as IShellFolder ptr, byval pidl as LPCITEMIDLIST) as HRESULT
	InitializeProgressDialog as function(byval This as INamespaceWalkCB ptr, byval ppszTitle as LPWSTR ptr, byval ppszCancel as LPWSTR ptr) as HRESULT
end type

type INamespaceWalkCB_
	lpVtbl as INamespaceWalkCBVtbl ptr
end type

#define INamespaceWalkCB_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define INamespaceWalkCB_AddRef(This) (This)->lpVtbl->AddRef(This)
#define INamespaceWalkCB_Release(This) (This)->lpVtbl->Release(This)
#define INamespaceWalkCB_FoundItem(This, psf, pidl) (This)->lpVtbl->FoundItem(This, psf, pidl)
#define INamespaceWalkCB_EnterFolder(This, psf, pidl) (This)->lpVtbl->EnterFolder(This, psf, pidl)
#define INamespaceWalkCB_LeaveFolder(This, psf, pidl) (This)->lpVtbl->LeaveFolder(This, psf, pidl)
#define INamespaceWalkCB_InitializeProgressDialog(This, ppszTitle, ppszCancel) (This)->lpVtbl->InitializeProgressDialog(This, ppszTitle, ppszCancel)

declare function INamespaceWalkCB_FoundItem_Proxy(byval This as INamespaceWalkCB ptr, byval psf as IShellFolder ptr, byval pidl as LPCITEMIDLIST) as HRESULT
declare sub INamespaceWalkCB_FoundItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function INamespaceWalkCB_EnterFolder_Proxy(byval This as INamespaceWalkCB ptr, byval psf as IShellFolder ptr, byval pidl as LPCITEMIDLIST) as HRESULT
declare sub INamespaceWalkCB_EnterFolder_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function INamespaceWalkCB_LeaveFolder_Proxy(byval This as INamespaceWalkCB ptr, byval psf as IShellFolder ptr, byval pidl as LPCITEMIDLIST) as HRESULT
declare sub INamespaceWalkCB_LeaveFolder_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function INamespaceWalkCB_InitializeProgressDialog_Proxy(byval This as INamespaceWalkCB ptr, byval ppszTitle as LPWSTR ptr, byval ppszCancel as LPWSTR ptr) as HRESULT
declare sub INamespaceWalkCB_InitializeProgressDialog_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#if _WIN32_WINNT >= &h0600
	#define __INamespaceWalkCB2_INTERFACE_DEFINED__
	extern IID_INamespaceWalkCB2 as const GUID
	type INamespaceWalkCB2 as INamespaceWalkCB2_

	type INamespaceWalkCB2Vtbl
		QueryInterface as function(byval This as INamespaceWalkCB2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as INamespaceWalkCB2 ptr) as ULONG
		Release as function(byval This as INamespaceWalkCB2 ptr) as ULONG
		FoundItem as function(byval This as INamespaceWalkCB2 ptr, byval psf as IShellFolder ptr, byval pidl as LPCITEMIDLIST) as HRESULT
		EnterFolder as function(byval This as INamespaceWalkCB2 ptr, byval psf as IShellFolder ptr, byval pidl as LPCITEMIDLIST) as HRESULT
		LeaveFolder as function(byval This as INamespaceWalkCB2 ptr, byval psf as IShellFolder ptr, byval pidl as LPCITEMIDLIST) as HRESULT
		InitializeProgressDialog as function(byval This as INamespaceWalkCB2 ptr, byval ppszTitle as LPWSTR ptr, byval ppszCancel as LPWSTR ptr) as HRESULT
		WalkComplete as function(byval This as INamespaceWalkCB2 ptr, byval hr as HRESULT) as HRESULT
	end type

	type INamespaceWalkCB2_
		lpVtbl as INamespaceWalkCB2Vtbl ptr
	end type

	#define INamespaceWalkCB2_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define INamespaceWalkCB2_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define INamespaceWalkCB2_Release(This) (This)->lpVtbl->Release(This)
	#define INamespaceWalkCB2_FoundItem(This, psf, pidl) (This)->lpVtbl->FoundItem(This, psf, pidl)
	#define INamespaceWalkCB2_EnterFolder(This, psf, pidl) (This)->lpVtbl->EnterFolder(This, psf, pidl)
	#define INamespaceWalkCB2_LeaveFolder(This, psf, pidl) (This)->lpVtbl->LeaveFolder(This, psf, pidl)
	#define INamespaceWalkCB2_InitializeProgressDialog(This, ppszTitle, ppszCancel) (This)->lpVtbl->InitializeProgressDialog(This, ppszTitle, ppszCancel)
	#define INamespaceWalkCB2_WalkComplete(This, hr) (This)->lpVtbl->WalkComplete(This, hr)
	declare function INamespaceWalkCB2_WalkComplete_Proxy(byval This as INamespaceWalkCB2 ptr, byval hr as HRESULT) as HRESULT
	declare sub INamespaceWalkCB2_WalkComplete_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#endif

#define __INamespaceWalk_INTERFACE_DEFINED__

type NAMESPACEWALKFLAG as long
enum
	NSWF_DEFAULT = &h0
	NSWF_NONE_IMPLIES_ALL = &h1
	NSWF_ONE_IMPLIES_ALL = &h2
	NSWF_DONT_TRAVERSE_LINKS = &h4
	NSWF_DONT_ACCUMULATE_RESULT = &h8
	NSWF_TRAVERSE_STREAM_JUNCTIONS = &h10
	NSWF_FILESYSTEM_ONLY = &h20
	NSWF_SHOW_PROGRESS = &h40
	NSWF_FLAG_VIEWORDER = &h80
	NSWF_IGNORE_AUTOPLAY_HIDA = &h100
	NSWF_ASYNC = &h200
	NSWF_DONT_RESOLVE_LINKS = &h400
	NSWF_ACCUMULATE_FOLDERS = &h800
	NSWF_DONT_SORT = &h1000
	NSWF_USE_TRANSFER_MEDIUM = &h2000
	NSWF_DONT_TRAVERSE_STREAM_JUNCTIONS = &h4000
	NSWF_ANY_IMPLIES_ALL = &h8000
end enum

const NSWF_ENUMERATE_BEST_EFFORT = &h00010000
const NSWF_TRAVERSE_ONLY_STORAGE = &h00020000
extern IID_INamespaceWalk as const GUID
type INamespaceWalk as INamespaceWalk_

type INamespaceWalkVtbl
	QueryInterface as function(byval This as INamespaceWalk ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as INamespaceWalk ptr) as ULONG
	Release as function(byval This as INamespaceWalk ptr) as ULONG
	Walk as function(byval This as INamespaceWalk ptr, byval punkToWalk as IUnknown ptr, byval dwFlags as DWORD, byval cDepth as long, byval pnswcb as INamespaceWalkCB ptr) as HRESULT
	GetIDArrayResult as function(byval This as INamespaceWalk ptr, byval pcItems as UINT ptr, byval prgpidl as LPITEMIDLIST ptr ptr) as HRESULT
end type

type INamespaceWalk_
	lpVtbl as INamespaceWalkVtbl ptr
end type

#define INamespaceWalk_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define INamespaceWalk_AddRef(This) (This)->lpVtbl->AddRef(This)
#define INamespaceWalk_Release(This) (This)->lpVtbl->Release(This)
#define INamespaceWalk_Walk(This, punkToWalk, dwFlags, cDepth, pnswcb) (This)->lpVtbl->Walk(This, punkToWalk, dwFlags, cDepth, pnswcb)
#define INamespaceWalk_GetIDArrayResult(This, pcItems, prgpidl) (This)->lpVtbl->GetIDArrayResult(This, pcItems, prgpidl)

declare function INamespaceWalk_Walk_Proxy(byval This as INamespaceWalk ptr, byval punkToWalk as IUnknown ptr, byval dwFlags as DWORD, byval cDepth as long, byval pnswcb as INamespaceWalkCB ptr) as HRESULT
declare sub INamespaceWalk_Walk_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function INamespaceWalk_GetIDArrayResult_Proxy(byval This as INamespaceWalk ptr, byval pcItems as UINT ptr, byval prgpidl as LPITEMIDLIST ptr ptr) as HRESULT
declare sub INamespaceWalk_GetIDArrayResult_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

private sub FreeIDListArray cdecl(byval ppidls as LPITEMIDLIST ptr, byval cItems as UINT)
	dim i as UINT
	while i < cItems
		CoTaskMemFree(ppidls[i])
		i += 1
	wend
	CoTaskMemFree(ppidls)
end sub

declare sub FreeIDListArrayFull cdecl alias "FreeIDListArray"(byval ppidls as LPITEMIDLIST ptr, byval cItems as UINT)
declare sub FreeIDListArrayChild cdecl alias "FreeIDListArray"(byval ppidls as LPITEMIDLIST ptr, byval cItems as UINT)
const ACDD_VISIBLE = &h1
#define __IAutoCompleteDropDown_INTERFACE_DEFINED__
extern IID_IAutoCompleteDropDown as const GUID
type IAutoCompleteDropDown as IAutoCompleteDropDown_

type IAutoCompleteDropDownVtbl
	QueryInterface as function(byval This as IAutoCompleteDropDown ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAutoCompleteDropDown ptr) as ULONG
	Release as function(byval This as IAutoCompleteDropDown ptr) as ULONG
	GetDropDownStatus as function(byval This as IAutoCompleteDropDown ptr, byval pdwFlags as DWORD ptr, byval ppwszString as LPWSTR ptr) as HRESULT
	ResetEnumerator as function(byval This as IAutoCompleteDropDown ptr) as HRESULT
end type

type IAutoCompleteDropDown_
	lpVtbl as IAutoCompleteDropDownVtbl ptr
end type

#define IAutoCompleteDropDown_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IAutoCompleteDropDown_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IAutoCompleteDropDown_Release(This) (This)->lpVtbl->Release(This)
#define IAutoCompleteDropDown_GetDropDownStatus(This, pdwFlags, ppwszString) (This)->lpVtbl->GetDropDownStatus(This, pdwFlags, ppwszString)
#define IAutoCompleteDropDown_ResetEnumerator(This) (This)->lpVtbl->ResetEnumerator(This)

declare function IAutoCompleteDropDown_GetDropDownStatus_Proxy(byval This as IAutoCompleteDropDown ptr, byval pdwFlags as DWORD ptr, byval ppwszString as LPWSTR ptr) as HRESULT
declare sub IAutoCompleteDropDown_GetDropDownStatus_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IAutoCompleteDropDown_ResetEnumerator_Proxy(byval This as IAutoCompleteDropDown ptr) as HRESULT
declare sub IAutoCompleteDropDown_ResetEnumerator_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

type tagBANDSITEINFO
	dwMask as DWORD
	dwState as DWORD
	dwStyle as DWORD
end type

type BANDSITEINFO as tagBANDSITEINFO

type tagBANDSITECID as long
enum
	BSID_BANDADDED = 0
	BSID_BANDREMOVED = 1
end enum

const BSIM_STATE = &h00000001
const BSIM_STYLE = &h00000002
const BSSF_VISIBLE = &h00000001
const BSSF_NOTITLE = &h00000002
const BSSF_UNDELETEABLE = &h00001000
const BSIS_AUTOGRIPPER = &h00000000
const BSIS_NOGRIPPER = &h00000001
const BSIS_ALWAYSGRIPPER = &h00000002
const BSIS_LEFTALIGN = &h00000004
const BSIS_SINGLECLICK = &h00000008
const BSIS_NOCONTEXTMENU = &h00000010
const BSIS_NODROPTARGET = &h00000020
const BSIS_NOCAPTION = &h00000040
const BSIS_PREFERNOLINEBREAK = &h00000080
const BSIS_LOCKED = &h00000100

#if _WIN32_WINNT >= &h0600
	const BSIS_PRESERVEORDERDURINGLAYOUT = &h00000200
	const BSIS_FIXEDORDER = &h00000400
#endif

#define __IBandSite_INTERFACE_DEFINED__
extern IID_IBandSite as const GUID
extern SID_SBandSite alias "IID_IBandSite" as const GUID
extern CGID_BandSite alias "IID_IBandSite" as const GUID
type IBandSite as IBandSite_

type IBandSiteVtbl
	QueryInterface as function(byval This as IBandSite ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IBandSite ptr) as ULONG
	Release as function(byval This as IBandSite ptr) as ULONG
	AddBand as function(byval This as IBandSite ptr, byval punk as IUnknown ptr) as HRESULT
	EnumBands as function(byval This as IBandSite ptr, byval uBand as UINT, byval pdwBandID as DWORD ptr) as HRESULT
	QueryBand as function(byval This as IBandSite ptr, byval dwBandID as DWORD, byval ppstb as IDeskBand ptr ptr, byval pdwState as DWORD ptr, byval pszName as LPWSTR, byval cchName as long) as HRESULT
	SetBandState as function(byval This as IBandSite ptr, byval dwBandID as DWORD, byval dwMask as DWORD, byval dwState as DWORD) as HRESULT
	RemoveBand as function(byval This as IBandSite ptr, byval dwBandID as DWORD) as HRESULT
	GetBandObject as function(byval This as IBandSite ptr, byval dwBandID as DWORD, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	SetBandSiteInfo as function(byval This as IBandSite ptr, byval pbsinfo as const BANDSITEINFO ptr) as HRESULT
	GetBandSiteInfo as function(byval This as IBandSite ptr, byval pbsinfo as BANDSITEINFO ptr) as HRESULT
end type

type IBandSite_
	lpVtbl as IBandSiteVtbl ptr
end type

#define IBandSite_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IBandSite_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IBandSite_Release(This) (This)->lpVtbl->Release(This)
#define IBandSite_AddBand(This, punk) (This)->lpVtbl->AddBand(This, punk)
#define IBandSite_EnumBands(This, uBand, pdwBandID) (This)->lpVtbl->EnumBands(This, uBand, pdwBandID)
#define IBandSite_QueryBand(This, dwBandID, ppstb, pdwState, pszName, cchName) (This)->lpVtbl->QueryBand(This, dwBandID, ppstb, pdwState, pszName, cchName)
#define IBandSite_SetBandState(This, dwBandID, dwMask, dwState) (This)->lpVtbl->SetBandState(This, dwBandID, dwMask, dwState)
#define IBandSite_RemoveBand(This, dwBandID) (This)->lpVtbl->RemoveBand(This, dwBandID)
#define IBandSite_GetBandObject(This, dwBandID, riid, ppv) (This)->lpVtbl->GetBandObject(This, dwBandID, riid, ppv)
#define IBandSite_SetBandSiteInfo(This, pbsinfo) (This)->lpVtbl->SetBandSiteInfo(This, pbsinfo)
#define IBandSite_GetBandSiteInfo(This, pbsinfo) (This)->lpVtbl->GetBandSiteInfo(This, pbsinfo)

declare function IBandSite_AddBand_Proxy(byval This as IBandSite ptr, byval punk as IUnknown ptr) as HRESULT
declare sub IBandSite_AddBand_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IBandSite_EnumBands_Proxy(byval This as IBandSite ptr, byval uBand as UINT, byval pdwBandID as DWORD ptr) as HRESULT
declare sub IBandSite_EnumBands_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IBandSite_RemoteQueryBand_Proxy(byval This as IBandSite ptr, byval dwBandID as DWORD, byval ppstb as IDeskBand ptr ptr, byval pdwState as DWORD ptr, byval pszName as LPWSTR, byval cchName as long) as HRESULT
declare sub IBandSite_RemoteQueryBand_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IBandSite_SetBandState_Proxy(byval This as IBandSite ptr, byval dwBandID as DWORD, byval dwMask as DWORD, byval dwState as DWORD) as HRESULT
declare sub IBandSite_SetBandState_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IBandSite_RemoveBand_Proxy(byval This as IBandSite ptr, byval dwBandID as DWORD) as HRESULT
declare sub IBandSite_RemoveBand_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IBandSite_GetBandObject_Proxy(byval This as IBandSite ptr, byval dwBandID as DWORD, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare sub IBandSite_GetBandObject_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IBandSite_SetBandSiteInfo_Proxy(byval This as IBandSite ptr, byval pbsinfo as const BANDSITEINFO ptr) as HRESULT
declare sub IBandSite_SetBandSiteInfo_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IBandSite_GetBandSiteInfo_Proxy(byval This as IBandSite ptr, byval pbsinfo as BANDSITEINFO ptr) as HRESULT
declare sub IBandSite_GetBandSiteInfo_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IBandSite_QueryBand_Proxy(byval This as IBandSite ptr, byval dwBandID as DWORD, byval ppstb as IDeskBand ptr ptr, byval pdwState as DWORD ptr, byval pszName as LPWSTR, byval cchName as long) as HRESULT
declare function IBandSite_QueryBand_Stub(byval This as IBandSite ptr, byval dwBandID as DWORD, byval ppstb as IDeskBand ptr ptr, byval pdwState as DWORD ptr, byval pszName as LPWSTR, byval cchName as long) as HRESULT
#define __IModalWindow_INTERFACE_DEFINED__
extern IID_IModalWindow as const GUID
type IModalWindow as IModalWindow_

type IModalWindowVtbl
	QueryInterface as function(byval This as IModalWindow ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IModalWindow ptr) as ULONG
	Release as function(byval This as IModalWindow ptr) as ULONG
	Show as function(byval This as IModalWindow ptr, byval hwndOwner as HWND) as HRESULT
end type

type IModalWindow_
	lpVtbl as IModalWindowVtbl ptr
end type

#define IModalWindow_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IModalWindow_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IModalWindow_Release(This) (This)->lpVtbl->Release(This)
#define IModalWindow_Show(This, hwndOwner) (This)->lpVtbl->Show(This, hwndOwner)

declare function IModalWindow_RemoteShow_Proxy(byval This as IModalWindow ptr, byval hwndOwner as HWND) as HRESULT
declare sub IModalWindow_RemoteShow_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IModalWindow_Show_Proxy(byval This as IModalWindow ptr, byval hwndOwner as HWND) as HRESULT
declare function IModalWindow_Show_Stub(byval This as IModalWindow ptr, byval hwndOwner as HWND) as HRESULT
#define PROPSTR_EXTENSIONCOMPLETIONSTATE wstr("ExtensionCompletionState")

type tagCDBURNINGEXTENSIONRET as long
enum
	CDBE_RET_DEFAULT = &h0
	CDBE_RET_DONTRUNOTHEREXTS = &h1
	CDBE_RET_STOPWIZARD = &h2
end enum

type _CDBE_ACTIONS as long
enum
	CDBE_TYPE_MUSIC = &h1
	CDBE_TYPE_DATA = &h2
	CDBE_TYPE_ALL = clng(&hffffffff)
end enum

type CDBE_ACTIONS as DWORD
#define __ICDBurnExt_INTERFACE_DEFINED__
extern IID_ICDBurnExt as const GUID
extern SID_CDWizardHost alias "IID_ICDBurnExt" as const GUID
type ICDBurnExt as ICDBurnExt_

type ICDBurnExtVtbl
	QueryInterface as function(byval This as ICDBurnExt ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ICDBurnExt ptr) as ULONG
	Release as function(byval This as ICDBurnExt ptr) as ULONG
	GetSupportedActionTypes as function(byval This as ICDBurnExt ptr, byval pdwActions as CDBE_ACTIONS ptr) as HRESULT
end type

type ICDBurnExt_
	lpVtbl as ICDBurnExtVtbl ptr
end type

#define ICDBurnExt_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define ICDBurnExt_AddRef(This) (This)->lpVtbl->AddRef(This)
#define ICDBurnExt_Release(This) (This)->lpVtbl->Release(This)
#define ICDBurnExt_GetSupportedActionTypes(This, pdwActions) (This)->lpVtbl->GetSupportedActionTypes(This, pdwActions)
declare function ICDBurnExt_GetSupportedActionTypes_Proxy(byval This as ICDBurnExt ptr, byval pdwActions as CDBE_ACTIONS ptr) as HRESULT
declare sub ICDBurnExt_GetSupportedActionTypes_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IContextMenuSite_INTERFACE_DEFINED__
extern IID_IContextMenuSite as const GUID
type IContextMenuSite as IContextMenuSite_

type IContextMenuSiteVtbl
	QueryInterface as function(byval This as IContextMenuSite ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IContextMenuSite ptr) as ULONG
	Release as function(byval This as IContextMenuSite ptr) as ULONG
	DoContextMenuPopup as function(byval This as IContextMenuSite ptr, byval punkContextMenu as IUnknown ptr, byval fFlags as UINT, byval pt as POINT) as HRESULT
end type

type IContextMenuSite_
	lpVtbl as IContextMenuSiteVtbl ptr
end type

#define IContextMenuSite_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IContextMenuSite_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IContextMenuSite_Release(This) (This)->lpVtbl->Release(This)
#define IContextMenuSite_DoContextMenuPopup(This, punkContextMenu, fFlags, pt) (This)->lpVtbl->DoContextMenuPopup(This, punkContextMenu, fFlags, pt)
declare function IContextMenuSite_DoContextMenuPopup_Proxy(byval This as IContextMenuSite ptr, byval punkContextMenu as IUnknown ptr, byval fFlags as UINT, byval pt as POINT) as HRESULT
declare sub IContextMenuSite_DoContextMenuPopup_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IEnumReadyCallback_INTERFACE_DEFINED__
extern IID_IEnumReadyCallback as const GUID
type IEnumReadyCallback as IEnumReadyCallback_

type IEnumReadyCallbackVtbl
	QueryInterface as function(byval This as IEnumReadyCallback ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IEnumReadyCallback ptr) as ULONG
	Release as function(byval This as IEnumReadyCallback ptr) as ULONG
	EnumReady as function(byval This as IEnumReadyCallback ptr) as HRESULT
end type

type IEnumReadyCallback_
	lpVtbl as IEnumReadyCallbackVtbl ptr
end type

#define IEnumReadyCallback_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IEnumReadyCallback_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IEnumReadyCallback_Release(This) (This)->lpVtbl->Release(This)
#define IEnumReadyCallback_EnumReady(This) (This)->lpVtbl->EnumReady(This)
declare function IEnumReadyCallback_EnumReady_Proxy(byval This as IEnumReadyCallback ptr) as HRESULT
declare sub IEnumReadyCallback_EnumReady_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IEnumerableView_INTERFACE_DEFINED__
extern IID_IEnumerableView as const GUID
type IEnumerableView as IEnumerableView_

type IEnumerableViewVtbl
	QueryInterface as function(byval This as IEnumerableView ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IEnumerableView ptr) as ULONG
	Release as function(byval This as IEnumerableView ptr) as ULONG
	SetEnumReadyCallback as function(byval This as IEnumerableView ptr, byval percb as IEnumReadyCallback ptr) as HRESULT
	CreateEnumIDListFromContents as function(byval This as IEnumerableView ptr, byval pidlFolder as LPCITEMIDLIST, byval dwEnumFlags as DWORD, byval ppEnumIDList as IEnumIDList ptr ptr) as HRESULT
end type

type IEnumerableView_
	lpVtbl as IEnumerableViewVtbl ptr
end type

#define IEnumerableView_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IEnumerableView_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IEnumerableView_Release(This) (This)->lpVtbl->Release(This)
#define IEnumerableView_SetEnumReadyCallback(This, percb) (This)->lpVtbl->SetEnumReadyCallback(This, percb)
#define IEnumerableView_CreateEnumIDListFromContents(This, pidlFolder, dwEnumFlags, ppEnumIDList) (This)->lpVtbl->CreateEnumIDListFromContents(This, pidlFolder, dwEnumFlags, ppEnumIDList)

declare function IEnumerableView_SetEnumReadyCallback_Proxy(byval This as IEnumerableView ptr, byval percb as IEnumReadyCallback ptr) as HRESULT
declare sub IEnumerableView_SetEnumReadyCallback_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumerableView_CreateEnumIDListFromContents_Proxy(byval This as IEnumerableView ptr, byval pidlFolder as LPCITEMIDLIST, byval dwEnumFlags as DWORD, byval ppEnumIDList as IEnumIDList ptr ptr) as HRESULT
declare sub IEnumerableView_CreateEnumIDListFromContents_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
extern SID_EnumerableView alias "IID_IEnumerableView" as const GUID
#define __IInsertItem_INTERFACE_DEFINED__
extern IID_IInsertItem as const GUID
type IInsertItem as IInsertItem_

type IInsertItemVtbl
	QueryInterface as function(byval This as IInsertItem ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IInsertItem ptr) as ULONG
	Release as function(byval This as IInsertItem ptr) as ULONG
	InsertItem as function(byval This as IInsertItem ptr, byval pidl as LPCITEMIDLIST) as HRESULT
end type

type IInsertItem_
	lpVtbl as IInsertItemVtbl ptr
end type

#define IInsertItem_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IInsertItem_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IInsertItem_Release(This) (This)->lpVtbl->Release(This)
#define IInsertItem_InsertItem(This, pidl) (This)->lpVtbl->InsertItem(This, pidl)
declare function IInsertItem_InsertItem_Proxy(byval This as IInsertItem ptr, byval pidl as LPCITEMIDLIST) as HRESULT
declare sub IInsertItem_InsertItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IMenuBand_INTERFACE_DEFINED__

type tagMENUBANDHANDLERCID as long
enum
	MBHANDCID_PIDLSELECT = 0
end enum

extern IID_IMenuBand as const GUID
type IMenuBand as IMenuBand_

type IMenuBandVtbl
	QueryInterface as function(byval This as IMenuBand ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IMenuBand ptr) as ULONG
	Release as function(byval This as IMenuBand ptr) as ULONG
	IsMenuMessage as function(byval This as IMenuBand ptr, byval pmsg as MSG ptr) as HRESULT
	TranslateMenuMessage as function(byval This as IMenuBand ptr, byval pmsg as MSG ptr, byval plRet as LRESULT ptr) as HRESULT
end type

type IMenuBand_
	lpVtbl as IMenuBandVtbl ptr
end type

#define IMenuBand_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IMenuBand_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IMenuBand_Release(This) (This)->lpVtbl->Release(This)
#define IMenuBand_IsMenuMessage(This, pmsg) (This)->lpVtbl->IsMenuMessage(This, pmsg)
#define IMenuBand_TranslateMenuMessage(This, pmsg, plRet) (This)->lpVtbl->TranslateMenuMessage(This, pmsg, plRet)

declare function IMenuBand_IsMenuMessage_Proxy(byval This as IMenuBand ptr, byval pmsg as MSG ptr) as HRESULT
declare sub IMenuBand_IsMenuMessage_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMenuBand_TranslateMenuMessage_Proxy(byval This as IMenuBand ptr, byval pmsg as MSG ptr, byval plRet as LRESULT ptr) as HRESULT
declare sub IMenuBand_TranslateMenuMessage_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IFolderBandPriv_INTERFACE_DEFINED__
extern IID_IFolderBandPriv as const GUID
type IFolderBandPriv as IFolderBandPriv_

type IFolderBandPrivVtbl
	QueryInterface as function(byval This as IFolderBandPriv ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IFolderBandPriv ptr) as ULONG
	Release as function(byval This as IFolderBandPriv ptr) as ULONG
	SetCascade as function(byval This as IFolderBandPriv ptr, byval fCascade as WINBOOL) as HRESULT
	SetAccelerators as function(byval This as IFolderBandPriv ptr, byval fAccelerators as WINBOOL) as HRESULT
	SetNoIcons as function(byval This as IFolderBandPriv ptr, byval fNoIcons as WINBOOL) as HRESULT
	SetNoText as function(byval This as IFolderBandPriv ptr, byval fNoText as WINBOOL) as HRESULT
end type

type IFolderBandPriv_
	lpVtbl as IFolderBandPrivVtbl ptr
end type

#define IFolderBandPriv_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IFolderBandPriv_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IFolderBandPriv_Release(This) (This)->lpVtbl->Release(This)
#define IFolderBandPriv_SetCascade(This, fCascade) (This)->lpVtbl->SetCascade(This, fCascade)
#define IFolderBandPriv_SetAccelerators(This, fAccelerators) (This)->lpVtbl->SetAccelerators(This, fAccelerators)
#define IFolderBandPriv_SetNoIcons(This, fNoIcons) (This)->lpVtbl->SetNoIcons(This, fNoIcons)
#define IFolderBandPriv_SetNoText(This, fNoText) (This)->lpVtbl->SetNoText(This, fNoText)

declare function IFolderBandPriv_SetCascade_Proxy(byval This as IFolderBandPriv ptr, byval fCascade as WINBOOL) as HRESULT
declare sub IFolderBandPriv_SetCascade_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFolderBandPriv_SetAccelerators_Proxy(byval This as IFolderBandPriv ptr, byval fAccelerators as WINBOOL) as HRESULT
declare sub IFolderBandPriv_SetAccelerators_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFolderBandPriv_SetNoIcons_Proxy(byval This as IFolderBandPriv ptr, byval fNoIcons as WINBOOL) as HRESULT
declare sub IFolderBandPriv_SetNoIcons_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFolderBandPriv_SetNoText_Proxy(byval This as IFolderBandPriv ptr, byval fNoText as WINBOOL) as HRESULT
declare sub IFolderBandPriv_SetNoText_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IRegTreeItem_INTERFACE_DEFINED__
extern IID_IRegTreeItem as const GUID
type IRegTreeItem as IRegTreeItem_

type IRegTreeItemVtbl
	QueryInterface as function(byval This as IRegTreeItem ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IRegTreeItem ptr) as ULONG
	Release as function(byval This as IRegTreeItem ptr) as ULONG
	GetCheckState as function(byval This as IRegTreeItem ptr, byval pbCheck as WINBOOL ptr) as HRESULT
	SetCheckState as function(byval This as IRegTreeItem ptr, byval bCheck as WINBOOL) as HRESULT
end type

type IRegTreeItem_
	lpVtbl as IRegTreeItemVtbl ptr
end type

#define IRegTreeItem_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IRegTreeItem_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IRegTreeItem_Release(This) (This)->lpVtbl->Release(This)
#define IRegTreeItem_GetCheckState(This, pbCheck) (This)->lpVtbl->GetCheckState(This, pbCheck)
#define IRegTreeItem_SetCheckState(This, bCheck) (This)->lpVtbl->SetCheckState(This, bCheck)

declare function IRegTreeItem_GetCheckState_Proxy(byval This as IRegTreeItem ptr, byval pbCheck as WINBOOL ptr) as HRESULT
declare sub IRegTreeItem_GetCheckState_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IRegTreeItem_SetCheckState_Proxy(byval This as IRegTreeItem ptr, byval bCheck as WINBOOL) as HRESULT
declare sub IRegTreeItem_SetCheckState_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IImageRecompress_INTERFACE_DEFINED__
extern IID_IImageRecompress as const GUID
type IImageRecompress as IImageRecompress_

type IImageRecompressVtbl
	QueryInterface as function(byval This as IImageRecompress ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IImageRecompress ptr) as ULONG
	Release as function(byval This as IImageRecompress ptr) as ULONG
	RecompressImage as function(byval This as IImageRecompress ptr, byval psi as IShellItem ptr, byval cx as long, byval cy as long, byval iQuality as long, byval pstg as IStorage ptr, byval ppstrmOut as IStream ptr ptr) as HRESULT
end type

type IImageRecompress_
	lpVtbl as IImageRecompressVtbl ptr
end type

#define IImageRecompress_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IImageRecompress_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IImageRecompress_Release(This) (This)->lpVtbl->Release(This)
#define IImageRecompress_RecompressImage(This, psi, cx, cy, iQuality, pstg, ppstrmOut) (This)->lpVtbl->RecompressImage(This, psi, cx, cy, iQuality, pstg, ppstrmOut)
declare function IImageRecompress_RecompressImage_Proxy(byval This as IImageRecompress ptr, byval psi as IShellItem ptr, byval cx as long, byval cy as long, byval iQuality as long, byval pstg as IStorage ptr, byval ppstrmOut as IStream ptr ptr) as HRESULT
declare sub IImageRecompress_RecompressImage_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#if _WIN32_WINNT >= &h0501
	#define __IDeskBar_INTERFACE_DEFINED__
	extern IID_IDeskBar as const GUID
	type IDeskBar as IDeskBar_

	type IDeskBarVtbl
		QueryInterface as function(byval This as IDeskBar ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IDeskBar ptr) as ULONG
		Release as function(byval This as IDeskBar ptr) as ULONG
		GetWindow as function(byval This as IDeskBar ptr, byval phwnd as HWND ptr) as HRESULT
		ContextSensitiveHelp as function(byval This as IDeskBar ptr, byval fEnterMode as WINBOOL) as HRESULT
		SetClient as function(byval This as IDeskBar ptr, byval punkClient as IUnknown ptr) as HRESULT
		GetClient as function(byval This as IDeskBar ptr, byval ppunkClient as IUnknown ptr ptr) as HRESULT
		OnPosRectChangeDB as function(byval This as IDeskBar ptr, byval prc as RECT ptr) as HRESULT
	end type

	type IDeskBar_
		lpVtbl as IDeskBarVtbl ptr
	end type

	#define IDeskBar_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IDeskBar_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IDeskBar_Release(This) (This)->lpVtbl->Release(This)
	#define IDeskBar_GetWindow(This, phwnd) (This)->lpVtbl->GetWindow(This, phwnd)
	#define IDeskBar_ContextSensitiveHelp(This, fEnterMode) (This)->lpVtbl->ContextSensitiveHelp(This, fEnterMode)
	#define IDeskBar_SetClient(This, punkClient) (This)->lpVtbl->SetClient(This, punkClient)
	#define IDeskBar_GetClient(This, ppunkClient) (This)->lpVtbl->GetClient(This, ppunkClient)
	#define IDeskBar_OnPosRectChangeDB(This, prc) (This)->lpVtbl->OnPosRectChangeDB(This, prc)

	declare function IDeskBar_SetClient_Proxy(byval This as IDeskBar ptr, byval punkClient as IUnknown ptr) as HRESULT
	declare sub IDeskBar_SetClient_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IDeskBar_GetClient_Proxy(byval This as IDeskBar ptr, byval ppunkClient as IUnknown ptr ptr) as HRESULT
	declare sub IDeskBar_GetClient_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IDeskBar_OnPosRectChangeDB_Proxy(byval This as IDeskBar ptr, byval prc as RECT ptr) as HRESULT
	declare sub IDeskBar_OnPosRectChangeDB_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	#define __IMenuPopup_INTERFACE_DEFINED__

	type tagMENUPOPUPSELECT as long
	enum
		MPOS_EXECUTE = 0
		MPOS_FULLCANCEL = 1
		MPOS_CANCELLEVEL = 2
		MPOS_SELECTLEFT = 3
		MPOS_SELECTRIGHT = 4
		MPOS_CHILDTRACKING = 5
	end enum

	type tagMENUPOPUPPOPUPFLAGS as long
	enum
		MPPF_SETFOCUS = &h1
		MPPF_INITIALSELECT = &h2
		MPPF_NOANIMATE = &h4
		MPPF_KEYBOARD = &h10
		MPPF_REPOSITION = &h20
		MPPF_FORCEZORDER = &h40
		MPPF_FINALSELECT = &h80
		MPPF_TOP = &h20000000
		MPPF_LEFT = &h40000000
		MPPF_RIGHT = &h60000000
		MPPF_BOTTOM = clng(&h80000000)
		MPPF_POS_MASK = clng(&he0000000)
		MPPF_ALIGN_LEFT = &h2000000
		MPPF_ALIGN_RIGHT = &h4000000
	end enum

	type MP_POPUPFLAGS as long
	extern IID_IMenuPopup as const GUID
	type IMenuPopup as IMenuPopup_

	type IMenuPopupVtbl
		QueryInterface as function(byval This as IMenuPopup ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IMenuPopup ptr) as ULONG
		Release as function(byval This as IMenuPopup ptr) as ULONG
		GetWindow as function(byval This as IMenuPopup ptr, byval phwnd as HWND ptr) as HRESULT
		ContextSensitiveHelp as function(byval This as IMenuPopup ptr, byval fEnterMode as WINBOOL) as HRESULT
		SetClient as function(byval This as IMenuPopup ptr, byval punkClient as IUnknown ptr) as HRESULT
		GetClient as function(byval This as IMenuPopup ptr, byval ppunkClient as IUnknown ptr ptr) as HRESULT
		OnPosRectChangeDB as function(byval This as IMenuPopup ptr, byval prc as RECT ptr) as HRESULT
		Popup as function(byval This as IMenuPopup ptr, byval ppt as POINTL ptr, byval prcExclude as RECTL ptr, byval dwFlags as MP_POPUPFLAGS) as HRESULT
		OnSelect as function(byval This as IMenuPopup ptr, byval dwSelectType as DWORD) as HRESULT
		SetSubMenu as function(byval This as IMenuPopup ptr, byval pmp as IMenuPopup ptr, byval fSet as WINBOOL) as HRESULT
	end type

	type IMenuPopup_
		lpVtbl as IMenuPopupVtbl ptr
	end type

	#define IMenuPopup_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IMenuPopup_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IMenuPopup_Release(This) (This)->lpVtbl->Release(This)
	#define IMenuPopup_GetWindow(This, phwnd) (This)->lpVtbl->GetWindow(This, phwnd)
	#define IMenuPopup_ContextSensitiveHelp(This, fEnterMode) (This)->lpVtbl->ContextSensitiveHelp(This, fEnterMode)
	#define IMenuPopup_SetClient(This, punkClient) (This)->lpVtbl->SetClient(This, punkClient)
	#define IMenuPopup_GetClient(This, ppunkClient) (This)->lpVtbl->GetClient(This, ppunkClient)
	#define IMenuPopup_OnPosRectChangeDB(This, prc) (This)->lpVtbl->OnPosRectChangeDB(This, prc)
	#define IMenuPopup_Popup(This, ppt, prcExclude, dwFlags) (This)->lpVtbl->Popup(This, ppt, prcExclude, dwFlags)
	#define IMenuPopup_OnSelect(This, dwSelectType) (This)->lpVtbl->OnSelect(This, dwSelectType)
	#define IMenuPopup_SetSubMenu(This, pmp, fSet) (This)->lpVtbl->SetSubMenu(This, pmp, fSet)

	declare function IMenuPopup_Popup_Proxy(byval This as IMenuPopup ptr, byval ppt as POINTL ptr, byval prcExclude as RECTL ptr, byval dwFlags as MP_POPUPFLAGS) as HRESULT
	declare sub IMenuPopup_Popup_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IMenuPopup_OnSelect_Proxy(byval This as IMenuPopup ptr, byval dwSelectType as DWORD) as HRESULT
	declare sub IMenuPopup_OnSelect_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IMenuPopup_SetSubMenu_Proxy(byval This as IMenuPopup ptr, byval pmp as IMenuPopup ptr, byval fSet as WINBOOL) as HRESULT
	declare sub IMenuPopup_SetSubMenu_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#endif

type IShellItemFilter as IShellItemFilter_

#if _WIN32_WINNT >= &h0600
	type FILE_USAGE_TYPE as long
	enum
		FUT_PLAYING = 0
		FUT_EDITING = 1
		FUT_GENERIC = 2
	end enum

	const OF_CAP_CANSWITCHTO = &h0001
	const OF_CAP_CANCLOSE = &h0002
	#define __IFileIsInUse_INTERFACE_DEFINED__
	extern IID_IFileIsInUse as const GUID
	type IFileIsInUse as IFileIsInUse_

	type IFileIsInUseVtbl
		QueryInterface as function(byval This as IFileIsInUse ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IFileIsInUse ptr) as ULONG
		Release as function(byval This as IFileIsInUse ptr) as ULONG
		GetAppName as function(byval This as IFileIsInUse ptr, byval ppszName as LPWSTR ptr) as HRESULT
		GetUsage as function(byval This as IFileIsInUse ptr, byval pfut as FILE_USAGE_TYPE ptr) as HRESULT
		GetCapabilities as function(byval This as IFileIsInUse ptr, byval pdwCapFlags as DWORD ptr) as HRESULT
		GetSwitchToHWND as function(byval This as IFileIsInUse ptr, byval phwnd as HWND ptr) as HRESULT
		CloseFile as function(byval This as IFileIsInUse ptr) as HRESULT
	end type

	type IFileIsInUse_
		lpVtbl as IFileIsInUseVtbl ptr
	end type

	#define IFileIsInUse_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IFileIsInUse_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IFileIsInUse_Release(This) (This)->lpVtbl->Release(This)
	#define IFileIsInUse_GetAppName(This, ppszName) (This)->lpVtbl->GetAppName(This, ppszName)
	#define IFileIsInUse_GetUsage(This, pfut) (This)->lpVtbl->GetUsage(This, pfut)
	#define IFileIsInUse_GetCapabilities(This, pdwCapFlags) (This)->lpVtbl->GetCapabilities(This, pdwCapFlags)
	#define IFileIsInUse_GetSwitchToHWND(This, phwnd) (This)->lpVtbl->GetSwitchToHWND(This, phwnd)
	#define IFileIsInUse_CloseFile(This) (This)->lpVtbl->CloseFile(This)

	declare function IFileIsInUse_GetAppName_Proxy(byval This as IFileIsInUse ptr, byval ppszName as LPWSTR ptr) as HRESULT
	declare sub IFileIsInUse_GetAppName_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileIsInUse_GetUsage_Proxy(byval This as IFileIsInUse ptr, byval pfut as FILE_USAGE_TYPE ptr) as HRESULT
	declare sub IFileIsInUse_GetUsage_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileIsInUse_GetCapabilities_Proxy(byval This as IFileIsInUse ptr, byval pdwCapFlags as DWORD ptr) as HRESULT
	declare sub IFileIsInUse_GetCapabilities_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileIsInUse_GetSwitchToHWND_Proxy(byval This as IFileIsInUse ptr, byval phwnd as HWND ptr) as HRESULT
	declare sub IFileIsInUse_GetSwitchToHWND_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileIsInUse_CloseFile_Proxy(byval This as IFileIsInUse ptr) as HRESULT
	declare sub IFileIsInUse_CloseFile_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

	type FDE_OVERWRITE_RESPONSE as long
	enum
		FDEOR_DEFAULT = 0
		FDEOR_ACCEPT = 1
		FDEOR_REFUSE = 2
	end enum

	type FDE_SHAREVIOLATION_RESPONSE as long
	enum
		FDESVR_DEFAULT = 0
		FDESVR_ACCEPT = 1
		FDESVR_REFUSE = 2
	end enum

	type FDAP as long
	enum
		FDAP_BOTTOM = 0
		FDAP_TOP = 1
	end enum

	#define __IFileDialogEvents_INTERFACE_DEFINED__
	extern IID_IFileDialogEvents as const GUID
	type IFileDialogEvents as IFileDialogEvents_
	type IFileDialog as IFileDialog_

	type IFileDialogEventsVtbl
		QueryInterface as function(byval This as IFileDialogEvents ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IFileDialogEvents ptr) as ULONG
		Release as function(byval This as IFileDialogEvents ptr) as ULONG
		OnFileOk as function(byval This as IFileDialogEvents ptr, byval pfd as IFileDialog ptr) as HRESULT
		OnFolderChanging as function(byval This as IFileDialogEvents ptr, byval pfd as IFileDialog ptr, byval psiFolder as IShellItem ptr) as HRESULT
		OnFolderChange as function(byval This as IFileDialogEvents ptr, byval pfd as IFileDialog ptr) as HRESULT
		OnSelectionChange as function(byval This as IFileDialogEvents ptr, byval pfd as IFileDialog ptr) as HRESULT
		OnShareViolation as function(byval This as IFileDialogEvents ptr, byval pfd as IFileDialog ptr, byval psi as IShellItem ptr, byval pResponse as FDE_SHAREVIOLATION_RESPONSE ptr) as HRESULT
		OnTypeChange as function(byval This as IFileDialogEvents ptr, byval pfd as IFileDialog ptr) as HRESULT
		OnOverwrite as function(byval This as IFileDialogEvents ptr, byval pfd as IFileDialog ptr, byval psi as IShellItem ptr, byval pResponse as FDE_OVERWRITE_RESPONSE ptr) as HRESULT
	end type

	type IFileDialogEvents_
		lpVtbl as IFileDialogEventsVtbl ptr
	end type

	#define IFileDialogEvents_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IFileDialogEvents_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IFileDialogEvents_Release(This) (This)->lpVtbl->Release(This)
	#define IFileDialogEvents_OnFileOk(This, pfd) (This)->lpVtbl->OnFileOk(This, pfd)
	#define IFileDialogEvents_OnFolderChanging(This, pfd, psiFolder) (This)->lpVtbl->OnFolderChanging(This, pfd, psiFolder)
	#define IFileDialogEvents_OnFolderChange(This, pfd) (This)->lpVtbl->OnFolderChange(This, pfd)
	#define IFileDialogEvents_OnSelectionChange(This, pfd) (This)->lpVtbl->OnSelectionChange(This, pfd)
	#define IFileDialogEvents_OnShareViolation(This, pfd, psi, pResponse) (This)->lpVtbl->OnShareViolation(This, pfd, psi, pResponse)
	#define IFileDialogEvents_OnTypeChange(This, pfd) (This)->lpVtbl->OnTypeChange(This, pfd)
	#define IFileDialogEvents_OnOverwrite(This, pfd, psi, pResponse) (This)->lpVtbl->OnOverwrite(This, pfd, psi, pResponse)

	declare function IFileDialogEvents_OnFileOk_Proxy(byval This as IFileDialogEvents ptr, byval pfd as IFileDialog ptr) as HRESULT
	declare sub IFileDialogEvents_OnFileOk_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialogEvents_OnFolderChanging_Proxy(byval This as IFileDialogEvents ptr, byval pfd as IFileDialog ptr, byval psiFolder as IShellItem ptr) as HRESULT
	declare sub IFileDialogEvents_OnFolderChanging_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialogEvents_OnFolderChange_Proxy(byval This as IFileDialogEvents ptr, byval pfd as IFileDialog ptr) as HRESULT
	declare sub IFileDialogEvents_OnFolderChange_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialogEvents_OnSelectionChange_Proxy(byval This as IFileDialogEvents ptr, byval pfd as IFileDialog ptr) as HRESULT
	declare sub IFileDialogEvents_OnSelectionChange_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialogEvents_OnShareViolation_Proxy(byval This as IFileDialogEvents ptr, byval pfd as IFileDialog ptr, byval psi as IShellItem ptr, byval pResponse as FDE_SHAREVIOLATION_RESPONSE ptr) as HRESULT
	declare sub IFileDialogEvents_OnShareViolation_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialogEvents_OnTypeChange_Proxy(byval This as IFileDialogEvents ptr, byval pfd as IFileDialog ptr) as HRESULT
	declare sub IFileDialogEvents_OnTypeChange_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialogEvents_OnOverwrite_Proxy(byval This as IFileDialogEvents ptr, byval pfd as IFileDialog ptr, byval psi as IShellItem ptr, byval pResponse as FDE_OVERWRITE_RESPONSE ptr) as HRESULT
	declare sub IFileDialogEvents_OnOverwrite_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	#define __IFileDialog_INTERFACE_DEFINED__

	type _FILEOPENDIALOGOPTIONS as long
	enum
		FOS_OVERWRITEPROMPT = &h2
		FOS_STRICTFILETYPES = &h4
		FOS_NOCHANGEDIR = &h8
		FOS_PICKFOLDERS = &h20
		FOS_FORCEFILESYSTEM = &h40
		FOS_ALLNONSTORAGEITEMS = &h80
		FOS_NOVALIDATE = &h100
		FOS_ALLOWMULTISELECT = &h200
		FOS_PATHMUSTEXIST = &h800
		FOS_FILEMUSTEXIST = &h1000
		FOS_CREATEPROMPT = &h2000
		FOS_SHAREAWARE = &h4000
		FOS_NOREADONLYRETURN = &h8000
		FOS_NOTESTFILECREATE = &h10000
		FOS_HIDEMRUPLACES = &h20000
		FOS_HIDEPINNEDPLACES = &h40000
		FOS_NODEREFERENCELINKS = &h100000
		FOS_DONTADDTORECENT = &h2000000
		FOS_FORCESHOWHIDDEN = &h10000000
		FOS_DEFAULTNOMINIMODE = &h20000000
		FOS_FORCEPREVIEWPANEON = &h40000000
	end enum

	type FILEOPENDIALOGOPTIONS as DWORD
	extern IID_IFileDialog as const GUID

	type IFileDialogVtbl
		QueryInterface as function(byval This as IFileDialog ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IFileDialog ptr) as ULONG
		Release as function(byval This as IFileDialog ptr) as ULONG
		Show as function(byval This as IFileDialog ptr, byval hwndOwner as HWND) as HRESULT
		SetFileTypes as function(byval This as IFileDialog ptr, byval cFileTypes as UINT, byval rgFilterSpec as const COMDLG_FILTERSPEC ptr) as HRESULT
		SetFileTypeIndex as function(byval This as IFileDialog ptr, byval iFileType as UINT) as HRESULT
		GetFileTypeIndex as function(byval This as IFileDialog ptr, byval piFileType as UINT ptr) as HRESULT
		Advise as function(byval This as IFileDialog ptr, byval pfde as IFileDialogEvents ptr, byval pdwCookie as DWORD ptr) as HRESULT
		Unadvise as function(byval This as IFileDialog ptr, byval dwCookie as DWORD) as HRESULT
		SetOptions as function(byval This as IFileDialog ptr, byval fos as FILEOPENDIALOGOPTIONS) as HRESULT
		GetOptions as function(byval This as IFileDialog ptr, byval pfos as FILEOPENDIALOGOPTIONS ptr) as HRESULT
		SetDefaultFolder as function(byval This as IFileDialog ptr, byval psi as IShellItem ptr) as HRESULT
		SetFolder as function(byval This as IFileDialog ptr, byval psi as IShellItem ptr) as HRESULT
		GetFolder as function(byval This as IFileDialog ptr, byval ppsi as IShellItem ptr ptr) as HRESULT
		GetCurrentSelection as function(byval This as IFileDialog ptr, byval ppsi as IShellItem ptr ptr) as HRESULT
		SetFileName as function(byval This as IFileDialog ptr, byval pszName as LPCWSTR) as HRESULT
		GetFileName as function(byval This as IFileDialog ptr, byval pszName as LPWSTR ptr) as HRESULT
		SetTitle as function(byval This as IFileDialog ptr, byval pszTitle as LPCWSTR) as HRESULT
		SetOkButtonLabel as function(byval This as IFileDialog ptr, byval pszText as LPCWSTR) as HRESULT
		SetFileNameLabel as function(byval This as IFileDialog ptr, byval pszLabel as LPCWSTR) as HRESULT
		GetResult as function(byval This as IFileDialog ptr, byval ppsi as IShellItem ptr ptr) as HRESULT
		AddPlace as function(byval This as IFileDialog ptr, byval psi as IShellItem ptr, byval fdap as FDAP) as HRESULT
		SetDefaultExtension as function(byval This as IFileDialog ptr, byval pszDefaultExtension as LPCWSTR) as HRESULT
		Close as function(byval This as IFileDialog ptr, byval hr as HRESULT) as HRESULT
		SetClientGuid as function(byval This as IFileDialog ptr, byval guid as const GUID const ptr) as HRESULT
		ClearClientData as function(byval This as IFileDialog ptr) as HRESULT
		SetFilter as function(byval This as IFileDialog ptr, byval pFilter as IShellItemFilter ptr) as HRESULT
	end type

	type IFileDialog_
		lpVtbl as IFileDialogVtbl ptr
	end type

	#define IFileDialog_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IFileDialog_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IFileDialog_Release(This) (This)->lpVtbl->Release(This)
	#define IFileDialog_Show(This, hwndOwner) (This)->lpVtbl->Show(This, hwndOwner)
	#define IFileDialog_SetFileTypes(This, cFileTypes, rgFilterSpec) (This)->lpVtbl->SetFileTypes(This, cFileTypes, rgFilterSpec)
	#define IFileDialog_SetFileTypeIndex(This, iFileType) (This)->lpVtbl->SetFileTypeIndex(This, iFileType)
	#define IFileDialog_GetFileTypeIndex(This, piFileType) (This)->lpVtbl->GetFileTypeIndex(This, piFileType)
	#define IFileDialog_Advise(This, pfde, pdwCookie) (This)->lpVtbl->Advise(This, pfde, pdwCookie)
	#define IFileDialog_Unadvise(This, dwCookie) (This)->lpVtbl->Unadvise(This, dwCookie)
	#define IFileDialog_SetOptions(This, fos) (This)->lpVtbl->SetOptions(This, fos)
	#define IFileDialog_GetOptions(This, pfos) (This)->lpVtbl->GetOptions(This, pfos)
	#define IFileDialog_SetDefaultFolder(This, psi) (This)->lpVtbl->SetDefaultFolder(This, psi)
	#define IFileDialog_SetFolder(This, psi) (This)->lpVtbl->SetFolder(This, psi)
	#define IFileDialog_GetFolder(This, ppsi) (This)->lpVtbl->GetFolder(This, ppsi)
	#define IFileDialog_GetCurrentSelection(This, ppsi) (This)->lpVtbl->GetCurrentSelection(This, ppsi)
	#define IFileDialog_SetFileName(This, pszName) (This)->lpVtbl->SetFileName(This, pszName)
	#define IFileDialog_GetFileName(This, pszName) (This)->lpVtbl->GetFileName(This, pszName)
	#define IFileDialog_SetTitle(This, pszTitle) (This)->lpVtbl->SetTitle(This, pszTitle)
	#define IFileDialog_SetOkButtonLabel(This, pszText) (This)->lpVtbl->SetOkButtonLabel(This, pszText)
	#define IFileDialog_SetFileNameLabel(This, pszLabel) (This)->lpVtbl->SetFileNameLabel(This, pszLabel)
	#define IFileDialog_GetResult(This, ppsi) (This)->lpVtbl->GetResult(This, ppsi)
	#define IFileDialog_AddPlace(This, psi, fdap) (This)->lpVtbl->AddPlace(This, psi, fdap)
	#define IFileDialog_SetDefaultExtension(This, pszDefaultExtension) (This)->lpVtbl->SetDefaultExtension(This, pszDefaultExtension)
	#define IFileDialog_Close(This, hr) (This)->lpVtbl->Close(This, hr)
	#define IFileDialog_SetClientGuid(This, guid) (This)->lpVtbl->SetClientGuid(This, guid)
	#define IFileDialog_ClearClientData(This) (This)->lpVtbl->ClearClientData(This)
	#define IFileDialog_SetFilter(This, pFilter) (This)->lpVtbl->SetFilter(This, pFilter)

	declare function IFileDialog_SetFileTypes_Proxy(byval This as IFileDialog ptr, byval cFileTypes as UINT, byval rgFilterSpec as const COMDLG_FILTERSPEC ptr) as HRESULT
	declare sub IFileDialog_SetFileTypes_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialog_SetFileTypeIndex_Proxy(byval This as IFileDialog ptr, byval iFileType as UINT) as HRESULT
	declare sub IFileDialog_SetFileTypeIndex_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialog_GetFileTypeIndex_Proxy(byval This as IFileDialog ptr, byval piFileType as UINT ptr) as HRESULT
	declare sub IFileDialog_GetFileTypeIndex_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialog_Advise_Proxy(byval This as IFileDialog ptr, byval pfde as IFileDialogEvents ptr, byval pdwCookie as DWORD ptr) as HRESULT
	declare sub IFileDialog_Advise_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialog_Unadvise_Proxy(byval This as IFileDialog ptr, byval dwCookie as DWORD) as HRESULT
	declare sub IFileDialog_Unadvise_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialog_SetOptions_Proxy(byval This as IFileDialog ptr, byval fos as FILEOPENDIALOGOPTIONS) as HRESULT
	declare sub IFileDialog_SetOptions_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialog_GetOptions_Proxy(byval This as IFileDialog ptr, byval pfos as FILEOPENDIALOGOPTIONS ptr) as HRESULT
	declare sub IFileDialog_GetOptions_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialog_SetDefaultFolder_Proxy(byval This as IFileDialog ptr, byval psi as IShellItem ptr) as HRESULT
	declare sub IFileDialog_SetDefaultFolder_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialog_SetFolder_Proxy(byval This as IFileDialog ptr, byval psi as IShellItem ptr) as HRESULT
	declare sub IFileDialog_SetFolder_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialog_GetFolder_Proxy(byval This as IFileDialog ptr, byval ppsi as IShellItem ptr ptr) as HRESULT
	declare sub IFileDialog_GetFolder_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialog_GetCurrentSelection_Proxy(byval This as IFileDialog ptr, byval ppsi as IShellItem ptr ptr) as HRESULT
	declare sub IFileDialog_GetCurrentSelection_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialog_SetFileName_Proxy(byval This as IFileDialog ptr, byval pszName as LPCWSTR) as HRESULT
	declare sub IFileDialog_SetFileName_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialog_GetFileName_Proxy(byval This as IFileDialog ptr, byval pszName as LPWSTR ptr) as HRESULT
	declare sub IFileDialog_GetFileName_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialog_SetTitle_Proxy(byval This as IFileDialog ptr, byval pszTitle as LPCWSTR) as HRESULT
	declare sub IFileDialog_SetTitle_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialog_SetOkButtonLabel_Proxy(byval This as IFileDialog ptr, byval pszText as LPCWSTR) as HRESULT
	declare sub IFileDialog_SetOkButtonLabel_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialog_SetFileNameLabel_Proxy(byval This as IFileDialog ptr, byval pszLabel as LPCWSTR) as HRESULT
	declare sub IFileDialog_SetFileNameLabel_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialog_GetResult_Proxy(byval This as IFileDialog ptr, byval ppsi as IShellItem ptr ptr) as HRESULT
	declare sub IFileDialog_GetResult_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialog_AddPlace_Proxy(byval This as IFileDialog ptr, byval psi as IShellItem ptr, byval fdap as FDAP) as HRESULT
	declare sub IFileDialog_AddPlace_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialog_SetDefaultExtension_Proxy(byval This as IFileDialog ptr, byval pszDefaultExtension as LPCWSTR) as HRESULT
	declare sub IFileDialog_SetDefaultExtension_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialog_Close_Proxy(byval This as IFileDialog ptr, byval hr as HRESULT) as HRESULT
	declare sub IFileDialog_Close_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialog_SetClientGuid_Proxy(byval This as IFileDialog ptr, byval guid as const GUID const ptr) as HRESULT
	declare sub IFileDialog_SetClientGuid_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialog_ClearClientData_Proxy(byval This as IFileDialog ptr) as HRESULT
	declare sub IFileDialog_ClearClientData_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialog_SetFilter_Proxy(byval This as IFileDialog ptr, byval pFilter as IShellItemFilter ptr) as HRESULT
	declare sub IFileDialog_SetFilter_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	#define __IFileSaveDialog_INTERFACE_DEFINED__
	extern IID_IFileSaveDialog as const GUID
	type IFileSaveDialog as IFileSaveDialog_

	type IFileSaveDialogVtbl
		QueryInterface as function(byval This as IFileSaveDialog ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IFileSaveDialog ptr) as ULONG
		Release as function(byval This as IFileSaveDialog ptr) as ULONG
		Show as function(byval This as IFileSaveDialog ptr, byval hwndOwner as HWND) as HRESULT
		SetFileTypes as function(byval This as IFileSaveDialog ptr, byval cFileTypes as UINT, byval rgFilterSpec as const COMDLG_FILTERSPEC ptr) as HRESULT
		SetFileTypeIndex as function(byval This as IFileSaveDialog ptr, byval iFileType as UINT) as HRESULT
		GetFileTypeIndex as function(byval This as IFileSaveDialog ptr, byval piFileType as UINT ptr) as HRESULT
		Advise as function(byval This as IFileSaveDialog ptr, byval pfde as IFileDialogEvents ptr, byval pdwCookie as DWORD ptr) as HRESULT
		Unadvise as function(byval This as IFileSaveDialog ptr, byval dwCookie as DWORD) as HRESULT
		SetOptions as function(byval This as IFileSaveDialog ptr, byval fos as FILEOPENDIALOGOPTIONS) as HRESULT
		GetOptions as function(byval This as IFileSaveDialog ptr, byval pfos as FILEOPENDIALOGOPTIONS ptr) as HRESULT
		SetDefaultFolder as function(byval This as IFileSaveDialog ptr, byval psi as IShellItem ptr) as HRESULT
		SetFolder as function(byval This as IFileSaveDialog ptr, byval psi as IShellItem ptr) as HRESULT
		GetFolder as function(byval This as IFileSaveDialog ptr, byval ppsi as IShellItem ptr ptr) as HRESULT
		GetCurrentSelection as function(byval This as IFileSaveDialog ptr, byval ppsi as IShellItem ptr ptr) as HRESULT
		SetFileName as function(byval This as IFileSaveDialog ptr, byval pszName as LPCWSTR) as HRESULT
		GetFileName as function(byval This as IFileSaveDialog ptr, byval pszName as LPWSTR ptr) as HRESULT
		SetTitle as function(byval This as IFileSaveDialog ptr, byval pszTitle as LPCWSTR) as HRESULT
		SetOkButtonLabel as function(byval This as IFileSaveDialog ptr, byval pszText as LPCWSTR) as HRESULT
		SetFileNameLabel as function(byval This as IFileSaveDialog ptr, byval pszLabel as LPCWSTR) as HRESULT
		GetResult as function(byval This as IFileSaveDialog ptr, byval ppsi as IShellItem ptr ptr) as HRESULT
		AddPlace as function(byval This as IFileSaveDialog ptr, byval psi as IShellItem ptr, byval fdap as FDAP) as HRESULT
		SetDefaultExtension as function(byval This as IFileSaveDialog ptr, byval pszDefaultExtension as LPCWSTR) as HRESULT
		Close as function(byval This as IFileSaveDialog ptr, byval hr as HRESULT) as HRESULT
		SetClientGuid as function(byval This as IFileSaveDialog ptr, byval guid as const GUID const ptr) as HRESULT
		ClearClientData as function(byval This as IFileSaveDialog ptr) as HRESULT
		SetFilter as function(byval This as IFileSaveDialog ptr, byval pFilter as IShellItemFilter ptr) as HRESULT
		SetSaveAsItem as function(byval This as IFileSaveDialog ptr, byval psi as IShellItem ptr) as HRESULT
		SetProperties as function(byval This as IFileSaveDialog ptr, byval pStore as IPropertyStore ptr) as HRESULT
		SetCollectedProperties as function(byval This as IFileSaveDialog ptr, byval pList as IPropertyDescriptionList ptr, byval fAppendDefault as WINBOOL) as HRESULT
		GetProperties as function(byval This as IFileSaveDialog ptr, byval ppStore as IPropertyStore ptr ptr) as HRESULT
		ApplyProperties as function(byval This as IFileSaveDialog ptr, byval psi as IShellItem ptr, byval pStore as IPropertyStore ptr, byval hwnd as HWND, byval pSink as IFileOperationProgressSink ptr) as HRESULT
	end type

	type IFileSaveDialog_
		lpVtbl as IFileSaveDialogVtbl ptr
	end type

	#define IFileSaveDialog_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IFileSaveDialog_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IFileSaveDialog_Release(This) (This)->lpVtbl->Release(This)
	#define IFileSaveDialog_Show(This, hwndOwner) (This)->lpVtbl->Show(This, hwndOwner)
	#define IFileSaveDialog_SetFileTypes(This, cFileTypes, rgFilterSpec) (This)->lpVtbl->SetFileTypes(This, cFileTypes, rgFilterSpec)
	#define IFileSaveDialog_SetFileTypeIndex(This, iFileType) (This)->lpVtbl->SetFileTypeIndex(This, iFileType)
	#define IFileSaveDialog_GetFileTypeIndex(This, piFileType) (This)->lpVtbl->GetFileTypeIndex(This, piFileType)
	#define IFileSaveDialog_Advise(This, pfde, pdwCookie) (This)->lpVtbl->Advise(This, pfde, pdwCookie)
	#define IFileSaveDialog_Unadvise(This, dwCookie) (This)->lpVtbl->Unadvise(This, dwCookie)
	#define IFileSaveDialog_SetOptions(This, fos) (This)->lpVtbl->SetOptions(This, fos)
	#define IFileSaveDialog_GetOptions(This, pfos) (This)->lpVtbl->GetOptions(This, pfos)
	#define IFileSaveDialog_SetDefaultFolder(This, psi) (This)->lpVtbl->SetDefaultFolder(This, psi)
	#define IFileSaveDialog_SetFolder(This, psi) (This)->lpVtbl->SetFolder(This, psi)
	#define IFileSaveDialog_GetFolder(This, ppsi) (This)->lpVtbl->GetFolder(This, ppsi)
	#define IFileSaveDialog_GetCurrentSelection(This, ppsi) (This)->lpVtbl->GetCurrentSelection(This, ppsi)
	#define IFileSaveDialog_SetFileName(This, pszName) (This)->lpVtbl->SetFileName(This, pszName)
	#define IFileSaveDialog_GetFileName(This, pszName) (This)->lpVtbl->GetFileName(This, pszName)
	#define IFileSaveDialog_SetTitle(This, pszTitle) (This)->lpVtbl->SetTitle(This, pszTitle)
	#define IFileSaveDialog_SetOkButtonLabel(This, pszText) (This)->lpVtbl->SetOkButtonLabel(This, pszText)
	#define IFileSaveDialog_SetFileNameLabel(This, pszLabel) (This)->lpVtbl->SetFileNameLabel(This, pszLabel)
	#define IFileSaveDialog_GetResult(This, ppsi) (This)->lpVtbl->GetResult(This, ppsi)
	#define IFileSaveDialog_AddPlace(This, psi, fdap) (This)->lpVtbl->AddPlace(This, psi, fdap)
	#define IFileSaveDialog_SetDefaultExtension(This, pszDefaultExtension) (This)->lpVtbl->SetDefaultExtension(This, pszDefaultExtension)
	#define IFileSaveDialog_Close(This, hr) (This)->lpVtbl->Close(This, hr)
	#define IFileSaveDialog_SetClientGuid(This, guid) (This)->lpVtbl->SetClientGuid(This, guid)
	#define IFileSaveDialog_ClearClientData(This) (This)->lpVtbl->ClearClientData(This)
	#define IFileSaveDialog_SetFilter(This, pFilter) (This)->lpVtbl->SetFilter(This, pFilter)
	#define IFileSaveDialog_SetSaveAsItem(This, psi) (This)->lpVtbl->SetSaveAsItem(This, psi)
	#define IFileSaveDialog_SetProperties(This, pStore) (This)->lpVtbl->SetProperties(This, pStore)
	#define IFileSaveDialog_SetCollectedProperties(This, pList, fAppendDefault) (This)->lpVtbl->SetCollectedProperties(This, pList, fAppendDefault)
	#define IFileSaveDialog_GetProperties(This, ppStore) (This)->lpVtbl->GetProperties(This, ppStore)
	#define IFileSaveDialog_ApplyProperties(This, psi, pStore, hwnd, pSink) (This)->lpVtbl->ApplyProperties(This, psi, pStore, hwnd, pSink)

	declare function IFileSaveDialog_SetSaveAsItem_Proxy(byval This as IFileSaveDialog ptr, byval psi as IShellItem ptr) as HRESULT
	declare sub IFileSaveDialog_SetSaveAsItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileSaveDialog_SetProperties_Proxy(byval This as IFileSaveDialog ptr, byval pStore as IPropertyStore ptr) as HRESULT
	declare sub IFileSaveDialog_SetProperties_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileSaveDialog_SetCollectedProperties_Proxy(byval This as IFileSaveDialog ptr, byval pList as IPropertyDescriptionList ptr, byval fAppendDefault as WINBOOL) as HRESULT
	declare sub IFileSaveDialog_SetCollectedProperties_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileSaveDialog_GetProperties_Proxy(byval This as IFileSaveDialog ptr, byval ppStore as IPropertyStore ptr ptr) as HRESULT
	declare sub IFileSaveDialog_GetProperties_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileSaveDialog_ApplyProperties_Proxy(byval This as IFileSaveDialog ptr, byval psi as IShellItem ptr, byval pStore as IPropertyStore ptr, byval hwnd as HWND, byval pSink as IFileOperationProgressSink ptr) as HRESULT
	declare sub IFileSaveDialog_ApplyProperties_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	#define __IFileOpenDialog_INTERFACE_DEFINED__
	extern IID_IFileOpenDialog as const GUID
	type IFileOpenDialog as IFileOpenDialog_

	type IFileOpenDialogVtbl
		QueryInterface as function(byval This as IFileOpenDialog ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IFileOpenDialog ptr) as ULONG
		Release as function(byval This as IFileOpenDialog ptr) as ULONG
		Show as function(byval This as IFileOpenDialog ptr, byval hwndOwner as HWND) as HRESULT
		SetFileTypes as function(byval This as IFileOpenDialog ptr, byval cFileTypes as UINT, byval rgFilterSpec as const COMDLG_FILTERSPEC ptr) as HRESULT
		SetFileTypeIndex as function(byval This as IFileOpenDialog ptr, byval iFileType as UINT) as HRESULT
		GetFileTypeIndex as function(byval This as IFileOpenDialog ptr, byval piFileType as UINT ptr) as HRESULT
		Advise as function(byval This as IFileOpenDialog ptr, byval pfde as IFileDialogEvents ptr, byval pdwCookie as DWORD ptr) as HRESULT
		Unadvise as function(byval This as IFileOpenDialog ptr, byval dwCookie as DWORD) as HRESULT
		SetOptions as function(byval This as IFileOpenDialog ptr, byval fos as FILEOPENDIALOGOPTIONS) as HRESULT
		GetOptions as function(byval This as IFileOpenDialog ptr, byval pfos as FILEOPENDIALOGOPTIONS ptr) as HRESULT
		SetDefaultFolder as function(byval This as IFileOpenDialog ptr, byval psi as IShellItem ptr) as HRESULT
		SetFolder as function(byval This as IFileOpenDialog ptr, byval psi as IShellItem ptr) as HRESULT
		GetFolder as function(byval This as IFileOpenDialog ptr, byval ppsi as IShellItem ptr ptr) as HRESULT
		GetCurrentSelection as function(byval This as IFileOpenDialog ptr, byval ppsi as IShellItem ptr ptr) as HRESULT
		SetFileName as function(byval This as IFileOpenDialog ptr, byval pszName as LPCWSTR) as HRESULT
		GetFileName as function(byval This as IFileOpenDialog ptr, byval pszName as LPWSTR ptr) as HRESULT
		SetTitle as function(byval This as IFileOpenDialog ptr, byval pszTitle as LPCWSTR) as HRESULT
		SetOkButtonLabel as function(byval This as IFileOpenDialog ptr, byval pszText as LPCWSTR) as HRESULT
		SetFileNameLabel as function(byval This as IFileOpenDialog ptr, byval pszLabel as LPCWSTR) as HRESULT
		GetResult as function(byval This as IFileOpenDialog ptr, byval ppsi as IShellItem ptr ptr) as HRESULT
		AddPlace as function(byval This as IFileOpenDialog ptr, byval psi as IShellItem ptr, byval fdap as FDAP) as HRESULT
		SetDefaultExtension as function(byval This as IFileOpenDialog ptr, byval pszDefaultExtension as LPCWSTR) as HRESULT
		Close as function(byval This as IFileOpenDialog ptr, byval hr as HRESULT) as HRESULT
		SetClientGuid as function(byval This as IFileOpenDialog ptr, byval guid as const GUID const ptr) as HRESULT
		ClearClientData as function(byval This as IFileOpenDialog ptr) as HRESULT
		SetFilter as function(byval This as IFileOpenDialog ptr, byval pFilter as IShellItemFilter ptr) as HRESULT
		GetResults as function(byval This as IFileOpenDialog ptr, byval ppenum as IShellItemArray ptr ptr) as HRESULT
		GetSelectedItems as function(byval This as IFileOpenDialog ptr, byval ppsai as IShellItemArray ptr ptr) as HRESULT
	end type

	type IFileOpenDialog_
		lpVtbl as IFileOpenDialogVtbl ptr
	end type

	#define IFileOpenDialog_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IFileOpenDialog_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IFileOpenDialog_Release(This) (This)->lpVtbl->Release(This)
	#define IFileOpenDialog_Show(This, hwndOwner) (This)->lpVtbl->Show(This, hwndOwner)
	#define IFileOpenDialog_SetFileTypes(This, cFileTypes, rgFilterSpec) (This)->lpVtbl->SetFileTypes(This, cFileTypes, rgFilterSpec)
	#define IFileOpenDialog_SetFileTypeIndex(This, iFileType) (This)->lpVtbl->SetFileTypeIndex(This, iFileType)
	#define IFileOpenDialog_GetFileTypeIndex(This, piFileType) (This)->lpVtbl->GetFileTypeIndex(This, piFileType)
	#define IFileOpenDialog_Advise(This, pfde, pdwCookie) (This)->lpVtbl->Advise(This, pfde, pdwCookie)
	#define IFileOpenDialog_Unadvise(This, dwCookie) (This)->lpVtbl->Unadvise(This, dwCookie)
	#define IFileOpenDialog_SetOptions(This, fos) (This)->lpVtbl->SetOptions(This, fos)
	#define IFileOpenDialog_GetOptions(This, pfos) (This)->lpVtbl->GetOptions(This, pfos)
	#define IFileOpenDialog_SetDefaultFolder(This, psi) (This)->lpVtbl->SetDefaultFolder(This, psi)
	#define IFileOpenDialog_SetFolder(This, psi) (This)->lpVtbl->SetFolder(This, psi)
	#define IFileOpenDialog_GetFolder(This, ppsi) (This)->lpVtbl->GetFolder(This, ppsi)
	#define IFileOpenDialog_GetCurrentSelection(This, ppsi) (This)->lpVtbl->GetCurrentSelection(This, ppsi)
	#define IFileOpenDialog_SetFileName(This, pszName) (This)->lpVtbl->SetFileName(This, pszName)
	#define IFileOpenDialog_GetFileName(This, pszName) (This)->lpVtbl->GetFileName(This, pszName)
	#define IFileOpenDialog_SetTitle(This, pszTitle) (This)->lpVtbl->SetTitle(This, pszTitle)
	#define IFileOpenDialog_SetOkButtonLabel(This, pszText) (This)->lpVtbl->SetOkButtonLabel(This, pszText)
	#define IFileOpenDialog_SetFileNameLabel(This, pszLabel) (This)->lpVtbl->SetFileNameLabel(This, pszLabel)
	#define IFileOpenDialog_GetResult(This, ppsi) (This)->lpVtbl->GetResult(This, ppsi)
	#define IFileOpenDialog_AddPlace(This, psi, fdap) (This)->lpVtbl->AddPlace(This, psi, fdap)
	#define IFileOpenDialog_SetDefaultExtension(This, pszDefaultExtension) (This)->lpVtbl->SetDefaultExtension(This, pszDefaultExtension)
	#define IFileOpenDialog_Close(This, hr) (This)->lpVtbl->Close(This, hr)
	#define IFileOpenDialog_SetClientGuid(This, guid) (This)->lpVtbl->SetClientGuid(This, guid)
	#define IFileOpenDialog_ClearClientData(This) (This)->lpVtbl->ClearClientData(This)
	#define IFileOpenDialog_SetFilter(This, pFilter) (This)->lpVtbl->SetFilter(This, pFilter)
	#define IFileOpenDialog_GetResults(This, ppenum) (This)->lpVtbl->GetResults(This, ppenum)
	#define IFileOpenDialog_GetSelectedItems(This, ppsai) (This)->lpVtbl->GetSelectedItems(This, ppsai)

	declare function IFileOpenDialog_GetResults_Proxy(byval This as IFileOpenDialog ptr, byval ppenum as IShellItemArray ptr ptr) as HRESULT
	declare sub IFileOpenDialog_GetResults_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileOpenDialog_GetSelectedItems_Proxy(byval This as IFileOpenDialog ptr, byval ppsai as IShellItemArray ptr ptr) as HRESULT
	declare sub IFileOpenDialog_GetSelectedItems_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

	type CDCONTROLSTATEF as long
	enum
		CDCS_INACTIVE = &h0
		CDCS_ENABLED = &h1
		CDCS_VISIBLE = &h2
		CDCS_ENABLEDVISIBLE = &h3
	end enum

	#define __IFileDialogCustomize_INTERFACE_DEFINED__
	extern IID_IFileDialogCustomize as const GUID
	type IFileDialogCustomize as IFileDialogCustomize_

	type IFileDialogCustomizeVtbl
		QueryInterface as function(byval This as IFileDialogCustomize ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IFileDialogCustomize ptr) as ULONG
		Release as function(byval This as IFileDialogCustomize ptr) as ULONG
		EnableOpenDropDown as function(byval This as IFileDialogCustomize ptr, byval dwIDCtl as DWORD) as HRESULT
		AddMenu as function(byval This as IFileDialogCustomize ptr, byval dwIDCtl as DWORD, byval pszLabel as LPCWSTR) as HRESULT
		AddPushButton as function(byval This as IFileDialogCustomize ptr, byval dwIDCtl as DWORD, byval pszLabel as LPCWSTR) as HRESULT
		AddComboBox as function(byval This as IFileDialogCustomize ptr, byval dwIDCtl as DWORD) as HRESULT
		AddRadioButtonList as function(byval This as IFileDialogCustomize ptr, byval dwIDCtl as DWORD) as HRESULT
		AddCheckButton as function(byval This as IFileDialogCustomize ptr, byval dwIDCtl as DWORD, byval pszLabel as LPCWSTR, byval bChecked as WINBOOL) as HRESULT
		AddEditBox as function(byval This as IFileDialogCustomize ptr, byval dwIDCtl as DWORD, byval pszText as LPCWSTR) as HRESULT
		AddSeparator as function(byval This as IFileDialogCustomize ptr, byval dwIDCtl as DWORD) as HRESULT
		AddText as function(byval This as IFileDialogCustomize ptr, byval dwIDCtl as DWORD, byval pszText as LPCWSTR) as HRESULT
		SetControlLabel as function(byval This as IFileDialogCustomize ptr, byval dwIDCtl as DWORD, byval pszLabel as LPCWSTR) as HRESULT
		GetControlState as function(byval This as IFileDialogCustomize ptr, byval dwIDCtl as DWORD, byval pdwState as CDCONTROLSTATEF ptr) as HRESULT
		SetControlState as function(byval This as IFileDialogCustomize ptr, byval dwIDCtl as DWORD, byval dwState as CDCONTROLSTATEF) as HRESULT
		GetEditBoxText as function(byval This as IFileDialogCustomize ptr, byval dwIDCtl as DWORD, byval ppszText as wstring ptr ptr) as HRESULT
		SetEditBoxText as function(byval This as IFileDialogCustomize ptr, byval dwIDCtl as DWORD, byval pszText as LPCWSTR) as HRESULT
		GetCheckButtonState as function(byval This as IFileDialogCustomize ptr, byval dwIDCtl as DWORD, byval pbChecked as WINBOOL ptr) as HRESULT
		SetCheckButtonState as function(byval This as IFileDialogCustomize ptr, byval dwIDCtl as DWORD, byval bChecked as WINBOOL) as HRESULT
		AddControlItem as function(byval This as IFileDialogCustomize ptr, byval dwIDCtl as DWORD, byval dwIDItem as DWORD, byval pszLabel as LPCWSTR) as HRESULT
		RemoveControlItem as function(byval This as IFileDialogCustomize ptr, byval dwIDCtl as DWORD, byval dwIDItem as DWORD) as HRESULT
		RemoveAllControlItems as function(byval This as IFileDialogCustomize ptr, byval dwIDCtl as DWORD) as HRESULT
		GetControlItemState as function(byval This as IFileDialogCustomize ptr, byval dwIDCtl as DWORD, byval dwIDItem as DWORD, byval pdwState as CDCONTROLSTATEF ptr) as HRESULT
		SetControlItemState as function(byval This as IFileDialogCustomize ptr, byval dwIDCtl as DWORD, byval dwIDItem as DWORD, byval dwState as CDCONTROLSTATEF) as HRESULT
		GetSelectedControlItem as function(byval This as IFileDialogCustomize ptr, byval dwIDCtl as DWORD, byval pdwIDItem as DWORD ptr) as HRESULT
		SetSelectedControlItem as function(byval This as IFileDialogCustomize ptr, byval dwIDCtl as DWORD, byval dwIDItem as DWORD) as HRESULT
		StartVisualGroup as function(byval This as IFileDialogCustomize ptr, byval dwIDCtl as DWORD, byval pszLabel as LPCWSTR) as HRESULT
		EndVisualGroup as function(byval This as IFileDialogCustomize ptr) as HRESULT
		MakeProminent as function(byval This as IFileDialogCustomize ptr, byval dwIDCtl as DWORD) as HRESULT
		SetControlItemText as function(byval This as IFileDialogCustomize ptr, byval dwIDCtl as DWORD, byval dwIDItem as DWORD, byval pszLabel as LPCWSTR) as HRESULT
	end type

	type IFileDialogCustomize_
		lpVtbl as IFileDialogCustomizeVtbl ptr
	end type

	#define IFileDialogCustomize_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IFileDialogCustomize_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IFileDialogCustomize_Release(This) (This)->lpVtbl->Release(This)
	#define IFileDialogCustomize_EnableOpenDropDown(This, dwIDCtl) (This)->lpVtbl->EnableOpenDropDown(This, dwIDCtl)
	#define IFileDialogCustomize_AddMenu(This, dwIDCtl, pszLabel) (This)->lpVtbl->AddMenu(This, dwIDCtl, pszLabel)
	#define IFileDialogCustomize_AddPushButton(This, dwIDCtl, pszLabel) (This)->lpVtbl->AddPushButton(This, dwIDCtl, pszLabel)
	#define IFileDialogCustomize_AddComboBox(This, dwIDCtl) (This)->lpVtbl->AddComboBox(This, dwIDCtl)
	#define IFileDialogCustomize_AddRadioButtonList(This, dwIDCtl) (This)->lpVtbl->AddRadioButtonList(This, dwIDCtl)
	#define IFileDialogCustomize_AddCheckButton(This, dwIDCtl, pszLabel, bChecked) (This)->lpVtbl->AddCheckButton(This, dwIDCtl, pszLabel, bChecked)
	#define IFileDialogCustomize_AddEditBox(This, dwIDCtl, pszText) (This)->lpVtbl->AddEditBox(This, dwIDCtl, pszText)
	#define IFileDialogCustomize_AddSeparator(This, dwIDCtl) (This)->lpVtbl->AddSeparator(This, dwIDCtl)
	#define IFileDialogCustomize_AddText(This, dwIDCtl, pszText) (This)->lpVtbl->AddText(This, dwIDCtl, pszText)
	#define IFileDialogCustomize_SetControlLabel(This, dwIDCtl, pszLabel) (This)->lpVtbl->SetControlLabel(This, dwIDCtl, pszLabel)
	#define IFileDialogCustomize_GetControlState(This, dwIDCtl, pdwState) (This)->lpVtbl->GetControlState(This, dwIDCtl, pdwState)
	#define IFileDialogCustomize_SetControlState(This, dwIDCtl, dwState) (This)->lpVtbl->SetControlState(This, dwIDCtl, dwState)
	#define IFileDialogCustomize_GetEditBoxText(This, dwIDCtl, ppszText) (This)->lpVtbl->GetEditBoxText(This, dwIDCtl, ppszText)
	#define IFileDialogCustomize_SetEditBoxText(This, dwIDCtl, pszText) (This)->lpVtbl->SetEditBoxText(This, dwIDCtl, pszText)
	#define IFileDialogCustomize_GetCheckButtonState(This, dwIDCtl, pbChecked) (This)->lpVtbl->GetCheckButtonState(This, dwIDCtl, pbChecked)
	#define IFileDialogCustomize_SetCheckButtonState(This, dwIDCtl, bChecked) (This)->lpVtbl->SetCheckButtonState(This, dwIDCtl, bChecked)
	#define IFileDialogCustomize_AddControlItem(This, dwIDCtl, dwIDItem, pszLabel) (This)->lpVtbl->AddControlItem(This, dwIDCtl, dwIDItem, pszLabel)
	#define IFileDialogCustomize_RemoveControlItem(This, dwIDCtl, dwIDItem) (This)->lpVtbl->RemoveControlItem(This, dwIDCtl, dwIDItem)
	#define IFileDialogCustomize_RemoveAllControlItems(This, dwIDCtl) (This)->lpVtbl->RemoveAllControlItems(This, dwIDCtl)
	#define IFileDialogCustomize_GetControlItemState(This, dwIDCtl, dwIDItem, pdwState) (This)->lpVtbl->GetControlItemState(This, dwIDCtl, dwIDItem, pdwState)
	#define IFileDialogCustomize_SetControlItemState(This, dwIDCtl, dwIDItem, dwState) (This)->lpVtbl->SetControlItemState(This, dwIDCtl, dwIDItem, dwState)
	#define IFileDialogCustomize_GetSelectedControlItem(This, dwIDCtl, pdwIDItem) (This)->lpVtbl->GetSelectedControlItem(This, dwIDCtl, pdwIDItem)
	#define IFileDialogCustomize_SetSelectedControlItem(This, dwIDCtl, dwIDItem) (This)->lpVtbl->SetSelectedControlItem(This, dwIDCtl, dwIDItem)
	#define IFileDialogCustomize_StartVisualGroup(This, dwIDCtl, pszLabel) (This)->lpVtbl->StartVisualGroup(This, dwIDCtl, pszLabel)
	#define IFileDialogCustomize_EndVisualGroup(This) (This)->lpVtbl->EndVisualGroup(This)
	#define IFileDialogCustomize_MakeProminent(This, dwIDCtl) (This)->lpVtbl->MakeProminent(This, dwIDCtl)
	#define IFileDialogCustomize_SetControlItemText(This, dwIDCtl, dwIDItem, pszLabel) (This)->lpVtbl->SetControlItemText(This, dwIDCtl, dwIDItem, pszLabel)

	declare function IFileDialogCustomize_EnableOpenDropDown_Proxy(byval This as IFileDialogCustomize ptr, byval dwIDCtl as DWORD) as HRESULT
	declare sub IFileDialogCustomize_EnableOpenDropDown_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialogCustomize_AddMenu_Proxy(byval This as IFileDialogCustomize ptr, byval dwIDCtl as DWORD, byval pszLabel as LPCWSTR) as HRESULT
	declare sub IFileDialogCustomize_AddMenu_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialogCustomize_AddPushButton_Proxy(byval This as IFileDialogCustomize ptr, byval dwIDCtl as DWORD, byval pszLabel as LPCWSTR) as HRESULT
	declare sub IFileDialogCustomize_AddPushButton_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialogCustomize_AddComboBox_Proxy(byval This as IFileDialogCustomize ptr, byval dwIDCtl as DWORD) as HRESULT
	declare sub IFileDialogCustomize_AddComboBox_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialogCustomize_AddRadioButtonList_Proxy(byval This as IFileDialogCustomize ptr, byval dwIDCtl as DWORD) as HRESULT
	declare sub IFileDialogCustomize_AddRadioButtonList_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialogCustomize_AddCheckButton_Proxy(byval This as IFileDialogCustomize ptr, byval dwIDCtl as DWORD, byval pszLabel as LPCWSTR, byval bChecked as WINBOOL) as HRESULT
	declare sub IFileDialogCustomize_AddCheckButton_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialogCustomize_AddEditBox_Proxy(byval This as IFileDialogCustomize ptr, byval dwIDCtl as DWORD, byval pszText as LPCWSTR) as HRESULT
	declare sub IFileDialogCustomize_AddEditBox_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialogCustomize_AddSeparator_Proxy(byval This as IFileDialogCustomize ptr, byval dwIDCtl as DWORD) as HRESULT
	declare sub IFileDialogCustomize_AddSeparator_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialogCustomize_AddText_Proxy(byval This as IFileDialogCustomize ptr, byval dwIDCtl as DWORD, byval pszText as LPCWSTR) as HRESULT
	declare sub IFileDialogCustomize_AddText_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialogCustomize_SetControlLabel_Proxy(byval This as IFileDialogCustomize ptr, byval dwIDCtl as DWORD, byval pszLabel as LPCWSTR) as HRESULT
	declare sub IFileDialogCustomize_SetControlLabel_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialogCustomize_GetControlState_Proxy(byval This as IFileDialogCustomize ptr, byval dwIDCtl as DWORD, byval pdwState as CDCONTROLSTATEF ptr) as HRESULT
	declare sub IFileDialogCustomize_GetControlState_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialogCustomize_SetControlState_Proxy(byval This as IFileDialogCustomize ptr, byval dwIDCtl as DWORD, byval dwState as CDCONTROLSTATEF) as HRESULT
	declare sub IFileDialogCustomize_SetControlState_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialogCustomize_GetEditBoxText_Proxy(byval This as IFileDialogCustomize ptr, byval dwIDCtl as DWORD, byval ppszText as wstring ptr ptr) as HRESULT
	declare sub IFileDialogCustomize_GetEditBoxText_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialogCustomize_SetEditBoxText_Proxy(byval This as IFileDialogCustomize ptr, byval dwIDCtl as DWORD, byval pszText as LPCWSTR) as HRESULT
	declare sub IFileDialogCustomize_SetEditBoxText_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialogCustomize_GetCheckButtonState_Proxy(byval This as IFileDialogCustomize ptr, byval dwIDCtl as DWORD, byval pbChecked as WINBOOL ptr) as HRESULT
	declare sub IFileDialogCustomize_GetCheckButtonState_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialogCustomize_SetCheckButtonState_Proxy(byval This as IFileDialogCustomize ptr, byval dwIDCtl as DWORD, byval bChecked as WINBOOL) as HRESULT
	declare sub IFileDialogCustomize_SetCheckButtonState_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialogCustomize_AddControlItem_Proxy(byval This as IFileDialogCustomize ptr, byval dwIDCtl as DWORD, byval dwIDItem as DWORD, byval pszLabel as LPCWSTR) as HRESULT
	declare sub IFileDialogCustomize_AddControlItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialogCustomize_RemoveControlItem_Proxy(byval This as IFileDialogCustomize ptr, byval dwIDCtl as DWORD, byval dwIDItem as DWORD) as HRESULT
	declare sub IFileDialogCustomize_RemoveControlItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialogCustomize_RemoveAllControlItems_Proxy(byval This as IFileDialogCustomize ptr, byval dwIDCtl as DWORD) as HRESULT
	declare sub IFileDialogCustomize_RemoveAllControlItems_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialogCustomize_GetControlItemState_Proxy(byval This as IFileDialogCustomize ptr, byval dwIDCtl as DWORD, byval dwIDItem as DWORD, byval pdwState as CDCONTROLSTATEF ptr) as HRESULT
	declare sub IFileDialogCustomize_GetControlItemState_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialogCustomize_SetControlItemState_Proxy(byval This as IFileDialogCustomize ptr, byval dwIDCtl as DWORD, byval dwIDItem as DWORD, byval dwState as CDCONTROLSTATEF) as HRESULT
	declare sub IFileDialogCustomize_SetControlItemState_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialogCustomize_GetSelectedControlItem_Proxy(byval This as IFileDialogCustomize ptr, byval dwIDCtl as DWORD, byval pdwIDItem as DWORD ptr) as HRESULT
	declare sub IFileDialogCustomize_GetSelectedControlItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialogCustomize_SetSelectedControlItem_Proxy(byval This as IFileDialogCustomize ptr, byval dwIDCtl as DWORD, byval dwIDItem as DWORD) as HRESULT
	declare sub IFileDialogCustomize_SetSelectedControlItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialogCustomize_StartVisualGroup_Proxy(byval This as IFileDialogCustomize ptr, byval dwIDCtl as DWORD, byval pszLabel as LPCWSTR) as HRESULT
	declare sub IFileDialogCustomize_StartVisualGroup_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialogCustomize_EndVisualGroup_Proxy(byval This as IFileDialogCustomize ptr) as HRESULT
	declare sub IFileDialogCustomize_EndVisualGroup_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialogCustomize_MakeProminent_Proxy(byval This as IFileDialogCustomize ptr, byval dwIDCtl as DWORD) as HRESULT
	declare sub IFileDialogCustomize_MakeProminent_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialogCustomize_SetControlItemText_Proxy(byval This as IFileDialogCustomize ptr, byval dwIDCtl as DWORD, byval dwIDItem as DWORD, byval pszLabel as LPCWSTR) as HRESULT
	declare sub IFileDialogCustomize_SetControlItemText_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	#define __IFileDialogControlEvents_INTERFACE_DEFINED__
	extern IID_IFileDialogControlEvents as const GUID
	type IFileDialogControlEvents as IFileDialogControlEvents_

	type IFileDialogControlEventsVtbl
		QueryInterface as function(byval This as IFileDialogControlEvents ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IFileDialogControlEvents ptr) as ULONG
		Release as function(byval This as IFileDialogControlEvents ptr) as ULONG
		OnItemSelected as function(byval This as IFileDialogControlEvents ptr, byval pfdc as IFileDialogCustomize ptr, byval dwIDCtl as DWORD, byval dwIDItem as DWORD) as HRESULT
		OnButtonClicked as function(byval This as IFileDialogControlEvents ptr, byval pfdc as IFileDialogCustomize ptr, byval dwIDCtl as DWORD) as HRESULT
		OnCheckButtonToggled as function(byval This as IFileDialogControlEvents ptr, byval pfdc as IFileDialogCustomize ptr, byval dwIDCtl as DWORD, byval bChecked as WINBOOL) as HRESULT
		OnControlActivating as function(byval This as IFileDialogControlEvents ptr, byval pfdc as IFileDialogCustomize ptr, byval dwIDCtl as DWORD) as HRESULT
	end type

	type IFileDialogControlEvents_
		lpVtbl as IFileDialogControlEventsVtbl ptr
	end type

	#define IFileDialogControlEvents_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IFileDialogControlEvents_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IFileDialogControlEvents_Release(This) (This)->lpVtbl->Release(This)
	#define IFileDialogControlEvents_OnItemSelected(This, pfdc, dwIDCtl, dwIDItem) (This)->lpVtbl->OnItemSelected(This, pfdc, dwIDCtl, dwIDItem)
	#define IFileDialogControlEvents_OnButtonClicked(This, pfdc, dwIDCtl) (This)->lpVtbl->OnButtonClicked(This, pfdc, dwIDCtl)
	#define IFileDialogControlEvents_OnCheckButtonToggled(This, pfdc, dwIDCtl, bChecked) (This)->lpVtbl->OnCheckButtonToggled(This, pfdc, dwIDCtl, bChecked)
	#define IFileDialogControlEvents_OnControlActivating(This, pfdc, dwIDCtl) (This)->lpVtbl->OnControlActivating(This, pfdc, dwIDCtl)

	declare function IFileDialogControlEvents_OnItemSelected_Proxy(byval This as IFileDialogControlEvents ptr, byval pfdc as IFileDialogCustomize ptr, byval dwIDCtl as DWORD, byval dwIDItem as DWORD) as HRESULT
	declare sub IFileDialogControlEvents_OnItemSelected_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialogControlEvents_OnButtonClicked_Proxy(byval This as IFileDialogControlEvents ptr, byval pfdc as IFileDialogCustomize ptr, byval dwIDCtl as DWORD) as HRESULT
	declare sub IFileDialogControlEvents_OnButtonClicked_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialogControlEvents_OnCheckButtonToggled_Proxy(byval This as IFileDialogControlEvents ptr, byval pfdc as IFileDialogCustomize ptr, byval dwIDCtl as DWORD, byval bChecked as WINBOOL) as HRESULT
	declare sub IFileDialogControlEvents_OnCheckButtonToggled_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialogControlEvents_OnControlActivating_Proxy(byval This as IFileDialogControlEvents ptr, byval pfdc as IFileDialogCustomize ptr, byval dwIDCtl as DWORD) as HRESULT
	declare sub IFileDialogControlEvents_OnControlActivating_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	#define __IFileDialog2_INTERFACE_DEFINED__
	extern IID_IFileDialog2 as const GUID
	type IFileDialog2 as IFileDialog2_

	type IFileDialog2Vtbl
		QueryInterface as function(byval This as IFileDialog2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IFileDialog2 ptr) as ULONG
		Release as function(byval This as IFileDialog2 ptr) as ULONG
		Show as function(byval This as IFileDialog2 ptr, byval hwndOwner as HWND) as HRESULT
		SetFileTypes as function(byval This as IFileDialog2 ptr, byval cFileTypes as UINT, byval rgFilterSpec as const COMDLG_FILTERSPEC ptr) as HRESULT
		SetFileTypeIndex as function(byval This as IFileDialog2 ptr, byval iFileType as UINT) as HRESULT
		GetFileTypeIndex as function(byval This as IFileDialog2 ptr, byval piFileType as UINT ptr) as HRESULT
		Advise as function(byval This as IFileDialog2 ptr, byval pfde as IFileDialogEvents ptr, byval pdwCookie as DWORD ptr) as HRESULT
		Unadvise as function(byval This as IFileDialog2 ptr, byval dwCookie as DWORD) as HRESULT
		SetOptions as function(byval This as IFileDialog2 ptr, byval fos as FILEOPENDIALOGOPTIONS) as HRESULT
		GetOptions as function(byval This as IFileDialog2 ptr, byval pfos as FILEOPENDIALOGOPTIONS ptr) as HRESULT
		SetDefaultFolder as function(byval This as IFileDialog2 ptr, byval psi as IShellItem ptr) as HRESULT
		SetFolder as function(byval This as IFileDialog2 ptr, byval psi as IShellItem ptr) as HRESULT
		GetFolder as function(byval This as IFileDialog2 ptr, byval ppsi as IShellItem ptr ptr) as HRESULT
		GetCurrentSelection as function(byval This as IFileDialog2 ptr, byval ppsi as IShellItem ptr ptr) as HRESULT
		SetFileName as function(byval This as IFileDialog2 ptr, byval pszName as LPCWSTR) as HRESULT
		GetFileName as function(byval This as IFileDialog2 ptr, byval pszName as LPWSTR ptr) as HRESULT
		SetTitle as function(byval This as IFileDialog2 ptr, byval pszTitle as LPCWSTR) as HRESULT
		SetOkButtonLabel as function(byval This as IFileDialog2 ptr, byval pszText as LPCWSTR) as HRESULT
		SetFileNameLabel as function(byval This as IFileDialog2 ptr, byval pszLabel as LPCWSTR) as HRESULT
		GetResult as function(byval This as IFileDialog2 ptr, byval ppsi as IShellItem ptr ptr) as HRESULT
		AddPlace as function(byval This as IFileDialog2 ptr, byval psi as IShellItem ptr, byval fdap as FDAP) as HRESULT
		SetDefaultExtension as function(byval This as IFileDialog2 ptr, byval pszDefaultExtension as LPCWSTR) as HRESULT
		Close as function(byval This as IFileDialog2 ptr, byval hr as HRESULT) as HRESULT
		SetClientGuid as function(byval This as IFileDialog2 ptr, byval guid as const GUID const ptr) as HRESULT
		ClearClientData as function(byval This as IFileDialog2 ptr) as HRESULT
		SetFilter as function(byval This as IFileDialog2 ptr, byval pFilter as IShellItemFilter ptr) as HRESULT
		SetCancelButtonLabel as function(byval This as IFileDialog2 ptr, byval pszLabel as LPCWSTR) as HRESULT
		SetNavigationRoot as function(byval This as IFileDialog2 ptr, byval psi as IShellItem ptr) as HRESULT
	end type

	type IFileDialog2_
		lpVtbl as IFileDialog2Vtbl ptr
	end type

	#define IFileDialog2_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IFileDialog2_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IFileDialog2_Release(This) (This)->lpVtbl->Release(This)
	#define IFileDialog2_Show(This, hwndOwner) (This)->lpVtbl->Show(This, hwndOwner)
	#define IFileDialog2_SetFileTypes(This, cFileTypes, rgFilterSpec) (This)->lpVtbl->SetFileTypes(This, cFileTypes, rgFilterSpec)
	#define IFileDialog2_SetFileTypeIndex(This, iFileType) (This)->lpVtbl->SetFileTypeIndex(This, iFileType)
	#define IFileDialog2_GetFileTypeIndex(This, piFileType) (This)->lpVtbl->GetFileTypeIndex(This, piFileType)
	#define IFileDialog2_Advise(This, pfde, pdwCookie) (This)->lpVtbl->Advise(This, pfde, pdwCookie)
	#define IFileDialog2_Unadvise(This, dwCookie) (This)->lpVtbl->Unadvise(This, dwCookie)
	#define IFileDialog2_SetOptions(This, fos) (This)->lpVtbl->SetOptions(This, fos)
	#define IFileDialog2_GetOptions(This, pfos) (This)->lpVtbl->GetOptions(This, pfos)
	#define IFileDialog2_SetDefaultFolder(This, psi) (This)->lpVtbl->SetDefaultFolder(This, psi)
	#define IFileDialog2_SetFolder(This, psi) (This)->lpVtbl->SetFolder(This, psi)
	#define IFileDialog2_GetFolder(This, ppsi) (This)->lpVtbl->GetFolder(This, ppsi)
	#define IFileDialog2_GetCurrentSelection(This, ppsi) (This)->lpVtbl->GetCurrentSelection(This, ppsi)
	#define IFileDialog2_SetFileName(This, pszName) (This)->lpVtbl->SetFileName(This, pszName)
	#define IFileDialog2_GetFileName(This, pszName) (This)->lpVtbl->GetFileName(This, pszName)
	#define IFileDialog2_SetTitle(This, pszTitle) (This)->lpVtbl->SetTitle(This, pszTitle)
	#define IFileDialog2_SetOkButtonLabel(This, pszText) (This)->lpVtbl->SetOkButtonLabel(This, pszText)
	#define IFileDialog2_SetFileNameLabel(This, pszLabel) (This)->lpVtbl->SetFileNameLabel(This, pszLabel)
	#define IFileDialog2_GetResult(This, ppsi) (This)->lpVtbl->GetResult(This, ppsi)
	#define IFileDialog2_AddPlace(This, psi, fdap) (This)->lpVtbl->AddPlace(This, psi, fdap)
	#define IFileDialog2_SetDefaultExtension(This, pszDefaultExtension) (This)->lpVtbl->SetDefaultExtension(This, pszDefaultExtension)
	#define IFileDialog2_Close(This, hr) (This)->lpVtbl->Close(This, hr)
	#define IFileDialog2_SetClientGuid(This, guid) (This)->lpVtbl->SetClientGuid(This, guid)
	#define IFileDialog2_ClearClientData(This) (This)->lpVtbl->ClearClientData(This)
	#define IFileDialog2_SetFilter(This, pFilter) (This)->lpVtbl->SetFilter(This, pFilter)
	#define IFileDialog2_SetCancelButtonLabel(This, pszLabel) (This)->lpVtbl->SetCancelButtonLabel(This, pszLabel)
	#define IFileDialog2_SetNavigationRoot(This, psi) (This)->lpVtbl->SetNavigationRoot(This, psi)

	declare function IFileDialog2_SetCancelButtonLabel_Proxy(byval This as IFileDialog2 ptr, byval pszLabel as LPCWSTR) as HRESULT
	declare sub IFileDialog2_SetCancelButtonLabel_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFileDialog2_SetNavigationRoot_Proxy(byval This as IFileDialog2 ptr, byval psi as IShellItem ptr) as HRESULT
	declare sub IFileDialog2_SetNavigationRoot_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

	type ASSOCIATIONLEVEL as long
	enum
		AL_MACHINE = 0
		AL_EFFECTIVE = 1
		AL_USER = 2
	end enum

	type ASSOCIATIONTYPE as long
	enum
		AT_FILEEXTENSION = 0
		AT_URLPROTOCOL = 1
		AT_STARTMENUCLIENT = 2
		AT_MIMETYPE = 3
	end enum

	#define __IApplicationAssociationRegistration_INTERFACE_DEFINED__
	extern IID_IApplicationAssociationRegistration as const GUID
	type IApplicationAssociationRegistration as IApplicationAssociationRegistration_

	type IApplicationAssociationRegistrationVtbl
		QueryInterface as function(byval This as IApplicationAssociationRegistration ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IApplicationAssociationRegistration ptr) as ULONG
		Release as function(byval This as IApplicationAssociationRegistration ptr) as ULONG
		QueryCurrentDefault as function(byval This as IApplicationAssociationRegistration ptr, byval pszQuery as LPCWSTR, byval atQueryType as ASSOCIATIONTYPE, byval alQueryLevel as ASSOCIATIONLEVEL, byval ppszAssociation as LPWSTR ptr) as HRESULT
		QueryAppIsDefault as function(byval This as IApplicationAssociationRegistration ptr, byval pszQuery as LPCWSTR, byval atQueryType as ASSOCIATIONTYPE, byval alQueryLevel as ASSOCIATIONLEVEL, byval pszAppRegistryName as LPCWSTR, byval pfDefault as WINBOOL ptr) as HRESULT
		QueryAppIsDefaultAll as function(byval This as IApplicationAssociationRegistration ptr, byval alQueryLevel as ASSOCIATIONLEVEL, byval pszAppRegistryName as LPCWSTR, byval pfDefault as WINBOOL ptr) as HRESULT
		SetAppAsDefault as function(byval This as IApplicationAssociationRegistration ptr, byval pszAppRegistryName as LPCWSTR, byval pszSet as LPCWSTR, byval atSetType as ASSOCIATIONTYPE) as HRESULT
		SetAppAsDefaultAll as function(byval This as IApplicationAssociationRegistration ptr, byval pszAppRegistryName as LPCWSTR) as HRESULT
		ClearUserAssociations as function(byval This as IApplicationAssociationRegistration ptr) as HRESULT
	end type

	type IApplicationAssociationRegistration_
		lpVtbl as IApplicationAssociationRegistrationVtbl ptr
	end type

	#define IApplicationAssociationRegistration_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IApplicationAssociationRegistration_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IApplicationAssociationRegistration_Release(This) (This)->lpVtbl->Release(This)
	#define IApplicationAssociationRegistration_QueryCurrentDefault(This, pszQuery, atQueryType, alQueryLevel, ppszAssociation) (This)->lpVtbl->QueryCurrentDefault(This, pszQuery, atQueryType, alQueryLevel, ppszAssociation)
	#define IApplicationAssociationRegistration_QueryAppIsDefault(This, pszQuery, atQueryType, alQueryLevel, pszAppRegistryName, pfDefault) (This)->lpVtbl->QueryAppIsDefault(This, pszQuery, atQueryType, alQueryLevel, pszAppRegistryName, pfDefault)
	#define IApplicationAssociationRegistration_QueryAppIsDefaultAll(This, alQueryLevel, pszAppRegistryName, pfDefault) (This)->lpVtbl->QueryAppIsDefaultAll(This, alQueryLevel, pszAppRegistryName, pfDefault)
	#define IApplicationAssociationRegistration_SetAppAsDefault(This, pszAppRegistryName, pszSet, atSetType) (This)->lpVtbl->SetAppAsDefault(This, pszAppRegistryName, pszSet, atSetType)
	#define IApplicationAssociationRegistration_SetAppAsDefaultAll(This, pszAppRegistryName) (This)->lpVtbl->SetAppAsDefaultAll(This, pszAppRegistryName)
	#define IApplicationAssociationRegistration_ClearUserAssociations(This) (This)->lpVtbl->ClearUserAssociations(This)

	declare function IApplicationAssociationRegistration_QueryCurrentDefault_Proxy(byval This as IApplicationAssociationRegistration ptr, byval pszQuery as LPCWSTR, byval atQueryType as ASSOCIATIONTYPE, byval alQueryLevel as ASSOCIATIONLEVEL, byval ppszAssociation as LPWSTR ptr) as HRESULT
	declare sub IApplicationAssociationRegistration_QueryCurrentDefault_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IApplicationAssociationRegistration_QueryAppIsDefault_Proxy(byval This as IApplicationAssociationRegistration ptr, byval pszQuery as LPCWSTR, byval atQueryType as ASSOCIATIONTYPE, byval alQueryLevel as ASSOCIATIONLEVEL, byval pszAppRegistryName as LPCWSTR, byval pfDefault as WINBOOL ptr) as HRESULT
	declare sub IApplicationAssociationRegistration_QueryAppIsDefault_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IApplicationAssociationRegistration_QueryAppIsDefaultAll_Proxy(byval This as IApplicationAssociationRegistration ptr, byval alQueryLevel as ASSOCIATIONLEVEL, byval pszAppRegistryName as LPCWSTR, byval pfDefault as WINBOOL ptr) as HRESULT
	declare sub IApplicationAssociationRegistration_QueryAppIsDefaultAll_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IApplicationAssociationRegistration_SetAppAsDefault_Proxy(byval This as IApplicationAssociationRegistration ptr, byval pszAppRegistryName as LPCWSTR, byval pszSet as LPCWSTR, byval atSetType as ASSOCIATIONTYPE) as HRESULT
	declare sub IApplicationAssociationRegistration_SetAppAsDefault_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IApplicationAssociationRegistration_SetAppAsDefaultAll_Proxy(byval This as IApplicationAssociationRegistration ptr, byval pszAppRegistryName as LPCWSTR) as HRESULT
	declare sub IApplicationAssociationRegistration_SetAppAsDefaultAll_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IApplicationAssociationRegistration_ClearUserAssociations_Proxy(byval This as IApplicationAssociationRegistration ptr) as HRESULT
	declare sub IApplicationAssociationRegistration_ClearUserAssociations_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function SHCreateAssociationRegistration(byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	#define __IApplicationAssociationRegistrationUI_INTERFACE_DEFINED__
	extern IID_IApplicationAssociationRegistrationUI as const GUID
	type IApplicationAssociationRegistrationUI as IApplicationAssociationRegistrationUI_

	type IApplicationAssociationRegistrationUIVtbl
		QueryInterface as function(byval This as IApplicationAssociationRegistrationUI ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IApplicationAssociationRegistrationUI ptr) as ULONG
		Release as function(byval This as IApplicationAssociationRegistrationUI ptr) as ULONG
		LaunchAdvancedAssociationUI as function(byval This as IApplicationAssociationRegistrationUI ptr, byval pszAppRegistryName as LPCWSTR) as HRESULT
	end type

	type IApplicationAssociationRegistrationUI_
		lpVtbl as IApplicationAssociationRegistrationUIVtbl ptr
	end type

	#define IApplicationAssociationRegistrationUI_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IApplicationAssociationRegistrationUI_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IApplicationAssociationRegistrationUI_Release(This) (This)->lpVtbl->Release(This)
	#define IApplicationAssociationRegistrationUI_LaunchAdvancedAssociationUI(This, pszAppRegistryName) (This)->lpVtbl->LaunchAdvancedAssociationUI(This, pszAppRegistryName)
	declare function IApplicationAssociationRegistrationUI_LaunchAdvancedAssociationUI_Proxy(byval This as IApplicationAssociationRegistrationUI ptr, byval pszAppRegistryName as LPCWSTR) as HRESULT
	declare sub IApplicationAssociationRegistrationUI_LaunchAdvancedAssociationUI_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#endif

type DELEGATEITEMID field = 1
	cbSize as WORD
	wOuter as WORD
	cbInner as WORD
	rgb_(0 to 0) as UBYTE
end type

type PCDELEGATEITEMID as const DELEGATEITEMID ptr
type PDELEGATEITEMID as DELEGATEITEMID ptr
#define __IDelegateFolder_INTERFACE_DEFINED__
extern IID_IDelegateFolder as const GUID
type IDelegateFolder as IDelegateFolder_

type IDelegateFolderVtbl
	QueryInterface as function(byval This as IDelegateFolder ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDelegateFolder ptr) as ULONG
	Release as function(byval This as IDelegateFolder ptr) as ULONG
	SetItemAlloc as function(byval This as IDelegateFolder ptr, byval pmalloc as IMalloc ptr) as HRESULT
end type

type IDelegateFolder_
	lpVtbl as IDelegateFolderVtbl ptr
end type

#define IDelegateFolder_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IDelegateFolder_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IDelegateFolder_Release(This) (This)->lpVtbl->Release(This)
#define IDelegateFolder_SetItemAlloc(This, pmalloc) (This)->lpVtbl->SetItemAlloc(This, pmalloc)
declare function IDelegateFolder_SetItemAlloc_Proxy(byval This as IDelegateFolder ptr, byval pmalloc as IMalloc ptr) as HRESULT
declare sub IDelegateFolder_SetItemAlloc_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#if _WIN32_WINNT >= &h0501
	#define __IBrowserFrameOptions_INTERFACE_DEFINED__
	type IBrowserFrameOptions as IBrowserFrameOptions_
	type LPBROWSERFRAMEOPTIONS as IBrowserFrameOptions ptr

	type _BROWSERFRAMEOPTIONS as long
	enum
		BFO_NONE = &h0
		BFO_BROWSER_PERSIST_SETTINGS = &h1
		BFO_RENAME_FOLDER_OPTIONS_TOINTERNET = &h2
		BFO_BOTH_OPTIONS = &h4
		BIF_PREFER_INTERNET_SHORTCUT = &h8
		BFO_BROWSE_NO_IN_NEW_PROCESS = &h10
		BFO_ENABLE_HYPERLINK_TRACKING = &h20
		BFO_USE_IE_OFFLINE_SUPPORT = &h40
		BFO_SUBSTITUE_INTERNET_START_PAGE = &h80
		BFO_USE_IE_LOGOBANDING = &h100
		BFO_ADD_IE_TOCAPTIONBAR = &h200
		BFO_USE_DIALUP_REF = &h400
		BFO_USE_IE_TOOLBAR = &h800
		BFO_NO_PARENT_FOLDER_SUPPORT = &h1000
		BFO_NO_REOPEN_NEXT_RESTART = &h2000
		BFO_GO_HOME_PAGE = &h4000
		BFO_PREFER_IEPROCESS = &h8000
		BFO_SHOW_NAVIGATION_CANCELLED = &h10000
		BFO_USE_IE_STATUSBAR = &h20000
		BFO_QUERY_ALL = clng(&hffffffff)
	end enum

	type BROWSERFRAMEOPTIONS as DWORD
	extern IID_IBrowserFrameOptions as const GUID

	type IBrowserFrameOptionsVtbl
		QueryInterface as function(byval This as IBrowserFrameOptions ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IBrowserFrameOptions ptr) as ULONG
		Release as function(byval This as IBrowserFrameOptions ptr) as ULONG
		GetFrameOptions as function(byval This as IBrowserFrameOptions ptr, byval dwMask as BROWSERFRAMEOPTIONS, byval pdwOptions as BROWSERFRAMEOPTIONS ptr) as HRESULT
	end type

	type IBrowserFrameOptions_
		lpVtbl as IBrowserFrameOptionsVtbl ptr
	end type

	#define IBrowserFrameOptions_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IBrowserFrameOptions_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IBrowserFrameOptions_Release(This) (This)->lpVtbl->Release(This)
	#define IBrowserFrameOptions_GetFrameOptions(This, dwMask, pdwOptions) (This)->lpVtbl->GetFrameOptions(This, dwMask, pdwOptions)
	declare function IBrowserFrameOptions_GetFrameOptions_Proxy(byval This as IBrowserFrameOptions ptr, byval dwMask as BROWSERFRAMEOPTIONS, byval pdwOptions as BROWSERFRAMEOPTIONS ptr) as HRESULT
	declare sub IBrowserFrameOptions_GetFrameOptions_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#endif

#if _WIN32_WINNT >= &h0600
	type NWMF as long
	enum
		NWMF_UNLOADING = &h1
		NWMF_USERINITED = &h2
		NWMF_FIRST = &h4
		NWMF_OVERRIDEKEY = &h8
		NWMF_SHOWHELP = &h10
		NWMF_HTMLDIALOG = &h20
		NWMF_FROMDIALOGCHILD = &h40
		NWMF_USERREQUESTED = &h80
		NWMF_USERALLOWED = &h100
		NWMF_FORCEWINDOW = &h10000
		NWMF_FORCETAB = &h20000
		NWMF_SUGGESTWINDOW = &h40000
		NWMF_SUGGESTTAB = &h80000
		NWMF_INACTIVETAB = &h100000
	end enum

	#define __INewWindowManager_INTERFACE_DEFINED__
	extern IID_INewWindowManager as const GUID
	extern SID_SNewWindowManager alias "IID_INewWindowManager" as const GUID
	type INewWindowManager as INewWindowManager_

	type INewWindowManagerVtbl
		QueryInterface as function(byval This as INewWindowManager ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as INewWindowManager ptr) as ULONG
		Release as function(byval This as INewWindowManager ptr) as ULONG
		EvaluateNewWindow as function(byval This as INewWindowManager ptr, byval pszUrl as LPCWSTR, byval pszName as LPCWSTR, byval pszUrlContext as LPCWSTR, byval pszFeatures as LPCWSTR, byval fReplace as WINBOOL, byval dwFlags as DWORD, byval dwUserActionTime as DWORD) as HRESULT
	end type

	type INewWindowManager_
		lpVtbl as INewWindowManagerVtbl ptr
	end type

	#define INewWindowManager_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define INewWindowManager_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define INewWindowManager_Release(This) (This)->lpVtbl->Release(This)
	#define INewWindowManager_EvaluateNewWindow(This, pszUrl, pszName, pszUrlContext, pszFeatures, fReplace, dwFlags, dwUserActionTime) (This)->lpVtbl->EvaluateNewWindow(This, pszUrl, pszName, pszUrlContext, pszFeatures, fReplace, dwFlags, dwUserActionTime)
	declare function INewWindowManager_EvaluateNewWindow_Proxy(byval This as INewWindowManager ptr, byval pszUrl as LPCWSTR, byval pszName as LPCWSTR, byval pszUrlContext as LPCWSTR, byval pszFeatures as LPCWSTR, byval fReplace as WINBOOL, byval dwFlags as DWORD, byval dwUserActionTime as DWORD) as HRESULT
	declare sub INewWindowManager_EvaluateNewWindow_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	#define __IAttachmentExecute_INTERFACE_DEFINED__

	type ATTACHMENT_PROMPT as long
	enum
		ATTACHMENT_PROMPT_NONE = &h0
		ATTACHMENT_PROMPT_SAVE = &h1
		ATTACHMENT_PROMPT_EXEC = &h2
		ATTACHMENT_PROMPT_EXEC_OR_SAVE = &h3
	end enum

	type ATTACHMENT_ACTION as long
	enum
		ATTACHMENT_ACTION_CANCEL = &h0
		ATTACHMENT_ACTION_SAVE = &h1
		ATTACHMENT_ACTION_EXEC = &h2
	end enum

	extern IID_IAttachmentExecute as const GUID
	type IAttachmentExecute as IAttachmentExecute_

	type IAttachmentExecuteVtbl
		QueryInterface as function(byval This as IAttachmentExecute ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IAttachmentExecute ptr) as ULONG
		Release as function(byval This as IAttachmentExecute ptr) as ULONG
		SetClientTitle as function(byval This as IAttachmentExecute ptr, byval pszTitle as LPCWSTR) as HRESULT
		SetClientGuid as function(byval This as IAttachmentExecute ptr, byval guid as const GUID const ptr) as HRESULT
		SetLocalPath as function(byval This as IAttachmentExecute ptr, byval pszLocalPath as LPCWSTR) as HRESULT
		SetFileName as function(byval This as IAttachmentExecute ptr, byval pszFileName as LPCWSTR) as HRESULT
		SetSource as function(byval This as IAttachmentExecute ptr, byval pszSource as LPCWSTR) as HRESULT
		SetReferrer as function(byval This as IAttachmentExecute ptr, byval pszReferrer as LPCWSTR) as HRESULT
		CheckPolicy as function(byval This as IAttachmentExecute ptr) as HRESULT
		Prompt as function(byval This as IAttachmentExecute ptr, byval hwnd as HWND, byval prompt as ATTACHMENT_PROMPT, byval paction as ATTACHMENT_ACTION ptr) as HRESULT
		Save as function(byval This as IAttachmentExecute ptr) as HRESULT
		Execute as function(byval This as IAttachmentExecute ptr, byval hwnd as HWND, byval pszVerb as LPCWSTR, byval phProcess as HANDLE ptr) as HRESULT
		SaveWithUI as function(byval This as IAttachmentExecute ptr, byval hwnd as HWND) as HRESULT
		ClearClientState as function(byval This as IAttachmentExecute ptr) as HRESULT
	end type

	type IAttachmentExecute_
		lpVtbl as IAttachmentExecuteVtbl ptr
	end type

	#define IAttachmentExecute_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IAttachmentExecute_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IAttachmentExecute_Release(This) (This)->lpVtbl->Release(This)
	#define IAttachmentExecute_SetClientTitle(This, pszTitle) (This)->lpVtbl->SetClientTitle(This, pszTitle)
	#define IAttachmentExecute_SetClientGuid(This, guid) (This)->lpVtbl->SetClientGuid(This, guid)
	#define IAttachmentExecute_SetLocalPath(This, pszLocalPath) (This)->lpVtbl->SetLocalPath(This, pszLocalPath)
	#define IAttachmentExecute_SetFileName(This, pszFileName) (This)->lpVtbl->SetFileName(This, pszFileName)
	#define IAttachmentExecute_SetSource(This, pszSource) (This)->lpVtbl->SetSource(This, pszSource)
	#define IAttachmentExecute_SetReferrer(This, pszReferrer) (This)->lpVtbl->SetReferrer(This, pszReferrer)
	#define IAttachmentExecute_CheckPolicy(This) (This)->lpVtbl->CheckPolicy(This)
	#define IAttachmentExecute_Prompt(This, hwnd, prompt, paction) (This)->lpVtbl->Prompt(This, hwnd, prompt, paction)
	#define IAttachmentExecute_Save(This) (This)->lpVtbl->Save(This)
	#define IAttachmentExecute_Execute(This, hwnd, pszVerb, phProcess) (This)->lpVtbl->Execute(This, hwnd, pszVerb, phProcess)
	#define IAttachmentExecute_SaveWithUI(This, hwnd) (This)->lpVtbl->SaveWithUI(This, hwnd)
	#define IAttachmentExecute_ClearClientState(This) (This)->lpVtbl->ClearClientState(This)

	declare function IAttachmentExecute_SetClientTitle_Proxy(byval This as IAttachmentExecute ptr, byval pszTitle as LPCWSTR) as HRESULT
	declare sub IAttachmentExecute_SetClientTitle_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IAttachmentExecute_SetClientGuid_Proxy(byval This as IAttachmentExecute ptr, byval guid as const GUID const ptr) as HRESULT
	declare sub IAttachmentExecute_SetClientGuid_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IAttachmentExecute_SetLocalPath_Proxy(byval This as IAttachmentExecute ptr, byval pszLocalPath as LPCWSTR) as HRESULT
	declare sub IAttachmentExecute_SetLocalPath_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IAttachmentExecute_SetFileName_Proxy(byval This as IAttachmentExecute ptr, byval pszFileName as LPCWSTR) as HRESULT
	declare sub IAttachmentExecute_SetFileName_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IAttachmentExecute_SetSource_Proxy(byval This as IAttachmentExecute ptr, byval pszSource as LPCWSTR) as HRESULT
	declare sub IAttachmentExecute_SetSource_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IAttachmentExecute_SetReferrer_Proxy(byval This as IAttachmentExecute ptr, byval pszReferrer as LPCWSTR) as HRESULT
	declare sub IAttachmentExecute_SetReferrer_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IAttachmentExecute_CheckPolicy_Proxy(byval This as IAttachmentExecute ptr) as HRESULT
	declare sub IAttachmentExecute_CheckPolicy_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IAttachmentExecute_Prompt_Proxy(byval This as IAttachmentExecute ptr, byval hwnd as HWND, byval prompt as ATTACHMENT_PROMPT, byval paction as ATTACHMENT_ACTION ptr) as HRESULT
	declare sub IAttachmentExecute_Prompt_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IAttachmentExecute_Save_Proxy(byval This as IAttachmentExecute ptr) as HRESULT
	declare sub IAttachmentExecute_Save_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IAttachmentExecute_Execute_Proxy(byval This as IAttachmentExecute ptr, byval hwnd as HWND, byval pszVerb as LPCWSTR, byval phProcess as HANDLE ptr) as HRESULT
	declare sub IAttachmentExecute_Execute_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IAttachmentExecute_SaveWithUI_Proxy(byval This as IAttachmentExecute ptr, byval hwnd as HWND) as HRESULT
	declare sub IAttachmentExecute_SaveWithUI_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IAttachmentExecute_ClearClientState_Proxy(byval This as IAttachmentExecute ptr) as HRESULT
	declare sub IAttachmentExecute_ClearClientState_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#endif

#if _WIN32_WINNT >= &h0501
	type tagSMDATA
		dwMask as DWORD
		dwFlags as DWORD
		hmenu as HMENU
		hwnd as HWND
		uId as UINT
		uIdParent as UINT
		uIdAncestor as UINT
		punk as IUnknown ptr
		pidlFolder as LPITEMIDLIST
		pidlItem as LPITEMIDLIST
		psf as IShellFolder ptr
		pvUserData as any ptr
	end type

	type SMDATA as tagSMDATA
	type LPSMDATA as tagSMDATA ptr
	const SMDM_SHELLFOLDER = &h00000001
	const SMDM_HMENU = &h00000002
	const SMDM_TOOLBAR = &h00000004

	type tagSMINFO
		dwMask as DWORD
		dwType as DWORD
		dwFlags as DWORD
		iIcon as long
	end type

	type SMINFO as tagSMINFO
	type PSMINFO as tagSMINFO ptr

	type SHCSCHANGENOTIFYSTRUCT
		lEvent as LONG
		pidl1 as LPCITEMIDLIST
		pidl2 as LPCITEMIDLIST
	end type

	type SMCSHCHANGENOTIFYSTRUCT as SHCSCHANGENOTIFYSTRUCT
	type PSMCSHCHANGENOTIFYSTRUCT as SHCSCHANGENOTIFYSTRUCT ptr

	type tagSMINFOMASK as long
	enum
		SMIM_TYPE = &h1
		SMIM_FLAGS = &h2
		SMIM_ICON = &h4
	end enum

	type tagSMINFOTYPE as long
	enum
		SMIT_SEPARATOR = &h1
		SMIT_STRING = &h2
	end enum

	type tagSMINFOFLAGS as long
	enum
		SMIF_ICON = &h1
		SMIF_ACCELERATOR = &h2
		SMIF_DROPTARGET = &h4
		SMIF_SUBMENU = &h8
		SMIF_CHECKED = &h20
		SMIF_DROPCASCADE = &h40
		SMIF_HIDDEN = &h80
		SMIF_DISABLED = &h100
		SMIF_TRACKPOPUP = &h200
		SMIF_DEMOTED = &h400
		SMIF_ALTSTATE = &h800
		SMIF_DRAGNDROP = &h1000
		SMIF_NEW = &h2000
	end enum

	const SMC_INITMENU = &h00000001
	const SMC_CREATE = &h00000002
	const SMC_EXITMENU = &h00000003
	const SMC_GETINFO = &h00000005
	const SMC_GETSFINFO = &h00000006
	const SMC_GETOBJECT = &h00000007
	const SMC_GETSFOBJECT = &h00000008
	const SMC_SFEXEC = &h00000009
	const SMC_SFSELECTITEM = &h0000000A
	const SMC_REFRESH = &h00000010
	const SMC_DEMOTE = &h00000011
	const SMC_PROMOTE = &h00000012
	const SMC_DEFAULTICON = &h00000016
	const SMC_NEWITEM = &h00000017
	const SMC_CHEVRONEXPAND = &h00000019
	const SMC_DISPLAYCHEVRONTIP = &h0000002A
	const SMC_SETSFOBJECT = &h0000002D
	const SMC_SHCHANGENOTIFY = &h0000002E
	const SMC_CHEVRONGETTIP = &h0000002F
	const SMC_SFDDRESTRICTED = &h00000030
#endif

#if _WIN32_WINNT >= &h0600
	const SMC_SFEXEC_MIDDLE = &h00000031
	const SMC_GETAUTOEXPANDSTATE = &h00000041
	const SMC_AUTOEXPANDCHANGE = &h00000042
	const SMC_GETCONTEXTMENUMODIFIER = &h00000043
	const SMC_GETBKCONTEXTMENU = &h00000044
	const SMC_OPEN = &h00000045
	const SMAE_EXPANDED = &h00000001
	const SMAE_CONTRACTED = &h00000002
	const SMAE_USER = &h00000004
	const SMAE_VALID = &h00000007
#endif

#if _WIN32_WINNT >= &h0501
	#define __IShellMenuCallback_INTERFACE_DEFINED__
	extern IID_IShellMenuCallback as const GUID
	type IShellMenuCallback as IShellMenuCallback_

	type IShellMenuCallbackVtbl
		QueryInterface as function(byval This as IShellMenuCallback ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IShellMenuCallback ptr) as ULONG
		Release as function(byval This as IShellMenuCallback ptr) as ULONG
		CallbackSM as function(byval This as IShellMenuCallback ptr, byval psmd as LPSMDATA, byval uMsg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as HRESULT
	end type

	type IShellMenuCallback_
		lpVtbl as IShellMenuCallbackVtbl ptr
	end type

	#define IShellMenuCallback_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IShellMenuCallback_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IShellMenuCallback_Release(This) (This)->lpVtbl->Release(This)
	#define IShellMenuCallback_CallbackSM(This, psmd, uMsg, wParam, lParam) (This)->lpVtbl->CallbackSM(This, psmd, uMsg, wParam, lParam)
	declare function IShellMenuCallback_CallbackSM_Proxy(byval This as IShellMenuCallback ptr, byval psmd as LPSMDATA, byval uMsg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as HRESULT
	declare sub IShellMenuCallback_CallbackSM_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	const SMINIT_DEFAULT = &h00000000
	const SMINIT_RESTRICT_DRAGDROP = &h00000002
	const SMINIT_TOPLEVEL = &h00000004
	const SMINIT_CACHED = &h00000010
#endif

#if _WIN32_WINNT >= &h0600
	const SMINIT_AUTOEXPAND = &h00000100
	const SMINIT_AUTOTOOLTIP = &h00000200
	const SMINIT_DROPONCONTAINER = &h00000400
#endif

#if _WIN32_WINNT >= &h0501
	const SMINIT_VERTICAL = &h10000000
	const SMINIT_HORIZONTAL = &h20000000
	const ANCESTORDEFAULT = cast(UINT, -1)
	const SMSET_TOP = &h10000000
	const SMSET_BOTTOM = &h20000000
	const SMSET_DONTOWN = &h00000001
	const SMINV_REFRESH = &h00000001
	const SMINV_ID = &h00000008
	#define __IShellMenu_INTERFACE_DEFINED__
	extern IID_IShellMenu as const GUID
	type IShellMenu as IShellMenu_

	type IShellMenuVtbl
		QueryInterface as function(byval This as IShellMenu ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IShellMenu ptr) as ULONG
		Release as function(byval This as IShellMenu ptr) as ULONG
		Initialize as function(byval This as IShellMenu ptr, byval psmc as IShellMenuCallback ptr, byval uId as UINT, byval uIdAncestor as UINT, byval dwFlags as DWORD) as HRESULT
		GetMenuInfo as function(byval This as IShellMenu ptr, byval ppsmc as IShellMenuCallback ptr ptr, byval puId as UINT ptr, byval puIdAncestor as UINT ptr, byval pdwFlags as DWORD ptr) as HRESULT
		SetShellFolder as function(byval This as IShellMenu ptr, byval psf as IShellFolder ptr, byval pidlFolder as LPCITEMIDLIST, byval hKey as HKEY, byval dwFlags as DWORD) as HRESULT
		GetShellFolder as function(byval This as IShellMenu ptr, byval pdwFlags as DWORD ptr, byval ppidl as LPITEMIDLIST ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
		SetMenu as function(byval This as IShellMenu ptr, byval hmenu as HMENU, byval hwnd as HWND, byval dwFlags as DWORD) as HRESULT
		GetMenu as function(byval This as IShellMenu ptr, byval phmenu as HMENU ptr, byval phwnd as HWND ptr, byval pdwFlags as DWORD ptr) as HRESULT
		InvalidateItem as function(byval This as IShellMenu ptr, byval psmd as LPSMDATA, byval dwFlags as DWORD) as HRESULT
		GetState as function(byval This as IShellMenu ptr, byval psmd as LPSMDATA) as HRESULT
		SetMenuToolbar as function(byval This as IShellMenu ptr, byval punk as IUnknown ptr, byval dwFlags as DWORD) as HRESULT
	end type

	type IShellMenu_
		lpVtbl as IShellMenuVtbl ptr
	end type

	#define IShellMenu_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IShellMenu_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IShellMenu_Release(This) (This)->lpVtbl->Release(This)
	#define IShellMenu_Initialize(This, psmc, uId, uIdAncestor, dwFlags) (This)->lpVtbl->Initialize(This, psmc, uId, uIdAncestor, dwFlags)
	#define IShellMenu_GetMenuInfo(This, ppsmc, puId, puIdAncestor, pdwFlags) (This)->lpVtbl->GetMenuInfo(This, ppsmc, puId, puIdAncestor, pdwFlags)
	#define IShellMenu_SetShellFolder(This, psf, pidlFolder, hKey, dwFlags) (This)->lpVtbl->SetShellFolder(This, psf, pidlFolder, hKey, dwFlags)
	#define IShellMenu_GetShellFolder(This, pdwFlags, ppidl, riid, ppv) (This)->lpVtbl->GetShellFolder(This, pdwFlags, ppidl, riid, ppv)
	#define IShellMenu_SetMenu(This, hmenu, hwnd, dwFlags) (This)->lpVtbl->SetMenu(This, hmenu, hwnd, dwFlags)
	#define IShellMenu_GetMenu(This, phmenu, phwnd, pdwFlags) (This)->lpVtbl->GetMenu(This, phmenu, phwnd, pdwFlags)
	#define IShellMenu_InvalidateItem(This, psmd, dwFlags) (This)->lpVtbl->InvalidateItem(This, psmd, dwFlags)
	#define IShellMenu_GetState(This, psmd) (This)->lpVtbl->GetState(This, psmd)
	#define IShellMenu_SetMenuToolbar(This, punk, dwFlags) (This)->lpVtbl->SetMenuToolbar(This, punk, dwFlags)

	declare function IShellMenu_Initialize_Proxy(byval This as IShellMenu ptr, byval psmc as IShellMenuCallback ptr, byval uId as UINT, byval uIdAncestor as UINT, byval dwFlags as DWORD) as HRESULT
	declare sub IShellMenu_Initialize_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IShellMenu_GetMenuInfo_Proxy(byval This as IShellMenu ptr, byval ppsmc as IShellMenuCallback ptr ptr, byval puId as UINT ptr, byval puIdAncestor as UINT ptr, byval pdwFlags as DWORD ptr) as HRESULT
	declare sub IShellMenu_GetMenuInfo_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IShellMenu_SetShellFolder_Proxy(byval This as IShellMenu ptr, byval psf as IShellFolder ptr, byval pidlFolder as LPCITEMIDLIST, byval hKey as HKEY, byval dwFlags as DWORD) as HRESULT
	declare sub IShellMenu_SetShellFolder_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IShellMenu_GetShellFolder_Proxy(byval This as IShellMenu ptr, byval pdwFlags as DWORD ptr, byval ppidl as LPITEMIDLIST ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	declare sub IShellMenu_GetShellFolder_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IShellMenu_SetMenu_Proxy(byval This as IShellMenu ptr, byval hmenu as HMENU, byval hwnd as HWND, byval dwFlags as DWORD) as HRESULT
	declare sub IShellMenu_SetMenu_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IShellMenu_GetMenu_Proxy(byval This as IShellMenu ptr, byval phmenu as HMENU ptr, byval phwnd as HWND ptr, byval pdwFlags as DWORD ptr) as HRESULT
	declare sub IShellMenu_GetMenu_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IShellMenu_InvalidateItem_Proxy(byval This as IShellMenu ptr, byval psmd as LPSMDATA, byval dwFlags as DWORD) as HRESULT
	declare sub IShellMenu_InvalidateItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IShellMenu_GetState_Proxy(byval This as IShellMenu ptr, byval psmd as LPSMDATA) as HRESULT
	declare sub IShellMenu_GetState_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IShellMenu_SetMenuToolbar_Proxy(byval This as IShellMenu ptr, byval punk as IUnknown ptr, byval dwFlags as DWORD) as HRESULT
	declare sub IShellMenu_SetMenuToolbar_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#endif

#define __IShellRunDll_INTERFACE_DEFINED__
extern IID_IShellRunDll as const GUID
type IShellRunDll as IShellRunDll_

type IShellRunDllVtbl
	QueryInterface as function(byval This as IShellRunDll ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IShellRunDll ptr) as ULONG
	Release as function(byval This as IShellRunDll ptr) as ULONG
	Run as function(byval This as IShellRunDll ptr, byval pszArgs as LPCWSTR) as HRESULT
end type

type IShellRunDll_
	lpVtbl as IShellRunDllVtbl ptr
end type

#define IShellRunDll_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IShellRunDll_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IShellRunDll_Release(This) (This)->lpVtbl->Release(This)
#define IShellRunDll_Run(This, pszArgs) (This)->lpVtbl->Run(This, pszArgs)
declare function IShellRunDll_Run_Proxy(byval This as IShellRunDll ptr, byval pszArgs as LPCWSTR) as HRESULT
declare sub IShellRunDll_Run_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#if _WIN32_WINNT >= &h0600
	type KF_CATEGORY as long
	enum
		KF_CATEGORY_VIRTUAL = 1
		KF_CATEGORY_FIXED = 2
		KF_CATEGORY_COMMON = 3
		KF_CATEGORY_PERUSER = 4
	end enum

	type _KF_DEFINITION_FLAGS as long
	enum
		KFDF_LOCAL_REDIRECT_ONLY = &h2
		KFDF_ROAMABLE = &h4
		KFDF_PRECREATE = &h8
		KFDF_STREAM = &h10
		KFDF_PUBLISHEXPANDEDPATH = &h20
	end enum

	type KF_DEFINITION_FLAGS as DWORD

	type _KF_REDIRECT_FLAGS as long
	enum
		KF_REDIRECT_USER_EXCLUSIVE = &h1
		KF_REDIRECT_COPY_SOURCE_DACL = &h2
		KF_REDIRECT_OWNER_USER = &h4
		KF_REDIRECT_SET_OWNER_EXPLICIT = &h8
		KF_REDIRECT_CHECK_ONLY = &h10
		KF_REDIRECT_WITH_UI = &h20
		KF_REDIRECT_UNPIN = &h40
		KF_REDIRECT_PIN = &h80
		KF_REDIRECT_COPY_CONTENTS = &h200
		KF_REDIRECT_DEL_SOURCE_CONTENTS = &h400
		KF_REDIRECT_EXCLUDE_ALL_KNOWN_SUBFOLDERS = &h800
	end enum

	type KF_REDIRECT_FLAGS as DWORD

	type _KF_REDIRECTION_CAPABILITIES as long
	enum
		KF_REDIRECTION_CAPABILITIES_ALLOW_ALL = &hff
		KF_REDIRECTION_CAPABILITIES_REDIRECTABLE = &h1
		KF_REDIRECTION_CAPABILITIES_DENY_ALL = &hfff00
		KF_REDIRECTION_CAPABILITIES_DENY_POLICY_REDIRECTED = &h100
		KF_REDIRECTION_CAPABILITIES_DENY_POLICY = &h200
		KF_REDIRECTION_CAPABILITIES_DENY_PERMISSIONS = &h400
	end enum

	type KF_REDIRECTION_CAPABILITIES as DWORD

	type KNOWNFOLDER_DEFINITION
		category as KF_CATEGORY
		pszName as LPWSTR
		pszDescription as LPWSTR
		fidParent as KNOWNFOLDERID
		pszRelativePath as LPWSTR
		pszParsingName as LPWSTR
		pszTooltip as LPWSTR
		pszLocalizedName as LPWSTR
		pszIcon as LPWSTR
		pszSecurity as LPWSTR
		dwAttributes as DWORD
		kfdFlags as KF_DEFINITION_FLAGS
		ftidType as FOLDERTYPEID
	end type

	#define __IKnownFolder_INTERFACE_DEFINED__
	extern IID_IKnownFolder as const GUID
	type IKnownFolder as IKnownFolder_

	type IKnownFolderVtbl
		QueryInterface as function(byval This as IKnownFolder ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IKnownFolder ptr) as ULONG
		Release as function(byval This as IKnownFolder ptr) as ULONG
		GetId as function(byval This as IKnownFolder ptr, byval pkfid as KNOWNFOLDERID ptr) as HRESULT
		GetCategory as function(byval This as IKnownFolder ptr, byval pCategory as KF_CATEGORY ptr) as HRESULT
		GetShellItem as function(byval This as IKnownFolder ptr, byval dwFlags as DWORD, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
		GetPath as function(byval This as IKnownFolder ptr, byval dwFlags as DWORD, byval ppszPath as LPWSTR ptr) as HRESULT
		SetPath as function(byval This as IKnownFolder ptr, byval dwFlags as DWORD, byval pszPath as LPCWSTR) as HRESULT
		GetIDList as function(byval This as IKnownFolder ptr, byval dwFlags as DWORD, byval ppidl as LPITEMIDLIST ptr) as HRESULT
		GetFolderType as function(byval This as IKnownFolder ptr, byval pftid as FOLDERTYPEID ptr) as HRESULT
		GetRedirectionCapabilities as function(byval This as IKnownFolder ptr, byval pCapabilities as KF_REDIRECTION_CAPABILITIES ptr) as HRESULT
		GetFolderDefinition as function(byval This as IKnownFolder ptr, byval pKFD as KNOWNFOLDER_DEFINITION ptr) as HRESULT
	end type

	type IKnownFolder_
		lpVtbl as IKnownFolderVtbl ptr
	end type

	#define IKnownFolder_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IKnownFolder_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IKnownFolder_Release(This) (This)->lpVtbl->Release(This)
	#define IKnownFolder_GetId(This, pkfid) (This)->lpVtbl->GetId(This, pkfid)
	#define IKnownFolder_GetCategory(This, pCategory) (This)->lpVtbl->GetCategory(This, pCategory)
	#define IKnownFolder_GetShellItem(This, dwFlags, riid, ppv) (This)->lpVtbl->GetShellItem(This, dwFlags, riid, ppv)
	#define IKnownFolder_GetPath(This, dwFlags, ppszPath) (This)->lpVtbl->GetPath(This, dwFlags, ppszPath)
	#define IKnownFolder_SetPath(This, dwFlags, pszPath) (This)->lpVtbl->SetPath(This, dwFlags, pszPath)
	#define IKnownFolder_GetIDList(This, dwFlags, ppidl) (This)->lpVtbl->GetIDList(This, dwFlags, ppidl)
	#define IKnownFolder_GetFolderType(This, pftid) (This)->lpVtbl->GetFolderType(This, pftid)
	#define IKnownFolder_GetRedirectionCapabilities(This, pCapabilities) (This)->lpVtbl->GetRedirectionCapabilities(This, pCapabilities)
	#define IKnownFolder_GetFolderDefinition(This, pKFD) (This)->lpVtbl->GetFolderDefinition(This, pKFD)

	declare function IKnownFolder_GetId_Proxy(byval This as IKnownFolder ptr, byval pkfid as KNOWNFOLDERID ptr) as HRESULT
	declare sub IKnownFolder_GetId_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IKnownFolder_GetCategory_Proxy(byval This as IKnownFolder ptr, byval pCategory as KF_CATEGORY ptr) as HRESULT
	declare sub IKnownFolder_GetCategory_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IKnownFolder_GetShellItem_Proxy(byval This as IKnownFolder ptr, byval dwFlags as DWORD, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	declare sub IKnownFolder_GetShellItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IKnownFolder_GetPath_Proxy(byval This as IKnownFolder ptr, byval dwFlags as DWORD, byval ppszPath as LPWSTR ptr) as HRESULT
	declare sub IKnownFolder_GetPath_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IKnownFolder_SetPath_Proxy(byval This as IKnownFolder ptr, byval dwFlags as DWORD, byval pszPath as LPCWSTR) as HRESULT
	declare sub IKnownFolder_SetPath_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IKnownFolder_GetIDList_Proxy(byval This as IKnownFolder ptr, byval dwFlags as DWORD, byval ppidl as LPITEMIDLIST ptr) as HRESULT
	declare sub IKnownFolder_GetIDList_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IKnownFolder_GetFolderType_Proxy(byval This as IKnownFolder ptr, byval pftid as FOLDERTYPEID ptr) as HRESULT
	declare sub IKnownFolder_GetFolderType_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IKnownFolder_GetRedirectionCapabilities_Proxy(byval This as IKnownFolder ptr, byval pCapabilities as KF_REDIRECTION_CAPABILITIES ptr) as HRESULT
	declare sub IKnownFolder_GetRedirectionCapabilities_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IKnownFolder_GetFolderDefinition_Proxy(byval This as IKnownFolder ptr, byval pKFD as KNOWNFOLDER_DEFINITION ptr) as HRESULT
	declare sub IKnownFolder_GetFolderDefinition_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	#define __IKnownFolderManager_INTERFACE_DEFINED__

	type FFFP_MODE as long
	enum
		FFFP_EXACTMATCH = 0
		FFFP_NEARESTPARENTMATCH = 1
	end enum

	extern IID_IKnownFolderManager as const GUID
	type IKnownFolderManager as IKnownFolderManager_

	type IKnownFolderManagerVtbl
		QueryInterface as function(byval This as IKnownFolderManager ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IKnownFolderManager ptr) as ULONG
		Release as function(byval This as IKnownFolderManager ptr) as ULONG
		FolderIdFromCsidl as function(byval This as IKnownFolderManager ptr, byval nCsidl as long, byval pfid as KNOWNFOLDERID ptr) as HRESULT
		FolderIdToCsidl as function(byval This as IKnownFolderManager ptr, byval rfid as const KNOWNFOLDERID const ptr, byval pnCsidl as long ptr) as HRESULT
		GetFolderIds as function(byval This as IKnownFolderManager ptr, byval ppKFId as KNOWNFOLDERID ptr ptr, byval pCount as UINT ptr) as HRESULT
		GetFolder as function(byval This as IKnownFolderManager ptr, byval rfid as const KNOWNFOLDERID const ptr, byval ppkf as IKnownFolder ptr ptr) as HRESULT
		GetFolderByName as function(byval This as IKnownFolderManager ptr, byval pszCanonicalName as LPCWSTR, byval ppkf as IKnownFolder ptr ptr) as HRESULT
		RegisterFolder as function(byval This as IKnownFolderManager ptr, byval rfid as const KNOWNFOLDERID const ptr, byval pKFD as const KNOWNFOLDER_DEFINITION ptr) as HRESULT
		UnregisterFolder as function(byval This as IKnownFolderManager ptr, byval rfid as const KNOWNFOLDERID const ptr) as HRESULT
		FindFolderFromPath as function(byval This as IKnownFolderManager ptr, byval pszPath as LPCWSTR, byval mode as FFFP_MODE, byval ppkf as IKnownFolder ptr ptr) as HRESULT
		FindFolderFromIDList as function(byval This as IKnownFolderManager ptr, byval pidl as LPCITEMIDLIST, byval ppkf as IKnownFolder ptr ptr) as HRESULT
		Redirect as function(byval This as IKnownFolderManager ptr, byval rfid as const KNOWNFOLDERID const ptr, byval hwnd as HWND, byval flags as KF_REDIRECT_FLAGS, byval pszTargetPath as LPCWSTR, byval cFolders as UINT, byval pExclusion as const KNOWNFOLDERID ptr, byval ppszError as LPWSTR ptr) as HRESULT
	end type

	type IKnownFolderManager_
		lpVtbl as IKnownFolderManagerVtbl ptr
	end type

	#define IKnownFolderManager_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IKnownFolderManager_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IKnownFolderManager_Release(This) (This)->lpVtbl->Release(This)
	#define IKnownFolderManager_FolderIdFromCsidl(This, nCsidl, pfid) (This)->lpVtbl->FolderIdFromCsidl(This, nCsidl, pfid)
	#define IKnownFolderManager_FolderIdToCsidl(This, rfid, pnCsidl) (This)->lpVtbl->FolderIdToCsidl(This, rfid, pnCsidl)
	#define IKnownFolderManager_GetFolderIds(This, ppKFId, pCount) (This)->lpVtbl->GetFolderIds(This, ppKFId, pCount)
	#define IKnownFolderManager_GetFolder(This, rfid, ppkf) (This)->lpVtbl->GetFolder(This, rfid, ppkf)
	#define IKnownFolderManager_GetFolderByName(This, pszCanonicalName, ppkf) (This)->lpVtbl->GetFolderByName(This, pszCanonicalName, ppkf)
	#define IKnownFolderManager_RegisterFolder(This, rfid, pKFD) (This)->lpVtbl->RegisterFolder(This, rfid, pKFD)
	#define IKnownFolderManager_UnregisterFolder(This, rfid) (This)->lpVtbl->UnregisterFolder(This, rfid)
	#define IKnownFolderManager_FindFolderFromPath(This, pszPath, mode, ppkf) (This)->lpVtbl->FindFolderFromPath(This, pszPath, mode, ppkf)
	#define IKnownFolderManager_FindFolderFromIDList(This, pidl, ppkf) (This)->lpVtbl->FindFolderFromIDList(This, pidl, ppkf)
	#define IKnownFolderManager_Redirect(This, rfid, hwnd, flags, pszTargetPath, cFolders, pExclusion, ppszError) (This)->lpVtbl->Redirect(This, rfid, hwnd, flags, pszTargetPath, cFolders, pExclusion, ppszError)

	declare function IKnownFolderManager_FolderIdFromCsidl_Proxy(byval This as IKnownFolderManager ptr, byval nCsidl as long, byval pfid as KNOWNFOLDERID ptr) as HRESULT
	declare sub IKnownFolderManager_FolderIdFromCsidl_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IKnownFolderManager_FolderIdToCsidl_Proxy(byval This as IKnownFolderManager ptr, byval rfid as const KNOWNFOLDERID const ptr, byval pnCsidl as long ptr) as HRESULT
	declare sub IKnownFolderManager_FolderIdToCsidl_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IKnownFolderManager_GetFolderIds_Proxy(byval This as IKnownFolderManager ptr, byval ppKFId as KNOWNFOLDERID ptr ptr, byval pCount as UINT ptr) as HRESULT
	declare sub IKnownFolderManager_GetFolderIds_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IKnownFolderManager_GetFolder_Proxy(byval This as IKnownFolderManager ptr, byval rfid as const KNOWNFOLDERID const ptr, byval ppkf as IKnownFolder ptr ptr) as HRESULT
	declare sub IKnownFolderManager_GetFolder_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IKnownFolderManager_GetFolderByName_Proxy(byval This as IKnownFolderManager ptr, byval pszCanonicalName as LPCWSTR, byval ppkf as IKnownFolder ptr ptr) as HRESULT
	declare sub IKnownFolderManager_GetFolderByName_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IKnownFolderManager_RegisterFolder_Proxy(byval This as IKnownFolderManager ptr, byval rfid as const KNOWNFOLDERID const ptr, byval pKFD as const KNOWNFOLDER_DEFINITION ptr) as HRESULT
	declare sub IKnownFolderManager_RegisterFolder_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IKnownFolderManager_UnregisterFolder_Proxy(byval This as IKnownFolderManager ptr, byval rfid as const KNOWNFOLDERID const ptr) as HRESULT
	declare sub IKnownFolderManager_UnregisterFolder_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IKnownFolderManager_FindFolderFromPath_Proxy(byval This as IKnownFolderManager ptr, byval pszPath as LPCWSTR, byval mode as FFFP_MODE, byval ppkf as IKnownFolder ptr ptr) as HRESULT
	declare sub IKnownFolderManager_FindFolderFromPath_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IKnownFolderManager_FindFolderFromIDList_Proxy(byval This as IKnownFolderManager ptr, byval pidl as LPCITEMIDLIST, byval ppkf as IKnownFolder ptr ptr) as HRESULT
	declare sub IKnownFolderManager_FindFolderFromIDList_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IKnownFolderManager_RemoteRedirect_Proxy(byval This as IKnownFolderManager ptr, byval rfid as const KNOWNFOLDERID const ptr, byval hwnd as HWND, byval flags as KF_REDIRECT_FLAGS, byval pszTargetPath as LPCWSTR, byval cFolders as UINT, byval pExclusion as const GUID ptr, byval ppszError as LPWSTR ptr) as HRESULT
	declare sub IKnownFolderManager_RemoteRedirect_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IKnownFolderManager_Redirect_Proxy(byval This as IKnownFolderManager ptr, byval rfid as const KNOWNFOLDERID const ptr, byval hwnd as HWND, byval flags as KF_REDIRECT_FLAGS, byval pszTargetPath as LPCWSTR, byval cFolders as UINT, byval pExclusion as const KNOWNFOLDERID ptr, byval ppszError as LPWSTR ptr) as HRESULT
	declare function IKnownFolderManager_Redirect_Stub(byval This as IKnownFolderManager ptr, byval rfid as const KNOWNFOLDERID const ptr, byval hwnd as HWND, byval flags as KF_REDIRECT_FLAGS, byval pszTargetPath as LPCWSTR, byval cFolders as UINT, byval pExclusion as const GUID ptr, byval ppszError as LPWSTR ptr) as HRESULT

	private sub FreeKnownFolderDefinitionFields cdecl(byval pKFD as KNOWNFOLDER_DEFINITION ptr)
		CoTaskMemFree(pKFD->pszName)
		CoTaskMemFree(pKFD->pszDescription)
		CoTaskMemFree(pKFD->pszRelativePath)
		CoTaskMemFree(pKFD->pszParsingName)
		CoTaskMemFree(pKFD->pszTooltip)
		CoTaskMemFree(pKFD->pszLocalizedName)
		CoTaskMemFree(pKFD->pszIcon)
		CoTaskMemFree(pKFD->pszSecurity)
	end sub

	type SHARE_ROLE as long
	enum
		SHARE_ROLE_INVALID = -1
		SHARE_ROLE_READER = 0
		SHARE_ROLE_CONTRIBUTOR = 1
		SHARE_ROLE_CO_OWNER = 2
		SHARE_ROLE_OWNER = 3
		SHARE_ROLE_CUSTOM = 4
		SHARE_ROLE_MIXED = 5
	end enum

	type DEF_SHARE_ID as long
	enum
		DEFSHAREID_USERS = 1
		DEFSHAREID_PUBLIC = 2
	end enum

	#define __ISharingConfigurationManager_INTERFACE_DEFINED__
	extern IID_ISharingConfigurationManager as const GUID
	type ISharingConfigurationManager as ISharingConfigurationManager_

	type ISharingConfigurationManagerVtbl
		QueryInterface as function(byval This as ISharingConfigurationManager ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as ISharingConfigurationManager ptr) as ULONG
		Release as function(byval This as ISharingConfigurationManager ptr) as ULONG
		CreateShare as function(byval This as ISharingConfigurationManager ptr, byval dsid as DEF_SHARE_ID, byval role as SHARE_ROLE) as HRESULT
		DeleteShare as function(byval This as ISharingConfigurationManager ptr, byval dsid as DEF_SHARE_ID) as HRESULT
		ShareExists as function(byval This as ISharingConfigurationManager ptr, byval dsid as DEF_SHARE_ID) as HRESULT
		GetSharePermissions as function(byval This as ISharingConfigurationManager ptr, byval dsid as DEF_SHARE_ID, byval pRole as SHARE_ROLE ptr) as HRESULT
		SharePrinters as function(byval This as ISharingConfigurationManager ptr) as HRESULT
		StopSharingPrinters as function(byval This as ISharingConfigurationManager ptr) as HRESULT
		ArePrintersShared as function(byval This as ISharingConfigurationManager ptr) as HRESULT
	end type

	type ISharingConfigurationManager_
		lpVtbl as ISharingConfigurationManagerVtbl ptr
	end type

	#define ISharingConfigurationManager_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define ISharingConfigurationManager_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define ISharingConfigurationManager_Release(This) (This)->lpVtbl->Release(This)
	#define ISharingConfigurationManager_CreateShare(This, dsid, role) (This)->lpVtbl->CreateShare(This, dsid, role)
	#define ISharingConfigurationManager_DeleteShare(This, dsid) (This)->lpVtbl->DeleteShare(This, dsid)
	#define ISharingConfigurationManager_ShareExists(This, dsid) (This)->lpVtbl->ShareExists(This, dsid)
	#define ISharingConfigurationManager_GetSharePermissions(This, dsid, pRole) (This)->lpVtbl->GetSharePermissions(This, dsid, pRole)
	#define ISharingConfigurationManager_SharePrinters(This) (This)->lpVtbl->SharePrinters(This)
	#define ISharingConfigurationManager_StopSharingPrinters(This) (This)->lpVtbl->StopSharingPrinters(This)
	#define ISharingConfigurationManager_ArePrintersShared(This) (This)->lpVtbl->ArePrintersShared(This)

	declare function ISharingConfigurationManager_CreateShare_Proxy(byval This as ISharingConfigurationManager ptr, byval dsid as DEF_SHARE_ID, byval role as SHARE_ROLE) as HRESULT
	declare sub ISharingConfigurationManager_CreateShare_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function ISharingConfigurationManager_DeleteShare_Proxy(byval This as ISharingConfigurationManager ptr, byval dsid as DEF_SHARE_ID) as HRESULT
	declare sub ISharingConfigurationManager_DeleteShare_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function ISharingConfigurationManager_ShareExists_Proxy(byval This as ISharingConfigurationManager ptr, byval dsid as DEF_SHARE_ID) as HRESULT
	declare sub ISharingConfigurationManager_ShareExists_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function ISharingConfigurationManager_GetSharePermissions_Proxy(byval This as ISharingConfigurationManager ptr, byval dsid as DEF_SHARE_ID, byval pRole as SHARE_ROLE ptr) as HRESULT
	declare sub ISharingConfigurationManager_GetSharePermissions_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function ISharingConfigurationManager_SharePrinters_Proxy(byval This as ISharingConfigurationManager ptr) as HRESULT
	declare sub ISharingConfigurationManager_SharePrinters_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function ISharingConfigurationManager_StopSharingPrinters_Proxy(byval This as ISharingConfigurationManager ptr) as HRESULT
	declare sub ISharingConfigurationManager_StopSharingPrinters_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function ISharingConfigurationManager_ArePrintersShared_Proxy(byval This as ISharingConfigurationManager ptr) as HRESULT
	declare sub ISharingConfigurationManager_ArePrintersShared_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#endif

#define __IPreviousVersionsInfo_INTERFACE_DEFINED__
extern IID_IPreviousVersionsInfo as const GUID
type IPreviousVersionsInfo as IPreviousVersionsInfo_

type IPreviousVersionsInfoVtbl
	QueryInterface as function(byval This as IPreviousVersionsInfo ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPreviousVersionsInfo ptr) as ULONG
	Release as function(byval This as IPreviousVersionsInfo ptr) as ULONG
	AreSnapshotsAvailable as function(byval This as IPreviousVersionsInfo ptr, byval pszPath as LPCWSTR, byval fOkToBeSlow as WINBOOL, byval pfAvailable as WINBOOL ptr) as HRESULT
end type

type IPreviousVersionsInfo_
	lpVtbl as IPreviousVersionsInfoVtbl ptr
end type

#define IPreviousVersionsInfo_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IPreviousVersionsInfo_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IPreviousVersionsInfo_Release(This) (This)->lpVtbl->Release(This)
#define IPreviousVersionsInfo_AreSnapshotsAvailable(This, pszPath, fOkToBeSlow, pfAvailable) (This)->lpVtbl->AreSnapshotsAvailable(This, pszPath, fOkToBeSlow, pfAvailable)
declare function IPreviousVersionsInfo_AreSnapshotsAvailable_Proxy(byval This as IPreviousVersionsInfo ptr, byval pszPath as LPCWSTR, byval fOkToBeSlow as WINBOOL, byval pfAvailable as WINBOOL ptr) as HRESULT
declare sub IPreviousVersionsInfo_AreSnapshotsAvailable_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#if _WIN32_WINNT >= &h0600
	#define __IRelatedItem_INTERFACE_DEFINED__
	extern IID_IRelatedItem as const GUID
	type IRelatedItem as IRelatedItem_

	type IRelatedItemVtbl
		QueryInterface as function(byval This as IRelatedItem ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IRelatedItem ptr) as ULONG
		Release as function(byval This as IRelatedItem ptr) as ULONG
		GetItemIDList as function(byval This as IRelatedItem ptr, byval ppidl as LPITEMIDLIST ptr) as HRESULT
		GetItem as function(byval This as IRelatedItem ptr, byval ppsi as IShellItem ptr ptr) as HRESULT
	end type

	type IRelatedItem_
		lpVtbl as IRelatedItemVtbl ptr
	end type

	#define IRelatedItem_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IRelatedItem_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IRelatedItem_Release(This) (This)->lpVtbl->Release(This)
	#define IRelatedItem_GetItemIDList(This, ppidl) (This)->lpVtbl->GetItemIDList(This, ppidl)
	#define IRelatedItem_GetItem(This, ppsi) (This)->lpVtbl->GetItem(This, ppsi)

	declare function IRelatedItem_GetItemIDList_Proxy(byval This as IRelatedItem ptr, byval ppidl as LPITEMIDLIST ptr) as HRESULT
	declare sub IRelatedItem_GetItemIDList_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IRelatedItem_GetItem_Proxy(byval This as IRelatedItem ptr, byval ppsi as IShellItem ptr ptr) as HRESULT
	declare sub IRelatedItem_GetItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	#define __IIdentityName_INTERFACE_DEFINED__
	extern IID_IIdentityName as const GUID
	type IIdentityName as IIdentityName_

	type IIdentityNameVtbl
		QueryInterface as function(byval This as IIdentityName ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IIdentityName ptr) as ULONG
		Release as function(byval This as IIdentityName ptr) as ULONG
		GetItemIDList as function(byval This as IIdentityName ptr, byval ppidl as LPITEMIDLIST ptr) as HRESULT
		GetItem as function(byval This as IIdentityName ptr, byval ppsi as IShellItem ptr ptr) as HRESULT
	end type

	type IIdentityName_
		lpVtbl as IIdentityNameVtbl ptr
	end type

	#define IIdentityName_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IIdentityName_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IIdentityName_Release(This) (This)->lpVtbl->Release(This)
	#define IIdentityName_GetItemIDList(This, ppidl) (This)->lpVtbl->GetItemIDList(This, ppidl)
	#define IIdentityName_GetItem(This, ppsi) (This)->lpVtbl->GetItem(This, ppsi)
	#define __IDelegateItem_INTERFACE_DEFINED__
	extern IID_IDelegateItem as const GUID
	type IDelegateItem as IDelegateItem_

	type IDelegateItemVtbl
		QueryInterface as function(byval This as IDelegateItem ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IDelegateItem ptr) as ULONG
		Release as function(byval This as IDelegateItem ptr) as ULONG
		GetItemIDList as function(byval This as IDelegateItem ptr, byval ppidl as LPITEMIDLIST ptr) as HRESULT
		GetItem as function(byval This as IDelegateItem ptr, byval ppsi as IShellItem ptr ptr) as HRESULT
	end type

	type IDelegateItem_
		lpVtbl as IDelegateItemVtbl ptr
	end type

	#define IDelegateItem_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IDelegateItem_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IDelegateItem_Release(This) (This)->lpVtbl->Release(This)
	#define IDelegateItem_GetItemIDList(This, ppidl) (This)->lpVtbl->GetItemIDList(This, ppidl)
	#define IDelegateItem_GetItem(This, ppsi) (This)->lpVtbl->GetItem(This, ppsi)
	#define __ICurrentItem_INTERFACE_DEFINED__
	extern IID_ICurrentItem as const GUID
	type ICurrentItem as ICurrentItem_

	type ICurrentItemVtbl
		QueryInterface as function(byval This as ICurrentItem ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as ICurrentItem ptr) as ULONG
		Release as function(byval This as ICurrentItem ptr) as ULONG
		GetItemIDList as function(byval This as ICurrentItem ptr, byval ppidl as LPITEMIDLIST ptr) as HRESULT
		GetItem as function(byval This as ICurrentItem ptr, byval ppsi as IShellItem ptr ptr) as HRESULT
	end type

	type ICurrentItem_
		lpVtbl as ICurrentItemVtbl ptr
	end type

	#define ICurrentItem_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define ICurrentItem_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define ICurrentItem_Release(This) (This)->lpVtbl->Release(This)
	#define ICurrentItem_GetItemIDList(This, ppidl) (This)->lpVtbl->GetItemIDList(This, ppidl)
	#define ICurrentItem_GetItem(This, ppsi) (This)->lpVtbl->GetItem(This, ppsi)
	#define __ITransferMediumItem_INTERFACE_DEFINED__
	extern IID_ITransferMediumItem as const GUID
	type ITransferMediumItem as ITransferMediumItem_

	type ITransferMediumItemVtbl
		QueryInterface as function(byval This as ITransferMediumItem ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as ITransferMediumItem ptr) as ULONG
		Release as function(byval This as ITransferMediumItem ptr) as ULONG
		GetItemIDList as function(byval This as ITransferMediumItem ptr, byval ppidl as LPITEMIDLIST ptr) as HRESULT
		GetItem as function(byval This as ITransferMediumItem ptr, byval ppsi as IShellItem ptr ptr) as HRESULT
	end type

	type ITransferMediumItem_
		lpVtbl as ITransferMediumItemVtbl ptr
	end type

	#define ITransferMediumItem_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define ITransferMediumItem_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define ITransferMediumItem_Release(This) (This)->lpVtbl->Release(This)
	#define ITransferMediumItem_GetItemIDList(This, ppidl) (This)->lpVtbl->GetItemIDList(This, ppidl)
	#define ITransferMediumItem_GetItem(This, ppsi) (This)->lpVtbl->GetItem(This, ppsi)
	#define __IUseToBrowseItem_INTERFACE_DEFINED__
	extern IID_IUseToBrowseItem as const GUID
	type IUseToBrowseItem as IUseToBrowseItem_

	type IUseToBrowseItemVtbl
		QueryInterface as function(byval This as IUseToBrowseItem ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IUseToBrowseItem ptr) as ULONG
		Release as function(byval This as IUseToBrowseItem ptr) as ULONG
		GetItemIDList as function(byval This as IUseToBrowseItem ptr, byval ppidl as LPITEMIDLIST ptr) as HRESULT
		GetItem as function(byval This as IUseToBrowseItem ptr, byval ppsi as IShellItem ptr ptr) as HRESULT
	end type

	type IUseToBrowseItem_
		lpVtbl as IUseToBrowseItemVtbl ptr
	end type

	#define IUseToBrowseItem_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IUseToBrowseItem_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IUseToBrowseItem_Release(This) (This)->lpVtbl->Release(This)
	#define IUseToBrowseItem_GetItemIDList(This, ppidl) (This)->lpVtbl->GetItemIDList(This, ppidl)
	#define IUseToBrowseItem_GetItem(This, ppsi) (This)->lpVtbl->GetItem(This, ppsi)
	#define __IDisplayItem_INTERFACE_DEFINED__
	extern IID_IDisplayItem as const GUID
	type IDisplayItem as IDisplayItem_

	type IDisplayItemVtbl
		QueryInterface as function(byval This as IDisplayItem ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IDisplayItem ptr) as ULONG
		Release as function(byval This as IDisplayItem ptr) as ULONG
		GetItemIDList as function(byval This as IDisplayItem ptr, byval ppidl as LPITEMIDLIST ptr) as HRESULT
		GetItem as function(byval This as IDisplayItem ptr, byval ppsi as IShellItem ptr ptr) as HRESULT
	end type

	type IDisplayItem_
		lpVtbl as IDisplayItemVtbl ptr
	end type

	#define IDisplayItem_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IDisplayItem_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IDisplayItem_Release(This) (This)->lpVtbl->Release(This)
	#define IDisplayItem_GetItemIDList(This, ppidl) (This)->lpVtbl->GetItemIDList(This, ppidl)
	#define IDisplayItem_GetItem(This, ppsi) (This)->lpVtbl->GetItem(This, ppsi)
	#define __IViewStateIdentityItem_INTERFACE_DEFINED__
	extern IID_IViewStateIdentityItem as const GUID
	type IViewStateIdentityItem as IViewStateIdentityItem_

	type IViewStateIdentityItemVtbl
		QueryInterface as function(byval This as IViewStateIdentityItem ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IViewStateIdentityItem ptr) as ULONG
		Release as function(byval This as IViewStateIdentityItem ptr) as ULONG
		GetItemIDList as function(byval This as IViewStateIdentityItem ptr, byval ppidl as LPITEMIDLIST ptr) as HRESULT
		GetItem as function(byval This as IViewStateIdentityItem ptr, byval ppsi as IShellItem ptr ptr) as HRESULT
	end type

	type IViewStateIdentityItem_
		lpVtbl as IViewStateIdentityItemVtbl ptr
	end type

	#define IViewStateIdentityItem_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IViewStateIdentityItem_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IViewStateIdentityItem_Release(This) (This)->lpVtbl->Release(This)
	#define IViewStateIdentityItem_GetItemIDList(This, ppidl) (This)->lpVtbl->GetItemIDList(This, ppidl)
	#define IViewStateIdentityItem_GetItem(This, ppsi) (This)->lpVtbl->GetItem(This, ppsi)
	#define __IPreviewItem_INTERFACE_DEFINED__
	extern IID_IPreviewItem as const GUID
	type IPreviewItem as IPreviewItem_

	type IPreviewItemVtbl
		QueryInterface as function(byval This as IPreviewItem ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IPreviewItem ptr) as ULONG
		Release as function(byval This as IPreviewItem ptr) as ULONG
		GetItemIDList as function(byval This as IPreviewItem ptr, byval ppidl as LPITEMIDLIST ptr) as HRESULT
		GetItem as function(byval This as IPreviewItem ptr, byval ppsi as IShellItem ptr ptr) as HRESULT
	end type

	type IPreviewItem_
		lpVtbl as IPreviewItemVtbl ptr
	end type

	#define IPreviewItem_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IPreviewItem_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IPreviewItem_Release(This) (This)->lpVtbl->Release(This)
	#define IPreviewItem_GetItemIDList(This, ppidl) (This)->lpVtbl->GetItemIDList(This, ppidl)
	#define IPreviewItem_GetItem(This, ppsi) (This)->lpVtbl->GetItem(This, ppsi)
#endif

#define __IDestinationStreamFactory_INTERFACE_DEFINED__
extern IID_IDestinationStreamFactory as const GUID
type IDestinationStreamFactory as IDestinationStreamFactory_

type IDestinationStreamFactoryVtbl
	QueryInterface as function(byval This as IDestinationStreamFactory ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDestinationStreamFactory ptr) as ULONG
	Release as function(byval This as IDestinationStreamFactory ptr) as ULONG
	GetDestinationStream as function(byval This as IDestinationStreamFactory ptr, byval ppstm as IStream ptr ptr) as HRESULT
end type

type IDestinationStreamFactory_
	lpVtbl as IDestinationStreamFactoryVtbl ptr
end type

#define IDestinationStreamFactory_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IDestinationStreamFactory_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IDestinationStreamFactory_Release(This) (This)->lpVtbl->Release(This)
#define IDestinationStreamFactory_GetDestinationStream(This, ppstm) (This)->lpVtbl->GetDestinationStream(This, ppstm)
declare function IDestinationStreamFactory_GetDestinationStream_Proxy(byval This as IDestinationStreamFactory ptr, byval ppstm as IStream ptr ptr) as HRESULT
declare sub IDestinationStreamFactory_GetDestinationStream_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

type _NMCII_FLAGS as long
enum
	NMCII_NONE = &h0
	NMCII_ITEMS = &h1
	NMCII_FOLDERS = &h2
end enum

type NMCII_FLAGS as long

type _NMCSAEI_FLAGS as long
enum
	NMCSAEI_SELECT = &h0
	NMCSAEI_EDIT = &h1
end enum

type NMCSAEI_FLAGS as long
#define __INewMenuClient_INTERFACE_DEFINED__
extern IID_INewMenuClient as const GUID
type INewMenuClient as INewMenuClient_

type INewMenuClientVtbl
	QueryInterface as function(byval This as INewMenuClient ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as INewMenuClient ptr) as ULONG
	Release as function(byval This as INewMenuClient ptr) as ULONG
	IncludeItems as function(byval This as INewMenuClient ptr, byval pflags as NMCII_FLAGS ptr) as HRESULT
	SelectAndEditItem as function(byval This as INewMenuClient ptr, byval pidlItem as LPCITEMIDLIST, byval flags as NMCSAEI_FLAGS) as HRESULT
end type

type INewMenuClient_
	lpVtbl as INewMenuClientVtbl ptr
end type

#define INewMenuClient_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define INewMenuClient_AddRef(This) (This)->lpVtbl->AddRef(This)
#define INewMenuClient_Release(This) (This)->lpVtbl->Release(This)
#define INewMenuClient_IncludeItems(This, pflags) (This)->lpVtbl->IncludeItems(This, pflags)
#define INewMenuClient_SelectAndEditItem(This, pidlItem, flags) (This)->lpVtbl->SelectAndEditItem(This, pidlItem, flags)

declare function INewMenuClient_IncludeItems_Proxy(byval This as INewMenuClient ptr, byval pflags as NMCII_FLAGS ptr) as HRESULT
declare sub INewMenuClient_IncludeItems_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function INewMenuClient_SelectAndEditItem_Proxy(byval This as INewMenuClient ptr, byval pidlItem as LPCITEMIDLIST, byval flags as NMCSAEI_FLAGS) as HRESULT
declare sub INewMenuClient_SelectAndEditItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
extern SID_SNewMenuClient alias "IID_INewMenuClient" as const GUID
extern SID_SCommandBarState as const GUID

#if _WIN32_WINNT >= &h0600
	#define __IInitializeWithBindCtx_INTERFACE_DEFINED__
	extern IID_IInitializeWithBindCtx as const GUID
	type IInitializeWithBindCtx as IInitializeWithBindCtx_

	type IInitializeWithBindCtxVtbl
		QueryInterface as function(byval This as IInitializeWithBindCtx ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IInitializeWithBindCtx ptr) as ULONG
		Release as function(byval This as IInitializeWithBindCtx ptr) as ULONG
		Initialize as function(byval This as IInitializeWithBindCtx ptr, byval pbc as IBindCtx ptr) as HRESULT
	end type

	type IInitializeWithBindCtx_
		lpVtbl as IInitializeWithBindCtxVtbl ptr
	end type

	#define IInitializeWithBindCtx_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IInitializeWithBindCtx_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IInitializeWithBindCtx_Release(This) (This)->lpVtbl->Release(This)
	#define IInitializeWithBindCtx_Initialize(This, pbc) (This)->lpVtbl->Initialize(This, pbc)
	declare function IInitializeWithBindCtx_Initialize_Proxy(byval This as IInitializeWithBindCtx ptr, byval pbc as IBindCtx ptr) as HRESULT
	declare sub IInitializeWithBindCtx_Initialize_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	#define __IShellItemFilter_INTERFACE_DEFINED__
	extern IID_IShellItemFilter as const GUID

	type IShellItemFilterVtbl
		QueryInterface as function(byval This as IShellItemFilter ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IShellItemFilter ptr) as ULONG
		Release as function(byval This as IShellItemFilter ptr) as ULONG
		IncludeItem as function(byval This as IShellItemFilter ptr, byval psi as IShellItem ptr) as HRESULT
		GetEnumFlagsForItem as function(byval This as IShellItemFilter ptr, byval psi as IShellItem ptr, byval pgrfFlags as SHCONTF ptr) as HRESULT
	end type

	type IShellItemFilter_
		lpVtbl as IShellItemFilterVtbl ptr
	end type

	#define IShellItemFilter_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IShellItemFilter_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IShellItemFilter_Release(This) (This)->lpVtbl->Release(This)
	#define IShellItemFilter_IncludeItem(This, psi) (This)->lpVtbl->IncludeItem(This, psi)
	#define IShellItemFilter_GetEnumFlagsForItem(This, psi, pgrfFlags) (This)->lpVtbl->GetEnumFlagsForItem(This, psi, pgrfFlags)

	declare function IShellItemFilter_IncludeItem_Proxy(byval This as IShellItemFilter ptr, byval psi as IShellItem ptr) as HRESULT
	declare sub IShellItemFilter_IncludeItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IShellItemFilter_GetEnumFlagsForItem_Proxy(byval This as IShellItemFilter ptr, byval psi as IShellItem ptr, byval pgrfFlags as SHCONTF ptr) as HRESULT
	declare sub IShellItemFilter_GetEnumFlagsForItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#endif

#define __INameSpaceTreeControl_INTERFACE_DEFINED__

type _NSTCSTYLE as long
enum
	NSTCS_HASEXPANDOS = &h1
	NSTCS_HASLINES = &h2
	NSTCS_SINGLECLICKEXPAND = &h4
	NSTCS_FULLROWSELECT = &h8
	NSTCS_SPRINGEXPAND = &h10
	NSTCS_HORIZONTALSCROLL = &h20
	NSTCS_ROOTHASEXPANDO = &h40
	NSTCS_SHOWSELECTIONALWAYS = &h80
	NSTCS_NOINFOTIP = &h200
	NSTCS_EVENHEIGHT = &h400
	NSTCS_NOREPLACEOPEN = &h800
	NSTCS_DISABLEDRAGDROP = &h1000
	NSTCS_NOORDERSTREAM = &h2000
	NSTCS_RICHTOOLTIP = &h4000
	NSTCS_BORDER = &h8000
	NSTCS_NOEDITLABELS = &h10000
	NSTCS_TABSTOP = &h20000
	NSTCS_FAVORITESMODE = &h80000
	NSTCS_AUTOHSCROLL = &h100000
	NSTCS_FADEINOUTEXPANDOS = &h200000
	NSTCS_EMPTYTEXT = &h400000
	NSTCS_CHECKBOXES = &h800000
	NSTCS_PARTIALCHECKBOXES = &h1000000
	NSTCS_EXCLUSIONCHECKBOXES = &h2000000
	NSTCS_DIMMEDCHECKBOXES = &h4000000
	NSTCS_NOINDENTCHECKS = &h8000000
	NSTCS_ALLOWJUNCTIONS = &h10000000
	NSTCS_SHOWTABSBUTTON = &h20000000
	NSTCS_SHOWDELETEBUTTON = &h40000000
	NSTCS_SHOWREFRESHBUTTON = clng(&h80000000)
end enum

type NSTCSTYLE as DWORD

type _NSTCROOTSTYLE as long
enum
	NSTCRS_VISIBLE = &h0
	NSTCRS_HIDDEN = &h1
	NSTCRS_EXPANDED = &h2
end enum

type NSTCROOTSTYLE as DWORD

type _NSTCITEMSTATE as long
enum
	NSTCIS_NONE = &h0
	NSTCIS_SELECTED = &h1
	NSTCIS_EXPANDED = &h2
	NSTCIS_BOLD = &h4
	NSTCIS_DISABLED = &h8
	NSTCIS_SELECTEDNOEXPAND = &h10
end enum

type NSTCITEMSTATE as DWORD

type NSTCGNI as long
enum
	NSTCGNI_NEXT = 0
	NSTCGNI_NEXTVISIBLE = 1
	NSTCGNI_PREV = 2
	NSTCGNI_PREVVISIBLE = 3
	NSTCGNI_PARENT = 4
	NSTCGNI_CHILD = 5
	NSTCGNI_FIRSTVISIBLE = 6
	NSTCGNI_LASTVISIBLE = 7
end enum

extern IID_INameSpaceTreeControl as const GUID
type INameSpaceTreeControl as INameSpaceTreeControl_

type INameSpaceTreeControlVtbl
	QueryInterface as function(byval This as INameSpaceTreeControl ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as INameSpaceTreeControl ptr) as ULONG
	Release as function(byval This as INameSpaceTreeControl ptr) as ULONG
	Initialize as function(byval This as INameSpaceTreeControl ptr, byval hwndParent as HWND, byval prc as RECT ptr, byval nsctsFlags as NSTCSTYLE) as HRESULT
	TreeAdvise as function(byval This as INameSpaceTreeControl ptr, byval punk as IUnknown ptr, byval pdwCookie as DWORD ptr) as HRESULT
	TreeUnadvise as function(byval This as INameSpaceTreeControl ptr, byval dwCookie as DWORD) as HRESULT
	AppendRoot as function(byval This as INameSpaceTreeControl ptr, byval psiRoot as IShellItem ptr, byval grfEnumFlags as SHCONTF, byval grfRootStyle as NSTCROOTSTYLE, byval pif as IShellItemFilter ptr) as HRESULT
	InsertRoot as function(byval This as INameSpaceTreeControl ptr, byval iIndex as long, byval psiRoot as IShellItem ptr, byval grfEnumFlags as SHCONTF, byval grfRootStyle as NSTCROOTSTYLE, byval pif as IShellItemFilter ptr) as HRESULT
	RemoveRoot as function(byval This as INameSpaceTreeControl ptr, byval psiRoot as IShellItem ptr) as HRESULT
	RemoveAllRoots as function(byval This as INameSpaceTreeControl ptr) as HRESULT
	GetRootItems as function(byval This as INameSpaceTreeControl ptr, byval ppsiaRootItems as IShellItemArray ptr ptr) as HRESULT
	SetItemState as function(byval This as INameSpaceTreeControl ptr, byval psi as IShellItem ptr, byval nstcisMask as NSTCITEMSTATE, byval nstcisFlags as NSTCITEMSTATE) as HRESULT
	GetItemState as function(byval This as INameSpaceTreeControl ptr, byval psi as IShellItem ptr, byval nstcisMask as NSTCITEMSTATE, byval pnstcisFlags as NSTCITEMSTATE ptr) as HRESULT
	GetSelectedItems as function(byval This as INameSpaceTreeControl ptr, byval psiaItems as IShellItemArray ptr ptr) as HRESULT
	GetItemCustomState as function(byval This as INameSpaceTreeControl ptr, byval psi as IShellItem ptr, byval piStateNumber as long ptr) as HRESULT
	SetItemCustomState as function(byval This as INameSpaceTreeControl ptr, byval psi as IShellItem ptr, byval iStateNumber as long) as HRESULT
	EnsureItemVisible as function(byval This as INameSpaceTreeControl ptr, byval psi as IShellItem ptr) as HRESULT
	SetTheme as function(byval This as INameSpaceTreeControl ptr, byval pszTheme as LPCWSTR) as HRESULT
	GetNextItem as function(byval This as INameSpaceTreeControl ptr, byval psi as IShellItem ptr, byval nstcgi as NSTCGNI, byval ppsiNext as IShellItem ptr ptr) as HRESULT
	HitTest as function(byval This as INameSpaceTreeControl ptr, byval ppt as POINT ptr, byval ppsiOut as IShellItem ptr ptr) as HRESULT
	GetItemRect as function(byval This as INameSpaceTreeControl ptr, byval psi as IShellItem ptr, byval prect as RECT ptr) as HRESULT
	CollapseAll as function(byval This as INameSpaceTreeControl ptr) as HRESULT
end type

type INameSpaceTreeControl_
	lpVtbl as INameSpaceTreeControlVtbl ptr
end type

#define INameSpaceTreeControl_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define INameSpaceTreeControl_AddRef(This) (This)->lpVtbl->AddRef(This)
#define INameSpaceTreeControl_Release(This) (This)->lpVtbl->Release(This)
#define INameSpaceTreeControl_Initialize(This, hwndParent, prc, nsctsFlags) (This)->lpVtbl->Initialize(This, hwndParent, prc, nsctsFlags)
#define INameSpaceTreeControl_TreeAdvise(This, punk, pdwCookie) (This)->lpVtbl->TreeAdvise(This, punk, pdwCookie)
#define INameSpaceTreeControl_TreeUnadvise(This, dwCookie) (This)->lpVtbl->TreeUnadvise(This, dwCookie)
#define INameSpaceTreeControl_AppendRoot(This, psiRoot, grfEnumFlags, grfRootStyle, pif) (This)->lpVtbl->AppendRoot(This, psiRoot, grfEnumFlags, grfRootStyle, pif)
#define INameSpaceTreeControl_InsertRoot(This, iIndex, psiRoot, grfEnumFlags, grfRootStyle, pif) (This)->lpVtbl->InsertRoot(This, iIndex, psiRoot, grfEnumFlags, grfRootStyle, pif)
#define INameSpaceTreeControl_RemoveRoot(This, psiRoot) (This)->lpVtbl->RemoveRoot(This, psiRoot)
#define INameSpaceTreeControl_RemoveAllRoots(This) (This)->lpVtbl->RemoveAllRoots(This)
#define INameSpaceTreeControl_GetRootItems(This, ppsiaRootItems) (This)->lpVtbl->GetRootItems(This, ppsiaRootItems)
#define INameSpaceTreeControl_SetItemState(This, psi, nstcisMask, nstcisFlags) (This)->lpVtbl->SetItemState(This, psi, nstcisMask, nstcisFlags)
#define INameSpaceTreeControl_GetItemState(This, psi, nstcisMask, pnstcisFlags) (This)->lpVtbl->GetItemState(This, psi, nstcisMask, pnstcisFlags)
#define INameSpaceTreeControl_GetSelectedItems(This, psiaItems) (This)->lpVtbl->GetSelectedItems(This, psiaItems)
#define INameSpaceTreeControl_GetItemCustomState(This, psi, piStateNumber) (This)->lpVtbl->GetItemCustomState(This, psi, piStateNumber)
#define INameSpaceTreeControl_SetItemCustomState(This, psi, iStateNumber) (This)->lpVtbl->SetItemCustomState(This, psi, iStateNumber)
#define INameSpaceTreeControl_EnsureItemVisible(This, psi) (This)->lpVtbl->EnsureItemVisible(This, psi)
#define INameSpaceTreeControl_SetTheme(This, pszTheme) (This)->lpVtbl->SetTheme(This, pszTheme)
#define INameSpaceTreeControl_GetNextItem(This, psi, nstcgi, ppsiNext) (This)->lpVtbl->GetNextItem(This, psi, nstcgi, ppsiNext)
#define INameSpaceTreeControl_HitTest(This, ppt, ppsiOut) (This)->lpVtbl->HitTest(This, ppt, ppsiOut)
#define INameSpaceTreeControl_GetItemRect(This, psi, prect) (This)->lpVtbl->GetItemRect(This, psi, prect)
#define INameSpaceTreeControl_CollapseAll(This) (This)->lpVtbl->CollapseAll(This)

declare function INameSpaceTreeControl_Initialize_Proxy(byval This as INameSpaceTreeControl ptr, byval hwndParent as HWND, byval prc as RECT ptr, byval nsctsFlags as NSTCSTYLE) as HRESULT
declare sub INameSpaceTreeControl_Initialize_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function INameSpaceTreeControl_TreeAdvise_Proxy(byval This as INameSpaceTreeControl ptr, byval punk as IUnknown ptr, byval pdwCookie as DWORD ptr) as HRESULT
declare sub INameSpaceTreeControl_TreeAdvise_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function INameSpaceTreeControl_TreeUnadvise_Proxy(byval This as INameSpaceTreeControl ptr, byval dwCookie as DWORD) as HRESULT
declare sub INameSpaceTreeControl_TreeUnadvise_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function INameSpaceTreeControl_AppendRoot_Proxy(byval This as INameSpaceTreeControl ptr, byval psiRoot as IShellItem ptr, byval grfEnumFlags as SHCONTF, byval grfRootStyle as NSTCROOTSTYLE, byval pif as IShellItemFilter ptr) as HRESULT
declare sub INameSpaceTreeControl_AppendRoot_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function INameSpaceTreeControl_InsertRoot_Proxy(byval This as INameSpaceTreeControl ptr, byval iIndex as long, byval psiRoot as IShellItem ptr, byval grfEnumFlags as SHCONTF, byval grfRootStyle as NSTCROOTSTYLE, byval pif as IShellItemFilter ptr) as HRESULT
declare sub INameSpaceTreeControl_InsertRoot_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function INameSpaceTreeControl_RemoveRoot_Proxy(byval This as INameSpaceTreeControl ptr, byval psiRoot as IShellItem ptr) as HRESULT
declare sub INameSpaceTreeControl_RemoveRoot_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function INameSpaceTreeControl_RemoveAllRoots_Proxy(byval This as INameSpaceTreeControl ptr) as HRESULT
declare sub INameSpaceTreeControl_RemoveAllRoots_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function INameSpaceTreeControl_GetRootItems_Proxy(byval This as INameSpaceTreeControl ptr, byval ppsiaRootItems as IShellItemArray ptr ptr) as HRESULT
declare sub INameSpaceTreeControl_GetRootItems_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function INameSpaceTreeControl_SetItemState_Proxy(byval This as INameSpaceTreeControl ptr, byval psi as IShellItem ptr, byval nstcisMask as NSTCITEMSTATE, byval nstcisFlags as NSTCITEMSTATE) as HRESULT
declare sub INameSpaceTreeControl_SetItemState_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function INameSpaceTreeControl_GetItemState_Proxy(byval This as INameSpaceTreeControl ptr, byval psi as IShellItem ptr, byval nstcisMask as NSTCITEMSTATE, byval pnstcisFlags as NSTCITEMSTATE ptr) as HRESULT
declare sub INameSpaceTreeControl_GetItemState_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function INameSpaceTreeControl_GetSelectedItems_Proxy(byval This as INameSpaceTreeControl ptr, byval psiaItems as IShellItemArray ptr ptr) as HRESULT
declare sub INameSpaceTreeControl_GetSelectedItems_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function INameSpaceTreeControl_GetItemCustomState_Proxy(byval This as INameSpaceTreeControl ptr, byval psi as IShellItem ptr, byval piStateNumber as long ptr) as HRESULT
declare sub INameSpaceTreeControl_GetItemCustomState_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function INameSpaceTreeControl_SetItemCustomState_Proxy(byval This as INameSpaceTreeControl ptr, byval psi as IShellItem ptr, byval iStateNumber as long) as HRESULT
declare sub INameSpaceTreeControl_SetItemCustomState_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function INameSpaceTreeControl_EnsureItemVisible_Proxy(byval This as INameSpaceTreeControl ptr, byval psi as IShellItem ptr) as HRESULT
declare sub INameSpaceTreeControl_EnsureItemVisible_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function INameSpaceTreeControl_SetTheme_Proxy(byval This as INameSpaceTreeControl ptr, byval pszTheme as LPCWSTR) as HRESULT
declare sub INameSpaceTreeControl_SetTheme_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function INameSpaceTreeControl_GetNextItem_Proxy(byval This as INameSpaceTreeControl ptr, byval psi as IShellItem ptr, byval nstcgi as NSTCGNI, byval ppsiNext as IShellItem ptr ptr) as HRESULT
declare sub INameSpaceTreeControl_GetNextItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function INameSpaceTreeControl_HitTest_Proxy(byval This as INameSpaceTreeControl ptr, byval ppt as POINT ptr, byval ppsiOut as IShellItem ptr ptr) as HRESULT
declare sub INameSpaceTreeControl_HitTest_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function INameSpaceTreeControl_GetItemRect_Proxy(byval This as INameSpaceTreeControl ptr, byval psi as IShellItem ptr, byval prect as RECT ptr) as HRESULT
declare sub INameSpaceTreeControl_GetItemRect_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function INameSpaceTreeControl_CollapseAll_Proxy(byval This as INameSpaceTreeControl ptr) as HRESULT
declare sub INameSpaceTreeControl_CollapseAll_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __INameSpaceTreeControl2_INTERFACE_DEFINED__

type NSTCSTYLE2 as long
enum
	NSTCS2_DEFAULT = &h0
	NSTCS2_INTERRUPTNOTIFICATIONS = &h1
	NSTCS2_SHOWNULLSPACEMENU = &h2
	NSTCS2_DISPLAYPADDING = &h4
	NSTCS2_DISPLAYPINNEDONLY = &h8
	NTSCS2_NOSINGLETONAUTOEXPAND = &h10
	NTSCS2_NEVERINSERTNONENUMERATED = &h20
end enum

extern IID_INameSpaceTreeControl2 as const GUID
type INameSpaceTreeControl2 as INameSpaceTreeControl2_

type INameSpaceTreeControl2Vtbl
	QueryInterface as function(byval This as INameSpaceTreeControl2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as INameSpaceTreeControl2 ptr) as ULONG
	Release as function(byval This as INameSpaceTreeControl2 ptr) as ULONG
	Initialize as function(byval This as INameSpaceTreeControl2 ptr, byval hwndParent as HWND, byval prc as RECT ptr, byval nsctsFlags as NSTCSTYLE) as HRESULT
	TreeAdvise as function(byval This as INameSpaceTreeControl2 ptr, byval punk as IUnknown ptr, byval pdwCookie as DWORD ptr) as HRESULT
	TreeUnadvise as function(byval This as INameSpaceTreeControl2 ptr, byval dwCookie as DWORD) as HRESULT
	AppendRoot as function(byval This as INameSpaceTreeControl2 ptr, byval psiRoot as IShellItem ptr, byval grfEnumFlags as SHCONTF, byval grfRootStyle as NSTCROOTSTYLE, byval pif as IShellItemFilter ptr) as HRESULT
	InsertRoot as function(byval This as INameSpaceTreeControl2 ptr, byval iIndex as long, byval psiRoot as IShellItem ptr, byval grfEnumFlags as SHCONTF, byval grfRootStyle as NSTCROOTSTYLE, byval pif as IShellItemFilter ptr) as HRESULT
	RemoveRoot as function(byval This as INameSpaceTreeControl2 ptr, byval psiRoot as IShellItem ptr) as HRESULT
	RemoveAllRoots as function(byval This as INameSpaceTreeControl2 ptr) as HRESULT
	GetRootItems as function(byval This as INameSpaceTreeControl2 ptr, byval ppsiaRootItems as IShellItemArray ptr ptr) as HRESULT
	SetItemState as function(byval This as INameSpaceTreeControl2 ptr, byval psi as IShellItem ptr, byval nstcisMask as NSTCITEMSTATE, byval nstcisFlags as NSTCITEMSTATE) as HRESULT
	GetItemState as function(byval This as INameSpaceTreeControl2 ptr, byval psi as IShellItem ptr, byval nstcisMask as NSTCITEMSTATE, byval pnstcisFlags as NSTCITEMSTATE ptr) as HRESULT
	GetSelectedItems as function(byval This as INameSpaceTreeControl2 ptr, byval psiaItems as IShellItemArray ptr ptr) as HRESULT
	GetItemCustomState as function(byval This as INameSpaceTreeControl2 ptr, byval psi as IShellItem ptr, byval piStateNumber as long ptr) as HRESULT
	SetItemCustomState as function(byval This as INameSpaceTreeControl2 ptr, byval psi as IShellItem ptr, byval iStateNumber as long) as HRESULT
	EnsureItemVisible as function(byval This as INameSpaceTreeControl2 ptr, byval psi as IShellItem ptr) as HRESULT
	SetTheme as function(byval This as INameSpaceTreeControl2 ptr, byval pszTheme as LPCWSTR) as HRESULT
	GetNextItem as function(byval This as INameSpaceTreeControl2 ptr, byval psi as IShellItem ptr, byval nstcgi as NSTCGNI, byval ppsiNext as IShellItem ptr ptr) as HRESULT
	HitTest as function(byval This as INameSpaceTreeControl2 ptr, byval ppt as POINT ptr, byval ppsiOut as IShellItem ptr ptr) as HRESULT
	GetItemRect as function(byval This as INameSpaceTreeControl2 ptr, byval psi as IShellItem ptr, byval prect as RECT ptr) as HRESULT
	CollapseAll as function(byval This as INameSpaceTreeControl2 ptr) as HRESULT
	SetControlStyle as function(byval This as INameSpaceTreeControl2 ptr, byval nstcsMask as NSTCSTYLE, byval nstcsStyle as NSTCSTYLE) as HRESULT
	GetControlStyle as function(byval This as INameSpaceTreeControl2 ptr, byval nstcsMask as NSTCSTYLE, byval pnstcsStyle as NSTCSTYLE ptr) as HRESULT
	SetControlStyle2 as function(byval This as INameSpaceTreeControl2 ptr, byval nstcsMask as NSTCSTYLE2, byval nstcsStyle as NSTCSTYLE2) as HRESULT
	GetControlStyle2 as function(byval This as INameSpaceTreeControl2 ptr, byval nstcsMask as NSTCSTYLE2, byval pnstcsStyle as NSTCSTYLE2 ptr) as HRESULT
end type

type INameSpaceTreeControl2_
	lpVtbl as INameSpaceTreeControl2Vtbl ptr
end type

#define INameSpaceTreeControl2_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define INameSpaceTreeControl2_AddRef(This) (This)->lpVtbl->AddRef(This)
#define INameSpaceTreeControl2_Release(This) (This)->lpVtbl->Release(This)
#define INameSpaceTreeControl2_Initialize(This, hwndParent, prc, nsctsFlags) (This)->lpVtbl->Initialize(This, hwndParent, prc, nsctsFlags)
#define INameSpaceTreeControl2_TreeAdvise(This, punk, pdwCookie) (This)->lpVtbl->TreeAdvise(This, punk, pdwCookie)
#define INameSpaceTreeControl2_TreeUnadvise(This, dwCookie) (This)->lpVtbl->TreeUnadvise(This, dwCookie)
#define INameSpaceTreeControl2_AppendRoot(This, psiRoot, grfEnumFlags, grfRootStyle, pif) (This)->lpVtbl->AppendRoot(This, psiRoot, grfEnumFlags, grfRootStyle, pif)
#define INameSpaceTreeControl2_InsertRoot(This, iIndex, psiRoot, grfEnumFlags, grfRootStyle, pif) (This)->lpVtbl->InsertRoot(This, iIndex, psiRoot, grfEnumFlags, grfRootStyle, pif)
#define INameSpaceTreeControl2_RemoveRoot(This, psiRoot) (This)->lpVtbl->RemoveRoot(This, psiRoot)
#define INameSpaceTreeControl2_RemoveAllRoots(This) (This)->lpVtbl->RemoveAllRoots(This)
#define INameSpaceTreeControl2_GetRootItems(This, ppsiaRootItems) (This)->lpVtbl->GetRootItems(This, ppsiaRootItems)
#define INameSpaceTreeControl2_SetItemState(This, psi, nstcisMask, nstcisFlags) (This)->lpVtbl->SetItemState(This, psi, nstcisMask, nstcisFlags)
#define INameSpaceTreeControl2_GetItemState(This, psi, nstcisMask, pnstcisFlags) (This)->lpVtbl->GetItemState(This, psi, nstcisMask, pnstcisFlags)
#define INameSpaceTreeControl2_GetSelectedItems(This, psiaItems) (This)->lpVtbl->GetSelectedItems(This, psiaItems)
#define INameSpaceTreeControl2_GetItemCustomState(This, psi, piStateNumber) (This)->lpVtbl->GetItemCustomState(This, psi, piStateNumber)
#define INameSpaceTreeControl2_SetItemCustomState(This, psi, iStateNumber) (This)->lpVtbl->SetItemCustomState(This, psi, iStateNumber)
#define INameSpaceTreeControl2_EnsureItemVisible(This, psi) (This)->lpVtbl->EnsureItemVisible(This, psi)
#define INameSpaceTreeControl2_SetTheme(This, pszTheme) (This)->lpVtbl->SetTheme(This, pszTheme)
#define INameSpaceTreeControl2_GetNextItem(This, psi, nstcgi, ppsiNext) (This)->lpVtbl->GetNextItem(This, psi, nstcgi, ppsiNext)
#define INameSpaceTreeControl2_HitTest(This, ppt, ppsiOut) (This)->lpVtbl->HitTest(This, ppt, ppsiOut)
#define INameSpaceTreeControl2_GetItemRect(This, psi, prect) (This)->lpVtbl->GetItemRect(This, psi, prect)
#define INameSpaceTreeControl2_CollapseAll(This) (This)->lpVtbl->CollapseAll(This)
#define INameSpaceTreeControl2_SetControlStyle(This, nstcsMask, nstcsStyle) (This)->lpVtbl->SetControlStyle(This, nstcsMask, nstcsStyle)
#define INameSpaceTreeControl2_GetControlStyle(This, nstcsMask, pnstcsStyle) (This)->lpVtbl->GetControlStyle(This, nstcsMask, pnstcsStyle)
#define INameSpaceTreeControl2_SetControlStyle2(This, nstcsMask, nstcsStyle) (This)->lpVtbl->SetControlStyle2(This, nstcsMask, nstcsStyle)
#define INameSpaceTreeControl2_GetControlStyle2(This, nstcsMask, pnstcsStyle) (This)->lpVtbl->GetControlStyle2(This, nstcsMask, pnstcsStyle)

declare function INameSpaceTreeControl2_SetControlStyle_Proxy(byval This as INameSpaceTreeControl2 ptr, byval nstcsMask as NSTCSTYLE, byval nstcsStyle as NSTCSTYLE) as HRESULT
declare sub INameSpaceTreeControl2_SetControlStyle_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function INameSpaceTreeControl2_GetControlStyle_Proxy(byval This as INameSpaceTreeControl2 ptr, byval nstcsMask as NSTCSTYLE, byval pnstcsStyle as NSTCSTYLE ptr) as HRESULT
declare sub INameSpaceTreeControl2_GetControlStyle_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function INameSpaceTreeControl2_SetControlStyle2_Proxy(byval This as INameSpaceTreeControl2 ptr, byval nstcsMask as NSTCSTYLE2, byval nstcsStyle as NSTCSTYLE2) as HRESULT
declare sub INameSpaceTreeControl2_SetControlStyle2_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function INameSpaceTreeControl2_GetControlStyle2_Proxy(byval This as INameSpaceTreeControl2 ptr, byval nstcsMask as NSTCSTYLE2, byval pnstcsStyle as NSTCSTYLE2 ptr) as HRESULT
declare sub INameSpaceTreeControl2_GetControlStyle2_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
const NSTCS2_ALLMASK = (NSTCS2_INTERRUPTNOTIFICATIONS or NSTCS2_SHOWNULLSPACEMENU) or NSTCS2_DISPLAYPADDING
extern SID_SNavigationPane alias "IID_INameSpaceTreeControl" as const GUID

#define ISLBUTTON(x) (NSTCECT_LBUTTON = ((x) and NSTCECT_BUTTON))
#define ISMBUTTON(x) (NSTCECT_MBUTTON = ((x) and NSTCECT_BUTTON))
#define ISRBUTTON(x) (NSTCECT_RBUTTON = ((x) and NSTCECT_BUTTON))
#define ISDBLCLICK(x) (NSTCECT_DBLCLICK = ((x) and NSTCECT_DBLCLICK))
#define __INameSpaceTreeControlEvents_INTERFACE_DEFINED__

type _NSTCEHITTEST as long
enum
	NSTCEHT_NOWHERE = &h1
	NSTCEHT_ONITEMICON = &h2
	NSTCEHT_ONITEMLABEL = &h4
	NSTCEHT_ONITEMINDENT = &h8
	NSTCEHT_ONITEMBUTTON = &h10
	NSTCEHT_ONITEMRIGHT = &h20
	NSTCEHT_ONITEMSTATEICON = &h40
	NSTCEHT_ONITEM = &h46
	NSTCEHT_ONITEMTABBUTTON = &h1000
end enum

type NSTCEHITTEST as DWORD

type _NSTCECLICKTYPE as long
enum
	NSTCECT_LBUTTON = &h1
	NSTCECT_MBUTTON = &h2
	NSTCECT_RBUTTON = &h3
	NSTCECT_BUTTON = &h3
	NSTCECT_DBLCLICK = &h4
end enum

type NSTCECLICKTYPE as DWORD
extern IID_INameSpaceTreeControlEvents as const GUID
type INameSpaceTreeControlEvents as INameSpaceTreeControlEvents_

type INameSpaceTreeControlEventsVtbl
	QueryInterface as function(byval This as INameSpaceTreeControlEvents ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as INameSpaceTreeControlEvents ptr) as ULONG
	Release as function(byval This as INameSpaceTreeControlEvents ptr) as ULONG
	OnItemClick as function(byval This as INameSpaceTreeControlEvents ptr, byval psi as IShellItem ptr, byval nstceHitTest as NSTCEHITTEST, byval nstceClickType as NSTCECLICKTYPE) as HRESULT
	OnPropertyItemCommit as function(byval This as INameSpaceTreeControlEvents ptr, byval psi as IShellItem ptr) as HRESULT
	OnItemStateChanging as function(byval This as INameSpaceTreeControlEvents ptr, byval psi as IShellItem ptr, byval nstcisMask as NSTCITEMSTATE, byval nstcisState as NSTCITEMSTATE) as HRESULT
	OnItemStateChanged as function(byval This as INameSpaceTreeControlEvents ptr, byval psi as IShellItem ptr, byval nstcisMask as NSTCITEMSTATE, byval nstcisState as NSTCITEMSTATE) as HRESULT
	OnSelectionChanged as function(byval This as INameSpaceTreeControlEvents ptr, byval psiaSelection as IShellItemArray ptr) as HRESULT
	OnKeyboardInput as function(byval This as INameSpaceTreeControlEvents ptr, byval uMsg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as HRESULT
	OnBeforeExpand as function(byval This as INameSpaceTreeControlEvents ptr, byval psi as IShellItem ptr) as HRESULT
	OnAfterExpand as function(byval This as INameSpaceTreeControlEvents ptr, byval psi as IShellItem ptr) as HRESULT
	OnBeginLabelEdit as function(byval This as INameSpaceTreeControlEvents ptr, byval psi as IShellItem ptr) as HRESULT
	OnEndLabelEdit as function(byval This as INameSpaceTreeControlEvents ptr, byval psi as IShellItem ptr) as HRESULT
	OnGetToolTip as function(byval This as INameSpaceTreeControlEvents ptr, byval psi as IShellItem ptr, byval pszTip as LPWSTR, byval cchTip as long) as HRESULT
	OnBeforeItemDelete as function(byval This as INameSpaceTreeControlEvents ptr, byval psi as IShellItem ptr) as HRESULT
	OnItemAdded as function(byval This as INameSpaceTreeControlEvents ptr, byval psi as IShellItem ptr, byval fIsRoot as WINBOOL) as HRESULT
	OnItemDeleted as function(byval This as INameSpaceTreeControlEvents ptr, byval psi as IShellItem ptr, byval fIsRoot as WINBOOL) as HRESULT
	OnBeforeContextMenu as function(byval This as INameSpaceTreeControlEvents ptr, byval psi as IShellItem ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	OnAfterContextMenu as function(byval This as INameSpaceTreeControlEvents ptr, byval psi as IShellItem ptr, byval pcmIn as IContextMenu ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	OnBeforeStateImageChange as function(byval This as INameSpaceTreeControlEvents ptr, byval psi as IShellItem ptr) as HRESULT
	OnGetDefaultIconIndex as function(byval This as INameSpaceTreeControlEvents ptr, byval psi as IShellItem ptr, byval piDefaultIcon as long ptr, byval piOpenIcon as long ptr) as HRESULT
end type

type INameSpaceTreeControlEvents_
	lpVtbl as INameSpaceTreeControlEventsVtbl ptr
end type

#define INameSpaceTreeControlEvents_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define INameSpaceTreeControlEvents_AddRef(This) (This)->lpVtbl->AddRef(This)
#define INameSpaceTreeControlEvents_Release(This) (This)->lpVtbl->Release(This)
#define INameSpaceTreeControlEvents_OnItemClick(This, psi, nstceHitTest, nstceClickType) (This)->lpVtbl->OnItemClick(This, psi, nstceHitTest, nstceClickType)
#define INameSpaceTreeControlEvents_OnPropertyItemCommit(This, psi) (This)->lpVtbl->OnPropertyItemCommit(This, psi)
#define INameSpaceTreeControlEvents_OnItemStateChanging(This, psi, nstcisMask, nstcisState) (This)->lpVtbl->OnItemStateChanging(This, psi, nstcisMask, nstcisState)
#define INameSpaceTreeControlEvents_OnItemStateChanged(This, psi, nstcisMask, nstcisState) (This)->lpVtbl->OnItemStateChanged(This, psi, nstcisMask, nstcisState)
#define INameSpaceTreeControlEvents_OnSelectionChanged(This, psiaSelection) (This)->lpVtbl->OnSelectionChanged(This, psiaSelection)
#define INameSpaceTreeControlEvents_OnKeyboardInput(This, uMsg, wParam, lParam) (This)->lpVtbl->OnKeyboardInput(This, uMsg, wParam, lParam)
#define INameSpaceTreeControlEvents_OnBeforeExpand(This, psi) (This)->lpVtbl->OnBeforeExpand(This, psi)
#define INameSpaceTreeControlEvents_OnAfterExpand(This, psi) (This)->lpVtbl->OnAfterExpand(This, psi)
#define INameSpaceTreeControlEvents_OnBeginLabelEdit(This, psi) (This)->lpVtbl->OnBeginLabelEdit(This, psi)
#define INameSpaceTreeControlEvents_OnEndLabelEdit(This, psi) (This)->lpVtbl->OnEndLabelEdit(This, psi)
#define INameSpaceTreeControlEvents_OnGetToolTip(This, psi, pszTip, cchTip) (This)->lpVtbl->OnGetToolTip(This, psi, pszTip, cchTip)
#define INameSpaceTreeControlEvents_OnBeforeItemDelete(This, psi) (This)->lpVtbl->OnBeforeItemDelete(This, psi)
#define INameSpaceTreeControlEvents_OnItemAdded(This, psi, fIsRoot) (This)->lpVtbl->OnItemAdded(This, psi, fIsRoot)
#define INameSpaceTreeControlEvents_OnItemDeleted(This, psi, fIsRoot) (This)->lpVtbl->OnItemDeleted(This, psi, fIsRoot)
#define INameSpaceTreeControlEvents_OnBeforeContextMenu(This, psi, riid, ppv) (This)->lpVtbl->OnBeforeContextMenu(This, psi, riid, ppv)
#define INameSpaceTreeControlEvents_OnAfterContextMenu(This, psi, pcmIn, riid, ppv) (This)->lpVtbl->OnAfterContextMenu(This, psi, pcmIn, riid, ppv)
#define INameSpaceTreeControlEvents_OnBeforeStateImageChange(This, psi) (This)->lpVtbl->OnBeforeStateImageChange(This, psi)
#define INameSpaceTreeControlEvents_OnGetDefaultIconIndex(This, psi, piDefaultIcon, piOpenIcon) (This)->lpVtbl->OnGetDefaultIconIndex(This, psi, piDefaultIcon, piOpenIcon)

declare function INameSpaceTreeControlEvents_OnItemClick_Proxy(byval This as INameSpaceTreeControlEvents ptr, byval psi as IShellItem ptr, byval nstceHitTest as NSTCEHITTEST, byval nstceClickType as NSTCECLICKTYPE) as HRESULT
declare sub INameSpaceTreeControlEvents_OnItemClick_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function INameSpaceTreeControlEvents_OnPropertyItemCommit_Proxy(byval This as INameSpaceTreeControlEvents ptr, byval psi as IShellItem ptr) as HRESULT
declare sub INameSpaceTreeControlEvents_OnPropertyItemCommit_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function INameSpaceTreeControlEvents_OnItemStateChanging_Proxy(byval This as INameSpaceTreeControlEvents ptr, byval psi as IShellItem ptr, byval nstcisMask as NSTCITEMSTATE, byval nstcisState as NSTCITEMSTATE) as HRESULT
declare sub INameSpaceTreeControlEvents_OnItemStateChanging_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function INameSpaceTreeControlEvents_OnItemStateChanged_Proxy(byval This as INameSpaceTreeControlEvents ptr, byval psi as IShellItem ptr, byval nstcisMask as NSTCITEMSTATE, byval nstcisState as NSTCITEMSTATE) as HRESULT
declare sub INameSpaceTreeControlEvents_OnItemStateChanged_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function INameSpaceTreeControlEvents_OnSelectionChanged_Proxy(byval This as INameSpaceTreeControlEvents ptr, byval psiaSelection as IShellItemArray ptr) as HRESULT
declare sub INameSpaceTreeControlEvents_OnSelectionChanged_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function INameSpaceTreeControlEvents_OnKeyboardInput_Proxy(byval This as INameSpaceTreeControlEvents ptr, byval uMsg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as HRESULT
declare sub INameSpaceTreeControlEvents_OnKeyboardInput_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function INameSpaceTreeControlEvents_OnBeforeExpand_Proxy(byval This as INameSpaceTreeControlEvents ptr, byval psi as IShellItem ptr) as HRESULT
declare sub INameSpaceTreeControlEvents_OnBeforeExpand_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function INameSpaceTreeControlEvents_OnAfterExpand_Proxy(byval This as INameSpaceTreeControlEvents ptr, byval psi as IShellItem ptr) as HRESULT
declare sub INameSpaceTreeControlEvents_OnAfterExpand_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function INameSpaceTreeControlEvents_OnBeginLabelEdit_Proxy(byval This as INameSpaceTreeControlEvents ptr, byval psi as IShellItem ptr) as HRESULT
declare sub INameSpaceTreeControlEvents_OnBeginLabelEdit_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function INameSpaceTreeControlEvents_OnEndLabelEdit_Proxy(byval This as INameSpaceTreeControlEvents ptr, byval psi as IShellItem ptr) as HRESULT
declare sub INameSpaceTreeControlEvents_OnEndLabelEdit_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function INameSpaceTreeControlEvents_OnGetToolTip_Proxy(byval This as INameSpaceTreeControlEvents ptr, byval psi as IShellItem ptr, byval pszTip as LPWSTR, byval cchTip as long) as HRESULT
declare sub INameSpaceTreeControlEvents_OnGetToolTip_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function INameSpaceTreeControlEvents_OnBeforeItemDelete_Proxy(byval This as INameSpaceTreeControlEvents ptr, byval psi as IShellItem ptr) as HRESULT
declare sub INameSpaceTreeControlEvents_OnBeforeItemDelete_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function INameSpaceTreeControlEvents_OnItemAdded_Proxy(byval This as INameSpaceTreeControlEvents ptr, byval psi as IShellItem ptr, byval fIsRoot as WINBOOL) as HRESULT
declare sub INameSpaceTreeControlEvents_OnItemAdded_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function INameSpaceTreeControlEvents_OnItemDeleted_Proxy(byval This as INameSpaceTreeControlEvents ptr, byval psi as IShellItem ptr, byval fIsRoot as WINBOOL) as HRESULT
declare sub INameSpaceTreeControlEvents_OnItemDeleted_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function INameSpaceTreeControlEvents_OnBeforeContextMenu_Proxy(byval This as INameSpaceTreeControlEvents ptr, byval psi as IShellItem ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare sub INameSpaceTreeControlEvents_OnBeforeContextMenu_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function INameSpaceTreeControlEvents_OnAfterContextMenu_Proxy(byval This as INameSpaceTreeControlEvents ptr, byval psi as IShellItem ptr, byval pcmIn as IContextMenu ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare sub INameSpaceTreeControlEvents_OnAfterContextMenu_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function INameSpaceTreeControlEvents_OnBeforeStateImageChange_Proxy(byval This as INameSpaceTreeControlEvents ptr, byval psi as IShellItem ptr) as HRESULT
declare sub INameSpaceTreeControlEvents_OnBeforeStateImageChange_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function INameSpaceTreeControlEvents_OnGetDefaultIconIndex_Proxy(byval This as INameSpaceTreeControlEvents ptr, byval psi as IShellItem ptr, byval piDefaultIcon as long ptr, byval piOpenIcon as long ptr) as HRESULT
declare sub INameSpaceTreeControlEvents_OnGetDefaultIconIndex_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
const NSTCDHPOS_ONTOP = -1
#define __INameSpaceTreeControlDropHandler_INTERFACE_DEFINED__
extern IID_INameSpaceTreeControlDropHandler as const GUID
type INameSpaceTreeControlDropHandler as INameSpaceTreeControlDropHandler_

type INameSpaceTreeControlDropHandlerVtbl
	QueryInterface as function(byval This as INameSpaceTreeControlDropHandler ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as INameSpaceTreeControlDropHandler ptr) as ULONG
	Release as function(byval This as INameSpaceTreeControlDropHandler ptr) as ULONG
	OnDragEnter as function(byval This as INameSpaceTreeControlDropHandler ptr, byval psiOver as IShellItem ptr, byval psiaData as IShellItemArray ptr, byval fOutsideSource as WINBOOL, byval grfKeyState as DWORD, byval pdwEffect as DWORD ptr) as HRESULT
	OnDragOver as function(byval This as INameSpaceTreeControlDropHandler ptr, byval psiOver as IShellItem ptr, byval psiaData as IShellItemArray ptr, byval grfKeyState as DWORD, byval pdwEffect as DWORD ptr) as HRESULT
	OnDragPosition as function(byval This as INameSpaceTreeControlDropHandler ptr, byval psiOver as IShellItem ptr, byval psiaData as IShellItemArray ptr, byval iNewPosition as long, byval iOldPosition as long) as HRESULT
	OnDrop as function(byval This as INameSpaceTreeControlDropHandler ptr, byval psiOver as IShellItem ptr, byval psiaData as IShellItemArray ptr, byval iPosition as long, byval grfKeyState as DWORD, byval pdwEffect as DWORD ptr) as HRESULT
	OnDropPosition as function(byval This as INameSpaceTreeControlDropHandler ptr, byval psiOver as IShellItem ptr, byval psiaData as IShellItemArray ptr, byval iNewPosition as long, byval iOldPosition as long) as HRESULT
	OnDragLeave as function(byval This as INameSpaceTreeControlDropHandler ptr, byval psiOver as IShellItem ptr) as HRESULT
end type

type INameSpaceTreeControlDropHandler_
	lpVtbl as INameSpaceTreeControlDropHandlerVtbl ptr
end type

#define INameSpaceTreeControlDropHandler_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define INameSpaceTreeControlDropHandler_AddRef(This) (This)->lpVtbl->AddRef(This)
#define INameSpaceTreeControlDropHandler_Release(This) (This)->lpVtbl->Release(This)
#define INameSpaceTreeControlDropHandler_OnDragEnter(This, psiOver, psiaData, fOutsideSource, grfKeyState, pdwEffect) (This)->lpVtbl->OnDragEnter(This, psiOver, psiaData, fOutsideSource, grfKeyState, pdwEffect)
#define INameSpaceTreeControlDropHandler_OnDragOver(This, psiOver, psiaData, grfKeyState, pdwEffect) (This)->lpVtbl->OnDragOver(This, psiOver, psiaData, grfKeyState, pdwEffect)
#define INameSpaceTreeControlDropHandler_OnDragPosition(This, psiOver, psiaData, iNewPosition, iOldPosition) (This)->lpVtbl->OnDragPosition(This, psiOver, psiaData, iNewPosition, iOldPosition)
#define INameSpaceTreeControlDropHandler_OnDrop(This, psiOver, psiaData, iPosition, grfKeyState, pdwEffect) (This)->lpVtbl->OnDrop(This, psiOver, psiaData, iPosition, grfKeyState, pdwEffect)
#define INameSpaceTreeControlDropHandler_OnDropPosition(This, psiOver, psiaData, iNewPosition, iOldPosition) (This)->lpVtbl->OnDropPosition(This, psiOver, psiaData, iNewPosition, iOldPosition)
#define INameSpaceTreeControlDropHandler_OnDragLeave(This, psiOver) (This)->lpVtbl->OnDragLeave(This, psiOver)

declare function INameSpaceTreeControlDropHandler_OnDragEnter_Proxy(byval This as INameSpaceTreeControlDropHandler ptr, byval psiOver as IShellItem ptr, byval psiaData as IShellItemArray ptr, byval fOutsideSource as WINBOOL, byval grfKeyState as DWORD, byval pdwEffect as DWORD ptr) as HRESULT
declare sub INameSpaceTreeControlDropHandler_OnDragEnter_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function INameSpaceTreeControlDropHandler_OnDragOver_Proxy(byval This as INameSpaceTreeControlDropHandler ptr, byval psiOver as IShellItem ptr, byval psiaData as IShellItemArray ptr, byval grfKeyState as DWORD, byval pdwEffect as DWORD ptr) as HRESULT
declare sub INameSpaceTreeControlDropHandler_OnDragOver_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function INameSpaceTreeControlDropHandler_OnDragPosition_Proxy(byval This as INameSpaceTreeControlDropHandler ptr, byval psiOver as IShellItem ptr, byval psiaData as IShellItemArray ptr, byval iNewPosition as long, byval iOldPosition as long) as HRESULT
declare sub INameSpaceTreeControlDropHandler_OnDragPosition_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function INameSpaceTreeControlDropHandler_OnDrop_Proxy(byval This as INameSpaceTreeControlDropHandler ptr, byval psiOver as IShellItem ptr, byval psiaData as IShellItemArray ptr, byval iPosition as long, byval grfKeyState as DWORD, byval pdwEffect as DWORD ptr) as HRESULT
declare sub INameSpaceTreeControlDropHandler_OnDrop_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function INameSpaceTreeControlDropHandler_OnDropPosition_Proxy(byval This as INameSpaceTreeControlDropHandler ptr, byval psiOver as IShellItem ptr, byval psiaData as IShellItemArray ptr, byval iNewPosition as long, byval iOldPosition as long) as HRESULT
declare sub INameSpaceTreeControlDropHandler_OnDropPosition_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function INameSpaceTreeControlDropHandler_OnDragLeave_Proxy(byval This as INameSpaceTreeControlDropHandler ptr, byval psiOver as IShellItem ptr) as HRESULT
declare sub INameSpaceTreeControlDropHandler_OnDragLeave_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __INameSpaceTreeAccessible_INTERFACE_DEFINED__
extern IID_INameSpaceTreeAccessible as const GUID
type INameSpaceTreeAccessible as INameSpaceTreeAccessible_

type INameSpaceTreeAccessibleVtbl
	QueryInterface as function(byval This as INameSpaceTreeAccessible ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as INameSpaceTreeAccessible ptr) as ULONG
	Release as function(byval This as INameSpaceTreeAccessible ptr) as ULONG
	OnGetDefaultAccessibilityAction as function(byval This as INameSpaceTreeAccessible ptr, byval psi as IShellItem ptr, byval pbstrDefaultAction as BSTR ptr) as HRESULT
	OnDoDefaultAccessibilityAction as function(byval This as INameSpaceTreeAccessible ptr, byval psi as IShellItem ptr) as HRESULT
	OnGetAccessibilityRole as function(byval This as INameSpaceTreeAccessible ptr, byval psi as IShellItem ptr, byval pvarRole as VARIANT ptr) as HRESULT
end type

type INameSpaceTreeAccessible_
	lpVtbl as INameSpaceTreeAccessibleVtbl ptr
end type

#define INameSpaceTreeAccessible_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define INameSpaceTreeAccessible_AddRef(This) (This)->lpVtbl->AddRef(This)
#define INameSpaceTreeAccessible_Release(This) (This)->lpVtbl->Release(This)
#define INameSpaceTreeAccessible_OnGetDefaultAccessibilityAction(This, psi, pbstrDefaultAction) (This)->lpVtbl->OnGetDefaultAccessibilityAction(This, psi, pbstrDefaultAction)
#define INameSpaceTreeAccessible_OnDoDefaultAccessibilityAction(This, psi) (This)->lpVtbl->OnDoDefaultAccessibilityAction(This, psi)
#define INameSpaceTreeAccessible_OnGetAccessibilityRole(This, psi, pvarRole) (This)->lpVtbl->OnGetAccessibilityRole(This, psi, pvarRole)

declare function INameSpaceTreeAccessible_OnGetDefaultAccessibilityAction_Proxy(byval This as INameSpaceTreeAccessible ptr, byval psi as IShellItem ptr, byval pbstrDefaultAction as BSTR ptr) as HRESULT
declare sub INameSpaceTreeAccessible_OnGetDefaultAccessibilityAction_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function INameSpaceTreeAccessible_OnDoDefaultAccessibilityAction_Proxy(byval This as INameSpaceTreeAccessible ptr, byval psi as IShellItem ptr) as HRESULT
declare sub INameSpaceTreeAccessible_OnDoDefaultAccessibilityAction_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function INameSpaceTreeAccessible_OnGetAccessibilityRole_Proxy(byval This as INameSpaceTreeAccessible ptr, byval psi as IShellItem ptr, byval pvarRole as VARIANT ptr) as HRESULT
declare sub INameSpaceTreeAccessible_OnGetAccessibilityRole_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __INameSpaceTreeControlCustomDraw_INTERFACE_DEFINED__

type NSTCCUSTOMDRAW
	psi as IShellItem ptr
	uItemState as UINT
	nstcis as NSTCITEMSTATE
	pszText as LPCWSTR
	iImage as long
	himl as HIMAGELIST
	iLevel as long
	iIndent as long
end type

extern IID_INameSpaceTreeControlCustomDraw as const GUID
type INameSpaceTreeControlCustomDraw as INameSpaceTreeControlCustomDraw_

type INameSpaceTreeControlCustomDrawVtbl
	QueryInterface as function(byval This as INameSpaceTreeControlCustomDraw ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as INameSpaceTreeControlCustomDraw ptr) as ULONG
	Release as function(byval This as INameSpaceTreeControlCustomDraw ptr) as ULONG
	PrePaint as function(byval This as INameSpaceTreeControlCustomDraw ptr, byval hdc as HDC, byval prc as RECT ptr, byval plres as LRESULT ptr) as HRESULT
	PostPaint as function(byval This as INameSpaceTreeControlCustomDraw ptr, byval hdc as HDC, byval prc as RECT ptr) as HRESULT
	ItemPrePaint as function(byval This as INameSpaceTreeControlCustomDraw ptr, byval hdc as HDC, byval prc as RECT ptr, byval pnstccdItem as NSTCCUSTOMDRAW ptr, byval pclrText as COLORREF ptr, byval pclrTextBk as COLORREF ptr, byval plres as LRESULT ptr) as HRESULT
	ItemPostPaint as function(byval This as INameSpaceTreeControlCustomDraw ptr, byval hdc as HDC, byval prc as RECT ptr, byval pnstccdItem as NSTCCUSTOMDRAW ptr) as HRESULT
end type

type INameSpaceTreeControlCustomDraw_
	lpVtbl as INameSpaceTreeControlCustomDrawVtbl ptr
end type

#define INameSpaceTreeControlCustomDraw_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define INameSpaceTreeControlCustomDraw_AddRef(This) (This)->lpVtbl->AddRef(This)
#define INameSpaceTreeControlCustomDraw_Release(This) (This)->lpVtbl->Release(This)
#define INameSpaceTreeControlCustomDraw_PrePaint(This, hdc, prc, plres) (This)->lpVtbl->PrePaint(This, hdc, prc, plres)
#define INameSpaceTreeControlCustomDraw_PostPaint(This, hdc, prc) (This)->lpVtbl->PostPaint(This, hdc, prc)
#define INameSpaceTreeControlCustomDraw_ItemPrePaint(This, hdc, prc, pnstccdItem, pclrText, pclrTextBk, plres) (This)->lpVtbl->ItemPrePaint(This, hdc, prc, pnstccdItem, pclrText, pclrTextBk, plres)
#define INameSpaceTreeControlCustomDraw_ItemPostPaint(This, hdc, prc, pnstccdItem) (This)->lpVtbl->ItemPostPaint(This, hdc, prc, pnstccdItem)

declare function INameSpaceTreeControlCustomDraw_PrePaint_Proxy(byval This as INameSpaceTreeControlCustomDraw ptr, byval hdc as HDC, byval prc as RECT ptr, byval plres as LRESULT ptr) as HRESULT
declare sub INameSpaceTreeControlCustomDraw_PrePaint_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function INameSpaceTreeControlCustomDraw_PostPaint_Proxy(byval This as INameSpaceTreeControlCustomDraw ptr, byval hdc as HDC, byval prc as RECT ptr) as HRESULT
declare sub INameSpaceTreeControlCustomDraw_PostPaint_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function INameSpaceTreeControlCustomDraw_ItemPrePaint_Proxy(byval This as INameSpaceTreeControlCustomDraw ptr, byval hdc as HDC, byval prc as RECT ptr, byval pnstccdItem as NSTCCUSTOMDRAW ptr, byval pclrText as COLORREF ptr, byval pclrTextBk as COLORREF ptr, byval plres as LRESULT ptr) as HRESULT
declare sub INameSpaceTreeControlCustomDraw_ItemPrePaint_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function INameSpaceTreeControlCustomDraw_ItemPostPaint_Proxy(byval This as INameSpaceTreeControlCustomDraw ptr, byval hdc as HDC, byval prc as RECT ptr, byval pnstccdItem as NSTCCUSTOMDRAW ptr) as HRESULT
declare sub INameSpaceTreeControlCustomDraw_ItemPostPaint_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#if _WIN32_WINNT >= &h0600
	#define __INameSpaceTreeControlFolderCapabilities_INTERFACE_DEFINED__

	type NSTCFOLDERCAPABILITIES as long
	enum
		NSTCFC_NONE = &h0
		NSTCFC_PINNEDITEMFILTERING = &h1
		NSTCFC_DELAY_REGISTER_NOTIFY = &h2
	end enum

	extern IID_INameSpaceTreeControlFolderCapabilities as const GUID
	type INameSpaceTreeControlFolderCapabilities as INameSpaceTreeControlFolderCapabilities_

	type INameSpaceTreeControlFolderCapabilitiesVtbl
		QueryInterface as function(byval This as INameSpaceTreeControlFolderCapabilities ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as INameSpaceTreeControlFolderCapabilities ptr) as ULONG
		Release as function(byval This as INameSpaceTreeControlFolderCapabilities ptr) as ULONG
		GetFolderCapabilities as function(byval This as INameSpaceTreeControlFolderCapabilities ptr, byval nfcMask as NSTCFOLDERCAPABILITIES, byval pnfcValue as NSTCFOLDERCAPABILITIES ptr) as HRESULT
	end type

	type INameSpaceTreeControlFolderCapabilities_
		lpVtbl as INameSpaceTreeControlFolderCapabilitiesVtbl ptr
	end type

	#define INameSpaceTreeControlFolderCapabilities_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define INameSpaceTreeControlFolderCapabilities_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define INameSpaceTreeControlFolderCapabilities_Release(This) (This)->lpVtbl->Release(This)
	#define INameSpaceTreeControlFolderCapabilities_GetFolderCapabilities(This, nfcMask, pnfcValue) (This)->lpVtbl->GetFolderCapabilities(This, nfcMask, pnfcValue)
	declare function INameSpaceTreeControlFolderCapabilities_GetFolderCapabilities_Proxy(byval This as INameSpaceTreeControlFolderCapabilities ptr, byval nfcMask as NSTCFOLDERCAPABILITIES, byval pnfcValue as NSTCFOLDERCAPABILITIES ptr) as HRESULT
	declare sub INameSpaceTreeControlFolderCapabilities_GetFolderCapabilities_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#endif

#define E_PREVIEWHANDLER_DRM_FAIL _HRESULT_TYPEDEF_(&h86420001)
#define E_PREVIEWHANDLER_NOAUTH _HRESULT_TYPEDEF_(&h86420002)
#define E_PREVIEWHANDLER_NOTFOUND _HRESULT_TYPEDEF_(&h86420003)
#define E_PREVIEWHANDLER_CORRUPT _HRESULT_TYPEDEF_(&h86420004)
#define __IPreviewHandler_INTERFACE_DEFINED__
extern IID_IPreviewHandler as const GUID
type IPreviewHandler as IPreviewHandler_

type IPreviewHandlerVtbl
	QueryInterface as function(byval This as IPreviewHandler ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPreviewHandler ptr) as ULONG
	Release as function(byval This as IPreviewHandler ptr) as ULONG
	SetWindow as function(byval This as IPreviewHandler ptr, byval hwnd as HWND, byval prc as const RECT ptr) as HRESULT
	SetRect as function(byval This as IPreviewHandler ptr, byval prc as const RECT ptr) as HRESULT
	DoPreview as function(byval This as IPreviewHandler ptr) as HRESULT
	Unload as function(byval This as IPreviewHandler ptr) as HRESULT
	SetFocus as function(byval This as IPreviewHandler ptr) as HRESULT
	QueryFocus as function(byval This as IPreviewHandler ptr, byval phwnd as HWND ptr) as HRESULT
	TranslateAccelerator as function(byval This as IPreviewHandler ptr, byval pmsg as MSG ptr) as HRESULT
end type

type IPreviewHandler_
	lpVtbl as IPreviewHandlerVtbl ptr
end type

#define IPreviewHandler_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IPreviewHandler_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IPreviewHandler_Release(This) (This)->lpVtbl->Release(This)
#define IPreviewHandler_SetWindow(This, hwnd, prc) (This)->lpVtbl->SetWindow(This, hwnd, prc)
#define IPreviewHandler_SetRect(This, prc) (This)->lpVtbl->SetRect(This, prc)
#define IPreviewHandler_DoPreview(This) (This)->lpVtbl->DoPreview(This)
#define IPreviewHandler_Unload(This) (This)->lpVtbl->Unload(This)
#define IPreviewHandler_SetFocus(This) (This)->lpVtbl->SetFocus(This)
#define IPreviewHandler_QueryFocus(This, phwnd) (This)->lpVtbl->QueryFocus(This, phwnd)
#define IPreviewHandler_TranslateAccelerator(This, pmsg) (This)->lpVtbl->TranslateAccelerator(This, pmsg)

declare function IPreviewHandler_SetWindow_Proxy(byval This as IPreviewHandler ptr, byval hwnd as HWND, byval prc as const RECT ptr) as HRESULT
declare sub IPreviewHandler_SetWindow_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPreviewHandler_SetRect_Proxy(byval This as IPreviewHandler ptr, byval prc as const RECT ptr) as HRESULT
declare sub IPreviewHandler_SetRect_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPreviewHandler_DoPreview_Proxy(byval This as IPreviewHandler ptr) as HRESULT
declare sub IPreviewHandler_DoPreview_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPreviewHandler_Unload_Proxy(byval This as IPreviewHandler ptr) as HRESULT
declare sub IPreviewHandler_Unload_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPreviewHandler_SetFocus_Proxy(byval This as IPreviewHandler ptr) as HRESULT
declare sub IPreviewHandler_SetFocus_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPreviewHandler_QueryFocus_Proxy(byval This as IPreviewHandler ptr, byval phwnd as HWND ptr) as HRESULT
declare sub IPreviewHandler_QueryFocus_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPreviewHandler_TranslateAccelerator_Proxy(byval This as IPreviewHandler ptr, byval pmsg as MSG ptr) as HRESULT
declare sub IPreviewHandler_TranslateAccelerator_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IPreviewHandlerFrame_INTERFACE_DEFINED__

type PREVIEWHANDLERFRAMEINFO
	haccel as HACCEL
	cAccelEntries as UINT
end type

extern IID_IPreviewHandlerFrame as const GUID
type IPreviewHandlerFrame as IPreviewHandlerFrame_

type IPreviewHandlerFrameVtbl
	QueryInterface as function(byval This as IPreviewHandlerFrame ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPreviewHandlerFrame ptr) as ULONG
	Release as function(byval This as IPreviewHandlerFrame ptr) as ULONG
	GetWindowContext as function(byval This as IPreviewHandlerFrame ptr, byval pinfo as PREVIEWHANDLERFRAMEINFO ptr) as HRESULT
	TranslateAccelerator as function(byval This as IPreviewHandlerFrame ptr, byval pmsg as MSG ptr) as HRESULT
end type

type IPreviewHandlerFrame_
	lpVtbl as IPreviewHandlerFrameVtbl ptr
end type

#define IPreviewHandlerFrame_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IPreviewHandlerFrame_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IPreviewHandlerFrame_Release(This) (This)->lpVtbl->Release(This)
#define IPreviewHandlerFrame_GetWindowContext(This, pinfo) (This)->lpVtbl->GetWindowContext(This, pinfo)
#define IPreviewHandlerFrame_TranslateAccelerator(This, pmsg) (This)->lpVtbl->TranslateAccelerator(This, pmsg)

declare function IPreviewHandlerFrame_GetWindowContext_Proxy(byval This as IPreviewHandlerFrame ptr, byval pinfo as PREVIEWHANDLERFRAMEINFO ptr) as HRESULT
declare sub IPreviewHandlerFrame_GetWindowContext_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPreviewHandlerFrame_TranslateAccelerator_Proxy(byval This as IPreviewHandlerFrame ptr, byval pmsg as MSG ptr) as HRESULT
declare sub IPreviewHandlerFrame_TranslateAccelerator_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

type IContextMenuCB as IContextMenuCB_

#if _WIN32_WINNT >= &h0600
	#define __ITrayDeskBand_INTERFACE_DEFINED__
	extern IID_ITrayDeskBand as const GUID
	type ITrayDeskBand as ITrayDeskBand_

	type ITrayDeskBandVtbl
		QueryInterface as function(byval This as ITrayDeskBand ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as ITrayDeskBand ptr) as ULONG
		Release as function(byval This as ITrayDeskBand ptr) as ULONG
		ShowDeskBand as function(byval This as ITrayDeskBand ptr, byval clsid as const IID const ptr) as HRESULT
		HideDeskBand as function(byval This as ITrayDeskBand ptr, byval clsid as const IID const ptr) as HRESULT
		IsDeskBandShown as function(byval This as ITrayDeskBand ptr, byval clsid as const IID const ptr) as HRESULT
		DeskBandRegistrationChanged as function(byval This as ITrayDeskBand ptr) as HRESULT
	end type

	type ITrayDeskBand_
		lpVtbl as ITrayDeskBandVtbl ptr
	end type

	#define ITrayDeskBand_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define ITrayDeskBand_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define ITrayDeskBand_Release(This) (This)->lpVtbl->Release(This)
	#define ITrayDeskBand_ShowDeskBand(This, clsid) (This)->lpVtbl->ShowDeskBand(This, clsid)
	#define ITrayDeskBand_HideDeskBand(This, clsid) (This)->lpVtbl->HideDeskBand(This, clsid)
	#define ITrayDeskBand_IsDeskBandShown(This, clsid) (This)->lpVtbl->IsDeskBandShown(This, clsid)
	#define ITrayDeskBand_DeskBandRegistrationChanged(This) (This)->lpVtbl->DeskBandRegistrationChanged(This)

	declare function ITrayDeskBand_ShowDeskBand_Proxy(byval This as ITrayDeskBand ptr, byval clsid as const IID const ptr) as HRESULT
	declare sub ITrayDeskBand_ShowDeskBand_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function ITrayDeskBand_HideDeskBand_Proxy(byval This as ITrayDeskBand ptr, byval clsid as const IID const ptr) as HRESULT
	declare sub ITrayDeskBand_HideDeskBand_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function ITrayDeskBand_IsDeskBandShown_Proxy(byval This as ITrayDeskBand ptr, byval clsid as const IID const ptr) as HRESULT
	declare sub ITrayDeskBand_IsDeskBandShown_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function ITrayDeskBand_DeskBandRegistrationChanged_Proxy(byval This as ITrayDeskBand ptr) as HRESULT
	declare sub ITrayDeskBand_DeskBandRegistrationChanged_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	#define __IBandHost_INTERFACE_DEFINED__
	extern IID_IBandHost as const GUID
	type IBandHost as IBandHost_

	type IBandHostVtbl
		QueryInterface as function(byval This as IBandHost ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IBandHost ptr) as ULONG
		Release as function(byval This as IBandHost ptr) as ULONG
		CreateBand as function(byval This as IBandHost ptr, byval rclsidBand as const IID const ptr, byval fAvailable as WINBOOL, byval fVisible as WINBOOL, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
		SetBandAvailability as function(byval This as IBandHost ptr, byval rclsidBand as const IID const ptr, byval fAvailable as WINBOOL) as HRESULT
		DestroyBand as function(byval This as IBandHost ptr, byval rclsidBand as const IID const ptr) as HRESULT
	end type

	type IBandHost_
		lpVtbl as IBandHostVtbl ptr
	end type

	#define IBandHost_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IBandHost_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IBandHost_Release(This) (This)->lpVtbl->Release(This)
	#define IBandHost_CreateBand(This, rclsidBand, fAvailable, fVisible, riid, ppv) (This)->lpVtbl->CreateBand(This, rclsidBand, fAvailable, fVisible, riid, ppv)
	#define IBandHost_SetBandAvailability(This, rclsidBand, fAvailable) (This)->lpVtbl->SetBandAvailability(This, rclsidBand, fAvailable)
	#define IBandHost_DestroyBand(This, rclsidBand) (This)->lpVtbl->DestroyBand(This, rclsidBand)

	declare function IBandHost_CreateBand_Proxy(byval This as IBandHost ptr, byval rclsidBand as const IID const ptr, byval fAvailable as WINBOOL, byval fVisible as WINBOOL, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	declare sub IBandHost_CreateBand_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IBandHost_SetBandAvailability_Proxy(byval This as IBandHost ptr, byval rclsidBand as const IID const ptr, byval fAvailable as WINBOOL) as HRESULT
	declare sub IBandHost_SetBandAvailability_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IBandHost_DestroyBand_Proxy(byval This as IBandHost ptr, byval rclsidBand as const IID const ptr) as HRESULT
	declare sub IBandHost_DestroyBand_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	extern SID_SBandHost alias "IID_IBandHost" as const GUID
	type EXPLORERPANE as GUID
	type REFEXPLORERPANE as const EXPLORERPANE const ptr
	#define __IExplorerPaneVisibility_INTERFACE_DEFINED__

	type _EXPLORERPANESTATE as long
	enum
		EPS_DONTCARE = &h0
		EPS_DEFAULT_ON = &h1
		EPS_DEFAULT_OFF = &h2
		EPS_STATEMASK = &hffff
		EPS_INITIALSTATE = &h10000
		EPS_FORCE = &h20000
	end enum

	type EXPLORERPANESTATE as DWORD
	extern IID_IExplorerPaneVisibility as const GUID
	type IExplorerPaneVisibility as IExplorerPaneVisibility_

	type IExplorerPaneVisibilityVtbl
		QueryInterface as function(byval This as IExplorerPaneVisibility ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IExplorerPaneVisibility ptr) as ULONG
		Release as function(byval This as IExplorerPaneVisibility ptr) as ULONG
		GetPaneState as function(byval This as IExplorerPaneVisibility ptr, byval ep as const EXPLORERPANE const ptr, byval peps as EXPLORERPANESTATE ptr) as HRESULT
	end type

	type IExplorerPaneVisibility_
		lpVtbl as IExplorerPaneVisibilityVtbl ptr
	end type

	#define IExplorerPaneVisibility_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IExplorerPaneVisibility_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IExplorerPaneVisibility_Release(This) (This)->lpVtbl->Release(This)
	#define IExplorerPaneVisibility_GetPaneState(This, ep, peps) (This)->lpVtbl->GetPaneState(This, ep, peps)
	declare function IExplorerPaneVisibility_GetPaneState_Proxy(byval This as IExplorerPaneVisibility ptr, byval ep as const EXPLORERPANE const ptr, byval peps as EXPLORERPANESTATE ptr) as HRESULT
	declare sub IExplorerPaneVisibility_GetPaneState_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	extern SID_ExplorerPaneVisibility alias "IID_IExplorerPaneVisibility" as const GUID
	#define __IContextMenuCB_INTERFACE_DEFINED__
	extern IID_IContextMenuCB as const GUID

	type IContextMenuCBVtbl
		QueryInterface as function(byval This as IContextMenuCB ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IContextMenuCB ptr) as ULONG
		Release as function(byval This as IContextMenuCB ptr) as ULONG
		CallBack as function(byval This as IContextMenuCB ptr, byval psf as IShellFolder ptr, byval hwndOwner as HWND, byval pdtobj as IDataObject ptr, byval uMsg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as HRESULT
	end type

	type IContextMenuCB_
		lpVtbl as IContextMenuCBVtbl ptr
	end type

	#define IContextMenuCB_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IContextMenuCB_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IContextMenuCB_Release(This) (This)->lpVtbl->Release(This)
	#define IContextMenuCB_CallBack(This, psf, hwndOwner, pdtobj, uMsg, wParam, lParam) (This)->lpVtbl->CallBack(This, psf, hwndOwner, pdtobj, uMsg, wParam, lParam)
	declare function IContextMenuCB_CallBack_Proxy(byval This as IContextMenuCB ptr, byval psf as IShellFolder ptr, byval hwndOwner as HWND, byval pdtobj as IDataObject ptr, byval uMsg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as HRESULT
	declare sub IContextMenuCB_CallBack_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#endif

#define __IDefaultExtractIconInit_INTERFACE_DEFINED__
extern IID_IDefaultExtractIconInit as const GUID
type IDefaultExtractIconInit as IDefaultExtractIconInit_

type IDefaultExtractIconInitVtbl
	QueryInterface as function(byval This as IDefaultExtractIconInit ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDefaultExtractIconInit ptr) as ULONG
	Release as function(byval This as IDefaultExtractIconInit ptr) as ULONG
	SetFlags as function(byval This as IDefaultExtractIconInit ptr, byval uFlags as UINT) as HRESULT
	SetKey as function(byval This as IDefaultExtractIconInit ptr, byval hkey as HKEY) as HRESULT
	SetNormalIcon as function(byval This as IDefaultExtractIconInit ptr, byval pszFile as LPCWSTR, byval iIcon as long) as HRESULT
	SetOpenIcon as function(byval This as IDefaultExtractIconInit ptr, byval pszFile as LPCWSTR, byval iIcon as long) as HRESULT
	SetShortcutIcon as function(byval This as IDefaultExtractIconInit ptr, byval pszFile as LPCWSTR, byval iIcon as long) as HRESULT
	SetDefaultIcon as function(byval This as IDefaultExtractIconInit ptr, byval pszFile as LPCWSTR, byval iIcon as long) as HRESULT
end type

type IDefaultExtractIconInit_
	lpVtbl as IDefaultExtractIconInitVtbl ptr
end type

#define IDefaultExtractIconInit_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IDefaultExtractIconInit_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IDefaultExtractIconInit_Release(This) (This)->lpVtbl->Release(This)
#define IDefaultExtractIconInit_SetFlags(This, uFlags) (This)->lpVtbl->SetFlags(This, uFlags)
#define IDefaultExtractIconInit_SetKey(This, hkey) (This)->lpVtbl->SetKey(This, hkey)
#define IDefaultExtractIconInit_SetNormalIcon(This, pszFile, iIcon) (This)->lpVtbl->SetNormalIcon(This, pszFile, iIcon)
#define IDefaultExtractIconInit_SetOpenIcon(This, pszFile, iIcon) (This)->lpVtbl->SetOpenIcon(This, pszFile, iIcon)
#define IDefaultExtractIconInit_SetShortcutIcon(This, pszFile, iIcon) (This)->lpVtbl->SetShortcutIcon(This, pszFile, iIcon)
#define IDefaultExtractIconInit_SetDefaultIcon(This, pszFile, iIcon) (This)->lpVtbl->SetDefaultIcon(This, pszFile, iIcon)

declare function IDefaultExtractIconInit_SetFlags_Proxy(byval This as IDefaultExtractIconInit ptr, byval uFlags as UINT) as HRESULT
declare sub IDefaultExtractIconInit_SetFlags_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDefaultExtractIconInit_SetKey_Proxy(byval This as IDefaultExtractIconInit ptr, byval hkey as HKEY) as HRESULT
declare sub IDefaultExtractIconInit_SetKey_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDefaultExtractIconInit_SetNormalIcon_Proxy(byval This as IDefaultExtractIconInit ptr, byval pszFile as LPCWSTR, byval iIcon as long) as HRESULT
declare sub IDefaultExtractIconInit_SetNormalIcon_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDefaultExtractIconInit_SetOpenIcon_Proxy(byval This as IDefaultExtractIconInit ptr, byval pszFile as LPCWSTR, byval iIcon as long) as HRESULT
declare sub IDefaultExtractIconInit_SetOpenIcon_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDefaultExtractIconInit_SetShortcutIcon_Proxy(byval This as IDefaultExtractIconInit ptr, byval pszFile as LPCWSTR, byval iIcon as long) as HRESULT
declare sub IDefaultExtractIconInit_SetShortcutIcon_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDefaultExtractIconInit_SetDefaultIcon_Proxy(byval This as IDefaultExtractIconInit ptr, byval pszFile as LPCWSTR, byval iIcon as long) as HRESULT
declare sub IDefaultExtractIconInit_SetDefaultIcon_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function SHCreateDefaultExtractIcon(byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
#define __IExplorerCommand_INTERFACE_DEFINED__

type _EXPCMDSTATE as long
enum
	ECS_ENABLED = &h0
	ECS_DISABLED = &h1
	ECS_HIDDEN = &h2
	ECS_CHECKBOX = &h4
	ECS_CHECKED = &h8
	ECS_RADIOCHECK = &h10
end enum

type EXPCMDSTATE as DWORD

type _EXPCMDFLAGS as long
enum
	ECF_DEFAULT = &h0
	ECF_HASSUBCOMMANDS = &h1
	ECF_HASSPLITBUTTON = &h2
	ECF_HIDELABEL = &h4
	ECF_ISSEPARATOR = &h8
	ECF_HASLUASHIELD = &h10
	ECF_SEPARATORBEFORE = &h20
	ECF_SEPARATORAFTER = &h40
	ECF_ISDROPDOWN = &h80
	ECF_TOGGLEABLE = &h100
	ECF_AUTOMENUICONS = &h200
end enum

type EXPCMDFLAGS as DWORD
extern IID_IExplorerCommand as const GUID
type IExplorerCommand as IExplorerCommand_
type IEnumExplorerCommand as IEnumExplorerCommand_

type IExplorerCommandVtbl
	QueryInterface as function(byval This as IExplorerCommand ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IExplorerCommand ptr) as ULONG
	Release as function(byval This as IExplorerCommand ptr) as ULONG
	GetTitle as function(byval This as IExplorerCommand ptr, byval psiItemArray as IShellItemArray ptr, byval ppszName as LPWSTR ptr) as HRESULT
	GetIcon as function(byval This as IExplorerCommand ptr, byval psiItemArray as IShellItemArray ptr, byval ppszIcon as LPWSTR ptr) as HRESULT
	GetToolTip as function(byval This as IExplorerCommand ptr, byval psiItemArray as IShellItemArray ptr, byval ppszInfotip as LPWSTR ptr) as HRESULT
	GetCanonicalName as function(byval This as IExplorerCommand ptr, byval pguidCommandName as GUID ptr) as HRESULT
	GetState as function(byval This as IExplorerCommand ptr, byval psiItemArray as IShellItemArray ptr, byval fOkToBeSlow as WINBOOL, byval pCmdState as EXPCMDSTATE ptr) as HRESULT
	Invoke as function(byval This as IExplorerCommand ptr, byval psiItemArray as IShellItemArray ptr, byval pbc as IBindCtx ptr) as HRESULT
	GetFlags as function(byval This as IExplorerCommand ptr, byval pFlags as EXPCMDFLAGS ptr) as HRESULT
	EnumSubCommands as function(byval This as IExplorerCommand ptr, byval ppEnum as IEnumExplorerCommand ptr ptr) as HRESULT
end type

type IExplorerCommand_
	lpVtbl as IExplorerCommandVtbl ptr
end type

#define IExplorerCommand_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IExplorerCommand_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IExplorerCommand_Release(This) (This)->lpVtbl->Release(This)
#define IExplorerCommand_GetTitle(This, psiItemArray, ppszName) (This)->lpVtbl->GetTitle(This, psiItemArray, ppszName)
#define IExplorerCommand_GetIcon(This, psiItemArray, ppszIcon) (This)->lpVtbl->GetIcon(This, psiItemArray, ppszIcon)
#define IExplorerCommand_GetToolTip(This, psiItemArray, ppszInfotip) (This)->lpVtbl->GetToolTip(This, psiItemArray, ppszInfotip)
#define IExplorerCommand_GetCanonicalName(This, pguidCommandName) (This)->lpVtbl->GetCanonicalName(This, pguidCommandName)
#define IExplorerCommand_GetState(This, psiItemArray, fOkToBeSlow, pCmdState) (This)->lpVtbl->GetState(This, psiItemArray, fOkToBeSlow, pCmdState)
#define IExplorerCommand_Invoke(This, psiItemArray, pbc) (This)->lpVtbl->Invoke(This, psiItemArray, pbc)
#define IExplorerCommand_GetFlags(This, pFlags) (This)->lpVtbl->GetFlags(This, pFlags)
#define IExplorerCommand_EnumSubCommands(This, ppEnum) (This)->lpVtbl->EnumSubCommands(This, ppEnum)

declare function IExplorerCommand_GetTitle_Proxy(byval This as IExplorerCommand ptr, byval psiItemArray as IShellItemArray ptr, byval ppszName as LPWSTR ptr) as HRESULT
declare sub IExplorerCommand_GetTitle_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IExplorerCommand_GetIcon_Proxy(byval This as IExplorerCommand ptr, byval psiItemArray as IShellItemArray ptr, byval ppszIcon as LPWSTR ptr) as HRESULT
declare sub IExplorerCommand_GetIcon_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IExplorerCommand_GetToolTip_Proxy(byval This as IExplorerCommand ptr, byval psiItemArray as IShellItemArray ptr, byval ppszInfotip as LPWSTR ptr) as HRESULT
declare sub IExplorerCommand_GetToolTip_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IExplorerCommand_GetCanonicalName_Proxy(byval This as IExplorerCommand ptr, byval pguidCommandName as GUID ptr) as HRESULT
declare sub IExplorerCommand_GetCanonicalName_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IExplorerCommand_GetState_Proxy(byval This as IExplorerCommand ptr, byval psiItemArray as IShellItemArray ptr, byval fOkToBeSlow as WINBOOL, byval pCmdState as EXPCMDSTATE ptr) as HRESULT
declare sub IExplorerCommand_GetState_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IExplorerCommand_Invoke_Proxy(byval This as IExplorerCommand ptr, byval psiItemArray as IShellItemArray ptr, byval pbc as IBindCtx ptr) as HRESULT
declare sub IExplorerCommand_Invoke_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IExplorerCommand_GetFlags_Proxy(byval This as IExplorerCommand ptr, byval pFlags as EXPCMDFLAGS ptr) as HRESULT
declare sub IExplorerCommand_GetFlags_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IExplorerCommand_EnumSubCommands_Proxy(byval This as IExplorerCommand ptr, byval ppEnum as IEnumExplorerCommand ptr ptr) as HRESULT
declare sub IExplorerCommand_EnumSubCommands_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IExplorerCommandState_INTERFACE_DEFINED__
extern IID_IExplorerCommandState as const GUID
type IExplorerCommandState as IExplorerCommandState_

type IExplorerCommandStateVtbl
	QueryInterface as function(byval This as IExplorerCommandState ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IExplorerCommandState ptr) as ULONG
	Release as function(byval This as IExplorerCommandState ptr) as ULONG
	GetState as function(byval This as IExplorerCommandState ptr, byval psiItemArray as IShellItemArray ptr, byval fOkToBeSlow as WINBOOL, byval pCmdState as EXPCMDSTATE ptr) as HRESULT
end type

type IExplorerCommandState_
	lpVtbl as IExplorerCommandStateVtbl ptr
end type

#define IExplorerCommandState_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IExplorerCommandState_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IExplorerCommandState_Release(This) (This)->lpVtbl->Release(This)
#define IExplorerCommandState_GetState(This, psiItemArray, fOkToBeSlow, pCmdState) (This)->lpVtbl->GetState(This, psiItemArray, fOkToBeSlow, pCmdState)
declare function IExplorerCommandState_GetState_Proxy(byval This as IExplorerCommandState ptr, byval psiItemArray as IShellItemArray ptr, byval fOkToBeSlow as WINBOOL, byval pCmdState as EXPCMDSTATE ptr) as HRESULT
declare sub IExplorerCommandState_GetState_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IInitializeCommand_INTERFACE_DEFINED__
extern IID_IInitializeCommand as const GUID
type IInitializeCommand as IInitializeCommand_

type IInitializeCommandVtbl
	QueryInterface as function(byval This as IInitializeCommand ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IInitializeCommand ptr) as ULONG
	Release as function(byval This as IInitializeCommand ptr) as ULONG
	Initialize as function(byval This as IInitializeCommand ptr, byval pszCommandName as LPCWSTR, byval ppb as IPropertyBag ptr) as HRESULT
end type

type IInitializeCommand_
	lpVtbl as IInitializeCommandVtbl ptr
end type

#define IInitializeCommand_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IInitializeCommand_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IInitializeCommand_Release(This) (This)->lpVtbl->Release(This)
#define IInitializeCommand_Initialize(This, pszCommandName, ppb) (This)->lpVtbl->Initialize(This, pszCommandName, ppb)
declare function IInitializeCommand_Initialize_Proxy(byval This as IInitializeCommand ptr, byval pszCommandName as LPCWSTR, byval ppb as IPropertyBag ptr) as HRESULT
declare sub IInitializeCommand_Initialize_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IEnumExplorerCommand_INTERFACE_DEFINED__
extern IID_IEnumExplorerCommand as const GUID

type IEnumExplorerCommandVtbl
	QueryInterface as function(byval This as IEnumExplorerCommand ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IEnumExplorerCommand ptr) as ULONG
	Release as function(byval This as IEnumExplorerCommand ptr) as ULONG
	Next as function(byval This as IEnumExplorerCommand ptr, byval celt as ULONG, byval pUICommand as IExplorerCommand ptr ptr, byval pceltFetched as ULONG ptr) as HRESULT
	Skip as function(byval This as IEnumExplorerCommand ptr, byval celt as ULONG) as HRESULT
	Reset as function(byval This as IEnumExplorerCommand ptr) as HRESULT
	Clone as function(byval This as IEnumExplorerCommand ptr, byval ppenum as IEnumExplorerCommand ptr ptr) as HRESULT
end type

type IEnumExplorerCommand_
	lpVtbl as IEnumExplorerCommandVtbl ptr
end type

#define IEnumExplorerCommand_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IEnumExplorerCommand_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IEnumExplorerCommand_Release(This) (This)->lpVtbl->Release(This)
#define IEnumExplorerCommand_Next(This, celt, pUICommand, pceltFetched) (This)->lpVtbl->Next(This, celt, pUICommand, pceltFetched)
#define IEnumExplorerCommand_Skip(This, celt) (This)->lpVtbl->Skip(This, celt)
#define IEnumExplorerCommand_Reset(This) (This)->lpVtbl->Reset(This)
#define IEnumExplorerCommand_Clone(This, ppenum) (This)->lpVtbl->Clone(This, ppenum)

declare function IEnumExplorerCommand_RemoteNext_Proxy(byval This as IEnumExplorerCommand ptr, byval celt as ULONG, byval pUICommand as IExplorerCommand ptr ptr, byval pceltFetched as ULONG ptr) as HRESULT
declare sub IEnumExplorerCommand_RemoteNext_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumExplorerCommand_Skip_Proxy(byval This as IEnumExplorerCommand ptr, byval celt as ULONG) as HRESULT
declare sub IEnumExplorerCommand_Skip_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumExplorerCommand_Reset_Proxy(byval This as IEnumExplorerCommand ptr) as HRESULT
declare sub IEnumExplorerCommand_Reset_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumExplorerCommand_Clone_Proxy(byval This as IEnumExplorerCommand ptr, byval ppenum as IEnumExplorerCommand ptr ptr) as HRESULT
declare sub IEnumExplorerCommand_Clone_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumExplorerCommand_Next_Proxy(byval This as IEnumExplorerCommand ptr, byval celt as ULONG, byval pUICommand as IExplorerCommand ptr ptr, byval pceltFetched as ULONG ptr) as HRESULT
declare function IEnumExplorerCommand_Next_Stub(byval This as IEnumExplorerCommand ptr, byval celt as ULONG, byval pUICommand as IExplorerCommand ptr ptr, byval pceltFetched as ULONG ptr) as HRESULT
#define __IExplorerCommandProvider_INTERFACE_DEFINED__
extern IID_IExplorerCommandProvider as const GUID
type IExplorerCommandProvider as IExplorerCommandProvider_

type IExplorerCommandProviderVtbl
	QueryInterface as function(byval This as IExplorerCommandProvider ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IExplorerCommandProvider ptr) as ULONG
	Release as function(byval This as IExplorerCommandProvider ptr) as ULONG
	GetCommands as function(byval This as IExplorerCommandProvider ptr, byval punkSite as IUnknown ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	GetCommand as function(byval This as IExplorerCommandProvider ptr, byval rguidCommandId as const GUID const ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
end type

type IExplorerCommandProvider_
	lpVtbl as IExplorerCommandProviderVtbl ptr
end type

#define IExplorerCommandProvider_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IExplorerCommandProvider_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IExplorerCommandProvider_Release(This) (This)->lpVtbl->Release(This)
#define IExplorerCommandProvider_GetCommands(This, punkSite, riid, ppv) (This)->lpVtbl->GetCommands(This, punkSite, riid, ppv)
#define IExplorerCommandProvider_GetCommand(This, rguidCommandId, riid, ppv) (This)->lpVtbl->GetCommand(This, rguidCommandId, riid, ppv)

declare function IExplorerCommandProvider_GetCommands_Proxy(byval This as IExplorerCommandProvider ptr, byval punkSite as IUnknown ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare sub IExplorerCommandProvider_GetCommands_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IExplorerCommandProvider_GetCommand_Proxy(byval This as IExplorerCommandProvider ptr, byval rguidCommandId as const GUID const ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare sub IExplorerCommandProvider_GetCommand_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
type HTHEME as HANDLE
#define __IInitializeNetworkFolder_INTERFACE_DEFINED__
extern IID_IInitializeNetworkFolder as const GUID
type IInitializeNetworkFolder as IInitializeNetworkFolder_

type IInitializeNetworkFolderVtbl
	QueryInterface as function(byval This as IInitializeNetworkFolder ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IInitializeNetworkFolder ptr) as ULONG
	Release as function(byval This as IInitializeNetworkFolder ptr) as ULONG
	Initialize as function(byval This as IInitializeNetworkFolder ptr, byval pidl as LPCITEMIDLIST, byval pidlTarget as LPCITEMIDLIST, byval uDisplayType as UINT, byval pszResName as LPCWSTR, byval pszProvider as LPCWSTR) as HRESULT
end type

type IInitializeNetworkFolder_
	lpVtbl as IInitializeNetworkFolderVtbl ptr
end type

#define IInitializeNetworkFolder_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IInitializeNetworkFolder_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IInitializeNetworkFolder_Release(This) (This)->lpVtbl->Release(This)
#define IInitializeNetworkFolder_Initialize(This, pidl, pidlTarget, uDisplayType, pszResName, pszProvider) (This)->lpVtbl->Initialize(This, pidl, pidlTarget, uDisplayType, pszResName, pszProvider)
declare function IInitializeNetworkFolder_Initialize_Proxy(byval This as IInitializeNetworkFolder ptr, byval pidl as LPCITEMIDLIST, byval pidlTarget as LPCITEMIDLIST, byval uDisplayType as UINT, byval pszResName as LPCWSTR, byval pszProvider as LPCWSTR) as HRESULT
declare sub IInitializeNetworkFolder_Initialize_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

type CPVIEW as long
enum
	CPVIEW_CLASSIC = 0
	CPVIEW_ALLITEMS = CPVIEW_CLASSIC
	CPVIEW_CATEGORY = 1
	CPVIEW_HOME = CPVIEW_CATEGORY
end enum

#define __IOpenControlPanel_INTERFACE_DEFINED__
extern IID_IOpenControlPanel as const GUID
type IOpenControlPanel as IOpenControlPanel_

type IOpenControlPanelVtbl
	QueryInterface as function(byval This as IOpenControlPanel ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IOpenControlPanel ptr) as ULONG
	Release as function(byval This as IOpenControlPanel ptr) as ULONG
	Open as function(byval This as IOpenControlPanel ptr, byval pszName as LPCWSTR, byval pszPage as LPCWSTR, byval punkSite as IUnknown ptr) as HRESULT
	GetPath as function(byval This as IOpenControlPanel ptr, byval pszName as LPCWSTR, byval pszPath as LPWSTR, byval cchPath as UINT) as HRESULT
	GetCurrentView as function(byval This as IOpenControlPanel ptr, byval pView as CPVIEW ptr) as HRESULT
end type

type IOpenControlPanel_
	lpVtbl as IOpenControlPanelVtbl ptr
end type

#define IOpenControlPanel_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IOpenControlPanel_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IOpenControlPanel_Release(This) (This)->lpVtbl->Release(This)
#define IOpenControlPanel_Open(This, pszName, pszPage, punkSite) (This)->lpVtbl->Open(This, pszName, pszPage, punkSite)
#define IOpenControlPanel_GetPath(This, pszName, pszPath, cchPath) (This)->lpVtbl->GetPath(This, pszName, pszPath, cchPath)
#define IOpenControlPanel_GetCurrentView(This, pView) (This)->lpVtbl->GetCurrentView(This, pView)

declare function IOpenControlPanel_Open_Proxy(byval This as IOpenControlPanel ptr, byval pszName as LPCWSTR, byval pszPage as LPCWSTR, byval punkSite as IUnknown ptr) as HRESULT
declare sub IOpenControlPanel_Open_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOpenControlPanel_GetPath_Proxy(byval This as IOpenControlPanel ptr, byval pszName as LPCWSTR, byval pszPath as LPWSTR, byval cchPath as UINT) as HRESULT
declare sub IOpenControlPanel_GetPath_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IOpenControlPanel_GetCurrentView_Proxy(byval This as IOpenControlPanel ptr, byval pView as CPVIEW ptr) as HRESULT
declare sub IOpenControlPanel_GetCurrentView_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IComputerInfoChangeNotify_INTERFACE_DEFINED__
extern IID_IComputerInfoChangeNotify as const GUID
type IComputerInfoChangeNotify as IComputerInfoChangeNotify_

type IComputerInfoChangeNotifyVtbl
	QueryInterface as function(byval This as IComputerInfoChangeNotify ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IComputerInfoChangeNotify ptr) as ULONG
	Release as function(byval This as IComputerInfoChangeNotify ptr) as ULONG
	ComputerInfoChanged as function(byval This as IComputerInfoChangeNotify ptr) as HRESULT
end type

type IComputerInfoChangeNotify_
	lpVtbl as IComputerInfoChangeNotifyVtbl ptr
end type

#define IComputerInfoChangeNotify_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IComputerInfoChangeNotify_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IComputerInfoChangeNotify_Release(This) (This)->lpVtbl->Release(This)
#define IComputerInfoChangeNotify_ComputerInfoChanged(This) (This)->lpVtbl->ComputerInfoChanged(This)
declare function IComputerInfoChangeNotify_ComputerInfoChanged_Proxy(byval This as IComputerInfoChangeNotify ptr) as HRESULT
declare sub IComputerInfoChangeNotify_ComputerInfoChanged_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define STR_FILE_SYS_BIND_DATA wstr("File System Bind Data")
#define __IFileSystemBindData_INTERFACE_DEFINED__
extern IID_IFileSystemBindData as const GUID
type IFileSystemBindData as IFileSystemBindData_

type IFileSystemBindDataVtbl
	QueryInterface as function(byval This as IFileSystemBindData ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IFileSystemBindData ptr) as ULONG
	Release as function(byval This as IFileSystemBindData ptr) as ULONG
	SetFindData as function(byval This as IFileSystemBindData ptr, byval pfd as const WIN32_FIND_DATAW ptr) as HRESULT
	GetFindData as function(byval This as IFileSystemBindData ptr, byval pfd as WIN32_FIND_DATAW ptr) as HRESULT
end type

type IFileSystemBindData_
	lpVtbl as IFileSystemBindDataVtbl ptr
end type

#define IFileSystemBindData_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IFileSystemBindData_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IFileSystemBindData_Release(This) (This)->lpVtbl->Release(This)
#define IFileSystemBindData_SetFindData(This, pfd) (This)->lpVtbl->SetFindData(This, pfd)
#define IFileSystemBindData_GetFindData(This, pfd) (This)->lpVtbl->GetFindData(This, pfd)

declare function IFileSystemBindData_SetFindData_Proxy(byval This as IFileSystemBindData ptr, byval pfd as const WIN32_FIND_DATAW ptr) as HRESULT
declare sub IFileSystemBindData_SetFindData_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFileSystemBindData_GetFindData_Proxy(byval This as IFileSystemBindData ptr, byval pfd as WIN32_FIND_DATAW ptr) as HRESULT
declare sub IFileSystemBindData_GetFindData_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IFileSystemBindData2_INTERFACE_DEFINED__
extern IID_IFileSystemBindData2 as const GUID
type IFileSystemBindData2 as IFileSystemBindData2_

type IFileSystemBindData2Vtbl
	QueryInterface as function(byval This as IFileSystemBindData2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IFileSystemBindData2 ptr) as ULONG
	Release as function(byval This as IFileSystemBindData2 ptr) as ULONG
	SetFindData as function(byval This as IFileSystemBindData2 ptr, byval pfd as const WIN32_FIND_DATAW ptr) as HRESULT
	GetFindData as function(byval This as IFileSystemBindData2 ptr, byval pfd as WIN32_FIND_DATAW ptr) as HRESULT
	SetFileID as function(byval This as IFileSystemBindData2 ptr, byval liFileID as LARGE_INTEGER) as HRESULT
	GetFileID as function(byval This as IFileSystemBindData2 ptr, byval pliFileID as LARGE_INTEGER ptr) as HRESULT
	SetJunctionCLSID as function(byval This as IFileSystemBindData2 ptr, byval clsid as const IID const ptr) as HRESULT
	GetJunctionCLSID as function(byval This as IFileSystemBindData2 ptr, byval pclsid as CLSID ptr) as HRESULT
end type

type IFileSystemBindData2_
	lpVtbl as IFileSystemBindData2Vtbl ptr
end type

#define IFileSystemBindData2_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IFileSystemBindData2_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IFileSystemBindData2_Release(This) (This)->lpVtbl->Release(This)
#define IFileSystemBindData2_SetFindData(This, pfd) (This)->lpVtbl->SetFindData(This, pfd)
#define IFileSystemBindData2_GetFindData(This, pfd) (This)->lpVtbl->GetFindData(This, pfd)
#define IFileSystemBindData2_SetFileID(This, liFileID) (This)->lpVtbl->SetFileID(This, liFileID)
#define IFileSystemBindData2_GetFileID(This, pliFileID) (This)->lpVtbl->GetFileID(This, pliFileID)
#define IFileSystemBindData2_SetJunctionCLSID(This, clsid) (This)->lpVtbl->SetJunctionCLSID(This, clsid)
#define IFileSystemBindData2_GetJunctionCLSID(This, pclsid) (This)->lpVtbl->GetJunctionCLSID(This, pclsid)

declare function IFileSystemBindData2_SetFileID_Proxy(byval This as IFileSystemBindData2 ptr, byval liFileID as LARGE_INTEGER) as HRESULT
declare sub IFileSystemBindData2_SetFileID_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFileSystemBindData2_GetFileID_Proxy(byval This as IFileSystemBindData2 ptr, byval pliFileID as LARGE_INTEGER ptr) as HRESULT
declare sub IFileSystemBindData2_GetFileID_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFileSystemBindData2_SetJunctionCLSID_Proxy(byval This as IFileSystemBindData2 ptr, byval clsid as const IID const ptr) as HRESULT
declare sub IFileSystemBindData2_SetJunctionCLSID_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFileSystemBindData2_GetJunctionCLSID_Proxy(byval This as IFileSystemBindData2 ptr, byval pclsid as CLSID ptr) as HRESULT
declare sub IFileSystemBindData2_GetJunctionCLSID_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#if _WIN32_WINNT >= &h0601
	#define __ICustomDestinationList_INTERFACE_DEFINED__

	type KNOWNDESTCATEGORY as long
	enum
		KDC_FREQUENT = 1
		KDC_RECENT = 2
	end enum

	extern IID_ICustomDestinationList as const GUID
	type ICustomDestinationList as ICustomDestinationList_

	type ICustomDestinationListVtbl
		QueryInterface as function(byval This as ICustomDestinationList ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as ICustomDestinationList ptr) as ULONG
		Release as function(byval This as ICustomDestinationList ptr) as ULONG
		SetAppID as function(byval This as ICustomDestinationList ptr, byval pszAppID as LPCWSTR) as HRESULT
		BeginList as function(byval This as ICustomDestinationList ptr, byval pcMinSlots as UINT ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
		AppendCategory as function(byval This as ICustomDestinationList ptr, byval pszCategory as LPCWSTR, byval poa as IObjectArray ptr) as HRESULT
		AppendKnownCategory as function(byval This as ICustomDestinationList ptr, byval category as KNOWNDESTCATEGORY) as HRESULT
		AddUserTasks as function(byval This as ICustomDestinationList ptr, byval poa as IObjectArray ptr) as HRESULT
		CommitList as function(byval This as ICustomDestinationList ptr) as HRESULT
		GetRemovedDestinations as function(byval This as ICustomDestinationList ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
		DeleteList as function(byval This as ICustomDestinationList ptr, byval pszAppID as LPCWSTR) as HRESULT
		AbortList as function(byval This as ICustomDestinationList ptr) as HRESULT
	end type

	type ICustomDestinationList_
		lpVtbl as ICustomDestinationListVtbl ptr
	end type

	#define ICustomDestinationList_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define ICustomDestinationList_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define ICustomDestinationList_Release(This) (This)->lpVtbl->Release(This)
	#define ICustomDestinationList_SetAppID(This, pszAppID) (This)->lpVtbl->SetAppID(This, pszAppID)
	#define ICustomDestinationList_BeginList(This, pcMinSlots, riid, ppv) (This)->lpVtbl->BeginList(This, pcMinSlots, riid, ppv)
	#define ICustomDestinationList_AppendCategory(This, pszCategory, poa) (This)->lpVtbl->AppendCategory(This, pszCategory, poa)
	#define ICustomDestinationList_AppendKnownCategory(This, category) (This)->lpVtbl->AppendKnownCategory(This, category)
	#define ICustomDestinationList_AddUserTasks(This, poa) (This)->lpVtbl->AddUserTasks(This, poa)
	#define ICustomDestinationList_CommitList(This) (This)->lpVtbl->CommitList(This)
	#define ICustomDestinationList_GetRemovedDestinations(This, riid, ppv) (This)->lpVtbl->GetRemovedDestinations(This, riid, ppv)
	#define ICustomDestinationList_DeleteList(This, pszAppID) (This)->lpVtbl->DeleteList(This, pszAppID)
	#define ICustomDestinationList_AbortList(This) (This)->lpVtbl->AbortList(This)

	declare function ICustomDestinationList_SetAppID_Proxy(byval This as ICustomDestinationList ptr, byval pszAppID as LPCWSTR) as HRESULT
	declare sub ICustomDestinationList_SetAppID_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function ICustomDestinationList_BeginList_Proxy(byval This as ICustomDestinationList ptr, byval pcMinSlots as UINT ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	declare sub ICustomDestinationList_BeginList_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function ICustomDestinationList_AppendCategory_Proxy(byval This as ICustomDestinationList ptr, byval pszCategory as LPCWSTR, byval poa as IObjectArray ptr) as HRESULT
	declare sub ICustomDestinationList_AppendCategory_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function ICustomDestinationList_AppendKnownCategory_Proxy(byval This as ICustomDestinationList ptr, byval category as KNOWNDESTCATEGORY) as HRESULT
	declare sub ICustomDestinationList_AppendKnownCategory_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function ICustomDestinationList_AddUserTasks_Proxy(byval This as ICustomDestinationList ptr, byval poa as IObjectArray ptr) as HRESULT
	declare sub ICustomDestinationList_AddUserTasks_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function ICustomDestinationList_CommitList_Proxy(byval This as ICustomDestinationList ptr) as HRESULT
	declare sub ICustomDestinationList_CommitList_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function ICustomDestinationList_GetRemovedDestinations_Proxy(byval This as ICustomDestinationList ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	declare sub ICustomDestinationList_GetRemovedDestinations_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function ICustomDestinationList_DeleteList_Proxy(byval This as ICustomDestinationList ptr, byval pszAppID as LPCWSTR) as HRESULT
	declare sub ICustomDestinationList_DeleteList_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function ICustomDestinationList_AbortList_Proxy(byval This as ICustomDestinationList ptr) as HRESULT
	declare sub ICustomDestinationList_AbortList_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	#define __IApplicationDestinations_INTERFACE_DEFINED__
	extern IID_IApplicationDestinations as const GUID
	type IApplicationDestinations as IApplicationDestinations_

	type IApplicationDestinationsVtbl
		QueryInterface as function(byval This as IApplicationDestinations ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IApplicationDestinations ptr) as ULONG
		Release as function(byval This as IApplicationDestinations ptr) as ULONG
		SetAppID as function(byval This as IApplicationDestinations ptr, byval pszAppID as LPCWSTR) as HRESULT
		RemoveDestination as function(byval This as IApplicationDestinations ptr, byval punk as IUnknown ptr) as HRESULT
		RemoveAllDestinations as function(byval This as IApplicationDestinations ptr) as HRESULT
	end type

	type IApplicationDestinations_
		lpVtbl as IApplicationDestinationsVtbl ptr
	end type

	#define IApplicationDestinations_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IApplicationDestinations_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IApplicationDestinations_Release(This) (This)->lpVtbl->Release(This)
	#define IApplicationDestinations_SetAppID(This, pszAppID) (This)->lpVtbl->SetAppID(This, pszAppID)
	#define IApplicationDestinations_RemoveDestination(This, punk) (This)->lpVtbl->RemoveDestination(This, punk)
	#define IApplicationDestinations_RemoveAllDestinations(This) (This)->lpVtbl->RemoveAllDestinations(This)

	declare function IApplicationDestinations_SetAppID_Proxy(byval This as IApplicationDestinations ptr, byval pszAppID as LPCWSTR) as HRESULT
	declare sub IApplicationDestinations_SetAppID_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IApplicationDestinations_RemoveDestination_Proxy(byval This as IApplicationDestinations ptr, byval punk as IUnknown ptr) as HRESULT
	declare sub IApplicationDestinations_RemoveDestination_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IApplicationDestinations_RemoveAllDestinations_Proxy(byval This as IApplicationDestinations ptr) as HRESULT
	declare sub IApplicationDestinations_RemoveAllDestinations_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	#define __IApplicationDocumentLists_INTERFACE_DEFINED__

	type APPDOCLISTTYPE as long
	enum
		ADLT_RECENT = 0
		ADLT_FREQUENT = 1
	end enum

	extern IID_IApplicationDocumentLists as const GUID
	type IApplicationDocumentLists as IApplicationDocumentLists_

	type IApplicationDocumentListsVtbl
		QueryInterface as function(byval This as IApplicationDocumentLists ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IApplicationDocumentLists ptr) as ULONG
		Release as function(byval This as IApplicationDocumentLists ptr) as ULONG
		SetAppID as function(byval This as IApplicationDocumentLists ptr, byval pszAppID as LPCWSTR) as HRESULT
		GetList as function(byval This as IApplicationDocumentLists ptr, byval listtype as APPDOCLISTTYPE, byval cItemsDesired as UINT, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	end type

	type IApplicationDocumentLists_
		lpVtbl as IApplicationDocumentListsVtbl ptr
	end type

	#define IApplicationDocumentLists_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IApplicationDocumentLists_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IApplicationDocumentLists_Release(This) (This)->lpVtbl->Release(This)
	#define IApplicationDocumentLists_SetAppID(This, pszAppID) (This)->lpVtbl->SetAppID(This, pszAppID)
	#define IApplicationDocumentLists_GetList(This, listtype, cItemsDesired, riid, ppv) (This)->lpVtbl->GetList(This, listtype, cItemsDesired, riid, ppv)

	declare function IApplicationDocumentLists_SetAppID_Proxy(byval This as IApplicationDocumentLists ptr, byval pszAppID as LPCWSTR) as HRESULT
	declare sub IApplicationDocumentLists_SetAppID_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IApplicationDocumentLists_GetList_Proxy(byval This as IApplicationDocumentLists ptr, byval listtype as APPDOCLISTTYPE, byval cItemsDesired as UINT, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	declare sub IApplicationDocumentLists_GetList_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	#define __IObjectWithAppUserModelID_INTERFACE_DEFINED__
	extern IID_IObjectWithAppUserModelID as const GUID
	type IObjectWithAppUserModelID as IObjectWithAppUserModelID_

	type IObjectWithAppUserModelIDVtbl
		QueryInterface as function(byval This as IObjectWithAppUserModelID ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IObjectWithAppUserModelID ptr) as ULONG
		Release as function(byval This as IObjectWithAppUserModelID ptr) as ULONG
		SetAppID as function(byval This as IObjectWithAppUserModelID ptr, byval pszAppID as LPCWSTR) as HRESULT
		GetAppID as function(byval This as IObjectWithAppUserModelID ptr, byval ppszAppID as LPWSTR ptr) as HRESULT
	end type

	type IObjectWithAppUserModelID_
		lpVtbl as IObjectWithAppUserModelIDVtbl ptr
	end type

	#define IObjectWithAppUserModelID_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IObjectWithAppUserModelID_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IObjectWithAppUserModelID_Release(This) (This)->lpVtbl->Release(This)
	#define IObjectWithAppUserModelID_SetAppID(This, pszAppID) (This)->lpVtbl->SetAppID(This, pszAppID)
	#define IObjectWithAppUserModelID_GetAppID(This, ppszAppID) (This)->lpVtbl->GetAppID(This, ppszAppID)

	declare function IObjectWithAppUserModelID_SetAppID_Proxy(byval This as IObjectWithAppUserModelID ptr, byval pszAppID as LPCWSTR) as HRESULT
	declare sub IObjectWithAppUserModelID_SetAppID_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IObjectWithAppUserModelID_GetAppID_Proxy(byval This as IObjectWithAppUserModelID ptr, byval ppszAppID as LPWSTR ptr) as HRESULT
	declare sub IObjectWithAppUserModelID_GetAppID_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	#define __IObjectWithProgID_INTERFACE_DEFINED__
	extern IID_IObjectWithProgID as const GUID
	type IObjectWithProgID as IObjectWithProgID_

	type IObjectWithProgIDVtbl
		QueryInterface as function(byval This as IObjectWithProgID ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IObjectWithProgID ptr) as ULONG
		Release as function(byval This as IObjectWithProgID ptr) as ULONG
		SetProgID as function(byval This as IObjectWithProgID ptr, byval pszProgID as LPCWSTR) as HRESULT
		GetProgID as function(byval This as IObjectWithProgID ptr, byval ppszProgID as LPWSTR ptr) as HRESULT
	end type

	type IObjectWithProgID_
		lpVtbl as IObjectWithProgIDVtbl ptr
	end type

	#define IObjectWithProgID_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IObjectWithProgID_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IObjectWithProgID_Release(This) (This)->lpVtbl->Release(This)
	#define IObjectWithProgID_SetProgID(This, pszProgID) (This)->lpVtbl->SetProgID(This, pszProgID)
	#define IObjectWithProgID_GetProgID(This, ppszProgID) (This)->lpVtbl->GetProgID(This, ppszProgID)

	declare function IObjectWithProgID_SetProgID_Proxy(byval This as IObjectWithProgID ptr, byval pszProgID as LPCWSTR) as HRESULT
	declare sub IObjectWithProgID_SetProgID_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IObjectWithProgID_GetProgID_Proxy(byval This as IObjectWithProgID ptr, byval ppszProgID as LPWSTR ptr) as HRESULT
	declare sub IObjectWithProgID_GetProgID_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	#define __IUpdateIDList_INTERFACE_DEFINED__
	extern IID_IUpdateIDList as const GUID
	type IUpdateIDList as IUpdateIDList_

	type IUpdateIDListVtbl
		QueryInterface as function(byval This as IUpdateIDList ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IUpdateIDList ptr) as ULONG
		Release as function(byval This as IUpdateIDList ptr) as ULONG
		Update as function(byval This as IUpdateIDList ptr, byval pbc as IBindCtx ptr, byval pidlIn as LPCITEMIDLIST, byval ppidlOut as LPITEMIDLIST ptr) as HRESULT
	end type

	type IUpdateIDList_
		lpVtbl as IUpdateIDListVtbl ptr
	end type

	#define IUpdateIDList_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IUpdateIDList_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IUpdateIDList_Release(This) (This)->lpVtbl->Release(This)
	#define IUpdateIDList_Update(This, pbc, pidlIn, ppidlOut) (This)->lpVtbl->Update(This, pbc, pidlIn, ppidlOut)

	declare function IUpdateIDList_Update_Proxy(byval This as IUpdateIDList ptr, byval pbc as IBindCtx ptr, byval pidlIn as LPCITEMIDLIST, byval ppidlOut as LPITEMIDLIST ptr) as HRESULT
	declare sub IUpdateIDList_Update_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function SetCurrentProcessExplicitAppUserModelID(byval AppID as PCWSTR) as HRESULT
	declare function GetCurrentProcessExplicitAppUserModelID(byval AppID as PWSTR ptr) as HRESULT
#endif

#define __IDesktopGadget_INTERFACE_DEFINED__
extern IID_IDesktopGadget as const GUID
type IDesktopGadget as IDesktopGadget_

type IDesktopGadgetVtbl
	QueryInterface as function(byval This as IDesktopGadget ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDesktopGadget ptr) as ULONG
	Release as function(byval This as IDesktopGadget ptr) as ULONG
	RunGadget as function(byval This as IDesktopGadget ptr, byval gadgetPath as LPCWSTR) as HRESULT
end type

type IDesktopGadget_
	lpVtbl as IDesktopGadgetVtbl ptr
end type

#define IDesktopGadget_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IDesktopGadget_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IDesktopGadget_Release(This) (This)->lpVtbl->Release(This)
#define IDesktopGadget_RunGadget(This, gadgetPath) (This)->lpVtbl->RunGadget(This, gadgetPath)
declare function IDesktopGadget_RunGadget_Proxy(byval This as IDesktopGadget ptr, byval gadgetPath as LPCWSTR) as HRESULT
declare sub IDesktopGadget_RunGadget_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#if _WIN32_WINNT = &h0602
	#define __IDesktopWallpaper_INTERFACE_DEFINED__

	type DESKTOP_SLIDESHOW_OPTIONS as long
	enum
		DSO_SHUFFLEIMAGES = &h1
	end enum

	type DESKTOP_SLIDESHOW_STATE as long
	enum
		DSS_ENABLED = &h1
		DSS_SLIDESHOW = &h2
		DSS_DISABLED_BY_REMOTE_SESSION = &h4
	end enum

	type DESKTOP_SLIDESHOW_DIRECTION as long
	enum
		DSD_FORWARD = 0
		DSD_BACKWARD = 1
	end enum

	type DESKTOP_WALLPAPER_POSITION as long
	enum
		DWPOS_CENTER = 0
		DWPOS_TILE = 1
		DWPOS_STRETCH = 2
		DWPOS_FIT = 3
		DWPOS_FILL = 4
		DWPOS_SPAN = 5
	end enum

	extern IID_IDesktopWallpaper as const GUID
	type IDesktopWallpaper as IDesktopWallpaper_

	type IDesktopWallpaperVtbl
		QueryInterface as function(byval This as IDesktopWallpaper ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IDesktopWallpaper ptr) as ULONG
		Release as function(byval This as IDesktopWallpaper ptr) as ULONG
		SetWallpaper as function(byval This as IDesktopWallpaper ptr, byval monitorID as LPCWSTR, byval wallpaper as LPCWSTR) as HRESULT
		GetWallpaper as function(byval This as IDesktopWallpaper ptr, byval monitorID as LPCWSTR, byval wallpaper as LPWSTR ptr) as HRESULT
		GetMonitorDevicePathAt as function(byval This as IDesktopWallpaper ptr, byval monitorIndex as UINT, byval monitorID as LPWSTR ptr) as HRESULT
		GetMonitorDevicePathCount as function(byval This as IDesktopWallpaper ptr, byval count as UINT ptr) as HRESULT
		GetMonitorRECT as function(byval This as IDesktopWallpaper ptr, byval monitorID as LPCWSTR, byval displayRect as RECT ptr) as HRESULT
		SetBackgroundColor as function(byval This as IDesktopWallpaper ptr, byval color as COLORREF) as HRESULT
		GetBackgroundColor as function(byval This as IDesktopWallpaper ptr, byval color as COLORREF ptr) as HRESULT
		SetPosition as function(byval This as IDesktopWallpaper ptr, byval position as DESKTOP_WALLPAPER_POSITION) as HRESULT
		GetPosition as function(byval This as IDesktopWallpaper ptr, byval position as DESKTOP_WALLPAPER_POSITION ptr) as HRESULT
		SetSlideshow as function(byval This as IDesktopWallpaper ptr, byval items as IShellItemArray ptr) as HRESULT
		GetSlideshow as function(byval This as IDesktopWallpaper ptr, byval items as IShellItemArray ptr ptr) as HRESULT
		SetSlideshowOptions as function(byval This as IDesktopWallpaper ptr, byval options as DESKTOP_SLIDESHOW_OPTIONS, byval slideshowTick as UINT) as HRESULT
		GetSlideshowOptions as function(byval This as IDesktopWallpaper ptr, byval options as DESKTOP_SLIDESHOW_OPTIONS ptr, byval slideshowTick as UINT ptr) as HRESULT
		AdvanceSlideshow as function(byval This as IDesktopWallpaper ptr, byval monitorID as LPCWSTR, byval direction as DESKTOP_SLIDESHOW_DIRECTION) as HRESULT
		GetStatus as function(byval This as IDesktopWallpaper ptr, byval state as DESKTOP_SLIDESHOW_STATE ptr) as HRESULT
		Enable as function(byval This as IDesktopWallpaper ptr, byval enable as WINBOOL) as HRESULT
	end type

	type IDesktopWallpaper_
		lpVtbl as IDesktopWallpaperVtbl ptr
	end type

	#define IDesktopWallpaper_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IDesktopWallpaper_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IDesktopWallpaper_Release(This) (This)->lpVtbl->Release(This)
	#define IDesktopWallpaper_SetWallpaper(This, monitorID, wallpaper) (This)->lpVtbl->SetWallpaper(This, monitorID, wallpaper)
	#define IDesktopWallpaper_GetWallpaper(This, monitorID, wallpaper) (This)->lpVtbl->GetWallpaper(This, monitorID, wallpaper)
	#define IDesktopWallpaper_GetMonitorDevicePathAt(This, monitorIndex, monitorID) (This)->lpVtbl->GetMonitorDevicePathAt(This, monitorIndex, monitorID)
	#define IDesktopWallpaper_GetMonitorDevicePathCount(This, count) (This)->lpVtbl->GetMonitorDevicePathCount(This, count)
	#define IDesktopWallpaper_GetMonitorRECT(This, monitorID, displayRect) (This)->lpVtbl->GetMonitorRECT(This, monitorID, displayRect)
	#define IDesktopWallpaper_SetBackgroundColor(This, color) (This)->lpVtbl->SetBackgroundColor(This, color)
	#define IDesktopWallpaper_GetBackgroundColor(This, color) (This)->lpVtbl->GetBackgroundColor(This, color)
	#define IDesktopWallpaper_SetPosition(This, position) (This)->lpVtbl->SetPosition(This, position)
	#define IDesktopWallpaper_GetPosition(This, position) (This)->lpVtbl->GetPosition(This, position)
	#define IDesktopWallpaper_SetSlideshow(This, items) (This)->lpVtbl->SetSlideshow(This, items)
	#define IDesktopWallpaper_GetSlideshow(This, items) (This)->lpVtbl->GetSlideshow(This, items)
	#define IDesktopWallpaper_SetSlideshowOptions(This, options, slideshowTick) (This)->lpVtbl->SetSlideshowOptions(This, options, slideshowTick)
	#define IDesktopWallpaper_GetSlideshowOptions(This, options, slideshowTick) (This)->lpVtbl->GetSlideshowOptions(This, options, slideshowTick)
	#define IDesktopWallpaper_AdvanceSlideshow(This, monitorID, direction) (This)->lpVtbl->AdvanceSlideshow(This, monitorID, direction)
	#define IDesktopWallpaper_GetStatus(This, state) (This)->lpVtbl->GetStatus(This, state)
	#define IDesktopWallpaper_Enable(This, enable) (This)->lpVtbl->Enable(This, enable)

	declare function IDesktopWallpaper_SetWallpaper_Proxy(byval This as IDesktopWallpaper ptr, byval monitorID as LPCWSTR, byval wallpaper as LPCWSTR) as HRESULT
	declare sub IDesktopWallpaper_SetWallpaper_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IDesktopWallpaper_GetWallpaper_Proxy(byval This as IDesktopWallpaper ptr, byval monitorID as LPCWSTR, byval wallpaper as LPWSTR ptr) as HRESULT
	declare sub IDesktopWallpaper_GetWallpaper_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IDesktopWallpaper_GetMonitorDevicePathAt_Proxy(byval This as IDesktopWallpaper ptr, byval monitorIndex as UINT, byval monitorID as LPWSTR ptr) as HRESULT
	declare sub IDesktopWallpaper_GetMonitorDevicePathAt_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IDesktopWallpaper_GetMonitorDevicePathCount_Proxy(byval This as IDesktopWallpaper ptr, byval count as UINT ptr) as HRESULT
	declare sub IDesktopWallpaper_GetMonitorDevicePathCount_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IDesktopWallpaper_GetMonitorRECT_Proxy(byval This as IDesktopWallpaper ptr, byval monitorID as LPCWSTR, byval displayRect as RECT ptr) as HRESULT
	declare sub IDesktopWallpaper_GetMonitorRECT_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IDesktopWallpaper_SetBackgroundColor_Proxy(byval This as IDesktopWallpaper ptr, byval color as COLORREF) as HRESULT
	declare sub IDesktopWallpaper_SetBackgroundColor_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IDesktopWallpaper_GetBackgroundColor_Proxy(byval This as IDesktopWallpaper ptr, byval color as COLORREF ptr) as HRESULT
	declare sub IDesktopWallpaper_GetBackgroundColor_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IDesktopWallpaper_SetPosition_Proxy(byval This as IDesktopWallpaper ptr, byval position as DESKTOP_WALLPAPER_POSITION) as HRESULT
	declare sub IDesktopWallpaper_SetPosition_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IDesktopWallpaper_GetPosition_Proxy(byval This as IDesktopWallpaper ptr, byval position as DESKTOP_WALLPAPER_POSITION ptr) as HRESULT
	declare sub IDesktopWallpaper_GetPosition_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IDesktopWallpaper_SetSlideshow_Proxy(byval This as IDesktopWallpaper ptr, byval items as IShellItemArray ptr) as HRESULT
	declare sub IDesktopWallpaper_SetSlideshow_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IDesktopWallpaper_GetSlideshow_Proxy(byval This as IDesktopWallpaper ptr, byval items as IShellItemArray ptr ptr) as HRESULT
	declare sub IDesktopWallpaper_GetSlideshow_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IDesktopWallpaper_SetSlideshowOptions_Proxy(byval This as IDesktopWallpaper ptr, byval options as DESKTOP_SLIDESHOW_OPTIONS, byval slideshowTick as UINT) as HRESULT
	declare sub IDesktopWallpaper_SetSlideshowOptions_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IDesktopWallpaper_GetSlideshowOptions_Proxy(byval This as IDesktopWallpaper ptr, byval options as DESKTOP_SLIDESHOW_OPTIONS ptr, byval slideshowTick as UINT ptr) as HRESULT
	declare sub IDesktopWallpaper_GetSlideshowOptions_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IDesktopWallpaper_AdvanceSlideshow_Proxy(byval This as IDesktopWallpaper ptr, byval monitorID as LPCWSTR, byval direction as DESKTOP_SLIDESHOW_DIRECTION) as HRESULT
	declare sub IDesktopWallpaper_AdvanceSlideshow_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IDesktopWallpaper_GetStatus_Proxy(byval This as IDesktopWallpaper ptr, byval state as DESKTOP_SLIDESHOW_STATE ptr) as HRESULT
	declare sub IDesktopWallpaper_GetStatus_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IDesktopWallpaper_Enable_Proxy(byval This as IDesktopWallpaper ptr, byval enable as WINBOOL) as HRESULT
	declare sub IDesktopWallpaper_Enable_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#endif

#define HOMEGROUP_SECURITY_GROUP_MULTI wstr("HUG")
#define HOMEGROUP_SECURITY_GROUP wstr("HomeUsers")
#define __IHomeGroup_INTERFACE_DEFINED__

type HOMEGROUPSHARINGCHOICES as long
enum
	HGSC_NONE = &h0
	HGSC_MUSICLIBRARY = &h1
	HGSC_PICTURESLIBRARY = &h2
	HGSC_VIDEOSLIBRARY = &h4
	HGSC_DOCUMENTSLIBRARY = &h8
	HGSC_PRINTERS = &h10
end enum

extern IID_IHomeGroup as const GUID
type IHomeGroup as IHomeGroup_

type IHomeGroupVtbl
	QueryInterface as function(byval This as IHomeGroup ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IHomeGroup ptr) as ULONG
	Release as function(byval This as IHomeGroup ptr) as ULONG
	IsMember as function(byval This as IHomeGroup ptr, byval member as WINBOOL ptr) as HRESULT
	ShowSharingWizard as function(byval This as IHomeGroup ptr, byval owner as HWND, byval sharingchoices as HOMEGROUPSHARINGCHOICES ptr) as HRESULT
end type

type IHomeGroup_
	lpVtbl as IHomeGroupVtbl ptr
end type

#define IHomeGroup_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IHomeGroup_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IHomeGroup_Release(This) (This)->lpVtbl->Release(This)
#define IHomeGroup_IsMember(This, member) (This)->lpVtbl->IsMember(This, member)
#define IHomeGroup_ShowSharingWizard(This, owner, sharingchoices) (This)->lpVtbl->ShowSharingWizard(This, owner, sharingchoices)

declare function IHomeGroup_IsMember_Proxy(byval This as IHomeGroup ptr, byval member as WINBOOL ptr) as HRESULT
declare sub IHomeGroup_IsMember_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IHomeGroup_ShowSharingWizard_Proxy(byval This as IHomeGroup ptr, byval owner as HWND, byval sharingchoices as HOMEGROUPSHARINGCHOICES ptr) as HRESULT
declare sub IHomeGroup_ShowSharingWizard_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IInitializeWithPropertyStore_INTERFACE_DEFINED__
extern IID_IInitializeWithPropertyStore as const GUID
type IInitializeWithPropertyStore as IInitializeWithPropertyStore_

type IInitializeWithPropertyStoreVtbl
	QueryInterface as function(byval This as IInitializeWithPropertyStore ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IInitializeWithPropertyStore ptr) as ULONG
	Release as function(byval This as IInitializeWithPropertyStore ptr) as ULONG
	Initialize as function(byval This as IInitializeWithPropertyStore ptr, byval pps as IPropertyStore ptr) as HRESULT
end type

type IInitializeWithPropertyStore_
	lpVtbl as IInitializeWithPropertyStoreVtbl ptr
end type

#define IInitializeWithPropertyStore_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IInitializeWithPropertyStore_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IInitializeWithPropertyStore_Release(This) (This)->lpVtbl->Release(This)
#define IInitializeWithPropertyStore_Initialize(This, pps) (This)->lpVtbl->Initialize(This, pps)
declare function IInitializeWithPropertyStore_Initialize_Proxy(byval This as IInitializeWithPropertyStore ptr, byval pps as IPropertyStore ptr) as HRESULT
declare sub IInitializeWithPropertyStore_Initialize_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IOpenSearchSource_INTERFACE_DEFINED__
extern IID_IOpenSearchSource as const GUID
type IOpenSearchSource as IOpenSearchSource_

type IOpenSearchSourceVtbl
	QueryInterface as function(byval This as IOpenSearchSource ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IOpenSearchSource ptr) as ULONG
	Release as function(byval This as IOpenSearchSource ptr) as ULONG
	GetResults as function(byval This as IOpenSearchSource ptr, byval hwnd as HWND, byval pszQuery as LPCWSTR, byval dwStartIndex as DWORD, byval dwCount as DWORD, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
end type

type IOpenSearchSource_
	lpVtbl as IOpenSearchSourceVtbl ptr
end type

#define IOpenSearchSource_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IOpenSearchSource_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IOpenSearchSource_Release(This) (This)->lpVtbl->Release(This)
#define IOpenSearchSource_GetResults(This, hwnd, pszQuery, dwStartIndex, dwCount, riid, ppv) (This)->lpVtbl->GetResults(This, hwnd, pszQuery, dwStartIndex, dwCount, riid, ppv)
declare function IOpenSearchSource_GetResults_Proxy(byval This as IOpenSearchSource ptr, byval hwnd as HWND, byval pszQuery as LPCWSTR, byval dwStartIndex as DWORD, byval dwCount as DWORD, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare sub IOpenSearchSource_GetResults_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IShellLibrary_INTERFACE_DEFINED__

type LIBRARYFOLDERFILTER as long
enum
	LFF_FORCEFILESYSTEM = 1
	LFF_STORAGEITEMS = 2
	LFF_ALLITEMS = 3
end enum

type LIBRARYOPTIONFLAGS as long
enum
	LOF_DEFAULT = &h0
	LOF_PINNEDTONAVPANE = &h1
	LOF_MASK_ALL = &h1
end enum

type DEFAULTSAVEFOLDERTYPE as long
enum
	DSFT_DETECT = 1
	DSFT_PRIVATE = 2
	DSFT_PUBLIC = 3
end enum

type LIBRARYSAVEFLAGS as long
enum
	LSF_FAILIFTHERE = &h0
	LSF_OVERRIDEEXISTING = &h1
	LSF_MAKEUNIQUENAME = &h2
end enum

extern IID_IShellLibrary as const GUID
type IShellLibrary as IShellLibrary_

type IShellLibraryVtbl
	QueryInterface as function(byval This as IShellLibrary ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IShellLibrary ptr) as ULONG
	Release as function(byval This as IShellLibrary ptr) as ULONG
	LoadLibraryFromItem as function(byval This as IShellLibrary ptr, byval psiLibrary as IShellItem ptr, byval grfMode as DWORD) as HRESULT
	LoadLibraryFromKnownFolder as function(byval This as IShellLibrary ptr, byval kfidLibrary as const KNOWNFOLDERID const ptr, byval grfMode as DWORD) as HRESULT
	AddFolder as function(byval This as IShellLibrary ptr, byval psiLocation as IShellItem ptr) as HRESULT
	RemoveFolder as function(byval This as IShellLibrary ptr, byval psiLocation as IShellItem ptr) as HRESULT
	GetFolders as function(byval This as IShellLibrary ptr, byval lff as LIBRARYFOLDERFILTER, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	ResolveFolder as function(byval This as IShellLibrary ptr, byval psiFolderToResolve as IShellItem ptr, byval dwTimeout as DWORD, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	GetDefaultSaveFolder as function(byval This as IShellLibrary ptr, byval dsft as DEFAULTSAVEFOLDERTYPE, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	SetDefaultSaveFolder as function(byval This as IShellLibrary ptr, byval dsft as DEFAULTSAVEFOLDERTYPE, byval psi as IShellItem ptr) as HRESULT
	GetOptions as function(byval This as IShellLibrary ptr, byval plofOptions as LIBRARYOPTIONFLAGS ptr) as HRESULT
	SetOptions as function(byval This as IShellLibrary ptr, byval lofMask as LIBRARYOPTIONFLAGS, byval lofOptions as LIBRARYOPTIONFLAGS) as HRESULT
	GetFolderType as function(byval This as IShellLibrary ptr, byval pftid as FOLDERTYPEID ptr) as HRESULT
	SetFolderType as function(byval This as IShellLibrary ptr, byval ftid as const FOLDERTYPEID const ptr) as HRESULT
	GetIcon as function(byval This as IShellLibrary ptr, byval ppszIcon as LPWSTR ptr) as HRESULT
	SetIcon as function(byval This as IShellLibrary ptr, byval pszIcon as LPCWSTR) as HRESULT
	Commit as function(byval This as IShellLibrary ptr) as HRESULT
	Save as function(byval This as IShellLibrary ptr, byval psiFolderToSaveIn as IShellItem ptr, byval pszLibraryName as LPCWSTR, byval lsf as LIBRARYSAVEFLAGS, byval ppsiSavedTo as IShellItem ptr ptr) as HRESULT
	SaveInKnownFolder as function(byval This as IShellLibrary ptr, byval kfidToSaveIn as const KNOWNFOLDERID const ptr, byval pszLibraryName as LPCWSTR, byval lsf as LIBRARYSAVEFLAGS, byval ppsiSavedTo as IShellItem ptr ptr) as HRESULT
end type

type IShellLibrary_
	lpVtbl as IShellLibraryVtbl ptr
end type

#define IShellLibrary_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IShellLibrary_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IShellLibrary_Release(This) (This)->lpVtbl->Release(This)
#define IShellLibrary_LoadLibraryFromItem(This, psiLibrary, grfMode) (This)->lpVtbl->LoadLibraryFromItem(This, psiLibrary, grfMode)
#define IShellLibrary_LoadLibraryFromKnownFolder(This, kfidLibrary, grfMode) (This)->lpVtbl->LoadLibraryFromKnownFolder(This, kfidLibrary, grfMode)
#define IShellLibrary_AddFolder(This, psiLocation) (This)->lpVtbl->AddFolder(This, psiLocation)
#define IShellLibrary_RemoveFolder(This, psiLocation) (This)->lpVtbl->RemoveFolder(This, psiLocation)
#define IShellLibrary_GetFolders(This, lff, riid, ppv) (This)->lpVtbl->GetFolders(This, lff, riid, ppv)
#define IShellLibrary_ResolveFolder(This, psiFolderToResolve, dwTimeout, riid, ppv) (This)->lpVtbl->ResolveFolder(This, psiFolderToResolve, dwTimeout, riid, ppv)
#define IShellLibrary_GetDefaultSaveFolder(This, dsft, riid, ppv) (This)->lpVtbl->GetDefaultSaveFolder(This, dsft, riid, ppv)
#define IShellLibrary_SetDefaultSaveFolder(This, dsft, psi) (This)->lpVtbl->SetDefaultSaveFolder(This, dsft, psi)
#define IShellLibrary_GetOptions(This, plofOptions) (This)->lpVtbl->GetOptions(This, plofOptions)
#define IShellLibrary_SetOptions(This, lofMask, lofOptions) (This)->lpVtbl->SetOptions(This, lofMask, lofOptions)
#define IShellLibrary_GetFolderType(This, pftid) (This)->lpVtbl->GetFolderType(This, pftid)
#define IShellLibrary_SetFolderType(This, ftid) (This)->lpVtbl->SetFolderType(This, ftid)
#define IShellLibrary_GetIcon(This, ppszIcon) (This)->lpVtbl->GetIcon(This, ppszIcon)
#define IShellLibrary_SetIcon(This, pszIcon) (This)->lpVtbl->SetIcon(This, pszIcon)
#define IShellLibrary_Commit(This) (This)->lpVtbl->Commit(This)
#define IShellLibrary_Save(This, psiFolderToSaveIn, pszLibraryName, lsf, ppsiSavedTo) (This)->lpVtbl->Save(This, psiFolderToSaveIn, pszLibraryName, lsf, ppsiSavedTo)
#define IShellLibrary_SaveInKnownFolder(This, kfidToSaveIn, pszLibraryName, lsf, ppsiSavedTo) (This)->lpVtbl->SaveInKnownFolder(This, kfidToSaveIn, pszLibraryName, lsf, ppsiSavedTo)

declare function IShellLibrary_LoadLibraryFromItem_Proxy(byval This as IShellLibrary ptr, byval psiLibrary as IShellItem ptr, byval grfMode as DWORD) as HRESULT
declare sub IShellLibrary_LoadLibraryFromItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLibrary_LoadLibraryFromKnownFolder_Proxy(byval This as IShellLibrary ptr, byval kfidLibrary as const KNOWNFOLDERID const ptr, byval grfMode as DWORD) as HRESULT
declare sub IShellLibrary_LoadLibraryFromKnownFolder_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLibrary_AddFolder_Proxy(byval This as IShellLibrary ptr, byval psiLocation as IShellItem ptr) as HRESULT
declare sub IShellLibrary_AddFolder_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLibrary_RemoveFolder_Proxy(byval This as IShellLibrary ptr, byval psiLocation as IShellItem ptr) as HRESULT
declare sub IShellLibrary_RemoveFolder_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLibrary_GetFolders_Proxy(byval This as IShellLibrary ptr, byval lff as LIBRARYFOLDERFILTER, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare sub IShellLibrary_GetFolders_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLibrary_ResolveFolder_Proxy(byval This as IShellLibrary ptr, byval psiFolderToResolve as IShellItem ptr, byval dwTimeout as DWORD, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare sub IShellLibrary_ResolveFolder_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLibrary_GetDefaultSaveFolder_Proxy(byval This as IShellLibrary ptr, byval dsft as DEFAULTSAVEFOLDERTYPE, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare sub IShellLibrary_GetDefaultSaveFolder_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLibrary_SetDefaultSaveFolder_Proxy(byval This as IShellLibrary ptr, byval dsft as DEFAULTSAVEFOLDERTYPE, byval psi as IShellItem ptr) as HRESULT
declare sub IShellLibrary_SetDefaultSaveFolder_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLibrary_GetOptions_Proxy(byval This as IShellLibrary ptr, byval plofOptions as LIBRARYOPTIONFLAGS ptr) as HRESULT
declare sub IShellLibrary_GetOptions_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLibrary_SetOptions_Proxy(byval This as IShellLibrary ptr, byval lofMask as LIBRARYOPTIONFLAGS, byval lofOptions as LIBRARYOPTIONFLAGS) as HRESULT
declare sub IShellLibrary_SetOptions_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLibrary_GetFolderType_Proxy(byval This as IShellLibrary ptr, byval pftid as FOLDERTYPEID ptr) as HRESULT
declare sub IShellLibrary_GetFolderType_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLibrary_SetFolderType_Proxy(byval This as IShellLibrary ptr, byval ftid as const FOLDERTYPEID const ptr) as HRESULT
declare sub IShellLibrary_SetFolderType_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLibrary_GetIcon_Proxy(byval This as IShellLibrary ptr, byval ppszIcon as LPWSTR ptr) as HRESULT
declare sub IShellLibrary_GetIcon_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLibrary_SetIcon_Proxy(byval This as IShellLibrary ptr, byval pszIcon as LPCWSTR) as HRESULT
declare sub IShellLibrary_SetIcon_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLibrary_Commit_Proxy(byval This as IShellLibrary ptr) as HRESULT
declare sub IShellLibrary_Commit_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLibrary_Save_Proxy(byval This as IShellLibrary ptr, byval psiFolderToSaveIn as IShellItem ptr, byval pszLibraryName as LPCWSTR, byval lsf as LIBRARYSAVEFLAGS, byval ppsiSavedTo as IShellItem ptr ptr) as HRESULT
declare sub IShellLibrary_Save_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLibrary_SaveInKnownFolder_Proxy(byval This as IShellLibrary ptr, byval kfidToSaveIn as const KNOWNFOLDERID const ptr, byval pszLibraryName as LPCWSTR, byval lsf as LIBRARYSAVEFLAGS, byval ppsiSavedTo as IShellItem ptr ptr) as HRESULT
declare sub IShellLibrary_SaveInKnownFolder_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

type PBM_EVENT as long
enum
	PE_DUCKSESSION = 1
	PE_UNDUCKSESSION = 2
end enum

#define __IPlaybackManagerEvents_INTERFACE_DEFINED__
extern IID_IPlaybackManagerEvents as const GUID
type IPlaybackManagerEvents as IPlaybackManagerEvents_

type IPlaybackManagerEventsVtbl
	QueryInterface as function(byval This as IPlaybackManagerEvents ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPlaybackManagerEvents ptr) as ULONG
	Release as function(byval This as IPlaybackManagerEvents ptr) as ULONG
	OnPlaybackManagerEvent as function(byval This as IPlaybackManagerEvents ptr, byval dwSessionId as DWORD, byval mediaEvent as PBM_EVENT) as HRESULT
end type

type IPlaybackManagerEvents_
	lpVtbl as IPlaybackManagerEventsVtbl ptr
end type

#define IPlaybackManagerEvents_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IPlaybackManagerEvents_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IPlaybackManagerEvents_Release(This) (This)->lpVtbl->Release(This)
#define IPlaybackManagerEvents_OnPlaybackManagerEvent(This, dwSessionId, mediaEvent) (This)->lpVtbl->OnPlaybackManagerEvent(This, dwSessionId, mediaEvent)
declare function IPlaybackManagerEvents_OnPlaybackManagerEvent_Proxy(byval This as IPlaybackManagerEvents ptr, byval dwSessionId as DWORD, byval mediaEvent as PBM_EVENT) as HRESULT
declare sub IPlaybackManagerEvents_OnPlaybackManagerEvent_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

type PBM_SESSION_TYPE as long
enum
	ST_COMMUNICATION = 1
	ST_MEDIA = 2
end enum

type PBM_PLAY_STATE as long
enum
	PS_PLAYING = 1
	PS_PAUSED = 2
	PS_STOPPED = 3
end enum

type PBM_MUTE_STATE as long
enum
	MS_MUTED = 1
	MS_UNMUTED = 2
end enum

#define __IPlaybackManager_INTERFACE_DEFINED__
extern IID_IPlaybackManager as const GUID
type IPlaybackManager as IPlaybackManager_

type IPlaybackManagerVtbl
	QueryInterface as function(byval This as IPlaybackManager ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPlaybackManager ptr) as ULONG
	Release as function(byval This as IPlaybackManager ptr) as ULONG
	Advise as function(byval This as IPlaybackManager ptr, byval type as PBM_SESSION_TYPE, byval pEvents as IPlaybackManagerEvents ptr, byval pdwSessionId as DWORD ptr) as HRESULT
	Unadvise as function(byval This as IPlaybackManager ptr, byval dwSessionId as DWORD) as HRESULT
	ChangeSessionState as function(byval This as IPlaybackManager ptr, byval dwSessionId as DWORD, byval state as PBM_PLAY_STATE, byval mute as PBM_MUTE_STATE) as HRESULT
end type

type IPlaybackManager_
	lpVtbl as IPlaybackManagerVtbl ptr
end type

#define IPlaybackManager_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IPlaybackManager_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IPlaybackManager_Release(This) (This)->lpVtbl->Release(This)
#define IPlaybackManager_Advise(This, type, pEvents, pdwSessionId) (This)->lpVtbl->Advise(This, type, pEvents, pdwSessionId)
#define IPlaybackManager_Unadvise(This, dwSessionId) (This)->lpVtbl->Unadvise(This, dwSessionId)
#define IPlaybackManager_ChangeSessionState(This, dwSessionId, state, mute) (This)->lpVtbl->ChangeSessionState(This, dwSessionId, state, mute)

declare function IPlaybackManager_Advise_Proxy(byval This as IPlaybackManager ptr, byval type as PBM_SESSION_TYPE, byval pEvents as IPlaybackManagerEvents ptr, byval pdwSessionId as DWORD ptr) as HRESULT
declare sub IPlaybackManager_Advise_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPlaybackManager_Unadvise_Proxy(byval This as IPlaybackManager ptr, byval dwSessionId as DWORD) as HRESULT
declare sub IPlaybackManager_Unadvise_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPlaybackManager_ChangeSessionState_Proxy(byval This as IPlaybackManager ptr, byval dwSessionId as DWORD, byval state as PBM_PLAY_STATE, byval mute as PBM_MUTE_STATE) as HRESULT
declare sub IPlaybackManager_ChangeSessionState_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

type DEFAULT_FOLDER_MENU_RESTRICTIONS as long
enum
	DFMR_DEFAULT = &h0
	DFMR_NO_STATIC_VERBS = &h8
	DFMR_STATIC_VERBS_ONLY = &h10
	DFMR_NO_RESOURCE_VERBS = &h20
	DFMR_OPTIN_HANDLERS_ONLY = &h40
	DFMR_RESOURCE_AND_FOLDER_VERBS_ONLY = &h80
	DFMR_USE_SPECIFIED_HANDLERS = &h100
	DFMR_USE_SPECIFIED_VERBS = &h200
	DFMR_NO_ASYNC_VERBS = &h400
end enum

#define __IDefaultFolderMenuInitialize_INTERFACE_DEFINED__
extern IID_IDefaultFolderMenuInitialize as const GUID
type IDefaultFolderMenuInitialize as IDefaultFolderMenuInitialize_

type IDefaultFolderMenuInitializeVtbl
	QueryInterface as function(byval This as IDefaultFolderMenuInitialize ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDefaultFolderMenuInitialize ptr) as ULONG
	Release as function(byval This as IDefaultFolderMenuInitialize ptr) as ULONG
	Initialize as function(byval This as IDefaultFolderMenuInitialize ptr, byval hwnd as HWND, byval pcmcb as IContextMenuCB ptr, byval pidlFolder as LPCITEMIDLIST, byval psf as IShellFolder ptr, byval cidl as UINT, byval apidl as LPCITEMIDLIST ptr, byval punkAssociation as IUnknown ptr, byval cKeys as UINT, byval aKeys as const HKEY ptr) as HRESULT
	SetMenuRestrictions as function(byval This as IDefaultFolderMenuInitialize ptr, byval dfmrValues as DEFAULT_FOLDER_MENU_RESTRICTIONS) as HRESULT
	GetMenuRestrictions as function(byval This as IDefaultFolderMenuInitialize ptr, byval dfmrMask as DEFAULT_FOLDER_MENU_RESTRICTIONS, byval pdfmrValues as DEFAULT_FOLDER_MENU_RESTRICTIONS ptr) as HRESULT
	SetHandlerClsid as function(byval This as IDefaultFolderMenuInitialize ptr, byval rclsid as const IID const ptr) as HRESULT
end type

type IDefaultFolderMenuInitialize_
	lpVtbl as IDefaultFolderMenuInitializeVtbl ptr
end type

#define IDefaultFolderMenuInitialize_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IDefaultFolderMenuInitialize_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IDefaultFolderMenuInitialize_Release(This) (This)->lpVtbl->Release(This)
#define IDefaultFolderMenuInitialize_Initialize(This, hwnd, pcmcb, pidlFolder, psf, cidl, apidl, punkAssociation, cKeys, aKeys) (This)->lpVtbl->Initialize(This, hwnd, pcmcb, pidlFolder, psf, cidl, apidl, punkAssociation, cKeys, aKeys)
#define IDefaultFolderMenuInitialize_SetMenuRestrictions(This, dfmrValues) (This)->lpVtbl->SetMenuRestrictions(This, dfmrValues)
#define IDefaultFolderMenuInitialize_GetMenuRestrictions(This, dfmrMask, pdfmrValues) (This)->lpVtbl->GetMenuRestrictions(This, dfmrMask, pdfmrValues)
#define IDefaultFolderMenuInitialize_SetHandlerClsid(This, rclsid) (This)->lpVtbl->SetHandlerClsid(This, rclsid)

declare function IDefaultFolderMenuInitialize_Initialize_Proxy(byval This as IDefaultFolderMenuInitialize ptr, byval hwnd as HWND, byval pcmcb as IContextMenuCB ptr, byval pidlFolder as LPCITEMIDLIST, byval psf as IShellFolder ptr, byval cidl as UINT, byval apidl as LPCITEMIDLIST ptr, byval punkAssociation as IUnknown ptr, byval cKeys as UINT, byval aKeys as const HKEY ptr) as HRESULT
declare sub IDefaultFolderMenuInitialize_Initialize_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDefaultFolderMenuInitialize_SetMenuRestrictions_Proxy(byval This as IDefaultFolderMenuInitialize ptr, byval dfmrValues as DEFAULT_FOLDER_MENU_RESTRICTIONS) as HRESULT
declare sub IDefaultFolderMenuInitialize_SetMenuRestrictions_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDefaultFolderMenuInitialize_GetMenuRestrictions_Proxy(byval This as IDefaultFolderMenuInitialize ptr, byval dfmrMask as DEFAULT_FOLDER_MENU_RESTRICTIONS, byval pdfmrValues as DEFAULT_FOLDER_MENU_RESTRICTIONS ptr) as HRESULT
declare sub IDefaultFolderMenuInitialize_GetMenuRestrictions_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDefaultFolderMenuInitialize_SetHandlerClsid_Proxy(byval This as IDefaultFolderMenuInitialize ptr, byval rclsid as const IID const ptr) as HRESULT
declare sub IDefaultFolderMenuInitialize_SetHandlerClsid_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#if _WIN32_WINNT = &h0602
	type ACTIVATEOPTIONS as long
	enum
		AO_NONE = &h0
		AO_DESIGNMODE = &h1
		AO_NOERRORUI = &h2
		AO_NOSPLASHSCREEN = &h4
	end enum

	#define __IApplicationActivationManager_INTERFACE_DEFINED__
	extern IID_IApplicationActivationManager as const GUID
	type IApplicationActivationManager as IApplicationActivationManager_

	type IApplicationActivationManagerVtbl
		QueryInterface as function(byval This as IApplicationActivationManager ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IApplicationActivationManager ptr) as ULONG
		Release as function(byval This as IApplicationActivationManager ptr) as ULONG
		ActivateApplication as function(byval This as IApplicationActivationManager ptr, byval appUserModelId as LPCWSTR, byval arguments as LPCWSTR, byval options as ACTIVATEOPTIONS, byval processId as DWORD ptr) as HRESULT
		ActivateForFile as function(byval This as IApplicationActivationManager ptr, byval appUserModelId as LPCWSTR, byval itemArray as IShellItemArray ptr, byval verb as LPCWSTR, byval processId as DWORD ptr) as HRESULT
		ActivateForProtocol as function(byval This as IApplicationActivationManager ptr, byval appUserModelId as LPCWSTR, byval itemArray as IShellItemArray ptr, byval processId as DWORD ptr) as HRESULT
	end type

	type IApplicationActivationManager_
		lpVtbl as IApplicationActivationManagerVtbl ptr
	end type

	#define IApplicationActivationManager_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IApplicationActivationManager_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IApplicationActivationManager_Release(This) (This)->lpVtbl->Release(This)
	#define IApplicationActivationManager_ActivateApplication(This, appUserModelId, arguments, options, processId) (This)->lpVtbl->ActivateApplication(This, appUserModelId, arguments, options, processId)
	#define IApplicationActivationManager_ActivateForFile(This, appUserModelId, itemArray, verb, processId) (This)->lpVtbl->ActivateForFile(This, appUserModelId, itemArray, verb, processId)
	#define IApplicationActivationManager_ActivateForProtocol(This, appUserModelId, itemArray, processId) (This)->lpVtbl->ActivateForProtocol(This, appUserModelId, itemArray, processId)

	declare function IApplicationActivationManager_ActivateApplication_Proxy(byval This as IApplicationActivationManager ptr, byval appUserModelId as LPCWSTR, byval arguments as LPCWSTR, byval options as ACTIVATEOPTIONS, byval processId as DWORD ptr) as HRESULT
	declare sub IApplicationActivationManager_ActivateApplication_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IApplicationActivationManager_ActivateForFile_Proxy(byval This as IApplicationActivationManager ptr, byval appUserModelId as LPCWSTR, byval itemArray as IShellItemArray ptr, byval verb as LPCWSTR, byval processId as DWORD ptr) as HRESULT
	declare sub IApplicationActivationManager_ActivateForFile_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IApplicationActivationManager_ActivateForProtocol_Proxy(byval This as IApplicationActivationManager ptr, byval appUserModelId as LPCWSTR, byval itemArray as IShellItemArray ptr, byval processId as DWORD ptr) as HRESULT
	declare sub IApplicationActivationManager_ActivateForProtocol_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#endif

extern LIBID_ShellObjects as const GUID
extern CLSID_DesktopWallpaper as const GUID
extern CLSID_ShellDesktop as const GUID
extern SID_SShellDesktop alias "CLSID_ShellDesktop" as const GUID
extern CLSID_ShellFSFolder as const GUID
extern CLSID_NetworkPlaces as const GUID
extern CLSID_ShellLink as const GUID
extern CLSID_QueryCancelAutoPlay as const GUID
extern CLSID_DriveSizeCategorizer as const GUID
extern CLSID_DriveTypeCategorizer as const GUID
extern CLSID_FreeSpaceCategorizer as const GUID
extern CLSID_TimeCategorizer as const GUID
extern CLSID_SizeCategorizer as const GUID
extern CLSID_AlphabeticalCategorizer as const GUID
extern CLSID_MergedCategorizer as const GUID
extern CLSID_ImageProperties as const GUID
extern CLSID_PropertiesUI as const GUID
extern CLSID_UserNotification as const GUID
extern CLSID_CDBurn as const GUID
extern CLSID_TaskbarList as const GUID
extern CLSID_StartMenuPin as const GUID
extern CLSID_WebWizardHost as const GUID
extern CLSID_PublishDropTarget as const GUID
extern CLSID_PublishingWizard as const GUID
extern SID_PublishingWizard alias "CLSID_PublishingWizard" as const GUID
extern CLSID_InternetPrintOrdering as const GUID
extern CLSID_FolderViewHost as const GUID
extern CLSID_ExplorerBrowser as const GUID
extern CLSID_ImageRecompress as const GUID
extern CLSID_TrayBandSiteService as const GUID
extern CLSID_TrayDeskBand as const GUID
extern CLSID_AttachmentServices as const GUID
extern CLSID_DocPropShellExtension as const GUID
extern CLSID_ShellItem as const GUID
extern CLSID_NamespaceWalker as const GUID
extern CLSID_FileOperation as const GUID
extern CLSID_FileOpenDialog as const GUID
extern CLSID_FileSaveDialog as const GUID
extern CLSID_KnownFolderManager as const GUID
extern CLSID_FSCopyHandler as const GUID
extern CLSID_SharingConfigurationManager as const GUID
extern CLSID_PreviousVersions as const GUID
extern CLSID_NetworkConnections as const GUID
extern CLSID_NamespaceTreeControl as const GUID
extern CLSID_IENamespaceTreeControl as const GUID
extern CLSID_ScheduledTasks as const GUID
extern CLSID_ApplicationAssociationRegistration as const GUID
extern CLSID_ApplicationAssociationRegistrationUI as const GUID
extern CLSID_SearchFolderItemFactory as const GUID
extern CLSID_OpenControlPanel as const GUID
extern CLSID_MailRecipient as const GUID
extern CLSID_NetworkExplorerFolder as const GUID
extern CLSID_DestinationList as const GUID
extern CLSID_ApplicationDestinations as const GUID
extern CLSID_ApplicationDocumentLists as const GUID
extern CLSID_HomeGroup as const GUID
extern CLSID_ShellLibrary as const GUID
extern CLSID_AppStartupLink as const GUID
extern CLSID_EnumerableObjectCollection as const GUID
extern CLSID_DesktopGadget as const GUID
extern CLSID_PlaybackManager as const GUID
extern CLSID_AccessibilityDockingService as const GUID
extern CLSID_FrameworkInputPane as const GUID
extern CLSID_DefFolderMenu as const GUID
extern CLSID_AppVisibility as const GUID
extern CLSID_AppShellVerbHandler as const GUID
extern CLSID_ExecuteUnknown as const GUID
extern CLSID_PackageDebugSettings as const GUID
extern CLSID_ApplicationActivationManager as const GUID
extern CLSID_ApplicationDesignModeSettings as const GUID
extern CLSID_ExecuteFolder as const GUID

#if _WIN32_WINNT >= &h0600
	declare function SHGetTemporaryPropertyForItem(byval psi as IShellItem ptr, byval propkey as const PROPERTYKEY const ptr, byval ppropvar as PROPVARIANT ptr) as HRESULT
	declare function SHSetTemporaryPropertyForItem(byval psi as IShellItem ptr, byval propkey as const PROPERTYKEY const ptr, byval propvar as const PROPVARIANT const ptr) as HRESULT
#endif

#if _WIN32_WINNT >= &h0601
	type LIBRARYMANAGEDIALOGOPTIONS as long
	enum
		LMD_DEFAULT = &h0
		LMD_ALLOWUNINDEXABLENETWORKLOCATIONS = &h1
	end enum

	declare function SHShowManageLibraryUI(byval psiLibrary as IShellItem ptr, byval hwndOwner as HWND, byval pszTitle as LPCWSTR, byval pszInstruction as LPCWSTR, byval lmdOptions as LIBRARYMANAGEDIALOGOPTIONS) as HRESULT
	declare function SHResolveLibrary(byval psiLibrary as IShellItem ptr) as HRESULT
#endif

#if _WIN32_WINNT >= &h0600
	#define __IAssocHandlerInvoker_INTERFACE_DEFINED__
	extern IID_IAssocHandlerInvoker as const GUID
	type IAssocHandlerInvoker as IAssocHandlerInvoker_

	type IAssocHandlerInvokerVtbl
		QueryInterface as function(byval This as IAssocHandlerInvoker ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IAssocHandlerInvoker ptr) as ULONG
		Release as function(byval This as IAssocHandlerInvoker ptr) as ULONG
		SupportsSelection as function(byval This as IAssocHandlerInvoker ptr) as HRESULT
		Invoke as function(byval This as IAssocHandlerInvoker ptr) as HRESULT
	end type

	type IAssocHandlerInvoker_
		lpVtbl as IAssocHandlerInvokerVtbl ptr
	end type

	#define IAssocHandlerInvoker_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IAssocHandlerInvoker_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IAssocHandlerInvoker_Release(This) (This)->lpVtbl->Release(This)
	#define IAssocHandlerInvoker_SupportsSelection(This) (This)->lpVtbl->SupportsSelection(This)
	#define IAssocHandlerInvoker_Invoke(This) (This)->lpVtbl->Invoke(This)

	declare function IAssocHandlerInvoker_SupportsSelection_Proxy(byval This as IAssocHandlerInvoker ptr) as HRESULT
	declare sub IAssocHandlerInvoker_SupportsSelection_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IAssocHandlerInvoker_Invoke_Proxy(byval This as IAssocHandlerInvoker ptr) as HRESULT
	declare sub IAssocHandlerInvoker_Invoke_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	#define __IAssocHandler_INTERFACE_DEFINED__
	extern IID_IAssocHandler as const GUID
	type IAssocHandler as IAssocHandler_

	type IAssocHandlerVtbl
		QueryInterface as function(byval This as IAssocHandler ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IAssocHandler ptr) as ULONG
		Release as function(byval This as IAssocHandler ptr) as ULONG
		GetName as function(byval This as IAssocHandler ptr, byval ppsz as LPWSTR ptr) as HRESULT
		GetUIName as function(byval This as IAssocHandler ptr, byval ppsz as LPWSTR ptr) as HRESULT
		GetIconLocation as function(byval This as IAssocHandler ptr, byval ppszPath as LPWSTR ptr, byval pIndex as long ptr) as HRESULT
		IsRecommended as function(byval This as IAssocHandler ptr) as HRESULT
		MakeDefault as function(byval This as IAssocHandler ptr, byval pszDescription as LPCWSTR) as HRESULT
		Invoke as function(byval This as IAssocHandler ptr, byval pdo as IDataObject ptr) as HRESULT
		CreateInvoker as function(byval This as IAssocHandler ptr, byval pdo as IDataObject ptr, byval ppInvoker as IAssocHandlerInvoker ptr ptr) as HRESULT
	end type

	type IAssocHandler_
		lpVtbl as IAssocHandlerVtbl ptr
	end type

	#define IAssocHandler_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IAssocHandler_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IAssocHandler_Release(This) (This)->lpVtbl->Release(This)
	#define IAssocHandler_GetName(This, ppsz) (This)->lpVtbl->GetName(This, ppsz)
	#define IAssocHandler_GetUIName(This, ppsz) (This)->lpVtbl->GetUIName(This, ppsz)
	#define IAssocHandler_GetIconLocation(This, ppszPath, pIndex) (This)->lpVtbl->GetIconLocation(This, ppszPath, pIndex)
	#define IAssocHandler_IsRecommended(This) (This)->lpVtbl->IsRecommended(This)
	#define IAssocHandler_MakeDefault(This, pszDescription) (This)->lpVtbl->MakeDefault(This, pszDescription)
	#define IAssocHandler_Invoke(This, pdo) (This)->lpVtbl->Invoke(This, pdo)
	#define IAssocHandler_CreateInvoker(This, pdo, ppInvoker) (This)->lpVtbl->CreateInvoker(This, pdo, ppInvoker)

	declare function IAssocHandler_GetName_Proxy(byval This as IAssocHandler ptr, byval ppsz as LPWSTR ptr) as HRESULT
	declare sub IAssocHandler_GetName_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IAssocHandler_GetUIName_Proxy(byval This as IAssocHandler ptr, byval ppsz as LPWSTR ptr) as HRESULT
	declare sub IAssocHandler_GetUIName_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IAssocHandler_GetIconLocation_Proxy(byval This as IAssocHandler ptr, byval ppszPath as LPWSTR ptr, byval pIndex as long ptr) as HRESULT
	declare sub IAssocHandler_GetIconLocation_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IAssocHandler_IsRecommended_Proxy(byval This as IAssocHandler ptr) as HRESULT
	declare sub IAssocHandler_IsRecommended_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IAssocHandler_MakeDefault_Proxy(byval This as IAssocHandler ptr, byval pszDescription as LPCWSTR) as HRESULT
	declare sub IAssocHandler_MakeDefault_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IAssocHandler_Invoke_Proxy(byval This as IAssocHandler ptr, byval pdo as IDataObject ptr) as HRESULT
	declare sub IAssocHandler_Invoke_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IAssocHandler_CreateInvoker_Proxy(byval This as IAssocHandler ptr, byval pdo as IDataObject ptr, byval ppInvoker as IAssocHandlerInvoker ptr ptr) as HRESULT
	declare sub IAssocHandler_CreateInvoker_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	#define __IEnumAssocHandlers_INTERFACE_DEFINED__
	extern IID_IEnumAssocHandlers as const GUID
	type IEnumAssocHandlers as IEnumAssocHandlers_

	type IEnumAssocHandlersVtbl
		QueryInterface as function(byval This as IEnumAssocHandlers ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IEnumAssocHandlers ptr) as ULONG
		Release as function(byval This as IEnumAssocHandlers ptr) as ULONG
		Next as function(byval This as IEnumAssocHandlers ptr, byval celt as ULONG, byval rgelt as IAssocHandler ptr ptr, byval pceltFetched as ULONG ptr) as HRESULT
	end type

	type IEnumAssocHandlers_
		lpVtbl as IEnumAssocHandlersVtbl ptr
	end type

	#define IEnumAssocHandlers_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IEnumAssocHandlers_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IEnumAssocHandlers_Release(This) (This)->lpVtbl->Release(This)
	#define IEnumAssocHandlers_Next(This, celt, rgelt, pceltFetched) (This)->lpVtbl->Next(This, celt, rgelt, pceltFetched)
	declare function IEnumAssocHandlers_Next_Proxy(byval This as IEnumAssocHandlers ptr, byval celt as ULONG, byval rgelt as IAssocHandler ptr ptr, byval pceltFetched as ULONG ptr) as HRESULT
	declare sub IEnumAssocHandlers_Next_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

	type ASSOC_FILTER as long
	enum
		ASSOC_FILTER_NONE = &h0
		ASSOC_FILTER_RECOMMENDED = &h1
	end enum

	declare function SHAssocEnumHandlers(byval pszExtra as PCWSTR, byval afFilter as ASSOC_FILTER, byval ppEnumHandler as IEnumAssocHandlers ptr ptr) as HRESULT
#endif

#if _WIN32_WINNT >= &h0601
	declare function SHAssocEnumHandlersForProtocolByApplication(byval protocol as PCWSTR, byval riid as const IID const ptr, byval enumHandlers as any ptr ptr) as HRESULT
#endif

#if _WIN32_WINNT = &h0602
	#define __IDataObjectProvider_INTERFACE_DEFINED__
	extern IID_IDataObjectProvider as const GUID
	type IDataObjectProvider as IDataObjectProvider_

	type IDataObjectProviderVtbl
		QueryInterface as function(byval This as IDataObjectProvider ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IDataObjectProvider ptr) as ULONG
		Release as function(byval This as IDataObjectProvider ptr) as ULONG
		GetDataObject as function(byval This as IDataObjectProvider ptr, byval dataObject as IDataObject ptr ptr) as HRESULT
		SetDataObject as function(byval This as IDataObjectProvider ptr, byval dataObject as IDataObject ptr) as HRESULT
	end type

	type IDataObjectProvider_
		lpVtbl as IDataObjectProviderVtbl ptr
	end type

	#define IDataObjectProvider_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IDataObjectProvider_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IDataObjectProvider_Release(This) (This)->lpVtbl->Release(This)
	#define IDataObjectProvider_GetDataObject(This, dataObject) (This)->lpVtbl->GetDataObject(This, dataObject)
	#define IDataObjectProvider_SetDataObject(This, dataObject) (This)->lpVtbl->SetDataObject(This, dataObject)
	declare function IDataObjectProvider_GetDataObject_Proxy(byval This as IDataObjectProvider ptr, byval dataObject as IDataObject ptr ptr) as HRESULT
	declare sub IDataObjectProvider_GetDataObject_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	#define __IDataTransferManagerInterop_INTERFACE_DEFINED__
	extern IID_IDataTransferManagerInterop as const GUID
	type IDataTransferManagerInterop as IDataTransferManagerInterop_

	type IDataTransferManagerInteropVtbl
		QueryInterface as function(byval This as IDataTransferManagerInterop ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IDataTransferManagerInterop ptr) as ULONG
		Release as function(byval This as IDataTransferManagerInterop ptr) as ULONG
		GetForWindow as function(byval This as IDataTransferManagerInterop ptr, byval appWindow as HWND, byval riid as const IID const ptr, byval dataTransferManager as any ptr ptr) as HRESULT
		ShowShareUIForWindow as function(byval This as IDataTransferManagerInterop ptr, byval appWindow as HWND) as HRESULT
	end type

	type IDataTransferManagerInterop_
		lpVtbl as IDataTransferManagerInteropVtbl ptr
	end type

	#define IDataTransferManagerInterop_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IDataTransferManagerInterop_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IDataTransferManagerInterop_Release(This) (This)->lpVtbl->Release(This)
	#define IDataTransferManagerInterop_GetForWindow(This, appWindow, riid, dataTransferManager) (This)->lpVtbl->GetForWindow(This, appWindow, riid, dataTransferManager)
	#define IDataTransferManagerInterop_ShowShareUIForWindow(This, appWindow) (This)->lpVtbl->ShowShareUIForWindow(This, appWindow)

	declare function IDataTransferManagerInterop_GetForWindow_Proxy(byval This as IDataTransferManagerInterop ptr, byval appWindow as HWND, byval riid as const IID const ptr, byval dataTransferManager as any ptr ptr) as HRESULT
	declare sub IDataTransferManagerInterop_GetForWindow_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IDataTransferManagerInterop_ShowShareUIForWindow_Proxy(byval This as IDataTransferManagerInterop ptr, byval appWindow as HWND) as HRESULT
	declare sub IDataTransferManagerInterop_ShowShareUIForWindow_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	#define __IFrameworkInputPaneHandler_INTERFACE_DEFINED__
	extern IID_IFrameworkInputPaneHandler as const GUID
	type IFrameworkInputPaneHandler as IFrameworkInputPaneHandler_

	type IFrameworkInputPaneHandlerVtbl
		QueryInterface as function(byval This as IFrameworkInputPaneHandler ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IFrameworkInputPaneHandler ptr) as ULONG
		Release as function(byval This as IFrameworkInputPaneHandler ptr) as ULONG
		Showing as function(byval This as IFrameworkInputPaneHandler ptr, byval prcInputPaneScreenLocation as RECT ptr, byval fEnsureFocusedElementInView as WINBOOL) as HRESULT
		Hiding as function(byval This as IFrameworkInputPaneHandler ptr, byval fEnsureFocusedElementInView as WINBOOL) as HRESULT
	end type

	type IFrameworkInputPaneHandler_
		lpVtbl as IFrameworkInputPaneHandlerVtbl ptr
	end type

	#define IFrameworkInputPaneHandler_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IFrameworkInputPaneHandler_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IFrameworkInputPaneHandler_Release(This) (This)->lpVtbl->Release(This)
	#define IFrameworkInputPaneHandler_Showing(This, prcInputPaneScreenLocation, fEnsureFocusedElementInView) (This)->lpVtbl->Showing(This, prcInputPaneScreenLocation, fEnsureFocusedElementInView)
	#define IFrameworkInputPaneHandler_Hiding(This, fEnsureFocusedElementInView) (This)->lpVtbl->Hiding(This, fEnsureFocusedElementInView)

	declare function IFrameworkInputPaneHandler_Showing_Proxy(byval This as IFrameworkInputPaneHandler ptr, byval prcInputPaneScreenLocation as RECT ptr, byval fEnsureFocusedElementInView as WINBOOL) as HRESULT
	declare sub IFrameworkInputPaneHandler_Showing_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFrameworkInputPaneHandler_Hiding_Proxy(byval This as IFrameworkInputPaneHandler ptr, byval fEnsureFocusedElementInView as WINBOOL) as HRESULT
	declare sub IFrameworkInputPaneHandler_Hiding_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	#define __IFrameworkInputPane_INTERFACE_DEFINED__
	extern IID_IFrameworkInputPane as const GUID
	type IFrameworkInputPane as IFrameworkInputPane_

	type IFrameworkInputPaneVtbl
		QueryInterface as function(byval This as IFrameworkInputPane ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IFrameworkInputPane ptr) as ULONG
		Release as function(byval This as IFrameworkInputPane ptr) as ULONG
		Advise as function(byval This as IFrameworkInputPane ptr, byval pWindow as IUnknown ptr, byval pHandler as IFrameworkInputPaneHandler ptr, byval pdwCookie as DWORD ptr) as HRESULT
		AdviseWithHWND as function(byval This as IFrameworkInputPane ptr, byval hwnd as HWND, byval pHandler as IFrameworkInputPaneHandler ptr, byval pdwCookie as DWORD ptr) as HRESULT
		Unadvise as function(byval This as IFrameworkInputPane ptr, byval dwCookie as DWORD) as HRESULT
		Location as function(byval This as IFrameworkInputPane ptr, byval prcInputPaneScreenLocation as RECT ptr) as HRESULT
	end type

	type IFrameworkInputPane_
		lpVtbl as IFrameworkInputPaneVtbl ptr
	end type

	#define IFrameworkInputPane_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IFrameworkInputPane_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IFrameworkInputPane_Release(This) (This)->lpVtbl->Release(This)
	#define IFrameworkInputPane_Advise(This, pWindow, pHandler, pdwCookie) (This)->lpVtbl->Advise(This, pWindow, pHandler, pdwCookie)
	#define IFrameworkInputPane_AdviseWithHWND(This, hwnd, pHandler, pdwCookie) (This)->lpVtbl->AdviseWithHWND(This, hwnd, pHandler, pdwCookie)
	#define IFrameworkInputPane_Unadvise(This, dwCookie) (This)->lpVtbl->Unadvise(This, dwCookie)
	#define IFrameworkInputPane_Location(This, prcInputPaneScreenLocation) (This)->lpVtbl->Location(This, prcInputPaneScreenLocation)

	declare function IFrameworkInputPane_Advise_Proxy(byval This as IFrameworkInputPane ptr, byval pWindow as IUnknown ptr, byval pHandler as IFrameworkInputPaneHandler ptr, byval pdwCookie as DWORD ptr) as HRESULT
	declare sub IFrameworkInputPane_Advise_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFrameworkInputPane_AdviseWithHWND_Proxy(byval This as IFrameworkInputPane ptr, byval hwnd as HWND, byval pHandler as IFrameworkInputPaneHandler ptr, byval pdwCookie as DWORD ptr) as HRESULT
	declare sub IFrameworkInputPane_AdviseWithHWND_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFrameworkInputPane_Unadvise_Proxy(byval This as IFrameworkInputPane ptr, byval dwCookie as DWORD) as HRESULT
	declare sub IFrameworkInputPane_Unadvise_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IFrameworkInputPane_Location_Proxy(byval This as IFrameworkInputPane ptr, byval prcInputPaneScreenLocation as RECT ptr) as HRESULT
	declare sub IFrameworkInputPane_Location_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	#define PROP_CONTRACT_DELEGATE wstr("ContractDelegate")

	private sub SetContractDelegateWindow cdecl(byval hwndSource as HWND, byval hwndDelegate as HWND)
		if hwndDelegate <> cptr(any ptr, 0) then
			SetPropW(hwndSource, wstr("ContractDelegate"), cast(HANDLE, hwndDelegate))
		else
			RemovePropW(hwndSource, wstr("ContractDelegate"))
		end if
	end sub

	#define GetContractDelegateWindow(hwndSource) cast(HWND, GetPropW((hwndSource), wstr("ContractDelegate")))
	#define __ISearchableApplication_INTERFACE_DEFINED__
	extern IID_ISearchableApplication as const GUID
	type ISearchableApplication as ISearchableApplication_

	type ISearchableApplicationVtbl
		QueryInterface as function(byval This as ISearchableApplication ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as ISearchableApplication ptr) as ULONG
		Release as function(byval This as ISearchableApplication ptr) as ULONG
		GetSearchWindow as function(byval This as ISearchableApplication ptr, byval hwnd as HWND ptr) as HRESULT
	end type

	type ISearchableApplication_
		lpVtbl as ISearchableApplicationVtbl ptr
	end type

	#define ISearchableApplication_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define ISearchableApplication_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define ISearchableApplication_Release(This) (This)->lpVtbl->Release(This)
	#define ISearchableApplication_GetSearchWindow(This, hwnd) (This)->lpVtbl->GetSearchWindow(This, hwnd)
	declare function ISearchableApplication_GetSearchWindow_Proxy(byval This as ISearchableApplication ptr, byval hwnd as HWND ptr) as HRESULT
	declare sub ISearchableApplication_GetSearchWindow_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

	type UNDOCK_REASON as long
	enum
		UR_RESOLUTION_CHANGE = 0
		UR_MONITOR_DISCONNECT = 1
	end enum

	#define __IAccessibilityDockingServiceCallback_INTERFACE_DEFINED__
	extern IID_IAccessibilityDockingServiceCallback as const GUID
	type IAccessibilityDockingServiceCallback as IAccessibilityDockingServiceCallback_

	type IAccessibilityDockingServiceCallbackVtbl
		QueryInterface as function(byval This as IAccessibilityDockingServiceCallback ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IAccessibilityDockingServiceCallback ptr) as ULONG
		Release as function(byval This as IAccessibilityDockingServiceCallback ptr) as ULONG
		Undocked as function(byval This as IAccessibilityDockingServiceCallback ptr, byval undockReason as UNDOCK_REASON) as HRESULT
	end type

	type IAccessibilityDockingServiceCallback_
		lpVtbl as IAccessibilityDockingServiceCallbackVtbl ptr
	end type

	#define IAccessibilityDockingServiceCallback_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IAccessibilityDockingServiceCallback_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IAccessibilityDockingServiceCallback_Release(This) (This)->lpVtbl->Release(This)
	#define IAccessibilityDockingServiceCallback_Undocked(This, undockReason) (This)->lpVtbl->Undocked(This, undockReason)
	declare function IAccessibilityDockingServiceCallback_Undocked_Proxy(byval This as IAccessibilityDockingServiceCallback ptr, byval undockReason as UNDOCK_REASON) as HRESULT
	declare sub IAccessibilityDockingServiceCallback_Undocked_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	#define __IAccessibilityDockingService_INTERFACE_DEFINED__
	extern IID_IAccessibilityDockingService as const GUID
	type IAccessibilityDockingService as IAccessibilityDockingService_

	type IAccessibilityDockingServiceVtbl
		QueryInterface as function(byval This as IAccessibilityDockingService ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IAccessibilityDockingService ptr) as ULONG
		Release as function(byval This as IAccessibilityDockingService ptr) as ULONG
		GetAvailableSize as function(byval This as IAccessibilityDockingService ptr, byval hMonitor as HMONITOR, byval pcxFixed as UINT ptr, byval pcyMax as UINT ptr) as HRESULT
		DockWindow as function(byval This as IAccessibilityDockingService ptr, byval hwnd as HWND, byval hMonitor as HMONITOR, byval cyRequested as UINT, byval pCallback as IAccessibilityDockingServiceCallback ptr) as HRESULT
		UndockWindow as function(byval This as IAccessibilityDockingService ptr, byval hwnd as HWND) as HRESULT
	end type

	type IAccessibilityDockingService_
		lpVtbl as IAccessibilityDockingServiceVtbl ptr
	end type

	#define IAccessibilityDockingService_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IAccessibilityDockingService_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IAccessibilityDockingService_Release(This) (This)->lpVtbl->Release(This)
	#define IAccessibilityDockingService_GetAvailableSize(This, hMonitor, pcxFixed, pcyMax) (This)->lpVtbl->GetAvailableSize(This, hMonitor, pcxFixed, pcyMax)
	#define IAccessibilityDockingService_DockWindow(This, hwnd, hMonitor, cyRequested, pCallback) (This)->lpVtbl->DockWindow(This, hwnd, hMonitor, cyRequested, pCallback)
	#define IAccessibilityDockingService_UndockWindow(This, hwnd) (This)->lpVtbl->UndockWindow(This, hwnd)

	declare function IAccessibilityDockingService_GetAvailableSize_Proxy(byval This as IAccessibilityDockingService ptr, byval hMonitor as HMONITOR, byval pcxFixed as UINT ptr, byval pcyMax as UINT ptr) as HRESULT
	declare sub IAccessibilityDockingService_GetAvailableSize_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IAccessibilityDockingService_DockWindow_Proxy(byval This as IAccessibilityDockingService ptr, byval hwnd as HWND, byval hMonitor as HMONITOR, byval cyRequested as UINT, byval pCallback as IAccessibilityDockingServiceCallback ptr) as HRESULT
	declare sub IAccessibilityDockingService_DockWindow_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IAccessibilityDockingService_UndockWindow_Proxy(byval This as IAccessibilityDockingService ptr, byval hwnd as HWND) as HRESULT
	declare sub IAccessibilityDockingService_UndockWindow_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

	type MONITOR_APP_VISIBILITY as long
	enum
		MAV_UNKNOWN = 0
		MAV_NO_APP_VISIBLE = 1
		MAV_APP_VISIBLE = 2
	end enum

	#define __IAppVisibilityEvents_INTERFACE_DEFINED__
	extern IID_IAppVisibilityEvents as const GUID
	type IAppVisibilityEvents as IAppVisibilityEvents_

	type IAppVisibilityEventsVtbl
		QueryInterface as function(byval This as IAppVisibilityEvents ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IAppVisibilityEvents ptr) as ULONG
		Release as function(byval This as IAppVisibilityEvents ptr) as ULONG
		AppVisibilityOnMonitorChanged as function(byval This as IAppVisibilityEvents ptr, byval hMonitor as HMONITOR, byval previousMode as MONITOR_APP_VISIBILITY, byval currentMode as MONITOR_APP_VISIBILITY) as HRESULT
		LauncherVisibilityChange as function(byval This as IAppVisibilityEvents ptr, byval currentVisibleState as WINBOOL) as HRESULT
	end type

	type IAppVisibilityEvents_
		lpVtbl as IAppVisibilityEventsVtbl ptr
	end type

	#define IAppVisibilityEvents_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IAppVisibilityEvents_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IAppVisibilityEvents_Release(This) (This)->lpVtbl->Release(This)
	#define IAppVisibilityEvents_AppVisibilityOnMonitorChanged(This, hMonitor, previousMode, currentMode) (This)->lpVtbl->AppVisibilityOnMonitorChanged(This, hMonitor, previousMode, currentMode)
	#define IAppVisibilityEvents_LauncherVisibilityChange(This, currentVisibleState) (This)->lpVtbl->LauncherVisibilityChange(This, currentVisibleState)

	declare function IAppVisibilityEvents_AppVisibilityOnMonitorChanged_Proxy(byval This as IAppVisibilityEvents ptr, byval hMonitor as HMONITOR, byval previousMode as MONITOR_APP_VISIBILITY, byval currentMode as MONITOR_APP_VISIBILITY) as HRESULT
	declare sub IAppVisibilityEvents_AppVisibilityOnMonitorChanged_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IAppVisibilityEvents_LauncherVisibilityChange_Proxy(byval This as IAppVisibilityEvents ptr, byval currentVisibleState as WINBOOL) as HRESULT
	declare sub IAppVisibilityEvents_LauncherVisibilityChange_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	#define __IAppVisibility_INTERFACE_DEFINED__
	extern IID_IAppVisibility as const GUID
	type IAppVisibility as IAppVisibility_

	type IAppVisibilityVtbl
		QueryInterface as function(byval This as IAppVisibility ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IAppVisibility ptr) as ULONG
		Release as function(byval This as IAppVisibility ptr) as ULONG
		GetAppVisibilityOnMonitor as function(byval This as IAppVisibility ptr, byval hMonitor as HMONITOR, byval pMode as MONITOR_APP_VISIBILITY ptr) as HRESULT
		IsLauncherVisible as function(byval This as IAppVisibility ptr, byval pfVisible as WINBOOL ptr) as HRESULT
		Advise as function(byval This as IAppVisibility ptr, byval pCallback as IAppVisibilityEvents ptr, byval pdwCookie as DWORD ptr) as HRESULT
		Unadvise as function(byval This as IAppVisibility ptr, byval dwCookie as DWORD) as HRESULT
	end type

	type IAppVisibility_
		lpVtbl as IAppVisibilityVtbl ptr
	end type

	#define IAppVisibility_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IAppVisibility_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IAppVisibility_Release(This) (This)->lpVtbl->Release(This)
	#define IAppVisibility_GetAppVisibilityOnMonitor(This, hMonitor, pMode) (This)->lpVtbl->GetAppVisibilityOnMonitor(This, hMonitor, pMode)
	#define IAppVisibility_IsLauncherVisible(This, pfVisible) (This)->lpVtbl->IsLauncherVisible(This, pfVisible)
	#define IAppVisibility_Advise(This, pCallback, pdwCookie) (This)->lpVtbl->Advise(This, pCallback, pdwCookie)
	#define IAppVisibility_Unadvise(This, dwCookie) (This)->lpVtbl->Unadvise(This, dwCookie)

	declare function IAppVisibility_GetAppVisibilityOnMonitor_Proxy(byval This as IAppVisibility ptr, byval hMonitor as HMONITOR, byval pMode as MONITOR_APP_VISIBILITY ptr) as HRESULT
	declare sub IAppVisibility_GetAppVisibilityOnMonitor_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IAppVisibility_IsLauncherVisible_Proxy(byval This as IAppVisibility ptr, byval pfVisible as WINBOOL ptr) as HRESULT
	declare sub IAppVisibility_IsLauncherVisible_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IAppVisibility_Advise_Proxy(byval This as IAppVisibility ptr, byval pCallback as IAppVisibilityEvents ptr, byval pdwCookie as DWORD ptr) as HRESULT
	declare sub IAppVisibility_Advise_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IAppVisibility_Unadvise_Proxy(byval This as IAppVisibility ptr, byval dwCookie as DWORD) as HRESULT
	declare sub IAppVisibility_Unadvise_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

	type PACKAGE_EXECUTION_STATE as long
	enum
		PES_UNKNOWN = 0
		PES_RUNNING = 1
		PES_SUSPENDING = 2
		PES_SUSPENDED = 3
		PES_TERMINATED = 4
	end enum

	#define __IPackageExecutionStateChangeNotification_INTERFACE_DEFINED__
	extern IID_IPackageExecutionStateChangeNotification as const GUID
	type IPackageExecutionStateChangeNotification as IPackageExecutionStateChangeNotification_

	type IPackageExecutionStateChangeNotificationVtbl
		QueryInterface as function(byval This as IPackageExecutionStateChangeNotification ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IPackageExecutionStateChangeNotification ptr) as ULONG
		Release as function(byval This as IPackageExecutionStateChangeNotification ptr) as ULONG
		OnStateChanged as function(byval This as IPackageExecutionStateChangeNotification ptr, byval pszPackageFullName as LPCWSTR, byval pesNewState as PACKAGE_EXECUTION_STATE) as HRESULT
	end type

	type IPackageExecutionStateChangeNotification_
		lpVtbl as IPackageExecutionStateChangeNotificationVtbl ptr
	end type

	#define IPackageExecutionStateChangeNotification_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IPackageExecutionStateChangeNotification_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IPackageExecutionStateChangeNotification_Release(This) (This)->lpVtbl->Release(This)
	#define IPackageExecutionStateChangeNotification_OnStateChanged(This, pszPackageFullName, pesNewState) (This)->lpVtbl->OnStateChanged(This, pszPackageFullName, pesNewState)
	declare function IPackageExecutionStateChangeNotification_OnStateChanged_Proxy(byval This as IPackageExecutionStateChangeNotification ptr, byval pszPackageFullName as LPCWSTR, byval pesNewState as PACKAGE_EXECUTION_STATE) as HRESULT
	declare sub IPackageExecutionStateChangeNotification_OnStateChanged_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	#define __IPackageDebugSettings_INTERFACE_DEFINED__
	extern IID_IPackageDebugSettings as const GUID
	type IPackageDebugSettings as IPackageDebugSettings_

	type IPackageDebugSettingsVtbl
		QueryInterface as function(byval This as IPackageDebugSettings ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IPackageDebugSettings ptr) as ULONG
		Release as function(byval This as IPackageDebugSettings ptr) as ULONG
		EnableDebugging as function(byval This as IPackageDebugSettings ptr, byval packageFullName as LPCWSTR, byval debuggerCommandLine as LPCWSTR, byval environment as PZZWSTR) as HRESULT
		DisableDebugging as function(byval This as IPackageDebugSettings ptr, byval packageFullName as LPCWSTR) as HRESULT
		Suspend as function(byval This as IPackageDebugSettings ptr, byval packageFullName as LPCWSTR) as HRESULT
		Resume as function(byval This as IPackageDebugSettings ptr, byval packageFullName as LPCWSTR) as HRESULT
		TerminateAllProcesses as function(byval This as IPackageDebugSettings ptr, byval packageFullName as LPCWSTR) as HRESULT
		SetTargetSessionId as function(byval This as IPackageDebugSettings ptr, byval sessionId as ULONG) as HRESULT
		EnumerateBackgroundTasks as function(byval This as IPackageDebugSettings ptr, byval packageFullName as LPCWSTR, byval taskCount as ULONG ptr, byval taskIds as LPCGUID ptr, byval taskNames as LPCWSTR ptr ptr) as HRESULT
		ActivateBackgroundTask as function(byval This as IPackageDebugSettings ptr, byval taskId as LPCGUID) as HRESULT
		StartServicing as function(byval This as IPackageDebugSettings ptr, byval packageFullName as LPCWSTR) as HRESULT
		StopServicing as function(byval This as IPackageDebugSettings ptr, byval packageFullName as LPCWSTR) as HRESULT
		StartSessionRedirection as function(byval This as IPackageDebugSettings ptr, byval packageFullName as LPCWSTR, byval sessionId as ULONG) as HRESULT
		StopSessionRedirection as function(byval This as IPackageDebugSettings ptr, byval packageFullName as LPCWSTR) as HRESULT
		GetPackageExecutionState as function(byval This as IPackageDebugSettings ptr, byval packageFullName as LPCWSTR, byval packageExecutionState as PACKAGE_EXECUTION_STATE ptr) as HRESULT
		RegisterForPackageStateChanges as function(byval This as IPackageDebugSettings ptr, byval packageFullName as LPCWSTR, byval pPackageExecutionStateChangeNotification as IPackageExecutionStateChangeNotification ptr, byval pdwCookie as DWORD ptr) as HRESULT
		UnregisterForPackageStateChanges as function(byval This as IPackageDebugSettings ptr, byval dwCookie as DWORD) as HRESULT
	end type

	type IPackageDebugSettings_
		lpVtbl as IPackageDebugSettingsVtbl ptr
	end type

	#define IPackageDebugSettings_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IPackageDebugSettings_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IPackageDebugSettings_Release(This) (This)->lpVtbl->Release(This)
	#define IPackageDebugSettings_EnableDebugging(This, packageFullName, debuggerCommandLine, environment) (This)->lpVtbl->EnableDebugging(This, packageFullName, debuggerCommandLine, environment)
	#define IPackageDebugSettings_DisableDebugging(This, packageFullName) (This)->lpVtbl->DisableDebugging(This, packageFullName)
	#define IPackageDebugSettings_Suspend(This, packageFullName) (This)->lpVtbl->Suspend(This, packageFullName)
	#define IPackageDebugSettings_Resume(This, packageFullName) (This)->lpVtbl->Resume(This, packageFullName)
	#define IPackageDebugSettings_TerminateAllProcesses(This, packageFullName) (This)->lpVtbl->TerminateAllProcesses(This, packageFullName)
	#define IPackageDebugSettings_SetTargetSessionId(This, sessionId) (This)->lpVtbl->SetTargetSessionId(This, sessionId)
	#define IPackageDebugSettings_EnumerateBackgroundTasks(This, packageFullName, taskCount, taskIds, taskNames) (This)->lpVtbl->EnumerateBackgroundTasks(This, packageFullName, taskCount, taskIds, taskNames)
	#define IPackageDebugSettings_ActivateBackgroundTask(This, taskId) (This)->lpVtbl->ActivateBackgroundTask(This, taskId)
	#define IPackageDebugSettings_StartServicing(This, packageFullName) (This)->lpVtbl->StartServicing(This, packageFullName)
	#define IPackageDebugSettings_StopServicing(This, packageFullName) (This)->lpVtbl->StopServicing(This, packageFullName)
	#define IPackageDebugSettings_StartSessionRedirection(This, packageFullName, sessionId) (This)->lpVtbl->StartSessionRedirection(This, packageFullName, sessionId)
	#define IPackageDebugSettings_StopSessionRedirection(This, packageFullName) (This)->lpVtbl->StopSessionRedirection(This, packageFullName)
	#define IPackageDebugSettings_GetPackageExecutionState(This, packageFullName, packageExecutionState) (This)->lpVtbl->GetPackageExecutionState(This, packageFullName, packageExecutionState)
	#define IPackageDebugSettings_RegisterForPackageStateChanges(This, packageFullName, pPackageExecutionStateChangeNotification, pdwCookie) (This)->lpVtbl->RegisterForPackageStateChanges(This, packageFullName, pPackageExecutionStateChangeNotification, pdwCookie)
	#define IPackageDebugSettings_UnregisterForPackageStateChanges(This, dwCookie) (This)->lpVtbl->UnregisterForPackageStateChanges(This, dwCookie)

	declare function IPackageDebugSettings_EnableDebugging_Proxy(byval This as IPackageDebugSettings ptr, byval packageFullName as LPCWSTR, byval debuggerCommandLine as LPCWSTR, byval environment as PZZWSTR) as HRESULT
	declare sub IPackageDebugSettings_EnableDebugging_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IPackageDebugSettings_DisableDebugging_Proxy(byval This as IPackageDebugSettings ptr, byval packageFullName as LPCWSTR) as HRESULT
	declare sub IPackageDebugSettings_DisableDebugging_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IPackageDebugSettings_Suspend_Proxy(byval This as IPackageDebugSettings ptr, byval packageFullName as LPCWSTR) as HRESULT
	declare sub IPackageDebugSettings_Suspend_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IPackageDebugSettings_Resume_Proxy(byval This as IPackageDebugSettings ptr, byval packageFullName as LPCWSTR) as HRESULT
	declare sub IPackageDebugSettings_Resume_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IPackageDebugSettings_TerminateAllProcesses_Proxy(byval This as IPackageDebugSettings ptr, byval packageFullName as LPCWSTR) as HRESULT
	declare sub IPackageDebugSettings_TerminateAllProcesses_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IPackageDebugSettings_SetTargetSessionId_Proxy(byval This as IPackageDebugSettings ptr, byval sessionId as ULONG) as HRESULT
	declare sub IPackageDebugSettings_SetTargetSessionId_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IPackageDebugSettings_EnumerateBackgroundTasks_Proxy(byval This as IPackageDebugSettings ptr, byval packageFullName as LPCWSTR, byval taskCount as ULONG ptr, byval taskIds as LPCGUID ptr, byval taskNames as LPCWSTR ptr ptr) as HRESULT
	declare sub IPackageDebugSettings_EnumerateBackgroundTasks_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IPackageDebugSettings_ActivateBackgroundTask_Proxy(byval This as IPackageDebugSettings ptr, byval taskId as LPCGUID) as HRESULT
	declare sub IPackageDebugSettings_ActivateBackgroundTask_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IPackageDebugSettings_StartServicing_Proxy(byval This as IPackageDebugSettings ptr, byval packageFullName as LPCWSTR) as HRESULT
	declare sub IPackageDebugSettings_StartServicing_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IPackageDebugSettings_StopServicing_Proxy(byval This as IPackageDebugSettings ptr, byval packageFullName as LPCWSTR) as HRESULT
	declare sub IPackageDebugSettings_StopServicing_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IPackageDebugSettings_StartSessionRedirection_Proxy(byval This as IPackageDebugSettings ptr, byval packageFullName as LPCWSTR, byval sessionId as ULONG) as HRESULT
	declare sub IPackageDebugSettings_StartSessionRedirection_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IPackageDebugSettings_StopSessionRedirection_Proxy(byval This as IPackageDebugSettings ptr, byval packageFullName as LPCWSTR) as HRESULT
	declare sub IPackageDebugSettings_StopSessionRedirection_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IPackageDebugSettings_GetPackageExecutionState_Proxy(byval This as IPackageDebugSettings ptr, byval packageFullName as LPCWSTR, byval packageExecutionState as PACKAGE_EXECUTION_STATE ptr) as HRESULT
	declare sub IPackageDebugSettings_GetPackageExecutionState_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IPackageDebugSettings_RegisterForPackageStateChanges_Proxy(byval This as IPackageDebugSettings ptr, byval packageFullName as LPCWSTR, byval pPackageExecutionStateChangeNotification as IPackageExecutionStateChangeNotification ptr, byval pdwCookie as DWORD ptr) as HRESULT
	declare sub IPackageDebugSettings_RegisterForPackageStateChanges_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IPackageDebugSettings_UnregisterForPackageStateChanges_Proxy(byval This as IPackageDebugSettings ptr, byval dwCookie as DWORD) as HRESULT
	declare sub IPackageDebugSettings_UnregisterForPackageStateChanges_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

	type AHE_TYPE as long
	enum
		AHE_DESKTOP = 0
		AHE_IMMERSIVE = 1
	end enum

	#define __IExecuteCommandApplicationHostEnvironment_INTERFACE_DEFINED__
	extern IID_IExecuteCommandApplicationHostEnvironment as const GUID
	type IExecuteCommandApplicationHostEnvironment as IExecuteCommandApplicationHostEnvironment_

	type IExecuteCommandApplicationHostEnvironmentVtbl
		QueryInterface as function(byval This as IExecuteCommandApplicationHostEnvironment ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IExecuteCommandApplicationHostEnvironment ptr) as ULONG
		Release as function(byval This as IExecuteCommandApplicationHostEnvironment ptr) as ULONG
		GetValue as function(byval This as IExecuteCommandApplicationHostEnvironment ptr, byval pahe as AHE_TYPE ptr) as HRESULT
	end type

	type IExecuteCommandApplicationHostEnvironment_
		lpVtbl as IExecuteCommandApplicationHostEnvironmentVtbl ptr
	end type

	#define IExecuteCommandApplicationHostEnvironment_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IExecuteCommandApplicationHostEnvironment_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IExecuteCommandApplicationHostEnvironment_Release(This) (This)->lpVtbl->Release(This)
	#define IExecuteCommandApplicationHostEnvironment_GetValue(This, pahe) (This)->lpVtbl->GetValue(This, pahe)
	declare function IExecuteCommandApplicationHostEnvironment_GetValue_Proxy(byval This as IExecuteCommandApplicationHostEnvironment ptr, byval pahe as AHE_TYPE ptr) as HRESULT
	declare sub IExecuteCommandApplicationHostEnvironment_GetValue_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

	type EC_HOST_UI_MODE as long
	enum
		ECHUIM_DESKTOP = 0
		ECHUIM_IMMERSIVE = 1
		ECHUIM_SYSTEM_LAUNCHER = 2
	end enum

	#define __IExecuteCommandHost_INTERFACE_DEFINED__
	extern IID_IExecuteCommandHost as const GUID
	type IExecuteCommandHost as IExecuteCommandHost_

	type IExecuteCommandHostVtbl
		QueryInterface as function(byval This as IExecuteCommandHost ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IExecuteCommandHost ptr) as ULONG
		Release as function(byval This as IExecuteCommandHost ptr) as ULONG
		GetUIMode as function(byval This as IExecuteCommandHost ptr, byval pUIMode as EC_HOST_UI_MODE ptr) as HRESULT
	end type

	type IExecuteCommandHost_
		lpVtbl as IExecuteCommandHostVtbl ptr
	end type

	#define IExecuteCommandHost_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IExecuteCommandHost_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IExecuteCommandHost_Release(This) (This)->lpVtbl->Release(This)
	#define IExecuteCommandHost_GetUIMode(This, pUIMode) (This)->lpVtbl->GetUIMode(This, pUIMode)
	declare function IExecuteCommandHost_GetUIMode_Proxy(byval This as IExecuteCommandHost ptr, byval pUIMode as EC_HOST_UI_MODE ptr) as HRESULT
	declare sub IExecuteCommandHost_GetUIMode_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	extern SID_ExecuteCommandHost alias "IID_IExecuteCommandHost" as const GUID

	type APPLICATION_VIEW_STATE as long
	enum
		AVS_FULLSCREEN_LANDSCAPE = 0
		AVS_FILLED = 1
		AVS_SNAPPED = 2
		AVS_FULLSCREEN_PORTRAIT = 3
	end enum

	type EDGE_GESTURE_KIND as long
	enum
		EGK_TOUCH = 0
		EGK_KEYBOARD = 1
		EGK_MOUSE = 2
	end enum

	#define __IApplicationDesignModeSettings_INTERFACE_DEFINED__
	extern IID_IApplicationDesignModeSettings as const GUID
	type IApplicationDesignModeSettings as IApplicationDesignModeSettings_

	type IApplicationDesignModeSettingsVtbl
		QueryInterface as function(byval This as IApplicationDesignModeSettings ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IApplicationDesignModeSettings ptr) as ULONG
		Release as function(byval This as IApplicationDesignModeSettings ptr) as ULONG
		SetNativeDisplaySize as function(byval This as IApplicationDesignModeSettings ptr, byval sizeNativeDisplay as SIZE) as HRESULT
		SetScaleFactor as function(byval This as IApplicationDesignModeSettings ptr, byval scaleFactor as DEVICE_SCALE_FACTOR) as HRESULT
		SetApplicationViewState as function(byval This as IApplicationDesignModeSettings ptr, byval viewState as APPLICATION_VIEW_STATE) as HRESULT
		ComputeApplicationSize as function(byval This as IApplicationDesignModeSettings ptr, byval psizeApplication as SIZE ptr) as HRESULT
		IsApplicationViewStateSupported as function(byval This as IApplicationDesignModeSettings ptr, byval viewState as APPLICATION_VIEW_STATE, byval sizeNativeDisplay as SIZE, byval scaleFactor as DEVICE_SCALE_FACTOR, byval pfSupported as WINBOOL ptr) as HRESULT
		TriggerEdgeGesture as function(byval This as IApplicationDesignModeSettings ptr, byval edgeGestureKind as EDGE_GESTURE_KIND) as HRESULT
	end type

	type IApplicationDesignModeSettings_
		lpVtbl as IApplicationDesignModeSettingsVtbl ptr
	end type

	#define IApplicationDesignModeSettings_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IApplicationDesignModeSettings_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IApplicationDesignModeSettings_Release(This) (This)->lpVtbl->Release(This)
	#define IApplicationDesignModeSettings_SetNativeDisplaySize(This, sizeNativeDisplay) (This)->lpVtbl->SetNativeDisplaySize(This, sizeNativeDisplay)
	#define IApplicationDesignModeSettings_SetScaleFactor(This, scaleFactor) (This)->lpVtbl->SetScaleFactor(This, scaleFactor)
	#define IApplicationDesignModeSettings_SetApplicationViewState(This, viewState) (This)->lpVtbl->SetApplicationViewState(This, viewState)
	#define IApplicationDesignModeSettings_ComputeApplicationSize(This, psizeApplication) (This)->lpVtbl->ComputeApplicationSize(This, psizeApplication)
	#define IApplicationDesignModeSettings_IsApplicationViewStateSupported(This, viewState, sizeNativeDisplay, scaleFactor, pfSupported) (This)->lpVtbl->IsApplicationViewStateSupported(This, viewState, sizeNativeDisplay, scaleFactor, pfSupported)
	#define IApplicationDesignModeSettings_TriggerEdgeGesture(This, edgeGestureKind) (This)->lpVtbl->TriggerEdgeGesture(This, edgeGestureKind)

	declare function IApplicationDesignModeSettings_SetNativeDisplaySize_Proxy(byval This as IApplicationDesignModeSettings ptr, byval sizeNativeDisplay as SIZE) as HRESULT
	declare sub IApplicationDesignModeSettings_SetNativeDisplaySize_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IApplicationDesignModeSettings_SetScaleFactor_Proxy(byval This as IApplicationDesignModeSettings ptr, byval scaleFactor as DEVICE_SCALE_FACTOR) as HRESULT
	declare sub IApplicationDesignModeSettings_SetScaleFactor_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IApplicationDesignModeSettings_SetApplicationViewState_Proxy(byval This as IApplicationDesignModeSettings ptr, byval viewState as APPLICATION_VIEW_STATE) as HRESULT
	declare sub IApplicationDesignModeSettings_SetApplicationViewState_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IApplicationDesignModeSettings_ComputeApplicationSize_Proxy(byval This as IApplicationDesignModeSettings ptr, byval psizeApplication as SIZE ptr) as HRESULT
	declare sub IApplicationDesignModeSettings_ComputeApplicationSize_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IApplicationDesignModeSettings_IsApplicationViewStateSupported_Proxy(byval This as IApplicationDesignModeSettings ptr, byval viewState as APPLICATION_VIEW_STATE, byval sizeNativeDisplay as SIZE, byval scaleFactor as DEVICE_SCALE_FACTOR, byval pfSupported as WINBOOL ptr) as HRESULT
	declare sub IApplicationDesignModeSettings_IsApplicationViewStateSupported_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IApplicationDesignModeSettings_TriggerEdgeGesture_Proxy(byval This as IApplicationDesignModeSettings ptr, byval edgeGestureKind as EDGE_GESTURE_KIND) as HRESULT
	declare sub IApplicationDesignModeSettings_TriggerEdgeGesture_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	#define __IInitializeWithWindow_INTERFACE_DEFINED__
	extern IID_IInitializeWithWindow as const GUID
	type IInitializeWithWindow as IInitializeWithWindow_

	type IInitializeWithWindowVtbl
		QueryInterface as function(byval This as IInitializeWithWindow ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IInitializeWithWindow ptr) as ULONG
		Release as function(byval This as IInitializeWithWindow ptr) as ULONG
		Initialize as function(byval This as IInitializeWithWindow ptr, byval hwnd as HWND) as HRESULT
	end type

	type IInitializeWithWindow_
		lpVtbl as IInitializeWithWindowVtbl ptr
	end type

	#define IInitializeWithWindow_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IInitializeWithWindow_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IInitializeWithWindow_Release(This) (This)->lpVtbl->Release(This)
	#define IInitializeWithWindow_Initialize(This, hwnd) (This)->lpVtbl->Initialize(This, hwnd)
	declare function IInitializeWithWindow_Initialize_Proxy(byval This as IInitializeWithWindow ptr, byval hwnd as HWND) as HRESULT
	declare sub IInitializeWithWindow_Initialize_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	#define __IHandlerInfo_INTERFACE_DEFINED__
	extern IID_IHandlerInfo as const GUID
	type IHandlerInfo as IHandlerInfo_

	type IHandlerInfoVtbl
		QueryInterface as function(byval This as IHandlerInfo ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IHandlerInfo ptr) as ULONG
		Release as function(byval This as IHandlerInfo ptr) as ULONG
		GetApplicationDisplayName as function(byval This as IHandlerInfo ptr, byval value as LPWSTR ptr) as HRESULT
		GetApplicationPublisher as function(byval This as IHandlerInfo ptr, byval value as LPWSTR ptr) as HRESULT
		GetApplicationIconReference as function(byval This as IHandlerInfo ptr, byval value as LPWSTR ptr) as HRESULT
	end type

	type IHandlerInfo_
		lpVtbl as IHandlerInfoVtbl ptr
	end type

	#define IHandlerInfo_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IHandlerInfo_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IHandlerInfo_Release(This) (This)->lpVtbl->Release(This)
	#define IHandlerInfo_GetApplicationDisplayName(This, value) (This)->lpVtbl->GetApplicationDisplayName(This, value)
	#define IHandlerInfo_GetApplicationPublisher(This, value) (This)->lpVtbl->GetApplicationPublisher(This, value)
	#define IHandlerInfo_GetApplicationIconReference(This, value) (This)->lpVtbl->GetApplicationIconReference(This, value)

	declare function IHandlerInfo_GetApplicationDisplayName_Proxy(byval This as IHandlerInfo ptr, byval value as LPWSTR ptr) as HRESULT
	declare sub IHandlerInfo_GetApplicationDisplayName_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IHandlerInfo_GetApplicationPublisher_Proxy(byval This as IHandlerInfo ptr, byval value as LPWSTR ptr) as HRESULT
	declare sub IHandlerInfo_GetApplicationPublisher_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IHandlerInfo_GetApplicationIconReference_Proxy(byval This as IHandlerInfo ptr, byval value as LPWSTR ptr) as HRESULT
	declare sub IHandlerInfo_GetApplicationIconReference_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	#define __IHandlerActivationHost_INTERFACE_DEFINED__
	extern IID_IHandlerActivationHost as const GUID
	type IHandlerActivationHost as IHandlerActivationHost_

	type IHandlerActivationHostVtbl
		QueryInterface as function(byval This as IHandlerActivationHost ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IHandlerActivationHost ptr) as ULONG
		Release as function(byval This as IHandlerActivationHost ptr) as ULONG
		BeforeCoCreateInstance as function(byval This as IHandlerActivationHost ptr, byval clsidHandler as const IID const ptr, byval itemsBeingActivated as IShellItemArray ptr, byval handlerInfo as IHandlerInfo ptr) as HRESULT
		BeforeCreateProcess as function(byval This as IHandlerActivationHost ptr, byval applicationPath as LPCWSTR, byval commandLine as LPCWSTR, byval handlerInfo as IHandlerInfo ptr) as HRESULT
	end type

	type IHandlerActivationHost_
		lpVtbl as IHandlerActivationHostVtbl ptr
	end type

	#define IHandlerActivationHost_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IHandlerActivationHost_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IHandlerActivationHost_Release(This) (This)->lpVtbl->Release(This)
	#define IHandlerActivationHost_BeforeCoCreateInstance(This, clsidHandler, itemsBeingActivated, handlerInfo) (This)->lpVtbl->BeforeCoCreateInstance(This, clsidHandler, itemsBeingActivated, handlerInfo)
	#define IHandlerActivationHost_BeforeCreateProcess(This, applicationPath, commandLine, handlerInfo) (This)->lpVtbl->BeforeCreateProcess(This, applicationPath, commandLine, handlerInfo)

	declare function IHandlerActivationHost_BeforeCoCreateInstance_Proxy(byval This as IHandlerActivationHost ptr, byval clsidHandler as const IID const ptr, byval itemsBeingActivated as IShellItemArray ptr, byval handlerInfo as IHandlerInfo ptr) as HRESULT
	declare sub IHandlerActivationHost_BeforeCoCreateInstance_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	declare function IHandlerActivationHost_BeforeCreateProcess_Proxy(byval This as IHandlerActivationHost ptr, byval applicationPath as LPCWSTR, byval commandLine as LPCWSTR, byval handlerInfo as IHandlerInfo ptr) as HRESULT
	declare sub IHandlerActivationHost_BeforeCreateProcess_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
	extern SID_SHandlerActivationHost alias "IID_IHandlerActivationHost" as const GUID
	extern SID_ShellExecuteNamedPropertyStore as const GUID
#endif

declare function PCIDLIST_ABSOLUTE_UserSize(byval as ULONG ptr, byval as ULONG, byval as LPCITEMIDLIST ptr) as ULONG
declare function PCIDLIST_ABSOLUTE_UserMarshal(byval as ULONG ptr, byval as ubyte ptr, byval as LPCITEMIDLIST ptr) as ubyte ptr
declare function PCIDLIST_ABSOLUTE_UserUnmarshal(byval as ULONG ptr, byval as ubyte ptr, byval as LPCITEMIDLIST ptr) as ubyte ptr
declare sub PCIDLIST_ABSOLUTE_UserFree(byval as ULONG ptr, byval as LPCITEMIDLIST ptr)
declare function PIDLIST_ABSOLUTE_UserSize(byval as ULONG ptr, byval as ULONG, byval as LPITEMIDLIST ptr) as ULONG
declare function PIDLIST_ABSOLUTE_UserMarshal(byval as ULONG ptr, byval as ubyte ptr, byval as LPITEMIDLIST ptr) as ubyte ptr
declare function PIDLIST_ABSOLUTE_UserUnmarshal(byval as ULONG ptr, byval as ubyte ptr, byval as LPITEMIDLIST ptr) as ubyte ptr
declare sub PIDLIST_ABSOLUTE_UserFree(byval as ULONG ptr, byval as LPITEMIDLIST ptr)
declare function PITEMID_CHILD_UserSize(byval as ULONG ptr, byval as ULONG, byval as LPITEMIDLIST ptr) as ULONG
declare function PITEMID_CHILD_UserMarshal(byval as ULONG ptr, byval as ubyte ptr, byval as LPITEMIDLIST ptr) as ubyte ptr
declare function PITEMID_CHILD_UserUnmarshal(byval as ULONG ptr, byval as ubyte ptr, byval as LPITEMIDLIST ptr) as ubyte ptr
declare sub PITEMID_CHILD_UserFree(byval as ULONG ptr, byval as LPITEMIDLIST ptr)
declare function PIDLIST_RELATIVE_UserSize(byval as ULONG ptr, byval as ULONG, byval as LPITEMIDLIST ptr) as ULONG
declare function PIDLIST_RELATIVE_UserMarshal(byval as ULONG ptr, byval as ubyte ptr, byval as LPITEMIDLIST ptr) as ubyte ptr
declare function PIDLIST_RELATIVE_UserUnmarshal(byval as ULONG ptr, byval as ubyte ptr, byval as LPITEMIDLIST ptr) as ubyte ptr
declare sub PIDLIST_RELATIVE_UserFree(byval as ULONG ptr, byval as LPITEMIDLIST ptr)
declare function PCUIDLIST_RELATIVE_UserSize(byval as ULONG ptr, byval as ULONG, byval as LPCITEMIDLIST ptr) as ULONG
declare function PCUIDLIST_RELATIVE_UserMarshal(byval as ULONG ptr, byval as ubyte ptr, byval as LPCITEMIDLIST ptr) as ubyte ptr
declare function PCUIDLIST_RELATIVE_UserUnmarshal(byval as ULONG ptr, byval as ubyte ptr, byval as LPCITEMIDLIST ptr) as ubyte ptr
declare sub PCUIDLIST_RELATIVE_UserFree(byval as ULONG ptr, byval as LPCITEMIDLIST ptr)
declare function PCUITEMID_CHILD_UserSize(byval as ULONG ptr, byval as ULONG, byval as LPCITEMIDLIST ptr) as ULONG
declare function PCUITEMID_CHILD_UserMarshal(byval as ULONG ptr, byval as ubyte ptr, byval as LPCITEMIDLIST ptr) as ubyte ptr
declare function PCUITEMID_CHILD_UserUnmarshal(byval as ULONG ptr, byval as ubyte ptr, byval as LPCITEMIDLIST ptr) as ubyte ptr
declare sub PCUITEMID_CHILD_UserFree(byval as ULONG ptr, byval as LPCITEMIDLIST ptr)
declare function HMONITOR_UserSize(byval as ULONG ptr, byval as ULONG, byval as HMONITOR ptr) as ULONG
declare function HMONITOR_UserMarshal(byval as ULONG ptr, byval as ubyte ptr, byval as HMONITOR ptr) as ubyte ptr
declare function HMONITOR_UserUnmarshal(byval as ULONG ptr, byval as ubyte ptr, byval as HMONITOR ptr) as ubyte ptr
declare sub HMONITOR_UserFree(byval as ULONG ptr, byval as HMONITOR ptr)

end extern

#include once "ole-common.bi"
