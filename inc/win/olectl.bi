'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   This Software is provided under the Zope Public License (ZPL) Version 2.1.
''
''   Copyright (c) 2009, 2010 by the mingw-w64 project
''
''   See the AUTHORS file for the list of contributors to the mingw-w64 project.
''
''   This license has been certified as open source. It has also been designated
''   as GPL compatible by the Free Software Foundation (FSF).
''
''   Redistribution and use in source and binary forms, with or without
''   modification, are permitted provided that the following conditions are met:
''
''     1. Redistributions in source code must retain the accompanying copyright
''        notice, this list of conditions, and the following disclaimer.
''     2. Redistributions in binary form must reproduce the accompanying
''        copyright notice, this list of conditions, and the following disclaimer
''        in the documentation and/or other materials provided with the
''        distribution.
''     3. Names of the copyright holders must not be used to endorse or promote
''        products derived from this software without prior written permission
''        from the copyright holders.
''     4. The right to distribute this software or to use it for any purpose does
''        not give you the right to use Servicemarks (sm) or Trademarks (tm) of
''        the copyright holders.  Use of them is covered by separate agreement
''        with the copyright holders.
''     5. If any files are modified, you must cause the modified files to carry
''        prominent notices stating that you changed the files and the date of
''        any change.
''
''   Disclaimer
''
''   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS ``AS IS'' AND ANY EXPRESSED
''   OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
''   OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
''   EVENT SHALL THE COPYRIGHT HOLDERS BE LIABLE FOR ANY DIRECT, INDIRECT,
''   INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
''   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, 
''   OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
''   LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
''   NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
''   EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "oleaut32"

#include once "ocidl.bi"

extern "Windows"

#define _OLECTL_H_
extern IID_IPropertyFrame as const GUID
extern CLSID_CFontPropPage as const GUID
extern CLSID_CColorPropPage as const GUID
extern CLSID_CPicturePropPage as const GUID
extern CLSID_PersistPropset as const GUID
extern CLSID_ConvertVBX as const GUID
extern CLSID_StdFont as const GUID
extern CLSID_StdPicture as const GUID
extern GUID_HIMETRIC as const GUID
extern GUID_COLOR as const GUID
extern GUID_XPOSPIXEL as const GUID
extern GUID_YPOSPIXEL as const GUID
extern GUID_XSIZEPIXEL as const GUID
extern GUID_YSIZEPIXEL as const GUID
extern GUID_XPOS as const GUID
extern GUID_YPOS as const GUID
extern GUID_XSIZE as const GUID
extern GUID_YSIZE as const GUID
extern GUID_OPTIONVALUEEXCLUSIVE as const GUID
extern GUID_CHECKVALUEEXCLUSIVE as const GUID
extern GUID_FONTNAME as const GUID
extern GUID_FONTSIZE as const GUID
extern GUID_FONTBOLD as const GUID
extern GUID_FONTITALIC as const GUID
extern GUID_FONTUNDERSCORE as const GUID
extern GUID_FONTSTRIKETHROUGH as const GUID
extern GUID_HANDLE as const GUID

type tagOCPFIPARAMS
	cbStructSize as ULONG
	hWndOwner as HWND
	x as long
	y as long
	lpszCaption as LPCOLESTR
	cObjects as ULONG
	lplpUnk as LPUNKNOWN ptr
	cPages as ULONG
	lpPages as CLSID ptr
	lcid as LCID
	dispidInitialProperty as DISPID
end type

type OCPFIPARAMS as tagOCPFIPARAMS
type LPOCPFIPARAMS as tagOCPFIPARAMS ptr
#define FONTSIZE_(n) (n##0000, 0)

type tagFONTDESC
	cbSizeofstruct as UINT
	lpstrName as LPOLESTR
	cySize as CY
	sWeight as SHORT
	sCharset as SHORT
	fItalic as WINBOOL
	fUnderline as WINBOOL
	fStrikethrough as WINBOOL
end type

type FONTDESC as tagFONTDESC
type LPFONTDESC as tagFONTDESC ptr
const PICTYPE_UNINITIALIZED = -1
const PICTYPE_NONE = 0
const PICTYPE_BITMAP = 1
const PICTYPE_METAFILE = 2
const PICTYPE_ICON = 3
const PICTYPE_ENHMETAFILE = 4

type tagPICTDESC_bmp
	hbitmap as HBITMAP
	hpal as HPALETTE
end type

type tagPICTDESC_wmf
	hmeta as HMETAFILE
	xExt as long
	yExt as long
end type

