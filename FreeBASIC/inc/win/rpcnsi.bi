''
''
'' rpcnsi -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_rpcnsi_bi__
#define __win_rpcnsi_bi__

type RPC_NS_HANDLE as any ptr

#define RPC_C_NS_SYNTAX_DEFAULT 0
#define RPC_C_NS_SYNTAX_DCE 3
#define RPC_C_PROFILE_DEFAULT_ELT 0
#define RPC_C_PROFILE_ALL_ELT 1
#define RPC_C_PROFILE_MATCH_BY_IF 2
#define RPC_C_PROFILE_MATCH_BY_MBR 3
#define RPC_C_PROFILE_MATCH_BY_BOTH 4
#define RPC_C_NS_DEFAULT_EXP_AGE -1

declare function RpcNsBindingLookupNext alias "RpcNsBindingLookupNext" (byval as RPC_NS_HANDLE, byval as RPC_BINDING_VECTOR ptr ptr) as RPC_STATUS
declare function RpcNsBindingLookupDone alias "RpcNsBindingLookupDone" (byval as RPC_NS_HANDLE ptr) as RPC_STATUS
declare function RpcNsGroupMbrInqDone alias "RpcNsGroupMbrInqDone" (byval as RPC_NS_HANDLE ptr) as RPC_STATUS
declare function RpcNsProfileEltInqDone alias "RpcNsProfileEltInqDone" (byval as RPC_NS_HANDLE ptr) as RPC_STATUS
declare function RpcNsEntryObjectInqNext alias "RpcNsEntryObjectInqNext" (byval as RPC_NS_HANDLE, byval as UUID ptr) as RPC_STATUS
declare function RpcNsEntryObjectInqDone alias "RpcNsEntryObjectInqDone" (byval as RPC_NS_HANDLE ptr) as RPC_STATUS
declare function RpcNsMgmtHandleSetExpAge alias "RpcNsMgmtHandleSetExpAge" (byval as RPC_NS_HANDLE, byval as uinteger) as RPC_STATUS
declare function RpcNsMgmtInqExpAge alias "RpcNsMgmtInqExpAge" (byval as uinteger ptr) as RPC_STATUS
declare function RpcNsMgmtSetExpAge alias "RpcNsMgmtSetExpAge" (byval as uinteger) as RPC_STATUS
declare function RpcNsBindingImportNext alias "RpcNsBindingImportNext" (byval as RPC_NS_HANDLE, byval as RPC_BINDING_HANDLE ptr) as RPC_STATUS
declare function RpcNsBindingImportDone alias "RpcNsBindingImportDone" (byval as RPC_NS_HANDLE ptr) as RPC_STATUS
declare function RpcNsBindingSelect alias "RpcNsBindingSelect" (byval as RPC_BINDING_VECTOR ptr, byval as RPC_BINDING_HANDLE ptr) as RPC_STATUS

