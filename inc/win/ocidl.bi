''
''
'' ocidl -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_ocidl_bi__
#define __win_ocidl_bi__

#include once "win/ole2.bi"

type LPERRORLOG as IErrorLog ptr
type LPPROPERTYBAG as IPropertyBag ptr
type LPPROPERTYBAG2 as IPropertyBag2 ptr
type LPENUMCONNECTIONS as IEnumConnections ptr
type LPCONNECTIONPOINT as IConnectionPoint ptr
type LPENUMCONNECTIONPOINTS as IEnumConnectionPoints ptr
type LPPROPERTYPAGESITE as IPropertyPageSite ptr
type LPFONT as IFont ptr
type LPFONTDISP as IFontDisp ptr
type LPOLEUNDOMANAGER as IOleUndoManager ptr
type TEXTMETRICOLE as TEXTMETRICW
type LPTEXTMETRICOLE as TEXTMETRICOLE ptr

type OLE_COLOR as DWORD
type OLE_HANDLE as UINT
type OLE_XPOS_HIMETRIC as integer
type OLE_YPOS_HIMETRIC as integer
type OLE_XSIZE_HIMETRIC as integer
type OLE_YSIZE_HIMETRIC as integer

enum READYSTATE
	READYSTATE_UNINITIALIZED = 0
	READYSTATE_LOADING = 1
	READYSTATE_LOADED = 2
	READYSTATE_INTERACTIVE = 3
	READYSTATE_COMPLETE = 4
end enum


enum PROPBAG2_TYPE
	PROPBAG2_TYPE_UNDEFINED = 0
	PROPBAG2_TYPE_DATA = 1
	PROPBAG2_TYPE_URL = 2
	PROPBAG2_TYPE_OBJECT = 3
	PROPBAG2_TYPE_STREAM = 4
	PROPBAG2_TYPE_STORAGE = 5
	PROPBAG2_TYPE_MONIKER = 6
end enum

type PROPBAG2
	dwType as DWORD
	vt as VARTYPE
	cfType as CLIPFORMAT
	dwHint as DWORD
	pstrName as LPOLESTR
	clsid as CLSID
end type

type QACONTROL
	cbSize as ULONG
	dwMiscStatus as DWORD
	dwViewStatus as DWORD
	dwEventCookie as DWORD
	dwPropNotifyCookie as DWORD
	dwPointerActivationPolicy as DWORD
end type

type POINTF
	x as single
	y as single
end type

type LPPOINTF as POINTF ptr

type CONTROLINFO
	cb as ULONG
	hAccel as HACCEL
	cAccel as USHORT
	dwFlags as DWORD
end type

type LPCONTROLINFO as CONTROLINFO ptr

type CONNECTDATA
	pUnk as LPUNKNOWN
	dwCookie as DWORD
end type

type LPCONNECTDATA as CONNECTDATA ptr

type LICINFO
	cbLicInfo as integer
	fRuntimeKeyAvail as BOOL
	fLicVerified as BOOL
end type

type LPLICINFO as LICINFO ptr

type CAUUID
	cElems as ULONG
	pElems as GUID ptr
end type

type LPCAUUID as CAUUID ptr

type CALPOLESTR
	cElems as ULONG
	pElems as LPOLESTR ptr
end type

type LPCALPOLESTR as CALPOLESTR ptr

type CADWORD
	cElems as ULONG
	pElems as DWORD ptr
end type

type LPCADWORD as CADWORD ptr

type PROPPAGEINFO
	cb as ULONG
	pszTitle as LPOLESTR
	size as SIZE
	pszDocString as LPOLESTR
	pszHelpFile as LPOLESTR
	dwHelpContext as DWORD
end type

type LPPROPPAGEINFO as PROPPAGEINFO ptr

extern IID_IOleControl alias "IID_IOleControl" as IID

type IOleControlVtbl_ as IOleControlVtbl

type IOleControl
	lpVtbl as IOleControlVtbl_ ptr
end type

type IOleControlVtbl
	QueryInterface as function(byval as IOleControl ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IOleControl ptr) as ULONG
	Release as function(byval as IOleControl ptr) as ULONG
	GetControlInfo as function(byval as IOleControl ptr, byval as LPCONTROLINFO) as HRESULT
	OnMnemonic as function(byval as IOleControl ptr, byval as LPMSG) as HRESULT
	OnAmbientPropertyChange as function(byval as IOleControl ptr, byval as DISPID) as HRESULT
	FreezeEvents as function(byval as IOleControl ptr, byval as BOOL) as HRESULT
end type
extern IID_IOleControlSite alias "IID_IOleControlSite" as IID

type IOleControlSiteVtbl_ as IOleControlSiteVtbl

type IOleControlSite
	lpVtbl as IOleControlSiteVtbl_ ptr
end type

type IOleControlSiteVtbl
	QueryInterface as function(byval as IOleControlSite ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IOleControlSite ptr) as ULONG
	Release as function(byval as IOleControlSite ptr) as ULONG
	OnControlInfoChanged as function(byval as IOleControlSite ptr) as HRESULT
	LockInPlaceActive as function(byval as IOleControlSite ptr, byval as BOOL) as HRESULT
	GetExtendedControl as function(byval as IOleControlSite ptr, byval as LPDISPATCH ptr) as HRESULT
	TransformCoords as function(byval as IOleControlSite ptr, byval as POINTL ptr, byval as POINTF ptr, byval as DWORD) as HRESULT
	TranslateAcceleratorA as function(byval as IOleControlSite ptr, byval as LPMSG, byval as DWORD) as HRESULT
	OnFocus as function(byval as IOleControlSite ptr, byval as BOOL) as HRESULT
	ShowPropertyFrame as function(byval as IOleControlSite ptr) as HRESULT
end type
extern IID_ISimpleFrameSite alias "IID_ISimpleFrameSite" as IID

#define IOleControlSite_QueryInterface(T,a,b) (T)->lpVtbl->QueryInterface(T,a,b)
#define IOleControlSite_AddRef(T) (T)->lpVtbl->AddRef(T)
#define IOleControlSite_Release(T) (T)->lpVtbl->Release(T)
#define IOleControlSite_OnControlInfoChanged(T) (T)->lpVtbl->OnControlInfoChanged(T)
#define IOleControlSite_LockInPlaceActive(T,a) (T)->lpVtbl->LockInPlaceActive(T,a)
#define IOleControlSite_GetExtendedControl(T,a) (T)->lpVtbl->GetExtendedControl(T,a)
#define IOleControlSite_TransformCoords(T,a,b,c) (T)->lpVtbl->TransformCoords(T,a,b,c)
#define IOleControlSite_TranslateAccelerator(T,a,b) (T)->lpVtbl->TranslateAccelerator(T,a,b)
#define IOleControlSite_OnFocus(T,a) (T)->lpVtbl->OnFocus(T,a)
#define IOleControlSite_ShowPropertyFrame(T) (T)->lpVtbl->ShowPropertyFrame(T)

type ISimpleFrameSiteVtbl_ as ISimpleFrameSiteVtbl

type ISimpleFrameSite
	lpVtbl as ISimpleFrameSiteVtbl_ ptr
end type

