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

#define _WINDNS_INCLUDED_
type QWORD as ulongint
type PQWORD as ulongint ptr
type DNS_STATUS as LONG
type PDNS_STATUS as LONG ptr
type IP4_ADDRESS as DWORD
type PIP4_ADDRESS as DWORD ptr

const SIZEOF_IP4_ADDRESS = 4
const IP4_ADDRESS_STRING_LENGTH = 15
const IP4_ADDRESS_STRING_BUFFER_LENGTH = 16

type _IP4_ARRAY
	AddrCount as DWORD
	AddrArray(0 to 0) as IP4_ADDRESS
end type

type IP4_ARRAY as _IP4_ARRAY
type PIP4_ARRAY as _IP4_ARRAY ptr

union IP6_ADDRESS
	#ifdef __FB_64BIT__
		IP6Qword(0 to 1) as QWORD
	#endif

	IP6Dword(0 to 3) as DWORD
	IP6Word(0 to 7) as WORD
	IP6Byte(0 to 15) as UBYTE
end union

type PIP6_ADDRESS as IP6_ADDRESS ptr
#undef IP6_ADDRESS_STRING_LENGTH
const IP6_ADDRESS_STRING_LENGTH = 47
const IP6_ADDRESS_STRING_BUFFER_LENGTH = 48
#macro INLINE_WORD_FLIP(out, in)
	scope
		dim _in as WORD = (in)
		(out) = (_in shl 8) or (_in shr 8)
	end scope
#endmacro
#define INLINE_HTONS(out, in) INLINE_WORD_FLIP(out, in)
#define INLINE_NTOHS(out, in) INLINE_WORD_FLIP(out, in)
#macro INLINE_DWORD_FLIP(out, in)
	scope
		dim _in as DWORD = (in)
		(out) = ((((_in shl 8) and &h00ff0000) or (_in shl 24)) or ((_in shr 8) and &h0000ff00)) or (_in shr 24)
	end scope
#endmacro
#define INLINE_NTOHL(out, in) INLINE_DWORD_FLIP(out, in)
#define INLINE_HTONL(out, in) INLINE_DWORD_FLIP(out, in)
#define INLINE_WRITE_FLIPPED_WORD(pout, in) INLINE_WORD_FLIP(*cptr(WORD ptr, pout), in)
#define INLINE_WRITE_FLIPPED_DWORD(pout, in) INLINE_DWORD_FLIP(*cptr(DWORD ptr, pout), in)
const DNS_PORT_HOST_ORDER = &h0035
const DNS_PORT_NET_ORDER = &h3500
const DNS_RFC_MAX_UDP_PACKET_LENGTH = 512
const DNS_MAX_NAME_LENGTH = 255
const DNS_MAX_LABEL_LENGTH = 63
const DNS_MAX_NAME_BUFFER_LENGTH = 256
const DNS_MAX_LABEL_BUFFER_LENGTH = 64
#define DNS_IP4_REVERSE_DOMAIN_STRING_A "in-addr.arpa."
#define DNS_IP4_REVERSE_DOMAIN_STRING_W wstr("in-addr.arpa.")
#define DNS_MAX_IP4_REVERSE_NAME_LENGTH ((IP4_ADDRESS_STRING_LENGTH + 1) + sizeof(DNS_IP4_REVERSE_DOMAIN_STRING_A))
#define DNS_MAX_IP4_REVERSE_NAME_BUFFER_LENGTH (DNS_MAX_IP4_REVERSE_NAME_LENGTH + 1)
#define DNS_IP6_REVERSE_DOMAIN_STRING_A "ip6.arpa."
#define DNS_IP6_REVERSE_DOMAIN_STRING_W wstr("ip6.arpa.")
#define DNS_MAX_IP6_REVERSE_NAME_LENGTH (64 + sizeof(DNS_IP6_REVERSE_DOMAIN_STRING_A))
#define DNS_MAX_IP6_REVERSE_NAME_BUFFER_LENGTH (DNS_MAX_IP6_REVERSE_NAME_LENGTH + 1)
#define DNS_MAX_REVERSE_NAME_LENGTH DNS_MAX_IP6_REVERSE_NAME_LENGTH
#define DNS_MAX_REVERSE_NAME_BUFFER_LENGTH DNS_MAX_IP6_REVERSE_NAME_BUFFER_LENGTH

#ifdef UNICODE
	#define DNS_IP4_REVERSE_DOMAIN_STRING DNS_IP4_REVERSE_DOMAIN_STRING_W
	#define DNS_IP6_REVERSE_DOMAIN_STRING DNS_IP6_REVERSE_DOMAIN_STRING_W
#else
	#define DNS_IP4_REVERSE_DOMAIN_STRING DNS_IP4_REVERSE_DOMAIN_STRING_A
	#define DNS_IP6_REVERSE_DOMAIN_STRING DNS_IP6_REVERSE_DOMAIN_STRING_A
#endif

const DNS_MAX_TEXT_STRING_LENGTH = 255

type _DNS_HEADER field = 1
	Xid as WORD
	RecursionDesired : 1 as UBYTE
	Truncation : 1 as UBYTE
	Authoritative : 1 as UBYTE
	Opcode : 4 as UBYTE
	IsResponse : 1 as UBYTE
	ResponseCode : 4 as UBYTE
	Reserved : 3 as UBYTE
	RecursionAvailable : 1 as UBYTE
	QuestionCount as WORD
	AnswerCount as WORD
	NameServerCount as WORD
	AdditionalCount as WORD
end type

type DNS_HEADER as _DNS_HEADER
type PDNS_HEADER as _DNS_HEADER ptr
#define DNS_HEADER_FLAGS(pHead) (*(cast(PWORD, (pHead)) + 1))
#macro DNS_BYTE_FLIP_HEADER_COUNTS(pHeader)
	scope
		dim _head as PDNS_HEADER = (pHeader)
		INLINE_HTONS(_head->Xid, _head->Xid)
		INLINE_HTONS(_head->QuestionCount, _head->QuestionCount)
		INLINE_HTONS(_head->AnswerCount, _head->AnswerCount)
		INLINE_HTONS(_head->NameServerCount, _head->NameServerCount)
		INLINE_HTONS(_head->AdditionalCount, _head->AdditionalCount)
	end scope
#endmacro
#define DNS_OFFSET_TO_QUESTION_NAME sizeof(DNS_HEADER)
const DNS_COMPRESSED_QUESTION_NAME = &hC00C
#define DNS_QUESTION_NAME_FROM_HEADER(_pHeader_) cast(PCHAR, cast(PDNS_HEADER, (_pHeader_)) + 1)
#define DNS_ANSWER_FROM_QUESTION(_pQuestion_) cast(PCHAR, cast(PDNS_QUESTION, (_pQuestion_)) + 1)

