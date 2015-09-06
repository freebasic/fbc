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

#inclib "oledlg"

#include once "_mingw_unicode.bi"
#include once "windows.bi"
#include once "shellapi.bi"
#include once "commdlg.bi"
#include once "ole2.bi"
#include once "dlgs.bi"
#include once "prsht.bi"

extern "Windows"

#define _OLEDLG_H_

#ifdef UNICODE
	#define _UNICODE
#endif

const IDC_OLEUIHELP = 99
const IDC_IO_CREATENEW = 2100
const IDC_IO_CREATEFROMFILE = 2101
const IDC_IO_LINKFILE = 2102
const IDC_IO_OBJECTTYPELIST = 2103
const IDC_IO_DISPLAYASICON = 2104
const IDC_IO_CHANGEICON = 2105
const IDC_IO_FILE = 2106
const IDC_IO_FILEDISPLAY = 2107
const IDC_IO_RESULTIMAGE = 2108
const IDC_IO_RESULTTEXT = 2109
const IDC_IO_ICONDISPLAY = 2110
const IDC_IO_OBJECTTYPETEXT = 2111
const IDC_IO_FILETEXT = 2112
const IDC_IO_FILETYPE = 2113
const IDC_IO_INSERTCONTROL = 2114
const IDC_IO_ADDCONTROL = 2115
const IDC_IO_CONTROLTYPELIST = 2116
const IDC_PS_PASTE = 500
const IDC_PS_PASTELINK = 501
const IDC_PS_SOURCETEXT = 502
const IDC_PS_PASTELIST = 503
const IDC_PS_PASTELINKLIST = 504
const IDC_PS_DISPLAYLIST = 505
const IDC_PS_DISPLAYASICON = 506
const IDC_PS_ICONDISPLAY = 507
const IDC_PS_CHANGEICON = 508
const IDC_PS_RESULTIMAGE = 509
const IDC_PS_RESULTTEXT = 510
const IDC_CI_GROUP = 120
const IDC_CI_CURRENT = 121
const IDC_CI_CURRENTICON = 122
const IDC_CI_DEFAULT = 123
const IDC_CI_DEFAULTICON = 124
const IDC_CI_FROMFILE = 125
const IDC_CI_FROMFILEEDIT = 126
const IDC_CI_ICONLIST = 127
const IDC_CI_LABEL = 128
const IDC_CI_LABELEDIT = 129
const IDC_CI_BROWSE = 130
const IDC_CI_ICONDISPLAY = 131
const IDC_CV_OBJECTTYPE = 150
const IDC_CV_DISPLAYASICON = 152
const IDC_CV_CHANGEICON = 153
const IDC_CV_ACTIVATELIST = 154
const IDC_CV_CONVERTTO = 155
const IDC_CV_ACTIVATEAS = 156
const IDC_CV_RESULTTEXT = 157
const IDC_CV_CONVERTLIST = 158
const IDC_CV_ICONDISPLAY = 165
const IDC_EL_CHANGESOURCE = 201
const IDC_EL_AUTOMATIC = 202
const IDC_EL_CANCELLINK = 209
const IDC_EL_UPDATENOW = 210
const IDC_EL_OPENSOURCE = 211
const IDC_EL_MANUAL = 212
const IDC_EL_LINKSOURCE = 216
const IDC_EL_LINKTYPE = 217
const IDC_EL_LINKSLISTBOX = 206
const IDC_EL_COL1 = 220
const IDC_EL_COL2 = 221
const IDC_EL_COL3 = 222
const IDC_BZ_RETRY = 600
const IDC_BZ_ICON = 601
const IDC_BZ_MESSAGE1 = 602
const IDC_BZ_SWITCHTO = 604
const IDC_UL_METER = 1029
const IDC_UL_STOP = 1030
const IDC_UL_PERCENT = 1031
const IDC_UL_PROGRESS = 1032
const IDC_PU_LINKS = 900
const IDC_PU_TEXT = 901
const IDC_PU_CONVERT = 902
const IDC_PU_ICON = 908
const IDC_GP_OBJECTNAME = 1009
const IDC_GP_OBJECTTYPE = 1010
const IDC_GP_OBJECTSIZE = 1011
const IDC_GP_CONVERT = 1013
const IDC_GP_OBJECTICON = 1014
const IDC_GP_OBJECTLOCATION = 1022
const IDC_VP_PERCENT = 1000
const IDC_VP_CHANGEICON = 1001
const IDC_VP_EDITABLE = 1002
const IDC_VP_ASICON = 1003
const IDC_VP_RELATIVE = 1005
const IDC_VP_SPIN = 1006
const IDC_VP_SCALETXT = 1034
const IDC_VP_ICONDISPLAY = 1021
const IDC_VP_RESULTIMAGE = 1033
const IDC_LP_OPENSOURCE = 1006
const IDC_LP_UPDATENOW = 1007
const IDC_LP_BREAKLINK = 1008
const IDC_LP_LINKSOURCE = 1012
const IDC_LP_CHANGESOURCE = 1015
const IDC_LP_AUTOMATIC = 1016
const IDC_LP_MANUAL = 1017
const IDC_LP_DATE = 1018
const IDC_LP_TIME = 1019
const IDD_INSERTOBJECT = 1000
const IDD_CHANGEICON = 1001
const IDD_CONVERT = 1002
const IDD_PASTESPECIAL = 1003
const IDD_EDITLINKS = 1004
const IDD_BUSY = 1006
const IDD_UPDATELINKS = 1007
const IDD_CHANGESOURCE = 1009
const IDD_INSERTFILEBROWSE = 1010
const IDD_CHANGEICONBROWSE = 1011
const IDD_CONVERTONLY = 1012
const IDD_CHANGESOURCE4 = 1013
const IDD_GNRLPROPS = 1100
const IDD_VIEWPROPS = 1101
const IDD_LINKPROPS = 1102
const IDD_CONVERT4 = 1103
const IDD_CONVERTONLY4 = 1104
const IDD_EDITLINKS4 = 1105
const IDD_GNRLPROPS4 = 1106
const IDD_LINKPROPS4 = 1107
const IDD_PASTESPECIAL4 = 1108
const IDD_CANNOTUPDATELINK = 1008
const IDD_LINKSOURCEUNAVAILABLE = 1020
const IDD_SERVERNOTFOUND = 1023
const IDD_OUTOFMEMORY = 1024
const IDD_SERVERNOTREGW = 1021
const IDD_LINKTYPECHANGEDW = 1022
const IDD_SERVERNOTREGA = 1025
const IDD_LINKTYPECHANGEDA = 1026

#ifdef UNICODE
	const IDD_SERVERNOTREG = IDD_SERVERNOTREGW
	const IDD_LINKTYPECHANGED = IDD_LINKTYPECHANGEDW
#else
	const IDD_SERVERNOTREG = IDD_SERVERNOTREGA
	const IDD_LINKTYPECHANGED = IDD_LINKTYPECHANGEDA
#endif

