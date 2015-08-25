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

#include once "_mingw_unicode.bi"

extern "Windows"

#define __RPCNSI_H__
type RPC_NS_HANDLE as any ptr
const RPC_C_NS_SYNTAX_DEFAULT = 0
const RPC_C_NS_SYNTAX_DCE = 3
const RPC_C_PROFILE_DEFAULT_ELT = 0
const RPC_C_PROFILE_ALL_ELT = 1
const RPC_C_PROFILE_ALL_ELTS = RPC_C_PROFILE_ALL_ELT
const RPC_C_PROFILE_MATCH_BY_IF = 2
const RPC_C_PROFILE_MATCH_BY_MBR = 3
const RPC_C_PROFILE_MATCH_BY_BOTH = 4
const RPC_C_NS_DEFAULT_EXP_AGE = -1

declare function RpcNsBindingExportA(byval EntryNameSyntax as ulong, byval EntryName as RPC_CSTR, byval IfSpec as RPC_IF_HANDLE, byval BindingVec as RPC_BINDING_VECTOR ptr, byval ObjectUuidVec as UUID_VECTOR ptr) as RPC_STATUS
declare function RpcNsBindingUnexportA(byval EntryNameSyntax as ulong, byval EntryName as RPC_CSTR, byval IfSpec as RPC_IF_HANDLE, byval ObjectUuidVec as UUID_VECTOR ptr) as RPC_STATUS
declare function RpcNsBindingExportW(byval EntryNameSyntax as ulong, byval EntryName as RPC_WSTR, byval IfSpec as RPC_IF_HANDLE, byval BindingVec as RPC_BINDING_VECTOR ptr, byval ObjectUuidVec as UUID_VECTOR ptr) as RPC_STATUS
declare function RpcNsBindingUnexportW(byval EntryNameSyntax as ulong, byval EntryName as RPC_WSTR, byval IfSpec as RPC_IF_HANDLE, byval ObjectUuidVec as UUID_VECTOR ptr) as RPC_STATUS
declare function RpcNsBindingExportPnPA(byval EntryNameSyntax as ulong, byval EntryName as RPC_CSTR, byval IfSpec as RPC_IF_HANDLE, byval ObjectVector as UUID_VECTOR ptr) as RPC_STATUS
declare function RpcNsBindingUnexportPnPA(byval EntryNameSyntax as ulong, byval EntryName as RPC_CSTR, byval IfSpec as RPC_IF_HANDLE, byval ObjectVector as UUID_VECTOR ptr) as RPC_STATUS
declare function RpcNsBindingExportPnPW(byval EntryNameSyntax as ulong, byval EntryName as RPC_WSTR, byval IfSpec as RPC_IF_HANDLE, byval ObjectVector as UUID_VECTOR ptr) as RPC_STATUS
declare function RpcNsBindingUnexportPnPW(byval EntryNameSyntax as ulong, byval EntryName as RPC_WSTR, byval IfSpec as RPC_IF_HANDLE, byval ObjectVector as UUID_VECTOR ptr) as RPC_STATUS
declare function RpcNsBindingLookupBeginA(byval EntryNameSyntax as ulong, byval EntryName as RPC_CSTR, byval IfSpec as RPC_IF_HANDLE, byval ObjUuid as UUID ptr, byval BindingMaxCount as ulong, byval LookupContext as RPC_NS_HANDLE ptr) as RPC_STATUS
declare function RpcNsBindingLookupBeginW(byval EntryNameSyntax as ulong, byval EntryName as RPC_WSTR, byval IfSpec as RPC_IF_HANDLE, byval ObjUuid as UUID ptr, byval BindingMaxCount as ulong, byval LookupContext as RPC_NS_HANDLE ptr) as RPC_STATUS
declare function RpcNsBindingLookupNext(byval LookupContext as RPC_NS_HANDLE, byval BindingVec as RPC_BINDING_VECTOR ptr ptr) as RPC_STATUS
declare function RpcNsBindingLookupDone(byval LookupContext as RPC_NS_HANDLE ptr) as RPC_STATUS
declare function RpcNsGroupDeleteA(byval GroupNameSyntax as ulong, byval GroupName as RPC_CSTR) as RPC_STATUS
declare function RpcNsGroupMbrAddA(byval GroupNameSyntax as ulong, byval GroupName as RPC_CSTR, byval MemberNameSyntax as ulong, byval MemberName as RPC_CSTR) as RPC_STATUS
declare function RpcNsGroupMbrRemoveA(byval GroupNameSyntax as ulong, byval GroupName as RPC_CSTR, byval MemberNameSyntax as ulong, byval MemberName as RPC_CSTR) as RPC_STATUS
declare function RpcNsGroupMbrInqBeginA(byval GroupNameSyntax as ulong, byval GroupName as RPC_CSTR, byval MemberNameSyntax as ulong, byval InquiryContext as RPC_NS_HANDLE ptr) as RPC_STATUS
declare function RpcNsGroupMbrInqNextA(byval InquiryContext as RPC_NS_HANDLE, byval MemberName as RPC_CSTR ptr) as RPC_STATUS
declare function RpcNsGroupDeleteW(byval GroupNameSyntax as ulong, byval GroupName as RPC_WSTR) as RPC_STATUS
declare function RpcNsGroupMbrAddW(byval GroupNameSyntax as ulong, byval GroupName as RPC_WSTR, byval MemberNameSyntax as ulong, byval MemberName as RPC_WSTR) as RPC_STATUS
declare function RpcNsGroupMbrRemoveW(byval GroupNameSyntax as ulong, byval GroupName as RPC_WSTR, byval MemberNameSyntax as ulong, byval MemberName as RPC_WSTR) as RPC_STATUS
declare function RpcNsGroupMbrInqBeginW(byval GroupNameSyntax as ulong, byval GroupName as RPC_WSTR, byval MemberNameSyntax as ulong, byval InquiryContext as RPC_NS_HANDLE ptr) as RPC_STATUS
declare function RpcNsGroupMbrInqNextW(byval InquiryContext as RPC_NS_HANDLE, byval MemberName as RPC_WSTR ptr) as RPC_STATUS
declare function RpcNsGroupMbrInqDone(byval InquiryContext as RPC_NS_HANDLE ptr) as RPC_STATUS
declare function RpcNsProfileDeleteA(byval ProfileNameSyntax as ulong, byval ProfileName as RPC_CSTR) as RPC_STATUS
declare function RpcNsProfileEltAddA(byval ProfileNameSyntax as ulong, byval ProfileName as RPC_CSTR, byval IfId as RPC_IF_ID ptr, byval MemberNameSyntax as ulong, byval MemberName as RPC_CSTR, byval Priority as ulong, byval Annotation as RPC_CSTR) as RPC_STATUS
declare function RpcNsProfileEltRemoveA(byval ProfileNameSyntax as ulong, byval ProfileName as RPC_CSTR, byval IfId as RPC_IF_ID ptr, byval MemberNameSyntax as ulong, byval MemberName as RPC_CSTR) as RPC_STATUS
declare function RpcNsProfileEltInqBeginA(byval ProfileNameSyntax as ulong, byval ProfileName as RPC_CSTR, byval InquiryType as ulong, byval IfId as RPC_IF_ID ptr, byval VersOption as ulong, byval MemberNameSyntax as ulong, byval MemberName as RPC_CSTR, byval InquiryContext as RPC_NS_HANDLE ptr) as RPC_STATUS
declare function RpcNsProfileEltInqNextA(byval InquiryContext as RPC_NS_HANDLE, byval IfId as RPC_IF_ID ptr, byval MemberName as RPC_CSTR ptr, byval Priority as ulong ptr, byval Annotation as RPC_CSTR ptr) as RPC_STATUS
declare function RpcNsProfileDeleteW(byval ProfileNameSyntax as ulong, byval ProfileName as RPC_WSTR) as RPC_STATUS
declare function RpcNsProfileEltAddW(byval ProfileNameSyntax as ulong, byval ProfileName as RPC_WSTR, byval IfId as RPC_IF_ID ptr, byval MemberNameSyntax as ulong, byval MemberName as RPC_WSTR, byval Priority as ulong, byval Annotation as RPC_WSTR) as RPC_STATUS
declare function RpcNsProfileEltRemoveW(byval ProfileNameSyntax as ulong, byval ProfileName as RPC_WSTR, byval IfId as RPC_IF_ID ptr, byval MemberNameSyntax as ulong, byval MemberName as RPC_WSTR) as RPC_STATUS
declare function RpcNsProfileEltInqBeginW(byval ProfileNameSyntax as ulong, byval ProfileName as RPC_WSTR, byval InquiryType as ulong, byval IfId as RPC_IF_ID ptr, byval VersOption as ulong, byval MemberNameSyntax as ulong, byval MemberName as RPC_WSTR, byval InquiryContext as RPC_NS_HANDLE ptr) as RPC_STATUS
declare function RpcNsProfileEltInqNextW(byval InquiryContext as RPC_NS_HANDLE, byval IfId as RPC_IF_ID ptr, byval MemberName as RPC_WSTR ptr, byval Priority as ulong ptr, byval Annotation as RPC_WSTR ptr) as RPC_STATUS
declare function RpcNsProfileEltInqDone(byval InquiryContext as RPC_NS_HANDLE ptr) as RPC_STATUS
declare function RpcNsEntryObjectInqBeginA(byval EntryNameSyntax as ulong, byval EntryName as RPC_CSTR, byval InquiryContext as RPC_NS_HANDLE ptr) as RPC_STATUS
declare function RpcNsEntryObjectInqBeginW(byval EntryNameSyntax as ulong, byval EntryName as RPC_WSTR, byval InquiryContext as RPC_NS_HANDLE ptr) as RPC_STATUS
declare function RpcNsEntryObjectInqNext(byval InquiryContext as RPC_NS_HANDLE, byval ObjUuid as UUID ptr) as RPC_STATUS
declare function RpcNsEntryObjectInqDone(byval InquiryContext as RPC_NS_HANDLE ptr) as RPC_STATUS
declare function RpcNsEntryExpandNameA(byval EntryNameSyntax as ulong, byval EntryName as RPC_CSTR, byval ExpandedName as RPC_CSTR ptr) as RPC_STATUS
declare function RpcNsMgmtBindingUnexportA(byval EntryNameSyntax as ulong, byval EntryName as RPC_CSTR, byval IfId as RPC_IF_ID ptr, byval VersOption as ulong, byval ObjectUuidVec as UUID_VECTOR ptr) as RPC_STATUS
declare function RpcNsMgmtEntryCreateA(byval EntryNameSyntax as ulong, byval EntryName as RPC_CSTR) as RPC_STATUS
declare function RpcNsMgmtEntryDeleteA(byval EntryNameSyntax as ulong, byval EntryName as RPC_CSTR) as RPC_STATUS
declare function RpcNsMgmtEntryInqIfIdsA(byval EntryNameSyntax as ulong, byval EntryName as RPC_CSTR, byval IfIdVec as RPC_IF_ID_VECTOR ptr ptr) as RPC_STATUS
declare function RpcNsMgmtHandleSetExpAge(byval NsHandle as RPC_NS_HANDLE, byval ExpirationAge as ulong) as RPC_STATUS
declare function RpcNsMgmtInqExpAge(byval ExpirationAge as ulong ptr) as RPC_STATUS
declare function RpcNsMgmtSetExpAge(byval ExpirationAge as ulong) as RPC_STATUS
declare function RpcNsEntryExpandNameW(byval EntryNameSyntax as ulong, byval EntryName as RPC_WSTR, byval ExpandedName as RPC_WSTR ptr) as RPC_STATUS
declare function RpcNsMgmtBindingUnexportW(byval EntryNameSyntax as ulong, byval EntryName as RPC_WSTR, byval IfId as RPC_IF_ID ptr, byval VersOption as ulong, byval ObjectUuidVec as UUID_VECTOR ptr) as RPC_STATUS
declare function RpcNsMgmtEntryCreateW(byval EntryNameSyntax as ulong, byval EntryName as RPC_WSTR) as RPC_STATUS
declare function RpcNsMgmtEntryDeleteW(byval EntryNameSyntax as ulong, byval EntryName as RPC_WSTR) as RPC_STATUS
declare function RpcNsMgmtEntryInqIfIdsW(byval EntryNameSyntax as ulong, byval EntryName as RPC_WSTR, byval IfIdVec as RPC_IF_ID_VECTOR ptr ptr) as RPC_STATUS
declare function RpcNsBindingImportBeginA(byval EntryNameSyntax as ulong, byval EntryName as RPC_CSTR, byval IfSpec as RPC_IF_HANDLE, byval ObjUuid as UUID ptr, byval ImportContext as RPC_NS_HANDLE ptr) as RPC_STATUS
declare function RpcNsBindingImportBeginW(byval EntryNameSyntax as ulong, byval EntryName as RPC_WSTR, byval IfSpec as RPC_IF_HANDLE, byval ObjUuid as UUID ptr, byval ImportContext as RPC_NS_HANDLE ptr) as RPC_STATUS
declare function RpcNsBindingImportNext(byval ImportContext as RPC_NS_HANDLE, byval Binding as RPC_BINDING_HANDLE ptr) as RPC_STATUS
declare function RpcNsBindingImportDone(byval ImportContext as RPC_NS_HANDLE ptr) as RPC_STATUS
declare function RpcNsBindingSelect(byval BindingVec as RPC_BINDING_VECTOR ptr, byval Binding as RPC_BINDING_HANDLE ptr) as RPC_STATUS

