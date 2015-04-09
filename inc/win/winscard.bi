'' FreeBASIC binding for mingw-w64-v3.3.0

#pragma once

#include once "_mingw_unicode.bi"
#include once "wtypes.bi"
#include once "winioctl.bi"
#include once "winsmcrd.bi"

extern "Windows"

#define _WINSCARD_H_
#define _LPCBYTE_DEFINED
type LPCBYTE as const UBYTE ptr
extern import g_rgSCardT0Pci as const SCARD_IO_REQUEST
extern import g_rgSCardT1Pci as const SCARD_IO_REQUEST
extern import g_rgSCardRawPci as const SCARD_IO_REQUEST

#define SCARD_PCI_T0 (@g_rgSCardT0Pci)
#define SCARD_PCI_T1 (@g_rgSCardT1Pci)
#define SCARD_PCI_RAW (@g_rgSCardRawPci)

type SCARDCONTEXT as ULONG_PTR
type PSCARDCONTEXT as SCARDCONTEXT ptr
type LPSCARDCONTEXT as SCARDCONTEXT ptr
type SCARDHANDLE as ULONG_PTR
type PSCARDHANDLE as SCARDHANDLE ptr
type LPSCARDHANDLE as SCARDHANDLE ptr

#define SCARD_AUTOALLOCATE cast(DWORD, -1)
const SCARD_SCOPE_USER = 0
const SCARD_SCOPE_TERMINAL = 1
const SCARD_SCOPE_SYSTEM = 2

declare function SCardEstablishContext(byval dwScope as DWORD, byval pvReserved1 as LPCVOID, byval pvReserved2 as LPCVOID, byval phContext as LPSCARDCONTEXT) as LONG
declare function SCardReleaseContext(byval hContext as SCARDCONTEXT) as LONG
declare function SCardIsValidContext(byval hContext as SCARDCONTEXT) as LONG

#define SCARD_ALL_READERS __TEXT(!"SCard$AllReaders\0")
#define SCARD_DEFAULT_READERS __TEXT(!"SCard$DefaultReaders\0")
#define SCARD_LOCAL_READERS __TEXT(!"SCard$LocalReaders\0")
#define SCARD_SYSTEM_READERS __TEXT(!"SCard$SystemReaders\0")
const SCARD_PROVIDER_PRIMARY = 1
const SCARD_PROVIDER_CSP = 2

#ifdef UNICODE
	#define SCardListReaderGroups SCardListReaderGroupsW
	#define SCardListReaders SCardListReadersW
	#define SCardListCards SCardListCardsW
	#define SCardListInterfaces SCardListInterfacesW
	#define SCardGetProviderId SCardGetProviderIdW
	#define SCardGetCardTypeProviderName SCardGetCardTypeProviderNameW
	#define SCardIntroduceReaderGroup SCardIntroduceReaderGroupW
	#define SCardForgetReaderGroup SCardForgetReaderGroupW
	#define SCardIntroduceReader SCardIntroduceReaderW
	#define SCardForgetReader SCardForgetReaderW
	#define SCardAddReaderToGroup SCardAddReaderToGroupW
	#define SCardRemoveReaderFromGroup SCardRemoveReaderFromGroupW
	#define SCardIntroduceCardType SCardIntroduceCardTypeW
	#define SCardSetCardTypeProviderName SCardSetCardTypeProviderNameW
	#define SCardForgetCardType SCardForgetCardTypeW
#else
	#define SCardListReaderGroups SCardListReaderGroupsA
	#define SCardListReaders SCardListReadersA
	#define SCardListCards SCardListCardsA
	#define SCardListInterfaces SCardListInterfacesA
	#define SCardGetProviderId SCardGetProviderIdA
	#define SCardGetCardTypeProviderName SCardGetCardTypeProviderNameA
	#define SCardIntroduceReaderGroup SCardIntroduceReaderGroupA
	#define SCardForgetReaderGroup SCardForgetReaderGroupA
	#define SCardIntroduceReader SCardIntroduceReaderA
	#define SCardForgetReader SCardForgetReaderA
	#define SCardAddReaderToGroup SCardAddReaderToGroupA
	#define SCardRemoveReaderFromGroup SCardRemoveReaderFromGroupA
	#define SCardIntroduceCardType SCardIntroduceCardTypeA
	#define SCardSetCardTypeProviderName SCardSetCardTypeProviderNameA
	#define SCardForgetCardType SCardForgetCardTypeA