type _DNS_WIRE_QUESTION field = 1
	QuestionType as WORD
	QuestionClass as WORD
end type

type DNS_WIRE_QUESTION as _DNS_WIRE_QUESTION
type PDNS_WIRE_QUESTION as _DNS_WIRE_QUESTION ptr

type _DNS_WIRE_RECORD field = 1
	RecordType as WORD
	RecordClass as WORD
	TimeToLive as DWORD
	DataLength as WORD
end type

type DNS_WIRE_RECORD as _DNS_WIRE_RECORD
type PDNS_WIRE_RECORD as _DNS_WIRE_RECORD ptr
const DNS_OPCODE_QUERY = 0
const DNS_OPCODE_IQUERY = 1
const DNS_OPCODE_SERVER_STATUS = 2
const DNS_OPCODE_UNKNOWN = 3
const DNS_OPCODE_NOTIFY = 4
const DNS_OPCODE_UPDATE = 5
const DNS_RCODE_NOERROR = 0
const DNS_RCODE_FORMERR = 1
const DNS_RCODE_SERVFAIL = 2
const DNS_RCODE_NXDOMAIN = 3
const DNS_RCODE_NOTIMPL = 4
const DNS_RCODE_REFUSED = 5
const DNS_RCODE_YXDOMAIN = 6
const DNS_RCODE_YXRRSET = 7
const DNS_RCODE_NXRRSET = 8
const DNS_RCODE_NOTAUTH = 9
const DNS_RCODE_NOTZONE = 10
const DNS_RCODE_MAX = 15
const DNS_RCODE_BADVERS = 16
const DNS_RCODE_BADSIG = 16
const DNS_RCODE_BADKEY = 17
const DNS_RCODE_BADTIME = 18
const DNS_RCODE_NO_ERROR = DNS_RCODE_NOERROR
const DNS_RCODE_FORMAT_ERROR = DNS_RCODE_FORMERR
const DNS_RCODE_SERVER_FAILURE = DNS_RCODE_SERVFAIL
const DNS_RCODE_NAME_ERROR = DNS_RCODE_NXDOMAIN
const DNS_RCODE_NOT_IMPLEMENTED = DNS_RCODE_NOTIMPL
const DNS_CLASS_INTERNET = &h0001
const DNS_CLASS_CSNET = &h0002
const DNS_CLASS_CHAOS = &h0003
const DNS_CLASS_HESIOD = &h0004
const DNS_CLASS_NONE = &h00fe
const DNS_CLASS_ALL = &h00ff
const DNS_CLASS_ANY = &h00ff
const DNS_RCLASS_INTERNET = &h0100
const DNS_RCLASS_CSNET = &h0200
const DNS_RCLASS_CHAOS = &h0300
const DNS_RCLASS_HESIOD = &h0400
const DNS_RCLASS_NONE = &hfe00
const DNS_RCLASS_ALL = &hff00
const DNS_RCLASS_ANY = &hff00
const DNS_TYPE_ZERO = &h0000
const DNS_TYPE_A = &h0001
const DNS_TYPE_NS = &h0002
const DNS_TYPE_MD = &h0003
const DNS_TYPE_MF = &h0004
const DNS_TYPE_CNAME = &h0005
const DNS_TYPE_SOA = &h0006
const DNS_TYPE_MB = &h0007
const DNS_TYPE_MG = &h0008
const DNS_TYPE_MR = &h0009
const DNS_TYPE_NULL = &h000a
const DNS_TYPE_WKS = &h000b
const DNS_TYPE_PTR = &h000c
const DNS_TYPE_HINFO = &h000d
const DNS_TYPE_MINFO = &h000e
const DNS_TYPE_MX = &h000f
const DNS_TYPE_TEXT = &h0010
const DNS_TYPE_RP = &h0011
const DNS_TYPE_AFSDB = &h0012
const DNS_TYPE_X25 = &h0013
const DNS_TYPE_ISDN = &h0014
const DNS_TYPE_RT = &h0015
const DNS_TYPE_NSAP = &h0016
const DNS_TYPE_NSAPPTR = &h0017
const DNS_TYPE_SIG = &h0018
const DNS_TYPE_KEY = &h0019
const DNS_TYPE_PX = &h001a
const DNS_TYPE_GPOS = &h001b
const DNS_TYPE_AAAA = &h001c
const DNS_TYPE_LOC = &h001d
const DNS_TYPE_NXT = &h001e
const DNS_TYPE_EID = &h001f
const DNS_TYPE_NIMLOC = &h0020
const DNS_TYPE_SRV = &h0021
const DNS_TYPE_ATMA = &h0022
const DNS_TYPE_NAPTR = &h0023
const DNS_TYPE_KX = &h0024
const DNS_TYPE_CERT = &h0025
const DNS_TYPE_A6 = &h0026
const DNS_TYPE_DNAME = &h0027
const DNS_TYPE_SINK = &h0028
const DNS_TYPE_OPT = &h0029
const DNS_TYPE_UINFO = &h0064
const DNS_TYPE_UID = &h0065
const DNS_TYPE_GID = &h0066
const DNS_TYPE_UNSPEC = &h0067
const DNS_TYPE_ADDRS = &h00f8
const DNS_TYPE_TKEY = &h00f9
const DNS_TYPE_TSIG = &h00fa
const DNS_TYPE_IXFR = &h00fb
const DNS_TYPE_AXFR = &h00fc
const DNS_TYPE_MAILB = &h00fd
const DNS_TYPE_MAILA = &h00fe
const DNS_TYPE_ALL = &h00ff
const DNS_TYPE_ANY = &h00ff
const DNS_TYPE_WINS = &hff01
const DNS_TYPE_WINSR = &hff02
const DNS_TYPE_NBSTAT = DNS_TYPE_WINSR
const DNS_RTYPE_A = &h0100
const DNS_RTYPE_NS = &h0200
const DNS_RTYPE_MD = &h0300
const DNS_RTYPE_MF = &h0400
const DNS_RTYPE_CNAME = &h0500
const DNS_RTYPE_SOA = &h0600
const DNS_RTYPE_MB = &h0700
const DNS_RTYPE_MG = &h0800
const DNS_RTYPE_MR = &h0900
const DNS_RTYPE_NULL = &h0a00
const DNS_RTYPE_WKS = &h0b00
const DNS_RTYPE_PTR = &h0c00
const DNS_RTYPE_HINFO = &h0d00
const DNS_RTYPE_MINFO = &h0e00
const DNS_RTYPE_MX = &h0f00
const DNS_RTYPE_TEXT = &h1000
const DNS_RTYPE_RP = &h1100
const DNS_RTYPE_AFSDB = &h1200
const DNS_RTYPE_X25 = &h1300
const DNS_RTYPE_ISDN = &h1400
const DNS_RTYPE_RT = &h1500
const DNS_RTYPE_NSAP = &h1600
const DNS_RTYPE_NSAPPTR = &h1700
const DNS_RTYPE_SIG = &h1800
const DNS_RTYPE_KEY = &h1900
const DNS_RTYPE_PX = &h1a00
const DNS_RTYPE_GPOS = &h1b00
const DNS_RTYPE_AAAA = &h1c00
const DNS_RTYPE_LOC = &h1d00
const DNS_RTYPE_NXT = &h1e00
const DNS_RTYPE_EID = &h1f00
const DNS_RTYPE_NIMLOC = &h2000
const DNS_RTYPE_SRV = &h2100
const DNS_RTYPE_ATMA = &h2200
const DNS_RTYPE_NAPTR = &h2300
const DNS_RTYPE_KX = &h2400
const DNS_RTYPE_CERT = &h2500
const DNS_RTYPE_A6 = &h2600
const DNS_RTYPE_DNAME = &h2700
const DNS_RTYPE_SINK = &h2800
const DNS_RTYPE_OPT = &h2900
const DNS_RTYPE_UINFO = &h6400
const DNS_RTYPE_UID = &h6500
const DNS_RTYPE_GID = &h6600
const DNS_RTYPE_UNSPEC = &h6700
const DNS_RTYPE_TKEY = &hf900
const DNS_RTYPE_TSIG = &hfa00
const DNS_RTYPE_IXFR = &hfb00
const DNS_RTYPE_AXFR = &hfc00
const DNS_RTYPE_MAILB = &hfd00
const DNS_RTYPE_MAILA = &hfe00
const DNS_RTYPE_ALL = &hff00
const DNS_RTYPE_ANY = &hff00
const DNS_RTYPE_WINS = &h01ff
const DNS_RTYPE_WINSR = &h02ff
const DNS_ATMA_FORMAT_E164 = 1
const DNS_ATMA_FORMAT_AESA = 2
const DNS_ATMA_MAX_ADDR_LENGTH = 20
const DNS_ATMA_AESA_ADDR_LENGTH = 20
const DNS_ATMA_MAX_RECORD_LENGTH = DNS_ATMA_MAX_ADDR_LENGTH + 1
const DNSSEC_ALGORITHM_RSAMD5 = 1
const DNSSEC_ALGORITHM_NULL = 253
const DNSSEC_ALGORITHM_PRIVATE = 254
const DNSSEC_PROTOCOL_NONE = 0
const DNSSEC_PROTOCOL_TLS = 1
const DNSSEC_PROTOCOL_EMAIL = 2
const DNSSEC_PROTOCOL_DNSSEC = 3
const DNSSEC_PROTOCOL_IPSEC = 4
const DNSSEC_KEY_FLAG_NOAUTH = &h0001
const DNSSEC_KEY_FLAG_NOCONF = &h0002
const DNSSEC_KEY_FLAG_FLAG2 = &h0004
const DNSSEC_KEY_FLAG_EXTEND = &h0008
#define DNSSEC_KEY_FLAG_
const DNSSEC_KEY_FLAG_FLAG4 = &h0010
const DNSSEC_KEY_FLAG_FLAG5 = &h0020
const DNSSEC_KEY_FLAG_USER = &h0000
const DNSSEC_KEY_FLAG_ZONE = &h0040
const DNSSEC_KEY_FLAG_HOST = &h0080
const DNSSEC_KEY_FLAG_NTPE3 = &h00c0
const DNSSEC_KEY_FLAG_FLAG8 = &h0100
const DNSSEC_KEY_FLAG_FLAG9 = &h0200
const DNSSEC_KEY_FLAG_FLAG10 = &h0400
const DNSSEC_KEY_FLAG_FLAG11 = &h0800
const DNSSEC_KEY_FLAG_SIG0 = &h0000
const DNSSEC_KEY_FLAG_SIG1 = &h1000
const DNSSEC_KEY_FLAG_SIG2 = &h2000
const DNSSEC_KEY_FLAG_SIG3 = &h3000
const DNSSEC_KEY_FLAG_SIG4 = &h4000
const DNSSEC_KEY_FLAG_SIG5 = &h5000
const DNSSEC_KEY_FLAG_SIG6 = &h6000
const DNSSEC_KEY_FLAG_SIG7 = &h7000
const DNSSEC_KEY_FLAG_SIG8 = &h8000
const DNSSEC_KEY_FLAG_SIG9 = &h9000
const DNSSEC_KEY_FLAG_SIG10 = &ha000
const DNSSEC_KEY_FLAG_SIG11 = &hb000
const DNSSEC_KEY_FLAG_SIG12 = &hc000
const DNSSEC_KEY_FLAG_SIG13 = &hd000
const DNSSEC_KEY_FLAG_SIG14 = &he000
const DNSSEC_KEY_FLAG_SIG15 = &hf000
const DNS_TKEY_MODE_SERVER_ASSIGN = 1
const DNS_TKEY_MODE_DIFFIE_HELLMAN = 2
const DNS_TKEY_MODE_GSS = 3
const DNS_TKEY_MODE_RESOLVER_ASSIGN = 4
const DNS_WINS_FLAG_SCOPE = &h80000000
const DNS_WINS_FLAG_LOCAL = &h00010000
#define IS_WORD_ALIGNED(p) ((cast(UINT_PTR, (p)) and cast(UINT_PTR, 1)) = 0)
#define IS_DWORD_ALIGNED(p) ((cast(UINT_PTR, (p)) and cast(UINT_PTR, 3)) = 0)
#define IS_QWORD_ALIGNED(p) ((cast(UINT_PTR, (p)) and cast(UINT_PTR, 7)) = 0)

