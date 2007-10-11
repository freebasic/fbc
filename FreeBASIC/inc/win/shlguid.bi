''
''
'' shlguid -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_shlguid_bi__
#define __win_shlguid_bi__

#inclib "uuid"
#inclib "shell32"

#define DEFINE_SHLGUID(n,l,w1,w2) DEFINE_GUID(n,l,w1,w2,&hC0,0,0,0,0,0,0,&h46)
#define SID_SShellBrowser IID_IShellBrowser

extern CLSID_ShellDesktop alias "CLSID_ShellDesktop" as GUID
extern CLSID_ShellLink alias "CLSID_ShellLink" as GUID
extern FMTID_Intshcut alias "FMTID_Intshcut" as GUID
extern FMTID_InternetSite alias "FMTID_InternetSite" as GUID
extern CGID_Explorer alias "CGID_Explorer" as GUID
extern CGID_ShellDocView alias "CGID_ShellDocView" as GUID
extern CGID_ShellServiceObject alias "CGID_ShellServiceObject" as GUID
extern IID_INewShortcutHookA alias "IID_INewShortcutHookA" as GUID
extern IID_IShellBrowser alias "IID_IShellBrowser" as GUID
extern IID_IShellView alias "IID_IShellView" as GUID
extern IID_IContextMenu alias "IID_IContextMenu" as GUID
extern IID_IColumnProvider alias "IID_IColumnProvider" as GUID
extern IID_IQueryInfo alias "IID_IQueryInfo" as GUID
extern IID_IShellIcon alias "IID_IShellIcon" as GUID
extern IID_IShellIconOverlayIdentifier alias "IID_IShellIconOverlayIdentifier" as GUID
extern IID_IShellFolder alias "IID_IShellFolder" as GUID
extern IID_IShellExtInit alias "IID_IShellExtInit" as GUID
extern IID_IShellPropSheetExt alias "IID_IShellPropSheetExt" as GUID
extern IID_IPersistFolder alias "IID_IPersistFolder" as GUID
extern IID_IExtractIconA alias "IID_IExtractIconA" as GUID
extern IID_IShellLinkA alias "IID_IShellLinkA" as GUID
extern IID_IShellCopyHookA alias "IID_IShellCopyHookA" as GUID
extern IID_IFileViewerA alias "IID_IFileViewerA" as GUID
extern IID_ICommDlgBrowser alias "IID_ICommDlgBrowser" as GUID
extern IID_IEnumIDList alias "IID_IEnumIDList" as GUID
extern IID_IFileViewerSite alias "IID_IFileViewerSite" as GUID
extern IID_IContextMenu2 alias "IID_IContextMenu2" as GUID
extern IID_IContextMenu3 alias "IID_IContextMenu3" as GUID
extern IID_IShellExecuteHookA alias "IID_IShellExecuteHookA" as GUID
extern IID_IPropSheetPage alias "IID_IPropSheetPage" as GUID
extern IID_INewShortcutHookW alias "IID_INewShortcutHookW" as GUID
extern IID_IFileViewerW alias "IID_IFileViewerW" as GUID
extern IID_IShellLinkW alias "IID_IShellLinkW" as GUID
extern IID_IExtractIconW alias "IID_IExtractIconW" as GUID
extern IID_IShellExecuteHookW alias "IID_IShellExecuteHookW" as GUID
extern IID_IShellCopyHookW alias "IID_IShellCopyHookW" as GUID
extern IID_IShellView2 alias "IID_IShellView2" as GUID
extern LIBID_SHDocVw alias "LIBID_SHDocVw" as GUID
extern IID_IShellExplorer alias "IID_IShellExplorer" as GUID
extern DIID_DShellExplorerEvents alias "DIID_DShellExplorerEvents" as GUID
extern CLSID_ShellExplorer alias "CLSID_ShellExplorer" as GUID
extern IID_ISHItemOC alias "IID_ISHItemOC" as GUID
extern DIID_DSHItemOCEvents alias "DIID_DSHItemOCEvents" as GUID
extern CLSID_SHItemOC alias "CLSID_SHItemOC" as GUID
extern IID_DHyperLink alias "IID_DHyperLink" as GUID
extern IID_DIExplorer alias "IID_DIExplorer" as GUID
extern DIID_DExplorerEvents alias "DIID_DExplorerEvents" as GUID
extern CLSID_InternetExplorer alias "CLSID_InternetExplorer" as GUID
extern CLSID_StdHyperLink alias "CLSID_StdHyperLink" as GUID
extern CLSID_FileTypes alias "CLSID_FileTypes" as GUID
extern CLSID_InternetShortcut alias "CLSID_InternetShortcut" as GUID
extern IID_IUniformResourceLocator alias "IID_IUniformResourceLocator" as GUID
extern CLSID_DragDropHelper alias "CLSID_DragDropHelper" as GUID
extern IID_IDropTargetHelper alias "IID_IDropTargetHelper" as GUID
extern IID_IDragSourceHelper alias "IID_IDragSourceHelper" as GUID
extern CLSID_AutoComplete alias "CLSID_AutoComplete" as GUID
extern IID_IAutoComplete alias "IID_IAutoComplete" as GUID
extern IID_IAutoComplete2 alias "IID_IAutoComplete2" as GUID
extern CLSID_ACLMulti alias "CLSID_ACLMulti" as GUID
extern IID_IObjMgr alias "IID_IObjMgr" as GUID
extern CLSID_ACListISF alias "CLSID_ACListISF" as GUID
extern IID_IACList alias "IID_IACList" as GUID
extern IID_IPersistFolder2 alias "IID_IPersistFolder2" as GUID
extern IID_IPersistFolder3 alias "IID_IPersistFolder3" as GUID
extern IID_IShellFolder2 alias "IID_IShellFolder2" as GUID
extern IID_IFileSystemBindData alias "IID_IFileSystemBindData" as GUID

#ifdef UNICODE
#define IID_IFileViewer	IID_IFileViewerW
#define IID_IShellLink	IID_IShellLinkW
#define IID_IExtractIcon	IID_IExtractIconW
#define IID_IShellCopyHook	IID_IShellCopyHookW
#define IID_IShellExecuteHook	IID_IShellExecuteHookW
#define IID_INewShortcutHook	IID_INewShortcutHookW
#else
#define IID_IFileViewer	IID_IFileViewerA
#define IID_IShellLink	IID_IShellLinkA
#define IID_IExtractIcon	IID_IExtractIconA
#define IID_IShellCopyHook	IID_IShellCopyHookA
#define IID_IShellExecuteHook	IID_IShellExecuteHookA
#define IID_INewShortcutHook	IID_INewShortcutHookA
#endif

#endif
