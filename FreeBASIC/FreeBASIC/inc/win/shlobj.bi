''
''
'' shlobj -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_shlobj_bi__
#define __win_shlobj_bi__

#include once "win/ole2.bi"
#include once "win/shlguid.bi"
#include once "win/shellapi.bi"
#include once "win/commctrl.bi"

#inclib "shell32"

#define BIF_RETURNONLYFSDIRS   &h0001
#define BIF_DONTGOBELOWDOMAIN  &h0002
#define BIF_STATUSTEXT         &h0004
#define BIF_RETURNFSANCESTORS  &h0008
#define BIF_EDITBOX            &h0010
#define BIF_VALIDATE           &h0020
#define BIF_NEWDIALOGSTYLE     &h0040
#define BIF_USENEWUI           (BIF_NEWDIALOGSTYLE or BIF_EDITBOX)
#define BIF_BROWSEINCLUDEURLS  &h0080
#define BIF_UAHINT             &h0100
#define BIF_NONEWFOLDERBUTTON  &h0200
#define BIF_NOTRANSLATETARGETS &h0400
#define BIF_BROWSEFORCOMPUTER  &h1000
#define BIF_BROWSEFORPRINTER   &h2000
#define BIF_BROWSEINCLUDEFILES &h4000
#define BIF_SHAREABLE          &h8000
#define BFFM_INITIALIZED 1
#define BFFM_SELCHANGED 2
#define BFFM_VALIDATEFAILEDA 3
#define BFFM_VALIDATEFAILEDW 4
#define BFFM_IUNKNOWN 5
#define BFFM_SETSTATUSTEXTA (WM_USER+100)
#define BFFM_SETSTATUSTEXTW (WM_USER+104)
#define BFFM_ENABLEOK (WM_USER+101)
#define BFFM_SETSELECTIONA (WM_USER+102)
#define BFFM_SETSELECTIONW (WM_USER+103)
#define BFFM_SETOKTEXT (WM_USER+105)
#define BFFM_SETEXPANDED (WM_USER+106)
#ifdef UNICODE
#define BFFM_SETSTATUSTEXT BFFM_SETSTATUSTEXTW
#define BFFM_SETSELECTION BFFM_SETSELECTIONW
#define BFFM_VALIDATEFAILED BFFM_VALIDATEFAILEDW
#else
#define BFFM_SETSTATUSTEXT BFFM_SETSTATUSTEXTA
#define BFFM_SETSELECTION BFFM_SETSELECTIONA
#define BFFM_VALIDATEFAILED BFFM_VALIDATEFAILEDA
#endif
#define DVASPECT_SHORTNAME 2
#define SHARD_PIDL 1
#define SHARD_PATH 2
#define SHCNE_RENAMEITEM 1
#define SHCNE_CREATE 2
#define SHCNE_DELETE 4
#define SHCNE_MKDIR 8
#define SHCNE_RMDIR 16
#define SHCNE_MEDIAINSERTED 32
#define SHCNE_MEDIAREMOVED 64
#define SHCNE_DRIVEREMOVED 128
#define SHCNE_DRIVEADD 256
#define SHCNE_NETSHARE 512
#define SHCNE_NETUNSHARE 1024
#define SHCNE_ATTRIBUTES 2048
#define SHCNE_UPDATEDIR 4096
#define SHCNE_UPDATEITEM 8192
#define SHCNE_SERVERDISCONNECT 16384
#define SHCNE_UPDATEIMAGE 32768
#define SHCNE_DRIVEADDGUI 65536
#define SHCNE_RENAMEFOLDER &h20000
#define SHCNE_FREESPACE &h40000
#define SHCNE_ASSOCCHANGED &h8000000
#define SHCNE_DISKEVENTS &h2381F
#define SHCNE_GLOBALEVENTS &hC0581E0
#define SHCNE_ALLEVENTS &h7FFFFFFF
#define SHCNE_INTERRUPT &h80000000
#define SHCNF_IDLIST 0
#define SHCNF_PATH 1
#define SHCNF_PRINTER 2
#define SHCNF_DWORD 3
#define SHCNF_PATHW 5
#define SHCNF_PRINTERW 6
#define SHCNF_TYPE &hFF
#define SHCNF_FLUSH &h1000
#define SHCNF_FLUSHNOWAIT &h2000
#define SFGAO_CANCOPY	DROPEFFECT_COPY
#define SFGAO_CANMOVE	DROPEFFECT_MOVE
#define SFGAO_CANLINK	DROPEFFECT_LINK
#define SFGAO_CANRENAME &h00000010L
#define SFGAO_CANDELETE &h00000020L
#define SFGAO_HASPROPSHEET &h00000040L
#define SFGAO_DROPTARGET &h00000100L
#define SFGAO_CAPABILITYMASK &h00000177L
#define SFGAO_GHOSTED &h00008000L
#define SFGAO_LINK &h00010000L
#define SFGAO_SHARE &h00020000L
#define SFGAO_READONLY &h00040000L
#define SFGAO_HIDDEN &h00080000L
#define SFGAO_DISPLAYATTRMASK &h000F0000L
#define SFGAO_FILESYSANCESTOR &h10000000L
#define SFGAO_FOLDER &h20000000L
#define SFGAO_FILESYSTEM &h40000000L
#define SFGAO_HASSUBFOLDER &h80000000L
#define SFGAO_CONTENTSMASK &h80000000L
#define SFGAO_VALIDATE &h01000000L
#define SFGAO_REMOVABLE &h02000000L
#define SFGAO_COMPRESSED &h04000000L
#define STRRET_WSTR 0
#define STRRET_OFFSET 1
#define STRRET_CSTR 2
#define SHGDFIL_FINDDATA 1
#define SHGDFIL_NETRESOURCE 2
#define SHGDFIL_DESCRIPTIONID 3
#define SHDID_ROOT_REGITEM 1
#define SHDID_FS_FILE 2
#define SHDID_FS_DIRECTORY 3
#define SHDID_FS_OTHER 4
#define SHDID_COMPUTER_DRIVE35 5
#define SHDID_COMPUTER_DRIVE525 6
#define SHDID_COMPUTER_REMOVABLE 7
#define SHDID_COMPUTER_FIXED 8
#define SHDID_COMPUTER_NETDRIVE 9
#define SHDID_COMPUTER_CDROM 10
#define SHDID_COMPUTER_RAMDISK 11
#define SHDID_COMPUTER_OTHER 12
#define SHDID_NET_DOMAIN 13
#define SHDID_NET_SERVER 14
#define SHDID_NET_SHARE 15
#define SHDID_NET_RESTOFNET 16
#define SHDID_NET_OTHER 17
#ifndef REGSTR_PATH_EXPLORER
#define REGSTR_PATH_EXPLORER $"Software\Microsoft\Windows\CurrentVersion\Explorer"
#endif

#define REGSTR_PATH_SPECIAL_FOLDERS	REGSTR_PATH_EXPLORER $"\Shell Folders"

#define CSIDL_DESKTOP 0
#define CSIDL_INTERNET 1
#define CSIDL_PROGRAMS 2
#define CSIDL_CONTROLS 3
#define CSIDL_PRINTERS 4
#define CSIDL_PERSONAL 5
#define CSIDL_FAVORITES 6
#define CSIDL_STARTUP 7
#define CSIDL_RECENT 8
#define CSIDL_SENDTO 9
#define CSIDL_BITBUCKET 10
#define CSIDL_STARTMENU 11
#define CSIDL_DESKTOPDIRECTORY 16
#define CSIDL_DRIVES 17
#define CSIDL_NETWORK 18
#define CSIDL_NETHOOD 19
#define CSIDL_FONTS 20
#define CSIDL_TEMPLATES 21
#define CSIDL_COMMON_STARTMENU 22
#define CSIDL_COMMON_PROGRAMS 23
#define CSIDL_COMMON_STARTUP 24
#define CSIDL_COMMON_DESKTOPDIRECTORY 25
#define CSIDL_APPDATA 26
#define CSIDL_PRINTHOOD 27
#define CSIDL_LOCAL_APPDATA 28
#define CSIDL_ALTSTARTUP 29
#define CSIDL_COMMON_ALTSTARTUP 30
#define CSIDL_COMMON_FAVORITES 31
#define CSIDL_INTERNET_CACHE 32
#define CSIDL_COOKIES 33
#define CSIDL_HISTORY 34
#define CSIDL_COMMON_APPDATA 35
#define CSIDL_WINDOWS 36
#define CSIDL_SYSTEM 37
#define CSIDL_PROGRAM_FILES 38
#define CSIDL_MYPICTURES 39
#define CSIDL_PROFILE 40
#define CSIDL_SYSTEMX86 41
#define CSIDL_PROGRAM_FILESX86 42
#define CSIDL_PROGRAM_FILES_COMMON 43
#define CSIDL_PROGRAM_FILES_COMMONX86 44
#define CSIDL_COMMON_TEMPLATES 45
#define CSIDL_COMMON_DOCUMENTS 46
#define CSIDL_COMMON_ADMINTOOLS 47
#define CSIDL_ADMINTOOLS 48
#define CSIDL_CONNECTIONS 49
#define CSIDL_COMMON_MUSIC 53
#define CSIDL_COMMON_PICTURES 54
#define CSIDL_COMMON_VIDEO 55
#define CSIDL_RESOURCES 56
#define CSIDL_RESOURCES_LOCALIZED 57
#define CSIDL_COMMON_OEM_LINKS 58
#define CSIDL_CDBURN_AREA 59
#define CSIDL_COMPUTERSNEARME 61
#define CSIDL_FLAG_CREATE &h8000
#define CFSTR_SHELLIDLIST "Shell IDList Array"
#define CFSTR_SHELLIDLISTOFFSET	"Shell Object Offsets"
#define CFSTR_NETRESOURCES "Net Resource"
#define CFSTR_FILEDESCRIPTOR "FileGroupDescriptor"
#define CFSTR_FILECONTENTS "FileContents"
#define CFSTR_FILENAME "FileName"
#define CFSTR_PRINTERGROUP "PrinterFriendlyName"
#define CFSTR_FILENAMEMAP "FileNameMap"
#define CFSTR_INDRAGLOOP "InShellDragLoop"
#define CFSTR_PASTESUCCEEDED "Paste Succeeded"
#define CFSTR_PERFORMEDDROPEFFECT "Performed DropEffect"
#define CFSTR_PREFERREDDROPEFFECT "Preferred DropEffect"
#define CFSTR_SHELLURL "UniformResourceLocator"
#define CMF_NORMAL 0
#define CMF_DEFAULTONLY 1
#define CMF_VERBSONLY 2
#define CMF_EXPLORE 4
#define CMF_NOVERBS 8
#define CMF_CANRENAME 16
#define CMF_NODEFAULT 32
#define CMF_INCLUDESTATIC 64
#define CMF_RESERVED &hffff0000
#define GCS_VERBA 0
#define GCS_HELPTEXTA 1
#define GCS_VALIDATEA 2
#define GCS_VERBW 4
#define GCS_HELPTEXTW 5
#define GCS_VALIDATEW 6
#define GCS_UNICODE 4
#ifdef UNICODE
#define GCS_VERB        GCS_VERBW
#define GCS_HELPTEXT    GCS_HELPTEXTW
#define GCS_VALIDATE    GCS_VALIDATEW
#else
#define GCS_VERB        GCS_VERBA
#define GCS_HELPTEXT    GCS_HELPTEXTA
#define GCS_VALIDATE    GCS_VALIDATEA
#endif
#define CMDSTR_NEWFOLDER "NewFolder"
#define CMDSTR_VIEWLIST	"ViewList"
#define CMDSTR_VIEWDETAILS "ViewDetails"
#define CMIC_MASK_HOTKEY	SEE_MASK_HOTKEY
#define CMIC_MASK_ICON	SEE_MASK_ICON
#define CMIC_MASK_FLAG_NO_UI	SEE_MASK_FLAG_NO_UI
#define CMIC_MASK_MODAL &h80000000
#define CMIC_VALID_SEE_FLAGS	SEE_VALID_CMIC_FLAGS
#define GIL_OPENICON 1
#define GIL_FORSHELL 2
#define GIL_SIMULATEDOC 1
#define GIL_PERINSTANCE 2
#define GIL_PERCLASS 4
#define GIL_NOTFILENAME 8
#define GIL_DONTCACHE 16
#define FVSIF_RECT 1
#define FVSIF_PINNED 2
#define FVSIF_NEWFAILED &h8000000
#define FVSIF_NEWFILE &h80000000
#define FVSIF_CANVIEWIT &h40000000
#define CDBOSC_SETFOCUS 0
#define CDBOSC_KILLFOCUS 1
#define CDBOSC_SELCHANGE 2
#define CDBOSC_RENAME 3
#define FCIDM_SHVIEWFIRST 0
#define FCIDM_SHVIEWLAST &h7fff
#define FCIDM_BROWSERFIRST &ha000
#define FCIDM_BROWSERLAST &hbf00
#define FCIDM_GLOBALFIRST &h8000
#define FCIDM_GLOBALLAST &h9fff
#define FCIDM_MENU_FILE &h8000
#define FCIDM_MENU_EDIT (&h8000+&h0040)
#define FCIDM_MENU_VIEW (&h8000+&h0080)
#define FCIDM_MENU_VIEW_SEP_OPTIONS (&h8000+&h0081)
#define FCIDM_MENU_TOOLS (&h8000+&h00c0)
#define FCIDM_MENU_TOOLS_SEP_GOTO (&h8000+&h00c1)
#define FCIDM_MENU_HELP (&h8000+&h0100)
#define FCIDM_MENU_FIND (&h8000+&h0140)
#define FCIDM_MENU_EXPLORE (&h8000+&h0150)
#define FCIDM_MENU_FAVORITES (&h8000+&h0170)
#define FCIDM_TOOLBAR &ha000
#define FCIDM_STATUS (&ha000+1)
#define SBSP_DEFBROWSER 0
#define SBSP_SAMEBROWSER 1
#define SBSP_NEWBROWSER 2
#define SBSP_DEFMODE 0
#define SBSP_OPENMODE 16
#define SBSP_EXPLOREMODE 32
#define SBSP_ABSOLUTE 0
#define SBSP_RELATIVE &h1000
#define SBSP_PARENT &h2000
#define SBSP_INITIATEDBYHLINKFRAME &h80000000
#define SBSP_REDIRECT &h40000000
#define FCW_STATUS 1
#define FCW_TOOLBAR 2
#define FCW_TREE 3
#define FCT_MERGE 1
#define FCT_CONFIGABLE 2
#define FCT_ADDTOEND 4
#define SVSI_DESELECT 0
#define SVSI_SELECT 1
#define SVSI_EDIT 3
#define SVSI_DESELECTOTHERS 4
#define SVSI_ENSUREVISIBLE 8
#define SVSI_FOCUSED 16
#define SVGIO_BACKGROUND 0
#define SVGIO_SELECTION 1
#define SVGIO_ALLVIEW 2
#define SV2GV_CURRENTVIEW cUINT(-1)
#define SV2GV_DEFAULTVIEW cUINT(-2)

