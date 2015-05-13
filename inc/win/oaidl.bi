''
''
'' oaidl -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_oaidl_bi__
#define __win_oaidl_bi__

#define __VARIANT_NAME_1
#define __VARIANT_NAME_2
#define __VARIANT_NAME_3
#define __VARIANT_NAME_4

#define DISPID_UNKNOWN (-1)
#define DISPID_VALUE (0)
#define DISPID_PROPERTYPUT (-3)
#define DISPID_NEWENUM (-4)
#define DISPID_EVALUATE (-5)
#define DISPID_CONSTRUCTOR (-6)
#define DISPID_DESTRUCTOR (-7)
#define DISPID_COLLECT (-8)
#define FADF_AUTO (1)
#define FADF_STATIC (2)
#define FADF_EMBEDDED (4)
#define FADF_FIXEDSIZE (16)
#define FADF_RECORD (32)
#define FADF_HAVEIID (64)
#define FADF_HAVEVARTYPE (128)
#define FADF_BSTR (256)
#define FADF_UNKNOWN (512)
#define FADF_DISPATCH (1024)
#define FADF_VARIANT (2048)
#define FADF_RESERVED (&hf0e8)
#define FADF_DATADELETED (&h1000)
#define FADF_CREATEVECTOR (&h2000)
#define PARAMFLAG_NONE (0)
#define PARAMFLAG_FIN (1)
#define PARAMFLAG_FOUT (2)
#define PARAMFLAG_FLCID (4)
#define PARAMFLAG_FRETVAL (8)
#define PARAMFLAG_FOPT (16)
#define PARAMFLAG_FHASDEFAULT (32)
#define IDLFLAG_NONE (0)
#define IDLFLAG_FIN (1)
#define IDLFLAG_FOUT (2)
#define IDLFLAG_FLCID (4)
#define IDLFLAG_FRETVAL (8)
#define IMPLTYPEFLAG_FDEFAULT 1
#define IMPLTYPEFLAG_FSOURCE 2
#define IMPLTYPEFLAG_FRESTRICTED 4
#define IMPLTYPEFLAG_FDEFAULTVTABLE 8

type LPTYPELIB as ITypeLib ptr
type LPTYPELIB2 as ITypeLib2 ptr
type LPCREATETYPEINFO as ICreateTypeInfo ptr
type LPCREATETYPEINFO2 as ICreateTypeInfo2 ptr
type LPCREATETYPELIB as ICreateTypeLib ptr
type LPCREATETYPELIB2 as ICreateTypeLib2 ptr
type LPTYPECOMP as ITypeComp ptr
type LPTYPEINFO as ITypeInfo ptr
type LPTYPEINFO2 as ITypeInfo2 ptr
type LPERRORINFO as IErrorInfo ptr
type LPDISPATCH as IDispatch ptr
type LPENUMVARIANT as IEnumVARIANT ptr
type LPCREATEERRORINFO as ICreateErrorInfo ptr
type LPSUPPORTERRORINFO as ISupportErrorInfo ptr
type LPRECORDINFO as IRecordInfo ptr

#inclib "uuid"

extern IID_ITypeLib alias "IID_ITypeLib" as IID
extern IID_ITypeLib2 alias "IID_ITypeLib2" as IID
extern IID_ICreateTypeInfo alias "IID_ICreateTypeInfo" as IID
extern IID_ICreateTypeInfo2 alias "IID_ICreateTypeInfo2" as IID
extern IID_ICreateTypeLib alias "IID_ICreateTypeLib" as IID
extern IID_ICreateTypeLib2 alias "IID_ICreateTypeLib2" as IID
extern IID_ITypeInfo alias "IID_ITypeInfo" as IID
extern IID_ITypeInfo2 alias "IID_ITypeInfo2" as IID
extern IID_IErrorInfo alias "IID_IErrorInfo" as IID
extern IID_IDispatch alias "IID_IDispatch" as IID
extern IID_IEnumVARIANT alias "IID_IEnumVARIANT" as IID
extern IID_ICreateErrorInfo alias "IID_ICreateErrorInfo" as IID
extern IID_ISupportErrorInfo alias "IID_ISupportErrorInfo" as IID
extern IID_IRecordInfo alias "IID_IRecordInfo" as IID
extern IID_ITypeMarshal alias "IID_ITypeMarshal" as IID

enum SYSKIND
	SYS_WIN16
	SYS_WIN32
	SYS_MAC
end enum

enum LIBFLAGS
	LIBFLAG_FRESTRICTED = 1
	LIBFLAG_FCONTROL = 2
	LIBFLAG_FHIDDEN = 4
	LIBFLAG_FHASDISKIMAGE = 8
end enum

type TLIBATTR
	guid as GUID
	lcid as LCID
	syskind as SYSKIND
	wMajorVerNum as WORD
	wMinorVerNum as WORD
	wLibFlags as WORD
end type

type LPTLIBATTR as TLIBATTR ptr
type CURRENCY as CY

