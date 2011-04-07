''
''
'' winldap -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_winldap_bi__
#define __win_winldap_bi__

#inclib "wldap32"

#include once "win/schannel.bi"
#include once "win/winber.bi"

#define LDAP_VERSION1 1
#define LDAP_VERSION2 2
#define LDAP_VERSION3 3
#define LDAP_VERSION 2
#define LDAP_API_VERSION 2004
#define LDAP_VERSION_MIN 2
#define LDAP_VERSION_MAX 3
#define LDAP_VENDOR_NAME "Microsoft Corporation."
#define LDAP_VENDOR_VERSION 510
#define LDAP_API_INFO_VERSION 1
#define LDAP_FEATURE_INFO_VERSION 1
#define LDAP_SUCCESS &h00
#define LDAP_OPERATIONS_ERROR &h01
#define LDAP_PROTOCOL_ERROR &h02
#define LDAP_TIMELIMIT_EXCEEDED &h03
#define LDAP_SIZELIMIT_EXCEEDED &h04
#define LDAP_COMPARE_FALSE &h05
#define LDAP_COMPARE_TRUE &h06
#define LDAP_STRONG_AUTH_NOT_SUPPORTED &h07
#define LDAP_STRONG_AUTH_REQUIRED &h08
#define LDAP_REFERRAL_V2 &h09
#define LDAP_REFERRAL &h0a
#define LDAP_ADMIN_LIMIT_EXCEEDED &h&b
#define LDAP_UNAVAILABLE_CRIT_EXTENSION &h0c
#define LDAP_CONFIDENTIALITY_REQUIRED &h0d
#define LDAP_SASL_BIND_IN_PROGRESS &h0e
#define LDAP_NO_SUCH_ATTRIBUTE &h10
#define LDAP_UNDEFINED_TYPE &h11
#define LDAP_INAPPROPRIATE_MATCHING &h12
#define LDAP_CONSTRAINT_VIOLATION &h13
#define LDAP_TYPE_OR_VALUE_EXISTS &h14
#define LDAP_INVALID_SYNTAX &h15
#define LDAP_NO_SUCH_OBJECT &h20
#define LDAP_ALIAS_PROBLEM &h21
#define LDAP_INVALID_DN_SYNTAX &h22
#define LDAP_IS_LEAF &h23
#define LDAP_ALIAS_DEREF_PROBLEM &h24
#define LDAP_INAPPROPRIATE_AUTH &h30
#define LDAP_INVALID_CREDENTIALS &h31
#define LDAP_INSUFFICIENT_ACCESS &h32
#define LDAP_BUSY &h33
#define LDAP_UNAVAILABLE &h34
#define LDAP_UNWILLING_TO_PERFORM &h35
#define LDAP_LOOP_DETECT &h36
#define LDAP_NAMING_VIOLATION &h40
#define LDAP_OBJECT_CLASS_VIOLATION &h41
#define LDAP_NOT_ALLOWED_ON_NONLEAF &h42
#define LDAP_NOT_ALLOWED_ON_RDN &h43
#define LDAP_ALREADY_EXISTS &h44
#define LDAP_NO_OBJECT_CLASS_MODS &h45
#define LDAP_RESULTS_TOO_LARGE &h46
#define LDAP_AFFECTS_MULTIPLE_DSAS &h47
#define LDAP_OTHER &h50
#define LDAP_SERVER_DOWN &h51
#define LDAP_LOCAL_ERROR &h52
#define LDAP_ENCODING_ERROR &h53
#define LDAP_DECODING_ERROR &h54
#define LDAP_TIMEOUT &h55
#define LDAP_AUTH_UNKNOWN &h56
#define LDAP_FILTER_ERROR &h57
#define LDAP_USER_CANCELLED &h58
#define LDAP_PARAM_ERROR &h59
#define LDAP_NO_MEMORY &h5a
#define LDAP_CONNECT_ERROR &h5b
#define LDAP_NOT_SUPPORTED &h5c
#define LDAP_CONTROL_NOT_FOUND &h5d
#define LDAP_NO_RESULTS_RETURNED &h5e
#define LDAP_MORE_RESULTS_TO_RETURN &h5f
#define LDAP_CLIENT_LOOP &h60
#define LDAP_REFERRAL_LIMIT_EXCEEDED &h61
#define LDAP_OPT_SUCCESS &h00
#define LDAP_AUTH_METHOD_NOT_SUPPORTED &h07
#define LDAP_ATTRIBUTE_OR_VALUE_EXISTS &h14
#define LDAP_INSUFFICIENT_RIGHTS &h32
#define LDAP_PARTIAL_RESULTS &h09
#define LDAP_PORT 389
#define LDAP_SSL_PORT 636
#define LDAP_GC_PORT 3268
#define LDAP_SSL_GC_PORT 3269
#define LDAP_OPT_API_INFO &h00
#define LDAP_OPT_DESC &h01
#define LDAP_OPT_DEREF &h02
#define LDAP_OPT_SIZELIMIT &h03
#define LDAP_OPT_TIMELIMIT &h04
#define LDAP_OPT_THREAD_FN_PTRS &h05
#define LDAP_OPT_REBIND_FN &h06
#define LDAP_OPT_REBIND_ARG &h07
#define LDAP_OPT_REFERRALS &h08
#define LDAP_OPT_RESTART &h09
#define LDAP_OPT_SSL &h0a
#define LDAP_OPT_IO_FN_PTRS &h&b
#define LDAP_OPT_CACHE_FN_PTRS &h0d
#define LDAP_OPT_CACHE_STRATEGY &h0e
#define LDAP_OPT_CACHE_ENABLE &h0f
#define LDAP_OPT_REFERRAL_HOP_LIMIT &h10
#define LDAP_OPT_PROTOCOL_VERSION &h11
#define LDAP_OPT_SERVER_CONTROLS &h12
#define LDAP_OPT_CLIENT_CONTROLS &h13
#define LDAP_OPT_API_FEATURE_INFO &h15
#define LDAP_OPT_HOST_NAME &h30
#define LDAP_OPT_ERROR_NUMBER &h31
#define LDAP_OPT_ERROR_STRING &h32
#define LDAP_OPT_SERVER_ERROR &h33
#define LDAP_OPT_SERVER_EXT_ERROR &h34
#define LDAP_OPT_PING_KEEP_ALIVE &h36
#define LDAP_OPT_PING_WAIT_TIME &h37
#define LDAP_OPT_PING_LIMIT &h38
#define LDAP_OPT_DNSDOMAIN_NAME &h3b
#define LDAP_OPT_GETDSNAME_FLAGS &h3d
#define LDAP_OPT_HOST_REACHABLE &h3e
#define LDAP_OPT_PROMPT_CREDENTIALS &h3f
#define LDAP_OPT_TCP_KEEPALIVE &h40
#define LDAP_OPT_REFERRAL_CALLBACK &h70
#define LDAP_OPT_CLIENT_CERTIFICATE &h80
#define LDAP_OPT_SERVER_CERTIFICATE &h81
#define LDAP_OPT_AUTO_RECONNECT &h91
#define LDAP_OPT_SSPI_FLAGS &h92
#define LDAP_OPT_SSL_INFO &h93
#define LDAP_OPT_REF_DEREF_CONN_PER_MSG &h94
#define LDAP_OPT_SIGN &h95
#define LDAP_OPT_ENCRYPT &h96
#define LDAP_OPT_SASL_METHOD &h97
#define LDAP_OPT_AREC_EXCLUSIVE &h98
#define LDAP_OPT_SECURITY_CONTEXT &h99
#define LDAP_OPT_ROOTDSE_CACHE &h9a
#define LDAP_OPT_VERSION &h11
#define LDAP_OPT_TLS &h0a
#define LDAP_OPT_TLS_INFO &h93
#define LDAP_DEREF_NEVER &h00
#define LDAP_DEREF_SEARCHING &h01
#define LDAP_DEREF_FINDING &h02
#define LDAP_DEREF_ALWAYS &h03
#define LDAP_NO_LIMIT 0
#define LDAP_CONTROL_REFERRALS "1.2.840.113556.1.4.616"
#define LDAP_CHASE_SUBORDINATE_REFERRALS &h20U
#define LDAP_CHASE_EXTERNAL_REFERRALS &h40U
#define LDAP_SCOPE_DEFAULT -1
#define LDAP_SCOPE_BASE &h0000
#define LDAP_SCOPE_ONELEVEL &h0001
#define LDAP_SCOPE_SUBTREE &h0002
#define LDAP_MOD_ADD &h00
#define LDAP_MOD_DELETE &h01
#define LDAP_MOD_REPLACE &h02
#define LDAP_MOD_BVALUES &h80
#define LDAP_RES_BIND &h61
#define LDAP_RES_SEARCH_ENTRY &h64
#define LDAP_RES_SEARCH_RESULT &h65
#define LDAP_RES_MODIFY &h67
#define LDAP_RES_ADD &h69
#define LDAP_RES_DELETE &h6b
#define LDAP_RES_MODRDN &h6d
#define LDAP_RES_COMPARE &h6f
#define LDAP_RES_SEARCH_REFERENCE &h73
#define LDAP_RES_EXTENDED &h78
#define LDAP_RES_ANY (-1L)
#define LDAP_MSG_ONE &h00
#define LDAP_MSG_ALL &h01
#define LDAP_MSG_RECEIVED &h02
#define LDAP_SERVER_SORT_OID "1.2.840.113556.1.4.473"
#define LDAP_SERVER_RESP_SORT_OID "1.2.840.113556.1.4.474"
#define LDAP_PAGED_RESULT_OID_STRING "1.2.840.113556.1.4.319"
#define LDAP_CONTROL_VLVREQUEST "2.16.840.1.113730.3.4.9"
#define LDAP_CONTROL_VLVRESPONSE "2.16.840.1.113730.3.4.10"
#define LDAP_START_TLS_OID "1.3.6.1.4.1.1466.20037"
#define LDAP_TTL_EXTENDED_OP_OID "1.3.6.1.4.1.1466.101.119.1"
#define LDAP_AUTH_NONE &h00U
#define LDAP_AUTH_SIMPLE &h80U
#define LDAP_AUTH_SASL &h83U
#define LDAP_AUTH_OTHERKIND &h86U
#define LDAP_AUTH_EXTERNAL (&h86U or &h20U)
#define LDAP_AUTH_SICILY (&h86U or &h200U)
#define LDAP_AUTH_NEGOTIATE (&h86U or &h400U)
#define LDAP_AUTH_MSN (&h86U or &h800U)
#define LDAP_AUTH_NTLM (&h86U or &h1000U)
#define LDAP_AUTH_DIGEST (&h86U or &h4000U)
#define LDAP_AUTH_DPA (&h86U or &h2000U)
#define LDAP_AUTH_SSPI (&h86U or &h400U)
#define LDAP_FILTER_AND &ha0
#define LDAP_FILTER_OR &ha1
#define LDAP_FILTER_NOT &ha2
#define LDAP_FILTER_EQUALITY &ha3
#define LDAP_FILTER_SUBSTRINGS &ha4
#define LDAP_FILTER_GE &ha5
#define LDAP_FILTER_LE &ha6
#define LDAP_FILTER_APPROX &ha8
#define LDAP_FILTER_EXTENSIBLE &ha9
#define LDAP_FILTER_PRESENT &h87
#define LDAP_SUBSTRING_INITIAL &h80
#define LDAP_SUBSTRING_ANY &h81
#define LDAP_SUBSTRING_FINAL &h82

