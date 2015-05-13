#pragma once

#include once "rpc.bi"
#include once "rpcndr.bi"

extern "Windows"

#define __wbemcli_h__
#define __IWbemClassObject_FWD_DEFINED__
#define __IWbemObjectAccess_FWD_DEFINED__
#define __IWbemQualifierSet_FWD_DEFINED__
#define __IWbemServices_FWD_DEFINED__
#define __IWbemLocator_FWD_DEFINED__
#define __IWbemObjectSink_FWD_DEFINED__
#define __IEnumWbemClassObject_FWD_DEFINED__
#define __IWbemCallResult_FWD_DEFINED__
#define __IWbemContext_FWD_DEFINED__
#define __IUnsecuredApartment_FWD_DEFINED__
#define __IWbemUnsecuredApartment_FWD_DEFINED__
#define __IWbemStatusCodeText_FWD_DEFINED__
#define __IWbemBackupRestore_FWD_DEFINED__
#define __IWbemBackupRestoreEx_FWD_DEFINED__
#define __IWbemRefresher_FWD_DEFINED__
#define __IWbemHiPerfEnum_FWD_DEFINED__
#define __IWbemConfigureRefresher_FWD_DEFINED__
#define __WbemLocator_FWD_DEFINED__
#define __WbemContext_FWD_DEFINED__
#define __UnsecuredApartment_FWD_DEFINED__
#define __WbemClassObject_FWD_DEFINED__
#define __MofCompiler_FWD_DEFINED__
#define __WbemStatusCodeText_FWD_DEFINED__
#define __WbemBackupRestore_FWD_DEFINED__
#define __WbemRefresher_FWD_DEFINED__
#define __WbemObjectTextSrc_FWD_DEFINED__
#define __IWbemShutdown_FWD_DEFINED__
#define __IWbemObjectTextSrc_FWD_DEFINED__
#define __IMofCompiler_FWD_DEFINED__
#define __WbemClient_v1_LIBRARY_DEFINED__

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
	WBEM_FLAG_UPDATE_COMPATIBLE = 0
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
type CIMTYPE as long

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
extern LIBID_WbemClient_v1 as const IID
#define __IWbemClassObject_INTERFACE_DEFINED__
extern IID_IWbemClassObject as const IID
type IWbemClassObject as IWbemClassObject_
type IWbemQualifierSet as IWbemQualifierSet_

type IWbemClassObjectVtbl
	QueryInterface as function(byval This as IWbemClassObject ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IWbemClassObject ptr) as ULONG
	Release as function(byval This as IWbemClassObject ptr) as ULONG
	GetQualifierSet as function(byval This as IWbemClassObject ptr, byval ppQualSet as IWbemQualifierSet ptr ptr) as HRESULT
	Get as function(byval This as IWbemClassObject ptr, byval wszName as LPCWSTR, byval lFlags as long, byval pVal as VARIANT ptr, byval pType as CIMTYPE ptr, byval plFlavor as long ptr) as HRESULT
	Put as function(byval This as IWbemClassObject ptr, byval wszName as LPCWSTR, byval lFlags as long, byval pVal as VARIANT ptr, byval Type as CIMTYPE) as HRESULT
	Delete_ as function(byval This as IWbemClassObject ptr, byval wszName as LPCWSTR) as HRESULT
	GetNames as function(byval This as IWbemClassObject ptr, byval wszQualifierName as LPCWSTR, byval lFlags as long, byval pQualifierVal as VARIANT ptr, byval pNames as SAFEARRAY ptr ptr) as HRESULT
	BeginEnumeration as function(byval This as IWbemClassObject ptr, byval lEnumFlags as long) as HRESULT
	Next as function(byval This as IWbemClassObject ptr, byval lFlags as long, byval strName as BSTR ptr, byval pVal as VARIANT ptr, byval pType as CIMTYPE ptr, byval plFlavor as long ptr) as HRESULT
	EndEnumeration as function(byval This as IWbemClassObject ptr) as HRESULT
	GetPropertyQualifierSet as function(byval This as IWbemClassObject ptr, byval wszProperty as LPCWSTR, byval ppQualSet as IWbemQualifierSet ptr ptr) as HRESULT
	Clone as function(byval This as IWbemClassObject ptr, byval ppCopy as IWbemClassObject ptr ptr) as HRESULT
	GetObjectText as function(byval This as IWbemClassObject ptr, byval lFlags as long, byval pstrObjectText as BSTR ptr) as HRESULT
	SpawnDerivedClass as function(byval This as IWbemClassObject ptr, byval lFlags as long, byval ppNewClass as IWbemClassObject ptr ptr) as HRESULT
	SpawnInstance as function(byval This as IWbemClassObject ptr, byval lFlags as long, byval ppNewInstance as IWbemClassObject ptr ptr) as HRESULT
	CompareTo as function(byval This as IWbemClassObject ptr, byval lFlags as long, byval pCompareTo as IWbemClassObject ptr) as HRESULT
	GetPropertyOrigin as function(byval This as IWbemClassObject ptr, byval wszName as LPCWSTR, byval pstrClassName as BSTR ptr) as HRESULT
	InheritsFrom as function(byval This as IWbemClassObject ptr, byval strAncestor as LPCWSTR) as HRESULT
	GetMethod as function(byval This as IWbemClassObject ptr, byval wszName as LPCWSTR, byval lFlags as long, byval ppInSignature as IWbemClassObject ptr ptr, byval ppOutSignature as IWbemClassObject ptr ptr) as HRESULT
	PutMethod as function(byval This as IWbemClassObject ptr, byval wszName as LPCWSTR, byval lFlags as long, byval pInSignature as IWbemClassObject ptr, byval pOutSignature as IWbemClassObject ptr) as HRESULT
	DeleteMethod as function(byval This as IWbemClassObject ptr, byval wszName as LPCWSTR) as HRESULT
	BeginMethodEnumeration as function(byval This as IWbemClassObject ptr, byval lEnumFlags as long) as HRESULT
	NextMethod as function(byval This as IWbemClassObject ptr, byval lFlags as long, byval pstrName as BSTR ptr, byval ppInSignature as IWbemClassObject ptr ptr, byval ppOutSignature as IWbemClassObject ptr ptr) as HRESULT
	EndMethodEnumeration as function(byval This as IWbemClassObject ptr) as HRESULT
	GetMethodQualifierSet as function(byval This as IWbemClassObject ptr, byval wszMethod as LPCWSTR, byval ppQualSet as IWbemQualifierSet ptr ptr) as HRESULT
	GetMethodOrigin as function(byval This as IWbemClassObject ptr, byval wszMethodName as LPCWSTR, byval pstrClassName as BSTR ptr) as HRESULT
end type

type IWbemClassObject_
	lpVtbl as IWbemClassObjectVtbl ptr
end type