type SAFEARRAYBOUND
	cElements as ULONG
	lLbound as LONG
end type

type LPSAFEARRAYBOUND as SAFEARRAYBOUND ptr

type SAFEARR_BSTR
	Size as ULONG
	aBstr as wireBSTR ptr
end type

type SAFEARR_UNKNOWN
	Size as ULONG
	apUnknown as IUnknown ptr ptr
end type

type SAFEARR_DISPATCH
	Size as ULONG
	apDispatch as LPDISPATCH ptr
end type

type VARIANT__ as VARIANT_

type SAFEARR_VARIANT
	Size as ULONG
	aVariant as VARIANT__ ptr
end type

enum SF_TYPE
	SF_ERROR = VT_ERROR
	SF_I1 = VT_I1
	SF_I2 = VT_I2
	SF_I4 = VT_I4
	SF_I8 = VT_I8
	SF_BSTR = VT_BSTR
	SF_UNKNOWN = VT_UNKNOWN
	SF_DISPATCH = VT_DISPATCH
	SF_VARIANT = VT_VARIANT
end enum

type BRECORD
	fFlags as ULONG
	clSize as ULONG
	pRecInfo as LPRECORDINFO ptr
	pRecord as byte ptr
end type

type wireBRECORD as BRECORD ptr

type SAFEARR_BRECORD
	Size as ULONG
	aRecord as wireBRECORD ptr
end type

type SAFEARR_HAVEIID
	Size as ULONG
	apUnknown as IUnknown ptr ptr
	iid as IID
end type

type SAFEARRAYUNION
	sfType as ULONG
	union
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
end type

type wireSAFEARRAY
	cDims as USHORT
	fFeatures as USHORT
	cbElements as ULONG
	cLocks as ULONG
	uArrayStructs as SAFEARRAYUNION
	rgsabound(0 to 1-1) as SAFEARRAYBOUND
end type

type wirePSAFEARRAY as wireSAFEARRAY ptr

type SAFEARRAY
	cDims as USHORT
	fFeatures as USHORT
	cbElements as ULONG
	cLocks as ULONG
	pvData as PVOID
	rgsabound(0 to 1-1) as SAFEARRAYBOUND
end type

type LPSAFEARRAY as SAFEARRAY ptr

type IRecordInfo_ as IRecordInfo

union VARIANT_
	type
		vt as VARTYPE
		wReserved1 as WORD
		wReserved2 as WORD
		wReserved3 as WORD
		union
			lVal as integer
			llVal as LONGLONG
			bVal as ubyte
			iVal as short
			fltVal as single
			dblVal as double
			boolVal as VARIANT_BOOL
			scode as SCODE
			cyVal as CY
			date as DATE_
			bstrVal as BSTR
			punkVal as IUnknown ptr
			pdispVal as LPDISPATCH
			parray as SAFEARRAY ptr
			pbVal as ubyte ptr
			piVal as short ptr
			plVal as integer ptr
			pfltVal as single ptr
			pdblVal as double ptr
			pboolVal as VARIANT_BOOL ptr
			pbool as _VARIANT_BOOL ptr
			pscode as SCODE ptr
			pcyVal as CY ptr
			pdate as DATE_ ptr
			pbstrVal as BSTR ptr
			ppunkVal as IUnknown ptr ptr
			ppdispVal as LPDISPATCH ptr
			pparray as SAFEARRAY ptr ptr
			pvarVal as VARIANT_ ptr
			byref as any ptr
			cVal as CHAR
			uiVal as USHORT
			ulVal as ULONG
			ullVal as ULONGLONG
			intVal as INT_
			uintVal as UINT
			pdecVal as DECIMAL ptr
			pcVal as CHAR ptr
			puiVal as USHORT ptr
			pulVal as ULONG ptr
			pintVal as INT_ ptr
			puintVal as UINT ptr
			type
				pvRecord as PVOID
				pRecInfo as IRecordInfo_ ptr
			end type
		end union
	end type
	decVal as DECIMAL
end union

type VARIANT as VARIANT_

type LPVARIANT as VARIANT_ ptr

type VARIANTARG as VARIANT_
type LPVARIANTARG as VARIANT_ ptr

type wireVARIANT
	clSize as DWORD
	rpcReserved as DWORD
	vt as USHORT
	wReserved1 as USHORT
	wReserved2 as USHORT
	wReserved3 as USHORT
	union
		lVal as LONG
		llVal as LONGLONG
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
		pdispVal as LPDISPATCH
		parray as wirePSAFEARRAY
		brecVal as wireBRECORD
		pbVal as UBYTE ptr
		piVal as SHORT ptr
		plVal as LONG ptr
		pfltVal as FLOAT ptr
		pdblVal as DOUBLE ptr
		pboolVal as VARIANT_BOOL ptr
		pscode as SCODE ptr
		pcyVal as CY ptr
		pdate as DATE_ ptr
		pbstrVal as wireBSTR ptr
		ppunkVal as IUnknown ptr ptr
		ppdispVal as LPDISPATCH ptr
		pparray as wirePSAFEARRAY ptr
		pvarVal as VARIANT_ ptr
		cVal as CHAR
		uiVal as USHORT
		ulVal as ULONG
		ullVal as ULONGLONG
		intVal as INT_
		uintVal as UINT
		decVal as DECIMAL
		pdecVal as DECIMAL ptr
		pcVal as CHAR ptr
		puiVal as USHORT ptr
		pulVal as ULONG ptr
		pintVal as INT_ ptr
		puintVal as UINT ptr
	end union
