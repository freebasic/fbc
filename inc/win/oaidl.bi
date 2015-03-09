#pragma once

#include once "rpc.bi"
#include once "rpcndr.bi"
#include once "windows.bi"
#include once "ole2.bi"
#include once "objidl.bi"
#include once "winapifamily.bi"

#inclib "uuid"

extern "Windows"

#define __oaidl_h__
#define __ICreateTypeInfo_FWD_DEFINED__
#define __ICreateTypeInfo2_FWD_DEFINED__
#define __ICreateTypeLib_FWD_DEFINED__
#define __ICreateTypeLib2_FWD_DEFINED__
#define __IDispatch_FWD_DEFINED__
#define __IEnumVARIANT_FWD_DEFINED__
#define __ITypeComp_FWD_DEFINED__
#define __ITypeInfo_FWD_DEFINED__
#define __ITypeInfo2_FWD_DEFINED__
#define __ITypeLib_FWD_DEFINED__
#define __ITypeLib2_FWD_DEFINED__
#define __ITypeChangeEvents_FWD_DEFINED__
#define __IErrorInfo_FWD_DEFINED__
#define __ICreateErrorInfo_FWD_DEFINED__
#define __ISupportErrorInfo_FWD_DEFINED__
#define __ITypeFactory_FWD_DEFINED__
#define __ITypeMarshal_FWD_DEFINED__
#define __IRecordInfo_FWD_DEFINED__
#define __IErrorLog_FWD_DEFINED__
#define __IPropertyBag_FWD_DEFINED__
#define __IOleAutomationTypes_INTERFACE_DEFINED__

extern IOleAutomationTypes_v1_0_c_ifspec as RPC_IF_HANDLE
extern IOleAutomationTypes_v1_0_s_ifspec as RPC_IF_HANDLE

type CURRENCY as CY

type tagSAFEARRAYBOUND
	cElements as ULONG
	lLbound as LONG
end type

type SAFEARRAYBOUND as tagSAFEARRAYBOUND
type LPSAFEARRAYBOUND as tagSAFEARRAYBOUND ptr
type wireVARIANT as _wireVARIANT ptr
type wireBRECORD as _wireBRECORD ptr

type _wireSAFEARR_BSTR
	Size as ULONG
	aBstr as wireBSTR ptr
end type

type SAFEARR_BSTR as _wireSAFEARR_BSTR

type _wireSAFEARR_UNKNOWN
	Size as ULONG
	apUnknown as IUnknown ptr ptr
end type

type SAFEARR_UNKNOWN as _wireSAFEARR_UNKNOWN

type IDispatch as IDispatch_

type _wireSAFEARR_DISPATCH
	Size as ULONG
	apDispatch as IDispatch ptr ptr
end type

type SAFEARR_DISPATCH as _wireSAFEARR_DISPATCH

type _wireSAFEARR_VARIANT
	Size as ULONG
	aVariant as wireVARIANT ptr
end type

type SAFEARR_VARIANT as _wireSAFEARR_VARIANT

type _wireSAFEARR_BRECORD
	Size as ULONG
	aRecord as wireBRECORD ptr
end type

type SAFEARR_BRECORD as _wireSAFEARR_BRECORD

type _wireSAFEARR_HAVEIID
	Size as ULONG
	apUnknown as IUnknown ptr ptr
	iid as IID
end type

type SAFEARR_HAVEIID as _wireSAFEARR_HAVEIID

type tagSF_TYPE as long
enum
	SF_ERROR = VT_ERROR
	SF_I1 = VT_I1
	SF_I2 = VT_I2
	SF_I4 = VT_I4
	SF_I8 = VT_I8
	SF_BSTR = VT_BSTR
	SF_UNKNOWN = VT_UNKNOWN
	SF_DISPATCH = VT_DISPATCH
	SF_VARIANT = VT_VARIANT
	SF_RECORD = VT_RECORD
	SF_HAVEIID = VT_UNKNOWN or VT_RESERVED
end enum

type SF_TYPE as tagSF_TYPE

union _wireSAFEARRAY_UNION_u
	BstrStr as SAFEARR_BSTR
	UnknownStr as SAFEARR_UNKNOWN
	DispatchStr as SAFEARR_DISPATCH
	VariantStr as SAFEARR_VARIANT
	RecordStr as SAFEARR_BRECORD
	HaveIidStr as SAFEARR_HAVEIID
	ByteStr as BYTE_SIZEDARR
	WordStr as WORD_SIZEDARR
	LongStr as DWORD_SIZEDARR
	HyperStr as HYPER_SIZEDARR
end union

type _wireSAFEARRAY_UNION
	sfType as ULONG
	u as _wireSAFEARRAY_UNION_u
end type

type SAFEARRAYUNION as _wireSAFEARRAY_UNION

type _wireSAFEARRAY
	cDims as USHORT
	fFeatures as USHORT
	cbElements as ULONG
	cLocks as ULONG
	uArrayStructs as SAFEARRAYUNION
	rgsabound(0 to 0) as SAFEARRAYBOUND
end type

type wireSAFEARRAY as _wireSAFEARRAY ptr
type wirePSAFEARRAY as wireSAFEARRAY ptr

type tagSAFEARRAY
	cDims as USHORT
	fFeatures as USHORT
	cbElements as ULONG
	cLocks as ULONG
	pvData as PVOID
	rgsabound(0 to 0) as SAFEARRAYBOUND
end type

type SAFEARRAY as tagSAFEARRAY
type LPSAFEARRAY as SAFEARRAY ptr

#define FADF_AUTO &h1
#define FADF_STATIC &h2
#define FADF_EMBEDDED &h4
#define FADF_FIXEDSIZE &h10
#define FADF_RECORD &h20
#define FADF_HAVEIID &h40
#define FADF_HAVEVARTYPE &h80
#define FADF_BSTR &h100
#define FADF_UNKNOWN &h200
#define FADF_DISPATCH &h400
#define FADF_VARIANT &h800
#define FADF_RESERVED &hf008
#define _FORCENAMELESSUNION 1
#define __tagVARIANT
#define __VARIANT_NAME_1
#define __VARIANT_NAME_2
#define __VARIANT_NAME_3
#define __tagBRECORD
#define __VARIANT_NAME_4

type VARIANT as tagVARIANT

type IRecordInfo as IRecordInfo_

type tagVARIANT
	union
		type
			vt as VARTYPE
			wReserved1 as WORD
			wReserved2 as WORD
			wReserved3 as WORD

			union
				llVal as LONGLONG
				lVal as LONG
				bVal as UBYTE
				iVal as SHORT
				fltVal as FLOAT
				dblVal as DOUBLE
				boolVal as VARIANT_BOOL
				scode as SCODE
				cyVal as CY
				date as DATE_
				bstrVal as BSTR
				punkVal as IUnknown ptr
				pdispVal as IDispatch ptr
				parray as SAFEARRAY ptr
				pbVal as UBYTE ptr
				piVal as SHORT ptr
				plVal as LONG ptr
				pllVal as LONGLONG ptr
				pfltVal as FLOAT ptr
				pdblVal as DOUBLE ptr
				pboolVal as VARIANT_BOOL ptr
				pscode as SCODE ptr
				pcyVal as CY ptr
				pdate as DATE_ ptr
				pbstrVal as BSTR ptr
				ppunkVal as IUnknown ptr ptr
				ppdispVal as IDispatch ptr ptr
				pparray as SAFEARRAY ptr ptr
				pvarVal as VARIANT ptr
				byref as PVOID
				cVal as byte
				uiVal as USHORT
				ulVal as ULONG
				ullVal as ULONGLONG
				intVal as INT_
				uintVal as UINT
				pdecVal as DECIMAL ptr
				pcVal as zstring ptr
				puiVal as USHORT ptr
				pulVal as ULONG ptr
				pullVal as ULONGLONG ptr
				pintVal as INT_ ptr
				puintVal as UINT ptr

				type
					pvRecord as PVOID
					pRecInfo as IRecordInfo ptr
				end type
			end union
		end type

		decVal as DECIMAL
	end union
end type

type LPVARIANT as VARIANT ptr
type VARIANTARG as VARIANT
type LPVARIANTARG as VARIANT ptr

#define _REFVARIANT_DEFINED

type _wireBRECORD
	fFlags as ULONG
	clSize as ULONG
	pRecInfo as IRecordInfo ptr
	pRecord as ubyte ptr
end type

type _wireVARIANT
	clSize as DWORD
	rpcReserved as DWORD
	vt as USHORT
	wReserved1 as USHORT
	wReserved2 as USHORT
	wReserved3 as USHORT

	union
		llVal as LONGLONG
		lVal as LONG
		bVal as UBYTE
		iVal as SHORT
		fltVal as FLOAT
		dblVal as DOUBLE
		boolVal as VARIANT_BOOL
		scode as SCODE
		cyVal as CY
		date as DATE_
		bstrVal as wireBSTR
		punkVal as IUnknown ptr
		pdispVal as IDispatch ptr
		parray as wirePSAFEARRAY
		brecVal as wireBRECORD
		pbVal as UBYTE ptr
		piVal as SHORT ptr
		plVal as LONG ptr
		pllVal as LONGLONG ptr
		pfltVal as FLOAT ptr
		pdblVal as DOUBLE ptr
		pboolVal as VARIANT_BOOL ptr
		pscode as SCODE ptr
		pcyVal as CY ptr
		pdate as DATE_ ptr
		pbstrVal as wireBSTR ptr
		ppunkVal as IUnknown ptr ptr
		ppdispVal as IDispatch ptr ptr
		pparray as wirePSAFEARRAY ptr
		pvarVal as wireVARIANT ptr
		cVal as byte
		uiVal as USHORT
		ulVal as ULONG
		ullVal as ULONGLONG
		intVal as INT_
		uintVal as UINT
		decVal as DECIMAL
		pdecVal as DECIMAL ptr
		pcVal as zstring ptr
		puiVal as USHORT ptr
		pulVal as ULONG ptr
		pullVal as ULONGLONG ptr
		pintVal as INT_ ptr
		puintVal as UINT ptr
	end union
end type

type DISPID as LONG
type MEMBERID as DISPID
type HREFTYPE as DWORD

type tagTYPEKIND as long
enum
	TKIND_ENUM = 0
	TKIND_RECORD = 1
	TKIND_MODULE = 2
	TKIND_INTERFACE = 3
	TKIND_DISPATCH = 4
	TKIND_COCLASS = 5
	TKIND_ALIAS = 6
	TKIND_UNION = 7
	TKIND_MAX = 8
end enum

type TYPEKIND as tagTYPEKIND

type tagARRAYDESC as tagARRAYDESC_

type tagTYPEDESC
	union
		lptdesc as tagTYPEDESC ptr
		lpadesc as tagARRAYDESC ptr
		hreftype as HREFTYPE
	end union

	vt as VARTYPE
end type

type TYPEDESC as tagTYPEDESC

type tagARRAYDESC_
	tdescElem as TYPEDESC
	cDims as USHORT
	rgbounds(0 to 0) as SAFEARRAYBOUND
end type

type ARRAYDESC as tagARRAYDESC

type tagPARAMDESCEX
	cBytes as ULONG
	varDefaultValue as VARIANTARG
end type

type PARAMDESCEX as tagPARAMDESCEX
type LPPARAMDESCEX as tagPARAMDESCEX ptr

type tagPARAMDESC
	pparamdescex as LPPARAMDESCEX
	wParamFlags as USHORT
end type

type PARAMDESC as tagPARAMDESC
type LPPARAMDESC as tagPARAMDESC ptr

#define PARAMFLAG_NONE &h0
#define PARAMFLAG_FIN &h1
#define PARAMFLAG_FOUT &h2
#define PARAMFLAG_FLCID &h4
#define PARAMFLAG_FRETVAL &h8
#define PARAMFLAG_FOPT &h10
#define PARAMFLAG_FHASDEFAULT &h20
#define PARAMFLAG_FHASCUSTDATA &h40

type tagIDLDESC
	dwReserved as ULONG_PTR
	wIDLFlags as USHORT
end type

type IDLDESC as tagIDLDESC
type LPIDLDESC as tagIDLDESC ptr

#define IDLFLAG_NONE PARAMFLAG_NONE
#define IDLFLAG_FIN PARAMFLAG_FIN
#define IDLFLAG_FOUT PARAMFLAG_FOUT
#define IDLFLAG_FLCID PARAMFLAG_FLCID
#define IDLFLAG_FRETVAL PARAMFLAG_FRETVAL

type tagELEMDESC
	tdesc as TYPEDESC

	union
		idldesc as IDLDESC
		paramdesc as PARAMDESC
	end union
end type

type ELEMDESC as tagELEMDESC
type LPELEMDESC as tagELEMDESC ptr

type tagTYPEATTR
	guid as GUID
	lcid as LCID
	dwReserved as DWORD
	memidConstructor as MEMBERID
	memidDestructor as MEMBERID
	lpstrSchema as LPOLESTR
	cbSizeInstance as ULONG
	typekind as TYPEKIND
	cFuncs as WORD
	cVars as WORD
	cImplTypes as WORD
	cbSizeVft as WORD
	cbAlignment as WORD
	wTypeFlags as WORD
	wMajorVerNum as WORD
	wMinorVerNum as WORD
	tdescAlias as TYPEDESC
	idldescType as IDLDESC
end type

type TYPEATTR as tagTYPEATTR
type LPTYPEATTR as tagTYPEATTR ptr

type tagDISPPARAMS
	rgvarg as VARIANTARG ptr
	rgdispidNamedArgs as DISPID ptr
	cArgs as UINT
	cNamedArgs as UINT
end type

type DISPPARAMS as tagDISPPARAMS

type tagEXCEPINFO
	wCode as WORD
	wReserved as WORD
	bstrSource as BSTR
	bstrDescription as BSTR
	bstrHelpFile as BSTR
	dwHelpContext as DWORD
	pvReserved as PVOID
	pfnDeferredFillIn as function(byval as tagEXCEPINFO ptr) as HRESULT
	scode as SCODE
end type

type EXCEPINFO as tagEXCEPINFO
type LPEXCEPINFO as tagEXCEPINFO ptr

type tagCALLCONV as long
enum
	CC_FASTCALL = 0
	CC_CDECL = 1
	CC_MSCPASCAL = 2
	CC_PASCAL = CC_MSCPASCAL
	CC_MACPASCAL = 3
	CC_STDCALL = 4
	CC_FPFASTCALL = 5
	CC_SYSCALL = 6
	CC_MPWCDECL = 7
	CC_MPWPASCAL = 8
	CC_MAX = 9
