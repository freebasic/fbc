#pragma once

#include once "_mingw_unicode.bi"
#include once "windows.bi"
#include once "shellapi.bi"
#include once "commdlg.bi"
#include once "ole2.bi"
#include once "crt/string.bi"
#include once "dlgs.bi"
#include once "prsht.bi"

'' The following symbols have been renamed:
''     #define OleUIInsertObject => OleUIInsertObject_
''     #define OleUIPasteSpecial => OleUIPasteSpecial_
''     inside struct tagOLEUIEDITLINKSW:
''         field lpOleUILinkContainer => lpOleUILinkContainer_
''     inside struct tagOLEUIEDITLINKSA:
''         field lpOleUILinkContainer => lpOleUILinkContainer_
''     #define OleUIEditLinks => OleUIEditLinks_
''     #define OleUIChangeIcon => OleUIChangeIcon_
''     #define OleUIConvert => OleUIConvert_
''     #define OleUIBusy => OleUIBusy_
''     inside struct tagOLEUICHANGESOURCEW:
''         field lpOleUILinkContainer => lpOleUILinkContainer_
''     inside struct tagOLEUICHANGESOURCEA:
''         field lpOleUILinkContainer => lpOleUILinkContainer_
''     #define OleUIChangeSource => OleUIChangeSource_

#inclib "oledlg"

extern "Windows"

type IOleUILinkContainerWVtbl as IOleUILinkContainerWVtbl_
type IOleUILinkContainerAVtbl as IOleUILinkContainerAVtbl_
type IOleUIObjInfoWVtbl as IOleUIObjInfoWVtbl_
type IOleUIObjInfoAVtbl as IOleUIObjInfoAVtbl_
type IOleUILinkInfoWVtbl as IOleUILinkInfoWVtbl_
type IOleUILinkInfoAVtbl as IOleUILinkInfoAVtbl_
type tagOLEUIOBJECTPROPSW as tagOLEUIOBJECTPROPSW_
type tagOLEUIOBJECTPROPSA as tagOLEUIOBJECTPROPSA_

#define _OLEDLG_H_

#ifdef UNICODE
	#define _UNICODE
#endif

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
#define IDD_CONVERT4 1103
#define IDD_CONVERTONLY4 1104
#define IDD_EDITLINKS4 1105
#define IDD_GNRLPROPS4 1106
#define IDD_LINKPROPS4 1107
#define IDD_PASTESPECIAL4 1108
#define IDD_CANNOTUPDATELINK 1008
#define IDD_LINKSOURCEUNAVAILABLE 1020
#define IDD_SERVERNOTFOUND 1023
#define IDD_OUTOFMEMORY 1024
#define IDD_SERVERNOTREGW 1021
#define IDD_LINKTYPECHANGEDW 1022
#define IDD_SERVERNOTREGA 1025
#define IDD_LINKTYPECHANGEDA 1026

#ifdef UNICODE
	#define IDD_SERVERNOTREG IDD_SERVERNOTREGW
	#define IDD_LINKTYPECHANGED IDD_LINKTYPECHANGEDW
#else
	#define IDD_SERVERNOTREG IDD_SERVERNOTREGA
	#define IDD_LINKTYPECHANGED IDD_LINKTYPECHANGEDA
#endif

type LPFNOLEUIHOOK as function(byval as HWND, byval as UINT, byval as WPARAM, byval as LPARAM) as UINT

