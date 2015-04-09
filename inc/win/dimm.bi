'' FreeBASIC binding for mingw-w64-v3.3.0

#pragma once

#include once "rpc.bi"
#include once "rpcndr.bi"
#include once "unknwn.bi"
#include once "imm.bi"

extern "Windows"

#define __dimm_h__
#define __IEnumRegisterWordA_FWD_DEFINED__
#define __IEnumRegisterWordW_FWD_DEFINED__
#define __IEnumInputContext_FWD_DEFINED__
#define __IActiveIMMRegistrar_FWD_DEFINED__
#define __IActiveIMMMessagePumpOwner_FWD_DEFINED__
#define __IActiveIMMApp_FWD_DEFINED__
#define __IActiveIMMIME_FWD_DEFINED__
#define __IActiveIME_FWD_DEFINED__
#define __IActiveIME2_FWD_DEFINED__
#define __CActiveIMM_FWD_DEFINED__
extern __MIDL_itf_dimm_0000_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_dimm_0000_v0_0_s_ifspec as RPC_IF_HANDLE
#define __ActiveIMM_LIBRARY_DEFINED__

union __MIDL___MIDL_itf_dimm_0000_0012_lfFont
	A as LOGFONTA
	W as LOGFONTW
end union

type __MIDL___MIDL_itf_dimm_0000_0012
	hWnd as HWND
	fOpen as WINBOOL
	ptStatusWndPos as POINT
	ptSoftKbdPos as POINT
	fdwConversion as DWORD
	fdwSentence as DWORD
	lfFont as __MIDL___MIDL_itf_dimm_0000_0012_lfFont
	cfCompForm as COMPOSITIONFORM
	cfCandForm(0 to 3) as CANDIDATEFORM
	hCompStr as HIMCC
	hCandInfo as HIMCC
	hGuideLine as HIMCC
	hPrivate as HIMCC
	dwNumMsgBuf as DWORD
	hMsgBuf as HIMCC
	fdwInit as DWORD
	dwReserve(0 to 2) as DWORD
end type

type INPUTCONTEXT as __MIDL___MIDL_itf_dimm_0000_0012

type __MIDL___MIDL_itf_dimm_0000_0014
	dwPrivateDataSize as DWORD
	fdwProperty as DWORD
	fdwConversionCaps as DWORD
	fdwSentenceCaps as DWORD
	fdwUICaps as DWORD
	fdwSCSCaps as DWORD
	fdwSelectCaps as DWORD
end type

type IMEINFO as __MIDL___MIDL_itf_dimm_0000_0014
extern LIBID_ActiveIMM as const IID
#define __IEnumRegisterWordA_INTERFACE_DEFINED__
extern IID_IEnumRegisterWordA as const IID
type IEnumRegisterWordA as IEnumRegisterWordA_

type IEnumRegisterWordAVtbl
	QueryInterface as function(byval This as IEnumRegisterWordA ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IEnumRegisterWordA ptr) as ULONG
	Release as function(byval This as IEnumRegisterWordA ptr) as ULONG
	Clone as function(byval This as IEnumRegisterWordA ptr, byval ppEnum as IEnumRegisterWordA ptr ptr) as HRESULT
	Next as function(byval This as IEnumRegisterWordA ptr, byval ulCount as ULONG, byval rgRegisterWord as REGISTERWORDA ptr, byval pcFetched as ULONG ptr) as HRESULT
	Reset as function(byval This as IEnumRegisterWordA ptr) as HRESULT
	Skip as function(byval This as IEnumRegisterWordA ptr, byval ulCount as ULONG) as HRESULT
end type

type IEnumRegisterWordA_
	lpVtbl as IEnumRegisterWordAVtbl ptr
end type

declare function IEnumRegisterWordA_Clone_Proxy(byval This as IEnumRegisterWordA ptr, byval ppEnum as IEnumRegisterWordA ptr ptr) as HRESULT
declare sub IEnumRegisterWordA_Clone_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IEnumRegisterWordA_Next_Proxy(byval This as IEnumRegisterWordA ptr, byval ulCount as ULONG, byval rgRegisterWord as REGISTERWORDA ptr, byval pcFetched as ULONG ptr) as HRESULT
declare sub IEnumRegisterWordA_Next_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IEnumRegisterWordA_Reset_Proxy(byval This as IEnumRegisterWordA ptr) as HRESULT
declare sub IEnumRegisterWordA_Reset_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IEnumRegisterWordA_Skip_Proxy(byval This as IEnumRegisterWordA ptr, byval ulCount as ULONG) as HRESULT
declare sub IEnumRegisterWordA_Skip_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IEnumRegisterWordW_INTERFACE_DEFINED__
extern IID_IEnumRegisterWordW as const IID
type IEnumRegisterWordW as IEnumRegisterWordW_

type IEnumRegisterWordWVtbl
	QueryInterface as function(byval This as IEnumRegisterWordW ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IEnumRegisterWordW ptr) as ULONG
	Release as function(byval This as IEnumRegisterWordW ptr) as ULONG
	Clone as function(byval This as IEnumRegisterWordW ptr, byval ppEnum as IEnumRegisterWordW ptr ptr) as HRESULT
	Next as function(byval This as IEnumRegisterWordW ptr, byval ulCount as ULONG, byval rgRegisterWord as REGISTERWORDW ptr, byval pcFetched as ULONG ptr) as HRESULT
	Reset as function(byval This as IEnumRegisterWordW ptr) as HRESULT
	Skip as function(byval This as IEnumRegisterWordW ptr, byval ulCount as ULONG) as HRESULT
end type

type IEnumRegisterWordW_
	lpVtbl as IEnumRegisterWordWVtbl ptr
end type

declare function IEnumRegisterWordW_Clone_Proxy(byval This as IEnumRegisterWordW ptr, byval ppEnum as IEnumRegisterWordW ptr ptr) as HRESULT
declare sub IEnumRegisterWordW_Clone_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IEnumRegisterWordW_Next_Proxy(byval This as IEnumRegisterWordW ptr, byval ulCount as ULONG, byval rgRegisterWord as REGISTERWORDW ptr, byval pcFetched as ULONG ptr) as HRESULT
declare sub IEnumRegisterWordW_Next_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IEnumRegisterWordW_Reset_Proxy(byval This as IEnumRegisterWordW ptr) as HRESULT
declare sub IEnumRegisterWordW_Reset_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IEnumRegisterWordW_Skip_Proxy(byval This as IEnumRegisterWordW ptr, byval ulCount as ULONG) as HRESULT
declare sub IEnumRegisterWordW_Skip_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IEnumInputContext_INTERFACE_DEFINED__
extern IID_IEnumInputContext as const IID
type IEnumInputContext as IEnumInputContext_

type IEnumInputContextVtbl
	QueryInterface as function(byval This as IEnumInputContext ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IEnumInputContext ptr) as ULONG
	Release as function(byval This as IEnumInputContext ptr) as ULONG
	Clone as function(byval This as IEnumInputContext ptr, byval ppEnum as IEnumInputContext ptr ptr) as HRESULT
	Next as function(byval This as IEnumInputContext ptr, byval ulCount as ULONG, byval rgInputContext as HIMC ptr, byval pcFetched as ULONG ptr) as HRESULT
	Reset as function(byval This as IEnumInputContext ptr) as HRESULT
	Skip as function(byval This as IEnumInputContext ptr, byval ulCount as ULONG) as HRESULT
end type

type IEnumInputContext_
	lpVtbl as IEnumInputContextVtbl ptr
end type

declare function IEnumInputContext_Clone_Proxy(byval This as IEnumInputContext ptr, byval ppEnum as IEnumInputContext ptr ptr) as HRESULT
declare sub IEnumInputContext_Clone_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IEnumInputContext_Next_Proxy(byval This as IEnumInputContext ptr, byval ulCount as ULONG, byval rgInputContext as HIMC ptr, byval pcFetched as ULONG ptr) as HRESULT
declare sub IEnumInputContext_Next_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IEnumInputContext_Reset_Proxy(byval This as IEnumInputContext ptr) as HRESULT
declare sub IEnumInputContext_Reset_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IEnumInputContext_Skip_Proxy(byval This as IEnumInputContext ptr, byval ulCount as ULONG) as HRESULT
declare sub IEnumInputContext_Skip_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IActiveIMMRegistrar_INTERFACE_DEFINED__
extern IID_IActiveIMMRegistrar as const IID
type IActiveIMMRegistrar as IActiveIMMRegistrar_

type IActiveIMMRegistrarVtbl
	QueryInterface as function(byval This as IActiveIMMRegistrar ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IActiveIMMRegistrar ptr) as ULONG
	Release as function(byval This as IActiveIMMRegistrar ptr) as ULONG
	RegisterIME as function(byval This as IActiveIMMRegistrar ptr, byval rclsid as const IID const ptr, byval lgid as LANGID, byval pszIconFile as LPCWSTR, byval pszDesc as LPCWSTR) as HRESULT
	UnregisterIME as function(byval This as IActiveIMMRegistrar ptr, byval rclsid as const IID const ptr) as HRESULT
end type

type IActiveIMMRegistrar_
	lpVtbl as IActiveIMMRegistrarVtbl ptr
end type

declare function IActiveIMMRegistrar_RegisterIME_Proxy(byval This as IActiveIMMRegistrar ptr, byval rclsid as const IID const ptr, byval lgid as LANGID, byval pszIconFile as LPCWSTR, byval pszDesc as LPCWSTR) as HRESULT
declare sub IActiveIMMRegistrar_RegisterIME_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMRegistrar_UnregisterIME_Proxy(byval This as IActiveIMMRegistrar ptr, byval rclsid as const IID const ptr) as HRESULT
declare sub IActiveIMMRegistrar_UnregisterIME_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IActiveIMMMessagePumpOwner_INTERFACE_DEFINED__
extern IID_IActiveIMMMessagePumpOwner as const IID
type IActiveIMMMessagePumpOwner as IActiveIMMMessagePumpOwner_

type IActiveIMMMessagePumpOwnerVtbl
	QueryInterface as function(byval This as IActiveIMMMessagePumpOwner ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IActiveIMMMessagePumpOwner ptr) as ULONG
	Release as function(byval This as IActiveIMMMessagePumpOwner ptr) as ULONG
	Start as function(byval This as IActiveIMMMessagePumpOwner ptr) as HRESULT
	as function(byval This as IActiveIMMMessagePumpOwner ptr) as HRESULT End
	OnTranslateMessage as function(byval This as IActiveIMMMessagePumpOwner ptr, byval pMsg as const MSG ptr) as HRESULT
	Pause as function(byval This as IActiveIMMMessagePumpOwner ptr, byval pdwCookie as DWORD ptr) as HRESULT
	Resume as function(byval This as IActiveIMMMessagePumpOwner ptr, byval dwCookie as DWORD) as HRESULT
end type

type IActiveIMMMessagePumpOwner_
	lpVtbl as IActiveIMMMessagePumpOwnerVtbl ptr
end type

declare function IActiveIMMMessagePumpOwner_Start_Proxy(byval This as IActiveIMMMessagePumpOwner ptr) as HRESULT
declare sub IActiveIMMMessagePumpOwner_Start_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMMessagePumpOwner_End_Proxy(byval This as IActiveIMMMessagePumpOwner ptr) as HRESULT
declare sub IActiveIMMMessagePumpOwner_End_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMMessagePumpOwner_OnTranslateMessage_Proxy(byval This as IActiveIMMMessagePumpOwner ptr, byval pMsg as const MSG ptr) as HRESULT
declare sub IActiveIMMMessagePumpOwner_OnTranslateMessage_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMMessagePumpOwner_Pause_Proxy(byval This as IActiveIMMMessagePumpOwner ptr, byval pdwCookie as DWORD ptr) as HRESULT
declare sub IActiveIMMMessagePumpOwner_Pause_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMMessagePumpOwner_Resume_Proxy(byval This as IActiveIMMMessagePumpOwner ptr, byval dwCookie as DWORD) as HRESULT
declare sub IActiveIMMMessagePumpOwner_Resume_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IActiveIMMApp_INTERFACE_DEFINED__
extern IID_IActiveIMMApp as const IID
type IActiveIMMApp as IActiveIMMApp_