type DNS_CONFIG_TYPE as long
enum
	DnsConfigPrimaryDomainName_W
	DnsConfigPrimaryDomainName_A
	DnsConfigPrimaryDomainName_UTF8
	DnsConfigAdapterDomainName_W
	DnsConfigAdapterDomainName_A
	DnsConfigAdapterDomainName_UTF8
	DnsConfigDnsServerList
	DnsConfigSearchList
	DnsConfigAdapterInfo
	DnsConfigPrimaryHostNameRegistrationEnabled
	DnsConfigAdapterHostNameRegistrationEnabled
	DnsConfigAddressRegistrationMaxCount
	DnsConfigHostName_W
	DnsConfigHostName_A
	DnsConfigHostName_UTF8
	DnsConfigFullHostName_W
	DnsConfigFullHostName_A
	DnsConfigFullHostName_UTF8
end enum

const DNS_CONFIG_FLAG_ALLOC = &h00000001
declare function DnsQueryConfig(byval Config as DNS_CONFIG_TYPE, byval Flag as DWORD, byval pwsAdapterName as PWSTR, byval pReserved as PVOID, byval pBuffer as PVOID, byval pBufferLength as PDWORD) as DNS_STATUS

type DNS_A_DATA
	IpAddress as IP4_ADDRESS
