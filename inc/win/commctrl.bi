#pragma once

#include once "_mingw_unicode.bi"
#include once "prsht.bi"
#include once "rpc.bi"
#include once "rpcndr.bi"
#include once "wtypesbase.bi"
#include once "unknwnbase.bi"
#include once "objidlbase.bi"

#inclib "comctl32"

extern "Windows"

#define _INC_COMMCTRL
declare sub InitCommonControls()

type tagINITCOMMONCONTROLSEX
	dwSize as DWORD
	dwICC as DWORD
end type

type INITCOMMONCONTROLSEX as tagINITCOMMONCONTROLSEX
type LPINITCOMMONCONTROLSEX as tagINITCOMMONCONTROLSEX ptr
#define ICC_LISTVIEW_CLASSES &h1
#define ICC_TREEVIEW_CLASSES &h2
#define ICC_BAR_CLASSES &h4
#define ICC_TAB_CLASSES &h8
#define ICC_UPDOWN_CLASS &h10
#define ICC_PROGRESS_CLASS &h20
#define ICC_HOTKEY_CLASS &h40
#define ICC_ANIMATE_CLASS &h80
#define ICC_WIN95_CLASSES &hff
#define ICC_DATE_CLASSES &h100
#define ICC_USEREX_CLASSES &h200
#define ICC_COOL_CLASSES &h400
#define ICC_INTERNET_CLASSES &h800
#define ICC_PAGESCROLLER_CLASS &h1000
#define ICC_NATIVEFNTCTL_CLASS &h2000
#define ICC_STANDARD_CLASSES &h4000
#define ICC_LINK_CLASS &h8000
declare function InitCommonControlsEx(byval as const INITCOMMONCONTROLSEX ptr) as WINBOOL
#define ODT_HEADER 100
#define ODT_TAB 101
#define ODT_LISTVIEW 102
#define LVM_FIRST &h1000
#define TV_FIRST &h1100
#define HDM_FIRST &h1200
#define TCM_FIRST &h1300
#define PGM_FIRST &h1400
#define ECM_FIRST &h1500
#define BCM_FIRST &h1600
#define CBM_FIRST &h1700
#define CCM_FIRST &h2000
#define CCM_LAST (CCM_FIRST + &h200)
#define CCM_SETBKCOLOR (CCM_FIRST + 1)
#define CCM_SETCOLORSCHEME (CCM_FIRST + 2)
#define CCM_GETCOLORSCHEME (CCM_FIRST + 3)
#define CCM_GETDROPTARGET (CCM_FIRST + 4)
#define CCM_SETUNICODEFORMAT (CCM_FIRST + 5)
#define CCM_GETUNICODEFORMAT (CCM_FIRST + 6)

type tagCOLORSCHEME
	dwSize as DWORD
	clrBtnHighlight as COLORREF
	clrBtnShadow as COLORREF
end type

type COLORSCHEME as tagCOLORSCHEME
type LPCOLORSCHEME as tagCOLORSCHEME ptr
#define COMCTL32_VERSION 6
#define CCM_SETVERSION (CCM_FIRST + &h7)
#define CCM_GETVERSION (CCM_FIRST + &h8)
#define CCM_SETNOTIFYWINDOW (CCM_FIRST + &h9)
#define CCM_SETWINDOWTHEME (CCM_FIRST + &hb)
#define CCM_DPISCALE (CCM_FIRST + &hc)
#define INFOTIPSIZE 1024
#define HANDLE_WM_NOTIFY(hwnd, wParam, lParam, fn) fn(hwnd, clng(wParam), cast(NMHDR ptr, lParam))
#define FORWARD_WM_NOTIFY(hwnd, idFrom, pnmhdr, fn) cast(LRESULT, fn(hwnd, WM_NOTIFY, cast(WPARAM, clng(idFrom)), cast(LPARAM, cast(NMHDR ptr, pnmhdr))))
#define NM_OUTOFMEMORY (NM_FIRST - 1)
#define NM_CLICK (NM_FIRST - 2)
#define NM_DBLCLK (NM_FIRST - 3)
#define NM_RETURN (NM_FIRST - 4)
#define NM_RCLICK (NM_FIRST - 5)
#define NM_RDBLCLK (NM_FIRST - 6)
#define NM_SETFOCUS (NM_FIRST - 7)
#define NM_KILLFOCUS (NM_FIRST - 8)
#define NM_CUSTOMDRAW (NM_FIRST - 12)
#define NM_HOVER (NM_FIRST - 13)
#define NM_NCHITTEST (NM_FIRST - 14)
#define NM_KEYDOWN (NM_FIRST - 15)
#define NM_RELEASEDCAPTURE (NM_FIRST - 16)
#define NM_SETCURSOR (NM_FIRST - 17)
#define NM_CHAR (NM_FIRST - 18)
#define NM_TOOLTIPSCREATED (NM_FIRST - 19)
#define NM_LDOWN (NM_FIRST - 20)
#define NM_RDOWN (NM_FIRST - 21)
#define NM_THEMECHANGED (NM_FIRST - 22)

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
#define NM_FIRST culng(0u - 0u)
#define NM_LAST culng(0u - 99u)
#define LVN_FIRST culng(0u - 100u)
#define LVN_LAST culng(0u - 199u)
#define HDN_FIRST culng(0u - 300u)
#define HDN_LAST culng(0u - 399u)
#define TVN_FIRST culng(0u - 400u)
#define TVN_LAST culng(0u - 499u)
#define TTN_FIRST culng(0u - 520u)
#define TTN_LAST culng(0u - 549u)
#define TCN_FIRST culng(0u - 550u)
#define TCN_LAST culng(0u - 580u)
#define TBN_FIRST culng(0u - 700u)
#define TBN_LAST culng(0u - 720u)
#define UDN_FIRST culng(0u - 721)
#define UDN_LAST culng(0u - 740)
#define MCN_FIRST culng(0u - 750u)
#define MCN_LAST culng(0u - 759u)
#define DTN_FIRST culng(0u - 760u)
#define DTN_LAST culng(0u - 799u)
#define CBEN_FIRST culng(0u - 800u)
#define CBEN_LAST culng(0u - 830u)
#define RBN_FIRST culng(0u - 831u)
#define RBN_LAST culng(0u - 859u)
#define IPN_FIRST culng(0u - 860u)
#define IPN_LAST culng(0u - 879u)
#define SBN_FIRST culng(0u - 880u)
#define SBN_LAST culng(0u - 899u)
#define PGN_FIRST culng(0u - 900u)
#define PGN_LAST culng(0u - 950u)
#define WMN_FIRST culng(0u - 1000u)
#define WMN_LAST culng(0u - 1200u)
#define BCN_FIRST culng(0u - 1250u)
#define BCN_LAST culng(0u - 1350u)
#define MSGF_COMMCTRL_BEGINDRAG &h4200
#define MSGF_COMMCTRL_SIZEHEADER &h4201
#define MSGF_COMMCTRL_DRAGSELECT &h4202
#define MSGF_COMMCTRL_TOOLBARCUST &h4203
#define CDRF_DODEFAULT &h0
#define CDRF_NEWFONT &h2
#define CDRF_SKIPDEFAULT &h4
#define CDRF_DOERASE &h8
#define CDRF_SKIPPOSTPAINT &h100
#define CDRF_NOTIFYPOSTPAINT &h10
#define CDRF_NOTIFYITEMDRAW &h20
#define CDRF_NOTIFYSUBITEMDRAW &h20
#define CDRF_NOTIFYPOSTERASE &h40
#define CDDS_PREPAINT &h1
#define CDDS_POSTPAINT &h2
#define CDDS_PREERASE &h3
#define CDDS_POSTERASE &h4
#define CDDS_ITEM &h10000
#define CDDS_ITEMPREPAINT (CDDS_ITEM or CDDS_PREPAINT)
#define CDDS_ITEMPOSTPAINT (CDDS_ITEM or CDDS_POSTPAINT)
#define CDDS_ITEMPREERASE (CDDS_ITEM or CDDS_PREERASE)
#define CDDS_ITEMPOSTERASE (CDDS_ITEM or CDDS_POSTERASE)
#define CDDS_SUBITEM &h20000
#define CDIS_SELECTED &h1
#define CDIS_GRAYED &h2
#define CDIS_DISABLED &h4
#define CDIS_CHECKED &h8
#define CDIS_FOCUS &h10
#define CDIS_DEFAULT &h20
#define CDIS_HOT &h40
#define CDIS_MARKED &h80
#define CDIS_INDETERMINATE &h100
#define CDIS_SHOWKEYBOARDCUES &h200

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
#define CLR_NONE __MSABI_LONG(&hffffffff)
#define CLR_DEFAULT __MSABI_LONG(&hFF000000)
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
#define ILC_MASK &h1
#define ILC_COLOR &h0
#define ILC_COLORDDB &hfe
#define ILC_COLOR4 &h4
#define ILC_COLOR8 &h8
#define ILC_COLOR16 &h10
#define ILC_COLOR24 &h18
#define ILC_COLOR32 &h20
#define ILC_PALETTE &h800
#define ILC_MIRROR &h2000
#define ILC_PERITEMMIRROR &h8000

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
#define ILD_NORMAL &h0
#define ILD_TRANSPARENT &h1
#define ILD_MASK &h10
#define ILD_IMAGE &h20
#define ILD_ROP &h40
#define ILD_BLEND25 &h2
#define ILD_BLEND50 &h4
#define ILD_OVERLAYMASK &hf00
#define INDEXTOOVERLAYMASK(i) ((i) shl 8)
#define ILD_PRESERVEALPHA &h1000
#define ILD_SCALE &h2000
#define ILD_DPISCALE &h4000
#define ILD_SELECTED ILD_BLEND50
#define ILD_FOCUS ILD_BLEND25
#define ILD_BLEND ILD_BLEND50
#define CLR_HILIGHT CLR_DEFAULT
#define ILS_NORMAL &h0
#define ILS_GLOW &h1
#define ILS_SHADOW &h2
#define ILS_SATURATE &h4
#define ILS_ALPHA &h8

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
	#define ImageList_LoadImage ImageList_LoadImageW
#else
	#define ImageList_LoadImage ImageList_LoadImageA
#endif

#define ILCF_MOVE &h0
#define ILCF_SWAP &h1
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
#define ILP_NORMAL 0
#define ILP_DOWNLEVEL 1
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
#define WC_HEADERA "SysHeader32"
#define WC_HEADERW wstr("SysHeader32")

#ifdef UNICODE
	#define WC_HEADER WC_HEADERW
#else
	#define WC_HEADER WC_HEADERA
#endif

#define HDS_HORZ &h0
#define HDS_BUTTONS &h2
#define HDS_HOTTRACK &h4
#define HDS_HIDDEN &h8
#define HDS_DRAGDROP &h40
#define HDS_FULLDRAG &h80
#define HDS_FILTERBAR &h100
#define HDS_FLAT &h200

#if _WIN32_WINNT = &h0602
	#define HDS_CHECKBOXES &h400
	#define HDS_NOSIZING &h800
	#define HDS_OVERFLOW &h1000
#endif

#define HDFT_ISSTRING &h0
#define HDFT_ISNUMBER &h1
#define HDFT_HASNOVALUE &h8000

#ifdef UNICODE
	#define HD_TEXTFILTER HD_TEXTFILTERW
	#define HDTEXTFILTER HD_TEXTFILTERW
	#define LPHD_TEXTFILTER LPHD_TEXTFILTERW
	#define LPHDTEXTFILTER LPHD_TEXTFILTERW
#else
	#define HD_TEXTFILTER HD_TEXTFILTERA
	#define HDTEXTFILTER HD_TEXTFILTERA
	#define LPHD_TEXTFILTER LPHD_TEXTFILTERA
	#define LPHDTEXTFILTER LPHD_TEXTFILTERA
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
#define HD_ITEMA HDITEMA
#define HD_ITEMW HDITEMW
#define HD_ITEM HDITEM

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
end type

type HDITEMW as _HD_ITEMW
type LPHDITEMW as _HD_ITEMW ptr

#ifdef UNICODE
	#define HDITEM HDITEMW
	#define LPHDITEM LPHDITEMW
	#define HDITEM_V1_SIZE HDITEMW_V1_SIZE
#else
	#define HDITEM HDITEMA
	#define LPHDITEM LPHDITEMA
	#define HDITEM_V1_SIZE HDITEMA_V1_SIZE
#endif

#define HDI_WIDTH &h1
#define HDI_HEIGHT HDI_WIDTH
#define HDI_TEXT &h2
#define HDI_FORMAT &h4
#define HDI_LPARAM &h8
#define HDI_BITMAP &h10
#define HDI_IMAGE &h20
#define HDI_DI_SETITEM &h40
#define HDI_ORDER &h80
#define HDI_FILTER &h100
#define HDF_LEFT &h0
#define HDF_RIGHT &h1
#define HDF_CENTER &h2
#define HDF_JUSTIFYMASK &h3
#define HDF_RTLREADING &h4
#define HDF_OWNERDRAW &h8000
#define HDF_STRING &h4000
#define HDF_BITMAP &h2000
#define HDF_BITMAP_ON_RIGHT &h1000
#define HDF_IMAGE &h800
#define HDF_SORTUP &h400
#define HDF_SORTDOWN &h200

#if _WIN32_WINNT = &h0602
	#define HDF_CHECKBOX &h40
	#define HDF_CHECKED &h80
	#define HDF_FIXEDWIDTH &h100
	#define HDF_SPLITBUTTON &h1000000
#endif

#define HDM_GETITEMCOUNT (HDM_FIRST + 0)
#define Header_GetItemCount(hwndHD) clng(SNDMSG((hwndHD), HDM_GETITEMCOUNT, cast(WPARAM, 0), cast(LPARAM, 0)))
#define HDM_INSERTITEMA (HDM_FIRST + 1)
#define HDM_INSERTITEMW (HDM_FIRST + 10)

#ifdef UNICODE
	#define HDM_INSERTITEM HDM_INSERTITEMW
#else
	#define HDM_INSERTITEM HDM_INSERTITEMA
#endif

#define Header_InsertItem(hwndHD, i, phdi) clng(SNDMSG((hwndHD), HDM_INSERTITEM, cast(WPARAM, clng((i))), cast(LPARAM, cptr(const HD_ITEM ptr, (phdi)))))
#define HDM_DELETEITEM (HDM_FIRST + 2)
#define Header_DeleteItem(hwndHD, i) cast(WINBOOL, SNDMSG((hwndHD), HDM_DELETEITEM, cast(WPARAM, clng((i))), cast(LPARAM, 0)))
#define HDM_GETITEMA (HDM_FIRST + 3)
#define HDM_GETITEMW (HDM_FIRST + 11)

#ifdef UNICODE
	#define HDM_GETITEM HDM_GETITEMW
#else
	#define HDM_GETITEM HDM_GETITEMA
#endif

#define Header_GetItem(hwndHD, i, phdi) cast(WINBOOL, SNDMSG((hwndHD), HDM_GETITEM, cast(WPARAM, clng((i))), cast(LPARAM, cptr(HD_ITEM ptr, (phdi)))))
#define HDM_SETITEMA (HDM_FIRST + 4)
#define HDM_SETITEMW (HDM_FIRST + 12)

#ifdef UNICODE
	#define HDM_SETITEM HDM_SETITEMW
#else
	#define HDM_SETITEM HDM_SETITEMA
#endif

#define Header_SetItem(hwndHD, i, phdi) cast(WINBOOL, SNDMSG((hwndHD), HDM_SETITEM, cast(WPARAM, clng((i))), cast(LPARAM, cptr(const HD_ITEM ptr, (phdi)))))
#define HD_LAYOUT HDLAYOUT

type _HD_LAYOUT
	prc as RECT ptr
	pwpos as WINDOWPOS ptr
end type

type HDLAYOUT as _HD_LAYOUT
type LPHDLAYOUT as _HD_LAYOUT ptr
#define HDM_LAYOUT (HDM_FIRST + 5)
#define Header_Layout(hwndHD, playout) cast(WINBOOL, SNDMSG((hwndHD), HDM_LAYOUT, 0, cast(LPARAM, cptr(HD_LAYOUT ptr, (playout)))))
#define HHT_NOWHERE &h1
#define HHT_ONHEADER &h2
#define HHT_ONDIVIDER &h4
#define HHT_ONDIVOPEN &h8
#define HHT_ONFILTER &h10
#define HHT_ONFILTERBUTTON &h20
#define HHT_ABOVE &h100
#define HHT_BELOW &h200
#define HHT_TORIGHT &h400
#define HHT_TOLEFT &h800
#define HD_HITTESTINFO HDHITTESTINFO

type _HD_HITTESTINFO
	pt as POINT
	flags as UINT
	iItem as long
end type

type HDHITTESTINFO as _HD_HITTESTINFO
type LPHDHITTESTINFO as _HD_HITTESTINFO ptr
#define HDM_HITTEST (HDM_FIRST + 6)
#define HDM_GETITEMRECT (HDM_FIRST + 7)
#define Header_GetItemRect(hwnd, iItem, lprc) cast(WINBOOL, SNDMSG((hwnd), HDM_GETITEMRECT, cast(WPARAM, (iItem)), cast(LPARAM, (lprc))))
#define HDM_SETIMAGELIST (HDM_FIRST + 8)
#define Header_SetImageList(hwnd, himl) cast(HIMAGELIST, SNDMSG((hwnd), HDM_SETIMAGELIST, 0, cast(LPARAM, (himl))))
#define HDM_GETIMAGELIST (HDM_FIRST + 9)
#define Header_GetImageList(hwnd) cast(HIMAGELIST, SNDMSG((hwnd), HDM_GETIMAGELIST, 0, 0))
#define HDM_ORDERTOINDEX (HDM_FIRST + 15)
#define Header_OrderToIndex(hwnd, i) clng(SNDMSG((hwnd), HDM_ORDERTOINDEX, cast(WPARAM, (i)), 0))
#define HDM_CREATEDRAGIMAGE (HDM_FIRST + 16)
#define Header_CreateDragImage(hwnd, i) cast(HIMAGELIST, SNDMSG((hwnd), HDM_CREATEDRAGIMAGE, cast(WPARAM, (i)), 0))
#define HDM_GETORDERARRAY (HDM_FIRST + 17)
#define Header_GetOrderArray(hwnd, iCount, lpi) cast(WINBOOL, SNDMSG((hwnd), HDM_GETORDERARRAY, cast(WPARAM, (iCount)), cast(LPARAM, (lpi))))
#define HDM_SETORDERARRAY (HDM_FIRST + 18)
#define Header_SetOrderArray(hwnd, iCount, lpi) cast(WINBOOL, SNDMSG((hwnd), HDM_SETORDERARRAY, cast(WPARAM, (iCount)), cast(LPARAM, (lpi))))
#define HDM_SETHOTDIVIDER (HDM_FIRST + 19)
#define Header_SetHotDivider(hwnd, fPos, dw) clng(SNDMSG((hwnd), HDM_SETHOTDIVIDER, cast(WPARAM, (fPos)), cast(LPARAM, (dw))))
#define HDM_SETBITMAPMARGIN (HDM_FIRST + 20)
#define Header_SetBitmapMargin(hwnd, iWidth) clng(SNDMSG((hwnd), HDM_SETBITMAPMARGIN, cast(WPARAM, (iWidth)), 0))
#define HDM_GETBITMAPMARGIN (HDM_FIRST + 21)
#define Header_GetBitmapMargin(hwnd) clng(SNDMSG((hwnd), HDM_GETBITMAPMARGIN, 0, 0))
#define HDM_SETUNICODEFORMAT CCM_SETUNICODEFORMAT
#define Header_SetUnicodeFormat(hwnd, fUnicode) cast(WINBOOL, SNDMSG((hwnd), HDM_SETUNICODEFORMAT, cast(WPARAM, (fUnicode)), 0))
#define HDM_GETUNICODEFORMAT CCM_GETUNICODEFORMAT
#define Header_GetUnicodeFormat(hwnd) cast(WINBOOL, SNDMSG((hwnd), HDM_GETUNICODEFORMAT, 0, 0))
#define HDM_SETFILTERCHANGETIMEOUT (HDM_FIRST + 22)
#define Header_SetFilterChangeTimeout(hwnd, i) clng(SNDMSG((hwnd), HDM_SETFILTERCHANGETIMEOUT, 0, cast(LPARAM, (i))))
#define HDM_EDITFILTER (HDM_FIRST + 23)
#define Header_EditFilter(hwnd, i, fDiscardChanges) clng(SNDMSG((hwnd), HDM_EDITFILTER, cast(WPARAM, (i)), MAKELPARAM(fDiscardChanges, 0)))
#define HDM_CLEARFILTER (HDM_FIRST + 24)
#define Header_ClearFilter(hwnd, i) clng(SNDMSG((hwnd), HDM_CLEARFILTER, cast(WPARAM, (i)), 0))
#define Header_ClearAllFilters(hwnd) clng(SNDMSG((hwnd), HDM_CLEARFILTER, cast(WPARAM, -1), 0))
#define HDN_ITEMCHANGINGA culng(HDN_FIRST - 0)
#define HDN_ITEMCHANGINGW culng(HDN_FIRST - 20)
#define HDN_ITEMCHANGEDA culng(HDN_FIRST - 1)
#define HDN_ITEMCHANGEDW culng(HDN_FIRST - 21)
#define HDN_ITEMCLICKA culng(HDN_FIRST - 2)
#define HDN_ITEMCLICKW culng(HDN_FIRST - 22)
#define HDN_ITEMDBLCLICKA culng(HDN_FIRST - 3)
#define HDN_ITEMDBLCLICKW culng(HDN_FIRST - 23)
#define HDN_DIVIDERDBLCLICKA culng(HDN_FIRST - 5)
#define HDN_DIVIDERDBLCLICKW culng(HDN_FIRST - 25)
#define HDN_BEGINTRACKA culng(HDN_FIRST - 6)
#define HDN_BEGINTRACKW culng(HDN_FIRST - 26)
#define HDN_ENDTRACKA culng(HDN_FIRST - 7)
#define HDN_ENDTRACKW culng(HDN_FIRST - 27)
#define HDN_TRACKA culng(HDN_FIRST - 8)
#define HDN_TRACKW culng(HDN_FIRST - 28)
#define HDN_GETDISPINFOA culng(HDN_FIRST - 9)
#define HDN_GETDISPINFOW culng(HDN_FIRST - 29)
#define HDN_BEGINDRAG culng(HDN_FIRST - 10)
#define HDN_ENDDRAG culng(HDN_FIRST - 11)
#define HDN_FILTERCHANGE culng(HDN_FIRST - 12)
#define HDN_FILTERBTNCLICK culng(HDN_FIRST - 13)

#ifdef UNICODE
	#define HDN_ITEMCHANGING HDN_ITEMCHANGINGW
	#define HDN_ITEMCHANGED HDN_ITEMCHANGEDW
	#define HDN_ITEMCLICK HDN_ITEMCLICKW
	#define HDN_ITEMDBLCLICK HDN_ITEMDBLCLICKW
	#define HDN_DIVIDERDBLCLICK HDN_DIVIDERDBLCLICKW
	#define HDN_BEGINTRACK HDN_BEGINTRACKW
	#define HDN_ENDTRACK HDN_ENDTRACKW
	#define HDN_TRACK HDN_TRACKW
	#define HDN_GETDISPINFO HDN_GETDISPINFOW
#else
	#define HDN_ITEMCHANGING HDN_ITEMCHANGINGA
	#define HDN_ITEMCHANGED HDN_ITEMCHANGEDA
	#define HDN_ITEMCLICK HDN_ITEMCLICKA
	#define HDN_ITEMDBLCLICK HDN_ITEMDBLCLICKA
	#define HDN_DIVIDERDBLCLICK HDN_DIVIDERDBLCLICKA
	#define HDN_BEGINTRACK HDN_BEGINTRACKA
	#define HDN_ENDTRACK HDN_ENDTRACKA
	#define HDN_TRACK HDN_TRACKA
	#define HDN_GETDISPINFO HDN_GETDISPINFOA
#endif

#define HD_NOTIFYA NMHEADERA
#define HD_NOTIFYW NMHEADERW
#define HD_NOTIFY NMHEADER

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
	#define NMHEADER NMHEADERW
	#define LPNMHEADER LPNMHEADERW
#else
	#define NMHEADER NMHEADERA
	#define LPNMHEADER LPNMHEADERA
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
	#define NMHDDISPINFO NMHDDISPINFOW
	#define LPNMHDDISPINFO LPNMHDDISPINFOW
#else
	#define NMHDDISPINFO NMHDDISPINFOA
	#define LPNMHDDISPINFO LPNMHDDISPINFOA
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
#define CMB_MASKED &h2
#define TBSTATE_CHECKED &h1
#define TBSTATE_PRESSED &h2
#define TBSTATE_ENABLED &h4
#define TBSTATE_HIDDEN &h8
#define TBSTATE_INDETERMINATE &h10
#define TBSTATE_WRAP &h20
#define TBSTATE_ELLIPSES &h40
#define TBSTATE_MARKED &h80
#define TBSTYLE_BUTTON &h0
#define TBSTYLE_SEP &h1
#define TBSTYLE_CHECK &h2
#define TBSTYLE_GROUP &h4
#define TBSTYLE_CHECKGROUP (TBSTYLE_GROUP or TBSTYLE_CHECK)
#define TBSTYLE_DROPDOWN &h8
#define TBSTYLE_AUTOSIZE &h10
#define TBSTYLE_NOPREFIX &h20
#define TBSTYLE_TOOLTIPS &h100
#define TBSTYLE_WRAPABLE &h200
#define TBSTYLE_ALTDRAG &h400
#define TBSTYLE_FLAT &h800
#define TBSTYLE_LIST &h1000
#define TBSTYLE_CUSTOMERASE &h2000
#define TBSTYLE_REGISTERDROP &h4000
#define TBSTYLE_TRANSPARENT &h8000
#define TBSTYLE_EX_DRAWDDARROWS &h1
#define BTNS_BUTTON TBSTYLE_BUTTON
#define BTNS_SEP TBSTYLE_SEP
#define BTNS_CHECK TBSTYLE_CHECK
#define BTNS_GROUP TBSTYLE_GROUP
#define BTNS_CHECKGROUP TBSTYLE_CHECKGROUP
#define BTNS_DROPDOWN TBSTYLE_DROPDOWN
#define BTNS_AUTOSIZE TBSTYLE_AUTOSIZE
#define BTNS_NOPREFIX TBSTYLE_NOPREFIX
#define BTNS_SHOWTEXT &h40
#define BTNS_WHOLEDROPDOWN &h80
#define TBSTYLE_EX_MIXEDBUTTONS &h8
#define TBSTYLE_EX_HIDECLIPPEDBUTTONS &h10
#define TBSTYLE_EX_DOUBLEBUFFER &h80

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
#define TBCDRF_NOEDGES &h10000
#define TBCDRF_HILITEHOTTRACK &h20000
#define TBCDRF_NOOFFSET &h40000
#define TBCDRF_NOMARK &h80000
#define TBCDRF_NOETCHEDEFFECT &h100000
#define TBCDRF_BLENDICON &h200000
#define TBCDRF_NOBACKGROUND &h400000
#define TB_ENABLEBUTTON (WM_USER + 1)
#define TB_CHECKBUTTON (WM_USER + 2)
#define TB_PRESSBUTTON (WM_USER + 3)
#define TB_HIDEBUTTON (WM_USER + 4)
#define TB_INDETERMINATE (WM_USER + 5)
#define TB_MARKBUTTON (WM_USER + 6)
#define TB_ISBUTTONENABLED (WM_USER + 9)
#define TB_ISBUTTONCHECKED (WM_USER + 10)
#define TB_ISBUTTONPRESSED (WM_USER + 11)
#define TB_ISBUTTONHIDDEN (WM_USER + 12)
#define TB_ISBUTTONINDETERMINATE (WM_USER + 13)
#define TB_ISBUTTONHIGHLIGHTED (WM_USER + 14)
#define TB_SETSTATE (WM_USER + 17)
#define TB_GETSTATE (WM_USER + 18)
#define TB_ADDBITMAP (WM_USER + 19)

