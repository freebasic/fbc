''
''
'' ole -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_ole_bi__
#define __win_ole_bi__

#inclib "ole32"

type OLE_LPCSTR as const zstring ptr
#define OLE_CONST
#ifndef LRESULT
type LRESULT as LONG
#endif
#ifndef HGLOBAL
type HGLOBAL as HANDLE
#endif

#define OT_LINK 1L
#define OT_EMBEDDED 2L
#define OT_STATIC 3L
#define OLEVERB_PRIMARY 0
#define OF_SET 1
#define OF_GET 2
#define OF_HANDLER 4

type OLETARGETDEVICE
	otdDeviceNameOffset as USHORT
	otdDriverNameOffset as USHORT
	otdPortNameOffset as USHORT
	otdExtDevmodeOffset as USHORT
	otdExtDevmodeSize as USHORT
	otdEnvironmentOffset as USHORT
	otdEnvironmentSize as USHORT
	otdData(0 to 1-1) as UBYTE
end type

type LPOLETARGETDEVICE as OLETARGETDEVICE ptr

enum OLESTATUS
	OLE_OK
	OLE_WAIT_FOR_RELEASE
	OLE_BUSY
	OLE_ERROR_PROTECT_ONLY
	OLE_ERROR_MEMORY
	OLE_ERROR_STREAM
	OLE_ERROR_STATIC
	OLE_ERROR_BLANK
	OLE_ERROR_DRAW
	OLE_ERROR_METAFILE
	OLE_ERROR_ABORT
	OLE_ERROR_CLIPBOARD
	OLE_ERROR_FORMAT
	OLE_ERROR_OBJECT
	OLE_ERROR_OPTION
	OLE_ERROR_PROTOCOL
	OLE_ERROR_ADDRESS
	OLE_ERROR_NOT_EQUAL
	OLE_ERROR_HANDLE
	OLE_ERROR_GENERIC
	OLE_ERROR_CLASS
	OLE_ERROR_SYNTAX
	OLE_ERROR_DATATYPE
	OLE_ERROR_PALETTE
	OLE_ERROR_NOT_LINK
	OLE_ERROR_NOT_EMPTY
	OLE_ERROR_SIZE
	OLE_ERROR_DRIVE
	OLE_ERROR_NETWORK
	OLE_ERROR_NAME
	OLE_ERROR_TEMPLATE
	OLE_ERROR_NEW
	OLE_ERROR_EDIT
	OLE_ERROR_OPEN
	OLE_ERROR_NOT_OPEN
	OLE_ERROR_LAUNCH
	OLE_ERROR_COMM
	OLE_ERROR_TERMINATE
	OLE_ERROR_COMMAND
	OLE_ERROR_SHOW
	OLE_ERROR_DOVERB
	OLE_ERROR_ADVISE_NATIVE
	OLE_ERROR_ADVISE_PICT
	OLE_ERROR_ADVISE_RENAME
	OLE_ERROR_POKE_NATIVE
	OLE_ERROR_REQUEST_NATIVE
	OLE_ERROR_REQUEST_PICT
	OLE_ERROR_SERVER_BLOCKED
	OLE_ERROR_REGISTRATION
	OLE_ERROR_ALREADY_REGISTERED
	OLE_ERROR_TASK
	OLE_ERROR_OUTOFDATE
	OLE_ERROR_CANT_UPDATE_CLIENT
	OLE_ERROR_UPDATE
	OLE_ERROR_SETDATA_FORMAT
	OLE_ERROR_STATIC_FROM_OTHER_OS
	OLE_ERROR_FILE_VER
	OLE_WARN_DELETE_DATA = 1000
end enum

enum OLE_NOTIFICATION
	OLE_CHANGED
	OLE_SAVED
	OLE_CLOSED
	OLE_RENAMED
	OLE_QUERY_PAINT
	OLE_RELEASE
	OLE_QUERY_RETRY
end enum

