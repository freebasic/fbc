''
''
'' oledlg -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_oledlg_bi__
#define __win_oledlg_bi__

#inclib "oledlg"

#include once "windows.bi"
#include once "win/shellapi.bi"
#include once "win/commdlg.bi"
#include once "win/ole2.bi"
#include once "win/dlgs.bi"
#include once "win/prsht.bi"

#define PS_MAXLINKTYPES 8
#define OLESTDDELIM $"\"
#define SZOLEUI_MSG_HELP "OLEUI_MSG_HELP"
#define SZOLEUI_MSG_ENDDIALOG "OLEUI_MSG_ENDDIALOG"
#define SZOLEUI_MSG_BROWSE "OLEUI_MSG_BROWSE"
#define SZOLEUI_MSG_CHANGEICON "OLEUI_MSG_CHANGEICON"
#define SZOLEUI_MSG_CLOSEBUSYDIALOG "OLEUI_MSG_CLOSEBUSYDIALOG"
#define SZOLEUI_MSG_CONVERT "OLEUI_MSG_CONVERT"
#define SZOLEUI_MSG_CHANGESOURCE "OLEUI_MSG_CHANGESOURCE"
#define SZOLEUI_MSG_ADDCONTROL "OLEUI_MSG_ADDCONTROL"
#define SZOLEUI_MSG_BROWSE_OFN "OLEUI_MSG_BROWSE_OFN"
#define PROP_HWND_CHGICONDLG "HWND_CIDLG"
#define IDC_OLEUIHELP 99
#define IDC_IO_CREATENEW 2100
#define IDC_IO_CREATEFROMFILE 2101
#define IDC_IO_LINKFILE 2102
#define IDC_IO_OBJECTTYPELIST 2103
#define IDC_IO_DISPLAYASICON 2104
#define IDC_IO_CHANGEICON 2105
#define IDC_IO_FILE 2106
#define IDC_IO_FILEDISPLAY 2107
#define IDC_IO_RESULTIMAGE 2108
#define IDC_IO_RESULTTEXT 2109
#define IDC_IO_ICONDISPLAY 2110
#define IDC_IO_OBJECTTYPETEXT 2111
#define IDC_IO_FILETEXT 2112
#define IDC_IO_FILETYPE 2113
#define IDC_IO_INSERTCONTROL 2114
#define IDC_IO_ADDCONTROL 2115
#define IDC_IO_CONTROLTYPELIST 2116
#define IDC_PS_PASTE 500
#define IDC_PS_PASTELINK 501
#define IDC_PS_SOURCETEXT 502
#define IDC_PS_PASTELIST 503
#define IDC_PS_PASTELINKLIST 504
#define IDC_PS_DISPLAYLIST 505
#define IDC_PS_DISPLAYASICON 506
#define IDC_PS_ICONDISPLAY 507
#define IDC_PS_CHANGEICON 508
#define IDC_PS_RESULTIMAGE 509
#define IDC_PS_RESULTTEXT 510
#define IDC_CI_GROUP 120
#define IDC_CI_CURRENT 121
#define IDC_CI_CURRENTICON 122
#define IDC_CI_DEFAULT 123
#define IDC_CI_DEFAULTICON 124
#define IDC_CI_FROMFILE 125
#define IDC_CI_FROMFILEEDIT 126
#define IDC_CI_ICONLIST 127
#define IDC_CI_LABEL 128
#define IDC_CI_LABELEDIT 129
#define IDC_CI_BROWSE 130
#define IDC_CI_ICONDISPLAY 131
#define IDC_CV_OBJECTTYPE 150
#define IDC_CV_DISPLAYASICON 152
#define IDC_CV_CHANGEICON 153
#define IDC_CV_ACTIVATELIST 154
#define IDC_CV_CONVERTTO 155
#define IDC_CV_ACTIVATEAS 156
#define IDC_CV_RESULTTEXT 157
#define IDC_CV_CONVERTLIST 158
#define IDC_CV_ICONDISPLAY 165
#define IDC_EL_CHANGESOURCE 201
#define IDC_EL_AUTOMATIC 202
#define IDC_EL_CANCELLINK 209
#define IDC_EL_UPDATENOW 210
#define IDC_EL_OPENSOURCE 211
#define IDC_EL_MANUAL 212
#define IDC_EL_LINKSOURCE 216
#define IDC_EL_LINKTYPE 217
#define IDC_EL_LINKSLISTBOX 206
#define IDC_EL_COL1 220
#define IDC_EL_COL2 221
#define IDC_EL_COL3 222
#define IDC_BZ_RETRY 600
#define IDC_BZ_ICON 601
#define IDC_BZ_MESSAGE1 602
#define IDC_BZ_SWITCHTO 604
#define IDC_UL_METER 1029
#define IDC_UL_STOP 1030
#define IDC_UL_PERCENT 1031
#define IDC_UL_PROGRESS 1032
#define IDC_PU_LINKS 900
#define IDC_PU_TEXT 901
#define IDC_PU_CONVERT 902
#define IDC_PU_ICON 908
#define IDC_GP_OBJECTNAME 1009
#define IDC_GP_OBJECTTYPE 1010
#define IDC_GP_OBJECTSIZE 1011
#define IDC_GP_CONVERT 1013
#define IDC_GP_OBJECTICON 1014
#define IDC_GP_OBJECTLOCATION 1022
#define IDC_VP_PERCENT 1000
#define IDC_VP_CHANGEICON 1001
#define IDC_VP_EDITABLE 1002
#define IDC_VP_ASICON 1003
#define IDC_VP_RELATIVE 1005
#define IDC_VP_SPIN 1006
#define IDC_VP_SCALETXT 1034
#define IDC_VP_ICONDISPLAY 1021
#define IDC_VP_RESULTIMAGE 1033
#define IDC_LP_OPENSOURCE 1006
#define IDC_LP_UPDATENOW 1007
#define IDC_LP_BREAKLINK 1008
#define IDC_LP_LINKSOURCE 1012
#define IDC_LP_CHANGESOURCE 1015
#define IDC_LP_AUTOMATIC 1016
#define IDC_LP_MANUAL 1017
#define IDC_LP_DATE 1018
#define IDC_LP_TIME 1019
#define IDD_INSERTOBJECT 1000
#define IDD_CHANGEICON 1001
#define IDD_CONVERT 1002
#define IDD_PASTESPECIAL 1003
#define IDD_EDITLINKS 1004
#define IDD_BUSY 1006
#define IDD_UPDATELINKS 1007
#define IDD_CHANGESOURCE 1009
#define IDD_INSERTFILEBROWSE 1010
#define IDD_CHANGEICONBROWSE 1011
#define IDD_CONVERTONLY 1012
#define IDD_CHANGESOURCE4 1013
#define IDD_GNRLPROPS 1100
#define IDD_VIEWPROPS 1101
#define IDD_LINKPROPS 1102
#define IDD_CANNOTUPDATELINK 1008
#define IDD_LINKSOURCEUNAVAILABLE 1020
#define IDD_SERVERNOTFOUND 1023
#define IDD_OUTOFMEMORY 1024
#define IDD_SERVERNOTREGW 1021
#define IDD_LINKTYPECHANGEDW 1022
#define IDD_SERVERNOTREGA 1025
#define IDD_LINKTYPECHANGEDA 1026
#define ID_BROWSE_CHANGEICON 1
#define ID_BROWSE_INSERTFILE 2
#define ID_BROWSE_ADDCONTROL 3
#define ID_BROWSE_CHANGESOURCE 4
#define OLEUI_FALSE 0
#define OLEUI_SUCCESS 1
#define OLEUI_OK 1
#define OLEUI_CANCEL 2
#define OLEUI_ERR_STANDARDMIN 100
#define OLEUI_ERR_STRUCTURENULL 101
#define OLEUI_ERR_STRUCTUREINVALID 102
#define OLEUI_ERR_CBSTRUCTINCORRECT 103
#define OLEUI_ERR_HWNDOWNERINVALID 104
#define OLEUI_ERR_LPSZCAPTIONINVALID 105
#define OLEUI_ERR_LPFNHOOKINVALID 106
#define OLEUI_ERR_HINSTANCEINVALID 107
#define OLEUI_ERR_LPSZTEMPLATEINVALID 108
#define OLEUI_ERR_HRESOURCEINVALID 109
#define OLEUI_ERR_FINDTEMPLATEFAILURE 110
#define OLEUI_ERR_LOADTEMPLATEFAILURE 111
#define OLEUI_ERR_DIALOGFAILURE 112
#define OLEUI_ERR_LOCALMEMALLOC 113
#define OLEUI_ERR_GLOBALMEMALLOC 114
#define OLEUI_ERR_LOADSTRING 115
#define OLEUI_ERR_OLEMEMALLOC 116
#define OLEUI_ERR_STANDARDMAX 116
#define OPF_OBJECTISLINK 1
#define OPF_NOFILLDEFAULT 2
#define OPF_SHOWHELP 4
#define OPF_DISABLECONVERT 8
#define OLEUI_OPERR_SUBPROPNULL 116
#define OLEUI_OPERR_SUBPROPINVALID (116+1)
#define OLEUI_OPERR_PROPSHEETNULL (116+2)
#define OLEUI_OPERR_PROPSHEETINVALID (116+3)
#define OLEUI_OPERR_SUPPROP (116+4)
#define OLEUI_OPERR_PROPSINVALID (116+5)
#define OLEUI_OPERR_PAGESINCORRECT (116+6)
#define OLEUI_OPERR_INVALIDPAGES (116+7)
#define OLEUI_OPERR_NOTSUPPORTED (116+8)
#define OLEUI_OPERR_DLGPROCNOTNULL (116+9)
#define OLEUI_OPERR_LPARAMNOTZERO (116+10)
#define OLEUI_GPERR_STRINGINVALID (116+11)
#define OLEUI_GPERR_CLASSIDINVALID (116+12)
#define OLEUI_GPERR_LPCLSIDEXCLUDEINVALID (116+13)
#define OLEUI_GPERR_CBFORMATINVALID (116+14)
#define OLEUI_VPERR_METAPICTINVALID (116+15)
#define OLEUI_VPERR_DVASPECTINVALID (116+16)
#define OLEUI_LPERR_LINKCNTRNULL (116+17)
#define OLEUI_LPERR_LINKCNTRINVALID (116+18)
#define OLEUI_OPERR_PROPERTYSHEET (116+19)
#define OLEUI_OPERR_OBJINFOINVALID (116+20)
#define OLEUI_OPERR_LINKINFOINVALID (116+21)
#define OLEUI_QUERY_GETCLASSID 65280
#define OLEUI_QUERY_LINKBROKEN 65281
#define IOF_SHOWHELP 1
#define IOF_SELECTCREATENEW 2
#define IOF_SELECTCREATEFROMFILE 4
#define IOF_CHECKLINK 8
#define IOF_CHECKDISPLAYASICON 16
#define IOF_CREATENEWOBJECT 32
#define IOF_CREATEFILEOBJECT 64
#define IOF_CREATELINKOBJECT 128
#define IOF_DISABLELINK 256
#define IOF_VERIFYSERVERSEXIST 512
#define IOF_DISABLEDISPLAYASICON 1024
#define IOF_HIDECHANGEICON 2048
#define IOF_SHOWINSERTCONTROL 4096
#define IOF_SELECTCREATECONTROL 8192
#define OLEUI_IOERR_LPSZFILEINVALID 116
#define OLEUI_IOERR_LPSZLABELINVALID (116+1)
#define OLEUI_IOERR_HICONINVALID (116+2)
#define OLEUI_IOERR_LPFORMATETCINVALID (116+3)
#define OLEUI_IOERR_PPVOBJINVALID (116+4)
#define OLEUI_IOERR_LPIOLECLIENTSITEINVALID (116+5)
#define OLEUI_IOERR_LPISTORAGEINVALID (116+6)
#define OLEUI_IOERR_SCODEHASERROR (116+7)
#define OLEUI_IOERR_LPCLSIDEXCLUDEINVALID (116+8)
#define OLEUI_IOERR_CCHFILEINVALID (116+9)
#define PSF_SHOWHELP 1
#define PSF_SELECTPASTE 2
#define PSF_SELECTPASTELINK 4
#define PSF_CHECKDISPLAYASICON 8
#define PSF_DISABLEDISPLAYASICON 16
#define PSF_HIDECHANGEICON 32
#define PSF_STAYONCLIPBOARDCHANGE 64
#define PSF_NOREFRESHDATAOBJECT 128
#define OLEUI_IOERR_SRCDATAOBJECTINVALID 116
#define OLEUI_IOERR_ARRPASTEENTRIESINVALID (116+1)
#define OLEUI_IOERR_ARRLINKTYPESINVALID (116+2)
#define OLEUI_PSERR_CLIPBOARDCHANGED (116+3)
#define OLEUI_PSERR_GETCLIPBOARDFAILED (116+4)
#define OLEUI_ELERR_LINKCNTRNULL 116
#define OLEUI_ELERR_LINKCNTRINVALID (116+1)
#define ELF_SHOWHELP 1
#define ELF_DISABLEUPDATENOW 2
#define ELF_DISABLEOPENSOURCE 4
#define ELF_DISABLECHANGESOURCE 8
#define ELF_DISABLECANCELLINK 16
#define CIF_SHOWHELP 1
#define CIF_SELECTCURRENT 2
#define CIF_SELECTDEFAULT 4
#define CIF_SELECTFROMFILE 8
#define CIF_USEICONEXE 16
#define OLEUI_CIERR_MUSTHAVECLSID 116
#define OLEUI_CIERR_MUSTHAVECURRENTMETAFILE (116+1)
#define OLEUI_CIERR_SZICONEXEINVALID (116+2)
#define CF_SHOWHELPBUTTON 1
#define CF_SETCONVERTDEFAULT 2
#define CF_SETACTIVATEDEFAULT 4
#define CF_SELECTCONVERTTO 8
#define CF_SELECTACTIVATEAS 16
#define CF_DISABLEDISPLAYASICON 32
#define CF_DISABLEACTIVATEAS 64
#define CF_HIDECHANGEICON 128
#define CF_CONVERTONLY 256
#define OLEUI_CTERR_CLASSIDINVALID (116+1)
#define OLEUI_CTERR_DVASPECTINVALID (116+2)
#define OLEUI_CTERR_CBFORMATINVALID (116+3)
#define OLEUI_CTERR_HMETAPICTINVALID (116+4)
#define OLEUI_CTERR_STRINGINVALID (116+5)
#define BZ_DISABLECANCELBUTTON 1
#define BZ_DISABLESWITCHTOBUTTON 2
#define BZ_DISABLERETRYBUTTON 4
#define BZ_NOTRESPONDINGDIALOG 8
#define OLEUI_BZERR_HTASKINVALID 116
#define OLEUI_BZ_SWITCHTOSELECTED (116+1)
#define OLEUI_BZ_RETRYSELECTED (116+2)
#define OLEUI_BZ_CALLUNBLOCKED (116+3)
#define CSF_SHOWHELP 1
#define CSF_VALIDSOURCE 2
#define CSF_ONLYGETSOURCE 4
#define CSF_EXPLORER 8
#define OLEUI_CSERR_LINKCNTRNULL 116
#define OLEUI_CSERR_LINKCNTRINVALID (116+1)
#define OLEUI_CSERR_FROMNOTNULL (116+2)
#define OLEUI_CSERR_TONOTNULL (116+3)
#define OLEUI_CSERR_SOURCENULL (116+4)
#define OLEUI_CSERR_SOURCEINVALID (116+5)
#define OLEUI_CSERR_SOURCEPARSERROR (116+6)
#define OLEUI_CSERR_SOURCEPARSEERROR (116+7)
#define VPF_SELECTRELATIVE 1
#define VPF_DISABLERELATIVE 2
#define VPF_DISABLESCALE 4

