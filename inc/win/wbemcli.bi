'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   This Software is provided under the Zope Public License (ZPL) Version 2.1.
''
''   Copyright (c) 2009, 2010 by the mingw-w64 project
''
''   See the AUTHORS file for the list of contributors to the mingw-w64 project.
''
''   This license has been certified as open source. It has also been designated
''   as GPL compatible by the Free Software Foundation (FSF).
''
''   Redistribution and use in source and binary forms, with or without
''   modification, are permitted provided that the following conditions are met:
''
''     1. Redistributions in source code must retain the accompanying copyright
''        notice, this list of conditions, and the following disclaimer.
''     2. Redistributions in binary form must reproduce the accompanying
''        copyright notice, this list of conditions, and the following disclaimer
''        in the documentation and/or other materials provided with the
''        distribution.
''     3. Names of the copyright holders must not be used to endorse or promote
''        products derived from this software without prior written permission
''        from the copyright holders.
''     4. The right to distribute this software or to use it for any purpose does
''        not give you the right to use Servicemarks (sm) or Trademarks (tm) of
''        the copyright holders.  Use of them is covered by separate agreement
''        with the copyright holders.
''     5. If any files are modified, you must cause the modified files to carry
''        prominent notices stating that you changed the files and the date of
''        any change.
''
''   Disclaimer
''
''   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS ``AS IS'' AND ANY EXPRESSED
''   OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
''   OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
''   EVENT SHALL THE COPYRIGHT HOLDERS BE LIABLE FOR ANY DIRECT, INDIRECT,
''   INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
''   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, 
''   OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
''   LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
''   NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
''   EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "rpc.bi"
#include once "rpcndr.bi"
#include once "ocidl.bi"
#include once "oleidl.bi"
#include once "oaidl.bi"
#include once "servprov.bi"
#include once "winapifamily.bi"

extern "Windows"

#define __wbemcli_h__
#define __WbemBackupRestore_FWD_DEFINED__
#define __WbemClassObject_FWD_DEFINED__
#define __WbemContext_FWD_DEFINED__
#define __WbemLocator_FWD_DEFINED__
#define __WbemStatusCodeText_FWD_DEFINED__
#define __UnsecuredApartment_FWD_DEFINED__
#define __MofCompiler_FWD_DEFINED__
#define __WbemObjectTextSrc_FWD_DEFINED__
#define __WbemRefresher_FWD_DEFINED__
#define __IWbemClassObject_FWD_DEFINED__
#define __IWbemQualifierSet_FWD_DEFINED__
#define __IWbemLocator_FWD_DEFINED__
#define __IWbemObjectSink_FWD_DEFINED__
#define __IWbemObjectSinkEx_FWD_DEFINED__
#define __IEnumWbemClassObject_FWD_DEFINED__
#define __IWbemContext_FWD_DEFINED__
#define __IWbemCallResult_FWD_DEFINED__
#define __IWbemServices_FWD_DEFINED__
#define __IWbemShutdown_FWD_DEFINED__
#define __IWbemObjectTextSrc_FWD_DEFINED__
#define __IWbemObjectAccess_FWD_DEFINED__
#define __IMofCompiler_FWD_DEFINED__
#define __IUnsecuredApartment_FWD_DEFINED__
#define __IWbemUnsecuredApartment_FWD_DEFINED__
#define __IWbemStatusCodeText_FWD_DEFINED__
#define __IWbemBackupRestore_FWD_DEFINED__
#define __IWbemBackupRestoreEx_FWD_DEFINED__
#define __IWbemRefresher_FWD_DEFINED__
#define __IWbemHiPerfEnum_FWD_DEFINED__
#define __IWbemConfigureRefresher_FWD_DEFINED__
#define __IWbemConnection_FWD_DEFINED__
#define __IWbemEventSink_FWD_DEFINED__
#define __IWbemSecureObjectSink_FWD_DEFINED__
extern LIBID_WbemClient_v1 as const GUID

type tag_WBEM_GENUS_TYPE as long
enum
	WBEM_GENUS_CLASS = 1
	WBEM_GENUS_INSTANCE = 2
end enum

type WBEM_GENUS_TYPE as tag_WBEM_GENUS_TYPE

type tag_WBEM_CHANGE_FLAG_TYPE as long
enum
	WBEM_FLAG_CREATE_OR_UPDATE = 0
	WBEM_FLAG_UPDATE_ONLY = &h1
	WBEM_FLAG_CREATE_ONLY = &h2
	WBEM_FLAG_UPDATE_COMPATIBLE = &h0
	WBEM_FLAG_UPDATE_SAFE_MODE = &h20
	WBEM_FLAG_UPDATE_FORCE_MODE = &h40
	WBEM_MASK_UPDATE_MODE = &h60
	WBEM_FLAG_ADVISORY = &h10000
end enum

type WBEM_CHANGE_FLAG_TYPE as tag_WBEM_CHANGE_FLAG_TYPE

type tag_WBEM_GENERIC_FLAG_TYPE as long
enum
	WBEM_FLAG_RETURN_IMMEDIATELY = &h10
	WBEM_FLAG_RETURN_WBEM_COMPLETE = 0
	WBEM_FLAG_BIDIRECTIONAL = 0
	WBEM_FLAG_FORWARD_ONLY = &h20
	WBEM_FLAG_NO_ERROR_OBJECT = &h40
	WBEM_FLAG_RETURN_ERROR_OBJECT = 0
	WBEM_FLAG_SEND_STATUS = &h80
	WBEM_FLAG_DONT_SEND_STATUS = 0
	WBEM_FLAG_ENSURE_LOCATABLE = &h100
	WBEM_FLAG_DIRECT_READ = &h200
	WBEM_FLAG_SEND_ONLY_SELECTED = 0
	WBEM_RETURN_WHEN_COMPLETE = 0
	WBEM_RETURN_IMMEDIATELY = &h10
	WBEM_MASK_RESERVED_FLAGS = &h1f000
	WBEM_FLAG_USE_AMENDED_QUALIFIERS = &h20000
	WBEM_FLAG_STRONG_VALIDATION = &h100000
end enum

type WBEM_GENERIC_FLAG_TYPE as tag_WBEM_GENERIC_FLAG_TYPE

type tag_WBEM_STATUS_TYPE as long
enum
	WBEM_STATUS_COMPLETE = 0
	WBEM_STATUS_REQUIREMENTS = 1
	WBEM_STATUS_PROGRESS = 2
	WBEM_STATUS_LOGGING_INFORMATION = &h100
	WBEM_STATUS_LOGGING_INFORMATION_PROVIDER = &h200
	WBEM_STATUS_LOGGING_INFORMATION_HOST = &h400
	WBEM_STATUS_LOGGING_INFORMATION_REPOSITORY = &h800
	WBEM_STATUS_LOGGING_INFORMATION_ESS = &h1000
end enum

type WBEM_STATUS_TYPE as tag_WBEM_STATUS_TYPE

type tag_WBEM_TIMEOUT_TYPE as long
enum
	WBEM_NO_WAIT = 0
	WBEM_INFINITE = &hffffffff
end enum

type WBEM_TIMEOUT_TYPE as tag_WBEM_TIMEOUT_TYPE

type tag_WBEM_CONDITION_FLAG_TYPE as long
enum
	WBEM_FLAG_ALWAYS = 0
	WBEM_FLAG_ONLY_IF_TRUE = &h1
	WBEM_FLAG_ONLY_IF_FALSE = &h2
	WBEM_FLAG_ONLY_IF_IDENTICAL = &h3
	WBEM_MASK_PRIMARY_CONDITION = &h3
	WBEM_FLAG_KEYS_ONLY = &h4
	WBEM_FLAG_REFS_ONLY = &h8
	WBEM_FLAG_LOCAL_ONLY = &h10
	WBEM_FLAG_PROPAGATED_ONLY = &h20
	WBEM_FLAG_SYSTEM_ONLY = &h30
	WBEM_FLAG_NONSYSTEM_ONLY = &h40
	WBEM_MASK_CONDITION_ORIGIN = &h70
	WBEM_FLAG_CLASS_OVERRIDES_ONLY = &h100
	WBEM_FLAG_CLASS_LOCAL_AND_OVERRIDES = &h200
	WBEM_MASK_CLASS_CONDITION = &h300
end enum

type WBEM_CONDITION_FLAG_TYPE as tag_WBEM_CONDITION_FLAG_TYPE

type tag_WBEM_FLAVOR_TYPE as long
enum
	WBEM_FLAVOR_DONT_PROPAGATE = 0
	WBEM_FLAVOR_FLAG_PROPAGATE_TO_INSTANCE = &h1
	WBEM_FLAVOR_FLAG_PROPAGATE_TO_DERIVED_CLASS = &h2
	WBEM_FLAVOR_MASK_PROPAGATION = &hf
	WBEM_FLAVOR_OVERRIDABLE = 0
	WBEM_FLAVOR_NOT_OVERRIDABLE = &h10
	WBEM_FLAVOR_MASK_PERMISSIONS = &h10
	WBEM_FLAVOR_ORIGIN_LOCAL = 0
	WBEM_FLAVOR_ORIGIN_PROPAGATED = &h20
	WBEM_FLAVOR_ORIGIN_SYSTEM = &h40
	WBEM_FLAVOR_MASK_ORIGIN = &h60
	WBEM_FLAVOR_NOT_AMENDED = 0
	WBEM_FLAVOR_AMENDED = &h80
	WBEM_FLAVOR_MASK_AMENDED = &h80
end enum

type WBEM_FLAVOR_TYPE as tag_WBEM_FLAVOR_TYPE

type tag_WBEM_QUERY_FLAG_TYPE as long
enum
	WBEM_FLAG_DEEP = 0
	WBEM_FLAG_SHALLOW = 1
	WBEM_FLAG_PROTOTYPE = 2
end enum

type WBEM_QUERY_FLAG_TYPE as tag_WBEM_QUERY_FLAG_TYPE

type tag_WBEM_SECURITY_FLAGS as long
enum
	WBEM_ENABLE = 1
	WBEM_METHOD_EXECUTE = 2
	WBEM_FULL_WRITE_REP = 4
	WBEM_PARTIAL_WRITE_REP = 8
	WBEM_WRITE_PROVIDER = &h10
	WBEM_REMOTE_ACCESS = &h20
	WBEM_RIGHT_SUBSCRIBE = &h40
	WBEM_RIGHT_PUBLISH = &h80
end enum

type WBEM_SECURITY_FLAGS as tag_WBEM_SECURITY_FLAGS

type tag_WBEM_LIMITATION_FLAG_TYPE as long
enum
	WBEM_FLAG_EXCLUDE_OBJECT_QUALIFIERS = &h10
	WBEM_FLAG_EXCLUDE_PROPERTY_QUALIFIERS = &h20
end enum

type WBEM_LIMITATION_FLAG_TYPE as tag_WBEM_LIMITATION_FLAG_TYPE

type tag_WBEM_TEXT_FLAG_TYPE as long
enum
	WBEM_FLAG_NO_FLAVORS = &h1
end enum

type WBEM_TEXT_FLAG_TYPE as tag_WBEM_TEXT_FLAG_TYPE

type tag_WBEM_COMPARISON_FLAG as long
enum
	WBEM_COMPARISON_INCLUDE_ALL = 0
	WBEM_FLAG_IGNORE_QUALIFIERS = &h1
	WBEM_FLAG_IGNORE_OBJECT_SOURCE = &h2
	WBEM_FLAG_IGNORE_DEFAULT_VALUES = &h4
	WBEM_FLAG_IGNORE_CLASS = &h8
	WBEM_FLAG_IGNORE_CASE = &h10
	WBEM_FLAG_IGNORE_FLAVOR = &h20
end enum

type WBEM_COMPARISON_FLAG as tag_WBEM_COMPARISON_FLAG

type tag_WBEM_LOCKING as long
enum
	WBEM_FLAG_ALLOW_READ = &h1
end enum

type WBEM_LOCKING_FLAG_TYPE as tag_WBEM_LOCKING

type tag_CIMTYPE_ENUMERATION as long
enum
	CIM_ILLEGAL = &hfff
	CIM_EMPTY = 0
	CIM_SINT8 = 16
	CIM_UINT8 = 17
	CIM_SINT16 = 2
	CIM_UINT16 = 18
	CIM_SINT32 = 3
	CIM_UINT32 = 19
	CIM_SINT64 = 20
	CIM_UINT64 = 21
	CIM_REAL32 = 4
	CIM_REAL64 = 5
	CIM_BOOLEAN = 11
	CIM_STRING = 8
	CIM_DATETIME = 101
	CIM_REFERENCE = 102
	CIM_CHAR16 = 103
	CIM_OBJECT = 13
	CIM_FLAG_ARRAY = &h2000
end enum

type CIMTYPE_ENUMERATION as tag_CIMTYPE_ENUMERATION

type tag_WBEM_BACKUP_RESTORE_FLAGS as long
enum
	WBEM_FLAG_BACKUP_RESTORE_DEFAULT = 0
	WBEM_FLAG_BACKUP_RESTORE_FORCE_SHUTDOWN = 1
end enum

type WBEM_BACKUP_RESTORE_FLAGS as tag_WBEM_BACKUP_RESTORE_FLAGS

type tag_WBEM_REFRESHER_FLAGS as long
enum
	WBEM_FLAG_REFRESH_AUTO_RECONNECT = 0
	WBEM_FLAG_REFRESH_NO_AUTO_RECONNECT = 1
end enum

type WBEM_REFRESHER_FLAGS as tag_WBEM_REFRESHER_FLAGS

type tag_WBEM_SHUTDOWN_FLAGS as long
enum
	WBEM_SHUTDOWN_UNLOAD_COMPONENT = 1
	WBEM_SHUTDOWN_WMI = 2
	WBEM_SHUTDOWN_OS = 3
end enum

type WBEM_SHUTDOWN_FLAGS as tag_WBEM_SHUTDOWN_FLAGS

type tag_WBEMSTATUS_FORMAT as long
enum
	WBEMSTATUS_FORMAT_NEWLINE = 0
	WBEMSTATUS_FORMAT_NO_NEWLINE = 1
end enum

type WBEMSTATUS_FORMAT as tag_WBEMSTATUS_FORMAT

type tag_WBEM_LIMITS as long
enum
	WBEM_MAX_IDENTIFIER = &h1000
	WBEM_MAX_QUERY = &h4000
	WBEM_MAX_PATH = &h2000
	WBEM_MAX_OBJECT_NESTING = 64
	WBEM_MAX_USER_PROPERTIES = 1024
end enum

type WBEM_LIMITS as tag_WBEM_LIMITS