declare function IWbemClassObject_GetQualifierSet_Proxy(byval This as IWbemClassObject ptr, byval ppQualSet as IWbemQualifierSet ptr ptr) as HRESULT
declare sub IWbemClassObject_GetQualifierSet_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemClassObject_Get_Proxy(byval This as IWbemClassObject ptr, byval wszName as LPCWSTR, byval lFlags as long, byval pVal as VARIANT ptr, byval pType as CIMTYPE ptr, byval plFlavor as long ptr) as HRESULT
declare sub IWbemClassObject_Get_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemClassObject_Put_Proxy(byval This as IWbemClassObject ptr, byval wszName as LPCWSTR, byval lFlags as long, byval pVal as VARIANT ptr, byval Type as CIMTYPE) as HRESULT
declare sub IWbemClassObject_Put_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemClassObject_Delete_Proxy(byval This as IWbemClassObject ptr, byval wszName as LPCWSTR) as HRESULT
declare sub IWbemClassObject_Delete_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemClassObject_GetNames_Proxy(byval This as IWbemClassObject ptr, byval wszQualifierName as LPCWSTR, byval lFlags as long, byval pQualifierVal as VARIANT ptr, byval pNames as SAFEARRAY ptr ptr) as HRESULT
declare sub IWbemClassObject_GetNames_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemClassObject_BeginEnumeration_Proxy(byval This as IWbemClassObject ptr, byval lEnumFlags as long) as HRESULT
declare sub IWbemClassObject_BeginEnumeration_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemClassObject_Next_Proxy(byval This as IWbemClassObject ptr, byval lFlags as long, byval strName as BSTR ptr, byval pVal as VARIANT ptr, byval pType as CIMTYPE ptr, byval plFlavor as long ptr) as HRESULT
declare sub IWbemClassObject_Next_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemClassObject_EndEnumeration_Proxy(byval This as IWbemClassObject ptr) as HRESULT
declare sub IWbemClassObject_EndEnumeration_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemClassObject_GetPropertyQualifierSet_Proxy(byval This as IWbemClassObject ptr, byval wszProperty as LPCWSTR, byval ppQualSet as IWbemQualifierSet ptr ptr) as HRESULT
declare sub IWbemClassObject_GetPropertyQualifierSet_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemClassObject_Clone_Proxy(byval This as IWbemClassObject ptr, byval ppCopy as IWbemClassObject ptr ptr) as HRESULT
declare sub IWbemClassObject_Clone_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemClassObject_GetObjectText_Proxy(byval This as IWbemClassObject ptr, byval lFlags as long, byval pstrObjectText as BSTR ptr) as HRESULT
declare sub IWbemClassObject_GetObjectText_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemClassObject_SpawnDerivedClass_Proxy(byval This as IWbemClassObject ptr, byval lFlags as long, byval ppNewClass as IWbemClassObject ptr ptr) as HRESULT
declare sub IWbemClassObject_SpawnDerivedClass_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemClassObject_SpawnInstance_Proxy(byval This as IWbemClassObject ptr, byval lFlags as long, byval ppNewInstance as IWbemClassObject ptr ptr) as HRESULT
declare sub IWbemClassObject_SpawnInstance_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemClassObject_CompareTo_Proxy(byval This as IWbemClassObject ptr, byval lFlags as long, byval pCompareTo as IWbemClassObject ptr) as HRESULT
declare sub IWbemClassObject_CompareTo_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemClassObject_GetPropertyOrigin_Proxy(byval This as IWbemClassObject ptr, byval wszName as LPCWSTR, byval pstrClassName as BSTR ptr) as HRESULT
declare sub IWbemClassObject_GetPropertyOrigin_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemClassObject_InheritsFrom_Proxy(byval This as IWbemClassObject ptr, byval strAncestor as LPCWSTR) as HRESULT
declare sub IWbemClassObject_InheritsFrom_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemClassObject_GetMethod_Proxy(byval This as IWbemClassObject ptr, byval wszName as LPCWSTR, byval lFlags as long, byval ppInSignature as IWbemClassObject ptr ptr, byval ppOutSignature as IWbemClassObject ptr ptr) as HRESULT
declare sub IWbemClassObject_GetMethod_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemClassObject_PutMethod_Proxy(byval This as IWbemClassObject ptr, byval wszName as LPCWSTR, byval lFlags as long, byval pInSignature as IWbemClassObject ptr, byval pOutSignature as IWbemClassObject ptr) as HRESULT
declare sub IWbemClassObject_PutMethod_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemClassObject_DeleteMethod_Proxy(byval This as IWbemClassObject ptr, byval wszName as LPCWSTR) as HRESULT
declare sub IWbemClassObject_DeleteMethod_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemClassObject_BeginMethodEnumeration_Proxy(byval This as IWbemClassObject ptr, byval lEnumFlags as long) as HRESULT
declare sub IWbemClassObject_BeginMethodEnumeration_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemClassObject_NextMethod_Proxy(byval This as IWbemClassObject ptr, byval lFlags as long, byval pstrName as BSTR ptr, byval ppInSignature as IWbemClassObject ptr ptr, byval ppOutSignature as IWbemClassObject ptr ptr) as HRESULT
declare sub IWbemClassObject_NextMethod_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemClassObject_EndMethodEnumeration_Proxy(byval This as IWbemClassObject ptr) as HRESULT
declare sub IWbemClassObject_EndMethodEnumeration_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemClassObject_GetMethodQualifierSet_Proxy(byval This as IWbemClassObject ptr, byval wszMethod as LPCWSTR, byval ppQualSet as IWbemQualifierSet ptr ptr) as HRESULT
declare sub IWbemClassObject_GetMethodQualifierSet_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemClassObject_GetMethodOrigin_Proxy(byval This as IWbemClassObject ptr, byval wszMethodName as LPCWSTR, byval pstrClassName as BSTR ptr) as HRESULT
declare sub IWbemClassObject_GetMethodOrigin_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IWbemObjectAccess_INTERFACE_DEFINED__
extern IID_IWbemObjectAccess as const IID
type IWbemObjectAccess as IWbemObjectAccess_

type IWbemObjectAccessVtbl
	QueryInterface as function(byval This as IWbemObjectAccess ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IWbemObjectAccess ptr) as ULONG
	Release as function(byval This as IWbemObjectAccess ptr) as ULONG
	GetQualifierSet as function(byval This as IWbemObjectAccess ptr, byval ppQualSet as IWbemQualifierSet ptr ptr) as HRESULT
	Get as function(byval This as IWbemObjectAccess ptr, byval wszName as LPCWSTR, byval lFlags as long, byval pVal as VARIANT ptr, byval pType as CIMTYPE ptr, byval plFlavor as long ptr) as HRESULT
	Put as function(byval This as IWbemObjectAccess ptr, byval wszName as LPCWSTR, byval lFlags as long, byval pVal as VARIANT ptr, byval Type as CIMTYPE) as HRESULT
	Delete_ as function(byval This as IWbemObjectAccess ptr, byval wszName as LPCWSTR) as HRESULT
	GetNames as function(byval This as IWbemObjectAccess ptr, byval wszQualifierName as LPCWSTR, byval lFlags as long, byval pQualifierVal as VARIANT ptr, byval pNames as SAFEARRAY ptr ptr) as HRESULT
	BeginEnumeration as function(byval This as IWbemObjectAccess ptr, byval lEnumFlags as long) as HRESULT
	Next as function(byval This as IWbemObjectAccess ptr, byval lFlags as long, byval strName as BSTR ptr, byval pVal as VARIANT ptr, byval pType as CIMTYPE ptr, byval plFlavor as long ptr) as HRESULT
	EndEnumeration as function(byval This as IWbemObjectAccess ptr) as HRESULT
	GetPropertyQualifierSet as function(byval This as IWbemObjectAccess ptr, byval wszProperty as LPCWSTR, byval ppQualSet as IWbemQualifierSet ptr ptr) as HRESULT
	Clone as function(byval This as IWbemObjectAccess ptr, byval ppCopy as IWbemClassObject ptr ptr) as HRESULT
	GetObjectText as function(byval This as IWbemObjectAccess ptr, byval lFlags as long, byval pstrObjectText as BSTR ptr) as HRESULT
	SpawnDerivedClass as function(byval This as IWbemObjectAccess ptr, byval lFlags as long, byval ppNewClass as IWbemClassObject ptr ptr) as HRESULT
	SpawnInstance as function(byval This as IWbemObjectAccess ptr, byval lFlags as long, byval ppNewInstance as IWbemClassObject ptr ptr) as HRESULT
	CompareTo as function(byval This as IWbemObjectAccess ptr, byval lFlags as long, byval pCompareTo as IWbemClassObject ptr) as HRESULT
	GetPropertyOrigin as function(byval This as IWbemObjectAccess ptr, byval wszName as LPCWSTR, byval pstrClassName as BSTR ptr) as HRESULT
	InheritsFrom as function(byval This as IWbemObjectAccess ptr, byval strAncestor as LPCWSTR) as HRESULT
	GetMethod as function(byval This as IWbemObjectAccess ptr, byval wszName as LPCWSTR, byval lFlags as long, byval ppInSignature as IWbemClassObject ptr ptr, byval ppOutSignature as IWbemClassObject ptr ptr) as HRESULT
	PutMethod as function(byval This as IWbemObjectAccess ptr, byval wszName as LPCWSTR, byval lFlags as long, byval pInSignature as IWbemClassObject ptr, byval pOutSignature as IWbemClassObject ptr) as HRESULT
	DeleteMethod as function(byval This as IWbemObjectAccess ptr, byval wszName as LPCWSTR) as HRESULT
	BeginMethodEnumeration as function(byval This as IWbemObjectAccess ptr, byval lEnumFlags as long) as HRESULT
	NextMethod as function(byval This as IWbemObjectAccess ptr, byval lFlags as long, byval pstrName as BSTR ptr, byval ppInSignature as IWbemClassObject ptr ptr, byval ppOutSignature as IWbemClassObject ptr ptr) as HRESULT
	EndMethodEnumeration as function(byval This as IWbemObjectAccess ptr) as HRESULT
	GetMethodQualifierSet as function(byval This as IWbemObjectAccess ptr, byval wszMethod as LPCWSTR, byval ppQualSet as IWbemQualifierSet ptr ptr) as HRESULT
	GetMethodOrigin as function(byval This as IWbemObjectAccess ptr, byval wszMethodName as LPCWSTR, byval pstrClassName as BSTR ptr) as HRESULT
	GetPropertyHandle as function(byval This as IWbemObjectAccess ptr, byval wszPropertyName as LPCWSTR, byval pType as CIMTYPE ptr, byval plHandle as long ptr) as HRESULT
	WritePropertyValue as function(byval This as IWbemObjectAccess ptr, byval lHandle as long, byval lNumBytes as long, byval aData as const ubyte ptr) as HRESULT
	ReadPropertyValue as function(byval This as IWbemObjectAccess ptr, byval lHandle as long, byval lBufferSize as long, byval plNumBytes as long ptr, byval aData as ubyte ptr) as HRESULT
	ReadDWORD as function(byval This as IWbemObjectAccess ptr, byval lHandle as long, byval pdw as DWORD ptr) as HRESULT
	WriteDWORD as function(byval This as IWbemObjectAccess ptr, byval lHandle as long, byval dw as DWORD) as HRESULT
	ReadQWORD as function(byval This as IWbemObjectAccess ptr, byval lHandle as long, byval pqw as ulongint ptr) as HRESULT
	WriteQWORD as function(byval This as IWbemObjectAccess ptr, byval lHandle as long, byval pw as ulongint) as HRESULT
	GetPropertyInfoByHandle as function(byval This as IWbemObjectAccess ptr, byval lHandle as long, byval pstrName as BSTR ptr, byval pType as CIMTYPE ptr) as HRESULT
	Lock as function(byval This as IWbemObjectAccess ptr, byval lFlags as long) as HRESULT
	Unlock as function(byval This as IWbemObjectAccess ptr, byval lFlags as long) as HRESULT