type LPFNOLEUIHOOK as function(byval as HWND, byval as UINT, byval as WPARAM, byval as LPARAM) as UINT

#ifdef UNICODE
type OLEUIINSERTOBJECTW
	cbStruct as DWORD
	dwFlags as DWORD
	hWndOwner as HWND
	lpszCaption as LPCWSTR
	lpfnHook as LPFNOLEUIHOOK
	lCustData as LPARAM
	hInstance as HINSTANCE
	lpszTemplate as LPCWSTR
	hResource as HRSRC
	clsid as CLSID
	lpszFile as LPWSTR
	cchFile as UINT
	cClsidExclude as UINT
	lpClsidExclude as LPCLSID
	iid as IID
	oleRender as DWORD
	lpFormatEtc as LPFORMATETC
	lpIOleClientSite as LPOLECLIENTSITE
	lpIStorage as LPSTORAGE
	ppvObj as PVOID ptr
	sc as SCODE
	hMetaPict as HGLOBAL
end type

type POLEUIINSERTOBJECTW as OLEUIINSERTOBJECTW ptr
type LPOLEUIINSERTOBJECTW as OLEUIINSERTOBJECTW ptr

declare function OleUIInsertObject alias "OleUIInsertObjectW" (byval as LPOLEUIINSERTOBJECTW) as UINT