end enum

type CALLCONV as tagCALLCONV

type tagFUNCKIND as long
enum
	FUNC_VIRTUAL = 0
	FUNC_PUREVIRTUAL = 1
	FUNC_NONVIRTUAL = 2
	FUNC_STATIC = 3
	FUNC_DISPATCH = 4
end enum

type FUNCKIND as tagFUNCKIND

type tagINVOKEKIND as long
enum
	INVOKE_FUNC = 1
	INVOKE_PROPERTYGET = 2
	INVOKE_PROPERTYPUT = 4
	INVOKE_PROPERTYPUTREF = 8
end enum

type INVOKEKIND as tagINVOKEKIND

type tagFUNCDESC
	memid as MEMBERID
	lprgscode as SCODE ptr
	lprgelemdescParam as ELEMDESC ptr
	funckind as FUNCKIND
	invkind as INVOKEKIND
	callconv as CALLCONV
	cParams as SHORT
	cParamsOpt as SHORT
	oVft as SHORT
	cScodes as SHORT
	elemdescFunc as ELEMDESC
	wFuncFlags as WORD
end type

type FUNCDESC as tagFUNCDESC
type LPFUNCDESC as tagFUNCDESC ptr

type tagVARKIND as long
enum
	VAR_PERINSTANCE = 0
	VAR_STATIC = 1
	VAR_CONST = 2
	VAR_DISPATCH = 3
end enum

type VARKIND as tagVARKIND

#define IMPLTYPEFLAG_FDEFAULT &h1
#define IMPLTYPEFLAG_FSOURCE &h2
#define IMPLTYPEFLAG_FRESTRICTED &h4
#define IMPLTYPEFLAG_FDEFAULTVTABLE &h8

type tagVARDESC
	memid as MEMBERID
	lpstrSchema as LPOLESTR

	union
		oInst as ULONG
		lpvarValue as VARIANT ptr
	end union

	elemdescVar as ELEMDESC
	wVarFlags as WORD
	varkind as VARKIND
end type

type VARDESC as tagVARDESC
type LPVARDESC as tagVARDESC ptr

type tagTYPEFLAGS as long
enum
	TYPEFLAG_FAPPOBJECT = &h1
	TYPEFLAG_FCANCREATE = &h2
	TYPEFLAG_FLICENSED = &h4
	TYPEFLAG_FPREDECLID = &h8
	TYPEFLAG_FHIDDEN = &h10
	TYPEFLAG_FCONTROL = &h20
	TYPEFLAG_FDUAL = &h40
	TYPEFLAG_FNONEXTENSIBLE = &h80
	TYPEFLAG_FOLEAUTOMATION = &h100
	TYPEFLAG_FRESTRICTED = &h200
	TYPEFLAG_FAGGREGATABLE = &h400
	TYPEFLAG_FREPLACEABLE = &h800
	TYPEFLAG_FDISPATCHABLE = &h1000
	TYPEFLAG_FREVERSEBIND = &h2000
	TYPEFLAG_FPROXY = &h4000
end enum

type TYPEFLAGS as tagTYPEFLAGS

type tagFUNCFLAGS as long
enum
	FUNCFLAG_FRESTRICTED = &h1
	FUNCFLAG_FSOURCE = &h2
	FUNCFLAG_FBINDABLE = &h4
	FUNCFLAG_FREQUESTEDIT = &h8
	FUNCFLAG_FDISPLAYBIND = &h10
	FUNCFLAG_FDEFAULTBIND = &h20
	FUNCFLAG_FHIDDEN = &h40
	FUNCFLAG_FUSESGETLASTERROR = &h80
	FUNCFLAG_FDEFAULTCOLLELEM = &h100
	FUNCFLAG_FUIDEFAULT = &h200
	FUNCFLAG_FNONBROWSABLE = &h400
	FUNCFLAG_FREPLACEABLE = &h800
	FUNCFLAG_FIMMEDIATEBIND = &h1000
end enum

type FUNCFLAGS as tagFUNCFLAGS

type tagVARFLAGS as long
enum
	VARFLAG_FREADONLY = &h1
	VARFLAG_FSOURCE = &h2
	VARFLAG_FBINDABLE = &h4
	VARFLAG_FREQUESTEDIT = &h8
	VARFLAG_FDISPLAYBIND = &h10
	VARFLAG_FDEFAULTBIND = &h20
	VARFLAG_FHIDDEN = &h40
	VARFLAG_FRESTRICTED = &h80
	VARFLAG_FDEFAULTCOLLELEM = &h100
	VARFLAG_FUIDEFAULT = &h200
	VARFLAG_FNONBROWSABLE = &h400
	VARFLAG_FREPLACEABLE = &h800
	VARFLAG_FIMMEDIATEBIND = &h1000
end enum

type VARFLAGS as tagVARFLAGS

type tagCLEANLOCALSTORAGE
	pInterface as IUnknown ptr
	pStorage as PVOID
	flags as DWORD
end type

type CLEANLOCALSTORAGE as tagCLEANLOCALSTORAGE

type tagCUSTDATAITEM
	guid as GUID
	varValue as VARIANTARG
end type

type CUSTDATAITEM as tagCUSTDATAITEM
type LPCUSTDATAITEM as tagCUSTDATAITEM ptr

type tagCUSTDATA
	cCustData as DWORD
	prgCustData as LPCUSTDATAITEM
end type

type CUSTDATA as tagCUSTDATA
type LPCUSTDATA as tagCUSTDATA ptr

#define __ICreateTypeInfo_INTERFACE_DEFINED__

type ICreateTypeInfo as ICreateTypeInfo_

type LPCREATETYPEINFO as ICreateTypeInfo ptr

extern IID_ICreateTypeInfo as const GUID

type ITypeInfo as ITypeInfo_

type ICreateTypeInfoVtbl
	QueryInterface as function(byval This as ICreateTypeInfo ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ICreateTypeInfo ptr) as ULONG
	Release as function(byval This as ICreateTypeInfo ptr) as ULONG
	SetGuid as function(byval This as ICreateTypeInfo ptr, byval guid as const GUID const ptr) as HRESULT
	SetTypeFlags as function(byval This as ICreateTypeInfo ptr, byval uTypeFlags as UINT) as HRESULT
	SetDocString as function(byval This as ICreateTypeInfo ptr, byval pStrDoc as LPOLESTR) as HRESULT
	SetHelpContext as function(byval This as ICreateTypeInfo ptr, byval dwHelpContext as DWORD) as HRESULT
	SetVersion as function(byval This as ICreateTypeInfo ptr, byval wMajorVerNum as WORD, byval wMinorVerNum as WORD) as HRESULT
	AddRefTypeInfo as function(byval This as ICreateTypeInfo ptr, byval pTInfo as ITypeInfo ptr, byval phRefType as HREFTYPE ptr) as HRESULT
	AddFuncDesc as function(byval This as ICreateTypeInfo ptr, byval index as UINT, byval pFuncDesc as FUNCDESC ptr) as HRESULT
	AddImplType as function(byval This as ICreateTypeInfo ptr, byval index as UINT, byval hRefType as HREFTYPE) as HRESULT
	SetImplTypeFlags as function(byval This as ICreateTypeInfo ptr, byval index as UINT, byval implTypeFlags as INT_) as HRESULT
	SetAlignment as function(byval This as ICreateTypeInfo ptr, byval cbAlignment as WORD) as HRESULT
	SetSchema as function(byval This as ICreateTypeInfo ptr, byval pStrSchema as LPOLESTR) as HRESULT
	AddVarDesc as function(byval This as ICreateTypeInfo ptr, byval index as UINT, byval pVarDesc as VARDESC ptr) as HRESULT
	SetFuncAndParamNames as function(byval This as ICreateTypeInfo ptr, byval index as UINT, byval rgszNames as LPOLESTR ptr, byval cNames as UINT) as HRESULT
	SetVarName as function(byval This as ICreateTypeInfo ptr, byval index as UINT, byval szName as LPOLESTR) as HRESULT
	SetTypeDescAlias as function(byval This as ICreateTypeInfo ptr, byval pTDescAlias as TYPEDESC ptr) as HRESULT
	DefineFuncAsDllEntry as function(byval This as ICreateTypeInfo ptr, byval index as UINT, byval szDllName as LPOLESTR, byval szProcName as LPOLESTR) as HRESULT
	SetFuncDocString as function(byval This as ICreateTypeInfo ptr, byval index as UINT, byval szDocString as LPOLESTR) as HRESULT
	SetVarDocString as function(byval This as ICreateTypeInfo ptr, byval index as UINT, byval szDocString as LPOLESTR) as HRESULT
	SetFuncHelpContext as function(byval This as ICreateTypeInfo ptr, byval index as UINT, byval dwHelpContext as DWORD) as HRESULT
	SetVarHelpContext as function(byval This as ICreateTypeInfo ptr, byval index as UINT, byval dwHelpContext as DWORD) as HRESULT
	SetMops as function(byval This as ICreateTypeInfo ptr, byval index as UINT, byval bstrMops as BSTR) as HRESULT
	SetTypeIdldesc as function(byval This as ICreateTypeInfo ptr, byval pIdlDesc as IDLDESC ptr) as HRESULT
	LayOut as function(byval This as ICreateTypeInfo ptr) as HRESULT
end type

type ICreateTypeInfo_
	lpVtbl as ICreateTypeInfoVtbl ptr
end type

declare function ICreateTypeInfo_SetGuid_Proxy(byval This as ICreateTypeInfo ptr, byval guid as const GUID const ptr) as HRESULT
declare sub ICreateTypeInfo_SetGuid_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICreateTypeInfo_SetTypeFlags_Proxy(byval This as ICreateTypeInfo ptr, byval uTypeFlags as UINT) as HRESULT
declare sub ICreateTypeInfo_SetTypeFlags_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICreateTypeInfo_SetDocString_Proxy(byval This as ICreateTypeInfo ptr, byval pStrDoc as LPOLESTR) as HRESULT
declare sub ICreateTypeInfo_SetDocString_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICreateTypeInfo_SetHelpContext_Proxy(byval This as ICreateTypeInfo ptr, byval dwHelpContext as DWORD) as HRESULT
declare sub ICreateTypeInfo_SetHelpContext_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICreateTypeInfo_SetVersion_Proxy(byval This as ICreateTypeInfo ptr, byval wMajorVerNum as WORD, byval wMinorVerNum as WORD) as HRESULT
declare sub ICreateTypeInfo_SetVersion_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICreateTypeInfo_AddRefTypeInfo_Proxy(byval This as ICreateTypeInfo ptr, byval pTInfo as ITypeInfo ptr, byval phRefType as HREFTYPE ptr) as HRESULT
declare sub ICreateTypeInfo_AddRefTypeInfo_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICreateTypeInfo_AddFuncDesc_Proxy(byval This as ICreateTypeInfo ptr, byval index as UINT, byval pFuncDesc as FUNCDESC ptr) as HRESULT
declare sub ICreateTypeInfo_AddFuncDesc_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICreateTypeInfo_AddImplType_Proxy(byval This as ICreateTypeInfo ptr, byval index as UINT, byval hRefType as HREFTYPE) as HRESULT
declare sub ICreateTypeInfo_AddImplType_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICreateTypeInfo_SetImplTypeFlags_Proxy(byval This as ICreateTypeInfo ptr, byval index as UINT, byval implTypeFlags as INT_) as HRESULT
declare sub ICreateTypeInfo_SetImplTypeFlags_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICreateTypeInfo_SetAlignment_Proxy(byval This as ICreateTypeInfo ptr, byval cbAlignment as WORD) as HRESULT
declare sub ICreateTypeInfo_SetAlignment_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICreateTypeInfo_SetSchema_Proxy(byval This as ICreateTypeInfo ptr, byval pStrSchema as LPOLESTR) as HRESULT
declare sub ICreateTypeInfo_SetSchema_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICreateTypeInfo_AddVarDesc_Proxy(byval This as ICreateTypeInfo ptr, byval index as UINT, byval pVarDesc as VARDESC ptr) as HRESULT
declare sub ICreateTypeInfo_AddVarDesc_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICreateTypeInfo_SetFuncAndParamNames_Proxy(byval This as ICreateTypeInfo ptr, byval index as UINT, byval rgszNames as LPOLESTR ptr, byval cNames as UINT) as HRESULT
declare sub ICreateTypeInfo_SetFuncAndParamNames_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICreateTypeInfo_SetVarName_Proxy(byval This as ICreateTypeInfo ptr, byval index as UINT, byval szName as LPOLESTR) as HRESULT
declare sub ICreateTypeInfo_SetVarName_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICreateTypeInfo_SetTypeDescAlias_Proxy(byval This as ICreateTypeInfo ptr, byval pTDescAlias as TYPEDESC ptr) as HRESULT
declare sub ICreateTypeInfo_SetTypeDescAlias_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICreateTypeInfo_DefineFuncAsDllEntry_Proxy(byval This as ICreateTypeInfo ptr, byval index as UINT, byval szDllName as LPOLESTR, byval szProcName as LPOLESTR) as HRESULT
declare sub ICreateTypeInfo_DefineFuncAsDllEntry_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICreateTypeInfo_SetFuncDocString_Proxy(byval This as ICreateTypeInfo ptr, byval index as UINT, byval szDocString as LPOLESTR) as HRESULT
declare sub ICreateTypeInfo_SetFuncDocString_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICreateTypeInfo_SetVarDocString_Proxy(byval This as ICreateTypeInfo ptr, byval index as UINT, byval szDocString as LPOLESTR) as HRESULT
declare sub ICreateTypeInfo_SetVarDocString_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICreateTypeInfo_SetFuncHelpContext_Proxy(byval This as ICreateTypeInfo ptr, byval index as UINT, byval dwHelpContext as DWORD) as HRESULT
declare sub ICreateTypeInfo_SetFuncHelpContext_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICreateTypeInfo_SetVarHelpContext_Proxy(byval This as ICreateTypeInfo ptr, byval index as UINT, byval dwHelpContext as DWORD) as HRESULT
declare sub ICreateTypeInfo_SetVarHelpContext_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICreateTypeInfo_SetMops_Proxy(byval This as ICreateTypeInfo ptr, byval index as UINT, byval bstrMops as BSTR) as HRESULT
declare sub ICreateTypeInfo_SetMops_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICreateTypeInfo_SetTypeIdldesc_Proxy(byval This as ICreateTypeInfo ptr, byval pIdlDesc as IDLDESC ptr) as HRESULT
declare sub ICreateTypeInfo_SetTypeIdldesc_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICreateTypeInfo_LayOut_Proxy(byval This as ICreateTypeInfo ptr) as HRESULT
declare sub ICreateTypeInfo_LayOut_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define __ICreateTypeInfo2_INTERFACE_DEFINED__