#endif

declare function SCardListReaderGroupsA(byval hContext as SCARDCONTEXT, byval mszGroups as LPSTR, byval pcchGroups as LPDWORD) as LONG
declare function SCardListReaderGroupsW(byval hContext as SCARDCONTEXT, byval mszGroups as LPWSTR, byval pcchGroups as LPDWORD) as LONG
declare function SCardListReadersA(byval hContext as SCARDCONTEXT, byval mszGroups as LPCSTR, byval mszReaders as LPSTR, byval pcchReaders as LPDWORD) as LONG
declare function SCardListReadersW(byval hContext as SCARDCONTEXT, byval mszGroups as LPCWSTR, byval mszReaders as LPWSTR, byval pcchReaders as LPDWORD) as LONG
declare function SCardListCardsA(byval hContext as SCARDCONTEXT, byval pbAtr as LPCBYTE, byval rgquidInterfaces as LPCGUID, byval cguidInterfaceCount as DWORD, byval mszCards as LPSTR, byval pcchCards as LPDWORD) as LONG
declare function SCardListCardsW(byval hContext as SCARDCONTEXT, byval pbAtr as LPCBYTE, byval rgquidInterfaces as LPCGUID, byval cguidInterfaceCount as DWORD, byval mszCards as LPWSTR, byval pcchCards as LPDWORD) as LONG
#define SCardListCardTypes SCardListCards
declare function SCardListInterfacesA(byval hContext as SCARDCONTEXT, byval szCard as LPCSTR, byval pguidInterfaces as LPGUID, byval pcguidInterfaces as LPDWORD) as LONG
declare function SCardListInterfacesW(byval hContext as SCARDCONTEXT, byval szCard as LPCWSTR, byval pguidInterfaces as LPGUID, byval pcguidInterfaces as LPDWORD) as LONG
declare function SCardGetProviderIdA(byval hContext as SCARDCONTEXT, byval szCard as LPCSTR, byval pguidProviderId as LPGUID) as LONG
declare function SCardGetProviderIdW(byval hContext as SCARDCONTEXT, byval szCard as LPCWSTR, byval pguidProviderId as LPGUID) as LONG
declare function SCardGetCardTypeProviderNameA(byval hContext as SCARDCONTEXT, byval szCardName as LPCSTR, byval dwProviderId as DWORD, byval szProvider as LPSTR, byval pcchProvider as LPDWORD) as LONG
declare function SCardGetCardTypeProviderNameW(byval hContext as SCARDCONTEXT, byval szCardName as LPCWSTR, byval dwProviderId as DWORD, byval szProvider as LPWSTR, byval pcchProvider as LPDWORD) as LONG
declare function SCardIntroduceReaderGroupA(byval hContext as SCARDCONTEXT, byval szGroupName as LPCSTR) as LONG
declare function SCardIntroduceReaderGroupW(byval hContext as SCARDCONTEXT, byval szGroupName as LPCWSTR) as LONG
declare function SCardForgetReaderGroupA(byval hContext as SCARDCONTEXT, byval szGroupName as LPCSTR) as LONG
declare function SCardForgetReaderGroupW(byval hContext as SCARDCONTEXT, byval szGroupName as LPCWSTR) as LONG
declare function SCardIntroduceReaderA(byval hContext as SCARDCONTEXT, byval szReaderName as LPCSTR, byval szDeviceName as LPCSTR) as LONG
declare function SCardIntroduceReaderW(byval hContext as SCARDCONTEXT, byval szReaderName as LPCWSTR, byval szDeviceName as LPCWSTR) as LONG
declare function SCardForgetReaderA(byval hContext as SCARDCONTEXT, byval szReaderName as LPCSTR) as LONG
declare function SCardForgetReaderW(byval hContext as SCARDCONTEXT, byval szReaderName as LPCWSTR) as LONG
declare function SCardAddReaderToGroupA(byval hContext as SCARDCONTEXT, byval szReaderName as LPCSTR, byval szGroupName as LPCSTR) as LONG
declare function SCardAddReaderToGroupW(byval hContext as SCARDCONTEXT, byval szReaderName as LPCWSTR, byval szGroupName as LPCWSTR) as LONG
declare function SCardRemoveReaderFromGroupA(byval hContext as SCARDCONTEXT, byval szReaderName as LPCSTR, byval szGroupName as LPCSTR) as LONG
declare function SCardRemoveReaderFromGroupW(byval hContext as SCARDCONTEXT, byval szReaderName as LPCWSTR, byval szGroupName as LPCWSTR) as LONG
declare function SCardIntroduceCardTypeA(byval hContext as SCARDCONTEXT, byval szCardName as LPCSTR, byval pguidPrimaryProvider as LPCGUID, byval rgguidInterfaces as LPCGUID, byval dwInterfaceCount as DWORD, byval pbAtr as LPCBYTE, byval pbAtrMask as LPCBYTE, byval cbAtrLen as DWORD) as LONG
declare function SCardIntroduceCardTypeW(byval hContext as SCARDCONTEXT, byval szCardName as LPCWSTR, byval pguidPrimaryProvider as LPCGUID, byval rgguidInterfaces as LPCGUID, byval dwInterfaceCount as DWORD, byval pbAtr as LPCBYTE, byval pbAtrMask as LPCBYTE, byval cbAtrLen as DWORD) as LONG
#define PCSCardIntroduceCardType(hContext, szCardName, pbAtr, pbAtrMask, cbAtrLen, pguidPrimaryProvider, rgguidInterfaces, dwInterfaceCount) SCardIntroduceCardType(hContext, szCardName, pguidPrimaryProvider, rgguidInterfaces, dwInterfaceCount, pbAtr, pbAtrMask, cbAtrLen)
declare function SCardSetCardTypeProviderNameA(byval hContext as SCARDCONTEXT, byval szCardName as LPCSTR, byval dwProviderId as DWORD, byval szProvider as LPCSTR) as LONG
declare function SCardSetCardTypeProviderNameW(byval hContext as SCARDCONTEXT, byval szCardName as LPCWSTR, byval dwProviderId as DWORD, byval szProvider as LPCWSTR) as LONG
declare function SCardForgetCardTypeA(byval hContext as SCARDCONTEXT, byval szCardName as LPCSTR) as LONG
declare function SCardForgetCardTypeW(byval hContext as SCARDCONTEXT, byval szCardName as LPCWSTR) as LONG
declare function SCardFreeMemory(byval hContext as SCARDCONTEXT, byval pvMem as LPCVOID) as LONG
declare function SCardAccessStartedEvent() as HANDLE
declare sub SCardReleaseStartedEvent()