type tag_WBEMSTATUS as long
enum
	WBEM_NO_ERROR = 0
	WBEM_S_NO_ERROR = 0
	WBEM_S_SAME = 0
	WBEM_S_FALSE = 1
	WBEM_S_ALREADY_EXISTS = &h40001
	WBEM_S_RESET_TO_DEFAULT = &h40002
	WBEM_S_DIFFERENT = &h40003
	WBEM_S_TIMEDOUT = &h40004
	WBEM_S_NO_MORE_DATA = &h40005
	WBEM_S_OPERATION_CANCELLED = &h40006
	WBEM_S_PENDING = &h40007
	WBEM_S_DUPLICATE_OBJECTS = &h40008
	WBEM_S_ACCESS_DENIED = &h40009
	WBEM_S_PARTIAL_RESULTS = &h40010
	WBEM_S_SOURCE_NOT_AVAILABLE = &h40017
	WBEM_E_FAILED = &h80041001
	WBEM_E_NOT_FOUND = &h80041002
	WBEM_E_ACCESS_DENIED = &h80041003
	WBEM_E_PROVIDER_FAILURE = &h80041004
	WBEM_E_TYPE_MISMATCH = &h80041005
	WBEM_E_OUT_OF_MEMORY = &h80041006
	WBEM_E_INVALID_CONTEXT = &h80041007
	WBEM_E_INVALID_PARAMETER = &h80041008
	WBEM_E_NOT_AVAILABLE = &h80041009
	WBEM_E_CRITICAL_ERROR = &h8004100a
	WBEM_E_INVALID_STREAM = &h8004100b
	WBEM_E_NOT_SUPPORTED = &h8004100c
	WBEM_E_INVALID_SUPERCLASS = &h8004100d
	WBEM_E_INVALID_NAMESPACE = &h8004100e
	WBEM_E_INVALID_OBJECT = &h8004100f
	WBEM_E_INVALID_CLASS = &h80041010
	WBEM_E_PROVIDER_NOT_FOUND = &h80041011
	WBEM_E_INVALID_PROVIDER_REGISTRATION = &h80041012
	WBEM_E_PROVIDER_LOAD_FAILURE = &h80041013
	WBEM_E_INITIALIZATION_FAILURE = &h80041014
	WBEM_E_TRANSPORT_FAILURE = &h80041015
	WBEM_E_INVALID_OPERATION = &h80041016
	WBEM_E_INVALID_QUERY = &h80041017
	WBEM_E_INVALID_QUERY_TYPE = &h80041018
	WBEM_E_ALREADY_EXISTS = &h80041019
	WBEM_E_OVERRIDE_NOT_ALLOWED = &h8004101a
	WBEM_E_PROPAGATED_QUALIFIER = &h8004101b
	WBEM_E_PROPAGATED_PROPERTY = &h8004101c
	WBEM_E_UNEXPECTED = &h8004101d
	WBEM_E_ILLEGAL_OPERATION = &h8004101e
	WBEM_E_CANNOT_BE_KEY = &h8004101f
	WBEM_E_INCOMPLETE_CLASS = &h80041020
	WBEM_E_INVALID_SYNTAX = &h80041021
	WBEM_E_NONDECORATED_OBJECT = &h80041022
	WBEM_E_READ_ONLY = &h80041023
	WBEM_E_PROVIDER_NOT_CAPABLE = &h80041024
	WBEM_E_CLASS_HAS_CHILDREN = &h80041025
	WBEM_E_CLASS_HAS_INSTANCES = &h80041026
	WBEM_E_QUERY_NOT_IMPLEMENTED = &h80041027
	WBEM_E_ILLEGAL_NULL = &h80041028
	WBEM_E_INVALID_QUALIFIER_TYPE = &h80041029
	WBEM_E_INVALID_PROPERTY_TYPE = &h8004102a
	WBEM_E_VALUE_OUT_OF_RANGE = &h8004102b
	WBEM_E_CANNOT_BE_SINGLETON = &h8004102c
	WBEM_E_INVALID_CIM_TYPE = &h8004102d
	WBEM_E_INVALID_METHOD = &h8004102e
	WBEM_E_INVALID_METHOD_PARAMETERS = &h8004102f
	WBEM_E_SYSTEM_PROPERTY = &h80041030
	WBEM_E_INVALID_PROPERTY = &h80041031
	WBEM_E_CALL_CANCELLED = &h80041032
	WBEM_E_SHUTTING_DOWN = &h80041033
	WBEM_E_PROPAGATED_METHOD = &h80041034
	WBEM_E_UNSUPPORTED_PARAMETER = &h80041035
	WBEM_E_MISSING_PARAMETER_ID = &h80041036
	WBEM_E_INVALID_PARAMETER_ID = &h80041037
	WBEM_E_NONCONSECUTIVE_PARAMETER_IDS = &h80041038
	WBEM_E_PARAMETER_ID_ON_RETVAL = &h80041039
	WBEM_E_INVALID_OBJECT_PATH = &h8004103a
	WBEM_E_OUT_OF_DISK_SPACE = &h8004103b
	WBEM_E_BUFFER_TOO_SMALL = &h8004103c
	WBEM_E_UNSUPPORTED_PUT_EXTENSION = &h8004103d
	WBEM_E_UNKNOWN_OBJECT_TYPE = &h8004103e
	WBEM_E_UNKNOWN_PACKET_TYPE = &h8004103f
	WBEM_E_MARSHAL_VERSION_MISMATCH = &h80041040
	WBEM_E_MARSHAL_INVALID_SIGNATURE = &h80041041
	WBEM_E_INVALID_QUALIFIER = &h80041042
	WBEM_E_INVALID_DUPLICATE_PARAMETER = &h80041043
	WBEM_E_TOO_MUCH_DATA = &h80041044
	WBEM_E_SERVER_TOO_BUSY = &h80041045
	WBEM_E_INVALID_FLAVOR = &h80041046
	WBEM_E_CIRCULAR_REFERENCE = &h80041047
	WBEM_E_UNSUPPORTED_CLASS_UPDATE = &h80041048
	WBEM_E_CANNOT_CHANGE_KEY_INHERITANCE = &h80041049
	WBEM_E_CANNOT_CHANGE_INDEX_INHERITANCE = &h80041050
	WBEM_E_TOO_MANY_PROPERTIES = &h80041051
	WBEM_E_UPDATE_TYPE_MISMATCH = &h80041052
	WBEM_E_UPDATE_OVERRIDE_NOT_ALLOWED = &h80041053
	WBEM_E_UPDATE_PROPAGATED_METHOD = &h80041054
	WBEM_E_METHOD_NOT_IMPLEMENTED = &h80041055
	WBEM_E_METHOD_DISABLED = &h80041056
	WBEM_E_REFRESHER_BUSY = &h80041057
	WBEM_E_UNPARSABLE_QUERY = &h80041058
	WBEM_E_NOT_EVENT_CLASS = &h80041059
	WBEM_E_MISSING_GROUP_WITHIN = &h8004105a
	WBEM_E_MISSING_AGGREGATION_LIST = &h8004105b
	WBEM_E_PROPERTY_NOT_AN_OBJECT = &h8004105c
	WBEM_E_AGGREGATING_BY_OBJECT = &h8004105d
	WBEM_E_UNINTERPRETABLE_PROVIDER_QUERY = &h8004105f
	WBEM_E_BACKUP_RESTORE_WINMGMT_RUNNING = &h80041060
	WBEM_E_QUEUE_OVERFLOW = &h80041061
	WBEM_E_PRIVILEGE_NOT_HELD = &h80041062
	WBEM_E_INVALID_OPERATOR = &h80041063
	WBEM_E_LOCAL_CREDENTIALS = &h80041064
	WBEM_E_CANNOT_BE_ABSTRACT = &h80041065
	WBEM_E_AMENDED_OBJECT = &h80041066
	WBEM_E_CLIENT_TOO_SLOW = &h80041067
	WBEM_E_NULL_SECURITY_DESCRIPTOR = &h80041068
	WBEM_E_TIMED_OUT = &h80041069
	WBEM_E_INVALID_ASSOCIATION = &h8004106a
	WBEM_E_AMBIGUOUS_OPERATION = &h8004106b
	WBEM_E_QUOTA_VIOLATION = &h8004106c
	WBEM_E_RESERVED_001 = &h8004106d
	WBEM_E_RESERVED_002 = &h8004106e
	WBEM_E_UNSUPPORTED_LOCALE = &h8004106f
	WBEM_E_HANDLE_OUT_OF_DATE = &h80041070
	WBEM_E_CONNECTION_FAILED = &h80041071
	WBEM_E_INVALID_HANDLE_REQUEST = &h80041072
	WBEM_E_PROPERTY_NAME_TOO_WIDE = &h80041073
	WBEM_E_CLASS_NAME_TOO_WIDE = &h80041074
	WBEM_E_METHOD_NAME_TOO_WIDE = &h80041075
	WBEM_E_QUALIFIER_NAME_TOO_WIDE = &h80041076
	WBEM_E_RERUN_COMMAND = &h80041077
	WBEM_E_DATABASE_VER_MISMATCH = &h80041078
	WBEM_E_VETO_DELETE = &h80041079
	WBEM_E_VETO_PUT = &h8004107a
	WBEM_E_INVALID_LOCALE = &h80041080
	WBEM_E_PROVIDER_SUSPENDED = &h80041081
	WBEM_E_SYNCHRONIZATION_REQUIRED = &h80041082
	WBEM_E_NO_SCHEMA = &h80041083
	WBEM_E_PROVIDER_ALREADY_REGISTERED = &h80041084
	WBEM_E_PROVIDER_NOT_REGISTERED = &h80041085
	WBEM_E_FATAL_TRANSPORT_ERROR = &h80041086
	WBEM_E_ENCRYPTED_CONNECTION_REQUIRED = &h80041087
	WBEM_E_PROVIDER_TIMED_OUT = &h80041088
	WBEM_E_NO_KEY = &h80041089
	WBEM_E_PROVIDER_DISABLED = &h8004108a
	WBEMESS_E_REGISTRATION_TOO_BROAD = &h80042001
	WBEMESS_E_REGISTRATION_TOO_PRECISE = &h80042002
	WBEMESS_E_AUTHZ_NOT_PRIVILEGED = &h80042003
	WBEMMOF_E_EXPECTED_QUALIFIER_NAME = &h80044001
	WBEMMOF_E_EXPECTED_SEMI = &h80044002
	WBEMMOF_E_EXPECTED_OPEN_BRACE = &h80044003
	WBEMMOF_E_EXPECTED_CLOSE_BRACE = &h80044004
	WBEMMOF_E_EXPECTED_CLOSE_BRACKET = &h80044005
	WBEMMOF_E_EXPECTED_CLOSE_PAREN = &h80044006
	WBEMMOF_E_ILLEGAL_CONSTANT_VALUE = &h80044007
	WBEMMOF_E_EXPECTED_TYPE_IDENTIFIER = &h80044008
	WBEMMOF_E_EXPECTED_OPEN_PAREN = &h80044009
	WBEMMOF_E_UNRECOGNIZED_TOKEN = &h8004400a
	WBEMMOF_E_UNRECOGNIZED_TYPE = &h8004400b
	WBEMMOF_E_EXPECTED_PROPERTY_NAME = &h8004400c
	WBEMMOF_E_TYPEDEF_NOT_SUPPORTED = &h8004400d
	WBEMMOF_E_UNEXPECTED_ALIAS = &h8004400e
	WBEMMOF_E_UNEXPECTED_ARRAY_INIT = &h8004400f
	WBEMMOF_E_INVALID_AMENDMENT_SYNTAX = &h80044010
	WBEMMOF_E_INVALID_DUPLICATE_AMENDMENT = &h80044011
	WBEMMOF_E_INVALID_PRAGMA = &h80044012
	WBEMMOF_E_INVALID_NAMESPACE_SYNTAX = &h80044013
	WBEMMOF_E_EXPECTED_CLASS_NAME = &h80044014
	WBEMMOF_E_TYPE_MISMATCH = &h80044015
	WBEMMOF_E_EXPECTED_ALIAS_NAME = &h80044016
	WBEMMOF_E_INVALID_CLASS_DECLARATION = &h80044017
	WBEMMOF_E_INVALID_INSTANCE_DECLARATION = &h80044018
	WBEMMOF_E_EXPECTED_DOLLAR = &h80044019
	WBEMMOF_E_CIMTYPE_QUALIFIER = &h8004401a
	WBEMMOF_E_DUPLICATE_PROPERTY = &h8004401b
	WBEMMOF_E_INVALID_NAMESPACE_SPECIFICATION = &h8004401c
	WBEMMOF_E_OUT_OF_RANGE = &h8004401d
	WBEMMOF_E_INVALID_FILE = &h8004401e
	WBEMMOF_E_ALIASES_IN_EMBEDDED = &h8004401f
	WBEMMOF_E_NULL_ARRAY_ELEM = &h80044020
	WBEMMOF_E_DUPLICATE_QUALIFIER = &h80044021
	WBEMMOF_E_EXPECTED_FLAVOR_TYPE = &h80044022
	WBEMMOF_E_INCOMPATIBLE_FLAVOR_TYPES = &h80044023
	WBEMMOF_E_MULTIPLE_ALIASES = &h80044024
	WBEMMOF_E_INCOMPATIBLE_FLAVOR_TYPES2 = &h80044025
	WBEMMOF_E_NO_ARRAYS_RETURNED = &h80044026
	WBEMMOF_E_MUST_BE_IN_OR_OUT = &h80044027
	WBEMMOF_E_INVALID_FLAGS_SYNTAX = &h80044028
	WBEMMOF_E_EXPECTED_BRACE_OR_BAD_TYPE = &h80044029
	WBEMMOF_E_UNSUPPORTED_CIMV22_QUAL_VALUE = &h8004402a
	WBEMMOF_E_UNSUPPORTED_CIMV22_DATA_TYPE = &h8004402b
	WBEMMOF_E_INVALID_DELETEINSTANCE_SYNTAX = &h8004402c
	WBEMMOF_E_INVALID_QUALIFIER_SYNTAX = &h8004402d
	WBEMMOF_E_QUALIFIER_USED_OUTSIDE_SCOPE = &h8004402e
	WBEMMOF_E_ERROR_CREATING_TEMP_FILE = &h8004402f
	WBEMMOF_E_ERROR_INVALID_INCLUDE_FILE = &h80044030
	WBEMMOF_E_INVALID_DELETECLASS_SYNTAX = &h80044031
end enum

type WBEMSTATUS as tag_WBEMSTATUS

type tag_WMI_OBJ_TEXT as long
enum
	WMI_OBJ_TEXT_CIM_DTD_2_0 = 1
	WMI_OBJ_TEXT_WMI_DTD_2_0 = 2
	WMI_OBJ_TEXT_WMI_EXT1 = 3
	WMI_OBJ_TEXT_WMI_EXT2 = 4
	WMI_OBJ_TEXT_WMI_EXT3 = 5
	WMI_OBJ_TEXT_WMI_EXT4 = 6
	WMI_OBJ_TEXT_WMI_EXT5 = 7
	WMI_OBJ_TEXT_WMI_EXT6 = 8
	WMI_OBJ_TEXT_WMI_EXT7 = 9
	WMI_OBJ_TEXT_WMI_EXT8 = 10
	WMI_OBJ_TEXT_WMI_EXT9 = 11
	WMI_OBJ_TEXT_WMI_EXT10 = 12
	WMI_OBJ_TEXT_LAST = 13
end enum

type WMI_OBJ_TEXT as tag_WMI_OBJ_TEXT

type tag_WBEM_COMPILER_OPTIONS as long
enum
	WBEM_FLAG_CHECK_ONLY = &h1
	WBEM_FLAG_AUTORECOVER = &h2
	WBEM_FLAG_WMI_CHECK = &h4
	WBEM_FLAG_CONSOLE_PRINT = &h8
	WBEM_FLAG_DONT_ADD_TO_LIST = &h10
	WBEM_FLAG_SPLIT_FILES = &h20
	WBEM_FLAG_STORE_FILE = &h100
end enum

type WBEM_COMPILER_OPTIONS as tag_WBEM_COMPILER_OPTIONS

type tag_WBEM_CONNECT_OPTIONS as long
enum
	WBEM_FLAG_CONNECT_REPOSITORY_ONLY = &h40
	WBEM_FLAG_CONNECT_USE_MAX_WAIT = &h80
	WBEM_FLAG_CONNECT_PROVIDERS = &h100
end enum

type WBEM_CONNECT_OPTIONS as tag_WBEM_CONNECT_OPTIONS

type tag_WBEM_UNSECAPP_FLAG_TYPE as long
enum
	WBEM_FLAG_UNSECAPP_DEFAULT_CHECK_ACCESS = 0
	WBEM_FLAG_UNSECAPP_CHECK_ACCESS = 1
	WBEM_FLAG_UNSECAPP_DONT_CHECK_ACCESS = 2
end enum

type WBEM_UNSECAPP_FLAG_TYPE as tag_WBEM_UNSECAPP_FLAG_TYPE

type tag_WBEM_INFORMATION_FLAG_TYPE as long
enum
	WBEM_FLAG_SHORT_NAME = &h1
	WBEM_FLAG_LONG_NAME = &h2
end enum

type WBEM_INFORMATION_FLAG_TYPE as tag_WBEM_INFORMATION_FLAG_TYPE

type tag_CompileStatusInfo
	lPhaseError as LONG
	hRes as HRESULT
	ObjectNum as LONG
	FirstLine as LONG
	LastLine as LONG
	dwOutFlags as DWORD
end type

type WBEM_COMPILE_STATUS_INFO as tag_CompileStatusInfo
type CIMTYPE as LONG
extern CLSID_WbemBackupRestore as const GUID
extern CLSID_WbemClassObject as const GUID
extern CLSID_WbemContext as const GUID
extern CLSID_WbemLocator as const GUID
extern CLSID_WbemStatusCodeText as const GUID
extern CLSID_UnsecuredApartment as const GUID
extern CLSID_MofCompiler as const GUID
extern CLSID_WbemObjectTextSrc as const GUID
extern CLSID_WbemRefresher as const GUID
#define __IWbemClassObject_INTERFACE_DEFINED__
extern IID_IWbemClassObject as const GUID
type IWbemClassObject as IWbemClassObject_
type IWbemQualifierSet as IWbemQualifierSet_

