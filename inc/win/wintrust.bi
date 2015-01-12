#pragma once

#include once "wincrypt.bi"

extern "C"

type WINTRUST_FILE_INFO_ as WINTRUST_FILE_INFO__
type WINTRUST_CATALOG_INFO_ as WINTRUST_CATALOG_INFO__
type WINTRUST_BLOB_INFO_ as WINTRUST_BLOB_INFO__
type WINTRUST_SGNR_INFO_ as WINTRUST_SGNR_INFO__
type WINTRUST_CERT_INFO_ as WINTRUST_CERT_INFO__
type _CRYPT_PROVIDER_DATA as _CRYPT_PROVIDER_DATA_
type _CRYPT_PROVIDER_SGNR as _CRYPT_PROVIDER_SGNR_
type _CRYPT_PROVIDER_PRIVDATA as _CRYPT_PROVIDER_PRIVDATA_
type _CRYPT_PROVIDER_FUNCTIONS as _CRYPT_PROVIDER_FUNCTIONS_
type _PROVDATA_SIP as _PROVDATA_SIP_
type _CRYPT_PROVUI_FUNCS as _CRYPT_PROVUI_FUNCS_
type _CRYPT_PROVUI_DATA as _CRYPT_PROVUI_DATA_
type _CRYPT_PROVIDER_CERT as _CRYPT_PROVIDER_CERT_
type SIP_DISPATCH_INFO_ as SIP_DISPATCH_INFO__
type SIP_SUBJECTINFO_ as SIP_SUBJECTINFO__
type SIP_INDIRECT_DATA_ as SIP_INDIRECT_DATA__
type _CRYPT_PROVIDER_DEFUSAGE as _CRYPT_PROVIDER_DEFUSAGE_

#define WINTRUST_H
#define WT_DEFINE_ALL_APIS

type _WINTRUST_DATA
	cbStruct as DWORD
	pPolicyCallbackData as LPVOID
	pSIPClientData as LPVOID
	dwUIChoice as DWORD
	fdwRevocationChecks as DWORD
	dwUnionChoice as DWORD

	union
		pFile as WINTRUST_FILE_INFO_ ptr
		pCatalog as WINTRUST_CATALOG_INFO_ ptr
		pBlob as WINTRUST_BLOB_INFO_ ptr
		pSgnr as WINTRUST_SGNR_INFO_ ptr
		pCert as WINTRUST_CERT_INFO_ ptr
	end union

	dwStateAction as DWORD
	hWVTStateData as HANDLE
	pwszURLReference as wstring ptr
	dwProvFlags as DWORD
	dwUIContext as DWORD
end type

type WINTRUST_DATA as _WINTRUST_DATA
type PWINTRUST_DATA as _WINTRUST_DATA ptr

#define WTD_UI_ALL 1
#define WTD_UI_NONE 2
#define WTD_UI_NOBAD 3
#define WTD_UI_NOGOOD 4
#define WTD_REVOKE_NONE &h00000000
#define WTD_REVOKE_WHOLECHAIN &h00000001
#define WTD_CHOICE_FILE 1
#define WTD_CHOICE_CATALOG 2
#define WTD_CHOICE_BLOB 3
#define WTD_CHOICE_SIGNER 4
#define WTD_CHOICE_CERT 5
#define WTD_STATEACTION_IGNORE &h00000000
#define WTD_STATEACTION_VERIFY &h00000001
#define WTD_STATEACTION_CLOSE &h00000002
#define WTD_STATEACTION_AUTO_CACHE &h00000003
#define WTD_STATEACTION_AUTO_CACHE_FLUSH &h00000004
#define WTD_PROV_FLAGS_MASK &h0000FFFF
#define WTD_USE_IE4_TRUST_FLAG &h00000001
#define WTD_NO_IE4_CHAIN_FLAG &h00000002
#define WTD_NO_POLICY_USAGE_FLAG &h00000004
#define WTD_REVOCATION_CHECK_NONE &h00000010
#define WTD_REVOCATION_CHECK_END_CERT &h00000020
#define WTD_REVOCATION_CHECK_CHAIN &h00000040
#define WTD_REVOCATION_CHECK_CHAIN_EXCLUDE_ROOT &h00000080
#define WTD_SAFER_FLAG &h00000100
#define WTD_HASH_ONLY_FLAG &h00000200
#define WTD_USE_DEFAULT_OSVER_CHECK &h00000400
#define WTD_LIFETIME_SIGNING_FLAG &h00000800
#define WTD_CACHE_ONLY_URL_RETRIEVAL &h00001000
#define WTD_UICONTEXT_EXECUTE 0
#define WTD_UICONTEXT_INSTALL 1

type WINTRUST_FILE_INFO__
	cbStruct as DWORD
	pcwszFilePath as LPCWSTR
	hFile as HANDLE
	pgKnownSubject as GUID ptr
end type

type WINTRUST_FILE_INFO as WINTRUST_FILE_INFO_
type PWINTRUST_FILE_INFO as WINTRUST_FILE_INFO_ ptr

type WINTRUST_CATALOG_INFO__
	cbStruct as DWORD
	dwCatalogVersion as DWORD
	pcwszCatalogFilePath as LPCWSTR
	pcwszMemberTag as LPCWSTR
	pcwszMemberFilePath as LPCWSTR
	hMemberFile as HANDLE
	pbCalculatedFileHash as UBYTE ptr
	cbCalculatedFileHash as DWORD
	pcCatalogContext as PCCTL_CONTEXT
end type

type WINTRUST_CATALOG_INFO as WINTRUST_CATALOG_INFO_
type PWINTRUST_CATALOG_INFO as WINTRUST_CATALOG_INFO_ ptr