#define OLESTDDELIM __TEXT(!"\\")
type LPFNOLEUIHOOK as function(byval as HWND, byval as UINT, byval as WPARAM, byval as LPARAM) as UINT
#define SZOLEUI_MSG_HELP __TEXT("OLEUI_MSG_HELP")
#define SZOLEUI_MSG_ENDDIALOG __TEXT("OLEUI_MSG_ENDDIALOG")
#define SZOLEUI_MSG_BROWSE __TEXT("OLEUI_MSG_BROWSE")
#define SZOLEUI_MSG_CHANGEICON __TEXT("OLEUI_MSG_CHANGEICON")
#define SZOLEUI_MSG_CLOSEBUSYDIALOG __TEXT("OLEUI_MSG_CLOSEBUSYDIALOG")
#define SZOLEUI_MSG_CONVERT __TEXT("OLEUI_MSG_CONVERT")
#define SZOLEUI_MSG_CHANGESOURCE __TEXT("OLEUI_MSG_CHANGESOURCE")
#define SZOLEUI_MSG_ADDCONTROL __TEXT("OLEUI_MSG_ADDCONTROL")
#define SZOLEUI_MSG_BROWSE_OFN __TEXT("OLEUI_MSG_BROWSE_OFN")
const ID_BROWSE_CHANGEICON = 1
const ID_BROWSE_INSERTFILE = 2
const ID_BROWSE_ADDCONTROL = 3
const ID_BROWSE_CHANGESOURCE = 4
const OLEUI_FALSE = 0
const OLEUI_SUCCESS = 1
const OLEUI_OK = 1
const OLEUI_CANCEL = 2
const OLEUI_ERR_STANDARDMIN = 100
const OLEUI_ERR_OLEMEMALLOC = 100
const OLEUI_ERR_STRUCTURENULL = 101
const OLEUI_ERR_STRUCTUREINVALID = 102
const OLEUI_ERR_CBSTRUCTINCORRECT = 103
const OLEUI_ERR_HWNDOWNERINVALID = 104
const OLEUI_ERR_LPSZCAPTIONINVALID = 105
const OLEUI_ERR_LPFNHOOKINVALID = 106
const OLEUI_ERR_HINSTANCEINVALID = 107
const OLEUI_ERR_LPSZTEMPLATEINVALID = 108
const OLEUI_ERR_HRESOURCEINVALID = 109
const OLEUI_ERR_FINDTEMPLATEFAILURE = 110
const OLEUI_ERR_LOADTEMPLATEFAILURE = 111
const OLEUI_ERR_DIALOGFAILURE = 112
const OLEUI_ERR_LOCALMEMALLOC = 113
const OLEUI_ERR_GLOBALMEMALLOC = 114
const OLEUI_ERR_LOADSTRING = 115
const OLEUI_ERR_STANDARDMAX = 116
declare function OleUIAddVerbMenuW(byval lpOleObj as LPOLEOBJECT, byval lpszShortType as LPCWSTR, byval hMenu as HMENU, byval uPos as UINT, byval uIDVerbMin as UINT, byval uIDVerbMax as UINT, byval bAddConvert as WINBOOL, byval idConvert as UINT, byval lphMenu as HMENU ptr) as WINBOOL
declare function OleUIAddVerbMenuA(byval lpOleObj as LPOLEOBJECT, byval lpszShortType as LPCSTR, byval hMenu as HMENU, byval uPos as UINT, byval uIDVerbMin as UINT, byval uIDVerbMax as UINT, byval bAddConvert as WINBOOL, byval idConvert as UINT, byval lphMenu as HMENU ptr) as WINBOOL

#ifdef UNICODE
	declare function OleUIAddVerbMenu alias "OleUIAddVerbMenuW"(byval lpOleObj as LPOLEOBJECT, byval lpszShortType as LPCWSTR, byval hMenu as HMENU, byval uPos as UINT, byval uIDVerbMin as UINT, byval uIDVerbMax as UINT, byval bAddConvert as WINBOOL, byval idConvert as UINT, byval lphMenu as HMENU ptr) as WINBOOL
#else
	declare function OleUIAddVerbMenu alias "OleUIAddVerbMenuA"(byval lpOleObj as LPOLEOBJECT, byval lpszShortType as LPCSTR, byval hMenu as HMENU, byval uPos as UINT, byval uIDVerbMin as UINT, byval uIDVerbMax as UINT, byval bAddConvert as WINBOOL, byval idConvert as UINT, byval lphMenu as HMENU ptr) as WINBOOL
#endif

type tagOLEUIINSERTOBJECTW
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
	ppvObj as LPVOID ptr
	sc as SCODE
	hMetaPict as HGLOBAL
end type

type OLEUIINSERTOBJECTW as tagOLEUIINSERTOBJECTW
type POLEUIINSERTOBJECTW as tagOLEUIINSERTOBJECTW ptr
type LPOLEUIINSERTOBJECTW as tagOLEUIINSERTOBJECTW ptr

type tagOLEUIINSERTOBJECTA
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
	ppvObj as LPVOID ptr
	sc as SCODE
	hMetaPict as HGLOBAL
end type

type OLEUIINSERTOBJECTA as tagOLEUIINSERTOBJECTA
type POLEUIINSERTOBJECTA as tagOLEUIINSERTOBJECTA ptr
type LPOLEUIINSERTOBJECTA as tagOLEUIINSERTOBJECTA ptr
declare function OleUIInsertObjectW(byval as LPOLEUIINSERTOBJECTW) as UINT
declare function OleUIInsertObjectA(byval as LPOLEUIINSERTOBJECTA) as UINT

#ifdef UNICODE
	type tagOLEUIINSERTOBJECT as tagOLEUIINSERTOBJECTW
	type OLEUIINSERTOBJECT as OLEUIINSERTOBJECTW
	type POLEUIINSERTOBJECT as POLEUIINSERTOBJECTW
	type LPOLEUIINSERTOBJECT as LPOLEUIINSERTOBJECTW
	declare function OleUIInsertObject alias "OleUIInsertObjectW"(byval as LPOLEUIINSERTOBJECTW) as UINT
#else
	type tagOLEUIINSERTOBJECT as tagOLEUIINSERTOBJECTA
	type OLEUIINSERTOBJECT as OLEUIINSERTOBJECTA
	type POLEUIINSERTOBJECT as POLEUIINSERTOBJECTA
	type LPOLEUIINSERTOBJECT as LPOLEUIINSERTOBJECTA
	declare function OleUIInsertObject alias "OleUIInsertObjectA"(byval as LPOLEUIINSERTOBJECTA) as UINT
#endif

const IOF_SHOWHELP = &h00000001
const IOF_SELECTCREATENEW = &h00000002
const IOF_SELECTCREATEFROMFILE = &h00000004
const IOF_CHECKLINK = &h00000008
const IOF_CHECKDISPLAYASICON = &h00000010
const IOF_CREATENEWOBJECT = &h00000020
const IOF_CREATEFILEOBJECT = &h00000040
const IOF_CREATELINKOBJECT = &h00000080
const IOF_DISABLELINK = &h00000100
const IOF_VERIFYSERVERSEXIST = &h00000200
const IOF_DISABLEDISPLAYASICON = &h00000400
const IOF_HIDECHANGEICON = &h00000800
const IOF_SHOWINSERTCONTROL = &h00001000
const IOF_SELECTCREATECONTROL = &h00002000
const OLEUI_IOERR_LPSZFILEINVALID = OLEUI_ERR_STANDARDMAX + 0
const OLEUI_IOERR_LPSZLABELINVALID = OLEUI_ERR_STANDARDMAX + 1
const OLEUI_IOERR_HICONINVALID = OLEUI_ERR_STANDARDMAX + 2
const OLEUI_IOERR_LPFORMATETCINVALID = OLEUI_ERR_STANDARDMAX + 3
const OLEUI_IOERR_PPVOBJINVALID = OLEUI_ERR_STANDARDMAX + 4
const OLEUI_IOERR_LPIOLECLIENTSITEINVALID = OLEUI_ERR_STANDARDMAX + 5
const OLEUI_IOERR_LPISTORAGEINVALID = OLEUI_ERR_STANDARDMAX + 6
const OLEUI_IOERR_SCODEHASERROR = OLEUI_ERR_STANDARDMAX + 7
const OLEUI_IOERR_LPCLSIDEXCLUDEINVALID = OLEUI_ERR_STANDARDMAX + 8
const OLEUI_IOERR_CCHFILEINVALID = OLEUI_ERR_STANDARDMAX + 9

