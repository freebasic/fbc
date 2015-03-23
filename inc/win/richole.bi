#pragma once

#inclib "uuid"

#include once "richedit.bi"

extern "Windows"

#define _RICHOLE_

type _reobject
	cbStruct as DWORD
	cp as LONG
	clsid as CLSID
	poleobj as LPOLEOBJECT
	pstg as LPSTORAGE
	polesite as LPOLECLIENTSITE
	sizel as SIZEL
	dvaspect as DWORD
	dwFlags as DWORD
	dwUser as DWORD
end type

type REOBJECT as _reobject
#define REO_GETOBJ_NO_INTERFACES __MSABI_LONG(&h00000000)
#define REO_GETOBJ_POLEOBJ __MSABI_LONG(&h00000001)
#define REO_GETOBJ_PSTG __MSABI_LONG(&h00000002)
#define REO_GETOBJ_POLESITE __MSABI_LONG(&h00000004)
#define REO_GETOBJ_ALL_INTERFACES __MSABI_LONG(&h00000007)
#define REO_CP_SELECTION cast(ULONG, -1)
#define REO_IOB_SELECTION cast(ULONG, -1)
#define REO_IOB_USE_CP cast(ULONG, -2)
#define REO_NULL __MSABI_LONG(&h00000000)
#define REO_READWRITEMASK __MSABI_LONG(&h0000003F)
#define REO_DONTNEEDPALETTE __MSABI_LONG(&h00000020)
#define REO_BLANK __MSABI_LONG(&h00000010)
#define REO_DYNAMICSIZE __MSABI_LONG(&h00000008)
#define REO_INVERTEDSELECT __MSABI_LONG(&h00000004)
#define REO_BELOWBASELINE __MSABI_LONG(&h00000002)
#define REO_RESIZABLE __MSABI_LONG(&h00000001)
#define REO_LINK __MSABI_LONG(&h80000000)
#define REO_STATIC __MSABI_LONG(&h40000000)
#define REO_SELECTED __MSABI_LONG(&h08000000)
#define REO_OPEN __MSABI_LONG(&h04000000)
#define REO_INPLACEACTIVE __MSABI_LONG(&h02000000)
#define REO_HILITED __MSABI_LONG(&h01000000)
#define REO_LINKAVAILABLE __MSABI_LONG(&h00800000)
#define REO_GETMETAFILE __MSABI_LONG(&h00400000)
#define RECO_PASTE __MSABI_LONG(&h00000000)
#define RECO_DROP __MSABI_LONG(&h00000001)
#define RECO_COPY __MSABI_LONG(&h00000002)
#define RECO_CUT __MSABI_LONG(&h00000003)
#define RECO_DRAG __MSABI_LONG(&h00000004)
type IRichEditOleVtbl as IRichEditOleVtbl_

type IRichEditOle
	lpVtbl as IRichEditOleVtbl ptr
end type