type tagPICTDESC_icon
	hicon as HICON
end type

type tagPICTDESC_emf
	hemf as HENHMETAFILE
end type

type tagPICTDESC
	cbSizeofstruct as UINT
	picType as UINT

	union
		bmp as tagPICTDESC_bmp
		wmf as tagPICTDESC_wmf
		icon as tagPICTDESC_icon
		emf as tagPICTDESC_emf
	end union
end type

type PICTDESC as tagPICTDESC
type LPPICTDESC as tagPICTDESC ptr
type OLE_XPOS_PIXELS as long
type OLE_YPOS_PIXELS as long
type OLE_XSIZE_PIXELS as long
type OLE_YSIZE_PIXELS as long
type OLE_XPOS_CONTAINER as single
type OLE_YPOS_CONTAINER as single
type OLE_XSIZE_CONTAINER as single
type OLE_YSIZE_CONTAINER as single

type OLE_TRISTATE as long
enum
	triUnchecked = 0
	triChecked = 1
	triGray = 2
end enum

type OLE_OPTEXCLUSIVE as VARIANT_BOOL
type OLE_CANCELBOOL as VARIANT_BOOL
type OLE_ENABLEDEFAULTBOOL as VARIANT_BOOL

#define STD_CTL_SCODE(n) MAKE_SCODE(SEVERITY_ERROR, FACILITY_CONTROL, n)
#define CTL_E_ILLEGALFUNCTIONCALL STD_CTL_SCODE(5)
#define CTL_E_OVERFLOW STD_CTL_SCODE(6)
#define CTL_E_OUTOFMEMORY STD_CTL_SCODE(7)
#define CTL_E_DIVISIONBYZERO STD_CTL_SCODE(11)
#define CTL_E_OUTOFSTRINGSPACE STD_CTL_SCODE(14)
#define CTL_E_OUTOFSTACKSPACE STD_CTL_SCODE(28)
#define CTL_E_BADFILENAMEORNUMBER STD_CTL_SCODE(52)
#define CTL_E_FILENOTFOUND STD_CTL_SCODE(53)
#define CTL_E_BADFILEMODE STD_CTL_SCODE(54)
#define CTL_E_FILEALREADYOPEN STD_CTL_SCODE(55)
#define CTL_E_DEVICEIOERROR STD_CTL_SCODE(57)
#define CTL_E_FILEALREADYEXISTS STD_CTL_SCODE(58)
#define CTL_E_BADRECORDLENGTH STD_CTL_SCODE(59)
#define CTL_E_DISKFULL STD_CTL_SCODE(61)
#define CTL_E_BADRECORDNUMBER STD_CTL_SCODE(63)
#define CTL_E_BADFILENAME STD_CTL_SCODE(64)
#define CTL_E_TOOMANYFILES STD_CTL_SCODE(67)
#define CTL_E_DEVICEUNAVAILABLE STD_CTL_SCODE(68)
#define CTL_E_PERMISSIONDENIED STD_CTL_SCODE(70)
#define CTL_E_DISKNOTREADY STD_CTL_SCODE(71)
#define CTL_E_PATHFILEACCESSERROR STD_CTL_SCODE(75)
#define CTL_E_PATHNOTFOUND STD_CTL_SCODE(76)
#define CTL_E_INVALIDPATTERNSTRING STD_CTL_SCODE(93)
#define CTL_E_INVALIDUSEOFNULL STD_CTL_SCODE(94)
#define CTL_E_INVALIDFILEFORMAT STD_CTL_SCODE(321)
#define CTL_E_INVALIDPROPERTYVALUE STD_CTL_SCODE(380)
#define CTL_E_INVALIDPROPERTYARRAYINDEX STD_CTL_SCODE(381)
#define CTL_E_SETNOTSUPPORTEDATRUNTIME STD_CTL_SCODE(382)
#define CTL_E_SETNOTSUPPORTED STD_CTL_SCODE(383)
#define CTL_E_NEEDPROPERTYARRAYINDEX STD_CTL_SCODE(385)
#define CTL_E_SETNOTPERMITTED STD_CTL_SCODE(387)
#define CTL_E_GETNOTSUPPORTEDATRUNTIME STD_CTL_SCODE(393)
#define CTL_E_GETNOTSUPPORTED STD_CTL_SCODE(394)
#define CTL_E_PROPERTYNOTFOUND STD_CTL_SCODE(422)
#define CTL_E_INVALIDCLIPBOARDFORMAT STD_CTL_SCODE(460)
#define CTL_E_INVALIDPICTURE STD_CTL_SCODE(481)
#define CTL_E_PRINTERERROR STD_CTL_SCODE(482)
#define CTL_E_CANTSAVEFILETOTEMP STD_CTL_SCODE(735)
#define CTL_E_SEARCHTEXTNOTFOUND STD_CTL_SCODE(744)
#define CTL_E_REPLACEMENTSTOOLONG STD_CTL_SCODE(746)
#define CUSTOM_CTL_SCODE(n) MAKE_SCODE(SEVERITY_ERROR, FACILITY_CONTROL, n)
#define CTL_E_CUSTOM_FIRST CUSTOM_CTL_SCODE(600)
#define CONNECT_E_FIRST MAKE_SCODE(SEVERITY_ERROR, FACILITY_ITF, &h0200)
#define CONNECT_E_LAST MAKE_SCODE(SEVERITY_ERROR, FACILITY_ITF, &h020F)
#define CONNECT_S_FIRST MAKE_SCODE(SEVERITY_SUCCESS, FACILITY_ITF, &h0200)
#define CONNECT_S_LAST MAKE_SCODE(SEVERITY_SUCCESS, FACILITY_ITF, &h020F)
#define CONNECT_E_NOCONNECTION (CONNECT_E_FIRST + 0)
#define CONNECT_E_ADVISELIMIT (CONNECT_E_FIRST + 1)
#define CONNECT_E_CANNOTCONNECT (CONNECT_E_FIRST + 2)
#define CONNECT_E_OVERRIDDEN (CONNECT_E_FIRST + 3)
#define SELFREG_E_FIRST MAKE_SCODE(SEVERITY_ERROR, FACILITY_ITF, &h0200)
#define SELFREG_E_LAST MAKE_SCODE(SEVERITY_ERROR, FACILITY_ITF, &h020F)
#define SELFREG_S_FIRST MAKE_SCODE(SEVERITY_SUCCESS, FACILITY_ITF, &h0200)
#define SELFREG_S_LAST MAKE_SCODE(SEVERITY_SUCCESS, FACILITY_ITF, &h020F)
#define SELFREG_E_TYPELIB (SELFREG_E_FIRST + 0)
#define SELFREG_E_CLASS (SELFREG_E_FIRST + 1)
#define PERPROP_E_FIRST MAKE_SCODE(SEVERITY_ERROR, FACILITY_ITF, &h0200)
#define PERPROP_E_LAST MAKE_SCODE(SEVERITY_ERROR, FACILITY_ITF, &h020F)
#define PERPROP_S_FIRST MAKE_SCODE(SEVERITY_SUCCESS, FACILITY_ITF, &h0200)
#define PERPROP_S_LAST MAKE_SCODE(SEVERITY_SUCCESS, FACILITY_ITF, &h020F)
#define PERPROP_E_NOPAGEAVAILABLE (PERPROP_E_FIRST + 0)
const OLEIVERB_PROPERTIES = -7
const VT_STREAMED_PROPSET = 73
const VT_STORED_PROPSET = 74
const VT_BLOB_PROPSET = 75
const VT_VERBOSE_ENUM = 76
const VT_COLOR = VT_I4
const VT_XPOS_PIXELS = VT_I4
const VT_YPOS_PIXELS = VT_I4
const VT_XSIZE_PIXELS = VT_I4
const VT_YSIZE_PIXELS = VT_I4
const VT_XPOS_HIMETRIC = VT_I4
const VT_YPOS_HIMETRIC = VT_I4
const VT_XSIZE_HIMETRIC = VT_I4
const VT_YSIZE_HIMETRIC = VT_I4
const VT_TRISTATE = VT_I2
const VT_OPTEXCLUSIVE = VT_BOOL
const VT_FONT = VT_DISPATCH
const VT_PICTURE = VT_DISPATCH
const VT_HANDLE = VT_I4
const OCM__BASE = WM_USER + &h1c00
const OCM_COMMAND = OCM__BASE + WM_COMMAND
const OCM_CTLCOLORBTN = OCM__BASE + WM_CTLCOLORBTN
const OCM_CTLCOLOREDIT = OCM__BASE + WM_CTLCOLOREDIT
const OCM_CTLCOLORDLG = OCM__BASE + WM_CTLCOLORDLG
const OCM_CTLCOLORLISTBOX = OCM__BASE + WM_CTLCOLORLISTBOX
const OCM_CTLCOLORMSGBOX = OCM__BASE + WM_CTLCOLORMSGBOX
const OCM_CTLCOLORSCROLLBAR = OCM__BASE + WM_CTLCOLORSCROLLBAR
const OCM_CTLCOLORSTATIC = OCM__BASE + WM_CTLCOLORSTATIC
const OCM_DRAWITEM = OCM__BASE + WM_DRAWITEM
const OCM_MEASUREITEM = OCM__BASE + WM_MEASUREITEM
const OCM_DELETEITEM = OCM__BASE + WM_DELETEITEM
const OCM_VKEYTOITEM = OCM__BASE + WM_VKEYTOITEM
const OCM_CHARTOITEM = OCM__BASE + WM_CHARTOITEM
const OCM_COMPAREITEM = OCM__BASE + WM_COMPAREITEM
const OCM_HSCROLL = OCM__BASE + WM_HSCROLL
const OCM_VSCROLL = OCM__BASE + WM_VSCROLL
const OCM_PARENTNOTIFY = OCM__BASE + WM_PARENTNOTIFY
const OCM_NOTIFY = OCM__BASE + WM_NOTIFY