type IWbemClassObjectVtbl
	QueryInterface as function(byval This as IWbemClassObject ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IWbemClassObject ptr) as ULONG
	Release as function(byval This as IWbemClassObject ptr) as ULONG
	GetQualifierSet as function(byval This as IWbemClassObject ptr, byval ppQualSet as IWbemQualifierSet ptr ptr) as HRESULT
	Get as function(byval This as IWbemClassObject ptr, byval wszName as LPCWSTR, byval lFlags as LONG, byval pVal as VARIANT ptr, byval pType as CIMTYPE ptr, byval plFlavor as LONG ptr) as HRESULT
	Put as function(byval This as IWbemClassObject ptr, byval wszName as LPCWSTR, byval lFlags as LONG, byval pVal as VARIANT ptr, byval Type as CIMTYPE) as HRESULT
	Delete_ as function(byval This as IWbemClassObject ptr, byval wszName as LPCWSTR) as HRESULT
	GetNames as function(byval This as IWbemClassObject ptr, byval wszQualifierName as LPCWSTR, byval lFlags as LONG, byval pQualifierVal as VARIANT ptr, byval pNames as SAFEARRAY ptr ptr) as HRESULT
	BeginEnumeration as function(byval This as IWbemClassObject ptr, byval lEnumFlags as LONG) as HRESULT
	Next as function(byval This as IWbemClassObject ptr, byval lFlags as LONG, byval strName as BSTR ptr, byval pVal as VARIANT ptr, byval pType as CIMTYPE ptr, byval plFlavor as LONG ptr) as HRESULT
	EndEnumeration as function(byval This as IWbemClassObject ptr) as HRESULT
	GetPropertyQualifierSet as function(byval This as IWbemClassObject ptr, byval wszProperty as LPCWSTR, byval ppQualSet as IWbemQualifierSet ptr ptr) as HRESULT
	Clone as function(byval This as IWbemClassObject ptr, byval ppCopy as IWbemClassObject ptr ptr) as HRESULT
	GetObjectText as function(byval This as IWbemClassObject ptr, byval lFlags as LONG, byval pstrObjectText as BSTR ptr) as HRESULT
	SpawnDerivedClass as function(byval This as IWbemClassObject ptr, byval lFlags as LONG, byval ppNewClass as IWbemClassObject ptr ptr) as HRESULT
	SpawnInstance as function(byval This as IWbemClassObject ptr, byval lFlags as LONG, byval ppNewInstance as IWbemClassObject ptr ptr) as HRESULT
	CompareTo as function(byval This as IWbemClassObject ptr, byval lFlags as LONG, byval pCompareTo as IWbemClassObject ptr) as HRESULT
	GetPropertyOrigin as function(byval This as IWbemClassObject ptr, byval wszName as LPCWSTR, byval pstrClassName as BSTR ptr) as HRESULT
	InheritsFrom as function(byval This as IWbemClassObject ptr, byval strAncestor as LPCWSTR) as HRESULT
	GetMethod as function(byval This as IWbemClassObject ptr, byval wszName as LPCWSTR, byval lFlags as LONG, byval ppInSignature as IWbemClassObject ptr ptr, byval ppOutSignature as IWbemClassObject ptr ptr) as HRESULT
	PutMethod as function(byval This as IWbemClassObject ptr, byval wszName as LPCWSTR, byval lFlags as LONG, byval pInSignature as IWbemClassObject ptr, byval pOutSignature as IWbemClassObject ptr) as HRESULT
	DeleteMethod as function(byval This as IWbemClassObject ptr, byval wszName as LPCWSTR) as HRESULT
	BeginMethodEnumeration as function(byval This as IWbemClassObject ptr, byval lEnumFlags as LONG) as HRESULT
	NextMethod as function(byval This as IWbemClassObject ptr, byval lFlags as LONG, byval pstrName as BSTR ptr, byval ppInSignature as IWbemClassObject ptr ptr, byval ppOutSignature as IWbemClassObject ptr ptr) as HRESULT
	EndMethodEnumeration as function(byval This as IWbemClassObject ptr) as HRESULT
	GetMethodQualifierSet as function(byval This as IWbemClassObject ptr, byval wszMethod as LPCWSTR, byval ppQualSet as IWbemQualifierSet ptr ptr) as HRESULT
	GetMethodOrigin as function(byval This as IWbemClassObject ptr, byval wszMethodName as LPCWSTR, byval pstrClassName as BSTR ptr) as HRESULT
end type

type IWbemClassObject_
	lpVtbl as IWbemClassObjectVtbl ptr
end type

#define IWbemClassObject_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IWbemClassObject_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IWbemClassObject_Release(This) (This)->lpVtbl->Release(This)
#define IWbemClassObject_GetQualifierSet(This, ppQualSet) (This)->lpVtbl->GetQualifierSet(This, ppQualSet)
#define IWbemClassObject_Get(This, wszName, lFlags, pVal, pType, plFlavor) (This)->lpVtbl->Get(This, wszName, lFlags, pVal, pType, plFlavor)
#define IWbemClassObject_Put(This, wszName, lFlags, pVal, Type) (This)->lpVtbl->Put(This, wszName, lFlags, pVal, Type)
#define IWbemClassObject_Delete(This, wszName) (This)->lpVtbl->Delete_(This, wszName)
#define IWbemClassObject_GetNames(This, wszQualifierName, lFlags, pQualifierVal, pNames) (This)->lpVtbl->GetNames(This, wszQualifierName, lFlags, pQualifierVal, pNames)
#define IWbemClassObject_BeginEnumeration(This, lEnumFlags) (This)->lpVtbl->BeginEnumeration(This, lEnumFlags)
#define IWbemClassObject_Next(This, lFlags, strName, pVal, pType, plFlavor) (This)->lpVtbl->Next(This, lFlags, strName, pVal, pType, plFlavor)
#define IWbemClassObject_EndEnumeration(This) (This)->lpVtbl->EndEnumeration(This)
#define IWbemClassObject_GetPropertyQualifierSet(This, wszProperty, ppQualSet) (This)->lpVtbl->GetPropertyQualifierSet(This, wszProperty, ppQualSet)
#define IWbemClassObject_Clone(This, ppCopy) (This)->lpVtbl->Clone(This, ppCopy)
#define IWbemClassObject_GetObjectText(This, lFlags, pstrObjectText) (This)->lpVtbl->GetObjectText(This, lFlags, pstrObjectText)
#define IWbemClassObject_SpawnDerivedClass(This, lFlags, ppNewClass) (This)->lpVtbl->SpawnDerivedClass(This, lFlags, ppNewClass)
#define IWbemClassObject_SpawnInstance(This, lFlags, ppNewInstance) (This)->lpVtbl->SpawnInstance(This, lFlags, ppNewInstance)
#define IWbemClassObject_CompareTo(This, lFlags, pCompareTo) (This)->lpVtbl->CompareTo(This, lFlags, pCompareTo)
#define IWbemClassObject_GetPropertyOrigin(This, wszName, pstrClassName) (This)->lpVtbl->GetPropertyOrigin(This, wszName, pstrClassName)
#define IWbemClassObject_InheritsFrom(This, strAncestor) (This)->lpVtbl->InheritsFrom(This, strAncestor)
#define IWbemClassObject_GetMethod(This, wszName, lFlags, ppInSignature, ppOutSignature) (This)->lpVtbl->GetMethod(This, wszName, lFlags, ppInSignature, ppOutSignature)
#define IWbemClassObject_PutMethod(This, wszName, lFlags, pInSignature, pOutSignature) (This)->lpVtbl->PutMethod(This, wszName, lFlags, pInSignature, pOutSignature)
#define IWbemClassObject_DeleteMethod(This, wszName) (This)->lpVtbl->DeleteMethod(This, wszName)
#define IWbemClassObject_BeginMethodEnumeration(This, lEnumFlags) (This)->lpVtbl->BeginMethodEnumeration(This, lEnumFlags)
#define IWbemClassObject_NextMethod(This, lFlags, pstrName, ppInSignature, ppOutSignature) (This)->lpVtbl->NextMethod(This, lFlags, pstrName, ppInSignature, ppOutSignature)
#define IWbemClassObject_EndMethodEnumeration(This) (This)->lpVtbl->EndMethodEnumeration(This)
#define IWbemClassObject_GetMethodQualifierSet(This, wszMethod, ppQualSet) (This)->lpVtbl->GetMethodQualifierSet(This, wszMethod, ppQualSet)
#define IWbemClassObject_GetMethodOrigin(This, wszMethodName, pstrClassName) (This)->lpVtbl->GetMethodOrigin(This, wszMethodName, pstrClassName)

declare function IWbemClassObject_GetQualifierSet_Proxy(byval This as IWbemClassObject ptr, byval ppQualSet as IWbemQualifierSet ptr ptr) as HRESULT
declare sub IWbemClassObject_GetQualifierSet_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemClassObject_Get_Proxy(byval This as IWbemClassObject ptr, byval wszName as LPCWSTR, byval lFlags as LONG, byval pVal as VARIANT ptr, byval pType as CIMTYPE ptr, byval plFlavor as LONG ptr) as HRESULT
declare sub IWbemClassObject_Get_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemClassObject_Put_Proxy(byval This as IWbemClassObject ptr, byval wszName as LPCWSTR, byval lFlags as LONG, byval pVal as VARIANT ptr, byval Type as CIMTYPE) as HRESULT
declare sub IWbemClassObject_Put_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemClassObject_Delete_Proxy(byval This as IWbemClassObject ptr, byval wszName as LPCWSTR) as HRESULT
declare sub IWbemClassObject_Delete_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemClassObject_GetNames_Proxy(byval This as IWbemClassObject ptr, byval wszQualifierName as LPCWSTR, byval lFlags as LONG, byval pQualifierVal as VARIANT ptr, byval pNames as SAFEARRAY ptr ptr) as HRESULT
declare sub IWbemClassObject_GetNames_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemClassObject_BeginEnumeration_Proxy(byval This as IWbemClassObject ptr, byval lEnumFlags as LONG) as HRESULT
declare sub IWbemClassObject_BeginEnumeration_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemClassObject_Next_Proxy(byval This as IWbemClassObject ptr, byval lFlags as LONG, byval strName as BSTR ptr, byval pVal as VARIANT ptr, byval pType as CIMTYPE ptr, byval plFlavor as LONG ptr) as HRESULT
declare sub IWbemClassObject_Next_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemClassObject_EndEnumeration_Proxy(byval This as IWbemClassObject ptr) as HRESULT
declare sub IWbemClassObject_EndEnumeration_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemClassObject_GetPropertyQualifierSet_Proxy(byval This as IWbemClassObject ptr, byval wszProperty as LPCWSTR, byval ppQualSet as IWbemQualifierSet ptr ptr) as HRESULT
declare sub IWbemClassObject_GetPropertyQualifierSet_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemClassObject_Clone_Proxy(byval This as IWbemClassObject ptr, byval ppCopy as IWbemClassObject ptr ptr) as HRESULT
declare sub IWbemClassObject_Clone_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemClassObject_GetObjectText_Proxy(byval This as IWbemClassObject ptr, byval lFlags as LONG, byval pstrObjectText as BSTR ptr) as HRESULT
declare sub IWbemClassObject_GetObjectText_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemClassObject_SpawnDerivedClass_Proxy(byval This as IWbemClassObject ptr, byval lFlags as LONG, byval ppNewClass as IWbemClassObject ptr ptr) as HRESULT
declare sub IWbemClassObject_SpawnDerivedClass_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemClassObject_SpawnInstance_Proxy(byval This as IWbemClassObject ptr, byval lFlags as LONG, byval ppNewInstance as IWbemClassObject ptr ptr) as HRESULT
declare sub IWbemClassObject_SpawnInstance_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemClassObject_CompareTo_Proxy(byval This as IWbemClassObject ptr, byval lFlags as LONG, byval pCompareTo as IWbemClassObject ptr) as HRESULT
declare sub IWbemClassObject_CompareTo_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemClassObject_GetPropertyOrigin_Proxy(byval This as IWbemClassObject ptr, byval wszName as LPCWSTR, byval pstrClassName as BSTR ptr) as HRESULT
declare sub IWbemClassObject_GetPropertyOrigin_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemClassObject_InheritsFrom_Proxy(byval This as IWbemClassObject ptr, byval strAncestor as LPCWSTR) as HRESULT
declare sub IWbemClassObject_InheritsFrom_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemClassObject_GetMethod_Proxy(byval This as IWbemClassObject ptr, byval wszName as LPCWSTR, byval lFlags as LONG, byval ppInSignature as IWbemClassObject ptr ptr, byval ppOutSignature as IWbemClassObject ptr ptr) as HRESULT
declare sub IWbemClassObject_GetMethod_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemClassObject_PutMethod_Proxy(byval This as IWbemClassObject ptr, byval wszName as LPCWSTR, byval lFlags as LONG, byval pInSignature as IWbemClassObject ptr, byval pOutSignature as IWbemClassObject ptr) as HRESULT
declare sub IWbemClassObject_PutMethod_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemClassObject_DeleteMethod_Proxy(byval This as IWbemClassObject ptr, byval wszName as LPCWSTR) as HRESULT
declare sub IWbemClassObject_DeleteMethod_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemClassObject_BeginMethodEnumeration_Proxy(byval This as IWbemClassObject ptr, byval lEnumFlags as LONG) as HRESULT
declare sub IWbemClassObject_BeginMethodEnumeration_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemClassObject_NextMethod_Proxy(byval This as IWbemClassObject ptr, byval lFlags as LONG, byval pstrName as BSTR ptr, byval ppInSignature as IWbemClassObject ptr ptr, byval ppOutSignature as IWbemClassObject ptr ptr) as HRESULT
declare sub IWbemClassObject_NextMethod_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemClassObject_EndMethodEnumeration_Proxy(byval This as IWbemClassObject ptr) as HRESULT
declare sub IWbemClassObject_EndMethodEnumeration_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemClassObject_GetMethodQualifierSet_Proxy(byval This as IWbemClassObject ptr, byval wszMethod as LPCWSTR, byval ppQualSet as IWbemQualifierSet ptr ptr) as HRESULT
declare sub IWbemClassObject_GetMethodQualifierSet_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemClassObject_GetMethodOrigin_Proxy(byval This as IWbemClassObject ptr, byval wszMethodName as LPCWSTR, byval pstrClassName as BSTR ptr) as HRESULT
declare sub IWbemClassObject_GetMethodOrigin_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IWbemQualifierSet_INTERFACE_DEFINED__
extern IID_IWbemQualifierSet as const GUID

type IWbemQualifierSetVtbl
	QueryInterface as function(byval This as IWbemQualifierSet ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IWbemQualifierSet ptr) as ULONG
	Release as function(byval This as IWbemQualifierSet ptr) as ULONG
	Get as function(byval This as IWbemQualifierSet ptr, byval wszName as LPCWSTR, byval lFlags as LONG, byval pVal as VARIANT ptr, byval plFlavor as LONG ptr) as HRESULT
	Put as function(byval This as IWbemQualifierSet ptr, byval wszName as LPCWSTR, byval pVal as VARIANT ptr, byval lFlavor as LONG) as HRESULT
	Delete_ as function(byval This as IWbemQualifierSet ptr, byval wszName as LPCWSTR) as HRESULT
	GetNames as function(byval This as IWbemQualifierSet ptr, byval lFlags as LONG, byval pNames as SAFEARRAY ptr ptr) as HRESULT
	BeginEnumeration as function(byval This as IWbemQualifierSet ptr, byval lFlags as LONG) as HRESULT
	Next as function(byval This as IWbemQualifierSet ptr, byval lFlags as LONG, byval pstrName as BSTR ptr, byval pVal as VARIANT ptr, byval plFlavor as LONG ptr) as HRESULT
	EndEnumeration as function(byval This as IWbemQualifierSet ptr) as HRESULT
end type

type IWbemQualifierSet_
	lpVtbl as IWbemQualifierSetVtbl ptr
end type

