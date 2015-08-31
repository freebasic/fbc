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

#inclib "ole32"

#include once "winapifamily.bi"

extern "Windows"

#define _INC_OLE
type OLE_LPCSTR as LPCSTR
const OT_LINK = 1
const OT_EMBEDDED = 2
const OT_STATIC = 3
const OLEVERB_PRIMARY = 0

type _OLETARGETDEVICE
	otdDeviceNameOffset as USHORT
	otdDriverNameOffset as USHORT
	otdPortNameOffset as USHORT
	otdExtDevmodeOffset as USHORT
	otdExtDevmodeSize as USHORT
	otdEnvironmentOffset as USHORT
	otdEnvironmentSize as USHORT
	otdData(0 to 0) as UBYTE
end type

type OLETARGETDEVICE as _OLETARGETDEVICE
type LPOLETARGETDEVICE as OLETARGETDEVICE ptr
const OF_SET = &h1
const OF_GET = &h2
const OF_HANDLER = &h4

type OLESTATUS as long
enum
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

type OLE_NOTIFICATION as long
enum
	OLE_CHANGED
	OLE_SAVED
	OLE_CLOSED
	OLE_RENAMED
	OLE_QUERY_PAINT
	OLE_RELEASE
	OLE_QUERY_RETRY
end enum

type OLE_RELEASE_METHOD as long
enum
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

type OLEOPT_RENDER as long
enum
	olerender_none
	olerender_draw
	olerender_format
end enum

type OLECLIPFORMAT as WORD

type OLEOPT_UPDATE as long
enum
	oleupdate_always
	oleupdate_onsave
	oleupdate_oncall
end enum

type HOBJECT as HANDLE
type LHSERVER as LONG_PTR
type LHCLIENTDOC as LONG_PTR
type LHSERVERDOC as LONG_PTR
type LPOLEOBJECT as _OLEOBJECT ptr
type LPOLESTREAM as _OLESTREAM ptr
type LPOLECLIENT as _OLECLIENT ptr

