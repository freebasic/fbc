'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   DISCLAIMER
''   This file has no copyright assigned and is placed in the Public Domain.
''   This file is part of the mingw-w64 runtime package.
''
''   The mingw-w64 runtime package and its code is distributed in the hope that it 
''   will be useful but WITHOUT ANY WARRANTY.  ALL WARRANTIES, EXPRESSED OR 
''   IMPLIED ARE HEREBY DISCLAIMED.  This includes but is not limited to 
''   warranties of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "mapi32"

extern "Windows"

#define MAPI_H
type LPULONG as ulong ptr
type FLAGS as ulong
#define __LHANDLE
type LHANDLE as ULONG_PTR
type LPLHANDLE as ULONG_PTR ptr
type LPBYTE as ubyte ptr
const lhSessionNull = cast(LHANDLE, 0)

type MapiFileDesc
	ulReserved as ULONG
	flFlags as ULONG
	nPosition as ULONG
	lpszPathName as LPSTR
	lpszFileName as LPSTR
	lpFileType as LPVOID
end type

type lpMapiFileDesc as MapiFileDesc ptr
const MAPI_OLE = &h00000001
const MAPI_OLE_STATIC = &h00000002

type MapiFileTagExt
	ulReserved as ULONG
	cbTag as ULONG
	lpTag as LPBYTE
	cbEncoding as ULONG
	lpEncoding as LPBYTE
end type

type lpMapiFileTagExt as MapiFileTagExt ptr

type MapiRecipDesc
	ulReserved as ULONG
	ulRecipClass as ULONG
	lpszName as LPSTR
	lpszAddress as LPSTR
	ulEIDSize as ULONG
	lpEntryID as LPVOID
end type

type lpMapiRecipDesc as MapiRecipDesc ptr
const MAPI_ORIG = 0
const MAPI_TO = 1
const MAPI_CC = 2
const MAPI_BCC = 3

type MapiMessage
	ulReserved as ULONG
	lpszSubject as LPSTR
	lpszNoteText as LPSTR
	lpszMessageType as LPSTR
	lpszDateReceived as LPSTR
	lpszConversationID as LPSTR
	flFlags as FLAGS
	lpOriginator as lpMapiRecipDesc
	nRecipCount as ULONG
	lpRecips as lpMapiRecipDesc
	nFileCount as ULONG
	lpFiles as lpMapiFileDesc
end type