declare function DllRegisterServer() as HRESULT
declare function DllUnregisterServer() as HRESULT
declare function OleCreatePropertyFrame(byval hwndOwner as HWND, byval x as UINT, byval y as UINT, byval lpszCaption as LPCOLESTR, byval cObjects as ULONG, byval ppUnk as LPUNKNOWN ptr, byval cPages as ULONG, byval pPageClsID as LPCLSID, byval lcid as LCID, byval dwReserved as DWORD, byval pvReserved as LPVOID) as HRESULT
declare function OleCreatePropertyFrameIndirect(byval lpParams as LPOCPFIPARAMS) as HRESULT
declare function OleTranslateColor(byval clr as OLE_COLOR, byval hpal as HPALETTE, byval lpcolorref as COLORREF ptr) as HRESULT
declare function OleCreateFontIndirect(byval lpFontDesc as LPFONTDESC, byval riid as const IID const ptr, byval lplpvObj as LPVOID ptr) as HRESULT
declare function OleCreatePictureIndirect(byval lpPictDesc as LPPICTDESC, byval riid as const IID const ptr, byval fOwn as WINBOOL, byval lplpvObj as LPVOID ptr) as HRESULT
declare function OleLoadPicture(byval lpstream as LPSTREAM, byval lSize as LONG, byval fRunmode as WINBOOL, byval riid as const IID const ptr, byval lplpvObj as LPVOID ptr) as HRESULT
declare function OleLoadPictureEx(byval lpstream as LPSTREAM, byval lSize as LONG, byval fRunmode as WINBOOL, byval riid as const IID const ptr, byval xSizeDesired as DWORD, byval ySizeDesired as DWORD, byval dwFlags as DWORD, byval lplpvObj as LPVOID ptr) as HRESULT
declare function OleLoadPicturePath(byval szURLorPath as LPOLESTR, byval punkCaller as LPUNKNOWN, byval dwReserved as DWORD, byval clrReserved as OLE_COLOR, byval riid as const IID const ptr, byval ppvRet as LPVOID ptr) as HRESULT
declare function OleLoadPictureFile(byval varFileName as VARIANT, byval lplpdispPicture as LPDISPATCH ptr) as HRESULT
declare function OleLoadPictureFileEx(byval varFileName as VARIANT, byval xSizeDesired as DWORD, byval ySizeDesired as DWORD, byval dwFlags as DWORD, byval lplpdispPicture as LPDISPATCH ptr) as HRESULT
declare function OleSavePictureFile(byval lpdispPicture as LPDISPATCH, byval bstrFileName as BSTR) as HRESULT
declare function OleIconToCursor(byval hinstExe as HINSTANCE, byval hIcon as HICON) as HCURSOR

