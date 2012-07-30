''
''
'' shellapi -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_shellapi_bi__
#define __win_shellapi_bi__

#inclib "shell32"

#define ABE_LEFT 0
#define ABE_TOP 1
#define ABE_RIGHT 2
#define ABE_BOTTOM 3
#define ABS_AUTOHIDE 1
#define ABS_ALWAYSONTOP 2
#define SEE_MASK_CLASSNAME 1
#define SEE_MASK_CLASSKEY 3
#define SEE_MASK_IDLIST 4
#define SEE_MASK_INVOKEIDLIST 12
#define SEE_MASK_ICON &h10
#define SEE_MASK_HOTKEY &h20
#define SEE_MASK_NOCLOSEPROCESS &h40
#define SEE_MASK_CONNECTNETDRV &h80
#define SEE_MASK_FLAG_DDEWAIT &h100
#define SEE_MASK_DOENVSUBST &h200
#define SEE_MASK_FLAG_NO_UI &h400
#define SEE_MASK_NO_CONSOLE &h8000
#define SEE_MASK_UNICODE &h10000
#define SEE_MASK_ASYNCOK &h100000
#define SEE_MASK_HMONITOR &h200000
#define ABM_NEW 0
#define ABM_REMOVE 1
#define ABM_QUERYPOS 2
#define ABM_SETPOS 3
#define ABM_GETSTATE 4
#define ABM_GETTASKBARPOS 5
#define ABM_ACTIVATE 6
#define ABM_GETAUTOHIDEBAR 7
#define ABM_SETAUTOHIDEBAR 8
#define ABM_WINDOWPOSCHANGED 9
#define ABN_STATECHANGE 0
#define ABN_POSCHANGED 1
#define ABN_FULLSCREENAPP 2
#define ABN_WINDOWARRANGE 3
#define NIM_ADD 0
#define NIM_MODIFY 1
#define NIM_DELETE 2
#define NOTIFYICON_VERSION 3
#define NIM_SETFOCUS 3
#define NIM_SETVERSION 4
#define NIF_MESSAGE &h00000001
#define NIF_ICON &h00000002
#define NIF_TIP &h00000004
#define NIF_STATE &h00000008
#define NIF_INFO &h00000010
#define NIF_GUID &h00000020
#define NIIF_NONE &h00000000
#define NIIF_INFO &h00000001
#define NIIF_WARNING &h00000002
#define NIIF_ERROR &h00000003
#define NIIF_ICON_MASK &h0000000F
#define NIIF_NOSOUND &h00000010
#define NIS_HIDDEN 1
#define NIS_SHAREDICON 2
#define SE_ERR_FNF 2
#define SE_ERR_PNF 3
#define SE_ERR_ACCESSDENIED 5
#define SE_ERR_OOM 8
#define SE_ERR_DLLNOTFOUND 32
#define SE_ERR_SHARE 26
#define SE_ERR_ASSOCINCOMPLETE 27
#define SE_ERR_DDETIMEOUT 28
#define SE_ERR_DDEFAIL 29
#define SE_ERR_DDEBUSY 30
#define SE_ERR_NOASSOC 31
#define FO_MOVE 1
#define FO_COPY 2
#define FO_DELETE 3
#define FO_RENAME 4
#define FOF_MULTIDESTFILES 1
#define FOF_CONFIRMMOUSE 2
#define FOF_SILENT 4
#define FOF_RENAMEONCOLLISION 8
#define FOF_NOCONFIRMATION 16
#define FOF_WANTMAPPINGHANDLE 32
#define FOF_ALLOWUNDO 64
#define FOF_FILESONLY 128
#define FOF_SIMPLEPROGRESS 256
#define FOF_NOCONFIRMMKDIR 512
#define FOF_NOERRORUI 1024
#define FOF_NOCOPYSECURITYATTRIBS 2048
#define PO_DELETE 19
#define PO_RENAME 20
#define PO_PORTCHANGE 32
#define PO_REN_PORT 52
#define SHGFI_ICON 256
#define SHGFI_DISPLAYNAME 512
#define SHGFI_TYPENAME 1024
#define SHGFI_ATTRIBUTES 2048
#define SHGFI_ICONLOCATION 4096
#define SHGFI_EXETYPE 8192
#define SHGFI_SYSICONINDEX 16384
#define SHGFI_LINKOVERLAY 32768
#define SHGFI_SELECTED 65536
#define SHGFI_ATTR_SPECIFIED 131072
#define SHGFI_LARGEICON 0
#define SHGFI_SMALLICON 1
#define SHGFI_OPENICON 2
#define SHGFI_SHELLICONSIZE 4
#define SHGFI_PIDL 8
#define SHGFI_USEFILEATTRIBUTES 16
#define SHERB_NOCONFIRMATION 1
#define SHERB_NOPROGRESSUI 2
#define SHERB_NOSOUND 4