#define OLESTDDELIM __TEXT(!"\\")
#define SZOLEUI_MSG_HELP __TEXT("OLEUI_MSG_HELP")
#define SZOLEUI_MSG_ENDDIALOG __TEXT("OLEUI_MSG_ENDDIALOG")
#define SZOLEUI_MSG_BROWSE __TEXT("OLEUI_MSG_BROWSE")
#define SZOLEUI_MSG_CHANGEICON __TEXT("OLEUI_MSG_CHANGEICON")
#define SZOLEUI_MSG_CLOSEBUSYDIALOG __TEXT("OLEUI_MSG_CLOSEBUSYDIALOG")
#define SZOLEUI_MSG_CONVERT __TEXT("OLEUI_MSG_CONVERT")
#define SZOLEUI_MSG_CHANGESOURCE __TEXT("OLEUI_MSG_CHANGESOURCE")
#define SZOLEUI_MSG_ADDCONTROL __TEXT("OLEUI_MSG_ADDCONTROL")
#define SZOLEUI_MSG_BROWSE_OFN __TEXT("OLEUI_MSG_BROWSE_OFN")
#define ID_BROWSE_CHANGEICON 1
#define ID_BROWSE_INSERTFILE 2
#define ID_BROWSE_ADDCONTROL 3
#define ID_BROWSE_CHANGESOURCE 4
#define OLEUI_FALSE 0
#define OLEUI_SUCCESS 1
#define OLEUI_OK 1
#define OLEUI_CANCEL 2
#define OLEUI_ERR_STANDARDMIN 100
#define OLEUI_ERR_OLEMEMALLOC 100
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
#define OLEUI_ERR_STANDARDMAX 116

declare function OleUIAddVerbMenuW(byval lpOleObj as LPOLEOBJECT, byval lpszShortType as LPCWSTR, byval hMenu as HMENU, byval uPos as UINT, byval uIDVerbMin as UINT, byval uIDVerbMax as UINT, byval bAddConvert as WINBOOL, byval idConvert as UINT, byval lphMenu as HMENU ptr) as WINBOOL
declare function OleUIAddVerbMenuA(byval lpOleObj as LPOLEOBJECT, byval lpszShortType as LPCSTR, byval hMenu as HMENU, byval uPos as UINT, byval uIDVerbMin as UINT, byval uIDVerbMax as UINT, byval bAddConvert as WINBOOL, byval idConvert as UINT, byval lphMenu as HMENU ptr) as WINBOOL

#ifdef UNICODE
	#define OleUIAddVerbMenu OleUIAddVerbMenuW
#else
	#define OleUIAddVerbMenu OleUIAddVerbMenuA
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
	#define tagOLEUIINSERTOBJECT tagOLEUIINSERTOBJECTW
	#define OLEUIINSERTOBJECT OLEUIINSERTOBJECTW
	#define POLEUIINSERTOBJECT POLEUIINSERTOBJECTW
	#define LPOLEUIINSERTOBJECT LPOLEUIINSERTOBJECTW
	#define OleUIInsertObject_ OleUIInsertObjectW
#else
	#define tagOLEUIINSERTOBJECT tagOLEUIINSERTOBJECTA
	#define OLEUIINSERTOBJECT OLEUIINSERTOBJECTA
	#define POLEUIINSERTOBJECT POLEUIINSERTOBJECTA
	#define LPOLEUIINSERTOBJECT LPOLEUIINSERTOBJECTA
	#define OleUIInsertObject_ OleUIInsertObjectA
#endif