#ifdef UNICODE
	declare function RpcNsBindingLookupBegin alias "RpcNsBindingLookupBeginW"(byval EntryNameSyntax as ulong, byval EntryName as RPC_WSTR, byval IfSpec as RPC_IF_HANDLE, byval ObjUuid as UUID ptr, byval BindingMaxCount as ulong, byval LookupContext as RPC_NS_HANDLE ptr) as RPC_STATUS
	declare function RpcNsBindingImportBegin alias "RpcNsBindingImportBeginW"(byval EntryNameSyntax as ulong, byval EntryName as RPC_WSTR, byval IfSpec as RPC_IF_HANDLE, byval ObjUuid as UUID ptr, byval ImportContext as RPC_NS_HANDLE ptr) as RPC_STATUS
	declare function RpcNsBindingExport alias "RpcNsBindingExportW"(byval EntryNameSyntax as ulong, byval EntryName as RPC_WSTR, byval IfSpec as RPC_IF_HANDLE, byval BindingVec as RPC_BINDING_VECTOR ptr, byval ObjectUuidVec as UUID_VECTOR ptr) as RPC_STATUS
	declare function RpcNsBindingUnexport alias "RpcNsBindingUnexportW"(byval EntryNameSyntax as ulong, byval EntryName as RPC_WSTR, byval IfSpec as RPC_IF_HANDLE, byval ObjectUuidVec as UUID_VECTOR ptr) as RPC_STATUS
	declare function RpcNsGroupDelete alias "RpcNsGroupDeleteW"(byval GroupNameSyntax as ulong, byval GroupName as RPC_WSTR) as RPC_STATUS
	declare function RpcNsGroupMbrAdd alias "RpcNsGroupMbrAddW"(byval GroupNameSyntax as ulong, byval GroupName as RPC_WSTR, byval MemberNameSyntax as ulong, byval MemberName as RPC_WSTR) as RPC_STATUS
	declare function RpcNsGroupMbrRemove alias "RpcNsGroupMbrRemoveW"(byval GroupNameSyntax as ulong, byval GroupName as RPC_WSTR, byval MemberNameSyntax as ulong, byval MemberName as RPC_WSTR) as RPC_STATUS
	declare function RpcNsGroupMbrInqBegin alias "RpcNsGroupMbrInqBeginW"(byval GroupNameSyntax as ulong, byval GroupName as RPC_WSTR, byval MemberNameSyntax as ulong, byval InquiryContext as RPC_NS_HANDLE ptr) as RPC_STATUS
	declare function RpcNsGroupMbrInqNext alias "RpcNsGroupMbrInqNextW"(byval InquiryContext as RPC_NS_HANDLE, byval MemberName as RPC_WSTR ptr) as RPC_STATUS
	declare function RpcNsEntryExpandName alias "RpcNsEntryExpandNameW"(byval EntryNameSyntax as ulong, byval EntryName as RPC_WSTR, byval ExpandedName as RPC_WSTR ptr) as RPC_STATUS
	declare function RpcNsEntryObjectInqBegin alias "RpcNsEntryObjectInqBeginW"(byval EntryNameSyntax as ulong, byval EntryName as RPC_WSTR, byval InquiryContext as RPC_NS_HANDLE ptr) as RPC_STATUS
	declare function RpcNsMgmtBindingUnexport alias "RpcNsMgmtBindingUnexportW"(byval EntryNameSyntax as ulong, byval EntryName as RPC_WSTR, byval IfId as RPC_IF_ID ptr, byval VersOption as ulong, byval ObjectUuidVec as UUID_VECTOR ptr) as RPC_STATUS
	declare function RpcNsMgmtEntryCreate alias "RpcNsMgmtEntryCreateW"(byval EntryNameSyntax as ulong, byval EntryName as RPC_WSTR) as RPC_STATUS
	declare function RpcNsMgmtEntryDelete alias "RpcNsMgmtEntryDeleteW"(byval EntryNameSyntax as ulong, byval EntryName as RPC_WSTR) as RPC_STATUS
	declare function RpcNsMgmtEntryInqIfIds alias "RpcNsMgmtEntryInqIfIdsW"(byval EntryNameSyntax as ulong, byval EntryName as RPC_WSTR, byval IfIdVec as RPC_IF_ID_VECTOR ptr ptr) as RPC_STATUS
	declare function RpcNsProfileDelete alias "RpcNsProfileDeleteW"(byval ProfileNameSyntax as ulong, byval ProfileName as RPC_WSTR) as RPC_STATUS
	declare function RpcNsProfileEltAdd alias "RpcNsProfileEltAddW"(byval ProfileNameSyntax as ulong, byval ProfileName as RPC_WSTR, byval IfId as RPC_IF_ID ptr, byval MemberNameSyntax as ulong, byval MemberName as RPC_WSTR, byval Priority as ulong, byval Annotation as RPC_WSTR) as RPC_STATUS
	declare function RpcNsProfileEltRemove alias "RpcNsProfileEltRemoveW"(byval ProfileNameSyntax as ulong, byval ProfileName as RPC_WSTR, byval IfId as RPC_IF_ID ptr, byval MemberNameSyntax as ulong, byval MemberName as RPC_WSTR) as RPC_STATUS
	declare function RpcNsProfileEltInqBegin alias "RpcNsProfileEltInqBeginW"(byval ProfileNameSyntax as ulong, byval ProfileName as RPC_WSTR, byval InquiryType as ulong, byval IfId as RPC_IF_ID ptr, byval VersOption as ulong, byval MemberNameSyntax as ulong, byval MemberName as RPC_WSTR, byval InquiryContext as RPC_NS_HANDLE ptr) as RPC_STATUS
	declare function RpcNsProfileEltInqNext alias "RpcNsProfileEltInqNextW"(byval InquiryContext as RPC_NS_HANDLE, byval IfId as RPC_IF_ID ptr, byval MemberName as RPC_WSTR ptr, byval Priority as ulong ptr, byval Annotation as RPC_WSTR ptr) as RPC_STATUS
	declare function RpcNsBindingExportPnP alias "RpcNsBindingExportPnPW"(byval EntryNameSyntax as ulong, byval EntryName as RPC_WSTR, byval IfSpec as RPC_IF_HANDLE, byval ObjectVector as UUID_VECTOR ptr) as RPC_STATUS
	declare function RpcNsBindingUnexportPnP alias "RpcNsBindingUnexportPnPW"(byval EntryNameSyntax as ulong, byval EntryName as RPC_WSTR, byval IfSpec as RPC_IF_HANDLE, byval ObjectVector as UUID_VECTOR ptr) as RPC_STATUS