end type

type DISPID as LONG
type MEMBERID as DISPID
type HREFTYPE as DWORD

enum TYPEKIND
	TKIND_ENUM
	TKIND_RECORD
	TKIND_MODULE
	TKIND_INTERFACE
	TKIND_DISPATCH
	TKIND_COCLASS
	TKIND_ALIAS
	TKIND_UNION
	TKIND_MAX
end enum

type ARRAYDESC_ as ARRAYDESC

type TYPEDESC
	union
		lptdesc as TYPEDESC ptr
		lpadesc as ARRAYDESC_ ptr
		hreftype as HREFTYPE
	end union
	vt as VARTYPE
end type

type ARRAYDESC
	tdescElem as TYPEDESC
	cDims as USHORT
	rgbounds(0 to 1-1) as SAFEARRAYBOUND
end type

type PARAMDESCEX
	cBytes as ULONG
	varDefaultValue as VARIANTARG
end type

type LPPARAMDESCEX as PARAMDESCEX ptr

type PARAMDESC
	pparamdescex as LPPARAMDESCEX
	wParamFlags as USHORT
end type

type LPPARAMDESC as PARAMDESC ptr

type IDLDESC
	dwReserved as ULONG
	wIDLFlags as USHORT
end type

type LPIDLDESC as IDLDESC ptr

type ELEMDESC
	tdesc as TYPEDESC
	union
		idldesc as IDLDESC
		paramdesc as PARAMDESC
	end union
end type

type LPELEMDESC as ELEMDESC ptr

type TYPEATTR
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

type LPTYPEATTR as TYPEATTR ptr

type DISPPARAMS
	rgvarg as VARIANTARG ptr
	rgdispidNamedArgs as DISPID ptr
	cArgs as UINT
	cNamedArgs as UINT
end type

type EXCEPINFO
	wCode as WORD
	wReserved as WORD
	bstrSource as BSTR
	bstrDescription as BSTR
	bstrHelpFile as BSTR
	dwHelpContext as DWORD
	pvReserved as PVOID
	pfnDeferredFillIn as function (byval as EXCEPINFO ptr) as HRESULT
	scode as SCODE
end type

type LPEXCEPINFO as EXCEPINFO ptr

enum CALLCONV
	CC_FASTCALL
	CC_CDECL
	CC_MSCPASCAL
	CC_PASCAL = CC_MSCPASCAL
	CC_MACPASCAL
	CC_STDCALL
	CC_FPFASTCALL
	CC_SYSCALL
	CC_MPWCDECL
	CC_MPWPASCAL
	CC_MAX = CC_MPWPASCAL
end enum

enum FUNCKIND
	FUNC_VIRTUAL
	FUNC_PUREVIRTUAL
	FUNC_NONVIRTUAL
	FUNC_STATIC
	FUNC_DISPATCH
end enum

enum INVOKEKIND
	INVOKE_FUNC = 1
	INVOKE_PROPERTYGET
	INVOKE_PROPERTYPUT = 4
	INVOKE_PROPERTYPUTREF = 8
end enum

type FUNCDESC
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

type LPFUNCDESC as FUNCDESC ptr

enum VARKIND
	VAR_PERINSTANCE
	VAR_STATIC
	VAR_CONST
	VAR_DISPATCH
end enum

type VARDESC
	memid as MEMBERID
	lpstrSchema as LPOLESTR
	union
		oInst as ULONG
		lpvarValue as VARIANT_ ptr
	end union
	elemdescVar as ELEMDESC
	wVarFlags as WORD
	varkind as VARKIND
end type

type LPVARDESC as VARDESC ptr

enum TYPEFLAGS
	TYPEFLAG_FAPPOBJECT = 1
	TYPEFLAG_FCANCREATE = 2
	TYPEFLAG_FLICENSED = 4
	TYPEFLAG_FPREDECLID = 8
	TYPEFLAG_FHIDDEN = 16
	TYPEFLAG_FCONTROL = 32
	TYPEFLAG_FDUAL = 64
	TYPEFLAG_FNONEXTENSIBLE = 128
	TYPEFLAG_FOLEAUTOMATION = 256
	TYPEFLAG_FRESTRICTED = 512
	TYPEFLAG_FAGGREGATABLE = 1024
	TYPEFLAG_FREPLACEABLE = 2048
	TYPEFLAG_FDISPATCHABLE = 4096
	TYPEFLAG_FREVERSEBIND = 8192
end enum

