#ifndef SHELLAPI_BI
#define SHELLAPI_BI
'-----------
'SHELLAPI.BI
'-----------
'
'This header defines every obtainable shell32 Function and related data types and structures.

'VERSION: 1.00

'$include once: "win\winbase.bi"

'----------------------
'| REQUIRED CONSTANTS |
'----------------------

'for FindExecutable
#define SE_ERR_FNF  2
#define SE_ERR_NOASSOC  31
#define SE_ERR_OOM  8

'for SHAddToRecentDocs
#define SHARD_PATHA  &H2&
#define SHARD_PIDL  &H1&

'for SHAppBarMessage
#define ABM_ACTIVATE  &H6
#define ABM_GETAUTOHIDEBAR  &H7
#define ABM_GETSTATE  &H4
#define ABM_GETTASKBARPOS  &H5
#define ABM_NEW  &H0
#define ABM_QUERYPOS  &H2
#define ABM_REMOVE  &H1
#define ABM_SETAUTOHIDEBAR  &H8
#define ABM_SETPOS  &H3
#define ABM_WINDOWPOSCHANGED  &H9

'for SHBrowseForFolder
#define BIF_BROWSEFORCOMPUTER  &H1000
#define BIF_BROWSEFORPRINTER  &H2000
#define BIF_BROWSEINCLUDEFILES  &H4000
#define BIF_BROWSEINCLUDEURLS  &H80
#define BIF_DONTGOBELOWDOMAIN  &H2
#define BIF_EDITBOX  &H10
#define BIF_NEWDIALOGSTYLE  &H40
#define BIF_RETURNFSANCESTORS  &H8
#define BIF_RETURNONLYFSDIRS  &H1
#define BIF_SHAREABLE  &H8000
#define BIF_STATUSTEXT  &H4
#define BIF_USENEWUI  &H40
#define BIF_VALIDATE  &H20

'for SHChangeNotify (wEventId)
#define SHCNE_ALLEVENTS  &H7FFFFFFF&
#define SHCNE_ASSOCCHANGED  &H8000000&
#define SHCNE_ATTRIBUTES  &H800&
#define SHCNE_CREATE  &H2&
#define SHCNE_DELETE  &H4&
#define SHCNE_DRIVEADD  &H100&
#define SHCNE_DRIVEADDGUI  &H10000&
#define SHCNE_DRIVEREMOVED  &H80&
#define SHCNE_EXTENDED_EVENT  &H4000000&
#define SHCNE_FREESPACE  &H40000&
#define SHCNE_MEDIAINSERTED  &H20&
#define SHCNE_MEDIAREMOVED  &H40&
#define SHCNE_MKDIR  &H8&
#define SHCNE_NETSHARE  &H200&
#define SHCNE_NETUNSHARE  &H400&
#define SHCNE_RENAMEFOLDER  &H20000&
#define SHCNE_RENAMEITEM  &H1&
#define SHCNE_RMDIR  &H10&
#define SHCNE_SERVERDISCONNECT  &H4000&
#define SHCNE_UPDATEDIR  &H1000&
#define SHCNE_UPDATEIMAGE  &H8000&
#define SHCNE_UPDATEITEM  &H2000&
#define SHCNE_DISKEVENTS  &H2381F&
#define SHCNE_GLOBALEVENTS  &HC0581E0&
#define SHCNE_INTERRUPT  &H80000000&

'for SHChangeNotify (uFlags)
#define SHCNF_DWORD  &H3
#define SHCNF_IDLIST  &H0
#define SHCNF_PATHA  &H1
#define SHCNF_PRINTERA  &H2
#define SHCNF_FLUSH  &H1000
#define SHCNF_FLUSHNOWAIT  &H2000

'for SHEmptyRecycleBin
#define SHERB_NOCONFIRMATION  &H1
#define SHERB_NOPROGRESSUI  &H2
#define SHERB_NOSOUND  &H4

'for SHFileOperation (wFunc)
#define FO_COPY  &H2
#define FO_DELETE  &H3
#define FO_MOVE  &H1
#define FO_RENAME  &H4

'for SHFileOperation (fFlags)
#define FOF_ALLOWUNDO  &H40
#define FOF_CONFIRMMOUSE  &H2
#define FOF_FILESONLY  &H80
#define FOF_MULTIDESTFILES  &H1
#define FOF_NOCONFIRMATION  &H10
#define FOF_NOCONFIRMMKDIR  &H200
#define FOF_NO_CONNECTED_ELEMENTS  &H2000
#define FOF_NOCOPYSECURITYATTRIBS  &H800
#define FOF_NOERRORUI  &H400
#define FOF_NORECURSION  &H1000
#define FOF_RENAMEONCOLLISION  &H8
#define FOF_SILENT  &H4
#define FOF_SIMPLEPROGRESS  &H100
#define FOF_WANTMAPPINGHANDLE  &H20
#define FOF_WANTNUKEWARNING  &H4000