type lpMapiMessage as MapiMessage ptr
const MAPI_UNREAD = &h00000001
const MAPI_RECEIPT_REQUESTED = &h00000002
const MAPI_SENT = &h00000004
const MAPI_LOGON_UI = &h00000001
const MAPI_PASSWORD_UI = &h00020000
const MAPI_NEW_SESSION = &h00000002
const MAPI_FORCE_DOWNLOAD = &h00001000
const MAPI_EXTENDED = &h00000020
const MAPI_DIALOG = &h00000008
const MAPI_UNREAD_ONLY = &h00000020
const MAPI_GUARANTEE_FIFO = &h00000100
const MAPI_LONG_MSGID = &h00004000
const MAPI_PEEK = &h00000080
const MAPI_SUPPRESS_ATTACH = &h00000800
const MAPI_ENVELOPE_ONLY = &h00000040
const MAPI_BODY_AS_FILE = &h00000200
const MAPI_AB_NOMODIFY = &h00000400
type LPMAPILOGON as function(byval ulUIParam as ULONG_PTR, byval lpszProfileName as LPSTR, byval lpszPassword as LPSTR, byval flFlags as FLAGS, byval ulReserved as ULONG, byval lplhSession as LPLHANDLE) as ULONG
declare function MAPILogon(byval ulUIParam as ULONG_PTR, byval lpszProfileName as LPSTR, byval lpszPassword as LPSTR, byval flFlags as FLAGS, byval ulReserved as ULONG, byval lplhSession as LPLHANDLE) as ULONG
type LPMAPILOGOFF as function(byval lhSession as LHANDLE, byval ulUIParam as ULONG_PTR, byval flFlags as FLAGS, byval ulReserved as ULONG) as ULONG
declare function MAPILogoff(byval lhSession as LHANDLE, byval ulUIParam as ULONG_PTR, byval flFlags as FLAGS, byval ulReserved as ULONG) as ULONG
type LPMAPISENDMAIL as function(byval lhSession as LHANDLE, byval ulUIParam as ULONG_PTR, byval lpMessage as lpMapiMessage, byval flFlags as FLAGS, byval ulReserved as ULONG) as ULONG
declare function MAPISendMail(byval lhSession as LHANDLE, byval ulUIParam as ULONG_PTR, byval lpMessage as lpMapiMessage, byval flFlags as FLAGS, byval ulReserved as ULONG) as ULONG
type LPMAPISENDDOCUMENTS as function(byval ulUIParam as ULONG_PTR, byval lpszDelimChar as LPSTR, byval lpszFilePaths as LPSTR, byval lpszFileNames as LPSTR, byval ulReserved as ULONG) as ULONG
declare function MAPISendDocuments(byval ulUIParam as ULONG_PTR, byval lpszDelimChar as LPSTR, byval lpszFilePaths as LPSTR, byval lpszFileNames as LPSTR, byval ulReserved as ULONG) as ULONG
type LPMAPIFINDNEXT as function(byval lhSession as LHANDLE, byval ulUIParam as ULONG_PTR, byval lpszMessageType as LPSTR, byval lpszSeedMessageID as LPSTR, byval flFlags as FLAGS, byval ulReserved as ULONG, byval lpszMessageID as LPSTR) as ULONG
declare function MAPIFindNext(byval lhSession as LHANDLE, byval ulUIParam as ULONG_PTR, byval lpszMessageType as LPSTR, byval lpszSeedMessageID as LPSTR, byval flFlags as FLAGS, byval ulReserved as ULONG, byval lpszMessageID as LPSTR) as ULONG
type LPMAPIREADMAIL as function(byval lhSession as LHANDLE, byval ulUIParam as ULONG_PTR, byval lpszMessageID as LPSTR, byval flFlags as FLAGS, byval ulReserved as ULONG, byval lppMessage as lpMapiMessage ptr) as ULONG
declare function MAPIReadMail(byval lhSession as LHANDLE, byval ulUIParam as ULONG_PTR, byval lpszMessageID as LPSTR, byval flFlags as FLAGS, byval ulReserved as ULONG, byval lppMessage as lpMapiMessage ptr) as ULONG
type LPMAPISAVEMAIL as function(byval lhSession as LHANDLE, byval ulUIParam as ULONG_PTR, byval lpMessage as lpMapiMessage, byval flFlags as FLAGS, byval ulReserved as ULONG, byval lpszMessageID as LPSTR) as ULONG
declare function MAPISaveMail(byval lhSession as LHANDLE, byval ulUIParam as ULONG_PTR, byval lpMessage as lpMapiMessage, byval flFlags as FLAGS, byval ulReserved as ULONG, byval lpszMessageID as LPSTR) as ULONG
type LPMAPIDELETEMAIL as function(byval lhSession as LHANDLE, byval ulUIParam as ULONG_PTR, byval lpszMessageID as LPSTR, byval flFlags as FLAGS, byval ulReserved as ULONG) as ULONG
declare function MAPIDeleteMail(byval lhSession as LHANDLE, byval ulUIParam as ULONG_PTR, byval lpszMessageID as LPSTR, byval flFlags as FLAGS, byval ulReserved as ULONG) as ULONG
type LPMAPIFREEBUFFER as function(byval pv as LPVOID) as ULONG
declare function MAPIFreeBuffer(byval pv as LPVOID) as ULONG
type LPMAPIADDRESS as function(byval lhSession as LHANDLE, byval ulUIParam as ULONG_PTR, byval lpszCaption as LPSTR, byval nEditFields as ULONG, byval lpszLabels as LPSTR, byval nRecips as ULONG, byval lpRecips as lpMapiRecipDesc, byval flFlags as FLAGS, byval ulReserved as ULONG, byval lpnNewRecips as LPULONG, byval lppNewRecips as lpMapiRecipDesc ptr) as ULONG
declare function MAPIAddress(byval lhSession as LHANDLE, byval ulUIParam as ULONG_PTR, byval lpszCaption as LPSTR, byval nEditFields as ULONG, byval lpszLabels as LPSTR, byval nRecips as ULONG, byval lpRecips as lpMapiRecipDesc, byval flFlags as FLAGS, byval ulReserved as ULONG, byval lpnNewRecips as LPULONG, byval lppNewRecips as lpMapiRecipDesc ptr) as ULONG
type LPMAPIDETAILS as function(byval lhSession as LHANDLE, byval ulUIParam as ULONG_PTR, byval lpRecip as lpMapiRecipDesc, byval flFlags as FLAGS, byval ulReserved as ULONG) as ULONG
declare function MAPIDetails(byval lhSession as LHANDLE, byval ulUIParam as ULONG_PTR, byval lpRecip as lpMapiRecipDesc, byval flFlags as FLAGS, byval ulReserved as ULONG) as ULONG
type LPMAPIRESOLVENAME as function(byval lhSession as LHANDLE, byval ulUIParam as ULONG_PTR, byval lpszName as LPSTR, byval flFlags as FLAGS, byval ulReserved as ULONG, byval lppRecip as lpMapiRecipDesc ptr) as ULONG
declare function MAPIResolveName(byval lhSession as LHANDLE, byval ulUIParam as ULONG_PTR, byval lpszName as LPSTR, byval flFlags as FLAGS, byval ulReserved as ULONG, byval lppRecip as lpMapiRecipDesc ptr) as ULONG
const SUCCESS_SUCCESS = 0
const MAPI_USER_ABORT = 1
const MAPI_E_USER_ABORT = MAPI_USER_ABORT
const MAPI_E_FAILURE = 2
const MAPI_E_LOGON_FAILURE = 3
const MAPI_E_LOGIN_FAILURE = MAPI_E_LOGON_FAILURE
const MAPI_E_DISK_FULL = 4
const MAPI_E_INSUFFICIENT_MEMORY = 5
const MAPI_E_ACCESS_DENIED = 6
const MAPI_E_TOO_MANY_SESSIONS = 8
const MAPI_E_TOO_MANY_FILES = 9
const MAPI_E_TOO_MANY_RECIPIENTS = 10
const MAPI_E_ATTACHMENT_NOT_FOUND = 11
const MAPI_E_ATTACHMENT_OPEN_FAILURE = 12
const MAPI_E_ATTACHMENT_WRITE_FAILURE = 13
const MAPI_E_UNKNOWN_RECIPIENT = 14
const MAPI_E_BAD_RECIPTYPE = 15
const MAPI_E_NO_MESSAGES = 16
const MAPI_E_INVALID_MESSAGE = 17
const MAPI_E_TEXT_TOO_LARGE = 18
const MAPI_E_INVALID_SESSION = 19
const MAPI_E_TYPE_NOT_SUPPORTED = 20
const MAPI_E_AMBIGUOUS_RECIPIENT = 21
const MAPI_E_AMBIG_RECIP = MAPI_E_AMBIGUOUS_RECIPIENT
const MAPI_E_MESSAGE_IN_USE = 22
const MAPI_E_NETWORK_FAILURE = 23
const MAPI_E_INVALID_EDITFIELDS = 24
const MAPI_E_INVALID_RECIPS = 25
const MAPI_E_NOT_SUPPORTED = 26

end extern