#define IOF_SHOWHELP __MSABI_LONG(&h00000001)
#define IOF_SELECTCREATENEW __MSABI_LONG(&h00000002)
#define IOF_SELECTCREATEFROMFILE __MSABI_LONG(&h00000004)
#define IOF_CHECKLINK __MSABI_LONG(&h00000008)
#define IOF_CHECKDISPLAYASICON __MSABI_LONG(&h00000010)
#define IOF_CREATENEWOBJECT __MSABI_LONG(&h00000020)
#define IOF_CREATEFILEOBJECT __MSABI_LONG(&h00000040)
#define IOF_CREATELINKOBJECT __MSABI_LONG(&h00000080)
#define IOF_DISABLELINK __MSABI_LONG(&h00000100)
#define IOF_VERIFYSERVERSEXIST __MSABI_LONG(&h00000200)
#define IOF_DISABLEDISPLAYASICON __MSABI_LONG(&h00000400)
#define IOF_HIDECHANGEICON __MSABI_LONG(&h00000800)
#define IOF_SHOWINSERTCONTROL __MSABI_LONG(&h00001000)
#define IOF_SELECTCREATECONTROL __MSABI_LONG(&h00002000)
#define OLEUI_IOERR_LPSZFILEINVALID (OLEUI_ERR_STANDARDMAX + 0)
#define OLEUI_IOERR_LPSZLABELINVALID (OLEUI_ERR_STANDARDMAX + 1)
#define OLEUI_IOERR_HICONINVALID (OLEUI_ERR_STANDARDMAX + 2)
#define OLEUI_IOERR_LPFORMATETCINVALID (OLEUI_ERR_STANDARDMAX + 3)
#define OLEUI_IOERR_PPVOBJINVALID (OLEUI_ERR_STANDARDMAX + 4)
#define OLEUI_IOERR_LPIOLECLIENTSITEINVALID (OLEUI_ERR_STANDARDMAX + 5)
#define OLEUI_IOERR_LPISTORAGEINVALID (OLEUI_ERR_STANDARDMAX + 6)
#define OLEUI_IOERR_SCODEHASERROR (OLEUI_ERR_STANDARDMAX + 7)
#define OLEUI_IOERR_LPCLSIDEXCLUDEINVALID (OLEUI_ERR_STANDARDMAX + 8)
#define OLEUI_IOERR_CCHFILEINVALID (OLEUI_ERR_STANDARDMAX + 9)

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
	#define tagOLEUIPASTEENTRY tagOLEUIPASTEENTRYW
	#define OLEUIPASTEENTRY OLEUIPASTEENTRYW
	#define POLEUIPASTEENTRY POLEUIPASTEENTRYW
	#define LPOLEUIPASTEENTRY LPOLEUIPASTEENTRYW
#else
	#define tagOLEUIPASTEENTRY tagOLEUIPASTEENTRYA
	#define OLEUIPASTEENTRY OLEUIPASTEENTRYA
	#define POLEUIPASTEENTRY POLEUIPASTEENTRYA
	#define LPOLEUIPASTEENTRY LPOLEUIPASTEENTRYA
#endif

#define PS_MAXLINKTYPES 8

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
	#define tagOLEUIPASTESPECIAL tagOLEUIPASTESPECIALW
	#define OLEUIPASTESPECIAL OLEUIPASTESPECIALW
	#define POLEUIPASTESPECIAL POLEUIPASTESPECIALW
	#define LPOLEUIPASTESPECIAL LPOLEUIPASTESPECIALW
#else
	#define tagOLEUIPASTESPECIAL tagOLEUIPASTESPECIALA
	#define OLEUIPASTESPECIAL OLEUIPASTESPECIALA
	#define POLEUIPASTESPECIAL POLEUIPASTESPECIALA
	#define LPOLEUIPASTESPECIAL LPOLEUIPASTESPECIALA
#endif

declare function OleUIPasteSpecialW(byval as LPOLEUIPASTESPECIALW) as UINT
declare function OleUIPasteSpecialA(byval as LPOLEUIPASTESPECIALA) as UINT

#ifdef UNICODE
	#define OleUIPasteSpecial_ OleUIPasteSpecialW
#else
	#define OleUIPasteSpecial_ OleUIPasteSpecialA
#endif