end type

type IWbemObjectAccess_
	lpVtbl as IWbemObjectAccessVtbl ptr
end type

declare function IWbemObjectAccess_GetPropertyHandle_Proxy(byval This as IWbemObjectAccess ptr, byval wszPropertyName as LPCWSTR, byval pType as CIMTYPE ptr, byval plHandle as long ptr) as HRESULT
declare sub IWbemObjectAccess_GetPropertyHandle_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemObjectAccess_WritePropertyValue_Proxy(byval This as IWbemObjectAccess ptr, byval lHandle as long, byval lNumBytes as long, byval aData as const ubyte ptr) as HRESULT
declare sub IWbemObjectAccess_WritePropertyValue_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemObjectAccess_ReadPropertyValue_Proxy(byval This as IWbemObjectAccess ptr, byval lHandle as long, byval lBufferSize as long, byval plNumBytes as long ptr, byval aData as ubyte ptr) as HRESULT
declare sub IWbemObjectAccess_ReadPropertyValue_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemObjectAccess_ReadDWORD_Proxy(byval This as IWbemObjectAccess ptr, byval lHandle as long, byval pdw as DWORD ptr) as HRESULT
declare sub IWbemObjectAccess_ReadDWORD_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemObjectAccess_WriteDWORD_Proxy(byval This as IWbemObjectAccess ptr, byval lHandle as long, byval dw as DWORD) as HRESULT
declare sub IWbemObjectAccess_WriteDWORD_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemObjectAccess_ReadQWORD_Proxy(byval This as IWbemObjectAccess ptr, byval lHandle as long, byval pqw as ulongint ptr) as HRESULT
declare sub IWbemObjectAccess_ReadQWORD_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemObjectAccess_WriteQWORD_Proxy(byval This as IWbemObjectAccess ptr, byval lHandle as long, byval pw as ulongint) as HRESULT
declare sub IWbemObjectAccess_WriteQWORD_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemObjectAccess_GetPropertyInfoByHandle_Proxy(byval This as IWbemObjectAccess ptr, byval lHandle as long, byval pstrName as BSTR ptr, byval pType as CIMTYPE ptr) as HRESULT
declare sub IWbemObjectAccess_GetPropertyInfoByHandle_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemObjectAccess_Lock_Proxy(byval This as IWbemObjectAccess ptr, byval lFlags as long) as HRESULT
declare sub IWbemObjectAccess_Lock_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemObjectAccess_Unlock_Proxy(byval This as IWbemObjectAccess ptr, byval lFlags as long) as HRESULT
declare sub IWbemObjectAccess_Unlock_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IWbemQualifierSet_INTERFACE_DEFINED__
extern IID_IWbemQualifierSet as const IID

type IWbemQualifierSetVtbl
	QueryInterface as function(byval This as IWbemQualifierSet ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IWbemQualifierSet ptr) as ULONG
	Release as function(byval This as IWbemQualifierSet ptr) as ULONG
	Get as function(byval This as IWbemQualifierSet ptr, byval wszName as LPCWSTR, byval lFlags as long, byval pVal as VARIANT ptr, byval plFlavor as long ptr) as HRESULT
	Put as function(byval This as IWbemQualifierSet ptr, byval wszName as LPCWSTR, byval pVal as VARIANT ptr, byval lFlavor as long) as HRESULT
	Delete_ as function(byval This as IWbemQualifierSet ptr, byval wszName as LPCWSTR) as HRESULT
	GetNames as function(byval This as IWbemQualifierSet ptr, byval lFlags as long, byval pNames as SAFEARRAY ptr ptr) as HRESULT
	BeginEnumeration as function(byval This as IWbemQualifierSet ptr, byval lFlags as long) as HRESULT
	Next as function(byval This as IWbemQualifierSet ptr, byval lFlags as long, byval pstrName as BSTR ptr, byval pVal as VARIANT ptr, byval plFlavor as long ptr) as HRESULT
	EndEnumeration as function(byval This as IWbemQualifierSet ptr) as HRESULT
end type

type IWbemQualifierSet_
	lpVtbl as IWbemQualifierSetVtbl ptr
end type

declare function IWbemQualifierSet_Get_Proxy(byval This as IWbemQualifierSet ptr, byval wszName as LPCWSTR, byval lFlags as long, byval pVal as VARIANT ptr, byval plFlavor as long ptr) as HRESULT
declare sub IWbemQualifierSet_Get_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemQualifierSet_Put_Proxy(byval This as IWbemQualifierSet ptr, byval wszName as LPCWSTR, byval pVal as VARIANT ptr, byval lFlavor as long) as HRESULT
declare sub IWbemQualifierSet_Put_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemQualifierSet_Delete_Proxy(byval This as IWbemQualifierSet ptr, byval wszName as LPCWSTR) as HRESULT
declare sub IWbemQualifierSet_Delete_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemQualifierSet_GetNames_Proxy(byval This as IWbemQualifierSet ptr, byval lFlags as long, byval pNames as SAFEARRAY ptr ptr) as HRESULT
declare sub IWbemQualifierSet_GetNames_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemQualifierSet_BeginEnumeration_Proxy(byval This as IWbemQualifierSet ptr, byval lFlags as long) as HRESULT
declare sub IWbemQualifierSet_BeginEnumeration_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemQualifierSet_Next_Proxy(byval This as IWbemQualifierSet ptr, byval lFlags as long, byval pstrName as BSTR ptr, byval pVal as VARIANT ptr, byval plFlavor as long ptr) as HRESULT
declare sub IWbemQualifierSet_Next_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemQualifierSet_EndEnumeration_Proxy(byval This as IWbemQualifierSet ptr) as HRESULT
declare sub IWbemQualifierSet_EndEnumeration_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IWbemServices_INTERFACE_DEFINED__
extern IID_IWbemServices as const IID

type IWbemServices as IWbemServices_
type IWbemContext as IWbemContext_
type IWbemCallResult as IWbemCallResult_
type IWbemObjectSink as IWbemObjectSink_
type IEnumWbemClassObject as IEnumWbemClassObject_