type tagOLEUIPASTEFLAG as long
enum
	OLEUIPASTE_ENABLEICON = 2048
	OLEUIPASTE_PASTEONLY = 0
	OLEUIPASTE_PASTE = 512
	OLEUIPASTE_LINKANYTYPE = 1024
	OLEUIPASTE_LINKTYPE1 = 1
	OLEUIPASTE_LINKTYPE2 = 2
	OLEUIPASTE_LINKTYPE3 = 4
	OLEUIPASTE_LINKTYPE4 = 8
	OLEUIPASTE_LINKTYPE5 = 16
	OLEUIPASTE_LINKTYPE6 = 32
	OLEUIPASTE_LINKTYPE7 = 64
	OLEUIPASTE_LINKTYPE8 = 128
end enum

type OLEUIPASTEFLAG as tagOLEUIPASTEFLAG

type tagOLEUIPASTEENTRYW
	fmtetc as FORMATETC
	lpstrFormatName as LPCWSTR
	lpstrResultText as LPCWSTR
	dwFlags as DWORD
	dwScratchSpace as DWORD
end type

type OLEUIPASTEENTRYW as tagOLEUIPASTEENTRYW
type POLEUIPASTEENTRYW as tagOLEUIPASTEENTRYW ptr
type LPOLEUIPASTEENTRYW as tagOLEUIPASTEENTRYW ptr

type tagOLEUIPASTEENTRYA
	fmtetc as FORMATETC
	lpstrFormatName as LPCSTR
	lpstrResultText as LPCSTR
	dwFlags as DWORD
	dwScratchSpace as DWORD
end type

type OLEUIPASTEENTRYA as tagOLEUIPASTEENTRYA
type POLEUIPASTEENTRYA as tagOLEUIPASTEENTRYA ptr
type LPOLEUIPASTEENTRYA as tagOLEUIPASTEENTRYA ptr

#ifdef UNICODE
	type tagOLEUIPASTEENTRY as tagOLEUIPASTEENTRYW
	type OLEUIPASTEENTRY as OLEUIPASTEENTRYW
	type POLEUIPASTEENTRY as POLEUIPASTEENTRYW
	type LPOLEUIPASTEENTRY as LPOLEUIPASTEENTRYW
#else
	type tagOLEUIPASTEENTRY as tagOLEUIPASTEENTRYA
	type OLEUIPASTEENTRY as OLEUIPASTEENTRYA
	type POLEUIPASTEENTRY as POLEUIPASTEENTRYA
	type LPOLEUIPASTEENTRY as LPOLEUIPASTEENTRYA
#endif

const PS_MAXLINKTYPES = 8

type tagOLEUIPASTESPECIALW
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
	cPasteEntries as long
	arrLinkTypes as UINT ptr
	cLinkTypes as long
	cClsidExclude as UINT
	lpClsidExclude as LPCLSID
	nSelectedIndex as long
	fLink as WINBOOL
	hMetaPict as HGLOBAL
	sizel as SIZEL
end type

type OLEUIPASTESPECIALW as tagOLEUIPASTESPECIALW
type POLEUIPASTESPECIALW as tagOLEUIPASTESPECIALW ptr
type LPOLEUIPASTESPECIALW as tagOLEUIPASTESPECIALW ptr

type tagOLEUIPASTESPECIALA
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
	cPasteEntries as long
	arrLinkTypes as UINT ptr
	cLinkTypes as long
	cClsidExclude as UINT
	lpClsidExclude as LPCLSID
	nSelectedIndex as long
	fLink as WINBOOL
	hMetaPict as HGLOBAL
	sizel as SIZEL
end type

type OLEUIPASTESPECIALA as tagOLEUIPASTESPECIALA
type POLEUIPASTESPECIALA as tagOLEUIPASTESPECIALA ptr
type LPOLEUIPASTESPECIALA as tagOLEUIPASTESPECIALA ptr

#ifdef UNICODE
	type tagOLEUIPASTESPECIAL as tagOLEUIPASTESPECIALW
	type OLEUIPASTESPECIAL as OLEUIPASTESPECIALW
	type POLEUIPASTESPECIAL as POLEUIPASTESPECIALW
	type LPOLEUIPASTESPECIAL as LPOLEUIPASTESPECIALW
#else
	type tagOLEUIPASTESPECIAL as tagOLEUIPASTESPECIALA
	type OLEUIPASTESPECIAL as OLEUIPASTESPECIALA
	type POLEUIPASTESPECIAL as POLEUIPASTESPECIALA
	type LPOLEUIPASTESPECIAL as LPOLEUIPASTESPECIALA
#endif

declare function OleUIPasteSpecialW(byval as LPOLEUIPASTESPECIALW) as UINT
declare function OleUIPasteSpecialA(byval as LPOLEUIPASTESPECIALA) as UINT

#ifdef UNICODE
	declare function OleUIPasteSpecial alias "OleUIPasteSpecialW"(byval as LPOLEUIPASTESPECIALW) as UINT
#else
	declare function OleUIPasteSpecial alias "OleUIPasteSpecialA"(byval as LPOLEUIPASTESPECIALA) as UINT
#endif

const PSF_SHOWHELP = &h00000001
const PSF_SELECTPASTE = &h00000002
const PSF_SELECTPASTELINK = &h00000004
const PSF_CHECKDISPLAYASICON = &h00000008
const PSF_DISABLEDISPLAYASICON = &h00000010
const PSF_HIDECHANGEICON = &h00000020
const PSF_STAYONCLIPBOARDCHANGE = &h00000040
const PSF_NOREFRESHDATAOBJECT = &h00000080
const OLEUI_IOERR_SRCDATAOBJECTINVALID = OLEUI_ERR_STANDARDMAX + 0
const OLEUI_IOERR_ARRPASTEENTRIESINVALID = OLEUI_ERR_STANDARDMAX + 1
const OLEUI_IOERR_ARRLINKTYPESINVALID = OLEUI_ERR_STANDARDMAX + 2
const OLEUI_PSERR_CLIPBOARDCHANGED = OLEUI_ERR_STANDARDMAX + 3
const OLEUI_PSERR_GETCLIPBOARDFAILED = OLEUI_ERR_STANDARDMAX + 4
type IOleUILinkContainerWVtbl as IOleUILinkContainerWVtbl_

type IOleUILinkContainerW
	lpVtbl as IOleUILinkContainerWVtbl ptr
end type

type IOleUILinkContainerWVtbl_
	QueryInterface as function(byval This as IOleUILinkContainerW ptr, byval riid as const IID const ptr, byval ppvObj as LPVOID ptr) as HRESULT
	AddRef as function(byval This as IOleUILinkContainerW ptr) as ULONG
	Release as function(byval This as IOleUILinkContainerW ptr) as ULONG
	GetNextLink as function(byval This as IOleUILinkContainerW ptr, byval dwLink as DWORD) as DWORD
	SetLinkUpdateOptions as function(byval This as IOleUILinkContainerW ptr, byval dwLink as DWORD, byval dwUpdateOpt as DWORD) as HRESULT
	GetLinkUpdateOptions as function(byval This as IOleUILinkContainerW ptr, byval dwLink as DWORD, byval lpdwUpdateOpt as DWORD ptr) as HRESULT
	SetLinkSource as function(byval This as IOleUILinkContainerW ptr, byval dwLink as DWORD, byval lpszDisplayName as LPWSTR, byval lenFileName as ULONG, byval pchEaten as ULONG ptr, byval fValidateSource as WINBOOL) as HRESULT
	GetLinkSource as function(byval This as IOleUILinkContainerW ptr, byval dwLink as DWORD, byval lplpszDisplayName as LPWSTR ptr, byval lplenFileName as ULONG ptr, byval lplpszFullLinkType as LPWSTR ptr, byval lplpszShortLinkType as LPWSTR ptr, byval lpfSourceAvailable as WINBOOL ptr, byval lpfIsSelected as WINBOOL ptr) as HRESULT
	OpenLinkSource as function(byval This as IOleUILinkContainerW ptr, byval dwLink as DWORD) as HRESULT
	UpdateLink as function(byval This as IOleUILinkContainerW ptr, byval dwLink as DWORD, byval fErrorMessage as WINBOOL, byval fReserved as WINBOOL) as HRESULT
	CancelLink as function(byval This as IOleUILinkContainerW ptr, byval dwLink as DWORD) as HRESULT
