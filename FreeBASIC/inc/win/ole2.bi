''
''
'' ole2 -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_ole2_bi__
#define __win_ole2_bi__

#inclib "ole32"

#include once "win/winerror.bi"
#include once "win/objbase.bi"
#include once "win/olectlid.bi"
#include once "win/oleauto.bi"

#define E_DRAW VIEW_E_DRAW
#define DATA_E_FORMATETC DV_E_FORMATETC
#define OLEIVERB_PRIMARY (0L)
#define OLEIVERB_SHOW (-1L)
#define OLEIVERB_OPEN (-2L)
#define OLEIVERB_HIDE (-3L)
#define OLEIVERB_UIACTIVATE (-4L)
#define OLEIVERB_INPLACEACTIVATE (-5L)
#define OLEIVERB_DISCARDUNDOSTATE (-6L)
#define EMBDHLP_INPROC_HANDLER &h0000L
#define EMBDHLP_INPROC_SERVER &h0001L
#define EMBDHLP_CREATENOW &h00000000L
#define EMBDHLP_DELAYCREATE &h00010000L

#include once "win/oleidl.bi"

type LPOLESTREAMVTBL as OLESTREAMVTBL ptr

type OLESTREAM
	lpstbl as LPOLESTREAMVTBL
end type

type LPOLESTREAM as OLESTREAM ptr

type OLESTREAMVTBL
	Get as function (byval as LPOLESTREAM, byval as any ptr, byval as DWORD) as DWORD
	Put as function (byval as LPOLESTREAM, byval as any ptr, byval as DWORD) as DWORD
end type