type IWbemServicesVtbl
	QueryInterface as function(byval This as IWbemServices ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IWbemServices ptr) as ULONG
	Release as function(byval This as IWbemServices ptr) as ULONG
	OpenNamespace as function(byval This as IWbemServices ptr, byval strNamespace as const BSTR, byval lFlags as long, byval pCtx as IWbemContext ptr, byval ppWorkingNamespace as IWbemServices ptr ptr, byval ppResult as IWbemCallResult ptr ptr) as HRESULT
	CancelAsyncCall as function(byval This as IWbemServices ptr, byval pSink as IWbemObjectSink ptr) as HRESULT
	QueryObjectSink as function(byval This as IWbemServices ptr, byval lFlags as long, byval ppResponseHandler as IWbemObjectSink ptr ptr) as HRESULT
	GetObject as function(byval This as IWbemServices ptr, byval strObjectPath as const BSTR, byval lFlags as long, byval pCtx as IWbemContext ptr, byval ppObject as IWbemClassObject ptr ptr, byval ppCallResult as IWbemCallResult ptr ptr) as HRESULT
	GetObjectAsync as function(byval This as IWbemServices ptr, byval strObjectPath as const BSTR, byval lFlags as long, byval pCtx as IWbemContext ptr, byval pResponseHandler as IWbemObjectSink ptr) as HRESULT
	PutClass as function(byval This as IWbemServices ptr, byval pObject as IWbemClassObject ptr, byval lFlags as long, byval pCtx as IWbemContext ptr, byval ppCallResult as IWbemCallResult ptr ptr) as HRESULT
	PutClassAsync as function(byval This as IWbemServices ptr, byval pObject as IWbemClassObject ptr, byval lFlags as long, byval pCtx as IWbemContext ptr, byval pResponseHandler as IWbemObjectSink ptr) as HRESULT
	DeleteClass as function(byval This as IWbemServices ptr, byval strClass as const BSTR, byval lFlags as long, byval pCtx as IWbemContext ptr, byval ppCallResult as IWbemCallResult ptr ptr) as HRESULT
	DeleteClassAsync as function(byval This as IWbemServices ptr, byval strClass as const BSTR, byval lFlags as long, byval pCtx as IWbemContext ptr, byval pResponseHandler as IWbemObjectSink ptr) as HRESULT
	CreateClassEnum as function(byval This as IWbemServices ptr, byval strSuperclass as const BSTR, byval lFlags as long, byval pCtx as IWbemContext ptr, byval ppEnum as IEnumWbemClassObject ptr ptr) as HRESULT
	CreateClassEnumAsync as function(byval This as IWbemServices ptr, byval strSuperclass as const BSTR, byval lFlags as long, byval pCtx as IWbemContext ptr, byval pResponseHandler as IWbemObjectSink ptr) as HRESULT
	PutInstance as function(byval This as IWbemServices ptr, byval pInst as IWbemClassObject ptr, byval lFlags as long, byval pCtx as IWbemContext ptr, byval ppCallResult as IWbemCallResult ptr ptr) as HRESULT
	PutInstanceAsync as function(byval This as IWbemServices ptr, byval pInst as IWbemClassObject ptr, byval lFlags as long, byval pCtx as IWbemContext ptr, byval pResponseHandler as IWbemObjectSink ptr) as HRESULT
	DeleteInstance as function(byval This as IWbemServices ptr, byval strObjectPath as const BSTR, byval lFlags as long, byval pCtx as IWbemContext ptr, byval ppCallResult as IWbemCallResult ptr ptr) as HRESULT
	DeleteInstanceAsync as function(byval This as IWbemServices ptr, byval strObjectPath as const BSTR, byval lFlags as long, byval pCtx as IWbemContext ptr, byval pResponseHandler as IWbemObjectSink ptr) as HRESULT
	CreateInstanceEnum as function(byval This as IWbemServices ptr, byval strFilter as const BSTR, byval lFlags as long, byval pCtx as IWbemContext ptr, byval ppEnum as IEnumWbemClassObject ptr ptr) as HRESULT
	CreateInstanceEnumAsync as function(byval This as IWbemServices ptr, byval strFilter as const BSTR, byval lFlags as long, byval pCtx as IWbemContext ptr, byval pResponseHandler as IWbemObjectSink ptr) as HRESULT
	ExecQuery as function(byval This as IWbemServices ptr, byval strQueryLanguage as const BSTR, byval strQuery as const BSTR, byval lFlags as long, byval pCtx as IWbemContext ptr, byval ppEnum as IEnumWbemClassObject ptr ptr) as HRESULT
	ExecQueryAsync as function(byval This as IWbemServices ptr, byval strQueryLanguage as const BSTR, byval strQuery as const BSTR, byval lFlags as long, byval pCtx as IWbemContext ptr, byval pResponseHandler as IWbemObjectSink ptr) as HRESULT
	ExecNotificationQuery as function(byval This as IWbemServices ptr, byval strQueryLanguage as const BSTR, byval strQuery as const BSTR, byval lFlags as long, byval pCtx as IWbemContext ptr, byval ppEnum as IEnumWbemClassObject ptr ptr) as HRESULT
	ExecNotificationQueryAsync as function(byval This as IWbemServices ptr, byval strQueryLanguage as const BSTR, byval strQuery as const BSTR, byval lFlags as long, byval pCtx as IWbemContext ptr, byval pResponseHandler as IWbemObjectSink ptr) as HRESULT
	ExecMethod as function(byval This as IWbemServices ptr, byval strObjectPath as const BSTR, byval strMethodName as const BSTR, byval lFlags as long, byval pCtx as IWbemContext ptr, byval pInParams as IWbemClassObject ptr, byval ppOutParams as IWbemClassObject ptr ptr, byval ppCallResult as IWbemCallResult ptr ptr) as HRESULT
	ExecMethodAsync as function(byval This as IWbemServices ptr, byval strObjectPath as const BSTR, byval strMethodName as const BSTR, byval lFlags as long, byval pCtx as IWbemContext ptr, byval pInParams as IWbemClassObject ptr, byval pResponseHandler as IWbemObjectSink ptr) as HRESULT
end type

type IWbemServices_
	lpVtbl as IWbemServicesVtbl ptr
end type