type ISimpleFrameSiteVtbl
	QueryInterface as function(byval as ISimpleFrameSite ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as ISimpleFrameSite ptr) as ULONG
	Release as function(byval as ISimpleFrameSite ptr) as ULONG
	PreMessageFilter as function(byval as ISimpleFrameSite ptr, byval as HWND, byval as UINT, byval as WPARAM, byval as LPARAM, byval as LONG ptr, byval as PDWORD) as HRESULT
	PostMessageFilter as function(byval as ISimpleFrameSite ptr, byval as HWND, byval as UINT, byval as WPARAM, byval as LPARAM, byval as LONG ptr, byval as DWORD) as HRESULT
end type
extern IID_IErrorLog alias "IID_IErrorLog" as IID

type IErrorLogVtbl_ as IErrorLogVtbl

type IErrorLog
	lpVtbl as IErrorLogVtbl_ ptr
end type

type IErrorLogVtbl
	QueryInterface as function(byval as IErrorLog ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IErrorLog ptr) as ULONG
	Release as function(byval as IErrorLog ptr) as ULONG
	AddError as function(byval as IErrorLog ptr, byval as LPCOLESTR, byval as LPEXCEPINFO) as HRESULT
end type
extern IID_IPropertyBag alias "IID_IPropertyBag" as IID

type IPropertyBagVtbl_ as IPropertyBagVtbl

type IPropertyBag
	lpVtbl as IPropertyBagVtbl_ ptr
end type

type IPropertyBagVtbl
	QueryInterface as function(byval as IPropertyBag ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IPropertyBag ptr) as ULONG
	Release as function(byval as IPropertyBag ptr) as ULONG
	Read as function(byval as IPropertyBag ptr, byval as LPCOLESTR, byval as LPVARIANT, byval as LPERRORLOG) as HRESULT
	Write as function(byval as IPropertyBag ptr, byval as LPCOLESTR, byval as LPVARIANT) as HRESULT
end type
extern IID_IPropertyBag2 alias "IID_IPropertyBag2" as IID

type IPropertyBag2Vtbl_ as IPropertyBag2Vtbl

type IPropertyBag2
	lpVtbl as IPropertyBag2Vtbl_ ptr
end type

type IPropertyBag2Vtbl
	QueryInterface as function(byval as IPropertyBag2 ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IPropertyBag2 ptr) as ULONG
	Release as function(byval as IPropertyBag2 ptr) as ULONG
	Read as function(byval as IPropertyBag2 ptr, byval as ULONG, byval as PROPBAG2 ptr, byval as LPERRORLOG, byval as VARIANT ptr, byval as HRESULT ptr) as HRESULT
	Write as function(byval as IPropertyBag2 ptr, byval as ULONG, byval as PROPBAG2 ptr, byval as VARIANT ptr) as HRESULT
	CountProperties as function(byval as IPropertyBag2 ptr, byval as ULONG ptr) as HRESULT
	GetPropertyInfo as function(byval as IPropertyBag2 ptr, byval as ULONG, byval as ULONG, byval as PROPBAG2 ptr, byval as ULONG ptr) as HRESULT
	LoadObject as function(byval as IPropertyBag2 ptr, byval as LPCOLESTR, byval as DWORD, byval as IUnknown ptr, byval as LPERRORLOG) as HRESULT
end type
extern IID_IPersistPropertyBag alias "IID_IPersistPropertyBag" as IID

type IPersistPropertyBagVtbl_ as IPersistPropertyBagVtbl

type IPersistPropertyBag
	lpVtbl as IPersistPropertyBagVtbl_ ptr
end type

type IPersistPropertyBagVtbl
	QueryInterface as function(byval as IPersistPropertyBag ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IPersistPropertyBag ptr) as ULONG
	Release as function(byval as IPersistPropertyBag ptr) as ULONG
	GetClassID as function(byval as IPersistPropertyBag ptr, byval as LPCLSID) as HRESULT
	InitNew as function(byval as IPersistPropertyBag ptr) as HRESULT
	Load as function(byval as IPersistPropertyBag ptr, byval as LPPROPERTYBAG, byval as LPERRORLOG) as HRESULT
	Save as function(byval as IPersistPropertyBag ptr, byval as LPPROPERTYBAG, byval as BOOL, byval as BOOL) as HRESULT
end type

#define IPersistPropertyBag_QueryInterface(T,a,b) (T)->lpVtbl->QueryInterface(T,a,b)
#define IPersistPropertyBag_AddRef(T) (T)->lpVtbl->AddRef(T)
#define IPersistPropertyBag_Release(T) (T)->lpVtbl->Release(T)
#define IPersistPropertyBag_GetClassID(T,a) (T)->lpVtbl->GetClassID(T,a)
#define IPersistPropertyBag_InitNew(T) (T)->lpVtbl->InitNew(T)
#define IPersistPropertyBag_Load(T,a,b) (T)->lpVtbl->Load(T,a,b)
#define IPersistPropertyBag_Save(T,a,b,c) (T)->lpVtbl->Save(T,a,b,c)

extern IID_IPersistPropertyBag2 alias "IID_IPersistPropertyBag2" as IID

type IPersistPropertyBag2Vtbl_ as IPersistPropertyBag2Vtbl

type IPersistPropertyBag2
	lpVtbl as IPersistPropertyBag2Vtbl_ ptr
end type

type IPersistPropertyBag2Vtbl
	QueryInterface as function(byval as IPersistPropertyBag2 ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IPersistPropertyBag2 ptr) as ULONG
	Release as function(byval as IPersistPropertyBag2 ptr) as ULONG
	GetClassID as function(byval as IPersistPropertyBag2 ptr, byval as LPCLSID) as HRESULT
	InitNew as function(byval as IPersistPropertyBag2 ptr) as HRESULT
	Load as function(byval as IPersistPropertyBag2 ptr, byval as LPPROPERTYBAG2, byval as LPERRORLOG) as HRESULT
	Save as function(byval as IPersistPropertyBag2 ptr, byval as LPPROPERTYBAG2, byval as BOOL, byval as BOOL) as HRESULT
	IsDirty as function(byval as IPersistPropertyBag2 ptr) as HRESULT
end type

#define IPersistPropertyBag2_QueryInterface(T,a,b) (T)->lpVtbl->QueryInterface(T,a,b)
#define IPersistPropertyBag2_AddRef(T) (T)->lpVtbl->AddRef(T)
#define IPersistPropertyBag2_Release(T) (T)->lpVtbl->Release(T)
#define IPersistPropertyBag2_GetClassID(T,a) (T)->lpVtbl->GetClassID(T,a)
#define IPersistPropertyBag2_InitNew(T) (T)->lpVtbl->InitNew(T)
#define IPersistPropertyBag2_Load(T,a,b) (T)->lpVtbl->Load(T,a,b)
#define IPersistPropertyBag2_Save(T,a,b,c) (T)->lpVtbl->Save(T,a,b,c)
#define IPersistPropertyBag2_IsDirty(T) (T)->lpVtbl->IsDirty(T)

extern IID_IPersistStreamInit alias "IID_IPersistStreamInit" as IID

type IPersistStreamInitVtbl_ as IPersistStreamInitVtbl

type IPersistStreamInit
	lpVtbl as IPersistStreamInitVtbl_ ptr
end type

