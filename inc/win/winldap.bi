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

#inclib "wldap32"

#include once "schnlsp.bi"

extern "C"

#define LDAP_CLIENT_DEFINED

#ifdef UNICODE
	const LDAP_UNICODE = 1
#else
	const LDAP_UNICODE = 0
#endif

const LDAP_PORT = 389
const LDAP_SSL_PORT = 636
const LDAP_GC_PORT = 3268
const LDAP_SSL_GC_PORT = 3269
const LDAP_VERSION1 = 1
const LDAP_VERSION2 = 2
const LDAP_VERSION3 = 3
const LDAP_VERSION = LDAP_VERSION2
const LDAP_BIND_CMD = &h60
const LDAP_UNBIND_CMD = &h42
const LDAP_SEARCH_CMD = &h63
const LDAP_MODIFY_CMD = &h66
const LDAP_ADD_CMD = &h68
const LDAP_DELETE_CMD = &h4a
const LDAP_MODRDN_CMD = &h6c
const LDAP_COMPARE_CMD = &h6e
const LDAP_ABANDON_CMD = &h50
const LDAP_SESSION_CMD = &h71
const LDAP_EXTENDED_CMD = &h77
const LDAP_RES_BIND = &h61
const LDAP_RES_SEARCH_ENTRY = &h64
const LDAP_RES_SEARCH_RESULT = &h65
const LDAP_RES_MODIFY = &h67
const LDAP_RES_ADD = &h69
const LDAP_RES_DELETE = &h6b
const LDAP_RES_MODRDN = &h6d
const LDAP_RES_COMPARE = &h6f
const LDAP_RES_SESSION = &h72
const LDAP_RES_REFERRAL = &h73
const LDAP_RES_EXTENDED = &h78
const LDAP_RES_ANY = -1
const LDAP_INVALID_CMD = &hff
const LDAP_INVALID_RES = &hff

type LDAP_RETCODE as long
enum
	LDAP_SUCCESS = &h00
	LDAP_OPERATIONS_ERROR = &h01
	LDAP_PROTOCOL_ERROR = &h02
	LDAP_TIMELIMIT_EXCEEDED = &h03
	LDAP_SIZELIMIT_EXCEEDED = &h04
	LDAP_COMPARE_FALSE = &h05
	LDAP_COMPARE_TRUE = &h06
	LDAP_AUTH_METHOD_NOT_SUPPORTED = &h07
	LDAP_STRONG_AUTH_REQUIRED = &h08
	LDAP_REFERRAL_V2 = &h09
	LDAP_PARTIAL_RESULTS = &h09
	LDAP_REFERRAL = &h0a
	LDAP_ADMIN_LIMIT_EXCEEDED = &h0b
	LDAP_UNAVAILABLE_CRIT_EXTENSION = &h0c
	LDAP_CONFIDENTIALITY_REQUIRED = &h0d
	LDAP_SASL_BIND_IN_PROGRESS = &h0e
	LDAP_NO_SUCH_ATTRIBUTE = &h10
	LDAP_UNDEFINED_TYPE = &h11
	LDAP_INAPPROPRIATE_MATCHING = &h12
	LDAP_CONSTRAINT_VIOLATION = &h13
	LDAP_ATTRIBUTE_OR_VALUE_EXISTS = &h14
	LDAP_INVALID_SYNTAX = &h15
	LDAP_NO_SUCH_OBJECT = &h20
	LDAP_ALIAS_PROBLEM = &h21
	LDAP_INVALID_DN_SYNTAX = &h22
	LDAP_IS_LEAF = &h23
	LDAP_ALIAS_DEREF_PROBLEM = &h24
	LDAP_INAPPROPRIATE_AUTH = &h30
	LDAP_INVALID_CREDENTIALS = &h31
	LDAP_INSUFFICIENT_RIGHTS = &h32
	LDAP_BUSY = &h33
	LDAP_UNAVAILABLE = &h34
	LDAP_UNWILLING_TO_PERFORM = &h35
	LDAP_LOOP_DETECT = &h36
	LDAP_SORT_CONTROL_MISSING = &h3C
	LDAP_OFFSET_RANGE_ERROR = &h3D
	LDAP_NAMING_VIOLATION = &h40
	LDAP_OBJECT_CLASS_VIOLATION = &h41
	LDAP_NOT_ALLOWED_ON_NONLEAF = &h42
	LDAP_NOT_ALLOWED_ON_RDN = &h43
	LDAP_ALREADY_EXISTS = &h44
	LDAP_NO_OBJECT_CLASS_MODS = &h45
	LDAP_RESULTS_TOO_LARGE = &h46
	LDAP_AFFECTS_MULTIPLE_DSAS = &h47
	LDAP_VIRTUAL_LIST_VIEW_ERROR = &h4c
	LDAP_OTHER = &h50
	LDAP_SERVER_DOWN = &h51
	LDAP_LOCAL_ERROR = &h52
	LDAP_ENCODING_ERROR = &h53
	LDAP_DECODING_ERROR = &h54
	LDAP_TIMEOUT = &h55
	LDAP_AUTH_UNKNOWN = &h56
	LDAP_FILTER_ERROR = &h57
	LDAP_USER_CANCELLED = &h58
	LDAP_PARAM_ERROR = &h59
	LDAP_NO_MEMORY = &h5a
	LDAP_CONNECT_ERROR = &h5b
	LDAP_NOT_SUPPORTED = &h5c
	LDAP_NO_RESULTS_RETURNED = &h5e
	LDAP_CONTROL_NOT_FOUND = &h5d
	LDAP_MORE_RESULTS_TO_RETURN = &h5f
	LDAP_CLIENT_LOOP = &h60
	LDAP_REFERRAL_LIMIT_EXCEEDED = &h61
end enum

const LDAP_AUTH_SIMPLE = &h80
const LDAP_AUTH_SASL = &h83
const LDAP_AUTH_OTHERKIND = &h86
const LDAP_AUTH_SICILY = LDAP_AUTH_OTHERKIND or &h0200
const LDAP_AUTH_MSN = LDAP_AUTH_OTHERKIND or &h0800
const LDAP_AUTH_NTLM = LDAP_AUTH_OTHERKIND or &h1000
const LDAP_AUTH_DPA = LDAP_AUTH_OTHERKIND or &h2000
const LDAP_AUTH_NEGOTIATE = LDAP_AUTH_OTHERKIND or &h0400
const LDAP_AUTH_SSPI = LDAP_AUTH_NEGOTIATE
const LDAP_AUTH_DIGEST = LDAP_AUTH_OTHERKIND or &h4000
const LDAP_AUTH_EXTERNAL = LDAP_AUTH_OTHERKIND or &h0020
const LDAP_FILTER_AND = &ha0
const LDAP_FILTER_OR = &ha1
const LDAP_FILTER_NOT = &ha2
const LDAP_FILTER_EQUALITY = &ha3
const LDAP_FILTER_SUBSTRINGS = &ha4
const LDAP_FILTER_GE = &ha5
const LDAP_FILTER_LE = &ha6
const LDAP_FILTER_PRESENT = &h87
const LDAP_FILTER_APPROX = &ha8
const LDAP_FILTER_EXTENSIBLE = &ha9
const LDAP_SUBSTRING_INITIAL = &h80
const LDAP_SUBSTRING_ANY = &h81
const LDAP_SUBSTRING_FINAL = &h82
const LDAP_DEREF_NEVER = 0
const LDAP_DEREF_SEARCHING = 1
const LDAP_DEREF_FINDING = 2
const LDAP_DEREF_ALWAYS = 3
const LDAP_NO_LIMIT = 0
const LDAP_OPT_DNS = &h00000001
const LDAP_OPT_CHASE_REFERRALS = &h00000002
const LDAP_OPT_RETURN_REFS = &h00000004

#ifdef __FB_64BIT__
	type ldap_ld_sb
		sb_sd as UINT_PTR
		Reserved1(0 to ((10 * sizeof(ULONG)) + 1) - 1) as UCHAR
		sb_naddr as ULONG_PTR
		Reserved2(0 to (6 * sizeof(ULONG)) - 1) as UCHAR
	end type

	type LDAP
		ld_sb as ldap_ld_sb
		ld_host as PCHAR
		ld_version as ULONG
		ld_lberoptions as UCHAR
		ld_deref as ULONG
		ld_timelimit as ULONG
		ld_sizelimit as ULONG
		ld_errno as ULONG
		ld_matched as PCHAR
		ld_error as PCHAR
		ld_msgid as ULONG
		Reserved3(0 to ((6 * sizeof(ULONG)) + 1) - 1) as UCHAR
		ld_cldaptries as ULONG
		ld_cldaptimeout as ULONG
		ld_refhoplimit as ULONG
		ld_options as ULONG
	end type
#else
	type ldap_ld_sb field = 4
		sb_sd as UINT_PTR
		Reserved1(0 to ((10 * sizeof(ULONG)) + 1) - 1) as UCHAR
		sb_naddr as ULONG_PTR
		Reserved2(0 to (6 * sizeof(ULONG)) - 1) as UCHAR
	end type

	type LDAP field = 4
		ld_sb as ldap_ld_sb
		ld_host as PCHAR
		ld_version as ULONG
		ld_lberoptions as UCHAR
		ld_deref as ULONG
		ld_timelimit as ULONG
		ld_sizelimit as ULONG
		ld_errno as ULONG
		ld_matched as PCHAR
		ld_error as PCHAR
		ld_msgid as ULONG
		Reserved3(0 to ((6 * sizeof(ULONG)) + 1) - 1) as UCHAR
		ld_cldaptries as ULONG
		ld_cldaptimeout as ULONG
		ld_refhoplimit as ULONG
		ld_options as ULONG
	end type
#endif

type PLDAP as LDAP ptr

#ifdef __FB_64BIT__
	type l_timeval
		tv_sec as LONG
		tv_usec as LONG
	end type
#else
	type l_timeval field = 4
		tv_sec as LONG
		tv_usec as LONG
	end type
#endif

type LDAP_TIMEVAL as l_timeval
type PLDAP_TIMEVAL as l_timeval ptr

#ifdef __FB_64BIT__
	type BERVAL_
		bv_len as ULONG
		bv_val as PCHAR
	end type
#else
	type BERVAL_ field = 4
		bv_len as ULONG
		bv_val as PCHAR
	end type
#endif

type LDAP_BERVAL as BERVAL
type PLDAP_BERVAL as BERVAL ptr
type PBERVAL_ as BERVAL ptr
type BerValue as BERVAL

#ifdef __FB_64BIT__
	type ldapmsg
		lm_msgid as ULONG
		lm_msgtype as ULONG
		lm_ber as PVOID
		lm_chain as ldapmsg ptr
		lm_next as ldapmsg ptr
		lm_time as ULONG
		Connection as PLDAP
		Request as PVOID
		lm_returncode as ULONG
		lm_referral as USHORT
		lm_chased as WINBOOLEAN
		lm_eom as WINBOOLEAN
		ConnectionReferenced as WINBOOLEAN
	end type
#else
	type ldapmsg field = 4
		lm_msgid as ULONG
		lm_msgtype as ULONG
		lm_ber as PVOID
		lm_chain as ldapmsg ptr
		lm_next as ldapmsg ptr
		lm_time as ULONG
		Connection as PLDAP
		Request as PVOID
		lm_returncode as ULONG
		lm_referral as USHORT
		lm_chased as WINBOOLEAN
		lm_eom as WINBOOLEAN
		ConnectionReferenced as WINBOOLEAN
	end type
#endif

type LDAPMessage as ldapmsg
type PLDAPMessage as ldapmsg ptr