#define PSF_SHOWHELP __MSABI_LONG(&h00000001)
#define PSF_SELECTPASTE __MSABI_LONG(&h00000002)
#define PSF_SELECTPASTELINK __MSABI_LONG(&h00000004)
#define PSF_CHECKDISPLAYASICON __MSABI_LONG(&h00000008)
#define PSF_DISABLEDISPLAYASICON __MSABI_LONG(&h00000010)
#define PSF_HIDECHANGEICON __MSABI_LONG(&h00000020)
#define PSF_STAYONCLIPBOARDCHANGE __MSABI_LONG(&h00000040)
#define PSF_NOREFRESHDATAOBJECT __MSABI_LONG(&h00000080)
#define OLEUI_IOERR_SRCDATAOBJECTINVALID (OLEUI_ERR_STANDARDMAX + 0)
#define OLEUI_IOERR_ARRPASTEENTRIESINVALID (OLEUI_ERR_STANDARDMAX + 1)
#define OLEUI_IOERR_ARRLINKTYPESINVALID (OLEUI_ERR_STANDARDMAX + 2)
#define OLEUI_PSERR_CLIPBOARDCHANGED (OLEUI_ERR_STANDARDMAX + 3)
#define OLEUI_PSERR_GETCLIPBOARDFAILED (OLEUI_ERR_STANDARDMAX + 4)

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
	#define IOleUILinkContainer IOleUILinkContainerW
	#define LPOLEUILINKCONTAINER LPOLEUILINKCONTAINERW
	#define IOleUILinkContainerVtbl IOleUILinkContainerWVtbl
#else
	#define IOleUILinkContainer IOleUILinkContainerA
	#define LPOLEUILINKCONTAINER LPOLEUILINKCONTAINERA
	#define IOleUILinkContainerVtbl IOleUILinkContainerAVtbl
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
	lpOleUILinkContainer_ as LPOLEUILINKCONTAINERW
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
	lpOleUILinkContainer_ as LPOLEUILINKCONTAINERA
end type

type OLEUIEDITLINKSA as tagOLEUIEDITLINKSA
type POLEUIEDITLINKSA as tagOLEUIEDITLINKSA ptr
type LPOLEUIEDITLINKSA as tagOLEUIEDITLINKSA ptr

#ifdef UNICODE
	#define tagOLEUIEDITLINKS tagOLEUIEDITLINKSW
	#define OLEUIEDITLINKS OLEUIEDITLINKSW
	#define POLEUIEDITLINKS POLEUIEDITLINKSW
	#define LPOLEUIEDITLINKS LPOLEUIEDITLINKSW
#else
	#define tagOLEUIEDITLINKS tagOLEUIEDITLINKSA
	#define OLEUIEDITLINKS OLEUIEDITLINKSA
	#define POLEUIEDITLINKS POLEUIEDITLINKSA
	#define LPOLEUIEDITLINKS LPOLEUIEDITLINKSA
#endif

#define OLEUI_ELERR_LINKCNTRNULL (OLEUI_ERR_STANDARDMAX + 0)
#define OLEUI_ELERR_LINKCNTRINVALID (OLEUI_ERR_STANDARDMAX + 1)

declare function OleUIEditLinksW(byval as LPOLEUIEDITLINKSW) as UINT
declare function OleUIEditLinksA(byval as LPOLEUIEDITLINKSA) as UINT

#ifdef UNICODE
	#define OleUIEditLinks_ OleUIEditLinksW
#else
	#define OleUIEditLinks_ OleUIEditLinksA
#endif

#define ELF_SHOWHELP __MSABI_LONG(&h00000001)
#define ELF_DISABLEUPDATENOW __MSABI_LONG(&h00000002)
#define ELF_DISABLEOPENSOURCE __MSABI_LONG(&h00000004)
#define ELF_DISABLECHANGESOURCE __MSABI_LONG(&h00000008)
#define ELF_DISABLECANCELLINK __MSABI_LONG(&h00000010)

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
	#define tagOLEUICHANGEICON tagOLEUICHANGEICONW
	#define OLEUICHANGEICON OLEUICHANGEICONW
	#define POLEUICHANGEICON POLEUICHANGEICONW
	#define LPOLEUICHANGEICON LPOLEUICHANGEICONW
	#define OleUIChangeIcon_ OleUIChangeIconW
