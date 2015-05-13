#pragma once

#inclib "ole32"

#include once "winapifamily.bi"
#include once "winerror.bi"
#include once "objbase.bi"
#include once "oleauto.bi"
#include once "oleidl.bi"

extern "Windows"

#define _OLE2_H_
#define E_DRAW VIEW_E_DRAW
#define DATA_E_FORMATETC DV_E_FORMATETC
#define OLEIVERB_PRIMARY __MSABI_LONG(0)
#define OLEIVERB_SHOW (-__MSABI_LONG(1))
#define OLEIVERB_OPEN (-__MSABI_LONG(2))
#define OLEIVERB_HIDE (-__MSABI_LONG(3))
#define OLEIVERB_UIACTIVATE (-__MSABI_LONG(4))
#define OLEIVERB_INPLACEACTIVATE (-__MSABI_LONG(5))
#define OLEIVERB_DISCARDUNDOSTATE (-__MSABI_LONG(6))
#define EMBDHLP_INPROC_HANDLER __MSABI_LONG(&h0000)
#define EMBDHLP_INPROC_SERVER __MSABI_LONG(&h0001)
#define EMBDHLP_CREATENOW __MSABI_LONG(&h00000000)
#define EMBDHLP_DELAYCREATE __MSABI_LONG(&h00010000)
const OLECREATE_LEAVERUNNING = &h1