type LDAP
	Reserved as zstring * 76
	ld_host as PCHAR
	ld_version as ULONG
	ld_lberoptions as UCHAR
	ld_deref as integer
	ld_timelimit as integer
	ld_sizelimit as integer
	ld_errno as integer
	ld_matched as PCHAR
	ld_error as PCHAR
end type

type PLDAP as LDAP ptr

type LDAPMessage
	lm_msgid as ULONG
	lm_msgtype as ULONG
	lm_ber as BerElement ptr
	lm_chain as LDAPMessage ptr
	lm_next as LDAPMessage ptr
	lm_time as ULONG
end type

type PLDAPMessage as LDAPMessage ptr

type LDAP_TIMEVAL
	tv_sec as LONG
	tv_usec as LONG
end type

type PLDAP_TIMEVAL as LDAP_TIMEVAL ptr

#ifndef UNICODE
type LDAPAPIInfoA
	ldapai_info_version as integer
	ldapai_api_version as integer
	ldapai_protocol_version as integer
	ldapai_extensions as byte ptr ptr
	ldapai_vendor_name as zstring ptr
	ldapai_vendor_version as integer
end type

type PLDAPAPIInfoA as LDAPAPIInfoA ptr

#else
type LDAPAPIInfoW
	ldapai_info_version as integer
	ldapai_api_version as integer
	ldapai_protocol_version as integer
	ldapai_extensions as PWCHAR ptr
	ldapai_vendor_name as PWCHAR
	ldapai_vendor_version as integer