#else
	#define tagOLEUICHANGEICON tagOLEUICHANGEICONA
	#define OLEUICHANGEICON OLEUICHANGEICONA
	#define POLEUICHANGEICON POLEUICHANGEICONA
	#define LPOLEUICHANGEICON LPOLEUICHANGEICONA
	#define OleUIChangeIcon_ OleUIChangeIconA
#endif

#define CIF_SHOWHELP __MSABI_LONG(&h00000001)
#define CIF_SELECTCURRENT __MSABI_LONG(&h00000002)
#define CIF_SELECTDEFAULT __MSABI_LONG(&h00000004)
#define CIF_SELECTFROMFILE __MSABI_LONG(&h00000008)
#define CIF_USEICONEXE __MSABI_LONG(&h00000010)
#define OLEUI_CIERR_MUSTHAVECLSID (OLEUI_ERR_STANDARDMAX + 0)
#define OLEUI_CIERR_MUSTHAVECURRENTMETAFILE (OLEUI_ERR_STANDARDMAX + 1)
#define OLEUI_CIERR_SZICONEXEINVALID (OLEUI_ERR_STANDARDMAX + 2)
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

declare function OleUIConvertW(byval as LPOLEUICONVERTW) as UINT
declare function OleUIConvertA(byval as LPOLEUICONVERTA) as UINT

#ifdef UNICODE
	#define tagOLEUICONVERT tagOLEUICONVERTW
	#define OLEUICONVERT OLEUICONVERTW
	#define POLEUICONVERT POLEUICONVERTW
	#define LPOLEUICONVERT LPOLEUICONVERTW
	#define OleUIConvert_ OleUIConvertW
#else
	#define tagOLEUICONVERT tagOLEUICONVERTA
	#define OLEUICONVERT OLEUICONVERTA
	#define POLEUICONVERT POLEUICONVERTA
	#define LPOLEUICONVERT LPOLEUICONVERTA
	#define OleUIConvert_ OleUIConvertA
#endif

declare function OleUICanConvertOrActivateAs(byval rClsid as const IID const ptr, byval fIsLinkedObject as WINBOOL, byval wFormat as WORD) as WINBOOL

#define CF_SHOWHELPBUTTON __MSABI_LONG(&h00000001)
#define CF_SETCONVERTDEFAULT __MSABI_LONG(&h00000002)
#define CF_SETACTIVATEDEFAULT __MSABI_LONG(&h00000004)
#define CF_SELECTCONVERTTO __MSABI_LONG(&h00000008)
#define CF_SELECTACTIVATEAS __MSABI_LONG(&h00000010)
#define CF_DISABLEDISPLAYASICON __MSABI_LONG(&h00000020)
#define CF_DISABLEACTIVATEAS __MSABI_LONG(&h00000040)
#define CF_HIDECHANGEICON __MSABI_LONG(&h00000080)
#define CF_CONVERTONLY __MSABI_LONG(&h00000100)
#define OLEUI_CTERR_CLASSIDINVALID (OLEUI_ERR_STANDARDMAX + 1)
#define OLEUI_CTERR_DVASPECTINVALID (OLEUI_ERR_STANDARDMAX + 2)
#define OLEUI_CTERR_CBFORMATINVALID (OLEUI_ERR_STANDARDMAX + 3)
#define OLEUI_CTERR_HMETAPICTINVALID (OLEUI_ERR_STANDARDMAX + 4)
#define OLEUI_CTERR_STRINGINVALID (OLEUI_ERR_STANDARDMAX + 5)

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
	#define tagOLEUIBUSY tagOLEUIBUSYW
	#define OLEUIBUSY OLEUIBUSYW
	#define POLEUIBUSY POLEUIBUSYW
	#define LPOLEUIBUSY LPOLEUIBUSYW
	#define OleUIBusy_ OleUIBusyW