type IPersistStreamInitVtbl
	QueryInterface as function(byval as IPersistStreamInit ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IPersistStreamInit ptr) as ULONG
	Release as function(byval as IPersistStreamInit ptr) as ULONG
	GetClassID as function(byval as IPersistStreamInit ptr, byval as LPCLSID) as HRESULT
	IsDirty as function(byval as IPersistStreamInit ptr) as HRESULT
	Load as function(byval as IPersistStreamInit ptr, byval as LPSTREAM) as HRESULT
	Save as function(byval as IPersistStreamInit ptr, byval as LPSTREAM, byval as BOOL) as HRESULT
	GetSizeMax as function(byval as IPersistStreamInit ptr, byval as PULARGE_INTEGER) as HRESULT
	InitNew as function(byval as IPersistStreamInit ptr) as HRESULT
end type
extern IID_IPersistMemory alias "IID_IPersistMemory" as IID

type IPersistMemoryVtbl_ as IPersistMemoryVtbl

type IPersistMemory
	lpVtbl as IPersistMemoryVtbl_ ptr
end type

type IPersistMemoryVtbl
	QueryInterface as function(byval as IPersistMemory ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IPersistMemory ptr) as ULONG
	Release as function(byval as IPersistMemory ptr) as ULONG
	GetClassID as function(byval as IPersistMemory ptr, byval as LPCLSID) as HRESULT
	IsDirty as function(byval as IPersistMemory ptr) as HRESULT
	Load as function(byval as IPersistMemory ptr, byval as PVOID, byval as ULONG) as HRESULT
	Save as function(byval as IPersistMemory ptr, byval as PVOID, byval as BOOL, byval as ULONG) as HRESULT
	GetSizeMax as function(byval as IPersistMemory ptr, byval as PULONG) as HRESULT
	InitNew as function(byval as IPersistMemory ptr) as HRESULT
end type
extern IID_IPropertyNotifySink alias "IID_IPropertyNotifySink" as IID

type IPropertyNotifySinkVtbl_ as IPropertyNotifySinkVtbl

type IPropertyNotifySink
	lpVtbl as IPropertyNotifySinkVtbl_ ptr
end type

type IPropertyNotifySinkVtbl
	QueryInterface as function(byval as IPropertyNotifySink ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IPropertyNotifySink ptr) as ULONG
	Release as function(byval as IPropertyNotifySink ptr) as ULONG
	OnChanged as function(byval as IPropertyNotifySink ptr, byval as DISPID) as HRESULT
	OnRequestEdit as function(byval as IPropertyNotifySink ptr, byval as DISPID) as HRESULT
end type

#define IPropertyNotifySink_QueryInterface(T,a,b) (T)->lpVtbl->QueryInterface(T,a,b)
#define IPropertyNotifySink_AddRef(T) (T)->lpVtbl->AddRef(T)
#define IPropertyNotifySink_Release(T) (T)->lpVtbl->Release(T)
#define IPropertyNotifySink_OnChanged(T,a) (T)->lpVtbl->OnChanged(T,a)
#define IPropertyNotifySink_OnRequestEdit(T,a) (T)->lpVtbl->OnRequestEdit(T,a)

extern IID_IProvideClassInfo alias "IID_IProvideClassInfo" as IID

type IProvideClassInfoVtbl_ as IProvideClassInfoVtbl

type IProvideClassInfo
	lpVtbl as IProvideClassInfoVtbl_ ptr
end type

type IProvideClassInfoVtbl
	QueryInterface as function(byval as IProvideClassInfo ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IProvideClassInfo ptr) as ULONG
	Release as function(byval as IProvideClassInfo ptr) as ULONG
	GetClassInfoA as function(byval as IProvideClassInfo ptr, byval as LPTYPEINFO ptr) as HRESULT
end type
extern IID_IProvideClassInfo2 alias "IID_IProvideClassInfo2" as IID

type IProvideClassInfo2Vtbl_ as IProvideClassInfo2Vtbl

type IProvideClassInfo2
	lpVtbl as IProvideClassInfo2Vtbl_ ptr
end type

type IProvideClassInfo2Vtbl
	QueryInterface as function(byval as IProvideClassInfo2 ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IProvideClassInfo2 ptr) as ULONG
	Release as function(byval as IProvideClassInfo2 ptr) as ULONG
	GetClassInfoA as function(byval as IProvideClassInfo2 ptr, byval as LPTYPEINFO ptr) as HRESULT
	GetGUID as function(byval as IProvideClassInfo2 ptr, byval as DWORD, byval as GUID ptr) as HRESULT
end type
extern IID_IConnectionPointContainer alias "IID_IConnectionPointContainer" as IID

type IConnectionPointContainerVtbl_ as IConnectionPointContainerVtbl

type IConnectionPointContainer
	lpVtbl as IConnectionPointContainerVtbl_ ptr
end type

type IConnectionPointContainerVtbl
	QueryInterface as function(byval as IConnectionPointContainer ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IConnectionPointContainer ptr) as ULONG
	Release as function(byval as IConnectionPointContainer ptr) as ULONG
	EnumConnectionPoints as function(byval as IConnectionPointContainer ptr, byval as LPENUMCONNECTIONPOINTS ptr) as HRESULT
	FindConnectionPoint as function(byval as IConnectionPointContainer ptr, byval as IID ptr, byval as LPCONNECTIONPOINT ptr) as HRESULT
end type

#define IConnectionPointContainer_QueryInterface(T,a,b) (T)->lpVtbl->QueryInterface(T,a,b)
#define IConnectionPointContainer_AddRef(T) (T)->lpVtbl->AddRef(T)
#define IConnectionPointContainer_Release(T) (T)->lpVtbl->Release(T)
#define IConnectionPointContainer_EnumConnectionPoints(T,a) (T)->lpVtbl->EnumConnectionPoints(T,a)
#define IConnectionPointContainer_FindConnectionPoint(T,a,b) (T)->lpVtbl->FindConnectionPoint(T,a,b)

extern IID_IEnumConnectionPoints alias "IID_IEnumConnectionPoints" as IID

type IEnumConnectionPointsVtbl_ as IEnumConnectionPointsVtbl

type IEnumConnectionPoints
	lpVtbl as IEnumConnectionPointsVtbl_ ptr
end type

type IEnumConnectionPointsVtbl
	QueryInterface as function(byval as IEnumConnectionPoints ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IEnumConnectionPoints ptr) as ULONG
	Release as function(byval as IEnumConnectionPoints ptr) as ULONG
	Next as function(byval as IEnumConnectionPoints ptr, byval as ULONG, byval as LPCONNECTIONPOINT ptr, byval as ULONG ptr) as HRESULT
	Skip as function(byval as IEnumConnectionPoints ptr, byval as ULONG) as HRESULT
	Reset as function(byval as IEnumConnectionPoints ptr) as HRESULT
	Clone as function(byval as IEnumConnectionPoints ptr, byval as LPENUMCONNECTIONPOINTS ptr) as HRESULT
end type

extern IID_IConnectionPoint alias "IID_IConnectionPoint" as IID

type IConnectionPointVtbl_ as IConnectionPointVtbl

type IConnectionPoint
	lpVtbl as IConnectionPointVtbl_ ptr
end type