'for SHGetFileInfo
#define SHGFI_ADDOVERLAYS  &H20
#define SHGFI_ATTR_SPECIFIED  &H20000
#define SHGFI_ATTRIBUTES  &H800
#define SHGFI_DISPLAYNAME  &H200
#define SHGFI_EXETYPE  &H2000
#define SHGFI_ICON  &H100
#define SHGFI_ICONLOCATION  &H1000
#define SHGFI_LARGEICON  &H0
#define SHGFI_LINKOVERLAY  &H8000
#define SHGFI_OPENICON  &H2
#define SHGFI_OVERLAYINDEX  &H40
#define SHGFI_PIDL  &H8
#define SHGFI_SELECTED  &H10000
#define SHGFI_SHELLICONSIZE  &H4
#define SHGFI_SMALLICON  &H1
#define SHGFI_SYSICONINDEX  &H4000
#define SHGFI_TYPENAME  &H400
#define SHGFI_USEFILEATTRIBUTES  &H10

'for SHGetNewLinkInfo
#define SHGNLI_PIDL  &H1
#define SHGNLI_NOUNIQUE  &H4
#define SHGNLI_PREFIXNAME  &H2

'for SHInvokePrinterCommand
#define PRINTACTION_DOCUMENTDEFAULTS  6
#define PRINTACTION_NETINSTALL  2
#define PRINTACTION_NETINSTALLLINK  3
#define PRINTACTION_OPEN  0
#define PRINTACTION_OPENNETPRN  5
#define PRINTACTION_PROPERTIES  1
#define PRINTACTION_SERVERPROPERTIES  7
#define PRINTACTION_TESTPAGE  4

'------------------
'| REQUIRED TYPES |
'------------------

Type APPBARDATA
  cbSize           As Integer
  hwnd             As Integer
  uCallbackMessage As Integer
  uEdge            As Integer
  rc               As RECT
  lParam           As Integer ' message specific
End Type

Type SHFILEOPSTRUCT Field = 1
  hWnd      As Integer
  wFunc     As Integer
  pFrom     As Byte ptr
  pTo       As Byte ptr
  fFlags    As Short
  fAborted  As Integer
  hNameMaps As Integer
  sProgress As Byte ptr
End Type

Type SHFILEINFO
  hIcon         As Integer           ' : icon
  iIcon         As Integer           ' : icondex
  dwAttributes  As Integer           ' : SFGAO_ flags
  szDisplayName As String * MAX_PATH-1 ' : display name (or path)
  szTypeName    As String * 80-1       ' : type name
End Type

Type NOTIFYICONDATA
  cbSize           As Integer
  hwnd             As Integer
  uID              As Integer
  uFlags           As Integer
  uCallbackMessage As Integer
  hIcon            As Integer
  szTip            As String * 64-1
End Type

Type BROWSEINFO Field = 1
  hOwner         As Integer
  pidlRoot       As Integer
  pszDisplayName As byte ptr
  lpszTitle      As byte ptr
  ulFlags        As Integer
  lpfn           As Integer
  lparam         As Integer
  iImage         As Integer
End Type

'-----------------
'| API FunctionS |
'-----------------