type tagTBADDBITMAP
	hInst as HINSTANCE
	nID as UINT_PTR
end type

type TBADDBITMAP as tagTBADDBITMAP
type LPTBADDBITMAP as tagTBADDBITMAP ptr
#define HINST_COMMCTRL cast(HINSTANCE, -1)
#define IDB_STD_SMALL_COLOR 0
#define IDB_STD_LARGE_COLOR 1
#define IDB_VIEW_SMALL_COLOR 4
#define IDB_VIEW_LARGE_COLOR 5
#define IDB_HIST_SMALL_COLOR 8
#define IDB_HIST_LARGE_COLOR 9
#define STD_CUT 0
#define STD_COPY 1
#define STD_PASTE 2
#define STD_UNDO 3
#define STD_REDOW 4
#define STD_DELETE 5
#define STD_FILENEW 6
#define STD_FILEOPEN 7
#define STD_FILESAVE 8
#define STD_PRINTPRE 9
#define STD_PROPERTIES 10
#define STD_HELP 11
#define STD_FIND 12
#define STD_REPLACE 13
#define STD_PRINT 14
#define VIEW_LARGEICONS 0
#define VIEW_SMALLICONS 1
#define VIEW_LIST 2
#define VIEW_DETAILS 3
#define VIEW_SORTNAME 4
#define VIEW_SORTSIZE 5
#define VIEW_SORTDATE 6
#define VIEW_SORTTYPE 7
#define VIEW_PARENTFOLDER 8
#define VIEW_NETCONNECT 9
#define VIEW_NETDISCONNECT 10
#define VIEW_NEWFOLDER 11
#define VIEW_VIEWMENU 12
#define HIST_BACK 0
#define HIST_FORWARD 1
#define HIST_FAVORITES 2
#define HIST_ADDTOFAVORITES 3
#define HIST_VIEWTREE 4
#define TB_ADDBUTTONSA (WM_USER + 20)
#define TB_INSERTBUTTONA (WM_USER + 21)
#define TB_DELETEBUTTON (WM_USER + 22)
#define TB_GETBUTTON (WM_USER + 23)
#define TB_BUTTONCOUNT (WM_USER + 24)
#define TB_COMMANDTOINDEX (WM_USER + 25)

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
	#define TBSAVEPARAMS TBSAVEPARAMSW
	#define LPTBSAVEPARAMS LPTBSAVEPARAMSW
#else
	#define TBSAVEPARAMS TBSAVEPARAMSA
	#define LPTBSAVEPARAMS LPTBSAVEPARAMSA
#endif

#define TB_SAVERESTOREA (WM_USER + 26)
#define TB_SAVERESTOREW (WM_USER + 76)
#define TB_CUSTOMIZE (WM_USER + 27)
#define TB_ADDSTRINGA (WM_USER + 28)
#define TB_ADDSTRINGW (WM_USER + 77)
#define TB_GETITEMRECT (WM_USER + 29)
#define TB_BUTTONSTRUCTSIZE (WM_USER + 30)
#define TB_SETBUTTONSIZE (WM_USER + 31)
#define TB_SETBITMAPSIZE (WM_USER + 32)
#define TB_AUTOSIZE (WM_USER + 33)
#define TB_GETTOOLTIPS (WM_USER + 35)
#define TB_SETTOOLTIPS (WM_USER + 36)
#define TB_SETPARENT (WM_USER + 37)
#define TB_SETROWS (WM_USER + 39)
#define TB_GETROWS (WM_USER + 40)
#define TB_SETCMDID (WM_USER + 42)
#define TB_CHANGEBITMAP (WM_USER + 43)
#define TB_GETBITMAP (WM_USER + 44)
#define TB_GETBUTTONTEXTA (WM_USER + 45)
#define TB_GETBUTTONTEXTW (WM_USER + 75)
#define TB_REPLACEBITMAP (WM_USER + 46)
#define TB_SETINDENT (WM_USER + 47)
#define TB_SETIMAGELIST (WM_USER + 48)
#define TB_GETIMAGELIST (WM_USER + 49)
#define TB_LOADIMAGES (WM_USER + 50)
#define TB_GETRECT (WM_USER + 51)
#define TB_SETHOTIMAGELIST (WM_USER + 52)
#define TB_GETHOTIMAGELIST (WM_USER + 53)
#define TB_SETDISABLEDIMAGELIST (WM_USER + 54)
#define TB_GETDISABLEDIMAGELIST (WM_USER + 55)
#define TB_SETSTYLE (WM_USER + 56)
#define TB_GETSTYLE (WM_USER + 57)
#define TB_GETBUTTONSIZE (WM_USER + 58)
#define TB_SETBUTTONWIDTH (WM_USER + 59)
#define TB_SETMAXTEXTROWS (WM_USER + 60)
#define TB_GETTEXTROWS (WM_USER + 61)

#ifdef UNICODE
	#define TB_GETBUTTONTEXT TB_GETBUTTONTEXTW
	#define TB_SAVERESTORE TB_SAVERESTOREW
	#define TB_ADDSTRING TB_ADDSTRINGW
#else
	#define TB_GETBUTTONTEXT TB_GETBUTTONTEXTA
	#define TB_SAVERESTORE TB_SAVERESTOREA
	#define TB_ADDSTRING TB_ADDSTRINGA
#endif

#define TB_GETOBJECT (WM_USER + 62)
#define TB_GETHOTITEM (WM_USER + 71)
#define TB_SETHOTITEM (WM_USER + 72)
#define TB_SETANCHORHIGHLIGHT (WM_USER + 73)
#define TB_GETANCHORHIGHLIGHT (WM_USER + 74)
#define TB_MAPACCELERATORA (WM_USER + 78)

type TBINSERTMARK
	iButton as long
	dwFlags as DWORD
end type

type LPTBINSERTMARK as TBINSERTMARK ptr
#define TBIMHT_AFTER &h1
#define TBIMHT_BACKGROUND &h2
#define TB_GETINSERTMARK (WM_USER + 79)
#define TB_SETINSERTMARK (WM_USER + 80)
#define TB_INSERTMARKHITTEST (WM_USER + 81)
#define TB_MOVEBUTTON (WM_USER + 82)
#define TB_GETMAXSIZE (WM_USER + 83)
#define TB_SETEXTENDEDSTYLE (WM_USER + 84)
#define TB_GETEXTENDEDSTYLE (WM_USER + 85)
#define TB_GETPADDING (WM_USER + 86)
#define TB_SETPADDING (WM_USER + 87)
#define TB_SETINSERTMARKCOLOR (WM_USER + 88)
#define TB_GETINSERTMARKCOLOR (WM_USER + 89)
#define TB_SETCOLORSCHEME CCM_SETCOLORSCHEME
#define TB_GETCOLORSCHEME CCM_GETCOLORSCHEME
#define TB_SETUNICODEFORMAT CCM_SETUNICODEFORMAT
#define TB_GETUNICODEFORMAT CCM_GETUNICODEFORMAT
#define TB_MAPACCELERATORW (WM_USER + 90)

#ifdef UNICODE
	#define TB_MAPACCELERATOR TB_MAPACCELERATORW
#else
	#define TB_MAPACCELERATOR TB_MAPACCELERATORA
#endif

type TBREPLACEBITMAP
	hInstOld as HINSTANCE
	nIDOld as UINT_PTR
	hInstNew as HINSTANCE
	nIDNew as UINT_PTR
	nButtons as long
end type

type LPTBREPLACEBITMAP as TBREPLACEBITMAP ptr
#define TBBF_LARGE &h1
#define TB_GETBITMAPFLAGS (WM_USER + 41)
#define TBIF_IMAGE &h1
#define TBIF_TEXT &h2
#define TBIF_STATE &h4
#define TBIF_STYLE &h8
#define TBIF_LPARAM &h10
#define TBIF_COMMAND &h20
#define TBIF_SIZE &h40
#define TBIF_BYINDEX &h80000000

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
	#define TBBUTTONINFO TBBUTTONINFOW
	#define LPTBBUTTONINFO LPTBBUTTONINFOW
#else
	#define TBBUTTONINFO TBBUTTONINFOA
	#define LPTBBUTTONINFO LPTBBUTTONINFOA
#endif

#define TB_GETBUTTONINFOW (WM_USER + 63)
#define TB_SETBUTTONINFOW (WM_USER + 64)
#define TB_GETBUTTONINFOA (WM_USER + 65)
#define TB_SETBUTTONINFOA (WM_USER + 66)

#ifdef UNICODE
	#define TB_GETBUTTONINFO TB_GETBUTTONINFOW
	#define TB_SETBUTTONINFO TB_SETBUTTONINFOW
#else
	#define TB_GETBUTTONINFO TB_GETBUTTONINFOA
	#define TB_SETBUTTONINFO TB_SETBUTTONINFOA
#endif

#define TB_INSERTBUTTONW (WM_USER + 67)
#define TB_ADDBUTTONSW (WM_USER + 68)
#define TB_HITTEST (WM_USER + 69)

#ifdef UNICODE
	#define TB_INSERTBUTTON TB_INSERTBUTTONW
	#define TB_ADDBUTTONS TB_ADDBUTTONSW
#else
	#define TB_INSERTBUTTON TB_INSERTBUTTONA
	#define TB_ADDBUTTONS TB_ADDBUTTONSA
#endif

#define TB_SETDRAWTEXTFLAGS (WM_USER + 70)
#define TB_GETSTRINGW (WM_USER + 91)
#define TB_GETSTRINGA (WM_USER + 92)

#ifdef UNICODE
	#define TB_GETSTRING TB_GETSTRINGW
#else
	#define TB_GETSTRING TB_GETSTRINGA
#endif

#define TB_SETHOTITEM2 (WM_USER + 94)
#define TB_SETLISTGAP (WM_USER + 96)
#define TB_GETIMAGELISTCOUNT (WM_USER + 98)
#define TB_GETIDEALSIZE (WM_USER + 99)
#define TB_TRANSLATEACCELERATOR CCM_TRANSLATEACCELERATOR
#define TBMF_PAD &h1
#define TBMF_BARPAD &h2
#define TBMF_BUTTONSPACING &h4

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
#define TB_GETMETRICS (WM_USER + 101)
#define TB_SETMETRICS (WM_USER + 102)

#if _WIN32_WINNT = &h0602
	#define TB_GETITEMDROPDOWNRECT (WM_USER + 103)
	#define TB_SETPRESSEDIMAGELIST (WM_USER + 104)
	#define TB_GETPRESSEDIMAGELIST (WM_USER + 105)
#endif

#define TB_SETWINDOWTHEME CCM_SETWINDOWTHEME
#define TBN_GETBUTTONINFOA culng(TBN_FIRST - 0)
#define TBN_BEGINDRAG culng(TBN_FIRST - 1)
#define TBN_ENDDRAG culng(TBN_FIRST - 2)
#define TBN_BEGINADJUST culng(TBN_FIRST - 3)
#define TBN_ENDADJUST culng(TBN_FIRST - 4)
#define TBN_RESET culng(TBN_FIRST - 5)
#define TBN_QUERYINSERT culng(TBN_FIRST - 6)
#define TBN_QUERYDELETE culng(TBN_FIRST - 7)
#define TBN_TOOLBARCHANGE culng(TBN_FIRST - 8)
#define TBN_CUSTHELP culng(TBN_FIRST - 9)
#define TBN_DROPDOWN culng(TBN_FIRST - 10)
#define TBN_GETOBJECT culng(TBN_FIRST - 12)

type tagNMTBHOTITEM
	hdr as NMHDR
	idOld as long
	idNew as long
	dwFlags as DWORD
end type

type NMTBHOTITEM as tagNMTBHOTITEM
type LPNMTBHOTITEM as tagNMTBHOTITEM ptr
#define HICF_OTHER &h0
#define HICF_MOUSE &h1
#define HICF_ARROWKEYS &h2
#define HICF_ACCELERATOR &h4
#define HICF_DUPACCEL &h8
#define HICF_ENTERING &h10
#define HICF_LEAVING &h20
#define HICF_RESELECT &h40
#define HICF_LMOUSE &h80
#define HICF_TOGGLEDROPDOWN &h100
#define TBN_HOTITEMCHANGE culng(TBN_FIRST - 13)
#define TBN_DRAGOUT culng(TBN_FIRST - 14)
#define TBN_DELETINGBUTTON culng(TBN_FIRST - 15)
#define TBN_GETDISPINFOA culng(TBN_FIRST - 16)
#define TBN_GETDISPINFOW culng(TBN_FIRST - 17)
#define TBN_GETINFOTIPA culng(TBN_FIRST - 18)
#define TBN_GETINFOTIPW culng(TBN_FIRST - 19)
#define TBN_GETBUTTONINFOW culng(TBN_FIRST - 20)
#define TBN_RESTORE culng(TBN_FIRST - 21)
#define TBN_SAVE culng(TBN_FIRST - 22)
#define TBN_INITCUSTOMIZE culng(TBN_FIRST - 23)
#define TBN_WRAPHOTITEM culng(TBN_FIRST - 24)
#define TBN_DUPACCELERATOR culng(TBN_FIRST - 25)
#define TBN_WRAPACCELERATOR culng(TBN_FIRST - 26)
#define TBN_DRAGOVER culng(TBN_FIRST - 27)
#define TBN_MAPACCELERATOR culng(TBN_FIRST - 28)
#define TBNRF_HIDEHELP &h1
#define TBNRF_ENDCUSTOMIZE &h2

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
	#define TBN_GETINFOTIP TBN_GETINFOTIPW
	#define NMTBGETINFOTIP NMTBGETINFOTIPW
	#define LPNMTBGETINFOTIP LPNMTBGETINFOTIPW
#else
	#define TBN_GETINFOTIP TBN_GETINFOTIPA
	#define NMTBGETINFOTIP NMTBGETINFOTIPA
	#define LPNMTBGETINFOTIP LPNMTBGETINFOTIPA
#endif

#define TBNF_IMAGE &h1
#define TBNF_TEXT &h2
#define TBNF_DI_SETITEM &h10000000

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
	#define TBN_GETDISPINFO TBN_GETDISPINFOW
	#define NMTBDISPINFO NMTBDISPINFOW
	#define LPNMTBDISPINFO LPNMTBDISPINFOW
#else
	#define TBN_GETDISPINFO TBN_GETDISPINFOA
	#define NMTBDISPINFO NMTBDISPINFOA
	#define LPNMTBDISPINFO LPNMTBDISPINFOA
#endif

#define TBDDRET_DEFAULT 0
#define TBDDRET_NODEFAULT 1
#define TBDDRET_TREATPRESSED 2

#ifdef UNICODE
	#define TBN_GETBUTTONINFO TBN_GETBUTTONINFOW
#else
	#define TBN_GETBUTTONINFO TBN_GETBUTTONINFOA
#endif

#define TBNOTIFYA NMTOOLBARA
#define TBNOTIFYW NMTOOLBARW
#define LPTBNOTIFYA LPNMTOOLBARA
#define LPTBNOTIFYW LPNMTOOLBARW
#define TBNOTIFY NMTOOLBAR
#define LPTBNOTIFY LPNMTOOLBAR

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
	#define NMTOOLBAR NMTOOLBARW
	#define LPNMTOOLBAR LPNMTOOLBARW
#else
	#define NMTOOLBAR NMTOOLBARA
	#define LPNMTOOLBAR LPNMTOOLBARA
#endif

#define REBARCLASSNAMEW wstr("ReBarWindow32")
#define REBARCLASSNAMEA "ReBarWindow32"

#ifdef UNICODE
	#define REBARCLASSNAME REBARCLASSNAMEW
#else
	#define REBARCLASSNAME REBARCLASSNAMEA
#endif

#define RBIM_IMAGELIST &h1
#define RBS_TOOLTIPS &h100
#define RBS_VARHEIGHT &h200
#define RBS_BANDBORDERS &h400
#define RBS_FIXEDORDER &h800
#define RBS_REGISTERDROP &h1000
#define RBS_AUTOSIZE &h2000
#define RBS_VERTICALGRIPPER &h4000
#define RBS_DBLCLKTOGGLE &h8000

type tagREBARINFO
	cbSize as UINT
	fMask as UINT
	himl as HIMAGELIST
end type

type REBARINFO as tagREBARINFO
type LPREBARINFO as tagREBARINFO ptr
#define RBBS_BREAK &h1
#define RBBS_FIXEDSIZE &h2
#define RBBS_CHILDEDGE &h4
#define RBBS_HIDDEN &h8
#define RBBS_NOVERT &h10
#define RBBS_FIXEDBMP &h20
#define RBBS_VARIABLEHEIGHT &h40
#define RBBS_GRIPPERALWAYS &h80
#define RBBS_NOGRIPPER &h100
#define RBBS_USECHEVRON &h200
#define RBBS_HIDETITLE &h400
#define RBBS_TOPALIGN &h800
#define RBBIM_STYLE &h1
#define RBBIM_COLORS &h2
#define RBBIM_TEXT &h4
#define RBBIM_IMAGE &h8
#define RBBIM_CHILD &h10
#define RBBIM_CHILDSIZE &h20
#define RBBIM_SIZE &h40
#define RBBIM_BACKGROUND &h80
#define RBBIM_ID &h100
#define RBBIM_IDEALSIZE &h200
#define RBBIM_LPARAM &h400
#define RBBIM_HEADERSIZE &h800

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
end type

type REBARBANDINFOW as tagREBARBANDINFOW
type LPREBARBANDINFOW as tagREBARBANDINFOW ptr
type LPCREBARBANDINFOW as const REBARBANDINFOW ptr

#ifdef UNICODE
	#define REBARBANDINFO REBARBANDINFOW
	#define LPREBARBANDINFO LPREBARBANDINFOW
	#define LPCREBARBANDINFO LPCREBARBANDINFOW
	#define REBARBANDINFO_V3_SIZE REBARBANDINFOW_V3_SIZE
#else
	#define REBARBANDINFO REBARBANDINFOA
	#define LPREBARBANDINFO LPREBARBANDINFOA
	#define LPCREBARBANDINFO LPCREBARBANDINFOA
	#define REBARBANDINFO_V3_SIZE REBARBANDINFOA_V3_SIZE
#endif

#define RB_INSERTBANDA (WM_USER + 1)
#define RB_DELETEBAND (WM_USER + 2)
#define RB_GETBARINFO (WM_USER + 3)
#define RB_SETBARINFO (WM_USER + 4)
#define RB_SETBANDINFOA (WM_USER + 6)
#define RB_SETPARENT (WM_USER + 7)
#define RB_HITTEST (WM_USER + 8)
#define RB_GETRECT (WM_USER + 9)
#define RB_INSERTBANDW (WM_USER + 10)
#define RB_SETBANDINFOW (WM_USER + 11)
#define RB_GETBANDCOUNT (WM_USER + 12)
#define RB_GETROWCOUNT (WM_USER + 13)
#define RB_GETROWHEIGHT (WM_USER + 14)
#define RB_IDTOINDEX (WM_USER + 16)
#define RB_GETTOOLTIPS (WM_USER + 17)
#define RB_SETTOOLTIPS (WM_USER + 18)
#define RB_SETBKCOLOR (WM_USER + 19)
#define RB_GETBKCOLOR (WM_USER + 20)
#define RB_SETTEXTCOLOR (WM_USER + 21)
#define RB_GETTEXTCOLOR (WM_USER + 22)
#define RBSTR_CHANGERECT &h1
#define RB_SIZETORECT (WM_USER + 23)
#define RB_SETCOLORSCHEME CCM_SETCOLORSCHEME
#define RB_GETCOLORSCHEME CCM_GETCOLORSCHEME

#ifdef UNICODE
	#define RB_INSERTBAND RB_INSERTBANDW
	#define RB_SETBANDINFO RB_SETBANDINFOW
#else
	#define RB_INSERTBAND RB_INSERTBANDA
	#define RB_SETBANDINFO RB_SETBANDINFOA
#endif

#define RB_BEGINDRAG (WM_USER + 24)
#define RB_ENDDRAG (WM_USER + 25)
#define RB_DRAGMOVE (WM_USER + 26)
#define RB_GETBARHEIGHT (WM_USER + 27)
#define RB_GETBANDINFOW (WM_USER + 28)
#define RB_GETBANDINFOA (WM_USER + 29)

#ifdef UNICODE
	#define RB_GETBANDINFO RB_GETBANDINFOW
#else
	#define RB_GETBANDINFO RB_GETBANDINFOA
#endif

#define RB_MINIMIZEBAND (WM_USER + 30)
#define RB_MAXIMIZEBAND (WM_USER + 31)
#define RB_GETDROPTARGET CCM_GETDROPTARGET
#define RB_GETBANDBORDERS (WM_USER + 34)
#define RB_SHOWBAND (WM_USER + 35)
#define RB_SETPALETTE (WM_USER + 37)
#define RB_GETPALETTE (WM_USER + 38)
#define RB_MOVEBAND (WM_USER + 39)
#define RB_SETUNICODEFORMAT CCM_SETUNICODEFORMAT
#define RB_GETUNICODEFORMAT CCM_GETUNICODEFORMAT
#define RB_GETBANDMARGINS (WM_USER + 40)
#define RB_SETWINDOWTHEME CCM_SETWINDOWTHEME
#define RB_PUSHCHEVRON (WM_USER + 43)
#define RBN_HEIGHTCHANGE culng(RBN_FIRST - 0)
#define RBN_GETOBJECT culng(RBN_FIRST - 1)
#define RBN_LAYOUTCHANGED culng(RBN_FIRST - 2)
#define RBN_AUTOSIZE culng(RBN_FIRST - 3)
#define RBN_BEGINDRAG culng(RBN_FIRST - 4)
#define RBN_ENDDRAG culng(RBN_FIRST - 5)
#define RBN_DELETINGBAND culng(RBN_FIRST - 6)
#define RBN_DELETEDBAND culng(RBN_FIRST - 7)
#define RBN_CHILDSIZE culng(RBN_FIRST - 8)
#define RBN_CHEVRONPUSHED culng(RBN_FIRST - 10)
#define RBN_MINMAX culng(RBN_FIRST - 21)
#define RBN_AUTOBREAK culng(RBN_FIRST - 22)

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
#define RBNM_ID &h1
#define RBNM_STYLE &h2
#define RBNM_LPARAM &h4

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
#define RBAB_AUTOSIZE &h1
#define RBAB_ADDBAND &h2

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
#define RBHT_NOWHERE &h1
#define RBHT_CAPTION &h2
#define RBHT_CLIENT &h3
#define RBHT_GRABBER &h4
#define RBHT_CHEVRON &h8

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

#define LPTOOLINFOA LPTTTOOLINFOA
#define LPTOOLINFOW LPTTTOOLINFOW
#define TOOLINFOA TTTOOLINFOA
#define TOOLINFOW TTTOOLINFOW
#define LPTOOLINFO LPTTTOOLINFO
#define TOOLINFO TTTOOLINFO
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
	#define TTTOOLINFO TTTOOLINFOW
	#define PTOOLINFO PTOOLINFOW
	#define LPTTTOOLINFO LPTTTOOLINFOW
	#define TTTOOLINFO_V1_SIZE TTTOOLINFOW_V1_SIZE
#else
	#define TTTOOLINFO TTTOOLINFOA
	#define PTOOLINFO PTOOLINFOA
	#define LPTTTOOLINFO LPTTTOOLINFOA
	#define TTTOOLINFO_V1_SIZE TTTOOLINFOA_V1_SIZE
#endif

#define TTS_ALWAYSTIP &h1
#define TTS_NOPREFIX &h2
#define TTS_NOANIMATE &h10
#define TTS_NOFADE &h20
#define TTS_BALLOON &h40
#define TTS_CLOSE &h80
#define TTF_IDISHWND &h1
#define TTF_CENTERTIP &h2
#define TTF_RTLREADING &h4
#define TTF_SUBCLASS &h10
#define TTF_TRACK &h20
#define TTF_ABSOLUTE &h80
#define TTF_TRANSPARENT &h100
#define TTF_PARSELINKS &h1000
#define TTF_DI_SETITEM &h8000
#define TTDT_AUTOMATIC 0
#define TTDT_RESHOW 1
#define TTDT_AUTOPOP 2
#define TTDT_INITIAL 3
#define TTI_NONE 0
#define TTI_INFO 1
#define TTI_WARNING 2
#define TTI_ERROR 3
#define TTM_ACTIVATE (WM_USER + 1)
#define TTM_SETDELAYTIME (WM_USER + 3)
#define TTM_ADDTOOLA (WM_USER + 4)
#define TTM_ADDTOOLW (WM_USER + 50)
#define TTM_DELTOOLA (WM_USER + 5)
#define TTM_DELTOOLW (WM_USER + 51)
#define TTM_NEWTOOLRECTA (WM_USER + 6)
#define TTM_NEWTOOLRECTW (WM_USER + 52)
#define TTM_RELAYEVENT (WM_USER + 7)
#define TTM_GETTOOLINFOA (WM_USER + 8)
#define TTM_GETTOOLINFOW (WM_USER + 53)
#define TTM_SETTOOLINFOA (WM_USER + 9)
#define TTM_SETTOOLINFOW (WM_USER + 54)
#define TTM_HITTESTA (WM_USER + 10)
#define TTM_HITTESTW (WM_USER + 55)
#define TTM_GETTEXTA (WM_USER + 11)
#define TTM_GETTEXTW (WM_USER + 56)
#define TTM_UPDATETIPTEXTA (WM_USER + 12)
#define TTM_UPDATETIPTEXTW (WM_USER + 57)
#define TTM_GETTOOLCOUNT (WM_USER + 13)
#define TTM_ENUMTOOLSA (WM_USER + 14)
#define TTM_ENUMTOOLSW (WM_USER + 58)
#define TTM_GETCURRENTTOOLA (WM_USER + 15)
#define TTM_GETCURRENTTOOLW (WM_USER + 59)
#define TTM_WINDOWFROMPOINT (WM_USER + 16)
#define TTM_TRACKACTIVATE (WM_USER + 17)
#define TTM_TRACKPOSITION (WM_USER + 18)
#define TTM_SETTIPBKCOLOR (WM_USER + 19)
#define TTM_SETTIPTEXTCOLOR (WM_USER + 20)
#define TTM_GETDELAYTIME (WM_USER + 21)
#define TTM_GETTIPBKCOLOR (WM_USER + 22)
#define TTM_GETTIPTEXTCOLOR (WM_USER + 23)
#define TTM_SETMAXTIPWIDTH (WM_USER + 24)
#define TTM_GETMAXTIPWIDTH (WM_USER + 25)
#define TTM_SETMARGIN (WM_USER + 26)
#define TTM_GETMARGIN (WM_USER + 27)
#define TTM_POP (WM_USER + 28)
#define TTM_UPDATE (WM_USER + 29)
#define TTM_GETBUBBLESIZE (WM_USER + 30)
#define TTM_ADJUSTRECT (WM_USER + 31)
#define TTM_SETTITLEA (WM_USER + 32)
#define TTM_SETTITLEW (WM_USER + 33)
#define TTM_POPUP (WM_USER + 34)
#define TTM_GETTITLE (WM_USER + 35)