declare function OleBuildVersion() as DWORD
declare function ReadClassStg(byval pStg as LPSTORAGE, byval pclsid as CLSID ptr) as HRESULT
declare function WriteClassStg(byval pStg as LPSTORAGE, byval rclsid as const IID const ptr) as HRESULT
declare function ReadClassStm(byval pStm as LPSTREAM, byval pclsid as CLSID ptr) as HRESULT
declare function WriteClassStm(byval pStm as LPSTREAM, byval rclsid as const IID const ptr) as HRESULT
declare function WriteFmtUserTypeStg(byval pstg as LPSTORAGE, byval cf as CLIPFORMAT, byval lpszUserType as LPOLESTR) as HRESULT
declare function ReadFmtUserTypeStg(byval pstg as LPSTORAGE, byval pcf as CLIPFORMAT ptr, byval lplpszUserType as LPOLESTR ptr) as HRESULT
declare function OleInitialize(byval pvReserved as LPVOID) as HRESULT
declare sub OleUninitialize()
declare function OleQueryLinkFromData(byval pSrcDataObject as LPDATAOBJECT) as HRESULT
declare function OleQueryCreateFromData(byval pSrcDataObject as LPDATAOBJECT) as HRESULT
declare function OleCreate(byval rclsid as const IID const ptr, byval riid as const IID const ptr, byval renderopt as DWORD, byval pFormatEtc as LPFORMATETC, byval pClientSite as LPOLECLIENTSITE, byval pStg as LPSTORAGE, byval ppvObj as LPVOID ptr) as HRESULT
declare function OleCreateEx(byval rclsid as const IID const ptr, byval riid as const IID const ptr, byval dwFlags as DWORD, byval renderopt as DWORD, byval cFormats as ULONG, byval rgAdvf as DWORD ptr, byval rgFormatEtc as LPFORMATETC, byval lpAdviseSink as IAdviseSink ptr, byval rgdwConnection as DWORD ptr, byval pClientSite as LPOLECLIENTSITE, byval pStg as LPSTORAGE, byval ppvObj as LPVOID ptr) as HRESULT
declare function OleCreateFromData(byval pSrcDataObj as LPDATAOBJECT, byval riid as const IID const ptr, byval renderopt as DWORD, byval pFormatEtc as LPFORMATETC, byval pClientSite as LPOLECLIENTSITE, byval pStg as LPSTORAGE, byval ppvObj as LPVOID ptr) as HRESULT
declare function OleCreateFromDataEx(byval pSrcDataObj as LPDATAOBJECT, byval riid as const IID const ptr, byval dwFlags as DWORD, byval renderopt as DWORD, byval cFormats as ULONG, byval rgAdvf as DWORD ptr, byval rgFormatEtc as LPFORMATETC, byval lpAdviseSink as IAdviseSink ptr, byval rgdwConnection as DWORD ptr, byval pClientSite as LPOLECLIENTSITE, byval pStg as LPSTORAGE, byval ppvObj as LPVOID ptr) as HRESULT
declare function OleCreateLinkFromData(byval pSrcDataObj as LPDATAOBJECT, byval riid as const IID const ptr, byval renderopt as DWORD, byval pFormatEtc as LPFORMATETC, byval pClientSite as LPOLECLIENTSITE, byval pStg as LPSTORAGE, byval ppvObj as LPVOID ptr) as HRESULT
declare function OleCreateLinkFromDataEx(byval pSrcDataObj as LPDATAOBJECT, byval riid as const IID const ptr, byval dwFlags as DWORD, byval renderopt as DWORD, byval cFormats as ULONG, byval rgAdvf as DWORD ptr, byval rgFormatEtc as LPFORMATETC, byval lpAdviseSink as IAdviseSink ptr, byval rgdwConnection as DWORD ptr, byval pClientSite as LPOLECLIENTSITE, byval pStg as LPSTORAGE, byval ppvObj as LPVOID ptr) as HRESULT
declare function OleCreateStaticFromData(byval pSrcDataObj as LPDATAOBJECT, byval iid as const IID const ptr, byval renderopt as DWORD, byval pFormatEtc as LPFORMATETC, byval pClientSite as LPOLECLIENTSITE, byval pStg as LPSTORAGE, byval ppvObj as LPVOID ptr) as HRESULT
declare function OleCreateLink(byval pmkLinkSrc as LPMONIKER, byval riid as const IID const ptr, byval renderopt as DWORD, byval lpFormatEtc as LPFORMATETC, byval pClientSite as LPOLECLIENTSITE, byval pStg as LPSTORAGE, byval ppvObj as LPVOID ptr) as HRESULT
declare function OleCreateLinkEx(byval pmkLinkSrc as LPMONIKER, byval riid as const IID const ptr, byval dwFlags as DWORD, byval renderopt as DWORD, byval cFormats as ULONG, byval rgAdvf as DWORD ptr, byval rgFormatEtc as LPFORMATETC, byval lpAdviseSink as IAdviseSink ptr, byval rgdwConnection as DWORD ptr, byval pClientSite as LPOLECLIENTSITE, byval pStg as LPSTORAGE, byval ppvObj as LPVOID ptr) as HRESULT
declare function OleCreateLinkToFile(byval lpszFileName as LPCOLESTR, byval riid as const IID const ptr, byval renderopt as DWORD, byval lpFormatEtc as LPFORMATETC, byval pClientSite as LPOLECLIENTSITE, byval pStg as LPSTORAGE, byval ppvObj as LPVOID ptr) as HRESULT
declare function OleCreateLinkToFileEx(byval lpszFileName as LPCOLESTR, byval riid as const IID const ptr, byval dwFlags as DWORD, byval renderopt as DWORD, byval cFormats as ULONG, byval rgAdvf as DWORD ptr, byval rgFormatEtc as LPFORMATETC, byval lpAdviseSink as IAdviseSink ptr, byval rgdwConnection as DWORD ptr, byval pClientSite as LPOLECLIENTSITE, byval pStg as LPSTORAGE, byval ppvObj as LPVOID ptr) as HRESULT
declare function OleCreateFromFile(byval rclsid as const IID const ptr, byval lpszFileName as LPCOLESTR, byval riid as const IID const ptr, byval renderopt as DWORD, byval lpFormatEtc as LPFORMATETC, byval pClientSite as LPOLECLIENTSITE, byval pStg as LPSTORAGE, byval ppvObj as LPVOID ptr) as HRESULT
declare function OleCreateFromFileEx(byval rclsid as const IID const ptr, byval lpszFileName as LPCOLESTR, byval riid as const IID const ptr, byval dwFlags as DWORD, byval renderopt as DWORD, byval cFormats as ULONG, byval rgAdvf as DWORD ptr, byval rgFormatEtc as LPFORMATETC, byval lpAdviseSink as IAdviseSink ptr, byval rgdwConnection as DWORD ptr, byval pClientSite as LPOLECLIENTSITE, byval pStg as LPSTORAGE, byval ppvObj as LPVOID ptr) as HRESULT
declare function OleLoad(byval pStg as LPSTORAGE, byval riid as const IID const ptr, byval pClientSite as LPOLECLIENTSITE, byval ppvObj as LPVOID ptr) as HRESULT
declare function OleSave(byval pPS as LPPERSISTSTORAGE, byval pStg as LPSTORAGE, byval fSameAsLoad as WINBOOL) as HRESULT
declare function OleLoadFromStream(byval pStm as LPSTREAM, byval iidInterface as const IID const ptr, byval ppvObj as LPVOID ptr) as HRESULT
declare function OleSaveToStream(byval pPStm as LPPERSISTSTREAM, byval pStm as LPSTREAM) as HRESULT
declare function OleSetContainedObject(byval pUnknown as LPUNKNOWN, byval fContained as WINBOOL) as HRESULT
declare function OleNoteObjectVisible(byval pUnknown as LPUNKNOWN, byval fVisible as WINBOOL) as HRESULT
declare function RegisterDragDrop(byval hwnd as HWND, byval pDropTarget as LPDROPTARGET) as HRESULT
declare function RevokeDragDrop(byval hwnd as HWND) as HRESULT
declare function DoDragDrop(byval pDataObj as LPDATAOBJECT, byval pDropSource as LPDROPSOURCE, byval dwOKEffects as DWORD, byval pdwEffect as LPDWORD) as HRESULT
declare function OleSetClipboard(byval pDataObj as LPDATAOBJECT) as HRESULT
declare function OleGetClipboard(byval ppDataObj as LPDATAOBJECT ptr) as HRESULT
declare function OleFlushClipboard() as HRESULT
declare function OleIsCurrentClipboard(byval pDataObj as LPDATAOBJECT) as HRESULT
declare function OleCreateMenuDescriptor(byval hmenuCombined as HMENU, byval lpMenuWidths as LPOLEMENUGROUPWIDTHS) as HOLEMENU
declare function OleSetMenuDescriptor(byval holemenu as HOLEMENU, byval hwndFrame as HWND, byval hwndActiveObject as HWND, byval lpFrame as LPOLEINPLACEFRAME, byval lpActiveObj as LPOLEINPLACEACTIVEOBJECT) as HRESULT
declare function OleDestroyMenuDescriptor(byval holemenu as HOLEMENU) as HRESULT
declare function OleTranslateAccelerator(byval lpFrame as LPOLEINPLACEFRAME, byval lpFrameInfo as LPOLEINPLACEFRAMEINFO, byval lpmsg as LPMSG) as HRESULT
declare function OleDuplicateData(byval hSrc as HANDLE, byval cfFormat as CLIPFORMAT, byval uiFlags as UINT) as HANDLE
declare function OleDraw(byval pUnknown as LPUNKNOWN, byval dwAspect as DWORD, byval hdcDraw as HDC, byval lprcBounds as LPCRECT) as HRESULT
declare function OleRun(byval pUnknown as LPUNKNOWN) as HRESULT
declare function OleIsRunning(byval pObject as LPOLEOBJECT) as WINBOOL
declare function OleLockRunning(byval pUnknown as LPUNKNOWN, byval fLock as WINBOOL, byval fLastUnlockCloses as WINBOOL) as HRESULT
declare sub ReleaseStgMedium(byval as LPSTGMEDIUM)
declare function CreateOleAdviseHolder(byval ppOAHolder as LPOLEADVISEHOLDER ptr) as HRESULT
declare function OleCreateDefaultHandler(byval clsid as const IID const ptr, byval pUnkOuter as LPUNKNOWN, byval riid as const IID const ptr, byval lplpObj as LPVOID ptr) as HRESULT
declare function OleCreateEmbeddingHelper(byval clsid as const IID const ptr, byval pUnkOuter as LPUNKNOWN, byval flags as DWORD, byval pCF as LPCLASSFACTORY, byval riid as const IID const ptr, byval lplpObj as LPVOID ptr) as HRESULT
declare function IsAccelerator(byval hAccel as HACCEL, byval cAccelEntries as long, byval lpMsg as LPMSG, byval lpwCmd as WORD ptr) as WINBOOL
declare function OleGetIconOfFile(byval lpszPath as LPOLESTR, byval fUseFileAsLabel as WINBOOL) as HGLOBAL
declare function OleGetIconOfClass(byval rclsid as const IID const ptr, byval lpszLabel as LPOLESTR, byval fUseTypeAsLabel as WINBOOL) as HGLOBAL
declare function OleMetafilePictFromIconAndLabel(byval hIcon as HICON, byval lpszLabel as LPOLESTR, byval lpszSourceFile as LPOLESTR, byval iIconIndex as UINT) as HGLOBAL
declare function OleRegGetUserType(byval clsid as const IID const ptr, byval dwFormOfType as DWORD, byval pszUserType as LPOLESTR ptr) as HRESULT
declare function OleRegGetMiscStatus(byval clsid as const IID const ptr, byval dwAspect as DWORD, byval pdwStatus as DWORD ptr) as HRESULT
declare function OleRegEnumFormatEtc(byval clsid as const IID const ptr, byval dwDirection as DWORD, byval ppenum as LPENUMFORMATETC ptr) as HRESULT
declare function OleRegEnumVerbs(byval clsid as const IID const ptr, byval ppenum as LPENUMOLEVERB ptr) as HRESULT
type LPOLESTREAM as _OLESTREAM ptr

