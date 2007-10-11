''
''
'' prsht -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_prsht_bi__
#define __win_prsht_bi__

#define MAXPROPPAGES 100
#define PSP_DEFAULT 0
#define PSP_DLGINDIRECT 1
#define PSP_USEHICON 2
#define PSP_USEICONID 4
#define PSP_USETITLE 8
#define PSP_RTLREADING 16
#define PSP_HASHELP 32
#define PSP_USEREFPARENT 64
#define PSP_USECALLBACK 128
#define PSP_PREMATURE 1024
#define PSPCB_RELEASE 1
#define PSPCB_CREATE 2
#define PSH_DEFAULT 0
#define PSH_PROPTITLE 1
#define PSH_USEHICON 2
#define PSH_USEICONID 4
#define PSH_PROPSHEETPAGE 8
#define PSH_WIZARDHASFINISH 16
#define PSH_WIZARD 32
#define PSH_USEPSTARTPAGE 64
#define PSH_NOAPPLYNOW 128
#define PSH_USECALLBACK 256
#define PSH_HASHELP 512
#define PSH_MODELESS 1024
#define PSH_RTLREADING 2048
#define PSH_WIZARDCONTEXTHELP 4096
#define PSCB_INITIALIZED 1
#define PSCB_PRECREATE 2
#define PSM_GETTABCONTROL 1140
#define PSM_GETCURRENTPAGEHWND 1142
#define PSM_ISDIALOGMESSAGE 1141
#define PSM_PRESSBUTTON 1137
#define PSM_SETCURSELID 1138
#define PSM_SETFINISHTEXTW 1145
#define PSM_SETFINISHTEXTA 1139
#define PSN_FIRST (-200)
#define PSN_LAST (-299)
#define PSN_APPLY (-202)
#define PSN_HELP (-205)
#define PSN_KILLACTIVE (-201)
#define PSN_QUERYCANCEL (-209)
#define PSN_RESET (-203)
#define PSN_SETACTIVE (-200)
#define PSN_WIZBACK (-206)
#define PSN_WIZFINISH (-208)
#define PSN_WIZNEXT (-207)
#define PSNRET_NOERROR 0
#define PSNRET_INVALID 1
#define PSNRET_INVALID_NOCHANGEPAGE 2
#define ID_PSRESTARTWINDOWS 2
#define ID_PSREBOOTSYSTEM 3
#define WIZ_CXDLG 276
#define WIZ_CYDLG 140
#define WIZ_CXBMP 80
#define WIZ_BODYX 92
#define WIZ_BODYCX 184
#define PROP_SM_CXDLG 212
#define PROP_SM_CYDLG 188
#define PROP_MED_CXDLG 227
#define PROP_MED_CYDLG 215
#define PROP_LG_CXDLG 252
#define PROP_LG_CYDLG 218
#define PSBTN_MAX 6
#define PSBTN_BACK 0
#define PSBTN_NEXT 1
#define PSBTN_FINISH 2
#define PSBTN_OK 3
#define PSBTN_APPLYNOW 4
#define PSBTN_CANCEL 5
#define PSBTN_HELP 6
#define PSWIZB_BACK 1
#define PSWIZB_NEXT 2
#define PSWIZB_FINISH 4
#define PSWIZB_DISABLEDFINISH 8
#define PSM_SETWIZBUTTONS (1024+112)
#define PSM_APPLY (1024+110)
#define PSM_UNCHANGED (1024+109)
#define PSM_QUERYSIBLINGS (1024+108)
#define PSM_CANCELTOCLOSE (1024+107)
#define PSM_REBOOTSYSTEM (1024+106)
#define PSM_RESTARTWINDOWS (1024+105)
#define PSM_CHANGED (1024+104)
#define PSM_ADDPAGE (1024+103)
#define PSM_REMOVEPAGE (1024+102)
#define PSM_SETCURSEL (1024+101)
#define PSM_SETTITLEA (1024+111)
#define PSM_SETTITLEW (1024+120)

#ifndef UNICODE