type SFGAOF as ULONG
type SHGDNF as DWORD

type CIDA field=1
	cidl as UINT
	aoffset(0 to 1-1) as UINT
end type

type LPIDA as CIDA ptr

type SHITEMID field=1
	cb as USHORT
	abID(0 to 1-1) as UBYTE
end type

type LPSHITEMID as SHITEMID ptr
type LPCSHITEMID as SHITEMID ptr

type ITEMIDLIST field=1
	mkid as SHITEMID
end type

type LPITEMIDLIST as ITEMIDLIST ptr
type LPCITEMIDLIST as ITEMIDLIST ptr
type BFFCALLBACK as function (byval as HWND, byval as UINT, byval as LPARAM, byval as LPARAM) as integer

#ifndef UNICODE
type BROWSEINFOA field=1
	hwndOwner as HWND
	pidlRoot as LPCITEMIDLIST
	pszDisplayName as LPSTR
	lpszTitle as LPCSTR
	ulFlags as UINT
	lpfn as BFFCALLBACK
	lParam as LPARAM
	iImage as integer
end type

type PBROWSEINFOA as BROWSEINFOA ptr
type LPBROWSEINFOA as BROWSEINFOA ptr

#else ''UNICODE
type BROWSEINFOW field=1
	hwndOwner as HWND
	pidlRoot as LPCITEMIDLIST
	pszDisplayName as LPWSTR
	lpszTitle as LPCWSTR
	ulFlags as UINT
	lpfn as BFFCALLBACK
	lParam as LPARAM
	iImage as integer
end type

type PBROWSEINFOW as BROWSEINFOW ptr
type LPBROWSEINFOW as BROWSEINFOW ptr
#endif ''UNICODE

type CMINVOKECOMMANDINFO field=1
	cbSize as DWORD
	fMask as DWORD
	hwnd as HWND
	lpVerb as LPCSTR
	lpParameters as LPCSTR
	lpDirectory as LPCSTR
	nShow as integer
	dwHotKey as DWORD
	hIcon as HANDLE
end type

type LPCMINVOKECOMMANDINFO as CMINVOKECOMMANDINFO ptr

type DROPFILES field=1
	pFiles as DWORD
	pt as POINT
	fNC as BOOL
	fWide as BOOL
end type

type LPDROPFILES as DROPFILES ptr

enum SHGDN
	SHGDN_NORMAL = 0
	SHGDN_INFOLDER
	SHGDN_FOREDITING = &h1000
	SHGDN_INCLUDE_NONFILESYS = &h2000
	SHGDN_FORADDRESSBAR = &h4000
	SHGDN_FORPARSING = &h8000
end enum

type SHGNO as SHGDN

enum SHCONTF
	SHCONTF_FOLDERS = 32
	SHCONTF_NONFOLDERS = 64
	SHCONTF_INCLUDEHIDDEN = 128
	SHCONTF_INIT_ON_FIRST_NEXT = 256
	SHCONTF_NETPRINTERSRCH = 512
	SHCONTF_SHAREABLE = 1024
	SHCONTF_STORAGE = 2048
end enum

type STRRET field=1
	uType as UINT
	union
		pOleStr as LPWSTR
		uOffset as UINT
		cStr as zstring * 260
	end union
end type

type LPSTRRET as STRRET ptr

enum FD_FLAGS
	FD_CLSID = 1
	FD_SIZEPOINT = 2
	FD_ATTRIBUTES = 4
	FD_CREATETIME = 8
	FD_ACCESSTIME = 16
	FD_WRITESTIME = 32
	FD_FILESIZE = 64
	FD_LINKUI = &h8000
end enum

type FILEDESCRIPTOR field=1
	dwFlags as DWORD
	clsid as CLSID
	sizel as SIZEL
	pointl as POINTL
	dwFileAttributes as DWORD
	ftCreationTime as FILETIME
	ftLastAccessTime as FILETIME
	ftLastWriteTime as FILETIME
	nFileSizeHigh as DWORD
	nFileSizeLow as DWORD
	cFileName as zstring * 260
end type

type LPFILEDESCRIPTOR as FILEDESCRIPTOR ptr

type FILEGROUPDESCRIPTOR field=1
	cItems as UINT
	fgd(0 to 1-1) as FILEDESCRIPTOR
end type

type LPFILEGROUPDESCRIPTOR as FILEGROUPDESCRIPTOR ptr

enum SLR_FLAGS
	SLR_NO_UI = 1
	SLR_ANY_MATCH = 2
	SLR_UPDATE = 4
	SLR_NOUPDATE = 8
	SLR_NOSEARCH = 16
	SLR_NOTRACK = 32
	SLR_NOLINKINFO = 64
	SLR_INVOKE_MSI = 128
end enum

enum SLGP_FLAGS
	SLGP_SHORTPATH = 1
	SLGP_UNCPRIORITY = 2
	SLGP_RAWPATH = 4
end enum

type LPVIEWSETTINGS as PBYTE

enum FOLDERFLAGS
	FWF_AUTOARRANGE = 1
	FWF_ABBREVIATEDNAMES = 2
	FWF_SNAPTOGRID = 4
	FWF_OWNERDATA = 8
	FWF_BESTFITWINDOW = 16
	FWF_DESKTOP = 32
	FWF_SINGLESEL = 64
	FWF_NOSUBFOLDERS = 128
	FWF_TRANSPARENT = 256
	FWF_NOCLIENTEDGE = 512
	FWF_NOSCROLL = &h400
	FWF_ALIGNLEFT = &h800
	FWF_SINGLECLICKACTIVATE = &h8000
end enum

enum FOLDERVIEWMODE
	FVM_ICON = 1
	FVM_SMALLICON
	FVM_LIST
	FVM_DETAILS
end enum

type FOLDERSETTINGS field=1
	ViewMode as UINT
	fFlags as UINT
end type

type LPFOLDERSETTINGS as FOLDERSETTINGS ptr
type LPCFOLDERSETTINGS as FOLDERSETTINGS ptr

type FVSHOWINFO field=1
	cbSize as DWORD
	hwndOwner as HWND
	iShow as integer
	dwFlags as DWORD
	rect as RECT
	punkRel as LPUNKNOWN
	strNewFile(0 to 260-1) as OLECHAR
end type

type LPFVSHOWINFO as FVSHOWINFO ptr

type NRESARRAY field=1
	cItems as UINT
	nr(0 to 1-1) as NETRESOURCE
end type

type LPNRESARRAY as NRESARRAY ptr

enum 
	SBSC_HIDE
	SBSC_SHOW
	SBSC_TOGGLE
	SBSC_QUERY
end enum

enum 
	SBCMDID_ENABLESHOWTREE
	SBCMDID_SHOWCONTROL
	SBCMDID_CANCELNAVIGATION
	SBCMDID_MAYSAVECHANGES
	SBCMDID_SETHLINKFRAME
	SBCMDID_ENABLESTOP
	SBCMDID_OPTIONS
end enum

enum SVUIA_STATUS
	SVUIA_DEACTIVATE
	SVUIA_ACTIVATE_NOFOCUS
	SVUIA_ACTIVATE_FOCUS
	SVUIA_INPLACEACTIVATE
end enum

type EXTRASEARCH
	guidSearch as GUID
	wszFriendlyName as wstring * 80
	wszUrl as wstring * 2084
end type

type LPEXTRASEARCH as EXTRASEARCH ptr
type SHCOLSTATEF as DWORD

type SHCOLUMNID
	fmtid as GUID
	pid as DWORD
end type

type LPSHCOLUMNID as SHCOLUMNID ptr
type LPCSHCOLUMNID as SHCOLUMNID ptr

type SHELLDETAILS
	fmt as integer
	cxChar as integer
	str as STRRET
end type

type LPSHELLDETAILS as SHELLDETAILS ptr

type PERSIST_FOLDER_TARGET_INFO
	pidlTargetFolder as LPITEMIDLIST
	szTargetParsingName as wstring * 260
	szNetworkProvider as wstring * 260
	dwAttributes as DWORD
	csidl as integer
end type

enum SHGFP_TYPE
	SHGFP_TYPE_CURRENT = 0
	SHGFP_TYPE_DEFAULT = 1