#ifdef UNICODE
declare function RpcNsBindingExport alias "RpcNsBindingExportW" (byval as uinteger, byval as ushort ptr, byval as RPC_IF_HANDLE, byval as RPC_BINDING_VECTOR ptr, byval as UUID_VECTOR ptr) as RPC_STATUS
declare function RpcNsBindingUnexport alias "RpcNsBindingUnexportW" (byval as uinteger, byval as ushort ptr, byval as RPC_IF_HANDLE, byval as UUID_VECTOR ptr) as RPC_STATUS
declare function RpcNsBindingLookupBegin alias "RpcNsBindingLookupBeginW" (byval as uinteger, byval as ushort ptr, byval as RPC_IF_HANDLE, byval as UUID ptr, byval as uinteger, byval as RPC_NS_HANDLE ptr) as RPC_STATUS
declare function RpcNsGroupDelete alias "RpcNsGroupDeleteW" (byval as uinteger, byval as ushort ptr) as RPC_STATUS
declare function RpcNsGroupMbrAdd alias "RpcNsGroupMbrAddW" (byval as uinteger, byval as ushort ptr, byval as uinteger, byval as ushort ptr) as RPC_STATUS
declare function RpcNsGroupMbrRemove alias "RpcNsGroupMbrRemoveW" (byval as uinteger, byval as ushort ptr, byval as uinteger, byval as ushort ptr) as RPC_STATUS
declare function RpcNsGroupMbrInqBegin alias "RpcNsGroupMbrInqBeginW" (byval as uinteger, byval as ushort ptr, byval as uinteger, byval as RPC_NS_HANDLE ptr) as RPC_STATUS
declare function RpcNsGroupMbrInqNext alias "RpcNsGroupMbrInqNextW" (byval as RPC_NS_HANDLE, byval as ushort ptr ptr) as RPC_STATUS
declare function RpcNsProfileDelete alias "RpcNsProfileDeleteW" (byval as uinteger, byval as ushort ptr) as RPC_STATUS
declare function RpcNsProfileEltAdd alias "RpcNsProfileEltAddW" (byval as uinteger, byval as ushort ptr, byval as RPC_IF_ID ptr, byval as uinteger, byval as ushort ptr, byval as uinteger, byval as ushort ptr) as RPC_STATUS
declare function RpcNsProfileEltRemove alias "RpcNsProfileEltRemoveW" (byval as uinteger, byval as ushort ptr, byval as RPC_IF_ID ptr, byval as uinteger, byval as ushort ptr) as RPC_STATUS
declare function RpcNsProfileEltInqBegin alias "RpcNsProfileEltInqBeginW" (byval as uinteger, byval as ushort ptr, byval as uinteger, byval as RPC_IF_ID ptr, byval as uinteger, byval as uinteger, byval as ushort ptr, byval as RPC_NS_HANDLE ptr) as RPC_STATUS
declare function RpcNsProfileEltInqNext alias "RpcNsProfileEltInqNextW" (byval as RPC_NS_HANDLE, byval as RPC_IF_ID ptr, byval as ushort ptr ptr, byval as uinteger ptr, byval as ushort ptr ptr) as RPC_STATUS
declare function RpcNsEntryObjectInqBegin alias "RpcNsEntryObjectInqBeginW" (byval as uinteger, byval as ushort ptr, byval as RPC_NS_HANDLE ptr) as RPC_STATUS
declare function RpcNsEntryExpandName alias "RpcNsEntryExpandNameW" (byval as uinteger, byval as ushort ptr, byval as ushort ptr ptr) as RPC_STATUS
declare function RpcNsMgmtBindingUnexport alias "RpcNsMgmtBindingUnexportW" (byval as uinteger, byval as ushort ptr, byval as RPC_IF_ID ptr, byval as uinteger, byval as UUID_VECTOR ptr) as RPC_STATUS
declare function RpcNsMgmtEntryCreate alias "RpcNsMgmtEntryCreateW" (byval as uinteger, byval as ushort ptr) as RPC_STATUS
declare function RpcNsMgmtEntryDelete alias "RpcNsMgmtEntryDeleteW" (byval as uinteger, byval as ushort ptr) as RPC_STATUS
declare function RpcNsMgmtEntryInqIfIds alias "RpcNsMgmtEntryInqIfIdsW" (byval as uinteger, byval as ushort, byval as RPC_IF_ID_VECTOR ptr ptr) as RPC_STATUS
declare function RpcNsBindingImportBegin alias "RpcNsBindingImportBeginW" (byval as uinteger, byval as ushort ptr, byval as RPC_IF_HANDLE, byval as UUID ptr, byval as RPC_NS_HANDLE ptr) as RPC_STATUS