#ifdef __FB_64BIT__
	type LDAPControlA
		ldctl_oid as PCHAR
		ldctl_value as BERVAL
		ldctl_iscritical as WINBOOLEAN
	end type
#else
	type LDAPControlA field = 4
		ldctl_oid as PCHAR
		ldctl_value as BERVAL
		ldctl_iscritical as WINBOOLEAN
	end type
#endif

type PLDAPControlA as LDAPControlA ptr

#ifdef __FB_64BIT__
	type LDAPControlW
		ldctl_oid as PWCHAR
		ldctl_value as BERVAL
		ldctl_iscritical as WINBOOLEAN
	end type
#else
	type LDAPControlW field = 4
		ldctl_oid as PWCHAR
		ldctl_value as BERVAL
		ldctl_iscritical as WINBOOLEAN
	end type
#endif

type PLDAPControlW as LDAPControlW ptr

#ifdef UNICODE
	type LDAPControl as LDAPControlW
	type PLDAPControl as PLDAPControlW
#else
	type LDAPControl as LDAPControlA
	type PLDAPControl as PLDAPControlA
#endif

#define LDAP_CONTROL_REFERRALS_W wstr("1.2.840.113556.1.4.616")
#define LDAP_CONTROL_REFERRALS "1.2.840.113556.1.4.616"
const LDAP_MOD_ADD = &h00
const LDAP_MOD_DELETE = &h01
const LDAP_MOD_REPLACE = &h02
const LDAP_MOD_BVALUES = &h80

#ifdef __FB_64BIT__
	union ldapmodW_mod_vals
		modv_strvals as PWCHAR ptr
		modv_bvals as BERVAL ptr ptr
	end union

	type LDAPModW
		mod_op as ULONG
		mod_type as PWCHAR
		mod_vals as ldapmodW_mod_vals
	end type
#else
	union ldapmodW_mod_vals field = 4
		modv_strvals as PWCHAR ptr
		modv_bvals as BERVAL ptr ptr
	end union

	type LDAPModW field = 4
		mod_op as ULONG
		mod_type as PWCHAR
		mod_vals as ldapmodW_mod_vals
	end type
#endif

type PLDAPModW as LDAPModW ptr

#ifdef __FB_64BIT__
	union ldapmodA_mod_vals
		modv_strvals as PCHAR ptr
		modv_bvals as BERVAL ptr ptr
	end union

	type LDAPModA
		mod_op as ULONG
		mod_type as PCHAR
		mod_vals as ldapmodA_mod_vals
	end type
#else
	union ldapmodA_mod_vals field = 4
		modv_strvals as PCHAR ptr
		modv_bvals as BERVAL ptr ptr
	end union

	type LDAPModA field = 4
		mod_op as ULONG
		mod_type as PCHAR
		mod_vals as ldapmodA_mod_vals
	end type
#endif

type PLDAPModA as LDAPModA ptr

#ifdef UNICODE
	type LDAPMod as LDAPModW
	type PLDAPMod as PLDAPModW
#else
	type LDAPMod as LDAPModA
	type PLDAPMod as PLDAPModA
#endif

#define LDAP_IS_CLDAP(ld) ((ld)->ld_sb.sb_naddr > 0)
#define mod_values mod_vals.modv_strvals
#define mod_bvalues mod_vals.modv_bvals
#define NAME_ERROR(n) ((n and &hf0) = &h20)

declare function ldap_openW(byval HostName as const PWCHAR, byval PortNumber as ULONG) as LDAP ptr
declare function ldap_openA(byval HostName as const PCHAR, byval PortNumber as ULONG) as LDAP ptr
declare function ldap_initW(byval HostName as const PWCHAR, byval PortNumber as ULONG) as LDAP ptr
declare function ldap_initA(byval HostName as const PCHAR, byval PortNumber as ULONG) as LDAP ptr
declare function ldap_sslinitW(byval HostName as PWCHAR, byval PortNumber as ULONG, byval secure as long) as LDAP ptr
declare function ldap_sslinitA(byval HostName as PCHAR, byval PortNumber as ULONG, byval secure as long) as LDAP ptr
declare function ldap_connect(byval ld as LDAP ptr, byval timeout as l_timeval ptr) as ULONG

#ifdef UNICODE
	declare function ldap_open alias "ldap_openW"(byval HostName as const PWCHAR, byval PortNumber as ULONG) as LDAP ptr
	declare function ldap_init alias "ldap_initW"(byval HostName as const PWCHAR, byval PortNumber as ULONG) as LDAP ptr
	declare function ldap_sslinit alias "ldap_sslinitW"(byval HostName as PWCHAR, byval PortNumber as ULONG, byval secure as long) as LDAP ptr
#else
	declare function ldap_open(byval HostName as PCHAR, byval PortNumber as ULONG) as LDAP ptr
	declare function ldap_init(byval HostName as PCHAR, byval PortNumber as ULONG) as LDAP ptr
	declare function ldap_sslinit(byval HostName as PCHAR, byval PortNumber as ULONG, byval secure as long) as LDAP ptr
#endif

declare function cldap_openW(byval HostName as PWCHAR, byval PortNumber as ULONG) as LDAP ptr
declare function cldap_openA(byval HostName as PCHAR, byval PortNumber as ULONG) as LDAP ptr

#ifdef UNICODE
	declare function cldap_open alias "cldap_openW"(byval HostName as PWCHAR, byval PortNumber as ULONG) as LDAP ptr
#else
	declare function cldap_open(byval HostName as PCHAR, byval PortNumber as ULONG) as LDAP ptr
#endif

declare function ldap_unbind(byval ld as ldap ptr) as ULONG
declare function ldap_unbind_s(byval ld as ldap ptr) as ULONG
declare function ldap_get_optionA alias "ldap_get_option"(byval ld as ldap ptr, byval option as long, byval outvalue as any ptr) as ULONG
declare function ldap_get_optionW(byval ld as ldap ptr, byval option as long, byval outvalue as any ptr) as ULONG
declare function ldap_set_optionA alias "ldap_set_option"(byval ld as ldap ptr, byval option as long, byval invalue as const any ptr) as ULONG
declare function ldap_set_optionW(byval ld as ldap ptr, byval option as long, byval invalue as const any ptr) as ULONG

#ifdef UNICODE
	declare function ldap_get_option alias "ldap_get_optionW"(byval ld as LDAP ptr, byval option as long, byval outvalue as any ptr) as ULONG
	declare function ldap_set_option alias "ldap_set_optionW"(byval ld as LDAP ptr, byval option as long, byval invalue as const any ptr) as ULONG
#else
	declare function ldap_get_option(byval ld as LDAP ptr, byval option as long, byval outvalue as any ptr) as ULONG
	declare function ldap_set_option(byval ld as LDAP ptr, byval option as long, byval invalue as const any ptr) as ULONG
#endif

const LDAP_OPT_API_INFO = &h00
const LDAP_OPT_DESC = &h01
const LDAP_OPT_DEREF = &h02
const LDAP_OPT_SIZELIMIT = &h03
const LDAP_OPT_TIMELIMIT = &h04
const LDAP_OPT_THREAD_FN_PTRS = &h05
const LDAP_OPT_REBIND_FN = &h06
const LDAP_OPT_REBIND_ARG = &h07
const LDAP_OPT_REFERRALS = &h08
const LDAP_OPT_RESTART = &h09
const LDAP_OPT_SSL = &h0a
const LDAP_OPT_IO_FN_PTRS = &h0b
const LDAP_OPT_CACHE_FN_PTRS = &h0d
const LDAP_OPT_CACHE_STRATEGY = &h0e
const LDAP_OPT_CACHE_ENABLE = &h0f
const LDAP_OPT_REFERRAL_HOP_LIMIT = &h10
const LDAP_OPT_PROTOCOL_VERSION = &h11
const LDAP_OPT_VERSION = &h11
const LDAP_OPT_API_FEATURE_INFO = &h15
const LDAP_OPT_HOST_NAME = &h30
const LDAP_OPT_ERROR_NUMBER = &h31
const LDAP_OPT_ERROR_STRING = &h32
const LDAP_OPT_SERVER_ERROR = &h33
const LDAP_OPT_SERVER_EXT_ERROR = &h34
const LDAP_OPT_HOST_REACHABLE = &h3E
const LDAP_OPT_PING_KEEP_ALIVE = &h36
const LDAP_OPT_PING_WAIT_TIME = &h37
const LDAP_OPT_PING_LIMIT = &h38
const LDAP_OPT_DNSDOMAIN_NAME = &h3B
const LDAP_OPT_GETDSNAME_FLAGS = &h3D
const LDAP_OPT_PROMPT_CREDENTIALS = &h3F
const LDAP_OPT_AUTO_RECONNECT = &h91
const LDAP_OPT_SSPI_FLAGS = &h92
const LDAP_OPT_SSL_INFO = &h93
const LDAP_OPT_TLS = LDAP_OPT_SSL
const LDAP_OPT_TLS_INFO = LDAP_OPT_SSL_INFO
const LDAP_OPT_SIGN = &h95
const LDAP_OPT_ENCRYPT = &h96
const LDAP_OPT_SASL_METHOD = &h97
const LDAP_OPT_AREC_EXCLUSIVE = &h98
const LDAP_OPT_SECURITY_CONTEXT = &h99
const LDAP_OPT_ROOTDSE_CACHE = &h9a
const LDAP_OPT_TCP_KEEPALIVE = &h40
const LDAP_OPT_FAST_CONCURRENT_BIND = &h41
const LDAP_OPT_SEND_TIMEOUT = &h42
const LDAP_OPT_ON = cptr(any ptr, 1)
const LDAP_OPT_OFF = cptr(any ptr, 0)
const LDAP_CHASE_SUBORDINATE_REFERRALS = &h00000020
const LDAP_CHASE_EXTERNAL_REFERRALS = &h00000040

declare function ldap_simple_bindW(byval ld as LDAP ptr, byval dn as PWCHAR, byval passwd as PWCHAR) as ULONG
declare function ldap_simple_bindA(byval ld as LDAP ptr, byval dn as PCHAR, byval passwd as PCHAR) as ULONG
declare function ldap_simple_bind_sW(byval ld as LDAP ptr, byval dn as PWCHAR, byval passwd as PWCHAR) as ULONG
declare function ldap_simple_bind_sA(byval ld as LDAP ptr, byval dn as PCHAR, byval passwd as PCHAR) as ULONG
declare function ldap_bindW(byval ld as LDAP ptr, byval dn as PWCHAR, byval cred as PWCHAR, byval method as ULONG) as ULONG
declare function ldap_bindA(byval ld as LDAP ptr, byval dn as PCHAR, byval cred as PCHAR, byval method as ULONG) as ULONG
declare function ldap_bind_sW(byval ld as LDAP ptr, byval dn as PWCHAR, byval cred as PWCHAR, byval method as ULONG) as ULONG
declare function ldap_bind_sA(byval ld as LDAP ptr, byval dn as PCHAR, byval cred as PCHAR, byval method as ULONG) as ULONG
declare function ldap_sasl_bindA(byval ExternalHandle as LDAP ptr, byval DistName as const PCHAR, byval AuthMechanism as const PCHAR, byval cred as const BERVAL ptr, byval ServerCtrls as PLDAPControlA ptr, byval ClientCtrls as PLDAPControlA ptr, byval MessageNumber as long ptr) as INT_
declare function ldap_sasl_bindW(byval ExternalHandle as LDAP ptr, byval DistName as const PWCHAR, byval AuthMechanism as const PWCHAR, byval cred as const BERVAL ptr, byval ServerCtrls as PLDAPControlW ptr, byval ClientCtrls as PLDAPControlW ptr, byval MessageNumber as long ptr) as INT_
declare function ldap_sasl_bind_sA(byval ExternalHandle as LDAP ptr, byval DistName as const PCHAR, byval AuthMechanism as const PCHAR, byval cred as const BERVAL ptr, byval ServerCtrls as PLDAPControlA ptr, byval ClientCtrls as PLDAPControlA ptr, byval ServerData as PBERVAL ptr) as INT_
declare function ldap_sasl_bind_sW(byval ExternalHandle as LDAP ptr, byval DistName as const PWCHAR, byval AuthMechanism as const PWCHAR, byval cred as const BERVAL ptr, byval ServerCtrls as PLDAPControlW ptr, byval ClientCtrls as PLDAPControlW ptr, byval ServerData as PBERVAL ptr) as INT_