type _OLEOBJECTVTBL
	QueryProtocol as function(byval as LPOLEOBJECT, byval as LPCSTR) as any ptr
	Release as function(byval as LPOLEOBJECT) as OLESTATUS
	Show as function(byval as LPOLEOBJECT, byval as WINBOOL) as OLESTATUS
	DoVerb as function(byval as LPOLEOBJECT, byval as UINT, byval as WINBOOL, byval as WINBOOL) as OLESTATUS
	GetData as function(byval as LPOLEOBJECT, byval as OLECLIPFORMAT, byval as HANDLE ptr) as OLESTATUS
	SetData as function(byval as LPOLEOBJECT, byval as OLECLIPFORMAT, byval as HANDLE) as OLESTATUS
	SetTargetDevice as function(byval as LPOLEOBJECT, byval as HANDLE) as OLESTATUS
	SetBounds as function(byval as LPOLEOBJECT, byval as const RECT ptr) as OLESTATUS
	EnumFormats as function(byval as LPOLEOBJECT, byval as OLECLIPFORMAT) as OLECLIPFORMAT
	SetColorScheme as function(byval as LPOLEOBJECT, byval as const LOGPALETTE ptr) as OLESTATUS
	Delete_ as function(byval as LPOLEOBJECT) as OLESTATUS
	SetHostNames as function(byval as LPOLEOBJECT, byval as LPCSTR, byval as LPCSTR) as OLESTATUS
	SaveToStream as function(byval as LPOLEOBJECT, byval as LPOLESTREAM) as OLESTATUS
	Clone as function(byval as LPOLEOBJECT, byval as LPOLECLIENT, byval as LHCLIENTDOC, byval as LPCSTR, byval as LPOLEOBJECT ptr) as OLESTATUS
	CopyFromLink as function(byval as LPOLEOBJECT, byval as LPOLECLIENT, byval as LHCLIENTDOC, byval as LPCSTR, byval as LPOLEOBJECT ptr) as OLESTATUS
	Equal as function(byval as LPOLEOBJECT, byval as LPOLEOBJECT) as OLESTATUS
	CopyToClipboard as function(byval as LPOLEOBJECT) as OLESTATUS
	Draw as function(byval as LPOLEOBJECT, byval as HDC, byval as const RECT ptr, byval as const RECT ptr, byval as HDC) as OLESTATUS
	Activate as function(byval as LPOLEOBJECT, byval as UINT, byval as WINBOOL, byval as WINBOOL, byval as HWND, byval as const RECT ptr) as OLESTATUS
	Execute as function(byval as LPOLEOBJECT, byval as HANDLE, byval as UINT) as OLESTATUS
	Close as function(byval as LPOLEOBJECT) as OLESTATUS
	Update as function(byval as LPOLEOBJECT) as OLESTATUS
	Reconnect as function(byval as LPOLEOBJECT) as OLESTATUS
	ObjectConvert as function(byval as LPOLEOBJECT, byval as LPCSTR, byval as LPOLECLIENT, byval as LHCLIENTDOC, byval as LPCSTR, byval as LPOLEOBJECT ptr) as OLESTATUS
	GetLinkUpdateOptions as function(byval as LPOLEOBJECT, byval as OLEOPT_UPDATE ptr) as OLESTATUS
	SetLinkUpdateOptions as function(byval as LPOLEOBJECT, byval as OLEOPT_UPDATE) as OLESTATUS
	Rename as function(byval as LPOLEOBJECT, byval as LPCSTR) as OLESTATUS
	QueryName as function(byval as LPOLEOBJECT, byval as LPSTR, byval as UINT ptr) as OLESTATUS
	QueryType as function(byval as LPOLEOBJECT, byval as LONG ptr) as OLESTATUS
	QueryBounds as function(byval as LPOLEOBJECT, byval as RECT ptr) as OLESTATUS
	QuerySize as function(byval as LPOLEOBJECT, byval as DWORD ptr) as OLESTATUS
	QueryOpen as function(byval as LPOLEOBJECT) as OLESTATUS
	QueryOutOfDate as function(byval as LPOLEOBJECT) as OLESTATUS
	QueryReleaseStatus as function(byval as LPOLEOBJECT) as OLESTATUS
	QueryReleaseError as function(byval as LPOLEOBJECT) as OLESTATUS
	QueryReleaseMethod as function(byval as LPOLEOBJECT) as OLE_RELEASE_METHOD
	RequestData as function(byval as LPOLEOBJECT, byval as OLECLIPFORMAT) as OLESTATUS
	ObjectLong as function(byval as LPOLEOBJECT, byval as UINT, byval as LONG ptr) as OLESTATUS
	ChangeData as function(byval as LPOLEOBJECT, byval as HANDLE, byval as LPOLECLIENT, byval as WINBOOL) as OLESTATUS
end type

type OLEOBJECTVTBL as _OLEOBJECTVTBL
type LPOLEOBJECTVTBL as OLEOBJECTVTBL ptr

type _OLEOBJECT
	lpvtbl as LPOLEOBJECTVTBL
end type

type OLEOBJECT as _OLEOBJECT

type _OLECLIENTVTBL
	CallBack as function(byval as LPOLECLIENT, byval as OLE_NOTIFICATION, byval as LPOLEOBJECT) as long
end type

type OLECLIENTVTBL as _OLECLIENTVTBL
type LPOLECLIENTVTBL as OLECLIENTVTBL ptr

type _OLECLIENT
	lpvtbl as LPOLECLIENTVTBL
end type

type OLECLIENT as _OLECLIENT

type _OLESTREAMVTBL
	Get as function(byval as LPOLESTREAM, byval as any ptr, byval as DWORD) as DWORD
	Put as function(byval as LPOLESTREAM, byval as const any ptr, byval as DWORD) as DWORD
end type

type OLESTREAMVTBL as _OLESTREAMVTBL
type LPOLESTREAMVTBL as OLESTREAMVTBL ptr

type _OLESTREAM
	lpstbl as LPOLESTREAMVTBL
end type