type WINTRUST_BLOB_INFO__
	cbStruct as DWORD
	gSubject as GUID
	pcwszDisplayName as LPCWSTR
	cbMemObject as DWORD
	pbMemObject as UBYTE ptr
	cbMemSignedMsg as DWORD
	pbMemSignedMsg as UBYTE ptr
end type

type WINTRUST_BLOB_INFO as WINTRUST_BLOB_INFO_
type PWINTRUST_BLOB_INFO as WINTRUST_BLOB_INFO_ ptr

type WINTRUST_SGNR_INFO__
	cbStruct as DWORD
	pcwszDisplayName as LPCWSTR
	psSignerInfo as CMSG_SIGNER_INFO ptr
	chStores as DWORD
	pahStores as HCERTSTORE ptr
end type

type WINTRUST_SGNR_INFO as WINTRUST_SGNR_INFO_
type PWINTRUST_SGNR_INFO as WINTRUST_SGNR_INFO_ ptr

#define WTCI_DONT_OPEN_STORES &h00000001
#define WTCI_OPEN_ONLY_ROOT &h00000002

type WINTRUST_CERT_INFO__
	cbStruct as DWORD
	pcwszDisplayName as LPCWSTR
	psCertContext as CERT_CONTEXT ptr
	chStores as DWORD
	pahStores as HCERTSTORE ptr
	dwFlags as DWORD
	psftVerifyAsOf as FILETIME ptr
end type

type WINTRUST_CERT_INFO as WINTRUST_CERT_INFO_
type PWINTRUST_CERT_INFO as WINTRUST_CERT_INFO_ ptr

#ifdef __FB_64BIT__
	declare function WinVerifyTrust(byval hwnd as HWND, byval pgActionID as GUID ptr, byval pWVTData as LPVOID) as LONG
	declare function WinVerifyTrustEx(byval hwnd as HWND, byval pgActionID as GUID ptr, byval pWinTrustData as WINTRUST_DATA ptr) as HRESULT
#else
	declare function WinVerifyTrust stdcall(byval hwnd as HWND, byval pgActionID as GUID ptr, byval pWVTData as LPVOID) as LONG
	declare function WinVerifyTrustEx stdcall(byval hwnd as HWND, byval pgActionID as GUID ptr, byval pWinTrustData as WINTRUST_DATA ptr) as HRESULT
#endif

#define WTPF_TRUSTTEST &h00000020
#define WTPF_TESTCANBEVALID &h00000080
#define WTPF_IGNOREEXPIRATION &h00000100
#define WTPF_IGNOREREVOKATION &h00000200
#define WTPF_OFFLINEOK_IND &h00000400
#define WTPF_OFFLINEOK_COM &h00000800
#define WTPF_OFFLINEOKNBU_IND &h00001000
#define WTPF_OFFLINEOKNBU_COM &h00002000
#define WTPF_VERIFY_V1_OFF &h00010000
#define WTPF_IGNOREREVOCATIONONTS &h00020000
#define WTPF_ALLOWONLYPERTRUST &h00040000

#ifdef __FB_64BIT__
	declare sub WintrustGetRegPolicyFlags(byval pdwPolicyFlags as DWORD ptr)
	declare function WintrustSetRegPolicyFlags(byval dwPolicyFlags as DWORD) as WINBOOL
#else
	declare sub WintrustGetRegPolicyFlags stdcall(byval pdwPolicyFlags as DWORD ptr)
	declare function WintrustSetRegPolicyFlags stdcall(byval dwPolicyFlags as DWORD) as WINBOOL
#endif

#define TRUSTERROR_STEP_WVTPARAMS 0
#define TRUSTERROR_STEP_FILEIO 2
#define TRUSTERROR_STEP_SIP 3
#define TRUSTERROR_STEP_SIPSUBJINFO 5
#define TRUSTERROR_STEP_CATALOGFILE 6
#define TRUSTERROR_STEP_CERTSTORE 7
#define TRUSTERROR_STEP_MESSAGE 8
#define TRUSTERROR_STEP_MSG_SIGNERCOUNT 9
#define TRUSTERROR_STEP_MSG_INNERCNTTYPE 10
#define TRUSTERROR_STEP_MSG_INNERCNT 11
#define TRUSTERROR_STEP_MSG_STORE 12
#define TRUSTERROR_STEP_MSG_SIGNERINFO 13
#define TRUSTERROR_STEP_MSG_SIGNERCERT 14
#define TRUSTERROR_STEP_MSG_CERTCHAIN 15
#define TRUSTERROR_STEP_MSG_COUNTERSIGINFO 16
#define TRUSTERROR_STEP_MSG_COUNTERSIGCERT 17
#define TRUSTERROR_STEP_VERIFY_MSGHASH 18
#define TRUSTERROR_STEP_VERIFY_MSGINDIRECTDATA 19
#define TRUSTERROR_STEP_FINAL_WVTINIT 30
#define TRUSTERROR_STEP_FINAL_INITPROV 31
#define TRUSTERROR_STEP_FINAL_OBJPROV 32
#define TRUSTERROR_STEP_FINAL_SIGPROV 33
#define TRUSTERROR_STEP_FINAL_CERTPROV 34
#define TRUSTERROR_STEP_FINAL_CERTCHKPROV 35
#define TRUSTERROR_STEP_FINAL_POLICYPROV 36
#define TRUSTERROR_STEP_FINAL_UIPROV 37
#define TRUSTERROR_MAX_STEPS 38