end type

type PDNS_A_DATA as DNS_A_DATA ptr

type DNS_PTR_DATAW
	pNameHost as PWSTR
end type

type PDNS_PTR_DATAW as DNS_PTR_DATAW ptr

type DNS_PTR_DATAA
	pNameHost as PSTR
end type

type PDNS_PTR_DATAA as DNS_PTR_DATAA ptr

type DNS_SOA_DATAW
	pNamePrimaryServer as PWSTR
	pNameAdministrator as PWSTR
	dwSerialNo as DWORD
	dwRefresh as DWORD
	dwRetry as DWORD
	dwExpire as DWORD
	dwDefaultTtl as DWORD
end type

type PDNS_SOA_DATAW as DNS_SOA_DATAW ptr

type DNS_SOA_DATAA
	pNamePrimaryServer as PSTR
	pNameAdministrator as PSTR
	dwSerialNo as DWORD
	dwRefresh as DWORD
	dwRetry as DWORD
	dwExpire as DWORD
	dwDefaultTtl as DWORD
end type

type PDNS_SOA_DATAA as DNS_SOA_DATAA ptr

type DNS_MINFO_DATAW
	pNameMailbox as PWSTR
	pNameErrorsMailbox as PWSTR
end type

type PDNS_MINFO_DATAW as DNS_MINFO_DATAW ptr

type DNS_MINFO_DATAA
	pNameMailbox as PSTR
	pNameErrorsMailbox as PSTR
end type

type PDNS_MINFO_DATAA as DNS_MINFO_DATAA ptr

type DNS_MX_DATAW
	pNameExchange as PWSTR
	wPreference as WORD
	Pad as WORD
end type

type PDNS_MX_DATAW as DNS_MX_DATAW ptr

type DNS_MX_DATAA
	pNameExchange as PSTR
	wPreference as WORD
	Pad as WORD
end type

type PDNS_MX_DATAA as DNS_MX_DATAA ptr

type DNS_TXT_DATAW
	dwStringCount as DWORD
	pStringArray(0 to 0) as PWSTR
end type

type PDNS_TXT_DATAW as DNS_TXT_DATAW ptr

type DNS_TXT_DATAA
	dwStringCount as DWORD
	pStringArray(0 to 0) as PSTR
end type

type PDNS_TXT_DATAA as DNS_TXT_DATAA ptr

type DNS_NULL_DATA
	dwByteCount as DWORD
	Data(0 to 0) as UBYTE
end type

type PDNS_NULL_DATA as DNS_NULL_DATA ptr

type DNS_WKS_DATA
	IpAddress as IP4_ADDRESS
	chProtocol as UCHAR
	BitMask(0 to 0) as UBYTE
end type

type PDNS_WKS_DATA as DNS_WKS_DATA ptr

type DNS_AAAA_DATA
	Ip6Address as IP6_ADDRESS
end type

type PDNS_AAAA_DATA as DNS_AAAA_DATA ptr

type DNS_SIG_DATAW
	pNameSigner as PWSTR
	wTypeCovered as WORD
	chAlgorithm as UBYTE
	chLabelCount as UBYTE
	dwOriginalTtl as DWORD
	dwExpiration as DWORD
	dwTimeSigned as DWORD
	wKeyTag as WORD
	Pad as WORD
	Signature(0 to 0) as UBYTE
end type

type PDNS_SIG_DATAW as DNS_SIG_DATAW ptr

type DNS_SIG_DATAA
	pNameSigner as PSTR
	wTypeCovered as WORD
	chAlgorithm as UBYTE
	chLabelCount as UBYTE
	dwOriginalTtl as DWORD
	dwExpiration as DWORD
	dwTimeSigned as DWORD
	wKeyTag as WORD
	Pad as WORD
	Signature(0 to 0) as UBYTE
end type

type PDNS_SIG_DATAA as DNS_SIG_DATAA ptr

type DNS_KEY_DATA
	wFlags as WORD
	chProtocol as UBYTE
	chAlgorithm as UBYTE
	Key(0 to 0) as UBYTE
end type

type PDNS_KEY_DATA as DNS_KEY_DATA ptr

type DNS_LOC_DATA
	wVersion as WORD
	wSize as WORD
	wHorPrec as WORD
	wVerPrec as WORD
	dwLatitude as DWORD
	dwLongitude as DWORD
	dwAltitude as DWORD
end type

type PDNS_LOC_DATA as DNS_LOC_DATA ptr

type DNS_NXT_DATAW
	pNameNext as PWSTR
	wNumTypes as WORD
	wTypes(0 to 0) as WORD
end type

type PDNS_NXT_DATAW as DNS_NXT_DATAW ptr

type DNS_NXT_DATAA
	pNameNext as PSTR
	wNumTypes as WORD
	wTypes(0 to 0) as WORD
end type

type PDNS_NXT_DATAA as DNS_NXT_DATAA ptr

type DNS_SRV_DATAW
	pNameTarget as PWSTR
	wPriority as WORD
	wWeight as WORD
	wPort as WORD
	Pad as WORD
end type

type PDNS_SRV_DATAW as DNS_SRV_DATAW ptr

type DNS_SRV_DATAA
	pNameTarget as PSTR
	wPriority as WORD
	wWeight as WORD
	wPort as WORD
	Pad as WORD
end type

type PDNS_SRV_DATAA as DNS_SRV_DATAA ptr

type DNS_ATMA_DATA
	AddressType as UBYTE
	Address(0 to 19) as UBYTE
end type

type PDNS_ATMA_DATA as DNS_ATMA_DATA ptr