enum FUNCFLAGS
	FUNCFLAG_FRESTRICTED = 1
	FUNCFLAG_FSOURCE = 2
	FUNCFLAG_FBINDABLE = 4
	FUNCFLAG_FREQUESTEDIT = 8
	FUNCFLAG_FDISPLAYBIND = 16
	FUNCFLAG_FDEFAULTBIND = 32
	FUNCFLAG_FHIDDEN = 64
	FUNCFLAG_FUSESGETLASTERROR = 128
	FUNCFLAG_FDEFAULTCOLLELEM = 256
	FUNCFLAG_FUIDEFAULT = 512
	FUNCFLAG_FNONBROWSABLE = 1024
	FUNCFLAG_FREPLACEABLE = 2048
	FUNCFLAG_FIMMEDIATEBIND = 4096
end enum

enum VARFLAGS
	VARFLAG_FREADONLY = 1
	VARFLAG_FSOURCE = 2
	VARFLAG_FBINDABLE = 4
	VARFLAG_FREQUESTEDIT = 8
	VARFLAG_FDISPLAYBIND = 16
	VARFLAG_FDEFAULTBIND = 32
	VARFLAG_FHIDDEN = 64
	VARFLAG_FRESTRICTED = 128
	VARFLAG_FDEFAULTCOLLELEM = 256
	VARFLAG_FUIDEFAULT = 512
	VARFLAG_FNONBROWSABLE = 1024
	VARFLAG_FREPLACEABLE = 2048
	VARFLAG_FIMMEDIATEBIND = 4096
end enum

type CLEANLOCALSTORAGE
	pInterface as IUnknown ptr
	pStorage as PVOID
	flags as DWORD
end type

type CUSTDATAITEM
	guid as GUID
	varValue as VARIANTARG
end type

type LPCUSTDATAITEM as CUSTDATAITEM ptr

type CUSTDATA
	cCustData as DWORD
	prgCustData as LPCUSTDATAITEM
end type

type LPCUSTDATA as CUSTDATA ptr

enum DESCKIND
	DESCKIND_NONE = 0
	DESCKIND_FUNCDESC = DESCKIND_NONE+1
	DESCKIND_VARDESC = DESCKIND_FUNCDESC+1
	DESCKIND_TYPECOMP = DESCKIND_VARDESC+1
	DESCKIND_IMPLICITAPPOBJ = DESCKIND_TYPECOMP+1
	DESCKIND_MAX = DESCKIND_IMPLICITAPPOBJ+1
end enum

union BINDPTR
	lpfuncdesc as LPFUNCDESC
	lpvardesc as LPVARDESC
	lptcomp as LPTYPECOMP
end union

type LPBINDPTR as BINDPTR ptr

type IDispatchVtbl_ as IDispatchVtbl

type IDispatch
	lpVtbl as IDispatchVtbl_ ptr
end type

type IDispatchVtbl
	QueryInterface as function (byval as IDispatch ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IDispatch ptr) as ULONG
	Release as function (byval as IDispatch ptr) as ULONG
	GetTypeInfoCount as function (byval as IDispatch ptr, byval as UINT ptr) as HRESULT
	GetTypeInfo as function (byval as IDispatch ptr, byval as UINT, byval as LCID, byval as LPTYPEINFO ptr) as HRESULT
	GetIDsOfNames as function (byval as IDispatch ptr, byval as IID ptr, byval as LPOLESTR ptr, byval as UINT, byval as LCID, byval as DISPID ptr) as HRESULT
	Invoke as function (byval as IDispatch ptr, byval as DISPID, byval as IID ptr, byval as LCID, byval as WORD, byval as DISPPARAMS ptr, byval as VARIANT_ ptr, byval as EXCEPINFO ptr, byval as UINT ptr) as HRESULT
end type

type IEnumVARIANTVtbl_ as IEnumVARIANTVtbl

type IEnumVARIANT
	lpVtbl as IEnumVARIANTVtbl_ ptr
end type

type IEnumVARIANTVtbl
	QueryInterface as function (byval as IEnumVARIANT ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IEnumVARIANT ptr) as ULONG
	Release as function (byval as IEnumVARIANT ptr) as ULONG
	Next as function (byval as IEnumVARIANT ptr, byval as ULONG, byval as VARIANT_ ptr, byval as ULONG ptr) as HRESULT
	Skip as function (byval as IEnumVARIANT ptr, byval as ULONG) as HRESULT
	Reset as function (byval as IEnumVARIANT ptr) as HRESULT
	Clone as function (byval as IEnumVARIANT ptr, byval as IEnumVARIANT ptr ptr) as HRESULT
end type

type ITypeCompVtbl_ as ITypeCompVtbl

type ITypeComp
	lpVtbl as ITypeCompVtbl_ ptr
end type