type SCARD_READERSTATEA
	szReader as LPCSTR
	pvUserData as LPVOID
	dwCurrentState as DWORD
	dwEventState as DWORD
	cbAtr as DWORD
	rgbAtr(0 to 35) as UBYTE
end type

type PSCARD_READERSTATEA as SCARD_READERSTATEA ptr
type LPSCARD_READERSTATEA as SCARD_READERSTATEA ptr

type SCARD_READERSTATEW
	szReader as LPCWSTR
	pvUserData as LPVOID
	dwCurrentState as DWORD
	dwEventState as DWORD
	cbAtr as DWORD
	rgbAtr(0 to 35) as UBYTE
end type

type PSCARD_READERSTATEW as SCARD_READERSTATEW ptr
type LPSCARD_READERSTATEW as SCARD_READERSTATEW ptr

#ifdef UNICODE
	type SCARD_READERSTATE as SCARD_READERSTATEW
	type PSCARD_READERSTATE as PSCARD_READERSTATEW
	type LPSCARD_READERSTATE as LPSCARD_READERSTATEW

	#define SCardLocateCards SCardLocateCardsW
	#define SCardLocateCardsByATR SCardLocateCardsByATRW
	#define SCardGetStatusChange SCardGetStatusChangeW
	#define SCardConnect SCardConnectW
	#define SCardStatus SCardStatusW