#else
type OLEUIINSERTOBJECTA
	cbStruct as DWORD
	dwFlags as DWORD
	hWndOwner as HWND
	lpszCaption as LPCSTR
	lpfnHook as LPFNOLEUIHOOK
	lCustData as LPARAM
	hInstance as HINSTANCE
	lpszTemplate as LPCSTR
	hResource as HRSRC
	clsid as CLSID
	lpszFile as LPSTR
	cchFile as UINT
	cClsidExclude as UINT
	lpClsidExclude as LPCLSID
	iid as IID
	oleRender as DWORD
	lpFormatEtc as LPFORMATETC
	lpIOleClientSite as LPOLECLIENTSITE
	lpIStorage as LPSTORAGE
	ppvObj as PVOID ptr
	sc as SCODE
	hMetaPict as HGLOBAL
end type

type POLEUIINSERTOBJECTA as OLEUIINSERTOBJECTA ptr
type LPOLEUIINSERTOBJECTA as OLEUIINSERTOBJECTA ptr

declare function OleUIInsertObject alias "OleUIInsertObjectA" (byval as LPOLEUIINSERTOBJECTA) as UINT
#endif

enum OLEUIPASTEFLAG
	OLEUIPASTE_PASTEONLY
	OLEUIPASTE_LINKTYPE1
	OLEUIPASTE_LINKTYPE2
	OLEUIPASTE_LINKTYPE3 = 4
	OLEUIPASTE_LINKTYPE4 = 8
	OLEUIPASTE_LINKTYPE5 = 16
	OLEUIPASTE_LINKTYPE6 = 32
	OLEUIPASTE_LINKTYPE7 = 64
	OLEUIPASTE_LINKTYPE8 = 128
	OLEUIPASTE_PASTE = 512
	OLEUIPASTE_LINKANYTYPE = 1024
	OLEUIPASTE_ENABLEICON = 2048
end enum

#ifdef UNICODE
type OLEUIPASTEENTRYW
	fmtetc as FORMATETC
	lpstrFormatName as LPCWSTR
	lpstrResultText as LPCWSTR
	dwFlags as DWORD
	dwScratchSpace as DWORD
end type

type POLEUIPASTEENTRYW as OLEUIPASTEENTRYW ptr
type LPOLEUIPASTEENTRYW as OLEUIPASTEENTRYW ptr

#else
type OLEUIPASTEENTRYA
	fmtetc as FORMATETC
	lpstrFormatName as LPCSTR
	lpstrResultText as LPCSTR
	dwFlags as DWORD
	dwScratchSpace as DWORD
end type

type POLEUIPASTEENTRYA as OLEUIPASTEENTRYA ptr
type LPOLEUIPASTEENTRYA as OLEUIPASTEENTRYA ptr
#endif

#ifdef UNICODE
type OLEUIPASTESPECIALW
	cbStruct as DWORD
	dwFlags as DWORD
	hWndOwner as HWND
	lpszCaption as LPCWSTR
	lpfnHook as LPFNOLEUIHOOK
	lCustData as LPARAM
	hInstance as HINSTANCE
	lpszTemplate as LPCWSTR
	hResource as HRSRC
	lpSrcDataObj as LPDATAOBJECT
	arrPasteEntries as LPOLEUIPASTEENTRYW
	cPasteEntries as integer
	arrLinkTypes as UINT ptr
	cLinkTypes as integer
	cClsidExclude as UINT
	lpClsidExclude as LPCLSID
	nSelectedIndex as integer
	fLink as BOOL
	hMetaPict as HGLOBAL
	sizel as SIZEL