declare function IWbemServices_OpenNamespace_Proxy(byval This as IWbemServices ptr, byval strNamespace as const BSTR, byval lFlags as long, byval pCtx as IWbemContext ptr, byval ppWorkingNamespace as IWbemServices ptr ptr, byval ppResult as IWbemCallResult ptr ptr) as HRESULT
declare sub IWbemServices_OpenNamespace_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemServices_CancelAsyncCall_Proxy(byval This as IWbemServices ptr, byval pSink as IWbemObjectSink ptr) as HRESULT
declare sub IWbemServices_CancelAsyncCall_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemServices_QueryObjectSink_Proxy(byval This as IWbemServices ptr, byval lFlags as long, byval ppResponseHandler as IWbemObjectSink ptr ptr) as HRESULT
declare sub IWbemServices_QueryObjectSink_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemServices_GetObject_Proxy(byval This as IWbemServices ptr, byval strObjectPath as const BSTR, byval lFlags as long, byval pCtx as IWbemContext ptr, byval ppObject as IWbemClassObject ptr ptr, byval ppCallResult as IWbemCallResult ptr ptr) as HRESULT
declare sub IWbemServices_GetObject_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemServices_GetObjectAsync_Proxy(byval This as IWbemServices ptr, byval strObjectPath as const BSTR, byval lFlags as long, byval pCtx as IWbemContext ptr, byval pResponseHandler as IWbemObjectSink ptr) as HRESULT
declare sub IWbemServices_GetObjectAsync_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemServices_PutClass_Proxy(byval This as IWbemServices ptr, byval pObject as IWbemClassObject ptr, byval lFlags as long, byval pCtx as IWbemContext ptr, byval ppCallResult as IWbemCallResult ptr ptr) as HRESULT
declare sub IWbemServices_PutClass_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemServices_PutClassAsync_Proxy(byval This as IWbemServices ptr, byval pObject as IWbemClassObject ptr, byval lFlags as long, byval pCtx as IWbemContext ptr, byval pResponseHandler as IWbemObjectSink ptr) as HRESULT
declare sub IWbemServices_PutClassAsync_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemServices_DeleteClass_Proxy(byval This as IWbemServices ptr, byval strClass as const BSTR, byval lFlags as long, byval pCtx as IWbemContext ptr, byval ppCallResult as IWbemCallResult ptr ptr) as HRESULT
declare sub IWbemServices_DeleteClass_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemServices_DeleteClassAsync_Proxy(byval This as IWbemServices ptr, byval strClass as const BSTR, byval lFlags as long, byval pCtx as IWbemContext ptr, byval pResponseHandler as IWbemObjectSink ptr) as HRESULT
declare sub IWbemServices_DeleteClassAsync_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemServices_CreateClassEnum_Proxy(byval This as IWbemServices ptr, byval strSuperclass as const BSTR, byval lFlags as long, byval pCtx as IWbemContext ptr, byval ppEnum as IEnumWbemClassObject ptr ptr) as HRESULT
declare sub IWbemServices_CreateClassEnum_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemServices_CreateClassEnumAsync_Proxy(byval This as IWbemServices ptr, byval strSuperclass as const BSTR, byval lFlags as long, byval pCtx as IWbemContext ptr, byval pResponseHandler as IWbemObjectSink ptr) as HRESULT
declare sub IWbemServices_CreateClassEnumAsync_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemServices_PutInstance_Proxy(byval This as IWbemServices ptr, byval pInst as IWbemClassObject ptr, byval lFlags as long, byval pCtx as IWbemContext ptr, byval ppCallResult as IWbemCallResult ptr ptr) as HRESULT
declare sub IWbemServices_PutInstance_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemServices_PutInstanceAsync_Proxy(byval This as IWbemServices ptr, byval pInst as IWbemClassObject ptr, byval lFlags as long, byval pCtx as IWbemContext ptr, byval pResponseHandler as IWbemObjectSink ptr) as HRESULT
declare sub IWbemServices_PutInstanceAsync_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemServices_DeleteInstance_Proxy(byval This as IWbemServices ptr, byval strObjectPath as const BSTR, byval lFlags as long, byval pCtx as IWbemContext ptr, byval ppCallResult as IWbemCallResult ptr ptr) as HRESULT
declare sub IWbemServices_DeleteInstance_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemServices_DeleteInstanceAsync_Proxy(byval This as IWbemServices ptr, byval strObjectPath as const BSTR, byval lFlags as long, byval pCtx as IWbemContext ptr, byval pResponseHandler as IWbemObjectSink ptr) as HRESULT
declare sub IWbemServices_DeleteInstanceAsync_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemServices_CreateInstanceEnum_Proxy(byval This as IWbemServices ptr, byval strFilter as const BSTR, byval lFlags as long, byval pCtx as IWbemContext ptr, byval ppEnum as IEnumWbemClassObject ptr ptr) as HRESULT
declare sub IWbemServices_CreateInstanceEnum_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemServices_CreateInstanceEnumAsync_Proxy(byval This as IWbemServices ptr, byval strFilter as const BSTR, byval lFlags as long, byval pCtx as IWbemContext ptr, byval pResponseHandler as IWbemObjectSink ptr) as HRESULT
declare sub IWbemServices_CreateInstanceEnumAsync_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemServices_ExecQuery_Proxy(byval This as IWbemServices ptr, byval strQueryLanguage as const BSTR, byval strQuery as const BSTR, byval lFlags as long, byval pCtx as IWbemContext ptr, byval ppEnum as IEnumWbemClassObject ptr ptr) as HRESULT
declare sub IWbemServices_ExecQuery_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemServices_ExecQueryAsync_Proxy(byval This as IWbemServices ptr, byval strQueryLanguage as const BSTR, byval strQuery as const BSTR, byval lFlags as long, byval pCtx as IWbemContext ptr, byval pResponseHandler as IWbemObjectSink ptr) as HRESULT
declare sub IWbemServices_ExecQueryAsync_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemServices_ExecNotificationQuery_Proxy(byval This as IWbemServices ptr, byval strQueryLanguage as const BSTR, byval strQuery as const BSTR, byval lFlags as long, byval pCtx as IWbemContext ptr, byval ppEnum as IEnumWbemClassObject ptr ptr) as HRESULT
declare sub IWbemServices_ExecNotificationQuery_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemServices_ExecNotificationQueryAsync_Proxy(byval This as IWbemServices ptr, byval strQueryLanguage as const BSTR, byval strQuery as const BSTR, byval lFlags as long, byval pCtx as IWbemContext ptr, byval pResponseHandler as IWbemObjectSink ptr) as HRESULT
declare sub IWbemServices_ExecNotificationQueryAsync_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemServices_ExecMethod_Proxy(byval This as IWbemServices ptr, byval strObjectPath as const BSTR, byval strMethodName as const BSTR, byval lFlags as long, byval pCtx as IWbemContext ptr, byval pInParams as IWbemClassObject ptr, byval ppOutParams as IWbemClassObject ptr ptr, byval ppCallResult as IWbemCallResult ptr ptr) as HRESULT
declare sub IWbemServices_ExecMethod_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemServices_ExecMethodAsync_Proxy(byval This as IWbemServices ptr, byval strObjectPath as const BSTR, byval strMethodName as const BSTR, byval lFlags as long, byval pCtx as IWbemContext ptr, byval pInParams as IWbemClassObject ptr, byval pResponseHandler as IWbemObjectSink ptr) as HRESULT
declare sub IWbemServices_ExecMethodAsync_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IWbemLocator_INTERFACE_DEFINED__
extern IID_IWbemLocator as const GUID
type IWbemLocator as IWbemLocator_

type IWbemLocatorVtbl
	QueryInterface as function(byval This as IWbemLocator ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IWbemLocator ptr) as ULONG
	Release as function(byval This as IWbemLocator ptr) as ULONG
	ConnectServer as function(byval This as IWbemLocator ptr, byval strNetworkResource as const BSTR, byval strUser as const BSTR, byval strPassword as const BSTR, byval strLocale as const BSTR, byval lSecurityFlags as long, byval strAuthority as const BSTR, byval pCtx as IWbemContext ptr, byval ppNamespace as IWbemServices ptr ptr) as HRESULT
end type

type IWbemLocator_
	lpVtbl as IWbemLocatorVtbl ptr
end type

declare function IWbemLocator_ConnectServer_Proxy(byval This as IWbemLocator ptr, byval strNetworkResource as const BSTR, byval strUser as const BSTR, byval strPassword as const BSTR, byval strLocale as const BSTR, byval lSecurityFlags as long, byval strAuthority as const BSTR, byval pCtx as IWbemContext ptr, byval ppNamespace as IWbemServices ptr ptr) as HRESULT
declare sub IWbemLocator_ConnectServer_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IWbemObjectSink_INTERFACE_DEFINED__
extern IID_IWbemObjectSink as const IID

type IWbemObjectSinkVtbl
	QueryInterface as function(byval This as IWbemObjectSink ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IWbemObjectSink ptr) as ULONG
	Release as function(byval This as IWbemObjectSink ptr) as ULONG
	Indicate as function(byval This as IWbemObjectSink ptr, byval lObjectCount as long, byval apObjArray as IWbemClassObject ptr ptr) as HRESULT
	SetStatus as function(byval This as IWbemObjectSink ptr, byval lFlags as long, byval hResult as HRESULT, byval strParam as BSTR, byval pObjParam as IWbemClassObject ptr) as HRESULT
end type

type IWbemObjectSink_
	lpVtbl as IWbemObjectSinkVtbl ptr
end type

declare function IWbemObjectSink_Indicate_Proxy(byval This as IWbemObjectSink ptr, byval lObjectCount as long, byval apObjArray as IWbemClassObject ptr ptr) as HRESULT
declare sub IWbemObjectSink_Indicate_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemObjectSink_SetStatus_Proxy(byval This as IWbemObjectSink ptr, byval lFlags as long, byval hResult as HRESULT, byval strParam as BSTR, byval pObjParam as IWbemClassObject ptr) as HRESULT
declare sub IWbemObjectSink_SetStatus_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IEnumWbemClassObject_INTERFACE_DEFINED__
extern IID_IEnumWbemClassObject as const IID

type IEnumWbemClassObjectVtbl
	QueryInterface as function(byval This as IEnumWbemClassObject ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IEnumWbemClassObject ptr) as ULONG
	Release as function(byval This as IEnumWbemClassObject ptr) as ULONG
	Reset as function(byval This as IEnumWbemClassObject ptr) as HRESULT
	Next as function(byval This as IEnumWbemClassObject ptr, byval lTimeout as long, byval uCount as ULONG, byval apObjects as IWbemClassObject ptr ptr, byval puReturned as ULONG ptr) as HRESULT
	NextAsync as function(byval This as IEnumWbemClassObject ptr, byval uCount as ULONG, byval pSink as IWbemObjectSink ptr) as HRESULT
	Clone as function(byval This as IEnumWbemClassObject ptr, byval ppEnum as IEnumWbemClassObject ptr ptr) as HRESULT
	Skip as function(byval This as IEnumWbemClassObject ptr, byval lTimeout as long, byval nCount as ULONG) as HRESULT
end type

type IEnumWbemClassObject_
	lpVtbl as IEnumWbemClassObjectVtbl ptr
end type