type DNS_TKEY_DATAW
	pNameAlgorithm as PWSTR
	pAlgorithmPacket as PBYTE
	pKey as PBYTE
	pOtherData as PBYTE
	dwCreateTime as DWORD
	dwExpireTime as DWORD
	wMode as WORD
	wError as WORD
	wKeyLength as WORD
	wOtherLength as WORD
	cAlgNameLength as UCHAR
	bPacketPointers as WINBOOL
end type

type PDNS_TKEY_DATAW as DNS_TKEY_DATAW ptr

type DNS_TKEY_DATAA
	pNameAlgorithm as PSTR
	pAlgorithmPacket as PBYTE
	pKey as PBYTE
	pOtherData as PBYTE
	dwCreateTime as DWORD
	dwExpireTime as DWORD
	wMode as WORD
	wError as WORD
	wKeyLength as WORD
	wOtherLength as WORD
	cAlgNameLength as UCHAR
	bPacketPointers as WINBOOL
end type

type PDNS_TKEY_DATAA as DNS_TKEY_DATAA ptr

type DNS_TSIG_DATAW
	pNameAlgorithm as PWSTR
	pAlgorithmPacket as PBYTE
	pSignature as PBYTE
	pOtherData as PBYTE
	i64CreateTime as LONGLONG
	wFudgeTime as WORD
	wOriginalXid as WORD
	wError as WORD
	wSigLength as WORD
	wOtherLength as WORD
	cAlgNameLength as UCHAR
	bPacketPointers as WINBOOL
end type

type PDNS_TSIG_DATAW as DNS_TSIG_DATAW ptr

type DNS_TSIG_DATAA
	pNameAlgorithm as PSTR
	pAlgorithmPacket as PBYTE
	pSignature as PBYTE
	pOtherData as PBYTE
	i64CreateTime as LONGLONG
	wFudgeTime as WORD
	wOriginalXid as WORD
	wError as WORD
	wSigLength as WORD
	wOtherLength as WORD
	cAlgNameLength as UCHAR
	bPacketPointers as WINBOOL
end type

type PDNS_TSIG_DATAA as DNS_TSIG_DATAA ptr

type DNS_WINS_DATA
	dwMappingFlag as DWORD
	dwLookupTimeout as DWORD
	dwCacheTimeout as DWORD
	cWinsServerCount as DWORD
	WinsServers(0 to 0) as IP4_ADDRESS
end type

type PDNS_WINS_DATA as DNS_WINS_DATA ptr

type DNS_WINSR_DATAW
	dwMappingFlag as DWORD
	dwLookupTimeout as DWORD
	dwCacheTimeout as DWORD
	pNameResultDomain as PWSTR
end type

type PDNS_WINSR_DATAW as DNS_WINSR_DATAW ptr

type DNS_WINSR_DATAA
	dwMappingFlag as DWORD
	dwLookupTimeout as DWORD
	dwCacheTimeout as DWORD
	pNameResultDomain as PSTR
end type

type PDNS_WINSR_DATAA as DNS_WINSR_DATAA ptr

#ifdef UNICODE
	type DNS_PTR_DATA as DNS_PTR_DATAW
	type PDNS_PTR_DATA as PDNS_PTR_DATAW
	type DNS_SOA_DATA as DNS_SOA_DATAW
	type PDNS_SOA_DATA as PDNS_SOA_DATAW
	type DNS_MINFO_DATA as DNS_MINFO_DATAW
	type PDNS_MINFO_DATA as PDNS_MINFO_DATAW
	type DNS_MX_DATA as DNS_MX_DATAW
	type PDNS_MX_DATA as PDNS_MX_DATAW
	type DNS_TXT_DATA as DNS_TXT_DATAW
	type PDNS_TXT_DATA as PDNS_TXT_DATAW
	type DNS_SIG_DATA as DNS_SIG_DATAW
	type PDNS_SIG_DATA as PDNS_SIG_DATAW
	type DNS_NXT_DATA as DNS_NXT_DATAW
	type PDNS_NXT_DATA as PDNS_NXT_DATAW
	type DNS_SRV_DATA as DNS_SRV_DATAW
	type PDNS_SRV_DATA as PDNS_SRV_DATAW
	type DNS_TKEY_DATA as DNS_TKEY_DATAW
	type PDNS_TKEY_DATA as PDNS_TKEY_DATAW
	type DNS_TSIG_DATA as DNS_TSIG_DATAW
	type PDNS_TSIG_DATA as PDNS_TSIG_DATAW
	type DNS_WINSR_DATA as DNS_WINSR_DATAW
	type PDNS_WINSR_DATA as PDNS_WINSR_DATAW
#else
	type DNS_PTR_DATA as DNS_PTR_DATAA
	type PDNS_PTR_DATA as PDNS_PTR_DATAA
	type DNS_SOA_DATA as DNS_SOA_DATAA
	type PDNS_SOA_DATA as PDNS_SOA_DATAA
	type DNS_MINFO_DATA as DNS_MINFO_DATAA
	type PDNS_MINFO_DATA as PDNS_MINFO_DATAA
	type DNS_MX_DATA as DNS_MX_DATAA
	type PDNS_MX_DATA as PDNS_MX_DATAA
	type DNS_TXT_DATA as DNS_TXT_DATAA
	type PDNS_TXT_DATA as PDNS_TXT_DATAA
	type DNS_SIG_DATA as DNS_SIG_DATAA
	type PDNS_SIG_DATA as PDNS_SIG_DATAA
	type DNS_NXT_DATA as DNS_NXT_DATAA
	type PDNS_NXT_DATA as PDNS_NXT_DATAA
	type DNS_SRV_DATA as DNS_SRV_DATAA
	type PDNS_SRV_DATA as PDNS_SRV_DATAA
	type DNS_TKEY_DATA as DNS_TKEY_DATAA
	type PDNS_TKEY_DATA as PDNS_TKEY_DATAA
	type DNS_TSIG_DATA as DNS_TSIG_DATAA
	type PDNS_TSIG_DATA as PDNS_TSIG_DATAA
	type DNS_WINSR_DATA as DNS_WINSR_DATAA
	type PDNS_WINSR_DATA as PDNS_WINSR_DATAA
#endif

#define DNS_TEXT_RECORD_LENGTH(StringCount) (FIELD_OFFSET(DNS_TXT_DATA, pStringArray) + ((StringCount) * sizeof(PCHAR)))
#define DNS_NULL_RECORD_LENGTH(ByteCount) (FIELD_OFFSET(DNS_NULL_DATA, Data) + (ByteCount))
#define DNS_WKS_RECORD_LENGTH(ByteCount) (FIELD_OFFSET(DNS_WKS_DATA, BitMask) + (ByteCount))
#define DNS_WINS_RECORD_LENGTH(IpCount) (FIELD_OFFSET(DNS_WINS_DATA, WinsServers) + ((IpCount) * sizeof(IP4_ADDRESS)))