enum OLE_RELEASE_METHOD
	OLE_NONE
	OLE_DELETE
	OLE_LNKPASTE
	OLE_EMBPASTE
	OLE_SHOW
	OLE_RUN
	OLE_ACTIVATE
	OLE_UPDATE
	OLE_CLOSE
	OLE_RECONNECT
	OLE_SETUPDATEOPTIONS
	OLE_SERVERUNLAUNCH
	OLE_LOADFROMSTREAM
	OLE_SETDATA
	OLE_REQUESTDATA
	OLE_OTHER
	OLE_CREATE
	OLE_CREATEFROMTEMPLATE
	OLE_CREATELINKFROMFILE
	OLE_COPYFROMLNK
	OLE_CREATEFROMFILE
	OLE_CREATEINVISIBLE
end enum

enum OLEOPT_RENDER
	olerender_none
	olerender_draw
	olerender_format
end enum

type OLECLIPFORMAT as WORD

enum OLEOPT_UPDATE
	oleupdate_always
	oleupdate_onsave
	oleupdate_oncall
end enum

#ifndef HOBJECT
type HOBJECT as HANDLE
#endif
type LHSERVER as LONG
type LHCLIENTDOC as LONG
type LHSERVERDOC as LONG
type LPOLEOBJECT as OLEOBJECT ptr
type LPOLESTREAM as OLESTREAM ptr
type LPOLECLIENT as OLECLIENT ptr

type OLEOBJECTVTBL
	QueryProtocol as sub (byval as LPOLEOBJECT, byval as LPCSTR)
	Release as function (byval as LPOLEOBJECT) as OLESTATUS
	Show as function (byval as LPOLEOBJECT, byval as BOOL) as OLESTATUS
	DoVerb as function (byval as LPOLEOBJECT, byval as UINT, byval as BOOL, byval as BOOL) as OLESTATUS
	GetData as function (byval as LPOLEOBJECT, byval as OLECLIPFORMAT, byval as HANDLE ptr) as OLESTATUS
	SetData as function (byval as LPOLEOBJECT, byval as OLECLIPFORMAT, byval as HANDLE) as OLESTATUS
	SetTargetDevice as function (byval as LPOLEOBJECT, byval as HANDLE) as OLESTATUS
	SetBounds as function (byval as LPOLEOBJECT, byval as RECT ptr) as OLESTATUS
	EnumFormats as function (byval as LPOLEOBJECT, byval as OLECLIPFORMAT) as OLECLIPFORMAT
	SetColorScheme as function (byval as LPOLEOBJECT, byval as LOGPALETTE ptr) as OLESTATUS
	Delete__ as function (byval as LPOLEOBJECT) as OLESTATUS
	SetHostNames as function (byval as LPOLEOBJECT, byval as LPCSTR, byval as LPCSTR) as OLESTATUS
	SaveToStream as function (byval as LPOLEOBJECT, byval as LPOLESTREAM) as OLESTATUS
	Clone as function (byval as LPOLEOBJECT, byval as LPOLECLIENT, byval as LHCLIENTDOC, byval as LPCSTR, byval as LPOLEOBJECT ptr) as OLESTATUS
	CopyFromLink as function (byval as LPOLEOBJECT, byval as LPOLECLIENT, byval as LHCLIENTDOC, byval as LPCSTR, byval as LPOLEOBJECT ptr) as OLESTATUS
	Equal as function (byval as LPOLEOBJECT, byval as LPOLEOBJECT) as OLESTATUS
	CopyToClipboard as function (byval as LPOLEOBJECT) as OLESTATUS
	Draw as function (byval as LPOLEOBJECT, byval as HDC, byval as RECT ptr, byval as RECT ptr, byval as HDC) as OLESTATUS
	Activate as function (byval as LPOLEOBJECT, byval as UINT, byval as BOOL, byval as BOOL, byval as HWND, byval as RECT ptr) as OLESTATUS
	Execute as function (byval as LPOLEOBJECT, byval as HANDLE, byval as UINT) as OLESTATUS
	Close as function (byval as LPOLEOBJECT) as OLESTATUS
	Update as function (byval as LPOLEOBJECT) as OLESTATUS
	Reconnect as function (byval as LPOLEOBJECT) as OLESTATUS
	ObjectConvert as function (byval as LPOLEOBJECT, byval as LPCSTR, byval as LPOLECLIENT, byval as LHCLIENTDOC, byval as LPCSTR, byval as LPOLEOBJECT ptr) as OLESTATUS
	GetLinkUpdateOptions as function (byval as LPOLEOBJECT, byval as OLEOPT_UPDATE ptr) as OLESTATUS
	SetLinkUpdateOptions as function (byval as LPOLEOBJECT, byval as OLEOPT_UPDATE) as OLESTATUS
	Rename as function (byval as LPOLEOBJECT, byval as LPCSTR) as OLESTATUS
	QueryName as function (byval as LPOLEOBJECT, byval as LPSTR, byval as UINT ptr) as OLESTATUS
	QueryType as function (byval as LPOLEOBJECT, byval as LONG ptr) as OLESTATUS
	QueryBounds as function (byval as LPOLEOBJECT, byval as RECT ptr) as OLESTATUS
	QuerySize as function (byval as LPOLEOBJECT, byval as DWORD ptr) as OLESTATUS
	QueryOpen as function (byval as LPOLEOBJECT) as OLESTATUS
	QueryOutOfDate as function (byval as LPOLEOBJECT) as OLESTATUS
	QueryReleaseStatus as function (byval as LPOLEOBJECT) as OLESTATUS
	QueryReleaseError as function (byval as LPOLEOBJECT) as OLESTATUS
	QueryReleaseMethod as function (byval as LPOLEOBJECT) as OLE_RELEASE_METHOD
	RequestData as function (byval as LPOLEOBJECT, byval as OLECLIPFORMAT) as OLESTATUS
	ObjectLong as function (byval as LPOLEOBJECT, byval as UINT, byval as LONG ptr) as OLESTATUS
	ChangeData as function (byval as LPOLEOBJECT, byval as HANDLE, byval as LPOLECLIENT, byval as BOOL) as OLESTATUS