end type

type POLEUIPASTESPECIALW as OLEUIPASTESPECIALW ptr
type LPOLEUIPASTESPECIALW as OLEUIPASTESPECIALW ptr

#else
type OLEUIPASTESPECIALA
	cbStruct as DWORD
	dwFlags as DWORD
	hWndOwner as HWND
	lpszCaption as LPCSTR
	lpfnHook as LPFNOLEUIHOOK
	lCustData as LPARAM
	hInstance as HINSTANCE
	lpszTemplate as LPCSTR
	hResource as HRSRC
	lpSrcDataObj as LPDATAOBJECT
	arrPasteEntries as LPOLEUIPASTEENTRYA
	cPasteEntries as integer
	arrLinkTypes as UINT ptr
	cLinkTypes as integer
	cClsidExclude as UINT
	lpClsidExclude as LPCLSID
	nSelectedIndex as integer
	fLink as BOOL
	hMetaPict as HGLOBAL
	sizel as SIZEL
end type

type POLEUIPASTESPECIALA as OLEUIPASTESPECIALA ptr
type LPOLEUIPASTESPECIALA as OLEUIPASTESPECIALA ptr
#endif

#ifdef UNICODE
type IOleUILinkContainerWVtbl_ as IOleUILinkContainerWVtbl

type IOleUILinkContainerW
	lpVtbl as IOleUILinkContainerWVtbl_ ptr
end type

type IOleUILinkContainerWVtbl
	QueryInterface as function(byval as IOleUILinkContainerW ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IOleUILinkContainerW ptr) as ULONG
	Release as function(byval as IOleUILinkContainerW ptr) as ULONG
	GetNextLink as function(byval as IOleUILinkContainerW ptr, byval as DWORD) as DWORD
	SetLinkUpdateOptions as function(byval as IOleUILinkContainerW ptr, byval as DWORD, byval as DWORD) as HRESULT
	GetLinkUpdateOptions as function(byval as IOleUILinkContainerW ptr, byval as DWORD, byval as PDWORD) as HRESULT
	SetLinkSource as function(byval as IOleUILinkContainerW ptr, byval as DWORD, byval as LPWSTR, byval as ULONG, byval as PULONG, byval as BOOL) as HRESULT
	GetLinkSource as function(byval as IOleUILinkContainerW ptr, byval as DWORD, byval as LPWSTR ptr, byval as PULONG, byval as LPWSTR ptr, byval as LPWSTR ptr, byval as BOOL ptr, byval as BOOL ptr) as HRESULT
	OpenLinkSource as function(byval as IOleUILinkContainerW ptr, byval as DWORD) as HRESULT
	UpdateLink as function(byval as IOleUILinkContainerW ptr, byval as DWORD, byval as BOOL, byval as BOOL) as HRESULT
	CancelLink as function(byval as IOleUILinkContainerW ptr, byval as DWORD) as HRESULT
end type

type LPOLEUILINKCONTAINERW as IOleUILinkContainerW ptr

#else
type IOleUILinkContainerAVtbl_ as IOleUILinkContainerAVtbl

type IOleUILinkContainerA
	lpVtbl as IOleUILinkContainerAVtbl_ ptr
end type

type IOleUILinkContainerAVtbl
	QueryInterface as function(byval as IOleUILinkContainerA ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IOleUILinkContainerA ptr) as ULONG
	Release as function(byval as IOleUILinkContainerA ptr) as ULONG
	GetNextLink as function(byval as IOleUILinkContainerA ptr, byval as DWORD) as DWORD
	SetLinkUpdateOptions as function(byval as IOleUILinkContainerA ptr, byval as DWORD, byval as DWORD) as HRESULT
	GetLinkUpdateOptions as function(byval as IOleUILinkContainerA ptr, byval as DWORD, byval as PDWORD) as HRESULT
	SetLinkSource as function(byval as IOleUILinkContainerA ptr, byval as DWORD, byval as LPSTR, byval as ULONG, byval as PULONG, byval as BOOL) as HRESULT
	GetLinkSource as function(byval as IOleUILinkContainerA ptr, byval as DWORD, byval as LPSTR ptr, byval as PULONG, byval as LPSTR ptr, byval as LPSTR ptr, byval as BOOL ptr, byval as BOOL ptr) as HRESULT
	OpenLinkSource as function(byval as IOleUILinkContainerA ptr, byval as DWORD) as HRESULT
	UpdateLink as function(byval as IOleUILinkContainerA ptr, byval as DWORD, byval as BOOL, byval as BOOL) as HRESULT
	CancelLink as function(byval as IOleUILinkContainerA ptr, byval as DWORD) as HRESULT
end type

type LPOLEUILINKCONTAINERA as IOleUILinkContainerA ptr
#endif

#ifdef UNICODE
type OLEUIEDITLINKSW
	cbStruct as DWORD
	dwFlags as DWORD
	hWndOwner as HWND
	lpszCaption as LPCWSTR
	lpfnHook as LPFNOLEUIHOOK
	lCustData as LPARAM
	hInstance as HINSTANCE
	lpszTemplate as LPCWSTR
	hResource as HRSRC
	lpOleUILinkContainer as LPOLEUILINKCONTAINERW
end type

type POLEUIEDITLINKSW as OLEUIEDITLINKSW ptr
type LPOLEUIEDITLINKSW as OLEUIEDITLINKSW ptr

#else
type OLEUIEDITLINKSA
	cbStruct as DWORD
	dwFlags as DWORD
	hWndOwner as HWND
	lpszCaption as LPCSTR
	lpfnHook as LPFNOLEUIHOOK
	lCustData as LPARAM
	hInstance as HINSTANCE
	lpszTemplate as LPCSTR
	hResource as HRSRC
	lpOleUILinkContainer as LPOLEUILINKCONTAINERA
end type

type POLEUIEDITLINKSA as OLEUIEDITLINKSA ptr
type LPOLEUIEDITLINKSA as OLEUIEDITLINKSA ptr
#endif

#ifdef UNICODE
type OLEUICHANGEICONW
	cbStruct as DWORD
	dwFlags as DWORD
	hWndOwner as HWND
	lpszCaption as LPCWSTR
	lpfnHook as LPFNOLEUIHOOK
	lCustData as LPARAM
	hInstance as HINSTANCE
	lpszTemplate as LPCWSTR
	hResource as HRSRC
	hMetaPict as HGLOBAL
	clsid as CLSID
	szIconExe as wstring * 260
	cchIconExe as integer
end type

type POLEUICHANGEICONW as OLEUICHANGEICONW ptr
type LPOLEUICHANGEICONW as OLEUICHANGEICONW ptr