#define IWbemQualifierSet_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IWbemQualifierSet_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IWbemQualifierSet_Release(This) (This)->lpVtbl->Release(This)
#define IWbemQualifierSet_Get(This, wszName, lFlags, pVal, plFlavor) (This)->lpVtbl->Get(This, wszName, lFlags, pVal, plFlavor)
#define IWbemQualifierSet_Put(This, wszName, pVal, lFlavor) (This)->lpVtbl->Put(This, wszName, pVal, lFlavor)
#define IWbemQualifierSet_Delete(This, wszName) (This)->lpVtbl->Delete_(This, wszName)
#define IWbemQualifierSet_GetNames(This, lFlags, pNames) (This)->lpVtbl->GetNames(This, lFlags, pNames)
#define IWbemQualifierSet_BeginEnumeration(This, lFlags) (This)->lpVtbl->BeginEnumeration(This, lFlags)
#define IWbemQualifierSet_Next(This, lFlags, pstrName, pVal, plFlavor) (This)->lpVtbl->Next(This, lFlags, pstrName, pVal, plFlavor)
#define IWbemQualifierSet_EndEnumeration(This) (This)->lpVtbl->EndEnumeration(This)

declare function IWbemQualifierSet_Get_Proxy(byval This as IWbemQualifierSet ptr, byval wszName as LPCWSTR, byval lFlags as LONG, byval pVal as VARIANT ptr, byval plFlavor as LONG ptr) as HRESULT
declare sub IWbemQualifierSet_Get_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemQualifierSet_Put_Proxy(byval This as IWbemQualifierSet ptr, byval wszName as LPCWSTR, byval pVal as VARIANT ptr, byval lFlavor as LONG) as HRESULT
declare sub IWbemQualifierSet_Put_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemQualifierSet_Delete_Proxy(byval This as IWbemQualifierSet ptr, byval wszName as LPCWSTR) as HRESULT
declare sub IWbemQualifierSet_Delete_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemQualifierSet_GetNames_Proxy(byval This as IWbemQualifierSet ptr, byval lFlags as LONG, byval pNames as SAFEARRAY ptr ptr) as HRESULT
declare sub IWbemQualifierSet_GetNames_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemQualifierSet_BeginEnumeration_Proxy(byval This as IWbemQualifierSet ptr, byval lFlags as LONG) as HRESULT
declare sub IWbemQualifierSet_BeginEnumeration_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemQualifierSet_Next_Proxy(byval This as IWbemQualifierSet ptr, byval lFlags as LONG, byval pstrName as BSTR ptr, byval pVal as VARIANT ptr, byval plFlavor as LONG ptr) as HRESULT
declare sub IWbemQualifierSet_Next_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemQualifierSet_EndEnumeration_Proxy(byval This as IWbemQualifierSet ptr) as HRESULT
declare sub IWbemQualifierSet_EndEnumeration_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IWbemLocator_INTERFACE_DEFINED__
extern IID_IWbemLocator as const GUID

type IWbemLocator as IWbemLocator_
type IWbemContext as IWbemContext_
type IWbemServices as IWbemServices_

type IWbemLocatorVtbl
	QueryInterface as function(byval This as IWbemLocator ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IWbemLocator ptr) as ULONG
	Release as function(byval This as IWbemLocator ptr) as ULONG
	ConnectServer as function(byval This as IWbemLocator ptr, byval strNetworkResource as const BSTR, byval strUser as const BSTR, byval strPassword as const BSTR, byval strLocale as const BSTR, byval lSecurityFlags as LONG, byval strAuthority as const BSTR, byval pCtx as IWbemContext ptr, byval ppNamespace as IWbemServices ptr ptr) as HRESULT
end type

type IWbemLocator_
	lpVtbl as IWbemLocatorVtbl ptr
end type

#define IWbemLocator_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IWbemLocator_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IWbemLocator_Release(This) (This)->lpVtbl->Release(This)
#define IWbemLocator_ConnectServer(This, strNetworkResource, strUser, strPassword, strLocale, lSecurityFlags, strAuthority, pCtx, ppNamespace) (This)->lpVtbl->ConnectServer(This, strNetworkResource, strUser, strPassword, strLocale, lSecurityFlags, strAuthority, pCtx, ppNamespace)
declare function IWbemLocator_ConnectServer_Proxy(byval This as IWbemLocator ptr, byval strNetworkResource as const BSTR, byval strUser as const BSTR, byval strPassword as const BSTR, byval strLocale as const BSTR, byval lSecurityFlags as LONG, byval strAuthority as const BSTR, byval pCtx as IWbemContext ptr, byval ppNamespace as IWbemServices ptr ptr) as HRESULT
declare sub IWbemLocator_ConnectServer_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IWbemObjectSink_INTERFACE_DEFINED__
extern IID_IWbemObjectSink as const GUID
type IWbemObjectSink as IWbemObjectSink_

type IWbemObjectSinkVtbl
	QueryInterface as function(byval This as IWbemObjectSink ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IWbemObjectSink ptr) as ULONG
	Release as function(byval This as IWbemObjectSink ptr) as ULONG
	Indicate as function(byval This as IWbemObjectSink ptr, byval lObjectCount as LONG, byval apObjArray as IWbemClassObject ptr ptr) as HRESULT
	SetStatus as function(byval This as IWbemObjectSink ptr, byval lFlags as LONG, byval hResult as HRESULT, byval strParam as BSTR, byval pObjParam as IWbemClassObject ptr) as HRESULT
end type

type IWbemObjectSink_
	lpVtbl as IWbemObjectSinkVtbl ptr
end type

#define IWbemObjectSink_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IWbemObjectSink_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IWbemObjectSink_Release(This) (This)->lpVtbl->Release(This)
#define IWbemObjectSink_Indicate(This, lObjectCount, apObjArray) (This)->lpVtbl->Indicate(This, lObjectCount, apObjArray)
#define IWbemObjectSink_SetStatus(This, lFlags, hResult, strParam, pObjParam) (This)->lpVtbl->SetStatus(This, lFlags, hResult, strParam, pObjParam)

declare function IWbemObjectSink_Indicate_Proxy(byval This as IWbemObjectSink ptr, byval lObjectCount as LONG, byval apObjArray as IWbemClassObject ptr ptr) as HRESULT
declare sub IWbemObjectSink_Indicate_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemObjectSink_SetStatus_Proxy(byval This as IWbemObjectSink ptr, byval lFlags as LONG, byval hResult as HRESULT, byval strParam as BSTR, byval pObjParam as IWbemClassObject ptr) as HRESULT
declare sub IWbemObjectSink_SetStatus_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IWbemObjectSinkEx_INTERFACE_DEFINED__
extern IID_IWbemObjectSinkEx as const GUID
type IWbemObjectSinkEx as IWbemObjectSinkEx_

type IWbemObjectSinkExVtbl
	QueryInterface as function(byval This as IWbemObjectSinkEx ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IWbemObjectSinkEx ptr) as ULONG
	Release as function(byval This as IWbemObjectSinkEx ptr) as ULONG
	Indicate as function(byval This as IWbemObjectSinkEx ptr, byval lObjectCount as LONG, byval apObjArray as IWbemClassObject ptr ptr) as HRESULT
	SetStatus as function(byval This as IWbemObjectSinkEx ptr, byval lFlags as LONG, byval hResult as HRESULT, byval strParam as BSTR, byval pObjParam as IWbemClassObject ptr) as HRESULT
	WriteMessage as function(byval This as IWbemObjectSinkEx ptr, byval uChannel as ULONG, byval strMessage as const BSTR) as HRESULT
	WriteError as function(byval This as IWbemObjectSinkEx ptr, byval pObjError as IWbemClassObject ptr, byval puReturned as ubyte ptr) as HRESULT
	PromptUser as function(byval This as IWbemObjectSinkEx ptr, byval strMessage as const BSTR, byval uPromptType as ubyte, byval puReturned as ubyte ptr) as HRESULT
	WriteProgress as function(byval This as IWbemObjectSinkEx ptr, byval strActivity as const BSTR, byval strCurrentOperation as const BSTR, byval strStatusDescription as const BSTR, byval uPercentComplete as ULONG, byval uSecondsRemaining as ULONG) as HRESULT
	WriteStreamParameter as function(byval This as IWbemObjectSinkEx ptr, byval strName as const BSTR, byval vtValue as VARIANT ptr, byval ulType as ULONG, byval ulFlags as ULONG) as HRESULT
end type

type IWbemObjectSinkEx_
	lpVtbl as IWbemObjectSinkExVtbl ptr
end type

#define IWbemObjectSinkEx_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IWbemObjectSinkEx_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IWbemObjectSinkEx_Release(This) (This)->lpVtbl->Release(This)
#define IWbemObjectSinkEx_Indicate(This, lObjectCount, apObjArray) (This)->lpVtbl->Indicate(This, lObjectCount, apObjArray)
#define IWbemObjectSinkEx_SetStatus(This, lFlags, hResult, strParam, pObjParam) (This)->lpVtbl->SetStatus(This, lFlags, hResult, strParam, pObjParam)
#define IWbemObjectSinkEx_WriteMessage(This, uChannel, strMessage) (This)->lpVtbl->WriteMessage(This, uChannel, strMessage)
#define IWbemObjectSinkEx_WriteError(This, pObjError, puReturned) (This)->lpVtbl->WriteError(This, pObjError, puReturned)
#define IWbemObjectSinkEx_PromptUser(This, strMessage, uPromptType, puReturned) (This)->lpVtbl->PromptUser(This, strMessage, uPromptType, puReturned)
#define IWbemObjectSinkEx_WriteProgress(This, strActivity, strCurrentOperation, strStatusDescription, uPercentComplete, uSecondsRemaining) (This)->lpVtbl->WriteProgress(This, strActivity, strCurrentOperation, strStatusDescription, uPercentComplete, uSecondsRemaining)
#define IWbemObjectSinkEx_WriteStreamParameter(This, strName, vtValue, ulType, ulFlags) (This)->lpVtbl->WriteStreamParameter(This, strName, vtValue, ulType, ulFlags)

declare function IWbemObjectSinkEx_WriteMessage_Proxy(byval This as IWbemObjectSinkEx ptr, byval uChannel as ULONG, byval strMessage as const BSTR) as HRESULT
declare sub IWbemObjectSinkEx_WriteMessage_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemObjectSinkEx_WriteError_Proxy(byval This as IWbemObjectSinkEx ptr, byval pObjError as IWbemClassObject ptr, byval puReturned as ubyte ptr) as HRESULT
declare sub IWbemObjectSinkEx_WriteError_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemObjectSinkEx_PromptUser_Proxy(byval This as IWbemObjectSinkEx ptr, byval strMessage as const BSTR, byval uPromptType as ubyte, byval puReturned as ubyte ptr) as HRESULT
declare sub IWbemObjectSinkEx_PromptUser_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemObjectSinkEx_WriteProgress_Proxy(byval This as IWbemObjectSinkEx ptr, byval strActivity as const BSTR, byval strCurrentOperation as const BSTR, byval strStatusDescription as const BSTR, byval uPercentComplete as ULONG, byval uSecondsRemaining as ULONG) as HRESULT
declare sub IWbemObjectSinkEx_WriteProgress_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemObjectSinkEx_WriteStreamParameter_Proxy(byval This as IWbemObjectSinkEx ptr, byval strName as const BSTR, byval vtValue as VARIANT ptr, byval ulType as ULONG, byval ulFlags as ULONG) as HRESULT
declare sub IWbemObjectSinkEx_WriteStreamParameter_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IEnumWbemClassObject_INTERFACE_DEFINED__
extern IID_IEnumWbemClassObject as const GUID
type IEnumWbemClassObject as IEnumWbemClassObject_

type IEnumWbemClassObjectVtbl
	QueryInterface as function(byval This as IEnumWbemClassObject ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IEnumWbemClassObject ptr) as ULONG
	Release as function(byval This as IEnumWbemClassObject ptr) as ULONG
	Reset as function(byval This as IEnumWbemClassObject ptr) as HRESULT
	Next as function(byval This as IEnumWbemClassObject ptr, byval lTimeout as LONG, byval uCount as ULONG, byval apObjects as IWbemClassObject ptr ptr, byval puReturned as ULONG ptr) as HRESULT
	NextAsync as function(byval This as IEnumWbemClassObject ptr, byval uCount as ULONG, byval pSink as IWbemObjectSink ptr) as HRESULT
	Clone as function(byval This as IEnumWbemClassObject ptr, byval ppEnum as IEnumWbemClassObject ptr ptr) as HRESULT
	Skip as function(byval This as IEnumWbemClassObject ptr, byval lTimeout as LONG, byval nCount as ULONG) as HRESULT
end type

type IEnumWbemClassObject_
	lpVtbl as IEnumWbemClassObjectVtbl ptr
end type

#define IEnumWbemClassObject_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IEnumWbemClassObject_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IEnumWbemClassObject_Release(This) (This)->lpVtbl->Release(This)
#define IEnumWbemClassObject_Reset(This) (This)->lpVtbl->Reset(This)
#define IEnumWbemClassObject_Next(This, lTimeout, uCount, apObjects, puReturned) (This)->lpVtbl->Next(This, lTimeout, uCount, apObjects, puReturned)
#define IEnumWbemClassObject_NextAsync(This, uCount, pSink) (This)->lpVtbl->NextAsync(This, uCount, pSink)
#define IEnumWbemClassObject_Clone(This, ppEnum) (This)->lpVtbl->Clone(This, ppEnum)
#define IEnumWbemClassObject_Skip(This, lTimeout, nCount) (This)->lpVtbl->Skip(This, lTimeout, nCount)

declare function IEnumWbemClassObject_Reset_Proxy(byval This as IEnumWbemClassObject ptr) as HRESULT
declare sub IEnumWbemClassObject_Reset_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumWbemClassObject_Next_Proxy(byval This as IEnumWbemClassObject ptr, byval lTimeout as LONG, byval uCount as ULONG, byval apObjects as IWbemClassObject ptr ptr, byval puReturned as ULONG ptr) as HRESULT
declare sub IEnumWbemClassObject_Next_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumWbemClassObject_NextAsync_Proxy(byval This as IEnumWbemClassObject ptr, byval uCount as ULONG, byval pSink as IWbemObjectSink ptr) as HRESULT
declare sub IEnumWbemClassObject_NextAsync_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumWbemClassObject_Clone_Proxy(byval This as IEnumWbemClassObject ptr, byval ppEnum as IEnumWbemClassObject ptr ptr) as HRESULT
declare sub IEnumWbemClassObject_Clone_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumWbemClassObject_Skip_Proxy(byval This as IEnumWbemClassObject ptr, byval lTimeout as LONG, byval nCount as ULONG) as HRESULT
declare sub IEnumWbemClassObject_Skip_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IWbemContext_INTERFACE_DEFINED__
extern IID_IWbemContext as const GUID

type IWbemContextVtbl
	QueryInterface as function(byval This as IWbemContext ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IWbemContext ptr) as ULONG
	Release as function(byval This as IWbemContext ptr) as ULONG
	Clone as function(byval This as IWbemContext ptr, byval ppNewCopy as IWbemContext ptr ptr) as HRESULT
	GetNames as function(byval This as IWbemContext ptr, byval lFlags as LONG, byval pNames as SAFEARRAY ptr ptr) as HRESULT
	BeginEnumeration as function(byval This as IWbemContext ptr, byval lFlags as LONG) as HRESULT
	Next as function(byval This as IWbemContext ptr, byval lFlags as LONG, byval pstrName as BSTR ptr, byval pValue as VARIANT ptr) as HRESULT
	EndEnumeration as function(byval This as IWbemContext ptr) as HRESULT
	SetValue as function(byval This as IWbemContext ptr, byval wszName as LPCWSTR, byval lFlags as LONG, byval pValue as VARIANT ptr) as HRESULT
	GetValue as function(byval This as IWbemContext ptr, byval wszName as LPCWSTR, byval lFlags as LONG, byval pValue as VARIANT ptr) as HRESULT
	DeleteValue as function(byval This as IWbemContext ptr, byval wszName as LPCWSTR, byval lFlags as LONG) as HRESULT
	DeleteAll as function(byval This as IWbemContext ptr) as HRESULT
end type

type IWbemContext_
	lpVtbl as IWbemContextVtbl ptr
end type

#define IWbemContext_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IWbemContext_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IWbemContext_Release(This) (This)->lpVtbl->Release(This)
#define IWbemContext_Clone(This, ppNewCopy) (This)->lpVtbl->Clone(This, ppNewCopy)
#define IWbemContext_GetNames(This, lFlags, pNames) (This)->lpVtbl->GetNames(This, lFlags, pNames)
#define IWbemContext_BeginEnumeration(This, lFlags) (This)->lpVtbl->BeginEnumeration(This, lFlags)
#define IWbemContext_Next(This, lFlags, pstrName, pValue) (This)->lpVtbl->Next(This, lFlags, pstrName, pValue)
#define IWbemContext_EndEnumeration(This) (This)->lpVtbl->EndEnumeration(This)
#define IWbemContext_SetValue(This, wszName, lFlags, pValue) (This)->lpVtbl->SetValue(This, wszName, lFlags, pValue)
#define IWbemContext_GetValue(This, wszName, lFlags, pValue) (This)->lpVtbl->GetValue(This, wszName, lFlags, pValue)
#define IWbemContext_DeleteValue(This, wszName, lFlags) (This)->lpVtbl->DeleteValue(This, wszName, lFlags)
#define IWbemContext_DeleteAll(This) (This)->lpVtbl->DeleteAll(This)