type ITypeCompVtbl
	QueryInterface as function (byval as ITypeComp ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as ITypeComp ptr) as ULONG
	Release as function (byval as ITypeComp ptr) as ULONG
	Bind as function (byval as ITypeComp ptr, byval as LPOLESTR, byval as ULONG, byval as WORD, byval as LPTYPEINFO ptr, byval as DESCKIND ptr, byval as LPBINDPTR) as HRESULT
	BindType as function (byval as ITypeComp ptr, byval as LPOLESTR, byval as ULONG, byval as LPTYPEINFO ptr, byval as LPTYPECOMP ptr) as HRESULT
end type

type ITypeInfoVtbl_ as ITypeInfoVtbl

type ITypeInfo
	lpVtbl as ITypeInfoVtbl_ ptr
end type

type ITypeInfoVtbl
	QueryInterface as function (byval as ITypeInfo ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as ITypeInfo ptr) as ULONG
	Release as function (byval as ITypeInfo ptr) as ULONG
	GetTypeAttr as function (byval as ITypeInfo ptr, byval as LPTYPEATTR ptr) as HRESULT
	GetTypeComp as function (byval as ITypeInfo ptr, byval as LPTYPECOMP ptr) as HRESULT
	GetFuncDesc as function (byval as ITypeInfo ptr, byval as UINT, byval as LPFUNCDESC ptr) as HRESULT
	GetVarDesc as function (byval as ITypeInfo ptr, byval as UINT, byval as LPVARDESC ptr) as HRESULT
	GetNames as function (byval as ITypeInfo ptr, byval as MEMBERID, byval as BSTR ptr, byval as UINT, byval as UINT ptr) as HRESULT
	GetRefTypeOfImplType as function (byval as ITypeInfo ptr, byval as UINT, byval as HREFTYPE ptr) as HRESULT
	GetImplTypeFlags as function (byval as ITypeInfo ptr, byval as UINT, byval as INT_ ptr) as HRESULT
	GetIDsOfNames as function (byval as ITypeInfo ptr, byval as LPOLESTR ptr, byval as UINT, byval as MEMBERID ptr) as HRESULT
	Invoke as function (byval as ITypeInfo ptr, byval as PVOID, byval as MEMBERID, byval as WORD, byval as DISPPARAMS ptr, byval as VARIANT_ ptr, byval as EXCEPINFO ptr, byval as UINT ptr) as HRESULT
	GetDocumentation as function (byval as ITypeInfo ptr, byval as MEMBERID, byval as BSTR ptr, byval as BSTR ptr, byval as DWORD ptr, byval as BSTR ptr) as HRESULT
	GetDllEntry as function (byval as ITypeInfo ptr, byval as MEMBERID, byval as INVOKEKIND, byval as BSTR ptr, byval as BSTR ptr, byval as WORD ptr) as HRESULT
	GetRefTypeInfo as function (byval as ITypeInfo ptr, byval as HREFTYPE, byval as LPTYPEINFO ptr) as HRESULT
	AddressOfMember as function (byval as ITypeInfo ptr, byval as MEMBERID, byval as INVOKEKIND, byval as PVOID ptr) as HRESULT
	CreateInstance as function (byval as ITypeInfo ptr, byval as LPUNKNOWN, byval as IID ptr, byval as PVOID ptr) as HRESULT
	GetMops as function (byval as ITypeInfo ptr, byval as MEMBERID, byval as BSTR ptr) as HRESULT
	GetContainingTypeLib as function (byval as ITypeInfo ptr, byval as LPTYPELIB ptr, byval as UINT ptr) as HRESULT
	ReleaseTypeAttr as sub (byval as ITypeInfo ptr, byval as LPTYPEATTR)
	ReleaseFuncDesc as sub (byval as ITypeInfo ptr, byval as LPFUNCDESC)
	ReleaseVarDesc as sub (byval as ITypeInfo ptr, byval as LPVARDESC)
end type

type ITypeInfo2Vtbl_ as ITypeInfo2Vtbl

type ITypeInfo2
	lpVtbl as ITypeInfo2Vtbl_ ptr
end type