#else
type OLEUICHANGEICONA
	cbStruct as DWORD
	dwFlags as DWORD
	hWndOwner as HWND
	lpszCaption as LPCSTR
	lpfnHook as LPFNOLEUIHOOK
	lCustData as LPARAM
	hInstance as HINSTANCE
	lpszTemplate as LPCSTR
	hResource as HRSRC
	hMetaPict as HGLOBAL
	clsid as CLSID
	szIconExe as zstring * 260
	cchIconExe as integer
end type

type POLEUICHANGEICONA as OLEUICHANGEICONA ptr
type LPOLEUICHANGEICONA as OLEUICHANGEICONA ptr
#endif

#ifdef UNICODE
type OLEUICONVERTW
	cbStruct as DWORD
	dwFlags as DWORD
	hWndOwner as HWND
	lpszCaption as LPCWSTR
	lpfnHook as LPFNOLEUIHOOK
	lCustData as LPARAM
	hInstance as HINSTANCE
	lpszTemplate as LPCWSTR
	hResource as HRSRC
	clsid as CLSID
	clsidConvertDefault as CLSID
	clsidActivateDefault as CLSID
	clsidNew as CLSID
	dvAspect as DWORD
	wFormat as WORD
	fIsLinkedObject as BOOL
	hMetaPict as HGLOBAL
	lpszUserType as LPWSTR
	fObjectsIconChanged as BOOL
	lpszDefLabel as LPWSTR
	cClsidExclude as UINT
	lpClsidExclude as LPCLSID
end type

type POLEUICONVERTW as OLEUICONVERTW ptr
type LPOLEUICONVERTW as OLEUICONVERTW ptr

#else
type OLEUICONVERTA
	cbStruct as DWORD
	dwFlags as DWORD
	hWndOwner as HWND
	lpszCaption as LPCSTR
	lpfnHook as LPFNOLEUIHOOK
	lCustData as LPARAM
	hInstance as HINSTANCE
	lpszTemplate as LPCSTR
	hResource as HRSRC
	clsid as CLSID
	clsidConvertDefault as CLSID
	clsidActivateDefault as CLSID
	clsidNew as CLSID
	dvAspect as DWORD
	wFormat as WORD
	fIsLinkedObject as BOOL
	hMetaPict as HGLOBAL
	lpszUserType as LPSTR
	fObjectsIconChanged as BOOL
	lpszDefLabel as LPSTR
	cClsidExclude as UINT
	lpClsidExclude as LPCLSID
end type

type POLEUICONVERTA as OLEUICONVERTA ptr
type LPOLEUICONVERTA as OLEUICONVERTA ptr
#endif

#ifdef UNICODE
type OLEUIBUSYW
	cbStruct as DWORD
	dwFlags as DWORD
	hWndOwner as HWND
	lpszCaption as LPCWSTR
	lpfnHook as LPFNOLEUIHOOK
	lCustData as LPARAM
	hInstance as HINSTANCE
	lpszTemplate as LPCWSTR
	hResource as HRSRC
	hTask as HTASK
	lphWndDialog as HWND ptr
end type

type POLEUIBUSYW as OLEUIBUSYW ptr
type LPOLEUIBUSYW as OLEUIBUSYW ptr

#else
type OLEUIBUSYA
	cbStruct as DWORD
	dwFlags as DWORD
	hWndOwner as HWND
	lpszCaption as LPCSTR
	lpfnHook as LPFNOLEUIHOOK
	lCustData as LPARAM
	hInstance as HINSTANCE
	lpszTemplate as LPCSTR
	hResource as HRSRC
	hTask as HTASK
	lphWndDialog as HWND ptr
end type

type POLEUIBUSYA as OLEUIBUSYA ptr
type LPOLEUIBUSYA as OLEUIBUSYA ptr
#endif

#ifdef UNICODE
type OLEUICHANGESOURCEW
	cbStruct as DWORD
	dwFlags as DWORD
	hWndOwner as HWND
	lpszCaption as LPCWSTR
	lpfnHook as LPFNOLEUIHOOK
	lCustData as LPARAM
	hInstance as HINSTANCE
	lpszTemplate as LPCWSTR
	hResource as HRSRC
	lpOFN as OPENFILENAMEW ptr
	dwReserved1(0 to 4-1) as DWORD
	lpOleUILinkContainer as LPOLEUILINKCONTAINERW
	dwLink as DWORD
	lpszDisplayName as LPWSTR
	nFileLength as ULONG
	lpszFrom as LPWSTR
	lpszTo as LPWSTR
end type

type POLEUICHANGESOURCEW as OLEUICHANGESOURCEW ptr
type LPOLEUICHANGESOURCEW as OLEUICHANGESOURCEW ptr

#else
type OLEUICHANGESOURCEA
	cbStruct as DWORD
	dwFlags as DWORD
	hWndOwner as HWND
	lpszCaption as LPCSTR
	lpfnHook as LPFNOLEUIHOOK
	lCustData as LPARAM
	hInstance as HINSTANCE
	lpszTemplate as LPCSTR
	hResource as HRSRC
	lpOFN as OPENFILENAMEA ptr
	dwReserved1(0 to 4-1) as DWORD
	lpOleUILinkContainer as LPOLEUILINKCONTAINERA
	dwLink as DWORD
	lpszDisplayName as LPSTR
	nFileLength as ULONG
	lpszFrom as LPSTR
	lpszTo as LPSTR
end type

type POLEUICHANGESOURCEA as OLEUICHANGESOURCEA ptr
type LPOLEUICHANGESOURCEA as OLEUICHANGESOURCEA ptr
#endif

#ifdef UNICODE
type IOleUIObjInfoWVtbl_ as IOleUIObjInfoWVtbl

type IOleUIObjInfoW
	lpVtbl as IOleUIObjInfoWVtbl_ ptr
end type

type IOleUIObjInfoWVtbl
	QueryInterface as function(byval as IOleUIObjInfoW ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IOleUIObjInfoW ptr) as ULONG
	Release as function(byval as IOleUIObjInfoW ptr) as ULONG
	GetObjectInfo as function(byval as IOleUIObjInfoW ptr, byval as DWORD, byval as PDWORD, byval as LPWSTR ptr, byval as LPWSTR ptr, byval as LPWSTR ptr, byval as LPWSTR ptr) as HRESULT
	GetConvertInfo as function(byval as IOleUIObjInfoW ptr, byval as DWORD, byval as CLSID ptr, byval as PWORD, byval as CLSID ptr, byval as LPCLSID ptr, byval as UINT ptr) as HRESULT
	ConvertObject as function(byval as IOleUIObjInfoW ptr, byval as DWORD, byval as CLSID ptr) as HRESULT
	GetViewInfo as function(byval as IOleUIObjInfoW ptr, byval as DWORD, byval as HGLOBAL ptr, byval as PDWORD, byval as integer ptr) as HRESULT
	SetViewInfo as function(byval as IOleUIObjInfoW ptr, byval as DWORD, byval as HGLOBAL, byval as DWORD, byval as integer, byval as BOOL) as HRESULT