end enum

type IEnumIDListVtbl_ as IEnumIDListVtbl

type IEnumIDList
	lpVtbl as IEnumIDListVtbl_ ptr
end type

type IEnumIDListVtbl
	QueryInterface as function (byval as IEnumIDList ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IEnumIDList ptr) as ULONG
	Release as function (byval as IEnumIDList ptr) as ULONG
	Next as function (byval as IEnumIDList ptr, byval as ULONG, byval as LPITEMIDLIST ptr, byval as ULONG ptr) as HRESULT
	Skip as function (byval as IEnumIDList ptr, byval as ULONG) as HRESULT
	Reset as function (byval as IEnumIDList ptr) as HRESULT
	Clone as function (byval as IEnumIDList ptr, byval as IEnumIDList ptr ptr) as HRESULT
end type

type LPENUMIDLIST as IEnumIDList ptr

#define IEnumIDList_QueryInterface(T,a,b) (T)->lpVtbl->QueryInterface(T,a,b)
#define IEnumIDList_Release(T) (T)->lpVtbl->AddRef(T)
#define IEnumIDList_AddRef(T) (T)->lpVtbl->Release(T)
#define IEnumIDList_Next(T,a,b,c) (T)->lpVtbl->Next(T,a,b,c)
#define IEnumIDList_Skip(T,a) (T)->lpVtbl->Skip(T,a)
#define IEnumIDList_Reset(T) (T)->lpVtbl->Reset(T)
#define IEnumIDList_Clone(T,a) (T)->lpVtbl->Clone(T,a)

type IObjMgrVtbl_ as IObjMgrVtbl

type IObjMgr
	lpVtbl as IObjMgrVtbl_ ptr
end type

type IObjMgrVtbl
	QueryInterface as function(byval as IObjMgr ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IObjMgr ptr) as ULONG
	Release as function(byval as IObjMgr ptr) as ULONG
	Append as function(byval as IObjMgr ptr, byval as IUnknown ptr) as HRESULT
	Remove as function(byval as IObjMgr ptr, byval as IUnknown ptr) as HRESULT
end type

type IContextMenuVtbl_ as IContextMenuVtbl

type IContextMenu
	lpVtbl as IContextMenuVtbl_ ptr
end type

type IContextMenuVtbl
	QueryInterface as function (byval as IContextMenu ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IContextMenu ptr) as ULONG
	Release as function (byval as IContextMenu ptr) as ULONG
	QueryContextMenu as function (byval as IContextMenu ptr, byval as HMENU, byval as UINT, byval as UINT, byval as UINT, byval as UINT) as HRESULT
	InvokeCommand as function (byval as IContextMenu ptr, byval as LPCMINVOKECOMMANDINFO) as HRESULT
	GetCommandString as function (byval as IContextMenu ptr, byval as UINT, byval as UINT, byval as PUINT, byval as LPSTR, byval as UINT) as HRESULT
end type

type LPCONTEXTMENU as IContextMenu ptr

#define IContextMenu_QueryInterface(T,a,b) (T)->lpVtbl->QueryInterface(T,a,b)
#define IContextMenu_AddRef(T) (T)->lpVtbl->AddRef(T)
#define IContextMenu_Release(T) (T)->lpVtbl->Release(T)
#define IContextMenu_QueryContextMenu(T,a,b,c,d,e) (T)->lpVtbl->QueryContextMenu(T,a,b,c,d,e)
#define IContextMenu_InvokeCommand(T,a) (T)->lpVtbl->InvokeCommand(T,a)
#define IContextMenu_GetCommandString(T,a,b,c,d,e) (T)->lpVtbl->GetCommandString(T,a,b,c,d,e)

type IContextMenu2Vtbl_ as IContextMenu2Vtbl

type IContextMenu2
	lpVtbl as IContextMenu2Vtbl_ ptr
end type

type IContextMenu2Vtbl
	QueryInterface as function (byval as IContextMenu2 ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IContextMenu2 ptr) as ULONG
	Release as function (byval as IContextMenu2 ptr) as ULONG
	QueryContextMenu as function (byval as IContextMenu2 ptr, byval as HMENU, byval as UINT, byval as UINT, byval as UINT, byval as UINT) as HRESULT
	InvokeCommand as function (byval as IContextMenu2 ptr, byval as LPCMINVOKECOMMANDINFO) as HRESULT
	GetCommandString as function (byval as IContextMenu2 ptr, byval as UINT, byval as UINT, byval as PUINT, byval as LPSTR, byval as UINT) as HRESULT
	HandleMenuMsg as function (byval as IContextMenu2 ptr, byval as UINT, byval as WPARAM, byval as LPARAM) as HRESULT
end type

type LPCONTEXTMENU2 as IContextMenu2 ptr

type IContextMenu3Vtbl_ as IContextMenu3Vtbl

type IContextMenu3
	lpVtbl as IContextMenu3Vtbl_ ptr
end type

type IContextMenu3Vtbl
	QueryInterface as function(byval as IContextMenu3 ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IContextMenu3 ptr) as ULONG
	Release as function(byval as IContextMenu3 ptr) as ULONG
	QueryContextMenu as function(byval as IContextMenu3 ptr, byval as HMENU, byval as UINT, byval as UINT, byval as UINT, byval as UINT) as HRESULT
	InvokeCommand as function(byval as IContextMenu3 ptr, byval as LPCMINVOKECOMMANDINFO) as HRESULT
	GetCommandString as function(byval as IContextMenu3 ptr, byval as UINT, byval as UINT, byval as PUINT, byval as LPSTR, byval as UINT) as HRESULT
	HandleMenuMsg as function(byval as IContextMenu3 ptr, byval as UINT, byval as WPARAM, byval as LPARAM) as HRESULT
	HandleMenuMsg2 as function(byval as IContextMenu3 ptr, byval as UINT, byval as WPARAM, byval as LPARAM, byval as LONG ptr) as HRESULT
end type

type LPCONTEXTMENU3 as IContextMenu3 ptr

#define IContextMenu2_QueryInterface(T,a,b) (T)->lpVtbl->QueryInterface(T,a,b)
#define IContextMenu2_AddRef(T) (T)->lpVtbl->AddRef(T)
#define IContextMenu2_Release(T) (T)->lpVtbl->Release(T)
#define IContextMenu2_QueryContextMenu(T,a,b,c,d,e) (T)->lpVtbl->QueryContextMenu(T,a,b,c,d,e)
#define IContextMenu2_InvokeCommand(T,a) (T)->lpVtbl->InvokeCommand(T,a)
#define IContextMenu2_GetCommandString(T,a,b,c,d,e) (T)->lpVtbl->GetCommandString(T,a,b,c,d,e)
#define IContextMenu2_HandleMenuMsg(T,a,b,c) (T)->lpVtbl->HandleMenuMsg(T,a,b,c)

#define IContextMenu3_QueryInterface(T,a,b) (T)->lpVtbl->QueryInterface(T,a,b)
#define IContextMenu3_AddRef(T) (T)->lpVtbl->AddRef(T)
#define IContextMenu3_Release(T) (T)->lpVtbl->Release(T)
#define IContextMenu3_QueryContextMenu(T,a,b,c,d,e) (T)->lpVtbl->QueryContextMenu(T,a,b,c,d,e)
#define IContextMenu3_InvokeCommand(T,a) (T)->lpVtbl->InvokeCommand(T,a)
#define IContextMenu3_GetCommandString(T,a,b,c,d,e) (T)->lpVtbl->GetCommandString(T,a,b,c,d,e)
#define IContextMenu3_HandleMenuMsg(T,a,b,c) (T)->lpVtbl->HandleMenuMsg(T,a,b,c)
#define IContextMenu3_HandleMenuMsg2(T,a,b,c,d) (T)->lpVtbl->HandleMenuMsg(T,a,b,c,d)

type SHCOLUMNINIT
	dwFlags as ULONG
	dwReserved as ULONG
	wszFolder as wstring * 260
end type

type SHCOLUMNDATA
	dwFlags as ULONG
	dwFileAttributes as DWORD
	dwReserved as ULONG
	pwszExt as WCHAR ptr
	wszFile as wstring * 260
end type

type LPSHCOLUMNDATA as SHCOLUMNDATA ptr
type LPCSHCOLUMNDATA as SHCOLUMNDATA ptr

#define MAX_COLUMN_NAME_LEN 80
#define MAX_COLUMN_DESC_LEN 128

type SHCOLUMNINFO
	scid as SHCOLUMNID
	vt as VARTYPE
	fmt as DWORD
	cChars as UINT
	csFlags as DWORD
	wszTitle as wstring * 80
	wszDescription as wstring * 128
end type

type LPSHCOLUMNINFO as SHCOLUMNINFO ptr
type LPCSHCOLUMNINFO as SHCOLUMNINFO ptr

enum SHCOLSTATE
	SHCOLSTATE_TYPE_STR = &h00000001
	SHCOLSTATE_TYPE_INT = &h00000002
	SHCOLSTATE_TYPE_DATE = &h00000003
	SHCOLSTATE_TYPEMASK = &h0000000f
	SHCOLSTATE_ONBYDEFAULT = &h00000010
	SHCOLSTATE_SLOW = &h00000020
	SHCOLSTATE_EXTENDED = &h00000040
	SHCOLSTATE_SECONDARYUI = &h00000080
	SHCOLSTATE_HIDDEN = &h00000100
	SHCOLSTATE_PREFER_VARCMP = &h00000200
end enum

type LPSHCOLUMNINIT as SHCOLUMNINIT ptr
type LPCSHCOLUMNINIT as SHCOLUMNINIT ptr

type IColumnProviderVtbl_ as IColumnProviderVtbl

type IColumnProvider
	lpVtbl as IColumnProviderVtbl_ ptr
end type

type IColumnProviderVtbl
	QueryInterface as function(byval as IColumnProvider ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IColumnProvider ptr) as ULONG
	Release as function(byval as IColumnProvider ptr) as ULONG
	Initialize as function(byval as IColumnProvider ptr, byval as LPCSHCOLUMNINIT) as HRESULT
	GetColumnInfo as function(byval as IColumnProvider ptr, byval as DWORD, byval as SHCOLUMNINFO ptr) as HRESULT
	GetItemData as function(byval as IColumnProvider ptr, byval as LPCSHCOLUMNID, byval as LPCSHCOLUMNDATA, byval as VARIANT_ ptr) as HRESULT
end type

type IQueryInfoVtbl_ as IQueryInfoVtbl

type IQueryInfo
	lpVtbl as IQueryInfoVtbl_ ptr
end type

type IQueryInfoVtbl
	QueryInterface as function(byval as IQueryInfo ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IQueryInfo ptr) as ULONG
	Release as function(byval as IQueryInfo ptr) as ULONG
	GetInfoTip as function(byval as IQueryInfo ptr, byval as DWORD, byval as WCHAR ptr ptr) as HRESULT
	GetInfoFlags as function(byval as IQueryInfo ptr, byval as DWORD ptr) as HRESULT
end type

type IShellExtInitVtbl_ as IShellExtInitVtbl

type IShellExtInit
	lpVtbl as IShellExtInitVtbl_ ptr
end type

type IShellExtInitVtbl
	QueryInterface as function (byval as IShellExtInit ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IShellExtInit ptr) as ULONG
	Release as function (byval as IShellExtInit ptr) as ULONG
	Initialize as function (byval as IShellExtInit ptr, byval as LPCITEMIDLIST, byval as LPDATAOBJECT, byval as HKEY) as HRESULT
end type

type LPSHELLEXTINIT as IShellExtInit ptr

