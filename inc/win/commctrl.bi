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

#inclib "comctl32"

#include once "winapifamily.bi"
#include once "_mingw_unicode.bi"
#include once "prsht.bi"
#include once "rpc.bi"
#include once "rpcndr.bi"
#include once "wtypesbase.bi"
#include once "unknwnbase.bi"
#include once "objidlbase.bi"

extern "Windows"

#define _INC_COMMCTRL
declare sub InitCommonControls()

type tagINITCOMMONCONTROLSEX
	dwSize as DWORD
	dwICC as DWORD
end type

type INITCOMMONCONTROLSEX as tagINITCOMMONCONTROLSEX
type LPINITCOMMONCONTROLSEX as tagINITCOMMONCONTROLSEX ptr
const ICC_LISTVIEW_CLASSES = &h1
const ICC_TREEVIEW_CLASSES = &h2
const ICC_BAR_CLASSES = &h4
const ICC_TAB_CLASSES = &h8
const ICC_UPDOWN_CLASS = &h10
const ICC_PROGRESS_CLASS = &h20
const ICC_HOTKEY_CLASS = &h40
const ICC_ANIMATE_CLASS = &h80
const ICC_WIN95_CLASSES = &hff
const ICC_DATE_CLASSES = &h100
const ICC_USEREX_CLASSES = &h200
const ICC_COOL_CLASSES = &h400
const ICC_INTERNET_CLASSES = &h800
const ICC_PAGESCROLLER_CLASS = &h1000
const ICC_NATIVEFNTCTL_CLASS = &h2000
const ICC_STANDARD_CLASSES = &h4000
const ICC_LINK_CLASS = &h8000
declare function InitCommonControlsEx(byval as const INITCOMMONCONTROLSEX ptr) as WINBOOL
const ODT_HEADER = 100
const ODT_TAB = 101
const ODT_LISTVIEW = 102
const LVM_FIRST = &h1000
const TV_FIRST = &h1100
const HDM_FIRST = &h1200
const TCM_FIRST = &h1300
const PGM_FIRST = &h1400
const ECM_FIRST = &h1500
const BCM_FIRST = &h1600
const CBM_FIRST = &h1700
const CCM_FIRST = &h2000
const CCM_LAST = CCM_FIRST + &h200
const CCM_SETBKCOLOR = CCM_FIRST + 1
const CCM_SETCOLORSCHEME = CCM_FIRST + 2
const CCM_GETCOLORSCHEME = CCM_FIRST + 3
const CCM_GETDROPTARGET = CCM_FIRST + 4
const CCM_SETUNICODEFORMAT = CCM_FIRST + 5
const CCM_GETUNICODEFORMAT = CCM_FIRST + 6
const CCM_SETVERSION = CCM_FIRST + &h7
const CCM_GETVERSION = CCM_FIRST + &h8
const CCM_SETNOTIFYWINDOW = CCM_FIRST + &h9
const CCM_SETWINDOWTHEME = CCM_FIRST + &hb
const CCM_DPISCALE = CCM_FIRST + &hc
const COMCTL32_VERSION = 6

type tagCOLORSCHEME
	dwSize as DWORD
	clrBtnHighlight as COLORREF
	clrBtnShadow as COLORREF
end type

type COLORSCHEME as tagCOLORSCHEME
type LPCOLORSCHEME as tagCOLORSCHEME ptr
const INFOTIPSIZE = 1024
#define HANDLE_WM_NOTIFY(hwnd, wParam, lParam, fn) fn((hwnd), clng(wParam), cptr(NMHDR ptr, (lParam)))
#define FORWARD_WM_NOTIFY(hwnd, idFrom, pnmhdr, fn) cast(LRESULT, fn((hwnd), WM_NOTIFY, cast(WPARAM, clng(idFrom)), cast(LPARAM, cptr(NMHDR ptr, (pnmhdr)))))
#define NM_OUTOFMEMORY culng(NM_FIRST - 1)
#define NM_CLICK culng(NM_FIRST - 2)
#define NM_DBLCLK culng(NM_FIRST - 3)
#define NM_RETURN culng(NM_FIRST - 4)
#define NM_RCLICK culng(NM_FIRST - 5)
#define NM_RDBLCLK culng(NM_FIRST - 6)
#define NM_SETFOCUS culng(NM_FIRST - 7)
#define NM_KILLFOCUS culng(NM_FIRST - 8)
#define NM_CUSTOMDRAW culng(NM_FIRST - 12)
#define NM_HOVER culng(NM_FIRST - 13)
#define NM_NCHITTEST culng(NM_FIRST - 14)
#define NM_KEYDOWN culng(NM_FIRST - 15)
#define NM_RELEASEDCAPTURE culng(NM_FIRST - 16)
#define NM_SETCURSOR culng(NM_FIRST - 17)
#define NM_CHAR culng(NM_FIRST - 18)
#define NM_TOOLTIPSCREATED culng(NM_FIRST - 19)
#define NM_LDOWN culng(NM_FIRST - 20)
#define NM_RDOWN culng(NM_FIRST - 21)
#define NM_THEMECHANGED culng(NM_FIRST - 22)

#if _WIN32_WINNT >= &h0600
	#define NM_FONTCHANGED culng(NM_FIRST - 23)
	#define NM_CUSTOMTEXT culng(NM_FIRST - 24)
	#define NM_TVSTATEIMAGECHANGING culng(NM_FIRST - 24)
#endif

type tagNMTOOLTIPSCREATED
	hdr as NMHDR
	hwndToolTips as HWND
end type

type NMTOOLTIPSCREATED as tagNMTOOLTIPSCREATED
type LPNMTOOLTIPSCREATED as tagNMTOOLTIPSCREATED ptr

type tagNMMOUSE
	hdr as NMHDR
	dwItemSpec as DWORD_PTR
	dwItemData as DWORD_PTR
	pt as POINT
	dwHitInfo as LPARAM
end type

type NMMOUSE as tagNMMOUSE
type LPNMMOUSE as tagNMMOUSE ptr
type NMCLICK as NMMOUSE
type LPNMCLICK as LPNMMOUSE

type tagNMOBJECTNOTIFY
	hdr as NMHDR
	iItem as long
	piid as const IID ptr
	pObject as any ptr
	hResult as HRESULT
	dwFlags as DWORD
end type

type NMOBJECTNOTIFY as tagNMOBJECTNOTIFY
type LPNMOBJECTNOTIFY as tagNMOBJECTNOTIFY ptr

type tagNMKEY
	hdr as NMHDR
	nVKey as UINT
	uFlags as UINT
end type

type NMKEY as tagNMKEY
type LPNMKEY as tagNMKEY ptr

type tagNMCHAR
	hdr as NMHDR
	ch as UINT
	dwItemPrev as DWORD
	dwItemNext as DWORD
end type

type NMCHAR as tagNMCHAR
type LPNMCHAR as tagNMCHAR ptr

#if _WIN32_WINNT >= &h0501
	type tagNMCUSTOMTEXT
		hdr as NMHDR
		hDC as HDC
		lpString as LPCWSTR
		nCount as long
		lpRect as LPRECT
		uFormat as UINT
		fLink as WINBOOL
	end type

	type NMCUSTOMTEXT as tagNMCUSTOMTEXT
	type LPNMCUSTOMTEXT as tagNMCUSTOMTEXT ptr
#endif

const NM_FIRST = culng(0u - 0u)
const NM_LAST = culng(0u - 99u)
const LVN_FIRST = culng(0u - 100u)
const LVN_LAST = culng(0u - 199u)
const HDN_FIRST = culng(0u - 300u)
const HDN_LAST = culng(0u - 399u)
const TVN_FIRST = culng(0u - 400u)
const TVN_LAST = culng(0u - 499u)
const TTN_FIRST = culng(0u - 520u)
const TTN_LAST = culng(0u - 549u)
const TCN_FIRST = culng(0u - 550u)
const TCN_LAST = culng(0u - 580u)
const TBN_FIRST = culng(0u - 700u)
const TBN_LAST = culng(0u - 720u)
const UDN_FIRST = culng(0u - 721)
const UDN_LAST = culng(0u - 729u)
const DTN_FIRST = culng(0u - 740u)
const DTN_LAST = culng(0u - 745u)
const MCN_FIRST = culng(0u - 746u)
const MCN_LAST = culng(0u - 752u)
const DTN_FIRST2 = culng(0u - 753u)
const DTN_LAST2 = culng(0u - 799u)
const CBEN_FIRST = culng(0u - 800u)
const CBEN_LAST = culng(0u - 830u)
const RBN_FIRST = culng(0u - 831u)
const RBN_LAST = culng(0u - 859u)
const IPN_FIRST = culng(0u - 860u)
const IPN_LAST = culng(0u - 879u)
const SBN_FIRST = culng(0u - 880u)
const SBN_LAST = culng(0u - 899u)
const PGN_FIRST = culng(0u - 900u)
const PGN_LAST = culng(0u - 950u)
const WMN_FIRST = culng(0u - 1000u)
const WMN_LAST = culng(0u - 1200u)
const BCN_FIRST = culng(0u - 1250u)
const BCN_LAST = culng(0u - 1350u)

#if _WIN32_WINNT >= &h0600
	const TRBN_FIRST = culng(0u - 1501u)
	const TRBN_LAST = culng(0u - 1519u)
#endif

const MSGF_COMMCTRL_BEGINDRAG = &h4200
const MSGF_COMMCTRL_SIZEHEADER = &h4201
const MSGF_COMMCTRL_DRAGSELECT = &h4202
const MSGF_COMMCTRL_TOOLBARCUST = &h4203
const CDRF_DODEFAULT = &h0
const CDRF_NEWFONT = &h2
const CDRF_SKIPDEFAULT = &h4
const CDRF_DOERASE = &h8
const CDRF_SKIPPOSTPAINT = &h100
const CDRF_NOTIFYPOSTPAINT = &h10
const CDRF_NOTIFYITEMDRAW = &h20
const CDRF_NOTIFYSUBITEMDRAW = &h20
const CDRF_NOTIFYPOSTERASE = &h40
const CDDS_PREPAINT = &h1
const CDDS_POSTPAINT = &h2
const CDDS_PREERASE = &h3
const CDDS_POSTERASE = &h4
const CDDS_ITEM = &h10000
const CDDS_ITEMPREPAINT = CDDS_ITEM or CDDS_PREPAINT
const CDDS_ITEMPOSTPAINT = CDDS_ITEM or CDDS_POSTPAINT
const CDDS_ITEMPREERASE = CDDS_ITEM or CDDS_PREERASE
const CDDS_ITEMPOSTERASE = CDDS_ITEM or CDDS_POSTERASE
const CDDS_SUBITEM = &h20000
const CDIS_SELECTED = &h1
const CDIS_GRAYED = &h2
const CDIS_DISABLED = &h4
const CDIS_CHECKED = &h8
const CDIS_FOCUS = &h10
const CDIS_DEFAULT = &h20
const CDIS_HOT = &h40
const CDIS_MARKED = &h80
const CDIS_INDETERMINATE = &h100
const CDIS_SHOWKEYBOARDCUES = &h200

#if _WIN32_WINNT >= &h0600
	const CDIS_NEARHOT = &h0400
	const CDIS_OTHERSIDEHOT = &h0800
	const CDIS_DROPHILITED = &h1000
#endif

type tagNMCUSTOMDRAWINFO
	hdr as NMHDR
	dwDrawStage as DWORD
	hdc as HDC
	rc as RECT
	dwItemSpec as DWORD_PTR
	uItemState as UINT
	lItemlParam as LPARAM
end type

type NMCUSTOMDRAW as tagNMCUSTOMDRAWINFO
type LPNMCUSTOMDRAW as tagNMCUSTOMDRAWINFO ptr

type tagNMTTCUSTOMDRAW
	nmcd as NMCUSTOMDRAW
	uDrawFlags as UINT
end type

type NMTTCUSTOMDRAW as tagNMTTCUSTOMDRAW
type LPNMTTCUSTOMDRAW as tagNMTTCUSTOMDRAW ptr

type tagNMCUSTOMSPLITRECTINFO
	hdr as NMHDR
	rcClient as RECT
	rcButton as RECT
	rcSplit as RECT
end type

type NMCUSTOMSPLITRECTINFO as tagNMCUSTOMSPLITRECTINFO
type LPNMCUSTOMSPLITRECTINFO as tagNMCUSTOMSPLITRECTINFO ptr
const NM_GETCUSTOMSPLITRECT = culng(BCN_FIRST + &h0003)
const CLR_NONE = &hffffffff
const CLR_DEFAULT = &hff000000
type HIMAGELIST as _IMAGELIST ptr

type _IMAGELISTDRAWPARAMS
	cbSize as DWORD
	himl as HIMAGELIST
	i as long
	hdcDst as HDC
	x as long
	y as long
	cx as long
	cy as long
	xBitmap as long
	yBitmap as long
	rgbBk as COLORREF
	rgbFg as COLORREF
	fStyle as UINT
	dwRop as DWORD
	fState as DWORD
	Frame as DWORD
	crEffect as COLORREF
end type

type IMAGELISTDRAWPARAMS as _IMAGELISTDRAWPARAMS
type LPIMAGELISTDRAWPARAMS as _IMAGELISTDRAWPARAMS ptr
#define IMAGELISTDRAWPARAMS_V3_SIZE CCSIZEOF_STRUCT(IMAGELISTDRAWPARAMS, dwRop)
const ILC_MASK = &h1
const ILC_COLOR = &h0
const ILC_COLORDDB = &hfe
const ILC_COLOR4 = &h4
const ILC_COLOR8 = &h8
const ILC_COLOR16 = &h10
const ILC_COLOR24 = &h18
const ILC_COLOR32 = &h20
const ILC_PALETTE = &h800
const ILC_MIRROR = &h2000
const ILC_PERITEMMIRROR = &h8000

#if _WIN32_WINNT >= &h0600
	const ILC_ORIGINALSIZE = &h00010000
	const ILC_HIGHQUALITYSCALE = &h00020000
#endif

declare function ImageList_Create(byval cx as long, byval cy as long, byval flags as UINT, byval cInitial as long, byval cGrow as long) as HIMAGELIST
declare function ImageList_Destroy(byval himl as HIMAGELIST) as WINBOOL
declare function ImageList_GetImageCount(byval himl as HIMAGELIST) as long
declare function ImageList_SetImageCount(byval himl as HIMAGELIST, byval uNewCount as UINT) as WINBOOL
declare function ImageList_Add(byval himl as HIMAGELIST, byval hbmImage as HBITMAP, byval hbmMask as HBITMAP) as long
declare function ImageList_ReplaceIcon(byval himl as HIMAGELIST, byval i as long, byval hicon as HICON) as long
declare function ImageList_SetBkColor(byval himl as HIMAGELIST, byval clrBk as COLORREF) as COLORREF
declare function ImageList_GetBkColor(byval himl as HIMAGELIST) as COLORREF
declare function ImageList_SetOverlayImage(byval himl as HIMAGELIST, byval iImage as long, byval iOverlay as long) as WINBOOL

#define ImageList_AddIcon(himl, hicon) ImageList_ReplaceIcon(himl, -1, hicon)
const ILD_NORMAL = &h0
const ILD_TRANSPARENT = &h1
const ILD_MASK = &h10
const ILD_IMAGE = &h20
const ILD_ROP = &h40
const ILD_BLEND25 = &h2
const ILD_BLEND50 = &h4
const ILD_OVERLAYMASK = &hf00
#define INDEXTOOVERLAYMASK(i) ((i) shl 8)
const ILD_PRESERVEALPHA = &h1000
const ILD_SCALE = &h2000
const ILD_DPISCALE = &h4000

#if _WIN32_WINNT >= &h0600
	const ILD_ASYNC = &h8000
#endif

const ILD_SELECTED = ILD_BLEND50
const ILD_FOCUS = ILD_BLEND25
const ILD_BLEND = ILD_BLEND50
const CLR_HILIGHT = CLR_DEFAULT
const ILS_NORMAL = &h0
const ILS_GLOW = &h1
const ILS_SHADOW = &h2
const ILS_SATURATE = &h4
const ILS_ALPHA = &h8

#if _WIN32_WINNT >= &h0600
	const ILGT_NORMAL = &h0
	const ILGT_ASYNC = &h1
	const HBITMAP_CALLBACK = cast(HBITMAP, -1)
#endif

declare function ImageList_Draw(byval himl as HIMAGELIST, byval i as long, byval hdcDst as HDC, byval x as long, byval y as long, byval fStyle as UINT) as WINBOOL
declare function ImageList_Replace(byval himl as HIMAGELIST, byval i as long, byval hbmImage as HBITMAP, byval hbmMask as HBITMAP) as WINBOOL
declare function ImageList_AddMasked(byval himl as HIMAGELIST, byval hbmImage as HBITMAP, byval crMask as COLORREF) as long
declare function ImageList_DrawEx(byval himl as HIMAGELIST, byval i as long, byval hdcDst as HDC, byval x as long, byval y as long, byval dx as long, byval dy as long, byval rgbBk as COLORREF, byval rgbFg as COLORREF, byval fStyle as UINT) as WINBOOL
declare function ImageList_DrawIndirect(byval pimldp as IMAGELISTDRAWPARAMS ptr) as WINBOOL
declare function ImageList_Remove(byval himl as HIMAGELIST, byval i as long) as WINBOOL
declare function ImageList_GetIcon(byval himl as HIMAGELIST, byval i as long, byval flags as UINT) as HICON
declare function ImageList_LoadImageA(byval hi as HINSTANCE, byval lpbmp as LPCSTR, byval cx as long, byval cGrow as long, byval crMask as COLORREF, byval uType as UINT, byval uFlags as UINT) as HIMAGELIST
declare function ImageList_LoadImageW(byval hi as HINSTANCE, byval lpbmp as LPCWSTR, byval cx as long, byval cGrow as long, byval crMask as COLORREF, byval uType as UINT, byval uFlags as UINT) as HIMAGELIST

#ifdef UNICODE
	declare function ImageList_LoadImage alias "ImageList_LoadImageW"(byval hi as HINSTANCE, byval lpbmp as LPCWSTR, byval cx as long, byval cGrow as long, byval crMask as COLORREF, byval uType as UINT, byval uFlags as UINT) as HIMAGELIST
#else
	declare function ImageList_LoadImage alias "ImageList_LoadImageA"(byval hi as HINSTANCE, byval lpbmp as LPCSTR, byval cx as long, byval cGrow as long, byval crMask as COLORREF, byval uType as UINT, byval uFlags as UINT) as HIMAGELIST
#endif

const ILCF_MOVE = &h0
const ILCF_SWAP = &h1
declare function ImageList_Copy(byval himlDst as HIMAGELIST, byval iDst as long, byval himlSrc as HIMAGELIST, byval iSrc as long, byval uFlags as UINT) as WINBOOL
declare function ImageList_BeginDrag(byval himlTrack as HIMAGELIST, byval iTrack as long, byval dxHotspot as long, byval dyHotspot as long) as WINBOOL
declare sub ImageList_EndDrag()
declare function ImageList_DragEnter(byval hwndLock as HWND, byval x as long, byval y as long) as WINBOOL
declare function ImageList_DragLeave(byval hwndLock as HWND) as WINBOOL
declare function ImageList_DragMove(byval x as long, byval y as long) as WINBOOL
declare function ImageList_SetDragCursorImage(byval himlDrag as HIMAGELIST, byval iDrag as long, byval dxHotspot as long, byval dyHotspot as long) as WINBOOL
declare function ImageList_DragShowNolock(byval fShow as WINBOOL) as WINBOOL
declare function ImageList_GetDragImage(byval ppt as POINT ptr, byval pptHotspot as POINT ptr) as HIMAGELIST

#define ImageList_RemoveAll(himl) ImageList_Remove(himl, -1)
#define ImageList_ExtractIcon(hi, himl, i) ImageList_GetIcon(himl, i, 0)
#define ImageList_LoadBitmap(hi, lpbmp, cx, cGrow, crMask) ImageList_LoadImage(hi, lpbmp, cx, cGrow, crMask, IMAGE_BITMAP, 0)
declare function ImageList_Read(byval pstm as LPSTREAM) as HIMAGELIST
declare function ImageList_Write(byval himl as HIMAGELIST, byval pstm as LPSTREAM) as WINBOOL
const ILP_NORMAL = 0
const ILP_DOWNLEVEL = 1
declare function ImageList_ReadEx(byval dwFlags as DWORD, byval pstm as LPSTREAM, byval riid as const IID const ptr, byval ppv as PVOID ptr) as HRESULT
declare function ImageList_WriteEx(byval himl as HIMAGELIST, byval dwFlags as DWORD, byval pstm as LPSTREAM) as HRESULT

type _IMAGEINFO
	hbmImage as HBITMAP
	hbmMask as HBITMAP
	Unused1 as long
	Unused2 as long
	rcImage as RECT
end type