type OLESTREAM as _OLESTREAM
declare function OleDelete(byval as LPOLEOBJECT) as OLESTATUS
declare function OleRelease(byval as LPOLEOBJECT) as OLESTATUS
declare function OleSaveToStream(byval as LPOLEOBJECT, byval as LPOLESTREAM) as OLESTATUS
declare function OleEqual(byval as LPOLEOBJECT, byval as LPOLEOBJECT) as OLESTATUS
declare function OleCopyToClipboard(byval as LPOLEOBJECT) as OLESTATUS
declare function OleSetHostNames(byval as LPOLEOBJECT, byval as LPCSTR, byval as LPCSTR) as OLESTATUS
declare function OleSetTargetDevice(byval as LPOLEOBJECT, byval as HANDLE) as OLESTATUS
declare function OleSetBounds(byval as LPOLEOBJECT, byval as const RECT ptr) as OLESTATUS
declare function OleSetColorScheme(byval as LPOLEOBJECT, byval as const LOGPALETTE ptr) as OLESTATUS
declare function OleQueryBounds(byval as LPOLEOBJECT, byval as RECT ptr) as OLESTATUS
declare function OleQuerySize(byval as LPOLEOBJECT, byval as DWORD ptr) as OLESTATUS
declare function OleDraw(byval as LPOLEOBJECT, byval as HDC, byval as const RECT ptr, byval as const RECT ptr, byval as HDC) as OLESTATUS
declare function OleQueryOpen(byval as LPOLEOBJECT) as OLESTATUS
declare function OleActivate(byval as LPOLEOBJECT, byval as UINT, byval as WINBOOL, byval as WINBOOL, byval as HWND, byval as const RECT ptr) as OLESTATUS
declare function OleExecute(byval as LPOLEOBJECT, byval as HANDLE, byval as UINT) as OLESTATUS
declare function OleClose(byval as LPOLEOBJECT) as OLESTATUS
declare function OleUpdate(byval as LPOLEOBJECT) as OLESTATUS
declare function OleReconnect(byval as LPOLEOBJECT) as OLESTATUS
declare function OleGetLinkUpdateOptions(byval as LPOLEOBJECT, byval as OLEOPT_UPDATE ptr) as OLESTATUS
declare function OleSetLinkUpdateOptions(byval as LPOLEOBJECT, byval as OLEOPT_UPDATE) as OLESTATUS
declare function OleQueryProtocol(byval as LPOLEOBJECT, byval as LPCSTR) as any ptr
declare function OleQueryReleaseStatus(byval as LPOLEOBJECT) as OLESTATUS
declare function OleQueryReleaseError(byval as LPOLEOBJECT) as OLESTATUS
declare function OleQueryReleaseMethod(byval as LPOLEOBJECT) as OLE_RELEASE_METHOD
declare function OleQueryType(byval as LPOLEOBJECT, byval as LONG ptr) as OLESTATUS
declare function OleQueryClientVersion() as DWORD
declare function OleQueryServerVersion() as DWORD
declare function OleEnumFormats(byval as LPOLEOBJECT, byval as OLECLIPFORMAT) as OLECLIPFORMAT
declare function OleGetData(byval as LPOLEOBJECT, byval as OLECLIPFORMAT, byval as HANDLE ptr) as OLESTATUS
declare function OleSetData(byval as LPOLEOBJECT, byval as OLECLIPFORMAT, byval as HANDLE) as OLESTATUS
declare function OleQueryOutOfDate(byval as LPOLEOBJECT) as OLESTATUS
declare function OleRequestData(byval as LPOLEOBJECT, byval as OLECLIPFORMAT) as OLESTATUS
declare function OleQueryLinkFromClip(byval as LPCSTR, byval as OLEOPT_RENDER, byval as OLECLIPFORMAT) as OLESTATUS
declare function OleQueryCreateFromClip(byval as LPCSTR, byval as OLEOPT_RENDER, byval as OLECLIPFORMAT) as OLESTATUS
declare function OleCreateFromClip(byval as LPCSTR, byval as LPOLECLIENT, byval as LHCLIENTDOC, byval as LPCSTR, byval as LPOLEOBJECT ptr, byval as OLEOPT_RENDER, byval as OLECLIPFORMAT) as OLESTATUS
declare function OleCreateLinkFromClip(byval as LPCSTR, byval as LPOLECLIENT, byval as LHCLIENTDOC, byval as LPCSTR, byval as LPOLEOBJECT ptr, byval as OLEOPT_RENDER, byval as OLECLIPFORMAT) as OLESTATUS
declare function OleCreateFromFile(byval as LPCSTR, byval as LPOLECLIENT, byval as LPCSTR, byval as LPCSTR, byval as LHCLIENTDOC, byval as LPCSTR, byval as LPOLEOBJECT ptr, byval as OLEOPT_RENDER, byval as OLECLIPFORMAT) as OLESTATUS
declare function OleCreateLinkFromFile(byval as LPCSTR, byval as LPOLECLIENT, byval as LPCSTR, byval as LPCSTR, byval as LPCSTR, byval as LHCLIENTDOC, byval as LPCSTR, byval as LPOLEOBJECT ptr, byval as OLEOPT_RENDER, byval as OLECLIPFORMAT) as OLESTATUS
declare function OleLoadFromStream(byval as LPOLESTREAM, byval as LPCSTR, byval as LPOLECLIENT, byval as LHCLIENTDOC, byval as LPCSTR, byval as LPOLEOBJECT ptr) as OLESTATUS
declare function OleCreate(byval as LPCSTR, byval as LPOLECLIENT, byval as LPCSTR, byval as LHCLIENTDOC, byval as LPCSTR, byval as LPOLEOBJECT ptr, byval as OLEOPT_RENDER, byval as OLECLIPFORMAT) as OLESTATUS
declare function OleCreateInvisible(byval as LPCSTR, byval as LPOLECLIENT, byval as LPCSTR, byval as LHCLIENTDOC, byval as LPCSTR, byval as LPOLEOBJECT ptr, byval as OLEOPT_RENDER, byval as OLECLIPFORMAT, byval as WINBOOL) as OLESTATUS
declare function OleCreateFromTemplate(byval as LPCSTR, byval as LPOLECLIENT, byval as LPCSTR, byval as LHCLIENTDOC, byval as LPCSTR, byval as LPOLEOBJECT ptr, byval as OLEOPT_RENDER, byval as OLECLIPFORMAT) as OLESTATUS
declare function OleClone(byval as LPOLEOBJECT, byval as LPOLECLIENT, byval as LHCLIENTDOC, byval as LPCSTR, byval as LPOLEOBJECT ptr) as OLESTATUS
declare function OleCopyFromLink(byval as LPOLEOBJECT, byval as LPCSTR, byval as LPOLECLIENT, byval as LHCLIENTDOC, byval as LPCSTR, byval as LPOLEOBJECT ptr) as OLESTATUS
declare function OleObjectConvert(byval as LPOLEOBJECT, byval as LPCSTR, byval as LPOLECLIENT, byval as LHCLIENTDOC, byval as LPCSTR, byval as LPOLEOBJECT ptr) as OLESTATUS
declare function OleRename(byval as LPOLEOBJECT, byval as LPCSTR) as OLESTATUS
declare function OleQueryName(byval lpobj as LPOLEOBJECT, byval lpBuf as LPSTR, byval lpcbBuf as UINT ptr) as OLESTATUS
declare function OleRevokeObject(byval as LPOLECLIENT) as OLESTATUS
declare function OleIsDcMeta(byval as HDC) as WINBOOL
declare function OleRegisterClientDoc(byval as LPCSTR, byval as LPCSTR, byval as LONG, byval as LHCLIENTDOC ptr) as OLESTATUS
declare function OleRevokeClientDoc(byval as LHCLIENTDOC) as OLESTATUS
declare function OleRenameClientDoc(byval as LHCLIENTDOC, byval as LPCSTR) as OLESTATUS
declare function OleRevertClientDoc(byval as LHCLIENTDOC) as OLESTATUS
declare function OleSavedClientDoc(byval as LHCLIENTDOC) as OLESTATUS
declare function OleEnumObjects(byval as LHCLIENTDOC, byval as LPOLEOBJECT ptr) as OLESTATUS