type _TTGETTITLE
	dwSize as DWORD
	uTitleBitmap as UINT
	cch as UINT
	pszTitle as wstring ptr
end type

type TTGETTITLE as _TTGETTITLE
type PTTGETTITLE as _TTGETTITLE ptr

#ifdef UNICODE
	#define TTM_ADDTOOL TTM_ADDTOOLW
	#define TTM_DELTOOL TTM_DELTOOLW
	#define TTM_NEWTOOLRECT TTM_NEWTOOLRECTW
	#define TTM_GETTOOLINFO TTM_GETTOOLINFOW
	#define TTM_SETTOOLINFO TTM_SETTOOLINFOW
	#define TTM_HITTEST TTM_HITTESTW
	#define TTM_GETTEXT TTM_GETTEXTW
	#define TTM_UPDATETIPTEXT TTM_UPDATETIPTEXTW
	#define TTM_ENUMTOOLS TTM_ENUMTOOLSW
	#define TTM_GETCURRENTTOOL TTM_GETCURRENTTOOLW
	#define TTM_SETTITLE TTM_SETTITLEW
#else
	#define TTM_ADDTOOL TTM_ADDTOOLA
	#define TTM_DELTOOL TTM_DELTOOLA
	#define TTM_NEWTOOLRECT TTM_NEWTOOLRECTA
	#define TTM_GETTOOLINFO TTM_GETTOOLINFOA
	#define TTM_SETTOOLINFO TTM_SETTOOLINFOA
	#define TTM_HITTEST TTM_HITTESTA
	#define TTM_GETTEXT TTM_GETTEXTA
	#define TTM_UPDATETIPTEXT TTM_UPDATETIPTEXTA
	#define TTM_ENUMTOOLS TTM_ENUMTOOLSA
	#define TTM_GETCURRENTTOOL TTM_GETCURRENTTOOLA
	#define TTM_SETTITLE TTM_SETTITLEA
#endif

#define TTM_SETWINDOWTHEME CCM_SETWINDOWTHEME
#define LPHITTESTINFOW LPTTHITTESTINFOW
#define LPHITTESTINFOA LPTTHITTESTINFOA
#define LPHITTESTINFO LPTTHITTESTINFO

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
	#define TTHITTESTINFO TTHITTESTINFOW
	#define LPTTHITTESTINFO LPTTHITTESTINFOW
#else
	#define TTHITTESTINFO TTHITTESTINFOA
	#define LPTTHITTESTINFO LPTTHITTESTINFOA
#endif

#define TTN_GETDISPINFOA culng(TTN_FIRST - 0)
#define TTN_GETDISPINFOW culng(TTN_FIRST - 10)
#define TTN_SHOW culng(TTN_FIRST - 1)
#define TTN_POP culng(TTN_FIRST - 2)
#define TTN_LINKCLICK culng(TTN_FIRST - 3)

#ifdef UNICODE
	#define TTN_GETDISPINFO TTN_GETDISPINFOW
#else
	#define TTN_GETDISPINFO TTN_GETDISPINFOA
#endif

#define TTN_NEEDTEXT TTN_GETDISPINFO
#define TTN_NEEDTEXTA TTN_GETDISPINFOA
#define TTN_NEEDTEXTW TTN_GETDISPINFOW
#define TOOLTIPTEXTW NMTTDISPINFOW
#define TOOLTIPTEXTA NMTTDISPINFOA
#define LPTOOLTIPTEXTA LPNMTTDISPINFOA
#define LPTOOLTIPTEXTW LPNMTTDISPINFOW
#define TOOLTIPTEXT NMTTDISPINFO
#define LPTOOLTIPTEXT LPNMTTDISPINFO
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
	#define NMTTDISPINFO NMTTDISPINFOW
	#define LPNMTTDISPINFO LPNMTTDISPINFOW
	#define NMTTDISPINFO_V1_SIZE NMTTDISPINFOW_V1_SIZE
#else
	#define NMTTDISPINFO NMTTDISPINFOA
	#define LPNMTTDISPINFO LPNMTTDISPINFOA
	#define NMTTDISPINFO_V1_SIZE NMTTDISPINFOA_V1_SIZE
#endif

#define SBARS_SIZEGRIP &h100
#define SBARS_TOOLTIPS &h800
#define SBT_TOOLTIPS &h800

declare sub DrawStatusTextA(byval hDC as HDC, byval lprc as LPCRECT, byval pszText as LPCSTR, byval uFlags as UINT)
declare sub DrawStatusTextW(byval hDC as HDC, byval lprc as LPCRECT, byval pszText as LPCWSTR, byval uFlags as UINT)
declare function CreateStatusWindowA(byval style as LONG, byval lpszText as LPCSTR, byval hwndParent as HWND, byval wID as UINT) as HWND
declare function CreateStatusWindowW(byval style as LONG, byval lpszText as LPCWSTR, byval hwndParent as HWND, byval wID as UINT) as HWND

#ifdef UNICODE
	#define CreateStatusWindow CreateStatusWindowW
	#define DrawStatusText DrawStatusTextW
#else
	#define CreateStatusWindow CreateStatusWindowA
	#define DrawStatusText DrawStatusTextA
#endif

#define STATUSCLASSNAMEW wstr("msctls_statusbar32")
#define STATUSCLASSNAMEA "msctls_statusbar32"

#ifdef UNICODE
	#define STATUSCLASSNAME STATUSCLASSNAMEW
#else
	#define STATUSCLASSNAME STATUSCLASSNAMEA
#endif

#define SB_SETTEXTA (WM_USER + 1)
#define SB_SETTEXTW (WM_USER + 11)
#define SB_GETTEXTA (WM_USER + 2)
#define SB_GETTEXTW (WM_USER + 13)
#define SB_GETTEXTLENGTHA (WM_USER + 3)
#define SB_GETTEXTLENGTHW (WM_USER + 12)

#ifdef UNICODE
	#define SB_GETTEXT SB_GETTEXTW
	#define SB_SETTEXT SB_SETTEXTW
	#define SB_GETTEXTLENGTH SB_GETTEXTLENGTHW
	#define SB_SETTIPTEXT SB_SETTIPTEXTW
	#define SB_GETTIPTEXT SB_GETTIPTEXTW
#else
	#define SB_GETTEXT SB_GETTEXTA
	#define SB_SETTEXT SB_SETTEXTA
	#define SB_GETTEXTLENGTH SB_GETTEXTLENGTHA
	#define SB_SETTIPTEXT SB_SETTIPTEXTA
	#define SB_GETTIPTEXT SB_GETTIPTEXTA
#endif

#define SB_SETPARTS (WM_USER + 4)
#define SB_GETPARTS (WM_USER + 6)
#define SB_GETBORDERS (WM_USER + 7)
#define SB_SETMINHEIGHT (WM_USER + 8)
#define SB_SIMPLE (WM_USER + 9)
#define SB_GETRECT (WM_USER + 10)
#define SB_ISSIMPLE (WM_USER + 14)
#define SB_SETICON (WM_USER + 15)
#define SB_SETTIPTEXTA (WM_USER + 16)
#define SB_SETTIPTEXTW (WM_USER + 17)
#define SB_GETTIPTEXTA (WM_USER + 18)
#define SB_GETTIPTEXTW (WM_USER + 19)
#define SB_GETICON (WM_USER + 20)
#define SB_SETUNICODEFORMAT CCM_SETUNICODEFORMAT
#define SB_GETUNICODEFORMAT CCM_GETUNICODEFORMAT
#define SBT_OWNERDRAW &h1000
#define SBT_NOBORDERS &h100
#define SBT_POPOUT &h200
#define SBT_RTLREADING &h400
#define SBT_NOTABPARSING &h800
#define SB_SETBKCOLOR CCM_SETBKCOLOR
#define SBN_SIMPLEMODECHANGE culng(SBN_FIRST - 0)
#define SB_SIMPLEID &hff

declare sub MenuHelp(byval uMsg as UINT, byval wParam as WPARAM, byval lParam as LPARAM, byval hMainMenu as HMENU, byval hInst as HINSTANCE, byval hwndStatus as HWND, byval lpwIDs as UINT ptr)
declare function ShowHideMenuCtl(byval hWnd as HWND, byval uFlags as UINT_PTR, byval lpInfo as LPINT) as WINBOOL
declare sub GetEffectiveClientRect(byval hWnd as HWND, byval lprc as LPRECT, byval lpInfo as const INT_ ptr)

#define MINSYSCOMMAND SC_SIZE
#define TRACKBAR_CLASSA "msctls_trackbar32"
#define TRACKBAR_CLASSW wstr("msctls_trackbar32")

#ifdef UNICODE
	#define TRACKBAR_CLASS TRACKBAR_CLASSW
#else
	#define TRACKBAR_CLASS TRACKBAR_CLASSA
#endif

#define TBS_AUTOTICKS &h1
#define TBS_VERT &h2
#define TBS_HORZ &h0
#define TBS_TOP &h4
#define TBS_BOTTOM &h0
#define TBS_LEFT &h4
#define TBS_RIGHT &h0
#define TBS_BOTH &h8
#define TBS_NOTICKS &h10
#define TBS_ENABLESELRANGE &h20
#define TBS_FIXEDLENGTH &h40
#define TBS_NOTHUMB &h80
#define TBS_TOOLTIPS &h100
#define TBS_REVERSED &h200
#define TBS_DOWNISLEFT &h400
#define TBM_GETPOS WM_USER
#define TBM_GETRANGEMIN (WM_USER + 1)
#define TBM_GETRANGEMAX (WM_USER + 2)
#define TBM_GETTIC (WM_USER + 3)
#define TBM_SETTIC (WM_USER + 4)
#define TBM_SETPOS (WM_USER + 5)
#define TBM_SETRANGE (WM_USER + 6)
#define TBM_SETRANGEMIN (WM_USER + 7)
#define TBM_SETRANGEMAX (WM_USER + 8)
#define TBM_CLEARTICS (WM_USER + 9)
#define TBM_SETSEL (WM_USER + 10)
#define TBM_SETSELSTART (WM_USER + 11)
#define TBM_SETSELEND (WM_USER + 12)
#define TBM_GETPTICS (WM_USER + 14)
#define TBM_GETTICPOS (WM_USER + 15)
#define TBM_GETNUMTICS (WM_USER + 16)
#define TBM_GETSELSTART (WM_USER + 17)
#define TBM_GETSELEND (WM_USER + 18)
#define TBM_CLEARSEL (WM_USER + 19)
#define TBM_SETTICFREQ (WM_USER + 20)
#define TBM_SETPAGESIZE (WM_USER + 21)
#define TBM_GETPAGESIZE (WM_USER + 22)
#define TBM_SETLINESIZE (WM_USER + 23)
#define TBM_GETLINESIZE (WM_USER + 24)
#define TBM_GETTHUMBRECT (WM_USER + 25)
#define TBM_GETCHANNELRECT (WM_USER + 26)
#define TBM_SETTHUMBLENGTH (WM_USER + 27)
#define TBM_GETTHUMBLENGTH (WM_USER + 28)
#define TBM_SETTOOLTIPS (WM_USER + 29)
#define TBM_GETTOOLTIPS (WM_USER + 30)
#define TBM_SETTIPSIDE (WM_USER + 31)
#define TBTS_TOP 0
#define TBTS_LEFT 1
#define TBTS_BOTTOM 2
#define TBTS_RIGHT 3
#define TBM_SETBUDDY (WM_USER + 32)
#define TBM_GETBUDDY (WM_USER + 33)
#define TBM_SETUNICODEFORMAT CCM_SETUNICODEFORMAT
#define TBM_GETUNICODEFORMAT CCM_GETUNICODEFORMAT
#define TB_LINEUP 0
#define TB_LINEDOWN 1
#define TB_PAGEUP 2
#define TB_PAGEDOWN 3
#define TB_THUMBPOSITION 4
#define TB_THUMBTRACK 5
#define TB_TOP 6
#define TB_BOTTOM 7
#define TB_ENDTRACK 8
#define TBCD_TICS &h1
#define TBCD_THUMB &h2
#define TBCD_CHANNEL &h3

type tagDRAGLISTINFO
	uNotification as UINT
	hWnd as HWND
	ptCursor as POINT
end type

type DRAGLISTINFO as tagDRAGLISTINFO
type LPDRAGLISTINFO as tagDRAGLISTINFO ptr
#define DL_BEGINDRAG (WM_USER + 133)
#define DL_DRAGGING (WM_USER + 134)
#define DL_DROPPED (WM_USER + 135)
#define DL_CANCELDRAG (WM_USER + 136)
#define DL_CURSORSET 0
#define DL_STOPCURSOR 1
#define DL_COPYCURSOR 2
#define DL_MOVECURSOR 3
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
#define UD_MAXVAL &h7fff
#define UD_MINVAL (-UD_MAXVAL)
#define UDS_WRAP &h1
#define UDS_SETBUDDYINT &h2
#define UDS_ALIGNRIGHT &h4
#define UDS_ALIGNLEFT &h8
#define UDS_AUTOBUDDY &h10
#define UDS_ARROWKEYS &h20
#define UDS_HORZ &h40
#define UDS_NOTHOUSANDS &h80
#define UDS_HOTTRACK &h100
#define UDM_SETRANGE (WM_USER + 101)
#define UDM_GETRANGE (WM_USER + 102)
#define UDM_SETPOS (WM_USER + 103)
#define UDM_GETPOS (WM_USER + 104)
#define UDM_SETBUDDY (WM_USER + 105)
#define UDM_GETBUDDY (WM_USER + 106)
#define UDM_SETACCEL (WM_USER + 107)
#define UDM_GETACCEL (WM_USER + 108)
#define UDM_SETBASE (WM_USER + 109)
#define UDM_GETBASE (WM_USER + 110)
#define UDM_SETRANGE32 (WM_USER + 111)
#define UDM_GETRANGE32 (WM_USER + 112)
#define UDM_SETUNICODEFORMAT CCM_SETUNICODEFORMAT
#define UDM_GETUNICODEFORMAT CCM_GETUNICODEFORMAT
#define UDM_SETPOS32 (WM_USER + 113)
#define UDM_GETPOS32 (WM_USER + 114)
declare function CreateUpDownControl(byval dwStyle as DWORD, byval x as long, byval y as long, byval cx as long, byval cy as long, byval hParent as HWND, byval nID as long, byval hInst as HINSTANCE, byval hBuddy as HWND, byval nUpper as long, byval nLower as long, byval nPos as long) as HWND
#define NM_UPDOWN NMUPDOWN
#define LPNM_UPDOWN LPNMUPDOWN

type _NM_UPDOWN
	hdr as NMHDR
	iPos as long
	iDelta as long
end type

type NMUPDOWN as _NM_UPDOWN
type LPNMUPDOWN as _NM_UPDOWN ptr
#define UDN_DELTAPOS culng(UDN_FIRST - 1)
#define PROGRESS_CLASSA "msctls_progress32"
#define PROGRESS_CLASSW wstr("msctls_progress32")

#ifdef UNICODE
	#define PROGRESS_CLASS PROGRESS_CLASSW
#else
	#define PROGRESS_CLASS PROGRESS_CLASSA
#endif

#define PBS_SMOOTH &h1
#define PBS_VERTICAL &h4
#define PBM_SETRANGE (WM_USER + 1)
#define PBM_SETPOS (WM_USER + 2)
#define PBM_DELTAPOS (WM_USER + 3)
#define PBM_SETSTEP (WM_USER + 4)
#define PBM_STEPIT (WM_USER + 5)
#define PBM_SETRANGE32 (WM_USER + 6)

type PBRANGE
	iLow as long
	iHigh as long
end type

type PPBRANGE as PBRANGE ptr
#define PBM_GETRANGE (WM_USER + 7)
#define PBM_GETPOS (WM_USER + 8)
#define PBM_SETBARCOLOR (WM_USER + 9)
#define PBM_SETBKCOLOR CCM_SETBKCOLOR
#define PBS_MARQUEE &h8
#define PBM_SETMARQUEE (WM_USER + 10)

#if _WIN32_WINNT = &h0602
	#define PBM_GETSTEP (WM_USER + 13)
	#define PBM_GETBKCOLOR (WM_USER + 14)
	#define PBM_GETBARCOLOR (WM_USER + 15)
	#define PBM_SETSTATE (WM_USER + 16)
	#define PBM_GETSTATE (WM_USER + 17)
	#define PBS_SMOOTHREVERSE &h10
	#define PBST_NORMAL 1
	#define PBST_ERROR 2
	#define PBST_PAUSED 3
#endif

#define HOTKEYF_SHIFT &h1
#define HOTKEYF_CONTROL &h2
#define HOTKEYF_ALT &h4
#define HOTKEYF_EXT &h8
#define HKCOMB_NONE &h1
#define HKCOMB_S &h2
#define HKCOMB_C &h4
#define HKCOMB_A &h8
#define HKCOMB_SC &h10
#define HKCOMB_SA &h20
#define HKCOMB_CA &h40
#define HKCOMB_SCA &h80
#define HKM_SETHOTKEY (WM_USER + 1)
#define HKM_GETHOTKEY (WM_USER + 2)
#define HKM_SETRULES (WM_USER + 3)
#define HOTKEY_CLASSA "msctls_hotkey32"
#define HOTKEY_CLASSW wstr("msctls_hotkey32")

#ifdef UNICODE
	#define HOTKEY_CLASS HOTKEY_CLASSW
#else
	#define HOTKEY_CLASS HOTKEY_CLASSA
#endif

#define CCS_TOP __MSABI_LONG(&h1)
#define CCS_NOMOVEY __MSABI_LONG(&h2)
#define CCS_BOTTOM __MSABI_LONG(&h3)
#define CCS_NORESIZE __MSABI_LONG(&h4)
#define CCS_NOPARENTALIGN __MSABI_LONG(&h8)
#define CCS_ADJUSTABLE __MSABI_LONG(&h20)
#define CCS_NODIVIDER __MSABI_LONG(&h40)
#define CCS_VERT __MSABI_LONG(&h80)
#define CCS_LEFT (CCS_VERT or CCS_TOP)
#define CCS_RIGHT (CCS_VERT or CCS_BOTTOM)
#define CCS_NOMOVEX (CCS_VERT or CCS_NOMOVEY)
#define WC_LISTVIEWA "SysListView32"
#define WC_LISTVIEWW wstr("SysListView32")

#ifdef UNICODE
	#define WC_LISTVIEW WC_LISTVIEWW
#else
	#define WC_LISTVIEW WC_LISTVIEWA
#endif

#define LVS_ICON &h0
#define LVS_REPORT &h1
#define LVS_SMALLICON &h2
#define LVS_LIST &h3
#define LVS_TYPEMASK &h3
#define LVS_SINGLESEL &h4
#define LVS_SHOWSELALWAYS &h8
#define LVS_SORTASCENDING &h10
#define LVS_SORTDESCENDING &h20
#define LVS_SHAREIMAGELISTS &h40
#define LVS_NOLABELWRAP &h80
#define LVS_AUTOARRANGE &h100
#define LVS_EDITLABELS &h200
#define LVS_OWNERDATA &h1000
#define LVS_NOSCROLL &h2000
#define LVS_TYPESTYLEMASK &hfc00
#define LVS_ALIGNTOP &h0
#define LVS_ALIGNLEFT &h800
#define LVS_ALIGNMASK &hc00
#define LVS_OWNERDRAWFIXED &h400
#define LVS_NOCOLUMNHEADER &h4000
#define LVS_NOSORTHEADER &h8000
#define LVM_SETUNICODEFORMAT CCM_SETUNICODEFORMAT
#define ListView_SetUnicodeFormat(hwnd, fUnicode) cast(WINBOOL, SNDMSG((hwnd), LVM_SETUNICODEFORMAT, cast(WPARAM, (fUnicode)), 0))
#define LVM_GETUNICODEFORMAT CCM_GETUNICODEFORMAT
#define ListView_GetUnicodeFormat(hwnd) cast(WINBOOL, SNDMSG((hwnd), LVM_GETUNICODEFORMAT, 0, 0))
#define LVM_GETBKCOLOR (LVM_FIRST + 0)
#define ListView_GetBkColor(hwnd) cast(COLORREF, SNDMSG((hwnd), LVM_GETBKCOLOR, cast(WPARAM, 0), cast(LPARAM, 0)))
#define LVM_SETBKCOLOR (LVM_FIRST + 1)
#define ListView_SetBkColor(hwnd, clrBk) cast(WINBOOL, SNDMSG((hwnd), LVM_SETBKCOLOR, 0, cast(LPARAM, cast(COLORREF, (clrBk)))))
#define LVM_GETIMAGELIST (LVM_FIRST + 2)
#define ListView_GetImageList(hwnd, iImageList) cast(HIMAGELIST, SNDMSG((hwnd), LVM_GETIMAGELIST, cast(WPARAM, cast(INT_, (iImageList))), cast(LPARAM, 0)))
#define LVSIL_NORMAL 0
#define LVSIL_SMALL 1
#define LVSIL_STATE 2
#define LVM_SETIMAGELIST (LVM_FIRST + 3)
#define ListView_SetImageList(hwnd, himl, iImageList) cast(HIMAGELIST, SNDMSG((hwnd), LVM_SETIMAGELIST, cast(WPARAM, (iImageList)), cast(LPARAM, cast(HIMAGELIST, (himl)))))
#define LVM_GETITEMCOUNT (LVM_FIRST + 4)
#define ListView_GetItemCount(hwnd) clng(SNDMSG((hwnd), LVM_GETITEMCOUNT, cast(WPARAM, 0), cast(LPARAM, 0)))
#define LVIF_TEXT &h1
#define LVIF_IMAGE &h2
#define LVIF_PARAM &h4
#define LVIF_STATE &h8
#define LVIF_INDENT &h10
#define LVIF_NORECOMPUTE &h800
#define LVIF_GROUPID &h100
#define LVIF_COLUMNS &h200
#define LVIS_FOCUSED &h1
#define LVIS_SELECTED &h2
#define LVIS_CUT &h4
#define LVIS_DROPHILITED &h8
#define LVIS_GLOW &h10
#define LVIS_ACTIVATING &h20
#define LVIS_OVERLAYMASK &hf00
#define LVIS_STATEIMAGEMASK &hF000
#define INDEXTOSTATEIMAGEMASK(i) ((i) shl 12)
#define I_INDENTCALLBACK (-1)
#define LV_ITEMA LVITEMA
#define LV_ITEMW LVITEMW
#define I_GROUPIDCALLBACK (-1)
#define I_GROUPIDNONE (-2)
#define LV_ITEM LVITEM
#define LVITEMA_V1_SIZE CCSIZEOF_STRUCT(LVITEMA, lParam)
#define LVITEMW_V1_SIZE CCSIZEOF_STRUCT(LVITEMW, lParam)

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
end type

type LVITEMW as tagLVITEMW
type LPLVITEMW as tagLVITEMW ptr

#ifdef UNICODE
	#define LVITEM LVITEMW
	#define LPLVITEM LPLVITEMW
	#define LVITEM_V1_SIZE LVITEMW_V1_SIZE
#else
	#define LVITEM LVITEMA
	#define LPLVITEM LPLVITEMA
	#define LVITEM_V1_SIZE LVITEMA_V1_SIZE
#endif

#define LPSTR_TEXTCALLBACKW cast(LPWSTR, cast(INT_PTR, -1))
#define LPSTR_TEXTCALLBACKA cast(LPSTR, cast(INT_PTR, -1))

#ifdef UNICODE
	#define LPSTR_TEXTCALLBACK LPSTR_TEXTCALLBACKW
#else
	#define LPSTR_TEXTCALLBACK LPSTR_TEXTCALLBACKA
#endif

#define I_IMAGECALLBACK (-1)
#define I_IMAGENONE (-2)
#define I_COLUMNSCALLBACK cast(UINT, -1)
#define LVM_GETITEMA (LVM_FIRST + 5)
#define LVM_GETITEMW (LVM_FIRST + 75)

#ifdef UNICODE
	#define LVM_GETITEM LVM_GETITEMW
#else
	#define LVM_GETITEM LVM_GETITEMA
#endif

#define ListView_GetItem(hwnd, pitem) cast(WINBOOL, SNDMSG((hwnd), LVM_GETITEM, 0, cast(LPARAM, cptr(LV_ITEM ptr, (pitem)))))
#define LVM_SETITEMA (LVM_FIRST + 6)
#define LVM_SETITEMW (LVM_FIRST + 76)

#ifdef UNICODE
	#define LVM_SETITEM LVM_SETITEMW
#else
	#define LVM_SETITEM LVM_SETITEMA
#endif

#define ListView_SetItem(hwnd, pitem) cast(WINBOOL, SNDMSG((hwnd), LVM_SETITEM, 0, cast(LPARAM, cptr(const LV_ITEM ptr, (pitem)))))
#define LVM_INSERTITEMA (LVM_FIRST + 7)
#define LVM_INSERTITEMW (LVM_FIRST + 77)

#ifdef UNICODE
	#define LVM_INSERTITEM LVM_INSERTITEMW
#else
	#define LVM_INSERTITEM LVM_INSERTITEMA
#endif