type PROPSHEETPAGEA field=8
	dwSize as DWORD
	dwFlags as DWORD
	hInstance as HINSTANCE
	union
		pszTemplate as LPCSTR
		pResource as LPCDLGTEMPLATE
	end union
	union
		hIcon as HICON
		pszIcon as LPCSTR
	end union
	pszTitle as LPCSTR
	pfnDlgProc as DLGPROC
	lParam as LPARAM
	pfnCallback as function (byval as HWND, byval as UINT, byval as PROPSHEETPAGEA ptr) as UINT
	pcRefParent as UINT ptr
end type

type LPPROPSHEETPAGEA as PROPSHEETPAGEA ptr
type LPCPROPSHEETPAGEA as PROPSHEETPAGEA ptr
type LPFNPSPCALLBACKA as function (byval as HWND, byval as UINT, byval as LPPROPSHEETPAGEA) as UINT

#else ''UNICODE
type PROPSHEETPAGEW field=8
	dwSize as DWORD
	dwFlags as DWORD
	hInstance as HINSTANCE
	union
		pszTemplate as LPCWSTR
		pResource as LPCDLGTEMPLATE
	end union
	union
		hIcon as HICON
		pszIcon as LPCWSTR
	end union
	pszTitle as LPCWSTR
	pfnDlgProc as DLGPROC
	lParam as LPARAM
	pfnCallback as function (byval as HWND, byval as UINT, byval as PROPSHEETPAGEW ptr) as UINT
	pcRefParent as UINT ptr
end type

type LPPROPSHEETPAGEW as PROPSHEETPAGEW ptr
type LPCPROPSHEETPAGEW as PROPSHEETPAGEA ptr
type LPFNPSPCALLBACKW as function (byval as HWND, byval as UINT, byval as LPPROPSHEETPAGEW) as UINT
#endif ''UNICODE

type PFNPROPSHEETCALLBACK as function (byval as HWND, byval as UINT, byval as LPARAM) as integer

type HPROPSHEETPAGE__
	i as integer
end type

type HPROPSHEETPAGE as HPROPSHEETPAGE__ ptr

#ifndef UNICODE
type PROPSHEETHEADERA field=8
	dwSize as DWORD
	dwFlags as DWORD
	hwndParent as HWND
	hInstance as HINSTANCE
	union
		hIcon as HICON
		pszIcon as LPCSTR
	end union
	pszCaption as LPCSTR
	nPages as UINT
	union
		nStartPage as UINT
		pStartPage as LPCSTR
	end union
	union
		ppsp as LPCPROPSHEETPAGEA
		phpage as HPROPSHEETPAGE ptr
	end union
	pfnCallback as PFNPROPSHEETCALLBACK
end type

type LPPROPSHEETHEADERA as PROPSHEETHEADERA ptr
type LPCPROPSHEETHEADERA as PROPSHEETHEADERA ptr

#else ''UNICODE
type PROPSHEETHEADERW field=8
	dwSize as DWORD
	dwFlags as DWORD
	hwndParent as HWND
	hInstance as HINSTANCE
	union
		hIcon as HICON
		pszIcon as LPCWSTR
	end union
	pszCaption as LPCWSTR
	nPages as UINT
	union
		nStartPage as UINT
		pStartPage as LPCWSTR
	end union
	union
		ppsp as LPCPROPSHEETPAGEW
		phpage as HPROPSHEETPAGE ptr
	end union
	pfnCallback as PFNPROPSHEETCALLBACK
end type

type LPPROPSHEETHEADERW as PROPSHEETHEADERW ptr
type LPCPROPSHEETHEADERW as PROPSHEETHEADERW ptr
#endif ''UNICODE

type LPFNADDPROPSHEETPAGE as function (byval as HPROPSHEETPAGE, byval as LPARAM) as BOOL
type LPFNADDPROPSHEETPAGES as function (byval as LPVOID, byval as LPFNADDPROPSHEETPAGE, byval as LPARAM) as BOOL

type PSHNOTIFY field=8
	hdr as NMHDR
	lParam as LPARAM
end type

type LPPSHNOTIFY as PSHNOTIFY ptr

declare function DestroyPropertySheetPage alias "DestroyPropertySheetPage" (byval as HPROPSHEETPAGE) as BOOL