#else
	type SCARD_READERSTATE as SCARD_READERSTATEA
	type PSCARD_READERSTATE as PSCARD_READERSTATEA
	type LPSCARD_READERSTATE as LPSCARD_READERSTATEA

	#define SCardLocateCards SCardLocateCardsA
	#define SCardLocateCardsByATR SCardLocateCardsByATRA
	#define SCardGetStatusChange SCardGetStatusChangeA
	#define SCardConnect SCardConnectA
	#define SCardStatus SCardStatusA
#endif

#define SCARD_READERSTATE_A SCARD_READERSTATEA
#define SCARD_READERSTATE_W SCARD_READERSTATEW
#define PSCARD_READERSTATE_A PSCARD_READERSTATEA
#define PSCARD_READERSTATE_W PSCARD_READERSTATEW
#define LPSCARD_READERSTATE_A LPSCARD_READERSTATEA
#define LPSCARD_READERSTATE_W LPSCARD_READERSTATEW
const SCARD_STATE_UNAWARE = &h00000000
const SCARD_STATE_IGNORE = &h00000001
const SCARD_STATE_CHANGED = &h00000002
const SCARD_STATE_UNKNOWN = &h00000004
const SCARD_STATE_UNAVAILABLE = &h00000008
const SCARD_STATE_EMPTY = &h00000010
const SCARD_STATE_PRESENT = &h00000020
const SCARD_STATE_ATRMATCH = &h00000040
const SCARD_STATE_EXCLUSIVE = &h00000080
const SCARD_STATE_INUSE = &h00000100
const SCARD_STATE_MUTE = &h00000200
const SCARD_STATE_UNPOWERED = &h00000400
declare function SCardLocateCardsA(byval hContext as SCARDCONTEXT, byval mszCards as LPCSTR, byval rgReaderStates as LPSCARD_READERSTATEA, byval cReaders as DWORD) as LONG
declare function SCardLocateCardsW(byval hContext as SCARDCONTEXT, byval mszCards as LPCWSTR, byval rgReaderStates as LPSCARD_READERSTATEW, byval cReaders as DWORD) as LONG

type _SCARD_ATRMASK
	cbAtr as DWORD
	rgbAtr(0 to 35) as UBYTE
	rgbMask(0 to 35) as UBYTE
end type

type SCARD_ATRMASK as _SCARD_ATRMASK
type PSCARD_ATRMASK as _SCARD_ATRMASK ptr
type LPSCARD_ATRMASK as _SCARD_ATRMASK ptr

declare function SCardLocateCardsByATRA(byval hContext as SCARDCONTEXT, byval rgAtrMasks as LPSCARD_ATRMASK, byval cAtrs as DWORD, byval rgReaderStates as LPSCARD_READERSTATEA, byval cReaders as DWORD) as LONG
declare function SCardLocateCardsByATRW(byval hContext as SCARDCONTEXT, byval rgAtrMasks as LPSCARD_ATRMASK, byval cAtrs as DWORD, byval rgReaderStates as LPSCARD_READERSTATEW, byval cReaders as DWORD) as LONG
declare function SCardGetStatusChangeA(byval hContext as SCARDCONTEXT, byval dwTimeout as DWORD, byval rgReaderStates as LPSCARD_READERSTATEA, byval cReaders as DWORD) as LONG
declare function SCardGetStatusChangeW(byval hContext as SCARDCONTEXT, byval dwTimeout as DWORD, byval rgReaderStates as LPSCARD_READERSTATEW, byval cReaders as DWORD) as LONG
declare function SCardCancel(byval hContext as SCARDCONTEXT) as LONG