#ifdef UNICODE
	declare function ldap_simple_bind alias "ldap_simple_bindW"(byval ld as LDAP ptr, byval dn as PWCHAR, byval passwd as PWCHAR) as ULONG
	declare function ldap_simple_bind_s alias "ldap_simple_bind_sW"(byval ld as LDAP ptr, byval dn as PWCHAR, byval passwd as PWCHAR) as ULONG
	declare function ldap_bind alias "ldap_bindW"(byval ld as LDAP ptr, byval dn as PWCHAR, byval cred as PWCHAR, byval method as ULONG) as ULONG
	declare function ldap_bind_s alias "ldap_bind_sW"(byval ld as LDAP ptr, byval dn as PWCHAR, byval cred as PWCHAR, byval method as ULONG) as ULONG
	declare function ldap_sasl_bind alias "ldap_sasl_bindW"(byval ExternalHandle as LDAP ptr, byval DistName as const PWCHAR, byval AuthMechanism as const PWCHAR, byval cred as const BERVAL ptr, byval ServerCtrls as PLDAPControlW ptr, byval ClientCtrls as PLDAPControlW ptr, byval MessageNumber as long ptr) as INT_
	declare function ldap_sasl_bind_s alias "ldap_sasl_bind_sW"(byval ExternalHandle as LDAP ptr, byval DistName as const PWCHAR, byval AuthMechanism as const PWCHAR, byval cred as const BERVAL ptr, byval ServerCtrls as PLDAPControlW ptr, byval ClientCtrls as PLDAPControlW ptr, byval ServerData as PBERVAL ptr) as INT_
#else
	declare function ldap_simple_bind(byval ld as LDAP ptr, byval dn as const PCHAR, byval passwd as const PCHAR) as ULONG
	declare function ldap_simple_bind_s(byval ld as LDAP ptr, byval dn as const PCHAR, byval passwd as const PCHAR) as ULONG
	declare function ldap_bind(byval ld as LDAP ptr, byval dn as const PCHAR, byval cred as const PCHAR, byval method as ULONG) as ULONG
	declare function ldap_bind_s(byval ld as LDAP ptr, byval dn as const PCHAR, byval cred as const PCHAR, byval method as ULONG) as ULONG
	declare function ldap_sasl_bind alias "ldap_sasl_bindA"(byval ExternalHandle as LDAP ptr, byval DistName as const PCHAR, byval AuthMechanism as const PCHAR, byval cred as const BERVAL ptr, byval ServerCtrls as PLDAPControlA ptr, byval ClientCtrls as PLDAPControlA ptr, byval MessageNumber as long ptr) as INT_
	declare function ldap_sasl_bind_s alias "ldap_sasl_bind_sA"(byval ExternalHandle as LDAP ptr, byval DistName as const PCHAR, byval AuthMechanism as const PCHAR, byval cred as const BERVAL ptr, byval ServerCtrls as PLDAPControlA ptr, byval ClientCtrls as PLDAPControlA ptr, byval ServerData as PBERVAL ptr) as INT_
#endif

const LDAP_SCOPE_BASE = &h00
const LDAP_SCOPE_ONELEVEL = &h01
const LDAP_SCOPE_SUBTREE = &h02

declare function ldap_searchW(byval ld as LDAP ptr, byval base as const PWCHAR, byval scope as ULONG, byval filter as const PWCHAR, byval attrs as PWCHAR ptr, byval attrsonly as ULONG) as ULONG
declare function ldap_searchA(byval ld as LDAP ptr, byval base as const PCHAR, byval scope as ULONG, byval filter as const PCHAR, byval attrs as PCHAR ptr, byval attrsonly as ULONG) as ULONG
declare function ldap_search_sW(byval ld as LDAP ptr, byval base as const PWCHAR, byval scope as ULONG, byval filter as const PWCHAR, byval attrs as PWCHAR ptr, byval attrsonly as ULONG, byval res as LDAPMessage ptr ptr) as ULONG
declare function ldap_search_sA(byval ld as LDAP ptr, byval base as const PCHAR, byval scope as ULONG, byval filter as const PCHAR, byval attrs as PCHAR ptr, byval attrsonly as ULONG, byval res as LDAPMessage ptr ptr) as ULONG
declare function ldap_search_stW(byval ld as LDAP ptr, byval base as const PWCHAR, byval scope as ULONG, byval filter as const PWCHAR, byval attrs as PWCHAR ptr, byval attrsonly as ULONG, byval timeout as l_timeval ptr, byval res as LDAPMessage ptr ptr) as ULONG
declare function ldap_search_stA(byval ld as LDAP ptr, byval base as const PCHAR, byval scope as ULONG, byval filter as const PCHAR, byval attrs as PCHAR ptr, byval attrsonly as ULONG, byval timeout as l_timeval ptr, byval res as LDAPMessage ptr ptr) as ULONG
declare function ldap_search_extW(byval ld as LDAP ptr, byval base as const PWCHAR, byval scope as ULONG, byval filter as const PWCHAR, byval attrs as PWCHAR ptr, byval attrsonly as ULONG, byval ServerControls as PLDAPControlW ptr, byval ClientControls as PLDAPControlW ptr, byval TimeLimit as ULONG, byval SizeLimit as ULONG, byval MessageNumber as ULONG ptr) as ULONG
declare function ldap_search_extA(byval ld as LDAP ptr, byval base as const PCHAR, byval scope as ULONG, byval filter as const PCHAR, byval attrs as PCHAR ptr, byval attrsonly as ULONG, byval ServerControls as PLDAPControlA ptr, byval ClientControls as PLDAPControlA ptr, byval TimeLimit as ULONG, byval SizeLimit as ULONG, byval MessageNumber as ULONG ptr) as ULONG
declare function ldap_search_ext_sW(byval ld as LDAP ptr, byval base as const PWCHAR, byval scope as ULONG, byval filter as const PWCHAR, byval attrs as PWCHAR ptr, byval attrsonly as ULONG, byval ServerControls as PLDAPControlW ptr, byval ClientControls as PLDAPControlW ptr, byval timeout as l_timeval ptr, byval SizeLimit as ULONG, byval res as LDAPMessage ptr ptr) as ULONG
declare function ldap_search_ext_sA(byval ld as LDAP ptr, byval base as const PCHAR, byval scope as ULONG, byval filter as const PCHAR, byval attrs as PCHAR ptr, byval attrsonly as ULONG, byval ServerControls as PLDAPControlA ptr, byval ClientControls as PLDAPControlA ptr, byval timeout as l_timeval ptr, byval SizeLimit as ULONG, byval res as LDAPMessage ptr ptr) as ULONG

#ifdef UNICODE
	declare function ldap_search alias "ldap_searchW"(byval ld as LDAP ptr, byval base as const PWCHAR, byval scope as ULONG, byval filter as const PWCHAR, byval attrs as PWCHAR ptr, byval attrsonly as ULONG) as ULONG
	declare function ldap_search_s alias "ldap_search_sW"(byval ld as LDAP ptr, byval base as const PWCHAR, byval scope as ULONG, byval filter as const PWCHAR, byval attrs as PWCHAR ptr, byval attrsonly as ULONG, byval res as LDAPMessage ptr ptr) as ULONG
	declare function ldap_search_st alias "ldap_search_stW"(byval ld as LDAP ptr, byval base as const PWCHAR, byval scope as ULONG, byval filter as const PWCHAR, byval attrs as PWCHAR ptr, byval attrsonly as ULONG, byval timeout as l_timeval ptr, byval res as LDAPMessage ptr ptr) as ULONG
	declare function ldap_search_ext alias "ldap_search_extW"(byval ld as LDAP ptr, byval base as const PWCHAR, byval scope as ULONG, byval filter as const PWCHAR, byval attrs as PWCHAR ptr, byval attrsonly as ULONG, byval ServerControls as PLDAPControlW ptr, byval ClientControls as PLDAPControlW ptr, byval TimeLimit as ULONG, byval SizeLimit as ULONG, byval MessageNumber as ULONG ptr) as ULONG
	declare function ldap_search_ext_s alias "ldap_search_ext_sW"(byval ld as LDAP ptr, byval base as const PWCHAR, byval scope as ULONG, byval filter as const PWCHAR, byval attrs as PWCHAR ptr, byval attrsonly as ULONG, byval ServerControls as PLDAPControlW ptr, byval ClientControls as PLDAPControlW ptr, byval timeout as l_timeval ptr, byval SizeLimit as ULONG, byval res as LDAPMessage ptr ptr) as ULONG
#else
	declare function ldap_search(byval ld as LDAP ptr, byval base as PCHAR, byval scope as ULONG, byval filter as PCHAR, byval attrs as PCHAR ptr, byval attrsonly as ULONG) as ULONG
	declare function ldap_search_s(byval ld as LDAP ptr, byval base as PCHAR, byval scope as ULONG, byval filter as PCHAR, byval attrs as PCHAR ptr, byval attrsonly as ULONG, byval res as LDAPMessage ptr ptr) as ULONG
	declare function ldap_search_st(byval ld as LDAP ptr, byval base as PCHAR, byval scope as ULONG, byval filter as PCHAR, byval attrs as PCHAR ptr, byval attrsonly as ULONG, byval timeout as l_timeval ptr, byval res as LDAPMessage ptr ptr) as ULONG
	declare function ldap_search_ext(byval ld as LDAP ptr, byval base as PCHAR, byval scope as ULONG, byval filter as PCHAR, byval attrs as PCHAR ptr, byval attrsonly as ULONG, byval ServerControls as PLDAPControlA ptr, byval ClientControls as PLDAPControlA ptr, byval TimeLimit as ULONG, byval SizeLimit as ULONG, byval MessageNumber as ULONG ptr) as ULONG
	declare function ldap_search_ext_s(byval ld as LDAP ptr, byval base as PCHAR, byval scope as ULONG, byval filter as PCHAR, byval attrs as PCHAR ptr, byval attrsonly as ULONG, byval ServerControls as PLDAPControlA ptr, byval ClientControls as PLDAPControlA ptr, byval timeout as l_timeval ptr, byval SizeLimit as ULONG, byval res as LDAPMessage ptr ptr) as ULONG
#endif

declare function ldap_check_filterW(byval ld as LDAP ptr, byval SearchFilter as PWCHAR) as ULONG
declare function ldap_check_filterA(byval ld as LDAP ptr, byval SearchFilter as PCHAR) as ULONG

#ifdef UNICODE
	declare function ldap_check_filter alias "ldap_check_filterW"(byval ld as LDAP ptr, byval SearchFilter as PWCHAR) as ULONG
#else
	declare function ldap_check_filter alias "ldap_check_filterA"(byval ld as LDAP ptr, byval SearchFilter as PCHAR) as ULONG
#endif

