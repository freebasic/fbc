'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   DISCLAIMER
''   This file has no copyright assigned and is placed in the Public Domain.
''   This file is part of the mingw-w64 runtime package.
''
''   The mingw-w64 runtime package and its code is distributed in the hope that it 
''   will be useful but WITHOUT ANY WARRANTY.  ALL WARRANTIES, EXPRESSED OR 
''   IMPLIED ARE HEREBY DISCLAIMED.  This includes but is not limited to 
''   warranties of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "uuid"

extern "C"

#define __CGUID_H__
extern GUID_NULL as const IID
extern IID_NULL alias "GUID_NULL" as const IID
extern CLSID_NULL alias "GUID_NULL" as const IID
extern FMTID_NULL alias "GUID_NULL" as const IID
extern CATID_MARSHALER as const IID
extern IID_IRpcChannel as const IID
extern IID_IRpcStub as const IID
extern IID_IStubManager as const IID
extern IID_IRpcProxy as const IID
extern IID_IProxyManager as const IID
extern IID_IPSFactory as const IID
extern IID_IInternalMoniker as const IID
extern IID_IDfReserved1 as const IID
extern IID_IDfReserved2 as const IID
extern IID_IDfReserved3 as const IID
extern CLSID_StdMarshal as const CLSID
extern CLSID_AggStdMarshal as const CLSID
extern CLSID_StdAsyncActManager as const CLSID
extern IID_IStub as const IID
extern IID_IProxy as const IID
extern IID_IEnumGeneric as const IID
extern IID_IEnumHolder as const IID
extern IID_IEnumCallback as const IID
extern IID_IOleManager as const IID
extern IID_IOlePresObj as const IID
extern IID_IDebug as const IID
extern IID_IDebugStream as const IID
extern CLSID_PSGenObject as const CLSID
extern CLSID_PSClientSite as const CLSID
extern CLSID_PSClassObject as const CLSID
extern CLSID_PSInPlaceActive as const CLSID
extern CLSID_PSInPlaceFrame as const CLSID
extern CLSID_PSDragDrop as const CLSID
extern CLSID_PSBindCtx as const CLSID
extern CLSID_PSEnumerators as const CLSID
extern CLSID_StaticMetafile as const CLSID
extern CLSID_StaticDib as const CLSID
extern CID_CDfsVolume as const CLSID
extern CLSID_DCOMAccessControl as const CLSID
extern CLSID_StdGlobalInterfaceTable as const CLSID
extern CLSID_ComBinding as const CLSID
extern CLSID_StdEvent as const CLSID
extern CLSID_ManualResetEvent as const CLSID
extern CLSID_SynchronizeContainer as const CLSID
extern CLSID_AddrControl as const CLSID
extern CLSID_CCDFormKrnl as const CLSID
extern CLSID_CCDPropertyPage as const CLSID
extern CLSID_CCDFormDialog as const CLSID
extern CLSID_CCDCommandButton as const CLSID
extern CLSID_CCDComboBox as const CLSID
extern CLSID_CCDTextBox as const CLSID
extern CLSID_CCDCheckBox as const CLSID
extern CLSID_CCDLabel as const CLSID
extern CLSID_CCDOptionButton as const CLSID
extern CLSID_CCDListBox as const CLSID
extern CLSID_CCDScrollBar as const CLSID
extern CLSID_CCDGroupBox as const CLSID
extern CLSID_CCDGeneralPropertyPage as const CLSID
extern CLSID_CCDGenericPropertyPage as const CLSID
extern CLSID_CCDFontPropertyPage as const CLSID
extern CLSID_CCDColorPropertyPage as const CLSID
extern CLSID_CCDLabelPropertyPage as const CLSID
extern CLSID_CCDCheckBoxPropertyPage as const CLSID
extern CLSID_CCDTextBoxPropertyPage as const CLSID
extern CLSID_CCDOptionButtonPropertyPage as const CLSID
extern CLSID_CCDListBoxPropertyPage as const CLSID
extern CLSID_CCDCommandButtonPropertyPage as const CLSID
extern CLSID_CCDComboBoxPropertyPage as const CLSID
extern CLSID_CCDScrollBarPropertyPage as const CLSID
extern CLSID_CCDGroupBoxPropertyPage as const CLSID
extern CLSID_CCDXObjectPropertyPage as const CLSID
extern CLSID_CStdPropertyFrame as const CLSID
extern CLSID_CFormPropertyPage as const CLSID
extern CLSID_CGridPropertyPage as const CLSID
extern CLSID_CWSJArticlePage as const CLSID
extern CLSID_CSystemPage as const CLSID
extern CLSID_IdentityUnmarshal as const CLSID
extern CLSID_InProcFreeMarshaler as const CLSID
extern CLSID_Picture_Metafile as const CLSID
extern CLSID_Picture_EnhMetafile as const CLSID
extern CLSID_Picture_Dib as const CLSID
extern GUID_TRISTATE as const GUID

end extern
