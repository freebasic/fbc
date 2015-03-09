#pragma once

#include once "rpc.bi"
#include once "rpcndr.bi"
#include once "windows.bi"
#include once "ole2.bi"
#include once "oaidl.bi"
#include once "_mingw_unicode.bi"

#inclib "oleacc"

extern "Windows"

#define __oleacc_h__
#define __IAccessible_FWD_DEFINED__
#define __IAccessibleHandler_FWD_DEFINED__
#define __IAccIdentity_FWD_DEFINED__
#define __IAccPropServer_FWD_DEFINED__
#define __IAccPropServices_FWD_DEFINED__
#define __CAccPropServices_FWD_DEFINED__

type LPFNLRESULTFROMOBJECT as function(byval riid as const IID const ptr, byval wParam as WPARAM, byval punk as LPUNKNOWN) as LRESULT
type LPFNOBJECTFROMLRESULT as function(byval lResult as LRESULT, byval riid as const IID const ptr, byval wParam as WPARAM, byval ppvObject as any ptr ptr) as HRESULT
type LPFNACCESSIBLEOBJECTFROMWINDOW as function(byval hwnd as HWND, byval dwId as DWORD, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT

type IAccessible as IAccessible_

type LPFNACCESSIBLEOBJECTFROMPOINT as function(byval ptScreen as POINT, byval ppacc as IAccessible ptr ptr, byval pvarChild as VARIANT ptr) as HRESULT
type LPFNCREATESTDACCESSIBLEOBJECT as function(byval hwnd as HWND, byval idObject as LONG, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
type LPFNACCESSIBLECHILDREN as function(byval paccContainer as IAccessible ptr, byval iChildStart as LONG, byval cChildren as LONG, byval rgvarChildren as VARIANT ptr, byval pcObtained as LONG ptr) as HRESULT

extern LIBID_Accessibility as const GUID
extern IID_IAccessibleHandler as const GUID
extern IID_IAccIdentity as const GUID
extern IID_IAccPropServer as const GUID
extern IID_IAccPropServices as const GUID
extern IID_IAccPropMgrInternal as const GUID
extern CLSID_AccPropServices as const GUID
extern IIS_IsOleaccProxy as const GUID

#ifdef UNICODE
	#define GetRoleText GetRoleTextW
	#define GetStateText GetStateTextW
	#define CreateStdAccessibleProxy CreateStdAccessibleProxyW
#else
	#define GetRoleText GetRoleTextA
	#define GetStateText GetStateTextA
	#define CreateStdAccessibleProxy CreateStdAccessibleProxyA
#endif

declare function LresultFromObject(byval riid as const IID const ptr, byval wParam as WPARAM, byval punk as LPUNKNOWN) as LRESULT
declare function ObjectFromLresult(byval lResult as LRESULT, byval riid as const IID const ptr, byval wParam as WPARAM, byval ppvObject as any ptr ptr) as HRESULT
declare function WindowFromAccessibleObject(byval as IAccessible ptr, byval phwnd as HWND ptr) as HRESULT
declare function AccessibleObjectFromWindow(byval hwnd as HWND, byval dwId as DWORD, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
declare function AccessibleObjectFromEvent(byval hwnd as HWND, byval dwId as DWORD, byval dwChildId as DWORD, byval ppacc as IAccessible ptr ptr, byval pvarChild as VARIANT ptr) as HRESULT
declare function AccessibleObjectFromPoint(byval ptScreen as POINT, byval ppacc as IAccessible ptr ptr, byval pvarChild as VARIANT ptr) as HRESULT
declare function AccessibleChildren(byval paccContainer as IAccessible ptr, byval iChildStart as LONG, byval cChildren as LONG, byval rgvarChildren as VARIANT ptr, byval pcObtained as LONG ptr) as HRESULT
declare function GetRoleTextA(byval lRole as DWORD, byval lpszRole as LPSTR, byval cchRoleMax as UINT) as UINT
declare function GetRoleTextW(byval lRole as DWORD, byval lpszRole as LPWSTR, byval cchRoleMax as UINT) as UINT
declare function GetStateTextA(byval lStateBit as DWORD, byval lpszState as LPSTR, byval cchState as UINT) as UINT
declare function GetStateTextW(byval lStateBit as DWORD, byval lpszState as LPWSTR, byval cchState as UINT) as UINT
declare sub GetOleaccVersionInfo(byval pVer as DWORD ptr, byval pBuild as DWORD ptr)
declare function CreateStdAccessibleObject(byval hwnd as HWND, byval idObject as LONG, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
declare function CreateStdAccessibleProxyA(byval hwnd as HWND, byval pClassName as LPCSTR, byval idObject as LONG, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
declare function CreateStdAccessibleProxyW(byval hwnd as HWND, byval pClassName as LPCWSTR, byval idObject as LONG, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT

#define MSAA_MENU_SIG __MSABI_LONG(&hAA0DF00D)

type tagMSAAMENUINFO
	dwMSAASignature as DWORD
	cchWText as DWORD
	pszWText as LPWSTR
end type

type MSAAMENUINFO as tagMSAAMENUINFO
type LPMSAAMENUINFO as tagMSAAMENUINFO ptr

extern PROPID_ACC_NAME as const GUID
extern PROPID_ACC_VALUE as const GUID
extern PROPID_ACC_DESCRIPTION as const GUID
extern PROPID_ACC_ROLE as const GUID
extern PROPID_ACC_STATE as const GUID
extern PROPID_ACC_HELP as const GUID
extern PROPID_ACC_KEYBOARDSHORTCUT as const GUID
extern PROPID_ACC_DEFAULTACTION as const GUID
extern PROPID_ACC_HELPTOPIC as const GUID
extern PROPID_ACC_FOCUS as const GUID
extern PROPID_ACC_SELECTION as const GUID
extern PROPID_ACC_PARENT as const GUID
extern PROPID_ACC_NAV_UP as const GUID
extern PROPID_ACC_NAV_DOWN as const GUID
extern PROPID_ACC_NAV_LEFT as const GUID
extern PROPID_ACC_NAV_RIGHT as const GUID
extern PROPID_ACC_NAV_PREV as const GUID
extern PROPID_ACC_NAV_NEXT as const GUID
extern PROPID_ACC_NAV_FIRSTCHILD as const GUID
extern PROPID_ACC_NAV_LASTCHILD as const GUID
extern PROPID_ACC_ROLEMAP as const GUID
extern PROPID_ACC_VALUEMAP as const GUID
extern PROPID_ACC_STATEMAP as const GUID
extern PROPID_ACC_DESCRIPTIONMAP as const GUID
extern PROPID_ACC_DODEFAULTACTION as const GUID

#define NAVDIR_MIN 0
#define NAVDIR_UP &h1
#define NAVDIR_DOWN &h2
#define NAVDIR_LEFT &h3
#define NAVDIR_RIGHT &h4
#define NAVDIR_NEXT &h5
#define NAVDIR_PREVIOUS &h6
#define NAVDIR_FIRSTCHILD &h7
#define NAVDIR_LASTCHILD &h8
#define NAVDIR_MAX &h9
#define SELFLAG_NONE 0
#define SELFLAG_TAKEFOCUS &h1
#define SELFLAG_TAKESELECTION &h2
#define SELFLAG_EXTENDSELECTION &h4
#define SELFLAG_ADDSELECTION &h8
#define SELFLAG_REMOVESELECTION &h10
#define SELFLAG_VALID &h1f
#define STATE_SYSTEM_HASPOPUP &h40000000
#define ROLE_SYSTEM_TITLEBAR &h1
#define ROLE_SYSTEM_MENUBAR &h2
#define ROLE_SYSTEM_SCROLLBAR &h3
#define ROLE_SYSTEM_GRIP &h4
#define ROLE_SYSTEM_SOUND &h5
#define ROLE_SYSTEM_CURSOR &h6
#define ROLE_SYSTEM_CARET &h7
#define ROLE_SYSTEM_ALERT &h8
#define ROLE_SYSTEM_WINDOW &h9
#define ROLE_SYSTEM_CLIENT &ha
#define ROLE_SYSTEM_MENUPOPUP &hb
#define ROLE_SYSTEM_MENUITEM &hc
#define ROLE_SYSTEM_TOOLTIP &hd
#define ROLE_SYSTEM_APPLICATION &he
#define ROLE_SYSTEM_DOCUMENT &hf
#define ROLE_SYSTEM_PANE &h10
#define ROLE_SYSTEM_CHART &h11
#define ROLE_SYSTEM_DIALOG &h12
#define ROLE_SYSTEM_BORDER &h13
#define ROLE_SYSTEM_GROUPING &h14
#define ROLE_SYSTEM_SEPARATOR &h15
#define ROLE_SYSTEM_TOOLBAR &h16
#define ROLE_SYSTEM_STATUSBAR &h17
#define ROLE_SYSTEM_TABLE &h18
#define ROLE_SYSTEM_COLUMNHEADER &h19
#define ROLE_SYSTEM_ROWHEADER &h1a
#define ROLE_SYSTEM_COLUMN &h1b
#define ROLE_SYSTEM_ROW &h1c
#define ROLE_SYSTEM_CELL &h1d
#define ROLE_SYSTEM_LINK &h1e
#define ROLE_SYSTEM_HELPBALLOON &h1f
#define ROLE_SYSTEM_CHARACTER &h20
#define ROLE_SYSTEM_LIST &h21
#define ROLE_SYSTEM_LISTITEM &h22
#define ROLE_SYSTEM_OUTLINE &h23
#define ROLE_SYSTEM_OUTLINEITEM &h24
#define ROLE_SYSTEM_PAGETAB &h25
#define ROLE_SYSTEM_PROPERTYPAGE &h26
#define ROLE_SYSTEM_INDICATOR &h27
#define ROLE_SYSTEM_GRAPHIC &h28
#define ROLE_SYSTEM_STATICTEXT &h29
#define ROLE_SYSTEM_TEXT &h2a
#define ROLE_SYSTEM_PUSHBUTTON &h2b
#define ROLE_SYSTEM_CHECKBUTTON &h2c
#define ROLE_SYSTEM_RADIOBUTTON &h2d
#define ROLE_SYSTEM_COMBOBOX &h2e
#define ROLE_SYSTEM_DROPLIST &h2f
#define ROLE_SYSTEM_PROGRESSBAR &h30
#define ROLE_SYSTEM_DIAL &h31
#define ROLE_SYSTEM_HOTKEYFIELD &h32
#define ROLE_SYSTEM_SLIDER &h33
#define ROLE_SYSTEM_SPINBUTTON &h34
#define ROLE_SYSTEM_DIAGRAM &h35
#define ROLE_SYSTEM_ANIMATION &h36
#define ROLE_SYSTEM_EQUATION &h37
#define ROLE_SYSTEM_BUTTONDROPDOWN &h38
#define ROLE_SYSTEM_BUTTONMENU &h39
#define ROLE_SYSTEM_BUTTONDROPDOWNGRID &h3a
#define ROLE_SYSTEM_WHITESPACE &h3b
#define ROLE_SYSTEM_PAGETABLIST &h3c
#define ROLE_SYSTEM_CLOCK &h3d
#define ROLE_SYSTEM_SPLITBUTTON &h3e
#define ROLE_SYSTEM_IPADDRESS &h3f
#define ROLE_SYSTEM_OUTLINEBUTTON &h40
#define __IAccessible_INTERFACE_DEFINED__

type LPACCESSIBLE as IAccessible ptr

#define DISPID_ACC_PARENT (-5000)
#define DISPID_ACC_CHILDCOUNT (-5001)
#define DISPID_ACC_CHILD (-5002)
#define DISPID_ACC_NAME (-5003)
#define DISPID_ACC_VALUE (-5004)
#define DISPID_ACC_DESCRIPTION (-5005)
#define DISPID_ACC_ROLE (-5006)
#define DISPID_ACC_STATE (-5007)
#define DISPID_ACC_HELP (-5008)
#define DISPID_ACC_HELPTOPIC (-5009)
#define DISPID_ACC_KEYBOARDSHORTCUT (-5010)
#define DISPID_ACC_FOCUS (-5011)
#define DISPID_ACC_SELECTION (-5012)
#define DISPID_ACC_DEFAULTACTION (-5013)
#define DISPID_ACC_SELECT (-5014)
#define DISPID_ACC_LOCATION (-5015)
#define DISPID_ACC_NAVIGATE (-5016)
#define DISPID_ACC_HITTEST (-5017)
#define DISPID_ACC_DODEFAULTACTION (-5018)

extern IID_IAccessible as const GUID

type IAccessibleVtbl
	QueryInterface as function(byval This as IAccessible ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAccessible ptr) as ULONG
	Release as function(byval This as IAccessible ptr) as ULONG
	GetTypeInfoCount as function(byval This as IAccessible ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IAccessible ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IAccessible ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IAccessible ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_accParent as function(byval This as IAccessible ptr, byval ppdispParent as IDispatch ptr ptr) as HRESULT
	get_accChildCount as function(byval This as IAccessible ptr, byval pcountChildren as LONG ptr) as HRESULT
	get_accChild as function(byval This as IAccessible ptr, byval varChildID as VARIANT, byval ppdispChild as IDispatch ptr ptr) as HRESULT
	get_accName as function(byval This as IAccessible ptr, byval varID as VARIANT, byval pszName as BSTR ptr) as HRESULT
	get_accValue as function(byval This as IAccessible ptr, byval varID as VARIANT, byval pszValue as BSTR ptr) as HRESULT
	get_accDescription as function(byval This as IAccessible ptr, byval varID as VARIANT, byval pszDescription as BSTR ptr) as HRESULT
	get_accRole as function(byval This as IAccessible ptr, byval varID as VARIANT, byval pvarRole as VARIANT ptr) as HRESULT
	get_accState as function(byval This as IAccessible ptr, byval varID as VARIANT, byval pvarState as VARIANT ptr) as HRESULT
	get_accHelp as function(byval This as IAccessible ptr, byval varID as VARIANT, byval pszHelp as BSTR ptr) as HRESULT
	get_accHelpTopic as function(byval This as IAccessible ptr, byval pszHelpFile as BSTR ptr, byval varID as VARIANT, byval pidTopic as LONG ptr) as HRESULT
	get_accKeyboardShortcut as function(byval This as IAccessible ptr, byval varID as VARIANT, byval pszKeyboardShortcut as BSTR ptr) as HRESULT
	get_accFocus as function(byval This as IAccessible ptr, byval pvarID as VARIANT ptr) as HRESULT
	get_accSelection as function(byval This as IAccessible ptr, byval pvarID as VARIANT ptr) as HRESULT
	get_accDefaultAction as function(byval This as IAccessible ptr, byval varID as VARIANT, byval pszDefaultAction as BSTR ptr) as HRESULT
	accSelect as function(byval This as IAccessible ptr, byval flagsSelect as LONG, byval varID as VARIANT) as HRESULT
	accLocation as function(byval This as IAccessible ptr, byval pxLeft as LONG ptr, byval pyTop as LONG ptr, byval pcxWidth as LONG ptr, byval pcyHeight as LONG ptr, byval varID as VARIANT) as HRESULT
	accNavigate as function(byval This as IAccessible ptr, byval navDir as LONG, byval varStart as VARIANT, byval pvarEnd as VARIANT ptr) as HRESULT
	accHitTest as function(byval This as IAccessible ptr, byval xLeft as LONG, byval yTop as LONG, byval pvarID as VARIANT ptr) as HRESULT
	accDoDefaultAction as function(byval This as IAccessible ptr, byval varID as VARIANT) as HRESULT
	put_accName as function(byval This as IAccessible ptr, byval varID as VARIANT, byval pszName as BSTR) as HRESULT
	put_accValue as function(byval This as IAccessible ptr, byval varID as VARIANT, byval pszValue as BSTR) as HRESULT
end type

type IAccessible_
	lpVtbl as IAccessibleVtbl ptr
end type

declare function IAccessible_get_accParent_Proxy(byval This as IAccessible ptr, byval ppdispParent as IDispatch ptr ptr) as HRESULT
declare sub IAccessible_get_accParent_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IAccessible_get_accChildCount_Proxy(byval This as IAccessible ptr, byval pcountChildren as LONG ptr) as HRESULT
declare sub IAccessible_get_accChildCount_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IAccessible_get_accChild_Proxy(byval This as IAccessible ptr, byval varChildID as VARIANT, byval ppdispChild as IDispatch ptr ptr) as HRESULT
declare sub IAccessible_get_accChild_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IAccessible_get_accName_Proxy(byval This as IAccessible ptr, byval varID as VARIANT, byval pszName as BSTR ptr) as HRESULT
declare sub IAccessible_get_accName_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IAccessible_get_accValue_Proxy(byval This as IAccessible ptr, byval varID as VARIANT, byval pszValue as BSTR ptr) as HRESULT
declare sub IAccessible_get_accValue_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IAccessible_get_accDescription_Proxy(byval This as IAccessible ptr, byval varID as VARIANT, byval pszDescription as BSTR ptr) as HRESULT
declare sub IAccessible_get_accDescription_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IAccessible_get_accRole_Proxy(byval This as IAccessible ptr, byval varID as VARIANT, byval pvarRole as VARIANT ptr) as HRESULT
declare sub IAccessible_get_accRole_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IAccessible_get_accState_Proxy(byval This as IAccessible ptr, byval varID as VARIANT, byval pvarState as VARIANT ptr) as HRESULT
declare sub IAccessible_get_accState_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IAccessible_get_accHelp_Proxy(byval This as IAccessible ptr, byval varID as VARIANT, byval pszHelp as BSTR ptr) as HRESULT
declare sub IAccessible_get_accHelp_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IAccessible_get_accHelpTopic_Proxy(byval This as IAccessible ptr, byval pszHelpFile as BSTR ptr, byval varID as VARIANT, byval pidTopic as LONG ptr) as HRESULT
declare sub IAccessible_get_accHelpTopic_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IAccessible_get_accKeyboardShortcut_Proxy(byval This as IAccessible ptr, byval varID as VARIANT, byval pszKeyboardShortcut as BSTR ptr) as HRESULT
declare sub IAccessible_get_accKeyboardShortcut_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IAccessible_get_accFocus_Proxy(byval This as IAccessible ptr, byval pvarID as VARIANT ptr) as HRESULT
declare sub IAccessible_get_accFocus_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IAccessible_get_accSelection_Proxy(byval This as IAccessible ptr, byval pvarID as VARIANT ptr) as HRESULT
declare sub IAccessible_get_accSelection_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IAccessible_get_accDefaultAction_Proxy(byval This as IAccessible ptr, byval varID as VARIANT, byval pszDefaultAction as BSTR ptr) as HRESULT
declare sub IAccessible_get_accDefaultAction_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IAccessible_accSelect_Proxy(byval This as IAccessible ptr, byval flagsSelect as LONG, byval varID as VARIANT) as HRESULT
declare sub IAccessible_accSelect_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IAccessible_accLocation_Proxy(byval This as IAccessible ptr, byval pxLeft as LONG ptr, byval pyTop as LONG ptr, byval pcxWidth as LONG ptr, byval pcyHeight as LONG ptr, byval varID as VARIANT) as HRESULT
declare sub IAccessible_accLocation_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IAccessible_accNavigate_Proxy(byval This as IAccessible ptr, byval navDir as LONG, byval varStart as VARIANT, byval pvarEnd as VARIANT ptr) as HRESULT
declare sub IAccessible_accNavigate_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IAccessible_accHitTest_Proxy(byval This as IAccessible ptr, byval xLeft as LONG, byval yTop as LONG, byval pvarID as VARIANT ptr) as HRESULT
declare sub IAccessible_accHitTest_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IAccessible_accDoDefaultAction_Proxy(byval This as IAccessible ptr, byval varID as VARIANT) as HRESULT
declare sub IAccessible_accDoDefaultAction_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IAccessible_put_accName_Proxy(byval This as IAccessible ptr, byval varID as VARIANT, byval pszName as BSTR) as HRESULT
declare sub IAccessible_put_accName_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IAccessible_put_accValue_Proxy(byval This as IAccessible ptr, byval varID as VARIANT, byval pszValue as BSTR) as HRESULT
declare sub IAccessible_put_accValue_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define __IAccessibleHandler_INTERFACE_DEFINED__

type IAccessibleHandler as IAccessibleHandler_

type LPACCESSIBLEHANDLER as IAccessibleHandler ptr

extern IID_IAccessibleHandler as const IID

type IAccessibleHandlerVtbl
	QueryInterface as function(byval This as IAccessibleHandler ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAccessibleHandler ptr) as ULONG
	Release as function(byval This as IAccessibleHandler ptr) as ULONG
	AccessibleObjectFromID as function(byval This as IAccessibleHandler ptr, byval hwnd as LONG, byval lObjectID as LONG, byval pIAccessible as LPACCESSIBLE ptr) as HRESULT
end type

type IAccessibleHandler_
	lpVtbl as IAccessibleHandlerVtbl ptr
end type

declare function IAccessibleHandler_AccessibleObjectFromID_Proxy(byval This as IAccessibleHandler ptr, byval hwnd as LONG, byval lObjectID as LONG, byval pIAccessible as LPACCESSIBLE ptr) as HRESULT
declare sub IAccessibleHandler_AccessibleObjectFromID_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

type AnnoScope as long
enum
	ANNO_THIS = 0
	ANNO_CONTAINER = 1
end enum

type MSAAPROPID as GUID

extern __MIDL_itf_oleacc_0116_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_oleacc_0116_v0_0_s_ifspec as RPC_IF_HANDLE

#define __IAccIdentity_INTERFACE_DEFINED__

extern IID_IAccIdentity as const IID

type IAccIdentity as IAccIdentity_

type IAccIdentityVtbl
	QueryInterface as function(byval This as IAccIdentity ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAccIdentity ptr) as ULONG
	Release as function(byval This as IAccIdentity ptr) as ULONG
	GetIdentityString as function(byval This as IAccIdentity ptr, byval dwIDChild as DWORD, byval ppIDString as UBYTE ptr ptr, byval pdwIDStringLen as DWORD ptr) as HRESULT
end type

type IAccIdentity_
	lpVtbl as IAccIdentityVtbl ptr
end type

declare function IAccIdentity_GetIdentityString_Proxy(byval This as IAccIdentity ptr, byval dwIDChild as DWORD, byval ppIDString as UBYTE ptr ptr, byval pdwIDStringLen as DWORD ptr) as HRESULT
declare sub IAccIdentity_GetIdentityString_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#define __IAccPropServer_INTERFACE_DEFINED__

extern IID_IAccPropServer as const IID

type IAccPropServer as IAccPropServer_

type IAccPropServerVtbl
	QueryInterface as function(byval This as IAccPropServer ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAccPropServer ptr) as ULONG
	Release as function(byval This as IAccPropServer ptr) as ULONG
	GetPropValue as function(byval This as IAccPropServer ptr, byval pIDString as const UBYTE ptr, byval dwIDStringLen as DWORD, byval idProp as MSAAPROPID, byval pvarValue as VARIANT ptr, byval pfHasProp as WINBOOL ptr) as HRESULT
end type

type IAccPropServer_
	lpVtbl as IAccPropServerVtbl ptr
end type

declare function IAccPropServer_GetPropValue_Proxy(byval This as IAccPropServer ptr, byval pIDString as const UBYTE ptr, byval dwIDStringLen as DWORD, byval idProp as MSAAPROPID, byval pvarValue as VARIANT ptr, byval pfHasProp as WINBOOL ptr) as HRESULT
declare sub IAccPropServer_GetPropValue_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#define __IAccPropServices_INTERFACE_DEFINED__

extern IID_IAccPropServices as const IID

type IAccPropServices as IAccPropServices_

type IAccPropServicesVtbl
	QueryInterface as function(byval This as IAccPropServices ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAccPropServices ptr) as ULONG
	Release as function(byval This as IAccPropServices ptr) as ULONG
	SetPropValue as function(byval This as IAccPropServices ptr, byval pIDString as const UBYTE ptr, byval dwIDStringLen as DWORD, byval idProp as MSAAPROPID, byval var as VARIANT) as HRESULT
	SetPropServer as function(byval This as IAccPropServices ptr, byval pIDString as const UBYTE ptr, byval dwIDStringLen as DWORD, byval paProps as const MSAAPROPID ptr, byval cProps as long, byval pServer as IAccPropServer ptr, byval annoScope as AnnoScope) as HRESULT
	ClearProps as function(byval This as IAccPropServices ptr, byval pIDString as const UBYTE ptr, byval dwIDStringLen as DWORD, byval paProps as const MSAAPROPID ptr, byval cProps as long) as HRESULT
	SetHwndProp as function(byval This as IAccPropServices ptr, byval hwnd as HWND, byval idObject as DWORD, byval idChild as DWORD, byval idProp as MSAAPROPID, byval var as VARIANT) as HRESULT
	SetHwndPropStr as function(byval This as IAccPropServices ptr, byval hwnd as HWND, byval idObject as DWORD, byval idChild as DWORD, byval idProp as MSAAPROPID, byval str as LPCWSTR) as HRESULT
	SetHwndPropServer as function(byval This as IAccPropServices ptr, byval hwnd as HWND, byval idObject as DWORD, byval idChild as DWORD, byval paProps as const MSAAPROPID ptr, byval cProps as long, byval pServer as IAccPropServer ptr, byval annoScope as AnnoScope) as HRESULT
	ClearHwndProps as function(byval This as IAccPropServices ptr, byval hwnd as HWND, byval idObject as DWORD, byval idChild as DWORD, byval paProps as const MSAAPROPID ptr, byval cProps as long) as HRESULT
	ComposeHwndIdentityString as function(byval This as IAccPropServices ptr, byval hwnd as HWND, byval idObject as DWORD, byval idChild as DWORD, byval ppIDString as UBYTE ptr ptr, byval pdwIDStringLen as DWORD ptr) as HRESULT
	DecomposeHwndIdentityString as function(byval This as IAccPropServices ptr, byval pIDString as const UBYTE ptr, byval dwIDStringLen as DWORD, byval phwnd as HWND ptr, byval pidObject as DWORD ptr, byval pidChild as DWORD ptr) as HRESULT
	SetHmenuProp as function(byval This as IAccPropServices ptr, byval hmenu as HMENU, byval idChild as DWORD, byval idProp as MSAAPROPID, byval var as VARIANT) as HRESULT
	SetHmenuPropStr as function(byval This as IAccPropServices ptr, byval hmenu as HMENU, byval idChild as DWORD, byval idProp as MSAAPROPID, byval str as LPCWSTR) as HRESULT
	SetHmenuPropServer as function(byval This as IAccPropServices ptr, byval hmenu as HMENU, byval idChild as DWORD, byval paProps as const MSAAPROPID ptr, byval cProps as long, byval pServer as IAccPropServer ptr, byval annoScope as AnnoScope) as HRESULT
	ClearHmenuProps as function(byval This as IAccPropServices ptr, byval hmenu as HMENU, byval idChild as DWORD, byval paProps as const MSAAPROPID ptr, byval cProps as long) as HRESULT
	ComposeHmenuIdentityString as function(byval This as IAccPropServices ptr, byval hmenu as HMENU, byval idChild as DWORD, byval ppIDString as UBYTE ptr ptr, byval pdwIDStringLen as DWORD ptr) as HRESULT
	DecomposeHmenuIdentityString as function(byval This as IAccPropServices ptr, byval pIDString as const UBYTE ptr, byval dwIDStringLen as DWORD, byval phmenu as HMENU ptr, byval pidChild as DWORD ptr) as HRESULT
end type

type IAccPropServices_
	lpVtbl as IAccPropServicesVtbl ptr
end type

declare function IAccPropServices_SetPropValue_Proxy(byval This as IAccPropServices ptr, byval pIDString as const UBYTE ptr, byval dwIDStringLen as DWORD, byval idProp as MSAAPROPID, byval var as VARIANT) as HRESULT
declare sub IAccPropServices_SetPropValue_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAccPropServices_SetPropServer_Proxy(byval This as IAccPropServices ptr, byval pIDString as const UBYTE ptr, byval dwIDStringLen as DWORD, byval paProps as const MSAAPROPID ptr, byval cProps as long, byval pServer as IAccPropServer ptr, byval annoScope as AnnoScope) as HRESULT
declare sub IAccPropServices_SetPropServer_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAccPropServices_ClearProps_Proxy(byval This as IAccPropServices ptr, byval pIDString as const UBYTE ptr, byval dwIDStringLen as DWORD, byval paProps as const MSAAPROPID ptr, byval cProps as long) as HRESULT
declare sub IAccPropServices_ClearProps_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAccPropServices_SetHwndProp_Proxy(byval This as IAccPropServices ptr, byval hwnd as HWND, byval idObject as DWORD, byval idChild as DWORD, byval idProp as MSAAPROPID, byval var as VARIANT) as HRESULT
declare sub IAccPropServices_SetHwndProp_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAccPropServices_SetHwndPropStr_Proxy(byval This as IAccPropServices ptr, byval hwnd as HWND, byval idObject as DWORD, byval idChild as DWORD, byval idProp as MSAAPROPID, byval str as LPCWSTR) as HRESULT
declare sub IAccPropServices_SetHwndPropStr_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAccPropServices_SetHwndPropServer_Proxy(byval This as IAccPropServices ptr, byval hwnd as HWND, byval idObject as DWORD, byval idChild as DWORD, byval paProps as const MSAAPROPID ptr, byval cProps as long, byval pServer as IAccPropServer ptr, byval annoScope as AnnoScope) as HRESULT
declare sub IAccPropServices_SetHwndPropServer_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAccPropServices_ClearHwndProps_Proxy(byval This as IAccPropServices ptr, byval hwnd as HWND, byval idObject as DWORD, byval idChild as DWORD, byval paProps as const MSAAPROPID ptr, byval cProps as long) as HRESULT
declare sub IAccPropServices_ClearHwndProps_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAccPropServices_ComposeHwndIdentityString_Proxy(byval This as IAccPropServices ptr, byval hwnd as HWND, byval idObject as DWORD, byval idChild as DWORD, byval ppIDString as UBYTE ptr ptr, byval pdwIDStringLen as DWORD ptr) as HRESULT
declare sub IAccPropServices_ComposeHwndIdentityString_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAccPropServices_DecomposeHwndIdentityString_Proxy(byval This as IAccPropServices ptr, byval pIDString as const UBYTE ptr, byval dwIDStringLen as DWORD, byval phwnd as HWND ptr, byval pidObject as DWORD ptr, byval pidChild as DWORD ptr) as HRESULT
declare sub IAccPropServices_DecomposeHwndIdentityString_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAccPropServices_SetHmenuProp_Proxy(byval This as IAccPropServices ptr, byval hmenu as HMENU, byval idChild as DWORD, byval idProp as MSAAPROPID, byval var as VARIANT) as HRESULT
declare sub IAccPropServices_SetHmenuProp_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAccPropServices_SetHmenuPropStr_Proxy(byval This as IAccPropServices ptr, byval hmenu as HMENU, byval idChild as DWORD, byval idProp as MSAAPROPID, byval str as LPCWSTR) as HRESULT
declare sub IAccPropServices_SetHmenuPropStr_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAccPropServices_SetHmenuPropServer_Proxy(byval This as IAccPropServices ptr, byval hmenu as HMENU, byval idChild as DWORD, byval paProps as const MSAAPROPID ptr, byval cProps as long, byval pServer as IAccPropServer ptr, byval annoScope as AnnoScope) as HRESULT
declare sub IAccPropServices_SetHmenuPropServer_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAccPropServices_ClearHmenuProps_Proxy(byval This as IAccPropServices ptr, byval hmenu as HMENU, byval idChild as DWORD, byval paProps as const MSAAPROPID ptr, byval cProps as long) as HRESULT
declare sub IAccPropServices_ClearHmenuProps_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAccPropServices_ComposeHmenuIdentityString_Proxy(byval This as IAccPropServices ptr, byval hmenu as HMENU, byval idChild as DWORD, byval ppIDString as UBYTE ptr ptr, byval pdwIDStringLen as DWORD ptr) as HRESULT
declare sub IAccPropServices_ComposeHmenuIdentityString_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAccPropServices_DecomposeHmenuIdentityString_Proxy(byval This as IAccPropServices ptr, byval pIDString as const UBYTE ptr, byval dwIDStringLen as DWORD, byval phmenu as HMENU ptr, byval pidChild as DWORD ptr) as HRESULT
declare sub IAccPropServices_DecomposeHmenuIdentityString_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

extern __MIDL_itf_oleacc_0119_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_oleacc_0119_v0_0_s_ifspec as RPC_IF_HANDLE

#define __Accessibility_LIBRARY_DEFINED__

extern LIBID_Accessibility as const IID
extern CLSID_CAccPropServices as const CLSID

end extern

#include once "ole-common.bi"