end type

type LPOLEOBJECTVTBL as OLEOBJECTVTBL ptr

type OLEOBJECT
	lpvtbl as LPOLEOBJECTVTBL
end type

type OLECLIENTVTBL
	CallBack as function (byval as LPOLECLIENT, byval as OLE_NOTIFICATION, byval as LPOLEOBJECT) as integer
end type

type LPOLECLIENTVTBL as OLECLIENTVTBL ptr

type OLECLIENT
	lpvtbl as LPOLECLIENTVTBL
end type

type OLESTREAMVTBL
	Get as function (byval as LPOLESTREAM, byval as any ptr, byval as DWORD) as DWORD
	Put as function (byval as LPOLESTREAM, byval as any ptr, byval as DWORD) as DWORD
end type

type LPOLESTREAMVTBL as OLESTREAMVTBL ptr

type OLESTREAM
	lpstbl as LPOLESTREAMVTBL
end type

enum OLE_SERVER_USE
	OLE_SERVER_MULTI
	OLE_SERVER_SINGLE
end enum

type LPOLESERVER as OLESERVER ptr
type LPOLESERVERDOC as OLESERVERDOC ptr

type OLESERVERVTBL
	Open as function (byval as LPOLESERVER, byval as LHSERVERDOC, byval as LPCSTR, byval as LPOLESERVERDOC ptr) as OLESTATUS
	Create as function (byval as LPOLESERVER, byval as LHSERVERDOC, byval as LPCSTR, byval as LPCSTR, byval as LPOLESERVERDOC ptr) as OLESTATUS
	CreateFromTemplate as function (byval as LPOLESERVER, byval as LHSERVERDOC, byval as LPCSTR, byval as LPCSTR, byval as LPCSTR, byval as LPOLESERVERDOC ptr) as OLESTATUS
	Edit as function (byval as LPOLESERVER, byval as LHSERVERDOC, byval as LPCSTR, byval as LPCSTR, byval as LPOLESERVERDOC ptr) as OLESTATUS
	Exit as function (byval as LPOLESERVER) as OLESTATUS
	Release as function (byval as LPOLESERVER) as OLESTATUS
	Execute as function (byval as LPOLESERVER, byval as HANDLE) as OLESTATUS
end type

type LPOLESERVERVTBL as OLESERVERVTBL ptr

type OLESERVER
	lpvtbl as LPOLESERVERVTBL
end type

