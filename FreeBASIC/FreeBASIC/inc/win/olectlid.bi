''
''
'' olectlid -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_olectlid_bi__
#define __win_olectlid_bi__

#inclib "uuid"

extern IID_IDispatch alias "IID_IDispatch" as GUID
extern IID_IPropertyNotifySink alias "IID_IPropertyNotifySink" as GUID
extern IID_IClassFactory2 alias "IID_IClassFactory2" as GUID
extern IID_IProvideClassInfo alias "IID_IProvideClassInfo" as GUID
extern IID_IProvideClassInfo2 alias "IID_IProvideClassInfo2" as GUID
extern IID_IConnectionPointContainer alias "IID_IConnectionPointContainer" as GUID
extern IID_IEnumConnectionPoints alias "IID_IEnumConnectionPoints" as GUID
extern IID_IConnectionPoint alias "IID_IConnectionPoint" as GUID
extern IID_IEnumConnections alias "IID_IEnumConnections" as GUID
extern IID_IOleControl alias "IID_IOleControl" as GUID
extern IID_IOleControlSite alias "IID_IOleControlSite" as GUID
extern IID_ISimpleFrameSite alias "IID_ISimpleFrameSite" as GUID
extern IID_IPersistStreamInit alias "IID_IPersistStreamInit" as GUID
extern IID_IPersistMemory alias "IID_IPersistMemory" as GUID
extern IID_IPersistPropertyBag alias "IID_IPersistPropertyBag" as GUID
extern IID_IPropertyBag alias "IID_IPropertyBag" as GUID
extern IID_IErrorLog alias "IID_IErrorLog" as GUID
extern IID_IPropertyFrame alias "IID_IPropertyFrame" as GUID
extern IID_ISpecifyPropertyPages alias "IID_ISpecifyPropertyPages" as GUID
extern IID_IPerPropertyBrowsing alias "IID_IPerPropertyBrowsing" as GUID
extern IID_IPropertyPageSite alias "IID_IPropertyPageSite" as GUID
extern IID_IPropertyPage alias "IID_IPropertyPage" as GUID
extern IID_IPropertyPage2 alias "IID_IPropertyPage2" as GUID
extern CLSID_CFontPropPage alias "CLSID_CFontPropPage" as GUID
extern CLSID_CColorPropPage alias "CLSID_CColorPropPage" as GUID
extern CLSID_CPicturePropPage alias "CLSID_CPicturePropPage" as GUID
extern CLSID_PersistPropset alias "CLSID_PersistPropset" as GUID
extern CLSID_ConvertVBX alias "CLSID_ConvertVBX" as GUID
extern CLSID_StdFont alias "CLSID_StdFont" as GUID
extern CLSID_StdPicture alias "CLSID_StdPicture" as GUID
extern IID_IFont alias "IID_IFont" as GUID
extern IID_IFontDisp alias "IID_IFontDisp" as GUID
extern IID_IPicture alias "IID_IPicture" as GUID
extern IID_IPictureDisp alias "IID_IPictureDisp" as GUID
extern GUID_HIMETRIC alias "GUID_HIMETRIC" as GUID
extern GUID_COLOR alias "GUID_COLOR" as GUID
extern GUID_XPOSPIXEL alias "GUID_XPOSPIXEL" as GUID
extern GUID_YPOSPIXEL alias "GUID_YPOSPIXEL" as GUID
extern GUID_XSIZEPIXEL alias "GUID_XSIZEPIXEL" as GUID
extern GUID_YSIZEPIXEL alias "GUID_YSIZEPIXEL" as GUID
extern GUID_XPOS alias "GUID_XPOS" as GUID
extern GUID_YPOS alias "GUID_YPOS" as GUID
extern GUID_XSIZE alias "GUID_XSIZE" as GUID
extern GUID_YSIZE alias "GUID_YSIZE" as GUID
extern GUID_TRISTATE alias "GUID_TRISTATE" as GUID
extern GUID_OPTIONVALUEEXCLUSIVE alias "GUID_OPTIONVALUEEXCLUSIVE" as GUID
extern GUID_CHECKVALUEEXCLUSIVE alias "GUID_CHECKVALUEEXCLUSIVE" as GUID
extern GUID_FONTNAME alias "GUID_FONTNAME" as GUID
extern GUID_FONTSIZE alias "GUID_FONTSIZE" as GUID
extern GUID_FONTBOLD alias "GUID_FONTBOLD" as GUID
extern GUID_FONTITALIC alias "GUID_FONTITALIC" as GUID
extern GUID_FONTUNDERSCORE alias "GUID_FONTUNDERSCORE" as GUID
extern GUID_FONTSTRIKETHROUGH alias "GUID_FONTSTRIKETHROUGH" as GUID
extern GUID_HANDLE alias "GUID_HANDLE" as GUID
extern IID_IEnumUnknown alias "IID_IEnumUnknown" as GUID
extern IID_IEnumString alias "IID_IEnumString" as GUID
extern IID_IEnumMoniker alias "IID_IEnumMoniker" as GUID
extern IID_IEnumFORMATETC alias "IID_IEnumFORMATETC" as GUID
extern IID_IEnumOLEVERB alias "IID_IEnumOLEVERB" as GUID
extern IID_IEnumSTATDATA alias "IID_IEnumSTATDATA" as GUID
extern IID_IEnumSTATSTG alias "IID_IEnumSTATSTG" as GUID
extern IID_IEnumGeneric alias "IID_IEnumGeneric" as GUID
extern IID_IEnumHolder alias "IID_IEnumHolder" as GUID
extern IID_IEnumCallback alias "IID_IEnumCallback" as GUID
extern IID_IPersistStream alias "IID_IPersistStream" as GUID
extern IID_IPersistStorage alias "IID_IPersistStorage" as GUID
extern IID_IPersistFile alias "IID_IPersistFile" as GUID
extern IID_IPersist alias "IID_IPersist" as GUID
extern IID_IViewObject alias "IID_IViewObject" as GUID
extern IID_IDataObject alias "IID_IDataObject" as GUID
extern IID_IAdviseSink alias "IID_IAdviseSink" as GUID
extern IID_IDataAdviseHolder alias "IID_IDataAdviseHolder" as GUID
extern IID_IOleAdviseHolder alias "IID_IOleAdviseHolder" as GUID
extern IID_IOleObject alias "IID_IOleObject" as GUID
extern IID_IOleInPlaceObject alias "IID_IOleInPlaceObject" as GUID
extern IID_IOleWindow alias "IID_IOleWindow" as GUID
extern IID_IOleInPlaceUIWindow alias "IID_IOleInPlaceUIWindow" as GUID
extern IID_IOleInPlaceFrame alias "IID_IOleInPlaceFrame" as GUID
extern IID_IOleInPlaceActiveObject alias "IID_IOleInPlaceActiveObject" as GUID
extern IID_IOleClientSite alias "IID_IOleClientSite" as GUID
extern IID_IOleInPlaceSite alias "IID_IOleInPlaceSite" as GUID
extern IID_IParseDisplayName alias "IID_IParseDisplayName" as GUID
extern IID_IOleContainer alias "IID_IOleContainer" as GUID
extern IID_IOleItemContainer alias "IID_IOleItemContainer" as GUID
extern IID_IOleLink alias "IID_IOleLink" as GUID
extern IID_IOleCache alias "IID_IOleCache" as GUID
extern IID_IOleManager alias "IID_IOleManager" as GUID
extern IID_IOlePresObj alias "IID_IOlePresObj" as GUID
extern IID_IDropSource alias "IID_IDropSource" as GUID
extern IID_IDropTarget alias "IID_IDropTarget" as GUID
extern IID_IDebug alias "IID_IDebug" as GUID
extern IID_IDebugStream alias "IID_IDebugStream" as GUID
extern IID_IAdviseSink2 alias "IID_IAdviseSink2" as GUID
extern IID_IRunnableObject alias "IID_IRunnableObject" as GUID
extern IID_IViewObject2 alias "IID_IViewObject2" as GUID
extern IID_IOleCache2 alias "IID_IOleCache2" as GUID
extern IID_IOleCacheControl alias "IID_IOleCacheControl" as GUID
extern CLSID_Picture_Metafile alias "CLSID_Picture_Metafile" as GUID
extern CLSID_Picture_Dib alias "CLSID_Picture_Dib" as GUID

#endif