declare function IWbemContext_Clone_Proxy(byval This as IWbemContext ptr, byval ppNewCopy as IWbemContext ptr ptr) as HRESULT
declare sub IWbemContext_Clone_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemContext_GetNames_Proxy(byval This as IWbemContext ptr, byval lFlags as LONG, byval pNames as SAFEARRAY ptr ptr) as HRESULT
declare sub IWbemContext_GetNames_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemContext_BeginEnumeration_Proxy(byval This as IWbemContext ptr, byval lFlags as LONG) as HRESULT
declare sub IWbemContext_BeginEnumeration_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemContext_Next_Proxy(byval This as IWbemContext ptr, byval lFlags as LONG, byval pstrName as BSTR ptr, byval pValue as VARIANT ptr) as HRESULT
declare sub IWbemContext_Next_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemContext_EndEnumeration_Proxy(byval This as IWbemContext ptr) as HRESULT
declare sub IWbemContext_EndEnumeration_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemContext_SetValue_Proxy(byval This as IWbemContext ptr, byval wszName as LPCWSTR, byval lFlags as LONG, byval pValue as VARIANT ptr) as HRESULT
declare sub IWbemContext_SetValue_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemContext_GetValue_Proxy(byval This as IWbemContext ptr, byval wszName as LPCWSTR, byval lFlags as LONG, byval pValue as VARIANT ptr) as HRESULT
declare sub IWbemContext_GetValue_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemContext_DeleteValue_Proxy(byval This as IWbemContext ptr, byval wszName as LPCWSTR, byval lFlags as LONG) as HRESULT
declare sub IWbemContext_DeleteValue_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemContext_DeleteAll_Proxy(byval This as IWbemContext ptr) as HRESULT
declare sub IWbemContext_DeleteAll_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IWbemCallResult_INTERFACE_DEFINED__
extern IID_IWbemCallResult as const GUID
type IWbemCallResult as IWbemCallResult_

type IWbemCallResultVtbl
	QueryInterface as function(byval This as IWbemCallResult ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IWbemCallResult ptr) as ULONG
	Release as function(byval This as IWbemCallResult ptr) as ULONG
	GetResultObject as function(byval This as IWbemCallResult ptr, byval lTimeout as LONG, byval ppResultObject as IWbemClassObject ptr ptr) as HRESULT
	GetResultString as function(byval This as IWbemCallResult ptr, byval lTimeout as LONG, byval pstrResultString as BSTR ptr) as HRESULT
	GetResultServices as function(byval This as IWbemCallResult ptr, byval lTimeout as LONG, byval ppServices as IWbemServices ptr ptr) as HRESULT
	GetCallStatus as function(byval This as IWbemCallResult ptr, byval lTimeout as LONG, byval plStatus as LONG ptr) as HRESULT
end type

type IWbemCallResult_
	lpVtbl as IWbemCallResultVtbl ptr
end type

#define IWbemCallResult_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IWbemCallResult_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IWbemCallResult_Release(This) (This)->lpVtbl->Release(This)
#define IWbemCallResult_GetResultObject(This, lTimeout, ppResultObject) (This)->lpVtbl->GetResultObject(This, lTimeout, ppResultObject)
#define IWbemCallResult_GetResultString(This, lTimeout, pstrResultString) (This)->lpVtbl->GetResultString(This, lTimeout, pstrResultString)
#define IWbemCallResult_GetResultServices(This, lTimeout, ppServices) (This)->lpVtbl->GetResultServices(This, lTimeout, ppServices)
#define IWbemCallResult_GetCallStatus(This, lTimeout, plStatus) (This)->lpVtbl->GetCallStatus(This, lTimeout, plStatus)

declare function IWbemCallResult_GetResultObject_Proxy(byval This as IWbemCallResult ptr, byval lTimeout as LONG, byval ppResultObject as IWbemClassObject ptr ptr) as HRESULT
declare sub IWbemCallResult_GetResultObject_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemCallResult_GetResultString_Proxy(byval This as IWbemCallResult ptr, byval lTimeout as LONG, byval pstrResultString as BSTR ptr) as HRESULT
declare sub IWbemCallResult_GetResultString_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemCallResult_GetResultServices_Proxy(byval This as IWbemCallResult ptr, byval lTimeout as LONG, byval ppServices as IWbemServices ptr ptr) as HRESULT
declare sub IWbemCallResult_GetResultServices_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemCallResult_GetCallStatus_Proxy(byval This as IWbemCallResult ptr, byval lTimeout as LONG, byval plStatus as LONG ptr) as HRESULT
declare sub IWbemCallResult_GetCallStatus_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IWbemServices_INTERFACE_DEFINED__
extern IID_IWbemServices as const GUID

type IWbemServicesVtbl
	QueryInterface as function(byval This as IWbemServices ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IWbemServices ptr) as ULONG
	Release as function(byval This as IWbemServices ptr) as ULONG
	OpenNamespace as function(byval This as IWbemServices ptr, byval strNamespace as const BSTR, byval lFlags as LONG, byval pCtx as IWbemContext ptr, byval ppWorkingNamespace as IWbemServices ptr ptr, byval ppResult as IWbemCallResult ptr ptr) as HRESULT
	CancelAsyncCall as function(byval This as IWbemServices ptr, byval pSink as IWbemObjectSink ptr) as HRESULT
	QueryObjectSink as function(byval This as IWbemServices ptr, byval lFlags as LONG, byval ppResponseHandler as IWbemObjectSink ptr ptr) as HRESULT
	GetObject as function(byval This as IWbemServices ptr, byval strObjectPath as const BSTR, byval lFlags as LONG, byval pCtx as IWbemContext ptr, byval ppObject as IWbemClassObject ptr ptr, byval ppCallResult as IWbemCallResult ptr ptr) as HRESULT
	GetObjectAsync as function(byval This as IWbemServices ptr, byval strObjectPath as const BSTR, byval lFlags as LONG, byval pCtx as IWbemContext ptr, byval pResponseHandler as IWbemObjectSink ptr) as HRESULT
	PutClass as function(byval This as IWbemServices ptr, byval pObject as IWbemClassObject ptr, byval lFlags as LONG, byval pCtx as IWbemContext ptr, byval ppCallResult as IWbemCallResult ptr ptr) as HRESULT
	PutClassAsync as function(byval This as IWbemServices ptr, byval pObject as IWbemClassObject ptr, byval lFlags as LONG, byval pCtx as IWbemContext ptr, byval pResponseHandler as IWbemObjectSink ptr) as HRESULT
	DeleteClass as function(byval This as IWbemServices ptr, byval strClass as const BSTR, byval lFlags as LONG, byval pCtx as IWbemContext ptr, byval ppCallResult as IWbemCallResult ptr ptr) as HRESULT
	DeleteClassAsync as function(byval This as IWbemServices ptr, byval strClass as const BSTR, byval lFlags as LONG, byval pCtx as IWbemContext ptr, byval pResponseHandler as IWbemObjectSink ptr) as HRESULT
	CreateClassEnum as function(byval This as IWbemServices ptr, byval strSuperclass as const BSTR, byval lFlags as LONG, byval pCtx as IWbemContext ptr, byval ppEnum as IEnumWbemClassObject ptr ptr) as HRESULT
	CreateClassEnumAsync as function(byval This as IWbemServices ptr, byval strSuperclass as const BSTR, byval lFlags as LONG, byval pCtx as IWbemContext ptr, byval pResponseHandler as IWbemObjectSink ptr) as HRESULT
	PutInstance as function(byval This as IWbemServices ptr, byval pInst as IWbemClassObject ptr, byval lFlags as LONG, byval pCtx as IWbemContext ptr, byval ppCallResult as IWbemCallResult ptr ptr) as HRESULT
	PutInstanceAsync as function(byval This as IWbemServices ptr, byval pInst as IWbemClassObject ptr, byval lFlags as LONG, byval pCtx as IWbemContext ptr, byval pResponseHandler as IWbemObjectSink ptr) as HRESULT
	DeleteInstance as function(byval This as IWbemServices ptr, byval strObjectPath as const BSTR, byval lFlags as LONG, byval pCtx as IWbemContext ptr, byval ppCallResult as IWbemCallResult ptr ptr) as HRESULT
	DeleteInstanceAsync as function(byval This as IWbemServices ptr, byval strObjectPath as const BSTR, byval lFlags as LONG, byval pCtx as IWbemContext ptr, byval pResponseHandler as IWbemObjectSink ptr) as HRESULT
	CreateInstanceEnum as function(byval This as IWbemServices ptr, byval strFilter as const BSTR, byval lFlags as LONG, byval pCtx as IWbemContext ptr, byval ppEnum as IEnumWbemClassObject ptr ptr) as HRESULT
	CreateInstanceEnumAsync as function(byval This as IWbemServices ptr, byval strFilter as const BSTR, byval lFlags as LONG, byval pCtx as IWbemContext ptr, byval pResponseHandler as IWbemObjectSink ptr) as HRESULT
	ExecQuery as function(byval This as IWbemServices ptr, byval strQueryLanguage as const BSTR, byval strQuery as const BSTR, byval lFlags as LONG, byval pCtx as IWbemContext ptr, byval ppEnum as IEnumWbemClassObject ptr ptr) as HRESULT
	ExecQueryAsync as function(byval This as IWbemServices ptr, byval strQueryLanguage as const BSTR, byval strQuery as const BSTR, byval lFlags as LONG, byval pCtx as IWbemContext ptr, byval pResponseHandler as IWbemObjectSink ptr) as HRESULT
	ExecNotificationQuery as function(byval This as IWbemServices ptr, byval strQueryLanguage as const BSTR, byval strQuery as const BSTR, byval lFlags as LONG, byval pCtx as IWbemContext ptr, byval ppEnum as IEnumWbemClassObject ptr ptr) as HRESULT
	ExecNotificationQueryAsync as function(byval This as IWbemServices ptr, byval strQueryLanguage as const BSTR, byval strQuery as const BSTR, byval lFlags as LONG, byval pCtx as IWbemContext ptr, byval pResponseHandler as IWbemObjectSink ptr) as HRESULT
	ExecMethod as function(byval This as IWbemServices ptr, byval strObjectPath as const BSTR, byval strMethodName as const BSTR, byval lFlags as LONG, byval pCtx as IWbemContext ptr, byval pInParams as IWbemClassObject ptr, byval ppOutParams as IWbemClassObject ptr ptr, byval ppCallResult as IWbemCallResult ptr ptr) as HRESULT
	ExecMethodAsync as function(byval This as IWbemServices ptr, byval strObjectPath as const BSTR, byval strMethodName as const BSTR, byval lFlags as LONG, byval pCtx as IWbemContext ptr, byval pInParams as IWbemClassObject ptr, byval pResponseHandler as IWbemObjectSink ptr) as HRESULT
end type

type IWbemServices_
	lpVtbl as IWbemServicesVtbl ptr
end type

#define IWbemServices_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IWbemServices_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IWbemServices_Release(This) (This)->lpVtbl->Release(This)
#define IWbemServices_OpenNamespace(This, strNamespace, lFlags, pCtx, ppWorkingNamespace, ppResult) (This)->lpVtbl->OpenNamespace(This, strNamespace, lFlags, pCtx, ppWorkingNamespace, ppResult)
#define IWbemServices_CancelAsyncCall(This, pSink) (This)->lpVtbl->CancelAsyncCall(This, pSink)
#define IWbemServices_QueryObjectSink(This, lFlags, ppResponseHandler) (This)->lpVtbl->QueryObjectSink(This, lFlags, ppResponseHandler)
#define IWbemServices_GetObject(This, strObjectPath, lFlags, pCtx, ppObject, ppCallResult) (This)->lpVtbl->GetObject(This, strObjectPath, lFlags, pCtx, ppObject, ppCallResult)
#define IWbemServices_GetObjectAsync(This, strObjectPath, lFlags, pCtx, pResponseHandler) (This)->lpVtbl->GetObjectAsync(This, strObjectPath, lFlags, pCtx, pResponseHandler)
#define IWbemServices_PutClass(This, pObject, lFlags, pCtx, ppCallResult) (This)->lpVtbl->PutClass(This, pObject, lFlags, pCtx, ppCallResult)
#define IWbemServices_PutClassAsync(This, pObject, lFlags, pCtx, pResponseHandler) (This)->lpVtbl->PutClassAsync(This, pObject, lFlags, pCtx, pResponseHandler)
#define IWbemServices_DeleteClass(This, strClass, lFlags, pCtx, ppCallResult) (This)->lpVtbl->DeleteClass(This, strClass, lFlags, pCtx, ppCallResult)
#define IWbemServices_DeleteClassAsync(This, strClass, lFlags, pCtx, pResponseHandler) (This)->lpVtbl->DeleteClassAsync(This, strClass, lFlags, pCtx, pResponseHandler)
#define IWbemServices_CreateClassEnum(This, strSuperclass, lFlags, pCtx, ppEnum) (This)->lpVtbl->CreateClassEnum(This, strSuperclass, lFlags, pCtx, ppEnum)
#define IWbemServices_CreateClassEnumAsync(This, strSuperclass, lFlags, pCtx, pResponseHandler) (This)->lpVtbl->CreateClassEnumAsync(This, strSuperclass, lFlags, pCtx, pResponseHandler)
#define IWbemServices_PutInstance(This, pInst, lFlags, pCtx, ppCallResult) (This)->lpVtbl->PutInstance(This, pInst, lFlags, pCtx, ppCallResult)
#define IWbemServices_PutInstanceAsync(This, pInst, lFlags, pCtx, pResponseHandler) (This)->lpVtbl->PutInstanceAsync(This, pInst, lFlags, pCtx, pResponseHandler)
#define IWbemServices_DeleteInstance(This, strObjectPath, lFlags, pCtx, ppCallResult) (This)->lpVtbl->DeleteInstance(This, strObjectPath, lFlags, pCtx, ppCallResult)
#define IWbemServices_DeleteInstanceAsync(This, strObjectPath, lFlags, pCtx, pResponseHandler) (This)->lpVtbl->DeleteInstanceAsync(This, strObjectPath, lFlags, pCtx, pResponseHandler)
#define IWbemServices_CreateInstanceEnum(This, strFilter, lFlags, pCtx, ppEnum) (This)->lpVtbl->CreateInstanceEnum(This, strFilter, lFlags, pCtx, ppEnum)
#define IWbemServices_CreateInstanceEnumAsync(This, strFilter, lFlags, pCtx, pResponseHandler) (This)->lpVtbl->CreateInstanceEnumAsync(This, strFilter, lFlags, pCtx, pResponseHandler)
#define IWbemServices_ExecQuery(This, strQueryLanguage, strQuery, lFlags, pCtx, ppEnum) (This)->lpVtbl->ExecQuery(This, strQueryLanguage, strQuery, lFlags, pCtx, ppEnum)
#define IWbemServices_ExecQueryAsync(This, strQueryLanguage, strQuery, lFlags, pCtx, pResponseHandler) (This)->lpVtbl->ExecQueryAsync(This, strQueryLanguage, strQuery, lFlags, pCtx, pResponseHandler)
#define IWbemServices_ExecNotificationQuery(This, strQueryLanguage, strQuery, lFlags, pCtx, ppEnum) (This)->lpVtbl->ExecNotificationQuery(This, strQueryLanguage, strQuery, lFlags, pCtx, ppEnum)
#define IWbemServices_ExecNotificationQueryAsync(This, strQueryLanguage, strQuery, lFlags, pCtx, pResponseHandler) (This)->lpVtbl->ExecNotificationQueryAsync(This, strQueryLanguage, strQuery, lFlags, pCtx, pResponseHandler)
#define IWbemServices_ExecMethod(This, strObjectPath, strMethodName, lFlags, pCtx, pInParams, ppOutParams, ppCallResult) (This)->lpVtbl->ExecMethod(This, strObjectPath, strMethodName, lFlags, pCtx, pInParams, ppOutParams, ppCallResult)
#define IWbemServices_ExecMethodAsync(This, strObjectPath, strMethodName, lFlags, pCtx, pInParams, pResponseHandler) (This)->lpVtbl->ExecMethodAsync(This, strObjectPath, strMethodName, lFlags, pCtx, pInParams, pResponseHandler)