type _DnsRecordFlags
	Section : 2 as DWORD
	Delete_ : 1 as DWORD
	CharSet : 2 as DWORD
	Unused : 3 as DWORD
	Reserved : 24 as DWORD
end type

type DNS_RECORD_FLAGS as _DnsRecordFlags

type _DnsSection as long
enum
	DnsSectionQuestion
	DnsSectionAnswer
	DnsSectionAuthority
	DnsSectionAddtional
end enum

type DNS_SECTION as _DnsSection
const DnsSectionZone = DnsSectionQuestion
const DnsSectionPrereq = DnsSectionAnswer
const DnsSectionUpdate = DnsSectionAuthority
const DNSREC_SECTION = &h00000003
const DNSREC_QUESTION = &h00000000
const DNSREC_ANSWER = &h00000001
const DNSREC_AUTHORITY = &h00000002
const DNSREC_ADDITIONAL = &h00000003
const DNSREC_ZONE = &h00000000
const DNSREC_PREREQ = &h00000001
const DNSREC_UPDATE = &h00000002
const DNSREC_DELETE = &h00000004
const DNSREC_NOEXIST = &h00000004

union _DnsRecordW_Flags
	DW as DWORD
	S as DNS_RECORD_FLAGS
end union

union _DnsRecordW_Data
	A as DNS_A_DATA
	SOA as DNS_SOA_DATAW
	PTR as DNS_PTR_DATAW
	NS as DNS_PTR_DATAW
	CNAME as DNS_PTR_DATAW
	MB as DNS_PTR_DATAW
	MD as DNS_PTR_DATAW
	MF as DNS_PTR_DATAW
	MG as DNS_PTR_DATAW
	MR as DNS_PTR_DATAW
	MINFO as DNS_MINFO_DATAW
	RP as DNS_MINFO_DATAW
	MX as DNS_MX_DATAW
	AFSDB as DNS_MX_DATAW
	RT as DNS_MX_DATAW
	HINFO as DNS_TXT_DATAW
	ISDN as DNS_TXT_DATAW
	TXT as DNS_TXT_DATAW
	X25 as DNS_TXT_DATAW
	Null_ as DNS_NULL_DATA
	WKS as DNS_WKS_DATA
	AAAA as DNS_AAAA_DATA
	KEY as DNS_KEY_DATA
	SIG as DNS_SIG_DATAW
	ATMA as DNS_ATMA_DATA
	NXT as DNS_NXT_DATAW
	SRV as DNS_SRV_DATAW
	TKEY as DNS_TKEY_DATAW
	TSIG as DNS_TSIG_DATAW
	WINS as DNS_WINS_DATA
	WINSR as DNS_WINSR_DATAW
	NBSTAT as DNS_WINSR_DATAW
end union

type _DnsRecordW
	pNext as _DnsRecordW ptr
	pName as PWSTR
	wType as WORD
	wDataLength as WORD
	Flags as _DnsRecordW_Flags
	dwTtl as DWORD
	dwReserved as DWORD
	Data as _DnsRecordW_Data
end type

type DNS_RECORDW as _DnsRecordW
type PDNS_RECORDW as _DnsRecordW ptr

union _DnsRecordA_Flags
	DW as DWORD
	S as DNS_RECORD_FLAGS
end union

union _DnsRecordA_Data
	A as DNS_A_DATA
	SOA as DNS_SOA_DATAA
	PTR as DNS_PTR_DATAA
	NS as DNS_PTR_DATAA
	CNAME as DNS_PTR_DATAA
	MB as DNS_PTR_DATAA
	MD as DNS_PTR_DATAA
	MF as DNS_PTR_DATAA
	MG as DNS_PTR_DATAA
	MR as DNS_PTR_DATAA
	MINFO as DNS_MINFO_DATAA
	RP as DNS_MINFO_DATAA
	MX as DNS_MX_DATAA
	AFSDB as DNS_MX_DATAA
	RT as DNS_MX_DATAA
	HINFO as DNS_TXT_DATAA
	ISDN as DNS_TXT_DATAA
	TXT as DNS_TXT_DATAA
	X25 as DNS_TXT_DATAA
	Null_ as DNS_NULL_DATA
	WKS as DNS_WKS_DATA
	AAAA as DNS_AAAA_DATA
	KEY as DNS_KEY_DATA
	SIG as DNS_SIG_DATAA
	ATMA as DNS_ATMA_DATA
	NXT as DNS_NXT_DATAA
	SRV as DNS_SRV_DATAA
	TKEY as DNS_TKEY_DATAA
	TSIG as DNS_TSIG_DATAA
	WINS as DNS_WINS_DATA
	WINSR as DNS_WINSR_DATAA
	NBSTAT as DNS_WINSR_DATAA
end union

type _DnsRecordA
	pNext as _DnsRecordA ptr
	pName as PSTR
	wType as WORD
	wDataLength as WORD
	Flags as _DnsRecordA_Flags
	dwTtl as DWORD
	dwReserved as DWORD
	Data as _DnsRecordA_Data
end type

type DNS_RECORDA as _DnsRecordA
type PDNS_RECORDA as _DnsRecordA ptr

#ifdef UNICODE
	type DNS_RECORD as DNS_RECORDW
	type PDNS_RECORD as DNS_RECORDW ptr
#else
	type DNS_RECORD as DNS_RECORDA
	type PDNS_RECORD as DNS_RECORDA ptr
#endif

#define DNS_RECORD_FIXED_SIZE FIELD_OFFSET(DNS_RECORD, Data)
#define SIZEOF_DNS_RECORD_HEADER DNS_RECORD_FIXED_SIZE

type _DnsRRSet
	pFirstRR as PDNS_RECORD
	pLastRR as PDNS_RECORD
end type

type DNS_RRSET as _DnsRRSet
type PDNS_RRSET as _DnsRRSet ptr
#macro DNS_RRSET_INIT(rrset)
	scope
		dim _prrset as PDNS_RRSET = @(rrset)
		_prrset->pFirstRR = NULL
		_prrset->pLastRR = cast(PDNS_RECORD, @_prrset->pFirstRR)
	end scope
#endmacro
#macro DNS_RRSET_ADD(rrset, pnewRR)
	scope
		dim _prrset as PDNS_RRSET = @(rrset)
		dim _prrnew as PDNS_RECORD = (pnewRR)
		_prrset->pLastRR->pNext = _prrnew
		_prrset->pLastRR = _prrnew
	end scope