#else
	#define tagOLEUIBUSY tagOLEUIBUSYA
	#define OLEUIBUSY OLEUIBUSYA
	#define POLEUIBUSY POLEUIBUSYA
	#define LPOLEUIBUSY LPOLEUIBUSYA
	#define OleUIBusy_ OleUIBusyA
#endif

#define BZ_DISABLECANCELBUTTON __MSABI_LONG(&h00000001)
#define BZ_DISABLESWITCHTOBUTTON __MSABI_LONG(&h00000002)
#define BZ_DISABLERETRYBUTTON __MSABI_LONG(&h00000004)
#define BZ_NOTRESPONDINGDIALOG __MSABI_LONG(&h00000008)
#define OLEUI_BZERR_HTASKINVALID (OLEUI_ERR_STANDARDMAX + 0)
#define OLEUI_BZ_SWITCHTOSELECTED (OLEUI_ERR_STANDARDMAX + 1)
#define OLEUI_BZ_RETRYSELECTED (OLEUI_ERR_STANDARDMAX + 2)
#define OLEUI_BZ_CALLUNBLOCKED (OLEUI_ERR_STANDARDMAX + 3)

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
	lpOleUILinkContainer_ as LPOLEUILINKCONTAINERW
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
	lpOleUILinkContainer_ as LPOLEUILINKCONTAINERA
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
	#define tagOLEUICHANGESOURCE tagOLEUICHANGESOURCEW
	#define OLEUICHANGESOURCE OLEUICHANGESOURCEW
	#define POLEUICHANGESOURCE POLEUICHANGESOURCEW
	#define LPOLEUICHANGESOURCE LPOLEUICHANGESOURCEW
	#define OleUIChangeSource_ OleUIChangeSourceW
#else
	#define tagOLEUICHANGESOURCE tagOLEUICHANGESOURCEA
	#define OLEUICHANGESOURCE OLEUICHANGESOURCEA
	#define POLEUICHANGESOURCE POLEUICHANGESOURCEA
	#define LPOLEUICHANGESOURCE LPOLEUICHANGESOURCEA
	#define OleUIChangeSource_ OleUIChangeSourceA
#endif

#define CSF_SHOWHELP __MSABI_LONG(&h00000001)
#define CSF_VALIDSOURCE __MSABI_LONG(&h00000002)
#define CSF_ONLYGETSOURCE __MSABI_LONG(&h00000004)
#define CSF_EXPLORER __MSABI_LONG(&h00000008)
#define OLEUI_CSERR_LINKCNTRNULL (OLEUI_ERR_STANDARDMAX + 0)
#define OLEUI_CSERR_LINKCNTRINVALID (OLEUI_ERR_STANDARDMAX + 1)
#define OLEUI_CSERR_FROMNOTNULL (OLEUI_ERR_STANDARDMAX + 2)
#define OLEUI_CSERR_TONOTNULL (OLEUI_ERR_STANDARDMAX + 3)
#define OLEUI_CSERR_SOURCENULL (OLEUI_ERR_STANDARDMAX + 4)
#define OLEUI_CSERR_SOURCEINVALID (OLEUI_ERR_STANDARDMAX + 5)
#define OLEUI_CSERR_SOURCEPARSERROR (OLEUI_ERR_STANDARDMAX + 6)
#define OLEUI_CSERR_SOURCEPARSEERROR (OLEUI_ERR_STANDARDMAX + 6)

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
	#define IOleUIObjInfo IOleUIObjInfoW
	#define LPOLEUIOBJINFO LPOLEUIOBJINFOW
	#define IOleUIObjInfoVtbl IOleUIObjInfoWVtbl
#else
	#define IOleUIObjInfo IOleUIObjInfoA
	#define LPOLEUIOBJINFO LPOLEUIOBJINFOA
	#define IOleUIObjInfoVtbl IOleUIObjInfoAVtbl