type IShellPropSheetExtVtbl_ as IShellPropSheetExtVtbl

type IShellPropSheetExt
	lpVtbl as IShellPropSheetExtVtbl_ ptr
end type

type IShellPropSheetExtVtbl
	QueryInterface as function (byval as IShellPropSheetExt ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IShellPropSheetExt ptr) as ULONG
	Release as function (byval as IShellPropSheetExt ptr) as ULONG
	AddPages as function (byval as IShellPropSheetExt ptr, byval as LPFNADDPROPSHEETPAGE, byval as LPARAM) as HRESULT
	ReplacePage as function (byval as IShellPropSheetExt ptr, byval as UINT, byval as LPFNADDPROPSHEETPAGE, byval as LPARAM) as HRESULT
end type

type LPSHELLPROPSHEETEXT as IShellPropSheetExt ptr

#ifndef UNICODE
type IExtractIconAVtbl_ as IExtractIconAVtbl

type IExtractIconA
	lpVtbl as IExtractIconAVtbl_ ptr
end type

type IExtractIconAVtbl
	QueryInterface as function (byval as IExtractIconA ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IExtractIconA ptr) as ULONG
	Release as function (byval as IExtractIconA ptr) as ULONG
	GetIconLocation as function (byval as IExtractIconA ptr, byval as UINT, byval as LPSTR, byval as UINT, byval as integer ptr, byval as PUINT) as HRESULT
	Extract as function (byval as IExtractIconA ptr, byval as LPCSTR, byval as UINT, byval as HICON ptr, byval as HICON ptr, byval as UINT) as HRESULT
end type

type LPEXTRACTICONA as IExtractIconA ptr

#define IExtractIconA_QueryInterface(T,a,b) (T)->lpVtbl->QueryInterface(T,a,b)
#define IExtractIconA_AddRef(T) (T)->lpVtbl->AddRef(T)
#define IExtractIconA_Release(T) (T)->lpVtbl->Release(T)
#define IExtractIconA_GetIconLocation(T,a,b,c,d,e) (T)->lpVtbl->GetIconLocation(T,a,b,c,d,e)
#define IExtractIconA_Extract(T,a,b,c,d,e) (T)->lpVtbl->Extract(T,a,b,c,d,e)

type IShellLinkAVtbl_ as IShellLinkAVtbl

type IShellLinkA
	lpVtbl as IShellLinkAVtbl_ ptr
end type

type IShellLinkAVtbl
	QueryInterface as function (byval as IShellLinkA ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IShellLinkA ptr) as ULONG
	Release as function (byval as IShellLinkA ptr) as ULONG
	GetPath as function (byval as IShellLinkA ptr, byval as LPSTR, byval as integer, byval as WIN32_FIND_DATAA ptr, byval as DWORD) as HRESULT
	GetIDList as function (byval as IShellLinkA ptr, byval as LPITEMIDLIST ptr) as HRESULT
	SetIDList as function (byval as IShellLinkA ptr, byval as LPCITEMIDLIST) as HRESULT
	GetDescription as function (byval as IShellLinkA ptr, byval as LPSTR, byval as integer) as HRESULT
	SetDescription as function (byval as IShellLinkA ptr, byval as LPCSTR) as HRESULT
	GetWorkingDirectory as function (byval as IShellLinkA ptr, byval as LPSTR, byval as integer) as HRESULT
	SetWorkingDirectory as function (byval as IShellLinkA ptr, byval as LPCSTR) as HRESULT
	GetArguments as function (byval as IShellLinkA ptr, byval as LPSTR, byval as integer) as HRESULT
	SetArguments as function (byval as IShellLinkA ptr, byval as LPCSTR) as HRESULT
	GetHotkey as function (byval as IShellLinkA ptr, byval as PWORD) as HRESULT
	SetHotkey as function (byval as IShellLinkA ptr, byval as WORD) as HRESULT
	GetShowCmd as function (byval as IShellLinkA ptr, byval as integer ptr) as HRESULT
	SetShowCmd as function (byval as IShellLinkA ptr, byval as integer) as HRESULT
	GetIconLocation as function (byval as IShellLinkA ptr, byval as LPSTR, byval as integer, byval as integer ptr) as HRESULT
	SetIconLocation as function (byval as IShellLinkA ptr, byval as LPCSTR, byval as integer) as HRESULT
	SetRelativePath as function (byval as IShellLinkA ptr, byval as LPCSTR, byval as DWORD) as HRESULT
	Resolve as function (byval as IShellLinkA ptr, byval as HWND, byval as DWORD) as HRESULT
	SetPath as function (byval as IShellLinkA ptr, byval as LPCSTR) as HRESULT
end type

#define IShellLinkA_QueryInterface(T,a,b) (T)->lpVtbl->QueryInterface(T,a,b)
#define IShellLinkA_AddRef(T) (T)->lpVtbl->AddRef(T)
#define IShellLinkA_Release(T) (T)->lpVtbl->Release(T)
#define IShellLinkA_GetPath(T,a,b,c,d) (T)->lpVtbl->GetPath(T,a,b,c,d)
#define IShellLinkA_GetIDList(T,a) (T)->lpVtbl->GetIDList(T,a)
#define IShellLinkA_SetIDList(T,a) (T)->lpVtbl->SetIDList(T,a)
#define IShellLinkA_GetDescription(T,a,b) (T)->lpVtbl->GetDescription(T,a,b)
#define IShellLinkA_SetDescription(T,a) (T)->lpVtbl->SetDescription(T,a)
#define IShellLinkA_GetWorkingDirectory(T,a,b) (T)->lpVtbl->GetWorkingDirectory(T,a,b)
#define IShellLinkA_SetWorkingDirectory(T,a) (T)->lpVtbl->SetWorkingDirectory(T,a)
#define IShellLinkA_GetArguments(T,a,b) (T)->lpVtbl->GetArguments(T,a,b)
#define IShellLinkA_SetArguments(T,a) (T)->lpVtbl->SetArguments(T,a)
#define IShellLinkA_GetHotkey(T,a) (T)->lpVtbl->GetHotkey(T,a)
#define IShellLinkA_SetHotkey(T,a) (T)->lpVtbl->SetHotkey(T,a)
#define IShellLinkA_GetShowCmd(T,a) (T)->lpVtbl->GetShowCmd(T,a)
#define IShellLinkA_SetShowCmd(T,a) (T)->lpVtbl->SetShowCmd(T,a)
#define IShellLinkA_GetIconLocation(T,a,b,c) (T)->lpVtbl->GetIconLocation(T,a,b,c)
#define IShellLinkA_SetIconLocation(T,a,b) (T)->lpVtbl->SetIconLocation(T,a,b)
#define IShellLinkA_SetRelativePath(T,a,b) (T)->lpVtbl->SetRelativePath(T,a,b)
#define IShellLinkA_Resolve(T,a,b) (T)->lpVtbl->Resolve(T,a,b)
#define IShellLinkA_SetPath(T,a) (T)->lpVtbl->SetPath(T,a)

#else ''UNICODE
type IExtractIconWVtbl_ as IExtractIconWVtbl

type IExtractIconW
	lpVtbl as IExtractIconWVtbl_ ptr
end type

type IExtractIconWVtbl
	QueryInterface as function (byval as IExtractIconW ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IExtractIconW ptr) as ULONG
	Release as function (byval as IExtractIconW ptr) as ULONG
	GetIconLocation as function (byval as IExtractIconW ptr, byval as UINT, byval as LPWSTR, byval as UINT, byval as integer ptr, byval as PUINT) as HRESULT
	Extract as function (byval as IExtractIconW ptr, byval as LPCWSTR, byval as UINT, byval as HICON ptr, byval as HICON ptr, byval as UINT) as HRESULT
end type

type LPEXTRACTICONW as IExtractIconW ptr

#define IExtractIconW_QueryInterface(T,a,b) (T)->lpVtbl->QueryInterface(T,a,b)
#define IExtractIconW_AddRef(T) (T)->lpVtbl->AddRef(T)
#define IExtractIconW_Release(T) (T)->lpVtbl->Release(T)
#define IExtractIconW_GetIconLocation(T,a,b,c,d,e) (T)->lpVtbl->GetIconLocation(T,a,b,c,d,e)
#define IExtractIconW_Extract(T,a,b,c,d,e) (T)->lpVtbl->Extract(T,a,b,c,d,e)

type IShellLinkWVtbl_ as IShellLinkWVtbl

type IShellLinkW
	lpVtbl as IShellLinkWVtbl_ ptr
end type

type IShellLinkWVtbl
	QueryInterface as function (byval as IShellLinkW ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IShellLinkW ptr) as ULONG
	Release as function (byval as IShellLinkW ptr) as ULONG
	GetPath as function (byval as IShellLinkW ptr, byval as LPWSTR, byval as integer, byval as WIN32_FIND_DATAW ptr, byval as DWORD) as HRESULT
	GetIDList as function (byval as IShellLinkW ptr, byval as LPITEMIDLIST ptr) as HRESULT
	SetIDList as function (byval as IShellLinkW ptr, byval as LPCITEMIDLIST) as HRESULT
	GetDescription as function (byval as IShellLinkW ptr, byval as LPWSTR, byval as integer) as HRESULT
	SetDescription as function (byval as IShellLinkW ptr, byval as LPCWSTR) as HRESULT
	GetWorkingDirectory as function (byval as IShellLinkW ptr, byval as LPWSTR, byval as integer) as HRESULT
	SetWorkingDirectory as function (byval as IShellLinkW ptr, byval as LPCWSTR) as HRESULT
	GetArguments as function (byval as IShellLinkW ptr, byval as LPWSTR, byval as integer) as HRESULT
	SetArguments as function (byval as IShellLinkW ptr, byval as LPCWSTR) as HRESULT
	GetHotkey as function (byval as IShellLinkW ptr, byval as PWORD) as HRESULT
	SetHotkey as function (byval as IShellLinkW ptr, byval as WORD) as HRESULT
	GetShowCmd as function (byval as IShellLinkW ptr, byval as integer ptr) as HRESULT
	SetShowCmd as function (byval as IShellLinkW ptr, byval as integer) as HRESULT
	GetIconLocation as function (byval as IShellLinkW ptr, byval as LPWSTR, byval as integer, byval as integer ptr) as HRESULT
	SetIconLocation as function (byval as IShellLinkW ptr, byval as LPCWSTR, byval as integer) as HRESULT
	SetRelativePath as function (byval as IShellLinkW ptr, byval as LPCWSTR, byval as DWORD) as HRESULT
	Resolve as function (byval as IShellLinkW ptr, byval as HWND, byval as DWORD) as HRESULT
	SetPath as function (byval as IShellLinkW ptr, byval as LPCWSTR) as HRESULT
end type