const LP_DEFAULT = &h00
const LP_MONOCHROME = &h01
const LP_VGACOLOR = &h02
const LP_COLOR = &h04
const DISPID_AUTOSIZE = -500
const DISPID_BACKCOLOR = -501
const DISPID_BACKSTYLE = -502
const DISPID_BORDERCOLOR = -503
const DISPID_BORDERSTYLE = -504
const DISPID_BORDERWIDTH = -505
const DISPID_DRAWMODE = -507
const DISPID_DRAWSTYLE = -508
const DISPID_DRAWWIDTH = -509
const DISPID_FILLCOLOR = -510
const DISPID_FILLSTYLE = -511
const DISPID_FONT = -512
const DISPID_FORECOLOR = -513
const DISPID_ENABLED = -514
const DISPID_HWND = -515
const DISPID_TABSTOP = -516
const DISPID_TEXT = -517
const DISPID_CAPTION = -518
const DISPID_BORDERVISIBLE = -519
const DISPID_APPEARANCE = -520
const DISPID_MOUSEPOINTER = -521
const DISPID_MOUSEICON = -522
const DISPID_PICTURE = -523
const DISPID_VALID = -524
const DISPID_READYSTATE = -525
const DISPID_LISTINDEX = -526
const DISPID_SELECTED = -527
const DISPID_LIST = -528
const DISPID_COLUMN = -529
const DISPID_LISTCOUNT = -531
const DISPID_MULTISELECT = -532
const DISPID_MAXLENGTH = -533
const DISPID_PASSWORDCHAR = -534
const DISPID_SCROLLBARS = -535
const DISPID_WORDWRAP = -536
const DISPID_MULTILINE = -537
const DISPID_NUMBEROFROWS = -538
const DISPID_NUMBEROFCOLUMNS = -539
const DISPID_DISPLAYSTYLE = -540
const DISPID_GROUPNAME = -541
const DISPID_IMEMODE = -542
const DISPID_ACCELERATOR = -543
const DISPID_ENTERKEYBEHAVIOR = -544
const DISPID_TABKEYBEHAVIOR = -545
const DISPID_SELTEXT = -546
const DISPID_SELSTART = -547
const DISPID_SELLENGTH = -548
const DISPID_REFRESH = -550
const DISPID_DOCLICK = -551
const DISPID_ABOUTBOX = -552
const DISPID_ADDITEM = -553
const DISPID_CLEAR = -554
const DISPID_REMOVEITEM = -555
const DISPID_CLICK = -600
const DISPID_DBLCLICK = -601
const DISPID_KEYDOWN = -602
const DISPID_KEYPRESS = -603
const DISPID_KEYUP = -604
const DISPID_MOUSEDOWN = -605
const DISPID_MOUSEMOVE = -606
const DISPID_MOUSEUP = -607
const DISPID_ERROREVENT = -608
const DISPID_READYSTATECHANGE = -609
const DISPID_CLICK_VALUE = -610
const DISPID_RIGHTTOLEFT = -611
const DISPID_TOPTOBOTTOM = -612
const DISPID_THIS = -613
const DISPID_AMBIENT_BACKCOLOR = -701
const DISPID_AMBIENT_DISPLAYNAME = -702
const DISPID_AMBIENT_FONT = -703
const DISPID_AMBIENT_FORECOLOR = -704
const DISPID_AMBIENT_LOCALEID = -705
const DISPID_AMBIENT_MESSAGEREFLECT = -706
const DISPID_AMBIENT_SCALEUNITS = -707
const DISPID_AMBIENT_TEXTALIGN = -708
const DISPID_AMBIENT_USERMODE = -709
const DISPID_AMBIENT_UIDEAD = -710
const DISPID_AMBIENT_SHOWGRABHANDLES = -711
const DISPID_AMBIENT_SHOWHATCHING = -712
const DISPID_AMBIENT_DISPLAYASDEFAULT = -713
const DISPID_AMBIENT_SUPPORTSMNEMONICS = -714
const DISPID_AMBIENT_AUTOCLIP = -715
const DISPID_AMBIENT_APPEARANCE = -716
const DISPID_AMBIENT_CODEPAGE = -725
const DISPID_AMBIENT_PALETTE = -726
const DISPID_AMBIENT_CHARSET = -727
const DISPID_AMBIENT_TRANSFERPRIORITY = -728
const DISPID_AMBIENT_RIGHTTOLEFT = -732
const DISPID_AMBIENT_TOPTOBOTTOM = -733
const DISPID_Name = -800
const DISPID_Delete = -801
const DISPID_Object = -802
const DISPID_Parent = -803
const DISPID_FONT_NAME = 0
const DISPID_FONT_SIZE = 2
const DISPID_FONT_BOLD = 3
const DISPID_FONT_ITALIC = 4
const DISPID_FONT_UNDER = 5
const DISPID_FONT_STRIKE = 6
const DISPID_FONT_WEIGHT = 7
const DISPID_FONT_CHARSET = 8
const DISPID_FONT_CHANGED = 9
const DISPID_PICT_HANDLE = 0
const DISPID_PICT_HPAL = 2
const DISPID_PICT_TYPE = 3
const DISPID_PICT_WIDTH = 4
const DISPID_PICT_HEIGHT = 5
const DISPID_PICT_RENDER = 6

end extern