#endif

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
	#define IOleUILinkInfo IOleUILinkInfoW
	#define LPOLEUILINKINFO LPOLEUILINKINFOW
	#define IOleUILinkInfoVtbl IOleUILinkInfoWVtbl
#else
	#define IOleUILinkInfo IOleUILinkInfoA
	#define LPOLEUILINKINFO LPOLEUILINKINFOA
	#define IOleUILinkInfoVtbl IOleUILinkInfoAVtbl
#endif

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
	#define tagOLEUIGNRLPROPS tagOLEUIGNRLPROPSW
	#define OLEUIGNRLPROPS OLEUIGNRLPROPSW
	#define POLEUIGNRLPROPS POLEUIGNRLPROPSW
	#define LPOLEUIGNRLPROPS LPOLEUIGNRLPROPSW
#else
	#define tagOLEUIGNRLPROPS tagOLEUIGNRLPROPSA
	#define OLEUIGNRLPROPS OLEUIGNRLPROPSA
	#define POLEUIGNRLPROPS POLEUIGNRLPROPSA
	#define LPOLEUIGNRLPROPS LPOLEUIGNRLPROPSA
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
	#define tagOLEUIVIEWPROPS tagOLEUIVIEWPROPSW
	#define OLEUIVIEWPROPS OLEUIVIEWPROPSW
	#define POLEUIVIEWPROPS POLEUIVIEWPROPSW
	#define LPOLEUIVIEWPROPS LPOLEUIVIEWPROPSW
#else
	#define tagOLEUIVIEWPROPS tagOLEUIVIEWPROPSA
	#define OLEUIVIEWPROPS OLEUIVIEWPROPSA
	#define POLEUIVIEWPROPS POLEUIVIEWPROPSA
	#define LPOLEUIVIEWPROPS LPOLEUIVIEWPROPSA
#endif

#define VPF_SELECTRELATIVE __MSABI_LONG(&h00000001)
#define VPF_DISABLERELATIVE __MSABI_LONG(&h00000002)
#define VPF_DISABLESCALE __MSABI_LONG(&h00000004)

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
	#define tagOLEUILINKPROPS tagOLEUILINKPROPSW
	#define OLEUILINKPROPS OLEUILINKPROPSW
	#define POLEUILINKPROPS POLEUILINKPROPSW
	#define LPOLEUILINKPROPS LPOLEUILINKPROPSW
	#define LPPROPSHEETHEADER LPPROPSHEETHEADERW
#else
	#define tagOLEUILINKPROPS tagOLEUILINKPROPSA
	#define OLEUILINKPROPS OLEUILINKPROPSA
	#define POLEUILINKPROPS POLEUILINKPROPSA
	#define LPOLEUILINKPROPS LPOLEUILINKPROPSA
	#define LPPROPSHEETHEADER LPPROPSHEETHEADERA
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
	#define tagOLEUIOBJECTPROPS tagOLEUIOBJECTPROPSW
	#define OLEUIOBJECTPROPS OLEUIOBJECTPROPSW
	#define POLEUIOBJECTPROPS POLEUIOBJECTPROPSW
	#define LPOLEUIOBJECTPROPS LPOLEUIOBJECTPROPSW
	#define OleUIObjectProperties OleUIObjectPropertiesW
#else
	#define tagOLEUIOBJECTPROPS tagOLEUIOBJECTPROPSA
	#define OLEUIOBJECTPROPS OLEUIOBJECTPROPSA
	#define POLEUIOBJECTPROPS POLEUIOBJECTPROPSA
	#define LPOLEUIOBJECTPROPS LPOLEUIOBJECTPROPSA
	#define OleUIObjectProperties OleUIObjectPropertiesA
#endif