type IMAGEINFO as _IMAGEINFO
type LPIMAGEINFO as _IMAGEINFO ptr
declare function ImageList_GetIconSize(byval himl as HIMAGELIST, byval cx as long ptr, byval cy as long ptr) as WINBOOL
declare function ImageList_SetIconSize(byval himl as HIMAGELIST, byval cx as long, byval cy as long) as WINBOOL
declare function ImageList_GetImageInfo(byval himl as HIMAGELIST, byval i as long, byval pImageInfo as IMAGEINFO ptr) as WINBOOL
declare function ImageList_Merge(byval himl1 as HIMAGELIST, byval i1 as long, byval himl2 as HIMAGELIST, byval i2 as long, byval dx as long, byval dy as long) as HIMAGELIST
declare function ImageList_Duplicate(byval himl as HIMAGELIST) as HIMAGELIST
declare function HIMAGELIST_QueryInterface(byval himl as HIMAGELIST, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT

#define IImageListToHIMAGELIST(IL) cast(HIMAGELIST, (IL))
#define WC_HEADERA "SysHeader32"
#define WC_HEADERW wstr("SysHeader32")

#ifdef UNICODE
	#define WC_HEADER WC_HEADERW
#else
	#define WC_HEADER WC_HEADERA
#endif

const HDS_HORZ = &h0
const HDS_BUTTONS = &h2
const HDS_HOTTRACK = &h4
const HDS_HIDDEN = &h8
const HDS_DRAGDROP = &h40
const HDS_FULLDRAG = &h80
const HDS_FILTERBAR = &h100
const HDS_FLAT = &h200

#if _WIN32_WINNT >= &h0600
	const HDS_CHECKBOXES = &h400
	const HDS_NOSIZING = &h800
	const HDS_OVERFLOW = &h1000
#endif

const HDFT_ISSTRING = &h0
const HDFT_ISNUMBER = &h1
const HDFT_ISDATE = &h2
const HDFT_HASNOVALUE = &h8000

#ifdef UNICODE
	type HD_TEXTFILTER as HD_TEXTFILTERW
	type HDTEXTFILTER as HD_TEXTFILTERW
	type LPHD_TEXTFILTER as LPHD_TEXTFILTERW
	type LPHDTEXTFILTER as LPHD_TEXTFILTERW
#else
	type HD_TEXTFILTER as HD_TEXTFILTERA
	type HDTEXTFILTER as HD_TEXTFILTERA
	type LPHD_TEXTFILTER as LPHD_TEXTFILTERA
	type LPHDTEXTFILTER as LPHD_TEXTFILTERA
#endif

type _HD_TEXTFILTERA
	pszText as LPSTR
	cchTextMax as INT_
end type

type HD_TEXTFILTERA as _HD_TEXTFILTERA
type LPHD_TEXTFILTERA as _HD_TEXTFILTERA ptr

type _HD_TEXTFILTERW
	pszText as LPWSTR
	cchTextMax as INT_
end type

type HD_TEXTFILTERW as _HD_TEXTFILTERW
type LPHD_TEXTFILTERW as _HD_TEXTFILTERW ptr
type HD_ITEMA as HDITEMA
type HD_ITEMW as HDITEMW

type _HD_ITEMA
	mask as UINT
	cxy as long
	pszText as LPSTR
	hbm as HBITMAP
	cchTextMax as long
	fmt as long
	lParam as LPARAM
	iImage as long
	iOrder as long
	as UINT type
	pvFilter as any ptr

	#if _WIN32_WINNT >= &h0600
		state as UINT
	#endif
end type

type HDITEMA as _HD_ITEMA
type LPHDITEMA as _HD_ITEMA ptr
#define HDITEMA_V1_SIZE CCSIZEOF_STRUCT(HDITEMA, lParam)
#define HDITEMW_V1_SIZE CCSIZEOF_STRUCT(HDITEMW, lParam)

type _HD_ITEMW
	mask as UINT
	cxy as long
	pszText as LPWSTR
	hbm as HBITMAP
	cchTextMax as long
	fmt as long
	lParam as LPARAM
	iImage as long
	iOrder as long
	as UINT type
	pvFilter as any ptr

	#if _WIN32_WINNT >= &h0600
		state as UINT
	#endif
end type

type HDITEMW as _HD_ITEMW
type LPHDITEMW as _HD_ITEMW ptr

#ifdef UNICODE
	type HDITEM as HDITEMW
#else
	type HDITEM as HDITEMA
#endif

type HD_ITEM as HDITEM

#ifdef UNICODE
	type LPHDITEM as LPHDITEMW
	#define HDITEM_V1_SIZE HDITEMW_V1_SIZE
#else
	type LPHDITEM as LPHDITEMA
	#define HDITEM_V1_SIZE HDITEMA_V1_SIZE
#endif

const HDI_WIDTH = &h1
const HDI_HEIGHT = HDI_WIDTH
const HDI_TEXT = &h2
const HDI_FORMAT = &h4
const HDI_LPARAM = &h8
const HDI_BITMAP = &h10
const HDI_IMAGE = &h20
const HDI_DI_SETITEM = &h40
const HDI_ORDER = &h80
const HDI_FILTER = &h100

#if _WIN32_WINNT >= &h0600
	const HDI_STATE = &h0200
#endif

const HDF_LEFT = &h0
const HDF_RIGHT = &h1
const HDF_CENTER = &h2
const HDF_JUSTIFYMASK = &h3
const HDF_RTLREADING = &h4
const HDF_OWNERDRAW = &h8000
const HDF_STRING = &h4000
const HDF_BITMAP = &h2000
const HDF_BITMAP_ON_RIGHT = &h1000
const HDF_IMAGE = &h800
const HDF_SORTUP = &h400
const HDF_SORTDOWN = &h200

#if _WIN32_WINNT >= &h0600
	const HDF_CHECKBOX = &h40
	const HDF_CHECKED = &h80
	const HDF_FIXEDWIDTH = &h100
	const HDF_SPLITBUTTON = &h1000000
	const HDIS_FOCUSED = &h1
#endif

const HDM_GETITEMCOUNT = HDM_FIRST + 0
#define Header_GetItemCount(hwndHD) clng(SNDMSG((hwndHD), HDM_GETITEMCOUNT, cast(WPARAM, 0), cast(LPARAM, 0)))
const HDM_INSERTITEMA = HDM_FIRST + 1
const HDM_INSERTITEMW = HDM_FIRST + 10

#ifdef UNICODE
	const HDM_INSERTITEM = HDM_INSERTITEMW
#else
	const HDM_INSERTITEM = HDM_INSERTITEMA
#endif

#define Header_InsertItem(hwndHD, i, phdi) clng(SNDMSG((hwndHD), HDM_INSERTITEM, cast(WPARAM, clng(i)), cast(LPARAM, cptr(const HD_ITEM ptr, (phdi)))))
const HDM_DELETEITEM = HDM_FIRST + 2
#define Header_DeleteItem(hwndHD, i) cast(WINBOOL, SNDMSG((hwndHD), HDM_DELETEITEM, cast(WPARAM, clng(i)), cast(LPARAM, 0)))
const HDM_GETITEMA = HDM_FIRST + 3
const HDM_GETITEMW = HDM_FIRST + 11

#ifdef UNICODE
	const HDM_GETITEM = HDM_GETITEMW
#else
	const HDM_GETITEM = HDM_GETITEMA
#endif

#define Header_GetItem(hwndHD, i, phdi) cast(WINBOOL, SNDMSG((hwndHD), HDM_GETITEM, cast(WPARAM, clng(i)), cast(LPARAM, cptr(HD_ITEM ptr, (phdi)))))
const HDM_SETITEMA = HDM_FIRST + 4
const HDM_SETITEMW = HDM_FIRST + 12

#ifdef UNICODE
	const HDM_SETITEM = HDM_SETITEMW
#else
	const HDM_SETITEM = HDM_SETITEMA
#endif

#define Header_SetItem(hwndHD, i, phdi) cast(WINBOOL, SNDMSG((hwndHD), HDM_SETITEM, cast(WPARAM, clng(i)), cast(LPARAM, cptr(const HD_ITEM ptr, (phdi)))))
type HD_LAYOUT as HDLAYOUT

type _HD_LAYOUT
	prc as RECT ptr
	pwpos as WINDOWPOS ptr
end type

type HDLAYOUT as _HD_LAYOUT
type LPHDLAYOUT as _HD_LAYOUT ptr
const HDM_LAYOUT = HDM_FIRST + 5
#define Header_Layout(hwndHD, playout) cast(WINBOOL, SNDMSG((hwndHD), HDM_LAYOUT, 0, cast(LPARAM, cptr(HD_LAYOUT ptr, (playout)))))
const HHT_NOWHERE = &h1
const HHT_ONHEADER = &h2
const HHT_ONDIVIDER = &h4
const HHT_ONDIVOPEN = &h8
const HHT_ONFILTER = &h10
const HHT_ONFILTERBUTTON = &h20
const HHT_ABOVE = &h100
const HHT_BELOW = &h200
const HHT_TORIGHT = &h400
const HHT_TOLEFT = &h800

#if _WIN32_WINNT >= &h0600
	const HHT_ONITEMSTATEICON = &h1000
	const HHT_ONDROPDOWN = &h2000
	const HHT_ONOVERFLOW = &h4000
#endif

type HD_HITTESTINFO as HDHITTESTINFO

type _HD_HITTESTINFO
	pt as POINT
	flags as UINT
	iItem as long
end type

type HDHITTESTINFO as _HD_HITTESTINFO
type LPHDHITTESTINFO as _HD_HITTESTINFO ptr
const HDSIL_NORMAL = 0
const HDSIL_STATE = 1
const HDM_HITTEST = HDM_FIRST + 6
const HDM_GETITEMRECT = HDM_FIRST + 7
#define Header_GetItemRect(hwnd, iItem, lprc) cast(WINBOOL, SNDMSG((hwnd), HDM_GETITEMRECT, cast(WPARAM, (iItem)), cast(LPARAM, (lprc))))
const HDM_SETIMAGELIST = HDM_FIRST + 8
#define Header_SetImageList(hwnd, himl) cast(HIMAGELIST, SNDMSG((hwnd), HDM_SETIMAGELIST, 0, cast(LPARAM, (himl))))
const HDM_GETIMAGELIST = HDM_FIRST + 9
#define Header_GetImageList(hwnd) cast(HIMAGELIST, SNDMSG((hwnd), HDM_GETIMAGELIST, 0, 0))
const HDM_ORDERTOINDEX = HDM_FIRST + 15
#define Header_OrderToIndex(hwnd, i) clng(SNDMSG((hwnd), HDM_ORDERTOINDEX, cast(WPARAM, (i)), 0))
const HDM_CREATEDRAGIMAGE = HDM_FIRST + 16
#define Header_CreateDragImage(hwnd, i) cast(HIMAGELIST, SNDMSG((hwnd), HDM_CREATEDRAGIMAGE, cast(WPARAM, (i)), 0))
const HDM_GETORDERARRAY = HDM_FIRST + 17
#define Header_GetOrderArray(hwnd, iCount, lpi) cast(WINBOOL, SNDMSG((hwnd), HDM_GETORDERARRAY, cast(WPARAM, (iCount)), cast(LPARAM, (lpi))))
const HDM_SETORDERARRAY = HDM_FIRST + 18
#define Header_SetOrderArray(hwnd, iCount, lpi) cast(WINBOOL, SNDMSG((hwnd), HDM_SETORDERARRAY, cast(WPARAM, (iCount)), cast(LPARAM, (lpi))))
const HDM_SETHOTDIVIDER = HDM_FIRST + 19
#define Header_SetHotDivider(hwnd, fPos, dw) clng(SNDMSG((hwnd), HDM_SETHOTDIVIDER, cast(WPARAM, (fPos)), cast(LPARAM, (dw))))
const HDM_SETBITMAPMARGIN = HDM_FIRST + 20
#define Header_SetBitmapMargin(hwnd, iWidth) clng(SNDMSG((hwnd), HDM_SETBITMAPMARGIN, cast(WPARAM, (iWidth)), 0))
const HDM_GETBITMAPMARGIN = HDM_FIRST + 21
#define Header_GetBitmapMargin(hwnd) clng(SNDMSG((hwnd), HDM_GETBITMAPMARGIN, 0, 0))
const HDM_SETUNICODEFORMAT = CCM_SETUNICODEFORMAT
#define Header_SetUnicodeFormat(hwnd, fUnicode) cast(WINBOOL, SNDMSG((hwnd), HDM_SETUNICODEFORMAT, cast(WPARAM, (fUnicode)), 0))
const HDM_GETUNICODEFORMAT = CCM_GETUNICODEFORMAT
#define Header_GetUnicodeFormat(hwnd) cast(WINBOOL, SNDMSG((hwnd), HDM_GETUNICODEFORMAT, 0, 0))
const HDM_SETFILTERCHANGETIMEOUT = HDM_FIRST + 22
#define Header_SetFilterChangeTimeout(hwnd, i) clng(SNDMSG((hwnd), HDM_SETFILTERCHANGETIMEOUT, 0, cast(LPARAM, (i))))
const HDM_EDITFILTER = HDM_FIRST + 23
#define Header_EditFilter(hwnd, i, fDiscardChanges) clng(SNDMSG((hwnd), HDM_EDITFILTER, cast(WPARAM, (i)), MAKELPARAM(fDiscardChanges, 0)))

#if _WIN32_WINNT >= &h0501
	#define HDM_TRANSLATEACCELERATOR CCM_TRANSLATEACCELERATOR
#endif

const HDM_CLEARFILTER = HDM_FIRST + 24
#define Header_ClearFilter(hwnd, i) clng(SNDMSG((hwnd), HDM_CLEARFILTER, cast(WPARAM, (i)), 0))
#define Header_ClearAllFilters(hwnd) clng(SNDMSG((hwnd), HDM_CLEARFILTER, cast(WPARAM, -1), 0))

#if _WIN32_WINNT >= &h0600
	const HDM_GETITEMDROPDOWNRECT = HDM_FIRST + 25
	#define Header_GetItemDropDownRect(hwnd, iItem, lprc) cast(WINBOOL, SNDMSG((hwnd), HDM_GETITEMDROPDOWNRECT, cast(WPARAM, (iItem)), cast(LPARAM, (lprc))))
	const HDM_GETOVERFLOWRECT = HDM_FIRST + 26
	#define Header_GetOverflowRect(hwnd, lprc) cast(WINBOOL, SNDMSG((hwnd), HDM_GETOVERFLOWRECT, 0, cast(LPARAM, (lprc))))
	const HDM_GETFOCUSEDITEM = HDM_FIRST + 27
	#define Header_GetFocusedItem(hwnd) clng(SNDMSG((hwnd), HDM_GETFOCUSEDITEM, cast(WPARAM, 0), cast(LPARAM, 0)))
	const HDM_SETFOCUSEDITEM = HDM_FIRST + 28
	#define Header_SetFocusedItem(hwnd, iItem) cast(WINBOOL, SNDMSG((hwnd), HDM_SETFOCUSEDITEM, cast(WPARAM, 0), cast(LPARAM, (iItem))))
#endif

const HDN_ITEMCHANGINGA = culng(HDN_FIRST - 0)
const HDN_ITEMCHANGINGW = culng(HDN_FIRST - 20)
const HDN_ITEMCHANGEDA = culng(HDN_FIRST - 1)
const HDN_ITEMCHANGEDW = culng(HDN_FIRST - 21)
const HDN_ITEMCLICKA = culng(HDN_FIRST - 2)
const HDN_ITEMCLICKW = culng(HDN_FIRST - 22)
const HDN_ITEMDBLCLICKA = culng(HDN_FIRST - 3)
const HDN_ITEMDBLCLICKW = culng(HDN_FIRST - 23)
const HDN_DIVIDERDBLCLICKA = culng(HDN_FIRST - 5)
const HDN_DIVIDERDBLCLICKW = culng(HDN_FIRST - 25)
const HDN_BEGINTRACKA = culng(HDN_FIRST - 6)
const HDN_BEGINTRACKW = culng(HDN_FIRST - 26)
const HDN_ENDTRACKA = culng(HDN_FIRST - 7)
const HDN_ENDTRACKW = culng(HDN_FIRST - 27)
const HDN_TRACKA = culng(HDN_FIRST - 8)
const HDN_TRACKW = culng(HDN_FIRST - 28)
const HDN_GETDISPINFOA = culng(HDN_FIRST - 9)
const HDN_GETDISPINFOW = culng(HDN_FIRST - 29)
const HDN_BEGINDRAG = culng(HDN_FIRST - 10)
const HDN_ENDDRAG = culng(HDN_FIRST - 11)
const HDN_FILTERCHANGE = culng(HDN_FIRST - 12)
const HDN_FILTERBTNCLICK = culng(HDN_FIRST - 13)

#if _WIN32_WINNT >= &h0501
	const HDN_BEGINFILTEREDIT = culng(HDN_FIRST - 14)
	const HDN_ENDFILTEREDIT = culng(HDN_FIRST - 15)
#endif

#if _WIN32_WINNT >= &h0600
	const HDN_ITEMSTATEICONCLICK = culng(HDN_FIRST - 16)
	const HDN_ITEMKEYDOWN = culng(HDN_FIRST - 17)
	const HDN_DROPDOWN = culng(HDN_FIRST - 18)
	const HDN_OVERFLOWCLICK = culng(HDN_FIRST - 19)
#endif

#ifdef UNICODE
	const HDN_ITEMCHANGING = HDN_ITEMCHANGINGW
	const HDN_ITEMCHANGED = HDN_ITEMCHANGEDW
	const HDN_ITEMCLICK = HDN_ITEMCLICKW
	const HDN_ITEMDBLCLICK = HDN_ITEMDBLCLICKW
	const HDN_DIVIDERDBLCLICK = HDN_DIVIDERDBLCLICKW
	const HDN_BEGINTRACK = HDN_BEGINTRACKW
	const HDN_ENDTRACK = HDN_ENDTRACKW
	const HDN_TRACK = HDN_TRACKW
	const HDN_GETDISPINFO = HDN_GETDISPINFOW
#else
	const HDN_ITEMCHANGING = HDN_ITEMCHANGINGA
	const HDN_ITEMCHANGED = HDN_ITEMCHANGEDA
	const HDN_ITEMCLICK = HDN_ITEMCLICKA
	const HDN_ITEMDBLCLICK = HDN_ITEMDBLCLICKA
	const HDN_DIVIDERDBLCLICK = HDN_DIVIDERDBLCLICKA
	const HDN_BEGINTRACK = HDN_BEGINTRACKA
	const HDN_ENDTRACK = HDN_ENDTRACKA
	const HDN_TRACK = HDN_TRACKA
	const HDN_GETDISPINFO = HDN_GETDISPINFOA
#endif

type HD_NOTIFYA as NMHEADERA
type HD_NOTIFYW as NMHEADERW

type tagNMHEADERA
	hdr as NMHDR
	iItem as long
	iButton as long
	pitem as HDITEMA ptr
end type

type NMHEADERA as tagNMHEADERA
type LPNMHEADERA as tagNMHEADERA ptr

type tagNMHEADERW
	hdr as NMHDR
	iItem as long
	iButton as long
	pitem as HDITEMW ptr
end type

type NMHEADERW as tagNMHEADERW
type LPNMHEADERW as tagNMHEADERW ptr

#ifdef UNICODE
	type NMHEADER as NMHEADERW
#else
	type NMHEADER as NMHEADERA
#endif

type HD_NOTIFY as NMHEADER

#ifdef UNICODE
	type LPNMHEADER as LPNMHEADERW
#else
	type LPNMHEADER as LPNMHEADERA
#endif

type tagNMHDDISPINFOW
	hdr as NMHDR
	iItem as long
	mask as UINT
	pszText as LPWSTR
	cchTextMax as long
	iImage as long
	lParam as LPARAM
end type

type NMHDDISPINFOW as tagNMHDDISPINFOW
type LPNMHDDISPINFOW as tagNMHDDISPINFOW ptr

type tagNMHDDISPINFOA
	hdr as NMHDR
	iItem as long
	mask as UINT
	pszText as LPSTR
	cchTextMax as long
	iImage as long
	lParam as LPARAM
end type

type NMHDDISPINFOA as tagNMHDDISPINFOA
type LPNMHDDISPINFOA as tagNMHDDISPINFOA ptr

#ifdef UNICODE
	type NMHDDISPINFO as NMHDDISPINFOW
	type LPNMHDDISPINFO as LPNMHDDISPINFOW
#else
	type NMHDDISPINFO as NMHDDISPINFOA
	type LPNMHDDISPINFO as LPNMHDDISPINFOA
#endif

type tagNMHDFILTERBTNCLICK
	hdr as NMHDR
	iItem as INT_
	rc as RECT
end type

type NMHDFILTERBTNCLICK as tagNMHDFILTERBTNCLICK
type LPNMHDFILTERBTNCLICK as tagNMHDFILTERBTNCLICK ptr
#define TOOLBARCLASSNAMEW wstr("ToolbarWindow32")
#define TOOLBARCLASSNAMEA "ToolbarWindow32"

#ifdef UNICODE
	#define TOOLBARCLASSNAME TOOLBARCLASSNAMEW
#else
	#define TOOLBARCLASSNAME TOOLBARCLASSNAMEA
#endif

type _TBBUTTON
	iBitmap as long
	idCommand as long
	fsState as UBYTE
	fsStyle as UBYTE

	#ifdef __FB_64BIT__
		bReserved(0 to 5) as UBYTE
	#else
		bReserved(0 to 1) as UBYTE
	#endif

	dwData as DWORD_PTR
	iString as INT_PTR
end type

type TBBUTTON as _TBBUTTON
type PTBBUTTON as _TBBUTTON ptr
type LPTBBUTTON as _TBBUTTON ptr
type LPCTBBUTTON as const TBBUTTON ptr

type _COLORMAP
	from as COLORREF
	to as COLORREF
end type

type COLORMAP as _COLORMAP
type LPCOLORMAP as _COLORMAP ptr
declare function CreateToolbarEx(byval hwnd as HWND, byval ws as DWORD, byval wID as UINT, byval nBitmaps as long, byval hBMInst as HINSTANCE, byval wBMID as UINT_PTR, byval lpButtons as LPCTBBUTTON, byval iNumButtons as long, byval dxButton as long, byval dyButton as long, byval dxBitmap as long, byval dyBitmap as long, byval uStructSize as UINT) as HWND
declare function CreateMappedBitmap(byval hInstance as HINSTANCE, byval idBitmap as INT_PTR, byval wFlags as UINT, byval lpColorMap as LPCOLORMAP, byval iNumMaps as long) as HBITMAP
const CMB_MASKED = &h2
const TBSTATE_CHECKED = &h1
const TBSTATE_PRESSED = &h2
const TBSTATE_ENABLED = &h4
const TBSTATE_HIDDEN = &h8
const TBSTATE_INDETERMINATE = &h10
const TBSTATE_WRAP = &h20
const TBSTATE_ELLIPSES = &h40
const TBSTATE_MARKED = &h80
const TBSTYLE_BUTTON = &h0
const TBSTYLE_SEP = &h1
const TBSTYLE_CHECK = &h2
const TBSTYLE_GROUP = &h4
const TBSTYLE_CHECKGROUP = TBSTYLE_GROUP or TBSTYLE_CHECK
const TBSTYLE_DROPDOWN = &h8
const TBSTYLE_AUTOSIZE = &h10
const TBSTYLE_NOPREFIX = &h20
const TBSTYLE_TOOLTIPS = &h100
const TBSTYLE_WRAPABLE = &h200
const TBSTYLE_ALTDRAG = &h400
const TBSTYLE_FLAT = &h800
const TBSTYLE_LIST = &h1000
const TBSTYLE_CUSTOMERASE = &h2000
const TBSTYLE_REGISTERDROP = &h4000
const TBSTYLE_TRANSPARENT = &h8000
const TBSTYLE_EX_DRAWDDARROWS = &h1
const BTNS_BUTTON = TBSTYLE_BUTTON
const BTNS_SEP = TBSTYLE_SEP
const BTNS_CHECK = TBSTYLE_CHECK
const BTNS_GROUP = TBSTYLE_GROUP
const BTNS_CHECKGROUP = TBSTYLE_CHECKGROUP
const BTNS_DROPDOWN = TBSTYLE_DROPDOWN
const BTNS_AUTOSIZE = TBSTYLE_AUTOSIZE
const BTNS_NOPREFIX = TBSTYLE_NOPREFIX
const BTNS_SHOWTEXT = &h40
const BTNS_WHOLEDROPDOWN = &h80
const TBSTYLE_EX_MULTICOLUMN = &h2
const TBSTYLE_EX_VERTICAL = &h4
const TBSTYLE_EX_MIXEDBUTTONS = &h8
const TBSTYLE_EX_HIDECLIPPEDBUTTONS = &h10
const TBSTYLE_EX_DOUBLEBUFFER = &h80

type _NMTBCUSTOMDRAW
	nmcd as NMCUSTOMDRAW
	hbrMonoDither as HBRUSH
	hbrLines as HBRUSH
	hpenLines as HPEN
	clrText as COLORREF
	clrMark as COLORREF
	clrTextHighlight as COLORREF
	clrBtnFace as COLORREF
	clrBtnHighlight as COLORREF
	clrHighlightHotTrack as COLORREF
	rcText as RECT
	nStringBkMode as long
	nHLStringBkMode as long
	iListGap as long
end type

type NMTBCUSTOMDRAW as _NMTBCUSTOMDRAW
type LPNMTBCUSTOMDRAW as _NMTBCUSTOMDRAW ptr
const TBCDRF_NOEDGES = &h10000
const TBCDRF_HILITEHOTTRACK = &h20000
const TBCDRF_NOOFFSET = &h40000
const TBCDRF_NOMARK = &h80000
const TBCDRF_NOETCHEDEFFECT = &h100000
const TBCDRF_BLENDICON = &h200000
const TBCDRF_NOBACKGROUND = &h400000

#if _WIN32_WINNT >= &h0600
	const TBCDRF_USECDCOLORS = &h00800000
#endif

const TB_ENABLEBUTTON = WM_USER + 1
const TB_CHECKBUTTON = WM_USER + 2
const TB_PRESSBUTTON = WM_USER + 3
const TB_HIDEBUTTON = WM_USER + 4
const TB_INDETERMINATE = WM_USER + 5
const TB_MARKBUTTON = WM_USER + 6
const TB_ISBUTTONENABLED = WM_USER + 9
const TB_ISBUTTONCHECKED = WM_USER + 10
const TB_ISBUTTONPRESSED = WM_USER + 11
const TB_ISBUTTONHIDDEN = WM_USER + 12
const TB_ISBUTTONINDETERMINATE = WM_USER + 13
const TB_ISBUTTONHIGHLIGHTED = WM_USER + 14
const TB_SETSTATE = WM_USER + 17
const TB_GETSTATE = WM_USER + 18
const TB_ADDBITMAP = WM_USER + 19

type tagTBADDBITMAP
	hInst as HINSTANCE
	nID as UINT_PTR
end type

type TBADDBITMAP as tagTBADDBITMAP
type LPTBADDBITMAP as tagTBADDBITMAP ptr
const HINST_COMMCTRL = cast(HINSTANCE, -1)
const IDB_STD_SMALL_COLOR = 0
const IDB_STD_LARGE_COLOR = 1
const IDB_VIEW_SMALL_COLOR = 4
const IDB_VIEW_LARGE_COLOR = 5
const IDB_HIST_SMALL_COLOR = 8
const IDB_HIST_LARGE_COLOR = 9

#if _WIN32_WINNT >= &h0600
	const IDB_HIST_NORMAL = 12
	const IDB_HIST_HOT = 13
	const IDB_HIST_DISABLED = 14
	const IDB_HIST_PRESSED = 15
#endif

const STD_CUT = 0
const STD_COPY = 1
const STD_PASTE = 2
const STD_UNDO = 3
const STD_REDOW = 4
const STD_DELETE = 5
const STD_FILENEW = 6
const STD_FILEOPEN = 7
const STD_FILESAVE = 8
const STD_PRINTPRE = 9
const STD_PROPERTIES = 10
const STD_HELP = 11
const STD_FIND = 12
const STD_REPLACE = 13
const STD_PRINT = 14
const VIEW_LARGEICONS = 0
const VIEW_SMALLICONS = 1
const VIEW_LIST = 2
const VIEW_DETAILS = 3
const VIEW_SORTNAME = 4
const VIEW_SORTSIZE = 5
const VIEW_SORTDATE = 6
const VIEW_SORTTYPE = 7
const VIEW_PARENTFOLDER = 8
const VIEW_NETCONNECT = 9
const VIEW_NETDISCONNECT = 10
const VIEW_NEWFOLDER = 11
const VIEW_VIEWMENU = 12
const HIST_BACK = 0
const HIST_FORWARD = 1
const HIST_FAVORITES = 2
const HIST_ADDTOFAVORITES = 3
const HIST_VIEWTREE = 4
const TB_ADDBUTTONSA = WM_USER + 20
const TB_INSERTBUTTONA = WM_USER + 21
const TB_DELETEBUTTON = WM_USER + 22
const TB_GETBUTTON = WM_USER + 23
const TB_BUTTONCOUNT = WM_USER + 24
const TB_COMMANDTOINDEX = WM_USER + 25

type tagTBSAVEPARAMSA
	hkr as HKEY
	pszSubKey as LPCSTR
	pszValueName as LPCSTR
end type

type TBSAVEPARAMSA as tagTBSAVEPARAMSA
type LPTBSAVEPARAMSA as tagTBSAVEPARAMSA ptr

type tagTBSAVEPARAMSW
	hkr as HKEY
	pszSubKey as LPCWSTR
	pszValueName as LPCWSTR
end type

type TBSAVEPARAMSW as tagTBSAVEPARAMSW
type LPTBSAVEPARAMW as tagTBSAVEPARAMSW ptr

#ifdef UNICODE
	type TBSAVEPARAMS as TBSAVEPARAMSW
	#define LPTBSAVEPARAMS LPTBSAVEPARAMSW
#else
	type TBSAVEPARAMS as TBSAVEPARAMSA
	type LPTBSAVEPARAMS as LPTBSAVEPARAMSA
#endif

const TB_SAVERESTOREA = WM_USER + 26
const TB_SAVERESTOREW = WM_USER + 76
const TB_CUSTOMIZE = WM_USER + 27
const TB_ADDSTRINGA = WM_USER + 28
const TB_ADDSTRINGW = WM_USER + 77
const TB_GETITEMRECT = WM_USER + 29
const TB_BUTTONSTRUCTSIZE = WM_USER + 30
const TB_SETBUTTONSIZE = WM_USER + 31
const TB_SETBITMAPSIZE = WM_USER + 32
const TB_AUTOSIZE = WM_USER + 33
const TB_GETTOOLTIPS = WM_USER + 35
const TB_SETTOOLTIPS = WM_USER + 36
const TB_SETPARENT = WM_USER + 37
const TB_SETROWS = WM_USER + 39
const TB_GETROWS = WM_USER + 40
const TB_SETCMDID = WM_USER + 42
const TB_CHANGEBITMAP = WM_USER + 43
const TB_GETBITMAP = WM_USER + 44
const TB_GETBUTTONTEXTA = WM_USER + 45
const TB_GETBUTTONTEXTW = WM_USER + 75
const TB_REPLACEBITMAP = WM_USER + 46
const TB_SETINDENT = WM_USER + 47
const TB_SETIMAGELIST = WM_USER + 48
const TB_GETIMAGELIST = WM_USER + 49
const TB_LOADIMAGES = WM_USER + 50
const TB_GETRECT = WM_USER + 51
const TB_SETHOTIMAGELIST = WM_USER + 52
const TB_GETHOTIMAGELIST = WM_USER + 53
const TB_SETDISABLEDIMAGELIST = WM_USER + 54
const TB_GETDISABLEDIMAGELIST = WM_USER + 55
const TB_SETSTYLE = WM_USER + 56
const TB_GETSTYLE = WM_USER + 57
const TB_GETBUTTONSIZE = WM_USER + 58
const TB_SETBUTTONWIDTH = WM_USER + 59
const TB_SETMAXTEXTROWS = WM_USER + 60
const TB_GETTEXTROWS = WM_USER + 61

#ifdef UNICODE
	const TB_GETBUTTONTEXT = TB_GETBUTTONTEXTW
	const TB_SAVERESTORE = TB_SAVERESTOREW
	const TB_ADDSTRING = TB_ADDSTRINGW
#else
	const TB_GETBUTTONTEXT = TB_GETBUTTONTEXTA
	const TB_SAVERESTORE = TB_SAVERESTOREA
	const TB_ADDSTRING = TB_ADDSTRINGA
#endif

const TB_GETOBJECT = WM_USER + 62
const TB_GETHOTITEM = WM_USER + 71
const TB_SETHOTITEM = WM_USER + 72
const TB_SETANCHORHIGHLIGHT = WM_USER + 73
const TB_GETANCHORHIGHLIGHT = WM_USER + 74
const TB_MAPACCELERATORA = WM_USER + 78

type TBINSERTMARK
	iButton as long
	dwFlags as DWORD
end type

type LPTBINSERTMARK as TBINSERTMARK ptr
const TBIMHT_AFTER = &h1
const TBIMHT_BACKGROUND = &h2
const TB_GETINSERTMARK = WM_USER + 79
const TB_SETINSERTMARK = WM_USER + 80
const TB_INSERTMARKHITTEST = WM_USER + 81
const TB_MOVEBUTTON = WM_USER + 82
const TB_GETMAXSIZE = WM_USER + 83
const TB_SETEXTENDEDSTYLE = WM_USER + 84
const TB_GETEXTENDEDSTYLE = WM_USER + 85
const TB_GETPADDING = WM_USER + 86
const TB_SETPADDING = WM_USER + 87
const TB_SETINSERTMARKCOLOR = WM_USER + 88
const TB_GETINSERTMARKCOLOR = WM_USER + 89
const TB_SETCOLORSCHEME = CCM_SETCOLORSCHEME
const TB_GETCOLORSCHEME = CCM_GETCOLORSCHEME
const TB_SETUNICODEFORMAT = CCM_SETUNICODEFORMAT
const TB_GETUNICODEFORMAT = CCM_GETUNICODEFORMAT
const TB_MAPACCELERATORW = WM_USER + 90

#ifdef UNICODE
	const TB_MAPACCELERATOR = TB_MAPACCELERATORW
#else
	const TB_MAPACCELERATOR = TB_MAPACCELERATORA
#endif

type TBREPLACEBITMAP
	hInstOld as HINSTANCE
	nIDOld as UINT_PTR
	hInstNew as HINSTANCE
	nIDNew as UINT_PTR
	nButtons as long
end type

type LPTBREPLACEBITMAP as TBREPLACEBITMAP ptr
const TBBF_LARGE = &h1
const TB_GETBITMAPFLAGS = WM_USER + 41
const TBIF_IMAGE = &h1
const TBIF_TEXT = &h2
const TBIF_STATE = &h4
const TBIF_STYLE = &h8
const TBIF_LPARAM = &h10
const TBIF_COMMAND = &h20
const TBIF_SIZE = &h40
const TBIF_BYINDEX = &h80000000

type TBBUTTONINFOA
	cbSize as UINT
	dwMask as DWORD
	idCommand as long
	iImage as long
	fsState as UBYTE
	fsStyle as UBYTE
	cx as WORD
	lParam as DWORD_PTR
	pszText as LPSTR
	cchText as long
end type

type LPTBBUTTONINFOA as TBBUTTONINFOA ptr

type TBBUTTONINFOW
	cbSize as UINT
	dwMask as DWORD
	idCommand as long
	iImage as long
	fsState as UBYTE
	fsStyle as UBYTE
	cx as WORD
	lParam as DWORD_PTR
	pszText as LPWSTR
	cchText as long
end type

type LPTBBUTTONINFOW as TBBUTTONINFOW ptr

#ifdef UNICODE
	type TBBUTTONINFO as TBBUTTONINFOW
	type LPTBBUTTONINFO as LPTBBUTTONINFOW
#else
	type TBBUTTONINFO as TBBUTTONINFOA
	type LPTBBUTTONINFO as LPTBBUTTONINFOA
#endif

const TB_GETBUTTONINFOW = WM_USER + 63
const TB_SETBUTTONINFOW = WM_USER + 64
const TB_GETBUTTONINFOA = WM_USER + 65
const TB_SETBUTTONINFOA = WM_USER + 66

#ifdef UNICODE
	const TB_GETBUTTONINFO = TB_GETBUTTONINFOW
	const TB_SETBUTTONINFO = TB_SETBUTTONINFOW
#else
	const TB_GETBUTTONINFO = TB_GETBUTTONINFOA
	const TB_SETBUTTONINFO = TB_SETBUTTONINFOA
#endif

const TB_INSERTBUTTONW = WM_USER + 67
const TB_ADDBUTTONSW = WM_USER + 68
const TB_HITTEST = WM_USER + 69

#ifdef UNICODE
	const TB_INSERTBUTTON = TB_INSERTBUTTONW
	const TB_ADDBUTTONS = TB_ADDBUTTONSW
#else
	const TB_INSERTBUTTON = TB_INSERTBUTTONA
	const TB_ADDBUTTONS = TB_ADDBUTTONSA
#endif

const TB_SETDRAWTEXTFLAGS = WM_USER + 70
const TB_GETSTRINGW = WM_USER + 91
const TB_GETSTRINGA = WM_USER + 92

#ifdef UNICODE
	const TB_GETSTRING = TB_GETSTRINGW
#else
	const TB_GETSTRING = TB_GETSTRINGA
#endif

const TB_SETBOUNDINGSIZE = WM_USER + 93
const TB_SETHOTITEM2 = WM_USER + 94
const TB_HASACCELERATOR = WM_USER + 95
const TB_SETLISTGAP = WM_USER + 96
const TB_GETIMAGELISTCOUNT = WM_USER + 98
const TB_GETIDEALSIZE = WM_USER + 99
#define TB_TRANSLATEACCELERATOR CCM_TRANSLATEACCELERATOR
const TBMF_PAD = &h1
const TBMF_BARPAD = &h2
const TBMF_BUTTONSPACING = &h4

type TBMETRICS
	cbSize as UINT
	dwMask as DWORD
	cxPad as long
	cyPad as long
	cxBarPad as long
	cyBarPad as long
	cxButtonSpacing as long
	cyButtonSpacing as long
end type

type LPTBMETRICS as TBMETRICS ptr
const TB_GETMETRICS = WM_USER + 101
const TB_SETMETRICS = WM_USER + 102
const TB_GETITEMDROPDOWNRECT = WM_USER + 103
const TB_SETPRESSEDIMAGELIST = WM_USER + 104
const TB_GETPRESSEDIMAGELIST = WM_USER + 105
const TB_SETWINDOWTHEME = CCM_SETWINDOWTHEME
const TBN_GETBUTTONINFOA = culng(TBN_FIRST - 0)
const TBN_BEGINDRAG = culng(TBN_FIRST - 1)
const TBN_ENDDRAG = culng(TBN_FIRST - 2)
const TBN_BEGINADJUST = culng(TBN_FIRST - 3)
const TBN_ENDADJUST = culng(TBN_FIRST - 4)
const TBN_RESET = culng(TBN_FIRST - 5)
const TBN_QUERYINSERT = culng(TBN_FIRST - 6)
const TBN_QUERYDELETE = culng(TBN_FIRST - 7)
const TBN_TOOLBARCHANGE = culng(TBN_FIRST - 8)
const TBN_CUSTHELP = culng(TBN_FIRST - 9)
const TBN_DROPDOWN = culng(TBN_FIRST - 10)
const TBN_GETOBJECT = culng(TBN_FIRST - 12)

type tagNMTBHOTITEM
	hdr as NMHDR
	idOld as long
	idNew as long
	dwFlags as DWORD
end type

type NMTBHOTITEM as tagNMTBHOTITEM
type LPNMTBHOTITEM as tagNMTBHOTITEM ptr
const HICF_OTHER = &h0
const HICF_MOUSE = &h1
const HICF_ARROWKEYS = &h2
const HICF_ACCELERATOR = &h4
const HICF_DUPACCEL = &h8
const HICF_ENTERING = &h10
const HICF_LEAVING = &h20
const HICF_RESELECT = &h40
const HICF_LMOUSE = &h80
const HICF_TOGGLEDROPDOWN = &h100
const TBN_HOTITEMCHANGE = culng(TBN_FIRST - 13)
const TBN_DRAGOUT = culng(TBN_FIRST - 14)
const TBN_DELETINGBUTTON = culng(TBN_FIRST - 15)
const TBN_GETDISPINFOA = culng(TBN_FIRST - 16)
const TBN_GETDISPINFOW = culng(TBN_FIRST - 17)
const TBN_GETINFOTIPA = culng(TBN_FIRST - 18)
const TBN_GETINFOTIPW = culng(TBN_FIRST - 19)
const TBN_GETBUTTONINFOW = culng(TBN_FIRST - 20)
const TBN_RESTORE = culng(TBN_FIRST - 21)
const TBN_SAVE = culng(TBN_FIRST - 22)
const TBN_INITCUSTOMIZE = culng(TBN_FIRST - 23)
const TBNRF_HIDEHELP = &h1
const TBNRF_ENDCUSTOMIZE = &h2
const TBN_WRAPHOTITEM = culng(TBN_FIRST - 24)
const TBN_DUPACCELERATOR = culng(TBN_FIRST - 25)
const TBN_WRAPACCELERATOR = culng(TBN_FIRST - 26)
const TBN_DRAGOVER = culng(TBN_FIRST - 27)
const TBN_MAPACCELERATOR = culng(TBN_FIRST - 28)
const TBNRF_HIDEHELP = &h1
const TBNRF_ENDCUSTOMIZE = &h2

type tagNMTBSAVE
	hdr as NMHDR
	pData as DWORD ptr
	pCurrent as DWORD ptr
	cbData as UINT
	iItem as long
	cButtons as long
	tbButton as TBBUTTON
end type

type NMTBSAVE as tagNMTBSAVE
type LPNMTBSAVE as tagNMTBSAVE ptr

type tagNMTBRESTORE
	hdr as NMHDR
	pData as DWORD ptr
	pCurrent as DWORD ptr
	cbData as UINT
	iItem as long
	cButtons as long
	cbBytesPerRecord as long
	tbButton as TBBUTTON
end type

type NMTBRESTORE as tagNMTBRESTORE
type LPNMTBRESTORE as tagNMTBRESTORE ptr

type tagNMTBGETINFOTIPA
	hdr as NMHDR
	pszText as LPSTR
	cchTextMax as long
	iItem as long
	lParam as LPARAM
end type

type NMTBGETINFOTIPA as tagNMTBGETINFOTIPA
type LPNMTBGETINFOTIPA as tagNMTBGETINFOTIPA ptr

type tagNMTBGETINFOTIPW
	hdr as NMHDR
	pszText as LPWSTR
	cchTextMax as long
	iItem as long
	lParam as LPARAM
end type

type NMTBGETINFOTIPW as tagNMTBGETINFOTIPW
type LPNMTBGETINFOTIPW as tagNMTBGETINFOTIPW ptr

#ifdef UNICODE
	const TBN_GETINFOTIP = TBN_GETINFOTIPW
	type NMTBGETINFOTIP as NMTBGETINFOTIPW
	type LPNMTBGETINFOTIP as LPNMTBGETINFOTIPW
#else
	const TBN_GETINFOTIP = TBN_GETINFOTIPA
	type NMTBGETINFOTIP as NMTBGETINFOTIPA
	type LPNMTBGETINFOTIP as LPNMTBGETINFOTIPA
#endif

const TBNF_IMAGE = &h1
const TBNF_TEXT = &h2
const TBNF_DI_SETITEM = &h10000000

type NMTBDISPINFOA
	hdr as NMHDR
	dwMask as DWORD
	idCommand as long
	lParam as DWORD_PTR
	iImage as long
	pszText as LPSTR
	cchText as long
end type

type LPNMTBDISPINFOA as NMTBDISPINFOA ptr

type NMTBDISPINFOW
	hdr as NMHDR
	dwMask as DWORD
	idCommand as long
	lParam as DWORD_PTR
	iImage as long
	pszText as LPWSTR
	cchText as long
end type

type LPNMTBDISPINFOW as NMTBDISPINFOW ptr

#ifdef UNICODE
	const TBN_GETDISPINFO = TBN_GETDISPINFOW
	type NMTBDISPINFO as NMTBDISPINFOW
	type LPNMTBDISPINFO as LPNMTBDISPINFOW
#else
	const TBN_GETDISPINFO = TBN_GETDISPINFOA
	type NMTBDISPINFO as NMTBDISPINFOA
	type LPNMTBDISPINFO as LPNMTBDISPINFOA
#endif

const TBDDRET_DEFAULT = 0
const TBDDRET_NODEFAULT = 1
const TBDDRET_TREATPRESSED = 2

#ifdef UNICODE
	const TBN_GETBUTTONINFO = TBN_GETBUTTONINFOW
#else
	const TBN_GETBUTTONINFO = TBN_GETBUTTONINFOA
#endif

type TBNOTIFYA as NMTOOLBARA
type TBNOTIFYW as NMTOOLBARW
type LPTBNOTIFYA as LPNMTOOLBARA
type LPTBNOTIFYW as LPNMTOOLBARW

type tagNMTOOLBARA
	hdr as NMHDR
	iItem as long
	tbButton as TBBUTTON
	cchText as long
	pszText as LPSTR
	rcButton as RECT
end type

type NMTOOLBARA as tagNMTOOLBARA
type LPNMTOOLBARA as tagNMTOOLBARA ptr

type tagNMTOOLBARW
	hdr as NMHDR
	iItem as long
	tbButton as TBBUTTON
	cchText as long
	pszText as LPWSTR
	rcButton as RECT
end type

type NMTOOLBARW as tagNMTOOLBARW
type LPNMTOOLBARW as tagNMTOOLBARW ptr

#ifdef UNICODE
	type NMTOOLBAR as NMTOOLBARW
#else
	type NMTOOLBAR as NMTOOLBARA
#endif

type TBNOTIFY as NMTOOLBAR

#ifdef UNICODE
	type LPNMTOOLBAR as LPNMTOOLBARW
#else
	type LPNMTOOLBAR as LPNMTOOLBARA
#endif

type LPTBNOTIFY as LPNMTOOLBAR
#define REBARCLASSNAMEW wstr("ReBarWindow32")
#define REBARCLASSNAMEA "ReBarWindow32"

#ifdef UNICODE
	#define REBARCLASSNAME REBARCLASSNAMEW
#else
	#define REBARCLASSNAME REBARCLASSNAMEA
#endif

const RBIM_IMAGELIST = &h1
const RBS_TOOLTIPS = &h100
const RBS_VARHEIGHT = &h200
const RBS_BANDBORDERS = &h400
const RBS_FIXEDORDER = &h800
const RBS_REGISTERDROP = &h1000
const RBS_AUTOSIZE = &h2000
const RBS_VERTICALGRIPPER = &h4000
const RBS_DBLCLKTOGGLE = &h8000

type tagREBARINFO
	cbSize as UINT
	fMask as UINT
	himl as HIMAGELIST
end type

type REBARINFO as tagREBARINFO
type LPREBARINFO as tagREBARINFO ptr
const RBBS_BREAK = &h1
const RBBS_FIXEDSIZE = &h2
const RBBS_CHILDEDGE = &h4
const RBBS_HIDDEN = &h8
const RBBS_NOVERT = &h10
const RBBS_FIXEDBMP = &h20
const RBBS_VARIABLEHEIGHT = &h40
const RBBS_GRIPPERALWAYS = &h80
const RBBS_NOGRIPPER = &h100
const RBBS_USECHEVRON = &h200
const RBBS_HIDETITLE = &h400
const RBBS_TOPALIGN = &h800
const RBBIM_STYLE = &h1
const RBBIM_COLORS = &h2
const RBBIM_TEXT = &h4
const RBBIM_IMAGE = &h8
const RBBIM_CHILD = &h10
const RBBIM_CHILDSIZE = &h20
const RBBIM_SIZE = &h40
const RBBIM_BACKGROUND = &h80
const RBBIM_ID = &h100
const RBBIM_IDEALSIZE = &h200
const RBBIM_LPARAM = &h400
const RBBIM_HEADERSIZE = &h800

#if _WIN32_WINNT >= &h0600
	const RBBIM_CHEVRONLOCATION = &h00001000
	const RBBIM_CHEVRONSTATE = &h00002000
#endif

type tagREBARBANDINFOA
	cbSize as UINT
	fMask as UINT
	fStyle as UINT
	clrFore as COLORREF
	clrBack as COLORREF
	lpText as LPSTR
	cch as UINT
	iImage as long
	hwndChild as HWND
	cxMinChild as UINT
	cyMinChild as UINT
	cx as UINT
	hbmBack as HBITMAP
	wID as UINT
	cyChild as UINT
	cyMaxChild as UINT
	cyIntegral as UINT
	cxIdeal as UINT
	lParam as LPARAM
	cxHeader as UINT

	#if _WIN32_WINNT >= &h0600
		rcChevronLocation as RECT
		uChevronState as UINT
	#endif
end type

type REBARBANDINFOA as tagREBARBANDINFOA
type LPREBARBANDINFOA as tagREBARBANDINFOA ptr
type LPCREBARBANDINFOA as const REBARBANDINFOA ptr

#define REBARBANDINFOA_V3_SIZE CCSIZEOF_STRUCT(REBARBANDINFOA, wID)
#define REBARBANDINFOW_V3_SIZE CCSIZEOF_STRUCT(REBARBANDINFOW, wID)
#define REBARBANDINFOA_V6_SIZE CCSIZEOF_STRUCT(REBARBANDINFOA, cxHeader)
#define REBARBANDINFOW_V6_SIZE CCSIZEOF_STRUCT(REBARBANDINFOW, cxHeader)

type tagREBARBANDINFOW
	cbSize as UINT
	fMask as UINT
	fStyle as UINT
	clrFore as COLORREF
	clrBack as COLORREF
	lpText as LPWSTR
	cch as UINT
	iImage as long
	hwndChild as HWND
	cxMinChild as UINT
	cyMinChild as UINT
	cx as UINT
	hbmBack as HBITMAP
	wID as UINT
	cyChild as UINT
	cyMaxChild as UINT
	cyIntegral as UINT
	cxIdeal as UINT
	lParam as LPARAM
	cxHeader as UINT

	#if _WIN32_WINNT >= &h0600
		rcChevronLocation as RECT
		uChevronState as UINT
	#endif
end type

type REBARBANDINFOW as tagREBARBANDINFOW
type LPREBARBANDINFOW as tagREBARBANDINFOW ptr
type LPCREBARBANDINFOW as const REBARBANDINFOW ptr

#ifdef UNICODE
	type REBARBANDINFO as REBARBANDINFOW
	type LPREBARBANDINFO as LPREBARBANDINFOW
	type LPCREBARBANDINFO as LPCREBARBANDINFOW
	#define REBARBANDINFO_V3_SIZE REBARBANDINFOW_V3_SIZE
	#define REBARBANDINFO_V6_SIZE REBARBANDINFOW_V6_SIZE
#else
	type REBARBANDINFO as REBARBANDINFOA
	type LPREBARBANDINFO as LPREBARBANDINFOA
	type LPCREBARBANDINFO as LPCREBARBANDINFOA
	#define REBARBANDINFO_V3_SIZE REBARBANDINFOA_V3_SIZE
	#define REBARBANDINFO_V6_SIZE REBARBANDINFOA_V6_SIZE
#endif

const RB_INSERTBANDA = WM_USER + 1
const RB_DELETEBAND = WM_USER + 2
const RB_GETBARINFO = WM_USER + 3
const RB_SETBARINFO = WM_USER + 4
const RB_SETBANDINFOA = WM_USER + 6
const RB_SETPARENT = WM_USER + 7
const RB_HITTEST = WM_USER + 8
const RB_GETRECT = WM_USER + 9
const RB_INSERTBANDW = WM_USER + 10
const RB_SETBANDINFOW = WM_USER + 11
const RB_GETBANDCOUNT = WM_USER + 12
const RB_GETROWCOUNT = WM_USER + 13
const RB_GETROWHEIGHT = WM_USER + 14
const RB_IDTOINDEX = WM_USER + 16
const RB_GETTOOLTIPS = WM_USER + 17
const RB_SETTOOLTIPS = WM_USER + 18
const RB_SETBKCOLOR = WM_USER + 19
const RB_GETBKCOLOR = WM_USER + 20
const RB_SETTEXTCOLOR = WM_USER + 21
const RB_GETTEXTCOLOR = WM_USER + 22
const RBSTR_CHANGERECT = &h1
const RB_SIZETORECT = WM_USER + 23
const RB_SETCOLORSCHEME = CCM_SETCOLORSCHEME
const RB_GETCOLORSCHEME = CCM_GETCOLORSCHEME

#ifdef UNICODE
	const RB_INSERTBAND = RB_INSERTBANDW
	const RB_SETBANDINFO = RB_SETBANDINFOW
#else
	const RB_INSERTBAND = RB_INSERTBANDA
	const RB_SETBANDINFO = RB_SETBANDINFOA
#endif

const RB_BEGINDRAG = WM_USER + 24
const RB_ENDDRAG = WM_USER + 25
const RB_DRAGMOVE = WM_USER + 26
const RB_GETBARHEIGHT = WM_USER + 27
const RB_GETBANDINFOW = WM_USER + 28
const RB_GETBANDINFOA = WM_USER + 29

#ifdef UNICODE
	const RB_GETBANDINFO = RB_GETBANDINFOW
#else
	const RB_GETBANDINFO = RB_GETBANDINFOA
#endif

const RB_MINIMIZEBAND = WM_USER + 30
const RB_MAXIMIZEBAND = WM_USER + 31
const RB_GETDROPTARGET = CCM_GETDROPTARGET
const RB_GETBANDBORDERS = WM_USER + 34
const RB_SHOWBAND = WM_USER + 35
const RB_SETPALETTE = WM_USER + 37
const RB_GETPALETTE = WM_USER + 38
const RB_MOVEBAND = WM_USER + 39
const RB_SETUNICODEFORMAT = CCM_SETUNICODEFORMAT
const RB_GETUNICODEFORMAT = CCM_GETUNICODEFORMAT
const RB_GETBANDMARGINS = WM_USER + 40
const RB_SETWINDOWTHEME = CCM_SETWINDOWTHEME

#if _WIN32_WINNT >= &h0501
	const RB_SETEXTENDEDSTYLE = WM_USER + 41
	const RB_GETEXTENDEDSTYLE = WM_USER + 42
#endif

const RB_PUSHCHEVRON = WM_USER + 43

#if _WIN32_WINNT >= &h0600
	const RB_SETBANDWIDTH = WM_USER + 44
#endif

const RBN_HEIGHTCHANGE = culng(RBN_FIRST - 0)
const RBN_GETOBJECT = culng(RBN_FIRST - 1)
const RBN_LAYOUTCHANGED = culng(RBN_FIRST - 2)
const RBN_AUTOSIZE = culng(RBN_FIRST - 3)
const RBN_BEGINDRAG = culng(RBN_FIRST - 4)
const RBN_ENDDRAG = culng(RBN_FIRST - 5)
const RBN_DELETINGBAND = culng(RBN_FIRST - 6)
const RBN_DELETEDBAND = culng(RBN_FIRST - 7)
const RBN_CHILDSIZE = culng(RBN_FIRST - 8)
const RBN_CHEVRONPUSHED = culng(RBN_FIRST - 10)

#if _WIN32_WINNT >= &h0501
	const RBN_SPLITTERDRAG = culng(RBN_FIRST - 11)
#endif

const RBN_MINMAX = culng(RBN_FIRST - 21)
const RBN_AUTOBREAK = culng(RBN_FIRST - 22)

type tagNMREBARCHILDSIZE
	hdr as NMHDR
	uBand as UINT
	wID as UINT
	rcChild as RECT
	rcBand as RECT
end type

type NMREBARCHILDSIZE as tagNMREBARCHILDSIZE
type LPNMREBARCHILDSIZE as tagNMREBARCHILDSIZE ptr

type tagNMREBAR
	hdr as NMHDR
	dwMask as DWORD
	uBand as UINT
	fStyle as UINT
	wID as UINT
	lParam as LPARAM
end type

type NMREBAR as tagNMREBAR
type LPNMREBAR as tagNMREBAR ptr
const RBNM_ID = &h1
const RBNM_STYLE = &h2
const RBNM_LPARAM = &h4

type tagNMRBAUTOSIZE
	hdr as NMHDR
	fChanged as WINBOOL
	rcTarget as RECT
	rcActual as RECT
end type

type NMRBAUTOSIZE as tagNMRBAUTOSIZE
type LPNMRBAUTOSIZE as tagNMRBAUTOSIZE ptr

type tagNMREBARCHEVRON
	hdr as NMHDR
	uBand as UINT
	wID as UINT
	lParam as LPARAM
	rc as RECT
	lParamNM as LPARAM
end type

type NMREBARCHEVRON as tagNMREBARCHEVRON
type LPNMREBARCHEVRON as tagNMREBARCHEVRON ptr

#if _WIN32_WINNT >= &h0501
	type tagNMREBARSPLITTER
		hdr as NMHDR
		rcSizing as RECT
	end type

	type NMREBARSPLITTER as tagNMREBARSPLITTER
	type LPNMREBARSPLITTER as tagNMREBARSPLITTER ptr
#endif

const RBAB_AUTOSIZE = &h1
const RBAB_ADDBAND = &h2

type tagNMREBARAUTOBREAK
	hdr as NMHDR
	uBand as UINT
	wID as UINT
	lParam as LPARAM
	uMsg as UINT
	fStyleCurrent as UINT
	fAutoBreak as WINBOOL
end type

type NMREBARAUTOBREAK as tagNMREBARAUTOBREAK
type LPNMREBARAUTOBREAK as tagNMREBARAUTOBREAK ptr
const RBHT_NOWHERE = &h1
const RBHT_CAPTION = &h2
const RBHT_CLIENT = &h3
const RBHT_GRABBER = &h4
const RBHT_CHEVRON = &h8

#if _WIN32_WINNT >= &h0501
	const RBHT_SPLITTER = &h10
#endif

type _RB_HITTESTINFO
	pt as POINT
	flags as UINT
	iBand as long
end type

type RBHITTESTINFO as _RB_HITTESTINFO
type LPRBHITTESTINFO as _RB_HITTESTINFO ptr
#define TOOLTIPS_CLASSW wstr("tooltips_class32")
#define TOOLTIPS_CLASSA "tooltips_class32"

#ifdef UNICODE
	#define TOOLTIPS_CLASS TOOLTIPS_CLASSW
#else
	#define TOOLTIPS_CLASS TOOLTIPS_CLASSA
#endif

type LPTOOLINFOA as LPTTTOOLINFOA
type LPTOOLINFOW as LPTTTOOLINFOW
type TOOLINFOA as TTTOOLINFOA
type TOOLINFOW as TTTOOLINFOW

#define TTTOOLINFOA_V1_SIZE CCSIZEOF_STRUCT(TTTOOLINFOA, lpszText)
#define TTTOOLINFOW_V1_SIZE CCSIZEOF_STRUCT(TTTOOLINFOW, lpszText)
#define TTTOOLINFOA_V2_SIZE CCSIZEOF_STRUCT(TTTOOLINFOA, lParam)
#define TTTOOLINFOW_V2_SIZE CCSIZEOF_STRUCT(TTTOOLINFOW, lParam)
#define TTTOOLINFOA_V3_SIZE CCSIZEOF_STRUCT(TTTOOLINFOA, lpReserved)
#define TTTOOLINFOW_V3_SIZE CCSIZEOF_STRUCT(TTTOOLINFOW, lpReserved)

type tagTOOLINFOA
	cbSize as UINT
	uFlags as UINT
	hwnd as HWND
	uId as UINT_PTR
	rect as RECT
	hinst as HINSTANCE
	lpszText as LPSTR
	lParam as LPARAM
	lpReserved as any ptr
end type

type TTTOOLINFOA as tagTOOLINFOA
type PTOOLINFOA as tagTOOLINFOA ptr
type LPTTTOOLINFOA as tagTOOLINFOA ptr

type tagTOOLINFOW
	cbSize as UINT
	uFlags as UINT
	hwnd as HWND
	uId as UINT_PTR
	rect as RECT
	hinst as HINSTANCE
	lpszText as LPWSTR
	lParam as LPARAM
	lpReserved as any ptr
end type

type TTTOOLINFOW as tagTOOLINFOW
type PTOOLINFOW as tagTOOLINFOW ptr
type LPTTTOOLINFOW as tagTOOLINFOW ptr

#ifdef UNICODE
	type TTTOOLINFO as TTTOOLINFOW
#else
	type TTTOOLINFO as TTTOOLINFOA
#endif

type TOOLINFO as TTTOOLINFO

#ifdef UNICODE
	type PTOOLINFO as PTOOLINFOW
	type LPTTTOOLINFO as LPTTTOOLINFOW
#else
	type PTOOLINFO as PTOOLINFOA
	type LPTTTOOLINFO as LPTTTOOLINFOA
#endif

type LPTOOLINFO as LPTTTOOLINFO

#ifdef UNICODE
	#define TTTOOLINFO_V1_SIZE TTTOOLINFOW_V1_SIZE
#else
	#define TTTOOLINFO_V1_SIZE TTTOOLINFOA_V1_SIZE
#endif

const TTS_ALWAYSTIP = &h1
const TTS_NOPREFIX = &h2
const TTS_NOANIMATE = &h10
const TTS_NOFADE = &h20
const TTS_BALLOON = &h40
const TTS_CLOSE = &h80

#if _WIN32_WINNT >= &h0600
	const TTS_USEVISUALSTYLE = &h100
#endif

const TTF_IDISHWND = &h1
const TTF_CENTERTIP = &h2
const TTF_RTLREADING = &h4
const TTF_SUBCLASS = &h10
const TTF_TRACK = &h20
const TTF_ABSOLUTE = &h80
const TTF_TRANSPARENT = &h100
const TTF_PARSELINKS = &h1000
const TTF_DI_SETITEM = &h8000
const TTDT_AUTOMATIC = 0
const TTDT_RESHOW = 1
const TTDT_AUTOPOP = 2
const TTDT_INITIAL = 3
const TTI_NONE = 0
const TTI_INFO = 1
const TTI_WARNING = 2
const TTI_ERROR = 3

#if _WIN32_WINNT >= &h0600
	const TTI_INFO_LARGE = 4
	const TTI_WARNING_LARGE = 5
	const TTI_ERROR_LARGE = 6
#endif

const TTM_ACTIVATE = WM_USER + 1
const TTM_SETDELAYTIME = WM_USER + 3
const TTM_ADDTOOLA = WM_USER + 4
const TTM_ADDTOOLW = WM_USER + 50
const TTM_DELTOOLA = WM_USER + 5
const TTM_DELTOOLW = WM_USER + 51
const TTM_NEWTOOLRECTA = WM_USER + 6
const TTM_NEWTOOLRECTW = WM_USER + 52
const TTM_RELAYEVENT = WM_USER + 7
const TTM_GETTOOLINFOA = WM_USER + 8
const TTM_GETTOOLINFOW = WM_USER + 53
const TTM_SETTOOLINFOA = WM_USER + 9
const TTM_SETTOOLINFOW = WM_USER + 54
const TTM_HITTESTA = WM_USER + 10
const TTM_HITTESTW = WM_USER + 55
const TTM_GETTEXTA = WM_USER + 11
const TTM_GETTEXTW = WM_USER + 56
const TTM_UPDATETIPTEXTA = WM_USER + 12
const TTM_UPDATETIPTEXTW = WM_USER + 57
const TTM_GETTOOLCOUNT = WM_USER + 13
const TTM_ENUMTOOLSA = WM_USER + 14
const TTM_ENUMTOOLSW = WM_USER + 58
const TTM_GETCURRENTTOOLA = WM_USER + 15
const TTM_GETCURRENTTOOLW = WM_USER + 59
const TTM_WINDOWFROMPOINT = WM_USER + 16
const TTM_TRACKACTIVATE = WM_USER + 17
const TTM_TRACKPOSITION = WM_USER + 18
const TTM_SETTIPBKCOLOR = WM_USER + 19
const TTM_SETTIPTEXTCOLOR = WM_USER + 20
const TTM_GETDELAYTIME = WM_USER + 21
const TTM_GETTIPBKCOLOR = WM_USER + 22
const TTM_GETTIPTEXTCOLOR = WM_USER + 23
const TTM_SETMAXTIPWIDTH = WM_USER + 24
const TTM_GETMAXTIPWIDTH = WM_USER + 25
const TTM_SETMARGIN = WM_USER + 26
const TTM_GETMARGIN = WM_USER + 27
const TTM_POP = WM_USER + 28
const TTM_UPDATE = WM_USER + 29
const TTM_GETBUBBLESIZE = WM_USER + 30
const TTM_ADJUSTRECT = WM_USER + 31
const TTM_SETTITLEA = WM_USER + 32
const TTM_SETTITLEW = WM_USER + 33
const TTM_POPUP = WM_USER + 34
const TTM_GETTITLE = WM_USER + 35

type _TTGETTITLE
	dwSize as DWORD
	uTitleBitmap as UINT
	cch as UINT
	pszTitle as wstring ptr
end type

type TTGETTITLE as _TTGETTITLE
type PTTGETTITLE as _TTGETTITLE ptr

#ifdef UNICODE
	const TTM_ADDTOOL = TTM_ADDTOOLW
	const TTM_DELTOOL = TTM_DELTOOLW
	const TTM_NEWTOOLRECT = TTM_NEWTOOLRECTW
	const TTM_GETTOOLINFO = TTM_GETTOOLINFOW
	const TTM_SETTOOLINFO = TTM_SETTOOLINFOW
	const TTM_HITTEST = TTM_HITTESTW
	const TTM_GETTEXT = TTM_GETTEXTW
	const TTM_UPDATETIPTEXT = TTM_UPDATETIPTEXTW
	const TTM_ENUMTOOLS = TTM_ENUMTOOLSW
	const TTM_GETCURRENTTOOL = TTM_GETCURRENTTOOLW
	const TTM_SETTITLE = TTM_SETTITLEW
#else
	const TTM_ADDTOOL = TTM_ADDTOOLA
	const TTM_DELTOOL = TTM_DELTOOLA
	const TTM_NEWTOOLRECT = TTM_NEWTOOLRECTA
	const TTM_GETTOOLINFO = TTM_GETTOOLINFOA
	const TTM_SETTOOLINFO = TTM_SETTOOLINFOA
	const TTM_HITTEST = TTM_HITTESTA
	const TTM_GETTEXT = TTM_GETTEXTA
	const TTM_UPDATETIPTEXT = TTM_UPDATETIPTEXTA
	const TTM_ENUMTOOLS = TTM_ENUMTOOLSA
	const TTM_GETCURRENTTOOL = TTM_GETCURRENTTOOLA
	const TTM_SETTITLE = TTM_SETTITLEA
#endif

const TTM_SETWINDOWTHEME = CCM_SETWINDOWTHEME
type LPHITTESTINFOW as LPTTHITTESTINFOW
type LPHITTESTINFOA as LPTTHITTESTINFOA

type _TT_HITTESTINFOA
	hwnd as HWND
	pt as POINT
	ti as TTTOOLINFOA
end type

type TTHITTESTINFOA as _TT_HITTESTINFOA
type LPTTHITTESTINFOA as _TT_HITTESTINFOA ptr

type _TT_HITTESTINFOW
	hwnd as HWND
	pt as POINT
	ti as TTTOOLINFOW
end type

type TTHITTESTINFOW as _TT_HITTESTINFOW
type LPTTHITTESTINFOW as _TT_HITTESTINFOW ptr

#ifdef UNICODE
	type TTHITTESTINFO as TTHITTESTINFOW
	type LPTTHITTESTINFO as LPTTHITTESTINFOW
#else
	type TTHITTESTINFO as TTHITTESTINFOA
	type LPTTHITTESTINFO as LPTTHITTESTINFOA
#endif

type LPHITTESTINFO as LPTTHITTESTINFO
const TTN_GETDISPINFOA = culng(TTN_FIRST - 0)
const TTN_GETDISPINFOW = culng(TTN_FIRST - 10)
const TTN_SHOW = culng(TTN_FIRST - 1)
const TTN_POP = culng(TTN_FIRST - 2)
const TTN_LINKCLICK = culng(TTN_FIRST - 3)

#ifdef UNICODE
	const TTN_GETDISPINFO = TTN_GETDISPINFOW
#else
	const TTN_GETDISPINFO = TTN_GETDISPINFOA
#endif

const TTN_NEEDTEXT = TTN_GETDISPINFO
const TTN_NEEDTEXTA = TTN_GETDISPINFOA
const TTN_NEEDTEXTW = TTN_GETDISPINFOW

type TOOLTIPTEXTW as NMTTDISPINFOW
type TOOLTIPTEXTA as NMTTDISPINFOA
type LPTOOLTIPTEXTA as LPNMTTDISPINFOA
type LPTOOLTIPTEXTW as LPNMTTDISPINFOW
#define NMTTDISPINFOA_V1_SIZE CCSIZEOF_STRUCT(NMTTDISPINFOA, uFlags)
#define NMTTDISPINFOW_V1_SIZE CCSIZEOF_STRUCT(NMTTDISPINFOW, uFlags)

type tagNMTTDISPINFOA
	hdr as NMHDR
	lpszText as LPSTR
	szText as zstring * 80
	hinst as HINSTANCE
	uFlags as UINT
	lParam as LPARAM
end type

type NMTTDISPINFOA as tagNMTTDISPINFOA
type LPNMTTDISPINFOA as tagNMTTDISPINFOA ptr

type tagNMTTDISPINFOW
	hdr as NMHDR
	lpszText as LPWSTR
	szText as wstring * 80
	hinst as HINSTANCE
	uFlags as UINT
	lParam as LPARAM
end type

type NMTTDISPINFOW as tagNMTTDISPINFOW
type LPNMTTDISPINFOW as tagNMTTDISPINFOW ptr

#ifdef UNICODE
	type NMTTDISPINFO as NMTTDISPINFOW
#else
	type NMTTDISPINFO as NMTTDISPINFOA
#endif

type TOOLTIPTEXT as NMTTDISPINFO

#ifdef UNICODE
	type LPNMTTDISPINFO as LPNMTTDISPINFOW
#else
	type LPNMTTDISPINFO as LPNMTTDISPINFOA
#endif

type LPTOOLTIPTEXT as LPNMTTDISPINFO

#ifdef UNICODE
	#define NMTTDISPINFO_V1_SIZE NMTTDISPINFOW_V1_SIZE
#else
	#define NMTTDISPINFO_V1_SIZE NMTTDISPINFOA_V1_SIZE
#endif

const SBARS_SIZEGRIP = &h100
const SBARS_TOOLTIPS = &h800
const SBT_TOOLTIPS = &h800

declare sub DrawStatusTextA(byval hDC as HDC, byval lprc as LPCRECT, byval pszText as LPCSTR, byval uFlags as UINT)
declare sub DrawStatusTextW(byval hDC as HDC, byval lprc as LPCRECT, byval pszText as LPCWSTR, byval uFlags as UINT)
declare function CreateStatusWindowA(byval style as LONG, byval lpszText as LPCSTR, byval hwndParent as HWND, byval wID as UINT) as HWND
declare function CreateStatusWindowW(byval style as LONG, byval lpszText as LPCWSTR, byval hwndParent as HWND, byval wID as UINT) as HWND

#ifdef UNICODE
	declare function CreateStatusWindow alias "CreateStatusWindowW"(byval style as LONG, byval lpszText as LPCWSTR, byval hwndParent as HWND, byval wID as UINT) as HWND
	declare sub DrawStatusText alias "DrawStatusTextW"(byval hDC as HDC, byval lprc as LPCRECT, byval pszText as LPCWSTR, byval uFlags as UINT)
#else
	declare function CreateStatusWindow alias "CreateStatusWindowA"(byval style as LONG, byval lpszText as LPCSTR, byval hwndParent as HWND, byval wID as UINT) as HWND
	declare sub DrawStatusText alias "DrawStatusTextA"(byval hDC as HDC, byval lprc as LPCRECT, byval pszText as LPCSTR, byval uFlags as UINT)
#endif

#define STATUSCLASSNAMEW wstr("msctls_statusbar32")
#define STATUSCLASSNAMEA "msctls_statusbar32"

#ifdef UNICODE
	#define STATUSCLASSNAME STATUSCLASSNAMEW
#else
	#define STATUSCLASSNAME STATUSCLASSNAMEA
#endif

const SB_SETTEXTA = WM_USER + 1
const SB_SETTEXTW = WM_USER + 11
const SB_GETTEXTA = WM_USER + 2
const SB_GETTEXTW = WM_USER + 13
const SB_GETTEXTLENGTHA = WM_USER + 3
const SB_GETTEXTLENGTHW = WM_USER + 12

#ifdef UNICODE
	const SB_GETTEXT = SB_GETTEXTW
	const SB_SETTEXT = SB_SETTEXTW
	const SB_GETTEXTLENGTH = SB_GETTEXTLENGTHW
#else
	const SB_GETTEXT = SB_GETTEXTA
	const SB_SETTEXT = SB_SETTEXTA
	const SB_GETTEXTLENGTH = SB_GETTEXTLENGTHA
#endif

const SB_SETPARTS = WM_USER + 4
const SB_GETPARTS = WM_USER + 6
const SB_GETBORDERS = WM_USER + 7
const SB_SETMINHEIGHT = WM_USER + 8
const SB_SIMPLE = WM_USER + 9
const SB_GETRECT = WM_USER + 10
const SB_ISSIMPLE = WM_USER + 14
const SB_SETICON = WM_USER + 15
const SB_SETTIPTEXTA = WM_USER + 16

#ifndef UNICODE
	const SB_SETTIPTEXT = SB_SETTIPTEXTA
#endif

const SB_SETTIPTEXTW = WM_USER + 17

#ifdef UNICODE
	const SB_SETTIPTEXT = SB_SETTIPTEXTW
#endif

const SB_GETTIPTEXTA = WM_USER + 18

#ifndef UNICODE
	const SB_GETTIPTEXT = SB_GETTIPTEXTA
#endif

const SB_GETTIPTEXTW = WM_USER + 19

#ifdef UNICODE
	const SB_GETTIPTEXT = SB_GETTIPTEXTW
#endif

const SB_GETICON = WM_USER + 20
const SB_SETUNICODEFORMAT = CCM_SETUNICODEFORMAT
const SB_GETUNICODEFORMAT = CCM_GETUNICODEFORMAT
const SBT_OWNERDRAW = &h1000
const SBT_NOBORDERS = &h100
const SBT_POPOUT = &h200
const SBT_RTLREADING = &h400
const SBT_NOTABPARSING = &h800
const SB_SETBKCOLOR = CCM_SETBKCOLOR
const SBN_SIMPLEMODECHANGE = culng(SBN_FIRST - 0)
const SB_SIMPLEID = &hff

declare sub MenuHelp(byval uMsg as UINT, byval wParam as WPARAM, byval lParam as LPARAM, byval hMainMenu as HMENU, byval hInst as HINSTANCE, byval hwndStatus as HWND, byval lpwIDs as UINT ptr)
declare function ShowHideMenuCtl(byval hWnd as HWND, byval uFlags as UINT_PTR, byval lpInfo as LPINT) as WINBOOL
declare sub GetEffectiveClientRect(byval hWnd as HWND, byval lprc as LPRECT, byval lpInfo as const INT_ ptr)

const MINSYSCOMMAND = SC_SIZE
#define TRACKBAR_CLASSA "msctls_trackbar32"
#define TRACKBAR_CLASSW wstr("msctls_trackbar32")

#ifdef UNICODE
	#define TRACKBAR_CLASS TRACKBAR_CLASSW
#else
	#define TRACKBAR_CLASS TRACKBAR_CLASSA
#endif

const TBS_AUTOTICKS = &h1
const TBS_VERT = &h2
const TBS_HORZ = &h0
const TBS_TOP = &h4
const TBS_BOTTOM = &h0
const TBS_LEFT = &h4
const TBS_RIGHT = &h0
const TBS_BOTH = &h8
const TBS_NOTICKS = &h10
const TBS_ENABLESELRANGE = &h20
const TBS_FIXEDLENGTH = &h40
const TBS_NOTHUMB = &h80
const TBS_TOOLTIPS = &h100
const TBS_REVERSED = &h200
const TBS_DOWNISLEFT = &h400

#if _WIN32_WINNT >= &h0501
	const TBS_NOTIFYBEFOREMOVE = &h800
#endif

#if _WIN32_WINNT >= &h0600
	const TBS_TRANSPARENTBKGND = &h1000
#endif

const TBM_GETPOS = WM_USER
const TBM_GETRANGEMIN = WM_USER + 1
const TBM_GETRANGEMAX = WM_USER + 2
const TBM_GETTIC = WM_USER + 3
const TBM_SETTIC = WM_USER + 4
const TBM_SETPOS = WM_USER + 5
const TBM_SETRANGE = WM_USER + 6
const TBM_SETRANGEMIN = WM_USER + 7
const TBM_SETRANGEMAX = WM_USER + 8
const TBM_CLEARTICS = WM_USER + 9
const TBM_SETSEL = WM_USER + 10
const TBM_SETSELSTART = WM_USER + 11
const TBM_SETSELEND = WM_USER + 12
const TBM_GETPTICS = WM_USER + 14
const TBM_GETTICPOS = WM_USER + 15
const TBM_GETNUMTICS = WM_USER + 16
const TBM_GETSELSTART = WM_USER + 17
const TBM_GETSELEND = WM_USER + 18
const TBM_CLEARSEL = WM_USER + 19
const TBM_SETTICFREQ = WM_USER + 20
const TBM_SETPAGESIZE = WM_USER + 21
const TBM_GETPAGESIZE = WM_USER + 22
const TBM_SETLINESIZE = WM_USER + 23
const TBM_GETLINESIZE = WM_USER + 24
const TBM_GETTHUMBRECT = WM_USER + 25
const TBM_GETCHANNELRECT = WM_USER + 26
const TBM_SETTHUMBLENGTH = WM_USER + 27
const TBM_GETTHUMBLENGTH = WM_USER + 28
const TBM_SETTOOLTIPS = WM_USER + 29
const TBM_GETTOOLTIPS = WM_USER + 30
const TBM_SETTIPSIDE = WM_USER + 31
const TBTS_TOP = 0
const TBTS_LEFT = 1
const TBTS_BOTTOM = 2
const TBTS_RIGHT = 3
const TBM_SETBUDDY = WM_USER + 32
const TBM_GETBUDDY = WM_USER + 33
const TBM_SETUNICODEFORMAT = CCM_SETUNICODEFORMAT
const TBM_GETUNICODEFORMAT = CCM_GETUNICODEFORMAT
const TB_LINEUP = 0
const TB_LINEDOWN = 1
const TB_PAGEUP = 2
const TB_PAGEDOWN = 3
const TB_THUMBPOSITION = 4
const TB_THUMBTRACK = 5
const TB_TOP = 6
const TB_BOTTOM = 7
const TB_ENDTRACK = 8
const TBCD_TICS = &h1
const TBCD_THUMB = &h2
const TBCD_CHANNEL = &h3

#if _WIN32_WINNT >= &h0600
	const TRBN_THUMBPOSCHANGING = culng(TRBN_FIRST - 1)

	type tagTRBTHUMBPOSCHANGING
		hdr as NMHDR
		dwPos as DWORD
		nReason as long
	end type

	type NMTRBTHUMBPOSCHANGING as tagTRBTHUMBPOSCHANGING
#endif

type tagDRAGLISTINFO
	uNotification as UINT
	hWnd as HWND
	ptCursor as POINT
end type

type DRAGLISTINFO as tagDRAGLISTINFO
type LPDRAGLISTINFO as tagDRAGLISTINFO ptr
const DL_BEGINDRAG = WM_USER + 133
const DL_DRAGGING = WM_USER + 134
const DL_DROPPED = WM_USER + 135
const DL_CANCELDRAG = WM_USER + 136
const DL_CURSORSET = 0
const DL_STOPCURSOR = 1
const DL_COPYCURSOR = 2
const DL_MOVECURSOR = 3
#define DRAGLISTMSGSTRING __TEXT("commctrl_DragListMsg")

declare function MakeDragList(byval hLB as HWND) as WINBOOL
declare sub DrawInsert(byval handParent as HWND, byval hLB as HWND, byval nItem as long)
declare function LBItemFromPt(byval hLB as HWND, byval pt as POINT, byval bAutoScroll as WINBOOL) as long
#define UPDOWN_CLASSA "msctls_updown32"
#define UPDOWN_CLASSW wstr("msctls_updown32")

#ifdef UNICODE
	#define UPDOWN_CLASS UPDOWN_CLASSW
#else
	#define UPDOWN_CLASS UPDOWN_CLASSA
#endif

type _UDACCEL
	nSec as UINT
	nInc as UINT
end type

type UDACCEL as _UDACCEL
type LPUDACCEL as _UDACCEL ptr
const UD_MAXVAL = &h7fff
const UD_MINVAL = -UD_MAXVAL
const UDS_WRAP = &h1
const UDS_SETBUDDYINT = &h2
const UDS_ALIGNRIGHT = &h4
const UDS_ALIGNLEFT = &h8
const UDS_AUTOBUDDY = &h10
const UDS_ARROWKEYS = &h20
const UDS_HORZ = &h40
const UDS_NOTHOUSANDS = &h80
const UDS_HOTTRACK = &h100
const UDM_SETRANGE = WM_USER + 101
const UDM_GETRANGE = WM_USER + 102
const UDM_SETPOS = WM_USER + 103
const UDM_GETPOS = WM_USER + 104
const UDM_SETBUDDY = WM_USER + 105
const UDM_GETBUDDY = WM_USER + 106
const UDM_SETACCEL = WM_USER + 107
const UDM_GETACCEL = WM_USER + 108
const UDM_SETBASE = WM_USER + 109
const UDM_GETBASE = WM_USER + 110
const UDM_SETRANGE32 = WM_USER + 111
const UDM_GETRANGE32 = WM_USER + 112
const UDM_SETUNICODEFORMAT = CCM_SETUNICODEFORMAT
const UDM_GETUNICODEFORMAT = CCM_GETUNICODEFORMAT
const UDM_SETPOS32 = WM_USER + 113
const UDM_GETPOS32 = WM_USER + 114
declare function CreateUpDownControl(byval dwStyle as DWORD, byval x as long, byval y as long, byval cx as long, byval cy as long, byval hParent as HWND, byval nID as long, byval hInst as HINSTANCE, byval hBuddy as HWND, byval nUpper as long, byval nLower as long, byval nPos as long) as HWND
type NM_UPDOWN as NMUPDOWN
type LPNM_UPDOWN as LPNMUPDOWN

type _NM_UPDOWN
	hdr as NMHDR
	iPos as long
	iDelta as long
end type

type NMUPDOWN as _NM_UPDOWN
type LPNMUPDOWN as _NM_UPDOWN ptr
const UDN_DELTAPOS = culng(UDN_FIRST - 1)
#define PROGRESS_CLASSA "msctls_progress32"
#define PROGRESS_CLASSW wstr("msctls_progress32")

#ifdef UNICODE
	#define PROGRESS_CLASS PROGRESS_CLASSW
#else
	#define PROGRESS_CLASS PROGRESS_CLASSA
#endif

const PBS_SMOOTH = &h1
const PBS_VERTICAL = &h4
const PBM_SETRANGE = WM_USER + 1
const PBM_SETPOS = WM_USER + 2
const PBM_DELTAPOS = WM_USER + 3
const PBM_SETSTEP = WM_USER + 4
const PBM_STEPIT = WM_USER + 5
const PBM_SETRANGE32 = WM_USER + 6

type PBRANGE
	iLow as long
	iHigh as long
end type

type PPBRANGE as PBRANGE ptr
const PBM_GETRANGE = WM_USER + 7
const PBM_GETPOS = WM_USER + 8
const PBM_SETBARCOLOR = WM_USER + 9
const PBM_SETBKCOLOR = CCM_SETBKCOLOR
const PBS_MARQUEE = &h8
const PBM_SETMARQUEE = WM_USER + 10

#if _WIN32_WINNT >= &h0600
	const PBM_GETSTEP = WM_USER + 13
	const PBM_GETBKCOLOR = WM_USER + 14
	const PBM_GETBARCOLOR = WM_USER + 15
	const PBM_SETSTATE = WM_USER + 16
	const PBM_GETSTATE = WM_USER + 17
	const PBS_SMOOTHREVERSE = &h10
	const PBST_NORMAL = 1
	const PBST_ERROR = 2
	const PBST_PAUSED = 3
#endif

const HOTKEYF_SHIFT = &h1
const HOTKEYF_CONTROL = &h2
const HOTKEYF_ALT = &h4
const HOTKEYF_EXT = &h8
const HKCOMB_NONE = &h1
const HKCOMB_S = &h2
const HKCOMB_C = &h4
const HKCOMB_A = &h8
const HKCOMB_SC = &h10
const HKCOMB_SA = &h20
const HKCOMB_CA = &h40
const HKCOMB_SCA = &h80
const HKM_SETHOTKEY = WM_USER + 1
const HKM_GETHOTKEY = WM_USER + 2
const HKM_SETRULES = WM_USER + 3
#define HOTKEY_CLASSA "msctls_hotkey32"
#define HOTKEY_CLASSW wstr("msctls_hotkey32")

#ifdef UNICODE
	#define HOTKEY_CLASS HOTKEY_CLASSW
#else
	#define HOTKEY_CLASS HOTKEY_CLASSA
#endif

const CCS_TOP = &h1
const CCS_NOMOVEY = &h2
const CCS_BOTTOM = &h3
const CCS_NORESIZE = &h4
const CCS_NOPARENTALIGN = &h8
const CCS_ADJUSTABLE = &h20
const CCS_NODIVIDER = &h40
const CCS_VERT = &h80
const CCS_LEFT = CCS_VERT or CCS_TOP
const CCS_RIGHT = CCS_VERT or CCS_BOTTOM
const CCS_NOMOVEX = CCS_VERT or CCS_NOMOVEY
const INVALID_LINK_INDEX = -1
const MAX_LINKID_TEXT = 48
#define L_MAX_URL_LENGTH ((2048 + 32) + sizeof("://"))
#define WC_LINK wstr("SysLink")

type tagLITEM
	mask as UINT
	iLink as long
	state as UINT
	stateMask as UINT
	szID as wstring * 48
	szUrl as wstring * (2048 + 32) + sizeof("://")
end type

type LITEM as tagLITEM
type PLITEM as tagLITEM ptr

type tagLHITTESTINFO
	pt as POINT
	item as LITEM
end type

type LHITTESTINFO as tagLHITTESTINFO
type PLHITTESTINFO as tagLHITTESTINFO ptr

type tagNMLINK
	hdr as NMHDR
	item as LITEM
end type

type NMLINK as tagNMLINK
type PNMLINK as tagNMLINK ptr
#define WC_LISTVIEWA "SysListView32"
#define WC_LISTVIEWW wstr("SysListView32")

#ifdef UNICODE
	#define WC_LISTVIEW WC_LISTVIEWW
#else
	#define WC_LISTVIEW WC_LISTVIEWA
#endif

const LVS_ICON = &h0
const LVS_REPORT = &h1
const LVS_SMALLICON = &h2
const LVS_LIST = &h3
const LVS_TYPEMASK = &h3
const LVS_SINGLESEL = &h4
const LVS_SHOWSELALWAYS = &h8
const LVS_SORTASCENDING = &h10
const LVS_SORTDESCENDING = &h20
const LVS_SHAREIMAGELISTS = &h40
const LVS_NOLABELWRAP = &h80
const LVS_AUTOARRANGE = &h100
const LVS_EDITLABELS = &h200
const LVS_OWNERDATA = &h1000
const LVS_NOSCROLL = &h2000
const LVS_TYPESTYLEMASK = &hfc00
const LVS_ALIGNTOP = &h0
const LVS_ALIGNLEFT = &h800
const LVS_ALIGNMASK = &hc00
const LVS_OWNERDRAWFIXED = &h400
const LVS_NOCOLUMNHEADER = &h4000
const LVS_NOSORTHEADER = &h8000
const LVM_SETUNICODEFORMAT = CCM_SETUNICODEFORMAT
#define ListView_SetUnicodeFormat(hwnd, fUnicode) cast(WINBOOL, SNDMSG((hwnd), LVM_SETUNICODEFORMAT, cast(WPARAM, (fUnicode)), 0))
const LVM_GETUNICODEFORMAT = CCM_GETUNICODEFORMAT
#define ListView_GetUnicodeFormat(hwnd) cast(WINBOOL, SNDMSG((hwnd), LVM_GETUNICODEFORMAT, 0, 0))
const LVM_GETBKCOLOR = LVM_FIRST + 0
#define ListView_GetBkColor(hwnd) cast(COLORREF, SNDMSG((hwnd), LVM_GETBKCOLOR, cast(WPARAM, 0), cast(LPARAM, 0)))
const LVM_SETBKCOLOR = LVM_FIRST + 1
#define ListView_SetBkColor(hwnd, clrBk) cast(WINBOOL, SNDMSG((hwnd), LVM_SETBKCOLOR, 0, cast(LPARAM, cast(COLORREF, (clrBk)))))
const LVM_GETIMAGELIST = LVM_FIRST + 2
#define ListView_GetImageList(hwnd, iImageList) cast(HIMAGELIST, SNDMSG((hwnd), LVM_GETIMAGELIST, cast(WPARAM, cast(INT_, (iImageList))), cast(LPARAM, 0)))
const LVSIL_NORMAL = 0
const LVSIL_SMALL = 1
const LVSIL_STATE = 2
const LVSIL_GROUPHEADER = 3
const LVM_SETIMAGELIST = LVM_FIRST + 3
#define ListView_SetImageList(hwnd, himl, iImageList) cast(HIMAGELIST, SNDMSG((hwnd), LVM_SETIMAGELIST, cast(WPARAM, (iImageList)), cast(LPARAM, cast(HIMAGELIST, (himl)))))
const LVM_GETITEMCOUNT = LVM_FIRST + 4
#define ListView_GetItemCount(hwnd) clng(SNDMSG((hwnd), LVM_GETITEMCOUNT, cast(WPARAM, 0), cast(LPARAM, 0)))
const LVIF_TEXT = &h1
const LVIF_IMAGE = &h2
const LVIF_PARAM = &h4
const LVIF_STATE = &h8
const LVIF_INDENT = &h10
const LVIF_NORECOMPUTE = &h800
const LVIF_GROUPID = &h100
const LVIF_COLUMNS = &h200

#if _WIN32_WINNT >= &h0600
	const LVIF_COLFMT = &h10000
#endif

const LVIS_FOCUSED = &h1
const LVIS_SELECTED = &h2
const LVIS_CUT = &h4
const LVIS_DROPHILITED = &h8
const LVIS_GLOW = &h10
const LVIS_ACTIVATING = &h20
const LVIS_OVERLAYMASK = &hf00
const LVIS_STATEIMAGEMASK = &hF000
#define INDEXTOSTATEIMAGEMASK(i) ((i) shl 12)
const I_INDENTCALLBACK = -1
type LV_ITEMA as LVITEMA
type LV_ITEMW as LVITEMW
const I_GROUPIDCALLBACK = -1
const I_GROUPIDNONE = -2
#define LVITEMA_V1_SIZE CCSIZEOF_STRUCT(LVITEMA, lParam)
#define LVITEMW_V1_SIZE CCSIZEOF_STRUCT(LVITEMW, lParam)

#if _WIN32_WINNT >= &h0600
	#define LVITEMA_V5_SIZE CCSIZEOF_STRUCT(LVITEMA, puColumns)
	#define LVITEMW_V5_SIZE CCSIZEOF_STRUCT(LVITEMW, puColumns)
#endif

#if defined(UNICODE) and (_WIN32_WINNT >= &h0600)
	#define LVITEM_V5_SIZE LVITEMW_V5_SIZE
#elseif (not defined(UNICODE)) and (_WIN32_WINNT >= &h0600)
	#define LVITEM_V5_SIZE LVITEMA_V5_SIZE
#endif

type tagLVITEMA
	mask as UINT
	iItem as long
	iSubItem as long
	state as UINT
	stateMask as UINT
	pszText as LPSTR
	cchTextMax as long
	iImage as long
	lParam as LPARAM
	iIndent as long
	iGroupId as long
	cColumns as UINT
	puColumns as PUINT

	#if _WIN32_WINNT >= &h0600
		piColFmt as long ptr
		iGroup as long
	#endif
end type

type LVITEMA as tagLVITEMA
type LPLVITEMA as tagLVITEMA ptr

type tagLVITEMW
	mask as UINT
	iItem as long
	iSubItem as long
	state as UINT
	stateMask as UINT
	pszText as LPWSTR
	cchTextMax as long
	iImage as long
	lParam as LPARAM
	iIndent as long
	iGroupId as long
	cColumns as UINT
	puColumns as PUINT

	#if _WIN32_WINNT >= &h0600
		piColFmt as long ptr
		iGroup as long
	#endif
end type

type LVITEMW as tagLVITEMW
type LPLVITEMW as tagLVITEMW ptr

#ifdef UNICODE
	type LVITEM as LVITEMW
#else
	type LVITEM as LVITEMA
#endif

type LV_ITEM as LVITEM

#ifdef UNICODE
	type LPLVITEM as LPLVITEMW
	#define LVITEM_V1_SIZE LVITEMW_V1_SIZE
#else
	type LPLVITEM as LPLVITEMA
	#define LVITEM_V1_SIZE LVITEMA_V1_SIZE
#endif

const LPSTR_TEXTCALLBACKW = cast(LPWSTR, cast(INT_PTR, -1))
const LPSTR_TEXTCALLBACKA = cast(LPSTR, cast(INT_PTR, -1))

#ifdef UNICODE
	const LPSTR_TEXTCALLBACK = LPSTR_TEXTCALLBACKW
#else
	const LPSTR_TEXTCALLBACK = LPSTR_TEXTCALLBACKA
#endif

const I_IMAGECALLBACK = -1
const I_IMAGENONE = -2
const I_COLUMNSCALLBACK = cast(UINT, -1)
const LVM_GETITEMA = LVM_FIRST + 5
const LVM_GETITEMW = LVM_FIRST + 75

#ifdef UNICODE
	const LVM_GETITEM = LVM_GETITEMW
#else
	const LVM_GETITEM = LVM_GETITEMA
#endif

#define ListView_GetItem(hwnd, pitem) cast(WINBOOL, SNDMSG((hwnd), LVM_GETITEM, 0, cast(LPARAM, cptr(LV_ITEM ptr, (pitem)))))
const LVM_SETITEMA = LVM_FIRST + 6
const LVM_SETITEMW = LVM_FIRST + 76

#ifdef UNICODE
	const LVM_SETITEM = LVM_SETITEMW
#else
	const LVM_SETITEM = LVM_SETITEMA
#endif

#define ListView_SetItem(hwnd, pitem) cast(WINBOOL, SNDMSG((hwnd), LVM_SETITEM, 0, cast(LPARAM, cptr(const LV_ITEM ptr, (pitem)))))
const LVM_INSERTITEMA = LVM_FIRST + 7
const LVM_INSERTITEMW = LVM_FIRST + 77

#ifdef UNICODE
	const LVM_INSERTITEM = LVM_INSERTITEMW
#else
	const LVM_INSERTITEM = LVM_INSERTITEMA
#endif

#define ListView_InsertItem(hwnd, pitem) clng(SNDMSG((hwnd), LVM_INSERTITEM, 0, cast(LPARAM, cptr(const LV_ITEM ptr, (pitem)))))
const LVM_DELETEITEM = LVM_FIRST + 8
#define ListView_DeleteItem(hwnd, i) cast(WINBOOL, SNDMSG((hwnd), LVM_DELETEITEM, cast(WPARAM, clng(i)), cast(LPARAM, 0)))
const LVM_DELETEALLITEMS = LVM_FIRST + 9
#define ListView_DeleteAllItems(hwnd) cast(WINBOOL, SNDMSG((hwnd), LVM_DELETEALLITEMS, cast(WPARAM, 0), cast(LPARAM, 0)))
const LVM_GETCALLBACKMASK = LVM_FIRST + 10
#define ListView_GetCallbackMask(hwnd) cast(WINBOOL, SNDMSG((hwnd), LVM_GETCALLBACKMASK, 0, 0))
const LVM_SETCALLBACKMASK = LVM_FIRST + 11
#define ListView_SetCallbackMask(hwnd, mask) cast(WINBOOL, SNDMSG((hwnd), LVM_SETCALLBACKMASK, cast(WPARAM, cast(UINT, (mask))), 0))
const LVNI_ALL = &h0
const LVNI_FOCUSED = &h1
const LVNI_SELECTED = &h2
const LVNI_CUT = &h4
const LVNI_DROPHILITED = &h8
const LVNI_STATEMASK = ((LVNI_FOCUSED or LVNI_SELECTED) or LVNI_CUT) or LVNI_DROPHILITED
const LVNI_VISIBLEORDER = &h10
const LVNI_PREVIOUS = &h20
const LVNI_VISIBLEONLY = &h40
const LVNI_SAMEGROUPONLY = &h80
const LVNI_ABOVE = &h100
const LVNI_BELOW = &h200
const LVNI_TOLEFT = &h400
const LVNI_TORIGHT = &h800
const LVNI_DIRECTIONMASK = ((LVNI_ABOVE or LVNI_BELOW) or LVNI_TOLEFT) or LVNI_TORIGHT
const LVM_GETNEXTITEM = LVM_FIRST + 12
#define ListView_GetNextItem(hwnd, i, flags) clng(SNDMSG((hwnd), LVM_GETNEXTITEM, cast(WPARAM, clng(i)), MAKELPARAM((flags), 0)))
const LVFI_PARAM = &h1
const LVFI_STRING = &h2
const LVFI_PARTIAL = &h8
const LVFI_WRAP = &h20
const LVFI_NEARESTXY = &h40
type LV_FINDINFOA as LVFINDINFOA
type LV_FINDINFOW as LVFINDINFOW

type tagLVFINDINFOA
	flags as UINT
	psz as LPCSTR
	lParam as LPARAM
	pt as POINT
	vkDirection as UINT
end type

type LVFINDINFOA as tagLVFINDINFOA
type LPFINDINFOA as tagLVFINDINFOA ptr

type tagLVFINDINFOW
	flags as UINT
	psz as LPCWSTR
	lParam as LPARAM
	pt as POINT
	vkDirection as UINT
end type

type LVFINDINFOW as tagLVFINDINFOW
type LPFINDINFOW as tagLVFINDINFOW ptr

#ifdef UNICODE
	type LVFINDINFO as LVFINDINFOW
#else
	type LVFINDINFO as LVFINDINFOA
#endif

type LV_FINDINFO as LVFINDINFO
const LVM_FINDITEMA = LVM_FIRST + 13
const LVM_FINDITEMW = LVM_FIRST + 83

#ifdef UNICODE
	const LVM_FINDITEM = LVM_FINDITEMW
#else
	const LVM_FINDITEM = LVM_FINDITEMA
#endif

#define ListView_FindItem(hwnd, iStart, plvfi) clng(SNDMSG((hwnd), LVM_FINDITEM, cast(WPARAM, clng(iStart)), cast(LPARAM, cptr(const LV_FINDINFO ptr, (plvfi)))))
const LVIR_BOUNDS = 0
const LVIR_ICON = 1
const LVIR_LABEL = 2
const LVIR_SELECTBOUNDS = 3
const LVM_GETITEMRECT = LVM_FIRST + 14
private function ListView_GetItemRect(byval hwnd as HWND, byval i as long, byval prc as RECT ptr, byval code as long) as WINBOOL
	if prc then
		prc->left = code
	end if
	function = SNDMSG(hwnd, LVM_GETITEMRECT, cast(WPARAM, i), cast(LPARAM, prc))
end function
const LVM_SETITEMPOSITION = LVM_FIRST + 15
#define ListView_SetItemPosition(hwndLV, i, x, y) cast(WINBOOL, SNDMSG((hwndLV), LVM_SETITEMPOSITION, cast(WPARAM, clng(i)), MAKELPARAM((x), (y))))
const LVM_GETITEMPOSITION = LVM_FIRST + 16
#define ListView_GetItemPosition(hwndLV, i, ppt) cast(WINBOOL, SNDMSG((hwndLV), LVM_GETITEMPOSITION, cast(WPARAM, clng(i)), cast(LPARAM, cptr(POINT ptr, (ppt)))))
const LVM_GETSTRINGWIDTHA = LVM_FIRST + 17
const LVM_GETSTRINGWIDTHW = LVM_FIRST + 87

#ifdef UNICODE
	const LVM_GETSTRINGWIDTH = LVM_GETSTRINGWIDTHW
#else
	const LVM_GETSTRINGWIDTH = LVM_GETSTRINGWIDTHA
#endif

#define ListView_GetStringWidth(hwndLV, psz) clng(SNDMSG((hwndLV), LVM_GETSTRINGWIDTH, 0, cast(LPARAM, cast(LPCTSTR, (psz)))))
const LVHT_NOWHERE = &h1
const LVHT_ONITEMICON = &h2
const LVHT_ONITEMLABEL = &h4
const LVHT_ONITEMSTATEICON = &h8
const LVHT_ONITEM = (LVHT_ONITEMICON or LVHT_ONITEMLABEL) or LVHT_ONITEMSTATEICON
const LVHT_ABOVE = &h8
const LVHT_BELOW = &h10
const LVHT_TORIGHT = &h20
const LVHT_TOLEFT = &h40
const LVHT_EX_GROUP_HEADER = &h10000000
const LVHT_EX_GROUP_FOOTER = &h20000000
const LVHT_EX_GROUP_COLLAPSE = &h40000000
const LVHT_EX_GROUP_BACKGROUND = &h80000000
const LVHT_EX_GROUP_STATEICON = &h01000000
const LVHT_EX_GROUP_SUBSETLINK = &h02000000
const LVHT_EX_GROUP = ((((LVHT_EX_GROUP_BACKGROUND or LVHT_EX_GROUP_COLLAPSE) or LVHT_EX_GROUP_FOOTER) or LVHT_EX_GROUP_HEADER) or LVHT_EX_GROUP_STATEICON) or LVHT_EX_GROUP_SUBSETLINK
const LVHT_EX_ONCONTENTS = &h04000000
type LV_HITTESTINFO as LVHITTESTINFO
#define LVHITTESTINFO_V1_SIZE CCSIZEOF_STRUCT(LVHITTESTINFO, iItem)

type tagLVHITTESTINFO
	pt as POINT
	flags as UINT
	iItem as long
	iSubItem as long

	#if _WIN32_WINNT >= &h0600
		iGroup as long
	#endif
end type

type LVHITTESTINFO as tagLVHITTESTINFO
type LPLVHITTESTINFO as tagLVHITTESTINFO ptr
const LVM_HITTEST = LVM_FIRST + 18
#define ListView_HitTest(hwndLV, pinfo) clng(SNDMSG((hwndLV), LVM_HITTEST, 0, cast(LPARAM, cptr(LV_HITTESTINFO ptr, (pinfo)))))
const LVM_ENSUREVISIBLE = LVM_FIRST + 19
#define ListView_EnsureVisible(hwndLV, i, fPartialOK) cast(WINBOOL, SNDMSG((hwndLV), LVM_ENSUREVISIBLE, cast(WPARAM, clng(i)), MAKELPARAM((fPartialOK), 0)))
const LVM_SCROLL = LVM_FIRST + 20
#define ListView_Scroll(hwndLV, dx, dy) cast(WINBOOL, SNDMSG((hwndLV), LVM_SCROLL, cast(WPARAM, clng(dx)), cast(LPARAM, clng(dy))))
const LVM_REDRAWITEMS = LVM_FIRST + 21
#define ListView_RedrawItems(hwndLV, iFirst, iLast) cast(WINBOOL, SNDMSG((hwndLV), LVM_REDRAWITEMS, cast(WPARAM, clng(iFirst)), cast(LPARAM, clng(iLast))))
const LVA_DEFAULT = &h0
const LVA_ALIGNLEFT = &h1
const LVA_ALIGNTOP = &h2
const LVA_SNAPTOGRID = &h5
const LVM_ARRANGE = LVM_FIRST + 22
#define ListView_Arrange(hwndLV, code) cast(WINBOOL, SNDMSG((hwndLV), LVM_ARRANGE, cast(WPARAM, cast(UINT, (code))), cast(LPARAM, 0)))
const LVM_EDITLABELA = LVM_FIRST + 23
const LVM_EDITLABELW = LVM_FIRST + 118

#ifdef UNICODE
	const LVM_EDITLABEL = LVM_EDITLABELW
#else
	const LVM_EDITLABEL = LVM_EDITLABELA
#endif

#define ListView_EditLabel(hwndLV, i) cast(HWND, SNDMSG((hwndLV), LVM_EDITLABEL, cast(WPARAM, clng(i)), cast(LPARAM, 0)))
const LVM_GETEDITCONTROL = LVM_FIRST + 24
#define ListView_GetEditControl(hwndLV) cast(HWND, SNDMSG((hwndLV), LVM_GETEDITCONTROL, cast(WPARAM, 0), cast(LPARAM, 0)))
type LV_COLUMNA as LVCOLUMNA
type LV_COLUMNW as LVCOLUMNW
#define LVCOLUMNA_V1_SIZE CCSIZEOF_STRUCT(LVCOLUMNA, iSubItem)
#define LVCOLUMNW_V1_SIZE CCSIZEOF_STRUCT(LVCOLUMNW, iSubItem)

type tagLVCOLUMNA
	mask as UINT
	fmt as long
	cx as long
	pszText as LPSTR
	cchTextMax as long
	iSubItem as long
	iImage as long
	iOrder as long

	#if _WIN32_WINNT >= &h0600
		cxMin as long
		cxDefault as long
		cxIdeal as long
	#endif
end type

type LVCOLUMNA as tagLVCOLUMNA
type LPLVCOLUMNA as tagLVCOLUMNA ptr

type tagLVCOLUMNW
	mask as UINT
	fmt as long
	cx as long
	pszText as LPWSTR
	cchTextMax as long
	iSubItem as long
	iImage as long
	iOrder as long

	#if _WIN32_WINNT >= &h0600
		cxMin as long
		cxDefault as long
		cxIdeal as long
	#endif
end type

type LVCOLUMNW as tagLVCOLUMNW
type LPLVCOLUMNW as tagLVCOLUMNW ptr

#ifdef UNICODE
	type LVCOLUMN as LVCOLUMNW
#else
	type LVCOLUMN as LVCOLUMNA
#endif

type LV_COLUMN as LVCOLUMN

#ifdef UNICODE
	type LPLVCOLUMN as LPLVCOLUMNW
	#define LVCOLUMN_V1_SIZE LVCOLUMNW_V1_SIZE
#else
	type LPLVCOLUMN as LPLVCOLUMNA
	#define LVCOLUMN_V1_SIZE LVCOLUMNA_V1_SIZE
#endif

const LVCF_FMT = &h1
const LVCF_WIDTH = &h2
const LVCF_TEXT = &h4
const LVCF_SUBITEM = &h8
const LVCF_IMAGE = &h10
const LVCF_ORDER = &h20

#if _WIN32_WINNT >= &h0600
	const LVCF_MINWIDTH = &h40
	const LVCF_DEFAULTWIDTH = &h80
	const LVCF_IDEALWIDTH = &h100
#endif

const LVCFMT_LEFT = &h0
const LVCFMT_RIGHT = &h1
const LVCFMT_CENTER = &h2
const LVCFMT_JUSTIFYMASK = &h3
const LVCFMT_IMAGE = &h800
const LVCFMT_BITMAP_ON_RIGHT = &h1000
const LVCFMT_COL_HAS_IMAGES = &h8000

#if _WIN32_WINNT >= &h0600
	const LVCFMT_FIXED_WIDTH = &h100
	const LVCFMT_NO_DPI_SCALE = &h40000
	const LVCFMT_FIXED_RATIO = &h80000
	const LVCFMT_LINE_BREAK = &h100000
	const LVCFMT_FILL = &h200000
	const LVCFMT_WRAP = &h400000
	const LVCFMT_NO_TITLE = &h800000
	const LVCFMT_SPLITBUTTON = &h1000000
	const LVCFMT_TILE_PLACEMENTMASK = LVCFMT_LINE_BREAK or LVCFMT_FILL
#endif

const LVM_GETCOLUMNA = LVM_FIRST + 25
const LVM_GETCOLUMNW = LVM_FIRST + 95

#ifdef UNICODE
	const LVM_GETCOLUMN = LVM_GETCOLUMNW
#else
	const LVM_GETCOLUMN = LVM_GETCOLUMNA
#endif

#define ListView_GetColumn(hwnd, iCol, pcol) cast(WINBOOL, SNDMSG((hwnd), LVM_GETCOLUMN, cast(WPARAM, clng(iCol)), cast(LPARAM, cptr(LV_COLUMN ptr, (pcol)))))
const LVM_SETCOLUMNA = LVM_FIRST + 26
const LVM_SETCOLUMNW = LVM_FIRST + 96

#ifdef UNICODE
	const LVM_SETCOLUMN = LVM_SETCOLUMNW
#else
	const LVM_SETCOLUMN = LVM_SETCOLUMNA
#endif

#define ListView_SetColumn(hwnd, iCol, pcol) cast(WINBOOL, SNDMSG((hwnd), LVM_SETCOLUMN, cast(WPARAM, clng(iCol)), cast(LPARAM, cptr(const LV_COLUMN ptr, (pcol)))))
const LVM_INSERTCOLUMNA = LVM_FIRST + 27
const LVM_INSERTCOLUMNW = LVM_FIRST + 97

#ifdef UNICODE
	const LVM_INSERTCOLUMN = LVM_INSERTCOLUMNW
#else
	const LVM_INSERTCOLUMN = LVM_INSERTCOLUMNA
#endif

#define ListView_InsertColumn(hwnd, iCol, pcol) clng(SNDMSG((hwnd), LVM_INSERTCOLUMN, cast(WPARAM, clng(iCol)), cast(LPARAM, cptr(const LV_COLUMN ptr, (pcol)))))
const LVM_DELETECOLUMN = LVM_FIRST + 28
#define ListView_DeleteColumn(hwnd, iCol) cast(WINBOOL, SNDMSG((hwnd), LVM_DELETECOLUMN, cast(WPARAM, clng(iCol)), 0))
const LVM_GETCOLUMNWIDTH = LVM_FIRST + 29
#define ListView_GetColumnWidth(hwnd, iCol) clng(SNDMSG((hwnd), LVM_GETCOLUMNWIDTH, cast(WPARAM, clng(iCol)), 0))
const LVSCW_AUTOSIZE = -1
const LVSCW_AUTOSIZE_USEHEADER = -2
const LVM_SETCOLUMNWIDTH = LVM_FIRST + 30
#define ListView_SetColumnWidth(hwnd, iCol, cx) cast(WINBOOL, SNDMSG((hwnd), LVM_SETCOLUMNWIDTH, cast(WPARAM, clng(iCol)), MAKELPARAM((cx), 0)))
const LVM_GETHEADER = LVM_FIRST + 31
#define ListView_GetHeader(hwnd_) cast(HWND, SNDMSG((hwnd_), LVM_GETHEADER, cast(WPARAM, 0), cast(LPARAM, 0)))
const LVM_CREATEDRAGIMAGE = LVM_FIRST + 33
#define ListView_CreateDragImage(hwnd, i, lpptUpLeft) cast(HIMAGELIST, SNDMSG((hwnd), LVM_CREATEDRAGIMAGE, cast(WPARAM, clng(i)), cast(LPARAM, cast(LPPOINT, (lpptUpLeft)))))
const LVM_GETVIEWRECT = LVM_FIRST + 34
#define ListView_GetViewRect(hwnd, prc) cast(WINBOOL, SNDMSG((hwnd), LVM_GETVIEWRECT, 0, cast(LPARAM, cptr(RECT ptr, (prc)))))
const LVM_GETTEXTCOLOR = LVM_FIRST + 35
#define ListView_GetTextColor(hwnd) cast(COLORREF, SNDMSG((hwnd), LVM_GETTEXTCOLOR, cast(WPARAM, 0), cast(LPARAM, 0)))
const LVM_SETTEXTCOLOR = LVM_FIRST + 36
#define ListView_SetTextColor(hwnd, clrText) cast(WINBOOL, SNDMSG((hwnd), LVM_SETTEXTCOLOR, 0, cast(LPARAM, cast(COLORREF, (clrText)))))
const LVM_GETTEXTBKCOLOR = LVM_FIRST + 37
#define ListView_GetTextBkColor(hwnd) cast(COLORREF, SNDMSG((hwnd), LVM_GETTEXTBKCOLOR, cast(WPARAM, 0), cast(LPARAM, 0)))
const LVM_SETTEXTBKCOLOR = LVM_FIRST + 38
#define ListView_SetTextBkColor(hwnd, clrTextBk) cast(WINBOOL, SNDMSG((hwnd), LVM_SETTEXTBKCOLOR, 0, cast(LPARAM, cast(COLORREF, (clrTextBk)))))
const LVM_GETTOPINDEX = LVM_FIRST + 39
#define ListView_GetTopIndex(hwndLV) clng(SNDMSG((hwndLV), LVM_GETTOPINDEX, 0, 0))
const LVM_GETCOUNTPERPAGE = LVM_FIRST + 40
#define ListView_GetCountPerPage(hwndLV) clng(SNDMSG((hwndLV), LVM_GETCOUNTPERPAGE, 0, 0))
const LVM_GETORIGIN = LVM_FIRST + 41
#define ListView_GetOrigin(hwndLV, ppt) cast(WINBOOL, SNDMSG((hwndLV), LVM_GETORIGIN, cast(WPARAM, 0), cast(LPARAM, cptr(POINT ptr, (ppt)))))
const LVM_UPDATE = LVM_FIRST + 42
#define ListView_Update(hwndLV, i) cast(WINBOOL, SNDMSG((hwndLV), LVM_UPDATE, cast(WPARAM, (i)), cast(LPARAM, 0)))
const LVM_SETITEMSTATE = LVM_FIRST + 43
#macro ListView_SetItemState(hwndLV, i, data, mask)
	scope
		dim _ms_lvi as LV_ITEM
		_ms_lvi.stateMask = mask
		_ms_lvi.state = data
		SNDMSG((hwndLV), LVM_SETITEMSTATE, cast(WPARAM, (i)), cast(LPARAM, cptr(LV_ITEM ptr, @_ms_lvi)))
	end scope
#endmacro
#define ListView_SetCheckState(hwndLV, i, fCheck) ListView_SetItemState(hwndLV, i, INDEXTOSTATEIMAGEMASK(iif((fCheck), 2, 1)), LVIS_STATEIMAGEMASK)
const LVM_GETITEMSTATE = LVM_FIRST + 44
#define ListView_GetItemState(hwndLV, i, mask) cast(UINT, SNDMSG((hwndLV), LVM_GETITEMSTATE, cast(WPARAM, (i)), cast(LPARAM, (mask))))
#define ListView_GetCheckState(hwndLV, i) ((cast(UINT, SNDMSG((hwndLV), LVM_GETITEMSTATE, cast(WPARAM, (i)), LVIS_STATEIMAGEMASK)) shr 12) - 1)
const LVM_GETITEMTEXTA = LVM_FIRST + 45
const LVM_GETITEMTEXTW = LVM_FIRST + 115

#ifdef UNICODE
	const LVM_GETITEMTEXT = LVM_GETITEMTEXTW
#else
	const LVM_GETITEMTEXT = LVM_GETITEMTEXTA
#endif

#macro ListView_GetItemText(hwndLV, i, iSubItem_, pszText_, cchTextMax_)
	scope
		dim _ms_lvi as LV_ITEM
		_ms_lvi.iSubItem = iSubItem_
		_ms_lvi.cchTextMax = cchTextMax_
		_ms_lvi.pszText = pszText_
		SNDMSG((hwndLV), LVM_GETITEMTEXT, cast(WPARAM, (i)), cast(LPARAM, cptr(LV_ITEM ptr, @_ms_lvi)))
	end scope
#endmacro
const LVM_SETITEMTEXTA = LVM_FIRST + 46
const LVM_SETITEMTEXTW = LVM_FIRST + 116

#ifdef UNICODE
	const LVM_SETITEMTEXT = LVM_SETITEMTEXTW
#else
	const LVM_SETITEMTEXT = LVM_SETITEMTEXTA
#endif

#macro ListView_SetItemText(hwndLV, i, iSubItem_, pszText_)
	scope
		dim _ms_lvi as LV_ITEM
		_ms_lvi.iSubItem = iSubItem_
		_ms_lvi.pszText = pszText_
		SNDMSG((hwndLV), LVM_SETITEMTEXT, cast(WPARAM, (i)), cast(LPARAM, cptr(LV_ITEM ptr, @_ms_lvi)))
	end scope
#endmacro
const LVSICF_NOINVALIDATEALL = &h1
const LVSICF_NOSCROLL = &h2
const LVM_SETITEMCOUNT = LVM_FIRST + 47
#define ListView_SetItemCount(hwndLV, cItems) SNDMSG((hwndLV), LVM_SETITEMCOUNT, cast(WPARAM, (cItems)), 0)
#define ListView_SetItemCountEx(hwndLV, cItems, dwFlags) SNDMSG((hwndLV), LVM_SETITEMCOUNT, cast(WPARAM, (cItems)), cast(LPARAM, (dwFlags)))
type PFNLVCOMPARE as function(byval as LPARAM, byval as LPARAM, byval as LPARAM) as long
const LVM_SORTITEMS = LVM_FIRST + 48
#define ListView_SortItems(hwndLV, _pfnCompare, _lPrm) cast(WINBOOL, SNDMSG((hwndLV), LVM_SORTITEMS, cast(WPARAM, cast(LPARAM, (_lPrm))), cast(LPARAM, cast(PFNLVCOMPARE, (_pfnCompare)))))
const LVM_SETITEMPOSITION32 = LVM_FIRST + 49
#macro ListView_SetItemPosition32(hwndLV, i, x0, y0)
	scope
		dim ptNewPos as POINT
		ptNewPos.x = x0
		ptNewPos.y = y0
		SNDMSG((hwndLV), LVM_SETITEMPOSITION32, cast(WPARAM, clng(i)), cast(LPARAM, @ptNewPos))
	end scope
#endmacro
const LVM_GETSELECTEDCOUNT = LVM_FIRST + 50
#define ListView_GetSelectedCount(hwndLV) cast(UINT, SNDMSG((hwndLV), LVM_GETSELECTEDCOUNT, cast(WPARAM, 0), cast(LPARAM, 0)))
const LVM_GETITEMSPACING = LVM_FIRST + 51
#define ListView_GetItemSpacing(hwndLV, fSmall) cast(DWORD, SNDMSG((hwndLV), LVM_GETITEMSPACING, fSmall, cast(LPARAM, 0)))
const LVM_GETISEARCHSTRINGA = LVM_FIRST + 52
const LVM_GETISEARCHSTRINGW = LVM_FIRST + 117

#ifdef UNICODE
	const LVM_GETISEARCHSTRING = LVM_GETISEARCHSTRINGW
#else
	const LVM_GETISEARCHSTRING = LVM_GETISEARCHSTRINGA
#endif

#define ListView_GetISearchString(hwndLV, lpsz) cast(WINBOOL, SNDMSG((hwndLV), LVM_GETISEARCHSTRING, 0, cast(LPARAM, cast(LPTSTR, (lpsz)))))
const LVM_SETICONSPACING = LVM_FIRST + 53
#define ListView_SetIconSpacing(hwndLV, cx, cy) cast(DWORD, SNDMSG((hwndLV), LVM_SETICONSPACING, 0, MAKELONG(cx, cy)))
const LVM_SETEXTENDEDLISTVIEWSTYLE = LVM_FIRST + 54
#define ListView_SetExtendedListViewStyle(hwndLV, dw) cast(DWORD, SNDMSG((hwndLV), LVM_SETEXTENDEDLISTVIEWSTYLE, 0, dw))
#define ListView_SetExtendedListViewStyleEx(hwndLV, dwMask, dw) cast(DWORD, SNDMSG((hwndLV), LVM_SETEXTENDEDLISTVIEWSTYLE, dwMask, dw))
const LVM_GETEXTENDEDLISTVIEWSTYLE = LVM_FIRST + 55
#define ListView_GetExtendedListViewStyle(hwndLV) cast(DWORD, SNDMSG((hwndLV), LVM_GETEXTENDEDLISTVIEWSTYLE, 0, 0))
const LVS_EX_GRIDLINES = &h1
const LVS_EX_SUBITEMIMAGES = &h2
const LVS_EX_CHECKBOXES = &h4
const LVS_EX_TRACKSELECT = &h8
const LVS_EX_HEADERDRAGDROP = &h10
const LVS_EX_FULLROWSELECT = &h20
const LVS_EX_ONECLICKACTIVATE = &h40
const LVS_EX_TWOCLICKACTIVATE = &h80
const LVS_EX_FLATSB = &h100
const LVS_EX_REGIONAL = &h200
const LVS_EX_INFOTIP = &h400
const LVS_EX_UNDERLINEHOT = &h800
const LVS_EX_UNDERLINECOLD = &h1000
const LVS_EX_MULTIWORKAREAS = &h2000
const LVS_EX_LABELTIP = &h4000
const LVS_EX_BORDERSELECT = &h8000
const LVS_EX_DOUBLEBUFFER = &h10000
const LVS_EX_HIDELABELS = &h20000
const LVS_EX_SINGLEROW = &h40000
const LVS_EX_SNAPTOGRID = &h80000
const LVS_EX_SIMPLESELECT = &h100000

#if _WIN32_WINNT >= &h0600
	const LVS_EX_JUSTIFYCOLUMNS = &h200000
	const LVS_EX_TRANSPARENTBKGND = &h400000
	const LVS_EX_TRANSPARENTSHADOWTEXT = &h800000
	const LVS_EX_AUTOAUTOARRANGE = &h1000000
	const LVS_EX_HEADERINALLVIEWS = &h2000000
	const LVS_EX_AUTOCHECKSELECT = &h8000000
	const LVS_EX_AUTOSIZECOLUMNS = &h10000000
	const LVS_EX_COLUMNSNAPPOINTS = &h40000000
	const LVS_EX_COLUMNOVERFLOW = &h80000000
#endif

const LVM_GETSUBITEMRECT = LVM_FIRST + 56
private function ListView_GetSubItemRect(byval hwnd as HWND, byval iItem as long, byval iSubItem as long, byval code as long, byval prc as RECT ptr) as WINBOOL
	if prc then
		prc->top = iSubItem
		prc->left = code
	end if
	function = SNDMSG(hwnd, LVM_GETSUBITEMRECT, cast(WPARAM, iItem), cast(LPARAM, prc))
end function
const LVM_SUBITEMHITTEST = LVM_FIRST + 57
#define ListView_SubItemHitTest(hwnd, plvhti) clng(SNDMSG((hwnd), LVM_SUBITEMHITTEST, 0, cast(LPARAM, cast(LPLVHITTESTINFO, (plvhti)))))
#define ListView_SubItemHitTestEx(hwnd, plvhti) clng(SNDMSG((hwnd), LVM_SUBITEMHITTEST, cast(WPARAM, -1), cast(LPARAM, cast(LPLVHITTESTINFO, (plvhti)))))
const LVM_SETCOLUMNORDERARRAY = LVM_FIRST + 58
#define ListView_SetColumnOrderArray(hwnd, iCount, pi) cast(WINBOOL, SNDMSG((hwnd), LVM_SETCOLUMNORDERARRAY, cast(WPARAM, (iCount)), cast(LPARAM, cast(LPINT, (pi)))))
const LVM_GETCOLUMNORDERARRAY = LVM_FIRST + 59
#define ListView_GetColumnOrderArray(hwnd, iCount, pi) cast(WINBOOL, SNDMSG((hwnd), LVM_GETCOLUMNORDERARRAY, cast(WPARAM, (iCount)), cast(LPARAM, cast(LPINT, (pi)))))
const LVM_SETHOTITEM = LVM_FIRST + 60
#define ListView_SetHotItem(hwnd, i) clng(SNDMSG((hwnd), LVM_SETHOTITEM, cast(WPARAM, (i)), 0))
const LVM_GETHOTITEM = LVM_FIRST + 61
#define ListView_GetHotItem(hwnd) clng(SNDMSG((hwnd), LVM_GETHOTITEM, 0, 0))
const LVM_SETHOTCURSOR = LVM_FIRST + 62
#define ListView_SetHotCursor(hwnd, hcur) cast(HCURSOR, SNDMSG((hwnd), LVM_SETHOTCURSOR, 0, cast(LPARAM, (hcur))))
const LVM_GETHOTCURSOR = LVM_FIRST + 63
#define ListView_GetHotCursor(hwnd) cast(HCURSOR, SNDMSG((hwnd), LVM_GETHOTCURSOR, 0, 0))
const LVM_APPROXIMATEVIEWRECT = LVM_FIRST + 64
#define ListView_ApproximateViewRect(hwnd, iWidth, iHeight, iCount) cast(DWORD, SNDMSG((hwnd), LVM_APPROXIMATEVIEWRECT, iCount, MAKELPARAM(iWidth, iHeight)))
const LV_MAX_WORKAREAS = 16
const LVM_SETWORKAREAS = LVM_FIRST + 65
#define ListView_SetWorkAreas(hwnd, nWorkAreas, prc) cast(WINBOOL, SNDMSG((hwnd), LVM_SETWORKAREAS, cast(WPARAM, clng(nWorkAreas)), cast(LPARAM, cptr(RECT ptr, (prc)))))
const LVM_GETWORKAREAS = LVM_FIRST + 70
#define ListView_GetWorkAreas(hwnd, nWorkAreas, prc) cast(WINBOOL, SNDMSG((hwnd), LVM_GETWORKAREAS, cast(WPARAM, clng(nWorkAreas)), cast(LPARAM, cptr(RECT ptr, (prc)))))
const LVM_GETNUMBEROFWORKAREAS = LVM_FIRST + 73
#define ListView_GetNumberOfWorkAreas(hwnd, pnWorkAreas) cast(WINBOOL, SNDMSG((hwnd), LVM_GETNUMBEROFWORKAREAS, 0, cast(LPARAM, cptr(UINT ptr, (pnWorkAreas)))))
const LVM_GETSELECTIONMARK = LVM_FIRST + 66
#define ListView_GetSelectionMark(hwnd) clng(SNDMSG((hwnd), LVM_GETSELECTIONMARK, 0, 0))
const LVM_SETSELECTIONMARK = LVM_FIRST + 67
#define ListView_SetSelectionMark(hwnd, i) clng(SNDMSG((hwnd), LVM_SETSELECTIONMARK, 0, cast(LPARAM, (i))))
const LVM_SETHOVERTIME = LVM_FIRST + 71
#define ListView_SetHoverTime(hwndLV, dwHoverTimeMs) cast(DWORD, SNDMSG((hwndLV), LVM_SETHOVERTIME, 0, cast(LPARAM, (dwHoverTimeMs))))
const LVM_GETHOVERTIME = LVM_FIRST + 72
#define ListView_GetHoverTime(hwndLV) cast(DWORD, SNDMSG((hwndLV), LVM_GETHOVERTIME, 0, 0))
const LVM_SETTOOLTIPS = LVM_FIRST + 74
#define ListView_SetToolTips(hwndLV, hwndNewHwnd) cast(HWND, SNDMSG((hwndLV), LVM_SETTOOLTIPS, cast(WPARAM, (hwndNewHwnd)), 0))
const LVM_GETTOOLTIPS = LVM_FIRST + 78
#define ListView_GetToolTips(hwndLV) cast(HWND, SNDMSG((hwndLV), LVM_GETTOOLTIPS, 0, 0))
const LVM_SORTITEMSEX = LVM_FIRST + 81
#define ListView_SortItemsEx(hwndLV, _pfnCompare, _lPrm) cast(WINBOOL, SNDMSG((hwndLV), LVM_SORTITEMSEX, cast(WPARAM, cast(LPARAM, (_lPrm))), cast(LPARAM, cast(PFNLVCOMPARE, (_pfnCompare)))))

type tagLVBKIMAGEA
	ulFlags as ULONG
	hbm as HBITMAP
	pszImage as LPSTR
	cchImageMax as UINT
	xOffsetPercent as long
	yOffsetPercent as long
end type

type LVBKIMAGEA as tagLVBKIMAGEA
type LPLVBKIMAGEA as tagLVBKIMAGEA ptr

type tagLVBKIMAGEW
	ulFlags as ULONG
	hbm as HBITMAP
	pszImage as LPWSTR
	cchImageMax as UINT
	xOffsetPercent as long
	yOffsetPercent as long
end type

type LVBKIMAGEW as tagLVBKIMAGEW
type LPLVBKIMAGEW as tagLVBKIMAGEW ptr
const LVBKIF_SOURCE_NONE = &h0
const LVBKIF_SOURCE_HBITMAP = &h1
const LVBKIF_SOURCE_URL = &h2
const LVBKIF_SOURCE_MASK = &h3
const LVBKIF_STYLE_NORMAL = &h0
const LVBKIF_STYLE_TILE = &h10
const LVBKIF_STYLE_MASK = &h10
const LVBKIF_FLAG_TILEOFFSET = &h100
const LVBKIF_TYPE_WATERMARK = &h10000000
const LVBKIF_FLAG_ALPHABLEND = &h20000000
const LVM_SETBKIMAGEA = LVM_FIRST + 68
const LVM_SETBKIMAGEW = LVM_FIRST + 138
const LVM_GETBKIMAGEA = LVM_FIRST + 69
const LVM_GETBKIMAGEW = LVM_FIRST + 139
const LVM_SETSELECTEDCOLUMN = LVM_FIRST + 140
#define ListView_SetSelectedColumn(hwnd, iCol) SNDMSG((hwnd), LVM_SETSELECTEDCOLUMN, cast(WPARAM, iCol), 0)
const LVM_SETTILEWIDTH = LVM_FIRST + 141
#define ListView_SetTileWidth(hwnd, cpWidth) SNDMSG((hwnd), LVM_SETTILEWIDTH, cast(WPARAM, cpWidth), 0)
const LV_VIEW_ICON = &h0
const LV_VIEW_DETAILS = &h1
const LV_VIEW_SMALLICON = &h2
const LV_VIEW_LIST = &h3
const LV_VIEW_TILE = &h4
const LV_VIEW_MAX = &h4
const LVM_SETVIEW = LVM_FIRST + 142
#define ListView_SetView(hwnd, iView) cast(DWORD, SNDMSG((hwnd), LVM_SETVIEW, cast(WPARAM, cast(DWORD, iView)), 0))
const LVM_GETVIEW = LVM_FIRST + 143
#define ListView_GetView(hwnd) cast(DWORD, SNDMSG((hwnd), LVM_GETVIEW, 0, 0))
const LVGF_NONE = &h0
const LVGF_HEADER = &h1
const LVGF_FOOTER = &h2
const LVGF_STATE = &h4
const LVGF_ALIGN = &h8
const LVGF_GROUPID = &h10

#if _WIN32_WINNT >= &h0600
	const LVGF_SUBTITLE = &h100
	const LVGF_TASK = &h200
	const LVGF_DESCRIPTIONTOP = &h400
	const LVGF_DESCRIPTIONBOTTOM = &h800
	const LVGF_TITLEIMAGE = &h1000
	const LVGF_EXTENDEDIMAGE = &h2000
	const LVGF_ITEMS = &h4000
	const LVGF_SUBSET = &h00008000
	const LVGF_SUBSETITEMS = &h10000
#endif

const LVGS_NORMAL = &h0
const LVGS_COLLAPSED = &h1
const LVGS_HIDDEN = &h2
const LVGS_NOHEADER = &h4
const LVGS_COLLAPSIBLE = &h8
const LVGS_FOCUSED = &h10
const LVGS_SELECTED = &h20
const LVGS_SUBSETED = &h40
const LVGS_SUBSETLINKFOCUSED = &h80
const LVGA_HEADER_LEFT = &h1
const LVGA_HEADER_CENTER = &h2
const LVGA_HEADER_RIGHT = &h4
const LVGA_FOOTER_LEFT = &h8
const LVGA_FOOTER_CENTER = &h10
const LVGA_FOOTER_RIGHT = &h20

type tagLVGROUP
	cbSize as UINT
	mask as UINT
	pszHeader as LPWSTR
	cchHeader as long
	pszFooter as LPWSTR
	cchFooter as long
	iGroupId as long
	stateMask as UINT
	state as UINT
	uAlign as UINT

	#if _WIN32_WINNT >= &h0600
		pszSubtitle as LPWSTR
		cchSubtitle as UINT
		pszTask as LPWSTR
		cchTask as UINT
		pszDescriptionTop as LPWSTR
		cchDescriptionTop as UINT
		pszDescriptionBottom as LPWSTR
		cchDescriptionBottom as UINT
		iTitleImage as long
		iExtendedImage as long
		iFirstItem as long
		cItems as UINT
		pszSubsetTitle as LPWSTR
		cchSubsetTitle as UINT
	#endif
end type

type LVGROUP as tagLVGROUP
type PLVGROUP as tagLVGROUP ptr

#if _WIN32_WINNT >= &h0600
	#define LVGROUP_V5_SIZE CCSIZEOF_STRUCT(LVGROUP, uAlign)
#endif

const LVM_INSERTGROUP = LVM_FIRST + 145
#define ListView_InsertGroup(hwnd, index, pgrp) SNDMSG((hwnd), LVM_INSERTGROUP, cast(WPARAM, index), cast(LPARAM, pgrp))
const LVM_SETGROUPINFO = LVM_FIRST + 147
#define ListView_SetGroupInfo(hwnd, iGroupId, pgrp) SNDMSG((hwnd), LVM_SETGROUPINFO, cast(WPARAM, iGroupId), cast(LPARAM, pgrp))
const LVM_GETGROUPINFO = LVM_FIRST + 149
#define ListView_GetGroupInfo(hwnd, iGroupId, pgrp) SNDMSG((hwnd), LVM_GETGROUPINFO, cast(WPARAM, iGroupId), cast(LPARAM, pgrp))
const LVM_REMOVEGROUP = LVM_FIRST + 150
#define ListView_RemoveGroup(hwnd, iGroupId) SNDMSG((hwnd), LVM_REMOVEGROUP, cast(WPARAM, iGroupId), 0)
const LVM_MOVEGROUP = LVM_FIRST + 151
#define ListView_MoveGroup(hwnd, iGroupId, toIndex) SNDMSG((hwnd), LVM_MOVEGROUP, cast(WPARAM, iGroupId), cast(LPARAM, toIndex))
const LVM_GETGROUPCOUNT = LVM_FIRST + 152
#define ListView_GetGroupCount(hwnd) SNDMSG((hwnd), LVM_GETGROUPCOUNT, cast(WPARAM, 0), cast(LPARAM, 0))
const LVM_GETGROUPINFOBYINDEX = LVM_FIRST + 153
#define ListView_GetGroupInfoByIndex(hwnd, iIndex, pgrp) SNDMSG((hwnd), LVM_GETGROUPINFOBYINDEX, cast(WPARAM, (iIndex)), cast(LPARAM, (pgrp)))
const LVM_MOVEITEMTOGROUP = LVM_FIRST + 154
#define ListView_MoveItemToGroup(hwnd, idItemFrom, idGroupTo) SNDMSG((hwnd), LVM_MOVEITEMTOGROUP, cast(WPARAM, idItemFrom), cast(LPARAM, idGroupTo))
const LVGGR_GROUP = 0
const LVGGR_HEADER = 1
const LVGGR_LABEL = 2
const LVGGR_SUBSETLINK = 3
const LVM_GETGROUPRECT = LVM_FIRST + 98
private function ListView_GetGroupRect(byval hwnd as HWND, byval iGroupId as long, byval type_ as LONG, byval prc as RECT ptr) as BOOL
	if prc then
		prc->top = type_
	end if
	function = SNDMSG(hwnd, LVM_GETGROUPRECT, cast(WPARAM, iGroupId), cast(LPARAM, prc))
end function
const LVGMF_NONE = &h0
const LVGMF_BORDERSIZE = &h1
const LVGMF_BORDERCOLOR = &h2
const LVGMF_TEXTCOLOR = &h4

type tagLVGROUPMETRICS
	cbSize as UINT
	mask as UINT
	Left as UINT
	Top as UINT
	Right as UINT
	Bottom as UINT
	crLeft as COLORREF
	crTop as COLORREF
	crRight as COLORREF
	crBottom as COLORREF
	crHeader as COLORREF
	crFooter as COLORREF
end type

type LVGROUPMETRICS as tagLVGROUPMETRICS
type PLVGROUPMETRICS as tagLVGROUPMETRICS ptr
const LVM_SETGROUPMETRICS = LVM_FIRST + 155
#define ListView_SetGroupMetrics(hwnd, pGroupMetrics) SNDMSG((hwnd), LVM_SETGROUPMETRICS, 0, cast(LPARAM, pGroupMetrics))
const LVM_GETGROUPMETRICS = LVM_FIRST + 156
#define ListView_GetGroupMetrics(hwnd, pGroupMetrics) SNDMSG((hwnd), LVM_GETGROUPMETRICS, 0, cast(LPARAM, pGroupMetrics))
const LVM_ENABLEGROUPVIEW = LVM_FIRST + 157
#define ListView_EnableGroupView(hwnd, fEnable) SNDMSG((hwnd), LVM_ENABLEGROUPVIEW, cast(WPARAM, fEnable), 0)
type PFNLVGROUPCOMPARE as function(byval as long, byval as long, byval as any ptr) as long
const LVM_SORTGROUPS = LVM_FIRST + 158
#define ListView_SortGroups(hwnd, _pfnGroupCompate, _plv) SNDMSG((hwnd), LVM_SORTGROUPS, cast(WPARAM, _pfnGroupCompate), cast(LPARAM, _plv))

type tagLVINSERTGROUPSORTED
	pfnGroupCompare as PFNLVGROUPCOMPARE
	pvData as any ptr
	lvGroup as LVGROUP
end type

type LVINSERTGROUPSORTED as tagLVINSERTGROUPSORTED
type PLVINSERTGROUPSORTED as tagLVINSERTGROUPSORTED ptr
const LVM_INSERTGROUPSORTED = LVM_FIRST + 159
#define ListView_InsertGroupSorted(hwnd, structInsert) SNDMSG((hwnd), LVM_INSERTGROUPSORTED, cast(WPARAM, structInsert), 0)
const LVM_REMOVEALLGROUPS = LVM_FIRST + 160
#define ListView_RemoveAllGroups(hwnd) SNDMSG((hwnd), LVM_REMOVEALLGROUPS, 0, 0)
const LVM_HASGROUP = LVM_FIRST + 161
#define ListView_HasGroup(hwnd, dwGroupId) SNDMSG((hwnd), LVM_HASGROUP, dwGroupId, 0)
private function ListView_SetGroupState(byval hwnd as HWND, byval dwGroupId as UINT, byval dwMask as UINT, byval dwState as UINT) as LRESULT
	dim as LVGROUP _macro_lvg
	_macro_lvg.cbSize = sizeof(_macro_lvg)
	_macro_lvg.mask = LVGF_STATE
	_macro_lvg.stateMask = dwMask
	_macro_lvg.state = dwState
	function = SNDMSG(hwnd, LVM_SETGROUPINFO, cast(WPARAM, dwGroupId), cast(LPARAM, @_macro_lvg))
end function
const LVM_GETGROUPSTATE = LVM_FIRST + 92
#define ListView_GetGroupState(hwnd, dwGroupId, dwMask) cast(UINT, SNDMSG((hwnd), LVM_GETGROUPSTATE, cast(WPARAM, (dwGroupId)), cast(LPARAM, (dwMask))))
const LVM_GETFOCUSEDGROUP = LVM_FIRST + 93
#define ListView_GetFocusedGroup(hwnd) SNDMSG((hwnd), LVM_GETFOCUSEDGROUP, 0, 0)
const LVTVIF_AUTOSIZE = &h0
const LVTVIF_FIXEDWIDTH = &h1
const LVTVIF_FIXEDHEIGHT = &h2
const LVTVIF_FIXEDSIZE = &h3

#if _WIN32_WINNT >= &h0600
	const LVTVIF_EXTENDED = &h4
#endif

const LVTVIM_TILESIZE = &h1
const LVTVIM_COLUMNS = &h2
const LVTVIM_LABELMARGIN = &h4

type tagLVTILEVIEWINFO
	cbSize as UINT
	dwMask as DWORD
	dwFlags as DWORD
	sizeTile as SIZE
	cLines as long
	rcLabelMargin as RECT
end type

type LVTILEVIEWINFO as tagLVTILEVIEWINFO
type PLVTILEVIEWINFO as tagLVTILEVIEWINFO ptr

type tagLVTILEINFO
	cbSize as UINT
	iItem as long
	cColumns as UINT
	puColumns as PUINT

	#if _WIN32_WINNT >= &h0600
		piColFmt as long ptr
	#endif
end type

type LVTILEINFO as tagLVTILEINFO
type PLVTILEINFO as tagLVTILEINFO ptr
#define LVTILEINFO_V5_SIZE CCSIZEOF_STRUCT(LVTILEINFO, puColumns)
const LVM_SETTILEVIEWINFO = LVM_FIRST + 162
#define ListView_SetTileViewInfo(hwnd, ptvi) SNDMSG((hwnd), LVM_SETTILEVIEWINFO, 0, cast(LPARAM, ptvi))
const LVM_GETTILEVIEWINFO = LVM_FIRST + 163
#define ListView_GetTileViewInfo(hwnd, ptvi) SNDMSG((hwnd), LVM_GETTILEVIEWINFO, 0, cast(LPARAM, ptvi))
const LVM_SETTILEINFO = LVM_FIRST + 164
#define ListView_SetTileInfo(hwnd, pti) SNDMSG((hwnd), LVM_SETTILEINFO, 0, cast(LPARAM, pti))
const LVM_GETTILEINFO = LVM_FIRST + 165
#define ListView_GetTileInfo(hwnd, pti) SNDMSG((hwnd), LVM_GETTILEINFO, 0, cast(LPARAM, pti))

type LVINSERTMARK
	cbSize as UINT
	dwFlags as DWORD
	iItem as long
	dwReserved as DWORD
end type

type LPLVINSERTMARK as LVINSERTMARK ptr
const LVIM_AFTER = &h1
const LVM_SETINSERTMARK = LVM_FIRST + 166
#define ListView_SetInsertMark(hwnd, lvim) cast(WINBOOL, SNDMSG((hwnd), LVM_SETINSERTMARK, cast(WPARAM, 0), cast(LPARAM, (lvim))))
const LVM_GETINSERTMARK = LVM_FIRST + 167
#define ListView_GetInsertMark(hwnd, lvim) cast(WINBOOL, SNDMSG((hwnd), LVM_GETINSERTMARK, cast(WPARAM, 0), cast(LPARAM, (lvim))))
const LVM_INSERTMARKHITTEST = LVM_FIRST + 168
#define ListView_InsertMarkHitTest(hwnd, point, lvim) clng(SNDMSG((hwnd), LVM_INSERTMARKHITTEST, cast(WPARAM, cast(LPPOINT, (point))), cast(LPARAM, cast(LPLVINSERTMARK, (lvim)))))
const LVM_GETINSERTMARKRECT = LVM_FIRST + 169
#define ListView_GetInsertMarkRect(hwnd, rc) clng(SNDMSG((hwnd), LVM_GETINSERTMARKRECT, cast(WPARAM, 0), cast(LPARAM, cast(LPRECT, (rc)))))
const LVM_SETINSERTMARKCOLOR = LVM_FIRST + 170
#define ListView_SetInsertMarkColor(hwnd, color) cast(COLORREF, SNDMSG((hwnd), LVM_SETINSERTMARKCOLOR, cast(WPARAM, 0), cast(LPARAM, cast(COLORREF, (color)))))
const LVM_GETINSERTMARKCOLOR = LVM_FIRST + 171
#define ListView_GetInsertMarkColor(hwnd) cast(COLORREF, SNDMSG((hwnd), LVM_GETINSERTMARKCOLOR, cast(WPARAM, 0), cast(LPARAM, 0)))

type tagLVSETINFOTIP
	cbSize as UINT
	dwFlags as DWORD
	pszText as LPWSTR
	iItem as long
	iSubItem as long
end type

type LVSETINFOTIP as tagLVSETINFOTIP
type PLVSETINFOTIP as tagLVSETINFOTIP ptr
const LVM_SETINFOTIP = LVM_FIRST + 173
#define ListView_SetInfoTip(hwndLV, plvInfoTip) cast(WINBOOL, SNDMSG((hwndLV), LVM_SETINFOTIP, cast(WPARAM, 0), cast(LPARAM, plvInfoTip)))
const LVM_GETSELECTEDCOLUMN = LVM_FIRST + 174
#define ListView_GetSelectedColumn(hwnd) cast(UINT, SNDMSG((hwnd), LVM_GETSELECTEDCOLUMN, 0, 0))
const LVM_ISGROUPVIEWENABLED = LVM_FIRST + 175
#define ListView_IsGroupViewEnabled(hwnd) cast(WINBOOL, SNDMSG((hwnd), LVM_ISGROUPVIEWENABLED, 0, 0))
const LVM_GETOUTLINECOLOR = LVM_FIRST + 176
#define ListView_GetOutlineColor(hwnd) cast(COLORREF, SNDMSG((hwnd), LVM_GETOUTLINECOLOR, 0, 0))
const LVM_SETOUTLINECOLOR = LVM_FIRST + 177
#define ListView_SetOutlineColor(hwnd, color) cast(COLORREF, SNDMSG((hwnd), LVM_SETOUTLINECOLOR, cast(WPARAM, 0), cast(LPARAM, cast(COLORREF, (color)))))
const LVM_CANCELEDITLABEL = LVM_FIRST + 179
#define ListView_CancelEditLabel(hwnd) SNDMSG((hwnd), LVM_CANCELEDITLABEL, 0, 0)
const LVM_MAPINDEXTOID = LVM_FIRST + 180
#define ListView_MapIndexToID(hwnd, index) cast(UINT, SNDMSG((hwnd), LVM_MAPINDEXTOID, cast(WPARAM, index), cast(LPARAM, 0)))
const LVM_MAPIDTOINDEX = LVM_FIRST + 181
#define ListView_MapIDToIndex(hwnd, id) cast(UINT, SNDMSG((hwnd), LVM_MAPIDTOINDEX, cast(WPARAM, id), cast(LPARAM, 0)))
const LVM_ISITEMVISIBLE = LVM_FIRST + 182
#define ListView_IsItemVisible(hwnd, index) cast(UINT, SNDMSG((hwnd), LVM_ISITEMVISIBLE, cast(WPARAM, (index)), cast(LPARAM, 0)))

#if _WIN32_WINNT >= &h0600
	#define ListView_SetGroupHeaderImageList(hwnd, himl) cast(HIMAGELIST, SNDMSG((hwnd), LVM_SETIMAGELIST, cast(WPARAM, LVSIL_GROUPHEADER), cast(LPARAM, cast(HIMAGELIST, (himl)))))
	#define ListView_GetGroupHeaderImageList(hwnd) cast(HIMAGELIST, SNDMSG((hwnd), LVM_GETIMAGELIST, cast(WPARAM, LVSIL_GROUPHEADER), 0))
	const LVM_GETEMPTYTEXT = LVM_FIRST + 204
	#define ListView_GetEmptyText(hwnd, pszText, cchText) cast(WINBOOL, SNDMSG((hwnd), LVM_GETEMPTYTEXT, cast(WPARAM, (cchText)), cast(LPARAM, (pszText))))
	const LVM_GETFOOTERRECT = LVM_FIRST + 205
	#define ListView_GetFooterRect(hwnd, prc) cast(WINBOOL, SNDMSG((hwnd), LVM_GETFOOTERRECT, cast(WPARAM, 0), cast(LPARAM, (prc))))
	const LVFF_ITEMCOUNT = &h1

	type tagLVFOOTERINFO
		mask as UINT
		pszText as LPWSTR
		cchTextMax as long
		cItems as UINT
	end type

	type LVFOOTERINFO as tagLVFOOTERINFO
	type LPLVFOOTERINFO as tagLVFOOTERINFO ptr
	const LVM_GETFOOTERINFO = LVM_FIRST + 206
	#define ListView_GetFooterInfo(hwnd, plvfi) cast(WINBOOL, SNDMSG((hwnd), LVM_GETFOOTERINFO, cast(WPARAM, 0), cast(LPARAM, (plvfi))))
	const LVM_GETFOOTERITEMRECT = LVM_FIRST + 207
	#define ListView_GetFooterItemRect(hwnd, iItem, prc) cast(WINBOOL, SNDMSG((hwnd), LVM_GETFOOTERITEMRECT, cast(WPARAM, (iItem)), cast(LPARAM, (prc))))
	const LVFIF_TEXT = &h1
	const LVFIF_STATE = &h2
	const LVFIS_FOCUSED = &h1

	type tagLVFOOTERITEM
		mask as UINT
		iItem as long
		pszText as LPWSTR
		cchTextMax as long
		state as UINT
		stateMask as UINT
	end type

	type LVFOOTERITEM as tagLVFOOTERITEM
	type LPLVFOOTERITEM as tagLVFOOTERITEM ptr
	const LVM_GETFOOTERITEM = LVM_FIRST + 208
	#define ListView_GetFooterItem(hwnd, iItem, pfi) cast(WINBOOL, SNDMSG((hwnd), LVM_GETFOOTERITEM, cast(WPARAM, (iItem)), cast(LPARAM, (pfi))))

	type tagLVITEMINDEX
		iItem as long
		iGroup as long
	end type

	type LVITEMINDEX as tagLVITEMINDEX
	type PLVITEMINDEX as tagLVITEMINDEX ptr
	const LVM_GETITEMINDEXRECT = LVM_FIRST + 209
	private function ListView_GetItemIndexRect(byval hwnd as HWND, byval plvii as LVITEMINDEX ptr, byval iSubItem as long, byval code as long, byval prc as LPRECT) as WINBOOL
		if prc then
			prc->top = iSubItem
			prc->left = code
		end if
		function = SNDMSG(hwnd, LVM_GETITEMINDEXRECT, cast(WPARAM, plvii), cast(LPARAM, prc))
	end function
	const LVM_SETITEMINDEXSTATE = LVM_FIRST + 210
	private function ListView_SetItemIndexState(byval hwndLV as HWND, byval plvii as LVITEMINDEX ptr, byval data_ as UINT, byval mask as UINT) as HRESULT
		dim as LV_ITEM _macro_lvi
		_macro_lvi.stateMask = mask
		_macro_lvi.state = data_
		function = SNDMSG(hwndLV, LVM_SETITEMINDEXSTATE, cast(WPARAM, plvii), cast(LPARAM, @_macro_lvi))
	end function
	const LVM_GETNEXTITEMINDEX = LVM_FIRST + 211
	#define ListView_GetNextItemIndex(hwnd, plvii, flags) cast(WINBOOL, SNDMSG((hwnd), LVM_GETNEXTITEMINDEX, cast(WPARAM, cptr(LVITEMINDEX ptr, (plvii))), MAKELPARAM((flags), 0)))
#endif

#ifdef UNICODE
	type LVBKIMAGE as LVBKIMAGEW
	type LPLVBKIMAGE as LPLVBKIMAGEW
	const LVM_SETBKIMAGE = LVM_SETBKIMAGEW
	const LVM_GETBKIMAGE = LVM_GETBKIMAGEW
#else
	type LVBKIMAGE as LVBKIMAGEA
	type LPLVBKIMAGE as LPLVBKIMAGEA
	const LVM_SETBKIMAGE = LVM_SETBKIMAGEA
	const LVM_GETBKIMAGE = LVM_GETBKIMAGEA
#endif

#define ListView_SetBkImage(hwnd, plvbki) cast(WINBOOL, SNDMSG((hwnd), LVM_SETBKIMAGE, 0, cast(LPARAM, (plvbki))))
#define ListView_GetBkImage(hwnd, plvbki) cast(WINBOOL, SNDMSG((hwnd), LVM_GETBKIMAGE, 0, cast(LPARAM, (plvbki))))
type LPNM_LISTVIEW as LPNMLISTVIEW
type NM_LISTVIEW as NMLISTVIEW

type tagNMLISTVIEW
	hdr as NMHDR
	iItem as long
	iSubItem as long
	uNewState as UINT
	uOldState as UINT
	uChanged as UINT
	ptAction as POINT
	lParam as LPARAM
end type

type NMLISTVIEW as tagNMLISTVIEW
type LPNMLISTVIEW as tagNMLISTVIEW ptr

type tagNMITEMACTIVATE
	hdr as NMHDR
	iItem as long
	iSubItem as long
	uNewState as UINT
	uOldState as UINT
	uChanged as UINT
	ptAction as POINT
	lParam as LPARAM
	uKeyFlags as UINT
end type

type NMITEMACTIVATE as tagNMITEMACTIVATE
type LPNMITEMACTIVATE as tagNMITEMACTIVATE ptr
const LVKF_ALT = &h1
const LVKF_CONTROL = &h2
const LVKF_SHIFT = &h4
#define NMLVCUSTOMDRAW_V3_SIZE CCSIZEOF_STRUCT(NMLVCUSTOMDRW, clrTextBk)

type tagNMLVCUSTOMDRAW
	nmcd as NMCUSTOMDRAW
	clrText as COLORREF
	clrTextBk as COLORREF
	iSubItem as long
	dwItemType as DWORD
	clrFace as COLORREF
	iIconEffect as long
	iIconPhase as long
	iPartId as long
	iStateId as long
	rcText as RECT
	uAlign as UINT
end type

type NMLVCUSTOMDRAW as tagNMLVCUSTOMDRAW
type LPNMLVCUSTOMDRAW as tagNMLVCUSTOMDRAW ptr
const LVCDI_ITEM = &h0
const LVCDI_GROUP = &h1
const LVCDI_ITEMSLIST = &h2
const LVCDRF_NOSELECT = &h10000
const LVCDRF_NOGROUPFRAME = &h20000

type tagNMLVCACHEHINT
	hdr as NMHDR
	iFrom as long
	iTo as long
end type

type NMLVCACHEHINT as tagNMLVCACHEHINT
type LPNMLVCACHEHINT as tagNMLVCACHEHINT ptr
type LPNM_CACHEHINT as LPNMLVCACHEHINT
type PNM_CACHEHINT as LPNMLVCACHEHINT
type NM_CACHEHINT as NMLVCACHEHINT

type tagNMLVFINDITEMA
	hdr as NMHDR
	iStart as long
	lvfi as LVFINDINFOA
end type

type NMLVFINDITEMA as tagNMLVFINDITEMA
type LPNMLVFINDITEMA as tagNMLVFINDITEMA ptr

type tagNMLVFINDITEMW
	hdr as NMHDR
	iStart as long
	lvfi as LVFINDINFOW
end type

type NMLVFINDITEMW as tagNMLVFINDITEMW
type LPNMLVFINDITEMW as tagNMLVFINDITEMW ptr
type PNM_FINDITEMA as LPNMLVFINDITEMA
type LPNM_FINDITEMA as LPNMLVFINDITEMA
type NM_FINDITEMA as NMLVFINDITEMA
type PNM_FINDITEMW as LPNMLVFINDITEMW
type LPNM_FINDITEMW as LPNMLVFINDITEMW
type NM_FINDITEMW as NMLVFINDITEMW

#ifdef UNICODE
	type PNM_FINDITEM as PNM_FINDITEMW
	type LPNM_FINDITEM as LPNM_FINDITEMW
	type NM_FINDITEM as NM_FINDITEMW
	type NMLVFINDITEM as NMLVFINDITEMW
	type LPNMLVFINDITEM as LPNMLVFINDITEMW
#else
	type PNM_FINDITEM as PNM_FINDITEMA
	type LPNM_FINDITEM as LPNM_FINDITEMA
	type NM_FINDITEM as NM_FINDITEMA
	type NMLVFINDITEM as NMLVFINDITEMA
	type LPNMLVFINDITEM as LPNMLVFINDITEMA
#endif

type tagNMLVODSTATECHANGE
	hdr as NMHDR
	iFrom as long
	iTo as long
	uNewState as UINT
	uOldState as UINT
end type

type NMLVODSTATECHANGE as tagNMLVODSTATECHANGE
type LPNMLVODSTATECHANGE as tagNMLVODSTATECHANGE ptr
type PNM_ODSTATECHANGE as LPNMLVODSTATECHANGE
type LPNM_ODSTATECHANGE as LPNMLVODSTATECHANGE
type NM_ODSTATECHANGE as NMLVODSTATECHANGE

const LVN_ITEMCHANGING = culng(LVN_FIRST - 0)
const LVN_ITEMCHANGED = culng(LVN_FIRST - 1)
const LVN_INSERTITEM = culng(LVN_FIRST - 2)
const LVN_DELETEITEM = culng(LVN_FIRST - 3)
const LVN_DELETEALLITEMS = culng(LVN_FIRST - 4)
const LVN_BEGINLABELEDITA = culng(LVN_FIRST - 5)
const LVN_BEGINLABELEDITW = culng(LVN_FIRST - 75)
const LVN_ENDLABELEDITA = culng(LVN_FIRST - 6)
const LVN_ENDLABELEDITW = culng(LVN_FIRST - 76)
const LVN_COLUMNCLICK = culng(LVN_FIRST - 8)
const LVN_BEGINDRAG = culng(LVN_FIRST - 9)
const LVN_BEGINRDRAG = culng(LVN_FIRST - 11)
const LVN_ODCACHEHINT = culng(LVN_FIRST - 13)
const LVN_ODFINDITEMA = culng(LVN_FIRST - 52)
const LVN_ODFINDITEMW = culng(LVN_FIRST - 79)
const LVN_ITEMACTIVATE = culng(LVN_FIRST - 14)
const LVN_ODSTATECHANGED = culng(LVN_FIRST - 15)

#ifdef UNICODE
	const LVN_ODFINDITEM = LVN_ODFINDITEMW
#else
	const LVN_ODFINDITEM = LVN_ODFINDITEMA
#endif

const LVN_HOTTRACK = culng(LVN_FIRST - 21)
const LVN_GETDISPINFOA = culng(LVN_FIRST - 50)
const LVN_GETDISPINFOW = culng(LVN_FIRST - 77)
const LVN_SETDISPINFOA = culng(LVN_FIRST - 51)
const LVN_SETDISPINFOW = culng(LVN_FIRST - 78)

#ifdef UNICODE
	const LVN_BEGINLABELEDIT = LVN_BEGINLABELEDITW
	const LVN_ENDLABELEDIT = LVN_ENDLABELEDITW
	const LVN_GETDISPINFO = LVN_GETDISPINFOW
	const LVN_SETDISPINFO = LVN_SETDISPINFOW
#else
	const LVN_BEGINLABELEDIT = LVN_BEGINLABELEDITA
	const LVN_ENDLABELEDIT = LVN_ENDLABELEDITA
	const LVN_GETDISPINFO = LVN_GETDISPINFOA
	const LVN_SETDISPINFO = LVN_SETDISPINFOA
#endif

const LVIF_DI_SETITEM = &h1000
type LV_DISPINFOA as NMLVDISPINFOA
type LV_DISPINFOW as NMLVDISPINFOW

type tagLVDISPINFO
	hdr as NMHDR
	item as LVITEMA
end type

type NMLVDISPINFOA as tagLVDISPINFO
type LPNMLVDISPINFOA as tagLVDISPINFO ptr

type tagLVDISPINFOW
	hdr as NMHDR
	item as LVITEMW
end type

type NMLVDISPINFOW as tagLVDISPINFOW
type LPNMLVDISPINFOW as tagLVDISPINFOW ptr

#ifdef UNICODE
	type NMLVDISPINFO as NMLVDISPINFOW
#else
	type NMLVDISPINFO as NMLVDISPINFOA
#endif

type LV_DISPINFO as NMLVDISPINFO
const LVN_KEYDOWN = culng(LVN_FIRST - 55)
type LV_KEYDOWN as NMLVKEYDOWN

type tagLVKEYDOWN field = 1
	hdr as NMHDR
	wVKey as WORD
	flags as UINT
end type

type NMLVKEYDOWN as tagLVKEYDOWN
type LPNMLVKEYDOWN as tagLVKEYDOWN ptr
const LVN_MARQUEEBEGIN = culng(LVN_FIRST - 56)

#if _WIN32_WINNT >= &h0600
	type tagNMLVLINK
		hdr as NMHDR
		link as LITEM
		iItem as long
		iSubItem as long
	end type

	type NMLVLINK as tagNMLVLINK
	type PNMLVLINK as tagNMLVLINK ptr
#endif

type tagNMLVGETINFOTIPA
	hdr as NMHDR
	dwFlags as DWORD
	pszText as LPSTR
	cchTextMax as long
	iItem as long
	iSubItem as long
	lParam as LPARAM
end type

type NMLVGETINFOTIPA as tagNMLVGETINFOTIPA
type LPNMLVGETINFOTIPA as tagNMLVGETINFOTIPA ptr

type tagNMLVGETINFOTIPW
	hdr as NMHDR
	dwFlags as DWORD
	pszText as LPWSTR
	cchTextMax as long
	iItem as long
	iSubItem as long
	lParam as LPARAM
end type

type NMLVGETINFOTIPW as tagNMLVGETINFOTIPW
type LPNMLVGETINFOTIPW as tagNMLVGETINFOTIPW ptr
const LVGIT_UNFOLDED = &h1
const LVN_GETINFOTIPA = culng(LVN_FIRST - 57)
const LVN_GETINFOTIPW = culng(LVN_FIRST - 58)

#ifdef UNICODE
	const LVN_GETINFOTIP = LVN_GETINFOTIPW
	type NMLVGETINFOTIP as NMLVGETINFOTIPW
	type LPNMLVGETINFOTIP as LPNMLVGETINFOTIPW
#else
	const LVN_GETINFOTIP = LVN_GETINFOTIPA
	type NMLVGETINFOTIP as NMLVGETINFOTIPA
	type LPNMLVGETINFOTIP as LPNMLVGETINFOTIPA
#endif

const LVNSCH_DEFAULT = -1
const LVNSCH_ERROR = -2
const LVNSCH_IGNORE = -3
const LVN_INCREMENTALSEARCHA = culng(LVN_FIRST - 62)
const LVN_INCREMENTALSEARCHW = culng(LVN_FIRST - 63)

#ifdef UNICODE
	const LVN_INCREMENTALSEARCH = LVN_INCREMENTALSEARCHW
#elseif (not defined(UNICODE)) and (_WIN32_WINNT >= &h0600)
	const LVN_INCREMENTALSEARCH = LVN_INCREMENTALSEARCHA
#endif

#if _WIN32_WINNT >= &h0600
	const LVN_COLUMNDROPDOWN = culng(LVN_FIRST - 64)
	const LVN_COLUMNOVERFLOWCLICK = culng(LVN_FIRST - 66)
#elseif (not defined(UNICODE)) and (_WIN32_WINNT <= &h0502)
	const LVN_INCREMENTALSEARCH = LVN_INCREMENTALSEARCHA
#endif

type tagNMLVSCROLL
	hdr as NMHDR
	dx as long
	dy as long
end type

type NMLVSCROLL as tagNMLVSCROLL
type LPNMLVSCROLL as tagNMLVSCROLL ptr
const LVN_BEGINSCROLL = culng(LVN_FIRST - 80)
const LVN_ENDSCROLL = culng(LVN_FIRST - 81)

#if _WIN32_WINNT >= &h0600
	const LVN_LINKCLICK = culng(LVN_FIRST - 84)
	const EMF_CENTERED = &h1

	type tagNMLVEMPTYMARKUP
		hdr as NMHDR
		dwFlags as DWORD
		szMarkup as wstring * (2048 + 32) + sizeof("://")
	end type

	type NMLVEMPTYMARKUP as tagNMLVEMPTYMARKUP
	const LVN_GETEMPTYMARKUP = culng(LVN_FIRST - 87)
#endif

#define WC_TREEVIEWA "SysTreeView32"
#define WC_TREEVIEWW wstr("SysTreeView32")

#ifdef UNICODE
	#define WC_TREEVIEW WC_TREEVIEWW
#else
	#define WC_TREEVIEW WC_TREEVIEWA
#endif

const TVS_HASBUTTONS = &h1
const TVS_HASLINES = &h2
const TVS_LINESATROOT = &h4
const TVS_EDITLABELS = &h8
const TVS_DISABLEDRAGDROP = &h10
const TVS_SHOWSELALWAYS = &h20
const TVS_RTLREADING = &h40
const TVS_NOTOOLTIPS = &h80
const TVS_CHECKBOXES = &h100
const TVS_TRACKSELECT = &h200
const TVS_SINGLEEXPAND = &h400
const TVS_INFOTIP = &h800
const TVS_FULLROWSELECT = &h1000
const TVS_NOSCROLL = &h2000
const TVS_NONEVENHEIGHT = &h4000
const TVS_NOHSCROLL = &h8000
const TVS_EX_NOSINGLECOLLAPSE = &h1

#if _WIN32_WINNT >= &h0600
	const TVS_EX_MULTISELECT = &h2
	const TVS_EX_DOUBLEBUFFER = &h4
	const TVS_EX_NOINDENTSTATE = &h8
	const TVS_EX_RICHTOOLTIP = &h10
	const TVS_EX_AUTOHSCROLL = &h20
	const TVS_EX_FADEINOUTEXPANDOS = &h40
	const TVS_EX_PARTIALCHECKBOXES = &h80
	const TVS_EX_EXCLUSIONCHECKBOXES = &h100
	const TVS_EX_DIMMEDCHECKBOXES = &h200
	const TVS_EX_DRAWIMAGEASYNC = &h400
#endif

type HTREEITEM as _TREEITEM ptr
const TVIF_TEXT = &h1
const TVIF_IMAGE = &h2
const TVIF_PARAM = &h4
const TVIF_STATE = &h8
const TVIF_HANDLE = &h10
const TVIF_SELECTEDIMAGE = &h20
const TVIF_CHILDREN = &h40
const TVIF_INTEGRAL = &h80

#if _WIN32_WINNT >= &h0501
	const TVIF_STATEEX = &h100
	const TVIF_EXPANDEDIMAGE = &h200
#endif

const TVIS_SELECTED = &h2
const TVIS_CUT = &h4
const TVIS_DROPHILITED = &h8
const TVIS_BOLD = &h10
const TVIS_EXPANDED = &h20
const TVIS_EXPANDEDONCE = &h40
const TVIS_EXPANDPARTIAL = &h80
const TVIS_OVERLAYMASK = &hf00
const TVIS_STATEIMAGEMASK = &hF000
const TVIS_USERMASK = &hF000

#if _WIN32_WINNT >= &h0501
	const TVIS_EX_FLAT = &h1
#endif

#if _WIN32_WINNT >= &h0600
	const TVIS_EX_DISABLED = &h2
#endif

#if _WIN32_WINNT >= &h0501
	const TVIS_EX_ALL = &h0002

	type tagNMTVSTATEIMAGECHANGING
		hdr as NMHDR
		hti as HTREEITEM
		iOldStateImageIndex as long
		iNewStateImageIndex as long
	end type

	type NMTVSTATEIMAGECHANGING as tagNMTVSTATEIMAGECHANGING
	type LPNMTVSTATEIMAGECHANGING as tagNMTVSTATEIMAGECHANGING ptr
#endif

const I_CHILDRENCALLBACK = -1
const I_CHILDRENAUTO = -2
type LPTV_ITEMW as LPTVITEMW
type LPTV_ITEMA as LPTVITEMA
type TV_ITEMW as TVITEMW
type TV_ITEMA as TVITEMA
type TV_ITEM as TVITEM

type tagTVITEMA
	mask as UINT
	hItem as HTREEITEM
	state as UINT
	stateMask as UINT
	pszText as LPSTR
	cchTextMax as long
	iImage as long
	iSelectedImage as long
	cChildren as long
	lParam as LPARAM
end type

type TVITEMA as tagTVITEMA
type LPTVITEMA as tagTVITEMA ptr

type tagTVITEMW
	mask as UINT
	hItem as HTREEITEM
	state as UINT
	stateMask as UINT
	pszText as LPWSTR
	cchTextMax as long
	iImage as long
	iSelectedImage as long
	cChildren as long
	lParam as LPARAM
end type

type TVITEMW as tagTVITEMW
type LPTVITEMW as tagTVITEMW ptr

type tagTVITEMEXA
	mask as UINT
	hItem as HTREEITEM
	state as UINT
	stateMask as UINT
	pszText as LPSTR
	cchTextMax as long
	iImage as long
	iSelectedImage as long
	cChildren as long
	lParam as LPARAM
	iIntegral as long

	#if _WIN32_WINNT >= &h0501
		uStateEx as UINT
		hwnd as HWND
		iExpandedImage as long
	#endif

	#if _WIN32_WINNT >= &h0601
		iReserved as long
	#endif
end type

type TVITEMEXA as tagTVITEMEXA
type LPTVITEMEXA as tagTVITEMEXA ptr

type tagTVITEMEXW
	mask as UINT
	hItem as HTREEITEM
	state as UINT
	stateMask as UINT
	pszText as LPWSTR
	cchTextMax as long
	iImage as long
	iSelectedImage as long
	cChildren as long
	lParam as LPARAM
	iIntegral as long

	#if _WIN32_WINNT >= &h0501
		uStateEx as UINT
		hwnd as HWND
		iExpandedImage as long
	#endif

	#if _WIN32_WINNT >= &h0601
		iReserved as long
	#endif
end type

type TVITEMEXW as tagTVITEMEXW
type LPTVITEMEXW as tagTVITEMEXW ptr

#ifdef UNICODE
	type TVITEMEX as TVITEMEXW
	type LPTVITEMEX as LPTVITEMEXW
	type TVITEM as TVITEMW
	type LPTVITEM as LPTVITEMW
#else
	type TVITEMEX as TVITEMEXA
	type LPTVITEMEX as LPTVITEMEXA
	type TVITEM as TVITEMA
	type LPTVITEM as LPTVITEMA
#endif

type LPTV_ITEM as LPTVITEM
const TVI_ROOT = cast(HTREEITEM, cast(ULONG_PTR, -&h10000))
const TVI_FIRST = cast(HTREEITEM, cast(ULONG_PTR, -&hffff))
const TVI_LAST = cast(HTREEITEM, cast(ULONG_PTR, -&hfffe))
const TVI_SORT = cast(HTREEITEM, cast(ULONG_PTR, -&hfffd))

type LPTV_INSERTSTRUCTA as LPTVINSERTSTRUCTA
type LPTV_INSERTSTRUCTW as LPTVINSERTSTRUCTW
type TV_INSERTSTRUCTA as TVINSERTSTRUCTA
type TV_INSERTSTRUCTW as TVINSERTSTRUCTW
#define TVINSERTSTRUCTA_V1_SIZE CCSIZEOF_STRUCT(TVINSERTSTRUCTA, item)
#define TVINSERTSTRUCTW_V1_SIZE CCSIZEOF_STRUCT(TVINSERTSTRUCTW, item)

type tagTVINSERTSTRUCTA
	hParent as HTREEITEM
	hInsertAfter as HTREEITEM

	union
		itemex as TVITEMEXA
		item as TVITEMA
	end union
end type

type TVINSERTSTRUCTA as tagTVINSERTSTRUCTA
type LPTVINSERTSTRUCTA as tagTVINSERTSTRUCTA ptr

type tagTVINSERTSTRUCTW
	hParent as HTREEITEM
	hInsertAfter as HTREEITEM

	union
		itemex as TVITEMEXW
		item as TVITEMW
	end union
end type

type TVINSERTSTRUCTW as tagTVINSERTSTRUCTW
type LPTVINSERTSTRUCTW as tagTVINSERTSTRUCTW ptr

#ifdef UNICODE
	type TVINSERTSTRUCT as TVINSERTSTRUCTW
#else
	type TVINSERTSTRUCT as TVINSERTSTRUCTA
#endif

type TV_INSERTSTRUCT as TVINSERTSTRUCT

#ifdef UNICODE
	type LPTVINSERTSTRUCT as LPTVINSERTSTRUCTW
#else
	type LPTVINSERTSTRUCT as LPTVINSERTSTRUCTA
#endif

type LPTV_INSERTSTRUCT as LPTVINSERTSTRUCT

#ifdef UNICODE
	#define TVINSERTSTRUCT_V1_SIZE TVINSERTSTRUCTW_V1_SIZE
#else
	#define TVINSERTSTRUCT_V1_SIZE TVINSERTSTRUCTA_V1_SIZE
#endif

const TVM_INSERTITEMA = TV_FIRST + 0
const TVM_INSERTITEMW = TV_FIRST + 50

#ifdef UNICODE
	const TVM_INSERTITEM = TVM_INSERTITEMW
#else
	const TVM_INSERTITEM = TVM_INSERTITEMA
#endif

#define TreeView_InsertItem(hwnd, lpis) cast(HTREEITEM, SNDMSG((hwnd), TVM_INSERTITEM, 0, cast(LPARAM, cast(LPTV_INSERTSTRUCT, (lpis)))))
const TVM_DELETEITEM = TV_FIRST + 1
#define TreeView_DeleteItem(hwnd, hitem) cast(WINBOOL, SNDMSG((hwnd), TVM_DELETEITEM, 0, cast(LPARAM, cast(HTREEITEM, (hitem)))))
#define TreeView_DeleteAllItems(hwnd) cast(WINBOOL, SNDMSG((hwnd), TVM_DELETEITEM, 0, cast(LPARAM, TVI_ROOT)))
const TVM_EXPAND = TV_FIRST + 2
#define TreeView_Expand(hwnd, hitem, code) cast(WINBOOL, SNDMSG((hwnd), TVM_EXPAND, cast(WPARAM, (code)), cast(LPARAM, cast(HTREEITEM, (hitem)))))
const TVE_COLLAPSE = &h1
const TVE_EXPAND = &h2
const TVE_TOGGLE = &h3
const TVE_EXPANDPARTIAL = &h4000
const TVE_COLLAPSERESET = &h8000
const TVM_GETITEMRECT = TV_FIRST + 4
private function TreeView_GetItemRect(byval hwnd as HWND, byval hitem as HTREEITEM, byval prc as RECT ptr, byval code as long) as WINBOOL
	*cptr(HTREEITEM ptr, prc) = hitem
	function = SNDMSG(hwnd, TVM_GETITEMRECT, cast(WPARAM, code), cast(LPARAM, prc))
end function
const TVM_GETCOUNT = TV_FIRST + 5
#define TreeView_GetCount(hwnd) cast(UINT, SNDMSG((hwnd), TVM_GETCOUNT, 0, 0))
const TVM_GETINDENT = TV_FIRST + 6
#define TreeView_GetIndent(hwnd) cast(UINT, SNDMSG((hwnd), TVM_GETINDENT, 0, 0))
const TVM_SETINDENT = TV_FIRST + 7
#define TreeView_SetIndent(hwnd, indent) cast(WINBOOL, SNDMSG((hwnd), TVM_SETINDENT, cast(WPARAM, (indent)), 0))
const TVM_GETIMAGELIST = TV_FIRST + 8
#define TreeView_GetImageList(hwnd, iImage) cast(HIMAGELIST, SNDMSG((hwnd), TVM_GETIMAGELIST, iImage, 0))
const TVSIL_NORMAL = 0
const TVSIL_STATE = 2
const TVM_SETIMAGELIST = TV_FIRST + 9
#define TreeView_SetImageList(hwnd, himl, iImage) cast(HIMAGELIST, SNDMSG((hwnd), TVM_SETIMAGELIST, iImage, cast(LPARAM, cast(HIMAGELIST, (himl)))))
const TVM_GETNEXTITEM = TV_FIRST + 10
#define TreeView_GetNextItem(hwnd, hitem, code) cast(HTREEITEM, SNDMSG((hwnd), TVM_GETNEXTITEM, cast(WPARAM, (code)), cast(LPARAM, cast(HTREEITEM, (hitem)))))
const TVGN_ROOT = &h0
const TVGN_NEXT = &h1
const TVGN_PREVIOUS = &h2
const TVGN_PARENT = &h3
const TVGN_CHILD = &h4
const TVGN_FIRSTVISIBLE = &h5
const TVGN_NEXTVISIBLE = &h6
const TVGN_PREVIOUSVISIBLE = &h7
const TVGN_DROPHILITE = &h8
const TVGN_CARET = &h9
const TVGN_LASTVISIBLE = &ha

#if _WIN32_WINNT >= &h0501
	const TVGN_NEXTSELECTED = &hb
#endif

const TVSI_NOSINGLEEXPAND = &h8000
#define TreeView_GetChild(hwnd, hitem) TreeView_GetNextItem(hwnd, hitem, TVGN_CHILD)
#define TreeView_GetNextSibling(hwnd, hitem) TreeView_GetNextItem(hwnd, hitem, TVGN_NEXT)
#define TreeView_GetPrevSibling(hwnd, hitem) TreeView_GetNextItem(hwnd, hitem, TVGN_PREVIOUS)
#define TreeView_GetParent(hwnd, hitem) TreeView_GetNextItem(hwnd, hitem, TVGN_PARENT)
#define TreeView_GetFirstVisible(hwnd) TreeView_GetNextItem(hwnd, NULL, TVGN_FIRSTVISIBLE)
#define TreeView_GetNextVisible(hwnd, hitem) TreeView_GetNextItem(hwnd, hitem, TVGN_NEXTVISIBLE)
#define TreeView_GetPrevVisible(hwnd, hitem) TreeView_GetNextItem(hwnd, hitem, TVGN_PREVIOUSVISIBLE)
#define TreeView_GetSelection(hwnd) TreeView_GetNextItem(hwnd, NULL, TVGN_CARET)
#define TreeView_GetDropHilight(hwnd) TreeView_GetNextItem(hwnd, NULL, TVGN_DROPHILITE)
#define TreeView_GetRoot(hwnd) TreeView_GetNextItem(hwnd, NULL, TVGN_ROOT)
#define TreeView_GetLastVisible(hwnd) TreeView_GetNextItem(hwnd, NULL, TVGN_LASTVISIBLE)

#if _WIN32_WINNT >= &h0501
	#define TreeView_GetNextSelected(hwnd, hitem) TreeView_GetNextItem(hwnd, hitem, TVGN_NEXTSELECTED)
#endif

const TVM_SELECTITEM = TV_FIRST + 11
#define TreeView_Select(hwnd, hitem, code) cast(WINBOOL, SNDMSG((hwnd), TVM_SELECTITEM, cast(WPARAM, (code)), cast(LPARAM, cast(HTREEITEM, (hitem)))))
#define TreeView_SelectItem(hwnd, hitem) TreeView_Select(hwnd, hitem, TVGN_CARET)
#define TreeView_SelectDropTarget(hwnd, hitem) TreeView_Select(hwnd, hitem, TVGN_DROPHILITE)
#define TreeView_SelectSetFirstVisible(hwnd, hitem) TreeView_Select(hwnd, hitem, TVGN_FIRSTVISIBLE)
const TVM_GETITEMA = TV_FIRST + 12
const TVM_GETITEMW = TV_FIRST + 62

#ifdef UNICODE
	const TVM_GETITEM = TVM_GETITEMW
#else
	const TVM_GETITEM = TVM_GETITEMA
#endif

#define TreeView_GetItem(hwnd, pitem) cast(WINBOOL, SNDMSG((hwnd), TVM_GETITEM, 0, cast(LPARAM, cptr(TV_ITEM ptr, (pitem)))))
const TVM_SETITEMA = TV_FIRST + 13
const TVM_SETITEMW = TV_FIRST + 63

#ifdef UNICODE
	const TVM_SETITEM = TVM_SETITEMW
#else
	const TVM_SETITEM = TVM_SETITEMA
#endif

#define TreeView_SetItem(hwnd, pitem) cast(WINBOOL, SNDMSG((hwnd), TVM_SETITEM, 0, cast(LPARAM, cptr(const TV_ITEM ptr, (pitem)))))
const TVM_EDITLABELA = TV_FIRST + 14
const TVM_EDITLABELW = TV_FIRST + 65

#ifdef UNICODE
	const TVM_EDITLABEL = TVM_EDITLABELW
#else
	const TVM_EDITLABEL = TVM_EDITLABELA
#endif

#define TreeView_EditLabel(hwnd_, hitem) cast(HWND, SNDMSG((hwnd_), TVM_EDITLABEL, 0, cast(LPARAM, cast(HTREEITEM, (hitem)))))
const TVM_GETEDITCONTROL = TV_FIRST + 15
#define TreeView_GetEditControl(hwnd_) cast(HWND, SNDMSG((hwnd_), TVM_GETEDITCONTROL, 0, 0))
const TVM_GETVISIBLECOUNT = TV_FIRST + 16
#define TreeView_GetVisibleCount(hwnd) cast(UINT, SNDMSG((hwnd), TVM_GETVISIBLECOUNT, 0, 0))
const TVM_HITTEST = TV_FIRST + 17
#define TreeView_HitTest(hwnd, lpht) cast(HTREEITEM, SNDMSG((hwnd), TVM_HITTEST, 0, cast(LPARAM, cast(LPTV_HITTESTINFO, (lpht)))))
type LPTV_HITTESTINFO as LPTVHITTESTINFO
type TV_HITTESTINFO as TVHITTESTINFO

type tagTVHITTESTINFO
	pt as POINT
	flags as UINT
	hItem as HTREEITEM
end type

type TVHITTESTINFO as tagTVHITTESTINFO
type LPTVHITTESTINFO as tagTVHITTESTINFO ptr
const TVHT_NOWHERE = &h1
const TVHT_ONITEMICON = &h2
const TVHT_ONITEMLABEL = &h4
#define TVHT_ONITEM ((TVHT_ONITEMICON or TVHT_ONITEMLABEL) or TVHT_ONITEMSTATEICON)
const TVHT_ONITEMINDENT = &h8
const TVHT_ONITEMBUTTON = &h10
const TVHT_ONITEMRIGHT = &h20
const TVHT_ONITEMSTATEICON = &h40
const TVHT_ABOVE = &h100
const TVHT_BELOW = &h200
const TVHT_TORIGHT = &h400
const TVHT_TOLEFT = &h800
const TVM_CREATEDRAGIMAGE = TV_FIRST + 18
#define TreeView_CreateDragImage(hwnd, hitem) cast(HIMAGELIST, SNDMSG((hwnd), TVM_CREATEDRAGIMAGE, 0, cast(LPARAM, cast(HTREEITEM, (hitem)))))
const TVM_SORTCHILDREN = TV_FIRST + 19
#define TreeView_SortChildren(hwnd, hitem, recurse) cast(WINBOOL, SNDMSG((hwnd), TVM_SORTCHILDREN, cast(WPARAM, (recurse)), cast(LPARAM, cast(HTREEITEM, (hitem)))))
const TVM_ENSUREVISIBLE = TV_FIRST + 20
#define TreeView_EnsureVisible(hwnd, hitem) cast(WINBOOL, SNDMSG((hwnd), TVM_ENSUREVISIBLE, 0, cast(LPARAM, cast(HTREEITEM, (hitem)))))
const TVM_SORTCHILDRENCB = TV_FIRST + 21
#define TreeView_SortChildrenCB(hwnd, psort, recurse) cast(WINBOOL, SNDMSG((hwnd), TVM_SORTCHILDRENCB, cast(WPARAM, (recurse)), cast(LPARAM, cast(LPTV_SORTCB, (psort)))))
const TVM_ENDEDITLABELNOW = TV_FIRST + 22
#define TreeView_EndEditLabelNow(hwnd, fCancel) cast(WINBOOL, SNDMSG((hwnd), TVM_ENDEDITLABELNOW, cast(WPARAM, (fCancel)), 0))
const TVM_GETISEARCHSTRINGA = TV_FIRST + 23
const TVM_GETISEARCHSTRINGW = TV_FIRST + 64

#ifdef UNICODE
	const TVM_GETISEARCHSTRING = TVM_GETISEARCHSTRINGW
#else
	const TVM_GETISEARCHSTRING = TVM_GETISEARCHSTRINGA
#endif

const TVM_SETTOOLTIPS = TV_FIRST + 24
#define TreeView_SetToolTips(hwnd_, hwndTT) cast(HWND, SNDMSG((hwnd_), TVM_SETTOOLTIPS, cast(WPARAM, (hwndTT)), 0))
const TVM_GETTOOLTIPS = TV_FIRST + 25
#define TreeView_GetToolTips(hwnd_) cast(HWND, SNDMSG((hwnd_), TVM_GETTOOLTIPS, 0, 0))
#define TreeView_GetISearchString(hwndTV, lpsz) cast(WINBOOL, SNDMSG((hwndTV), TVM_GETISEARCHSTRING, 0, cast(LPARAM, cast(LPTSTR, (lpsz)))))
const TVM_SETINSERTMARK = TV_FIRST + 26
#define TreeView_SetInsertMark(hwnd, hItem, fAfter) cast(WINBOOL, SNDMSG((hwnd), TVM_SETINSERTMARK, cast(WPARAM, (fAfter)), cast(LPARAM, (hItem))))
const TVM_SETUNICODEFORMAT = CCM_SETUNICODEFORMAT
#define TreeView_SetUnicodeFormat(hwnd, fUnicode) cast(WINBOOL, SNDMSG((hwnd), TVM_SETUNICODEFORMAT, cast(WPARAM, (fUnicode)), 0))
const TVM_GETUNICODEFORMAT = CCM_GETUNICODEFORMAT
#define TreeView_GetUnicodeFormat(hwnd) cast(WINBOOL, SNDMSG((hwnd), TVM_GETUNICODEFORMAT, 0, 0))
const TVM_SETITEMHEIGHT = TV_FIRST + 27
#define TreeView_SetItemHeight(hwnd, iHeight) clng(SNDMSG((hwnd), TVM_SETITEMHEIGHT, cast(WPARAM, (iHeight)), 0))
const TVM_GETITEMHEIGHT = TV_FIRST + 28
#define TreeView_GetItemHeight(hwnd) clng(SNDMSG((hwnd), TVM_GETITEMHEIGHT, 0, 0))
const TVM_SETBKCOLOR = TV_FIRST + 29
#define TreeView_SetBkColor(hwnd, clr) cast(COLORREF, SNDMSG((hwnd), TVM_SETBKCOLOR, 0, cast(LPARAM, (clr))))
const TVM_SETTEXTCOLOR = TV_FIRST + 30
#define TreeView_SetTextColor(hwnd, clr) cast(COLORREF, SNDMSG((hwnd), TVM_SETTEXTCOLOR, 0, cast(LPARAM, (clr))))
const TVM_GETBKCOLOR = TV_FIRST + 31
#define TreeView_GetBkColor(hwnd) cast(COLORREF, SNDMSG((hwnd), TVM_GETBKCOLOR, 0, 0))
const TVM_GETTEXTCOLOR = TV_FIRST + 32
#define TreeView_GetTextColor(hwnd) cast(COLORREF, SNDMSG((hwnd), TVM_GETTEXTCOLOR, 0, 0))
const TVM_SETSCROLLTIME = TV_FIRST + 33
#define TreeView_SetScrollTime(hwnd, uTime) cast(UINT, SNDMSG((hwnd), TVM_SETSCROLLTIME, uTime, 0))
const TVM_GETSCROLLTIME = TV_FIRST + 34
#define TreeView_GetScrollTime(hwnd) cast(UINT, SNDMSG((hwnd), TVM_GETSCROLLTIME, 0, 0))
const TVM_SETBORDER = TV_FIRST + 35
#define TreeView_SetBorder(hwnd, dwFlags, xBorder, yBorder) clng(SNDMSG((hwnd), TVM_SETBORDER, cast(WPARAM, (dwFlags)), MAKELPARAM(xBorder, yBorder)))
const TVSBF_XBORDER = &h1
const TVSBF_YBORDER = &h2
const TVM_SETINSERTMARKCOLOR = TV_FIRST + 37
#define TreeView_SetInsertMarkColor(hwnd, clr) cast(COLORREF, SNDMSG((hwnd), TVM_SETINSERTMARKCOLOR, 0, cast(LPARAM, (clr))))
const TVM_GETINSERTMARKCOLOR = TV_FIRST + 38
#define TreeView_GetInsertMarkColor(hwnd) cast(COLORREF, SNDMSG((hwnd), TVM_GETINSERTMARKCOLOR, 0, 0))
#macro TreeView_SetItemState(hwndTV, hti, data, _mask)
	scope
		dim _ms_TVi as TVITEM
		_ms_TVi.mask = TVIF_STATE
		_ms_TVi.hItem = hti
		_ms_TVi.stateMask = _mask
		_ms_TVi.state = data
		SNDMSG((hwndTV), TVM_SETITEM, 0, cast(LPARAM, cptr(TV_ITEM ptr, @_ms_TVi)))
	end scope
#endmacro
#define TreeView_SetCheckState(hwndTV, hti, fCheck) TreeView_SetItemState(hwndTV, hti, INDEXTOSTATEIMAGEMASK(iif((fCheck), 2, 1)), TVIS_STATEIMAGEMASK)
const TVM_GETITEMSTATE = TV_FIRST + 39
#define TreeView_GetItemState(hwndTV, hti, mask) cast(UINT, SNDMSG((hwndTV), TVM_GETITEMSTATE, cast(WPARAM, (hti)), cast(LPARAM, (mask))))
#define TreeView_GetCheckState(hwndTV, hti) ((cast(UINT, SNDMSG((hwndTV), TVM_GETITEMSTATE, cast(WPARAM, (hti)), TVIS_STATEIMAGEMASK)) shr 12) - 1)
const TVM_SETLINECOLOR = TV_FIRST + 40
#define TreeView_SetLineColor(hwnd, clr) cast(COLORREF, SNDMSG((hwnd), TVM_SETLINECOLOR, 0, cast(LPARAM, (clr))))
const TVM_GETLINECOLOR = TV_FIRST + 41
#define TreeView_GetLineColor(hwnd) cast(COLORREF, SNDMSG((hwnd), TVM_GETLINECOLOR, 0, 0))
const TVM_MAPACCIDTOHTREEITEM = TV_FIRST + 42
#define TreeView_MapAccIDToHTREEITEM(hwnd, id) cast(HTREEITEM, SNDMSG((hwnd), TVM_MAPACCIDTOHTREEITEM, id, 0))
const TVM_MAPHTREEITEMTOACCID = TV_FIRST + 43
#define TreeView_MapHTREEITEMToAccID(hwnd, htreeitem) cast(UINT, SNDMSG((hwnd), TVM_MAPHTREEITEMTOACCID, cast(WPARAM, htreeitem), 0))
const TVM_SETEXTENDEDSTYLE = TV_FIRST + 44
#define TreeView_SetExtendedStyle(hwnd, dw, mask) cast(DWORD, SNDMSG((hwnd), TVM_SETEXTENDEDSTYLE, mask, dw))
const TVM_GETEXTENDEDSTYLE = TV_FIRST + 45
#define TreeView_GetExtendedStyle(hwnd) cast(DWORD, SNDMSG((hwnd), TVM_GETEXTENDEDSTYLE, 0, 0))
const TVM_SETHOT = TV_FIRST + 58
#define TreeView_SetHot(hwnd, hitem) SNDMSG((hwnd), TVM_SETHOT, 0, cast(LPARAM, (hitem)))
const TVM_SETAUTOSCROLLINFO = TV_FIRST + 59
#define TreeView_SetAutoScrollInfo(hwnd, uPixPerSec, uUpdateTime) SNDMSG((hwnd), TVM_SETAUTOSCROLLINFO, cast(WPARAM, (uPixPerSec)), cast(LPARAM, (uUpdateTime)))

#if _WIN32_WINNT >= &h0600
	const TVM_GETSELECTEDCOUNT = TV_FIRST + 70
	#define TreeView_GetSelectedCount(hwnd) cast(DWORD, SNDMSG((hwnd), TVM_GETSELECTEDCOUNT, 0, 0))
	const TVM_SHOWINFOTIP = TV_FIRST + 71
	#define TreeView_ShowInfoTip(hwnd, hitem) cast(DWORD, SNDMSG((hwnd), TVM_SHOWINFOTIP, 0, cast(LPARAM, (hitem))))

	type _TVITEMPART as long
	enum
		TVGIPR_BUTTON = &h0001
	end enum

	type TVITEMPART as _TVITEMPART

	type tagTVGETITEMPARTRECTINFO
		hti as HTREEITEM
		prc as RECT ptr
		partID as TVITEMPART
	end type

	type TVGETITEMPARTRECTINFO as tagTVGETITEMPARTRECTINFO
	const TVM_GETITEMPARTRECT = TV_FIRST + 72
	private function TreeView_GetItemPartRect(byval hwnd as HWND, byval hitem as HTREEITEM, byval prc as RECT ptr, byval partid as TVITEMPART) as WINBOOL
		dim as TVGETITEMPARTRECTINFO info
		info.hti = hitem
		info.prc = prc
		info.partID = partid
		function = SNDMSG(hwnd, TVM_GETITEMPARTRECT, 0, cast(LPARAM, @info))
	end function
#endif

type PFNTVCOMPARE as function(byval lParam1 as LPARAM, byval lParam2 as LPARAM, byval lParamSort as LPARAM) as long
type LPTV_SORTCB as LPTVSORTCB
type TV_SORTCB as TVSORTCB

type tagTVSORTCB
	hParent as HTREEITEM
	lpfnCompare as PFNTVCOMPARE
	lParam as LPARAM
end type

type TVSORTCB as tagTVSORTCB
type LPTVSORTCB as tagTVSORTCB ptr
type LPNM_TREEVIEWA as LPNMTREEVIEWA
type LPNM_TREEVIEWW as LPNMTREEVIEWW
type NM_TREEVIEWW as NMTREEVIEWW
type NM_TREEVIEWA as NMTREEVIEWA

type tagNMTREEVIEWA
	hdr as NMHDR
	action as UINT
	itemOld as TVITEMA
	itemNew as TVITEMA
	ptDrag as POINT
end type

type NMTREEVIEWA as tagNMTREEVIEWA
type LPNMTREEVIEWA as tagNMTREEVIEWA ptr

type tagNMTREEVIEWW
	hdr as NMHDR
	action as UINT
	itemOld as TVITEMW
	itemNew as TVITEMW
	ptDrag as POINT
end type

type NMTREEVIEWW as tagNMTREEVIEWW
type LPNMTREEVIEWW as tagNMTREEVIEWW ptr

#ifdef UNICODE
	type NMTREEVIEW as NMTREEVIEWW
#else
	type NMTREEVIEW as NMTREEVIEWA
#endif

type NM_TREEVIEW as NMTREEVIEW

#ifdef UNICODE
	type LPNMTREEVIEW as LPNMTREEVIEWW
#else
	type LPNMTREEVIEW as LPNMTREEVIEWA
#endif

type LPNM_TREEVIEW as LPNMTREEVIEW
const TVN_SELCHANGINGA = culng(TVN_FIRST - 1)
const TVN_SELCHANGINGW = culng(TVN_FIRST - 50)
const TVN_SELCHANGEDA = culng(TVN_FIRST - 2)
const TVN_SELCHANGEDW = culng(TVN_FIRST - 51)
const TVC_UNKNOWN = &h0
const TVC_BYMOUSE = &h1
const TVC_BYKEYBOARD = &h2
const TVN_GETDISPINFOA = culng(TVN_FIRST - 3)
const TVN_GETDISPINFOW = culng(TVN_FIRST - 52)
const TVN_SETDISPINFOA = culng(TVN_FIRST - 4)
const TVN_SETDISPINFOW = culng(TVN_FIRST - 53)
const TVIF_DI_SETITEM = &h1000
type TV_DISPINFOA as NMTVDISPINFOA
type TV_DISPINFOW as NMTVDISPINFOW

type tagTVDISPINFOA
	hdr as NMHDR
	item as TVITEMA
end type

type NMTVDISPINFOA as tagTVDISPINFOA
type LPNMTVDISPINFOA as tagTVDISPINFOA ptr

type tagTVDISPINFOW
	hdr as NMHDR
	item as TVITEMW
end type

type NMTVDISPINFOW as tagTVDISPINFOW
type LPNMTVDISPINFOW as tagTVDISPINFOW ptr

#ifdef UNICODE
	type NMTVDISPINFO as NMTVDISPINFOW
#else
	type NMTVDISPINFO as NMTVDISPINFOA
#endif

type TV_DISPINFO as NMTVDISPINFO

#ifdef UNICODE
	type LPNMTVDISPINFO as LPNMTVDISPINFOW
#elseif (not defined(UNICODE)) and (_WIN32_WINNT >= &h0501)
	type LPNMTVDISPINFO as LPNMTVDISPINFOA
#endif

#if _WIN32_WINNT >= &h0501
	type tagTVDISPINFOEXA
		hdr as NMHDR
		item as TVITEMEXA
	end type

	type NMTVDISPINFOEXA as tagTVDISPINFOEXA
	type LPNMTVDISPINFOEXA as tagTVDISPINFOEXA ptr

	type tagTVDISPINFOEXW
		hdr as NMHDR
		item as TVITEMEXW
	end type

	type NMTVDISPINFOEXW as tagTVDISPINFOEXW
	type LPNMTVDISPINFOEXW as tagTVDISPINFOEXW ptr
#endif

#if defined(UNICODE) and (_WIN32_WINNT >= &h0501)
	type NMTVDISPINFOEX as NMTVDISPINFOEXW
	type LPNMTVDISPINFOEX as LPNMTVDISPINFOEXW
#elseif (not defined(UNICODE)) and (_WIN32_WINNT >= &h0501)
	type NMTVDISPINFOEX as NMTVDISPINFOEXA
	type LPNMTVDISPINFOEX as LPNMTVDISPINFOEXA
#endif

#if _WIN32_WINNT >= &h0501
	type TV_DISPINFOEXA as NMTVDISPINFOEXA
	type TV_DISPINFOEXW as NMTVDISPINFOEXW
	type TV_DISPINFOEX as NMTVDISPINFOEX
#elseif (not defined(UNICODE)) and (_WIN32_WINNT = &h0400)
	type LPNMTVDISPINFO as LPNMTVDISPINFOA
#endif

const TVN_ITEMEXPANDINGA = culng(TVN_FIRST - 5)
const TVN_ITEMEXPANDINGW = culng(TVN_FIRST - 54)
const TVN_ITEMEXPANDEDA = culng(TVN_FIRST - 6)
const TVN_ITEMEXPANDEDW = culng(TVN_FIRST - 55)
const TVN_BEGINDRAGA = culng(TVN_FIRST - 7)
const TVN_BEGINDRAGW = culng(TVN_FIRST - 56)
const TVN_BEGINRDRAGA = culng(TVN_FIRST - 8)
const TVN_BEGINRDRAGW = culng(TVN_FIRST - 57)
const TVN_DELETEITEMA = culng(TVN_FIRST - 9)
const TVN_DELETEITEMW = culng(TVN_FIRST - 58)
const TVN_BEGINLABELEDITA = culng(TVN_FIRST - 10)
const TVN_BEGINLABELEDITW = culng(TVN_FIRST - 59)
const TVN_ENDLABELEDITA = culng(TVN_FIRST - 11)
const TVN_ENDLABELEDITW = culng(TVN_FIRST - 60)
const TVN_KEYDOWN = culng(TVN_FIRST - 12)
const TVN_GETINFOTIPA = culng(TVN_FIRST - 13)
const TVN_GETINFOTIPW = culng(TVN_FIRST - 14)
const TVN_SINGLEEXPAND = culng(TVN_FIRST - 15)
const TVNRET_DEFAULT = 0
const TVNRET_SKIPOLD = 1
const TVNRET_SKIPNEW = 2

#if _WIN32_WINNT >= &h0501
	const TVN_ITEMCHANGINGA = culng(TVN_FIRST - 16)
	const TVN_ITEMCHANGINGW = culng(TVN_FIRST - 17)
	const TVN_ITEMCHANGEDA = culng(TVN_FIRST - 18)
	const TVN_ITEMCHANGEDW = culng(TVN_FIRST - 19)
	const TVN_ASYNCDRAW = culng(TVN_FIRST - 20)
#endif

type TV_KEYDOWN as NMTVKEYDOWN

type tagTVKEYDOWN field = 1
	hdr as NMHDR
	wVKey as WORD
	flags as UINT
end type

type NMTVKEYDOWN as tagTVKEYDOWN
type LPNMTVKEYDOWN as tagTVKEYDOWN ptr

#ifdef UNICODE
	const TVN_SELCHANGING = TVN_SELCHANGINGW
	const TVN_SELCHANGED = TVN_SELCHANGEDW
	const TVN_GETDISPINFO = TVN_GETDISPINFOW
	const TVN_SETDISPINFO = TVN_SETDISPINFOW
	const TVN_ITEMEXPANDING = TVN_ITEMEXPANDINGW
	const TVN_ITEMEXPANDED = TVN_ITEMEXPANDEDW
	const TVN_BEGINDRAG = TVN_BEGINDRAGW
	const TVN_BEGINRDRAG = TVN_BEGINRDRAGW
	const TVN_DELETEITEM = TVN_DELETEITEMW
	const TVN_BEGINLABELEDIT = TVN_BEGINLABELEDITW
	const TVN_ENDLABELEDIT = TVN_ENDLABELEDITW
#else
	const TVN_SELCHANGING = TVN_SELCHANGINGA
	const TVN_SELCHANGED = TVN_SELCHANGEDA
	const TVN_GETDISPINFO = TVN_GETDISPINFOA
	const TVN_SETDISPINFO = TVN_SETDISPINFOA
	const TVN_ITEMEXPANDING = TVN_ITEMEXPANDINGA
	const TVN_ITEMEXPANDED = TVN_ITEMEXPANDEDA
	const TVN_BEGINDRAG = TVN_BEGINDRAGA
	const TVN_BEGINRDRAG = TVN_BEGINRDRAGA
	const TVN_DELETEITEM = TVN_DELETEITEMA
	const TVN_BEGINLABELEDIT = TVN_BEGINLABELEDITA
	const TVN_ENDLABELEDIT = TVN_ENDLABELEDITA
#endif

#define NMTVCUSTOMDRAW_V3_SIZE CCSIZEOF_STRUCT(NMTVCUSTOMDRAW, clrTextBk)

type tagNMTVCUSTOMDRAW
	nmcd as NMCUSTOMDRAW
	clrText as COLORREF
	clrTextBk as COLORREF
	iLevel as long
end type

type NMTVCUSTOMDRAW as tagNMTVCUSTOMDRAW
type LPNMTVCUSTOMDRAW as tagNMTVCUSTOMDRAW ptr

type tagNMTVGETINFOTIPA
	hdr as NMHDR
	pszText as LPSTR
	cchTextMax as long
	hItem as HTREEITEM
	lParam as LPARAM
end type

type NMTVGETINFOTIPA as tagNMTVGETINFOTIPA
type LPNMTVGETINFOTIPA as tagNMTVGETINFOTIPA ptr

type tagNMTVGETINFOTIPW
	hdr as NMHDR
	pszText as LPWSTR
	cchTextMax as long
	hItem as HTREEITEM
	lParam as LPARAM
end type

type NMTVGETINFOTIPW as tagNMTVGETINFOTIPW
type LPNMTVGETINFOTIPW as tagNMTVGETINFOTIPW ptr

#ifdef UNICODE
	const TVN_GETINFOTIP = TVN_GETINFOTIPW
	type NMTVGETINFOTIP as NMTVGETINFOTIPW
	type LPNMTVGETINFOTIP as LPNMTVGETINFOTIPW
#else
	const TVN_GETINFOTIP = TVN_GETINFOTIPA
	type NMTVGETINFOTIP as NMTVGETINFOTIPA
	type LPNMTVGETINFOTIP as LPNMTVGETINFOTIPA
#endif

const TVCDRF_NOIMAGES = &h10000

#if _WIN32_WINNT >= &h0502
	type tagTVITEMCHANGE
		hdr as NMHDR
		uChanged as UINT
		hItem as HTREEITEM
		uStateNew as UINT
		uStateOld as UINT
		lParam as LPARAM
	end type

	type NMTVITEMCHANGE as tagTVITEMCHANGE

	type tagNMTVASYNCDRAW
		hdr as NMHDR
		pimldp as IMAGELISTDRAWPARAMS ptr
		hr as HRESULT
		hItem as HTREEITEM
		lParam as LPARAM
		dwRetFlags as DWORD
		iRetImageIndex as long
	end type

	type NMTVASYNCDRAW as tagNMTVASYNCDRAW
#endif

#if defined(UNICODE) and (_WIN32_WINNT >= &h0502)
	const TVN_ITEMCHANGING = TVN_ITEMCHANGINGW
	const TVN_ITEMCHANGED = TVN_ITEMCHANGEDW
#elseif (not defined(UNICODE)) and (_WIN32_WINNT >= &h0502)
	const TVN_ITEMCHANGING = TVN_ITEMCHANGINGA
	const TVN_ITEMCHANGED = TVN_ITEMCHANGEDA
#endif

#define WC_COMBOBOXEXW wstr("ComboBoxEx32")
#define WC_COMBOBOXEXA "ComboBoxEx32"

#ifdef UNICODE
	#define WC_COMBOBOXEX WC_COMBOBOXEXW
#else
	#define WC_COMBOBOXEX WC_COMBOBOXEXA
#endif

const CBEIF_TEXT = &h1
const CBEIF_IMAGE = &h2
const CBEIF_SELECTEDIMAGE = &h4
const CBEIF_OVERLAY = &h8
const CBEIF_INDENT = &h10
const CBEIF_LPARAM = &h20
const CBEIF_DI_SETITEM = &h10000000

type tagCOMBOBOXEXITEMA
	mask as UINT
	iItem as INT_PTR
	pszText as LPSTR
	cchTextMax as long
	iImage as long
	iSelectedImage as long
	iOverlay as long
	iIndent as long
	lParam as LPARAM
end type

type COMBOBOXEXITEMA as tagCOMBOBOXEXITEMA
type PCOMBOBOXEXITEMA as tagCOMBOBOXEXITEMA ptr
type PCCOMBOEXITEMA as const COMBOBOXEXITEMA ptr

type tagCOMBOBOXEXITEMW
	mask as UINT
	iItem as INT_PTR
	pszText as LPWSTR
	cchTextMax as long
	iImage as long
	iSelectedImage as long
	iOverlay as long
	iIndent as long
	lParam as LPARAM
end type

type COMBOBOXEXITEMW as tagCOMBOBOXEXITEMW
type PCOMBOBOXEXITEMW as tagCOMBOBOXEXITEMW ptr
type PCCOMBOEXITEMW as const COMBOBOXEXITEMW ptr

#ifdef UNICODE
	type COMBOBOXEXITEM as COMBOBOXEXITEMW
	type PCOMBOBOXEXITEM as PCOMBOBOXEXITEMW
	#define PCCOMBOBOXEXITEM PCCOMBOBOXEXITEMW
#else
	type COMBOBOXEXITEM as COMBOBOXEXITEMA
	type PCOMBOBOXEXITEM as PCOMBOBOXEXITEMA
	#define PCCOMBOBOXEXITEM PCCOMBOBOXEXITEMA
#endif

const CBEM_INSERTITEMA = WM_USER + 1
const CBEM_SETIMAGELIST = WM_USER + 2
const CBEM_GETIMAGELIST = WM_USER + 3
const CBEM_GETITEMA = WM_USER + 4
const CBEM_SETITEMA = WM_USER + 5
const CBEM_DELETEITEM = CB_DELETESTRING
const CBEM_GETCOMBOCONTROL = WM_USER + 6
const CBEM_GETEDITCONTROL = WM_USER + 7
const CBEM_SETEXSTYLE = WM_USER + 8
const CBEM_SETEXTENDEDSTYLE = WM_USER + 14
const CBEM_GETEXSTYLE = WM_USER + 9
const CBEM_GETEXTENDEDSTYLE = WM_USER + 9
const CBEM_SETUNICODEFORMAT = CCM_SETUNICODEFORMAT
const CBEM_GETUNICODEFORMAT = CCM_GETUNICODEFORMAT
const CBEM_HASEDITCHANGED = WM_USER + 10
const CBEM_INSERTITEMW = WM_USER + 11
const CBEM_SETITEMW = WM_USER + 12
const CBEM_GETITEMW = WM_USER + 13

#ifdef UNICODE
	const CBEM_INSERTITEM = CBEM_INSERTITEMW
	const CBEM_SETITEM = CBEM_SETITEMW
	const CBEM_GETITEM = CBEM_GETITEMW
#else
	const CBEM_INSERTITEM = CBEM_INSERTITEMA
	const CBEM_SETITEM = CBEM_SETITEMA
	const CBEM_GETITEM = CBEM_GETITEMA
#endif

const CBEM_SETWINDOWTHEME = CCM_SETWINDOWTHEME
const CBES_EX_NOEDITIMAGE = &h1
const CBES_EX_NOEDITIMAGEINDENT = &h2
const CBES_EX_PATHWORDBREAKPROC = &h4
const CBES_EX_NOSIZELIMIT = &h8
const CBES_EX_CASESENSITIVE = &h10

#if _WIN32_WINNT >= &h0600
	const CBES_EX_TEXTENDELLIPSIS = &h00000020
#endif

type NMCOMBOBOXEXA
	hdr as NMHDR
	ceItem as COMBOBOXEXITEMA
end type

type PNMCOMBOBOXEXA as NMCOMBOBOXEXA ptr

type NMCOMBOBOXEXW
	hdr as NMHDR
	ceItem as COMBOBOXEXITEMW
end type

type PNMCOMBOBOXEXW as NMCOMBOBOXEXW ptr

#ifdef UNICODE
	type NMCOMBOBOXEX as NMCOMBOBOXEXW
	type PNMCOMBOBOXEX as PNMCOMBOBOXEXW
#else
	type NMCOMBOBOXEX as NMCOMBOBOXEXA
	type PNMCOMBOBOXEX as PNMCOMBOBOXEXA
#endif

const CBEN_GETDISPINFOA = culng(CBEN_FIRST - 0)

#ifndef UNICODE
	const CBEN_GETDISPINFO = CBEN_GETDISPINFOA
#endif

const CBEN_INSERTITEM = culng(CBEN_FIRST - 1)
const CBEN_DELETEITEM = culng(CBEN_FIRST - 2)
const CBEN_BEGINEDIT = culng(CBEN_FIRST - 4)
const CBEN_ENDEDITA = culng(CBEN_FIRST - 5)
const CBEN_ENDEDITW = culng(CBEN_FIRST - 6)
const CBEN_GETDISPINFOW = culng(CBEN_FIRST - 7)

#ifdef UNICODE
	const CBEN_GETDISPINFO = CBEN_GETDISPINFOW
#endif

const CBEN_DRAGBEGINA = culng(CBEN_FIRST - 8)
const CBEN_DRAGBEGINW = culng(CBEN_FIRST - 9)

#ifdef UNICODE
	const CBEN_DRAGBEGIN = CBEN_DRAGBEGINW
	const CBEN_ENDEDIT = CBEN_ENDEDITW
#else
	const CBEN_DRAGBEGIN = CBEN_DRAGBEGINA
	const CBEN_ENDEDIT = CBEN_ENDEDITA
#endif

const CBENF_KILLFOCUS = 1
const CBENF_RETURN = 2
const CBENF_ESCAPE = 3
const CBENF_DROPDOWN = 4
const CBEMAXSTRLEN = 260

type NMCBEDRAGBEGINW
	hdr as NMHDR
	iItemid as long
	szText as wstring * 260
end type

type LPNMCBEDRAGBEGINW as NMCBEDRAGBEGINW ptr
type PNMCBEDRAGBEGINW as NMCBEDRAGBEGINW ptr

type NMCBEDRAGBEGINA
	hdr as NMHDR
	iItemid as long
	szText as zstring * 260
end type

type LPNMCBEDRAGBEGINA as NMCBEDRAGBEGINA ptr
type PNMCBEDRAGBEGINA as NMCBEDRAGBEGINA ptr

#ifdef UNICODE
	type NMCBEDRAGBEGIN as NMCBEDRAGBEGINW
	type LPNMCBEDRAGBEGIN as LPNMCBEDRAGBEGINW
	type PNMCBEDRAGBEGIN as PNMCBEDRAGBEGINW
#else
	type NMCBEDRAGBEGIN as NMCBEDRAGBEGINA
	type LPNMCBEDRAGBEGIN as LPNMCBEDRAGBEGINA
	type PNMCBEDRAGBEGIN as PNMCBEDRAGBEGINA
#endif

type NMCBEENDEDITW
	hdr as NMHDR
	fChanged as WINBOOL
	iNewSelection as long
	szText as wstring * 260
	iWhy as long
end type

type LPNMCBEENDEDITW as NMCBEENDEDITW ptr
type PNMCBEENDEDITW as NMCBEENDEDITW ptr

type NMCBEENDEDITA
	hdr as NMHDR
	fChanged as WINBOOL
	iNewSelection as long
	szText as zstring * 260
	iWhy as long
end type

type LPNMCBEENDEDITA as NMCBEENDEDITA ptr
type PNMCBEENDEDITA as NMCBEENDEDITA ptr

#ifdef UNICODE
	type NMCBEENDEDIT as NMCBEENDEDITW
	type LPNMCBEENDEDIT as LPNMCBEENDEDITW
	type PNMCBEENDEDIT as PNMCBEENDEDITW
#else
	type NMCBEENDEDIT as NMCBEENDEDITA
	type LPNMCBEENDEDIT as LPNMCBEENDEDITA
	type PNMCBEENDEDIT as PNMCBEENDEDITA
#endif

#define WC_TABCONTROLA "SysTabControl32"
#define WC_TABCONTROLW wstr("SysTabControl32")

#ifdef UNICODE
	#define WC_TABCONTROL WC_TABCONTROLW
#else
	#define WC_TABCONTROL WC_TABCONTROLA
#endif

const TCS_SCROLLOPPOSITE = &h1
const TCS_BOTTOM = &h2
const TCS_RIGHT = &h2
const TCS_MULTISELECT = &h4
const TCS_FLATBUTTONS = &h8
const TCS_FORCEICONLEFT = &h10
const TCS_FORCELABELLEFT = &h20
const TCS_HOTTRACK = &h40
const TCS_VERTICAL = &h80
const TCS_TABS = &h0
const TCS_BUTTONS = &h100
const TCS_SINGLELINE = &h0
const TCS_MULTILINE = &h200
const TCS_RIGHTJUSTIFY = &h0
const TCS_FIXEDWIDTH = &h400
const TCS_RAGGEDRIGHT = &h800
const TCS_FOCUSONBUTTONDOWN = &h1000
const TCS_OWNERDRAWFIXED = &h2000
const TCS_TOOLTIPS = &h4000
const TCS_FOCUSNEVER = &h8000
const TCS_EX_FLATSEPARATORS = &h1
const TCS_EX_REGISTERDROP = &h2
const TCM_GETIMAGELIST = TCM_FIRST + 2
#define TabCtrl_GetImageList(hwnd) cast(HIMAGELIST, SNDMSG((hwnd), TCM_GETIMAGELIST, cast(WPARAM, 0), cast(LPARAM, 0)))
const TCM_SETIMAGELIST = TCM_FIRST + 3
#define TabCtrl_SetImageList(hwnd, himl) cast(HIMAGELIST, SNDMSG((hwnd), TCM_SETIMAGELIST, 0, cast(LPARAM, cast(HIMAGELIST, (himl)))))
const TCM_GETITEMCOUNT = TCM_FIRST + 4
#define TabCtrl_GetItemCount(hwnd) clng(SNDMSG((hwnd), TCM_GETITEMCOUNT, cast(WPARAM, 0), cast(LPARAM, 0)))
const TCIF_TEXT = &h1
const TCIF_IMAGE = &h2
const TCIF_RTLREADING = &h4
const TCIF_PARAM = &h8
const TCIF_STATE = &h10
const TCIS_BUTTONPRESSED = &h1
const TCIS_HIGHLIGHTED = &h2
type TC_ITEMHEADERA as TCITEMHEADERA
type TC_ITEMHEADERW as TCITEMHEADERW

type tagTCITEMHEADERA
	mask as UINT
	lpReserved1 as UINT
	lpReserved2 as UINT
	pszText as LPSTR
	cchTextMax as long
	iImage as long
end type

type TCITEMHEADERA as tagTCITEMHEADERA
type LPTCITEMHEADERA as tagTCITEMHEADERA ptr

type tagTCITEMHEADERW
	mask as UINT
	lpReserved1 as UINT
	lpReserved2 as UINT
	pszText as LPWSTR
	cchTextMax as long
	iImage as long
end type

type TCITEMHEADERW as tagTCITEMHEADERW
type LPTCITEMHEADERW as tagTCITEMHEADERW ptr

#ifdef UNICODE
	type TCITEMHEADER as TCITEMHEADERW
#else
	type TCITEMHEADER as TCITEMHEADERA
#endif

type TC_ITEMHEADER as TCITEMHEADER

#ifdef UNICODE
	type LPTCITEMHEADER as LPTCITEMHEADERW
#else
	type LPTCITEMHEADER as LPTCITEMHEADERA
#endif

type TC_ITEMA as TCITEMA
type TC_ITEMW as TCITEMW

type tagTCITEMA
	mask as UINT
	dwState as DWORD
	dwStateMask as DWORD
	pszText as LPSTR
	cchTextMax as long
	iImage as long
	lParam as LPARAM
end type

type TCITEMA as tagTCITEMA
type LPTCITEMA as tagTCITEMA ptr

type tagTCITEMW
	mask as UINT
	dwState as DWORD
	dwStateMask as DWORD
	pszText as LPWSTR
	cchTextMax as long
	iImage as long
	lParam as LPARAM
end type

type TCITEMW as tagTCITEMW
type LPTCITEMW as tagTCITEMW ptr

#ifdef UNICODE
	type TCITEM as TCITEMW
#else
	type TCITEM as TCITEMA
#endif

type TC_ITEM as TCITEM

#ifdef UNICODE
	type LPTCITEM as LPTCITEMW
#else
	type LPTCITEM as LPTCITEMA
#endif

const TCM_GETITEMA = TCM_FIRST + 5
const TCM_GETITEMW = TCM_FIRST + 60

#ifdef UNICODE
	const TCM_GETITEM = TCM_GETITEMW
#else
	const TCM_GETITEM = TCM_GETITEMA
#endif

#define TabCtrl_GetItem(hwnd, iItem, pitem) cast(WINBOOL, SNDMSG((hwnd), TCM_GETITEM, cast(WPARAM, clng(iItem)), cast(LPARAM, cptr(TC_ITEM ptr, (pitem)))))
const TCM_SETITEMA = TCM_FIRST + 6
const TCM_SETITEMW = TCM_FIRST + 61

#ifdef UNICODE
	const TCM_SETITEM = TCM_SETITEMW
#else
	const TCM_SETITEM = TCM_SETITEMA
#endif

#define TabCtrl_SetItem(hwnd, iItem, pitem) cast(WINBOOL, SNDMSG((hwnd), TCM_SETITEM, cast(WPARAM, clng(iItem)), cast(LPARAM, cptr(TC_ITEM ptr, (pitem)))))
const TCM_INSERTITEMA = TCM_FIRST + 7
const TCM_INSERTITEMW = TCM_FIRST + 62

#ifdef UNICODE
	const TCM_INSERTITEM = TCM_INSERTITEMW
#else
	const TCM_INSERTITEM = TCM_INSERTITEMA
#endif

#define TabCtrl_InsertItem(hwnd, iItem, pitem) clng(SNDMSG((hwnd), TCM_INSERTITEM, cast(WPARAM, clng(iItem)), cast(LPARAM, cptr(const TC_ITEM ptr, (pitem)))))
const TCM_DELETEITEM = TCM_FIRST + 8
#define TabCtrl_DeleteItem(hwnd, i) cast(WINBOOL, SNDMSG((hwnd), TCM_DELETEITEM, cast(WPARAM, clng(i)), cast(LPARAM, 0)))
const TCM_DELETEALLITEMS = TCM_FIRST + 9
#define TabCtrl_DeleteAllItems(hwnd) cast(WINBOOL, SNDMSG((hwnd), TCM_DELETEALLITEMS, cast(WPARAM, 0), cast(LPARAM, 0)))
const TCM_GETITEMRECT = TCM_FIRST + 10
#define TabCtrl_GetItemRect(hwnd, i, prc) cast(WINBOOL, SNDMSG((hwnd), TCM_GETITEMRECT, cast(WPARAM, clng(i)), cast(LPARAM, cptr(RECT ptr, (prc)))))
const TCM_GETCURSEL = TCM_FIRST + 11
#define TabCtrl_GetCurSel(hwnd) clng(SNDMSG((hwnd), TCM_GETCURSEL, 0, 0))
const TCM_SETCURSEL = TCM_FIRST + 12
#define TabCtrl_SetCurSel(hwnd, i) clng(SNDMSG((hwnd), TCM_SETCURSEL, cast(WPARAM, (i)), 0))
const TCHT_NOWHERE = &h1
const TCHT_ONITEMICON = &h2
const TCHT_ONITEMLABEL = &h4
const TCHT_ONITEM = TCHT_ONITEMICON or TCHT_ONITEMLABEL
type LPTC_HITTESTINFO as LPTCHITTESTINFO
type TC_HITTESTINFO as TCHITTESTINFO

type tagTCHITTESTINFO
	pt as POINT
	flags as UINT
end type

type TCHITTESTINFO as tagTCHITTESTINFO
type LPTCHITTESTINFO as tagTCHITTESTINFO ptr
const TCM_HITTEST = TCM_FIRST + 13
#define TabCtrl_HitTest(hwndTC, pinfo) clng(SNDMSG((hwndTC), TCM_HITTEST, 0, cast(LPARAM, cptr(TC_HITTESTINFO ptr, (pinfo)))))
const TCM_SETITEMEXTRA = TCM_FIRST + 14
#define TabCtrl_SetItemExtra(hwndTC, cb) cast(WINBOOL, SNDMSG((hwndTC), TCM_SETITEMEXTRA, cast(WPARAM, (cb)), cast(LPARAM, 0)))
const TCM_ADJUSTRECT = TCM_FIRST + 40
#define TabCtrl_AdjustRect(hwnd, bLarger, prc) clng(SNDMSG(hwnd, TCM_ADJUSTRECT, cast(WPARAM, cast(WINBOOL, (bLarger))), cast(LPARAM, cptr(RECT ptr, prc))))
const TCM_SETITEMSIZE = TCM_FIRST + 41
#define TabCtrl_SetItemSize(hwnd, x, y) cast(DWORD, SNDMSG((hwnd), TCM_SETITEMSIZE, 0, MAKELPARAM(x, y)))
const TCM_REMOVEIMAGE = TCM_FIRST + 42
#define TabCtrl_RemoveImage(hwnd, i) SNDMSG((hwnd), TCM_REMOVEIMAGE, i, cast(LPARAM, 0))
const TCM_SETPADDING = TCM_FIRST + 43
#define TabCtrl_SetPadding(hwnd, cx, cy) SNDMSG((hwnd), TCM_SETPADDING, 0, MAKELPARAM(cx, cy))
const TCM_GETROWCOUNT = TCM_FIRST + 44
#define TabCtrl_GetRowCount(hwnd) clng(SNDMSG((hwnd), TCM_GETROWCOUNT, cast(WPARAM, 0), cast(LPARAM, 0)))
const TCM_GETTOOLTIPS = TCM_FIRST + 45
#define TabCtrl_GetToolTips(hwnd_) cast(HWND, SNDMSG((hwnd_), TCM_GETTOOLTIPS, cast(WPARAM, 0), cast(LPARAM, 0)))
const TCM_SETTOOLTIPS = TCM_FIRST + 46
#define TabCtrl_SetToolTips(hwnd, hwndTT) SNDMSG((hwnd), TCM_SETTOOLTIPS, cast(WPARAM, (hwndTT)), cast(LPARAM, 0))
const TCM_GETCURFOCUS = TCM_FIRST + 47
#define TabCtrl_GetCurFocus(hwnd) clng(SNDMSG((hwnd), TCM_GETCURFOCUS, 0, 0))
const TCM_SETCURFOCUS = TCM_FIRST + 48
#define TabCtrl_SetCurFocus(hwnd, i) SNDMSG((hwnd), TCM_SETCURFOCUS, i, 0)
const TCM_SETMINTABWIDTH = TCM_FIRST + 49
#define TabCtrl_SetMinTabWidth(hwnd, x) clng(SNDMSG((hwnd), TCM_SETMINTABWIDTH, 0, x))
const TCM_DESELECTALL = TCM_FIRST + 50
#define TabCtrl_DeselectAll(hwnd, fExcludeFocus) SNDMSG((hwnd), TCM_DESELECTALL, fExcludeFocus, 0)
const TCM_HIGHLIGHTITEM = TCM_FIRST + 51
#define TabCtrl_HighlightItem(hwnd, i, fHighlight) cast(WINBOOL, SNDMSG((hwnd), TCM_HIGHLIGHTITEM, cast(WPARAM, (i)), cast(LPARAM, MAKELONG(fHighlight, 0))))
const TCM_SETEXTENDEDSTYLE = TCM_FIRST + 52
#define TabCtrl_SetExtendedStyle(hwnd, dw) cast(DWORD, SNDMSG((hwnd), TCM_SETEXTENDEDSTYLE, 0, dw))
const TCM_GETEXTENDEDSTYLE = TCM_FIRST + 53
#define TabCtrl_GetExtendedStyle(hwnd) cast(DWORD, SNDMSG((hwnd), TCM_GETEXTENDEDSTYLE, 0, 0))
const TCM_SETUNICODEFORMAT = CCM_SETUNICODEFORMAT
#define TabCtrl_SetUnicodeFormat(hwnd, fUnicode) cast(WINBOOL, SNDMSG((hwnd), TCM_SETUNICODEFORMAT, cast(WPARAM, (fUnicode)), 0))
const TCM_GETUNICODEFORMAT = CCM_GETUNICODEFORMAT
#define TabCtrl_GetUnicodeFormat(hwnd) cast(WINBOOL, SNDMSG((hwnd), TCM_GETUNICODEFORMAT, 0, 0))
const TCN_KEYDOWN = culng(TCN_FIRST - 0)
type TC_KEYDOWN as NMTCKEYDOWN

type tagTCKEYDOWN field = 1
	hdr as NMHDR
	wVKey as WORD
	flags as UINT
end type

type NMTCKEYDOWN as tagTCKEYDOWN
const TCN_SELCHANGE = culng(TCN_FIRST - 1)
const TCN_SELCHANGING = culng(TCN_FIRST - 2)
const TCN_GETOBJECT = culng(TCN_FIRST - 3)
const TCN_FOCUSCHANGE = culng(TCN_FIRST - 4)
#define ANIMATE_CLASSW wstr("SysAnimate32")
#define ANIMATE_CLASSA "SysAnimate32"

#ifdef UNICODE
	#define ANIMATE_CLASS ANIMATE_CLASSW
#else
	#define ANIMATE_CLASS ANIMATE_CLASSA
#endif

const ACS_CENTER = &h1
const ACS_TRANSPARENT = &h2
const ACS_AUTOPLAY = &h4
const ACS_TIMER = &h8
const ACM_OPENA = WM_USER + 100
const ACM_OPENW = WM_USER + 103

#ifdef UNICODE
	const ACM_OPEN = ACM_OPENW
#else
	const ACM_OPEN = ACM_OPENA
#endif

const ACM_PLAY = WM_USER + 101
const ACM_STOP = WM_USER + 102
const ACM_ISPLAYING = WM_USER + 104
const ACN_START = 1
const ACN_STOP = 2
#define Animate_Create(hwndP, id, dwStyle, hInstance) CreateWindow(ANIMATE_CLASS, NULL, dwStyle, 0, 0, 0, 0, hwndP, cast(HMENU, (id)), hInstance, NULL)
#define Animate_Open(hwnd, szName) cast(WINBOOL, SNDMSG(hwnd, ACM_OPEN, 0, cast(LPARAM, cast(LPTSTR, (szName)))))
#define Animate_OpenEx(hwnd, hInst, szName) cast(WINBOOL, SNDMSG(hwnd, ACM_OPEN, cast(WPARAM, (hInst)), cast(LPARAM, cast(LPTSTR, (szName)))))
#define Animate_Play(hwnd, from, to, rep) cast(WINBOOL, SNDMSG(hwnd, ACM_PLAY, cast(WPARAM, (rep)), cast(LPARAM, MAKELONG(from, to))))
#define Animate_Stop(hwnd) cast(WINBOOL, SNDMSG(hwnd, ACM_STOP, 0, 0))
#define Animate_IsPlaying(hwnd) cast(WINBOOL, SNDMSG(hwnd, ACM_ISPLAYING, 0, 0))
#define Animate_Close(hwnd) Animate_Open(hwnd, NULL)
#define Animate_Seek(hwnd, frame) Animate_Play(hwnd, frame, frame, 1)
#define MONTHCAL_CLASSW wstr("SysMonthCal32")
#define MONTHCAL_CLASSA "SysMonthCal32"

#ifdef UNICODE
	#define MONTHCAL_CLASS MONTHCAL_CLASSW
#else
	#define MONTHCAL_CLASS MONTHCAL_CLASSA
#endif

type MONTHDAYSTATE as DWORD
type LPMONTHDAYSTATE as DWORD ptr
const MCM_FIRST = &h1000
const MCM_GETCURSEL = MCM_FIRST + 1
#define MonthCal_GetCurSel(hmc, pst) cast(WINBOOL, SNDMSG(hmc, MCM_GETCURSEL, 0, cast(LPARAM, (pst))))
const MCM_SETCURSEL = MCM_FIRST + 2
#define MonthCal_SetCurSel(hmc, pst) cast(WINBOOL, SNDMSG(hmc, MCM_SETCURSEL, 0, cast(LPARAM, (pst))))
const MCM_GETMAXSELCOUNT = MCM_FIRST + 3
#define MonthCal_GetMaxSelCount(hmc) cast(DWORD, SNDMSG(hmc, MCM_GETMAXSELCOUNT, cast(WPARAM, 0), cast(LPARAM, 0)))
const MCM_SETMAXSELCOUNT = MCM_FIRST + 4
#define MonthCal_SetMaxSelCount(hmc, n) cast(WINBOOL, SNDMSG(hmc, MCM_SETMAXSELCOUNT, cast(WPARAM, (n)), cast(LPARAM, 0)))
const MCM_GETSELRANGE = MCM_FIRST + 5
#define MonthCal_GetSelRange(hmc, rgst) SNDMSG(hmc, MCM_GETSELRANGE, 0, cast(LPARAM, (rgst)))
const MCM_SETSELRANGE = MCM_FIRST + 6
#define MonthCal_SetSelRange(hmc, rgst) SNDMSG(hmc, MCM_SETSELRANGE, 0, cast(LPARAM, (rgst)))
const MCM_GETMONTHRANGE = MCM_FIRST + 7
#define MonthCal_GetMonthRange(hmc, gmr, rgst) cast(DWORD, SNDMSG(hmc, MCM_GETMONTHRANGE, cast(WPARAM, (gmr)), cast(LPARAM, (rgst))))
const MCM_SETDAYSTATE = MCM_FIRST + 8
#define MonthCal_SetDayState(hmc, cbds, rgds) SNDMSG(hmc, MCM_SETDAYSTATE, cast(WPARAM, (cbds)), cast(LPARAM, (rgds)))
const MCM_GETMINREQRECT = MCM_FIRST + 9
#define MonthCal_GetMinReqRect(hmc, prc) SNDMSG(hmc, MCM_GETMINREQRECT, 0, cast(LPARAM, (prc)))
const MCM_SETCOLOR = MCM_FIRST + 10
#define MonthCal_SetColor(hmc, iColor, clr) SNDMSG(hmc, MCM_SETCOLOR, iColor, clr)
const MCM_GETCOLOR = MCM_FIRST + 11
#define MonthCal_GetColor(hmc, iColor) SNDMSG(hmc, MCM_GETCOLOR, iColor, 0)
const MCSC_BACKGROUND = 0
const MCSC_TEXT = 1
const MCSC_TITLEBK = 2
const MCSC_TITLETEXT = 3
const MCSC_MONTHBK = 4
const MCSC_TRAILINGTEXT = 5
const MCM_SETTODAY = MCM_FIRST + 12
#define MonthCal_SetToday(hmc, pst) SNDMSG(hmc, MCM_SETTODAY, 0, cast(LPARAM, (pst)))
const MCM_GETTODAY = MCM_FIRST + 13
#define MonthCal_GetToday(hmc, pst) cast(WINBOOL, SNDMSG(hmc, MCM_GETTODAY, 0, cast(LPARAM, (pst))))
const MCM_HITTEST = MCM_FIRST + 14
#define MonthCal_HitTest(hmc, pinfo) SNDMSG(hmc, MCM_HITTEST, 0, cast(LPARAM, cast(PMCHITTESTINFO, (pinfo))))

type MCHITTESTINFO
	cbSize as UINT
	pt as POINT
	uHit as UINT
	st as SYSTEMTIME

	#if _WIN32_WINNT >= &h0600
		rc as RECT
		iOffset as long
		iRow as long
		iCol as long
	#endif
end type

type PMCHITTESTINFO as MCHITTESTINFO ptr
#define MCHITTESTINFO_V1_SIZE CCSIZEOF_STRUCT(MCHITTESTINFO, st)
const MCHT_TITLE = &h10000
const MCHT_CALENDAR = &h20000
const MCHT_TODAYLINK = &h30000

#if _WIN32_WINNT >= &h0600
	const MCHT_CALENDARCONTROL = &h100000
#endif

const MCHT_NEXT = &h1000000
const MCHT_PREV = &h2000000
const MCHT_NOWHERE = &h0
const MCHT_TITLEBK = MCHT_TITLE
const MCHT_TITLEMONTH = MCHT_TITLE or &h1
const MCHT_TITLEYEAR = MCHT_TITLE or &h2
const MCHT_TITLEBTNNEXT = (MCHT_TITLE or MCHT_NEXT) or &h3
const MCHT_TITLEBTNPREV = (MCHT_TITLE or MCHT_PREV) or &h3
const MCHT_CALENDARBK = MCHT_CALENDAR
const MCHT_CALENDARDATE = MCHT_CALENDAR or &h1
const MCHT_CALENDARDATENEXT = MCHT_CALENDARDATE or MCHT_NEXT
const MCHT_CALENDARDATEPREV = MCHT_CALENDARDATE or MCHT_PREV
const MCHT_CALENDARDAY = MCHT_CALENDAR or &h2
const MCHT_CALENDARWEEKNUM = MCHT_CALENDAR or &h3
const MCHT_CALENDARDATEMIN = MCHT_CALENDAR or &h4
const MCHT_CALENDARDATEMAX = MCHT_CALENDAR or &h5
const MCM_SETFIRSTDAYOFWEEK = MCM_FIRST + 15
#define MonthCal_SetFirstDayOfWeek(hmc, iDay) SNDMSG(hmc, MCM_SETFIRSTDAYOFWEEK, 0, iDay)
const MCM_GETFIRSTDAYOFWEEK = MCM_FIRST + 16
#define MonthCal_GetFirstDayOfWeek(hmc) cast(DWORD, SNDMSG(hmc, MCM_GETFIRSTDAYOFWEEK, 0, 0))
const MCM_GETRANGE = MCM_FIRST + 17
#define MonthCal_GetRange(hmc, rgst) cast(DWORD, SNDMSG(hmc, MCM_GETRANGE, 0, cast(LPARAM, (rgst))))
const MCM_SETRANGE = MCM_FIRST + 18
#define MonthCal_SetRange(hmc, gd, rgst) cast(WINBOOL, SNDMSG(hmc, MCM_SETRANGE, cast(WPARAM, (gd)), cast(LPARAM, (rgst))))
const MCM_GETMONTHDELTA = MCM_FIRST + 19
#define MonthCal_GetMonthDelta(hmc) clng(SNDMSG(hmc, MCM_GETMONTHDELTA, 0, 0))
const MCM_SETMONTHDELTA = MCM_FIRST + 20
#define MonthCal_SetMonthDelta(hmc, n) clng(SNDMSG(hmc, MCM_SETMONTHDELTA, n, 0))
const MCM_GETMAXTODAYWIDTH = MCM_FIRST + 21
#define MonthCal_GetMaxTodayWidth(hmc) cast(DWORD, SNDMSG(hmc, MCM_GETMAXTODAYWIDTH, 0, 0))
const MCM_SETUNICODEFORMAT = CCM_SETUNICODEFORMAT
#define MonthCal_SetUnicodeFormat(hwnd, fUnicode) cast(WINBOOL, SNDMSG((hwnd), MCM_SETUNICODEFORMAT, cast(WPARAM, (fUnicode)), 0))
const MCM_GETUNICODEFORMAT = CCM_GETUNICODEFORMAT
#define MonthCal_GetUnicodeFormat(hwnd) cast(WINBOOL, SNDMSG((hwnd), MCM_GETUNICODEFORMAT, 0, 0))

#if _WIN32_WINNT >= &h0600
	const MCMV_MONTH = 0
	const MCMV_YEAR = 1
	const MCMV_DECADE = 2
	const MCMV_CENTURY = 3
	const MCMV_MAX = MCMV_CENTURY
	const MCM_GETCURRENTVIEW = MCM_FIRST + 22
	#define MonthCal_GetCurrentView(hmc) cast(DWORD, SNDMSG(hmc, MCM_GETCURRENTVIEW, 0, 0))
	const MCM_GETCALENDARCOUNT = MCM_FIRST + 23
	#define MonthCal_GetCalendarCount(hmc) cast(DWORD, SNDMSG(hmc, MCM_GETCALENDARCOUNT, 0, 0))
	const MCGIP_CALENDARCONTROL = 0
	const MCGIP_NEXT = 1
	const MCGIP_PREV = 2
	const MCGIP_FOOTER = 3
	const MCGIP_CALENDAR = 4
	const MCGIP_CALENDARHEADER = 5
	const MCGIP_CALENDARBODY = 6
	const MCGIP_CALENDARROW = 7
	const MCGIP_CALENDARCELL = 8
	const MCGIF_DATE = &o1
	const MCGIF_RECT = &h2
	const MCGIF_NAME = &h4

	type tagMCGRIDINFO
		cbSize as UINT
		dwPart as DWORD
		dwFlags as DWORD
		iCalendar as long
		iRow as long
		iCol as long
		bSelected as WINBOOL
		stStart as SYSTEMTIME
		stEnd as SYSTEMTIME
		rc as RECT
		pszName as PWSTR
		cchName as uinteger
	end type

	type MCGRIDINFO as tagMCGRIDINFO
	type PMCGRIDINFO as tagMCGRIDINFO ptr
	const MCM_GETCALENDARGRIDINFO = MCM_FIRST + 24
	#define MonthCal_GetCalendarGridInfo(hmc, pmcGridInfo) cast(WINBOOL, SNDMSG(hmc, MCM_GETCALENDARGRIDINFO, 0, cast(LPARAM, cast(PMCGRIDINFO, (pmcGridInfo)))))
	const MCM_GETCALID = MCM_FIRST + 27
	#define MonthCal_GetCALID(hmc) cast(CALID, SNDMSG(hmc, MCM_GETCALID, 0, 0))
	const MCM_SETCALID = MCM_FIRST + 28
	#define MonthCal_SetCALID(hmc, calid) SNDMSG(hmc, MCM_SETCALID, cast(WPARAM, (calid)), 0)
	const MCM_SIZERECTTOMIN = MCM_FIRST + 29
	#define MonthCal_SizeRectToMin(hmc, prc) SNDMSG(hmc, MCM_SIZERECTTOMIN, 0, cast(LPARAM, (prc)))
	const MCM_SETCALENDARBORDER = MCM_FIRST + 30
	#define MonthCal_SetCalendarBorder(hmc, fset, xyborder) SNDMSG(hmc, MCM_SETCALENDARBORDER, cast(WPARAM, (fset)), cast(LPARAM, (xyborder)))
	const MCM_GETCALENDARBORDER = MCM_FIRST + 31
	#define MonthCal_GetCalendarBorder(hmc) clng(SNDMSG(hmc, MCM_GETCALENDARBORDER, 0, 0))
	const MCM_SETCURRENTVIEW = MCM_FIRST + 32
	#define MonthCal_SetCurrentView(hmc, dwNewView) cast(WINBOOL, SNDMSG(hmc, MCM_SETCURRENTVIEW, 0, cast(LPARAM, (dwNewView))))
#endif

type tagNMSELCHANGE
	nmhdr as NMHDR
	stSelStart as SYSTEMTIME
	stSelEnd as SYSTEMTIME
end type

type NMSELCHANGE as tagNMSELCHANGE
type LPNMSELCHANGE as tagNMSELCHANGE ptr
const MCN_SELCHANGE = culng(MCN_FIRST - 3)

type tagNMDAYSTATE
	nmhdr as NMHDR
	stStart as SYSTEMTIME
	cDayState as long
	prgDayState as LPMONTHDAYSTATE
end type

type NMDAYSTATE as tagNMDAYSTATE
type LPNMDAYSTATE as tagNMDAYSTATE ptr
const MCN_GETDAYSTATE = culng(MCN_FIRST + 3)
type NMSELECT as NMSELCHANGE
type LPNMSELECT as NMSELCHANGE ptr
const MCN_SELECT = MCN_FIRST

type tagNMVIEWCHANGE
	nmhdr as NMHDR
	dwOldView as DWORD
	dwNewView as DWORD
end type

type NMVIEWCHANGE as tagNMVIEWCHANGE
type LPNMVIEWCHANGE as tagNMVIEWCHANGE ptr
const MCN_VIEWCHANGE = culng(MCN_FIRST - 4)
const MCS_DAYSTATE = &h1
const MCS_MULTISELECT = &h2
const MCS_WEEKNUMBERS = &h4
const MCS_NOTODAYCIRCLE = &h8
const MCS_NOTODAY = &h10

#if _WIN32_WINNT >= &h0600
	const MCS_NOTRAILINGDATES = &h40
	const MCS_SHORTDAYSOFWEEK = &h80
	const MCS_NOSELCHANGEONNAV = &h100
#endif

const GMR_VISIBLE = 0
const GMR_DAYSTATE = 1
#define DATETIMEPICK_CLASSW wstr("SysDateTimePick32")
#define DATETIMEPICK_CLASSA "SysDateTimePick32"

#ifdef UNICODE
	#define DATETIMEPICK_CLASS DATETIMEPICK_CLASSW
#elseif (not defined(UNICODE)) and (_WIN32_WINNT >= &h0600)
	#define DATETIMEPICK_CLASS DATETIMEPICK_CLASSA
#endif

#if _WIN32_WINNT >= &h0600
	type tagDATETIMEPICKERINFO
		cbSize as DWORD
		rcCheck as RECT
		stateCheck as DWORD
		rcButton as RECT
		stateButton as DWORD
		hwndEdit as HWND
		hwndUD as HWND
		hwndDropDown as HWND
	end type

	type DATETIMEPICKERINFO as tagDATETIMEPICKERINFO
	type LPDATETIMEPICKERINFO as tagDATETIMEPICKERINFO ptr
#elseif (not defined(UNICODE)) and (_WIN32_WINNT <= &h0502)
	#define DATETIMEPICK_CLASS DATETIMEPICK_CLASSA
#endif

const DTM_FIRST = &h1000
const DTM_GETSYSTEMTIME = DTM_FIRST + 1
#define DateTime_GetSystemtime(hdp, pst) cast(DWORD, SNDMSG(hdp, DTM_GETSYSTEMTIME, 0, cast(LPARAM, (pst))))
const DTM_SETSYSTEMTIME = DTM_FIRST + 2
#define DateTime_SetSystemtime(hdp, gd, pst) cast(WINBOOL, SNDMSG(hdp, DTM_SETSYSTEMTIME, cast(WPARAM, (gd)), cast(LPARAM, (pst))))
const DTM_GETRANGE = DTM_FIRST + 3
#define DateTime_GetRange(hdp, rgst) cast(DWORD, SNDMSG(hdp, DTM_GETRANGE, 0, cast(LPARAM, (rgst))))
const DTM_SETRANGE = DTM_FIRST + 4
#define DateTime_SetRange(hdp, gd, rgst) cast(WINBOOL, SNDMSG(hdp, DTM_SETRANGE, cast(WPARAM, (gd)), cast(LPARAM, (rgst))))
const DTM_SETFORMATA = DTM_FIRST + 5
const DTM_SETFORMATW = DTM_FIRST + 50

#ifdef UNICODE
	const DTM_SETFORMAT = DTM_SETFORMATW
#else
	const DTM_SETFORMAT = DTM_SETFORMATA
#endif

#define DateTime_SetFormat(hdp, sz) cast(WINBOOL, SNDMSG(hdp, DTM_SETFORMAT, 0, cast(LPARAM, (sz))))
const DTM_SETMCCOLOR = DTM_FIRST + 6
#define DateTime_SetMonthCalColor(hdp, iColor, clr) SNDMSG(hdp, DTM_SETMCCOLOR, iColor, clr)
const DTM_GETMCCOLOR = DTM_FIRST + 7
#define DateTime_GetMonthCalColor(hdp, iColor) SNDMSG(hdp, DTM_GETMCCOLOR, iColor, 0)
const DTM_GETMONTHCAL = DTM_FIRST + 8
#define DateTime_GetMonthCal(hdp) cast(HWND, SNDMSG(hdp, DTM_GETMONTHCAL, 0, 0))
const DTM_SETMCFONT = DTM_FIRST + 9
#define DateTime_SetMonthCalFont(hdp, hfont, fRedraw) SNDMSG(hdp, DTM_SETMCFONT, cast(WPARAM, (hfont)), cast(LPARAM, (fRedraw)))
const DTM_GETMCFONT = DTM_FIRST + 10
#define DateTime_GetMonthCalFont(hdp) SNDMSG(hdp, DTM_GETMCFONT, 0, 0)

#if _WIN32_WINNT >= &h0600
	const DTM_SETMCSTYLE = DTM_FIRST + 11
	#define DateTime_SetMonthCalStyle(hdp, dwStyle) SNDMSG(hdp, DTM_SETMCSTYLE, 0, cast(LPARAM, dwStyle))
	const DTM_GETMCSTYLE = DTM_FIRST + 12
	#define DateTime_GetMonthCalStyle(hdp) SNDMSG(hdp, DTM_GETMCSTYLE, 0, 0)
	const DTM_CLOSEMONTHCAL = DTM_FIRST + 13
	#define DateTime_CloseMonthCal(hdp) SNDMSG(hdp, DTM_CLOSEMONTHCAL, 0, 0)
	const DTM_GETDATETIMEPICKERINFO = DTM_FIRST + 14
	#define DateTime_GetDateTimePickerInfo(hdp, pdtpi) SNDMSG(hdp, DTM_GETDATETIMEPICKERINFO, 0, cast(LPARAM, (pdtpi)))
	const DTM_GETIDEALSIZE = DTM_FIRST + 15
	#define DateTime_GetIdealSize(hdp, psize) cast(WINBOOL, SNDMSG((hdp), DTM_GETIDEALSIZE, 0, cast(LPARAM, (psize))))
#endif

const DTS_UPDOWN = &h1
const DTS_SHOWNONE = &h2
const DTS_SHORTDATEFORMAT = &h0
const DTS_LONGDATEFORMAT = &h4
const DTS_SHORTDATECENTURYFORMAT = &hc
const DTS_TIMEFORMAT = &h9
const DTS_APPCANPARSE = &h10
const DTS_RIGHTALIGN = &h20
const DTN_DATETIMECHANGE = culng(DTN_FIRST2 - 6)

type tagNMDATETIMECHANGE
	nmhdr as NMHDR
	dwFlags as DWORD
	st as SYSTEMTIME
end type

type NMDATETIMECHANGE as tagNMDATETIMECHANGE
type LPNMDATETIMECHANGE as tagNMDATETIMECHANGE ptr
const DTN_USERSTRINGA = culng(DTN_FIRST2 - 5)
const DTN_USERSTRINGW = culng(DTN_FIRST - 5)

type tagNMDATETIMESTRINGA
	nmhdr as NMHDR
	pszUserString as LPCSTR
	st as SYSTEMTIME
	dwFlags as DWORD
end type

type NMDATETIMESTRINGA as tagNMDATETIMESTRINGA
type LPNMDATETIMESTRINGA as tagNMDATETIMESTRINGA ptr

type tagNMDATETIMESTRINGW
	nmhdr as NMHDR
	pszUserString as LPCWSTR
	st as SYSTEMTIME
	dwFlags as DWORD
end type

type NMDATETIMESTRINGW as tagNMDATETIMESTRINGW
type LPNMDATETIMESTRINGW as tagNMDATETIMESTRINGW ptr

#ifdef UNICODE
	const DTN_USERSTRING = DTN_USERSTRINGW
	type NMDATETIMESTRING as NMDATETIMESTRINGW
	type LPNMDATETIMESTRING as LPNMDATETIMESTRINGW
#else
	const DTN_USERSTRING = DTN_USERSTRINGA
	type NMDATETIMESTRING as NMDATETIMESTRINGA
	type LPNMDATETIMESTRING as LPNMDATETIMESTRINGA
#endif

const DTN_WMKEYDOWNA = culng(DTN_FIRST2 - 4)
const DTN_WMKEYDOWNW = culng(DTN_FIRST - 4)

type tagNMDATETIMEWMKEYDOWNA
	nmhdr as NMHDR
	nVirtKey as long
	pszFormat as LPCSTR
	st as SYSTEMTIME
end type

type NMDATETIMEWMKEYDOWNA as tagNMDATETIMEWMKEYDOWNA
type LPNMDATETIMEWMKEYDOWNA as tagNMDATETIMEWMKEYDOWNA ptr

type tagNMDATETIMEWMKEYDOWNW
	nmhdr as NMHDR
	nVirtKey as long
	pszFormat as LPCWSTR
	st as SYSTEMTIME
end type

type NMDATETIMEWMKEYDOWNW as tagNMDATETIMEWMKEYDOWNW
type LPNMDATETIMEWMKEYDOWNW as tagNMDATETIMEWMKEYDOWNW ptr

#ifdef UNICODE
	const DTN_WMKEYDOWN = DTN_WMKEYDOWNW
	type NMDATETIMEWMKEYDOWN as NMDATETIMEWMKEYDOWNW
	type LPNMDATETIMEWMKEYDOWN as LPNMDATETIMEWMKEYDOWNW
#else
	const DTN_WMKEYDOWN = DTN_WMKEYDOWNA
	type NMDATETIMEWMKEYDOWN as NMDATETIMEWMKEYDOWNA
	type LPNMDATETIMEWMKEYDOWN as LPNMDATETIMEWMKEYDOWNA
#endif

const DTN_FORMATA = culng(DTN_FIRST2 - 3)
const DTN_FORMATW = culng(DTN_FIRST - 3)

type tagNMDATETIMEFORMATA
	nmhdr as NMHDR
	pszFormat as LPCSTR
	st as SYSTEMTIME
	pszDisplay as LPCSTR
	szDisplay as zstring * 64
end type

type NMDATETIMEFORMATA as tagNMDATETIMEFORMATA
type LPNMDATETIMEFORMATA as tagNMDATETIMEFORMATA ptr

type tagNMDATETIMEFORMATW
	nmhdr as NMHDR
	pszFormat as LPCWSTR
	st as SYSTEMTIME
	pszDisplay as LPCWSTR
	szDisplay as wstring * 64
end type

type NMDATETIMEFORMATW as tagNMDATETIMEFORMATW
type LPNMDATETIMEFORMATW as tagNMDATETIMEFORMATW ptr

#ifdef UNICODE
	const DTN_FORMAT = DTN_FORMATW
	type NMDATETIMEFORMAT as NMDATETIMEFORMATW
	type LPNMDATETIMEFORMAT as LPNMDATETIMEFORMATW
#else
	const DTN_FORMAT = DTN_FORMATA
	type NMDATETIMEFORMAT as NMDATETIMEFORMATA
	type LPNMDATETIMEFORMAT as LPNMDATETIMEFORMATA
#endif

const DTN_FORMATQUERYA = culng(DTN_FIRST2 - 2)
const DTN_FORMATQUERYW = culng(DTN_FIRST - 2)

type tagNMDATETIMEFORMATQUERYA
	nmhdr as NMHDR
	pszFormat as LPCSTR
	szMax as SIZE
end type

type NMDATETIMEFORMATQUERYA as tagNMDATETIMEFORMATQUERYA
type LPNMDATETIMEFORMATQUERYA as tagNMDATETIMEFORMATQUERYA ptr

type tagNMDATETIMEFORMATQUERYW
	nmhdr as NMHDR
	pszFormat as LPCWSTR
	szMax as SIZE
end type

type NMDATETIMEFORMATQUERYW as tagNMDATETIMEFORMATQUERYW
type LPNMDATETIMEFORMATQUERYW as tagNMDATETIMEFORMATQUERYW ptr

#ifdef UNICODE
	const DTN_FORMATQUERY = DTN_FORMATQUERYW
	type NMDATETIMEFORMATQUERY as NMDATETIMEFORMATQUERYW
	type LPNMDATETIMEFORMATQUERY as LPNMDATETIMEFORMATQUERYW
#else
	const DTN_FORMATQUERY = DTN_FORMATQUERYA
	type NMDATETIMEFORMATQUERY as NMDATETIMEFORMATQUERYA
	type LPNMDATETIMEFORMATQUERY as LPNMDATETIMEFORMATQUERYA
#endif

const DTN_DROPDOWN = culng(DTN_FIRST2 - 1)
const DTN_CLOSEUP = DTN_FIRST2
const GDTR_MIN = &h1
const GDTR_MAX = &h2
const GDT_ERROR = -1
const GDT_VALID = 0
const GDT_NONE = 1
const IPM_CLEARADDRESS = WM_USER + 100
const IPM_SETADDRESS = WM_USER + 101
const IPM_GETADDRESS = WM_USER + 102
const IPM_SETRANGE = WM_USER + 103
const IPM_SETFOCUS = WM_USER + 104
const IPM_ISBLANK = WM_USER + 105
#define WC_IPADDRESSW wstr("SysIPAddress32")
#define WC_IPADDRESSA "SysIPAddress32"

#ifdef UNICODE
	#define WC_IPADDRESS WC_IPADDRESSW
#else
	#define WC_IPADDRESS WC_IPADDRESSA
#endif

const IPN_FIELDCHANGED = culng(IPN_FIRST - 0)

type tagNMIPADDRESS
	hdr as NMHDR
	iField as long
	iValue as long
end type

type NMIPADDRESS as tagNMIPADDRESS
type LPNMIPADDRESS as tagNMIPADDRESS ptr
#define MAKEIPRANGE(low, high) cast(LPARAM, cast(WORD, (cast(UBYTE, (high)) shl 8) + cast(UBYTE, (low))))
#define MAKEIPADDRESS(b1, b2, b3, b4) cast(LPARAM, (((cast(DWORD, (b1)) shl 24) + (cast(DWORD, (b2)) shl 16)) + (cast(DWORD, (b3)) shl 8)) + cast(DWORD, (b4)))
#define FIRST_IPADDRESS(x) ((x shr 24) and &hff)
#define SECOND_IPADDRESS(x) ((x shr 16) and &hff)
#define THIRD_IPADDRESS(x) ((x shr 8) and &hff)
#define FOURTH_IPADDRESS(x) (x and &hff)
#define WC_PAGESCROLLERW wstr("SysPager")
#define WC_PAGESCROLLERA "SysPager"

#ifdef UNICODE
	#define WC_PAGESCROLLER WC_PAGESCROLLERW
#else
	#define WC_PAGESCROLLER WC_PAGESCROLLERA
#endif

const PGS_VERT = &h0
const PGS_HORZ = &h1
const PGS_AUTOSCROLL = &h2
const PGS_DRAGNDROP = &h4
const PGF_INVISIBLE = 0
const PGF_NORMAL = 1
const PGF_GRAYED = 2
const PGF_DEPRESSED = 4
const PGF_HOT = 8
const PGB_TOPORLEFT = 0
const PGB_BOTTOMORRIGHT = 1
const PGM_SETCHILD = PGM_FIRST + 1
#define Pager_SetChild(hwnd, hwndChild) SNDMSG((hwnd), PGM_SETCHILD, 0, cast(LPARAM, (hwndChild)))
const PGM_RECALCSIZE = PGM_FIRST + 2
#define Pager_RecalcSize(hwnd) SNDMSG((hwnd), PGM_RECALCSIZE, 0, 0)
const PGM_FORWARDMOUSE = PGM_FIRST + 3
#define Pager_ForwardMouse(hwnd, bForward) SNDMSG((hwnd), PGM_FORWARDMOUSE, cast(WPARAM, (bForward)), 0)
const PGM_SETBKCOLOR = PGM_FIRST + 4
#define Pager_SetBkColor(hwnd, clr) cast(COLORREF, SNDMSG((hwnd), PGM_SETBKCOLOR, 0, cast(LPARAM, (clr))))
const PGM_GETBKCOLOR = PGM_FIRST + 5
#define Pager_GetBkColor(hwnd) cast(COLORREF, SNDMSG((hwnd), PGM_GETBKCOLOR, 0, 0))
const PGM_SETBORDER = PGM_FIRST + 6
#define Pager_SetBorder(hwnd, iBorder) clng(SNDMSG((hwnd), PGM_SETBORDER, 0, cast(LPARAM, (iBorder))))
const PGM_GETBORDER = PGM_FIRST + 7
#define Pager_GetBorder(hwnd) clng(SNDMSG((hwnd), PGM_GETBORDER, 0, 0))
const PGM_SETPOS = PGM_FIRST + 8
#define Pager_SetPos(hwnd, iPos) clng(SNDMSG((hwnd), PGM_SETPOS, 0, cast(LPARAM, (iPos))))
const PGM_GETPOS = PGM_FIRST + 9
#define Pager_GetPos(hwnd) clng(SNDMSG((hwnd), PGM_GETPOS, 0, 0))
const PGM_SETBUTTONSIZE = PGM_FIRST + 10
#define Pager_SetButtonSize(hwnd, iSize) clng(SNDMSG((hwnd), PGM_SETBUTTONSIZE, 0, cast(LPARAM, (iSize))))
const PGM_GETBUTTONSIZE = PGM_FIRST + 11
#define Pager_GetButtonSize(hwnd) clng(SNDMSG((hwnd), PGM_GETBUTTONSIZE, 0, 0))
const PGM_GETBUTTONSTATE = PGM_FIRST + 12
#define Pager_GetButtonState(hwnd, iButton) cast(DWORD, SNDMSG((hwnd), PGM_GETBUTTONSTATE, 0, cast(LPARAM, (iButton))))
const PGM_GETDROPTARGET = CCM_GETDROPTARGET
#define Pager_GetDropTarget(hwnd, ppdt) SNDMSG((hwnd), PGM_GETDROPTARGET, 0, cast(LPARAM, (ppdt)))
const PGM_SETSCROLLINFO = PGM_FIRST + 13
#define Pager_SetScrollInfo(hwnd, cTimeOut, cLinesPer, cPixelsPerLine) SNDMSG((hwnd), PGM_SETSCROLLINFO, cTimeOut, MAKELONG(cLinesPer, cPixelsPerLine))
const PGN_SCROLL = culng(PGN_FIRST - 1)
const PGF_SCROLLUP = 1
const PGF_SCROLLDOWN = 2
const PGF_SCROLLLEFT = 4
const PGF_SCROLLRIGHT = 8
const PGK_SHIFT = 1
const PGK_CONTROL = 2
const PGK_MENU = 4

type NMPGSCROLL field = 1
	hdr as NMHDR
	fwKeys as WORD
	rcParent as RECT
	iDir as long
	iXpos as long
	iYpos as long
	iScroll as long
end type

type LPNMPGSCROLL as NMPGSCROLL ptr
const PGN_CALCSIZE = culng(PGN_FIRST - 2)
const PGF_CALCWIDTH = 1
const PGF_CALCHEIGHT = 2

type NMPGCALCSIZE
	hdr as NMHDR
	dwFlag as DWORD
	iWidth as long
	iHeight as long
end type

type LPNMPGCALCSIZE as NMPGCALCSIZE ptr
const PGN_HOTITEMCHANGE = culng(PGN_FIRST - 3)

type tagNMPGHOTITEM
	hdr as NMHDR
	idOld as long
	idNew as long
	dwFlags as DWORD
end type

type NMPGHOTITEM as tagNMPGHOTITEM
type LPNMPGHOTITEM as tagNMPGHOTITEM ptr
#define WC_NATIVEFONTCTLW wstr("NativeFontCtl")
#define WC_NATIVEFONTCTLA "NativeFontCtl"

#ifdef UNICODE
	#define WC_NATIVEFONTCTL WC_NATIVEFONTCTLW
#else
	#define WC_NATIVEFONTCTL WC_NATIVEFONTCTLA
#endif

const NFS_EDIT = &h1
const NFS_STATIC = &h2
const NFS_LISTCOMBO = &h4
const NFS_BUTTON = &h8
const NFS_ALL = &h10
const NFS_USEFONTASSOC = &h20
#define WC_BUTTONA "Button"
#define WC_BUTTONW wstr("Button")

#ifdef UNICODE
	#define WC_BUTTON WC_BUTTONW
#else
	#define WC_BUTTON WC_BUTTONA
#endif

const BUTTON_IMAGELIST_ALIGN_LEFT = 0
const BUTTON_IMAGELIST_ALIGN_RIGHT = 1
const BUTTON_IMAGELIST_ALIGN_TOP = 2
const BUTTON_IMAGELIST_ALIGN_BOTTOM = 3
const BUTTON_IMAGELIST_ALIGN_CENTER = 4

type BUTTON_IMAGELIST
	himl as HIMAGELIST
	margin as RECT
	uAlign as UINT
end type

type PBUTTON_IMAGELIST as BUTTON_IMAGELIST ptr
const BCM_GETIDEALSIZE = BCM_FIRST + &h1
#define Button_GetIdealSize(hwnd, psize) cast(WINBOOL, SNDMSG((hwnd), BCM_GETIDEALSIZE, 0, cast(LPARAM, (psize))))
const BCM_SETIMAGELIST = BCM_FIRST + &h2
#define Button_SetImageList(hwnd, pbuttonImagelist) cast(WINBOOL, SNDMSG((hwnd), BCM_SETIMAGELIST, 0, cast(LPARAM, (pbuttonImagelist))))
const BCM_GETIMAGELIST = BCM_FIRST + &h3
#define Button_GetImageList(hwnd, pbuttonImagelist) cast(WINBOOL, SNDMSG((hwnd), BCM_GETIMAGELIST, 0, cast(LPARAM, (pbuttonImagelist))))
const BCM_SETTEXTMARGIN = BCM_FIRST + &h4
#define Button_SetTextMargin(hwnd, pmargin) cast(WINBOOL, SNDMSG((hwnd), BCM_SETTEXTMARGIN, 0, cast(LPARAM, (pmargin))))
const BCM_GETTEXTMARGIN = BCM_FIRST + &h5
#define Button_GetTextMargin(hwnd, pmargin) cast(WINBOOL, SNDMSG((hwnd), BCM_GETTEXTMARGIN, 0, cast(LPARAM, (pmargin))))

type tagNMBCHOTITEM
	hdr as NMHDR
	dwFlags as DWORD
end type

type NMBCHOTITEM as tagNMBCHOTITEM
type LPNMBCHOTITEM as tagNMBCHOTITEM ptr
const BCN_HOTITEMCHANGE = culng(BCN_FIRST + &h1)
const BST_HOT = &h0200

#if _WIN32_WINNT >= &h0600
	const BST_DROPDOWNPUSHED = &h0400
	const BS_SPLITBUTTON = &hc
	const BS_DEFSPLITBUTTON = &hd
	const BS_COMMANDLINK = &he
	const BS_DEFCOMMANDLINK = &hf
	const BCSIF_GLYPH = &h0001
	const BCSIF_IMAGE = &h0002
	const BCSIF_STYLE = &h0004
	const BCSIF_SIZE = &h0008
	const BCSS_NOSPLIT = &h0001
	const BCSS_STRETCH = &h0002
	const BCSS_ALIGNLEFT = &h0004
	const BCSS_IMAGE = &h0008

	type tagBUTTON_SPLITINFO
		mask as UINT
		himlGlyph as HIMAGELIST
		uSplitStyle as UINT
		size as SIZE
	end type

	type BUTTON_SPLITINFO as tagBUTTON_SPLITINFO
	type PBUTTON_SPLITINFO as tagBUTTON_SPLITINFO ptr
	const BCM_SETDROPDOWNSTATE = BCM_FIRST + &h6
	#define Button_SetDropDownState(hwnd, fDropDown) cast(WINBOOL, SNDMSG((hwnd), BCM_SETDROPDOWNSTATE, cast(WPARAM, (fDropDown)), 0))
	const BCM_SETSPLITINFO = BCM_FIRST + &h7
	#define Button_SetSplitInfo(hwnd, pInfo) cast(WINBOOL, SNDMSG((hwnd), BCM_SETSPLITINFO, 0, cast(LPARAM, (pInfo))))
	const BCM_GETSPLITINFO = BCM_FIRST + &h8
	#define Button_GetSplitInfo(hwnd, pInfo) cast(WINBOOL, SNDMSG((hwnd), BCM_GETSPLITINFO, 0, cast(LPARAM, (pInfo))))
	const BCM_SETNOTE = BCM_FIRST + &h9
	#define Button_SetNote(hwnd, psz) cast(WINBOOL, SNDMSG((hwnd), BCM_SETNOTE, 0, cast(LPARAM, (psz))))
	const BCM_GETNOTE = BCM_FIRST + &ha
	#define Button_GetNote(hwnd, psz, pcc) cast(WINBOOL, SNDMSG((hwnd), BCM_GETNOTE, cast(WPARAM, pcc), cast(LPARAM, psz)))
	const BCM_GETNOTELENGTH = BCM_FIRST + &hb
	#define Button_GetNoteLength(hwnd) cast(LRESULT, SNDMSG((hwnd), BCM_GETNOTELENGTH, 0, 0))
	const BCM_SETSHIELD = BCM_FIRST + &hc
	#define Button_SetElevationRequiredState(hwnd, fRequired) cast(LRESULT, SNDMSG((hwnd), BCM_SETSHIELD, 0, cast(LPARAM, fRequired)))
	const BCCL_NOGLYPH = cast(HIMAGELIST, -1)

	type tagNMBCDROPDOWN
		hdr as NMHDR
		rcButton as RECT
	end type

	type NMBCDROPDOWN as tagNMBCDROPDOWN
	type LPNMBCDROPDOWN as tagNMBCDROPDOWN ptr
	const BCN_DROPDOWN = culng(BCN_FIRST + &h0002)
#endif

#define WC_STATICA "Static"
#define WC_STATICW wstr("Static")

#ifdef UNICODE
	#define WC_STATIC WC_STATICW
#else
	#define WC_STATIC WC_STATICA
#endif

#define WC_EDITA "Edit"
#define WC_EDITW wstr("Edit")

#ifdef UNICODE
	#define WC_EDIT WC_EDITW
#else
	#define WC_EDIT WC_EDITA
#endif

const EM_SETCUEBANNER = ECM_FIRST + 1
#define Edit_SetCueBannerText(hwnd, lpcwText) cast(WINBOOL, SNDMSG((hwnd), EM_SETCUEBANNER, 0, cast(LPARAM, (lpcwText))))
const EM_GETCUEBANNER = ECM_FIRST + 2
#define Edit_GetCueBannerText(hwnd, lpwText, cchText) cast(WINBOOL, SNDMSG((hwnd), EM_GETCUEBANNER, cast(WPARAM, (lpwText)), cast(LPARAM, (cchText))))

type _tagEDITBALLOONTIP
	cbStruct as DWORD
	pszTitle as LPCWSTR
	pszText as LPCWSTR
	ttiIcon as INT_
end type

type EDITBALLOONTIP as _tagEDITBALLOONTIP
type PEDITBALLOONTIP as _tagEDITBALLOONTIP ptr
const EM_SHOWBALLOONTIP = ECM_FIRST + 3
#define Edit_ShowBalloonTip(hwnd, peditballoontip) cast(WINBOOL, SNDMSG((hwnd), EM_SHOWBALLOONTIP, 0, cast(LPARAM, (peditballoontip))))
const EM_HIDEBALLOONTIP = ECM_FIRST + 4
#define Edit_HideBalloonTip(hwnd) cast(WINBOOL, SNDMSG((hwnd), EM_HIDEBALLOONTIP, 0, 0))

#if _WIN32_WINNT >= &h0600
	const EM_SETHILITE = ECM_FIRST + 5
	#define Edit_SetHilite(hwndCtl, ichStart, ichEnd) SNDMSG((hwndCtl), EM_SETHILITE, (ichStart), (ichEnd))
	const EM_GETHILITE = ECM_FIRST + 6
	#define Edit_GetHilite(hwndCtl) cast(DWORD, SNDMSG((hwndCtl), EM_GETHILITE, cast(WPARAM, 0), cast(LPARAM, 0)))
#endif

const EM_NOSETFOCUS = ECM_FIRST + 7
#define Edit_NoSetFocus(hwndCtl) cast(DWORD, SNDMSG((hwndCtl), EM_NOSETFOCUS, cast(WPARAM, 0), cast(LPARAM, 0)))
const EM_TAKEFOCUS = ECM_FIRST + 8
#define Edit_TakeFocus(hwndCtl) cast(DWORD, SNDMSG((hwndCtl), EM_TAKEFOCUS, cast(WPARAM, 0), cast(LPARAM, 0)))
#define WC_LISTBOXA "ListBox"
#define WC_LISTBOXW wstr("ListBox")

#ifdef UNICODE
	#define WC_LISTBOX WC_LISTBOXW
#else
	#define WC_LISTBOX WC_LISTBOXA
#endif

#define WC_COMBOBOXA "ComboBox"
#define WC_COMBOBOXW wstr("ComboBox")

#ifdef UNICODE
	#define WC_COMBOBOX WC_COMBOBOXW
#else
	#define WC_COMBOBOX WC_COMBOBOXA
#endif

const CB_SETMINVISIBLE = CBM_FIRST + 1
const CB_GETMINVISIBLE = CBM_FIRST + 2
const CB_SETCUEBANNER = CBM_FIRST + 3
const CB_GETCUEBANNER = CBM_FIRST + 4
#define ComboBox_SetMinVisible(hwnd, iMinVisible) cast(WINBOOL, SNDMSG((hwnd), CB_SETMINVISIBLE, cast(WPARAM, (iMinVisible)), 0))
#define ComboBox_GetMinVisible(hwnd) clng(SNDMSG((hwnd), CB_GETMINVISIBLE, 0, 0))
#define ComboBox_SetCueBannerText(hwnd, lpcwText) cast(WINBOOL, SNDMSG((hwnd), CB_SETCUEBANNER, 0, cast(LPARAM, (lpcwText))))
#define ComboBox_GetCueBannerText(hwnd, lpwText, cchText) cast(WINBOOL, SNDMSG((hwnd), CB_GETCUEBANNER, cast(WPARAM, (lpwText)), cast(LPARAM, (cchText))))
#define WC_SCROLLBARA "ScrollBar"
#define WC_SCROLLBARW wstr("ScrollBar")

#ifdef UNICODE
	#define WC_SCROLLBAR WC_SCROLLBARW
#else
	#define WC_SCROLLBAR WC_SCROLLBARA
#endif

const LWS_TRANSPARENT = &h1
const LWS_IGNORERETURN = &h2

#if _WIN32_WINNT >= &h0600
	const LWS_NOPREFIX = &h4
	const LWS_USEVISUALSTYLE = &h8
	const LWS_USECUSTOMTEXT = &h10
	const LWS_RIGHT = &h20
#endif

const LIF_ITEMINDEX = &h1
const LIF_STATE = &h2
const LIF_ITEMID = &h4
const LIF_URL = &h8
const LIS_FOCUSED = &h1
const LIS_ENABLED = &h2
const LIS_VISITED = &h4

#if _WIN32_WINNT >= &h0600
	const LIS_HOTTRACK = &h8
	const LIS_DEFAULTCOLORS = &h10
#endif

const LM_HITTEST = WM_USER + &h300
const LM_GETIDEALHEIGHT = WM_USER + &h301
const LM_SETITEM = WM_USER + &h302
const LM_GETITEM = WM_USER + &h303

#if _WIN32_WINNT >= &h0600
	type PFTASKDIALOGCALLBACK as function(byval hwnd as HWND, byval msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM, byval lpRefData as LONG_PTR) as HRESULT

	type _TASKDIALOG_FLAGS as long
	enum
		TDF_ENABLE_HYPERLINKS = &h1
		TDF_USE_HICON_MAIN = &h2
		TDF_USE_HICON_FOOTER = &h4
		TDF_ALLOW_DIALOG_CANCELLATION = &h8
		TDF_USE_COMMAND_LINKS = &h10
		TDF_USE_COMMAND_LINKS_NO_ICON = &h20
		TDF_EXPAND_FOOTER_AREA = &h40
		TDF_EXPANDED_BY_DEFAULT = &h80
		TDF_VERIFICATION_FLAG_CHECKED = &h100
		TDF_SHOW_PROGRESS_BAR = &h0200
		TDF_SHOW_MARQUEE_PROGRESS_BAR = &h0400
		TDF_CALLBACK_TIMER = &h0800
		TDF_POSITION_RELATIVE_TO_WINDOW = &h1000
		TDF_RTL_LAYOUT = &h2000
		TDF_NO_DEFAULT_RADIO_BUTTON = &h4000
		TDF_CAN_BE_MINIMIZED = &h8000

		#if _WIN32_WINNT = &h0602
			TDF_NO_SET_FOREGROUND = &h10000
		#endif

		TDF_SIZE_TO_CONTENT = &h1000000
	end enum

	type TASKDIALOG_FLAGS as long

	type _TASKDIALOG_MESSAGES as long
	enum
		TDM_NAVIGATE_PAGE = &h0400 + 101
		TDM_CLICK_BUTTON = &h0400 + 102
		TDM_SET_MARQUEE_PROGRESS_BAR = &h0400 + 103
		TDM_SET_PROGRESS_BAR_STATE = &h0400 + 104
		TDM_SET_PROGRESS_BAR_RANGE = &h0400 + 105
		TDM_SET_PROGRESS_BAR_POS = &h0400 + 106
		TDM_SET_PROGRESS_BAR_MARQUEE = &h0400 + 107
		TDM_SET_ELEMENT_TEXT = &h0400 + 108
		TDM_CLICK_RADIO_BUTTON = &h0400 + 110
		TDM_ENABLE_BUTTON = &h0400 + 111
		TDM_ENABLE_RADIO_BUTTON = &h0400 + 112
		TDM_CLICK_VERIFICATION = &h0400 + 113
		TDM_UPDATE_ELEMENT_TEXT = &h0400 + 114
		TDM_SET_BUTTON_ELEVATION_REQUIRED_STATE = &h0400 + 115
		TDM_UPDATE_ICON = &h0400 + 116
	end enum

	type TASKDIALOG_MESSAGES as _TASKDIALOG_MESSAGES

	type _TASKDIALOG_NOTIFICATIONS as long
	enum
		TDN_CREATED = 0
		TDN_NAVIGATED = 1
		TDN_BUTTON_CLICKED = 2
		TDN_HYPERLINK_CLICKED = 3
		TDN_TIMER = 4
		TDN_DESTROYED = 5
		TDN_RADIO_BUTTON_CLICKED = 6
		TDN_DIALOG_CONSTRUCTED = 7
		TDN_VERIFICATION_CLICKED = 8
		TDN_HELP = 9
		TDN_EXPANDO_BUTTON_CLICKED = 10
	end enum

	type TASKDIALOG_NOTIFICATIONS as _TASKDIALOG_NOTIFICATIONS

	type _TASKDIALOG_BUTTON field = 1
		nButtonID as long
		pszButtonText as PCWSTR
	end type

	type TASKDIALOG_BUTTON as _TASKDIALOG_BUTTON

	type _TASKDIALOG_ELEMENTS as long
	enum
		TDE_CONTENT
		TDE_EXPANDED_INFORMATION
		TDE_FOOTER
		TDE_MAIN_INSTRUCTION
	end enum

	type TASKDIALOG_ELEMENTS as _TASKDIALOG_ELEMENTS

	type _TASKDIALOG_ICON_ELEMENTS as long
	enum
		TDIE_ICON_MAIN
		TDIE_ICON_FOOTER
	end enum

	type TASKDIALOG_ICON_ELEMENTS as _TASKDIALOG_ICON_ELEMENTS
	#define TD_WARNING_ICON MAKEINTRESOURCEW(-1)
	#define TD_ERROR_ICON MAKEINTRESOURCEW(-2)
	#define TD_INFORMATION_ICON MAKEINTRESOURCEW(-3)
	#define TD_SHIELD_ICON MAKEINTRESOURCEW(-4)

	type _TASKDIALOG_COMMON_BUTTON_FLAGS as long
	enum
		TDCBF_OK_BUTTON = &h1
		TDCBF_YES_BUTTON = &h2
		TDCBF_NO_BUTTON = &h4
		TDCBF_CANCEL_BUTTON = &h8
		TDCBF_RETRY_BUTTON = &h10
		TDCBF_CLOSE_BUTTON = &h20
	end enum

	type TASKDIALOG_COMMON_BUTTON_FLAGS as long

	type _TASKDIALOGCONFIG field = 1
		cbSize as UINT
		hwndParent as HWND
		hInstance as HINSTANCE
		dwFlags as TASKDIALOG_FLAGS
		dwCommonButtons as TASKDIALOG_COMMON_BUTTON_FLAGS
		pszWindowTitle as PCWSTR

		union field = 1
			hMainIcon as HICON
			pszMainIcon as PCWSTR
		end union

		pszMainInstruction as PCWSTR
		pszContent as PCWSTR
		cButtons as UINT
		pButtons as const TASKDIALOG_BUTTON ptr
		nDefaultButton as long
		cRadioButtons as UINT
		pRadioButtons as const TASKDIALOG_BUTTON ptr
		nDefaultRadioButton as long
		pszVerificationText as PCWSTR
		pszExpandedInformation as PCWSTR
		pszExpandedControlText as PCWSTR
		pszCollapsedControlText as PCWSTR

		union field = 1
			hFooterIcon as HICON
			pszFooterIcon as PCWSTR
		end union

		pszFooter as PCWSTR
		pfCallback as PFTASKDIALOGCALLBACK
		lpCallbackData as LONG_PTR
		cxWidth as UINT
	end type

	type TASKDIALOGCONFIG as _TASKDIALOGCONFIG
	declare function TaskDialogIndirect(byval pTaskConfig as const TASKDIALOGCONFIG ptr, byval pnButton as long ptr, byval pnRadioButton as long ptr, byval pfVerificationFlagChecked as WINBOOL ptr) as HRESULT
	declare function TaskDialog(byval hwndOwner as HWND, byval hInstance as HINSTANCE, byval pszWindowTitle as PCWSTR, byval pszMainInstruction as PCWSTR, byval pszContent as PCWSTR, byval dwCommonButtons as TASKDIALOG_COMMON_BUTTON_FLAGS, byval pszIcon as PCWSTR, byval pnButton as long ptr) as HRESULT
#endif

declare sub InitMUILanguage(byval uiLang as LANGID)
declare function GetMUILanguage() as LANGID
#define __COMMCTRL_DA_DEFINED__
const DA_LAST = &h7fffffff
const DA_ERR = -1

type PFNDAENUMCALLBACK as function(byval p as any ptr, byval pData as any ptr) as long
type PFNDAENUMCALLBACKCONST as function(byval p as const any ptr, byval pData as any ptr) as long
type PFNDACOMPARE as function(byval p1 as any ptr, byval p2 as any ptr, byval lParam as LPARAM) as long
type PFNDACOMPARECONST as function(byval p1 as const any ptr, byval p2 as const any ptr, byval lParam as LPARAM) as long
type HDSA as _DSA ptr

declare function DSA_Create(byval cbItem as long, byval cItemGrow as long) as HDSA
declare function DSA_Destroy(byval hdsa as HDSA) as WINBOOL
declare sub DSA_DestroyCallback(byval hdsa as HDSA, byval pfnCB as PFNDAENUMCALLBACK, byval pData as any ptr)
declare function DSA_DeleteItem(byval hdsa as HDSA, byval i as long) as WINBOOL
declare function DSA_DeleteAllItems(byval hdsa as HDSA) as WINBOOL
declare sub DSA_EnumCallback(byval hdsa as HDSA, byval pfnCB as PFNDAENUMCALLBACK, byval pData as any ptr)
declare function DSA_InsertItem(byval hdsa as HDSA, byval i as long, byval pitem as const any ptr) as long
declare function DSA_GetItemPtr(byval hdsa as HDSA, byval i as long) as PVOID
declare function DSA_GetItem(byval hdsa as HDSA, byval i as long, byval pitem as any ptr) as WINBOOL
declare function DSA_SetItem(byval hdsa as HDSA, byval i as long, byval pitem as const any ptr) as WINBOOL
#define DSA_GetItemCount(hdsa) (*cptr(long ptr, (hdsa)))
#define DSA_AppendItem(hdsa, pitem) DSA_InsertItem(hdsa, DA_LAST, pitem)

#if _WIN32_WINNT >= &h0600
	declare function DSA_Clone(byval hdsa as HDSA) as HDSA
	declare function DSA_GetSize(byval hdsa as HDSA) as ULONGLONG
	declare function DSA_Sort(byval pdsa as HDSA, byval pfnCompare as PFNDACOMPARE, byval lParam as LPARAM) as WINBOOL
#endif

const DSA_APPEND = DA_LAST
const DSA_ERR = DA_ERR
type PFNDSAENUMCALLBACK as PFNDAENUMCALLBACK
type PFNDSAENUMCALLBACKCONST as PFNDAENUMCALLBACKCONST
type PFNDSACOMPARE as PFNDACOMPARE
type PFNDSACOMPARECONST as PFNDACOMPARECONST
type HDPA as _DPA ptr

declare function DPA_Create(byval cItemGrow as long) as HDPA
declare function DPA_CreateEx(byval cpGrow as long, byval hheap as HANDLE) as HDPA
declare function DPA_Clone(byval hdpa as const HDPA, byval hdpaNew as HDPA) as HDPA
declare function DPA_Destroy(byval hdpa as HDPA) as WINBOOL
declare sub DPA_DestroyCallback(byval hdpa as HDPA, byval pfnCB as PFNDAENUMCALLBACK, byval pData as any ptr)
declare function DPA_DeletePtr(byval hdpa as HDPA, byval i as long) as PVOID
declare function DPA_DeleteAllPtrs(byval hdpa as HDPA) as WINBOOL
declare sub DPA_EnumCallback(byval hdpa as HDPA, byval pfnCB as PFNDAENUMCALLBACK, byval pData as any ptr)
declare function DPA_Grow(byval pdpa as HDPA, byval cp as long) as WINBOOL
declare function DPA_InsertPtr(byval hdpa as HDPA, byval i as long, byval p as any ptr) as long
declare function DPA_SetPtr(byval hdpa as HDPA, byval i as long, byval p as any ptr) as WINBOOL
declare function DPA_GetPtr(byval hdpa as HDPA, byval i as INT_PTR) as PVOID
declare function DPA_GetPtrIndex(byval hdpa as HDPA, byval p as const any ptr) as long

#define DPA_GetPtrCount(hdpa) (*cptr(long ptr, (hdpa)))
#define DPA_SetPtrCount(hdpa, cItems) scope : (*cptr(long ptr, (hdpa))) = (cItems) : end scope
#define DPA_FastDeleteLastPtr(hdpa) scope : *cptr(long ptr, (hdpa)) -= 1 : end scope
#define DPA_GetPtrPtr(hdpa) (*cptr(any ptr ptr ptr, cptr(UBYTE ptr, (hdpa)) + sizeof(any ptr)))
#define DPA_FastGetPtr(hdpa, i) DPA_GetPtrPtr(hdpa)[i]
#define DPA_AppendPtr(hdpa, pitem) DPA_InsertPtr(hdpa, DA_LAST, pitem)

#if _WIN32_WINNT >= &h0600
	declare function DPA_GetSize(byval hdpa as HDPA) as ULONGLONG
#endif

declare function DPA_Sort(byval hdpa as HDPA, byval pfnCompare as PFNDACOMPARE, byval lParam as LPARAM) as WINBOOL

type _DPASTREAMINFO
	iPos as long
	pvItem as any ptr
end type

type DPASTREAMINFO as _DPASTREAMINFO
type PFNDPASTREAM as function(byval pinfo as DPASTREAMINFO ptr, byval pstream as IStream ptr, byval pvInstData as any ptr) as HRESULT
declare function DPA_LoadStream(byval phdpa as HDPA ptr, byval pfn as PFNDPASTREAM, byval pstream as IStream ptr, byval pvInstData as any ptr) as HRESULT
declare function DPA_SaveStream(byval hdpa as HDPA, byval pfn as PFNDPASTREAM, byval pstream as IStream ptr, byval pvInstData as any ptr) as HRESULT
const DPAM_SORTED = &h1
const DPAM_NORMAL = &h2
const DPAM_UNION = &h4
const DPAM_INTERSECT = &h8
type PFNDPAMERGE as function(byval uMsg as UINT, byval pvDest as any ptr, byval pvSrc as any ptr, byval lParam as LPARAM) as any ptr
type PFNDPAMERGECONST as function(byval uMsg as UINT, byval pvDest as const any ptr, byval pvSrc as const any ptr, byval lParam as LPARAM) as const any ptr
const DPAMM_MERGE = 1
const DPAMM_DELETE = 2
const DPAMM_INSERT = 3
declare function DPA_Merge(byval hdpaDest as HDPA, byval hdpaSrc as HDPA, byval dwFlags as DWORD, byval pfnCompare as PFNDACOMPARE, byval pfnMerge as PFNDPAMERGE, byval lParam as LPARAM) as WINBOOL
const DPAS_SORTED = &h1
const DPAS_INSERTBEFORE = &h2
const DPAS_INSERTAFTER = &h4
declare function DPA_Search(byval hdpa as HDPA, byval pFind as any ptr, byval iStart as long, byval pfnCompare as PFNDACOMPARE, byval lParam as LPARAM, byval options as UINT) as long
#define DPA_SortedInsertPtr(hdpa, pFind, iStart, pfnCompare, lParam, options, pitem) DPA_InsertPtr(hdpa, DPA_Search(hdpa, pFind, iStart, pfnCompare, lParam, DPAS_SORTED or (options)), (pitem))
const DPA_APPEND = DA_LAST
const DPA_ERR = DA_ERR

type PFNDPAENUMCALLBACK as PFNDAENUMCALLBACK
type PFNDPAENUMCALLBACKCONST as PFNDAENUMCALLBACKCONST
type PFNDPACOMPARE as PFNDACOMPARE
type PFNDPACOMPARECONST as PFNDACOMPARECONST
declare function Str_SetPtrW(byval ppsz as LPWSTR ptr, byval psz as LPCWSTR) as WINBOOL
declare function _TrackMouseEvent(byval lpEventTrack as LPTRACKMOUSEEVENT) as WINBOOL

const WSB_PROP_CYVSCROLL = &h1
const WSB_PROP_CXHSCROLL = &h2
const WSB_PROP_CYHSCROLL = &h4
const WSB_PROP_CXVSCROLL = &h8
const WSB_PROP_CXHTHUMB = &h10
const WSB_PROP_CYVTHUMB = &h20
const WSB_PROP_VBKGCOLOR = &h40
const WSB_PROP_HBKGCOLOR = &h80
const WSB_PROP_VSTYLE = &h100
const WSB_PROP_HSTYLE = &h200
const WSB_PROP_WINSTYLE = &h400
const WSB_PROP_PALETTE = &h800
const WSB_PROP_MASK = &hfff
const FSB_FLAT_MODE = 2
const FSB_ENCARTA_MODE = 1
const FSB_REGULAR_MODE = 0

declare function FlatSB_EnableScrollBar(byval as HWND, byval as long, byval as UINT) as WINBOOL
declare function FlatSB_ShowScrollBar(byval as HWND, byval code as long, byval as WINBOOL) as WINBOOL
declare function FlatSB_GetScrollRange(byval as HWND, byval code as long, byval as LPINT, byval as LPINT) as WINBOOL
declare function FlatSB_GetScrollInfo(byval as HWND, byval code as long, byval as LPSCROLLINFO) as WINBOOL
declare function FlatSB_GetScrollPos(byval as HWND, byval code as long) as long
declare function FlatSB_GetScrollProp(byval as HWND, byval propIndex as long, byval as LPINT) as WINBOOL

#ifdef __FB_64BIT__
	declare function FlatSB_GetScrollPropPtr(byval as HWND, byval propIndex as long, byval as PINT_PTR) as WINBOOL
#else
	declare function FlatSB_GetScrollPropPtr alias "FlatSB_GetScrollProp"(byval as HWND, byval propIndex as long, byval as LPINT) as WINBOOL
#endif

declare function FlatSB_SetScrollPos(byval as HWND, byval code as long, byval pos as long, byval fRedraw as WINBOOL) as long
declare function FlatSB_SetScrollInfo(byval as HWND, byval code as long, byval as LPSCROLLINFO, byval fRedraw as WINBOOL) as long
declare function FlatSB_SetScrollRange(byval as HWND, byval code as long, byval min as long, byval max as long, byval fRedraw as WINBOOL) as long
declare function FlatSB_SetScrollProp(byval as HWND, byval index as UINT, byval newValue as INT_PTR, byval as WINBOOL) as WINBOOL
declare function FlatSB_SetScrollPropPtr alias "FlatSB_SetScrollProp"(byval as HWND, byval index as UINT, byval newValue as INT_PTR, byval as WINBOOL) as WINBOOL
declare function InitializeFlatSB(byval as HWND) as WINBOOL
declare function UninitializeFlatSB(byval as HWND) as HRESULT
type SUBCLASSPROC as function(byval hWnd as HWND, byval uMsg as UINT, byval wParam as WPARAM, byval lParam as LPARAM, byval uIdSubclass as UINT_PTR, byval dwRefData as DWORD_PTR) as LRESULT
declare function SetWindowSubclass(byval hWnd as HWND, byval pfnSubclass as SUBCLASSPROC, byval uIdSubclass as UINT_PTR, byval dwRefData as DWORD_PTR) as WINBOOL
declare function GetWindowSubclass(byval hWnd as HWND, byval pfnSubclass as SUBCLASSPROC, byval uIdSubclass as UINT_PTR, byval pdwRefData as DWORD_PTR ptr) as WINBOOL
declare function RemoveWindowSubclass(byval hWnd as HWND, byval pfnSubclass as SUBCLASSPROC, byval uIdSubclass as UINT_PTR) as WINBOOL
declare function DefSubclassProc(byval hWnd as HWND, byval uMsg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT
declare function DrawShadowText(byval hdc as HDC, byval pszText as LPCWSTR, byval cch as UINT, byval prc as RECT ptr, byval dwFlags as DWORD, byval crText as COLORREF, byval crShadow as COLORREF, byval ixOffset as long, byval iyOffset as long) as long

#if _WIN32_WINNT >= &h0600
	type _LI_METRIC as long
	enum
		LIM_SMALL
		LIM_LARGE
	end enum

	declare function LoadIconMetric(byval hinst as HINSTANCE, byval pszName as PCWSTR, byval lims as long, byval phico as HICON ptr) as HRESULT
	declare function LoadIconWithScaleDown(byval hinst as HINSTANCE, byval pszName as PCWSTR, byval cx as long, byval cy as long, byval phico as HICON ptr) as HRESULT
#endif

end extern