declare function ldap_modifyW(byval ld as LDAP ptr, byval dn as PWCHAR, byval mods as LDAPModW ptr ptr) as ULONG
declare function ldap_modifyA(byval ld as LDAP ptr, byval dn as PCHAR, byval mods as LDAPModA ptr ptr) as ULONG
declare function ldap_modify_sW(byval ld as LDAP ptr, byval dn as PWCHAR, byval mods as LDAPModW ptr ptr) as ULONG
declare function ldap_modify_sA(byval ld as LDAP ptr, byval dn as PCHAR, byval mods as LDAPModA ptr ptr) as ULONG
declare function ldap_modify_extW(byval ld as LDAP ptr, byval dn as const PWCHAR, byval mods as LDAPModW ptr ptr, byval ServerControls as PLDAPControlW ptr, byval ClientControls as PLDAPControlW ptr, byval MessageNumber as ULONG ptr) as ULONG
declare function ldap_modify_extA(byval ld as LDAP ptr, byval dn as const PCHAR, byval mods as LDAPModA ptr ptr, byval ServerControls as PLDAPControlA ptr, byval ClientControls as PLDAPControlA ptr, byval MessageNumber as ULONG ptr) as ULONG
declare function ldap_modify_ext_sW(byval ld as LDAP ptr, byval dn as const PWCHAR, byval mods as LDAPModW ptr ptr, byval ServerControls as PLDAPControlW ptr, byval ClientControls as PLDAPControlW ptr) as ULONG
declare function ldap_modify_ext_sA(byval ld as LDAP ptr, byval dn as const PCHAR, byval mods as LDAPModA ptr ptr, byval ServerControls as PLDAPControlA ptr, byval ClientControls as PLDAPControlA ptr) as ULONG

#ifdef UNICODE
	declare function ldap_modify alias "ldap_modifyW"(byval ld as LDAP ptr, byval dn as PWCHAR, byval mods as LDAPModW ptr ptr) as ULONG
	declare function ldap_modify_s alias "ldap_modify_sW"(byval ld as LDAP ptr, byval dn as PWCHAR, byval mods as LDAPModW ptr ptr) as ULONG
	declare function ldap_modify_ext alias "ldap_modify_extW"(byval ld as LDAP ptr, byval dn as const PWCHAR, byval mods as LDAPModW ptr ptr, byval ServerControls as PLDAPControlW ptr, byval ClientControls as PLDAPControlW ptr, byval MessageNumber as ULONG ptr) as ULONG
	declare function ldap_modify_ext_s alias "ldap_modify_ext_sW"(byval ld as LDAP ptr, byval dn as const PWCHAR, byval mods as LDAPModW ptr ptr, byval ServerControls as PLDAPControlW ptr, byval ClientControls as PLDAPControlW ptr) as ULONG
#else
	declare function ldap_modify(byval ld as LDAP ptr, byval dn as PCHAR, byval mods as LDAPModA ptr ptr) as ULONG
	declare function ldap_modify_s(byval ld as LDAP ptr, byval dn as PCHAR, byval mods as LDAPModA ptr ptr) as ULONG
	declare function ldap_modify_ext(byval ld as LDAP ptr, byval dn as const PCHAR, byval mods as LDAPModA ptr ptr, byval ServerControls as PLDAPControlA ptr, byval ClientControls as PLDAPControlA ptr, byval MessageNumber as ULONG ptr) as ULONG
	declare function ldap_modify_ext_s(byval ld as LDAP ptr, byval dn as const PCHAR, byval mods as LDAPModA ptr ptr, byval ServerControls as PLDAPControlA ptr, byval ClientControls as PLDAPControlA ptr) as ULONG
#endif

declare function ldap_modrdn2W(byval ExternalHandle as LDAP ptr, byval DistinguishedName as const PWCHAR, byval NewDistinguishedName as const PWCHAR, byval DeleteOldRdn as INT_) as ULONG
declare function ldap_modrdn2A(byval ExternalHandle as LDAP ptr, byval DistinguishedName as const PCHAR, byval NewDistinguishedName as const PCHAR, byval DeleteOldRdn as INT_) as ULONG
declare function ldap_modrdnW(byval ExternalHandle as LDAP ptr, byval DistinguishedName as const PWCHAR, byval NewDistinguishedName as const PWCHAR) as ULONG
declare function ldap_modrdnA(byval ExternalHandle as LDAP ptr, byval DistinguishedName as const PCHAR, byval NewDistinguishedName as const PCHAR) as ULONG
declare function ldap_modrdn2_sW(byval ExternalHandle as LDAP ptr, byval DistinguishedName as const PWCHAR, byval NewDistinguishedName as const PWCHAR, byval DeleteOldRdn as INT_) as ULONG
declare function ldap_modrdn2_sA(byval ExternalHandle as LDAP ptr, byval DistinguishedName as const PCHAR, byval NewDistinguishedName as const PCHAR, byval DeleteOldRdn as INT_) as ULONG
declare function ldap_modrdn_sW(byval ExternalHandle as LDAP ptr, byval DistinguishedName as const PWCHAR, byval NewDistinguishedName as const PWCHAR) as ULONG
declare function ldap_modrdn_sA(byval ExternalHandle as LDAP ptr, byval DistinguishedName as const PCHAR, byval NewDistinguishedName as const PCHAR) as ULONG

#ifdef UNICODE
	declare function ldap_modrdn2 alias "ldap_modrdn2W"(byval ExternalHandle as LDAP ptr, byval DistinguishedName as const PWCHAR, byval NewDistinguishedName as const PWCHAR, byval DeleteOldRdn as INT_) as ULONG
	declare function ldap_modrdn alias "ldap_modrdnW"(byval ExternalHandle as LDAP ptr, byval DistinguishedName as const PWCHAR, byval NewDistinguishedName as const PWCHAR) as ULONG
	declare function ldap_modrdn2_s alias "ldap_modrdn2_sW"(byval ExternalHandle as LDAP ptr, byval DistinguishedName as const PWCHAR, byval NewDistinguishedName as const PWCHAR, byval DeleteOldRdn as INT_) as ULONG
	declare function ldap_modrdn_s alias "ldap_modrdn_sW"(byval ExternalHandle as LDAP ptr, byval DistinguishedName as const PWCHAR, byval NewDistinguishedName as const PWCHAR) as ULONG
#else
	declare function ldap_modrdn2(byval ExternalHandle as LDAP ptr, byval DistinguishedName as const PCHAR, byval NewDistinguishedName as const PCHAR, byval DeleteOldRdn as INT_) as ULONG
	declare function ldap_modrdn(byval ExternalHandle as LDAP ptr, byval DistinguishedName as const PCHAR, byval NewDistinguishedName as const PCHAR) as ULONG
	declare function ldap_modrdn2_s(byval ExternalHandle as LDAP ptr, byval DistinguishedName as const PCHAR, byval NewDistinguishedName as const PCHAR, byval DeleteOldRdn as INT_) as ULONG
	declare function ldap_modrdn_s(byval ExternalHandle as LDAP ptr, byval DistinguishedName as const PCHAR, byval NewDistinguishedName as const PCHAR) as ULONG
#endif

declare function ldap_rename_extW(byval ld as LDAP ptr, byval dn as const PWCHAR, byval NewRDN as const PWCHAR, byval NewParent as const PWCHAR, byval DeleteOldRdn as INT_, byval ServerControls as PLDAPControlW ptr, byval ClientControls as PLDAPControlW ptr, byval MessageNumber as ULONG ptr) as ULONG
declare function ldap_rename_extA(byval ld as LDAP ptr, byval dn as const PCHAR, byval NewRDN as const PCHAR, byval NewParent as const PCHAR, byval DeleteOldRdn as INT_, byval ServerControls as PLDAPControlA ptr, byval ClientControls as PLDAPControlA ptr, byval MessageNumber as ULONG ptr) as ULONG
declare function ldap_rename_ext_sW(byval ld as LDAP ptr, byval dn as const PWCHAR, byval NewRDN as const PWCHAR, byval NewParent as const PWCHAR, byval DeleteOldRdn as INT_, byval ServerControls as PLDAPControlW ptr, byval ClientControls as PLDAPControlW ptr) as ULONG
declare function ldap_rename_ext_sA(byval ld as LDAP ptr, byval dn as const PCHAR, byval NewRDN as const PCHAR, byval NewParent as const PCHAR, byval DeleteOldRdn as INT_, byval ServerControls as PLDAPControlA ptr, byval ClientControls as PLDAPControlA ptr) as ULONG

#ifdef UNICODE
	declare function ldap_rename alias "ldap_rename_extW"(byval ld as LDAP ptr, byval dn as const PWCHAR, byval NewRDN as const PWCHAR, byval NewParent as const PWCHAR, byval DeleteOldRdn as INT_, byval ServerControls as PLDAPControlW ptr, byval ClientControls as PLDAPControlW ptr, byval MessageNumber as ULONG ptr) as ULONG
	declare function ldap_rename_s alias "ldap_rename_ext_sW"(byval ld as LDAP ptr, byval dn as const PWCHAR, byval NewRDN as const PWCHAR, byval NewParent as const PWCHAR, byval DeleteOldRdn as INT_, byval ServerControls as PLDAPControlW ptr, byval ClientControls as PLDAPControlW ptr) as ULONG
	declare function ldap_rename_ext alias "ldap_rename_extW"(byval ld as LDAP ptr, byval dn as const PWCHAR, byval NewRDN as const PWCHAR, byval NewParent as const PWCHAR, byval DeleteOldRdn as INT_, byval ServerControls as PLDAPControlW ptr, byval ClientControls as PLDAPControlW ptr, byval MessageNumber as ULONG ptr) as ULONG
	declare function ldap_rename_ext_s alias "ldap_rename_ext_sW"(byval ld as LDAP ptr, byval dn as const PWCHAR, byval NewRDN as const PWCHAR, byval NewParent as const PWCHAR, byval DeleteOldRdn as INT_, byval ServerControls as PLDAPControlW ptr, byval ClientControls as PLDAPControlW ptr) as ULONG
#else
	declare function ldap_rename alias "ldap_rename_extA"(byval ld as LDAP ptr, byval dn as const PCHAR, byval NewRDN as const PCHAR, byval NewParent as const PCHAR, byval DeleteOldRdn as INT_, byval ServerControls as PLDAPControlA ptr, byval ClientControls as PLDAPControlA ptr, byval MessageNumber as ULONG ptr) as ULONG
	declare function ldap_rename_s alias "ldap_rename_ext_sA"(byval ld as LDAP ptr, byval dn as const PCHAR, byval NewRDN as const PCHAR, byval NewParent as const PCHAR, byval DeleteOldRdn as INT_, byval ServerControls as PLDAPControlA ptr, byval ClientControls as PLDAPControlA ptr) as ULONG
	declare function ldap_rename_ext(byval ld as LDAP ptr, byval dn as const PCHAR, byval NewRDN as const PCHAR, byval NewParent as const PCHAR, byval DeleteOldRdn as INT_, byval ServerControls as PLDAPControlA ptr, byval ClientControls as PLDAPControlA ptr, byval MessageNumber as ULONG ptr) as ULONG
	declare function ldap_rename_ext_s(byval ld as LDAP ptr, byval dn as const PCHAR, byval NewRDN as const PCHAR, byval NewParent as const PCHAR, byval DeleteOldRdn as INT_, byval ServerControls as PLDAPControlA ptr, byval ClientControls as PLDAPControlA ptr) as ULONG
#endif