type OLE_SERVER_USE as long
enum
	OLE_SERVER_MULTI
	OLE_SERVER_SINGLE
end enum

type LPOLESERVER as _OLESERVER ptr
type LPOLESERVERDOC as _OLESERVERDOC ptr
declare function OleRegisterServer(byval as LPCSTR, byval as LPOLESERVER, byval as LHSERVER ptr, byval as HINSTANCE, byval as OLE_SERVER_USE) as OLESTATUS
declare function OleRevokeServer(byval as LHSERVER) as OLESTATUS
declare function OleBlockServer(byval as LHSERVER) as OLESTATUS
declare function OleUnblockServer(byval as LHSERVER, byval as WINBOOL ptr) as OLESTATUS
declare function OleLockServer(byval as LPOLEOBJECT, byval as LHSERVER ptr) as OLESTATUS
declare function OleUnlockServer(byval as LHSERVER) as OLESTATUS
declare function OleRegisterServerDoc(byval as LHSERVER, byval as LPCSTR, byval as LPOLESERVERDOC, byval as LHSERVERDOC ptr) as OLESTATUS
declare function OleRevokeServerDoc(byval as LHSERVERDOC) as OLESTATUS
declare function OleRenameServerDoc(byval as LHSERVERDOC, byval as LPCSTR) as OLESTATUS
declare function OleRevertServerDoc(byval as LHSERVERDOC) as OLESTATUS
declare function OleSavedServerDoc(byval as LHSERVERDOC) as OLESTATUS