#define IShellLinkW_QueryInterface(T,a,b) (T)->lpVtbl->QueryInterface(T,a,b)
#define IShellLinkW_AddRef(T) (T)->lpVtbl->AddRef(T)
#define IShellLinkW_Release(T) (T)->lpVtbl->Release(T)
#define IShellLinkW_GetPath(T,a,b,c,d) (T)->lpVtbl->GetPath(T,a,b,c,d)
#define IShellLinkW_GetIDList(T,a) (T)->lpVtbl->GetIDList(T,a)
#define IShellLinkW_SetIDList(T,a) (T)->lpVtbl->SetIDList(T,a)
#define IShellLinkW_GetDescription(T,a,b) (T)->lpVtbl->GetDescription(T,a,b)
#define IShellLinkW_SetDescription(T,a) (T)->lpVtbl->SetDescription(T,a)
#define IShellLinkW_GetWorkingDirectory(T,a,b) (T)->lpVtbl->GetWorkingDirectory(T,a,b)
#define IShellLinkW_SetWorkingDirectory(T,a) (T)->lpVtbl->SetWorkingDirectory(T,a)
#define IShellLinkW_GetArguments(T,a,b) (T)->lpVtbl->GetArguments(T,a,b)
#define IShellLinkW_SetArguments(T,a) (T)->lpVtbl->SetArguments(T,a)
#define IShellLinkW_GetHotkey(T,a) (T)->lpVtbl->GetHotkey(T,a)
#define IShellLinkW_SetHotkey(T,a) (T)->lpVtbl->SetHotkey(T,a)
#define IShellLinkW_GetShowCmd(T,a) (T)->lpVtbl->GetShowCmd(T,a)
#define IShellLinkW_SetShowCmd(T,a) (T)->lpVtbl->SetShowCmd(T,a)
#define IShellLinkW_GetIconLocation(T,a,b,c) (T)->lpVtbl->GetIconLocation(T,a,b,c)
#define IShellLinkW_SetIconLocation(T,a,b) (T)->lpVtbl->SetIconLocation(T,a,b)
#define IShellLinkW_SetRelativePath(T,a,b) (T)->lpVtbl->SetRelativePath(T,a,b)
#define IShellLinkW_Resolve(T,a,b) (T)->lpVtbl->Resolve(T,a,b)
#define IShellLinkW_SetPath(T,a) (T)->lpVtbl->SetPath(T,a)

#endif ''UNICODE

type IShellFolderVtbl_ as IShellFolderVtbl

type IShellFolder
	lpVtbl as IShellFolderVtbl_ ptr
end type

type IShellFolderVtbl
	QueryInterface as function (byval as IShellFolder ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IShellFolder ptr) as ULONG
	Release as function (byval as IShellFolder ptr) as ULONG
	ParseDisplayName as function (byval as IShellFolder ptr, byval as HWND, byval as LPBC, byval as LPOLESTR, byval as PULONG, byval as LPITEMIDLIST ptr, byval as PULONG) as HRESULT
	EnumObjects as function (byval as IShellFolder ptr, byval as HWND, byval as DWORD, byval as LPENUMIDLIST ptr) as HRESULT
	BindToObject as function (byval as IShellFolder ptr, byval as LPCITEMIDLIST, byval as LPBC, byval as IID ptr, byval as PVOID ptr) as HRESULT
	BindToStorage as function (byval as IShellFolder ptr, byval as LPCITEMIDLIST, byval as LPBC, byval as IID ptr, byval as PVOID ptr) as HRESULT
	CompareIDs as function (byval as IShellFolder ptr, byval as LPARAM, byval as LPCITEMIDLIST, byval as LPCITEMIDLIST) as HRESULT
	CreateViewObject as function (byval as IShellFolder ptr, byval as HWND, byval as IID ptr, byval as PVOID ptr) as HRESULT
	GetAttributesOf as function (byval as IShellFolder ptr, byval as UINT, byval as LPCITEMIDLIST ptr, byval as PULONG) as HRESULT
	GetUIObjectOf as function (byval as IShellFolder ptr, byval as HWND, byval as UINT, byval as LPCITEMIDLIST ptr, byval as IID ptr, byval as PUINT, byval as PVOID ptr) as HRESULT
	GetDisplayNameOf as function (byval as IShellFolder ptr, byval as LPCITEMIDLIST, byval as DWORD, byval as LPSTRRET) as HRESULT
	SetNameOf as function (byval as IShellFolder ptr, byval as HWND, byval as LPCITEMIDLIST, byval as LPCOLESTR, byval as DWORD, byval as LPITEMIDLIST ptr) as HRESULT
end type

type LPSHELLFOLDER as IShellFolder ptr

#define IShellFolder_QueryInterface(T,a,b) (T)->lpVtbl->QueryInterface(T,a,b)
#define IShellFolder_AddRef(T) (T)->lpVtbl->AddRef(T)
#define IShellFolder_Release(T) (T)->lpVtbl->Release(T)
#define IShellFolder_ParseDisplayName(T,a,b,c,d,e,f) (T)->lpVtbl->ParseDisplayName(T,a,b,c,d,e,f)
#define IShellFolder_EnumObjects(T,a,b,c) (T)->lpVtbl->EnumObjects(T,a,b,c)
#define IShellFolder_BindToObject(T,a,b,c,d) (T)->lpVtbl->BindToObject(T,a,b,c,d)
#define IShellFolder_BindToStorage(T,a,b,c,d) (T)->lpVtbl->BindToStorage(T,a,b,c,d)
#define IShellFolder_CompareIDs(T,a,b,c) (T)->lpVtbl->CompareIDs(T,a,b,c)
#define IShellFolder_CreateViewObject(T,a,b) (T)->lpVtbl->CreateViewObject(T,a,b)
#define IShellFolder_GetAttributesOf(T,a,b,c) (T)->lpVtbl->GetAttributesOf(T,a,b,c)
#define IShellFolder_GetUIObjectOf(T,a,b,c,d,e,f) (T)->lpVtbl->GetUIObjectOf(T,a,b,c,d,e,f)
#define IShellFolder_GetDisplayNameOf(T,a,b,c) (T)->lpVtbl->GetDisplayNameOf(T,a,b,c)
#define IShellFolder_SetNameOf(T,a,b,c,d,e) (T)->lpVtbl->SetNameOf(T,a,b,c,d,e)

type IEnumExtraSearchVtbl_ as IEnumExtraSearchVtbl

type IEnumExtraSearch
	lpVtbl as IEnumExtraSearchVtbl_ ptr
end type

type IEnumExtraSearchVtbl
	QueryInterface as function(byval as IEnumExtraSearch ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IEnumExtraSearch ptr) as ULONG
	Release as function(byval as IEnumExtraSearch ptr) as ULONG
	Next as function(byval as IEnumExtraSearch ptr, byval as ULONG, byval as LPEXTRASEARCH ptr, byval as ULONG ptr) as HRESULT
	Skip as function(byval as IEnumExtraSearch ptr, byval as ULONG) as HRESULT
	Reset as function(byval as IEnumExtraSearch ptr) as HRESULT
	Clone as function(byval as IEnumExtraSearch ptr, byval as IEnumExtraSearch ptr ptr) as HRESULT
end type

type LPENUMEXTRASEARCH as IEnumExtraSearch ptr

type IShellFolder2Vtbl_ as IShellFolder2Vtbl

type IShellFolder2
	lpVtbl as IShellFolder2Vtbl_ ptr
end type

type IShellFolder2Vtbl
	QueryInterface as function(byval as IShellFolder2 ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IShellFolder2 ptr) as ULONG
	Release as function(byval as IShellFolder2 ptr) as ULONG
	ParseDisplayName as function(byval as IShellFolder2 ptr, byval as HWND, byval as LPBC, byval as LPOLESTR, byval as PULONG, byval as LPITEMIDLIST ptr, byval as PULONG) as HRESULT
	EnumObjects as function(byval as IShellFolder2 ptr, byval as HWND, byval as DWORD, byval as LPENUMIDLIST ptr) as HRESULT
	BindToObject as function(byval as IShellFolder2 ptr, byval as LPCITEMIDLIST, byval as LPBC, byval as IID ptr, byval as PVOID ptr) as HRESULT
	BindToStorage as function(byval as IShellFolder2 ptr, byval as LPCITEMIDLIST, byval as LPBC, byval as IID ptr, byval as PVOID ptr) as HRESULT
	CompareIDs as function(byval as IShellFolder2 ptr, byval as LPARAM, byval as LPCITEMIDLIST, byval as LPCITEMIDLIST) as HRESULT
	CreateViewObject as function(byval as IShellFolder2 ptr, byval as HWND, byval as IID ptr, byval as PVOID ptr) as HRESULT
	GetAttributesOf as function(byval as IShellFolder2 ptr, byval as UINT, byval as LPCITEMIDLIST ptr, byval as PULONG) as HRESULT
	GetUIObjectOf as function(byval as IShellFolder2 ptr, byval as HWND, byval as UINT, byval as LPCITEMIDLIST ptr, byval as IID ptr, byval as PUINT, byval as PVOID ptr) as HRESULT
	GetDisplayNameOf as function(byval as IShellFolder2 ptr, byval as LPCITEMIDLIST, byval as DWORD, byval as LPSTRRET) as HRESULT
	SetNameOf as function(byval as IShellFolder2 ptr, byval as HWND, byval as LPCITEMIDLIST, byval as LPCOLESTR, byval as DWORD, byval as LPITEMIDLIST ptr) as HRESULT
	GetDefaultSearchGUID as function(byval as IShellFolder2 ptr, byval as GUID ptr) as HRESULT
	EnumSearches as function(byval as IShellFolder2 ptr, byval as IEnumExtraSearch ptr ptr) as HRESULT
	GetDefaultColumn as function(byval as IShellFolder2 ptr, byval as DWORD, byval as ULONG ptr, byval as ULONG ptr) as HRESULT
	GetDefaultColumnState as function(byval as IShellFolder2 ptr, byval as UINT, byval as SHCOLSTATEF ptr) as HRESULT
	GetDetailsEx as function(byval as IShellFolder2 ptr, byval as LPCITEMIDLIST, byval as SHCOLUMNID ptr, byval as VARIANT_ ptr) as HRESULT
	GetDetailsOf as function(byval as IShellFolder2 ptr, byval as LPCITEMIDLIST, byval as UINT, byval as SHELLDETAILS ptr) as HRESULT
	MapColumnToSCID as function(byval as IShellFolder2 ptr, byval as UINT, byval as SHCOLUMNID ptr) as HRESULT
end type

type LPSHELLFOLDER2 as IShellFolder2 ptr

#define IShellFolder2_QueryInterface(T,a,b) (T)->lpVtbl->QueryInterface(T,a,b)
#define IShellFolder2_AddRef(T) (T)->lpVtbl->AddRef(T)
#define IShellFolder2_Release(T) (T)->lpVtbl->Release(T)
#define IShellFolder2_ParseDisplayName(T,a,b,c,d,e,f) (T)->lpVtbl->ParseDisplayName(T,a,b,c,d,e,f)
#define IShellFolder2_EnumObjects(T,a,b,c) (T)->lpVtbl->EnumObjects(T,a,b,c)
#define IShellFolder2_BindToObject(T,a,b,c,d) (T)->lpVtbl->BindToObject(T,a,b,c,d)
#define IShellFolder2_BindToStorage(T,a,b,c,d) (T)->lpVtbl->BindToStorage(T,a,b,c,d)
#define IShellFolder2_CompareIDs(T,a,b,c) (T)->lpVtbl->CompareIDs(T,a,b,c)
#define IShellFolder2_CreateViewObject(T,a,b) (T)->lpVtbl->CreateViewObject(T,a,b)
#define IShellFolder2_GetAttributesOf(T,a,b,c) (T)->lpVtbl->GetAttributesOf(T,a,b,c)
#define IShellFolder2_GetUIObjectOf(T,a,b,c,d,e,f) (T)->lpVtbl->GetUIObjectOf(T,a,b,c,d,e,f)
#define IShellFolder2_GetDisplayNameOf(T,a,b,c) (T)->lpVtbl->GetDisplayNameOf(T,a,b,c)
#define IShellFolder2_SetNameOf(T,a,b,c,d,e) (T)->lpVtbl->SetNameOf(T,a,b,c,d,e)
#define IShellFolder2_GetDefaultSearchGUID(T,a) (T)->lpVtbl->GetDefaultSearchGUID(T,a)
#define IShellFolder2_EnumSearches(T,a) (T)->lpVtbl->EnumSearches(T,a)
#define IShellFolder2_GetDefaultColumn(T,a,b,c) (T)->lpVtbl->GetDefaultColumn(T,a,b,c)
#define IShellFolder2_GetDefaultColumnState(T,a,b) (T)->lpVtbl->GetDefaultColumnState(T,a,b)
#define IShellFolder2_GetDetailsEx(T,a,b,c) (T)->lpVtbl->GetDetailsEx(T,a,b,c)
#define IShellFolder2_GetDetailsOf(T,a,b,c) (T)->lpVtbl->GetDetailsOf(T,a,b,c)
#define IShellFolder2_MapColumnToSCID(T,a,b) (T)->lpVtbl->MapColumnToSCID(T,a,b)