#endmacro
#macro DNS_RRSET_TERMINATE(rrset)
	scope
		dim _prrset as PDNS_RRSET = @(rrset)
		_prrset->pLastRR->pNext = NULL
	end scope
#endmacro

type _DNS_CHARSET as long
enum
	DnsCharSetUnknown
	DnsCharSetUnicode
	DnsCharSetUtf8
	DnsCharSetAnsi
end enum

type DNS_CHARSET as _DNS_CHARSET
declare function DnsRecordCopyEx(byval pRecord as PDNS_RECORD, byval CharSetIn as DNS_CHARSET, byval CharSetOut as DNS_CHARSET) as PDNS_RECORD
declare function DnsRecordSetCopyEx(byval pRecordSet as PDNS_RECORD, byval CharSetIn as DNS_CHARSET, byval CharSetOut as DNS_CHARSET) as PDNS_RECORD

#ifdef UNICODE
	#define DnsRecordCopy(pRR) DnsRecordCopyEx((pRR), DnsCharSetUnicode, DnsCharSetUnicode)
	#define DnsRecordSetCopy(pRR) DnsRecordSetCopyEx((pRR), DnsCharSetUnicode, DnsCharSetUnicode)
#else
	#define DnsRecordCopy(pRR) DnsRecordCopyEx((pRR), DnsCharSetAnsi, DnsCharSetAnsi)
	#define DnsRecordSetCopy(pRR) DnsRecordSetCopyEx((pRR), DnsCharSetAnsi, DnsCharSetAnsi)
#endif

declare function DnsRecordCompare(byval pRecord1 as PDNS_RECORD, byval pRecord2 as PDNS_RECORD) as WINBOOL
declare function DnsRecordSetCompare(byval pRR1 as PDNS_RECORD, byval pRR2 as PDNS_RECORD, byval ppDiff1 as PDNS_RECORD ptr, byval ppDiff2 as PDNS_RECORD ptr) as WINBOOL
declare function DnsRecordSetDetach cdecl(byval pRecordList as PDNS_RECORD) as PDNS_RECORD

type DNS_FREE_TYPE as long
enum
	DnsFreeFlat = 0
	DnsFreeRecordList
	DnsFreeParsedMessageFields
end enum

declare sub DnsFree(byval pData as PVOID, byval FreeType as DNS_FREE_TYPE)
const DnsFreeRecordListDeep = DnsFreeRecordList
declare sub DnsRecordListFree(byval pRecordList as PDNS_RECORD, byval FreeType as DNS_FREE_TYPE)
const DNS_QUERY_STANDARD = &h00000000
const DNS_QUERY_ACCEPT_TRUNCATED_RESPONSE = &h00000001
const DNS_QUERY_USE_TCP_ONLY = &h00000002
const DNS_QUERY_NO_RECURSION = &h00000004
const DNS_QUERY_BYPASS_CACHE = &h00000008
const DNS_QUERY_NO_WIRE_QUERY = &h00000010
const DNS_QUERY_NO_LOCAL_NAME = &h00000020
const DNS_QUERY_NO_HOSTS_FILE = &h00000040
const DNS_QUERY_NO_NETBT = &h00000080
const DNS_QUERY_WIRE_ONLY = &h00000100
const DNS_QUERY_RETURN_MESSAGE = &h00000200
const DNS_QUERY_MULTICAST_ONLY = &h00000400
const DNS_QUERY_NO_MULTICAST = &h00000800
const DNS_QUERY_TREAT_AS_FQDN = &h00001000
const DNS_QUERY_APPEND_MULTILABEL = &h00800000
const DNS_QUERY_DONT_RESET_TTL_VALUES = &h00100000
const DNS_QUERY_RESERVED = &hff000000
const DNS_QUERY_CACHE_ONLY = DNS_QUERY_NO_WIRE_QUERY

declare function DnsQuery_A(byval pszName as PCSTR, byval wType as WORD, byval Options as DWORD, byval aipServers as PIP4_ARRAY, byval ppQueryResults as PDNS_RECORD ptr, byval pReserved as PVOID ptr) as DNS_STATUS
declare function DnsQuery_UTF8(byval pszName as PCSTR, byval wType as WORD, byval Options as DWORD, byval aipServers as PIP4_ARRAY, byval ppQueryResults as PDNS_RECORD ptr, byval pReserved as PVOID ptr) as DNS_STATUS
declare function DnsQuery_W(byval pszName as PCWSTR, byval wType as WORD, byval Options as DWORD, byval aipServers as PIP4_ARRAY, byval ppQueryResults as PDNS_RECORD ptr, byval pReserved as PVOID ptr) as DNS_STATUS

#ifdef UNICODE
	declare function DnsQuery alias "DnsQuery_W"(byval pszName as PCWSTR, byval wType as WORD, byval Options as DWORD, byval aipServers as PIP4_ARRAY, byval ppQueryResults as PDNS_RECORD ptr, byval pReserved as PVOID ptr) as DNS_STATUS
#else
	declare function DnsQuery alias "DnsQuery_A"(byval pszName as PCSTR, byval wType as WORD, byval Options as DWORD, byval aipServers as PIP4_ARRAY, byval ppQueryResults as PDNS_RECORD ptr, byval pReserved as PVOID ptr) as DNS_STATUS
#endif

const DNS_UPDATE_SECURITY_USE_DEFAULT = &h00000000
const DNS_UPDATE_SECURITY_OFF = &h00000010
const DNS_UPDATE_SECURITY_ON = &h00000020
const DNS_UPDATE_SECURITY_ONLY = &h00000100
const DNS_UPDATE_CACHE_SECURITY_CONTEXT = &h00000200
const DNS_UPDATE_TEST_USE_LOCAL_SYS_ACCT = &h00000400
const DNS_UPDATE_FORCE_SECURITY_NEGO = &h00000800
const DNS_UPDATE_TRY_ALL_MASTER_SERVERS = &h00001000
const DNS_UPDATE_SKIP_NO_UPDATE_ADAPTERS = &h00002000
const DNS_UPDATE_REMOTE_SERVER = &h00004000
const DNS_UPDATE_RESERVED = &hffff0000

#ifdef UNICODE
	#define DnsValidateName(p, f) DnsValidateName_W((p), (f))
	#define DnsNameCompare(n1, n2) DnsNameCompare_W((n1), (n2))
#else
	#define DnsValidateName(p, f) DnsValidateName_A((p), (f))
	#define DnsNameCompare(n1, n2) DnsNameCompare_A((n1), (n2))