declare function ldap_addW(byval ld as LDAP ptr, byval dn as PWCHAR, byval attrs as LDAPModW ptr ptr) as ULONG
declare function ldap_addA(byval ld as LDAP ptr, byval dn as PCHAR, byval attrs as LDAPModA ptr ptr) as ULONG
declare function ldap_add_sW(byval ld as LDAP ptr, byval dn as PWCHAR, byval attrs as LDAPModW ptr ptr) as ULONG
declare function ldap_add_sA(byval ld as LDAP ptr, byval dn as PCHAR, byval attrs as LDAPModA ptr ptr) as ULONG
declare function ldap_add_extW(byval ld as LDAP ptr, byval dn as const PWCHAR, byval attrs as LDAPModW ptr ptr, byval ServerControls as PLDAPControlW ptr, byval ClientControls as PLDAPControlW ptr, byval MessageNumber as ULONG ptr) as ULONG
declare function ldap_add_extA(byval ld as LDAP ptr, byval dn as const PCHAR, byval attrs as LDAPModA ptr ptr, byval ServerControls as PLDAPControlA ptr, byval ClientControls as PLDAPControlA ptr, byval MessageNumber as ULONG ptr) as ULONG
declare function ldap_add_ext_sW(byval ld as LDAP ptr, byval dn as const PWCHAR, byval attrs as LDAPModW ptr ptr, byval ServerControls as PLDAPControlW ptr, byval ClientControls as PLDAPControlW ptr) as ULONG
declare function ldap_add_ext_sA(byval ld as LDAP ptr, byval dn as const PCHAR, byval attrs as LDAPModA ptr ptr, byval ServerControls as PLDAPControlA ptr, byval ClientControls as PLDAPControlA ptr) as ULONG

#ifdef UNICODE
	declare function ldap_add alias "ldap_addW"(byval ld as LDAP ptr, byval dn as PWCHAR, byval attrs as LDAPModW ptr ptr) as ULONG
	declare function ldap_add_s alias "ldap_add_sW"(byval ld as LDAP ptr, byval dn as PWCHAR, byval attrs as LDAPModW ptr ptr) as ULONG
	declare function ldap_add_ext alias "ldap_add_extW"(byval ld as LDAP ptr, byval dn as const PWCHAR, byval attrs as LDAPModW ptr ptr, byval ServerControls as PLDAPControlW ptr, byval ClientControls as PLDAPControlW ptr, byval MessageNumber as ULONG ptr) as ULONG
	declare function ldap_add_ext_s alias "ldap_add_ext_sW"(byval ld as LDAP ptr, byval dn as const PWCHAR, byval attrs as LDAPModW ptr ptr, byval ServerControls as PLDAPControlW ptr, byval ClientControls as PLDAPControlW ptr) as ULONG
#else
	declare function ldap_add(byval ld as LDAP ptr, byval dn as PCHAR, byval attrs as LDAPModA ptr ptr) as ULONG
	declare function ldap_add_s(byval ld as LDAP ptr, byval dn as PCHAR, byval attrs as LDAPModA ptr ptr) as ULONG
	declare function ldap_add_ext(byval ld as LDAP ptr, byval dn as const PCHAR, byval attrs as LDAPModA ptr ptr, byval ServerControls as PLDAPControlA ptr, byval ClientControls as PLDAPControlA ptr, byval MessageNumber as ULONG ptr) as ULONG
	declare function ldap_add_ext_s(byval ld as LDAP ptr, byval dn as const PCHAR, byval attrs as LDAPModA ptr ptr, byval ServerControls as PLDAPControlA ptr, byval ClientControls as PLDAPControlA ptr) as ULONG
#endif

declare function ldap_compareW(byval ld as LDAP ptr, byval dn as const PWCHAR, byval attr as const PWCHAR, byval value as PWCHAR) as ULONG
declare function ldap_compareA(byval ld as LDAP ptr, byval dn as const PCHAR, byval attr as const PCHAR, byval value as PCHAR) as ULONG
declare function ldap_compare_sW(byval ld as LDAP ptr, byval dn as const PWCHAR, byval attr as const PWCHAR, byval value as PWCHAR) as ULONG
declare function ldap_compare_sA(byval ld as LDAP ptr, byval dn as const PCHAR, byval attr as const PCHAR, byval value as PCHAR) as ULONG

#ifdef UNICODE
	declare function ldap_compare alias "ldap_compareW"(byval ld as LDAP ptr, byval dn as const PWCHAR, byval attr as const PWCHAR, byval value as PWCHAR) as ULONG
	declare function ldap_compare_s alias "ldap_compare_sW"(byval ld as LDAP ptr, byval dn as const PWCHAR, byval attr as const PWCHAR, byval value as PWCHAR) as ULONG
#else
	declare function ldap_compare(byval ld as LDAP ptr, byval dn as const PCHAR, byval attr as const PCHAR, byval value as PCHAR) as ULONG
	declare function ldap_compare_s(byval ld as LDAP ptr, byval dn as const PCHAR, byval attr as const PCHAR, byval value as PCHAR) as ULONG
#endif

declare function ldap_compare_extW(byval ld as LDAP ptr, byval dn as const PWCHAR, byval Attr as const PWCHAR, byval Value as const PWCHAR, byval Data as BERVAL ptr, byval ServerControls as PLDAPControlW ptr, byval ClientControls as PLDAPControlW ptr, byval MessageNumber as ULONG ptr) as ULONG
declare function ldap_compare_extA(byval ld as LDAP ptr, byval dn as const PCHAR, byval Attr as const PCHAR, byval Value as const PCHAR, byval Data as BERVAL ptr, byval ServerControls as PLDAPControlA ptr, byval ClientControls as PLDAPControlA ptr, byval MessageNumber as ULONG ptr) as ULONG
declare function ldap_compare_ext_sW(byval ld as LDAP ptr, byval dn as const PWCHAR, byval Attr as const PWCHAR, byval Value as const PWCHAR, byval Data as BERVAL ptr, byval ServerControls as PLDAPControlW ptr, byval ClientControls as PLDAPControlW ptr) as ULONG
declare function ldap_compare_ext_sA(byval ld as LDAP ptr, byval dn as const PCHAR, byval Attr as const PCHAR, byval Value as const PCHAR, byval Data as BERVAL ptr, byval ServerControls as PLDAPControlA ptr, byval ClientControls as PLDAPControlA ptr) as ULONG

#ifdef UNICODE
	declare function ldap_compare_ext alias "ldap_compare_extW"(byval ld as LDAP ptr, byval dn as const PWCHAR, byval Attr as const PWCHAR, byval Value as const PWCHAR, byval Data as BERVAL ptr, byval ServerControls as PLDAPControlW ptr, byval ClientControls as PLDAPControlW ptr, byval MessageNumber as ULONG ptr) as ULONG
	declare function ldap_compare_ext_s alias "ldap_compare_ext_sW"(byval ld as LDAP ptr, byval dn as const PWCHAR, byval Attr as const PWCHAR, byval Value as const PWCHAR, byval Data as BERVAL ptr, byval ServerControls as PLDAPControlW ptr, byval ClientControls as PLDAPControlW ptr) as ULONG
#else
	declare function ldap_compare_ext(byval ld as LDAP ptr, byval dn as const PCHAR, byval Attr as const PCHAR, byval Value as const PCHAR, byval Data as BERVAL ptr, byval ServerControls as PLDAPControlA ptr, byval ClientControls as PLDAPControlA ptr, byval MessageNumber as ULONG ptr) as ULONG
	declare function ldap_compare_ext_s(byval ld as LDAP ptr, byval dn as const PCHAR, byval Attr as const PCHAR, byval Value as const PCHAR, byval Data as BERVAL ptr, byval ServerControls as PLDAPControlA ptr, byval ClientControls as PLDAPControlA ptr) as ULONG
#endif

declare function ldap_deleteW(byval ld as LDAP ptr, byval dn as const PWCHAR) as ULONG
declare function ldap_deleteA(byval ld as LDAP ptr, byval dn as const PCHAR) as ULONG
declare function ldap_delete_sW(byval ld as LDAP ptr, byval dn as const PWCHAR) as ULONG
declare function ldap_delete_sA(byval ld as LDAP ptr, byval dn as const PCHAR) as ULONG
declare function ldap_delete_extW(byval ld as LDAP ptr, byval dn as const PWCHAR, byval ServerControls as PLDAPControlW ptr, byval ClientControls as PLDAPControlW ptr, byval MessageNumber as ULONG ptr) as ULONG
declare function ldap_delete_extA(byval ld as LDAP ptr, byval dn as const PCHAR, byval ServerControls as PLDAPControlA ptr, byval ClientControls as PLDAPControlA ptr, byval MessageNumber as ULONG ptr) as ULONG
declare function ldap_delete_ext_sW(byval ld as LDAP ptr, byval dn as const PWCHAR, byval ServerControls as PLDAPControlW ptr, byval ClientControls as PLDAPControlW ptr) as ULONG
declare function ldap_delete_ext_sA(byval ld as LDAP ptr, byval dn as const PCHAR, byval ServerControls as PLDAPControlA ptr, byval ClientControls as PLDAPControlA ptr) as ULONG

#ifdef UNICODE
	declare function ldap_delete alias "ldap_deleteW"(byval ld as LDAP ptr, byval dn as const PWCHAR) as ULONG
	declare function ldap_delete_ext alias "ldap_delete_extW"(byval ld as LDAP ptr, byval dn as const PWCHAR, byval ServerControls as PLDAPControlW ptr, byval ClientControls as PLDAPControlW ptr, byval MessageNumber as ULONG ptr) as ULONG
	declare function ldap_delete_s alias "ldap_delete_sW"(byval ld as LDAP ptr, byval dn as const PWCHAR) as ULONG
	declare function ldap_delete_ext_s alias "ldap_delete_ext_sW"(byval ld as LDAP ptr, byval dn as const PWCHAR, byval ServerControls as PLDAPControlW ptr, byval ClientControls as PLDAPControlW ptr) as ULONG
#else
	declare function ldap_delete(byval ld as LDAP ptr, byval dn as PCHAR) as ULONG
	declare function ldap_delete_s(byval ld as LDAP ptr, byval dn as PCHAR) as ULONG
	declare function ldap_delete_ext(byval ld as LDAP ptr, byval dn as const PCHAR, byval ServerControls as PLDAPControlA ptr, byval ClientControls as PLDAPControlA ptr, byval MessageNumber as ULONG ptr) as ULONG
	declare function ldap_delete_ext_s(byval ld as LDAP ptr, byval dn as const PCHAR, byval ServerControls as PLDAPControlA ptr, byval ClientControls as PLDAPControlA ptr) as ULONG
#endif

declare function ldap_abandon(byval ld as LDAP ptr, byval msgid as ULONG) as ULONG
const LDAP_MSG_ONE = 0
const LDAP_MSG_ALL = 1
const LDAP_MSG_RECEIVED = 2