type ICopyHookVtbl_ as ICopyHookVtbl

type ICopyHook
	lpVtbl as ICopyHookVtbl_ ptr
end type

type ICopyHookVtbl
	QueryInterface as function (byval as ICopyHook ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as ICopyHook ptr) as ULONG
	Release as function (byval as ICopyHook ptr) as ULONG
	CopyCallback as function (byval as ICopyHook ptr, byval as HWND, byval as UINT, byval as UINT, byval as LPCSTR, byval as DWORD, byval as LPCSTR, byval as DWORD) as UINT
end type

type LPCOPYHOOK as ICopyHook ptr

type IFileViewerSiteVtbl_ as IFileViewerSiteVtbl

type IFileViewerSite
	lpVtbl as IFileViewerSiteVtbl_ ptr
end type

type IFileViewerSiteVtbl
	QueryInterface as function (byval as IFileViewerSite ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IFileViewerSite ptr) as ULONG
	Release as function (byval as IFileViewerSite ptr) as ULONG
	SetPinnedWindow as function (byval as IFileViewerSite ptr, byval as HWND) as HRESULT
	GetPinnedWindow as function (byval as IFileViewerSite ptr, byval as HWND ptr) as HRESULT
end type

type LPFILEVIEWERSITE as IFileViewerSite ptr

type IFileViewerVtbl_ as IFileViewerVtbl

type IFileViewer
	lpVtbl as IFileViewerVtbl_ ptr
end type

type IFileViewerVtbl
	QueryInterface as function (byval as IFileViewer ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IFileViewer ptr) as ULONG
	Release as function (byval as IFileViewer ptr) as ULONG
	ShowInitialize as function (byval as IFileViewer ptr, byval as LPFILEVIEWERSITE) as HRESULT
	Show as function (byval as IFileViewer ptr, byval as LPFVSHOWINFO) as HRESULT
	PrintTo as function (byval as IFileViewer ptr, byval as LPSTR, byval as BOOL) as HRESULT
end type

type LPFILEVIEWER as IFileViewer ptr

#ifdef UNICODE
type IFileSystemBindDataVtbl_ as IFileSystemBindDataVtbl

type IFileSystemBindData
	lpVtbl as IFileSystemBindDataVtbl_ ptr
end type

type IFileSystemBindDataVtbl
	QueryInterface as function(byval as IFileSystemBindData ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IFileSystemBindData ptr) as ULONG
	Release as function(byval as IFileSystemBindData ptr) as ULONG
	SetFindData as function(byval as IFileSystemBindData ptr, byval as WIN32_FIND_DATAW ptr) as HRESULT
	GetFindData as function(byval as IFileSystemBindData ptr, byval as WIN32_FIND_DATAW ptr) as HRESULT
end type
#endif

type IPersistFolderVtbl_ as IPersistFolderVtbl

type IPersistFolder
	lpVtbl as IPersistFolderVtbl_ ptr
end type

type IPersistFolderVtbl
	QueryInterface as function (byval as IPersistFolder ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IPersistFolder ptr) as ULONG
	Release as function (byval as IPersistFolder ptr) as ULONG
	GetClassID as function (byval as IPersistFolder ptr, byval as CLSID ptr) as HRESULT
	Initialize as function (byval as IPersistFolder ptr, byval as LPCITEMIDLIST) as HRESULT
end type

type LPPERSISTFOLDER as IPersistFolder ptr

#define IPersistFolder_QueryInterface(T,a,b) (T)->lpVtbl->QueryInterface(T,a,b)
#define IPersistFolder_AddRef(T) (T)->lpVtbl->AddRef(T)
#define IPersistFolder_Release(T) (T)->lpVtbl->Release(T)
#define IPersistFolder_GetClassID(T,a) (T)->lpVtbl->GetClassID(T,a)
#define IPersistFolder_Initialize(T,a) (T)->lpVtbl->Initialize(T,a)

type IPersistFolder2Vtbl_ as IPersistFolder2Vtbl

type IPersistFolder2
	lpVtbl as IPersistFolder2Vtbl_ ptr
end type

type IPersistFolder2Vtbl
	QueryInterface as function(byval as IPersistFolder2 ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IPersistFolder2 ptr) as ULONG
	Release as function(byval as IPersistFolder2 ptr) as ULONG
	GetClassID as function(byval as IPersistFolder2 ptr, byval as CLSID ptr) as HRESULT
	Initialize as function(byval as IPersistFolder2 ptr, byval as LPCITEMIDLIST) as HRESULT
	GetCurFolder as function(byval as IPersistFolder2 ptr, byval as LPITEMIDLIST ptr) as HRESULT
end type

type LPPERSISTFOLDER2 as IPersistFolder2 ptr

#define IPersistFolder2_QueryInterface(T,a,b) (T)->lpVtbl->QueryInterface(T,a,b)
#define IPersistFolder2_AddRef(T) (T)->lpVtbl->AddRef(T)
#define IPersistFolder2_Release(T) (T)->lpVtbl->Release(T)
#define IPersistFolder2_GetClassID(T,a) (T)->lpVtbl->GetClassID(T,a)
#define IPersistFolder2_Initialize(T,a) (T)->lpVtbl->Initialize(T,a)
#define IPersistFolder2_GetCurFolder(T,a) (T)->lpVtbl->GetCurFolder(T,a)

type IPersistFolder3Vtbl_ as IPersistFolder3Vtbl

type IPersistFolder3
	lpVtbl as IPersistFolder3Vtbl_ ptr
end type

type IPersistFolder3Vtbl
	QueryInterface as function(byval as IPersistFolder3 ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IPersistFolder3 ptr) as ULONG
	Release as function(byval as IPersistFolder3 ptr) as ULONG
	GetClassID as function(byval as IPersistFolder3 ptr, byval as CLSID ptr) as HRESULT
	Initialize as function(byval as IPersistFolder3 ptr, byval as LPCITEMIDLIST) as HRESULT
	GetCurFolder as function(byval as IPersistFolder3 ptr, byval as LPITEMIDLIST ptr) as HRESULT
	InitializeEx as function(byval as IPersistFolder3 ptr, byval as IBindCtx ptr, byval as LPCITEMIDLIST, byval as PERSIST_FOLDER_TARGET_INFO ptr) as HRESULT
	GetFolderTargetInfo as function(byval as IPersistFolder3 ptr, byval as PERSIST_FOLDER_TARGET_INFO ptr) as HRESULT
end type

type LPPERSISTFOLDER3 as IPersistFolder3 ptr

#define IPersistFolder3_QueryInterface(T,a,b) (T)->lpVtbl->QueryInterface(T,a,b)
#define IPersistFolder3_AddRef(T) (T)->lpVtbl->AddRef(T)
#define IPersistFolder3_Release(T) (T)->lpVtbl->Release(T)
#define IPersistFolder3_GetClassID(T,a) (T)->lpVtbl->GetClassID(T,a)
#define IPersistFolder3_Initialize(T,a) (T)->lpVtbl->Initialize(T,a)
#define IPersistFolder3_GetCurFolder(T,a) (T)->lpVtbl->GetCurFolder(T,a)
#define IPersistFolder3_InitializeEx(T,a,b,c) (T)->lpVtbl->InitializeEx(T,a,b,c)
#define IPersistFolder3_GetFolderTargetInfo(T,a) (T)->lpVtbl->GetFolderTargetInfo(T,a)

type LPSHELLBROWSER as IShellBrowser ptr
type LPSHELLVIEW as IShellView ptr

type IShellBrowserVtbl_ as IShellBrowserVtbl

type IShellBrowser
	lpVtbl as IShellBrowserVtbl_ ptr
end type

type IShellBrowserVtbl
	QueryInterface as function (byval as IShellBrowser ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IShellBrowser ptr) as ULONG
	Release as function (byval as IShellBrowser ptr) as ULONG
	GetWindow as function (byval as IShellBrowser ptr, byval as HWND ptr) as HRESULT
	ContextSensitiveHelp as function (byval as IShellBrowser ptr, byval as BOOL) as HRESULT
	InsertMenusSB as function (byval as IShellBrowser ptr, byval as HMENU, byval as LPOLEMENUGROUPWIDTHS) as HRESULT
	SetMenuSB as function (byval as IShellBrowser ptr, byval as HMENU, byval as HOLEMENU, byval as HWND) as HRESULT
	RemoveMenusSB as function (byval as IShellBrowser ptr, byval as HMENU) as HRESULT
	SetStatusTextSB as function (byval as IShellBrowser ptr, byval as LPCOLESTR) as HRESULT
	EnableModelessSB as function (byval as IShellBrowser ptr, byval as BOOL) as HRESULT
	TranslateAcceleratorSB as function (byval as IShellBrowser ptr, byval as LPMSG, byval as WORD) as HRESULT
	BrowseObject as function (byval as IShellBrowser ptr, byval as LPCITEMIDLIST, byval as UINT) as HRESULT
	GetViewStateStream as function (byval as IShellBrowser ptr, byval as DWORD, byval as LPSTREAM ptr) as HRESULT
	GetControlWindow as function (byval as IShellBrowser ptr, byval as UINT, byval as HWND ptr) as HRESULT
	SendControlMsg as function(byval as IShellBrowser ptr, byval as UINT, byval as UINT, byval as WPARAM, byval as LPARAM, byval as LONG ptr) as HRESULT
	QueryActiveShellView as function (byval as IShellBrowser ptr, byval as LPSHELLVIEW ptr) as HRESULT
	OnViewWindowActive as function (byval as IShellBrowser ptr, byval as LPSHELLVIEW) as HRESULT
	SetToolbarItems as function (byval as IShellBrowser ptr, byval as LPTBBUTTON, byval as UINT, byval as UINT) as HRESULT
end type

#define IShellBrowser_QueryInterface(T,a,b) (T)->lpVtbl->QueryInterface(T,a,b)
#define IShellBrowser_AddRef(T) (T)->lpVtbl->AddRef(T)
#define IShellBrowser_Release(T) (T)->lpVtbl->Release(T)
#define IShellBrowser_GetWindow(T,a) (T)->lpVtbl->GetWindow(T,a)
#define IShellBrowser_ContextSensitiveHelp(T,a) (T)->lpVtbl->ContextSensitiveHelp(T,a)
#define IShellBrowser_InsertMenusSB(T,a,b) (T)->lpVtbl->InsertMenusSB(T,a,b)
#define IShellBrowser_SetMenuSB(T,a,b,c) (T)->lpVtbl->SetMenuSB(T,a,b,c)
#define IShellBrowser_RemoveMenusSB(T,a) (T)->lpVtbl->RemoveMenusSB(T,a)
#define IShellBrowser_SetStatusTextSB(T,a) (T)->lpVtbl->SetStatusTextSB(T,a)
#define IShellBrowser_EnableModelessSB(T,a) (T)->lpVtbl->EnableModelessSB(T,a)
#define IShellBrowser_TranslateAcceleratorSB(T,a,b) (T)->lpVtbl->TranslateAcceleratorSB(T,a,b)
#define IShellBrowser_BrowseObject(T,a,b) (T)->lpVtbl->BrowseObject(T,a,b)
#define IShellBrowser_GetViewStateStream(T,a,b) (T)->lpVtbl->GetViewStateStream(T,a,b)
#define IShellBrowser_GetControlWindow(T,a,b) (T)->lpVtbl->GetControlWindow(T,a,b)
#define IShellBrowser_SendControlMsg(T,a,b,c,d,e) (T)->lpVtbl->SendControlMsg(T,a,b,c,d,e)
#define IShellBrowser_QueryActiveShellView(T,a) (T)->lpVtbl->QueryActiveShellView(T,a)
#define IShellBrowser_OnViewWindowActive(T,a) (T)->lpVtbl->OnViewWindowActive(T,a)
#define IShellBrowser_SetToolbarItems(T,a,b,c) (T)->lpVtbl->SetToolbarItems(T,a,b,c)