#else
	declare function RpcNsBindingLookupBegin alias "RpcNsBindingLookupBeginA"(byval EntryNameSyntax as ulong, byval EntryName as RPC_CSTR, byval IfSpec as RPC_IF_HANDLE, byval ObjUuid as UUID ptr, byval BindingMaxCount as ulong, byval LookupContext as RPC_NS_HANDLE ptr) as RPC_STATUS
	declare function RpcNsBindingImportBegin alias "RpcNsBindingImportBeginA"(byval EntryNameSyntax as ulong, byval EntryName as RPC_CSTR, byval IfSpec as RPC_IF_HANDLE, byval ObjUuid as UUID ptr, byval ImportContext as RPC_NS_HANDLE ptr) as RPC_STATUS
	declare function RpcNsBindingExport alias "RpcNsBindingExportA"(byval EntryNameSyntax as ulong, byval EntryName as RPC_CSTR, byval IfSpec as RPC_IF_HANDLE, byval BindingVec as RPC_BINDING_VECTOR ptr, byval ObjectUuidVec as UUID_VECTOR ptr) as RPC_STATUS
	declare function RpcNsBindingUnexport alias "RpcNsBindingUnexportA"(byval EntryNameSyntax as ulong, byval EntryName as RPC_CSTR, byval IfSpec as RPC_IF_HANDLE, byval ObjectUuidVec as UUID_VECTOR ptr) as RPC_STATUS
	declare function RpcNsGroupDelete alias "RpcNsGroupDeleteA"(byval GroupNameSyntax as ulong, byval GroupName as RPC_CSTR) as RPC_STATUS
	declare function RpcNsGroupMbrAdd alias "RpcNsGroupMbrAddA"(byval GroupNameSyntax as ulong, byval GroupName as RPC_CSTR, byval MemberNameSyntax as ulong, byval MemberName as RPC_CSTR) as RPC_STATUS
	declare function RpcNsGroupMbrRemove alias "RpcNsGroupMbrRemoveA"(byval GroupNameSyntax as ulong, byval GroupName as RPC_CSTR, byval MemberNameSyntax as ulong, byval MemberName as RPC_CSTR) as RPC_STATUS
	declare function RpcNsGroupMbrInqBegin alias "RpcNsGroupMbrInqBeginA"(byval GroupNameSyntax as ulong, byval GroupName as RPC_CSTR, byval MemberNameSyntax as ulong, byval InquiryContext as RPC_NS_HANDLE ptr) as RPC_STATUS
	declare function RpcNsGroupMbrInqNext alias "RpcNsGroupMbrInqNextA"(byval InquiryContext as RPC_NS_HANDLE, byval MemberName as RPC_CSTR ptr) as RPC_STATUS
	declare function RpcNsEntryExpandName alias "RpcNsEntryExpandNameA"(byval EntryNameSyntax as ulong, byval EntryName as RPC_CSTR, byval ExpandedName as RPC_CSTR ptr) as RPC_STATUS
	declare function RpcNsEntryObjectInqBegin alias "RpcNsEntryObjectInqBeginA"(byval EntryNameSyntax as ulong, byval EntryName as RPC_CSTR, byval InquiryContext as RPC_NS_HANDLE ptr) as RPC_STATUS
	declare function RpcNsMgmtBindingUnexport alias "RpcNsMgmtBindingUnexportA"(byval EntryNameSyntax as ulong, byval EntryName as RPC_CSTR, byval IfId as RPC_IF_ID ptr, byval VersOption as ulong, byval ObjectUuidVec as UUID_VECTOR ptr) as RPC_STATUS
	declare function RpcNsMgmtEntryCreate alias "RpcNsMgmtEntryCreateA"(byval EntryNameSyntax as ulong, byval EntryName as RPC_CSTR) as RPC_STATUS
	declare function RpcNsMgmtEntryDelete alias "RpcNsMgmtEntryDeleteA"(byval EntryNameSyntax as ulong, byval EntryName as RPC_CSTR) as RPC_STATUS
	declare function RpcNsMgmtEntryInqIfIds alias "RpcNsMgmtEntryInqIfIdsA"(byval EntryNameSyntax as ulong, byval EntryName as RPC_CSTR, byval IfIdVec as RPC_IF_ID_VECTOR ptr ptr) as RPC_STATUS
	declare function RpcNsProfileDelete alias "RpcNsProfileDeleteA"(byval ProfileNameSyntax as ulong, byval ProfileName as RPC_CSTR) as RPC_STATUS
	declare function RpcNsProfileEltAdd alias "RpcNsProfileEltAddA"(byval ProfileNameSyntax as ulong, byval ProfileName as RPC_CSTR, byval IfId as RPC_IF_ID ptr, byval MemberNameSyntax as ulong, byval MemberName as RPC_CSTR, byval Priority as ulong, byval Annotation as RPC_CSTR) as RPC_STATUS
	declare function RpcNsProfileEltRemove alias "RpcNsProfileEltRemoveA"(byval ProfileNameSyntax as ulong, byval ProfileName as RPC_CSTR, byval IfId as RPC_IF_ID ptr, byval MemberNameSyntax as ulong, byval MemberName as RPC_CSTR) as RPC_STATUS
	declare function RpcNsProfileEltInqBegin alias "RpcNsProfileEltInqBeginA"(byval ProfileNameSyntax as ulong, byval ProfileName as RPC_CSTR, byval InquiryType as ulong, byval IfId as RPC_IF_ID ptr, byval VersOption as ulong, byval MemberNameSyntax as ulong, byval MemberName as RPC_CSTR, byval InquiryContext as RPC_NS_HANDLE ptr) as RPC_STATUS
	declare function RpcNsProfileEltInqNext alias "RpcNsProfileEltInqNextA"(byval InquiryContext as RPC_NS_HANDLE, byval IfId as RPC_IF_ID ptr, byval MemberName as RPC_CSTR ptr, byval Priority as ulong ptr, byval Annotation as RPC_CSTR ptr) as RPC_STATUS
	declare function RpcNsBindingExportPnP alias "RpcNsBindingExportPnPA"(byval EntryNameSyntax as ulong, byval EntryName as RPC_CSTR, byval IfSpec as RPC_IF_HANDLE, byval ObjectVector as UUID_VECTOR ptr) as RPC_STATUS
	declare function RpcNsBindingUnexportPnP alias "RpcNsBindingUnexportPnPA"(byval EntryNameSyntax as ulong, byval EntryName as RPC_CSTR, byval IfSpec as RPC_IF_HANDLE, byval ObjectVector as UUID_VECTOR ptr) as RPC_STATUS
#endif

end extern
