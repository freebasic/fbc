#ifndef OLE32_BI
#define OLE32_BI
'--------
'OLE32.BI
'--------
'
'This header defines every obtainable ole32 Function and related data types and structures.

'VERSION: 1.00

'$include once: "win\winbase.bi"
'$include once: "win\kernel32.bi"
'$include once: "win\user32.bi"

'----------------------
'| REQUIRED CONSTANTS |
'----------------------


'------------------
'| REQUIRED TYPES |
'------------------

Type Guid
  Data1 As Integer
  Data2 As Short
  Data3 As Short
  Data4(0 To 7) As Byte
End Type

'-----------------
'| API FUNCTIONS |
'-----------------

Declare Sub BindMoniker Lib "ole32" (ByVal pmk As Integer, ByVal grfOpt As Integer, ByVal iidResult As Integer, ByRef ppvResult As Any)
Declare Sub CLIPFORMAT_UserFree Lib "ole32" (ByRef pInteger As Integer, ByRef pClipformat As Short)
Declare Function CLIPFORMAT_UserMarshal Lib "ole32" (ByRef pInteger As Integer, ByVal pChar As String, ByRef pClipformat As Short) As Integer
Declare Function CLIPFORMAT_UserSize Lib "ole32" (ByRef pInteger As Integer, ByVal lInteger As Integer, ByRef pClipformat As Short) As Integer
Declare Function CLIPFORMAT_UserUnmarshal Lib "ole32" (ByRef pInteger As Integer, ByVal pChar As String, ByRef pClipformat As Short) As Integer
Declare Function CLSIDFromProgID Lib "ole32" (ByRef TSzProgID As String, ByRef T As Integer) As Integer
Declare Sub CLSIDFromString Lib "ole32" (ByVal lpsz As String, ByVal pclsid As Integer)
Declare Function CoAddRefServerProcess Lib "ole32" () As Integer
Declare Function CoBuildVersion Lib "ole32" () As Integer
Declare Sub CoCopyProxy Lib "ole32" (ByVal pProxy As Integer, ByVal ppCopy As Integer)
Declare Sub CoCreateFreeThreadedMarshaler Lib "ole32" (ByVal punkOuter As Integer, ByVal ppunkMarshal As Integer)
Declare Sub CoCreateGuid Lib "ole32" (ByRef pguid As GUID)
Declare Sub CoCreateInstance Lib "ole32" (ByVal rclsid As Integer, ByVal pUnkOuter As Integer, ByVal dwClsContext As Integer, ByVal riid As Integer, ByRef ppv As Any)
'Declare Sub CoCreateInstanceEx Lib "ole32" (ByVal Clsid As Integer, ByVal punkOuter As Integer, ByVal dwClsCtx As Integer, ByRef pServerInfo As COSERVERINFO, ByVal dwCount As Integer, ByRef pResults As MULTI_QI)
Declare Sub CoDisconnectObject Lib "ole32" (ByVal pUnk As Integer, ByVal dwReserved As Integer)
Declare Function CoDosDateTimeToFileTime Lib "ole32" (ByVal nDosDate As Short, ByVal nDosTime As Short, ByRef lpFileTime As FILETIME) As Integer
Declare Sub CoFileTimeNow Lib "ole32" (ByRef lpFileTime As FILETIME)
Declare Function CoFileTimeToDosDateTime Lib "ole32" (ByRef lpFileTime As FILETIME, ByRef lpDosDate As Short, ByRef lpDosTime As Short) As Integer
Declare Sub CoFreeAllLibraries Lib "ole32" ()
Declare Sub CoFreeLibrary Lib "ole32" (ByVal hInst As Integer)
Declare Sub CoFreeUnusedLibraries Lib "ole32" ()
Declare Sub CoGetCallContext Lib "ole32" (ByVal riid As Integer, ByRef ppInterface As Any)
'CoGetCallerTID 'UNREFERENCED
Declare Sub CoGetClassObject Lib "ole32" (ByVal rclsid As Integer, ByVal dwClsContext As Integer, ByRef pvReserved As Any, ByVal riid As Integer, ByRef ppv As Any)
'CoGetCurrentLogicalThreadId 'UNREFERENCED
Declare Function CoGetCurrentProcess Lib "ole32" () As Integer
'Declare Sub CoGetInstanceFromFile Lib "ole32" (ByRef pServerInfo As COSERVERINFO, ByRef pClsid As Integer, ByVal punkOuter As Integer, ByVal dwClsCtx As Integer, ByVal grfMode As Integer, ByRef pwszName As Byte, ByVal dwCount As Integer, ByRef pResults As MULTI_QI)
'Declare Sub CoGetInstanceFromIStorage Lib "ole32" (ByRef pServerInfo As COSERVERINFO, ByRef pClsid As Integer, ByVal punkOuter As Integer, ByVal dwClsCtx As Integer, ByVal pstg As Integer, ByVal dwCount As Integer, ByRef pResults As MULTI_QI)
Declare Sub CoGetInterfaceAndReleaseStream Lib "ole32" (ByRef pStm As Integer, ByVal iid As Integer, ByRef ppv As Any)
Declare Sub CoGetMalloc Lib "ole32" (ByVal dwMemContext As Integer, ByVal ppMalloc As Integer)
Declare Sub CoGetMarshalSizeMax Lib "ole32" (ByRef pulSize As Integer, ByVal riid As Integer, ByVal pUnk As Integer, ByVal dwDestContext As Integer, ByRef pvDestContext As Any, ByVal mshlflags As Integer)
'Declare Sub CoGetObject Lib "ole32" (ByVal pszName As String, ByRef pBindOptions As BIND_OPTS, ByVal riid As Integer, ByRef ppv As Any)
Declare Sub CoGetPSClsid Lib "ole32" (ByVal riid As Integer, ByRef pClsid As Integer)
Declare Sub CoGetStandardMarshal Lib "ole32" (ByVal riid As Integer, ByVal pUnk As Integer, ByVal dwDestContext As Integer, ByRef pvDestContext As Any, ByVal mshlflags As Integer, ByVal ppMarshal As Integer)
'CoGetState 'UNREFERENCED
'CoGetTIDFromIPID 'UNREFERENCED
Declare Sub CoGetTreatAsClass Lib "ole32" (ByVal clsidOld As Integer, ByVal pClsidNew As Integer)
Declare Sub CoImpersonateClient Lib "ole32" ()
Declare Sub CoInitialize Lib "ole32" (ByRef pvReserved As Any)
Declare Sub CoInitializeEx Lib "ole32" (ByRef pvReserved As Any, ByVal dwCoInit As Integer)
'Declare Sub CoInitializeSecurity Lib "ole32" (ByRef pSecDesc As SECURITY_DESCRIPTOR, ByVal cAuthSvc As Integer, ByRef asAuthSvc As SOLE_AUTHENTICATION_SERVICE, ByRef pReserved1 As Any, ByVal dwAuthnLevel As Integer, ByVal dwImpLevel As Integer, ByRef pAuthList As Any, ByVal dwCapabilities As Integer, ByRef pReserved3 As Any)
'CoInitializeWOW 'UNREFERENCED
Declare Function CoIsHandlerConnected Lib "ole32" (ByVal pUnk As Integer) As Integer
Declare Function CoIsOle1Class Lib "ole32" (ByVal rclsid As Integer) As Integer
Declare Function CoLoadLibrary Lib "ole32" (ByVal lpszLibName As String, ByVal bAutoFree As Integer) As Integer
Declare Sub CoLockObjectExternal Lib "ole32" (ByVal pUnk As Integer, ByVal fLock As Integer, ByVal fLastUnlockReleases As Integer)
Declare Sub CoMarshalHresult Lib "ole32" (ByRef pstm As Integer, ByVal hresult As Integer)
Declare Sub CoMarshalInterface Lib "ole32" (ByRef pStm As Integer, ByVal riid As Integer, ByVal pUnk As Integer, ByVal dwDestContext As Integer, ByRef pvDestContext As Any, ByVal mshlflags As Integer)
Declare Sub CoMarshalInterThreadInterfaceInStream Lib "ole32" (ByVal riid As Integer, ByVal pUnk As Integer, ByRef ppStm As Integer)
'Declare Sub CoQueryAuthenticationServices Lib "ole32" (ByRef pcAuthSvc As Integer, ByRef asAuthSvc As SOLE_AUTHENTICATION_SERVICE)
Declare Sub CoQueryClientBlanket Lib "ole32" (ByRef pAuthnSvc As Integer, ByRef pAuthzSvc As Integer, ByRef pServerPrincName As Byte, ByRef pAuthnLevel As Integer, ByRef pImpLevel As Integer, ByRef pPrivs As Integer, ByRef pCapabilities As Integer)
Declare Sub CoQueryProxyBlanket Lib "ole32" (ByVal pProxy As Integer, ByRef pwAuthnSvc As Integer, ByRef pAuthzSvc As Integer, ByRef pServerPrincName As Byte, ByRef pAuthnLevel As Integer, ByRef pImpLevel As Integer, ByRef pAuthInfo As Integer, ByRef pCapabilites As Integer)
'CoQueryReleaseObject 'UNREFERENCED
Declare Sub CoRegisterChannelHook Lib "ole32" (ByVal ExtensionUuid As Integer, ByRef pChannelHook As Integer)
Declare Sub CoRegisterClassObject Lib "ole32" (ByVal rclsid As Integer, ByVal pUnk As Integer, ByVal dwClsContext As Integer, ByVal flags As Integer, ByRef lpdwRegister As Integer)
Declare Sub CoRegisterMallocSpy Lib "ole32" (ByVal pMallocSpy As Integer)
Declare Sub CoRegisterMessageFilter Lib "ole32" (ByVal lpMessageFilter As Integer, ByVal lplpMessageFilter As Integer)
Declare Sub CoRegisterPSClsid Lib "ole32" (ByVal riid As Integer, ByVal rclsid As Integer)
'Declare Sub CoRegisterSurrogate Lib "ole32" (ByRef pSurrogate As SURROGATE)
Declare Sub CoReleaseMarshalData Lib "ole32" (ByRef pStm As Integer)
Declare Function CoReleaseServerProcess Lib "ole32" () As Integer
Declare Sub CoResumeClassObjects Lib "ole32" ()
Declare Sub CoRevertToSelf Lib "ole32" ()
Declare Sub CoRevokeClassObject Lib "ole32" (ByVal dwRegister As Integer)
Declare Sub CoRevokeMallocSpy Lib "ole32" ()
Declare Sub CoSetProxyBlanket Lib "ole32" (ByVal pProxy As Integer, ByVal dwAuthnSvc As Integer, ByVal dwAuthzSvc As Integer, ByRef pServerPrincName As Byte, ByVal dwAuthnLevel As Integer, ByVal dwImpLevel As Integer, ByVal pAuthInfo As Integer, ByVal dwCapabilities As Integer)
'CoSetState 'UNREFERENCED
Declare Sub CoSuspendClassObjects Lib "ole32" ()
Declare Sub CoSwitchCallContext Lib "ole32" (ByVal pNewObject As Integer, ByVal ppOldObject As Integer)
Declare Function CoTaskMemAlloc Lib "ole32" (ByVal cb As Integer) As Integer
Declare Sub CoTaskMemFree Lib "ole32" (ByRef pv As Any)
Declare Function CoTaskMemRealloc Lib "ole32" (ByRef pv As Any, ByVal cb As Integer) As Integer
Declare Sub CoTreatAsClass Lib "ole32" (ByVal clsidOld As Integer, ByVal clsidNew As Integer)
Declare Sub CoUninitialize Lib "ole32" ()
'CoUnloadingWOW 'UNREFERENCED
Declare Sub CoUnmarshalHresult Lib "ole32" (ByRef pstm As Integer, ByRef phresult As Integer)
Declare Sub CoUnmarshalInterface Lib "ole32" (ByRef pStm As Integer, ByVal riid As Integer, ByRef ppv As Any)
Declare Sub CreateAntiMoniker Lib "ole32" (ByVal ppmk As Integer)
Declare Sub CreateBindCtx Lib "ole32" (ByVal reserved As Integer, ByVal ppbc As Integer)
Declare Sub CreateClassMoniker Lib "ole32" (ByVal rclsid As Integer, ByVal ppmk As Integer)
Declare Sub CreateDataAdviseHolder Lib "ole32" (ByVal ppDAHolder As Integer)
Declare Sub CreateDataCache Lib "ole32" (ByVal pUnkOuter As Integer, ByVal rclsid As Integer, ByVal iid As Integer, ByRef ppv As Any)
Declare Sub CreateErrorInfo Lib "ole32" (ByVal pperrinfo As Integer)
Declare Sub CreateFileMoniker Lib "ole32" (ByVal lpszPathName As Integer, ByVal ppmk As Integer)
Declare Sub CreateGenericComposite Lib "ole32" (ByVal pmkFirst As Integer, ByVal pmkRest As Integer, ByVal ppmkComposite As Integer)
Declare Sub CreateILockBytesOnHGlobal Lib "ole32" (ByVal hGlobal As Integer, ByVal fDeleteOnRelease As Integer, ByVal pplkbyt As Integer)
Declare Sub CreateItemMoniker Lib "ole32" (ByVal lpszDelim As Integer, ByVal lpszItem As Integer, ByVal ppmk As Integer)
Declare Sub CreateObjrefMoniker Lib "ole32" (ByVal punk As Integer, ByVal ppmk As Integer)
Declare Sub CreateOleAdviseHolder Lib "ole32" (ByVal ppOAHolder As Integer)
Declare Sub CreatePointerMoniker Lib "ole32" (ByVal punk As Integer, ByVal ppmk As Integer)
Declare Sub CreateStreamOnHGlobal Lib "ole32" (ByVal hGlobal As Integer, ByVal fDeleteOnRelease As Integer, ByRef ppstm As Integer)
'DllDebugObjectRPCHook 'UNREFERENCED
'DllGetClassObject 'GENERIC FUNCTION
'DllGetClassObjectWOW 'UNREFERENCED
'DllRegisterServer 'GENERIC FUNCTON
'Declare Sub DoDragDrop Lib "ole32" (ByRef pDataObj As DATAOBJECT, ByVal pDropSource As Integer, ByVal dwOKEffects As Integer, ByRef pdwEffect As Integer)
'EnableHookObject 'UNREFERENCED
'Declare Sub FreePropVariantArray Lib "iprop.dll" (ByVal cVariants As Integer, ByRef rgvars As PROPVARIANT)
Declare Sub GetClassFile Lib "ole32" (ByVal szFilename As Integer, ByRef pclsid As Integer)
Declare Sub GetConvertStg Lib "ole32" (ByVal pStg As Integer)
'GetDocumentBitStg 'UNREFERENCED
Declare Sub GetErrorInfo Lib "ole32" (ByVal dwReserved As Integer, ByVal pperrinfo As Integer)
Declare Sub GetHGlobalFromILockBytes Lib "ole32" (ByVal plkbyt As Integer, ByRef phglobal As Integer)
Declare Sub GetHGlobalFromStream Lib "ole32" (ByRef pstm As Integer, ByRef phglobal As Integer)
'GetHookInterface 'UNREFERENCED
Declare Sub GetRunningObjectTable Lib "ole32" (ByVal reserved As Integer, ByVal pprot As Integer)
Declare Sub HACCEL_UserFree Lib "ole32" (ByRef pInteger As Integer, ByRef pHaccel As Integer)
Declare Function HACCEL_UserMarshal Lib "ole32" (ByRef pInteger As Integer, ByVal pChar As String, ByRef pHaccel As Integer) As Integer
Declare Function HACCEL_UserSize Lib "ole32" (ByRef pInteger As Integer, ByVal lInteger As Integer, ByRef pHaccel As Integer) As Integer
Declare Function HACCEL_UserUnmarshal Lib "ole32" (ByRef pInteger As Integer, ByVal pChar As String, ByRef pHaccel As Integer) As Integer
Declare Sub HBITMAP_UserFree Lib "ole32" (ByRef pInteger As Integer, ByRef pHbitmap As Integer)
Declare Function HBITMAP_UserMarshal Lib "ole32" (ByRef pInteger As Integer, ByVal pChar As String, ByRef pHbitmap As Integer) As Integer
Declare Function HBITMAP_UserSize Lib "ole32" (ByRef pInteger As Integer, ByVal lInteger As Integer, ByRef pHbitmap As Integer) As Integer
Declare Function HBITMAP_UserUnmarshal Lib "ole32" (ByRef pInteger As Integer, ByVal pChar As String, ByRef pHbitmap As Integer) As Integer
'HBRUSH_UserFree 'UNREFERENCED
'HBRUSH_UserMarshal 'UNREFERENCED
'HBRUSH_UserSize 'UNREFERENCED
'HBRUSH_UserUnmarshal 'UNREFERENCED
'HENHMETAFILE_UserFree 'UNREFERENCED
'HENHMETAFILE_UserMarshal 'UNREFERENCED
'HENHMETAFILE_UserSize 'UNREFERENCED
'HENHMETAFILE_UserUnmarshal 'UNREFERENCED
Declare Sub HGLOBAL_UserFree Lib "ole32" (ByRef pInteger As Integer, ByRef pHglobal As Integer)
Declare Function HGLOBAL_UserMarshal Lib "ole32" (ByRef pInteger As Integer, ByVal pChar As String, ByRef pHglobal As Integer) As Integer
Declare Function HGLOBAL_UserSize Lib "ole32" (ByRef pInteger As Integer, ByVal lInteger As Integer, ByRef pHglobal As Integer) As Integer
Declare Function HGLOBAL_UserUnmarshal Lib "ole32" (ByRef pInteger As Integer, ByVal pChar As String, ByRef pHglobal As Integer) As Integer
Declare Sub HMENU_UserFree Lib "ole32" (ByRef pInteger As Integer, ByRef pHmenu As Integer)
Declare Function HMENU_UserMarshal Lib "ole32" (ByRef pInteger As Integer, ByVal pChar As String, ByRef pHmenu As Integer) As Integer
Declare Function HMENU_UserSize Lib "ole32" (ByRef pInteger As Integer, ByVal lInteger As Integer, ByRef pHmenu As Integer) As Integer
Declare Function HMENU_UserUnmarshal Lib "ole32" (ByRef pInteger As Integer, ByVal pChar As String, ByRef pHmenu As Integer) As Integer
'HMETAFILEPICT_UserFree 'UNREFERENCED
'HMETAFILEPICT_UserMarshal 'UNREFERENCED
'HMETAFILEPICT_UserSize 'UNREFERENCED
'HMETAFILEPICT_UserUnmarshal 'UNREFERENCED
'HMETAFILE_UserFree 'UNREFERENCED
'HMETAFILE_UserMarshal 'UNREFERENCED
'HMETAFILE_UserSize 'UNREFERENCED
'HMETAFILE_UserUnmarshal 'UNREFERENCED
Declare Sub HPALETTE_UserFree Lib "ole32" (ByRef pInteger As Integer, ByRef pHpalette As Integer)
Declare Function HPALETTE_UserMarshal Lib "ole32" (ByRef pInteger As Integer, ByVal pChar As String, ByRef pHpalette As Integer) As Integer
Declare Function HPALETTE_UserSize Lib "ole32" (ByRef pInteger As Integer, ByVal lInteger As Integer, ByRef pHpalette As Integer) As Integer
Declare Function HPALETTE_UserUnmarshal Lib "ole32" (ByRef pInteger As Integer, ByVal pChar As String, ByRef pHpalette As Integer) As Integer
Declare Sub HWND_UserFree Lib "ole32" (ByRef pInteger As Integer, ByRef pHwnd As Integer)
Declare Function HWND_UserMarshal Lib "ole32" (ByRef pInteger As Integer, ByVal pChar As String, ByRef pHwnd As Integer) As Integer
Declare Function HWND_UserSize Lib "ole32" (ByRef pInteger As Integer, ByVal lInteger As Integer, ByRef pHwnd As Integer) As Integer
Declare Function HWND_UserUnmarshal Lib "ole32" (ByRef pInteger As Integer, ByVal pChar As String, ByRef pHwnd As Integer) As Integer
Declare Sub IIDFromString Lib "ole32" (ByVal lpsz As String, ByVal lpiid As Integer)
'I_RemoteMain 'UNREFERENCED
Declare Function IsAccelerator Lib "ole32" (ByVal hAccel As Integer, ByVal cAccelEntries As Integer, ByRef lpMsg As MSG, ByRef lpwCmd As Short) As Integer
'IsEqualGUID 'UNREFERENCED
'IsValidIid 'UNREFERENCED
'IsValidInterface 'UNREFERENCED
'IsValidPtrIn 'UNREFERENCED
'IsValidPtrOut 'UNREFERENCED
Declare Sub MkParseDisplayName Lib "ole32" (ByVal pbc As Integer, ByVal szUserName As Integer, ByRef pchEaten As Integer, ByVal ppmk As Integer)
Declare Sub MonikerCommonPrefixWith Lib "ole32" (ByVal pmkThis As Integer, ByVal pmkOther As Integer, ByVal ppmkCommon As Integer)
Declare Sub MonikerRelativePathTo Lib "ole32" (ByVal pmkSrc As Integer, ByVal pmkDest As Integer, ByVal ppmkRelPath As Integer, ByVal dwReserved As Integer)
Declare Function OleBuildVersion Lib "ole32" () As Integer
'Declare Sub OleConvertIStorageToOLESTREAM Lib "ole32" (ByVal pstg As Integer, ByRef lpolestream As LPOLESTREAM)
'Declare Sub OleConvertIStorageToOLESTREAMEx Lib "ole32" (ByVal pstg As Integer, ByVal cfFormat As Short, ByVal lWidth As Integer, ByVal lHeight As Integer, ByVal dwSize As Integer, ByVal pmedium As Integer, ByRef polestm As LPOLESTREAM)
'Declare Sub OleConvertOLESTREAMToIStorage Lib "ole32" (ByRef lpolestream As LPOLESTREAM, ByVal pstg As Integer, ByRef ptd As DVTARGETDEVICE)
'Declare Sub OleConvertOLESTREAMToIStorageEx Lib "ole32" (ByRef polestm As LPOLESTREAM, ByVal pstg As Integer, ByRef pcfFormat As Short, ByRef plwWidth As Integer, ByRef plHeight As Integer, ByRef pdwSize As Integer, ByVal pmedium As Integer)
'Declare Sub OleCreate Lib "ole32" (ByVal rclsid As Integer, ByVal riid As Integer, ByVal renderopt As Integer, ByRef pFormatEtc As FORMATETC, ByVal pClientSite As Integer, ByVal pStg As Integer, ByRef ppvObj As Any)
Declare Sub OleCreateDefaultHandler Lib "ole32" (ByVal clsid As Integer, ByVal pUnkOuter As Integer, ByVal riid As Integer, ByRef lplpObj As Any)
Declare Sub OleCreateEmbeddingHelper Lib "ole32" (ByVal clsid As Integer, ByVal pUnkOuter As Integer, ByVal flags As Integer, ByVal pCF As Integer, ByVal riid As Integer, ByRef lplpObj As Any)
'Declare Sub OleCreateEx Lib "ole32" (ByVal rclsid As Integer, ByVal riid As Integer, ByVal dwFlags As Integer, ByVal renderopt As Integer, ByVal cFormats As Integer, ByRef rgAdvf As Integer, ByRef rgFormatEtc As FORMATETC, ByVal lpAdviseSink As Integer, ByRef rgdwConnection As Integer, ByVal pClientSite As Integer, ByVal pStg As Integer, ByRef ppvObj As Any)
'Declare Sub OleCreateFromData Lib "ole32" (ByRef pSrcDataObj As DATAOBJECT, ByVal riid As Integer, ByVal renderopt As Integer, ByRef pFormatEtc As FORMATETC, ByVal pClientSite As Integer, ByVal pStg As Integer, ByRef ppvObj As Any)
'Declare Sub OleCreateFromDataEx Lib "ole32" (ByRef pSrcDataObj As DATAOBJECT, ByVal riid As Integer, ByVal dwFlags As Integer, ByVal renderopt As Integer, ByVal cFormats As Integer, ByRef rgAdvf As Integer, ByRef rgFormatEtc As FORMATETC, ByVal lpAdviseSink As Integer, ByRef rgdwConnection As Integer, ByVal pClientSite As Integer, ByVal pStg As Integer, ByRef ppvObj As Any)
'Declare Sub OleCreateFromFile Lib "ole32" (ByVal rclsid As Integer, ByVal lpszFileName As Integer, ByVal riid As Integer, ByVal renderopt As Integer, ByRef lpFormatEtc As FORMATETC, ByVal pClientSite As Integer, ByVal pStg As Integer, ByRef ppvObj As Any)
'Declare Sub OleCreateFromFileEx Lib "ole32" (ByVal rclsid As Integer, ByVal lpszFileName As Integer, ByVal riid As Integer, ByVal dwFlags As Integer, ByVal renderopt As Integer, ByVal cFormats As Integer, ByRef rgAdvf As Integer, ByRef rgFormatEtc As FORMATETC, ByVal lpAdviseSink As Integer, ByRef rgdwConnection As Integer, ByVal pClientSite As Integer, ByVal pStg As Integer, ByRef ppvObj As Any)
'Declare Sub OleCreateLink Lib "ole32" (ByVal pmkLinkSrc As Integer, ByVal riid As Integer, ByVal renderopt As Integer, ByRef lpFormatEtc As FORMATETC, ByVal pClientSite As Integer, ByVal pStg As Integer, ByRef ppvObj As Any)
'Declare Sub OleCreateLinkEx Lib "ole32" (ByVal pmkLinkSrc As Integer, ByVal riid As Integer, ByVal dwFlags As Integer, ByVal renderopt As Integer, ByVal cFormats As Integer, ByRef rgAdvf As Integer, ByRef rgFormatEtc As FORMATETC, ByVal lpAdviseSink As Integer, ByRef rgdwConnection As Integer, ByVal pClientSite As Integer, ByVal pStg As Integer, ByRef ppvObj As Any)
'Declare Sub OleCreateLinkFromData Lib "ole32" (ByRef pSrcDataObj As DATAOBJECT, ByVal riid As Integer, ByVal renderopt As Integer, ByRef pFormatEtc As FORMATETC, ByVal pClientSite As Integer, ByVal pStg As Integer, ByRef ppvObj As Any)
'Declare Sub OleCreateLinkFromDataEx Lib "ole32" (ByRef pSrcDataObj As DATAOBJECT, ByVal riid As Integer, ByVal dwFlags As Integer, ByVal renderopt As Integer, ByVal cFormats As Integer, ByRef rgAdvf As Integer, ByRef rgFormatEtc As FORMATETC, ByVal lpAdviseSink As Integer, ByRef rgdwConnection As Integer, ByVal pClientSite As Integer, ByVal pStg As Integer, ByRef ppvObj As Any)
'Declare Sub OleCreateLinkToFile Lib "ole32" (ByVal lpszFileName As Integer, ByVal riid As Integer, ByVal renderopt As Integer, ByRef lpFormatEtc As FORMATETC, ByVal pClientSite As Integer, ByVal pStg As Integer, ByRef ppvObj As Any)
'Declare Sub OleCreateLinkToFileEx Lib "ole32" (ByVal lpszFileName As Integer, ByVal riid As Integer, ByVal dwFlags As Integer, ByVal renderopt As Integer, ByVal cFormats As Integer, ByRef rgAdvf As Integer, ByRef rgFormatEtc As FORMATETC, ByVal lpAdviseSink As Integer, ByRef rgdwConnection As Integer, ByVal pClientSite As Integer, ByVal pStg As Integer, ByRef ppvObj As Any)
Declare Function OleCreateMenuDescriptor Lib "ole32" (ByVal hmenuCombined As Integer, ByVal lpMenuWidths As Integer) As Integer
'Declare Sub OleCreateStaticFromData Lib "ole32" (ByRef pSrcDataObj As DATAOBJECT, ByVal iid As Integer, ByVal renderopt As Integer, ByRef pFormatEtc As FORMATETC, ByVal pClientSite As Integer, ByVal pStg As Integer, ByRef ppvObj As Any)
Declare Sub OleDoAutoConvert Lib "ole32" (ByVal pStg As Integer, ByVal pClsidNew As Integer)
Declare Sub OleDraw Lib "ole32" (ByVal pUnknown As Integer, ByVal dwAspect As Integer, ByVal hdcDraw As Integer, ByRef lprcBounds As RECT)
Declare Function OleDuplicateData Lib "ole32" (ByVal hSrc As Integer, ByVal cfFormat As Short, ByVal uiFlags As Integer) As Integer
Declare Sub OleFlushClipboard Lib "ole32" ()
Declare Sub OleGetAutoConvert Lib "ole32" (ByVal clsidOld As Integer, ByVal pClsidNew As Integer)
'Declare Sub OleGetClipboard Lib "ole32" (ByRef ppDataObj As DATAOBJECT)
Declare Function OleGetIconOfClass Lib "ole32" (ByVal rclsid As Integer, ByVal lpszLabel As String, ByVal fUseTypeAsLabel As Integer) As Integer
Declare Function OleGetIconOfFile Lib "ole32" (ByVal lpszPath As String, ByVal fUseFileAsLabel As Integer) As Integer
Declare Sub OleInitialize Lib "ole32" (ByRef pvReserved As Any)
'OleInitializeWOW 'UNREFERENCED
'Declare Sub OleIsCurrentClipboard Lib "ole32" (ByRef pDataObj As DATAOBJECT)
Declare Function OleIsRunning Lib "ole32" (ByVal pObject As Integer) As Integer
Declare Sub OleLoad Lib "ole32" (ByVal pStg As Integer, ByVal riid As Integer, ByVal pClientSite As Integer, ByRef ppvObj As Any)
Declare Sub OleLoadFromStream Lib "ole32" (ByRef pStm As Integer, ByVal iidInterface As Integer, ByRef ppvObj As Any)
Declare Sub OleLockRunning Lib "ole32" (ByVal pUnknown As Integer, ByVal fLock As Integer, ByVal fLastUnlockCloses As Integer)
Declare Function OleMetafilePictFromIconAndLabel Lib "ole32" (ByVal hIcon As Integer, ByVal lpszLabel As String, ByVal lpszSourceFile As String, ByVal iIconIndex As Integer) As Integer
Declare Sub OleNoteObjectVisible Lib "ole32" (ByVal pUnknown As Integer, ByVal fVisible As Integer)
'Declare Sub OleQueryCreateFromData Lib "ole32" (ByRef pSrcDataObject As DATAOBJECT)
'Declare Sub OleQueryLinkFromData Lib "ole32" (ByRef pSrcDataObject As DATAOBJECT)
Declare Sub OleRegEnumFormatEtc Lib "ole32" (ByVal clsid As Integer, ByVal dwDirection As Integer, ByVal ppenum As Integer)
Declare Sub OleRegEnumVerbs Lib "ole32" (ByVal clsid As Integer, ByVal ppenum As Integer)
Declare Sub OleRegGetMiscStatus Lib "ole32" (ByVal clsid As Integer, ByVal dwAspect As Integer, ByRef pdwStatus As Integer)
Declare Sub OleRegGetUserType Lib "ole32" (ByVal clsid As Integer, ByVal dwFormOfType As Integer, ByVal pszUserType As String)
Declare Sub OleRun Lib "ole32" (ByVal pUnknown As Integer)
Declare Sub OleSave Lib "ole32" (ByVal pPS As Integer, ByVal pStg As Integer, ByVal fSameAsLoad As Integer)
Declare Sub OleSaveToStream Lib "ole32" (ByVal pPStm As Integer, ByRef pStm As Integer)
Declare Sub OleSetAutoConvert Lib "ole32" (ByVal clsidOld As Integer, ByVal clsidNew As Integer)
'Declare Sub OleSetClipboard Lib "ole32" (ByRef pDataObj As IUnknown)
Declare Sub OleSetContainedObject Lib "ole32" (ByVal pUnknown As Integer, ByVal fContained As Integer)
Declare Sub OleSetMenuDescriptor Lib "ole32" (ByVal holemenu As Integer, ByVal hwndFrame As Integer, ByVal hwndActiveObject As Integer, ByVal lpFrame As Integer, ByVal lpActiveObj As Integer)
Declare Sub OleTranslateAccelerator Lib "ole32" (ByVal lpFrame As Integer, ByVal lpFrameInfo As Integer, ByRef lpmsg As MSG)
Declare Sub OleUninitialize Lib "ole32" ()
'ProgIDFromCLSID 'UNREFERENCED
'PropSysAllocString 'UNREFERENCED
'PropSysFreeString 'UNREFERENCED
'Declare Sub PropVariantCopy Lib "ole32" (ByRef pvarDest As PROPVARIANT, ByRef pvarSrc As PROPVARIANT)
Declare Sub ReadClassStg Lib "ole32" (ByVal pStg As Integer, ByRef pclsid As Integer)
Declare Sub ReadClassStm Lib "ole32" (ByRef pStm As Integer, ByRef pclsid As Integer)
Declare Sub ReadFmtUserTypeStg Lib "ole32" (ByVal pstg As Integer, ByRef pcf As Short, ByVal lplpszUserType As String)
'ReadOleStg 'UNREFERENCED
'ReadStringStream 'UNREFERENCED
Declare Sub RegisterDragDrop Lib "ole32" (ByVal hwnd As Integer, ByVal pDropTarget As Integer)
Declare Sub ReleaseStgMedium Lib "ole32" (ByVal lpstgmedium As Integer)
Declare Sub RevokeDragDrop Lib "ole32" (ByVal hwnd As Integer)
Declare Sub SNB_UserFree Lib "ole32" (ByRef pInteger As Integer, ByVal pSnb As Integer)
Declare Function SNB_UserMarshal Lib "ole32" (ByRef pInteger As Integer, ByVal pChar As String, ByVal pSnb As Integer) As Integer
Declare Function SNB_UserSize Lib "ole32" (ByRef pInteger As Integer, ByVal lInteger As Integer, ByVal pSnb As Integer) As Integer
Declare Function SNB_UserUnmarshal Lib "ole32" (ByRef pInteger As Integer, ByVal pChar As String, ByVal pSnb As Integer) As Integer
'Declare Sub STGMEDIUM_UserFree Lib "ole32" (ByRef pInteger As Integer, ByRef pStgmedium As STGMEDIUM)
'Declare Function STGMEDIUM_UserMarshal Lib "ole32" (ByRef pInteger As Integer, ByVal pChar As String, ByRef pStgmedium As STGMEDIUM) As Integer
'Declare Function STGMEDIUM_UserSize Lib "ole32" (ByRef pInteger As Integer, ByVal Integer As Integer, ByRef pStgmedium As STGMEDIUM) As Integer
'Declare Function STGMEDIUM_UserUnmarshal Lib "ole32" (ByRef pInteger As Integer, ByVal pChar As String, ByRef pStgmedium As STGMEDIUM) As Integer
Declare Sub SetConvertStg Lib "ole32" (ByVal pStg As Integer, ByVal fConvert As Integer)
'SetDocumentBitStg 'UNREFERENCED
Declare Sub SetErrorInfo Lib "ole32" (ByVal dwReserved As Integer, ByVal perrinfo As Integer)
Declare Sub StgCreateDocfile Lib "ole32" (ByRef pwcsName As Byte, ByVal grfMode As Integer, ByVal reserved As Integer, ByVal ppstgOpen As Integer)
Declare Sub StgCreateDocfileOnILockBytes Lib "ole32" (ByVal plkbyt As Integer, ByVal grfMode As Integer, ByVal reserved As Integer, ByVal ppstgOpen As Integer)
'Declare Sub StgCreateStorageEx Lib "ole32" (ByRef pwcsName As Byte, ByVal grfMode As Integer, ByVal stgfmt As Integer, ByVal grfAttrs As Integer, ByRef pStgOptions As STGOPTIONS, ByRef reserved As Any, ByVal riid As Integer, ByRef ppObjectOpen As Any)
Declare Sub StgGetIFillLockBytesOnFile Lib "ole32" (ByRef pwcsName As Byte, ByRef ppflb As Integer)
Declare Sub StgGetIFillLockBytesOnILockBytes Lib "ole32" (ByVal pilb As Integer, ByRef ppflb As Integer)
Declare Sub StgIsStorageFile Lib "ole32" (ByRef pwcsName As Byte)
Declare Sub StgIsStorageILockBytes Lib "ole32" (ByVal plkbyt As Integer)
Declare Sub StgOpenStorage Lib "ole32" (ByRef pwcsName As Byte, ByVal pstgPriority As Integer, ByVal grfMode As Integer, ByVal snbExclude As Integer, ByVal reserved As Integer, ByVal ppstgOpen As Integer)
'Declare Sub StgOpenStorageEx Lib "ole32" (ByRef pwcsName As Byte, ByVal grfMode As Integer, ByVal stgfmt As Integer, ByVal grfAttrs As Integer, ByRef pStgOptions As STGOPTIONS, ByRef reserved As Any, ByVal riid As Integer, ByRef ppObjectOpen As Any)
Declare Sub StgOpenStorageOnILockBytes Lib "ole32" (ByVal plkbyt As Integer, ByVal pstgPriority As Integer, ByVal grfMode As Integer, ByVal snbExclude As Integer, ByVal reserved As Integer, ByVal ppstgOpen As Integer)
Declare Sub StgSetTimes Lib "ole32" (ByRef lpszName As Byte, ByRef pctime As FILETIME, ByRef patime As FILETIME, ByRef pmtime As FILETIME)
Declare Sub StringFromCLSID Lib "ole32" (ByVal rclsid As Integer, ByVal lplpsz As String)
Declare Function StringFromGUID2 Lib "ole32" (ByVal rguid As Integer, ByVal lpsz As String, ByVal cchMax As Integer) As Integer
Declare Sub StringFromIID Lib "ole32" (ByVal rclsid As Integer, ByVal lplpsz As String)
'UpdateDCOMSettings 'UNREFERENCED
'UtConvertDvtd16toDvtd32 'UNREFERENCED
'UtConvertDvtd32toDvtd16 'UNREFERENCED
'UtGetDvtd16Info 'UNREFERENCED
'UtGetDvtd32Info 'UNREFERENCED
'WdtpInterfacePointer_UserFree 'UNREFERENCED
'WdtpInterfacePointer_UserMarshal 'UNREFERENCED
'WdtpInterfacePointer_UserSize 'UNREFERENCED
'WdtpInterfacePointer_UserUnmarshal 'UNREFERENCED
Declare Sub WriteClassStg Lib "ole32" (ByVal pStg As Integer, ByVal rclsid As Integer)
Declare Sub WriteClassStm Lib "ole32" (ByRef pStm As Integer, ByVal rclsid As Integer)
Declare Sub WriteFmtUserTypeStg Lib "ole32" (ByVal pstg As Integer, ByVal cf As Short, ByVal lpszUserType As String)
'WriteOleStg 'UNREFERENCED
'WriteStringStream 'UNREFERENCED

#endif 'OLE32