type PFN_CPD_MEM_ALLOC as function(byval cbSize as DWORD) as any ptr
type PFN_CPD_MEM_FREE as sub(byval pvMem2Free as any ptr)
type PFN_CPD_ADD_STORE as function(byval pProvData as _CRYPT_PROVIDER_DATA ptr, byval hStore2Add as HCERTSTORE) as WINBOOL
type PFN_CPD_ADD_SGNR as function(byval pProvData as _CRYPT_PROVIDER_DATA ptr, byval fCounterSigner as WINBOOL, byval idxSigner as DWORD, byval pSgnr2Add as _CRYPT_PROVIDER_SGNR ptr) as WINBOOL
type PFN_CPD_ADD_CERT as function(byval pProvData as _CRYPT_PROVIDER_DATA ptr, byval idxSigner as DWORD, byval fCounterSigner as WINBOOL, byval idxCounterSigner as DWORD, byval pCert2Add as PCCERT_CONTEXT) as WINBOOL
type PFN_CPD_ADD_PRIVDATA as function(byval pProvData as _CRYPT_PROVIDER_DATA ptr, byval pPrivData2Add as _CRYPT_PROVIDER_PRIVDATA ptr) as WINBOOL
type PFN_PROVIDER_INIT_CALL as function(byval pProvData as _CRYPT_PROVIDER_DATA ptr) as HRESULT
type PFN_PROVIDER_OBJTRUST_CALL as function(byval pProvData as _CRYPT_PROVIDER_DATA ptr) as HRESULT
type PFN_PROVIDER_SIGTRUST_CALL as function(byval pProvData as _CRYPT_PROVIDER_DATA ptr) as HRESULT
type PFN_PROVIDER_CERTTRUST_CALL as function(byval pProvData as _CRYPT_PROVIDER_DATA ptr) as HRESULT
type PFN_PROVIDER_FINALPOLICY_CALL as function(byval pProvData as _CRYPT_PROVIDER_DATA ptr) as HRESULT
type PFN_PROVIDER_TESTFINALPOLICY_CALL as function(byval pProvData as _CRYPT_PROVIDER_DATA ptr) as HRESULT
type PFN_PROVIDER_CLEANUP_CALL as function(byval pProvData as _CRYPT_PROVIDER_DATA ptr) as HRESULT
type PFN_PROVIDER_CERTCHKPOLICY_CALL as function(byval pProvData as _CRYPT_PROVIDER_DATA ptr, byval idxSigner as DWORD, byval fCounterSignerChain as WINBOOL, byval idxCounterSigner as DWORD) as WINBOOL

#define WVT_OFFSETOF(t, f) cast(ULONG, cast(ULONG_PTR, @cptr(t ptr, 0)->f))
#define WVT_ISINSTRUCT(structtypedef, structpassedsize, member) iif(WVT_OFFSETOF(structtypedef, member) < structpassedsize, TRUE, FALSE)
#define WVT_IS_CBSTRUCT_GT_MEMBEROFFSET(structtypedef, structpassedsize, member) WVT_ISINSTRUCT(structtypedef, structpassedsize, member)

type _CRYPT_PROVIDER_DATA_
	cbStruct as DWORD
	pWintrustData as WINTRUST_DATA ptr
	fOpenedFile as WINBOOL
	hWndParent as HWND
	pgActionID as GUID ptr
	hProv as HCRYPTPROV
	dwError as DWORD
	dwRegSecuritySettings as DWORD
	dwRegPolicySettings as DWORD
	psPfns as _CRYPT_PROVIDER_FUNCTIONS ptr
	cdwTrustStepErrors as DWORD
	padwTrustStepErrors as DWORD ptr
	chStores as DWORD
	pahStores as HCERTSTORE ptr
	dwEncoding as DWORD
	hMsg as HCRYPTMSG
	csSigners as DWORD
	pasSigners as _CRYPT_PROVIDER_SGNR ptr
	csProvPrivData as DWORD
	pasProvPrivData as _CRYPT_PROVIDER_PRIVDATA ptr
	dwSubjectChoice as DWORD

	union
		pPDSip as _PROVDATA_SIP ptr
	end union

	pszUsageOID as zstring ptr
	fRecallWithState as WINBOOL
	sftSystemTime as FILETIME
	pszCTLSignerUsageOID as zstring ptr
	dwProvFlags as DWORD
	dwFinalError as DWORD
	pRequestUsage as PCERT_USAGE_MATCH
	dwTrustPubSettings as DWORD
	dwUIStateFlags as DWORD
end type

type CRYPT_PROVIDER_DATA as _CRYPT_PROVIDER_DATA
type PCRYPT_PROVIDER_DATA as _CRYPT_PROVIDER_DATA ptr

#define CPD_CHOICE_SIP 1
#define CPD_USE_NT5_CHAIN_FLAG &h80000000
#define CPD_REVOCATION_CHECK_NONE &h00010000
#define CPD_REVOCATION_CHECK_END_CERT &h00020000
#define CPD_REVOCATION_CHECK_CHAIN &h00040000
#define CPD_REVOCATION_CHECK_CHAIN_EXCLUDE_ROOT &h00080000
#define CPD_UISTATE_MODE_PROMPT &h00000000
#define CPD_UISTATE_MODE_BLOCK &h00000001
#define CPD_UISTATE_MODE_ALLOW &h00000002
#define CPD_UISTATE_MODE_MASK &h00000003