#endif

declare function DnsAcquireContextHandle_W(byval CredentialFlags as DWORD, byval pCredentials as PVOID, byval pContextHandle as PHANDLE) as DNS_STATUS

#ifdef UNICODE
	declare function DnsAcquireContextHandle alias "DnsAcquireContextHandle_W"(byval CredentialFlags as DWORD, byval pCredentials as PVOID, byval pContextHandle as PHANDLE) as DNS_STATUS
#endif

declare function DnsAcquireContextHandle_A(byval CredentialFlags as DWORD, byval pCredentials as PVOID, byval pContextHandle as PHANDLE) as DNS_STATUS

#ifndef UNICODE
	declare function DnsAcquireContextHandle alias "DnsAcquireContextHandle_A"(byval CredentialFlags as DWORD, byval pCredentials as PVOID, byval pContextHandle as PHANDLE) as DNS_STATUS
#endif

declare sub DnsReleaseContextHandle(byval hContext as HANDLE)
declare function DnsModifyRecordsInSet_W(byval pAddRecords as PDNS_RECORD, byval pDeleteRecords as PDNS_RECORD, byval Options as DWORD, byval hContext as HANDLE, byval pServerList as PIP4_ARRAY, byval pReserved as PVOID) as DNS_STATUS

#ifdef UNICODE
	declare function DnsModifyRecordsInSet alias "DnsModifyRecordsInSet_W"(byval pAddRecords as PDNS_RECORD, byval pDeleteRecords as PDNS_RECORD, byval Options as DWORD, byval hContext as HANDLE, byval pServerList as PIP4_ARRAY, byval pReserved as PVOID) as DNS_STATUS
#endif

declare function DnsModifyRecordsInSet_A(byval pAddRecords as PDNS_RECORD, byval pDeleteRecords as PDNS_RECORD, byval Options as DWORD, byval hContext as HANDLE, byval pServerList as PIP4_ARRAY, byval pReserved as PVOID) as DNS_STATUS

#ifndef UNICODE
	declare function DnsModifyRecordsInSet alias "DnsModifyRecordsInSet_A"(byval pAddRecords as PDNS_RECORD, byval pDeleteRecords as PDNS_RECORD, byval Options as DWORD, byval hContext as HANDLE, byval pServerList as PIP4_ARRAY, byval pReserved as PVOID) as DNS_STATUS
#endif

declare function DnsModifyRecordsInSet_UTF8(byval pAddRecords as PDNS_RECORD, byval pDeleteRecords as PDNS_RECORD, byval Options as DWORD, byval hContext as HANDLE, byval pServerList as PIP4_ARRAY, byval pReserved as PVOID) as DNS_STATUS
declare function DnsReplaceRecordSetW(byval pNewSet as PDNS_RECORD, byval Options as DWORD, byval hContext as HANDLE, byval pServerList as PIP4_ARRAY, byval pReserved as PVOID) as DNS_STATUS

#ifdef UNICODE
	declare function DnsReplaceRecordSet alias "DnsReplaceRecordSetW"(byval pNewSet as PDNS_RECORD, byval Options as DWORD, byval hContext as HANDLE, byval pServerList as PIP4_ARRAY, byval pReserved as PVOID) as DNS_STATUS
#endif

declare function DnsReplaceRecordSetA(byval pNewSet as PDNS_RECORD, byval Options as DWORD, byval hContext as HANDLE, byval pServerList as PIP4_ARRAY, byval pReserved as PVOID) as DNS_STATUS

#ifndef UNICODE
	declare function DnsReplaceRecordSet alias "DnsReplaceRecordSetA"(byval pNewSet as PDNS_RECORD, byval Options as DWORD, byval hContext as HANDLE, byval pServerList as PIP4_ARRAY, byval pReserved as PVOID) as DNS_STATUS
#endif

declare function DnsReplaceRecordSetUTF8(byval pNewSet as PDNS_RECORD, byval Options as DWORD, byval hContext as HANDLE, byval pServerList as PIP4_ARRAY, byval pReserved as PVOID) as DNS_STATUS

type _DNS_NAME_FORMAT as long
enum
	DnsNameDomain
	DnsNameDomainLabel
	DnsNameHostnameFull
	DnsNameHostnameLabel
	DnsNameWildcard
	DnsNameSrvRecord
end enum

type DNS_NAME_FORMAT as _DNS_NAME_FORMAT
declare function DnsValidateName_UTF8 cdecl(byval pszName as LPCSTR, byval Format as DNS_NAME_FORMAT) as DNS_STATUS
declare function DnsValidateName_W cdecl(byval pwszName as LPCWSTR, byval Format as DNS_NAME_FORMAT) as DNS_STATUS
declare function DnsValidateName_A cdecl(byval pszName as LPCSTR, byval Format as DNS_NAME_FORMAT) as DNS_STATUS
declare function DnsNameCompare_A(byval pName1 as LPSTR, byval pName2 as LPSTR) as WINBOOL
declare function DnsNameCompare_W(byval pName1 as LPWSTR, byval pName2 as LPWSTR) as WINBOOL

type _DNS_MESSAGE_BUFFER
	MessageHead as DNS_HEADER
	MessageBody as zstring * 1
end type

type DNS_MESSAGE_BUFFER as _DNS_MESSAGE_BUFFER
type PDNS_MESSAGE_BUFFER as _DNS_MESSAGE_BUFFER ptr
declare function DnsWriteQuestionToBuffer_W(byval pDnsBuffer as PDNS_MESSAGE_BUFFER, byval pdwBufferSize as PDWORD, byval pszName as LPWSTR, byval wType as WORD, byval Xid as WORD, byval fRecursionDesired as WINBOOL) as WINBOOL
declare function DnsWriteQuestionToBuffer_UTF8(byval pDnsBuffer as PDNS_MESSAGE_BUFFER, byval pdwBufferSize as LPDWORD, byval pszName as LPSTR, byval wType as WORD, byval Xid as WORD, byval fRecursionDesired as WINBOOL) as WINBOOL
declare function DnsExtractRecordsFromMessage_W(byval pDnsBuffer as PDNS_MESSAGE_BUFFER, byval wMessageLength as WORD, byval ppRecord as PDNS_RECORD ptr) as DNS_STATUS
declare function DnsExtractRecordsFromMessage_UTF8(byval pDnsBuffer as PDNS_MESSAGE_BUFFER, byval wMessageLength as WORD, byval ppRecord as PDNS_RECORD ptr) as DNS_STATUS

end extern