end type

type PLDAPAPIInfoW as LDAPAPIInfoW ptr
#endif

#ifndef UNICODE
type LDAPAPIFeatureInfoA
	ldapaif_info_version as integer
	ldapaif_name as zstring ptr
	ldapaif_version as integer
end type

type PLDAPAPIFeatureInfoA as LDAPAPIFeatureInfoA ptr

#else
type LDAPAPIFeatureInfoW
	ldapaif_info_version as integer
	ldapaif_name as PWCHAR
	ldapaif_version as integer
end type

type PLDAPAPIFeatureInfoW as LDAPAPIFeatureInfoW ptr
#endif

#ifndef UNICODE
type LDAPControlA
	ldctl_oid as PCHAR
	ldctl_value as BerValue
	ldctl_iscritical as BOOLEAN
end type

type PLDAPControlA as LDAPControlA ptr

#else
type LDAPControlW
	ldctl_oid as PWCHAR
	ldctl_value as BerValue
	ldctl_iscritical as BOOLEAN
end type

type PLDAPControlW as LDAPControlW ptr
#endif

#ifndef UNICODE
union mod_vals_uA
	modv_strvals as PCHAR ptr
	modv_bvals as BerValue ptr ptr
end union

type LDAPModA
	mod_op as ULONG
	mod_type as PCHAR
	mod_vals as mod_vals_uA
end type

type PLDAPModA as LDAPModA ptr

#else
union mod_vals_uW
	modv_strvals as PWCHAR ptr
	modv_bvals as BerValue ptr ptr
end union

type LDAPModW
	mod_op as ULONG
	mod_type as PWCHAR
	mod_vals as mod_vals_uW
end type

type PLDAPModW as LDAPModW ptr
#endif

#define mod_values      mod_vals.modv_strvals
#define mod_bvalues     mod_vals.modv_bvals

type PLDAPSearch as LDAPSearch ptr

#ifndef UNICODE
type LDAPSortKeyA
	sk_attrtype as PCHAR
	sk_matchruleoid as PCHAR
	sk_reverseorder as BOOLEAN
end type

type PLDAPSortKeyA as LDAPSortKeyA ptr

#else
type LDAPSortKeyW
	sk_attrtype as PWCHAR
	sk_matchruleoid as PWCHAR
	sk_reverseorder as BOOLEAN
end type

type PLDAPSortKeyW as LDAPSortKeyW ptr
#endif

type QUERYFORCONNECTION as ULONG
type NOTIFYOFNEWCONNECTION as BOOLEAN
type DEREFERENCECONNECTION as ULONG
type QUERYCLIENTCERT as BOOLEAN

type LDAP_REFERRAL_CALLBACK
	SizeOfCallbacks as ULONG
	QueryForConnection as QUERYFORCONNECTION ptr
	NotifyRoutine as NOTIFYOFNEWCONNECTION ptr
	DereferenceRoutine as DEREFERENCECONNECTION ptr
end type

type PLDAP_REFERRAL_CALLBACK as LDAP_REFERRAL_CALLBACK ptr

type LDAPVLVInfo
	ldvlv_version as integer
	ldvlv_before_count as uinteger
	ldvlv_after_count as uinteger
	ldvlv_offset as uinteger
	ldvlv_count as uinteger
	ldvlv_attrvalue as BerValue ptr
	ldvlv_context as BerValue ptr
	ldvlv_extradata as any ptr
end type