const SCARD_SHARE_EXCLUSIVE = 1
const SCARD_SHARE_SHARED = 2
const SCARD_SHARE_DIRECT = 3
const SCARD_LEAVE_CARD = 0
const SCARD_RESET_CARD = 1
const SCARD_UNPOWER_CARD = 2
const SCARD_EJECT_CARD = 3

declare function SCardConnectA(byval hContext as SCARDCONTEXT, byval szReader as LPCSTR, byval dwShareMode as DWORD, byval dwPreferredProtocols as DWORD, byval phCard as LPSCARDHANDLE, byval pdwActiveProtocol as LPDWORD) as LONG
declare function SCardConnectW(byval hContext as SCARDCONTEXT, byval szReader as LPCWSTR, byval dwShareMode as DWORD, byval dwPreferredProtocols as DWORD, byval phCard as LPSCARDHANDLE, byval pdwActiveProtocol as LPDWORD) as LONG
declare function SCardReconnect(byval hCard as SCARDHANDLE, byval dwShareMode as DWORD, byval dwPreferredProtocols as DWORD, byval dwInitialization as DWORD, byval pdwActiveProtocol as LPDWORD) as LONG
declare function SCardDisconnect(byval hCard as SCARDHANDLE, byval dwDisposition as DWORD) as LONG
declare function SCardBeginTransaction(byval hCard as SCARDHANDLE) as LONG
declare function SCardEndTransaction(byval hCard as SCARDHANDLE, byval dwDisposition as DWORD) as LONG
declare function SCardCancelTransaction(byval hCard as SCARDHANDLE) as LONG
declare function SCardState(byval hCard as SCARDHANDLE, byval pdwState as LPDWORD, byval pdwProtocol as LPDWORD, byval pbAtr as LPBYTE, byval pcbAtrLen as LPDWORD) as LONG
declare function SCardStatusA(byval hCard as SCARDHANDLE, byval szReaderName as LPSTR, byval pcchReaderLen as LPDWORD, byval pdwState as LPDWORD, byval pdwProtocol as LPDWORD, byval pbAtr as LPBYTE, byval pcbAtrLen as LPDWORD) as LONG
declare function SCardStatusW(byval hCard as SCARDHANDLE, byval szReaderName as LPWSTR, byval pcchReaderLen as LPDWORD, byval pdwState as LPDWORD, byval pdwProtocol as LPDWORD, byval pbAtr as LPBYTE, byval pcbAtrLen as LPDWORD) as LONG
declare function SCardTransmit(byval hCard as SCARDHANDLE, byval pioSendPci as LPCSCARD_IO_REQUEST, byval pbSendBuffer as LPCBYTE, byval cbSendLength as DWORD, byval pioRecvPci as LPSCARD_IO_REQUEST, byval pbRecvBuffer as LPBYTE, byval pcbRecvLength as LPDWORD) as LONG
declare function SCardControl(byval hCard as SCARDHANDLE, byval dwControlCode as DWORD, byval lpInBuffer as LPCVOID, byval nInBufferSize as DWORD, byval lpOutBuffer as LPVOID, byval nOutBufferSize as DWORD, byval lpBytesReturned as LPDWORD) as LONG
declare function SCardGetAttrib(byval hCard as SCARDHANDLE, byval dwAttrId as DWORD, byval pbAttr as LPBYTE, byval pcbAttrLen as LPDWORD) as LONG
#define SCardGetReaderCapabilities SCardGetAttrib
declare function SCardSetAttrib(byval hCard as SCARDHANDLE, byval dwAttrId as DWORD, byval pbAttr as LPCBYTE, byval cbAttrLen as DWORD) as LONG

#define SCardSetReaderCapabilities SCardSetAttrib
const SC_DLG_MINIMAL_UI = &h01
const SC_DLG_NO_UI = &h02
const SC_DLG_FORCE_UI = &h04
const SCERR_NOCARDNAME = &h4000
const SCERR_NOGUIDS = &h8000