declare function ldap_result(byval ld as LDAP ptr, byval msgid as ULONG, byval all as ULONG, byval timeout as l_timeval ptr, byval res as LDAPMessage ptr ptr) as ULONG
declare function ldap_msgfree(byval res as LDAPMessage ptr) as ULONG
declare function ldap_result2error(byval ld as LDAP ptr, byval res as LDAPMessage ptr, byval freeit as ULONG) as ULONG
declare function ldap_parse_resultW(byval Connection as LDAP ptr, byval ResultMessage as LDAPMessage ptr, byval ReturnCode as ULONG ptr, byval MatchedDNs as PWCHAR ptr, byval ErrorMessage as PWCHAR ptr, byval Referrals as PWCHAR ptr ptr, byval ServerControls as PLDAPControlW ptr ptr, byval Freeit as WINBOOLEAN) as ULONG
declare function ldap_parse_resultA(byval Connection as LDAP ptr, byval ResultMessage as LDAPMessage ptr, byval ReturnCode as ULONG ptr, byval MatchedDNs as PCHAR ptr, byval ErrorMessage as PCHAR ptr, byval Referrals as PCHAR ptr ptr, byval ServerControls as PLDAPControlA ptr ptr, byval Freeit as WINBOOLEAN) as ULONG
declare function ldap_parse_extended_resultA(byval Connection as LDAP ptr, byval ResultMessage as LDAPMessage ptr, byval ResultOID as PCHAR ptr, byval ResultData as BERVAL ptr ptr, byval Freeit as WINBOOLEAN) as ULONG
declare function ldap_parse_extended_resultW(byval Connection as LDAP ptr, byval ResultMessage as LDAPMessage ptr, byval ResultOID as PWCHAR ptr, byval ResultData as BERVAL ptr ptr, byval Freeit as WINBOOLEAN) as ULONG
declare function ldap_controls_freeA(byval Controls as LDAPControlA ptr ptr) as ULONG
declare function ldap_control_freeA(byval Controls as LDAPControlA ptr) as ULONG
declare function ldap_controls_freeW(byval Control as LDAPControlW ptr ptr) as ULONG
declare function ldap_control_freeW(byval Control as LDAPControlW ptr) as ULONG
declare function ldap_free_controlsW(byval Controls as LDAPControlW ptr ptr) as ULONG
declare function ldap_free_controlsA(byval Controls as LDAPControlA ptr ptr) as ULONG

#ifdef UNICODE
	declare function ldap_parse_result alias "ldap_parse_resultW"(byval Connection as LDAP ptr, byval ResultMessage as LDAPMessage ptr, byval ReturnCode as ULONG ptr, byval MatchedDNs as PWCHAR ptr, byval ErrorMessage as PWCHAR ptr, byval Referrals as PWCHAR ptr ptr, byval ServerControls as PLDAPControlW ptr ptr, byval Freeit as WINBOOLEAN) as ULONG
	declare function ldap_controls_free alias "ldap_controls_freeW"(byval Control as LDAPControlW ptr ptr) as ULONG
	declare function ldap_control_free alias "ldap_control_freeW"(byval Control as LDAPControlW ptr) as ULONG
	declare function ldap_free_controls alias "ldap_free_controlsW"(byval Controls as LDAPControlW ptr ptr) as ULONG
	declare function ldap_parse_extended_result alias "ldap_parse_extended_resultW"(byval Connection as LDAP ptr, byval ResultMessage as LDAPMessage ptr, byval ResultOID as PWCHAR ptr, byval ResultData as BERVAL ptr ptr, byval Freeit as WINBOOLEAN) as ULONG
#else
	declare function ldap_parse_extended_result alias "ldap_parse_extended_resultA"(byval Connection as LDAP ptr, byval ResultMessage as LDAPMessage ptr, byval ResultOID as PCHAR ptr, byval ResultData as BERVAL ptr ptr, byval Freeit as WINBOOLEAN) as ULONG
	declare function ldap_parse_result(byval Connection as LDAP ptr, byval ResultMessage as LDAPMessage ptr, byval ReturnCode as ULONG ptr, byval MatchedDNs as PCHAR ptr, byval ErrorMessage as PCHAR ptr, byval Referrals as PCHAR ptr ptr, byval ServerControls as PLDAPControlA ptr ptr, byval Freeit as WINBOOLEAN) as ULONG
	declare function ldap_controls_free(byval Controls as LDAPControlA ptr ptr) as ULONG
	declare function ldap_control_free(byval Control as LDAPControlA ptr) as ULONG
	declare function ldap_free_controls(byval Controls as LDAPControlA ptr ptr) as ULONG
#endif

declare function ldap_err2stringW(byval err as ULONG) as PWCHAR
declare function ldap_err2stringA(byval err as ULONG) as PCHAR

#ifdef UNICODE
	declare function ldap_err2string alias "ldap_err2stringW"(byval err as ULONG) as PWCHAR
#else
	declare function ldap_err2string(byval err as ULONG) as PCHAR
#endif

declare sub ldap_perror(byval ld as LDAP ptr, byval msg as const PCHAR)
declare function ldap_first_entry(byval ld as LDAP ptr, byval res as LDAPMessage ptr) as LDAPMessage ptr
declare function ldap_next_entry(byval ld as LDAP ptr, byval entry as LDAPMessage ptr) as LDAPMessage ptr
declare function ldap_count_entries(byval ld as LDAP ptr, byval res as LDAPMessage ptr) as ULONG

type BerElement_
	opaque as PCHAR
end type

const NULLBER = cptr(BerElement ptr, 0)
declare function ldap_first_attributeW(byval ld as LDAP ptr, byval entry as LDAPMessage ptr, byval ptr as BerElement ptr ptr) as PWCHAR
declare function ldap_first_attributeA(byval ld as LDAP ptr, byval entry as LDAPMessage ptr, byval ptr as BerElement ptr ptr) as PCHAR

#ifdef UNICODE
	declare function ldap_first_attribute alias "ldap_first_attributeW"(byval ld as LDAP ptr, byval entry as LDAPMessage ptr, byval ptr as BerElement ptr ptr) as PWCHAR
#else
	declare function ldap_first_attribute(byval ld as LDAP ptr, byval entry as LDAPMessage ptr, byval ptr as BerElement ptr ptr) as PCHAR
#endif

declare function ldap_next_attributeW(byval ld as LDAP ptr, byval entry as LDAPMessage ptr, byval ptr as BerElement ptr) as PWCHAR
declare function ldap_next_attributeA(byval ld as LDAP ptr, byval entry as LDAPMessage ptr, byval ptr as BerElement ptr) as PCHAR

#ifdef UNICODE
	declare function ldap_next_attribute alias "ldap_next_attributeW"(byval ld as LDAP ptr, byval entry as LDAPMessage ptr, byval ptr as BerElement ptr) as PWCHAR
#else
	declare function ldap_next_attribute(byval ld as LDAP ptr, byval entry as LDAPMessage ptr, byval ptr as BerElement ptr) as PCHAR
#endif

declare function ldap_get_valuesW(byval ld as LDAP ptr, byval entry as LDAPMessage ptr, byval attr as const PWCHAR) as PWCHAR ptr
declare function ldap_get_valuesA(byval ld as LDAP ptr, byval entry as LDAPMessage ptr, byval attr as const PCHAR) as PCHAR ptr

#ifdef UNICODE
	declare function ldap_get_values alias "ldap_get_valuesW"(byval ld as LDAP ptr, byval entry as LDAPMessage ptr, byval attr as const PWCHAR) as PWCHAR ptr
#else
	declare function ldap_get_values(byval ld as LDAP ptr, byval entry as LDAPMessage ptr, byval attr as const PCHAR) as PCHAR ptr
#endif

declare function ldap_get_values_lenW(byval ExternalHandle as LDAP ptr, byval Message as LDAPMessage ptr, byval attr as const PWCHAR) as BERVAL ptr ptr
declare function ldap_get_values_lenA(byval ExternalHandle as LDAP ptr, byval Message as LDAPMessage ptr, byval attr as const PCHAR) as BERVAL ptr ptr

#ifdef UNICODE
	declare function ldap_get_values_len alias "ldap_get_values_lenW"(byval ExternalHandle as LDAP ptr, byval Message as LDAPMessage ptr, byval attr as const PWCHAR) as BERVAL ptr ptr
#else
	declare function ldap_get_values_len(byval ExternalHandle as LDAP ptr, byval Message as LDAPMessage ptr, byval attr as const PCHAR) as BERVAL ptr ptr
#endif

declare function ldap_count_valuesW(byval vals as PWCHAR ptr) as ULONG
declare function ldap_count_valuesA(byval vals as PCHAR ptr) as ULONG

#ifdef UNICODE
	declare function ldap_count_values alias "ldap_count_valuesW"(byval vals as PWCHAR ptr) as ULONG
#else
	declare function ldap_count_values(byval vals as PCHAR ptr) as ULONG
#endif

declare function ldap_count_values_len(byval vals as BERVAL ptr ptr) as ULONG
declare function ldap_value_freeW(byval vals as PWCHAR ptr) as ULONG
declare function ldap_value_freeA(byval vals as PCHAR ptr) as ULONG

#ifdef UNICODE
	declare function ldap_value_free alias "ldap_value_freeW"(byval vals as PWCHAR ptr) as ULONG
#else
	declare function ldap_value_free(byval vals as PCHAR ptr) as ULONG
#endif

declare function ldap_value_free_len(byval vals as BERVAL ptr ptr) as ULONG
declare function ldap_get_dnW(byval ld as LDAP ptr, byval entry as LDAPMessage ptr) as PWCHAR
declare function ldap_get_dnA(byval ld as LDAP ptr, byval entry as LDAPMessage ptr) as PCHAR

#ifdef UNICODE
	declare function ldap_get_dn alias "ldap_get_dnW"(byval ld as LDAP ptr, byval entry as LDAPMessage ptr) as PWCHAR
#else
	declare function ldap_get_dn(byval ld as LDAP ptr, byval entry as LDAPMessage ptr) as PCHAR
#endif

declare function ldap_explode_dnW(byval dn as const PWCHAR, byval notypes as ULONG) as PWCHAR ptr
declare function ldap_explode_dnA(byval dn as const PCHAR, byval notypes as ULONG) as PCHAR ptr

#ifdef UNICODE
	declare function ldap_explode_dn alias "ldap_explode_dnW"(byval dn as const PWCHAR, byval notypes as ULONG) as PWCHAR ptr
#else
	declare function ldap_explode_dn(byval dn as const PCHAR, byval notypes as ULONG) as PCHAR ptr
#endif

declare function ldap_dn2ufnW(byval dn as const PWCHAR) as PWCHAR
declare function ldap_dn2ufnA(byval dn as const PCHAR) as PCHAR

#ifdef UNICODE
	declare function ldap_dn2ufn alias "ldap_dn2ufnW"(byval dn as const PWCHAR) as PWCHAR
#else
	declare function ldap_dn2ufn(byval dn as const PCHAR) as PCHAR
#endif

declare sub ldap_memfreeW(byval Block as PWCHAR)
declare sub ldap_memfreeA(byval Block as PCHAR)

#ifdef UNICODE
	declare sub ldap_memfree alias "ldap_memfreeW"(byval Block as PWCHAR)
#else
	declare sub ldap_memfree(byval Block as PCHAR)
#endif

declare function ldap_ufn2dnW(byval ufn as const PWCHAR, byval pDn as PWCHAR ptr) as ULONG
declare function ldap_ufn2dnA(byval ufn as const PCHAR, byval pDn as PCHAR ptr) as ULONG

#ifdef UNICODE
	declare function ldap_ufn2dn alias "ldap_ufn2dnW"(byval ufn as const PWCHAR, byval pDn as PWCHAR ptr) as ULONG
#else
	declare function ldap_ufn2dn(byval ufn as const PCHAR, byval pDn as PCHAR ptr) as ULONG
#endif

const LBER_USE_DER = &h01
const LBER_USE_INDEFINITE_LEN = &h02
const LBER_TRANSLATE_STRINGS = &h04
const LAPI_MAJOR_VER1 = 1
const LAPI_MINOR_VER1 = 1

type LDAP_VERSION_INFO
	lv_size as ULONG
	lv_major as ULONG
	lv_minor as ULONG
end type