type ICreateTypeInfo2 as ICreateTypeInfo2_

type LPCREATETYPEINFO2 as ICreateTypeInfo2 ptr

extern IID_ICreateTypeInfo2 as const GUID

type ICreateTypeInfo2Vtbl
	QueryInterface as function(byval This as ICreateTypeInfo2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ICreateTypeInfo2 ptr) as ULONG
	Release as function(byval This as ICreateTypeInfo2 ptr) as ULONG
	SetGuid as function(byval This as ICreateTypeInfo2 ptr, byval guid as const GUID const ptr) as HRESULT
	SetTypeFlags as function(byval This as ICreateTypeInfo2 ptr, byval uTypeFlags as UINT) as HRESULT
	SetDocString as function(byval This as ICreateTypeInfo2 ptr, byval pStrDoc as LPOLESTR) as HRESULT
	SetHelpContext as function(byval This as ICreateTypeInfo2 ptr, byval dwHelpContext as DWORD) as HRESULT
	SetVersion as function(byval This as ICreateTypeInfo2 ptr, byval wMajorVerNum as WORD, byval wMinorVerNum as WORD) as HRESULT
	AddRefTypeInfo as function(byval This as ICreateTypeInfo2 ptr, byval pTInfo as ITypeInfo ptr, byval phRefType as HREFTYPE ptr) as HRESULT
	AddFuncDesc as function(byval This as ICreateTypeInfo2 ptr, byval index as UINT, byval pFuncDesc as FUNCDESC ptr) as HRESULT
	AddImplType as function(byval This as ICreateTypeInfo2 ptr, byval index as UINT, byval hRefType as HREFTYPE) as HRESULT
	SetImplTypeFlags as function(byval This as ICreateTypeInfo2 ptr, byval index as UINT, byval implTypeFlags as INT_) as HRESULT
	SetAlignment as function(byval This as ICreateTypeInfo2 ptr, byval cbAlignment as WORD) as HRESULT
	SetSchema as function(byval This as ICreateTypeInfo2 ptr, byval pStrSchema as LPOLESTR) as HRESULT
	AddVarDesc as function(byval This as ICreateTypeInfo2 ptr, byval index as UINT, byval pVarDesc as VARDESC ptr) as HRESULT
	SetFuncAndParamNames as function(byval This as ICreateTypeInfo2 ptr, byval index as UINT, byval rgszNames as LPOLESTR ptr, byval cNames as UINT) as HRESULT
	SetVarName as function(byval This as ICreateTypeInfo2 ptr, byval index as UINT, byval szName as LPOLESTR) as HRESULT
	SetTypeDescAlias as function(byval This as ICreateTypeInfo2 ptr, byval pTDescAlias as TYPEDESC ptr) as HRESULT
	DefineFuncAsDllEntry as function(byval This as ICreateTypeInfo2 ptr, byval index as UINT, byval szDllName as LPOLESTR, byval szProcName as LPOLESTR) as HRESULT
	SetFuncDocString as function(byval This as ICreateTypeInfo2 ptr, byval index as UINT, byval szDocString as LPOLESTR) as HRESULT
	SetVarDocString as function(byval This as ICreateTypeInfo2 ptr, byval index as UINT, byval szDocString as LPOLESTR) as HRESULT
	SetFuncHelpContext as function(byval This as ICreateTypeInfo2 ptr, byval index as UINT, byval dwHelpContext as DWORD) as HRESULT
	SetVarHelpContext as function(byval This as ICreateTypeInfo2 ptr, byval index as UINT, byval dwHelpContext as DWORD) as HRESULT
	SetMops as function(byval This as ICreateTypeInfo2 ptr, byval index as UINT, byval bstrMops as BSTR) as HRESULT
	SetTypeIdldesc as function(byval This as ICreateTypeInfo2 ptr, byval pIdlDesc as IDLDESC ptr) as HRESULT
	LayOut as function(byval This as ICreateTypeInfo2 ptr) as HRESULT
	DeleteFuncDesc as function(byval This as ICreateTypeInfo2 ptr, byval index as UINT) as HRESULT
	DeleteFuncDescByMemId as function(byval This as ICreateTypeInfo2 ptr, byval memid as MEMBERID, byval invKind as INVOKEKIND) as HRESULT
	DeleteVarDesc as function(byval This as ICreateTypeInfo2 ptr, byval index as UINT) as HRESULT
	DeleteVarDescByMemId as function(byval This as ICreateTypeInfo2 ptr, byval memid as MEMBERID) as HRESULT
	DeleteImplType as function(byval This as ICreateTypeInfo2 ptr, byval index as UINT) as HRESULT
	SetCustData as function(byval This as ICreateTypeInfo2 ptr, byval guid as const GUID const ptr, byval pVarVal as VARIANT ptr) as HRESULT
	SetFuncCustData as function(byval This as ICreateTypeInfo2 ptr, byval index as UINT, byval guid as const GUID const ptr, byval pVarVal as VARIANT ptr) as HRESULT
	SetParamCustData as function(byval This as ICreateTypeInfo2 ptr, byval indexFunc as UINT, byval indexParam as UINT, byval guid as const GUID const ptr, byval pVarVal as VARIANT ptr) as HRESULT
	SetVarCustData as function(byval This as ICreateTypeInfo2 ptr, byval index as UINT, byval guid as const GUID const ptr, byval pVarVal as VARIANT ptr) as HRESULT
	SetImplTypeCustData as function(byval This as ICreateTypeInfo2 ptr, byval index as UINT, byval guid as const GUID const ptr, byval pVarVal as VARIANT ptr) as HRESULT
	SetHelpStringContext as function(byval This as ICreateTypeInfo2 ptr, byval dwHelpStringContext as ULONG) as HRESULT
	SetFuncHelpStringContext as function(byval This as ICreateTypeInfo2 ptr, byval index as UINT, byval dwHelpStringContext as ULONG) as HRESULT
	SetVarHelpStringContext as function(byval This as ICreateTypeInfo2 ptr, byval index as UINT, byval dwHelpStringContext as ULONG) as HRESULT
	Invalidate as function(byval This as ICreateTypeInfo2 ptr) as HRESULT
	SetName as function(byval This as ICreateTypeInfo2 ptr, byval szName as LPOLESTR) as HRESULT
end type

type ICreateTypeInfo2_
	lpVtbl as ICreateTypeInfo2Vtbl ptr
end type

declare function ICreateTypeInfo2_DeleteFuncDesc_Proxy(byval This as ICreateTypeInfo2 ptr, byval index as UINT) as HRESULT
declare sub ICreateTypeInfo2_DeleteFuncDesc_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICreateTypeInfo2_DeleteFuncDescByMemId_Proxy(byval This as ICreateTypeInfo2 ptr, byval memid as MEMBERID, byval invKind as INVOKEKIND) as HRESULT
declare sub ICreateTypeInfo2_DeleteFuncDescByMemId_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICreateTypeInfo2_DeleteVarDesc_Proxy(byval This as ICreateTypeInfo2 ptr, byval index as UINT) as HRESULT
declare sub ICreateTypeInfo2_DeleteVarDesc_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICreateTypeInfo2_DeleteVarDescByMemId_Proxy(byval This as ICreateTypeInfo2 ptr, byval memid as MEMBERID) as HRESULT
declare sub ICreateTypeInfo2_DeleteVarDescByMemId_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICreateTypeInfo2_DeleteImplType_Proxy(byval This as ICreateTypeInfo2 ptr, byval index as UINT) as HRESULT
declare sub ICreateTypeInfo2_DeleteImplType_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICreateTypeInfo2_SetCustData_Proxy(byval This as ICreateTypeInfo2 ptr, byval guid as const GUID const ptr, byval pVarVal as VARIANT ptr) as HRESULT
declare sub ICreateTypeInfo2_SetCustData_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICreateTypeInfo2_SetFuncCustData_Proxy(byval This as ICreateTypeInfo2 ptr, byval index as UINT, byval guid as const GUID const ptr, byval pVarVal as VARIANT ptr) as HRESULT
declare sub ICreateTypeInfo2_SetFuncCustData_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICreateTypeInfo2_SetParamCustData_Proxy(byval This as ICreateTypeInfo2 ptr, byval indexFunc as UINT, byval indexParam as UINT, byval guid as const GUID const ptr, byval pVarVal as VARIANT ptr) as HRESULT
declare sub ICreateTypeInfo2_SetParamCustData_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICreateTypeInfo2_SetVarCustData_Proxy(byval This as ICreateTypeInfo2 ptr, byval index as UINT, byval guid as const GUID const ptr, byval pVarVal as VARIANT ptr) as HRESULT
declare sub ICreateTypeInfo2_SetVarCustData_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICreateTypeInfo2_SetImplTypeCustData_Proxy(byval This as ICreateTypeInfo2 ptr, byval index as UINT, byval guid as const GUID const ptr, byval pVarVal as VARIANT ptr) as HRESULT
declare sub ICreateTypeInfo2_SetImplTypeCustData_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICreateTypeInfo2_SetHelpStringContext_Proxy(byval This as ICreateTypeInfo2 ptr, byval dwHelpStringContext as ULONG) as HRESULT
declare sub ICreateTypeInfo2_SetHelpStringContext_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICreateTypeInfo2_SetFuncHelpStringContext_Proxy(byval This as ICreateTypeInfo2 ptr, byval index as UINT, byval dwHelpStringContext as ULONG) as HRESULT
declare sub ICreateTypeInfo2_SetFuncHelpStringContext_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICreateTypeInfo2_SetVarHelpStringContext_Proxy(byval This as ICreateTypeInfo2 ptr, byval index as UINT, byval dwHelpStringContext as ULONG) as HRESULT
declare sub ICreateTypeInfo2_SetVarHelpStringContext_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICreateTypeInfo2_Invalidate_Proxy(byval This as ICreateTypeInfo2 ptr) as HRESULT
declare sub ICreateTypeInfo2_Invalidate_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICreateTypeInfo2_SetName_Proxy(byval This as ICreateTypeInfo2 ptr, byval szName as LPOLESTR) as HRESULT
declare sub ICreateTypeInfo2_SetName_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define __ICreateTypeLib_INTERFACE_DEFINED__

type ICreateTypeLib as ICreateTypeLib_

type LPCREATETYPELIB as ICreateTypeLib ptr

extern IID_ICreateTypeLib as const GUID

type ICreateTypeLibVtbl
	QueryInterface as function(byval This as ICreateTypeLib ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ICreateTypeLib ptr) as ULONG
	Release as function(byval This as ICreateTypeLib ptr) as ULONG
	CreateTypeInfo as function(byval This as ICreateTypeLib ptr, byval szName as LPOLESTR, byval tkind as TYPEKIND, byval ppCTInfo as ICreateTypeInfo ptr ptr) as HRESULT
	SetName as function(byval This as ICreateTypeLib ptr, byval szName as LPOLESTR) as HRESULT
	SetVersion as function(byval This as ICreateTypeLib ptr, byval wMajorVerNum as WORD, byval wMinorVerNum as WORD) as HRESULT
	SetGuid as function(byval This as ICreateTypeLib ptr, byval guid as const GUID const ptr) as HRESULT
	SetDocString as function(byval This as ICreateTypeLib ptr, byval szDoc as LPOLESTR) as HRESULT
	SetHelpFileName as function(byval This as ICreateTypeLib ptr, byval szHelpFileName as LPOLESTR) as HRESULT
	SetHelpContext as function(byval This as ICreateTypeLib ptr, byval dwHelpContext as DWORD) as HRESULT
	SetLcid as function(byval This as ICreateTypeLib ptr, byval lcid as LCID) as HRESULT
	SetLibFlags as function(byval This as ICreateTypeLib ptr, byval uLibFlags as UINT) as HRESULT
	SaveAllChanges as function(byval This as ICreateTypeLib ptr) as HRESULT
end type

type ICreateTypeLib_
	lpVtbl as ICreateTypeLibVtbl ptr
end type

declare function ICreateTypeLib_CreateTypeInfo_Proxy(byval This as ICreateTypeLib ptr, byval szName as LPOLESTR, byval tkind as TYPEKIND, byval ppCTInfo as ICreateTypeInfo ptr ptr) as HRESULT
declare sub ICreateTypeLib_CreateTypeInfo_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICreateTypeLib_SetName_Proxy(byval This as ICreateTypeLib ptr, byval szName as LPOLESTR) as HRESULT
declare sub ICreateTypeLib_SetName_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICreateTypeLib_SetVersion_Proxy(byval This as ICreateTypeLib ptr, byval wMajorVerNum as WORD, byval wMinorVerNum as WORD) as HRESULT
declare sub ICreateTypeLib_SetVersion_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICreateTypeLib_SetGuid_Proxy(byval This as ICreateTypeLib ptr, byval guid as const GUID const ptr) as HRESULT
declare sub ICreateTypeLib_SetGuid_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICreateTypeLib_SetDocString_Proxy(byval This as ICreateTypeLib ptr, byval szDoc as LPOLESTR) as HRESULT
declare sub ICreateTypeLib_SetDocString_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICreateTypeLib_SetHelpFileName_Proxy(byval This as ICreateTypeLib ptr, byval szHelpFileName as LPOLESTR) as HRESULT
declare sub ICreateTypeLib_SetHelpFileName_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICreateTypeLib_SetHelpContext_Proxy(byval This as ICreateTypeLib ptr, byval dwHelpContext as DWORD) as HRESULT
declare sub ICreateTypeLib_SetHelpContext_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICreateTypeLib_SetLcid_Proxy(byval This as ICreateTypeLib ptr, byval lcid as LCID) as HRESULT
declare sub ICreateTypeLib_SetLcid_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICreateTypeLib_SetLibFlags_Proxy(byval This as ICreateTypeLib ptr, byval uLibFlags as UINT) as HRESULT
declare sub ICreateTypeLib_SetLibFlags_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICreateTypeLib_SaveAllChanges_Proxy(byval This as ICreateTypeLib ptr) as HRESULT
declare sub ICreateTypeLib_SaveAllChanges_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define __ICreateTypeLib2_INTERFACE_DEFINED__