declare function ldap_connect alias "ldap_connect" (byval as LDAP ptr, byval as LDAP_TIMEVAL ptr) as ULONG
declare function ldap_stop_tls_s alias "ldap_stop_tls_s" (byval as LDAP ptr) as BOOLEAN
declare function ldap_unbind alias "ldap_unbind" (byval as LDAP ptr) as ULONG
declare function ldap_unbind_s alias "ldap_unbind_s" (byval as LDAP ptr) as ULONG
declare function ldap_close_extended_op alias "ldap_close_extended_op" (byval as LDAP ptr, byval as ULONG) as ULONG
declare function ldap_abandon alias "ldap_abandon" (byval as LDAP ptr, byval as ULONG) as ULONG
declare function ldap_result alias "ldap_result" (byval as LDAP ptr, byval as ULONG, byval as ULONG, byval as LDAP_TIMEVAL ptr, byval as LDAPMessage ptr ptr) as ULONG
declare function ldap_msgfree alias "ldap_msgfree" (byval as LDAPMessage ptr) as ULONG
declare function LdapGetLastError alias "LdapGetLastError" () as ULONG
declare function LdapMapErrorToWin32 alias "LdapMapErrorToWin32" (byval as ULONG) as ULONG
declare function ldap_result2error alias "ldap_result2error" (byval as LDAP ptr, byval as LDAPMessage ptr, byval as ULONG) as ULONG
declare function ldap_first_entry alias "ldap_first_entry" (byval as LDAP ptr, byval as LDAPMessage ptr) as PLDAPMessage
declare function ldap_next_entry alias "ldap_next_entry" (byval as LDAP ptr, byval as LDAPMessage ptr) as PLDAPMessage
declare function ldap_first_reference alias "ldap_first_reference" (byval as LDAP ptr, byval as LDAPMessage ptr) as PLDAPMessage
declare function ldap_next_reference alias "ldap_next_reference" (byval as LDAP ptr, byval as LDAPMessage ptr) as PLDAPMessage
declare function ldap_count_entries alias "ldap_count_entries" (byval as LDAP ptr, byval as LDAPMessage ptr) as ULONG
declare function ldap_count_references alias "ldap_count_references" (byval as LDAP ptr, byval as LDAPMessage ptr) as ULONG
declare function ldap_value_free_len alias "ldap_value_free_len" (byval as berval ptr ptr) as ULONG
declare function ldap_get_next_page alias "ldap_get_next_page" (byval as PLDAP, byval as PLDAPSearch, byval as ULONG, byval as ULONG ptr) as ULONG
declare function ldap_get_next_page_s alias "ldap_get_next_page_s" (byval as PLDAP, byval as PLDAPSearch, byval as LDAP_TIMEVAL ptr, byval as ULONG, byval as ULONG ptr, byval as LDAPMessage ptr ptr) as ULONG
declare function ldap_get_paged_count alias "ldap_get_paged_count" (byval as PLDAP, byval as PLDAPSearch, byval as ULONG ptr, byval as PLDAPMessage) as ULONG
declare function ldap_search_abandon_page alias "ldap_search_abandon_page" (byval as PLDAP, byval as PLDAPSearch) as ULONG
declare function ldap_conn_from_msg alias "ldap_conn_from_msg" (byval as LDAP ptr, byval as LDAPMessage ptr) as LDAP
declare function LdapUnicodeToUTF8 alias "LdapUnicodeToUTF8" (byval as LPCWSTR, byval as integer, byval as LPSTR, byval as integer) as INT_
declare function LdapUTF8ToUnicode alias "LdapUTF8ToUnicode" (byval as LPCSTR, byval as integer, byval as LPWSTR, byval as integer) as INT_
declare function ldap_count_values_len alias "ldap_count_values_len" (byval as berval ptr ptr) as ULONG

