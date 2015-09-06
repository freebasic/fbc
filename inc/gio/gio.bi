'' FreeBASIC binding for glib-2.44.1
''
'' based on the C header files:
''   GIO - GLib Input, Output and Streaming Library
''
''   Copyright (C) 2006-2007 Red Hat, Inc.
''
''   This library is free software; you can redistribute it and/or
''   modify it under the terms of the GNU Lesser General Public
''   License as published by the Free Software Foundation; either
''   version 2 of the License, or (at your option) any later version.
''
''   This library is distributed in the hope that it will be useful,
''   but WITHOUT ANY WARRANTY; without even the implied warranty of
''   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
''   Lesser General Public License for more details.
''
''   You should have received a copy of the GNU Lesser General
''   Public License along with this library; if not, see <http://www.gnu.org/licenses/>.
''
''   Author: Alexander Larsson <alexl@redhat.com>
''
'' translated to FreeBASIC by:
''   (C) 2011, 2012 Thomas[ dot ]Freiherr[ at ]gmx[ dot ]net
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "gio-2.0"

#include once "glib-object.bi"

#ifdef __FB_UNIX__
	#include once "crt/sys/types.bi"
#endif

#include once "glib.bi"
#include once "gmodule.bi"

'' The following symbols have been renamed:
''     procedure g_file_monitor => g_file_monitor_

#ifdef __FB_WIN32__
#pragma push(msbitfields)
#endif

extern "C"

#define __G_IO_H__
#define __GIO_GIO_H_INSIDE__
#define __GIO_TYPES_H__
#define __GIO_ENUMS_H__

type GAppInfoCreateFlags as long
enum
	G_APP_INFO_CREATE_NONE = 0
	G_APP_INFO_CREATE_NEEDS_TERMINAL = 1 shl 0
	G_APP_INFO_CREATE_SUPPORTS_URIS = 1 shl 1
	G_APP_INFO_CREATE_SUPPORTS_STARTUP_NOTIFICATION = 1 shl 2
end enum

type GConverterFlags as long
enum
	G_CONVERTER_NO_FLAGS = 0
	G_CONVERTER_INPUT_AT_END = 1 shl 0
	G_CONVERTER_FLUSH = 1 shl 1
end enum

type GConverterResult as long
enum
	G_CONVERTER_ERROR = 0
	G_CONVERTER_CONVERTED = 1
	G_CONVERTER_FINISHED = 2
	G_CONVERTER_FLUSHED = 3
end enum

type GDataStreamByteOrder as long
enum
	G_DATA_STREAM_BYTE_ORDER_BIG_ENDIAN
	G_DATA_STREAM_BYTE_ORDER_LITTLE_ENDIAN
	G_DATA_STREAM_BYTE_ORDER_HOST_ENDIAN
end enum

type GDataStreamNewlineType as long
enum
	G_DATA_STREAM_NEWLINE_TYPE_LF
	G_DATA_STREAM_NEWLINE_TYPE_CR
	G_DATA_STREAM_NEWLINE_TYPE_CR_LF
	G_DATA_STREAM_NEWLINE_TYPE_ANY
end enum

type GFileAttributeType as long
enum
	G_FILE_ATTRIBUTE_TYPE_INVALID = 0
	G_FILE_ATTRIBUTE_TYPE_STRING
	G_FILE_ATTRIBUTE_TYPE_BYTE_STRING
	G_FILE_ATTRIBUTE_TYPE_BOOLEAN
	G_FILE_ATTRIBUTE_TYPE_UINT32
	G_FILE_ATTRIBUTE_TYPE_INT32
	G_FILE_ATTRIBUTE_TYPE_UINT64
	G_FILE_ATTRIBUTE_TYPE_INT64
	G_FILE_ATTRIBUTE_TYPE_OBJECT
	G_FILE_ATTRIBUTE_TYPE_STRINGV
end enum

type GFileAttributeInfoFlags as long
enum
	G_FILE_ATTRIBUTE_INFO_NONE = 0
	G_FILE_ATTRIBUTE_INFO_COPY_WITH_FILE = 1 shl 0
	G_FILE_ATTRIBUTE_INFO_COPY_WHEN_MOVED = 1 shl 1
end enum

type GFileAttributeStatus as long
enum
	G_FILE_ATTRIBUTE_STATUS_UNSET = 0
	G_FILE_ATTRIBUTE_STATUS_SET
	G_FILE_ATTRIBUTE_STATUS_ERROR_SETTING
end enum

type GFileQueryInfoFlags as long
enum
	G_FILE_QUERY_INFO_NONE = 0
	G_FILE_QUERY_INFO_NOFOLLOW_SYMLINKS = 1 shl 0
end enum

type GFileCreateFlags as long
enum
	G_FILE_CREATE_NONE = 0
	G_FILE_CREATE_PRIVATE = 1 shl 0
	G_FILE_CREATE_REPLACE_DESTINATION = 1 shl 1
end enum

type GFileMeasureFlags as long
enum
	G_FILE_MEASURE_NONE = 0
	G_FILE_MEASURE_REPORT_ANY_ERROR = 1 shl 1
	G_FILE_MEASURE_APPARENT_SIZE = 1 shl 2
	G_FILE_MEASURE_NO_XDEV = 1 shl 3
end enum

type GMountMountFlags as long
enum
	G_MOUNT_MOUNT_NONE = 0
end enum

type GMountUnmountFlags as long
enum
	G_MOUNT_UNMOUNT_NONE = 0
	G_MOUNT_UNMOUNT_FORCE = 1 shl 0
end enum

type GDriveStartFlags as long
enum
	G_DRIVE_START_NONE = 0
end enum

type GDriveStartStopType as long
enum
	G_DRIVE_START_STOP_TYPE_UNKNOWN
	G_DRIVE_START_STOP_TYPE_SHUTDOWN
	G_DRIVE_START_STOP_TYPE_NETWORK
	G_DRIVE_START_STOP_TYPE_MULTIDISK
	G_DRIVE_START_STOP_TYPE_PASSWORD
end enum

type GFileCopyFlags as long
enum
	G_FILE_COPY_NONE = 0
	G_FILE_COPY_OVERWRITE = 1 shl 0
	G_FILE_COPY_BACKUP = 1 shl 1
	G_FILE_COPY_NOFOLLOW_SYMLINKS = 1 shl 2
	G_FILE_COPY_ALL_METADATA = 1 shl 3
	G_FILE_COPY_NO_FALLBACK_FOR_MOVE = 1 shl 4
	G_FILE_COPY_TARGET_DEFAULT_PERMS = 1 shl 5
end enum

type GFileMonitorFlags as long
enum
	G_FILE_MONITOR_NONE = 0
	G_FILE_MONITOR_WATCH_MOUNTS = 1 shl 0
	G_FILE_MONITOR_SEND_MOVED = 1 shl 1
	G_FILE_MONITOR_WATCH_HARD_LINKS = 1 shl 2
end enum

type GFileType as long
enum
	G_FILE_TYPE_UNKNOWN = 0
	G_FILE_TYPE_REGULAR
	G_FILE_TYPE_DIRECTORY
	G_FILE_TYPE_SYMBOLIC_LINK
	G_FILE_TYPE_SPECIAL
	G_FILE_TYPE_SHORTCUT
	G_FILE_TYPE_MOUNTABLE
end enum

type GFilesystemPreviewType as long
enum
	G_FILESYSTEM_PREVIEW_TYPE_IF_ALWAYS = 0
	G_FILESYSTEM_PREVIEW_TYPE_IF_LOCAL
	G_FILESYSTEM_PREVIEW_TYPE_NEVER
end enum

type GFileMonitorEvent as long
enum
	G_FILE_MONITOR_EVENT_CHANGED
	G_FILE_MONITOR_EVENT_CHANGES_DONE_HINT
	G_FILE_MONITOR_EVENT_DELETED
	G_FILE_MONITOR_EVENT_CREATED
	G_FILE_MONITOR_EVENT_ATTRIBUTE_CHANGED
	G_FILE_MONITOR_EVENT_PRE_UNMOUNT
	G_FILE_MONITOR_EVENT_UNMOUNTED
	G_FILE_MONITOR_EVENT_MOVED
end enum

type GIOErrorEnum as long
enum
	G_IO_ERROR_FAILED
	G_IO_ERROR_NOT_FOUND
	G_IO_ERROR_EXISTS
	G_IO_ERROR_IS_DIRECTORY
	G_IO_ERROR_NOT_DIRECTORY
	G_IO_ERROR_NOT_EMPTY
	G_IO_ERROR_NOT_REGULAR_FILE
	G_IO_ERROR_NOT_SYMBOLIC_LINK
	G_IO_ERROR_NOT_MOUNTABLE_FILE
	G_IO_ERROR_FILENAME_TOO_LONG
	G_IO_ERROR_INVALID_FILENAME
	G_IO_ERROR_TOO_MANY_LINKS
	G_IO_ERROR_NO_SPACE
	G_IO_ERROR_INVALID_ARGUMENT
	G_IO_ERROR_PERMISSION_DENIED
	G_IO_ERROR_NOT_SUPPORTED
	G_IO_ERROR_NOT_MOUNTED
	G_IO_ERROR_ALREADY_MOUNTED
	G_IO_ERROR_CLOSED
	G_IO_ERROR_CANCELLED
	G_IO_ERROR_PENDING
	G_IO_ERROR_READ_ONLY
	G_IO_ERROR_CANT_CREATE_BACKUP
	G_IO_ERROR_WRONG_ETAG
	G_IO_ERROR_TIMED_OUT
	G_IO_ERROR_WOULD_RECURSE
	G_IO_ERROR_BUSY
	G_IO_ERROR_WOULD_BLOCK
	G_IO_ERROR_HOST_NOT_FOUND
	G_IO_ERROR_WOULD_MERGE
	G_IO_ERROR_FAILED_HANDLED
	G_IO_ERROR_TOO_MANY_OPEN_FILES
	G_IO_ERROR_NOT_INITIALIZED
	G_IO_ERROR_ADDRESS_IN_USE
	G_IO_ERROR_PARTIAL_INPUT
	G_IO_ERROR_INVALID_DATA
	G_IO_ERROR_DBUS_ERROR
	G_IO_ERROR_HOST_UNREACHABLE
	G_IO_ERROR_NETWORK_UNREACHABLE
	G_IO_ERROR_CONNECTION_REFUSED
	G_IO_ERROR_PROXY_FAILED
	G_IO_ERROR_PROXY_AUTH_FAILED
	G_IO_ERROR_PROXY_NEED_AUTH
	G_IO_ERROR_PROXY_NOT_ALLOWED
	G_IO_ERROR_BROKEN_PIPE
	G_IO_ERROR_CONNECTION_CLOSED = G_IO_ERROR_BROKEN_PIPE
	G_IO_ERROR_NOT_CONNECTED
end enum

type GAskPasswordFlags as long
enum
	G_ASK_PASSWORD_NEED_PASSWORD = 1 shl 0
	G_ASK_PASSWORD_NEED_USERNAME = 1 shl 1
	G_ASK_PASSWORD_NEED_DOMAIN = 1 shl 2
	G_ASK_PASSWORD_SAVING_SUPPORTED = 1 shl 3
	G_ASK_PASSWORD_ANONYMOUS_SUPPORTED = 1 shl 4
end enum

type GPasswordSave as long
enum
	G_PASSWORD_SAVE_NEVER
	G_PASSWORD_SAVE_FOR_SESSION
	G_PASSWORD_SAVE_PERMANENTLY
end enum

type GMountOperationResult as long
enum
	G_MOUNT_OPERATION_HANDLED
	G_MOUNT_OPERATION_ABORTED
	G_MOUNT_OPERATION_UNHANDLED
end enum

type GOutputStreamSpliceFlags as long
enum
	G_OUTPUT_STREAM_SPLICE_NONE = 0
	G_OUTPUT_STREAM_SPLICE_CLOSE_SOURCE = 1 shl 0
	G_OUTPUT_STREAM_SPLICE_CLOSE_TARGET = 1 shl 1
end enum

type GIOStreamSpliceFlags as long
enum
	G_IO_STREAM_SPLICE_NONE = 0
	G_IO_STREAM_SPLICE_CLOSE_STREAM1 = 1 shl 0
	G_IO_STREAM_SPLICE_CLOSE_STREAM2 = 1 shl 1
	G_IO_STREAM_SPLICE_WAIT_FOR_BOTH = 1 shl 2
end enum

type GEmblemOrigin as long
enum
	G_EMBLEM_ORIGIN_UNKNOWN
	G_EMBLEM_ORIGIN_DEVICE
	G_EMBLEM_ORIGIN_LIVEMETADATA
	G_EMBLEM_ORIGIN_TAG
end enum

type GResolverError as long
enum
	G_RESOLVER_ERROR_NOT_FOUND
	G_RESOLVER_ERROR_TEMPORARY_FAILURE
	G_RESOLVER_ERROR_INTERNAL
end enum

type GResolverRecordType as long
enum
	G_RESOLVER_RECORD_SRV = 1
	G_RESOLVER_RECORD_MX
	G_RESOLVER_RECORD_TXT
	G_RESOLVER_RECORD_SOA
	G_RESOLVER_RECORD_NS
end enum

type GResourceError as long
enum
	G_RESOURCE_ERROR_NOT_FOUND
	G_RESOURCE_ERROR_INTERNAL
end enum

type GResourceFlags as long
enum
	G_RESOURCE_FLAGS_NONE = 0
	G_RESOURCE_FLAGS_COMPRESSED = 1 shl 0
end enum

type GResourceLookupFlags as long
enum
	G_RESOURCE_LOOKUP_FLAGS_NONE = 0
end enum

type GSocketFamily as long
enum
	G_SOCKET_FAMILY_INVALID
	G_SOCKET_FAMILY_UNIX = 1
	G_SOCKET_FAMILY_IPV4 = 2

	#ifdef __FB_LINUX__
		G_SOCKET_FAMILY_IPV6 = 10
	#elseif defined(__FB_FREEBSD__)
		G_SOCKET_FAMILY_IPV6 = 28
	#elseif defined(__FB_OPENBSD__) or defined(__FB_NETBSD__)
		G_SOCKET_FAMILY_IPV6 = 24
	#elseif defined(__FB_DARWIN__)
		G_SOCKET_FAMILY_IPV6 = 30
	#else
		G_SOCKET_FAMILY_IPV6 = 23
	#endif
end enum

type GSocketType as long
enum
	G_SOCKET_TYPE_INVALID
	G_SOCKET_TYPE_STREAM
	G_SOCKET_TYPE_DATAGRAM
	G_SOCKET_TYPE_SEQPACKET
end enum

type GSocketMsgFlags as long
enum
	G_SOCKET_MSG_NONE
	G_SOCKET_MSG_OOB = 1
	G_SOCKET_MSG_PEEK = 2
	G_SOCKET_MSG_DONTROUTE = 4
end enum

type GSocketProtocol as long
enum
	G_SOCKET_PROTOCOL_UNKNOWN = -1
	G_SOCKET_PROTOCOL_DEFAULT = 0
	G_SOCKET_PROTOCOL_TCP = 6
	G_SOCKET_PROTOCOL_UDP = 17
	G_SOCKET_PROTOCOL_SCTP = 132
end enum

type GZlibCompressorFormat as long
enum
	G_ZLIB_COMPRESSOR_FORMAT_ZLIB
	G_ZLIB_COMPRESSOR_FORMAT_GZIP
	G_ZLIB_COMPRESSOR_FORMAT_RAW
end enum

type GUnixSocketAddressType as long
enum
	G_UNIX_SOCKET_ADDRESS_INVALID
	G_UNIX_SOCKET_ADDRESS_ANONYMOUS
	G_UNIX_SOCKET_ADDRESS_PATH
	G_UNIX_SOCKET_ADDRESS_ABSTRACT
	G_UNIX_SOCKET_ADDRESS_ABSTRACT_PADDED
end enum

type GBusType as long
enum
	G_BUS_TYPE_STARTER = -1
	G_BUS_TYPE_NONE = 0
	G_BUS_TYPE_SYSTEM = 1
	G_BUS_TYPE_SESSION = 2
end enum

type GBusNameOwnerFlags as long
enum
	G_BUS_NAME_OWNER_FLAGS_NONE = 0
	G_BUS_NAME_OWNER_FLAGS_ALLOW_REPLACEMENT = 1 shl 0
	G_BUS_NAME_OWNER_FLAGS_REPLACE = 1 shl 1
end enum

type GBusNameWatcherFlags as long
enum
	G_BUS_NAME_WATCHER_FLAGS_NONE = 0
	G_BUS_NAME_WATCHER_FLAGS_AUTO_START = 1 shl 0
end enum

type GDBusProxyFlags as long
enum
	G_DBUS_PROXY_FLAGS_NONE = 0
	G_DBUS_PROXY_FLAGS_DO_NOT_LOAD_PROPERTIES = 1 shl 0
	G_DBUS_PROXY_FLAGS_DO_NOT_CONNECT_SIGNALS = 1 shl 1
	G_DBUS_PROXY_FLAGS_DO_NOT_AUTO_START = 1 shl 2
	G_DBUS_PROXY_FLAGS_GET_INVALIDATED_PROPERTIES = 1 shl 3
	G_DBUS_PROXY_FLAGS_DO_NOT_AUTO_START_AT_CONSTRUCTION = 1 shl 4
end enum

type GDBusError as long
enum
	G_DBUS_ERROR_FAILED
	G_DBUS_ERROR_NO_MEMORY
	G_DBUS_ERROR_SERVICE_UNKNOWN
	G_DBUS_ERROR_NAME_HAS_NO_OWNER
	G_DBUS_ERROR_NO_REPLY
	G_DBUS_ERROR_IO_ERROR
	G_DBUS_ERROR_BAD_ADDRESS
	G_DBUS_ERROR_NOT_SUPPORTED
	G_DBUS_ERROR_LIMITS_EXCEEDED
	G_DBUS_ERROR_ACCESS_DENIED
	G_DBUS_ERROR_AUTH_FAILED
	G_DBUS_ERROR_NO_SERVER
	G_DBUS_ERROR_TIMEOUT
	G_DBUS_ERROR_NO_NETWORK
	G_DBUS_ERROR_ADDRESS_IN_USE
	G_DBUS_ERROR_DISCONNECTED
	G_DBUS_ERROR_INVALID_ARGS
	G_DBUS_ERROR_FILE_NOT_FOUND
	G_DBUS_ERROR_FILE_EXISTS
	G_DBUS_ERROR_UNKNOWN_METHOD
	G_DBUS_ERROR_TIMED_OUT
	G_DBUS_ERROR_MATCH_RULE_NOT_FOUND
	G_DBUS_ERROR_MATCH_RULE_INVALID
	G_DBUS_ERROR_SPAWN_EXEC_FAILED
	G_DBUS_ERROR_SPAWN_FORK_FAILED
	G_DBUS_ERROR_SPAWN_CHILD_EXITED
	G_DBUS_ERROR_SPAWN_CHILD_SIGNALED
	G_DBUS_ERROR_SPAWN_FAILED
	G_DBUS_ERROR_SPAWN_SETUP_FAILED
	G_DBUS_ERROR_SPAWN_CONFIG_INVALID
	G_DBUS_ERROR_SPAWN_SERVICE_INVALID
	G_DBUS_ERROR_SPAWN_SERVICE_NOT_FOUND
	G_DBUS_ERROR_SPAWN_PERMISSIONS_INVALID
	G_DBUS_ERROR_SPAWN_FILE_INVALID
	G_DBUS_ERROR_SPAWN_NO_MEMORY
	G_DBUS_ERROR_UNIX_PROCESS_ID_UNKNOWN
	G_DBUS_ERROR_INVALID_SIGNATURE
	G_DBUS_ERROR_INVALID_FILE_CONTENT
	G_DBUS_ERROR_SELINUX_SECURITY_CONTEXT_UNKNOWN
	G_DBUS_ERROR_ADT_AUDIT_DATA_UNKNOWN
	G_DBUS_ERROR_OBJECT_PATH_IN_USE
	G_DBUS_ERROR_UNKNOWN_OBJECT
	G_DBUS_ERROR_UNKNOWN_INTERFACE
	G_DBUS_ERROR_UNKNOWN_PROPERTY
	G_DBUS_ERROR_PROPERTY_READ_ONLY
end enum

type GDBusConnectionFlags as long
enum
	G_DBUS_CONNECTION_FLAGS_NONE = 0
	G_DBUS_CONNECTION_FLAGS_AUTHENTICATION_CLIENT = 1 shl 0
	G_DBUS_CONNECTION_FLAGS_AUTHENTICATION_SERVER = 1 shl 1
	G_DBUS_CONNECTION_FLAGS_AUTHENTICATION_ALLOW_ANONYMOUS = 1 shl 2
	G_DBUS_CONNECTION_FLAGS_MESSAGE_BUS_CONNECTION = 1 shl 3
	G_DBUS_CONNECTION_FLAGS_DELAY_MESSAGE_PROCESSING = 1 shl 4
end enum

type GDBusCapabilityFlags as long
enum
	G_DBUS_CAPABILITY_FLAGS_NONE = 0
	G_DBUS_CAPABILITY_FLAGS_UNIX_FD_PASSING = 1 shl 0
end enum

type GDBusCallFlags as long
enum
	G_DBUS_CALL_FLAGS_NONE = 0
	G_DBUS_CALL_FLAGS_NO_AUTO_START = 1 shl 0
end enum

type GDBusMessageType as long
enum
	G_DBUS_MESSAGE_TYPE_INVALID
	G_DBUS_MESSAGE_TYPE_METHOD_CALL
	G_DBUS_MESSAGE_TYPE_METHOD_RETURN
	G_DBUS_MESSAGE_TYPE_ERROR
	G_DBUS_MESSAGE_TYPE_SIGNAL
end enum

type GDBusMessageFlags as long
enum
	G_DBUS_MESSAGE_FLAGS_NONE = 0
	G_DBUS_MESSAGE_FLAGS_NO_REPLY_EXPECTED = 1 shl 0
	G_DBUS_MESSAGE_FLAGS_NO_AUTO_START = 1 shl 1
end enum

type GDBusMessageHeaderField as long
enum
	G_DBUS_MESSAGE_HEADER_FIELD_INVALID
	G_DBUS_MESSAGE_HEADER_FIELD_PATH
	G_DBUS_MESSAGE_HEADER_FIELD_INTERFACE
	G_DBUS_MESSAGE_HEADER_FIELD_MEMBER
	G_DBUS_MESSAGE_HEADER_FIELD_ERROR_NAME
	G_DBUS_MESSAGE_HEADER_FIELD_REPLY_SERIAL
	G_DBUS_MESSAGE_HEADER_FIELD_DESTINATION
	G_DBUS_MESSAGE_HEADER_FIELD_SENDER
	G_DBUS_MESSAGE_HEADER_FIELD_SIGNATURE
	G_DBUS_MESSAGE_HEADER_FIELD_NUM_UNIX_FDS
end enum

type GDBusPropertyInfoFlags as long
enum
	G_DBUS_PROPERTY_INFO_FLAGS_NONE = 0
	G_DBUS_PROPERTY_INFO_FLAGS_READABLE = 1 shl 0
	G_DBUS_PROPERTY_INFO_FLAGS_WRITABLE = 1 shl 1
end enum

type GDBusSubtreeFlags as long
enum
	G_DBUS_SUBTREE_FLAGS_NONE = 0
	G_DBUS_SUBTREE_FLAGS_DISPATCH_TO_UNENUMERATED_NODES = 1 shl 0
end enum

type GDBusServerFlags as long
enum
	G_DBUS_SERVER_FLAGS_NONE = 0
	G_DBUS_SERVER_FLAGS_RUN_IN_THREAD = 1 shl 0
	G_DBUS_SERVER_FLAGS_AUTHENTICATION_ALLOW_ANONYMOUS = 1 shl 1
end enum

type GDBusSignalFlags as long
enum
	G_DBUS_SIGNAL_FLAGS_NONE = 0
	G_DBUS_SIGNAL_FLAGS_NO_MATCH_RULE = 1 shl 0
	G_DBUS_SIGNAL_FLAGS_MATCH_ARG0_NAMESPACE = 1 shl 1
	G_DBUS_SIGNAL_FLAGS_MATCH_ARG0_PATH = 1 shl 2
end enum

type GDBusSendMessageFlags as long
enum
	G_DBUS_SEND_MESSAGE_FLAGS_NONE = 0
	G_DBUS_SEND_MESSAGE_FLAGS_PRESERVE_SERIAL = 1 shl 0
end enum

type GCredentialsType as long
enum
	G_CREDENTIALS_TYPE_INVALID
	G_CREDENTIALS_TYPE_LINUX_UCRED
	G_CREDENTIALS_TYPE_FREEBSD_CMSGCRED
	G_CREDENTIALS_TYPE_OPENBSD_SOCKPEERCRED
	G_CREDENTIALS_TYPE_SOLARIS_UCRED
	G_CREDENTIALS_TYPE_NETBSD_UNPCBID
end enum

type GDBusMessageByteOrder as long
enum
	G_DBUS_MESSAGE_BYTE_ORDER_BIG_ENDIAN = asc("B")
	G_DBUS_MESSAGE_BYTE_ORDER_LITTLE_ENDIAN = asc("l")
end enum

type GApplicationFlags as long
enum
	G_APPLICATION_FLAGS_NONE
	G_APPLICATION_IS_SERVICE = 1 shl 0
	G_APPLICATION_IS_LAUNCHER = 1 shl 1
	G_APPLICATION_HANDLES_OPEN = 1 shl 2
	G_APPLICATION_HANDLES_COMMAND_LINE = 1 shl 3
	G_APPLICATION_SEND_ENVIRONMENT = 1 shl 4
	G_APPLICATION_NON_UNIQUE = 1 shl 5
end enum

type GTlsError as long
enum
	G_TLS_ERROR_UNAVAILABLE
	G_TLS_ERROR_MISC
	G_TLS_ERROR_BAD_CERTIFICATE
	G_TLS_ERROR_NOT_TLS
	G_TLS_ERROR_HANDSHAKE
	G_TLS_ERROR_CERTIFICATE_REQUIRED
	G_TLS_ERROR_EOF
end enum

type GTlsCertificateFlags as long
enum
	G_TLS_CERTIFICATE_UNKNOWN_CA = 1 shl 0
	G_TLS_CERTIFICATE_BAD_IDENTITY = 1 shl 1
	G_TLS_CERTIFICATE_NOT_ACTIVATED = 1 shl 2
	G_TLS_CERTIFICATE_EXPIRED = 1 shl 3
	G_TLS_CERTIFICATE_REVOKED = 1 shl 4
	G_TLS_CERTIFICATE_INSECURE = 1 shl 5
	G_TLS_CERTIFICATE_GENERIC_ERROR = 1 shl 6
	G_TLS_CERTIFICATE_VALIDATE_ALL = &h007f
end enum

type GTlsAuthenticationMode as long
enum
	G_TLS_AUTHENTICATION_NONE
	G_TLS_AUTHENTICATION_REQUESTED
	G_TLS_AUTHENTICATION_REQUIRED
end enum

type GTlsRehandshakeMode as long
enum
	G_TLS_REHANDSHAKE_NEVER
	G_TLS_REHANDSHAKE_SAFELY
	G_TLS_REHANDSHAKE_UNSAFELY
end enum

type _GTlsPasswordFlags as long
enum
	G_TLS_PASSWORD_NONE = 0
	G_TLS_PASSWORD_RETRY = 1 shl 1
	G_TLS_PASSWORD_MANY_TRIES = 1 shl 2
	G_TLS_PASSWORD_FINAL_TRY = 1 shl 3
end enum

type GTlsPasswordFlags as _GTlsPasswordFlags

type GTlsInteractionResult as long
enum
	G_TLS_INTERACTION_UNHANDLED
	G_TLS_INTERACTION_HANDLED
	G_TLS_INTERACTION_FAILED
end enum

type GDBusInterfaceSkeletonFlags as long
enum
	G_DBUS_INTERFACE_SKELETON_FLAGS_NONE = 0
	G_DBUS_INTERFACE_SKELETON_FLAGS_HANDLE_METHOD_INVOCATIONS_IN_THREAD = 1 shl 0
end enum

type GDBusObjectManagerClientFlags as long
enum
	G_DBUS_OBJECT_MANAGER_CLIENT_FLAGS_NONE = 0
	G_DBUS_OBJECT_MANAGER_CLIENT_FLAGS_DO_NOT_AUTO_START = 1 shl 0
end enum

type GTlsDatabaseVerifyFlags as long
enum
	G_TLS_DATABASE_VERIFY_NONE = 0
end enum

type GTlsDatabaseLookupFlags as long
enum
	G_TLS_DATABASE_LOOKUP_NONE = 0
	G_TLS_DATABASE_LOOKUP_KEYPAIR = 1
end enum

type GTlsCertificateRequestFlags as long
enum
	G_TLS_CERTIFICATE_REQUEST_NONE = 0
end enum

type GIOModuleScopeFlags as long
enum
	G_IO_MODULE_SCOPE_NONE
	G_IO_MODULE_SCOPE_BLOCK_DUPLICATES
end enum

type GSocketClientEvent as long
enum
	G_SOCKET_CLIENT_RESOLVING
	G_SOCKET_CLIENT_RESOLVED
	G_SOCKET_CLIENT_CONNECTING
	G_SOCKET_CLIENT_CONNECTED
	G_SOCKET_CLIENT_PROXY_NEGOTIATING
	G_SOCKET_CLIENT_PROXY_NEGOTIATED
	G_SOCKET_CLIENT_TLS_HANDSHAKING
	G_SOCKET_CLIENT_TLS_HANDSHAKED
	G_SOCKET_CLIENT_COMPLETE
end enum

type GTestDBusFlags as long
enum
	G_TEST_DBUS_NONE = 0
end enum

type GSubprocessFlags as long
enum
	G_SUBPROCESS_FLAGS_NONE = 0
	G_SUBPROCESS_FLAGS_STDIN_PIPE = culng(1u shl 0)
	G_SUBPROCESS_FLAGS_STDIN_INHERIT = culng(1u shl 1)
	G_SUBPROCESS_FLAGS_STDOUT_PIPE = culng(1u shl 2)
	G_SUBPROCESS_FLAGS_STDOUT_SILENCE = culng(1u shl 3)
	G_SUBPROCESS_FLAGS_STDERR_PIPE = culng(1u shl 4)
	G_SUBPROCESS_FLAGS_STDERR_SILENCE = culng(1u shl 5)
	G_SUBPROCESS_FLAGS_STDERR_MERGE = culng(1u shl 6)
	G_SUBPROCESS_FLAGS_INHERIT_FDS = culng(1u shl 7)
end enum

type GNotificationPriority as long
enum
	G_NOTIFICATION_PRIORITY_NORMAL
	G_NOTIFICATION_PRIORITY_LOW
	G_NOTIFICATION_PRIORITY_HIGH
	G_NOTIFICATION_PRIORITY_URGENT
end enum

type GNetworkConnectivity as long
enum
	G_NETWORK_CONNECTIVITY_LOCAL = 1
	G_NETWORK_CONNECTIVITY_LIMITED = 2
	G_NETWORK_CONNECTIVITY_PORTAL = 3
	G_NETWORK_CONNECTIVITY_FULL = 4
end enum

type GAppLaunchContext as _GAppLaunchContext
type GAppInfo as _GAppInfo
type GAsyncResult as _GAsyncResult
type GAsyncInitable as _GAsyncInitable
type GBufferedInputStream as _GBufferedInputStream
type GBufferedOutputStream as _GBufferedOutputStream
type GCancellable as _GCancellable
type GCharsetConverter as _GCharsetConverter
type GConverter as _GConverter
type GConverterInputStream as _GConverterInputStream
type GConverterOutputStream as _GConverterOutputStream
type GDataInputStream as _GDataInputStream
type GSimplePermission as _GSimplePermission
type GZlibCompressor as _GZlibCompressor
type GZlibDecompressor as _GZlibDecompressor
type GSimpleActionGroup as _GSimpleActionGroup
type GRemoteActionGroup as _GRemoteActionGroup
type GDBusActionGroup as _GDBusActionGroup
type GActionMap as _GActionMap
type GActionGroup as _GActionGroup
type GPropertyAction as _GPropertyAction
type GSimpleAction as _GSimpleAction
type GAction as _GAction
type GApplication as _GApplication
type GApplicationCommandLine as _GApplicationCommandLine
type GSettingsBackend as _GSettingsBackend
type GSettings as _GSettings
type GPermission as _GPermission
type GMenuModel as _GMenuModel
type GNotification as _GNotification
type GDrive as _GDrive
type GFileEnumerator as _GFileEnumerator
type GFileMonitor as _GFileMonitor
type GFilterInputStream as _GFilterInputStream
type GFilterOutputStream as _GFilterOutputStream
type GFile as _GFile
type GFileInfo as _GFileInfo
type GFileAttributeMatcher as _GFileAttributeMatcher
type GFileAttributeInfo as _GFileAttributeInfo
type GFileAttributeInfoList as _GFileAttributeInfoList
type GFileDescriptorBased as _GFileDescriptorBased
type GFileInputStream as _GFileInputStream
type GFileOutputStream as _GFileOutputStream
type GFileIOStream as _GFileIOStream
type GFileIcon as _GFileIcon
type GFilenameCompleter as _GFilenameCompleter
type GIcon as _GIcon
type GInetAddress as _GInetAddress
type GInetAddressMask as _GInetAddressMask
type GInetSocketAddress as _GInetSocketAddress
type GInputStream as _GInputStream
type GInitable as _GInitable
type GIOModule as _GIOModule
type GIOExtensionPoint as _GIOExtensionPoint
type GIOExtension as _GIOExtension
type GIOSchedulerJob as _GIOSchedulerJob
type GIOStreamAdapter as _GIOStreamAdapter
type GLoadableIcon as _GLoadableIcon
type GBytesIcon as _GBytesIcon
type GMemoryInputStream as _GMemoryInputStream
type GMemoryOutputStream as _GMemoryOutputStream
type GMount as _GMount
type GMountOperation as _GMountOperation
type GNetworkAddress as _GNetworkAddress
type GNetworkMonitor as _GNetworkMonitor
type GNetworkService as _GNetworkService
type GOutputStream as _GOutputStream
type GIOStream as _GIOStream
type GSimpleIOStream as _GSimpleIOStream
type GPollableInputStream as _GPollableInputStream
type GPollableOutputStream as _GPollableOutputStream
type GResolver as _GResolver
type GResource as _GResource
type GSeekable as _GSeekable
type GSimpleAsyncResult as _GSimpleAsyncResult
type GSocket as _GSocket
type GSocketControlMessage as _GSocketControlMessage
type GSocketClient as _GSocketClient
type GSocketConnection as _GSocketConnection
type GSocketListener as _GSocketListener
type GSocketService as _GSocketService
type GSocketAddress as _GSocketAddress
type GSocketAddressEnumerator as _GSocketAddressEnumerator
type GSocketConnectable as _GSocketConnectable
type GSrvTarget as _GSrvTarget
type GTask as _GTask
type GTcpConnection as _GTcpConnection
type GTcpWrapperConnection as _GTcpWrapperConnection
type GThreadedSocketService as _GThreadedSocketService
type GThemedIcon as _GThemedIcon
type GTlsCertificate as _GTlsCertificate
type GTlsClientConnection as _GTlsClientConnection
type GTlsConnection as _GTlsConnection
type GTlsDatabase as _GTlsDatabase
type GTlsFileDatabase as _GTlsFileDatabase
type GTlsInteraction as _GTlsInteraction
type GTlsPassword as _GTlsPassword
type GTlsServerConnection as _GTlsServerConnection
type GVfs as _GVfs
type GProxyResolver as _GProxyResolver
type GProxy as _GProxy
type GProxyAddress as _GProxyAddress
type GProxyAddressEnumerator as _GProxyAddressEnumerator
type GVolume as _GVolume
type GVolumeMonitor as _GVolumeMonitor
type GAsyncReadyCallback as sub(byval source_object as GObject ptr, byval res as GAsyncResult ptr, byval user_data as gpointer)
type GFileProgressCallback as sub(byval current_num_bytes as goffset, byval total_num_bytes as goffset, byval user_data as gpointer)
type GFileReadMoreCallback as function(byval file_contents as const zstring ptr, byval file_size as goffset, byval callback_data as gpointer) as gboolean
type GFileMeasureProgressCallback as sub(byval reporting as gboolean, byval current_size as guint64, byval num_dirs as guint64, byval num_files as guint64, byval user_data as gpointer)
type GIOSchedulerJobFunc as function(byval job as GIOSchedulerJob ptr, byval cancellable as GCancellable ptr, byval user_data as gpointer) as gboolean
type GSimpleAsyncThreadFunc as sub(byval res as GSimpleAsyncResult ptr, byval object as GObject ptr, byval cancellable as GCancellable ptr)
type GSocketSourceFunc as function(byval socket as GSocket ptr, byval condition as GIOCondition, byval user_data as gpointer) as gboolean
type GInputVector as _GInputVector

type _GInputVector
	buffer as gpointer
	size as gsize
end type

type GOutputVector as _GOutputVector

type _GOutputVector
	buffer as gconstpointer
	size as gsize
end type

type GOutputMessage as _GOutputMessage

type _GOutputMessage
	address as GSocketAddress ptr
	vectors as GOutputVector ptr
	num_vectors as guint
	bytes_sent as guint
	control_messages as GSocketControlMessage ptr ptr
	num_control_messages as guint
end type

type GCredentials as _GCredentials
type GUnixCredentialsMessage as _GUnixCredentialsMessage
type GUnixFDList as _GUnixFDList
type GDBusMessage as _GDBusMessage
type GDBusConnection as _GDBusConnection
type GDBusProxy as _GDBusProxy
type GDBusMethodInvocation as _GDBusMethodInvocation
type GDBusServer as _GDBusServer
type GDBusAuthObserver as _GDBusAuthObserver
type GDBusErrorEntry as _GDBusErrorEntry
type GDBusInterfaceVTable as _GDBusInterfaceVTable
type GDBusSubtreeVTable as _GDBusSubtreeVTable
type GDBusAnnotationInfo as _GDBusAnnotationInfo
type GDBusArgInfo as _GDBusArgInfo
type GDBusMethodInfo as _GDBusMethodInfo
type GDBusSignalInfo as _GDBusSignalInfo
type GDBusPropertyInfo as _GDBusPropertyInfo
type GDBusInterfaceInfo as _GDBusInterfaceInfo
type GDBusNodeInfo as _GDBusNodeInfo
type GCancellableSourceFunc as function(byval cancellable as GCancellable ptr, byval user_data as gpointer) as gboolean
type GPollableSourceFunc as function(byval pollable_stream as GObject ptr, byval user_data as gpointer) as gboolean
type GDBusInterface as _GDBusInterface
type GDBusInterfaceSkeleton as _GDBusInterfaceSkeleton
type GDBusObject as _GDBusObject
type GDBusObjectSkeleton as _GDBusObjectSkeleton
type GDBusObjectProxy as _GDBusObjectProxy
type GDBusObjectManager as _GDBusObjectManager
type GDBusObjectManagerClient as _GDBusObjectManagerClient
type GDBusObjectManagerServer as _GDBusObjectManagerServer
type GDBusProxyTypeFunc as function(byval manager as GDBusObjectManagerClient ptr, byval object_path as const gchar ptr, byval interface_name as const gchar ptr, byval user_data as gpointer) as GType
type GTestDBus as _GTestDBus
type GSubprocess as _GSubprocess
type GSubprocessLauncher as _GSubprocessLauncher

#define __G_ACTION_H__
#define G_TYPE_ACTION g_action_get_type()
#define G_ACTION(inst) G_TYPE_CHECK_INSTANCE_CAST((inst), G_TYPE_ACTION, GAction)
#define G_IS_ACTION(inst) G_TYPE_CHECK_INSTANCE_TYPE((inst), G_TYPE_ACTION)
#define G_ACTION_GET_IFACE(inst) G_TYPE_INSTANCE_GET_INTERFACE((inst), G_TYPE_ACTION, GActionInterface)
type GActionInterface as _GActionInterface

type _GActionInterface
	g_iface as GTypeInterface
	get_name as function(byval action as GAction ptr) as const gchar ptr
	get_parameter_type as function(byval action as GAction ptr) as const GVariantType ptr
	get_state_type as function(byval action as GAction ptr) as const GVariantType ptr
	get_state_hint as function(byval action as GAction ptr) as GVariant ptr
	get_enabled as function(byval action as GAction ptr) as gboolean
	get_state as function(byval action as GAction ptr) as GVariant ptr
	change_state as sub(byval action as GAction ptr, byval value as GVariant ptr)
	activate as sub(byval action as GAction ptr, byval parameter as GVariant ptr)
end type

declare function g_action_get_type() as GType
declare function g_action_get_name(byval action as GAction ptr) as const gchar ptr
declare function g_action_get_parameter_type(byval action as GAction ptr) as const GVariantType ptr
declare function g_action_get_state_type(byval action as GAction ptr) as const GVariantType ptr
declare function g_action_get_state_hint(byval action as GAction ptr) as GVariant ptr
declare function g_action_get_enabled(byval action as GAction ptr) as gboolean
declare function g_action_get_state(byval action as GAction ptr) as GVariant ptr
declare sub g_action_change_state(byval action as GAction ptr, byval value as GVariant ptr)
declare sub g_action_activate(byval action as GAction ptr, byval parameter as GVariant ptr)
declare function g_action_name_is_valid(byval action_name as const gchar ptr) as gboolean
declare function g_action_parse_detailed_name(byval detailed_name as const gchar ptr, byval action_name as gchar ptr ptr, byval target_value as GVariant ptr ptr, byval error as GError ptr ptr) as gboolean
declare function g_action_print_detailed_name(byval action_name as const gchar ptr, byval target_value as GVariant ptr) as gchar ptr

#define __G_ACTION_GROUP_H__
#define G_TYPE_ACTION_GROUP g_action_group_get_type()
#define G_ACTION_GROUP(inst) G_TYPE_CHECK_INSTANCE_CAST((inst), G_TYPE_ACTION_GROUP, GActionGroup)
#define G_IS_ACTION_GROUP(inst) G_TYPE_CHECK_INSTANCE_TYPE((inst), G_TYPE_ACTION_GROUP)
#define G_ACTION_GROUP_GET_IFACE(inst) G_TYPE_INSTANCE_GET_INTERFACE((inst), G_TYPE_ACTION_GROUP, GActionGroupInterface)
type GActionGroupInterface as _GActionGroupInterface

type _GActionGroupInterface
	g_iface as GTypeInterface
	has_action as function(byval action_group as GActionGroup ptr, byval action_name as const gchar ptr) as gboolean
	list_actions as function(byval action_group as GActionGroup ptr) as gchar ptr ptr
	get_action_enabled as function(byval action_group as GActionGroup ptr, byval action_name as const gchar ptr) as gboolean
	get_action_parameter_type as function(byval action_group as GActionGroup ptr, byval action_name as const gchar ptr) as const GVariantType ptr
	get_action_state_type as function(byval action_group as GActionGroup ptr, byval action_name as const gchar ptr) as const GVariantType ptr
	get_action_state_hint as function(byval action_group as GActionGroup ptr, byval action_name as const gchar ptr) as GVariant ptr
	get_action_state as function(byval action_group as GActionGroup ptr, byval action_name as const gchar ptr) as GVariant ptr
	change_action_state as sub(byval action_group as GActionGroup ptr, byval action_name as const gchar ptr, byval value as GVariant ptr)
	activate_action as sub(byval action_group as GActionGroup ptr, byval action_name as const gchar ptr, byval parameter as GVariant ptr)
	action_added as sub(byval action_group as GActionGroup ptr, byval action_name as const gchar ptr)
	action_removed as sub(byval action_group as GActionGroup ptr, byval action_name as const gchar ptr)
	action_enabled_changed as sub(byval action_group as GActionGroup ptr, byval action_name as const gchar ptr, byval enabled as gboolean)
	action_state_changed as sub(byval action_group as GActionGroup ptr, byval action_name as const gchar ptr, byval state as GVariant ptr)
	query_action as function(byval action_group as GActionGroup ptr, byval action_name as const gchar ptr, byval enabled as gboolean ptr, byval parameter_type as const GVariantType ptr ptr, byval state_type as const GVariantType ptr ptr, byval state_hint as GVariant ptr ptr, byval state as GVariant ptr ptr) as gboolean
end type

declare function g_action_group_get_type() as GType
declare function g_action_group_has_action(byval action_group as GActionGroup ptr, byval action_name as const gchar ptr) as gboolean
declare function g_action_group_list_actions(byval action_group as GActionGroup ptr) as gchar ptr ptr
declare function g_action_group_get_action_parameter_type(byval action_group as GActionGroup ptr, byval action_name as const gchar ptr) as const GVariantType ptr
declare function g_action_group_get_action_state_type(byval action_group as GActionGroup ptr, byval action_name as const gchar ptr) as const GVariantType ptr
declare function g_action_group_get_action_state_hint(byval action_group as GActionGroup ptr, byval action_name as const gchar ptr) as GVariant ptr
declare function g_action_group_get_action_enabled(byval action_group as GActionGroup ptr, byval action_name as const gchar ptr) as gboolean
declare function g_action_group_get_action_state(byval action_group as GActionGroup ptr, byval action_name as const gchar ptr) as GVariant ptr
declare sub g_action_group_change_action_state(byval action_group as GActionGroup ptr, byval action_name as const gchar ptr, byval value as GVariant ptr)
declare sub g_action_group_activate_action(byval action_group as GActionGroup ptr, byval action_name as const gchar ptr, byval parameter as GVariant ptr)
declare sub g_action_group_action_added(byval action_group as GActionGroup ptr, byval action_name as const gchar ptr)
declare sub g_action_group_action_removed(byval action_group as GActionGroup ptr, byval action_name as const gchar ptr)
declare sub g_action_group_action_enabled_changed(byval action_group as GActionGroup ptr, byval action_name as const gchar ptr, byval enabled as gboolean)
declare sub g_action_group_action_state_changed(byval action_group as GActionGroup ptr, byval action_name as const gchar ptr, byval state as GVariant ptr)
declare function g_action_group_query_action(byval action_group as GActionGroup ptr, byval action_name as const gchar ptr, byval enabled as gboolean ptr, byval parameter_type as const GVariantType ptr ptr, byval state_type as const GVariantType ptr ptr, byval state_hint as GVariant ptr ptr, byval state as GVariant ptr ptr) as gboolean
#define __G_ACTION_GROUP_EXPORTER_H__
declare function g_dbus_connection_export_action_group(byval connection as GDBusConnection ptr, byval object_path as const gchar ptr, byval action_group as GActionGroup ptr, byval error as GError ptr ptr) as guint
declare sub g_dbus_connection_unexport_action_group(byval connection as GDBusConnection ptr, byval export_id as guint)

#define __G_ACTION_MAP_H__
#define G_TYPE_ACTION_MAP g_action_map_get_type()
#define G_ACTION_MAP(inst) G_TYPE_CHECK_INSTANCE_CAST((inst), G_TYPE_ACTION_MAP, GActionMap)
#define G_IS_ACTION_MAP(inst) G_TYPE_CHECK_INSTANCE_TYPE((inst), G_TYPE_ACTION_MAP)
#define G_ACTION_MAP_GET_IFACE(inst) G_TYPE_INSTANCE_GET_INTERFACE((inst), G_TYPE_ACTION_MAP, GActionMapInterface)
type GActionMapInterface as _GActionMapInterface
type GActionEntry as _GActionEntry

type _GActionMapInterface
	g_iface as GTypeInterface
	lookup_action as function(byval action_map as GActionMap ptr, byval action_name as const gchar ptr) as GAction ptr
	add_action as sub(byval action_map as GActionMap ptr, byval action as GAction ptr)
	remove_action as sub(byval action_map as GActionMap ptr, byval action_name as const gchar ptr)
end type

type _GActionEntry
	name as const gchar ptr
	activate as sub(byval action as GSimpleAction ptr, byval parameter as GVariant ptr, byval user_data as gpointer)
	parameter_type as const gchar ptr
	state as const gchar ptr
	change_state as sub(byval action as GSimpleAction ptr, byval value as GVariant ptr, byval user_data as gpointer)
	padding(0 to 2) as gsize
end type

declare function g_action_map_get_type() as GType
declare function g_action_map_lookup_action(byval action_map as GActionMap ptr, byval action_name as const gchar ptr) as GAction ptr
declare sub g_action_map_add_action(byval action_map as GActionMap ptr, byval action as GAction ptr)
declare sub g_action_map_remove_action(byval action_map as GActionMap ptr, byval action_name as const gchar ptr)
declare sub g_action_map_add_action_entries(byval action_map as GActionMap ptr, byval entries as const GActionEntry ptr, byval n_entries as gint, byval user_data as gpointer)

#define __G_APP_INFO_H__
#define G_TYPE_APP_INFO g_app_info_get_type()
#define G_APP_INFO(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), G_TYPE_APP_INFO, GAppInfo)
#define G_IS_APP_INFO(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), G_TYPE_APP_INFO)
#define G_APP_INFO_GET_IFACE(obj) G_TYPE_INSTANCE_GET_INTERFACE((obj), G_TYPE_APP_INFO, GAppInfoIface)
#define G_TYPE_APP_LAUNCH_CONTEXT g_app_launch_context_get_type()
#define G_APP_LAUNCH_CONTEXT(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_APP_LAUNCH_CONTEXT, GAppLaunchContext)
#define G_APP_LAUNCH_CONTEXT_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_APP_LAUNCH_CONTEXT, GAppLaunchContextClass)
#define G_IS_APP_LAUNCH_CONTEXT(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_APP_LAUNCH_CONTEXT)
#define G_IS_APP_LAUNCH_CONTEXT_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), G_TYPE_APP_LAUNCH_CONTEXT)
#define G_APP_LAUNCH_CONTEXT_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), G_TYPE_APP_LAUNCH_CONTEXT, GAppLaunchContextClass)

type GAppLaunchContextClass as _GAppLaunchContextClass
type GAppLaunchContextPrivate as _GAppLaunchContextPrivate
type GAppInfoIface as _GAppInfoIface

type _GAppInfoIface
	g_iface as GTypeInterface
	dup as function(byval appinfo as GAppInfo ptr) as GAppInfo ptr
	equal as function(byval appinfo1 as GAppInfo ptr, byval appinfo2 as GAppInfo ptr) as gboolean
	get_id as function(byval appinfo as GAppInfo ptr) as const zstring ptr
	get_name as function(byval appinfo as GAppInfo ptr) as const zstring ptr
	get_description as function(byval appinfo as GAppInfo ptr) as const zstring ptr
	get_executable as function(byval appinfo as GAppInfo ptr) as const zstring ptr
	get_icon as function(byval appinfo as GAppInfo ptr) as GIcon ptr
	launch as function(byval appinfo as GAppInfo ptr, byval files as GList ptr, byval launch_context as GAppLaunchContext ptr, byval error as GError ptr ptr) as gboolean
	supports_uris as function(byval appinfo as GAppInfo ptr) as gboolean
	supports_files as function(byval appinfo as GAppInfo ptr) as gboolean
	launch_uris as function(byval appinfo as GAppInfo ptr, byval uris as GList ptr, byval launch_context as GAppLaunchContext ptr, byval error as GError ptr ptr) as gboolean
	should_show as function(byval appinfo as GAppInfo ptr) as gboolean
	set_as_default_for_type as function(byval appinfo as GAppInfo ptr, byval content_type as const zstring ptr, byval error as GError ptr ptr) as gboolean
	set_as_default_for_extension as function(byval appinfo as GAppInfo ptr, byval extension as const zstring ptr, byval error as GError ptr ptr) as gboolean
	add_supports_type as function(byval appinfo as GAppInfo ptr, byval content_type as const zstring ptr, byval error as GError ptr ptr) as gboolean
	can_remove_supports_type as function(byval appinfo as GAppInfo ptr) as gboolean
	remove_supports_type as function(byval appinfo as GAppInfo ptr, byval content_type as const zstring ptr, byval error as GError ptr ptr) as gboolean
	can_delete as function(byval appinfo as GAppInfo ptr) as gboolean
	do_delete as function(byval appinfo as GAppInfo ptr) as gboolean
	get_commandline as function(byval appinfo as GAppInfo ptr) as const zstring ptr
	get_display_name as function(byval appinfo as GAppInfo ptr) as const zstring ptr
	set_as_last_used_for_type as function(byval appinfo as GAppInfo ptr, byval content_type as const zstring ptr, byval error as GError ptr ptr) as gboolean
	get_supported_types as function(byval appinfo as GAppInfo ptr) as const zstring ptr ptr
end type

declare function g_app_info_get_type() as GType
declare function g_app_info_create_from_commandline(byval commandline as const zstring ptr, byval application_name as const zstring ptr, byval flags as GAppInfoCreateFlags, byval error as GError ptr ptr) as GAppInfo ptr
declare function g_app_info_dup(byval appinfo as GAppInfo ptr) as GAppInfo ptr
declare function g_app_info_equal(byval appinfo1 as GAppInfo ptr, byval appinfo2 as GAppInfo ptr) as gboolean
declare function g_app_info_get_id(byval appinfo as GAppInfo ptr) as const zstring ptr
declare function g_app_info_get_name(byval appinfo as GAppInfo ptr) as const zstring ptr
declare function g_app_info_get_display_name(byval appinfo as GAppInfo ptr) as const zstring ptr
declare function g_app_info_get_description(byval appinfo as GAppInfo ptr) as const zstring ptr
declare function g_app_info_get_executable(byval appinfo as GAppInfo ptr) as const zstring ptr
declare function g_app_info_get_commandline(byval appinfo as GAppInfo ptr) as const zstring ptr
declare function g_app_info_get_icon(byval appinfo as GAppInfo ptr) as GIcon ptr
declare function g_app_info_launch(byval appinfo as GAppInfo ptr, byval files as GList ptr, byval launch_context as GAppLaunchContext ptr, byval error as GError ptr ptr) as gboolean
declare function g_app_info_supports_uris(byval appinfo as GAppInfo ptr) as gboolean
declare function g_app_info_supports_files(byval appinfo as GAppInfo ptr) as gboolean
declare function g_app_info_launch_uris(byval appinfo as GAppInfo ptr, byval uris as GList ptr, byval launch_context as GAppLaunchContext ptr, byval error as GError ptr ptr) as gboolean
declare function g_app_info_should_show(byval appinfo as GAppInfo ptr) as gboolean
declare function g_app_info_set_as_default_for_type(byval appinfo as GAppInfo ptr, byval content_type as const zstring ptr, byval error as GError ptr ptr) as gboolean
declare function g_app_info_set_as_default_for_extension(byval appinfo as GAppInfo ptr, byval extension as const zstring ptr, byval error as GError ptr ptr) as gboolean
declare function g_app_info_add_supports_type(byval appinfo as GAppInfo ptr, byval content_type as const zstring ptr, byval error as GError ptr ptr) as gboolean
declare function g_app_info_can_remove_supports_type(byval appinfo as GAppInfo ptr) as gboolean
declare function g_app_info_remove_supports_type(byval appinfo as GAppInfo ptr, byval content_type as const zstring ptr, byval error as GError ptr ptr) as gboolean
declare function g_app_info_get_supported_types(byval appinfo as GAppInfo ptr) as const zstring ptr ptr
declare function g_app_info_can_delete(byval appinfo as GAppInfo ptr) as gboolean
declare function g_app_info_delete(byval appinfo as GAppInfo ptr) as gboolean
declare function g_app_info_set_as_last_used_for_type(byval appinfo as GAppInfo ptr, byval content_type as const zstring ptr, byval error as GError ptr ptr) as gboolean
declare function g_app_info_get_all() as GList ptr
declare function g_app_info_get_all_for_type(byval content_type as const zstring ptr) as GList ptr
declare function g_app_info_get_recommended_for_type(byval content_type as const gchar ptr) as GList ptr
declare function g_app_info_get_fallback_for_type(byval content_type as const gchar ptr) as GList ptr
declare sub g_app_info_reset_type_associations(byval content_type as const zstring ptr)
declare function g_app_info_get_default_for_type(byval content_type as const zstring ptr, byval must_support_uris as gboolean) as GAppInfo ptr
declare function g_app_info_get_default_for_uri_scheme(byval uri_scheme as const zstring ptr) as GAppInfo ptr
declare function g_app_info_launch_default_for_uri(byval uri as const zstring ptr, byval launch_context as GAppLaunchContext ptr, byval error as GError ptr ptr) as gboolean

type _GAppLaunchContext
	parent_instance as GObject
	priv as GAppLaunchContextPrivate ptr
end type

type _GAppLaunchContextClass
	parent_class as GObjectClass
	get_display as function(byval context as GAppLaunchContext ptr, byval info as GAppInfo ptr, byval files as GList ptr) as zstring ptr
	get_startup_notify_id as function(byval context as GAppLaunchContext ptr, byval info as GAppInfo ptr, byval files as GList ptr) as zstring ptr
	launch_failed as sub(byval context as GAppLaunchContext ptr, byval startup_notify_id as const zstring ptr)
	launched as sub(byval context as GAppLaunchContext ptr, byval info as GAppInfo ptr, byval platform_data as GVariant ptr)
	_g_reserved1 as sub()
	_g_reserved2 as sub()
	_g_reserved3 as sub()
	_g_reserved4 as sub()
end type

declare function g_app_launch_context_get_type() as GType
declare function g_app_launch_context_new() as GAppLaunchContext ptr
declare sub g_app_launch_context_setenv(byval context as GAppLaunchContext ptr, byval variable as const zstring ptr, byval value as const zstring ptr)
declare sub g_app_launch_context_unsetenv(byval context as GAppLaunchContext ptr, byval variable as const zstring ptr)
declare function g_app_launch_context_get_environment(byval context as GAppLaunchContext ptr) as zstring ptr ptr
declare function g_app_launch_context_get_display(byval context as GAppLaunchContext ptr, byval info as GAppInfo ptr, byval files as GList ptr) as zstring ptr
declare function g_app_launch_context_get_startup_notify_id(byval context as GAppLaunchContext ptr, byval info as GAppInfo ptr, byval files as GList ptr) as zstring ptr
declare sub g_app_launch_context_launch_failed(byval context as GAppLaunchContext ptr, byval startup_notify_id as const zstring ptr)

#define G_TYPE_APP_INFO_MONITOR g_app_info_monitor_get_type()
#define G_APP_INFO_MONITOR(inst) G_TYPE_CHECK_INSTANCE_CAST((inst), G_TYPE_APP_INFO_MONITOR, GAppInfoMonitor)
#define G_IS_APP_INFO_MONITOR(inst) G_TYPE_CHECK_INSTANCE_TYPE((inst), G_TYPE_APP_INFO_MONITOR)
type GAppInfoMonitor as _GAppInfoMonitor
declare function g_app_info_monitor_get_type() as GType
declare function g_app_info_monitor_get() as GAppInfoMonitor ptr
#define __G_APPLICATION_H__
#define G_TYPE_APPLICATION g_application_get_type()
#define G_APPLICATION(inst) G_TYPE_CHECK_INSTANCE_CAST((inst), G_TYPE_APPLICATION, GApplication)
#define G_APPLICATION_CLASS(class) G_TYPE_CHECK_CLASS_CAST((class), G_TYPE_APPLICATION, GApplicationClass)
#define G_IS_APPLICATION(inst) G_TYPE_CHECK_INSTANCE_TYPE((inst), G_TYPE_APPLICATION)
#define G_IS_APPLICATION_CLASS(class) G_TYPE_CHECK_CLASS_TYPE((class), G_TYPE_APPLICATION)
#define G_APPLICATION_GET_CLASS(inst) G_TYPE_INSTANCE_GET_CLASS((inst), G_TYPE_APPLICATION, GApplicationClass)
type GApplicationPrivate as _GApplicationPrivate
type GApplicationClass as _GApplicationClass

type _GApplication
	parent_instance as GObject
	priv as GApplicationPrivate ptr
end type

type _GApplicationClass
	parent_class as GObjectClass
	startup as sub(byval application as GApplication ptr)
	activate as sub(byval application as GApplication ptr)
	open as sub(byval application as GApplication ptr, byval files as GFile ptr ptr, byval n_files as gint, byval hint as const gchar ptr)
	command_line as function(byval application as GApplication ptr, byval command_line as GApplicationCommandLine ptr) as long
	local_command_line as function(byval application as GApplication ptr, byval arguments as gchar ptr ptr ptr, byval exit_status as long ptr) as gboolean
	before_emit as sub(byval application as GApplication ptr, byval platform_data as GVariant ptr)
	after_emit as sub(byval application as GApplication ptr, byval platform_data as GVariant ptr)
	add_platform_data as sub(byval application as GApplication ptr, byval builder as GVariantBuilder ptr)
	quit_mainloop as sub(byval application as GApplication ptr)
	run_mainloop as sub(byval application as GApplication ptr)
	shutdown as sub(byval application as GApplication ptr)
	dbus_register as function(byval application as GApplication ptr, byval connection as GDBusConnection ptr, byval object_path as const gchar ptr, byval error as GError ptr ptr) as gboolean
	dbus_unregister as sub(byval application as GApplication ptr, byval connection as GDBusConnection ptr, byval object_path as const gchar ptr)
	handle_local_options as function(byval application as GApplication ptr, byval options as GVariantDict ptr) as gint
	padding(0 to 7) as gpointer
end type

declare function g_application_get_type() as GType
declare function g_application_id_is_valid(byval application_id as const gchar ptr) as gboolean
declare function g_application_new(byval application_id as const gchar ptr, byval flags as GApplicationFlags) as GApplication ptr
declare function g_application_get_application_id(byval application as GApplication ptr) as const gchar ptr
declare sub g_application_set_application_id(byval application as GApplication ptr, byval application_id as const gchar ptr)
declare function g_application_get_dbus_connection(byval application as GApplication ptr) as GDBusConnection ptr
declare function g_application_get_dbus_object_path(byval application as GApplication ptr) as const gchar ptr
declare function g_application_get_inactivity_timeout(byval application as GApplication ptr) as guint
declare sub g_application_set_inactivity_timeout(byval application as GApplication ptr, byval inactivity_timeout as guint)
declare function g_application_get_flags(byval application as GApplication ptr) as GApplicationFlags
declare sub g_application_set_flags(byval application as GApplication ptr, byval flags as GApplicationFlags)
declare function g_application_get_resource_base_path(byval application as GApplication ptr) as const gchar ptr
declare sub g_application_set_resource_base_path(byval application as GApplication ptr, byval resource_path as const gchar ptr)
declare sub g_application_set_action_group(byval application as GApplication ptr, byval action_group as GActionGroup ptr)
declare sub g_application_add_main_option_entries(byval application as GApplication ptr, byval entries as const GOptionEntry ptr)
declare sub g_application_add_main_option(byval application as GApplication ptr, byval long_name as const zstring ptr, byval short_name as byte, byval flags as GOptionFlags, byval arg as GOptionArg, byval description as const zstring ptr, byval arg_description as const zstring ptr)
declare sub g_application_add_option_group(byval application as GApplication ptr, byval group as GOptionGroup ptr)
declare function g_application_get_is_registered(byval application as GApplication ptr) as gboolean
declare function g_application_get_is_remote(byval application as GApplication ptr) as gboolean
declare function g_application_register(byval application as GApplication ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
declare sub g_application_hold(byval application as GApplication ptr)
declare sub g_application_release(byval application as GApplication ptr)
declare sub g_application_activate(byval application as GApplication ptr)
declare sub g_application_open(byval application as GApplication ptr, byval files as GFile ptr ptr, byval n_files as gint, byval hint as const gchar ptr)
declare function g_application_run(byval application as GApplication ptr, byval argc as long, byval argv as zstring ptr ptr) as long
declare sub g_application_quit(byval application as GApplication ptr)
declare function g_application_get_default() as GApplication ptr
declare sub g_application_set_default(byval application as GApplication ptr)
declare sub g_application_mark_busy(byval application as GApplication ptr)
declare sub g_application_unmark_busy(byval application as GApplication ptr)
declare function g_application_get_is_busy(byval application as GApplication ptr) as gboolean
declare sub g_application_send_notification(byval application as GApplication ptr, byval id as const gchar ptr, byval notification as GNotification ptr)
declare sub g_application_withdraw_notification(byval application as GApplication ptr, byval id as const gchar ptr)
declare sub g_application_bind_busy_property(byval application as GApplication ptr, byval object as gpointer, byval property as const gchar ptr)
declare sub g_application_unbind_busy_property(byval application as GApplication ptr, byval object as gpointer, byval property as const gchar ptr)

#define __G_APPLICATION_COMMAND_LINE_H__
#define G_TYPE_APPLICATION_COMMAND_LINE g_application_command_line_get_type()
#define G_APPLICATION_COMMAND_LINE(inst) G_TYPE_CHECK_INSTANCE_CAST((inst), G_TYPE_APPLICATION_COMMAND_LINE, GApplicationCommandLine)
#define G_APPLICATION_COMMAND_LINE_CLASS(class) G_TYPE_CHECK_CLASS_CAST((class), G_TYPE_APPLICATION_COMMAND_LINE, GApplicationCommandLineClass)
#define G_IS_APPLICATION_COMMAND_LINE(inst) G_TYPE_CHECK_INSTANCE_TYPE((inst), G_TYPE_APPLICATION_COMMAND_LINE)
#define G_IS_APPLICATION_COMMAND_LINE_CLASS(class) G_TYPE_CHECK_CLASS_TYPE((class), G_TYPE_APPLICATION_COMMAND_LINE)
#define G_APPLICATION_COMMAND_LINE_GET_CLASS(inst) G_TYPE_INSTANCE_GET_CLASS((inst), G_TYPE_APPLICATION_COMMAND_LINE, GApplicationCommandLineClass)
type GApplicationCommandLinePrivate as _GApplicationCommandLinePrivate
type GApplicationCommandLineClass as _GApplicationCommandLineClass

type _GApplicationCommandLine
	parent_instance as GObject
	priv as GApplicationCommandLinePrivate ptr
end type

type _GApplicationCommandLineClass
	parent_class as GObjectClass
	print_literal as sub(byval cmdline as GApplicationCommandLine ptr, byval message as const gchar ptr)
	printerr_literal as sub(byval cmdline as GApplicationCommandLine ptr, byval message as const gchar ptr)
	get_stdin as function(byval cmdline as GApplicationCommandLine ptr) as GInputStream ptr
	padding(0 to 10) as gpointer
end type

declare function g_application_command_line_get_type() as GType
declare function g_application_command_line_get_arguments(byval cmdline as GApplicationCommandLine ptr, byval argc as long ptr) as gchar ptr ptr
declare function g_application_command_line_get_options_dict(byval cmdline as GApplicationCommandLine ptr) as GVariantDict ptr
declare function g_application_command_line_get_stdin(byval cmdline as GApplicationCommandLine ptr) as GInputStream ptr
declare function g_application_command_line_get_environ(byval cmdline as GApplicationCommandLine ptr) as const gchar const ptr ptr
declare function g_application_command_line_getenv(byval cmdline as GApplicationCommandLine ptr, byval name as const gchar ptr) as const gchar ptr
declare function g_application_command_line_get_cwd(byval cmdline as GApplicationCommandLine ptr) as const gchar ptr
declare function g_application_command_line_get_is_remote(byval cmdline as GApplicationCommandLine ptr) as gboolean
declare sub g_application_command_line_print(byval cmdline as GApplicationCommandLine ptr, byval format as const gchar ptr, ...)
declare sub g_application_command_line_printerr(byval cmdline as GApplicationCommandLine ptr, byval format as const gchar ptr, ...)
declare function g_application_command_line_get_exit_status(byval cmdline as GApplicationCommandLine ptr) as long
declare sub g_application_command_line_set_exit_status(byval cmdline as GApplicationCommandLine ptr, byval exit_status as long)
declare function g_application_command_line_get_platform_data(byval cmdline as GApplicationCommandLine ptr) as GVariant ptr
declare function g_application_command_line_create_file_for_arg(byval cmdline as GApplicationCommandLine ptr, byval arg as const gchar ptr) as GFile ptr

#define __G_ASYNC_INITABLE_H__
#define __G_INITABLE_H__
#define G_TYPE_INITABLE g_initable_get_type()
#define G_INITABLE(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), G_TYPE_INITABLE, GInitable)
#define G_IS_INITABLE(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), G_TYPE_INITABLE)
#define G_INITABLE_GET_IFACE(obj) G_TYPE_INSTANCE_GET_INTERFACE((obj), G_TYPE_INITABLE, GInitableIface)
#define G_TYPE_IS_INITABLE(type) g_type_is_a((type), G_TYPE_INITABLE)
type GInitableIface as _GInitableIface

type _GInitableIface
	g_iface as GTypeInterface
	init as function(byval initable as GInitable ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
end type

declare function g_initable_get_type() as GType
declare function g_initable_init(byval initable as GInitable ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
declare function g_initable_new(byval object_type as GType, byval cancellable as GCancellable ptr, byval error as GError ptr ptr, byval first_property_name as const gchar ptr, ...) as gpointer
declare function g_initable_newv(byval object_type as GType, byval n_parameters as guint, byval parameters as GParameter ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gpointer
declare function g_initable_new_valist(byval object_type as GType, byval first_property_name as const gchar ptr, byval var_args as va_list, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GObject ptr

#define G_TYPE_ASYNC_INITABLE g_async_initable_get_type()
#define G_ASYNC_INITABLE(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), G_TYPE_ASYNC_INITABLE, GAsyncInitable)
#define G_IS_ASYNC_INITABLE(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), G_TYPE_ASYNC_INITABLE)
#define G_ASYNC_INITABLE_GET_IFACE(obj) G_TYPE_INSTANCE_GET_INTERFACE((obj), G_TYPE_ASYNC_INITABLE, GAsyncInitableIface)
#define G_TYPE_IS_ASYNC_INITABLE(type) g_type_is_a((type), G_TYPE_ASYNC_INITABLE)
type GAsyncInitableIface as _GAsyncInitableIface

type _GAsyncInitableIface
	g_iface as GTypeInterface
	init_async as sub(byval initable as GAsyncInitable ptr, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	init_finish as function(byval initable as GAsyncInitable ptr, byval res as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
end type

declare function g_async_initable_get_type() as GType
declare sub g_async_initable_init_async(byval initable as GAsyncInitable ptr, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_async_initable_init_finish(byval initable as GAsyncInitable ptr, byval res as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
declare sub g_async_initable_new_async(byval object_type as GType, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer, byval first_property_name as const gchar ptr, ...)
declare sub g_async_initable_newv_async(byval object_type as GType, byval n_parameters as guint, byval parameters as GParameter ptr, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare sub g_async_initable_new_valist_async(byval object_type as GType, byval first_property_name as const gchar ptr, byval var_args as va_list, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_async_initable_new_finish(byval initable as GAsyncInitable ptr, byval res as GAsyncResult ptr, byval error as GError ptr ptr) as GObject ptr

#define __G_ASYNC_RESULT_H__
#define G_TYPE_ASYNC_RESULT g_async_result_get_type()
#define G_ASYNC_RESULT(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), G_TYPE_ASYNC_RESULT, GAsyncResult)
#define G_IS_ASYNC_RESULT(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), G_TYPE_ASYNC_RESULT)
#define G_ASYNC_RESULT_GET_IFACE(obj) G_TYPE_INSTANCE_GET_INTERFACE((obj), G_TYPE_ASYNC_RESULT, GAsyncResultIface)
type GAsyncResultIface as _GAsyncResultIface

type _GAsyncResultIface
	g_iface as GTypeInterface
	get_user_data as function(byval res as GAsyncResult ptr) as gpointer
	get_source_object as function(byval res as GAsyncResult ptr) as GObject ptr
	is_tagged as function(byval res as GAsyncResult ptr, byval source_tag as gpointer) as gboolean
end type

declare function g_async_result_get_type() as GType
declare function g_async_result_get_user_data(byval res as GAsyncResult ptr) as gpointer
declare function g_async_result_get_source_object(byval res as GAsyncResult ptr) as GObject ptr
declare function g_async_result_legacy_propagate_error(byval res as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
declare function g_async_result_is_tagged(byval res as GAsyncResult ptr, byval source_tag as gpointer) as gboolean

#define __G_BUFFERED_INPUT_STREAM_H__
#define __G_FILTER_INPUT_STREAM_H__
#define __G_INPUT_STREAM_H__
#define G_TYPE_INPUT_STREAM g_input_stream_get_type()
#define G_INPUT_STREAM(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_INPUT_STREAM, GInputStream)
#define G_INPUT_STREAM_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_INPUT_STREAM, GInputStreamClass)
#define G_IS_INPUT_STREAM(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_INPUT_STREAM)
#define G_IS_INPUT_STREAM_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), G_TYPE_INPUT_STREAM)
#define G_INPUT_STREAM_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), G_TYPE_INPUT_STREAM, GInputStreamClass)
type GInputStreamClass as _GInputStreamClass
type GInputStreamPrivate as _GInputStreamPrivate

type _GInputStream
	parent_instance as GObject
	priv as GInputStreamPrivate ptr
end type

type _GInputStreamClass
	parent_class as GObjectClass
	read_fn as function(byval stream as GInputStream ptr, byval buffer as any ptr, byval count as gsize, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gssize
	skip as function(byval stream as GInputStream ptr, byval count as gsize, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gssize
	close_fn as function(byval stream as GInputStream ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
	read_async as sub(byval stream as GInputStream ptr, byval buffer as any ptr, byval count as gsize, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	read_finish as function(byval stream as GInputStream ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gssize
	skip_async as sub(byval stream as GInputStream ptr, byval count as gsize, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	skip_finish as function(byval stream as GInputStream ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gssize
	close_async as sub(byval stream as GInputStream ptr, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	close_finish as function(byval stream as GInputStream ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
	_g_reserved1 as sub()
	_g_reserved2 as sub()
	_g_reserved3 as sub()
	_g_reserved4 as sub()
	_g_reserved5 as sub()
end type

declare function g_input_stream_get_type() as GType
declare function g_input_stream_read(byval stream as GInputStream ptr, byval buffer as any ptr, byval count as gsize, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gssize
declare function g_input_stream_read_all(byval stream as GInputStream ptr, byval buffer as any ptr, byval count as gsize, byval bytes_read as gsize ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
declare function g_input_stream_read_bytes(byval stream as GInputStream ptr, byval count as gsize, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GBytes ptr
declare function g_input_stream_skip(byval stream as GInputStream ptr, byval count as gsize, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gssize
declare function g_input_stream_close(byval stream as GInputStream ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
declare sub g_input_stream_read_async(byval stream as GInputStream ptr, byval buffer as any ptr, byval count as gsize, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_input_stream_read_finish(byval stream as GInputStream ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gssize
declare sub g_input_stream_read_all_async(byval stream as GInputStream ptr, byval buffer as any ptr, byval count as gsize, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_input_stream_read_all_finish(byval stream as GInputStream ptr, byval result as GAsyncResult ptr, byval bytes_read as gsize ptr, byval error as GError ptr ptr) as gboolean
declare sub g_input_stream_read_bytes_async(byval stream as GInputStream ptr, byval count as gsize, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_input_stream_read_bytes_finish(byval stream as GInputStream ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as GBytes ptr
declare sub g_input_stream_skip_async(byval stream as GInputStream ptr, byval count as gsize, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_input_stream_skip_finish(byval stream as GInputStream ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gssize
declare sub g_input_stream_close_async(byval stream as GInputStream ptr, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_input_stream_close_finish(byval stream as GInputStream ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
declare function g_input_stream_is_closed(byval stream as GInputStream ptr) as gboolean
declare function g_input_stream_has_pending(byval stream as GInputStream ptr) as gboolean
declare function g_input_stream_set_pending(byval stream as GInputStream ptr, byval error as GError ptr ptr) as gboolean
declare sub g_input_stream_clear_pending(byval stream as GInputStream ptr)

#define G_TYPE_FILTER_INPUT_STREAM g_filter_input_stream_get_type()
#define G_FILTER_INPUT_STREAM(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_FILTER_INPUT_STREAM, GFilterInputStream)
#define G_FILTER_INPUT_STREAM_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_FILTER_INPUT_STREAM, GFilterInputStreamClass)
#define G_IS_FILTER_INPUT_STREAM(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_FILTER_INPUT_STREAM)
#define G_IS_FILTER_INPUT_STREAM_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), G_TYPE_FILTER_INPUT_STREAM)
#define G_FILTER_INPUT_STREAM_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), G_TYPE_FILTER_INPUT_STREAM, GFilterInputStreamClass)
type GFilterInputStreamClass as _GFilterInputStreamClass

type _GFilterInputStream
	parent_instance as GInputStream
	base_stream as GInputStream ptr
end type

type _GFilterInputStreamClass
	parent_class as GInputStreamClass
	_g_reserved1 as sub()
	_g_reserved2 as sub()
	_g_reserved3 as sub()
end type

declare function g_filter_input_stream_get_type() as GType
declare function g_filter_input_stream_get_base_stream(byval stream as GFilterInputStream ptr) as GInputStream ptr
declare function g_filter_input_stream_get_close_base_stream(byval stream as GFilterInputStream ptr) as gboolean
declare sub g_filter_input_stream_set_close_base_stream(byval stream as GFilterInputStream ptr, byval close_base as gboolean)

#define G_TYPE_BUFFERED_INPUT_STREAM g_buffered_input_stream_get_type()
#define G_BUFFERED_INPUT_STREAM(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_BUFFERED_INPUT_STREAM, GBufferedInputStream)
#define G_BUFFERED_INPUT_STREAM_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_BUFFERED_INPUT_STREAM, GBufferedInputStreamClass)
#define G_IS_BUFFERED_INPUT_STREAM(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_BUFFERED_INPUT_STREAM)
#define G_IS_BUFFERED_INPUT_STREAM_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), G_TYPE_BUFFERED_INPUT_STREAM)
#define G_BUFFERED_INPUT_STREAM_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), G_TYPE_BUFFERED_INPUT_STREAM, GBufferedInputStreamClass)
type GBufferedInputStreamClass as _GBufferedInputStreamClass
type GBufferedInputStreamPrivate as _GBufferedInputStreamPrivate

type _GBufferedInputStream
	parent_instance as GFilterInputStream
	priv as GBufferedInputStreamPrivate ptr
end type

type _GBufferedInputStreamClass
	parent_class as GFilterInputStreamClass
	fill as function(byval stream as GBufferedInputStream ptr, byval count as gssize, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gssize
	fill_async as sub(byval stream as GBufferedInputStream ptr, byval count as gssize, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	fill_finish as function(byval stream as GBufferedInputStream ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gssize
	_g_reserved1 as sub()
	_g_reserved2 as sub()
	_g_reserved3 as sub()
	_g_reserved4 as sub()
	_g_reserved5 as sub()
end type

declare function g_buffered_input_stream_get_type() as GType
declare function g_buffered_input_stream_new(byval base_stream as GInputStream ptr) as GInputStream ptr
declare function g_buffered_input_stream_new_sized(byval base_stream as GInputStream ptr, byval size as gsize) as GInputStream ptr
declare function g_buffered_input_stream_get_buffer_size(byval stream as GBufferedInputStream ptr) as gsize
declare sub g_buffered_input_stream_set_buffer_size(byval stream as GBufferedInputStream ptr, byval size as gsize)
declare function g_buffered_input_stream_get_available(byval stream as GBufferedInputStream ptr) as gsize
declare function g_buffered_input_stream_peek(byval stream as GBufferedInputStream ptr, byval buffer as any ptr, byval offset as gsize, byval count as gsize) as gsize
declare function g_buffered_input_stream_peek_buffer(byval stream as GBufferedInputStream ptr, byval count as gsize ptr) as const any ptr
declare function g_buffered_input_stream_fill(byval stream as GBufferedInputStream ptr, byval count as gssize, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gssize
declare sub g_buffered_input_stream_fill_async(byval stream as GBufferedInputStream ptr, byval count as gssize, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_buffered_input_stream_fill_finish(byval stream as GBufferedInputStream ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gssize
declare function g_buffered_input_stream_read_byte(byval stream as GBufferedInputStream ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as long

#define __G_BUFFERED_OUTPUT_STREAM_H__
#define __G_FILTER_OUTPUT_STREAM_H__
#define __G_OUTPUT_STREAM_H__
#define G_TYPE_OUTPUT_STREAM g_output_stream_get_type()
#define G_OUTPUT_STREAM(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_OUTPUT_STREAM, GOutputStream)
#define G_OUTPUT_STREAM_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_OUTPUT_STREAM, GOutputStreamClass)
#define G_IS_OUTPUT_STREAM(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_OUTPUT_STREAM)
#define G_IS_OUTPUT_STREAM_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), G_TYPE_OUTPUT_STREAM)
#define G_OUTPUT_STREAM_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), G_TYPE_OUTPUT_STREAM, GOutputStreamClass)
type GOutputStreamClass as _GOutputStreamClass
type GOutputStreamPrivate as _GOutputStreamPrivate

type _GOutputStream
	parent_instance as GObject
	priv as GOutputStreamPrivate ptr
end type

type _GOutputStreamClass
	parent_class as GObjectClass
	write_fn as function(byval stream as GOutputStream ptr, byval buffer as const any ptr, byval count as gsize, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gssize
	splice as function(byval stream as GOutputStream ptr, byval source as GInputStream ptr, byval flags as GOutputStreamSpliceFlags, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gssize
	flush as function(byval stream as GOutputStream ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
	close_fn as function(byval stream as GOutputStream ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
	write_async as sub(byval stream as GOutputStream ptr, byval buffer as const any ptr, byval count as gsize, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	write_finish as function(byval stream as GOutputStream ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gssize
	splice_async as sub(byval stream as GOutputStream ptr, byval source as GInputStream ptr, byval flags as GOutputStreamSpliceFlags, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	splice_finish as function(byval stream as GOutputStream ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gssize
	flush_async as sub(byval stream as GOutputStream ptr, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	flush_finish as function(byval stream as GOutputStream ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
	close_async as sub(byval stream as GOutputStream ptr, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	close_finish as function(byval stream as GOutputStream ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
	_g_reserved1 as sub()
	_g_reserved2 as sub()
	_g_reserved3 as sub()
	_g_reserved4 as sub()
	_g_reserved5 as sub()
	_g_reserved6 as sub()
	_g_reserved7 as sub()
	_g_reserved8 as sub()
end type

declare function g_output_stream_get_type() as GType
declare function g_output_stream_write(byval stream as GOutputStream ptr, byval buffer as const any ptr, byval count as gsize, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gssize
declare function g_output_stream_write_all(byval stream as GOutputStream ptr, byval buffer as const any ptr, byval count as gsize, byval bytes_written as gsize ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
declare function g_output_stream_printf(byval stream as GOutputStream ptr, byval bytes_written as gsize ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr, byval format as const gchar ptr, ...) as gboolean
declare function g_output_stream_vprintf(byval stream as GOutputStream ptr, byval bytes_written as gsize ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr, byval format as const gchar ptr, byval args as va_list) as gboolean
declare function g_output_stream_write_bytes(byval stream as GOutputStream ptr, byval bytes as GBytes ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gssize
declare function g_output_stream_splice(byval stream as GOutputStream ptr, byval source as GInputStream ptr, byval flags as GOutputStreamSpliceFlags, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gssize
declare function g_output_stream_flush(byval stream as GOutputStream ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
declare function g_output_stream_close(byval stream as GOutputStream ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
declare sub g_output_stream_write_async(byval stream as GOutputStream ptr, byval buffer as const any ptr, byval count as gsize, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_output_stream_write_finish(byval stream as GOutputStream ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gssize
declare sub g_output_stream_write_all_async(byval stream as GOutputStream ptr, byval buffer as const any ptr, byval count as gsize, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_output_stream_write_all_finish(byval stream as GOutputStream ptr, byval result as GAsyncResult ptr, byval bytes_written as gsize ptr, byval error as GError ptr ptr) as gboolean
declare sub g_output_stream_write_bytes_async(byval stream as GOutputStream ptr, byval bytes as GBytes ptr, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_output_stream_write_bytes_finish(byval stream as GOutputStream ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gssize
declare sub g_output_stream_splice_async(byval stream as GOutputStream ptr, byval source as GInputStream ptr, byval flags as GOutputStreamSpliceFlags, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_output_stream_splice_finish(byval stream as GOutputStream ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gssize
declare sub g_output_stream_flush_async(byval stream as GOutputStream ptr, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_output_stream_flush_finish(byval stream as GOutputStream ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
declare sub g_output_stream_close_async(byval stream as GOutputStream ptr, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_output_stream_close_finish(byval stream as GOutputStream ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
declare function g_output_stream_is_closed(byval stream as GOutputStream ptr) as gboolean
declare function g_output_stream_is_closing(byval stream as GOutputStream ptr) as gboolean
declare function g_output_stream_has_pending(byval stream as GOutputStream ptr) as gboolean
declare function g_output_stream_set_pending(byval stream as GOutputStream ptr, byval error as GError ptr ptr) as gboolean
declare sub g_output_stream_clear_pending(byval stream as GOutputStream ptr)

#define G_TYPE_FILTER_OUTPUT_STREAM g_filter_output_stream_get_type()
#define G_FILTER_OUTPUT_STREAM(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_FILTER_OUTPUT_STREAM, GFilterOutputStream)
#define G_FILTER_OUTPUT_STREAM_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_FILTER_OUTPUT_STREAM, GFilterOutputStreamClass)
#define G_IS_FILTER_OUTPUT_STREAM(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_FILTER_OUTPUT_STREAM)
#define G_IS_FILTER_OUTPUT_STREAM_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), G_TYPE_FILTER_OUTPUT_STREAM)
#define G_FILTER_OUTPUT_STREAM_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), G_TYPE_FILTER_OUTPUT_STREAM, GFilterOutputStreamClass)
type GFilterOutputStreamClass as _GFilterOutputStreamClass

type _GFilterOutputStream
	parent_instance as GOutputStream
	base_stream as GOutputStream ptr
end type

type _GFilterOutputStreamClass
	parent_class as GOutputStreamClass
	_g_reserved1 as sub()
	_g_reserved2 as sub()
	_g_reserved3 as sub()
end type

declare function g_filter_output_stream_get_type() as GType
declare function g_filter_output_stream_get_base_stream(byval stream as GFilterOutputStream ptr) as GOutputStream ptr
declare function g_filter_output_stream_get_close_base_stream(byval stream as GFilterOutputStream ptr) as gboolean
declare sub g_filter_output_stream_set_close_base_stream(byval stream as GFilterOutputStream ptr, byval close_base as gboolean)

#define G_TYPE_BUFFERED_OUTPUT_STREAM g_buffered_output_stream_get_type()
#define G_BUFFERED_OUTPUT_STREAM(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_BUFFERED_OUTPUT_STREAM, GBufferedOutputStream)
#define G_BUFFERED_OUTPUT_STREAM_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_BUFFERED_OUTPUT_STREAM, GBufferedOutputStreamClass)
#define G_IS_BUFFERED_OUTPUT_STREAM(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_BUFFERED_OUTPUT_STREAM)
#define G_IS_BUFFERED_OUTPUT_STREAM_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), G_TYPE_BUFFERED_OUTPUT_STREAM)
#define G_BUFFERED_OUTPUT_STREAM_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), G_TYPE_BUFFERED_OUTPUT_STREAM, GBufferedOutputStreamClass)
type GBufferedOutputStreamClass as _GBufferedOutputStreamClass
type GBufferedOutputStreamPrivate as _GBufferedOutputStreamPrivate

type _GBufferedOutputStream
	parent_instance as GFilterOutputStream
	priv as GBufferedOutputStreamPrivate ptr
end type

type _GBufferedOutputStreamClass
	parent_class as GFilterOutputStreamClass
	_g_reserved1 as sub()
	_g_reserved2 as sub()
end type

declare function g_buffered_output_stream_get_type() as GType
declare function g_buffered_output_stream_new(byval base_stream as GOutputStream ptr) as GOutputStream ptr
declare function g_buffered_output_stream_new_sized(byval base_stream as GOutputStream ptr, byval size as gsize) as GOutputStream ptr
declare function g_buffered_output_stream_get_buffer_size(byval stream as GBufferedOutputStream ptr) as gsize
declare sub g_buffered_output_stream_set_buffer_size(byval stream as GBufferedOutputStream ptr, byval size as gsize)
declare function g_buffered_output_stream_get_auto_grow(byval stream as GBufferedOutputStream ptr) as gboolean
declare sub g_buffered_output_stream_set_auto_grow(byval stream as GBufferedOutputStream ptr, byval auto_grow as gboolean)

#define __G_BYTES_ICON_H__
#define G_TYPE_BYTES_ICON g_bytes_icon_get_type()
#define G_BYTES_ICON(inst) G_TYPE_CHECK_INSTANCE_CAST((inst), G_TYPE_BYTES_ICON, GBytesIcon)
#define G_IS_BYTES_ICON(inst) G_TYPE_CHECK_INSTANCE_TYPE((inst), G_TYPE_BYTES_ICON)

declare function g_bytes_icon_get_type() as GType
declare function g_bytes_icon_new(byval bytes as GBytes ptr) as GIcon ptr
declare function g_bytes_icon_get_bytes(byval icon as GBytesIcon ptr) as GBytes ptr

#define __G_CANCELLABLE_H__
#define G_TYPE_CANCELLABLE g_cancellable_get_type()
#define G_CANCELLABLE(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_CANCELLABLE, GCancellable)
#define G_CANCELLABLE_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_CANCELLABLE, GCancellableClass)
#define G_IS_CANCELLABLE(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_CANCELLABLE)
#define G_IS_CANCELLABLE_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), G_TYPE_CANCELLABLE)
#define G_CANCELLABLE_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), G_TYPE_CANCELLABLE, GCancellableClass)
type GCancellableClass as _GCancellableClass
type GCancellablePrivate as _GCancellablePrivate

type _GCancellable
	parent_instance as GObject
	priv as GCancellablePrivate ptr
end type

type _GCancellableClass
	parent_class as GObjectClass
	cancelled as sub(byval cancellable as GCancellable ptr)
	_g_reserved1 as sub()
	_g_reserved2 as sub()
	_g_reserved3 as sub()
	_g_reserved4 as sub()
	_g_reserved5 as sub()
end type

declare function g_cancellable_get_type() as GType
declare function g_cancellable_new() as GCancellable ptr
declare function g_cancellable_is_cancelled(byval cancellable as GCancellable ptr) as gboolean
declare function g_cancellable_set_error_if_cancelled(byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
declare function g_cancellable_get_fd(byval cancellable as GCancellable ptr) as long
declare function g_cancellable_make_pollfd(byval cancellable as GCancellable ptr, byval pollfd as GPollFD ptr) as gboolean
declare sub g_cancellable_release_fd(byval cancellable as GCancellable ptr)
declare function g_cancellable_source_new(byval cancellable as GCancellable ptr) as GSource ptr
declare function g_cancellable_get_current() as GCancellable ptr
declare sub g_cancellable_push_current(byval cancellable as GCancellable ptr)
declare sub g_cancellable_pop_current(byval cancellable as GCancellable ptr)
declare sub g_cancellable_reset(byval cancellable as GCancellable ptr)
declare function g_cancellable_connect(byval cancellable as GCancellable ptr, byval callback as GCallback, byval data as gpointer, byval data_destroy_func as GDestroyNotify) as gulong
declare sub g_cancellable_disconnect(byval cancellable as GCancellable ptr, byval handler_id as gulong)
declare sub g_cancellable_cancel(byval cancellable as GCancellable ptr)

#define __G_CHARSET_CONVERTER_H__
#define __G_CONVERTER_H__
#define G_TYPE_CONVERTER g_converter_get_type()
#define G_CONVERTER(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), G_TYPE_CONVERTER, GConverter)
#define G_IS_CONVERTER(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), G_TYPE_CONVERTER)
#define G_CONVERTER_GET_IFACE(obj) G_TYPE_INSTANCE_GET_INTERFACE((obj), G_TYPE_CONVERTER, GConverterIface)
type GConverterIface as _GConverterIface

type _GConverterIface
	g_iface as GTypeInterface
	convert as function(byval converter as GConverter ptr, byval inbuf as const any ptr, byval inbuf_size as gsize, byval outbuf as any ptr, byval outbuf_size as gsize, byval flags as GConverterFlags, byval bytes_read as gsize ptr, byval bytes_written as gsize ptr, byval error as GError ptr ptr) as GConverterResult
	reset as sub(byval converter as GConverter ptr)
end type

declare function g_converter_get_type() as GType
declare function g_converter_convert(byval converter as GConverter ptr, byval inbuf as const any ptr, byval inbuf_size as gsize, byval outbuf as any ptr, byval outbuf_size as gsize, byval flags as GConverterFlags, byval bytes_read as gsize ptr, byval bytes_written as gsize ptr, byval error as GError ptr ptr) as GConverterResult
declare sub g_converter_reset(byval converter as GConverter ptr)

#define G_TYPE_CHARSET_CONVERTER g_charset_converter_get_type()
#define G_CHARSET_CONVERTER(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_CHARSET_CONVERTER, GCharsetConverter)
#define G_CHARSET_CONVERTER_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_CHARSET_CONVERTER, GCharsetConverterClass)
#define G_IS_CHARSET_CONVERTER(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_CHARSET_CONVERTER)
#define G_IS_CHARSET_CONVERTER_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), G_TYPE_CHARSET_CONVERTER)
#define G_CHARSET_CONVERTER_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), G_TYPE_CHARSET_CONVERTER, GCharsetConverterClass)
type GCharsetConverterClass as _GCharsetConverterClass

type _GCharsetConverterClass
	parent_class as GObjectClass
end type

declare function g_charset_converter_get_type() as GType
declare function g_charset_converter_new(byval to_charset as const gchar ptr, byval from_charset as const gchar ptr, byval error as GError ptr ptr) as GCharsetConverter ptr
declare sub g_charset_converter_set_use_fallback(byval converter as GCharsetConverter ptr, byval use_fallback as gboolean)
declare function g_charset_converter_get_use_fallback(byval converter as GCharsetConverter ptr) as gboolean
declare function g_charset_converter_get_num_fallbacks(byval converter as GCharsetConverter ptr) as guint
#define __G_CONTENT_TYPE_H__
declare function g_content_type_equals(byval type1 as const gchar ptr, byval type2 as const gchar ptr) as gboolean
declare function g_content_type_is_a(byval type as const gchar ptr, byval supertype as const gchar ptr) as gboolean
declare function g_content_type_is_unknown(byval type as const gchar ptr) as gboolean
declare function g_content_type_get_description(byval type as const gchar ptr) as gchar ptr
declare function g_content_type_get_mime_type(byval type as const gchar ptr) as gchar ptr
declare function g_content_type_get_icon(byval type as const gchar ptr) as GIcon ptr
declare function g_content_type_get_symbolic_icon(byval type as const gchar ptr) as GIcon ptr
declare function g_content_type_get_generic_icon_name(byval type as const gchar ptr) as gchar ptr
declare function g_content_type_can_be_executable(byval type as const gchar ptr) as gboolean
declare function g_content_type_from_mime_type(byval mime_type as const gchar ptr) as gchar ptr
declare function g_content_type_guess(byval filename as const gchar ptr, byval data as const guchar ptr, byval data_size as gsize, byval result_uncertain as gboolean ptr) as gchar ptr
declare function g_content_type_guess_for_tree(byval root as GFile ptr) as gchar ptr ptr
declare function g_content_types_get_registered() as GList ptr

#define __G_CONVERTER_INPUT_STREAM_H__
#define G_TYPE_CONVERTER_INPUT_STREAM g_converter_input_stream_get_type()
#define G_CONVERTER_INPUT_STREAM(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_CONVERTER_INPUT_STREAM, GConverterInputStream)
#define G_CONVERTER_INPUT_STREAM_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_CONVERTER_INPUT_STREAM, GConverterInputStreamClass)
#define G_IS_CONVERTER_INPUT_STREAM(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_CONVERTER_INPUT_STREAM)
#define G_IS_CONVERTER_INPUT_STREAM_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), G_TYPE_CONVERTER_INPUT_STREAM)
#define G_CONVERTER_INPUT_STREAM_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), G_TYPE_CONVERTER_INPUT_STREAM, GConverterInputStreamClass)
type GConverterInputStreamClass as _GConverterInputStreamClass
type GConverterInputStreamPrivate as _GConverterInputStreamPrivate

type _GConverterInputStream
	parent_instance as GFilterInputStream
	priv as GConverterInputStreamPrivate ptr
end type

type _GConverterInputStreamClass
	parent_class as GFilterInputStreamClass
	_g_reserved1 as sub()
	_g_reserved2 as sub()
	_g_reserved3 as sub()
	_g_reserved4 as sub()
	_g_reserved5 as sub()
end type

declare function g_converter_input_stream_get_type() as GType
declare function g_converter_input_stream_new(byval base_stream as GInputStream ptr, byval converter as GConverter ptr) as GInputStream ptr
declare function g_converter_input_stream_get_converter(byval converter_stream as GConverterInputStream ptr) as GConverter ptr

#define __G_CONVERTER_OUTPUT_STREAM_H__
#define G_TYPE_CONVERTER_OUTPUT_STREAM g_converter_output_stream_get_type()
#define G_CONVERTER_OUTPUT_STREAM(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_CONVERTER_OUTPUT_STREAM, GConverterOutputStream)
#define G_CONVERTER_OUTPUT_STREAM_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_CONVERTER_OUTPUT_STREAM, GConverterOutputStreamClass)
#define G_IS_CONVERTER_OUTPUT_STREAM(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_CONVERTER_OUTPUT_STREAM)
#define G_IS_CONVERTER_OUTPUT_STREAM_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), G_TYPE_CONVERTER_OUTPUT_STREAM)
#define G_CONVERTER_OUTPUT_STREAM_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), G_TYPE_CONVERTER_OUTPUT_STREAM, GConverterOutputStreamClass)
type GConverterOutputStreamClass as _GConverterOutputStreamClass
type GConverterOutputStreamPrivate as _GConverterOutputStreamPrivate

type _GConverterOutputStream
	parent_instance as GFilterOutputStream
	priv as GConverterOutputStreamPrivate ptr
end type

type _GConverterOutputStreamClass
	parent_class as GFilterOutputStreamClass
	_g_reserved1 as sub()
	_g_reserved2 as sub()
	_g_reserved3 as sub()
	_g_reserved4 as sub()
	_g_reserved5 as sub()
end type

declare function g_converter_output_stream_get_type() as GType
declare function g_converter_output_stream_new(byval base_stream as GOutputStream ptr, byval converter as GConverter ptr) as GOutputStream ptr
declare function g_converter_output_stream_get_converter(byval converter_stream as GConverterOutputStream ptr) as GConverter ptr

#define __G_CREDENTIALS_H__
#define G_TYPE_CREDENTIALS g_credentials_get_type()
#define G_CREDENTIALS(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_CREDENTIALS, GCredentials)
#define G_CREDENTIALS_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_CREDENTIALS, GCredentialsClass)
#define G_CREDENTIALS_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), G_TYPE_CREDENTIALS, GCredentialsClass)
#define G_IS_CREDENTIALS(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_CREDENTIALS)
#define G_IS_CREDENTIALS_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), G_TYPE_CREDENTIALS)
type GCredentialsClass as _GCredentialsClass

declare function g_credentials_get_type() as GType
declare function g_credentials_new() as GCredentials ptr
declare function g_credentials_to_string(byval credentials as GCredentials ptr) as gchar ptr
declare function g_credentials_get_native(byval credentials as GCredentials ptr, byval native_type as GCredentialsType) as gpointer
declare sub g_credentials_set_native(byval credentials as GCredentials ptr, byval native_type as GCredentialsType, byval native as gpointer)
declare function g_credentials_is_same_user(byval credentials as GCredentials ptr, byval other_credentials as GCredentials ptr, byval error as GError ptr ptr) as gboolean

#ifdef __FB_UNIX__
	declare function g_credentials_get_unix_pid(byval credentials as GCredentials ptr, byval error as GError ptr ptr) as pid_t
	declare function g_credentials_get_unix_user(byval credentials as GCredentials ptr, byval error as GError ptr ptr) as uid_t
	declare function g_credentials_set_unix_user(byval credentials as GCredentials ptr, byval uid as uid_t, byval error as GError ptr ptr) as gboolean
#endif

#define __G_DATA_INPUT_STREAM_H__
#define G_TYPE_DATA_INPUT_STREAM g_data_input_stream_get_type()
#define G_DATA_INPUT_STREAM(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_DATA_INPUT_STREAM, GDataInputStream)
#define G_DATA_INPUT_STREAM_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_DATA_INPUT_STREAM, GDataInputStreamClass)
#define G_IS_DATA_INPUT_STREAM(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_DATA_INPUT_STREAM)
#define G_IS_DATA_INPUT_STREAM_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), G_TYPE_DATA_INPUT_STREAM)
#define G_DATA_INPUT_STREAM_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), G_TYPE_DATA_INPUT_STREAM, GDataInputStreamClass)
type GDataInputStreamClass as _GDataInputStreamClass
type GDataInputStreamPrivate as _GDataInputStreamPrivate

type _GDataInputStream
	parent_instance as GBufferedInputStream
	priv as GDataInputStreamPrivate ptr
end type

type _GDataInputStreamClass
	parent_class as GBufferedInputStreamClass
	_g_reserved1 as sub()
	_g_reserved2 as sub()
	_g_reserved3 as sub()
	_g_reserved4 as sub()
	_g_reserved5 as sub()
end type

declare function g_data_input_stream_get_type() as GType
declare function g_data_input_stream_new(byval base_stream as GInputStream ptr) as GDataInputStream ptr
declare sub g_data_input_stream_set_byte_order(byval stream as GDataInputStream ptr, byval order as GDataStreamByteOrder)
declare function g_data_input_stream_get_byte_order(byval stream as GDataInputStream ptr) as GDataStreamByteOrder
declare sub g_data_input_stream_set_newline_type(byval stream as GDataInputStream ptr, byval type as GDataStreamNewlineType)
declare function g_data_input_stream_get_newline_type(byval stream as GDataInputStream ptr) as GDataStreamNewlineType
declare function g_data_input_stream_read_byte(byval stream as GDataInputStream ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as guchar
declare function g_data_input_stream_read_int16(byval stream as GDataInputStream ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gint16
declare function g_data_input_stream_read_uint16(byval stream as GDataInputStream ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as guint16
declare function g_data_input_stream_read_int32(byval stream as GDataInputStream ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gint32
declare function g_data_input_stream_read_uint32(byval stream as GDataInputStream ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as guint32
declare function g_data_input_stream_read_int64(byval stream as GDataInputStream ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gint64
declare function g_data_input_stream_read_uint64(byval stream as GDataInputStream ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as guint64
declare function g_data_input_stream_read_line(byval stream as GDataInputStream ptr, byval length as gsize ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as zstring ptr
declare function g_data_input_stream_read_line_utf8(byval stream as GDataInputStream ptr, byval length as gsize ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as zstring ptr
declare sub g_data_input_stream_read_line_async(byval stream as GDataInputStream ptr, byval io_priority as gint, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_data_input_stream_read_line_finish(byval stream as GDataInputStream ptr, byval result as GAsyncResult ptr, byval length as gsize ptr, byval error as GError ptr ptr) as zstring ptr
declare function g_data_input_stream_read_line_finish_utf8(byval stream as GDataInputStream ptr, byval result as GAsyncResult ptr, byval length as gsize ptr, byval error as GError ptr ptr) as zstring ptr
declare function g_data_input_stream_read_until(byval stream as GDataInputStream ptr, byval stop_chars as const gchar ptr, byval length as gsize ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as zstring ptr
declare sub g_data_input_stream_read_until_async(byval stream as GDataInputStream ptr, byval stop_chars as const gchar ptr, byval io_priority as gint, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_data_input_stream_read_until_finish(byval stream as GDataInputStream ptr, byval result as GAsyncResult ptr, byval length as gsize ptr, byval error as GError ptr ptr) as zstring ptr
declare function g_data_input_stream_read_upto(byval stream as GDataInputStream ptr, byval stop_chars as const gchar ptr, byval stop_chars_len as gssize, byval length as gsize ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as zstring ptr
declare sub g_data_input_stream_read_upto_async(byval stream as GDataInputStream ptr, byval stop_chars as const gchar ptr, byval stop_chars_len as gssize, byval io_priority as gint, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_data_input_stream_read_upto_finish(byval stream as GDataInputStream ptr, byval result as GAsyncResult ptr, byval length as gsize ptr, byval error as GError ptr ptr) as zstring ptr

#define __G_DATA_OUTPUT_STREAM_H__
#define G_TYPE_DATA_OUTPUT_STREAM g_data_output_stream_get_type()
#define G_DATA_OUTPUT_STREAM(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_DATA_OUTPUT_STREAM, GDataOutputStream)
#define G_DATA_OUTPUT_STREAM_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_DATA_OUTPUT_STREAM, GDataOutputStreamClass)
#define G_IS_DATA_OUTPUT_STREAM(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_DATA_OUTPUT_STREAM)
#define G_IS_DATA_OUTPUT_STREAM_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), G_TYPE_DATA_OUTPUT_STREAM)
#define G_DATA_OUTPUT_STREAM_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), G_TYPE_DATA_OUTPUT_STREAM, GDataOutputStreamClass)

type GDataOutputStream as _GDataOutputStream
type GDataOutputStreamClass as _GDataOutputStreamClass
type GDataOutputStreamPrivate as _GDataOutputStreamPrivate

type _GDataOutputStream
	parent_instance as GFilterOutputStream
	priv as GDataOutputStreamPrivate ptr
end type

type _GDataOutputStreamClass
	parent_class as GFilterOutputStreamClass
	_g_reserved1 as sub()
	_g_reserved2 as sub()
	_g_reserved3 as sub()
	_g_reserved4 as sub()
	_g_reserved5 as sub()
end type

declare function g_data_output_stream_get_type() as GType
declare function g_data_output_stream_new(byval base_stream as GOutputStream ptr) as GDataOutputStream ptr
declare sub g_data_output_stream_set_byte_order(byval stream as GDataOutputStream ptr, byval order as GDataStreamByteOrder)
declare function g_data_output_stream_get_byte_order(byval stream as GDataOutputStream ptr) as GDataStreamByteOrder
declare function g_data_output_stream_put_byte(byval stream as GDataOutputStream ptr, byval data as guchar, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
declare function g_data_output_stream_put_int16(byval stream as GDataOutputStream ptr, byval data as gint16, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
declare function g_data_output_stream_put_uint16(byval stream as GDataOutputStream ptr, byval data as guint16, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
declare function g_data_output_stream_put_int32(byval stream as GDataOutputStream ptr, byval data as gint32, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
declare function g_data_output_stream_put_uint32(byval stream as GDataOutputStream ptr, byval data as guint32, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
declare function g_data_output_stream_put_int64(byval stream as GDataOutputStream ptr, byval data as gint64, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
declare function g_data_output_stream_put_uint64(byval stream as GDataOutputStream ptr, byval data as guint64, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
declare function g_data_output_stream_put_string(byval stream as GDataOutputStream ptr, byval str as const zstring ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
#define __G_DBUS_ADDRESS_H__
declare function g_dbus_address_escape_value(byval string as const gchar ptr) as gchar ptr
declare function g_dbus_is_address(byval string as const gchar ptr) as gboolean
declare function g_dbus_is_supported_address(byval string as const gchar ptr, byval error as GError ptr ptr) as gboolean
declare sub g_dbus_address_get_stream(byval address as const gchar ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_dbus_address_get_stream_finish(byval res as GAsyncResult ptr, byval out_guid as gchar ptr ptr, byval error as GError ptr ptr) as GIOStream ptr
declare function g_dbus_address_get_stream_sync(byval address as const gchar ptr, byval out_guid as gchar ptr ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GIOStream ptr
declare function g_dbus_address_get_for_bus_sync(byval bus_type as GBusType, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gchar ptr

#define __G_DBUS_AUTH_OBSERVER_H__
#define G_TYPE_DBUS_AUTH_OBSERVER g_dbus_auth_observer_get_type()
#define G_DBUS_AUTH_OBSERVER(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_DBUS_AUTH_OBSERVER, GDBusAuthObserver)
#define G_IS_DBUS_AUTH_OBSERVER(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_DBUS_AUTH_OBSERVER)

declare function g_dbus_auth_observer_get_type() as GType
declare function g_dbus_auth_observer_new() as GDBusAuthObserver ptr
declare function g_dbus_auth_observer_authorize_authenticated_peer(byval observer as GDBusAuthObserver ptr, byval stream as GIOStream ptr, byval credentials as GCredentials ptr) as gboolean
declare function g_dbus_auth_observer_allow_mechanism(byval observer as GDBusAuthObserver ptr, byval mechanism as const gchar ptr) as gboolean

#define __G_DBUS_CONNECTION_H__
#define G_TYPE_DBUS_CONNECTION g_dbus_connection_get_type()
#define G_DBUS_CONNECTION(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_DBUS_CONNECTION, GDBusConnection)
#define G_IS_DBUS_CONNECTION(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_DBUS_CONNECTION)

declare function g_dbus_connection_get_type() as GType
declare sub g_bus_get(byval bus_type as GBusType, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_bus_get_finish(byval res as GAsyncResult ptr, byval error as GError ptr ptr) as GDBusConnection ptr
declare function g_bus_get_sync(byval bus_type as GBusType, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GDBusConnection ptr
declare sub g_dbus_connection_new(byval stream as GIOStream ptr, byval guid as const gchar ptr, byval flags as GDBusConnectionFlags, byval observer as GDBusAuthObserver ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_dbus_connection_new_finish(byval res as GAsyncResult ptr, byval error as GError ptr ptr) as GDBusConnection ptr
declare function g_dbus_connection_new_sync(byval stream as GIOStream ptr, byval guid as const gchar ptr, byval flags as GDBusConnectionFlags, byval observer as GDBusAuthObserver ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GDBusConnection ptr
declare sub g_dbus_connection_new_for_address(byval address as const gchar ptr, byval flags as GDBusConnectionFlags, byval observer as GDBusAuthObserver ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_dbus_connection_new_for_address_finish(byval res as GAsyncResult ptr, byval error as GError ptr ptr) as GDBusConnection ptr
declare function g_dbus_connection_new_for_address_sync(byval address as const gchar ptr, byval flags as GDBusConnectionFlags, byval observer as GDBusAuthObserver ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GDBusConnection ptr
declare sub g_dbus_connection_start_message_processing(byval connection as GDBusConnection ptr)
declare function g_dbus_connection_is_closed(byval connection as GDBusConnection ptr) as gboolean
declare function g_dbus_connection_get_stream(byval connection as GDBusConnection ptr) as GIOStream ptr
declare function g_dbus_connection_get_guid(byval connection as GDBusConnection ptr) as const gchar ptr
declare function g_dbus_connection_get_unique_name(byval connection as GDBusConnection ptr) as const gchar ptr
declare function g_dbus_connection_get_peer_credentials(byval connection as GDBusConnection ptr) as GCredentials ptr
declare function g_dbus_connection_get_last_serial(byval connection as GDBusConnection ptr) as guint32
declare function g_dbus_connection_get_exit_on_close(byval connection as GDBusConnection ptr) as gboolean
declare sub g_dbus_connection_set_exit_on_close(byval connection as GDBusConnection ptr, byval exit_on_close as gboolean)
declare function g_dbus_connection_get_capabilities(byval connection as GDBusConnection ptr) as GDBusCapabilityFlags
declare sub g_dbus_connection_close(byval connection as GDBusConnection ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_dbus_connection_close_finish(byval connection as GDBusConnection ptr, byval res as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
declare function g_dbus_connection_close_sync(byval connection as GDBusConnection ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
declare sub g_dbus_connection_flush(byval connection as GDBusConnection ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_dbus_connection_flush_finish(byval connection as GDBusConnection ptr, byval res as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
declare function g_dbus_connection_flush_sync(byval connection as GDBusConnection ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
declare function g_dbus_connection_send_message(byval connection as GDBusConnection ptr, byval message as GDBusMessage ptr, byval flags as GDBusSendMessageFlags, byval out_serial as guint32 ptr, byval error as GError ptr ptr) as gboolean
declare sub g_dbus_connection_send_message_with_reply(byval connection as GDBusConnection ptr, byval message as GDBusMessage ptr, byval flags as GDBusSendMessageFlags, byval timeout_msec as gint, byval out_serial as guint32 ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_dbus_connection_send_message_with_reply_finish(byval connection as GDBusConnection ptr, byval res as GAsyncResult ptr, byval error as GError ptr ptr) as GDBusMessage ptr
declare function g_dbus_connection_send_message_with_reply_sync(byval connection as GDBusConnection ptr, byval message as GDBusMessage ptr, byval flags as GDBusSendMessageFlags, byval timeout_msec as gint, byval out_serial as guint32 ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GDBusMessage ptr
declare function g_dbus_connection_emit_signal(byval connection as GDBusConnection ptr, byval destination_bus_name as const gchar ptr, byval object_path as const gchar ptr, byval interface_name as const gchar ptr, byval signal_name as const gchar ptr, byval parameters as GVariant ptr, byval error as GError ptr ptr) as gboolean
declare sub g_dbus_connection_call(byval connection as GDBusConnection ptr, byval bus_name as const gchar ptr, byval object_path as const gchar ptr, byval interface_name as const gchar ptr, byval method_name as const gchar ptr, byval parameters as GVariant ptr, byval reply_type as const GVariantType ptr, byval flags as GDBusCallFlags, byval timeout_msec as gint, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_dbus_connection_call_finish(byval connection as GDBusConnection ptr, byval res as GAsyncResult ptr, byval error as GError ptr ptr) as GVariant ptr
declare function g_dbus_connection_call_sync(byval connection as GDBusConnection ptr, byval bus_name as const gchar ptr, byval object_path as const gchar ptr, byval interface_name as const gchar ptr, byval method_name as const gchar ptr, byval parameters as GVariant ptr, byval reply_type as const GVariantType ptr, byval flags as GDBusCallFlags, byval timeout_msec as gint, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GVariant ptr
declare sub g_dbus_connection_call_with_unix_fd_list(byval connection as GDBusConnection ptr, byval bus_name as const gchar ptr, byval object_path as const gchar ptr, byval interface_name as const gchar ptr, byval method_name as const gchar ptr, byval parameters as GVariant ptr, byval reply_type as const GVariantType ptr, byval flags as GDBusCallFlags, byval timeout_msec as gint, byval fd_list as GUnixFDList ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_dbus_connection_call_with_unix_fd_list_finish(byval connection as GDBusConnection ptr, byval out_fd_list as GUnixFDList ptr ptr, byval res as GAsyncResult ptr, byval error as GError ptr ptr) as GVariant ptr
declare function g_dbus_connection_call_with_unix_fd_list_sync(byval connection as GDBusConnection ptr, byval bus_name as const gchar ptr, byval object_path as const gchar ptr, byval interface_name as const gchar ptr, byval method_name as const gchar ptr, byval parameters as GVariant ptr, byval reply_type as const GVariantType ptr, byval flags as GDBusCallFlags, byval timeout_msec as gint, byval fd_list as GUnixFDList ptr, byval out_fd_list as GUnixFDList ptr ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GVariant ptr

type GDBusInterfaceMethodCallFunc as sub(byval connection as GDBusConnection ptr, byval sender as const gchar ptr, byval object_path as const gchar ptr, byval interface_name as const gchar ptr, byval method_name as const gchar ptr, byval parameters as GVariant ptr, byval invocation as GDBusMethodInvocation ptr, byval user_data as gpointer)
type GDBusInterfaceGetPropertyFunc as function(byval connection as GDBusConnection ptr, byval sender as const gchar ptr, byval object_path as const gchar ptr, byval interface_name as const gchar ptr, byval property_name as const gchar ptr, byval error as GError ptr ptr, byval user_data as gpointer) as GVariant ptr
type GDBusInterfaceSetPropertyFunc as function(byval connection as GDBusConnection ptr, byval sender as const gchar ptr, byval object_path as const gchar ptr, byval interface_name as const gchar ptr, byval property_name as const gchar ptr, byval value as GVariant ptr, byval error as GError ptr ptr, byval user_data as gpointer) as gboolean

type _GDBusInterfaceVTable
	method_call as GDBusInterfaceMethodCallFunc
	get_property as GDBusInterfaceGetPropertyFunc
	set_property as GDBusInterfaceSetPropertyFunc
	padding(0 to 7) as gpointer
end type

declare function g_dbus_connection_register_object(byval connection as GDBusConnection ptr, byval object_path as const gchar ptr, byval interface_info as GDBusInterfaceInfo ptr, byval vtable as const GDBusInterfaceVTable ptr, byval user_data as gpointer, byval user_data_free_func as GDestroyNotify, byval error as GError ptr ptr) as guint
declare function g_dbus_connection_unregister_object(byval connection as GDBusConnection ptr, byval registration_id as guint) as gboolean
type GDBusSubtreeEnumerateFunc as function(byval connection as GDBusConnection ptr, byval sender as const gchar ptr, byval object_path as const gchar ptr, byval user_data as gpointer) as gchar ptr ptr
type GDBusSubtreeIntrospectFunc as function(byval connection as GDBusConnection ptr, byval sender as const gchar ptr, byval object_path as const gchar ptr, byval node as const gchar ptr, byval user_data as gpointer) as GDBusInterfaceInfo ptr ptr
type GDBusSubtreeDispatchFunc as function(byval connection as GDBusConnection ptr, byval sender as const gchar ptr, byval object_path as const gchar ptr, byval interface_name as const gchar ptr, byval node as const gchar ptr, byval out_user_data as gpointer ptr, byval user_data as gpointer) as const GDBusInterfaceVTable ptr

type _GDBusSubtreeVTable
	enumerate as GDBusSubtreeEnumerateFunc
	introspect as GDBusSubtreeIntrospectFunc
	dispatch as GDBusSubtreeDispatchFunc
	padding(0 to 7) as gpointer
end type

declare function g_dbus_connection_register_subtree(byval connection as GDBusConnection ptr, byval object_path as const gchar ptr, byval vtable as const GDBusSubtreeVTable ptr, byval flags as GDBusSubtreeFlags, byval user_data as gpointer, byval user_data_free_func as GDestroyNotify, byval error as GError ptr ptr) as guint
declare function g_dbus_connection_unregister_subtree(byval connection as GDBusConnection ptr, byval registration_id as guint) as gboolean
type GDBusSignalCallback as sub(byval connection as GDBusConnection ptr, byval sender_name as const gchar ptr, byval object_path as const gchar ptr, byval interface_name as const gchar ptr, byval signal_name as const gchar ptr, byval parameters as GVariant ptr, byval user_data as gpointer)
declare function g_dbus_connection_signal_subscribe(byval connection as GDBusConnection ptr, byval sender as const gchar ptr, byval interface_name as const gchar ptr, byval member as const gchar ptr, byval object_path as const gchar ptr, byval arg0 as const gchar ptr, byval flags as GDBusSignalFlags, byval callback as GDBusSignalCallback, byval user_data as gpointer, byval user_data_free_func as GDestroyNotify) as guint
declare sub g_dbus_connection_signal_unsubscribe(byval connection as GDBusConnection ptr, byval subscription_id as guint)
type GDBusMessageFilterFunction as function(byval connection as GDBusConnection ptr, byval message as GDBusMessage ptr, byval incoming as gboolean, byval user_data as gpointer) as GDBusMessage ptr
declare function g_dbus_connection_add_filter(byval connection as GDBusConnection ptr, byval filter_function as GDBusMessageFilterFunction, byval user_data as gpointer, byval user_data_free_func as GDestroyNotify) as guint
declare sub g_dbus_connection_remove_filter(byval connection as GDBusConnection ptr, byval filter_id as guint)
#define __G_DBUS_ERROR_H__
#define G_DBUS_ERROR g_dbus_error_quark()
declare function g_dbus_error_quark() as GQuark
declare function g_dbus_error_is_remote_error(byval error as const GError ptr) as gboolean
declare function g_dbus_error_get_remote_error(byval error as const GError ptr) as gchar ptr
declare function g_dbus_error_strip_remote_error(byval error as GError ptr) as gboolean

type _GDBusErrorEntry
	error_code as gint
	dbus_error_name as const gchar ptr
end type

declare function g_dbus_error_register_error(byval error_domain as GQuark, byval error_code as gint, byval dbus_error_name as const gchar ptr) as gboolean
declare function g_dbus_error_unregister_error(byval error_domain as GQuark, byval error_code as gint, byval dbus_error_name as const gchar ptr) as gboolean
declare sub g_dbus_error_register_error_domain(byval error_domain_quark_name as const gchar ptr, byval quark_volatile as gsize ptr, byval entries as const GDBusErrorEntry ptr, byval num_entries as guint)
declare function g_dbus_error_new_for_dbus_error(byval dbus_error_name as const gchar ptr, byval dbus_error_message as const gchar ptr) as GError ptr
declare sub g_dbus_error_set_dbus_error(byval error as GError ptr ptr, byval dbus_error_name as const gchar ptr, byval dbus_error_message as const gchar ptr, byval format as const gchar ptr, ...)
declare sub g_dbus_error_set_dbus_error_valist(byval error as GError ptr ptr, byval dbus_error_name as const gchar ptr, byval dbus_error_message as const gchar ptr, byval format as const gchar ptr, byval var_args as va_list)
declare function g_dbus_error_encode_gerror(byval error as const GError ptr) as gchar ptr
#define __G_DBUS_INTROSPECTION_H__

type _GDBusAnnotationInfo
	ref_count as gint
	key as gchar ptr
	value as gchar ptr
	annotations as GDBusAnnotationInfo ptr ptr
end type

type _GDBusArgInfo
	ref_count as gint
	name as gchar ptr
	signature as gchar ptr
	annotations as GDBusAnnotationInfo ptr ptr
end type

type _GDBusMethodInfo
	ref_count as gint
	name as gchar ptr
	in_args as GDBusArgInfo ptr ptr
	out_args as GDBusArgInfo ptr ptr
	annotations as GDBusAnnotationInfo ptr ptr
end type

type _GDBusSignalInfo
	ref_count as gint
	name as gchar ptr
	args as GDBusArgInfo ptr ptr
	annotations as GDBusAnnotationInfo ptr ptr
end type

type _GDBusPropertyInfo
	ref_count as gint
	name as gchar ptr
	signature as gchar ptr
	flags as GDBusPropertyInfoFlags
	annotations as GDBusAnnotationInfo ptr ptr
end type

type _GDBusInterfaceInfo
	ref_count as gint
	name as gchar ptr
	methods as GDBusMethodInfo ptr ptr
	signals as GDBusSignalInfo ptr ptr
	properties as GDBusPropertyInfo ptr ptr
	annotations as GDBusAnnotationInfo ptr ptr
end type

type _GDBusNodeInfo
	ref_count as gint
	path as gchar ptr
	interfaces as GDBusInterfaceInfo ptr ptr
	nodes as GDBusNodeInfo ptr ptr
	annotations as GDBusAnnotationInfo ptr ptr
end type

declare function g_dbus_annotation_info_lookup(byval annotations as GDBusAnnotationInfo ptr ptr, byval name as const gchar ptr) as const gchar ptr
declare function g_dbus_interface_info_lookup_method(byval info as GDBusInterfaceInfo ptr, byval name as const gchar ptr) as GDBusMethodInfo ptr
declare function g_dbus_interface_info_lookup_signal(byval info as GDBusInterfaceInfo ptr, byval name as const gchar ptr) as GDBusSignalInfo ptr
declare function g_dbus_interface_info_lookup_property(byval info as GDBusInterfaceInfo ptr, byval name as const gchar ptr) as GDBusPropertyInfo ptr
declare sub g_dbus_interface_info_cache_build(byval info as GDBusInterfaceInfo ptr)
declare sub g_dbus_interface_info_cache_release(byval info as GDBusInterfaceInfo ptr)
declare sub g_dbus_interface_info_generate_xml(byval info as GDBusInterfaceInfo ptr, byval indent as guint, byval string_builder as GString ptr)
declare function g_dbus_node_info_new_for_xml(byval xml_data as const gchar ptr, byval error as GError ptr ptr) as GDBusNodeInfo ptr
declare function g_dbus_node_info_lookup_interface(byval info as GDBusNodeInfo ptr, byval name as const gchar ptr) as GDBusInterfaceInfo ptr
declare sub g_dbus_node_info_generate_xml(byval info as GDBusNodeInfo ptr, byval indent as guint, byval string_builder as GString ptr)
declare function g_dbus_node_info_ref(byval info as GDBusNodeInfo ptr) as GDBusNodeInfo ptr
declare function g_dbus_interface_info_ref(byval info as GDBusInterfaceInfo ptr) as GDBusInterfaceInfo ptr
declare function g_dbus_method_info_ref(byval info as GDBusMethodInfo ptr) as GDBusMethodInfo ptr
declare function g_dbus_signal_info_ref(byval info as GDBusSignalInfo ptr) as GDBusSignalInfo ptr
declare function g_dbus_property_info_ref(byval info as GDBusPropertyInfo ptr) as GDBusPropertyInfo ptr
declare function g_dbus_arg_info_ref(byval info as GDBusArgInfo ptr) as GDBusArgInfo ptr
declare function g_dbus_annotation_info_ref(byval info as GDBusAnnotationInfo ptr) as GDBusAnnotationInfo ptr
declare sub g_dbus_node_info_unref(byval info as GDBusNodeInfo ptr)
declare sub g_dbus_interface_info_unref(byval info as GDBusInterfaceInfo ptr)
declare sub g_dbus_method_info_unref(byval info as GDBusMethodInfo ptr)
declare sub g_dbus_signal_info_unref(byval info as GDBusSignalInfo ptr)
declare sub g_dbus_property_info_unref(byval info as GDBusPropertyInfo ptr)
declare sub g_dbus_arg_info_unref(byval info as GDBusArgInfo ptr)
declare sub g_dbus_annotation_info_unref(byval info as GDBusAnnotationInfo ptr)

#define G_TYPE_DBUS_NODE_INFO g_dbus_node_info_get_type()
#define G_TYPE_DBUS_INTERFACE_INFO g_dbus_interface_info_get_type()
#define G_TYPE_DBUS_METHOD_INFO g_dbus_method_info_get_type()
#define G_TYPE_DBUS_SIGNAL_INFO g_dbus_signal_info_get_type()
#define G_TYPE_DBUS_PROPERTY_INFO g_dbus_property_info_get_type()
#define G_TYPE_DBUS_ARG_INFO g_dbus_arg_info_get_type()
#define G_TYPE_DBUS_ANNOTATION_INFO g_dbus_annotation_info_get_type()

declare function g_dbus_node_info_get_type() as GType
declare function g_dbus_interface_info_get_type() as GType
declare function g_dbus_method_info_get_type() as GType
declare function g_dbus_signal_info_get_type() as GType
declare function g_dbus_property_info_get_type() as GType
declare function g_dbus_arg_info_get_type() as GType
declare function g_dbus_annotation_info_get_type() as GType

#define __G_DBUS_MESSAGE_H__
#define G_TYPE_DBUS_MESSAGE g_dbus_message_get_type()
#define G_DBUS_MESSAGE(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_DBUS_MESSAGE, GDBusMessage)
#define G_IS_DBUS_MESSAGE(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_DBUS_MESSAGE)

declare function g_dbus_message_get_type() as GType
declare function g_dbus_message_new() as GDBusMessage ptr
declare function g_dbus_message_new_signal(byval path as const gchar ptr, byval interface_ as const gchar ptr, byval signal as const gchar ptr) as GDBusMessage ptr
declare function g_dbus_message_new_method_call(byval name as const gchar ptr, byval path as const gchar ptr, byval interface_ as const gchar ptr, byval method as const gchar ptr) as GDBusMessage ptr
declare function g_dbus_message_new_method_reply(byval method_call_message as GDBusMessage ptr) as GDBusMessage ptr
declare function g_dbus_message_new_method_error(byval method_call_message as GDBusMessage ptr, byval error_name as const gchar ptr, byval error_message_format as const gchar ptr, ...) as GDBusMessage ptr
declare function g_dbus_message_new_method_error_valist(byval method_call_message as GDBusMessage ptr, byval error_name as const gchar ptr, byval error_message_format as const gchar ptr, byval var_args as va_list) as GDBusMessage ptr
declare function g_dbus_message_new_method_error_literal(byval method_call_message as GDBusMessage ptr, byval error_name as const gchar ptr, byval error_message as const gchar ptr) as GDBusMessage ptr
declare function g_dbus_message_print(byval message as GDBusMessage ptr, byval indent as guint) as gchar ptr
declare function g_dbus_message_get_locked(byval message as GDBusMessage ptr) as gboolean
declare sub g_dbus_message_lock(byval message as GDBusMessage ptr)
declare function g_dbus_message_copy(byval message as GDBusMessage ptr, byval error as GError ptr ptr) as GDBusMessage ptr
declare function g_dbus_message_get_byte_order(byval message as GDBusMessage ptr) as GDBusMessageByteOrder
declare sub g_dbus_message_set_byte_order(byval message as GDBusMessage ptr, byval byte_order as GDBusMessageByteOrder)
declare function g_dbus_message_get_message_type(byval message as GDBusMessage ptr) as GDBusMessageType
declare sub g_dbus_message_set_message_type(byval message as GDBusMessage ptr, byval type as GDBusMessageType)
declare function g_dbus_message_get_flags(byval message as GDBusMessage ptr) as GDBusMessageFlags
declare sub g_dbus_message_set_flags(byval message as GDBusMessage ptr, byval flags as GDBusMessageFlags)
declare function g_dbus_message_get_serial(byval message as GDBusMessage ptr) as guint32
declare sub g_dbus_message_set_serial(byval message as GDBusMessage ptr, byval serial as guint32)
declare function g_dbus_message_get_header(byval message as GDBusMessage ptr, byval header_field as GDBusMessageHeaderField) as GVariant ptr
declare sub g_dbus_message_set_header(byval message as GDBusMessage ptr, byval header_field as GDBusMessageHeaderField, byval value as GVariant ptr)
declare function g_dbus_message_get_header_fields(byval message as GDBusMessage ptr) as guchar ptr
declare function g_dbus_message_get_body(byval message as GDBusMessage ptr) as GVariant ptr
declare sub g_dbus_message_set_body(byval message as GDBusMessage ptr, byval body as GVariant ptr)
declare function g_dbus_message_get_unix_fd_list(byval message as GDBusMessage ptr) as GUnixFDList ptr
declare sub g_dbus_message_set_unix_fd_list(byval message as GDBusMessage ptr, byval fd_list as GUnixFDList ptr)
declare function g_dbus_message_get_reply_serial(byval message as GDBusMessage ptr) as guint32
declare sub g_dbus_message_set_reply_serial(byval message as GDBusMessage ptr, byval value as guint32)
declare function g_dbus_message_get_interface(byval message as GDBusMessage ptr) as const gchar ptr
declare sub g_dbus_message_set_interface(byval message as GDBusMessage ptr, byval value as const gchar ptr)
declare function g_dbus_message_get_member(byval message as GDBusMessage ptr) as const gchar ptr
declare sub g_dbus_message_set_member(byval message as GDBusMessage ptr, byval value as const gchar ptr)
declare function g_dbus_message_get_path(byval message as GDBusMessage ptr) as const gchar ptr
declare sub g_dbus_message_set_path(byval message as GDBusMessage ptr, byval value as const gchar ptr)
declare function g_dbus_message_get_sender(byval message as GDBusMessage ptr) as const gchar ptr
declare sub g_dbus_message_set_sender(byval message as GDBusMessage ptr, byval value as const gchar ptr)
declare function g_dbus_message_get_destination(byval message as GDBusMessage ptr) as const gchar ptr
declare sub g_dbus_message_set_destination(byval message as GDBusMessage ptr, byval value as const gchar ptr)
declare function g_dbus_message_get_error_name(byval message as GDBusMessage ptr) as const gchar ptr
declare sub g_dbus_message_set_error_name(byval message as GDBusMessage ptr, byval value as const gchar ptr)
declare function g_dbus_message_get_signature(byval message as GDBusMessage ptr) as const gchar ptr
declare sub g_dbus_message_set_signature(byval message as GDBusMessage ptr, byval value as const gchar ptr)
declare function g_dbus_message_get_num_unix_fds(byval message as GDBusMessage ptr) as guint32
declare sub g_dbus_message_set_num_unix_fds(byval message as GDBusMessage ptr, byval value as guint32)
declare function g_dbus_message_get_arg0(byval message as GDBusMessage ptr) as const gchar ptr
declare function g_dbus_message_new_from_blob(byval blob as guchar ptr, byval blob_len as gsize, byval capabilities as GDBusCapabilityFlags, byval error as GError ptr ptr) as GDBusMessage ptr
declare function g_dbus_message_bytes_needed(byval blob as guchar ptr, byval blob_len as gsize, byval error as GError ptr ptr) as gssize
declare function g_dbus_message_to_blob(byval message as GDBusMessage ptr, byval out_size as gsize ptr, byval capabilities as GDBusCapabilityFlags, byval error as GError ptr ptr) as guchar ptr
declare function g_dbus_message_to_gerror(byval message as GDBusMessage ptr, byval error as GError ptr ptr) as gboolean

#define __G_DBUS_METHOD_INVOCATION_H__
#define G_TYPE_DBUS_METHOD_INVOCATION g_dbus_method_invocation_get_type()
#define G_DBUS_METHOD_INVOCATION(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_DBUS_METHOD_INVOCATION, GDBusMethodInvocation)
#define G_IS_DBUS_METHOD_INVOCATION(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_DBUS_METHOD_INVOCATION)

declare function g_dbus_method_invocation_get_type() as GType
declare function g_dbus_method_invocation_get_sender(byval invocation as GDBusMethodInvocation ptr) as const gchar ptr
declare function g_dbus_method_invocation_get_object_path(byval invocation as GDBusMethodInvocation ptr) as const gchar ptr
declare function g_dbus_method_invocation_get_interface_name(byval invocation as GDBusMethodInvocation ptr) as const gchar ptr
declare function g_dbus_method_invocation_get_method_name(byval invocation as GDBusMethodInvocation ptr) as const gchar ptr
declare function g_dbus_method_invocation_get_method_info(byval invocation as GDBusMethodInvocation ptr) as const GDBusMethodInfo ptr
declare function g_dbus_method_invocation_get_property_info(byval invocation as GDBusMethodInvocation ptr) as const GDBusPropertyInfo ptr
declare function g_dbus_method_invocation_get_connection(byval invocation as GDBusMethodInvocation ptr) as GDBusConnection ptr
declare function g_dbus_method_invocation_get_message(byval invocation as GDBusMethodInvocation ptr) as GDBusMessage ptr
declare function g_dbus_method_invocation_get_parameters(byval invocation as GDBusMethodInvocation ptr) as GVariant ptr
declare function g_dbus_method_invocation_get_user_data(byval invocation as GDBusMethodInvocation ptr) as gpointer
declare sub g_dbus_method_invocation_return_value(byval invocation as GDBusMethodInvocation ptr, byval parameters as GVariant ptr)
declare sub g_dbus_method_invocation_return_value_with_unix_fd_list(byval invocation as GDBusMethodInvocation ptr, byval parameters as GVariant ptr, byval fd_list as GUnixFDList ptr)
declare sub g_dbus_method_invocation_return_error(byval invocation as GDBusMethodInvocation ptr, byval domain as GQuark, byval code as gint, byval format as const gchar ptr, ...)
declare sub g_dbus_method_invocation_return_error_valist(byval invocation as GDBusMethodInvocation ptr, byval domain as GQuark, byval code as gint, byval format as const gchar ptr, byval var_args as va_list)
declare sub g_dbus_method_invocation_return_error_literal(byval invocation as GDBusMethodInvocation ptr, byval domain as GQuark, byval code as gint, byval message as const gchar ptr)
declare sub g_dbus_method_invocation_return_gerror(byval invocation as GDBusMethodInvocation ptr, byval error as const GError ptr)
declare sub g_dbus_method_invocation_take_error(byval invocation as GDBusMethodInvocation ptr, byval error as GError ptr)
declare sub g_dbus_method_invocation_return_dbus_error(byval invocation as GDBusMethodInvocation ptr, byval error_name as const gchar ptr, byval error_message as const gchar ptr)
#define __G_DBUS_NAME_OWNING_H__

type GBusAcquiredCallback as sub(byval connection as GDBusConnection ptr, byval name as const gchar ptr, byval user_data as gpointer)
type GBusNameAcquiredCallback as sub(byval connection as GDBusConnection ptr, byval name as const gchar ptr, byval user_data as gpointer)
type GBusNameLostCallback as sub(byval connection as GDBusConnection ptr, byval name as const gchar ptr, byval user_data as gpointer)

declare function g_bus_own_name(byval bus_type as GBusType, byval name as const gchar ptr, byval flags as GBusNameOwnerFlags, byval bus_acquired_handler as GBusAcquiredCallback, byval name_acquired_handler as GBusNameAcquiredCallback, byval name_lost_handler as GBusNameLostCallback, byval user_data as gpointer, byval user_data_free_func as GDestroyNotify) as guint
declare function g_bus_own_name_on_connection(byval connection as GDBusConnection ptr, byval name as const gchar ptr, byval flags as GBusNameOwnerFlags, byval name_acquired_handler as GBusNameAcquiredCallback, byval name_lost_handler as GBusNameLostCallback, byval user_data as gpointer, byval user_data_free_func as GDestroyNotify) as guint
declare function g_bus_own_name_with_closures(byval bus_type as GBusType, byval name as const gchar ptr, byval flags as GBusNameOwnerFlags, byval bus_acquired_closure as GClosure ptr, byval name_acquired_closure as GClosure ptr, byval name_lost_closure as GClosure ptr) as guint
declare function g_bus_own_name_on_connection_with_closures(byval connection as GDBusConnection ptr, byval name as const gchar ptr, byval flags as GBusNameOwnerFlags, byval name_acquired_closure as GClosure ptr, byval name_lost_closure as GClosure ptr) as guint
declare sub g_bus_unown_name(byval owner_id as guint)
#define __G_DBUS_NAME_WATCHING_H__
type GBusNameAppearedCallback as sub(byval connection as GDBusConnection ptr, byval name as const gchar ptr, byval name_owner as const gchar ptr, byval user_data as gpointer)
type GBusNameVanishedCallback as sub(byval connection as GDBusConnection ptr, byval name as const gchar ptr, byval user_data as gpointer)
declare function g_bus_watch_name(byval bus_type as GBusType, byval name as const gchar ptr, byval flags as GBusNameWatcherFlags, byval name_appeared_handler as GBusNameAppearedCallback, byval name_vanished_handler as GBusNameVanishedCallback, byval user_data as gpointer, byval user_data_free_func as GDestroyNotify) as guint
declare function g_bus_watch_name_on_connection(byval connection as GDBusConnection ptr, byval name as const gchar ptr, byval flags as GBusNameWatcherFlags, byval name_appeared_handler as GBusNameAppearedCallback, byval name_vanished_handler as GBusNameVanishedCallback, byval user_data as gpointer, byval user_data_free_func as GDestroyNotify) as guint
declare function g_bus_watch_name_with_closures(byval bus_type as GBusType, byval name as const gchar ptr, byval flags as GBusNameWatcherFlags, byval name_appeared_closure as GClosure ptr, byval name_vanished_closure as GClosure ptr) as guint
declare function g_bus_watch_name_on_connection_with_closures(byval connection as GDBusConnection ptr, byval name as const gchar ptr, byval flags as GBusNameWatcherFlags, byval name_appeared_closure as GClosure ptr, byval name_vanished_closure as GClosure ptr) as guint
declare sub g_bus_unwatch_name(byval watcher_id as guint)

#define __G_DBUS_PROXY_H__
#define G_TYPE_DBUS_PROXY g_dbus_proxy_get_type()
#define G_DBUS_PROXY(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_DBUS_PROXY, GDBusProxy)
#define G_DBUS_PROXY_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_DBUS_PROXY, GDBusProxyClass)
#define G_DBUS_PROXY_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), G_TYPE_DBUS_PROXY, GDBusProxyClass)
#define G_IS_DBUS_PROXY(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_DBUS_PROXY)
#define G_IS_DBUS_PROXY_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), G_TYPE_DBUS_PROXY)
type GDBusProxyClass as _GDBusProxyClass
type GDBusProxyPrivate as _GDBusProxyPrivate

type _GDBusProxy
	parent_instance as GObject
	priv as GDBusProxyPrivate ptr
end type

type _GDBusProxyClass
	parent_class as GObjectClass
	g_properties_changed as sub(byval proxy as GDBusProxy ptr, byval changed_properties as GVariant ptr, byval invalidated_properties as const gchar const ptr ptr)
	g_signal as sub(byval proxy as GDBusProxy ptr, byval sender_name as const gchar ptr, byval signal_name as const gchar ptr, byval parameters as GVariant ptr)
	padding(0 to 31) as gpointer
end type

declare function g_dbus_proxy_get_type() as GType
declare sub g_dbus_proxy_new(byval connection as GDBusConnection ptr, byval flags as GDBusProxyFlags, byval info as GDBusInterfaceInfo ptr, byval name as const gchar ptr, byval object_path as const gchar ptr, byval interface_name as const gchar ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_dbus_proxy_new_finish(byval res as GAsyncResult ptr, byval error as GError ptr ptr) as GDBusProxy ptr
declare function g_dbus_proxy_new_sync(byval connection as GDBusConnection ptr, byval flags as GDBusProxyFlags, byval info as GDBusInterfaceInfo ptr, byval name as const gchar ptr, byval object_path as const gchar ptr, byval interface_name as const gchar ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GDBusProxy ptr
declare sub g_dbus_proxy_new_for_bus(byval bus_type as GBusType, byval flags as GDBusProxyFlags, byval info as GDBusInterfaceInfo ptr, byval name as const gchar ptr, byval object_path as const gchar ptr, byval interface_name as const gchar ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_dbus_proxy_new_for_bus_finish(byval res as GAsyncResult ptr, byval error as GError ptr ptr) as GDBusProxy ptr
declare function g_dbus_proxy_new_for_bus_sync(byval bus_type as GBusType, byval flags as GDBusProxyFlags, byval info as GDBusInterfaceInfo ptr, byval name as const gchar ptr, byval object_path as const gchar ptr, byval interface_name as const gchar ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GDBusProxy ptr
declare function g_dbus_proxy_get_connection(byval proxy as GDBusProxy ptr) as GDBusConnection ptr
declare function g_dbus_proxy_get_flags(byval proxy as GDBusProxy ptr) as GDBusProxyFlags
declare function g_dbus_proxy_get_name(byval proxy as GDBusProxy ptr) as const gchar ptr
declare function g_dbus_proxy_get_name_owner(byval proxy as GDBusProxy ptr) as gchar ptr
declare function g_dbus_proxy_get_object_path(byval proxy as GDBusProxy ptr) as const gchar ptr
declare function g_dbus_proxy_get_interface_name(byval proxy as GDBusProxy ptr) as const gchar ptr
declare function g_dbus_proxy_get_default_timeout(byval proxy as GDBusProxy ptr) as gint
declare sub g_dbus_proxy_set_default_timeout(byval proxy as GDBusProxy ptr, byval timeout_msec as gint)
declare function g_dbus_proxy_get_interface_info(byval proxy as GDBusProxy ptr) as GDBusInterfaceInfo ptr
declare sub g_dbus_proxy_set_interface_info(byval proxy as GDBusProxy ptr, byval info as GDBusInterfaceInfo ptr)
declare function g_dbus_proxy_get_cached_property(byval proxy as GDBusProxy ptr, byval property_name as const gchar ptr) as GVariant ptr
declare sub g_dbus_proxy_set_cached_property(byval proxy as GDBusProxy ptr, byval property_name as const gchar ptr, byval value as GVariant ptr)
declare function g_dbus_proxy_get_cached_property_names(byval proxy as GDBusProxy ptr) as gchar ptr ptr
declare sub g_dbus_proxy_call(byval proxy as GDBusProxy ptr, byval method_name as const gchar ptr, byval parameters as GVariant ptr, byval flags as GDBusCallFlags, byval timeout_msec as gint, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_dbus_proxy_call_finish(byval proxy as GDBusProxy ptr, byval res as GAsyncResult ptr, byval error as GError ptr ptr) as GVariant ptr
declare function g_dbus_proxy_call_sync(byval proxy as GDBusProxy ptr, byval method_name as const gchar ptr, byval parameters as GVariant ptr, byval flags as GDBusCallFlags, byval timeout_msec as gint, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GVariant ptr
declare sub g_dbus_proxy_call_with_unix_fd_list(byval proxy as GDBusProxy ptr, byval method_name as const gchar ptr, byval parameters as GVariant ptr, byval flags as GDBusCallFlags, byval timeout_msec as gint, byval fd_list as GUnixFDList ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_dbus_proxy_call_with_unix_fd_list_finish(byval proxy as GDBusProxy ptr, byval out_fd_list as GUnixFDList ptr ptr, byval res as GAsyncResult ptr, byval error as GError ptr ptr) as GVariant ptr
declare function g_dbus_proxy_call_with_unix_fd_list_sync(byval proxy as GDBusProxy ptr, byval method_name as const gchar ptr, byval parameters as GVariant ptr, byval flags as GDBusCallFlags, byval timeout_msec as gint, byval fd_list as GUnixFDList ptr, byval out_fd_list as GUnixFDList ptr ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GVariant ptr

#define __G_DBUS_SERVER_H__
#define G_TYPE_DBUS_SERVER g_dbus_server_get_type()
#define G_DBUS_SERVER(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_DBUS_SERVER, GDBusServer)
#define G_IS_DBUS_SERVER(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_DBUS_SERVER)

declare function g_dbus_server_get_type() as GType
declare function g_dbus_server_new_sync(byval address as const gchar ptr, byval flags as GDBusServerFlags, byval guid as const gchar ptr, byval observer as GDBusAuthObserver ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GDBusServer ptr
declare function g_dbus_server_get_client_address(byval server as GDBusServer ptr) as const gchar ptr
declare function g_dbus_server_get_guid(byval server as GDBusServer ptr) as const gchar ptr
declare function g_dbus_server_get_flags(byval server as GDBusServer ptr) as GDBusServerFlags
declare sub g_dbus_server_start(byval server as GDBusServer ptr)
declare sub g_dbus_server_stop(byval server as GDBusServer ptr)
declare function g_dbus_server_is_active(byval server as GDBusServer ptr) as gboolean
#define __G_DBUS_UTILS_H__
declare function g_dbus_is_guid(byval string as const gchar ptr) as gboolean
declare function g_dbus_generate_guid() as gchar ptr
declare function g_dbus_is_name(byval string as const gchar ptr) as gboolean
declare function g_dbus_is_unique_name(byval string as const gchar ptr) as gboolean
declare function g_dbus_is_member_name(byval string as const gchar ptr) as gboolean
declare function g_dbus_is_interface_name(byval string as const gchar ptr) as gboolean
declare sub g_dbus_gvariant_to_gvalue(byval value as GVariant ptr, byval out_gvalue as GValue ptr)
declare function g_dbus_gvalue_to_gvariant(byval gvalue as const GValue ptr, byval type as const GVariantType ptr) as GVariant ptr

#define __G_DRIVE_H__
#define G_TYPE_DRIVE g_drive_get_type()
#define G_DRIVE(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), G_TYPE_DRIVE, GDrive)
#define G_IS_DRIVE(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), G_TYPE_DRIVE)
#define G_DRIVE_GET_IFACE(obj) G_TYPE_INSTANCE_GET_INTERFACE((obj), G_TYPE_DRIVE, GDriveIface)
type GDriveIface as _GDriveIface

type _GDriveIface
	g_iface as GTypeInterface
	changed as sub(byval drive as GDrive ptr)
	disconnected as sub(byval drive as GDrive ptr)
	eject_button as sub(byval drive as GDrive ptr)
	get_name as function(byval drive as GDrive ptr) as zstring ptr
	get_icon as function(byval drive as GDrive ptr) as GIcon ptr
	has_volumes as function(byval drive as GDrive ptr) as gboolean
	get_volumes as function(byval drive as GDrive ptr) as GList ptr
	is_media_removable as function(byval drive as GDrive ptr) as gboolean
	has_media as function(byval drive as GDrive ptr) as gboolean
	is_media_check_automatic as function(byval drive as GDrive ptr) as gboolean
	can_eject as function(byval drive as GDrive ptr) as gboolean
	can_poll_for_media as function(byval drive as GDrive ptr) as gboolean
	eject as sub(byval drive as GDrive ptr, byval flags as GMountUnmountFlags, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	eject_finish as function(byval drive as GDrive ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
	poll_for_media as sub(byval drive as GDrive ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	poll_for_media_finish as function(byval drive as GDrive ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
	get_identifier as function(byval drive as GDrive ptr, byval kind as const zstring ptr) as zstring ptr
	enumerate_identifiers as function(byval drive as GDrive ptr) as zstring ptr ptr
	get_start_stop_type as function(byval drive as GDrive ptr) as GDriveStartStopType
	can_start as function(byval drive as GDrive ptr) as gboolean
	can_start_degraded as function(byval drive as GDrive ptr) as gboolean
	start as sub(byval drive as GDrive ptr, byval flags as GDriveStartFlags, byval mount_operation as GMountOperation ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	start_finish as function(byval drive as GDrive ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
	can_stop as function(byval drive as GDrive ptr) as gboolean
	stop as sub(byval drive as GDrive ptr, byval flags as GMountUnmountFlags, byval mount_operation as GMountOperation ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	stop_finish as function(byval drive as GDrive ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
	stop_button as sub(byval drive as GDrive ptr)
	eject_with_operation as sub(byval drive as GDrive ptr, byval flags as GMountUnmountFlags, byval mount_operation as GMountOperation ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	eject_with_operation_finish as function(byval drive as GDrive ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
	get_sort_key as function(byval drive as GDrive ptr) as const gchar ptr
	get_symbolic_icon as function(byval drive as GDrive ptr) as GIcon ptr
end type

declare function g_drive_get_type() as GType
declare function g_drive_get_name(byval drive as GDrive ptr) as zstring ptr
declare function g_drive_get_icon(byval drive as GDrive ptr) as GIcon ptr
declare function g_drive_get_symbolic_icon(byval drive as GDrive ptr) as GIcon ptr
declare function g_drive_has_volumes(byval drive as GDrive ptr) as gboolean
declare function g_drive_get_volumes(byval drive as GDrive ptr) as GList ptr
declare function g_drive_is_media_removable(byval drive as GDrive ptr) as gboolean
declare function g_drive_has_media(byval drive as GDrive ptr) as gboolean
declare function g_drive_is_media_check_automatic(byval drive as GDrive ptr) as gboolean
declare function g_drive_can_poll_for_media(byval drive as GDrive ptr) as gboolean
declare function g_drive_can_eject(byval drive as GDrive ptr) as gboolean
declare sub g_drive_eject(byval drive as GDrive ptr, byval flags as GMountUnmountFlags, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_drive_eject_finish(byval drive as GDrive ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
declare sub g_drive_poll_for_media(byval drive as GDrive ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_drive_poll_for_media_finish(byval drive as GDrive ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
declare function g_drive_get_identifier(byval drive as GDrive ptr, byval kind as const zstring ptr) as zstring ptr
declare function g_drive_enumerate_identifiers(byval drive as GDrive ptr) as zstring ptr ptr
declare function g_drive_get_start_stop_type(byval drive as GDrive ptr) as GDriveStartStopType
declare function g_drive_can_start(byval drive as GDrive ptr) as gboolean
declare function g_drive_can_start_degraded(byval drive as GDrive ptr) as gboolean
declare sub g_drive_start(byval drive as GDrive ptr, byval flags as GDriveStartFlags, byval mount_operation as GMountOperation ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_drive_start_finish(byval drive as GDrive ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
declare function g_drive_can_stop(byval drive as GDrive ptr) as gboolean
declare sub g_drive_stop(byval drive as GDrive ptr, byval flags as GMountUnmountFlags, byval mount_operation as GMountOperation ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_drive_stop_finish(byval drive as GDrive ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
declare sub g_drive_eject_with_operation(byval drive as GDrive ptr, byval flags as GMountUnmountFlags, byval mount_operation as GMountOperation ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_drive_eject_with_operation_finish(byval drive as GDrive ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
declare function g_drive_get_sort_key(byval drive as GDrive ptr) as const gchar ptr

#define __G_EMBLEMED_ICON_H__
#define __G_ICON_H__
#define G_TYPE_ICON g_icon_get_type()
#define G_ICON(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), G_TYPE_ICON, GIcon)
#define G_IS_ICON(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), G_TYPE_ICON)
#define G_ICON_GET_IFACE(obj) G_TYPE_INSTANCE_GET_INTERFACE((obj), G_TYPE_ICON, GIconIface)
type GIconIface as _GIconIface

type _GIconIface
	g_iface as GTypeInterface
	hash as function(byval icon as GIcon ptr) as guint
	equal as function(byval icon1 as GIcon ptr, byval icon2 as GIcon ptr) as gboolean
	to_tokens as function(byval icon as GIcon ptr, byval tokens as GPtrArray ptr, byval out_version as gint ptr) as gboolean
	from_tokens as function(byval tokens as gchar ptr ptr, byval num_tokens as gint, byval version as gint, byval error as GError ptr ptr) as GIcon ptr
	serialize as function(byval icon as GIcon ptr) as GVariant ptr
end type

declare function g_icon_get_type() as GType
declare function g_icon_hash(byval icon as gconstpointer) as guint
declare function g_icon_equal(byval icon1 as GIcon ptr, byval icon2 as GIcon ptr) as gboolean
declare function g_icon_to_string(byval icon as GIcon ptr) as gchar ptr
declare function g_icon_new_for_string(byval str as const gchar ptr, byval error as GError ptr ptr) as GIcon ptr
declare function g_icon_serialize(byval icon as GIcon ptr) as GVariant ptr
declare function g_icon_deserialize(byval value as GVariant ptr) as GIcon ptr

#define __G_EMBLEM_H__
#define G_TYPE_EMBLEM g_emblem_get_type()
#define G_EMBLEM(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_EMBLEM, GEmblem)
#define G_EMBLEM_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_EMBLEM, GEmblemClass)
#define G_IS_EMBLEM(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_EMBLEM)
#define G_IS_EMBLEM_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), G_TYPE_EMBLEM)
#define G_EMBLEM_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), G_TYPE_EMBLEM, GEmblemClass)
type GEmblem as _GEmblem
type GEmblemClass as _GEmblemClass

declare function g_emblem_get_type() as GType
declare function g_emblem_new(byval icon as GIcon ptr) as GEmblem ptr
declare function g_emblem_new_with_origin(byval icon as GIcon ptr, byval origin as GEmblemOrigin) as GEmblem ptr
declare function g_emblem_get_icon(byval emblem as GEmblem ptr) as GIcon ptr
declare function g_emblem_get_origin(byval emblem as GEmblem ptr) as GEmblemOrigin

#define G_TYPE_EMBLEMED_ICON g_emblemed_icon_get_type()
#define G_EMBLEMED_ICON(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_EMBLEMED_ICON, GEmblemedIcon)
#define G_EMBLEMED_ICON_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_EMBLEMED_ICON, GEmblemedIconClass)
#define G_IS_EMBLEMED_ICON(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_EMBLEMED_ICON)
#define G_IS_EMBLEMED_ICON_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), G_TYPE_EMBLEMED_ICON)
#define G_EMBLEMED_ICON_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), G_TYPE_EMBLEMED_ICON, GEmblemedIconClass)

type GEmblemedIcon as _GEmblemedIcon
type GEmblemedIconClass as _GEmblemedIconClass
type GEmblemedIconPrivate as _GEmblemedIconPrivate

type _GEmblemedIcon
	parent_instance as GObject
	priv as GEmblemedIconPrivate ptr
end type

type _GEmblemedIconClass
	parent_class as GObjectClass
end type

declare function g_emblemed_icon_get_type() as GType
declare function g_emblemed_icon_new(byval icon as GIcon ptr, byval emblem as GEmblem ptr) as GIcon ptr
declare function g_emblemed_icon_get_icon(byval emblemed as GEmblemedIcon ptr) as GIcon ptr
declare function g_emblemed_icon_get_emblems(byval emblemed as GEmblemedIcon ptr) as GList ptr
declare sub g_emblemed_icon_add_emblem(byval emblemed as GEmblemedIcon ptr, byval emblem as GEmblem ptr)
declare sub g_emblemed_icon_clear_emblems(byval emblemed as GEmblemedIcon ptr)
#define __G_FILE_ATTRIBUTE_H__

type _GFileAttributeInfo
	name as zstring ptr
	as GFileAttributeType type
	flags as GFileAttributeInfoFlags
end type

type _GFileAttributeInfoList
	infos as GFileAttributeInfo ptr
	n_infos as long
end type

#define G_TYPE_FILE_ATTRIBUTE_INFO_LIST g_file_attribute_info_list_get_type()
declare function g_file_attribute_info_list_get_type() as GType
declare function g_file_attribute_info_list_new() as GFileAttributeInfoList ptr
declare function g_file_attribute_info_list_ref(byval list as GFileAttributeInfoList ptr) as GFileAttributeInfoList ptr
declare sub g_file_attribute_info_list_unref(byval list as GFileAttributeInfoList ptr)
declare function g_file_attribute_info_list_dup(byval list as GFileAttributeInfoList ptr) as GFileAttributeInfoList ptr
declare function g_file_attribute_info_list_lookup(byval list as GFileAttributeInfoList ptr, byval name as const zstring ptr) as const GFileAttributeInfo ptr
declare sub g_file_attribute_info_list_add(byval list as GFileAttributeInfoList ptr, byval name as const zstring ptr, byval type as GFileAttributeType, byval flags as GFileAttributeInfoFlags)

#define __G_FILE_ENUMERATOR_H__
#define G_TYPE_FILE_ENUMERATOR g_file_enumerator_get_type()
#define G_FILE_ENUMERATOR(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_FILE_ENUMERATOR, GFileEnumerator)
#define G_FILE_ENUMERATOR_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_FILE_ENUMERATOR, GFileEnumeratorClass)
#define G_IS_FILE_ENUMERATOR(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_FILE_ENUMERATOR)
#define G_IS_FILE_ENUMERATOR_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), G_TYPE_FILE_ENUMERATOR)
#define G_FILE_ENUMERATOR_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), G_TYPE_FILE_ENUMERATOR, GFileEnumeratorClass)
type GFileEnumeratorClass as _GFileEnumeratorClass
type GFileEnumeratorPrivate as _GFileEnumeratorPrivate

type _GFileEnumerator
	parent_instance as GObject
	priv as GFileEnumeratorPrivate ptr
end type

type _GFileEnumeratorClass
	parent_class as GObjectClass
	next_file as function(byval enumerator as GFileEnumerator ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GFileInfo ptr
	close_fn as function(byval enumerator as GFileEnumerator ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
	next_files_async as sub(byval enumerator as GFileEnumerator ptr, byval num_files as long, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	next_files_finish as function(byval enumerator as GFileEnumerator ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as GList ptr
	close_async as sub(byval enumerator as GFileEnumerator ptr, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	close_finish as function(byval enumerator as GFileEnumerator ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
	_g_reserved1 as sub()
	_g_reserved2 as sub()
	_g_reserved3 as sub()
	_g_reserved4 as sub()
	_g_reserved5 as sub()
	_g_reserved6 as sub()
	_g_reserved7 as sub()
end type

declare function g_file_enumerator_get_type() as GType
declare function g_file_enumerator_next_file(byval enumerator as GFileEnumerator ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GFileInfo ptr
declare function g_file_enumerator_close(byval enumerator as GFileEnumerator ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
declare sub g_file_enumerator_next_files_async(byval enumerator as GFileEnumerator ptr, byval num_files as long, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_file_enumerator_next_files_finish(byval enumerator as GFileEnumerator ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as GList ptr
declare sub g_file_enumerator_close_async(byval enumerator as GFileEnumerator ptr, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_file_enumerator_close_finish(byval enumerator as GFileEnumerator ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
declare function g_file_enumerator_is_closed(byval enumerator as GFileEnumerator ptr) as gboolean
declare function g_file_enumerator_has_pending(byval enumerator as GFileEnumerator ptr) as gboolean
declare sub g_file_enumerator_set_pending(byval enumerator as GFileEnumerator ptr, byval pending as gboolean)
declare function g_file_enumerator_get_container(byval enumerator as GFileEnumerator ptr) as GFile ptr
declare function g_file_enumerator_get_child(byval enumerator as GFileEnumerator ptr, byval info as GFileInfo ptr) as GFile ptr
declare function g_file_enumerator_iterate(byval direnum as GFileEnumerator ptr, byval out_info as GFileInfo ptr ptr, byval out_child as GFile ptr ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean

#define __G_FILE_H__
#define G_TYPE_FILE g_file_get_type()
#define G_FILE(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), G_TYPE_FILE, GFile)
#define G_IS_FILE(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), G_TYPE_FILE)
#define G_FILE_GET_IFACE(obj) G_TYPE_INSTANCE_GET_INTERFACE((obj), G_TYPE_FILE, GFileIface)
type GFileIface as _GFileIface

type _GFileIface
	g_iface as GTypeInterface
	dup as function(byval file as GFile ptr) as GFile ptr
	hash as function(byval file as GFile ptr) as guint
	equal as function(byval file1 as GFile ptr, byval file2 as GFile ptr) as gboolean
	is_native as function(byval file as GFile ptr) as gboolean
	has_uri_scheme as function(byval file as GFile ptr, byval uri_scheme as const zstring ptr) as gboolean
	get_uri_scheme as function(byval file as GFile ptr) as zstring ptr
	get_basename as function(byval file as GFile ptr) as zstring ptr
	get_path as function(byval file as GFile ptr) as zstring ptr
	get_uri as function(byval file as GFile ptr) as zstring ptr
	get_parse_name as function(byval file as GFile ptr) as zstring ptr
	get_parent as function(byval file as GFile ptr) as GFile ptr
	prefix_matches as function(byval prefix as GFile ptr, byval file as GFile ptr) as gboolean
	get_relative_path as function(byval parent as GFile ptr, byval descendant as GFile ptr) as zstring ptr
	resolve_relative_path as function(byval file as GFile ptr, byval relative_path as const zstring ptr) as GFile ptr
	get_child_for_display_name as function(byval file as GFile ptr, byval display_name as const zstring ptr, byval error as GError ptr ptr) as GFile ptr
	enumerate_children as function(byval file as GFile ptr, byval attributes as const zstring ptr, byval flags as GFileQueryInfoFlags, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GFileEnumerator ptr
	enumerate_children_async as sub(byval file as GFile ptr, byval attributes as const zstring ptr, byval flags as GFileQueryInfoFlags, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	enumerate_children_finish as function(byval file as GFile ptr, byval res as GAsyncResult ptr, byval error as GError ptr ptr) as GFileEnumerator ptr
	query_info as function(byval file as GFile ptr, byval attributes as const zstring ptr, byval flags as GFileQueryInfoFlags, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GFileInfo ptr
	query_info_async as sub(byval file as GFile ptr, byval attributes as const zstring ptr, byval flags as GFileQueryInfoFlags, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	query_info_finish as function(byval file as GFile ptr, byval res as GAsyncResult ptr, byval error as GError ptr ptr) as GFileInfo ptr
	query_filesystem_info as function(byval file as GFile ptr, byval attributes as const zstring ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GFileInfo ptr
	query_filesystem_info_async as sub(byval file as GFile ptr, byval attributes as const zstring ptr, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	query_filesystem_info_finish as function(byval file as GFile ptr, byval res as GAsyncResult ptr, byval error as GError ptr ptr) as GFileInfo ptr
	find_enclosing_mount as function(byval file as GFile ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GMount ptr
	find_enclosing_mount_async as sub(byval file as GFile ptr, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	find_enclosing_mount_finish as function(byval file as GFile ptr, byval res as GAsyncResult ptr, byval error as GError ptr ptr) as GMount ptr
	set_display_name as function(byval file as GFile ptr, byval display_name as const zstring ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GFile ptr
	set_display_name_async as sub(byval file as GFile ptr, byval display_name as const zstring ptr, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	set_display_name_finish as function(byval file as GFile ptr, byval res as GAsyncResult ptr, byval error as GError ptr ptr) as GFile ptr
	query_settable_attributes as function(byval file as GFile ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GFileAttributeInfoList ptr
	_query_settable_attributes_async as sub()
	_query_settable_attributes_finish as sub()
	query_writable_namespaces as function(byval file as GFile ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GFileAttributeInfoList ptr
	_query_writable_namespaces_async as sub()
	_query_writable_namespaces_finish as sub()
	set_attribute as function(byval file as GFile ptr, byval attribute as const zstring ptr, byval type as GFileAttributeType, byval value_p as gpointer, byval flags as GFileQueryInfoFlags, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
	set_attributes_from_info as function(byval file as GFile ptr, byval info as GFileInfo ptr, byval flags as GFileQueryInfoFlags, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
	set_attributes_async as sub(byval file as GFile ptr, byval info as GFileInfo ptr, byval flags as GFileQueryInfoFlags, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	set_attributes_finish as function(byval file as GFile ptr, byval result as GAsyncResult ptr, byval info as GFileInfo ptr ptr, byval error as GError ptr ptr) as gboolean
	read_fn as function(byval file as GFile ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GFileInputStream ptr
	read_async as sub(byval file as GFile ptr, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	read_finish as function(byval file as GFile ptr, byval res as GAsyncResult ptr, byval error as GError ptr ptr) as GFileInputStream ptr
	append_to as function(byval file as GFile ptr, byval flags as GFileCreateFlags, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GFileOutputStream ptr
	append_to_async as sub(byval file as GFile ptr, byval flags as GFileCreateFlags, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	append_to_finish as function(byval file as GFile ptr, byval res as GAsyncResult ptr, byval error as GError ptr ptr) as GFileOutputStream ptr
	create as function(byval file as GFile ptr, byval flags as GFileCreateFlags, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GFileOutputStream ptr
	create_async as sub(byval file as GFile ptr, byval flags as GFileCreateFlags, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	create_finish as function(byval file as GFile ptr, byval res as GAsyncResult ptr, byval error as GError ptr ptr) as GFileOutputStream ptr
	replace as function(byval file as GFile ptr, byval etag as const zstring ptr, byval make_backup as gboolean, byval flags as GFileCreateFlags, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GFileOutputStream ptr
	replace_async as sub(byval file as GFile ptr, byval etag as const zstring ptr, byval make_backup as gboolean, byval flags as GFileCreateFlags, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	replace_finish as function(byval file as GFile ptr, byval res as GAsyncResult ptr, byval error as GError ptr ptr) as GFileOutputStream ptr
	delete_file as function(byval file as GFile ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
	delete_file_async as sub(byval file as GFile ptr, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	delete_file_finish as function(byval file as GFile ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
	trash as function(byval file as GFile ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
	trash_async as sub(byval file as GFile ptr, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	trash_finish as function(byval file as GFile ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
	make_directory as function(byval file as GFile ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
	make_directory_async as sub(byval file as GFile ptr, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	make_directory_finish as function(byval file as GFile ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
	make_symbolic_link as function(byval file as GFile ptr, byval symlink_value as const zstring ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
	_make_symbolic_link_async as sub()
	_make_symbolic_link_finish as sub()
	copy as function(byval source as GFile ptr, byval destination as GFile ptr, byval flags as GFileCopyFlags, byval cancellable as GCancellable ptr, byval progress_callback as GFileProgressCallback, byval progress_callback_data as gpointer, byval error as GError ptr ptr) as gboolean
	copy_async as sub(byval source as GFile ptr, byval destination as GFile ptr, byval flags as GFileCopyFlags, byval io_priority as long, byval cancellable as GCancellable ptr, byval progress_callback as GFileProgressCallback, byval progress_callback_data as gpointer, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	copy_finish as function(byval file as GFile ptr, byval res as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
	move as function(byval source as GFile ptr, byval destination as GFile ptr, byval flags as GFileCopyFlags, byval cancellable as GCancellable ptr, byval progress_callback as GFileProgressCallback, byval progress_callback_data as gpointer, byval error as GError ptr ptr) as gboolean
	_move_async as sub()
	_move_finish as sub()
	mount_mountable as sub(byval file as GFile ptr, byval flags as GMountMountFlags, byval mount_operation as GMountOperation ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	mount_mountable_finish as function(byval file as GFile ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as GFile ptr
	unmount_mountable as sub(byval file as GFile ptr, byval flags as GMountUnmountFlags, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	unmount_mountable_finish as function(byval file as GFile ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
	eject_mountable as sub(byval file as GFile ptr, byval flags as GMountUnmountFlags, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	eject_mountable_finish as function(byval file as GFile ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
	mount_enclosing_volume as sub(byval location as GFile ptr, byval flags as GMountMountFlags, byval mount_operation as GMountOperation ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	mount_enclosing_volume_finish as function(byval location as GFile ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
	monitor_dir as function(byval file as GFile ptr, byval flags as GFileMonitorFlags, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GFileMonitor ptr
	monitor_file as function(byval file as GFile ptr, byval flags as GFileMonitorFlags, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GFileMonitor ptr
	open_readwrite as function(byval file as GFile ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GFileIOStream ptr
	open_readwrite_async as sub(byval file as GFile ptr, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	open_readwrite_finish as function(byval file as GFile ptr, byval res as GAsyncResult ptr, byval error as GError ptr ptr) as GFileIOStream ptr
	create_readwrite as function(byval file as GFile ptr, byval flags as GFileCreateFlags, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GFileIOStream ptr
	create_readwrite_async as sub(byval file as GFile ptr, byval flags as GFileCreateFlags, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	create_readwrite_finish as function(byval file as GFile ptr, byval res as GAsyncResult ptr, byval error as GError ptr ptr) as GFileIOStream ptr
	replace_readwrite as function(byval file as GFile ptr, byval etag as const zstring ptr, byval make_backup as gboolean, byval flags as GFileCreateFlags, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GFileIOStream ptr
	replace_readwrite_async as sub(byval file as GFile ptr, byval etag as const zstring ptr, byval make_backup as gboolean, byval flags as GFileCreateFlags, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	replace_readwrite_finish as function(byval file as GFile ptr, byval res as GAsyncResult ptr, byval error as GError ptr ptr) as GFileIOStream ptr
	start_mountable as sub(byval file as GFile ptr, byval flags as GDriveStartFlags, byval start_operation as GMountOperation ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	start_mountable_finish as function(byval file as GFile ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
	stop_mountable as sub(byval file as GFile ptr, byval flags as GMountUnmountFlags, byval mount_operation as GMountOperation ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	stop_mountable_finish as function(byval file as GFile ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
	supports_thread_contexts as gboolean
	unmount_mountable_with_operation as sub(byval file as GFile ptr, byval flags as GMountUnmountFlags, byval mount_operation as GMountOperation ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	unmount_mountable_with_operation_finish as function(byval file as GFile ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
	eject_mountable_with_operation as sub(byval file as GFile ptr, byval flags as GMountUnmountFlags, byval mount_operation as GMountOperation ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	eject_mountable_with_operation_finish as function(byval file as GFile ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
	poll_mountable as sub(byval file as GFile ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	poll_mountable_finish as function(byval file as GFile ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
	measure_disk_usage as function(byval file as GFile ptr, byval flags as GFileMeasureFlags, byval cancellable as GCancellable ptr, byval progress_callback as GFileMeasureProgressCallback, byval progress_data as gpointer, byval disk_usage as guint64 ptr, byval num_dirs as guint64 ptr, byval num_files as guint64 ptr, byval error as GError ptr ptr) as gboolean
	measure_disk_usage_async as sub(byval file as GFile ptr, byval flags as GFileMeasureFlags, byval io_priority as gint, byval cancellable as GCancellable ptr, byval progress_callback as GFileMeasureProgressCallback, byval progress_data as gpointer, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	measure_disk_usage_finish as function(byval file as GFile ptr, byval result as GAsyncResult ptr, byval disk_usage as guint64 ptr, byval num_dirs as guint64 ptr, byval num_files as guint64 ptr, byval error as GError ptr ptr) as gboolean
end type

declare function g_file_get_type() as GType
declare function g_file_new_for_path(byval path as const zstring ptr) as GFile ptr
declare function g_file_new_for_uri(byval uri as const zstring ptr) as GFile ptr
declare function g_file_new_for_commandline_arg(byval arg as const zstring ptr) as GFile ptr
declare function g_file_new_for_commandline_arg_and_cwd(byval arg as const gchar ptr, byval cwd as const gchar ptr) as GFile ptr
declare function g_file_new_tmp(byval tmpl as const zstring ptr, byval iostream as GFileIOStream ptr ptr, byval error as GError ptr ptr) as GFile ptr
declare function g_file_parse_name(byval parse_name as const zstring ptr) as GFile ptr
declare function g_file_dup(byval file as GFile ptr) as GFile ptr
declare function g_file_hash(byval file as gconstpointer) as guint
declare function g_file_equal(byval file1 as GFile ptr, byval file2 as GFile ptr) as gboolean
declare function g_file_get_basename(byval file as GFile ptr) as zstring ptr
declare function g_file_get_path(byval file as GFile ptr) as zstring ptr
declare function g_file_get_uri(byval file as GFile ptr) as zstring ptr
declare function g_file_get_parse_name(byval file as GFile ptr) as zstring ptr
declare function g_file_get_parent(byval file as GFile ptr) as GFile ptr
declare function g_file_has_parent(byval file as GFile ptr, byval parent as GFile ptr) as gboolean
declare function g_file_get_child(byval file as GFile ptr, byval name as const zstring ptr) as GFile ptr
declare function g_file_get_child_for_display_name(byval file as GFile ptr, byval display_name as const zstring ptr, byval error as GError ptr ptr) as GFile ptr
declare function g_file_has_prefix(byval file as GFile ptr, byval prefix as GFile ptr) as gboolean
declare function g_file_get_relative_path(byval parent as GFile ptr, byval descendant as GFile ptr) as zstring ptr
declare function g_file_resolve_relative_path(byval file as GFile ptr, byval relative_path as const zstring ptr) as GFile ptr
declare function g_file_is_native(byval file as GFile ptr) as gboolean
declare function g_file_has_uri_scheme(byval file as GFile ptr, byval uri_scheme as const zstring ptr) as gboolean
declare function g_file_get_uri_scheme(byval file as GFile ptr) as zstring ptr
declare function g_file_read(byval file as GFile ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GFileInputStream ptr
declare sub g_file_read_async(byval file as GFile ptr, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_file_read_finish(byval file as GFile ptr, byval res as GAsyncResult ptr, byval error as GError ptr ptr) as GFileInputStream ptr
declare function g_file_append_to(byval file as GFile ptr, byval flags as GFileCreateFlags, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GFileOutputStream ptr
declare function g_file_create(byval file as GFile ptr, byval flags as GFileCreateFlags, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GFileOutputStream ptr
declare function g_file_replace(byval file as GFile ptr, byval etag as const zstring ptr, byval make_backup as gboolean, byval flags as GFileCreateFlags, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GFileOutputStream ptr
declare sub g_file_append_to_async(byval file as GFile ptr, byval flags as GFileCreateFlags, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_file_append_to_finish(byval file as GFile ptr, byval res as GAsyncResult ptr, byval error as GError ptr ptr) as GFileOutputStream ptr
declare sub g_file_create_async(byval file as GFile ptr, byval flags as GFileCreateFlags, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_file_create_finish(byval file as GFile ptr, byval res as GAsyncResult ptr, byval error as GError ptr ptr) as GFileOutputStream ptr
declare sub g_file_replace_async(byval file as GFile ptr, byval etag as const zstring ptr, byval make_backup as gboolean, byval flags as GFileCreateFlags, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_file_replace_finish(byval file as GFile ptr, byval res as GAsyncResult ptr, byval error as GError ptr ptr) as GFileOutputStream ptr
declare function g_file_open_readwrite(byval file as GFile ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GFileIOStream ptr
declare sub g_file_open_readwrite_async(byval file as GFile ptr, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_file_open_readwrite_finish(byval file as GFile ptr, byval res as GAsyncResult ptr, byval error as GError ptr ptr) as GFileIOStream ptr
declare function g_file_create_readwrite(byval file as GFile ptr, byval flags as GFileCreateFlags, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GFileIOStream ptr
declare sub g_file_create_readwrite_async(byval file as GFile ptr, byval flags as GFileCreateFlags, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_file_create_readwrite_finish(byval file as GFile ptr, byval res as GAsyncResult ptr, byval error as GError ptr ptr) as GFileIOStream ptr
declare function g_file_replace_readwrite(byval file as GFile ptr, byval etag as const zstring ptr, byval make_backup as gboolean, byval flags as GFileCreateFlags, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GFileIOStream ptr
declare sub g_file_replace_readwrite_async(byval file as GFile ptr, byval etag as const zstring ptr, byval make_backup as gboolean, byval flags as GFileCreateFlags, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_file_replace_readwrite_finish(byval file as GFile ptr, byval res as GAsyncResult ptr, byval error as GError ptr ptr) as GFileIOStream ptr
declare function g_file_query_exists(byval file as GFile ptr, byval cancellable as GCancellable ptr) as gboolean
declare function g_file_query_file_type(byval file as GFile ptr, byval flags as GFileQueryInfoFlags, byval cancellable as GCancellable ptr) as GFileType
declare function g_file_query_info(byval file as GFile ptr, byval attributes as const zstring ptr, byval flags as GFileQueryInfoFlags, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GFileInfo ptr
declare sub g_file_query_info_async(byval file as GFile ptr, byval attributes as const zstring ptr, byval flags as GFileQueryInfoFlags, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_file_query_info_finish(byval file as GFile ptr, byval res as GAsyncResult ptr, byval error as GError ptr ptr) as GFileInfo ptr
declare function g_file_query_filesystem_info(byval file as GFile ptr, byval attributes as const zstring ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GFileInfo ptr
declare sub g_file_query_filesystem_info_async(byval file as GFile ptr, byval attributes as const zstring ptr, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_file_query_filesystem_info_finish(byval file as GFile ptr, byval res as GAsyncResult ptr, byval error as GError ptr ptr) as GFileInfo ptr
declare function g_file_find_enclosing_mount(byval file as GFile ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GMount ptr
declare sub g_file_find_enclosing_mount_async(byval file as GFile ptr, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_file_find_enclosing_mount_finish(byval file as GFile ptr, byval res as GAsyncResult ptr, byval error as GError ptr ptr) as GMount ptr
declare function g_file_enumerate_children(byval file as GFile ptr, byval attributes as const zstring ptr, byval flags as GFileQueryInfoFlags, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GFileEnumerator ptr
declare sub g_file_enumerate_children_async(byval file as GFile ptr, byval attributes as const zstring ptr, byval flags as GFileQueryInfoFlags, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_file_enumerate_children_finish(byval file as GFile ptr, byval res as GAsyncResult ptr, byval error as GError ptr ptr) as GFileEnumerator ptr
declare function g_file_set_display_name(byval file as GFile ptr, byval display_name as const zstring ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GFile ptr
declare sub g_file_set_display_name_async(byval file as GFile ptr, byval display_name as const zstring ptr, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_file_set_display_name_finish(byval file as GFile ptr, byval res as GAsyncResult ptr, byval error as GError ptr ptr) as GFile ptr
declare function g_file_delete(byval file as GFile ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
declare sub g_file_delete_async(byval file as GFile ptr, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_file_delete_finish(byval file as GFile ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
declare function g_file_trash(byval file as GFile ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
declare sub g_file_trash_async(byval file as GFile ptr, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_file_trash_finish(byval file as GFile ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
declare function g_file_copy(byval source as GFile ptr, byval destination as GFile ptr, byval flags as GFileCopyFlags, byval cancellable as GCancellable ptr, byval progress_callback as GFileProgressCallback, byval progress_callback_data as gpointer, byval error as GError ptr ptr) as gboolean
declare sub g_file_copy_async(byval source as GFile ptr, byval destination as GFile ptr, byval flags as GFileCopyFlags, byval io_priority as long, byval cancellable as GCancellable ptr, byval progress_callback as GFileProgressCallback, byval progress_callback_data as gpointer, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_file_copy_finish(byval file as GFile ptr, byval res as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
declare function g_file_move(byval source as GFile ptr, byval destination as GFile ptr, byval flags as GFileCopyFlags, byval cancellable as GCancellable ptr, byval progress_callback as GFileProgressCallback, byval progress_callback_data as gpointer, byval error as GError ptr ptr) as gboolean
declare function g_file_make_directory(byval file as GFile ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
declare sub g_file_make_directory_async(byval file as GFile ptr, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_file_make_directory_finish(byval file as GFile ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
declare function g_file_make_directory_with_parents(byval file as GFile ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
declare function g_file_make_symbolic_link(byval file as GFile ptr, byval symlink_value as const zstring ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
declare function g_file_query_settable_attributes(byval file as GFile ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GFileAttributeInfoList ptr
declare function g_file_query_writable_namespaces(byval file as GFile ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GFileAttributeInfoList ptr
declare function g_file_set_attribute(byval file as GFile ptr, byval attribute as const zstring ptr, byval type as GFileAttributeType, byval value_p as gpointer, byval flags as GFileQueryInfoFlags, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
declare function g_file_set_attributes_from_info(byval file as GFile ptr, byval info as GFileInfo ptr, byval flags as GFileQueryInfoFlags, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
declare sub g_file_set_attributes_async(byval file as GFile ptr, byval info as GFileInfo ptr, byval flags as GFileQueryInfoFlags, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_file_set_attributes_finish(byval file as GFile ptr, byval result as GAsyncResult ptr, byval info as GFileInfo ptr ptr, byval error as GError ptr ptr) as gboolean
declare function g_file_set_attribute_string(byval file as GFile ptr, byval attribute as const zstring ptr, byval value as const zstring ptr, byval flags as GFileQueryInfoFlags, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
declare function g_file_set_attribute_byte_string(byval file as GFile ptr, byval attribute as const zstring ptr, byval value as const zstring ptr, byval flags as GFileQueryInfoFlags, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
declare function g_file_set_attribute_uint32(byval file as GFile ptr, byval attribute as const zstring ptr, byval value as guint32, byval flags as GFileQueryInfoFlags, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
declare function g_file_set_attribute_int32(byval file as GFile ptr, byval attribute as const zstring ptr, byval value as gint32, byval flags as GFileQueryInfoFlags, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
declare function g_file_set_attribute_uint64(byval file as GFile ptr, byval attribute as const zstring ptr, byval value as guint64, byval flags as GFileQueryInfoFlags, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
declare function g_file_set_attribute_int64(byval file as GFile ptr, byval attribute as const zstring ptr, byval value as gint64, byval flags as GFileQueryInfoFlags, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
declare sub g_file_mount_enclosing_volume(byval location as GFile ptr, byval flags as GMountMountFlags, byval mount_operation as GMountOperation ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_file_mount_enclosing_volume_finish(byval location as GFile ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
declare sub g_file_mount_mountable(byval file as GFile ptr, byval flags as GMountMountFlags, byval mount_operation as GMountOperation ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_file_mount_mountable_finish(byval file as GFile ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as GFile ptr
declare sub g_file_unmount_mountable(byval file as GFile ptr, byval flags as GMountUnmountFlags, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_file_unmount_mountable_finish(byval file as GFile ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
declare sub g_file_unmount_mountable_with_operation(byval file as GFile ptr, byval flags as GMountUnmountFlags, byval mount_operation as GMountOperation ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_file_unmount_mountable_with_operation_finish(byval file as GFile ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
declare sub g_file_eject_mountable(byval file as GFile ptr, byval flags as GMountUnmountFlags, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_file_eject_mountable_finish(byval file as GFile ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
declare sub g_file_eject_mountable_with_operation(byval file as GFile ptr, byval flags as GMountUnmountFlags, byval mount_operation as GMountOperation ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_file_eject_mountable_with_operation_finish(byval file as GFile ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
declare function g_file_copy_attributes(byval source as GFile ptr, byval destination as GFile ptr, byval flags as GFileCopyFlags, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
declare function g_file_monitor_directory(byval file as GFile ptr, byval flags as GFileMonitorFlags, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GFileMonitor ptr
declare function g_file_monitor_file(byval file as GFile ptr, byval flags as GFileMonitorFlags, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GFileMonitor ptr
declare function g_file_monitor_ alias "g_file_monitor"(byval file as GFile ptr, byval flags as GFileMonitorFlags, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GFileMonitor ptr
declare function g_file_measure_disk_usage(byval file as GFile ptr, byval flags as GFileMeasureFlags, byval cancellable as GCancellable ptr, byval progress_callback as GFileMeasureProgressCallback, byval progress_data as gpointer, byval disk_usage as guint64 ptr, byval num_dirs as guint64 ptr, byval num_files as guint64 ptr, byval error as GError ptr ptr) as gboolean
declare sub g_file_measure_disk_usage_async(byval file as GFile ptr, byval flags as GFileMeasureFlags, byval io_priority as gint, byval cancellable as GCancellable ptr, byval progress_callback as GFileMeasureProgressCallback, byval progress_data as gpointer, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_file_measure_disk_usage_finish(byval file as GFile ptr, byval result as GAsyncResult ptr, byval disk_usage as guint64 ptr, byval num_dirs as guint64 ptr, byval num_files as guint64 ptr, byval error as GError ptr ptr) as gboolean
declare sub g_file_start_mountable(byval file as GFile ptr, byval flags as GDriveStartFlags, byval start_operation as GMountOperation ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_file_start_mountable_finish(byval file as GFile ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
declare sub g_file_stop_mountable(byval file as GFile ptr, byval flags as GMountUnmountFlags, byval mount_operation as GMountOperation ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_file_stop_mountable_finish(byval file as GFile ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
declare sub g_file_poll_mountable(byval file as GFile ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_file_poll_mountable_finish(byval file as GFile ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
declare function g_file_query_default_handler(byval file as GFile ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GAppInfo ptr
declare function g_file_load_contents(byval file as GFile ptr, byval cancellable as GCancellable ptr, byval contents as zstring ptr ptr, byval length as gsize ptr, byval etag_out as zstring ptr ptr, byval error as GError ptr ptr) as gboolean
declare sub g_file_load_contents_async(byval file as GFile ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_file_load_contents_finish(byval file as GFile ptr, byval res as GAsyncResult ptr, byval contents as zstring ptr ptr, byval length as gsize ptr, byval etag_out as zstring ptr ptr, byval error as GError ptr ptr) as gboolean
declare sub g_file_load_partial_contents_async(byval file as GFile ptr, byval cancellable as GCancellable ptr, byval read_more_callback as GFileReadMoreCallback, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_file_load_partial_contents_finish(byval file as GFile ptr, byval res as GAsyncResult ptr, byval contents as zstring ptr ptr, byval length as gsize ptr, byval etag_out as zstring ptr ptr, byval error as GError ptr ptr) as gboolean
declare function g_file_replace_contents(byval file as GFile ptr, byval contents as const zstring ptr, byval length as gsize, byval etag as const zstring ptr, byval make_backup as gboolean, byval flags as GFileCreateFlags, byval new_etag as zstring ptr ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
declare sub g_file_replace_contents_async(byval file as GFile ptr, byval contents as const zstring ptr, byval length as gsize, byval etag as const zstring ptr, byval make_backup as gboolean, byval flags as GFileCreateFlags, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare sub g_file_replace_contents_bytes_async(byval file as GFile ptr, byval contents as GBytes ptr, byval etag as const zstring ptr, byval make_backup as gboolean, byval flags as GFileCreateFlags, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_file_replace_contents_finish(byval file as GFile ptr, byval res as GAsyncResult ptr, byval new_etag as zstring ptr ptr, byval error as GError ptr ptr) as gboolean
declare function g_file_supports_thread_contexts(byval file as GFile ptr) as gboolean

#define __G_FILE_ICON_H__
#define G_TYPE_FILE_ICON g_file_icon_get_type()
#define G_FILE_ICON(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_FILE_ICON, GFileIcon)
#define G_FILE_ICON_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_FILE_ICON, GFileIconClass)
#define G_IS_FILE_ICON(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_FILE_ICON)
#define G_IS_FILE_ICON_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), G_TYPE_FILE_ICON)
#define G_FILE_ICON_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), G_TYPE_FILE_ICON, GFileIconClass)
type GFileIconClass as _GFileIconClass

declare function g_file_icon_get_type() as GType
declare function g_file_icon_new(byval file as GFile ptr) as GIcon ptr
declare function g_file_icon_get_file(byval icon as GFileIcon ptr) as GFile ptr

#define __G_FILE_INFO_H__
#define G_TYPE_FILE_INFO g_file_info_get_type()
#define G_FILE_INFO(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_FILE_INFO, GFileInfo)
#define G_FILE_INFO_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_FILE_INFO, GFileInfoClass)
#define G_IS_FILE_INFO(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_FILE_INFO)
#define G_IS_FILE_INFO_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), G_TYPE_FILE_INFO)
#define G_FILE_INFO_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), G_TYPE_FILE_INFO, GFileInfoClass)
type GFileInfoClass as _GFileInfoClass
#define G_FILE_ATTRIBUTE_STANDARD_TYPE "standard::type"
#define G_FILE_ATTRIBUTE_STANDARD_IS_HIDDEN "standard::is-hidden"
#define G_FILE_ATTRIBUTE_STANDARD_IS_BACKUP "standard::is-backup"
#define G_FILE_ATTRIBUTE_STANDARD_IS_SYMLINK "standard::is-symlink"
#define G_FILE_ATTRIBUTE_STANDARD_IS_VIRTUAL "standard::is-virtual"
#define G_FILE_ATTRIBUTE_STANDARD_NAME "standard::name"
#define G_FILE_ATTRIBUTE_STANDARD_DISPLAY_NAME "standard::display-name"
#define G_FILE_ATTRIBUTE_STANDARD_EDIT_NAME "standard::edit-name"
#define G_FILE_ATTRIBUTE_STANDARD_COPY_NAME "standard::copy-name"
#define G_FILE_ATTRIBUTE_STANDARD_DESCRIPTION "standard::description"
#define G_FILE_ATTRIBUTE_STANDARD_ICON "standard::icon"
#define G_FILE_ATTRIBUTE_STANDARD_SYMBOLIC_ICON "standard::symbolic-icon"
#define G_FILE_ATTRIBUTE_STANDARD_CONTENT_TYPE "standard::content-type"
#define G_FILE_ATTRIBUTE_STANDARD_FAST_CONTENT_TYPE "standard::fast-content-type"
#define G_FILE_ATTRIBUTE_STANDARD_SIZE "standard::size"
#define G_FILE_ATTRIBUTE_STANDARD_ALLOCATED_SIZE "standard::allocated-size"
#define G_FILE_ATTRIBUTE_STANDARD_SYMLINK_TARGET "standard::symlink-target"
#define G_FILE_ATTRIBUTE_STANDARD_TARGET_URI "standard::target-uri"
#define G_FILE_ATTRIBUTE_STANDARD_SORT_ORDER "standard::sort-order"
#define G_FILE_ATTRIBUTE_ETAG_VALUE "etag::value"
#define G_FILE_ATTRIBUTE_ID_FILE "id::file"
#define G_FILE_ATTRIBUTE_ID_FILESYSTEM "id::filesystem"
#define G_FILE_ATTRIBUTE_ACCESS_CAN_READ "access::can-read"
#define G_FILE_ATTRIBUTE_ACCESS_CAN_WRITE "access::can-write"
#define G_FILE_ATTRIBUTE_ACCESS_CAN_EXECUTE "access::can-execute"
#define G_FILE_ATTRIBUTE_ACCESS_CAN_DELETE "access::can-delete"
#define G_FILE_ATTRIBUTE_ACCESS_CAN_TRASH "access::can-trash"
#define G_FILE_ATTRIBUTE_ACCESS_CAN_RENAME "access::can-rename"
#define G_FILE_ATTRIBUTE_MOUNTABLE_CAN_MOUNT "mountable::can-mount"
#define G_FILE_ATTRIBUTE_MOUNTABLE_CAN_UNMOUNT "mountable::can-unmount"
#define G_FILE_ATTRIBUTE_MOUNTABLE_CAN_EJECT "mountable::can-eject"
#define G_FILE_ATTRIBUTE_MOUNTABLE_UNIX_DEVICE "mountable::unix-device"
#define G_FILE_ATTRIBUTE_MOUNTABLE_UNIX_DEVICE_FILE "mountable::unix-device-file"
#define G_FILE_ATTRIBUTE_MOUNTABLE_HAL_UDI "mountable::hal-udi"
#define G_FILE_ATTRIBUTE_MOUNTABLE_CAN_START "mountable::can-start"
#define G_FILE_ATTRIBUTE_MOUNTABLE_CAN_START_DEGRADED "mountable::can-start-degraded"
#define G_FILE_ATTRIBUTE_MOUNTABLE_CAN_STOP "mountable::can-stop"
#define G_FILE_ATTRIBUTE_MOUNTABLE_START_STOP_TYPE "mountable::start-stop-type"
#define G_FILE_ATTRIBUTE_MOUNTABLE_CAN_POLL "mountable::can-poll"
#define G_FILE_ATTRIBUTE_MOUNTABLE_IS_MEDIA_CHECK_AUTOMATIC "mountable::is-media-check-automatic"
#define G_FILE_ATTRIBUTE_TIME_MODIFIED "time::modified"
#define G_FILE_ATTRIBUTE_TIME_MODIFIED_USEC "time::modified-usec"
#define G_FILE_ATTRIBUTE_TIME_ACCESS "time::access"
#define G_FILE_ATTRIBUTE_TIME_ACCESS_USEC "time::access-usec"
#define G_FILE_ATTRIBUTE_TIME_CHANGED "time::changed"
#define G_FILE_ATTRIBUTE_TIME_CHANGED_USEC "time::changed-usec"
#define G_FILE_ATTRIBUTE_TIME_CREATED "time::created"
#define G_FILE_ATTRIBUTE_TIME_CREATED_USEC "time::created-usec"
#define G_FILE_ATTRIBUTE_UNIX_DEVICE "unix::device"
#define G_FILE_ATTRIBUTE_UNIX_INODE "unix::inode"
#define G_FILE_ATTRIBUTE_UNIX_MODE "unix::mode"
#define G_FILE_ATTRIBUTE_UNIX_NLINK "unix::nlink"
#define G_FILE_ATTRIBUTE_UNIX_UID "unix::uid"
#define G_FILE_ATTRIBUTE_UNIX_GID "unix::gid"
#define G_FILE_ATTRIBUTE_UNIX_RDEV "unix::rdev"
#define G_FILE_ATTRIBUTE_UNIX_BLOCK_SIZE "unix::block-size"
#define G_FILE_ATTRIBUTE_UNIX_BLOCKS "unix::blocks"
#define G_FILE_ATTRIBUTE_UNIX_IS_MOUNTPOINT "unix::is-mountpoint"
#define G_FILE_ATTRIBUTE_DOS_IS_ARCHIVE "dos::is-archive"
#define G_FILE_ATTRIBUTE_DOS_IS_SYSTEM "dos::is-system"
#define G_FILE_ATTRIBUTE_OWNER_USER "owner::user"
#define G_FILE_ATTRIBUTE_OWNER_USER_REAL "owner::user-real"
#define G_FILE_ATTRIBUTE_OWNER_GROUP "owner::group"
#define G_FILE_ATTRIBUTE_THUMBNAIL_PATH "thumbnail::path"
#define G_FILE_ATTRIBUTE_THUMBNAILING_FAILED "thumbnail::failed"
#define G_FILE_ATTRIBUTE_THUMBNAIL_IS_VALID "thumbnail::is-valid"
#define G_FILE_ATTRIBUTE_PREVIEW_ICON "preview::icon"
#define G_FILE_ATTRIBUTE_FILESYSTEM_SIZE "filesystem::size"
#define G_FILE_ATTRIBUTE_FILESYSTEM_FREE "filesystem::free"
#define G_FILE_ATTRIBUTE_FILESYSTEM_USED "filesystem::used"
#define G_FILE_ATTRIBUTE_FILESYSTEM_TYPE "filesystem::type"
#define G_FILE_ATTRIBUTE_FILESYSTEM_READONLY "filesystem::readonly"
#define G_FILE_ATTRIBUTE_FILESYSTEM_USE_PREVIEW "filesystem::use-preview"
#define G_FILE_ATTRIBUTE_GVFS_BACKEND "gvfs::backend"
#define G_FILE_ATTRIBUTE_SELINUX_CONTEXT "selinux::context"
#define G_FILE_ATTRIBUTE_TRASH_ITEM_COUNT "trash::item-count"
#define G_FILE_ATTRIBUTE_TRASH_ORIG_PATH "trash::orig-path"
#define G_FILE_ATTRIBUTE_TRASH_DELETION_DATE "trash::deletion-date"

declare function g_file_info_get_type() as GType
declare function g_file_info_new() as GFileInfo ptr
declare function g_file_info_dup(byval other as GFileInfo ptr) as GFileInfo ptr
declare sub g_file_info_copy_into(byval src_info as GFileInfo ptr, byval dest_info as GFileInfo ptr)
declare function g_file_info_has_attribute(byval info as GFileInfo ptr, byval attribute as const zstring ptr) as gboolean
declare function g_file_info_has_namespace(byval info as GFileInfo ptr, byval name_space as const zstring ptr) as gboolean
declare function g_file_info_list_attributes(byval info as GFileInfo ptr, byval name_space as const zstring ptr) as zstring ptr ptr
declare function g_file_info_get_attribute_data(byval info as GFileInfo ptr, byval attribute as const zstring ptr, byval type as GFileAttributeType ptr, byval value_pp as gpointer ptr, byval status as GFileAttributeStatus ptr) as gboolean
declare function g_file_info_get_attribute_type(byval info as GFileInfo ptr, byval attribute as const zstring ptr) as GFileAttributeType
declare sub g_file_info_remove_attribute(byval info as GFileInfo ptr, byval attribute as const zstring ptr)
declare function g_file_info_get_attribute_status(byval info as GFileInfo ptr, byval attribute as const zstring ptr) as GFileAttributeStatus
declare function g_file_info_set_attribute_status(byval info as GFileInfo ptr, byval attribute as const zstring ptr, byval status as GFileAttributeStatus) as gboolean
declare function g_file_info_get_attribute_as_string(byval info as GFileInfo ptr, byval attribute as const zstring ptr) as zstring ptr
declare function g_file_info_get_attribute_string(byval info as GFileInfo ptr, byval attribute as const zstring ptr) as const zstring ptr
declare function g_file_info_get_attribute_byte_string(byval info as GFileInfo ptr, byval attribute as const zstring ptr) as const zstring ptr
declare function g_file_info_get_attribute_boolean(byval info as GFileInfo ptr, byval attribute as const zstring ptr) as gboolean
declare function g_file_info_get_attribute_uint32(byval info as GFileInfo ptr, byval attribute as const zstring ptr) as guint32
declare function g_file_info_get_attribute_int32(byval info as GFileInfo ptr, byval attribute as const zstring ptr) as gint32
declare function g_file_info_get_attribute_uint64(byval info as GFileInfo ptr, byval attribute as const zstring ptr) as guint64
declare function g_file_info_get_attribute_int64(byval info as GFileInfo ptr, byval attribute as const zstring ptr) as gint64
declare function g_file_info_get_attribute_object(byval info as GFileInfo ptr, byval attribute as const zstring ptr) as GObject ptr
declare function g_file_info_get_attribute_stringv(byval info as GFileInfo ptr, byval attribute as const zstring ptr) as zstring ptr ptr
declare sub g_file_info_set_attribute(byval info as GFileInfo ptr, byval attribute as const zstring ptr, byval type as GFileAttributeType, byval value_p as gpointer)
declare sub g_file_info_set_attribute_string(byval info as GFileInfo ptr, byval attribute as const zstring ptr, byval attr_value as const zstring ptr)
declare sub g_file_info_set_attribute_byte_string(byval info as GFileInfo ptr, byval attribute as const zstring ptr, byval attr_value as const zstring ptr)
declare sub g_file_info_set_attribute_boolean(byval info as GFileInfo ptr, byval attribute as const zstring ptr, byval attr_value as gboolean)
declare sub g_file_info_set_attribute_uint32(byval info as GFileInfo ptr, byval attribute as const zstring ptr, byval attr_value as guint32)
declare sub g_file_info_set_attribute_int32(byval info as GFileInfo ptr, byval attribute as const zstring ptr, byval attr_value as gint32)
declare sub g_file_info_set_attribute_uint64(byval info as GFileInfo ptr, byval attribute as const zstring ptr, byval attr_value as guint64)
declare sub g_file_info_set_attribute_int64(byval info as GFileInfo ptr, byval attribute as const zstring ptr, byval attr_value as gint64)
declare sub g_file_info_set_attribute_object(byval info as GFileInfo ptr, byval attribute as const zstring ptr, byval attr_value as GObject ptr)
declare sub g_file_info_set_attribute_stringv(byval info as GFileInfo ptr, byval attribute as const zstring ptr, byval attr_value as zstring ptr ptr)
declare sub g_file_info_clear_status(byval info as GFileInfo ptr)
declare function g_file_info_get_deletion_date(byval info as GFileInfo ptr) as GDateTime ptr
declare function g_file_info_get_file_type(byval info as GFileInfo ptr) as GFileType
declare function g_file_info_get_is_hidden(byval info as GFileInfo ptr) as gboolean
declare function g_file_info_get_is_backup(byval info as GFileInfo ptr) as gboolean
declare function g_file_info_get_is_symlink(byval info as GFileInfo ptr) as gboolean
declare function g_file_info_get_name(byval info as GFileInfo ptr) as const zstring ptr
declare function g_file_info_get_display_name(byval info as GFileInfo ptr) as const zstring ptr
declare function g_file_info_get_edit_name(byval info as GFileInfo ptr) as const zstring ptr
declare function g_file_info_get_icon(byval info as GFileInfo ptr) as GIcon ptr
declare function g_file_info_get_symbolic_icon(byval info as GFileInfo ptr) as GIcon ptr
declare function g_file_info_get_content_type(byval info as GFileInfo ptr) as const zstring ptr
declare function g_file_info_get_size(byval info as GFileInfo ptr) as goffset
declare sub g_file_info_get_modification_time(byval info as GFileInfo ptr, byval result as GTimeVal ptr)
declare function g_file_info_get_symlink_target(byval info as GFileInfo ptr) as const zstring ptr
declare function g_file_info_get_etag(byval info as GFileInfo ptr) as const zstring ptr
declare function g_file_info_get_sort_order(byval info as GFileInfo ptr) as gint32
declare sub g_file_info_set_attribute_mask(byval info as GFileInfo ptr, byval mask as GFileAttributeMatcher ptr)
declare sub g_file_info_unset_attribute_mask(byval info as GFileInfo ptr)
declare sub g_file_info_set_file_type(byval info as GFileInfo ptr, byval type as GFileType)
declare sub g_file_info_set_is_hidden(byval info as GFileInfo ptr, byval is_hidden as gboolean)
declare sub g_file_info_set_is_symlink(byval info as GFileInfo ptr, byval is_symlink as gboolean)
declare sub g_file_info_set_name(byval info as GFileInfo ptr, byval name as const zstring ptr)
declare sub g_file_info_set_display_name(byval info as GFileInfo ptr, byval display_name as const zstring ptr)
declare sub g_file_info_set_edit_name(byval info as GFileInfo ptr, byval edit_name as const zstring ptr)
declare sub g_file_info_set_icon(byval info as GFileInfo ptr, byval icon as GIcon ptr)
declare sub g_file_info_set_symbolic_icon(byval info as GFileInfo ptr, byval icon as GIcon ptr)
declare sub g_file_info_set_content_type(byval info as GFileInfo ptr, byval content_type as const zstring ptr)
declare sub g_file_info_set_size(byval info as GFileInfo ptr, byval size as goffset)
declare sub g_file_info_set_modification_time(byval info as GFileInfo ptr, byval mtime as GTimeVal ptr)
declare sub g_file_info_set_symlink_target(byval info as GFileInfo ptr, byval symlink_target as const zstring ptr)
declare sub g_file_info_set_sort_order(byval info as GFileInfo ptr, byval sort_order as gint32)
#define G_TYPE_FILE_ATTRIBUTE_MATCHER g_file_attribute_matcher_get_type()
declare function g_file_attribute_matcher_get_type() as GType
declare function g_file_attribute_matcher_new(byval attributes as const zstring ptr) as GFileAttributeMatcher ptr
declare function g_file_attribute_matcher_ref(byval matcher as GFileAttributeMatcher ptr) as GFileAttributeMatcher ptr
declare sub g_file_attribute_matcher_unref(byval matcher as GFileAttributeMatcher ptr)
declare function g_file_attribute_matcher_subtract(byval matcher as GFileAttributeMatcher ptr, byval subtract as GFileAttributeMatcher ptr) as GFileAttributeMatcher ptr
declare function g_file_attribute_matcher_matches(byval matcher as GFileAttributeMatcher ptr, byval attribute as const zstring ptr) as gboolean
declare function g_file_attribute_matcher_matches_only(byval matcher as GFileAttributeMatcher ptr, byval attribute as const zstring ptr) as gboolean
declare function g_file_attribute_matcher_enumerate_namespace(byval matcher as GFileAttributeMatcher ptr, byval ns as const zstring ptr) as gboolean
declare function g_file_attribute_matcher_enumerate_next(byval matcher as GFileAttributeMatcher ptr) as const zstring ptr
declare function g_file_attribute_matcher_to_string(byval matcher as GFileAttributeMatcher ptr) as zstring ptr

#define __G_FILE_INPUT_STREAM_H__
#define G_TYPE_FILE_INPUT_STREAM g_file_input_stream_get_type()
#define G_FILE_INPUT_STREAM(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_FILE_INPUT_STREAM, GFileInputStream)
#define G_FILE_INPUT_STREAM_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_FILE_INPUT_STREAM, GFileInputStreamClass)
#define G_IS_FILE_INPUT_STREAM(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_FILE_INPUT_STREAM)
#define G_IS_FILE_INPUT_STREAM_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), G_TYPE_FILE_INPUT_STREAM)
#define G_FILE_INPUT_STREAM_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), G_TYPE_FILE_INPUT_STREAM, GFileInputStreamClass)
type GFileInputStreamClass as _GFileInputStreamClass
type GFileInputStreamPrivate as _GFileInputStreamPrivate

type _GFileInputStream
	parent_instance as GInputStream
	priv as GFileInputStreamPrivate ptr
end type

type _GFileInputStreamClass
	parent_class as GInputStreamClass
	tell as function(byval stream as GFileInputStream ptr) as goffset
	can_seek as function(byval stream as GFileInputStream ptr) as gboolean
	seek as function(byval stream as GFileInputStream ptr, byval offset as goffset, byval type as GSeekType, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
	query_info as function(byval stream as GFileInputStream ptr, byval attributes as const zstring ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GFileInfo ptr
	query_info_async as sub(byval stream as GFileInputStream ptr, byval attributes as const zstring ptr, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	query_info_finish as function(byval stream as GFileInputStream ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as GFileInfo ptr
	_g_reserved1 as sub()
	_g_reserved2 as sub()
	_g_reserved3 as sub()
	_g_reserved4 as sub()
	_g_reserved5 as sub()
end type

declare function g_file_input_stream_get_type() as GType
declare function g_file_input_stream_query_info(byval stream as GFileInputStream ptr, byval attributes as const zstring ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GFileInfo ptr
declare sub g_file_input_stream_query_info_async(byval stream as GFileInputStream ptr, byval attributes as const zstring ptr, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_file_input_stream_query_info_finish(byval stream as GFileInputStream ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as GFileInfo ptr

#define __G_FILE_IO_STREAM_H__
#define __G_IO_STREAM_H__
#define __G_IO_ERROR_H__
#define G_IO_ERROR g_io_error_quark()
declare function g_io_error_quark() as GQuark
declare function g_io_error_from_errno(byval err_no as gint) as GIOErrorEnum

#ifdef __FB_WIN32__
	declare function g_io_error_from_win32_error(byval error_code as gint) as GIOErrorEnum
#endif

#define G_TYPE_IO_STREAM g_io_stream_get_type()
#define G_IO_STREAM(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_IO_STREAM, GIOStream)
#define G_IO_STREAM_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_IO_STREAM, GIOStreamClass)
#define G_IS_IO_STREAM(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_IO_STREAM)
#define G_IS_IO_STREAM_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), G_TYPE_IO_STREAM)
#define G_IO_STREAM_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), G_TYPE_IO_STREAM, GIOStreamClass)
type GIOStreamPrivate as _GIOStreamPrivate
type GIOStreamClass as _GIOStreamClass

type _GIOStream
	parent_instance as GObject
	priv as GIOStreamPrivate ptr
end type

type _GIOStreamClass
	parent_class as GObjectClass
	get_input_stream as function(byval stream as GIOStream ptr) as GInputStream ptr
	get_output_stream as function(byval stream as GIOStream ptr) as GOutputStream ptr
	close_fn as function(byval stream as GIOStream ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
	close_async as sub(byval stream as GIOStream ptr, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	close_finish as function(byval stream as GIOStream ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
	_g_reserved1 as sub()
	_g_reserved2 as sub()
	_g_reserved3 as sub()
	_g_reserved4 as sub()
	_g_reserved5 as sub()
	_g_reserved6 as sub()
	_g_reserved7 as sub()
	_g_reserved8 as sub()
	_g_reserved9 as sub()
	_g_reserved10 as sub()
end type

declare function g_io_stream_get_type() as GType
declare function g_io_stream_get_input_stream(byval stream as GIOStream ptr) as GInputStream ptr
declare function g_io_stream_get_output_stream(byval stream as GIOStream ptr) as GOutputStream ptr
declare sub g_io_stream_splice_async(byval stream1 as GIOStream ptr, byval stream2 as GIOStream ptr, byval flags as GIOStreamSpliceFlags, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_io_stream_splice_finish(byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
declare function g_io_stream_close(byval stream as GIOStream ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
declare sub g_io_stream_close_async(byval stream as GIOStream ptr, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_io_stream_close_finish(byval stream as GIOStream ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
declare function g_io_stream_is_closed(byval stream as GIOStream ptr) as gboolean
declare function g_io_stream_has_pending(byval stream as GIOStream ptr) as gboolean
declare function g_io_stream_set_pending(byval stream as GIOStream ptr, byval error as GError ptr ptr) as gboolean
declare sub g_io_stream_clear_pending(byval stream as GIOStream ptr)

#define G_TYPE_FILE_IO_STREAM g_file_io_stream_get_type()
#define G_FILE_IO_STREAM(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_FILE_IO_STREAM, GFileIOStream)
#define G_FILE_IO_STREAM_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_FILE_IO_STREAM, GFileIOStreamClass)
#define G_IS_FILE_IO_STREAM(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_FILE_IO_STREAM)
#define G_IS_FILE_IO_STREAM_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), G_TYPE_FILE_IO_STREAM)
#define G_FILE_IO_STREAM_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), G_TYPE_FILE_IO_STREAM, GFileIOStreamClass)
type GFileIOStreamClass as _GFileIOStreamClass
type GFileIOStreamPrivate as _GFileIOStreamPrivate

type _GFileIOStream
	parent_instance as GIOStream
	priv as GFileIOStreamPrivate ptr
end type

type _GFileIOStreamClass
	parent_class as GIOStreamClass
	tell as function(byval stream as GFileIOStream ptr) as goffset
	can_seek as function(byval stream as GFileIOStream ptr) as gboolean
	seek as function(byval stream as GFileIOStream ptr, byval offset as goffset, byval type as GSeekType, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
	can_truncate as function(byval stream as GFileIOStream ptr) as gboolean
	truncate_fn as function(byval stream as GFileIOStream ptr, byval size as goffset, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
	query_info as function(byval stream as GFileIOStream ptr, byval attributes as const zstring ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GFileInfo ptr
	query_info_async as sub(byval stream as GFileIOStream ptr, byval attributes as const zstring ptr, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	query_info_finish as function(byval stream as GFileIOStream ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as GFileInfo ptr
	get_etag as function(byval stream as GFileIOStream ptr) as zstring ptr
	_g_reserved1 as sub()
	_g_reserved2 as sub()
	_g_reserved3 as sub()
	_g_reserved4 as sub()
	_g_reserved5 as sub()
end type

declare function g_file_io_stream_get_type() as GType
declare function g_file_io_stream_query_info(byval stream as GFileIOStream ptr, byval attributes as const zstring ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GFileInfo ptr
declare sub g_file_io_stream_query_info_async(byval stream as GFileIOStream ptr, byval attributes as const zstring ptr, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_file_io_stream_query_info_finish(byval stream as GFileIOStream ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as GFileInfo ptr
declare function g_file_io_stream_get_etag(byval stream as GFileIOStream ptr) as zstring ptr

#define __G_FILE_MONITOR_H__
#define G_TYPE_FILE_MONITOR g_file_monitor_get_type()
#define G_FILE_MONITOR(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_FILE_MONITOR, GFileMonitor)
#define G_FILE_MONITOR_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_FILE_MONITOR, GFileMonitorClass)
#define G_IS_FILE_MONITOR(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_FILE_MONITOR)
#define G_IS_FILE_MONITOR_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), G_TYPE_FILE_MONITOR)
#define G_FILE_MONITOR_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), G_TYPE_FILE_MONITOR, GFileMonitorClass)
type GFileMonitorClass as _GFileMonitorClass
type GFileMonitorPrivate as _GFileMonitorPrivate

type _GFileMonitor
	parent_instance as GObject
	priv as GFileMonitorPrivate ptr
end type

type _GFileMonitorClass
	parent_class as GObjectClass
	changed as sub(byval monitor as GFileMonitor ptr, byval file as GFile ptr, byval other_file as GFile ptr, byval event_type as GFileMonitorEvent)
	cancel as function(byval monitor as GFileMonitor ptr) as gboolean
	_g_reserved1 as sub()
	_g_reserved2 as sub()
	_g_reserved3 as sub()
	_g_reserved4 as sub()
	_g_reserved5 as sub()
end type

declare function g_file_monitor_get_type() as GType
declare function g_file_monitor_cancel(byval monitor as GFileMonitor ptr) as gboolean
declare function g_file_monitor_is_cancelled(byval monitor as GFileMonitor ptr) as gboolean
declare sub g_file_monitor_set_rate_limit(byval monitor as GFileMonitor ptr, byval limit_msecs as gint)
declare sub g_file_monitor_emit_event(byval monitor as GFileMonitor ptr, byval child as GFile ptr, byval other_file as GFile ptr, byval event_type as GFileMonitorEvent)

#define __G_FILENAME_COMPLETER_H__
#define G_TYPE_FILENAME_COMPLETER g_filename_completer_get_type()
#define G_FILENAME_COMPLETER(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_FILENAME_COMPLETER, GFilenameCompleter)
#define G_FILENAME_COMPLETER_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_FILENAME_COMPLETER, GFilenameCompleterClass)
#define G_FILENAME_COMPLETER_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), G_TYPE_FILENAME_COMPLETER, GFilenameCompleterClass)
#define G_IS_FILENAME_COMPLETER(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_FILENAME_COMPLETER)
#define G_IS_FILENAME_COMPLETER_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), G_TYPE_FILENAME_COMPLETER)
type GFilenameCompleterClass as _GFilenameCompleterClass

type _GFilenameCompleterClass
	parent_class as GObjectClass
	got_completion_data as sub(byval filename_completer as GFilenameCompleter ptr)
	_g_reserved1 as sub()
	_g_reserved2 as sub()
	_g_reserved3 as sub()
end type

declare function g_filename_completer_get_type() as GType
declare function g_filename_completer_new() as GFilenameCompleter ptr
declare function g_filename_completer_get_completion_suffix(byval completer as GFilenameCompleter ptr, byval initial_text as const zstring ptr) as zstring ptr
declare function g_filename_completer_get_completions(byval completer as GFilenameCompleter ptr, byval initial_text as const zstring ptr) as zstring ptr ptr
declare sub g_filename_completer_set_dirs_only(byval completer as GFilenameCompleter ptr, byval dirs_only as gboolean)

#define __G_FILE_OUTPUT_STREAM_H__
#define G_TYPE_FILE_OUTPUT_STREAM g_file_output_stream_get_type()
#define G_FILE_OUTPUT_STREAM(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_FILE_OUTPUT_STREAM, GFileOutputStream)
#define G_FILE_OUTPUT_STREAM_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_FILE_OUTPUT_STREAM, GFileOutputStreamClass)
#define G_IS_FILE_OUTPUT_STREAM(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_FILE_OUTPUT_STREAM)
#define G_IS_FILE_OUTPUT_STREAM_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), G_TYPE_FILE_OUTPUT_STREAM)
#define G_FILE_OUTPUT_STREAM_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), G_TYPE_FILE_OUTPUT_STREAM, GFileOutputStreamClass)
type GFileOutputStreamClass as _GFileOutputStreamClass
type GFileOutputStreamPrivate as _GFileOutputStreamPrivate

type _GFileOutputStream
	parent_instance as GOutputStream
	priv as GFileOutputStreamPrivate ptr
end type

type _GFileOutputStreamClass
	parent_class as GOutputStreamClass
	tell as function(byval stream as GFileOutputStream ptr) as goffset
	can_seek as function(byval stream as GFileOutputStream ptr) as gboolean
	seek as function(byval stream as GFileOutputStream ptr, byval offset as goffset, byval type as GSeekType, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
	can_truncate as function(byval stream as GFileOutputStream ptr) as gboolean
	truncate_fn as function(byval stream as GFileOutputStream ptr, byval size as goffset, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
	query_info as function(byval stream as GFileOutputStream ptr, byval attributes as const zstring ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GFileInfo ptr
	query_info_async as sub(byval stream as GFileOutputStream ptr, byval attributes as const zstring ptr, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	query_info_finish as function(byval stream as GFileOutputStream ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as GFileInfo ptr
	get_etag as function(byval stream as GFileOutputStream ptr) as zstring ptr
	_g_reserved1 as sub()
	_g_reserved2 as sub()
	_g_reserved3 as sub()
	_g_reserved4 as sub()
	_g_reserved5 as sub()
end type

declare function g_file_output_stream_get_type() as GType
declare function g_file_output_stream_query_info(byval stream as GFileOutputStream ptr, byval attributes as const zstring ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GFileInfo ptr
declare sub g_file_output_stream_query_info_async(byval stream as GFileOutputStream ptr, byval attributes as const zstring ptr, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_file_output_stream_query_info_finish(byval stream as GFileOutputStream ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as GFileInfo ptr
declare function g_file_output_stream_get_etag(byval stream as GFileOutputStream ptr) as zstring ptr

#define __G_INET_ADDRESS_H__
#define G_TYPE_INET_ADDRESS g_inet_address_get_type()
#define G_INET_ADDRESS(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_INET_ADDRESS, GInetAddress)
#define G_INET_ADDRESS_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_INET_ADDRESS, GInetAddressClass)
#define G_IS_INET_ADDRESS(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_INET_ADDRESS)
#define G_IS_INET_ADDRESS_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), G_TYPE_INET_ADDRESS)
#define G_INET_ADDRESS_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), G_TYPE_INET_ADDRESS, GInetAddressClass)
type GInetAddressClass as _GInetAddressClass
type GInetAddressPrivate as _GInetAddressPrivate

type _GInetAddress
	parent_instance as GObject
	priv as GInetAddressPrivate ptr
end type

type _GInetAddressClass
	parent_class as GObjectClass
	to_string as function(byval address as GInetAddress ptr) as gchar ptr
	to_bytes as function(byval address as GInetAddress ptr) as const guint8 ptr
end type

declare function g_inet_address_get_type() as GType
declare function g_inet_address_new_from_string(byval string as const gchar ptr) as GInetAddress ptr
declare function g_inet_address_new_from_bytes(byval bytes as const guint8 ptr, byval family as GSocketFamily) as GInetAddress ptr
declare function g_inet_address_new_loopback(byval family as GSocketFamily) as GInetAddress ptr
declare function g_inet_address_new_any(byval family as GSocketFamily) as GInetAddress ptr
declare function g_inet_address_equal(byval address as GInetAddress ptr, byval other_address as GInetAddress ptr) as gboolean
declare function g_inet_address_to_string(byval address as GInetAddress ptr) as gchar ptr
declare function g_inet_address_to_bytes(byval address as GInetAddress ptr) as const guint8 ptr
declare function g_inet_address_get_native_size(byval address as GInetAddress ptr) as gsize
declare function g_inet_address_get_family(byval address as GInetAddress ptr) as GSocketFamily
declare function g_inet_address_get_is_any(byval address as GInetAddress ptr) as gboolean
declare function g_inet_address_get_is_loopback(byval address as GInetAddress ptr) as gboolean
declare function g_inet_address_get_is_link_local(byval address as GInetAddress ptr) as gboolean
declare function g_inet_address_get_is_site_local(byval address as GInetAddress ptr) as gboolean
declare function g_inet_address_get_is_multicast(byval address as GInetAddress ptr) as gboolean
declare function g_inet_address_get_is_mc_global(byval address as GInetAddress ptr) as gboolean
declare function g_inet_address_get_is_mc_link_local(byval address as GInetAddress ptr) as gboolean
declare function g_inet_address_get_is_mc_node_local(byval address as GInetAddress ptr) as gboolean
declare function g_inet_address_get_is_mc_org_local(byval address as GInetAddress ptr) as gboolean
declare function g_inet_address_get_is_mc_site_local(byval address as GInetAddress ptr) as gboolean

#define __G_INET_ADDRESS_MASK_H__
#define G_TYPE_INET_ADDRESS_MASK g_inet_address_mask_get_type()
#define G_INET_ADDRESS_MASK(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_INET_ADDRESS_MASK, GInetAddressMask)
#define G_INET_ADDRESS_MASK_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_INET_ADDRESS_MASK, GInetAddressMaskClass)
#define G_IS_INET_ADDRESS_MASK(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_INET_ADDRESS_MASK)
#define G_IS_INET_ADDRESS_MASK_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), G_TYPE_INET_ADDRESS_MASK)
#define G_INET_ADDRESS_MASK_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), G_TYPE_INET_ADDRESS_MASK, GInetAddressMaskClass)
type GInetAddressMaskClass as _GInetAddressMaskClass
type GInetAddressMaskPrivate as _GInetAddressMaskPrivate

type _GInetAddressMask
	parent_instance as GObject
	priv as GInetAddressMaskPrivate ptr
end type

type _GInetAddressMaskClass
	parent_class as GObjectClass
end type

declare function g_inet_address_mask_get_type() as GType
declare function g_inet_address_mask_new(byval addr as GInetAddress ptr, byval length as guint, byval error as GError ptr ptr) as GInetAddressMask ptr
declare function g_inet_address_mask_new_from_string(byval mask_string as const gchar ptr, byval error as GError ptr ptr) as GInetAddressMask ptr
declare function g_inet_address_mask_to_string(byval mask as GInetAddressMask ptr) as gchar ptr
declare function g_inet_address_mask_get_family(byval mask as GInetAddressMask ptr) as GSocketFamily
declare function g_inet_address_mask_get_address(byval mask as GInetAddressMask ptr) as GInetAddress ptr
declare function g_inet_address_mask_get_length(byval mask as GInetAddressMask ptr) as guint
declare function g_inet_address_mask_matches(byval mask as GInetAddressMask ptr, byval address as GInetAddress ptr) as gboolean
declare function g_inet_address_mask_equal(byval mask as GInetAddressMask ptr, byval mask2 as GInetAddressMask ptr) as gboolean

#define __G_INET_SOCKET_ADDRESS_H__
#define __G_SOCKET_ADDRESS_H__
#define G_TYPE_SOCKET_ADDRESS g_socket_address_get_type()
#define G_SOCKET_ADDRESS(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_SOCKET_ADDRESS, GSocketAddress)
#define G_SOCKET_ADDRESS_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_SOCKET_ADDRESS, GSocketAddressClass)
#define G_IS_SOCKET_ADDRESS(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_SOCKET_ADDRESS)
#define G_IS_SOCKET_ADDRESS_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), G_TYPE_SOCKET_ADDRESS)
#define G_SOCKET_ADDRESS_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), G_TYPE_SOCKET_ADDRESS, GSocketAddressClass)
type GSocketAddressClass as _GSocketAddressClass

type _GSocketAddress
	parent_instance as GObject
end type

type _GSocketAddressClass
	parent_class as GObjectClass
	get_family as function(byval address as GSocketAddress ptr) as GSocketFamily
	get_native_size as function(byval address as GSocketAddress ptr) as gssize
	to_native as function(byval address as GSocketAddress ptr, byval dest as gpointer, byval destlen as gsize, byval error as GError ptr ptr) as gboolean
end type

declare function g_socket_address_get_type() as GType
declare function g_socket_address_get_family(byval address as GSocketAddress ptr) as GSocketFamily
declare function g_socket_address_new_from_native(byval native as gpointer, byval len as gsize) as GSocketAddress ptr
declare function g_socket_address_to_native(byval address as GSocketAddress ptr, byval dest as gpointer, byval destlen as gsize, byval error as GError ptr ptr) as gboolean
declare function g_socket_address_get_native_size(byval address as GSocketAddress ptr) as gssize

#define G_TYPE_INET_SOCKET_ADDRESS g_inet_socket_address_get_type()
#define G_INET_SOCKET_ADDRESS(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_INET_SOCKET_ADDRESS, GInetSocketAddress)
#define G_INET_SOCKET_ADDRESS_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_INET_SOCKET_ADDRESS, GInetSocketAddressClass)
#define G_IS_INET_SOCKET_ADDRESS(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_INET_SOCKET_ADDRESS)
#define G_IS_INET_SOCKET_ADDRESS_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), G_TYPE_INET_SOCKET_ADDRESS)
#define G_INET_SOCKET_ADDRESS_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), G_TYPE_INET_SOCKET_ADDRESS, GInetSocketAddressClass)
type GInetSocketAddressClass as _GInetSocketAddressClass
type GInetSocketAddressPrivate as _GInetSocketAddressPrivate

type _GInetSocketAddress
	parent_instance as GSocketAddress
	priv as GInetSocketAddressPrivate ptr
end type

type _GInetSocketAddressClass
	parent_class as GSocketAddressClass
end type

declare function g_inet_socket_address_get_type() as GType
declare function g_inet_socket_address_new(byval address as GInetAddress ptr, byval port as guint16) as GSocketAddress ptr
declare function g_inet_socket_address_new_from_string(byval address as const zstring ptr, byval port as guint) as GSocketAddress ptr
declare function g_inet_socket_address_get_address(byval address as GInetSocketAddress ptr) as GInetAddress ptr
declare function g_inet_socket_address_get_port(byval address as GInetSocketAddress ptr) as guint16
declare function g_inet_socket_address_get_flowinfo(byval address as GInetSocketAddress ptr) as guint32
declare function g_inet_socket_address_get_scope_id(byval address as GInetSocketAddress ptr) as guint32
#define __GIO_ENUM_TYPES_H__
declare function g_app_info_create_flags_get_type() as GType
#define G_TYPE_APP_INFO_CREATE_FLAGS g_app_info_create_flags_get_type()
declare function g_converter_flags_get_type() as GType
#define G_TYPE_CONVERTER_FLAGS g_converter_flags_get_type()
declare function g_converter_result_get_type() as GType
#define G_TYPE_CONVERTER_RESULT g_converter_result_get_type()
declare function g_data_stream_byte_order_get_type() as GType
#define G_TYPE_DATA_STREAM_BYTE_ORDER g_data_stream_byte_order_get_type()
declare function g_data_stream_newline_type_get_type() as GType
#define G_TYPE_DATA_STREAM_NEWLINE_TYPE g_data_stream_newline_type_get_type()
declare function g_file_attribute_type_get_type() as GType
#define G_TYPE_FILE_ATTRIBUTE_TYPE g_file_attribute_type_get_type()
declare function g_file_attribute_info_flags_get_type() as GType
#define G_TYPE_FILE_ATTRIBUTE_INFO_FLAGS g_file_attribute_info_flags_get_type()
declare function g_file_attribute_status_get_type() as GType
#define G_TYPE_FILE_ATTRIBUTE_STATUS g_file_attribute_status_get_type()
declare function g_file_query_info_flags_get_type() as GType
#define G_TYPE_FILE_QUERY_INFO_FLAGS g_file_query_info_flags_get_type()
declare function g_file_create_flags_get_type() as GType
#define G_TYPE_FILE_CREATE_FLAGS g_file_create_flags_get_type()
declare function g_file_measure_flags_get_type() as GType
#define G_TYPE_FILE_MEASURE_FLAGS g_file_measure_flags_get_type()
declare function g_mount_mount_flags_get_type() as GType
#define G_TYPE_MOUNT_MOUNT_FLAGS g_mount_mount_flags_get_type()
declare function g_mount_unmount_flags_get_type() as GType
#define G_TYPE_MOUNT_UNMOUNT_FLAGS g_mount_unmount_flags_get_type()
declare function g_drive_start_flags_get_type() as GType
#define G_TYPE_DRIVE_START_FLAGS g_drive_start_flags_get_type()
declare function g_drive_start_stop_type_get_type() as GType
#define G_TYPE_DRIVE_START_STOP_TYPE g_drive_start_stop_type_get_type()
declare function g_file_copy_flags_get_type() as GType
#define G_TYPE_FILE_COPY_FLAGS g_file_copy_flags_get_type()
declare function g_file_monitor_flags_get_type() as GType
#define G_TYPE_FILE_MONITOR_FLAGS g_file_monitor_flags_get_type()
declare function g_file_type_get_type() as GType
#define G_TYPE_FILE_TYPE g_file_type_get_type()
declare function g_filesystem_preview_type_get_type() as GType
#define G_TYPE_FILESYSTEM_PREVIEW_TYPE g_filesystem_preview_type_get_type()
declare function g_file_monitor_event_get_type() as GType
#define G_TYPE_FILE_MONITOR_EVENT g_file_monitor_event_get_type()
declare function g_io_error_enum_get_type() as GType
#define G_TYPE_IO_ERROR_ENUM g_io_error_enum_get_type()
declare function g_ask_password_flags_get_type() as GType
#define G_TYPE_ASK_PASSWORD_FLAGS g_ask_password_flags_get_type()
declare function g_password_save_get_type() as GType
#define G_TYPE_PASSWORD_SAVE g_password_save_get_type()
declare function g_mount_operation_result_get_type() as GType
#define G_TYPE_MOUNT_OPERATION_RESULT g_mount_operation_result_get_type()
declare function g_output_stream_splice_flags_get_type() as GType
#define G_TYPE_OUTPUT_STREAM_SPLICE_FLAGS g_output_stream_splice_flags_get_type()
declare function g_io_stream_splice_flags_get_type() as GType
#define G_TYPE_IO_STREAM_SPLICE_FLAGS g_io_stream_splice_flags_get_type()
declare function g_emblem_origin_get_type() as GType
#define G_TYPE_EMBLEM_ORIGIN g_emblem_origin_get_type()
declare function g_resolver_error_get_type() as GType
#define G_TYPE_RESOLVER_ERROR g_resolver_error_get_type()
declare function g_resolver_record_type_get_type() as GType
#define G_TYPE_RESOLVER_RECORD_TYPE g_resolver_record_type_get_type()
declare function g_resource_error_get_type() as GType
#define G_TYPE_RESOURCE_ERROR g_resource_error_get_type()
declare function g_resource_flags_get_type() as GType
#define G_TYPE_RESOURCE_FLAGS g_resource_flags_get_type()
declare function g_resource_lookup_flags_get_type() as GType
#define G_TYPE_RESOURCE_LOOKUP_FLAGS g_resource_lookup_flags_get_type()
declare function g_socket_family_get_type() as GType
#define G_TYPE_SOCKET_FAMILY g_socket_family_get_type()
declare function g_socket_type_get_type() as GType
#define G_TYPE_SOCKET_TYPE g_socket_type_get_type()
declare function g_socket_msg_flags_get_type() as GType
#define G_TYPE_SOCKET_MSG_FLAGS g_socket_msg_flags_get_type()
declare function g_socket_protocol_get_type() as GType
#define G_TYPE_SOCKET_PROTOCOL g_socket_protocol_get_type()
declare function g_zlib_compressor_format_get_type() as GType
#define G_TYPE_ZLIB_COMPRESSOR_FORMAT g_zlib_compressor_format_get_type()
declare function g_unix_socket_address_type_get_type() as GType
#define G_TYPE_UNIX_SOCKET_ADDRESS_TYPE g_unix_socket_address_type_get_type()
declare function g_bus_type_get_type() as GType
#define G_TYPE_BUS_TYPE g_bus_type_get_type()
declare function g_bus_name_owner_flags_get_type() as GType
#define G_TYPE_BUS_NAME_OWNER_FLAGS g_bus_name_owner_flags_get_type()
declare function g_bus_name_watcher_flags_get_type() as GType
#define G_TYPE_BUS_NAME_WATCHER_FLAGS g_bus_name_watcher_flags_get_type()
declare function g_dbus_proxy_flags_get_type() as GType
#define G_TYPE_DBUS_PROXY_FLAGS g_dbus_proxy_flags_get_type()
declare function g_dbus_error_get_type() as GType
#define G_TYPE_DBUS_ERROR g_dbus_error_get_type()
declare function g_dbus_connection_flags_get_type() as GType
#define G_TYPE_DBUS_CONNECTION_FLAGS g_dbus_connection_flags_get_type()
declare function g_dbus_capability_flags_get_type() as GType
#define G_TYPE_DBUS_CAPABILITY_FLAGS g_dbus_capability_flags_get_type()
declare function g_dbus_call_flags_get_type() as GType
#define G_TYPE_DBUS_CALL_FLAGS g_dbus_call_flags_get_type()
declare function g_dbus_message_type_get_type() as GType
#define G_TYPE_DBUS_MESSAGE_TYPE g_dbus_message_type_get_type()
declare function g_dbus_message_flags_get_type() as GType
#define G_TYPE_DBUS_MESSAGE_FLAGS g_dbus_message_flags_get_type()
declare function g_dbus_message_header_field_get_type() as GType
#define G_TYPE_DBUS_MESSAGE_HEADER_FIELD g_dbus_message_header_field_get_type()
declare function g_dbus_property_info_flags_get_type() as GType
#define G_TYPE_DBUS_PROPERTY_INFO_FLAGS g_dbus_property_info_flags_get_type()
declare function g_dbus_subtree_flags_get_type() as GType
#define G_TYPE_DBUS_SUBTREE_FLAGS g_dbus_subtree_flags_get_type()
declare function g_dbus_server_flags_get_type() as GType
#define G_TYPE_DBUS_SERVER_FLAGS g_dbus_server_flags_get_type()
declare function g_dbus_signal_flags_get_type() as GType
#define G_TYPE_DBUS_SIGNAL_FLAGS g_dbus_signal_flags_get_type()
declare function g_dbus_send_message_flags_get_type() as GType
#define G_TYPE_DBUS_SEND_MESSAGE_FLAGS g_dbus_send_message_flags_get_type()
declare function g_credentials_type_get_type() as GType
#define G_TYPE_CREDENTIALS_TYPE g_credentials_type_get_type()
declare function g_dbus_message_byte_order_get_type() as GType
#define G_TYPE_DBUS_MESSAGE_BYTE_ORDER g_dbus_message_byte_order_get_type()
declare function g_application_flags_get_type() as GType
#define G_TYPE_APPLICATION_FLAGS g_application_flags_get_type()
declare function g_tls_error_get_type() as GType
#define G_TYPE_TLS_ERROR g_tls_error_get_type()
declare function g_tls_certificate_flags_get_type() as GType
#define G_TYPE_TLS_CERTIFICATE_FLAGS g_tls_certificate_flags_get_type()
declare function g_tls_authentication_mode_get_type() as GType
#define G_TYPE_TLS_AUTHENTICATION_MODE g_tls_authentication_mode_get_type()
declare function g_tls_rehandshake_mode_get_type() as GType
#define G_TYPE_TLS_REHANDSHAKE_MODE g_tls_rehandshake_mode_get_type()
declare function g_tls_password_flags_get_type() as GType
#define G_TYPE_TLS_PASSWORD_FLAGS g_tls_password_flags_get_type()
declare function g_tls_interaction_result_get_type() as GType
#define G_TYPE_TLS_INTERACTION_RESULT g_tls_interaction_result_get_type()
declare function g_dbus_interface_skeleton_flags_get_type() as GType
#define G_TYPE_DBUS_INTERFACE_SKELETON_FLAGS g_dbus_interface_skeleton_flags_get_type()
declare function g_dbus_object_manager_client_flags_get_type() as GType
#define G_TYPE_DBUS_OBJECT_MANAGER_CLIENT_FLAGS g_dbus_object_manager_client_flags_get_type()
declare function g_tls_database_verify_flags_get_type() as GType
#define G_TYPE_TLS_DATABASE_VERIFY_FLAGS g_tls_database_verify_flags_get_type()
declare function g_tls_database_lookup_flags_get_type() as GType
#define G_TYPE_TLS_DATABASE_LOOKUP_FLAGS g_tls_database_lookup_flags_get_type()
declare function g_tls_certificate_request_flags_get_type() as GType
#define G_TYPE_TLS_CERTIFICATE_REQUEST_FLAGS g_tls_certificate_request_flags_get_type()
declare function g_io_module_scope_flags_get_type() as GType
#define G_TYPE_IO_MODULE_SCOPE_FLAGS g_io_module_scope_flags_get_type()
declare function g_socket_client_event_get_type() as GType
#define G_TYPE_SOCKET_CLIENT_EVENT g_socket_client_event_get_type()
declare function g_test_dbus_flags_get_type() as GType
#define G_TYPE_TEST_DBUS_FLAGS g_test_dbus_flags_get_type()
declare function g_subprocess_flags_get_type() as GType
#define G_TYPE_SUBPROCESS_FLAGS g_subprocess_flags_get_type()
declare function g_notification_priority_get_type() as GType
#define G_TYPE_NOTIFICATION_PRIORITY g_notification_priority_get_type()
declare function g_network_connectivity_get_type() as GType
#define G_TYPE_NETWORK_CONNECTIVITY g_network_connectivity_get_type()
declare function g_settings_bind_flags_get_type() as GType
#define G_TYPE_SETTINGS_BIND_FLAGS g_settings_bind_flags_get_type()
#define __G_IO_MODULE_H__
type GIOModuleScope as _GIOModuleScope
declare function g_io_module_scope_new(byval flags as GIOModuleScopeFlags) as GIOModuleScope ptr
declare sub g_io_module_scope_free(byval scope as GIOModuleScope ptr)
declare sub g_io_module_scope_block(byval scope as GIOModuleScope ptr, byval basename as const gchar ptr)

#define G_IO_TYPE_MODULE g_io_module_get_type()
#define G_IO_MODULE(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_IO_TYPE_MODULE, GIOModule)
#define G_IO_MODULE_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), G_IO_TYPE_MODULE, GIOModuleClass)
#define G_IO_IS_MODULE(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_IO_TYPE_MODULE)
#define G_IO_IS_MODULE_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), G_IO_TYPE_MODULE)
#define G_IO_MODULE_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), G_IO_TYPE_MODULE, GIOModuleClass)
type GIOModuleClass as _GIOModuleClass

declare function g_io_module_get_type() as GType
declare function g_io_module_new(byval filename as const gchar ptr) as GIOModule ptr
declare sub g_io_modules_scan_all_in_directory(byval dirname as const zstring ptr)
declare function g_io_modules_load_all_in_directory(byval dirname as const gchar ptr) as GList ptr
declare sub g_io_modules_scan_all_in_directory_with_scope(byval dirname as const gchar ptr, byval scope as GIOModuleScope ptr)
declare function g_io_modules_load_all_in_directory_with_scope(byval dirname as const gchar ptr, byval scope as GIOModuleScope ptr) as GList ptr
declare function g_io_extension_point_register(byval name as const zstring ptr) as GIOExtensionPoint ptr
declare function g_io_extension_point_lookup(byval name as const zstring ptr) as GIOExtensionPoint ptr
declare sub g_io_extension_point_set_required_type(byval extension_point as GIOExtensionPoint ptr, byval type as GType)
declare function g_io_extension_point_get_required_type(byval extension_point as GIOExtensionPoint ptr) as GType
declare function g_io_extension_point_get_extensions(byval extension_point as GIOExtensionPoint ptr) as GList ptr
declare function g_io_extension_point_get_extension_by_name(byval extension_point as GIOExtensionPoint ptr, byval name as const zstring ptr) as GIOExtension ptr
declare function g_io_extension_point_implement(byval extension_point_name as const zstring ptr, byval type as GType, byval extension_name as const zstring ptr, byval priority as gint) as GIOExtension ptr
declare function g_io_extension_get_type(byval extension as GIOExtension ptr) as GType
declare function g_io_extension_get_name(byval extension as GIOExtension ptr) as const zstring ptr
declare function g_io_extension_get_priority(byval extension as GIOExtension ptr) as gint
declare function g_io_extension_ref_class(byval extension as GIOExtension ptr) as GTypeClass ptr
declare sub g_io_module_load(byval module as GIOModule ptr)
declare sub g_io_module_unload(byval module as GIOModule ptr)
declare function g_io_module_query() as zstring ptr ptr
#define __G_IO_SCHEDULER_H__
declare sub g_io_scheduler_push_job(byval job_func as GIOSchedulerJobFunc, byval user_data as gpointer, byval notify as GDestroyNotify, byval io_priority as gint, byval cancellable as GCancellable ptr)
declare sub g_io_scheduler_cancel_all_jobs()
declare function g_io_scheduler_job_send_to_mainloop(byval job as GIOSchedulerJob ptr, byval func as GSourceFunc, byval user_data as gpointer, byval notify as GDestroyNotify) as gboolean
declare sub g_io_scheduler_job_send_to_mainloop_async(byval job as GIOSchedulerJob ptr, byval func as GSourceFunc, byval user_data as gpointer, byval notify as GDestroyNotify)

#define __G_LOADABLE_ICON_H__
#define G_TYPE_LOADABLE_ICON g_loadable_icon_get_type()
#define G_LOADABLE_ICON(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), G_TYPE_LOADABLE_ICON, GLoadableIcon)
#define G_IS_LOADABLE_ICON(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), G_TYPE_LOADABLE_ICON)
#define G_LOADABLE_ICON_GET_IFACE(obj) G_TYPE_INSTANCE_GET_INTERFACE((obj), G_TYPE_LOADABLE_ICON, GLoadableIconIface)
type GLoadableIconIface as _GLoadableIconIface

type _GLoadableIconIface
	g_iface as GTypeInterface
	load as function(byval icon as GLoadableIcon ptr, byval size as long, byval type as zstring ptr ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GInputStream ptr
	load_async as sub(byval icon as GLoadableIcon ptr, byval size as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	load_finish as function(byval icon as GLoadableIcon ptr, byval res as GAsyncResult ptr, byval type as zstring ptr ptr, byval error as GError ptr ptr) as GInputStream ptr
end type

declare function g_loadable_icon_get_type() as GType
declare function g_loadable_icon_load(byval icon as GLoadableIcon ptr, byval size as long, byval type as zstring ptr ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GInputStream ptr
declare sub g_loadable_icon_load_async(byval icon as GLoadableIcon ptr, byval size as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_loadable_icon_load_finish(byval icon as GLoadableIcon ptr, byval res as GAsyncResult ptr, byval type as zstring ptr ptr, byval error as GError ptr ptr) as GInputStream ptr

#define __G_MEMORY_INPUT_STREAM_H__
#define G_TYPE_MEMORY_INPUT_STREAM g_memory_input_stream_get_type()
#define G_MEMORY_INPUT_STREAM(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_MEMORY_INPUT_STREAM, GMemoryInputStream)
#define G_MEMORY_INPUT_STREAM_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_MEMORY_INPUT_STREAM, GMemoryInputStreamClass)
#define G_IS_MEMORY_INPUT_STREAM(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_MEMORY_INPUT_STREAM)
#define G_IS_MEMORY_INPUT_STREAM_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), G_TYPE_MEMORY_INPUT_STREAM)
#define G_MEMORY_INPUT_STREAM_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), G_TYPE_MEMORY_INPUT_STREAM, GMemoryInputStreamClass)
type GMemoryInputStreamClass as _GMemoryInputStreamClass
type GMemoryInputStreamPrivate as _GMemoryInputStreamPrivate

type _GMemoryInputStream
	parent_instance as GInputStream
	priv as GMemoryInputStreamPrivate ptr
end type

type _GMemoryInputStreamClass
	parent_class as GInputStreamClass
	_g_reserved1 as sub()
	_g_reserved2 as sub()
	_g_reserved3 as sub()
	_g_reserved4 as sub()
	_g_reserved5 as sub()
end type

declare function g_memory_input_stream_get_type() as GType
declare function g_memory_input_stream_new() as GInputStream ptr
declare function g_memory_input_stream_new_from_data(byval data as const any ptr, byval len as gssize, byval destroy as GDestroyNotify) as GInputStream ptr
declare function g_memory_input_stream_new_from_bytes(byval bytes as GBytes ptr) as GInputStream ptr
declare sub g_memory_input_stream_add_data(byval stream as GMemoryInputStream ptr, byval data as const any ptr, byval len as gssize, byval destroy as GDestroyNotify)
declare sub g_memory_input_stream_add_bytes(byval stream as GMemoryInputStream ptr, byval bytes as GBytes ptr)

#define __G_MEMORY_OUTPUT_STREAM_H__
#define G_TYPE_MEMORY_OUTPUT_STREAM g_memory_output_stream_get_type()
#define G_MEMORY_OUTPUT_STREAM(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_MEMORY_OUTPUT_STREAM, GMemoryOutputStream)
#define G_MEMORY_OUTPUT_STREAM_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_MEMORY_OUTPUT_STREAM, GMemoryOutputStreamClass)
#define G_IS_MEMORY_OUTPUT_STREAM(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_MEMORY_OUTPUT_STREAM)
#define G_IS_MEMORY_OUTPUT_STREAM_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), G_TYPE_MEMORY_OUTPUT_STREAM)
#define G_MEMORY_OUTPUT_STREAM_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), G_TYPE_MEMORY_OUTPUT_STREAM, GMemoryOutputStreamClass)
type GMemoryOutputStreamClass as _GMemoryOutputStreamClass
type GMemoryOutputStreamPrivate as _GMemoryOutputStreamPrivate

type _GMemoryOutputStream
	parent_instance as GOutputStream
	priv as GMemoryOutputStreamPrivate ptr
end type

type _GMemoryOutputStreamClass
	parent_class as GOutputStreamClass
	_g_reserved1 as sub()
	_g_reserved2 as sub()
	_g_reserved3 as sub()
	_g_reserved4 as sub()
	_g_reserved5 as sub()
end type

type GReallocFunc as function(byval data as gpointer, byval size as gsize) as gpointer
declare function g_memory_output_stream_get_type() as GType
declare function g_memory_output_stream_new(byval data as gpointer, byval size as gsize, byval realloc_function as GReallocFunc, byval destroy_function as GDestroyNotify) as GOutputStream ptr
declare function g_memory_output_stream_new_resizable() as GOutputStream ptr
declare function g_memory_output_stream_get_data(byval ostream as GMemoryOutputStream ptr) as gpointer
declare function g_memory_output_stream_get_size(byval ostream as GMemoryOutputStream ptr) as gsize
declare function g_memory_output_stream_get_data_size(byval ostream as GMemoryOutputStream ptr) as gsize
declare function g_memory_output_stream_steal_data(byval ostream as GMemoryOutputStream ptr) as gpointer
declare function g_memory_output_stream_steal_as_bytes(byval ostream as GMemoryOutputStream ptr) as GBytes ptr

#define __G_MOUNT_H__
#define G_TYPE_MOUNT g_mount_get_type()
#define G_MOUNT(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), G_TYPE_MOUNT, GMount)
#define G_IS_MOUNT(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), G_TYPE_MOUNT)
#define G_MOUNT_GET_IFACE(obj) G_TYPE_INSTANCE_GET_INTERFACE((obj), G_TYPE_MOUNT, GMountIface)
type GMountIface as _GMountIface

type _GMountIface
	g_iface as GTypeInterface
	changed as sub(byval mount as GMount ptr)
	unmounted as sub(byval mount as GMount ptr)
	get_root as function(byval mount as GMount ptr) as GFile ptr
	get_name as function(byval mount as GMount ptr) as zstring ptr
	get_icon as function(byval mount as GMount ptr) as GIcon ptr
	get_uuid as function(byval mount as GMount ptr) as zstring ptr
	get_volume as function(byval mount as GMount ptr) as GVolume ptr
	get_drive as function(byval mount as GMount ptr) as GDrive ptr
	can_unmount as function(byval mount as GMount ptr) as gboolean
	can_eject as function(byval mount as GMount ptr) as gboolean
	unmount as sub(byval mount as GMount ptr, byval flags as GMountUnmountFlags, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	unmount_finish as function(byval mount as GMount ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
	eject as sub(byval mount as GMount ptr, byval flags as GMountUnmountFlags, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	eject_finish as function(byval mount as GMount ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
	remount as sub(byval mount as GMount ptr, byval flags as GMountMountFlags, byval mount_operation as GMountOperation ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	remount_finish as function(byval mount as GMount ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
	guess_content_type as sub(byval mount as GMount ptr, byval force_rescan as gboolean, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	guess_content_type_finish as function(byval mount as GMount ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gchar ptr ptr
	guess_content_type_sync as function(byval mount as GMount ptr, byval force_rescan as gboolean, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gchar ptr ptr
	pre_unmount as sub(byval mount as GMount ptr)
	unmount_with_operation as sub(byval mount as GMount ptr, byval flags as GMountUnmountFlags, byval mount_operation as GMountOperation ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	unmount_with_operation_finish as function(byval mount as GMount ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
	eject_with_operation as sub(byval mount as GMount ptr, byval flags as GMountUnmountFlags, byval mount_operation as GMountOperation ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	eject_with_operation_finish as function(byval mount as GMount ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
	get_default_location as function(byval mount as GMount ptr) as GFile ptr
	get_sort_key as function(byval mount as GMount ptr) as const gchar ptr
	get_symbolic_icon as function(byval mount as GMount ptr) as GIcon ptr
end type

declare function g_mount_get_type() as GType
declare function g_mount_get_root(byval mount as GMount ptr) as GFile ptr
declare function g_mount_get_default_location(byval mount as GMount ptr) as GFile ptr
declare function g_mount_get_name(byval mount as GMount ptr) as zstring ptr
declare function g_mount_get_icon(byval mount as GMount ptr) as GIcon ptr
declare function g_mount_get_symbolic_icon(byval mount as GMount ptr) as GIcon ptr
declare function g_mount_get_uuid(byval mount as GMount ptr) as zstring ptr
declare function g_mount_get_volume(byval mount as GMount ptr) as GVolume ptr
declare function g_mount_get_drive(byval mount as GMount ptr) as GDrive ptr
declare function g_mount_can_unmount(byval mount as GMount ptr) as gboolean
declare function g_mount_can_eject(byval mount as GMount ptr) as gboolean
declare sub g_mount_unmount(byval mount as GMount ptr, byval flags as GMountUnmountFlags, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_mount_unmount_finish(byval mount as GMount ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
declare sub g_mount_eject(byval mount as GMount ptr, byval flags as GMountUnmountFlags, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_mount_eject_finish(byval mount as GMount ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
declare sub g_mount_remount(byval mount as GMount ptr, byval flags as GMountMountFlags, byval mount_operation as GMountOperation ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_mount_remount_finish(byval mount as GMount ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
declare sub g_mount_guess_content_type(byval mount as GMount ptr, byval force_rescan as gboolean, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_mount_guess_content_type_finish(byval mount as GMount ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gchar ptr ptr
declare function g_mount_guess_content_type_sync(byval mount as GMount ptr, byval force_rescan as gboolean, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gchar ptr ptr
declare function g_mount_is_shadowed(byval mount as GMount ptr) as gboolean
declare sub g_mount_shadow(byval mount as GMount ptr)
declare sub g_mount_unshadow(byval mount as GMount ptr)
declare sub g_mount_unmount_with_operation(byval mount as GMount ptr, byval flags as GMountUnmountFlags, byval mount_operation as GMountOperation ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_mount_unmount_with_operation_finish(byval mount as GMount ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
declare sub g_mount_eject_with_operation(byval mount as GMount ptr, byval flags as GMountUnmountFlags, byval mount_operation as GMountOperation ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_mount_eject_with_operation_finish(byval mount as GMount ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
declare function g_mount_get_sort_key(byval mount as GMount ptr) as const gchar ptr

#define __G_MOUNT_OPERATION_H__
#define G_TYPE_MOUNT_OPERATION g_mount_operation_get_type()
#define G_MOUNT_OPERATION(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_MOUNT_OPERATION, GMountOperation)
#define G_MOUNT_OPERATION_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_MOUNT_OPERATION, GMountOperationClass)
#define G_IS_MOUNT_OPERATION(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_MOUNT_OPERATION)
#define G_IS_MOUNT_OPERATION_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), G_TYPE_MOUNT_OPERATION)
#define G_MOUNT_OPERATION_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), G_TYPE_MOUNT_OPERATION, GMountOperationClass)
type GMountOperationClass as _GMountOperationClass
type GMountOperationPrivate as _GMountOperationPrivate

type _GMountOperation
	parent_instance as GObject
	priv as GMountOperationPrivate ptr
end type

type _GMountOperationClass
	parent_class as GObjectClass
	ask_password as sub(byval op as GMountOperation ptr, byval message as const zstring ptr, byval default_user as const zstring ptr, byval default_domain as const zstring ptr, byval flags as GAskPasswordFlags)
	ask_question as sub(byval op as GMountOperation ptr, byval message as const zstring ptr, byval choices as const zstring ptr ptr)
	reply as sub(byval op as GMountOperation ptr, byval result as GMountOperationResult)
	aborted as sub(byval op as GMountOperation ptr)
	show_processes as sub(byval op as GMountOperation ptr, byval message as const gchar ptr, byval processes as GArray ptr, byval choices as const gchar ptr ptr)
	show_unmount_progress as sub(byval op as GMountOperation ptr, byval message as const gchar ptr, byval time_left as gint64, byval bytes_left as gint64)
	_g_reserved1 as sub()
	_g_reserved2 as sub()
	_g_reserved3 as sub()
	_g_reserved4 as sub()
	_g_reserved5 as sub()
	_g_reserved6 as sub()
	_g_reserved7 as sub()
	_g_reserved8 as sub()
	_g_reserved9 as sub()
end type

declare function g_mount_operation_get_type() as GType
declare function g_mount_operation_new() as GMountOperation ptr
declare function g_mount_operation_get_username(byval op as GMountOperation ptr) as const zstring ptr
declare sub g_mount_operation_set_username(byval op as GMountOperation ptr, byval username as const zstring ptr)
declare function g_mount_operation_get_password(byval op as GMountOperation ptr) as const zstring ptr
declare sub g_mount_operation_set_password(byval op as GMountOperation ptr, byval password as const zstring ptr)
declare function g_mount_operation_get_anonymous(byval op as GMountOperation ptr) as gboolean
declare sub g_mount_operation_set_anonymous(byval op as GMountOperation ptr, byval anonymous as gboolean)
declare function g_mount_operation_get_domain(byval op as GMountOperation ptr) as const zstring ptr
declare sub g_mount_operation_set_domain(byval op as GMountOperation ptr, byval domain as const zstring ptr)
declare function g_mount_operation_get_password_save(byval op as GMountOperation ptr) as GPasswordSave
declare sub g_mount_operation_set_password_save(byval op as GMountOperation ptr, byval save as GPasswordSave)
declare function g_mount_operation_get_choice(byval op as GMountOperation ptr) as long
declare sub g_mount_operation_set_choice(byval op as GMountOperation ptr, byval choice as long)
declare sub g_mount_operation_reply(byval op as GMountOperation ptr, byval result as GMountOperationResult)

#define __G_NATIVE_VOLUME_MONITOR_H__
#define __G_VOLUME_MONITOR_H__
#define G_TYPE_VOLUME_MONITOR g_volume_monitor_get_type()
#define G_VOLUME_MONITOR(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_VOLUME_MONITOR, GVolumeMonitor)
#define G_VOLUME_MONITOR_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_VOLUME_MONITOR, GVolumeMonitorClass)
#define G_VOLUME_MONITOR_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), G_TYPE_VOLUME_MONITOR, GVolumeMonitorClass)
#define G_IS_VOLUME_MONITOR(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_VOLUME_MONITOR)
#define G_IS_VOLUME_MONITOR_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), G_TYPE_VOLUME_MONITOR)
#define G_VOLUME_MONITOR_EXTENSION_POINT_NAME "gio-volume-monitor"
type GVolumeMonitorClass as _GVolumeMonitorClass

type _GVolumeMonitor
	parent_instance as GObject
	priv as gpointer
end type

type _GVolumeMonitorClass
	parent_class as GObjectClass
	volume_added as sub(byval volume_monitor as GVolumeMonitor ptr, byval volume as GVolume ptr)
	volume_removed as sub(byval volume_monitor as GVolumeMonitor ptr, byval volume as GVolume ptr)
	volume_changed as sub(byval volume_monitor as GVolumeMonitor ptr, byval volume as GVolume ptr)
	mount_added as sub(byval volume_monitor as GVolumeMonitor ptr, byval mount as GMount ptr)
	mount_removed as sub(byval volume_monitor as GVolumeMonitor ptr, byval mount as GMount ptr)
	mount_pre_unmount as sub(byval volume_monitor as GVolumeMonitor ptr, byval mount as GMount ptr)
	mount_changed as sub(byval volume_monitor as GVolumeMonitor ptr, byval mount as GMount ptr)
	drive_connected as sub(byval volume_monitor as GVolumeMonitor ptr, byval drive as GDrive ptr)
	drive_disconnected as sub(byval volume_monitor as GVolumeMonitor ptr, byval drive as GDrive ptr)
	drive_changed as sub(byval volume_monitor as GVolumeMonitor ptr, byval drive as GDrive ptr)
	is_supported as function() as gboolean
	get_connected_drives as function(byval volume_monitor as GVolumeMonitor ptr) as GList ptr
	get_volumes as function(byval volume_monitor as GVolumeMonitor ptr) as GList ptr
	get_mounts as function(byval volume_monitor as GVolumeMonitor ptr) as GList ptr
	get_volume_for_uuid as function(byval volume_monitor as GVolumeMonitor ptr, byval uuid as const zstring ptr) as GVolume ptr
	get_mount_for_uuid as function(byval volume_monitor as GVolumeMonitor ptr, byval uuid as const zstring ptr) as GMount ptr
	adopt_orphan_mount as function(byval mount as GMount ptr, byval volume_monitor as GVolumeMonitor ptr) as GVolume ptr
	drive_eject_button as sub(byval volume_monitor as GVolumeMonitor ptr, byval drive as GDrive ptr)
	drive_stop_button as sub(byval volume_monitor as GVolumeMonitor ptr, byval drive as GDrive ptr)
	_g_reserved1 as sub()
	_g_reserved2 as sub()
	_g_reserved3 as sub()
	_g_reserved4 as sub()
	_g_reserved5 as sub()
	_g_reserved6 as sub()
end type

declare function g_volume_monitor_get_type() as GType
declare function g_volume_monitor_get() as GVolumeMonitor ptr
declare function g_volume_monitor_get_connected_drives(byval volume_monitor as GVolumeMonitor ptr) as GList ptr
declare function g_volume_monitor_get_volumes(byval volume_monitor as GVolumeMonitor ptr) as GList ptr
declare function g_volume_monitor_get_mounts(byval volume_monitor as GVolumeMonitor ptr) as GList ptr
declare function g_volume_monitor_get_volume_for_uuid(byval volume_monitor as GVolumeMonitor ptr, byval uuid as const zstring ptr) as GVolume ptr
declare function g_volume_monitor_get_mount_for_uuid(byval volume_monitor as GVolumeMonitor ptr, byval uuid as const zstring ptr) as GMount ptr
declare function g_volume_monitor_adopt_orphan_mount(byval mount as GMount ptr) as GVolume ptr

#define G_TYPE_NATIVE_VOLUME_MONITOR g_native_volume_monitor_get_type()
#define G_NATIVE_VOLUME_MONITOR(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_NATIVE_VOLUME_MONITOR, GNativeVolumeMonitor)
#define G_NATIVE_VOLUME_MONITOR_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_NATIVE_VOLUME_MONITOR, GNativeVolumeMonitorClass)
#define G_IS_NATIVE_VOLUME_MONITOR(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_NATIVE_VOLUME_MONITOR)
#define G_IS_NATIVE_VOLUME_MONITOR_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), G_TYPE_NATIVE_VOLUME_MONITOR)
#define G_NATIVE_VOLUME_MONITOR_EXTENSION_POINT_NAME "gio-native-volume-monitor"
type GNativeVolumeMonitor as _GNativeVolumeMonitor
type GNativeVolumeMonitorClass as _GNativeVolumeMonitorClass

type _GNativeVolumeMonitor
	parent_instance as GVolumeMonitor
end type

type _GNativeVolumeMonitorClass
	parent_class as GVolumeMonitorClass
	get_mount_for_mount_path as function(byval mount_path as const zstring ptr, byval cancellable as GCancellable ptr) as GMount ptr
end type

declare function g_native_volume_monitor_get_type() as GType
#define __G_NETWORK_ADDRESS_H__
#define G_TYPE_NETWORK_ADDRESS g_network_address_get_type()
#define G_NETWORK_ADDRESS(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_NETWORK_ADDRESS, GNetworkAddress)
#define G_NETWORK_ADDRESS_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_NETWORK_ADDRESS, GNetworkAddressClass)
#define G_IS_NETWORK_ADDRESS(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_NETWORK_ADDRESS)
#define G_IS_NETWORK_ADDRESS_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), G_TYPE_NETWORK_ADDRESS)
#define G_NETWORK_ADDRESS_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), G_TYPE_NETWORK_ADDRESS, GNetworkAddressClass)
type GNetworkAddressClass as _GNetworkAddressClass
type GNetworkAddressPrivate as _GNetworkAddressPrivate

type _GNetworkAddress
	parent_instance as GObject
	priv as GNetworkAddressPrivate ptr
end type

type _GNetworkAddressClass
	parent_class as GObjectClass
end type

declare function g_network_address_get_type() as GType
declare function g_network_address_new(byval hostname as const gchar ptr, byval port as guint16) as GSocketConnectable ptr
declare function g_network_address_new_loopback(byval port as guint16) as GSocketConnectable ptr
declare function g_network_address_parse(byval host_and_port as const gchar ptr, byval default_port as guint16, byval error as GError ptr ptr) as GSocketConnectable ptr
declare function g_network_address_parse_uri(byval uri as const gchar ptr, byval default_port as guint16, byval error as GError ptr ptr) as GSocketConnectable ptr
declare function g_network_address_get_hostname(byval addr as GNetworkAddress ptr) as const gchar ptr
declare function g_network_address_get_port(byval addr as GNetworkAddress ptr) as guint16
declare function g_network_address_get_scheme(byval addr as GNetworkAddress ptr) as const gchar ptr

#define __G_NETWORK_MONITOR_H__
#define G_NETWORK_MONITOR_EXTENSION_POINT_NAME "gio-network-monitor"
#define G_TYPE_NETWORK_MONITOR g_network_monitor_get_type()
#define G_NETWORK_MONITOR(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_NETWORK_MONITOR, GNetworkMonitor)
#define G_IS_NETWORK_MONITOR(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_NETWORK_MONITOR)
#define G_NETWORK_MONITOR_GET_INTERFACE(o) G_TYPE_INSTANCE_GET_INTERFACE((o), G_TYPE_NETWORK_MONITOR, GNetworkMonitorInterface)
type GNetworkMonitorInterface as _GNetworkMonitorInterface

type _GNetworkMonitorInterface
	g_iface as GTypeInterface
	network_changed as sub(byval monitor as GNetworkMonitor ptr, byval available as gboolean)
	can_reach as function(byval monitor as GNetworkMonitor ptr, byval connectable as GSocketConnectable ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
	can_reach_async as sub(byval monitor as GNetworkMonitor ptr, byval connectable as GSocketConnectable ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	can_reach_finish as function(byval monitor as GNetworkMonitor ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
end type

declare function g_network_monitor_get_type() as GType
declare function g_network_monitor_get_default() as GNetworkMonitor ptr
declare function g_network_monitor_get_network_available(byval monitor as GNetworkMonitor ptr) as gboolean
declare function g_network_monitor_get_connectivity(byval monitor as GNetworkMonitor ptr) as GNetworkConnectivity
declare function g_network_monitor_can_reach(byval monitor as GNetworkMonitor ptr, byval connectable as GSocketConnectable ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
declare sub g_network_monitor_can_reach_async(byval monitor as GNetworkMonitor ptr, byval connectable as GSocketConnectable ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_network_monitor_can_reach_finish(byval monitor as GNetworkMonitor ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean

#define __G_NETWORK_SERVICE_H__
#define G_TYPE_NETWORK_SERVICE g_network_service_get_type()
#define G_NETWORK_SERVICE(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_NETWORK_SERVICE, GNetworkService)
#define G_NETWORK_SERVICE_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_NETWORK_SERVICE, GNetworkServiceClass)
#define G_IS_NETWORK_SERVICE(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_NETWORK_SERVICE)
#define G_IS_NETWORK_SERVICE_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), G_TYPE_NETWORK_SERVICE)
#define G_NETWORK_SERVICE_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), G_TYPE_NETWORK_SERVICE, GNetworkServiceClass)
type GNetworkServiceClass as _GNetworkServiceClass
type GNetworkServicePrivate as _GNetworkServicePrivate

type _GNetworkService
	parent_instance as GObject
	priv as GNetworkServicePrivate ptr
end type

type _GNetworkServiceClass
	parent_class as GObjectClass
end type

declare function g_network_service_get_type() as GType
declare function g_network_service_new(byval service as const gchar ptr, byval protocol as const gchar ptr, byval domain as const gchar ptr) as GSocketConnectable ptr
declare function g_network_service_get_service(byval srv as GNetworkService ptr) as const gchar ptr
declare function g_network_service_get_protocol(byval srv as GNetworkService ptr) as const gchar ptr
declare function g_network_service_get_domain(byval srv as GNetworkService ptr) as const gchar ptr
declare function g_network_service_get_scheme(byval srv as GNetworkService ptr) as const gchar ptr
declare sub g_network_service_set_scheme(byval srv as GNetworkService ptr, byval scheme as const gchar ptr)

#define __G_PERMISSION_H__
#define G_TYPE_PERMISSION g_permission_get_type()
#define G_PERMISSION(inst) G_TYPE_CHECK_INSTANCE_CAST((inst), G_TYPE_PERMISSION, GPermission)
#define G_PERMISSION_CLASS(class) G_TYPE_CHECK_CLASS_CAST((class), G_TYPE_PERMISSION, GPermissionClass)
#define G_IS_PERMISSION(inst) G_TYPE_CHECK_INSTANCE_TYPE((inst), G_TYPE_PERMISSION)
#define G_IS_PERMISSION_CLASS(class) G_TYPE_CHECK_CLASS_TYPE((class), G_TYPE_PERMISSION)
#define G_PERMISSION_GET_CLASS(inst) G_TYPE_INSTANCE_GET_CLASS((inst), G_TYPE_PERMISSION, GPermissionClass)
type GPermissionPrivate as _GPermissionPrivate
type GPermissionClass as _GPermissionClass

type _GPermission
	parent_instance as GObject
	priv as GPermissionPrivate ptr
end type

type _GPermissionClass
	parent_class as GObjectClass
	acquire as function(byval permission as GPermission ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
	acquire_async as sub(byval permission as GPermission ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	acquire_finish as function(byval permission as GPermission ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
	release as function(byval permission as GPermission ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
	release_async as sub(byval permission as GPermission ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	release_finish as function(byval permission as GPermission ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
	reserved(0 to 15) as gpointer
end type

declare function g_permission_get_type() as GType
declare function g_permission_acquire(byval permission as GPermission ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
declare sub g_permission_acquire_async(byval permission as GPermission ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_permission_acquire_finish(byval permission as GPermission ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
declare function g_permission_release(byval permission as GPermission ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
declare sub g_permission_release_async(byval permission as GPermission ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_permission_release_finish(byval permission as GPermission ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
declare function g_permission_get_allowed(byval permission as GPermission ptr) as gboolean
declare function g_permission_get_can_acquire(byval permission as GPermission ptr) as gboolean
declare function g_permission_get_can_release(byval permission as GPermission ptr) as gboolean
declare sub g_permission_impl_update(byval permission as GPermission ptr, byval allowed as gboolean, byval can_acquire as gboolean, byval can_release as gboolean)

#define __G_POLLABLE_INPUT_STREAM_H__
#define G_TYPE_POLLABLE_INPUT_STREAM g_pollable_input_stream_get_type()
#define G_POLLABLE_INPUT_STREAM(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), G_TYPE_POLLABLE_INPUT_STREAM, GPollableInputStream)
#define G_IS_POLLABLE_INPUT_STREAM(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), G_TYPE_POLLABLE_INPUT_STREAM)
#define G_POLLABLE_INPUT_STREAM_GET_INTERFACE(obj) G_TYPE_INSTANCE_GET_INTERFACE((obj), G_TYPE_POLLABLE_INPUT_STREAM, GPollableInputStreamInterface)
type GPollableInputStreamInterface as _GPollableInputStreamInterface

type _GPollableInputStreamInterface
	g_iface as GTypeInterface
	can_poll as function(byval stream as GPollableInputStream ptr) as gboolean
	is_readable as function(byval stream as GPollableInputStream ptr) as gboolean
	create_source as function(byval stream as GPollableInputStream ptr, byval cancellable as GCancellable ptr) as GSource ptr
	read_nonblocking as function(byval stream as GPollableInputStream ptr, byval buffer as any ptr, byval count as gsize, byval error as GError ptr ptr) as gssize
end type

declare function g_pollable_input_stream_get_type() as GType
declare function g_pollable_input_stream_can_poll(byval stream as GPollableInputStream ptr) as gboolean
declare function g_pollable_input_stream_is_readable(byval stream as GPollableInputStream ptr) as gboolean
declare function g_pollable_input_stream_create_source(byval stream as GPollableInputStream ptr, byval cancellable as GCancellable ptr) as GSource ptr
declare function g_pollable_input_stream_read_nonblocking(byval stream as GPollableInputStream ptr, byval buffer as any ptr, byval count as gsize, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gssize

#define __G_POLLABLE_OUTPUT_STREAM_H__
#define G_TYPE_POLLABLE_OUTPUT_STREAM g_pollable_output_stream_get_type()
#define G_POLLABLE_OUTPUT_STREAM(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), G_TYPE_POLLABLE_OUTPUT_STREAM, GPollableOutputStream)
#define G_IS_POLLABLE_OUTPUT_STREAM(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), G_TYPE_POLLABLE_OUTPUT_STREAM)
#define G_POLLABLE_OUTPUT_STREAM_GET_INTERFACE(obj) G_TYPE_INSTANCE_GET_INTERFACE((obj), G_TYPE_POLLABLE_OUTPUT_STREAM, GPollableOutputStreamInterface)
type GPollableOutputStreamInterface as _GPollableOutputStreamInterface

type _GPollableOutputStreamInterface
	g_iface as GTypeInterface
	can_poll as function(byval stream as GPollableOutputStream ptr) as gboolean
	is_writable as function(byval stream as GPollableOutputStream ptr) as gboolean
	create_source as function(byval stream as GPollableOutputStream ptr, byval cancellable as GCancellable ptr) as GSource ptr
	write_nonblocking as function(byval stream as GPollableOutputStream ptr, byval buffer as const any ptr, byval count as gsize, byval error as GError ptr ptr) as gssize
end type

declare function g_pollable_output_stream_get_type() as GType
declare function g_pollable_output_stream_can_poll(byval stream as GPollableOutputStream ptr) as gboolean
declare function g_pollable_output_stream_is_writable(byval stream as GPollableOutputStream ptr) as gboolean
declare function g_pollable_output_stream_create_source(byval stream as GPollableOutputStream ptr, byval cancellable as GCancellable ptr) as GSource ptr
declare function g_pollable_output_stream_write_nonblocking(byval stream as GPollableOutputStream ptr, byval buffer as const any ptr, byval count as gsize, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gssize
#define __G_POLLABLE_UTILS_H__
declare function g_pollable_source_new(byval pollable_stream as GObject ptr) as GSource ptr
declare function g_pollable_source_new_full(byval pollable_stream as gpointer, byval child_source as GSource ptr, byval cancellable as GCancellable ptr) as GSource ptr
declare function g_pollable_stream_read(byval stream as GInputStream ptr, byval buffer as any ptr, byval count as gsize, byval blocking as gboolean, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gssize
declare function g_pollable_stream_write(byval stream as GOutputStream ptr, byval buffer as const any ptr, byval count as gsize, byval blocking as gboolean, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gssize
declare function g_pollable_stream_write_all(byval stream as GOutputStream ptr, byval buffer as const any ptr, byval count as gsize, byval blocking as gboolean, byval bytes_written as gsize ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean

#define __G_PROPERTY_ACTION_H__
#define G_TYPE_PROPERTY_ACTION g_property_action_get_type()
#define G_PROPERTY_ACTION(inst) G_TYPE_CHECK_INSTANCE_CAST((inst), G_TYPE_PROPERTY_ACTION, GPropertyAction)
#define G_IS_PROPERTY_ACTION(inst) G_TYPE_CHECK_INSTANCE_TYPE((inst), G_TYPE_PROPERTY_ACTION)
declare function g_property_action_get_type() as GType
declare function g_property_action_new(byval name as const gchar ptr, byval object as gpointer, byval property_name as const gchar ptr) as GPropertyAction ptr
#define __G_PROXY_H__
#define G_TYPE_PROXY g_proxy_get_type()
#define G_PROXY(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_PROXY, GProxy)
#define G_IS_PROXY(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_PROXY)
#define G_PROXY_GET_IFACE(obj) G_TYPE_INSTANCE_GET_INTERFACE((obj), G_TYPE_PROXY, GProxyInterface)
#define G_PROXY_EXTENSION_POINT_NAME "gio-proxy"
type GProxyInterface as _GProxyInterface

type _GProxyInterface
	g_iface as GTypeInterface
	connect as function(byval proxy as GProxy ptr, byval connection as GIOStream ptr, byval proxy_address as GProxyAddress ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GIOStream ptr
	connect_async as sub(byval proxy as GProxy ptr, byval connection as GIOStream ptr, byval proxy_address as GProxyAddress ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	connect_finish as function(byval proxy as GProxy ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as GIOStream ptr
	supports_hostname as function(byval proxy as GProxy ptr) as gboolean
end type

declare function g_proxy_get_type() as GType
declare function g_proxy_get_default_for_protocol(byval protocol as const gchar ptr) as GProxy ptr
declare function g_proxy_connect(byval proxy as GProxy ptr, byval connection as GIOStream ptr, byval proxy_address as GProxyAddress ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GIOStream ptr
declare sub g_proxy_connect_async(byval proxy as GProxy ptr, byval connection as GIOStream ptr, byval proxy_address as GProxyAddress ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_proxy_connect_finish(byval proxy as GProxy ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as GIOStream ptr
declare function g_proxy_supports_hostname(byval proxy as GProxy ptr) as gboolean

#define __G_PROXY_ADDRESS_H__
#define G_TYPE_PROXY_ADDRESS g_proxy_address_get_type()
#define G_PROXY_ADDRESS(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_PROXY_ADDRESS, GProxyAddress)
#define G_PROXY_ADDRESS_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_PROXY_ADDRESS, GProxyAddressClass)
#define G_IS_PROXY_ADDRESS(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_PROXY_ADDRESS)
#define G_IS_PROXY_ADDRESS_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), G_TYPE_PROXY_ADDRESS)
#define G_PROXY_ADDRESS_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), G_TYPE_PROXY_ADDRESS, GProxyAddressClass)
type GProxyAddressClass as _GProxyAddressClass
type GProxyAddressPrivate as _GProxyAddressPrivate

type _GProxyAddress
	parent_instance as GInetSocketAddress
	priv as GProxyAddressPrivate ptr
end type

type _GProxyAddressClass
	parent_class as GInetSocketAddressClass
end type

declare function g_proxy_address_get_type() as GType
declare function g_proxy_address_new(byval inetaddr as GInetAddress ptr, byval port as guint16, byval protocol as const gchar ptr, byval dest_hostname as const gchar ptr, byval dest_port as guint16, byval username as const gchar ptr, byval password as const gchar ptr) as GSocketAddress ptr
declare function g_proxy_address_get_protocol(byval proxy as GProxyAddress ptr) as const gchar ptr
declare function g_proxy_address_get_destination_protocol(byval proxy as GProxyAddress ptr) as const gchar ptr
declare function g_proxy_address_get_destination_hostname(byval proxy as GProxyAddress ptr) as const gchar ptr
declare function g_proxy_address_get_destination_port(byval proxy as GProxyAddress ptr) as guint16
declare function g_proxy_address_get_username(byval proxy as GProxyAddress ptr) as const gchar ptr
declare function g_proxy_address_get_password(byval proxy as GProxyAddress ptr) as const gchar ptr
declare function g_proxy_address_get_uri(byval proxy as GProxyAddress ptr) as const gchar ptr

#define __G_PROXY_ADDRESS_ENUMERATOR_H__
#define __G_SOCKET_ADDRESS_ENUMERATOR_H__
#define G_TYPE_SOCKET_ADDRESS_ENUMERATOR g_socket_address_enumerator_get_type()
#define G_SOCKET_ADDRESS_ENUMERATOR(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_SOCKET_ADDRESS_ENUMERATOR, GSocketAddressEnumerator)
#define G_SOCKET_ADDRESS_ENUMERATOR_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_SOCKET_ADDRESS_ENUMERATOR, GSocketAddressEnumeratorClass)
#define G_IS_SOCKET_ADDRESS_ENUMERATOR(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_SOCKET_ADDRESS_ENUMERATOR)
#define G_IS_SOCKET_ADDRESS_ENUMERATOR_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), G_TYPE_SOCKET_ADDRESS_ENUMERATOR)
#define G_SOCKET_ADDRESS_ENUMERATOR_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), G_TYPE_SOCKET_ADDRESS_ENUMERATOR, GSocketAddressEnumeratorClass)
type GSocketAddressEnumeratorClass as _GSocketAddressEnumeratorClass

type _GSocketAddressEnumerator
	parent_instance as GObject
end type

type _GSocketAddressEnumeratorClass
	parent_class as GObjectClass
	next as function(byval enumerator as GSocketAddressEnumerator ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GSocketAddress ptr
	next_async as sub(byval enumerator as GSocketAddressEnumerator ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	next_finish as function(byval enumerator as GSocketAddressEnumerator ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as GSocketAddress ptr
end type

declare function g_socket_address_enumerator_get_type() as GType
declare function g_socket_address_enumerator_next(byval enumerator as GSocketAddressEnumerator ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GSocketAddress ptr
declare sub g_socket_address_enumerator_next_async(byval enumerator as GSocketAddressEnumerator ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_socket_address_enumerator_next_finish(byval enumerator as GSocketAddressEnumerator ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as GSocketAddress ptr

#define G_TYPE_PROXY_ADDRESS_ENUMERATOR g_proxy_address_enumerator_get_type()
#define G_PROXY_ADDRESS_ENUMERATOR(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_PROXY_ADDRESS_ENUMERATOR, GProxyAddressEnumerator)
#define G_PROXY_ADDRESS_ENUMERATOR_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_PROXY_ADDRESS_ENUMERATOR, GProxyAddressEnumeratorClass)
#define G_IS_PROXY_ADDRESS_ENUMERATOR(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_PROXY_ADDRESS_ENUMERATOR)
#define G_IS_PROXY_ADDRESS_ENUMERATOR_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), G_TYPE_PROXY_ADDRESS_ENUMERATOR)
#define G_PROXY_ADDRESS_ENUMERATOR_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), G_TYPE_PROXY_ADDRESS_ENUMERATOR, GProxyAddressEnumeratorClass)
type GProxyAddressEnumeratorClass as _GProxyAddressEnumeratorClass
type GProxyAddressEnumeratorPrivate as _GProxyAddressEnumeratorPrivate

type _GProxyAddressEnumerator
	parent_instance as GSocketAddressEnumerator
	priv as GProxyAddressEnumeratorPrivate ptr
end type

type _GProxyAddressEnumeratorClass
	parent_class as GSocketAddressEnumeratorClass
	_g_reserved1 as sub()
	_g_reserved2 as sub()
	_g_reserved3 as sub()
	_g_reserved4 as sub()
	_g_reserved5 as sub()
	_g_reserved6 as sub()
	_g_reserved7 as sub()
end type

declare function g_proxy_address_enumerator_get_type() as GType
#define __G_PROXY_RESOLVER_H__
#define G_TYPE_PROXY_RESOLVER g_proxy_resolver_get_type()
#define G_PROXY_RESOLVER(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_PROXY_RESOLVER, GProxyResolver)
#define G_IS_PROXY_RESOLVER(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_PROXY_RESOLVER)
#define G_PROXY_RESOLVER_GET_IFACE(o) G_TYPE_INSTANCE_GET_INTERFACE((o), G_TYPE_PROXY_RESOLVER, GProxyResolverInterface)
#define G_PROXY_RESOLVER_EXTENSION_POINT_NAME "gio-proxy-resolver"
type GProxyResolverInterface as _GProxyResolverInterface

type _GProxyResolverInterface
	g_iface as GTypeInterface
	is_supported as function(byval resolver as GProxyResolver ptr) as gboolean
	lookup as function(byval resolver as GProxyResolver ptr, byval uri as const gchar ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gchar ptr ptr
	lookup_async as sub(byval resolver as GProxyResolver ptr, byval uri as const gchar ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	lookup_finish as function(byval resolver as GProxyResolver ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gchar ptr ptr
end type

declare function g_proxy_resolver_get_type() as GType
declare function g_proxy_resolver_get_default() as GProxyResolver ptr
declare function g_proxy_resolver_is_supported(byval resolver as GProxyResolver ptr) as gboolean
declare function g_proxy_resolver_lookup(byval resolver as GProxyResolver ptr, byval uri as const gchar ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gchar ptr ptr
declare sub g_proxy_resolver_lookup_async(byval resolver as GProxyResolver ptr, byval uri as const gchar ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_proxy_resolver_lookup_finish(byval resolver as GProxyResolver ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gchar ptr ptr

#define __G_RESOLVER_H__
#define G_TYPE_RESOLVER g_resolver_get_type()
#define G_RESOLVER(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_RESOLVER, GResolver)
#define G_RESOLVER_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_RESOLVER, GResolverClass)
#define G_IS_RESOLVER(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_RESOLVER)
#define G_IS_RESOLVER_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), G_TYPE_RESOLVER)
#define G_RESOLVER_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), G_TYPE_RESOLVER, GResolverClass)
type GResolverPrivate as _GResolverPrivate
type GResolverClass as _GResolverClass

type _GResolver
	parent_instance as GObject
	priv as GResolverPrivate ptr
end type

type _GResolverClass
	parent_class as GObjectClass
	reload as sub(byval resolver as GResolver ptr)
	lookup_by_name as function(byval resolver as GResolver ptr, byval hostname as const gchar ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GList ptr
	lookup_by_name_async as sub(byval resolver as GResolver ptr, byval hostname as const gchar ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	lookup_by_name_finish as function(byval resolver as GResolver ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as GList ptr
	lookup_by_address as function(byval resolver as GResolver ptr, byval address as GInetAddress ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gchar ptr
	lookup_by_address_async as sub(byval resolver as GResolver ptr, byval address as GInetAddress ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	lookup_by_address_finish as function(byval resolver as GResolver ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gchar ptr
	lookup_service as function(byval resolver as GResolver ptr, byval rrname as const gchar ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GList ptr
	lookup_service_async as sub(byval resolver as GResolver ptr, byval rrname as const gchar ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	lookup_service_finish as function(byval resolver as GResolver ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as GList ptr
	lookup_records as function(byval resolver as GResolver ptr, byval rrname as const gchar ptr, byval record_type as GResolverRecordType, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GList ptr
	lookup_records_async as sub(byval resolver as GResolver ptr, byval rrname as const gchar ptr, byval record_type as GResolverRecordType, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	lookup_records_finish as function(byval resolver as GResolver ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as GList ptr
	_g_reserved4 as sub()
	_g_reserved5 as sub()
	_g_reserved6 as sub()
end type

declare function g_resolver_get_type() as GType
declare function g_resolver_get_default() as GResolver ptr
declare sub g_resolver_set_default(byval resolver as GResolver ptr)
declare function g_resolver_lookup_by_name(byval resolver as GResolver ptr, byval hostname as const gchar ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GList ptr
declare sub g_resolver_lookup_by_name_async(byval resolver as GResolver ptr, byval hostname as const gchar ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_resolver_lookup_by_name_finish(byval resolver as GResolver ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as GList ptr
declare sub g_resolver_free_addresses(byval addresses as GList ptr)
declare function g_resolver_lookup_by_address(byval resolver as GResolver ptr, byval address as GInetAddress ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gchar ptr
declare sub g_resolver_lookup_by_address_async(byval resolver as GResolver ptr, byval address as GInetAddress ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_resolver_lookup_by_address_finish(byval resolver as GResolver ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gchar ptr
declare function g_resolver_lookup_service(byval resolver as GResolver ptr, byval service as const gchar ptr, byval protocol as const gchar ptr, byval domain as const gchar ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GList ptr
declare sub g_resolver_lookup_service_async(byval resolver as GResolver ptr, byval service as const gchar ptr, byval protocol as const gchar ptr, byval domain as const gchar ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_resolver_lookup_service_finish(byval resolver as GResolver ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as GList ptr
declare function g_resolver_lookup_records(byval resolver as GResolver ptr, byval rrname as const gchar ptr, byval record_type as GResolverRecordType, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GList ptr
declare sub g_resolver_lookup_records_async(byval resolver as GResolver ptr, byval rrname as const gchar ptr, byval record_type as GResolverRecordType, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_resolver_lookup_records_finish(byval resolver as GResolver ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as GList ptr
declare sub g_resolver_free_targets(byval targets as GList ptr)
#define G_RESOLVER_ERROR g_resolver_error_quark()
declare function g_resolver_error_quark() as GQuark

#define __G_RESOURCE_H__
#define G_TYPE_RESOURCE g_resource_get_type()
#define G_RESOURCE_ERROR g_resource_error_quark()
declare function g_resource_error_quark() as GQuark
type GStaticResource as _GStaticResource

type _GStaticResource
	data as const guint8 ptr
	data_len as gsize
	resource as GResource ptr
	next as GStaticResource ptr
	padding as gpointer
end type

declare function g_resource_get_type() as GType
declare function g_resource_new_from_data(byval data as GBytes ptr, byval error as GError ptr ptr) as GResource ptr
declare function g_resource_ref(byval resource as GResource ptr) as GResource ptr
declare sub g_resource_unref(byval resource as GResource ptr)
declare function g_resource_load(byval filename as const gchar ptr, byval error as GError ptr ptr) as GResource ptr
declare function g_resource_open_stream(byval resource as GResource ptr, byval path as const zstring ptr, byval lookup_flags as GResourceLookupFlags, byval error as GError ptr ptr) as GInputStream ptr
declare function g_resource_lookup_data(byval resource as GResource ptr, byval path as const zstring ptr, byval lookup_flags as GResourceLookupFlags, byval error as GError ptr ptr) as GBytes ptr
declare function g_resource_enumerate_children(byval resource as GResource ptr, byval path as const zstring ptr, byval lookup_flags as GResourceLookupFlags, byval error as GError ptr ptr) as zstring ptr ptr
declare function g_resource_get_info(byval resource as GResource ptr, byval path as const zstring ptr, byval lookup_flags as GResourceLookupFlags, byval size as gsize ptr, byval flags as guint32 ptr, byval error as GError ptr ptr) as gboolean
declare sub g_resources_register(byval resource as GResource ptr)
declare sub g_resources_unregister(byval resource as GResource ptr)
declare function g_resources_open_stream(byval path as const zstring ptr, byval lookup_flags as GResourceLookupFlags, byval error as GError ptr ptr) as GInputStream ptr
declare function g_resources_lookup_data(byval path as const zstring ptr, byval lookup_flags as GResourceLookupFlags, byval error as GError ptr ptr) as GBytes ptr
declare function g_resources_enumerate_children(byval path as const zstring ptr, byval lookup_flags as GResourceLookupFlags, byval error as GError ptr ptr) as zstring ptr ptr
declare function g_resources_get_info(byval path as const zstring ptr, byval lookup_flags as GResourceLookupFlags, byval size as gsize ptr, byval flags as guint32 ptr, byval error as GError ptr ptr) as gboolean
declare sub g_static_resource_init(byval static_resource as GStaticResource ptr)
declare sub g_static_resource_fini(byval static_resource as GStaticResource ptr)
declare function g_static_resource_get_resource(byval static_resource as GStaticResource ptr) as GResource ptr

#define __G_SEEKABLE_H__
#define G_TYPE_SEEKABLE g_seekable_get_type()
#define G_SEEKABLE(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), G_TYPE_SEEKABLE, GSeekable)
#define G_IS_SEEKABLE(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), G_TYPE_SEEKABLE)
#define G_SEEKABLE_GET_IFACE(obj) G_TYPE_INSTANCE_GET_INTERFACE((obj), G_TYPE_SEEKABLE, GSeekableIface)
type GSeekableIface as _GSeekableIface

type _GSeekableIface
	g_iface as GTypeInterface
	tell as function(byval seekable as GSeekable ptr) as goffset
	can_seek as function(byval seekable as GSeekable ptr) as gboolean
	seek as function(byval seekable as GSeekable ptr, byval offset as goffset, byval type as GSeekType, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
	can_truncate as function(byval seekable as GSeekable ptr) as gboolean
	truncate_fn as function(byval seekable as GSeekable ptr, byval offset as goffset, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
end type

declare function g_seekable_get_type() as GType
declare function g_seekable_tell(byval seekable as GSeekable ptr) as goffset
declare function g_seekable_can_seek(byval seekable as GSeekable ptr) as gboolean
declare function g_seekable_seek(byval seekable as GSeekable ptr, byval offset as goffset, byval type as GSeekType, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
declare function g_seekable_can_truncate(byval seekable as GSeekable ptr) as gboolean
declare function g_seekable_truncate(byval seekable as GSeekable ptr, byval offset as goffset, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
#define __G_SETTINGS_SCHEMA_H__

type GSettingsSchemaSource as _GSettingsSchemaSource
type GSettingsSchema as _GSettingsSchema
type GSettingsSchemaKey as _GSettingsSchemaKey
#define G_TYPE_SETTINGS_SCHEMA_SOURCE g_settings_schema_source_get_type()

declare function g_settings_schema_source_get_type() as GType
declare function g_settings_schema_source_get_default() as GSettingsSchemaSource ptr
declare function g_settings_schema_source_ref(byval source as GSettingsSchemaSource ptr) as GSettingsSchemaSource ptr
declare sub g_settings_schema_source_unref(byval source as GSettingsSchemaSource ptr)
declare function g_settings_schema_source_new_from_directory(byval directory as const gchar ptr, byval parent as GSettingsSchemaSource ptr, byval trusted as gboolean, byval error as GError ptr ptr) as GSettingsSchemaSource ptr
declare function g_settings_schema_source_lookup(byval source as GSettingsSchemaSource ptr, byval schema_id as const gchar ptr, byval recursive as gboolean) as GSettingsSchema ptr
declare sub g_settings_schema_source_list_schemas(byval source as GSettingsSchemaSource ptr, byval recursive as gboolean, byval non_relocatable as gchar ptr ptr ptr, byval relocatable as gchar ptr ptr ptr)
#define G_TYPE_SETTINGS_SCHEMA g_settings_schema_get_type()
declare function g_settings_schema_get_type() as GType
declare function g_settings_schema_ref(byval schema as GSettingsSchema ptr) as GSettingsSchema ptr
declare sub g_settings_schema_unref(byval schema as GSettingsSchema ptr)
declare function g_settings_schema_get_id(byval schema as GSettingsSchema ptr) as const gchar ptr
declare function g_settings_schema_get_path(byval schema as GSettingsSchema ptr) as const gchar ptr
declare function g_settings_schema_get_key(byval schema as GSettingsSchema ptr, byval name as const gchar ptr) as GSettingsSchemaKey ptr
declare function g_settings_schema_has_key(byval schema as GSettingsSchema ptr, byval name as const gchar ptr) as gboolean
declare function g_settings_schema_list_children(byval schema as GSettingsSchema ptr) as gchar ptr ptr
#define G_TYPE_SETTINGS_SCHEMA_KEY g_settings_schema_key_get_type()
declare function g_settings_schema_key_get_type() as GType
declare function g_settings_schema_key_ref(byval key as GSettingsSchemaKey ptr) as GSettingsSchemaKey ptr
declare sub g_settings_schema_key_unref(byval key as GSettingsSchemaKey ptr)
declare function g_settings_schema_key_get_value_type(byval key as GSettingsSchemaKey ptr) as const GVariantType ptr
declare function g_settings_schema_key_get_default_value(byval key as GSettingsSchemaKey ptr) as GVariant ptr
declare function g_settings_schema_key_get_range(byval key as GSettingsSchemaKey ptr) as GVariant ptr
declare function g_settings_schema_key_range_check(byval key as GSettingsSchemaKey ptr, byval value as GVariant ptr) as gboolean
declare function g_settings_schema_key_get_name(byval key as GSettingsSchemaKey ptr) as const gchar ptr
declare function g_settings_schema_key_get_summary(byval key as GSettingsSchemaKey ptr) as const gchar ptr
declare function g_settings_schema_key_get_description(byval key as GSettingsSchemaKey ptr) as const gchar ptr

#define __G_SETTINGS_H__
#define G_TYPE_SETTINGS g_settings_get_type()
#define G_SETTINGS(inst) G_TYPE_CHECK_INSTANCE_CAST((inst), G_TYPE_SETTINGS, GSettings)
#define G_SETTINGS_CLASS(class) G_TYPE_CHECK_CLASS_CAST((class), G_TYPE_SETTINGS, GSettingsClass)
#define G_IS_SETTINGS(inst) G_TYPE_CHECK_INSTANCE_TYPE((inst), G_TYPE_SETTINGS)
#define G_IS_SETTINGS_CLASS(class) G_TYPE_CHECK_CLASS_TYPE((class), G_TYPE_SETTINGS)
#define G_SETTINGS_GET_CLASS(inst) G_TYPE_INSTANCE_GET_CLASS((inst), G_TYPE_SETTINGS, GSettingsClass)
type GSettingsPrivate as _GSettingsPrivate
type GSettingsClass as _GSettingsClass

type _GSettingsClass
	parent_class as GObjectClass
	writable_changed as sub(byval settings as GSettings ptr, byval key as const gchar ptr)
	changed as sub(byval settings as GSettings ptr, byval key as const gchar ptr)
	writable_change_event as function(byval settings as GSettings ptr, byval key as GQuark) as gboolean
	change_event as function(byval settings as GSettings ptr, byval keys as const GQuark ptr, byval n_keys as gint) as gboolean
	padding(0 to 19) as gpointer
end type

type _GSettings
	parent_instance as GObject
	priv as GSettingsPrivate ptr
end type

declare function g_settings_get_type() as GType
declare function g_settings_list_schemas() as const gchar const ptr ptr
declare function g_settings_list_relocatable_schemas() as const gchar const ptr ptr
declare function g_settings_new(byval schema_id as const gchar ptr) as GSettings ptr
declare function g_settings_new_with_path(byval schema_id as const gchar ptr, byval path as const gchar ptr) as GSettings ptr
declare function g_settings_new_with_backend(byval schema_id as const gchar ptr, byval backend as GSettingsBackend ptr) as GSettings ptr
declare function g_settings_new_with_backend_and_path(byval schema_id as const gchar ptr, byval backend as GSettingsBackend ptr, byval path as const gchar ptr) as GSettings ptr
declare function g_settings_new_full(byval schema as GSettingsSchema ptr, byval backend as GSettingsBackend ptr, byval path as const gchar ptr) as GSettings ptr
declare function g_settings_list_children(byval settings as GSettings ptr) as gchar ptr ptr
declare function g_settings_list_keys(byval settings as GSettings ptr) as gchar ptr ptr
declare function g_settings_get_range(byval settings as GSettings ptr, byval key as const gchar ptr) as GVariant ptr
declare function g_settings_range_check(byval settings as GSettings ptr, byval key as const gchar ptr, byval value as GVariant ptr) as gboolean
declare function g_settings_set_value(byval settings as GSettings ptr, byval key as const gchar ptr, byval value as GVariant ptr) as gboolean
declare function g_settings_get_value(byval settings as GSettings ptr, byval key as const gchar ptr) as GVariant ptr
declare function g_settings_get_user_value(byval settings as GSettings ptr, byval key as const gchar ptr) as GVariant ptr
declare function g_settings_get_default_value(byval settings as GSettings ptr, byval key as const gchar ptr) as GVariant ptr
declare function g_settings_set(byval settings as GSettings ptr, byval key as const gchar ptr, byval format as const gchar ptr, ...) as gboolean
declare sub g_settings_get(byval settings as GSettings ptr, byval key as const gchar ptr, byval format as const gchar ptr, ...)
declare sub g_settings_reset(byval settings as GSettings ptr, byval key as const gchar ptr)
declare function g_settings_get_int(byval settings as GSettings ptr, byval key as const gchar ptr) as gint
declare function g_settings_set_int(byval settings as GSettings ptr, byval key as const gchar ptr, byval value as gint) as gboolean
declare function g_settings_get_uint(byval settings as GSettings ptr, byval key as const gchar ptr) as guint
declare function g_settings_set_uint(byval settings as GSettings ptr, byval key as const gchar ptr, byval value as guint) as gboolean
declare function g_settings_get_string(byval settings as GSettings ptr, byval key as const gchar ptr) as gchar ptr
declare function g_settings_set_string(byval settings as GSettings ptr, byval key as const gchar ptr, byval value as const gchar ptr) as gboolean
declare function g_settings_get_boolean(byval settings as GSettings ptr, byval key as const gchar ptr) as gboolean
declare function g_settings_set_boolean(byval settings as GSettings ptr, byval key as const gchar ptr, byval value as gboolean) as gboolean
declare function g_settings_get_double(byval settings as GSettings ptr, byval key as const gchar ptr) as gdouble
declare function g_settings_set_double(byval settings as GSettings ptr, byval key as const gchar ptr, byval value as gdouble) as gboolean
declare function g_settings_get_strv(byval settings as GSettings ptr, byval key as const gchar ptr) as gchar ptr ptr
declare function g_settings_set_strv(byval settings as GSettings ptr, byval key as const gchar ptr, byval value as const gchar const ptr ptr) as gboolean
declare function g_settings_get_enum(byval settings as GSettings ptr, byval key as const gchar ptr) as gint
declare function g_settings_set_enum(byval settings as GSettings ptr, byval key as const gchar ptr, byval value as gint) as gboolean
declare function g_settings_get_flags(byval settings as GSettings ptr, byval key as const gchar ptr) as guint
declare function g_settings_set_flags(byval settings as GSettings ptr, byval key as const gchar ptr, byval value as guint) as gboolean
declare function g_settings_get_child(byval settings as GSettings ptr, byval name as const gchar ptr) as GSettings ptr
declare function g_settings_is_writable(byval settings as GSettings ptr, byval name as const gchar ptr) as gboolean
declare sub g_settings_delay(byval settings as GSettings ptr)
declare sub g_settings_apply(byval settings as GSettings ptr)
declare sub g_settings_revert(byval settings as GSettings ptr)
declare function g_settings_get_has_unapplied(byval settings as GSettings ptr) as gboolean
declare sub g_settings_sync()

type GSettingsBindSetMapping as function(byval value as const GValue ptr, byval expected_type as const GVariantType ptr, byval user_data as gpointer) as GVariant ptr
type GSettingsBindGetMapping as function(byval value as GValue ptr, byval variant as GVariant ptr, byval user_data as gpointer) as gboolean
type GSettingsGetMapping as function(byval value as GVariant ptr, byval result as gpointer ptr, byval user_data as gpointer) as gboolean

type GSettingsBindFlags as long
enum
	G_SETTINGS_BIND_DEFAULT
	G_SETTINGS_BIND_GET = 1 shl 0
	G_SETTINGS_BIND_SET = 1 shl 1
	G_SETTINGS_BIND_NO_SENSITIVITY = 1 shl 2
	G_SETTINGS_BIND_GET_NO_CHANGES = 1 shl 3
	G_SETTINGS_BIND_INVERT_BOOLEAN = 1 shl 4
end enum

declare sub g_settings_bind(byval settings as GSettings ptr, byval key as const gchar ptr, byval object as gpointer, byval property as const gchar ptr, byval flags as GSettingsBindFlags)
declare sub g_settings_bind_with_mapping(byval settings as GSettings ptr, byval key as const gchar ptr, byval object as gpointer, byval property as const gchar ptr, byval flags as GSettingsBindFlags, byval get_mapping as GSettingsBindGetMapping, byval set_mapping as GSettingsBindSetMapping, byval user_data as gpointer, byval destroy as GDestroyNotify)
declare sub g_settings_bind_writable(byval settings as GSettings ptr, byval key as const gchar ptr, byval object as gpointer, byval property as const gchar ptr, byval inverted as gboolean)
declare sub g_settings_unbind(byval object as gpointer, byval property as const gchar ptr)
declare function g_settings_create_action(byval settings as GSettings ptr, byval key as const gchar ptr) as GAction ptr
declare function g_settings_get_mapped(byval settings as GSettings ptr, byval key as const gchar ptr, byval mapping as GSettingsGetMapping, byval user_data as gpointer) as gpointer

#define __G_SIMPLE_ACTION_H__
#define G_TYPE_SIMPLE_ACTION g_simple_action_get_type()
#define G_SIMPLE_ACTION(inst) G_TYPE_CHECK_INSTANCE_CAST((inst), G_TYPE_SIMPLE_ACTION, GSimpleAction)
#define G_IS_SIMPLE_ACTION(inst) G_TYPE_CHECK_INSTANCE_TYPE((inst), G_TYPE_SIMPLE_ACTION)

declare function g_simple_action_get_type() as GType
declare function g_simple_action_new(byval name as const gchar ptr, byval parameter_type as const GVariantType ptr) as GSimpleAction ptr
declare function g_simple_action_new_stateful(byval name as const gchar ptr, byval parameter_type as const GVariantType ptr, byval state as GVariant ptr) as GSimpleAction ptr
declare sub g_simple_action_set_enabled(byval simple as GSimpleAction ptr, byval enabled as gboolean)
declare sub g_simple_action_set_state(byval simple as GSimpleAction ptr, byval value as GVariant ptr)
declare sub g_simple_action_set_state_hint(byval simple as GSimpleAction ptr, byval state_hint as GVariant ptr)

#define __G_SIMPLE_ACTION_GROUP_H__
#define G_TYPE_SIMPLE_ACTION_GROUP g_simple_action_group_get_type()
#define G_SIMPLE_ACTION_GROUP(inst) G_TYPE_CHECK_INSTANCE_CAST((inst), G_TYPE_SIMPLE_ACTION_GROUP, GSimpleActionGroup)
#define G_SIMPLE_ACTION_GROUP_CLASS(class) G_TYPE_CHECK_CLASS_CAST((class), G_TYPE_SIMPLE_ACTION_GROUP, GSimpleActionGroupClass)
#define G_IS_SIMPLE_ACTION_GROUP(inst) G_TYPE_CHECK_INSTANCE_TYPE((inst), G_TYPE_SIMPLE_ACTION_GROUP)
#define G_IS_SIMPLE_ACTION_GROUP_CLASS(class) G_TYPE_CHECK_CLASS_TYPE((class), G_TYPE_SIMPLE_ACTION_GROUP)
#define G_SIMPLE_ACTION_GROUP_GET_CLASS(inst) G_TYPE_INSTANCE_GET_CLASS((inst), G_TYPE_SIMPLE_ACTION_GROUP, GSimpleActionGroupClass)
type GSimpleActionGroupPrivate as _GSimpleActionGroupPrivate
type GSimpleActionGroupClass as _GSimpleActionGroupClass

type _GSimpleActionGroup
	parent_instance as GObject
	priv as GSimpleActionGroupPrivate ptr
end type

type _GSimpleActionGroupClass
	parent_class as GObjectClass
	padding(0 to 11) as gpointer
end type

declare function g_simple_action_group_get_type() as GType
declare function g_simple_action_group_new() as GSimpleActionGroup ptr
declare function g_simple_action_group_lookup(byval simple as GSimpleActionGroup ptr, byval action_name as const gchar ptr) as GAction ptr
declare sub g_simple_action_group_insert(byval simple as GSimpleActionGroup ptr, byval action as GAction ptr)
declare sub g_simple_action_group_remove(byval simple as GSimpleActionGroup ptr, byval action_name as const gchar ptr)
declare sub g_simple_action_group_add_entries(byval simple as GSimpleActionGroup ptr, byval entries as const GActionEntry ptr, byval n_entries as gint, byval user_data as gpointer)

#define __G_SIMPLE_ASYNC_RESULT_H__
#define G_TYPE_SIMPLE_ASYNC_RESULT g_simple_async_result_get_type()
#define G_SIMPLE_ASYNC_RESULT(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_SIMPLE_ASYNC_RESULT, GSimpleAsyncResult)
#define G_SIMPLE_ASYNC_RESULT_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_SIMPLE_ASYNC_RESULT, GSimpleAsyncResultClass)
#define G_IS_SIMPLE_ASYNC_RESULT(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_SIMPLE_ASYNC_RESULT)
#define G_IS_SIMPLE_ASYNC_RESULT_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), G_TYPE_SIMPLE_ASYNC_RESULT)
#define G_SIMPLE_ASYNC_RESULT_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), G_TYPE_SIMPLE_ASYNC_RESULT, GSimpleAsyncResultClass)
type GSimpleAsyncResultClass as _GSimpleAsyncResultClass

declare function g_simple_async_result_get_type() as GType
declare function g_simple_async_result_new(byval source_object as GObject ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer, byval source_tag as gpointer) as GSimpleAsyncResult ptr
declare function g_simple_async_result_new_error(byval source_object as GObject ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer, byval domain as GQuark, byval code as gint, byval format as const zstring ptr, ...) as GSimpleAsyncResult ptr
declare function g_simple_async_result_new_from_error(byval source_object as GObject ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer, byval error as const GError ptr) as GSimpleAsyncResult ptr
declare function g_simple_async_result_new_take_error(byval source_object as GObject ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer, byval error as GError ptr) as GSimpleAsyncResult ptr
declare sub g_simple_async_result_set_op_res_gpointer(byval simple as GSimpleAsyncResult ptr, byval op_res as gpointer, byval destroy_op_res as GDestroyNotify)
declare function g_simple_async_result_get_op_res_gpointer(byval simple as GSimpleAsyncResult ptr) as gpointer
declare sub g_simple_async_result_set_op_res_gssize(byval simple as GSimpleAsyncResult ptr, byval op_res as gssize)
declare function g_simple_async_result_get_op_res_gssize(byval simple as GSimpleAsyncResult ptr) as gssize
declare sub g_simple_async_result_set_op_res_gboolean(byval simple as GSimpleAsyncResult ptr, byval op_res as gboolean)
declare function g_simple_async_result_get_op_res_gboolean(byval simple as GSimpleAsyncResult ptr) as gboolean
declare sub g_simple_async_result_set_check_cancellable(byval simple as GSimpleAsyncResult ptr, byval check_cancellable as GCancellable ptr)
declare function g_simple_async_result_get_source_tag(byval simple as GSimpleAsyncResult ptr) as gpointer
declare sub g_simple_async_result_set_handle_cancellation(byval simple as GSimpleAsyncResult ptr, byval handle_cancellation as gboolean)
declare sub g_simple_async_result_complete(byval simple as GSimpleAsyncResult ptr)
declare sub g_simple_async_result_complete_in_idle(byval simple as GSimpleAsyncResult ptr)
declare sub g_simple_async_result_run_in_thread(byval simple as GSimpleAsyncResult ptr, byval func as GSimpleAsyncThreadFunc, byval io_priority as long, byval cancellable as GCancellable ptr)
declare sub g_simple_async_result_set_from_error(byval simple as GSimpleAsyncResult ptr, byval error as const GError ptr)
declare sub g_simple_async_result_take_error(byval simple as GSimpleAsyncResult ptr, byval error as GError ptr)
declare function g_simple_async_result_propagate_error(byval simple as GSimpleAsyncResult ptr, byval dest as GError ptr ptr) as gboolean
declare sub g_simple_async_result_set_error(byval simple as GSimpleAsyncResult ptr, byval domain as GQuark, byval code as gint, byval format as const zstring ptr, ...)
declare sub g_simple_async_result_set_error_va(byval simple as GSimpleAsyncResult ptr, byval domain as GQuark, byval code as gint, byval format as const zstring ptr, byval args as va_list)
declare function g_simple_async_result_is_valid(byval result as GAsyncResult ptr, byval source as GObject ptr, byval source_tag as gpointer) as gboolean
declare sub g_simple_async_report_error_in_idle(byval object as GObject ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer, byval domain as GQuark, byval code as gint, byval format as const zstring ptr, ...)
declare sub g_simple_async_report_gerror_in_idle(byval object as GObject ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer, byval error as const GError ptr)
declare sub g_simple_async_report_take_gerror_in_idle(byval object as GObject ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer, byval error as GError ptr)

#define __G_SIMPLE_IO_STREAM_H__
#define G_TYPE_SIMPLE_IO_STREAM g_simple_io_stream_get_type()
#define G_SIMPLE_IO_STREAM(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), G_TYPE_SIMPLE_IO_STREAM, GSimpleIOStream)
#define G_IS_SIMPLE_IO_STREAM(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), G_TYPE_SIMPLE_IO_STREAM)
declare function g_simple_io_stream_get_type() as GType
declare function g_simple_io_stream_new(byval input_stream as GInputStream ptr, byval output_stream as GOutputStream ptr) as GIOStream ptr
#define __G_SIMPLE_PERMISSION_H__
#define G_TYPE_SIMPLE_PERMISSION g_simple_permission_get_type()
#define G_SIMPLE_PERMISSION(inst) G_TYPE_CHECK_INSTANCE_CAST((inst), G_TYPE_SIMPLE_PERMISSION, GSimplePermission)
#define G_IS_SIMPLE_PERMISSION(inst) G_TYPE_CHECK_INSTANCE_TYPE((inst), G_TYPE_SIMPLE_PERMISSION)
declare function g_simple_permission_get_type() as GType
declare function g_simple_permission_new(byval allowed as gboolean) as GPermission ptr
#define __G_SOCKET_CLIENT_H__
#define G_TYPE_SOCKET_CLIENT g_socket_client_get_type()
#define G_SOCKET_CLIENT(inst) G_TYPE_CHECK_INSTANCE_CAST((inst), G_TYPE_SOCKET_CLIENT, GSocketClient)
#define G_SOCKET_CLIENT_CLASS(class) G_TYPE_CHECK_CLASS_CAST((class), G_TYPE_SOCKET_CLIENT, GSocketClientClass)
#define G_IS_SOCKET_CLIENT(inst) G_TYPE_CHECK_INSTANCE_TYPE((inst), G_TYPE_SOCKET_CLIENT)
#define G_IS_SOCKET_CLIENT_CLASS(class) G_TYPE_CHECK_CLASS_TYPE((class), G_TYPE_SOCKET_CLIENT)
#define G_SOCKET_CLIENT_GET_CLASS(inst) G_TYPE_INSTANCE_GET_CLASS((inst), G_TYPE_SOCKET_CLIENT, GSocketClientClass)
type GSocketClientPrivate as _GSocketClientPrivate
type GSocketClientClass as _GSocketClientClass

type _GSocketClientClass
	parent_class as GObjectClass
	event as sub(byval client as GSocketClient ptr, byval event as GSocketClientEvent, byval connectable as GSocketConnectable ptr, byval connection as GIOStream ptr)
	_g_reserved1 as sub()
	_g_reserved2 as sub()
	_g_reserved3 as sub()
	_g_reserved4 as sub()
end type

type _GSocketClient
	parent_instance as GObject
	priv as GSocketClientPrivate ptr
end type

declare function g_socket_client_get_type() as GType
declare function g_socket_client_new() as GSocketClient ptr
declare function g_socket_client_get_family(byval client as GSocketClient ptr) as GSocketFamily
declare sub g_socket_client_set_family(byval client as GSocketClient ptr, byval family as GSocketFamily)
declare function g_socket_client_get_socket_type(byval client as GSocketClient ptr) as GSocketType
declare sub g_socket_client_set_socket_type(byval client as GSocketClient ptr, byval type as GSocketType)
declare function g_socket_client_get_protocol(byval client as GSocketClient ptr) as GSocketProtocol
declare sub g_socket_client_set_protocol(byval client as GSocketClient ptr, byval protocol as GSocketProtocol)
declare function g_socket_client_get_local_address(byval client as GSocketClient ptr) as GSocketAddress ptr
declare sub g_socket_client_set_local_address(byval client as GSocketClient ptr, byval address as GSocketAddress ptr)
declare function g_socket_client_get_timeout(byval client as GSocketClient ptr) as guint
declare sub g_socket_client_set_timeout(byval client as GSocketClient ptr, byval timeout as guint)
declare function g_socket_client_get_enable_proxy(byval client as GSocketClient ptr) as gboolean
declare sub g_socket_client_set_enable_proxy(byval client as GSocketClient ptr, byval enable as gboolean)
declare function g_socket_client_get_tls(byval client as GSocketClient ptr) as gboolean
declare sub g_socket_client_set_tls(byval client as GSocketClient ptr, byval tls as gboolean)
declare function g_socket_client_get_tls_validation_flags(byval client as GSocketClient ptr) as GTlsCertificateFlags
declare sub g_socket_client_set_tls_validation_flags(byval client as GSocketClient ptr, byval flags as GTlsCertificateFlags)
declare function g_socket_client_get_proxy_resolver(byval client as GSocketClient ptr) as GProxyResolver ptr
declare sub g_socket_client_set_proxy_resolver(byval client as GSocketClient ptr, byval proxy_resolver as GProxyResolver ptr)
declare function g_socket_client_connect(byval client as GSocketClient ptr, byval connectable as GSocketConnectable ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GSocketConnection ptr
declare function g_socket_client_connect_to_host(byval client as GSocketClient ptr, byval host_and_port as const gchar ptr, byval default_port as guint16, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GSocketConnection ptr
declare function g_socket_client_connect_to_service(byval client as GSocketClient ptr, byval domain as const gchar ptr, byval service as const gchar ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GSocketConnection ptr
declare function g_socket_client_connect_to_uri(byval client as GSocketClient ptr, byval uri as const gchar ptr, byval default_port as guint16, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GSocketConnection ptr
declare sub g_socket_client_connect_async(byval client as GSocketClient ptr, byval connectable as GSocketConnectable ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_socket_client_connect_finish(byval client as GSocketClient ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as GSocketConnection ptr
declare sub g_socket_client_connect_to_host_async(byval client as GSocketClient ptr, byval host_and_port as const gchar ptr, byval default_port as guint16, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_socket_client_connect_to_host_finish(byval client as GSocketClient ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as GSocketConnection ptr
declare sub g_socket_client_connect_to_service_async(byval client as GSocketClient ptr, byval domain as const gchar ptr, byval service as const gchar ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_socket_client_connect_to_service_finish(byval client as GSocketClient ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as GSocketConnection ptr
declare sub g_socket_client_connect_to_uri_async(byval client as GSocketClient ptr, byval uri as const gchar ptr, byval default_port as guint16, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_socket_client_connect_to_uri_finish(byval client as GSocketClient ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as GSocketConnection ptr
declare sub g_socket_client_add_application_proxy(byval client as GSocketClient ptr, byval protocol as const gchar ptr)

#define __G_SOCKET_CONNECTABLE_H__
#define G_TYPE_SOCKET_CONNECTABLE g_socket_connectable_get_type()
#define G_SOCKET_CONNECTABLE(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), G_TYPE_SOCKET_CONNECTABLE, GSocketConnectable)
#define G_IS_SOCKET_CONNECTABLE(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), G_TYPE_SOCKET_CONNECTABLE)
#define G_SOCKET_CONNECTABLE_GET_IFACE(obj) G_TYPE_INSTANCE_GET_INTERFACE((obj), G_TYPE_SOCKET_CONNECTABLE, GSocketConnectableIface)
type GSocketConnectableIface as _GSocketConnectableIface

type _GSocketConnectableIface
	g_iface as GTypeInterface
	enumerate as function(byval connectable as GSocketConnectable ptr) as GSocketAddressEnumerator ptr
	proxy_enumerate as function(byval connectable as GSocketConnectable ptr) as GSocketAddressEnumerator ptr
end type

declare function g_socket_connectable_get_type() as GType
declare function g_socket_connectable_enumerate(byval connectable as GSocketConnectable ptr) as GSocketAddressEnumerator ptr
declare function g_socket_connectable_proxy_enumerate(byval connectable as GSocketConnectable ptr) as GSocketAddressEnumerator ptr

#define __G_SOCKET_CONNECTION_H__
#define __G_SOCKET_H__
#define G_TYPE_SOCKET g_socket_get_type()
#define G_SOCKET(inst) G_TYPE_CHECK_INSTANCE_CAST((inst), G_TYPE_SOCKET, GSocket)
#define G_SOCKET_CLASS(class) G_TYPE_CHECK_CLASS_CAST((class), G_TYPE_SOCKET, GSocketClass)
#define G_IS_SOCKET(inst) G_TYPE_CHECK_INSTANCE_TYPE((inst), G_TYPE_SOCKET)
#define G_IS_SOCKET_CLASS(class) G_TYPE_CHECK_CLASS_TYPE((class), G_TYPE_SOCKET)
#define G_SOCKET_GET_CLASS(inst) G_TYPE_INSTANCE_GET_CLASS((inst), G_TYPE_SOCKET, GSocketClass)
type GSocketPrivate as _GSocketPrivate
type GSocketClass as _GSocketClass

type _GSocketClass
	parent_class as GObjectClass
	_g_reserved1 as sub()
	_g_reserved2 as sub()
	_g_reserved3 as sub()
	_g_reserved4 as sub()
	_g_reserved5 as sub()
	_g_reserved6 as sub()
	_g_reserved7 as sub()
	_g_reserved8 as sub()
	_g_reserved9 as sub()
	_g_reserved10 as sub()
end type

type _GSocket
	parent_instance as GObject
	priv as GSocketPrivate ptr
end type

declare function g_socket_get_type() as GType
declare function g_socket_new(byval family as GSocketFamily, byval type as GSocketType, byval protocol as GSocketProtocol, byval error as GError ptr ptr) as GSocket ptr
declare function g_socket_new_from_fd(byval fd as gint, byval error as GError ptr ptr) as GSocket ptr
declare function g_socket_get_fd(byval socket as GSocket ptr) as long
declare function g_socket_get_family(byval socket as GSocket ptr) as GSocketFamily
declare function g_socket_get_socket_type(byval socket as GSocket ptr) as GSocketType
declare function g_socket_get_protocol(byval socket as GSocket ptr) as GSocketProtocol
declare function g_socket_get_local_address(byval socket as GSocket ptr, byval error as GError ptr ptr) as GSocketAddress ptr
declare function g_socket_get_remote_address(byval socket as GSocket ptr, byval error as GError ptr ptr) as GSocketAddress ptr
declare sub g_socket_set_blocking(byval socket as GSocket ptr, byval blocking as gboolean)
declare function g_socket_get_blocking(byval socket as GSocket ptr) as gboolean
declare sub g_socket_set_keepalive(byval socket as GSocket ptr, byval keepalive as gboolean)
declare function g_socket_get_keepalive(byval socket as GSocket ptr) as gboolean
declare function g_socket_get_listen_backlog(byval socket as GSocket ptr) as gint
declare sub g_socket_set_listen_backlog(byval socket as GSocket ptr, byval backlog as gint)
declare function g_socket_get_timeout(byval socket as GSocket ptr) as guint
declare sub g_socket_set_timeout(byval socket as GSocket ptr, byval timeout as guint)
declare function g_socket_get_ttl(byval socket as GSocket ptr) as guint
declare sub g_socket_set_ttl(byval socket as GSocket ptr, byval ttl as guint)
declare function g_socket_get_broadcast(byval socket as GSocket ptr) as gboolean
declare sub g_socket_set_broadcast(byval socket as GSocket ptr, byval broadcast as gboolean)
declare function g_socket_get_multicast_loopback(byval socket as GSocket ptr) as gboolean
declare sub g_socket_set_multicast_loopback(byval socket as GSocket ptr, byval loopback as gboolean)
declare function g_socket_get_multicast_ttl(byval socket as GSocket ptr) as guint
declare sub g_socket_set_multicast_ttl(byval socket as GSocket ptr, byval ttl as guint)
declare function g_socket_is_connected(byval socket as GSocket ptr) as gboolean
declare function g_socket_bind(byval socket as GSocket ptr, byval address as GSocketAddress ptr, byval allow_reuse as gboolean, byval error as GError ptr ptr) as gboolean
declare function g_socket_join_multicast_group(byval socket as GSocket ptr, byval group as GInetAddress ptr, byval source_specific as gboolean, byval iface as const gchar ptr, byval error as GError ptr ptr) as gboolean
declare function g_socket_leave_multicast_group(byval socket as GSocket ptr, byval group as GInetAddress ptr, byval source_specific as gboolean, byval iface as const gchar ptr, byval error as GError ptr ptr) as gboolean
declare function g_socket_connect(byval socket as GSocket ptr, byval address as GSocketAddress ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
declare function g_socket_check_connect_result(byval socket as GSocket ptr, byval error as GError ptr ptr) as gboolean
declare function g_socket_get_available_bytes(byval socket as GSocket ptr) as gssize
declare function g_socket_condition_check(byval socket as GSocket ptr, byval condition as GIOCondition) as GIOCondition
declare function g_socket_condition_wait(byval socket as GSocket ptr, byval condition as GIOCondition, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
declare function g_socket_condition_timed_wait(byval socket as GSocket ptr, byval condition as GIOCondition, byval timeout as gint64, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
declare function g_socket_accept(byval socket as GSocket ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GSocket ptr
declare function g_socket_listen(byval socket as GSocket ptr, byval error as GError ptr ptr) as gboolean
declare function g_socket_receive(byval socket as GSocket ptr, byval buffer as gchar ptr, byval size as gsize, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gssize
declare function g_socket_receive_from(byval socket as GSocket ptr, byval address as GSocketAddress ptr ptr, byval buffer as gchar ptr, byval size as gsize, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gssize
declare function g_socket_send(byval socket as GSocket ptr, byval buffer as const gchar ptr, byval size as gsize, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gssize
declare function g_socket_send_to(byval socket as GSocket ptr, byval address as GSocketAddress ptr, byval buffer as const gchar ptr, byval size as gsize, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gssize
declare function g_socket_receive_message(byval socket as GSocket ptr, byval address as GSocketAddress ptr ptr, byval vectors as GInputVector ptr, byval num_vectors as gint, byval messages as GSocketControlMessage ptr ptr ptr, byval num_messages as gint ptr, byval flags as gint ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gssize
declare function g_socket_send_message(byval socket as GSocket ptr, byval address as GSocketAddress ptr, byval vectors as GOutputVector ptr, byval num_vectors as gint, byval messages as GSocketControlMessage ptr ptr, byval num_messages as gint, byval flags as gint, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gssize
declare function g_socket_send_messages(byval socket as GSocket ptr, byval messages as GOutputMessage ptr, byval num_messages as guint, byval flags as gint, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gint
declare function g_socket_close(byval socket as GSocket ptr, byval error as GError ptr ptr) as gboolean
declare function g_socket_shutdown(byval socket as GSocket ptr, byval shutdown_read as gboolean, byval shutdown_write as gboolean, byval error as GError ptr ptr) as gboolean
declare function g_socket_is_closed(byval socket as GSocket ptr) as gboolean
declare function g_socket_create_source(byval socket as GSocket ptr, byval condition as GIOCondition, byval cancellable as GCancellable ptr) as GSource ptr
declare function g_socket_speaks_ipv4(byval socket as GSocket ptr) as gboolean
declare function g_socket_get_credentials(byval socket as GSocket ptr, byval error as GError ptr ptr) as GCredentials ptr
declare function g_socket_receive_with_blocking(byval socket as GSocket ptr, byval buffer as gchar ptr, byval size as gsize, byval blocking as gboolean, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gssize
declare function g_socket_send_with_blocking(byval socket as GSocket ptr, byval buffer as const gchar ptr, byval size as gsize, byval blocking as gboolean, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gssize
declare function g_socket_get_option(byval socket as GSocket ptr, byval level as gint, byval optname as gint, byval value as gint ptr, byval error as GError ptr ptr) as gboolean
declare function g_socket_set_option(byval socket as GSocket ptr, byval level as gint, byval optname as gint, byval value as gint, byval error as GError ptr ptr) as gboolean

#define G_TYPE_SOCKET_CONNECTION g_socket_connection_get_type()
#define G_SOCKET_CONNECTION(inst) G_TYPE_CHECK_INSTANCE_CAST((inst), G_TYPE_SOCKET_CONNECTION, GSocketConnection)
#define G_SOCKET_CONNECTION_CLASS(class) G_TYPE_CHECK_CLASS_CAST((class), G_TYPE_SOCKET_CONNECTION, GSocketConnectionClass)
#define G_IS_SOCKET_CONNECTION(inst) G_TYPE_CHECK_INSTANCE_TYPE((inst), G_TYPE_SOCKET_CONNECTION)
#define G_IS_SOCKET_CONNECTION_CLASS(class) G_TYPE_CHECK_CLASS_TYPE((class), G_TYPE_SOCKET_CONNECTION)
#define G_SOCKET_CONNECTION_GET_CLASS(inst) G_TYPE_INSTANCE_GET_CLASS((inst), G_TYPE_SOCKET_CONNECTION, GSocketConnectionClass)
type GSocketConnectionPrivate as _GSocketConnectionPrivate
type GSocketConnectionClass as _GSocketConnectionClass

type _GSocketConnectionClass
	parent_class as GIOStreamClass
	_g_reserved1 as sub()
	_g_reserved2 as sub()
	_g_reserved3 as sub()
	_g_reserved4 as sub()
	_g_reserved5 as sub()
	_g_reserved6 as sub()
end type

type _GSocketConnection
	parent_instance as GIOStream
	priv as GSocketConnectionPrivate ptr
end type

declare function g_socket_connection_get_type() as GType
declare function g_socket_connection_is_connected(byval connection as GSocketConnection ptr) as gboolean
declare function g_socket_connection_connect(byval connection as GSocketConnection ptr, byval address as GSocketAddress ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
declare sub g_socket_connection_connect_async(byval connection as GSocketConnection ptr, byval address as GSocketAddress ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_socket_connection_connect_finish(byval connection as GSocketConnection ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
declare function g_socket_connection_get_socket(byval connection as GSocketConnection ptr) as GSocket ptr
declare function g_socket_connection_get_local_address(byval connection as GSocketConnection ptr, byval error as GError ptr ptr) as GSocketAddress ptr
declare function g_socket_connection_get_remote_address(byval connection as GSocketConnection ptr, byval error as GError ptr ptr) as GSocketAddress ptr
declare sub g_socket_connection_factory_register_type(byval g_type as GType, byval family as GSocketFamily, byval type as GSocketType, byval protocol as gint)
declare function g_socket_connection_factory_lookup_type(byval family as GSocketFamily, byval type as GSocketType, byval protocol_id as gint) as GType
declare function g_socket_connection_factory_create_connection(byval socket as GSocket ptr) as GSocketConnection ptr

#define __G_SOCKET_CONTROL_MESSAGE_H__
#define G_TYPE_SOCKET_CONTROL_MESSAGE g_socket_control_message_get_type()
#define G_SOCKET_CONTROL_MESSAGE(inst) G_TYPE_CHECK_INSTANCE_CAST((inst), G_TYPE_SOCKET_CONTROL_MESSAGE, GSocketControlMessage)
#define G_SOCKET_CONTROL_MESSAGE_CLASS(class) G_TYPE_CHECK_CLASS_CAST((class), G_TYPE_SOCKET_CONTROL_MESSAGE, GSocketControlMessageClass)
#define G_IS_SOCKET_CONTROL_MESSAGE(inst) G_TYPE_CHECK_INSTANCE_TYPE((inst), G_TYPE_SOCKET_CONTROL_MESSAGE)
#define G_IS_SOCKET_CONTROL_MESSAGE_CLASS(class) G_TYPE_CHECK_CLASS_TYPE((class), G_TYPE_SOCKET_CONTROL_MESSAGE)
#define G_SOCKET_CONTROL_MESSAGE_GET_CLASS(inst) G_TYPE_INSTANCE_GET_CLASS((inst), G_TYPE_SOCKET_CONTROL_MESSAGE, GSocketControlMessageClass)
type GSocketControlMessagePrivate as _GSocketControlMessagePrivate
type GSocketControlMessageClass as _GSocketControlMessageClass

type _GSocketControlMessageClass
	parent_class as GObjectClass
	get_size as function(byval message as GSocketControlMessage ptr) as gsize
	get_level as function(byval message as GSocketControlMessage ptr) as long
	get_type as function(byval message as GSocketControlMessage ptr) as long
	serialize as sub(byval message as GSocketControlMessage ptr, byval data as gpointer)
	deserialize as function(byval level as long, byval type as long, byval size as gsize, byval data as gpointer) as GSocketControlMessage ptr
	_g_reserved1 as sub()
	_g_reserved2 as sub()
	_g_reserved3 as sub()
	_g_reserved4 as sub()
	_g_reserved5 as sub()
end type

type _GSocketControlMessage
	parent_instance as GObject
	priv as GSocketControlMessagePrivate ptr
end type

declare function g_socket_control_message_get_type() as GType
declare function g_socket_control_message_get_size(byval message as GSocketControlMessage ptr) as gsize
declare function g_socket_control_message_get_level(byval message as GSocketControlMessage ptr) as long
declare function g_socket_control_message_get_msg_type(byval message as GSocketControlMessage ptr) as long
declare sub g_socket_control_message_serialize(byval message as GSocketControlMessage ptr, byval data as gpointer)
declare function g_socket_control_message_deserialize(byval level as long, byval type as long, byval size as gsize, byval data as gpointer) as GSocketControlMessage ptr

#define __G_SOCKET_LISTENER_H__
#define G_TYPE_SOCKET_LISTENER g_socket_listener_get_type()
#define G_SOCKET_LISTENER(inst) G_TYPE_CHECK_INSTANCE_CAST((inst), G_TYPE_SOCKET_LISTENER, GSocketListener)
#define G_SOCKET_LISTENER_CLASS(class) G_TYPE_CHECK_CLASS_CAST((class), G_TYPE_SOCKET_LISTENER, GSocketListenerClass)
#define G_IS_SOCKET_LISTENER(inst) G_TYPE_CHECK_INSTANCE_TYPE((inst), G_TYPE_SOCKET_LISTENER)
#define G_IS_SOCKET_LISTENER_CLASS(class) G_TYPE_CHECK_CLASS_TYPE((class), G_TYPE_SOCKET_LISTENER)
#define G_SOCKET_LISTENER_GET_CLASS(inst) G_TYPE_INSTANCE_GET_CLASS((inst), G_TYPE_SOCKET_LISTENER, GSocketListenerClass)
type GSocketListenerPrivate as _GSocketListenerPrivate
type GSocketListenerClass as _GSocketListenerClass

type _GSocketListenerClass
	parent_class as GObjectClass
	changed as sub(byval listener as GSocketListener ptr)
	_g_reserved1 as sub()
	_g_reserved2 as sub()
	_g_reserved3 as sub()
	_g_reserved4 as sub()
	_g_reserved5 as sub()
	_g_reserved6 as sub()
end type

type _GSocketListener
	parent_instance as GObject
	priv as GSocketListenerPrivate ptr
end type

declare function g_socket_listener_get_type() as GType
declare function g_socket_listener_new() as GSocketListener ptr
declare sub g_socket_listener_set_backlog(byval listener as GSocketListener ptr, byval listen_backlog as long)
declare function g_socket_listener_add_socket(byval listener as GSocketListener ptr, byval socket as GSocket ptr, byval source_object as GObject ptr, byval error as GError ptr ptr) as gboolean
declare function g_socket_listener_add_address(byval listener as GSocketListener ptr, byval address as GSocketAddress ptr, byval type as GSocketType, byval protocol as GSocketProtocol, byval source_object as GObject ptr, byval effective_address as GSocketAddress ptr ptr, byval error as GError ptr ptr) as gboolean
declare function g_socket_listener_add_inet_port(byval listener as GSocketListener ptr, byval port as guint16, byval source_object as GObject ptr, byval error as GError ptr ptr) as gboolean
declare function g_socket_listener_add_any_inet_port(byval listener as GSocketListener ptr, byval source_object as GObject ptr, byval error as GError ptr ptr) as guint16
declare function g_socket_listener_accept_socket(byval listener as GSocketListener ptr, byval source_object as GObject ptr ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GSocket ptr
declare sub g_socket_listener_accept_socket_async(byval listener as GSocketListener ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_socket_listener_accept_socket_finish(byval listener as GSocketListener ptr, byval result as GAsyncResult ptr, byval source_object as GObject ptr ptr, byval error as GError ptr ptr) as GSocket ptr
declare function g_socket_listener_accept(byval listener as GSocketListener ptr, byval source_object as GObject ptr ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GSocketConnection ptr
declare sub g_socket_listener_accept_async(byval listener as GSocketListener ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_socket_listener_accept_finish(byval listener as GSocketListener ptr, byval result as GAsyncResult ptr, byval source_object as GObject ptr ptr, byval error as GError ptr ptr) as GSocketConnection ptr
declare sub g_socket_listener_close(byval listener as GSocketListener ptr)

#define __G_SOCKET_SERVICE_H__
#define G_TYPE_SOCKET_SERVICE g_socket_service_get_type()
#define G_SOCKET_SERVICE(inst) G_TYPE_CHECK_INSTANCE_CAST((inst), G_TYPE_SOCKET_SERVICE, GSocketService)
#define G_SOCKET_SERVICE_CLASS(class) G_TYPE_CHECK_CLASS_CAST((class), G_TYPE_SOCKET_SERVICE, GSocketServiceClass)
#define G_IS_SOCKET_SERVICE(inst) G_TYPE_CHECK_INSTANCE_TYPE((inst), G_TYPE_SOCKET_SERVICE)
#define G_IS_SOCKET_SERVICE_CLASS(class) G_TYPE_CHECK_CLASS_TYPE((class), G_TYPE_SOCKET_SERVICE)
#define G_SOCKET_SERVICE_GET_CLASS(inst) G_TYPE_INSTANCE_GET_CLASS((inst), G_TYPE_SOCKET_SERVICE, GSocketServiceClass)
type GSocketServicePrivate as _GSocketServicePrivate
type GSocketServiceClass as _GSocketServiceClass

type _GSocketServiceClass
	parent_class as GSocketListenerClass
	incoming as function(byval service as GSocketService ptr, byval connection as GSocketConnection ptr, byval source_object as GObject ptr) as gboolean
	_g_reserved1 as sub()
	_g_reserved2 as sub()
	_g_reserved3 as sub()
	_g_reserved4 as sub()
	_g_reserved5 as sub()
	_g_reserved6 as sub()
end type

type _GSocketService
	parent_instance as GSocketListener
	priv as GSocketServicePrivate ptr
end type

declare function g_socket_service_get_type() as GType
declare function g_socket_service_new() as GSocketService ptr
declare sub g_socket_service_start(byval service as GSocketService ptr)
declare sub g_socket_service_stop(byval service as GSocketService ptr)
declare function g_socket_service_is_active(byval service as GSocketService ptr) as gboolean
#define __G_SRV_TARGET_H__
declare function g_srv_target_get_type() as GType
#define G_TYPE_SRV_TARGET g_srv_target_get_type()
declare function g_srv_target_new(byval hostname as const gchar ptr, byval port as guint16, byval priority as guint16, byval weight as guint16) as GSrvTarget ptr
declare function g_srv_target_copy(byval target as GSrvTarget ptr) as GSrvTarget ptr
declare sub g_srv_target_free(byval target as GSrvTarget ptr)
declare function g_srv_target_get_hostname(byval target as GSrvTarget ptr) as const gchar ptr
declare function g_srv_target_get_port(byval target as GSrvTarget ptr) as guint16
declare function g_srv_target_get_priority(byval target as GSrvTarget ptr) as guint16
declare function g_srv_target_get_weight(byval target as GSrvTarget ptr) as guint16
declare function g_srv_target_list_sort(byval targets as GList ptr) as GList ptr

#define __G_SIMPLE_PROXY_RESOLVER_H__
#define G_TYPE_SIMPLE_PROXY_RESOLVER g_simple_proxy_resolver_get_type()
#define G_SIMPLE_PROXY_RESOLVER(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_SIMPLE_PROXY_RESOLVER, GSimpleProxyResolver)
#define G_SIMPLE_PROXY_RESOLVER_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_SIMPLE_PROXY_RESOLVER, GSimpleProxyResolverClass)
#define G_IS_SIMPLE_PROXY_RESOLVER(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_SIMPLE_PROXY_RESOLVER)
#define G_IS_SIMPLE_PROXY_RESOLVER_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), G_TYPE_SIMPLE_PROXY_RESOLVER)
#define G_SIMPLE_PROXY_RESOLVER_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), G_TYPE_SIMPLE_PROXY_RESOLVER, GSimpleProxyResolverClass)

type GSimpleProxyResolver as _GSimpleProxyResolver
type GSimpleProxyResolverPrivate as _GSimpleProxyResolverPrivate
type GSimpleProxyResolverClass as _GSimpleProxyResolverClass

type _GSimpleProxyResolver
	parent_instance as GObject
	priv as GSimpleProxyResolverPrivate ptr
end type

type _GSimpleProxyResolverClass
	parent_class as GObjectClass
	_g_reserved1 as sub()
	_g_reserved2 as sub()
	_g_reserved3 as sub()
	_g_reserved4 as sub()
	_g_reserved5 as sub()
end type

declare function g_simple_proxy_resolver_get_type() as GType
declare function g_simple_proxy_resolver_new(byval default_proxy as const gchar ptr, byval ignore_hosts as gchar ptr ptr) as GProxyResolver ptr
declare sub g_simple_proxy_resolver_set_default_proxy(byval resolver as GSimpleProxyResolver ptr, byval default_proxy as const gchar ptr)
declare sub g_simple_proxy_resolver_set_ignore_hosts(byval resolver as GSimpleProxyResolver ptr, byval ignore_hosts as gchar ptr ptr)
declare sub g_simple_proxy_resolver_set_uri_proxy(byval resolver as GSimpleProxyResolver ptr, byval uri_scheme as const gchar ptr, byval proxy as const gchar ptr)

#define __G_TASK_H__
#define G_TYPE_TASK g_task_get_type()
#define G_TASK(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_TASK, GTask)
#define G_TASK_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_TASK, GTaskClass)
#define G_IS_TASK(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_TASK)
#define G_IS_TASK_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), G_TYPE_TASK)
#define G_TASK_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), G_TYPE_TASK, GTaskClass)
type GTaskClass as _GTaskClass

declare function g_task_get_type() as GType
declare function g_task_new(byval source_object as gpointer, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval callback_data as gpointer) as GTask ptr
declare sub g_task_report_error(byval source_object as gpointer, byval callback as GAsyncReadyCallback, byval callback_data as gpointer, byval source_tag as gpointer, byval error as GError ptr)
declare sub g_task_report_new_error(byval source_object as gpointer, byval callback as GAsyncReadyCallback, byval callback_data as gpointer, byval source_tag as gpointer, byval domain as GQuark, byval code as gint, byval format as const zstring ptr, ...)
declare sub g_task_set_task_data(byval task as GTask ptr, byval task_data as gpointer, byval task_data_destroy as GDestroyNotify)
declare sub g_task_set_priority(byval task as GTask ptr, byval priority as gint)
declare sub g_task_set_check_cancellable(byval task as GTask ptr, byval check_cancellable as gboolean)
declare sub g_task_set_source_tag(byval task as GTask ptr, byval source_tag as gpointer)
declare function g_task_get_source_object(byval task as GTask ptr) as gpointer
declare function g_task_get_task_data(byval task as GTask ptr) as gpointer
declare function g_task_get_priority(byval task as GTask ptr) as gint
declare function g_task_get_context(byval task as GTask ptr) as GMainContext ptr
declare function g_task_get_cancellable(byval task as GTask ptr) as GCancellable ptr
declare function g_task_get_check_cancellable(byval task as GTask ptr) as gboolean
declare function g_task_get_source_tag(byval task as GTask ptr) as gpointer
declare function g_task_is_valid(byval result as gpointer, byval source_object as gpointer) as gboolean
type GTaskThreadFunc as sub(byval task as GTask ptr, byval source_object as gpointer, byval task_data as gpointer, byval cancellable as GCancellable ptr)
declare sub g_task_run_in_thread(byval task as GTask ptr, byval task_func as GTaskThreadFunc)
declare sub g_task_run_in_thread_sync(byval task as GTask ptr, byval task_func as GTaskThreadFunc)
declare function g_task_set_return_on_cancel(byval task as GTask ptr, byval return_on_cancel as gboolean) as gboolean
declare function g_task_get_return_on_cancel(byval task as GTask ptr) as gboolean
declare sub g_task_attach_source(byval task as GTask ptr, byval source as GSource ptr, byval callback as GSourceFunc)
declare sub g_task_return_pointer(byval task as GTask ptr, byval result as gpointer, byval result_destroy as GDestroyNotify)
declare sub g_task_return_boolean(byval task as GTask ptr, byval result as gboolean)
declare sub g_task_return_int(byval task as GTask ptr, byval result as gssize)
declare sub g_task_return_error(byval task as GTask ptr, byval error as GError ptr)
declare sub g_task_return_new_error(byval task as GTask ptr, byval domain as GQuark, byval code as gint, byval format as const zstring ptr, ...)
declare function g_task_return_error_if_cancelled(byval task as GTask ptr) as gboolean
declare function g_task_propagate_pointer(byval task as GTask ptr, byval error as GError ptr ptr) as gpointer
declare function g_task_propagate_boolean(byval task as GTask ptr, byval error as GError ptr ptr) as gboolean
declare function g_task_propagate_int(byval task as GTask ptr, byval error as GError ptr ptr) as gssize
declare function g_task_had_error(byval task as GTask ptr) as gboolean
declare function g_task_get_completed(byval task as GTask ptr) as gboolean

#define __G_SUBPROCESS_H__
#define G_TYPE_SUBPROCESS g_subprocess_get_type()
#define G_SUBPROCESS(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_SUBPROCESS, GSubprocess)
#define G_IS_SUBPROCESS(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_SUBPROCESS)

declare function g_subprocess_get_type() as GType
declare function g_subprocess_new(byval flags as GSubprocessFlags, byval error as GError ptr ptr, byval argv0 as const gchar ptr, ...) as GSubprocess ptr
declare function g_subprocess_newv(byval argv as const gchar const ptr ptr, byval flags as GSubprocessFlags, byval error as GError ptr ptr) as GSubprocess ptr
declare function g_subprocess_get_stdin_pipe(byval subprocess as GSubprocess ptr) as GOutputStream ptr
declare function g_subprocess_get_stdout_pipe(byval subprocess as GSubprocess ptr) as GInputStream ptr
declare function g_subprocess_get_stderr_pipe(byval subprocess as GSubprocess ptr) as GInputStream ptr
declare function g_subprocess_get_identifier(byval subprocess as GSubprocess ptr) as const gchar ptr

#ifdef __FB_UNIX__
	declare sub g_subprocess_send_signal(byval subprocess as GSubprocess ptr, byval signal_num as gint)
#endif

declare sub g_subprocess_force_exit(byval subprocess as GSubprocess ptr)
declare function g_subprocess_wait(byval subprocess as GSubprocess ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
declare sub g_subprocess_wait_async(byval subprocess as GSubprocess ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_subprocess_wait_finish(byval subprocess as GSubprocess ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
declare function g_subprocess_wait_check(byval subprocess as GSubprocess ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
declare sub g_subprocess_wait_check_async(byval subprocess as GSubprocess ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_subprocess_wait_check_finish(byval subprocess as GSubprocess ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
declare function g_subprocess_get_status(byval subprocess as GSubprocess ptr) as gint
declare function g_subprocess_get_successful(byval subprocess as GSubprocess ptr) as gboolean
declare function g_subprocess_get_if_exited(byval subprocess as GSubprocess ptr) as gboolean
declare function g_subprocess_get_exit_status(byval subprocess as GSubprocess ptr) as gint
declare function g_subprocess_get_if_signaled(byval subprocess as GSubprocess ptr) as gboolean
declare function g_subprocess_get_term_sig(byval subprocess as GSubprocess ptr) as gint
declare function g_subprocess_communicate(byval subprocess as GSubprocess ptr, byval stdin_buf as GBytes ptr, byval cancellable as GCancellable ptr, byval stdout_buf as GBytes ptr ptr, byval stderr_buf as GBytes ptr ptr, byval error as GError ptr ptr) as gboolean
declare sub g_subprocess_communicate_async(byval subprocess as GSubprocess ptr, byval stdin_buf as GBytes ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_subprocess_communicate_finish(byval subprocess as GSubprocess ptr, byval result as GAsyncResult ptr, byval stdout_buf as GBytes ptr ptr, byval stderr_buf as GBytes ptr ptr, byval error as GError ptr ptr) as gboolean
declare function g_subprocess_communicate_utf8(byval subprocess as GSubprocess ptr, byval stdin_buf as const zstring ptr, byval cancellable as GCancellable ptr, byval stdout_buf as zstring ptr ptr, byval stderr_buf as zstring ptr ptr, byval error as GError ptr ptr) as gboolean
declare sub g_subprocess_communicate_utf8_async(byval subprocess as GSubprocess ptr, byval stdin_buf as const zstring ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_subprocess_communicate_utf8_finish(byval subprocess as GSubprocess ptr, byval result as GAsyncResult ptr, byval stdout_buf as zstring ptr ptr, byval stderr_buf as zstring ptr ptr, byval error as GError ptr ptr) as gboolean

#define __G_SUBPROCESS_LAUNCHER_H__
#define G_TYPE_SUBPROCESS_LAUNCHER g_subprocess_launcher_get_type()
#define G_SUBPROCESS_LAUNCHER(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_SUBPROCESS_LAUNCHER, GSubprocessLauncher)
#define G_IS_SUBPROCESS_LAUNCHER(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_SUBPROCESS_LAUNCHER)

declare function g_subprocess_launcher_get_type() as GType
declare function g_subprocess_launcher_new(byval flags as GSubprocessFlags) as GSubprocessLauncher ptr
declare function g_subprocess_launcher_spawn(byval self as GSubprocessLauncher ptr, byval error as GError ptr ptr, byval argv0 as const gchar ptr, ...) as GSubprocess ptr
declare function g_subprocess_launcher_spawnv(byval self as GSubprocessLauncher ptr, byval argv as const gchar const ptr ptr, byval error as GError ptr ptr) as GSubprocess ptr
declare sub g_subprocess_launcher_set_environ(byval self as GSubprocessLauncher ptr, byval env as gchar ptr ptr)
declare sub g_subprocess_launcher_setenv(byval self as GSubprocessLauncher ptr, byval variable as const gchar ptr, byval value as const gchar ptr, byval overwrite as gboolean)
declare sub g_subprocess_launcher_unsetenv(byval self as GSubprocessLauncher ptr, byval variable as const gchar ptr)
declare function g_subprocess_launcher_getenv(byval self as GSubprocessLauncher ptr, byval variable as const gchar ptr) as const gchar ptr
declare sub g_subprocess_launcher_set_cwd(byval self as GSubprocessLauncher ptr, byval cwd as const gchar ptr)
declare sub g_subprocess_launcher_set_flags(byval self as GSubprocessLauncher ptr, byval flags as GSubprocessFlags)

#ifdef __FB_UNIX__
	declare sub g_subprocess_launcher_set_stdin_file_path(byval self as GSubprocessLauncher ptr, byval path as const gchar ptr)
	declare sub g_subprocess_launcher_take_stdin_fd(byval self as GSubprocessLauncher ptr, byval fd as gint)
	declare sub g_subprocess_launcher_set_stdout_file_path(byval self as GSubprocessLauncher ptr, byval path as const gchar ptr)
	declare sub g_subprocess_launcher_take_stdout_fd(byval self as GSubprocessLauncher ptr, byval fd as gint)
	declare sub g_subprocess_launcher_set_stderr_file_path(byval self as GSubprocessLauncher ptr, byval path as const gchar ptr)
	declare sub g_subprocess_launcher_take_stderr_fd(byval self as GSubprocessLauncher ptr, byval fd as gint)
	declare sub g_subprocess_launcher_take_fd(byval self as GSubprocessLauncher ptr, byval source_fd as gint, byval target_fd as gint)
	declare sub g_subprocess_launcher_set_child_setup(byval self as GSubprocessLauncher ptr, byval child_setup as GSpawnChildSetupFunc, byval user_data as gpointer, byval destroy_notify as GDestroyNotify)
#endif

#define __G_TCP_CONNECTION_H__
#define G_TYPE_TCP_CONNECTION g_tcp_connection_get_type()
#define G_TCP_CONNECTION(inst) G_TYPE_CHECK_INSTANCE_CAST((inst), G_TYPE_TCP_CONNECTION, GTcpConnection)
#define G_TCP_CONNECTION_CLASS(class) G_TYPE_CHECK_CLASS_CAST((class), G_TYPE_TCP_CONNECTION, GTcpConnectionClass)
#define G_IS_TCP_CONNECTION(inst) G_TYPE_CHECK_INSTANCE_TYPE((inst), G_TYPE_TCP_CONNECTION)
#define G_IS_TCP_CONNECTION_CLASS(class) G_TYPE_CHECK_CLASS_TYPE((class), G_TYPE_TCP_CONNECTION)
#define G_TCP_CONNECTION_GET_CLASS(inst) G_TYPE_INSTANCE_GET_CLASS((inst), G_TYPE_TCP_CONNECTION, GTcpConnectionClass)
type GTcpConnectionPrivate as _GTcpConnectionPrivate
type GTcpConnectionClass as _GTcpConnectionClass

type _GTcpConnectionClass
	parent_class as GSocketConnectionClass
end type

type _GTcpConnection
	parent_instance as GSocketConnection
	priv as GTcpConnectionPrivate ptr
end type

declare function g_tcp_connection_get_type() as GType
declare sub g_tcp_connection_set_graceful_disconnect(byval connection as GTcpConnection ptr, byval graceful_disconnect as gboolean)
declare function g_tcp_connection_get_graceful_disconnect(byval connection as GTcpConnection ptr) as gboolean

#define __G_TCP_WRAPPER_CONNECTION_H__
#define G_TYPE_TCP_WRAPPER_CONNECTION g_tcp_wrapper_connection_get_type()
#define G_TCP_WRAPPER_CONNECTION(inst) G_TYPE_CHECK_INSTANCE_CAST((inst), G_TYPE_TCP_WRAPPER_CONNECTION, GTcpWrapperConnection)
#define G_TCP_WRAPPER_CONNECTION_CLASS(class) G_TYPE_CHECK_CLASS_CAST((class), G_TYPE_TCP_WRAPPER_CONNECTION, GTcpWrapperConnectionClass)
#define G_IS_TCP_WRAPPER_CONNECTION(inst) G_TYPE_CHECK_INSTANCE_TYPE((inst), G_TYPE_TCP_WRAPPER_CONNECTION)
#define G_IS_TCP_WRAPPER_CONNECTION_CLASS(class) G_TYPE_CHECK_CLASS_TYPE((class), G_TYPE_TCP_WRAPPER_CONNECTION)
#define G_TCP_WRAPPER_CONNECTION_GET_CLASS(inst) G_TYPE_INSTANCE_GET_CLASS((inst), G_TYPE_TCP_WRAPPER_CONNECTION, GTcpWrapperConnectionClass)
type GTcpWrapperConnectionPrivate as _GTcpWrapperConnectionPrivate
type GTcpWrapperConnectionClass as _GTcpWrapperConnectionClass

type _GTcpWrapperConnectionClass
	parent_class as GTcpConnectionClass
end type

type _GTcpWrapperConnection
	parent_instance as GTcpConnection
	priv as GTcpWrapperConnectionPrivate ptr
end type

declare function g_tcp_wrapper_connection_get_type() as GType
declare function g_tcp_wrapper_connection_new(byval base_io_stream as GIOStream ptr, byval socket as GSocket ptr) as GSocketConnection ptr
declare function g_tcp_wrapper_connection_get_base_io_stream(byval conn as GTcpWrapperConnection ptr) as GIOStream ptr

#define __G_TEST_DBUS_H__
#define G_TYPE_TEST_DBUS g_test_dbus_get_type()
#define G_TEST_DBUS(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), G_TYPE_TEST_DBUS, GTestDBus)
#define G_IS_TEST_DBUS(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), G_TYPE_TEST_DBUS)

declare function g_test_dbus_get_type() as GType
declare function g_test_dbus_new(byval flags as GTestDBusFlags) as GTestDBus ptr
declare function g_test_dbus_get_flags(byval self as GTestDBus ptr) as GTestDBusFlags
declare function g_test_dbus_get_bus_address(byval self as GTestDBus ptr) as const gchar ptr
declare sub g_test_dbus_add_service_dir(byval self as GTestDBus ptr, byval path as const gchar ptr)
declare sub g_test_dbus_up(byval self as GTestDBus ptr)
declare sub g_test_dbus_stop(byval self as GTestDBus ptr)
declare sub g_test_dbus_down(byval self as GTestDBus ptr)
declare sub g_test_dbus_unset()

#define __G_THEMED_ICON_H__
#define G_TYPE_THEMED_ICON g_themed_icon_get_type()
#define G_THEMED_ICON(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_THEMED_ICON, GThemedIcon)
#define G_THEMED_ICON_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_THEMED_ICON, GThemedIconClass)
#define G_IS_THEMED_ICON(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_THEMED_ICON)
#define G_IS_THEMED_ICON_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), G_TYPE_THEMED_ICON)
#define G_THEMED_ICON_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), G_TYPE_THEMED_ICON, GThemedIconClass)
type GThemedIconClass as _GThemedIconClass

declare function g_themed_icon_get_type() as GType
declare function g_themed_icon_new(byval iconname as const zstring ptr) as GIcon ptr
declare function g_themed_icon_new_with_default_fallbacks(byval iconname as const zstring ptr) as GIcon ptr
declare function g_themed_icon_new_from_names(byval iconnames as zstring ptr ptr, byval len as long) as GIcon ptr
declare sub g_themed_icon_prepend_name(byval icon as GThemedIcon ptr, byval iconname as const zstring ptr)
declare sub g_themed_icon_append_name(byval icon as GThemedIcon ptr, byval iconname as const zstring ptr)
declare function g_themed_icon_get_names(byval icon as GThemedIcon ptr) as const gchar const ptr ptr

#define __G_THREADED_SOCKET_SERVICE_H__
#define G_TYPE_THREADED_SOCKET_SERVICE g_threaded_socket_service_get_type()
#define G_THREADED_SOCKET_SERVICE(inst) G_TYPE_CHECK_INSTANCE_CAST((inst), G_TYPE_THREADED_SOCKET_SERVICE, GThreadedSocketService)
#define G_THREADED_SOCKET_SERVICE_CLASS(class) G_TYPE_CHECK_CLASS_CAST((class), G_TYPE_THREADED_SOCKET_SERVICE, GThreadedSocketServiceClass)
#define G_IS_THREADED_SOCKET_SERVICE(inst) G_TYPE_CHECK_INSTANCE_TYPE((inst), G_TYPE_THREADED_SOCKET_SERVICE)
#define G_IS_THREADED_SOCKET_SERVICE_CLASS(class) G_TYPE_CHECK_CLASS_TYPE((class), G_TYPE_THREADED_SOCKET_SERVICE)
#define G_THREADED_SOCKET_SERVICE_GET_CLASS(inst) G_TYPE_INSTANCE_GET_CLASS((inst), G_TYPE_THREADED_SOCKET_SERVICE, GThreadedSocketServiceClass)
type GThreadedSocketServicePrivate as _GThreadedSocketServicePrivate
type GThreadedSocketServiceClass as _GThreadedSocketServiceClass

type _GThreadedSocketServiceClass
	parent_class as GSocketServiceClass
	run as function(byval service as GThreadedSocketService ptr, byval connection as GSocketConnection ptr, byval source_object as GObject ptr) as gboolean
	_g_reserved1 as sub()
	_g_reserved2 as sub()
	_g_reserved3 as sub()
	_g_reserved4 as sub()
	_g_reserved5 as sub()
end type

type _GThreadedSocketService
	parent_instance as GSocketService
	priv as GThreadedSocketServicePrivate ptr
end type

declare function g_threaded_socket_service_get_type() as GType
declare function g_threaded_socket_service_new(byval max_threads as long) as GSocketService ptr
#define __G_TLS_BACKEND_H__
#define G_TLS_BACKEND_EXTENSION_POINT_NAME "gio-tls-backend"
#define G_TYPE_TLS_BACKEND g_tls_backend_get_type()
#define G_TLS_BACKEND(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), G_TYPE_TLS_BACKEND, GTlsBackend)
#define G_IS_TLS_BACKEND(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), G_TYPE_TLS_BACKEND)
#define G_TLS_BACKEND_GET_INTERFACE(obj) G_TYPE_INSTANCE_GET_INTERFACE((obj), G_TYPE_TLS_BACKEND, GTlsBackendInterface)
type GTlsBackend as _GTlsBackend
type GTlsBackendInterface as _GTlsBackendInterface

type _GTlsBackendInterface
	g_iface as GTypeInterface
	supports_tls as function(byval backend as GTlsBackend ptr) as gboolean
	get_certificate_type as function() as GType
	get_client_connection_type as function() as GType
	get_server_connection_type as function() as GType
	get_file_database_type as function() as GType
	get_default_database as function(byval backend as GTlsBackend ptr) as GTlsDatabase ptr
end type

declare function g_tls_backend_get_type() as GType
declare function g_tls_backend_get_default() as GTlsBackend ptr
declare function g_tls_backend_get_default_database(byval backend as GTlsBackend ptr) as GTlsDatabase ptr
declare function g_tls_backend_supports_tls(byval backend as GTlsBackend ptr) as gboolean
declare function g_tls_backend_get_certificate_type(byval backend as GTlsBackend ptr) as GType
declare function g_tls_backend_get_client_connection_type(byval backend as GTlsBackend ptr) as GType
declare function g_tls_backend_get_server_connection_type(byval backend as GTlsBackend ptr) as GType
declare function g_tls_backend_get_file_database_type(byval backend as GTlsBackend ptr) as GType

#define __G_TLS_CERTIFICATE_H__
#define G_TYPE_TLS_CERTIFICATE g_tls_certificate_get_type()
#define G_TLS_CERTIFICATE(inst) G_TYPE_CHECK_INSTANCE_CAST((inst), G_TYPE_TLS_CERTIFICATE, GTlsCertificate)
#define G_TLS_CERTIFICATE_CLASS(class) G_TYPE_CHECK_CLASS_CAST((class), G_TYPE_TLS_CERTIFICATE, GTlsCertificateClass)
#define G_IS_TLS_CERTIFICATE(inst) G_TYPE_CHECK_INSTANCE_TYPE((inst), G_TYPE_TLS_CERTIFICATE)
#define G_IS_TLS_CERTIFICATE_CLASS(class) G_TYPE_CHECK_CLASS_TYPE((class), G_TYPE_TLS_CERTIFICATE)
#define G_TLS_CERTIFICATE_GET_CLASS(inst) G_TYPE_INSTANCE_GET_CLASS((inst), G_TYPE_TLS_CERTIFICATE, GTlsCertificateClass)
type GTlsCertificateClass as _GTlsCertificateClass
type GTlsCertificatePrivate as _GTlsCertificatePrivate

type _GTlsCertificate
	parent_instance as GObject
	priv as GTlsCertificatePrivate ptr
end type

type _GTlsCertificateClass
	parent_class as GObjectClass
	verify as function(byval cert as GTlsCertificate ptr, byval identity as GSocketConnectable ptr, byval trusted_ca as GTlsCertificate ptr) as GTlsCertificateFlags
	padding(0 to 7) as gpointer
end type

declare function g_tls_certificate_get_type() as GType
declare function g_tls_certificate_new_from_pem(byval data as const gchar ptr, byval length as gssize, byval error as GError ptr ptr) as GTlsCertificate ptr
declare function g_tls_certificate_new_from_file(byval file as const gchar ptr, byval error as GError ptr ptr) as GTlsCertificate ptr
declare function g_tls_certificate_new_from_files(byval cert_file as const gchar ptr, byval key_file as const gchar ptr, byval error as GError ptr ptr) as GTlsCertificate ptr
declare function g_tls_certificate_list_new_from_file(byval file as const gchar ptr, byval error as GError ptr ptr) as GList ptr
declare function g_tls_certificate_get_issuer(byval cert as GTlsCertificate ptr) as GTlsCertificate ptr
declare function g_tls_certificate_verify(byval cert as GTlsCertificate ptr, byval identity as GSocketConnectable ptr, byval trusted_ca as GTlsCertificate ptr) as GTlsCertificateFlags
declare function g_tls_certificate_is_same(byval cert_one as GTlsCertificate ptr, byval cert_two as GTlsCertificate ptr) as gboolean

#define __G_TLS_CLIENT_CONNECTION_H__
#define __G_TLS_CONNECTION_H__
#define G_TYPE_TLS_CONNECTION g_tls_connection_get_type()
#define G_TLS_CONNECTION(inst) G_TYPE_CHECK_INSTANCE_CAST((inst), G_TYPE_TLS_CONNECTION, GTlsConnection)
#define G_TLS_CONNECTION_CLASS(class) G_TYPE_CHECK_CLASS_CAST((class), G_TYPE_TLS_CONNECTION, GTlsConnectionClass)
#define G_IS_TLS_CONNECTION(inst) G_TYPE_CHECK_INSTANCE_TYPE((inst), G_TYPE_TLS_CONNECTION)
#define G_IS_TLS_CONNECTION_CLASS(class) G_TYPE_CHECK_CLASS_TYPE((class), G_TYPE_TLS_CONNECTION)
#define G_TLS_CONNECTION_GET_CLASS(inst) G_TYPE_INSTANCE_GET_CLASS((inst), G_TYPE_TLS_CONNECTION, GTlsConnectionClass)
type GTlsConnectionClass as _GTlsConnectionClass
type GTlsConnectionPrivate as _GTlsConnectionPrivate

type _GTlsConnection
	parent_instance as GIOStream
	priv as GTlsConnectionPrivate ptr
end type

type _GTlsConnectionClass
	parent_class as GIOStreamClass
	accept_certificate as function(byval connection as GTlsConnection ptr, byval peer_cert as GTlsCertificate ptr, byval errors as GTlsCertificateFlags) as gboolean
	handshake as function(byval conn as GTlsConnection ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
	handshake_async as sub(byval conn as GTlsConnection ptr, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	handshake_finish as function(byval conn as GTlsConnection ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
	padding(0 to 7) as gpointer
end type

declare function g_tls_connection_get_type() as GType
declare sub g_tls_connection_set_use_system_certdb(byval conn as GTlsConnection ptr, byval use_system_certdb as gboolean)
declare function g_tls_connection_get_use_system_certdb(byval conn as GTlsConnection ptr) as gboolean
declare sub g_tls_connection_set_database(byval conn as GTlsConnection ptr, byval database as GTlsDatabase ptr)
declare function g_tls_connection_get_database(byval conn as GTlsConnection ptr) as GTlsDatabase ptr
declare sub g_tls_connection_set_certificate(byval conn as GTlsConnection ptr, byval certificate as GTlsCertificate ptr)
declare function g_tls_connection_get_certificate(byval conn as GTlsConnection ptr) as GTlsCertificate ptr
declare sub g_tls_connection_set_interaction(byval conn as GTlsConnection ptr, byval interaction as GTlsInteraction ptr)
declare function g_tls_connection_get_interaction(byval conn as GTlsConnection ptr) as GTlsInteraction ptr
declare function g_tls_connection_get_peer_certificate(byval conn as GTlsConnection ptr) as GTlsCertificate ptr
declare function g_tls_connection_get_peer_certificate_errors(byval conn as GTlsConnection ptr) as GTlsCertificateFlags
declare sub g_tls_connection_set_require_close_notify(byval conn as GTlsConnection ptr, byval require_close_notify as gboolean)
declare function g_tls_connection_get_require_close_notify(byval conn as GTlsConnection ptr) as gboolean
declare sub g_tls_connection_set_rehandshake_mode(byval conn as GTlsConnection ptr, byval mode as GTlsRehandshakeMode)
declare function g_tls_connection_get_rehandshake_mode(byval conn as GTlsConnection ptr) as GTlsRehandshakeMode
declare function g_tls_connection_handshake(byval conn as GTlsConnection ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
declare sub g_tls_connection_handshake_async(byval conn as GTlsConnection ptr, byval io_priority as long, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_tls_connection_handshake_finish(byval conn as GTlsConnection ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
#define G_TLS_ERROR g_tls_error_quark()
declare function g_tls_error_quark() as GQuark
declare function g_tls_connection_emit_accept_certificate(byval conn as GTlsConnection ptr, byval peer_cert as GTlsCertificate ptr, byval errors as GTlsCertificateFlags) as gboolean

#define G_TYPE_TLS_CLIENT_CONNECTION g_tls_client_connection_get_type()
#define G_TLS_CLIENT_CONNECTION(inst) G_TYPE_CHECK_INSTANCE_CAST((inst), G_TYPE_TLS_CLIENT_CONNECTION, GTlsClientConnection)
#define G_IS_TLS_CLIENT_CONNECTION(inst) G_TYPE_CHECK_INSTANCE_TYPE((inst), G_TYPE_TLS_CLIENT_CONNECTION)
#define G_TLS_CLIENT_CONNECTION_GET_INTERFACE(inst) G_TYPE_INSTANCE_GET_INTERFACE((inst), G_TYPE_TLS_CLIENT_CONNECTION, GTlsClientConnectionInterface)
type GTlsClientConnectionInterface as _GTlsClientConnectionInterface

type _GTlsClientConnectionInterface
	g_iface as GTypeInterface
end type

declare function g_tls_client_connection_get_type() as GType
declare function g_tls_client_connection_new(byval base_io_stream as GIOStream ptr, byval server_identity as GSocketConnectable ptr, byval error as GError ptr ptr) as GIOStream ptr
declare function g_tls_client_connection_get_validation_flags(byval conn as GTlsClientConnection ptr) as GTlsCertificateFlags
declare sub g_tls_client_connection_set_validation_flags(byval conn as GTlsClientConnection ptr, byval flags as GTlsCertificateFlags)
declare function g_tls_client_connection_get_server_identity(byval conn as GTlsClientConnection ptr) as GSocketConnectable ptr
declare sub g_tls_client_connection_set_server_identity(byval conn as GTlsClientConnection ptr, byval identity as GSocketConnectable ptr)
declare function g_tls_client_connection_get_use_ssl3(byval conn as GTlsClientConnection ptr) as gboolean
declare sub g_tls_client_connection_set_use_ssl3(byval conn as GTlsClientConnection ptr, byval use_ssl3 as gboolean)
declare function g_tls_client_connection_get_accepted_cas(byval conn as GTlsClientConnection ptr) as GList ptr

#define __G_TLS_DATABASE_H__
#define G_TLS_DATABASE_PURPOSE_AUTHENTICATE_SERVER "1.3.6.1.5.5.7.3.1"
#define G_TLS_DATABASE_PURPOSE_AUTHENTICATE_CLIENT "1.3.6.1.5.5.7.3.2"
#define G_TYPE_TLS_DATABASE g_tls_database_get_type()
#define G_TLS_DATABASE(inst) G_TYPE_CHECK_INSTANCE_CAST((inst), G_TYPE_TLS_DATABASE, GTlsDatabase)
#define G_TLS_DATABASE_CLASS(class) G_TYPE_CHECK_CLASS_CAST((class), G_TYPE_TLS_DATABASE, GTlsDatabaseClass)
#define G_IS_TLS_DATABASE(inst) G_TYPE_CHECK_INSTANCE_TYPE((inst), G_TYPE_TLS_DATABASE)
#define G_IS_TLS_DATABASE_CLASS(class) G_TYPE_CHECK_CLASS_TYPE((class), G_TYPE_TLS_DATABASE)
#define G_TLS_DATABASE_GET_CLASS(inst) G_TYPE_INSTANCE_GET_CLASS((inst), G_TYPE_TLS_DATABASE, GTlsDatabaseClass)
type GTlsDatabaseClass as _GTlsDatabaseClass
type GTlsDatabasePrivate as _GTlsDatabasePrivate

type _GTlsDatabase
	parent_instance as GObject
	priv as GTlsDatabasePrivate ptr
end type

type _GTlsDatabaseClass
	parent_class as GObjectClass
	verify_chain as function(byval self as GTlsDatabase ptr, byval chain as GTlsCertificate ptr, byval purpose as const gchar ptr, byval identity as GSocketConnectable ptr, byval interaction as GTlsInteraction ptr, byval flags as GTlsDatabaseVerifyFlags, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GTlsCertificateFlags
	verify_chain_async as sub(byval self as GTlsDatabase ptr, byval chain as GTlsCertificate ptr, byval purpose as const gchar ptr, byval identity as GSocketConnectable ptr, byval interaction as GTlsInteraction ptr, byval flags as GTlsDatabaseVerifyFlags, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	verify_chain_finish as function(byval self as GTlsDatabase ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as GTlsCertificateFlags
	create_certificate_handle as function(byval self as GTlsDatabase ptr, byval certificate as GTlsCertificate ptr) as gchar ptr
	lookup_certificate_for_handle as function(byval self as GTlsDatabase ptr, byval handle as const gchar ptr, byval interaction as GTlsInteraction ptr, byval flags as GTlsDatabaseLookupFlags, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GTlsCertificate ptr
	lookup_certificate_for_handle_async as sub(byval self as GTlsDatabase ptr, byval handle as const gchar ptr, byval interaction as GTlsInteraction ptr, byval flags as GTlsDatabaseLookupFlags, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	lookup_certificate_for_handle_finish as function(byval self as GTlsDatabase ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as GTlsCertificate ptr
	lookup_certificate_issuer as function(byval self as GTlsDatabase ptr, byval certificate as GTlsCertificate ptr, byval interaction as GTlsInteraction ptr, byval flags as GTlsDatabaseLookupFlags, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GTlsCertificate ptr
	lookup_certificate_issuer_async as sub(byval self as GTlsDatabase ptr, byval certificate as GTlsCertificate ptr, byval interaction as GTlsInteraction ptr, byval flags as GTlsDatabaseLookupFlags, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	lookup_certificate_issuer_finish as function(byval self as GTlsDatabase ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as GTlsCertificate ptr
	lookup_certificates_issued_by as function(byval self as GTlsDatabase ptr, byval issuer_raw_dn as GByteArray ptr, byval interaction as GTlsInteraction ptr, byval flags as GTlsDatabaseLookupFlags, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GList ptr
	lookup_certificates_issued_by_async as sub(byval self as GTlsDatabase ptr, byval issuer_raw_dn as GByteArray ptr, byval interaction as GTlsInteraction ptr, byval flags as GTlsDatabaseLookupFlags, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	lookup_certificates_issued_by_finish as function(byval self as GTlsDatabase ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as GList ptr
	padding(0 to 15) as gpointer
end type

declare function g_tls_database_get_type() as GType
declare function g_tls_database_verify_chain(byval self as GTlsDatabase ptr, byval chain as GTlsCertificate ptr, byval purpose as const gchar ptr, byval identity as GSocketConnectable ptr, byval interaction as GTlsInteraction ptr, byval flags as GTlsDatabaseVerifyFlags, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GTlsCertificateFlags
declare sub g_tls_database_verify_chain_async(byval self as GTlsDatabase ptr, byval chain as GTlsCertificate ptr, byval purpose as const gchar ptr, byval identity as GSocketConnectable ptr, byval interaction as GTlsInteraction ptr, byval flags as GTlsDatabaseVerifyFlags, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_tls_database_verify_chain_finish(byval self as GTlsDatabase ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as GTlsCertificateFlags
declare function g_tls_database_create_certificate_handle(byval self as GTlsDatabase ptr, byval certificate as GTlsCertificate ptr) as gchar ptr
declare function g_tls_database_lookup_certificate_for_handle(byval self as GTlsDatabase ptr, byval handle as const gchar ptr, byval interaction as GTlsInteraction ptr, byval flags as GTlsDatabaseLookupFlags, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GTlsCertificate ptr
declare sub g_tls_database_lookup_certificate_for_handle_async(byval self as GTlsDatabase ptr, byval handle as const gchar ptr, byval interaction as GTlsInteraction ptr, byval flags as GTlsDatabaseLookupFlags, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_tls_database_lookup_certificate_for_handle_finish(byval self as GTlsDatabase ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as GTlsCertificate ptr
declare function g_tls_database_lookup_certificate_issuer(byval self as GTlsDatabase ptr, byval certificate as GTlsCertificate ptr, byval interaction as GTlsInteraction ptr, byval flags as GTlsDatabaseLookupFlags, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GTlsCertificate ptr
declare sub g_tls_database_lookup_certificate_issuer_async(byval self as GTlsDatabase ptr, byval certificate as GTlsCertificate ptr, byval interaction as GTlsInteraction ptr, byval flags as GTlsDatabaseLookupFlags, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_tls_database_lookup_certificate_issuer_finish(byval self as GTlsDatabase ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as GTlsCertificate ptr
declare function g_tls_database_lookup_certificates_issued_by(byval self as GTlsDatabase ptr, byval issuer_raw_dn as GByteArray ptr, byval interaction as GTlsInteraction ptr, byval flags as GTlsDatabaseLookupFlags, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GList ptr
declare sub g_tls_database_lookup_certificates_issued_by_async(byval self as GTlsDatabase ptr, byval issuer_raw_dn as GByteArray ptr, byval interaction as GTlsInteraction ptr, byval flags as GTlsDatabaseLookupFlags, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_tls_database_lookup_certificates_issued_by_finish(byval self as GTlsDatabase ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as GList ptr

#define __G_TLS_FILE_DATABASE_H__
#define G_TYPE_TLS_FILE_DATABASE g_tls_file_database_get_type()
#define G_TLS_FILE_DATABASE(inst) G_TYPE_CHECK_INSTANCE_CAST((inst), G_TYPE_TLS_FILE_DATABASE, GTlsFileDatabase)
#define G_IS_TLS_FILE_DATABASE(inst) G_TYPE_CHECK_INSTANCE_TYPE((inst), G_TYPE_TLS_FILE_DATABASE)
#define G_TLS_FILE_DATABASE_GET_INTERFACE(inst) G_TYPE_INSTANCE_GET_INTERFACE((inst), G_TYPE_TLS_FILE_DATABASE, GTlsFileDatabaseInterface)
type GTlsFileDatabaseInterface as _GTlsFileDatabaseInterface

type _GTlsFileDatabaseInterface
	g_iface as GTypeInterface
	padding(0 to 7) as gpointer
end type

declare function g_tls_file_database_get_type() as GType
declare function g_tls_file_database_new(byval anchors as const gchar ptr, byval error as GError ptr ptr) as GTlsDatabase ptr
#define __G_TLS_INTERACTION_H__
#define G_TYPE_TLS_INTERACTION g_tls_interaction_get_type()
#define G_TLS_INTERACTION(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_TLS_INTERACTION, GTlsInteraction)
#define G_TLS_INTERACTION_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_TLS_INTERACTION, GTlsInteractionClass)
#define G_IS_TLS_INTERACTION(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_TLS_INTERACTION)
#define G_IS_TLS_INTERACTION_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), G_TYPE_TLS_INTERACTION)
#define G_TLS_INTERACTION_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), G_TYPE_TLS_INTERACTION, GTlsInteractionClass)
type GTlsInteractionClass as _GTlsInteractionClass
type GTlsInteractionPrivate as _GTlsInteractionPrivate

type _GTlsInteraction
	parent_instance as GObject
	priv as GTlsInteractionPrivate ptr
end type

type _GTlsInteractionClass
	parent_class as GObjectClass
	ask_password as function(byval interaction as GTlsInteraction ptr, byval password as GTlsPassword ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GTlsInteractionResult
	ask_password_async as sub(byval interaction as GTlsInteraction ptr, byval password as GTlsPassword ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	ask_password_finish as function(byval interaction as GTlsInteraction ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as GTlsInteractionResult
	request_certificate as function(byval interaction as GTlsInteraction ptr, byval connection as GTlsConnection ptr, byval flags as GTlsCertificateRequestFlags, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GTlsInteractionResult
	request_certificate_async as sub(byval interaction as GTlsInteraction ptr, byval connection as GTlsConnection ptr, byval flags as GTlsCertificateRequestFlags, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	request_certificate_finish as function(byval interaction as GTlsInteraction ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as GTlsInteractionResult
	padding(0 to 20) as gpointer
end type

declare function g_tls_interaction_get_type() as GType
declare function g_tls_interaction_invoke_ask_password(byval interaction as GTlsInteraction ptr, byval password as GTlsPassword ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GTlsInteractionResult
declare function g_tls_interaction_ask_password(byval interaction as GTlsInteraction ptr, byval password as GTlsPassword ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GTlsInteractionResult
declare sub g_tls_interaction_ask_password_async(byval interaction as GTlsInteraction ptr, byval password as GTlsPassword ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_tls_interaction_ask_password_finish(byval interaction as GTlsInteraction ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as GTlsInteractionResult
declare function g_tls_interaction_invoke_request_certificate(byval interaction as GTlsInteraction ptr, byval connection as GTlsConnection ptr, byval flags as GTlsCertificateRequestFlags, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GTlsInteractionResult
declare function g_tls_interaction_request_certificate(byval interaction as GTlsInteraction ptr, byval connection as GTlsConnection ptr, byval flags as GTlsCertificateRequestFlags, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GTlsInteractionResult
declare sub g_tls_interaction_request_certificate_async(byval interaction as GTlsInteraction ptr, byval connection as GTlsConnection ptr, byval flags as GTlsCertificateRequestFlags, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_tls_interaction_request_certificate_finish(byval interaction as GTlsInteraction ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as GTlsInteractionResult

#define __G_TLS_SERVER_CONNECTION_H__
#define G_TYPE_TLS_SERVER_CONNECTION g_tls_server_connection_get_type()
#define G_TLS_SERVER_CONNECTION(inst) G_TYPE_CHECK_INSTANCE_CAST((inst), G_TYPE_TLS_SERVER_CONNECTION, GTlsServerConnection)
#define G_IS_TLS_SERVER_CONNECTION(inst) G_TYPE_CHECK_INSTANCE_TYPE((inst), G_TYPE_TLS_SERVER_CONNECTION)
#define G_TLS_SERVER_CONNECTION_GET_INTERFACE(inst) G_TYPE_INSTANCE_GET_INTERFACE((inst), G_TYPE_TLS_SERVER_CONNECTION, GTlsServerConnectionInterface)
type GTlsServerConnectionInterface as _GTlsServerConnectionInterface

type _GTlsServerConnectionInterface
	g_iface as GTypeInterface
end type

declare function g_tls_server_connection_get_type() as GType
declare function g_tls_server_connection_new(byval base_io_stream as GIOStream ptr, byval certificate as GTlsCertificate ptr, byval error as GError ptr ptr) as GIOStream ptr
#define __G_TLS_PASSWORD_H__
#define G_TYPE_TLS_PASSWORD g_tls_password_get_type()
#define G_TLS_PASSWORD(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_TLS_PASSWORD, GTlsPassword)
#define G_TLS_PASSWORD_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_TLS_PASSWORD, GTlsPasswordClass)
#define G_IS_TLS_PASSWORD(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_TLS_PASSWORD)
#define G_IS_TLS_PASSWORD_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), G_TYPE_TLS_PASSWORD)
#define G_TLS_PASSWORD_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), G_TYPE_TLS_PASSWORD, GTlsPasswordClass)
type GTlsPasswordClass as _GTlsPasswordClass
type GTlsPasswordPrivate as _GTlsPasswordPrivate

type _GTlsPassword
	parent_instance as GObject
	priv as GTlsPasswordPrivate ptr
end type

type _GTlsPasswordClass
	parent_class as GObjectClass
	get_value as function(byval password as GTlsPassword ptr, byval length as gsize ptr) as const guchar ptr
	set_value as sub(byval password as GTlsPassword ptr, byval value as guchar ptr, byval length as gssize, byval destroy as GDestroyNotify)
	get_default_warning as function(byval password as GTlsPassword ptr) as const gchar ptr
	padding(0 to 3) as gpointer
end type

declare function g_tls_password_get_type() as GType
declare function g_tls_password_new(byval flags as GTlsPasswordFlags, byval description as const gchar ptr) as GTlsPassword ptr
declare function g_tls_password_get_value(byval password as GTlsPassword ptr, byval length as gsize ptr) as const guchar ptr
declare sub g_tls_password_set_value(byval password as GTlsPassword ptr, byval value as const guchar ptr, byval length as gssize)
declare sub g_tls_password_set_value_full(byval password as GTlsPassword ptr, byval value as guchar ptr, byval length as gssize, byval destroy as GDestroyNotify)
declare function g_tls_password_get_flags(byval password as GTlsPassword ptr) as GTlsPasswordFlags
declare sub g_tls_password_set_flags(byval password as GTlsPassword ptr, byval flags as GTlsPasswordFlags)
declare function g_tls_password_get_description(byval password as GTlsPassword ptr) as const gchar ptr
declare sub g_tls_password_set_description(byval password as GTlsPassword ptr, byval description as const gchar ptr)
declare function g_tls_password_get_warning(byval password as GTlsPassword ptr) as const gchar ptr
declare sub g_tls_password_set_warning(byval password as GTlsPassword ptr, byval warning as const gchar ptr)

#define __G_VFS_H__
#define G_TYPE_VFS g_vfs_get_type()
#define G_VFS(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_VFS, GVfs)
#define G_VFS_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_VFS, GVfsClass)
#define G_VFS_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), G_TYPE_VFS, GVfsClass)
#define G_IS_VFS(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_VFS)
#define G_IS_VFS_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), G_TYPE_VFS)
#define G_VFS_EXTENSION_POINT_NAME "gio-vfs"
type GVfsClass as _GVfsClass

type _GVfs
	parent_instance as GObject
end type

type _GVfsClass
	parent_class as GObjectClass
	is_active as function(byval vfs as GVfs ptr) as gboolean
	get_file_for_path as function(byval vfs as GVfs ptr, byval path as const zstring ptr) as GFile ptr
	get_file_for_uri as function(byval vfs as GVfs ptr, byval uri as const zstring ptr) as GFile ptr
	get_supported_uri_schemes as function(byval vfs as GVfs ptr) as const gchar const ptr ptr
	parse_name as function(byval vfs as GVfs ptr, byval parse_name as const zstring ptr) as GFile ptr
	local_file_add_info as sub(byval vfs as GVfs ptr, byval filename as const zstring ptr, byval device as guint64, byval attribute_matcher as GFileAttributeMatcher ptr, byval info as GFileInfo ptr, byval cancellable as GCancellable ptr, byval extra_data as gpointer ptr, byval free_extra_data as GDestroyNotify ptr)
	add_writable_namespaces as sub(byval vfs as GVfs ptr, byval list as GFileAttributeInfoList ptr)
	local_file_set_attributes as function(byval vfs as GVfs ptr, byval filename as const zstring ptr, byval info as GFileInfo ptr, byval flags as GFileQueryInfoFlags, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as gboolean
	local_file_removed as sub(byval vfs as GVfs ptr, byval filename as const zstring ptr)
	local_file_moved as sub(byval vfs as GVfs ptr, byval source as const zstring ptr, byval dest as const zstring ptr)
	deserialize_icon as function(byval vfs as GVfs ptr, byval value as GVariant ptr) as GIcon ptr
	_g_reserved1 as sub()
	_g_reserved2 as sub()
	_g_reserved3 as sub()
	_g_reserved4 as sub()
	_g_reserved5 as sub()
	_g_reserved6 as sub()
end type

declare function g_vfs_get_type() as GType
declare function g_vfs_is_active(byval vfs as GVfs ptr) as gboolean
declare function g_vfs_get_file_for_path(byval vfs as GVfs ptr, byval path as const zstring ptr) as GFile ptr
declare function g_vfs_get_file_for_uri(byval vfs as GVfs ptr, byval uri as const zstring ptr) as GFile ptr
declare function g_vfs_get_supported_uri_schemes(byval vfs as GVfs ptr) as const gchar const ptr ptr
declare function g_vfs_parse_name(byval vfs as GVfs ptr, byval parse_name as const zstring ptr) as GFile ptr
declare function g_vfs_get_default() as GVfs ptr
declare function g_vfs_get_local() as GVfs ptr

#define __G_VOLUME_H__
#define G_VOLUME_IDENTIFIER_KIND_HAL_UDI "hal-udi"
#define G_VOLUME_IDENTIFIER_KIND_UNIX_DEVICE "unix-device"
#define G_VOLUME_IDENTIFIER_KIND_LABEL "label"
#define G_VOLUME_IDENTIFIER_KIND_UUID "uuid"
#define G_VOLUME_IDENTIFIER_KIND_NFS_MOUNT "nfs-mount"
#define G_VOLUME_IDENTIFIER_KIND_CLASS "class"
#define G_TYPE_VOLUME g_volume_get_type()
#define G_VOLUME(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), G_TYPE_VOLUME, GVolume)
#define G_IS_VOLUME(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), G_TYPE_VOLUME)
#define G_VOLUME_GET_IFACE(obj) G_TYPE_INSTANCE_GET_INTERFACE((obj), G_TYPE_VOLUME, GVolumeIface)
type GVolumeIface as _GVolumeIface

type _GVolumeIface
	g_iface as GTypeInterface
	changed as sub(byval volume as GVolume ptr)
	removed as sub(byval volume as GVolume ptr)
	get_name as function(byval volume as GVolume ptr) as zstring ptr
	get_icon as function(byval volume as GVolume ptr) as GIcon ptr
	get_uuid as function(byval volume as GVolume ptr) as zstring ptr
	get_drive as function(byval volume as GVolume ptr) as GDrive ptr
	get_mount as function(byval volume as GVolume ptr) as GMount ptr
	can_mount as function(byval volume as GVolume ptr) as gboolean
	can_eject as function(byval volume as GVolume ptr) as gboolean
	mount_fn as sub(byval volume as GVolume ptr, byval flags as GMountMountFlags, byval mount_operation as GMountOperation ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	mount_finish as function(byval volume as GVolume ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
	eject as sub(byval volume as GVolume ptr, byval flags as GMountUnmountFlags, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	eject_finish as function(byval volume as GVolume ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
	get_identifier as function(byval volume as GVolume ptr, byval kind as const zstring ptr) as zstring ptr
	enumerate_identifiers as function(byval volume as GVolume ptr) as zstring ptr ptr
	should_automount as function(byval volume as GVolume ptr) as gboolean
	get_activation_root as function(byval volume as GVolume ptr) as GFile ptr
	eject_with_operation as sub(byval volume as GVolume ptr, byval flags as GMountUnmountFlags, byval mount_operation as GMountOperation ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
	eject_with_operation_finish as function(byval volume as GVolume ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
	get_sort_key as function(byval volume as GVolume ptr) as const gchar ptr
	get_symbolic_icon as function(byval volume as GVolume ptr) as GIcon ptr
end type

declare function g_volume_get_type() as GType
declare function g_volume_get_name(byval volume as GVolume ptr) as zstring ptr
declare function g_volume_get_icon(byval volume as GVolume ptr) as GIcon ptr
declare function g_volume_get_symbolic_icon(byval volume as GVolume ptr) as GIcon ptr
declare function g_volume_get_uuid(byval volume as GVolume ptr) as zstring ptr
declare function g_volume_get_drive(byval volume as GVolume ptr) as GDrive ptr
declare function g_volume_get_mount(byval volume as GVolume ptr) as GMount ptr
declare function g_volume_can_mount(byval volume as GVolume ptr) as gboolean
declare function g_volume_can_eject(byval volume as GVolume ptr) as gboolean
declare function g_volume_should_automount(byval volume as GVolume ptr) as gboolean
declare sub g_volume_mount(byval volume as GVolume ptr, byval flags as GMountMountFlags, byval mount_operation as GMountOperation ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_volume_mount_finish(byval volume as GVolume ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
declare sub g_volume_eject(byval volume as GVolume ptr, byval flags as GMountUnmountFlags, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_volume_eject_finish(byval volume as GVolume ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
declare function g_volume_get_identifier(byval volume as GVolume ptr, byval kind as const zstring ptr) as zstring ptr
declare function g_volume_enumerate_identifiers(byval volume as GVolume ptr) as zstring ptr ptr
declare function g_volume_get_activation_root(byval volume as GVolume ptr) as GFile ptr
declare sub g_volume_eject_with_operation(byval volume as GVolume ptr, byval flags as GMountUnmountFlags, byval mount_operation as GMountOperation ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_volume_eject_with_operation_finish(byval volume as GVolume ptr, byval result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
declare function g_volume_get_sort_key(byval volume as GVolume ptr) as const gchar ptr

#define __G_ZLIB_COMPRESSOR_H__
#define G_TYPE_ZLIB_COMPRESSOR g_zlib_compressor_get_type()
#define G_ZLIB_COMPRESSOR(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_ZLIB_COMPRESSOR, GZlibCompressor)
#define G_ZLIB_COMPRESSOR_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_ZLIB_COMPRESSOR, GZlibCompressorClass)
#define G_IS_ZLIB_COMPRESSOR(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_ZLIB_COMPRESSOR)
#define G_IS_ZLIB_COMPRESSOR_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), G_TYPE_ZLIB_COMPRESSOR)
#define G_ZLIB_COMPRESSOR_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), G_TYPE_ZLIB_COMPRESSOR, GZlibCompressorClass)
type GZlibCompressorClass as _GZlibCompressorClass

type _GZlibCompressorClass
	parent_class as GObjectClass
end type

declare function g_zlib_compressor_get_type() as GType
declare function g_zlib_compressor_new(byval format as GZlibCompressorFormat, byval level as long) as GZlibCompressor ptr
declare function g_zlib_compressor_get_file_info(byval compressor as GZlibCompressor ptr) as GFileInfo ptr
declare sub g_zlib_compressor_set_file_info(byval compressor as GZlibCompressor ptr, byval file_info as GFileInfo ptr)

#define __G_ZLIB_DECOMPRESSOR_H__
#define G_TYPE_ZLIB_DECOMPRESSOR g_zlib_decompressor_get_type()
#define G_ZLIB_DECOMPRESSOR(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_ZLIB_DECOMPRESSOR, GZlibDecompressor)
#define G_ZLIB_DECOMPRESSOR_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_ZLIB_DECOMPRESSOR, GZlibDecompressorClass)
#define G_IS_ZLIB_DECOMPRESSOR(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_ZLIB_DECOMPRESSOR)
#define G_IS_ZLIB_DECOMPRESSOR_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), G_TYPE_ZLIB_DECOMPRESSOR)
#define G_ZLIB_DECOMPRESSOR_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), G_TYPE_ZLIB_DECOMPRESSOR, GZlibDecompressorClass)
type GZlibDecompressorClass as _GZlibDecompressorClass

type _GZlibDecompressorClass
	parent_class as GObjectClass
end type

declare function g_zlib_decompressor_get_type() as GType
declare function g_zlib_decompressor_new(byval format as GZlibCompressorFormat) as GZlibDecompressor ptr
declare function g_zlib_decompressor_get_file_info(byval decompressor as GZlibDecompressor ptr) as GFileInfo ptr

#define __G_DBUS_INTERFACE_H__
#define G_TYPE_DBUS_INTERFACE g_dbus_interface_get_type()
#define G_DBUS_INTERFACE(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_DBUS_INTERFACE, GDBusInterface)
#define G_IS_DBUS_INTERFACE(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_DBUS_INTERFACE)
#define G_DBUS_INTERFACE_GET_IFACE(o) G_TYPE_INSTANCE_GET_INTERFACE((o), G_TYPE_DBUS_INTERFACE, GDBusInterfaceIface)
type GDBusInterfaceIface as _GDBusInterfaceIface

type _GDBusInterfaceIface
	parent_iface as GTypeInterface
	get_info as function(byval interface_ as GDBusInterface ptr) as GDBusInterfaceInfo ptr
	get_object as function(byval interface_ as GDBusInterface ptr) as GDBusObject ptr
	set_object as sub(byval interface_ as GDBusInterface ptr, byval object as GDBusObject ptr)
	dup_object as function(byval interface_ as GDBusInterface ptr) as GDBusObject ptr
end type

declare function g_dbus_interface_get_type() as GType
declare function g_dbus_interface_get_info(byval interface_ as GDBusInterface ptr) as GDBusInterfaceInfo ptr
declare function g_dbus_interface_get_object(byval interface_ as GDBusInterface ptr) as GDBusObject ptr
declare sub g_dbus_interface_set_object(byval interface_ as GDBusInterface ptr, byval object as GDBusObject ptr)
declare function g_dbus_interface_dup_object(byval interface_ as GDBusInterface ptr) as GDBusObject ptr

#define __G_DBUS_INTERFACE_SKELETON_H__
#define G_TYPE_DBUS_INTERFACE_SKELETON g_dbus_interface_skeleton_get_type()
#define G_DBUS_INTERFACE_SKELETON(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_DBUS_INTERFACE_SKELETON, GDBusInterfaceSkeleton)
#define G_DBUS_INTERFACE_SKELETON_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_DBUS_INTERFACE_SKELETON, GDBusInterfaceSkeletonClass)
#define G_DBUS_INTERFACE_SKELETON_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), G_TYPE_DBUS_INTERFACE_SKELETON, GDBusInterfaceSkeletonClass)
#define G_IS_DBUS_INTERFACE_SKELETON(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_DBUS_INTERFACE_SKELETON)
#define G_IS_DBUS_INTERFACE_SKELETON_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), G_TYPE_DBUS_INTERFACE_SKELETON)
type GDBusInterfaceSkeletonClass as _GDBusInterfaceSkeletonClass
type GDBusInterfaceSkeletonPrivate as _GDBusInterfaceSkeletonPrivate

type _GDBusInterfaceSkeleton
	parent_instance as GObject
	priv as GDBusInterfaceSkeletonPrivate ptr
end type

type _GDBusInterfaceSkeletonClass
	parent_class as GObjectClass
	get_info as function(byval interface_ as GDBusInterfaceSkeleton ptr) as GDBusInterfaceInfo ptr
	get_vtable as function(byval interface_ as GDBusInterfaceSkeleton ptr) as GDBusInterfaceVTable ptr
	get_properties as function(byval interface_ as GDBusInterfaceSkeleton ptr) as GVariant ptr
	flush as sub(byval interface_ as GDBusInterfaceSkeleton ptr)
	vfunc_padding(0 to 7) as gpointer
	g_authorize_method as function(byval interface_ as GDBusInterfaceSkeleton ptr, byval invocation as GDBusMethodInvocation ptr) as gboolean
	signal_padding(0 to 7) as gpointer
end type

declare function g_dbus_interface_skeleton_get_type() as GType
declare function g_dbus_interface_skeleton_get_flags(byval interface_ as GDBusInterfaceSkeleton ptr) as GDBusInterfaceSkeletonFlags
declare sub g_dbus_interface_skeleton_set_flags(byval interface_ as GDBusInterfaceSkeleton ptr, byval flags as GDBusInterfaceSkeletonFlags)
declare function g_dbus_interface_skeleton_get_info(byval interface_ as GDBusInterfaceSkeleton ptr) as GDBusInterfaceInfo ptr
declare function g_dbus_interface_skeleton_get_vtable(byval interface_ as GDBusInterfaceSkeleton ptr) as GDBusInterfaceVTable ptr
declare function g_dbus_interface_skeleton_get_properties(byval interface_ as GDBusInterfaceSkeleton ptr) as GVariant ptr
declare sub g_dbus_interface_skeleton_flush(byval interface_ as GDBusInterfaceSkeleton ptr)
declare function g_dbus_interface_skeleton_export(byval interface_ as GDBusInterfaceSkeleton ptr, byval connection as GDBusConnection ptr, byval object_path as const gchar ptr, byval error as GError ptr ptr) as gboolean
declare sub g_dbus_interface_skeleton_unexport(byval interface_ as GDBusInterfaceSkeleton ptr)
declare sub g_dbus_interface_skeleton_unexport_from_connection(byval interface_ as GDBusInterfaceSkeleton ptr, byval connection as GDBusConnection ptr)
declare function g_dbus_interface_skeleton_get_connection(byval interface_ as GDBusInterfaceSkeleton ptr) as GDBusConnection ptr
declare function g_dbus_interface_skeleton_get_connections(byval interface_ as GDBusInterfaceSkeleton ptr) as GList ptr
declare function g_dbus_interface_skeleton_has_connection(byval interface_ as GDBusInterfaceSkeleton ptr, byval connection as GDBusConnection ptr) as gboolean
declare function g_dbus_interface_skeleton_get_object_path(byval interface_ as GDBusInterfaceSkeleton ptr) as const gchar ptr

#define __G_DBUS_OBJECT_H__
#define G_TYPE_DBUS_OBJECT g_dbus_object_get_type()
#define G_DBUS_OBJECT(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_DBUS_OBJECT, GDBusObject)
#define G_IS_DBUS_OBJECT(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_DBUS_OBJECT)
#define G_DBUS_OBJECT_GET_IFACE(o) G_TYPE_INSTANCE_GET_INTERFACE((o), G_TYPE_DBUS_OBJECT, GDBusObjectIface)
type GDBusObjectIface as _GDBusObjectIface

type _GDBusObjectIface
	parent_iface as GTypeInterface
	get_object_path as function(byval object as GDBusObject ptr) as const gchar ptr
	get_interfaces as function(byval object as GDBusObject ptr) as GList ptr
	get_interface as function(byval object as GDBusObject ptr, byval interface_name as const gchar ptr) as GDBusInterface ptr
	interface_added as sub(byval object as GDBusObject ptr, byval interface_ as GDBusInterface ptr)
	interface_removed as sub(byval object as GDBusObject ptr, byval interface_ as GDBusInterface ptr)
end type

declare function g_dbus_object_get_type() as GType
declare function g_dbus_object_get_object_path(byval object as GDBusObject ptr) as const gchar ptr
declare function g_dbus_object_get_interfaces(byval object as GDBusObject ptr) as GList ptr
declare function g_dbus_object_get_interface(byval object as GDBusObject ptr, byval interface_name as const gchar ptr) as GDBusInterface ptr

#define __G_DBUS_OBJECT_SKELETON_H__
#define G_TYPE_DBUS_OBJECT_SKELETON g_dbus_object_skeleton_get_type()
#define G_DBUS_OBJECT_SKELETON(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_DBUS_OBJECT_SKELETON, GDBusObjectSkeleton)
#define G_DBUS_OBJECT_SKELETON_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_DBUS_OBJECT_SKELETON, GDBusObjectSkeletonClass)
#define G_DBUS_OBJECT_SKELETON_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), G_TYPE_DBUS_OBJECT_SKELETON, GDBusObjectSkeletonClass)
#define G_IS_DBUS_OBJECT_SKELETON(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_DBUS_OBJECT_SKELETON)
#define G_IS_DBUS_OBJECT_SKELETON_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), G_TYPE_DBUS_OBJECT_SKELETON)
type GDBusObjectSkeletonClass as _GDBusObjectSkeletonClass
type GDBusObjectSkeletonPrivate as _GDBusObjectSkeletonPrivate

type _GDBusObjectSkeleton
	parent_instance as GObject
	priv as GDBusObjectSkeletonPrivate ptr
end type

type _GDBusObjectSkeletonClass
	parent_class as GObjectClass
	authorize_method as function(byval object as GDBusObjectSkeleton ptr, byval interface_ as GDBusInterfaceSkeleton ptr, byval invocation as GDBusMethodInvocation ptr) as gboolean
	padding(0 to 7) as gpointer
end type

declare function g_dbus_object_skeleton_get_type() as GType
declare function g_dbus_object_skeleton_new(byval object_path as const gchar ptr) as GDBusObjectSkeleton ptr
declare sub g_dbus_object_skeleton_flush(byval object as GDBusObjectSkeleton ptr)
declare sub g_dbus_object_skeleton_add_interface(byval object as GDBusObjectSkeleton ptr, byval interface_ as GDBusInterfaceSkeleton ptr)
declare sub g_dbus_object_skeleton_remove_interface(byval object as GDBusObjectSkeleton ptr, byval interface_ as GDBusInterfaceSkeleton ptr)
declare sub g_dbus_object_skeleton_remove_interface_by_name(byval object as GDBusObjectSkeleton ptr, byval interface_name as const gchar ptr)
declare sub g_dbus_object_skeleton_set_object_path(byval object as GDBusObjectSkeleton ptr, byval object_path as const gchar ptr)

#define __G_DBUS_OBJECT_PROXY_H__
#define G_TYPE_DBUS_OBJECT_PROXY g_dbus_object_proxy_get_type()
#define G_DBUS_OBJECT_PROXY(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_DBUS_OBJECT_PROXY, GDBusObjectProxy)
#define G_DBUS_OBJECT_PROXY_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_DBUS_OBJECT_PROXY, GDBusObjectProxyClass)
#define G_DBUS_OBJECT_PROXY_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), G_TYPE_DBUS_OBJECT_PROXY, GDBusObjectProxyClass)
#define G_IS_DBUS_OBJECT_PROXY(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_DBUS_OBJECT_PROXY)
#define G_IS_DBUS_OBJECT_PROXY_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), G_TYPE_DBUS_OBJECT_PROXY)
type GDBusObjectProxyClass as _GDBusObjectProxyClass
type GDBusObjectProxyPrivate as _GDBusObjectProxyPrivate

type _GDBusObjectProxy
	parent_instance as GObject
	priv as GDBusObjectProxyPrivate ptr
end type

type _GDBusObjectProxyClass
	parent_class as GObjectClass
	padding(0 to 7) as gpointer
end type

declare function g_dbus_object_proxy_get_type() as GType
declare function g_dbus_object_proxy_new(byval connection as GDBusConnection ptr, byval object_path as const gchar ptr) as GDBusObjectProxy ptr
declare function g_dbus_object_proxy_get_connection(byval proxy as GDBusObjectProxy ptr) as GDBusConnection ptr

#define __G_DBUS_OBJECT_MANAGER_H__
#define G_TYPE_DBUS_OBJECT_MANAGER g_dbus_object_manager_get_type()
#define G_DBUS_OBJECT_MANAGER(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_DBUS_OBJECT_MANAGER, GDBusObjectManager)
#define G_IS_DBUS_OBJECT_MANAGER(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_DBUS_OBJECT_MANAGER)
#define G_DBUS_OBJECT_MANAGER_GET_IFACE(o) G_TYPE_INSTANCE_GET_INTERFACE((o), G_TYPE_DBUS_OBJECT_MANAGER, GDBusObjectManagerIface)
type GDBusObjectManagerIface as _GDBusObjectManagerIface

type _GDBusObjectManagerIface
	parent_iface as GTypeInterface
	get_object_path as function(byval manager as GDBusObjectManager ptr) as const gchar ptr
	get_objects as function(byval manager as GDBusObjectManager ptr) as GList ptr
	get_object as function(byval manager as GDBusObjectManager ptr, byval object_path as const gchar ptr) as GDBusObject ptr
	get_interface as function(byval manager as GDBusObjectManager ptr, byval object_path as const gchar ptr, byval interface_name as const gchar ptr) as GDBusInterface ptr
	object_added as sub(byval manager as GDBusObjectManager ptr, byval object as GDBusObject ptr)
	object_removed as sub(byval manager as GDBusObjectManager ptr, byval object as GDBusObject ptr)
	interface_added as sub(byval manager as GDBusObjectManager ptr, byval object as GDBusObject ptr, byval interface_ as GDBusInterface ptr)
	interface_removed as sub(byval manager as GDBusObjectManager ptr, byval object as GDBusObject ptr, byval interface_ as GDBusInterface ptr)
end type

declare function g_dbus_object_manager_get_type() as GType
declare function g_dbus_object_manager_get_object_path(byval manager as GDBusObjectManager ptr) as const gchar ptr
declare function g_dbus_object_manager_get_objects(byval manager as GDBusObjectManager ptr) as GList ptr
declare function g_dbus_object_manager_get_object(byval manager as GDBusObjectManager ptr, byval object_path as const gchar ptr) as GDBusObject ptr
declare function g_dbus_object_manager_get_interface(byval manager as GDBusObjectManager ptr, byval object_path as const gchar ptr, byval interface_name as const gchar ptr) as GDBusInterface ptr

#define __G_DBUS_OBJECT_MANAGER_CLIENT_H__
#define G_TYPE_DBUS_OBJECT_MANAGER_CLIENT g_dbus_object_manager_client_get_type()
#define G_DBUS_OBJECT_MANAGER_CLIENT(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_DBUS_OBJECT_MANAGER_CLIENT, GDBusObjectManagerClient)
#define G_DBUS_OBJECT_MANAGER_CLIENT_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_DBUS_OBJECT_MANAGER_CLIENT, GDBusObjectManagerClientClass)
#define G_DBUS_OBJECT_MANAGER_CLIENT_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), G_TYPE_DBUS_OBJECT_MANAGER_CLIENT, GDBusObjectManagerClientClass)
#define G_IS_DBUS_OBJECT_MANAGER_CLIENT(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_DBUS_OBJECT_MANAGER_CLIENT)
#define G_IS_DBUS_OBJECT_MANAGER_CLIENT_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), G_TYPE_DBUS_OBJECT_MANAGER_CLIENT)
type GDBusObjectManagerClientClass as _GDBusObjectManagerClientClass
type GDBusObjectManagerClientPrivate as _GDBusObjectManagerClientPrivate

type _GDBusObjectManagerClient
	parent_instance as GObject
	priv as GDBusObjectManagerClientPrivate ptr
end type

type _GDBusObjectManagerClientClass
	parent_class as GObjectClass
	interface_proxy_signal as sub(byval manager as GDBusObjectManagerClient ptr, byval object_proxy as GDBusObjectProxy ptr, byval interface_proxy as GDBusProxy ptr, byval sender_name as const gchar ptr, byval signal_name as const gchar ptr, byval parameters as GVariant ptr)
	interface_proxy_properties_changed as sub(byval manager as GDBusObjectManagerClient ptr, byval object_proxy as GDBusObjectProxy ptr, byval interface_proxy as GDBusProxy ptr, byval changed_properties as GVariant ptr, byval invalidated_properties as const gchar const ptr ptr)
	padding(0 to 7) as gpointer
end type

declare function g_dbus_object_manager_client_get_type() as GType
declare sub g_dbus_object_manager_client_new(byval connection as GDBusConnection ptr, byval flags as GDBusObjectManagerClientFlags, byval name as const gchar ptr, byval object_path as const gchar ptr, byval get_proxy_type_func as GDBusProxyTypeFunc, byval get_proxy_type_user_data as gpointer, byval get_proxy_type_destroy_notify as GDestroyNotify, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_dbus_object_manager_client_new_finish(byval res as GAsyncResult ptr, byval error as GError ptr ptr) as GDBusObjectManager ptr
declare function g_dbus_object_manager_client_new_sync(byval connection as GDBusConnection ptr, byval flags as GDBusObjectManagerClientFlags, byval name as const gchar ptr, byval object_path as const gchar ptr, byval get_proxy_type_func as GDBusProxyTypeFunc, byval get_proxy_type_user_data as gpointer, byval get_proxy_type_destroy_notify as GDestroyNotify, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GDBusObjectManager ptr
declare sub g_dbus_object_manager_client_new_for_bus(byval bus_type as GBusType, byval flags as GDBusObjectManagerClientFlags, byval name as const gchar ptr, byval object_path as const gchar ptr, byval get_proxy_type_func as GDBusProxyTypeFunc, byval get_proxy_type_user_data as gpointer, byval get_proxy_type_destroy_notify as GDestroyNotify, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function g_dbus_object_manager_client_new_for_bus_finish(byval res as GAsyncResult ptr, byval error as GError ptr ptr) as GDBusObjectManager ptr
declare function g_dbus_object_manager_client_new_for_bus_sync(byval bus_type as GBusType, byval flags as GDBusObjectManagerClientFlags, byval name as const gchar ptr, byval object_path as const gchar ptr, byval get_proxy_type_func as GDBusProxyTypeFunc, byval get_proxy_type_user_data as gpointer, byval get_proxy_type_destroy_notify as GDestroyNotify, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GDBusObjectManager ptr
declare function g_dbus_object_manager_client_get_connection(byval manager as GDBusObjectManagerClient ptr) as GDBusConnection ptr
declare function g_dbus_object_manager_client_get_flags(byval manager as GDBusObjectManagerClient ptr) as GDBusObjectManagerClientFlags
declare function g_dbus_object_manager_client_get_name(byval manager as GDBusObjectManagerClient ptr) as const gchar ptr
declare function g_dbus_object_manager_client_get_name_owner(byval manager as GDBusObjectManagerClient ptr) as gchar ptr

#define __G_DBUS_OBJECT_MANAGER_SERVER_H__
#define G_TYPE_DBUS_OBJECT_MANAGER_SERVER g_dbus_object_manager_server_get_type()
#define G_DBUS_OBJECT_MANAGER_SERVER(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_DBUS_OBJECT_MANAGER_SERVER, GDBusObjectManagerServer)
#define G_DBUS_OBJECT_MANAGER_SERVER_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_DBUS_OBJECT_MANAGER_SERVER, GDBusObjectManagerServerClass)
#define G_DBUS_OBJECT_MANAGER_SERVER_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), G_TYPE_DBUS_OBJECT_MANAGER_SERVER, GDBusObjectManagerServerClass)
#define G_IS_DBUS_OBJECT_MANAGER_SERVER(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_DBUS_OBJECT_MANAGER_SERVER)
#define G_IS_DBUS_OBJECT_MANAGER_SERVER_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), G_TYPE_DBUS_OBJECT_MANAGER_SERVER)
type GDBusObjectManagerServerClass as _GDBusObjectManagerServerClass
type GDBusObjectManagerServerPrivate as _GDBusObjectManagerServerPrivate

type _GDBusObjectManagerServer
	parent_instance as GObject
	priv as GDBusObjectManagerServerPrivate ptr
end type

type _GDBusObjectManagerServerClass
	parent_class as GObjectClass
	padding(0 to 7) as gpointer
end type

declare function g_dbus_object_manager_server_get_type() as GType
declare function g_dbus_object_manager_server_new(byval object_path as const gchar ptr) as GDBusObjectManagerServer ptr
declare function g_dbus_object_manager_server_get_connection(byval manager as GDBusObjectManagerServer ptr) as GDBusConnection ptr
declare sub g_dbus_object_manager_server_set_connection(byval manager as GDBusObjectManagerServer ptr, byval connection as GDBusConnection ptr)
declare sub g_dbus_object_manager_server_export(byval manager as GDBusObjectManagerServer ptr, byval object as GDBusObjectSkeleton ptr)
declare sub g_dbus_object_manager_server_export_uniquely(byval manager as GDBusObjectManagerServer ptr, byval object as GDBusObjectSkeleton ptr)
declare function g_dbus_object_manager_server_is_exported(byval manager as GDBusObjectManagerServer ptr, byval object as GDBusObjectSkeleton ptr) as gboolean
declare function g_dbus_object_manager_server_unexport(byval manager as GDBusObjectManagerServer ptr, byval object_path as const gchar ptr) as gboolean

#define __G_DBUS_ACTION_GROUP_H__
#define G_TYPE_DBUS_ACTION_GROUP g_dbus_action_group_get_type()
#define G_DBUS_ACTION_GROUP(inst) G_TYPE_CHECK_INSTANCE_CAST((inst), G_TYPE_DBUS_ACTION_GROUP, GDBusActionGroup)
#define G_DBUS_ACTION_GROUP_CLASS(class) G_TYPE_CHECK_CLASS_CAST((class), G_TYPE_DBUS_ACTION_GROUP, GDBusActionGroupClass)
#define G_IS_DBUS_ACTION_GROUP(inst) G_TYPE_CHECK_INSTANCE_TYPE((inst), G_TYPE_DBUS_ACTION_GROUP)
#define G_IS_DBUS_ACTION_GROUP_CLASS(class) G_TYPE_CHECK_CLASS_TYPE((class), G_TYPE_DBUS_ACTION_GROUP)
#define G_DBUS_ACTION_GROUP_GET_CLASS(inst) G_TYPE_INSTANCE_GET_CLASS((inst), G_TYPE_DBUS_ACTION_GROUP, GDBusActionGroupClass)
declare function g_dbus_action_group_get_type() as GType
declare function g_dbus_action_group_get(byval connection as GDBusConnection ptr, byval bus_name as const gchar ptr, byval object_path as const gchar ptr) as GDBusActionGroup ptr
#define __G_REMOTE_ACTION_GROUP_H__
#define G_TYPE_REMOTE_ACTION_GROUP g_remote_action_group_get_type()
#define G_REMOTE_ACTION_GROUP(inst) G_TYPE_CHECK_INSTANCE_CAST((inst), G_TYPE_REMOTE_ACTION_GROUP, GRemoteActionGroup)
#define G_IS_REMOTE_ACTION_GROUP(inst) G_TYPE_CHECK_INSTANCE_TYPE((inst), G_TYPE_REMOTE_ACTION_GROUP)
#define G_REMOTE_ACTION_GROUP_GET_IFACE(inst) G_TYPE_INSTANCE_GET_INTERFACE((inst), G_TYPE_REMOTE_ACTION_GROUP, GRemoteActionGroupInterface)
type GRemoteActionGroupInterface as _GRemoteActionGroupInterface

type _GRemoteActionGroupInterface
	g_iface as GTypeInterface
	activate_action_full as sub(byval remote as GRemoteActionGroup ptr, byval action_name as const gchar ptr, byval parameter as GVariant ptr, byval platform_data as GVariant ptr)
	change_action_state_full as sub(byval remote as GRemoteActionGroup ptr, byval action_name as const gchar ptr, byval value as GVariant ptr, byval platform_data as GVariant ptr)
end type

declare function g_remote_action_group_get_type() as GType
declare sub g_remote_action_group_activate_action_full(byval remote as GRemoteActionGroup ptr, byval action_name as const gchar ptr, byval parameter as GVariant ptr, byval platform_data as GVariant ptr)
declare sub g_remote_action_group_change_action_state_full(byval remote as GRemoteActionGroup ptr, byval action_name as const gchar ptr, byval value as GVariant ptr, byval platform_data as GVariant ptr)

#define __G_MENU_MODEL_H__
#define G_MENU_ATTRIBUTE_ACTION "action"
#define G_MENU_ATTRIBUTE_ACTION_NAMESPACE "action-namespace"
#define G_MENU_ATTRIBUTE_TARGET "target"
#define G_MENU_ATTRIBUTE_LABEL "label"
#define G_MENU_ATTRIBUTE_ICON "icon"
#define G_MENU_LINK_SUBMENU "submenu"
#define G_MENU_LINK_SECTION "section"
#define G_TYPE_MENU_MODEL g_menu_model_get_type()
#define G_MENU_MODEL(inst) G_TYPE_CHECK_INSTANCE_CAST((inst), G_TYPE_MENU_MODEL, GMenuModel)
#define G_MENU_MODEL_CLASS(class) G_TYPE_CHECK_CLASS_CAST((class), G_TYPE_MENU_MODEL, GMenuModelClass)
#define G_IS_MENU_MODEL(inst) G_TYPE_CHECK_INSTANCE_TYPE((inst), G_TYPE_MENU_MODEL)
#define G_IS_MENU_MODEL_CLASS(class) G_TYPE_CHECK_CLASS_TYPE((class), G_TYPE_MENU_MODEL)
#define G_MENU_MODEL_GET_CLASS(inst) G_TYPE_INSTANCE_GET_CLASS((inst), G_TYPE_MENU_MODEL, GMenuModelClass)

type GMenuModelPrivate as _GMenuModelPrivate
type GMenuModelClass as _GMenuModelClass
type GMenuAttributeIterPrivate as _GMenuAttributeIterPrivate
type GMenuAttributeIterClass as _GMenuAttributeIterClass
type GMenuAttributeIter as _GMenuAttributeIter
type GMenuLinkIterPrivate as _GMenuLinkIterPrivate
type GMenuLinkIterClass as _GMenuLinkIterClass
type GMenuLinkIter as _GMenuLinkIter

type _GMenuModel
	parent_instance as GObject
	priv as GMenuModelPrivate ptr
end type

type _GMenuModelClass
	parent_class as GObjectClass
	is_mutable as function(byval model as GMenuModel ptr) as gboolean
	get_n_items as function(byval model as GMenuModel ptr) as gint
	get_item_attributes as sub(byval model as GMenuModel ptr, byval item_index as gint, byval attributes as GHashTable ptr ptr)
	iterate_item_attributes as function(byval model as GMenuModel ptr, byval item_index as gint) as GMenuAttributeIter ptr
	get_item_attribute_value as function(byval model as GMenuModel ptr, byval item_index as gint, byval attribute as const gchar ptr, byval expected_type as const GVariantType ptr) as GVariant ptr
	get_item_links as sub(byval model as GMenuModel ptr, byval item_index as gint, byval links as GHashTable ptr ptr)
	iterate_item_links as function(byval model as GMenuModel ptr, byval item_index as gint) as GMenuLinkIter ptr
	get_item_link as function(byval model as GMenuModel ptr, byval item_index as gint, byval link as const gchar ptr) as GMenuModel ptr
end type

declare function g_menu_model_get_type() as GType
declare function g_menu_model_is_mutable(byval model as GMenuModel ptr) as gboolean
declare function g_menu_model_get_n_items(byval model as GMenuModel ptr) as gint
declare function g_menu_model_iterate_item_attributes(byval model as GMenuModel ptr, byval item_index as gint) as GMenuAttributeIter ptr
declare function g_menu_model_get_item_attribute_value(byval model as GMenuModel ptr, byval item_index as gint, byval attribute as const gchar ptr, byval expected_type as const GVariantType ptr) as GVariant ptr
declare function g_menu_model_get_item_attribute(byval model as GMenuModel ptr, byval item_index as gint, byval attribute as const gchar ptr, byval format_string as const gchar ptr, ...) as gboolean
declare function g_menu_model_iterate_item_links(byval model as GMenuModel ptr, byval item_index as gint) as GMenuLinkIter ptr
declare function g_menu_model_get_item_link(byval model as GMenuModel ptr, byval item_index as gint, byval link as const gchar ptr) as GMenuModel ptr
declare sub g_menu_model_items_changed(byval model as GMenuModel ptr, byval position as gint, byval removed as gint, byval added as gint)

#define G_TYPE_MENU_ATTRIBUTE_ITER g_menu_attribute_iter_get_type()
#define G_MENU_ATTRIBUTE_ITER(inst) G_TYPE_CHECK_INSTANCE_CAST((inst), G_TYPE_MENU_ATTRIBUTE_ITER, GMenuAttributeIter)
#define G_MENU_ATTRIBUTE_ITER_CLASS(class) G_TYPE_CHECK_CLASS_CAST((class), G_TYPE_MENU_ATTRIBUTE_ITER, GMenuAttributeIterClass)
#define G_IS_MENU_ATTRIBUTE_ITER(inst) G_TYPE_CHECK_INSTANCE_TYPE((inst), G_TYPE_MENU_ATTRIBUTE_ITER)
#define G_IS_MENU_ATTRIBUTE_ITER_CLASS(class) G_TYPE_CHECK_CLASS_TYPE((class), G_TYPE_MENU_ATTRIBUTE_ITER)
#define G_MENU_ATTRIBUTE_ITER_GET_CLASS(inst) G_TYPE_INSTANCE_GET_CLASS((inst), G_TYPE_MENU_ATTRIBUTE_ITER, GMenuAttributeIterClass)

type _GMenuAttributeIter
	parent_instance as GObject
	priv as GMenuAttributeIterPrivate ptr
end type

type _GMenuAttributeIterClass
	parent_class as GObjectClass
	get_next as function(byval iter as GMenuAttributeIter ptr, byval out_name as const gchar ptr ptr, byval value as GVariant ptr ptr) as gboolean
end type

declare function g_menu_attribute_iter_get_type() as GType
declare function g_menu_attribute_iter_get_next(byval iter as GMenuAttributeIter ptr, byval out_name as const gchar ptr ptr, byval value as GVariant ptr ptr) as gboolean
declare function g_menu_attribute_iter_next(byval iter as GMenuAttributeIter ptr) as gboolean
declare function g_menu_attribute_iter_get_name(byval iter as GMenuAttributeIter ptr) as const gchar ptr
declare function g_menu_attribute_iter_get_value(byval iter as GMenuAttributeIter ptr) as GVariant ptr

#define G_TYPE_MENU_LINK_ITER g_menu_link_iter_get_type()
#define G_MENU_LINK_ITER(inst) G_TYPE_CHECK_INSTANCE_CAST((inst), G_TYPE_MENU_LINK_ITER, GMenuLinkIter)
#define G_MENU_LINK_ITER_CLASS(class) G_TYPE_CHECK_CLASS_CAST((class), G_TYPE_MENU_LINK_ITER, GMenuLinkIterClass)
#define G_IS_MENU_LINK_ITER(inst) G_TYPE_CHECK_INSTANCE_TYPE((inst), G_TYPE_MENU_LINK_ITER)
#define G_IS_MENU_LINK_ITER_CLASS(class) G_TYPE_CHECK_CLASS_TYPE((class), G_TYPE_MENU_LINK_ITER)
#define G_MENU_LINK_ITER_GET_CLASS(inst) G_TYPE_INSTANCE_GET_CLASS((inst), G_TYPE_MENU_LINK_ITER, GMenuLinkIterClass)

type _GMenuLinkIter
	parent_instance as GObject
	priv as GMenuLinkIterPrivate ptr
end type

type _GMenuLinkIterClass
	parent_class as GObjectClass
	get_next as function(byval iter as GMenuLinkIter ptr, byval out_link as const gchar ptr ptr, byval value as GMenuModel ptr ptr) as gboolean
end type

declare function g_menu_link_iter_get_type() as GType
declare function g_menu_link_iter_get_next(byval iter as GMenuLinkIter ptr, byval out_link as const gchar ptr ptr, byval value as GMenuModel ptr ptr) as gboolean
declare function g_menu_link_iter_next(byval iter as GMenuLinkIter ptr) as gboolean
declare function g_menu_link_iter_get_name(byval iter as GMenuLinkIter ptr) as const gchar ptr
declare function g_menu_link_iter_get_value(byval iter as GMenuLinkIter ptr) as GMenuModel ptr

#define __G_MENU_H__
#define G_TYPE_MENU g_menu_get_type()
#define G_MENU(inst) G_TYPE_CHECK_INSTANCE_CAST((inst), G_TYPE_MENU, GMenu)
#define G_IS_MENU(inst) G_TYPE_CHECK_INSTANCE_TYPE((inst), G_TYPE_MENU)
#define G_TYPE_MENU_ITEM g_menu_item_get_type()
#define G_MENU_ITEM(inst) G_TYPE_CHECK_INSTANCE_CAST((inst), G_TYPE_MENU_ITEM, GMenuItem)
#define G_IS_MENU_ITEM(inst) G_TYPE_CHECK_INSTANCE_TYPE((inst), G_TYPE_MENU_ITEM)
type GMenuItem as _GMenuItem
type GMenu as _GMenu

declare function g_menu_get_type() as GType
declare function g_menu_new() as GMenu ptr
declare sub g_menu_freeze(byval menu as GMenu ptr)
declare sub g_menu_insert_item(byval menu as GMenu ptr, byval position as gint, byval item as GMenuItem ptr)
declare sub g_menu_prepend_item(byval menu as GMenu ptr, byval item as GMenuItem ptr)
declare sub g_menu_append_item(byval menu as GMenu ptr, byval item as GMenuItem ptr)
declare sub g_menu_remove(byval menu as GMenu ptr, byval position as gint)
declare sub g_menu_remove_all(byval menu as GMenu ptr)
declare sub g_menu_insert(byval menu as GMenu ptr, byval position as gint, byval label as const gchar ptr, byval detailed_action as const gchar ptr)
declare sub g_menu_prepend(byval menu as GMenu ptr, byval label as const gchar ptr, byval detailed_action as const gchar ptr)
declare sub g_menu_append(byval menu as GMenu ptr, byval label as const gchar ptr, byval detailed_action as const gchar ptr)
declare sub g_menu_insert_section(byval menu as GMenu ptr, byval position as gint, byval label as const gchar ptr, byval section as GMenuModel ptr)
declare sub g_menu_prepend_section(byval menu as GMenu ptr, byval label as const gchar ptr, byval section as GMenuModel ptr)
declare sub g_menu_append_section(byval menu as GMenu ptr, byval label as const gchar ptr, byval section as GMenuModel ptr)
declare sub g_menu_insert_submenu(byval menu as GMenu ptr, byval position as gint, byval label as const gchar ptr, byval submenu as GMenuModel ptr)
declare sub g_menu_prepend_submenu(byval menu as GMenu ptr, byval label as const gchar ptr, byval submenu as GMenuModel ptr)
declare sub g_menu_append_submenu(byval menu as GMenu ptr, byval label as const gchar ptr, byval submenu as GMenuModel ptr)
declare function g_menu_item_get_type() as GType
declare function g_menu_item_new(byval label as const gchar ptr, byval detailed_action as const gchar ptr) as GMenuItem ptr
declare function g_menu_item_new_from_model(byval model as GMenuModel ptr, byval item_index as gint) as GMenuItem ptr
declare function g_menu_item_new_submenu(byval label as const gchar ptr, byval submenu as GMenuModel ptr) as GMenuItem ptr
declare function g_menu_item_new_section(byval label as const gchar ptr, byval section as GMenuModel ptr) as GMenuItem ptr
declare function g_menu_item_get_attribute_value(byval menu_item as GMenuItem ptr, byval attribute as const gchar ptr, byval expected_type as const GVariantType ptr) as GVariant ptr
declare function g_menu_item_get_attribute(byval menu_item as GMenuItem ptr, byval attribute as const gchar ptr, byval format_string as const gchar ptr, ...) as gboolean
declare function g_menu_item_get_link(byval menu_item as GMenuItem ptr, byval link as const gchar ptr) as GMenuModel ptr
declare sub g_menu_item_set_attribute_value(byval menu_item as GMenuItem ptr, byval attribute as const gchar ptr, byval value as GVariant ptr)
declare sub g_menu_item_set_attribute(byval menu_item as GMenuItem ptr, byval attribute as const gchar ptr, byval format_string as const gchar ptr, ...)
declare sub g_menu_item_set_link(byval menu_item as GMenuItem ptr, byval link as const gchar ptr, byval model as GMenuModel ptr)
declare sub g_menu_item_set_label(byval menu_item as GMenuItem ptr, byval label as const gchar ptr)
declare sub g_menu_item_set_submenu(byval menu_item as GMenuItem ptr, byval submenu as GMenuModel ptr)
declare sub g_menu_item_set_section(byval menu_item as GMenuItem ptr, byval section as GMenuModel ptr)
declare sub g_menu_item_set_action_and_target_value(byval menu_item as GMenuItem ptr, byval action as const gchar ptr, byval target_value as GVariant ptr)
declare sub g_menu_item_set_action_and_target(byval menu_item as GMenuItem ptr, byval action as const gchar ptr, byval format_string as const gchar ptr, ...)
declare sub g_menu_item_set_detailed_action(byval menu_item as GMenuItem ptr, byval detailed_action as const gchar ptr)
declare sub g_menu_item_set_icon(byval menu_item as GMenuItem ptr, byval icon as GIcon ptr)
#define __G_MENU_EXPORTER_H__
declare function g_dbus_connection_export_menu_model(byval connection as GDBusConnection ptr, byval object_path as const gchar ptr, byval menu as GMenuModel ptr, byval error as GError ptr ptr) as guint
declare sub g_dbus_connection_unexport_menu_model(byval connection as GDBusConnection ptr, byval export_id as guint)

#define __G_DBUS_MENU_MODEL_H__
#define G_TYPE_DBUS_MENU_MODEL g_dbus_menu_model_get_type()
#define G_DBUS_MENU_MODEL(inst) G_TYPE_CHECK_INSTANCE_CAST((inst), G_TYPE_DBUS_MENU_MODEL, GDBusMenuModel)
#define G_IS_DBUS_MENU_MODEL(inst) G_TYPE_CHECK_INSTANCE_TYPE((inst), G_TYPE_DBUS_MENU_MODEL)
type GDBusMenuModel as _GDBusMenuModel
declare function g_dbus_menu_model_get_type() as GType
declare function g_dbus_menu_model_get(byval connection as GDBusConnection ptr, byval bus_name as const gchar ptr, byval object_path as const gchar ptr) as GDBusMenuModel ptr
#define __G_NOTIFICATION_H__
#define G_TYPE_NOTIFICATION g_notification_get_type()
#define G_NOTIFICATION(o) G_TYPE_CHECK_INSTANCE_CAST((o), G_TYPE_NOTIFICATION, GNotification)
#define G_IS_NOTIFICATION(o) G_TYPE_CHECK_INSTANCE_TYPE((o), G_TYPE_NOTIFICATION)

declare function g_notification_get_type() as GType
declare function g_notification_new(byval title as const gchar ptr) as GNotification ptr
declare sub g_notification_set_title(byval notification as GNotification ptr, byval title as const gchar ptr)
declare sub g_notification_set_body(byval notification as GNotification ptr, byval body as const gchar ptr)
declare sub g_notification_set_icon(byval notification as GNotification ptr, byval icon as GIcon ptr)
declare sub g_notification_set_urgent(byval notification as GNotification ptr, byval urgent as gboolean)
declare sub g_notification_set_priority(byval notification as GNotification ptr, byval priority as GNotificationPriority)
declare sub g_notification_add_button(byval notification as GNotification ptr, byval label as const gchar ptr, byval detailed_action as const gchar ptr)
declare sub g_notification_add_button_with_target(byval notification as GNotification ptr, byval label as const gchar ptr, byval action as const gchar ptr, byval target_format as const gchar ptr, ...)
declare sub g_notification_add_button_with_target_value(byval notification as GNotification ptr, byval label as const gchar ptr, byval action as const gchar ptr, byval target as GVariant ptr)
declare sub g_notification_set_default_action(byval notification as GNotification ptr, byval detailed_action as const gchar ptr)
declare sub g_notification_set_default_action_and_target(byval notification as GNotification ptr, byval action as const gchar ptr, byval target_format as const gchar ptr, ...)
declare sub g_notification_set_default_action_and_target_value(byval notification as GNotification ptr, byval action as const gchar ptr, byval target as GVariant ptr)
#define __G_LIST_MODEL_H__
#define G_TYPE_LIST_MODEL g_list_model_get_type()
declare function g_list_model_get_type() as GType

type GListModel as _GListModel
type GListModelInterface as _GListModelInterface
type GListModel_autoptr as GListModel ptr

private sub glib_autoptr_cleanup_GListModel(byval _ptr as GListModel ptr ptr)
	glib_autoptr_cleanup_GObject(cptr(GObject ptr ptr, _ptr))
end sub

#define G_LIST_MODEL(ptr_) cptr(GListModel ptr, g_type_check_instance_cast_(cptr(GTypeInstance ptr, (ptr_)), g_list_model_get_type()))
#define G_IS_LIST_MODEL(ptr_) cast(gboolean, G_TYPE_CHECK_INSTANCE_TYPE((ptr_), g_list_model_get_type()))
#define G_LIST_MODEL_GET_IFACE(ptr_) cptr(GListModelInterface ptr, g_type_interface_peek(cptr(GTypeInstance ptr, (ptr_))->g_class, g_list_model_get_type()))

type _GListModelInterface
	g_iface as GTypeInterface
	get_item_type as function(byval list as GListModel ptr) as GType
	get_n_items as function(byval list as GListModel ptr) as guint
	get_item as function(byval list as GListModel ptr, byval position as guint) as gpointer
end type

declare function g_list_model_get_item_type(byval list as GListModel ptr) as GType
declare function g_list_model_get_n_items(byval list as GListModel ptr) as guint
declare function g_list_model_get_item(byval list as GListModel ptr, byval position as guint) as gpointer
declare function g_list_model_get_object(byval list as GListModel ptr, byval position as guint) as GObject ptr
declare sub g_list_model_items_changed(byval list as GListModel ptr, byval position as guint, byval removed as guint, byval added as guint)
#define __G_LIST_STORE_H__
#define G_TYPE_LIST_STORE g_list_store_get_type()
declare function g_list_store_get_type() as GType
type GListStore as _GListStore

type GListStoreClass
	parent_class as GObjectClass
end type

type GListStore_autoptr as GListStore ptr

private sub glib_autoptr_cleanup_GListStore(byval _ptr as GListStore ptr ptr)
	glib_autoptr_cleanup_GObject(cptr(GObject ptr ptr, _ptr))
end sub

#define G_LIST_STORE(ptr_) cptr(GListStore ptr, g_type_check_instance_cast_(cptr(GTypeInstance ptr, (ptr_)), g_list_store_get_type()))
#define G_IS_LIST_STORE(ptr_) cast(gboolean, G_TYPE_CHECK_INSTANCE_TYPE((ptr_), g_list_store_get_type()))
declare function g_list_store_new(byval item_type as GType) as GListStore ptr
declare sub g_list_store_insert(byval store as GListStore ptr, byval position as guint, byval item as gpointer)
declare function g_list_store_insert_sorted(byval store as GListStore ptr, byval item as gpointer, byval compare_func as GCompareDataFunc, byval user_data as gpointer) as guint
declare sub g_list_store_append(byval store as GListStore ptr, byval item as gpointer)
declare sub g_list_store_remove(byval store as GListStore ptr, byval position as guint)
declare sub g_list_store_remove_all(byval store as GListStore ptr)
declare sub g_list_store_splice(byval store as GListStore ptr, byval position as guint, byval n_removals as guint, byval additions as gpointer ptr, byval n_additions as guint)
type GAction_autoptr as GAction ptr

private sub glib_autoptr_cleanup_GAction(byval _ptr as GAction ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GActionMap_autoptr as GActionMap ptr

private sub glib_autoptr_cleanup_GActionMap(byval _ptr as GActionMap ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GAppInfo_autoptr as GAppInfo ptr

private sub glib_autoptr_cleanup_GAppInfo(byval _ptr as GAppInfo ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GAppLaunchContext_autoptr as GAppLaunchContext ptr

private sub glib_autoptr_cleanup_GAppLaunchContext(byval _ptr as GAppLaunchContext ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GAppInfoMonitor_autoptr as GAppInfoMonitor ptr

private sub glib_autoptr_cleanup_GAppInfoMonitor(byval _ptr as GAppInfoMonitor ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GApplicationCommandLine_autoptr as GApplicationCommandLine ptr

private sub glib_autoptr_cleanup_GApplicationCommandLine(byval _ptr as GApplicationCommandLine ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GApplication_autoptr as GApplication ptr

private sub glib_autoptr_cleanup_GApplication(byval _ptr as GApplication ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GAsyncInitable_autoptr as GAsyncInitable ptr

private sub glib_autoptr_cleanup_GAsyncInitable(byval _ptr as GAsyncInitable ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GAsyncResult_autoptr as GAsyncResult ptr

private sub glib_autoptr_cleanup_GAsyncResult(byval _ptr as GAsyncResult ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GBufferedInputStream_autoptr as GBufferedInputStream ptr

private sub glib_autoptr_cleanup_GBufferedInputStream(byval _ptr as GBufferedInputStream ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GBufferedOutputStream_autoptr as GBufferedOutputStream ptr

private sub glib_autoptr_cleanup_GBufferedOutputStream(byval _ptr as GBufferedOutputStream ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GBytesIcon_autoptr as GBytesIcon ptr

private sub glib_autoptr_cleanup_GBytesIcon(byval _ptr as GBytesIcon ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GCancellable_autoptr as GCancellable ptr

private sub glib_autoptr_cleanup_GCancellable(byval _ptr as GCancellable ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GCharsetConverter_autoptr as GCharsetConverter ptr

private sub glib_autoptr_cleanup_GCharsetConverter(byval _ptr as GCharsetConverter ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GConverter_autoptr as GConverter ptr

private sub glib_autoptr_cleanup_GConverter(byval _ptr as GConverter ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GConverterInputStream_autoptr as GConverterInputStream ptr

private sub glib_autoptr_cleanup_GConverterInputStream(byval _ptr as GConverterInputStream ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GConverterOutputStream_autoptr as GConverterOutputStream ptr

private sub glib_autoptr_cleanup_GConverterOutputStream(byval _ptr as GConverterOutputStream ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GCredentials_autoptr as GCredentials ptr

private sub glib_autoptr_cleanup_GCredentials(byval _ptr as GCredentials ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GDataInputStream_autoptr as GDataInputStream ptr

private sub glib_autoptr_cleanup_GDataInputStream(byval _ptr as GDataInputStream ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GDataOutputStream_autoptr as GDataOutputStream ptr

private sub glib_autoptr_cleanup_GDataOutputStream(byval _ptr as GDataOutputStream ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GDBusActionGroup_autoptr as GDBusActionGroup ptr

private sub glib_autoptr_cleanup_GDBusActionGroup(byval _ptr as GDBusActionGroup ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GDBusAuthObserver_autoptr as GDBusAuthObserver ptr

private sub glib_autoptr_cleanup_GDBusAuthObserver(byval _ptr as GDBusAuthObserver ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GDBusConnection_autoptr as GDBusConnection ptr

private sub glib_autoptr_cleanup_GDBusConnection(byval _ptr as GDBusConnection ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GDBusInterface_autoptr as GDBusInterface ptr

private sub glib_autoptr_cleanup_GDBusInterface(byval _ptr as GDBusInterface ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GDBusInterfaceSkeleton_autoptr as GDBusInterfaceSkeleton ptr

private sub glib_autoptr_cleanup_GDBusInterfaceSkeleton(byval _ptr as GDBusInterfaceSkeleton ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GDBusMenuModel_autoptr as GDBusMenuModel ptr

private sub glib_autoptr_cleanup_GDBusMenuModel(byval _ptr as GDBusMenuModel ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GDBusMessage_autoptr as GDBusMessage ptr

private sub glib_autoptr_cleanup_GDBusMessage(byval _ptr as GDBusMessage ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GDBusMethodInvocation_autoptr as GDBusMethodInvocation ptr

private sub glib_autoptr_cleanup_GDBusMethodInvocation(byval _ptr as GDBusMethodInvocation ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GDBusNodeInfo_autoptr as GDBusNodeInfo ptr

private sub glib_autoptr_cleanup_GDBusNodeInfo(byval _ptr as GDBusNodeInfo ptr ptr)
	if *_ptr then
		g_dbus_node_info_unref(*_ptr)
	end if
end sub

type GDBusObject_autoptr as GDBusObject ptr

private sub glib_autoptr_cleanup_GDBusObject(byval _ptr as GDBusObject ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GDBusObjectManagerClient_autoptr as GDBusObjectManagerClient ptr

private sub glib_autoptr_cleanup_GDBusObjectManagerClient(byval _ptr as GDBusObjectManagerClient ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GDBusObjectManager_autoptr as GDBusObjectManager ptr

private sub glib_autoptr_cleanup_GDBusObjectManager(byval _ptr as GDBusObjectManager ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GDBusObjectManagerServer_autoptr as GDBusObjectManagerServer ptr

private sub glib_autoptr_cleanup_GDBusObjectManagerServer(byval _ptr as GDBusObjectManagerServer ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GDBusObjectProxy_autoptr as GDBusObjectProxy ptr

private sub glib_autoptr_cleanup_GDBusObjectProxy(byval _ptr as GDBusObjectProxy ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GDBusObjectSkeleton_autoptr as GDBusObjectSkeleton ptr

private sub glib_autoptr_cleanup_GDBusObjectSkeleton(byval _ptr as GDBusObjectSkeleton ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GDBusProxy_autoptr as GDBusProxy ptr

private sub glib_autoptr_cleanup_GDBusProxy(byval _ptr as GDBusProxy ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GDBusServer_autoptr as GDBusServer ptr

private sub glib_autoptr_cleanup_GDBusServer(byval _ptr as GDBusServer ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GDrive_autoptr as GDrive ptr

private sub glib_autoptr_cleanup_GDrive(byval _ptr as GDrive ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GEmblemedIcon_autoptr as GEmblemedIcon ptr

private sub glib_autoptr_cleanup_GEmblemedIcon(byval _ptr as GEmblemedIcon ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GEmblem_autoptr as GEmblem ptr

private sub glib_autoptr_cleanup_GEmblem(byval _ptr as GEmblem ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GFileEnumerator_autoptr as GFileEnumerator ptr

private sub glib_autoptr_cleanup_GFileEnumerator(byval _ptr as GFileEnumerator ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GFile_autoptr as GFile ptr

private sub glib_autoptr_cleanup_GFile(byval _ptr as GFile ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GFileIcon_autoptr as GFileIcon ptr

private sub glib_autoptr_cleanup_GFileIcon(byval _ptr as GFileIcon ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GFileInfo_autoptr as GFileInfo ptr

private sub glib_autoptr_cleanup_GFileInfo(byval _ptr as GFileInfo ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GFileInputStream_autoptr as GFileInputStream ptr

private sub glib_autoptr_cleanup_GFileInputStream(byval _ptr as GFileInputStream ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GFileIOStream_autoptr as GFileIOStream ptr

private sub glib_autoptr_cleanup_GFileIOStream(byval _ptr as GFileIOStream ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GFileMonitor_autoptr as GFileMonitor ptr

private sub glib_autoptr_cleanup_GFileMonitor(byval _ptr as GFileMonitor ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GFilenameCompleter_autoptr as GFilenameCompleter ptr

private sub glib_autoptr_cleanup_GFilenameCompleter(byval _ptr as GFilenameCompleter ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GFileOutputStream_autoptr as GFileOutputStream ptr

private sub glib_autoptr_cleanup_GFileOutputStream(byval _ptr as GFileOutputStream ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GFilterInputStream_autoptr as GFilterInputStream ptr

private sub glib_autoptr_cleanup_GFilterInputStream(byval _ptr as GFilterInputStream ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GFilterOutputStream_autoptr as GFilterOutputStream ptr

private sub glib_autoptr_cleanup_GFilterOutputStream(byval _ptr as GFilterOutputStream ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GIcon_autoptr as GIcon ptr

private sub glib_autoptr_cleanup_GIcon(byval _ptr as GIcon ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GInetAddress_autoptr as GInetAddress ptr

private sub glib_autoptr_cleanup_GInetAddress(byval _ptr as GInetAddress ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GInetAddressMask_autoptr as GInetAddressMask ptr

private sub glib_autoptr_cleanup_GInetAddressMask(byval _ptr as GInetAddressMask ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GInetSocketAddress_autoptr as GInetSocketAddress ptr

private sub glib_autoptr_cleanup_GInetSocketAddress(byval _ptr as GInetSocketAddress ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GInitable_autoptr as GInitable ptr

private sub glib_autoptr_cleanup_GInitable(byval _ptr as GInitable ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GInputStream_autoptr as GInputStream ptr

private sub glib_autoptr_cleanup_GInputStream(byval _ptr as GInputStream ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GIOModule_autoptr as GIOModule ptr

private sub glib_autoptr_cleanup_GIOModule(byval _ptr as GIOModule ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GIOStream_autoptr as GIOStream ptr

private sub glib_autoptr_cleanup_GIOStream(byval _ptr as GIOStream ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GLoadableIcon_autoptr as GLoadableIcon ptr

private sub glib_autoptr_cleanup_GLoadableIcon(byval _ptr as GLoadableIcon ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GMemoryInputStream_autoptr as GMemoryInputStream ptr

private sub glib_autoptr_cleanup_GMemoryInputStream(byval _ptr as GMemoryInputStream ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GMemoryOutputStream_autoptr as GMemoryOutputStream ptr

private sub glib_autoptr_cleanup_GMemoryOutputStream(byval _ptr as GMemoryOutputStream ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GMenu_autoptr as GMenu ptr

private sub glib_autoptr_cleanup_GMenu(byval _ptr as GMenu ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GMenuItem_autoptr as GMenuItem ptr

private sub glib_autoptr_cleanup_GMenuItem(byval _ptr as GMenuItem ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GMenuModel_autoptr as GMenuModel ptr

private sub glib_autoptr_cleanup_GMenuModel(byval _ptr as GMenuModel ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GMenuAttributeIter_autoptr as GMenuAttributeIter ptr

private sub glib_autoptr_cleanup_GMenuAttributeIter(byval _ptr as GMenuAttributeIter ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GMenuLinkIter_autoptr as GMenuLinkIter ptr

private sub glib_autoptr_cleanup_GMenuLinkIter(byval _ptr as GMenuLinkIter ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GMount_autoptr as GMount ptr

private sub glib_autoptr_cleanup_GMount(byval _ptr as GMount ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GMountOperation_autoptr as GMountOperation ptr

private sub glib_autoptr_cleanup_GMountOperation(byval _ptr as GMountOperation ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GNativeVolumeMonitor_autoptr as GNativeVolumeMonitor ptr

private sub glib_autoptr_cleanup_GNativeVolumeMonitor(byval _ptr as GNativeVolumeMonitor ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GNetworkAddress_autoptr as GNetworkAddress ptr

private sub glib_autoptr_cleanup_GNetworkAddress(byval _ptr as GNetworkAddress ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GNetworkMonitor_autoptr as GNetworkMonitor ptr

private sub glib_autoptr_cleanup_GNetworkMonitor(byval _ptr as GNetworkMonitor ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GNetworkService_autoptr as GNetworkService ptr

private sub glib_autoptr_cleanup_GNetworkService(byval _ptr as GNetworkService ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GNotification_autoptr as GNotification ptr

private sub glib_autoptr_cleanup_GNotification(byval _ptr as GNotification ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GOutputStream_autoptr as GOutputStream ptr

private sub glib_autoptr_cleanup_GOutputStream(byval _ptr as GOutputStream ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GPermission_autoptr as GPermission ptr

private sub glib_autoptr_cleanup_GPermission(byval _ptr as GPermission ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GPollableInputStream_autoptr as GPollableInputStream ptr

private sub glib_autoptr_cleanup_GPollableInputStream(byval _ptr as GPollableInputStream ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GPollableOutputStream_autoptr as GPollableOutputStream ptr

private sub glib_autoptr_cleanup_GPollableOutputStream(byval _ptr as GPollableOutputStream ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GPropertyAction_autoptr as GPropertyAction ptr

private sub glib_autoptr_cleanup_GPropertyAction(byval _ptr as GPropertyAction ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GProxyAddressEnumerator_autoptr as GProxyAddressEnumerator ptr

private sub glib_autoptr_cleanup_GProxyAddressEnumerator(byval _ptr as GProxyAddressEnumerator ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GProxyAddress_autoptr as GProxyAddress ptr

private sub glib_autoptr_cleanup_GProxyAddress(byval _ptr as GProxyAddress ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GProxy_autoptr as GProxy ptr

private sub glib_autoptr_cleanup_GProxy(byval _ptr as GProxy ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GProxyResolver_autoptr as GProxyResolver ptr

private sub glib_autoptr_cleanup_GProxyResolver(byval _ptr as GProxyResolver ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GRemoteActionGroup_autoptr as GRemoteActionGroup ptr

private sub glib_autoptr_cleanup_GRemoteActionGroup(byval _ptr as GRemoteActionGroup ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GResolver_autoptr as GResolver ptr

private sub glib_autoptr_cleanup_GResolver(byval _ptr as GResolver ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GSeekable_autoptr as GSeekable ptr

private sub glib_autoptr_cleanup_GSeekable(byval _ptr as GSeekable ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GSettingsBackend_autoptr as GSettingsBackend ptr

private sub glib_autoptr_cleanup_GSettingsBackend(byval _ptr as GSettingsBackend ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GSettingsSchema_autoptr as GSettingsSchema ptr

private sub glib_autoptr_cleanup_GSettingsSchema(byval _ptr as GSettingsSchema ptr ptr)
	if *_ptr then
		g_settings_schema_unref(*_ptr)
	end if
end sub

type GSettings_autoptr as GSettings ptr

private sub glib_autoptr_cleanup_GSettings(byval _ptr as GSettings ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GSimpleActionGroup_autoptr as GSimpleActionGroup ptr

private sub glib_autoptr_cleanup_GSimpleActionGroup(byval _ptr as GSimpleActionGroup ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GSimpleAction_autoptr as GSimpleAction ptr

private sub glib_autoptr_cleanup_GSimpleAction(byval _ptr as GSimpleAction ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GSimpleAsyncResult_autoptr as GSimpleAsyncResult ptr

private sub glib_autoptr_cleanup_GSimpleAsyncResult(byval _ptr as GSimpleAsyncResult ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GSimplePermission_autoptr as GSimplePermission ptr

private sub glib_autoptr_cleanup_GSimplePermission(byval _ptr as GSimplePermission ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GSimpleProxyResolver_autoptr as GSimpleProxyResolver ptr

private sub glib_autoptr_cleanup_GSimpleProxyResolver(byval _ptr as GSimpleProxyResolver ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GSocketAddressEnumerator_autoptr as GSocketAddressEnumerator ptr

private sub glib_autoptr_cleanup_GSocketAddressEnumerator(byval _ptr as GSocketAddressEnumerator ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GSocketAddress_autoptr as GSocketAddress ptr

private sub glib_autoptr_cleanup_GSocketAddress(byval _ptr as GSocketAddress ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GSocketClient_autoptr as GSocketClient ptr

private sub glib_autoptr_cleanup_GSocketClient(byval _ptr as GSocketClient ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GSocketConnectable_autoptr as GSocketConnectable ptr

private sub glib_autoptr_cleanup_GSocketConnectable(byval _ptr as GSocketConnectable ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GSocketConnection_autoptr as GSocketConnection ptr

private sub glib_autoptr_cleanup_GSocketConnection(byval _ptr as GSocketConnection ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GSocketControlMessage_autoptr as GSocketControlMessage ptr

private sub glib_autoptr_cleanup_GSocketControlMessage(byval _ptr as GSocketControlMessage ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GSocket_autoptr as GSocket ptr

private sub glib_autoptr_cleanup_GSocket(byval _ptr as GSocket ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GSocketListener_autoptr as GSocketListener ptr

private sub glib_autoptr_cleanup_GSocketListener(byval _ptr as GSocketListener ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GSocketService_autoptr as GSocketService ptr

private sub glib_autoptr_cleanup_GSocketService(byval _ptr as GSocketService ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GSubprocess_autoptr as GSubprocess ptr

private sub glib_autoptr_cleanup_GSubprocess(byval _ptr as GSubprocess ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GSubprocessLauncher_autoptr as GSubprocessLauncher ptr

private sub glib_autoptr_cleanup_GSubprocessLauncher(byval _ptr as GSubprocessLauncher ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GTask_autoptr as GTask ptr

private sub glib_autoptr_cleanup_GTask(byval _ptr as GTask ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GTcpConnection_autoptr as GTcpConnection ptr

private sub glib_autoptr_cleanup_GTcpConnection(byval _ptr as GTcpConnection ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GTcpWrapperConnection_autoptr as GTcpWrapperConnection ptr

private sub glib_autoptr_cleanup_GTcpWrapperConnection(byval _ptr as GTcpWrapperConnection ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GTestDBus_autoptr as GTestDBus ptr

private sub glib_autoptr_cleanup_GTestDBus(byval _ptr as GTestDBus ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GThemedIcon_autoptr as GThemedIcon ptr

private sub glib_autoptr_cleanup_GThemedIcon(byval _ptr as GThemedIcon ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GThreadedSocketService_autoptr as GThreadedSocketService ptr

private sub glib_autoptr_cleanup_GThreadedSocketService(byval _ptr as GThreadedSocketService ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GTlsBackend_autoptr as GTlsBackend ptr

private sub glib_autoptr_cleanup_GTlsBackend(byval _ptr as GTlsBackend ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GTlsCertificate_autoptr as GTlsCertificate ptr

private sub glib_autoptr_cleanup_GTlsCertificate(byval _ptr as GTlsCertificate ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GTlsClientConnection_autoptr as GTlsClientConnection ptr

private sub glib_autoptr_cleanup_GTlsClientConnection(byval _ptr as GTlsClientConnection ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GTlsConnection_autoptr as GTlsConnection ptr

private sub glib_autoptr_cleanup_GTlsConnection(byval _ptr as GTlsConnection ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GTlsDatabase_autoptr as GTlsDatabase ptr

private sub glib_autoptr_cleanup_GTlsDatabase(byval _ptr as GTlsDatabase ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GTlsFileDatabase_autoptr as GTlsFileDatabase ptr

private sub glib_autoptr_cleanup_GTlsFileDatabase(byval _ptr as GTlsFileDatabase ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GTlsInteraction_autoptr as GTlsInteraction ptr

private sub glib_autoptr_cleanup_GTlsInteraction(byval _ptr as GTlsInteraction ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GTlsPassword_autoptr as GTlsPassword ptr

private sub glib_autoptr_cleanup_GTlsPassword(byval _ptr as GTlsPassword ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GTlsServerConnection_autoptr as GTlsServerConnection ptr

private sub glib_autoptr_cleanup_GTlsServerConnection(byval _ptr as GTlsServerConnection ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GVfs_autoptr as GVfs ptr

private sub glib_autoptr_cleanup_GVfs(byval _ptr as GVfs ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GVolume_autoptr as GVolume ptr

private sub glib_autoptr_cleanup_GVolume(byval _ptr as GVolume ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GVolumeMonitor_autoptr as GVolumeMonitor ptr

private sub glib_autoptr_cleanup_GVolumeMonitor(byval _ptr as GVolumeMonitor ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GZlibCompressor_autoptr as GZlibCompressor ptr

private sub glib_autoptr_cleanup_GZlibCompressor(byval _ptr as GZlibCompressor ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GZlibDecompressor_autoptr as GZlibDecompressor ptr

private sub glib_autoptr_cleanup_GZlibDecompressor(byval _ptr as GZlibDecompressor ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

#undef __GIO_GIO_H_INSIDE__

end extern

#ifdef __FB_WIN32__
#pragma pop(msbitfields)
#endif
