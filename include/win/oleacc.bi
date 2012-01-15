''
''
'' oleacc -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_oleacc_bi__
#define __win_oleacc_bi__

#inclib "oleacc"

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
#define NAVDIR_DOWN 2
#define NAVDIR_FIRSTCHILD 7
#define NAVDIR_LASTCHILD 8
#define NAVDIR_LEFT 3
#define NAVDIR_NEXT 5
#define NAVDIR_PREVIOUS 6
#define NAVDIR_RIGHT 4
#define NAVDIR_UP 1
#define ROLE_SYSTEM_ALERT 8
#define ROLE_SYSTEM_ANIMATION 54
#define ROLE_SYSTEM_APPLICATION 14
#define ROLE_SYSTEM_BORDER 19
#define ROLE_SYSTEM_BUTTONDROPDOWN 56
#define ROLE_SYSTEM_BUTTONDROPDOWNGRID 58
#define ROLE_SYSTEM_BUTTONMENU 57
#define ROLE_SYSTEM_CARET 7
#define ROLE_SYSTEM_CELL 29
#define ROLE_SYSTEM_CHARACTER 32
#define ROLE_SYSTEM_CHART 17
#define ROLE_SYSTEM_CHECKBUTTON 44
#define ROLE_SYSTEM_CLIENT 10
#define ROLE_SYSTEM_CLOCK 61
#define ROLE_SYSTEM_COLUMN 27
#define ROLE_SYSTEM_COLUMNHEADER 25
#define ROLE_SYSTEM_COMBOBOX 46
#define ROLE_SYSTEM_CURSOR 6
#define ROLE_SYSTEM_DIAGRAM 53
#define ROLE_SYSTEM_DIAL 49
#define ROLE_SYSTEM_DIALOG 18
#define ROLE_SYSTEM_DOCUMENT 15
#define ROLE_SYSTEM_DROPLIST 47
#define ROLE_SYSTEM_EQUATION 55
#define ROLE_SYSTEM_GRAPHIC 40
#define ROLE_SYSTEM_GRIP 4
#define ROLE_SYSTEM_GROUPING 20
#define ROLE_SYSTEM_HELPBALLOON 31
#define ROLE_SYSTEM_HOTKEYFIELD 50
#define ROLE_SYSTEM_INDICATOR 39
#define ROLE_SYSTEM_LINK 30
#define ROLE_SYSTEM_LIST 33
#define ROLE_SYSTEM_LISTITEM 34
#define ROLE_SYSTEM_MENUBAR 2
#define ROLE_SYSTEM_MENUITEM 12
#define ROLE_SYSTEM_MENUPOPUP 11
#define ROLE_SYSTEM_OUTLINE 35
#define ROLE_SYSTEM_OUTLINEITEM 36
#define ROLE_SYSTEM_PAGETAB 37
#define ROLE_SYSTEM_PAGETABLIST 60
#define ROLE_SYSTEM_PANE 16
#define ROLE_SYSTEM_PROGRESSBAR 48
#define ROLE_SYSTEM_PROPERTYPAGE 38
#define ROLE_SYSTEM_PUSHBUTTON 43
#define ROLE_SYSTEM_RADIOBUTTON 45
#define ROLE_SYSTEM_ROW 28
#define ROLE_SYSTEM_ROWHEADER 26
#define ROLE_SYSTEM_SCROLLBAR 3
#define ROLE_SYSTEM_SEPARATOR 21
#define ROLE_SYSTEM_SLIDER 51
#define ROLE_SYSTEM_SOUND 5
#define ROLE_SYSTEM_SPINBUTTON 52
#define ROLE_SYSTEM_STATICTEXT 41
#define ROLE_SYSTEM_STATUSBAR 23
#define ROLE_SYSTEM_TABLE 24
#define ROLE_SYSTEM_TEXT 42
#define ROLE_SYSTEM_TITLEBAR 1
#define ROLE_SYSTEM_TOOLBAR 22
#define ROLE_SYSTEM_TOOLTIP 13
#define ROLE_SYSTEM_WHITESPACE 59
#define ROLE_SYSTEM_WINDOW 9
#define STATE_SYSTEM_UNAVAILABLE &h00000001
#define STATE_SYSTEM_SELECTED &h00000002
#define STATE_SYSTEM_FOCUSED &h00000004
#define STATE_SYSTEM_PRESSED &h00000008
#define STATE_SYSTEM_CHECKED &h00000010
#define STATE_SYSTEM_MIXED &h00000020
#define STATE_SYSTEM_READONLY &h00000040
#define STATE_SYSTEM_HOTTRACKED &h00000080
#define STATE_SYSTEM_DEFAULT &h00000100
#define STATE_SYSTEM_EXPANDED &h00000200
#define STATE_SYSTEM_COLLAPSED &h00000400
#define STATE_SYSTEM_BUSY &h00000800
#define STATE_SYSTEM_FLOATING &h00001000
#define STATE_SYSTEM_MARQUEED &h00002000
#define STATE_SYSTEM_ANIMATED &h00004000
#define STATE_SYSTEM_INVISIBLE &h00008000
#define STATE_SYSTEM_OFFSCREEN &h00010000
#define STATE_SYSTEM_SIZEABLE &h00020000
#define STATE_SYSTEM_MOVEABLE &h00040000
#define STATE_SYSTEM_SELFVOICING &h00080000
#define STATE_SYSTEM_FOCUSABLE &h00100000
#define STATE_SYSTEM_SELECTABLE &h00200000
#define STATE_SYSTEM_LINKED &h00400000
#define STATE_SYSTEM_TRAVERSED &h00800000
#define STATE_SYSTEM_MULTISELECTABLE &h01000000
#define STATE_SYSTEM_EXTSELECTABLE &h02000000
#define STATE_SYSTEM_ALERT_LOW &h04000000
#define STATE_SYSTEM_ALERT_MEDIUM &h08000000
#define STATE_SYSTEM_ALERT_HIGH &h10000000
#define STATE_SYSTEM_VALID &h1fffffff