#define ListView_InsertItem(hwnd, pitem) clng(SNDMSG((hwnd), LVM_INSERTITEM, 0, cast(LPARAM, cptr(const LV_ITEM ptr, (pitem)))))
#define LVM_DELETEITEM (LVM_FIRST + 8)
#define ListView_DeleteItem(hwnd, i) cast(WINBOOL, SNDMSG((hwnd), LVM_DELETEITEM, cast(WPARAM, clng((i))), cast(LPARAM, 0)))
#define LVM_DELETEALLITEMS (LVM_FIRST + 9)
#define ListView_DeleteAllItems(hwnd) cast(WINBOOL, SNDMSG((hwnd), LVM_DELETEALLITEMS, cast(WPARAM, 0), cast(LPARAM, 0)))
#define LVM_GETCALLBACKMASK (LVM_FIRST + 10)
#define ListView_GetCallbackMask(hwnd) cast(WINBOOL, SNDMSG((hwnd), LVM_GETCALLBACKMASK, 0, 0))
#define LVM_SETCALLBACKMASK (LVM_FIRST + 11)
#define ListView_SetCallbackMask(hwnd, mask) cast(WINBOOL, SNDMSG((hwnd), LVM_SETCALLBACKMASK, cast(WPARAM, cast(UINT, (mask))), 0))
#define LVNI_ALL &h0
#define LVNI_FOCUSED &h1
#define LVNI_SELECTED &h2
#define LVNI_CUT &h4
#define LVNI_DROPHILITED &h8
#define LVNI_ABOVE &h100
#define LVNI_BELOW &h200
#define LVNI_TOLEFT &h400
#define LVNI_TORIGHT &h800
#define LVM_GETNEXTITEM (LVM_FIRST + 12)
#define ListView_GetNextItem(hwnd, i, flags) clng(SNDMSG((hwnd), LVM_GETNEXTITEM, cast(WPARAM, clng((i))), MAKELPARAM((flags), 0)))
#define LVFI_PARAM &h1
#define LVFI_STRING &h2
#define LVFI_PARTIAL &h8
#define LVFI_WRAP &h20
#define LVFI_NEARESTXY &h40
#define LV_FINDINFOA LVFINDINFOA
#define LV_FINDINFOW LVFINDINFOW
#define LV_FINDINFO LVFINDINFO

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
	#define LVFINDINFO LVFINDINFOW
#else
	#define LVFINDINFO LVFINDINFOA
#endif

#define LVM_FINDITEMA (LVM_FIRST + 13)
#define LVM_FINDITEMW (LVM_FIRST + 83)

#ifdef UNICODE
	#define LVM_FINDITEM LVM_FINDITEMW
#else
	#define LVM_FINDITEM LVM_FINDITEMA
#endif

#define ListView_FindItem(hwnd, iStart, plvfi) clng(SNDMSG((hwnd), LVM_FINDITEM, cast(WPARAM, clng((iStart))), cast(LPARAM, cptr(const LV_FINDINFO ptr, (plvfi)))))
#define LVIR_BOUNDS 0
#define LVIR_ICON 1
#define LVIR_LABEL 2
#define LVIR_SELECTBOUNDS 3
#define LVM_GETITEMRECT (LVM_FIRST + 14)
private function ListView_GetItemRect(byval hwnd as HWND, byval i as long, byval prc as RECT ptr, byval code as long) as WINBOOL
	if prc then
		prc->left = code
	end if
	function = SNDMSG(hwnd, LVM_GETITEMRECT, cast(WPARAM, i), cast(LPARAM, prc))
end function
#define LVM_SETITEMPOSITION (LVM_FIRST + 15)
#define ListView_SetItemPosition(hwndLV, i, x, y) cast(WINBOOL, SNDMSG((hwndLV), LVM_SETITEMPOSITION, cast(WPARAM, clng((i))), MAKELPARAM((x), (y))))
#define LVM_GETITEMPOSITION (LVM_FIRST + 16)
#define ListView_GetItemPosition(hwndLV, i, ppt) cast(WINBOOL, SNDMSG((hwndLV), LVM_GETITEMPOSITION, cast(WPARAM, clng((i))), cast(LPARAM, cptr(POINT ptr, (ppt)))))
#define LVM_GETSTRINGWIDTHA (LVM_FIRST + 17)
#define LVM_GETSTRINGWIDTHW (LVM_FIRST + 87)

#ifdef UNICODE
	#define LVM_GETSTRINGWIDTH LVM_GETSTRINGWIDTHW
#else
	#define LVM_GETSTRINGWIDTH LVM_GETSTRINGWIDTHA
#endif

#define ListView_GetStringWidth(hwndLV, psz) clng(SNDMSG((hwndLV), LVM_GETSTRINGWIDTH, 0, cast(LPARAM, cast(LPCTSTR, (psz)))))
#define LVHT_NOWHERE &h1
#define LVHT_ONITEMICON &h2
#define LVHT_ONITEMLABEL &h4
#define LVHT_ONITEMSTATEICON &h8
#define LVHT_ONITEM ((LVHT_ONITEMICON or LVHT_ONITEMLABEL) or LVHT_ONITEMSTATEICON)
#define LVHT_ABOVE &h8
#define LVHT_BELOW &h10
#define LVHT_TORIGHT &h20
#define LVHT_TOLEFT &h40
#define LV_HITTESTINFO LVHITTESTINFO
#define LVHITTESTINFO_V1_SIZE CCSIZEOF_STRUCT(LVHITTESTINFO, iItem)

type tagLVHITTESTINFO
	pt as POINT
	flags as UINT
	iItem as long
	iSubItem as long
end type

type LVHITTESTINFO as tagLVHITTESTINFO
type LPLVHITTESTINFO as tagLVHITTESTINFO ptr
#define LVM_HITTEST (LVM_FIRST + 18)
#define ListView_HitTest(hwndLV, pinfo) clng(SNDMSG((hwndLV), LVM_HITTEST, 0, cast(LPARAM, cptr(LV_HITTESTINFO ptr, (pinfo)))))
#define LVM_ENSUREVISIBLE (LVM_FIRST + 19)
#define ListView_EnsureVisible(hwndLV, i, fPartialOK) cast(WINBOOL, SNDMSG((hwndLV), LVM_ENSUREVISIBLE, cast(WPARAM, clng((i))), MAKELPARAM((fPartialOK), 0)))
#define LVM_SCROLL (LVM_FIRST + 20)
#define ListView_Scroll(hwndLV, dx, dy) cast(WINBOOL, SNDMSG((hwndLV), LVM_SCROLL, cast(WPARAM, clng((dx))), cast(LPARAM, clng((dy)))))
#define LVM_REDRAWITEMS (LVM_FIRST + 21)
#define ListView_RedrawItems(hwndLV, iFirst, iLast) cast(WINBOOL, SNDMSG((hwndLV), LVM_REDRAWITEMS, cast(WPARAM, clng((iFirst))), cast(LPARAM, clng((iLast)))))
#define LVA_DEFAULT &h0
#define LVA_ALIGNLEFT &h1
#define LVA_ALIGNTOP &h2
#define LVA_SNAPTOGRID &h5
#define LVM_ARRANGE (LVM_FIRST + 22)
#define ListView_Arrange(hwndLV, code) cast(WINBOOL, SNDMSG((hwndLV), LVM_ARRANGE, cast(WPARAM, cast(UINT, (code))), cast(LPARAM, 0)))
#define LVM_EDITLABELA (LVM_FIRST + 23)
#define LVM_EDITLABELW (LVM_FIRST + 118)

#ifdef UNICODE
	#define LVM_EDITLABEL LVM_EDITLABELW
#else
	#define LVM_EDITLABEL LVM_EDITLABELA
#endif

#define ListView_EditLabel(hwndLV, i) cast(HWND, SNDMSG((hwndLV), LVM_EDITLABEL, cast(WPARAM, clng((i))), cast(LPARAM, 0)))
#define LVM_GETEDITCONTROL (LVM_FIRST + 24)
#define ListView_GetEditControl(hwndLV) cast(HWND, SNDMSG((hwndLV), LVM_GETEDITCONTROL, cast(WPARAM, 0), cast(LPARAM, 0)))
#define LV_COLUMNA LVCOLUMNA
#define LV_COLUMNW LVCOLUMNW
#define LV_COLUMN LVCOLUMN
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

	#if _WIN32_WINNT = &h0602
		cxMin as long
		cxDefault as long
		cxIdeal as long
	#endif
end type

type LVCOLUMNW as tagLVCOLUMNW
type LPLVCOLUMNW as tagLVCOLUMNW ptr

#ifdef UNICODE
	#define LVCOLUMN LVCOLUMNW
	#define LPLVCOLUMN LPLVCOLUMNW
	#define LVCOLUMN_V1_SIZE LVCOLUMNW_V1_SIZE
#else
	#define LVCOLUMN LVCOLUMNA
	#define LPLVCOLUMN LPLVCOLUMNA
	#define LVCOLUMN_V1_SIZE LVCOLUMNA_V1_SIZE
#endif

#define LVCF_FMT &h1
#define LVCF_WIDTH &h2
#define LVCF_TEXT &h4
#define LVCF_SUBITEM &h8
#define LVCF_IMAGE &h10
#define LVCF_ORDER &h20

#if _WIN32_WINNT = &h0602
	#define LVCF_MINWIDTH &h40
	#define LVCF_DEFAULTWIDTH &h80
	#define LVCF_IDEALWIDTH &h100
#endif

#define LVCFMT_LEFT &h0
#define LVCFMT_RIGHT &h1
#define LVCFMT_CENTER &h2
#define LVCFMT_JUSTIFYMASK &h3
#define LVCFMT_IMAGE &h800
#define LVCFMT_BITMAP_ON_RIGHT &h1000
#define LVCFMT_COL_HAS_IMAGES &h8000

#if _WIN32_WINNT = &h0602
	#define LVCFMT_FIXED_WIDTH &h100
	#define LVCFMT_NO_DPI_SCALE &h40000
	#define LVCFMT_FIXED_RATIO &h80000
	#define LVCFMT_LINE_BREAK &h100000
	#define LVCFMT_FILL &h200000
	#define LVCFMT_WRAP &h400000
	#define LVCFMT_NO_TITLE &h800000
	#define LVCFMT_SPLITBUTTON &h1000000
	#define LVCFMT_TILE_PLACEMENTMASK (LVCFMT_LINE_BREAK or LVCFMT_FILL)
#endif

#define LVM_GETCOLUMNA (LVM_FIRST + 25)
#define LVM_GETCOLUMNW (LVM_FIRST + 95)

#ifdef UNICODE
	#define LVM_GETCOLUMN LVM_GETCOLUMNW
#else
	#define LVM_GETCOLUMN LVM_GETCOLUMNA
#endif

#define ListView_GetColumn(hwnd, iCol, pcol) cast(WINBOOL, SNDMSG((hwnd), LVM_GETCOLUMN, cast(WPARAM, clng((iCol))), cast(LPARAM, cptr(LV_COLUMN ptr, (pcol)))))
#define LVM_SETCOLUMNA (LVM_FIRST + 26)
#define LVM_SETCOLUMNW (LVM_FIRST + 96)

#ifdef UNICODE
	#define LVM_SETCOLUMN LVM_SETCOLUMNW
#else
	#define LVM_SETCOLUMN LVM_SETCOLUMNA
#endif

#define ListView_SetColumn(hwnd, iCol, pcol) cast(WINBOOL, SNDMSG((hwnd), LVM_SETCOLUMN, cast(WPARAM, clng((iCol))), cast(LPARAM, cptr(const LV_COLUMN ptr, (pcol)))))
#define LVM_INSERTCOLUMNA (LVM_FIRST + 27)
#define LVM_INSERTCOLUMNW (LVM_FIRST + 97)

#ifdef UNICODE
	#define LVM_INSERTCOLUMN LVM_INSERTCOLUMNW
#else
	#define LVM_INSERTCOLUMN LVM_INSERTCOLUMNA
#endif

#define ListView_InsertColumn(hwnd, iCol, pcol) clng(SNDMSG((hwnd), LVM_INSERTCOLUMN, cast(WPARAM, clng((iCol))), cast(LPARAM, cptr(const LV_COLUMN ptr, (pcol)))))
#define LVM_DELETECOLUMN (LVM_FIRST + 28)
#define ListView_DeleteColumn(hwnd, iCol) cast(WINBOOL, SNDMSG((hwnd), LVM_DELETECOLUMN, cast(WPARAM, clng((iCol))), 0))
#define LVM_GETCOLUMNWIDTH (LVM_FIRST + 29)
#define ListView_GetColumnWidth(hwnd, iCol) clng(SNDMSG((hwnd), LVM_GETCOLUMNWIDTH, cast(WPARAM, clng((iCol))), 0))
#define LVSCW_AUTOSIZE (-1)
#define LVSCW_AUTOSIZE_USEHEADER (-2)
#define LVM_SETCOLUMNWIDTH (LVM_FIRST + 30)
#define ListView_SetColumnWidth(hwnd, iCol, cx) cast(WINBOOL, SNDMSG((hwnd), LVM_SETCOLUMNWIDTH, cast(WPARAM, clng((iCol))), MAKELPARAM((cx), 0)))
#define LVM_GETHEADER (LVM_FIRST + 31)
#define ListView_GetHeader(hwnd) cast(HWND, SNDMSG((hwnd), LVM_GETHEADER, cast(WPARAM, 0), cast(LPARAM, 0)))
#define LVM_CREATEDRAGIMAGE (LVM_FIRST + 33)
#define ListView_CreateDragImage(hwnd, i, lpptUpLeft) cast(HIMAGELIST, SNDMSG((hwnd), LVM_CREATEDRAGIMAGE, cast(WPARAM, clng((i))), cast(LPARAM, cast(LPPOINT, (lpptUpLeft)))))
#define LVM_GETVIEWRECT (LVM_FIRST + 34)
#define ListView_GetViewRect(hwnd, prc) cast(WINBOOL, SNDMSG((hwnd), LVM_GETVIEWRECT, 0, cast(LPARAM, cptr(RECT ptr, (prc)))))
#define LVM_GETTEXTCOLOR (LVM_FIRST + 35)
#define ListView_GetTextColor(hwnd) cast(COLORREF, SNDMSG((hwnd), LVM_GETTEXTCOLOR, cast(WPARAM, 0), cast(LPARAM, 0)))
#define LVM_SETTEXTCOLOR (LVM_FIRST + 36)
#define ListView_SetTextColor(hwnd, clrText) cast(WINBOOL, SNDMSG((hwnd), LVM_SETTEXTCOLOR, 0, cast(LPARAM, cast(COLORREF, (clrText)))))
#define LVM_GETTEXTBKCOLOR (LVM_FIRST + 37)
#define ListView_GetTextBkColor(hwnd) cast(COLORREF, SNDMSG((hwnd), LVM_GETTEXTBKCOLOR, cast(WPARAM, 0), cast(LPARAM, 0)))
#define LVM_SETTEXTBKCOLOR (LVM_FIRST + 38)
#define ListView_SetTextBkColor(hwnd, clrTextBk) cast(WINBOOL, SNDMSG((hwnd), LVM_SETTEXTBKCOLOR, 0, cast(LPARAM, cast(COLORREF, (clrTextBk)))))
#define LVM_GETTOPINDEX (LVM_FIRST + 39)
#define ListView_GetTopIndex(hwndLV) clng(SNDMSG((hwndLV), LVM_GETTOPINDEX, 0, 0))
#define LVM_GETCOUNTPERPAGE (LVM_FIRST + 40)
#define ListView_GetCountPerPage(hwndLV) clng(SNDMSG((hwndLV), LVM_GETCOUNTPERPAGE, 0, 0))
#define LVM_GETORIGIN (LVM_FIRST + 41)
#define ListView_GetOrigin(hwndLV, ppt) cast(WINBOOL, SNDMSG((hwndLV), LVM_GETORIGIN, cast(WPARAM, 0), cast(LPARAM, cptr(POINT ptr, (ppt)))))
#define LVM_UPDATE (LVM_FIRST + 42)
#define ListView_Update(hwndLV, i) cast(WINBOOL, SNDMSG((hwndLV), LVM_UPDATE, cast(WPARAM, (i)), cast(LPARAM, 0)))
#define LVM_SETITEMSTATE (LVM_FIRST + 43)
#macro ListView_SetItemState(hwndLV, i, data, mask)
	scope
		dim _ms_lvi as LV_ITEM
		_ms_lvi.stateMask = mask
		_ms_lvi.state = data
		SNDMSG((hwndLV), LVM_SETITEMSTATE, cast(WPARAM, (i)), cast(LPARAM, cptr(LV_ITEM ptr, @_ms_lvi)))
	end scope
#endmacro
#define ListView_SetCheckState(hwndLV, i, fCheck) ListView_SetItemState(hwndLV, i, INDEXTOSTATEIMAGEMASK(iif((fCheck), 2, 1)), LVIS_STATEIMAGEMASK)
#define LVM_GETITEMSTATE (LVM_FIRST + 44)
#define ListView_GetItemState(hwndLV, i, mask) cast(UINT, SNDMSG((hwndLV), LVM_GETITEMSTATE, cast(WPARAM, (i)), cast(LPARAM, (mask))))
#define ListView_GetCheckState(hwndLV, i) ((cast(UINT, SNDMSG((hwndLV), LVM_GETITEMSTATE, cast(WPARAM, (i)), LVIS_STATEIMAGEMASK)) shr 12) - 1)
#define LVM_GETITEMTEXTA (LVM_FIRST + 45)
#define LVM_GETITEMTEXTW (LVM_FIRST + 115)

#ifdef UNICODE
	#define LVM_GETITEMTEXT LVM_GETITEMTEXTW
#else
	#define LVM_GETITEMTEXT LVM_GETITEMTEXTA
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
#define LVM_SETITEMTEXTA (LVM_FIRST + 46)
#define LVM_SETITEMTEXTW (LVM_FIRST + 116)

#ifdef UNICODE
	#define LVM_SETITEMTEXT LVM_SETITEMTEXTW
#else
	#define LVM_SETITEMTEXT LVM_SETITEMTEXTA
#endif

#macro ListView_SetItemText(hwndLV, i, iSubItem_, pszText_)
	scope
		dim _ms_lvi as LV_ITEM
		_ms_lvi.iSubItem = iSubItem_
		_ms_lvi.pszText = pszText_
		SNDMSG((hwndLV), LVM_SETITEMTEXT, cast(WPARAM, (i)), cast(LPARAM, cptr(LV_ITEM ptr, @_ms_lvi)))
	end scope
#endmacro
#define LVSICF_NOINVALIDATEALL &h1
#define LVSICF_NOSCROLL &h2
#define LVM_SETITEMCOUNT (LVM_FIRST + 47)
#define ListView_SetItemCount(hwndLV, cItems) SNDMSG((hwndLV), LVM_SETITEMCOUNT, cast(WPARAM, (cItems)), 0)
#define ListView_SetItemCountEx(hwndLV, cItems, dwFlags) SNDMSG((hwndLV), LVM_SETITEMCOUNT, cast(WPARAM, (cItems)), cast(LPARAM, (dwFlags)))
type PFNLVCOMPARE as function(byval as LPARAM, byval as LPARAM, byval as LPARAM) as long
#define LVM_SORTITEMS (LVM_FIRST + 48)
#define ListView_SortItems(hwndLV, _pfnCompare, _lPrm) cast(WINBOOL, SNDMSG((hwndLV), LVM_SORTITEMS, cast(WPARAM, cast(LPARAM, (_lPrm))), cast(LPARAM, cast(PFNLVCOMPARE, (_pfnCompare)))))
#define LVM_SETITEMPOSITION32 (LVM_FIRST + 49)
#macro ListView_SetItemPosition32(hwndLV, i, x0, y0)
	scope
		dim ptNewPos as POINT
		ptNewPos.x = x0
		ptNewPos.y = y0
		SNDMSG((hwndLV), LVM_SETITEMPOSITION32, cast(WPARAM, clng((i))), cast(LPARAM, @ptNewPos))
	end scope
#endmacro
#define LVM_GETSELECTEDCOUNT (LVM_FIRST + 50)
#define ListView_GetSelectedCount(hwndLV) cast(UINT, SNDMSG((hwndLV), LVM_GETSELECTEDCOUNT, cast(WPARAM, 0), cast(LPARAM, 0)))
#define LVM_GETITEMSPACING (LVM_FIRST + 51)
#define ListView_GetItemSpacing(hwndLV, fSmall) cast(DWORD, SNDMSG((hwndLV), LVM_GETITEMSPACING, fSmall, cast(LPARAM, 0)))
#define LVM_GETISEARCHSTRINGA (LVM_FIRST + 52)
#define LVM_GETISEARCHSTRINGW (LVM_FIRST + 117)

#ifdef UNICODE
	#define LVM_GETISEARCHSTRING LVM_GETISEARCHSTRINGW
#else
	#define LVM_GETISEARCHSTRING LVM_GETISEARCHSTRINGA
#endif

#define ListView_GetISearchString(hwndLV, lpsz) cast(WINBOOL, SNDMSG((hwndLV), LVM_GETISEARCHSTRING, 0, cast(LPARAM, cast(LPTSTR, (lpsz)))))
#define LVM_SETICONSPACING (LVM_FIRST + 53)
#define ListView_SetIconSpacing(hwndLV, cx, cy) cast(DWORD, SNDMSG((hwndLV), LVM_SETICONSPACING, 0, MAKELONG(cx, cy)))
#define LVM_SETEXTENDEDLISTVIEWSTYLE (LVM_FIRST + 54)
#define ListView_SetExtendedListViewStyle(hwndLV, dw) cast(DWORD, SNDMSG((hwndLV), LVM_SETEXTENDEDLISTVIEWSTYLE, 0, dw))
#define ListView_SetExtendedListViewStyleEx(hwndLV, dwMask, dw) cast(DWORD, SNDMSG((hwndLV), LVM_SETEXTENDEDLISTVIEWSTYLE, dwMask, dw))
#define LVM_GETEXTENDEDLISTVIEWSTYLE (LVM_FIRST + 55)
#define ListView_GetExtendedListViewStyle(hwndLV) cast(DWORD, SNDMSG((hwndLV), LVM_GETEXTENDEDLISTVIEWSTYLE, 0, 0))
#define LVS_EX_GRIDLINES &h1
#define LVS_EX_SUBITEMIMAGES &h2
#define LVS_EX_CHECKBOXES &h4
#define LVS_EX_TRACKSELECT &h8
#define LVS_EX_HEADERDRAGDROP &h10
#define LVS_EX_FULLROWSELECT &h20
#define LVS_EX_ONECLICKACTIVATE &h40
#define LVS_EX_TWOCLICKACTIVATE &h80
#define LVS_EX_FLATSB &h100
#define LVS_EX_REGIONAL &h200
#define LVS_EX_INFOTIP &h400
#define LVS_EX_UNDERLINEHOT &h800
#define LVS_EX_UNDERLINECOLD &h1000
#define LVS_EX_MULTIWORKAREAS &h2000
#define LVS_EX_LABELTIP &h4000
#define LVS_EX_BORDERSELECT &h8000
#define LVS_EX_DOUBLEBUFFER &h10000
#define LVS_EX_HIDELABELS &h20000
#define LVS_EX_SINGLEROW &h40000
#define LVS_EX_SNAPTOGRID &h80000
#define LVS_EX_SIMPLESELECT &h100000

#if _WIN32_WINNT = &h0602
	#define LVS_EX_JUSTIFYCOLUMNS &h200000
	#define LVS_EX_TRANSPARENTBKGND &h400000
	#define LVS_EX_TRANSPARENTSHADOWTEXT &h800000
	#define LVS_EX_AUTOAUTOARRANGE &h1000000
	#define LVS_EX_HEADERINALLVIEWS &h2000000
	#define LVS_EX_AUTOCHECKSELECT &h8000000
	#define LVS_EX_AUTOSIZECOLUMNS &h10000000
	#define LVS_EX_COLUMNSNAPPOINTS &h40000000
	#define LVS_EX_COLUMNOVERFLOW &h80000000
#endif

#define LVM_GETSUBITEMRECT (LVM_FIRST + 56)
private function ListView_GetSubItemRect(byval hwnd as HWND, byval iItem as long, byval iSubItem as long, byval code as long, byval prc as RECT ptr) as WINBOOL
	if prc then
		prc->top = iSubItem
		prc->left = code
	end if
	function = SNDMSG(hwnd, LVM_GETSUBITEMRECT, cast(WPARAM, iItem), cast(LPARAM, prc))