end type

type LPOLEUIOBJINFOW as IOleUIObjInfoW ptr

#else
type IOleUIObjInfoAVtbl_ as IOleUIObjInfoAVtbl

type IOleUIObjInfoA
	lpVtbl as IOleUIObjInfoAVtbl_ ptr
end type

type IOleUIObjInfoAVtbl
	QueryInterface as function(byval as IOleUIObjInfoA ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IOleUIObjInfoA ptr) as ULONG
	Release as function(byval as IOleUIObjInfoA ptr) as ULONG
	GetObjectInfo as function(byval as IOleUIObjInfoA ptr, byval as DWORD, byval as PDWORD, byval as LPSTR ptr, byval as LPSTR ptr, byval as LPSTR ptr, byval as LPSTR ptr) as HRESULT
	GetConvertInfo as function(byval as IOleUIObjInfoA ptr, byval as DWORD, byval as CLSID ptr, byval as PWORD, byval as CLSID ptr, byval as LPCLSID ptr, byval as UINT ptr) as HRESULT
	ConvertObject as function(byval as IOleUIObjInfoA ptr, byval as DWORD, byval as CLSID ptr) as HRESULT
	GetViewInfo as function(byval as IOleUIObjInfoA ptr, byval as DWORD, byval as HGLOBAL ptr, byval as PDWORD, byval as integer ptr) as HRESULT
	SetViewInfo as function(byval as IOleUIObjInfoA ptr, byval as DWORD, byval as HGLOBAL, byval as DWORD, byval as integer, byval as BOOL) as HRESULT
end type

type LPOLEUIOBJINFOA as IOleUIObjInfoA ptr
#endif

#ifdef UNICODE
type IOleUILinkInfoWVtbl_ as IOleUILinkInfoWVtbl

type IOleUILinkInfoW
	lpVtbl as IOleUILinkInfoWVtbl_ ptr
end type

type IOleUILinkInfoWVtbl
	QueryInterface as function(byval as IOleUILinkInfoW ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IOleUILinkInfoW ptr) as ULONG
	Release as function(byval as IOleUILinkInfoW ptr) as ULONG
	GetNextLink as function(byval as IOleUILinkInfoW ptr, byval as DWORD) as DWORD
	SetLinkUpdateOptions as function(byval as IOleUILinkInfoW ptr, byval as DWORD, byval as DWORD) as HRESULT
	GetLinkUpdateOptions as function(byval as IOleUILinkInfoW ptr, byval as DWORD, byval as DWORD ptr) as HRESULT
	SetLinkSource as function(byval as IOleUILinkInfoW ptr, byval as DWORD, byval as LPWSTR, byval as ULONG, byval as PULONG, byval as BOOL) as HRESULT
	GetLinkSource as function(byval as IOleUILinkInfoW ptr, byval as DWORD, byval as LPWSTR ptr, byval as PULONG, byval as LPWSTR ptr, byval as LPWSTR ptr, byval as BOOL ptr, byval as BOOL ptr) as HRESULT
	OpenLinkSource as function(byval as IOleUILinkInfoW ptr, byval as DWORD) as HRESULT
	UpdateLink as function(byval as IOleUILinkInfoW ptr, byval as DWORD, byval as BOOL, byval as BOOL) as HRESULT
	CancelLink as function(byval as IOleUILinkInfoW ptr, byval as DWORD) as HRESULT
	GetLastUpdate as function(byval as IOleUILinkInfoW ptr, byval as DWORD, byval as FILETIME ptr) as HRESULT
end type

type LPOLEUILINKINFOW as IOleUILinkInfoW ptr

#else
type IOleUILinkInfoAVtbl_ as IOleUILinkInfoAVtbl

type IOleUILinkInfoA
	lpVtbl as IOleUILinkInfoAVtbl_ ptr
end type

type IOleUILinkInfoAVtbl
	QueryInterface as function(byval as IOleUILinkInfoA ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IOleUILinkInfoA ptr) as ULONG
	Release as function(byval as IOleUILinkInfoA ptr) as ULONG
	GetNextLink as function(byval as IOleUILinkInfoA ptr, byval as DWORD) as DWORD
	SetLinkUpdateOptions as function(byval as IOleUILinkInfoA ptr, byval as DWORD, byval as DWORD) as HRESULT
	GetLinkUpdateOptions as function(byval as IOleUILinkInfoA ptr, byval as DWORD, byval as DWORD ptr) as HRESULT
	SetLinkSource as function(byval as IOleUILinkInfoA ptr, byval as DWORD, byval as LPSTR, byval as ULONG, byval as PULONG, byval as BOOL) as HRESULT
	GetLinkSource as function(byval as IOleUILinkInfoA ptr, byval as DWORD, byval as LPSTR ptr, byval as PULONG, byval as LPSTR ptr, byval as LPSTR ptr, byval as BOOL ptr, byval as BOOL ptr) as HRESULT
	OpenLinkSource as function(byval as IOleUILinkInfoA ptr, byval as DWORD) as HRESULT
	UpdateLink as function(byval as IOleUILinkInfoA ptr, byval as DWORD, byval as BOOL, byval as BOOL) as HRESULT
	CancelLink as function(byval as IOleUILinkInfoA ptr, byval as DWORD) as HRESULT
	GetLastUpdate as function(byval as IOleUILinkInfoA ptr, byval as DWORD, byval as FILETIME ptr) as HRESULT
end type

type LPOLEUILINKINFOA as IOleUILinkInfoA ptr
#endif

#ifdef UNICODE
type OLEUIOBJECTPROPSW_ as OLEUIOBJECTPROPSW

type OLEUIGNRLPROPSW
	cbStruct as DWORD
	dwFlags as DWORD
	dwReserved1(0 to 2-1) as DWORD
	lpfnHook as LPFNOLEUIHOOK
	lCustData as LPARAM
	dwReserved2(0 to 3-1) as DWORD
	lpOP as OLEUIOBJECTPROPSW_ ptr
end type

type POLEUIGNRLPROPSW as OLEUIGNRLPROPSW ptr
type LPOLEUIGNRLPROPSW as OLEUIGNRLPROPSW ptr

#else
type OLEUIOBJECTPROPSA_ as OLEUIOBJECTPROPSA

type OLEUIGNRLPROPSA
	cbStruct as DWORD
	dwFlags as DWORD
	dwReserved1(0 to 2-1) as DWORD
	lpfnHook as LPFNOLEUIHOOK
	lCustData as LPARAM
	dwReserved2(0 to 3-1) as DWORD
	lpOP as OLEUIOBJECTPROPSA_ ptr
end type