declare function IEnumWbemClassObject_Reset_Proxy(byval This as IEnumWbemClassObject ptr) as HRESULT
declare sub IEnumWbemClassObject_Reset_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IEnumWbemClassObject_Next_Proxy(byval This as IEnumWbemClassObject ptr, byval lTimeout as long, byval uCount as ULONG, byval apObjects as IWbemClassObject ptr ptr, byval puReturned as ULONG ptr) as HRESULT
declare sub IEnumWbemClassObject_Next_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IEnumWbemClassObject_NextAsync_Proxy(byval This as IEnumWbemClassObject ptr, byval uCount as ULONG, byval pSink as IWbemObjectSink ptr) as HRESULT
declare sub IEnumWbemClassObject_NextAsync_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IEnumWbemClassObject_Clone_Proxy(byval This as IEnumWbemClassObject ptr, byval ppEnum as IEnumWbemClassObject ptr ptr) as HRESULT
declare sub IEnumWbemClassObject_Clone_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IEnumWbemClassObject_Skip_Proxy(byval This as IEnumWbemClassObject ptr, byval lTimeout as long, byval nCount as ULONG) as HRESULT
declare sub IEnumWbemClassObject_Skip_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IWbemCallResult_INTERFACE_DEFINED__
extern IID_IWbemCallResult as const IID

type IWbemCallResultVtbl
	QueryInterface as function(byval This as IWbemCallResult ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IWbemCallResult ptr) as ULONG
	Release as function(byval This as IWbemCallResult ptr) as ULONG
	GetResultObject as function(byval This as IWbemCallResult ptr, byval lTimeout as long, byval ppResultObject as IWbemClassObject ptr ptr) as HRESULT
	GetResultString as function(byval This as IWbemCallResult ptr, byval lTimeout as long, byval pstrResultString as BSTR ptr) as HRESULT
	GetResultServices as function(byval This as IWbemCallResult ptr, byval lTimeout as long, byval ppServices as IWbemServices ptr ptr) as HRESULT
	GetCallStatus as function(byval This as IWbemCallResult ptr, byval lTimeout as long, byval plStatus as long ptr) as HRESULT
end type

type IWbemCallResult_
	lpVtbl as IWbemCallResultVtbl ptr
end type

declare function IWbemCallResult_GetResultObject_Proxy(byval This as IWbemCallResult ptr, byval lTimeout as long, byval ppResultObject as IWbemClassObject ptr ptr) as HRESULT
declare sub IWbemCallResult_GetResultObject_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemCallResult_GetResultString_Proxy(byval This as IWbemCallResult ptr, byval lTimeout as long, byval pstrResultString as BSTR ptr) as HRESULT
declare sub IWbemCallResult_GetResultString_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemCallResult_GetResultServices_Proxy(byval This as IWbemCallResult ptr, byval lTimeout as long, byval ppServices as IWbemServices ptr ptr) as HRESULT
declare sub IWbemCallResult_GetResultServices_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemCallResult_GetCallStatus_Proxy(byval This as IWbemCallResult ptr, byval lTimeout as long, byval plStatus as long ptr) as HRESULT
declare sub IWbemCallResult_GetCallStatus_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IWbemContext_INTERFACE_DEFINED__
extern IID_IWbemContext as const IID

type IWbemContextVtbl
	QueryInterface as function(byval This as IWbemContext ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IWbemContext ptr) as ULONG
	Release as function(byval This as IWbemContext ptr) as ULONG
	Clone as function(byval This as IWbemContext ptr, byval ppNewCopy as IWbemContext ptr ptr) as HRESULT
	GetNames as function(byval This as IWbemContext ptr, byval lFlags as long, byval pNames as SAFEARRAY ptr ptr) as HRESULT
	BeginEnumeration as function(byval This as IWbemContext ptr, byval lFlags as long) as HRESULT
	Next as function(byval This as IWbemContext ptr, byval lFlags as long, byval pstrName as BSTR ptr, byval pValue as VARIANT ptr) as HRESULT
	EndEnumeration as function(byval This as IWbemContext ptr) as HRESULT
	SetValue as function(byval This as IWbemContext ptr, byval wszName as LPCWSTR, byval lFlags as long, byval pValue as VARIANT ptr) as HRESULT
	GetValue as function(byval This as IWbemContext ptr, byval wszName as LPCWSTR, byval lFlags as long, byval pValue as VARIANT ptr) as HRESULT
	DeleteValue as function(byval This as IWbemContext ptr, byval wszName as LPCWSTR, byval lFlags as long) as HRESULT
	DeleteAll as function(byval This as IWbemContext ptr) as HRESULT
end type

type IWbemContext_
	lpVtbl as IWbemContextVtbl ptr
end type

declare function IWbemContext_Clone_Proxy(byval This as IWbemContext ptr, byval ppNewCopy as IWbemContext ptr ptr) as HRESULT
declare sub IWbemContext_Clone_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemContext_GetNames_Proxy(byval This as IWbemContext ptr, byval lFlags as long, byval pNames as SAFEARRAY ptr ptr) as HRESULT
declare sub IWbemContext_GetNames_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemContext_BeginEnumeration_Proxy(byval This as IWbemContext ptr, byval lFlags as long) as HRESULT
declare sub IWbemContext_BeginEnumeration_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemContext_Next_Proxy(byval This as IWbemContext ptr, byval lFlags as long, byval pstrName as BSTR ptr, byval pValue as VARIANT ptr) as HRESULT
declare sub IWbemContext_Next_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemContext_EndEnumeration_Proxy(byval This as IWbemContext ptr) as HRESULT
declare sub IWbemContext_EndEnumeration_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemContext_SetValue_Proxy(byval This as IWbemContext ptr, byval wszName as LPCWSTR, byval lFlags as long, byval pValue as VARIANT ptr) as HRESULT
declare sub IWbemContext_SetValue_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemContext_GetValue_Proxy(byval This as IWbemContext ptr, byval wszName as LPCWSTR, byval lFlags as long, byval pValue as VARIANT ptr) as HRESULT
declare sub IWbemContext_GetValue_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemContext_DeleteValue_Proxy(byval This as IWbemContext ptr, byval wszName as LPCWSTR, byval lFlags as long) as HRESULT
declare sub IWbemContext_DeleteValue_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemContext_DeleteAll_Proxy(byval This as IWbemContext ptr) as HRESULT
declare sub IWbemContext_DeleteAll_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IUnsecuredApartment_INTERFACE_DEFINED__
extern IID_IUnsecuredApartment as const IID
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

declare function IUnsecuredApartment_CreateObjectStub_Proxy(byval This as IUnsecuredApartment ptr, byval pObject as IUnknown ptr, byval ppStub as IUnknown ptr ptr) as HRESULT
declare sub IUnsecuredApartment_CreateObjectStub_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IWbemUnsecuredApartment_INTERFACE_DEFINED__
extern IID_IWbemUnsecuredApartment as const IID
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

declare function IWbemUnsecuredApartment_CreateSinkStub_Proxy(byval This as IWbemUnsecuredApartment ptr, byval pSink as IWbemObjectSink ptr, byval dwFlags as DWORD, byval wszReserved as LPCWSTR, byval ppStub as IWbemObjectSink ptr ptr) as HRESULT
declare sub IWbemUnsecuredApartment_CreateSinkStub_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IWbemStatusCodeText_INTERFACE_DEFINED__
extern IID_IWbemStatusCodeText as const IID
type IWbemStatusCodeText as IWbemStatusCodeText_

type IWbemStatusCodeTextVtbl
	QueryInterface as function(byval This as IWbemStatusCodeText ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IWbemStatusCodeText ptr) as ULONG
	Release as function(byval This as IWbemStatusCodeText ptr) as ULONG
	GetErrorCodeText as function(byval This as IWbemStatusCodeText ptr, byval hRes as HRESULT, byval LocaleId as LCID, byval lFlags as long, byval MessageText as BSTR ptr) as HRESULT
	GetFacilityCodeText as function(byval This as IWbemStatusCodeText ptr, byval hRes as HRESULT, byval LocaleId as LCID, byval lFlags as long, byval MessageText as BSTR ptr) as HRESULT
end type

type IWbemStatusCodeText_
	lpVtbl as IWbemStatusCodeTextVtbl ptr
end type

declare function IWbemStatusCodeText_GetErrorCodeText_Proxy(byval This as IWbemStatusCodeText ptr, byval hRes as HRESULT, byval LocaleId as LCID, byval lFlags as long, byval MessageText as BSTR ptr) as HRESULT
declare sub IWbemStatusCodeText_GetErrorCodeText_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemStatusCodeText_GetFacilityCodeText_Proxy(byval This as IWbemStatusCodeText ptr, byval hRes as HRESULT, byval LocaleId as LCID, byval lFlags as long, byval MessageText as BSTR ptr) as HRESULT
declare sub IWbemStatusCodeText_GetFacilityCodeText_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IWbemBackupRestore_INTERFACE_DEFINED__
extern IID_IWbemBackupRestore as const IID
type IWbemBackupRestore as IWbemBackupRestore_