#ifndef CreateDataAdviseHolder
declare function CreateDataAdviseHolder alias "CreateDataAdviseHolder" (byval as LPDATAADVISEHOLDER ptr) as HRESULT
#endif
declare function OleBuildVersion alias "OleBuildVersion" () as DWORD
declare function ReadClassStg alias "ReadClassStg" (byval as LPSTORAGE, byval as CLSID ptr) as HRESULT
declare function WriteClassStg alias "WriteClassStg" (byval as LPSTORAGE, byval as CLSID ptr) as HRESULT
declare function ReadClassStm alias "ReadClassStm" (byval as LPSTREAM, byval as CLSID ptr) as HRESULT
declare function WriteClassStm alias "WriteClassStm" (byval as LPSTREAM, byval as CLSID ptr) as HRESULT
declare function WriteFmtUserTypeStg alias "WriteFmtUserTypeStg" (byval as LPSTORAGE, byval as CLIPFORMAT, byval as LPOLESTR) as HRESULT
declare function ReadFmtUserTypeStg alias "ReadFmtUserTypeStg" (byval as LPSTORAGE, byval as CLIPFORMAT ptr, byval as LPOLESTR ptr) as HRESULT
declare function OleInitialize alias "OleInitialize" (byval as PVOID) as HRESULT
declare sub OleUninitialize alias "OleUninitialize" ()
declare function OleQueryLinkFromData alias "OleQueryLinkFromData" (byval as LPDATAOBJECT) as HRESULT
declare function OleQueryCreateFromData alias "OleQueryCreateFromData" (byval as LPDATAOBJECT) as HRESULT
declare function OleCreate alias "OleCreate" (byval as CLSID ptr, byval as IID ptr, byval as DWORD, byval as LPFORMATETC, byval as LPOLECLIENTSITE, byval as LPSTORAGE, byval as PVOID ptr) as HRESULT
declare function OleCreateFromData alias "OleCreateFromData" (byval as LPDATAOBJECT, byval as IID ptr, byval as DWORD, byval as LPFORMATETC, byval as LPOLECLIENTSITE, byval as LPSTORAGE, byval as PVOID ptr) as HRESULT
declare function OleCreateLinkFromData alias "OleCreateLinkFromData" (byval as LPDATAOBJECT, byval as IID ptr, byval as DWORD, byval as LPFORMATETC, byval as LPOLECLIENTSITE, byval as LPSTORAGE, byval as PVOID ptr) as HRESULT
declare function OleCreateStaticFromData alias "OleCreateStaticFromData" (byval as LPDATAOBJECT, byval as IID ptr, byval as DWORD, byval as LPFORMATETC, byval as LPOLECLIENTSITE, byval as LPSTORAGE, byval as PVOID ptr) as HRESULT
declare function OleCreateLink alias "OleCreateLink" (byval as LPMONIKER, byval as IID ptr, byval as DWORD, byval as LPFORMATETC, byval as LPOLECLIENTSITE, byval as LPSTORAGE, byval as PVOID ptr) as HRESULT
declare function OleCreateLinkToFile alias "OleCreateLinkToFile" (byval as LPCOLESTR, byval as IID ptr, byval as DWORD, byval as LPFORMATETC, byval as LPOLECLIENTSITE, byval as LPSTORAGE, byval as PVOID ptr) as HRESULT
declare function OleCreateFromFile alias "OleCreateFromFile" (byval as CLSID ptr, byval as LPCOLESTR, byval as IID ptr, byval as DWORD, byval as LPFORMATETC, byval as LPOLECLIENTSITE, byval as LPSTORAGE, byval as PVOID ptr) as HRESULT
declare function OleLoad alias "OleLoad" (byval as LPSTORAGE, byval as IID ptr, byval as LPOLECLIENTSITE, byval as PVOID ptr) as HRESULT
declare function OleSave alias "OleSave" (byval as LPPERSISTSTORAGE, byval as LPSTORAGE, byval as BOOL) as HRESULT
declare function OleLoadFromStream alias "OleLoadFromStream" (byval as LPSTREAM, byval as IID ptr, byval as PVOID ptr) as HRESULT
declare function OleSaveToStream alias "OleSaveToStream" (byval as LPPERSISTSTREAM, byval as LPSTREAM) as HRESULT
declare function OleSetContainedObject alias "OleSetContainedObject" (byval as LPUNKNOWN, byval as BOOL) as HRESULT
declare function OleNoteObjectVisible alias "OleNoteObjectVisible" (byval as LPUNKNOWN, byval as BOOL) as HRESULT
declare function RegisterDragDrop alias "RegisterDragDrop" (byval as HWND, byval as LPDROPTARGET) as HRESULT
declare function RevokeDragDrop alias "RevokeDragDrop" (byval as HWND) as HRESULT
declare function DoDragDrop alias "DoDragDrop" (byval as LPDATAOBJECT, byval as LPDROPSOURCE, byval as DWORD, byval as PDWORD) as HRESULT
declare function OleSetClipboard alias "OleSetClipboard" (byval as LPDATAOBJECT) as HRESULT
declare function OleGetClipboard alias "OleGetClipboard" (byval as LPDATAOBJECT ptr) as HRESULT
declare function OleFlushClipboard alias "OleFlushClipboard" () as HRESULT
declare function OleIsCurrentClipboard alias "OleIsCurrentClipboard" (byval as LPDATAOBJECT) as HRESULT
declare function OleCreateMenuDescriptor alias "OleCreateMenuDescriptor" (byval as HMENU, byval as LPOLEMENUGROUPWIDTHS) as HOLEMENU
declare function OleSetMenuDescriptor alias "OleSetMenuDescriptor" (byval as HOLEMENU, byval as HWND, byval as HWND, byval as LPOLEINPLACEFRAME, byval as LPOLEINPLACEACTIVEOBJECT) as HRESULT
declare function OleDestroyMenuDescriptor alias "OleDestroyMenuDescriptor" (byval as HOLEMENU) as HRESULT
declare function OleTranslateAccelerator alias "OleTranslateAccelerator" (byval as LPOLEINPLACEFRAME, byval as LPOLEINPLACEFRAMEINFO, byval as LPMSG) as HRESULT
declare function OleDuplicateData alias "OleDuplicateData" (byval as HANDLE, byval as CLIPFORMAT, byval as UINT) as HANDLE
declare function OleDraw alias "OleDraw" (byval as LPUNKNOWN, byval as DWORD, byval as HDC, byval as LPCRECT) as HRESULT
declare function OleRun alias "OleRun" (byval as LPUNKNOWN) as HRESULT
declare function OleIsRunning alias "OleIsRunning" (byval as LPOLEOBJECT) as BOOL
declare function OleLockRunning alias "OleLockRunning" (byval as LPUNKNOWN, byval as BOOL, byval as BOOL) as HRESULT
declare sub ReleaseStgMedium alias "ReleaseStgMedium" (byval as LPSTGMEDIUM)
declare function CreateOleAdviseHolder alias "CreateOleAdviseHolder" (byval as LPOLEADVISEHOLDER ptr) as HRESULT
declare function OleCreateDefaultHandler alias "OleCreateDefaultHandler" (byval as CLSID ptr, byval as LPUNKNOWN, byval as IID ptr, byval as PVOID ptr) as HRESULT
declare function OleCreateEmbeddingHelper alias "OleCreateEmbeddingHelper" (byval as CLSID ptr, byval as LPUNKNOWN, byval as DWORD, byval as LPCLASSFACTORY, byval as IID ptr, byval as PVOID ptr) as HRESULT
declare function IsAccelerator alias "IsAccelerator" (byval as HACCEL, byval as integer, byval as LPMSG, byval as WORD ptr) as BOOL
declare function OleGetIconOfFile alias "OleGetIconOfFile" (byval as LPOLESTR, byval as BOOL) as HGLOBAL
declare function OleGetIconOfClass alias "OleGetIconOfClass" (byval as CLSID ptr, byval as LPOLESTR, byval as BOOL) as HGLOBAL
declare function OleMetafilePictFromIconAndLabel alias "OleMetafilePictFromIconAndLabel" (byval as HICON, byval as LPOLESTR, byval as LPOLESTR, byval as UINT) as HGLOBAL
declare function OleRegGetUserType alias "OleRegGetUserType" (byval as CLSID ptr, byval as DWORD, byval as LPOLESTR ptr) as HRESULT
declare function OleRegGetMiscStatus alias "OleRegGetMiscStatus" (byval as CLSID ptr, byval as DWORD, byval as DWORD ptr) as HRESULT
declare function OleRegEnumFormatEtc alias "OleRegEnumFormatEtc" (byval as CLSID ptr, byval as DWORD, byval as LPENUMFORMATETC ptr) as HRESULT
declare function OleRegEnumVerbs alias "OleRegEnumVerbs" (byval as CLSID ptr, byval as LPENUMOLEVERB ptr) as HRESULT
declare function OleConvertOLESTREAMToIStorage alias "OleConvertOLESTREAMToIStorage" (byval as LPOLESTREAM, byval as LPSTORAGE, byval as DVTARGETDEVICE ptr) as HRESULT
declare function OleConvertIStorageToOLESTREAM alias "OleConvertIStorageToOLESTREAM" (byval as LPSTORAGE, byval as LPOLESTREAM) as HRESULT
declare function GetHGlobalFromILockBytes alias "GetHGlobalFromILockBytes" (byval as LPLOCKBYTES, byval as HGLOBAL ptr) as HRESULT
declare function CreateILockBytesOnHGlobal alias "CreateILockBytesOnHGlobal" (byval as HGLOBAL, byval as BOOL, byval as LPLOCKBYTES ptr) as HRESULT
declare function GetHGlobalFromStream alias "GetHGlobalFromStream" (byval as LPSTREAM, byval as HGLOBAL ptr) as HRESULT
declare function CreateStreamOnHGlobal alias "CreateStreamOnHGlobal" (byval as HGLOBAL, byval as BOOL, byval as LPSTREAM ptr) as HRESULT
declare function OleDoAutoConvert alias "OleDoAutoConvert" (byval as LPSTORAGE, byval as LPCLSID) as HRESULT
declare function OleGetAutoConvert alias "OleGetAutoConvert" (byval as CLSID ptr, byval as LPCLSID) as HRESULT
declare function OleSetAutoConvert alias "OleSetAutoConvert" (byval as CLSID ptr, byval as CLSID ptr) as HRESULT
declare function GetConvertStg alias "GetConvertStg" (byval as LPSTORAGE) as HRESULT
declare function SetConvertStg alias "SetConvertStg" (byval as LPSTORAGE, byval as BOOL) as HRESULT
declare function OleConvertIStorageToOLESTREAMEx alias "OleConvertIStorageToOLESTREAMEx" (byval as LPSTORAGE, byval as CLIPFORMAT, byval as LONG, byval as LONG, byval as DWORD, byval as LPSTGMEDIUM, byval as LPOLESTREAM) as HRESULT
declare function OleConvertOLESTREAMToIStorageEx alias "OleConvertOLESTREAMToIStorageEx" (byval as LPOLESTREAM, byval as LPSTORAGE, byval as CLIPFORMAT ptr, byval as LONG ptr, byval as LONG ptr, byval as DWORD ptr, byval as LPSTGMEDIUM) as HRESULT

#endif