type FILEOP_FLAGS as WORD
type PRINTEROP_FLAGS as WORD

type APPBARDATA field=2
	cbSize as DWORD
	hWnd as HWND
	uCallbackMessage as UINT
	uEdge as UINT
	rc as RECT
	lParam as LPARAM
end type

type PAPPBARDATA as APPBARDATA ptr

type HDROP__
	i as integer
end type

type HDROP as HDROP__ ptr

#ifndef UNICODE
type NOTIFYICONDATAA field=2
	cbSize as DWORD
	hWnd as HWND
	uID as UINT
	uFlags as UINT
	uCallbackMessage as UINT
	hIcon as HICON
	szTip as zstring * 128
	dwState as DWORD
	dwStateMask as DWORD
	szInfo as zstring * 256
	union
		uTimeout as UINT
		uVersion as UINT
	end union
	szInfoTitle as zstring * 64
	dwInfoFlags as DWORD
	guidItem as GUID
end type

type PNOTIFYICONDATAA as NOTIFYICONDATAA ptr

#else ''UNICODE
type NOTIFYICONDATAW field=2
	cbSize as DWORD
	hWnd as HWND
	uID as UINT
	uFlags as UINT
	uCallbackMessage as UINT
	hIcon as HICON
	szTip as wstring * 128
	dwState as DWORD
	dwStateMask as DWORD
	szInfo as wstring * 256
	union
		uTimeout as UINT
		uVersion as UINT
	end union
	szInfoTitle as wstring * 64
	dwInfoFlags as DWORD
	guidItem as GUID
end type

type PNOTIFYICONDATAW as NOTIFYICONDATAW ptr
#endif ''UNICODE

#ifndef UNICODE
type SHELLEXECUTEINFOA field=2
	cbSize as DWORD
	fMask as ULONG
	hwnd as HWND
	lpVerb as LPCSTR
	lpFile as LPCSTR
	lpParameters as LPCSTR
	lpDirectory as LPCSTR
	nShow as integer
	hInstApp as HINSTANCE
	lpIDList as PVOID
	lpClass as LPCSTR
	hkeyClass as HKEY
	dwHotKey as DWORD
	hIcon as HANDLE
	hProcess as HANDLE
end type

type LPSHELLEXECUTEINFOA as SHELLEXECUTEINFOA ptr

#else ''UNICODE
type SHELLEXECUTEINFOW field=2
	cbSize as DWORD
	fMask as ULONG
	hwnd as HWND
	lpVerb as LPCWSTR
	lpFile as LPCWSTR
	lpParameters as LPCWSTR
	lpDirectory as LPCWSTR
	nShow as integer
	hInstApp as HINSTANCE
	lpIDList as PVOID
	lpClass as LPCWSTR
	hkeyClass as HKEY
	dwHotKey as DWORD
	hIcon as HANDLE
	hProcess as HANDLE
end type

