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

#inclib "oleacc"

#include once "rpc.bi"
#include once "rpcndr.bi"
#include once "windows.bi"
#include once "ole2.bi"
#include once "oaidl.bi"
#include once "_mingw_unicode.bi"

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

declare function LresultFromObject(byval riid as const IID const ptr, byval wParam as WPARAM, byval punk as LPUNKNOWN) as LRESULT
declare function ObjectFromLresult(byval lResult as LRESULT, byval riid as const IID const ptr, byval wParam as WPARAM, byval ppvObject as any ptr ptr) as HRESULT
declare function WindowFromAccessibleObject(byval as IAccessible ptr, byval phwnd as HWND ptr) as HRESULT
declare function AccessibleObjectFromWindow(byval hwnd as HWND, byval dwId as DWORD, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
declare function AccessibleObjectFromEvent(byval hwnd as HWND, byval dwId as DWORD, byval dwChildId as DWORD, byval ppacc as IAccessible ptr ptr, byval pvarChild as VARIANT ptr) as HRESULT
declare function AccessibleObjectFromPoint(byval ptScreen as POINT, byval ppacc as IAccessible ptr ptr, byval pvarChild as VARIANT ptr) as HRESULT
declare function AccessibleChildren(byval paccContainer as IAccessible ptr, byval iChildStart as LONG, byval cChildren as LONG, byval rgvarChildren as VARIANT ptr, byval pcObtained as LONG ptr) as HRESULT
declare function GetRoleTextA(byval lRole as DWORD, byval lpszRole as LPSTR, byval cchRoleMax as UINT) as UINT

#ifndef UNICODE
	declare function GetRoleText alias "GetRoleTextA"(byval lRole as DWORD, byval lpszRole as LPSTR, byval cchRoleMax as UINT) as UINT
#endif

declare function GetRoleTextW(byval lRole as DWORD, byval lpszRole as LPWSTR, byval cchRoleMax as UINT) as UINT

#ifdef UNICODE
	declare function GetRoleText alias "GetRoleTextW"(byval lRole as DWORD, byval lpszRole as LPWSTR, byval cchRoleMax as UINT) as UINT
#endif

declare function GetStateTextA(byval lStateBit as DWORD, byval lpszState as LPSTR, byval cchState as UINT) as UINT

#ifndef UNICODE
	declare function GetStateText alias "GetStateTextA"(byval lStateBit as DWORD, byval lpszState as LPSTR, byval cchState as UINT) as UINT
#endif

declare function GetStateTextW(byval lStateBit as DWORD, byval lpszState as LPWSTR, byval cchState as UINT) as UINT

#ifdef UNICODE
	declare function GetStateText alias "GetStateTextW"(byval lStateBit as DWORD, byval lpszState as LPWSTR, byval cchState as UINT) as UINT
#endif

declare sub GetOleaccVersionInfo(byval pVer as DWORD ptr, byval pBuild as DWORD ptr)
declare function CreateStdAccessibleObject(byval hwnd as HWND, byval idObject as LONG, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
declare function CreateStdAccessibleProxyA(byval hwnd as HWND, byval pClassName as LPCSTR, byval idObject as LONG, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT

#ifndef UNICODE
	declare function CreateStdAccessibleProxy alias "CreateStdAccessibleProxyA"(byval hwnd as HWND, byval pClassName as LPCSTR, byval idObject as LONG, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
#endif

declare function CreateStdAccessibleProxyW(byval hwnd as HWND, byval pClassName as LPCWSTR, byval idObject as LONG, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT

#ifdef UNICODE
	declare function CreateStdAccessibleProxy alias "CreateStdAccessibleProxyW"(byval hwnd as HWND, byval pClassName as LPCWSTR, byval idObject as LONG, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
#endif

const MSAA_MENU_SIG = &hAA0DF00D

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

const NAVDIR_MIN = 0
const NAVDIR_UP = &h1
const NAVDIR_DOWN = &h2
const NAVDIR_LEFT = &h3
const NAVDIR_RIGHT = &h4
const NAVDIR_NEXT = &h5
const NAVDIR_PREVIOUS = &h6
const NAVDIR_FIRSTCHILD = &h7
const NAVDIR_LASTCHILD = &h8
const NAVDIR_MAX = &h9
const SELFLAG_NONE = 0
const SELFLAG_TAKEFOCUS = &h1
const SELFLAG_TAKESELECTION = &h2
const SELFLAG_EXTENDSELECTION = &h4
const SELFLAG_ADDSELECTION = &h8
const SELFLAG_REMOVESELECTION = &h10
const SELFLAG_VALID = &h1f
const STATE_SYSTEM_HASPOPUP = &h40000000
const ROLE_SYSTEM_TITLEBAR = &h1
const ROLE_SYSTEM_MENUBAR = &h2
const ROLE_SYSTEM_SCROLLBAR = &h3
const ROLE_SYSTEM_GRIP = &h4
const ROLE_SYSTEM_SOUND = &h5
const ROLE_SYSTEM_CURSOR = &h6
const ROLE_SYSTEM_CARET = &h7
const ROLE_SYSTEM_ALERT = &h8
const ROLE_SYSTEM_WINDOW = &h9
const ROLE_SYSTEM_CLIENT = &ha
const ROLE_SYSTEM_MENUPOPUP = &hb
const ROLE_SYSTEM_MENUITEM = &hc
const ROLE_SYSTEM_TOOLTIP = &hd
const ROLE_SYSTEM_APPLICATION = &he
const ROLE_SYSTEM_DOCUMENT = &hf
const ROLE_SYSTEM_PANE = &h10
const ROLE_SYSTEM_CHART = &h11
const ROLE_SYSTEM_DIALOG = &h12
const ROLE_SYSTEM_BORDER = &h13
const ROLE_SYSTEM_GROUPING = &h14
const ROLE_SYSTEM_SEPARATOR = &h15
const ROLE_SYSTEM_TOOLBAR = &h16
const ROLE_SYSTEM_STATUSBAR = &h17
const ROLE_SYSTEM_TABLE = &h18
const ROLE_SYSTEM_COLUMNHEADER = &h19
const ROLE_SYSTEM_ROWHEADER = &h1a
const ROLE_SYSTEM_COLUMN = &h1b
const ROLE_SYSTEM_ROW = &h1c
const ROLE_SYSTEM_CELL = &h1d
const ROLE_SYSTEM_LINK = &h1e
const ROLE_SYSTEM_HELPBALLOON = &h1f
const ROLE_SYSTEM_CHARACTER = &h20
const ROLE_SYSTEM_LIST = &h21
const ROLE_SYSTEM_LISTITEM = &h22
const ROLE_SYSTEM_OUTLINE = &h23
const ROLE_SYSTEM_OUTLINEITEM = &h24
const ROLE_SYSTEM_PAGETAB = &h25
const ROLE_SYSTEM_PROPERTYPAGE = &h26
const ROLE_SYSTEM_INDICATOR = &h27
const ROLE_SYSTEM_GRAPHIC = &h28
const ROLE_SYSTEM_STATICTEXT = &h29
const ROLE_SYSTEM_TEXT = &h2a
const ROLE_SYSTEM_PUSHBUTTON = &h2b
const ROLE_SYSTEM_CHECKBUTTON = &h2c
const ROLE_SYSTEM_RADIOBUTTON = &h2d
const ROLE_SYSTEM_COMBOBOX = &h2e
const ROLE_SYSTEM_DROPLIST = &h2f
const ROLE_SYSTEM_PROGRESSBAR = &h30
const ROLE_SYSTEM_DIAL = &h31
const ROLE_SYSTEM_HOTKEYFIELD = &h32
const ROLE_SYSTEM_SLIDER = &h33
const ROLE_SYSTEM_SPINBUTTON = &h34
const ROLE_SYSTEM_DIAGRAM = &h35
const ROLE_SYSTEM_ANIMATION = &h36
const ROLE_SYSTEM_EQUATION = &h37
const ROLE_SYSTEM_BUTTONDROPDOWN = &h38
const ROLE_SYSTEM_BUTTONMENU = &h39
const ROLE_SYSTEM_BUTTONDROPDOWNGRID = &h3a
const ROLE_SYSTEM_WHITESPACE = &h3b
const ROLE_SYSTEM_PAGETABLIST = &h3c
const ROLE_SYSTEM_CLOCK = &h3d
const ROLE_SYSTEM_SPLITBUTTON = &h3e
const ROLE_SYSTEM_IPADDRESS = &h3f
const ROLE_SYSTEM_OUTLINEBUTTON = &h40
#define __IAccessible_INTERFACE_DEFINED__
type LPACCESSIBLE as IAccessible ptr
const DISPID_ACC_PARENT = -5000
const DISPID_ACC_CHILDCOUNT = -5001
const DISPID_ACC_CHILD = -5002
const DISPID_ACC_NAME = -5003
const DISPID_ACC_VALUE = -5004
const DISPID_ACC_DESCRIPTION = -5005
const DISPID_ACC_ROLE = -5006
const DISPID_ACC_STATE = -5007
const DISPID_ACC_HELP = -5008
const DISPID_ACC_HELPTOPIC = -5009
const DISPID_ACC_KEYBOARDSHORTCUT = -5010
const DISPID_ACC_FOCUS = -5011
const DISPID_ACC_SELECTION = -5012
const DISPID_ACC_DEFAULTACTION = -5013
const DISPID_ACC_SELECT = -5014
const DISPID_ACC_LOCATION = -5015
const DISPID_ACC_NAVIGATE = -5016
const DISPID_ACC_HITTEST = -5017
const DISPID_ACC_DODEFAULTACTION = -5018
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

#define IAccessible_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IAccessible_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IAccessible_Release(This) (This)->lpVtbl->Release(This)
#define IAccessible_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IAccessible_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IAccessible_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IAccessible_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IAccessible_get_accParent(This, ppdispParent) (This)->lpVtbl->get_accParent(This, ppdispParent)
#define IAccessible_get_accChildCount(This, pcountChildren) (This)->lpVtbl->get_accChildCount(This, pcountChildren)
#define IAccessible_get_accChild(This, varChildID, ppdispChild) (This)->lpVtbl->get_accChild(This, varChildID, ppdispChild)
#define IAccessible_get_accName(This, varID, pszName) (This)->lpVtbl->get_accName(This, varID, pszName)
#define IAccessible_get_accValue(This, varID, pszValue) (This)->lpVtbl->get_accValue(This, varID, pszValue)
#define IAccessible_get_accDescription(This, varID, pszDescription) (This)->lpVtbl->get_accDescription(This, varID, pszDescription)
#define IAccessible_get_accRole(This, varID, pvarRole) (This)->lpVtbl->get_accRole(This, varID, pvarRole)
#define IAccessible_get_accState(This, varID, pvarState) (This)->lpVtbl->get_accState(This, varID, pvarState)
#define IAccessible_get_accHelp(This, varID, pszHelp) (This)->lpVtbl->get_accHelp(This, varID, pszHelp)
#define IAccessible_get_accHelpTopic(This, pszHelpFile, varID, pidTopic) (This)->lpVtbl->get_accHelpTopic(This, pszHelpFile, varID, pidTopic)
#define IAccessible_get_accKeyboardShortcut(This, varID, pszKeyboardShortcut) (This)->lpVtbl->get_accKeyboardShortcut(This, varID, pszKeyboardShortcut)
#define IAccessible_get_accFocus(This, pvarID) (This)->lpVtbl->get_accFocus(This, pvarID)
#define IAccessible_get_accSelection(This, pvarID) (This)->lpVtbl->get_accSelection(This, pvarID)
#define IAccessible_get_accDefaultAction(This, varID, pszDefaultAction) (This)->lpVtbl->get_accDefaultAction(This, varID, pszDefaultAction)
#define IAccessible_accSelect(This, flagsSelect, varID) (This)->lpVtbl->accSelect(This, flagsSelect, varID)
#define IAccessible_accLocation(This, pxLeft, pyTop, pcxWidth, pcyHeight, varID) (This)->lpVtbl->accLocation(This, pxLeft, pyTop, pcxWidth, pcyHeight, varID)
#define IAccessible_accNavigate(This, navDir, varStart, pvarEnd) (This)->lpVtbl->accNavigate(This, navDir, varStart, pvarEnd)
#define IAccessible_accHitTest(This, xLeft, yTop, pvarID) (This)->lpVtbl->accHitTest(This, xLeft, yTop, pvarID)
#define IAccessible_accDoDefaultAction(This, varID) (This)->lpVtbl->accDoDefaultAction(This, varID)
#define IAccessible_put_accName(This, varID, pszName) (This)->lpVtbl->put_accName(This, varID, pszName)
#define IAccessible_put_accValue(This, varID, pszValue) (This)->lpVtbl->put_accValue(This, varID, pszValue)

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

#define IAccessibleHandler_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IAccessibleHandler_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IAccessibleHandler_Release(This) (This)->lpVtbl->Release(This)
#define IAccessibleHandler_AccessibleObjectFromID(This, hwnd, lObjectID, pIAccessible) (This)->lpVtbl->AccessibleObjectFromID(This, hwnd, lObjectID, pIAccessible)
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

#define IAccIdentity_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IAccIdentity_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IAccIdentity_Release(This) (This)->lpVtbl->Release(This)
#define IAccIdentity_GetIdentityString(This, dwIDChild, ppIDString, pdwIDStringLen) (This)->lpVtbl->GetIdentityString(This, dwIDChild, ppIDString, pdwIDStringLen)
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

#define IAccPropServer_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IAccPropServer_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IAccPropServer_Release(This) (This)->lpVtbl->Release(This)
#define IAccPropServer_GetPropValue(This, pIDString, dwIDStringLen, idProp, pvarValue, pfHasProp) (This)->lpVtbl->GetPropValue(This, pIDString, dwIDStringLen, idProp, pvarValue, pfHasProp)
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

#define IAccPropServices_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IAccPropServices_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IAccPropServices_Release(This) (This)->lpVtbl->Release(This)
#define IAccPropServices_SetPropValue(This, pIDString, dwIDStringLen, idProp, var) (This)->lpVtbl->SetPropValue(This, pIDString, dwIDStringLen, idProp, var)
#define IAccPropServices_SetPropServer(This, pIDString, dwIDStringLen, paProps, cProps, pServer, annoScope) (This)->lpVtbl->SetPropServer(This, pIDString, dwIDStringLen, paProps, cProps, pServer, annoScope)
#define IAccPropServices_ClearProps(This, pIDString, dwIDStringLen, paProps, cProps) (This)->lpVtbl->ClearProps(This, pIDString, dwIDStringLen, paProps, cProps)
#define IAccPropServices_SetHwndProp(This, hwnd, idObject, idChild, idProp, var) (This)->lpVtbl->SetHwndProp(This, hwnd, idObject, idChild, idProp, var)
#define IAccPropServices_SetHwndPropStr(This, hwnd, idObject, idChild, idProp, str) (This)->lpVtbl->SetHwndPropStr(This, hwnd, idObject, idChild, idProp, str)
#define IAccPropServices_SetHwndPropServer(This, hwnd, idObject, idChild, paProps, cProps, pServer, annoScope) (This)->lpVtbl->SetHwndPropServer(This, hwnd, idObject, idChild, paProps, cProps, pServer, annoScope)
#define IAccPropServices_ClearHwndProps(This, hwnd, idObject, idChild, paProps, cProps) (This)->lpVtbl->ClearHwndProps(This, hwnd, idObject, idChild, paProps, cProps)
#define IAccPropServices_ComposeHwndIdentityString(This, hwnd, idObject, idChild, ppIDString, pdwIDStringLen) (This)->lpVtbl->ComposeHwndIdentityString(This, hwnd, idObject, idChild, ppIDString, pdwIDStringLen)
#define IAccPropServices_DecomposeHwndIdentityString(This, pIDString, dwIDStringLen, phwnd, pidObject, pidChild) (This)->lpVtbl->DecomposeHwndIdentityString(This, pIDString, dwIDStringLen, phwnd, pidObject, pidChild)
#define IAccPropServices_SetHmenuProp(This, hmenu, idChild, idProp, var) (This)->lpVtbl->SetHmenuProp(This, hmenu, idChild, idProp, var)
#define IAccPropServices_SetHmenuPropStr(This, hmenu, idChild, idProp, str) (This)->lpVtbl->SetHmenuPropStr(This, hmenu, idChild, idProp, str)
#define IAccPropServices_SetHmenuPropServer(This, hmenu, idChild, paProps, cProps, pServer, annoScope) (This)->lpVtbl->SetHmenuPropServer(This, hmenu, idChild, paProps, cProps, pServer, annoScope)
#define IAccPropServices_ClearHmenuProps(This, hmenu, idChild, paProps, cProps) (This)->lpVtbl->ClearHmenuProps(This, hmenu, idChild, paProps, cProps)
#define IAccPropServices_ComposeHmenuIdentityString(This, hmenu, idChild, ppIDString, pdwIDStringLen) (This)->lpVtbl->ComposeHmenuIdentityString(This, hmenu, idChild, ppIDString, pdwIDStringLen)
#define IAccPropServices_DecomposeHmenuIdentityString(This, pIDString, dwIDStringLen, phmenu, pidChild) (This)->lpVtbl->DecomposeHmenuIdentityString(This, pIDString, dwIDStringLen, phmenu, pidChild)

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
