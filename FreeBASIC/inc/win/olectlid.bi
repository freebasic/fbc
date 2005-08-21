''
''
'' olectlid -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __olectlid_bi__
#define __olectlid_bi__

extern import IID_IDispatch alias "IID_IDispatch" as GUID
extern import IID_IPropertyNotifySink alias "IID_IPropertyNotifySink" as GUID
extern import IID_IClassFactory2 alias "IID_IClassFactory2" as GUID
extern import IID_IProvideClassInfo alias "IID_IProvideClassInfo" as GUID
extern import IID_IProvideClassInfo2 alias "IID_IProvideClassInfo2" as GUID
extern import IID_IConnectionPointContainer alias "IID_IConnectionPointContainer" as GUID
extern import IID_IEnumConnectionPoints alias "IID_IEnumConnectionPoints" as GUID
extern import IID_IConnectionPoint alias "IID_IConnectionPoint" as GUID
extern import IID_IEnumConnections alias "IID_IEnumConnections" as GUID
extern import IID_IOleControl alias "IID_IOleControl" as GUID
extern import IID_IOleControlSite alias "IID_IOleControlSite" as GUID
extern import IID_ISimpleFrameSite alias "IID_ISimpleFrameSite" as GUID
extern import IID_IPersistStreamInit alias "IID_IPersistStreamInit" as GUID
extern import IID_IPersistMemory alias "IID_IPersistMemory" as GUID
extern import IID_IPersistPropertyBag alias "IID_IPersistPropertyBag" as GUID
extern import IID_IPropertyBag alias "IID_IPropertyBag" as GUID
extern import IID_IErrorLog alias "IID_IErrorLog" as GUID
extern import IID_IPropertyFrame alias "IID_IPropertyFrame" as GUID
extern import IID_ISpecifyPropertyPages alias "IID_ISpecifyPropertyPages" as GUID
extern import IID_IPerPropertyBrowsing alias "IID_IPerPropertyBrowsing" as GUID
extern import IID_IPropertyPageSite alias "IID_IPropertyPageSite" as GUID
extern import IID_IPropertyPage alias "IID_IPropertyPage" as GUID
extern import IID_IPropertyPage2 alias "IID_IPropertyPage2" as GUID
extern import CLSID_CFontPropPage alias "CLSID_CFontPropPage" as GUID
extern import CLSID_CColorPropPage alias "CLSID_CColorPropPage" as GUID
extern import CLSID_CPicturePropPage alias "CLSID_CPicturePropPage" as GUID
extern import CLSID_PersistPropset alias "CLSID_PersistPropset" as GUID
extern import CLSID_ConvertVBX alias "CLSID_ConvertVBX" as GUID
extern import CLSID_StdFont alias "CLSID_StdFont" as GUID
extern import CLSID_StdPicture alias "CLSID_StdPicture" as GUID
extern import IID_IFont alias "IID_IFont" as GUID
extern import IID_IFontDisp alias "IID_IFontDisp" as GUID
extern import IID_IPicture alias "IID_IPicture" as GUID
extern import IID_IPictureDisp alias "IID_IPictureDisp" as GUID
extern import GUID_HIMETRIC alias "GUID_HIMETRIC" as GUID
extern import GUID_COLOR alias "GUID_COLOR" as GUID
extern import GUID_XPOSPIXEL alias "GUID_XPOSPIXEL" as GUID
extern import GUID_YPOSPIXEL alias "GUID_YPOSPIXEL" as GUID
extern import GUID_XSIZEPIXEL alias "GUID_XSIZEPIXEL" as GUID
extern import GUID_YSIZEPIXEL alias "GUID_YSIZEPIXEL" as GUID
extern import GUID_XPOS alias "GUID_XPOS" as GUID
extern import GUID_YPOS alias "GUID_YPOS" as GUID
extern import GUID_XSIZE alias "GUID_XSIZE" as GUID
extern import GUID_YSIZE alias "GUID_YSIZE" as GUID
extern import GUID_TRISTATE alias "GUID_TRISTATE" as GUID
extern import GUID_OPTIONVALUEEXCLUSIVE alias "GUID_OPTIONVALUEEXCLUSIVE" as GUID
extern import GUID_CHECKVALUEEXCLUSIVE alias "GUID_CHECKVALUEEXCLUSIVE" as GUID
extern import GUID_FONTNAME alias "GUID_FONTNAME" as GUID
extern import GUID_FONTSIZE alias "GUID_FONTSIZE" as GUID
extern import GUID_FONTBOLD alias "GUID_FONTBOLD" as GUID
extern import GUID_FONTITALIC alias "GUID_FONTITALIC" as GUID
extern import GUID_FONTUNDERSCORE alias "GUID_FONTUNDERSCORE" as GUID
extern import GUID_FONTSTRIKETHROUGH alias "GUID_FONTSTRIKETHROUGH" as GUID
extern import GUID_HANDLE alias "GUID_HANDLE" as GUID
extern import IID_IEnumUnknown alias "IID_IEnumUnknown" as GUID
extern import IID_IEnumString alias "IID_IEnumString" as GUID
extern import IID_IEnumMoniker alias "IID_IEnumMoniker" as GUID
extern import IID_IEnumFORMATETC alias "IID_IEnumFORMATETC" as GUID
extern import IID_IEnumOLEVERB alias "IID_IEnumOLEVERB" as GUID
extern import IID_IEnumSTATDATA alias "IID_IEnumSTATDATA" as GUID
extern import IID_IEnumSTATSTG alias "IID_IEnumSTATSTG" as GUID
extern import IID_IEnumGeneric alias "IID_IEnumGeneric" as GUID
extern import IID_IEnumHolder alias "IID_IEnumHolder" as GUID
extern import IID_IEnumCallback alias "IID_IEnumCallback" as GUID
extern import IID_IPersistStream alias "IID_IPersistStream" as GUID
extern import IID_IPersistStorage alias "IID_IPersistStorage" as GUID
extern import IID_IPersistFile alias "IID_IPersistFile" as GUID
extern import IID_IPersist alias "IID_IPersist" as GUID
extern import IID_IViewObject alias "IID_IViewObject" as GUID
extern import IID_IDataObject alias "IID_IDataObject" as GUID
extern import IID_IAdviseSink alias "IID_IAdviseSink" as GUID
extern import IID_IDataAdviseHolder alias "IID_IDataAdviseHolder" as GUID
extern import IID_IOleAdviseHolder alias "IID_IOleAdviseHolder" as GUID
extern import IID_IOleObject alias "IID_IOleObject" as GUID
extern import IID_IOleInPlaceObject alias "IID_IOleInPlaceObject" as GUID
extern import IID_IOleWindow alias "IID_IOleWindow" as GUID
extern import IID_IOleInPlaceUIWindow alias "IID_IOleInPlaceUIWindow" as GUID
extern import IID_IOleInPlaceFrame alias "IID_IOleInPlaceFrame" as GUID
extern import IID_IOleInPlaceActiveObject alias "IID_IOleInPlaceActiveObject" as GUID
extern import IID_IOleClientSite alias "IID_IOleClientSite" as GUID
extern import IID_IOleInPlaceSite alias "IID_IOleInPlaceSite" as GUID
extern import IID_IParseDisplayName alias "IID_IParseDisplayName" as GUID
extern import IID_IOleContainer alias "IID_IOleContainer" as GUID
extern import IID_IOleItemContainer alias "IID_IOleItemContainer" as GUID
extern import IID_IOleLink alias "IID_IOleLink" as GUID
extern import IID_IOleCache alias "IID_IOleCache" as GUID
extern import IID_IOleManager alias "IID_IOleManager" as GUID
extern import IID_IOlePresObj alias "IID_IOlePresObj" as GUID
extern import IID_IDropSource alias "IID_IDropSource" as GUID
extern import IID_IDropTarget alias "IID_IDropTarget" as GUID
extern import IID_IDebug alias "IID_IDebug" as GUID
extern import IID_IDebugStream alias "IID_IDebugStream" as GUID
extern import IID_IAdviseSink2 alias "IID_IAdviseSink2" as GUID
extern import IID_IRunnableObject alias "IID_IRunnableObject" as GUID
extern import IID_IViewObject2 alias "IID_IViewObject2" as GUID
extern import IID_IOleCache2 alias "IID_IOleCache2" as GUID
extern import IID_IOleCacheControl alias "IID_IOleCacheControl" as GUID
extern import CLSID_Picture_Metafile alias "CLSID_Picture_Metafile" as GUID
extern import CLSID_Picture_Dib alias "CLSID_Picture_Dib" as GUID

#endif