type LPSHELLEXECUTEINFOW as SHELLEXECUTEINFOW ptr
#endif ''UNICODE

#ifndef UNICODE
type SHFILEOPSTRUCTA field=2
	hwnd as HWND
	wFunc as UINT
	pFrom as LPCSTR
	pTo as LPCSTR
	fFlags as FILEOP_FLAGS
	fAnyOperationsAborted as BOOL
	hNameMappings as PVOID
	lpszProgressTitle as LPCSTR
end type

type LPSHFILEOPSTRUCTA as SHFILEOPSTRUCTA ptr

#else ''UNICODE
type SHFILEOPSTRUCTW field=2
	hwnd as HWND
	wFunc as UINT
	pFrom as LPCWSTR
	pTo as LPCWSTR
	fFlags as FILEOP_FLAGS
	fAnyOperationsAborted as BOOL
	hNameMappings as PVOID
	lpszProgressTitle as LPCWSTR
end type

type LPSHFILEOPSTRUCTW as SHFILEOPSTRUCTW ptr
#endif ''UNICODE

#ifndef UNICODE
type SHFILEINFOA field=2
	hIcon as HICON
	iIcon as integer
	dwAttributes as DWORD
	szDisplayName as zstring * 260
	szTypeName as zstring * 80
end type

#else ''UNICODE
type SHFILEINFOW field=2
	hIcon as HICON
	iIcon as integer
	dwAttributes as DWORD
	szDisplayName as wstring * 260
	szTypeName as wstring * 80
end type
#endif ''UNICODE

type SHQUERYRBINFO field=2
	cbSize as DWORD
	i64Size as longint
	i64NumItems as longint
end type

type LPSHQUERYRBINFO as SHQUERYRBINFO ptr

declare sub DragAcceptFiles alias "DragAcceptFiles" (byval as HWND, byval as BOOL)
declare sub DragFinish alias "DragFinish" (byval as HDROP)
declare function DragQueryPoint alias "DragQueryPoint" (byval as HDROP, byval as LPPOINT) as BOOL
declare function SHAppBarMessage alias "SHAppBarMessage" (byval as DWORD, byval as PAPPBARDATA) as UINT
declare sub SHFreeNameMappings alias "SHFreeNameMappings" (byval as HANDLE)

#ifdef UNICODE
declare function CommandLineToArgv alias "CommandLineToArgvW" (byval as LPCWSTR, byval as integer ptr) as LPWSTR ptr
declare function DragQueryFile alias "DragQueryFileW" (byval as HDROP, byval as UINT, byval as LPWSTR, byval as UINT) as UINT
declare function ExtractAssociatedIcon alias "ExtractAssociatedIconW" (byval as HINSTANCE, byval as LPCWSTR, byval as PWORD) as HICON
declare function ExtractIcon alias "ExtractIconW" (byval as HINSTANCE, byval as LPCWSTR, byval as UINT) as HICON
declare function ExtractIconEx alias "ExtractIconExW" (byval as LPCWSTR, byval as integer, byval as HICON ptr, byval as HICON ptr, byval as UINT) as UINT
declare function FindExecutable alias "FindExecutableW" (byval as LPCWSTR, byval as LPCWSTR, byval as LPWSTR) as HINSTANCE
declare function Shell_NotifyIcon alias "Shell_NotifyIconW" (byval as DWORD, byval as PNOTIFYICONDATAW) as BOOL
declare function ShellAbout alias "ShellAboutW" (byval as HWND, byval as LPCWSTR, byval as LPCWSTR, byval as HICON) as integer
declare function ShellExecute alias "ShellExecuteW" (byval as HWND, byval as LPCWSTR, byval as LPCWSTR, byval as LPCWSTR, byval as LPCWSTR, byval as INT_) as HINSTANCE
declare function ShellExecuteEx alias "ShellExecuteExW" (byval as LPSHELLEXECUTEINFOW) as BOOL
declare function SHFileOperation alias "SHFileOperationW" (byval as LPSHFILEOPSTRUCTW) as integer
declare function SHGetFileInfo alias "SHGetFileInfoW" (byval as LPCWSTR, byval as DWORD, byval as SHFILEINFOW ptr, byval as UINT, byval as UINT) as DWORD
declare function SHQueryRecycleBin alias "SHQueryRecycleBinW" (byval as LPCWSTR, byval as LPSHQUERYRBINFO) as HRESULT
declare function SHEmptyRecycleBin alias "SHEmptyRecycleBinW" (byval as HWND, byval as LPCWSTR, byval as DWORD) as HRESULT