type IRichEditOleVtbl_
	QueryInterface as function(byval This as IRichEditOle ptr, byval riid as const IID const ptr, byval lplpObj as LPVOID ptr) as HRESULT
	AddRef as function(byval This as IRichEditOle ptr) as ULONG
	Release as function(byval This as IRichEditOle ptr) as ULONG
	GetClientSite as function(byval This as IRichEditOle ptr, byval lplpolesite as LPOLECLIENTSITE ptr) as HRESULT
	GetObjectCount as function(byval This as IRichEditOle ptr) as LONG
	GetLinkCount as function(byval This as IRichEditOle ptr) as LONG
	GetObject as function(byval This as IRichEditOle ptr, byval iob as LONG, byval lpreobject as REOBJECT ptr, byval dwFlags as DWORD) as HRESULT
	InsertObject as function(byval This as IRichEditOle ptr, byval lpreobject as REOBJECT ptr) as HRESULT
	ConvertObject as function(byval This as IRichEditOle ptr, byval iob as LONG, byval rclsidNew as const IID const ptr, byval lpstrUserTypeNew as LPCSTR) as HRESULT
	ActivateAs as function(byval This as IRichEditOle ptr, byval rclsid as const IID const ptr, byval rclsidAs as const IID const ptr) as HRESULT
	SetHostNames as function(byval This as IRichEditOle ptr, byval lpstrContainerApp as LPCSTR, byval lpstrContainerObj as LPCSTR) as HRESULT
	SetLinkAvailable as function(byval This as IRichEditOle ptr, byval iob as LONG, byval fAvailable as WINBOOL) as HRESULT
	SetDvaspect as function(byval This as IRichEditOle ptr, byval iob as LONG, byval dvaspect as DWORD) as HRESULT
	HandsOffStorage as function(byval This as IRichEditOle ptr, byval iob as LONG) as HRESULT
	SaveCompleted as function(byval This as IRichEditOle ptr, byval iob as LONG, byval lpstg as LPSTORAGE) as HRESULT
	InPlaceDeactivate as function(byval This as IRichEditOle ptr) as HRESULT
	ContextSensitiveHelp as function(byval This as IRichEditOle ptr, byval fEnterMode as WINBOOL) as HRESULT
	GetClipboardData as function(byval This as IRichEditOle ptr, byval lpchrg as CHARRANGE ptr, byval reco as DWORD, byval lplpdataobj as LPDATAOBJECT ptr) as HRESULT
	ImportDataObject as function(byval This as IRichEditOle ptr, byval lpdataobj as LPDATAOBJECT, byval cf as CLIPFORMAT, byval hMetaPict as HGLOBAL) as HRESULT
end type

type LPRICHEDITOLE as IRichEditOle ptr
type IRichEditOleCallbackVtbl as IRichEditOleCallbackVtbl_

type IRichEditOleCallback
	lpVtbl as IRichEditOleCallbackVtbl ptr
end type

type IRichEditOleCallbackVtbl_
	QueryInterface as function(byval This as IRichEditOleCallback ptr, byval riid as const IID const ptr, byval lplpObj as LPVOID ptr) as HRESULT
	AddRef as function(byval This as IRichEditOleCallback ptr) as ULONG
	Release as function(byval This as IRichEditOleCallback ptr) as ULONG
	GetNewStorage as function(byval This as IRichEditOleCallback ptr, byval lplpstg as LPSTORAGE ptr) as HRESULT
	GetInPlaceContext as function(byval This as IRichEditOleCallback ptr, byval lplpFrame as LPOLEINPLACEFRAME ptr, byval lplpDoc as LPOLEINPLACEUIWINDOW ptr, byval lpFrameInfo as LPOLEINPLACEFRAMEINFO) as HRESULT
	ShowContainerUI as function(byval This as IRichEditOleCallback ptr, byval fShow as WINBOOL) as HRESULT
	QueryInsertObject as function(byval This as IRichEditOleCallback ptr, byval lpclsid as LPCLSID, byval lpstg as LPSTORAGE, byval cp as LONG) as HRESULT
	DeleteObject as function(byval This as IRichEditOleCallback ptr, byval lpoleobj as LPOLEOBJECT) as HRESULT
	QueryAcceptData as function(byval This as IRichEditOleCallback ptr, byval lpdataobj as LPDATAOBJECT, byval lpcfFormat as CLIPFORMAT ptr, byval reco as DWORD, byval fReally as WINBOOL, byval hMetaPict as HGLOBAL) as HRESULT
	ContextSensitiveHelp as function(byval This as IRichEditOleCallback ptr, byval fEnterMode as WINBOOL) as HRESULT
	GetClipboardData as function(byval This as IRichEditOleCallback ptr, byval lpchrg as CHARRANGE ptr, byval reco as DWORD, byval lplpdataobj as LPDATAOBJECT ptr) as HRESULT
	GetDragDropEffect as function(byval This as IRichEditOleCallback ptr, byval fDrag as WINBOOL, byval grfKeyState as DWORD, byval pdwEffect as LPDWORD) as HRESULT
	GetContextMenu as function(byval This as IRichEditOleCallback ptr, byval seltype as WORD, byval lpoleobj as LPOLEOBJECT, byval lpchrg as CHARRANGE ptr, byval lphmenu as HMENU ptr) as HRESULT
end type

type LPRICHEDITOLECALLBACK as IRichEditOleCallback ptr
extern IID_IRichEditOle as const GUID
extern IID_IRichEditOleCallback as const GUID

end extern