end type

type LPOLEUILINKCONTAINERW as IOleUILinkContainerW ptr
type IOleUILinkContainerAVtbl as IOleUILinkContainerAVtbl_

type IOleUILinkContainerA
	lpVtbl as IOleUILinkContainerAVtbl ptr
end type

type IOleUILinkContainerAVtbl_
	QueryInterface as function(byval This as IOleUILinkContainerA ptr, byval riid as const IID const ptr, byval ppvObj as LPVOID ptr) as HRESULT
	AddRef as function(byval This as IOleUILinkContainerA ptr) as ULONG
	Release as function(byval This as IOleUILinkContainerA ptr) as ULONG
	GetNextLink as function(byval This as IOleUILinkContainerA ptr, byval dwLink as DWORD) as DWORD
	SetLinkUpdateOptions as function(byval This as IOleUILinkContainerA ptr, byval dwLink as DWORD, byval dwUpdateOpt as DWORD) as HRESULT
	GetLinkUpdateOptions as function(byval This as IOleUILinkContainerA ptr, byval dwLink as DWORD, byval lpdwUpdateOpt as DWORD ptr) as HRESULT
	SetLinkSource as function(byval This as IOleUILinkContainerA ptr, byval dwLink as DWORD, byval lpszDisplayName as LPSTR, byval lenFileName as ULONG, byval pchEaten as ULONG ptr, byval fValidateSource as WINBOOL) as HRESULT
	GetLinkSource as function(byval This as IOleUILinkContainerA ptr, byval dwLink as DWORD, byval lplpszDisplayName as LPSTR ptr, byval lplenFileName as ULONG ptr, byval lplpszFullLinkType as LPSTR ptr, byval lplpszShortLinkType as LPSTR ptr, byval lpfSourceAvailable as WINBOOL ptr, byval lpfIsSelected as WINBOOL ptr) as HRESULT
	OpenLinkSource as function(byval This as IOleUILinkContainerA ptr, byval dwLink as DWORD) as HRESULT
	UpdateLink as function(byval This as IOleUILinkContainerA ptr, byval dwLink as DWORD, byval fErrorMessage as WINBOOL, byval fReserved as WINBOOL) as HRESULT
	CancelLink as function(byval This as IOleUILinkContainerA ptr, byval dwLink as DWORD) as HRESULT
end type

type LPOLEUILINKCONTAINERA as IOleUILinkContainerA ptr

#ifdef UNICODE
	type IOleUILinkContainer as IOleUILinkContainerW
	type LPOLEUILINKCONTAINER as LPOLEUILINKCONTAINERW
	type IOleUILinkContainerVtbl as IOleUILinkContainerWVtbl
#else
	type IOleUILinkContainer as IOleUILinkContainerA
	type LPOLEUILINKCONTAINER as LPOLEUILINKCONTAINERA
	type IOleUILinkContainerVtbl as IOleUILinkContainerAVtbl
#endif

type tagOLEUIEDITLINKSW
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

type OLEUIEDITLINKSW as tagOLEUIEDITLINKSW
type POLEUIEDITLINKSW as tagOLEUIEDITLINKSW ptr
type LPOLEUIEDITLINKSW as tagOLEUIEDITLINKSW ptr

type tagOLEUIEDITLINKSA
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

type OLEUIEDITLINKSA as tagOLEUIEDITLINKSA
type POLEUIEDITLINKSA as tagOLEUIEDITLINKSA ptr
type LPOLEUIEDITLINKSA as tagOLEUIEDITLINKSA ptr

#ifdef UNICODE
	type tagOLEUIEDITLINKS as tagOLEUIEDITLINKSW
	type OLEUIEDITLINKS as OLEUIEDITLINKSW
	type POLEUIEDITLINKS as POLEUIEDITLINKSW
	type LPOLEUIEDITLINKS as LPOLEUIEDITLINKSW
#else
	type tagOLEUIEDITLINKS as tagOLEUIEDITLINKSA
	type OLEUIEDITLINKS as OLEUIEDITLINKSA
	type POLEUIEDITLINKS as POLEUIEDITLINKSA
	type LPOLEUIEDITLINKS as LPOLEUIEDITLINKSA
#endif

const OLEUI_ELERR_LINKCNTRNULL = OLEUI_ERR_STANDARDMAX + 0
const OLEUI_ELERR_LINKCNTRINVALID = OLEUI_ERR_STANDARDMAX + 1
declare function OleUIEditLinksW(byval as LPOLEUIEDITLINKSW) as UINT
declare function OleUIEditLinksA(byval as LPOLEUIEDITLINKSA) as UINT

#ifdef UNICODE
	declare function OleUIEditLinks alias "OleUIEditLinksW"(byval as LPOLEUIEDITLINKSW) as UINT
#else
	declare function OleUIEditLinks alias "OleUIEditLinksA"(byval as LPOLEUIEDITLINKSA) as UINT
#endif

const ELF_SHOWHELP = &h00000001
const ELF_DISABLEUPDATENOW = &h00000002
const ELF_DISABLEOPENSOURCE = &h00000004
const ELF_DISABLECHANGESOURCE = &h00000008
const ELF_DISABLECANCELLINK = &h00000010

type tagOLEUICHANGEICONW
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
	cchIconExe as long
end type

type OLEUICHANGEICONW as tagOLEUICHANGEICONW
type POLEUICHANGEICONW as tagOLEUICHANGEICONW ptr
type LPOLEUICHANGEICONW as tagOLEUICHANGEICONW ptr

type tagOLEUICHANGEICONA
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
	cchIconExe as long
end type

type OLEUICHANGEICONA as tagOLEUICHANGEICONA
type POLEUICHANGEICONA as tagOLEUICHANGEICONA ptr
type LPOLEUICHANGEICONA as tagOLEUICHANGEICONA ptr
declare function OleUIChangeIconW(byval as LPOLEUICHANGEICONW) as UINT
declare function OleUIChangeIconA(byval as LPOLEUICHANGEICONA) as UINT

#ifdef UNICODE
	type tagOLEUICHANGEICON as tagOLEUICHANGEICONW
	type OLEUICHANGEICON as OLEUICHANGEICONW
	type POLEUICHANGEICON as POLEUICHANGEICONW
	type LPOLEUICHANGEICON as LPOLEUICHANGEICONW
	declare function OleUIChangeIcon alias "OleUIChangeIconW"(byval as LPOLEUICHANGEICONW) as UINT
#else
	type tagOLEUICHANGEICON as tagOLEUICHANGEICONA
	type OLEUICHANGEICON as OLEUICHANGEICONA
	type POLEUICHANGEICON as POLEUICHANGEICONA
	type LPOLEUICHANGEICON as LPOLEUICHANGEICONA
	declare function OleUIChangeIcon alias "OleUIChangeIconA"(byval as LPOLEUICHANGEICONA) as UINT
#endif

const CIF_SHOWHELP = &h00000001
const CIF_SELECTCURRENT = &h00000002
const CIF_SELECTDEFAULT = &h00000004
const CIF_SELECTFROMFILE = &h00000008
const CIF_USEICONEXE = &h00000010
const OLEUI_CIERR_MUSTHAVECLSID = OLEUI_ERR_STANDARDMAX + 0
const OLEUI_CIERR_MUSTHAVECURRENTMETAFILE = OLEUI_ERR_STANDARDMAX + 1
const OLEUI_CIERR_SZICONEXEINVALID = OLEUI_ERR_STANDARDMAX + 2
#define PROP_HWND_CHGICONDLG __TEXT("HWND_CIDLG")