type IConnectionPointVtbl
	QueryInterface as function(byval as IConnectionPoint ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IConnectionPoint ptr) as ULONG
	Release as function(byval as IConnectionPoint ptr) as ULONG
	GetConnectionInterface as function(byval as IConnectionPoint ptr, byval as IID ptr) as HRESULT
	GetConnectionPointContainer as function(byval as IConnectionPoint ptr, byval as IConnectionPointContainer ptr ptr) as HRESULT
	Advise as function(byval as IConnectionPoint ptr, byval as LPUNKNOWN, byval as PDWORD) as HRESULT
	Unadvise as function(byval as IConnectionPoint ptr, byval as DWORD) as HRESULT
	EnumConnections as function(byval as IConnectionPoint ptr, byval as LPENUMCONNECTIONS ptr) as HRESULT
end type

#define IConnectionPoint_QueryInterface(T,a,b) (T)->lpVtbl->QueryInterface(T,a,b)
#define IConnectionPoint_AddRef(T) (T)->lpVtbl->AddRef(T)
#define IConnectionPoint_Release(T) (T)->lpVtbl->Release(T)
#define IConnectionPoint_GetConnectionInterface(T,a) (T)->lpVtbl->GetConnectionInterface(T,a)
#define IConnectionPoint_GetConnectionPointContainer(T,a) (T)->lpVtbl->GetConnectionPointContainer(T,a)
#define IConnectionPoint_Advise(T,a,b) (T)->lpVtbl->Advise(T,a,b)
#define IConnectionPoint_Unadvise(T,a) (T)->lpVtbl->Unadvise(T,a)
#define IConnectionPoint_EnumConnections(T,a) (T)->lpVtbl->EnumConnections(T,a)

extern IID_IEnumConnections alias "IID_IEnumConnections" as IID

type IEnumConnectionsVtbl_ as IEnumConnectionsVtbl

type IEnumConnections
	lpVtbl as IEnumConnectionsVtbl_ ptr
end type

type IEnumConnectionsVtbl
	QueryInterface as function(byval as IEnumConnections ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IEnumConnections ptr) as ULONG
	Release as function(byval as IEnumConnections ptr) as ULONG
	Next as function(byval as IEnumConnections ptr, byval as ULONG, byval as LPCONNECTDATA, byval as PULONG) as HRESULT
	Skip as function(byval as IEnumConnections ptr, byval as ULONG) as HRESULT
	Reset as function(byval as IEnumConnections ptr) as HRESULT
	Clone as function(byval as IEnumConnections ptr, byval as LPENUMCONNECTIONS ptr) as HRESULT
end type

#define IEnumConnections_QueryInterface(T,a,b) (T)->lpVtbl->QueryInterface(T,a,b)
#define IEnumConnections_AddRef(T) (T)->lpVtbl->AddRef(T)
#define IEnumConnections_Release(T) (T)->lpVtbl->Release(T)
#define IEnumConnections_Next(T,a,b,c) (T)->lpVtbl->Next(T,a,b,c)
#define IEnumConnections_Skip(T,a) (T)->lpVtbl->Skip(T,a)
#define IEnumConnections_Reset(T) (T)->lpVtbl->Reset(T)
#define IEnumConnections_Clone(T,a) (T)->lpVtbl->Clone(T,a)

extern IID_IClassFactory2 alias "IID_IClassFactory2" as IID

type IClassFactory2Vtbl_ as IClassFactory2Vtbl

type IClassFactory2
	lpVtbl as IClassFactory2Vtbl_ ptr
end type

type IClassFactory2Vtbl
	QueryInterface as function(byval as IClassFactory2 ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IClassFactory2 ptr) as ULONG
	Release as function(byval as IClassFactory2 ptr) as ULONG
	CreateInstance as function(byval as IClassFactory2 ptr, byval as LPUNKNOWN, byval as IID ptr, byval as PVOID ptr) as HRESULT
	LockServer as function(byval as IClassFactory2 ptr, byval as BOOL) as HRESULT
	GetLicInfo as function(byval as IClassFactory2 ptr, byval as LPLICINFO) as HRESULT
	RequestLicKey as function(byval as IClassFactory2 ptr, byval as DWORD, byval as BSTR ptr) as HRESULT
	CreateInstanceLic as function(byval as IClassFactory2 ptr, byval as LPUNKNOWN, byval as LPUNKNOWN, byval as IID ptr, byval as BSTR, byval as PVOID ptr) as HRESULT
end type
extern IID_ISpecifyPropertyPages alias "IID_ISpecifyPropertyPages" as IID

type ISpecifyPropertyPagesVtbl_ as ISpecifyPropertyPagesVtbl

type ISpecifyPropertyPages
	lpVtbl as ISpecifyPropertyPagesVtbl_ ptr
end type

type ISpecifyPropertyPagesVtbl
	QueryInterface as function(byval as ISpecifyPropertyPages ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as ISpecifyPropertyPages ptr) as ULONG
	Release as function(byval as ISpecifyPropertyPages ptr) as ULONG
	GetPages as function(byval as ISpecifyPropertyPages ptr, byval as CAUUID ptr) as HRESULT
end type
extern IID_IPerPropertyBrowsing alias "IID_IPerPropertyBrowsing" as IID

type IPerPropertyBrowsingVtbl_ as IPerPropertyBrowsingVtbl

type IPerPropertyBrowsing
	lpVtbl as IPerPropertyBrowsingVtbl_ ptr
end type

type IPerPropertyBrowsingVtbl
	QueryInterface as function(byval as IPerPropertyBrowsing ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IPerPropertyBrowsing ptr) as ULONG
	Release as function(byval as IPerPropertyBrowsing ptr) as ULONG
	GetDisplayString as function(byval as IPerPropertyBrowsing ptr, byval as DISPID, byval as BSTR ptr) as HRESULT
	MapPropertyToPage as function(byval as IPerPropertyBrowsing ptr, byval as DISPID, byval as LPCLSID) as HRESULT
	GetPredefinedStrings as function(byval as IPerPropertyBrowsing ptr, byval as DISPID, byval as CALPOLESTR ptr, byval as CADWORD ptr) as HRESULT
	GetPredefinedValue as function(byval as IPerPropertyBrowsing ptr, byval as DISPID, byval as DWORD, byval as VARIANT ptr) as HRESULT
end type
extern IID_IPropertyPageSite alias "IID_IPropertyPageSite" as IID

type IPropertyPageSiteVtbl_ as IPropertyPageSiteVtbl

type IPropertyPageSite
	lpVtbl as IPropertyPageSiteVtbl_ ptr
end type

type IPropertyPageSiteVtbl
	QueryInterface as function(byval as IPropertyPageSite ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IPropertyPageSite ptr) as ULONG
	Release as function(byval as IPropertyPageSite ptr) as ULONG
	OnStatusChange as function(byval as IPropertyPageSite ptr, byval as DWORD) as HRESULT
	GetLocaleID as function(byval as IPropertyPageSite ptr, byval as LCID ptr) as HRESULT
	GetPageContainer as function(byval as IPropertyPageSite ptr, byval as LPUNKNOWN ptr) as HRESULT
	TranslateAcceleratorA as function(byval as IPropertyPageSite ptr, byval as LPMSG) as HRESULT