type ITypeInfo2Vtbl
	QueryInterface as function(byval as ITypeInfo2 ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as ITypeInfo2 ptr) as ULONG
	Release as function(byval as ITypeInfo2 ptr) as ULONG
	GetTypeAttr as function(byval as ITypeInfo2 ptr, byval as LPTYPEATTR ptr) as HRESULT
	GetTypeComp as function(byval as ITypeInfo2 ptr, byval as LPTYPECOMP ptr) as HRESULT
	GetFuncDesc as function(byval as ITypeInfo2 ptr, byval as UINT, byval as LPFUNCDESC ptr) as HRESULT
	GetVarDesc as function(byval as ITypeInfo2 ptr, byval as UINT, byval as LPVARDESC ptr) as HRESULT
	GetNames as function(byval as ITypeInfo2 ptr, byval as MEMBERID, byval as BSTR ptr, byval as UINT, byval as UINT ptr) as HRESULT
	GetRefTypeOfImplType as function(byval as ITypeInfo2 ptr, byval as UINT, byval as HREFTYPE ptr) as HRESULT
	GetImplTypeFlags as function(byval as ITypeInfo2 ptr, byval as UINT, byval as INT_ ptr) as HRESULT
	GetIDsOfNames as function(byval as ITypeInfo2 ptr, byval as LPOLESTR ptr, byval as UINT, byval as MEMBERID ptr) as HRESULT
	Invoke as function(byval as ITypeInfo2 ptr, byval as PVOID, byval as MEMBERID, byval as WORD, byval as DISPPARAMS ptr, byval as VARIANT_ ptr, byval as EXCEPINFO ptr, byval as UINT ptr) as HRESULT
	GetDocumentation as function(byval as ITypeInfo2 ptr, byval as MEMBERID, byval as BSTR ptr, byval as BSTR ptr, byval as DWORD ptr, byval as BSTR ptr) as HRESULT
	GetDllEntry as function(byval as ITypeInfo2 ptr, byval as MEMBERID, byval as INVOKEKIND, byval as BSTR ptr, byval as BSTR ptr, byval as WORD ptr) as HRESULT
	GetRefTypeInfo as function(byval as ITypeInfo2 ptr, byval as HREFTYPE, byval as LPTYPEINFO ptr) as HRESULT
	AddressOfMember as function(byval as ITypeInfo2 ptr, byval as MEMBERID, byval as INVOKEKIND, byval as PVOID ptr) as HRESULT
	CreateInstance as function(byval as ITypeInfo2 ptr, byval as LPUNKNOWN, byval as IID ptr, byval as PVOID ptr) as HRESULT
	GetMops as function(byval as ITypeInfo2 ptr, byval as MEMBERID, byval as BSTR ptr) as HRESULT
	GetContainingTypeLib as function(byval as ITypeInfo2 ptr, byval as LPTYPELIB ptr, byval as UINT ptr) as HRESULT
	ReleaseTypeAttr as sub(byval as ITypeInfo2 ptr, byval as LPTYPEATTR)
	ReleaseFuncDesc as sub(byval as ITypeInfo2 ptr, byval as LPFUNCDESC)
	ReleaseVarDesc as sub(byval as ITypeInfo2 ptr, byval as LPVARDESC)
	GetTypeKind as function(byval as ITypeInfo2 ptr, byval as TYPEKIND ptr) as HRESULT
	GetTypeFlags as function(byval as ITypeInfo2 ptr, byval as ULONG ptr) as HRESULT
	GetFuncIndexOfMemId as function(byval as ITypeInfo2 ptr, byval as MEMBERID, byval as INVOKEKIND, byval as UINT ptr) as HRESULT
	GetVarIndexOfMemId as function(byval as ITypeInfo2 ptr, byval as MEMBERID, byval as UINT ptr) as HRESULT
	GetCustData as function(byval as ITypeInfo2 ptr, byval as GUID ptr, byval as VARIANT_ ptr) as HRESULT
	GetFuncCustData as function(byval as ITypeInfo2 ptr, byval as UINT, byval as GUID ptr, byval as VARIANT_ ptr) as HRESULT
	GetParamCustData as function(byval as ITypeInfo2 ptr, byval as UINT, byval as UINT, byval as GUID ptr, byval as VARIANT_ ptr) as HRESULT
	GetVarCustData as function(byval as ITypeInfo2 ptr, byval as UINT, byval as GUID ptr, byval as VARIANT_ ptr) as HRESULT
	GetImplTypeCustData as function(byval as ITypeInfo2 ptr, byval as UINT, byval as GUID ptr, byval as VARIANT_ ptr) as HRESULT
	GetDocumentation2 as function(byval as ITypeInfo2 ptr, byval as MEMBERID, byval as LCID, byval as BSTR ptr, byval as DWORD ptr, byval as BSTR ptr) as HRESULT
	GetAllCustData as function(byval as ITypeInfo2 ptr, byval as CUSTDATA ptr) as HRESULT
	GetAllFuncCustData as function(byval as ITypeInfo2 ptr, byval as UINT, byval as CUSTDATA ptr) as HRESULT
	GetAllParamCustData as function(byval as ITypeInfo2 ptr, byval as UINT, byval as UINT, byval as CUSTDATA ptr) as HRESULT
	GetAllVarCustData as function(byval as ITypeInfo2 ptr, byval as UINT, byval as CUSTDATA ptr) as HRESULT
	GetAllImplTypeCustData as function(byval as ITypeInfo2 ptr, byval as UINT, byval as CUSTDATA ptr) as HRESULT
end type

type ITypeLibVtbl_ as ITypeLibVtbl

type ITypeLib
	lpVtbl as ITypeLibVtbl_ ptr
end type