type tagOLEUICONVERTW
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
	fIsLinkedObject as WINBOOL
	hMetaPict as HGLOBAL
	lpszUserType as LPWSTR
	fObjectsIconChanged as WINBOOL
	lpszDefLabel as LPWSTR
	cClsidExclude as UINT
	lpClsidExclude as LPCLSID
end type

type OLEUICONVERTW as tagOLEUICONVERTW
type POLEUICONVERTW as tagOLEUICONVERTW ptr
type LPOLEUICONVERTW as tagOLEUICONVERTW ptr

type tagOLEUICONVERTA
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
	fIsLinkedObject as WINBOOL
	hMetaPict as HGLOBAL
	lpszUserType as LPSTR
	fObjectsIconChanged as WINBOOL
	lpszDefLabel as LPSTR
	cClsidExclude as UINT
	lpClsidExclude as LPCLSID
end type

type OLEUICONVERTA as tagOLEUICONVERTA
type POLEUICONVERTA as tagOLEUICONVERTA ptr
type LPOLEUICONVERTA as tagOLEUICONVERTA ptr

#ifdef UNICODE
	type tagOLEUICONVERT as tagOLEUICONVERTW
	type OLEUICONVERT as OLEUICONVERTW
	type POLEUICONVERT as POLEUICONVERTW
	type LPOLEUICONVERT as LPOLEUICONVERTW
	declare function OleUIConvert alias "OleUIConvertW"(byval as LPOLEUICONVERTW) as UINT
#else
	type tagOLEUICONVERT as tagOLEUICONVERTA
	type OLEUICONVERT as OLEUICONVERTA
	type POLEUICONVERT as POLEUICONVERTA
	type LPOLEUICONVERT as LPOLEUICONVERTA
	declare function OleUIConvert alias "OleUIConvertA"(byval as LPOLEUICONVERTA) as UINT
#endif

declare function OleUICanConvertOrActivateAs(byval rClsid as const IID const ptr, byval fIsLinkedObject as WINBOOL, byval wFormat as WORD) as WINBOOL
const CF_SHOWHELPBUTTON = &h00000001
const CF_SETCONVERTDEFAULT = &h00000002
const CF_SETACTIVATEDEFAULT = &h00000004
const CF_SELECTCONVERTTO = &h00000008
const CF_SELECTACTIVATEAS = &h00000010
const CF_DISABLEDISPLAYASICON = &h00000020
const CF_DISABLEACTIVATEAS = &h00000040
const CF_HIDECHANGEICON = &h00000080
const CF_CONVERTONLY = &h00000100
const OLEUI_CTERR_CLASSIDINVALID = OLEUI_ERR_STANDARDMAX + 1
const OLEUI_CTERR_DVASPECTINVALID = OLEUI_ERR_STANDARDMAX + 2
const OLEUI_CTERR_CBFORMATINVALID = OLEUI_ERR_STANDARDMAX + 3
const OLEUI_CTERR_HMETAPICTINVALID = OLEUI_ERR_STANDARDMAX + 4
const OLEUI_CTERR_STRINGINVALID = OLEUI_ERR_STANDARDMAX + 5

type tagOLEUIBUSYW
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

type OLEUIBUSYW as tagOLEUIBUSYW
type POLEUIBUSYW as tagOLEUIBUSYW ptr
type LPOLEUIBUSYW as tagOLEUIBUSYW ptr

type tagOLEUIBUSYA
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

type OLEUIBUSYA as tagOLEUIBUSYA
type POLEUIBUSYA as tagOLEUIBUSYA ptr
type LPOLEUIBUSYA as tagOLEUIBUSYA ptr
declare function OleUIBusyW(byval as LPOLEUIBUSYW) as UINT
declare function OleUIBusyA(byval as LPOLEUIBUSYA) as UINT

#ifdef UNICODE
	type tagOLEUIBUSY as tagOLEUIBUSYW
	type OLEUIBUSY as OLEUIBUSYW
	type POLEUIBUSY as POLEUIBUSYW
	type LPOLEUIBUSY as LPOLEUIBUSYW
	declare function OleUIBusy alias "OleUIBusyW"(byval as LPOLEUIBUSYW) as UINT
#else
	type tagOLEUIBUSY as tagOLEUIBUSYA
	type OLEUIBUSY as OLEUIBUSYA
	type POLEUIBUSY as POLEUIBUSYA
	type LPOLEUIBUSY as LPOLEUIBUSYA
	declare function OleUIBusy alias "OleUIBusyA"(byval as LPOLEUIBUSYA) as UINT
#endif

const BZ_DISABLECANCELBUTTON = &h00000001
const BZ_DISABLESWITCHTOBUTTON = &h00000002
const BZ_DISABLERETRYBUTTON = &h00000004
const BZ_NOTRESPONDINGDIALOG = &h00000008
const OLEUI_BZERR_HTASKINVALID = OLEUI_ERR_STANDARDMAX + 0
const OLEUI_BZ_SWITCHTOSELECTED = OLEUI_ERR_STANDARDMAX + 1
const OLEUI_BZ_RETRYSELECTED = OLEUI_ERR_STANDARDMAX + 2
const OLEUI_BZ_CALLUNBLOCKED = OLEUI_ERR_STANDARDMAX + 3

type tagOLEUICHANGESOURCEW
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
	dwReserved1(0 to 3) as DWORD
	lpOleUILinkContainer as LPOLEUILINKCONTAINERW
	dwLink as DWORD
	lpszDisplayName as LPWSTR
	nFileLength as ULONG
	lpszFrom as LPWSTR
	lpszTo as LPWSTR
end type

type OLEUICHANGESOURCEW as tagOLEUICHANGESOURCEW
type POLEUICHANGESOURCEW as tagOLEUICHANGESOURCEW ptr
type LPOLEUICHANGESOURCEW as tagOLEUICHANGESOURCEW ptr

type tagOLEUICHANGESOURCEA
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
	dwReserved1(0 to 3) as DWORD
	lpOleUILinkContainer as LPOLEUILINKCONTAINERA
	dwLink as DWORD
	lpszDisplayName as LPSTR
	nFileLength as ULONG
	lpszFrom as LPSTR
	lpszTo as LPSTR
end type

type OLEUICHANGESOURCEA as tagOLEUICHANGESOURCEA
type POLEUICHANGESOURCEA as tagOLEUICHANGESOURCEA ptr
type LPOLEUICHANGESOURCEA as tagOLEUICHANGESOURCEA ptr
declare function OleUIChangeSourceW(byval as LPOLEUICHANGESOURCEW) as UINT
declare function OleUIChangeSourceA(byval as LPOLEUICHANGESOURCEA) as UINT

#ifdef UNICODE
	type tagOLEUICHANGESOURCE as tagOLEUICHANGESOURCEW
	type OLEUICHANGESOURCE as OLEUICHANGESOURCEW
	type POLEUICHANGESOURCE as POLEUICHANGESOURCEW
	type LPOLEUICHANGESOURCE as LPOLEUICHANGESOURCEW
	declare function OleUIChangeSource alias "OleUIChangeSourceW"(byval as LPOLEUICHANGESOURCEW) as UINT
#else
	type tagOLEUICHANGESOURCE as tagOLEUICHANGESOURCEA
	type OLEUICHANGESOURCE as OLEUICHANGESOURCEA
	type POLEUICHANGESOURCE as POLEUICHANGESOURCEA
	type LPOLEUICHANGESOURCE as LPOLEUICHANGESOURCEA
	declare function OleUIChangeSource alias "OleUIChangeSourceA"(byval as LPOLEUICHANGESOURCEA) as UINT
#endif