#ifdef UNICODE
	#define LPOCNCONNPROC LPOCNCONNPROCW
#else
	#define LPOCNCONNPROC LPOCNCONNPROCA
#endif

type LPOCNCONNPROCA as function(byval as SCARDCONTEXT, byval as LPSTR, byval as LPSTR, byval as PVOID) as SCARDHANDLE
type LPOCNCONNPROCW as function(byval as SCARDCONTEXT, byval as LPWSTR, byval as LPWSTR, byval as PVOID) as SCARDHANDLE
type LPOCNCHKPROC as function(byval as SCARDCONTEXT, byval as SCARDHANDLE, byval as PVOID) as WINBOOL
type LPOCNDSCPROC as sub(byval as SCARDCONTEXT, byval as SCARDHANDLE, byval as PVOID)

type OPENCARD_SEARCH_CRITERIAA
	dwStructSize as DWORD
	lpstrGroupNames as LPSTR
	nMaxGroupNames as DWORD
	rgguidInterfaces as LPCGUID
	cguidInterfaces as DWORD
	lpstrCardNames as LPSTR
	nMaxCardNames as DWORD
	lpfnCheck as LPOCNCHKPROC
	lpfnConnect as LPOCNCONNPROCA
	lpfnDisconnect as LPOCNDSCPROC
	pvUserData as LPVOID
	dwShareMode as DWORD
	dwPreferredProtocols as DWORD
end type

type POPENCARD_SEARCH_CRITERIAA as OPENCARD_SEARCH_CRITERIAA ptr
type LPOPENCARD_SEARCH_CRITERIAA as OPENCARD_SEARCH_CRITERIAA ptr

type OPENCARD_SEARCH_CRITERIAW
	dwStructSize as DWORD
	lpstrGroupNames as LPWSTR
	nMaxGroupNames as DWORD
	rgguidInterfaces as LPCGUID
	cguidInterfaces as DWORD
	lpstrCardNames as LPWSTR
	nMaxCardNames as DWORD
	lpfnCheck as LPOCNCHKPROC
	lpfnConnect as LPOCNCONNPROCW
	lpfnDisconnect as LPOCNDSCPROC
	pvUserData as LPVOID
	dwShareMode as DWORD
	dwPreferredProtocols as DWORD
end type

type POPENCARD_SEARCH_CRITERIAW as OPENCARD_SEARCH_CRITERIAW ptr
type LPOPENCARD_SEARCH_CRITERIAW as OPENCARD_SEARCH_CRITERIAW ptr

#ifdef UNICODE
	type OPENCARD_SEARCH_CRITERIA as OPENCARD_SEARCH_CRITERIAW
	type POPENCARD_SEARCH_CRITERIA as POPENCARD_SEARCH_CRITERIAW
	type LPOPENCARD_SEARCH_CRITERIA as LPOPENCARD_SEARCH_CRITERIAW
#else
	type OPENCARD_SEARCH_CRITERIA as OPENCARD_SEARCH_CRITERIAA
	type POPENCARD_SEARCH_CRITERIA as POPENCARD_SEARCH_CRITERIAA
	type LPOPENCARD_SEARCH_CRITERIA as LPOPENCARD_SEARCH_CRITERIAA
#endif

type OPENCARDNAME_EXA
	dwStructSize as DWORD
	hSCardContext as SCARDCONTEXT
	hwndOwner as HWND
	dwFlags as DWORD
	lpstrTitle as LPCSTR
	lpstrSearchDesc as LPCSTR
	hIcon as HICON
	pOpenCardSearchCriteria as POPENCARD_SEARCH_CRITERIAA
	lpfnConnect as LPOCNCONNPROCA
	pvUserData as LPVOID
	dwShareMode as DWORD
	dwPreferredProtocols as DWORD
	lpstrRdr as LPSTR
	nMaxRdr as DWORD
	lpstrCard as LPSTR
	nMaxCard as DWORD
	dwActiveProtocol as DWORD
	hCardHandle as SCARDHANDLE