type _CRYPT_PROVIDER_FUNCTIONS_
	cbStruct as DWORD
	pfnAlloc as PFN_CPD_MEM_ALLOC
	pfnFree as PFN_CPD_MEM_FREE
	pfnAddStore2Chain as PFN_CPD_ADD_STORE
	pfnAddSgnr2Chain as PFN_CPD_ADD_SGNR
	pfnAddCert2Chain as PFN_CPD_ADD_CERT
	pfnAddPrivData2Chain as PFN_CPD_ADD_PRIVDATA
	pfnInitialize as PFN_PROVIDER_INIT_CALL
	pfnObjectTrust as PFN_PROVIDER_OBJTRUST_CALL
	pfnSignatureTrust as PFN_PROVIDER_SIGTRUST_CALL
	pfnCertificateTrust as PFN_PROVIDER_CERTTRUST_CALL
	pfnFinalPolicy as PFN_PROVIDER_FINALPOLICY_CALL
	pfnCertCheckPolicy as PFN_PROVIDER_CERTCHKPOLICY_CALL
	pfnTestFinalPolicy as PFN_PROVIDER_TESTFINALPOLICY_CALL
	psUIpfns as _CRYPT_PROVUI_FUNCS ptr
	pfnCleanupPolicy as PFN_PROVIDER_CLEANUP_CALL
end type

type CRYPT_PROVIDER_FUNCTIONS as _CRYPT_PROVIDER_FUNCTIONS
type PCRYPT_PROVIDER_FUNCTIONS as _CRYPT_PROVIDER_FUNCTIONS ptr
type PFN_PROVUI_CALL as function(byval hWndSecurityDialog as HWND, byval pProvData as _CRYPT_PROVIDER_DATA ptr) as WINBOOL

type _CRYPT_PROVUI_FUNCS_
	cbStruct as DWORD
	psUIData as _CRYPT_PROVUI_DATA ptr
	pfnOnMoreInfoClick as PFN_PROVUI_CALL
	pfnOnMoreInfoClickDefault as PFN_PROVUI_CALL
	pfnOnAdvancedClick as PFN_PROVUI_CALL
	pfnOnAdvancedClickDefault as PFN_PROVUI_CALL
end type

type CRYPT_PROVUI_FUNCS as _CRYPT_PROVUI_FUNCS
type PCRYPT_PROVUI_FUNCS as _CRYPT_PROVUI_FUNCS ptr

type _CRYPT_PROVUI_DATA_
	cbStruct as DWORD
	dwFinalError as DWORD
	pYesButtonText as wstring ptr
	pNoButtonText as wstring ptr
	pMoreInfoButtonText as wstring ptr
	pAdvancedLinkText as wstring ptr
	pCopyActionText as wstring ptr
	pCopyActionTextNoTS as wstring ptr
	pCopyActionTextNotSigned as wstring ptr
end type

type CRYPT_PROVUI_DATA as _CRYPT_PROVUI_DATA
type PCRYPT_PROVUI_DATA as _CRYPT_PROVUI_DATA ptr

#define SGNR_TYPE_TIMESTAMP &h00000010

type _CRYPT_PROVIDER_SGNR_
	cbStruct as DWORD
	sftVerifyAsOf as FILETIME
	csCertChain as DWORD
	pasCertChain as _CRYPT_PROVIDER_CERT ptr
	dwSignerType as DWORD
	psSigner as CMSG_SIGNER_INFO ptr
	dwError as DWORD
	csCounterSigners as DWORD
	pasCounterSigners as _CRYPT_PROVIDER_SGNR ptr
	pChainContext as PCCERT_CHAIN_CONTEXT
end type

type CRYPT_PROVIDER_SGNR as _CRYPT_PROVIDER_SGNR
type PCRYPT_PROVIDER_SGNR as _CRYPT_PROVIDER_SGNR ptr

#define CERT_CONFIDENCE_SIG &h10000000
#define CERT_CONFIDENCE_TIME &h01000000
#define CERT_CONFIDENCE_TIMENEST &h00100000
#define CERT_CONFIDENCE_AUTHIDEXT &h00010000
#define CERT_CONFIDENCE_HYGIENE &h00001000
#define CERT_CONFIDENCE_HIGHEST &h11111000

type _CRYPT_PROVIDER_CERT_
	cbStruct as DWORD
	pCert as PCCERT_CONTEXT
	fCommercial as WINBOOL
	fTrustedRoot as WINBOOL
	fSelfSigned as WINBOOL
	fTestCert as WINBOOL
	dwRevokedReason as DWORD
	dwConfidence as DWORD
	dwError as DWORD
	pTrustListContext as CTL_CONTEXT ptr
	fTrustListSignerCert as WINBOOL
	pCtlContext as PCCTL_CONTEXT
	dwCtlError as DWORD
	fIsCyclic as WINBOOL
	pChainElement as PCERT_CHAIN_ELEMENT
end type

type CRYPT_PROVIDER_CERT as _CRYPT_PROVIDER_CERT
type PCRYPT_PROVIDER_CERT as _CRYPT_PROVIDER_CERT ptr

type _CRYPT_PROVIDER_PRIVDATA_
	cbStruct as DWORD
	gProviderID as GUID
	cbProvData as DWORD
	pvProvData as any ptr
end type

type CRYPT_PROVIDER_PRIVDATA as _CRYPT_PROVIDER_PRIVDATA
type PCRYPT_PROVIDER_PRIVDATA as _CRYPT_PROVIDER_PRIVDATA ptr

type _PROVDATA_SIP_
	cbStruct as DWORD
	gSubject as GUID
	pSip as SIP_DISPATCH_INFO_ ptr
	pCATSip as SIP_DISPATCH_INFO_ ptr
	psSipSubjectInfo as SIP_SUBJECTINFO_ ptr
	psSipCATSubjectInfo as SIP_SUBJECTINFO_ ptr
	psIndirectData as SIP_INDIRECT_DATA_ ptr
end type