end function
#define LVM_SUBITEMHITTEST (LVM_FIRST + 57)
#define ListView_SubItemHitTest(hwnd, plvhti) clng(SNDMSG((hwnd), LVM_SUBITEMHITTEST, 0, cast(LPARAM, cast(LPLVHITTESTINFO, (plvhti)))))
#define LVM_SETCOLUMNORDERARRAY (LVM_FIRST + 58)
#define ListView_SetColumnOrderArray(hwnd, iCount, pi) cast(WINBOOL, SNDMSG((hwnd), LVM_SETCOLUMNORDERARRAY, cast(WPARAM, (iCount)), cast(LPARAM, cast(LPINT, (pi)))))
#define LVM_GETCOLUMNORDERARRAY (LVM_FIRST + 59)
#define ListView_GetColumnOrderArray(hwnd, iCount, pi) cast(WINBOOL, SNDMSG((hwnd), LVM_GETCOLUMNORDERARRAY, cast(WPARAM, (iCount)), cast(LPARAM, cast(LPINT, (pi)))))
#define LVM_SETHOTITEM (LVM_FIRST + 60)
#define ListView_SetHotItem(hwnd, i) clng(SNDMSG((hwnd), LVM_SETHOTITEM, cast(WPARAM, (i)), 0))
#define LVM_GETHOTITEM (LVM_FIRST + 61)
#define ListView_GetHotItem(hwnd) clng(SNDMSG((hwnd), LVM_GETHOTITEM, 0, 0))
#define LVM_SETHOTCURSOR (LVM_FIRST + 62)
#define ListView_SetHotCursor(hwnd, hcur) cast(HCURSOR, SNDMSG((hwnd), LVM_SETHOTCURSOR, 0, cast(LPARAM, (hcur))))
#define LVM_GETHOTCURSOR (LVM_FIRST + 63)
#define ListView_GetHotCursor(hwnd) cast(HCURSOR, SNDMSG((hwnd), LVM_GETHOTCURSOR, 0, 0))
#define LVM_APPROXIMATEVIEWRECT (LVM_FIRST + 64)
#define ListView_ApproximateViewRect(hwnd, iWidth, iHeight, iCount) cast(DWORD, SNDMSG((hwnd), LVM_APPROXIMATEVIEWRECT, iCount, MAKELPARAM(iWidth, iHeight)))
#define LV_MAX_WORKAREAS 16
#define LVM_SETWORKAREAS (LVM_FIRST + 65)
#define ListView_SetWorkAreas(hwnd, nWorkAreas, prc) cast(WINBOOL, SNDMSG((hwnd), LVM_SETWORKAREAS, cast(WPARAM, clng((nWorkAreas))), cast(LPARAM, cptr(RECT ptr, (prc)))))
#define LVM_GETWORKAREAS (LVM_FIRST + 70)
#define ListView_GetWorkAreas(hwnd, nWorkAreas, prc) cast(WINBOOL, SNDMSG((hwnd), LVM_GETWORKAREAS, cast(WPARAM, clng((nWorkAreas))), cast(LPARAM, cptr(RECT ptr, (prc)))))
#define LVM_GETNUMBEROFWORKAREAS (LVM_FIRST + 73)
#define ListView_GetNumberOfWorkAreas(hwnd, pnWorkAreas) cast(WINBOOL, SNDMSG((hwnd), LVM_GETNUMBEROFWORKAREAS, 0, cast(LPARAM, cptr(UINT ptr, (pnWorkAreas)))))
#define LVM_GETSELECTIONMARK (LVM_FIRST + 66)
#define ListView_GetSelectionMark(hwnd) clng(SNDMSG((hwnd), LVM_GETSELECTIONMARK, 0, 0))
#define LVM_SETSELECTIONMARK (LVM_FIRST + 67)
#define ListView_SetSelectionMark(hwnd, i) clng(SNDMSG((hwnd), LVM_SETSELECTIONMARK, 0, cast(LPARAM, (i))))
#define LVM_SETHOVERTIME (LVM_FIRST + 71)
#define ListView_SetHoverTime(hwndLV, dwHoverTimeMs) cast(DWORD, SNDMSG((hwndLV), LVM_SETHOVERTIME, 0, cast(LPARAM, (dwHoverTimeMs))))
#define LVM_GETHOVERTIME (LVM_FIRST + 72)
#define ListView_GetHoverTime(hwndLV) cast(DWORD, SNDMSG((hwndLV), LVM_GETHOVERTIME, 0, 0))
#define LVM_SETTOOLTIPS (LVM_FIRST + 74)
#define ListView_SetToolTips(hwndLV, hwndNewHwnd) cast(HWND, SNDMSG((hwndLV), LVM_SETTOOLTIPS, cast(WPARAM, (hwndNewHwnd)), 0))
#define LVM_GETTOOLTIPS (LVM_FIRST + 78)
#define ListView_GetToolTips(hwndLV) cast(HWND, SNDMSG((hwndLV), LVM_GETTOOLTIPS, 0, 0))
#define LVM_SORTITEMSEX (LVM_FIRST + 81)
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
#define LVBKIF_SOURCE_NONE &h0
#define LVBKIF_SOURCE_HBITMAP &h1
#define LVBKIF_SOURCE_URL &h2
#define LVBKIF_SOURCE_MASK &h3
#define LVBKIF_STYLE_NORMAL &h0
#define LVBKIF_STYLE_TILE &h10
#define LVBKIF_STYLE_MASK &h10
#define LVBKIF_FLAG_TILEOFFSET &h100
#define LVBKIF_TYPE_WATERMARK &h10000000
#define LVM_SETBKIMAGEA (LVM_FIRST + 68)
#define LVM_SETBKIMAGEW (LVM_FIRST + 138)
#define LVM_GETBKIMAGEA (LVM_FIRST + 69)
#define LVM_GETBKIMAGEW (LVM_FIRST + 139)
#define LVM_SETSELECTEDCOLUMN (LVM_FIRST + 140)
#define ListView_SetSelectedColumn(hwnd, iCol) SNDMSG((hwnd), LVM_SETSELECTEDCOLUMN, cast(WPARAM, iCol), 0)
#define LVM_SETTILEWIDTH (LVM_FIRST + 141)
#define ListView_SetTileWidth(hwnd, cpWidth) SNDMSG((hwnd), LVM_SETTILEWIDTH, cast(WPARAM, cpWidth), 0)
#define LV_VIEW_ICON &h0
#define LV_VIEW_DETAILS &h1
#define LV_VIEW_SMALLICON &h2
#define LV_VIEW_LIST &h3
#define LV_VIEW_TILE &h4
#define LV_VIEW_MAX &h4
#define LVM_SETVIEW (LVM_FIRST + 142)
#define ListView_SetView(hwnd, iView) cast(DWORD, SNDMSG((hwnd), LVM_SETVIEW, cast(WPARAM, cast(DWORD, iView)), 0))
#define LVM_GETVIEW (LVM_FIRST + 143)
#define ListView_GetView(hwnd) cast(DWORD, SNDMSG((hwnd), LVM_GETVIEW, 0, 0))
#define LVGF_NONE &h0
#define LVGF_HEADER &h1
#define LVGF_FOOTER &h2
#define LVGF_STATE &h4
#define LVGF_ALIGN &h8
#define LVGF_GROUPID &h10
#define LVGS_NORMAL &h0
#define LVGS_COLLAPSED &h1
#define LVGS_HIDDEN &h2
#define LVGA_HEADER_LEFT &h1
#define LVGA_HEADER_CENTER &h2
#define LVGA_HEADER_RIGHT &h4
#define LVGA_FOOTER_LEFT &h8
#define LVGA_FOOTER_CENTER &h10
#define LVGA_FOOTER_RIGHT &h20

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
end type

type LVGROUP as tagLVGROUP
type PLVGROUP as tagLVGROUP ptr
#define LVM_INSERTGROUP (LVM_FIRST + 145)
#define ListView_InsertGroup(hwnd, index, pgrp) SNDMSG((hwnd), LVM_INSERTGROUP, cast(WPARAM, index), cast(LPARAM, pgrp))
#define LVM_SETGROUPINFO (LVM_FIRST + 147)
#define ListView_SetGroupInfo(hwnd, iGroupId, pgrp) SNDMSG((hwnd), LVM_SETGROUPINFO, cast(WPARAM, iGroupId), cast(LPARAM, pgrp))
#define LVM_GETGROUPINFO (LVM_FIRST + 149)
#define ListView_GetGroupInfo(hwnd, iGroupId, pgrp) SNDMSG((hwnd), LVM_GETGROUPINFO, cast(WPARAM, iGroupId), cast(LPARAM, pgrp))
#define LVM_REMOVEGROUP (LVM_FIRST + 150)
#define ListView_RemoveGroup(hwnd, iGroupId) SNDMSG((hwnd), LVM_REMOVEGROUP, cast(WPARAM, iGroupId), 0)
#define LVM_MOVEGROUP (LVM_FIRST + 151)
#define ListView_MoveGroup(hwnd, iGroupId, toIndex) SNDMSG((hwnd), LVM_MOVEGROUP, cast(WPARAM, iGroupId), cast(LPARAM, toIndex))
#define LVM_MOVEITEMTOGROUP (LVM_FIRST + 154)
#define ListView_MoveItemToGroup(hwnd, idItemFrom, idGroupTo) SNDMSG((hwnd), LVM_MOVEITEMTOGROUP, cast(WPARAM, idItemFrom), cast(LPARAM, idGroupTo))
#define LVGMF_NONE &h0
#define LVGMF_BORDERSIZE &h1
#define LVGMF_BORDERCOLOR &h2
#define LVGMF_TEXTCOLOR &h4

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
#define LVM_SETGROUPMETRICS (LVM_FIRST + 155)
#define ListView_SetGroupMetrics(hwnd, pGroupMetrics) SNDMSG((hwnd), LVM_SETGROUPMETRICS, 0, cast(LPARAM, pGroupMetrics))
#define LVM_GETGROUPMETRICS (LVM_FIRST + 156)
#define ListView_GetGroupMetrics(hwnd, pGroupMetrics) SNDMSG((hwnd), LVM_GETGROUPMETRICS, 0, cast(LPARAM, pGroupMetrics))
#define LVM_ENABLEGROUPVIEW (LVM_FIRST + 157)
#define ListView_EnableGroupView(hwnd, fEnable) SNDMSG((hwnd), LVM_ENABLEGROUPVIEW, cast(WPARAM, fEnable), 0)
type PFNLVGROUPCOMPARE as function(byval as long, byval as long, byval as any ptr) as long
#define LVM_SORTGROUPS (LVM_FIRST + 158)
#define ListView_SortGroups(hwnd, _pfnGroupCompate, _plv) SNDMSG((hwnd), LVM_SORTGROUPS, cast(WPARAM, _pfnGroupCompate), cast(LPARAM, _plv))

type tagLVINSERTGROUPSORTED
	pfnGroupCompare as PFNLVGROUPCOMPARE
	pvData as any ptr
	lvGroup as LVGROUP
end type

type LVINSERTGROUPSORTED as tagLVINSERTGROUPSORTED
type PLVINSERTGROUPSORTED as tagLVINSERTGROUPSORTED ptr
#define LVM_INSERTGROUPSORTED (LVM_FIRST + 159)
#define ListView_InsertGroupSorted(hwnd, structInsert) SNDMSG((hwnd), LVM_INSERTGROUPSORTED, cast(WPARAM, structInsert), 0)
#define LVM_REMOVEALLGROUPS (LVM_FIRST + 160)
#define ListView_RemoveAllGroups(hwnd) SNDMSG((hwnd), LVM_REMOVEALLGROUPS, 0, 0)
#define LVM_HASGROUP (LVM_FIRST + 161)
#define ListView_HasGroup(hwnd, dwGroupId) SNDMSG((hwnd), LVM_HASGROUP, dwGroupId, 0)
#define LVTVIF_AUTOSIZE &h0
#define LVTVIF_FIXEDWIDTH &h1
#define LVTVIF_FIXEDHEIGHT &h2
#define LVTVIF_FIXEDSIZE &h3
#define LVTVIM_TILESIZE &h1
#define LVTVIM_COLUMNS &h2
#define LVTVIM_LABELMARGIN &h4

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
end type

type LVTILEINFO as tagLVTILEINFO
type PLVTILEINFO as tagLVTILEINFO ptr
#define LVM_SETTILEVIEWINFO (LVM_FIRST + 162)
#define ListView_SetTileViewInfo(hwnd, ptvi) SNDMSG((hwnd), LVM_SETTILEVIEWINFO, 0, cast(LPARAM, ptvi))
#define LVM_GETTILEVIEWINFO (LVM_FIRST + 163)
#define ListView_GetTileViewInfo(hwnd, ptvi) SNDMSG((hwnd), LVM_GETTILEVIEWINFO, 0, cast(LPARAM, ptvi))
#define LVM_SETTILEINFO (LVM_FIRST + 164)
#define ListView_SetTileInfo(hwnd, pti) SNDMSG((hwnd), LVM_SETTILEINFO, 0, cast(LPARAM, pti))
#define LVM_GETTILEINFO (LVM_FIRST + 165)
#define ListView_GetTileInfo(hwnd, pti) SNDMSG((hwnd), LVM_GETTILEINFO, 0, cast(LPARAM, pti))

type LVINSERTMARK
	cbSize as UINT
	dwFlags as DWORD
	iItem as long
	dwReserved as DWORD
end type

type LPLVINSERTMARK as LVINSERTMARK ptr
#define LVIM_AFTER &h1
#define LVM_SETINSERTMARK (LVM_FIRST + 166)
#define ListView_SetInsertMark(hwnd, lvim) cast(WINBOOL, SNDMSG((hwnd), LVM_SETINSERTMARK, cast(WPARAM, 0), cast(LPARAM, (lvim))))
#define LVM_GETINSERTMARK (LVM_FIRST + 167)
#define ListView_GetInsertMark(hwnd, lvim) cast(WINBOOL, SNDMSG((hwnd), LVM_GETINSERTMARK, cast(WPARAM, 0), cast(LPARAM, (lvim))))
#define LVM_INSERTMARKHITTEST (LVM_FIRST + 168)
#define ListView_InsertMarkHitTest(hwnd, point, lvim) clng(SNDMSG((hwnd), LVM_INSERTMARKHITTEST, cast(WPARAM, cast(LPPOINT, (point))), cast(LPARAM, cast(LPLVINSERTMARK, (lvim)))))
#define LVM_GETINSERTMARKRECT (LVM_FIRST + 169)
#define ListView_GetInsertMarkRect(hwnd, rc) clng(SNDMSG((hwnd), LVM_GETINSERTMARKRECT, cast(WPARAM, 0), cast(LPARAM, cast(LPRECT, (rc)))))
#define LVM_SETINSERTMARKCOLOR (LVM_FIRST + 170)
#define ListView_SetInsertMarkColor(hwnd, color) cast(COLORREF, SNDMSG((hwnd), LVM_SETINSERTMARKCOLOR, cast(WPARAM, 0), cast(LPARAM, cast(COLORREF, (color)))))
#define LVM_GETINSERTMARKCOLOR (LVM_FIRST + 171)
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
#define LVM_SETINFOTIP (LVM_FIRST + 173)
#define ListView_SetInfoTip(hwndLV, plvInfoTip) cast(WINBOOL, SNDMSG((hwndLV), LVM_SETINFOTIP, cast(WPARAM, 0), cast(LPARAM, plvInfoTip)))
#define LVM_GETSELECTEDCOLUMN (LVM_FIRST + 174)
#define ListView_GetSelectedColumn(hwnd) cast(UINT, SNDMSG((hwnd), LVM_GETSELECTEDCOLUMN, 0, 0))
#define LVM_ISGROUPVIEWENABLED (LVM_FIRST + 175)
#define ListView_IsGroupViewEnabled(hwnd) cast(WINBOOL, SNDMSG((hwnd), LVM_ISGROUPVIEWENABLED, 0, 0))
#define LVM_GETOUTLINECOLOR (LVM_FIRST + 176)
#define ListView_GetOutlineColor(hwnd) cast(COLORREF, SNDMSG((hwnd), LVM_GETOUTLINECOLOR, 0, 0))
#define LVM_SETOUTLINECOLOR (LVM_FIRST + 177)
#define ListView_SetOutlineColor(hwnd, color) cast(COLORREF, SNDMSG((hwnd), LVM_SETOUTLINECOLOR, cast(WPARAM, 0), cast(LPARAM, cast(COLORREF, (color)))))
#define LVM_CANCELEDITLABEL (LVM_FIRST + 179)
#define ListView_CancelEditLabel(hwnd) SNDMSG((hwnd), LVM_CANCELEDITLABEL, 0, 0)
#define LVM_MAPINDEXTOID (LVM_FIRST + 180)
#define ListView_MapIndexToID(hwnd, index) cast(UINT, SNDMSG((hwnd), LVM_MAPINDEXTOID, cast(WPARAM, index), cast(LPARAM, 0)))
#define LVM_MAPIDTOINDEX (LVM_FIRST + 181)
#define ListView_MapIDToIndex(hwnd, id) cast(UINT, SNDMSG((hwnd), LVM_MAPIDTOINDEX, cast(WPARAM, id), cast(LPARAM, 0)))
#define LVM_ISITEMVISIBLE (LVM_FIRST + 182)
#define ListView_IsItemVisible(hwnd, index) cast(UINT, SNDMSG((hwnd), LVM_ISITEMVISIBLE, cast(WPARAM, (index)), cast(LPARAM, 0)))

#ifdef UNICODE
	#define LVBKIMAGE LVBKIMAGEW
	#define LPLVBKIMAGE LPLVBKIMAGEW
	#define LVM_SETBKIMAGE LVM_SETBKIMAGEW
	#define LVM_GETBKIMAGE LVM_GETBKIMAGEW
#else
	#define LVBKIMAGE LVBKIMAGEA
	#define LPLVBKIMAGE LPLVBKIMAGEA
	#define LVM_SETBKIMAGE LVM_SETBKIMAGEA
	#define LVM_GETBKIMAGE LVM_GETBKIMAGEA
#endif

#define ListView_SetBkImage(hwnd, plvbki) cast(WINBOOL, SNDMSG((hwnd), LVM_SETBKIMAGE, 0, cast(LPARAM, (plvbki))))
#define ListView_GetBkImage(hwnd, plvbki) cast(WINBOOL, SNDMSG((hwnd), LVM_GETBKIMAGE, 0, cast(LPARAM, (plvbki))))
#define LPNM_LISTVIEW LPNMLISTVIEW
#define NM_LISTVIEW NMLISTVIEW

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
#define LVKF_ALT &h1
#define LVKF_CONTROL &h2
#define LVKF_SHIFT &h4
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
#define LVCDI_ITEM &h0
#define LVCDI_GROUP &h1
#define LVCDRF_NOSELECT &h10000
#define LVCDRF_NOGROUPFRAME &h20000

type tagNMLVCACHEHINT
	hdr as NMHDR
	iFrom as long
	iTo as long
end type

type NMLVCACHEHINT as tagNMLVCACHEHINT
type LPNMLVCACHEHINT as tagNMLVCACHEHINT ptr
#define LPNM_CACHEHINT LPNMLVCACHEHINT
#define PNM_CACHEHINT LPNMLVCACHEHINT
#define NM_CACHEHINT NMLVCACHEHINT

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
#define PNM_FINDITEMA LPNMLVFINDITEMA
#define LPNM_FINDITEMA LPNMLVFINDITEMA
#define NM_FINDITEMA NMLVFINDITEMA
#define PNM_FINDITEMW LPNMLVFINDITEMW
#define LPNM_FINDITEMW LPNMLVFINDITEMW
#define NM_FINDITEMW NMLVFINDITEMW

#ifdef UNICODE
	#define PNM_FINDITEM PNM_FINDITEMW
	#define LPNM_FINDITEM LPNM_FINDITEMW
	#define NM_FINDITEM NM_FINDITEMW
	#define NMLVFINDITEM NMLVFINDITEMW
	#define LPNMLVFINDITEM LPNMLVFINDITEMW
#else
	#define PNM_FINDITEM PNM_FINDITEMA
	#define LPNM_FINDITEM LPNM_FINDITEMA
	#define NM_FINDITEM NM_FINDITEMA
	#define NMLVFINDITEM NMLVFINDITEMA
	#define LPNMLVFINDITEM LPNMLVFINDITEMA
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
#define PNM_ODSTATECHANGE LPNMLVODSTATECHANGE
#define LPNM_ODSTATECHANGE LPNMLVODSTATECHANGE
#define NM_ODSTATECHANGE NMLVODSTATECHANGE
#define LVN_ITEMCHANGING culng(LVN_FIRST - 0)
#define LVN_ITEMCHANGED culng(LVN_FIRST - 1)
#define LVN_INSERTITEM culng(LVN_FIRST - 2)
#define LVN_DELETEITEM culng(LVN_FIRST - 3)
#define LVN_DELETEALLITEMS culng(LVN_FIRST - 4)
#define LVN_BEGINLABELEDITA culng(LVN_FIRST - 5)
#define LVN_BEGINLABELEDITW culng(LVN_FIRST - 75)
#define LVN_ENDLABELEDITA culng(LVN_FIRST - 6)
#define LVN_ENDLABELEDITW culng(LVN_FIRST - 76)
#define LVN_COLUMNCLICK culng(LVN_FIRST - 8)
#define LVN_BEGINDRAG culng(LVN_FIRST - 9)
#define LVN_BEGINRDRAG culng(LVN_FIRST - 11)
#define LVN_ODCACHEHINT culng(LVN_FIRST - 13)
#define LVN_ODFINDITEMA culng(LVN_FIRST - 52)
#define LVN_ODFINDITEMW culng(LVN_FIRST - 79)
#define LVN_ITEMACTIVATE culng(LVN_FIRST - 14)
#define LVN_ODSTATECHANGED culng(LVN_FIRST - 15)

#ifdef UNICODE
	#define LVN_ODFINDITEM LVN_ODFINDITEMW
#else
	#define LVN_ODFINDITEM LVN_ODFINDITEMA
#endif

#define LVN_HOTTRACK culng(LVN_FIRST - 21)
#define LVN_GETDISPINFOA culng(LVN_FIRST - 50)
#define LVN_GETDISPINFOW culng(LVN_FIRST - 77)
#define LVN_SETDISPINFOA culng(LVN_FIRST - 51)
#define LVN_SETDISPINFOW culng(LVN_FIRST - 78)

#ifdef UNICODE
	#define LVN_BEGINLABELEDIT LVN_BEGINLABELEDITW
	#define LVN_ENDLABELEDIT LVN_ENDLABELEDITW
	#define LVN_GETDISPINFO LVN_GETDISPINFOW
	#define LVN_SETDISPINFO LVN_SETDISPINFOW
#else
	#define LVN_BEGINLABELEDIT LVN_BEGINLABELEDITA
	#define LVN_ENDLABELEDIT LVN_ENDLABELEDITA
	#define LVN_GETDISPINFO LVN_GETDISPINFOA
	#define LVN_SETDISPINFO LVN_SETDISPINFOA
#endif

#define LVIF_DI_SETITEM &h1000
#define LV_DISPINFOA NMLVDISPINFOA
#define LV_DISPINFOW NMLVDISPINFOW
#define LV_DISPINFO NMLVDISPINFO

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
	#define NMLVDISPINFO NMLVDISPINFOW
#else
	#define NMLVDISPINFO NMLVDISPINFOA
#endif

#define LVN_KEYDOWN culng(LVN_FIRST - 55)
#define LV_KEYDOWN NMLVKEYDOWN

type tagLVKEYDOWN field = 1
	hdr as NMHDR
	wVKey as WORD
	flags as UINT
end type

type NMLVKEYDOWN as tagLVKEYDOWN
type LPNMLVKEYDOWN as tagLVKEYDOWN ptr
#define LVN_MARQUEEBEGIN culng(LVN_FIRST - 56)

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
#define LVGIT_UNFOLDED &h1
#define LVN_GETINFOTIPA culng(LVN_FIRST - 57)
#define LVN_GETINFOTIPW culng(LVN_FIRST - 58)

#ifdef UNICODE
	#define LVN_GETINFOTIP LVN_GETINFOTIPW
	#define NMLVGETINFOTIP NMLVGETINFOTIPW
	#define LPNMLVGETINFOTIP LPNMLVGETINFOTIPW
#else
	#define LVN_GETINFOTIP LVN_GETINFOTIPA
	#define NMLVGETINFOTIP NMLVGETINFOTIPA
	#define LPNMLVGETINFOTIP LPNMLVGETINFOTIPA
#endif

type tagNMLVSCROLL
	hdr as NMHDR
	dx as long
	dy as long
end type

type NMLVSCROLL as tagNMLVSCROLL
type LPNMLVSCROLL as tagNMLVSCROLL ptr
#define LVN_BEGINSCROLL culng(LVN_FIRST - 80)
#define LVN_ENDSCROLL culng(LVN_FIRST - 81)
#define WC_TREEVIEWA "SysTreeView32"
#define WC_TREEVIEWW wstr("SysTreeView32")

#ifdef UNICODE
	#define WC_TREEVIEW WC_TREEVIEWW
#else
	#define WC_TREEVIEW WC_TREEVIEWA
#endif

#define TVS_HASBUTTONS &h1
#define TVS_HASLINES &h2
#define TVS_LINESATROOT &h4
#define TVS_EDITLABELS &h8
#define TVS_DISABLEDRAGDROP &h10
#define TVS_SHOWSELALWAYS &h20
#define TVS_RTLREADING &h40
#define TVS_NOTOOLTIPS &h80
#define TVS_CHECKBOXES &h100
#define TVS_TRACKSELECT &h200
#define TVS_SINGLEEXPAND &h400
#define TVS_INFOTIP &h800
#define TVS_FULLROWSELECT &h1000
#define TVS_NOSCROLL &h2000
#define TVS_NONEVENHEIGHT &h4000
#define TVS_NOHSCROLL &h8000
type HTREEITEM as _TREEITEM ptr
#define TVIF_TEXT &h1
#define TVIF_IMAGE &h2
#define TVIF_PARAM &h4
#define TVIF_STATE &h8
#define TVIF_HANDLE &h10
#define TVIF_SELECTEDIMAGE &h20
#define TVIF_CHILDREN &h40
#define TVIF_INTEGRAL &h80
#define TVIS_SELECTED &h2
#define TVIS_CUT &h4
#define TVIS_DROPHILITED &h8
#define TVIS_BOLD &h10
#define TVIS_EXPANDED &h20
#define TVIS_EXPANDEDONCE &h40
#define TVIS_EXPANDPARTIAL &h80
#define TVIS_OVERLAYMASK &hf00
#define TVIS_STATEIMAGEMASK &hF000
#define TVIS_USERMASK &hF000
#define I_CHILDRENCALLBACK (-1)
#define LPTV_ITEMW LPTVITEMW
#define LPTV_ITEMA LPTVITEMA
#define TV_ITEMW TVITEMW
#define TV_ITEMA TVITEMA
#define LPTV_ITEM LPTVITEM
#define TV_ITEM TVITEM

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
end type

type TVITEMEXW as tagTVITEMEXW
type LPTVITEMEXW as tagTVITEMEXW ptr

#ifdef UNICODE
	type TVITEMEX as TVITEMEXW
	type LPTVITEMEX as LPTVITEMEXW
	#define TVITEM TVITEMW
	#define LPTVITEM LPTVITEMW
#else
	type TVITEMEX as TVITEMEXA
	type LPTVITEMEX as LPTVITEMEXA
	#define TVITEM TVITEMA
	#define LPTVITEM LPTVITEMA
#endif

#define TVI_ROOT cast(HTREEITEM, cast(ULONG_PTR, -&h10000))
#define TVI_FIRST cast(HTREEITEM, cast(ULONG_PTR, -&hffff))
#define TVI_LAST cast(HTREEITEM, cast(ULONG_PTR, -&hfffe))
#define TVI_SORT cast(HTREEITEM, cast(ULONG_PTR, -&hfffd))
#define LPTV_INSERTSTRUCTA LPTVINSERTSTRUCTA
#define LPTV_INSERTSTRUCTW LPTVINSERTSTRUCTW
#define TV_INSERTSTRUCTA TVINSERTSTRUCTA
#define TV_INSERTSTRUCTW TVINSERTSTRUCTW
#define TV_INSERTSTRUCT TVINSERTSTRUCT
#define LPTV_INSERTSTRUCT LPTVINSERTSTRUCT
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
	#define TVINSERTSTRUCT TVINSERTSTRUCTW
	#define LPTVINSERTSTRUCT LPTVINSERTSTRUCTW
	#define TVINSERTSTRUCT_V1_SIZE TVINSERTSTRUCTW_V1_SIZE
#else
	#define TVINSERTSTRUCT TVINSERTSTRUCTA
	#define LPTVINSERTSTRUCT LPTVINSERTSTRUCTA
	#define TVINSERTSTRUCT_V1_SIZE TVINSERTSTRUCTA_V1_SIZE
#endif

#define TVM_INSERTITEMA (TV_FIRST + 0)
#define TVM_INSERTITEMW (TV_FIRST + 50)