type IShellViewVtbl_ as IShellViewVtbl

type IShellView
	lpVtbl as IShellViewVtbl_ ptr
end type

type IShellViewVtbl
	QueryInterface as function (byval as IShellView ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IShellView ptr) as ULONG
	Release as function (byval as IShellView ptr) as ULONG
	GetWindow as function (byval as IShellView ptr, byval as HWND ptr) as HRESULT
	ContextSensitiveHelp as function (byval as IShellView ptr, byval as BOOL) as HRESULT
	TranslateAcceleratorA as function (byval as IShellView ptr, byval as LPMSG) as HRESULT
	EnableModeless as function (byval as IShellView ptr, byval as BOOL) as HRESULT
	UIActivate as function (byval as IShellView ptr, byval as UINT) as HRESULT
	Refresh as function (byval as IShellView ptr) as HRESULT
	CreateViewWindow as function (byval as IShellView ptr, byval as IShellView ptr, byval as LPCFOLDERSETTINGS, byval as LPSHELLBROWSER, byval as RECT ptr, byval as HWND ptr) as HRESULT
	DestroyViewWindow as function (byval as IShellView ptr) as HRESULT
	GetCurrentInfo as function (byval as IShellView ptr, byval as LPFOLDERSETTINGS) as HRESULT
	AddPropertySheetPages as function (byval as IShellView ptr, byval as DWORD, byval as LPFNADDPROPSHEETPAGE, byval as LPARAM) as HRESULT
	SaveViewState as function (byval as IShellView ptr) as HRESULT
	SelectItem as function (byval as IShellView ptr, byval as LPCITEMIDLIST, byval as UINT) as HRESULT
	GetItemObject as function (byval as IShellView ptr, byval as UINT, byval as IID ptr, byval as PVOID ptr) as HRESULT
end type

#define IShellView_QueryInterface(T,a,b) (T)->lpVtbl->QueryInterface(T,a,b)
#define IShellView_AddRef(T) (T)->lpVtbl->AddRef(T)
#define IShellView_Release(T) (T)->lpVtbl->Release(T)
#define IShellView_GetWindow(T,a) (T)->lpVtbl->GetWindow(T,a)
#define IShellView_ContextSensitiveHelp(T,a) (T)->lpVtbl->ContextSensitiveHelp(T,a)
#define IShellView_TranslateAccelerator(T,a) (T)->lpVtbl->TranslateAccelerator(T,a)
#define IShellView_EnableModeless(T,a) (T)->lpVtbl->EnableModeless(T,a)
#define IShellView_UIActivate(T,a) (T)->lpVtbl->UIActivate(T,a)
#define IShellView_Refresh(T) (T)->lpVtbl->Refresh(T)
#define IShellView_CreateViewWindow(T,a,b,c,d,e) (T)->lpVtbl->CreateViewWindow(T,a,b,c,d,e)
#define IShellView_DestroyViewWindow(T) (T)->lpVtbl->DestroyViewWindow(T)
#define IShellView_GetCurrentInfo(T,a) (T)->lpVtbl->GetCurrentInfo(T,a)
#define IShellView_AddPropertySheetPages(T,a,b,c) (T)->lpVtbl->AddPropertySheetPages(T,a,b,c)
#define IShellView_SaveViewState(T) (T)->lpVtbl->SaveViewState(T)
#define IShellView_SelectItem(T,a,b) (T)->lpVtbl->SelectItem(T,a,b)
#define IShellView_GetItemObject(T,a,b,c) (T)->lpVtbl->GetItemObject(T,a,b,c)

type ICommDlgBrowserVtbl_ as ICommDlgBrowserVtbl

type ICommDlgBrowser
	lpVtbl as ICommDlgBrowserVtbl_ ptr
end type

type ICommDlgBrowserVtbl
	QueryInterface as function (byval as ICommDlgBrowser ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as ICommDlgBrowser ptr) as ULONG
	Release as function (byval as ICommDlgBrowser ptr) as ULONG
	OnDefaultCommand as function (byval as ICommDlgBrowser ptr, byval as IShellView ptr) as HRESULT
	OnStateChange as function (byval as ICommDlgBrowser ptr, byval as IShellView ptr, byval as ULONG) as HRESULT
	IncludeObject as function (byval as ICommDlgBrowser ptr, byval as IShellView ptr, byval as LPCITEMIDLIST) as HRESULT
end type

type LPCOMMDLGBROWSER as ICommDlgBrowser ptr

#define ICommDlgBrowser_QueryInterface(T,a,b) (T)->lpVtbl->QueryInterface(T,a,b)
#define ICommDlgBrowser_AddRef(T) (T)->lpVtbl->AddRef(T)
#define ICommDlgBrowser_Release(T) (T)->lpVtbl->Release(T)
#define ICommDlgBrowser_OnDefaultCommand(T,a) (T)->lpVtbl->OnDefaultCommand(T,a)
#define ICommDlgBrowser_OnStateChange(T,a,b) (T)->lpVtbl->OnStateChange(T,a,b)
#define ICommDlgBrowser_IncludeObject(T,a,b) (T)->lpVtbl->IncludeObject(T,a,b)

type SHELLVIEWID as GUID

type SV2CVW2_PARAMS field=1
	cbSize as DWORD
	psvPrev as IShellView ptr
	pfs as FOLDERSETTINGS ptr
	psbOwner as IShellBrowser ptr
	prcView as RECT ptr
	pvid as SHELLVIEWID ptr
	hwndView as HWND
end type

type LPSV2CVW2_PARAMS as SV2CVW2_PARAMS ptr

type IShellView2Vtbl_ as IShellView2Vtbl

type IShellView2
	lpVtbl as IShellView2Vtbl_ ptr
end type

type IShellView2Vtbl
	QueryInterface as function (byval as IShellView2 ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IShellView2 ptr) as ULONG
	Release as function (byval as IShellView2 ptr) as ULONG
	GetWindow as function (byval as IShellView2 ptr, byval as HWND ptr) as HRESULT
	ContextSensitiveHelp as function (byval as IShellView2 ptr, byval as BOOL) as HRESULT
	TranslateAcceleratorA as function (byval as IShellView2 ptr, byval as LPMSG) as HRESULT
	EnableModeless as function (byval as IShellView2 ptr, byval as BOOL) as HRESULT
	UIActivate as function (byval as IShellView2 ptr, byval as UINT) as HRESULT
	Refresh as function (byval as IShellView2 ptr) as HRESULT
	CreateViewWindow as function (byval as IShellView2 ptr, byval as IShellView ptr, byval as LPCFOLDERSETTINGS, byval as LPSHELLBROWSER, byval as RECT ptr, byval as HWND ptr) as HRESULT
	DestroyViewWindow as function (byval as IShellView2 ptr) as HRESULT
	GetCurrentInfo as function (byval as IShellView2 ptr, byval as LPFOLDERSETTINGS) as HRESULT
	AddPropertySheetPages as function (byval as IShellView2 ptr, byval as DWORD, byval as LPFNADDPROPSHEETPAGE, byval as LPARAM) as HRESULT
	SaveViewState as function (byval as IShellView2 ptr) as HRESULT
	SelectItem as function (byval as IShellView2 ptr, byval as LPCITEMIDLIST, byval as UINT) as HRESULT
	GetItemObject as function (byval as IShellView2 ptr, byval as UINT, byval as IID ptr, byval as PVOID ptr) as HRESULT
	GetView as function (byval as IShellView2 ptr, byval as SHELLVIEWID ptr, byval as ULONG) as HRESULT
	CreateViewWindow2 as function (byval as IShellView2 ptr, byval as LPSV2CVW2_PARAMS) as HRESULT
end type

#ifndef UNICODE
type IShellExecuteHookAVtbl_ as IShellExecuteHookAVtbl

type IShellExecuteHookA
	lpVtbl as IShellExecuteHookAVtbl_ ptr
end type

type IShellExecuteHookAVtbl
	QueryInterface as function (byval as IShellExecuteHookA ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IShellExecuteHookA ptr) as ULONG
	Release as function (byval as IShellExecuteHookA ptr) as ULONG
	Execute as function (byval as IShellExecuteHookA ptr, byval as LPSHELLEXECUTEINFOA) as HRESULT
end type

#else ''UNICODE
type IShellExecuteHookWVtbl_ as IShellExecuteHookWVtbl

type IShellExecuteHookW
	lpVtbl as IShellExecuteHookWVtbl_ ptr
end type

type IShellExecuteHookWVtbl
	QueryInterface as function (byval as IShellExecuteHookW ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IShellExecuteHookW ptr) as ULONG
	Release as function (byval as IShellExecuteHookW ptr) as ULONG
	Execute as function (byval as IShellExecuteHookW ptr, byval as LPSHELLEXECUTEINFOW) as HRESULT
end type
#endif ''UNICODE
 
type IShellIconVtbl_ as IShellIconVtbl

type IShellIcon
	lpVtbl as IShellIconVtbl_ ptr
end type

type IShellIconVtbl
	QueryInterface as function (byval as IShellIcon ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IShellIcon ptr) as ULONG
	Release as function (byval as IShellIcon ptr) as ULONG
	GetIconOf as function (byval as IShellIcon ptr, byval as LPCITEMIDLIST, byval as UINT, byval as PINT) as HRESULT
end type

type LPSHELLICON as IShellIcon ptr

type SHELLFLAGSTATE field=1
	fShowAllObjects:1 as BOOL
	fShowExtensions:1 as BOOL
	fNoConfirmRecycle:1 as BOOL
	fShowSysFiles:1 as BOOL
	fShowCompColor:1 as BOOL
	fDoubleClickInWebView:1 as BOOL
	fDesktopHTML:1 as BOOL
	fWin95Classic:1 as BOOL
	fDontPrettyPath:1 as BOOL
	fShowAttribCol:1 as BOOL
	fMapNetDrvBtn:1 as BOOL
	fShowInfoTip:1 as BOOL
	fHideIcons:1 as BOOL
	fRestFlags:3 as UINT
end type

type LPSHELLFLAGSTATE as SHELLFLAGSTATE ptr

#define SSF_SHOWALLOBJECTS &h1
#define SSF_SHOWEXTENSIONS &h2
#define SSF_SHOWCOMPCOLOR &h8
#define SSF_SHOWSYSFILES &h20
#define SSF_DOUBLECLICKINWEBVIEW &h80
#define SSF_SHOWATTRIBCOL &h100
#define SSF_DESKTOPHTML &h200
#define SSF_WIN95CLASSIC &h400
#define SSF_DONTPRETTYPATH &h800
#define SSF_MAPNETDRVBUTTON &h1000
#define SSF_SHOWINFOTIP &h2000
#define SSF_HIDEICONS &h4000
#define SSF_NOCONFIRMRECYCLE &h8000