type PLDAP_VERSION_INFO as LDAP_VERSION_INFO ptr
declare function ldap_startup(byval version as PLDAP_VERSION_INFO, byval Instance as HANDLE ptr) as ULONG
const LDAP_API_INFO_VERSION = 1
const LDAP_API_VERSION = 2004
const LDAP_VERSION_MIN = 2
const LDAP_VERSION_MAX = 3
#define LDAP_VENDOR_NAME "Microsoft Corporation."
#define LDAP_VENDOR_NAME_W wstr("Microsoft Corporation.")
const LDAP_VENDOR_VERSION = 510

type LDAPAPIInfoA
	ldapai_info_version as long
	ldapai_api_version as long
	ldapai_protocol_version as long
	ldapai_extensions as zstring ptr ptr
	ldapai_vendor_name as zstring ptr
	ldapai_vendor_version as long
end type

type LDAPAPIInfoW
	ldapai_info_version as long
	ldapai_api_version as long
	ldapai_protocol_version as long
	ldapai_extensions as PWCHAR ptr
	ldapai_vendor_name as PWCHAR
	ldapai_vendor_version as long
end type

const LDAP_FEATURE_INFO_VERSION = 1

type ldap_apifeature_infoA
	ldapaif_info_version as long
	ldapaif_name as zstring ptr
	ldapaif_version as long
end type

type LDAPAPIFeatureInfoA as ldap_apifeature_infoA

type ldap_apifeature_infoW
	ldapaif_info_version as long
	ldapaif_name as PWCHAR
	ldapaif_version as long
end type

type LDAPAPIFeatureInfoW as ldap_apifeature_infoW

#ifdef UNICODE
	type LDAPAPIInfo as LDAPAPIInfoW
	type LDAPAPIFeatureInfo as LDAPAPIFeatureInfoW
#else
	type LDAPAPIInfo as LDAPAPIInfoA
	type LDAPAPIFeatureInfo as LDAPAPIFeatureInfoA
#endif

declare function ldap_cleanup(byval hInstance as HANDLE) as ULONG
declare function ldap_escape_filter_elementW(byval sourceFilterElement as PCHAR, byval sourceLength as ULONG, byval destFilterElement as PWCHAR, byval destLength as ULONG) as ULONG
declare function ldap_escape_filter_elementA(byval sourceFilterElement as PCHAR, byval sourceLength as ULONG, byval destFilterElement as PCHAR, byval destLength as ULONG) as ULONG

#ifdef UNICODE
	declare function ldap_escape_filter_element alias "ldap_escape_filter_elementW"(byval sourceFilterElement as PCHAR, byval sourceLength as ULONG, byval destFilterElement as PWCHAR, byval destLength as ULONG) as ULONG
#else
	declare function ldap_escape_filter_element(byval sourceFilterElement as PCHAR, byval sourceLength as ULONG, byval destFilterElement as PCHAR, byval destLength as ULONG) as ULONG
#endif

declare function ldap_set_dbg_flags(byval NewFlags as ULONG) as ULONG
type DBGPRINT as function(byval Format as PCH, ...) as ULONG
declare sub ldap_set_dbg_routine(byval DebugPrintRoutine as DBGPRINT)
declare function LdapUTF8ToUnicode(byval lpSrcStr as LPCSTR, byval cchSrc as long, byval lpDestStr as LPWSTR, byval cchDest as long) as long
declare function LdapUnicodeToUTF8(byval lpSrcStr as LPCWSTR, byval cchSrc as long, byval lpDestStr as LPSTR, byval cchDest as long) as long

#define LDAP_SERVER_SORT_OID "1.2.840.113556.1.4.473"
#define LDAP_SERVER_SORT_OID_W wstr("1.2.840.113556.1.4.473")
#define LDAP_SERVER_RESP_SORT_OID "1.2.840.113556.1.4.474"
#define LDAP_SERVER_RESP_SORT_OID_W wstr("1.2.840.113556.1.4.474")
type PLDAPSearch as LDAPSearch ptr

type LDAPSortKeyW
	sk_attrtype as PWCHAR
	sk_matchruleoid as PWCHAR
	sk_reverseorder as WINBOOLEAN
end type

type PLDAPSortKeyW as LDAPSortKeyW ptr

type LDAPSortKeyA
	sk_attrtype as PCHAR
	sk_matchruleoid as PCHAR
	sk_reverseorder as WINBOOLEAN
end type

type PLDAPSortKeyA as LDAPSortKeyA ptr

#ifdef UNICODE
	type LDAPSortKey as LDAPSortKeyW
	type PLDAPSortKey as PLDAPSortKeyW
#else
	type LDAPSortKey as LDAPSortKeyA
	type PLDAPSortKey as PLDAPSortKeyA
#endif

declare function ldap_create_sort_controlA(byval ExternalHandle as PLDAP, byval SortKeys as PLDAPSortKeyA ptr, byval IsCritical as UCHAR, byval Control as PLDAPControlA ptr) as ULONG
declare function ldap_create_sort_controlW(byval ExternalHandle as PLDAP, byval SortKeys as PLDAPSortKeyW ptr, byval IsCritical as UCHAR, byval Control as PLDAPControlW ptr) as ULONG
declare function ldap_parse_sort_controlA(byval ExternalHandle as PLDAP, byval Control as PLDAPControlA ptr, byval Result as ULONG ptr, byval Attribute as PCHAR ptr) as ULONG
declare function ldap_parse_sort_controlW(byval ExternalHandle as PLDAP, byval Control as PLDAPControlW ptr, byval Result as ULONG ptr, byval Attribute as PWCHAR ptr) as ULONG

#ifdef UNICODE
	declare function ldap_create_sort_control alias "ldap_create_sort_controlW"(byval ExternalHandle as PLDAP, byval SortKeys as PLDAPSortKeyW ptr, byval IsCritical as UCHAR, byval Control as PLDAPControlW ptr) as ULONG
	declare function ldap_parse_sort_control alias "ldap_parse_sort_controlW"(byval ExternalHandle as PLDAP, byval Control as PLDAPControlW ptr, byval Result as ULONG ptr, byval Attribute as PWCHAR ptr) as ULONG
#else
	declare function ldap_create_sort_control(byval ExternalHandle as PLDAP, byval SortKeys as PLDAPSortKeyA ptr, byval IsCritical as UCHAR, byval Control as PLDAPControlA ptr) as ULONG
	declare function ldap_parse_sort_control(byval ExternalHandle as PLDAP, byval Control as PLDAPControlA ptr, byval Result as ULONG ptr, byval Attribute as PCHAR ptr) as ULONG
#endif

declare function ldap_encode_sort_controlW(byval ExternalHandle as PLDAP, byval SortKeys as PLDAPSortKeyW ptr, byval Control as PLDAPControlW, byval Criticality as WINBOOLEAN) as ULONG
declare function ldap_encode_sort_controlA(byval ExternalHandle as PLDAP, byval SortKeys as PLDAPSortKeyA ptr, byval Control as PLDAPControlA, byval Criticality as WINBOOLEAN) as ULONG

#ifdef UNICODE
	declare function ldap_encode_sort_control alias "ldap_encode_sort_controlW"(byval ExternalHandle as PLDAP, byval SortKeys as PLDAPSortKeyW ptr, byval Control as PLDAPControlW, byval Criticality as WINBOOLEAN) as ULONG
#else
	declare function ldap_encode_sort_control(byval ExternalHandle as PLDAP, byval SortKeys as PLDAPSortKeyA ptr, byval Control as PLDAPControlA, byval Criticality as WINBOOLEAN) as ULONG
#endif

declare function ldap_create_page_controlW(byval ExternalHandle as PLDAP, byval PageSize as ULONG, byval Cookie as BERVAL ptr, byval IsCritical as UCHAR, byval Control as PLDAPControlW ptr) as ULONG
declare function ldap_create_page_controlA(byval ExternalHandle as PLDAP, byval PageSize as ULONG, byval Cookie as BERVAL ptr, byval IsCritical as UCHAR, byval Control as PLDAPControlA ptr) as ULONG
declare function ldap_parse_page_controlW(byval ExternalHandle as PLDAP, byval ServerControls as PLDAPControlW ptr, byval TotalCount as ULONG ptr, byval Cookie as BERVAL ptr ptr) as ULONG
declare function ldap_parse_page_controlA(byval ExternalHandle as PLDAP, byval ServerControls as PLDAPControlA ptr, byval TotalCount as ULONG ptr, byval Cookie as BERVAL ptr ptr) as ULONG

#ifdef UNICODE
	declare function ldap_create_page_control alias "ldap_create_page_controlW"(byval ExternalHandle as PLDAP, byval PageSize as ULONG, byval Cookie as BERVAL ptr, byval IsCritical as UCHAR, byval Control as PLDAPControlW ptr) as ULONG
	declare function ldap_parse_page_control alias "ldap_parse_page_controlW"(byval ExternalHandle as PLDAP, byval ServerControls as PLDAPControlW ptr, byval TotalCount as ULONG ptr, byval Cookie as BERVAL ptr ptr) as ULONG
#else
	declare function ldap_create_page_control(byval ExternalHandle as PLDAP, byval PageSize as ULONG, byval Cookie as BERVAL ptr, byval IsCritical as UCHAR, byval Control as PLDAPControlA ptr) as ULONG
	declare function ldap_parse_page_control(byval ExternalHandle as PLDAP, byval ServerControls as PLDAPControlA ptr, byval TotalCount as ULONG ptr, byval Cookie as BERVAL ptr ptr) as ULONG
#endif

#define LDAP_PAGED_RESULT_OID_STRING "1.2.840.113556.1.4.319"
#define LDAP_PAGED_RESULT_OID_STRING_W wstr("1.2.840.113556.1.4.319")
declare function ldap_search_init_pageW(byval ExternalHandle as PLDAP, byval DistinguishedName as const PWCHAR, byval ScopeOfSearch as ULONG, byval SearchFilter as const PWCHAR, byval AttributeList as PWCHAR ptr, byval AttributesOnly as ULONG, byval ServerControls as PLDAPControlW ptr, byval ClientControls as PLDAPControlW ptr, byval PageTimeLimit as ULONG, byval TotalSizeLimit as ULONG, byval SortKeys as PLDAPSortKeyW ptr) as PLDAPSearch
declare function ldap_search_init_pageA(byval ExternalHandle as PLDAP, byval DistinguishedName as const PCHAR, byval ScopeOfSearch as ULONG, byval SearchFilter as const PCHAR, byval AttributeList as PCHAR ptr, byval AttributesOnly as ULONG, byval ServerControls as PLDAPControlA ptr, byval ClientControls as PLDAPControlA ptr, byval PageTimeLimit as ULONG, byval TotalSizeLimit as ULONG, byval SortKeys as PLDAPSortKeyA ptr) as PLDAPSearch

#ifdef UNICODE
	declare function ldap_search_init_page alias "ldap_search_init_pageW"(byval ExternalHandle as PLDAP, byval DistinguishedName as const PWCHAR, byval ScopeOfSearch as ULONG, byval SearchFilter as const PWCHAR, byval AttributeList as PWCHAR ptr, byval AttributesOnly as ULONG, byval ServerControls as PLDAPControlW ptr, byval ClientControls as PLDAPControlW ptr, byval PageTimeLimit as ULONG, byval TotalSizeLimit as ULONG, byval SortKeys as PLDAPSortKeyW ptr) as PLDAPSearch
#else
	declare function ldap_search_init_page(byval ExternalHandle as PLDAP, byval DistinguishedName as const PCHAR, byval ScopeOfSearch as ULONG, byval SearchFilter as const PCHAR, byval AttributeList as PCHAR ptr, byval AttributesOnly as ULONG, byval ServerControls as PLDAPControlA ptr, byval ClientControls as PLDAPControlA ptr, byval PageTimeLimit as ULONG, byval TotalSizeLimit as ULONG, byval SortKeys as PLDAPSortKeyA ptr) as PLDAPSearch