end type

type POPENCARDNAME_EXA as OPENCARDNAME_EXA ptr
type LPOPENCARDNAME_EXA as OPENCARDNAME_EXA ptr

type OPENCARDNAME_EXW
	dwStructSize as DWORD
	hSCardContext as SCARDCONTEXT
	hwndOwner as HWND
	dwFlags as DWORD
	lpstrTitle as LPCWSTR
	lpstrSearchDesc as LPCWSTR
	hIcon as HICON
	pOpenCardSearchCriteria as POPENCARD_SEARCH_CRITERIAW
	lpfnConnect as LPOCNCONNPROCW
	pvUserData as LPVOID
	dwShareMode as DWORD
	dwPreferredProtocols as DWORD
	lpstrRdr as LPWSTR
	nMaxRdr as DWORD
	lpstrCard as LPWSTR
	nMaxCard as DWORD
	dwActiveProtocol as DWORD
	hCardHandle as SCARDHANDLE
end type

type POPENCARDNAME_EXW as OPENCARDNAME_EXW ptr
type LPOPENCARDNAME_EXW as OPENCARDNAME_EXW ptr

#ifdef UNICODE
	type OPENCARDNAME_EX as OPENCARDNAME_EXW
	type POPENCARDNAME_EX as POPENCARDNAME_EXW
	type LPOPENCARDNAME_EX as LPOPENCARDNAME_EXW
#else
	type OPENCARDNAME_EX as OPENCARDNAME_EXA
	type POPENCARDNAME_EX as POPENCARDNAME_EXA
	type LPOPENCARDNAME_EX as LPOPENCARDNAME_EXA
#endif

#define OPENCARDNAMEA_EX OPENCARDNAME_EXA
#define OPENCARDNAMEW_EX OPENCARDNAME_EXW
#define POPENCARDNAMEA_EX POPENCARDNAME_EXA
#define POPENCARDNAMEW_EX POPENCARDNAME_EXW
#define LPOPENCARDNAMEA_EX LPOPENCARDNAME_EXA
#define LPOPENCARDNAMEW_EX LPOPENCARDNAME_EXW

#ifdef UNICODE
	#define SCardUIDlgSelectCard SCardUIDlgSelectCardW
#else
	#define SCardUIDlgSelectCard SCardUIDlgSelectCardA
#endif

declare function SCardUIDlgSelectCardA(byval as LPOPENCARDNAME_EXA) as LONG
declare function SCardUIDlgSelectCardW(byval as LPOPENCARDNAME_EXW) as LONG

type OPENCARDNAMEA
	dwStructSize as DWORD
	hwndOwner as HWND
	hSCardContext as SCARDCONTEXT
	lpstrGroupNames as LPSTR
	nMaxGroupNames as DWORD
	lpstrCardNames as LPSTR
	nMaxCardNames as DWORD
	rgguidInterfaces as LPCGUID
	cguidInterfaces as DWORD
	lpstrRdr as LPSTR
	nMaxRdr as DWORD
	lpstrCard as LPSTR
	nMaxCard as DWORD
	lpstrTitle as LPCSTR
	dwFlags as DWORD
	pvUserData as LPVOID
	dwShareMode as DWORD
	dwPreferredProtocols as DWORD
	dwActiveProtocol as DWORD
	lpfnConnect as LPOCNCONNPROCA
	lpfnCheck as LPOCNCHKPROC
	lpfnDisconnect as LPOCNDSCPROC
	hCardHandle as SCARDHANDLE
end type

type POPENCARDNAMEA as OPENCARDNAMEA ptr
type LPOPENCARDNAMEA as OPENCARDNAMEA ptr

