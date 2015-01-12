#pragma once

#inclib "mapi32"

extern "Windows"

#define MAPI_H

type LPULONG as ulong ptr
type FLAGS as ulong

#define __LHANDLE

type LHANDLE as ULONG_PTR
type LPLHANDLE as ULONG_PTR ptr

#define lhSessionNull cast(LHANDLE, 0)

type MapiFileDesc
	ulReserved as ULONG
	flFlags as ULONG
	nPosition as ULONG
	lpszPathName as LPSTR
	lpszFileName as LPSTR
	lpFileType as LPVOID
end type

type lpMapiFileDesc as MapiFileDesc ptr

#define MAPI_OLE &h00000001
#define MAPI_OLE_STATIC &h00000002

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

#define MAPI_ORIG 0
#define MAPI_TO 1
#define MAPI_CC 2
#define MAPI_BCC 3

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

#define MAPI_UNREAD &h00000001
#define MAPI_RECEIPT_REQUESTED &h00000002
#define MAPI_SENT &h00000004
#define MAPI_LOGON_UI &h00000001
#define MAPI_PASSWORD_UI &h00020000
#define MAPI_NEW_SESSION &h00000002
#define MAPI_FORCE_DOWNLOAD &h00001000
#define MAPI_EXTENDED &h00000020
#define MAPI_DIALOG &h00000008
#define MAPI_UNREAD_ONLY &h00000020
#define MAPI_GUARANTEE_FIFO &h00000100
#define MAPI_LONG_MSGID &h00004000
#define MAPI_PEEK &h00000080
#define MAPI_SUPPRESS_ATTACH &h00000800
#define MAPI_ENVELOPE_ONLY &h00000040
#define MAPI_BODY_AS_FILE &h00000200
#define MAPI_AB_NOMODIFY &h00000400

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

#define SUCCESS_SUCCESS 0
#define MAPI_USER_ABORT 1
#define MAPI_E_USER_ABORT MAPI_USER_ABORT
#define MAPI_E_FAILURE 2
#define MAPI_E_LOGON_FAILURE 3
#define MAPI_E_LOGIN_FAILURE MAPI_E_LOGON_FAILURE
#define MAPI_E_DISK_FULL 4
#define MAPI_E_INSUFFICIENT_MEMORY 5
#define MAPI_E_ACCESS_DENIED 6
#define MAPI_E_TOO_MANY_SESSIONS 8
#define MAPI_E_TOO_MANY_FILES 9
#define MAPI_E_TOO_MANY_RECIPIENTS 10
#define MAPI_E_ATTACHMENT_NOT_FOUND 11
#define MAPI_E_ATTACHMENT_OPEN_FAILURE 12
#define MAPI_E_ATTACHMENT_WRITE_FAILURE 13
#define MAPI_E_UNKNOWN_RECIPIENT 14
#define MAPI_E_BAD_RECIPTYPE 15
#define MAPI_E_NO_MESSAGES 16
#define MAPI_E_INVALID_MESSAGE 17
#define MAPI_E_TEXT_TOO_LARGE 18
#define MAPI_E_INVALID_SESSION 19
#define MAPI_E_TYPE_NOT_SUPPORTED 20
#define MAPI_E_AMBIGUOUS_RECIPIENT 21
#define MAPI_E_AMBIG_RECIP MAPI_E_AMBIGUOUS_RECIPIENT
#define MAPI_E_MESSAGE_IN_USE 22
#define MAPI_E_NETWORK_FAILURE 23
#define MAPI_E_INVALID_EDITFIELDS 24
#define MAPI_E_INVALID_RECIPS 25
#define MAPI_E_NOT_SUPPORTED 26

end extern