declare function IWbemServices_OpenNamespace_Proxy(byval This as IWbemServices ptr, byval strNamespace as const BSTR, byval lFlags as LONG, byval pCtx as IWbemContext ptr, byval ppWorkingNamespace as IWbemServices ptr ptr, byval ppResult as IWbemCallResult ptr ptr) as HRESULT
declare sub IWbemServices_OpenNamespace_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemServices_CancelAsyncCall_Proxy(byval This as IWbemServices ptr, byval pSink as IWbemObjectSink ptr) as HRESULT
declare sub IWbemServices_CancelAsyncCall_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemServices_QueryObjectSink_Proxy(byval This as IWbemServices ptr, byval lFlags as LONG, byval ppResponseHandler as IWbemObjectSink ptr ptr) as HRESULT
declare sub IWbemServices_QueryObjectSink_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemServices_GetObject_Proxy(byval This as IWbemServices ptr, byval strObjectPath as const BSTR, byval lFlags as LONG, byval pCtx as IWbemContext ptr, byval ppObject as IWbemClassObject ptr ptr, byval ppCallResult as IWbemCallResult ptr ptr) as HRESULT
declare sub IWbemServices_GetObject_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemServices_GetObjectAsync_Proxy(byval This as IWbemServices ptr, byval strObjectPath as const BSTR, byval lFlags as LONG, byval pCtx as IWbemContext ptr, byval pResponseHandler as IWbemObjectSink ptr) as HRESULT
declare sub IWbemServices_GetObjectAsync_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemServices_PutClass_Proxy(byval This as IWbemServices ptr, byval pObject as IWbemClassObject ptr, byval lFlags as LONG, byval pCtx as IWbemContext ptr, byval ppCallResult as IWbemCallResult ptr ptr) as HRESULT
declare sub IWbemServices_PutClass_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemServices_PutClassAsync_Proxy(byval This as IWbemServices ptr, byval pObject as IWbemClassObject ptr, byval lFlags as LONG, byval pCtx as IWbemContext ptr, byval pResponseHandler as IWbemObjectSink ptr) as HRESULT
declare sub IWbemServices_PutClassAsync_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemServices_DeleteClass_Proxy(byval This as IWbemServices ptr, byval strClass as const BSTR, byval lFlags as LONG, byval pCtx as IWbemContext ptr, byval ppCallResult as IWbemCallResult ptr ptr) as HRESULT
declare sub IWbemServices_DeleteClass_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemServices_DeleteClassAsync_Proxy(byval This as IWbemServices ptr, byval strClass as const BSTR, byval lFlags as LONG, byval pCtx as IWbemContext ptr, byval pResponseHandler as IWbemObjectSink ptr) as HRESULT
declare sub IWbemServices_DeleteClassAsync_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemServices_CreateClassEnum_Proxy(byval This as IWbemServices ptr, byval strSuperclass as const BSTR, byval lFlags as LONG, byval pCtx as IWbemContext ptr, byval ppEnum as IEnumWbemClassObject ptr ptr) as HRESULT
declare sub IWbemServices_CreateClassEnum_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemServices_CreateClassEnumAsync_Proxy(byval This as IWbemServices ptr, byval strSuperclass as const BSTR, byval lFlags as LONG, byval pCtx as IWbemContext ptr, byval pResponseHandler as IWbemObjectSink ptr) as HRESULT
declare sub IWbemServices_CreateClassEnumAsync_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemServices_PutInstance_Proxy(byval This as IWbemServices ptr, byval pInst as IWbemClassObject ptr, byval lFlags as LONG, byval pCtx as IWbemContext ptr, byval ppCallResult as IWbemCallResult ptr ptr) as HRESULT
declare sub IWbemServices_PutInstance_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemServices_PutInstanceAsync_Proxy(byval This as IWbemServices ptr, byval pInst as IWbemClassObject ptr, byval lFlags as LONG, byval pCtx as IWbemContext ptr, byval pResponseHandler as IWbemObjectSink ptr) as HRESULT
declare sub IWbemServices_PutInstanceAsync_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemServices_DeleteInstance_Proxy(byval This as IWbemServices ptr, byval strObjectPath as const BSTR, byval lFlags as LONG, byval pCtx as IWbemContext ptr, byval ppCallResult as IWbemCallResult ptr ptr) as HRESULT
declare sub IWbemServices_DeleteInstance_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemServices_DeleteInstanceAsync_Proxy(byval This as IWbemServices ptr, byval strObjectPath as const BSTR, byval lFlags as LONG, byval pCtx as IWbemContext ptr, byval pResponseHandler as IWbemObjectSink ptr) as HRESULT
declare sub IWbemServices_DeleteInstanceAsync_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemServices_CreateInstanceEnum_Proxy(byval This as IWbemServices ptr, byval strFilter as const BSTR, byval lFlags as LONG, byval pCtx as IWbemContext ptr, byval ppEnum as IEnumWbemClassObject ptr ptr) as HRESULT
declare sub IWbemServices_CreateInstanceEnum_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemServices_CreateInstanceEnumAsync_Proxy(byval This as IWbemServices ptr, byval strFilter as const BSTR, byval lFlags as LONG, byval pCtx as IWbemContext ptr, byval pResponseHandler as IWbemObjectSink ptr) as HRESULT
declare sub IWbemServices_CreateInstanceEnumAsync_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemServices_ExecQuery_Proxy(byval This as IWbemServices ptr, byval strQueryLanguage as const BSTR, byval strQuery as const BSTR, byval lFlags as LONG, byval pCtx as IWbemContext ptr, byval ppEnum as IEnumWbemClassObject ptr ptr) as HRESULT
declare sub IWbemServices_ExecQuery_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemServices_ExecQueryAsync_Proxy(byval This as IWbemServices ptr, byval strQueryLanguage as const BSTR, byval strQuery as const BSTR, byval lFlags as LONG, byval pCtx as IWbemContext ptr, byval pResponseHandler as IWbemObjectSink ptr) as HRESULT
declare sub IWbemServices_ExecQueryAsync_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemServices_ExecNotificationQuery_Proxy(byval This as IWbemServices ptr, byval strQueryLanguage as const BSTR, byval strQuery as const BSTR, byval lFlags as LONG, byval pCtx as IWbemContext ptr, byval ppEnum as IEnumWbemClassObject ptr ptr) as HRESULT
declare sub IWbemServices_ExecNotificationQuery_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemServices_ExecNotificationQueryAsync_Proxy(byval This as IWbemServices ptr, byval strQueryLanguage as const BSTR, byval strQuery as const BSTR, byval lFlags as LONG, byval pCtx as IWbemContext ptr, byval pResponseHandler as IWbemObjectSink ptr) as HRESULT
declare sub IWbemServices_ExecNotificationQueryAsync_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemServices_ExecMethod_Proxy(byval This as IWbemServices ptr, byval strObjectPath as const BSTR, byval strMethodName as const BSTR, byval lFlags as LONG, byval pCtx as IWbemContext ptr, byval pInParams as IWbemClassObject ptr, byval ppOutParams as IWbemClassObject ptr ptr, byval ppCallResult as IWbemCallResult ptr ptr) as HRESULT
declare sub IWbemServices_ExecMethod_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemServices_ExecMethodAsync_Proxy(byval This as IWbemServices ptr, byval strObjectPath as const BSTR, byval strMethodName as const BSTR, byval lFlags as LONG, byval pCtx as IWbemContext ptr, byval pInParams as IWbemClassObject ptr, byval pResponseHandler as IWbemObjectSink ptr) as HRESULT
declare sub IWbemServices_ExecMethodAsync_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IWbemShutdown_INTERFACE_DEFINED__
extern IID_IWbemShutdown as const GUID
type IWbemShutdown as IWbemShutdown_

type IWbemShutdownVtbl
	QueryInterface as function(byval This as IWbemShutdown ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IWbemShutdown ptr) as ULONG
	Release as function(byval This as IWbemShutdown ptr) as ULONG
	Shutdown as function(byval This as IWbemShutdown ptr, byval uReason as LONG, byval uMaxMilliseconds as ULONG, byval pCtx as IWbemContext ptr) as HRESULT
end type

type IWbemShutdown_
	lpVtbl as IWbemShutdownVtbl ptr
end type

#define IWbemShutdown_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IWbemShutdown_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IWbemShutdown_Release(This) (This)->lpVtbl->Release(This)
#define IWbemShutdown_Shutdown(This, uReason, uMaxMilliseconds, pCtx) (This)->lpVtbl->Shutdown(This, uReason, uMaxMilliseconds, pCtx)
declare function IWbemShutdown_Shutdown_Proxy(byval This as IWbemShutdown ptr, byval uReason as LONG, byval uMaxMilliseconds as ULONG, byval pCtx as IWbemContext ptr) as HRESULT
declare sub IWbemShutdown_Shutdown_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IWbemObjectTextSrc_INTERFACE_DEFINED__
extern IID_IWbemObjectTextSrc as const GUID
type IWbemObjectTextSrc as IWbemObjectTextSrc_

type IWbemObjectTextSrcVtbl
	QueryInterface as function(byval This as IWbemObjectTextSrc ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IWbemObjectTextSrc ptr) as ULONG
	Release as function(byval This as IWbemObjectTextSrc ptr) as ULONG
	GetText as function(byval This as IWbemObjectTextSrc ptr, byval lFlags as LONG, byval pObj as IWbemClassObject ptr, byval uObjTextFormat as ULONG, byval pCtx as IWbemContext ptr, byval strText as BSTR ptr) as HRESULT
	CreateFromText as function(byval This as IWbemObjectTextSrc ptr, byval lFlags as LONG, byval strText as BSTR, byval uObjTextFormat as ULONG, byval pCtx as IWbemContext ptr, byval pNewObj as IWbemClassObject ptr ptr) as HRESULT
end type

type IWbemObjectTextSrc_
	lpVtbl as IWbemObjectTextSrcVtbl ptr
end type

#define IWbemObjectTextSrc_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IWbemObjectTextSrc_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IWbemObjectTextSrc_Release(This) (This)->lpVtbl->Release(This)
#define IWbemObjectTextSrc_GetText(This, lFlags, pObj, uObjTextFormat, pCtx, strText) (This)->lpVtbl->GetText(This, lFlags, pObj, uObjTextFormat, pCtx, strText)
#define IWbemObjectTextSrc_CreateFromText(This, lFlags, strText, uObjTextFormat, pCtx, pNewObj) (This)->lpVtbl->CreateFromText(This, lFlags, strText, uObjTextFormat, pCtx, pNewObj)

declare function IWbemObjectTextSrc_GetText_Proxy(byval This as IWbemObjectTextSrc ptr, byval lFlags as LONG, byval pObj as IWbemClassObject ptr, byval uObjTextFormat as ULONG, byval pCtx as IWbemContext ptr, byval strText as BSTR ptr) as HRESULT
declare sub IWbemObjectTextSrc_GetText_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemObjectTextSrc_CreateFromText_Proxy(byval This as IWbemObjectTextSrc ptr, byval lFlags as LONG, byval strText as BSTR, byval uObjTextFormat as ULONG, byval pCtx as IWbemContext ptr, byval pNewObj as IWbemClassObject ptr ptr) as HRESULT
declare sub IWbemObjectTextSrc_CreateFromText_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IWbemObjectAccess_INTERFACE_DEFINED__
extern IID_IWbemObjectAccess as const GUID
type IWbemObjectAccess as IWbemObjectAccess_

type IWbemObjectAccessVtbl
	QueryInterface as function(byval This as IWbemObjectAccess ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IWbemObjectAccess ptr) as ULONG
	Release as function(byval This as IWbemObjectAccess ptr) as ULONG
	GetQualifierSet as function(byval This as IWbemObjectAccess ptr, byval ppQualSet as IWbemQualifierSet ptr ptr) as HRESULT
	Get as function(byval This as IWbemObjectAccess ptr, byval wszName as LPCWSTR, byval lFlags as LONG, byval pVal as VARIANT ptr, byval pType as CIMTYPE ptr, byval plFlavor as LONG ptr) as HRESULT
	Put as function(byval This as IWbemObjectAccess ptr, byval wszName as LPCWSTR, byval lFlags as LONG, byval pVal as VARIANT ptr, byval Type as CIMTYPE) as HRESULT
	Delete_ as function(byval This as IWbemObjectAccess ptr, byval wszName as LPCWSTR) as HRESULT
	GetNames as function(byval This as IWbemObjectAccess ptr, byval wszQualifierName as LPCWSTR, byval lFlags as LONG, byval pQualifierVal as VARIANT ptr, byval pNames as SAFEARRAY ptr ptr) as HRESULT
	BeginEnumeration as function(byval This as IWbemObjectAccess ptr, byval lEnumFlags as LONG) as HRESULT
	Next as function(byval This as IWbemObjectAccess ptr, byval lFlags as LONG, byval strName as BSTR ptr, byval pVal as VARIANT ptr, byval pType as CIMTYPE ptr, byval plFlavor as LONG ptr) as HRESULT
	EndEnumeration as function(byval This as IWbemObjectAccess ptr) as HRESULT
	GetPropertyQualifierSet as function(byval This as IWbemObjectAccess ptr, byval wszProperty as LPCWSTR, byval ppQualSet as IWbemQualifierSet ptr ptr) as HRESULT
	Clone as function(byval This as IWbemObjectAccess ptr, byval ppCopy as IWbemClassObject ptr ptr) as HRESULT
	GetObjectText as function(byval This as IWbemObjectAccess ptr, byval lFlags as LONG, byval pstrObjectText as BSTR ptr) as HRESULT
	SpawnDerivedClass as function(byval This as IWbemObjectAccess ptr, byval lFlags as LONG, byval ppNewClass as IWbemClassObject ptr ptr) as HRESULT
	SpawnInstance as function(byval This as IWbemObjectAccess ptr, byval lFlags as LONG, byval ppNewInstance as IWbemClassObject ptr ptr) as HRESULT
	CompareTo as function(byval This as IWbemObjectAccess ptr, byval lFlags as LONG, byval pCompareTo as IWbemClassObject ptr) as HRESULT
	GetPropertyOrigin as function(byval This as IWbemObjectAccess ptr, byval wszName as LPCWSTR, byval pstrClassName as BSTR ptr) as HRESULT
	InheritsFrom as function(byval This as IWbemObjectAccess ptr, byval strAncestor as LPCWSTR) as HRESULT
	GetMethod as function(byval This as IWbemObjectAccess ptr, byval wszName as LPCWSTR, byval lFlags as LONG, byval ppInSignature as IWbemClassObject ptr ptr, byval ppOutSignature as IWbemClassObject ptr ptr) as HRESULT
	PutMethod as function(byval This as IWbemObjectAccess ptr, byval wszName as LPCWSTR, byval lFlags as LONG, byval pInSignature as IWbemClassObject ptr, byval pOutSignature as IWbemClassObject ptr) as HRESULT
	DeleteMethod as function(byval This as IWbemObjectAccess ptr, byval wszName as LPCWSTR) as HRESULT
	BeginMethodEnumeration as function(byval This as IWbemObjectAccess ptr, byval lEnumFlags as LONG) as HRESULT
	NextMethod as function(byval This as IWbemObjectAccess ptr, byval lFlags as LONG, byval pstrName as BSTR ptr, byval ppInSignature as IWbemClassObject ptr ptr, byval ppOutSignature as IWbemClassObject ptr ptr) as HRESULT
	EndMethodEnumeration as function(byval This as IWbemObjectAccess ptr) as HRESULT
	GetMethodQualifierSet as function(byval This as IWbemObjectAccess ptr, byval wszMethod as LPCWSTR, byval ppQualSet as IWbemQualifierSet ptr ptr) as HRESULT
	GetMethodOrigin as function(byval This as IWbemObjectAccess ptr, byval wszMethodName as LPCWSTR, byval pstrClassName as BSTR ptr) as HRESULT
	GetPropertyHandle as function(byval This as IWbemObjectAccess ptr, byval wszPropertyName as LPCWSTR, byval pType as CIMTYPE ptr, byval plHandle as LONG ptr) as HRESULT
	WritePropertyValue as function(byval This as IWbemObjectAccess ptr, byval lHandle as LONG, byval lNumBytes as LONG, byval aData as const ubyte ptr) as HRESULT
	ReadPropertyValue as function(byval This as IWbemObjectAccess ptr, byval lHandle as LONG, byval lBufferSize as LONG, byval plNumBytes as LONG ptr, byval aData as ubyte ptr) as HRESULT
	ReadDWORD as function(byval This as IWbemObjectAccess ptr, byval lHandle as LONG, byval pdw as DWORD ptr) as HRESULT
	WriteDWORD as function(byval This as IWbemObjectAccess ptr, byval lHandle as LONG, byval dw as DWORD) as HRESULT
	ReadQWORD as function(byval This as IWbemObjectAccess ptr, byval lHandle as LONG, byval pqw as UINT64 ptr) as HRESULT
	WriteQWORD as function(byval This as IWbemObjectAccess ptr, byval lHandle as LONG, byval pw as UINT64) as HRESULT
	GetPropertyInfoByHandle as function(byval This as IWbemObjectAccess ptr, byval lHandle as LONG, byval pstrName as BSTR ptr, byval pType as CIMTYPE ptr) as HRESULT
	Lock as function(byval This as IWbemObjectAccess ptr, byval lFlags as LONG) as HRESULT
	Unlock as function(byval This as IWbemObjectAccess ptr, byval lFlags as LONG) as HRESULT