type OPENCARDNAMEW
	dwStructSize as DWORD
	hwndOwner as HWND
	hSCardContext as SCARDCONTEXT
	lpstrGroupNames as LPWSTR
	nMaxGroupNames as DWORD
	lpstrCardNames as LPWSTR
	nMaxCardNames as DWORD
	rgguidInterfaces as LPCGUID
	cguidInterfaces as DWORD
	lpstrRdr as LPWSTR
	nMaxRdr as DWORD
	lpstrCard as LPWSTR
	nMaxCard as DWORD
	lpstrTitle as LPCWSTR
	dwFlags as DWORD
	pvUserData as LPVOID
	dwShareMode as DWORD
	dwPreferredProtocols as DWORD
	dwActiveProtocol as DWORD
	lpfnConnect as LPOCNCONNPROCW
	lpfnCheck as LPOCNCHKPROC
	lpfnDisconnect as LPOCNDSCPROC
	hCardHandle as SCARDHANDLE
end type

type POPENCARDNAMEW as OPENCARDNAMEW ptr
type LPOPENCARDNAMEW as OPENCARDNAMEW ptr

#ifdef UNICODE
	type OPENCARDNAME as OPENCARDNAMEW
	type POPENCARDNAME as POPENCARDNAMEW
	type LPOPENCARDNAME as LPOPENCARDNAMEW
#else
	type OPENCARDNAME as OPENCARDNAMEA
	type POPENCARDNAME as POPENCARDNAMEA
	type LPOPENCARDNAME as LPOPENCARDNAMEA
#endif

#define OPENCARDNAME_A OPENCARDNAMEA
#define OPENCARDNAME_W OPENCARDNAMEW
#define POPENCARDNAME_A POPENCARDNAMEA
#define POPENCARDNAME_W POPENCARDNAMEW
#define LPOPENCARDNAME_A LPOPENCARDNAMEA
#define LPOPENCARDNAME_W LPOPENCARDNAMEW

#ifdef UNICODE
	#define GetOpenCardName GetOpenCardNameW
#else
	#define GetOpenCardName GetOpenCardNameA
#endif

declare function GetOpenCardNameA(byval as LPOPENCARDNAMEA) as LONG
declare function GetOpenCardNameW(byval as LPOPENCARDNAMEW) as LONG
declare function SCardDlgExtendedError() as LONG

#if _WIN32_WINNT = &h0602
	declare function SCardGetTransmitCount(byval hCard as SCARDHANDLE, byval pcTransmitCount as LPDWORD) as LONG
	declare function SCardReadCacheA(byval hContext as SCARDCONTEXT, byval CardIdentifier as UUID ptr, byval FreshnessCounter as DWORD, byval LookupName as LPSTR, byval Data as PBYTE, byval DataLen as DWORD ptr) as LONG
	declare function SCardReadCacheW(byval hContext as SCARDCONTEXT, byval CardIdentifier as UUID ptr, byval FreshnessCounter as DWORD, byval LookupName as LPWSTR, byval Data as PBYTE, byval DataLen as DWORD ptr) as LONG
#endif

#if defined(UNICODE) and (_WIN32_WINNT = &h0602)
	#define SCardReadCache SCardReadCacheW
#elseif (not defined(UNICODE)) and (_WIN32_WINNT = &h0602)
	#define SCardReadCache SCardReadCacheA
#endif

#if _WIN32_WINNT = &h0602
	declare function SCardWriteCacheA(byval hContext as SCARDCONTEXT, byval CardIdentifier as UUID ptr, byval FreshnessCounter as DWORD, byval LookupName as LPSTR, byval Data as PBYTE, byval DataLen as DWORD) as LONG
	declare function SCardWriteCacheW(byval hContext as SCARDCONTEXT, byval CardIdentifier as UUID ptr, byval FreshnessCounter as DWORD, byval LookupName as LPWSTR, byval Data as PBYTE, byval DataLen as DWORD) as LONG
#endif

#if defined(UNICODE) and (_WIN32_WINNT = &h0602)
	#define SCardWriteCache SCardWriteCacheW
#elseif (not defined(UNICODE)) and (_WIN32_WINNT = &h0602)
	#define SCardWriteCache SCardWriteCacheA
#endif

end extern