enum SELFLAG
	SELFLAG_NONE = 0
	SELFLAG_TAKEFOCUS = 1
	SELFLAG_TAKESELECTION = 2
	SELFLAG_EXTENDSELECTION = 4
	SELFLAG_ADDSELECTION = 8
	SELFLAG_REMOVESELECTION = 16
end enum

#define SELFLAG_VALID &h0000001F

extern LIBID_Accessibility alias "LIBID_Accessibility" as IID
extern IID_IAccessible alias "IID_IAccessible" as IID

type IAccessibleVtbl_ as IAccessibleVtbl

type IAccessible
	lpVtbl as IAccessibleVtbl_ ptr
end type

type IAccessibleVtbl
	QueryInterface as function(byval as IAccessible ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IAccessible ptr) as ULONG
	Release as function(byval as IAccessible ptr) as ULONG
	GetTypeInfoCount as function(byval as IAccessible ptr, byval as UINT ptr) as HRESULT
	GetTypeInfo as function(byval as IAccessible ptr, byval as UINT, byval as LCID, byval as LPTYPEINFO ptr) as HRESULT
	GetIDsOfNames as function(byval as IAccessible ptr, byval as IID ptr, byval as LPOLESTR ptr, byval as UINT, byval as LCID, byval as DISPID ptr) as HRESULT
	Invoke as function(byval as IAccessible ptr, byval as DISPID, byval as IID ptr, byval as LCID, byval as WORD, byval as DISPPARAMS ptr, byval as VARIANT_ ptr, byval as EXCEPINFO ptr, byval as UINT ptr) as HRESULT
	get_accParent as function(byval as IAccessible ptr, byval as IDispatch ptr ptr) as HRESULT
	get_accChildCount as function(byval as IAccessible ptr, byval as integer ptr) as HRESULT
	get_accChild as function(byval as IAccessible ptr, byval as VARIANT_, byval as IDispatch ptr ptr) as HRESULT
	get_accName as function(byval as IAccessible ptr, byval as VARIANT_, byval as BSTR ptr) as HRESULT
	get_accValue as function(byval as IAccessible ptr, byval as VARIANT_, byval as BSTR ptr) as HRESULT
	get_accDescription as function(byval as IAccessible ptr, byval as VARIANT_, byval as BSTR ptr) as HRESULT
	get_accRole as function(byval as IAccessible ptr, byval as VARIANT_, byval as VARIANT_ ptr) as HRESULT
	get_accState as function(byval as IAccessible ptr, byval as VARIANT_, byval as VARIANT_ ptr) as HRESULT
	get_accHelp as function(byval as IAccessible ptr, byval as VARIANT_, byval as BSTR ptr) as HRESULT
	get_accHelpTopic as function(byval as IAccessible ptr, byval as BSTR ptr, byval as VARIANT_, byval as integer ptr) as HRESULT
	get_accKeyboardShortcut as function(byval as IAccessible ptr, byval as VARIANT_, byval as BSTR ptr) as HRESULT
	get_accFocus as function(byval as IAccessible ptr, byval as VARIANT_ ptr) as HRESULT
	get_accSelection as function(byval as IAccessible ptr, byval as VARIANT_ ptr) as HRESULT
	get_accDefaultAction as function(byval as IAccessible ptr, byval as VARIANT_, byval as BSTR ptr) as HRESULT
	accSelect as function(byval as IAccessible ptr, byval as integer, byval as VARIANT_) as HRESULT
	accLocation as function(byval as IAccessible ptr, byval as integer ptr, byval as integer ptr, byval as integer ptr, byval as integer ptr, byval as VARIANT_) as HRESULT
	accNavigate as function(byval as IAccessible ptr, byval as integer, byval as VARIANT_, byval as VARIANT_ ptr) as HRESULT
	accHitTest as function(byval as IAccessible ptr, byval as integer, byval as integer, byval as VARIANT_ ptr) as HRESULT
	accDoDefaultAction as function(byval as IAccessible ptr, byval as VARIANT_) as HRESULT
	put_accName as function(byval as IAccessible ptr, byval as VARIANT_, byval as BSTR) as HRESULT
	put_accValue as function(byval as IAccessible ptr, byval as VARIANT_, byval as BSTR) as HRESULT
