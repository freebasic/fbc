'' FreeBASIC binding for mingw-w64-v3.3.0

#pragma once

#include once "_mingw_unicode.bi"

extern "Windows"

#define __RPCNSI_H__
type RPC_NS_HANDLE as any ptr
const RPC_C_NS_SYNTAX_DEFAULT = 0
const RPC_C_NS_SYNTAX_DCE = 3
const RPC_C_PROFILE_DEFAULT_ELT = 0
const RPC_C_PROFILE_ALL_ELT = 1
#define RPC_C_PROFILE_ALL_ELTS RPC_C_PROFILE_ALL_ELT
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
	#define RpcNsBindingLookupBegin RpcNsBindingLookupBeginW
	#define RpcNsBindingImportBegin RpcNsBindingImportBeginW
	#define RpcNsBindingExport RpcNsBindingExportW
	#define RpcNsBindingUnexport RpcNsBindingUnexportW
	#define RpcNsGroupDelete RpcNsGroupDeleteW
	#define RpcNsGroupMbrAdd RpcNsGroupMbrAddW
	#define RpcNsGroupMbrRemove RpcNsGroupMbrRemoveW
	#define RpcNsGroupMbrInqBegin RpcNsGroupMbrInqBeginW
	#define RpcNsGroupMbrInqNext RpcNsGroupMbrInqNextW
	#define RpcNsEntryExpandName RpcNsEntryExpandNameW
	#define RpcNsEntryObjectInqBegin RpcNsEntryObjectInqBeginW
	#define RpcNsMgmtBindingUnexport RpcNsMgmtBindingUnexportW
	#define RpcNsMgmtEntryCreate RpcNsMgmtEntryCreateW
	#define RpcNsMgmtEntryDelete RpcNsMgmtEntryDeleteW
	#define RpcNsMgmtEntryInqIfIds RpcNsMgmtEntryInqIfIdsW
	#define RpcNsProfileDelete RpcNsProfileDeleteW
	#define RpcNsProfileEltAdd RpcNsProfileEltAddW
	#define RpcNsProfileEltRemove RpcNsProfileEltRemoveW
	#define RpcNsProfileEltInqBegin RpcNsProfileEltInqBeginW
	#define RpcNsProfileEltInqNext RpcNsProfileEltInqNextW
	#define RpcNsBindingExportPnP RpcNsBindingExportPnPW
	#define RpcNsBindingUnexportPnP RpcNsBindingUnexportPnPW
#else
	#define RpcNsBindingLookupBegin RpcNsBindingLookupBeginA
	#define RpcNsBindingImportBegin RpcNsBindingImportBeginA
	#define RpcNsBindingExport RpcNsBindingExportA
	#define RpcNsBindingUnexport RpcNsBindingUnexportA
	#define RpcNsGroupDelete RpcNsGroupDeleteA
	#define RpcNsGroupMbrAdd RpcNsGroupMbrAddA
	#define RpcNsGroupMbrRemove RpcNsGroupMbrRemoveA
	#define RpcNsGroupMbrInqBegin RpcNsGroupMbrInqBeginA
	#define RpcNsGroupMbrInqNext RpcNsGroupMbrInqNextA
	#define RpcNsEntryExpandName RpcNsEntryExpandNameA
	#define RpcNsEntryObjectInqBegin RpcNsEntryObjectInqBeginA
	#define RpcNsMgmtBindingUnexport RpcNsMgmtBindingUnexportA
	#define RpcNsMgmtEntryCreate RpcNsMgmtEntryCreateA
	#define RpcNsMgmtEntryDelete RpcNsMgmtEntryDeleteA
	#define RpcNsMgmtEntryInqIfIds RpcNsMgmtEntryInqIfIdsA
	#define RpcNsProfileDelete RpcNsProfileDeleteA
	#define RpcNsProfileEltAdd RpcNsProfileEltAddA
	#define RpcNsProfileEltRemove RpcNsProfileEltRemoveA
	#define RpcNsProfileEltInqBegin RpcNsProfileEltInqBeginA
	#define RpcNsProfileEltInqNext RpcNsProfileEltInqNextA
	#define RpcNsBindingExportPnP RpcNsBindingExportPnPA
	#define RpcNsBindingUnexportPnP RpcNsBindingUnexportPnPA
#endif

end extern
