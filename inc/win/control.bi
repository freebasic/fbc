''
''
'' control -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_control_bi__
#define __win_control_bi__

#include once "win/rpc.bi"
#include once "win/rpcndr.bi"

type IAMCollection_ as IAMCollection
type IMediaControl_ as IMediaControl
type IMediaEvent_ as IMediaEvent
type IMediaEventEx_ as IMediaEventEx
type IMediaPosition_ as IMediaPosition
type IBasicAudio_ as IBasicAudio
type IVideoWindow_ as IVideoWindow
type IBasicVideo_ as IBasicVideo
type IBasicVideo2_ as IBasicVideo2
type IDeferredCommand_ as IDeferredCommand
type IQueueCommand_ as IQueueCommand
type FilgraphManager_ as FilgraphManager
type IFilterInfo_ as IFilterInfo
type IRegFilterInfo_ as IRegFilterInfo
type IMediaTypeInfo_ as IMediaTypeInfo
type IPinInfo_ as IPinInfo
type IAMStats_ as IAMStats

type REFTIME as double
type OAEVENT as LONG_PTR
type OAHWND as LONG_PTR
type OAFilterState as integer

extern LIBID_QuartzTypeLib alias "LIBID_QuartzTypeLib" as GUID
extern IID_IAMCollection alias "IID_IAMCollection" as GUID

type IAMCollectionVtbl_ as IAMCollectionVtbl

type IAMCollection
    lpVtbl as IAMCollectionVtbl_ ptr
end type

