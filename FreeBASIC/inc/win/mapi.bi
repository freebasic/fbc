''
''
'' mapi -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_mapi_bi__
#define __win_mapi_bi__

#inclib "mapi32"

#define SUCCESS_SUCCESS 0
#define MAPI_USER_ABORT 1
#define MAPI_E_USER_ABORT 1
#define MAPI_E_FAILURE 2
#define MAPI_E_LOGIN_FAILURE 3
#define MAPI_E_LOGON_FAILURE 3
#define MAPI_E_DISK_FULL 4
#define MAPI_E_INSUFFICIENT_MEMORY 5
#define MAPI_E_ACCESS_DENIED 6
#define MAPI_E_BLK_TOO_SMALL 6
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
#define MAPI_E_AMBIGUOUS_RECIP 21
#define MAPI_E_MESSAGE_IN_USE 22
#define MAPI_E_NETWORK_FAILURE 23
#define MAPI_E_INVALID_EDITFIELDS 24
#define MAPI_E_INVALID_RECIPS 25
#define MAPI_E_NOT_SUPPORTED 26
#define MAPI_ORIG 0
#define MAPI_TO 1
#define MAPI_CC 2
#define MAPI_BCC 3
#define MAPI_LOGON_UI &h0001
#define MAPI_NEW_SESSION &h0002
#define MAPI_FORCE_DOWNLOAD &h1000
#define MAPI_LOGOFF_SHARED &h0001
#define MAPI_LOGOFF_UI &h0002
#define MAPI_DIALOG &h0008
#define MAPI_UNREAD_ONLY &h0020
#define MAPI_LONG_MSGID &h4000
#define MAPI_GUARANTEE_FIFO &h0100
#define MAPI_ENVELOPE_ONLY &h0040
#define MAPI_PEEK &h0080
#define MAPI_BODY_AS_FILE &h0200
#define MAPI_SUPPRESS_ATTACH &h0800
#define MAPI_AB_NOMODIFY &h0400
#define MAPI_OLE &h0001
#define MAPI_OLE_STATIC &h0002
#define MAPI_UNREAD &h0001
#define MAPI_RECEIPT_REQUESTED &h0002
#define MAPI_SENT &h0004

type FLAGS as uinteger
type LHANDLE as uinteger
type LPLHANDLE as uinteger ptr
type LPULONG as uinteger ptr

type MapiRecipDesc
	ulReserved as ULONG
	ulRecipClass as ULONG
	lpszName as LPSTR
	lpszAddress as LPSTR
	ulEIDSize as ULONG
	lpEntryID as LPVOID
end type

type lpMapiRecipDesc as MapiRecipDesc ptr

type MapiFileDesc
	ulReserved as ULONG
	flFlags as ULONG
	nPosition as ULONG
	lpszPathName as LPSTR
	lpszFileName as LPSTR
	lpFileType as LPVOID
end type

type lpMapiFileDesc as MapiFileDesc ptr

type MapiFileTagExt
	ulReserved as ULONG
	cbTag as ULONG
	lpTag as LPBYTE
	cbEncoding as ULONG
	lpEncoding as LPBYTE
end type

type lpMapiFileTagExt as MapiFileTagExt ptr

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