type IActiveIMMAppVtbl
	QueryInterface as function(byval This as IActiveIMMApp ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IActiveIMMApp ptr) as ULONG
	Release as function(byval This as IActiveIMMApp ptr) as ULONG
	AssociateContext as function(byval This as IActiveIMMApp ptr, byval hWnd as HWND, byval hIME as HIMC, byval phPrev as HIMC ptr) as HRESULT
	ConfigureIMEA as function(byval This as IActiveIMMApp ptr, byval hKL as HKL, byval hWnd as HWND, byval dwMode as DWORD, byval pData as REGISTERWORDA ptr) as HRESULT
	ConfigureIMEW as function(byval This as IActiveIMMApp ptr, byval hKL as HKL, byval hWnd as HWND, byval dwMode as DWORD, byval pData as REGISTERWORDW ptr) as HRESULT
	CreateContext as function(byval This as IActiveIMMApp ptr, byval phIMC as HIMC ptr) as HRESULT
	DestroyContext as function(byval This as IActiveIMMApp ptr, byval hIME as HIMC) as HRESULT
	EnumRegisterWordA as function(byval This as IActiveIMMApp ptr, byval hKL as HKL, byval szReading as LPSTR, byval dwStyle as DWORD, byval szRegister as LPSTR, byval pData as LPVOID, byval pEnum as IEnumRegisterWordA ptr ptr) as HRESULT
	EnumRegisterWordW as function(byval This as IActiveIMMApp ptr, byval hKL as HKL, byval szReading as LPWSTR, byval dwStyle as DWORD, byval szRegister as LPWSTR, byval pData as LPVOID, byval pEnum as IEnumRegisterWordW ptr ptr) as HRESULT
	EscapeA as function(byval This as IActiveIMMApp ptr, byval hKL as HKL, byval hIMC as HIMC, byval uEscape as UINT, byval pData as LPVOID, byval plResult as LRESULT ptr) as HRESULT
	EscapeW as function(byval This as IActiveIMMApp ptr, byval hKL as HKL, byval hIMC as HIMC, byval uEscape as UINT, byval pData as LPVOID, byval plResult as LRESULT ptr) as HRESULT
	GetCandidateListA as function(byval This as IActiveIMMApp ptr, byval hIMC as HIMC, byval dwIndex as DWORD, byval uBufLen as UINT, byval pCandList as CANDIDATELIST ptr, byval puCopied as UINT ptr) as HRESULT
	GetCandidateListW as function(byval This as IActiveIMMApp ptr, byval hIMC as HIMC, byval dwIndex as DWORD, byval uBufLen as UINT, byval pCandList as CANDIDATELIST ptr, byval puCopied as UINT ptr) as HRESULT
	GetCandidateListCountA as function(byval This as IActiveIMMApp ptr, byval hIMC as HIMC, byval pdwListSize as DWORD ptr, byval pdwBufLen as DWORD ptr) as HRESULT
	GetCandidateListCountW as function(byval This as IActiveIMMApp ptr, byval hIMC as HIMC, byval pdwListSize as DWORD ptr, byval pdwBufLen as DWORD ptr) as HRESULT
	GetCandidateWindow as function(byval This as IActiveIMMApp ptr, byval hIMC as HIMC, byval dwIndex as DWORD, byval pCandidate as CANDIDATEFORM ptr) as HRESULT
	GetCompositionFontA as function(byval This as IActiveIMMApp ptr, byval hIMC as HIMC, byval plf as LOGFONTA ptr) as HRESULT
	GetCompositionFontW as function(byval This as IActiveIMMApp ptr, byval hIMC as HIMC, byval plf as LOGFONTW ptr) as HRESULT
	GetCompositionStringA as function(byval This as IActiveIMMApp ptr, byval hIMC as HIMC, byval dwIndex as DWORD, byval dwBufLen as DWORD, byval plCopied as LONG ptr, byval pBuf as LPVOID) as HRESULT
	GetCompositionStringW as function(byval This as IActiveIMMApp ptr, byval hIMC as HIMC, byval dwIndex as DWORD, byval dwBufLen as DWORD, byval plCopied as LONG ptr, byval pBuf as LPVOID) as HRESULT
	GetCompositionWindow as function(byval This as IActiveIMMApp ptr, byval hIMC as HIMC, byval pCompForm as COMPOSITIONFORM ptr) as HRESULT
	GetContext as function(byval This as IActiveIMMApp ptr, byval hWnd as HWND, byval phIMC as HIMC ptr) as HRESULT
	GetConversionListA as function(byval This as IActiveIMMApp ptr, byval hKL as HKL, byval hIMC as HIMC, byval pSrc as LPSTR, byval uBufLen as UINT, byval uFlag as UINT, byval pDst as CANDIDATELIST ptr, byval puCopied as UINT ptr) as HRESULT
	GetConversionListW as function(byval This as IActiveIMMApp ptr, byval hKL as HKL, byval hIMC as HIMC, byval pSrc as LPWSTR, byval uBufLen as UINT, byval uFlag as UINT, byval pDst as CANDIDATELIST ptr, byval puCopied as UINT ptr) as HRESULT
	GetConversionStatus as function(byval This as IActiveIMMApp ptr, byval hIMC as HIMC, byval pfdwConversion as DWORD ptr, byval pfdwSentence as DWORD ptr) as HRESULT
	GetDefaultIMEWnd as function(byval This as IActiveIMMApp ptr, byval hWnd as HWND, byval phDefWnd as HWND ptr) as HRESULT
	GetDescriptionA as function(byval This as IActiveIMMApp ptr, byval hKL as HKL, byval uBufLen as UINT, byval szDescription as LPSTR, byval puCopied as UINT ptr) as HRESULT
	GetDescriptionW as function(byval This as IActiveIMMApp ptr, byval hKL as HKL, byval uBufLen as UINT, byval szDescription as LPWSTR, byval puCopied as UINT ptr) as HRESULT
	GetGuideLineA as function(byval This as IActiveIMMApp ptr, byval hIMC as HIMC, byval dwIndex as DWORD, byval dwBufLen as DWORD, byval pBuf as LPSTR, byval pdwResult as DWORD ptr) as HRESULT
	GetGuideLineW as function(byval This as IActiveIMMApp ptr, byval hIMC as HIMC, byval dwIndex as DWORD, byval dwBufLen as DWORD, byval pBuf as LPWSTR, byval pdwResult as DWORD ptr) as HRESULT
	GetIMEFileNameA as function(byval This as IActiveIMMApp ptr, byval hKL as HKL, byval uBufLen as UINT, byval szFileName as LPSTR, byval puCopied as UINT ptr) as HRESULT
	GetIMEFileNameW as function(byval This as IActiveIMMApp ptr, byval hKL as HKL, byval uBufLen as UINT, byval szFileName as LPWSTR, byval puCopied as UINT ptr) as HRESULT
	GetOpenStatus as function(byval This as IActiveIMMApp ptr, byval hIMC as HIMC) as HRESULT
	GetProperty as function(byval This as IActiveIMMApp ptr, byval hKL as HKL, byval fdwIndex as DWORD, byval pdwProperty as DWORD ptr) as HRESULT
	GetRegisterWordStyleA as function(byval This as IActiveIMMApp ptr, byval hKL as HKL, byval nItem as UINT, byval pStyleBuf as STYLEBUFA ptr, byval puCopied as UINT ptr) as HRESULT
	GetRegisterWordStyleW as function(byval This as IActiveIMMApp ptr, byval hKL as HKL, byval nItem as UINT, byval pStyleBuf as STYLEBUFW ptr, byval puCopied as UINT ptr) as HRESULT
	GetStatusWindowPos as function(byval This as IActiveIMMApp ptr, byval hIMC as HIMC, byval pptPos as POINT ptr) as HRESULT
	GetVirtualKey as function(byval This as IActiveIMMApp ptr, byval hWnd as HWND, byval puVirtualKey as UINT ptr) as HRESULT
	InstallIMEA as function(byval This as IActiveIMMApp ptr, byval szIMEFileName as LPSTR, byval szLayoutText as LPSTR, byval phKL as HKL ptr) as HRESULT
	InstallIMEW as function(byval This as IActiveIMMApp ptr, byval szIMEFileName as LPWSTR, byval szLayoutText as LPWSTR, byval phKL as HKL ptr) as HRESULT
	IsIME as function(byval This as IActiveIMMApp ptr, byval hKL as HKL) as HRESULT
	IsUIMessageA as function(byval This as IActiveIMMApp ptr, byval hWndIME as HWND, byval msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as HRESULT
	IsUIMessageW as function(byval This as IActiveIMMApp ptr, byval hWndIME as HWND, byval msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as HRESULT
	NotifyIME as function(byval This as IActiveIMMApp ptr, byval hIMC as HIMC, byval dwAction as DWORD, byval dwIndex as DWORD, byval dwValue as DWORD) as HRESULT
	RegisterWordA as function(byval This as IActiveIMMApp ptr, byval hKL as HKL, byval szReading as LPSTR, byval dwStyle as DWORD, byval szRegister as LPSTR) as HRESULT
	RegisterWordW as function(byval This as IActiveIMMApp ptr, byval hKL as HKL, byval szReading as LPWSTR, byval dwStyle as DWORD, byval szRegister as LPWSTR) as HRESULT
	ReleaseContext as function(byval This as IActiveIMMApp ptr, byval hWnd as HWND, byval hIMC as HIMC) as HRESULT
	SetCandidateWindow as function(byval This as IActiveIMMApp ptr, byval hIMC as HIMC, byval pCandidate as CANDIDATEFORM ptr) as HRESULT
	SetCompositionFontA as function(byval This as IActiveIMMApp ptr, byval hIMC as HIMC, byval plf as LOGFONTA ptr) as HRESULT
	SetCompositionFontW as function(byval This as IActiveIMMApp ptr, byval hIMC as HIMC, byval plf as LOGFONTW ptr) as HRESULT
	SetCompositionStringA as function(byval This as IActiveIMMApp ptr, byval hIMC as HIMC, byval dwIndex as DWORD, byval pComp as LPVOID, byval dwCompLen as DWORD, byval pRead as LPVOID, byval dwReadLen as DWORD) as HRESULT
	SetCompositionStringW as function(byval This as IActiveIMMApp ptr, byval hIMC as HIMC, byval dwIndex as DWORD, byval pComp as LPVOID, byval dwCompLen as DWORD, byval pRead as LPVOID, byval dwReadLen as DWORD) as HRESULT
	SetCompositionWindow as function(byval This as IActiveIMMApp ptr, byval hIMC as HIMC, byval pCompForm as COMPOSITIONFORM ptr) as HRESULT
	SetConversionStatus as function(byval This as IActiveIMMApp ptr, byval hIMC as HIMC, byval fdwConversion as DWORD, byval fdwSentence as DWORD) as HRESULT
	SetOpenStatus as function(byval This as IActiveIMMApp ptr, byval hIMC as HIMC, byval fOpen as WINBOOL) as HRESULT
	SetStatusWindowPos as function(byval This as IActiveIMMApp ptr, byval hIMC as HIMC, byval pptPos as POINT ptr) as HRESULT
	SimulateHotKey as function(byval This as IActiveIMMApp ptr, byval hWnd as HWND, byval dwHotKeyID as DWORD) as HRESULT
	UnregisterWordA as function(byval This as IActiveIMMApp ptr, byval hKL as HKL, byval szReading as LPSTR, byval dwStyle as DWORD, byval szUnregister as LPSTR) as HRESULT
	UnregisterWordW as function(byval This as IActiveIMMApp ptr, byval hKL as HKL, byval szReading as LPWSTR, byval dwStyle as DWORD, byval szUnregister as LPWSTR) as HRESULT
	Activate as function(byval This as IActiveIMMApp ptr, byval fRestoreLayout as WINBOOL) as HRESULT
	Deactivate as function(byval This as IActiveIMMApp ptr) as HRESULT
	OnDefWindowProc as function(byval This as IActiveIMMApp ptr, byval hWnd as HWND, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM, byval plResult as LRESULT ptr) as HRESULT
	FilterClientWindows as function(byval This as IActiveIMMApp ptr, byval aaClassList as ATOM ptr, byval uSize as UINT) as HRESULT
	GetCodePageA as function(byval This as IActiveIMMApp ptr, byval hKL as HKL, byval uCodePage as UINT ptr) as HRESULT
	GetLangId as function(byval This as IActiveIMMApp ptr, byval hKL as HKL, byval plid as LANGID ptr) as HRESULT
	AssociateContextEx as function(byval This as IActiveIMMApp ptr, byval hWnd as HWND, byval hIMC as HIMC, byval dwFlags as DWORD) as HRESULT
	DisableIME as function(byval This as IActiveIMMApp ptr, byval idThread as DWORD) as HRESULT
	GetImeMenuItemsA as function(byval This as IActiveIMMApp ptr, byval hIMC as HIMC, byval dwFlags as DWORD, byval dwType as DWORD, byval pImeParentMenu as IMEMENUITEMINFOA ptr, byval pImeMenu as IMEMENUITEMINFOA ptr, byval dwSize as DWORD, byval pdwResult as DWORD ptr) as HRESULT
	GetImeMenuItemsW as function(byval This as IActiveIMMApp ptr, byval hIMC as HIMC, byval dwFlags as DWORD, byval dwType as DWORD, byval pImeParentMenu as IMEMENUITEMINFOW ptr, byval pImeMenu as IMEMENUITEMINFOW ptr, byval dwSize as DWORD, byval pdwResult as DWORD ptr) as HRESULT
	EnumInputContext as function(byval This as IActiveIMMApp ptr, byval idThread as DWORD, byval ppEnum as IEnumInputContext ptr ptr) as HRESULT
end type

type IActiveIMMApp_
	lpVtbl as IActiveIMMAppVtbl ptr
end type

declare function IActiveIMMApp_AssociateContext_Proxy(byval This as IActiveIMMApp ptr, byval hWnd as HWND, byval hIME as HIMC, byval phPrev as HIMC ptr) as HRESULT
declare sub IActiveIMMApp_AssociateContext_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_ConfigureIMEA_Proxy(byval This as IActiveIMMApp ptr, byval hKL as HKL, byval hWnd as HWND, byval dwMode as DWORD, byval pData as REGISTERWORDA ptr) as HRESULT
declare sub IActiveIMMApp_ConfigureIMEA_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_ConfigureIMEW_Proxy(byval This as IActiveIMMApp ptr, byval hKL as HKL, byval hWnd as HWND, byval dwMode as DWORD, byval pData as REGISTERWORDW ptr) as HRESULT
declare sub IActiveIMMApp_ConfigureIMEW_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_CreateContext_Proxy(byval This as IActiveIMMApp ptr, byval phIMC as HIMC ptr) as HRESULT
declare sub IActiveIMMApp_CreateContext_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_DestroyContext_Proxy(byval This as IActiveIMMApp ptr, byval hIME as HIMC) as HRESULT
declare sub IActiveIMMApp_DestroyContext_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_EnumRegisterWordA_Proxy(byval This as IActiveIMMApp ptr, byval hKL as HKL, byval szReading as LPSTR, byval dwStyle as DWORD, byval szRegister as LPSTR, byval pData as LPVOID, byval pEnum as IEnumRegisterWordA ptr ptr) as HRESULT
declare sub IActiveIMMApp_EnumRegisterWordA_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_EnumRegisterWordW_Proxy(byval This as IActiveIMMApp ptr, byval hKL as HKL, byval szReading as LPWSTR, byval dwStyle as DWORD, byval szRegister as LPWSTR, byval pData as LPVOID, byval pEnum as IEnumRegisterWordW ptr ptr) as HRESULT
declare sub IActiveIMMApp_EnumRegisterWordW_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_EscapeA_Proxy(byval This as IActiveIMMApp ptr, byval hKL as HKL, byval hIMC as HIMC, byval uEscape as UINT, byval pData as LPVOID, byval plResult as LRESULT ptr) as HRESULT
declare sub IActiveIMMApp_EscapeA_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_EscapeW_Proxy(byval This as IActiveIMMApp ptr, byval hKL as HKL, byval hIMC as HIMC, byval uEscape as UINT, byval pData as LPVOID, byval plResult as LRESULT ptr) as HRESULT
declare sub IActiveIMMApp_EscapeW_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_GetCandidateListA_Proxy(byval This as IActiveIMMApp ptr, byval hIMC as HIMC, byval dwIndex as DWORD, byval uBufLen as UINT, byval pCandList as CANDIDATELIST ptr, byval puCopied as UINT ptr) as HRESULT
declare sub IActiveIMMApp_GetCandidateListA_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_GetCandidateListW_Proxy(byval This as IActiveIMMApp ptr, byval hIMC as HIMC, byval dwIndex as DWORD, byval uBufLen as UINT, byval pCandList as CANDIDATELIST ptr, byval puCopied as UINT ptr) as HRESULT
declare sub IActiveIMMApp_GetCandidateListW_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_GetCandidateListCountA_Proxy(byval This as IActiveIMMApp ptr, byval hIMC as HIMC, byval pdwListSize as DWORD ptr, byval pdwBufLen as DWORD ptr) as HRESULT
declare sub IActiveIMMApp_GetCandidateListCountA_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_GetCandidateListCountW_Proxy(byval This as IActiveIMMApp ptr, byval hIMC as HIMC, byval pdwListSize as DWORD ptr, byval pdwBufLen as DWORD ptr) as HRESULT
declare sub IActiveIMMApp_GetCandidateListCountW_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_GetCandidateWindow_Proxy(byval This as IActiveIMMApp ptr, byval hIMC as HIMC, byval dwIndex as DWORD, byval pCandidate as CANDIDATEFORM ptr) as HRESULT
declare sub IActiveIMMApp_GetCandidateWindow_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_GetCompositionFontA_Proxy(byval This as IActiveIMMApp ptr, byval hIMC as HIMC, byval plf as LOGFONTA ptr) as HRESULT
declare sub IActiveIMMApp_GetCompositionFontA_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_GetCompositionFontW_Proxy(byval This as IActiveIMMApp ptr, byval hIMC as HIMC, byval plf as LOGFONTW ptr) as HRESULT
declare sub IActiveIMMApp_GetCompositionFontW_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_GetCompositionStringA_Proxy(byval This as IActiveIMMApp ptr, byval hIMC as HIMC, byval dwIndex as DWORD, byval dwBufLen as DWORD, byval plCopied as LONG ptr, byval pBuf as LPVOID) as HRESULT
declare sub IActiveIMMApp_GetCompositionStringA_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_GetCompositionStringW_Proxy(byval This as IActiveIMMApp ptr, byval hIMC as HIMC, byval dwIndex as DWORD, byval dwBufLen as DWORD, byval plCopied as LONG ptr, byval pBuf as LPVOID) as HRESULT
declare sub IActiveIMMApp_GetCompositionStringW_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_GetCompositionWindow_Proxy(byval This as IActiveIMMApp ptr, byval hIMC as HIMC, byval pCompForm as COMPOSITIONFORM ptr) as HRESULT
declare sub IActiveIMMApp_GetCompositionWindow_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_GetContext_Proxy(byval This as IActiveIMMApp ptr, byval hWnd as HWND, byval phIMC as HIMC ptr) as HRESULT
declare sub IActiveIMMApp_GetContext_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_GetConversionListA_Proxy(byval This as IActiveIMMApp ptr, byval hKL as HKL, byval hIMC as HIMC, byval pSrc as LPSTR, byval uBufLen as UINT, byval uFlag as UINT, byval pDst as CANDIDATELIST ptr, byval puCopied as UINT ptr) as HRESULT
declare sub IActiveIMMApp_GetConversionListA_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_GetConversionListW_Proxy(byval This as IActiveIMMApp ptr, byval hKL as HKL, byval hIMC as HIMC, byval pSrc as LPWSTR, byval uBufLen as UINT, byval uFlag as UINT, byval pDst as CANDIDATELIST ptr, byval puCopied as UINT ptr) as HRESULT
declare sub IActiveIMMApp_GetConversionListW_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_GetConversionStatus_Proxy(byval This as IActiveIMMApp ptr, byval hIMC as HIMC, byval pfdwConversion as DWORD ptr, byval pfdwSentence as DWORD ptr) as HRESULT
declare sub IActiveIMMApp_GetConversionStatus_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_GetDefaultIMEWnd_Proxy(byval This as IActiveIMMApp ptr, byval hWnd as HWND, byval phDefWnd as HWND ptr) as HRESULT
declare sub IActiveIMMApp_GetDefaultIMEWnd_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_GetDescriptionA_Proxy(byval This as IActiveIMMApp ptr, byval hKL as HKL, byval uBufLen as UINT, byval szDescription as LPSTR, byval puCopied as UINT ptr) as HRESULT
declare sub IActiveIMMApp_GetDescriptionA_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_GetDescriptionW_Proxy(byval This as IActiveIMMApp ptr, byval hKL as HKL, byval uBufLen as UINT, byval szDescription as LPWSTR, byval puCopied as UINT ptr) as HRESULT
declare sub IActiveIMMApp_GetDescriptionW_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_GetGuideLineA_Proxy(byval This as IActiveIMMApp ptr, byval hIMC as HIMC, byval dwIndex as DWORD, byval dwBufLen as DWORD, byval pBuf as LPSTR, byval pdwResult as DWORD ptr) as HRESULT
declare sub IActiveIMMApp_GetGuideLineA_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_GetGuideLineW_Proxy(byval This as IActiveIMMApp ptr, byval hIMC as HIMC, byval dwIndex as DWORD, byval dwBufLen as DWORD, byval pBuf as LPWSTR, byval pdwResult as DWORD ptr) as HRESULT
declare sub IActiveIMMApp_GetGuideLineW_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_GetIMEFileNameA_Proxy(byval This as IActiveIMMApp ptr, byval hKL as HKL, byval uBufLen as UINT, byval szFileName as LPSTR, byval puCopied as UINT ptr) as HRESULT
declare sub IActiveIMMApp_GetIMEFileNameA_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_GetIMEFileNameW_Proxy(byval This as IActiveIMMApp ptr, byval hKL as HKL, byval uBufLen as UINT, byval szFileName as LPWSTR, byval puCopied as UINT ptr) as HRESULT
declare sub IActiveIMMApp_GetIMEFileNameW_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_GetOpenStatus_Proxy(byval This as IActiveIMMApp ptr, byval hIMC as HIMC) as HRESULT
declare sub IActiveIMMApp_GetOpenStatus_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_GetProperty_Proxy(byval This as IActiveIMMApp ptr, byval hKL as HKL, byval fdwIndex as DWORD, byval pdwProperty as DWORD ptr) as HRESULT
declare sub IActiveIMMApp_GetProperty_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_GetRegisterWordStyleA_Proxy(byval This as IActiveIMMApp ptr, byval hKL as HKL, byval nItem as UINT, byval pStyleBuf as STYLEBUFA ptr, byval puCopied as UINT ptr) as HRESULT
declare sub IActiveIMMApp_GetRegisterWordStyleA_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_GetRegisterWordStyleW_Proxy(byval This as IActiveIMMApp ptr, byval hKL as HKL, byval nItem as UINT, byval pStyleBuf as STYLEBUFW ptr, byval puCopied as UINT ptr) as HRESULT
declare sub IActiveIMMApp_GetRegisterWordStyleW_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_GetStatusWindowPos_Proxy(byval This as IActiveIMMApp ptr, byval hIMC as HIMC, byval pptPos as POINT ptr) as HRESULT
declare sub IActiveIMMApp_GetStatusWindowPos_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_GetVirtualKey_Proxy(byval This as IActiveIMMApp ptr, byval hWnd as HWND, byval puVirtualKey as UINT ptr) as HRESULT
declare sub IActiveIMMApp_GetVirtualKey_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_InstallIMEA_Proxy(byval This as IActiveIMMApp ptr, byval szIMEFileName as LPSTR, byval szLayoutText as LPSTR, byval phKL as HKL ptr) as HRESULT
declare sub IActiveIMMApp_InstallIMEA_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_InstallIMEW_Proxy(byval This as IActiveIMMApp ptr, byval szIMEFileName as LPWSTR, byval szLayoutText as LPWSTR, byval phKL as HKL ptr) as HRESULT
declare sub IActiveIMMApp_InstallIMEW_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_IsIME_Proxy(byval This as IActiveIMMApp ptr, byval hKL as HKL) as HRESULT
declare sub IActiveIMMApp_IsIME_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_IsUIMessageA_Proxy(byval This as IActiveIMMApp ptr, byval hWndIME as HWND, byval msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as HRESULT
declare sub IActiveIMMApp_IsUIMessageA_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_IsUIMessageW_Proxy(byval This as IActiveIMMApp ptr, byval hWndIME as HWND, byval msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as HRESULT
declare sub IActiveIMMApp_IsUIMessageW_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_NotifyIME_Proxy(byval This as IActiveIMMApp ptr, byval hIMC as HIMC, byval dwAction as DWORD, byval dwIndex as DWORD, byval dwValue as DWORD) as HRESULT
declare sub IActiveIMMApp_NotifyIME_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_RegisterWordA_Proxy(byval This as IActiveIMMApp ptr, byval hKL as HKL, byval szReading as LPSTR, byval dwStyle as DWORD, byval szRegister as LPSTR) as HRESULT
declare sub IActiveIMMApp_RegisterWordA_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_RegisterWordW_Proxy(byval This as IActiveIMMApp ptr, byval hKL as HKL, byval szReading as LPWSTR, byval dwStyle as DWORD, byval szRegister as LPWSTR) as HRESULT
declare sub IActiveIMMApp_RegisterWordW_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_ReleaseContext_Proxy(byval This as IActiveIMMApp ptr, byval hWnd as HWND, byval hIMC as HIMC) as HRESULT
declare sub IActiveIMMApp_ReleaseContext_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_SetCandidateWindow_Proxy(byval This as IActiveIMMApp ptr, byval hIMC as HIMC, byval pCandidate as CANDIDATEFORM ptr) as HRESULT
declare sub IActiveIMMApp_SetCandidateWindow_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_SetCompositionFontA_Proxy(byval This as IActiveIMMApp ptr, byval hIMC as HIMC, byval plf as LOGFONTA ptr) as HRESULT
declare sub IActiveIMMApp_SetCompositionFontA_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_SetCompositionFontW_Proxy(byval This as IActiveIMMApp ptr, byval hIMC as HIMC, byval plf as LOGFONTW ptr) as HRESULT
declare sub IActiveIMMApp_SetCompositionFontW_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_SetCompositionStringA_Proxy(byval This as IActiveIMMApp ptr, byval hIMC as HIMC, byval dwIndex as DWORD, byval pComp as LPVOID, byval dwCompLen as DWORD, byval pRead as LPVOID, byval dwReadLen as DWORD) as HRESULT
declare sub IActiveIMMApp_SetCompositionStringA_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_SetCompositionStringW_Proxy(byval This as IActiveIMMApp ptr, byval hIMC as HIMC, byval dwIndex as DWORD, byval pComp as LPVOID, byval dwCompLen as DWORD, byval pRead as LPVOID, byval dwReadLen as DWORD) as HRESULT
declare sub IActiveIMMApp_SetCompositionStringW_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_SetCompositionWindow_Proxy(byval This as IActiveIMMApp ptr, byval hIMC as HIMC, byval pCompForm as COMPOSITIONFORM ptr) as HRESULT
declare sub IActiveIMMApp_SetCompositionWindow_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_SetConversionStatus_Proxy(byval This as IActiveIMMApp ptr, byval hIMC as HIMC, byval fdwConversion as DWORD, byval fdwSentence as DWORD) as HRESULT
declare sub IActiveIMMApp_SetConversionStatus_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_SetOpenStatus_Proxy(byval This as IActiveIMMApp ptr, byval hIMC as HIMC, byval fOpen as WINBOOL) as HRESULT
declare sub IActiveIMMApp_SetOpenStatus_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_SetStatusWindowPos_Proxy(byval This as IActiveIMMApp ptr, byval hIMC as HIMC, byval pptPos as POINT ptr) as HRESULT
declare sub IActiveIMMApp_SetStatusWindowPos_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_SimulateHotKey_Proxy(byval This as IActiveIMMApp ptr, byval hWnd as HWND, byval dwHotKeyID as DWORD) as HRESULT
declare sub IActiveIMMApp_SimulateHotKey_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_UnregisterWordA_Proxy(byval This as IActiveIMMApp ptr, byval hKL as HKL, byval szReading as LPSTR, byval dwStyle as DWORD, byval szUnregister as LPSTR) as HRESULT
declare sub IActiveIMMApp_UnregisterWordA_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_UnregisterWordW_Proxy(byval This as IActiveIMMApp ptr, byval hKL as HKL, byval szReading as LPWSTR, byval dwStyle as DWORD, byval szUnregister as LPWSTR) as HRESULT
declare sub IActiveIMMApp_UnregisterWordW_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_Activate_Proxy(byval This as IActiveIMMApp ptr, byval fRestoreLayout as WINBOOL) as HRESULT
declare sub IActiveIMMApp_Activate_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_Deactivate_Proxy(byval This as IActiveIMMApp ptr) as HRESULT
declare sub IActiveIMMApp_Deactivate_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_OnDefWindowProc_Proxy(byval This as IActiveIMMApp ptr, byval hWnd as HWND, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM, byval plResult as LRESULT ptr) as HRESULT
declare sub IActiveIMMApp_OnDefWindowProc_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_FilterClientWindows_Proxy(byval This as IActiveIMMApp ptr, byval aaClassList as ATOM ptr, byval uSize as UINT) as HRESULT
declare sub IActiveIMMApp_FilterClientWindows_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_GetCodePageA_Proxy(byval This as IActiveIMMApp ptr, byval hKL as HKL, byval uCodePage as UINT ptr) as HRESULT
declare sub IActiveIMMApp_GetCodePageA_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_GetLangId_Proxy(byval This as IActiveIMMApp ptr, byval hKL as HKL, byval plid as LANGID ptr) as HRESULT
declare sub IActiveIMMApp_GetLangId_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_AssociateContextEx_Proxy(byval This as IActiveIMMApp ptr, byval hWnd as HWND, byval hIMC as HIMC, byval dwFlags as DWORD) as HRESULT
declare sub IActiveIMMApp_AssociateContextEx_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_DisableIME_Proxy(byval This as IActiveIMMApp ptr, byval idThread as DWORD) as HRESULT
declare sub IActiveIMMApp_DisableIME_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_GetImeMenuItemsA_Proxy(byval This as IActiveIMMApp ptr, byval hIMC as HIMC, byval dwFlags as DWORD, byval dwType as DWORD, byval pImeParentMenu as IMEMENUITEMINFOA ptr, byval pImeMenu as IMEMENUITEMINFOA ptr, byval dwSize as DWORD, byval pdwResult as DWORD ptr) as HRESULT
declare sub IActiveIMMApp_GetImeMenuItemsA_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_GetImeMenuItemsW_Proxy(byval This as IActiveIMMApp ptr, byval hIMC as HIMC, byval dwFlags as DWORD, byval dwType as DWORD, byval pImeParentMenu as IMEMENUITEMINFOW ptr, byval pImeMenu as IMEMENUITEMINFOW ptr, byval dwSize as DWORD, byval pdwResult as DWORD ptr) as HRESULT
declare sub IActiveIMMApp_GetImeMenuItemsW_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMApp_EnumInputContext_Proxy(byval This as IActiveIMMApp ptr, byval idThread as DWORD, byval ppEnum as IEnumInputContext ptr ptr) as HRESULT
declare sub IActiveIMMApp_EnumInputContext_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IActiveIMMIME_INTERFACE_DEFINED__
extern IID_IActiveIMMIME as const IID
type IActiveIMMIME as IActiveIMMIME_

type IActiveIMMIMEVtbl
	QueryInterface as function(byval This as IActiveIMMIME ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IActiveIMMIME ptr) as ULONG
	Release as function(byval This as IActiveIMMIME ptr) as ULONG
	AssociateContext as function(byval This as IActiveIMMIME ptr, byval hWnd as HWND, byval hIME as HIMC, byval phPrev as HIMC ptr) as HRESULT
	ConfigureIMEA as function(byval This as IActiveIMMIME ptr, byval hKL as HKL, byval hWnd as HWND, byval dwMode as DWORD, byval pData as REGISTERWORDA ptr) as HRESULT
	ConfigureIMEW as function(byval This as IActiveIMMIME ptr, byval hKL as HKL, byval hWnd as HWND, byval dwMode as DWORD, byval pData as REGISTERWORDW ptr) as HRESULT
	CreateContext as function(byval This as IActiveIMMIME ptr, byval phIMC as HIMC ptr) as HRESULT
	DestroyContext as function(byval This as IActiveIMMIME ptr, byval hIME as HIMC) as HRESULT
	EnumRegisterWordA as function(byval This as IActiveIMMIME ptr, byval hKL as HKL, byval szReading as LPSTR, byval dwStyle as DWORD, byval szRegister as LPSTR, byval pData as LPVOID, byval pEnum as IEnumRegisterWordA ptr ptr) as HRESULT
	EnumRegisterWordW as function(byval This as IActiveIMMIME ptr, byval hKL as HKL, byval szReading as LPWSTR, byval dwStyle as DWORD, byval szRegister as LPWSTR, byval pData as LPVOID, byval pEnum as IEnumRegisterWordW ptr ptr) as HRESULT
	EscapeA as function(byval This as IActiveIMMIME ptr, byval hKL as HKL, byval hIMC as HIMC, byval uEscape as UINT, byval pData as LPVOID, byval plResult as LRESULT ptr) as HRESULT
	EscapeW as function(byval This as IActiveIMMIME ptr, byval hKL as HKL, byval hIMC as HIMC, byval uEscape as UINT, byval pData as LPVOID, byval plResult as LRESULT ptr) as HRESULT
	GetCandidateListA as function(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval dwIndex as DWORD, byval uBufLen as UINT, byval pCandList as CANDIDATELIST ptr, byval puCopied as UINT ptr) as HRESULT
	GetCandidateListW as function(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval dwIndex as DWORD, byval uBufLen as UINT, byval pCandList as CANDIDATELIST ptr, byval puCopied as UINT ptr) as HRESULT
	GetCandidateListCountA as function(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval pdwListSize as DWORD ptr, byval pdwBufLen as DWORD ptr) as HRESULT
	GetCandidateListCountW as function(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval pdwListSize as DWORD ptr, byval pdwBufLen as DWORD ptr) as HRESULT
	GetCandidateWindow as function(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval dwIndex as DWORD, byval pCandidate as CANDIDATEFORM ptr) as HRESULT
	GetCompositionFontA as function(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval plf as LOGFONTA ptr) as HRESULT
	GetCompositionFontW as function(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval plf as LOGFONTW ptr) as HRESULT
	GetCompositionStringA as function(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval dwIndex as DWORD, byval dwBufLen as DWORD, byval plCopied as LONG ptr, byval pBuf as LPVOID) as HRESULT
	GetCompositionStringW as function(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval dwIndex as DWORD, byval dwBufLen as DWORD, byval plCopied as LONG ptr, byval pBuf as LPVOID) as HRESULT
	GetCompositionWindow as function(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval pCompForm as COMPOSITIONFORM ptr) as HRESULT
	GetContext as function(byval This as IActiveIMMIME ptr, byval hWnd as HWND, byval phIMC as HIMC ptr) as HRESULT
	GetConversionListA as function(byval This as IActiveIMMIME ptr, byval hKL as HKL, byval hIMC as HIMC, byval pSrc as LPSTR, byval uBufLen as UINT, byval uFlag as UINT, byval pDst as CANDIDATELIST ptr, byval puCopied as UINT ptr) as HRESULT
	GetConversionListW as function(byval This as IActiveIMMIME ptr, byval hKL as HKL, byval hIMC as HIMC, byval pSrc as LPWSTR, byval uBufLen as UINT, byval uFlag as UINT, byval pDst as CANDIDATELIST ptr, byval puCopied as UINT ptr) as HRESULT
	GetConversionStatus as function(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval pfdwConversion as DWORD ptr, byval pfdwSentence as DWORD ptr) as HRESULT
	GetDefaultIMEWnd as function(byval This as IActiveIMMIME ptr, byval hWnd as HWND, byval phDefWnd as HWND ptr) as HRESULT
	GetDescriptionA as function(byval This as IActiveIMMIME ptr, byval hKL as HKL, byval uBufLen as UINT, byval szDescription as LPSTR, byval puCopied as UINT ptr) as HRESULT
	GetDescriptionW as function(byval This as IActiveIMMIME ptr, byval hKL as HKL, byval uBufLen as UINT, byval szDescription as LPWSTR, byval puCopied as UINT ptr) as HRESULT
	GetGuideLineA as function(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval dwIndex as DWORD, byval dwBufLen as DWORD, byval pBuf as LPSTR, byval pdwResult as DWORD ptr) as HRESULT
	GetGuideLineW as function(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval dwIndex as DWORD, byval dwBufLen as DWORD, byval pBuf as LPWSTR, byval pdwResult as DWORD ptr) as HRESULT
	GetIMEFileNameA as function(byval This as IActiveIMMIME ptr, byval hKL as HKL, byval uBufLen as UINT, byval szFileName as LPSTR, byval puCopied as UINT ptr) as HRESULT
	GetIMEFileNameW as function(byval This as IActiveIMMIME ptr, byval hKL as HKL, byval uBufLen as UINT, byval szFileName as LPWSTR, byval puCopied as UINT ptr) as HRESULT
	GetOpenStatus as function(byval This as IActiveIMMIME ptr, byval hIMC as HIMC) as HRESULT
	GetProperty as function(byval This as IActiveIMMIME ptr, byval hKL as HKL, byval fdwIndex as DWORD, byval pdwProperty as DWORD ptr) as HRESULT
	GetRegisterWordStyleA as function(byval This as IActiveIMMIME ptr, byval hKL as HKL, byval nItem as UINT, byval pStyleBuf as STYLEBUFA ptr, byval puCopied as UINT ptr) as HRESULT
	GetRegisterWordStyleW as function(byval This as IActiveIMMIME ptr, byval hKL as HKL, byval nItem as UINT, byval pStyleBuf as STYLEBUFW ptr, byval puCopied as UINT ptr) as HRESULT
	GetStatusWindowPos as function(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval pptPos as POINT ptr) as HRESULT
	GetVirtualKey as function(byval This as IActiveIMMIME ptr, byval hWnd as HWND, byval puVirtualKey as UINT ptr) as HRESULT
	InstallIMEA as function(byval This as IActiveIMMIME ptr, byval szIMEFileName as LPSTR, byval szLayoutText as LPSTR, byval phKL as HKL ptr) as HRESULT
	InstallIMEW as function(byval This as IActiveIMMIME ptr, byval szIMEFileName as LPWSTR, byval szLayoutText as LPWSTR, byval phKL as HKL ptr) as HRESULT
	IsIME as function(byval This as IActiveIMMIME ptr, byval hKL as HKL) as HRESULT
	IsUIMessageA as function(byval This as IActiveIMMIME ptr, byval hWndIME as HWND, byval msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as HRESULT
	IsUIMessageW as function(byval This as IActiveIMMIME ptr, byval hWndIME as HWND, byval msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as HRESULT
	NotifyIME as function(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval dwAction as DWORD, byval dwIndex as DWORD, byval dwValue as DWORD) as HRESULT
	RegisterWordA as function(byval This as IActiveIMMIME ptr, byval hKL as HKL, byval szReading as LPSTR, byval dwStyle as DWORD, byval szRegister as LPSTR) as HRESULT
	RegisterWordW as function(byval This as IActiveIMMIME ptr, byval hKL as HKL, byval szReading as LPWSTR, byval dwStyle as DWORD, byval szRegister as LPWSTR) as HRESULT
	ReleaseContext as function(byval This as IActiveIMMIME ptr, byval hWnd as HWND, byval hIMC as HIMC) as HRESULT
	SetCandidateWindow as function(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval pCandidate as CANDIDATEFORM ptr) as HRESULT
	SetCompositionFontA as function(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval plf as LOGFONTA ptr) as HRESULT
	SetCompositionFontW as function(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval plf as LOGFONTW ptr) as HRESULT
	SetCompositionStringA as function(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval dwIndex as DWORD, byval pComp as LPVOID, byval dwCompLen as DWORD, byval pRead as LPVOID, byval dwReadLen as DWORD) as HRESULT
	SetCompositionStringW as function(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval dwIndex as DWORD, byval pComp as LPVOID, byval dwCompLen as DWORD, byval pRead as LPVOID, byval dwReadLen as DWORD) as HRESULT
	SetCompositionWindow as function(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval pCompForm as COMPOSITIONFORM ptr) as HRESULT
	SetConversionStatus as function(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval fdwConversion as DWORD, byval fdwSentence as DWORD) as HRESULT
	SetOpenStatus as function(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval fOpen as WINBOOL) as HRESULT
	SetStatusWindowPos as function(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval pptPos as POINT ptr) as HRESULT
	SimulateHotKey as function(byval This as IActiveIMMIME ptr, byval hWnd as HWND, byval dwHotKeyID as DWORD) as HRESULT
	UnregisterWordA as function(byval This as IActiveIMMIME ptr, byval hKL as HKL, byval szReading as LPSTR, byval dwStyle as DWORD, byval szUnregister as LPSTR) as HRESULT
	UnregisterWordW as function(byval This as IActiveIMMIME ptr, byval hKL as HKL, byval szReading as LPWSTR, byval dwStyle as DWORD, byval szUnregister as LPWSTR) as HRESULT
	GenerateMessage as function(byval This as IActiveIMMIME ptr, byval hIMC as HIMC) as HRESULT
	LockIMC as function(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval ppIMC as INPUTCONTEXT ptr ptr) as HRESULT
	UnlockIMC as function(byval This as IActiveIMMIME ptr, byval hIMC as HIMC) as HRESULT
	GetIMCLockCount as function(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval pdwLockCount as DWORD ptr) as HRESULT
	CreateIMCC as function(byval This as IActiveIMMIME ptr, byval dwSize as DWORD, byval phIMCC as HIMCC ptr) as HRESULT
	DestroyIMCC as function(byval This as IActiveIMMIME ptr, byval hIMCC as HIMCC) as HRESULT
	LockIMCC as function(byval This as IActiveIMMIME ptr, byval hIMCC as HIMCC, byval ppv as any ptr ptr) as HRESULT
	UnlockIMCC as function(byval This as IActiveIMMIME ptr, byval hIMCC as HIMCC) as HRESULT
	ReSizeIMCC as function(byval This as IActiveIMMIME ptr, byval hIMCC as HIMCC, byval dwSize as DWORD, byval phIMCC as HIMCC ptr) as HRESULT
	GetIMCCSize as function(byval This as IActiveIMMIME ptr, byval hIMCC as HIMCC, byval pdwSize as DWORD ptr) as HRESULT
	GetIMCCLockCount as function(byval This as IActiveIMMIME ptr, byval hIMCC as HIMCC, byval pdwLockCount as DWORD ptr) as HRESULT
	GetHotKey as function(byval This as IActiveIMMIME ptr, byval dwHotKeyID as DWORD, byval puModifiers as UINT ptr, byval puVKey as UINT ptr, byval phKL as HKL ptr) as HRESULT
	SetHotKey as function(byval This as IActiveIMMIME ptr, byval dwHotKeyID as DWORD, byval uModifiers as UINT, byval uVKey as UINT, byval hKL as HKL) as HRESULT
	CreateSoftKeyboard as function(byval This as IActiveIMMIME ptr, byval uType as UINT, byval hOwner as HWND, byval x as long, byval y as long, byval phSoftKbdWnd as HWND ptr) as HRESULT
	DestroySoftKeyboard as function(byval This as IActiveIMMIME ptr, byval hSoftKbdWnd as HWND) as HRESULT
	ShowSoftKeyboard as function(byval This as IActiveIMMIME ptr, byval hSoftKbdWnd as HWND, byval nCmdShow as long) as HRESULT
	GetCodePageA as function(byval This as IActiveIMMIME ptr, byval hKL as HKL, byval uCodePage as UINT ptr) as HRESULT
	GetLangId as function(byval This as IActiveIMMIME ptr, byval hKL as HKL, byval plid as LANGID ptr) as HRESULT
	KeybdEvent as function(byval This as IActiveIMMIME ptr, byval lgidIME as LANGID, byval bVk as UBYTE, byval bScan as UBYTE, byval dwFlags as DWORD, byval dwExtraInfo as DWORD) as HRESULT
	LockModal as function(byval This as IActiveIMMIME ptr) as HRESULT
	UnlockModal as function(byval This as IActiveIMMIME ptr) as HRESULT
	AssociateContextEx as function(byval This as IActiveIMMIME ptr, byval hWnd as HWND, byval hIMC as HIMC, byval dwFlags as DWORD) as HRESULT
	DisableIME as function(byval This as IActiveIMMIME ptr, byval idThread as DWORD) as HRESULT
	GetImeMenuItemsA as function(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval dwFlags as DWORD, byval dwType as DWORD, byval pImeParentMenu as IMEMENUITEMINFOA ptr, byval pImeMenu as IMEMENUITEMINFOA ptr, byval dwSize as DWORD, byval pdwResult as DWORD ptr) as HRESULT
	GetImeMenuItemsW as function(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval dwFlags as DWORD, byval dwType as DWORD, byval pImeParentMenu as IMEMENUITEMINFOW ptr, byval pImeMenu as IMEMENUITEMINFOW ptr, byval dwSize as DWORD, byval pdwResult as DWORD ptr) as HRESULT
	EnumInputContext as function(byval This as IActiveIMMIME ptr, byval idThread as DWORD, byval ppEnum as IEnumInputContext ptr ptr) as HRESULT
	RequestMessageA as function(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval wParam as WPARAM, byval lParam as LPARAM, byval plResult as LRESULT ptr) as HRESULT
	RequestMessageW as function(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval wParam as WPARAM, byval lParam as LPARAM, byval plResult as LRESULT ptr) as HRESULT
	SendIMCA as function(byval This as IActiveIMMIME ptr, byval hWnd as HWND, byval uMsg as UINT, byval wParam as WPARAM, byval lParam as LPARAM, byval plResult as LRESULT ptr) as HRESULT
	SendIMCW as function(byval This as IActiveIMMIME ptr, byval hWnd as HWND, byval uMsg as UINT, byval wParam as WPARAM, byval lParam as LPARAM, byval plResult as LRESULT ptr) as HRESULT
	IsSleeping as function(byval This as IActiveIMMIME ptr) as HRESULT
end type

type IActiveIMMIME_
	lpVtbl as IActiveIMMIMEVtbl ptr
end type

declare function IActiveIMMIME_AssociateContext_Proxy(byval This as IActiveIMMIME ptr, byval hWnd as HWND, byval hIME as HIMC, byval phPrev as HIMC ptr) as HRESULT
declare sub IActiveIMMIME_AssociateContext_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_ConfigureIMEA_Proxy(byval This as IActiveIMMIME ptr, byval hKL as HKL, byval hWnd as HWND, byval dwMode as DWORD, byval pData as REGISTERWORDA ptr) as HRESULT
declare sub IActiveIMMIME_ConfigureIMEA_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_ConfigureIMEW_Proxy(byval This as IActiveIMMIME ptr, byval hKL as HKL, byval hWnd as HWND, byval dwMode as DWORD, byval pData as REGISTERWORDW ptr) as HRESULT
declare sub IActiveIMMIME_ConfigureIMEW_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_CreateContext_Proxy(byval This as IActiveIMMIME ptr, byval phIMC as HIMC ptr) as HRESULT
declare sub IActiveIMMIME_CreateContext_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_DestroyContext_Proxy(byval This as IActiveIMMIME ptr, byval hIME as HIMC) as HRESULT
declare sub IActiveIMMIME_DestroyContext_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_EnumRegisterWordA_Proxy(byval This as IActiveIMMIME ptr, byval hKL as HKL, byval szReading as LPSTR, byval dwStyle as DWORD, byval szRegister as LPSTR, byval pData as LPVOID, byval pEnum as IEnumRegisterWordA ptr ptr) as HRESULT
declare sub IActiveIMMIME_EnumRegisterWordA_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_EnumRegisterWordW_Proxy(byval This as IActiveIMMIME ptr, byval hKL as HKL, byval szReading as LPWSTR, byval dwStyle as DWORD, byval szRegister as LPWSTR, byval pData as LPVOID, byval pEnum as IEnumRegisterWordW ptr ptr) as HRESULT
declare sub IActiveIMMIME_EnumRegisterWordW_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_EscapeA_Proxy(byval This as IActiveIMMIME ptr, byval hKL as HKL, byval hIMC as HIMC, byval uEscape as UINT, byval pData as LPVOID, byval plResult as LRESULT ptr) as HRESULT
declare sub IActiveIMMIME_EscapeA_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_EscapeW_Proxy(byval This as IActiveIMMIME ptr, byval hKL as HKL, byval hIMC as HIMC, byval uEscape as UINT, byval pData as LPVOID, byval plResult as LRESULT ptr) as HRESULT
declare sub IActiveIMMIME_EscapeW_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_GetCandidateListA_Proxy(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval dwIndex as DWORD, byval uBufLen as UINT, byval pCandList as CANDIDATELIST ptr, byval puCopied as UINT ptr) as HRESULT
declare sub IActiveIMMIME_GetCandidateListA_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_GetCandidateListW_Proxy(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval dwIndex as DWORD, byval uBufLen as UINT, byval pCandList as CANDIDATELIST ptr, byval puCopied as UINT ptr) as HRESULT
declare sub IActiveIMMIME_GetCandidateListW_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_GetCandidateListCountA_Proxy(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval pdwListSize as DWORD ptr, byval pdwBufLen as DWORD ptr) as HRESULT
declare sub IActiveIMMIME_GetCandidateListCountA_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_GetCandidateListCountW_Proxy(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval pdwListSize as DWORD ptr, byval pdwBufLen as DWORD ptr) as HRESULT
declare sub IActiveIMMIME_GetCandidateListCountW_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_GetCandidateWindow_Proxy(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval dwIndex as DWORD, byval pCandidate as CANDIDATEFORM ptr) as HRESULT
declare sub IActiveIMMIME_GetCandidateWindow_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_GetCompositionFontA_Proxy(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval plf as LOGFONTA ptr) as HRESULT
declare sub IActiveIMMIME_GetCompositionFontA_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_GetCompositionFontW_Proxy(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval plf as LOGFONTW ptr) as HRESULT
declare sub IActiveIMMIME_GetCompositionFontW_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_GetCompositionStringA_Proxy(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval dwIndex as DWORD, byval dwBufLen as DWORD, byval plCopied as LONG ptr, byval pBuf as LPVOID) as HRESULT
declare sub IActiveIMMIME_GetCompositionStringA_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_GetCompositionStringW_Proxy(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval dwIndex as DWORD, byval dwBufLen as DWORD, byval plCopied as LONG ptr, byval pBuf as LPVOID) as HRESULT
declare sub IActiveIMMIME_GetCompositionStringW_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_GetCompositionWindow_Proxy(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval pCompForm as COMPOSITIONFORM ptr) as HRESULT
declare sub IActiveIMMIME_GetCompositionWindow_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_GetContext_Proxy(byval This as IActiveIMMIME ptr, byval hWnd as HWND, byval phIMC as HIMC ptr) as HRESULT
declare sub IActiveIMMIME_GetContext_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_GetConversionListA_Proxy(byval This as IActiveIMMIME ptr, byval hKL as HKL, byval hIMC as HIMC, byval pSrc as LPSTR, byval uBufLen as UINT, byval uFlag as UINT, byval pDst as CANDIDATELIST ptr, byval puCopied as UINT ptr) as HRESULT
declare sub IActiveIMMIME_GetConversionListA_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_GetConversionListW_Proxy(byval This as IActiveIMMIME ptr, byval hKL as HKL, byval hIMC as HIMC, byval pSrc as LPWSTR, byval uBufLen as UINT, byval uFlag as UINT, byval pDst as CANDIDATELIST ptr, byval puCopied as UINT ptr) as HRESULT
declare sub IActiveIMMIME_GetConversionListW_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_GetConversionStatus_Proxy(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval pfdwConversion as DWORD ptr, byval pfdwSentence as DWORD ptr) as HRESULT
declare sub IActiveIMMIME_GetConversionStatus_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_GetDefaultIMEWnd_Proxy(byval This as IActiveIMMIME ptr, byval hWnd as HWND, byval phDefWnd as HWND ptr) as HRESULT
declare sub IActiveIMMIME_GetDefaultIMEWnd_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_GetDescriptionA_Proxy(byval This as IActiveIMMIME ptr, byval hKL as HKL, byval uBufLen as UINT, byval szDescription as LPSTR, byval puCopied as UINT ptr) as HRESULT
declare sub IActiveIMMIME_GetDescriptionA_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_GetDescriptionW_Proxy(byval This as IActiveIMMIME ptr, byval hKL as HKL, byval uBufLen as UINT, byval szDescription as LPWSTR, byval puCopied as UINT ptr) as HRESULT
declare sub IActiveIMMIME_GetDescriptionW_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_GetGuideLineA_Proxy(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval dwIndex as DWORD, byval dwBufLen as DWORD, byval pBuf as LPSTR, byval pdwResult as DWORD ptr) as HRESULT
declare sub IActiveIMMIME_GetGuideLineA_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_GetGuideLineW_Proxy(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval dwIndex as DWORD, byval dwBufLen as DWORD, byval pBuf as LPWSTR, byval pdwResult as DWORD ptr) as HRESULT
declare sub IActiveIMMIME_GetGuideLineW_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_GetIMEFileNameA_Proxy(byval This as IActiveIMMIME ptr, byval hKL as HKL, byval uBufLen as UINT, byval szFileName as LPSTR, byval puCopied as UINT ptr) as HRESULT
declare sub IActiveIMMIME_GetIMEFileNameA_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_GetIMEFileNameW_Proxy(byval This as IActiveIMMIME ptr, byval hKL as HKL, byval uBufLen as UINT, byval szFileName as LPWSTR, byval puCopied as UINT ptr) as HRESULT
declare sub IActiveIMMIME_GetIMEFileNameW_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_GetOpenStatus_Proxy(byval This as IActiveIMMIME ptr, byval hIMC as HIMC) as HRESULT
declare sub IActiveIMMIME_GetOpenStatus_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_GetProperty_Proxy(byval This as IActiveIMMIME ptr, byval hKL as HKL, byval fdwIndex as DWORD, byval pdwProperty as DWORD ptr) as HRESULT
declare sub IActiveIMMIME_GetProperty_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_GetRegisterWordStyleA_Proxy(byval This as IActiveIMMIME ptr, byval hKL as HKL, byval nItem as UINT, byval pStyleBuf as STYLEBUFA ptr, byval puCopied as UINT ptr) as HRESULT
declare sub IActiveIMMIME_GetRegisterWordStyleA_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_GetRegisterWordStyleW_Proxy(byval This as IActiveIMMIME ptr, byval hKL as HKL, byval nItem as UINT, byval pStyleBuf as STYLEBUFW ptr, byval puCopied as UINT ptr) as HRESULT
declare sub IActiveIMMIME_GetRegisterWordStyleW_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_GetStatusWindowPos_Proxy(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval pptPos as POINT ptr) as HRESULT
declare sub IActiveIMMIME_GetStatusWindowPos_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_GetVirtualKey_Proxy(byval This as IActiveIMMIME ptr, byval hWnd as HWND, byval puVirtualKey as UINT ptr) as HRESULT
declare sub IActiveIMMIME_GetVirtualKey_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_InstallIMEA_Proxy(byval This as IActiveIMMIME ptr, byval szIMEFileName as LPSTR, byval szLayoutText as LPSTR, byval phKL as HKL ptr) as HRESULT
declare sub IActiveIMMIME_InstallIMEA_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_InstallIMEW_Proxy(byval This as IActiveIMMIME ptr, byval szIMEFileName as LPWSTR, byval szLayoutText as LPWSTR, byval phKL as HKL ptr) as HRESULT
declare sub IActiveIMMIME_InstallIMEW_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_IsIME_Proxy(byval This as IActiveIMMIME ptr, byval hKL as HKL) as HRESULT
declare sub IActiveIMMIME_IsIME_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_IsUIMessageA_Proxy(byval This as IActiveIMMIME ptr, byval hWndIME as HWND, byval msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as HRESULT
declare sub IActiveIMMIME_IsUIMessageA_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_IsUIMessageW_Proxy(byval This as IActiveIMMIME ptr, byval hWndIME as HWND, byval msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as HRESULT
declare sub IActiveIMMIME_IsUIMessageW_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_NotifyIME_Proxy(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval dwAction as DWORD, byval dwIndex as DWORD, byval dwValue as DWORD) as HRESULT
declare sub IActiveIMMIME_NotifyIME_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_RegisterWordA_Proxy(byval This as IActiveIMMIME ptr, byval hKL as HKL, byval szReading as LPSTR, byval dwStyle as DWORD, byval szRegister as LPSTR) as HRESULT
declare sub IActiveIMMIME_RegisterWordA_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_RegisterWordW_Proxy(byval This as IActiveIMMIME ptr, byval hKL as HKL, byval szReading as LPWSTR, byval dwStyle as DWORD, byval szRegister as LPWSTR) as HRESULT
declare sub IActiveIMMIME_RegisterWordW_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_ReleaseContext_Proxy(byval This as IActiveIMMIME ptr, byval hWnd as HWND, byval hIMC as HIMC) as HRESULT
declare sub IActiveIMMIME_ReleaseContext_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_SetCandidateWindow_Proxy(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval pCandidate as CANDIDATEFORM ptr) as HRESULT
declare sub IActiveIMMIME_SetCandidateWindow_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_SetCompositionFontA_Proxy(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval plf as LOGFONTA ptr) as HRESULT
declare sub IActiveIMMIME_SetCompositionFontA_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_SetCompositionFontW_Proxy(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval plf as LOGFONTW ptr) as HRESULT
declare sub IActiveIMMIME_SetCompositionFontW_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_SetCompositionStringA_Proxy(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval dwIndex as DWORD, byval pComp as LPVOID, byval dwCompLen as DWORD, byval pRead as LPVOID, byval dwReadLen as DWORD) as HRESULT
declare sub IActiveIMMIME_SetCompositionStringA_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_SetCompositionStringW_Proxy(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval dwIndex as DWORD, byval pComp as LPVOID, byval dwCompLen as DWORD, byval pRead as LPVOID, byval dwReadLen as DWORD) as HRESULT
declare sub IActiveIMMIME_SetCompositionStringW_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_SetCompositionWindow_Proxy(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval pCompForm as COMPOSITIONFORM ptr) as HRESULT
declare sub IActiveIMMIME_SetCompositionWindow_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_SetConversionStatus_Proxy(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval fdwConversion as DWORD, byval fdwSentence as DWORD) as HRESULT
declare sub IActiveIMMIME_SetConversionStatus_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_SetOpenStatus_Proxy(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval fOpen as WINBOOL) as HRESULT
declare sub IActiveIMMIME_SetOpenStatus_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_SetStatusWindowPos_Proxy(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval pptPos as POINT ptr) as HRESULT
declare sub IActiveIMMIME_SetStatusWindowPos_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_SimulateHotKey_Proxy(byval This as IActiveIMMIME ptr, byval hWnd as HWND, byval dwHotKeyID as DWORD) as HRESULT
declare sub IActiveIMMIME_SimulateHotKey_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_UnregisterWordA_Proxy(byval This as IActiveIMMIME ptr, byval hKL as HKL, byval szReading as LPSTR, byval dwStyle as DWORD, byval szUnregister as LPSTR) as HRESULT
declare sub IActiveIMMIME_UnregisterWordA_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_UnregisterWordW_Proxy(byval This as IActiveIMMIME ptr, byval hKL as HKL, byval szReading as LPWSTR, byval dwStyle as DWORD, byval szUnregister as LPWSTR) as HRESULT
declare sub IActiveIMMIME_UnregisterWordW_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_GenerateMessage_Proxy(byval This as IActiveIMMIME ptr, byval hIMC as HIMC) as HRESULT
declare sub IActiveIMMIME_GenerateMessage_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_LockIMC_Proxy(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval ppIMC as INPUTCONTEXT ptr ptr) as HRESULT
declare sub IActiveIMMIME_LockIMC_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_UnlockIMC_Proxy(byval This as IActiveIMMIME ptr, byval hIMC as HIMC) as HRESULT
declare sub IActiveIMMIME_UnlockIMC_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_GetIMCLockCount_Proxy(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval pdwLockCount as DWORD ptr) as HRESULT
declare sub IActiveIMMIME_GetIMCLockCount_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_CreateIMCC_Proxy(byval This as IActiveIMMIME ptr, byval dwSize as DWORD, byval phIMCC as HIMCC ptr) as HRESULT
declare sub IActiveIMMIME_CreateIMCC_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_DestroyIMCC_Proxy(byval This as IActiveIMMIME ptr, byval hIMCC as HIMCC) as HRESULT
declare sub IActiveIMMIME_DestroyIMCC_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_LockIMCC_Proxy(byval This as IActiveIMMIME ptr, byval hIMCC as HIMCC, byval ppv as any ptr ptr) as HRESULT
declare sub IActiveIMMIME_LockIMCC_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_UnlockIMCC_Proxy(byval This as IActiveIMMIME ptr, byval hIMCC as HIMCC) as HRESULT
declare sub IActiveIMMIME_UnlockIMCC_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_ReSizeIMCC_Proxy(byval This as IActiveIMMIME ptr, byval hIMCC as HIMCC, byval dwSize as DWORD, byval phIMCC as HIMCC ptr) as HRESULT
declare sub IActiveIMMIME_ReSizeIMCC_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_GetIMCCSize_Proxy(byval This as IActiveIMMIME ptr, byval hIMCC as HIMCC, byval pdwSize as DWORD ptr) as HRESULT
declare sub IActiveIMMIME_GetIMCCSize_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_GetIMCCLockCount_Proxy(byval This as IActiveIMMIME ptr, byval hIMCC as HIMCC, byval pdwLockCount as DWORD ptr) as HRESULT
declare sub IActiveIMMIME_GetIMCCLockCount_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_GetHotKey_Proxy(byval This as IActiveIMMIME ptr, byval dwHotKeyID as DWORD, byval puModifiers as UINT ptr, byval puVKey as UINT ptr, byval phKL as HKL ptr) as HRESULT
declare sub IActiveIMMIME_GetHotKey_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_SetHotKey_Proxy(byval This as IActiveIMMIME ptr, byval dwHotKeyID as DWORD, byval uModifiers as UINT, byval uVKey as UINT, byval hKL as HKL) as HRESULT
declare sub IActiveIMMIME_SetHotKey_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_CreateSoftKeyboard_Proxy(byval This as IActiveIMMIME ptr, byval uType as UINT, byval hOwner as HWND, byval x as long, byval y as long, byval phSoftKbdWnd as HWND ptr) as HRESULT
declare sub IActiveIMMIME_CreateSoftKeyboard_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_DestroySoftKeyboard_Proxy(byval This as IActiveIMMIME ptr, byval hSoftKbdWnd as HWND) as HRESULT
declare sub IActiveIMMIME_DestroySoftKeyboard_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_ShowSoftKeyboard_Proxy(byval This as IActiveIMMIME ptr, byval hSoftKbdWnd as HWND, byval nCmdShow as long) as HRESULT
declare sub IActiveIMMIME_ShowSoftKeyboard_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_GetCodePageA_Proxy(byval This as IActiveIMMIME ptr, byval hKL as HKL, byval uCodePage as UINT ptr) as HRESULT
declare sub IActiveIMMIME_GetCodePageA_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_GetLangId_Proxy(byval This as IActiveIMMIME ptr, byval hKL as HKL, byval plid as LANGID ptr) as HRESULT
declare sub IActiveIMMIME_GetLangId_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_KeybdEvent_Proxy(byval This as IActiveIMMIME ptr, byval lgidIME as LANGID, byval bVk as UBYTE, byval bScan as UBYTE, byval dwFlags as DWORD, byval dwExtraInfo as DWORD) as HRESULT
declare sub IActiveIMMIME_KeybdEvent_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_LockModal_Proxy(byval This as IActiveIMMIME ptr) as HRESULT
declare sub IActiveIMMIME_LockModal_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_UnlockModal_Proxy(byval This as IActiveIMMIME ptr) as HRESULT
declare sub IActiveIMMIME_UnlockModal_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_AssociateContextEx_Proxy(byval This as IActiveIMMIME ptr, byval hWnd as HWND, byval hIMC as HIMC, byval dwFlags as DWORD) as HRESULT
declare sub IActiveIMMIME_AssociateContextEx_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_DisableIME_Proxy(byval This as IActiveIMMIME ptr, byval idThread as DWORD) as HRESULT
declare sub IActiveIMMIME_DisableIME_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_GetImeMenuItemsA_Proxy(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval dwFlags as DWORD, byval dwType as DWORD, byval pImeParentMenu as IMEMENUITEMINFOA ptr, byval pImeMenu as IMEMENUITEMINFOA ptr, byval dwSize as DWORD, byval pdwResult as DWORD ptr) as HRESULT
declare sub IActiveIMMIME_GetImeMenuItemsA_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_GetImeMenuItemsW_Proxy(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval dwFlags as DWORD, byval dwType as DWORD, byval pImeParentMenu as IMEMENUITEMINFOW ptr, byval pImeMenu as IMEMENUITEMINFOW ptr, byval dwSize as DWORD, byval pdwResult as DWORD ptr) as HRESULT
declare sub IActiveIMMIME_GetImeMenuItemsW_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_EnumInputContext_Proxy(byval This as IActiveIMMIME ptr, byval idThread as DWORD, byval ppEnum as IEnumInputContext ptr ptr) as HRESULT
declare sub IActiveIMMIME_EnumInputContext_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_RequestMessageA_Proxy(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval wParam as WPARAM, byval lParam as LPARAM, byval plResult as LRESULT ptr) as HRESULT
declare sub IActiveIMMIME_RequestMessageA_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_RequestMessageW_Proxy(byval This as IActiveIMMIME ptr, byval hIMC as HIMC, byval wParam as WPARAM, byval lParam as LPARAM, byval plResult as LRESULT ptr) as HRESULT
declare sub IActiveIMMIME_RequestMessageW_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_SendIMCA_Proxy(byval This as IActiveIMMIME ptr, byval hWnd as HWND, byval uMsg as UINT, byval wParam as WPARAM, byval lParam as LPARAM, byval plResult as LRESULT ptr) as HRESULT
declare sub IActiveIMMIME_SendIMCA_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_SendIMCW_Proxy(byval This as IActiveIMMIME ptr, byval hWnd as HWND, byval uMsg as UINT, byval wParam as WPARAM, byval lParam as LPARAM, byval plResult as LRESULT ptr) as HRESULT
declare sub IActiveIMMIME_SendIMCW_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIMMIME_IsSleeping_Proxy(byval This as IActiveIMMIME ptr) as HRESULT
declare sub IActiveIMMIME_IsSleeping_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IActiveIME_INTERFACE_DEFINED__
extern IID_IActiveIME as const IID
type IActiveIME as IActiveIME_

type IActiveIMEVtbl
	QueryInterface as function(byval This as IActiveIME ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IActiveIME ptr) as ULONG
	Release as function(byval This as IActiveIME ptr) as ULONG
	Inquire as function(byval This as IActiveIME ptr, byval dwSystemInfoFlags as DWORD, byval pIMEInfo as IMEINFO ptr, byval szWndClass as LPWSTR, byval pdwPrivate as DWORD ptr) as HRESULT
	ConversionList as function(byval This as IActiveIME ptr, byval hIMC as HIMC, byval szSource as LPWSTR, byval uFlag as UINT, byval uBufLen as UINT, byval pDest as CANDIDATELIST ptr, byval puCopied as UINT ptr) as HRESULT
	Configure as function(byval This as IActiveIME ptr, byval hKL as HKL, byval hWnd as HWND, byval dwMode as DWORD, byval pRegisterWord as REGISTERWORDW ptr) as HRESULT
	Destroy as function(byval This as IActiveIME ptr, byval uReserved as UINT) as HRESULT
	Escape as function(byval This as IActiveIME ptr, byval hIMC as HIMC, byval uEscape as UINT, byval pData as any ptr, byval plResult as LRESULT ptr) as HRESULT
	SetActiveContext as function(byval This as IActiveIME ptr, byval hIMC as HIMC, byval fFlag as WINBOOL) as HRESULT
	ProcessKey as function(byval This as IActiveIME ptr, byval hIMC as HIMC, byval uVirKey as UINT, byval lParam as DWORD, byval pbKeyState as UBYTE ptr) as HRESULT
	Notify as function(byval This as IActiveIME ptr, byval hIMC as HIMC, byval dwAction as DWORD, byval dwIndex as DWORD, byval dwValue as DWORD) as HRESULT
	Select as function(byval This as IActiveIME ptr, byval hIMC as HIMC, byval fSelect as WINBOOL) as HRESULT
	SetCompositionString as function(byval This as IActiveIME ptr, byval hIMC as HIMC, byval dwIndex as DWORD, byval pComp as any ptr, byval dwCompLen as DWORD, byval pRead as any ptr, byval dwReadLen as DWORD) as HRESULT
	ToAsciiEx as function(byval This as IActiveIME ptr, byval uVirKey as UINT, byval uScanCode as UINT, byval pbKeyState as UBYTE ptr, byval fuState as UINT, byval hIMC as HIMC, byval pdwTransBuf as DWORD ptr, byval puSize as UINT ptr) as HRESULT
	RegisterWord as function(byval This as IActiveIME ptr, byval szReading as LPWSTR, byval dwStyle as DWORD, byval szString as LPWSTR) as HRESULT
	UnregisterWord as function(byval This as IActiveIME ptr, byval szReading as LPWSTR, byval dwStyle as DWORD, byval szString as LPWSTR) as HRESULT
	GetRegisterWordStyle as function(byval This as IActiveIME ptr, byval nItem as UINT, byval pStyleBuf as STYLEBUFW ptr, byval puBufSize as UINT ptr) as HRESULT
	EnumRegisterWord as function(byval This as IActiveIME ptr, byval szReading as LPWSTR, byval dwStyle as DWORD, byval szRegister as LPWSTR, byval pData as LPVOID, byval ppEnum as IEnumRegisterWordW ptr ptr) as HRESULT
	GetCodePageA as function(byval This as IActiveIME ptr, byval uCodePage as UINT ptr) as HRESULT
	GetLangId as function(byval This as IActiveIME ptr, byval plid as LANGID ptr) as HRESULT
end type

type IActiveIME_
	lpVtbl as IActiveIMEVtbl ptr
end type

declare function IActiveIME_Inquire_Proxy(byval This as IActiveIME ptr, byval dwSystemInfoFlags as DWORD, byval pIMEInfo as IMEINFO ptr, byval szWndClass as LPWSTR, byval pdwPrivate as DWORD ptr) as HRESULT
declare sub IActiveIME_Inquire_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIME_ConversionList_Proxy(byval This as IActiveIME ptr, byval hIMC as HIMC, byval szSource as LPWSTR, byval uFlag as UINT, byval uBufLen as UINT, byval pDest as CANDIDATELIST ptr, byval puCopied as UINT ptr) as HRESULT
declare sub IActiveIME_ConversionList_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIME_Configure_Proxy(byval This as IActiveIME ptr, byval hKL as HKL, byval hWnd as HWND, byval dwMode as DWORD, byval pRegisterWord as REGISTERWORDW ptr) as HRESULT
declare sub IActiveIME_Configure_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIME_Destroy_Proxy(byval This as IActiveIME ptr, byval uReserved as UINT) as HRESULT
declare sub IActiveIME_Destroy_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIME_Escape_Proxy(byval This as IActiveIME ptr, byval hIMC as HIMC, byval uEscape as UINT, byval pData as any ptr, byval plResult as LRESULT ptr) as HRESULT
declare sub IActiveIME_Escape_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIME_SetActiveContext_Proxy(byval This as IActiveIME ptr, byval hIMC as HIMC, byval fFlag as WINBOOL) as HRESULT
declare sub IActiveIME_SetActiveContext_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIME_ProcessKey_Proxy(byval This as IActiveIME ptr, byval hIMC as HIMC, byval uVirKey as UINT, byval lParam as DWORD, byval pbKeyState as UBYTE ptr) as HRESULT
declare sub IActiveIME_ProcessKey_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIME_Notify_Proxy(byval This as IActiveIME ptr, byval hIMC as HIMC, byval dwAction as DWORD, byval dwIndex as DWORD, byval dwValue as DWORD) as HRESULT
declare sub IActiveIME_Notify_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIME_Select_Proxy(byval This as IActiveIME ptr, byval hIMC as HIMC, byval fSelect as WINBOOL) as HRESULT
declare sub IActiveIME_Select_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIME_SetCompositionString_Proxy(byval This as IActiveIME ptr, byval hIMC as HIMC, byval dwIndex as DWORD, byval pComp as any ptr, byval dwCompLen as DWORD, byval pRead as any ptr, byval dwReadLen as DWORD) as HRESULT
declare sub IActiveIME_SetCompositionString_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIME_ToAsciiEx_Proxy(byval This as IActiveIME ptr, byval uVirKey as UINT, byval uScanCode as UINT, byval pbKeyState as UBYTE ptr, byval fuState as UINT, byval hIMC as HIMC, byval pdwTransBuf as DWORD ptr, byval puSize as UINT ptr) as HRESULT
declare sub IActiveIME_ToAsciiEx_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIME_RegisterWord_Proxy(byval This as IActiveIME ptr, byval szReading as LPWSTR, byval dwStyle as DWORD, byval szString as LPWSTR) as HRESULT
declare sub IActiveIME_RegisterWord_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIME_UnregisterWord_Proxy(byval This as IActiveIME ptr, byval szReading as LPWSTR, byval dwStyle as DWORD, byval szString as LPWSTR) as HRESULT
declare sub IActiveIME_UnregisterWord_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIME_GetRegisterWordStyle_Proxy(byval This as IActiveIME ptr, byval nItem as UINT, byval pStyleBuf as STYLEBUFW ptr, byval puBufSize as UINT ptr) as HRESULT
declare sub IActiveIME_GetRegisterWordStyle_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIME_EnumRegisterWord_Proxy(byval This as IActiveIME ptr, byval szReading as LPWSTR, byval dwStyle as DWORD, byval szRegister as LPWSTR, byval pData as LPVOID, byval ppEnum as IEnumRegisterWordW ptr ptr) as HRESULT
declare sub IActiveIME_EnumRegisterWord_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIME_GetCodePageA_Proxy(byval This as IActiveIME ptr, byval uCodePage as UINT ptr) as HRESULT
declare sub IActiveIME_GetCodePageA_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIME_GetLangId_Proxy(byval This as IActiveIME ptr, byval plid as LANGID ptr) as HRESULT
declare sub IActiveIME_GetLangId_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IActiveIME2_INTERFACE_DEFINED__
extern IID_IActiveIME2 as const IID
type IActiveIME2 as IActiveIME2_

type IActiveIME2Vtbl
	QueryInterface as function(byval This as IActiveIME2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IActiveIME2 ptr) as ULONG
	Release as function(byval This as IActiveIME2 ptr) as ULONG
	Inquire as function(byval This as IActiveIME2 ptr, byval dwSystemInfoFlags as DWORD, byval pIMEInfo as IMEINFO ptr, byval szWndClass as LPWSTR, byval pdwPrivate as DWORD ptr) as HRESULT
	ConversionList as function(byval This as IActiveIME2 ptr, byval hIMC as HIMC, byval szSource as LPWSTR, byval uFlag as UINT, byval uBufLen as UINT, byval pDest as CANDIDATELIST ptr, byval puCopied as UINT ptr) as HRESULT
	Configure as function(byval This as IActiveIME2 ptr, byval hKL as HKL, byval hWnd as HWND, byval dwMode as DWORD, byval pRegisterWord as REGISTERWORDW ptr) as HRESULT
	Destroy as function(byval This as IActiveIME2 ptr, byval uReserved as UINT) as HRESULT
	Escape as function(byval This as IActiveIME2 ptr, byval hIMC as HIMC, byval uEscape as UINT, byval pData as any ptr, byval plResult as LRESULT ptr) as HRESULT
	SetActiveContext as function(byval This as IActiveIME2 ptr, byval hIMC as HIMC, byval fFlag as WINBOOL) as HRESULT
	ProcessKey as function(byval This as IActiveIME2 ptr, byval hIMC as HIMC, byval uVirKey as UINT, byval lParam as DWORD, byval pbKeyState as UBYTE ptr) as HRESULT
	Notify as function(byval This as IActiveIME2 ptr, byval hIMC as HIMC, byval dwAction as DWORD, byval dwIndex as DWORD, byval dwValue as DWORD) as HRESULT
	Select as function(byval This as IActiveIME2 ptr, byval hIMC as HIMC, byval fSelect as WINBOOL) as HRESULT
	SetCompositionString as function(byval This as IActiveIME2 ptr, byval hIMC as HIMC, byval dwIndex as DWORD, byval pComp as any ptr, byval dwCompLen as DWORD, byval pRead as any ptr, byval dwReadLen as DWORD) as HRESULT
	ToAsciiEx as function(byval This as IActiveIME2 ptr, byval uVirKey as UINT, byval uScanCode as UINT, byval pbKeyState as UBYTE ptr, byval fuState as UINT, byval hIMC as HIMC, byval pdwTransBuf as DWORD ptr, byval puSize as UINT ptr) as HRESULT
	RegisterWord as function(byval This as IActiveIME2 ptr, byval szReading as LPWSTR, byval dwStyle as DWORD, byval szString as LPWSTR) as HRESULT
	UnregisterWord as function(byval This as IActiveIME2 ptr, byval szReading as LPWSTR, byval dwStyle as DWORD, byval szString as LPWSTR) as HRESULT
	GetRegisterWordStyle as function(byval This as IActiveIME2 ptr, byval nItem as UINT, byval pStyleBuf as STYLEBUFW ptr, byval puBufSize as UINT ptr) as HRESULT
	EnumRegisterWord as function(byval This as IActiveIME2 ptr, byval szReading as LPWSTR, byval dwStyle as DWORD, byval szRegister as LPWSTR, byval pData as LPVOID, byval ppEnum as IEnumRegisterWordW ptr ptr) as HRESULT
	GetCodePageA as function(byval This as IActiveIME2 ptr, byval uCodePage as UINT ptr) as HRESULT
	GetLangId as function(byval This as IActiveIME2 ptr, byval plid as LANGID ptr) as HRESULT
	Sleep as function(byval This as IActiveIME2 ptr) as HRESULT
	Unsleep as function(byval This as IActiveIME2 ptr, byval fDead as WINBOOL) as HRESULT
end type

type IActiveIME2_
	lpVtbl as IActiveIME2Vtbl ptr
end type

declare function IActiveIME2_Sleep_Proxy(byval This as IActiveIME2 ptr) as HRESULT
declare sub IActiveIME2_Sleep_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IActiveIME2_Unsleep_Proxy(byval This as IActiveIME2 ptr, byval fDead as WINBOOL) as HRESULT
declare sub IActiveIME2_Unsleep_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
extern CLSID_CActiveIMM as const CLSID

end extern