Declare Function CommandLineToArgv Lib "shell32" Alias "CommandLineToArgvA" (ByVal lpCmdLine As String, ByRef pNumArgs As Short) As Integer
Declare Function DoEnvironmentSubst Lib "shell32" Alias "DoEnvironmentSubstA" (ByVal szString As String, ByVal cbString As Integer) As Integer
Declare Sub DragAcceptFiles Lib "shell32" (ByVal hwnd As Integer, ByVal fAccept As Integer)
Declare Sub DragFinish Lib "shell32" (ByVal hDrop As Integer)
Declare Function DragQueryFile Lib "shell32" Alias "DragQueryFileA" (ByVal HDROP As Integer, ByVal UINT As Integer, ByVal lpStr As String, ByVal ch As Integer) As Integer
Declare Function DragQueryPoint Lib "shell32" (ByVal HDROP As Integer, ByRef lpPoint As POINTAPI) As Integer
Declare Function DuplicateIcon Lib "shell32" (ByVal hInst As Integer, ByVal hIcon As Integer) As Integer
Declare Function ExtractAssociatedIcon Lib "shell32" Alias "ExtractAssociatedIconA" (ByVal hInst As Integer, ByVal lpIconPath As String, ByRef lpiIcon As Integer) As Integer
Declare Function ExtractIcon Lib "shell32" Alias "ExtractIconA" (ByVal hInst As Integer, ByVal lpszExeFileName As String, ByVal nIconIndex As Integer) As Integer
Declare Function ExtractIconEx Lib "shell32" Alias "ExtractIconExA" (ByVal lpszFile As String, ByVal nIconIndex As Integer, ByRef phiconLarge As Integer, ByRef phiconSmall As Integer, ByVal nIcons As Integer) As Integer
Declare Function FindExecutable Lib "shell32" Alias "FindExecutableA" (ByVal lpFile As String, ByVal lpDirectory As String, ByVal lpResult As String) As Integer
Declare Sub SHAddToRecentDocs Lib "shell32" (ByVal uFlags As Integer, ByRef pv As Any)
Declare Function SHAppBarMessage Lib "shell32" (ByVal dwMessage As Integer, ByRef pData As APPBARDATA) As Integer
Declare Function SHBrowseForFolder Lib "shell32" Alias "SHBrowseForFolderA" (lpBrowseInfo As BROWSEINFO) As Integer
Declare Sub SHChangeNotify Lib "shell32" (ByVal wEventId As Integer, ByVal uFlags As Integer, ByRef dwItem1 As Any, ByRef dwItem2 As Any)
Declare Sub SHEmptyRecycleBin Lib "shell32" Alias "SHEmptyRecycleBinA" (ByVal hwnd As Integer, ByVal pszRootPath As String, ByVal dwFlags As Integer)
Declare Function SHFileOperation Lib "shell32" Alias "SHFileOperationA" (ByRef lpFileOp As SHFILEOPSTRUCT) As Integer
Declare Sub SHFreeNameMappings Lib "shell32" (ByVal hNameMappings As Integer)
Declare Sub SHGetDesktopFolder Lib "shell32" (ByRef ppshf As Integer)
Declare Function SHGetDiskFreeSpaceEx Lib "shell32" Alias "SHGetDiskFreeSpaceExA" (ByVal pszDirectoryName As String, ByRef pulFreeBytesAvailableToCaller As INT64, ByRef pulTotalNumberOfBytes As INT64, ByRef pulTotalNumberOfFreeBytes As INT64) As Integer
Declare Function SHGetFileInfo Lib "shell32" Alias "SHGetFileInfoA" (ByVal pszPath As String, ByVal dwFileAttributes As Integer, ByRef psfi As SHFILEINFO, ByVal cbFileInfo As Integer, ByVal uFlags As Integer) As Integer
Declare Sub SHGetInstanceExplorer Lib "shell32" (ByVal ppunk As Integer)
Declare Function SHGetNewLinkInfo Lib "shell32" Alias "SHGetNewLinkInfoA" (ByVal pszLinkto As String, ByVal pszDir As String, ByVal pszName As String, ByRef pfMustCopy As Integer, ByVal uFlags As Integer) As Integer
Declare Function SHGetPathFromIDList Lib "shell32" Alias "SHGetPathFromIDListA" (ByVal pidl As Integer, ByVal pszPath As String) As Integer
Declare Function SHGetSpecialFolderPath Lib "shell32" Alias "SHGetSpecialFolderPathA" (ByVal hwnd As Integer, ByVal pszPath As String, ByVal csidl As Integer, ByVal fCreate As Integer) As Integer
Declare Function SHInvokePrinterCommand Lib "shell32" Alias "SHInvokePrinterCommandA" (ByVal hwnd As Integer, ByVal uAction As Integer, ByVal lpBuf1 As String, ByVal lpBuf2 As String, ByVal fModal As Integer) As Integer
Declare Sub SHLoadInProc Lib "shell32" (ByVal rclsid As Integer)
Declare Function ShellAbout Lib "shell32" Alias "ShellAboutA" (ByVal hwnd As Integer, ByVal szApp As String, ByVal szOtherStuff As String, ByVal hIcon As Integer) As Integer
Declare Function ShellExecute Lib "shell32" Alias "ShellExecuteA" (ByVal hwnd As Integer, ByVal lpOperation As String, ByVal lpFile As String, ByVal lpParameters As String, ByVal lpDirectory As String, ByVal nShowCmd As Integer) As Integer
Declare Function Shell_NotifyIcon Lib "shell32" Alias "Shell_NotifyIconA" (ByVal dwMessage As Integer, ByRef lpData As NOTIFYICONDATA) As Integer

#endif 'SHELLAPI