type OLESERVERDOCVTBL
	Save as function (byval as LPOLESERVERDOC) as OLESTATUS
	Close as function (byval as LPOLESERVERDOC) as OLESTATUS
	SetHostNames as function (byval as LPOLESERVERDOC, byval as LPCSTR, byval as LPCSTR) as OLESTATUS
	SetDocDimensions as function (byval as LPOLESERVERDOC, byval as RECT ptr) as OLESTATUS
	GetObjectA as function (byval as LPOLESERVERDOC, byval as LPCSTR, byval as LPOLEOBJECT ptr, byval as LPOLECLIENT) as OLESTATUS
	Release as function (byval as LPOLESERVERDOC) as OLESTATUS
	SetColorScheme as function (byval as LPOLESERVERDOC, byval as LOGPALETTE ptr) as OLESTATUS
	Execute as function (byval as LPOLESERVERDOC, byval as HANDLE) as OLESTATUS
end type

type LPOLESERVERDOCVTBL as OLESERVERDOCVTBL ptr

type OLESERVERDOC
	lpvtbl as LPOLESERVERDOCVTBL
end type

declare function OleDelete alias "OleDelete" (byval as LPOLEOBJECT) as OLESTATUS
declare function OleRelease alias "OleRelease" (byval as LPOLEOBJECT) as OLESTATUS
declare function OleSaveToStream alias "OleSaveToStream" (byval as LPOLEOBJECT, byval as LPOLESTREAM) as OLESTATUS
declare function OleEqual alias "OleEqual" (byval as LPOLEOBJECT, byval as LPOLEOBJECT) as OLESTATUS
declare function OleCopyToClipboard alias "OleCopyToClipboard" (byval as LPOLEOBJECT) as OLESTATUS
declare function OleSetHostNames alias "OleSetHostNames" (byval as LPOLEOBJECT, byval as LPCSTR, byval as LPCSTR) as OLESTATUS
declare function OleSetTargetDevice alias "OleSetTargetDevice" (byval as LPOLEOBJECT, byval as HANDLE) as OLESTATUS
declare function OleSetBounds alias "OleSetBounds" (byval as LPOLEOBJECT, byval as LPCRECT) as OLESTATUS
declare function OleSetColorScheme alias "OleSetColorScheme" (byval as LPOLEOBJECT, byval as LOGPALETTE ptr) as OLESTATUS
declare function OleQueryBounds alias "OleQueryBounds" (byval as LPOLEOBJECT, byval as RECT ptr) as OLESTATUS
declare function OleQuerySize alias "OleQuerySize" (byval as LPOLEOBJECT, byval as DWORD ptr) as OLESTATUS
declare function OleDraw alias "OleDraw" (byval as LPOLEOBJECT, byval as HDC, byval as LPCRECT, byval as LPCRECT, byval as HDC) as OLESTATUS
declare function OleQueryOpen alias "OleQueryOpen" (byval as LPOLEOBJECT) as OLESTATUS
declare function OleActivate alias "OleActivate" (byval as LPOLEOBJECT, byval as UINT, byval as BOOL, byval as BOOL, byval as HWND, byval as LPCRECT) as OLESTATUS
declare function OleExecute alias "OleExecute" (byval as LPOLEOBJECT, byval as HANDLE, byval as UINT) as OLESTATUS
declare function OleClose alias "OleClose" (byval as LPOLEOBJECT) as OLESTATUS
declare function OleUpdate alias "OleUpdate" (byval as LPOLEOBJECT) as OLESTATUS
declare function OleReconnect alias "OleReconnect" (byval as LPOLEOBJECT) as OLESTATUS
declare function OleGetLinkUpdateOptions alias "OleGetLinkUpdateOptions" (byval as LPOLEOBJECT, byval as OLEOPT_UPDATE ptr) as OLESTATUS
declare function OleSetLinkUpdateOptions alias "OleSetLinkUpdateOptions" (byval as LPOLEOBJECT, byval as OLEOPT_UPDATE) as OLESTATUS
declare function OleQueryProtocol alias "OleQueryProtocol" (byval as LPOLEOBJECT, byval as LPCSTR) as any ptr
declare function OleQueryReleaseStatus alias "OleQueryReleaseStatus" (byval as LPOLEOBJECT) as OLESTATUS
declare function OleQueryReleaseError alias "OleQueryReleaseError" (byval as LPOLEOBJECT) as OLESTATUS
declare function OleQueryReleaseMethod alias "OleQueryReleaseMethod" (byval as LPOLEOBJECT) as OLE_RELEASE_METHOD
declare function OleQueryType alias "OleQueryType" (byval as LPOLEOBJECT, byval as LONG ptr) as OLESTATUS
declare function OleQueryClientVersion alias "OleQueryClientVersion" () as DWORD
declare function OleQueryServerVersion alias "OleQueryServerVersion" () as DWORD
declare function OleEnumFormats alias "OleEnumFormats" (byval as LPOLEOBJECT, byval as OLECLIPFORMAT) as OLECLIPFORMAT
declare function OleGetData alias "OleGetData" (byval as LPOLEOBJECT, byval as OLECLIPFORMAT, byval as HANDLE ptr) as OLESTATUS
declare function OleSetData alias "OleSetData" (byval as LPOLEOBJECT, byval as OLECLIPFORMAT, byval as HANDLE) as OLESTATUS
declare function OleQueryOutOfDate alias "OleQueryOutOfDate" (byval as LPOLEOBJECT) as OLESTATUS
declare function OleRequestData alias "OleRequestData" (byval as LPOLEOBJECT, byval as OLECLIPFORMAT) as OLESTATUS
declare function OleQueryLinkFromClip alias "OleQueryLinkFromClip" (byval as LPCSTR, byval as OLEOPT_RENDER, byval as OLECLIPFORMAT) as OLESTATUS
declare function OleQueryCreateFromClip alias "OleQueryCreateFromClip" (byval as LPCSTR, byval as OLEOPT_RENDER, byval as OLECLIPFORMAT) as OLESTATUS
declare function OleCreateFromClip alias "OleCreateFromClip" (byval as LPCSTR, byval as LPOLECLIENT, byval as LHCLIENTDOC, byval as LPCSTR, byval as LPOLEOBJECT ptr, byval as OLEOPT_RENDER, byval as OLECLIPFORMAT) as OLESTATUS
declare function OleCreateLinkFromClip alias "OleCreateLinkFromClip" (byval as LPCSTR, byval as LPOLECLIENT, byval as LHCLIENTDOC, byval as LPCSTR, byval as LPOLEOBJECT ptr, byval as OLEOPT_RENDER, byval as OLECLIPFORMAT) as OLESTATUS
declare function OleCreateFromFile alias "OleCreateFromFile" (byval as LPCSTR, byval as LPOLECLIENT, byval as LPCSTR, byval as LPCSTR, byval as LHCLIENTDOC, byval as LPCSTR, byval as LPOLEOBJECT ptr, byval as OLEOPT_RENDER, byval as OLECLIPFORMAT) as OLESTATUS
declare function OleCreateLinkFromFile alias "OleCreateLinkFromFile" (byval as LPCSTR, byval as LPOLECLIENT, byval as LPCSTR, byval as LPCSTR, byval as LPCSTR, byval as LHCLIENTDOC, byval as LPCSTR, byval as LPOLEOBJECT ptr, byval as OLEOPT_RENDER, byval as OLECLIPFORMAT) as OLESTATUS
declare function OleLoadFromStream alias "OleLoadFromStream" (byval as LPOLESTREAM, byval as LPCSTR, byval as LPOLECLIENT, byval as LHCLIENTDOC, byval as LPCSTR, byval as LPOLEOBJECT ptr) as OLESTATUS
declare function OleCreate alias "OleCreate" (byval as LPCSTR, byval as LPOLECLIENT, byval as LPCSTR, byval as LHCLIENTDOC, byval as LPCSTR, byval as LPOLEOBJECT ptr, byval as OLEOPT_RENDER, byval as OLECLIPFORMAT) as OLESTATUS
declare function OleCreateInvisible alias "OleCreateInvisible" (byval as LPCSTR, byval as LPOLECLIENT, byval as LPCSTR, byval as LHCLIENTDOC, byval as LPCSTR, byval as LPOLEOBJECT ptr, byval as OLEOPT_RENDER, byval as OLECLIPFORMAT, byval as BOOL) as OLESTATUS
declare function OleCreateFromTemplate alias "OleCreateFromTemplate" (byval as LPCSTR, byval as LPOLECLIENT, byval as LPCSTR, byval as LHCLIENTDOC, byval as LPCSTR, byval as LPOLEOBJECT ptr, byval as OLEOPT_RENDER, byval as OLECLIPFORMAT) as OLESTATUS
declare function OleClone alias "OleClone" (byval as LPOLEOBJECT, byval as LPOLECLIENT, byval as LHCLIENTDOC, byval as LPCSTR, byval as LPOLEOBJECT ptr) as OLESTATUS
declare function OleCopyFromLink alias "OleCopyFromLink" (byval as LPOLEOBJECT, byval as LPCSTR, byval as LPOLECLIENT, byval as LHCLIENTDOC, byval as LPCSTR, byval as LPOLEOBJECT ptr) as OLESTATUS
declare function OleObjectConvert alias "OleObjectConvert" (byval as LPOLEOBJECT, byval as LPCSTR, byval as LPOLECLIENT, byval as LHCLIENTDOC, byval as LPCSTR, byval as LPOLEOBJECT ptr) as OLESTATUS
declare function OleRename alias "OleRename" (byval as LPOLEOBJECT, byval as LPCSTR) as OLESTATUS
declare function OleQueryName alias "OleQueryName" (byval as LPOLEOBJECT, byval as LPSTR, byval as UINT ptr) as OLESTATUS
declare function OleRevokeObject alias "OleRevokeObject" (byval as LPOLECLIENT) as OLESTATUS
declare function OleIsDcMeta alias "OleIsDcMeta" (byval as HDC) as BOOL
declare function OleRegisterClientDoc alias "OleRegisterClientDoc" (byval as LPCSTR, byval as LPCSTR, byval as LONG, byval as LHCLIENTDOC ptr) as OLESTATUS
declare function OleRevokeClientDoc alias "OleRevokeClientDoc" (byval as LHCLIENTDOC) as OLESTATUS
declare function OleRenameClientDoc alias "OleRenameClientDoc" (byval as LHCLIENTDOC, byval as LPCSTR) as OLESTATUS
declare function OleRevertClientDoc alias "OleRevertClientDoc" (byval as LHCLIENTDOC) as OLESTATUS
declare function OleSavedClientDoc alias "OleSavedClientDoc" (byval as LHCLIENTDOC) as OLESTATUS
declare function OleEnumObjects alias "OleEnumObjects" (byval as LHCLIENTDOC, byval as LPOLEOBJECT ptr) as OLESTATUS
declare function OleRegisterServer alias "OleRegisterServer" (byval as LPCSTR, byval as LPOLESERVER, byval as LHSERVER ptr, byval as HINSTANCE, byval as OLE_SERVER_USE) as OLESTATUS
declare function OleRevokeServer alias "OleRevokeServer" (byval as LHSERVER) as OLESTATUS
declare function OleBlockServer alias "OleBlockServer" (byval as LHSERVER) as OLESTATUS
declare function OleUnblockServer alias "OleUnblockServer" (byval as LHSERVER, byval as BOOL ptr) as OLESTATUS
declare function OleLockServer alias "OleLockServer" (byval as LPOLEOBJECT, byval as LHSERVER ptr) as OLESTATUS
declare function OleUnlockServer alias "OleUnlockServer" (byval as LHSERVER) as OLESTATUS
declare function OleRegisterServerDoc alias "OleRegisterServerDoc" (byval as LHSERVER, byval as LPCSTR, byval as LPOLESERVERDOC, byval as LHSERVERDOC ptr) as OLESTATUS
declare function OleRevokeServerDoc alias "OleRevokeServerDoc" (byval as LHSERVERDOC) as OLESTATUS
declare function OleRenameServerDoc alias "OleRenameServerDoc" (byval as LHSERVERDOC, byval as LPCSTR) as OLESTATUS
declare function OleRevertServerDoc alias "OleRevertServerDoc" (byval as LHSERVERDOC) as OLESTATUS
declare function OleSavedServerDoc alias "OleSavedServerDoc" (byval as LHSERVERDOC) as OLESTATUS

#endif