type POLEUIGNRLPROPSA as OLEUIGNRLPROPSA ptr
type LPOLEUIGNRLPROPSA as OLEUIGNRLPROPSA ptr
#endif

#ifdef UNICODE
type OLEUIVIEWPROPSW
	cbStruct as DWORD
	dwFlags as DWORD
	dwReserved1(0 to 2-1) as DWORD
	lpfnHook as LPFNOLEUIHOOK
	lCustData as LPARAM
	dwReserved2(0 to 3-1) as DWORD
	lpOP as OLEUIOBJECTPROPSW_ ptr
	nScaleMin as integer
	nScaleMax as integer
end type

type POLEUIVIEWPROPSW as OLEUIVIEWPROPSW ptr
type LPOLEUIVIEWPROPSW as OLEUIVIEWPROPSW ptr

#else
type OLEUIVIEWPROPSA
	cbStruct as DWORD
	dwFlags as DWORD
	dwReserved1(0 to 2-1) as DWORD
	lpfnHook as LPFNOLEUIHOOK
	lCustData as LPARAM
	dwReserved2(0 to 3-1) as DWORD
	lpOP as OLEUIOBJECTPROPSA_ ptr
	nScaleMin as integer
	nScaleMax as integer
end type

type POLEUIVIEWPROPSA as OLEUIVIEWPROPSA ptr
type LPOLEUIVIEWPROPSA as OLEUIVIEWPROPSA ptr
#endif

#ifdef UNICODE
type OLEUILINKPROPSW
	cbStruct as DWORD
	dwFlags as DWORD
	dwReserved1(0 to 2-1) as DWORD
	lpfnHook as LPFNOLEUIHOOK
	lCustData as LPARAM
	dwReserved2(0 to 3-1) as DWORD
	lpOP as OLEUIOBJECTPROPSW_ ptr
end type

type POLEUILINKPROPSW as OLEUILINKPROPSW ptr
type LPOLEUILINKPROPSW as OLEUILINKPROPSW ptr

#else
type OLEUILINKPROPSA
	cbStruct as DWORD
	dwFlags as DWORD
	dwReserved1(0 to 2-1) as DWORD
	lpfnHook as LPFNOLEUIHOOK
	lCustData as LPARAM
	dwReserved2(0 to 3-1) as DWORD
	lpOP as OLEUIOBJECTPROPSA_ ptr
end type

type POLEUILINKPROPSA as OLEUILINKPROPSA ptr
type LPOLEUILINKPROPSA as OLEUILINKPROPSA ptr
#endif

#ifdef UNICODE
type OLEUIOBJECTPROPSW
	cbStruct as DWORD
	dwFlags as DWORD
	lpPS as LPPROPSHEETHEADERW
	dwObject as DWORD
	lpObjInfo as LPOLEUIOBJINFOW
	dwLink as DWORD
	lpLinkInfo as LPOLEUILINKINFOW
	lpGP as LPOLEUIGNRLPROPSW
	lpVP as LPOLEUIVIEWPROPSW
	lpLP as LPOLEUILINKPROPSW
end type

type POLEUIOBJECTPROPSW as OLEUIOBJECTPROPSW ptr
type LPOLEUIOBJECTPROPSW as OLEUIOBJECTPROPSW ptr

#else
type OLEUIOBJECTPROPSA
	cbStruct as DWORD
	dwFlags as DWORD
	lpPS as LPPROPSHEETHEADERA
	dwObject as DWORD
	lpObjInfo as LPOLEUIOBJINFOA
	dwLink as DWORD
	lpLinkInfo as LPOLEUILINKINFOA
	lpGP as LPOLEUIGNRLPROPSA
	lpVP as LPOLEUIVIEWPROPSA
	lpLP as LPOLEUILINKPROPSA
end type

type POLEUIOBJECTPROPSA as OLEUIOBJECTPROPSA ptr
type LPOLEUIOBJECTPROPSA as OLEUIOBJECTPROPSA ptr
#endif

declare function OleUICanConvertOrActivateAs alias "OleUICanConvertOrActivateAs" (byval as CLSID ptr, byval as BOOL, byval as WORD) as BOOL

#ifdef UNICODE
declare function OleUIAddVerbMenu alias "OleUIAddVerbMenuW" (byval as LPOLEOBJECT, byval as LPCWSTR, byval as HMENU, byval as UINT, byval as UINT, byval as UINT, byval as BOOL, byval as UINT, byval as HMENU ptr) as BOOL
declare function OleUIBusy alias "OleUIBusyW" (byval as LPOLEUIBUSYW) as UINT
declare function OleUIChangeIcon alias "OleUIChangeIconW" (byval as LPOLEUICHANGEICONW) as UINT
declare function OleUIChangeSource alias "OleUIChangeSourceW" (byval as LPOLEUICHANGESOURCEW) as UINT
declare function OleUIConvert alias "OleUIConvertW" (byval as LPOLEUICONVERTW) as UINT
declare function OleUIEditLinks alias "OleUIEditLinksW" (byval as LPOLEUIEDITLINKSW) as UINT
declare function OleUIObjectProperties alias "OleUIObjectPropertiesW" (byval as LPOLEUIOBJECTPROPSW) as UINT
declare function OleUIPasteSpecial alias "OleUIPasteSpecialW" (byval as LPOLEUIPASTESPECIALW) as UINT
declare function OleUIPromptUser cdecl alias "OleUIPromptUserW" (byval as integer, byval as HWND, ...) as integer
declare function OleUIUpdateLinks alias "OleUIUpdateLinksW" (byval as LPOLEUILINKCONTAINERW, byval as HWND, byval as LPWSTR, byval as integer) as BOOL

#else
declare function OleUIAddVerbMenu alias "OleUIAddVerbMenuA" (byval as LPOLEOBJECT, byval as LPCSTR, byval as HMENU, byval as UINT, byval as UINT, byval as UINT, byval as BOOL, byval as UINT, byval as HMENU ptr) as BOOL
declare function OleUIBusy alias "OleUIBusyA" (byval as LPOLEUIBUSYA) as UINT
declare function OleUIChangeIcon alias "OleUIChangeIconA" (byval as LPOLEUICHANGEICONA) as UINT
declare function OleUIChangeSource alias "OleUIChangeSourceA" (byval as LPOLEUICHANGESOURCEA) as UINT
declare function OleUIConvert alias "OleUIConvertA" (byval as LPOLEUICONVERTA) as UINT
declare function OleUIEditLinks alias "OleUIEditLinksA" (byval as LPOLEUIEDITLINKSA) as UINT
declare function OleUIObjectProperties alias "OleUIObjectPropertiesA" (byval as LPOLEUIOBJECTPROPSA) as UINT
declare function OleUIPasteSpecial alias "OleUIPasteSpecialA" (byval as LPOLEUIPASTESPECIALA) as UINT
declare function OleUIPromptUser cdecl alias "OleUIPromptUserA" (byval as integer, byval as HWND, ...) as integer
declare function OleUIUpdateLinks alias "OleUIUpdateLinksA" (byval as LPOLEUILINKCONTAINERA, byval as HWND, byval as LPSTR, byval as integer) as BOOL
#endif