#ifdef UNICODE
	#define TVM_INSERTITEM TVM_INSERTITEMW
#else
	#define TVM_INSERTITEM TVM_INSERTITEMA
#endif

#define TreeView_InsertItem(hwnd, lpis) cast(HTREEITEM, SNDMSG((hwnd), TVM_INSERTITEM, 0, cast(LPARAM, cast(LPTV_INSERTSTRUCT, lpis))))
#define TVM_DELETEITEM (TV_FIRST + 1)
#define TreeView_DeleteItem(hwnd, hitem) cast(WINBOOL, SNDMSG((hwnd), TVM_DELETEITEM, 0, cast(LPARAM, cast(HTREEITEM, (hitem)))))
#define TreeView_DeleteAllItems(hwnd) cast(WINBOOL, SNDMSG((hwnd), TVM_DELETEITEM, 0, cast(LPARAM, TVI_ROOT)))
#define TVM_EXPAND (TV_FIRST + 2)
#define TreeView_Expand(hwnd, hitem, code) cast(WINBOOL, SNDMSG((hwnd), TVM_EXPAND, cast(WPARAM, (code)), cast(LPARAM, cast(HTREEITEM, (hitem)))))
#define TVE_COLLAPSE &h1
#define TVE_EXPAND &h2
#define TVE_TOGGLE &h3
#define TVE_EXPANDPARTIAL &h4000
#define TVE_COLLAPSERESET &h8000
#define TVM_GETITEMRECT (TV_FIRST + 4)
private function TreeView_GetItemRect(byval hwnd as HWND, byval hitem as HTREEITEM, byval prc as RECT ptr, byval code as long) as WINBOOL
	*cptr(HTREEITEM ptr, prc) = hitem
	function = SNDMSG(hwnd, TVM_GETITEMRECT, cast(WPARAM, code), cast(LPARAM, prc))
end function
#define TVM_GETCOUNT (TV_FIRST + 5)
#define TreeView_GetCount(hwnd) cast(UINT, SNDMSG((hwnd), TVM_GETCOUNT, 0, 0))
#define TVM_GETINDENT (TV_FIRST + 6)
#define TreeView_GetIndent(hwnd) cast(UINT, SNDMSG((hwnd), TVM_GETINDENT, 0, 0))
#define TVM_SETINDENT (TV_FIRST + 7)
#define TreeView_SetIndent(hwnd, indent) cast(WINBOOL, SNDMSG((hwnd), TVM_SETINDENT, cast(WPARAM, (indent)), 0))
#define TVM_GETIMAGELIST (TV_FIRST + 8)
#define TreeView_GetImageList(hwnd, iImage) cast(HIMAGELIST, SNDMSG((hwnd), TVM_GETIMAGELIST, iImage, 0))
#define TVSIL_NORMAL 0
#define TVSIL_STATE 2
#define TVM_SETIMAGELIST (TV_FIRST + 9)
#define TreeView_SetImageList(hwnd, himl, iImage) cast(HIMAGELIST, SNDMSG((hwnd), TVM_SETIMAGELIST, iImage, cast(LPARAM, cast(HIMAGELIST, (himl)))))
#define TVM_GETNEXTITEM (TV_FIRST + 10)
#define TreeView_GetNextItem(hwnd, hitem, code) cast(HTREEITEM, SNDMSG((hwnd), TVM_GETNEXTITEM, cast(WPARAM, (code)), cast(LPARAM, cast(HTREEITEM, (hitem)))))
#define TVGN_ROOT &h0
#define TVGN_NEXT &h1
#define TVGN_PREVIOUS &h2
#define TVGN_PARENT &h3
#define TVGN_CHILD &h4
#define TVGN_FIRSTVISIBLE &h5
#define TVGN_NEXTVISIBLE &h6
#define TVGN_PREVIOUSVISIBLE &h7
#define TVGN_DROPHILITE &h8
#define TVGN_CARET &h9
#define TVGN_LASTVISIBLE &ha
#define TVSI_NOSINGLEEXPAND &h8000
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
#define TVM_SELECTITEM (TV_FIRST + 11)
#define TreeView_Select(hwnd, hitem, code) cast(WINBOOL, SNDMSG((hwnd), TVM_SELECTITEM, cast(WPARAM, (code)), cast(LPARAM, cast(HTREEITEM, (hitem)))))
#define TreeView_SelectItem(hwnd, hitem) TreeView_Select(hwnd, hitem, TVGN_CARET)
#define TreeView_SelectDropTarget(hwnd, hitem) TreeView_Select(hwnd, hitem, TVGN_DROPHILITE)
#define TreeView_SelectSetFirstVisible(hwnd, hitem) TreeView_Select(hwnd, hitem, TVGN_FIRSTVISIBLE)
#define TVM_GETITEMA (TV_FIRST + 12)
#define TVM_GETITEMW (TV_FIRST + 62)

#ifdef UNICODE
	#define TVM_GETITEM TVM_GETITEMW
#else
	#define TVM_GETITEM TVM_GETITEMA
#endif

#define TreeView_GetItem(hwnd, pitem) cast(WINBOOL, SNDMSG((hwnd), TVM_GETITEM, 0, cast(LPARAM, cptr(TV_ITEM ptr, (pitem)))))
#define TVM_SETITEMA (TV_FIRST + 13)
#define TVM_SETITEMW (TV_FIRST + 63)

#ifdef UNICODE
	#define TVM_SETITEM TVM_SETITEMW
#else
	#define TVM_SETITEM TVM_SETITEMA
#endif

#define TreeView_SetItem(hwnd, pitem) cast(WINBOOL, SNDMSG((hwnd), TVM_SETITEM, 0, cast(LPARAM, cptr(const TV_ITEM ptr, (pitem)))))
#define TVM_EDITLABELA (TV_FIRST + 14)
#define TVM_EDITLABELW (TV_FIRST + 65)

#ifdef UNICODE
	#define TVM_EDITLABEL TVM_EDITLABELW
#else
	#define TVM_EDITLABEL TVM_EDITLABELA
#endif

#define TreeView_EditLabel(hwnd, hitem) cast(HWND, SNDMSG((hwnd), TVM_EDITLABEL, 0, cast(LPARAM, cast(HTREEITEM, (hitem)))))
#define TVM_GETEDITCONTROL (TV_FIRST + 15)
#define TreeView_GetEditControl(hwnd) cast(HWND, SNDMSG((hwnd), TVM_GETEDITCONTROL, 0, 0))
#define TVM_GETVISIBLECOUNT (TV_FIRST + 16)
#define TreeView_GetVisibleCount(hwnd) cast(UINT, SNDMSG((hwnd), TVM_GETVISIBLECOUNT, 0, 0))
#define TVM_HITTEST (TV_FIRST + 17)
#define TreeView_HitTest(hwnd, lpht) cast(HTREEITEM, SNDMSG((hwnd), TVM_HITTEST, 0, cast(LPARAM, cast(LPTV_HITTESTINFO, lpht))))
#define LPTV_HITTESTINFO LPTVHITTESTINFO
#define TV_HITTESTINFO TVHITTESTINFO

type tagTVHITTESTINFO
	pt as POINT
	flags as UINT
	hItem as HTREEITEM
end type

type TVHITTESTINFO as tagTVHITTESTINFO
type LPTVHITTESTINFO as tagTVHITTESTINFO ptr
#define TVHT_NOWHERE &h1
#define TVHT_ONITEMICON &h2
#define TVHT_ONITEMLABEL &h4
#define TVHT_ONITEM ((TVHT_ONITEMICON or TVHT_ONITEMLABEL) or TVHT_ONITEMSTATEICON)
#define TVHT_ONITEMINDENT &h8
#define TVHT_ONITEMBUTTON &h10
#define TVHT_ONITEMRIGHT &h20
#define TVHT_ONITEMSTATEICON &h40
#define TVHT_ABOVE &h100
#define TVHT_BELOW &h200
#define TVHT_TORIGHT &h400
#define TVHT_TOLEFT &h800
#define TVM_CREATEDRAGIMAGE (TV_FIRST + 18)
#define TreeView_CreateDragImage(hwnd, hitem) cast(HIMAGELIST, SNDMSG((hwnd), TVM_CREATEDRAGIMAGE, 0, cast(LPARAM, cast(HTREEITEM, (hitem)))))
#define TVM_SORTCHILDREN (TV_FIRST + 19)
#define TreeView_SortChildren(hwnd, hitem, recurse) cast(WINBOOL, SNDMSG((hwnd), TVM_SORTCHILDREN, cast(WPARAM, (recurse)), cast(LPARAM, cast(HTREEITEM, (hitem)))))
#define TVM_ENSUREVISIBLE (TV_FIRST + 20)
#define TreeView_EnsureVisible(hwnd, hitem) cast(WINBOOL, SNDMSG((hwnd), TVM_ENSUREVISIBLE, 0, cast(LPARAM, cast(HTREEITEM, (hitem)))))
#define TVM_SORTCHILDRENCB (TV_FIRST + 21)
#define TreeView_SortChildrenCB(hwnd, psort, recurse) cast(WINBOOL, SNDMSG((hwnd), TVM_SORTCHILDRENCB, cast(WPARAM, recurse), cast(LPARAM, cast(LPTV_SORTCB, psort))))
#define TVM_ENDEDITLABELNOW (TV_FIRST + 22)
#define TreeView_EndEditLabelNow(hwnd, fCancel) cast(WINBOOL, SNDMSG((hwnd), TVM_ENDEDITLABELNOW, cast(WPARAM, (fCancel)), 0))
#define TVM_GETISEARCHSTRINGA (TV_FIRST + 23)
#define TVM_GETISEARCHSTRINGW (TV_FIRST + 64)

#ifdef UNICODE
	#define TVM_GETISEARCHSTRING TVM_GETISEARCHSTRINGW
#else
	#define TVM_GETISEARCHSTRING TVM_GETISEARCHSTRINGA
#endif

#define TVM_SETTOOLTIPS (TV_FIRST + 24)
#define TreeView_SetToolTips(hwnd, hwndTT) cast(HWND, SNDMSG((hwnd), TVM_SETTOOLTIPS, cast(WPARAM, (hwndTT)), 0))
#define TVM_GETTOOLTIPS (TV_FIRST + 25)
#define TreeView_GetToolTips(hwnd) cast(HWND, SNDMSG((hwnd), TVM_GETTOOLTIPS, 0, 0))
#define TreeView_GetISearchString(hwndTV, lpsz) cast(WINBOOL, SNDMSG((hwndTV), TVM_GETISEARCHSTRING, 0, cast(LPARAM, cast(LPTSTR, (lpsz)))))
#define TVM_SETINSERTMARK (TV_FIRST + 26)
#define TreeView_SetInsertMark(hwnd, hItem, fAfter) cast(WINBOOL, SNDMSG((hwnd), TVM_SETINSERTMARK, cast(WPARAM, (fAfter)), cast(LPARAM, (hItem))))
#define TVM_SETUNICODEFORMAT CCM_SETUNICODEFORMAT
#define TreeView_SetUnicodeFormat(hwnd, fUnicode) cast(WINBOOL, SNDMSG((hwnd), TVM_SETUNICODEFORMAT, cast(WPARAM, (fUnicode)), 0))
#define TVM_GETUNICODEFORMAT CCM_GETUNICODEFORMAT
#define TreeView_GetUnicodeFormat(hwnd) cast(WINBOOL, SNDMSG((hwnd), TVM_GETUNICODEFORMAT, 0, 0))
#define TVM_SETITEMHEIGHT (TV_FIRST + 27)
#define TreeView_SetItemHeight(hwnd, iHeight) clng(SNDMSG((hwnd), TVM_SETITEMHEIGHT, cast(WPARAM, (iHeight)), 0))
#define TVM_GETITEMHEIGHT (TV_FIRST + 28)
#define TreeView_GetItemHeight(hwnd) clng(SNDMSG((hwnd), TVM_GETITEMHEIGHT, 0, 0))
#define TVM_SETBKCOLOR (TV_FIRST + 29)
#define TreeView_SetBkColor(hwnd, clr) cast(COLORREF, SNDMSG((hwnd), TVM_SETBKCOLOR, 0, cast(LPARAM, (clr))))
#define TVM_SETTEXTCOLOR (TV_FIRST + 30)
#define TreeView_SetTextColor(hwnd, clr) cast(COLORREF, SNDMSG((hwnd), TVM_SETTEXTCOLOR, 0, cast(LPARAM, (clr))))
#define TVM_GETBKCOLOR (TV_FIRST + 31)
#define TreeView_GetBkColor(hwnd) cast(COLORREF, SNDMSG((hwnd), TVM_GETBKCOLOR, 0, 0))
#define TVM_GETTEXTCOLOR (TV_FIRST + 32)
#define TreeView_GetTextColor(hwnd) cast(COLORREF, SNDMSG((hwnd), TVM_GETTEXTCOLOR, 0, 0))
#define TVM_SETSCROLLTIME (TV_FIRST + 33)
#define TreeView_SetScrollTime(hwnd, uTime) cast(UINT, SNDMSG((hwnd), TVM_SETSCROLLTIME, uTime, 0))
#define TVM_GETSCROLLTIME (TV_FIRST + 34)
#define TreeView_GetScrollTime(hwnd) cast(UINT, SNDMSG((hwnd), TVM_GETSCROLLTIME, 0, 0))
#define TVM_SETINSERTMARKCOLOR (TV_FIRST + 37)
#define TreeView_SetInsertMarkColor(hwnd, clr) cast(COLORREF, SNDMSG((hwnd), TVM_SETINSERTMARKCOLOR, 0, cast(LPARAM, (clr))))
#define TVM_GETINSERTMARKCOLOR (TV_FIRST + 38)
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
#define TVM_GETITEMSTATE (TV_FIRST + 39)
#define TreeView_GetItemState(hwndTV, hti, mask) cast(UINT, SNDMSG((hwndTV), TVM_GETITEMSTATE, cast(WPARAM, (hti)), cast(LPARAM, (mask))))
#define TreeView_GetCheckState(hwndTV, hti) ((cast(UINT, SNDMSG((hwndTV), TVM_GETITEMSTATE, cast(WPARAM, (hti)), TVIS_STATEIMAGEMASK)) shr 12) - 1)
#define TVM_SETLINECOLOR (TV_FIRST + 40)
#define TreeView_SetLineColor(hwnd, clr) cast(COLORREF, SNDMSG((hwnd), TVM_SETLINECOLOR, 0, cast(LPARAM, (clr))))
#define TVM_GETLINECOLOR (TV_FIRST + 41)
#define TreeView_GetLineColor(hwnd) cast(COLORREF, SNDMSG((hwnd), TVM_GETLINECOLOR, 0, 0))
#define TVM_MAPACCIDTOHTREEITEM (TV_FIRST + 42)
#define TreeView_MapAccIDToHTREEITEM(hwnd, id) cast(HTREEITEM, SNDMSG((hwnd), TVM_MAPACCIDTOHTREEITEM, id, 0))
#define TVM_MAPHTREEITEMTOACCID (TV_FIRST + 43)
#define TreeView_MapHTREEITEMToAccID(hwnd, htreeitem) cast(UINT, SNDMSG((hwnd), TVM_MAPHTREEITEMTOACCID, cast(WPARAM, htreeitem), 0))
type PFNTVCOMPARE as function(byval lParam1 as LPARAM, byval lParam2 as LPARAM, byval lParamSort as LPARAM) as long
#define LPTV_SORTCB LPTVSORTCB
#define TV_SORTCB TVSORTCB

type tagTVSORTCB
	hParent as HTREEITEM
	lpfnCompare as PFNTVCOMPARE
	lParam as LPARAM
end type

type TVSORTCB as tagTVSORTCB
type LPTVSORTCB as tagTVSORTCB ptr
#define LPNM_TREEVIEWA LPNMTREEVIEWA
#define LPNM_TREEVIEWW LPNMTREEVIEWW
#define NM_TREEVIEWW NMTREEVIEWW
#define NM_TREEVIEWA NMTREEVIEWA
#define LPNM_TREEVIEW LPNMTREEVIEW
#define NM_TREEVIEW NMTREEVIEW

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
	#define NMTREEVIEW NMTREEVIEWW
	#define LPNMTREEVIEW LPNMTREEVIEWW
#else
	#define NMTREEVIEW NMTREEVIEWA
	#define LPNMTREEVIEW LPNMTREEVIEWA
#endif

#define TVN_SELCHANGINGA culng(TVN_FIRST - 1)
#define TVN_SELCHANGINGW culng(TVN_FIRST - 50)
#define TVN_SELCHANGEDA culng(TVN_FIRST - 2)
#define TVN_SELCHANGEDW culng(TVN_FIRST - 51)
#define TVC_UNKNOWN &h0
#define TVC_BYMOUSE &h1
#define TVC_BYKEYBOARD &h2
#define TVN_GETDISPINFOA culng(TVN_FIRST - 3)
#define TVN_GETDISPINFOW culng(TVN_FIRST - 52)
#define TVN_SETDISPINFOA culng(TVN_FIRST - 4)
#define TVN_SETDISPINFOW culng(TVN_FIRST - 53)
#define TVIF_DI_SETITEM &h1000
#define TV_DISPINFOA NMTVDISPINFOA
#define TV_DISPINFOW NMTVDISPINFOW
#define TV_DISPINFO NMTVDISPINFO

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
	#define NMTVDISPINFO NMTVDISPINFOW
	#define LPNMTVDISPINFO LPNMTVDISPINFOW
#elseif (not defined(UNICODE)) and ((_WIN32_WINNT = &h0502) or (_WIN32_WINNT = &h0602))
	#define NMTVDISPINFO NMTVDISPINFOA
	#define LPNMTVDISPINFO LPNMTVDISPINFOA
#endif

#if (_WIN32_WINNT = &h0502) or (_WIN32_WINNT = &h0602)
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

#if defined(UNICODE) and ((_WIN32_WINNT = &h0502) or (_WIN32_WINNT = &h0602))
	#define NMTVDISPINFOEX NMTVDISPINFOEXW
	#define LPNMTVDISPINFOEX LPNMTVDISPINFOEXW
#elseif (not defined(UNICODE)) and ((_WIN32_WINNT = &h0502) or (_WIN32_WINNT = &h0602))
	#define NMTVDISPINFOEX NMTVDISPINFOEXA
	#define LPNMTVDISPINFOEX LPNMTVDISPINFOEXA
#endif

#if (_WIN32_WINNT = &h0502) or (_WIN32_WINNT = &h0602)
	#define TV_DISPINFOEXA NMTVDISPINFOEXA
	#define TV_DISPINFOEXW NMTVDISPINFOEXW
	#define TV_DISPINFOEX NMTVDISPINFOEX
#elseif (not defined(UNICODE)) and (_WIN32_WINNT = &h0400)
	#define NMTVDISPINFO NMTVDISPINFOA
	#define LPNMTVDISPINFO LPNMTVDISPINFOA
#endif

#define TVN_ITEMEXPANDINGA culng(TVN_FIRST - 5)
#define TVN_ITEMEXPANDINGW culng(TVN_FIRST - 54)
#define TVN_ITEMEXPANDEDA culng(TVN_FIRST - 6)
#define TVN_ITEMEXPANDEDW culng(TVN_FIRST - 55)
#define TVN_BEGINDRAGA culng(TVN_FIRST - 7)
#define TVN_BEGINDRAGW culng(TVN_FIRST - 56)
#define TVN_BEGINRDRAGA culng(TVN_FIRST - 8)
#define TVN_BEGINRDRAGW culng(TVN_FIRST - 57)
#define TVN_DELETEITEMA culng(TVN_FIRST - 9)
#define TVN_DELETEITEMW culng(TVN_FIRST - 58)
#define TVN_BEGINLABELEDITA culng(TVN_FIRST - 10)
#define TVN_BEGINLABELEDITW culng(TVN_FIRST - 59)
#define TVN_ENDLABELEDITA culng(TVN_FIRST - 11)
#define TVN_ENDLABELEDITW culng(TVN_FIRST - 60)
#define TVN_KEYDOWN culng(TVN_FIRST - 12)
#define TVN_GETINFOTIPA culng(TVN_FIRST - 13)
#define TVN_GETINFOTIPW culng(TVN_FIRST - 14)
#define TVN_SINGLEEXPAND culng(TVN_FIRST - 15)
#define TVNRET_DEFAULT 0
#define TVNRET_SKIPOLD 1
#define TVNRET_SKIPNEW 2
#define TV_KEYDOWN NMTVKEYDOWN

type tagTVKEYDOWN field = 1
	hdr as NMHDR
	wVKey as WORD
	flags as UINT
end type

type NMTVKEYDOWN as tagTVKEYDOWN
type LPNMTVKEYDOWN as tagTVKEYDOWN ptr

#ifdef UNICODE
	#define TVN_SELCHANGING TVN_SELCHANGINGW
	#define TVN_SELCHANGED TVN_SELCHANGEDW
	#define TVN_GETDISPINFO TVN_GETDISPINFOW
	#define TVN_SETDISPINFO TVN_SETDISPINFOW
	#define TVN_ITEMEXPANDING TVN_ITEMEXPANDINGW
	#define TVN_ITEMEXPANDED TVN_ITEMEXPANDEDW
	#define TVN_BEGINDRAG TVN_BEGINDRAGW
	#define TVN_BEGINRDRAG TVN_BEGINRDRAGW
	#define TVN_DELETEITEM TVN_DELETEITEMW
	#define TVN_BEGINLABELEDIT TVN_BEGINLABELEDITW
	#define TVN_ENDLABELEDIT TVN_ENDLABELEDITW
#else
	#define TVN_SELCHANGING TVN_SELCHANGINGA
	#define TVN_SELCHANGED TVN_SELCHANGEDA
	#define TVN_GETDISPINFO TVN_GETDISPINFOA
	#define TVN_SETDISPINFO TVN_SETDISPINFOA
	#define TVN_ITEMEXPANDING TVN_ITEMEXPANDINGA
	#define TVN_ITEMEXPANDED TVN_ITEMEXPANDEDA
	#define TVN_BEGINDRAG TVN_BEGINDRAGA
	#define TVN_BEGINRDRAG TVN_BEGINRDRAGA
	#define TVN_DELETEITEM TVN_DELETEITEMA
	#define TVN_BEGINLABELEDIT TVN_BEGINLABELEDITA
	#define TVN_ENDLABELEDIT TVN_ENDLABELEDITA
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
	#define TVN_GETINFOTIP TVN_GETINFOTIPW
	#define NMTVGETINFOTIP NMTVGETINFOTIPW
	#define LPNMTVGETINFOTIP LPNMTVGETINFOTIPW
#else
	#define TVN_GETINFOTIP TVN_GETINFOTIPA
	#define NMTVGETINFOTIP NMTVGETINFOTIPA
	#define LPNMTVGETINFOTIP LPNMTVGETINFOTIPA
#endif

#define TVCDRF_NOIMAGES &h10000
#define WC_COMBOBOXEXW wstr("ComboBoxEx32")
#define WC_COMBOBOXEXA "ComboBoxEx32"

#ifdef UNICODE
	#define WC_COMBOBOXEX WC_COMBOBOXEXW
#else
	#define WC_COMBOBOXEX WC_COMBOBOXEXA
#endif

#define CBEIF_TEXT &h1
#define CBEIF_IMAGE &h2
#define CBEIF_SELECTEDIMAGE &h4
#define CBEIF_OVERLAY &h8
#define CBEIF_INDENT &h10
#define CBEIF_LPARAM &h20
#define CBEIF_DI_SETITEM &h10000000

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
	#define COMBOBOXEXITEM COMBOBOXEXITEMW
	#define PCOMBOBOXEXITEM PCOMBOBOXEXITEMW
	#define PCCOMBOBOXEXITEM PCCOMBOBOXEXITEMW
#else
	#define COMBOBOXEXITEM COMBOBOXEXITEMA
	#define PCOMBOBOXEXITEM PCOMBOBOXEXITEMA
	#define PCCOMBOBOXEXITEM PCCOMBOBOXEXITEMA
#endif

#define CBEM_INSERTITEMA (WM_USER + 1)
#define CBEM_SETIMAGELIST (WM_USER + 2)
#define CBEM_GETIMAGELIST (WM_USER + 3)
#define CBEM_GETITEMA (WM_USER + 4)
#define CBEM_SETITEMA (WM_USER + 5)
#define CBEM_DELETEITEM CB_DELETESTRING
#define CBEM_GETCOMBOCONTROL (WM_USER + 6)
#define CBEM_GETEDITCONTROL (WM_USER + 7)
#define CBEM_SETEXSTYLE (WM_USER + 8)
#define CBEM_SETEXTENDEDSTYLE (WM_USER + 14)
#define CBEM_GETEXSTYLE (WM_USER + 9)
#define CBEM_GETEXTENDEDSTYLE (WM_USER + 9)
#define CBEM_SETUNICODEFORMAT CCM_SETUNICODEFORMAT
#define CBEM_GETUNICODEFORMAT CCM_GETUNICODEFORMAT
#define CBEM_HASEDITCHANGED (WM_USER + 10)
#define CBEM_INSERTITEMW (WM_USER + 11)
#define CBEM_SETITEMW (WM_USER + 12)
#define CBEM_GETITEMW (WM_USER + 13)

#ifdef UNICODE
	#define CBEM_INSERTITEM CBEM_INSERTITEMW
	#define CBEM_SETITEM CBEM_SETITEMW
	#define CBEM_GETITEM CBEM_GETITEMW
#else
	#define CBEM_INSERTITEM CBEM_INSERTITEMA
	#define CBEM_SETITEM CBEM_SETITEMA
	#define CBEM_GETITEM CBEM_GETITEMA
#endif

#define CBEM_SETWINDOWTHEME CCM_SETWINDOWTHEME
#define CBES_EX_NOEDITIMAGE &h1
#define CBES_EX_NOEDITIMAGEINDENT &h2
#define CBES_EX_PATHWORDBREAKPROC &h4
#define CBES_EX_NOSIZELIMIT &h8
#define CBES_EX_CASESENSITIVE &h10

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
	#define NMCOMBOBOXEX NMCOMBOBOXEXW
	#define PNMCOMBOBOXEX PNMCOMBOBOXEXW
	#define CBEN_GETDISPINFO CBEN_GETDISPINFOW
#else
	#define NMCOMBOBOXEX NMCOMBOBOXEXA
	#define PNMCOMBOBOXEX PNMCOMBOBOXEXA
	#define CBEN_GETDISPINFO CBEN_GETDISPINFOA
#endif