#ifdef UNICODE
declare function ldap_init alias "ldap_initW" (byval as PWCHAR, byval as ULONG) as PLDAP
declare function ldap_open alias "ldap_openW" (byval as PWCHAR, byval as ULONG) as PLDAP
declare function cldap_open alias "cldap_openW" (byval as PWCHAR, byval as ULONG) as PLDAP
declare function ldap_sslinit alias "ldap_sslinitW" (byval as PWCHAR, byval as ULONG, byval as integer) as PLDAP
declare function ldap_start_tls_s alias "ldap_start_tls_sW" (byval as LDAP ptr, byval as PLDAPControlW ptr, byval as PLDAPControlW ptr) as ULONG
declare function ldap_get_option alias "ldap_get_optionW" (byval as LDAP ptr, byval as integer, byval as any ptr) as ULONG
declare function ldap_set_option alias "ldap_set_optionW" (byval as LDAP ptr, byval as integer, byval as any ptr) as ULONG
declare function ldap_control_free alias "ldap_control_freeW" (byval as LDAPControlW ptr) as ULONG
declare function ldap_controls_free alias "ldap_controls_freeW" (byval as LDAPControlW ptr ptr) as ULONG
declare function ldap_free_controls alias "ldap_free_controlsW" (byval as LDAPControlW ptr ptr) as ULONG
declare function ldap_sasl_bind alias "ldap_sasl_bindW" (byval as LDAP ptr, byval as PWCHAR, byval as PWCHAR, byval as BERVAL ptr, byval as PLDAPControlW ptr, byval as PLDAPControlW ptr, byval as integer ptr) as ULONG
declare function ldap_sasl_bind_s alias "ldap_sasl_bind_sW" (byval as LDAP ptr, byval as PWCHAR, byval as PWCHAR, byval as BERVAL ptr, byval as PLDAPControlW ptr, byval as PLDAPControlW ptr, byval as PBERVAL ptr) as ULONG
declare function ldap_simple_bind alias "ldap_simple_bindW" (byval as LDAP ptr, byval as PWCHAR, byval as PWCHAR) as ULONG
declare function ldap_simple_bind_s alias "ldap_simple_bind_sW" (byval as LDAP ptr, byval as PWCHAR, byval as PWCHAR) as ULONG
declare function ldap_bind alias "ldap_bindW" (byval as LDAP ptr, byval as PWCHAR, byval as PWCHAR, byval as ULONG) as ULONG
declare function ldap_bind_s alias "ldap_bind_sW" (byval as LDAP ptr, byval as PWCHAR, byval as PWCHAR, byval as ULONG) as ULONG
declare function ldap_search_ext alias "ldap_search_extW" (byval as LDAP ptr, byval as PWCHAR, byval as ULONG, byval as PWCHAR, byval as PWCHAR ptr, byval as ULONG, byval as PLDAPControlW ptr, byval as PLDAPControlW ptr, byval as ULONG, byval as ULONG, byval as ULONG ptr) as ULONG
declare function ldap_search_ext_s alias "ldap_search_ext_sW" (byval as LDAP ptr, byval as PWCHAR, byval as ULONG, byval as PWCHAR, byval as PWCHAR ptr, byval as ULONG, byval as PLDAPControlW ptr, byval as PLDAPControlW ptr, byval as LDAP_TIMEVAL ptr, byval as ULONG, byval as LDAPMessage ptr ptr) as ULONG
declare function ldap_search alias "ldap_searchW" (byval as LDAP ptr, byval as PWCHAR, byval as ULONG, byval as PWCHAR, byval as PWCHAR ptr, byval as ULONG) as ULONG
declare function ldap_search_s alias "ldap_search_sW" (byval as LDAP ptr, byval as PWCHAR, byval as ULONG, byval as PWCHAR, byval as PWCHAR ptr, byval as ULONG, byval as LDAPMessage ptr ptr) as ULONG
declare function ldap_search_st alias "ldap_search_stW" (byval as LDAP ptr, byval as PWCHAR, byval as ULONG, byval as PWCHAR, byval as PWCHAR ptr, byval as ULONG, byval as LDAP_TIMEVAL ptr, byval as LDAPMessage ptr ptr) as ULONG
declare function ldap_compare_ext alias "ldap_compare_extW" (byval as LDAP ptr, byval as PWCHAR, byval as PWCHAR, byval as PWCHAR, byval as berval ptr, byval as PLDAPControlW ptr, byval as PLDAPControlW ptr, byval as ULONG ptr) as ULONG
declare function ldap_compare_ext_s alias "ldap_compare_ext_sW" (byval as LDAP ptr, byval as PWCHAR, byval as PWCHAR, byval as PWCHAR, byval as berval ptr, byval as PLDAPControlW ptr, byval as PLDAPControlW ptr) as ULONG
declare function ldap_compare alias "ldap_compareW" (byval as LDAP ptr, byval as PWCHAR, byval as PWCHAR, byval as PWCHAR) as ULONG
declare function ldap_compare_s alias "ldap_compare_sW" (byval as LDAP ptr, byval as PWCHAR, byval as PWCHAR, byval as PWCHAR) as ULONG
declare function ldap_modify_ext alias "ldap_modify_extW" (byval as LDAP ptr, byval as PWCHAR, byval as LDAPModW ptr ptr, byval as PLDAPControlW ptr, byval as PLDAPControlW ptr, byval as ULONG ptr) as ULONG
declare function ldap_modify_ext_s alias "ldap_modify_ext_sW" (byval as LDAP ptr, byval as PWCHAR, byval as LDAPModW ptr ptr, byval as PLDAPControlW ptr, byval as PLDAPControlW ptr) as ULONG
declare function ldap_modify alias "ldap_modifyW" (byval as LDAP ptr, byval as PWCHAR, byval as LDAPModW ptr ptr) as ULONG
declare function ldap_modify_s alias "ldap_modify_sW" (byval as LDAP ptr, byval as PWCHAR, byval as LDAPModW ptr ptr) as ULONG
declare function ldap_rename_ext alias "ldap_rename_extW" (byval as LDAP ptr, byval as PWCHAR, byval as PWCHAR, byval as PWCHAR, byval as INT_, byval as PLDAPControlW ptr, byval as PLDAPControlW ptr, byval as ULONG ptr) as ULONG
declare function ldap_rename_ext_s alias "ldap_rename_ext_sW" (byval as LDAP ptr, byval as PWCHAR, byval as PWCHAR, byval as PWCHAR, byval as INT_, byval as PLDAPControlW ptr, byval as PLDAPControlW ptr) as ULONG
declare function ldap_modrdn alias "ldap_modrdnW" (byval as LDAP ptr, byval as PWCHAR, byval as PWCHAR) as ULONG
declare function ldap_modrdn_s alias "ldap_modrdn_sW" (byval as LDAP ptr, byval as PWCHAR, byval as PWCHAR) as ULONG
declare function ldap_modrdn2 alias "ldap_modrdn2W" (byval as LDAP ptr, byval as PWCHAR, byval as PWCHAR, byval as INT_) as ULONG
declare function ldap_modrdn2_s alias "ldap_modrdn2_sW" (byval as LDAP ptr, byval as PWCHAR, byval as PWCHAR, byval as INT_) as ULONG
declare function ldap_add_ext alias "ldap_add_extW" (byval as LDAP ptr, byval as PWCHAR, byval as LDAPModW ptr ptr, byval as PLDAPControlW ptr, byval as PLDAPControlW ptr, byval as ULONG ptr) as ULONG
declare function ldap_add_ext_s alias "ldap_add_ext_sW" (byval as LDAP ptr, byval as PWCHAR, byval as LDAPModW ptr ptr, byval as PLDAPControlW ptr, byval as PLDAPControlW ptr) as ULONG
declare function ldap_add alias "ldap_addW" (byval as LDAP ptr, byval as PWCHAR, byval as LDAPModW ptr ptr) as ULONG
declare function ldap_add_s alias "ldap_add_sW" (byval as LDAP ptr, byval as PWCHAR, byval as LDAPModW ptr ptr) as ULONG
declare function ldap_delete_ext alias "ldap_delete_extW" (byval as LDAP ptr, byval as PWCHAR, byval as PLDAPControlW ptr, byval as PLDAPControlW ptr, byval as ULONG ptr) as ULONG
declare function ldap_delete_ext_s alias "ldap_delete_ext_sW" (byval as LDAP ptr, byval as PWCHAR, byval as PLDAPControlW ptr, byval as PLDAPControlW ptr) as ULONG
declare function ldap_delete alias "ldap_deleteW" (byval as LDAP ptr, byval as PWCHAR) as ULONG
declare function ldap_delete_s alias "ldap_delete_sW" (byval as LDAP ptr, byval as PWCHAR) as ULONG
declare function ldap_extended_operation alias "ldap_extended_operationW" (byval as LDAP ptr, byval as PWCHAR, byval as berval ptr, byval as PLDAPControlW ptr, byval as PLDAPControlW ptr, byval as ULONG ptr) as ULONG
declare function ldap_extended_operation_s alias "ldap_extended_operation_sW" (byval as LDAP ptr, byval as PWCHAR, byval as berval ptr, byval as PLDAPControlW ptr, byval as PLDAPControlW ptr, byval as PWCHAR ptr, byval as berval ptr ptr) as ULONG
declare function ldap_parse_result alias "ldap_parse_resultW" (byval as LDAP ptr, byval as LDAPMessage ptr, byval as ULONG ptr, byval as PWCHAR ptr, byval as PWCHAR ptr, byval as PWCHAR ptr ptr, byval as PLDAPControlW ptr ptr, byval as BOOLEAN) as ULONG
declare function ldap_parse_extended_result alias "ldap_parse_extended_resultW" (byval as LDAP, byval as LDAPMessage ptr, byval as PWCHAR ptr, byval as berval ptr ptr, byval as BOOLEAN) as ULONG
declare function ldap_err2string alias "ldap_err2stringW" (byval as ULONG) as PWCHAR
declare function ldap_first_attribute alias "ldap_first_attributeW" (byval as LDAP ptr, byval as LDAPMessage ptr, byval as BerElement ptr ptr) as PWCHAR
declare function ldap_next_attribute alias "ldap_next_attributeW" (byval as LDAP ptr, byval as LDAPMessage ptr, byval as BerElement ptr) as PWCHAR
declare sub ldap_memfree alias "ldap_memfreeW" (byval as PWCHAR)
declare function ldap_get_values alias "ldap_get_valuesW" (byval as LDAP ptr, byval as LDAPMessage ptr, byval as PWCHAR) as PWCHAR ptr
declare function ldap_get_values_len alias "ldap_get_values_lenW" (byval as LDAP ptr, byval as LDAPMessage ptr, byval as PWCHAR) as BerValue ptr ptr
declare function ldap_count_values alias "ldap_count_valuesW" (byval as PWCHAR ptr) as ULONG
declare function ldap_value_free alias "ldap_value_freeW" (byval as PWCHAR ptr) as ULONG
declare function ldap_get_dn alias "ldap_get_dnW" (byval as LDAP ptr, byval as LDAPMessage ptr) as PWCHAR
declare function ldap_explode_dn alias "ldap_explode_dnW" (byval as PWCHAR, byval as ULONG) as PWCHAR
declare function ldap_dn2ufn alias "ldap_dn2ufnW" (byval as PWCHAR) as PWCHAR
declare function ldap_ufn2dn alias "ldap_ufn2dnW" (byval as PWCHAR, byval as PWCHAR ptr) as ULONG
declare function ldap_parse_reference alias "ldap_parse_referenceW" (byval as LDAP ptr, byval as LDAPMessage ptr, byval as PWCHAR ptr ptr) as ULONG
declare function ldap_check_filter alias "ldap_check_filterW" (byval as LDAP ptr, byval as PWCHAR) as ULONG
declare function ldap_create_page_control alias "ldap_create_page_controlW" (byval as PLDAP, byval as ULONG, byval as berval ptr, byval as UCHAR, byval as PLDAPControlW ptr) as ULONG
declare function ldap_create_sort_control alias "ldap_create_sort_controlW" (byval as PLDAP, byval as PLDAPSortKeyW ptr, byval as UCHAR, byval as PLDAPControlW ptr) as ULONG
declare function ldap_create_vlv_control alias "ldap_create_vlv_controlW" (byval as LDAP ptr, byval as LDAPVLVInfo ptr, byval as UCHAR, byval as LDAPControlW ptr ptr) as INT_
declare function ldap_encode_sort_control alias "ldap_encode_sort_controlW" (byval as PLDAP, byval as PLDAPSortKeyW ptr, byval as PLDAPControlW, byval as BOOLEAN) as ULONG
declare function ldap_escape_filter_element alias "ldap_escape_filter_elementW" (byval as PWCHAR, byval as ULONG, byval as PWCHAR, byval as ULONG) as ULONG
declare function ldap_parse_page_control alias "ldap_parse_page_controlW" (byval as PLDAP, byval as PLDAPControlW ptr, byval as ULONG ptr, byval as berval ptr ptr) as ULONG
declare function ldap_parse_sort_control alias "ldap_parse_sort_controlW" (byval as PLDAP, byval as PLDAPControlW ptr, byval as ULONG ptr, byval as PWCHAR ptr) as ULONG
declare function ldap_parse_vlv_control alias "ldap_parse_vlv_controlW" (byval as LDAP ptr, byval as LDAPControlW ptr ptr, byval as uinteger ptr, byval as uinteger ptr, byval as berval ptr ptr, byval as integer ptr) as INT_
declare function ldap_search_init_page alias "ldap_search_init_pageW" (byval as PLDAP, byval as PWCHAR, byval as ULONG, byval as PWCHAR, byval as PWCHAR ptr, byval as ULONG, byval as PLDAPControlW ptr, byval as PLDAPControlW ptr, byval as ULONG, byval as ULONG, byval as PLDAPSortKeyW ptr) as PLDAPSearch