#ifdef UNICODE
#define IDD_SERVERNOTREG IDD_SERVERNOTREGW
#define IDD_LINKTYPECHANGED IDD_LINKTYPECHANGEDW
type OLEUIOBJECTPROPS as OLEUIOBJECTPROPSW
type POLEUIOBJECTPROPS as POLEUIOBJECTPROPSW
type LPOLEUIOBJECTPROPS as LPOLEUIOBJECTPROPSW
type OLEUIINSERTOBJECT as OLEUIINSERTOBJECTW
type POLEUIINSERTOBJECT as POLEUIINSERTOBJECTW
type LPOLEUIINSERTOBJECT as LPOLEUIINSERTOBJECTW
type OLEUIPASTEENTRY as OLEUIPASTEENTRYW
type POLEUIPASTEENTRY as POLEUIPASTEENTRYW
type LPOLEUIPASTEENTRY as LPOLEUIPASTEENTRYW
type OLEUIPASTESPECIAL as OLEUIPASTESPECIALW
type POLEUIPASTESPECIAL as POLEUIPASTESPECIALW
type LPOLEUIPASTESPECIAL as LPOLEUIPASTESPECIALW
type IOleUILinkContainer as IOleUILinkContainerW
type LPOLEUILINKCONTAINER as LPOLEUILINKCONTAINERW
type OLEUIEDITLINKS as OLEUIEDITLINKSW
type POLEUIEDITLINKS as POLEUIEDITLINKSW
type LPOLEUIEDITLINKS as LPOLEUIEDITLINKSW
type OLEUICHANGEICON as OLEUICHANGEICONW
type POLEUICHANGEICON as POLEUICHANGEICONW
type LPOLEUICHANGEICON as LPOLEUICHANGEICONW
type OLEUICONVERT as OLEUICONVERTW
type POLEUICONVERT as POLEUICONVERTW
type LPOLEUICONVERT as LPOLEUICONVERTW
type OLEUIBUSY as OLEUIBUSYW
type POLEUIBUSY as POLEUIBUSYW
type LPOLEUIBUSY as LPOLEUIBUSYW
type OLEUICHANGESOURCE as OLEUICHANGESOURCEW
type POLEUICHANGESOURCE as POLEUICHANGESOURCEW
type LPOLEUICHANGESOURCE as LPOLEUICHANGESOURCEW
type IOleUIObjInfo as IOleUIObjInfoW
type LPOLEUIOBJINFO as LPOLEUIOBJINFOW
type IOleUILinkInfo as IOleUILinkInfoW
type IOleUILinkInfoVtbl as IOleUILinkInfoWVtbl
type LPOLEUILINKINFO as LPOLEUILINKINFOW
type OLEUIGNRLPROPS as OLEUIGNRLPROPSW
type POLEUIGNRLPROPS as POLEUIGNRLPROPSW
type LPOLEUIGNRLPROPS as LPOLEUIGNRLPROPSW
type OLEUIVIEWPROPS as OLEUIVIEWPROPSW
type POLEUIVIEWPROPS as POLEUIVIEWPROPSW
type LPOLEUIVIEWPROPS as LPOLEUIVIEWPROPSW
type OLEUILINKPROPS as OLEUILINKPROPSW
type POLEUILINKPROPS as POLEUILINKPROPSW
type LPOLEUILINKPROPS as LPOLEUILINKPROPSW
#else
#define IDD_SERVERNOTREG IDD_SERVERNOTREGA
#define IDD_LINKTYPECHANGED IDD_LINKTYPECHANGEDA
type OLEUIOBJECTPROPS as OLEUIOBJECTPROPSA
type POLEUIOBJECTPROPS as POLEUIOBJECTPROPSA
type LPOLEUIOBJECTPROPS as LPOLEUIOBJECTPROPSA
type OLEUIINSERTOBJECT as OLEUIINSERTOBJECTA
type POLEUIINSERTOBJECT as POLEUIINSERTOBJECTA
type LPOLEUIINSERTOBJECT as LPOLEUIINSERTOBJECTA
type OLEUIPASTEENTRY as OLEUIPASTEENTRYA
type POLEUIPASTEENTRY as POLEUIPASTEENTRYA
type LPOLEUIPASTEENTRY as LPOLEUIPASTEENTRYA
type OLEUIPASTESPECIAL as OLEUIPASTESPECIALA
type POLEUIPASTESPECIAL as POLEUIPASTESPECIALA
type LPOLEUIPASTESPECIAL as LPOLEUIPASTESPECIALA
type IOleUILinkContainer as IOleUILinkContainerA
type LPOLEUILINKCONTAINER as LPOLEUILINKCONTAINERA
type OLEUIEDITLINKS as OLEUIEDITLINKSA
type POLEUIEDITLINKS as POLEUIEDITLINKSA
type LPOLEUIEDITLINKS as LPOLEUIEDITLINKSA
type OLEUICHANGEICON as OLEUICHANGEICONA
type POLEUICHANGEICON as POLEUICHANGEICONA
type LPOLEUICHANGEICON as LPOLEUICHANGEICONA
type OLEUICONVERT as OLEUICONVERTA
type POLEUICONVERT as POLEUICONVERTA
type LPOLEUICONVERT as LPOLEUICONVERTA
type OLEUIBUSY as OLEUIBUSYA
type POLEUIBUSY as POLEUIBUSYA
type LPOLEUIBUSY as LPOLEUIBUSYA
type OLEUICHANGESOURCE as OLEUICHANGESOURCEA
type POLEUICHANGESOURCE as POLEUICHANGESOURCEA
type LPOLEUICHANGESOURCE as LPOLEUICHANGESOURCEA
type IOleUIObjInfo as IOleUIObjInfoA
type LPOLEUIOBJINFO as LPOLEUIOBJINFOA
type IOleUILinkInfo as IOleUILinkInfoA
type IOleUILinkInfoVtbl as IOleUILinkInfoAVtbl
type LPOLEUILINKINFO as LPOLEUILINKINFOA
type OLEUIGNRLPROPS as OLEUIGNRLPROPSA
type POLEUIGNRLPROPS as POLEUIGNRLPROPSA
type LPOLEUIGNRLPROPS as LPOLEUIGNRLPROPSA
type OLEUIVIEWPROPS as OLEUIVIEWPROPSA
type POLEUIVIEWPROPS as POLEUIVIEWPROPSA
type LPOLEUIVIEWPROPS as LPOLEUIVIEWPROPSA
type OLEUILINKPROPS as OLEUILINKPROPSA
type POLEUILINKPROPS as POLEUILINKPROPSA
type LPOLEUILINKPROPS as LPOLEUILINKPROPSA
#endif

#endif