#endif

declare function ldap_get_next_page(byval ExternalHandle as PLDAP, byval SearchHandle as PLDAPSearch, byval PageSize as ULONG, byval MessageNumber as ULONG ptr) as ULONG
declare function ldap_get_next_page_s(byval ExternalHandle as PLDAP, byval SearchHandle as PLDAPSearch, byval timeout as l_timeval ptr, byval PageSize as ULONG, byval TotalCount as ULONG ptr, byval Results as LDAPMessage ptr ptr) as ULONG
declare function ldap_get_paged_count(byval ExternalHandle as PLDAP, byval SearchBlock as PLDAPSearch, byval TotalCount as ULONG ptr, byval Results as PLDAPMessage) as ULONG
declare function ldap_search_abandon_page(byval ExternalHandle as PLDAP, byval SearchBlock as PLDAPSearch) as ULONG

#define LDAP_CONTROL_VLVREQUEST "2.16.840.1.113730.3.4.9"
#define LDAP_CONTROL_VLVREQUEST_W wstr("2.16.840.1.113730.3.4.9")
#define LDAP_CONTROL_VLVRESPONSE "2.16.840.1.113730.3.4.10"
#define LDAP_CONTROL_VLVRESPONSE_W wstr("2.16.840.1.113730.3.4.10")
const LDAP_API_FEATURE_VIRTUAL_LIST_VIEW = 1001
const LDAP_VLVINFO_VERSION = 1

type LDAPVLVInfo
	ldvlv_version as long
	ldvlv_before_count as ULONG
	ldvlv_after_count as ULONG
	ldvlv_offset as ULONG
	ldvlv_count as ULONG
	ldvlv_attrvalue as PBERVAL
	ldvlv_context as PBERVAL
	ldvlv_extradata as any ptr
end type

type PLDAPVLVInfo as LDAPVLVInfo ptr
declare function ldap_create_vlv_controlW(byval ExternalHandle as PLDAP, byval VlvInfo as PLDAPVLVInfo, byval IsCritical as UCHAR, byval Control as PLDAPControlW ptr) as INT_
declare function ldap_create_vlv_controlA(byval ExternalHandle as PLDAP, byval VlvInfo as PLDAPVLVInfo, byval IsCritical as UCHAR, byval Control as PLDAPControlA ptr) as INT_
declare function ldap_parse_vlv_controlW(byval ExternalHandle as PLDAP, byval Control as PLDAPControlW ptr, byval TargetPos as PULONG, byval ListCount as PULONG, byval Context as PBERVAL ptr, byval ErrCode as PINT) as INT_
declare function ldap_parse_vlv_controlA(byval ExternalHandle as PLDAP, byval Control as PLDAPControlA ptr, byval TargetPos as PULONG, byval ListCount as PULONG, byval Context as PBERVAL ptr, byval ErrCode as PINT) as INT_

#ifdef UNICODE
	declare function ldap_create_vlv_control alias "ldap_create_vlv_controlW"(byval ExternalHandle as PLDAP, byval VlvInfo as PLDAPVLVInfo, byval IsCritical as UCHAR, byval Control as PLDAPControlW ptr) as INT_
	declare function ldap_parse_vlv_control alias "ldap_parse_vlv_controlW"(byval ExternalHandle as PLDAP, byval Control as PLDAPControlW ptr, byval TargetPos as PULONG, byval ListCount as PULONG, byval Context as PBERVAL ptr, byval ErrCode as PINT) as INT_
#else
	declare function ldap_create_vlv_control alias "ldap_create_vlv_controlA"(byval ExternalHandle as PLDAP, byval VlvInfo as PLDAPVLVInfo, byval IsCritical as UCHAR, byval Control as PLDAPControlA ptr) as INT_
	declare function ldap_parse_vlv_control alias "ldap_parse_vlv_controlA"(byval ExternalHandle as PLDAP, byval Control as PLDAPControlA ptr, byval TargetPos as PULONG, byval ListCount as PULONG, byval Context as PBERVAL ptr, byval ErrCode as PINT) as INT_
#endif

#define LDAP_START_TLS_OID "1.3.6.1.4.1.1466.20037"
#define LDAP_START_TLS_OID_W wstr("1.3.6.1.4.1.1466.20037")
declare function ldap_start_tls_sW(byval ExternalHandle as PLDAP, byval ServerReturnValue as PULONG, byval result as LDAPMessage ptr ptr, byval ServerControls as PLDAPControlW ptr, byval ClientControls as PLDAPControlW ptr) as ULONG
declare function ldap_start_tls_sA(byval ExternalHandle as PLDAP, byval ServerReturnValue as PULONG, byval result as LDAPMessage ptr ptr, byval ServerControls as PLDAPControlA ptr, byval ClientControls as PLDAPControlA ptr) as ULONG
declare function ldap_stop_tls_s(byval ExternalHandle as PLDAP) as WINBOOLEAN

#ifdef UNICODE
	declare function ldap_start_tls_s alias "ldap_start_tls_sW"(byval ExternalHandle as PLDAP, byval ServerReturnValue as PULONG, byval result as LDAPMessage ptr ptr, byval ServerControls as PLDAPControlW ptr, byval ClientControls as PLDAPControlW ptr) as ULONG
#else
	declare function ldap_start_tls_s alias "ldap_start_tls_sA"(byval ExternalHandle as PLDAP, byval ServerReturnValue as PULONG, byval result as LDAPMessage ptr ptr, byval ServerControls as PLDAPControlA ptr, byval ClientControls as PLDAPControlA ptr) as ULONG
#endif

#define LDAP_TTL_EXTENDED_OP_OID "1.3.6.1.4.1.1466.101.119.1"
#define LDAP_TTL_EXTENDED_OP_OID_W wstr("1.3.6.1.4.1.1466.101.119.1")
declare function ldap_first_reference(byval ld as LDAP ptr, byval res as LDAPMessage ptr) as LDAPMessage ptr
declare function ldap_next_reference(byval ld as LDAP ptr, byval entry as LDAPMessage ptr) as LDAPMessage ptr
declare function ldap_count_references(byval ld as LDAP ptr, byval res as LDAPMessage ptr) as ULONG
declare function ldap_parse_referenceW(byval Connection as LDAP ptr, byval ResultMessage as LDAPMessage ptr, byval Referrals as PWCHAR ptr ptr) as ULONG
declare function ldap_parse_referenceA(byval Connection as LDAP ptr, byval ResultMessage as LDAPMessage ptr, byval Referrals as PCHAR ptr ptr) as ULONG

#ifdef UNICODE
	declare function ldap_parse_reference alias "ldap_parse_referenceW"(byval Connection as LDAP ptr, byval ResultMessage as LDAPMessage ptr, byval Referrals as PWCHAR ptr ptr) as ULONG
#else
	declare function ldap_parse_reference(byval Connection as LDAP ptr, byval ResultMessage as LDAPMessage ptr, byval Referrals as PCHAR ptr ptr) as ULONG
#endif

declare function ldap_extended_operationW(byval ld as LDAP ptr, byval Oid as const PWCHAR, byval Data as BERVAL ptr, byval ServerControls as PLDAPControlW ptr, byval ClientControls as PLDAPControlW ptr, byval MessageNumber as ULONG ptr) as ULONG
declare function ldap_extended_operationA(byval ld as LDAP ptr, byval Oid as const PCHAR, byval Data as BERVAL ptr, byval ServerControls as PLDAPControlA ptr, byval ClientControls as PLDAPControlA ptr, byval MessageNumber as ULONG ptr) as ULONG
declare function ldap_extended_operation_sA(byval ExternalHandle as LDAP ptr, byval Oid as PCHAR, byval Data as BERVAL ptr, byval ServerControls as PLDAPControlA ptr, byval ClientControls as PLDAPControlA ptr, byval ReturnedOid as PCHAR ptr, byval ReturnedData as BERVAL ptr ptr) as ULONG
declare function ldap_extended_operation_sW(byval ExternalHandle as LDAP ptr, byval Oid as PWCHAR, byval Data as BERVAL ptr, byval ServerControls as PLDAPControlW ptr, byval ClientControls as PLDAPControlW ptr, byval ReturnedOid as PWCHAR ptr, byval ReturnedData as BERVAL ptr ptr) as ULONG

#ifdef UNICODE
	declare function ldap_extended_operation alias "ldap_extended_operationW"(byval ld as LDAP ptr, byval Oid as const PWCHAR, byval Data as BERVAL ptr, byval ServerControls as PLDAPControlW ptr, byval ClientControls as PLDAPControlW ptr, byval MessageNumber as ULONG ptr) as ULONG
	declare function ldap_extended_operation_s alias "ldap_extended_operation_sW"(byval ExternalHandle as LDAP ptr, byval Oid as PWCHAR, byval Data as BERVAL ptr, byval ServerControls as PLDAPControlW ptr, byval ClientControls as PLDAPControlW ptr, byval ReturnedOid as PWCHAR ptr, byval ReturnedData as BERVAL ptr ptr) as ULONG
#else
	declare function ldap_extended_operation(byval ld as LDAP ptr, byval Oid as const PCHAR, byval Data as BERVAL ptr, byval ServerControls as PLDAPControlA ptr, byval ClientControls as PLDAPControlA ptr, byval MessageNumber as ULONG ptr) as ULONG
	declare function ldap_extended_operation_s alias "ldap_extended_operation_sA"(byval ExternalHandle as LDAP ptr, byval Oid as PCHAR, byval Data as BERVAL ptr, byval ServerControls as PLDAPControlA ptr, byval ClientControls as PLDAPControlA ptr, byval ReturnedOid as PCHAR ptr, byval ReturnedData as BERVAL ptr ptr) as ULONG
#endif

declare function ldap_close_extended_op(byval ld as LDAP ptr, byval MessageNumber as ULONG) as ULONG
const LDAP_OPT_REFERRAL_CALLBACK = &h70

type LdapReferralCallback
	SizeOfCallbacks as ULONG
	QueryForConnection as function(byval PrimaryConnection as PLDAP, byval ReferralFromConnection as PLDAP, byval NewDN as PWCHAR, byval HostName as PCHAR, byval PortNumber as ULONG, byval SecAuthIdentity as PVOID, byval CurrentUserToken as PVOID, byval ConnectionToUse as PLDAP ptr) as ULONG
	NotifyRoutine as function(byval PrimaryConnection as PLDAP, byval ReferralFromConnection as PLDAP, byval NewDN as PWCHAR, byval HostName as PCHAR, byval NewConnection as PLDAP, byval PortNumber as ULONG, byval SecAuthIdentity as PVOID, byval CurrentUser as PVOID, byval ErrorCodeFromBind as ULONG) as WINBOOLEAN
	DereferenceRoutine as function(byval PrimaryConnection as PLDAP, byval ConnectionToDereference as PLDAP) as ULONG
end type

type LDAP_REFERRAL_CALLBACK as LdapReferralCallback
type PLDAP_REFERRAL_CALLBACK as LdapReferralCallback ptr
declare function LdapGetLastError() as ULONG
declare function LdapMapErrorToWin32(byval LdapError as ULONG) as ULONG
const LDAP_OPT_CLIENT_CERTIFICATE = &h80
const LDAP_OPT_SERVER_CERTIFICATE = &h81
const LDAP_OPT_REF_DEREF_CONN_PER_MSG = &h94
declare function ldap_conn_from_msg(byval PrimaryConn as LDAP ptr, byval res as LDAPMessage ptr) as LDAP ptr

end extern