#else ''UNICODE
declare function RpcNsBindingExport alias "RpcNsBindingExportA" (byval as uinteger, byval as ubyte ptr, byval as RPC_IF_HANDLE, byval as RPC_BINDING_VECTOR ptr, byval as UUID_VECTOR ptr) as RPC_STATUS
declare function RpcNsBindingUnexport alias "RpcNsBindingUnexportA" (byval as uinteger, byval as ubyte ptr, byval as RPC_IF_HANDLE, byval as UUID_VECTOR ptr) as RPC_STATUS
declare function RpcNsBindingLookupBegin alias "RpcNsBindingLookupBeginA" (byval as uinteger, byval as ubyte ptr, byval as RPC_IF_HANDLE, byval as UUID ptr, byval as uinteger, byval as RPC_NS_HANDLE ptr) as RPC_STATUS
declare function RpcNsGroupDelete alias "RpcNsGroupDeleteA" (byval as uinteger, byval as ubyte ptr) as RPC_STATUS
declare function RpcNsGroupMbrAdd alias "RpcNsGroupMbrAddA" (byval as uinteger, byval as ubyte ptr, byval as uinteger, byval as ubyte ptr) as RPC_STATUS
declare function RpcNsGroupMbrRemove alias "RpcNsGroupMbrRemoveA" (byval as uinteger, byval as ubyte ptr, byval as uinteger, byval as ubyte ptr) as RPC_STATUS
declare function RpcNsGroupMbrInqBegin alias "RpcNsGroupMbrInqBeginA" (byval as uinteger, byval as ubyte ptr, byval as uinteger, byval as RPC_NS_HANDLE ptr) as RPC_STATUS
declare function RpcNsGroupMbrInqNext alias "RpcNsGroupMbrInqNextA" (byval as RPC_NS_HANDLE, byval as ubyte ptr ptr) as RPC_STATUS
declare function RpcNsProfileDelete alias "RpcNsProfileDeleteA" (byval as uinteger, byval as ubyte ptr) as RPC_STATUS
declare function RpcNsProfileEltAdd alias "RpcNsProfileEltAddA" (byval as uinteger, byval as ubyte ptr, byval as RPC_IF_ID ptr, byval as uinteger, byval as ubyte ptr, byval as uinteger, byval as ubyte ptr) as RPC_STATUS
declare function RpcNsProfileEltRemove alias "RpcNsProfileEltRemoveA" (byval as uinteger, byval as ubyte ptr, byval as RPC_IF_ID ptr, byval as uinteger, byval as ubyte ptr) as RPC_STATUS
declare function RpcNsProfileEltInqBegin alias "RpcNsProfileEltInqBeginA" (byval as uinteger, byval as ubyte ptr, byval as uinteger, byval as RPC_IF_ID ptr, byval as uinteger, byval as uinteger, byval as ubyte ptr, byval as RPC_NS_HANDLE ptr) as RPC_STATUS
declare function RpcNsProfileEltInqNext alias "RpcNsProfileEltInqNextA" (byval as RPC_NS_HANDLE, byval as RPC_IF_ID ptr, byval as ubyte ptr ptr, byval as uinteger ptr, byval as ubyte ptr ptr) as RPC_STATUS
declare function RpcNsEntryExpandName alias "RpcNsEntryExpandNameA" (byval as uinteger, byval as ubyte ptr, byval as ubyte ptr ptr) as RPC_STATUS
declare function RpcNsMgmtBindingUnexport alias "RpcNsMgmtBindingUnexportA" (byval as uinteger, byval as ubyte ptr, byval as RPC_IF_ID ptr, byval as uinteger, byval as UUID_VECTOR ptr) as RPC_STATUS
declare function RpcNsMgmtEntryCreate alias "RpcNsMgmtEntryCreateA" (byval as uinteger, byval as ubyte ptr) as RPC_STATUS
declare function RpcNsMgmtEntryDelete alias "RpcNsMgmtEntryDeleteA" (byval as uinteger, byval as ubyte ptr) as RPC_STATUS
declare function RpcNsMgmtEntryInqIfIds alias "RpcNsMgmtEntryInqIfIdsA" (byval as uinteger, byval as ubyte ptr, byval as RPC_IF_ID_VECTOR ptr ptr) as RPC_STATUS
declare function RpcNsEntryObjectInqBegin alias "RpcNsEntryObjectInqBeginA" (byval as uinteger, byval as ubyte ptr, byval as RPC_NS_HANDLE ptr) as RPC_STATUS
declare function RpcNsBindingImportBegin alias "RpcNsBindingImportBeginA" (byval as uinteger, byval as ubyte ptr, byval as RPC_IF_HANDLE, byval as UUID ptr, byval as RPC_NS_HANDLE ptr) as RPC_STATUS

#endif ''UNICODE

#endif