type ICreateTypeLib2 as ICreateTypeLib2_

type LPCREATETYPELIB2 as ICreateTypeLib2 ptr

extern IID_ICreateTypeLib2 as const GUID

type ICreateTypeLib2Vtbl
	QueryInterface as function(byval This as ICreateTypeLib2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ICreateTypeLib2 ptr) as ULONG
	Release as function(byval This as ICreateTypeLib2 ptr) as ULONG
	CreateTypeInfo as function(byval This as ICreateTypeLib2 ptr, byval szName as LPOLESTR, byval tkind as TYPEKIND, byval ppCTInfo as ICreateTypeInfo ptr ptr) as HRESULT
	SetName as function(byval This as ICreateTypeLib2 ptr, byval szName as LPOLESTR) as HRESULT
	SetVersion as function(byval This as ICreateTypeLib2 ptr, byval wMajorVerNum as WORD, byval wMinorVerNum as WORD) as HRESULT
	SetGuid as function(byval This as ICreateTypeLib2 ptr, byval guid as const GUID const ptr) as HRESULT
	SetDocString as function(byval This as ICreateTypeLib2 ptr, byval szDoc as LPOLESTR) as HRESULT
	SetHelpFileName as function(byval This as ICreateTypeLib2 ptr, byval szHelpFileName as LPOLESTR) as HRESULT
	SetHelpContext as function(byval This as ICreateTypeLib2 ptr, byval dwHelpContext as DWORD) as HRESULT
	SetLcid as function(byval This as ICreateTypeLib2 ptr, byval lcid as LCID) as HRESULT
	SetLibFlags as function(byval This as ICreateTypeLib2 ptr, byval uLibFlags as UINT) as HRESULT
	SaveAllChanges as function(byval This as ICreateTypeLib2 ptr) as HRESULT
	DeleteTypeInfo as function(byval This as ICreateTypeLib2 ptr, byval szName as LPOLESTR) as HRESULT
	SetCustData as function(byval This as ICreateTypeLib2 ptr, byval guid as const GUID const ptr, byval pVarVal as VARIANT ptr) as HRESULT
	SetHelpStringContext as function(byval This as ICreateTypeLib2 ptr, byval dwHelpStringContext as ULONG) as HRESULT
	SetHelpStringDll as function(byval This as ICreateTypeLib2 ptr, byval szFileName as LPOLESTR) as HRESULT
end type

type ICreateTypeLib2_
	lpVtbl as ICreateTypeLib2Vtbl ptr
end type

declare function ICreateTypeLib2_DeleteTypeInfo_Proxy(byval This as ICreateTypeLib2 ptr, byval szName as LPOLESTR) as HRESULT
declare sub ICreateTypeLib2_DeleteTypeInfo_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICreateTypeLib2_SetCustData_Proxy(byval This as ICreateTypeLib2 ptr, byval guid as const GUID const ptr, byval pVarVal as VARIANT ptr) as HRESULT
declare sub ICreateTypeLib2_SetCustData_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICreateTypeLib2_SetHelpStringContext_Proxy(byval This as ICreateTypeLib2 ptr, byval dwHelpStringContext as ULONG) as HRESULT
declare sub ICreateTypeLib2_SetHelpStringContext_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICreateTypeLib2_SetHelpStringDll_Proxy(byval This as ICreateTypeLib2 ptr, byval szFileName as LPOLESTR) as HRESULT
declare sub ICreateTypeLib2_SetHelpStringDll_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define __IDispatch_INTERFACE_DEFINED__

type LPDISPATCH as IDispatch ptr

#define DISPID_UNKNOWN (-1)
#define DISPID_VALUE 0
#define DISPID_PROPERTYPUT (-3)
#define DISPID_NEWENUM (-4)
#define DISPID_EVALUATE (-5)
#define DISPID_CONSTRUCTOR (-6)
#define DISPID_DESTRUCTOR (-7)
#define DISPID_COLLECT (-8)

extern IID_IDispatch as const GUID