type PROVDATA_SIP as _PROVDATA_SIP
type PPROVDATA_SIP as _PROVDATA_SIP ptr

#define WT_CURRENT_VERSION &h00000200

type _CRYPT_TRUST_REG_ENTRY
	cbStruct as DWORD
	pwszDLLName as wstring ptr
	pwszFunctionName as wstring ptr
end type

type CRYPT_TRUST_REG_ENTRY as _CRYPT_TRUST_REG_ENTRY
type PCRYPT_TRUST_REG_ENTRY as _CRYPT_TRUST_REG_ENTRY ptr

type _CRYPT_REGISTER_ACTIONID
	cbStruct as DWORD
	sInitProvider as CRYPT_TRUST_REG_ENTRY
	sObjectProvider as CRYPT_TRUST_REG_ENTRY
	sSignatureProvider as CRYPT_TRUST_REG_ENTRY
	sCertificateProvider as CRYPT_TRUST_REG_ENTRY
	sCertificatePolicyProvider as CRYPT_TRUST_REG_ENTRY
	sFinalPolicyProvider as CRYPT_TRUST_REG_ENTRY
	sTestPolicyProvider as CRYPT_TRUST_REG_ENTRY
	sCleanupProvider as CRYPT_TRUST_REG_ENTRY
end type

type CRYPT_REGISTER_ACTIONID as _CRYPT_REGISTER_ACTIONID
type PCRYPT_REGISTER_ACTIONID as _CRYPT_REGISTER_ACTIONID ptr
type PFN_ALLOCANDFILLDEFUSAGE as function(byval pszUsageOID as const zstring ptr, byval psDefUsage as _CRYPT_PROVIDER_DEFUSAGE ptr) as WINBOOL
type PFN_FREEDEFUSAGE as function(byval pszUsageOID as const zstring ptr, byval psDefUsage as _CRYPT_PROVIDER_DEFUSAGE ptr) as WINBOOL

type _CRYPT_PROVIDER_REGDEFUSAGE
	cbStruct as DWORD
	pgActionID as GUID ptr
	pwszDllName as wstring ptr
	pwszLoadCallbackDataFunctionName as zstring ptr
	pwszFreeCallbackDataFunctionName as zstring ptr
end type

type CRYPT_PROVIDER_REGDEFUSAGE as _CRYPT_PROVIDER_REGDEFUSAGE
type PCRYPT_PROVIDER_REGDEFUSAGE as _CRYPT_PROVIDER_REGDEFUSAGE ptr

type _CRYPT_PROVIDER_DEFUSAGE_
	cbStruct as DWORD
	gActionID as GUID
	pDefPolicyCallbackData as LPVOID
	pDefSIPClientData as LPVOID
end type

type CRYPT_PROVIDER_DEFUSAGE as _CRYPT_PROVIDER_DEFUSAGE
type PCRYPT_PROVIDER_DEFUSAGE as _CRYPT_PROVIDER_DEFUSAGE ptr

#ifdef __FB_64BIT__
	declare function WintrustAddActionID(byval pgActionID as GUID ptr, byval fdwFlags as DWORD, byval psProvInfo as CRYPT_REGISTER_ACTIONID ptr) as WINBOOL
#else
	declare function WintrustAddActionID stdcall(byval pgActionID as GUID ptr, byval fdwFlags as DWORD, byval psProvInfo as CRYPT_REGISTER_ACTIONID ptr) as WINBOOL
#endif

#define WT_PROVIDER_DLL_NAME wstr("WINTRUST.DLL")
#define WT_PROVIDER_CERTTRUST_FUNCTION wstr("WintrustCertificateTrust")
#define WT_ADD_ACTION_ID_RET_RESULT_FLAG &h1

#ifdef __FB_64BIT__
	declare function WintrustRemoveActionID(byval pgActionID as GUID ptr) as WINBOOL
	declare function WintrustLoadFunctionPointers(byval pgActionID as GUID ptr, byval pPfns as CRYPT_PROVIDER_FUNCTIONS ptr) as WINBOOL
	declare function WintrustAddDefaultForUsage(byval pszUsageOID as const zstring ptr, byval psDefUsage as CRYPT_PROVIDER_REGDEFUSAGE ptr) as WINBOOL
#else
	declare function WintrustRemoveActionID stdcall(byval pgActionID as GUID ptr) as WINBOOL
	declare function WintrustLoadFunctionPointers stdcall(byval pgActionID as GUID ptr, byval pPfns as CRYPT_PROVIDER_FUNCTIONS ptr) as WINBOOL
	declare function WintrustAddDefaultForUsage stdcall(byval pszUsageOID as const zstring ptr, byval psDefUsage as CRYPT_PROVIDER_REGDEFUSAGE ptr) as WINBOOL
#endif

#define DWACTION_ALLOCANDFILL 1
#define DWACTION_FREE 2

#ifdef __FB_64BIT__
	declare function WintrustGetDefaultForUsage(byval dwAction as DWORD, byval pszUsageOID as const zstring ptr, byval psUsage as CRYPT_PROVIDER_DEFUSAGE ptr) as WINBOOL
	declare function WTHelperGetProvSignerFromChain(byval pProvData as CRYPT_PROVIDER_DATA ptr, byval idxSigner as DWORD, byval fCounterSigner as WINBOOL, byval idxCounterSigner as DWORD) as CRYPT_PROVIDER_SGNR ptr
	declare function WTHelperGetProvCertFromChain(byval pSgnr as CRYPT_PROVIDER_SGNR ptr, byval idxCert as DWORD) as CRYPT_PROVIDER_CERT ptr
	declare function WTHelperProvDataFromStateData(byval hStateData as HANDLE) as CRYPT_PROVIDER_DATA ptr
	declare function WTHelperGetProvPrivateDataFromChain(byval pProvData as CRYPT_PROVIDER_DATA ptr, byval pgProviderID as GUID ptr) as CRYPT_PROVIDER_PRIVDATA ptr
	declare function WTHelperCertIsSelfSigned(byval dwEncoding as DWORD, byval pCert as CERT_INFO ptr) as WINBOOL
	declare function WTHelperCertCheckValidSignature(byval pProvData as CRYPT_PROVIDER_DATA ptr) as HRESULT