const CSF_SHOWHELP = &h00000001
const CSF_VALIDSOURCE = &h00000002
const CSF_ONLYGETSOURCE = &h00000004
const CSF_EXPLORER = &h00000008
const OLEUI_CSERR_LINKCNTRNULL = OLEUI_ERR_STANDARDMAX + 0
const OLEUI_CSERR_LINKCNTRINVALID = OLEUI_ERR_STANDARDMAX + 1
const OLEUI_CSERR_FROMNOTNULL = OLEUI_ERR_STANDARDMAX + 2
const OLEUI_CSERR_TONOTNULL = OLEUI_ERR_STANDARDMAX + 3
const OLEUI_CSERR_SOURCENULL = OLEUI_ERR_STANDARDMAX + 4
const OLEUI_CSERR_SOURCEINVALID = OLEUI_ERR_STANDARDMAX + 5
const OLEUI_CSERR_SOURCEPARSERROR = OLEUI_ERR_STANDARDMAX + 6
const OLEUI_CSERR_SOURCEPARSEERROR = OLEUI_ERR_STANDARDMAX + 6
type IOleUIObjInfoWVtbl as IOleUIObjInfoWVtbl_

type IOleUIObjInfoW
	lpVtbl as IOleUIObjInfoWVtbl ptr
end type

type IOleUIObjInfoWVtbl_
	QueryInterface as function(byval This as IOleUIObjInfoW ptr, byval riid as const IID const ptr, byval ppvObj as LPVOID ptr) as HRESULT
	AddRef as function(byval This as IOleUIObjInfoW ptr) as ULONG
	Release as function(byval This as IOleUIObjInfoW ptr) as ULONG
	GetObjectInfo as function(byval This as IOleUIObjInfoW ptr, byval dwObject as DWORD, byval lpdwObjSize as DWORD ptr, byval lplpszLabel as LPWSTR ptr, byval lplpszType as LPWSTR ptr, byval lplpszShortType as LPWSTR ptr, byval lplpszLocation as LPWSTR ptr) as HRESULT
	GetConvertInfo as function(byval This as IOleUIObjInfoW ptr, byval dwObject as DWORD, byval lpClassID as CLSID ptr, byval lpwFormat as WORD ptr, byval lpConvertDefaultClassID as CLSID ptr, byval lplpClsidExclude as LPCLSID ptr, byval lpcClsidExclude as UINT ptr) as HRESULT
	ConvertObject as function(byval This as IOleUIObjInfoW ptr, byval dwObject as DWORD, byval clsidNew as const IID const ptr) as HRESULT
	GetViewInfo as function(byval This as IOleUIObjInfoW ptr, byval dwObject as DWORD, byval phMetaPict as HGLOBAL ptr, byval pdvAspect as DWORD ptr, byval pnCurrentScale as long ptr) as HRESULT
	SetViewInfo as function(byval This as IOleUIObjInfoW ptr, byval dwObject as DWORD, byval hMetaPict as HGLOBAL, byval dvAspect as DWORD, byval nCurrentScale as long, byval bRelativeToOrig as WINBOOL) as HRESULT
end type

type LPOLEUIOBJINFOW as IOleUIObjInfoW ptr
type IOleUIObjInfoAVtbl as IOleUIObjInfoAVtbl_

type IOleUIObjInfoA
	lpVtbl as IOleUIObjInfoAVtbl ptr
end type

type IOleUIObjInfoAVtbl_
	QueryInterface as function(byval This as IOleUIObjInfoA ptr, byval riid as const IID const ptr, byval ppvObj as LPVOID ptr) as HRESULT
	AddRef as function(byval This as IOleUIObjInfoA ptr) as ULONG
	Release as function(byval This as IOleUIObjInfoA ptr) as ULONG
	GetObjectInfo as function(byval This as IOleUIObjInfoA ptr, byval dwObject as DWORD, byval lpdwObjSize as DWORD ptr, byval lplpszLabel as LPSTR ptr, byval lplpszType as LPSTR ptr, byval lplpszShortType as LPSTR ptr, byval lplpszLocation as LPSTR ptr) as HRESULT
	GetConvertInfo as function(byval This as IOleUIObjInfoA ptr, byval dwObject as DWORD, byval lpClassID as CLSID ptr, byval lpwFormat as WORD ptr, byval lpConvertDefaultClassID as CLSID ptr, byval lplpClsidExclude as LPCLSID ptr, byval lpcClsidExclude as UINT ptr) as HRESULT
	ConvertObject as function(byval This as IOleUIObjInfoA ptr, byval dwObject as DWORD, byval clsidNew as const IID const ptr) as HRESULT
	GetViewInfo as function(byval This as IOleUIObjInfoA ptr, byval dwObject as DWORD, byval phMetaPict as HGLOBAL ptr, byval pdvAspect as DWORD ptr, byval pnCurrentScale as long ptr) as HRESULT
	SetViewInfo as function(byval This as IOleUIObjInfoA ptr, byval dwObject as DWORD, byval hMetaPict as HGLOBAL, byval dvAspect as DWORD, byval nCurrentScale as long, byval bRelativeToOrig as WINBOOL) as HRESULT
end type

type LPOLEUIOBJINFOA as IOleUIObjInfoA ptr

#ifdef UNICODE
	type IOleUIObjInfo as IOleUIObjInfoW
	type LPOLEUIOBJINFO as LPOLEUIOBJINFOW
	type IOleUIObjInfoVtbl as IOleUIObjInfoWVtbl
#else
	type IOleUIObjInfo as IOleUIObjInfoA
	type LPOLEUIOBJINFO as LPOLEUIOBJINFOA
	type IOleUIObjInfoVtbl as IOleUIObjInfoAVtbl
#endif

type IOleUILinkInfoWVtbl as IOleUILinkInfoWVtbl_

type IOleUILinkInfoW
	lpVtbl as IOleUILinkInfoWVtbl ptr
end type

type IOleUILinkInfoWVtbl_
	QueryInterface as function(byval This as IOleUILinkInfoW ptr, byval riid as const IID const ptr, byval ppvObj as LPVOID ptr) as HRESULT
	AddRef as function(byval This as IOleUILinkInfoW ptr) as ULONG
	Release as function(byval This as IOleUILinkInfoW ptr) as ULONG
	GetNextLink as function(byval This as IOleUILinkInfoW ptr, byval dwLink as DWORD) as DWORD
	SetLinkUpdateOptions as function(byval This as IOleUILinkInfoW ptr, byval dwLink as DWORD, byval dwUpdateOpt as DWORD) as HRESULT
	GetLinkUpdateOptions as function(byval This as IOleUILinkInfoW ptr, byval dwLink as DWORD, byval lpdwUpdateOpt as DWORD ptr) as HRESULT
	SetLinkSource as function(byval This as IOleUILinkInfoW ptr, byval dwLink as DWORD, byval lpszDisplayName as LPWSTR, byval lenFileName as ULONG, byval pchEaten as ULONG ptr, byval fValidateSource as WINBOOL) as HRESULT
	GetLinkSource as function(byval This as IOleUILinkInfoW ptr, byval dwLink as DWORD, byval lplpszDisplayName as LPWSTR ptr, byval lplenFileName as ULONG ptr, byval lplpszFullLinkType as LPWSTR ptr, byval lplpszShortLinkType as LPWSTR ptr, byval lpfSourceAvailable as WINBOOL ptr, byval lpfIsSelected as WINBOOL ptr) as HRESULT
	OpenLinkSource as function(byval This as IOleUILinkInfoW ptr, byval dwLink as DWORD) as HRESULT
	UpdateLink as function(byval This as IOleUILinkInfoW ptr, byval dwLink as DWORD, byval fErrorMessage as WINBOOL, byval fReserved as WINBOOL) as HRESULT
	CancelLink as function(byval This as IOleUILinkInfoW ptr, byval dwLink as DWORD) as HRESULT
	GetLastUpdate as function(byval This as IOleUILinkInfoW ptr, byval dwLink as DWORD, byval lpLastUpdate as FILETIME ptr) as HRESULT
end type

type LPOLEUILINKINFOW as IOleUILinkInfoW ptr
type IOleUILinkInfoAVtbl as IOleUILinkInfoAVtbl_