type ITypeLibVtbl
	QueryInterface as function (byval as ITypeLib ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as ITypeLib ptr) as ULONG
	Release as function (byval as ITypeLib ptr) as ULONG
	GetTypeInfoCount as function (byval as ITypeLib ptr) as UINT
	GetTypeInfo as function (byval as ITypeLib ptr, byval as UINT, byval as ITypeInfo ptr ptr) as HRESULT
	GetTypeInfoType as function (byval as ITypeLib ptr, byval as UINT, byval as TYPEKIND ptr) as HRESULT
	GetTypeInfoOfGuid as function (byval as ITypeLib ptr, byval as GUID ptr, byval as ITypeInfo ptr ptr) as HRESULT
	GetLibAttr as function (byval as ITypeLib ptr, byval as TLIBATTR ptr ptr) as HRESULT
	GetTypeComp as function (byval as ITypeLib ptr, byval as ITypeComp ptr) as HRESULT
	GetDocumentation as function (byval as ITypeLib ptr, byval as INT_, byval as BSTR ptr, byval as BSTR ptr, byval as DWORD ptr, byval as BSTR ptr) as HRESULT
	IsName as function (byval as ITypeLib ptr, byval as LPOLESTR, byval as ULONG, byval as BOOL ptr) as HRESULT
	FindName as function (byval as ITypeLib ptr, byval as LPOLESTR, byval as ULONG, byval as ITypeInfo ptr ptr, byval as MEMBERID ptr, byval as USHORT ptr) as HRESULT
	ReleaseTLibAttr as sub (byval as ITypeLib ptr, byval as TLIBATTR ptr)
end type

type ITypeLib2Vtbl_ as ITypeLib2Vtbl

type ITypeLib2
	lpVtbl as ITypeLib2Vtbl_ ptr
end type

type ITypeLib2Vtbl
	QueryInterface as function(byval as ITypeLib2 ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as ITypeLib2 ptr) as ULONG
	Release as function(byval as ITypeLib2 ptr) as ULONG
	GetTypeInfoCount as function(byval as ITypeLib2 ptr) as UINT
	GetTypeInfo as function(byval as ITypeLib2 ptr, byval as UINT, byval as ITypeInfo ptr ptr) as HRESULT
	GetTypeInfoType as function(byval as ITypeLib2 ptr, byval as UINT, byval as TYPEKIND ptr) as HRESULT
	GetTypeInfoOfGuid as function(byval as ITypeLib2 ptr, byval as GUID ptr, byval as ITypeInfo ptr ptr) as HRESULT
	GetLibAttr as function(byval as ITypeLib2 ptr, byval as TLIBATTR ptr ptr) as HRESULT
	GetTypeComp as function(byval as ITypeLib2 ptr, byval as ITypeComp ptr) as HRESULT
	GetDocumentation as function(byval as ITypeLib2 ptr, byval as INT_, byval as BSTR ptr, byval as BSTR ptr, byval as DWORD ptr, byval as BSTR ptr) as HRESULT
	IsName as function(byval as ITypeLib2 ptr, byval as LPOLESTR, byval as ULONG, byval as BOOL ptr) as HRESULT
	FindName as function(byval as ITypeLib2 ptr, byval as LPOLESTR, byval as ULONG, byval as ITypeInfo ptr ptr, byval as MEMBERID ptr, byval as USHORT ptr) as HRESULT
	ReleaseTLibAttr as sub(byval as ITypeLib2 ptr, byval as TLIBATTR ptr)
	GetCustData as function(byval as ITypeLib2 ptr, byval as GUID ptr, byval as VARIANT_ ptr) as HRESULT
	GetLibStatistics as function(byval as ITypeLib2 ptr, byval as ULONG ptr, byval as ULONG ptr) as HRESULT
	GetDocumentation2 as function(byval as ITypeLib2 ptr, byval as INT_, byval as LCID, byval as BSTR ptr, byval as DWORD ptr, byval as BSTR ptr) as HRESULT
	GetAllCustData as function(byval as ITypeLib2 ptr, byval as CUSTDATA ptr) as HRESULT
end type

extern IID_IErrorInfo alias "IID_IErrorInfo" as IID

type IErrorInfoVtbl_ as IErrorInfoVtbl

type IErrorInfo
	lpVtbl as IErrorInfoVtbl_ ptr
end type

type IErrorInfoVtbl
	QueryInterface as function (byval as IErrorInfo ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IErrorInfo ptr) as ULONG
	Release as function (byval as IErrorInfo ptr) as ULONG
	GetGUID as function (byval as IErrorInfo ptr, byval as GUID ptr) as HRESULT
	GetSource as function (byval as IErrorInfo ptr, byval as BSTR ptr) as HRESULT
	GetDescription as function (byval as IErrorInfo ptr, byval as BSTR ptr) as HRESULT
	GetHelpFile as function (byval as IErrorInfo ptr, byval as BSTR ptr) as HRESULT
	GetHelpContext as function (byval as IErrorInfo ptr, byval as DWORD ptr) as HRESULT
end type
extern IID_ICreateErrorInfo alias "IID_ICreateErrorInfo" as IID

type ICreateErrorInfoVtbl_ as ICreateErrorInfoVtbl

type ICreateErrorInfo
	lpVtbl as ICreateErrorInfoVtbl_ ptr
end type