type IShellIconOverlayIdentifierVtbl_ as IShellIconOverlayIdentifierVtbl

type IShellIconOverlayIdentifier
	lpVtbl as IShellIconOverlayIdentifierVtbl_ ptr
end type

type IShellIconOverlayIdentifierVtbl
	QueryInterface as function(byval as IShellIconOverlayIdentifier ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IShellIconOverlayIdentifier ptr) as ULONG
	Release as function(byval as IShellIconOverlayIdentifier ptr) as ULONG
	IsMemberOf as function(byval as IShellIconOverlayIdentifier ptr, byval as LPCWSTR, byval as DWORD) as HRESULT
	GetOverlayInfo as function(byval as IShellIconOverlayIdentifier ptr, byval as LPWSTR, byval as integer, byval as integer ptr, byval as DWORD ptr) as HRESULT
	GetPriority as function(byval as IShellIconOverlayIdentifier ptr, byval as integer ptr) as HRESULT
end type

#define ISIOI_ICONFILE &h00000001
#define ISIOI_ICONINDEX &h00000002

type SHELLSTATE field=1
	fShowAllObjects:1 as BOOL
	fShowExtensions:1 as BOOL
	fNoConfirmRecycle:1 as BOOL
	fShowSysFiles:1 as BOOL
	fShowCompColor:1 as BOOL
	fDoubleClickInWebView:1 as BOOL
	fDesktopHTML:1 as BOOL
	fWin95Classic:1 as BOOL
	fDontPrettyPath:1 as BOOL
	fShowAttribCol:1 as BOOL
	fMapNetDrvBtn:1 as BOOL
	fShowInfoTip:1 as BOOL
	fHideIcons:1 as BOOL
	fWebView:1 as BOOL
	fFilter:1 as BOOL
	fShowSuperHidden:1 as BOOL
	fNoNetCrawling:1 as BOOL
	dwWin95Unused as DWORD
	uWin95Unused as UINT
	lParamSort as LONG
	iSortDirection as integer
	version as UINT
	uNotUsed as UINT
	fSepProcess:1 as BOOL
	fStartPanelOn:1 as BOOL
	fShowStartPage:1 as BOOL
	fSpareFlags:13 as UINT
end type

type LPSHELLSTATE as SHELLSTATE ptr

type SHDRAGIMAGE field=1
	sizeDragImage as SIZE
	ptOffset as POINT
	hbmpDragImage as HBITMAP
	crColorKey as COLORREF
end type

type LPSHDRAGIMAGE as SHDRAGIMAGE ptr

type IDragSourceHelperVtbl_ as IDragSourceHelperVtbl

type IDragSourceHelper
	lpVtbl as IDragSourceHelperVtbl_ ptr
end type

type IDragSourceHelperVtbl
	QueryInterface as function (byval as IDragSourceHelper ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function (byval as IDragSourceHelper ptr) as ULONG
	Release as function (byval as IDragSourceHelper ptr) as ULONG
	InitializeFromBitmap as function (byval as IDragSourceHelper ptr, byval as LPSHDRAGIMAGE, byval as IDataObject ptr) as HRESULT
	InitializeFromWindow as function (byval as IDragSourceHelper ptr, byval as HWND, byval as POINT ptr, byval as IDataObject ptr) as HRESULT
end type

type IDropTargetHelperVtbl_ as IDropTargetHelperVtbl

type IDropTargetHelper
	lpVtbl as IDropTargetHelperVtbl_ ptr
end type

type IDropTargetHelperVtbl
	QueryInterface as function (byval as IDropTargetHelper ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
	AddRef as function (byval as IDropTargetHelper ptr) as ULONG
	Release as function (byval as IDropTargetHelper ptr) as ULONG
	DragEnter as function (byval as IDropTargetHelper ptr, byval as HWND, byval as IDataObject ptr, byval as POINT ptr, byval as DWORD) as HRESULT
	DragLeave as function (byval as IDropTargetHelper ptr) as HRESULT
	DragOver as function (byval as IDropTargetHelper ptr, byval as POINT ptr, byval as DWORD) as HRESULT
	Drop as function (byval as IDropTargetHelper ptr, byval as IDataObject ptr, byval as POINT ptr, byval as DWORD) as HRESULT
	Show as function (byval as IDropTargetHelper ptr, byval as BOOL) as HRESULT
end type

declare sub SHAddToRecentDocs alias "SHAddToRecentDocs" (byval as UINT, byval as PCVOID)
declare sub SHChangeNotify alias "SHChangeNotify" (byval as LONG, byval as UINT, byval as PCVOID, byval as PCVOID)
declare function SHGetDesktopFolder alias "SHGetDesktopFolder" (byval as LPSHELLFOLDER ptr) as HRESULT
declare function SHGetInstanceExplorer alias "SHGetInstanceExplorer" (byval as IUnknown ptr ptr) as HRESULT
declare function SHGetMalloc alias "SHGetMalloc" (byval as LPMALLOC ptr) as HRESULT
declare function SHGetSpecialFolderLocation alias "SHGetSpecialFolderLocation" (byval as HWND, byval as integer, byval as LPITEMIDLIST ptr) as HRESULT
declare function SHLoadInProc alias "SHLoadInProc" (byval as CLSID ptr) as HRESULT
declare function SHGetFolderLocation alias "SHGetFolderLocation" (byval as HWND, byval as integer, byval as HANDLE, byval as DWORD, byval as LPITEMIDLIST ptr) as HRESULT
declare sub SHGetSettings alias "SHGetSettings" (byval as LPSHELLFLAGSTATE, byval as DWORD)
declare sub SHGetSetSettings alias "SHGetSetSettings" (byval as LPSHELLSTATE, byval as DWORD, byval as BOOL)
declare function SHCoCreateInstance alias "SHCoCreateInstance" (byval as LPCWSTR, byval as CLSID ptr, byval as IUnknown ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
declare function SHBindToParent alias "SHBindToParent" (byval as LPCITEMIDLIST, byval as IID ptr, byval as any ptr ptr, byval as LPCITEMIDLIST ptr) as HRESULT

declare function ILIsEqual alias "ILIsEqual" (byval as LPCITEMIDLIST, byval as LPCITEMIDLIST) as BOOL
declare function ILIsParent alias "ILIsParent" (byval as LPCITEMIDLIST, byval as LPCITEMIDLIST, byval as BOOL) as BOOL
declare function ILRemoveLastID alias "ILRemoveLastID" (byval as LPITEMIDLIST) as BOOL
declare function ILLoadFromStream alias "ILLoadFromStream" (byval as IStream ptr, byval as LPITEMIDLIST ptr) as HRESULT
declare function ILSaveToStream alias "ILSaveToStream" (byval as IStream ptr, byval as LPCITEMIDLIST) as HRESULT
declare function ILAppendID alias "ILAppendID" (byval as LPITEMIDLIST, byval as LPCSHITEMID, byval as BOOL) as LPITEMIDLIST
declare function ILClone alias "ILClone" (byval as LPCITEMIDLIST) as LPITEMIDLIST
declare function ILCloneFirst alias "ILCloneFirst" (byval as LPCITEMIDLIST) as LPITEMIDLIST
declare function ILCombine alias "ILCombine" (byval as LPCITEMIDLIST, byval as LPCITEMIDLIST) as LPITEMIDLIST
declare function ILFindChild alias "ILFindChild" (byval as LPCITEMIDLIST, byval as LPCITEMIDLIST) as LPITEMIDLIST
declare function ILFindLastID alias "ILFindLastID" (byval as LPCITEMIDLIST) as LPITEMIDLIST
declare function ILGetNext alias "ILGetNext" (byval as LPCITEMIDLIST) as LPITEMIDLIST
declare function ILGetSize alias "ILGetSize" (byval as LPCITEMIDLIST) as UINT
declare sub ILFree alias "ILFree" (byval as LPITEMIDLIST)

#ifdef UNICODE
declare function SHBrowseForFolder alias "SHBrowseForFolderW" (byval as PBROWSEINFOW) as LPITEMIDLIST
declare function SHGetDataFromIDList alias "SHGetDataFromIDListW" (byval as LPSHELLFOLDER, byval as LPCITEMIDLIST, byval as integer, byval as PVOID, byval as integer) as HRESULT
declare function SHGetPathFromIDList alias "SHGetPathFromIDListW" (byval as LPCITEMIDLIST, byval as LPWSTR) as BOOL
declare function SHGetSpecialFolderPath alias "SHGetSpecialFolderPathW" (byval as HWND, byval as LPWSTR, byval as integer, byval as BOOL) as BOOL
declare function SHGetFolderPath alias "SHGetFolderPathW" (byval as HWND, byval as integer, byval as HANDLE, byval as DWORD, byval as LPWSTR) as HRESULT
declare function SHCreateDirectoryEx alias "SHCreateDirectoryExW" (byval as HWND, byval as LPCWSTR, byval as LPSECURITY_ATTRIBUTES) as INT_
declare function SHGetFolderPathAndSubDir alias "SHGetFolderPathAndSubDirW" (byval as HWND, byval as integer, byval as HANDLE, byval as DWORD, byval as LPCWSTR, byval as LPWSTR) as HRESULT

type IShellExecuteHook as IShellExecuteHookW
type IShellLink as IShellLinkW
type BROWSEINFO as BROWSEINFOW
type PBROWSEINFO as BROWSEINFOW ptr
type LPBROWSEINFO as BROWSEINFOW ptr

#else ''UNICODE
declare function SHBrowseForFolder alias "SHBrowseForFolderA" (byval as PBROWSEINFOA) as LPITEMIDLIST
declare function SHGetDataFromIDList alias "SHGetDataFromIDListA" (byval as LPSHELLFOLDER, byval as LPCITEMIDLIST, byval as integer, byval as PVOID, byval as integer) as HRESULT
declare function SHGetPathFromIDList alias "SHGetPathFromIDListA" (byval as LPCITEMIDLIST, byval as LPSTR) as BOOL
declare function SHGetSpecialFolderPath alias "SHGetSpecialFolderPathA" (byval as HWND, byval as LPSTR, byval as integer, byval as BOOL) as BOOL
declare function SHGetFolderPath alias "SHGetFolderPathA" (byval as HWND, byval as integer, byval as HANDLE, byval as DWORD, byval as LPSTR) as HRESULT
declare function SHCreateDirectoryEx alias "SHCreateDirectoryExA" (byval as HWND, byval as LPCSTR, byval as LPSECURITY_ATTRIBUTES) as INT_
declare function SHGetFolderPathAndSubDir alias "SHGetFolderPathAndSubDirA" (byval as HWND, byval as integer, byval as HANDLE, byval as DWORD, byval as LPCSTR, byval as LPSTR) as HRESULT

type IShellExecuteHook as IShellExecuteHookA
type IShellLink as IShellLinkA
type BROWSEINFO as BROWSEINFOA
type PBROWSEINFO as BROWSEINFOA ptr
type LPBROWSEINFO as BROWSEINFOA ptr
#endif ''UNICODE

declare function SHFormatDrive alias "SHFormatDrive" (byval as HWND, byval as UINT, byval as UINT, byval as UINT) as DWORD

#define SHFMT_ID_DEFAULT &hFFFF
#define SHFMT_OPT_FULL 1
#define SHFMT_OPT_SYSONLY 2
#define SHFMT_ERROR &hFFFFFFFF
#define SHFMT_CANCEL &hFFFFFFFE
#define SHFMT_NOFORMAT &hFFFFFFFD

#endif