#else
	declare function WintrustGetDefaultForUsage stdcall(byval dwAction as DWORD, byval pszUsageOID as const zstring ptr, byval psUsage as CRYPT_PROVIDER_DEFUSAGE ptr) as WINBOOL
	declare function WTHelperGetProvSignerFromChain stdcall(byval pProvData as CRYPT_PROVIDER_DATA ptr, byval idxSigner as DWORD, byval fCounterSigner as WINBOOL, byval idxCounterSigner as DWORD) as CRYPT_PROVIDER_SGNR ptr
	declare function WTHelperGetProvCertFromChain stdcall(byval pSgnr as CRYPT_PROVIDER_SGNR ptr, byval idxCert as DWORD) as CRYPT_PROVIDER_CERT ptr
	declare function WTHelperProvDataFromStateData stdcall(byval hStateData as HANDLE) as CRYPT_PROVIDER_DATA ptr
	declare function WTHelperGetProvPrivateDataFromChain stdcall(byval pProvData as CRYPT_PROVIDER_DATA ptr, byval pgProviderID as GUID ptr) as CRYPT_PROVIDER_PRIVDATA ptr
	declare function WTHelperCertIsSelfSigned stdcall(byval dwEncoding as DWORD, byval pCert as CERT_INFO ptr) as WINBOOL
	declare function WTHelperCertCheckValidSignature stdcall(byval pProvData as CRYPT_PROVIDER_DATA ptr) as HRESULT
#endif

#define szOID_TRUSTED_CODESIGNING_CA_LIST "1.3.6.1.4.1.311.2.2.1"
#define szOID_TRUSTED_CLIENT_AUTH_CA_LIST "1.3.6.1.4.1.311.2.2.2"
#define szOID_TRUSTED_SERVER_AUTH_CA_LIST "1.3.6.1.4.1.311.2.2.3"
#define SPC_COMMON_NAME_OBJID szOID_COMMON_NAME
#define SPC_TIME_STAMP_REQUEST_OBJID "1.3.6.1.4.1.311.3.2.1"
#define SPC_INDIRECT_DATA_OBJID "1.3.6.1.4.1.311.2.1.4"
#define SPC_SP_AGENCY_INFO_OBJID "1.3.6.1.4.1.311.2.1.10"
#define SPC_STATEMENT_TYPE_OBJID "1.3.6.1.4.1.311.2.1.11"
#define SPC_SP_OPUS_INFO_OBJID "1.3.6.1.4.1.311.2.1.12"
#define SPC_CERT_EXTENSIONS_OBJID "1.3.6.1.4.1.311.2.1.14"
#define SPC_PE_IMAGE_DATA_OBJID "1.3.6.1.4.1.311.2.1.15"
#define SPC_RAW_FILE_DATA_OBJID "1.3.6.1.4.1.311.2.1.18"
#define SPC_STRUCTURED_STORAGE_DATA_OBJID "1.3.6.1.4.1.311.2.1.19"
#define SPC_JAVA_CLASS_DATA_OBJID "1.3.6.1.4.1.311.2.1.20"
#define SPC_INDIVIDUAL_SP_KEY_PURPOSE_OBJID "1.3.6.1.4.1.311.2.1.21"
#define SPC_COMMERCIAL_SP_KEY_PURPOSE_OBJID "1.3.6.1.4.1.311.2.1.22"
#define SPC_CAB_DATA_OBJID "1.3.6.1.4.1.311.2.1.25"
#define SPC_GLUE_RDN_OBJID "1.3.6.1.4.1.311.2.1.25"
#define SPC_MINIMAL_CRITERIA_OBJID "1.3.6.1.4.1.311.2.1.26"
#define SPC_FINANCIAL_CRITERIA_OBJID "1.3.6.1.4.1.311.2.1.27"
#define SPC_LINK_OBJID "1.3.6.1.4.1.311.2.1.28"
#define SPC_SIGINFO_OBJID "1.3.6.1.4.1.311.2.1.30"
#define CAT_NAMEVALUE_OBJID "1.3.6.1.4.1.311.12.2.1"
#define CAT_MEMBERINFO_OBJID "1.3.6.1.4.1.311.12.2.2"
#define SPC_SP_AGENCY_INFO_STRUCT cast(LPCSTR, 2000)
#define SPC_MINIMAL_CRITERIA_STRUCT cast(LPCSTR, 2001)
#define SPC_FINANCIAL_CRITERIA_STRUCT cast(LPCSTR, 2002)
#define SPC_INDIRECT_DATA_CONTENT_STRUCT cast(LPCSTR, 2003)
#define SPC_PE_IMAGE_DATA_STRUCT cast(LPCSTR, 2004)
#define SPC_LINK_STRUCT cast(LPCSTR, 2005)
#define SPC_STATEMENT_TYPE_STRUCT cast(LPCSTR, 2006)
#define SPC_SP_OPUS_INFO_STRUCT cast(LPCSTR, 2007)
#define SPC_CAB_DATA_STRUCT cast(LPCSTR, 2008)
#define SPC_JAVA_CLASS_DATA_STRUCT cast(LPCSTR, 2009)
#define SPC_SIGINFO_STRUCT cast(LPCSTR, 2130)
#define CAT_NAMEVALUE_STRUCT cast(LPCSTR, 2221)
#define CAT_MEMBERINFO_STRUCT cast(LPCSTR, 2222)
#define SPC_UUID_LENGTH 16