#define PropSheet_AddPage(d,p) SendMessage(d,PSM_ADDPAGE,0,cint( p))
#define PropSheet_Apply(d) SendMessage(d,PSM_APPLY,0,0)
#define PropSheet_CancelToClose(d) SendMessage(d,PSM_CANCELTOCLOSE,0,0)
#define PropSheet_Changed(d,w) SendMessage(d,PSM_CHANGED,cuint( w),0)
#define PropSheet_GetCurrentPageHwnd(d) cptr(HWND, SendMessage(d,PSM_GETCURRENTPAGEHWND,0,0)
#define PropSheet_GetTabControl(d) cptr(HWND, SendMessage(d,PSM_GETTABCONTROL,0,0))
#define PropSheet_IsDialogMessage(d,m) SendMessage(d,PSM_ISDIALOGMESSAGE,0,cint( m))
#define PropSheet_PressButton(d,i) SendMessage(d,PSM_PRESSBUTTON,i,0)
#define PropSheet_QuerySiblings(d,w,l) SendMessage(d,PSM_QUERYSIBLINGS,w,l)
#define PropSheet_RebootSystem(d) SendMessage(d,PSM_REBOOTSYSTEM,0,0)
#define PropSheet_RemovePage(d,i,p) SendMessage(d,PSM_REMOVEPAGE,i,cint( p))
#define PropSheet_RestartWindows(d) SendMessage(d,PSM_RESTARTWINDOWS,0,0)
#define PropSheet_SetCurSel(d,p,i) SendMessage(d,PSM_SETCURSEL,i,cint( p))
#define PropSheet_SetCurSelByID(d,i) SendMessage(d,PSM_SETCURSELID,0,i)
#define PropSheet_SetFinishText(d,s) SendMessage(d,PSM_SETFINISHTEXT,0,cint( s))
#define PropSheet_SetTitle(d,w,s) SendMessage(d,PSM_SETTITLE,w,cint( s))
#define PropSheet_SetWizButtons(d,f) PostMessage(d,PSM_SETWIZBUTTONS,0,cint( f))
#define PropSheet_UnChanged(d,w) SendMessage(d,PSM_UNCHANGED,cuint( w),0)

#ifdef UNICODE
type LPFNPSPCALLBACK	as LPFNPSPCALLBACKW
type PROPSHEETPAGE	as PROPSHEETPAGEW
type LPPROPSHEETPAGE	as LPPROPSHEETPAGEW
type LPCPROPSHEETPAGE	as LPCPROPSHEETPAGEW
type PROPSHEETHEADER	as PROPSHEETHEADERW
type LPPROPSHEETHEADER	as LPPROPSHEETHEADERW
type LPCPROPSHEETHEADER	as LPCPROPSHEETHEADERW
#define PSM_SETTITLE PSM_SETTITLEW
#define PSM_SETFINISHTEXT PSM_SETFINISHTEXTW

declare function CreatePropertySheetPage alias "CreatePropertySheetPageW" (byval as LPCPROPSHEETPAGEW) as HPROPSHEETPAGE
declare function PropertySheet alias "PropertySheetW" (byval as LPCPROPSHEETHEADERW) as integer

#else ''UNICODE
type LPFNPSPCALLBACK	as LPFNPSPCALLBACKA
type PROPSHEETPAGE	as PROPSHEETPAGEA
type LPPROPSHEETPAGE	as LPPROPSHEETPAGEA
type LPCPROPSHEETPAGE	as LPCPROPSHEETPAGEA
type PROPSHEETHEADER	as PROPSHEETHEADERA
type LPPROPSHEETHEADER	as LPPROPSHEETHEADERA
type LPCPROPSHEETHEADER	as LPCPROPSHEETHEADERA
#define PSM_SETTITLE PSM_SETTITLEA
#define PSM_SETFINISHTEXT PSM_SETFINISHTEXTA

declare function CreatePropertySheetPage alias "CreatePropertySheetPageA" (byval as LPCPROPSHEETPAGEA) as HPROPSHEETPAGE
declare function PropertySheet alias "PropertySheetA" (byval as LPCPROPSHEETHEADERA) as integer

#endif ''UNICODE


#endif