end type
extern IID_IPropertyPage alias "IID_IPropertyPage" as IID

type IPropertyPageVtbl_ as IPropertyPageVtbl

type IPropertyPage
	lpVtbl as IPropertyPageVtbl_ ptr
end type

type IPropertyPageVtbl
	QueryInterface as function(byval as IPropertyPage ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IPropertyPage ptr) as ULONG
	Release as function(byval as IPropertyPage ptr) as ULONG
	SetPageSite as function(byval as IPropertyPage ptr, byval as LPPROPERTYPAGESITE) as HRESULT
	Activate as function(byval as IPropertyPage ptr, byval as HWND, byval as LPCRECT, byval as BOOL) as HRESULT
	Deactivate as function(byval as IPropertyPage ptr) as HRESULT
	GetPageInfo as function(byval as IPropertyPage ptr, byval as LPPROPPAGEINFO) as HRESULT
	SetObjects as function(byval as IPropertyPage ptr, byval as ULONG, byval as LPUNKNOWN ptr) as HRESULT
	Show as function(byval as IPropertyPage ptr, byval as UINT) as HRESULT
	Move as function(byval as IPropertyPage ptr, byval as LPCRECT) as HRESULT
	IsPageDirty as function(byval as IPropertyPage ptr) as HRESULT
	Apply as function(byval as IPropertyPage ptr) as HRESULT
	Help as function(byval as IPropertyPage ptr, byval as LPCOLESTR) as HRESULT
	TranslateAcceleratorA as function(byval as IPropertyPage ptr, byval as LPMSG) as HRESULT
end type
extern IID_IPropertyPage2 alias "IID_IPropertyPage2" as IID

type IPropertyPage2Vtbl_ as IPropertyPage2Vtbl

type IPropertyPage2
	lpVtbl as IPropertyPage2Vtbl_ ptr
end type

type IPropertyPage2Vtbl
	QueryInterface as function(byval as IPropertyPage2 ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IPropertyPage2 ptr) as ULONG
	Release as function(byval as IPropertyPage2 ptr) as ULONG
	SetPageSite as function(byval as IPropertyPage2 ptr, byval as LPPROPERTYPAGESITE) as HRESULT
	Activate as function(byval as IPropertyPage2 ptr, byval as HWND, byval as LPCRECT, byval as BOOL) as HRESULT
	Deactivate as function(byval as IPropertyPage2 ptr) as HRESULT
	GetPageInfo as function(byval as IPropertyPage2 ptr, byval as LPPROPPAGEINFO) as HRESULT
	SetObjects as function(byval as IPropertyPage2 ptr, byval as ULONG, byval as LPUNKNOWN ptr) as HRESULT
	Show as function(byval as IPropertyPage2 ptr, byval as UINT) as HRESULT
	Move as function(byval as IPropertyPage2 ptr, byval as LPCRECT) as HRESULT
	IsPageDirty as function(byval as IPropertyPage2 ptr) as HRESULT
	Apply as function(byval as IPropertyPage2 ptr) as HRESULT
	Help as function(byval as IPropertyPage2 ptr, byval as LPCOLESTR) as HRESULT
	TranslateAcceleratorA as function(byval as IPropertyPage2 ptr, byval as LPMSG) as HRESULT
	EditProperty as function(byval as IPropertyPage2 ptr, byval as DISPID) as HRESULT
end type
extern IID_IFont alias "IID_IFont" as IID

type IFontVtbl_ as IFontVtbl

type IFont
	lpVtbl as IFontVtbl_ ptr
end type

type IFontVtbl
	QueryInterface as function(byval as IFont ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IFont ptr) as ULONG
	Release as function(byval as IFont ptr) as ULONG
	get_Name as function(byval as IFont ptr, byval as BSTR ptr) as HRESULT
	put_Name as function(byval as IFont ptr, byval as BSTR) as HRESULT
	get_Size as function(byval as IFont ptr, byval as CY ptr) as HRESULT
	put_Size as function(byval as IFont ptr, byval as CY) as HRESULT
	get_Bold as function(byval as IFont ptr, byval as BOOL ptr) as HRESULT
	put_Bold as function(byval as IFont ptr, byval as BOOL) as HRESULT
	get_Italic as function(byval as IFont ptr, byval as BOOL ptr) as HRESULT
	put_Italic as function(byval as IFont ptr, byval as BOOL) as HRESULT
	get_Underline as function(byval as IFont ptr, byval as BOOL ptr) as HRESULT
	put_Underline as function(byval as IFont ptr, byval as BOOL) as HRESULT
	get_Strikethrough as function(byval as IFont ptr, byval as BOOL ptr) as HRESULT
	put_Strikethrough as function(byval as IFont ptr, byval as BOOL) as HRESULT
	get_Weight as function(byval as IFont ptr, byval as short ptr) as HRESULT
	put_Weight as function(byval as IFont ptr, byval as short) as HRESULT
	get_Charset as function(byval as IFont ptr, byval as short ptr) as HRESULT
	put_Charset as function(byval as IFont ptr, byval as short) as HRESULT
	get_hFont as function(byval as IFont ptr, byval as HFONT ptr) as HRESULT
	Clone as function(byval as IFont ptr, byval as IFont ptr ptr) as HRESULT
	IsEqual as function(byval as IFont ptr, byval as IFont ptr) as HRESULT
	SetRatio as function(byval as IFont ptr, byval as integer, byval as integer) as HRESULT
	QueryTextMetrics as function(byval as IFont ptr, byval as LPTEXTMETRICOLE) as HRESULT
	AddRefHfont as function(byval as IFont ptr, byval as HFONT) as HRESULT
	ReleaseHfont as function(byval as IFont ptr, byval as HFONT) as HRESULT
	SetHdc as function(byval as IFont ptr, byval as HDC) as HRESULT
end type
extern IID_IFontDisp alias "IID_IFontDisp" as IID

type IFontDispVtbl_ as IFontDispVtbl

type IFontDisp
	lpVtbl as IFontDispVtbl_ ptr
end type

type IFontDispVtbl
	QueryInterface as function(byval as IFontDisp ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IFontDisp ptr) as ULONG
	Release as function(byval as IFontDisp ptr) as ULONG
	GetTypeInfoCount as function(byval as IFontDisp ptr, byval as UINT ptr) as HRESULT
	GetTypeInfo as function(byval as IFontDisp ptr, byval as UINT, byval as LCID, byval as LPTYPEINFO ptr) as HRESULT
	GetIDsOfNames as function(byval as IFontDisp ptr, byval as IID ptr, byval as LPOLESTR ptr, byval as UINT, byval as LCID, byval as DISPID ptr) as HRESULT
	Invoke as function(byval as IFontDisp ptr, byval as DISPID, byval as IID ptr, byval as LCID, byval as WORD, byval as DISPPARAMS ptr, byval as VARIANT ptr, byval as EXCEPINFO ptr, byval as UINT ptr) as HRESULT
end type
extern IID_IPicture alias "IID_IPicture" as IID

type IPictureVtbl_ as IPictureVtbl

type IPicture
	lpVtbl as IPictureVtbl_ ptr
end type