end type

type LPACCESSIBLE as IAccessible ptr

declare function AccessibleChildren alias "AccessibleChildren" (byval as IAccessible ptr, byval as LONG, byval as LONG, byval as VARIANT_ ptr, byval as LONG ptr) as HRESULT
declare function AccessibleObjectFromEvent alias "AccessibleObjectFromEvent" (byval as HWND, byval as DWORD, byval as DWORD, byval as IAccessible ptr, byval as VARIANT_ ptr) as HRESULT
declare function AccessibleObjectFromPoint alias "AccessibleObjectFromPoint" (byval as POINT, byval as IAccessible ptr ptr, byval as VARIANT_ ptr) as HRESULT
declare function AccessibleObjectFromWindow alias "AccessibleObjectFromWindow" (byval as HWND, byval as DWORD, byval as IID ptr, byval as any ptr ptr) as HRESULT
declare function CreateStdAccessibleObject alias "CreateStdAccessibleObject" (byval as HWND, byval as LONG, byval as IID ptr, byval as any ptr ptr) as HRESULT
declare sub GetOleaccVersionInfo alias "GetOleaccVersionInfo" (byval as DWORD ptr, byval as DWORD ptr)
declare function LresultFromObject alias "LresultFromObject" (byval as IID ptr, byval as WPARAM, byval as LPUNKNOWN) as LONG
declare function ObjectFromLresult alias "ObjectFromLresult" (byval as LONG, byval as IID ptr, byval as WPARAM, byval as any ptr ptr) as HRESULT
declare function WindowFromAccessibleObject alias "WindowFromAccessibleObject" (byval as IAccessible ptr, byval as HWND ptr) as HRESULT

#ifdef UNICODE
declare function CreateStdAccessibleProxyW alias "CreateStdAccessibleProxyW" (byval as HWND, byval as LPCWSTR, byval as LONG, byval as IID ptr, byval as any ptr ptr) as HRESULT
declare function GetRoleTextW alias "GetRoleTextW" (byval as DWORD, byval as LPWSTR, byval as UINT) as UINT
declare function GetStateTextW alias "GetStateTextW" (byval as DWORD, byval as LPWSTR, byval as UINT) as UINT
#else
declare function CreateStdAccessibleProxyA alias "CreateStdAccessibleProxyA" (byval as HWND, byval as LPCSTR, byval as LONG, byval as IID ptr, byval as any ptr ptr) as HRESULT
declare function GetRoleTextA alias "GetRoleTextA" (byval as DWORD, byval as LPSTR, byval as UINT) as UINT
declare function GetStateTextA alias "GetStateTextA" (byval as DWORD, byval as LPSTR, byval as UINT) as UINT
#endif

#endif