type _SPC_SERIALIZED_OBJECT
	ClassId(0 to 15) as UBYTE
	SerializedData as CRYPT_DATA_BLOB
end type

type SPC_SERIALIZED_OBJECT as _SPC_SERIALIZED_OBJECT
type PSPC_SERIALIZED_OBJECT as _SPC_SERIALIZED_OBJECT ptr

type SPC_SIGINFO_
	dwSipVersion as DWORD
	gSIPGuid as GUID
	dwReserved1 as DWORD
	dwReserved2 as DWORD
	dwReserved3 as DWORD
	dwReserved4 as DWORD
	dwReserved5 as DWORD
end type

type SPC_SIGINFO as SPC_SIGINFO_
type PSPC_SIGINFO as SPC_SIGINFO_ ptr

#define SPC_URL_LINK_CHOICE 1
#define SPC_MONIKER_LINK_CHOICE 2
#define SPC_FILE_LINK_CHOICE 3

type SPC_LINK_
	dwLinkChoice as DWORD

	union
		pwszUrl as LPWSTR
		Moniker as SPC_SERIALIZED_OBJECT
		pwszFile as LPWSTR
	end union
end type

type SPC_LINK as SPC_LINK_
type PSPC_LINK as SPC_LINK_ ptr

type _SPC_PE_IMAGE_DATA
	Flags as CRYPT_BIT_BLOB
	pFile as PSPC_LINK
end type

type SPC_PE_IMAGE_DATA as _SPC_PE_IMAGE_DATA
type PSPC_PE_IMAGE_DATA as _SPC_PE_IMAGE_DATA ptr

type _SPC_INDIRECT_DATA_CONTENT
	Data as CRYPT_ATTRIBUTE_TYPE_VALUE
	DigestAlgorithm as CRYPT_ALGORITHM_IDENTIFIER
	Digest as CRYPT_HASH_BLOB
end type

type SPC_INDIRECT_DATA_CONTENT as _SPC_INDIRECT_DATA_CONTENT
type PSPC_INDIRECT_DATA_CONTENT as _SPC_INDIRECT_DATA_CONTENT ptr

type _SPC_FINANCIAL_CRITERIA
	fFinancialInfoAvailable as WINBOOL
	fMeetsCriteria as WINBOOL
end type

type SPC_FINANCIAL_CRITERIA as _SPC_FINANCIAL_CRITERIA
type PSPC_FINANCIAL_CRITERIA as _SPC_FINANCIAL_CRITERIA ptr

type _SPC_IMAGE
	pImageLink as SPC_LINK_ ptr
	Bitmap as CRYPT_DATA_BLOB
	Metafile as CRYPT_DATA_BLOB
	EnhancedMetafile as CRYPT_DATA_BLOB
	GifFile as CRYPT_DATA_BLOB
end type

type SPC_IMAGE as _SPC_IMAGE
type PSPC_IMAGE as _SPC_IMAGE ptr

type _SPC_SP_AGENCY_INFO
	pPolicyInformation as SPC_LINK_ ptr
	pwszPolicyDisplayText as LPWSTR
	pLogoImage as PSPC_IMAGE
	pLogoLink as SPC_LINK_ ptr
end type

type SPC_SP_AGENCY_INFO as _SPC_SP_AGENCY_INFO
type PSPC_SP_AGENCY_INFO as _SPC_SP_AGENCY_INFO ptr

type _SPC_STATEMENT_TYPE
	cKeyPurposeId as DWORD
	rgpszKeyPurposeId as LPSTR ptr
end type

type SPC_STATEMENT_TYPE as _SPC_STATEMENT_TYPE
type PSPC_STATEMENT_TYPE as _SPC_STATEMENT_TYPE ptr

type _SPC_SP_OPUS_INFO
	pwszProgramName as LPCWSTR
	pMoreInfo as SPC_LINK_ ptr
	pPublisherInfo as SPC_LINK_ ptr
end type

type SPC_SP_OPUS_INFO as _SPC_SP_OPUS_INFO
type PSPC_SP_OPUS_INFO as _SPC_SP_OPUS_INFO ptr

type _CAT_NAMEVALUE
	pwszTag as LPWSTR
	fdwFlags as DWORD
	Value as CRYPT_DATA_BLOB
end type

type CAT_NAMEVALUE as _CAT_NAMEVALUE
type PCAT_NAMEVALUE as _CAT_NAMEVALUE ptr

type _CAT_MEMBERINFO
	pwszSubjGuid as LPWSTR
	dwCertVersion as DWORD
end type

type CAT_MEMBERINFO as _CAT_MEMBERINFO
type PCAT_MEMBERINFO as _CAT_MEMBERINFO ptr

type _WIN_CERTIFICATE
	dwLength as DWORD
	wRevision as WORD
	wCertificateType as WORD
	bCertificate(0 to 0) as UBYTE
end type

type WIN_CERTIFICATE as _WIN_CERTIFICATE
type LPWIN_CERTIFICATE as _WIN_CERTIFICATE ptr

#define WIN_CERT_REVISION_1_0 &h0100
#define WIN_CERT_REVISION_2_0 &h0200
#define WIN_CERT_TYPE_X509 &h0001
#define WIN_CERT_TYPE_PKCS_SIGNED_DATA &h0002
#define WIN_CERT_TYPE_RESERVED_1 &h0003
#define WIN_CERT_TYPE_TS_STACK_SIGNED &h0004