type IPictureVtbl
	QueryInterface as function(byval as IPicture ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IPicture ptr) as ULONG
	Release as function(byval as IPicture ptr) as ULONG
	get_Handle as function(byval as IPicture ptr, byval as OLE_HANDLE ptr) as HRESULT
	get_hPal as function(byval as IPicture ptr, byval as OLE_HANDLE ptr) as HRESULT
	get_Type as function(byval as IPicture ptr, byval as short ptr) as HRESULT
	get_Width as function(byval as IPicture ptr, byval as OLE_XSIZE_HIMETRIC ptr) as HRESULT
	get_Height as function(byval as IPicture ptr, byval as OLE_YSIZE_HIMETRIC ptr) as HRESULT
	Render as function(byval as IPicture ptr, byval as HDC, byval as integer, byval as integer, byval as integer, byval as integer, byval as OLE_XPOS_HIMETRIC, byval as OLE_YPOS_HIMETRIC, byval as OLE_XSIZE_HIMETRIC, byval as OLE_YSIZE_HIMETRIC, byval as LPCRECT) as HRESULT
	set_hPal as function(byval as IPicture ptr, byval as OLE_HANDLE) as HRESULT
	get_CurDC as function(byval as IPicture ptr, byval as HDC ptr) as HRESULT
	SelectPicture as function(byval as IPicture ptr, byval as HDC, byval as HDC ptr, byval as OLE_HANDLE ptr) as HRESULT
	get_KeepOriginalFormat as function(byval as IPicture ptr, byval as BOOL ptr) as HRESULT
	put_KeepOriginalFormat as function(byval as IPicture ptr, byval as BOOL) as HRESULT
	PictureChanged as function(byval as IPicture ptr) as HRESULT
	SaveAsFile as function(byval as IPicture ptr, byval as LPSTREAM, byval as BOOL, byval as LONG ptr) as HRESULT
	get_Attributes as function(byval as IPicture ptr, byval as PDWORD) as HRESULT
end type

#define IPicture_QueryInterface(p,a,b) (p)->lpVtbl->QueryInterface(p,a,b)
#define IPicture_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IPicture_Release(p) (p)->lpVtbl->Release(p)
#define IPicture_get_Handle(p,a) (p)->lpVtbl->get_Handle(p,a)
#define IPicture_get_hPal(p,a) (p)->lpVtbl->get_hPal(p,a)
#define IPicture_get_Type(p,a) (p)->lpVtbl->get_Type(p,a)
#define IPicture_get_Width(p,a) (p)->lpVtbl->get_Width(p,a)
#define IPicture_get_Height(p,a) (p)->lpVtbl->get_Height(p,a)
#define IPicture_Render(p,a,b,c,d,e,f,g,h,i,j) (p)->lpVtbl->Render(p,a,b,c,d,e,f,g,h,i,j)
#define IPicture_set_hPal(p,a) (p)->lpVtbl->set_hPal(p,a)
#define IPicture_get_CurDC(p,a) (p)->lpVtbl->get_CurDC(p,a)
#define IPicture_SelectPicture(p,a,b,c) (p)->lpVtbl->SelectPicture(p,a,b,c)
#define IPicture_get_KeepOriginalFormat(p,a) (p)->lpVtbl->get_KeepOriginalFormat(p,a)
#define IPicture_put_KeepOriginalFormat(p,a) (p)->lpVtbl->put_KeepOriginalFormat(p,a)
#define IPicture_PictureChanged(p) (p)->lpVtbl->PictureChanged(p)
#define IPicture_SaveAsFile(p,a,b,c) (p)->lpVtbl->SaveAsFile(p,a,b,c)
#define IPicture_get_Attributes(p,a) (p)->lpVtbl->get_Attributes(p,a)

extern IID_IPictureDisp alias "IID_IPictureDisp" as IID

type IPictureDispVtbl_ as IPictureDispVtbl

type IPictureDisp
	lpVtbl as IPictureDispVtbl_ ptr
end type

type IPictureDispVtbl
	QueryInterface as function(byval as IPictureDisp ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IPictureDisp ptr) as ULONG
	Release as function(byval as IPictureDisp ptr) as ULONG
	GetTypeInfoCount as function(byval as IPictureDisp ptr, byval as UINT ptr) as HRESULT
	GetTypeInfo as function(byval as IPictureDisp ptr, byval as UINT, byval as LCID, byval as LPTYPEINFO ptr) as HRESULT
	GetIDsOfNames as function(byval as IPictureDisp ptr, byval as IID ptr, byval as LPOLESTR ptr, byval as UINT, byval as LCID, byval as DISPID ptr) as HRESULT
	Invoke as function(byval as IPictureDisp ptr, byval as DISPID, byval as IID ptr, byval as LCID, byval as WORD, byval as DISPPARAMS ptr, byval as VARIANT ptr, byval as EXCEPINFO ptr, byval as UINT ptr) as HRESULT
end type
extern IID_IOleInPlaceSiteEx alias "IID_IOleInPlaceSiteEx" as IID

type IOleInPlaceSiteExVtbl_ as IOleInPlaceSiteExVtbl

type IOleInPlaceSiteEx
	lpVtbl as IOleInPlaceSiteExVtbl_ ptr
end type

type IOleInPlaceSiteExVtbl
	QueryInterface as function(byval as IOleInPlaceSiteEx ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IOleInPlaceSiteEx ptr) as ULONG
	Release as function(byval as IOleInPlaceSiteEx ptr) as ULONG
	GetWindow as function(byval as IOleInPlaceSiteEx ptr, byval as HWND ptr) as HRESULT
	ContextSensitiveHelp as function(byval as IOleInPlaceSiteEx ptr, byval as BOOL) as HRESULT
	CanInPlaceActivate as function(byval as IOleInPlaceSiteEx ptr) as HRESULT
	OnInPlaceActivate as function(byval as IOleInPlaceSiteEx ptr) as HRESULT
	OnUIActivate as function(byval as IOleInPlaceSiteEx ptr) as HRESULT
	GetWindowContext as function(byval as IOleInPlaceSiteEx ptr, byval as IOleInPlaceFrame ptr ptr, byval as IOleInPlaceUIWindow ptr ptr, byval as LPRECT, byval as LPRECT, byval as LPOLEINPLACEFRAMEINFO) as HRESULT
	Scroll as function(byval as IOleInPlaceSiteEx ptr, byval as SIZE) as HRESULT
	OnUIDeactivate as function(byval as IOleInPlaceSiteEx ptr, byval as BOOL) as HRESULT
	OnInPlaceDeactivate as function(byval as IOleInPlaceSiteEx ptr) as HRESULT
	DiscardUndoState as function(byval as IOleInPlaceSiteEx ptr) as HRESULT
	DeactivateAndUndo as function(byval as IOleInPlaceSiteEx ptr) as HRESULT
	OnPosRectChange as function(byval as IOleInPlaceSiteEx ptr, byval as LPCRECT) as HRESULT
	OnInPlaceActivateEx as function(byval as IOleInPlaceSiteEx ptr, byval as BOOL ptr, byval as DWORD) as HRESULT
	OnInPlaceDeactivateEx as function(byval as IOleInPlaceSiteEx ptr, byval as BOOL) as HRESULT
	RequestUIActivate as function(byval as IOleInPlaceSiteEx ptr) as HRESULT