#else
declare function ldap_init alias "ldap_initA" (byval as PCHAR, byval as ULONG) as PLDAP
declare function ldap_open alias "ldap_openA" (byval as PCHAR, byval as ULONG) as PLDAP
declare function cldap_open alias "cldap_openA" (byval as PCHAR, byval as ULONG) as PLDAP
declare function ldap_sslinit alias "ldap_sslinitA" (byval as PCHAR, byval as ULONG, byval as integer) as PLDAP
declare function ldap_start_tls_s alias "ldap_start_tls_sA" (byval as LDAP ptr, byval as PLDAPControlA ptr, byval as PLDAPControlA ptr) as ULONG
declare function ldap_get_option alias "ldap_get_optionA" (byval as LDAP ptr, byval as integer, byval as any ptr) as ULONG
declare function ldap_set_option alias "ldap_set_optionA" (byval as LDAP ptr, byval as integer, byval as any ptr) as ULONG
declare function ldap_control_free alias "ldap_control_freeA" (byval as LDAPControlA ptr) as ULONG
declare function ldap_controls_free alias "ldap_controls_freeA" (byval as LDAPControlA ptr ptr) as ULONG
declare function ldap_free_controls alias "ldap_free_controlsA" (byval as LDAPControlA ptr ptr) as ULONG
declare function ldap_sasl_bind alias "ldap_sasl_bindA" (byval as LDAP ptr, byval as PCHAR, byval as PCHAR, byval as BERVAL ptr, byval as PLDAPControlA ptr, byval as PLDAPControlA ptr, byval as integer ptr) as ULONG
declare function ldap_sasl_bind_s alias "ldap_sasl_bind_sA" (byval as LDAP ptr, byval as PCHAR, byval as PCHAR, byval as BERVAL ptr, byval as PLDAPControlA ptr, byval as PLDAPControlA ptr, byval as PBERVAL ptr) as ULONG
declare function ldap_simple_bind alias "ldap_simple_bindA" (byval as LDAP ptr, byval as PCHAR, byval as PCHAR) as ULONG
declare function ldap_simple_bind_s alias "ldap_simple_bind_sA" (byval as LDAP ptr, byval as PCHAR, byval as PCHAR) as ULONG
declare function ldap_bind alias "ldap_bindA" (byval as LDAP ptr, byval as PCHAR, byval as PCHAR, byval as ULONG) as ULONG
declare function ldap_bind_s alias "ldap_bind_sA" (byval as LDAP ptr, byval as PCHAR, byval as PCHAR, byval as ULONG) as ULONG
''''''''declare function ldap_search_ext alias "ldap_search_extA" (byval as LDAP ptr, byval as PCHAR, byval as ULONG, byval as PCHAR, byval as PCHAR ptr, byval as ULONG, byval as PLDAPControlW ptr, byval as PLDAPControlW ptr, byval as ULONG, byval as ULONG, byval as ULONG ptr) as ULONG
declare function ldap_search_ext_s alias "ldap_search_ext_sA" (byval as LDAP ptr, byval as PCHAR, byval as ULONG, byval as PCHAR, byval as PCHAR ptr, byval as ULONG, byval as PLDAPControlA ptr, byval as PLDAPControlA ptr, byval as LDAP_TIMEVAL ptr, byval as ULONG, byval as LDAPMessage ptr ptr) as ULONG
declare function ldap_search alias "ldap_searchA" (byval as LDAP ptr, byval as PCHAR, byval as ULONG, byval as PCHAR, byval as PCHAR ptr, byval as ULONG) as ULONG
declare function ldap_search_s alias "ldap_search_sA" (byval as LDAP ptr, byval as PCHAR, byval as ULONG, byval as PCHAR, byval as PCHAR ptr, byval as ULONG, byval as LDAPMessage ptr ptr) as ULONG
declare function ldap_search_st alias "ldap_search_stA" (byval as LDAP ptr, byval as PCHAR, byval as ULONG, byval as PCHAR, byval as PCHAR ptr, byval as ULONG, byval as LDAP_TIMEVAL ptr, byval as LDAPMessage ptr ptr) as ULONG
declare function ldap_compare_ext alias "ldap_compare_extA" (byval as LDAP ptr, byval as PCHAR, byval as PCHAR, byval as PCHAR, byval as berval ptr, byval as PLDAPControlA ptr, byval as PLDAPControlA ptr, byval as ULONG ptr) as ULONG
declare function ldap_compare_ext_s alias "ldap_compare_ext_sA" (byval as LDAP ptr, byval as PCHAR, byval as PCHAR, byval as PCHAR, byval as berval ptr, byval as PLDAPControlA ptr, byval as PLDAPControlA ptr) as ULONG
declare function ldap_compare alias "ldap_compareA" (byval as LDAP ptr, byval as PCHAR, byval as PCHAR, byval as PCHAR) as ULONG
declare function ldap_compare_s alias "ldap_compare_sA" (byval as LDAP ptr, byval as PCHAR, byval as PCHAR, byval as PCHAR) as ULONG
declare function ldap_modify_ext alias "ldap_modify_extA" (byval as LDAP ptr, byval as PCHAR, byval as LDAPModA ptr ptr, byval as PLDAPControlA ptr, byval as PLDAPControlA ptr, byval as ULONG ptr) as ULONG
declare function ldap_modify_ext_s alias "ldap_modify_ext_sA" (byval as LDAP ptr, byval as PCHAR, byval as LDAPModA ptr ptr, byval as PLDAPControlA ptr, byval as PLDAPControlA ptr) as ULONG
declare function ldap_modify alias "ldap_modifyA" (byval as LDAP ptr, byval as PCHAR, byval as LDAPModA ptr ptr) as ULONG
declare function ldap_modify_s alias "ldap_modify_sA" (byval as LDAP ptr, byval as PCHAR, byval as LDAPModA ptr ptr) as ULONG
declare function ldap_rename_ext alias "ldap_rename_extA" (byval as LDAP ptr, byval as PCHAR, byval as PCHAR, byval as PCHAR, byval as INT_, byval as PLDAPControlA ptr, byval as PLDAPControlA ptr, byval as ULONG ptr) as ULONG
declare function ldap_rename_ext_s alias "ldap_rename_ext_sA" (byval as LDAP ptr, byval as PCHAR, byval as PCHAR, byval as PCHAR, byval as INT_, byval as PLDAPControlA ptr, byval as PLDAPControlA ptr) as ULONG
declare function ldap_modrdn alias "ldap_modrdnA" (byval as LDAP ptr, byval as PCHAR, byval as PCHAR) as ULONG
declare function ldap_modrdn_s alias "ldap_modrdn_sA" (byval as LDAP ptr, byval as PCHAR, byval as PCHAR) as ULONG
declare function ldap_modrdn2 alias "ldap_modrdn2A" (byval as LDAP ptr, byval as PCHAR, byval as PCHAR, byval as INT_) as ULONG
declare function ldap_modrdn2_s alias "ldap_modrdn2_sA" (byval as LDAP ptr, byval as PCHAR, byval as PCHAR, byval as INT_) as ULONG
declare function ldap_add_ext alias "ldap_add_extA" (byval as LDAP ptr, byval as PCHAR, byval as LDAPModA ptr ptr, byval as PLDAPControlA ptr, byval as PLDAPControlA ptr, byval as ULONG ptr) as ULONG
declare function ldap_add_ext_s alias "ldap_add_ext_sA" (byval as LDAP ptr, byval as PCHAR, byval as LDAPModA ptr ptr, byval as PLDAPControlA ptr, byval as PLDAPControlA ptr) as ULONG
declare function ldap_add alias "ldap_addA" (byval as LDAP ptr, byval as PCHAR, byval as LDAPModA ptr ptr) as ULONG
declare function ldap_add_s alias "ldap_add_sA" (byval as LDAP ptr, byval as PCHAR, byval as LDAPModA ptr ptr) as ULONG
declare function ldap_delete_ext alias "ldap_delete_extA" (byval as LDAP ptr, byval as PCHAR, byval as PLDAPControlA ptr, byval as PLDAPControlA ptr, byval as ULONG ptr) as ULONG
declare function ldap_delete_ext_s alias "ldap_delete_ext_sA" (byval as LDAP ptr, byval as PCHAR, byval as PLDAPControlA ptr, byval as PLDAPControlA ptr) as ULONG
declare function ldap_delete alias "ldap_deleteA" (byval as LDAP ptr, byval as PCHAR) as ULONG
declare function ldap_delete_s alias "ldap_delete_sA" (byval as LDAP ptr, byval as PCHAR) as ULONG
declare function ldap_extended_operation alias "ldap_extended_operationA" (byval as LDAP ptr, byval as PCHAR, byval as berval ptr, byval as PLDAPControlA ptr, byval as PLDAPControlA ptr, byval as ULONG ptr) as ULONG
declare function ldap_extended_operation_s alias "ldap_extended_operation_sA" (byval as LDAP ptr, byval as PCHAR, byval as berval ptr, byval as PLDAPControlA ptr, byval as PLDAPControlA ptr, byval as PCHAR ptr, byval as berval ptr ptr) as ULONG
declare function ldap_parse_result alias "ldap_parse_resultA" (byval as LDAP ptr, byval as LDAPMessage ptr, byval as ULONG ptr, byval as PCHAR ptr, byval as PCHAR ptr, byval as PCHAR ptr ptr, byval as PLDAPControlA ptr ptr, byval as BOOLEAN) as ULONG
declare function ldap_parse_extended_result alias "ldap_parse_extended_resultA" (byval as LDAP, byval as LDAPMessage ptr, byval as PCHAR ptr, byval as berval ptr ptr, byval as BOOLEAN) as ULONG
declare function ldap_err2string alias "ldap_err2stringA" (byval as ULONG) as PCHAR
declare function ldap_first_attribute alias "ldap_first_attributeA" (byval as LDAP ptr, byval as LDAPMessage ptr, byval as BerElement ptr ptr) as PCHAR
declare function ldap_next_attribute alias "ldap_next_attributeA" (byval as LDAP ptr, byval as LDAPMessage ptr, byval as BerElement ptr) as PCHAR
declare sub ldap_memfree alias "ldap_memfreeA" (byval as PCHAR)
declare function ldap_get_values alias "ldap_get_valuesA" (byval as LDAP ptr, byval as LDAPMessage ptr, byval as PCHAR) as PCHAR ptr
declare function ldap_get_values_len alias "ldap_get_values_lenA" (byval as LDAP ptr, byval as LDAPMessage ptr, byval as PCHAR) as BerValue ptr ptr
declare function ldap_count_values alias "ldap_count_valuesA" (byval as PCHAR ptr) as ULONG
declare function ldap_value_free alias "ldap_value_freeA" (byval as PCHAR ptr) as ULONG
declare function ldap_get_dn alias "ldap_get_dnA" (byval as LDAP ptr, byval as LDAPMessage ptr) as PCHAR
declare function ldap_explode_dn alias "ldap_explode_dnA" (byval as PCHAR, byval as ULONG) as PCHAR
declare function ldap_dn2ufn alias "ldap_dn2ufnA" (byval as PCHAR) as PCHAR
declare function ldap_ufn2dn alias "ldap_ufn2dnA" (byval as PCHAR, byval as PCHAR ptr) as ULONG
declare function ldap_parse_reference alias "ldap_parse_referenceA" (byval as LDAP ptr, byval as LDAPMessage ptr, byval as PCHAR ptr ptr) as ULONG
declare function ldap_check_filter alias "ldap_check_filterA" (byval as LDAP ptr, byval as PCHAR) as ULONG
declare function ldap_create_page_control alias "ldap_create_page_controlA" (byval as PLDAP, byval as ULONG, byval as berval ptr, byval as UCHAR, byval as PLDAPControlA ptr) as ULONG
declare function ldap_create_sort_control alias "ldap_create_sort_controlA" (byval as PLDAP, byval as PLDAPSortKeyA ptr, byval as UCHAR, byval as PLDAPControlA ptr) as ULONG
declare function ldap_create_vlv_control alias "ldap_create_vlv_controlA" (byval as LDAP ptr, byval as LDAPVLVInfo ptr, byval as UCHAR, byval as LDAPControlA ptr ptr) as INT_
declare function ldap_encode_sort_control alias "ldap_encode_sort_controlA" (byval as PLDAP, byval as PLDAPSortKeyA ptr, byval as PLDAPControlA, byval as BOOLEAN) as ULONG
declare function ldap_escape_filter_element alias "ldap_escape_filter_elementA" (byval as PCHAR, byval as ULONG, byval as PCHAR, byval as ULONG) as ULONG
declare function ldap_parse_page_control alias "ldap_parse_page_controlA" (byval as PLDAP, byval as PLDAPControlA ptr, byval as ULONG ptr, byval as berval ptr ptr) as ULONG
declare function ldap_parse_sort_control alias "ldap_parse_sort_controlA" (byval as PLDAP, byval as PLDAPControlA ptr, byval as ULONG ptr, byval as PCHAR ptr) as ULONG
declare function ldap_parse_vlv_control alias "ldap_parse_vlv_controlA" (byval as LDAP ptr, byval as LDAPControlA ptr ptr, byval as uinteger ptr, byval as uinteger ptr, byval as berval ptr ptr, byval as integer ptr) as INT_
declare function ldap_search_init_page alias "ldap_search_init_pageA" (byval as PLDAP, byval as PCHAR, byval as ULONG, byval as PCHAR, byval as PCHAR ptr, byval as ULONG, byval as PLDAPControlA ptr, byval as PLDAPControlA ptr, byval as ULONG, byval as ULONG, byval as PLDAPSortKeyA ptr) as PLDAPSearch
#endif

#endif