type IDispatchVtbl
	QueryInterface as function(byval This as IDispatch ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDispatch ptr) as ULONG
	Release as function(byval This as IDispatch ptr) as ULONG
	GetTypeInfoCount as function(byval This as IDispatch ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IDispatch ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IDispatch ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IDispatch ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
end type

type IDispatch_
	lpVtbl as IDispatchVtbl ptr
end type

declare function IDispatch_GetTypeInfoCount_Proxy(byval This as IDispatch ptr, byval pctinfo as UINT ptr) as HRESULT
declare sub IDispatch_GetTypeInfoCount_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDispatch_GetTypeInfo_Proxy(byval This as IDispatch ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
declare sub IDispatch_GetTypeInfo_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDispatch_GetIDsOfNames_Proxy(byval This as IDispatch ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
declare sub IDispatch_GetIDsOfNames_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDispatch_RemoteInvoke_Proxy(byval This as IDispatch ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval dwFlags as DWORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval pArgErr as UINT ptr, byval cVarRef as UINT, byval rgVarRefIdx as UINT ptr, byval rgVarRef as VARIANTARG ptr) as HRESULT
declare sub IDispatch_RemoteInvoke_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDispatch_Invoke_Proxy(byval This as IDispatch ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
declare function IDispatch_Invoke_Stub(byval This as IDispatch ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval dwFlags as DWORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval pArgErr as UINT ptr, byval cVarRef as UINT, byval rgVarRefIdx as UINT ptr, byval rgVarRef as VARIANTARG ptr) as HRESULT

#define __IEnumVARIANT_INTERFACE_DEFINED__

type IEnumVARIANT as IEnumVARIANT_

type LPENUMVARIANT as IEnumVARIANT ptr

extern IID_IEnumVARIANT as const GUID

type IEnumVARIANTVtbl
	QueryInterface as function(byval This as IEnumVARIANT ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IEnumVARIANT ptr) as ULONG
	Release as function(byval This as IEnumVARIANT ptr) as ULONG
	Next as function(byval This as IEnumVARIANT ptr, byval celt as ULONG, byval rgVar as VARIANT ptr, byval pCeltFetched as ULONG ptr) as HRESULT
	Skip as function(byval This as IEnumVARIANT ptr, byval celt as ULONG) as HRESULT
	Reset as function(byval This as IEnumVARIANT ptr) as HRESULT
	Clone as function(byval This as IEnumVARIANT ptr, byval ppEnum as IEnumVARIANT ptr ptr) as HRESULT
end type

type IEnumVARIANT_
	lpVtbl as IEnumVARIANTVtbl ptr
end type

declare function IEnumVARIANT_RemoteNext_Proxy(byval This as IEnumVARIANT ptr, byval celt as ULONG, byval rgVar as VARIANT ptr, byval pCeltFetched as ULONG ptr) as HRESULT
declare sub IEnumVARIANT_RemoteNext_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumVARIANT_Skip_Proxy(byval This as IEnumVARIANT ptr, byval celt as ULONG) as HRESULT
declare sub IEnumVARIANT_Skip_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumVARIANT_Reset_Proxy(byval This as IEnumVARIANT ptr) as HRESULT
declare sub IEnumVARIANT_Reset_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumVARIANT_Clone_Proxy(byval This as IEnumVARIANT ptr, byval ppEnum as IEnumVARIANT ptr ptr) as HRESULT
declare sub IEnumVARIANT_Clone_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumVARIANT_Next_Proxy(byval This as IEnumVARIANT ptr, byval celt as ULONG, byval rgVar as VARIANT ptr, byval pCeltFetched as ULONG ptr) as HRESULT
declare function IEnumVARIANT_Next_Stub(byval This as IEnumVARIANT ptr, byval celt as ULONG, byval rgVar as VARIANT ptr, byval pCeltFetched as ULONG ptr) as HRESULT

#define __ITypeComp_INTERFACE_DEFINED__

type ITypeComp as ITypeComp_

type LPTYPECOMP as ITypeComp ptr

type tagDESCKIND as long
enum
	DESCKIND_NONE = 0
	DESCKIND_FUNCDESC = 1
	DESCKIND_VARDESC = 2
	DESCKIND_TYPECOMP = 3
	DESCKIND_IMPLICITAPPOBJ = 4
	DESCKIND_MAX = 5
end enum

type DESCKIND as tagDESCKIND

union tagBINDPTR
	lpfuncdesc as FUNCDESC ptr
	lpvardesc as VARDESC ptr
	lptcomp as ITypeComp ptr
end union

type BINDPTR as tagBINDPTR
type LPBINDPTR as tagBINDPTR ptr

extern IID_ITypeComp as const GUID

type ITypeCompVtbl
	QueryInterface as function(byval This as ITypeComp ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ITypeComp ptr) as ULONG
	Release as function(byval This as ITypeComp ptr) as ULONG
	Bind as function(byval This as ITypeComp ptr, byval szName as LPOLESTR, byval lHashVal as ULONG, byval wFlags as WORD, byval ppTInfo as ITypeInfo ptr ptr, byval pDescKind as DESCKIND ptr, byval pBindPtr as BINDPTR ptr) as HRESULT
	BindType as function(byval This as ITypeComp ptr, byval szName as LPOLESTR, byval lHashVal as ULONG, byval ppTInfo as ITypeInfo ptr ptr, byval ppTComp as ITypeComp ptr ptr) as HRESULT
end type

type ITypeComp_
	lpVtbl as ITypeCompVtbl ptr
end type

declare function ITypeComp_RemoteBind_Proxy(byval This as ITypeComp ptr, byval szName as LPOLESTR, byval lHashVal as ULONG, byval wFlags as WORD, byval ppTInfo as ITypeInfo ptr ptr, byval pDescKind as DESCKIND ptr, byval ppFuncDesc as LPFUNCDESC ptr, byval ppVarDesc as LPVARDESC ptr, byval ppTypeComp as ITypeComp ptr ptr, byval pDummy as CLEANLOCALSTORAGE ptr) as HRESULT
declare sub ITypeComp_RemoteBind_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITypeComp_RemoteBindType_Proxy(byval This as ITypeComp ptr, byval szName as LPOLESTR, byval lHashVal as ULONG, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
declare sub ITypeComp_RemoteBindType_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITypeComp_Bind_Proxy(byval This as ITypeComp ptr, byval szName as LPOLESTR, byval lHashVal as ULONG, byval wFlags as WORD, byval ppTInfo as ITypeInfo ptr ptr, byval pDescKind as DESCKIND ptr, byval pBindPtr as BINDPTR ptr) as HRESULT
declare function ITypeComp_Bind_Stub(byval This as ITypeComp ptr, byval szName as LPOLESTR, byval lHashVal as ULONG, byval wFlags as WORD, byval ppTInfo as ITypeInfo ptr ptr, byval pDescKind as DESCKIND ptr, byval ppFuncDesc as LPFUNCDESC ptr, byval ppVarDesc as LPVARDESC ptr, byval ppTypeComp as ITypeComp ptr ptr, byval pDummy as CLEANLOCALSTORAGE ptr) as HRESULT
declare function ITypeComp_BindType_Proxy(byval This as ITypeComp ptr, byval szName as LPOLESTR, byval lHashVal as ULONG, byval ppTInfo as ITypeInfo ptr ptr, byval ppTComp as ITypeComp ptr ptr) as HRESULT
declare function ITypeComp_BindType_Stub(byval This as ITypeComp ptr, byval szName as LPOLESTR, byval lHashVal as ULONG, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT

#define __ITypeInfo_INTERFACE_DEFINED__

type LPTYPEINFO as ITypeInfo ptr

extern IID_ITypeInfo as const GUID

type ITypeLib as ITypeLib_

type ITypeInfoVtbl
	QueryInterface as function(byval This as ITypeInfo ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ITypeInfo ptr) as ULONG
	Release as function(byval This as ITypeInfo ptr) as ULONG
	GetTypeAttr as function(byval This as ITypeInfo ptr, byval ppTypeAttr as TYPEATTR ptr ptr) as HRESULT
	GetTypeComp as function(byval This as ITypeInfo ptr, byval ppTComp as ITypeComp ptr ptr) as HRESULT
	GetFuncDesc as function(byval This as ITypeInfo ptr, byval index as UINT, byval ppFuncDesc as FUNCDESC ptr ptr) as HRESULT
	GetVarDesc as function(byval This as ITypeInfo ptr, byval index as UINT, byval ppVarDesc as VARDESC ptr ptr) as HRESULT
	GetNames as function(byval This as ITypeInfo ptr, byval memid as MEMBERID, byval rgBstrNames as BSTR ptr, byval cMaxNames as UINT, byval pcNames as UINT ptr) as HRESULT
	GetRefTypeOfImplType as function(byval This as ITypeInfo ptr, byval index as UINT, byval pRefType as HREFTYPE ptr) as HRESULT
	GetImplTypeFlags as function(byval This as ITypeInfo ptr, byval index as UINT, byval pImplTypeFlags as INT_ ptr) as HRESULT
	GetIDsOfNames as function(byval This as ITypeInfo ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval pMemId as MEMBERID ptr) as HRESULT
	Invoke as function(byval This as ITypeInfo ptr, byval pvInstance as PVOID, byval memid as MEMBERID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	GetDocumentation as function(byval This as ITypeInfo ptr, byval memid as MEMBERID, byval pBstrName as BSTR ptr, byval pBstrDocString as BSTR ptr, byval pdwHelpContext as DWORD ptr, byval pBstrHelpFile as BSTR ptr) as HRESULT
	GetDllEntry as function(byval This as ITypeInfo ptr, byval memid as MEMBERID, byval invKind as INVOKEKIND, byval pBstrDllName as BSTR ptr, byval pBstrName as BSTR ptr, byval pwOrdinal as WORD ptr) as HRESULT
	GetRefTypeInfo as function(byval This as ITypeInfo ptr, byval hRefType as HREFTYPE, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	AddressOfMember as function(byval This as ITypeInfo ptr, byval memid as MEMBERID, byval invKind as INVOKEKIND, byval ppv as PVOID ptr) as HRESULT
	CreateInstance as function(byval This as ITypeInfo ptr, byval pUnkOuter as IUnknown ptr, byval riid as const IID const ptr, byval ppvObj as PVOID ptr) as HRESULT
	GetMops as function(byval This as ITypeInfo ptr, byval memid as MEMBERID, byval pBstrMops as BSTR ptr) as HRESULT
	GetContainingTypeLib as function(byval This as ITypeInfo ptr, byval ppTLib as ITypeLib ptr ptr, byval pIndex as UINT ptr) as HRESULT
	ReleaseTypeAttr as sub(byval This as ITypeInfo ptr, byval pTypeAttr as TYPEATTR ptr)
	ReleaseFuncDesc as sub(byval This as ITypeInfo ptr, byval pFuncDesc as FUNCDESC ptr)
	ReleaseVarDesc as sub(byval This as ITypeInfo ptr, byval pVarDesc as VARDESC ptr)
end type

type ITypeInfo_
	lpVtbl as ITypeInfoVtbl ptr
end type

declare function ITypeInfo_RemoteGetTypeAttr_Proxy(byval This as ITypeInfo ptr, byval ppTypeAttr as LPTYPEATTR ptr, byval pDummy as CLEANLOCALSTORAGE ptr) as HRESULT
declare sub ITypeInfo_RemoteGetTypeAttr_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITypeInfo_GetTypeComp_Proxy(byval This as ITypeInfo ptr, byval ppTComp as ITypeComp ptr ptr) as HRESULT
declare sub ITypeInfo_GetTypeComp_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITypeInfo_RemoteGetFuncDesc_Proxy(byval This as ITypeInfo ptr, byval index as UINT, byval ppFuncDesc as LPFUNCDESC ptr, byval pDummy as CLEANLOCALSTORAGE ptr) as HRESULT
declare sub ITypeInfo_RemoteGetFuncDesc_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITypeInfo_RemoteGetVarDesc_Proxy(byval This as ITypeInfo ptr, byval index as UINT, byval ppVarDesc as LPVARDESC ptr, byval pDummy as CLEANLOCALSTORAGE ptr) as HRESULT
declare sub ITypeInfo_RemoteGetVarDesc_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITypeInfo_RemoteGetNames_Proxy(byval This as ITypeInfo ptr, byval memid as MEMBERID, byval rgBstrNames as BSTR ptr, byval cMaxNames as UINT, byval pcNames as UINT ptr) as HRESULT
declare sub ITypeInfo_RemoteGetNames_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITypeInfo_GetRefTypeOfImplType_Proxy(byval This as ITypeInfo ptr, byval index as UINT, byval pRefType as HREFTYPE ptr) as HRESULT
declare sub ITypeInfo_GetRefTypeOfImplType_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITypeInfo_GetImplTypeFlags_Proxy(byval This as ITypeInfo ptr, byval index as UINT, byval pImplTypeFlags as INT_ ptr) as HRESULT
declare sub ITypeInfo_GetImplTypeFlags_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITypeInfo_LocalGetIDsOfNames_Proxy(byval This as ITypeInfo ptr) as HRESULT
declare sub ITypeInfo_LocalGetIDsOfNames_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITypeInfo_LocalInvoke_Proxy(byval This as ITypeInfo ptr) as HRESULT
declare sub ITypeInfo_LocalInvoke_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITypeInfo_RemoteGetDocumentation_Proxy(byval This as ITypeInfo ptr, byval memid as MEMBERID, byval refPtrFlags as DWORD, byval pBstrName as BSTR ptr, byval pBstrDocString as BSTR ptr, byval pdwHelpContext as DWORD ptr, byval pBstrHelpFile as BSTR ptr) as HRESULT
declare sub ITypeInfo_RemoteGetDocumentation_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITypeInfo_RemoteGetDllEntry_Proxy(byval This as ITypeInfo ptr, byval memid as MEMBERID, byval invKind as INVOKEKIND, byval refPtrFlags as DWORD, byval pBstrDllName as BSTR ptr, byval pBstrName as BSTR ptr, byval pwOrdinal as WORD ptr) as HRESULT
declare sub ITypeInfo_RemoteGetDllEntry_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITypeInfo_GetRefTypeInfo_Proxy(byval This as ITypeInfo ptr, byval hRefType as HREFTYPE, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
declare sub ITypeInfo_GetRefTypeInfo_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITypeInfo_LocalAddressOfMember_Proxy(byval This as ITypeInfo ptr) as HRESULT
declare sub ITypeInfo_LocalAddressOfMember_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITypeInfo_RemoteCreateInstance_Proxy(byval This as ITypeInfo ptr, byval riid as const IID const ptr, byval ppvObj as IUnknown ptr ptr) as HRESULT
declare sub ITypeInfo_RemoteCreateInstance_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITypeInfo_GetMops_Proxy(byval This as ITypeInfo ptr, byval memid as MEMBERID, byval pBstrMops as BSTR ptr) as HRESULT
declare sub ITypeInfo_GetMops_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITypeInfo_RemoteGetContainingTypeLib_Proxy(byval This as ITypeInfo ptr, byval ppTLib as ITypeLib ptr ptr, byval pIndex as UINT ptr) as HRESULT
declare sub ITypeInfo_RemoteGetContainingTypeLib_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITypeInfo_LocalReleaseTypeAttr_Proxy(byval This as ITypeInfo ptr) as HRESULT
declare sub ITypeInfo_LocalReleaseTypeAttr_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITypeInfo_LocalReleaseFuncDesc_Proxy(byval This as ITypeInfo ptr) as HRESULT
declare sub ITypeInfo_LocalReleaseFuncDesc_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITypeInfo_LocalReleaseVarDesc_Proxy(byval This as ITypeInfo ptr) as HRESULT
declare sub ITypeInfo_LocalReleaseVarDesc_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITypeInfo_GetTypeAttr_Proxy(byval This as ITypeInfo ptr, byval ppTypeAttr as TYPEATTR ptr ptr) as HRESULT
declare function ITypeInfo_GetTypeAttr_Stub(byval This as ITypeInfo ptr, byval ppTypeAttr as LPTYPEATTR ptr, byval pDummy as CLEANLOCALSTORAGE ptr) as HRESULT
declare function ITypeInfo_GetFuncDesc_Proxy(byval This as ITypeInfo ptr, byval index as UINT, byval ppFuncDesc as FUNCDESC ptr ptr) as HRESULT
declare function ITypeInfo_GetFuncDesc_Stub(byval This as ITypeInfo ptr, byval index as UINT, byval ppFuncDesc as LPFUNCDESC ptr, byval pDummy as CLEANLOCALSTORAGE ptr) as HRESULT
declare function ITypeInfo_GetVarDesc_Proxy(byval This as ITypeInfo ptr, byval index as UINT, byval ppVarDesc as VARDESC ptr ptr) as HRESULT
declare function ITypeInfo_GetVarDesc_Stub(byval This as ITypeInfo ptr, byval index as UINT, byval ppVarDesc as LPVARDESC ptr, byval pDummy as CLEANLOCALSTORAGE ptr) as HRESULT
declare function ITypeInfo_GetNames_Proxy(byval This as ITypeInfo ptr, byval memid as MEMBERID, byval rgBstrNames as BSTR ptr, byval cMaxNames as UINT, byval pcNames as UINT ptr) as HRESULT
declare function ITypeInfo_GetNames_Stub(byval This as ITypeInfo ptr, byval memid as MEMBERID, byval rgBstrNames as BSTR ptr, byval cMaxNames as UINT, byval pcNames as UINT ptr) as HRESULT
declare function ITypeInfo_GetIDsOfNames_Proxy(byval This as ITypeInfo ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval pMemId as MEMBERID ptr) as HRESULT
declare function ITypeInfo_GetIDsOfNames_Stub(byval This as ITypeInfo ptr) as HRESULT
declare function ITypeInfo_Invoke_Proxy(byval This as ITypeInfo ptr, byval pvInstance as PVOID, byval memid as MEMBERID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
declare function ITypeInfo_Invoke_Stub(byval This as ITypeInfo ptr) as HRESULT
declare function ITypeInfo_GetDocumentation_Proxy(byval This as ITypeInfo ptr, byval memid as MEMBERID, byval pBstrName as BSTR ptr, byval pBstrDocString as BSTR ptr, byval pdwHelpContext as DWORD ptr, byval pBstrHelpFile as BSTR ptr) as HRESULT
declare function ITypeInfo_GetDocumentation_Stub(byval This as ITypeInfo ptr, byval memid as MEMBERID, byval refPtrFlags as DWORD, byval pBstrName as BSTR ptr, byval pBstrDocString as BSTR ptr, byval pdwHelpContext as DWORD ptr, byval pBstrHelpFile as BSTR ptr) as HRESULT
declare function ITypeInfo_GetDllEntry_Proxy(byval This as ITypeInfo ptr, byval memid as MEMBERID, byval invKind as INVOKEKIND, byval pBstrDllName as BSTR ptr, byval pBstrName as BSTR ptr, byval pwOrdinal as WORD ptr) as HRESULT
declare function ITypeInfo_GetDllEntry_Stub(byval This as ITypeInfo ptr, byval memid as MEMBERID, byval invKind as INVOKEKIND, byval refPtrFlags as DWORD, byval pBstrDllName as BSTR ptr, byval pBstrName as BSTR ptr, byval pwOrdinal as WORD ptr) as HRESULT
declare function ITypeInfo_AddressOfMember_Proxy(byval This as ITypeInfo ptr, byval memid as MEMBERID, byval invKind as INVOKEKIND, byval ppv as PVOID ptr) as HRESULT
declare function ITypeInfo_AddressOfMember_Stub(byval This as ITypeInfo ptr) as HRESULT
declare function ITypeInfo_CreateInstance_Proxy(byval This as ITypeInfo ptr, byval pUnkOuter as IUnknown ptr, byval riid as const IID const ptr, byval ppvObj as PVOID ptr) as HRESULT
declare function ITypeInfo_CreateInstance_Stub(byval This as ITypeInfo ptr, byval riid as const IID const ptr, byval ppvObj as IUnknown ptr ptr) as HRESULT
declare function ITypeInfo_GetContainingTypeLib_Proxy(byval This as ITypeInfo ptr, byval ppTLib as ITypeLib ptr ptr, byval pIndex as UINT ptr) as HRESULT
declare function ITypeInfo_GetContainingTypeLib_Stub(byval This as ITypeInfo ptr, byval ppTLib as ITypeLib ptr ptr, byval pIndex as UINT ptr) as HRESULT
declare sub ITypeInfo_ReleaseTypeAttr_Proxy(byval This as ITypeInfo ptr, byval pTypeAttr as TYPEATTR ptr)
declare function ITypeInfo_ReleaseTypeAttr_Stub(byval This as ITypeInfo ptr) as HRESULT
declare sub ITypeInfo_ReleaseFuncDesc_Proxy(byval This as ITypeInfo ptr, byval pFuncDesc as FUNCDESC ptr)
declare function ITypeInfo_ReleaseFuncDesc_Stub(byval This as ITypeInfo ptr) as HRESULT
declare sub ITypeInfo_ReleaseVarDesc_Proxy(byval This as ITypeInfo ptr, byval pVarDesc as VARDESC ptr)
declare function ITypeInfo_ReleaseVarDesc_Stub(byval This as ITypeInfo ptr) as HRESULT

#define __ITypeInfo2_INTERFACE_DEFINED__

type ITypeInfo2 as ITypeInfo2_

type LPTYPEINFO2 as ITypeInfo2 ptr

extern IID_ITypeInfo2 as const GUID

type ITypeInfo2Vtbl
	QueryInterface as function(byval This as ITypeInfo2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ITypeInfo2 ptr) as ULONG
	Release as function(byval This as ITypeInfo2 ptr) as ULONG
	GetTypeAttr as function(byval This as ITypeInfo2 ptr, byval ppTypeAttr as TYPEATTR ptr ptr) as HRESULT
	GetTypeComp as function(byval This as ITypeInfo2 ptr, byval ppTComp as ITypeComp ptr ptr) as HRESULT
	GetFuncDesc as function(byval This as ITypeInfo2 ptr, byval index as UINT, byval ppFuncDesc as FUNCDESC ptr ptr) as HRESULT
	GetVarDesc as function(byval This as ITypeInfo2 ptr, byval index as UINT, byval ppVarDesc as VARDESC ptr ptr) as HRESULT
	GetNames as function(byval This as ITypeInfo2 ptr, byval memid as MEMBERID, byval rgBstrNames as BSTR ptr, byval cMaxNames as UINT, byval pcNames as UINT ptr) as HRESULT
	GetRefTypeOfImplType as function(byval This as ITypeInfo2 ptr, byval index as UINT, byval pRefType as HREFTYPE ptr) as HRESULT
	GetImplTypeFlags as function(byval This as ITypeInfo2 ptr, byval index as UINT, byval pImplTypeFlags as INT_ ptr) as HRESULT
	GetIDsOfNames as function(byval This as ITypeInfo2 ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval pMemId as MEMBERID ptr) as HRESULT
	Invoke as function(byval This as ITypeInfo2 ptr, byval pvInstance as PVOID, byval memid as MEMBERID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	GetDocumentation as function(byval This as ITypeInfo2 ptr, byval memid as MEMBERID, byval pBstrName as BSTR ptr, byval pBstrDocString as BSTR ptr, byval pdwHelpContext as DWORD ptr, byval pBstrHelpFile as BSTR ptr) as HRESULT
	GetDllEntry as function(byval This as ITypeInfo2 ptr, byval memid as MEMBERID, byval invKind as INVOKEKIND, byval pBstrDllName as BSTR ptr, byval pBstrName as BSTR ptr, byval pwOrdinal as WORD ptr) as HRESULT
	GetRefTypeInfo as function(byval This as ITypeInfo2 ptr, byval hRefType as HREFTYPE, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	AddressOfMember as function(byval This as ITypeInfo2 ptr, byval memid as MEMBERID, byval invKind as INVOKEKIND, byval ppv as PVOID ptr) as HRESULT
	CreateInstance as function(byval This as ITypeInfo2 ptr, byval pUnkOuter as IUnknown ptr, byval riid as const IID const ptr, byval ppvObj as PVOID ptr) as HRESULT
	GetMops as function(byval This as ITypeInfo2 ptr, byval memid as MEMBERID, byval pBstrMops as BSTR ptr) as HRESULT
	GetContainingTypeLib as function(byval This as ITypeInfo2 ptr, byval ppTLib as ITypeLib ptr ptr, byval pIndex as UINT ptr) as HRESULT
	ReleaseTypeAttr as sub(byval This as ITypeInfo2 ptr, byval pTypeAttr as TYPEATTR ptr)
	ReleaseFuncDesc as sub(byval This as ITypeInfo2 ptr, byval pFuncDesc as FUNCDESC ptr)
	ReleaseVarDesc as sub(byval This as ITypeInfo2 ptr, byval pVarDesc as VARDESC ptr)
	GetTypeKind as function(byval This as ITypeInfo2 ptr, byval pTypeKind as TYPEKIND ptr) as HRESULT
	GetTypeFlags as function(byval This as ITypeInfo2 ptr, byval pTypeFlags as ULONG ptr) as HRESULT
	GetFuncIndexOfMemId as function(byval This as ITypeInfo2 ptr, byval memid as MEMBERID, byval invKind as INVOKEKIND, byval pFuncIndex as UINT ptr) as HRESULT
	GetVarIndexOfMemId as function(byval This as ITypeInfo2 ptr, byval memid as MEMBERID, byval pVarIndex as UINT ptr) as HRESULT
	GetCustData as function(byval This as ITypeInfo2 ptr, byval guid as const GUID const ptr, byval pVarVal as VARIANT ptr) as HRESULT
	GetFuncCustData as function(byval This as ITypeInfo2 ptr, byval index as UINT, byval guid as const GUID const ptr, byval pVarVal as VARIANT ptr) as HRESULT
	GetParamCustData as function(byval This as ITypeInfo2 ptr, byval indexFunc as UINT, byval indexParam as UINT, byval guid as const GUID const ptr, byval pVarVal as VARIANT ptr) as HRESULT
	GetVarCustData as function(byval This as ITypeInfo2 ptr, byval index as UINT, byval guid as const GUID const ptr, byval pVarVal as VARIANT ptr) as HRESULT
	GetImplTypeCustData as function(byval This as ITypeInfo2 ptr, byval index as UINT, byval guid as const GUID const ptr, byval pVarVal as VARIANT ptr) as HRESULT
	GetDocumentation2 as function(byval This as ITypeInfo2 ptr, byval memid as MEMBERID, byval lcid as LCID, byval pbstrHelpString as BSTR ptr, byval pdwHelpStringContext as DWORD ptr, byval pbstrHelpStringDll as BSTR ptr) as HRESULT
	GetAllCustData as function(byval This as ITypeInfo2 ptr, byval pCustData as CUSTDATA ptr) as HRESULT
	GetAllFuncCustData as function(byval This as ITypeInfo2 ptr, byval index as UINT, byval pCustData as CUSTDATA ptr) as HRESULT
	GetAllParamCustData as function(byval This as ITypeInfo2 ptr, byval indexFunc as UINT, byval indexParam as UINT, byval pCustData as CUSTDATA ptr) as HRESULT
	GetAllVarCustData as function(byval This as ITypeInfo2 ptr, byval index as UINT, byval pCustData as CUSTDATA ptr) as HRESULT
	GetAllImplTypeCustData as function(byval This as ITypeInfo2 ptr, byval index as UINT, byval pCustData as CUSTDATA ptr) as HRESULT
end type

type ITypeInfo2_
	lpVtbl as ITypeInfo2Vtbl ptr
end type

declare function ITypeInfo2_GetTypeKind_Proxy(byval This as ITypeInfo2 ptr, byval pTypeKind as TYPEKIND ptr) as HRESULT
declare sub ITypeInfo2_GetTypeKind_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITypeInfo2_GetTypeFlags_Proxy(byval This as ITypeInfo2 ptr, byval pTypeFlags as ULONG ptr) as HRESULT
declare sub ITypeInfo2_GetTypeFlags_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITypeInfo2_GetFuncIndexOfMemId_Proxy(byval This as ITypeInfo2 ptr, byval memid as MEMBERID, byval invKind as INVOKEKIND, byval pFuncIndex as UINT ptr) as HRESULT
declare sub ITypeInfo2_GetFuncIndexOfMemId_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITypeInfo2_GetVarIndexOfMemId_Proxy(byval This as ITypeInfo2 ptr, byval memid as MEMBERID, byval pVarIndex as UINT ptr) as HRESULT
declare sub ITypeInfo2_GetVarIndexOfMemId_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITypeInfo2_GetCustData_Proxy(byval This as ITypeInfo2 ptr, byval guid as const GUID const ptr, byval pVarVal as VARIANT ptr) as HRESULT
declare sub ITypeInfo2_GetCustData_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITypeInfo2_GetFuncCustData_Proxy(byval This as ITypeInfo2 ptr, byval index as UINT, byval guid as const GUID const ptr, byval pVarVal as VARIANT ptr) as HRESULT
declare sub ITypeInfo2_GetFuncCustData_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITypeInfo2_GetParamCustData_Proxy(byval This as ITypeInfo2 ptr, byval indexFunc as UINT, byval indexParam as UINT, byval guid as const GUID const ptr, byval pVarVal as VARIANT ptr) as HRESULT
declare sub ITypeInfo2_GetParamCustData_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITypeInfo2_GetVarCustData_Proxy(byval This as ITypeInfo2 ptr, byval index as UINT, byval guid as const GUID const ptr, byval pVarVal as VARIANT ptr) as HRESULT
declare sub ITypeInfo2_GetVarCustData_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITypeInfo2_GetImplTypeCustData_Proxy(byval This as ITypeInfo2 ptr, byval index as UINT, byval guid as const GUID const ptr, byval pVarVal as VARIANT ptr) as HRESULT
declare sub ITypeInfo2_GetImplTypeCustData_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITypeInfo2_RemoteGetDocumentation2_Proxy(byval This as ITypeInfo2 ptr, byval memid as MEMBERID, byval lcid as LCID, byval refPtrFlags as DWORD, byval pbstrHelpString as BSTR ptr, byval pdwHelpStringContext as DWORD ptr, byval pbstrHelpStringDll as BSTR ptr) as HRESULT
declare sub ITypeInfo2_RemoteGetDocumentation2_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITypeInfo2_GetAllCustData_Proxy(byval This as ITypeInfo2 ptr, byval pCustData as CUSTDATA ptr) as HRESULT
declare sub ITypeInfo2_GetAllCustData_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITypeInfo2_GetAllFuncCustData_Proxy(byval This as ITypeInfo2 ptr, byval index as UINT, byval pCustData as CUSTDATA ptr) as HRESULT
declare sub ITypeInfo2_GetAllFuncCustData_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITypeInfo2_GetAllParamCustData_Proxy(byval This as ITypeInfo2 ptr, byval indexFunc as UINT, byval indexParam as UINT, byval pCustData as CUSTDATA ptr) as HRESULT
declare sub ITypeInfo2_GetAllParamCustData_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITypeInfo2_GetAllVarCustData_Proxy(byval This as ITypeInfo2 ptr, byval index as UINT, byval pCustData as CUSTDATA ptr) as HRESULT
declare sub ITypeInfo2_GetAllVarCustData_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITypeInfo2_GetAllImplTypeCustData_Proxy(byval This as ITypeInfo2 ptr, byval index as UINT, byval pCustData as CUSTDATA ptr) as HRESULT
declare sub ITypeInfo2_GetAllImplTypeCustData_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITypeInfo2_GetDocumentation2_Proxy(byval This as ITypeInfo2 ptr, byval memid as MEMBERID, byval lcid as LCID, byval pbstrHelpString as BSTR ptr, byval pdwHelpStringContext as DWORD ptr, byval pbstrHelpStringDll as BSTR ptr) as HRESULT
declare function ITypeInfo2_GetDocumentation2_Stub(byval This as ITypeInfo2 ptr, byval memid as MEMBERID, byval lcid as LCID, byval refPtrFlags as DWORD, byval pbstrHelpString as BSTR ptr, byval pdwHelpStringContext as DWORD ptr, byval pbstrHelpStringDll as BSTR ptr) as HRESULT

#define __ITypeLib_INTERFACE_DEFINED__

type tagSYSKIND as long
enum
	SYS_WIN16 = 0
	SYS_WIN32 = 1
	SYS_MAC = 2
	SYS_WIN64 = 3
end enum

type SYSKIND as tagSYSKIND

type tagLIBFLAGS as long
enum
	LIBFLAG_FRESTRICTED = &h1
	LIBFLAG_FCONTROL = &h2
	LIBFLAG_FHIDDEN = &h4
	LIBFLAG_FHASDISKIMAGE = &h8
end enum

type LIBFLAGS as tagLIBFLAGS
type LPTYPELIB as ITypeLib ptr

type tagTLIBATTR
	guid as GUID
	lcid as LCID
	syskind as SYSKIND
	wMajorVerNum as WORD
	wMinorVerNum as WORD
	wLibFlags as WORD
end type

type TLIBATTR as tagTLIBATTR
type LPTLIBATTR as tagTLIBATTR ptr

extern IID_ITypeLib as const GUID

type ITypeLibVtbl
	QueryInterface as function(byval This as ITypeLib ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ITypeLib ptr) as ULONG
	Release as function(byval This as ITypeLib ptr) as ULONG
	GetTypeInfoCount as function(byval This as ITypeLib ptr) as UINT
	GetTypeInfo as function(byval This as ITypeLib ptr, byval index as UINT, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetTypeInfoType as function(byval This as ITypeLib ptr, byval index as UINT, byval pTKind as TYPEKIND ptr) as HRESULT
	GetTypeInfoOfGuid as function(byval This as ITypeLib ptr, byval guid as const GUID const ptr, byval ppTinfo as ITypeInfo ptr ptr) as HRESULT
	GetLibAttr as function(byval This as ITypeLib ptr, byval ppTLibAttr as TLIBATTR ptr ptr) as HRESULT
	GetTypeComp as function(byval This as ITypeLib ptr, byval ppTComp as ITypeComp ptr ptr) as HRESULT
	GetDocumentation as function(byval This as ITypeLib ptr, byval index as INT_, byval pBstrName as BSTR ptr, byval pBstrDocString as BSTR ptr, byval pdwHelpContext as DWORD ptr, byval pBstrHelpFile as BSTR ptr) as HRESULT
	IsName as function(byval This as ITypeLib ptr, byval szNameBuf as LPOLESTR, byval lHashVal as ULONG, byval pfName as WINBOOL ptr) as HRESULT
	FindName as function(byval This as ITypeLib ptr, byval szNameBuf as LPOLESTR, byval lHashVal as ULONG, byval ppTInfo as ITypeInfo ptr ptr, byval rgMemId as MEMBERID ptr, byval pcFound as USHORT ptr) as HRESULT
	ReleaseTLibAttr as sub(byval This as ITypeLib ptr, byval pTLibAttr as TLIBATTR ptr)
end type

type ITypeLib_
	lpVtbl as ITypeLibVtbl ptr
end type

declare function ITypeLib_RemoteGetTypeInfoCount_Proxy(byval This as ITypeLib ptr, byval pcTInfo as UINT ptr) as HRESULT
declare sub ITypeLib_RemoteGetTypeInfoCount_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITypeLib_GetTypeInfo_Proxy(byval This as ITypeLib ptr, byval index as UINT, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
declare sub ITypeLib_GetTypeInfo_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITypeLib_GetTypeInfoType_Proxy(byval This as ITypeLib ptr, byval index as UINT, byval pTKind as TYPEKIND ptr) as HRESULT
declare sub ITypeLib_GetTypeInfoType_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITypeLib_GetTypeInfoOfGuid_Proxy(byval This as ITypeLib ptr, byval guid as const GUID const ptr, byval ppTinfo as ITypeInfo ptr ptr) as HRESULT
declare sub ITypeLib_GetTypeInfoOfGuid_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITypeLib_RemoteGetLibAttr_Proxy(byval This as ITypeLib ptr, byval ppTLibAttr as LPTLIBATTR ptr, byval pDummy as CLEANLOCALSTORAGE ptr) as HRESULT
declare sub ITypeLib_RemoteGetLibAttr_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITypeLib_GetTypeComp_Proxy(byval This as ITypeLib ptr, byval ppTComp as ITypeComp ptr ptr) as HRESULT
declare sub ITypeLib_GetTypeComp_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITypeLib_RemoteGetDocumentation_Proxy(byval This as ITypeLib ptr, byval index as INT_, byval refPtrFlags as DWORD, byval pBstrName as BSTR ptr, byval pBstrDocString as BSTR ptr, byval pdwHelpContext as DWORD ptr, byval pBstrHelpFile as BSTR ptr) as HRESULT
declare sub ITypeLib_RemoteGetDocumentation_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITypeLib_RemoteIsName_Proxy(byval This as ITypeLib ptr, byval szNameBuf as LPOLESTR, byval lHashVal as ULONG, byval pfName as WINBOOL ptr, byval pBstrLibName as BSTR ptr) as HRESULT
declare sub ITypeLib_RemoteIsName_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITypeLib_RemoteFindName_Proxy(byval This as ITypeLib ptr, byval szNameBuf as LPOLESTR, byval lHashVal as ULONG, byval ppTInfo as ITypeInfo ptr ptr, byval rgMemId as MEMBERID ptr, byval pcFound as USHORT ptr, byval pBstrLibName as BSTR ptr) as HRESULT
declare sub ITypeLib_RemoteFindName_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITypeLib_LocalReleaseTLibAttr_Proxy(byval This as ITypeLib ptr) as HRESULT
declare sub ITypeLib_LocalReleaseTLibAttr_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITypeLib_GetTypeInfoCount_Proxy(byval This as ITypeLib ptr) as UINT
declare function ITypeLib_GetTypeInfoCount_Stub(byval This as ITypeLib ptr, byval pcTInfo as UINT ptr) as HRESULT
declare function ITypeLib_GetLibAttr_Proxy(byval This as ITypeLib ptr, byval ppTLibAttr as TLIBATTR ptr ptr) as HRESULT
declare function ITypeLib_GetLibAttr_Stub(byval This as ITypeLib ptr, byval ppTLibAttr as LPTLIBATTR ptr, byval pDummy as CLEANLOCALSTORAGE ptr) as HRESULT
declare function ITypeLib_GetDocumentation_Proxy(byval This as ITypeLib ptr, byval index as INT_, byval pBstrName as BSTR ptr, byval pBstrDocString as BSTR ptr, byval pdwHelpContext as DWORD ptr, byval pBstrHelpFile as BSTR ptr) as HRESULT
declare function ITypeLib_GetDocumentation_Stub(byval This as ITypeLib ptr, byval index as INT_, byval refPtrFlags as DWORD, byval pBstrName as BSTR ptr, byval pBstrDocString as BSTR ptr, byval pdwHelpContext as DWORD ptr, byval pBstrHelpFile as BSTR ptr) as HRESULT
declare function ITypeLib_IsName_Proxy(byval This as ITypeLib ptr, byval szNameBuf as LPOLESTR, byval lHashVal as ULONG, byval pfName as WINBOOL ptr) as HRESULT
declare function ITypeLib_IsName_Stub(byval This as ITypeLib ptr, byval szNameBuf as LPOLESTR, byval lHashVal as ULONG, byval pfName as WINBOOL ptr, byval pBstrLibName as BSTR ptr) as HRESULT
declare function ITypeLib_FindName_Proxy(byval This as ITypeLib ptr, byval szNameBuf as LPOLESTR, byval lHashVal as ULONG, byval ppTInfo as ITypeInfo ptr ptr, byval rgMemId as MEMBERID ptr, byval pcFound as USHORT ptr) as HRESULT
declare function ITypeLib_FindName_Stub(byval This as ITypeLib ptr, byval szNameBuf as LPOLESTR, byval lHashVal as ULONG, byval ppTInfo as ITypeInfo ptr ptr, byval rgMemId as MEMBERID ptr, byval pcFound as USHORT ptr, byval pBstrLibName as BSTR ptr) as HRESULT
declare sub ITypeLib_ReleaseTLibAttr_Proxy(byval This as ITypeLib ptr, byval pTLibAttr as TLIBATTR ptr)
declare function ITypeLib_ReleaseTLibAttr_Stub(byval This as ITypeLib ptr) as HRESULT

#define __ITypeLib2_INTERFACE_DEFINED__

type ITypeLib2 as ITypeLib2_

type LPTYPELIB2 as ITypeLib2 ptr

extern IID_ITypeLib2 as const GUID

type ITypeLib2Vtbl
	QueryInterface as function(byval This as ITypeLib2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ITypeLib2 ptr) as ULONG
	Release as function(byval This as ITypeLib2 ptr) as ULONG
	GetTypeInfoCount as function(byval This as ITypeLib2 ptr) as UINT
	GetTypeInfo as function(byval This as ITypeLib2 ptr, byval index as UINT, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetTypeInfoType as function(byval This as ITypeLib2 ptr, byval index as UINT, byval pTKind as TYPEKIND ptr) as HRESULT
	GetTypeInfoOfGuid as function(byval This as ITypeLib2 ptr, byval guid as const GUID const ptr, byval ppTinfo as ITypeInfo ptr ptr) as HRESULT
	GetLibAttr as function(byval This as ITypeLib2 ptr, byval ppTLibAttr as TLIBATTR ptr ptr) as HRESULT
	GetTypeComp as function(byval This as ITypeLib2 ptr, byval ppTComp as ITypeComp ptr ptr) as HRESULT
	GetDocumentation as function(byval This as ITypeLib2 ptr, byval index as INT_, byval pBstrName as BSTR ptr, byval pBstrDocString as BSTR ptr, byval pdwHelpContext as DWORD ptr, byval pBstrHelpFile as BSTR ptr) as HRESULT
	IsName as function(byval This as ITypeLib2 ptr, byval szNameBuf as LPOLESTR, byval lHashVal as ULONG, byval pfName as WINBOOL ptr) as HRESULT
	FindName as function(byval This as ITypeLib2 ptr, byval szNameBuf as LPOLESTR, byval lHashVal as ULONG, byval ppTInfo as ITypeInfo ptr ptr, byval rgMemId as MEMBERID ptr, byval pcFound as USHORT ptr) as HRESULT
	ReleaseTLibAttr as sub(byval This as ITypeLib2 ptr, byval pTLibAttr as TLIBATTR ptr)
	GetCustData as function(byval This as ITypeLib2 ptr, byval guid as const GUID const ptr, byval pVarVal as VARIANT ptr) as HRESULT
	GetLibStatistics as function(byval This as ITypeLib2 ptr, byval pcUniqueNames as ULONG ptr, byval pcchUniqueNames as ULONG ptr) as HRESULT
	GetDocumentation2 as function(byval This as ITypeLib2 ptr, byval index as INT_, byval lcid as LCID, byval pbstrHelpString as BSTR ptr, byval pdwHelpStringContext as DWORD ptr, byval pbstrHelpStringDll as BSTR ptr) as HRESULT
	GetAllCustData as function(byval This as ITypeLib2 ptr, byval pCustData as CUSTDATA ptr) as HRESULT
end type

type ITypeLib2_
	lpVtbl as ITypeLib2Vtbl ptr
end type

declare function ITypeLib2_GetCustData_Proxy(byval This as ITypeLib2 ptr, byval guid as const GUID const ptr, byval pVarVal as VARIANT ptr) as HRESULT
declare sub ITypeLib2_GetCustData_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITypeLib2_RemoteGetLibStatistics_Proxy(byval This as ITypeLib2 ptr, byval pcUniqueNames as ULONG ptr, byval pcchUniqueNames as ULONG ptr) as HRESULT
declare sub ITypeLib2_RemoteGetLibStatistics_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITypeLib2_RemoteGetDocumentation2_Proxy(byval This as ITypeLib2 ptr, byval index as INT_, byval lcid as LCID, byval refPtrFlags as DWORD, byval pbstrHelpString as BSTR ptr, byval pdwHelpStringContext as DWORD ptr, byval pbstrHelpStringDll as BSTR ptr) as HRESULT
declare sub ITypeLib2_RemoteGetDocumentation2_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITypeLib2_GetAllCustData_Proxy(byval This as ITypeLib2 ptr, byval pCustData as CUSTDATA ptr) as HRESULT
declare sub ITypeLib2_GetAllCustData_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITypeLib2_GetLibStatistics_Proxy(byval This as ITypeLib2 ptr, byval pcUniqueNames as ULONG ptr, byval pcchUniqueNames as ULONG ptr) as HRESULT
declare function ITypeLib2_GetLibStatistics_Stub(byval This as ITypeLib2 ptr, byval pcUniqueNames as ULONG ptr, byval pcchUniqueNames as ULONG ptr) as HRESULT
declare function ITypeLib2_GetDocumentation2_Proxy(byval This as ITypeLib2 ptr, byval index as INT_, byval lcid as LCID, byval pbstrHelpString as BSTR ptr, byval pdwHelpStringContext as DWORD ptr, byval pbstrHelpStringDll as BSTR ptr) as HRESULT
declare function ITypeLib2_GetDocumentation2_Stub(byval This as ITypeLib2 ptr, byval index as INT_, byval lcid as LCID, byval refPtrFlags as DWORD, byval pbstrHelpString as BSTR ptr, byval pdwHelpStringContext as DWORD ptr, byval pbstrHelpStringDll as BSTR ptr) as HRESULT

#define __ITypeChangeEvents_INTERFACE_DEFINED__

type ITypeChangeEvents as ITypeChangeEvents_

type LPTYPECHANGEEVENTS as ITypeChangeEvents ptr

type tagCHANGEKIND as long
enum
	CHANGEKIND_ADDMEMBER = 0
	CHANGEKIND_DELETEMEMBER = 1
	CHANGEKIND_SETNAMES = 2
	CHANGEKIND_SETDOCUMENTATION = 3
	CHANGEKIND_GENERAL = 4
	CHANGEKIND_INVALIDATE = 5
	CHANGEKIND_CHANGEFAILED = 6
	CHANGEKIND_MAX = 7
end enum

type CHANGEKIND as tagCHANGEKIND

extern IID_ITypeChangeEvents as const GUID

type ITypeChangeEventsVtbl
	QueryInterface as function(byval This as ITypeChangeEvents ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ITypeChangeEvents ptr) as ULONG
	Release as function(byval This as ITypeChangeEvents ptr) as ULONG
	RequestTypeChange as function(byval This as ITypeChangeEvents ptr, byval changeKind as CHANGEKIND, byval pTInfoBefore as ITypeInfo ptr, byval pStrName as LPOLESTR, byval pfCancel as INT_ ptr) as HRESULT
	AfterTypeChange as function(byval This as ITypeChangeEvents ptr, byval changeKind as CHANGEKIND, byval pTInfoAfter as ITypeInfo ptr, byval pStrName as LPOLESTR) as HRESULT
end type

type ITypeChangeEvents_
	lpVtbl as ITypeChangeEventsVtbl ptr
end type

declare function ITypeChangeEvents_RequestTypeChange_Proxy(byval This as ITypeChangeEvents ptr, byval changeKind as CHANGEKIND, byval pTInfoBefore as ITypeInfo ptr, byval pStrName as LPOLESTR, byval pfCancel as INT_ ptr) as HRESULT
declare sub ITypeChangeEvents_RequestTypeChange_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITypeChangeEvents_AfterTypeChange_Proxy(byval This as ITypeChangeEvents ptr, byval changeKind as CHANGEKIND, byval pTInfoAfter as ITypeInfo ptr, byval pStrName as LPOLESTR) as HRESULT
declare sub ITypeChangeEvents_AfterTypeChange_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define __IErrorInfo_INTERFACE_DEFINED__

type IErrorInfo as IErrorInfo_

type LPERRORINFO as IErrorInfo ptr

extern IID_IErrorInfo as const GUID

type IErrorInfoVtbl
	QueryInterface as function(byval This as IErrorInfo ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IErrorInfo ptr) as ULONG
	Release as function(byval This as IErrorInfo ptr) as ULONG
	GetGUID as function(byval This as IErrorInfo ptr, byval pGUID as GUID ptr) as HRESULT
	GetSource as function(byval This as IErrorInfo ptr, byval pBstrSource as BSTR ptr) as HRESULT
	GetDescription as function(byval This as IErrorInfo ptr, byval pBstrDescription as BSTR ptr) as HRESULT
	GetHelpFile as function(byval This as IErrorInfo ptr, byval pBstrHelpFile as BSTR ptr) as HRESULT
	GetHelpContext as function(byval This as IErrorInfo ptr, byval pdwHelpContext as DWORD ptr) as HRESULT
end type

type IErrorInfo_
	lpVtbl as IErrorInfoVtbl ptr
end type

declare function IErrorInfo_GetGUID_Proxy(byval This as IErrorInfo ptr, byval pGUID as GUID ptr) as HRESULT
declare sub IErrorInfo_GetGUID_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IErrorInfo_GetSource_Proxy(byval This as IErrorInfo ptr, byval pBstrSource as BSTR ptr) as HRESULT
declare sub IErrorInfo_GetSource_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IErrorInfo_GetDescription_Proxy(byval This as IErrorInfo ptr, byval pBstrDescription as BSTR ptr) as HRESULT
declare sub IErrorInfo_GetDescription_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IErrorInfo_GetHelpFile_Proxy(byval This as IErrorInfo ptr, byval pBstrHelpFile as BSTR ptr) as HRESULT
declare sub IErrorInfo_GetHelpFile_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IErrorInfo_GetHelpContext_Proxy(byval This as IErrorInfo ptr, byval pdwHelpContext as DWORD ptr) as HRESULT
declare sub IErrorInfo_GetHelpContext_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define __ICreateErrorInfo_INTERFACE_DEFINED__

type ICreateErrorInfo as ICreateErrorInfo_

type LPCREATEERRORINFO as ICreateErrorInfo ptr

extern IID_ICreateErrorInfo as const GUID

type ICreateErrorInfoVtbl
	QueryInterface as function(byval This as ICreateErrorInfo ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ICreateErrorInfo ptr) as ULONG
	Release as function(byval This as ICreateErrorInfo ptr) as ULONG
	SetGUID as function(byval This as ICreateErrorInfo ptr, byval rguid as const GUID const ptr) as HRESULT
	SetSource as function(byval This as ICreateErrorInfo ptr, byval szSource as LPOLESTR) as HRESULT
	SetDescription as function(byval This as ICreateErrorInfo ptr, byval szDescription as LPOLESTR) as HRESULT
	SetHelpFile as function(byval This as ICreateErrorInfo ptr, byval szHelpFile as LPOLESTR) as HRESULT
	SetHelpContext as function(byval This as ICreateErrorInfo ptr, byval dwHelpContext as DWORD) as HRESULT
end type

type ICreateErrorInfo_
	lpVtbl as ICreateErrorInfoVtbl ptr
end type

declare function ICreateErrorInfo_SetGUID_Proxy(byval This as ICreateErrorInfo ptr, byval rguid as const GUID const ptr) as HRESULT
declare sub ICreateErrorInfo_SetGUID_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICreateErrorInfo_SetSource_Proxy(byval This as ICreateErrorInfo ptr, byval szSource as LPOLESTR) as HRESULT
declare sub ICreateErrorInfo_SetSource_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICreateErrorInfo_SetDescription_Proxy(byval This as ICreateErrorInfo ptr, byval szDescription as LPOLESTR) as HRESULT
declare sub ICreateErrorInfo_SetDescription_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICreateErrorInfo_SetHelpFile_Proxy(byval This as ICreateErrorInfo ptr, byval szHelpFile as LPOLESTR) as HRESULT
declare sub ICreateErrorInfo_SetHelpFile_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICreateErrorInfo_SetHelpContext_Proxy(byval This as ICreateErrorInfo ptr, byval dwHelpContext as DWORD) as HRESULT
declare sub ICreateErrorInfo_SetHelpContext_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define __ISupportErrorInfo_INTERFACE_DEFINED__

type ISupportErrorInfo as ISupportErrorInfo_

type LPSUPPORTERRORINFO as ISupportErrorInfo ptr

extern IID_ISupportErrorInfo as const GUID

type ISupportErrorInfoVtbl
	QueryInterface as function(byval This as ISupportErrorInfo ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ISupportErrorInfo ptr) as ULONG
	Release as function(byval This as ISupportErrorInfo ptr) as ULONG
	InterfaceSupportsErrorInfo as function(byval This as ISupportErrorInfo ptr, byval riid as const IID const ptr) as HRESULT
end type

type ISupportErrorInfo_
	lpVtbl as ISupportErrorInfoVtbl ptr
end type

declare function ISupportErrorInfo_InterfaceSupportsErrorInfo_Proxy(byval This as ISupportErrorInfo ptr, byval riid as const IID const ptr) as HRESULT
declare sub ISupportErrorInfo_InterfaceSupportsErrorInfo_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define __ITypeFactory_INTERFACE_DEFINED__

extern IID_ITypeFactory as const GUID

type ITypeFactory as ITypeFactory_

type ITypeFactoryVtbl
	QueryInterface as function(byval This as ITypeFactory ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ITypeFactory ptr) as ULONG
	Release as function(byval This as ITypeFactory ptr) as ULONG
	CreateFromTypeInfo as function(byval This as ITypeFactory ptr, byval pTypeInfo as ITypeInfo ptr, byval riid as const IID const ptr, byval ppv as IUnknown ptr ptr) as HRESULT
end type

type ITypeFactory_
	lpVtbl as ITypeFactoryVtbl ptr
end type

declare function ITypeFactory_CreateFromTypeInfo_Proxy(byval This as ITypeFactory ptr, byval pTypeInfo as ITypeInfo ptr, byval riid as const IID const ptr, byval ppv as IUnknown ptr ptr) as HRESULT
declare sub ITypeFactory_CreateFromTypeInfo_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define __ITypeMarshal_INTERFACE_DEFINED__

extern IID_ITypeMarshal as const GUID

type ITypeMarshal as ITypeMarshal_

type ITypeMarshalVtbl
	QueryInterface as function(byval This as ITypeMarshal ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ITypeMarshal ptr) as ULONG
	Release as function(byval This as ITypeMarshal ptr) as ULONG
	Size as function(byval This as ITypeMarshal ptr, byval pvType as PVOID, byval dwDestContext as DWORD, byval pvDestContext as PVOID, byval pSize as ULONG ptr) as HRESULT
	Marshal as function(byval This as ITypeMarshal ptr, byval pvType as PVOID, byval dwDestContext as DWORD, byval pvDestContext as PVOID, byval cbBufferLength as ULONG, byval pBuffer as UBYTE ptr, byval pcbWritten as ULONG ptr) as HRESULT
	Unmarshal as function(byval This as ITypeMarshal ptr, byval pvType as PVOID, byval dwFlags as DWORD, byval cbBufferLength as ULONG, byval pBuffer as UBYTE ptr, byval pcbRead as ULONG ptr) as HRESULT
	Free as function(byval This as ITypeMarshal ptr, byval pvType as PVOID) as HRESULT
end type

type ITypeMarshal_
	lpVtbl as ITypeMarshalVtbl ptr
end type

declare function ITypeMarshal_Size_Proxy(byval This as ITypeMarshal ptr, byval pvType as PVOID, byval dwDestContext as DWORD, byval pvDestContext as PVOID, byval pSize as ULONG ptr) as HRESULT
declare sub ITypeMarshal_Size_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITypeMarshal_Marshal_Proxy(byval This as ITypeMarshal ptr, byval pvType as PVOID, byval dwDestContext as DWORD, byval pvDestContext as PVOID, byval cbBufferLength as ULONG, byval pBuffer as UBYTE ptr, byval pcbWritten as ULONG ptr) as HRESULT
declare sub ITypeMarshal_Marshal_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITypeMarshal_Unmarshal_Proxy(byval This as ITypeMarshal ptr, byval pvType as PVOID, byval dwFlags as DWORD, byval cbBufferLength as ULONG, byval pBuffer as UBYTE ptr, byval pcbRead as ULONG ptr) as HRESULT
declare sub ITypeMarshal_Unmarshal_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ITypeMarshal_Free_Proxy(byval This as ITypeMarshal ptr, byval pvType as PVOID) as HRESULT
declare sub ITypeMarshal_Free_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define __IRecordInfo_INTERFACE_DEFINED__

type LPRECORDINFO as IRecordInfo ptr

extern IID_IRecordInfo as const GUID

type IRecordInfoVtbl
	QueryInterface as function(byval This as IRecordInfo ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IRecordInfo ptr) as ULONG
	Release as function(byval This as IRecordInfo ptr) as ULONG
	RecordInit as function(byval This as IRecordInfo ptr, byval pvNew as PVOID) as HRESULT
	RecordClear as function(byval This as IRecordInfo ptr, byval pvExisting as PVOID) as HRESULT
	RecordCopy as function(byval This as IRecordInfo ptr, byval pvExisting as PVOID, byval pvNew as PVOID) as HRESULT
	GetGuid as function(byval This as IRecordInfo ptr, byval pguid as GUID ptr) as HRESULT
	GetName as function(byval This as IRecordInfo ptr, byval pbstrName as BSTR ptr) as HRESULT
	GetSize as function(byval This as IRecordInfo ptr, byval pcbSize as ULONG ptr) as HRESULT
	GetTypeInfo as function(byval This as IRecordInfo ptr, byval ppTypeInfo as ITypeInfo ptr ptr) as HRESULT
	GetField as function(byval This as IRecordInfo ptr, byval pvData as PVOID, byval szFieldName as LPCOLESTR, byval pvarField as VARIANT ptr) as HRESULT
	GetFieldNoCopy as function(byval This as IRecordInfo ptr, byval pvData as PVOID, byval szFieldName as LPCOLESTR, byval pvarField as VARIANT ptr, byval ppvDataCArray as PVOID ptr) as HRESULT
	PutField as function(byval This as IRecordInfo ptr, byval wFlags as ULONG, byval pvData as PVOID, byval szFieldName as LPCOLESTR, byval pvarField as VARIANT ptr) as HRESULT
	PutFieldNoCopy as function(byval This as IRecordInfo ptr, byval wFlags as ULONG, byval pvData as PVOID, byval szFieldName as LPCOLESTR, byval pvarField as VARIANT ptr) as HRESULT
	GetFieldNames as function(byval This as IRecordInfo ptr, byval pcNames as ULONG ptr, byval rgBstrNames as BSTR ptr) as HRESULT
	IsMatchingType as function(byval This as IRecordInfo ptr, byval pRecordInfo as IRecordInfo ptr) as WINBOOL
	RecordCreate as function(byval This as IRecordInfo ptr) as PVOID
	RecordCreateCopy as function(byval This as IRecordInfo ptr, byval pvSource as PVOID, byval ppvDest as PVOID ptr) as HRESULT
	RecordDestroy as function(byval This as IRecordInfo ptr, byval pvRecord as PVOID) as HRESULT
end type

type IRecordInfo_
	lpVtbl as IRecordInfoVtbl ptr
end type

declare function IRecordInfo_RecordInit_Proxy(byval This as IRecordInfo ptr, byval pvNew as PVOID) as HRESULT
declare sub IRecordInfo_RecordInit_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IRecordInfo_RecordClear_Proxy(byval This as IRecordInfo ptr, byval pvExisting as PVOID) as HRESULT
declare sub IRecordInfo_RecordClear_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IRecordInfo_RecordCopy_Proxy(byval This as IRecordInfo ptr, byval pvExisting as PVOID, byval pvNew as PVOID) as HRESULT
declare sub IRecordInfo_RecordCopy_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IRecordInfo_GetGuid_Proxy(byval This as IRecordInfo ptr, byval pguid as GUID ptr) as HRESULT
declare sub IRecordInfo_GetGuid_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IRecordInfo_GetName_Proxy(byval This as IRecordInfo ptr, byval pbstrName as BSTR ptr) as HRESULT
declare sub IRecordInfo_GetName_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IRecordInfo_GetSize_Proxy(byval This as IRecordInfo ptr, byval pcbSize as ULONG ptr) as HRESULT
declare sub IRecordInfo_GetSize_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IRecordInfo_GetTypeInfo_Proxy(byval This as IRecordInfo ptr, byval ppTypeInfo as ITypeInfo ptr ptr) as HRESULT
declare sub IRecordInfo_GetTypeInfo_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IRecordInfo_GetField_Proxy(byval This as IRecordInfo ptr, byval pvData as PVOID, byval szFieldName as LPCOLESTR, byval pvarField as VARIANT ptr) as HRESULT
declare sub IRecordInfo_GetField_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IRecordInfo_GetFieldNoCopy_Proxy(byval This as IRecordInfo ptr, byval pvData as PVOID, byval szFieldName as LPCOLESTR, byval pvarField as VARIANT ptr, byval ppvDataCArray as PVOID ptr) as HRESULT
declare sub IRecordInfo_GetFieldNoCopy_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IRecordInfo_PutField_Proxy(byval This as IRecordInfo ptr, byval wFlags as ULONG, byval pvData as PVOID, byval szFieldName as LPCOLESTR, byval pvarField as VARIANT ptr) as HRESULT
declare sub IRecordInfo_PutField_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IRecordInfo_PutFieldNoCopy_Proxy(byval This as IRecordInfo ptr, byval wFlags as ULONG, byval pvData as PVOID, byval szFieldName as LPCOLESTR, byval pvarField as VARIANT ptr) as HRESULT
declare sub IRecordInfo_PutFieldNoCopy_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IRecordInfo_GetFieldNames_Proxy(byval This as IRecordInfo ptr, byval pcNames as ULONG ptr, byval rgBstrNames as BSTR ptr) as HRESULT
declare sub IRecordInfo_GetFieldNames_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IRecordInfo_IsMatchingType_Proxy(byval This as IRecordInfo ptr, byval pRecordInfo as IRecordInfo ptr) as WINBOOL
declare sub IRecordInfo_IsMatchingType_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IRecordInfo_RecordCreate_Proxy(byval This as IRecordInfo ptr) as PVOID
declare sub IRecordInfo_RecordCreate_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IRecordInfo_RecordCreateCopy_Proxy(byval This as IRecordInfo ptr, byval pvSource as PVOID, byval ppvDest as PVOID ptr) as HRESULT
declare sub IRecordInfo_RecordCreateCopy_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IRecordInfo_RecordDestroy_Proxy(byval This as IRecordInfo ptr, byval pvRecord as PVOID) as HRESULT
declare sub IRecordInfo_RecordDestroy_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define __IErrorLog_INTERFACE_DEFINED__

type IErrorLog as IErrorLog_

type LPERRORLOG as IErrorLog ptr

extern IID_IErrorLog as const GUID

type IErrorLogVtbl
	QueryInterface as function(byval This as IErrorLog ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IErrorLog ptr) as ULONG
	Release as function(byval This as IErrorLog ptr) as ULONG
	AddError as function(byval This as IErrorLog ptr, byval pszPropName as LPCOLESTR, byval pExcepInfo as EXCEPINFO ptr) as HRESULT
end type

type IErrorLog_
	lpVtbl as IErrorLogVtbl ptr
end type

declare function IErrorLog_AddError_Proxy(byval This as IErrorLog ptr, byval pszPropName as LPCOLESTR, byval pExcepInfo as EXCEPINFO ptr) as HRESULT
declare sub IErrorLog_AddError_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#define __IPropertyBag_INTERFACE_DEFINED__

type IPropertyBag as IPropertyBag_

type LPPROPERTYBAG as IPropertyBag ptr

extern IID_IPropertyBag as const GUID

type IPropertyBagVtbl
	QueryInterface as function(byval This as IPropertyBag ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPropertyBag ptr) as ULONG
	Release as function(byval This as IPropertyBag ptr) as ULONG
	Read as function(byval This as IPropertyBag ptr, byval pszPropName as LPCOLESTR, byval pVar as VARIANT ptr, byval pErrorLog as IErrorLog ptr) as HRESULT
	Write as function(byval This as IPropertyBag ptr, byval pszPropName as LPCOLESTR, byval pVar as VARIANT ptr) as HRESULT
end type

type IPropertyBag_
	lpVtbl as IPropertyBagVtbl ptr
end type

declare function IPropertyBag_RemoteRead_Proxy(byval This as IPropertyBag ptr, byval pszPropName as LPCOLESTR, byval pVar as VARIANT ptr, byval pErrorLog as IErrorLog ptr, byval varType as DWORD, byval pUnkObj as IUnknown ptr) as HRESULT
declare sub IPropertyBag_RemoteRead_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyBag_Write_Proxy(byval This as IPropertyBag ptr, byval pszPropName as LPCOLESTR, byval pVar as VARIANT ptr) as HRESULT
declare sub IPropertyBag_Write_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyBag_Read_Proxy(byval This as IPropertyBag ptr, byval pszPropName as LPCOLESTR, byval pVar as VARIANT ptr, byval pErrorLog as IErrorLog ptr) as HRESULT
declare function IPropertyBag_Read_Stub(byval This as IPropertyBag ptr, byval pszPropName as LPCOLESTR, byval pVar as VARIANT ptr, byval pErrorLog as IErrorLog ptr, byval varType as DWORD, byval pUnkObj as IUnknown ptr) as HRESULT
declare function CLEANLOCALSTORAGE_UserSize(byval as ULONG ptr, byval as ULONG, byval as CLEANLOCALSTORAGE ptr) as ULONG
declare function CLEANLOCALSTORAGE_UserMarshal(byval as ULONG ptr, byval as ubyte ptr, byval as CLEANLOCALSTORAGE ptr) as ubyte ptr
declare function CLEANLOCALSTORAGE_UserUnmarshal(byval as ULONG ptr, byval as ubyte ptr, byval as CLEANLOCALSTORAGE ptr) as ubyte ptr
declare sub CLEANLOCALSTORAGE_UserFree(byval as ULONG ptr, byval as CLEANLOCALSTORAGE ptr)
declare function LPSAFEARRAY_UserMarshal(byval as ULONG ptr, byval as ubyte ptr, byval as LPSAFEARRAY ptr) as ubyte ptr
declare function LPSAFEARRAY_UserSize(byval as ULONG ptr, byval as ULONG, byval as LPSAFEARRAY ptr) as ULONG
declare function LPSAFEARRAY_UserUnmarshal(byval as ULONG ptr, byval as ubyte ptr, byval as LPSAFEARRAY ptr) as ubyte ptr
declare sub LPSAFEARRAY_UserFree(byval as ULONG ptr, byval as LPSAFEARRAY ptr)
declare function VARIANT_UserSize(byval as ULONG ptr, byval as ULONG, byval as VARIANT ptr) as ULONG
declare function VARIANT_UserMarshal(byval as ULONG ptr, byval as ubyte ptr, byval as VARIANT ptr) as ubyte ptr
declare function VARIANT_UserUnmarshal(byval as ULONG ptr, byval as ubyte ptr, byval as VARIANT ptr) as ubyte ptr
declare sub VARIANT_UserFree(byval as ULONG ptr, byval as VARIANT ptr)

end extern

#include once "ole-common.bi"