declare function MAPILogon alias "MAPILogon" (byval as ULONG, byval as LPSTR, byval as LPSTR, byval as FLAGS, byval as ULONG, byval as LPLHANDLE) as ULONG
declare function MAPISendMail alias "MAPISendMail" (byval as LHANDLE, byval as ULONG, byval as lpMapiMessage, byval as FLAGS, byval as ULONG) as ULONG
declare function MAPISendDocuments alias "MAPISendDocuments" (byval as ULONG, byval as LPSTR, byval as LPSTR, byval as LPSTR, byval as ULONG) as ULONG
declare function MAPIReadMail alias "MAPIReadMail" (byval as LHANDLE, byval as ULONG, byval as LPSTR, byval as FLAGS, byval as ULONG, byval as lpMapiMessage ptr) as ULONG
declare function MAPIFindNext alias "MAPIFindNext" (byval as LHANDLE, byval as ULONG, byval as LPSTR, byval as LPSTR, byval as FLAGS, byval as ULONG, byval as LPSTR) as ULONG
declare function MAPIResolveName alias "MAPIResolveName" (byval as LHANDLE, byval as ULONG, byval as LPSTR, byval as FLAGS, byval as ULONG, byval as lpMapiRecipDesc ptr) as ULONG
declare function MAPIAddress alias "MAPIAddress" (byval as LHANDLE, byval as ULONG, byval as LPSTR, byval as ULONG, byval as LPSTR, byval as ULONG, byval as lpMapiRecipDesc, byval as FLAGS, byval as ULONG, byval as LPULONG, byval as lpMapiRecipDesc ptr) as ULONG
declare function MAPIFreeBuffer alias "MAPIFreeBuffer" (byval as LPVOID) as ULONG
declare function MAPIDetails alias "MAPIDetails" (byval as LHANDLE, byval as ULONG, byval as lpMapiRecipDesc, byval as FLAGS, byval as ULONG) as ULONG
declare function MAPISaveMail alias "MAPISaveMail" (byval as LHANDLE, byval as ULONG, byval lpszMessage as lpMapiMessage, byval as FLAGS, byval as ULONG, byval as LPSTR) as ULONG
declare function MAPIDeleteMail alias "MAPIDeleteMail" (byval lpSession as LHANDLE, byval as ULONG, byval as LPSTR, byval as FLAGS, byval as ULONG) as ULONG
declare function MAPILogoff alias "MAPILogoff" (byval as LHANDLE, byval as ULONG, byval as FLAGS, byval as ULONG) as ULONG
declare function MAPIGetNetscapeVersion alias "MAPIGetNetscapeVersion" () as ULONG
declare function MAPI_NSCP_SynchronizeClient alias "MAPI_NSCP_SynchronizeClient" (byval as LHANDLE, byval as ULONG) as ULONG

type LPMAPILOGON as function (byval as ULONG, byval as LPSTR, byval as LPSTR, byval as FLAGS, byval as ULONG, byval as LPLHANDLE) as ULONG
type LPMAPISENDMAIL as function (byval as LHANDLE, byval as ULONG, byval as lpMapiMessage, byval as FLAGS, byval as ULONG) as ULONG
type LPMAPISENDDOCUMENTS as function (byval as ULONG, byval as LPSTR, byval as LPSTR, byval as LPSTR, byval as ULONG) as ULONG
type LPMAPIREADMAIL as function (byval as LHANDLE, byval as ULONG, byval as LPSTR, byval as FLAGS, byval as ULONG, byval as lpMapiMessage ptr) as ULONG
type LPMAPIFINDNEXT as function (byval as LHANDLE, byval as ULONG, byval as LPSTR, byval as LPSTR, byval as FLAGS, byval as ULONG, byval as LPSTR) as ULONG
type LPMAPIRESOLVENAME as function (byval as LHANDLE, byval as ULONG, byval as LPSTR, byval as FLAGS, byval as ULONG, byval as lpMapiRecipDesc ptr) as ULONG
type LPMAPIADDRESS as function (byval as LHANDLE, byval as ULONG, byval as LPSTR, byval as ULONG, byval as LPSTR, byval as ULONG, byval as lpMapiRecipDesc, byval as FLAGS, byval as ULONG, byval as LPULONG, byval as lpMapiRecipDesc ptr) as ULONG
type LPMAPIFREEBUFFER as function (byval as LPVOID) as ULONG
type LPMAPIDETAILS as function (byval as LHANDLE, byval as ULONG, byval as lpMapiRecipDesc, byval as FLAGS, byval as ULONG) as ULONG
type LPMAPISAVEMAIL as function (byval as LHANDLE, byval as ULONG, byval as lpMapiMessage, byval as FLAGS, byval as ULONG, byval as LPSTR) as ULONG
type LPMAPIDELETEMAIL as function (byval as LHANDLE, byval as ULONG, byval as LPSTR, byval as FLAGS, byval as ULONG) as ULONG
type LPMAPILOGOFF as function (byval as LHANDLE, byval as ULONG, byval as FLAGS, byval as ULONG) as ULONG

#endif