type WIN_TRUST_SUBJECT as LPVOID

type _WIN_TRUST_ACTDATA_CONTEXT_WITH_SUBJECT
	hClientToken as HANDLE
	SubjectType as GUID ptr
	Subject as WIN_TRUST_SUBJECT
end type

type WIN_TRUST_ACTDATA_CONTEXT_WITH_SUBJECT as _WIN_TRUST_ACTDATA_CONTEXT_WITH_SUBJECT
type LPWIN_TRUST_ACTDATA_CONTEXT_WITH_SUBJECT as _WIN_TRUST_ACTDATA_CONTEXT_WITH_SUBJECT ptr

type _WIN_TRUST_ACTDATA_SUBJECT_ONLY
	SubjectType as GUID ptr
	Subject as WIN_TRUST_SUBJECT
end type

type WIN_TRUST_ACTDATA_SUBJECT_ONLY as _WIN_TRUST_ACTDATA_SUBJECT_ONLY
type LPWIN_TRUST_ACTDATA_SUBJECT_ONLY as _WIN_TRUST_ACTDATA_SUBJECT_ONLY ptr

#define WIN_TRUST_SUBJTYPE_RAW_FILE (&h959dc450, &h8d9e, &h11cf, (&h87, &h36, &h00, &haa, &h00, &ha4, &h85, &heb))
#define WIN_TRUST_SUBJTYPE_PE_IMAGE (&h43c9a1e0, &h8da0, &h11cf, (&h87, &h36, &h00, &haa, &h00, &ha4, &h85, &heb))
#define WIN_TRUST_SUBJTYPE_JAVA_CLASS (&h08ad3990, &h8da1, &h11cf, (&h87, &h36, &h00, &haa, &h00, &ha4, &h85, &heb))
#define WIN_TRUST_SUBJTYPE_CABINET (&hd17c5374, &ha392, &h11cf, (&h9d, &hf5, &h0, &haa, &h0, &hc1, &h84, &he0))

type _WIN_TRUST_SUBJECT_FILE
	hFile as HANDLE
	lpPath as LPCWSTR
end type

type WIN_TRUST_SUBJECT_FILE as _WIN_TRUST_SUBJECT_FILE
type LPWIN_TRUST_SUBJECT_FILE as _WIN_TRUST_SUBJECT_FILE ptr

#define WIN_TRUST_SUBJTYPE_RAW_FILEEX (&h6f458110, &hc2f1, &h11cf, (&h8a, &h69, &h0, &haa, &h0, &h6c, &h37, &h6))
#define WIN_TRUST_SUBJTYPE_PE_IMAGEEX (&h6f458111, &hc2f1, &h11cf, (&h8a, &h69, &h0, &haa, &h0, &h6c, &h37, &h6))
#define WIN_TRUST_SUBJTYPE_JAVA_CLASSEX (&h6f458113, &hc2f1, &h11cf, (&h8a, &h69, &h0, &haa, &h0, &h6c, &h37, &h6))
#define WIN_TRUST_SUBJTYPE_CABINETEX (&h6f458114, &hc2f1, &h11cf, (&h8a, &h69, &h0, &haa, &h0, &h6c, &h37, &h6))

type _WIN_TRUST_SUBJECT_FILE_AND_DISPLAY
	hFile as HANDLE
	lpPath as LPCWSTR
	lpDisplayName as LPCWSTR
end type

type WIN_TRUST_SUBJECT_FILE_AND_DISPLAY as _WIN_TRUST_SUBJECT_FILE_AND_DISPLAY
type LPWIN_TRUST_SUBJECT_FILE_AND_DISPLAY as _WIN_TRUST_SUBJECT_FILE_AND_DISPLAY ptr

#define WIN_TRUST_SUBJTYPE_OLE_STORAGE (&hc257e740, &h8da0, &h11cf, (&h87, &h36, &h00, &haa, &h00, &ha4, &h85, &heb))
#define WIN_SPUB_ACTION_TRUSTED_PUBLISHER (&h66426730, &h8da1, &h11cf, (&h87, &h36, &h00, &haa, &h00, &ha4, &h85, &heb))
#define WIN_SPUB_ACTION_NT_ACTIVATE_IMAGE (&h8bc96b00, &h8da1, &h11cf, (&h87, &h36, &h00, &haa, &h00, &ha4, &h85, &heb))
#define WIN_SPUB_ACTION_PUBLISHED_SOFTWARE (&h64b9d180, &h8da2, &h11cf, (&h87, &h36, &h00, &haa, &h00, &ha4, &h85, &heb))

type _WIN_SPUB_TRUSTED_PUBLISHER_DATA
	hClientToken as HANDLE
	lpCertificate as LPWIN_CERTIFICATE
end type

type WIN_SPUB_TRUSTED_PUBLISHER_DATA as _WIN_SPUB_TRUSTED_PUBLISHER_DATA
type LPWIN_SPUB_TRUSTED_PUBLISHER_DATA as _WIN_SPUB_TRUSTED_PUBLISHER_DATA ptr

#if defined(__FB_64BIT__) and (_WIN32_WINNT = &h0602)
	declare sub WintrustSetDefaultIncludePEPageHashes(byval fIncludePEPageHashes as WINBOOL)
#elseif (not defined(__FB_64BIT__)) and (_WIN32_WINNT = &h0602)
	declare sub WintrustSetDefaultIncludePEPageHashes stdcall(byval fIncludePEPageHashes as WINBOOL)
#endif

end extern