type IOleUILinkInfoA
	lpVtbl as IOleUILinkInfoAVtbl ptr
end type

type IOleUILinkInfoAVtbl_
	QueryInterface as function(byval This as IOleUILinkInfoA ptr, byval riid as const IID const ptr, byval ppvObj as LPVOID ptr) as HRESULT
	AddRef as function(byval This as IOleUILinkInfoA ptr) as ULONG
	Release as function(byval This as IOleUILinkInfoA ptr) as ULONG
	GetNextLink as function(byval This as IOleUILinkInfoA ptr, byval dwLink as DWORD) as DWORD
	SetLinkUpdateOptions as function(byval This as IOleUILinkInfoA ptr, byval dwLink as DWORD, byval dwUpdateOpt as DWORD) as HRESULT
	GetLinkUpdateOptions as function(byval This as IOleUILinkInfoA ptr, byval dwLink as DWORD, byval lpdwUpdateOpt as DWORD ptr) as HRESULT
	SetLinkSource as function(byval This as IOleUILinkInfoA ptr, byval dwLink as DWORD, byval lpszDisplayName as LPSTR, byval lenFileName as ULONG, byval pchEaten as ULONG ptr, byval fValidateSource as WINBOOL) as HRESULT
	GetLinkSource as function(byval This as IOleUILinkInfoA ptr, byval dwLink as DWORD, byval lplpszDisplayName as LPSTR ptr, byval lplenFileName as ULONG ptr, byval lplpszFullLinkType as LPSTR ptr, byval lplpszShortLinkType as LPSTR ptr, byval lpfSourceAvailable as WINBOOL ptr, byval lpfIsSelected as WINBOOL ptr) as HRESULT
	OpenLinkSource as function(byval This as IOleUILinkInfoA ptr, byval dwLink as DWORD) as HRESULT
	UpdateLink as function(byval This as IOleUILinkInfoA ptr, byval dwLink as DWORD, byval fErrorMessage as WINBOOL, byval fReserved as WINBOOL) as HRESULT
	CancelLink as function(byval This as IOleUILinkInfoA ptr, byval dwLink as DWORD) as HRESULT
	GetLastUpdate as function(byval This as IOleUILinkInfoA ptr, byval dwLink as DWORD, byval lpLastUpdate as FILETIME ptr) as HRESULT
end type

type LPOLEUILINKINFOA as IOleUILinkInfoA ptr

#ifdef UNICODE
	type IOleUILinkInfo as IOleUILinkInfoW
	type LPOLEUILINKINFO as LPOLEUILINKINFOW
	type IOleUILinkInfoVtbl as IOleUILinkInfoWVtbl
#else
	type IOleUILinkInfo as IOleUILinkInfoA
	type LPOLEUILINKINFO as LPOLEUILINKINFOA
	type IOleUILinkInfoVtbl as IOleUILinkInfoAVtbl
#endif

type tagOLEUIOBJECTPROPSW as tagOLEUIOBJECTPROPSW_

type tagOLEUIGNRLPROPSW
	cbStruct as DWORD
	dwFlags as DWORD
	dwReserved1(0 to 1) as DWORD
	lpfnHook as LPFNOLEUIHOOK
	lCustData as LPARAM
	dwReserved2(0 to 2) as DWORD
	lpOP as tagOLEUIOBJECTPROPSW ptr
end type

type OLEUIGNRLPROPSW as tagOLEUIGNRLPROPSW
type POLEUIGNRLPROPSW as tagOLEUIGNRLPROPSW ptr
type LPOLEUIGNRLPROPSW as tagOLEUIGNRLPROPSW ptr
type tagOLEUIOBJECTPROPSA as tagOLEUIOBJECTPROPSA_

type tagOLEUIGNRLPROPSA
	cbStruct as DWORD
	dwFlags as DWORD
	dwReserved1(0 to 1) as DWORD
	lpfnHook as LPFNOLEUIHOOK
	lCustData as LPARAM
	dwReserved2(0 to 2) as DWORD
	lpOP as tagOLEUIOBJECTPROPSA ptr
end type

type OLEUIGNRLPROPSA as tagOLEUIGNRLPROPSA
type POLEUIGNRLPROPSA as tagOLEUIGNRLPROPSA ptr
type LPOLEUIGNRLPROPSA as tagOLEUIGNRLPROPSA ptr

#ifdef UNICODE
	type tagOLEUIGNRLPROPS as tagOLEUIGNRLPROPSW
	type OLEUIGNRLPROPS as OLEUIGNRLPROPSW
	type POLEUIGNRLPROPS as POLEUIGNRLPROPSW
	type LPOLEUIGNRLPROPS as LPOLEUIGNRLPROPSW
#else
	type tagOLEUIGNRLPROPS as tagOLEUIGNRLPROPSA
	type OLEUIGNRLPROPS as OLEUIGNRLPROPSA
	type POLEUIGNRLPROPS as POLEUIGNRLPROPSA
	type LPOLEUIGNRLPROPS as LPOLEUIGNRLPROPSA
#endif

type tagOLEUIVIEWPROPSW
	cbStruct as DWORD
	dwFlags as DWORD
	dwReserved1(0 to 1) as DWORD
	lpfnHook as LPFNOLEUIHOOK
	lCustData as LPARAM
	dwReserved2(0 to 2) as DWORD
	lpOP as tagOLEUIOBJECTPROPSW ptr
	nScaleMin as long
	nScaleMax as long
end type

type OLEUIVIEWPROPSW as tagOLEUIVIEWPROPSW
type POLEUIVIEWPROPSW as tagOLEUIVIEWPROPSW ptr
type LPOLEUIVIEWPROPSW as tagOLEUIVIEWPROPSW ptr

type tagOLEUIVIEWPROPSA
	cbStruct as DWORD
	dwFlags as DWORD
	dwReserved1(0 to 1) as DWORD
	lpfnHook as LPFNOLEUIHOOK
	lCustData as LPARAM
	dwReserved2(0 to 2) as DWORD
	lpOP as tagOLEUIOBJECTPROPSA ptr
	nScaleMin as long
	nScaleMax as long
end type

type OLEUIVIEWPROPSA as tagOLEUIVIEWPROPSA
type POLEUIVIEWPROPSA as tagOLEUIVIEWPROPSA ptr
type LPOLEUIVIEWPROPSA as tagOLEUIVIEWPROPSA ptr

#ifdef UNICODE
	type tagOLEUIVIEWPROPS as tagOLEUIVIEWPROPSW
	type OLEUIVIEWPROPS as OLEUIVIEWPROPSW
	type POLEUIVIEWPROPS as POLEUIVIEWPROPSW
	type LPOLEUIVIEWPROPS as LPOLEUIVIEWPROPSW
#else
	type tagOLEUIVIEWPROPS as tagOLEUIVIEWPROPSA
	type OLEUIVIEWPROPS as OLEUIVIEWPROPSA
	type POLEUIVIEWPROPS as POLEUIVIEWPROPSA
	type LPOLEUIVIEWPROPS as LPOLEUIVIEWPROPSA
#endif

const VPF_SELECTRELATIVE = &h00000001
const VPF_DISABLERELATIVE = &h00000002
const VPF_DISABLESCALE = &h00000004

type tagOLEUILINKPROPSW
	cbStruct as DWORD
	dwFlags as DWORD
	dwReserved1(0 to 1) as DWORD
	lpfnHook as LPFNOLEUIHOOK
	lCustData as LPARAM
	dwReserved2(0 to 2) as DWORD
	lpOP as tagOLEUIOBJECTPROPSW ptr
end type

type OLEUILINKPROPSW as tagOLEUILINKPROPSW
type POLEUILINKPROPSW as tagOLEUILINKPROPSW ptr
type LPOLEUILINKPROPSW as tagOLEUILINKPROPSW ptr