type IWbemBackupRestoreVtbl
	QueryInterface as function(byval This as IWbemBackupRestore ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IWbemBackupRestore ptr) as ULONG
	Release as function(byval This as IWbemBackupRestore ptr) as ULONG
	Backup as function(byval This as IWbemBackupRestore ptr, byval strBackupToFile as LPCWSTR, byval lFlags as long) as HRESULT
	Restore as function(byval This as IWbemBackupRestore ptr, byval strRestoreFromFile as LPCWSTR, byval lFlags as long) as HRESULT
end type

type IWbemBackupRestore_
	lpVtbl as IWbemBackupRestoreVtbl ptr
end type

declare function IWbemBackupRestore_Backup_Proxy(byval This as IWbemBackupRestore ptr, byval strBackupToFile as LPCWSTR, byval lFlags as long) as HRESULT
declare sub IWbemBackupRestore_Backup_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemBackupRestore_Restore_Proxy(byval This as IWbemBackupRestore ptr, byval strRestoreFromFile as LPCWSTR, byval lFlags as long) as HRESULT
declare sub IWbemBackupRestore_Restore_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IWbemBackupRestoreEx_INTERFACE_DEFINED__
extern IID_IWbemBackupRestoreEx as const IID
type IWbemBackupRestoreEx as IWbemBackupRestoreEx_

type IWbemBackupRestoreExVtbl
	QueryInterface as function(byval This as IWbemBackupRestoreEx ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IWbemBackupRestoreEx ptr) as ULONG
	Release as function(byval This as IWbemBackupRestoreEx ptr) as ULONG
	Backup as function(byval This as IWbemBackupRestoreEx ptr, byval strBackupToFile as LPCWSTR, byval lFlags as long) as HRESULT
	Restore as function(byval This as IWbemBackupRestoreEx ptr, byval strRestoreFromFile as LPCWSTR, byval lFlags as long) as HRESULT
	Pause as function(byval This as IWbemBackupRestoreEx ptr) as HRESULT
	Resume as function(byval This as IWbemBackupRestoreEx ptr) as HRESULT
end type

type IWbemBackupRestoreEx_
	lpVtbl as IWbemBackupRestoreExVtbl ptr
end type

declare function IWbemBackupRestoreEx_Pause_Proxy(byval This as IWbemBackupRestoreEx ptr) as HRESULT
declare sub IWbemBackupRestoreEx_Pause_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemBackupRestoreEx_Resume_Proxy(byval This as IWbemBackupRestoreEx ptr) as HRESULT
declare sub IWbemBackupRestoreEx_Resume_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IWbemRefresher_INTERFACE_DEFINED__
extern IID_IWbemRefresher as const IID
type IWbemRefresher as IWbemRefresher_

type IWbemRefresherVtbl
	QueryInterface as function(byval This as IWbemRefresher ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IWbemRefresher ptr) as ULONG
	Release as function(byval This as IWbemRefresher ptr) as ULONG
	Refresh as function(byval This as IWbemRefresher ptr, byval lFlags as long) as HRESULT
end type

type IWbemRefresher_
	lpVtbl as IWbemRefresherVtbl ptr
end type

declare function IWbemRefresher_Refresh_Proxy(byval This as IWbemRefresher ptr, byval lFlags as long) as HRESULT
declare sub IWbemRefresher_Refresh_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IWbemHiPerfEnum_INTERFACE_DEFINED__
extern IID_IWbemHiPerfEnum as const IID
type IWbemHiPerfEnum as IWbemHiPerfEnum_

type IWbemHiPerfEnumVtbl
	QueryInterface as function(byval This as IWbemHiPerfEnum ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IWbemHiPerfEnum ptr) as ULONG
	Release as function(byval This as IWbemHiPerfEnum ptr) as ULONG
	AddObjects as function(byval This as IWbemHiPerfEnum ptr, byval lFlags as long, byval uNumObjects as ULONG, byval apIds as long ptr, byval apObj as IWbemObjectAccess ptr ptr) as HRESULT
	RemoveObjects as function(byval This as IWbemHiPerfEnum ptr, byval lFlags as long, byval uNumObjects as ULONG, byval apIds as long ptr) as HRESULT
	GetObjects as function(byval This as IWbemHiPerfEnum ptr, byval lFlags as long, byval uNumObjects as ULONG, byval apObj as IWbemObjectAccess ptr ptr, byval puReturned as ULONG ptr) as HRESULT
	RemoveAll as function(byval This as IWbemHiPerfEnum ptr, byval lFlags as long) as HRESULT
end type

type IWbemHiPerfEnum_
	lpVtbl as IWbemHiPerfEnumVtbl ptr
end type

declare function IWbemHiPerfEnum_AddObjects_Proxy(byval This as IWbemHiPerfEnum ptr, byval lFlags as long, byval uNumObjects as ULONG, byval apIds as long ptr, byval apObj as IWbemObjectAccess ptr ptr) as HRESULT
declare sub IWbemHiPerfEnum_AddObjects_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemHiPerfEnum_RemoveObjects_Proxy(byval This as IWbemHiPerfEnum ptr, byval lFlags as long, byval uNumObjects as ULONG, byval apIds as long ptr) as HRESULT
declare sub IWbemHiPerfEnum_RemoveObjects_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemHiPerfEnum_GetObjects_Proxy(byval This as IWbemHiPerfEnum ptr, byval lFlags as long, byval uNumObjects as ULONG, byval apObj as IWbemObjectAccess ptr ptr, byval puReturned as ULONG ptr) as HRESULT
declare sub IWbemHiPerfEnum_GetObjects_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemHiPerfEnum_RemoveAll_Proxy(byval This as IWbemHiPerfEnum ptr, byval lFlags as long) as HRESULT
declare sub IWbemHiPerfEnum_RemoveAll_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IWbemConfigureRefresher_INTERFACE_DEFINED__
extern IID_IWbemConfigureRefresher as const IID
type IWbemConfigureRefresher as IWbemConfigureRefresher_

type IWbemConfigureRefresherVtbl
	QueryInterface as function(byval This as IWbemConfigureRefresher ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IWbemConfigureRefresher ptr) as ULONG
	Release as function(byval This as IWbemConfigureRefresher ptr) as ULONG
	AddObjectByPath as function(byval This as IWbemConfigureRefresher ptr, byval pNamespace as IWbemServices ptr, byval wszPath as LPCWSTR, byval lFlags as long, byval pContext as IWbemContext ptr, byval ppRefreshable as IWbemClassObject ptr ptr, byval plId as long ptr) as HRESULT
	AddObjectByTemplate as function(byval This as IWbemConfigureRefresher ptr, byval pNamespace as IWbemServices ptr, byval pTemplate as IWbemClassObject ptr, byval lFlags as long, byval pContext as IWbemContext ptr, byval ppRefreshable as IWbemClassObject ptr ptr, byval plId as long ptr) as HRESULT
	AddRefresher as function(byval This as IWbemConfigureRefresher ptr, byval pRefresher as IWbemRefresher ptr, byval lFlags as long, byval plId as long ptr) as HRESULT
	Remove as function(byval This as IWbemConfigureRefresher ptr, byval lId as long, byval lFlags as long) as HRESULT
	AddEnum as function(byval This as IWbemConfigureRefresher ptr, byval pNamespace as IWbemServices ptr, byval wszClassName as LPCWSTR, byval lFlags as long, byval pContext as IWbemContext ptr, byval ppEnum as IWbemHiPerfEnum ptr ptr, byval plId as long ptr) as HRESULT
end type

type IWbemConfigureRefresher_
	lpVtbl as IWbemConfigureRefresherVtbl ptr
end type

declare function IWbemConfigureRefresher_AddObjectByPath_Proxy(byval This as IWbemConfigureRefresher ptr, byval pNamespace as IWbemServices ptr, byval wszPath as LPCWSTR, byval lFlags as long, byval pContext as IWbemContext ptr, byval ppRefreshable as IWbemClassObject ptr ptr, byval plId as long ptr) as HRESULT
declare sub IWbemConfigureRefresher_AddObjectByPath_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemConfigureRefresher_AddObjectByTemplate_Proxy(byval This as IWbemConfigureRefresher ptr, byval pNamespace as IWbemServices ptr, byval pTemplate as IWbemClassObject ptr, byval lFlags as long, byval pContext as IWbemContext ptr, byval ppRefreshable as IWbemClassObject ptr ptr, byval plId as long ptr) as HRESULT
declare sub IWbemConfigureRefresher_AddObjectByTemplate_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemConfigureRefresher_AddRefresher_Proxy(byval This as IWbemConfigureRefresher ptr, byval pRefresher as IWbemRefresher ptr, byval lFlags as long, byval plId as long ptr) as HRESULT
declare sub IWbemConfigureRefresher_AddRefresher_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemConfigureRefresher_Remove_Proxy(byval This as IWbemConfigureRefresher ptr, byval lId as long, byval lFlags as long) as HRESULT
declare sub IWbemConfigureRefresher_Remove_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemConfigureRefresher_AddEnum_Proxy(byval This as IWbemConfigureRefresher ptr, byval pNamespace as IWbemServices ptr, byval wszClassName as LPCWSTR, byval lFlags as long, byval pContext as IWbemContext ptr, byval ppEnum as IWbemHiPerfEnum ptr ptr, byval plId as long ptr) as HRESULT
declare sub IWbemConfigureRefresher_AddEnum_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