type _OLESTREAMVTBL
	Get as function(byval as LPOLESTREAM, byval as any ptr, byval as DWORD) as DWORD
	Put as function(byval as LPOLESTREAM, byval as const any ptr, byval as DWORD) as DWORD
end type

type OLESTREAMVTBL as _OLESTREAMVTBL
type LPOLESTREAMVTBL as OLESTREAMVTBL ptr

type _OLESTREAM
	lpstbl as LPOLESTREAMVTBL
end type

type OLESTREAM as _OLESTREAM
declare function OleConvertOLESTREAMToIStorage(byval lpolestream as LPOLESTREAM, byval pstg as LPSTORAGE, byval ptd as const DVTARGETDEVICE ptr) as HRESULT
declare function OleConvertIStorageToOLESTREAM(byval pstg as LPSTORAGE, byval lpolestream as LPOLESTREAM) as HRESULT
declare function GetHGlobalFromILockBytes(byval plkbyt as LPLOCKBYTES, byval phglobal as HGLOBAL ptr) as HRESULT
declare function CreateILockBytesOnHGlobal(byval hGlobal as HGLOBAL, byval fDeleteOnRelease as WINBOOL, byval pplkbyt as LPLOCKBYTES ptr) as HRESULT
declare function OleDoAutoConvert(byval pStg as LPSTORAGE, byval pClsidNew as LPCLSID) as HRESULT
declare function OleGetAutoConvert(byval clsidOld as const IID const ptr, byval pClsidNew as LPCLSID) as HRESULT
declare function OleSetAutoConvert(byval clsidOld as const IID const ptr, byval clsidNew as const IID const ptr) as HRESULT
declare function GetConvertStg(byval pStg as LPSTORAGE) as HRESULT
declare function SetConvertStg(byval pStg as LPSTORAGE, byval fConvert as WINBOOL) as HRESULT
declare function OleConvertIStorageToOLESTREAMEx(byval pstg as LPSTORAGE, byval cfFormat as CLIPFORMAT, byval lWidth as LONG, byval lHeight as LONG, byval dwSize as DWORD, byval pmedium as LPSTGMEDIUM, byval polestm as LPOLESTREAM) as HRESULT
declare function OleConvertOLESTREAMToIStorageEx(byval polestm as LPOLESTREAM, byval pstg as LPSTORAGE, byval pcfFormat as CLIPFORMAT ptr, byval plwWidth as LONG ptr, byval plHeight as LONG ptr, byval pdwSize as DWORD ptr, byval pmedium as LPSTGMEDIUM) as HRESULT

end extern