type tagOLEUILINKPROPSA
	cbStruct as DWORD
	dwFlags as DWORD
	dwReserved1(0 to 1) as DWORD
	lpfnHook as LPFNOLEUIHOOK
	lCustData as LPARAM
	dwReserved2(0 to 2) as DWORD
	lpOP as tagOLEUIOBJECTPROPSA ptr
end type

type OLEUILINKPROPSA as tagOLEUILINKPROPSA
type POLEUILINKPROPSA as tagOLEUILINKPROPSA ptr
type LPOLEUILINKPROPSA as tagOLEUILINKPROPSA ptr

#ifdef UNICODE
	type tagOLEUILINKPROPS as tagOLEUILINKPROPSW
	type OLEUILINKPROPS as OLEUILINKPROPSW
	type POLEUILINKPROPS as POLEUILINKPROPSW
	type LPOLEUILINKPROPS as LPOLEUILINKPROPSW
#else
	type tagOLEUILINKPROPS as tagOLEUILINKPROPSA
	type OLEUILINKPROPS as OLEUILINKPROPSA
	type POLEUILINKPROPS as POLEUILINKPROPSA
	type LPOLEUILINKPROPS as LPOLEUILINKPROPSA
#endif

type LPPROPSHEETHEADERW as _PROPSHEETHEADERW ptr
type LPPROPSHEETHEADERA as _PROPSHEETHEADERA ptr

#ifdef UNICODE
	type LPPROPSHEETHEADER as LPPROPSHEETHEADERW
#else
	type LPPROPSHEETHEADER as LPPROPSHEETHEADERA
#endif

type tagOLEUIOBJECTPROPSW_
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

type OLEUIOBJECTPROPSW as tagOLEUIOBJECTPROPSW
type POLEUIOBJECTPROPSW as tagOLEUIOBJECTPROPSW ptr
type LPOLEUIOBJECTPROPSW as tagOLEUIOBJECTPROPSW ptr

type tagOLEUIOBJECTPROPSA_
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

type OLEUIOBJECTPROPSA as tagOLEUIOBJECTPROPSA
type POLEUIOBJECTPROPSA as tagOLEUIOBJECTPROPSA ptr
type LPOLEUIOBJECTPROPSA as tagOLEUIOBJECTPROPSA ptr
declare function OleUIObjectPropertiesW(byval as LPOLEUIOBJECTPROPSW) as UINT
declare function OleUIObjectPropertiesA(byval as LPOLEUIOBJECTPROPSA) as UINT

#ifdef UNICODE
	type tagOLEUIOBJECTPROPS as tagOLEUIOBJECTPROPSW
	type OLEUIOBJECTPROPS as OLEUIOBJECTPROPSW
	type POLEUIOBJECTPROPS as POLEUIOBJECTPROPSW
	type LPOLEUIOBJECTPROPS as LPOLEUIOBJECTPROPSW
	declare function OleUIObjectProperties alias "OleUIObjectPropertiesW"(byval as LPOLEUIOBJECTPROPSW) as UINT
#else
	type tagOLEUIOBJECTPROPS as tagOLEUIOBJECTPROPSA
	type OLEUIOBJECTPROPS as OLEUIOBJECTPROPSA
	type POLEUIOBJECTPROPS as POLEUIOBJECTPROPSA
	type LPOLEUIOBJECTPROPS as LPOLEUIOBJECTPROPSA
	declare function OleUIObjectProperties alias "OleUIObjectPropertiesA"(byval as LPOLEUIOBJECTPROPSA) as UINT
#endif

const OPF_OBJECTISLINK = &h00000001
const OPF_NOFILLDEFAULT = &h00000002
const OPF_SHOWHELP = &h00000004
const OPF_DISABLECONVERT = &h00000008
const OLEUI_OPERR_SUBPROPNULL = OLEUI_ERR_STANDARDMAX + 0
const OLEUI_OPERR_SUBPROPINVALID = OLEUI_ERR_STANDARDMAX + 1
const OLEUI_OPERR_PROPSHEETNULL = OLEUI_ERR_STANDARDMAX + 2
const OLEUI_OPERR_PROPSHEETINVALID = OLEUI_ERR_STANDARDMAX + 3
const OLEUI_OPERR_SUPPROP = OLEUI_ERR_STANDARDMAX + 4
const OLEUI_OPERR_PROPSINVALID = OLEUI_ERR_STANDARDMAX + 5
const OLEUI_OPERR_PAGESINCORRECT = OLEUI_ERR_STANDARDMAX + 6
const OLEUI_OPERR_INVALIDPAGES = OLEUI_ERR_STANDARDMAX + 7
const OLEUI_OPERR_NOTSUPPORTED = OLEUI_ERR_STANDARDMAX + 8
const OLEUI_OPERR_DLGPROCNOTNULL = OLEUI_ERR_STANDARDMAX + 9
const OLEUI_OPERR_LPARAMNOTZERO = OLEUI_ERR_STANDARDMAX + 10
const OLEUI_GPERR_STRINGINVALID = OLEUI_ERR_STANDARDMAX + 11
const OLEUI_GPERR_CLASSIDINVALID = OLEUI_ERR_STANDARDMAX + 12
const OLEUI_GPERR_LPCLSIDEXCLUDEINVALID = OLEUI_ERR_STANDARDMAX + 13
const OLEUI_GPERR_CBFORMATINVALID = OLEUI_ERR_STANDARDMAX + 14
const OLEUI_VPERR_METAPICTINVALID = OLEUI_ERR_STANDARDMAX + 15
const OLEUI_VPERR_DVASPECTINVALID = OLEUI_ERR_STANDARDMAX + 16
const OLEUI_LPERR_LINKCNTRNULL = OLEUI_ERR_STANDARDMAX + 17
const OLEUI_LPERR_LINKCNTRINVALID = OLEUI_ERR_STANDARDMAX + 18
const OLEUI_OPERR_PROPERTYSHEET = OLEUI_ERR_STANDARDMAX + 19
const OLEUI_OPERR_OBJINFOINVALID = OLEUI_ERR_STANDARDMAX + 20
const OLEUI_OPERR_LINKINFOINVALID = OLEUI_ERR_STANDARDMAX + 21
const OLEUI_QUERY_GETCLASSID = &hFF00
const OLEUI_QUERY_LINKBROKEN = &hFF01
declare function OleUIPromptUserW cdecl(byval nTemplate as long, byval hwndParent as HWND, ...) as long
declare function OleUIPromptUserA cdecl(byval nTemplate as long, byval hwndParent as HWND, ...) as long

#ifdef UNICODE
	declare function OleUIPromptUser cdecl alias "OleUIPromptUserW"(byval nTemplate as long, byval hwndParent as HWND, ...) as long
#else
	declare function OleUIPromptUser cdecl alias "OleUIPromptUserA"(byval nTemplate as long, byval hwndParent as HWND, ...) as long
#endif

declare function OleUIUpdateLinksW(byval lpOleUILinkCntr as LPOLEUILINKCONTAINERW, byval hwndParent as HWND, byval lpszTitle as LPWSTR, byval cLinks as long) as WINBOOL
declare function OleUIUpdateLinksA(byval lpOleUILinkCntr as LPOLEUILINKCONTAINERA, byval hwndParent as HWND, byval lpszTitle as LPSTR, byval cLinks as long) as WINBOOL

#ifdef UNICODE
	declare function OleUIUpdateLinks alias "OleUIUpdateLinksW"(byval lpOleUILinkCntr as LPOLEUILINKCONTAINERW, byval hwndParent as HWND, byval lpszTitle as LPWSTR, byval cLinks as long) as WINBOOL
#else
	declare function OleUIUpdateLinks alias "OleUIUpdateLinksA"(byval lpOleUILinkCntr as LPOLEUILINKCONTAINERA, byval hwndParent as HWND, byval lpszTitle as LPSTR, byval cLinks as long) as WINBOOL
#endif

end extern