extern CLSID_WbemLocator as const CLSID
extern CLSID_WbemContext as const CLSID
extern CLSID_UnsecuredApartment as const CLSID
extern CLSID_WbemClassObject as const CLSID
extern CLSID_MofCompiler as const CLSID
extern CLSID_WbemStatusCodeText as const CLSID
extern CLSID_WbemBackupRestore as const CLSID
extern CLSID_WbemRefresher as const CLSID
extern CLSID_WbemObjectTextSrc as const CLSID
extern __MIDL_itf_wbemcli_0000_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_wbemcli_0000_v0_0_s_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_wbemcli_0116_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_wbemcli_0116_v0_0_s_ifspec as RPC_IF_HANDLE
#define __IWbemShutdown_INTERFACE_DEFINED__
extern IID_IWbemShutdown as const IID
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

declare function IWbemShutdown_Shutdown_Proxy(byval This as IWbemShutdown ptr, byval uReason as LONG, byval uMaxMilliseconds as ULONG, byval pCtx as IWbemContext ptr) as HRESULT
declare sub IWbemShutdown_Shutdown_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

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
extern __MIDL_itf_wbemcli_0123_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_wbemcli_0123_v0_0_s_ifspec as RPC_IF_HANDLE
#define __IWbemObjectTextSrc_INTERFACE_DEFINED__
extern IID_IWbemObjectTextSrc as const IID
type IWbemObjectTextSrc as IWbemObjectTextSrc_

type IWbemObjectTextSrcVtbl
	QueryInterface as function(byval This as IWbemObjectTextSrc ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IWbemObjectTextSrc ptr) as ULONG
	Release as function(byval This as IWbemObjectTextSrc ptr) as ULONG
	GetText as function(byval This as IWbemObjectTextSrc ptr, byval lFlags as long, byval pObj as IWbemClassObject ptr, byval uObjTextFormat as ULONG, byval pCtx as IWbemContext ptr, byval strText as BSTR ptr) as HRESULT
	CreateFromText as function(byval This as IWbemObjectTextSrc ptr, byval lFlags as long, byval strText as BSTR, byval uObjTextFormat as ULONG, byval pCtx as IWbemContext ptr, byval pNewObj as IWbemClassObject ptr ptr) as HRESULT
end type

type IWbemObjectTextSrc_
	lpVtbl as IWbemObjectTextSrcVtbl ptr
end type

declare function IWbemObjectTextSrc_GetText_Proxy(byval This as IWbemObjectTextSrc ptr, byval lFlags as long, byval pObj as IWbemClassObject ptr, byval uObjTextFormat as ULONG, byval pCtx as IWbemContext ptr, byval strText as BSTR ptr) as HRESULT
declare sub IWbemObjectTextSrc_GetText_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWbemObjectTextSrc_CreateFromText_Proxy(byval This as IWbemObjectTextSrc ptr, byval lFlags as long, byval strText as BSTR, byval uObjTextFormat as ULONG, byval pCtx as IWbemContext ptr, byval pNewObj as IWbemClassObject ptr ptr) as HRESULT
declare sub IWbemObjectTextSrc_CreateFromText_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

type tag_CompileStatusInfo
	lPhaseError as long
	hRes as HRESULT
	ObjectNum as long
	FirstLine as long
	LastLine as long
	dwOutFlags as DWORD
end type

type WBEM_COMPILE_STATUS_INFO as tag_CompileStatusInfo

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
extern __MIDL_itf_wbemcli_0125_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_wbemcli_0125_v0_0_s_ifspec as RPC_IF_HANDLE
#define __IMofCompiler_INTERFACE_DEFINED__
extern IID_IMofCompiler as const IID
type IMofCompiler as IMofCompiler_

type IMofCompilerVtbl
	QueryInterface as function(byval This as IMofCompiler ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IMofCompiler ptr) as ULONG
	Release as function(byval This as IMofCompiler ptr) as ULONG
	CompileFile as function(byval This as IMofCompiler ptr, byval FileName as LPWSTR, byval ServerAndNamespace as LPWSTR, byval User as LPWSTR, byval Authority as LPWSTR, byval Password as LPWSTR, byval lOptionFlags as LONG, byval lClassFlags as LONG, byval lInstanceFlags as LONG, byval pInfo as WBEM_COMPILE_STATUS_INFO ptr) as HRESULT
	CompileBuffer as function(byval This as IMofCompiler ptr, byval BuffSize as long, byval pBuffer as UBYTE ptr, byval ServerAndNamespace as LPWSTR, byval User as LPWSTR, byval Authority as LPWSTR, byval Password as LPWSTR, byval lOptionFlags as LONG, byval lClassFlags as LONG, byval lInstanceFlags as LONG, byval pInfo as WBEM_COMPILE_STATUS_INFO ptr) as HRESULT
	CreateBMOF as function(byval This as IMofCompiler ptr, byval TextFileName as LPWSTR, byval BMOFFileName as LPWSTR, byval ServerAndNamespace as LPWSTR, byval lOptionFlags as LONG, byval lClassFlags as LONG, byval lInstanceFlags as LONG, byval pInfo as WBEM_COMPILE_STATUS_INFO ptr) as HRESULT
end type

type IMofCompiler_
	lpVtbl as IMofCompilerVtbl ptr
end type

declare function IMofCompiler_CompileFile_Proxy(byval This as IMofCompiler ptr, byval FileName as LPWSTR, byval ServerAndNamespace as LPWSTR, byval User as LPWSTR, byval Authority as LPWSTR, byval Password as LPWSTR, byval lOptionFlags as LONG, byval lClassFlags as LONG, byval lInstanceFlags as LONG, byval pInfo as WBEM_COMPILE_STATUS_INFO ptr) as HRESULT
declare sub IMofCompiler_CompileFile_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMofCompiler_CompileBuffer_Proxy(byval This as IMofCompiler ptr, byval BuffSize as long, byval pBuffer as UBYTE ptr, byval ServerAndNamespace as LPWSTR, byval User as LPWSTR, byval Authority as LPWSTR, byval Password as LPWSTR, byval lOptionFlags as LONG, byval lClassFlags as LONG, byval lInstanceFlags as LONG, byval pInfo as WBEM_COMPILE_STATUS_INFO ptr) as HRESULT
declare sub IMofCompiler_CompileBuffer_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IMofCompiler_CreateBMOF_Proxy(byval This as IMofCompiler ptr, byval TextFileName as LPWSTR, byval BMOFFileName as LPWSTR, byval ServerAndNamespace as LPWSTR, byval lOptionFlags as LONG, byval lClassFlags as LONG, byval lInstanceFlags as LONG, byval pInfo as WBEM_COMPILE_STATUS_INFO ptr) as HRESULT
declare sub IMofCompiler_CreateBMOF_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

type tag_WBEM_UNSECAPP_FLAG_TYPE as long
enum
	WBEM_FLAG_UNSECAPP_DEFAULT_CHECK_ACCESS = 0
	WBEM_FLAG_UNSECAPP_CHECK_ACCESS = 1
	WBEM_FLAG_UNSECAPP_DONT_CHECK_ACCESS = 2
end enum

type WBEM_UNSECAPP_FLAG_TYPE as tag_WBEM_UNSECAPP_FLAG_TYPE
extern __MIDL_itf_wbemcli_0127_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_wbemcli_0127_v0_0_s_ifspec as RPC_IF_HANDLE

type tag_WBEM_INFORMATION_FLAG_TYPE as long
enum
	WBEM_FLAG_SHORT_NAME = &h1
	WBEM_FLAG_LONG_NAME = &h2
end enum

type WBEM_INFORMATION_FLAG_TYPE as tag_WBEM_INFORMATION_FLAG_TYPE
extern __MIDL_itf_wbemcli_0128_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_wbemcli_0128_v0_0_s_ifspec as RPC_IF_HANDLE

end extern

#include once "ole-common.bi"