#define CBEN_GETDISPINFOA culng(CBEN_FIRST - 0)
#define CBEN_INSERTITEM culng(CBEN_FIRST - 1)
#define CBEN_DELETEITEM culng(CBEN_FIRST - 2)
#define CBEN_BEGINEDIT culng(CBEN_FIRST - 4)
#define CBEN_ENDEDITA culng(CBEN_FIRST - 5)
#define CBEN_ENDEDITW culng(CBEN_FIRST - 6)
#define CBEN_GETDISPINFOW culng(CBEN_FIRST - 7)
#define CBEN_DRAGBEGINA culng(CBEN_FIRST - 8)
#define CBEN_DRAGBEGINW culng(CBEN_FIRST - 9)

#ifdef UNICODE
	#define CBEN_DRAGBEGIN CBEN_DRAGBEGINW
	#define CBEN_ENDEDIT CBEN_ENDEDITW
#else
	#define CBEN_DRAGBEGIN CBEN_DRAGBEGINA
	#define CBEN_ENDEDIT CBEN_ENDEDITA
#endif

#define CBENF_KILLFOCUS 1
#define CBENF_RETURN 2
#define CBENF_ESCAPE 3
#define CBENF_DROPDOWN 4
#define CBEMAXSTRLEN 260

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
	#define NMCBEDRAGBEGIN NMCBEDRAGBEGINW
	#define LPNMCBEDRAGBEGIN LPNMCBEDRAGBEGINW
	#define PNMCBEDRAGBEGIN PNMCBEDRAGBEGINW
#else
	#define NMCBEDRAGBEGIN NMCBEDRAGBEGINA
	#define LPNMCBEDRAGBEGIN LPNMCBEDRAGBEGINA
	#define PNMCBEDRAGBEGIN PNMCBEDRAGBEGINA
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
	#define NMCBEENDEDIT NMCBEENDEDITW
	#define LPNMCBEENDEDIT LPNMCBEENDEDITW
	#define PNMCBEENDEDIT PNMCBEENDEDITW
#else
	#define NMCBEENDEDIT NMCBEENDEDITA
	#define LPNMCBEENDEDIT LPNMCBEENDEDITA
	#define PNMCBEENDEDIT PNMCBEENDEDITA
#endif

#define WC_TABCONTROLA "SysTabControl32"
#define WC_TABCONTROLW wstr("SysTabControl32")

#ifdef UNICODE
	#define WC_TABCONTROL WC_TABCONTROLW
#else
	#define WC_TABCONTROL WC_TABCONTROLA
#endif

#define TCS_SCROLLOPPOSITE &h1
#define TCS_BOTTOM &h2
#define TCS_RIGHT &h2
#define TCS_MULTISELECT &h4
#define TCS_FLATBUTTONS &h8
#define TCS_FORCEICONLEFT &h10
#define TCS_FORCELABELLEFT &h20
#define TCS_HOTTRACK &h40
#define TCS_VERTICAL &h80
#define TCS_TABS &h0
#define TCS_BUTTONS &h100
#define TCS_SINGLELINE &h0
#define TCS_MULTILINE &h200
#define TCS_RIGHTJUSTIFY &h0
#define TCS_FIXEDWIDTH &h400
#define TCS_RAGGEDRIGHT &h800
#define TCS_FOCUSONBUTTONDOWN &h1000
#define TCS_OWNERDRAWFIXED &h2000
#define TCS_TOOLTIPS &h4000
#define TCS_FOCUSNEVER &h8000
#define TCS_EX_FLATSEPARATORS &h1
#define TCS_EX_REGISTERDROP &h2
#define TCM_GETIMAGELIST (TCM_FIRST + 2)
#define TabCtrl_GetImageList(hwnd) cast(HIMAGELIST, SNDMSG((hwnd), TCM_GETIMAGELIST, cast(WPARAM, 0), cast(LPARAM, 0)))
#define TCM_SETIMAGELIST (TCM_FIRST + 3)
#define TabCtrl_SetImageList(hwnd, himl) cast(HIMAGELIST, SNDMSG((hwnd), TCM_SETIMAGELIST, 0, cast(LPARAM, cast(HIMAGELIST, (himl)))))
#define TCM_GETITEMCOUNT (TCM_FIRST + 4)
#define TabCtrl_GetItemCount(hwnd) clng(SNDMSG((hwnd), TCM_GETITEMCOUNT, cast(WPARAM, 0), cast(LPARAM, 0)))
#define TCIF_TEXT &h1
#define TCIF_IMAGE &h2
#define TCIF_RTLREADING &h4
#define TCIF_PARAM &h8
#define TCIF_STATE &h10
#define TCIS_BUTTONPRESSED &h1
#define TCIS_HIGHLIGHTED &h2
#define TC_ITEMHEADERA TCITEMHEADERA
#define TC_ITEMHEADERW TCITEMHEADERW
#define TC_ITEMHEADER TCITEMHEADER

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
	#define TCITEMHEADER TCITEMHEADERW
	#define LPTCITEMHEADER LPTCITEMHEADERW
#else
	#define TCITEMHEADER TCITEMHEADERA
	#define LPTCITEMHEADER LPTCITEMHEADERA
#endif

#define TC_ITEMA TCITEMA
#define TC_ITEMW TCITEMW
#define TC_ITEM TCITEM

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
	#define TCITEM TCITEMW
	#define LPTCITEM LPTCITEMW
#else
	#define TCITEM TCITEMA
	#define LPTCITEM LPTCITEMA
#endif

#define TCM_GETITEMA (TCM_FIRST + 5)
#define TCM_GETITEMW (TCM_FIRST + 60)

#ifdef UNICODE
	#define TCM_GETITEM TCM_GETITEMW
#else
	#define TCM_GETITEM TCM_GETITEMA
#endif

#define TabCtrl_GetItem(hwnd, iItem, pitem) cast(WINBOOL, SNDMSG((hwnd), TCM_GETITEM, cast(WPARAM, clng((iItem))), cast(LPARAM, cptr(TC_ITEM ptr, (pitem)))))
#define TCM_SETITEMA (TCM_FIRST + 6)
#define TCM_SETITEMW (TCM_FIRST + 61)

#ifdef UNICODE
	#define TCM_SETITEM TCM_SETITEMW
#else
	#define TCM_SETITEM TCM_SETITEMA
#endif

#define TabCtrl_SetItem(hwnd, iItem, pitem) cast(WINBOOL, SNDMSG((hwnd), TCM_SETITEM, cast(WPARAM, clng((iItem))), cast(LPARAM, cptr(TC_ITEM ptr, (pitem)))))
#define TCM_INSERTITEMA (TCM_FIRST + 7)
#define TCM_INSERTITEMW (TCM_FIRST + 62)

#ifdef UNICODE
	#define TCM_INSERTITEM TCM_INSERTITEMW
#else
	#define TCM_INSERTITEM TCM_INSERTITEMA
#endif

#define TabCtrl_InsertItem(hwnd, iItem, pitem) clng(SNDMSG((hwnd), TCM_INSERTITEM, cast(WPARAM, clng((iItem))), cast(LPARAM, cptr(const TC_ITEM ptr, (pitem)))))
#define TCM_DELETEITEM (TCM_FIRST + 8)
#define TabCtrl_DeleteItem(hwnd, i) cast(WINBOOL, SNDMSG((hwnd), TCM_DELETEITEM, cast(WPARAM, clng((i))), cast(LPARAM, 0)))
#define TCM_DELETEALLITEMS (TCM_FIRST + 9)
#define TabCtrl_DeleteAllItems(hwnd) cast(WINBOOL, SNDMSG((hwnd), TCM_DELETEALLITEMS, cast(WPARAM, 0), cast(LPARAM, 0)))
#define TCM_GETITEMRECT (TCM_FIRST + 10)
#define TabCtrl_GetItemRect(hwnd, i, prc) cast(WINBOOL, SNDMSG((hwnd), TCM_GETITEMRECT, cast(WPARAM, clng((i))), cast(LPARAM, cptr(RECT ptr, (prc)))))
#define TCM_GETCURSEL (TCM_FIRST + 11)
#define TabCtrl_GetCurSel(hwnd) clng(SNDMSG((hwnd), TCM_GETCURSEL, 0, 0))
#define TCM_SETCURSEL (TCM_FIRST + 12)
#define TabCtrl_SetCurSel(hwnd, i) clng(SNDMSG((hwnd), TCM_SETCURSEL, cast(WPARAM, (i)), 0))
#define TCHT_NOWHERE &h1
#define TCHT_ONITEMICON &h2
#define TCHT_ONITEMLABEL &h4
#define TCHT_ONITEM (TCHT_ONITEMICON or TCHT_ONITEMLABEL)
#define LPTC_HITTESTINFO LPTCHITTESTINFO
#define TC_HITTESTINFO TCHITTESTINFO

type tagTCHITTESTINFO
	pt as POINT
	flags as UINT
end type

type TCHITTESTINFO as tagTCHITTESTINFO
type LPTCHITTESTINFO as tagTCHITTESTINFO ptr
#define TCM_HITTEST (TCM_FIRST + 13)
#define TabCtrl_HitTest(hwndTC, pinfo) clng(SNDMSG((hwndTC), TCM_HITTEST, 0, cast(LPARAM, cptr(TC_HITTESTINFO ptr, (pinfo)))))
#define TCM_SETITEMEXTRA (TCM_FIRST + 14)
#define TabCtrl_SetItemExtra(hwndTC, cb) cast(WINBOOL, SNDMSG((hwndTC), TCM_SETITEMEXTRA, cast(WPARAM, (cb)), cast(LPARAM, 0)))
#define TCM_ADJUSTRECT (TCM_FIRST + 40)
#define TabCtrl_AdjustRect(hwnd, bLarger, prc) clng(SNDMSG(hwnd, TCM_ADJUSTRECT, cast(WPARAM, cast(WINBOOL, (bLarger))), cast(LPARAM, cptr(RECT ptr, prc))))
#define TCM_SETITEMSIZE (TCM_FIRST + 41)
#define TabCtrl_SetItemSize(hwnd, x, y) cast(DWORD, SNDMSG((hwnd), TCM_SETITEMSIZE, 0, MAKELPARAM(x, y)))
#define TCM_REMOVEIMAGE (TCM_FIRST + 42)
#define TabCtrl_RemoveImage(hwnd, i) SNDMSG((hwnd), TCM_REMOVEIMAGE, i, cast(LPARAM, 0))
#define TCM_SETPADDING (TCM_FIRST + 43)
#define TabCtrl_SetPadding(hwnd, cx, cy) SNDMSG((hwnd), TCM_SETPADDING, 0, MAKELPARAM(cx, cy))
#define TCM_GETROWCOUNT (TCM_FIRST + 44)
#define TabCtrl_GetRowCount(hwnd) clng(SNDMSG((hwnd), TCM_GETROWCOUNT, cast(WPARAM, 0), cast(LPARAM, 0)))
#define TCM_GETTOOLTIPS (TCM_FIRST + 45)
#define TabCtrl_GetToolTips(hwnd) cast(HWND, SNDMSG((hwnd), TCM_GETTOOLTIPS, cast(WPARAM, 0), cast(LPARAM, 0)))
#define TCM_SETTOOLTIPS (TCM_FIRST + 46)
#define TabCtrl_SetToolTips(hwnd, hwndTT) SNDMSG((hwnd), TCM_SETTOOLTIPS, cast(WPARAM, (hwndTT)), cast(LPARAM, 0))
#define TCM_GETCURFOCUS (TCM_FIRST + 47)
#define TabCtrl_GetCurFocus(hwnd) clng(SNDMSG((hwnd), TCM_GETCURFOCUS, 0, 0))
#define TCM_SETCURFOCUS (TCM_FIRST + 48)
#define TabCtrl_SetCurFocus(hwnd, i) SNDMSG((hwnd), TCM_SETCURFOCUS, i, 0)
#define TCM_SETMINTABWIDTH (TCM_FIRST + 49)
#define TabCtrl_SetMinTabWidth(hwnd, x) clng(SNDMSG((hwnd), TCM_SETMINTABWIDTH, 0, x))
#define TCM_DESELECTALL (TCM_FIRST + 50)
#define TabCtrl_DeselectAll(hwnd, fExcludeFocus) SNDMSG((hwnd), TCM_DESELECTALL, fExcludeFocus, 0)
#define TCM_HIGHLIGHTITEM (TCM_FIRST + 51)
#define TabCtrl_HighlightItem(hwnd, i, fHighlight) cast(WINBOOL, SNDMSG((hwnd), TCM_HIGHLIGHTITEM, cast(WPARAM, (i)), cast(LPARAM, MAKELONG(fHighlight, 0))))
#define TCM_SETEXTENDEDSTYLE (TCM_FIRST + 52)
#define TabCtrl_SetExtendedStyle(hwnd, dw) cast(DWORD, SNDMSG((hwnd), TCM_SETEXTENDEDSTYLE, 0, dw))
#define TCM_GETEXTENDEDSTYLE (TCM_FIRST + 53)
#define TabCtrl_GetExtendedStyle(hwnd) cast(DWORD, SNDMSG((hwnd), TCM_GETEXTENDEDSTYLE, 0, 0))
#define TCM_SETUNICODEFORMAT CCM_SETUNICODEFORMAT
#define TabCtrl_SetUnicodeFormat(hwnd, fUnicode) cast(WINBOOL, SNDMSG((hwnd), TCM_SETUNICODEFORMAT, cast(WPARAM, (fUnicode)), 0))
#define TCM_GETUNICODEFORMAT CCM_GETUNICODEFORMAT
#define TabCtrl_GetUnicodeFormat(hwnd) cast(WINBOOL, SNDMSG((hwnd), TCM_GETUNICODEFORMAT, 0, 0))
#define TCN_KEYDOWN culng(TCN_FIRST - 0)
#define TC_KEYDOWN NMTCKEYDOWN

type tagTCKEYDOWN field = 1
	hdr as NMHDR
	wVKey as WORD
	flags as UINT
end type

type NMTCKEYDOWN as tagTCKEYDOWN
#define TCN_SELCHANGE culng(TCN_FIRST - 1)
#define TCN_SELCHANGING culng(TCN_FIRST - 2)
#define TCN_GETOBJECT culng(TCN_FIRST - 3)
#define TCN_FOCUSCHANGE culng(TCN_FIRST - 4)
#define ANIMATE_CLASSW wstr("SysAnimate32")
#define ANIMATE_CLASSA "SysAnimate32"

#ifdef UNICODE
	#define ANIMATE_CLASS ANIMATE_CLASSW
#else
	#define ANIMATE_CLASS ANIMATE_CLASSA
#endif

#define ACS_CENTER &h1
#define ACS_TRANSPARENT &h2
#define ACS_AUTOPLAY &h4
#define ACS_TIMER &h8
#define ACM_OPENA (WM_USER + 100)
#define ACM_OPENW (WM_USER + 103)

#ifdef UNICODE
	#define ACM_OPEN ACM_OPENW
#else
	#define ACM_OPEN ACM_OPENA
#endif

#define ACM_PLAY (WM_USER + 101)
#define ACM_STOP (WM_USER + 102)
#define ACN_START 1
#define ACN_STOP 2
#define Animate_Create(hwndP, id, dwStyle, hInstance) CreateWindow(ANIMATE_CLASS, NULL, dwStyle, 0, 0, 0, 0, hwndP, cast(HMENU, (id)), hInstance, NULL)
#define Animate_Open(hwnd, szName) cast(WINBOOL, SNDMSG(hwnd, ACM_OPEN, 0, cast(LPARAM, cast(LPTSTR, (szName)))))
#define Animate_OpenEx(hwnd, hInst, szName) cast(WINBOOL, SNDMSG(hwnd, ACM_OPEN, cast(WPARAM, (hInst)), cast(LPARAM, cast(LPTSTR, (szName)))))
#define Animate_Play(hwnd, from, to, rep) cast(WINBOOL, SNDMSG(hwnd, ACM_PLAY, cast(WPARAM, (rep)), cast(LPARAM, MAKELONG(from, to))))
#define Animate_Stop(hwnd) cast(WINBOOL, SNDMSG(hwnd, ACM_STOP, 0, 0))
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
#define MCM_FIRST &h1000
#define MCM_GETCURSEL (MCM_FIRST + 1)
#define MonthCal_GetCurSel(hmc, pst) cast(WINBOOL, SNDMSG(hmc, MCM_GETCURSEL, 0, cast(LPARAM, (pst))))
#define MCM_SETCURSEL (MCM_FIRST + 2)
#define MonthCal_SetCurSel(hmc, pst) cast(WINBOOL, SNDMSG(hmc, MCM_SETCURSEL, 0, cast(LPARAM, (pst))))
#define MCM_GETMAXSELCOUNT (MCM_FIRST + 3)
#define MonthCal_GetMaxSelCount(hmc) cast(DWORD, SNDMSG(hmc, MCM_GETMAXSELCOUNT, cast(WPARAM, 0), cast(LPARAM, 0)))
#define MCM_SETMAXSELCOUNT (MCM_FIRST + 4)
#define MonthCal_SetMaxSelCount(hmc, n) cast(WINBOOL, SNDMSG(hmc, MCM_SETMAXSELCOUNT, cast(WPARAM, (n)), cast(LPARAM, 0)))
#define MCM_GETSELRANGE (MCM_FIRST + 5)
#define MonthCal_GetSelRange(hmc, rgst) SNDMSG(hmc, MCM_GETSELRANGE, 0, cast(LPARAM, (rgst)))
#define MCM_SETSELRANGE (MCM_FIRST + 6)
#define MonthCal_SetSelRange(hmc, rgst) SNDMSG(hmc, MCM_SETSELRANGE, 0, cast(LPARAM, (rgst)))
#define MCM_GETMONTHRANGE (MCM_FIRST + 7)
#define MonthCal_GetMonthRange(hmc, gmr, rgst) cast(DWORD, SNDMSG(hmc, MCM_GETMONTHRANGE, cast(WPARAM, (gmr)), cast(LPARAM, (rgst))))
#define MCM_SETDAYSTATE (MCM_FIRST + 8)
#define MonthCal_SetDayState(hmc, cbds, rgds) SNDMSG(hmc, MCM_SETDAYSTATE, cast(WPARAM, (cbds)), cast(LPARAM, (rgds)))
#define MCM_GETMINREQRECT (MCM_FIRST + 9)
#define MonthCal_GetMinReqRect(hmc, prc) SNDMSG(hmc, MCM_GETMINREQRECT, 0, cast(LPARAM, (prc)))
#define MCM_SETCOLOR (MCM_FIRST + 10)
#define MonthCal_SetColor(hmc, iColor, clr) SNDMSG(hmc, MCM_SETCOLOR, iColor, clr)
#define MCM_GETCOLOR (MCM_FIRST + 11)
#define MonthCal_GetColor(hmc, iColor) SNDMSG(hmc, MCM_GETCOLOR, iColor, 0)
#define MCSC_BACKGROUND 0
#define MCSC_TEXT 1
#define MCSC_TITLEBK 2
#define MCSC_TITLETEXT 3
#define MCSC_MONTHBK 4
#define MCSC_TRAILINGTEXT 5
#define MCM_SETTODAY (MCM_FIRST + 12)
#define MonthCal_SetToday(hmc, pst) SNDMSG(hmc, MCM_SETTODAY, 0, cast(LPARAM, (pst)))
#define MCM_GETTODAY (MCM_FIRST + 13)
#define MonthCal_GetToday(hmc, pst) cast(WINBOOL, SNDMSG(hmc, MCM_GETTODAY, 0, cast(LPARAM, (pst))))
#define MCM_HITTEST (MCM_FIRST + 14)
#define MonthCal_HitTest(hmc, pinfo) SNDMSG(hmc, MCM_HITTEST, 0, cast(LPARAM, cast(PMCHITTESTINFO, (pinfo))))

type MCHITTESTINFO
	cbSize as UINT
	pt as POINT
	uHit as UINT
	st as SYSTEMTIME
end type

type PMCHITTESTINFO as MCHITTESTINFO ptr
#define MCHT_TITLE &h10000
#define MCHT_CALENDAR &h20000
#define MCHT_TODAYLINK &h30000
#define MCHT_NEXT &h1000000
#define MCHT_PREV &h2000000
#define MCHT_NOWHERE &h0
#define MCHT_TITLEBK MCHT_TITLE
#define MCHT_TITLEMONTH (MCHT_TITLE or &h1)
#define MCHT_TITLEYEAR (MCHT_TITLE or &h2)
#define MCHT_TITLEBTNNEXT ((MCHT_TITLE or MCHT_NEXT) or &h3)
#define MCHT_TITLEBTNPREV ((MCHT_TITLE or MCHT_PREV) or &h3)
#define MCHT_CALENDARBK MCHT_CALENDAR
#define MCHT_CALENDARDATE (MCHT_CALENDAR or &h1)
#define MCHT_CALENDARDATENEXT (MCHT_CALENDARDATE or MCHT_NEXT)
#define MCHT_CALENDARDATEPREV (MCHT_CALENDARDATE or MCHT_PREV)
#define MCHT_CALENDARDAY (MCHT_CALENDAR or &h2)
#define MCHT_CALENDARWEEKNUM (MCHT_CALENDAR or &h3)
#define MCM_SETFIRSTDAYOFWEEK (MCM_FIRST + 15)
#define MonthCal_SetFirstDayOfWeek(hmc, iDay) SNDMSG(hmc, MCM_SETFIRSTDAYOFWEEK, 0, iDay)
#define MCM_GETFIRSTDAYOFWEEK (MCM_FIRST + 16)
#define MonthCal_GetFirstDayOfWeek(hmc) cast(DWORD, SNDMSG(hmc, MCM_GETFIRSTDAYOFWEEK, 0, 0))
#define MCM_GETRANGE (MCM_FIRST + 17)
#define MonthCal_GetRange(hmc, rgst) cast(DWORD, SNDMSG(hmc, MCM_GETRANGE, 0, cast(LPARAM, (rgst))))
#define MCM_SETRANGE (MCM_FIRST + 18)
#define MonthCal_SetRange(hmc, gd, rgst) cast(WINBOOL, SNDMSG(hmc, MCM_SETRANGE, cast(WPARAM, (gd)), cast(LPARAM, (rgst))))
#define MCM_GETMONTHDELTA (MCM_FIRST + 19)
#define MonthCal_GetMonthDelta(hmc) clng(SNDMSG(hmc, MCM_GETMONTHDELTA, 0, 0))
#define MCM_SETMONTHDELTA (MCM_FIRST + 20)
#define MonthCal_SetMonthDelta(hmc, n) clng(SNDMSG(hmc, MCM_SETMONTHDELTA, n, 0))
#define MCM_GETMAXTODAYWIDTH (MCM_FIRST + 21)
#define MonthCal_GetMaxTodayWidth(hmc) cast(DWORD, SNDMSG(hmc, MCM_GETMAXTODAYWIDTH, 0, 0))
#define MCM_SETUNICODEFORMAT CCM_SETUNICODEFORMAT
#define MonthCal_SetUnicodeFormat(hwnd, fUnicode) cast(WINBOOL, SNDMSG((hwnd), MCM_SETUNICODEFORMAT, cast(WPARAM, (fUnicode)), 0))
#define MCM_GETUNICODEFORMAT CCM_GETUNICODEFORMAT
#define MonthCal_GetUnicodeFormat(hwnd) cast(WINBOOL, SNDMSG((hwnd), MCM_GETUNICODEFORMAT, 0, 0))

type tagNMSELCHANGE
	nmhdr as NMHDR
	stSelStart as SYSTEMTIME
	stSelEnd as SYSTEMTIME
end type

type NMSELCHANGE as tagNMSELCHANGE
type LPNMSELCHANGE as tagNMSELCHANGE ptr
#define MCN_SELCHANGE culng(MCN_FIRST + 1)

type tagNMDAYSTATE
	nmhdr as NMHDR
	stStart as SYSTEMTIME
	cDayState as long
	prgDayState as LPMONTHDAYSTATE
end type

type NMDAYSTATE as tagNMDAYSTATE
type LPNMDAYSTATE as tagNMDAYSTATE ptr
#define MCN_GETDAYSTATE culng(MCN_FIRST + 3)
type NMSELECT as NMSELCHANGE
type LPNMSELECT as NMSELCHANGE ptr
#define MCN_SELECT culng(MCN_FIRST + 4)
#define MCS_DAYSTATE &h1
#define MCS_MULTISELECT &h2
#define MCS_WEEKNUMBERS &h4
#define MCS_NOTODAYCIRCLE &h8
#define MCS_NOTODAY &h10
#define GMR_VISIBLE 0
#define GMR_DAYSTATE 1
#define DATETIMEPICK_CLASSW wstr("SysDateTimePick32")
#define DATETIMEPICK_CLASSA "SysDateTimePick32"

#ifdef UNICODE
	#define DATETIMEPICK_CLASS DATETIMEPICK_CLASSW
#else
	#define DATETIMEPICK_CLASS DATETIMEPICK_CLASSA
#endif

#define DTM_FIRST &h1000
#define DTM_GETSYSTEMTIME (DTM_FIRST + 1)
#define DateTime_GetSystemtime(hdp, pst) cast(DWORD, SNDMSG(hdp, DTM_GETSYSTEMTIME, 0, cast(LPARAM, (pst))))
#define DTM_SETSYSTEMTIME (DTM_FIRST + 2)
#define DateTime_SetSystemtime(hdp, gd, pst) cast(WINBOOL, SNDMSG(hdp, DTM_SETSYSTEMTIME, cast(WPARAM, (gd)), cast(LPARAM, (pst))))
#define DTM_GETRANGE (DTM_FIRST + 3)
#define DateTime_GetRange(hdp, rgst) cast(DWORD, SNDMSG(hdp, DTM_GETRANGE, 0, cast(LPARAM, (rgst))))
#define DTM_SETRANGE (DTM_FIRST + 4)
#define DateTime_SetRange(hdp, gd, rgst) cast(WINBOOL, SNDMSG(hdp, DTM_SETRANGE, cast(WPARAM, (gd)), cast(LPARAM, (rgst))))
#define DTM_SETFORMATA (DTM_FIRST + 5)
#define DTM_SETFORMATW (DTM_FIRST + 50)

#ifdef UNICODE
	#define DTM_SETFORMAT DTM_SETFORMATW
#else
	#define DTM_SETFORMAT DTM_SETFORMATA
#endif