type IAMCollectionVtbl
    QueryInterface as function(byval as IAMCollection ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
    AddRef as function(byval as IAMCollection ptr) as ULONG
    Release as function(byval as IAMCollection ptr) as ULONG
    GetTypeInfoCount as function(byval as IAMCollection ptr, byval as UINT ptr) as HRESULT
    GetTypeInfo as function(byval as IAMCollection ptr, byval as UINT, byval as LCID, byval as ITypeInfo ptr ptr) as HRESULT
    GetIDsOfNames as function(byval as IAMCollection ptr, byval as IID ptr, byval as LPOLESTR ptr, byval as UINT, byval as LCID, byval as DISPID ptr) as HRESULT
    Invoke as function(byval as IAMCollection ptr, byval as DISPID, byval as IID ptr, byval as LCID, byval as WORD, byval as DISPPARAMS ptr, byval as VARIANT_ ptr, byval as EXCEPINFO ptr, byval as UINT ptr) as HRESULT
    get_Count as function(byval as IAMCollection ptr, byval as LONG ptr) as HRESULT
    Item as function(byval as IAMCollection ptr, byval as integer, byval as IUnknown ptr ptr) as HRESULT
    get__NewEnum as function(byval as IAMCollection ptr, byval as IUnknown ptr ptr) as HRESULT
end type

#define IAMCollection_QueryInterface(This,riid,ppvObject) (This)->lpVtbl -> QueryInterface(This,riid,ppvObject)
#define IAMCollection_AddRef(This) (This)->lpVtbl -> AddRef(This)
#define IAMCollection_Release(This) (This)->lpVtbl -> Release(This)
#define IAMCollection_GetTypeInfoCount(This,pctinfo) (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo)
#define IAMCollection_GetTypeInfo(This,iTInfo,lcid,ppTInfo) (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo)
#define IAMCollection_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)
#define IAMCollection_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)
#define IAMCollection_get_Count(This,plCount) (This)->lpVtbl -> get_Count(This,plCount)
#define IAMCollection_Item(This,lItem,ppUnk) (This)->lpVtbl -> Item(This,lItem,ppUnk)
#define IAMCollection_get__NewEnum(This,ppUnk) (This)->lpVtbl -> get__NewEnum(This,ppUnk)

extern IID_IMediaControl alias "IID_IMediaControl" as GUID

type IMediaControlVtbl_ as IMediaControlVtbl

type IMediaControl
    lpVtbl as IMediaControlVtbl_ ptr
end type

type IMediaControlVtbl
    QueryInterface as function(byval as IMediaControl ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
    AddRef as function(byval as IMediaControl ptr) as ULONG
    Release as function(byval as IMediaControl ptr) as ULONG
    GetTypeInfoCount as function(byval as IMediaControl ptr, byval as UINT ptr) as HRESULT
    GetTypeInfo as function(byval as IMediaControl ptr, byval as UINT, byval as LCID, byval as ITypeInfo ptr ptr) as HRESULT
    GetIDsOfNames as function(byval as IMediaControl ptr, byval as IID ptr, byval as LPOLESTR ptr, byval as UINT, byval as LCID, byval as DISPID ptr) as HRESULT
    Invoke as function(byval as IMediaControl ptr, byval as DISPID, byval as IID ptr, byval as LCID, byval as WORD, byval as DISPPARAMS ptr, byval as VARIANT_ ptr, byval as EXCEPINFO ptr, byval as UINT ptr) as HRESULT
    Run as function(byval as IMediaControl ptr) as HRESULT
    Pause as function(byval as IMediaControl ptr) as HRESULT
    Stop as function(byval as IMediaControl ptr) as HRESULT
    GetState as function(byval as IMediaControl ptr, byval as LONG, byval as OAFilterState ptr) as HRESULT
    RenderFile as function(byval as IMediaControl ptr, byval as BSTR) as HRESULT
    AddSourceFilter as function(byval as IMediaControl ptr, byval as BSTR, byval as IDispatch ptr ptr) as HRESULT
    get_FilterCollection as function(byval as IMediaControl ptr, byval as IDispatch ptr ptr) as HRESULT
    get_RegFilterCollection as function(byval as IMediaControl ptr, byval as IDispatch ptr ptr) as HRESULT
    StopWhenReady as function(byval as IMediaControl ptr) as HRESULT
end type

#define IMediaControl_QueryInterface(This,riid,ppvObject) (This)->lpVtbl -> QueryInterface(This,riid,ppvObject)
#define IMediaControl_AddRef(This) (This)->lpVtbl -> AddRef(This)
#define IMediaControl_Release(This) (This)->lpVtbl -> Release(This)
#define IMediaControl_GetTypeInfoCount(This,pctinfo) (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo)
#define IMediaControl_GetTypeInfo(This,iTInfo,lcid,ppTInfo) (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo)
#define IMediaControl_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)
#define IMediaControl_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)
#define IMediaControl_Run(This) (This)->lpVtbl -> Run(This)
#define IMediaControl_Pause(This) (This)->lpVtbl -> Pause(This)
#define IMediaControl_Stop(This) (This)->lpVtbl -> Stop(This)
#define IMediaControl_GetState(This,msTimeout,pfs) (This)->lpVtbl -> GetState(This,msTimeout,pfs)
#define IMediaControl_RenderFile(This,strFilename) (This)->lpVtbl -> RenderFile(This,strFilename)
#define IMediaControl_AddSourceFilter(This,strFilename,ppUnk) (This)->lpVtbl -> AddSourceFilter(This,strFilename,ppUnk)
#define IMediaControl_get_FilterCollection(This,ppUnk) (This)->lpVtbl -> get_FilterCollection(This,ppUnk)
#define IMediaControl_get_RegFilterCollection(This,ppUnk) (This)->lpVtbl -> get_RegFilterCollection(This,ppUnk)
#define IMediaControl_StopWhenReady(This) (This)->lpVtbl -> StopWhenReady(This)

extern IID_IMediaEvent alias "IID_IMediaEvent" as GUID

type IMediaEventVtbl_ as IMediaEventVtbl

type IMediaEvent
    lpVtbl as IMediaEventVtbl_ ptr
end type

type IMediaEventVtbl
    QueryInterface as function(byval as IMediaEvent ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
    AddRef as function(byval as IMediaEvent ptr) as ULONG
    Release as function(byval as IMediaEvent ptr) as ULONG
    GetTypeInfoCount as function(byval as IMediaEvent ptr, byval as UINT ptr) as HRESULT
    GetTypeInfo as function(byval as IMediaEvent ptr, byval as UINT, byval as LCID, byval as ITypeInfo ptr ptr) as HRESULT
    GetIDsOfNames as function(byval as IMediaEvent ptr, byval as IID ptr, byval as LPOLESTR ptr, byval as UINT, byval as LCID, byval as DISPID ptr) as HRESULT
    Invoke as function(byval as IMediaEvent ptr, byval as DISPID, byval as IID ptr, byval as LCID, byval as WORD, byval as DISPPARAMS ptr, byval as VARIANT_ ptr, byval as EXCEPINFO ptr, byval as UINT ptr) as HRESULT
    GetEventHandle as function(byval as IMediaEvent ptr, byval as OAEVENT ptr) as HRESULT
    GetEvent as function(byval as IMediaEvent ptr, byval as integer ptr, byval as LONG_PTR ptr, byval as LONG_PTR ptr, byval as integer) as HRESULT
    WaitForCompletion as function(byval as IMediaEvent ptr, byval as integer, byval as integer ptr) as HRESULT
    CancelDefaultHandling as function(byval as IMediaEvent ptr, byval as integer) as HRESULT
    RestoreDefaultHandling as function(byval as IMediaEvent ptr, byval as integer) as HRESULT
    FreeEventParams as function(byval as IMediaEvent ptr, byval as integer, byval as LONG_PTR, byval as LONG_PTR) as HRESULT
end type

#define IMediaEvent_QueryInterface(This,riid,ppvObject) (This)->lpVtbl -> QueryInterface(This,riid,ppvObject)
#define IMediaEvent_AddRef(This) (This)->lpVtbl -> AddRef(This)
#define IMediaEvent_Release(This) (This)->lpVtbl -> Release(This)
#define IMediaEvent_GetTypeInfoCount(This,pctinfo) (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo)
#define IMediaEvent_GetTypeInfo(This,iTInfo,lcid,ppTInfo) (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo)
#define IMediaEvent_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)
#define IMediaEvent_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)
#define IMediaEvent_GetEventHandle(This,hEvent) (This)->lpVtbl -> GetEventHandle(This,hEvent)
#define IMediaEvent_GetEvent(This,lEventCode,lParam1,lParam2,msTimeout) (This)->lpVtbl -> GetEvent(This,lEventCode,lParam1,lParam2,msTimeout)
#define IMediaEvent_WaitForCompletion(This,msTimeout,pEvCode) (This)->lpVtbl -> WaitForCompletion(This,msTimeout,pEvCode)
#define IMediaEvent_CancelDefaultHandling(This,lEvCode) (This)->lpVtbl -> CancelDefaultHandling(This,lEvCode)
#define IMediaEvent_RestoreDefaultHandling(This,lEvCode) (This)->lpVtbl -> RestoreDefaultHandling(This,lEvCode)
#define IMediaEvent_FreeEventParams(This,lEvCode,lParam1,lParam2) (This)->lpVtbl -> FreeEventParams(This,lEvCode,lParam1,lParam2)

extern IID_IMediaEventEx alias "IID_IMediaEventEx" as GUID

type IMediaEventExVtbl_ as IMediaEventExVtbl

type IMediaEventEx
    lpVtbl as IMediaEventExVtbl_ ptr
end type

type IMediaEventExVtbl
    QueryInterface as function(byval as IMediaEventEx ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
    AddRef as function(byval as IMediaEventEx ptr) as ULONG
    Release as function(byval as IMediaEventEx ptr) as ULONG
    GetTypeInfoCount as function(byval as IMediaEventEx ptr, byval as UINT ptr) as HRESULT
    GetTypeInfo as function(byval as IMediaEventEx ptr, byval as UINT, byval as LCID, byval as ITypeInfo ptr ptr) as HRESULT
    GetIDsOfNames as function(byval as IMediaEventEx ptr, byval as IID ptr, byval as LPOLESTR ptr, byval as UINT, byval as LCID, byval as DISPID ptr) as HRESULT
    Invoke as function(byval as IMediaEventEx ptr, byval as DISPID, byval as IID ptr, byval as LCID, byval as WORD, byval as DISPPARAMS ptr, byval as VARIANT_ ptr, byval as EXCEPINFO ptr, byval as UINT ptr) as HRESULT
    GetEventHandle as function(byval as IMediaEventEx ptr, byval as OAEVENT ptr) as HRESULT
    GetEvent as function(byval as IMediaEventEx ptr, byval as integer ptr, byval as LONG_PTR ptr, byval as LONG_PTR ptr, byval as integer) as HRESULT
    WaitForCompletion as function(byval as IMediaEventEx ptr, byval as integer, byval as integer ptr) as HRESULT
    CancelDefaultHandling as function(byval as IMediaEventEx ptr, byval as integer) as HRESULT
    RestoreDefaultHandling as function(byval as IMediaEventEx ptr, byval as integer) as HRESULT
    FreeEventParams as function(byval as IMediaEventEx ptr, byval as integer, byval as LONG_PTR, byval as LONG_PTR) as HRESULT
    SetNotifyWindow as function(byval as IMediaEventEx ptr, byval as OAHWND, byval as integer, byval as LONG_PTR) as HRESULT
    SetNotifyFlags as function(byval as IMediaEventEx ptr, byval as integer) as HRESULT
    GetNotifyFlags as function(byval as IMediaEventEx ptr, byval as integer ptr) as HRESULT
end type

#define IMediaEventEx_QueryInterface(This,riid,ppvObject) (This)->lpVtbl -> QueryInterface(This,riid,ppvObject)
#define IMediaEventEx_AddRef(This) (This)->lpVtbl -> AddRef(This)
#define IMediaEventEx_Release(This) (This)->lpVtbl -> Release(This)
#define IMediaEventEx_GetTypeInfoCount(This,pctinfo) (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo)
#define IMediaEventEx_GetTypeInfo(This,iTInfo,lcid,ppTInfo) (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo)
#define IMediaEventEx_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)
#define IMediaEventEx_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)
#define IMediaEventEx_GetEventHandle(This,hEvent) (This)->lpVtbl -> GetEventHandle(This,hEvent)
#define IMediaEventEx_GetEvent(This,lEventCode,lParam1,lParam2,msTimeout) (This)->lpVtbl -> GetEvent(This,lEventCode,lParam1,lParam2,msTimeout)
#define IMediaEventEx_WaitForCompletion(This,msTimeout,pEvCode) (This)->lpVtbl -> WaitForCompletion(This,msTimeout,pEvCode)
#define IMediaEventEx_CancelDefaultHandling(This,lEvCode) (This)->lpVtbl -> CancelDefaultHandling(This,lEvCode)
#define IMediaEventEx_RestoreDefaultHandling(This,lEvCode) (This)->lpVtbl -> RestoreDefaultHandling(This,lEvCode)
#define IMediaEventEx_FreeEventParams(This,lEvCode,lParam1,lParam2) (This)->lpVtbl -> FreeEventParams(This,lEvCode,lParam1,lParam2)
#define IMediaEventEx_SetNotifyWindow(This,hwnd,lMsg,lInstanceData) (This)->lpVtbl -> SetNotifyWindow(This,hwnd,lMsg,lInstanceData)
#define IMediaEventEx_SetNotifyFlags(This,lNoNotifyFlags) (This)->lpVtbl -> SetNotifyFlags(This,lNoNotifyFlags)
#define IMediaEventEx_GetNotifyFlags(This,lplNoNotifyFlags) (This)->lpVtbl -> GetNotifyFlags(This,lplNoNotifyFlags)

extern IID_IMediaPosition alias "IID_IMediaPosition" as GUID

type IMediaPositionVtbl_ as IMediaPositionVtbl

type IMediaPosition
    lpVtbl as IMediaPositionVtbl_ ptr
end type

type IMediaPositionVtbl
    QueryInterface as function(byval as IMediaPosition ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
    AddRef as function(byval as IMediaPosition ptr) as ULONG
    Release as function(byval as IMediaPosition ptr) as ULONG
    GetTypeInfoCount as function(byval as IMediaPosition ptr, byval as UINT ptr) as HRESULT
    GetTypeInfo as function(byval as IMediaPosition ptr, byval as UINT, byval as LCID, byval as ITypeInfo ptr ptr) as HRESULT
    GetIDsOfNames as function(byval as IMediaPosition ptr, byval as IID ptr, byval as LPOLESTR ptr, byval as UINT, byval as LCID, byval as DISPID ptr) as HRESULT
    Invoke as function(byval as IMediaPosition ptr, byval as DISPID, byval as IID ptr, byval as LCID, byval as WORD, byval as DISPPARAMS ptr, byval as VARIANT_ ptr, byval as EXCEPINFO ptr, byval as UINT ptr) as HRESULT
    get_Duration as function(byval as IMediaPosition ptr, byval as REFTIME ptr) as HRESULT
    put_CurrentPosition as function(byval as IMediaPosition ptr, byval as REFTIME) as HRESULT
    get_CurrentPosition as function(byval as IMediaPosition ptr, byval as REFTIME ptr) as HRESULT
    get_StopTime as function(byval as IMediaPosition ptr, byval as REFTIME ptr) as HRESULT
    put_StopTime as function(byval as IMediaPosition ptr, byval as REFTIME) as HRESULT
    get_PrerollTime as function(byval as IMediaPosition ptr, byval as REFTIME ptr) as HRESULT
    put_PrerollTime as function(byval as IMediaPosition ptr, byval as REFTIME) as HRESULT
    put_Rate as function(byval as IMediaPosition ptr, byval as double) as HRESULT
    get_Rate as function(byval as IMediaPosition ptr, byval as double ptr) as HRESULT
    CanSeekForward as function(byval as IMediaPosition ptr, byval as LONG ptr) as HRESULT
    CanSeekBackward as function(byval as IMediaPosition ptr, byval as LONG ptr) as HRESULT
end type

#define IMediaPosition_QueryInterface(This,riid,ppvObject) (This)->lpVtbl -> QueryInterface(This,riid,ppvObject)
#define IMediaPosition_AddRef(This) (This)->lpVtbl -> AddRef(This)
#define IMediaPosition_Release(This) (This)->lpVtbl -> Release(This)
#define IMediaPosition_GetTypeInfoCount(This,pctinfo) (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo)
#define IMediaPosition_GetTypeInfo(This,iTInfo,lcid,ppTInfo) (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo)
#define IMediaPosition_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)
#define IMediaPosition_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)
#define IMediaPosition_get_Duration(This,plength) (This)->lpVtbl -> get_Duration(This,plength)
#define IMediaPosition_put_CurrentPosition(This,llTime) (This)->lpVtbl -> put_CurrentPosition(This,llTime)
#define IMediaPosition_get_CurrentPosition(This,pllTime) (This)->lpVtbl -> get_CurrentPosition(This,pllTime)
#define IMediaPosition_get_StopTime(This,pllTime) (This)->lpVtbl -> get_StopTime(This,pllTime)
#define IMediaPosition_put_StopTime(This,llTime) (This)->lpVtbl -> put_StopTime(This,llTime)
#define IMediaPosition_get_PrerollTime(This,pllTime) (This)->lpVtbl -> get_PrerollTime(This,pllTime)
#define IMediaPosition_put_PrerollTime(This,llTime) (This)->lpVtbl -> put_PrerollTime(This,llTime)
#define IMediaPosition_put_Rate(This,dRate) (This)->lpVtbl -> put_Rate(This,dRate)
#define IMediaPosition_get_Rate(This,pdRate) (This)->lpVtbl -> get_Rate(This,pdRate)
#define IMediaPosition_CanSeekForward(This,pCanSeekForward) (This)->lpVtbl -> CanSeekForward(This,pCanSeekForward)
#define IMediaPosition_CanSeekBackward(This,pCanSeekBackward) (This)->lpVtbl -> CanSeekBackward(This,pCanSeekBackward)

extern IID_IBasicAudio alias "IID_IBasicAudio" as GUID

type IBasicAudioVtbl_ as IBasicAudioVtbl

type IBasicAudio
    lpVtbl as IBasicAudioVtbl_ ptr
end type

type IBasicAudioVtbl
    QueryInterface as function(byval as IBasicAudio ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
    AddRef as function(byval as IBasicAudio ptr) as ULONG
    Release as function(byval as IBasicAudio ptr) as ULONG
    GetTypeInfoCount as function(byval as IBasicAudio ptr, byval as UINT ptr) as HRESULT
    GetTypeInfo as function(byval as IBasicAudio ptr, byval as UINT, byval as LCID, byval as ITypeInfo ptr ptr) as HRESULT
    GetIDsOfNames as function(byval as IBasicAudio ptr, byval as IID ptr, byval as LPOLESTR ptr, byval as UINT, byval as LCID, byval as DISPID ptr) as HRESULT
    Invoke as function(byval as IBasicAudio ptr, byval as DISPID, byval as IID ptr, byval as LCID, byval as WORD, byval as DISPPARAMS ptr, byval as VARIANT_ ptr, byval as EXCEPINFO ptr, byval as UINT ptr) as HRESULT
    put_Volume as function(byval as IBasicAudio ptr, byval as integer) as HRESULT
    get_Volume as function(byval as IBasicAudio ptr, byval as integer ptr) as HRESULT
    put_Balance as function(byval as IBasicAudio ptr, byval as integer) as HRESULT
    get_Balance as function(byval as IBasicAudio ptr, byval as integer ptr) as HRESULT
end type

#define IBasicAudio_QueryInterface(This,riid,ppvObject) (This)->lpVtbl -> QueryInterface(This,riid,ppvObject)
#define IBasicAudio_AddRef(This) (This)->lpVtbl -> AddRef(This)
#define IBasicAudio_Release(This) (This)->lpVtbl -> Release(This)
#define IBasicAudio_GetTypeInfoCount(This,pctinfo) (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo)
#define IBasicAudio_GetTypeInfo(This,iTInfo,lcid,ppTInfo) (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo)
#define IBasicAudio_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)
#define IBasicAudio_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)
#define IBasicAudio_put_Volume(This,lVolume) (This)->lpVtbl -> put_Volume(This,lVolume)
#define IBasicAudio_get_Volume(This,plVolume) (This)->lpVtbl -> get_Volume(This,plVolume)
#define IBasicAudio_put_Balance(This,lBalance) (This)->lpVtbl -> put_Balance(This,lBalance)
#define IBasicAudio_get_Balance(This,plBalance) (This)->lpVtbl -> get_Balance(This,plBalance)

extern IID_IVideoWindow alias "IID_IVideoWindow" as GUID

type IVideoWindowVtbl_ as IVideoWindowVtbl

type IVideoWindow
    lpVtbl as IVideoWindowVtbl_ ptr
end type

type IVideoWindowVtbl
    QueryInterface as function(byval as IVideoWindow ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
    AddRef as function(byval as IVideoWindow ptr) as ULONG
    Release as function(byval as IVideoWindow ptr) as ULONG
    GetTypeInfoCount as function(byval as IVideoWindow ptr, byval as UINT ptr) as HRESULT
    GetTypeInfo as function(byval as IVideoWindow ptr, byval as UINT, byval as LCID, byval as ITypeInfo ptr ptr) as HRESULT
    GetIDsOfNames as function(byval as IVideoWindow ptr, byval as IID ptr, byval as LPOLESTR ptr, byval as UINT, byval as LCID, byval as DISPID ptr) as HRESULT
    Invoke as function(byval as IVideoWindow ptr, byval as DISPID, byval as IID ptr, byval as LCID, byval as WORD, byval as DISPPARAMS ptr, byval as VARIANT_ ptr, byval as EXCEPINFO ptr, byval as UINT ptr) as HRESULT
    put_Caption as function(byval as IVideoWindow ptr, byval as BSTR) as HRESULT
    get_Caption as function(byval as IVideoWindow ptr, byval as BSTR ptr) as HRESULT
    put_WindowStyle as function(byval as IVideoWindow ptr, byval as integer) as HRESULT
    get_WindowStyle as function(byval as IVideoWindow ptr, byval as integer ptr) as HRESULT
    put_WindowStyleEx as function(byval as IVideoWindow ptr, byval as integer) as HRESULT
    get_WindowStyleEx as function(byval as IVideoWindow ptr, byval as integer ptr) as HRESULT
    put_AutoShow as function(byval as IVideoWindow ptr, byval as integer) as HRESULT
    get_AutoShow as function(byval as IVideoWindow ptr, byval as integer ptr) as HRESULT
    put_WindowState as function(byval as IVideoWindow ptr, byval as integer) as HRESULT
    get_WindowState as function(byval as IVideoWindow ptr, byval as integer ptr) as HRESULT
    put_BackgroundPalette as function(byval as IVideoWindow ptr, byval as integer) as HRESULT
    get_BackgroundPalette as function(byval as IVideoWindow ptr, byval as integer ptr) as HRESULT
    put_Visible as function(byval as IVideoWindow ptr, byval as integer) as HRESULT
    get_Visible as function(byval as IVideoWindow ptr, byval as integer ptr) as HRESULT
    put_Left as function(byval as IVideoWindow ptr, byval as integer) as HRESULT
    get_Left as function(byval as IVideoWindow ptr, byval as integer ptr) as HRESULT
    put_Width as function(byval as IVideoWindow ptr, byval as integer) as HRESULT
    get_Width as function(byval as IVideoWindow ptr, byval as integer ptr) as HRESULT
    put_Top as function(byval as IVideoWindow ptr, byval as integer) as HRESULT
    get_Top as function(byval as IVideoWindow ptr, byval as integer ptr) as HRESULT
    put_Height as function(byval as IVideoWindow ptr, byval as integer) as HRESULT
    get_Height as function(byval as IVideoWindow ptr, byval as integer ptr) as HRESULT
    put_Owner as function(byval as IVideoWindow ptr, byval as OAHWND) as HRESULT
    get_Owner as function(byval as IVideoWindow ptr, byval as OAHWND ptr) as HRESULT
    put_MessageDrain as function(byval as IVideoWindow ptr, byval as OAHWND) as HRESULT
    get_MessageDrain as function(byval as IVideoWindow ptr, byval as OAHWND ptr) as HRESULT
    get_BorderColor as function(byval as IVideoWindow ptr, byval as integer ptr) as HRESULT
    put_BorderColor as function(byval as IVideoWindow ptr, byval as integer) as HRESULT
    get_FullScreenMode as function(byval as IVideoWindow ptr, byval as integer ptr) as HRESULT
    put_FullScreenMode as function(byval as IVideoWindow ptr, byval as integer) as HRESULT
    SetWindowForeground as function(byval as IVideoWindow ptr, byval as integer) as HRESULT
    NotifyOwnerMessage as function(byval as IVideoWindow ptr, byval as OAHWND, byval as integer, byval as LONG_PTR, byval as LONG_PTR) as HRESULT
    SetWindowPosition as function(byval as IVideoWindow ptr, byval as integer, byval as integer, byval as integer, byval as integer) as HRESULT
    GetWindowPosition as function(byval as IVideoWindow ptr, byval as integer ptr, byval as integer ptr, byval as integer ptr, byval as integer ptr) as HRESULT
    GetMinIdealImageSize as function(byval as IVideoWindow ptr, byval as integer ptr, byval as integer ptr) as HRESULT
    GetMaxIdealImageSize as function(byval as IVideoWindow ptr, byval as integer ptr, byval as integer ptr) as HRESULT
    GetRestorePosition as function(byval as IVideoWindow ptr, byval as integer ptr, byval as integer ptr, byval as integer ptr, byval as integer ptr) as HRESULT
    HideCursor as function(byval as IVideoWindow ptr, byval as integer) as HRESULT
    IsCursorHidden as function(byval as IVideoWindow ptr, byval as integer ptr) as HRESULT
end type

#define IVideoWindow_QueryInterface(This,riid,ppvObject) (This)->lpVtbl -> QueryInterface(This,riid,ppvObject)
#define IVideoWindow_AddRef(This) (This)->lpVtbl -> AddRef(This)
#define IVideoWindow_Release(This) (This)->lpVtbl -> Release(This)
#define IVideoWindow_GetTypeInfoCount(This,pctinfo) (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo)
#define IVideoWindow_GetTypeInfo(This,iTInfo,lcid,ppTInfo) (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo)
#define IVideoWindow_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)
#define IVideoWindow_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)
#define IVideoWindow_put_Caption(This,strCaption) (This)->lpVtbl -> put_Caption(This,strCaption)
#define IVideoWindow_get_Caption(This,strCaption) (This)->lpVtbl -> get_Caption(This,strCaption)
#define IVideoWindow_put_WindowStyle(This,WindowStyle) (This)->lpVtbl -> put_WindowStyle(This,WindowStyle)
#define IVideoWindow_get_WindowStyle(This,WindowStyle) (This)->lpVtbl -> get_WindowStyle(This,WindowStyle)
#define IVideoWindow_put_WindowStyleEx(This,WindowStyleEx) (This)->lpVtbl -> put_WindowStyleEx(This,WindowStyleEx)
#define IVideoWindow_get_WindowStyleEx(This,WindowStyleEx) (This)->lpVtbl -> get_WindowStyleEx(This,WindowStyleEx)
#define IVideoWindow_put_AutoShow(This,AutoShow) (This)->lpVtbl -> put_AutoShow(This,AutoShow)
#define IVideoWindow_get_AutoShow(This,AutoShow) (This)->lpVtbl -> get_AutoShow(This,AutoShow)
#define IVideoWindow_put_WindowState(This,WindowState) (This)->lpVtbl -> put_WindowState(This,WindowState)
#define IVideoWindow_get_WindowState(This,WindowState) (This)->lpVtbl -> get_WindowState(This,WindowState)
#define IVideoWindow_put_BackgroundPalette(This,BackgroundPalette) (This)->lpVtbl -> put_BackgroundPalette(This,BackgroundPalette)
#define IVideoWindow_get_BackgroundPalette(This,pBackgroundPalette) (This)->lpVtbl -> get_BackgroundPalette(This,pBackgroundPalette)
#define IVideoWindow_put_Visible(This,Visible) (This)->lpVtbl -> put_Visible(This,Visible)
#define IVideoWindow_get_Visible(This,pVisible) (This)->lpVtbl -> get_Visible(This,pVisible)
#define IVideoWindow_put_Left(This,Left_) (This)->lpVtbl -> put_Left(This,Left_)
#define IVideoWindow_get_Left(This,pLeft) (This)->lpVtbl -> get_Left(This,pLeft)
#define IVideoWindow_put_Width(This,Width_) (This)->lpVtbl -> put_Width(This,Width_)
#define IVideoWindow_get_Width(This,pWidth) (This)->lpVtbl -> get_Width(This,pWidth)
#define IVideoWindow_put_Top(This,Top) (This)->lpVtbl -> put_Top(This,Top)
#define IVideoWindow_get_Top(This,pTop) (This)->lpVtbl -> get_Top(This,pTop)
#define IVideoWindow_put_Height(This,Height) (This)->lpVtbl -> put_Height(This,Height)
#define IVideoWindow_get_Height(This,pHeight) (This)->lpVtbl -> get_Height(This,pHeight)
#define IVideoWindow_put_Owner(This,Owner) (This)->lpVtbl -> put_Owner(This,Owner)
#define IVideoWindow_get_Owner(This,Owner) (This)->lpVtbl -> get_Owner(This,Owner)
#define IVideoWindow_put_MessageDrain(This,Drain) (This)->lpVtbl -> put_MessageDrain(This,Drain)
#define IVideoWindow_get_MessageDrain(This,Drain) (This)->lpVtbl -> get_MessageDrain(This,Drain)
#define IVideoWindow_get_BorderColor(This,Color) (This)->lpVtbl -> get_BorderColor(This,Color)
#define IVideoWindow_put_BorderColor(This,Color) (This)->lpVtbl -> put_BorderColor(This,Color)
#define IVideoWindow_get_FullScreenMode(This,FullScreenMode) (This)->lpVtbl -> get_FullScreenMode(This,FullScreenMode)
#define IVideoWindow_put_FullScreenMode(This,FullScreenMode) (This)->lpVtbl -> put_FullScreenMode(This,FullScreenMode)
#define IVideoWindow_SetWindowForeground(This,Focus) (This)->lpVtbl -> SetWindowForeground(This,Focus)
#define IVideoWindow_NotifyOwnerMessage(This,hwnd,uMsg,wParam,lParam) (This)->lpVtbl -> NotifyOwnerMessage(This,hwnd,uMsg,wParam,lParam)
#define IVideoWindow_SetWindowPosition(This,Left_,Top,Width_,Height) (This)->lpVtbl -> SetWindowPosition(This,Left_,Top,Width_,Height)
#define IVideoWindow_GetWindowPosition(This,pLeft,pTop,pWidth,pHeight) (This)->lpVtbl -> GetWindowPosition(This,pLeft,pTop,pWidth,pHeight)
#define IVideoWindow_GetMinIdealImageSize(This,pWidth,pHeight) (This)->lpVtbl -> GetMinIdealImageSize(This,pWidth,pHeight)
#define IVideoWindow_GetMaxIdealImageSize(This,pWidth,pHeight) (This)->lpVtbl -> GetMaxIdealImageSize(This,pWidth,pHeight)
#define IVideoWindow_GetRestorePosition(This,pLeft,pTop,pWidth,pHeight) (This)->lpVtbl -> GetRestorePosition(This,pLeft,pTop,pWidth,pHeight)
#define IVideoWindow_HideCursor(This,HideCursor) (This)->lpVtbl -> HideCursor(This,_HideCursor)
#define IVideoWindow_IsCursorHidden(This,CursorHidden) (This)->lpVtbl -> IsCursorHidden(This,CursorHidden)

extern IID_IBasicVideo alias "IID_IBasicVideo" as GUID

type IBasicVideoVtbl_ as IBasicVideoVtbl

type IBasicVideo
    lpVtbl as IBasicVideoVtbl_ ptr
end type

type IBasicVideoVtbl
    QueryInterface as function(byval as IBasicVideo ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
    AddRef as function(byval as IBasicVideo ptr) as ULONG
    Release as function(byval as IBasicVideo ptr) as ULONG
    GetTypeInfoCount as function(byval as IBasicVideo ptr, byval as UINT ptr) as HRESULT
    GetTypeInfo as function(byval as IBasicVideo ptr, byval as UINT, byval as LCID, byval as ITypeInfo ptr ptr) as HRESULT
    GetIDsOfNames as function(byval as IBasicVideo ptr, byval as IID ptr, byval as LPOLESTR ptr, byval as UINT, byval as LCID, byval as DISPID ptr) as HRESULT
    Invoke as function(byval as IBasicVideo ptr, byval as DISPID, byval as IID ptr, byval as LCID, byval as WORD, byval as DISPPARAMS ptr, byval as VARIANT_ ptr, byval as EXCEPINFO ptr, byval as UINT ptr) as HRESULT
    get_AvgTimePerFrame as function(byval as IBasicVideo ptr, byval as REFTIME ptr) as HRESULT
    get_BitRate as function(byval as IBasicVideo ptr, byval as integer ptr) as HRESULT
    get_BitErrorRate as function(byval as IBasicVideo ptr, byval as integer ptr) as HRESULT
    get_VideoWidth as function(byval as IBasicVideo ptr, byval as integer ptr) as HRESULT
    get_VideoHeight as function(byval as IBasicVideo ptr, byval as integer ptr) as HRESULT
    put_SourceLeft as function(byval as IBasicVideo ptr, byval as integer) as HRESULT
    get_SourceLeft as function(byval as IBasicVideo ptr, byval as integer ptr) as HRESULT
    put_SourceWidth as function(byval as IBasicVideo ptr, byval as integer) as HRESULT
    get_SourceWidth as function(byval as IBasicVideo ptr, byval as integer ptr) as HRESULT
    put_SourceTop as function(byval as IBasicVideo ptr, byval as integer) as HRESULT
    get_SourceTop as function(byval as IBasicVideo ptr, byval as integer ptr) as HRESULT
    put_SourceHeight as function(byval as IBasicVideo ptr, byval as integer) as HRESULT
    get_SourceHeight as function(byval as IBasicVideo ptr, byval as integer ptr) as HRESULT
    put_DestinationLeft as function(byval as IBasicVideo ptr, byval as integer) as HRESULT
    get_DestinationLeft as function(byval as IBasicVideo ptr, byval as integer ptr) as HRESULT
    put_DestinationWidth as function(byval as IBasicVideo ptr, byval as integer) as HRESULT
    get_DestinationWidth as function(byval as IBasicVideo ptr, byval as integer ptr) as HRESULT
    put_DestinationTop as function(byval as IBasicVideo ptr, byval as integer) as HRESULT
    get_DestinationTop as function(byval as IBasicVideo ptr, byval as integer ptr) as HRESULT
    put_DestinationHeight as function(byval as IBasicVideo ptr, byval as integer) as HRESULT
    get_DestinationHeight as function(byval as IBasicVideo ptr, byval as integer ptr) as HRESULT
    SetSourcePosition as function(byval as IBasicVideo ptr, byval as integer, byval as integer, byval as integer, byval as integer) as HRESULT
    GetSourcePosition as function(byval as IBasicVideo ptr, byval as integer ptr, byval as integer ptr, byval as integer ptr, byval as integer ptr) as HRESULT
    SetDefaultSourcePosition as function(byval as IBasicVideo ptr) as HRESULT
    SetDestinationPosition as function(byval as IBasicVideo ptr, byval as integer, byval as integer, byval as integer, byval as integer) as HRESULT
    GetDestinationPosition as function(byval as IBasicVideo ptr, byval as integer ptr, byval as integer ptr, byval as integer ptr, byval as integer ptr) as HRESULT
    SetDefaultDestinationPosition as function(byval as IBasicVideo ptr) as HRESULT
    GetVideoSize as function(byval as IBasicVideo ptr, byval as integer ptr, byval as integer ptr) as HRESULT
    GetVideoPaletteEntries as function(byval as IBasicVideo ptr, byval as integer, byval as integer, byval as integer ptr, byval as integer ptr) as HRESULT
    GetCurrentImage as function(byval as IBasicVideo ptr, byval as integer ptr, byval as integer ptr) as HRESULT
    IsUsingDefaultSource as function(byval as IBasicVideo ptr) as HRESULT
    IsUsingDefaultDestination as function(byval as IBasicVideo ptr) as HRESULT
end type

#define IBasicVideo_QueryInterface(This,riid,ppvObject) (This)->lpVtbl -> QueryInterface(This,riid,ppvObject)
#define IBasicVideo_AddRef(This) (This)->lpVtbl -> AddRef(This)
#define IBasicVideo_Release(This) (This)->lpVtbl -> Release(This)
#define IBasicVideo_GetTypeInfoCount(This,pctinfo) (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo)
#define IBasicVideo_GetTypeInfo(This,iTInfo,lcid,ppTInfo) (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo)
#define IBasicVideo_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)
#define IBasicVideo_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)
#define IBasicVideo_get_AvgTimePerFrame(This,pAvgTimePerFrame) (This)->lpVtbl -> get_AvgTimePerFrame(This,pAvgTimePerFrame)
#define IBasicVideo_get_BitRate(This,pBitRate) (This)->lpVtbl -> get_BitRate(This,pBitRate)
#define IBasicVideo_get_BitErrorRate(This,pBitErrorRate) (This)->lpVtbl -> get_BitErrorRate(This,pBitErrorRate)
#define IBasicVideo_get_VideoWidth(This,pVideoWidth) (This)->lpVtbl -> get_VideoWidth(This,pVideoWidth)
#define IBasicVideo_get_VideoHeight(This,pVideoHeight) (This)->lpVtbl -> get_VideoHeight(This,pVideoHeight)
#define IBasicVideo_put_SourceLeft(This,SourceLeft) (This)->lpVtbl -> put_SourceLeft(This,SourceLeft)
#define IBasicVideo_get_SourceLeft(This,pSourceLeft) (This)->lpVtbl -> get_SourceLeft(This,pSourceLeft)
#define IBasicVideo_put_SourceWidth(This,SourceWidth) (This)->lpVtbl -> put_SourceWidth(This,SourceWidth)
#define IBasicVideo_get_SourceWidth(This,pSourceWidth) (This)->lpVtbl -> get_SourceWidth(This,pSourceWidth)
#define IBasicVideo_put_SourceTop(This,SourceTop) (This)->lpVtbl -> put_SourceTop(This,SourceTop)
#define IBasicVideo_get_SourceTop(This,pSourceTop) (This)->lpVtbl -> get_SourceTop(This,pSourceTop)
#define IBasicVideo_put_SourceHeight(This,SourceHeight) (This)->lpVtbl -> put_SourceHeight(This,SourceHeight)
#define IBasicVideo_get_SourceHeight(This,pSourceHeight) (This)->lpVtbl -> get_SourceHeight(This,pSourceHeight)
#define IBasicVideo_put_DestinationLeft(This,DestinationLeft) (This)->lpVtbl -> put_DestinationLeft(This,DestinationLeft)
#define IBasicVideo_get_DestinationLeft(This,pDestinationLeft) (This)->lpVtbl -> get_DestinationLeft(This,pDestinationLeft)
#define IBasicVideo_put_DestinationWidth(This,DestinationWidth) (This)->lpVtbl -> put_DestinationWidth(This,DestinationWidth)
#define IBasicVideo_get_DestinationWidth(This,pDestinationWidth) (This)->lpVtbl -> get_DestinationWidth(This,pDestinationWidth)
#define IBasicVideo_put_DestinationTop(This,DestinationTop) (This)->lpVtbl -> put_DestinationTop(This,DestinationTop)
#define IBasicVideo_get_DestinationTop(This,pDestinationTop) (This)->lpVtbl -> get_DestinationTop(This,pDestinationTop)
#define IBasicVideo_put_DestinationHeight(This,DestinationHeight) (This)->lpVtbl -> put_DestinationHeight(This,DestinationHeight)
#define IBasicVideo_get_DestinationHeight(This,pDestinationHeight) (This)->lpVtbl -> get_DestinationHeight(This,pDestinationHeight)
#define IBasicVideo_SetSourcePosition(This,Left_,Top,Width_,Height) (This)->lpVtbl -> SetSourcePosition(This,Left_,Top,Width_,Height)
#define IBasicVideo_GetSourcePosition(This,pLeft,pTop,pWidth,pHeight) (This)->lpVtbl -> GetSourcePosition(This,pLeft,pTop,pWidth,pHeight)
#define IBasicVideo_SetDefaultSourcePosition(This) (This)->lpVtbl -> SetDefaultSourcePosition(This)
#define IBasicVideo_SetDestinationPosition(This,Left_,Top,Width_,Height) (This)->lpVtbl -> SetDestinationPosition(This,Left_,Top,Width_,Height)
#define IBasicVideo_GetDestinationPosition(This,pLeft,pTop,pWidth,pHeight) (This)->lpVtbl -> GetDestinationPosition(This,pLeft,pTop,pWidth,pHeight)
#define IBasicVideo_SetDefaultDestinationPosition(This) (This)->lpVtbl -> SetDefaultDestinationPosition(This)
#define IBasicVideo_GetVideoSize(This,pWidth,pHeight) (This)->lpVtbl -> GetVideoSize(This,pWidth,pHeight)
#define IBasicVideo_GetVideoPaletteEntries(This,StartIndex,Entries,pRetrieved,pPalette) (This)->lpVtbl -> GetVideoPaletteEntries(This,StartIndex,Entries,pRetrieved,pPalette)
#define IBasicVideo_GetCurrentImage(This,pBufferSize,pDIBImage) (This)->lpVtbl -> GetCurrentImage(This,pBufferSize,pDIBImage)
#define IBasicVideo_IsUsingDefaultSource(This) (This)->lpVtbl -> IsUsingDefaultSource(This)
#define IBasicVideo_IsUsingDefaultDestination(This) (This)->lpVtbl -> IsUsingDefaultDestination(This)

extern IID_IBasicVideo2 alias "IID_IBasicVideo2" as GUID

type IBasicVideo2Vtbl_ as IBasicVideo2Vtbl

type IBasicVideo2
    lpVtbl as IBasicVideo2Vtbl_ ptr
end type

type IBasicVideo2Vtbl
    QueryInterface as function(byval as IBasicVideo2 ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
    AddRef as function(byval as IBasicVideo2 ptr) as ULONG
    Release as function(byval as IBasicVideo2 ptr) as ULONG
    GetTypeInfoCount as function(byval as IBasicVideo2 ptr, byval as UINT ptr) as HRESULT
    GetTypeInfo as function(byval as IBasicVideo2 ptr, byval as UINT, byval as LCID, byval as ITypeInfo ptr ptr) as HRESULT
    GetIDsOfNames as function(byval as IBasicVideo2 ptr, byval as IID ptr, byval as LPOLESTR ptr, byval as UINT, byval as LCID, byval as DISPID ptr) as HRESULT
    Invoke as function(byval as IBasicVideo2 ptr, byval as DISPID, byval as IID ptr, byval as LCID, byval as WORD, byval as DISPPARAMS ptr, byval as VARIANT_ ptr, byval as EXCEPINFO ptr, byval as UINT ptr) as HRESULT
    get_AvgTimePerFrame as function(byval as IBasicVideo2 ptr, byval as REFTIME ptr) as HRESULT
    get_BitRate as function(byval as IBasicVideo2 ptr, byval as integer ptr) as HRESULT
    get_BitErrorRate as function(byval as IBasicVideo2 ptr, byval as integer ptr) as HRESULT
    get_VideoWidth as function(byval as IBasicVideo2 ptr, byval as integer ptr) as HRESULT
    get_VideoHeight as function(byval as IBasicVideo2 ptr, byval as integer ptr) as HRESULT
    put_SourceLeft as function(byval as IBasicVideo2 ptr, byval as integer) as HRESULT
    get_SourceLeft as function(byval as IBasicVideo2 ptr, byval as integer ptr) as HRESULT
    put_SourceWidth as function(byval as IBasicVideo2 ptr, byval as integer) as HRESULT
    get_SourceWidth as function(byval as IBasicVideo2 ptr, byval as integer ptr) as HRESULT
    put_SourceTop as function(byval as IBasicVideo2 ptr, byval as integer) as HRESULT
    get_SourceTop as function(byval as IBasicVideo2 ptr, byval as integer ptr) as HRESULT
    put_SourceHeight as function(byval as IBasicVideo2 ptr, byval as integer) as HRESULT
    get_SourceHeight as function(byval as IBasicVideo2 ptr, byval as integer ptr) as HRESULT
    put_DestinationLeft as function(byval as IBasicVideo2 ptr, byval as integer) as HRESULT
    get_DestinationLeft as function(byval as IBasicVideo2 ptr, byval as integer ptr) as HRESULT
    put_DestinationWidth as function(byval as IBasicVideo2 ptr, byval as integer) as HRESULT
    get_DestinationWidth as function(byval as IBasicVideo2 ptr, byval as integer ptr) as HRESULT
    put_DestinationTop as function(byval as IBasicVideo2 ptr, byval as integer) as HRESULT
    get_DestinationTop as function(byval as IBasicVideo2 ptr, byval as integer ptr) as HRESULT
    put_DestinationHeight as function(byval as IBasicVideo2 ptr, byval as integer) as HRESULT
    get_DestinationHeight as function(byval as IBasicVideo2 ptr, byval as integer ptr) as HRESULT
    SetSourcePosition as function(byval as IBasicVideo2 ptr, byval as integer, byval as integer, byval as integer, byval as integer) as HRESULT
    GetSourcePosition as function(byval as IBasicVideo2 ptr, byval as integer ptr, byval as integer ptr, byval as integer ptr, byval as integer ptr) as HRESULT
    SetDefaultSourcePosition as function(byval as IBasicVideo2 ptr) as HRESULT
    SetDestinationPosition as function(byval as IBasicVideo2 ptr, byval as integer, byval as integer, byval as integer, byval as integer) as HRESULT
    GetDestinationPosition as function(byval as IBasicVideo2 ptr, byval as integer ptr, byval as integer ptr, byval as integer ptr, byval as integer ptr) as HRESULT
    SetDefaultDestinationPosition as function(byval as IBasicVideo2 ptr) as HRESULT
    GetVideoSize as function(byval as IBasicVideo2 ptr, byval as integer ptr, byval as integer ptr) as HRESULT
    GetVideoPaletteEntries as function(byval as IBasicVideo2 ptr, byval as integer, byval as integer, byval as integer ptr, byval as integer ptr) as HRESULT
    GetCurrentImage as function(byval as IBasicVideo2 ptr, byval as integer ptr, byval as integer ptr) as HRESULT
    IsUsingDefaultSource as function(byval as IBasicVideo2 ptr) as HRESULT
    IsUsingDefaultDestination as function(byval as IBasicVideo2 ptr) as HRESULT
    GetPreferredAspectRatio as function(byval as IBasicVideo2 ptr, byval as integer ptr, byval as integer ptr) as HRESULT
end type

#define IBasicVideo2_QueryInterface(This,riid,ppvObject) (This)->lpVtbl -> QueryInterface(This,riid,ppvObject)
#define IBasicVideo2_AddRef(This) (This)->lpVtbl -> AddRef(This)
#define IBasicVideo2_Release(This) (This)->lpVtbl -> Release(This)
#define IBasicVideo2_GetTypeInfoCount(This,pctinfo) (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo)
#define IBasicVideo2_GetTypeInfo(This,iTInfo,lcid,ppTInfo) (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo)
#define IBasicVideo2_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)
#define IBasicVideo2_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)
#define IBasicVideo2_get_AvgTimePerFrame(This,pAvgTimePerFrame) (This)->lpVtbl -> get_AvgTimePerFrame(This,pAvgTimePerFrame)
#define IBasicVideo2_get_BitRate(This,pBitRate) (This)->lpVtbl -> get_BitRate(This,pBitRate)
#define IBasicVideo2_get_BitErrorRate(This,pBitErrorRate) (This)->lpVtbl -> get_BitErrorRate(This,pBitErrorRate)
#define IBasicVideo2_get_VideoWidth(This,pVideoWidth) (This)->lpVtbl -> get_VideoWidth(This,pVideoWidth)
#define IBasicVideo2_get_VideoHeight(This,pVideoHeight) (This)->lpVtbl -> get_VideoHeight(This,pVideoHeight)
#define IBasicVideo2_put_SourceLeft(This,SourceLeft) (This)->lpVtbl -> put_SourceLeft(This,SourceLeft)
#define IBasicVideo2_get_SourceLeft(This,pSourceLeft) (This)->lpVtbl -> get_SourceLeft(This,pSourceLeft)
#define IBasicVideo2_put_SourceWidth(This,SourceWidth) (This)->lpVtbl -> put_SourceWidth(This,SourceWidth)
#define IBasicVideo2_get_SourceWidth(This,pSourceWidth) (This)->lpVtbl -> get_SourceWidth(This,pSourceWidth)
#define IBasicVideo2_put_SourceTop(This,SourceTop) (This)->lpVtbl -> put_SourceTop(This,SourceTop)
#define IBasicVideo2_get_SourceTop(This,pSourceTop) (This)->lpVtbl -> get_SourceTop(This,pSourceTop)
#define IBasicVideo2_put_SourceHeight(This,SourceHeight) (This)->lpVtbl -> put_SourceHeight(This,SourceHeight)
#define IBasicVideo2_get_SourceHeight(This,pSourceHeight) (This)->lpVtbl -> get_SourceHeight(This,pSourceHeight)
#define IBasicVideo2_put_DestinationLeft(This,DestinationLeft) (This)->lpVtbl -> put_DestinationLeft(This,DestinationLeft)
#define IBasicVideo2_get_DestinationLeft(This,pDestinationLeft) (This)->lpVtbl -> get_DestinationLeft(This,pDestinationLeft)
#define IBasicVideo2_put_DestinationWidth(This,DestinationWidth) (This)->lpVtbl -> put_DestinationWidth(This,DestinationWidth)
#define IBasicVideo2_get_DestinationWidth(This,pDestinationWidth) (This)->lpVtbl -> get_DestinationWidth(This,pDestinationWidth)
#define IBasicVideo2_put_DestinationTop(This,DestinationTop) (This)->lpVtbl -> put_DestinationTop(This,DestinationTop)
#define IBasicVideo2_get_DestinationTop(This,pDestinationTop) (This)->lpVtbl -> get_DestinationTop(This,pDestinationTop)
#define IBasicVideo2_put_DestinationHeight(This,DestinationHeight) (This)->lpVtbl -> put_DestinationHeight(This,DestinationHeight)
#define IBasicVideo2_get_DestinationHeight(This,pDestinationHeight) (This)->lpVtbl -> get_DestinationHeight(This,pDestinationHeight)
#define IBasicVideo2_SetSourcePosition(This,Left_,Top,Width_,Height) (This)->lpVtbl -> SetSourcePosition(This,Left_,Top,Width_,Height)
#define IBasicVideo2_GetSourcePosition(This,pLeft,pTop,pWidth,pHeight) (This)->lpVtbl -> GetSourcePosition(This,pLeft,pTop,pWidth,pHeight)
#define IBasicVideo2_SetDefaultSourcePosition(This) (This)->lpVtbl -> SetDefaultSourcePosition(This)
#define IBasicVideo2_SetDestinationPosition(This,Left_,Top,Width_,Height) (This)->lpVtbl -> SetDestinationPosition(This,Left_,Top,Width_,Height)
#define IBasicVideo2_GetDestinationPosition(This,pLeft,pTop,pWidth,pHeight) (This)->lpVtbl -> GetDestinationPosition(This,pLeft,pTop,pWidth,pHeight)
#define IBasicVideo2_SetDefaultDestinationPosition(This) (This)->lpVtbl -> SetDefaultDestinationPosition(This)
#define IBasicVideo2_GetVideoSize(This,pWidth,pHeight) (This)->lpVtbl -> GetVideoSize(This,pWidth,pHeight)
#define IBasicVideo2_GetVideoPaletteEntries(This,StartIndex,Entries,pRetrieved,pPalette) (This)->lpVtbl -> GetVideoPaletteEntries(This,StartIndex,Entries,pRetrieved,pPalette)
#define IBasicVideo2_GetCurrentImage(This,pBufferSize,pDIBImage) (This)->lpVtbl -> GetCurrentImage(This,pBufferSize,pDIBImage)
#define IBasicVideo2_IsUsingDefaultSource(This) (This)->lpVtbl -> IsUsingDefaultSource(This)
#define IBasicVideo2_IsUsingDefaultDestination(This) (This)->lpVtbl -> IsUsingDefaultDestination(This)
#define IBasicVideo2_GetPreferredAspectRatio(This,plAspectX,plAspectY) (This)->lpVtbl -> GetPreferredAspectRatio(This,plAspectX,plAspectY)

extern IID_IDeferredCommand alias "IID_IDeferredCommand" as GUID

type IDeferredCommandVtbl_ as IDeferredCommandVtbl

type IDeferredCommand
    lpVtbl as IDeferredCommandVtbl_ ptr
end type

type IDeferredCommandVtbl
    QueryInterface as function(byval as IDeferredCommand ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
    AddRef as function(byval as IDeferredCommand ptr) as ULONG
    Release as function(byval as IDeferredCommand ptr) as ULONG
    Cancel as function(byval as IDeferredCommand ptr) as HRESULT
    Confidence as function(byval as IDeferredCommand ptr, byval as LONG ptr) as HRESULT
    Postpone as function(byval as IDeferredCommand ptr, byval as REFTIME) as HRESULT
    GetHResult as function(byval as IDeferredCommand ptr, byval as HRESULT ptr) as HRESULT
end type

#define IDeferredCommand_QueryInterface(This,riid,ppvObject) (This)->lpVtbl -> QueryInterface(This,riid,ppvObject)
#define IDeferredCommand_AddRef(This) (This)->lpVtbl -> AddRef(This)
#define IDeferredCommand_Release(This) (This)->lpVtbl -> Release(This)
#define IDeferredCommand_Cancel(This) (This)->lpVtbl -> Cancel(This)
#define IDeferredCommand_Confidence(This,pConfidence) (This)->lpVtbl -> Confidence(This,pConfidence)
#define IDeferredCommand_Postpone(This,newtime) (This)->lpVtbl -> Postpone(This,newtime)
#define IDeferredCommand_GetHResult(This,phrResult) (This)->lpVtbl -> GetHResult(This,phrResult)

extern IID_IQueueCommand alias "IID_IQueueCommand" as GUID

type IQueueCommandVtbl_ as IQueueCommandVtbl

type IQueueCommand
    lpVtbl as IQueueCommandVtbl_ ptr
end type

type IQueueCommandVtbl
    QueryInterface as function(byval as IQueueCommand ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
    AddRef as function(byval as IQueueCommand ptr) as ULONG
    Release as function(byval as IQueueCommand ptr) as ULONG
    InvokeAtStreamTime as function(byval as IQueueCommand ptr, byval as IDeferredCommand ptr ptr, byval as REFTIME, byval as GUID ptr, byval as integer, byval as short, byval as integer, byval as VARIANT_ ptr, byval as VARIANT_ ptr, byval as short ptr) as HRESULT
    InvokeAtPresentationTime as function(byval as IQueueCommand ptr, byval as IDeferredCommand ptr ptr, byval as REFTIME, byval as GUID ptr, byval as integer, byval as short, byval as integer, byval as VARIANT_ ptr, byval as VARIANT_ ptr, byval as short ptr) as HRESULT
end type

#define IQueueCommand_QueryInterface(This,riid,ppvObject) (This)->lpVtbl -> QueryInterface(This,riid,ppvObject)
#define IQueueCommand_AddRef(This) (This)->lpVtbl -> AddRef(This)
#define IQueueCommand_Release(This) (This)->lpVtbl -> Release(This)
#define IQueueCommand_InvokeAtStreamTime(This,pCmd,time_,iid,dispidMethod,wFlags,cArgs,pDispParams,pvarResult,puArgErr) (This)->lpVtbl -> InvokeAtStreamTime(This,pCmd,time_,iid,dispidMethod,wFlags,cArgs,pDispParams,pvarResult,puArgErr)
#define IQueueCommand_InvokeAtPresentationTime(This,pCmd,time_,iid,dispidMethod,wFlags,cArgs,pDispParams,pvarResult,puArgErr) (This)->lpVtbl -> InvokeAtPresentationTime(This,pCmd,time_,iid,dispidMethod,wFlags,cArgs,pDispParams,pvarResult,puArgErr)

extern CLSID_FilgraphManager alias "CLSID_FilgraphManager" as GUID
extern IID_IFilterInfo alias "IID_IFilterInfo" as GUID

type IFilterInfoVtbl_ as IFilterInfoVtbl

type IFilterInfo
    lpVtbl as IFilterInfoVtbl_ ptr
end type

type IFilterInfoVtbl
    QueryInterface as function(byval as IFilterInfo ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
    AddRef as function(byval as IFilterInfo ptr) as ULONG
    Release as function(byval as IFilterInfo ptr) as ULONG
    GetTypeInfoCount as function(byval as IFilterInfo ptr, byval as UINT ptr) as HRESULT
    GetTypeInfo as function(byval as IFilterInfo ptr, byval as UINT, byval as LCID, byval as ITypeInfo ptr ptr) as HRESULT
    GetIDsOfNames as function(byval as IFilterInfo ptr, byval as IID ptr, byval as LPOLESTR ptr, byval as UINT, byval as LCID, byval as DISPID ptr) as HRESULT
    Invoke as function(byval as IFilterInfo ptr, byval as DISPID, byval as IID ptr, byval as LCID, byval as WORD, byval as DISPPARAMS ptr, byval as VARIANT_ ptr, byval as EXCEPINFO ptr, byval as UINT ptr) as HRESULT
    FindPin as function(byval as IFilterInfo ptr, byval as BSTR, byval as IDispatch ptr ptr) as HRESULT
    get_Name as function(byval as IFilterInfo ptr, byval as BSTR ptr) as HRESULT
    get_VendorInfo as function(byval as IFilterInfo ptr, byval as BSTR ptr) as HRESULT
    get_Filter as function(byval as IFilterInfo ptr, byval as IUnknown ptr ptr) as HRESULT
    get_Pins as function(byval as IFilterInfo ptr, byval as IDispatch ptr ptr) as HRESULT
    get_IsFileSource as function(byval as IFilterInfo ptr, byval as LONG ptr) as HRESULT
    get_Filename as function(byval as IFilterInfo ptr, byval as BSTR ptr) as HRESULT
    put_Filename as function(byval as IFilterInfo ptr, byval as BSTR) as HRESULT
end type

#define IFilterInfo_QueryInterface(This,riid,ppvObject) (This)->lpVtbl -> QueryInterface(This,riid,ppvObject)
#define IFilterInfo_AddRef(This) (This)->lpVtbl -> AddRef(This)
#define IFilterInfo_Release(This) (This)->lpVtbl -> Release(This)
#define IFilterInfo_GetTypeInfoCount(This,pctinfo) (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo)
#define IFilterInfo_GetTypeInfo(This,iTInfo,lcid,ppTInfo) (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo)
#define IFilterInfo_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)
#define IFilterInfo_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)
#define IFilterInfo_FindPin(This,strPinID,ppUnk) (This)->lpVtbl -> FindPin(This,strPinID,ppUnk)
#define IFilterInfo_get_Name(This,strName) (This)->lpVtbl -> get_Name(This,strName)
#define IFilterInfo_get_VendorInfo(This,strVendorInfo) (This)->lpVtbl -> get_VendorInfo(This,strVendorInfo)
#define IFilterInfo_get_Filter(This,ppUnk) (This)->lpVtbl -> get_Filter(This,ppUnk)
#define IFilterInfo_get_Pins(This,ppUnk) (This)->lpVtbl -> get_Pins(This,ppUnk)
#define IFilterInfo_get_IsFileSource(This,pbIsSource) (This)->lpVtbl -> get_IsFileSource(This,pbIsSource)
#define IFilterInfo_get_Filename(This,pstrFilename) (This)->lpVtbl -> get_Filename(This,pstrFilename)
#define IFilterInfo_put_Filename(This,strFilename) (This)->lpVtbl -> put_Filename(This,strFilename)

extern IID_IRegFilterInfo alias "IID_IRegFilterInfo" as GUID

type IRegFilterInfoVtbl_ as IRegFilterInfoVtbl

type IRegFilterInfo
    lpVtbl as IRegFilterInfoVtbl_ ptr
end type

type IRegFilterInfoVtbl
    QueryInterface as function(byval as IRegFilterInfo ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
    AddRef as function(byval as IRegFilterInfo ptr) as ULONG
    Release as function(byval as IRegFilterInfo ptr) as ULONG
    GetTypeInfoCount as function(byval as IRegFilterInfo ptr, byval as UINT ptr) as HRESULT
    GetTypeInfo as function(byval as IRegFilterInfo ptr, byval as UINT, byval as LCID, byval as ITypeInfo ptr ptr) as HRESULT
    GetIDsOfNames as function(byval as IRegFilterInfo ptr, byval as IID ptr, byval as LPOLESTR ptr, byval as UINT, byval as LCID, byval as DISPID ptr) as HRESULT
    Invoke as function(byval as IRegFilterInfo ptr, byval as DISPID, byval as IID ptr, byval as LCID, byval as WORD, byval as DISPPARAMS ptr, byval as VARIANT_ ptr, byval as EXCEPINFO ptr, byval as UINT ptr) as HRESULT
    get_Name as function(byval as IRegFilterInfo ptr, byval as BSTR ptr) as HRESULT
    Filter as function(byval as IRegFilterInfo ptr, byval as IDispatch ptr ptr) as HRESULT
end type

#define IRegFilterInfo_QueryInterface(This,riid,ppvObject) (This)->lpVtbl -> QueryInterface(This,riid,ppvObject)
#define IRegFilterInfo_AddRef(This) (This)->lpVtbl -> AddRef(This)
#define IRegFilterInfo_Release(This) (This)->lpVtbl -> Release(This)
#define IRegFilterInfo_GetTypeInfoCount(This,pctinfo) (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo)
#define IRegFilterInfo_GetTypeInfo(This,iTInfo,lcid,ppTInfo) (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo)
#define IRegFilterInfo_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)
#define IRegFilterInfo_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)
#define IRegFilterInfo_get_Name(This,strName) (This)->lpVtbl -> get_Name(This,strName)
#define IRegFilterInfo_Filter(This,ppUnk) (This)->lpVtbl -> Filter(This,ppUnk)

extern IID_IMediaTypeInfo alias "IID_IMediaTypeInfo" as GUID

type IMediaTypeInfoVtbl_ as IMediaTypeInfoVtbl

type IMediaTypeInfo
    lpVtbl as IMediaTypeInfoVtbl_ ptr
end type

type IMediaTypeInfoVtbl
    QueryInterface as function(byval as IMediaTypeInfo ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
    AddRef as function(byval as IMediaTypeInfo ptr) as ULONG
    Release as function(byval as IMediaTypeInfo ptr) as ULONG
    GetTypeInfoCount as function(byval as IMediaTypeInfo ptr, byval as UINT ptr) as HRESULT
    GetTypeInfo as function(byval as IMediaTypeInfo ptr, byval as UINT, byval as LCID, byval as ITypeInfo ptr ptr) as HRESULT
    GetIDsOfNames as function(byval as IMediaTypeInfo ptr, byval as IID ptr, byval as LPOLESTR ptr, byval as UINT, byval as LCID, byval as DISPID ptr) as HRESULT
    Invoke as function(byval as IMediaTypeInfo ptr, byval as DISPID, byval as IID ptr, byval as LCID, byval as WORD, byval as DISPPARAMS ptr, byval as VARIANT_ ptr, byval as EXCEPINFO ptr, byval as UINT ptr) as HRESULT
    get_Type as function(byval as IMediaTypeInfo ptr, byval as BSTR ptr) as HRESULT
    get_Subtype as function(byval as IMediaTypeInfo ptr, byval as BSTR ptr) as HRESULT
end type

#define IMediaTypeInfo_QueryInterface(This,riid,ppvObject) (This)->lpVtbl -> QueryInterface(This,riid,ppvObject)
#define IMediaTypeInfo_AddRef(This) (This)->lpVtbl -> AddRef(This)
#define IMediaTypeInfo_Release(This) (This)->lpVtbl -> Release(This)
#define IMediaTypeInfo_GetTypeInfoCount(This,pctinfo) (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo)
#define IMediaTypeInfo_GetTypeInfo(This,iTInfo,lcid,ppTInfo) (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo)
#define IMediaTypeInfo_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)
#define IMediaTypeInfo_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)
#define IMediaTypeInfo_get_Type(This,strType) (This)->lpVtbl -> get_Type(This,strType)
#define IMediaTypeInfo_get_Subtype(This,strType) (This)->lpVtbl -> get_Subtype(This,strType)

extern IID_IPinInfo alias "IID_IPinInfo" as GUID

type IPinInfoVtbl_ as IPinInfoVtbl

type IPinInfo
    lpVtbl as IPinInfoVtbl_ ptr
end type

type IPinInfoVtbl
    QueryInterface as function(byval as IPinInfo ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
    AddRef as function(byval as IPinInfo ptr) as ULONG
    Release as function(byval as IPinInfo ptr) as ULONG
    GetTypeInfoCount as function(byval as IPinInfo ptr, byval as UINT ptr) as HRESULT
    GetTypeInfo as function(byval as IPinInfo ptr, byval as UINT, byval as LCID, byval as ITypeInfo ptr ptr) as HRESULT
    GetIDsOfNames as function(byval as IPinInfo ptr, byval as IID ptr, byval as LPOLESTR ptr, byval as UINT, byval as LCID, byval as DISPID ptr) as HRESULT
    Invoke as function(byval as IPinInfo ptr, byval as DISPID, byval as IID ptr, byval as LCID, byval as WORD, byval as DISPPARAMS ptr, byval as VARIANT_ ptr, byval as EXCEPINFO ptr, byval as UINT ptr) as HRESULT
    get_Pin as function(byval as IPinInfo ptr, byval as IUnknown ptr ptr) as HRESULT
    get_ConnectedTo as function(byval as IPinInfo ptr, byval as IDispatch ptr ptr) as HRESULT
    get_ConnectionMediaType as function(byval as IPinInfo ptr, byval as IDispatch ptr ptr) as HRESULT
    get_FilterInfo as function(byval as IPinInfo ptr, byval as IDispatch ptr ptr) as HRESULT
    get_Name as function(byval as IPinInfo ptr, byval as BSTR ptr) as HRESULT
    get_Direction as function(byval as IPinInfo ptr, byval as LONG ptr) as HRESULT
    get_PinID as function(byval as IPinInfo ptr, byval as BSTR ptr) as HRESULT
    get_MediaTypes as function(byval as IPinInfo ptr, byval as IDispatch ptr ptr) as HRESULT
    Connect as function(byval as IPinInfo ptr, byval as IUnknown ptr) as HRESULT
    ConnectDirect as function(byval as IPinInfo ptr, byval as IUnknown ptr) as HRESULT
    ConnectWithType as function(byval as IPinInfo ptr, byval as IUnknown ptr, byval as IDispatch ptr) as HRESULT
    Disconnect as function(byval as IPinInfo ptr) as HRESULT
    Render as function(byval as IPinInfo ptr) as HRESULT
end type

#define IPinInfo_QueryInterface(This,riid,ppvObject) (This)->lpVtbl -> QueryInterface(This,riid,ppvObject)
#define IPinInfo_AddRef(This) (This)->lpVtbl -> AddRef(This)
#define IPinInfo_Release(This) (This)->lpVtbl -> Release(This)
#define IPinInfo_GetTypeInfoCount(This,pctinfo) (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo)
#define IPinInfo_GetTypeInfo(This,iTInfo,lcid,ppTInfo) (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo)
#define IPinInfo_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)
#define IPinInfo_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)
#define IPinInfo_get_Pin(This,ppUnk) (This)->lpVtbl -> get_Pin(This,ppUnk)
#define IPinInfo_get_ConnectedTo(This,ppUnk) (This)->lpVtbl -> get_ConnectedTo(This,ppUnk)
#define IPinInfo_get_ConnectionMediaType(This,ppUnk) (This)->lpVtbl -> get_ConnectionMediaType(This,ppUnk)
#define IPinInfo_get_FilterInfo(This,ppUnk) (This)->lpVtbl -> get_FilterInfo(This,ppUnk)
#define IPinInfo_get_Name(This,ppUnk) (This)->lpVtbl -> get_Name(This,ppUnk)
#define IPinInfo_get_Direction(This,ppDirection) (This)->lpVtbl -> get_Direction(This,ppDirection)
#define IPinInfo_get_PinID(This,strPinID) (This)->lpVtbl -> get_PinID(This,strPinID)
#define IPinInfo_get_MediaTypes(This,ppUnk) (This)->lpVtbl -> get_MediaTypes(This,ppUnk)
#define IPinInfo_Connect(This,pPin) (This)->lpVtbl -> Connect(This,pPin)
#define IPinInfo_ConnectDirect(This,pPin) (This)->lpVtbl -> ConnectDirect(This,pPin)
#define IPinInfo_ConnectWithType(This,pPin,pMediaType) (This)->lpVtbl -> ConnectWithType(This,pPin,pMediaType)
#define IPinInfo_Disconnect(This) (This)->lpVtbl -> Disconnect(This)
#define IPinInfo_Render(This) (This)->lpVtbl -> Render(This)

extern IID_IAMStats alias "IID_IAMStats" as GUID

type IAMStatsVtbl_ as IAMStatsVtbl

type IAMStats
    lpVtbl as IAMStatsVtbl_ ptr
end type

type IAMStatsVtbl
    QueryInterface as function(byval as IAMStats ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
    AddRef as function(byval as IAMStats ptr) as ULONG
    Release as function(byval as IAMStats ptr) as ULONG
    GetTypeInfoCount as function(byval as IAMStats ptr, byval as UINT ptr) as HRESULT
    GetTypeInfo as function(byval as IAMStats ptr, byval as UINT, byval as LCID, byval as ITypeInfo ptr ptr) as HRESULT
    GetIDsOfNames as function(byval as IAMStats ptr, byval as IID ptr, byval as LPOLESTR ptr, byval as UINT, byval as LCID, byval as DISPID ptr) as HRESULT
    Invoke as function(byval as IAMStats ptr, byval as DISPID, byval as IID ptr, byval as LCID, byval as WORD, byval as DISPPARAMS ptr, byval as VARIANT_ ptr, byval as EXCEPINFO ptr, byval as UINT ptr) as HRESULT
    Reset as function(byval as IAMStats ptr) as HRESULT
    get_Count as function(byval as IAMStats ptr, byval as LONG ptr) as HRESULT
    GetValueByIndex as function(byval as IAMStats ptr, byval as integer, byval as BSTR ptr, byval as integer ptr, byval as double ptr, byval as double ptr, byval as double ptr, byval as double ptr, byval as double ptr) as HRESULT
    GetValueByName as function(byval as IAMStats ptr, byval as BSTR, byval as integer ptr, byval as integer ptr, byval as double ptr, byval as double ptr, byval as double ptr, byval as double ptr, byval as double ptr) as HRESULT
    GetIndex as function(byval as IAMStats ptr, byval as BSTR, byval as integer, byval as integer ptr) as HRESULT
    AddValue as function(byval as IAMStats ptr, byval as integer, byval as double) as HRESULT
end type

#define IAMStats_QueryInterface(This,riid,ppvObject) (This)->lpVtbl -> QueryInterface(This,riid,ppvObject)
#define IAMStats_AddRef(This) (This)->lpVtbl -> AddRef(This)
#define IAMStats_Release(This) (This)->lpVtbl -> Release(This)
#define IAMStats_GetTypeInfoCount(This,pctinfo) (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo)
#define IAMStats_GetTypeInfo(This,iTInfo,lcid,ppTInfo) (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo)
#define IAMStats_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)
#define IAMStats_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)
#define IAMStats_Reset(This) (This)->lpVtbl -> Reset(This)
#define IAMStats_get_Count(This,plCount) (This)->lpVtbl -> get_Count(This,plCount)
#define IAMStats_GetValueByIndex(This,lIndex,szName,lCount,dLast,dAverage,dStdDev,dMin,dMax) (This)->lpVtbl -> GetValueByIndex(This,lIndex,szName,lCount,dLast,dAverage,dStdDev,dMin,dMax)
#define IAMStats_GetValueByName(This,szName,lIndex,lCount,dLast,dAverage,dStdDev,dMin,dMax) (This)->lpVtbl -> GetValueByName(This,szName,lIndex,lCount,dLast,dAverage,dStdDev,dMin,dMax)
#define IAMStats_GetIndex(This,szName,lCreate,plIndex) (This)->lpVtbl -> GetIndex(This,szName,lCreate,plIndex)
#define IAMStats_AddValue(This,lIndex,dValue) (This)->lpVtbl -> AddValue(This,lIndex,dValue)

#endif