type _OLESERVERVTBL
	Open as function(byval as LPOLESERVER, byval as LHSERVERDOC, byval as LPCSTR, byval as LPOLESERVERDOC ptr) as OLESTATUS
	Create as function(byval as LPOLESERVER, byval as LHSERVERDOC, byval as LPCSTR, byval as LPCSTR, byval as LPOLESERVERDOC ptr) as OLESTATUS
	CreateFromTemplate as function(byval as LPOLESERVER, byval as LHSERVERDOC, byval as LPCSTR, byval as LPCSTR, byval as LPCSTR, byval as LPOLESERVERDOC ptr) as OLESTATUS
	Edit as function(byval as LPOLESERVER, byval as LHSERVERDOC, byval as LPCSTR, byval as LPCSTR, byval as LPOLESERVERDOC ptr) as OLESTATUS
	Exit as function(byval as LPOLESERVER) as OLESTATUS
	Release as function(byval as LPOLESERVER) as OLESTATUS
	Execute as function(byval as LPOLESERVER, byval as HANDLE) as OLESTATUS
end type

type OLESERVERVTBL as _OLESERVERVTBL
type LPOLESERVERVTBL as OLESERVERVTBL ptr

type _OLESERVER
	lpvtbl as LPOLESERVERVTBL
end type

type OLESERVER as _OLESERVER

type _OLESERVERDOCVTBL
	Save as function(byval as LPOLESERVERDOC) as OLESTATUS
	Close as function(byval as LPOLESERVERDOC) as OLESTATUS
	SetHostNames as function(byval as LPOLESERVERDOC, byval as LPCSTR, byval as LPCSTR) as OLESTATUS
	SetDocDimensions as function(byval as LPOLESERVERDOC, byval as const RECT ptr) as OLESTATUS
	GetObject as function(byval as LPOLESERVERDOC, byval as LPCSTR, byval as LPOLEOBJECT ptr, byval as LPOLECLIENT) as OLESTATUS
	Release as function(byval as LPOLESERVERDOC) as OLESTATUS
	SetColorScheme as function(byval as LPOLESERVERDOC, byval as const LOGPALETTE ptr) as OLESTATUS
	Execute as function(byval as LPOLESERVERDOC, byval as HANDLE) as OLESTATUS
end type

type OLESERVERDOCVTBL as _OLESERVERDOCVTBL
type LPOLESERVERDOCVTBL as OLESERVERDOCVTBL ptr

type _OLESERVERDOC
	lpvtbl as LPOLESERVERDOCVTBL
end type

type OLESERVERDOC as _OLESERVERDOC

end extern