#define DateTime_SetFormat(hdp, sz) cast(WINBOOL, SNDMSG(hdp, DTM_SETFORMAT, 0, cast(LPARAM, (sz))))
#define DTM_SETMCCOLOR (DTM_FIRST + 6)
#define DateTime_SetMonthCalColor(hdp, iColor, clr) SNDMSG(hdp, DTM_SETMCCOLOR, iColor, clr)
#define DTM_GETMCCOLOR (DTM_FIRST + 7)
#define DateTime_GetMonthCalColor(hdp, iColor) SNDMSG(hdp, DTM_GETMCCOLOR, iColor, 0)
#define DTM_GETMONTHCAL (DTM_FIRST + 8)
#define DateTime_GetMonthCal(hdp) cast(HWND, SNDMSG(hdp, DTM_GETMONTHCAL, 0, 0))
#define DTM_SETMCFONT (DTM_FIRST + 9)
#define DateTime_SetMonthCalFont(hdp, hfont, fRedraw) SNDMSG(hdp, DTM_SETMCFONT, cast(WPARAM, (hfont)), cast(LPARAM, (fRedraw)))
#define DTM_GETMCFONT (DTM_FIRST + 10)
#define DateTime_GetMonthCalFont(hdp) SNDMSG(hdp, DTM_GETMCFONT, 0, 0)
#define DTS_UPDOWN &h1
#define DTS_SHOWNONE &h2
#define DTS_SHORTDATEFORMAT &h0
#define DTS_LONGDATEFORMAT &h4
#define DTS_SHORTDATECENTURYFORMAT &hc
#define DTS_TIMEFORMAT &h9
#define DTS_APPCANPARSE &h10
#define DTS_RIGHTALIGN &h20
#define DTN_DATETIMECHANGE culng(DTN_FIRST + 1)

type tagNMDATETIMECHANGE
	nmhdr as NMHDR
	dwFlags as DWORD
	st as SYSTEMTIME
end type

type NMDATETIMECHANGE as tagNMDATETIMECHANGE
type LPNMDATETIMECHANGE as tagNMDATETIMECHANGE ptr
#define DTN_USERSTRINGA culng(DTN_FIRST + 2)
#define DTN_USERSTRINGW culng(DTN_FIRST + 15)

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
	#define DTN_USERSTRING DTN_USERSTRINGW
	#define NMDATETIMESTRING NMDATETIMESTRINGW
	#define LPNMDATETIMESTRING LPNMDATETIMESTRINGW
#else
	#define DTN_USERSTRING DTN_USERSTRINGA
	#define NMDATETIMESTRING NMDATETIMESTRINGA
	#define LPNMDATETIMESTRING LPNMDATETIMESTRINGA
#endif

#define DTN_WMKEYDOWNA culng(DTN_FIRST + 3)
#define DTN_WMKEYDOWNW culng(DTN_FIRST + 16)

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
	#define DTN_WMKEYDOWN DTN_WMKEYDOWNW
	#define NMDATETIMEWMKEYDOWN NMDATETIMEWMKEYDOWNW
	#define LPNMDATETIMEWMKEYDOWN LPNMDATETIMEWMKEYDOWNW
#else
	#define DTN_WMKEYDOWN DTN_WMKEYDOWNA
	#define NMDATETIMEWMKEYDOWN NMDATETIMEWMKEYDOWNA
	#define LPNMDATETIMEWMKEYDOWN LPNMDATETIMEWMKEYDOWNA
#endif

#define DTN_FORMATA culng(DTN_FIRST + 4)
#define DTN_FORMATW culng(DTN_FIRST + 17)

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
	#define DTN_FORMAT DTN_FORMATW
	#define NMDATETIMEFORMAT NMDATETIMEFORMATW
	#define LPNMDATETIMEFORMAT LPNMDATETIMEFORMATW
#else
	#define DTN_FORMAT DTN_FORMATA
	#define NMDATETIMEFORMAT NMDATETIMEFORMATA
	#define LPNMDATETIMEFORMAT LPNMDATETIMEFORMATA
#endif

#define DTN_FORMATQUERYA culng(DTN_FIRST + 5)
#define DTN_FORMATQUERYW culng(DTN_FIRST + 18)

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
	#define DTN_FORMATQUERY DTN_FORMATQUERYW
	#define NMDATETIMEFORMATQUERY NMDATETIMEFORMATQUERYW
	#define LPNMDATETIMEFORMATQUERY LPNMDATETIMEFORMATQUERYW
#else
	#define DTN_FORMATQUERY DTN_FORMATQUERYA
	#define NMDATETIMEFORMATQUERY NMDATETIMEFORMATQUERYA
	#define LPNMDATETIMEFORMATQUERY LPNMDATETIMEFORMATQUERYA
#endif

#define DTN_DROPDOWN culng(DTN_FIRST + 6)
#define DTN_CLOSEUP culng(DTN_FIRST + 7)
#define GDTR_MIN &h1
#define GDTR_MAX &h2
#define GDT_ERROR (-1)
#define GDT_VALID 0
#define GDT_NONE 1
#define IPM_CLEARADDRESS (WM_USER + 100)
#define IPM_SETADDRESS (WM_USER + 101)
#define IPM_GETADDRESS (WM_USER + 102)
#define IPM_SETRANGE (WM_USER + 103)
#define IPM_SETFOCUS (WM_USER + 104)
#define IPM_ISBLANK (WM_USER + 105)
#define WC_IPADDRESSW wstr("SysIPAddress32")
#define WC_IPADDRESSA "SysIPAddress32"

#ifdef UNICODE
	#define WC_IPADDRESS WC_IPADDRESSW
#else
	#define WC_IPADDRESS WC_IPADDRESSA
#endif

#define IPN_FIELDCHANGED culng(IPN_FIRST - 0)

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

#define PGS_VERT &h0
#define PGS_HORZ &h1
#define PGS_AUTOSCROLL &h2
#define PGS_DRAGNDROP &h4
#define PGF_INVISIBLE 0
#define PGF_NORMAL 1
#define PGF_GRAYED 2
#define PGF_DEPRESSED 4
#define PGF_HOT 8
#define PGB_TOPORLEFT 0
#define PGB_BOTTOMORRIGHT 1
#define PGM_SETCHILD (PGM_FIRST + 1)
#define Pager_SetChild(hwnd, hwndChild) SNDMSG((hwnd), PGM_SETCHILD, 0, cast(LPARAM, (hwndChild)))
#define PGM_RECALCSIZE (PGM_FIRST + 2)
#define Pager_RecalcSize(hwnd) SNDMSG((hwnd), PGM_RECALCSIZE, 0, 0)
#define PGM_FORWARDMOUSE (PGM_FIRST + 3)
#define Pager_ForwardMouse(hwnd, bForward) SNDMSG((hwnd), PGM_FORWARDMOUSE, cast(WPARAM, (bForward)), 0)
#define PGM_SETBKCOLOR (PGM_FIRST + 4)
#define Pager_SetBkColor(hwnd, clr) cast(COLORREF, SNDMSG((hwnd), PGM_SETBKCOLOR, 0, cast(LPARAM, (clr))))
#define PGM_GETBKCOLOR (PGM_FIRST + 5)
#define Pager_GetBkColor(hwnd) cast(COLORREF, SNDMSG((hwnd), PGM_GETBKCOLOR, 0, 0))
#define PGM_SETBORDER (PGM_FIRST + 6)
#define Pager_SetBorder(hwnd, iBorder) clng(SNDMSG((hwnd), PGM_SETBORDER, 0, cast(LPARAM, (iBorder))))
#define PGM_GETBORDER (PGM_FIRST + 7)
#define Pager_GetBorder(hwnd) clng(SNDMSG((hwnd), PGM_GETBORDER, 0, 0))
#define PGM_SETPOS (PGM_FIRST + 8)
#define Pager_SetPos(hwnd, iPos) clng(SNDMSG((hwnd), PGM_SETPOS, 0, cast(LPARAM, (iPos))))
#define PGM_GETPOS (PGM_FIRST + 9)
#define Pager_GetPos(hwnd) clng(SNDMSG((hwnd), PGM_GETPOS, 0, 0))
#define PGM_SETBUTTONSIZE (PGM_FIRST + 10)
#define Pager_SetButtonSize(hwnd, iSize) clng(SNDMSG((hwnd), PGM_SETBUTTONSIZE, 0, cast(LPARAM, (iSize))))
#define PGM_GETBUTTONSIZE (PGM_FIRST + 11)
#define Pager_GetButtonSize(hwnd) clng(SNDMSG((hwnd), PGM_GETBUTTONSIZE, 0, 0))
#define PGM_GETBUTTONSTATE (PGM_FIRST + 12)
#define Pager_GetButtonState(hwnd, iButton) cast(DWORD, SNDMSG((hwnd), PGM_GETBUTTONSTATE, 0, cast(LPARAM, (iButton))))
#define PGM_GETDROPTARGET CCM_GETDROPTARGET
#define Pager_GetDropTarget(hwnd, ppdt) SNDMSG((hwnd), PGM_GETDROPTARGET, 0, cast(LPARAM, (ppdt)))
#define PGN_SCROLL culng(PGN_FIRST - 1)
#define PGF_SCROLLUP 1
#define PGF_SCROLLDOWN 2
#define PGF_SCROLLLEFT 4
#define PGF_SCROLLRIGHT 8
#define PGK_SHIFT 1
#define PGK_CONTROL 2
#define PGK_MENU 4

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
#define PGN_CALCSIZE culng(PGN_FIRST - 2)
#define PGF_CALCWIDTH 1
#define PGF_CALCHEIGHT 2

type NMPGCALCSIZE
	hdr as NMHDR
	dwFlag as DWORD
	iWidth as long
	iHeight as long
end type

type LPNMPGCALCSIZE as NMPGCALCSIZE ptr
#define PGN_HOTITEMCHANGE culng(PGN_FIRST - 3)

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

#define NFS_EDIT &h1
#define NFS_STATIC &h2
#define NFS_LISTCOMBO &h4
#define NFS_BUTTON &h8
#define NFS_ALL &h10
#define NFS_USEFONTASSOC &h20
#define WC_BUTTONA "Button"
#define WC_BUTTONW wstr("Button")

#ifdef UNICODE
	#define WC_BUTTON WC_BUTTONW
#else
	#define WC_BUTTON WC_BUTTONA
#endif

#define BUTTON_IMAGELIST_ALIGN_LEFT 0
#define BUTTON_IMAGELIST_ALIGN_RIGHT 1
#define BUTTON_IMAGELIST_ALIGN_TOP 2
#define BUTTON_IMAGELIST_ALIGN_BOTTOM 3
#define BUTTON_IMAGELIST_ALIGN_CENTER 4

type BUTTON_IMAGELIST
	himl as HIMAGELIST
	margin as RECT
	uAlign as UINT
end type

type PBUTTON_IMAGELIST as BUTTON_IMAGELIST ptr
#define BCM_GETIDEALSIZE (BCM_FIRST + &h1)
#define Button_GetIdealSize(hwnd, psize) cast(WINBOOL, SNDMSG((hwnd), BCM_GETIDEALSIZE, 0, cast(LPARAM, (psize))))
#define BCM_SETIMAGELIST (BCM_FIRST + &h2)
#define Button_SetImageList(hwnd, pbuttonImagelist) cast(WINBOOL, SNDMSG((hwnd), BCM_SETIMAGELIST, 0, cast(LPARAM, (pbuttonImagelist))))
#define BCM_GETIMAGELIST (BCM_FIRST + &h3)
#define Button_GetImageList(hwnd, pbuttonImagelist) cast(WINBOOL, SNDMSG((hwnd), BCM_GETIMAGELIST, 0, cast(LPARAM, (pbuttonImagelist))))
#define BCM_SETTEXTMARGIN (BCM_FIRST + &h4)
#define Button_SetTextMargin(hwnd, pmargin) cast(WINBOOL, SNDMSG((hwnd), BCM_SETTEXTMARGIN, 0, cast(LPARAM, (pmargin))))
#define BCM_GETTEXTMARGIN (BCM_FIRST + &h5)
#define Button_GetTextMargin(hwnd, pmargin) cast(WINBOOL, SNDMSG((hwnd), BCM_GETTEXTMARGIN, 0, cast(LPARAM, (pmargin))))
#define BCM_SETNOTE (BCM_FIRST + &h9)
#define Button_SetNote(hwnd, psz) cast(WINBOOL, SNDMSG((hwnd), BCM_SETNOTE, 0, cast(LPARAM, (psz))))
#define BCM_GETNOTE (BCM_FIRST + &ha)
#define Button_GetNote(hwnd, psz, pcc) cast(WINBOOL, SNDMSG((hwnd), BCM_GETNOTE, cast(WPARAM, pcc), cast(LPARAM, psz)))
#define BCM_GETNOTELENGTH (BCM_FIRST + &hb)
#define Button_GetNoteLength(hwnd) cast(LRESULT, SNDMSG((hwnd), BCM_GETNOTELENGTH, 0, 0))
#define BCM_SETSHIELD (BCM_FIRST + &hc)
#define Button_SetElevationRequiredState(hwnd, fRequired) cast(LRESULT, SNDMSG((hwnd), BCM_SETSHIELD, 0, cast(LPARAM, fRequired)))
#define BCM_SETDROPDOWNSTATE (BCM_FIRST + &h6)
#define Button_SetDropDownState(hwnd, fDropDown) cast(WINBOOL, SNDMSG((hwnd), BCM_SETDROPDOWNSTATE, cast(WPARAM, fDropDown), 0))
#define BCM_SETSPLITINFO (BCM_FIRST + &h7)
#define Button_SetSplitInfo(hwnd, psi) cast(WINBOOL, SNDMSG((hwnd), BCM_SETSPLITINFO, 0, cast(LPARAM, psi)))
#define BCM_GETSPLITINFO (BCM_FIRST + &h8)
#define Button_GetSplitInfo(hwnd, psi) cast(WINBOOL, SNDMSG((hwnd), BCM_GETSPLITINFO, 0, cast(LPARAM, psi)))

type tagNMBCHOTITEM
	hdr as NMHDR
	dwFlags as DWORD
end type

type NMBCHOTITEM as tagNMBCHOTITEM
type LPNMBCHOTITEM as tagNMBCHOTITEM ptr
#define BCN_HOTITEMCHANGE culng(BCN_FIRST + &h1)
#define BST_HOT &h200
#define BS_SPLITBUTTON &hc
#define BS_DEFSPLITBUTTON &hd
#define BS_COMMANDLINK &he
#define BS_DEFCOMMANDLINK &hf
#define BST_DROPDOWNPUSHED &h400
#define BCSIF_GLYPH &h1
#define BCSIF_IMAGE &h2
#define BCSIF_STYLE &h4
#define BCSIF_SIZE &h8
#define BCSS_NOSPLIT &h1
#define BCSS_STRETCH &h2
#define BCSS_ALIGNLEFT &h4
#define BCSS_IMAGE &h8
#define BCN_DROPDOWN culng(BCN_FIRST + &h2)
#define BCCL_NOGLYPH cast(HIMAGELIST, cuint(-1))

type tagBUTTON_SPLITINFO
	mask as UINT
	himlGlyph as HIMAGELIST
	uSplitStyle as UINT
	size as SIZE
end type

type BUTTON_SPLITINFO as tagBUTTON_SPLITINFO
type PBUTTON_SPLITINFO as tagBUTTON_SPLITINFO ptr
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

#define EM_SETCUEBANNER (ECM_FIRST + 1)
#define Edit_SetCueBannerText(hwnd, lpcwText) cast(WINBOOL, SNDMSG((hwnd), EM_SETCUEBANNER, 0, cast(LPARAM, (lpcwText))))
#define EM_GETCUEBANNER (ECM_FIRST + 2)
#define Edit_GetCueBannerText(hwnd, lpwText, cchText) cast(WINBOOL, SNDMSG((hwnd), EM_GETCUEBANNER, cast(WPARAM, (lpwText)), cast(LPARAM, (cchText))))

type _tagEDITBALLOONTIP
	cbStruct as DWORD
	pszTitle as LPCWSTR
	pszText as LPCWSTR
	ttiIcon as INT_
end type

type EDITBALLOONTIP as _tagEDITBALLOONTIP
type PEDITBALLOONTIP as _tagEDITBALLOONTIP ptr
#define EM_SHOWBALLOONTIP (ECM_FIRST + 3)
#define Edit_ShowBalloonTip(hwnd, peditballoontip) cast(WINBOOL, SNDMSG((hwnd), EM_SHOWBALLOONTIP, 0, cast(LPARAM, (peditballoontip))))
#define EM_HIDEBALLOONTIP (ECM_FIRST + 4)
#define Edit_HideBalloonTip(hwnd) cast(WINBOOL, SNDMSG((hwnd), EM_HIDEBALLOONTIP, 0, 0))
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

#define CB_SETMINVISIBLE (CBM_FIRST + 1)
#define CB_GETMINVISIBLE (CBM_FIRST + 2)
#define ComboBox_SetMinVisible(hwnd, iMinVisible) cast(WINBOOL, SNDMSG((hwnd), CB_SETMINVISIBLE, cast(WPARAM, iMinVisible), 0))
#define ComboBox_GetMinVisible(hwnd) clng(SNDMSG((hwnd), CB_GETMINVISIBLE, 0, 0))
#define WC_SCROLLBARA "ScrollBar"
#define WC_SCROLLBARW wstr("ScrollBar")

#ifdef UNICODE
	#define WC_SCROLLBAR WC_SCROLLBARW
#else
	#define WC_SCROLLBAR WC_SCROLLBARA
#endif

#define INVALID_LINK_INDEX (-1)
#define MAX_LINKID_TEXT 48
#define L_MAX_URL_LENGTH ((2048 + 32) + sizeof("://"))
#define WC_LINK wstr("SysLink")
#define LWS_TRANSPARENT &h1
#define LWS_IGNORERETURN &h2
#define LIF_ITEMINDEX &h1
#define LIF_STATE &h2
#define LIF_ITEMID &h4
#define LIF_URL &h8
#define LIS_FOCUSED &h1
#define LIS_ENABLED &h2
#define LIS_VISITED &h4

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
#define LM_HITTEST (WM_USER + &h300)
#define LM_GETIDEALHEIGHT (WM_USER + &h301)
#define LM_SETITEM (WM_USER + &h302)
#define LM_GETITEM (WM_USER + &h303)
declare sub InitMUILanguage(byval uiLang as LANGID)
declare function GetMUILanguage() as LANGID
#define DA_LAST &h7fffffff
#define DPA_APPEND &h7fffffff
#define DPA_ERR (-1)
#define DSA_APPEND &h7fffffff
#define DSA_ERR (-1)

type HDSA as _DSA ptr
type PFNDPAENUMCALLBACK as function(byval p as any ptr, byval pData as any ptr) as long
type PFNDSAENUMCALLBACK as function(byval p as any ptr, byval pData as any ptr) as long

declare function DSA_Create(byval cbItem as long, byval cItemGrow as long) as HDSA
declare function DSA_Destroy(byval hdsa as HDSA) as WINBOOL
declare sub DSA_DestroyCallback(byval hdsa as HDSA, byval pfnCB as PFNDSAENUMCALLBACK, byval pData as any ptr)
declare function DSA_GetItemPtr(byval hdsa as HDSA, byval i as long) as PVOID
declare function DSA_InsertItem(byval hdsa as HDSA, byval i as long, byval pitem as any ptr) as long
type HDPA as _DPA ptr
declare function DPA_Create(byval cItemGrow as long) as HDPA
declare function DPA_Destroy(byval hdpa as HDPA) as WINBOOL
declare function DPA_DeletePtr(byval hdpa as HDPA, byval i as long) as PVOID
declare function DPA_DeleteAllPtrs(byval hdpa as HDPA) as WINBOOL
declare sub DPA_EnumCallback(byval hdpa as HDPA, byval pfnCB as PFNDPAENUMCALLBACK, byval pData as any ptr)
declare sub DPA_DestroyCallback(byval hdpa as HDPA, byval pfnCB as PFNDPAENUMCALLBACK, byval pData as any ptr)
declare function DPA_SetPtr(byval hdpa as HDPA, byval i as long, byval p as any ptr) as WINBOOL
declare function DPA_InsertPtr(byval hdpa as HDPA, byval i as long, byval p as any ptr) as long
declare function DPA_GetPtr(byval hdpa as HDPA, byval i as INT_PTR) as PVOID
type PFNDPACOMPARE as function(byval p1 as any ptr, byval p2 as any ptr, byval lParam as LPARAM) as long
declare function DPA_Sort(byval hdpa as HDPA, byval pfnCompare as PFNDPACOMPARE, byval lParam as LPARAM) as WINBOOL

#define DPAS_SORTED &h1
#define DPAS_INSERTBEFORE &h2
#define DPAS_INSERTAFTER &h4
declare function DPA_Search(byval hdpa as HDPA, byval pFind as any ptr, byval iStart as long, byval pfnCompare as PFNDPACOMPARE, byval lParam as LPARAM, byval options as UINT) as long
declare function Str_SetPtrW(byval ppsz as LPWSTR ptr, byval psz as LPCWSTR) as WINBOOL

type _DPASTREAMINFO
	iPos as long
	pvItem as any ptr
end type

type DPASTREAMINFO as _DPASTREAMINFO
type PFNDPASTREAM as function(byval as DPASTREAMINFO ptr, byval as IStream ptr, byval as any ptr) as HRESULT
type PFNDPAMERGE as function(byval as UINT, byval as any ptr, byval as any ptr, byval as LPARAM) as any ptr
type PFNDPAMERGECONST as function(byval as UINT, byval as const any ptr, byval as const any ptr, byval as LPARAM) as const any ptr

declare function DPA_LoadStream(byval phdpa as HDPA ptr, byval pfn as PFNDPASTREAM, byval pstream as IStream ptr, byval pvInstData as any ptr) as HRESULT
declare function DPA_SaveStream(byval hdpa as HDPA, byval pfn as PFNDPASTREAM, byval pstream as IStream ptr, byval pvInstData as any ptr) as HRESULT
declare function DPA_Grow(byval pdpa as HDPA, byval cp as long) as WINBOOL
declare function DPA_GetPtrIndex(byval hdpa as HDPA, byval p as const any ptr) as long

#define DPA_GetPtrCount(hdpa) (*cptr(long ptr, (hdpa)))
#define DPA_SetPtrCount(hdpa, cItems) scope : *cptr(long ptr, (hdpa)) = (cItems) : end scope
#define DPA_GetPtrPtr(hdpa) (*cptr(any ptr ptr ptr, cptr(UBYTE ptr, (hdpa)) + sizeof(any ptr)))
#define DPA_AppendPtr(hdpa, pitem) DPA_InsertPtr(hdpa, DA_LAST, pitem)
#define DPA_FastDeleteLastPtr(hdpa) scope : *cptr(long ptr, (hdpa)) -= 1 : end scope
#define DPA_FastGetPtr(hdpa, i) DPA_GetPtrPtr(hdpa)[i]
#define DPAM_SORTED 1
#define DPAM_NORMAL 2
#define DPAM_UNION 4
#define DPAM_INTERSECT 8
#define DPAMM_MERGE 1
#define DPAMM_DELETE 2
#define DPAMM_INSERT 3
declare function _TrackMouseEvent(byval lpEventTrack as LPTRACKMOUSEEVENT) as WINBOOL
#define WSB_PROP_CYVSCROLL __MSABI_LONG(&h1)
#define WSB_PROP_CXHSCROLL __MSABI_LONG(&h2)
#define WSB_PROP_CYHSCROLL __MSABI_LONG(&h4)
#define WSB_PROP_CXVSCROLL __MSABI_LONG(&h8)
#define WSB_PROP_CXHTHUMB __MSABI_LONG(&h10)
#define WSB_PROP_CYVTHUMB __MSABI_LONG(&h20)
#define WSB_PROP_VBKGCOLOR __MSABI_LONG(&h40)
#define WSB_PROP_HBKGCOLOR __MSABI_LONG(&h80)
#define WSB_PROP_VSTYLE __MSABI_LONG(&h100)
#define WSB_PROP_HSTYLE __MSABI_LONG(&h200)
#define WSB_PROP_WINSTYLE __MSABI_LONG(&h400)
#define WSB_PROP_PALETTE __MSABI_LONG(&h800)
#define WSB_PROP_MASK __MSABI_LONG(&hfff)
#define FSB_FLAT_MODE 2
#define FSB_ENCARTA_MODE 1
#define FSB_REGULAR_MODE 0

declare function FlatSB_EnableScrollBar(byval as HWND, byval as long, byval as UINT) as WINBOOL
declare function FlatSB_ShowScrollBar(byval as HWND, byval code as long, byval as WINBOOL) as WINBOOL
declare function FlatSB_GetScrollRange(byval as HWND, byval code as long, byval as LPINT, byval as LPINT) as WINBOOL
declare function FlatSB_GetScrollInfo(byval as HWND, byval code as long, byval as LPSCROLLINFO) as WINBOOL
declare function FlatSB_GetScrollPos(byval as HWND, byval code as long) as long
declare function FlatSB_GetScrollProp(byval as HWND, byval propIndex as long, byval as LPINT) as WINBOOL

#ifdef __FB_64BIT__
	declare function FlatSB_GetScrollPropPtr(byval as HWND, byval propIndex as long, byval as PINT_PTR) as WINBOOL
#else
	#define FlatSB_GetScrollPropPtr FlatSB_GetScrollProp
#endif

declare function FlatSB_SetScrollPos(byval as HWND, byval code as long, byval pos as long, byval fRedraw as WINBOOL) as long
declare function FlatSB_SetScrollInfo(byval as HWND, byval code as long, byval as LPSCROLLINFO, byval fRedraw as WINBOOL) as long
declare function FlatSB_SetScrollRange(byval as HWND, byval code as long, byval min as long, byval max as long, byval fRedraw as WINBOOL) as long
declare function FlatSB_SetScrollProp(byval as HWND, byval index as UINT, byval newValue as INT_PTR, byval as WINBOOL) as WINBOOL
#define FlatSB_SetScrollPropPtr FlatSB_SetScrollProp
declare function InitializeFlatSB(byval as HWND) as WINBOOL
declare function UninitializeFlatSB(byval as HWND) as HRESULT
type SUBCLASSPROC as function(byval hWnd as HWND, byval uMsg as UINT, byval wParam as WPARAM, byval lParam as LPARAM, byval uIdSubclass as UINT_PTR, byval dwRefData as DWORD_PTR) as LRESULT
declare function SetWindowSubclass(byval hWnd as HWND, byval pfnSubclass as SUBCLASSPROC, byval uIdSubclass as UINT_PTR, byval dwRefData as DWORD_PTR) as WINBOOL
declare function GetWindowSubclass(byval hWnd as HWND, byval pfnSubclass as SUBCLASSPROC, byval uIdSubclass as UINT_PTR, byval pdwRefData as DWORD_PTR ptr) as WINBOOL
declare function RemoveWindowSubclass(byval hWnd as HWND, byval pfnSubclass as SUBCLASSPROC, byval uIdSubclass as UINT_PTR) as WINBOOL
declare function DefSubclassProc(byval hWnd as HWND, byval uMsg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT
declare function DrawShadowText(byval hdc as HDC, byval pszText as LPCWSTR, byval cch as UINT, byval prc as RECT ptr, byval dwFlags as DWORD, byval crText as COLORREF, byval crShadow as COLORREF, byval ixOffset as long, byval iyOffset as long) as long

end extern