type ICreateErrorInfoVtbl
	QueryInterface as function (byval as ICreateErrorInfo ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as ICreateErrorInfo ptr) as ULONG
	Release as function (byval as ICreateErrorInfo ptr) as ULONG
	SetGUID as function (byval as ICreateErrorInfo ptr, byval as GUID ptr) as HRESULT
	SetSource as function (byval as ICreateErrorInfo ptr, byval as LPOLESTR) as HRESULT
	SetDescription as function (byval as ICreateErrorInfo ptr, byval as LPOLESTR) as HRESULT
	SetHelpFile as function (byval as ICreateErrorInfo ptr, byval as LPOLESTR) as HRESULT
	SetHelpContext as function (byval as ICreateErrorInfo ptr, byval as DWORD) as HRESULT
end type
extern IID_ISupportErrorInfo alias "IID_ISupportErrorInfo" as IID

type ISupportErrorInfoVtbl_ as ISupportErrorInfoVtbl

type ISupportErrorInfo
	lpVtbl as ISupportErrorInfoVtbl_ ptr
end type

type ISupportErrorInfoVtbl
	QueryInterface as function (byval as ISupportErrorInfo ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as ISupportErrorInfo ptr) as ULONG
	Release as function (byval as ISupportErrorInfo ptr) as ULONG
	InterfaceSupportsErrorInfo as function (byval as ISupportErrorInfo ptr, byval as IID ptr) as HRESULT
end type
extern IID_IRecordInfo alias "IID_IRecordInfo" as IID

type IRecordInfoVtbl_ as IRecordInfoVtbl

type IRecordInfo
	lpVtbl as IRecordInfoVtbl_ ptr
end type

type IRecordInfoVtbl
	QueryInterface as function (byval as IRecordInfo ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IRecordInfo ptr) as ULONG
	Release as function (byval as IRecordInfo ptr) as ULONG
	RecordInit as function (byval as IRecordInfo ptr, byval as PVOID) as HRESULT
	RecordClear as function (byval as IRecordInfo ptr, byval as PVOID) as HRESULT
	RecordCopy as function (byval as IRecordInfo ptr, byval as PVOID, byval as PVOID) as HRESULT
	GetGuid as function (byval as IRecordInfo ptr, byval as GUID ptr) as HRESULT
	GetName as function (byval as IRecordInfo ptr, byval as BSTR ptr) as HRESULT
	GetSize as function (byval as IRecordInfo ptr, byval as ULONG ptr) as HRESULT
	GetTypeInfo as function (byval as IRecordInfo ptr, byval as ITypeInfo ptr ptr) as HRESULT
	GetField as function (byval as IRecordInfo ptr, byval as PVOID, byval as LPCOLESTR, byval as VARIANT_ ptr) as HRESULT
	GetFieldNoCopy as function (byval as IRecordInfo ptr, byval as PVOID, byval as LPCOLESTR, byval as VARIANT_ ptr, byval as PVOID ptr) as HRESULT
	PutField as function (byval as IRecordInfo ptr, byval as ULONG, byval as PVOID, byval as LPCOLESTR, byval as VARIANT_ ptr) as HRESULT
	PutFieldNoCopy as function (byval as IRecordInfo ptr, byval as ULONG, byval as PVOID, byval as LPCOLESTR, byval as VARIANT_ ptr) as HRESULT
	GetFieldNames as function (byval as IRecordInfo ptr, byval as ULONG ptr, byval as BSTR ptr) as HRESULT
	IsMatchingType as function (byval as IRecordInfo ptr, byval as IRecordInfo ptr) as BOOL
	RecordCreate as function (byval as IRecordInfo ptr) as PVOID
	RecordCreateCopy as function (byval as IRecordInfo ptr, byval as PVOID, byval as PVOID ptr) as HRESULT
	RecordDestroy as function (byval as IRecordInfo ptr, byval as PVOID) as HRESULT
end type
extern IID_ITypeMarshal alias "IID_ITypeMarshal" as IID

type ITypeMarshalVtbl_ as ITypeMarshalVtbl

type ITypeMarshal
	lpVtbl as ITypeMarshalVtbl_ ptr
end type

type ITypeMarshalVtbl
	QueryInterface as function (byval as ITypeMarshal ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as ITypeMarshal ptr) as ULONG
	Release as function (byval as ITypeMarshal ptr) as ULONG
	Size as function (byval as ITypeMarshal ptr, byval as PVOID, byval as DWORD, byval as PVOID, byval as ULONG ptr) as HRESULT
	Marshal as function (byval as ITypeMarshal ptr, byval as PVOID, byval as DWORD, byval as PVOID, byval as ULONG, byval as UBYTE ptr, byval as ULONG ptr) as HRESULT
	Unmarshal as function (byval as ITypeMarshal ptr, byval as PVOID, byval as DWORD, byval as ULONG, byval as UBYTE ptr, byval as ULONG ptr) as HRESULT
	Free as function (byval as ITypeMarshal ptr, byval as PVOID) as HRESULT
end type

#endif