end type

type IWbemObjectAccess_
	lpVtbl as IWbemObjectAccessVtbl ptr
end type

#define IWbemObjectAccess_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IWbemObjectAccess_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IWbemObjectAccess_Release(This) (This)->lpVtbl->Release(This)
#define IWbemObjectAccess_GetQualifierSet(This, ppQualSet) (This)->lpVtbl->GetQualifierSet(This, ppQualSet)
#define IWbemObjectAccess_Get(This, wszName, lFlags, pVal, pType, plFlavor) (This)->lpVtbl->Get(This, wszName, lFlags, pVal, pType, plFlavor)
#define IWbemObjectAccess_Put(This, wszName, lFlags, pVal, Type) (This)->lpVtbl->Put(This, wszName, lFlags, pVal, Type)
#define IWbemObjectAccess_Delete(This, wszName) (This)->lpVtbl->Delete_(This, wszName)
#define IWbemObjectAccess_GetNames(This, wszQualifierName, lFlags, pQualifierVal, pNames) (This)->lpVtbl->GetNames(This, wszQualifierName, lFlags, pQualifierVal, pNames)
#define IWbemObjectAccess_BeginEnumeration(This, lEnumFlags) (This)->lpVtbl->BeginEnumeration(This, lEnumFlags)
#define IWbemObjectAccess_Next(This, lFlags, strName, pVal, pType, plFlavor) (This)->lpVtbl->Next(This, lFlags, strName, pVal, pType, plFlavor)
#define IWbemObjectAccess_EndEnumeration(This) (This)->lpVtbl->EndEnumeration(This)
#define IWbemObjectAccess_GetPropertyQualifierSet(This, wszProperty, ppQualSet) (This)->lpVtbl->GetPropertyQualifierSet(This, wszProperty, ppQualSet)
#define IWbemObjectAccess_Clone(This, ppCopy) (This)->lpVtbl->Clone(This, ppCopy)
#define IWbemObjectAccess_GetObjectText(This, lFlags, pstrObjectText) (This)->lpVtbl->GetObjectText(This, lFlags, pstrObjectText)
#define IWbemObjectAccess_SpawnDerivedClass(This, lFlags, ppNewClass) (This)->lpVtbl->SpawnDerivedClass(This, lFlags, ppNewClass)
#define IWbemObjectAccess_SpawnInstance(This, lFlags, ppNewInstance) (This)->lpVtbl->SpawnInstance(This, lFlags, ppNewInstance)
#define IWbemObjectAccess_CompareTo(This, lFlags, pCompareTo) (This)->lpVtbl->CompareTo(This, lFlags, pCompareTo)
#define IWbemObjectAccess_GetPropertyOrigin(This, wszName, pstrClassName) (This)->lpVtbl->GetPropertyOrigin(This, wszName, pstrClassName)
#define IWbemObjectAccess_InheritsFrom(This, strAncestor) (This)->lpVtbl->InheritsFrom(This, strAncestor)
#define IWbemObjectAccess_GetMethod(This, wszName, lFlags, ppInSignature, ppOutSignature) (This)->lpVtbl->GetMethod(This, wszName, lFlags, ppInSignature, ppOutSignature)
#define IWbemObjectAccess_PutMethod(This, wszName, lFlags, pInSignature, pOutSignature) (This)->lpVtbl->PutMethod(This, wszName, lFlags, pInSignature, pOutSignature)
#define IWbemObjectAccess_DeleteMethod(This, wszName) (This)->lpVtbl->DeleteMethod(This, wszName)
#define IWbemObjectAccess_BeginMethodEnumeration(This, lEnumFlags) (This)->lpVtbl->BeginMethodEnumeration(This, lEnumFlags)
#define IWbemObjectAccess_NextMethod(This, lFlags, pstrName, ppInSignature, ppOutSignature) (This)->lpVtbl->NextMethod(This, lFlags, pstrName, ppInSignature, ppOutSignature)
#define IWbemObjectAccess_EndMethodEnumeration(This) (This)->lpVtbl->EndMethodEnumeration(This)
#define IWbemObjectAccess_GetMethodQualifierSet(This, wszMethod, ppQualSet) (This)->lpVtbl->GetMethodQualifierSet(This, wszMethod, ppQualSet)
#define IWbemObjectAccess_GetMethodOrigin(This, wszMethodName, pstrClassName) (This)->lpVtbl->GetMethodOrigin(This, wszMethodName, pstrClassName)
#define IWbemObjectAccess_GetPropertyHandle(This, wszPropertyName, pType, plHandle) (This)->lpVtbl->GetPropertyHandle(This, wszPropertyName, pType, plHandle)
#define IWbemObjectAccess_WritePropertyValue(This, lHandle, lNumBytes, aData) (This)->lpVtbl->WritePropertyValue(This, lHandle, lNumBytes, aData)
#define IWbemObjectAccess_ReadPropertyValue(This, lHandle, lBufferSize, plNumBytes, aData) (This)->lpVtbl->ReadPropertyValue(This, lHandle, lBufferSize, plNumBytes, aData)
#define IWbemObjectAccess_ReadDWORD(This, lHandle, pdw) (This)->lpVtbl->ReadDWORD(This, lHandle, pdw)
#define IWbemObjectAccess_WriteDWORD(This, lHandle, dw) (This)->lpVtbl->WriteDWORD(This, lHandle, dw)
#define IWbemObjectAccess_ReadQWORD(This, lHandle, pqw) (This)->lpVtbl->ReadQWORD(This, lHandle, pqw)
#define IWbemObjectAccess_WriteQWORD(This, lHandle, pw) (This)->lpVtbl->WriteQWORD(This, lHandle, pw)
#define IWbemObjectAccess_GetPropertyInfoByHandle(This, lHandle, pstrName, pType) (This)->lpVtbl->GetPropertyInfoByHandle(This, lHandle, pstrName, pType)
#define IWbemObjectAccess_Lock(This, lFlags) (This)->lpVtbl->Lock(This, lFlags)
#define IWbemObjectAccess_Unlock(This, lFlags) (This)->lpVtbl->Unlock(This, lFlags)

declare function IWbemObjectAccess_GetPropertyHandle_Proxy(byval This as IWbemObjectAccess ptr, byval wszPropertyName as LPCWSTR, byval pType as CIMTYPE ptr, byval plHandle as LONG ptr) as HRESULT
declare sub IWbemObjectAccess_GetPropertyHandle_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemObjectAccess_WritePropertyValue_Proxy(byval This as IWbemObjectAccess ptr, byval lHandle as LONG, byval lNumBytes as LONG, byval aData as const ubyte ptr) as HRESULT
declare sub IWbemObjectAccess_WritePropertyValue_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemObjectAccess_ReadPropertyValue_Proxy(byval This as IWbemObjectAccess ptr, byval lHandle as LONG, byval lBufferSize as LONG, byval plNumBytes as LONG ptr, byval aData as ubyte ptr) as HRESULT
declare sub IWbemObjectAccess_ReadPropertyValue_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemObjectAccess_ReadDWORD_Proxy(byval This as IWbemObjectAccess ptr, byval lHandle as LONG, byval pdw as DWORD ptr) as HRESULT
declare sub IWbemObjectAccess_ReadDWORD_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemObjectAccess_WriteDWORD_Proxy(byval This as IWbemObjectAccess ptr, byval lHandle as LONG, byval dw as DWORD) as HRESULT
declare sub IWbemObjectAccess_WriteDWORD_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemObjectAccess_ReadQWORD_Proxy(byval This as IWbemObjectAccess ptr, byval lHandle as LONG, byval pqw as UINT64 ptr) as HRESULT
declare sub IWbemObjectAccess_ReadQWORD_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemObjectAccess_WriteQWORD_Proxy(byval This as IWbemObjectAccess ptr, byval lHandle as LONG, byval pw as UINT64) as HRESULT
declare sub IWbemObjectAccess_WriteQWORD_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemObjectAccess_GetPropertyInfoByHandle_Proxy(byval This as IWbemObjectAccess ptr, byval lHandle as LONG, byval pstrName as BSTR ptr, byval pType as CIMTYPE ptr) as HRESULT
declare sub IWbemObjectAccess_GetPropertyInfoByHandle_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemObjectAccess_Lock_Proxy(byval This as IWbemObjectAccess ptr, byval lFlags as LONG) as HRESULT
declare sub IWbemObjectAccess_Lock_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemObjectAccess_Unlock_Proxy(byval This as IWbemObjectAccess ptr, byval lFlags as LONG) as HRESULT
declare sub IWbemObjectAccess_Unlock_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IMofCompiler_INTERFACE_DEFINED__
extern IID_IMofCompiler as const GUID
type IMofCompiler as IMofCompiler_

type IMofCompilerVtbl
	QueryInterface as function(byval This as IMofCompiler ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IMofCompiler ptr) as ULONG
	Release as function(byval This as IMofCompiler ptr) as ULONG
	CompileFile as function(byval This as IMofCompiler ptr, byval FileName as LPWSTR, byval ServerAndNamespace as LPWSTR, byval User as LPWSTR, byval Authority as LPWSTR, byval Password as LPWSTR, byval lOptionFlags as LONG, byval lClassFlags as LONG, byval lInstanceFlags as LONG, byval pInfo as WBEM_COMPILE_STATUS_INFO ptr) as HRESULT
	CompileBuffer as function(byval This as IMofCompiler ptr, byval BuffSize as LONG, byval pBuffer as UBYTE ptr, byval ServerAndNamespace as LPWSTR, byval User as LPWSTR, byval Authority as LPWSTR, byval Password as LPWSTR, byval lOptionFlags as LONG, byval lClassFlags as LONG, byval lInstanceFlags as LONG, byval pInfo as WBEM_COMPILE_STATUS_INFO ptr) as HRESULT
	CreateBMOF as function(byval This as IMofCompiler ptr, byval TextFileName as LPWSTR, byval BMOFFileName as LPWSTR, byval ServerAndNamespace as LPWSTR, byval lOptionFlags as LONG, byval lClassFlags as LONG, byval lInstanceFlags as LONG, byval pInfo as WBEM_COMPILE_STATUS_INFO ptr) as HRESULT
end type

type IMofCompiler_
	lpVtbl as IMofCompilerVtbl ptr
end type

#define IMofCompiler_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IMofCompiler_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IMofCompiler_Release(This) (This)->lpVtbl->Release(This)
#define IMofCompiler_CompileFile(This, FileName, ServerAndNamespace, User, Authority, Password, lOptionFlags, lClassFlags, lInstanceFlags, pInfo) (This)->lpVtbl->CompileFile(This, FileName, ServerAndNamespace, User, Authority, Password, lOptionFlags, lClassFlags, lInstanceFlags, pInfo)
#define IMofCompiler_CompileBuffer(This, BuffSize, pBuffer, ServerAndNamespace, User, Authority, Password, lOptionFlags, lClassFlags, lInstanceFlags, pInfo) (This)->lpVtbl->CompileBuffer(This, BuffSize, pBuffer, ServerAndNamespace, User, Authority, Password, lOptionFlags, lClassFlags, lInstanceFlags, pInfo)
#define IMofCompiler_CreateBMOF(This, TextFileName, BMOFFileName, ServerAndNamespace, lOptionFlags, lClassFlags, lInstanceFlags, pInfo) (This)->lpVtbl->CreateBMOF(This, TextFileName, BMOFFileName, ServerAndNamespace, lOptionFlags, lClassFlags, lInstanceFlags, pInfo)

declare function IMofCompiler_CompileFile_Proxy(byval This as IMofCompiler ptr, byval FileName as LPWSTR, byval ServerAndNamespace as LPWSTR, byval User as LPWSTR, byval Authority as LPWSTR, byval Password as LPWSTR, byval lOptionFlags as LONG, byval lClassFlags as LONG, byval lInstanceFlags as LONG, byval pInfo as WBEM_COMPILE_STATUS_INFO ptr) as HRESULT
declare sub IMofCompiler_CompileFile_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMofCompiler_CompileBuffer_Proxy(byval This as IMofCompiler ptr, byval BuffSize as LONG, byval pBuffer as UBYTE ptr, byval ServerAndNamespace as LPWSTR, byval User as LPWSTR, byval Authority as LPWSTR, byval Password as LPWSTR, byval lOptionFlags as LONG, byval lClassFlags as LONG, byval lInstanceFlags as LONG, byval pInfo as WBEM_COMPILE_STATUS_INFO ptr) as HRESULT
declare sub IMofCompiler_CompileBuffer_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IMofCompiler_CreateBMOF_Proxy(byval This as IMofCompiler ptr, byval TextFileName as LPWSTR, byval BMOFFileName as LPWSTR, byval ServerAndNamespace as LPWSTR, byval lOptionFlags as LONG, byval lClassFlags as LONG, byval lInstanceFlags as LONG, byval pInfo as WBEM_COMPILE_STATUS_INFO ptr) as HRESULT
declare sub IMofCompiler_CreateBMOF_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IUnsecuredApartment_INTERFACE_DEFINED__
extern IID_IUnsecuredApartment as const GUID
type IUnsecuredApartment as IUnsecuredApartment_

type IUnsecuredApartmentVtbl
	QueryInterface as function(byval This as IUnsecuredApartment ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IUnsecuredApartment ptr) as ULONG
	Release as function(byval This as IUnsecuredApartment ptr) as ULONG
	CreateObjectStub as function(byval This as IUnsecuredApartment ptr, byval pObject as IUnknown ptr, byval ppStub as IUnknown ptr ptr) as HRESULT
end type

type IUnsecuredApartment_
	lpVtbl as IUnsecuredApartmentVtbl ptr
end type

#define IUnsecuredApartment_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IUnsecuredApartment_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IUnsecuredApartment_Release(This) (This)->lpVtbl->Release(This)
#define IUnsecuredApartment_CreateObjectStub(This, pObject, ppStub) (This)->lpVtbl->CreateObjectStub(This, pObject, ppStub)
declare function IUnsecuredApartment_CreateObjectStub_Proxy(byval This as IUnsecuredApartment ptr, byval pObject as IUnknown ptr, byval ppStub as IUnknown ptr ptr) as HRESULT
declare sub IUnsecuredApartment_CreateObjectStub_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IWbemUnsecuredApartment_INTERFACE_DEFINED__
extern IID_IWbemUnsecuredApartment as const GUID
type IWbemUnsecuredApartment as IWbemUnsecuredApartment_

type IWbemUnsecuredApartmentVtbl
	QueryInterface as function(byval This as IWbemUnsecuredApartment ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IWbemUnsecuredApartment ptr) as ULONG
	Release as function(byval This as IWbemUnsecuredApartment ptr) as ULONG
	CreateObjectStub as function(byval This as IWbemUnsecuredApartment ptr, byval pObject as IUnknown ptr, byval ppStub as IUnknown ptr ptr) as HRESULT
	CreateSinkStub as function(byval This as IWbemUnsecuredApartment ptr, byval pSink as IWbemObjectSink ptr, byval dwFlags as DWORD, byval wszReserved as LPCWSTR, byval ppStub as IWbemObjectSink ptr ptr) as HRESULT
end type

type IWbemUnsecuredApartment_
	lpVtbl as IWbemUnsecuredApartmentVtbl ptr