type NOTIFYICONDATA as NOTIFYICONDATAW
type PNOTIFYICONDATA as NOTIFYICONDATAW ptr
type SHELLEXECUTEINFO as SHELLEXECUTEINFOW
type LPSHELLEXECUTEINFO as SHELLEXECUTEINFOW ptr
type SHFILEOPSTRUCT as SHFILEOPSTRUCTW
type LPSHFILEOPSTRUCT as SHFILEOPSTRUCTW ptr
type SHFILEINFO as SHFILEINFOW

#else ''UNICODE
declare function DragQueryFile alias "DragQueryFileA" (byval as HDROP, byval as UINT, byval as LPSTR, byval as UINT) as UINT
declare function ExtractAssociatedIcon alias "ExtractAssociatedIconA" (byval as HINSTANCE, byval as LPCSTR, byval as PWORD) as HICON
declare function ExtractIcon alias "ExtractIconA" (byval as HINSTANCE, byval as LPCSTR, byval as UINT) as HICON
declare function ExtractIconEx alias "ExtractIconExA" (byval as LPCSTR, byval as integer, byval as HICON ptr, byval as HICON ptr, byval as UINT) as UINT
declare function FindExecutable alias "FindExecutableA" (byval as LPCSTR, byval as LPCSTR, byval as LPSTR) as HINSTANCE
declare function Shell_NotifyIcon alias "Shell_NotifyIconA" (byval as DWORD, byval as PNOTIFYICONDATAA) as BOOL
declare function ShellAbout alias "ShellAboutA" (byval as HWND, byval as LPCSTR, byval as LPCSTR, byval as HICON) as integer
declare function ShellExecute alias "ShellExecuteA" (byval as HWND, byval as LPCSTR, byval as LPCSTR, byval as LPCSTR, byval as LPCSTR, byval as INT_) as HINSTANCE
declare function ShellExecuteEx alias "ShellExecuteExA" (byval as LPSHELLEXECUTEINFOA) as BOOL
declare function SHFileOperation alias "SHFileOperationA" (byval as LPSHFILEOPSTRUCTA) as integer
declare function SHGetFileInfo alias "SHGetFileInfoA" (byval as LPCSTR, byval as DWORD, byval as SHFILEINFOA ptr, byval as UINT, byval as UINT) as DWORD
declare function SHQueryRecycleBin alias "SHQueryRecycleBinA" (byval as LPCSTR, byval as LPSHQUERYRBINFO) as HRESULT
declare function SHEmptyRecycleBin alias "SHEmptyRecycleBinA" (byval as HWND, byval as LPCSTR, byval as DWORD) as HRESULT

type NOTIFYICONDATA as NOTIFYICONDATAA
type PNOTIFYICONDATA as NOTIFYICONDATAA ptr
type SHELLEXECUTEINFO as SHELLEXECUTEINFOA
type LPSHELLEXECUTEINFO as SHELLEXECUTEINFOA ptr
type SHFILEOPSTRUCT as SHFILEOPSTRUCTA
type LPSHFILEOPSTRUCT as SHFILEOPSTRUCTA ptr
type SHFILEINFO as SHFILEINFOA

#endif ''UNICODE

#endif