end type
extern IID_IObjectWithSite alias "IID_IObjectWithSite" as IID

type IObjectWithSiteVtbl_ as IObjectWithSiteVtbl

type IObjectWithSite
	lpVtbl as IObjectWithSiteVtbl_ ptr
end type

type IObjectWithSiteVtbl
	QueryInterface as function(byval as IObjectWithSite ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IObjectWithSite ptr) as ULONG
	Release as function(byval as IObjectWithSite ptr) as ULONG
	SetSite as function(byval as IObjectWithSite ptr, byval as IUnknown ptr) as HRESULT
	GetSite as function(byval as IObjectWithSite ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
end type
extern IID_IOleInPlaceSiteWindowless alias "IID_IOleInPlaceSiteWindowless" as IID

type IOleInPlaceSiteWindowlessVtbl_ as IOleInPlaceSiteWindowlessVtbl

type IOleInPlaceSiteWindowless
	lpVtbl as IOleInPlaceSiteWindowlessVtbl_ ptr
end type

type IOleInPlaceSiteWindowlessVtbl
	QueryInterface as function(byval as IOleInPlaceSiteWindowless ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IOleInPlaceSiteWindowless ptr) as ULONG
	Release as function(byval as IOleInPlaceSiteWindowless ptr) as ULONG
	GetWindow as function(byval as IOleInPlaceSiteWindowless ptr, byval as HWND ptr) as HRESULT
	ContextSensitiveHelp as function(byval as IOleInPlaceSiteWindowless ptr, byval as BOOL) as HRESULT
	CanInPlaceActivate as function(byval as IOleInPlaceSiteWindowless ptr) as HRESULT
	OnInPlaceActivate as function(byval as IOleInPlaceSiteWindowless ptr) as HRESULT
	OnUIActivate as function(byval as IOleInPlaceSiteWindowless ptr) as HRESULT
	GetWindowContext as function(byval as IOleInPlaceSiteWindowless ptr, byval as IOleInPlaceFrame ptr ptr, byval as IOleInPlaceUIWindow ptr ptr, byval as LPRECT, byval as LPRECT, byval as LPOLEINPLACEFRAMEINFO) as HRESULT
	Scroll as function(byval as IOleInPlaceSiteWindowless ptr, byval as SIZE) as HRESULT
	OnUIDeactivate as function(byval as IOleInPlaceSiteWindowless ptr, byval as BOOL) as HRESULT
	OnInPlaceDeactivate as function(byval as IOleInPlaceSiteWindowless ptr) as HRESULT
	DiscardUndoState as function(byval as IOleInPlaceSiteWindowless ptr) as HRESULT
	DeactivateAndUndo as function(byval as IOleInPlaceSiteWindowless ptr) as HRESULT
	OnPosRectChange as function(byval as IOleInPlaceSiteWindowless ptr, byval as LPCRECT) as HRESULT
	OnInPlaceActivateEx as function(byval as IOleInPlaceSiteWindowless ptr, byval as BOOL ptr, byval as DWORD) as HRESULT
	OnInPlaceDeactivateEx as function(byval as IOleInPlaceSiteWindowless ptr, byval as BOOL) as HRESULT
	RequestUIActivate as function(byval as IOleInPlaceSiteWindowless ptr) as HRESULT
	CanWindowlessActivate as function(byval as IOleInPlaceSiteWindowless ptr) as HRESULT
	GetCapture as function(byval as IOleInPlaceSiteWindowless ptr) as HRESULT
	SetCapture as function(byval as IOleInPlaceSiteWindowless ptr, byval as BOOL) as HRESULT
	GetFocus as function(byval as IOleInPlaceSiteWindowless ptr) as HRESULT
	SetFocus as function(byval as IOleInPlaceSiteWindowless ptr, byval as BOOL) as HRESULT
	GetDC as function(byval as IOleInPlaceSiteWindowless ptr, byval as LPCRECT, byval as DWORD, byval as HDC ptr) as HRESULT
	ReleaseDC as function(byval as IOleInPlaceSiteWindowless ptr, byval as HDC) as HRESULT
	InvalidateRect as function(byval as IOleInPlaceSiteWindowless ptr, byval as LPCRECT, byval as BOOL) as HRESULT
	InvalidateRgn as function(byval as IOleInPlaceSiteWindowless ptr, byval as HRGN, byval as BOOL) as HRESULT
	ScrollRect as function(byval as IOleInPlaceSiteWindowless ptr, byval as INT_, byval as INT_, byval as LPCRECT, byval as LPCRECT) as HRESULT
	AdjustRect as function(byval as IOleInPlaceSiteWindowless ptr, byval as LPCRECT) as HRESULT
	OnDefWindowMessage as function(byval as IOleInPlaceSiteWindowless ptr, byval as UINT, byval as WPARAM, byval as LPARAM, byval as LONG ptr) as HRESULT
end type
extern IID_IAdviseSinkEx alias "IID_IAdviseSinkEx" as IID

type IAdviseSinkExVtbl_ as IAdviseSinkExVtbl

type IAdviseSinkEx
	lpVtbl as IAdviseSinkExVtbl_ ptr
end type

type IAdviseSinkExVtbl
	QueryInterface as function(byval as IAdviseSinkEx ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IAdviseSinkEx ptr) as ULONG
	Release as function(byval as IAdviseSinkEx ptr) as ULONG
	OnDataChange as sub(byval as IAdviseSinkEx ptr, byval as FORMATETC ptr, byval as STGMEDIUM ptr)
	OnViewChange as sub(byval as IAdviseSinkEx ptr, byval as DWORD, byval as LONG)
	OnRename as sub(byval as IAdviseSinkEx ptr, byval as IMoniker ptr)
	OnSave as sub(byval as IAdviseSinkEx ptr)
	OnClose as sub(byval as IAdviseSinkEx ptr)
	OnViewStatusChange as function(byval as IAdviseSinkEx ptr, byval as DWORD) as HRESULT
end type
extern IID_IPointerInactive alias "IID_IPointerInactive" as IID

type IPointerInactiveVtbl_ as IPointerInactiveVtbl

type IPointerInactive
	lpVtbl as IPointerInactiveVtbl_ ptr
end type

type IPointerInactiveVtbl
	QueryInterface as function(byval as IPointerInactive ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IPointerInactive ptr) as ULONG
	Release as function(byval as IPointerInactive ptr) as ULONG
	GetActivationPolicy as function(byval as IPointerInactive ptr, byval as DWORD ptr) as HRESULT
	OnInactiveMouseMove as function(byval as IPointerInactive ptr, byval as LPCRECT, byval as LONG, byval as LONG, byval as DWORD) as HRESULT
	OnInactiveSetCursor as function(byval as IPointerInactive ptr, byval as LPCRECT, byval as LONG, byval as LONG, byval as DWORD, byval as BOOL) as HRESULT
end type
extern IID_IOleUndoUnit alias "IID_IOleUndoUnit" as IID

type IOleUndoUnitVtbl_ as IOleUndoUnitVtbl

type IOleUndoUnit
	lpVtbl as IOleUndoUnitVtbl_ ptr
end type

type IOleUndoUnitVtbl
	QueryInterface as function(byval as IOleUndoUnit ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IOleUndoUnit ptr) as ULONG
	Release as function(byval as IOleUndoUnit ptr) as ULONG
	Do as function(byval as IOleUndoUnit ptr, byval as LPOLEUNDOMANAGER) as HRESULT
	GetDescription as function(byval as IOleUndoUnit ptr, byval as BSTR ptr) as HRESULT
	GetUnitType as function(byval as IOleUndoUnit ptr, byval as CLSID ptr, byval as LONG ptr) as HRESULT
	OnNextAdd as function(byval as IOleUndoUnit ptr) as HRESULT
end type
extern IID_IOleParentUndoUnit alias "IID_IOleParentUndoUnit" as IID

type IOleParentUndoUnitVtbl_ as IOleParentUndoUnitVtbl

type IOleParentUndoUnit
	lpVtbl as IOleParentUndoUnitVtbl_ ptr
end type

type IOleParentUndoUnitVtbl
	QueryInterface as function(byval as IOleParentUndoUnit ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IOleParentUndoUnit ptr) as ULONG
	Release as function(byval as IOleParentUndoUnit ptr) as ULONG
	Do as function(byval as IOleParentUndoUnit ptr, byval as LPOLEUNDOMANAGER) as HRESULT
	GetDescription as function(byval as IOleParentUndoUnit ptr, byval as BSTR ptr) as HRESULT
	GetUnitType as function(byval as IOleParentUndoUnit ptr, byval as CLSID ptr, byval as LONG ptr) as HRESULT
	OnNextAdd as function(byval as IOleParentUndoUnit ptr) as HRESULT
	Open as function(byval as IOleParentUndoUnit ptr, byval as IOleParentUndoUnit ptr) as HRESULT
	Close as function(byval as IOleParentUndoUnit ptr, byval as IOleParentUndoUnit ptr, byval as BOOL) as HRESULT
	Add as function(byval as IOleParentUndoUnit ptr, byval as IOleUndoUnit ptr) as HRESULT
	FindUnit as function(byval as IOleParentUndoUnit ptr, byval as IOleUndoUnit ptr) as HRESULT
	GetParentState as function(byval as IOleParentUndoUnit ptr, byval as DWORD ptr) as HRESULT
end type
extern IID_IEnumOleUndoUnits alias "IID_IEnumOleUndoUnits" as IID

type IEnumOleUndoUnitsVtbl_ as IEnumOleUndoUnitsVtbl

type IEnumOleUndoUnits
	lpVtbl as IEnumOleUndoUnitsVtbl_ ptr
end type

type IEnumOleUndoUnitsVtbl
	QueryInterface as function(byval as IEnumOleUndoUnits ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IEnumOleUndoUnits ptr) as ULONG
	Release as function(byval as IEnumOleUndoUnits ptr) as ULONG
	Next as function(byval as IEnumOleUndoUnits ptr, byval as ULONG, byval as IOleUndoUnit ptr ptr, byval as ULONG ptr) as HRESULT
	Skip as function(byval as IEnumOleUndoUnits ptr, byval as ULONG) as HRESULT
	Reset as function(byval as IEnumOleUndoUnits ptr) as HRESULT
	Clone as function(byval as IEnumOleUndoUnits ptr, byval as IEnumOleUndoUnits ptr ptr) as HRESULT
end type
extern IID_IOleUndoManager alias "IID_IOleUndoManager" as IID

type IOleUndoManagerVtbl_ as IOleUndoManagerVtbl

type IOleUndoManager
	lpVtbl as IOleUndoManagerVtbl_ ptr
end type

type IOleUndoManagerVtbl
	QueryInterface as function(byval as IOleUndoManager ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IOleUndoManager ptr) as ULONG
	Release as function(byval as IOleUndoManager ptr) as ULONG
	Open as function(byval as IOleUndoManager ptr, byval as IOleParentUndoUnit ptr) as HRESULT
	Close as function(byval as IOleUndoManager ptr, byval as IOleParentUndoUnit ptr, byval as BOOL) as HRESULT
	Add as function(byval as IOleUndoManager ptr, byval as IOleUndoUnit ptr) as HRESULT
	GetOpenParentState as function(byval as IOleUndoManager ptr, byval as DWORD ptr) as HRESULT
	DiscardFrom as function(byval as IOleUndoManager ptr, byval as IOleUndoUnit ptr) as HRESULT
	UndoTo as function(byval as IOleUndoManager ptr, byval as IOleUndoUnit ptr) as HRESULT
	RedoTo as function(byval as IOleUndoManager ptr, byval as IOleUndoUnit ptr) as HRESULT
	EnumUndoable as function(byval as IOleUndoManager ptr, byval as IEnumOleUndoUnits ptr ptr) as HRESULT
	EnumRedoable as function(byval as IOleUndoManager ptr, byval as IEnumOleUndoUnits ptr ptr) as HRESULT
	GetLastUndoDescription as function(byval as IOleUndoManager ptr, byval as BSTR ptr) as HRESULT
	GetLastRedoDescription as function(byval as IOleUndoManager ptr, byval as BSTR ptr) as HRESULT
	Enable as function(byval as IOleUndoManager ptr, byval as BOOL) as HRESULT
end type

enum QACONTAINERFLAGS
	QACONTAINER_SHOWHATCHING = 1
	QACONTAINER_SHOWGRABHANDLES = 2
	QACONTAINER_USERMODE = 4
	QACONTAINER_DISPLAYASDEFAULT = 8
	QACONTAINER_UIDEAD = 16
	QACONTAINER_AUTOCLIP = 32
	QACONTAINER_MESSAGEREFLECT = 64
	QACONTAINER_SUPPORTSMNEMONICS = 128
end enum

type IBindHost_ as IBindHost
type IServiceProvider_ as IServiceProvider

type QACONTAINER
	cbSize as ULONG
	pClientSite as IOleClientSite ptr
	pAdviseSink as IAdviseSinkEx ptr
	pPropertyNotifySink as IPropertyNotifySink ptr
	pUnkEventSink as IUnknown ptr
	dwAmbientFlags as DWORD
	colorFore as OLE_COLOR
	colorBack as OLE_COLOR
	pFont as IFont ptr
	pUndoMgr as IOleUndoManager ptr
	dwAppearance as DWORD
	lcid as LONG
	hpal as HPALETTE
	pBindHost as IBindHost_ ptr
	pOleControlSite as IOleControlSite ptr
	pServiceProvider as IServiceProvider_ ptr
end type

extern IID_IQuickActivate alias "IID_IQuickActivate" as IID

type IQuickActivateVtbl_ as IQuickActivateVtbl

type IQuickActivate
	lpVtbl as IQuickActivateVtbl_ ptr
end type

type IQuickActivateVtbl
	QueryInterface as function(byval as IQuickActivate ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IQuickActivate ptr) as ULONG
	Release as function(byval as IQuickActivate ptr) as ULONG
	QuickActivate as function(byval as IQuickActivate ptr, byval as QACONTAINER ptr, byval as QACONTROL ptr) as HRESULT
	SetContentExtent as function(byval as IQuickActivate ptr, byval as LPSIZEL) as HRESULT
	GetContentExtent as function(byval as IQuickActivate ptr, byval as LPSIZEL) as HRESULT
end type

#endif