end type

#define IWbemUnsecuredApartment_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IWbemUnsecuredApartment_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IWbemUnsecuredApartment_Release(This) (This)->lpVtbl->Release(This)
#define IWbemUnsecuredApartment_CreateObjectStub(This, pObject, ppStub) (This)->lpVtbl->CreateObjectStub(This, pObject, ppStub)
#define IWbemUnsecuredApartment_CreateSinkStub(This, pSink, dwFlags, wszReserved, ppStub) (This)->lpVtbl->CreateSinkStub(This, pSink, dwFlags, wszReserved, ppStub)
declare function IWbemUnsecuredApartment_CreateSinkStub_Proxy(byval This as IWbemUnsecuredApartment ptr, byval pSink as IWbemObjectSink ptr, byval dwFlags as DWORD, byval wszReserved as LPCWSTR, byval ppStub as IWbemObjectSink ptr ptr) as HRESULT
declare sub IWbemUnsecuredApartment_CreateSinkStub_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IWbemStatusCodeText_INTERFACE_DEFINED__
extern IID_IWbemStatusCodeText as const GUID
type IWbemStatusCodeText as IWbemStatusCodeText_

type IWbemStatusCodeTextVtbl
	QueryInterface as function(byval This as IWbemStatusCodeText ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IWbemStatusCodeText ptr) as ULONG
	Release as function(byval This as IWbemStatusCodeText ptr) as ULONG
	GetErrorCodeText as function(byval This as IWbemStatusCodeText ptr, byval hRes as HRESULT, byval LocaleId as LCID, byval lFlags as LONG, byval MessageText as BSTR ptr) as HRESULT
	GetFacilityCodeText as function(byval This as IWbemStatusCodeText ptr, byval hRes as HRESULT, byval LocaleId as LCID, byval lFlags as LONG, byval MessageText as BSTR ptr) as HRESULT
end type

type IWbemStatusCodeText_
	lpVtbl as IWbemStatusCodeTextVtbl ptr
end type

#define IWbemStatusCodeText_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IWbemStatusCodeText_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IWbemStatusCodeText_Release(This) (This)->lpVtbl->Release(This)
#define IWbemStatusCodeText_GetErrorCodeText(This, hRes, LocaleId, lFlags, MessageText) (This)->lpVtbl->GetErrorCodeText(This, hRes, LocaleId, lFlags, MessageText)
#define IWbemStatusCodeText_GetFacilityCodeText(This, hRes, LocaleId, lFlags, MessageText) (This)->lpVtbl->GetFacilityCodeText(This, hRes, LocaleId, lFlags, MessageText)

declare function IWbemStatusCodeText_GetErrorCodeText_Proxy(byval This as IWbemStatusCodeText ptr, byval hRes as HRESULT, byval LocaleId as LCID, byval lFlags as LONG, byval MessageText as BSTR ptr) as HRESULT
declare sub IWbemStatusCodeText_GetErrorCodeText_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemStatusCodeText_GetFacilityCodeText_Proxy(byval This as IWbemStatusCodeText ptr, byval hRes as HRESULT, byval LocaleId as LCID, byval lFlags as LONG, byval MessageText as BSTR ptr) as HRESULT
declare sub IWbemStatusCodeText_GetFacilityCodeText_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IWbemBackupRestore_INTERFACE_DEFINED__
extern IID_IWbemBackupRestore as const GUID
type IWbemBackupRestore as IWbemBackupRestore_

type IWbemBackupRestoreVtbl
	QueryInterface as function(byval This as IWbemBackupRestore ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IWbemBackupRestore ptr) as ULONG
	Release as function(byval This as IWbemBackupRestore ptr) as ULONG
	Backup as function(byval This as IWbemBackupRestore ptr, byval strBackupToFile as LPCWSTR, byval lFlags as LONG) as HRESULT
	Restore as function(byval This as IWbemBackupRestore ptr, byval strRestoreFromFile as LPCWSTR, byval lFlags as LONG) as HRESULT
end type

type IWbemBackupRestore_
	lpVtbl as IWbemBackupRestoreVtbl ptr
end type

#define IWbemBackupRestore_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IWbemBackupRestore_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IWbemBackupRestore_Release(This) (This)->lpVtbl->Release(This)
#define IWbemBackupRestore_Backup(This, strBackupToFile, lFlags) (This)->lpVtbl->Backup(This, strBackupToFile, lFlags)
#define IWbemBackupRestore_Restore(This, strRestoreFromFile, lFlags) (This)->lpVtbl->Restore(This, strRestoreFromFile, lFlags)

declare function IWbemBackupRestore_Backup_Proxy(byval This as IWbemBackupRestore ptr, byval strBackupToFile as LPCWSTR, byval lFlags as LONG) as HRESULT
declare sub IWbemBackupRestore_Backup_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemBackupRestore_Restore_Proxy(byval This as IWbemBackupRestore ptr, byval strRestoreFromFile as LPCWSTR, byval lFlags as LONG) as HRESULT
declare sub IWbemBackupRestore_Restore_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IWbemBackupRestoreEx_INTERFACE_DEFINED__
extern IID_IWbemBackupRestoreEx as const GUID
type IWbemBackupRestoreEx as IWbemBackupRestoreEx_

type IWbemBackupRestoreExVtbl
	QueryInterface as function(byval This as IWbemBackupRestoreEx ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IWbemBackupRestoreEx ptr) as ULONG
	Release as function(byval This as IWbemBackupRestoreEx ptr) as ULONG
	Backup as function(byval This as IWbemBackupRestoreEx ptr, byval strBackupToFile as LPCWSTR, byval lFlags as LONG) as HRESULT
	Restore as function(byval This as IWbemBackupRestoreEx ptr, byval strRestoreFromFile as LPCWSTR, byval lFlags as LONG) as HRESULT
	Pause as function(byval This as IWbemBackupRestoreEx ptr) as HRESULT
	Resume as function(byval This as IWbemBackupRestoreEx ptr) as HRESULT
end type

type IWbemBackupRestoreEx_
	lpVtbl as IWbemBackupRestoreExVtbl ptr
end type

#define IWbemBackupRestoreEx_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IWbemBackupRestoreEx_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IWbemBackupRestoreEx_Release(This) (This)->lpVtbl->Release(This)
#define IWbemBackupRestoreEx_Backup(This, strBackupToFile, lFlags) (This)->lpVtbl->Backup(This, strBackupToFile, lFlags)
#define IWbemBackupRestoreEx_Restore(This, strRestoreFromFile, lFlags) (This)->lpVtbl->Restore(This, strRestoreFromFile, lFlags)
#define IWbemBackupRestoreEx_Pause(This) (This)->lpVtbl->Pause(This)
#define IWbemBackupRestoreEx_Resume(This) (This)->lpVtbl->Resume(This)

declare function IWbemBackupRestoreEx_Pause_Proxy(byval This as IWbemBackupRestoreEx ptr) as HRESULT
declare sub IWbemBackupRestoreEx_Pause_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemBackupRestoreEx_Resume_Proxy(byval This as IWbemBackupRestoreEx ptr) as HRESULT
declare sub IWbemBackupRestoreEx_Resume_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IWbemRefresher_INTERFACE_DEFINED__
extern IID_IWbemRefresher as const GUID
type IWbemRefresher as IWbemRefresher_

type IWbemRefresherVtbl
	QueryInterface as function(byval This as IWbemRefresher ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IWbemRefresher ptr) as ULONG
	Release as function(byval This as IWbemRefresher ptr) as ULONG
	Refresh as function(byval This as IWbemRefresher ptr, byval lFlags as LONG) as HRESULT
end type

type IWbemRefresher_
	lpVtbl as IWbemRefresherVtbl ptr
end type

#define IWbemRefresher_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IWbemRefresher_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IWbemRefresher_Release(This) (This)->lpVtbl->Release(This)
#define IWbemRefresher_Refresh(This, lFlags) (This)->lpVtbl->Refresh(This, lFlags)
declare function IWbemRefresher_Refresh_Proxy(byval This as IWbemRefresher ptr, byval lFlags as LONG) as HRESULT
declare sub IWbemRefresher_Refresh_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IWbemHiPerfEnum_INTERFACE_DEFINED__
extern IID_IWbemHiPerfEnum as const GUID
type IWbemHiPerfEnum as IWbemHiPerfEnum_

type IWbemHiPerfEnumVtbl
	QueryInterface as function(byval This as IWbemHiPerfEnum ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IWbemHiPerfEnum ptr) as ULONG
	Release as function(byval This as IWbemHiPerfEnum ptr) as ULONG
	AddObjects as function(byval This as IWbemHiPerfEnum ptr, byval lFlags as LONG, byval uNumObjects as ULONG, byval apIds as LONG ptr, byval apObj as IWbemObjectAccess ptr ptr) as HRESULT
	RemoveObjects as function(byval This as IWbemHiPerfEnum ptr, byval lFlags as LONG, byval uNumObjects as ULONG, byval apIds as LONG ptr) as HRESULT
	GetObjects as function(byval This as IWbemHiPerfEnum ptr, byval lFlags as LONG, byval uNumObjects as ULONG, byval apObj as IWbemObjectAccess ptr ptr, byval puReturned as ULONG ptr) as HRESULT
	RemoveAll as function(byval This as IWbemHiPerfEnum ptr, byval lFlags as LONG) as HRESULT
end type

type IWbemHiPerfEnum_
	lpVtbl as IWbemHiPerfEnumVtbl ptr
end type

#define IWbemHiPerfEnum_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IWbemHiPerfEnum_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IWbemHiPerfEnum_Release(This) (This)->lpVtbl->Release(This)
#define IWbemHiPerfEnum_AddObjects(This, lFlags, uNumObjects, apIds, apObj) (This)->lpVtbl->AddObjects(This, lFlags, uNumObjects, apIds, apObj)
#define IWbemHiPerfEnum_RemoveObjects(This, lFlags, uNumObjects, apIds) (This)->lpVtbl->RemoveObjects(This, lFlags, uNumObjects, apIds)
#define IWbemHiPerfEnum_GetObjects(This, lFlags, uNumObjects, apObj, puReturned) (This)->lpVtbl->GetObjects(This, lFlags, uNumObjects, apObj, puReturned)
#define IWbemHiPerfEnum_RemoveAll(This, lFlags) (This)->lpVtbl->RemoveAll(This, lFlags)

declare function IWbemHiPerfEnum_AddObjects_Proxy(byval This as IWbemHiPerfEnum ptr, byval lFlags as LONG, byval uNumObjects as ULONG, byval apIds as LONG ptr, byval apObj as IWbemObjectAccess ptr ptr) as HRESULT
declare sub IWbemHiPerfEnum_AddObjects_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemHiPerfEnum_RemoveObjects_Proxy(byval This as IWbemHiPerfEnum ptr, byval lFlags as LONG, byval uNumObjects as ULONG, byval apIds as LONG ptr) as HRESULT
declare sub IWbemHiPerfEnum_RemoveObjects_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemHiPerfEnum_GetObjects_Proxy(byval This as IWbemHiPerfEnum ptr, byval lFlags as LONG, byval uNumObjects as ULONG, byval apObj as IWbemObjectAccess ptr ptr, byval puReturned as ULONG ptr) as HRESULT
declare sub IWbemHiPerfEnum_GetObjects_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemHiPerfEnum_RemoveAll_Proxy(byval This as IWbemHiPerfEnum ptr, byval lFlags as LONG) as HRESULT
declare sub IWbemHiPerfEnum_RemoveAll_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IWbemConfigureRefresher_INTERFACE_DEFINED__
extern IID_IWbemConfigureRefresher as const GUID
type IWbemConfigureRefresher as IWbemConfigureRefresher_

type IWbemConfigureRefresherVtbl
	QueryInterface as function(byval This as IWbemConfigureRefresher ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IWbemConfigureRefresher ptr) as ULONG
	Release as function(byval This as IWbemConfigureRefresher ptr) as ULONG
	AddObjectByPath as function(byval This as IWbemConfigureRefresher ptr, byval pNamespace as IWbemServices ptr, byval wszPath as LPCWSTR, byval lFlags as LONG, byval pContext as IWbemContext ptr, byval ppRefreshable as IWbemClassObject ptr ptr, byval plId as LONG ptr) as HRESULT
	AddObjectByTemplate as function(byval This as IWbemConfigureRefresher ptr, byval pNamespace as IWbemServices ptr, byval pTemplate as IWbemClassObject ptr, byval lFlags as LONG, byval pContext as IWbemContext ptr, byval ppRefreshable as IWbemClassObject ptr ptr, byval plId as LONG ptr) as HRESULT
	AddRefresher as function(byval This as IWbemConfigureRefresher ptr, byval pRefresher as IWbemRefresher ptr, byval lFlags as LONG, byval plId as LONG ptr) as HRESULT
	Remove as function(byval This as IWbemConfigureRefresher ptr, byval lId as LONG, byval lFlags as LONG) as HRESULT
	AddEnum as function(byval This as IWbemConfigureRefresher ptr, byval pNamespace as IWbemServices ptr, byval wszClassName as LPCWSTR, byval lFlags as LONG, byval pContext as IWbemContext ptr, byval ppEnum as IWbemHiPerfEnum ptr ptr, byval plId as LONG ptr) as HRESULT
end type

type IWbemConfigureRefresher_
	lpVtbl as IWbemConfigureRefresherVtbl ptr
end type

#define IWbemConfigureRefresher_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IWbemConfigureRefresher_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IWbemConfigureRefresher_Release(This) (This)->lpVtbl->Release(This)
#define IWbemConfigureRefresher_AddObjectByPath(This, pNamespace, wszPath, lFlags, pContext, ppRefreshable, plId) (This)->lpVtbl->AddObjectByPath(This, pNamespace, wszPath, lFlags, pContext, ppRefreshable, plId)
#define IWbemConfigureRefresher_AddObjectByTemplate(This, pNamespace, pTemplate, lFlags, pContext, ppRefreshable, plId) (This)->lpVtbl->AddObjectByTemplate(This, pNamespace, pTemplate, lFlags, pContext, ppRefreshable, plId)
#define IWbemConfigureRefresher_AddRefresher(This, pRefresher, lFlags, plId) (This)->lpVtbl->AddRefresher(This, pRefresher, lFlags, plId)
#define IWbemConfigureRefresher_Remove(This, lId, lFlags) (This)->lpVtbl->Remove(This, lId, lFlags)
#define IWbemConfigureRefresher_AddEnum(This, pNamespace, wszClassName, lFlags, pContext, ppEnum, plId) (This)->lpVtbl->AddEnum(This, pNamespace, wszClassName, lFlags, pContext, ppEnum, plId)

declare function IWbemConfigureRefresher_AddObjectByPath_Proxy(byval This as IWbemConfigureRefresher ptr, byval pNamespace as IWbemServices ptr, byval wszPath as LPCWSTR, byval lFlags as LONG, byval pContext as IWbemContext ptr, byval ppRefreshable as IWbemClassObject ptr ptr, byval plId as LONG ptr) as HRESULT
declare sub IWbemConfigureRefresher_AddObjectByPath_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemConfigureRefresher_AddObjectByTemplate_Proxy(byval This as IWbemConfigureRefresher ptr, byval pNamespace as IWbemServices ptr, byval pTemplate as IWbemClassObject ptr, byval lFlags as LONG, byval pContext as IWbemContext ptr, byval ppRefreshable as IWbemClassObject ptr ptr, byval plId as LONG ptr) as HRESULT
declare sub IWbemConfigureRefresher_AddObjectByTemplate_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemConfigureRefresher_AddRefresher_Proxy(byval This as IWbemConfigureRefresher ptr, byval pRefresher as IWbemRefresher ptr, byval lFlags as LONG, byval plId as LONG ptr) as HRESULT
declare sub IWbemConfigureRefresher_AddRefresher_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemConfigureRefresher_Remove_Proxy(byval This as IWbemConfigureRefresher ptr, byval lId as LONG, byval lFlags as LONG) as HRESULT
declare sub IWbemConfigureRefresher_Remove_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWbemConfigureRefresher_AddEnum_Proxy(byval This as IWbemConfigureRefresher ptr, byval pNamespace as IWbemServices ptr, byval wszClassName as LPCWSTR, byval lFlags as LONG, byval pContext as IWbemContext ptr, byval ppEnum as IWbemHiPerfEnum ptr ptr, byval plId as LONG ptr) as HRESULT
declare sub IWbemConfigureRefresher_AddEnum_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

end extern

#include once "ole-common.bi"