#define OPF_OBJECTISLINK __MSABI_LONG(&h00000001)
#define OPF_NOFILLDEFAULT __MSABI_LONG(&h00000002)
#define OPF_SHOWHELP __MSABI_LONG(&h00000004)
#define OPF_DISABLECONVERT __MSABI_LONG(&h00000008)
#define OLEUI_OPERR_SUBPROPNULL (OLEUI_ERR_STANDARDMAX + 0)
#define OLEUI_OPERR_SUBPROPINVALID (OLEUI_ERR_STANDARDMAX + 1)
#define OLEUI_OPERR_PROPSHEETNULL (OLEUI_ERR_STANDARDMAX + 2)
#define OLEUI_OPERR_PROPSHEETINVALID (OLEUI_ERR_STANDARDMAX + 3)
#define OLEUI_OPERR_SUPPROP (OLEUI_ERR_STANDARDMAX + 4)
#define OLEUI_OPERR_PROPSINVALID (OLEUI_ERR_STANDARDMAX + 5)
#define OLEUI_OPERR_PAGESINCORRECT (OLEUI_ERR_STANDARDMAX + 6)
#define OLEUI_OPERR_INVALIDPAGES (OLEUI_ERR_STANDARDMAX + 7)
#define OLEUI_OPERR_NOTSUPPORTED (OLEUI_ERR_STANDARDMAX + 8)
#define OLEUI_OPERR_DLGPROCNOTNULL (OLEUI_ERR_STANDARDMAX + 9)
#define OLEUI_OPERR_LPARAMNOTZERO (OLEUI_ERR_STANDARDMAX + 10)
#define OLEUI_GPERR_STRINGINVALID (OLEUI_ERR_STANDARDMAX + 11)
#define OLEUI_GPERR_CLASSIDINVALID (OLEUI_ERR_STANDARDMAX + 12)
#define OLEUI_GPERR_LPCLSIDEXCLUDEINVALID (OLEUI_ERR_STANDARDMAX + 13)
#define OLEUI_GPERR_CBFORMATINVALID (OLEUI_ERR_STANDARDMAX + 14)
#define OLEUI_VPERR_METAPICTINVALID (OLEUI_ERR_STANDARDMAX + 15)
#define OLEUI_VPERR_DVASPECTINVALID (OLEUI_ERR_STANDARDMAX + 16)
#define OLEUI_LPERR_LINKCNTRNULL (OLEUI_ERR_STANDARDMAX + 17)
#define OLEUI_LPERR_LINKCNTRINVALID (OLEUI_ERR_STANDARDMAX + 18)
#define OLEUI_OPERR_PROPERTYSHEET (OLEUI_ERR_STANDARDMAX + 19)
#define OLEUI_OPERR_OBJINFOINVALID (OLEUI_ERR_STANDARDMAX + 20)
#define OLEUI_OPERR_LINKINFOINVALID (OLEUI_ERR_STANDARDMAX + 21)
#define OLEUI_QUERY_GETCLASSID &hFF00
#define OLEUI_QUERY_LINKBROKEN &hFF01

declare function OleUIPromptUserW cdecl(byval nTemplate as long, byval hwndParent as HWND, ...) as long
declare function OleUIPromptUserA cdecl(byval nTemplate as long, byval hwndParent as HWND, ...) as long

#ifdef UNICODE
	#define OleUIPromptUser OleUIPromptUserW
#else
	#define OleUIPromptUser OleUIPromptUserA
#endif

declare function OleUIUpdateLinksW(byval lpOleUILinkCntr as LPOLEUILINKCONTAINERW, byval hwndParent as HWND, byval lpszTitle as LPWSTR, byval cLinks as long) as WINBOOL
declare function OleUIUpdateLinksA(byval lpOleUILinkCntr as LPOLEUILINKCONTAINERA, byval hwndParent as HWND, byval lpszTitle as LPSTR, byval cLinks as long) as WINBOOL

#ifdef UNICODE
	#define OleUIUpdateLinks OleUIUpdateLinksW
#else
	#define OleUIUpdateLinks OleUIUpdateLinksA
#endif

end extern
