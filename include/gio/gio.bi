' This is file gio.bi
' (FreeBasic binding for GLib library version 2.31.4)
'
' translated with help of h_2_bi.bas by
' Thomas[ dot ]Freiherr[ at ]gmx[ dot ]net.
'
' Licence:
' (C) 2011 Thomas[ dot ]Freiherr[ at ]gmx[ dot ]net
'
' This library binding is free software; you can redistribute it
' and/or modify it under the terms of the GNU Lesser General Public
' License as published by the Free Software Foundation; either
' version 2 of the License, or (at your option) ANY later version.
'
' This binding is distributed in the hope that it will be useful,
' but WITHOUT ANY WARRANTY; without even the implied warranty of
' MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
' Lesser General Public License for more details, refer to:
' http://www.gnu.org/licenses/lgpl.html
'
'
' Original license text:
'
'/* GIO - GLib Input, Output and Streaming Library
 '*
 '* Copyright (C) 2006-2007 Red Hat, Inc.
 '*
 '* This library is free software; you can redistribute it and/or
 '* modify it under the terms of the GNU Lesser General Public
 '* License as published by the Free Software Foundation; either
 '* version 2 of the License, or (at your option) any later version.
 '*
 '* This library is distributed in the hope that it will be useful,
 '* but WITHOUT ANY WARRANTY; without even the implied warranty of
 '* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 '* Lesser General Public License for more details.
 '*
 '* You should have received a copy of the GNU Lesser General
 '* Public License along with this library; if not, write to the
 '* Free Software Foundation, Inc., 59 Temple Place, Suite 330,
 '* Boston, MA 02111-1307, USA.
 '*
 '* Author: Alexander Larsson <alexl@redhat.com>
 '*/

#IFDEF __FB_WIN32__
#PRAGMA push(msbitfields)
#ENDIF

#IFNDEF __USE_GTK_OLD__
#INCLIB "gio-2.0"
#ENDIF

EXTERN "C"

#IFNDEF __G_IO_H__
#DEFINE __G_IO_H__
#DEFINE __GIO_GIO_H_INSIDE__

#IFNDEF __GIO_TYPES_H__
#DEFINE __GIO_TYPES_H__

#IFNDEF __GIO_ENUMS_H__
#DEFINE __GIO_ENUMS_H__
#INCLUDE ONCE "glib-object.bi"

ENUM GAppInfoCreateFlags
  G_APP_INFO_CREATE_NONE = 0
  G_APP_INFO_CREATE_NEEDS_TERMINAL = (1 SHL 0)
  G_APP_INFO_CREATE_SUPPORTS_URIS = (1 SHL 1)
  G_APP_INFO_CREATE_SUPPORTS_STARTUP_NOTIFICATION = (1 SHL 2)
END ENUM

ENUM GConverterFlags
  G_CONVERTER_NO_FLAGS = 0
  G_CONVERTER_INPUT_AT_END = (1 SHL 0)
  G_CONVERTER_FLUSH = (1 SHL 1)
END ENUM

ENUM GConverterResult
  G_CONVERTER_ERROR = 0
  G_CONVERTER_CONVERTED = 1
  G_CONVERTER_FINISHED = 2
  G_CONVERTER_FLUSHED = 3
END ENUM

ENUM GDataStreamByteOrder
  G_DATA_STREAM_BYTE_ORDER_BIG_ENDIAN
  G_DATA_STREAM_BYTE_ORDER_LITTLE_ENDIAN
  G_DATA_STREAM_BYTE_ORDER_HOST_ENDIAN
END ENUM

ENUM GDataStreamNewlineType
  G_DATA_STREAM_NEWLINE_TYPE_LF
  G_DATA_STREAM_NEWLINE_TYPE_CR
  G_DATA_STREAM_NEWLINE_TYPE_CR_LF
  G_DATA_STREAM_NEWLINE_TYPE_ANY
END ENUM

ENUM GFileAttributeType
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
END ENUM

ENUM GFileAttributeInfoFlags
  G_FILE_ATTRIBUTE_INFO_NONE = 0
  G_FILE_ATTRIBUTE_INFO_COPY_WITH_FILE = (1 SHL 0)
  G_FILE_ATTRIBUTE_INFO_COPY_WHEN_MOVED = (1 SHL 1)
END ENUM

ENUM GFileAttributeStatus
  G_FILE_ATTRIBUTE_STATUS_UNSET = 0
  G_FILE_ATTRIBUTE_STATUS_SET
  G_FILE_ATTRIBUTE_STATUS_ERROR_SETTING
END ENUM

ENUM GFileQueryInfoFlags
  G_FILE_QUERY_INFO_NONE = 0
  G_FILE_QUERY_INFO_NOFOLLOW_SYMLINKS = (1 SHL 0)
END ENUM

ENUM GFileCreateFlags
  G_FILE_CREATE_NONE = 0
  G_FILE_CREATE_PRIVATE = (1 SHL 0)
  G_FILE_CREATE_REPLACE_DESTINATION = (1 SHL 1)
END ENUM

ENUM GMountMountFlags
  G_MOUNT_MOUNT_NONE = 0
END ENUM

ENUM GMountUnmountFlags
  G_MOUNT_UNMOUNT_NONE = 0
  G_MOUNT_UNMOUNT_FORCE = (1 SHL 0)
END ENUM

ENUM GDriveStartFlags
  G_DRIVE_START_NONE = 0
END ENUM

ENUM GDriveStartStopType
  G_DRIVE_START_STOP_TYPE_UNKNOWN
  G_DRIVE_START_STOP_TYPE_SHUTDOWN
  G_DRIVE_START_STOP_TYPE_NETWORK
  G_DRIVE_START_STOP_TYPE_MULTIDISK
  G_DRIVE_START_STOP_TYPE_PASSWORD
END ENUM

ENUM GFileCopyFlags
  G_FILE_COPY_NONE = 0
  G_FILE_COPY_OVERWRITE = (1 SHL 0)
  G_FILE_COPY_BACKUP = (1 SHL 1)
  G_FILE_COPY_NOFOLLOW_SYMLINKS = (1 SHL 2)
  G_FILE_COPY_ALL_METADATA = (1 SHL 3)
  G_FILE_COPY_NO_FALLBACK_FOR_MOVE = (1 SHL 4)
  G_FILE_COPY_TARGET_DEFAULT_PERMS = (1 SHL 5)
END ENUM

ENUM GFileMonitorFlags
  G_FILE_MONITOR_NONE = 0
  G_FILE_MONITOR_WATCH_MOUNTS = (1 SHL 0)
  G_FILE_MONITOR_SEND_MOVED = (1 SHL 1)
END ENUM

ENUM GFileType
  G_FILE_TYPE_UNKNOWN = 0
  G_FILE_TYPE_REGULAR
  G_FILE_TYPE_DIRECTORY
  G_FILE_TYPE_SYMBOLIC_LINK
  G_FILE_TYPE_SPECIAL
  G_FILE_TYPE_SHORTCUT
  G_FILE_TYPE_MOUNTABLE
END ENUM

ENUM GFilesystemPreviewType
  G_FILESYSTEM_PREVIEW_TYPE_IF_ALWAYS = 0
  G_FILESYSTEM_PREVIEW_TYPE_IF_LOCAL
  G_FILESYSTEM_PREVIEW_TYPE_NEVER
END ENUM

ENUM GFileMonitorEvent
  G_FILE_MONITOR_EVENT_CHANGED
  G_FILE_MONITOR_EVENT_CHANGES_DONE_HINT
  G_FILE_MONITOR_EVENT_DELETED
  G_FILE_MONITOR_EVENT_CREATED
  G_FILE_MONITOR_EVENT_ATTRIBUTE_CHANGED
  G_FILE_MONITOR_EVENT_PRE_UNMOUNT
  G_FILE_MONITOR_EVENT_UNMOUNTED
  G_FILE_MONITOR_EVENT_MOVED
END ENUM

ENUM GIOErrorEnum
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
END ENUM

ENUM GAskPasswordFlags
  G_ASK_PASSWORD_NEED_PASSWORD = (1 SHL 0)
  G_ASK_PASSWORD_NEED_USERNAME = (1 SHL 1)
  G_ASK_PASSWORD_NEED_DOMAIN = (1 SHL 2)
  G_ASK_PASSWORD_SAVING_SUPPORTED = (1 SHL 3)
  G_ASK_PASSWORD_ANONYMOUS_SUPPORTED = (1 SHL 4)
END ENUM

ENUM GPasswordSave
  G_PASSWORD_SAVE_NEVER
  G_PASSWORD_SAVE_FOR_SESSION
  G_PASSWORD_SAVE_PERMANENTLY
END ENUM

ENUM GMountOperationResult
  G_MOUNT_OPERATION_HANDLED
  G_MOUNT_OPERATION_ABORTED
  G_MOUNT_OPERATION_UNHANDLED
END ENUM

ENUM GOutputStreamSpliceFlags
  G_OUTPUT_STREAM_SPLICE_NONE = 0
  G_OUTPUT_STREAM_SPLICE_CLOSE_SOURCE = (1 SHL 0)
  G_OUTPUT_STREAM_SPLICE_CLOSE_TARGET = (1 SHL 1)
END ENUM

ENUM GIOStreamSpliceFlags
  G_IO_STREAM_SPLICE_NONE = 0
  G_IO_STREAM_SPLICE_CLOSE_STREAM1 = (1 SHL 0)
  G_IO_STREAM_SPLICE_CLOSE_STREAM2 = (1 SHL 1)
  G_IO_STREAM_SPLICE_WAIT_FOR_BOTH = (1 SHL 2)
END ENUM

ENUM GEmblemOrigin
  G_EMBLEM_ORIGIN_UNKNOWN
  G_EMBLEM_ORIGIN_DEVICE
  G_EMBLEM_ORIGIN_LIVEMETADATA
  G_EMBLEM_ORIGIN_TAG
END ENUM

ENUM GResolverError
  G_RESOLVER_ERROR_NOT_FOUND
  G_RESOLVER_ERROR_TEMPORARY_FAILURE
  G_RESOLVER_ERROR_INTERNAL
END ENUM

ENUM GSocketFamily
  G_SOCKET_FAMILY_INVALID
#IFDEF GLIB_SYSDEF_AF_UNIX
  G_SOCKET_FAMILY_UNIX = GLIB_SYSDEF_AF_UNIX
#ENDIF ' GLIB_SYSDEF_AF_UNIX
  G_SOCKET_FAMILY_IPV4 = GLIB_SYSDEF_AF_INET
  G_SOCKET_FAMILY_IPV6 = GLIB_SYSDEF_AF_INET6
END ENUM

ENUM GSocketType
  G_SOCKET_TYPE_INVALID
  G_SOCKET_TYPE_STREAM
  G_SOCKET_TYPE_DATAGRAM
  G_SOCKET_TYPE_SEQPACKET
END ENUM

ENUM GSocketMsgFlags
  G_SOCKET_MSG_NONE
  G_SOCKET_MSG_OOB = GLIB_SYSDEF_MSG_OOB
  G_SOCKET_MSG_PEEK = GLIB_SYSDEF_MSG_PEEK
  G_SOCKET_MSG_DONTROUTE = GLIB_SYSDEF_MSG_DONTROUTE
END ENUM

ENUM GSocketProtocol
  G_SOCKET_PROTOCOL_UNKNOWN = -1
  G_SOCKET_PROTOCOL_DEFAULT = 0
  G_SOCKET_PROTOCOL_TCP = 6
  G_SOCKET_PROTOCOL_UDP = 17
  G_SOCKET_PROTOCOL_SCTP = 132
END ENUM

ENUM GZlibCompressorFormat
  G_ZLIB_COMPRESSOR_FORMAT_ZLIB
  G_ZLIB_COMPRESSOR_FORMAT_GZIP
  G_ZLIB_COMPRESSOR_FORMAT_RAW
END ENUM

ENUM GUnixSocketAddressType
  G_UNIX_SOCKET_ADDRESS_INVALID
  G_UNIX_SOCKET_ADDRESS_ANONYMOUS
  G_UNIX_SOCKET_ADDRESS_PATH
  G_UNIX_SOCKET_ADDRESS_ABSTRACT
  G_UNIX_SOCKET_ADDRESS_ABSTRACT_PADDED
END ENUM

ENUM GBusType
  G_BUS_TYPE_STARTER = -1
  G_BUS_TYPE_NONE = 0
  G_BUS_TYPE_SYSTEM = 1
  G_BUS_TYPE_SESSION = 2
END ENUM

ENUM GBusNameOwnerFlags
  G_BUS_NAME_OWNER_FLAGS_NONE = 0
  G_BUS_NAME_OWNER_FLAGS_ALLOW_REPLACEMENT = (1 SHL 0)
  G_BUS_NAME_OWNER_FLAGS_REPLACE = (1 SHL 1)
END ENUM

ENUM GBusNameWatcherFlags
  G_BUS_NAME_WATCHER_FLAGS_NONE = 0
  G_BUS_NAME_WATCHER_FLAGS_AUTO_START = (1 SHL 0)
END ENUM

ENUM GDBusProxyFlags
  G_DBUS_PROXY_FLAGS_NONE = 0
  G_DBUS_PROXY_FLAGS_DO_NOT_LOAD_PROPERTIES = (1 SHL 0)
  G_DBUS_PROXY_FLAGS_DO_NOT_CONNECT_SIGNALS = (1 SHL 1)
  G_DBUS_PROXY_FLAGS_DO_NOT_AUTO_START = (1 SHL 2)
END ENUM

ENUM GDBusError
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
END ENUM

ENUM GDBusConnectionFlags
  G_DBUS_CONNECTION_FLAGS_NONE = 0
  G_DBUS_CONNECTION_FLAGS_AUTHENTICATION_CLIENT = (1 SHL 0)
  G_DBUS_CONNECTION_FLAGS_AUTHENTICATION_SERVER = (1 SHL 1)
  G_DBUS_CONNECTION_FLAGS_AUTHENTICATION_ALLOW_ANONYMOUS = (1 SHL 2)
  G_DBUS_CONNECTION_FLAGS_MESSAGE_BUS_CONNECTION = (1 SHL 3)
  G_DBUS_CONNECTION_FLAGS_DELAY_MESSAGE_PROCESSING = (1 SHL 4)
END ENUM

ENUM GDBusCapabilityFlags
  G_DBUS_CAPABILITY_FLAGS_NONE = 0
  G_DBUS_CAPABILITY_FLAGS_UNIX_FD_PASSING = (1 SHL 0)
END ENUM

ENUM GDBusCallFlags
  G_DBUS_CALL_FLAGS_NONE = 0
  G_DBUS_CALL_FLAGS_NO_AUTO_START = (1 SHL 0)
END ENUM

ENUM GDBusMessageType
  G_DBUS_MESSAGE_TYPE_INVALID
  G_DBUS_MESSAGE_TYPE_METHOD_CALL
  G_DBUS_MESSAGE_TYPE_METHOD_RETURN
  G_DBUS_MESSAGE_TYPE_ERROR
  G_DBUS_MESSAGE_TYPE_SIGNAL
END ENUM

ENUM GDBusMessageFlags
  G_DBUS_MESSAGE_FLAGS_NONE = 0
  G_DBUS_MESSAGE_FLAGS_NO_REPLY_EXPECTED = (1 SHL 0)
  G_DBUS_MESSAGE_FLAGS_NO_AUTO_START = (1 SHL 1)
END ENUM

ENUM GDBusMessageHeaderField
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
END ENUM

ENUM GDBusPropertyInfoFlags
  G_DBUS_PROPERTY_INFO_FLAGS_NONE = 0
  G_DBUS_PROPERTY_INFO_FLAGS_READABLE = (1 SHL 0)
  G_DBUS_PROPERTY_INFO_FLAGS_WRITABLE = (1 SHL 1)
END ENUM

ENUM GDBusSubtreeFlags
  G_DBUS_SUBTREE_FLAGS_NONE = 0
  G_DBUS_SUBTREE_FLAGS_DISPATCH_TO_UNENUMERATED_NODES = (1 SHL 0)
END ENUM

ENUM GDBusServerFlags
  G_DBUS_SERVER_FLAGS_NONE = 0
  G_DBUS_SERVER_FLAGS_RUN_IN_THREAD = (1 SHL 0)
  G_DBUS_SERVER_FLAGS_AUTHENTICATION_ALLOW_ANONYMOUS = (1 SHL 1)
END ENUM

ENUM GDBusSignalFlags
  G_DBUS_SIGNAL_FLAGS_NONE = 0
  G_DBUS_SIGNAL_FLAGS_NO_MATCH_RULE = (1 SHL 0)
END ENUM

ENUM GDBusSendMessageFlags
  G_DBUS_SEND_MESSAGE_FLAGS_NONE = 0
  G_DBUS_SEND_MESSAGE_FLAGS_PRESERVE_SERIAL = (1 SHL 0)
END ENUM

ENUM GCredentialsType
  G_CREDENTIALS_TYPE_INVALID
  G_CREDENTIALS_TYPE_LINUX_UCRED
  G_CREDENTIALS_TYPE_FREEBSD_CMSGCRED
  G_CREDENTIALS_TYPE_OPENBSD_SOCKPEERCRED
END ENUM

ENUM GDBusMessageByteOrder
  G_DBUS_MESSAGE_BYTE_ORDER_BIG_ENDIAN = ASC(!"B")
  G_DBUS_MESSAGE_BYTE_ORDER_LITTLE_ENDIAN = ASC(!"l")
END ENUM

ENUM GApplicationFlags
  G_APPLICATION_FLAGS_NONE
  G_APPLICATION_IS_SERVICE = (1 SHL 0)
  G_APPLICATION_IS_LAUNCHER = (1 SHL 1)
  G_APPLICATION_HANDLES_OPEN = (1 SHL 2)
  G_APPLICATION_HANDLES_COMMAND_LINE = (1 SHL 3)
  G_APPLICATION_SEND_ENVIRONMENT = (1 SHL 4)
  G_APPLICATION_NON_UNIQUE = (1 SHL 5)
END ENUM

ENUM GTlsError
  G_TLS_ERROR_UNAVAILABLE
  G_TLS_ERROR_MISC
  G_TLS_ERROR_BAD_CERTIFICATE
  G_TLS_ERROR_NOT_TLS
  G_TLS_ERROR_HANDSHAKE
  G_TLS_ERROR_CERTIFICATE_REQUIRED
  G_TLS_ERROR_EOF
END ENUM

ENUM GTlsCertificateFlags
  G_TLS_CERTIFICATE_UNKNOWN_CA = (1 SHL 0)
  G_TLS_CERTIFICATE_BAD_IDENTITY = (1 SHL 1)
  G_TLS_CERTIFICATE_NOT_ACTIVATED = (1 SHL 2)
  G_TLS_CERTIFICATE_EXPIRED = (1 SHL 3)
  G_TLS_CERTIFICATE_REVOKED = (1 SHL 4)
  G_TLS_CERTIFICATE_INSECURE = (1 SHL 5)
  G_TLS_CERTIFICATE_GENERIC_ERROR = (1 SHL 6)
  G_TLS_CERTIFICATE_VALIDATE_ALL = &h007F
END ENUM

ENUM GTlsAuthenticationMode
  G_TLS_AUTHENTICATION_NONE
  G_TLS_AUTHENTICATION_REQUESTED
  G_TLS_AUTHENTICATION_REQUIRED
END ENUM

ENUM GTlsRehandshakeMode
  G_TLS_REHANDSHAKE_NEVER
  G_TLS_REHANDSHAKE_SAFELY
  G_TLS_REHANDSHAKE_UNSAFELY
END ENUM

ENUM _GTlsPasswordFlags
  G_TLS_PASSWORD_NONE = 0
  G_TLS_PASSWORD_RETRY = 1 SHL 1
  G_TLS_PASSWORD_MANY_TRIES = 1 SHL 2
  G_TLS_PASSWORD_FINAL_TRY = 1 SHL 3
END ENUM

TYPE AS _GTlsPasswordFlags GTlsPasswordFlags

ENUM GTlsInteractionResult
  G_TLS_INTERACTION_UNHANDLED
  G_TLS_INTERACTION_HANDLED
  G_TLS_INTERACTION_FAILED
END ENUM

ENUM GDBusInterfaceSkeletonFlags
  G_DBUS_INTERFACE_SKELETON_FLAGS_NONE = 0
  G_DBUS_INTERFACE_SKELETON_FLAGS_HANDLE_METHOD_INVOCATIONS_IN_THR = (1 SHL 0)
END ENUM

ENUM GDBusObjectManagerClientFlags
  G_DBUS_OBJECT_MANAGER_CLIENT_FLAGS_NONE = 0
  G_DBUS_OBJECT_MANAGER_CLIENT_FLAGS_DO_NOT_AUTO_START = (1 SHL 0)
END ENUM

ENUM GTlsDatabaseVerifyFlags
  G_TLS_DATABASE_VERIFY_NONE = 0
END ENUM

ENUM GTlsDatabaseLookupFlags
  G_TLS_DATABASE_LOOKUP_NONE = 0
  G_TLS_DATABASE_LOOKUP_KEYPAIR = 1
END ENUM

ENUM GIOModuleScopeFlags
  G_IO_MODULE_SCOPE_NONE
  G_IO_MODULE_SCOPE_BLOCK_DUPLICATES
END ENUM

#ENDIF ' __GIO_ENUMS_H__

TYPE GAppLaunchContext AS _GAppLaunchContext
TYPE GAppInfo AS _GAppInfo
TYPE GAsyncResult AS _GAsyncResult
TYPE GAsyncInitable AS _GAsyncInitable
TYPE GBufferedInputStream AS _GBufferedInputStream
TYPE GBufferedOutputStream AS _GBufferedOutputStream
TYPE GCancellable AS _GCancellable
TYPE GCharsetConverter AS _GCharsetConverter
TYPE GConverter AS _GConverter
TYPE GConverterInputStream AS _GConverterInputStream
TYPE GConverterOutputStream AS _GConverterOutputStream
TYPE GDataInputStream AS _GDataInputStream
TYPE GSimplePermission AS _GSimplePermission
TYPE GZlibCompressor AS _GZlibCompressor
TYPE GZlibDecompressor AS _GZlibDecompressor
TYPE GSimpleActionGroup AS _GSimpleActionGroup
TYPE GDBusActionGroup AS _GDBusActionGroup
TYPE GActionMap AS _GActionMap
TYPE GActionGroup AS _GActionGroup
TYPE GSimpleAction AS _GSimpleAction
TYPE GAction AS _GAction
TYPE GApplication AS _GApplication
TYPE GApplicationCommandLine AS _GApplicationCommandLine
TYPE GSettingsBackend AS _GSettingsBackend
TYPE GSettings AS _GSettings
TYPE GPermission AS _GPermission
TYPE GMenuModel AS _GMenuModel
TYPE GDrive AS _GDrive
TYPE GFileEnumerator AS _GFileEnumerator
TYPE GFileMonitor AS _GFileMonitor
TYPE GFilterInputStream AS _GFilterInputStream
TYPE GFilterOutputStream AS _GFilterOutputStream
TYPE GFile AS _GFile
TYPE GFileInfo AS _GFileInfo
TYPE GFileAttributeMatcher AS _GFileAttributeMatcher
TYPE GFileAttributeInfo AS _GFileAttributeInfo
TYPE GFileAttributeInfoList AS _GFileAttributeInfoList
TYPE GFileDescriptorBased AS _GFileDescriptorBased
TYPE GFileInputStream AS _GFileInputStream
TYPE GFileOutputStream AS _GFileOutputStream
TYPE GFileIOStream AS _GFileIOStream
TYPE GFileIcon AS _GFileIcon
TYPE GFilenameCompleter AS _GFilenameCompleter
TYPE GIcon AS _GIcon
TYPE GInetAddress AS _GInetAddress
TYPE GInetAddressMask AS _GInetAddressMask
TYPE GInetSocketAddress AS _GInetSocketAddress
TYPE GInputStream AS _GInputStream
TYPE GInitable AS _GInitable
TYPE GIOModule AS _GIOModule
TYPE GIOExtensionPoint AS _GIOExtensionPoint
TYPE GIOExtension AS _GIOExtension
TYPE GIOSchedulerJob AS _GIOSchedulerJob
TYPE GIOStreamAdapter AS _GIOStreamAdapter
TYPE GLoadableIcon AS _GLoadableIcon
TYPE GMemoryInputStream AS _GMemoryInputStream
TYPE GMemoryOutputStream AS _GMemoryOutputStream
TYPE GMount AS _GMount
TYPE GMountOperation AS _GMountOperation
TYPE GNetworkAddress AS _GNetworkAddress
TYPE GNetworkMonitor AS _GNetworkMonitor
TYPE GNetworkService AS _GNetworkService
TYPE GOutputStream AS _GOutputStream
TYPE GIOStream AS _GIOStream
TYPE GPollableInputStream AS _GPollableInputStream
TYPE GPollableOutputStream AS _GPollableOutputStream
TYPE GResolver AS _GResolver
TYPE GSeekable AS _GSeekable
TYPE GSimpleAsyncResult AS _GSimpleAsyncResult
TYPE GSocket AS _GSocket
TYPE GSocketControlMessage AS _GSocketControlMessage
TYPE GSocketClient AS _GSocketClient
TYPE GSocketConnection AS _GSocketConnection
TYPE GSocketListener AS _GSocketListener
TYPE GSocketService AS _GSocketService
TYPE GSocketAddress AS _GSocketAddress
TYPE GSocketAddressEnumerator AS _GSocketAddressEnumerator
TYPE GSocketConnectable AS _GSocketConnectable
TYPE GSrvTarget AS _GSrvTarget
TYPE GTcpConnection AS _GTcpConnection
TYPE GTcpWrapperConnection AS _GTcpWrapperConnection
TYPE GThreadedSocketService AS _GThreadedSocketService
TYPE GThemedIcon AS _GThemedIcon
TYPE GTlsCertificate AS _GTlsCertificate
TYPE GTlsClientConnection AS _GTlsClientConnection
TYPE GTlsConnection AS _GTlsConnection
TYPE GTlsDatabase AS _GTlsDatabase
TYPE GTlsFileDatabase AS _GTlsFileDatabase
TYPE GTlsInteraction AS _GTlsInteraction
TYPE GTlsPassword AS _GTlsPassword
TYPE GTlsServerConnection AS _GTlsServerConnection
TYPE GVfs AS _GVfs
TYPE GProxyResolver AS _GProxyResolver
TYPE GProxy AS _GProxy
TYPE GProxyAddress AS _GProxyAddress
TYPE GProxyAddressEnumerator AS _GProxyAddressEnumerator
TYPE GVolume AS _GVolume
TYPE GVolumeMonitor AS _GVolumeMonitor
TYPE GAsyncReadyCallback AS SUB(BYVAL AS GObject PTR, BYVAL AS GAsyncResult PTR, BYVAL AS gpointer)
TYPE GFileProgressCallback AS SUB(BYVAL AS goffset, BYVAL AS goffset, BYVAL AS gpointer)
TYPE GFileReadMoreCallback AS FUNCTION(BYVAL AS CONST ZSTRING PTR, BYVAL AS goffset, BYVAL AS gpointer) AS gboolean
TYPE GIOSchedulerJobFunc AS FUNCTION(BYVAL AS GIOSchedulerJob PTR, BYVAL AS GCancellable PTR, BYVAL AS gpointer) AS gboolean
TYPE GSimpleAsyncThreadFunc AS SUB(BYVAL AS GSimpleAsyncResult PTR, BYVAL AS GObject PTR, BYVAL AS GCancellable PTR)
TYPE GSocketSourceFunc AS FUNCTION(BYVAL AS GSocket PTR, BYVAL AS GIOCondition, BYVAL AS gpointer) AS gboolean
TYPE GInputVector AS _GInputVector

TYPE _GInputVector
  AS gpointer buffer
  AS gsize size
END TYPE

TYPE GOutputVector AS _GOutputVector

TYPE _GOutputVector
  AS gconstpointer buffer
  AS gsize size
END TYPE

TYPE GCredentials AS _GCredentials
TYPE GUnixCredentialsMessage AS _GUnixCredentialsMessage
TYPE GUnixFDList AS _GUnixFDList
TYPE GDBusMessage AS _GDBusMessage
TYPE GDBusConnection AS _GDBusConnection
TYPE GDBusProxy AS _GDBusProxy
TYPE GDBusMethodInvocation AS _GDBusMethodInvocation
TYPE GDBusServer AS _GDBusServer
TYPE GDBusAuthObserver AS _GDBusAuthObserver
TYPE GDBusErrorEntry AS _GDBusErrorEntry
TYPE GDBusInterfaceVTable AS _GDBusInterfaceVTable
TYPE GDBusSubtreeVTable AS _GDBusSubtreeVTable
TYPE GDBusAnnotationInfo AS _GDBusAnnotationInfo
TYPE GDBusArgInfo AS _GDBusArgInfo
TYPE GDBusMethodInfo AS _GDBusMethodInfo
TYPE GDBusSignalInfo AS _GDBusSignalInfo
TYPE GDBusPropertyInfo AS _GDBusPropertyInfo
TYPE GDBusInterfaceInfo AS _GDBusInterfaceInfo
TYPE GDBusNodeInfo AS _GDBusNodeInfo
TYPE GCancellableSourceFunc AS FUNCTION(BYVAL AS GCancellable PTR, BYVAL AS gpointer) AS gboolean
TYPE GPollableSourceFunc AS FUNCTION(BYVAL AS GObject PTR, BYVAL AS gpointer) AS gboolean
TYPE GDBusInterface AS _GDBusInterface
TYPE GDBusInterfaceSkeleton AS _GDBusInterfaceSkeleton
TYPE GDBusObject AS _GDBusObject
TYPE GDBusObjectSkeleton AS _GDBusObjectSkeleton
TYPE GDBusObjectProxy AS _GDBusObjectProxy
TYPE GDBusObjectManager AS _GDBusObjectManager
TYPE GDBusObjectManagerClient AS _GDBusObjectManagerClient
TYPE GDBusObjectManagerServer AS _GDBusObjectManagerServer
TYPE GDBusProxyTypeFunc AS FUNCTION(BYVAL AS GDBusObjectManagerClient PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS gpointer) AS GType

#ENDIF ' __GIO_TYPES_H__

#IFNDEF __G_ACTION_H__
#DEFINE __G_ACTION_H__

#DEFINE G_TYPE_ACTION (g_action_get_type ())
#DEFINE G_ACTION(inst) (G_TYPE_CHECK_INSTANCE_CAST ((inst), _
                                                             G_TYPE_ACTION, GAction))
#DEFINE G_IS_ACTION(inst) (G_TYPE_CHECK_INSTANCE_TYPE ((inst), G_TYPE_ACTION))
#DEFINE G_ACTION_GET_IFACE(inst) (G_TYPE_INSTANCE_GET_INTERFACE ((inst), _
                                                             G_TYPE_ACTION, GActionInterface))

TYPE GActionInterface AS _GActionInterface

TYPE _GActionInterface
  AS GTypeInterface g_iface
  get_name AS FUNCTION(BYVAL AS GAction PTR) AS CONST gchar PTR
  get_parameter_type AS FUNCTION(BYVAL AS GAction PTR) AS CONST GVariantType PTR
  get_state_type AS FUNCTION(BYVAL AS GAction PTR) AS CONST GVariantType PTR
  get_state_hint AS FUNCTION(BYVAL AS GAction PTR) AS GVariant PTR
  get_enabled AS FUNCTION(BYVAL AS GAction PTR) AS gboolean
  get_state AS FUNCTION(BYVAL AS GAction PTR) AS GVariant PTR
  change_state AS SUB(BYVAL AS GAction PTR, BYVAL AS GVariant PTR)
  activate AS SUB(BYVAL AS GAction PTR, BYVAL AS GVariant PTR)
END TYPE

DECLARE FUNCTION g_action_get_type() AS GType
DECLARE FUNCTION g_action_get_name(BYVAL AS GAction PTR) AS CONST gchar PTR
DECLARE FUNCTION g_action_get_parameter_type(BYVAL AS GAction PTR) AS CONST GVariantType PTR
DECLARE FUNCTION g_action_get_state_type(BYVAL AS GAction PTR) AS CONST GVariantType PTR
DECLARE FUNCTION g_action_get_state_hint(BYVAL AS GAction PTR) AS GVariant PTR
DECLARE FUNCTION g_action_get_enabled(BYVAL AS GAction PTR) AS gboolean
DECLARE FUNCTION g_action_get_state(BYVAL AS GAction PTR) AS GVariant PTR
DECLARE SUB g_action_change_state(BYVAL AS GAction PTR, BYVAL AS GVariant PTR)
DECLARE SUB g_action_activate(BYVAL AS GAction PTR, BYVAL AS GVariant PTR)

#ENDIF ' __G_ACTION_H__

#IFNDEF __G_ACTION_GROUP_H__
#DEFINE __G_ACTION_GROUP_H__

#DEFINE G_TYPE_ACTION_GROUP (g_action_group_get_type ())
#DEFINE G_ACTION_GROUP(inst) (G_TYPE_CHECK_INSTANCE_CAST ((inst), _
                                                             G_TYPE_ACTION_GROUP, GActionGroup))
#DEFINE G_IS_ACTION_GROUP(inst) (G_TYPE_CHECK_INSTANCE_TYPE ((inst), _
                                                             G_TYPE_ACTION_GROUP))
#DEFINE G_ACTION_GROUP_GET_IFACE(inst) (G_TYPE_INSTANCE_GET_INTERFACE ((inst), _
                                                             G_TYPE_ACTION_GROUP, GActionGroupInterface))

TYPE GActionGroupInterface AS _GActionGroupInterface

TYPE _GActionGroupInterface
  AS GTypeInterface g_iface
  has_action AS FUNCTION(BYVAL AS GActionGroup PTR, BYVAL AS CONST gchar PTR) AS gboolean
  list_actions AS FUNCTION(BYVAL AS GActionGroup PTR) AS gchar PTR PTR
  get_action_enabled AS FUNCTION(BYVAL AS GActionGroup PTR, BYVAL AS CONST gchar PTR) AS gboolean
  get_action_parameter_type AS FUNCTION(BYVAL AS GActionGroup PTR, BYVAL AS CONST gchar PTR) AS CONST GVariantType PTR
  get_action_state_type AS FUNCTION(BYVAL AS GActionGroup PTR, BYVAL AS CONST gchar PTR) AS CONST GVariantType PTR
  get_action_state_hint AS FUNCTION(BYVAL AS GActionGroup PTR, BYVAL AS CONST gchar PTR) AS GVariant PTR
  get_action_state AS FUNCTION(BYVAL AS GActionGroup PTR, BYVAL AS CONST gchar PTR) AS GVariant PTR
  change_action_state AS SUB(BYVAL AS GActionGroup PTR, BYVAL AS CONST gchar PTR, BYVAL AS GVariant PTR)
  activate_action AS SUB(BYVAL AS GActionGroup PTR, BYVAL AS CONST gchar PTR, BYVAL AS GVariant PTR)
  action_added AS SUB(BYVAL AS GActionGroup PTR, BYVAL AS CONST gchar PTR)
  action_removed AS SUB(BYVAL AS GActionGroup PTR, BYVAL AS CONST gchar PTR)
  action_enabled_changed AS SUB(BYVAL AS GActionGroup PTR, BYVAL AS CONST gchar PTR, BYVAL AS gboolean)
  action_state_changed AS SUB(BYVAL AS GActionGroup PTR, BYVAL AS CONST gchar PTR, BYVAL AS GVariant PTR)
  query_action AS FUNCTION(BYVAL AS GActionGroup PTR, BYVAL AS CONST gchar PTR, BYVAL AS gboolean PTR, BYVAL AS CONST GVariantType PTR PTR, BYVAL AS CONST GVariantType PTR PTR, BYVAL AS GVariant PTR PTR, BYVAL AS GVariant PTR PTR) AS gboolean
END TYPE

DECLARE FUNCTION g_action_group_get_type() AS GType
DECLARE FUNCTION g_action_group_has_action(BYVAL AS GActionGroup PTR, BYVAL AS CONST gchar PTR) AS gboolean
DECLARE FUNCTION g_action_group_list_actions(BYVAL AS GActionGroup PTR) AS gchar PTR PTR
DECLARE FUNCTION g_action_group_get_action_parameter_type(BYVAL AS GActionGroup PTR, BYVAL AS CONST gchar PTR) AS CONST GVariantType PTR
DECLARE FUNCTION g_action_group_get_action_state_type(BYVAL AS GActionGroup PTR, BYVAL AS CONST gchar PTR) AS CONST GVariantType PTR
DECLARE FUNCTION g_action_group_get_action_state_hint(BYVAL AS GActionGroup PTR, BYVAL AS CONST gchar PTR) AS GVariant PTR
DECLARE FUNCTION g_action_group_get_action_enabled(BYVAL AS GActionGroup PTR, BYVAL AS CONST gchar PTR) AS gboolean
DECLARE FUNCTION g_action_group_get_action_state(BYVAL AS GActionGroup PTR, BYVAL AS CONST gchar PTR) AS GVariant PTR
DECLARE SUB g_action_group_change_action_state(BYVAL AS GActionGroup PTR, BYVAL AS CONST gchar PTR, BYVAL AS GVariant PTR)
DECLARE SUB g_action_group_activate_action(BYVAL AS GActionGroup PTR, BYVAL AS CONST gchar PTR, BYVAL AS GVariant PTR)
DECLARE SUB g_action_group_action_added(BYVAL AS GActionGroup PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB g_action_group_action_removed(BYVAL AS GActionGroup PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB g_action_group_action_enabled_changed(BYVAL AS GActionGroup PTR, BYVAL AS CONST gchar PTR, BYVAL AS gboolean)
DECLARE SUB g_action_group_action_state_changed(BYVAL AS GActionGroup PTR, BYVAL AS CONST gchar PTR, BYVAL AS GVariant PTR)
DECLARE FUNCTION g_action_group_query_action(BYVAL AS GActionGroup PTR, BYVAL AS CONST gchar PTR, BYVAL AS gboolean PTR, BYVAL AS CONST GVariantType PTR PTR, BYVAL AS CONST GVariantType PTR PTR, BYVAL AS GVariant PTR PTR, BYVAL AS GVariant PTR PTR) AS gboolean

#ENDIF ' __G_ACTION_GROUP_H__

#IFNDEF __G_ACTION_GROUP_EXPORTER_H__
#DEFINE __G_ACTION_GROUP_EXPORTER_H__

DECLARE FUNCTION g_dbus_connection_export_action_group(BYVAL AS GDBusConnection PTR, BYVAL AS CONST gchar PTR, BYVAL AS GActionGroup PTR, BYVAL AS GError PTR PTR) AS guint
DECLARE SUB g_dbus_connection_unexport_action_group(BYVAL AS GDBusConnection PTR, BYVAL AS guint)

#ENDIF ' __G_ACTION_GROUP_EXPORTER_H__

' 002 start from: glib-2.31.4/gio/gio.h ==> glib-2.31.4/gio/gactionmap.h

#IFNDEF __G_ACTION_MAP_H__
#DEFINE __G_ACTION_MAP_H__

#DEFINE G_TYPE_ACTION_MAP (g_action_map_get_type ())
#DEFINE G_ACTION_MAP(inst) (G_TYPE_CHECK_INSTANCE_CAST ((inst), _
                                                             G_TYPE_ACTION_MAP, GActionMap))
#DEFINE G_IS_ACTION_MAP(inst) (G_TYPE_CHECK_INSTANCE_TYPE ((inst), _
                                                             G_TYPE_ACTION_MAP))
#DEFINE G_ACTION_MAP_GET_IFACE(inst) (G_TYPE_INSTANCE_GET_INTERFACE ((inst), _
                                                             G_TYPE_ACTION_MAP, GActionMapInterface))

TYPE GActionMapInterface AS _GActionMapInterface
TYPE GActionEntry AS _GActionEntry

TYPE _GActionMapInterface
  AS GTypeInterface g_iface
  lookup_action AS FUNCTION(BYVAL AS GActionMap PTR, BYVAL AS CONST gchar PTR) AS GAction PTR
  add_action AS SUB(BYVAL AS GActionMap PTR, BYVAL AS GAction PTR)
  remove_action AS SUB(BYVAL AS GActionMap PTR, BYVAL AS CONST gchar PTR)
END TYPE

TYPE _GActionEntry
  AS CONST gchar PTR name
  activate AS SUB(BYVAL AS GSimpleAction PTR, BYVAL AS GVariant PTR, BYVAL AS gpointer)
  AS CONST gchar PTR parameter_type
  AS CONST gchar PTR state
  change_state AS SUB(BYVAL AS GSimpleAction PTR, BYVAL AS GVariant PTR, BYVAL AS gpointer)
  AS gsize padding(2)
END TYPE

DECLARE FUNCTION g_action_map_get_type() AS GType
DECLARE FUNCTION g_action_map_lookup_action(BYVAL AS GActionMap PTR, BYVAL AS CONST gchar PTR) AS GAction PTR
DECLARE SUB g_action_map_add_action(BYVAL AS GActionMap PTR, BYVAL AS GAction PTR)
DECLARE SUB g_action_map_remove_action(BYVAL AS GActionMap PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB g_action_map_add_action_entries(BYVAL AS GActionMap PTR, BYVAL AS CONST GActionEntry PTR, BYVAL AS gint, BYVAL AS gpointer)

#ENDIF ' __G_ACTION_MAP_H__
#IFNDEF __G_APP_INFO_H__
#DEFINE __G_APP_INFO_H__

#DEFINE G_TYPE_APP_INFO (g_app_info_get_type ())
#DEFINE G_APP_INFO(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), G_TYPE_APP_INFO, GAppInfo))
#DEFINE G_IS_APP_INFO(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), G_TYPE_APP_INFO))
#DEFINE G_APP_INFO_GET_IFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), G_TYPE_APP_INFO, GAppInfoIface))
#DEFINE G_TYPE_APP_LAUNCH_CONTEXT (g_app_launch_context_get_type ())
#DEFINE G_APP_LAUNCH_CONTEXT(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_APP_LAUNCH_CONTEXT, GAppLaunchContext))
#DEFINE G_APP_LAUNCH_CONTEXT_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_APP_LAUNCH_CONTEXT, GAppLaunchContextClass))
#DEFINE G_IS_APP_LAUNCH_CONTEXT(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_APP_LAUNCH_CONTEXT))
#DEFINE G_IS_APP_LAUNCH_CONTEXT_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), G_TYPE_APP_LAUNCH_CONTEXT))
#DEFINE G_APP_LAUNCH_CONTEXT_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), G_TYPE_APP_LAUNCH_CONTEXT, GAppLaunchContextClass))

TYPE GAppLaunchContextClass AS _GAppLaunchContextClass
TYPE GAppLaunchContextPrivate AS _GAppLaunchContextPrivate
TYPE GAppInfoIface AS _GAppInfoIface

TYPE _GAppInfoIface
  AS GTypeInterface g_iface
  dup AS FUNCTION(BYVAL AS GAppInfo PTR) AS GAppInfo PTR
  equal AS FUNCTION(BYVAL AS GAppInfo PTR, BYVAL AS GAppInfo PTR) AS gboolean
  get_id AS FUNCTION(BYVAL AS GAppInfo PTR) AS CONST ZSTRING PTR
  get_name AS FUNCTION(BYVAL AS GAppInfo PTR) AS CONST ZSTRING PTR
  get_description AS FUNCTION(BYVAL AS GAppInfo PTR) AS CONST ZSTRING PTR
  get_executable AS FUNCTION(BYVAL AS GAppInfo PTR) AS CONST ZSTRING PTR
  get_icon AS FUNCTION(BYVAL AS GAppInfo PTR) AS GIcon PTR
  launch AS FUNCTION(BYVAL AS GAppInfo PTR, BYVAL AS GList PTR, BYVAL AS GAppLaunchContext PTR, BYVAL AS GError PTR PTR) AS gboolean
  supports_uris AS FUNCTION(BYVAL AS GAppInfo PTR) AS gboolean
  supports_files AS FUNCTION(BYVAL AS GAppInfo PTR) AS gboolean
  launch_uris AS FUNCTION(BYVAL AS GAppInfo PTR, BYVAL AS GList PTR, BYVAL AS GAppLaunchContext PTR, BYVAL AS GError PTR PTR) AS gboolean
  should_show AS FUNCTION(BYVAL AS GAppInfo PTR) AS gboolean
  set_as_default_for_type AS FUNCTION(BYVAL AS GAppInfo PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS GError PTR PTR) AS gboolean
  set_as_default_for_extension AS FUNCTION(BYVAL AS GAppInfo PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS GError PTR PTR) AS gboolean
  add_supports_type AS FUNCTION(BYVAL AS GAppInfo PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS GError PTR PTR) AS gboolean
  can_remove_supports_type AS FUNCTION(BYVAL AS GAppInfo PTR) AS gboolean
  remove_supports_type AS FUNCTION(BYVAL AS GAppInfo PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS GError PTR PTR) AS gboolean
  can_delete AS FUNCTION(BYVAL AS GAppInfo PTR) AS gboolean
  do_delete AS FUNCTION(BYVAL AS GAppInfo PTR) AS gboolean
  get_commandline AS FUNCTION(BYVAL AS GAppInfo PTR) AS CONST ZSTRING PTR
  get_display_name AS FUNCTION(BYVAL AS GAppInfo PTR) AS CONST ZSTRING PTR
  set_as_last_used_for_type AS FUNCTION(BYVAL AS GAppInfo PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS GError PTR PTR) AS gboolean
END TYPE

DECLARE FUNCTION g_app_info_get_type() AS GType
DECLARE FUNCTION g_app_info_create_from_commandline(BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS GAppInfoCreateFlags, BYVAL AS GError PTR PTR) AS GAppInfo PTR
DECLARE FUNCTION g_app_info_dup(BYVAL AS GAppInfo PTR) AS GAppInfo PTR
DECLARE FUNCTION g_app_info_equal(BYVAL AS GAppInfo PTR, BYVAL AS GAppInfo PTR) AS gboolean
DECLARE FUNCTION g_app_info_get_id(BYVAL AS GAppInfo PTR) AS CONST ZSTRING PTR
DECLARE FUNCTION g_app_info_get_name(BYVAL AS GAppInfo PTR) AS CONST ZSTRING PTR
DECLARE FUNCTION g_app_info_get_display_name(BYVAL AS GAppInfo PTR) AS CONST ZSTRING PTR
DECLARE FUNCTION g_app_info_get_description(BYVAL AS GAppInfo PTR) AS CONST ZSTRING PTR
DECLARE FUNCTION g_app_info_get_executable(BYVAL AS GAppInfo PTR) AS CONST ZSTRING PTR
DECLARE FUNCTION g_app_info_get_commandline(BYVAL AS GAppInfo PTR) AS CONST ZSTRING PTR
DECLARE FUNCTION g_app_info_get_icon(BYVAL AS GAppInfo PTR) AS GIcon PTR
DECLARE FUNCTION g_app_info_launch(BYVAL AS GAppInfo PTR, BYVAL AS GList PTR, BYVAL AS GAppLaunchContext PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_app_info_supports_uris(BYVAL AS GAppInfo PTR) AS gboolean
DECLARE FUNCTION g_app_info_supports_files(BYVAL AS GAppInfo PTR) AS gboolean
DECLARE FUNCTION g_app_info_launch_uris(BYVAL AS GAppInfo PTR, BYVAL AS GList PTR, BYVAL AS GAppLaunchContext PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_app_info_should_show(BYVAL AS GAppInfo PTR) AS gboolean
DECLARE FUNCTION g_app_info_set_as_default_for_type(BYVAL AS GAppInfo PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_app_info_set_as_default_for_extension(BYVAL AS GAppInfo PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_app_info_add_supports_type(BYVAL AS GAppInfo PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_app_info_can_remove_supports_type(BYVAL AS GAppInfo PTR) AS gboolean
DECLARE FUNCTION g_app_info_remove_supports_type(BYVAL AS GAppInfo PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_app_info_can_delete(BYVAL AS GAppInfo PTR) AS gboolean
DECLARE FUNCTION g_app_info_delete(BYVAL AS GAppInfo PTR) AS gboolean
DECLARE FUNCTION g_app_info_set_as_last_used_for_type(BYVAL AS GAppInfo PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_app_info_get_all() AS GList PTR
DECLARE FUNCTION g_app_info_get_all_for_type(BYVAL AS CONST ZSTRING PTR) AS GList PTR
DECLARE FUNCTION g_app_info_get_recommended_for_type(BYVAL AS CONST gchar PTR) AS GList PTR
DECLARE FUNCTION g_app_info_get_fallback_for_type(BYVAL AS CONST gchar PTR) AS GList PTR
DECLARE SUB g_app_info_reset_type_associations(BYVAL AS CONST ZSTRING PTR)
DECLARE FUNCTION g_app_info_get_default_for_type(BYVAL AS CONST ZSTRING PTR, BYVAL AS gboolean) AS GAppInfo PTR
DECLARE FUNCTION g_app_info_get_default_for_uri_scheme(BYVAL AS CONST ZSTRING PTR) AS GAppInfo PTR
DECLARE FUNCTION g_app_info_launch_default_for_uri(BYVAL AS CONST ZSTRING PTR, BYVAL AS GAppLaunchContext PTR, BYVAL AS GError PTR PTR) AS gboolean

TYPE _GAppLaunchContext
  AS GObject parent_instance
  AS GAppLaunchContextPrivate PTR priv
END TYPE

TYPE _GAppLaunchContextClass
  AS GObjectClass parent_class
  get_display AS FUNCTION(BYVAL AS GAppLaunchContext PTR, BYVAL AS GAppInfo PTR, BYVAL AS GList PTR) AS ZSTRING PTR
  get_startup_notify_id AS FUNCTION(BYVAL AS GAppLaunchContext PTR, BYVAL AS GAppInfo PTR, BYVAL AS GList PTR) AS ZSTRING PTR
  launch_failed AS SUB(BYVAL AS GAppLaunchContext PTR, BYVAL AS CONST ZSTRING PTR)
  _g_reserved1 AS SUB()
  _g_reserved2 AS SUB()
  _g_reserved3 AS SUB()
  _g_reserved4 AS SUB()
  _g_reserved5 AS SUB()
END TYPE

DECLARE FUNCTION g_app_launch_context_get_type() AS GType
DECLARE FUNCTION g_app_launch_context_new() AS GAppLaunchContext PTR
DECLARE SUB g_app_launch_context_setenv(BYVAL AS GAppLaunchContext PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST ZSTRING PTR)
DECLARE SUB g_app_launch_context_unsetenv(BYVAL AS GAppLaunchContext PTR, BYVAL AS CONST ZSTRING PTR)
DECLARE FUNCTION g_app_launch_context_get_environment(BYVAL AS GAppLaunchContext PTR) AS ZSTRING PTR PTR
DECLARE FUNCTION g_app_launch_context_get_display(BYVAL AS GAppLaunchContext PTR, BYVAL AS GAppInfo PTR, BYVAL AS GList PTR) AS ZSTRING PTR
DECLARE FUNCTION g_app_launch_context_get_startup_notify_id(BYVAL AS GAppLaunchContext PTR, BYVAL AS GAppInfo PTR, BYVAL AS GList PTR) AS ZSTRING PTR
DECLARE SUB g_app_launch_context_launch_failed(BYVAL AS GAppLaunchContext PTR, BYVAL AS CONST ZSTRING PTR)

#ENDIF ' __G_APP_INFO_H__


#IFNDEF __G_APPLICATION_H__
#DEFINE __G_APPLICATION_H__

#DEFINE G_TYPE_APPLICATION (g_application_get_type ())
#DEFINE G_APPLICATION(inst) (G_TYPE_CHECK_INSTANCE_CAST ((inst), _
                                                             G_TYPE_APPLICATION, GApplication))
#DEFINE G_APPLICATION_CLASS(class) (G_TYPE_CHECK_CLASS_CAST ((class), _
                                                             G_TYPE_APPLICATION, GApplicationClass))
#DEFINE G_IS_APPLICATION(inst) (G_TYPE_CHECK_INSTANCE_TYPE ((inst), G_TYPE_APPLICATION))
#DEFINE G_IS_APPLICATION_CLASS(class) (G_TYPE_CHECK_CLASS_TYPE ((class), G_TYPE_APPLICATION))
#DEFINE G_APPLICATION_GET_CLASS(inst) (G_TYPE_INSTANCE_GET_CLASS ((inst), _
                                                             G_TYPE_APPLICATION, GApplicationClass))

TYPE GApplicationPrivate AS _GApplicationPrivate
TYPE GApplicationClass AS _GApplicationClass

TYPE _GApplication
  AS GObject parent_instance
  AS GApplicationPrivate PTR priv
END TYPE

TYPE _GApplicationClass
  AS GObjectClass parent_class
  startup AS SUB(BYVAL AS GApplication PTR)
  activate AS SUB(BYVAL AS GApplication PTR)
  open_ AS SUB(BYVAL AS GApplication PTR, BYVAL AS GFile PTR PTR, BYVAL AS gint, BYVAL AS CONST gchar PTR)
  command_line AS FUNCTION(BYVAL AS GApplication PTR, BYVAL AS GApplicationCommandLine PTR) AS INTEGER
  local_command_line AS FUNCTION(BYVAL AS GApplication PTR, BYVAL AS gchar PTR PTR PTR, BYVAL AS INTEGER PTR) AS gboolean
  before_emit AS SUB(BYVAL AS GApplication PTR, BYVAL AS GVariant PTR)
  after_emit AS SUB(BYVAL AS GApplication PTR, BYVAL AS GVariant PTR)
  add_platform_data AS SUB(BYVAL AS GApplication PTR, BYVAL AS GVariantBuilder PTR)
  quit_mainloop AS SUB(BYVAL AS GApplication PTR)
  run_mainloop AS SUB(BYVAL AS GApplication PTR)
  shutdown AS SUB(BYVAL AS GApplication PTR)
  AS gpointer padding(10)
END TYPE

DECLARE FUNCTION g_application_get_type() AS GType
DECLARE FUNCTION g_application_id_is_valid(BYVAL AS CONST gchar PTR) AS gboolean
DECLARE FUNCTION g_application_new(BYVAL AS CONST gchar PTR, BYVAL AS GApplicationFlags) AS GApplication PTR
DECLARE FUNCTION g_application_get_application_id(BYVAL AS GApplication PTR) AS CONST gchar PTR
DECLARE SUB g_application_set_application_id(BYVAL AS GApplication PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION g_application_get_inactivity_timeout(BYVAL AS GApplication PTR) AS guint
DECLARE SUB g_application_set_inactivity_timeout(BYVAL AS GApplication PTR, BYVAL AS guint)
DECLARE FUNCTION g_application_get_flags(BYVAL AS GApplication PTR) AS GApplicationFlags
DECLARE SUB g_application_set_flags(BYVAL AS GApplication PTR, BYVAL AS GApplicationFlags)
DECLARE SUB g_application_set_action_group(BYVAL AS GApplication PTR, BYVAL AS GActionGroup PTR)
DECLARE SUB g_application_set_app_menu(BYVAL AS GApplication PTR, BYVAL AS GMenuModel PTR)
DECLARE FUNCTION g_application_get_app_menu(BYVAL AS GApplication PTR) AS GMenuModel PTR
DECLARE SUB g_application_set_menubar(BYVAL AS GApplication PTR, BYVAL AS GMenuModel PTR)
DECLARE FUNCTION g_application_get_menubar(BYVAL AS GApplication PTR) AS GMenuModel PTR
DECLARE FUNCTION g_application_get_is_registered(BYVAL AS GApplication PTR) AS gboolean
DECLARE FUNCTION g_application_get_is_remote(BYVAL AS GApplication PTR) AS gboolean
DECLARE FUNCTION g_application_register(BYVAL AS GApplication PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE SUB g_application_hold(BYVAL AS GApplication PTR)
DECLARE SUB g_application_release(BYVAL AS GApplication PTR)
DECLARE SUB g_application_activate(BYVAL AS GApplication PTR)
DECLARE SUB g_application_open(BYVAL AS GApplication PTR, BYVAL AS GFile PTR PTR, BYVAL AS gint, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION g_application_run(BYVAL AS GApplication PTR, BYVAL AS INTEGER, BYVAL AS ZSTRING PTR PTR) AS INTEGER
DECLARE FUNCTION g_application_get_default() AS GApplication PTR
DECLARE SUB g_application_set_default(BYVAL AS GApplication PTR)

#ENDIF ' __G_APPLICATION_H__

#IFNDEF __G_APPLICATION_COMMAND_LINE_H__
#DEFINE __G_APPLICATION_COMMAND_LINE_H__

#DEFINE G_TYPE_APPLICATION_COMMAND_LINE (g_application_command_line_get_type ())
#DEFINE G_APPLICATION_COMMAND_LINE(inst) (G_TYPE_CHECK_INSTANCE_CAST ((inst), _
                                                             G_TYPE_APPLICATION_COMMAND_LINE, _
                                                             GApplicationCommandLine))
#DEFINE G_APPLICATION_COMMAND_LINE_CLASS(class) (G_TYPE_CHECK_CLASS_CAST ((class), _
                                                             G_TYPE_APPLICATION_COMMAND_LINE, _
                                                             GApplicationCommandLineClass))
#DEFINE G_IS_APPLICATION_COMMAND_LINE(inst) (G_TYPE_CHECK_INSTANCE_TYPE ((inst), _
                                                             G_TYPE_APPLICATION_COMMAND_LINE))
#DEFINE G_IS_APPLICATION_COMMAND_LINE_CLASS(class) (G_TYPE_CHECK_CLASS_TYPE ((class), _
                                                             G_TYPE_APPLICATION_COMMAND_LINE))
#DEFINE G_APPLICATION_COMMAND_LINE_GET_CLASS(inst) (G_TYPE_INSTANCE_GET_CLASS ((inst), _
                                                             G_TYPE_APPLICATION_COMMAND_LINE, _
                                                             GApplicationCommandLineClass))

TYPE GApplicationCommandLinePrivate AS _GApplicationCommandLinePrivate
TYPE GApplicationCommandLineClass AS _GApplicationCommandLineClass

TYPE _GApplicationCommandLine
  AS GObject parent_instance
  AS GApplicationCommandLinePrivate PTR priv
END TYPE

TYPE _GApplicationCommandLineClass
  AS GObjectClass parent_class
  print_literal AS SUB(BYVAL AS GApplicationCommandLine PTR, BYVAL AS CONST gchar PTR)
  printerr_literal AS SUB(BYVAL AS GApplicationCommandLine PTR, BYVAL AS CONST gchar PTR)
  AS gpointer padding(11)
END TYPE

DECLARE FUNCTION g_application_command_line_get_type() AS GType
DECLARE FUNCTION g_application_command_line_get_arguments(BYVAL AS GApplicationCommandLine PTR, BYVAL AS INTEGER PTR) AS gchar PTR PTR
DECLARE FUNCTION g_application_command_line_get_environ(BYVAL AS GApplicationCommandLine PTR) AS CONST gchar CONST PTR PTR
DECLARE FUNCTION g_application_command_line_getenv(BYVAL AS GApplicationCommandLine PTR, BYVAL AS CONST gchar PTR) AS CONST gchar PTR
DECLARE FUNCTION g_application_command_line_get_cwd(BYVAL AS GApplicationCommandLine PTR) AS CONST gchar PTR
DECLARE FUNCTION g_application_command_line_get_is_remote(BYVAL AS GApplicationCommandLine PTR) AS gboolean
DECLARE SUB g_application_command_line_print(BYVAL AS GApplicationCommandLine PTR, BYVAL AS CONST gchar PTR, ...)
DECLARE SUB g_application_command_line_printerr(BYVAL AS GApplicationCommandLine PTR, BYVAL AS CONST gchar PTR, ...)
DECLARE FUNCTION g_application_command_line_get_exit_status(BYVAL AS GApplicationCommandLine PTR) AS INTEGER
DECLARE SUB g_application_command_line_set_exit_status(BYVAL AS GApplicationCommandLine PTR, BYVAL AS INTEGER)
DECLARE FUNCTION g_application_command_line_get_platform_data(BYVAL AS GApplicationCommandLine PTR) AS GVariant PTR

#ENDIF ' __G_APPLICATION_COMMAND_LINE_H__

#IFNDEF __G_ASYNC_INITABLE_H__
#DEFINE __G_ASYNC_INITABLE_H__

#IFNDEF __G_INITABLE_H__
#DEFINE __G_INITABLE_H__

#DEFINE G_TYPE_INITABLE (g_initable_get_type ())
#DEFINE G_INITABLE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), G_TYPE_INITABLE, GInitable))
#DEFINE G_IS_INITABLE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), G_TYPE_INITABLE))
#DEFINE G_INITABLE_GET_IFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), G_TYPE_INITABLE, GInitableIface))
#DEFINE G_TYPE_IS_INITABLE(type) (g_type_is_a ((type), G_TYPE_INITABLE))

TYPE GInitableIface AS _GInitableIface

TYPE _GInitableIface
  AS GTypeInterface g_iface
  init AS FUNCTION(BYVAL AS GInitable PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
END TYPE

DECLARE FUNCTION g_initable_get_type() AS GType
DECLARE FUNCTION g_initable_init(BYVAL AS GInitable PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_initable_new(BYVAL AS GType, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR, BYVAL AS CONST gchar PTR, ...) AS gpointer
DECLARE FUNCTION g_initable_newv(BYVAL AS GType, BYVAL AS guint, BYVAL AS GParameter PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gpointer
DECLARE FUNCTION g_initable_new_valist(BYVAL AS GType, BYVAL AS CONST gchar PTR, BYVAL AS va_list, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GObject PTR

#ENDIF ' __G_INITABLE_H__

#DEFINE G_TYPE_ASYNC_INITABLE (g_async_initable_get_type ())
#DEFINE G_ASYNC_INITABLE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), G_TYPE_ASYNC_INITABLE, GAsyncInitable))
#DEFINE G_IS_ASYNC_INITABLE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), G_TYPE_ASYNC_INITABLE))
#DEFINE G_ASYNC_INITABLE_GET_IFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), G_TYPE_ASYNC_INITABLE, GAsyncInitableIface))
#DEFINE G_TYPE_IS_ASYNC_INITABLE(type) (g_type_is_a ((type), G_TYPE_ASYNC_INITABLE))

TYPE GAsyncInitableIface AS _GAsyncInitableIface

TYPE _GAsyncInitableIface
  AS GTypeInterface g_iface
  init_async AS SUB(BYVAL AS GAsyncInitable PTR, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  init_finish AS FUNCTION(BYVAL AS GAsyncInitable PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
END TYPE

DECLARE FUNCTION g_async_initable_get_type() AS GType
DECLARE SUB g_async_initable_init_async(BYVAL AS GAsyncInitable PTR, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_async_initable_init_finish(BYVAL AS GAsyncInitable PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE SUB g_async_initable_new_async(BYVAL AS GType, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer, BYVAL AS CONST gchar PTR, ...)
DECLARE SUB g_async_initable_newv_async(BYVAL AS GType, BYVAL AS guint, BYVAL AS GParameter PTR, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE SUB g_async_initable_new_valist_async(BYVAL AS GType, BYVAL AS CONST gchar PTR, BYVAL AS va_list, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_async_initable_new_finish(BYVAL AS GAsyncInitable PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GObject PTR

#ENDIF ' __G_ASYNC_INITABLE_H__

#IFNDEF __G_ASYNC_RESULT_H__
#DEFINE __G_ASYNC_RESULT_H__

#DEFINE G_TYPE_ASYNC_RESULT (g_async_result_get_type ())
#DEFINE G_ASYNC_RESULT(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), G_TYPE_ASYNC_RESULT, GAsyncResult))
#DEFINE G_IS_ASYNC_RESULT(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), G_TYPE_ASYNC_RESULT))
#DEFINE G_ASYNC_RESULT_GET_IFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), G_TYPE_ASYNC_RESULT, GAsyncResultIface))

TYPE GAsyncResultIface AS _GAsyncResultIface

TYPE _GAsyncResultIface
  AS GTypeInterface g_iface
  get_user_data AS FUNCTION(BYVAL AS GAsyncResult PTR) AS gpointer
  get_source_object AS FUNCTION(BYVAL AS GAsyncResult PTR) AS GObject PTR
END TYPE

DECLARE FUNCTION g_async_result_get_type() AS GType
DECLARE FUNCTION g_async_result_get_user_data(BYVAL AS GAsyncResult PTR) AS gpointer
DECLARE FUNCTION g_async_result_get_source_object(BYVAL AS GAsyncResult PTR) AS GObject PTR

#ENDIF ' __G_ASYNC_RESULT_H__

#IFNDEF __G_BUFFERED_INPUT_STREAM_H__
#DEFINE __G_BUFFERED_INPUT_STREAM_H__

#IFNDEF __G_FILTER_INPUT_STREAM_H__
#DEFINE __G_FILTER_INPUT_STREAM_H__

#IFNDEF __G_INPUT_STREAM_H__
#DEFINE __G_INPUT_STREAM_H__

#DEFINE G_TYPE_INPUT_STREAM (g_input_stream_get_type ())
#DEFINE G_INPUT_STREAM(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_INPUT_STREAM, GInputStream))
#DEFINE G_INPUT_STREAM_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_INPUT_STREAM, GInputStreamClass))
#DEFINE G_IS_INPUT_STREAM(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_INPUT_STREAM))
#DEFINE G_IS_INPUT_STREAM_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), G_TYPE_INPUT_STREAM))
#DEFINE G_INPUT_STREAM_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), G_TYPE_INPUT_STREAM, GInputStreamClass))

TYPE GInputStreamClass AS _GInputStreamClass
TYPE GInputStreamPrivate AS _GInputStreamPrivate

TYPE _GInputStream
  AS GObject parent_instance
  AS GInputStreamPrivate PTR priv
END TYPE

TYPE _GInputStreamClass
  AS GObjectClass parent_class
  read_fn AS FUNCTION(BYVAL AS GInputStream PTR, BYVAL AS ANY PTR, BYVAL AS gsize, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gssize
  skip AS FUNCTION(BYVAL AS GInputStream PTR, BYVAL AS gsize, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gssize
  close_fn AS FUNCTION(BYVAL AS GInputStream PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
  read_async AS SUB(BYVAL AS GInputStream PTR, BYVAL AS ANY PTR, BYVAL AS gsize, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  read_finish AS FUNCTION(BYVAL AS GInputStream PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gssize
  skip_async AS SUB(BYVAL AS GInputStream PTR, BYVAL AS gsize, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  skip_finish AS FUNCTION(BYVAL AS GInputStream PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gssize
  close_async AS SUB(BYVAL AS GInputStream PTR, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  close_finish AS FUNCTION(BYVAL AS GInputStream PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
  _g_reserved1 AS SUB()
  _g_reserved2 AS SUB()
  _g_reserved3 AS SUB()
  _g_reserved4 AS SUB()
  _g_reserved5 AS SUB()
END TYPE

DECLARE FUNCTION g_input_stream_get_type() AS GType
DECLARE FUNCTION g_input_stream_read(BYVAL AS GInputStream PTR, BYVAL AS ANY PTR, BYVAL AS gsize, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gssize
DECLARE FUNCTION g_input_stream_read_all(BYVAL AS GInputStream PTR, BYVAL AS ANY PTR, BYVAL AS gsize, BYVAL AS gsize PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_input_stream_skip(BYVAL AS GInputStream PTR, BYVAL AS gsize, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gssize
DECLARE FUNCTION g_input_stream_close(BYVAL AS GInputStream PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE SUB g_input_stream_read_async(BYVAL AS GInputStream PTR, BYVAL AS ANY PTR, BYVAL AS gsize, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_input_stream_read_finish(BYVAL AS GInputStream PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gssize
DECLARE SUB g_input_stream_skip_async(BYVAL AS GInputStream PTR, BYVAL AS gsize, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_input_stream_skip_finish(BYVAL AS GInputStream PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gssize
DECLARE SUB g_input_stream_close_async(BYVAL AS GInputStream PTR, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_input_stream_close_finish(BYVAL AS GInputStream PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_input_stream_is_closed(BYVAL AS GInputStream PTR) AS gboolean
DECLARE FUNCTION g_input_stream_has_pending(BYVAL AS GInputStream PTR) AS gboolean
DECLARE FUNCTION g_input_stream_set_pending(BYVAL AS GInputStream PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE SUB g_input_stream_clear_pending(BYVAL AS GInputStream PTR)

#ENDIF ' __G_INPUT_STREAM_H__

#DEFINE G_TYPE_FILTER_INPUT_STREAM (g_filter_input_stream_get_type ())
#DEFINE G_FILTER_INPUT_STREAM(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_FILTER_INPUT_STREAM, GFilterInputStream))
#DEFINE G_FILTER_INPUT_STREAM_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_FILTER_INPUT_STREAM, GFilterInputStreamClass))
#DEFINE G_IS_FILTER_INPUT_STREAM(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_FILTER_INPUT_STREAM))
#DEFINE G_IS_FILTER_INPUT_STREAM_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), G_TYPE_FILTER_INPUT_STREAM))
#DEFINE G_FILTER_INPUT_STREAM_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), G_TYPE_FILTER_INPUT_STREAM, GFilterInputStreamClass))

TYPE GFilterInputStreamClass AS _GFilterInputStreamClass

TYPE _GFilterInputStream
  AS GInputStream parent_instance
  AS GInputStream PTR base_stream
END TYPE

TYPE _GFilterInputStreamClass
  AS GInputStreamClass parent_class
  _g_reserved1 AS SUB()
  _g_reserved2 AS SUB()
  _g_reserved3 AS SUB()
END TYPE

DECLARE FUNCTION g_filter_input_stream_get_type() AS GType
DECLARE FUNCTION g_filter_input_stream_get_base_stream(BYVAL AS GFilterInputStream PTR) AS GInputStream PTR
DECLARE FUNCTION g_filter_input_stream_get_close_base_stream(BYVAL AS GFilterInputStream PTR) AS gboolean
DECLARE SUB g_filter_input_stream_set_close_base_stream(BYVAL AS GFilterInputStream PTR, BYVAL AS gboolean)

#ENDIF ' __G_FILTER_INPUT_STREAM_H__

#DEFINE G_TYPE_BUFFERED_INPUT_STREAM (g_buffered_input_stream_get_type ())
#DEFINE G_BUFFERED_INPUT_STREAM(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_BUFFERED_INPUT_STREAM, GBufferedInputStream))
#DEFINE G_BUFFERED_INPUT_STREAM_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_BUFFERED_INPUT_STREAM, GBufferedInputStreamClass))
#DEFINE G_IS_BUFFERED_INPUT_STREAM(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_BUFFERED_INPUT_STREAM))
#DEFINE G_IS_BUFFERED_INPUT_STREAM_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), G_TYPE_BUFFERED_INPUT_STREAM))
#DEFINE G_BUFFERED_INPUT_STREAM_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), G_TYPE_BUFFERED_INPUT_STREAM, GBufferedInputStreamClass))

TYPE GBufferedInputStreamClass AS _GBufferedInputStreamClass
TYPE GBufferedInputStreamPrivate AS _GBufferedInputStreamPrivate

TYPE _GBufferedInputStream
  AS GFilterInputStream parent_instance
  AS GBufferedInputStreamPrivate PTR priv
END TYPE

TYPE _GBufferedInputStreamClass
  AS GFilterInputStreamClass parent_class
  fill AS FUNCTION(BYVAL AS GBufferedInputStream PTR, BYVAL AS gssize, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gssize
  fill_async AS SUB(BYVAL AS GBufferedInputStream PTR, BYVAL AS gssize, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  fill_finish AS FUNCTION(BYVAL AS GBufferedInputStream PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gssize
  _g_reserved1 AS SUB()
  _g_reserved2 AS SUB()
  _g_reserved3 AS SUB()
  _g_reserved4 AS SUB()
  _g_reserved5 AS SUB()
END TYPE

DECLARE FUNCTION g_buffered_input_stream_get_type() AS GType
DECLARE FUNCTION g_buffered_input_stream_new(BYVAL AS GInputStream PTR) AS GInputStream PTR
DECLARE FUNCTION g_buffered_input_stream_new_sized(BYVAL AS GInputStream PTR, BYVAL AS gsize) AS GInputStream PTR
DECLARE FUNCTION g_buffered_input_stream_get_buffer_size(BYVAL AS GBufferedInputStream PTR) AS gsize
DECLARE SUB g_buffered_input_stream_set_buffer_size(BYVAL AS GBufferedInputStream PTR, BYVAL AS gsize)
DECLARE FUNCTION g_buffered_input_stream_get_available(BYVAL AS GBufferedInputStream PTR) AS gsize
DECLARE FUNCTION g_buffered_input_stream_peek(BYVAL AS GBufferedInputStream PTR, BYVAL AS ANY PTR, BYVAL AS gsize, BYVAL AS gsize) AS gsize
DECLARE FUNCTION g_buffered_input_stream_peek_buffer(BYVAL AS GBufferedInputStream PTR, BYVAL AS gsize PTR) AS CONST ANY PTR
DECLARE FUNCTION g_buffered_input_stream_fill(BYVAL AS GBufferedInputStream PTR, BYVAL AS gssize, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gssize
DECLARE SUB g_buffered_input_stream_fill_async(BYVAL AS GBufferedInputStream PTR, BYVAL AS gssize, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_buffered_input_stream_fill_finish(BYVAL AS GBufferedInputStream PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gssize
DECLARE FUNCTION g_buffered_input_stream_read_byte(BYVAL AS GBufferedInputStream PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS INTEGER

#ENDIF ' __G_BUFFERED_INPUT_STREAM_H__

#IFNDEF __G_BUFFERED_OUTPUT_STREAM_H__
#DEFINE __G_BUFFERED_OUTPUT_STREAM_H__

#IFNDEF __G_FILTER_OUTPUT_STREAM_H__
#DEFINE __G_FILTER_OUTPUT_STREAM_H__

#IFNDEF __G_OUTPUT_STREAM_H__
#DEFINE __G_OUTPUT_STREAM_H__

#DEFINE G_TYPE_OUTPUT_STREAM (g_output_stream_get_type ())
#DEFINE G_OUTPUT_STREAM(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_OUTPUT_STREAM, GOutputStream))
#DEFINE G_OUTPUT_STREAM_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_OUTPUT_STREAM, GOutputStreamClass))
#DEFINE G_IS_OUTPUT_STREAM(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_OUTPUT_STREAM))
#DEFINE G_IS_OUTPUT_STREAM_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), G_TYPE_OUTPUT_STREAM))
#DEFINE G_OUTPUT_STREAM_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), G_TYPE_OUTPUT_STREAM, GOutputStreamClass))

TYPE GOutputStreamClass AS _GOutputStreamClass
TYPE GOutputStreamPrivate AS _GOutputStreamPrivate

TYPE _GOutputStream
  AS GObject parent_instance
  AS GOutputStreamPrivate PTR priv
END TYPE

TYPE _GOutputStreamClass
  AS GObjectClass parent_class
  write_fn AS FUNCTION(BYVAL AS GOutputStream PTR, BYVAL AS CONST ANY PTR, BYVAL AS gsize, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gssize
  splice AS FUNCTION(BYVAL AS GOutputStream PTR, BYVAL AS GInputStream PTR, BYVAL AS GOutputStreamSpliceFlags, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gssize
  flush AS FUNCTION(BYVAL AS GOutputStream PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
  close_fn AS FUNCTION(BYVAL AS GOutputStream PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
  write_async AS SUB(BYVAL AS GOutputStream PTR, BYVAL AS CONST ANY PTR, BYVAL AS gsize, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  write_finish AS FUNCTION(BYVAL AS GOutputStream PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gssize
  splice_async AS SUB(BYVAL AS GOutputStream PTR, BYVAL AS GInputStream PTR, BYVAL AS GOutputStreamSpliceFlags, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  splice_finish AS FUNCTION(BYVAL AS GOutputStream PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gssize
  flush_async AS SUB(BYVAL AS GOutputStream PTR, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  flush_finish AS FUNCTION(BYVAL AS GOutputStream PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
  close_async AS SUB(BYVAL AS GOutputStream PTR, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  close_finish AS FUNCTION(BYVAL AS GOutputStream PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
  _g_reserved1 AS SUB()
  _g_reserved2 AS SUB()
  _g_reserved3 AS SUB()
  _g_reserved4 AS SUB()
  _g_reserved5 AS SUB()
  _g_reserved6 AS SUB()
  _g_reserved7 AS SUB()
  _g_reserved8 AS SUB()
END TYPE

DECLARE FUNCTION g_output_stream_get_type() AS GType
DECLARE FUNCTION g_output_stream_write(BYVAL AS GOutputStream PTR, BYVAL AS CONST ANY PTR, BYVAL AS gsize, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gssize
DECLARE FUNCTION g_output_stream_write_all(BYVAL AS GOutputStream PTR, BYVAL AS CONST ANY PTR, BYVAL AS gsize, BYVAL AS gsize PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_output_stream_splice(BYVAL AS GOutputStream PTR, BYVAL AS GInputStream PTR, BYVAL AS GOutputStreamSpliceFlags, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gssize
DECLARE FUNCTION g_output_stream_flush(BYVAL AS GOutputStream PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_output_stream_close(BYVAL AS GOutputStream PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE SUB g_output_stream_write_async(BYVAL AS GOutputStream PTR, BYVAL AS CONST ANY PTR, BYVAL AS gsize, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_output_stream_write_finish(BYVAL AS GOutputStream PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gssize
DECLARE SUB g_output_stream_splice_async(BYVAL AS GOutputStream PTR, BYVAL AS GInputStream PTR, BYVAL AS GOutputStreamSpliceFlags, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_output_stream_splice_finish(BYVAL AS GOutputStream PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gssize
DECLARE SUB g_output_stream_flush_async(BYVAL AS GOutputStream PTR, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_output_stream_flush_finish(BYVAL AS GOutputStream PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE SUB g_output_stream_close_async(BYVAL AS GOutputStream PTR, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_output_stream_close_finish(BYVAL AS GOutputStream PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_output_stream_is_closed(BYVAL AS GOutputStream PTR) AS gboolean
DECLARE FUNCTION g_output_stream_is_closing(BYVAL AS GOutputStream PTR) AS gboolean
DECLARE FUNCTION g_output_stream_has_pending(BYVAL AS GOutputStream PTR) AS gboolean
DECLARE FUNCTION g_output_stream_set_pending(BYVAL AS GOutputStream PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE SUB g_output_stream_clear_pending(BYVAL AS GOutputStream PTR)

#ENDIF ' __G_OUTPUT_STREAM_H__

#DEFINE G_TYPE_FILTER_OUTPUT_STREAM (g_filter_output_stream_get_type ())
#DEFINE G_FILTER_OUTPUT_STREAM(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_FILTER_OUTPUT_STREAM, GFilterOutputStream))
#DEFINE G_FILTER_OUTPUT_STREAM_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_FILTER_OUTPUT_STREAM, GFilterOutputStreamClass))
#DEFINE G_IS_FILTER_OUTPUT_STREAM(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_FILTER_OUTPUT_STREAM))
#DEFINE G_IS_FILTER_OUTPUT_STREAM_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), G_TYPE_FILTER_OUTPUT_STREAM))
#DEFINE G_FILTER_OUTPUT_STREAM_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), G_TYPE_FILTER_OUTPUT_STREAM, GFilterOutputStreamClass))

TYPE GFilterOutputStreamClass AS _GFilterOutputStreamClass

TYPE _GFilterOutputStream
  AS GOutputStream parent_instance
  AS GOutputStream PTR base_stream
END TYPE

TYPE _GFilterOutputStreamClass
  AS GOutputStreamClass parent_class
  _g_reserved1 AS SUB()
  _g_reserved2 AS SUB()
  _g_reserved3 AS SUB()
END TYPE

DECLARE FUNCTION g_filter_output_stream_get_type() AS GType
DECLARE FUNCTION g_filter_output_stream_get_base_stream(BYVAL AS GFilterOutputStream PTR) AS GOutputStream PTR
DECLARE FUNCTION g_filter_output_stream_get_close_base_stream(BYVAL AS GFilterOutputStream PTR) AS gboolean
DECLARE SUB g_filter_output_stream_set_close_base_stream(BYVAL AS GFilterOutputStream PTR, BYVAL AS gboolean)

#ENDIF ' __G_FILTER_OUTPUT_STREAM_H__

#DEFINE G_TYPE_BUFFERED_OUTPUT_STREAM (g_buffered_output_stream_get_type ())
#DEFINE G_BUFFERED_OUTPUT_STREAM(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_BUFFERED_OUTPUT_STREAM, GBufferedOutputStream))
#DEFINE G_BUFFERED_OUTPUT_STREAM_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_BUFFERED_OUTPUT_STREAM, GBufferedOutputStreamClass))
#DEFINE G_IS_BUFFERED_OUTPUT_STREAM(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_BUFFERED_OUTPUT_STREAM))
#DEFINE G_IS_BUFFERED_OUTPUT_STREAM_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), G_TYPE_BUFFERED_OUTPUT_STREAM))
#DEFINE G_BUFFERED_OUTPUT_STREAM_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), G_TYPE_BUFFERED_OUTPUT_STREAM, GBufferedOutputStreamClass))

TYPE GBufferedOutputStreamClass AS _GBufferedOutputStreamClass
TYPE GBufferedOutputStreamPrivate AS _GBufferedOutputStreamPrivate

TYPE _GBufferedOutputStream
  AS GFilterOutputStream parent_instance
  AS GBufferedOutputStreamPrivate PTR priv
END TYPE

TYPE _GBufferedOutputStreamClass
  AS GFilterOutputStreamClass parent_class
  _g_reserved1 AS SUB()
  _g_reserved2 AS SUB()
END TYPE

DECLARE FUNCTION g_buffered_output_stream_get_type() AS GType
DECLARE FUNCTION g_buffered_output_stream_new(BYVAL AS GOutputStream PTR) AS GOutputStream PTR
DECLARE FUNCTION g_buffered_output_stream_new_sized(BYVAL AS GOutputStream PTR, BYVAL AS gsize) AS GOutputStream PTR
DECLARE FUNCTION g_buffered_output_stream_get_buffer_size(BYVAL AS GBufferedOutputStream PTR) AS gsize
DECLARE SUB g_buffered_output_stream_set_buffer_size(BYVAL AS GBufferedOutputStream PTR, BYVAL AS gsize)
DECLARE FUNCTION g_buffered_output_stream_get_auto_grow(BYVAL AS GBufferedOutputStream PTR) AS gboolean
DECLARE SUB g_buffered_output_stream_set_auto_grow(BYVAL AS GBufferedOutputStream PTR, BYVAL AS gboolean)

#ENDIF ' __G_BUFFERED_OUTPUT_STREAM_H__

#IFNDEF __G_CANCELLABLE_H__
#DEFINE __G_CANCELLABLE_H__

#DEFINE G_TYPE_CANCELLABLE (g_cancellable_get_type ())
#DEFINE G_CANCELLABLE(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_CANCELLABLE, GCancellable))
#DEFINE G_CANCELLABLE_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_CANCELLABLE, GCancellableClass))
#DEFINE G_IS_CANCELLABLE(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_CANCELLABLE))
#DEFINE G_IS_CANCELLABLE_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), G_TYPE_CANCELLABLE))
#DEFINE G_CANCELLABLE_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), G_TYPE_CANCELLABLE, GCancellableClass))

TYPE GCancellableClass AS _GCancellableClass
TYPE GCancellablePrivate AS _GCancellablePrivate

TYPE _GCancellable
  AS GObject parent_instance
  AS GCancellablePrivate PTR priv
END TYPE

TYPE _GCancellableClass
  AS GObjectClass parent_class
  cancelled AS SUB(BYVAL AS GCancellable PTR)
  _g_reserved1 AS SUB()
  _g_reserved2 AS SUB()
  _g_reserved3 AS SUB()
  _g_reserved4 AS SUB()
  _g_reserved5 AS SUB()
END TYPE

DECLARE FUNCTION g_cancellable_get_type() AS GType
DECLARE FUNCTION g_cancellable_new() AS GCancellable PTR
DECLARE FUNCTION g_cancellable_is_cancelled(BYVAL AS GCancellable PTR) AS gboolean
DECLARE FUNCTION g_cancellable_set_error_if_cancelled(BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_cancellable_get_fd(BYVAL AS GCancellable PTR) AS INTEGER
DECLARE FUNCTION g_cancellable_make_pollfd(BYVAL AS GCancellable PTR, BYVAL AS GPollFD PTR) AS gboolean
DECLARE SUB g_cancellable_release_fd(BYVAL AS GCancellable PTR)
DECLARE FUNCTION g_cancellable_source_new(BYVAL AS GCancellable PTR) AS GSource PTR
DECLARE FUNCTION g_cancellable_get_current() AS GCancellable PTR
DECLARE SUB g_cancellable_push_current(BYVAL AS GCancellable PTR)
DECLARE SUB g_cancellable_pop_current(BYVAL AS GCancellable PTR)
DECLARE SUB g_cancellable_reset(BYVAL AS GCancellable PTR)
DECLARE FUNCTION g_cancellable_connect(BYVAL AS GCancellable PTR, BYVAL AS GCallback, BYVAL AS gpointer, BYVAL AS GDestroyNotify) AS gulong
DECLARE SUB g_cancellable_disconnect(BYVAL AS GCancellable PTR, BYVAL AS gulong)
DECLARE SUB g_cancellable_cancel(BYVAL AS GCancellable PTR)

#ENDIF ' __G_CANCELLABLE_H__

#IFNDEF __G_CHARSET_CONVERTER_H__
#DEFINE __G_CHARSET_CONVERTER_H__

#IFNDEF __G_CONVERTER_H__
#DEFINE __G_CONVERTER_H__

#DEFINE G_TYPE_CONVERTER (g_converter_get_type ())
#DEFINE G_CONVERTER(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), G_TYPE_CONVERTER, GConverter))
#DEFINE G_IS_CONVERTER(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), G_TYPE_CONVERTER))
#DEFINE G_CONVERTER_GET_IFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), G_TYPE_CONVERTER, GConverterIface))

TYPE GConverterIface AS _GConverterIface

TYPE _GConverterIface
  AS GTypeInterface g_iface
  convert AS FUNCTION(BYVAL AS GConverter PTR, BYVAL AS CONST ANY PTR, BYVAL AS gsize, BYVAL AS ANY PTR, BYVAL AS gsize, BYVAL AS GConverterFlags, BYVAL AS gsize PTR, BYVAL AS gsize PTR, BYVAL AS GError PTR PTR) AS GConverterResult
  reset_ AS SUB(BYVAL AS GConverter PTR)
END TYPE

DECLARE FUNCTION g_converter_get_type() AS GType
DECLARE FUNCTION g_converter_convert(BYVAL AS GConverter PTR, BYVAL AS CONST ANY PTR, BYVAL AS gsize, BYVAL AS ANY PTR, BYVAL AS gsize, BYVAL AS GConverterFlags, BYVAL AS gsize PTR, BYVAL AS gsize PTR, BYVAL AS GError PTR PTR) AS GConverterResult
DECLARE SUB g_converter_reset(BYVAL AS GConverter PTR)

#ENDIF ' __G_CONVERTER_H__

#DEFINE G_TYPE_CHARSET_CONVERTER (g_charset_converter_get_type ())
#DEFINE G_CHARSET_CONVERTER(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_CHARSET_CONVERTER, GCharsetConverter))
#DEFINE G_CHARSET_CONVERTER_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_CHARSET_CONVERTER, GCharsetConverterClass))
#DEFINE G_IS_CHARSET_CONVERTER(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_CHARSET_CONVERTER))
#DEFINE G_IS_CHARSET_CONVERTER_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), G_TYPE_CHARSET_CONVERTER))
#DEFINE G_CHARSET_CONVERTER_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), G_TYPE_CHARSET_CONVERTER, GCharsetConverterClass))

TYPE GCharsetConverterClass AS _GCharsetConverterClass

TYPE _GCharsetConverterClass
  AS GObjectClass parent_class
END TYPE

DECLARE FUNCTION g_charset_converter_get_type() AS GType
DECLARE FUNCTION g_charset_converter_new(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS GCharsetConverter PTR
DECLARE SUB g_charset_converter_set_use_fallback(BYVAL AS GCharsetConverter PTR, BYVAL AS gboolean)
DECLARE FUNCTION g_charset_converter_get_use_fallback(BYVAL AS GCharsetConverter PTR) AS gboolean
DECLARE FUNCTION g_charset_converter_get_num_fallbacks(BYVAL AS GCharsetConverter PTR) AS guint

#ENDIF ' __G_CHARSET_CONVERTER_H__

#IFNDEF __G_CONTENT_TYPE_H__
#DEFINE __G_CONTENT_TYPE_H__

DECLARE FUNCTION g_content_type_equals(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR) AS gboolean
DECLARE FUNCTION g_content_type_is_a(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR) AS gboolean
DECLARE FUNCTION g_content_type_is_unknown(BYVAL AS CONST gchar PTR) AS gboolean
DECLARE FUNCTION g_content_type_get_description(BYVAL AS CONST gchar PTR) AS gchar PTR
DECLARE FUNCTION g_content_type_get_mime_type(BYVAL AS CONST gchar PTR) AS gchar PTR
DECLARE FUNCTION g_content_type_get_icon(BYVAL AS CONST gchar PTR) AS GIcon PTR
DECLARE FUNCTION g_content_type_can_be_executable(BYVAL AS CONST gchar PTR) AS gboolean
DECLARE FUNCTION g_content_type_from_mime_type(BYVAL AS CONST gchar PTR) AS gchar PTR
DECLARE FUNCTION g_content_type_guess(BYVAL AS CONST gchar PTR, BYVAL AS CONST guchar PTR, BYVAL AS gsize, BYVAL AS gboolean PTR) AS gchar PTR
DECLARE FUNCTION g_content_type_guess_for_tree(BYVAL AS GFile PTR) AS gchar PTR PTR
DECLARE FUNCTION g_content_types_get_registered() AS GList PTR

#ENDIF ' __G_CONTENT_TYPE_H__

#IFNDEF __G_CONVERTER_INPUT_STREAM_H__
#DEFINE __G_CONVERTER_INPUT_STREAM_H__

#DEFINE G_TYPE_CONVERTER_INPUT_STREAM (g_converter_input_stream_get_type ())
#DEFINE G_CONVERTER_INPUT_STREAM(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_CONVERTER_INPUT_STREAM, GConverterInputStream))
#DEFINE G_CONVERTER_INPUT_STREAM_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_CONVERTER_INPUT_STREAM, GConverterInputStreamClass))
#DEFINE G_IS_CONVERTER_INPUT_STREAM(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_CONVERTER_INPUT_STREAM))
#DEFINE G_IS_CONVERTER_INPUT_STREAM_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), G_TYPE_CONVERTER_INPUT_STREAM))
#DEFINE G_CONVERTER_INPUT_STREAM_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), G_TYPE_CONVERTER_INPUT_STREAM, GConverterInputStreamClass))

TYPE GConverterInputStreamClass AS _GConverterInputStreamClass
TYPE GConverterInputStreamPrivate AS _GConverterInputStreamPrivate

TYPE _GConverterInputStream
  AS GFilterInputStream parent_instance
  AS GConverterInputStreamPrivate PTR priv
END TYPE

TYPE _GConverterInputStreamClass
  AS GFilterInputStreamClass parent_class
  _g_reserved1 AS SUB()
  _g_reserved2 AS SUB()
  _g_reserved3 AS SUB()
  _g_reserved4 AS SUB()
  _g_reserved5 AS SUB()
END TYPE

DECLARE FUNCTION g_converter_input_stream_get_type() AS GType
DECLARE FUNCTION g_converter_input_stream_new(BYVAL AS GInputStream PTR, BYVAL AS GConverter PTR) AS GInputStream PTR
DECLARE FUNCTION g_converter_input_stream_get_converter(BYVAL AS GConverterInputStream PTR) AS GConverter PTR

#ENDIF ' __G_CONVERTER_INPUT_STREAM_H__

#IFNDEF __G_CONVERTER_OUTPUT_STREAM_H__
#DEFINE __G_CONVERTER_OUTPUT_STREAM_H__

#DEFINE G_TYPE_CONVERTER_OUTPUT_STREAM (g_converter_output_stream_get_type ())
#DEFINE G_CONVERTER_OUTPUT_STREAM(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_CONVERTER_OUTPUT_STREAM, GConverterOutputStream))
#DEFINE G_CONVERTER_OUTPUT_STREAM_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_CONVERTER_OUTPUT_STREAM, GConverterOutputStreamClass))
#DEFINE G_IS_CONVERTER_OUTPUT_STREAM(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_CONVERTER_OUTPUT_STREAM))
#DEFINE G_IS_CONVERTER_OUTPUT_STREAM_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), G_TYPE_CONVERTER_OUTPUT_STREAM))
#DEFINE G_CONVERTER_OUTPUT_STREAM_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), G_TYPE_CONVERTER_OUTPUT_STREAM, GConverterOutputStreamClass))

TYPE GConverterOutputStreamClass AS _GConverterOutputStreamClass
TYPE GConverterOutputStreamPrivate AS _GConverterOutputStreamPrivate

TYPE _GConverterOutputStream
  AS GFilterOutputStream parent_instance
  AS GConverterOutputStreamPrivate PTR priv
END TYPE

TYPE _GConverterOutputStreamClass
  AS GFilterOutputStreamClass parent_class
  _g_reserved1 AS SUB()
  _g_reserved2 AS SUB()
  _g_reserved3 AS SUB()
  _g_reserved4 AS SUB()
  _g_reserved5 AS SUB()
END TYPE

DECLARE FUNCTION g_converter_output_stream_get_type() AS GType
DECLARE FUNCTION g_converter_output_stream_new(BYVAL AS GOutputStream PTR, BYVAL AS GConverter PTR) AS GOutputStream PTR
DECLARE FUNCTION g_converter_output_stream_get_converter(BYVAL AS GConverterOutputStream PTR) AS GConverter PTR

#ENDIF ' __G_CONVERTER_OUTPUT_STREAM_H__

#IFNDEF __G_CREDENTIALS_H__
#DEFINE __G_CREDENTIALS_H__

#IFDEF G_OS_UNIX
#INCLUDE ONCE "crt/unistd.bi"
#INCLUDE ONCE "crt/sys/types.bi"
#ENDIF ' G_OS_UNIX

#DEFINE G_TYPE_CREDENTIALS (g_credentials_get_type ())
#DEFINE G_CREDENTIALS(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_CREDENTIALS, GCredentials))
#DEFINE G_CREDENTIALS_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_CREDENTIALS, GCredentialsClass))
#DEFINE G_CREDENTIALS_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), G_TYPE_CREDENTIALS, GCredentialsClass))
#DEFINE G_IS_CREDENTIALS(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_CREDENTIALS))
#DEFINE G_IS_CREDENTIALS_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), G_TYPE_CREDENTIALS))

TYPE GCredentialsClass AS _GCredentialsClass

DECLARE FUNCTION g_credentials_get_type() AS GType
DECLARE FUNCTION g_credentials_new() AS GCredentials PTR
DECLARE FUNCTION g_credentials_to_string(BYVAL AS GCredentials PTR) AS gchar PTR
DECLARE FUNCTION g_credentials_get_native(BYVAL AS GCredentials PTR, BYVAL AS GCredentialsType) AS gpointer
DECLARE SUB g_credentials_set_native(BYVAL AS GCredentials PTR, BYVAL AS GCredentialsType, BYVAL AS gpointer)
DECLARE FUNCTION g_credentials_is_same_user(BYVAL AS GCredentials PTR, BYVAL AS GCredentials PTR, BYVAL AS GError PTR PTR) AS gboolean

#IFDEF G_OS_UNIX

DECLARE FUNCTION g_credentials_get_unix_user(BYVAL AS GCredentials PTR, BYVAL AS GError PTR PTR) AS uid_t
DECLARE FUNCTION g_credentials_set_unix_user(BYVAL AS GCredentials PTR, BYVAL AS uid_t, BYVAL AS GError PTR PTR) AS gboolean

#ENDIF ' G_OS_UNIX
#ENDIF ' __G_CREDENTIALS_H__

#IFNDEF __G_DATA_INPUT_STREAM_H__
#DEFINE __G_DATA_INPUT_STREAM_H__

#DEFINE G_TYPE_DATA_INPUT_STREAM (g_data_input_stream_get_type ())
#DEFINE G_DATA_INPUT_STREAM(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_DATA_INPUT_STREAM, GDataInputStream))
#DEFINE G_DATA_INPUT_STREAM_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_DATA_INPUT_STREAM, GDataInputStreamClass))
#DEFINE G_IS_DATA_INPUT_STREAM(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_DATA_INPUT_STREAM))
#DEFINE G_IS_DATA_INPUT_STREAM_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), G_TYPE_DATA_INPUT_STREAM))
#DEFINE G_DATA_INPUT_STREAM_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), G_TYPE_DATA_INPUT_STREAM, GDataInputStreamClass))

TYPE GDataInputStreamClass AS _GDataInputStreamClass
TYPE GDataInputStreamPrivate AS _GDataInputStreamPrivate

TYPE _GDataInputStream
  AS GBufferedInputStream parent_instance
  AS GDataInputStreamPrivate PTR priv
END TYPE

TYPE _GDataInputStreamClass
  AS GBufferedInputStreamClass parent_class
  _g_reserved1 AS SUB()
  _g_reserved2 AS SUB()
  _g_reserved3 AS SUB()
  _g_reserved4 AS SUB()
  _g_reserved5 AS SUB()
END TYPE

DECLARE FUNCTION g_data_input_stream_get_type() AS GType
DECLARE FUNCTION g_data_input_stream_new(BYVAL AS GInputStream PTR) AS GDataInputStream PTR
DECLARE SUB g_data_input_stream_set_byte_order(BYVAL AS GDataInputStream PTR, BYVAL AS GDataStreamByteOrder)
DECLARE FUNCTION g_data_input_stream_get_byte_order(BYVAL AS GDataInputStream PTR) AS GDataStreamByteOrder
DECLARE SUB g_data_input_stream_set_newline_type(BYVAL AS GDataInputStream PTR, BYVAL AS GDataStreamNewlineType)
DECLARE FUNCTION g_data_input_stream_get_newline_type(BYVAL AS GDataInputStream PTR) AS GDataStreamNewlineType
DECLARE FUNCTION g_data_input_stream_read_byte(BYVAL AS GDataInputStream PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS guchar
DECLARE FUNCTION g_data_input_stream_read_int16(BYVAL AS GDataInputStream PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gint16
DECLARE FUNCTION g_data_input_stream_read_uint16(BYVAL AS GDataInputStream PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS guint16
DECLARE FUNCTION g_data_input_stream_read_int32(BYVAL AS GDataInputStream PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gint32
DECLARE FUNCTION g_data_input_stream_read_uint32(BYVAL AS GDataInputStream PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS guint32
DECLARE FUNCTION g_data_input_stream_read_int64(BYVAL AS GDataInputStream PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gint64
DECLARE FUNCTION g_data_input_stream_read_uint64(BYVAL AS GDataInputStream PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS guint64
DECLARE FUNCTION g_data_input_stream_read_line(BYVAL AS GDataInputStream PTR, BYVAL AS gsize PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS ZSTRING PTR
DECLARE FUNCTION g_data_input_stream_read_line_utf8(BYVAL AS GDataInputStream PTR, BYVAL AS gsize PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS ZSTRING PTR
DECLARE SUB g_data_input_stream_read_line_async(BYVAL AS GDataInputStream PTR, BYVAL AS gint, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_data_input_stream_read_line_finish(BYVAL AS GDataInputStream PTR, BYVAL AS GAsyncResult PTR, BYVAL AS gsize PTR, BYVAL AS GError PTR PTR) AS ZSTRING PTR
DECLARE FUNCTION g_data_input_stream_read_line_finish_utf8(BYVAL AS GDataInputStream PTR, BYVAL AS GAsyncResult PTR, BYVAL AS gsize PTR, BYVAL AS GError PTR PTR) AS ZSTRING PTR
DECLARE FUNCTION g_data_input_stream_read_until(BYVAL AS GDataInputStream PTR, BYVAL AS CONST gchar PTR, BYVAL AS gsize PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS ZSTRING PTR
DECLARE SUB g_data_input_stream_read_until_async(BYVAL AS GDataInputStream PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_data_input_stream_read_until_finish(BYVAL AS GDataInputStream PTR, BYVAL AS GAsyncResult PTR, BYVAL AS gsize PTR, BYVAL AS GError PTR PTR) AS ZSTRING PTR
DECLARE FUNCTION g_data_input_stream_read_upto(BYVAL AS GDataInputStream PTR, BYVAL AS CONST gchar PTR, BYVAL AS gssize, BYVAL AS gsize PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS ZSTRING PTR
DECLARE SUB g_data_input_stream_read_upto_async(BYVAL AS GDataInputStream PTR, BYVAL AS CONST gchar PTR, BYVAL AS gssize, BYVAL AS gint, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_data_input_stream_read_upto_finish(BYVAL AS GDataInputStream PTR, BYVAL AS GAsyncResult PTR, BYVAL AS gsize PTR, BYVAL AS GError PTR PTR) AS ZSTRING PTR

#ENDIF ' __G_DATA_INPUT_STREAM_H__

#IFNDEF __G_DATA_OUTPUT_STREAM_H__
#DEFINE __G_DATA_OUTPUT_STREAM_H__

#DEFINE G_TYPE_DATA_OUTPUT_STREAM (g_data_output_stream_get_type ())
#DEFINE G_DATA_OUTPUT_STREAM(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_DATA_OUTPUT_STREAM, GDataOutputStream))
#DEFINE G_DATA_OUTPUT_STREAM_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_DATA_OUTPUT_STREAM, GDataOutputStreamClass))
#DEFINE G_IS_DATA_OUTPUT_STREAM(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_DATA_OUTPUT_STREAM))
#DEFINE G_IS_DATA_OUTPUT_STREAM_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), G_TYPE_DATA_OUTPUT_STREAM))
#DEFINE G_DATA_OUTPUT_STREAM_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), G_TYPE_DATA_OUTPUT_STREAM, GDataOutputStreamClass))

TYPE GDataOutputStream AS _GDataOutputStream
TYPE GDataOutputStreamClass AS _GDataOutputStreamClass
TYPE GDataOutputStreamPrivate AS _GDataOutputStreamPrivate

TYPE _GDataOutputStream
  AS GFilterOutputStream parent_instance
  AS GDataOutputStreamPrivate PTR priv
END TYPE

TYPE _GDataOutputStreamClass
  AS GFilterOutputStreamClass parent_class
  _g_reserved1 AS SUB()
  _g_reserved2 AS SUB()
  _g_reserved3 AS SUB()
  _g_reserved4 AS SUB()
  _g_reserved5 AS SUB()
END TYPE

DECLARE FUNCTION g_data_output_stream_get_type() AS GType
DECLARE FUNCTION g_data_output_stream_new(BYVAL AS GOutputStream PTR) AS GDataOutputStream PTR
DECLARE SUB g_data_output_stream_set_byte_order(BYVAL AS GDataOutputStream PTR, BYVAL AS GDataStreamByteOrder)
DECLARE FUNCTION g_data_output_stream_get_byte_order(BYVAL AS GDataOutputStream PTR) AS GDataStreamByteOrder
DECLARE FUNCTION g_data_output_stream_put_byte(BYVAL AS GDataOutputStream PTR, BYVAL AS guchar, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_data_output_stream_put_int16(BYVAL AS GDataOutputStream PTR, BYVAL AS gint16, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_data_output_stream_put_uint16(BYVAL AS GDataOutputStream PTR, BYVAL AS guint16, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_data_output_stream_put_int32(BYVAL AS GDataOutputStream PTR, BYVAL AS gint32, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_data_output_stream_put_uint32(BYVAL AS GDataOutputStream PTR, BYVAL AS guint32, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_data_output_stream_put_int64(BYVAL AS GDataOutputStream PTR, BYVAL AS gint64, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_data_output_stream_put_uint64(BYVAL AS GDataOutputStream PTR, BYVAL AS guint64, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_data_output_stream_put_string(BYVAL AS GDataOutputStream PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean

#ENDIF ' __G_DATA_OUTPUT_STREAM_H__

#IFNDEF __G_DBUS_ADDRESS_H__
#DEFINE __G_DBUS_ADDRESS_H__

DECLARE FUNCTION g_dbus_is_address(BYVAL AS CONST gchar PTR) AS gboolean
DECLARE FUNCTION g_dbus_is_supported_address(BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE SUB g_dbus_address_get_stream(BYVAL AS CONST gchar PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_dbus_address_get_stream_finish(BYVAL AS GAsyncResult PTR, BYVAL AS gchar PTR PTR, BYVAL AS GError PTR PTR) AS GIOStream PTR
DECLARE FUNCTION g_dbus_address_get_stream_sync(BYVAL AS CONST gchar PTR, BYVAL AS gchar PTR PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GIOStream PTR
DECLARE FUNCTION g_dbus_address_get_for_bus_sync(BYVAL AS GBusType, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gchar PTR

#ENDIF ' __G_DBUS_ADDRESS_H__

#IFNDEF __G_DBUS_AUTH_OBSERVER_H__
#DEFINE __G_DBUS_AUTH_OBSERVER_H__

#DEFINE G_TYPE_DBUS_AUTH_OBSERVER (g_dbus_auth_observer_get_type ())
#DEFINE G_DBUS_AUTH_OBSERVER(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_DBUS_AUTH_OBSERVER, GDBusAuthObserver))
#DEFINE G_IS_DBUS_AUTH_OBSERVER(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_DBUS_AUTH_OBSERVER))

DECLARE FUNCTION g_dbus_auth_observer_get_type() AS GType
DECLARE FUNCTION g_dbus_auth_observer_new() AS GDBusAuthObserver PTR
DECLARE FUNCTION g_dbus_auth_observer_authorize_authenticated_peer(BYVAL AS GDBusAuthObserver PTR, BYVAL AS GIOStream PTR, BYVAL AS GCredentials PTR) AS gboolean

#ENDIF ' __G_DBUS_AUTH_OBSERVER_H__

#IFNDEF __G_DBUS_CONNECTION_H__
#DEFINE __G_DBUS_CONNECTION_H__

#DEFINE G_TYPE_DBUS_CONNECTION (g_dbus_connection_get_type ())
#DEFINE G_DBUS_CONNECTION(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_DBUS_CONNECTION, GDBusConnection))
#DEFINE G_IS_DBUS_CONNECTION(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_DBUS_CONNECTION))

DECLARE FUNCTION g_dbus_connection_get_type() AS GType
DECLARE SUB g_bus_get(BYVAL AS GBusType, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_bus_get_finish(BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GDBusConnection PTR
DECLARE FUNCTION g_bus_get_sync(BYVAL AS GBusType, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GDBusConnection PTR
DECLARE SUB g_dbus_connection_new(BYVAL AS GIOStream PTR, BYVAL AS CONST gchar PTR, BYVAL AS GDBusConnectionFlags, BYVAL AS GDBusAuthObserver PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_dbus_connection_new_finish(BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GDBusConnection PTR
DECLARE FUNCTION g_dbus_connection_new_sync(BYVAL AS GIOStream PTR, BYVAL AS CONST gchar PTR, BYVAL AS GDBusConnectionFlags, BYVAL AS GDBusAuthObserver PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GDBusConnection PTR
DECLARE SUB g_dbus_connection_new_for_address(BYVAL AS CONST gchar PTR, BYVAL AS GDBusConnectionFlags, BYVAL AS GDBusAuthObserver PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_dbus_connection_new_for_address_finish(BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GDBusConnection PTR
DECLARE FUNCTION g_dbus_connection_new_for_address_sync(BYVAL AS CONST gchar PTR, BYVAL AS GDBusConnectionFlags, BYVAL AS GDBusAuthObserver PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GDBusConnection PTR
DECLARE SUB g_dbus_connection_start_message_processing(BYVAL AS GDBusConnection PTR)
DECLARE FUNCTION g_dbus_connection_is_closed(BYVAL AS GDBusConnection PTR) AS gboolean
DECLARE FUNCTION g_dbus_connection_get_stream(BYVAL AS GDBusConnection PTR) AS GIOStream PTR
DECLARE FUNCTION g_dbus_connection_get_guid(BYVAL AS GDBusConnection PTR) AS CONST gchar PTR
DECLARE FUNCTION g_dbus_connection_get_unique_name(BYVAL AS GDBusConnection PTR) AS CONST gchar PTR
DECLARE FUNCTION g_dbus_connection_get_peer_credentials(BYVAL AS GDBusConnection PTR) AS GCredentials PTR
DECLARE FUNCTION g_dbus_connection_get_exit_on_close(BYVAL AS GDBusConnection PTR) AS gboolean
DECLARE SUB g_dbus_connection_set_exit_on_close(BYVAL AS GDBusConnection PTR, BYVAL AS gboolean)
DECLARE FUNCTION g_dbus_connection_get_capabilities(BYVAL AS GDBusConnection PTR) AS GDBusCapabilityFlags
DECLARE SUB g_dbus_connection_close(BYVAL AS GDBusConnection PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_dbus_connection_close_finish(BYVAL AS GDBusConnection PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_dbus_connection_close_sync(BYVAL AS GDBusConnection PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE SUB g_dbus_connection_flush(BYVAL AS GDBusConnection PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_dbus_connection_flush_finish(BYVAL AS GDBusConnection PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_dbus_connection_flush_sync(BYVAL AS GDBusConnection PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_dbus_connection_send_message(BYVAL AS GDBusConnection PTR, BYVAL AS GDBusMessage PTR, BYVAL AS GDBusSendMessageFlags, BYVAL AS guint32 PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE SUB g_dbus_connection_send_message_with_reply(BYVAL AS GDBusConnection PTR, BYVAL AS GDBusMessage PTR, BYVAL AS GDBusSendMessageFlags, BYVAL AS gint, BYVAL AS guint32 PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_dbus_connection_send_message_with_reply_finish(BYVAL AS GDBusConnection PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GDBusMessage PTR
DECLARE FUNCTION g_dbus_connection_send_message_with_reply_sync(BYVAL AS GDBusConnection PTR, BYVAL AS GDBusMessage PTR, BYVAL AS GDBusSendMessageFlags, BYVAL AS gint, BYVAL AS guint32 PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GDBusMessage PTR
DECLARE FUNCTION g_dbus_connection_emit_signal(BYVAL AS GDBusConnection PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GVariant PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE SUB g_dbus_connection_call(BYVAL AS GDBusConnection PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GVariant PTR, BYVAL AS CONST GVariantType PTR, BYVAL AS GDBusCallFlags, BYVAL AS gint, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_dbus_connection_call_finish(BYVAL AS GDBusConnection PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GVariant PTR
DECLARE FUNCTION g_dbus_connection_call_sync(BYVAL AS GDBusConnection PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GVariant PTR, BYVAL AS CONST GVariantType PTR, BYVAL AS GDBusCallFlags, BYVAL AS gint, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GVariant PTR
DECLARE SUB g_dbus_connection_call_with_unix_fd_list(BYVAL AS GDBusConnection PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GVariant PTR, BYVAL AS CONST GVariantType PTR, BYVAL AS GDBusCallFlags, BYVAL AS gint, BYVAL AS GUnixFDList PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_dbus_connection_call_with_unix_fd_list_finish(BYVAL AS GDBusConnection PTR, BYVAL AS GUnixFDList PTR PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GVariant PTR
DECLARE FUNCTION g_dbus_connection_call_with_unix_fd_list_sync(BYVAL AS GDBusConnection PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GVariant PTR, BYVAL AS CONST GVariantType PTR, BYVAL AS GDBusCallFlags, BYVAL AS gint, BYVAL AS GUnixFDList PTR, BYVAL AS GUnixFDList PTR PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GVariant PTR

TYPE GDBusInterfaceMethodCallFunc AS SUB(BYVAL AS GDBusConnection PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GVariant PTR, BYVAL AS GDBusMethodInvocation PTR, BYVAL AS gpointer)
TYPE GDBusInterfaceGetPropertyFunc AS FUNCTION(BYVAL AS GDBusConnection PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR, BYVAL AS gpointer) AS GVariant PTR
TYPE GDBusInterfaceSetPropertyFunc AS FUNCTION(BYVAL AS GDBusConnection PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GVariant PTR, BYVAL AS GError PTR PTR, BYVAL AS gpointer) AS gboolean

TYPE _GDBusInterfaceVTable
  AS GDBusInterfaceMethodCallFunc method_call
  AS GDBusInterfaceGetPropertyFunc get_property
  AS GDBusInterfaceSetPropertyFunc set_property
  AS gpointer padding(7)
END TYPE

DECLARE FUNCTION g_dbus_connection_register_object(BYVAL AS GDBusConnection PTR, BYVAL AS CONST gchar PTR, BYVAL AS GDBusInterfaceInfo PTR, BYVAL AS CONST GDBusInterfaceVTable PTR, BYVAL AS gpointer, BYVAL AS GDestroyNotify, BYVAL AS GError PTR PTR) AS guint
DECLARE FUNCTION g_dbus_connection_unregister_object(BYVAL AS GDBusConnection PTR, BYVAL AS guint) AS gboolean

TYPE GDBusSubtreeEnumerateFunc AS FUNCTION(BYVAL AS GDBusConnection PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS gpointer) AS gchar PTR PTR
TYPE GDBusSubtreeIntrospectFunc AS FUNCTION(BYVAL AS GDBusConnection PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS gpointer) AS GDBusInterfaceInfo PTR PTR
TYPE GDBusSubtreeDispatchFunc AS FUNCTION(BYVAL AS GDBusConnection PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS gpointer PTR, BYVAL AS gpointer) AS CONST GDBusInterfaceVTable PTR

TYPE _GDBusSubtreeVTable
  AS GDBusSubtreeEnumerateFunc enumerate
  AS GDBusSubtreeIntrospectFunc introspect
  AS GDBusSubtreeDispatchFunc dispatch
  AS gpointer padding(7)
END TYPE

DECLARE FUNCTION g_dbus_connection_register_subtree(BYVAL AS GDBusConnection PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST GDBusSubtreeVTable PTR, BYVAL AS GDBusSubtreeFlags, BYVAL AS gpointer, BYVAL AS GDestroyNotify, BYVAL AS GError PTR PTR) AS guint
DECLARE FUNCTION g_dbus_connection_unregister_subtree(BYVAL AS GDBusConnection PTR, BYVAL AS guint) AS gboolean

TYPE GDBusSignalCallback AS SUB(BYVAL AS GDBusConnection PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GVariant PTR, BYVAL AS gpointer)

DECLARE FUNCTION g_dbus_connection_signal_subscribe(BYVAL AS GDBusConnection PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GDBusSignalFlags, BYVAL AS GDBusSignalCallback, BYVAL AS gpointer, BYVAL AS GDestroyNotify) AS guint
DECLARE SUB g_dbus_connection_signal_unsubscribe(BYVAL AS GDBusConnection PTR, BYVAL AS guint)

TYPE GDBusMessageFilterFunction AS FUNCTION(BYVAL AS GDBusConnection PTR, BYVAL AS GDBusMessage PTR, BYVAL AS gboolean, BYVAL AS gpointer) AS GDBusMessage PTR

DECLARE FUNCTION g_dbus_connection_add_filter(BYVAL AS GDBusConnection PTR, BYVAL AS GDBusMessageFilterFunction, BYVAL AS gpointer, BYVAL AS GDestroyNotify) AS guint
DECLARE SUB g_dbus_connection_remove_filter(BYVAL AS GDBusConnection PTR, BYVAL AS guint)

#ENDIF ' __G_DBUS_CONNECTION_H__

#IFNDEF __G_DBUS_ERROR_H__
#DEFINE __G_DBUS_ERROR_H__

#DEFINE G_DBUS_ERROR g_dbus_error_quark()

DECLARE FUNCTION g_dbus_error_quark() AS GQuark
DECLARE FUNCTION g_dbus_error_is_remote_error(BYVAL AS CONST GError PTR) AS gboolean
DECLARE FUNCTION g_dbus_error_get_remote_error(BYVAL AS CONST GError PTR) AS gchar PTR
DECLARE FUNCTION g_dbus_error_strip_remote_error(BYVAL AS GError PTR) AS gboolean

TYPE _GDBusErrorEntry
  AS gint error_code
  AS CONST gchar PTR dbus_error_name
END TYPE

DECLARE FUNCTION g_dbus_error_register_error(BYVAL AS GQuark, BYVAL AS gint, BYVAL AS CONST gchar PTR) AS gboolean
DECLARE FUNCTION g_dbus_error_unregister_error(BYVAL AS GQuark, BYVAL AS gint, BYVAL AS CONST gchar PTR) AS gboolean
DECLARE SUB g_dbus_error_register_error_domain(BYVAL AS CONST gchar PTR, BYVAL AS gsize PTR, BYVAL AS CONST GDBusErrorEntry PTR, BYVAL AS guint)
DECLARE FUNCTION g_dbus_error_new_for_dbus_error(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR) AS GError PTR
DECLARE SUB g_dbus_error_set_dbus_error(BYVAL AS GError PTR PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, ...)
DECLARE SUB g_dbus_error_set_dbus_error_valist(BYVAL AS GError PTR PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS va_list)
DECLARE FUNCTION g_dbus_error_encode_gerror(BYVAL AS CONST GError PTR) AS gchar PTR

#ENDIF ' __G_DBUS_ERROR_H__

#IFNDEF __G_DBUS_INTROSPECTION_H__
#DEFINE __G_DBUS_INTROSPECTION_H__

TYPE _GDBusAnnotationInfo
  AS gint ref_count
  AS gchar PTR key
  AS gchar PTR value
  AS GDBusAnnotationInfo PTR PTR annotations
END TYPE

TYPE _GDBusArgInfo
  AS gint ref_count
  AS gchar PTR name
  AS gchar PTR signature
  AS GDBusAnnotationInfo PTR PTR annotations
END TYPE

TYPE _GDBusMethodInfo
  AS gint ref_count
  AS gchar PTR name
  AS GDBusArgInfo PTR PTR in_args
  AS GDBusArgInfo PTR PTR out_args
  AS GDBusAnnotationInfo PTR PTR annotations
END TYPE

TYPE _GDBusSignalInfo
  AS gint ref_count
  AS gchar PTR name
  AS GDBusArgInfo PTR PTR args
  AS GDBusAnnotationInfo PTR PTR annotations
END TYPE

TYPE _GDBusPropertyInfo
  AS gint ref_count
  AS gchar PTR name
  AS gchar PTR signature
  AS GDBusPropertyInfoFlags flags
  AS GDBusAnnotationInfo PTR PTR annotations
END TYPE

TYPE _GDBusInterfaceInfo
  AS gint ref_count
  AS gchar PTR name
  AS GDBusMethodInfo PTR PTR methods
  AS GDBusSignalInfo PTR PTR signals
  AS GDBusPropertyInfo PTR PTR properties
  AS GDBusAnnotationInfo PTR PTR annotations
END TYPE

TYPE _GDBusNodeInfo
  AS gint ref_count
  AS gchar PTR path
  AS GDBusInterfaceInfo PTR PTR interfaces
  AS GDBusNodeInfo PTR PTR nodes
  AS GDBusAnnotationInfo PTR PTR annotations
END TYPE

DECLARE FUNCTION g_dbus_annotation_info_lookup(BYVAL AS GDBusAnnotationInfo PTR PTR, BYVAL AS CONST gchar PTR) AS CONST gchar PTR
DECLARE FUNCTION g_dbus_interface_info_lookup_method(BYVAL AS GDBusInterfaceInfo PTR, BYVAL AS CONST gchar PTR) AS GDBusMethodInfo PTR
DECLARE FUNCTION g_dbus_interface_info_lookup_signal(BYVAL AS GDBusInterfaceInfo PTR, BYVAL AS CONST gchar PTR) AS GDBusSignalInfo PTR
DECLARE FUNCTION g_dbus_interface_info_lookup_property(BYVAL AS GDBusInterfaceInfo PTR, BYVAL AS CONST gchar PTR) AS GDBusPropertyInfo PTR
DECLARE SUB g_dbus_interface_info_cache_build(BYVAL AS GDBusInterfaceInfo PTR)
DECLARE SUB g_dbus_interface_info_cache_release(BYVAL AS GDBusInterfaceInfo PTR)
DECLARE SUB g_dbus_interface_info_generate_xml(BYVAL AS GDBusInterfaceInfo PTR, BYVAL AS guint, BYVAL AS GString PTR)
DECLARE FUNCTION g_dbus_node_info_new_for_xml(BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS GDBusNodeInfo PTR
DECLARE FUNCTION g_dbus_node_info_lookup_interface(BYVAL AS GDBusNodeInfo PTR, BYVAL AS CONST gchar PTR) AS GDBusInterfaceInfo PTR
DECLARE SUB g_dbus_node_info_generate_xml(BYVAL AS GDBusNodeInfo PTR, BYVAL AS guint, BYVAL AS GString PTR)
DECLARE FUNCTION g_dbus_node_info_ref(BYVAL AS GDBusNodeInfo PTR) AS GDBusNodeInfo PTR
DECLARE FUNCTION g_dbus_interface_info_ref(BYVAL AS GDBusInterfaceInfo PTR) AS GDBusInterfaceInfo PTR
DECLARE FUNCTION g_dbus_method_info_ref(BYVAL AS GDBusMethodInfo PTR) AS GDBusMethodInfo PTR
DECLARE FUNCTION g_dbus_signal_info_ref(BYVAL AS GDBusSignalInfo PTR) AS GDBusSignalInfo PTR
DECLARE FUNCTION g_dbus_property_info_ref(BYVAL AS GDBusPropertyInfo PTR) AS GDBusPropertyInfo PTR
DECLARE FUNCTION g_dbus_arg_info_ref(BYVAL AS GDBusArgInfo PTR) AS GDBusArgInfo PTR
DECLARE FUNCTION g_dbus_annotation_info_ref(BYVAL AS GDBusAnnotationInfo PTR) AS GDBusAnnotationInfo PTR
DECLARE SUB g_dbus_node_info_unref(BYVAL AS GDBusNodeInfo PTR)
DECLARE SUB g_dbus_interface_info_unref(BYVAL AS GDBusInterfaceInfo PTR)
DECLARE SUB g_dbus_method_info_unref(BYVAL AS GDBusMethodInfo PTR)
DECLARE SUB g_dbus_signal_info_unref(BYVAL AS GDBusSignalInfo PTR)
DECLARE SUB g_dbus_property_info_unref(BYVAL AS GDBusPropertyInfo PTR)
DECLARE SUB g_dbus_arg_info_unref(BYVAL AS GDBusArgInfo PTR)
DECLARE SUB g_dbus_annotation_info_unref(BYVAL AS GDBusAnnotationInfo PTR)

#DEFINE G_TYPE_DBUS_NODE_INFO (g_dbus_node_info_get_type ())
#DEFINE G_TYPE_DBUS_INTERFACE_INFO (g_dbus_interface_info_get_type ())
#DEFINE G_TYPE_DBUS_METHOD_INFO (g_dbus_method_info_get_type ())
#DEFINE G_TYPE_DBUS_SIGNAL_INFO (g_dbus_signal_info_get_type ())
#DEFINE G_TYPE_DBUS_PROPERTY_INFO (g_dbus_property_info_get_type ())
#DEFINE G_TYPE_DBUS_ARG_INFO (g_dbus_arg_info_get_type ())
#DEFINE G_TYPE_DBUS_ANNOTATION_INFO (g_dbus_annotation_info_get_type ())

DECLARE FUNCTION g_dbus_node_info_get_type() AS GType
DECLARE FUNCTION g_dbus_interface_info_get_type() AS GType
DECLARE FUNCTION g_dbus_method_info_get_type() AS GType
DECLARE FUNCTION g_dbus_signal_info_get_type() AS GType
DECLARE FUNCTION g_dbus_property_info_get_type() AS GType
DECLARE FUNCTION g_dbus_arg_info_get_type() AS GType
DECLARE FUNCTION g_dbus_annotation_info_get_type() AS GType

#ENDIF ' __G_DBUS_INTROSPECTION_H__

#IFNDEF __G_DBUS_MESSAGE_H__
#DEFINE __G_DBUS_MESSAGE_H__

#DEFINE G_TYPE_DBUS_MESSAGE (g_dbus_message_get_type ())
#DEFINE G_DBUS_MESSAGE(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_DBUS_MESSAGE, GDBusMessage))
#DEFINE G_IS_DBUS_MESSAGE(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_DBUS_MESSAGE))

DECLARE FUNCTION g_dbus_message_get_type() AS GType
DECLARE FUNCTION g_dbus_message_new() AS GDBusMessage PTR
DECLARE FUNCTION g_dbus_message_new_signal(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR) AS GDBusMessage PTR
DECLARE FUNCTION g_dbus_message_new_method_call(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR) AS GDBusMessage PTR
DECLARE FUNCTION g_dbus_message_new_method_reply(BYVAL AS GDBusMessage PTR) AS GDBusMessage PTR
DECLARE FUNCTION g_dbus_message_new_method_error(BYVAL AS GDBusMessage PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, ...) AS GDBusMessage PTR
DECLARE FUNCTION g_dbus_message_new_method_error_valist(BYVAL AS GDBusMessage PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS va_list) AS GDBusMessage PTR
DECLARE FUNCTION g_dbus_message_new_method_error_literal(BYVAL AS GDBusMessage PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR) AS GDBusMessage PTR
DECLARE FUNCTION g_dbus_message_print(BYVAL AS GDBusMessage PTR, BYVAL AS guint) AS gchar PTR
DECLARE FUNCTION g_dbus_message_get_locked(BYVAL AS GDBusMessage PTR) AS gboolean
DECLARE SUB g_dbus_message_lock(BYVAL AS GDBusMessage PTR)
DECLARE FUNCTION g_dbus_message_copy(BYVAL AS GDBusMessage PTR, BYVAL AS GError PTR PTR) AS GDBusMessage PTR
DECLARE FUNCTION g_dbus_message_get_byte_order(BYVAL AS GDBusMessage PTR) AS GDBusMessageByteOrder
DECLARE SUB g_dbus_message_set_byte_order(BYVAL AS GDBusMessage PTR, BYVAL AS GDBusMessageByteOrder)
DECLARE FUNCTION g_dbus_message_get_message_type(BYVAL AS GDBusMessage PTR) AS GDBusMessageType
DECLARE SUB g_dbus_message_set_message_type(BYVAL AS GDBusMessage PTR, BYVAL AS GDBusMessageType)
DECLARE FUNCTION g_dbus_message_get_flags(BYVAL AS GDBusMessage PTR) AS GDBusMessageFlags
DECLARE SUB g_dbus_message_set_flags(BYVAL AS GDBusMessage PTR, BYVAL AS GDBusMessageFlags)
DECLARE FUNCTION g_dbus_message_get_serial(BYVAL AS GDBusMessage PTR) AS guint32
DECLARE SUB g_dbus_message_set_serial(BYVAL AS GDBusMessage PTR, BYVAL AS guint32)
DECLARE FUNCTION g_dbus_message_get_header(BYVAL AS GDBusMessage PTR, BYVAL AS GDBusMessageHeaderField) AS GVariant PTR
DECLARE SUB g_dbus_message_set_header(BYVAL AS GDBusMessage PTR, BYVAL AS GDBusMessageHeaderField, BYVAL AS GVariant PTR)
DECLARE FUNCTION g_dbus_message_get_header_fields(BYVAL AS GDBusMessage PTR) AS guchar PTR
DECLARE FUNCTION g_dbus_message_get_body(BYVAL AS GDBusMessage PTR) AS GVariant PTR
DECLARE SUB g_dbus_message_set_body(BYVAL AS GDBusMessage PTR, BYVAL AS GVariant PTR)
DECLARE FUNCTION g_dbus_message_get_unix_fd_list(BYVAL AS GDBusMessage PTR) AS GUnixFDList PTR
DECLARE SUB g_dbus_message_set_unix_fd_list(BYVAL AS GDBusMessage PTR, BYVAL AS GUnixFDList PTR)
DECLARE FUNCTION g_dbus_message_get_reply_serial(BYVAL AS GDBusMessage PTR) AS guint32
DECLARE SUB g_dbus_message_set_reply_serial(BYVAL AS GDBusMessage PTR, BYVAL AS guint32)
DECLARE FUNCTION g_dbus_message_get_interface(BYVAL AS GDBusMessage PTR) AS CONST gchar PTR
DECLARE SUB g_dbus_message_set_interface(BYVAL AS GDBusMessage PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION g_dbus_message_get_member(BYVAL AS GDBusMessage PTR) AS CONST gchar PTR
DECLARE SUB g_dbus_message_set_member(BYVAL AS GDBusMessage PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION g_dbus_message_get_path(BYVAL AS GDBusMessage PTR) AS CONST gchar PTR
DECLARE SUB g_dbus_message_set_path(BYVAL AS GDBusMessage PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION g_dbus_message_get_sender(BYVAL AS GDBusMessage PTR) AS CONST gchar PTR
DECLARE SUB g_dbus_message_set_sender(BYVAL AS GDBusMessage PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION g_dbus_message_get_destination(BYVAL AS GDBusMessage PTR) AS CONST gchar PTR
DECLARE SUB g_dbus_message_set_destination(BYVAL AS GDBusMessage PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION g_dbus_message_get_error_name(BYVAL AS GDBusMessage PTR) AS CONST gchar PTR
DECLARE SUB g_dbus_message_set_error_name(BYVAL AS GDBusMessage PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION g_dbus_message_get_signature(BYVAL AS GDBusMessage PTR) AS CONST gchar PTR
DECLARE SUB g_dbus_message_set_signature(BYVAL AS GDBusMessage PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION g_dbus_message_get_num_unix_fds(BYVAL AS GDBusMessage PTR) AS guint32
DECLARE SUB g_dbus_message_set_num_unix_fds(BYVAL AS GDBusMessage PTR, BYVAL AS guint32)
DECLARE FUNCTION g_dbus_message_get_arg0(BYVAL AS GDBusMessage PTR) AS CONST gchar PTR
DECLARE FUNCTION g_dbus_message_new_from_blob(BYVAL AS guchar PTR, BYVAL AS gsize, BYVAL AS GDBusCapabilityFlags, BYVAL AS GError PTR PTR) AS GDBusMessage PTR
DECLARE FUNCTION g_dbus_message_bytes_needed(BYVAL AS guchar PTR, BYVAL AS gsize, BYVAL AS GError PTR PTR) AS gssize
DECLARE FUNCTION g_dbus_message_to_blob(BYVAL AS GDBusMessage PTR, BYVAL AS gsize PTR, BYVAL AS GDBusCapabilityFlags, BYVAL AS GError PTR PTR) AS guchar PTR
DECLARE FUNCTION g_dbus_message_to_gerror(BYVAL AS GDBusMessage PTR, BYVAL AS GError PTR PTR) AS gboolean

#ENDIF ' __G_DBUS_MESSAGE_H__

#IFNDEF __G_DBUS_METHOD_INVOCATION_H__
#DEFINE __G_DBUS_METHOD_INVOCATION_H__

#DEFINE G_TYPE_DBUS_METHOD_INVOCATION (g_dbus_method_invocation_get_type ())
#DEFINE G_DBUS_METHOD_INVOCATION(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_DBUS_METHOD_INVOCATION, GDBusMethodInvocation))
#DEFINE G_IS_DBUS_METHOD_INVOCATION(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_DBUS_METHOD_INVOCATION))

DECLARE FUNCTION g_dbus_method_invocation_get_type() AS GType
DECLARE FUNCTION g_dbus_method_invocation_get_sender(BYVAL AS GDBusMethodInvocation PTR) AS CONST gchar PTR
DECLARE FUNCTION g_dbus_method_invocation_get_object_path(BYVAL AS GDBusMethodInvocation PTR) AS CONST gchar PTR
DECLARE FUNCTION g_dbus_method_invocation_get_interface_name(BYVAL AS GDBusMethodInvocation PTR) AS CONST gchar PTR
DECLARE FUNCTION g_dbus_method_invocation_get_method_name(BYVAL AS GDBusMethodInvocation PTR) AS CONST gchar PTR
DECLARE FUNCTION g_dbus_method_invocation_get_method_info(BYVAL AS GDBusMethodInvocation PTR) AS CONST GDBusMethodInfo PTR
DECLARE FUNCTION g_dbus_method_invocation_get_connection(BYVAL AS GDBusMethodInvocation PTR) AS GDBusConnection PTR
DECLARE FUNCTION g_dbus_method_invocation_get_message(BYVAL AS GDBusMethodInvocation PTR) AS GDBusMessage PTR
DECLARE FUNCTION g_dbus_method_invocation_get_parameters(BYVAL AS GDBusMethodInvocation PTR) AS GVariant PTR
DECLARE FUNCTION g_dbus_method_invocation_get_user_data(BYVAL AS GDBusMethodInvocation PTR) AS gpointer
DECLARE SUB g_dbus_method_invocation_return_value(BYVAL AS GDBusMethodInvocation PTR, BYVAL AS GVariant PTR)
DECLARE SUB g_dbus_method_invocation_return_value_with_unix_fd_list(BYVAL AS GDBusMethodInvocation PTR, BYVAL AS GVariant PTR, BYVAL AS GUnixFDList PTR)
DECLARE SUB g_dbus_method_invocation_return_error(BYVAL AS GDBusMethodInvocation PTR, BYVAL AS GQuark, BYVAL AS gint, BYVAL AS CONST gchar PTR, ...)
DECLARE SUB g_dbus_method_invocation_return_error_valist(BYVAL AS GDBusMethodInvocation PTR, BYVAL AS GQuark, BYVAL AS gint, BYVAL AS CONST gchar PTR, BYVAL AS va_list)
DECLARE SUB g_dbus_method_invocation_return_error_literal(BYVAL AS GDBusMethodInvocation PTR, BYVAL AS GQuark, BYVAL AS gint, BYVAL AS CONST gchar PTR)
DECLARE SUB g_dbus_method_invocation_return_gerror(BYVAL AS GDBusMethodInvocation PTR, BYVAL AS CONST GError PTR)
DECLARE SUB g_dbus_method_invocation_take_error(BYVAL AS GDBusMethodInvocation PTR, BYVAL AS GError PTR)
DECLARE SUB g_dbus_method_invocation_return_dbus_error(BYVAL AS GDBusMethodInvocation PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR)

#ENDIF ' __G_DBUS_METHOD_INVOCATION_H__

#IFNDEF __G_DBUS_NAME_OWNING_H__
#DEFINE __G_DBUS_NAME_OWNING_H__

TYPE GBusAcquiredCallback AS SUB(BYVAL AS GDBusConnection PTR, BYVAL AS CONST gchar PTR, BYVAL AS gpointer)
TYPE GBusNameAcquiredCallback AS SUB(BYVAL AS GDBusConnection PTR, BYVAL AS CONST gchar PTR, BYVAL AS gpointer)
TYPE GBusNameLostCallback AS SUB(BYVAL AS GDBusConnection PTR, BYVAL AS CONST gchar PTR, BYVAL AS gpointer)

DECLARE FUNCTION g_bus_own_name(BYVAL AS GBusType, BYVAL AS CONST gchar PTR, BYVAL AS GBusNameOwnerFlags, BYVAL AS GBusAcquiredCallback, BYVAL AS GBusNameAcquiredCallback, BYVAL AS GBusNameLostCallback, BYVAL AS gpointer, BYVAL AS GDestroyNotify) AS guint
DECLARE FUNCTION g_bus_own_name_on_connection(BYVAL AS GDBusConnection PTR, BYVAL AS CONST gchar PTR, BYVAL AS GBusNameOwnerFlags, BYVAL AS GBusNameAcquiredCallback, BYVAL AS GBusNameLostCallback, BYVAL AS gpointer, BYVAL AS GDestroyNotify) AS guint
DECLARE FUNCTION g_bus_own_name_with_closures(BYVAL AS GBusType, BYVAL AS CONST gchar PTR, BYVAL AS GBusNameOwnerFlags, BYVAL AS GClosure PTR, BYVAL AS GClosure PTR, BYVAL AS GClosure PTR) AS guint
DECLARE FUNCTION g_bus_own_name_on_connection_with_closures(BYVAL AS GDBusConnection PTR, BYVAL AS CONST gchar PTR, BYVAL AS GBusNameOwnerFlags, BYVAL AS GClosure PTR, BYVAL AS GClosure PTR) AS guint
DECLARE SUB g_bus_unown_name(BYVAL AS guint)

#ENDIF ' __G_DBUS_NAME_OWNING_H__

#IFNDEF __G_DBUS_NAME_WATCHING_H__
#DEFINE __G_DBUS_NAME_WATCHING_H__

TYPE GBusNameAppearedCallback AS SUB(BYVAL AS GDBusConnection PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS gpointer)
TYPE GBusNameVanishedCallback AS SUB(BYVAL AS GDBusConnection PTR, BYVAL AS CONST gchar PTR, BYVAL AS gpointer)

DECLARE FUNCTION g_bus_watch_name(BYVAL AS GBusType, BYVAL AS CONST gchar PTR, BYVAL AS GBusNameWatcherFlags, BYVAL AS GBusNameAppearedCallback, BYVAL AS GBusNameVanishedCallback, BYVAL AS gpointer, BYVAL AS GDestroyNotify) AS guint
DECLARE FUNCTION g_bus_watch_name_on_connection(BYVAL AS GDBusConnection PTR, BYVAL AS CONST gchar PTR, BYVAL AS GBusNameWatcherFlags, BYVAL AS GBusNameAppearedCallback, BYVAL AS GBusNameVanishedCallback, BYVAL AS gpointer, BYVAL AS GDestroyNotify) AS guint
DECLARE FUNCTION g_bus_watch_name_with_closures(BYVAL AS GBusType, BYVAL AS CONST gchar PTR, BYVAL AS GBusNameWatcherFlags, BYVAL AS GClosure PTR, BYVAL AS GClosure PTR) AS guint
DECLARE FUNCTION g_bus_watch_name_on_connection_with_closures(BYVAL AS GDBusConnection PTR, BYVAL AS CONST gchar PTR, BYVAL AS GBusNameWatcherFlags, BYVAL AS GClosure PTR, BYVAL AS GClosure PTR) AS guint
DECLARE SUB g_bus_unwatch_name(BYVAL AS guint)

#ENDIF ' __G_DBUS_NAME_WATCHING_H__

#IFNDEF __G_DBUS_PROXY_H__
#DEFINE __G_DBUS_PROXY_H__

#DEFINE G_TYPE_DBUS_PROXY (g_dbus_proxy_get_type ())
#DEFINE G_DBUS_PROXY(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_DBUS_PROXY, GDBusProxy))
#DEFINE G_DBUS_PROXY_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_DBUS_PROXY, GDBusProxyClass))
#DEFINE G_DBUS_PROXY_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), G_TYPE_DBUS_PROXY, GDBusProxyClass))
#DEFINE G_IS_DBUS_PROXY(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_DBUS_PROXY))
#DEFINE G_IS_DBUS_PROXY_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), G_TYPE_DBUS_PROXY))

TYPE GDBusProxyClass AS _GDBusProxyClass
TYPE GDBusProxyPrivate AS _GDBusProxyPrivate

TYPE _GDBusProxy
  AS GObject parent_instance
  AS GDBusProxyPrivate PTR priv
END TYPE

TYPE _GDBusProxyClass
  AS GObjectClass parent_class
  g_properties_changed AS SUB(BYVAL AS GDBusProxy PTR, BYVAL AS GVariant PTR, BYVAL AS CONST gchar CONST PTR PTR)
  g_signal AS SUB(BYVAL AS GDBusProxy PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GVariant PTR)
  AS gpointer padding(31)
END TYPE

DECLARE FUNCTION g_dbus_proxy_get_type() AS GType
DECLARE SUB g_dbus_proxy_new(BYVAL AS GDBusConnection PTR, BYVAL AS GDBusProxyFlags, BYVAL AS GDBusInterfaceInfo PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_dbus_proxy_new_finish(BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GDBusProxy PTR
DECLARE FUNCTION g_dbus_proxy_new_sync(BYVAL AS GDBusConnection PTR, BYVAL AS GDBusProxyFlags, BYVAL AS GDBusInterfaceInfo PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GDBusProxy PTR
DECLARE SUB g_dbus_proxy_new_for_bus(BYVAL AS GBusType, BYVAL AS GDBusProxyFlags, BYVAL AS GDBusInterfaceInfo PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_dbus_proxy_new_for_bus_finish(BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GDBusProxy PTR
DECLARE FUNCTION g_dbus_proxy_new_for_bus_sync(BYVAL AS GBusType, BYVAL AS GDBusProxyFlags, BYVAL AS GDBusInterfaceInfo PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GDBusProxy PTR
DECLARE FUNCTION g_dbus_proxy_get_connection(BYVAL AS GDBusProxy PTR) AS GDBusConnection PTR
DECLARE FUNCTION g_dbus_proxy_get_flags(BYVAL AS GDBusProxy PTR) AS GDBusProxyFlags
DECLARE FUNCTION g_dbus_proxy_get_name(BYVAL AS GDBusProxy PTR) AS CONST gchar PTR
DECLARE FUNCTION g_dbus_proxy_get_name_owner(BYVAL AS GDBusProxy PTR) AS gchar PTR
DECLARE FUNCTION g_dbus_proxy_get_object_path(BYVAL AS GDBusProxy PTR) AS CONST gchar PTR
DECLARE FUNCTION g_dbus_proxy_get_interface_name(BYVAL AS GDBusProxy PTR) AS CONST gchar PTR
DECLARE FUNCTION g_dbus_proxy_get_default_timeout(BYVAL AS GDBusProxy PTR) AS gint
DECLARE SUB g_dbus_proxy_set_default_timeout(BYVAL AS GDBusProxy PTR, BYVAL AS gint)
DECLARE FUNCTION g_dbus_proxy_get_interface_info(BYVAL AS GDBusProxy PTR) AS GDBusInterfaceInfo PTR
DECLARE SUB g_dbus_proxy_set_interface_info(BYVAL AS GDBusProxy PTR, BYVAL AS GDBusInterfaceInfo PTR)
DECLARE FUNCTION g_dbus_proxy_get_cached_property(BYVAL AS GDBusProxy PTR, BYVAL AS CONST gchar PTR) AS GVariant PTR
DECLARE SUB g_dbus_proxy_set_cached_property(BYVAL AS GDBusProxy PTR, BYVAL AS CONST gchar PTR, BYVAL AS GVariant PTR)
DECLARE FUNCTION g_dbus_proxy_get_cached_property_names(BYVAL AS GDBusProxy PTR) AS gchar PTR PTR
DECLARE SUB g_dbus_proxy_call(BYVAL AS GDBusProxy PTR, BYVAL AS CONST gchar PTR, BYVAL AS GVariant PTR, BYVAL AS GDBusCallFlags, BYVAL AS gint, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_dbus_proxy_call_finish(BYVAL AS GDBusProxy PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GVariant PTR
DECLARE FUNCTION g_dbus_proxy_call_sync(BYVAL AS GDBusProxy PTR, BYVAL AS CONST gchar PTR, BYVAL AS GVariant PTR, BYVAL AS GDBusCallFlags, BYVAL AS gint, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GVariant PTR
DECLARE SUB g_dbus_proxy_call_with_unix_fd_list(BYVAL AS GDBusProxy PTR, BYVAL AS CONST gchar PTR, BYVAL AS GVariant PTR, BYVAL AS GDBusCallFlags, BYVAL AS gint, BYVAL AS GUnixFDList PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_dbus_proxy_call_with_unix_fd_list_finish(BYVAL AS GDBusProxy PTR, BYVAL AS GUnixFDList PTR PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GVariant PTR
DECLARE FUNCTION g_dbus_proxy_call_with_unix_fd_list_sync(BYVAL AS GDBusProxy PTR, BYVAL AS CONST gchar PTR, BYVAL AS GVariant PTR, BYVAL AS GDBusCallFlags, BYVAL AS gint, BYVAL AS GUnixFDList PTR, BYVAL AS GUnixFDList PTR PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GVariant PTR

#ENDIF ' __G_DBUS_PROXY_H__

#IFNDEF __G_DBUS_SERVER_H__
#DEFINE __G_DBUS_SERVER_H__

#DEFINE G_TYPE_DBUS_SERVER (g_dbus_server_get_type ())
#DEFINE G_DBUS_SERVER(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_DBUS_SERVER, GDBusServer))
#DEFINE G_IS_DBUS_SERVER(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_DBUS_SERVER))

DECLARE FUNCTION g_dbus_server_get_type() AS GType
DECLARE FUNCTION g_dbus_server_new_sync(BYVAL AS CONST gchar PTR, BYVAL AS GDBusServerFlags, BYVAL AS CONST gchar PTR, BYVAL AS GDBusAuthObserver PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GDBusServer PTR
DECLARE FUNCTION g_dbus_server_get_client_address(BYVAL AS GDBusServer PTR) AS CONST gchar PTR
DECLARE FUNCTION g_dbus_server_get_guid(BYVAL AS GDBusServer PTR) AS CONST gchar PTR
DECLARE FUNCTION g_dbus_server_get_flags(BYVAL AS GDBusServer PTR) AS GDBusServerFlags
DECLARE SUB g_dbus_server_start(BYVAL AS GDBusServer PTR)
DECLARE SUB g_dbus_server_stop(BYVAL AS GDBusServer PTR)
DECLARE FUNCTION g_dbus_server_is_active(BYVAL AS GDBusServer PTR) AS gboolean

#ENDIF ' __G_DBUS_SERVER_H__

#IFNDEF __G_DBUS_UTILS_H__
#DEFINE __G_DBUS_UTILS_H__

DECLARE FUNCTION g_dbus_is_guid(BYVAL AS CONST gchar PTR) AS gboolean
DECLARE FUNCTION g_dbus_generate_guid() AS gchar PTR
DECLARE FUNCTION g_dbus_is_name(BYVAL AS CONST gchar PTR) AS gboolean
DECLARE FUNCTION g_dbus_is_unique_name(BYVAL AS CONST gchar PTR) AS gboolean
DECLARE FUNCTION g_dbus_is_member_name(BYVAL AS CONST gchar PTR) AS gboolean
DECLARE FUNCTION g_dbus_is_interface_name(BYVAL AS CONST gchar PTR) AS gboolean
DECLARE SUB g_dbus_gvariant_to_gvalue(BYVAL AS GVariant PTR, BYVAL AS GValue PTR)
DECLARE FUNCTION g_dbus_gvalue_to_gvariant(BYVAL AS CONST GValue PTR, BYVAL AS CONST GVariantType PTR) AS GVariant PTR

#ENDIF ' __G_DBUS_UTILS_H__

#IFNDEF __G_DRIVE_H__
#DEFINE __G_DRIVE_H__

#DEFINE G_TYPE_DRIVE (g_drive_get_type ())
#DEFINE G_DRIVE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), G_TYPE_DRIVE, GDrive))
#DEFINE G_IS_DRIVE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), G_TYPE_DRIVE))
#DEFINE G_DRIVE_GET_IFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), G_TYPE_DRIVE, GDriveIface))

TYPE GDriveIface AS _GDriveIface

TYPE _GDriveIface
  AS GTypeInterface g_iface
  changed AS SUB(BYVAL AS GDrive PTR)
  disconnected AS SUB(BYVAL AS GDrive PTR)
  eject_button AS SUB(BYVAL AS GDrive PTR)
  get_name AS FUNCTION(BYVAL AS GDrive PTR) AS ZSTRING PTR
  get_icon AS FUNCTION(BYVAL AS GDrive PTR) AS GIcon PTR
  has_volumes AS FUNCTION(BYVAL AS GDrive PTR) AS gboolean
  get_volumes AS FUNCTION(BYVAL AS GDrive PTR) AS GList PTR
  is_media_removable AS FUNCTION(BYVAL AS GDrive PTR) AS gboolean
  has_media AS FUNCTION(BYVAL AS GDrive PTR) AS gboolean
  is_media_check_automatic AS FUNCTION(BYVAL AS GDrive PTR) AS gboolean
  can_eject AS FUNCTION(BYVAL AS GDrive PTR) AS gboolean
  can_poll_for_media AS FUNCTION(BYVAL AS GDrive PTR) AS gboolean
  eject AS SUB(BYVAL AS GDrive PTR, BYVAL AS GMountUnmountFlags, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  eject_finish AS FUNCTION(BYVAL AS GDrive PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
  poll_for_media AS SUB(BYVAL AS GDrive PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  poll_for_media_finish AS FUNCTION(BYVAL AS GDrive PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
  get_identifier AS FUNCTION(BYVAL AS GDrive PTR, BYVAL AS CONST ZSTRING PTR) AS ZSTRING PTR
  enumerate_identifiers AS FUNCTION(BYVAL AS GDrive PTR) AS ZSTRING PTR PTR
  get_start_stop_type AS FUNCTION(BYVAL AS GDrive PTR) AS GDriveStartStopType
  can_start AS FUNCTION(BYVAL AS GDrive PTR) AS gboolean
  can_start_degraded AS FUNCTION(BYVAL AS GDrive PTR) AS gboolean
  start AS SUB(BYVAL AS GDrive PTR, BYVAL AS GDriveStartFlags, BYVAL AS GMountOperation PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  start_finish AS FUNCTION(BYVAL AS GDrive PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
  can_stop AS FUNCTION(BYVAL AS GDrive PTR) AS gboolean
  stop_ AS SUB(BYVAL AS GDrive PTR, BYVAL AS GMountUnmountFlags, BYVAL AS GMountOperation PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  stop_finish AS FUNCTION(BYVAL AS GDrive PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
  stop_button AS SUB(BYVAL AS GDrive PTR)
  eject_with_operation AS SUB(BYVAL AS GDrive PTR, BYVAL AS GMountUnmountFlags, BYVAL AS GMountOperation PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  eject_with_operation_finish AS FUNCTION(BYVAL AS GDrive PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
  get_sort_key AS FUNCTION(BYVAL AS GDrive PTR) AS CONST gchar PTR
END TYPE

DECLARE FUNCTION g_drive_get_type() AS GType
DECLARE FUNCTION g_drive_get_name(BYVAL AS GDrive PTR) AS ZSTRING PTR
DECLARE FUNCTION g_drive_get_icon(BYVAL AS GDrive PTR) AS GIcon PTR
DECLARE FUNCTION g_drive_has_volumes(BYVAL AS GDrive PTR) AS gboolean
DECLARE FUNCTION g_drive_get_volumes(BYVAL AS GDrive PTR) AS GList PTR
DECLARE FUNCTION g_drive_is_media_removable(BYVAL AS GDrive PTR) AS gboolean
DECLARE FUNCTION g_drive_has_media(BYVAL AS GDrive PTR) AS gboolean
DECLARE FUNCTION g_drive_is_media_check_automatic(BYVAL AS GDrive PTR) AS gboolean
DECLARE FUNCTION g_drive_can_poll_for_media(BYVAL AS GDrive PTR) AS gboolean
DECLARE FUNCTION g_drive_can_eject(BYVAL AS GDrive PTR) AS gboolean
DECLARE SUB g_drive_eject(BYVAL AS GDrive PTR, BYVAL AS GMountUnmountFlags, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_drive_eject_finish(BYVAL AS GDrive PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE SUB g_drive_poll_for_media(BYVAL AS GDrive PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_drive_poll_for_media_finish(BYVAL AS GDrive PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_drive_get_identifier(BYVAL AS GDrive PTR, BYVAL AS CONST ZSTRING PTR) AS ZSTRING PTR
DECLARE FUNCTION g_drive_enumerate_identifiers(BYVAL AS GDrive PTR) AS ZSTRING PTR PTR
DECLARE FUNCTION g_drive_get_start_stop_type(BYVAL AS GDrive PTR) AS GDriveStartStopType
DECLARE FUNCTION g_drive_can_start(BYVAL AS GDrive PTR) AS gboolean
DECLARE FUNCTION g_drive_can_start_degraded(BYVAL AS GDrive PTR) AS gboolean
DECLARE SUB g_drive_start(BYVAL AS GDrive PTR, BYVAL AS GDriveStartFlags, BYVAL AS GMountOperation PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_drive_start_finish(BYVAL AS GDrive PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_drive_can_stop(BYVAL AS GDrive PTR) AS gboolean
DECLARE SUB g_drive_stop(BYVAL AS GDrive PTR, BYVAL AS GMountUnmountFlags, BYVAL AS GMountOperation PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_drive_stop_finish(BYVAL AS GDrive PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE SUB g_drive_eject_with_operation(BYVAL AS GDrive PTR, BYVAL AS GMountUnmountFlags, BYVAL AS GMountOperation PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_drive_eject_with_operation_finish(BYVAL AS GDrive PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_drive_get_sort_key(BYVAL AS GDrive PTR) AS CONST gchar PTR

#ENDIF ' __G_DRIVE_H__

#IFNDEF __G_EMBLEMED_ICON_H__
#DEFINE __G_EMBLEMED_ICON_H__

#IFNDEF __G_ICON_H__
#DEFINE __G_ICON_H__

#DEFINE G_TYPE_ICON (g_icon_get_type ())
#DEFINE G_ICON(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), G_TYPE_ICON, GIcon))
#DEFINE G_IS_ICON(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), G_TYPE_ICON))
#DEFINE G_ICON_GET_IFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), G_TYPE_ICON, GIconIface))

TYPE GIconIface AS _GIconIface

TYPE _GIconIface
  AS GTypeInterface g_iface
  hash AS FUNCTION(BYVAL AS GIcon PTR) AS guint
  equal AS FUNCTION(BYVAL AS GIcon PTR, BYVAL AS GIcon PTR) AS gboolean
  to_tokens AS FUNCTION(BYVAL AS GIcon PTR, BYVAL AS GPtrArray PTR, BYVAL AS gint PTR) AS gboolean
  from_tokens AS FUNCTION(BYVAL AS gchar PTR PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS GError PTR PTR) AS GIcon PTR
END TYPE

DECLARE FUNCTION g_icon_get_type() AS GType
DECLARE FUNCTION g_icon_hash(BYVAL AS gconstpointer) AS guint
DECLARE FUNCTION g_icon_equal(BYVAL AS GIcon PTR, BYVAL AS GIcon PTR) AS gboolean
DECLARE FUNCTION g_icon_to_string(BYVAL AS GIcon PTR) AS gchar PTR
DECLARE FUNCTION g_icon_new_for_string(BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS GIcon PTR

#ENDIF ' __G_ICON_H__

#IFNDEF __G_EMBLEM_H__
#DEFINE __G_EMBLEM_H__

#DEFINE G_TYPE_EMBLEM (g_emblem_get_type ())
#DEFINE G_EMBLEM(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_EMBLEM, GEmblem))
#DEFINE G_EMBLEM_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_EMBLEM, GEmblemClass))
#DEFINE G_IS_EMBLEM(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_EMBLEM))
#DEFINE G_IS_EMBLEM_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), G_TYPE_EMBLEM))
#DEFINE G_EMBLEM_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), G_TYPE_EMBLEM, GEmblemClass))

TYPE GEmblem AS _GEmblem
TYPE GEmblemClass AS _GEmblemClass

DECLARE FUNCTION g_emblem_get_type() AS GType
DECLARE FUNCTION g_emblem_new(BYVAL AS GIcon PTR) AS GEmblem PTR
DECLARE FUNCTION g_emblem_new_with_origin(BYVAL AS GIcon PTR, BYVAL AS GEmblemOrigin) AS GEmblem PTR
DECLARE FUNCTION g_emblem_get_icon(BYVAL AS GEmblem PTR) AS GIcon PTR
DECLARE FUNCTION g_emblem_get_origin(BYVAL AS GEmblem PTR) AS GEmblemOrigin

#ENDIF ' __G_EMBLEM_H__

#DEFINE G_TYPE_EMBLEMED_ICON (g_emblemed_icon_get_type ())
#DEFINE G_EMBLEMED_ICON(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_EMBLEMED_ICON, GEmblemedIcon))
#DEFINE G_EMBLEMED_ICON_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_EMBLEMED_ICON, GEmblemedIconClass))
#DEFINE G_IS_EMBLEMED_ICON(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_EMBLEMED_ICON))
#DEFINE G_IS_EMBLEMED_ICON_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), G_TYPE_EMBLEMED_ICON))
#DEFINE G_EMBLEMED_ICON_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), G_TYPE_EMBLEMED_ICON, GEmblemedIconClass))

TYPE GEmblemedIcon AS _GEmblemedIcon
TYPE GEmblemedIconClass AS _GEmblemedIconClass
TYPE GEmblemedIconPrivate AS _GEmblemedIconPrivate

TYPE _GEmblemedIcon
  AS GObject parent_instance
  AS GEmblemedIconPrivate PTR priv
END TYPE

TYPE _GEmblemedIconClass
  AS GObjectClass parent_class
END TYPE

DECLARE FUNCTION g_emblemed_icon_get_type() AS GType
DECLARE FUNCTION g_emblemed_icon_new(BYVAL AS GIcon PTR, BYVAL AS GEmblem PTR) AS GIcon PTR
DECLARE FUNCTION g_emblemed_icon_get_icon(BYVAL AS GEmblemedIcon PTR) AS GIcon PTR
DECLARE FUNCTION g_emblemed_icon_get_emblems(BYVAL AS GEmblemedIcon PTR) AS GList PTR
DECLARE SUB g_emblemed_icon_add_emblem(BYVAL AS GEmblemedIcon PTR, BYVAL AS GEmblem PTR)
DECLARE SUB g_emblemed_icon_clear_emblems(BYVAL AS GEmblemedIcon PTR)

#ENDIF ' __G_EMBLEMED_ICON_H__

#IFNDEF __G_FILE_ATTRIBUTE_H__
#DEFINE __G_FILE_ATTRIBUTE_H__

TYPE _GFileAttributeInfo
  AS ZSTRING PTR name
  AS GFileAttributeType type
  AS GFileAttributeInfoFlags flags
END TYPE

TYPE _GFileAttributeInfoList
  AS GFileAttributeInfo PTR infos
  AS INTEGER n_infos
END TYPE

DECLARE FUNCTION g_file_attribute_info_list_get_type() AS GType
DECLARE FUNCTION g_file_attribute_info_list_new() AS GFileAttributeInfoList PTR
DECLARE FUNCTION g_file_attribute_info_list_ref(BYVAL AS GFileAttributeInfoList PTR) AS GFileAttributeInfoList PTR
DECLARE SUB g_file_attribute_info_list_unref(BYVAL AS GFileAttributeInfoList PTR)
DECLARE FUNCTION g_file_attribute_info_list_dup(BYVAL AS GFileAttributeInfoList PTR) AS GFileAttributeInfoList PTR
DECLARE FUNCTION g_file_attribute_info_list_lookup(BYVAL AS GFileAttributeInfoList PTR, BYVAL AS CONST ZSTRING PTR) AS CONST GFileAttributeInfo PTR
DECLARE SUB g_file_attribute_info_list_add(BYVAL AS GFileAttributeInfoList PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS GFileAttributeType, BYVAL AS GFileAttributeInfoFlags)

#ENDIF ' __G_FILE_ATTRIBUTE_H__

#IFNDEF __G_FILE_ENUMERATOR_H__
#DEFINE __G_FILE_ENUMERATOR_H__

#DEFINE G_TYPE_FILE_ENUMERATOR (g_file_enumerator_get_type ())
#DEFINE G_FILE_ENUMERATOR(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_FILE_ENUMERATOR, GFileEnumerator))
#DEFINE G_FILE_ENUMERATOR_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_FILE_ENUMERATOR, GFileEnumeratorClass))
#DEFINE G_IS_FILE_ENUMERATOR(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_FILE_ENUMERATOR))
#DEFINE G_IS_FILE_ENUMERATOR_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), G_TYPE_FILE_ENUMERATOR))
#DEFINE G_FILE_ENUMERATOR_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), G_TYPE_FILE_ENUMERATOR, GFileEnumeratorClass))

TYPE GFileEnumeratorClass AS _GFileEnumeratorClass
TYPE GFileEnumeratorPrivate AS _GFileEnumeratorPrivate

TYPE _GFileEnumerator
  AS GObject parent_instance
  AS GFileEnumeratorPrivate PTR priv
END TYPE

TYPE _GFileEnumeratorClass
  AS GObjectClass parent_class
  next_file AS FUNCTION(BYVAL AS GFileEnumerator PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GFileInfo PTR
  close_fn AS FUNCTION(BYVAL AS GFileEnumerator PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
  next_files_async AS SUB(BYVAL AS GFileEnumerator PTR, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  next_files_finish AS FUNCTION(BYVAL AS GFileEnumerator PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GList PTR
  close_async AS SUB(BYVAL AS GFileEnumerator PTR, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  close_finish AS FUNCTION(BYVAL AS GFileEnumerator PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
  _g_reserved1 AS SUB()
  _g_reserved2 AS SUB()
  _g_reserved3 AS SUB()
  _g_reserved4 AS SUB()
  _g_reserved5 AS SUB()
  _g_reserved6 AS SUB()
  _g_reserved7 AS SUB()
END TYPE

DECLARE FUNCTION g_file_enumerator_get_type() AS GType
DECLARE FUNCTION g_file_enumerator_next_file(BYVAL AS GFileEnumerator PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GFileInfo PTR
DECLARE FUNCTION g_file_enumerator_close(BYVAL AS GFileEnumerator PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE SUB g_file_enumerator_next_files_async(BYVAL AS GFileEnumerator PTR, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_file_enumerator_next_files_finish(BYVAL AS GFileEnumerator PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GList PTR
DECLARE SUB g_file_enumerator_close_async(BYVAL AS GFileEnumerator PTR, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_file_enumerator_close_finish(BYVAL AS GFileEnumerator PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_file_enumerator_is_closed(BYVAL AS GFileEnumerator PTR) AS gboolean
DECLARE FUNCTION g_file_enumerator_has_pending(BYVAL AS GFileEnumerator PTR) AS gboolean
DECLARE SUB g_file_enumerator_set_pending(BYVAL AS GFileEnumerator PTR, BYVAL AS gboolean)
DECLARE FUNCTION g_file_enumerator_get_container(BYVAL AS GFileEnumerator PTR) AS GFile PTR

#ENDIF ' __G_FILE_ENUMERATOR_H__

#IFNDEF __G_FILE_H__
#DEFINE __G_FILE_H__

#DEFINE G_TYPE_FILE (g_file_get_type ())
#DEFINE G_FILE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), G_TYPE_FILE, GFile))
#DEFINE G_IS_FILE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), G_TYPE_FILE))
#DEFINE G_FILE_GET_IFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), G_TYPE_FILE, GFileIface))

#IF 0

TYPE GFile AS _GFile

#ENDIF ' 0

TYPE GFileIface AS _GFileIface

TYPE _GFileIface
  AS GTypeInterface g_iface
  dup AS FUNCTION(BYVAL AS GFile PTR) AS GFile PTR
  hash AS FUNCTION(BYVAL AS GFile PTR) AS guint
  equal AS FUNCTION(BYVAL AS GFile PTR, BYVAL AS GFile PTR) AS gboolean
  is_native AS FUNCTION(BYVAL AS GFile PTR) AS gboolean
  has_uri_scheme AS FUNCTION(BYVAL AS GFile PTR, BYVAL AS CONST ZSTRING PTR) AS gboolean
  get_uri_scheme AS FUNCTION(BYVAL AS GFile PTR) AS ZSTRING PTR
  get_basename AS FUNCTION(BYVAL AS GFile PTR) AS ZSTRING PTR
  get_path AS FUNCTION(BYVAL AS GFile PTR) AS ZSTRING PTR
  get_uri AS FUNCTION(BYVAL AS GFile PTR) AS ZSTRING PTR
  get_parse_name AS FUNCTION(BYVAL AS GFile PTR) AS ZSTRING PTR
  get_parent AS FUNCTION(BYVAL AS GFile PTR) AS GFile PTR
  prefix_matches AS FUNCTION(BYVAL AS GFile PTR, BYVAL AS GFile PTR) AS gboolean
  get_relative_path AS FUNCTION(BYVAL AS GFile PTR, BYVAL AS GFile PTR) AS ZSTRING PTR
  resolve_relative_path AS FUNCTION(BYVAL AS GFile PTR, BYVAL AS CONST ZSTRING PTR) AS GFile PTR
  get_child_for_display_name AS FUNCTION(BYVAL AS GFile PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS GError PTR PTR) AS GFile PTR
  enumerate_children AS FUNCTION(BYVAL AS GFile PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS GFileQueryInfoFlags, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GFileEnumerator PTR
  enumerate_children_async AS SUB(BYVAL AS GFile PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS GFileQueryInfoFlags, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  enumerate_children_finish AS FUNCTION(BYVAL AS GFile PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GFileEnumerator PTR
  query_info AS FUNCTION(BYVAL AS GFile PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS GFileQueryInfoFlags, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GFileInfo PTR
  query_info_async AS SUB(BYVAL AS GFile PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS GFileQueryInfoFlags, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  query_info_finish AS FUNCTION(BYVAL AS GFile PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GFileInfo PTR
  query_filesystem_info AS FUNCTION(BYVAL AS GFile PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GFileInfo PTR
  query_filesystem_info_async AS SUB(BYVAL AS GFile PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  query_filesystem_info_finish AS FUNCTION(BYVAL AS GFile PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GFileInfo PTR
  find_enclosing_mount AS FUNCTION(BYVAL AS GFile PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GMount PTR
  find_enclosing_mount_async AS SUB(BYVAL AS GFile PTR, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  find_enclosing_mount_finish AS FUNCTION(BYVAL AS GFile PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GMount PTR
  set_display_name AS FUNCTION(BYVAL AS GFile PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GFile PTR
  set_display_name_async AS SUB(BYVAL AS GFile PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  set_display_name_finish AS FUNCTION(BYVAL AS GFile PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GFile PTR
  query_settable_attributes AS FUNCTION(BYVAL AS GFile PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GFileAttributeInfoList PTR
  _query_settable_attributes_async AS SUB()
  _query_settable_attributes_finish AS SUB()
  query_writable_namespaces AS FUNCTION(BYVAL AS GFile PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GFileAttributeInfoList PTR
  _query_writable_namespaces_async AS SUB()
  _query_writable_namespaces_finish AS SUB()
  set_attribute AS FUNCTION(BYVAL AS GFile PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS GFileAttributeType, BYVAL AS gpointer, BYVAL AS GFileQueryInfoFlags, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
  set_attributes_from_info AS FUNCTION(BYVAL AS GFile PTR, BYVAL AS GFileInfo PTR, BYVAL AS GFileQueryInfoFlags, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
  set_attributes_async AS SUB(BYVAL AS GFile PTR, BYVAL AS GFileInfo PTR, BYVAL AS GFileQueryInfoFlags, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  set_attributes_finish AS FUNCTION(BYVAL AS GFile PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GFileInfo PTR PTR, BYVAL AS GError PTR PTR) AS gboolean
  read_fn AS FUNCTION(BYVAL AS GFile PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GFileInputStream PTR
  read_async AS SUB(BYVAL AS GFile PTR, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  read_finish AS FUNCTION(BYVAL AS GFile PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GFileInputStream PTR
  append_to AS FUNCTION(BYVAL AS GFile PTR, BYVAL AS GFileCreateFlags, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GFileOutputStream PTR
  append_to_async AS SUB(BYVAL AS GFile PTR, BYVAL AS GFileCreateFlags, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  append_to_finish AS FUNCTION(BYVAL AS GFile PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GFileOutputStream PTR
  create AS FUNCTION(BYVAL AS GFile PTR, BYVAL AS GFileCreateFlags, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GFileOutputStream PTR
  create_async AS SUB(BYVAL AS GFile PTR, BYVAL AS GFileCreateFlags, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  create_finish AS FUNCTION(BYVAL AS GFile PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GFileOutputStream PTR
  replace AS FUNCTION(BYVAL AS GFile PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS gboolean, BYVAL AS GFileCreateFlags, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GFileOutputStream PTR
  replace_async AS SUB(BYVAL AS GFile PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS gboolean, BYVAL AS GFileCreateFlags, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  replace_finish AS FUNCTION(BYVAL AS GFile PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GFileOutputStream PTR
  delete_file AS FUNCTION(BYVAL AS GFile PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
  _delete_file_async AS SUB()
  _delete_file_finish AS SUB()
  trash AS FUNCTION(BYVAL AS GFile PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
  _trash_async AS SUB()
  _trash_finish AS SUB()
  make_directory AS FUNCTION(BYVAL AS GFile PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
  _make_directory_async AS SUB()
  _make_directory_finish AS SUB()
  make_symbolic_link AS FUNCTION(BYVAL AS GFile PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
  _make_symbolic_link_async AS SUB()
  _make_symbolic_link_finish AS SUB()
  copy AS FUNCTION(BYVAL AS GFile PTR, BYVAL AS GFile PTR, BYVAL AS GFileCopyFlags, BYVAL AS GCancellable PTR, BYVAL AS GFileProgressCallback, BYVAL AS gpointer, BYVAL AS GError PTR PTR) AS gboolean
  copy_async AS SUB(BYVAL AS GFile PTR, BYVAL AS GFile PTR, BYVAL AS GFileCopyFlags, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GFileProgressCallback, BYVAL AS gpointer, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  copy_finish AS FUNCTION(BYVAL AS GFile PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
  move AS FUNCTION(BYVAL AS GFile PTR, BYVAL AS GFile PTR, BYVAL AS GFileCopyFlags, BYVAL AS GCancellable PTR, BYVAL AS GFileProgressCallback, BYVAL AS gpointer, BYVAL AS GError PTR PTR) AS gboolean
  _move_async AS SUB()
  _move_finish AS SUB()
  mount_mountable AS SUB(BYVAL AS GFile PTR, BYVAL AS GMountMountFlags, BYVAL AS GMountOperation PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  mount_mountable_finish AS FUNCTION(BYVAL AS GFile PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GFile PTR
  unmount_mountable AS SUB(BYVAL AS GFile PTR, BYVAL AS GMountUnmountFlags, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  unmount_mountable_finish AS FUNCTION(BYVAL AS GFile PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
  eject_mountable AS SUB(BYVAL AS GFile PTR, BYVAL AS GMountUnmountFlags, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  eject_mountable_finish AS FUNCTION(BYVAL AS GFile PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
  mount_enclosing_volume AS SUB(BYVAL AS GFile PTR, BYVAL AS GMountMountFlags, BYVAL AS GMountOperation PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  mount_enclosing_volume_finish AS FUNCTION(BYVAL AS GFile PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
  monitor_dir AS FUNCTION(BYVAL AS GFile PTR, BYVAL AS GFileMonitorFlags, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GFileMonitor PTR
  monitor_file AS FUNCTION(BYVAL AS GFile PTR, BYVAL AS GFileMonitorFlags, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GFileMonitor PTR
  open_readwrite AS FUNCTION(BYVAL AS GFile PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GFileIOStream PTR
  open_readwrite_async AS SUB(BYVAL AS GFile PTR, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  open_readwrite_finish AS FUNCTION(BYVAL AS GFile PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GFileIOStream PTR
  create_readwrite AS FUNCTION(BYVAL AS GFile PTR, BYVAL AS GFileCreateFlags, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GFileIOStream PTR
  create_readwrite_async AS SUB(BYVAL AS GFile PTR, BYVAL AS GFileCreateFlags, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  create_readwrite_finish AS FUNCTION(BYVAL AS GFile PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GFileIOStream PTR
  replace_readwrite AS FUNCTION(BYVAL AS GFile PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS gboolean, BYVAL AS GFileCreateFlags, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GFileIOStream PTR
  replace_readwrite_async AS SUB(BYVAL AS GFile PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS gboolean, BYVAL AS GFileCreateFlags, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  replace_readwrite_finish AS FUNCTION(BYVAL AS GFile PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GFileIOStream PTR
  start_mountable AS SUB(BYVAL AS GFile PTR, BYVAL AS GDriveStartFlags, BYVAL AS GMountOperation PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  start_mountable_finish AS FUNCTION(BYVAL AS GFile PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
  stop_mountable AS SUB(BYVAL AS GFile PTR, BYVAL AS GMountUnmountFlags, BYVAL AS GMountOperation PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  stop_mountable_finish AS FUNCTION(BYVAL AS GFile PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
  AS gboolean supports_thread_contexts
  unmount_mountable_with_operation AS SUB(BYVAL AS GFile PTR, BYVAL AS GMountUnmountFlags, BYVAL AS GMountOperation PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  unmount_mountable_with_operation_finish AS FUNCTION(BYVAL AS GFile PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
  eject_mountable_with_operation AS SUB(BYVAL AS GFile PTR, BYVAL AS GMountUnmountFlags, BYVAL AS GMountOperation PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  eject_mountable_with_operation_finish AS FUNCTION(BYVAL AS GFile PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
  poll_mountable AS SUB(BYVAL AS GFile PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  poll_mountable_finish AS FUNCTION(BYVAL AS GFile PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
END TYPE

DECLARE FUNCTION g_file_get_type() AS GType
DECLARE FUNCTION g_file_new_for_path(BYVAL AS CONST ZSTRING PTR) AS GFile PTR
DECLARE FUNCTION g_file_new_for_uri(BYVAL AS CONST ZSTRING PTR) AS GFile PTR
DECLARE FUNCTION g_file_new_for_commandline_arg(BYVAL AS CONST ZSTRING PTR) AS GFile PTR
DECLARE FUNCTION g_file_new_tmp(BYVAL AS CONST ZSTRING PTR, BYVAL AS GFileIOStream PTR PTR, BYVAL AS GError PTR PTR) AS GFile PTR
DECLARE FUNCTION g_file_parse_name(BYVAL AS CONST ZSTRING PTR) AS GFile PTR
DECLARE FUNCTION g_file_dup(BYVAL AS GFile PTR) AS GFile PTR
DECLARE FUNCTION g_file_hash(BYVAL AS gconstpointer) AS guint
DECLARE FUNCTION g_file_equal(BYVAL AS GFile PTR, BYVAL AS GFile PTR) AS gboolean
DECLARE FUNCTION g_file_get_basename(BYVAL AS GFile PTR) AS ZSTRING PTR
DECLARE FUNCTION g_file_get_path(BYVAL AS GFile PTR) AS ZSTRING PTR
DECLARE FUNCTION g_file_get_uri(BYVAL AS GFile PTR) AS ZSTRING PTR
DECLARE FUNCTION g_file_get_parse_name(BYVAL AS GFile PTR) AS ZSTRING PTR
DECLARE FUNCTION g_file_get_parent(BYVAL AS GFile PTR) AS GFile PTR
DECLARE FUNCTION g_file_has_parent(BYVAL AS GFile PTR, BYVAL AS GFile PTR) AS gboolean
DECLARE FUNCTION g_file_get_child(BYVAL AS GFile PTR, BYVAL AS CONST ZSTRING PTR) AS GFile PTR
DECLARE FUNCTION g_file_get_child_for_display_name(BYVAL AS GFile PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS GError PTR PTR) AS GFile PTR
DECLARE FUNCTION g_file_has_prefix(BYVAL AS GFile PTR, BYVAL AS GFile PTR) AS gboolean
DECLARE FUNCTION g_file_get_relative_path(BYVAL AS GFile PTR, BYVAL AS GFile PTR) AS ZSTRING PTR
DECLARE FUNCTION g_file_resolve_relative_path(BYVAL AS GFile PTR, BYVAL AS CONST ZSTRING PTR) AS GFile PTR
DECLARE FUNCTION g_file_is_native(BYVAL AS GFile PTR) AS gboolean
DECLARE FUNCTION g_file_has_uri_scheme(BYVAL AS GFile PTR, BYVAL AS CONST ZSTRING PTR) AS gboolean
DECLARE FUNCTION g_file_get_uri_scheme(BYVAL AS GFile PTR) AS ZSTRING PTR
DECLARE FUNCTION g_file_read(BYVAL AS GFile PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GFileInputStream PTR
DECLARE SUB g_file_read_async(BYVAL AS GFile PTR, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_file_read_finish(BYVAL AS GFile PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GFileInputStream PTR
DECLARE FUNCTION g_file_append_to(BYVAL AS GFile PTR, BYVAL AS GFileCreateFlags, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GFileOutputStream PTR
DECLARE FUNCTION g_file_create(BYVAL AS GFile PTR, BYVAL AS GFileCreateFlags, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GFileOutputStream PTR
DECLARE FUNCTION g_file_replace(BYVAL AS GFile PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS gboolean, BYVAL AS GFileCreateFlags, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GFileOutputStream PTR
DECLARE SUB g_file_append_to_async(BYVAL AS GFile PTR, BYVAL AS GFileCreateFlags, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_file_append_to_finish(BYVAL AS GFile PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GFileOutputStream PTR
DECLARE SUB g_file_create_async(BYVAL AS GFile PTR, BYVAL AS GFileCreateFlags, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_file_create_finish(BYVAL AS GFile PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GFileOutputStream PTR
DECLARE SUB g_file_replace_async(BYVAL AS GFile PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS gboolean, BYVAL AS GFileCreateFlags, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_file_replace_finish(BYVAL AS GFile PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GFileOutputStream PTR
DECLARE FUNCTION g_file_open_readwrite(BYVAL AS GFile PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GFileIOStream PTR
DECLARE SUB g_file_open_readwrite_async(BYVAL AS GFile PTR, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_file_open_readwrite_finish(BYVAL AS GFile PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GFileIOStream PTR
DECLARE FUNCTION g_file_create_readwrite(BYVAL AS GFile PTR, BYVAL AS GFileCreateFlags, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GFileIOStream PTR
DECLARE SUB g_file_create_readwrite_async(BYVAL AS GFile PTR, BYVAL AS GFileCreateFlags, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_file_create_readwrite_finish(BYVAL AS GFile PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GFileIOStream PTR
DECLARE FUNCTION g_file_replace_readwrite(BYVAL AS GFile PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS gboolean, BYVAL AS GFileCreateFlags, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GFileIOStream PTR
DECLARE SUB g_file_replace_readwrite_async(BYVAL AS GFile PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS gboolean, BYVAL AS GFileCreateFlags, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_file_replace_readwrite_finish(BYVAL AS GFile PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GFileIOStream PTR
DECLARE FUNCTION g_file_query_exists(BYVAL AS GFile PTR, BYVAL AS GCancellable PTR) AS gboolean
DECLARE FUNCTION g_file_query_file_type(BYVAL AS GFile PTR, BYVAL AS GFileQueryInfoFlags, BYVAL AS GCancellable PTR) AS GFileType
DECLARE FUNCTION g_file_query_info(BYVAL AS GFile PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS GFileQueryInfoFlags, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GFileInfo PTR
DECLARE SUB g_file_query_info_async(BYVAL AS GFile PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS GFileQueryInfoFlags, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_file_query_info_finish(BYVAL AS GFile PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GFileInfo PTR
DECLARE FUNCTION g_file_query_filesystem_info(BYVAL AS GFile PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GFileInfo PTR
DECLARE SUB g_file_query_filesystem_info_async(BYVAL AS GFile PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_file_query_filesystem_info_finish(BYVAL AS GFile PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GFileInfo PTR
DECLARE FUNCTION g_file_find_enclosing_mount(BYVAL AS GFile PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GMount PTR
DECLARE SUB g_file_find_enclosing_mount_async(BYVAL AS GFile PTR, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_file_find_enclosing_mount_finish(BYVAL AS GFile PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GMount PTR
DECLARE FUNCTION g_file_enumerate_children(BYVAL AS GFile PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS GFileQueryInfoFlags, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GFileEnumerator PTR
DECLARE SUB g_file_enumerate_children_async(BYVAL AS GFile PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS GFileQueryInfoFlags, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_file_enumerate_children_finish(BYVAL AS GFile PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GFileEnumerator PTR
DECLARE FUNCTION g_file_set_display_name(BYVAL AS GFile PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GFile PTR
DECLARE SUB g_file_set_display_name_async(BYVAL AS GFile PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_file_set_display_name_finish(BYVAL AS GFile PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GFile PTR
DECLARE FUNCTION g_file_delete(BYVAL AS GFile PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_file_trash(BYVAL AS GFile PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_file_copy(BYVAL AS GFile PTR, BYVAL AS GFile PTR, BYVAL AS GFileCopyFlags, BYVAL AS GCancellable PTR, BYVAL AS GFileProgressCallback, BYVAL AS gpointer, BYVAL AS GError PTR PTR) AS gboolean
DECLARE SUB g_file_copy_async(BYVAL AS GFile PTR, BYVAL AS GFile PTR, BYVAL AS GFileCopyFlags, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GFileProgressCallback, BYVAL AS gpointer, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_file_copy_finish(BYVAL AS GFile PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_file_move(BYVAL AS GFile PTR, BYVAL AS GFile PTR, BYVAL AS GFileCopyFlags, BYVAL AS GCancellable PTR, BYVAL AS GFileProgressCallback, BYVAL AS gpointer, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_file_make_directory(BYVAL AS GFile PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_file_make_directory_with_parents(BYVAL AS GFile PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_file_make_symbolic_link(BYVAL AS GFile PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_file_query_settable_attributes(BYVAL AS GFile PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GFileAttributeInfoList PTR
DECLARE FUNCTION g_file_query_writable_namespaces(BYVAL AS GFile PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GFileAttributeInfoList PTR
DECLARE FUNCTION g_file_set_attribute(BYVAL AS GFile PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS GFileAttributeType, BYVAL AS gpointer, BYVAL AS GFileQueryInfoFlags, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_file_set_attributes_from_info(BYVAL AS GFile PTR, BYVAL AS GFileInfo PTR, BYVAL AS GFileQueryInfoFlags, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE SUB g_file_set_attributes_async(BYVAL AS GFile PTR, BYVAL AS GFileInfo PTR, BYVAL AS GFileQueryInfoFlags, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_file_set_attributes_finish(BYVAL AS GFile PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GFileInfo PTR PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_file_set_attribute_string(BYVAL AS GFile PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS GFileQueryInfoFlags, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_file_set_attribute_byte_string(BYVAL AS GFile PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS GFileQueryInfoFlags, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_file_set_attribute_uint32(BYVAL AS GFile PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS guint32, BYVAL AS GFileQueryInfoFlags, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_file_set_attribute_int32(BYVAL AS GFile PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS gint32, BYVAL AS GFileQueryInfoFlags, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_file_set_attribute_uint64(BYVAL AS GFile PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS guint64, BYVAL AS GFileQueryInfoFlags, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_file_set_attribute_int64(BYVAL AS GFile PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS gint64, BYVAL AS GFileQueryInfoFlags, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE SUB g_file_mount_enclosing_volume(BYVAL AS GFile PTR, BYVAL AS GMountMountFlags, BYVAL AS GMountOperation PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_file_mount_enclosing_volume_finish(BYVAL AS GFile PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE SUB g_file_mount_mountable(BYVAL AS GFile PTR, BYVAL AS GMountMountFlags, BYVAL AS GMountOperation PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_file_mount_mountable_finish(BYVAL AS GFile PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GFile PTR
DECLARE SUB g_file_unmount_mountable(BYVAL AS GFile PTR, BYVAL AS GMountUnmountFlags, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_file_unmount_mountable_finish(BYVAL AS GFile PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE SUB g_file_unmount_mountable_with_operation(BYVAL AS GFile PTR, BYVAL AS GMountUnmountFlags, BYVAL AS GMountOperation PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_file_unmount_mountable_with_operation_finish(BYVAL AS GFile PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE SUB g_file_eject_mountable(BYVAL AS GFile PTR, BYVAL AS GMountUnmountFlags, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_file_eject_mountable_finish(BYVAL AS GFile PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE SUB g_file_eject_mountable_with_operation(BYVAL AS GFile PTR, BYVAL AS GMountUnmountFlags, BYVAL AS GMountOperation PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_file_eject_mountable_with_operation_finish(BYVAL AS GFile PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_file_copy_attributes(BYVAL AS GFile PTR, BYVAL AS GFile PTR, BYVAL AS GFileCopyFlags, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_file_monitor_directory(BYVAL AS GFile PTR, BYVAL AS GFileMonitorFlags, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GFileMonitor PTR
DECLARE FUNCTION g_file_monitor_file(BYVAL AS GFile PTR, BYVAL AS GFileMonitorFlags, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GFileMonitor PTR
DECLARE FUNCTION g_file_monitor_ ALIAS "g_file_monitor"(BYVAL AS GFile PTR, BYVAL AS GFileMonitorFlags, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GFileMonitor PTR
DECLARE SUB g_file_start_mountable(BYVAL AS GFile PTR, BYVAL AS GDriveStartFlags, BYVAL AS GMountOperation PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_file_start_mountable_finish(BYVAL AS GFile PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE SUB g_file_stop_mountable(BYVAL AS GFile PTR, BYVAL AS GMountUnmountFlags, BYVAL AS GMountOperation PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_file_stop_mountable_finish(BYVAL AS GFile PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE SUB g_file_poll_mountable(BYVAL AS GFile PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_file_poll_mountable_finish(BYVAL AS GFile PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_file_query_default_handler(BYVAL AS GFile PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GAppInfo PTR
DECLARE FUNCTION g_file_load_contents(BYVAL AS GFile PTR, BYVAL AS GCancellable PTR, BYVAL AS ZSTRING PTR PTR, BYVAL AS gsize PTR, BYVAL AS ZSTRING PTR PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE SUB g_file_load_contents_async(BYVAL AS GFile PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_file_load_contents_finish(BYVAL AS GFile PTR, BYVAL AS GAsyncResult PTR, BYVAL AS ZSTRING PTR PTR, BYVAL AS gsize PTR, BYVAL AS ZSTRING PTR PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE SUB g_file_load_partial_contents_async(BYVAL AS GFile PTR, BYVAL AS GCancellable PTR, BYVAL AS GFileReadMoreCallback, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_file_load_partial_contents_finish(BYVAL AS GFile PTR, BYVAL AS GAsyncResult PTR, BYVAL AS ZSTRING PTR PTR, BYVAL AS gsize PTR, BYVAL AS ZSTRING PTR PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_file_replace_contents(BYVAL AS GFile PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS gsize, BYVAL AS CONST ZSTRING PTR, BYVAL AS gboolean, BYVAL AS GFileCreateFlags, BYVAL AS ZSTRING PTR PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE SUB g_file_replace_contents_async(BYVAL AS GFile PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS gsize, BYVAL AS CONST ZSTRING PTR, BYVAL AS gboolean, BYVAL AS GFileCreateFlags, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_file_replace_contents_finish(BYVAL AS GFile PTR, BYVAL AS GAsyncResult PTR, BYVAL AS ZSTRING PTR PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_file_supports_thread_contexts(BYVAL AS GFile PTR) AS gboolean

#ENDIF ' __G_FILE_H__

#IFNDEF __G_FILE_ICON_H__
#DEFINE __G_FILE_ICON_H__

#DEFINE G_TYPE_FILE_ICON (g_file_icon_get_type ())
#DEFINE G_FILE_ICON(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_FILE_ICON, GFileIcon))
#DEFINE G_FILE_ICON_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_FILE_ICON, GFileIconClass))
#DEFINE G_IS_FILE_ICON(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_FILE_ICON))
#DEFINE G_IS_FILE_ICON_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), G_TYPE_FILE_ICON))
#DEFINE G_FILE_ICON_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), G_TYPE_FILE_ICON, GFileIconClass))

TYPE GFileIconClass AS _GFileIconClass

DECLARE FUNCTION g_file_icon_get_type() AS GType
DECLARE FUNCTION g_file_icon_new(BYVAL AS GFile PTR) AS GIcon PTR
DECLARE FUNCTION g_file_icon_get_file(BYVAL AS GFileIcon PTR) AS GFile PTR

#ENDIF ' __G_FILE_ICON_H__

#IFNDEF __G_FILE_INFO_H__
#DEFINE __G_FILE_INFO_H__

#DEFINE G_TYPE_FILE_INFO (g_file_info_get_type ())
#DEFINE G_FILE_INFO(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_FILE_INFO, GFileInfo))
#DEFINE G_FILE_INFO_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_FILE_INFO, GFileInfoClass))
#DEFINE G_IS_FILE_INFO(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_FILE_INFO))
#DEFINE G_IS_FILE_INFO_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), G_TYPE_FILE_INFO))
#DEFINE G_FILE_INFO_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), G_TYPE_FILE_INFO, GFileInfoClass))

TYPE GFileInfoClass AS _GFileInfoClass

#DEFINE G_FILE_ATTRIBUTE_STANDARD_TYPE !"standard::type"
#DEFINE G_FILE_ATTRIBUTE_STANDARD_IS_HIDDEN !"standard::is-hidden"
#DEFINE G_FILE_ATTRIBUTE_STANDARD_IS_BACKUP !"standard::is-backup"
#DEFINE G_FILE_ATTRIBUTE_STANDARD_IS_SYMLINK !"standard::is-symlink"
#DEFINE G_FILE_ATTRIBUTE_STANDARD_IS_VIRTUAL !"standard::is-virtual"
#DEFINE G_FILE_ATTRIBUTE_STANDARD_NAME !"standard::name"
#DEFINE G_FILE_ATTRIBUTE_STANDARD_DISPLAY_NAME !"standard::display-name"
#DEFINE G_FILE_ATTRIBUTE_STANDARD_EDIT_NAME !"standard::edit-name"
#DEFINE G_FILE_ATTRIBUTE_STANDARD_COPY_NAME !"standard::copy-name"
#DEFINE G_FILE_ATTRIBUTE_STANDARD_DESCRIPTION !"standard::description"
#DEFINE G_FILE_ATTRIBUTE_STANDARD_ICON !"standard::icon"
#DEFINE G_FILE_ATTRIBUTE_STANDARD_CONTENT_TYPE !"standard::content-type"
#DEFINE G_FILE_ATTRIBUTE_STANDARD_FAST_CONTENT_TYPE !"standard::fast-content-type"
#DEFINE G_FILE_ATTRIBUTE_STANDARD_SIZE !"standard::size"
#DEFINE G_FILE_ATTRIBUTE_STANDARD_ALLOCATED_SIZE !"standard::allocated-size"
#DEFINE G_FILE_ATTRIBUTE_STANDARD_SYMLINK_TARGET !"standard::symlink-target"
#DEFINE G_FILE_ATTRIBUTE_STANDARD_TARGET_URI !"standard::target-uri"
#DEFINE G_FILE_ATTRIBUTE_STANDARD_SORT_ORDER !"standard::sort-order"
#DEFINE G_FILE_ATTRIBUTE_ETAG_VALUE !"etag::value"
#DEFINE G_FILE_ATTRIBUTE_ID_FILE !"id::file"
#DEFINE G_FILE_ATTRIBUTE_ID_FILESYSTEM !"id::filesystem"
#DEFINE G_FILE_ATTRIBUTE_ACCESS_CAN_READ !"access::can-read"
#DEFINE G_FILE_ATTRIBUTE_ACCESS_CAN_WRITE !"access::can-write"
#DEFINE G_FILE_ATTRIBUTE_ACCESS_CAN_EXECUTE !"access::can-execute"
#DEFINE G_FILE_ATTRIBUTE_ACCESS_CAN_DELETE !"access::can-delete"
#DEFINE G_FILE_ATTRIBUTE_ACCESS_CAN_TRASH !"access::can-trash"
#DEFINE G_FILE_ATTRIBUTE_ACCESS_CAN_RENAME !"access::can-rename"
#DEFINE G_FILE_ATTRIBUTE_MOUNTABLE_CAN_MOUNT !"mountable::can-mount"
#DEFINE G_FILE_ATTRIBUTE_MOUNTABLE_CAN_UNMOUNT !"mountable::can-unmount"
#DEFINE G_FILE_ATTRIBUTE_MOUNTABLE_CAN_EJECT !"mountable::can-eject"
#DEFINE G_FILE_ATTRIBUTE_MOUNTABLE_UNIX_DEVICE !"mountable::unix-device"
#DEFINE G_FILE_ATTRIBUTE_MOUNTABLE_UNIX_DEVICE_FILE !"mountable::unix-device-file"
#DEFINE G_FILE_ATTRIBUTE_MOUNTABLE_HAL_UDI !"mountable::hal-udi"
#DEFINE G_FILE_ATTRIBUTE_MOUNTABLE_CAN_START !"mountable::can-start"
#DEFINE G_FILE_ATTRIBUTE_MOUNTABLE_CAN_START_DEGRADED !"mountable::can-start-degraded"
#DEFINE G_FILE_ATTRIBUTE_MOUNTABLE_CAN_STOP !"mountable::can-stop"
#DEFINE G_FILE_ATTRIBUTE_MOUNTABLE_START_STOP_TYPE !"mountable::start-stop-type"
#DEFINE G_FILE_ATTRIBUTE_MOUNTABLE_CAN_POLL !"mountable::can-poll"
#DEFINE G_FILE_ATTRIBUTE_MOUNTABLE_IS_MEDIA_CHECK_AUTOMATIC !"mountable::is-media-check-automatic"
#DEFINE G_FILE_ATTRIBUTE_TIME_MODIFIED !"time::modified"
#DEFINE G_FILE_ATTRIBUTE_TIME_MODIFIED_USEC !"time::modified-usec"
#DEFINE G_FILE_ATTRIBUTE_TIME_ACCESS !"time::access"
#DEFINE G_FILE_ATTRIBUTE_TIME_ACCESS_USEC !"time::access-usec"
#DEFINE G_FILE_ATTRIBUTE_TIME_CHANGED !"time::changed"
#DEFINE G_FILE_ATTRIBUTE_TIME_CHANGED_USEC !"time::changed-usec"
#DEFINE G_FILE_ATTRIBUTE_TIME_CREATED !"time::created"
#DEFINE G_FILE_ATTRIBUTE_TIME_CREATED_USEC !"time::created-usec"
#DEFINE G_FILE_ATTRIBUTE_UNIX_DEVICE !"unix::device"
#DEFINE G_FILE_ATTRIBUTE_UNIX_INODE !"unix::inode"
#DEFINE G_FILE_ATTRIBUTE_UNIX_MODE !"unix::mode"
#DEFINE G_FILE_ATTRIBUTE_UNIX_NLINK !"unix::nlink"
#DEFINE G_FILE_ATTRIBUTE_UNIX_UID !"unix::uid"
#DEFINE G_FILE_ATTRIBUTE_UNIX_GID !"unix::gid"
#DEFINE G_FILE_ATTRIBUTE_UNIX_RDEV !"unix::rdev"
#DEFINE G_FILE_ATTRIBUTE_UNIX_BLOCK_SIZE !"unix::block-size"
#DEFINE G_FILE_ATTRIBUTE_UNIX_BLOCKS !"unix::blocks"
#DEFINE G_FILE_ATTRIBUTE_UNIX_IS_MOUNTPOINT !"unix::is-mountpoint"
#DEFINE G_FILE_ATTRIBUTE_DOS_IS_ARCHIVE !"dos::is-archive"
#DEFINE G_FILE_ATTRIBUTE_DOS_IS_SYSTEM !"dos::is-system"
#DEFINE G_FILE_ATTRIBUTE_OWNER_USER !"owner::user"
#DEFINE G_FILE_ATTRIBUTE_OWNER_USER_REAL !"owner::user-real"
#DEFINE G_FILE_ATTRIBUTE_OWNER_GROUP !"owner::group"
#DEFINE G_FILE_ATTRIBUTE_THUMBNAIL_PATH !"thumbnail::path"
#DEFINE G_FILE_ATTRIBUTE_THUMBNAILING_FAILED !"thumbnail::failed"
#DEFINE G_FILE_ATTRIBUTE_PREVIEW_ICON !"preview::icon"
#DEFINE G_FILE_ATTRIBUTE_FILESYSTEM_SIZE !"filesystem::size"
#DEFINE G_FILE_ATTRIBUTE_FILESYSTEM_FREE !"filesystem::free"
#DEFINE G_FILE_ATTRIBUTE_FILESYSTEM_TYPE !"filesystem::type"
#DEFINE G_FILE_ATTRIBUTE_FILESYSTEM_READONLY !"filesystem::readonly"
#DEFINE G_FILE_ATTRIBUTE_FILESYSTEM_USE_PREVIEW !"filesystem::use-preview"
#DEFINE G_FILE_ATTRIBUTE_GVFS_BACKEND !"gvfs::backend"
#DEFINE G_FILE_ATTRIBUTE_SELINUX_CONTEXT !"selinux::context"
#DEFINE G_FILE_ATTRIBUTE_TRASH_ITEM_COUNT !"trash::item-count"
#DEFINE G_FILE_ATTRIBUTE_TRASH_ORIG_PATH !"trash::orig-path"
#DEFINE G_FILE_ATTRIBUTE_TRASH_DELETION_DATE !"trash::deletion-date"

DECLARE FUNCTION g_file_info_get_type() AS GType
DECLARE FUNCTION g_file_info_new() AS GFileInfo PTR
DECLARE FUNCTION g_file_info_dup(BYVAL AS GFileInfo PTR) AS GFileInfo PTR
DECLARE SUB g_file_info_copy_into(BYVAL AS GFileInfo PTR, BYVAL AS GFileInfo PTR)
DECLARE FUNCTION g_file_info_has_attribute(BYVAL AS GFileInfo PTR, BYVAL AS CONST ZSTRING PTR) AS gboolean
DECLARE FUNCTION g_file_info_has_namespace(BYVAL AS GFileInfo PTR, BYVAL AS CONST ZSTRING PTR) AS gboolean
DECLARE FUNCTION g_file_info_list_attributes(BYVAL AS GFileInfo PTR, BYVAL AS CONST ZSTRING PTR) AS ZSTRING PTR PTR
DECLARE FUNCTION g_file_info_get_attribute_data(BYVAL AS GFileInfo PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS GFileAttributeType PTR, BYVAL AS gpointer PTR, BYVAL AS GFileAttributeStatus PTR) AS gboolean
DECLARE FUNCTION g_file_info_get_attribute_type(BYVAL AS GFileInfo PTR, BYVAL AS CONST ZSTRING PTR) AS GFileAttributeType
DECLARE SUB g_file_info_remove_attribute(BYVAL AS GFileInfo PTR, BYVAL AS CONST ZSTRING PTR)
DECLARE FUNCTION g_file_info_get_attribute_status(BYVAL AS GFileInfo PTR, BYVAL AS CONST ZSTRING PTR) AS GFileAttributeStatus
DECLARE FUNCTION g_file_info_set_attribute_status(BYVAL AS GFileInfo PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS GFileAttributeStatus) AS gboolean
DECLARE FUNCTION g_file_info_get_attribute_as_string(BYVAL AS GFileInfo PTR, BYVAL AS CONST ZSTRING PTR) AS ZSTRING PTR
DECLARE FUNCTION g_file_info_get_attribute_string(BYVAL AS GFileInfo PTR, BYVAL AS CONST ZSTRING PTR) AS CONST ZSTRING PTR
DECLARE FUNCTION g_file_info_get_attribute_byte_string(BYVAL AS GFileInfo PTR, BYVAL AS CONST ZSTRING PTR) AS CONST ZSTRING PTR
DECLARE FUNCTION g_file_info_get_attribute_boolean(BYVAL AS GFileInfo PTR, BYVAL AS CONST ZSTRING PTR) AS gboolean
DECLARE FUNCTION g_file_info_get_attribute_uint32(BYVAL AS GFileInfo PTR, BYVAL AS CONST ZSTRING PTR) AS guint32
DECLARE FUNCTION g_file_info_get_attribute_int32(BYVAL AS GFileInfo PTR, BYVAL AS CONST ZSTRING PTR) AS gint32
DECLARE FUNCTION g_file_info_get_attribute_uint64(BYVAL AS GFileInfo PTR, BYVAL AS CONST ZSTRING PTR) AS guint64
DECLARE FUNCTION g_file_info_get_attribute_int64(BYVAL AS GFileInfo PTR, BYVAL AS CONST ZSTRING PTR) AS gint64
DECLARE FUNCTION g_file_info_get_attribute_object(BYVAL AS GFileInfo PTR, BYVAL AS CONST ZSTRING PTR) AS GObject PTR
DECLARE FUNCTION g_file_info_get_attribute_stringv(BYVAL AS GFileInfo PTR, BYVAL AS CONST ZSTRING PTR) AS ZSTRING PTR PTR
DECLARE SUB g_file_info_set_attribute(BYVAL AS GFileInfo PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS GFileAttributeType, BYVAL AS gpointer)
DECLARE SUB g_file_info_set_attribute_string(BYVAL AS GFileInfo PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST ZSTRING PTR)
DECLARE SUB g_file_info_set_attribute_byte_string(BYVAL AS GFileInfo PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST ZSTRING PTR)
DECLARE SUB g_file_info_set_attribute_boolean(BYVAL AS GFileInfo PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS gboolean)
DECLARE SUB g_file_info_set_attribute_uint32(BYVAL AS GFileInfo PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS guint32)
DECLARE SUB g_file_info_set_attribute_int32(BYVAL AS GFileInfo PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS gint32)
DECLARE SUB g_file_info_set_attribute_uint64(BYVAL AS GFileInfo PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS guint64)
DECLARE SUB g_file_info_set_attribute_int64(BYVAL AS GFileInfo PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS gint64)
DECLARE SUB g_file_info_set_attribute_object(BYVAL AS GFileInfo PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS GObject PTR)
DECLARE SUB g_file_info_set_attribute_stringv(BYVAL AS GFileInfo PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS ZSTRING PTR PTR)
DECLARE SUB g_file_info_clear_status(BYVAL AS GFileInfo PTR)
DECLARE FUNCTION g_file_info_get_file_type(BYVAL AS GFileInfo PTR) AS GFileType
DECLARE FUNCTION g_file_info_get_is_hidden(BYVAL AS GFileInfo PTR) AS gboolean
DECLARE FUNCTION g_file_info_get_is_backup(BYVAL AS GFileInfo PTR) AS gboolean
DECLARE FUNCTION g_file_info_get_is_symlink(BYVAL AS GFileInfo PTR) AS gboolean
DECLARE FUNCTION g_file_info_get_name(BYVAL AS GFileInfo PTR) AS CONST ZSTRING PTR
DECLARE FUNCTION g_file_info_get_display_name(BYVAL AS GFileInfo PTR) AS CONST ZSTRING PTR
DECLARE FUNCTION g_file_info_get_edit_name(BYVAL AS GFileInfo PTR) AS CONST ZSTRING PTR
DECLARE FUNCTION g_file_info_get_icon(BYVAL AS GFileInfo PTR) AS GIcon PTR
DECLARE FUNCTION g_file_info_get_content_type(BYVAL AS GFileInfo PTR) AS CONST ZSTRING PTR
DECLARE FUNCTION g_file_info_get_size(BYVAL AS GFileInfo PTR) AS goffset
DECLARE SUB g_file_info_get_modification_time(BYVAL AS GFileInfo PTR, BYVAL AS GTimeVal PTR)
DECLARE FUNCTION g_file_info_get_symlink_target(BYVAL AS GFileInfo PTR) AS CONST ZSTRING PTR
DECLARE FUNCTION g_file_info_get_etag(BYVAL AS GFileInfo PTR) AS CONST ZSTRING PTR
DECLARE FUNCTION g_file_info_get_sort_order(BYVAL AS GFileInfo PTR) AS gint32
DECLARE SUB g_file_info_set_attribute_mask(BYVAL AS GFileInfo PTR, BYVAL AS GFileAttributeMatcher PTR)
DECLARE SUB g_file_info_unset_attribute_mask(BYVAL AS GFileInfo PTR)
DECLARE SUB g_file_info_set_file_type(BYVAL AS GFileInfo PTR, BYVAL AS GFileType)
DECLARE SUB g_file_info_set_is_hidden(BYVAL AS GFileInfo PTR, BYVAL AS gboolean)
DECLARE SUB g_file_info_set_is_symlink(BYVAL AS GFileInfo PTR, BYVAL AS gboolean)
DECLARE SUB g_file_info_set_name(BYVAL AS GFileInfo PTR, BYVAL AS CONST ZSTRING PTR)
DECLARE SUB g_file_info_set_display_name(BYVAL AS GFileInfo PTR, BYVAL AS CONST ZSTRING PTR)
DECLARE SUB g_file_info_set_edit_name(BYVAL AS GFileInfo PTR, BYVAL AS CONST ZSTRING PTR)
DECLARE SUB g_file_info_set_icon(BYVAL AS GFileInfo PTR, BYVAL AS GIcon PTR)
DECLARE SUB g_file_info_set_content_type(BYVAL AS GFileInfo PTR, BYVAL AS CONST ZSTRING PTR)
DECLARE SUB g_file_info_set_size(BYVAL AS GFileInfo PTR, BYVAL AS goffset)
DECLARE SUB g_file_info_set_modification_time(BYVAL AS GFileInfo PTR, BYVAL AS GTimeVal PTR)
DECLARE SUB g_file_info_set_symlink_target(BYVAL AS GFileInfo PTR, BYVAL AS CONST ZSTRING PTR)
DECLARE SUB g_file_info_set_sort_order(BYVAL AS GFileInfo PTR, BYVAL AS gint32)
DECLARE FUNCTION g_file_attribute_matcher_get_type() AS GType
DECLARE FUNCTION g_file_attribute_matcher_new(BYVAL AS CONST ZSTRING PTR) AS GFileAttributeMatcher PTR
DECLARE FUNCTION g_file_attribute_matcher_ref(BYVAL AS GFileAttributeMatcher PTR) AS GFileAttributeMatcher PTR
DECLARE SUB g_file_attribute_matcher_unref(BYVAL AS GFileAttributeMatcher PTR)
DECLARE FUNCTION g_file_attribute_matcher_subtract(BYVAL AS GFileAttributeMatcher PTR, BYVAL AS GFileAttributeMatcher PTR) AS GFileAttributeMatcher PTR
DECLARE FUNCTION g_file_attribute_matcher_matches(BYVAL AS GFileAttributeMatcher PTR, BYVAL AS CONST ZSTRING PTR) AS gboolean
DECLARE FUNCTION g_file_attribute_matcher_matches_only(BYVAL AS GFileAttributeMatcher PTR, BYVAL AS CONST ZSTRING PTR) AS gboolean
DECLARE FUNCTION g_file_attribute_matcher_enumerate_namespace(BYVAL AS GFileAttributeMatcher PTR, BYVAL AS CONST ZSTRING PTR) AS gboolean
DECLARE FUNCTION g_file_attribute_matcher_enumerate_next(BYVAL AS GFileAttributeMatcher PTR) AS CONST ZSTRING PTR
DECLARE FUNCTION g_file_attribute_matcher_to_string(BYVAL AS GFileAttributeMatcher PTR) AS ZSTRING PTR

#ENDIF ' __G_FILE_INFO_H__

#IFNDEF __G_FILE_INPUT_STREAM_H__
#DEFINE __G_FILE_INPUT_STREAM_H__

#DEFINE G_TYPE_FILE_INPUT_STREAM (g_file_input_stream_get_type ())
#DEFINE G_FILE_INPUT_STREAM(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_FILE_INPUT_STREAM, GFileInputStream))
#DEFINE G_FILE_INPUT_STREAM_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_FILE_INPUT_STREAM, GFileInputStreamClass))
#DEFINE G_IS_FILE_INPUT_STREAM(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_FILE_INPUT_STREAM))
#DEFINE G_IS_FILE_INPUT_STREAM_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), G_TYPE_FILE_INPUT_STREAM))
#DEFINE G_FILE_INPUT_STREAM_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), G_TYPE_FILE_INPUT_STREAM, GFileInputStreamClass))

TYPE GFileInputStreamClass AS _GFileInputStreamClass
TYPE GFileInputStreamPrivate AS _GFileInputStreamPrivate

TYPE _GFileInputStream
  AS GInputStream parent_instance
  AS GFileInputStreamPrivate PTR priv
END TYPE

TYPE _GFileInputStreamClass
  AS GInputStreamClass parent_class
  tell AS FUNCTION(BYVAL AS GFileInputStream PTR) AS goffset
  can_seek AS FUNCTION(BYVAL AS GFileInputStream PTR) AS gboolean
  seek_ AS FUNCTION(BYVAL AS GFileInputStream PTR, BYVAL AS goffset, BYVAL AS GSeekType, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
  query_info AS FUNCTION(BYVAL AS GFileInputStream PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GFileInfo PTR
  query_info_async AS SUB(BYVAL AS GFileInputStream PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  query_info_finish AS FUNCTION(BYVAL AS GFileInputStream PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GFileInfo PTR
  _g_reserved1 AS SUB()
  _g_reserved2 AS SUB()
  _g_reserved3 AS SUB()
  _g_reserved4 AS SUB()
  _g_reserved5 AS SUB()
END TYPE

DECLARE FUNCTION g_file_input_stream_get_type() AS GType
DECLARE FUNCTION g_file_input_stream_query_info(BYVAL AS GFileInputStream PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GFileInfo PTR
DECLARE SUB g_file_input_stream_query_info_async(BYVAL AS GFileInputStream PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_file_input_stream_query_info_finish(BYVAL AS GFileInputStream PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GFileInfo PTR

#ENDIF ' __G_FILE_INPUT_STREAM_H__

#IFNDEF __G_FILE_IO_STREAM_H__
#DEFINE __G_FILE_IO_STREAM_H__

#IFNDEF __G_IO_STREAM_H__
#DEFINE __G_IO_STREAM_H__

#IFNDEF __G_IO_ERROR_H__
#DEFINE __G_IO_ERROR_H__
#INCLUDE ONCE "glib.bi"

#DEFINE G_IO_ERROR g_io_error_quark()

DECLARE FUNCTION g_io_error_quark() AS GQuark
DECLARE FUNCTION g_io_error_from_errno(BYVAL AS gint) AS GIOErrorEnum

#IFDEF G_OS_WIN32

DECLARE FUNCTION g_io_error_from_win32_error(BYVAL AS gint) AS GIOErrorEnum

#ENDIF ' G_OS_WIN32
#ENDIF ' __G_IO_ERROR_H__

#DEFINE G_TYPE_IO_STREAM (g_io_stream_get_type ())
#DEFINE G_IO_STREAM(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_IO_STREAM, GIOStream))
#DEFINE G_IO_STREAM_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_IO_STREAM, GIOStreamClass))
#DEFINE G_IS_IO_STREAM(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_IO_STREAM))
#DEFINE G_IS_IO_STREAM_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), G_TYPE_IO_STREAM))
#DEFINE G_IO_STREAM_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), G_TYPE_IO_STREAM, GIOStreamClass))

TYPE GIOStreamPrivate AS _GIOStreamPrivate
TYPE GIOStreamClass AS _GIOStreamClass

TYPE _GIOStream
  AS GObject parent_instance
  AS GIOStreamPrivate PTR priv
END TYPE

TYPE _GIOStreamClass
  AS GObjectClass parent_class
  get_input_stream AS FUNCTION(BYVAL AS GIOStream PTR) AS GInputStream PTR
  get_output_stream AS FUNCTION(BYVAL AS GIOStream PTR) AS GOutputStream PTR
  close_fn AS FUNCTION(BYVAL AS GIOStream PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
  close_async AS SUB(BYVAL AS GIOStream PTR, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  close_finish AS FUNCTION(BYVAL AS GIOStream PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
  _g_reserved1 AS SUB()
  _g_reserved2 AS SUB()
  _g_reserved3 AS SUB()
  _g_reserved4 AS SUB()
  _g_reserved5 AS SUB()
  _g_reserved6 AS SUB()
  _g_reserved7 AS SUB()
  _g_reserved8 AS SUB()
  _g_reserved9 AS SUB()
  _g_reserved10 AS SUB()
END TYPE

DECLARE FUNCTION g_io_stream_get_type() AS GType
DECLARE FUNCTION g_io_stream_get_input_stream(BYVAL AS GIOStream PTR) AS GInputStream PTR
DECLARE FUNCTION g_io_stream_get_output_stream(BYVAL AS GIOStream PTR) AS GOutputStream PTR
DECLARE SUB g_io_stream_splice_async(BYVAL AS GIOStream PTR, BYVAL AS GIOStream PTR, BYVAL AS GIOStreamSpliceFlags, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_io_stream_splice_finish(BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_io_stream_close(BYVAL AS GIOStream PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE SUB g_io_stream_close_async(BYVAL AS GIOStream PTR, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_io_stream_close_finish(BYVAL AS GIOStream PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_io_stream_is_closed(BYVAL AS GIOStream PTR) AS gboolean
DECLARE FUNCTION g_io_stream_has_pending(BYVAL AS GIOStream PTR) AS gboolean
DECLARE FUNCTION g_io_stream_set_pending(BYVAL AS GIOStream PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE SUB g_io_stream_clear_pending(BYVAL AS GIOStream PTR)

#ENDIF ' __G_IO_STREAM_H__

#DEFINE G_TYPE_FILE_IO_STREAM (g_file_io_stream_get_type ())
#DEFINE G_FILE_IO_STREAM(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_FILE_IO_STREAM, GFileIOStream))
#DEFINE G_FILE_IO_STREAM_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_FILE_IO_STREAM, GFileIOStreamClass))
#DEFINE G_IS_FILE_IO_STREAM(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_FILE_IO_STREAM))
#DEFINE G_IS_FILE_IO_STREAM_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), G_TYPE_FILE_IO_STREAM))
#DEFINE G_FILE_IO_STREAM_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), G_TYPE_FILE_IO_STREAM, GFileIOStreamClass))

TYPE GFileIOStreamClass AS _GFileIOStreamClass
TYPE GFileIOStreamPrivate AS _GFileIOStreamPrivate

TYPE _GFileIOStream
  AS GIOStream parent_instance
  AS GFileIOStreamPrivate PTR priv
END TYPE

TYPE _GFileIOStreamClass
  AS GIOStreamClass parent_class
  tell AS FUNCTION(BYVAL AS GFileIOStream PTR) AS goffset
  can_seek AS FUNCTION(BYVAL AS GFileIOStream PTR) AS gboolean
  seek_ AS FUNCTION(BYVAL AS GFileIOStream PTR, BYVAL AS goffset, BYVAL AS GSeekType, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
  can_truncate AS FUNCTION(BYVAL AS GFileIOStream PTR) AS gboolean
  truncate_fn AS FUNCTION(BYVAL AS GFileIOStream PTR, BYVAL AS goffset, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
  query_info AS FUNCTION(BYVAL AS GFileIOStream PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GFileInfo PTR
  query_info_async AS SUB(BYVAL AS GFileIOStream PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  query_info_finish AS FUNCTION(BYVAL AS GFileIOStream PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GFileInfo PTR
  get_etag AS FUNCTION(BYVAL AS GFileIOStream PTR) AS ZSTRING PTR
  _g_reserved1 AS SUB()
  _g_reserved2 AS SUB()
  _g_reserved3 AS SUB()
  _g_reserved4 AS SUB()
  _g_reserved5 AS SUB()
END TYPE

DECLARE FUNCTION g_file_io_stream_get_type() AS GType
DECLARE FUNCTION g_file_io_stream_query_info(BYVAL AS GFileIOStream PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GFileInfo PTR
DECLARE SUB g_file_io_stream_query_info_async(BYVAL AS GFileIOStream PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_file_io_stream_query_info_finish(BYVAL AS GFileIOStream PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GFileInfo PTR
DECLARE FUNCTION g_file_io_stream_get_etag(BYVAL AS GFileIOStream PTR) AS ZSTRING PTR

#ENDIF ' __G_FILE_IO_STREAM_H__

#IFNDEF __G_FILE_MONITOR_H__
#DEFINE __G_FILE_MONITOR_H__

#DEFINE G_TYPE_FILE_MONITOR (g_file_monitor_get_type ())
#DEFINE G_FILE_MONITOR(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_FILE_MONITOR, GFileMonitor))
#DEFINE G_FILE_MONITOR_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_FILE_MONITOR, GFileMonitorClass))
#DEFINE G_IS_FILE_MONITOR(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_FILE_MONITOR))
#DEFINE G_IS_FILE_MONITOR_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), G_TYPE_FILE_MONITOR))
#DEFINE G_FILE_MONITOR_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), G_TYPE_FILE_MONITOR, GFileMonitorClass))

TYPE GFileMonitorClass AS _GFileMonitorClass
TYPE GFileMonitorPrivate AS _GFileMonitorPrivate

TYPE _GFileMonitor
  AS GObject parent_instance
  AS GFileMonitorPrivate PTR priv
END TYPE

TYPE _GFileMonitorClass
  AS GObjectClass parent_class
  changed AS SUB(BYVAL AS GFileMonitor PTR, BYVAL AS GFile PTR, BYVAL AS GFile PTR, BYVAL AS GFileMonitorEvent)
  cancel AS FUNCTION(BYVAL AS GFileMonitor PTR) AS gboolean
  _g_reserved1 AS SUB()
  _g_reserved2 AS SUB()
  _g_reserved3 AS SUB()
  _g_reserved4 AS SUB()
  _g_reserved5 AS SUB()
END TYPE

DECLARE FUNCTION g_file_monitor_get_type() AS GType
DECLARE FUNCTION g_file_monitor_cancel(BYVAL AS GFileMonitor PTR) AS gboolean
DECLARE FUNCTION g_file_monitor_is_cancelled(BYVAL AS GFileMonitor PTR) AS gboolean
DECLARE SUB g_file_monitor_set_rate_limit(BYVAL AS GFileMonitor PTR, BYVAL AS gint)
DECLARE SUB g_file_monitor_emit_event(BYVAL AS GFileMonitor PTR, BYVAL AS GFile PTR, BYVAL AS GFile PTR, BYVAL AS GFileMonitorEvent)

#ENDIF ' __G_FILE_MONITOR_H__

#IFNDEF __G_FILENAME_COMPLETER_H__
#DEFINE __G_FILENAME_COMPLETER_H__

#DEFINE G_TYPE_FILENAME_COMPLETER (g_filename_completer_get_type ())
#DEFINE G_FILENAME_COMPLETER(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_FILENAME_COMPLETER, GFilenameCompleter))
#DEFINE G_FILENAME_COMPLETER_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_FILENAME_COMPLETER, GFilenameCompleterClass))
#DEFINE G_FILENAME_COMPLETER_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), G_TYPE_FILENAME_COMPLETER, GFilenameCompleterClass))
#DEFINE G_IS_FILENAME_COMPLETER(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_FILENAME_COMPLETER))
#DEFINE G_IS_FILENAME_COMPLETER_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), G_TYPE_FILENAME_COMPLETER))

TYPE GFilenameCompleterClass AS _GFilenameCompleterClass

TYPE _GFilenameCompleterClass
  AS GObjectClass parent_class
  got_completion_data AS SUB(BYVAL AS GFilenameCompleter PTR)
  _g_reserved1 AS SUB()
  _g_reserved2 AS SUB()
  _g_reserved3 AS SUB()
END TYPE

DECLARE FUNCTION g_filename_completer_get_type() AS GType
DECLARE FUNCTION g_filename_completer_new() AS GFilenameCompleter PTR
DECLARE FUNCTION g_filename_completer_get_completion_suffix(BYVAL AS GFilenameCompleter PTR, BYVAL AS CONST ZSTRING PTR) AS ZSTRING PTR
DECLARE FUNCTION g_filename_completer_get_completions(BYVAL AS GFilenameCompleter PTR, BYVAL AS CONST ZSTRING PTR) AS ZSTRING PTR PTR
DECLARE SUB g_filename_completer_set_dirs_only(BYVAL AS GFilenameCompleter PTR, BYVAL AS gboolean)

#ENDIF ' __G_FILENAME_COMPLETER_H__

#IFNDEF __G_FILE_OUTPUT_STREAM_H__
#DEFINE __G_FILE_OUTPUT_STREAM_H__

#DEFINE G_TYPE_FILE_OUTPUT_STREAM (g_file_output_stream_get_type ())
#DEFINE G_FILE_OUTPUT_STREAM(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_FILE_OUTPUT_STREAM, GFileOutputStream))
#DEFINE G_FILE_OUTPUT_STREAM_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_FILE_OUTPUT_STREAM, GFileOutputStreamClass))
#DEFINE G_IS_FILE_OUTPUT_STREAM(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_FILE_OUTPUT_STREAM))
#DEFINE G_IS_FILE_OUTPUT_STREAM_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), G_TYPE_FILE_OUTPUT_STREAM))
#DEFINE G_FILE_OUTPUT_STREAM_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), G_TYPE_FILE_OUTPUT_STREAM, GFileOutputStreamClass))

TYPE GFileOutputStreamClass AS _GFileOutputStreamClass
TYPE GFileOutputStreamPrivate AS _GFileOutputStreamPrivate

TYPE _GFileOutputStream
  AS GOutputStream parent_instance
  AS GFileOutputStreamPrivate PTR priv
END TYPE

TYPE _GFileOutputStreamClass
  AS GOutputStreamClass parent_class
  tell AS FUNCTION(BYVAL AS GFileOutputStream PTR) AS goffset
  can_seek AS FUNCTION(BYVAL AS GFileOutputStream PTR) AS gboolean
  seek_ AS FUNCTION(BYVAL AS GFileOutputStream PTR, BYVAL AS goffset, BYVAL AS GSeekType, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
  can_truncate AS FUNCTION(BYVAL AS GFileOutputStream PTR) AS gboolean
  truncate_fn AS FUNCTION(BYVAL AS GFileOutputStream PTR, BYVAL AS goffset, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
  query_info AS FUNCTION(BYVAL AS GFileOutputStream PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GFileInfo PTR
  query_info_async AS SUB(BYVAL AS GFileOutputStream PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  query_info_finish AS FUNCTION(BYVAL AS GFileOutputStream PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GFileInfo PTR
  get_etag AS FUNCTION(BYVAL AS GFileOutputStream PTR) AS ZSTRING PTR
  _g_reserved1 AS SUB()
  _g_reserved2 AS SUB()
  _g_reserved3 AS SUB()
  _g_reserved4 AS SUB()
  _g_reserved5 AS SUB()
END TYPE

DECLARE FUNCTION g_file_output_stream_get_type() AS GType
DECLARE FUNCTION g_file_output_stream_query_info(BYVAL AS GFileOutputStream PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GFileInfo PTR
DECLARE SUB g_file_output_stream_query_info_async(BYVAL AS GFileOutputStream PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_file_output_stream_query_info_finish(BYVAL AS GFileOutputStream PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GFileInfo PTR
DECLARE FUNCTION g_file_output_stream_get_etag(BYVAL AS GFileOutputStream PTR) AS ZSTRING PTR

#ENDIF ' __G_FILE_OUTPUT_STREAM_H__

#IFNDEF __G_INET_ADDRESS_H__
#DEFINE __G_INET_ADDRESS_H__

#DEFINE G_TYPE_INET_ADDRESS (g_inet_address_get_type ())
#DEFINE G_INET_ADDRESS(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_INET_ADDRESS, GInetAddress))
#DEFINE G_INET_ADDRESS_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_INET_ADDRESS, GInetAddressClass))
#DEFINE G_IS_INET_ADDRESS(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_INET_ADDRESS))
#DEFINE G_IS_INET_ADDRESS_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), G_TYPE_INET_ADDRESS))
#DEFINE G_INET_ADDRESS_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), G_TYPE_INET_ADDRESS, GInetAddressClass))

TYPE GInetAddressClass AS _GInetAddressClass
TYPE GInetAddressPrivate AS _GInetAddressPrivate

TYPE _GInetAddress
  AS GObject parent_instance
  AS GInetAddressPrivate PTR priv
END TYPE

TYPE _GInetAddressClass
  AS GObjectClass parent_class
  to_string AS FUNCTION(BYVAL AS GInetAddress PTR) AS gchar PTR
  to_bytes AS FUNCTION(BYVAL AS GInetAddress PTR) AS CONST guint8 PTR
END TYPE

DECLARE FUNCTION g_inet_address_get_type() AS GType
DECLARE FUNCTION g_inet_address_new_from_string(BYVAL AS CONST gchar PTR) AS GInetAddress PTR
DECLARE FUNCTION g_inet_address_new_from_bytes(BYVAL AS CONST guint8 PTR, BYVAL AS GSocketFamily) AS GInetAddress PTR
DECLARE FUNCTION g_inet_address_new_loopback(BYVAL AS GSocketFamily) AS GInetAddress PTR
DECLARE FUNCTION g_inet_address_new_any(BYVAL AS GSocketFamily) AS GInetAddress PTR
DECLARE FUNCTION g_inet_address_equal(BYVAL AS GInetAddress PTR, BYVAL AS GInetAddress PTR) AS gboolean
DECLARE FUNCTION g_inet_address_to_string(BYVAL AS GInetAddress PTR) AS gchar PTR
DECLARE FUNCTION g_inet_address_to_bytes(BYVAL AS GInetAddress PTR) AS CONST guint8 PTR
DECLARE FUNCTION g_inet_address_get_native_size(BYVAL AS GInetAddress PTR) AS gsize
DECLARE FUNCTION g_inet_address_get_family(BYVAL AS GInetAddress PTR) AS GSocketFamily
DECLARE FUNCTION g_inet_address_get_is_any(BYVAL AS GInetAddress PTR) AS gboolean
DECLARE FUNCTION g_inet_address_get_is_loopback(BYVAL AS GInetAddress PTR) AS gboolean
DECLARE FUNCTION g_inet_address_get_is_link_local(BYVAL AS GInetAddress PTR) AS gboolean
DECLARE FUNCTION g_inet_address_get_is_site_local(BYVAL AS GInetAddress PTR) AS gboolean
DECLARE FUNCTION g_inet_address_get_is_multicast(BYVAL AS GInetAddress PTR) AS gboolean
DECLARE FUNCTION g_inet_address_get_is_mc_global(BYVAL AS GInetAddress PTR) AS gboolean
DECLARE FUNCTION g_inet_address_get_is_mc_link_local(BYVAL AS GInetAddress PTR) AS gboolean
DECLARE FUNCTION g_inet_address_get_is_mc_node_local(BYVAL AS GInetAddress PTR) AS gboolean
DECLARE FUNCTION g_inet_address_get_is_mc_org_local(BYVAL AS GInetAddress PTR) AS gboolean
DECLARE FUNCTION g_inet_address_get_is_mc_site_local(BYVAL AS GInetAddress PTR) AS gboolean

#ENDIF ' __G_INET_ADDRESS_H__

#IFNDEF __G_INET_ADDRESS_MASK_H__
#DEFINE __G_INET_ADDRESS_MASK_H__

#DEFINE G_TYPE_INET_ADDRESS_MASK (g_inet_address_mask_get_type ())
#DEFINE G_INET_ADDRESS_MASK(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_INET_ADDRESS_MASK, GInetAddressMask))
#DEFINE G_INET_ADDRESS_MASK_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_INET_ADDRESS_MASK, GInetAddressMaskClass))
#DEFINE G_IS_INET_ADDRESS_MASK(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_INET_ADDRESS_MASK))
#DEFINE G_IS_INET_ADDRESS_MASK_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), G_TYPE_INET_ADDRESS_MASK))
#DEFINE G_INET_ADDRESS_MASK_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), G_TYPE_INET_ADDRESS_MASK, GInetAddressMaskClass))

TYPE GInetAddressMaskClass AS _GInetAddressMaskClass
TYPE GInetAddressMaskPrivate AS _GInetAddressMaskPrivate

TYPE _GInetAddressMask
  AS GObject parent_instance
  AS GInetAddressMaskPrivate PTR priv
END TYPE

TYPE _GInetAddressMaskClass
  AS GObjectClass parent_class
END TYPE

DECLARE FUNCTION g_inet_address_mask_get_type() AS GType
DECLARE FUNCTION g_inet_address_mask_new(BYVAL AS GInetAddress PTR, BYVAL AS guint, BYVAL AS GError PTR PTR) AS GInetAddressMask PTR
DECLARE FUNCTION g_inet_address_mask_new_from_string(BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS GInetAddressMask PTR
DECLARE FUNCTION g_inet_address_mask_to_string(BYVAL AS GInetAddressMask PTR) AS gchar PTR
DECLARE FUNCTION g_inet_address_mask_get_family(BYVAL AS GInetAddressMask PTR) AS GSocketFamily
DECLARE FUNCTION g_inet_address_mask_get_address(BYVAL AS GInetAddressMask PTR) AS GInetAddress PTR
DECLARE FUNCTION g_inet_address_mask_get_length(BYVAL AS GInetAddressMask PTR) AS guint
DECLARE FUNCTION g_inet_address_mask_matches(BYVAL AS GInetAddressMask PTR, BYVAL AS GInetAddress PTR) AS gboolean
DECLARE FUNCTION g_inet_address_mask_equal(BYVAL AS GInetAddressMask PTR, BYVAL AS GInetAddressMask PTR) AS gboolean

#ENDIF ' __G_INET_ADDRESS_MASK_H__

#IFNDEF __G_INET_SOCKET_ADDRESS_H__
#DEFINE __G_INET_SOCKET_ADDRESS_H__

#IFNDEF __G_SOCKET_ADDRESS_H__
#DEFINE __G_SOCKET_ADDRESS_H__

#DEFINE G_TYPE_SOCKET_ADDRESS (g_socket_address_get_type ())
#DEFINE G_SOCKET_ADDRESS(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_SOCKET_ADDRESS, GSocketAddress))
#DEFINE G_SOCKET_ADDRESS_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_SOCKET_ADDRESS, GSocketAddressClass))
#DEFINE G_IS_SOCKET_ADDRESS(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_SOCKET_ADDRESS))
#DEFINE G_IS_SOCKET_ADDRESS_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), G_TYPE_SOCKET_ADDRESS))
#DEFINE G_SOCKET_ADDRESS_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), G_TYPE_SOCKET_ADDRESS, GSocketAddressClass))

TYPE GSocketAddressClass AS _GSocketAddressClass

TYPE _GSocketAddress
  AS GObject parent_instance
END TYPE

TYPE _GSocketAddressClass
  AS GObjectClass parent_class
  get_family AS FUNCTION(BYVAL AS GSocketAddress PTR) AS GSocketFamily
  get_native_size AS FUNCTION(BYVAL AS GSocketAddress PTR) AS gssize
  to_native AS FUNCTION(BYVAL AS GSocketAddress PTR, BYVAL AS gpointer, BYVAL AS gsize, BYVAL AS GError PTR PTR) AS gboolean
END TYPE

DECLARE FUNCTION g_socket_address_get_type() AS GType
DECLARE FUNCTION g_socket_address_get_family(BYVAL AS GSocketAddress PTR) AS GSocketFamily
DECLARE FUNCTION g_socket_address_new_from_native(BYVAL AS gpointer, BYVAL AS gsize) AS GSocketAddress PTR
DECLARE FUNCTION g_socket_address_to_native(BYVAL AS GSocketAddress PTR, BYVAL AS gpointer, BYVAL AS gsize, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_socket_address_get_native_size(BYVAL AS GSocketAddress PTR) AS gssize

#ENDIF ' __G_SOCKET_ADDRESS_H__

#DEFINE G_TYPE_INET_SOCKET_ADDRESS (g_inet_socket_address_get_type ())
#DEFINE G_INET_SOCKET_ADDRESS(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_INET_SOCKET_ADDRESS, GInetSocketAddress))
#DEFINE G_INET_SOCKET_ADDRESS_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_INET_SOCKET_ADDRESS, GInetSocketAddressClass))
#DEFINE G_IS_INET_SOCKET_ADDRESS(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_INET_SOCKET_ADDRESS))
#DEFINE G_IS_INET_SOCKET_ADDRESS_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), G_TYPE_INET_SOCKET_ADDRESS))
#DEFINE G_INET_SOCKET_ADDRESS_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), G_TYPE_INET_SOCKET_ADDRESS, GInetSocketAddressClass))

TYPE GInetSocketAddressClass AS _GInetSocketAddressClass
TYPE GInetSocketAddressPrivate AS _GInetSocketAddressPrivate

TYPE _GInetSocketAddress
  AS GSocketAddress parent_instance
  AS GInetSocketAddressPrivate PTR priv
END TYPE

TYPE _GInetSocketAddressClass
  AS GSocketAddressClass parent_class
END TYPE

DECLARE FUNCTION g_inet_socket_address_get_type() AS GType
DECLARE FUNCTION g_inet_socket_address_new(BYVAL AS GInetAddress PTR, BYVAL AS guint16) AS GSocketAddress PTR
DECLARE FUNCTION g_inet_socket_address_get_address(BYVAL AS GInetSocketAddress PTR) AS GInetAddress PTR
DECLARE FUNCTION g_inet_socket_address_get_port(BYVAL AS GInetSocketAddress PTR) AS guint16

#ENDIF ' __G_INET_SOCKET_ADDRESS_H__

#IFNDEF __GIO_ENUM_TYPES_H__
#DEFINE __GIO_ENUM_TYPES_H__

DECLARE FUNCTION g_app_info_create_flags_get_type() AS GType
#DEFINE G_TYPE_APP_INFO_CREATE_FLAGS (g_app_info_create_flags_get_type ())
DECLARE FUNCTION g_converter_flags_get_type() AS GType
#DEFINE G_TYPE_CONVERTER_FLAGS (g_converter_flags_get_type ())
DECLARE FUNCTION g_converter_result_get_type() AS GType
#DEFINE G_TYPE_CONVERTER_RESULT (g_converter_result_get_type ())
DECLARE FUNCTION g_data_stream_byte_order_get_type() AS GType
#DEFINE G_TYPE_DATA_STREAM_BYTE_ORDER (g_data_stream_byte_order_get_type ())
DECLARE FUNCTION g_data_stream_newline_type_get_type() AS GType
#DEFINE G_TYPE_DATA_STREAM_NEWLINE_TYPE (g_data_stream_newline_type_get_type ())
DECLARE FUNCTION g_file_attribute_type_get_type() AS GType
#DEFINE G_TYPE_FILE_ATTRIBUTE_TYPE (g_file_attribute_type_get_type ())
DECLARE FUNCTION g_file_attribute_info_flags_get_type() AS GType
#DEFINE G_TYPE_FILE_ATTRIBUTE_INFO_FLAGS (g_file_attribute_info_flags_get_type ())
DECLARE FUNCTION g_file_attribute_status_get_type() AS GType
#DEFINE G_TYPE_FILE_ATTRIBUTE_STATUS (g_file_attribute_status_get_type ())
DECLARE FUNCTION g_file_query_info_flags_get_type() AS GType
#DEFINE G_TYPE_FILE_QUERY_INFO_FLAGS (g_file_query_info_flags_get_type ())
DECLARE FUNCTION g_file_create_flags_get_type() AS GType
#DEFINE G_TYPE_FILE_CREATE_FLAGS (g_file_create_flags_get_type ())
DECLARE FUNCTION g_mount_mount_flags_get_type() AS GType
#DEFINE G_TYPE_MOUNT_MOUNT_FLAGS (g_mount_mount_flags_get_type ())
DECLARE FUNCTION g_mount_unmount_flags_get_type() AS GType
#DEFINE G_TYPE_MOUNT_UNMOUNT_FLAGS (g_mount_unmount_flags_get_type ())
DECLARE FUNCTION g_drive_start_flags_get_type() AS GType
#DEFINE G_TYPE_DRIVE_START_FLAGS (g_drive_start_flags_get_type ())
DECLARE FUNCTION g_drive_start_stop_type_get_type() AS GType
#DEFINE G_TYPE_DRIVE_START_STOP_TYPE (g_drive_start_stop_type_get_type ())
DECLARE FUNCTION g_file_copy_flags_get_type() AS GType
#DEFINE G_TYPE_FILE_COPY_FLAGS (g_file_copy_flags_get_type ())
DECLARE FUNCTION g_file_monitor_flags_get_type() AS GType
#DEFINE G_TYPE_FILE_MONITOR_FLAGS (g_file_monitor_flags_get_type ())
DECLARE FUNCTION g_file_type_get_type() AS GType
#DEFINE G_TYPE_FILE_TYPE (g_file_type_get_type ())
DECLARE FUNCTION g_filesystem_preview_type_get_type() AS GType
#DEFINE G_TYPE_FILESYSTEM_PREVIEW_TYPE (g_filesystem_preview_type_get_type ())
DECLARE FUNCTION g_file_monitor_event_get_type() AS GType
#DEFINE G_TYPE_FILE_MONITOR_EVENT (g_file_monitor_event_get_type ())
DECLARE FUNCTION g_io_error_enum_get_type() AS GType
#DEFINE G_TYPE_IO_ERROR_ENUM (g_io_error_enum_get_type ())
DECLARE FUNCTION g_ask_password_flags_get_type() AS GType
#DEFINE G_TYPE_ASK_PASSWORD_FLAGS (g_ask_password_flags_get_type ())
DECLARE FUNCTION g_password_save_get_type() AS GType
#DEFINE G_TYPE_PASSWORD_SAVE (g_password_save_get_type ())
DECLARE FUNCTION g_mount_operation_result_get_type() AS GType
#DEFINE G_TYPE_MOUNT_OPERATION_RESULT (g_mount_operation_result_get_type ())
DECLARE FUNCTION g_output_stream_splice_flags_get_type() AS GType
#DEFINE G_TYPE_OUTPUT_STREAM_SPLICE_FLAGS (g_output_stream_splice_flags_get_type ())
DECLARE FUNCTION g_io_stream_splice_flags_get_type() AS GType
#DEFINE G_TYPE_IO_STREAM_SPLICE_FLAGS (g_io_stream_splice_flags_get_type ())
DECLARE FUNCTION g_emblem_origin_get_type() AS GType
#DEFINE G_TYPE_EMBLEM_ORIGIN (g_emblem_origin_get_type ())
DECLARE FUNCTION g_resolver_error_get_type() AS GType
#DEFINE G_TYPE_RESOLVER_ERROR (g_resolver_error_get_type ())
DECLARE FUNCTION g_socket_family_get_type() AS GType
#DEFINE G_TYPE_SOCKET_FAMILY (g_socket_family_get_type ())
DECLARE FUNCTION g_socket_type_get_type() AS GType
#DEFINE G_TYPE_SOCKET_TYPE (g_socket_type_get_type ())
DECLARE FUNCTION g_socket_msg_flags_get_type() AS GType
#DEFINE G_TYPE_SOCKET_MSG_FLAGS (g_socket_msg_flags_get_type ())
DECLARE FUNCTION g_socket_protocol_get_type() AS GType
#DEFINE G_TYPE_SOCKET_PROTOCOL (g_socket_protocol_get_type ())
DECLARE FUNCTION g_zlib_compressor_format_get_type() AS GType
#DEFINE G_TYPE_ZLIB_COMPRESSOR_FORMAT (g_zlib_compressor_format_get_type ())
DECLARE FUNCTION g_unix_socket_address_type_get_type() AS GType
#DEFINE G_TYPE_UNIX_SOCKET_ADDRESS_TYPE (g_unix_socket_address_type_get_type ())
DECLARE FUNCTION g_bus_type_get_type() AS GType
#DEFINE G_TYPE_BUS_TYPE (g_bus_type_get_type ())
DECLARE FUNCTION g_bus_name_owner_flags_get_type() AS GType
#DEFINE G_TYPE_BUS_NAME_OWNER_FLAGS (g_bus_name_owner_flags_get_type ())
DECLARE FUNCTION g_bus_name_watcher_flags_get_type() AS GType
#DEFINE G_TYPE_BUS_NAME_WATCHER_FLAGS (g_bus_name_watcher_flags_get_type ())
DECLARE FUNCTION g_dbus_proxy_flags_get_type() AS GType
#DEFINE G_TYPE_DBUS_PROXY_FLAGS (g_dbus_proxy_flags_get_type ())
DECLARE FUNCTION g_dbus_error_get_type() AS GType
#DEFINE G_TYPE_DBUS_ERROR (g_dbus_error_get_type ())
DECLARE FUNCTION g_dbus_connection_flags_get_type() AS GType
#DEFINE G_TYPE_DBUS_CONNECTION_FLAGS (g_dbus_connection_flags_get_type ())
DECLARE FUNCTION g_dbus_capability_flags_get_type() AS GType
#DEFINE G_TYPE_DBUS_CAPABILITY_FLAGS (g_dbus_capability_flags_get_type ())
DECLARE FUNCTION g_dbus_call_flags_get_type() AS GType
#DEFINE G_TYPE_DBUS_CALL_FLAGS (g_dbus_call_flags_get_type ())
DECLARE FUNCTION g_dbus_message_type_get_type() AS GType
#DEFINE G_TYPE_DBUS_MESSAGE_TYPE (g_dbus_message_type_get_type ())
DECLARE FUNCTION g_dbus_message_flags_get_type() AS GType
#DEFINE G_TYPE_DBUS_MESSAGE_FLAGS (g_dbus_message_flags_get_type ())
DECLARE FUNCTION g_dbus_message_header_field_get_type() AS GType
#DEFINE G_TYPE_DBUS_MESSAGE_HEADER_FIELD (g_dbus_message_header_field_get_type ())
DECLARE FUNCTION g_dbus_property_info_flags_get_type() AS GType
#DEFINE G_TYPE_DBUS_PROPERTY_INFO_FLAGS (g_dbus_property_info_flags_get_type ())
DECLARE FUNCTION g_dbus_subtree_flags_get_type() AS GType
#DEFINE G_TYPE_DBUS_SUBTREE_FLAGS (g_dbus_subtree_flags_get_type ())
DECLARE FUNCTION g_dbus_server_flags_get_type() AS GType
#DEFINE G_TYPE_DBUS_SERVER_FLAGS (g_dbus_server_flags_get_type ())
DECLARE FUNCTION g_dbus_signal_flags_get_type() AS GType
#DEFINE G_TYPE_DBUS_SIGNAL_FLAGS (g_dbus_signal_flags_get_type ())
DECLARE FUNCTION g_dbus_send_message_flags_get_type() AS GType
#DEFINE G_TYPE_DBUS_SEND_MESSAGE_FLAGS (g_dbus_send_message_flags_get_type ())
DECLARE FUNCTION g_credentials_type_get_type() AS GType
#DEFINE G_TYPE_CREDENTIALS_TYPE (g_credentials_type_get_type ())
DECLARE FUNCTION g_dbus_message_byte_order_get_type() AS GType
#DEFINE G_TYPE_DBUS_MESSAGE_BYTE_ORDER (g_dbus_message_byte_order_get_type ())
DECLARE FUNCTION g_application_flags_get_type() AS GType
#DEFINE G_TYPE_APPLICATION_FLAGS (g_application_flags_get_type ())
DECLARE FUNCTION g_tls_error_get_type() AS GType
#DEFINE G_TYPE_TLS_ERROR (g_tls_error_get_type ())
DECLARE FUNCTION g_tls_certificate_flags_get_type() AS GType
#DEFINE G_TYPE_TLS_CERTIFICATE_FLAGS (g_tls_certificate_flags_get_type ())
DECLARE FUNCTION g_tls_authentication_mode_get_type() AS GType
#DEFINE G_TYPE_TLS_AUTHENTICATION_MODE (g_tls_authentication_mode_get_type ())
DECLARE FUNCTION g_tls_rehandshake_mode_get_type() AS GType
#DEFINE G_TYPE_TLS_REHANDSHAKE_MODE (g_tls_rehandshake_mode_get_type ())
DECLARE FUNCTION g_tls_password_flags_get_type() AS GType
#DEFINE G_TYPE_TLS_PASSWORD_FLAGS (g_tls_password_flags_get_type ())
DECLARE FUNCTION g_tls_interaction_result_get_type() AS GType
#DEFINE G_TYPE_TLS_INTERACTION_RESULT (g_tls_interaction_result_get_type ())
DECLARE FUNCTION g_dbus_interface_skeleton_flags_get_type() AS GType
#DEFINE G_TYPE_DBUS_INTERFACE_SKELETON_FLAGS (g_dbus_interface_skeleton_flags_get_type ())
DECLARE FUNCTION g_dbus_object_manager_client_flags_get_type() AS GType
#DEFINE G_TYPE_DBUS_OBJECT_MANAGER_CLIENT_FLAGS (g_dbus_object_manager_client_flags_get_type ())
DECLARE FUNCTION g_tls_database_verify_flags_get_type() AS GType
#DEFINE G_TYPE_TLS_DATABASE_VERIFY_FLAGS (g_tls_database_verify_flags_get_type ())
DECLARE FUNCTION g_tls_database_lookup_flags_get_type() AS GType
#DEFINE G_TYPE_TLS_DATABASE_LOOKUP_FLAGS (g_tls_database_lookup_flags_get_type ())
DECLARE FUNCTION g_io_module_scope_flags_get_type() AS GType
#DEFINE G_TYPE_IO_MODULE_SCOPE_FLAGS (g_io_module_scope_flags_get_type ())
DECLARE FUNCTION g_settings_bind_flags_get_type() AS GType
#DEFINE G_TYPE_SETTINGS_BIND_FLAGS (g_settings_bind_flags_get_type ())
#ENDIF ' __GIO_ENUM_TYPES_H__

#IFNDEF __G_IO_MODULE_H__
#DEFINE __G_IO_MODULE_H__

#INCLUDE ONCE "gmodule.bi"

TYPE GIOModuleScope AS _GIOModuleScope

DECLARE FUNCTION g_io_module_scope_new(BYVAL AS GIOModuleScopeFlags) AS GIOModuleScope PTR
DECLARE SUB g_io_module_scope_free(BYVAL AS GIOModuleScope PTR)
DECLARE SUB g_io_module_scope_block(BYVAL AS GIOModuleScope PTR, BYVAL AS CONST gchar PTR)

#DEFINE G_IO_TYPE_MODULE (g_io_module_get_type ())
#DEFINE G_IO_MODULE(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_IO_TYPE_MODULE, GIOModule))
#DEFINE G_IO_MODULE_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), G_IO_TYPE_MODULE, GIOModuleClass))
#DEFINE G_IO_IS_MODULE(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_IO_TYPE_MODULE))
#DEFINE G_IO_IS_MODULE_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), G_IO_TYPE_MODULE))
#DEFINE G_IO_MODULE_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), G_IO_TYPE_MODULE, GIOModuleClass))

TYPE GIOModuleClass AS _GIOModuleClass

DECLARE FUNCTION g_io_module_get_type() AS GType
DECLARE FUNCTION g_io_module_new(BYVAL AS CONST gchar PTR) AS GIOModule PTR
DECLARE SUB g_io_modules_scan_all_in_directory(BYVAL AS CONST ZSTRING PTR)
DECLARE FUNCTION g_io_modules_load_all_in_directory(BYVAL AS CONST gchar PTR) AS GList PTR
DECLARE SUB g_io_modules_scan_all_in_directory_with_scope(BYVAL AS CONST gchar PTR, BYVAL AS GIOModuleScope PTR)
DECLARE FUNCTION g_io_modules_load_all_in_directory_with_scope(BYVAL AS CONST gchar PTR, BYVAL AS GIOModuleScope PTR) AS GList PTR
DECLARE FUNCTION g_io_extension_point_register(BYVAL AS CONST ZSTRING PTR) AS GIOExtensionPoint PTR
DECLARE FUNCTION g_io_extension_point_lookup(BYVAL AS CONST ZSTRING PTR) AS GIOExtensionPoint PTR
DECLARE SUB g_io_extension_point_set_required_type(BYVAL AS GIOExtensionPoint PTR, BYVAL AS GType)
DECLARE FUNCTION g_io_extension_point_get_required_type(BYVAL AS GIOExtensionPoint PTR) AS GType
DECLARE FUNCTION g_io_extension_point_get_extensions(BYVAL AS GIOExtensionPoint PTR) AS GList PTR
DECLARE FUNCTION g_io_extension_point_get_extension_by_name(BYVAL AS GIOExtensionPoint PTR, BYVAL AS CONST ZSTRING PTR) AS GIOExtension PTR
DECLARE FUNCTION g_io_extension_point_implement(BYVAL AS CONST ZSTRING PTR, BYVAL AS GType, BYVAL AS CONST ZSTRING PTR, BYVAL AS gint) AS GIOExtension PTR
DECLARE FUNCTION g_io_extension_get_type(BYVAL AS GIOExtension PTR) AS GType
DECLARE FUNCTION g_io_extension_get_name(BYVAL AS GIOExtension PTR) AS CONST ZSTRING PTR
DECLARE FUNCTION g_io_extension_get_priority(BYVAL AS GIOExtension PTR) AS gint
DECLARE FUNCTION g_io_extension_ref_class(BYVAL AS GIOExtension PTR) AS GTypeClass PTR
DECLARE SUB g_io_module_load(BYVAL AS GIOModule PTR)
DECLARE SUB g_io_module_unload(BYVAL AS GIOModule PTR)
DECLARE FUNCTION g_io_module_query() AS ZSTRING PTR PTR

#ENDIF ' __G_IO_MODULE_H__

#IFNDEF __G_IO_SCHEDULER_H__
#DEFINE __G_IO_SCHEDULER_H__

DECLARE SUB g_io_scheduler_push_job(BYVAL AS GIOSchedulerJobFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify, BYVAL AS gint, BYVAL AS GCancellable PTR)
DECLARE SUB g_io_scheduler_cancel_all_jobs()
DECLARE FUNCTION g_io_scheduler_job_send_to_mainloop(BYVAL AS GIOSchedulerJob PTR, BYVAL AS GSourceFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify) AS gboolean
DECLARE SUB g_io_scheduler_job_send_to_mainloop_async(BYVAL AS GIOSchedulerJob PTR, BYVAL AS GSourceFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify)

#ENDIF ' __G_IO_SCHEDULER_H__

#IFNDEF __G_LOADABLE_ICON_H__
#DEFINE __G_LOADABLE_ICON_H__

#DEFINE G_TYPE_LOADABLE_ICON (g_loadable_icon_get_type ())
#DEFINE G_LOADABLE_ICON(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), G_TYPE_LOADABLE_ICON, GLoadableIcon))
#DEFINE G_IS_LOADABLE_ICON(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), G_TYPE_LOADABLE_ICON))
#DEFINE G_LOADABLE_ICON_GET_IFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), G_TYPE_LOADABLE_ICON, GLoadableIconIface))

TYPE GLoadableIconIface AS _GLoadableIconIface

TYPE _GLoadableIconIface
  AS GTypeInterface g_iface
  load AS FUNCTION(BYVAL AS GLoadableIcon PTR, BYVAL AS INTEGER, BYVAL AS ZSTRING PTR PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GInputStream PTR
  load_async AS SUB(BYVAL AS GLoadableIcon PTR, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  load_finish AS FUNCTION(BYVAL AS GLoadableIcon PTR, BYVAL AS GAsyncResult PTR, BYVAL AS ZSTRING PTR PTR, BYVAL AS GError PTR PTR) AS GInputStream PTR
END TYPE

DECLARE FUNCTION g_loadable_icon_get_type() AS GType
DECLARE FUNCTION g_loadable_icon_load(BYVAL AS GLoadableIcon PTR, BYVAL AS INTEGER, BYVAL AS ZSTRING PTR PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GInputStream PTR
DECLARE SUB g_loadable_icon_load_async(BYVAL AS GLoadableIcon PTR, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_loadable_icon_load_finish(BYVAL AS GLoadableIcon PTR, BYVAL AS GAsyncResult PTR, BYVAL AS ZSTRING PTR PTR, BYVAL AS GError PTR PTR) AS GInputStream PTR

#ENDIF ' __G_LOADABLE_ICON_H__

#IFNDEF __G_MEMORY_INPUT_STREAM_H__
#DEFINE __G_MEMORY_INPUT_STREAM_H__

#DEFINE G_TYPE_MEMORY_INPUT_STREAM (g_memory_input_stream_get_type ())
#DEFINE G_MEMORY_INPUT_STREAM(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_MEMORY_INPUT_STREAM, GMemoryInputStream))
#DEFINE G_MEMORY_INPUT_STREAM_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_MEMORY_INPUT_STREAM, GMemoryInputStreamClass))
#DEFINE G_IS_MEMORY_INPUT_STREAM(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_MEMORY_INPUT_STREAM))
#DEFINE G_IS_MEMORY_INPUT_STREAM_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), G_TYPE_MEMORY_INPUT_STREAM))
#DEFINE G_MEMORY_INPUT_STREAM_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), G_TYPE_MEMORY_INPUT_STREAM, GMemoryInputStreamClass))

TYPE GMemoryInputStreamClass AS _GMemoryInputStreamClass
TYPE GMemoryInputStreamPrivate AS _GMemoryInputStreamPrivate

TYPE _GMemoryInputStream
  AS GInputStream parent_instance
  AS GMemoryInputStreamPrivate PTR priv
END TYPE

TYPE _GMemoryInputStreamClass
  AS GInputStreamClass parent_class
  _g_reserved1 AS SUB()
  _g_reserved2 AS SUB()
  _g_reserved3 AS SUB()
  _g_reserved4 AS SUB()
  _g_reserved5 AS SUB()
END TYPE

DECLARE FUNCTION g_memory_input_stream_get_type() AS GType
DECLARE FUNCTION g_memory_input_stream_new() AS GInputStream PTR
DECLARE FUNCTION g_memory_input_stream_new_from_data(BYVAL AS CONST ANY PTR, BYVAL AS gssize, BYVAL AS GDestroyNotify) AS GInputStream PTR
DECLARE SUB g_memory_input_stream_add_data(BYVAL AS GMemoryInputStream PTR, BYVAL AS CONST ANY PTR, BYVAL AS gssize, BYVAL AS GDestroyNotify)

#ENDIF ' __G_MEMORY_INPUT_STREAM_H__

#IFNDEF __G_MEMORY_OUTPUT_STREAM_H__
#DEFINE __G_MEMORY_OUTPUT_STREAM_H__

#DEFINE G_TYPE_MEMORY_OUTPUT_STREAM (g_memory_output_stream_get_type ())
#DEFINE G_MEMORY_OUTPUT_STREAM(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_MEMORY_OUTPUT_STREAM, GMemoryOutputStream))
#DEFINE G_MEMORY_OUTPUT_STREAM_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_MEMORY_OUTPUT_STREAM, GMemoryOutputStreamClass))
#DEFINE G_IS_MEMORY_OUTPUT_STREAM(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_MEMORY_OUTPUT_STREAM))
#DEFINE G_IS_MEMORY_OUTPUT_STREAM_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), G_TYPE_MEMORY_OUTPUT_STREAM))
#DEFINE G_MEMORY_OUTPUT_STREAM_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), G_TYPE_MEMORY_OUTPUT_STREAM, GMemoryOutputStreamClass))

TYPE GMemoryOutputStreamClass AS _GMemoryOutputStreamClass
TYPE GMemoryOutputStreamPrivate AS _GMemoryOutputStreamPrivate

TYPE _GMemoryOutputStream
  AS GOutputStream parent_instance
  AS GMemoryOutputStreamPrivate PTR priv
END TYPE

TYPE _GMemoryOutputStreamClass
  AS GOutputStreamClass parent_class
  _g_reserved1 AS SUB()
  _g_reserved2 AS SUB()
  _g_reserved3 AS SUB()
  _g_reserved4 AS SUB()
  _g_reserved5 AS SUB()
END TYPE

TYPE GReallocFunc AS FUNCTION(BYVAL AS gpointer, BYVAL AS gsize) AS gpointer

DECLARE FUNCTION g_memory_output_stream_get_type() AS GType
DECLARE FUNCTION g_memory_output_stream_new(BYVAL AS gpointer, BYVAL AS gsize, BYVAL AS GReallocFunc, BYVAL AS GDestroyNotify) AS GOutputStream PTR
DECLARE FUNCTION g_memory_output_stream_get_data(BYVAL AS GMemoryOutputStream PTR) AS gpointer
DECLARE FUNCTION g_memory_output_stream_get_size(BYVAL AS GMemoryOutputStream PTR) AS gsize
DECLARE FUNCTION g_memory_output_stream_get_data_size(BYVAL AS GMemoryOutputStream PTR) AS gsize
DECLARE FUNCTION g_memory_output_stream_steal_data(BYVAL AS GMemoryOutputStream PTR) AS gpointer

#ENDIF ' __G_MEMORY_OUTPUT_STREAM_H__

#IFNDEF __G_MOUNT_H__
#DEFINE __G_MOUNT_H__

#DEFINE G_TYPE_MOUNT (g_mount_get_type ())
#DEFINE G_MOUNT(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), G_TYPE_MOUNT, GMount))
#DEFINE G_IS_MOUNT(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), G_TYPE_MOUNT))
#DEFINE G_MOUNT_GET_IFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), G_TYPE_MOUNT, GMountIface))

TYPE GMountIface AS _GMountIface

TYPE _GMountIface
  AS GTypeInterface g_iface
  changed AS SUB(BYVAL AS GMount PTR)
  unmounted AS SUB(BYVAL AS GMount PTR)
  get_root AS FUNCTION(BYVAL AS GMount PTR) AS GFile PTR
  get_name AS FUNCTION(BYVAL AS GMount PTR) AS ZSTRING PTR
  get_icon AS FUNCTION(BYVAL AS GMount PTR) AS GIcon PTR
  get_uuid AS FUNCTION(BYVAL AS GMount PTR) AS ZSTRING PTR
  get_volume AS FUNCTION(BYVAL AS GMount PTR) AS GVolume PTR
  get_drive AS FUNCTION(BYVAL AS GMount PTR) AS GDrive PTR
  can_unmount AS FUNCTION(BYVAL AS GMount PTR) AS gboolean
  can_eject AS FUNCTION(BYVAL AS GMount PTR) AS gboolean
  unmount AS SUB(BYVAL AS GMount PTR, BYVAL AS GMountUnmountFlags, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  unmount_finish AS FUNCTION(BYVAL AS GMount PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
  eject AS SUB(BYVAL AS GMount PTR, BYVAL AS GMountUnmountFlags, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  eject_finish AS FUNCTION(BYVAL AS GMount PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
  remount AS SUB(BYVAL AS GMount PTR, BYVAL AS GMountMountFlags, BYVAL AS GMountOperation PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  remount_finish AS FUNCTION(BYVAL AS GMount PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
  guess_content_type AS SUB(BYVAL AS GMount PTR, BYVAL AS gboolean, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  guess_content_type_finish AS FUNCTION(BYVAL AS GMount PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gchar PTR PTR
  guess_content_type_sync AS FUNCTION(BYVAL AS GMount PTR, BYVAL AS gboolean, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gchar PTR PTR
  pre_unmount AS SUB(BYVAL AS GMount PTR)
  unmount_with_operation AS SUB(BYVAL AS GMount PTR, BYVAL AS GMountUnmountFlags, BYVAL AS GMountOperation PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  unmount_with_operation_finish AS FUNCTION(BYVAL AS GMount PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
  eject_with_operation AS SUB(BYVAL AS GMount PTR, BYVAL AS GMountUnmountFlags, BYVAL AS GMountOperation PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  eject_with_operation_finish AS FUNCTION(BYVAL AS GMount PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
  get_default_location AS FUNCTION(BYVAL AS GMount PTR) AS GFile PTR
  get_sort_key AS FUNCTION(BYVAL AS GMount PTR) AS CONST gchar PTR
END TYPE

DECLARE FUNCTION g_mount_get_type() AS GType
DECLARE FUNCTION g_mount_get_root(BYVAL AS GMount PTR) AS GFile PTR
DECLARE FUNCTION g_mount_get_default_location(BYVAL AS GMount PTR) AS GFile PTR
DECLARE FUNCTION g_mount_get_name(BYVAL AS GMount PTR) AS ZSTRING PTR
DECLARE FUNCTION g_mount_get_icon(BYVAL AS GMount PTR) AS GIcon PTR
DECLARE FUNCTION g_mount_get_uuid(BYVAL AS GMount PTR) AS ZSTRING PTR
DECLARE FUNCTION g_mount_get_volume(BYVAL AS GMount PTR) AS GVolume PTR
DECLARE FUNCTION g_mount_get_drive(BYVAL AS GMount PTR) AS GDrive PTR
DECLARE FUNCTION g_mount_can_unmount(BYVAL AS GMount PTR) AS gboolean
DECLARE FUNCTION g_mount_can_eject(BYVAL AS GMount PTR) AS gboolean
DECLARE SUB g_mount_unmount(BYVAL AS GMount PTR, BYVAL AS GMountUnmountFlags, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_mount_unmount_finish(BYVAL AS GMount PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE SUB g_mount_eject(BYVAL AS GMount PTR, BYVAL AS GMountUnmountFlags, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_mount_eject_finish(BYVAL AS GMount PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE SUB g_mount_remount(BYVAL AS GMount PTR, BYVAL AS GMountMountFlags, BYVAL AS GMountOperation PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_mount_remount_finish(BYVAL AS GMount PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE SUB g_mount_guess_content_type(BYVAL AS GMount PTR, BYVAL AS gboolean, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_mount_guess_content_type_finish(BYVAL AS GMount PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gchar PTR PTR
DECLARE FUNCTION g_mount_guess_content_type_sync(BYVAL AS GMount PTR, BYVAL AS gboolean, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gchar PTR PTR
DECLARE FUNCTION g_mount_is_shadowed(BYVAL AS GMount PTR) AS gboolean
DECLARE SUB g_mount_shadow(BYVAL AS GMount PTR)
DECLARE SUB g_mount_unshadow(BYVAL AS GMount PTR)
DECLARE SUB g_mount_unmount_with_operation(BYVAL AS GMount PTR, BYVAL AS GMountUnmountFlags, BYVAL AS GMountOperation PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_mount_unmount_with_operation_finish(BYVAL AS GMount PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE SUB g_mount_eject_with_operation(BYVAL AS GMount PTR, BYVAL AS GMountUnmountFlags, BYVAL AS GMountOperation PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_mount_eject_with_operation_finish(BYVAL AS GMount PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_mount_get_sort_key(BYVAL AS GMount PTR) AS CONST gchar PTR

#ENDIF ' __G_MOUNT_H__

#IFNDEF __G_MOUNT_OPERATION_H__
#DEFINE __G_MOUNT_OPERATION_H__

#DEFINE G_TYPE_MOUNT_OPERATION (g_mount_operation_get_type ())
#DEFINE G_MOUNT_OPERATION(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_MOUNT_OPERATION, GMountOperation))
#DEFINE G_MOUNT_OPERATION_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_MOUNT_OPERATION, GMountOperationClass))
#DEFINE G_IS_MOUNT_OPERATION(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_MOUNT_OPERATION))
#DEFINE G_IS_MOUNT_OPERATION_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), G_TYPE_MOUNT_OPERATION))
#DEFINE G_MOUNT_OPERATION_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), G_TYPE_MOUNT_OPERATION, GMountOperationClass))

TYPE GMountOperationClass AS _GMountOperationClass
TYPE GMountOperationPrivate AS _GMountOperationPrivate

TYPE _GMountOperation
  AS GObject parent_instance
  AS GMountOperationPrivate PTR priv
END TYPE

TYPE _GMountOperationClass
  AS GObjectClass parent_class
  ask_password AS SUB(BYVAL AS GMountOperation PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS GAskPasswordFlags)
  ask_question AS SUB(BYVAL AS GMountOperation PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST ZSTRING PTR PTR)
  reply AS SUB(BYVAL AS GMountOperation PTR, BYVAL AS GMountOperationResult)
  aborted AS SUB(BYVAL AS GMountOperation PTR)
  show_processes AS SUB(BYVAL AS GMountOperation PTR, BYVAL AS CONST gchar PTR, BYVAL AS GArray PTR, BYVAL AS CONST gchar PTR PTR)
  _g_reserved1 AS SUB()
  _g_reserved2 AS SUB()
  _g_reserved3 AS SUB()
  _g_reserved4 AS SUB()
  _g_reserved5 AS SUB()
  _g_reserved6 AS SUB()
  _g_reserved7 AS SUB()
  _g_reserved8 AS SUB()
  _g_reserved9 AS SUB()
  _g_reserved10 AS SUB()
END TYPE

DECLARE FUNCTION g_mount_operation_get_type() AS GType
DECLARE FUNCTION g_mount_operation_new() AS GMountOperation PTR
DECLARE FUNCTION g_mount_operation_get_username(BYVAL AS GMountOperation PTR) AS CONST ZSTRING PTR
DECLARE SUB g_mount_operation_set_username(BYVAL AS GMountOperation PTR, BYVAL AS CONST ZSTRING PTR)
DECLARE FUNCTION g_mount_operation_get_password(BYVAL AS GMountOperation PTR) AS CONST ZSTRING PTR
DECLARE SUB g_mount_operation_set_password(BYVAL AS GMountOperation PTR, BYVAL AS CONST ZSTRING PTR)
DECLARE FUNCTION g_mount_operation_get_anonymous(BYVAL AS GMountOperation PTR) AS gboolean
DECLARE SUB g_mount_operation_set_anonymous(BYVAL AS GMountOperation PTR, BYVAL AS gboolean)
DECLARE FUNCTION g_mount_operation_get_domain(BYVAL AS GMountOperation PTR) AS CONST ZSTRING PTR
DECLARE SUB g_mount_operation_set_domain(BYVAL AS GMountOperation PTR, BYVAL AS CONST ZSTRING PTR)
DECLARE FUNCTION g_mount_operation_get_password_save(BYVAL AS GMountOperation PTR) AS GPasswordSave
DECLARE SUB g_mount_operation_set_password_save(BYVAL AS GMountOperation PTR, BYVAL AS GPasswordSave)
DECLARE FUNCTION g_mount_operation_get_choice(BYVAL AS GMountOperation PTR) AS INTEGER
DECLARE SUB g_mount_operation_set_choice(BYVAL AS GMountOperation PTR, BYVAL AS INTEGER)
DECLARE SUB g_mount_operation_reply(BYVAL AS GMountOperation PTR, BYVAL AS GMountOperationResult)

#ENDIF ' __G_MOUNT_OPERATION_H__

#IFNDEF __G_NATIVE_VOLUME_MONITOR_H__
#DEFINE __G_NATIVE_VOLUME_MONITOR_H__

#IFNDEF __G_VOLUME_MONITOR_H__
#DEFINE __G_VOLUME_MONITOR_H__

#DEFINE G_TYPE_VOLUME_MONITOR (g_volume_monitor_get_type ())
#DEFINE G_VOLUME_MONITOR(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_VOLUME_MONITOR, GVolumeMonitor))
#DEFINE G_VOLUME_MONITOR_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_VOLUME_MONITOR, GVolumeMonitorClass))
#DEFINE G_VOLUME_MONITOR_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), G_TYPE_VOLUME_MONITOR, GVolumeMonitorClass))
#DEFINE G_IS_VOLUME_MONITOR(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_VOLUME_MONITOR))
#DEFINE G_IS_VOLUME_MONITOR_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), G_TYPE_VOLUME_MONITOR))
#DEFINE G_VOLUME_MONITOR_EXTENSION_POINT_NAME !"gio-volume-monitor"

TYPE GVolumeMonitorClass AS _GVolumeMonitorClass

TYPE _GVolumeMonitor
  AS GObject parent_instance
  AS gpointer priv
END TYPE

TYPE _GVolumeMonitorClass
  AS GObjectClass parent_class
  volume_added AS SUB(BYVAL AS GVolumeMonitor PTR, BYVAL AS GVolume PTR)
  volume_removed AS SUB(BYVAL AS GVolumeMonitor PTR, BYVAL AS GVolume PTR)
  volume_changed AS SUB(BYVAL AS GVolumeMonitor PTR, BYVAL AS GVolume PTR)
  mount_added AS SUB(BYVAL AS GVolumeMonitor PTR, BYVAL AS GMount PTR)
  mount_removed AS SUB(BYVAL AS GVolumeMonitor PTR, BYVAL AS GMount PTR)
  mount_pre_unmount AS SUB(BYVAL AS GVolumeMonitor PTR, BYVAL AS GMount PTR)
  mount_changed AS SUB(BYVAL AS GVolumeMonitor PTR, BYVAL AS GMount PTR)
  drive_connected AS SUB(BYVAL AS GVolumeMonitor PTR, BYVAL AS GDrive PTR)
  drive_disconnected AS SUB(BYVAL AS GVolumeMonitor PTR, BYVAL AS GDrive PTR)
  drive_changed AS SUB(BYVAL AS GVolumeMonitor PTR, BYVAL AS GDrive PTR)
  is_supported AS FUNCTION() AS gboolean
  get_connected_drives AS FUNCTION(BYVAL AS GVolumeMonitor PTR) AS GList PTR
  get_volumes AS FUNCTION(BYVAL AS GVolumeMonitor PTR) AS GList PTR
  get_mounts AS FUNCTION(BYVAL AS GVolumeMonitor PTR) AS GList PTR
  get_volume_for_uuid AS FUNCTION(BYVAL AS GVolumeMonitor PTR, BYVAL AS CONST ZSTRING PTR) AS GVolume PTR
  get_mount_for_uuid AS FUNCTION(BYVAL AS GVolumeMonitor PTR, BYVAL AS CONST ZSTRING PTR) AS GMount PTR
  adopt_orphan_mount AS FUNCTION(BYVAL AS GMount PTR, BYVAL AS GVolumeMonitor PTR) AS GVolume PTR
  drive_eject_button AS SUB(BYVAL AS GVolumeMonitor PTR, BYVAL AS GDrive PTR)
  drive_stop_button AS SUB(BYVAL AS GVolumeMonitor PTR, BYVAL AS GDrive PTR)
  _g_reserved1 AS SUB()
  _g_reserved2 AS SUB()
  _g_reserved3 AS SUB()
  _g_reserved4 AS SUB()
  _g_reserved5 AS SUB()
  _g_reserved6 AS SUB()
END TYPE

DECLARE FUNCTION g_volume_monitor_get_type() AS GType
DECLARE FUNCTION g_volume_monitor_get() AS GVolumeMonitor PTR
DECLARE FUNCTION g_volume_monitor_get_connected_drives(BYVAL AS GVolumeMonitor PTR) AS GList PTR
DECLARE FUNCTION g_volume_monitor_get_volumes(BYVAL AS GVolumeMonitor PTR) AS GList PTR
DECLARE FUNCTION g_volume_monitor_get_mounts(BYVAL AS GVolumeMonitor PTR) AS GList PTR
DECLARE FUNCTION g_volume_monitor_get_volume_for_uuid(BYVAL AS GVolumeMonitor PTR, BYVAL AS CONST ZSTRING PTR) AS GVolume PTR
DECLARE FUNCTION g_volume_monitor_get_mount_for_uuid(BYVAL AS GVolumeMonitor PTR, BYVAL AS CONST ZSTRING PTR) AS GMount PTR
DECLARE FUNCTION g_volume_monitor_adopt_orphan_mount(BYVAL AS GMount PTR) AS GVolume PTR

#ENDIF ' __G_VOLUME_MONITOR_H__

#DEFINE G_TYPE_NATIVE_VOLUME_MONITOR (g_native_volume_monitor_get_type ())
#DEFINE G_NATIVE_VOLUME_MONITOR(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_NATIVE_VOLUME_MONITOR, GNativeVolumeMonitor))
#DEFINE G_NATIVE_VOLUME_MONITOR_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_NATIVE_VOLUME_MONITOR, GNativeVolumeMonitorClass))
#DEFINE G_IS_NATIVE_VOLUME_MONITOR(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_NATIVE_VOLUME_MONITOR))
#DEFINE G_IS_NATIVE_VOLUME_MONITOR_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), G_TYPE_NATIVE_VOLUME_MONITOR))
#DEFINE G_NATIVE_VOLUME_MONITOR_EXTENSION_POINT_NAME !"gio-native-volume-monitor"

TYPE GNativeVolumeMonitor AS _GNativeVolumeMonitor
TYPE GNativeVolumeMonitorClass AS _GNativeVolumeMonitorClass

TYPE _GNativeVolumeMonitor
  AS GVolumeMonitor parent_instance
END TYPE

TYPE _GNativeVolumeMonitorClass
  AS GVolumeMonitorClass parent_class
  get_mount_for_mount_path AS FUNCTION(BYVAL AS CONST ZSTRING PTR, BYVAL AS GCancellable PTR) AS GMount PTR
END TYPE

DECLARE FUNCTION g_native_volume_monitor_get_type() AS GType

#ENDIF ' __G_NATIVE_VOLUME_MONITOR_H__

#IFNDEF __G_NETWORK_ADDRESS_H__
#DEFINE __G_NETWORK_ADDRESS_H__

#DEFINE G_TYPE_NETWORK_ADDRESS (g_network_address_get_type ())
#DEFINE G_NETWORK_ADDRESS(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_NETWORK_ADDRESS, GNetworkAddress))
#DEFINE G_NETWORK_ADDRESS_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_NETWORK_ADDRESS, GNetworkAddressClass))
#DEFINE G_IS_NETWORK_ADDRESS(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_NETWORK_ADDRESS))
#DEFINE G_IS_NETWORK_ADDRESS_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), G_TYPE_NETWORK_ADDRESS))
#DEFINE G_NETWORK_ADDRESS_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), G_TYPE_NETWORK_ADDRESS, GNetworkAddressClass))

TYPE GNetworkAddressClass AS _GNetworkAddressClass
TYPE GNetworkAddressPrivate AS _GNetworkAddressPrivate

TYPE _GNetworkAddress
  AS GObject parent_instance
  AS GNetworkAddressPrivate PTR priv
END TYPE

TYPE _GNetworkAddressClass
  AS GObjectClass parent_class
END TYPE

DECLARE FUNCTION g_network_address_get_type() AS GType
DECLARE FUNCTION g_network_address_new(BYVAL AS CONST gchar PTR, BYVAL AS guint16) AS GSocketConnectable PTR
DECLARE FUNCTION g_network_address_parse(BYVAL AS CONST gchar PTR, BYVAL AS guint16, BYVAL AS GError PTR PTR) AS GSocketConnectable PTR
DECLARE FUNCTION g_network_address_parse_uri(BYVAL AS CONST gchar PTR, BYVAL AS guint16, BYVAL AS GError PTR PTR) AS GSocketConnectable PTR
DECLARE FUNCTION g_network_address_get_hostname(BYVAL AS GNetworkAddress PTR) AS CONST gchar PTR
DECLARE FUNCTION g_network_address_get_port(BYVAL AS GNetworkAddress PTR) AS guint16
DECLARE FUNCTION g_network_address_get_scheme(BYVAL AS GNetworkAddress PTR) AS CONST gchar PTR

#ENDIF ' __G_NETWORK_ADDRESS_H__

#IFNDEF __G_NETWORK_MONITOR_H__
#DEFINE __G_NETWORK_MONITOR_H__

#DEFINE G_NETWORK_MONITOR_EXTENSION_POINT_NAME !"gio-network-monitor"
#DEFINE G_TYPE_NETWORK_MONITOR (g_network_monitor_get_type ())
#DEFINE G_NETWORK_MONITOR(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_NETWORK_MONITOR, GNetworkMonitor))
#DEFINE G_IS_NETWORK_MONITOR(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_NETWORK_MONITOR))
#DEFINE G_NETWORK_MONITOR_GET_INTERFACE(o) (G_TYPE_INSTANCE_GET_INTERFACE ((o), G_TYPE_NETWORK_MONITOR, GNetworkMonitorInterface))

TYPE GNetworkMonitorInterface AS _GNetworkMonitorInterface

TYPE _GNetworkMonitorInterface
  AS GTypeInterface g_iface
  network_changed AS SUB(BYVAL AS GNetworkMonitor PTR, BYVAL AS gboolean)
  can_reach AS FUNCTION(BYVAL AS GNetworkMonitor PTR, BYVAL AS GSocketConnectable PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
  can_reach_async AS SUB(BYVAL AS GNetworkMonitor PTR, BYVAL AS GSocketConnectable PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  can_reach_finish AS FUNCTION(BYVAL AS GNetworkMonitor PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
END TYPE

DECLARE FUNCTION g_network_monitor_get_type() AS GType
DECLARE FUNCTION g_network_monitor_get_default() AS GNetworkMonitor PTR
DECLARE FUNCTION g_network_monitor_get_network_available(BYVAL AS GNetworkMonitor PTR) AS gboolean
DECLARE FUNCTION g_network_monitor_can_reach(BYVAL AS GNetworkMonitor PTR, BYVAL AS GSocketConnectable PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE SUB g_network_monitor_can_reach_async(BYVAL AS GNetworkMonitor PTR, BYVAL AS GSocketConnectable PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_network_monitor_can_reach_finish(BYVAL AS GNetworkMonitor PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean

#ENDIF ' __G_NETWORK_MONITOR_H__

#IFNDEF __G_NETWORK_SERVICE_H__
#DEFINE __G_NETWORK_SERVICE_H__

#DEFINE G_TYPE_NETWORK_SERVICE (g_network_service_get_type ())
#DEFINE G_NETWORK_SERVICE(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_NETWORK_SERVICE, GNetworkService))
#DEFINE G_NETWORK_SERVICE_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_NETWORK_SERVICE, GNetworkServiceClass))
#DEFINE G_IS_NETWORK_SERVICE(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_NETWORK_SERVICE))
#DEFINE G_IS_NETWORK_SERVICE_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), G_TYPE_NETWORK_SERVICE))
#DEFINE G_NETWORK_SERVICE_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), G_TYPE_NETWORK_SERVICE, GNetworkServiceClass))

TYPE GNetworkServiceClass AS _GNetworkServiceClass
TYPE GNetworkServicePrivate AS _GNetworkServicePrivate

TYPE _GNetworkService
  AS GObject parent_instance
  AS GNetworkServicePrivate PTR priv
END TYPE

TYPE _GNetworkServiceClass
  AS GObjectClass parent_class
END TYPE

DECLARE FUNCTION g_network_service_get_type() AS GType
DECLARE FUNCTION g_network_service_new(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR) AS GSocketConnectable PTR
DECLARE FUNCTION g_network_service_get_service(BYVAL AS GNetworkService PTR) AS CONST gchar PTR
DECLARE FUNCTION g_network_service_get_protocol(BYVAL AS GNetworkService PTR) AS CONST gchar PTR
DECLARE FUNCTION g_network_service_get_domain(BYVAL AS GNetworkService PTR) AS CONST gchar PTR
DECLARE FUNCTION g_network_service_get_scheme(BYVAL AS GNetworkService PTR) AS CONST gchar PTR
DECLARE SUB g_network_service_set_scheme(BYVAL AS GNetworkService PTR, BYVAL AS CONST gchar PTR)

#ENDIF ' __G_NETWORK_SERVICE_H__

#IFNDEF __G_PERMISSION_H__
#DEFINE __G_PERMISSION_H__

#DEFINE G_TYPE_PERMISSION (g_permission_get_type ())
#DEFINE G_PERMISSION(inst) (G_TYPE_CHECK_INSTANCE_CAST ((inst), _
                                       G_TYPE_PERMISSION, GPermission))
#DEFINE G_PERMISSION_CLASS(class) (G_TYPE_CHECK_CLASS_CAST ((class), _
                                       G_TYPE_PERMISSION, GPermissionClass))
#DEFINE G_IS_PERMISSION(inst) (G_TYPE_CHECK_INSTANCE_TYPE ((inst), _
                                       G_TYPE_PERMISSION))
#DEFINE G_IS_PERMISSION_CLASS(class) (G_TYPE_CHECK_CLASS_TYPE ((class), _
                                       G_TYPE_PERMISSION))
#DEFINE G_PERMISSION_GET_CLASS(inst) (G_TYPE_INSTANCE_GET_CLASS ((inst), _
                                       G_TYPE_PERMISSION, GPermissionClass))

TYPE GPermissionPrivate AS _GPermissionPrivate
TYPE GPermissionClass AS _GPermissionClass

TYPE _GPermission
  AS GObject parent_instance
  AS GPermissionPrivate PTR priv
END TYPE

TYPE _GPermissionClass
  AS GObjectClass parent_class
  acquire AS FUNCTION(BYVAL AS GPermission PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
  acquire_async AS SUB(BYVAL AS GPermission PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  acquire_finish AS FUNCTION(BYVAL AS GPermission PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
  release AS FUNCTION(BYVAL AS GPermission PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
  release_async AS SUB(BYVAL AS GPermission PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  release_finish AS FUNCTION(BYVAL AS GPermission PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
  AS gpointer reserved(15)
END TYPE

DECLARE FUNCTION g_permission_get_type() AS GType
DECLARE FUNCTION g_permission_acquire(BYVAL AS GPermission PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE SUB g_permission_acquire_async(BYVAL AS GPermission PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_permission_acquire_finish(BYVAL AS GPermission PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_permission_release(BYVAL AS GPermission PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE SUB g_permission_release_async(BYVAL AS GPermission PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_permission_release_finish(BYVAL AS GPermission PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_permission_get_allowed(BYVAL AS GPermission PTR) AS gboolean
DECLARE FUNCTION g_permission_get_can_acquire(BYVAL AS GPermission PTR) AS gboolean
DECLARE FUNCTION g_permission_get_can_release(BYVAL AS GPermission PTR) AS gboolean
DECLARE SUB g_permission_impl_update(BYVAL AS GPermission PTR, BYVAL AS gboolean, BYVAL AS gboolean, BYVAL AS gboolean)

#ENDIF ' __G_PERMISSION_H__

#IFNDEF __G_POLLABLE_INPUT_STREAM_H__
#DEFINE __G_POLLABLE_INPUT_STREAM_H__

#DEFINE G_TYPE_POLLABLE_INPUT_STREAM (g_pollable_input_stream_get_type ())
#DEFINE G_POLLABLE_INPUT_STREAM(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), G_TYPE_POLLABLE_INPUT_STREAM, GPollableInputStream))
#DEFINE G_IS_POLLABLE_INPUT_STREAM(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), G_TYPE_POLLABLE_INPUT_STREAM))
#DEFINE G_POLLABLE_INPUT_STREAM_GET_INTERFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), G_TYPE_POLLABLE_INPUT_STREAM, GPollableInputStreamInterface))

TYPE GPollableInputStreamInterface AS _GPollableInputStreamInterface

TYPE _GPollableInputStreamInterface
  AS GTypeInterface g_iface
  can_poll AS FUNCTION(BYVAL AS GPollableInputStream PTR) AS gboolean
  is_readable AS FUNCTION(BYVAL AS GPollableInputStream PTR) AS gboolean
  create_source AS FUNCTION(BYVAL AS GPollableInputStream PTR, BYVAL AS GCancellable PTR) AS GSource PTR
  read_nonblocking AS FUNCTION(BYVAL AS GPollableInputStream PTR, BYVAL AS ANY PTR, BYVAL AS gsize, BYVAL AS GError PTR PTR) AS gssize
END TYPE

DECLARE FUNCTION g_pollable_input_stream_get_type() AS GType
DECLARE FUNCTION g_pollable_input_stream_can_poll(BYVAL AS GPollableInputStream PTR) AS gboolean
DECLARE FUNCTION g_pollable_input_stream_is_readable(BYVAL AS GPollableInputStream PTR) AS gboolean
DECLARE FUNCTION g_pollable_input_stream_create_source(BYVAL AS GPollableInputStream PTR, BYVAL AS GCancellable PTR) AS GSource PTR
DECLARE FUNCTION g_pollable_input_stream_read_nonblocking(BYVAL AS GPollableInputStream PTR, BYVAL AS ANY PTR, BYVAL AS gsize, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gssize
DECLARE FUNCTION g_pollable_source_new(BYVAL AS GObject PTR) AS GSource PTR

#ENDIF ' __G_POLLABLE_INPUT_STREAM_H__

#IFNDEF __G_POLLABLE_OUTPUT_STREAM_H__
#DEFINE __G_POLLABLE_OUTPUT_STREAM_H__

#DEFINE G_TYPE_POLLABLE_OUTPUT_STREAM (g_pollable_output_stream_get_type ())
#DEFINE G_POLLABLE_OUTPUT_STREAM(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), G_TYPE_POLLABLE_OUTPUT_STREAM, GPollableOutputStream))
#DEFINE G_IS_POLLABLE_OUTPUT_STREAM(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), G_TYPE_POLLABLE_OUTPUT_STREAM))
#DEFINE G_POLLABLE_OUTPUT_STREAM_GET_INTERFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), G_TYPE_POLLABLE_OUTPUT_STREAM, GPollableOutputStreamInterface))

TYPE GPollableOutputStreamInterface AS _GPollableOutputStreamInterface

TYPE _GPollableOutputStreamInterface
  AS GTypeInterface g_iface
  can_poll AS FUNCTION(BYVAL AS GPollableOutputStream PTR) AS gboolean
  is_writable AS FUNCTION(BYVAL AS GPollableOutputStream PTR) AS gboolean
  create_source AS FUNCTION(BYVAL AS GPollableOutputStream PTR, BYVAL AS GCancellable PTR) AS GSource PTR
  write_nonblocking AS FUNCTION(BYVAL AS GPollableOutputStream PTR, BYVAL AS CONST ANY PTR, BYVAL AS gsize, BYVAL AS GError PTR PTR) AS gssize
END TYPE

DECLARE FUNCTION g_pollable_output_stream_get_type() AS GType
DECLARE FUNCTION g_pollable_output_stream_can_poll(BYVAL AS GPollableOutputStream PTR) AS gboolean
DECLARE FUNCTION g_pollable_output_stream_is_writable(BYVAL AS GPollableOutputStream PTR) AS gboolean
DECLARE FUNCTION g_pollable_output_stream_create_source(BYVAL AS GPollableOutputStream PTR, BYVAL AS GCancellable PTR) AS GSource PTR
DECLARE FUNCTION g_pollable_output_stream_write_nonblocking(BYVAL AS GPollableOutputStream PTR, BYVAL AS CONST ANY PTR, BYVAL AS gsize, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gssize

#ENDIF ' __G_POLLABLE_OUTPUT_STREAM_H__

#IFNDEF __G_PROXY_H__
#DEFINE __G_PROXY_H__

#DEFINE G_TYPE_PROXY (g_proxy_get_type ())
#DEFINE G_PROXY(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_PROXY, GProxy))
#DEFINE G_IS_PROXY(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_PROXY))
#DEFINE G_PROXY_GET_IFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), G_TYPE_PROXY, GProxyInterface))
#DEFINE G_PROXY_EXTENSION_POINT_NAME !"gio-proxy"

TYPE GProxyInterface AS _GProxyInterface

TYPE _GProxyInterface
  AS GTypeInterface g_iface
  connect AS FUNCTION(BYVAL AS GProxy PTR, BYVAL AS GIOStream PTR, BYVAL AS GProxyAddress PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GIOStream PTR
  connect_async AS SUB(BYVAL AS GProxy PTR, BYVAL AS GIOStream PTR, BYVAL AS GProxyAddress PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  connect_finish AS FUNCTION(BYVAL AS GProxy PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GIOStream PTR
  supports_hostname AS FUNCTION(BYVAL AS GProxy PTR) AS gboolean
END TYPE

DECLARE FUNCTION g_proxy_get_type() AS GType
DECLARE FUNCTION g_proxy_get_default_for_protocol(BYVAL AS CONST gchar PTR) AS GProxy PTR
DECLARE FUNCTION g_proxy_connect(BYVAL AS GProxy PTR, BYVAL AS GIOStream PTR, BYVAL AS GProxyAddress PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GIOStream PTR
DECLARE SUB g_proxy_connect_async(BYVAL AS GProxy PTR, BYVAL AS GIOStream PTR, BYVAL AS GProxyAddress PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_proxy_connect_finish(BYVAL AS GProxy PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GIOStream PTR
DECLARE FUNCTION g_proxy_supports_hostname(BYVAL AS GProxy PTR) AS gboolean

#ENDIF ' __G_PROXY_H__

#IFNDEF __G_PROXY_ADDRESS_H__
#DEFINE __G_PROXY_ADDRESS_H__

#DEFINE G_TYPE_PROXY_ADDRESS (g_proxy_address_get_type ())
#DEFINE G_PROXY_ADDRESS(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_PROXY_ADDRESS, GProxyAddress))
#DEFINE G_PROXY_ADDRESS_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_PROXY_ADDRESS, GProxyAddressClass))
#DEFINE G_IS_PROXY_ADDRESS(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_PROXY_ADDRESS))
#DEFINE G_IS_PROXY_ADDRESS_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), G_TYPE_PROXY_ADDRESS))
#DEFINE G_PROXY_ADDRESS_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), G_TYPE_PROXY_ADDRESS, GProxyAddressClass))

TYPE GProxyAddressClass AS _GProxyAddressClass
TYPE GProxyAddressPrivate AS _GProxyAddressPrivate

TYPE _GProxyAddress
  AS GInetSocketAddress parent_instance
  AS GProxyAddressPrivate PTR priv
END TYPE

TYPE _GProxyAddressClass
  AS GInetSocketAddressClass parent_class
END TYPE

DECLARE FUNCTION g_proxy_address_get_type() AS GType
DECLARE FUNCTION g_proxy_address_new(BYVAL AS GInetAddress PTR, BYVAL AS guint16, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS guint16, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR) AS GSocketAddress PTR
DECLARE FUNCTION g_proxy_address_get_protocol(BYVAL AS GProxyAddress PTR) AS CONST gchar PTR
DECLARE FUNCTION g_proxy_address_get_destination_hostname(BYVAL AS GProxyAddress PTR) AS CONST gchar PTR
DECLARE FUNCTION g_proxy_address_get_destination_port(BYVAL AS GProxyAddress PTR) AS guint16
DECLARE FUNCTION g_proxy_address_get_username(BYVAL AS GProxyAddress PTR) AS CONST gchar PTR
DECLARE FUNCTION g_proxy_address_get_password(BYVAL AS GProxyAddress PTR) AS CONST gchar PTR

#ENDIF ' __G_PROXY_ADDRESS_H__

#IFNDEF __G_PROXY_ADDRESS_ENUMERATOR_H__
#DEFINE __G_PROXY_ADDRESS_ENUMERATOR_H__

#IFNDEF __G_SOCKET_ADDRESS_ENUMERATOR_H__
#DEFINE __G_SOCKET_ADDRESS_ENUMERATOR_H__

#DEFINE G_TYPE_SOCKET_ADDRESS_ENUMERATOR (g_socket_address_enumerator_get_type ())
#DEFINE G_SOCKET_ADDRESS_ENUMERATOR(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_SOCKET_ADDRESS_ENUMERATOR, GSocketAddressEnumerator))
#DEFINE G_SOCKET_ADDRESS_ENUMERATOR_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_SOCKET_ADDRESS_ENUMERATOR, GSocketAddressEnumeratorClass))
#DEFINE G_IS_SOCKET_ADDRESS_ENUMERATOR(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_SOCKET_ADDRESS_ENUMERATOR))
#DEFINE G_IS_SOCKET_ADDRESS_ENUMERATOR_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), G_TYPE_SOCKET_ADDRESS_ENUMERATOR))
#DEFINE G_SOCKET_ADDRESS_ENUMERATOR_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), G_TYPE_SOCKET_ADDRESS_ENUMERATOR, GSocketAddressEnumeratorClass))

TYPE GSocketAddressEnumeratorClass AS _GSocketAddressEnumeratorClass

TYPE _GSocketAddressEnumerator
  AS GObject parent_instance
END TYPE

TYPE _GSocketAddressEnumeratorClass
  AS GObjectClass parent_class
  next_ AS FUNCTION(BYVAL AS GSocketAddressEnumerator PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GSocketAddress PTR
  next_async AS SUB(BYVAL AS GSocketAddressEnumerator PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  next_finish AS FUNCTION(BYVAL AS GSocketAddressEnumerator PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GSocketAddress PTR
END TYPE

DECLARE FUNCTION g_socket_address_enumerator_get_type() AS GType
DECLARE FUNCTION g_socket_address_enumerator_next(BYVAL AS GSocketAddressEnumerator PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GSocketAddress PTR
DECLARE SUB g_socket_address_enumerator_next_async(BYVAL AS GSocketAddressEnumerator PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_socket_address_enumerator_next_finish(BYVAL AS GSocketAddressEnumerator PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GSocketAddress PTR

#ENDIF ' __G_SOCKET_ADDRESS_ENUMERATOR_H__

#DEFINE G_TYPE_PROXY_ADDRESS_ENUMERATOR (g_proxy_address_enumerator_get_type ())
#DEFINE G_PROXY_ADDRESS_ENUMERATOR(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_PROXY_ADDRESS_ENUMERATOR, GProxyAddressEnumerator))
#DEFINE G_PROXY_ADDRESS_ENUMERATOR_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_PROXY_ADDRESS_ENUMERATOR, GProxyAddressEnumeratorClass))
#DEFINE G_IS_PROXY_ADDRESS_ENUMERATOR(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_PROXY_ADDRESS_ENUMERATOR))
#DEFINE G_IS_PROXY_ADDRESS_ENUMERATOR_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), G_TYPE_PROXY_ADDRESS_ENUMERATOR))
#DEFINE G_PROXY_ADDRESS_ENUMERATOR_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), G_TYPE_PROXY_ADDRESS_ENUMERATOR, GProxyAddressEnumeratorClass))

TYPE GProxyAddressEnumeratorClass AS _GProxyAddressEnumeratorClass
TYPE GProxyAddressEnumeratorPrivate AS _GProxyAddressEnumeratorPrivate

TYPE _GProxyAddressEnumerator
  AS GSocketAddressEnumerator parent_instance
  AS GProxyAddressEnumeratorPrivate PTR priv
END TYPE

TYPE _GProxyAddressEnumeratorClass
  AS GSocketAddressEnumeratorClass parent_class
  _g_reserved1 AS SUB()
  _g_reserved2 AS SUB()
  _g_reserved3 AS SUB()
  _g_reserved4 AS SUB()
  _g_reserved5 AS SUB()
  _g_reserved6 AS SUB()
  _g_reserved7 AS SUB()
END TYPE

DECLARE FUNCTION g_proxy_address_enumerator_get_type() AS GType

#ENDIF ' __G_PROXY_ADDRESS_ENUMERATOR_H__

#IFNDEF __G_PROXY_RESOLVER_H__
#DEFINE __G_PROXY_RESOLVER_H__

#DEFINE G_TYPE_PROXY_RESOLVER (g_proxy_resolver_get_type ())
#DEFINE G_PROXY_RESOLVER(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_PROXY_RESOLVER, GProxyResolver))
#DEFINE G_IS_PROXY_RESOLVER(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_PROXY_RESOLVER))
#DEFINE G_PROXY_RESOLVER_GET_IFACE(o) (G_TYPE_INSTANCE_GET_INTERFACE ((o), G_TYPE_PROXY_RESOLVER, GProxyResolverInterface))
#DEFINE G_PROXY_RESOLVER_EXTENSION_POINT_NAME !"gio-proxy-resolver"

TYPE GProxyResolverInterface AS _GProxyResolverInterface

TYPE _GProxyResolverInterface
  AS GTypeInterface g_iface
  is_supported AS FUNCTION(BYVAL AS GProxyResolver PTR) AS gboolean
  lookup AS FUNCTION(BYVAL AS GProxyResolver PTR, BYVAL AS CONST gchar PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gchar PTR PTR
  lookup_async AS SUB(BYVAL AS GProxyResolver PTR, BYVAL AS CONST gchar PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  lookup_finish AS FUNCTION(BYVAL AS GProxyResolver PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gchar PTR PTR
END TYPE

DECLARE FUNCTION g_proxy_resolver_get_type() AS GType
DECLARE FUNCTION g_proxy_resolver_get_default() AS GProxyResolver PTR
DECLARE FUNCTION g_proxy_resolver_is_supported(BYVAL AS GProxyResolver PTR) AS gboolean
DECLARE FUNCTION g_proxy_resolver_lookup(BYVAL AS GProxyResolver PTR, BYVAL AS CONST gchar PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gchar PTR PTR
DECLARE SUB g_proxy_resolver_lookup_async(BYVAL AS GProxyResolver PTR, BYVAL AS CONST gchar PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_proxy_resolver_lookup_finish(BYVAL AS GProxyResolver PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gchar PTR PTR

#ENDIF ' __G_PROXY_RESOLVER_H__

#IFNDEF __G_RESOLVER_H__
#DEFINE __G_RESOLVER_H__

#DEFINE G_TYPE_RESOLVER (g_resolver_get_type ())
#DEFINE G_RESOLVER(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_RESOLVER, GResolver))
#DEFINE G_RESOLVER_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_RESOLVER, GResolverClass))
#DEFINE G_IS_RESOLVER(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_RESOLVER))
#DEFINE G_IS_RESOLVER_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), G_TYPE_RESOLVER))
#DEFINE G_RESOLVER_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), G_TYPE_RESOLVER, GResolverClass))

TYPE GResolverPrivate AS _GResolverPrivate
TYPE GResolverClass AS _GResolverClass

TYPE _GResolver
  AS GObject parent_instance
  AS GResolverPrivate PTR priv
END TYPE

TYPE _GResolverClass
  AS GObjectClass parent_class
  reload AS SUB(BYVAL AS GResolver PTR)
  lookup_by_name AS FUNCTION(BYVAL AS GResolver PTR, BYVAL AS CONST gchar PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GList PTR
  lookup_by_name_async AS SUB(BYVAL AS GResolver PTR, BYVAL AS CONST gchar PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  lookup_by_name_finish AS FUNCTION(BYVAL AS GResolver PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GList PTR
  lookup_by_address AS FUNCTION(BYVAL AS GResolver PTR, BYVAL AS GInetAddress PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gchar PTR
  lookup_by_address_async AS SUB(BYVAL AS GResolver PTR, BYVAL AS GInetAddress PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  lookup_by_address_finish AS FUNCTION(BYVAL AS GResolver PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gchar PTR
  lookup_service AS FUNCTION(BYVAL AS GResolver PTR, BYVAL AS CONST gchar PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GList PTR
  lookup_service_async AS SUB(BYVAL AS GResolver PTR, BYVAL AS CONST gchar PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  lookup_service_finish AS FUNCTION(BYVAL AS GResolver PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GList PTR
  _g_reserved1 AS SUB()
  _g_reserved2 AS SUB()
  _g_reserved3 AS SUB()
  _g_reserved4 AS SUB()
  _g_reserved5 AS SUB()
  _g_reserved6 AS SUB()
END TYPE

DECLARE FUNCTION g_resolver_get_type() AS GType
DECLARE FUNCTION g_resolver_get_default() AS GResolver PTR
DECLARE SUB g_resolver_set_default(BYVAL AS GResolver PTR)
DECLARE FUNCTION g_resolver_lookup_by_name(BYVAL AS GResolver PTR, BYVAL AS CONST gchar PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GList PTR
DECLARE SUB g_resolver_lookup_by_name_async(BYVAL AS GResolver PTR, BYVAL AS CONST gchar PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_resolver_lookup_by_name_finish(BYVAL AS GResolver PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GList PTR
DECLARE SUB g_resolver_free_addresses(BYVAL AS GList PTR)
DECLARE FUNCTION g_resolver_lookup_by_address(BYVAL AS GResolver PTR, BYVAL AS GInetAddress PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gchar PTR
DECLARE SUB g_resolver_lookup_by_address_async(BYVAL AS GResolver PTR, BYVAL AS GInetAddress PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_resolver_lookup_by_address_finish(BYVAL AS GResolver PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gchar PTR
DECLARE FUNCTION g_resolver_lookup_service(BYVAL AS GResolver PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GList PTR
DECLARE SUB g_resolver_lookup_service_async(BYVAL AS GResolver PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_resolver_lookup_service_finish(BYVAL AS GResolver PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GList PTR
DECLARE SUB g_resolver_free_targets(BYVAL AS GList PTR)

#DEFINE G_RESOLVER_ERROR (g_resolver_error_quark ())

DECLARE FUNCTION g_resolver_error_quark() AS GQuark

#ENDIF ' __G_RESOLVER_H__

#IFNDEF __G_SEEKABLE_H__
#DEFINE __G_SEEKABLE_H__

#DEFINE G_TYPE_SEEKABLE (g_seekable_get_type ())
#DEFINE G_SEEKABLE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), G_TYPE_SEEKABLE, GSeekable))
#DEFINE G_IS_SEEKABLE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), G_TYPE_SEEKABLE))
#DEFINE G_SEEKABLE_GET_IFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), G_TYPE_SEEKABLE, GSeekableIface))

TYPE GSeekableIface AS _GSeekableIface

TYPE _GSeekableIface
  AS GTypeInterface g_iface
  tell AS FUNCTION(BYVAL AS GSeekable PTR) AS goffset
  can_seek AS FUNCTION(BYVAL AS GSeekable PTR) AS gboolean
  seek_ AS FUNCTION(BYVAL AS GSeekable PTR, BYVAL AS goffset, BYVAL AS GSeekType, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
  can_truncate AS FUNCTION(BYVAL AS GSeekable PTR) AS gboolean
  truncate_fn AS FUNCTION(BYVAL AS GSeekable PTR, BYVAL AS goffset, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
END TYPE

DECLARE FUNCTION g_seekable_get_type() AS GType
DECLARE FUNCTION g_seekable_tell(BYVAL AS GSeekable PTR) AS goffset
DECLARE FUNCTION g_seekable_can_seek(BYVAL AS GSeekable PTR) AS gboolean
DECLARE FUNCTION g_seekable_seek(BYVAL AS GSeekable PTR, BYVAL AS goffset, BYVAL AS GSeekType, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_seekable_can_truncate(BYVAL AS GSeekable PTR) AS gboolean
DECLARE FUNCTION g_seekable_truncate(BYVAL AS GSeekable PTR, BYVAL AS goffset, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean

#ENDIF ' __G_SEEKABLE_H__

#IFNDEF __G_SETTINGS_SCHEMA_H__
#DEFINE __G_SETTINGS_SCHEMA_H__

TYPE GSettingsSchemaSource AS _GSettingsSchemaSource
TYPE GSettingsSchema AS _GSettingsSchema

#DEFINE G_TYPE_SETTINGS_SCHEMA_SOURCE (g_settings_schema_source_get_type ())

DECLARE FUNCTION g_settings_schema_source_get_type() AS GType
DECLARE FUNCTION g_settings_schema_source_get_default() AS GSettingsSchemaSource PTR
DECLARE FUNCTION g_settings_schema_source_ref(BYVAL AS GSettingsSchemaSource PTR) AS GSettingsSchemaSource PTR
DECLARE SUB g_settings_schema_source_unref(BYVAL AS GSettingsSchemaSource PTR)
DECLARE FUNCTION g_settings_schema_source_new_from_directory(BYVAL AS CONST gchar PTR, BYVAL AS GSettingsSchemaSource PTR, BYVAL AS gboolean, BYVAL AS GError PTR PTR) AS GSettingsSchemaSource PTR
DECLARE FUNCTION g_settings_schema_source_lookup(BYVAL AS GSettingsSchemaSource PTR, BYVAL AS CONST gchar PTR, BYVAL AS gboolean) AS GSettingsSchema PTR

#DEFINE G_TYPE_SETTINGS_SCHEMA (g_settings_schema_get_type ())

DECLARE FUNCTION g_settings_schema_get_type() AS GType
DECLARE FUNCTION g_settings_schema_ref(BYVAL AS GSettingsSchema PTR) AS GSettingsSchema PTR
DECLARE SUB g_settings_schema_unref(BYVAL AS GSettingsSchema PTR)
DECLARE FUNCTION g_settings_schema_get_id(BYVAL AS GSettingsSchema PTR) AS CONST gchar PTR
DECLARE FUNCTION g_settings_schema_get_path(BYVAL AS GSettingsSchema PTR) AS CONST gchar PTR

#ENDIF ' __G_SETTINGS_SCHEMA_H__

#IFNDEF __G_SETTINGS_H__
#DEFINE __G_SETTINGS_H__

#DEFINE G_TYPE_SETTINGS (g_settings_get_type ())
#DEFINE G_SETTINGS(inst) (G_TYPE_CHECK_INSTANCE_CAST ((inst), _
                                                             G_TYPE_SETTINGS, GSettings))
#DEFINE G_SETTINGS_CLASS(class) (G_TYPE_CHECK_CLASS_CAST ((class), _
                                                             G_TYPE_SETTINGS, GSettingsClass))
#DEFINE G_IS_SETTINGS(inst) (G_TYPE_CHECK_INSTANCE_TYPE ((inst), G_TYPE_SETTINGS))
#DEFINE G_IS_SETTINGS_CLASS(class) (G_TYPE_CHECK_CLASS_TYPE ((class), G_TYPE_SETTINGS))
#DEFINE G_SETTINGS_GET_CLASS(inst) (G_TYPE_INSTANCE_GET_CLASS ((inst), _
                                                             G_TYPE_SETTINGS, GSettingsClass))

TYPE GSettingsPrivate AS _GSettingsPrivate
TYPE GSettingsClass AS _GSettingsClass

TYPE _GSettingsClass
  AS GObjectClass parent_class
  writable_changed AS SUB(BYVAL AS GSettings PTR, BYVAL AS CONST gchar PTR)
  changed AS SUB(BYVAL AS GSettings PTR, BYVAL AS CONST gchar PTR)
  writable_change_event AS FUNCTION(BYVAL AS GSettings PTR, BYVAL AS GQuark) AS gboolean
  change_event AS FUNCTION(BYVAL AS GSettings PTR, BYVAL AS CONST GQuark PTR, BYVAL AS gint) AS gboolean
  AS gpointer padding(19)
END TYPE

TYPE _GSettings
  AS GObject parent_instance
  AS GSettingsPrivate PTR priv
END TYPE

DECLARE FUNCTION g_settings_get_type() AS GType
DECLARE FUNCTION g_settings_list_schemas() AS CONST gchar CONST PTR PTR
DECLARE FUNCTION g_settings_list_relocatable_schemas() AS CONST gchar CONST PTR PTR
DECLARE FUNCTION g_settings_new(BYVAL AS CONST gchar PTR) AS GSettings PTR
DECLARE FUNCTION g_settings_new_with_path(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR) AS GSettings PTR
DECLARE FUNCTION g_settings_new_with_backend(BYVAL AS CONST gchar PTR, BYVAL AS GSettingsBackend PTR) AS GSettings PTR
DECLARE FUNCTION g_settings_new_with_backend_and_path(BYVAL AS CONST gchar PTR, BYVAL AS GSettingsBackend PTR, BYVAL AS CONST gchar PTR) AS GSettings PTR
DECLARE FUNCTION g_settings_new_full(BYVAL AS GSettingsSchema PTR, BYVAL AS GSettingsBackend PTR, BYVAL AS CONST gchar PTR) AS GSettings PTR
DECLARE FUNCTION g_settings_list_children(BYVAL AS GSettings PTR) AS gchar PTR PTR
DECLARE FUNCTION g_settings_list_keys(BYVAL AS GSettings PTR) AS gchar PTR PTR
DECLARE FUNCTION g_settings_get_range(BYVAL AS GSettings PTR, BYVAL AS CONST gchar PTR) AS GVariant PTR
DECLARE FUNCTION g_settings_range_check(BYVAL AS GSettings PTR, BYVAL AS CONST gchar PTR, BYVAL AS GVariant PTR) AS gboolean
DECLARE FUNCTION g_settings_set_value(BYVAL AS GSettings PTR, BYVAL AS CONST gchar PTR, BYVAL AS GVariant PTR) AS gboolean
DECLARE FUNCTION g_settings_get_value(BYVAL AS GSettings PTR, BYVAL AS CONST gchar PTR) AS GVariant PTR
DECLARE FUNCTION g_settings_set(BYVAL AS GSettings PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, ...) AS gboolean
DECLARE SUB g_settings_get(BYVAL AS GSettings PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, ...)
DECLARE SUB g_settings_reset(BYVAL AS GSettings PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION g_settings_get_int(BYVAL AS GSettings PTR, BYVAL AS CONST gchar PTR) AS gint
DECLARE FUNCTION g_settings_set_int(BYVAL AS GSettings PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint) AS gboolean
DECLARE FUNCTION g_settings_get_uint(BYVAL AS GSettings PTR, BYVAL AS CONST gchar PTR) AS guint
DECLARE FUNCTION g_settings_set_uint(BYVAL AS GSettings PTR, BYVAL AS CONST gchar PTR, BYVAL AS guint) AS gboolean
DECLARE FUNCTION g_settings_get_string(BYVAL AS GSettings PTR, BYVAL AS CONST gchar PTR) AS gchar PTR
DECLARE FUNCTION g_settings_set_string(BYVAL AS GSettings PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR) AS gboolean
DECLARE FUNCTION g_settings_get_boolean(BYVAL AS GSettings PTR, BYVAL AS CONST gchar PTR) AS gboolean
DECLARE FUNCTION g_settings_set_boolean(BYVAL AS GSettings PTR, BYVAL AS CONST gchar PTR, BYVAL AS gboolean) AS gboolean
DECLARE FUNCTION g_settings_get_double(BYVAL AS GSettings PTR, BYVAL AS CONST gchar PTR) AS gdouble
DECLARE FUNCTION g_settings_set_double(BYVAL AS GSettings PTR, BYVAL AS CONST gchar PTR, BYVAL AS gdouble) AS gboolean
DECLARE FUNCTION g_settings_get_strv(BYVAL AS GSettings PTR, BYVAL AS CONST gchar PTR) AS gchar PTR PTR
DECLARE FUNCTION g_settings_set_strv(BYVAL AS GSettings PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar CONST PTR PTR) AS gboolean
DECLARE FUNCTION g_settings_get_enum(BYVAL AS GSettings PTR, BYVAL AS CONST gchar PTR) AS gint
DECLARE FUNCTION g_settings_set_enum(BYVAL AS GSettings PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint) AS gboolean
DECLARE FUNCTION g_settings_get_flags(BYVAL AS GSettings PTR, BYVAL AS CONST gchar PTR) AS guint
DECLARE FUNCTION g_settings_set_flags(BYVAL AS GSettings PTR, BYVAL AS CONST gchar PTR, BYVAL AS guint) AS gboolean
DECLARE FUNCTION g_settings_get_child(BYVAL AS GSettings PTR, BYVAL AS CONST gchar PTR) AS GSettings PTR
DECLARE FUNCTION g_settings_is_writable(BYVAL AS GSettings PTR, BYVAL AS CONST gchar PTR) AS gboolean
DECLARE SUB g_settings_delay(BYVAL AS GSettings PTR)
DECLARE SUB g_settings_apply(BYVAL AS GSettings PTR)
DECLARE SUB g_settings_revert(BYVAL AS GSettings PTR)
DECLARE FUNCTION g_settings_get_has_unapplied(BYVAL AS GSettings PTR) AS gboolean
DECLARE SUB g_settings_sync()

TYPE GSettingsBindSetMapping AS FUNCTION(BYVAL AS CONST GValue PTR, BYVAL AS CONST GVariantType PTR, BYVAL AS gpointer) AS GVariant PTR
TYPE GSettingsBindGetMapping AS FUNCTION(BYVAL AS GValue PTR, BYVAL AS GVariant PTR, BYVAL AS gpointer) AS gboolean
TYPE GSettingsGetMapping AS FUNCTION(BYVAL AS GVariant PTR, BYVAL AS gpointer PTR, BYVAL AS gpointer) AS gboolean

ENUM GSettingsBindFlags
  G_SETTINGS_BIND_DEFAULT
  G_SETTINGS_BIND_GET = (1 SHL 0)
  G_SETTINGS_BIND_SET = (1 SHL 1)
  G_SETTINGS_BIND_NO_SENSITIVITY = (1 SHL 2)
  G_SETTINGS_BIND_GET_NO_CHANGES = (1 SHL 3)
  G_SETTINGS_BIND_INVERT_BOOLEAN = (1 SHL 4)
END ENUM

DECLARE SUB g_settings_bind(BYVAL AS GSettings PTR, BYVAL AS CONST gchar PTR, BYVAL AS gpointer, BYVAL AS CONST gchar PTR, BYVAL AS GSettingsBindFlags)
DECLARE SUB g_settings_bind_with_mapping(BYVAL AS GSettings PTR, BYVAL AS CONST gchar PTR, BYVAL AS gpointer, BYVAL AS CONST gchar PTR, BYVAL AS GSettingsBindFlags, BYVAL AS GSettingsBindGetMapping, BYVAL AS GSettingsBindSetMapping, BYVAL AS gpointer, BYVAL AS GDestroyNotify)
DECLARE SUB g_settings_bind_writable(BYVAL AS GSettings PTR, BYVAL AS CONST gchar PTR, BYVAL AS gpointer, BYVAL AS CONST gchar PTR, BYVAL AS gboolean)
DECLARE SUB g_settings_unbind(BYVAL AS gpointer, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION g_settings_get_mapped(BYVAL AS GSettings PTR, BYVAL AS CONST gchar PTR, BYVAL AS GSettingsGetMapping, BYVAL AS gpointer) AS gpointer

#ENDIF ' __G_SETTINGS_H__

#IFNDEF __G_SIMPLE_ACTION_H__
#DEFINE __G_SIMPLE_ACTION_H__

#DEFINE G_TYPE_SIMPLE_ACTION (g_simple_action_get_type ())
#DEFINE G_SIMPLE_ACTION(inst) (G_TYPE_CHECK_INSTANCE_CAST ((inst), _
                                                             G_TYPE_SIMPLE_ACTION, GSimpleAction))
#DEFINE G_IS_SIMPLE_ACTION(inst) (G_TYPE_CHECK_INSTANCE_TYPE ((inst), _
                                                             G_TYPE_SIMPLE_ACTION))

DECLARE FUNCTION g_simple_action_get_type() AS GType
DECLARE FUNCTION g_simple_action_new(BYVAL AS CONST gchar PTR, BYVAL AS CONST GVariantType PTR) AS GSimpleAction PTR
DECLARE FUNCTION g_simple_action_new_stateful(BYVAL AS CONST gchar PTR, BYVAL AS CONST GVariantType PTR, BYVAL AS GVariant PTR) AS GSimpleAction PTR
DECLARE SUB g_simple_action_set_enabled(BYVAL AS GSimpleAction PTR, BYVAL AS gboolean)
DECLARE SUB g_simple_action_set_state(BYVAL AS GSimpleAction PTR, BYVAL AS GVariant PTR)

#ENDIF ' __G_SIMPLE_ACTION_H__

' 002 start from: glib-2.31.4/gio/gio.h ==> glib-2.31.4/gio/gsimpleactiongroup.h

#IFNDEF __G_SIMPLE_ACTION_GROUP_H__
#DEFINE __G_SIMPLE_ACTION_GROUP_H__

#DEFINE G_TYPE_SIMPLE_ACTION_GROUP (g_simple_action_group_get_type ())
#DEFINE G_SIMPLE_ACTION_GROUP(inst) (G_TYPE_CHECK_INSTANCE_CAST ((inst), _
                                                             G_TYPE_SIMPLE_ACTION_GROUP, GSimpleActionGroup))
#DEFINE G_SIMPLE_ACTION_GROUP_CLASS(class) (G_TYPE_CHECK_CLASS_CAST ((class), _
                                                             G_TYPE_SIMPLE_ACTION_GROUP, GSimpleActionGroupClass))
#DEFINE G_IS_SIMPLE_ACTION_GROUP(inst) (G_TYPE_CHECK_INSTANCE_TYPE ((inst), _
                                                             G_TYPE_SIMPLE_ACTION_GROUP))
#DEFINE G_IS_SIMPLE_ACTION_GROUP_CLASS(class) (G_TYPE_CHECK_CLASS_TYPE ((class), _
                                                             G_TYPE_SIMPLE_ACTION_GROUP))
#DEFINE G_SIMPLE_ACTION_GROUP_GET_CLASS(inst) (G_TYPE_INSTANCE_GET_CLASS ((inst), _
                                                             G_TYPE_SIMPLE_ACTION_GROUP, GSimpleActionGroupClass))

TYPE GSimpleActionGroupPrivate AS _GSimpleActionGroupPrivate
TYPE GSimpleActionGroupClass AS _GSimpleActionGroupClass

TYPE _GSimpleActionGroup
  AS GObject parent_instance
  AS GSimpleActionGroupPrivate PTR priv
END TYPE

TYPE _GSimpleActionGroupClass
  AS GObjectClass parent_class
  AS gpointer padding(11)
END TYPE

DECLARE FUNCTION g_simple_action_group_get_type() AS GType
DECLARE FUNCTION g_simple_action_group_new() AS GSimpleActionGroup PTR
DECLARE FUNCTION g_simple_action_group_lookup(BYVAL AS GSimpleActionGroup PTR, BYVAL AS CONST gchar PTR) AS GAction PTR
DECLARE SUB g_simple_action_group_insert(BYVAL AS GSimpleActionGroup PTR, BYVAL AS GAction PTR)
DECLARE SUB g_simple_action_group_remove(BYVAL AS GSimpleActionGroup PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB g_simple_action_group_add_entries(BYVAL AS GSimpleActionGroup PTR, BYVAL AS CONST GActionEntry PTR, BYVAL AS gint, BYVAL AS gpointer)

#ENDIF ' __G_SIMPLE_ACTION_GROUP_H__

#IFNDEF __G_SIMPLE_ASYNC_RESULT_H__
#DEFINE __G_SIMPLE_ASYNC_RESULT_H__

#DEFINE G_TYPE_SIMPLE_ASYNC_RESULT (g_simple_async_result_get_type ())
#DEFINE G_SIMPLE_ASYNC_RESULT(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_SIMPLE_ASYNC_RESULT, GSimpleAsyncResult))
#DEFINE G_SIMPLE_ASYNC_RESULT_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_SIMPLE_ASYNC_RESULT, GSimpleAsyncResultClass))
#DEFINE G_IS_SIMPLE_ASYNC_RESULT(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_SIMPLE_ASYNC_RESULT))
#DEFINE G_IS_SIMPLE_ASYNC_RESULT_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), G_TYPE_SIMPLE_ASYNC_RESULT))
#DEFINE G_SIMPLE_ASYNC_RESULT_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), G_TYPE_SIMPLE_ASYNC_RESULT, GSimpleAsyncResultClass))

TYPE GSimpleAsyncResultClass AS _GSimpleAsyncResultClass

DECLARE FUNCTION g_simple_async_result_get_type() AS GType
DECLARE FUNCTION g_simple_async_result_new(BYVAL AS GObject PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer, BYVAL AS gpointer) AS GSimpleAsyncResult PTR
DECLARE FUNCTION g_simple_async_result_new_error(BYVAL AS GObject PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer, BYVAL AS GQuark, BYVAL AS gint, BYVAL AS CONST ZSTRING PTR, ...) AS GSimpleAsyncResult PTR
DECLARE FUNCTION g_simple_async_result_new_from_error(BYVAL AS GObject PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer, BYVAL AS CONST GError PTR) AS GSimpleAsyncResult PTR
DECLARE FUNCTION g_simple_async_result_new_take_error(BYVAL AS GObject PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer, BYVAL AS GError PTR) AS GSimpleAsyncResult PTR
DECLARE SUB g_simple_async_result_set_op_res_gpointer(BYVAL AS GSimpleAsyncResult PTR, BYVAL AS gpointer, BYVAL AS GDestroyNotify)
DECLARE FUNCTION g_simple_async_result_get_op_res_gpointer(BYVAL AS GSimpleAsyncResult PTR) AS gpointer
DECLARE SUB g_simple_async_result_set_op_res_gssize(BYVAL AS GSimpleAsyncResult PTR, BYVAL AS gssize)
DECLARE FUNCTION g_simple_async_result_get_op_res_gssize(BYVAL AS GSimpleAsyncResult PTR) AS gssize
DECLARE SUB g_simple_async_result_set_op_res_gboolean(BYVAL AS GSimpleAsyncResult PTR, BYVAL AS gboolean)
DECLARE FUNCTION g_simple_async_result_get_op_res_gboolean(BYVAL AS GSimpleAsyncResult PTR) AS gboolean
DECLARE FUNCTION g_simple_async_result_get_source_tag(BYVAL AS GSimpleAsyncResult PTR) AS gpointer
DECLARE SUB g_simple_async_result_set_handle_cancellation(BYVAL AS GSimpleAsyncResult PTR, BYVAL AS gboolean)
DECLARE SUB g_simple_async_result_complete(BYVAL AS GSimpleAsyncResult PTR)
DECLARE SUB g_simple_async_result_complete_in_idle(BYVAL AS GSimpleAsyncResult PTR)
DECLARE SUB g_simple_async_result_run_in_thread(BYVAL AS GSimpleAsyncResult PTR, BYVAL AS GSimpleAsyncThreadFunc, BYVAL AS INTEGER, BYVAL AS GCancellable PTR)
DECLARE SUB g_simple_async_result_set_from_error(BYVAL AS GSimpleAsyncResult PTR, BYVAL AS CONST GError PTR)
DECLARE SUB g_simple_async_result_take_error(BYVAL AS GSimpleAsyncResult PTR, BYVAL AS GError PTR)
DECLARE FUNCTION g_simple_async_result_propagate_error(BYVAL AS GSimpleAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE SUB g_simple_async_result_set_error(BYVAL AS GSimpleAsyncResult PTR, BYVAL AS GQuark, BYVAL AS gint, BYVAL AS CONST ZSTRING PTR, ...)
DECLARE SUB g_simple_async_result_set_error_va(BYVAL AS GSimpleAsyncResult PTR, BYVAL AS GQuark, BYVAL AS gint, BYVAL AS CONST ZSTRING PTR, BYVAL AS va_list)
DECLARE FUNCTION g_simple_async_result_is_valid(BYVAL AS GAsyncResult PTR, BYVAL AS GObject PTR, BYVAL AS gpointer) AS gboolean
DECLARE SUB g_simple_async_report_error_in_idle(BYVAL AS GObject PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer, BYVAL AS GQuark, BYVAL AS gint, BYVAL AS CONST ZSTRING PTR, ...)
DECLARE SUB g_simple_async_report_gerror_in_idle(BYVAL AS GObject PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer, BYVAL AS CONST GError PTR)
DECLARE SUB g_simple_async_report_take_gerror_in_idle(BYVAL AS GObject PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer, BYVAL AS GError PTR)

#ENDIF ' __G_SIMPLE_ASYNC_RESULT_H__

#IFNDEF __G_SIMPLE_PERMISSION_H__
#DEFINE __G_SIMPLE_PERMISSION_H__

#DEFINE G_TYPE_SIMPLE_PERMISSION (g_simple_permission_get_type ())
#DEFINE G_SIMPLE_PERMISSION(inst) (G_TYPE_CHECK_INSTANCE_CAST ((inst), _
                                       G_TYPE_SIMPLE_PERMISSION, _
                                       GSimplePermission))
#DEFINE G_IS_SIMPLE_PERMISSION(inst) (G_TYPE_CHECK_INSTANCE_TYPE ((inst), _
                                       G_TYPE_SIMPLE_PERMISSION))

DECLARE FUNCTION g_simple_permission_get_type() AS GType
DECLARE FUNCTION g_simple_permission_new(BYVAL AS gboolean) AS GPermission PTR

#ENDIF ' __G_SIMPLE_PERMISSION_H__

#IFNDEF __G_SOCKET_CLIENT_H__
#DEFINE __G_SOCKET_CLIENT_H__

#DEFINE G_TYPE_SOCKET_CLIENT (g_socket_client_get_type ())
#DEFINE G_SOCKET_CLIENT(inst) (G_TYPE_CHECK_INSTANCE_CAST ((inst), _
                                                             G_TYPE_SOCKET_CLIENT, GSocketClient))
#DEFINE G_SOCKET_CLIENT_CLASS(class) (G_TYPE_CHECK_CLASS_CAST ((class), _
                                                             G_TYPE_SOCKET_CLIENT, GSocketClientClass))
#DEFINE G_IS_SOCKET_CLIENT(inst) (G_TYPE_CHECK_INSTANCE_TYPE ((inst), _
                                                             G_TYPE_SOCKET_CLIENT))
#DEFINE G_IS_SOCKET_CLIENT_CLASS(class) (G_TYPE_CHECK_CLASS_TYPE ((class), _
                                                             G_TYPE_SOCKET_CLIENT))
#DEFINE G_SOCKET_CLIENT_GET_CLASS(inst) (G_TYPE_INSTANCE_GET_CLASS ((inst), _
                                                             G_TYPE_SOCKET_CLIENT, GSocketClientClass))

TYPE GSocketClientPrivate AS _GSocketClientPrivate
TYPE GSocketClientClass AS _GSocketClientClass

TYPE _GSocketClientClass
  AS GObjectClass parent_class
  _g_reserved1 AS SUB()
  _g_reserved2 AS SUB()
  _g_reserved3 AS SUB()
  _g_reserved4 AS SUB()
  _g_reserved5 AS SUB()
END TYPE

TYPE _GSocketClient
  AS GObject parent_instance
  AS GSocketClientPrivate PTR priv
END TYPE

DECLARE FUNCTION g_socket_client_get_type() AS GType
DECLARE FUNCTION g_socket_client_new() AS GSocketClient PTR
DECLARE FUNCTION g_socket_client_get_family(BYVAL AS GSocketClient PTR) AS GSocketFamily
DECLARE SUB g_socket_client_set_family(BYVAL AS GSocketClient PTR, BYVAL AS GSocketFamily)
DECLARE FUNCTION g_socket_client_get_socket_type(BYVAL AS GSocketClient PTR) AS GSocketType
DECLARE SUB g_socket_client_set_socket_type(BYVAL AS GSocketClient PTR, BYVAL AS GSocketType)
DECLARE FUNCTION g_socket_client_get_protocol(BYVAL AS GSocketClient PTR) AS GSocketProtocol
DECLARE SUB g_socket_client_set_protocol(BYVAL AS GSocketClient PTR, BYVAL AS GSocketProtocol)
DECLARE FUNCTION g_socket_client_get_local_address(BYVAL AS GSocketClient PTR) AS GSocketAddress PTR
DECLARE SUB g_socket_client_set_local_address(BYVAL AS GSocketClient PTR, BYVAL AS GSocketAddress PTR)
DECLARE FUNCTION g_socket_client_get_timeout(BYVAL AS GSocketClient PTR) AS guint
DECLARE SUB g_socket_client_set_timeout(BYVAL AS GSocketClient PTR, BYVAL AS guint)
DECLARE FUNCTION g_socket_client_get_enable_proxy(BYVAL AS GSocketClient PTR) AS gboolean
DECLARE SUB g_socket_client_set_enable_proxy(BYVAL AS GSocketClient PTR, BYVAL AS gboolean)
DECLARE FUNCTION g_socket_client_get_tls(BYVAL AS GSocketClient PTR) AS gboolean
DECLARE SUB g_socket_client_set_tls(BYVAL AS GSocketClient PTR, BYVAL AS gboolean)
DECLARE FUNCTION g_socket_client_get_tls_validation_flags(BYVAL AS GSocketClient PTR) AS GTlsCertificateFlags
DECLARE SUB g_socket_client_set_tls_validation_flags(BYVAL AS GSocketClient PTR, BYVAL AS GTlsCertificateFlags)
DECLARE FUNCTION g_socket_client_connect(BYVAL AS GSocketClient PTR, BYVAL AS GSocketConnectable PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GSocketConnection PTR
DECLARE FUNCTION g_socket_client_connect_to_host(BYVAL AS GSocketClient PTR, BYVAL AS CONST gchar PTR, BYVAL AS guint16, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GSocketConnection PTR
DECLARE FUNCTION g_socket_client_connect_to_service(BYVAL AS GSocketClient PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GSocketConnection PTR
DECLARE FUNCTION g_socket_client_connect_to_uri(BYVAL AS GSocketClient PTR, BYVAL AS CONST gchar PTR, BYVAL AS guint16, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GSocketConnection PTR
DECLARE SUB g_socket_client_connect_async(BYVAL AS GSocketClient PTR, BYVAL AS GSocketConnectable PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_socket_client_connect_finish(BYVAL AS GSocketClient PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GSocketConnection PTR
DECLARE SUB g_socket_client_connect_to_host_async(BYVAL AS GSocketClient PTR, BYVAL AS CONST gchar PTR, BYVAL AS guint16, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_socket_client_connect_to_host_finish(BYVAL AS GSocketClient PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GSocketConnection PTR
DECLARE SUB g_socket_client_connect_to_service_async(BYVAL AS GSocketClient PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_socket_client_connect_to_service_finish(BYVAL AS GSocketClient PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GSocketConnection PTR
DECLARE SUB g_socket_client_connect_to_uri_async(BYVAL AS GSocketClient PTR, BYVAL AS CONST gchar PTR, BYVAL AS guint16, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_socket_client_connect_to_uri_finish(BYVAL AS GSocketClient PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GSocketConnection PTR
DECLARE SUB g_socket_client_add_application_proxy(BYVAL AS GSocketClient PTR, BYVAL AS CONST gchar PTR)

#ENDIF ' __G_SOCKET_CLIENT_H__

#IFNDEF __G_SOCKET_CONNECTABLE_H__
#DEFINE __G_SOCKET_CONNECTABLE_H__

#DEFINE G_TYPE_SOCKET_CONNECTABLE (g_socket_connectable_get_type ())
#DEFINE G_SOCKET_CONNECTABLE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), G_TYPE_SOCKET_CONNECTABLE, GSocketConnectable))
#DEFINE G_IS_SOCKET_CONNECTABLE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), G_TYPE_SOCKET_CONNECTABLE))
#DEFINE G_SOCKET_CONNECTABLE_GET_IFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), G_TYPE_SOCKET_CONNECTABLE, GSocketConnectableIface))

TYPE GSocketConnectableIface AS _GSocketConnectableIface

TYPE _GSocketConnectableIface
  AS GTypeInterface g_iface
  enumerate AS FUNCTION(BYVAL AS GSocketConnectable PTR) AS GSocketAddressEnumerator PTR
  proxy_enumerate AS FUNCTION(BYVAL AS GSocketConnectable PTR) AS GSocketAddressEnumerator PTR
END TYPE

DECLARE FUNCTION g_socket_connectable_get_type() AS GType
DECLARE FUNCTION g_socket_connectable_enumerate(BYVAL AS GSocketConnectable PTR) AS GSocketAddressEnumerator PTR
DECLARE FUNCTION g_socket_connectable_proxy_enumerate(BYVAL AS GSocketConnectable PTR) AS GSocketAddressEnumerator PTR

#ENDIF ' __G_SOCKET_CONNECTABLE_H__

#IFNDEF __G_SOCKET_CONNECTION_H__
#DEFINE __G_SOCKET_CONNECTION_H__

#IFNDEF __G_SOCKET_H__
#DEFINE __G_SOCKET_H__

#DEFINE G_TYPE_SOCKET (g_socket_get_type ())
#DEFINE G_SOCKET(inst) (G_TYPE_CHECK_INSTANCE_CAST ((inst), _
                                                             G_TYPE_SOCKET, GSocket))
#DEFINE G_SOCKET_CLASS(class) (G_TYPE_CHECK_CLASS_CAST ((class), _
                                                             G_TYPE_SOCKET, GSocketClass))
#DEFINE G_IS_SOCKET(inst) (G_TYPE_CHECK_INSTANCE_TYPE ((inst), _
                                                             G_TYPE_SOCKET))
#DEFINE G_IS_SOCKET_CLASS(class) (G_TYPE_CHECK_CLASS_TYPE ((class), _
                                                             G_TYPE_SOCKET))
#DEFINE G_SOCKET_GET_CLASS(inst) (G_TYPE_INSTANCE_GET_CLASS ((inst), _
                                                             G_TYPE_SOCKET, GSocketClass))

TYPE GSocketPrivate AS _GSocketPrivate
TYPE GSocketClass AS _GSocketClass

TYPE _GSocketClass
  AS GObjectClass parent_class
  _g_reserved1 AS SUB()
  _g_reserved2 AS SUB()
  _g_reserved3 AS SUB()
  _g_reserved4 AS SUB()
  _g_reserved5 AS SUB()
  _g_reserved6 AS SUB()
  _g_reserved7 AS SUB()
  _g_reserved8 AS SUB()
  _g_reserved9 AS SUB()
  _g_reserved10 AS SUB()
END TYPE

TYPE _GSocket
  AS GObject parent_instance
  AS GSocketPrivate PTR priv
END TYPE

DECLARE FUNCTION g_socket_get_type() AS GType
DECLARE FUNCTION g_socket_new(BYVAL AS GSocketFamily, BYVAL AS GSocketType, BYVAL AS GSocketProtocol, BYVAL AS GError PTR PTR) AS GSocket PTR
DECLARE FUNCTION g_socket_new_from_fd(BYVAL AS gint, BYVAL AS GError PTR PTR) AS GSocket PTR
DECLARE FUNCTION g_socket_get_fd(BYVAL AS GSocket PTR) AS INTEGER
DECLARE FUNCTION g_socket_get_family(BYVAL AS GSocket PTR) AS GSocketFamily
DECLARE FUNCTION g_socket_get_socket_type(BYVAL AS GSocket PTR) AS GSocketType
DECLARE FUNCTION g_socket_get_protocol(BYVAL AS GSocket PTR) AS GSocketProtocol
DECLARE FUNCTION g_socket_get_local_address(BYVAL AS GSocket PTR, BYVAL AS GError PTR PTR) AS GSocketAddress PTR
DECLARE FUNCTION g_socket_get_remote_address(BYVAL AS GSocket PTR, BYVAL AS GError PTR PTR) AS GSocketAddress PTR
DECLARE SUB g_socket_set_blocking(BYVAL AS GSocket PTR, BYVAL AS gboolean)
DECLARE FUNCTION g_socket_get_blocking(BYVAL AS GSocket PTR) AS gboolean
DECLARE SUB g_socket_set_keepalive(BYVAL AS GSocket PTR, BYVAL AS gboolean)
DECLARE FUNCTION g_socket_get_keepalive(BYVAL AS GSocket PTR) AS gboolean
DECLARE FUNCTION g_socket_get_listen_backlog(BYVAL AS GSocket PTR) AS gint
DECLARE SUB g_socket_set_listen_backlog(BYVAL AS GSocket PTR, BYVAL AS gint)
DECLARE FUNCTION g_socket_get_timeout(BYVAL AS GSocket PTR) AS guint
DECLARE SUB g_socket_set_timeout(BYVAL AS GSocket PTR, BYVAL AS guint)
DECLARE FUNCTION g_socket_is_connected(BYVAL AS GSocket PTR) AS gboolean
DECLARE FUNCTION g_socket_bind(BYVAL AS GSocket PTR, BYVAL AS GSocketAddress PTR, BYVAL AS gboolean, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_socket_connect(BYVAL AS GSocket PTR, BYVAL AS GSocketAddress PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_socket_check_connect_result(BYVAL AS GSocket PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_socket_condition_check(BYVAL AS GSocket PTR, BYVAL AS GIOCondition) AS GIOCondition
DECLARE FUNCTION g_socket_condition_wait(BYVAL AS GSocket PTR, BYVAL AS GIOCondition, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_socket_accept(BYVAL AS GSocket PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GSocket PTR
DECLARE FUNCTION g_socket_listen(BYVAL AS GSocket PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_socket_receive(BYVAL AS GSocket PTR, BYVAL AS gchar PTR, BYVAL AS gsize, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gssize
DECLARE FUNCTION g_socket_receive_from(BYVAL AS GSocket PTR, BYVAL AS GSocketAddress PTR PTR, BYVAL AS gchar PTR, BYVAL AS gsize, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gssize
DECLARE FUNCTION g_socket_send(BYVAL AS GSocket PTR, BYVAL AS CONST gchar PTR, BYVAL AS gsize, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gssize
DECLARE FUNCTION g_socket_send_to(BYVAL AS GSocket PTR, BYVAL AS GSocketAddress PTR, BYVAL AS CONST gchar PTR, BYVAL AS gsize, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gssize
DECLARE FUNCTION g_socket_receive_message(BYVAL AS GSocket PTR, BYVAL AS GSocketAddress PTR PTR, BYVAL AS GInputVector PTR, BYVAL AS gint, BYVAL AS GSocketControlMessage PTR PTR PTR, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gssize
DECLARE FUNCTION g_socket_send_message(BYVAL AS GSocket PTR, BYVAL AS GSocketAddress PTR, BYVAL AS GOutputVector PTR, BYVAL AS gint, BYVAL AS GSocketControlMessage PTR PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gssize
DECLARE FUNCTION g_socket_close(BYVAL AS GSocket PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_socket_shutdown(BYVAL AS GSocket PTR, BYVAL AS gboolean, BYVAL AS gboolean, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_socket_is_closed(BYVAL AS GSocket PTR) AS gboolean
DECLARE FUNCTION g_socket_create_source(BYVAL AS GSocket PTR, BYVAL AS GIOCondition, BYVAL AS GCancellable PTR) AS GSource PTR
DECLARE FUNCTION g_socket_speaks_ipv4(BYVAL AS GSocket PTR) AS gboolean
DECLARE FUNCTION g_socket_get_credentials(BYVAL AS GSocket PTR, BYVAL AS GError PTR PTR) AS GCredentials PTR
DECLARE FUNCTION g_socket_receive_with_blocking(BYVAL AS GSocket PTR, BYVAL AS gchar PTR, BYVAL AS gsize, BYVAL AS gboolean, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gssize
DECLARE FUNCTION g_socket_send_with_blocking(BYVAL AS GSocket PTR, BYVAL AS CONST gchar PTR, BYVAL AS gsize, BYVAL AS gboolean, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gssize

#ENDIF ' __G_SOCKET_H__

#DEFINE G_TYPE_SOCKET_CONNECTION (g_socket_connection_get_type ())
#DEFINE G_SOCKET_CONNECTION(inst) (G_TYPE_CHECK_INSTANCE_CAST ((inst), _
                                                             G_TYPE_SOCKET_CONNECTION, GSocketConnection))
#DEFINE G_SOCKET_CONNECTION_CLASS(class) (G_TYPE_CHECK_CLASS_CAST ((class), _
                                                             G_TYPE_SOCKET_CONNECTION, GSocketConnectionClass))
#DEFINE G_IS_SOCKET_CONNECTION(inst) (G_TYPE_CHECK_INSTANCE_TYPE ((inst), _
                                                             G_TYPE_SOCKET_CONNECTION))
#DEFINE G_IS_SOCKET_CONNECTION_CLASS(class) (G_TYPE_CHECK_CLASS_TYPE ((class), _
                                                             G_TYPE_SOCKET_CONNECTION))
#DEFINE G_SOCKET_CONNECTION_GET_CLASS(inst) (G_TYPE_INSTANCE_GET_CLASS ((inst), _
                                                             G_TYPE_SOCKET_CONNECTION, GSocketConnectionClass))

TYPE GSocketConnectionPrivate AS _GSocketConnectionPrivate
TYPE GSocketConnectionClass AS _GSocketConnectionClass

TYPE _GSocketConnectionClass
  AS GIOStreamClass parent_class
  _g_reserved1 AS SUB()
  _g_reserved2 AS SUB()
  _g_reserved3 AS SUB()
  _g_reserved4 AS SUB()
  _g_reserved5 AS SUB()
  _g_reserved6 AS SUB()
END TYPE

TYPE _GSocketConnection
  AS GIOStream parent_instance
  AS GSocketConnectionPrivate PTR priv
END TYPE

DECLARE FUNCTION g_socket_connection_get_type() AS GType
DECLARE FUNCTION g_socket_connection_get_socket(BYVAL AS GSocketConnection PTR) AS GSocket PTR
DECLARE FUNCTION g_socket_connection_get_local_address(BYVAL AS GSocketConnection PTR, BYVAL AS GError PTR PTR) AS GSocketAddress PTR
DECLARE FUNCTION g_socket_connection_get_remote_address(BYVAL AS GSocketConnection PTR, BYVAL AS GError PTR PTR) AS GSocketAddress PTR
DECLARE SUB g_socket_connection_factory_register_type(BYVAL AS GType, BYVAL AS GSocketFamily, BYVAL AS GSocketType, BYVAL AS gint)
DECLARE FUNCTION g_socket_connection_factory_lookup_type(BYVAL AS GSocketFamily, BYVAL AS GSocketType, BYVAL AS gint) AS GType
DECLARE FUNCTION g_socket_connection_factory_create_connection(BYVAL AS GSocket PTR) AS GSocketConnection PTR

#ENDIF ' __G_SOCKET_CONNECTION_H__

#IFNDEF __G_SOCKET_CONTROL_MESSAGE_H__
#DEFINE __G_SOCKET_CONTROL_MESSAGE_H__

#DEFINE G_TYPE_SOCKET_CONTROL_MESSAGE (g_socket_control_message_get_type ())
#DEFINE G_SOCKET_CONTROL_MESSAGE(inst) (G_TYPE_CHECK_INSTANCE_CAST ((inst), _
                                                             G_TYPE_SOCKET_CONTROL_MESSAGE, _
                                                             GSocketControlMessage))
#DEFINE G_SOCKET_CONTROL_MESSAGE_CLASS(class) (G_TYPE_CHECK_CLASS_CAST ((class), _
                                                             G_TYPE_SOCKET_CONTROL_MESSAGE, _
                                                             GSocketControlMessageClass))
#DEFINE G_IS_SOCKET_CONTROL_MESSAGE(inst) (G_TYPE_CHECK_INSTANCE_TYPE ((inst), _
                                                             G_TYPE_SOCKET_CONTROL_MESSAGE))
#DEFINE G_IS_SOCKET_CONTROL_MESSAGE_CLASS(class) (G_TYPE_CHECK_CLASS_TYPE ((class), _
                                                             G_TYPE_SOCKET_CONTROL_MESSAGE))
#DEFINE G_SOCKET_CONTROL_MESSAGE_GET_CLASS(inst) (G_TYPE_INSTANCE_GET_CLASS ((inst), _
                                                             G_TYPE_SOCKET_CONTROL_MESSAGE, _
                                                             GSocketControlMessageClass))

TYPE GSocketControlMessagePrivate AS _GSocketControlMessagePrivate
TYPE GSocketControlMessageClass AS _GSocketControlMessageClass

TYPE _GSocketControlMessageClass
  AS GObjectClass parent_class
  get_size AS FUNCTION(BYVAL AS GSocketControlMessage PTR) AS gsize
  get_level AS FUNCTION(BYVAL AS GSocketControlMessage PTR) AS INTEGER
  get_type AS FUNCTION(BYVAL AS GSocketControlMessage PTR) AS INTEGER
  serialize AS SUB(BYVAL AS GSocketControlMessage PTR, BYVAL AS gpointer)
  deserialize AS FUNCTION(BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS gsize, BYVAL AS gpointer) AS GSocketControlMessage PTR
  _g_reserved1 AS SUB()
  _g_reserved2 AS SUB()
  _g_reserved3 AS SUB()
  _g_reserved4 AS SUB()
  _g_reserved5 AS SUB()
END TYPE

TYPE _GSocketControlMessage
  AS GObject parent_instance
  AS GSocketControlMessagePrivate PTR priv
END TYPE

DECLARE FUNCTION g_socket_control_message_get_type() AS GType
DECLARE FUNCTION g_socket_control_message_get_size(BYVAL AS GSocketControlMessage PTR) AS gsize
DECLARE FUNCTION g_socket_control_message_get_level(BYVAL AS GSocketControlMessage PTR) AS INTEGER
DECLARE FUNCTION g_socket_control_message_get_msg_type(BYVAL AS GSocketControlMessage PTR) AS INTEGER
DECLARE SUB g_socket_control_message_serialize(BYVAL AS GSocketControlMessage PTR, BYVAL AS gpointer)
DECLARE FUNCTION g_socket_control_message_deserialize(BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS gsize, BYVAL AS gpointer) AS GSocketControlMessage PTR

#ENDIF ' __G_SOCKET_CONTROL_MESSAGE_H__

#IFNDEF __G_SOCKET_LISTENER_H__
#DEFINE __G_SOCKET_LISTENER_H__

#DEFINE G_TYPE_SOCKET_LISTENER (g_socket_listener_get_type ())
#DEFINE G_SOCKET_LISTENER(inst) (G_TYPE_CHECK_INSTANCE_CAST ((inst), _
                                                             G_TYPE_SOCKET_LISTENER, GSocketListener))
#DEFINE G_SOCKET_LISTENER_CLASS(class) (G_TYPE_CHECK_CLASS_CAST ((class), _
                                                             G_TYPE_SOCKET_LISTENER, GSocketListenerClass))
#DEFINE G_IS_SOCKET_LISTENER(inst) (G_TYPE_CHECK_INSTANCE_TYPE ((inst), _
                                                             G_TYPE_SOCKET_LISTENER))
#DEFINE G_IS_SOCKET_LISTENER_CLASS(class) (G_TYPE_CHECK_CLASS_TYPE ((class), _
                                                             G_TYPE_SOCKET_LISTENER))
#DEFINE G_SOCKET_LISTENER_GET_CLASS(inst) (G_TYPE_INSTANCE_GET_CLASS ((inst), _
                                                             G_TYPE_SOCKET_LISTENER, GSocketListenerClass))

TYPE GSocketListenerPrivate AS _GSocketListenerPrivate
TYPE GSocketListenerClass AS _GSocketListenerClass

TYPE _GSocketListenerClass
  AS GObjectClass parent_class
  changed AS SUB(BYVAL AS GSocketListener PTR)
  _g_reserved1 AS SUB()
  _g_reserved2 AS SUB()
  _g_reserved3 AS SUB()
  _g_reserved4 AS SUB()
  _g_reserved5 AS SUB()
  _g_reserved6 AS SUB()
END TYPE

TYPE _GSocketListener
  AS GObject parent_instance
  AS GSocketListenerPrivate PTR priv
END TYPE

DECLARE FUNCTION g_socket_listener_get_type() AS GType
DECLARE FUNCTION g_socket_listener_new() AS GSocketListener PTR
DECLARE SUB g_socket_listener_set_backlog(BYVAL AS GSocketListener PTR, BYVAL AS INTEGER)
DECLARE FUNCTION g_socket_listener_add_socket(BYVAL AS GSocketListener PTR, BYVAL AS GSocket PTR, BYVAL AS GObject PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_socket_listener_add_address(BYVAL AS GSocketListener PTR, BYVAL AS GSocketAddress PTR, BYVAL AS GSocketType, BYVAL AS GSocketProtocol, BYVAL AS GObject PTR, BYVAL AS GSocketAddress PTR PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_socket_listener_add_inet_port(BYVAL AS GSocketListener PTR, BYVAL AS guint16, BYVAL AS GObject PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_socket_listener_add_any_inet_port(BYVAL AS GSocketListener PTR, BYVAL AS GObject PTR, BYVAL AS GError PTR PTR) AS guint16
DECLARE FUNCTION g_socket_listener_accept_socket(BYVAL AS GSocketListener PTR, BYVAL AS GObject PTR PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GSocket PTR
DECLARE SUB g_socket_listener_accept_socket_async(BYVAL AS GSocketListener PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_socket_listener_accept_socket_finish(BYVAL AS GSocketListener PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GObject PTR PTR, BYVAL AS GError PTR PTR) AS GSocket PTR
DECLARE FUNCTION g_socket_listener_accept(BYVAL AS GSocketListener PTR, BYVAL AS GObject PTR PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GSocketConnection PTR
DECLARE SUB g_socket_listener_accept_async(BYVAL AS GSocketListener PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_socket_listener_accept_finish(BYVAL AS GSocketListener PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GObject PTR PTR, BYVAL AS GError PTR PTR) AS GSocketConnection PTR
DECLARE SUB g_socket_listener_close(BYVAL AS GSocketListener PTR)

#ENDIF ' __G_SOCKET_LISTENER_H__

#IFNDEF __G_SOCKET_SERVICE_H__
#DEFINE __G_SOCKET_SERVICE_H__

#DEFINE G_TYPE_SOCKET_SERVICE (g_socket_service_get_type ())
#DEFINE G_SOCKET_SERVICE(inst) (G_TYPE_CHECK_INSTANCE_CAST ((inst), _
                                                             G_TYPE_SOCKET_SERVICE, GSocketService))
#DEFINE G_SOCKET_SERVICE_CLASS(class) (G_TYPE_CHECK_CLASS_CAST ((class), _
                                                             G_TYPE_SOCKET_SERVICE, GSocketServiceClass))
#DEFINE G_IS_SOCKET_SERVICE(inst) (G_TYPE_CHECK_INSTANCE_TYPE ((inst), _
                                                             G_TYPE_SOCKET_SERVICE))
#DEFINE G_IS_SOCKET_SERVICE_CLASS(class) (G_TYPE_CHECK_CLASS_TYPE ((class), _
                                                             G_TYPE_SOCKET_SERVICE))
#DEFINE G_SOCKET_SERVICE_GET_CLASS(inst) (G_TYPE_INSTANCE_GET_CLASS ((inst), _
                                                             G_TYPE_SOCKET_SERVICE, GSocketServiceClass))

TYPE GSocketServicePrivate AS _GSocketServicePrivate
TYPE GSocketServiceClass AS _GSocketServiceClass

TYPE _GSocketServiceClass
  AS GSocketListenerClass parent_class
  incoming AS FUNCTION(BYVAL AS GSocketService PTR, BYVAL AS GSocketConnection PTR, BYVAL AS GObject PTR) AS gboolean
  _g_reserved1 AS SUB()
  _g_reserved2 AS SUB()
  _g_reserved3 AS SUB()
  _g_reserved4 AS SUB()
  _g_reserved5 AS SUB()
  _g_reserved6 AS SUB()
END TYPE

TYPE _GSocketService
  AS GSocketListener parent_instance
  AS GSocketServicePrivate PTR priv
END TYPE

DECLARE FUNCTION g_socket_service_get_type() AS GType
DECLARE FUNCTION g_socket_service_new() AS GSocketService PTR
DECLARE SUB g_socket_service_start(BYVAL AS GSocketService PTR)
DECLARE SUB g_socket_service_stop(BYVAL AS GSocketService PTR)
DECLARE FUNCTION g_socket_service_is_active(BYVAL AS GSocketService PTR) AS gboolean

#ENDIF ' __G_SOCKET_SERVICE_H__

#IFNDEF __G_SRV_TARGET_H__
#DEFINE __G_SRV_TARGET_H__

DECLARE FUNCTION g_srv_target_get_type() AS GType

#DEFINE G_TYPE_SRV_TARGET (g_srv_target_get_type ())

DECLARE FUNCTION g_srv_target_new(BYVAL AS CONST gchar PTR, BYVAL AS guint16, BYVAL AS guint16, BYVAL AS guint16) AS GSrvTarget PTR
DECLARE FUNCTION g_srv_target_copy(BYVAL AS GSrvTarget PTR) AS GSrvTarget PTR
DECLARE SUB g_srv_target_free(BYVAL AS GSrvTarget PTR)
DECLARE FUNCTION g_srv_target_get_hostname(BYVAL AS GSrvTarget PTR) AS CONST gchar PTR
DECLARE FUNCTION g_srv_target_get_port(BYVAL AS GSrvTarget PTR) AS guint16
DECLARE FUNCTION g_srv_target_get_priority(BYVAL AS GSrvTarget PTR) AS guint16
DECLARE FUNCTION g_srv_target_get_weight(BYVAL AS GSrvTarget PTR) AS guint16
DECLARE FUNCTION g_srv_target_list_sort(BYVAL AS GList PTR) AS GList PTR

#ENDIF ' __G_SRV_TARGET_H__

#IFNDEF __G_TCP_CONNECTION_H__
#DEFINE __G_TCP_CONNECTION_H__

#DEFINE G_TYPE_TCP_CONNECTION (g_tcp_connection_get_type ())
#DEFINE G_TCP_CONNECTION(inst) (G_TYPE_CHECK_INSTANCE_CAST ((inst), _
                                                             G_TYPE_TCP_CONNECTION, GTcpConnection))
#DEFINE G_TCP_CONNECTION_CLASS(class) (G_TYPE_CHECK_CLASS_CAST ((class), _
                                                             G_TYPE_TCP_CONNECTION, GTcpConnectionClass))
#DEFINE G_IS_TCP_CONNECTION(inst) (G_TYPE_CHECK_INSTANCE_TYPE ((inst), _
                                                             G_TYPE_TCP_CONNECTION))
#DEFINE G_IS_TCP_CONNECTION_CLASS(class) (G_TYPE_CHECK_CLASS_TYPE ((class), _
                                                             G_TYPE_TCP_CONNECTION))
#DEFINE G_TCP_CONNECTION_GET_CLASS(inst) (G_TYPE_INSTANCE_GET_CLASS ((inst), _
                                                             G_TYPE_TCP_CONNECTION, GTcpConnectionClass))

TYPE GTcpConnectionPrivate AS _GTcpConnectionPrivate
TYPE GTcpConnectionClass AS _GTcpConnectionClass

TYPE _GTcpConnectionClass
  AS GSocketConnectionClass parent_class
END TYPE

TYPE _GTcpConnection
  AS GSocketConnection parent_instance
  AS GTcpConnectionPrivate PTR priv
END TYPE

DECLARE FUNCTION g_tcp_connection_get_type() AS GType
DECLARE SUB g_tcp_connection_set_graceful_disconnect(BYVAL AS GTcpConnection PTR, BYVAL AS gboolean)
DECLARE FUNCTION g_tcp_connection_get_graceful_disconnect(BYVAL AS GTcpConnection PTR) AS gboolean

#ENDIF ' __G_TCP_CONNECTION_H__

#IFNDEF __G_TCP_WRAPPER_CONNECTION_H__
#DEFINE __G_TCP_WRAPPER_CONNECTION_H__

#DEFINE G_TYPE_TCP_WRAPPER_CONNECTION (g_tcp_wrapper_connection_get_type ())
#DEFINE G_TCP_WRAPPER_CONNECTION(inst) (G_TYPE_CHECK_INSTANCE_CAST ((inst), _
                                                  G_TYPE_TCP_WRAPPER_CONNECTION, GTcpWrapperConnection))
#DEFINE G_TCP_WRAPPER_CONNECTION_CLASS(class) (G_TYPE_CHECK_CLASS_CAST ((class), _
                                                  G_TYPE_TCP_WRAPPER_CONNECTION, GTcpWrapperConnectionClass))
#DEFINE G_IS_TCP_WRAPPER_CONNECTION(inst) (G_TYPE_CHECK_INSTANCE_TYPE ((inst), _
                                                  G_TYPE_TCP_WRAPPER_CONNECTION))
#DEFINE G_IS_TCP_WRAPPER_CONNECTION_CLASS(class) (G_TYPE_CHECK_CLASS_TYPE ((class), _
                                                  G_TYPE_TCP_WRAPPER_CONNECTION))
#DEFINE G_TCP_WRAPPER_CONNECTION_GET_CLASS(inst) (G_TYPE_INSTANCE_GET_CLASS ((inst), _
                                                  G_TYPE_TCP_WRAPPER_CONNECTION, GTcpWrapperConnectionClass))

TYPE GTcpWrapperConnectionPrivate AS _GTcpWrapperConnectionPrivate
TYPE GTcpWrapperConnectionClass AS _GTcpWrapperConnectionClass

TYPE _GTcpWrapperConnectionClass
  AS GTcpConnectionClass parent_class
END TYPE

TYPE _GTcpWrapperConnection
  AS GTcpConnection parent_instance
  AS GTcpWrapperConnectionPrivate PTR priv
END TYPE

DECLARE FUNCTION g_tcp_wrapper_connection_get_type() AS GType
DECLARE FUNCTION g_tcp_wrapper_connection_new(BYVAL AS GIOStream PTR, BYVAL AS GSocket PTR) AS GSocketConnection PTR
DECLARE FUNCTION g_tcp_wrapper_connection_get_base_io_stream(BYVAL AS GTcpWrapperConnection PTR) AS GIOStream PTR

#ENDIF ' __G_TCP_WRAPPER_CONNECTION_H__

#IFNDEF __G_THEMED_ICON_H__
#DEFINE __G_THEMED_ICON_H__

#DEFINE G_TYPE_THEMED_ICON (g_themed_icon_get_type ())
#DEFINE G_THEMED_ICON(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_THEMED_ICON, GThemedIcon))
#DEFINE G_THEMED_ICON_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_THEMED_ICON, GThemedIconClass))
#DEFINE G_IS_THEMED_ICON(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_THEMED_ICON))
#DEFINE G_IS_THEMED_ICON_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), G_TYPE_THEMED_ICON))
#DEFINE G_THEMED_ICON_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), G_TYPE_THEMED_ICON, GThemedIconClass))

TYPE GThemedIconClass AS _GThemedIconClass

DECLARE FUNCTION g_themed_icon_get_type() AS GType
DECLARE FUNCTION g_themed_icon_new(BYVAL AS CONST ZSTRING PTR) AS GIcon PTR
DECLARE FUNCTION g_themed_icon_new_with_default_fallbacks(BYVAL AS CONST ZSTRING PTR) AS GIcon PTR
DECLARE FUNCTION g_themed_icon_new_from_names(BYVAL AS ZSTRING PTR PTR, BYVAL AS INTEGER) AS GIcon PTR
DECLARE SUB g_themed_icon_prepend_name(BYVAL AS GThemedIcon PTR, BYVAL AS CONST ZSTRING PTR)
DECLARE SUB g_themed_icon_append_name(BYVAL AS GThemedIcon PTR, BYVAL AS CONST ZSTRING PTR)
DECLARE FUNCTION g_themed_icon_get_names(BYVAL AS GThemedIcon PTR) AS CONST gchar CONST PTR PTR

#ENDIF ' __G_THEMED_ICON_H__

#IFNDEF __G_THREADED_SOCKET_SERVICE_H__
#DEFINE __G_THREADED_SOCKET_SERVICE_H__

#DEFINE G_TYPE_THREADED_SOCKET_SERVICE (g_threaded_socket_service_get_type ())
#DEFINE G_THREADED_SOCKET_SERVICE(inst) (G_TYPE_CHECK_INSTANCE_CAST ((inst), _
                                                             G_TYPE_THREADED_SOCKET_SERVICE, _
                                                             GThreadedSocketService))
#DEFINE G_THREADED_SOCKET_SERVICE_CLASS(class) (G_TYPE_CHECK_CLASS_CAST ((class), _
                                                             G_TYPE_THREADED_SOCKET_SERVICE, _
                                                             GThreadedSocketServiceClass))
#DEFINE G_IS_THREADED_SOCKET_SERVICE(inst) (G_TYPE_CHECK_INSTANCE_TYPE ((inst), _
                                                             G_TYPE_THREADED_SOCKET_SERVICE))
#DEFINE G_IS_THREADED_SOCKET_SERVICE_CLASS(class) (G_TYPE_CHECK_CLASS_TYPE ((class), _
                                                             G_TYPE_THREADED_SOCKET_SERVICE))
#DEFINE G_THREADED_SOCKET_SERVICE_GET_CLASS(inst) (G_TYPE_INSTANCE_GET_CLASS ((inst), _
                                                             G_TYPE_THREADED_SOCKET_SERVICE, _
                                                             GThreadedSocketServiceClass))

TYPE GThreadedSocketServicePrivate AS _GThreadedSocketServicePrivate
TYPE GThreadedSocketServiceClass AS _GThreadedSocketServiceClass

TYPE _GThreadedSocketServiceClass
  AS GSocketServiceClass parent_class
  run_ AS FUNCTION(BYVAL AS GThreadedSocketService PTR, BYVAL AS GSocketConnection PTR, BYVAL AS GObject PTR) AS gboolean
  _g_reserved1 AS SUB()
  _g_reserved2 AS SUB()
  _g_reserved3 AS SUB()
  _g_reserved4 AS SUB()
  _g_reserved5 AS SUB()
END TYPE

TYPE _GThreadedSocketService
  AS GSocketService parent_instance
  AS GThreadedSocketServicePrivate PTR priv
END TYPE

DECLARE FUNCTION g_threaded_socket_service_get_type() AS GType
DECLARE FUNCTION g_threaded_socket_service_new(BYVAL AS INTEGER) AS GSocketService PTR

#ENDIF ' __G_THREADED_SOCKET_SERVICE_H__

#IFNDEF __G_TLS_BACKEND_H__
#DEFINE __G_TLS_BACKEND_H__

#DEFINE G_TLS_BACKEND_EXTENSION_POINT_NAME !"gio-tls-backend"
#DEFINE G_TYPE_TLS_BACKEND (g_tls_backend_get_type ())
#DEFINE G_TLS_BACKEND(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), G_TYPE_TLS_BACKEND, GTlsBackend))
#DEFINE G_IS_TLS_BACKEND(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), G_TYPE_TLS_BACKEND))
#DEFINE G_TLS_BACKEND_GET_INTERFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), G_TYPE_TLS_BACKEND, GTlsBackendInterface))

TYPE GTlsBackend AS _GTlsBackend
TYPE GTlsBackendInterface AS _GTlsBackendInterface

TYPE _GTlsBackendInterface
  AS GTypeInterface g_iface
  supports_tls AS FUNCTION(BYVAL AS GTlsBackend PTR) AS gboolean
  get_certificate_type AS FUNCTION() AS GType
  get_client_connection_type AS FUNCTION() AS GType
  get_server_connection_type AS FUNCTION() AS GType
  get_file_database_type AS FUNCTION() AS GType
  get_default_database AS FUNCTION(BYVAL AS GTlsBackend PTR) AS GTlsDatabase PTR
END TYPE

DECLARE FUNCTION g_tls_backend_get_type() AS GType
DECLARE FUNCTION g_tls_backend_get_default() AS GTlsBackend PTR
DECLARE FUNCTION g_tls_backend_get_default_database(BYVAL AS GTlsBackend PTR) AS GTlsDatabase PTR
DECLARE FUNCTION g_tls_backend_supports_tls(BYVAL AS GTlsBackend PTR) AS gboolean
DECLARE FUNCTION g_tls_backend_get_certificate_type(BYVAL AS GTlsBackend PTR) AS GType
DECLARE FUNCTION g_tls_backend_get_client_connection_type(BYVAL AS GTlsBackend PTR) AS GType
DECLARE FUNCTION g_tls_backend_get_server_connection_type(BYVAL AS GTlsBackend PTR) AS GType
DECLARE FUNCTION g_tls_backend_get_file_database_type(BYVAL AS GTlsBackend PTR) AS GType

#ENDIF ' __G_TLS_BACKEND_H__

#IFNDEF __G_TLS_CERTIFICATE_H__
#DEFINE __G_TLS_CERTIFICATE_H__

#DEFINE G_TYPE_TLS_CERTIFICATE (g_tls_certificate_get_type ())
#DEFINE G_TLS_CERTIFICATE(inst) (G_TYPE_CHECK_INSTANCE_CAST ((inst), G_TYPE_TLS_CERTIFICATE, GTlsCertificate))
#DEFINE G_TLS_CERTIFICATE_CLASS(class) (G_TYPE_CHECK_CLASS_CAST ((class), G_TYPE_TLS_CERTIFICATE, GTlsCertificateClass))
#DEFINE G_IS_TLS_CERTIFICATE(inst) (G_TYPE_CHECK_INSTANCE_TYPE ((inst), G_TYPE_TLS_CERTIFICATE))
#DEFINE G_IS_TLS_CERTIFICATE_CLASS(class) (G_TYPE_CHECK_CLASS_TYPE ((class), G_TYPE_TLS_CERTIFICATE))
#DEFINE G_TLS_CERTIFICATE_GET_CLASS(inst) (G_TYPE_INSTANCE_GET_CLASS ((inst), G_TYPE_TLS_CERTIFICATE, GTlsCertificateClass))

TYPE GTlsCertificateClass AS _GTlsCertificateClass
TYPE GTlsCertificatePrivate AS _GTlsCertificatePrivate

TYPE _GTlsCertificate
  AS GObject parent_instance
  AS GTlsCertificatePrivate PTR priv
END TYPE

TYPE _GTlsCertificateClass
  AS GObjectClass parent_class
  verify AS FUNCTION(BYVAL AS GTlsCertificate PTR, BYVAL AS GSocketConnectable PTR, BYVAL AS GTlsCertificate PTR) AS GTlsCertificateFlags
  AS gpointer padding(7)
END TYPE

DECLARE FUNCTION g_tls_certificate_get_type() AS GType
DECLARE FUNCTION g_tls_certificate_new_from_pem(BYVAL AS CONST gchar PTR, BYVAL AS gssize, BYVAL AS GError PTR PTR) AS GTlsCertificate PTR
DECLARE FUNCTION g_tls_certificate_new_from_file(BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS GTlsCertificate PTR
DECLARE FUNCTION g_tls_certificate_new_from_files(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS GTlsCertificate PTR
DECLARE FUNCTION g_tls_certificate_list_new_from_file(BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS GList PTR
DECLARE FUNCTION g_tls_certificate_get_issuer(BYVAL AS GTlsCertificate PTR) AS GTlsCertificate PTR
DECLARE FUNCTION g_tls_certificate_verify(BYVAL AS GTlsCertificate PTR, BYVAL AS GSocketConnectable PTR, BYVAL AS GTlsCertificate PTR) AS GTlsCertificateFlags

#ENDIF ' __G_TLS_CERTIFICATE_H__

#IFNDEF __G_TLS_CLIENT_CONNECTION_H__
#DEFINE __G_TLS_CLIENT_CONNECTION_H__

#IFNDEF __G_TLS_CONNECTION_H__
#DEFINE __G_TLS_CONNECTION_H__

#DEFINE G_TYPE_TLS_CONNECTION (g_tls_connection_get_type ())
#DEFINE G_TLS_CONNECTION(inst) (G_TYPE_CHECK_INSTANCE_CAST ((inst), G_TYPE_TLS_CONNECTION, GTlsConnection))
#DEFINE G_TLS_CONNECTION_CLASS(class) (G_TYPE_CHECK_CLASS_CAST ((class), G_TYPE_TLS_CONNECTION, GTlsConnectionClass))
#DEFINE G_IS_TLS_CONNECTION(inst) (G_TYPE_CHECK_INSTANCE_TYPE ((inst), G_TYPE_TLS_CONNECTION))
#DEFINE G_IS_TLS_CONNECTION_CLASS(class) (G_TYPE_CHECK_CLASS_TYPE ((class), G_TYPE_TLS_CONNECTION))
#DEFINE G_TLS_CONNECTION_GET_CLASS(inst) (G_TYPE_INSTANCE_GET_CLASS ((inst), G_TYPE_TLS_CONNECTION, GTlsConnectionClass))

TYPE GTlsConnectionClass AS _GTlsConnectionClass
TYPE GTlsConnectionPrivate AS _GTlsConnectionPrivate

TYPE _GTlsConnection
  AS GIOStream parent_instance
  AS GTlsConnectionPrivate PTR priv
END TYPE

TYPE _GTlsConnectionClass
  AS GIOStreamClass parent_class
  accept_certificate AS FUNCTION(BYVAL AS GTlsConnection PTR, BYVAL AS GTlsCertificate PTR, BYVAL AS GTlsCertificateFlags) AS gboolean
  handshake AS FUNCTION(BYVAL AS GTlsConnection PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
  handshake_async AS SUB(BYVAL AS GTlsConnection PTR, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  handshake_finish AS FUNCTION(BYVAL AS GTlsConnection PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
  AS gpointer padding(7)
END TYPE

DECLARE FUNCTION g_tls_connection_get_type() AS GType
DECLARE SUB g_tls_connection_set_use_system_certdb(BYVAL AS GTlsConnection PTR, BYVAL AS gboolean)
DECLARE FUNCTION g_tls_connection_get_use_system_certdb(BYVAL AS GTlsConnection PTR) AS gboolean
DECLARE SUB g_tls_connection_set_database(BYVAL AS GTlsConnection PTR, BYVAL AS GTlsDatabase PTR)
DECLARE FUNCTION g_tls_connection_get_database(BYVAL AS GTlsConnection PTR) AS GTlsDatabase PTR
DECLARE SUB g_tls_connection_set_certificate(BYVAL AS GTlsConnection PTR, BYVAL AS GTlsCertificate PTR)
DECLARE FUNCTION g_tls_connection_get_certificate(BYVAL AS GTlsConnection PTR) AS GTlsCertificate PTR
DECLARE SUB g_tls_connection_set_interaction(BYVAL AS GTlsConnection PTR, BYVAL AS GTlsInteraction PTR)
DECLARE FUNCTION g_tls_connection_get_interaction(BYVAL AS GTlsConnection PTR) AS GTlsInteraction PTR
DECLARE FUNCTION g_tls_connection_get_peer_certificate(BYVAL AS GTlsConnection PTR) AS GTlsCertificate PTR
DECLARE FUNCTION g_tls_connection_get_peer_certificate_errors(BYVAL AS GTlsConnection PTR) AS GTlsCertificateFlags
DECLARE SUB g_tls_connection_set_require_close_notify(BYVAL AS GTlsConnection PTR, BYVAL AS gboolean)
DECLARE FUNCTION g_tls_connection_get_require_close_notify(BYVAL AS GTlsConnection PTR) AS gboolean
DECLARE SUB g_tls_connection_set_rehandshake_mode(BYVAL AS GTlsConnection PTR, BYVAL AS GTlsRehandshakeMode)
DECLARE FUNCTION g_tls_connection_get_rehandshake_mode(BYVAL AS GTlsConnection PTR) AS GTlsRehandshakeMode
DECLARE FUNCTION g_tls_connection_handshake(BYVAL AS GTlsConnection PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE SUB g_tls_connection_handshake_async(BYVAL AS GTlsConnection PTR, BYVAL AS INTEGER, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_tls_connection_handshake_finish(BYVAL AS GTlsConnection PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean

#DEFINE G_TLS_ERROR (g_tls_error_quark ())

DECLARE FUNCTION g_tls_error_quark() AS GQuark
DECLARE FUNCTION g_tls_connection_emit_accept_certificate(BYVAL AS GTlsConnection PTR, BYVAL AS GTlsCertificate PTR, BYVAL AS GTlsCertificateFlags) AS gboolean

#ENDIF ' __G_TLS_CONNECTION_H__

#DEFINE G_TYPE_TLS_CLIENT_CONNECTION (g_tls_client_connection_get_type ())
#DEFINE G_TLS_CLIENT_CONNECTION(inst) (G_TYPE_CHECK_INSTANCE_CAST ((inst), G_TYPE_TLS_CLIENT_CONNECTION, GTlsClientConnection))
#DEFINE G_IS_TLS_CLIENT_CONNECTION(inst) (G_TYPE_CHECK_INSTANCE_TYPE ((inst), G_TYPE_TLS_CLIENT_CONNECTION))
#DEFINE G_TLS_CLIENT_CONNECTION_GET_INTERFACE(inst) (G_TYPE_INSTANCE_GET_INTERFACE ((inst), G_TYPE_TLS_CLIENT_CONNECTION, GTlsClientConnectionInterface))

TYPE GTlsClientConnectionInterface AS _GTlsClientConnectionInterface

TYPE _GTlsClientConnectionInterface
  AS GTypeInterface g_iface
END TYPE

DECLARE FUNCTION g_tls_client_connection_get_type() AS GType
DECLARE FUNCTION g_tls_client_connection_new(BYVAL AS GIOStream PTR, BYVAL AS GSocketConnectable PTR, BYVAL AS GError PTR PTR) AS GIOStream PTR
DECLARE FUNCTION g_tls_client_connection_get_validation_flags(BYVAL AS GTlsClientConnection PTR) AS GTlsCertificateFlags
DECLARE SUB g_tls_client_connection_set_validation_flags(BYVAL AS GTlsClientConnection PTR, BYVAL AS GTlsCertificateFlags)
DECLARE FUNCTION g_tls_client_connection_get_server_identity(BYVAL AS GTlsClientConnection PTR) AS GSocketConnectable PTR
DECLARE SUB g_tls_client_connection_set_server_identity(BYVAL AS GTlsClientConnection PTR, BYVAL AS GSocketConnectable PTR)
DECLARE FUNCTION g_tls_client_connection_get_use_ssl3(BYVAL AS GTlsClientConnection PTR) AS gboolean
DECLARE SUB g_tls_client_connection_set_use_ssl3(BYVAL AS GTlsClientConnection PTR, BYVAL AS gboolean)
DECLARE FUNCTION g_tls_client_connection_get_accepted_cas(BYVAL AS GTlsClientConnection PTR) AS GList PTR

#ENDIF ' __G_TLS_CLIENT_CONNECTION_H__

#IFNDEF __G_TLS_DATABASE_H__
#DEFINE __G_TLS_DATABASE_H__

#DEFINE G_TLS_DATABASE_PURPOSE_AUTHENTICATE_SERVER !"1.3.6.1.5.5.7.3.1"
#DEFINE G_TLS_DATABASE_PURPOSE_AUTHENTICATE_CLIENT !"1.3.6.1.5.5.7.3.2"
#DEFINE G_TYPE_TLS_DATABASE (g_tls_database_get_type ())
#DEFINE G_TLS_DATABASE(inst) (G_TYPE_CHECK_INSTANCE_CAST ((inst), G_TYPE_TLS_DATABASE, GTlsDatabase))
#DEFINE G_TLS_DATABASE_CLASS(class) (G_TYPE_CHECK_CLASS_CAST ((class), G_TYPE_TLS_DATABASE, GTlsDatabaseClass))
#DEFINE G_IS_TLS_DATABASE(inst) (G_TYPE_CHECK_INSTANCE_TYPE ((inst), G_TYPE_TLS_DATABASE))
#DEFINE G_IS_TLS_DATABASE_CLASS(class) (G_TYPE_CHECK_CLASS_TYPE ((class), G_TYPE_TLS_DATABASE))
#DEFINE G_TLS_DATABASE_GET_CLASS(inst) (G_TYPE_INSTANCE_GET_CLASS ((inst), G_TYPE_TLS_DATABASE, GTlsDatabaseClass))

TYPE GTlsDatabaseClass AS _GTlsDatabaseClass
TYPE GTlsDatabasePrivate AS _GTlsDatabasePrivate

TYPE _GTlsDatabase
  AS GObject parent_instance
  AS GTlsDatabasePrivate PTR priv
END TYPE

TYPE _GTlsDatabaseClass
  AS GObjectClass parent_class
  verify_chain AS FUNCTION(BYVAL AS GTlsDatabase PTR, BYVAL AS GTlsCertificate PTR, BYVAL AS CONST gchar PTR, BYVAL AS GSocketConnectable PTR, BYVAL AS GTlsInteraction PTR, BYVAL AS GTlsDatabaseVerifyFlags, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GTlsCertificateFlags
  verify_chain_async AS SUB(BYVAL AS GTlsDatabase PTR, BYVAL AS GTlsCertificate PTR, BYVAL AS CONST gchar PTR, BYVAL AS GSocketConnectable PTR, BYVAL AS GTlsInteraction PTR, BYVAL AS GTlsDatabaseVerifyFlags, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  verify_chain_finish AS FUNCTION(BYVAL AS GTlsDatabase PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GTlsCertificateFlags
  create_certificate_handle AS FUNCTION(BYVAL AS GTlsDatabase PTR, BYVAL AS GTlsCertificate PTR) AS gchar PTR
  lookup_certificate_for_handle AS FUNCTION(BYVAL AS GTlsDatabase PTR, BYVAL AS CONST gchar PTR, BYVAL AS GTlsInteraction PTR, BYVAL AS GTlsDatabaseLookupFlags, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GTlsCertificate PTR
  lookup_certificate_for_handle_async AS SUB(BYVAL AS GTlsDatabase PTR, BYVAL AS CONST gchar PTR, BYVAL AS GTlsInteraction PTR, BYVAL AS GTlsDatabaseLookupFlags, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  lookup_certificate_for_handle_finish AS FUNCTION(BYVAL AS GTlsDatabase PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GTlsCertificate PTR
  lookup_certificate_issuer AS FUNCTION(BYVAL AS GTlsDatabase PTR, BYVAL AS GTlsCertificate PTR, BYVAL AS GTlsInteraction PTR, BYVAL AS GTlsDatabaseLookupFlags, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GTlsCertificate PTR
  lookup_certificate_issuer_async AS SUB(BYVAL AS GTlsDatabase PTR, BYVAL AS GTlsCertificate PTR, BYVAL AS GTlsInteraction PTR, BYVAL AS GTlsDatabaseLookupFlags, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  lookup_certificate_issuer_finish AS FUNCTION(BYVAL AS GTlsDatabase PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GTlsCertificate PTR
  lookup_certificates_issued_by AS FUNCTION(BYVAL AS GTlsDatabase PTR, BYVAL AS GByteArray PTR, BYVAL AS GTlsInteraction PTR, BYVAL AS GTlsDatabaseLookupFlags, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GList PTR
  lookup_certificates_issued_by_async AS SUB(BYVAL AS GTlsDatabase PTR, BYVAL AS GByteArray PTR, BYVAL AS GTlsInteraction PTR, BYVAL AS GTlsDatabaseLookupFlags, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  lookup_certificates_issued_by_finish AS FUNCTION(BYVAL AS GTlsDatabase PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GList PTR
  AS gpointer padding(15)
END TYPE

DECLARE FUNCTION g_tls_database_get_type() AS GType
DECLARE FUNCTION g_tls_database_verify_chain(BYVAL AS GTlsDatabase PTR, BYVAL AS GTlsCertificate PTR, BYVAL AS CONST gchar PTR, BYVAL AS GSocketConnectable PTR, BYVAL AS GTlsInteraction PTR, BYVAL AS GTlsDatabaseVerifyFlags, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GTlsCertificateFlags
DECLARE SUB g_tls_database_verify_chain_async(BYVAL AS GTlsDatabase PTR, BYVAL AS GTlsCertificate PTR, BYVAL AS CONST gchar PTR, BYVAL AS GSocketConnectable PTR, BYVAL AS GTlsInteraction PTR, BYVAL AS GTlsDatabaseVerifyFlags, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_tls_database_verify_chain_finish(BYVAL AS GTlsDatabase PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GTlsCertificateFlags
DECLARE FUNCTION g_tls_database_create_certificate_handle(BYVAL AS GTlsDatabase PTR, BYVAL AS GTlsCertificate PTR) AS gchar PTR
DECLARE FUNCTION g_tls_database_lookup_certificate_for_handle(BYVAL AS GTlsDatabase PTR, BYVAL AS CONST gchar PTR, BYVAL AS GTlsInteraction PTR, BYVAL AS GTlsDatabaseLookupFlags, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GTlsCertificate PTR
DECLARE SUB g_tls_database_lookup_certificate_for_handle_async(BYVAL AS GTlsDatabase PTR, BYVAL AS CONST gchar PTR, BYVAL AS GTlsInteraction PTR, BYVAL AS GTlsDatabaseLookupFlags, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_tls_database_lookup_certificate_for_handle_finish(BYVAL AS GTlsDatabase PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GTlsCertificate PTR
DECLARE FUNCTION g_tls_database_lookup_certificate_issuer(BYVAL AS GTlsDatabase PTR, BYVAL AS GTlsCertificate PTR, BYVAL AS GTlsInteraction PTR, BYVAL AS GTlsDatabaseLookupFlags, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GTlsCertificate PTR
DECLARE SUB g_tls_database_lookup_certificate_issuer_async(BYVAL AS GTlsDatabase PTR, BYVAL AS GTlsCertificate PTR, BYVAL AS GTlsInteraction PTR, BYVAL AS GTlsDatabaseLookupFlags, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_tls_database_lookup_certificate_issuer_finish(BYVAL AS GTlsDatabase PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GTlsCertificate PTR
DECLARE FUNCTION g_tls_database_lookup_certificates_issued_by(BYVAL AS GTlsDatabase PTR, BYVAL AS GByteArray PTR, BYVAL AS GTlsInteraction PTR, BYVAL AS GTlsDatabaseLookupFlags, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GList PTR
DECLARE SUB g_tls_database_lookup_certificates_issued_by_async(BYVAL AS GTlsDatabase PTR, BYVAL AS GByteArray PTR, BYVAL AS GTlsInteraction PTR, BYVAL AS GTlsDatabaseLookupFlags, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_tls_database_lookup_certificates_issued_by_finish(BYVAL AS GTlsDatabase PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GList PTR

#ENDIF ' __G_TLS_DATABASE_H__

#IFNDEF __G_TLS_FILE_DATABASE_H__
#DEFINE __G_TLS_FILE_DATABASE_H__

#DEFINE G_TYPE_TLS_FILE_DATABASE (g_tls_file_database_get_type ())
#DEFINE G_TLS_FILE_DATABASE(inst) (G_TYPE_CHECK_INSTANCE_CAST ((inst), G_TYPE_TLS_FILE_DATABASE, GTlsFileDatabase))
#DEFINE G_IS_TLS_FILE_DATABASE(inst) (G_TYPE_CHECK_INSTANCE_TYPE ((inst), G_TYPE_TLS_FILE_DATABASE))
#DEFINE G_TLS_FILE_DATABASE_GET_INTERFACE(inst) (G_TYPE_INSTANCE_GET_INTERFACE ((inst), G_TYPE_TLS_FILE_DATABASE, GTlsFileDatabaseInterface))

TYPE GTlsFileDatabaseInterface AS _GTlsFileDatabaseInterface

TYPE _GTlsFileDatabaseInterface
  AS GTypeInterface g_iface
  AS gpointer padding(7)
END TYPE

DECLARE FUNCTION g_tls_file_database_get_type() AS GType
DECLARE FUNCTION g_tls_file_database_new(BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS GTlsDatabase PTR

#ENDIF ' __G_TLS_FILE_DATABASE_H__

#IFNDEF __G_TLS_INTERACTION_H__
#DEFINE __G_TLS_INTERACTION_H__

#DEFINE G_TYPE_TLS_INTERACTION (g_tls_interaction_get_type ())
#DEFINE G_TLS_INTERACTION(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_TLS_INTERACTION, GTlsInteraction))
#DEFINE G_TLS_INTERACTION_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_TLS_INTERACTION, GTlsInteractionClass))
#DEFINE G_IS_TLS_INTERACTION(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_TLS_INTERACTION))
#DEFINE G_IS_TLS_INTERACTION_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), G_TYPE_TLS_INTERACTION))
#DEFINE G_TLS_INTERACTION_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), G_TYPE_TLS_INTERACTION, GTlsInteractionClass))

TYPE GTlsInteractionClass AS _GTlsInteractionClass
TYPE GTlsInteractionPrivate AS _GTlsInteractionPrivate

TYPE _GTlsInteraction
  AS GObject parent_instance
  AS GTlsInteractionPrivate PTR priv
END TYPE

TYPE _GTlsInteractionClass
  AS GObjectClass parent_class
  ask_password AS FUNCTION(BYVAL AS GTlsInteraction PTR, BYVAL AS GTlsPassword PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GTlsInteractionResult
  ask_password_async AS SUB(BYVAL AS GTlsInteraction PTR, BYVAL AS GTlsPassword PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  ask_password_finish AS FUNCTION(BYVAL AS GTlsInteraction PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GTlsInteractionResult
  AS gpointer padding(23)
END TYPE

DECLARE FUNCTION g_tls_interaction_get_type() AS GType
DECLARE FUNCTION g_tls_interaction_invoke_ask_password(BYVAL AS GTlsInteraction PTR, BYVAL AS GTlsPassword PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GTlsInteractionResult
DECLARE FUNCTION g_tls_interaction_ask_password(BYVAL AS GTlsInteraction PTR, BYVAL AS GTlsPassword PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GTlsInteractionResult
DECLARE SUB g_tls_interaction_ask_password_async(BYVAL AS GTlsInteraction PTR, BYVAL AS GTlsPassword PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_tls_interaction_ask_password_finish(BYVAL AS GTlsInteraction PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GTlsInteractionResult

#ENDIF ' __G_TLS_INTERACTION_H__

#IFNDEF __G_TLS_SERVER_CONNECTION_H__
#DEFINE __G_TLS_SERVER_CONNECTION_H__

#DEFINE G_TYPE_TLS_SERVER_CONNECTION (g_tls_server_connection_get_type ())
#DEFINE G_TLS_SERVER_CONNECTION(inst) (G_TYPE_CHECK_INSTANCE_CAST ((inst), G_TYPE_TLS_SERVER_CONNECTION, GTlsServerConnection))
#DEFINE G_IS_TLS_SERVER_CONNECTION(inst) (G_TYPE_CHECK_INSTANCE_TYPE ((inst), G_TYPE_TLS_SERVER_CONNECTION))
#DEFINE G_TLS_SERVER_CONNECTION_GET_INTERFACE(inst) (G_TYPE_INSTANCE_GET_INTERFACE ((inst), G_TYPE_TLS_SERVER_CONNECTION, GTlsServerConnectionInterface))

TYPE GTlsServerConnectionInterface AS _GTlsServerConnectionInterface

TYPE _GTlsServerConnectionInterface
  AS GTypeInterface g_iface
END TYPE

DECLARE FUNCTION g_tls_server_connection_get_type() AS GType
DECLARE FUNCTION g_tls_server_connection_new(BYVAL AS GIOStream PTR, BYVAL AS GTlsCertificate PTR, BYVAL AS GError PTR PTR) AS GIOStream PTR

#ENDIF ' __G_TLS_SERVER_CONNECTION_H__

#IFNDEF __G_TLS_PASSWORD_H__
#DEFINE __G_TLS_PASSWORD_H__

#DEFINE G_TYPE_TLS_PASSWORD (g_tls_password_get_type ())
#DEFINE G_TLS_PASSWORD(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_TLS_PASSWORD, GTlsPassword))
#DEFINE G_TLS_PASSWORD_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_TLS_PASSWORD, GTlsPasswordClass))
#DEFINE G_IS_TLS_PASSWORD(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_TLS_PASSWORD))
#DEFINE G_IS_TLS_PASSWORD_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), G_TYPE_TLS_PASSWORD))
#DEFINE G_TLS_PASSWORD_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), G_TYPE_TLS_PASSWORD, GTlsPasswordClass))

TYPE GTlsPasswordClass AS _GTlsPasswordClass
TYPE GTlsPasswordPrivate AS _GTlsPasswordPrivate

TYPE _GTlsPassword
  AS GObject parent_instance
  AS GTlsPasswordPrivate PTR priv
END TYPE

TYPE _GTlsPasswordClass
  AS GObjectClass parent_class
  get_value AS FUNCTION(BYVAL AS GTlsPassword PTR, BYVAL AS gsize PTR) AS CONST guchar PTR
  set_value AS SUB(BYVAL AS GTlsPassword PTR, BYVAL AS guchar PTR, BYVAL AS gssize, BYVAL AS GDestroyNotify)
  get_default_warning AS FUNCTION(BYVAL AS GTlsPassword PTR) AS CONST gchar PTR
  AS gpointer padding(3)
END TYPE

DECLARE FUNCTION g_tls_password_get_type() AS GType
DECLARE FUNCTION g_tls_password_new(BYVAL AS GTlsPasswordFlags, BYVAL AS CONST gchar PTR) AS GTlsPassword PTR
DECLARE FUNCTION g_tls_password_get_value(BYVAL AS GTlsPassword PTR, BYVAL AS gsize PTR) AS CONST guchar PTR
DECLARE SUB g_tls_password_set_value(BYVAL AS GTlsPassword PTR, BYVAL AS CONST guchar PTR, BYVAL AS gssize)
DECLARE SUB g_tls_password_set_value_full(BYVAL AS GTlsPassword PTR, BYVAL AS guchar PTR, BYVAL AS gssize, BYVAL AS GDestroyNotify)
DECLARE FUNCTION g_tls_password_get_flags(BYVAL AS GTlsPassword PTR) AS GTlsPasswordFlags
DECLARE SUB g_tls_password_set_flags(BYVAL AS GTlsPassword PTR, BYVAL AS GTlsPasswordFlags)
DECLARE FUNCTION g_tls_password_get_description(BYVAL AS GTlsPassword PTR) AS CONST gchar PTR
DECLARE SUB g_tls_password_set_description(BYVAL AS GTlsPassword PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION g_tls_password_get_warning(BYVAL AS GTlsPassword PTR) AS CONST gchar PTR
DECLARE SUB g_tls_password_set_warning(BYVAL AS GTlsPassword PTR, BYVAL AS CONST gchar PTR)

#ENDIF ' __G_TLS_PASSWORD_H__

#IFNDEF __G_VFS_H__
#DEFINE __G_VFS_H__

#DEFINE G_TYPE_VFS (g_vfs_get_type ())
#DEFINE G_VFS(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_VFS, GVfs))
#DEFINE G_VFS_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_VFS, GVfsClass))
#DEFINE G_VFS_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), G_TYPE_VFS, GVfsClass))
#DEFINE G_IS_VFS(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_VFS))
#DEFINE G_IS_VFS_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), G_TYPE_VFS))
#DEFINE G_VFS_EXTENSION_POINT_NAME !"gio-vfs"

TYPE GVfsClass AS _GVfsClass

TYPE _GVfs
  AS GObject parent_instance
END TYPE

TYPE _GVfsClass
  AS GObjectClass parent_class
  is_active AS FUNCTION(BYVAL AS GVfs PTR) AS gboolean
  get_file_for_path AS FUNCTION(BYVAL AS GVfs PTR, BYVAL AS CONST ZSTRING PTR) AS GFile PTR
  get_file_for_uri AS FUNCTION(BYVAL AS GVfs PTR, BYVAL AS CONST ZSTRING PTR) AS GFile PTR
  get_supported_uri_schemes AS FUNCTION(BYVAL AS GVfs PTR) AS CONST gchar CONST PTR PTR
  parse_name AS FUNCTION(BYVAL AS GVfs PTR, BYVAL AS CONST ZSTRING PTR) AS GFile PTR
  local_file_add_info AS SUB(BYVAL AS GVfs PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS guint64, BYVAL AS GFileAttributeMatcher PTR, BYVAL AS GFileInfo PTR, BYVAL AS GCancellable PTR, BYVAL AS gpointer PTR, BYVAL AS GDestroyNotify PTR)
  add_writable_namespaces AS SUB(BYVAL AS GVfs PTR, BYVAL AS GFileAttributeInfoList PTR)
  local_file_set_attributes AS FUNCTION(BYVAL AS GVfs PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS GFileInfo PTR, BYVAL AS GFileQueryInfoFlags, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS gboolean
  local_file_removed AS SUB(BYVAL AS GVfs PTR, BYVAL AS CONST ZSTRING PTR)
  local_file_moved AS SUB(BYVAL AS GVfs PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST ZSTRING PTR)
  _g_reserved1 AS SUB()
  _g_reserved2 AS SUB()
  _g_reserved3 AS SUB()
  _g_reserved4 AS SUB()
  _g_reserved5 AS SUB()
  _g_reserved6 AS SUB()
  _g_reserved7 AS SUB()
END TYPE

DECLARE FUNCTION g_vfs_get_type() AS GType
DECLARE FUNCTION g_vfs_is_active(BYVAL AS GVfs PTR) AS gboolean
DECLARE FUNCTION g_vfs_get_file_for_path(BYVAL AS GVfs PTR, BYVAL AS CONST ZSTRING PTR) AS GFile PTR
DECLARE FUNCTION g_vfs_get_file_for_uri(BYVAL AS GVfs PTR, BYVAL AS CONST ZSTRING PTR) AS GFile PTR
DECLARE FUNCTION g_vfs_get_supported_uri_schemes(BYVAL AS GVfs PTR) AS CONST gchar CONST PTR PTR
DECLARE FUNCTION g_vfs_parse_name(BYVAL AS GVfs PTR, BYVAL AS CONST ZSTRING PTR) AS GFile PTR
DECLARE FUNCTION g_vfs_get_default() AS GVfs PTR
DECLARE FUNCTION g_vfs_get_local() AS GVfs PTR

#ENDIF ' __G_VFS_H__

#IFNDEF __G_VOLUME_H__
#DEFINE __G_VOLUME_H__

#DEFINE G_VOLUME_IDENTIFIER_KIND_HAL_UDI !"hal-udi"
#DEFINE G_VOLUME_IDENTIFIER_KIND_UNIX_DEVICE !"unix-device"
#DEFINE G_VOLUME_IDENTIFIER_KIND_LABEL !"label"
#DEFINE G_VOLUME_IDENTIFIER_KIND_UUID !"uuid"
#DEFINE G_VOLUME_IDENTIFIER_KIND_NFS_MOUNT !"nfs-mount"
#DEFINE G_TYPE_VOLUME (g_volume_get_type ())
#DEFINE G_VOLUME(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), G_TYPE_VOLUME, GVolume))
#DEFINE G_IS_VOLUME(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), G_TYPE_VOLUME))
#DEFINE G_VOLUME_GET_IFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), G_TYPE_VOLUME, GVolumeIface))

TYPE GVolumeIface AS _GVolumeIface

TYPE _GVolumeIface
  AS GTypeInterface g_iface
  changed AS SUB(BYVAL AS GVolume PTR)
  removed AS SUB(BYVAL AS GVolume PTR)
  get_name AS FUNCTION(BYVAL AS GVolume PTR) AS ZSTRING PTR
  get_icon AS FUNCTION(BYVAL AS GVolume PTR) AS GIcon PTR
  get_uuid AS FUNCTION(BYVAL AS GVolume PTR) AS ZSTRING PTR
  get_drive AS FUNCTION(BYVAL AS GVolume PTR) AS GDrive PTR
  get_mount AS FUNCTION(BYVAL AS GVolume PTR) AS GMount PTR
  can_mount AS FUNCTION(BYVAL AS GVolume PTR) AS gboolean
  can_eject AS FUNCTION(BYVAL AS GVolume PTR) AS gboolean
  mount_fn AS SUB(BYVAL AS GVolume PTR, BYVAL AS GMountMountFlags, BYVAL AS GMountOperation PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  mount_finish AS FUNCTION(BYVAL AS GVolume PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
  eject AS SUB(BYVAL AS GVolume PTR, BYVAL AS GMountUnmountFlags, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  eject_finish AS FUNCTION(BYVAL AS GVolume PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
  get_identifier AS FUNCTION(BYVAL AS GVolume PTR, BYVAL AS CONST ZSTRING PTR) AS ZSTRING PTR
  enumerate_identifiers AS FUNCTION(BYVAL AS GVolume PTR) AS ZSTRING PTR PTR
  should_automount AS FUNCTION(BYVAL AS GVolume PTR) AS gboolean
  get_activation_root AS FUNCTION(BYVAL AS GVolume PTR) AS GFile PTR
  eject_with_operation AS SUB(BYVAL AS GVolume PTR, BYVAL AS GMountUnmountFlags, BYVAL AS GMountOperation PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
  eject_with_operation_finish AS FUNCTION(BYVAL AS GVolume PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
  get_sort_key AS FUNCTION(BYVAL AS GVolume PTR) AS CONST gchar PTR
END TYPE

DECLARE FUNCTION g_volume_get_type() AS GType
DECLARE FUNCTION g_volume_get_name(BYVAL AS GVolume PTR) AS ZSTRING PTR
DECLARE FUNCTION g_volume_get_icon(BYVAL AS GVolume PTR) AS GIcon PTR
DECLARE FUNCTION g_volume_get_uuid(BYVAL AS GVolume PTR) AS ZSTRING PTR
DECLARE FUNCTION g_volume_get_drive(BYVAL AS GVolume PTR) AS GDrive PTR
DECLARE FUNCTION g_volume_get_mount(BYVAL AS GVolume PTR) AS GMount PTR
DECLARE FUNCTION g_volume_can_mount(BYVAL AS GVolume PTR) AS gboolean
DECLARE FUNCTION g_volume_can_eject(BYVAL AS GVolume PTR) AS gboolean
DECLARE FUNCTION g_volume_should_automount(BYVAL AS GVolume PTR) AS gboolean
DECLARE SUB g_volume_mount(BYVAL AS GVolume PTR, BYVAL AS GMountMountFlags, BYVAL AS GMountOperation PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_volume_mount_finish(BYVAL AS GVolume PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE SUB g_volume_eject(BYVAL AS GVolume PTR, BYVAL AS GMountUnmountFlags, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_volume_eject_finish(BYVAL AS GVolume PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_volume_get_identifier(BYVAL AS GVolume PTR, BYVAL AS CONST ZSTRING PTR) AS ZSTRING PTR
DECLARE FUNCTION g_volume_enumerate_identifiers(BYVAL AS GVolume PTR) AS ZSTRING PTR PTR
DECLARE FUNCTION g_volume_get_activation_root(BYVAL AS GVolume PTR) AS GFile PTR
DECLARE SUB g_volume_eject_with_operation(BYVAL AS GVolume PTR, BYVAL AS GMountUnmountFlags, BYVAL AS GMountOperation PTR, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_volume_eject_with_operation_finish(BYVAL AS GVolume PTR, BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION g_volume_get_sort_key(BYVAL AS GVolume PTR) AS CONST gchar PTR

#ENDIF ' __G_VOLUME_H__

#IFNDEF __G_ZLIB_COMPRESSOR_H__
#DEFINE __G_ZLIB_COMPRESSOR_H__

#DEFINE G_TYPE_ZLIB_COMPRESSOR (g_zlib_compressor_get_type ())
#DEFINE G_ZLIB_COMPRESSOR(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_ZLIB_COMPRESSOR, GZlibCompressor))
#DEFINE G_ZLIB_COMPRESSOR_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_ZLIB_COMPRESSOR, GZlibCompressorClass))
#DEFINE G_IS_ZLIB_COMPRESSOR(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_ZLIB_COMPRESSOR))
#DEFINE G_IS_ZLIB_COMPRESSOR_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), G_TYPE_ZLIB_COMPRESSOR))
#DEFINE G_ZLIB_COMPRESSOR_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), G_TYPE_ZLIB_COMPRESSOR, GZlibCompressorClass))

TYPE GZlibCompressorClass AS _GZlibCompressorClass

TYPE _GZlibCompressorClass
  AS GObjectClass parent_class
END TYPE

DECLARE FUNCTION g_zlib_compressor_get_type() AS GType
DECLARE FUNCTION g_zlib_compressor_new(BYVAL AS GZlibCompressorFormat, BYVAL AS INTEGER) AS GZlibCompressor PTR
DECLARE FUNCTION g_zlib_compressor_get_file_info(BYVAL AS GZlibCompressor PTR) AS GFileInfo PTR
DECLARE SUB g_zlib_compressor_set_file_info(BYVAL AS GZlibCompressor PTR, BYVAL AS GFileInfo PTR)

#ENDIF ' __G_ZLIB_COMPRESSOR_H__

#IFNDEF __G_ZLIB_DECOMPRESSOR_H__
#DEFINE __G_ZLIB_DECOMPRESSOR_H__

#DEFINE G_TYPE_ZLIB_DECOMPRESSOR (g_zlib_decompressor_get_type ())
#DEFINE G_ZLIB_DECOMPRESSOR(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_ZLIB_DECOMPRESSOR, GZlibDecompressor))
#DEFINE G_ZLIB_DECOMPRESSOR_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_ZLIB_DECOMPRESSOR, GZlibDecompressorClass))
#DEFINE G_IS_ZLIB_DECOMPRESSOR(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_ZLIB_DECOMPRESSOR))
#DEFINE G_IS_ZLIB_DECOMPRESSOR_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), G_TYPE_ZLIB_DECOMPRESSOR))
#DEFINE G_ZLIB_DECOMPRESSOR_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), G_TYPE_ZLIB_DECOMPRESSOR, GZlibDecompressorClass))

TYPE GZlibDecompressorClass AS _GZlibDecompressorClass

TYPE _GZlibDecompressorClass
  AS GObjectClass parent_class
END TYPE

DECLARE FUNCTION g_zlib_decompressor_get_type() AS GType
DECLARE FUNCTION g_zlib_decompressor_new(BYVAL AS GZlibCompressorFormat) AS GZlibDecompressor PTR
DECLARE FUNCTION g_zlib_decompressor_get_file_info(BYVAL AS GZlibDecompressor PTR) AS GFileInfo PTR

#ENDIF ' __G_ZLIB_DECOMPRESSOR_H__

#IFNDEF __G_DBUS_INTERFACE_H__
#DEFINE __G_DBUS_INTERFACE_H__

#DEFINE G_TYPE_DBUS_INTERFACE (g_dbus_interface_get_type())
#DEFINE G_DBUS_INTERFACE(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_DBUS_INTERFACE, GDBusInterface))
#DEFINE G_IS_DBUS_INTERFACE(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_DBUS_INTERFACE))
#DEFINE G_DBUS_INTERFACE_GET_IFACE(o) (G_TYPE_INSTANCE_GET_INTERFACE((o), G_TYPE_DBUS_INTERFACE, GDBusInterfaceIface))

TYPE GDBusInterfaceIface AS _GDBusInterfaceIface

TYPE _GDBusInterfaceIface
  AS GTypeInterface parent_iface
  get_info AS FUNCTION(BYVAL AS GDBusInterface PTR) AS GDBusInterfaceInfo PTR
  get_object AS FUNCTION(BYVAL AS GDBusInterface PTR) AS GDBusObject PTR
  set_object AS SUB(BYVAL AS GDBusInterface PTR, BYVAL AS GDBusObject PTR)
END TYPE

DECLARE FUNCTION g_dbus_interface_get_type() AS GType
DECLARE FUNCTION g_dbus_interface_get_info(BYVAL AS GDBusInterface PTR) AS GDBusInterfaceInfo PTR
DECLARE FUNCTION g_dbus_interface_get_object(BYVAL AS GDBusInterface PTR) AS GDBusObject PTR
DECLARE SUB g_dbus_interface_set_object(BYVAL AS GDBusInterface PTR, BYVAL AS GDBusObject PTR)

#ENDIF ' __G_DBUS_INTERFACE_H__

#IFNDEF __G_DBUS_INTERFACE_SKELETON_H__
#DEFINE __G_DBUS_INTERFACE_SKELETON_H__

#DEFINE G_TYPE_DBUS_INTERFACE_SKELETON (g_dbus_interface_skeleton_get_type ())
#DEFINE G_DBUS_INTERFACE_SKELETON(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_DBUS_INTERFACE_SKELETON, GDBusInterfaceSkeleton))
#DEFINE G_DBUS_INTERFACE_SKELETON_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_DBUS_INTERFACE_SKELETON, GDBusInterfaceSkeletonClass))
#DEFINE G_DBUS_INTERFACE_SKELETON_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), G_TYPE_DBUS_INTERFACE_SKELETON, GDBusInterfaceSkeletonClass))
#DEFINE G_IS_DBUS_INTERFACE_SKELETON(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_DBUS_INTERFACE_SKELETON))
#DEFINE G_IS_DBUS_INTERFACE_SKELETON_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), G_TYPE_DBUS_INTERFACE_SKELETON))

TYPE GDBusInterfaceSkeletonClass AS _GDBusInterfaceSkeletonClass
TYPE GDBusInterfaceSkeletonPrivate AS _GDBusInterfaceSkeletonPrivate

TYPE _GDBusInterfaceSkeleton
  AS GObject parent_instance
  AS GDBusInterfaceSkeletonPrivate PTR priv
END TYPE

TYPE _GDBusInterfaceSkeletonClass
  AS GObjectClass parent_class
  get_info AS FUNCTION(BYVAL AS GDBusInterfaceSkeleton PTR) AS GDBusInterfaceInfo PTR
  get_vtable AS FUNCTION(BYVAL AS GDBusInterfaceSkeleton PTR) AS GDBusInterfaceVTable PTR
  get_properties AS FUNCTION(BYVAL AS GDBusInterfaceSkeleton PTR) AS GVariant PTR
  flush AS SUB(BYVAL AS GDBusInterfaceSkeleton PTR)
  AS gpointer vfunc_padding(7)
  g_authorize_method AS FUNCTION(BYVAL AS GDBusInterfaceSkeleton PTR, BYVAL AS GDBusMethodInvocation PTR) AS gboolean
  AS gpointer signal_padding(7)
END TYPE

DECLARE FUNCTION g_dbus_interface_skeleton_get_type() AS GType
DECLARE FUNCTION g_dbus_interface_skeleton_get_flags(BYVAL AS GDBusInterfaceSkeleton PTR) AS GDBusInterfaceSkeletonFlags
DECLARE SUB g_dbus_interface_skeleton_set_flags(BYVAL AS GDBusInterfaceSkeleton PTR, BYVAL AS GDBusInterfaceSkeletonFlags)
DECLARE FUNCTION g_dbus_interface_skeleton_get_info(BYVAL AS GDBusInterfaceSkeleton PTR) AS GDBusInterfaceInfo PTR
DECLARE FUNCTION g_dbus_interface_skeleton_get_vtable(BYVAL AS GDBusInterfaceSkeleton PTR) AS GDBusInterfaceVTable PTR
DECLARE FUNCTION g_dbus_interface_skeleton_get_properties(BYVAL AS GDBusInterfaceSkeleton PTR) AS GVariant PTR
DECLARE SUB g_dbus_interface_skeleton_flush(BYVAL AS GDBusInterfaceSkeleton PTR)
DECLARE FUNCTION g_dbus_interface_skeleton_export(BYVAL AS GDBusInterfaceSkeleton PTR, BYVAL AS GDBusConnection PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE SUB g_dbus_interface_skeleton_unexport(BYVAL AS GDBusInterfaceSkeleton PTR)
DECLARE SUB g_dbus_interface_skeleton_unexport_from_connection(BYVAL AS GDBusInterfaceSkeleton PTR, BYVAL AS GDBusConnection PTR)
DECLARE FUNCTION g_dbus_interface_skeleton_get_connection(BYVAL AS GDBusInterfaceSkeleton PTR) AS GDBusConnection PTR
DECLARE FUNCTION g_dbus_interface_skeleton_get_connections(BYVAL AS GDBusInterfaceSkeleton PTR) AS GList PTR
DECLARE FUNCTION g_dbus_interface_skeleton_has_connection(BYVAL AS GDBusInterfaceSkeleton PTR, BYVAL AS GDBusConnection PTR) AS gboolean
DECLARE FUNCTION g_dbus_interface_skeleton_get_object_path(BYVAL AS GDBusInterfaceSkeleton PTR) AS CONST gchar PTR

#ENDIF ' __G_DBUS_INTERFACE_SKELETON_H__

#IFNDEF __G_DBUS_OBJECT_H__
#DEFINE __G_DBUS_OBJECT_H__

#DEFINE G_TYPE_DBUS_OBJECT (g_dbus_object_get_type())
#DEFINE G_DBUS_OBJECT(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_DBUS_OBJECT, GDBusObject))
#DEFINE G_IS_DBUS_OBJECT(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_DBUS_OBJECT))
#DEFINE G_DBUS_OBJECT_GET_IFACE(o) (G_TYPE_INSTANCE_GET_INTERFACE((o), G_TYPE_DBUS_OBJECT, GDBusObjectIface))

TYPE GDBusObjectIface AS _GDBusObjectIface

TYPE _GDBusObjectIface
  AS GTypeInterface parent_iface
  get_object_path AS FUNCTION(BYVAL AS GDBusObject PTR) AS CONST gchar PTR
  get_interfaces AS FUNCTION(BYVAL AS GDBusObject PTR) AS GList PTR
  get_interface AS FUNCTION(BYVAL AS GDBusObject PTR, BYVAL AS CONST gchar PTR) AS GDBusInterface PTR
  interface_added AS SUB(BYVAL AS GDBusObject PTR, BYVAL AS GDBusInterface PTR)
  interface_removed AS SUB(BYVAL AS GDBusObject PTR, BYVAL AS GDBusInterface PTR)
END TYPE

DECLARE FUNCTION g_dbus_object_get_type() AS GType
DECLARE FUNCTION g_dbus_object_get_object_path(BYVAL AS GDBusObject PTR) AS CONST gchar PTR
DECLARE FUNCTION g_dbus_object_get_interfaces(BYVAL AS GDBusObject PTR) AS GList PTR
DECLARE FUNCTION g_dbus_object_get_interface(BYVAL AS GDBusObject PTR, BYVAL AS CONST gchar PTR) AS GDBusInterface PTR

#ENDIF ' __G_DBUS_OBJECT_H__

#IFNDEF __G_DBUS_OBJECT_SKELETON_H__
#DEFINE __G_DBUS_OBJECT_SKELETON_H__

#DEFINE G_TYPE_DBUS_OBJECT_SKELETON (g_dbus_object_skeleton_get_type ())
#DEFINE G_DBUS_OBJECT_SKELETON(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_DBUS_OBJECT_SKELETON, GDBusObjectSkeleton))
#DEFINE G_DBUS_OBJECT_SKELETON_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_DBUS_OBJECT_SKELETON, GDBusObjectSkeletonClass))
#DEFINE G_DBUS_OBJECT_SKELETON_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), G_TYPE_DBUS_OBJECT_SKELETON, GDBusObjectSkeletonClass))
#DEFINE G_IS_DBUS_OBJECT_SKELETON(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_DBUS_OBJECT_SKELETON))
#DEFINE G_IS_DBUS_OBJECT_SKELETON_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), G_TYPE_DBUS_OBJECT_SKELETON))

TYPE GDBusObjectSkeletonClass AS _GDBusObjectSkeletonClass
TYPE GDBusObjectSkeletonPrivate AS _GDBusObjectSkeletonPrivate

TYPE _GDBusObjectSkeleton
  AS GObject parent_instance
  AS GDBusObjectSkeletonPrivate PTR priv
END TYPE

TYPE _GDBusObjectSkeletonClass
  AS GObjectClass parent_class
  authorize_method AS FUNCTION(BYVAL AS GDBusObjectSkeleton PTR, BYVAL AS GDBusInterfaceSkeleton PTR, BYVAL AS GDBusMethodInvocation PTR) AS gboolean
  AS gpointer padding(7)
END TYPE

DECLARE FUNCTION g_dbus_object_skeleton_get_type() AS GType
DECLARE FUNCTION g_dbus_object_skeleton_new(BYVAL AS CONST gchar PTR) AS GDBusObjectSkeleton PTR
DECLARE SUB g_dbus_object_skeleton_flush(BYVAL AS GDBusObjectSkeleton PTR)
DECLARE SUB g_dbus_object_skeleton_add_interface(BYVAL AS GDBusObjectSkeleton PTR, BYVAL AS GDBusInterfaceSkeleton PTR)
DECLARE SUB g_dbus_object_skeleton_remove_interface(BYVAL AS GDBusObjectSkeleton PTR, BYVAL AS GDBusInterfaceSkeleton PTR)
DECLARE SUB g_dbus_object_skeleton_remove_interface_by_name(BYVAL AS GDBusObjectSkeleton PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB g_dbus_object_skeleton_set_object_path(BYVAL AS GDBusObjectSkeleton PTR, BYVAL AS CONST gchar PTR)

#ENDIF ' __G_DBUS_OBJECT_SKELETON_H__

#IFNDEF __G_DBUS_OBJECT_PROXY_H__
#DEFINE __G_DBUS_OBJECT_PROXY_H__

#DEFINE G_TYPE_DBUS_OBJECT_PROXY (g_dbus_object_proxy_get_type ())
#DEFINE G_DBUS_OBJECT_PROXY(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_DBUS_OBJECT_PROXY, GDBusObjectProxy))
#DEFINE G_DBUS_OBJECT_PROXY_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_DBUS_OBJECT_PROXY, GDBusObjectProxyClass))
#DEFINE G_DBUS_OBJECT_PROXY_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), G_TYPE_DBUS_OBJECT_PROXY, GDBusObjectProxyClass))
#DEFINE G_IS_DBUS_OBJECT_PROXY(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_DBUS_OBJECT_PROXY))
#DEFINE G_IS_DBUS_OBJECT_PROXY_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), G_TYPE_DBUS_OBJECT_PROXY))

TYPE GDBusObjectProxyClass AS _GDBusObjectProxyClass
TYPE GDBusObjectProxyPrivate AS _GDBusObjectProxyPrivate

TYPE _GDBusObjectProxy
  AS GObject parent_instance
  AS GDBusObjectProxyPrivate PTR priv
END TYPE

TYPE _GDBusObjectProxyClass
  AS GObjectClass parent_class
  AS gpointer padding(7)
END TYPE

DECLARE FUNCTION g_dbus_object_proxy_get_type() AS GType
DECLARE FUNCTION g_dbus_object_proxy_new(BYVAL AS GDBusConnection PTR, BYVAL AS CONST gchar PTR) AS GDBusObjectProxy PTR
DECLARE FUNCTION g_dbus_object_proxy_get_connection(BYVAL AS GDBusObjectProxy PTR) AS GDBusConnection PTR

#ENDIF ' __G_DBUS_OBJECT_PROXY_H__

#IFNDEF __G_DBUS_OBJECT_MANAGER_H__
#DEFINE __G_DBUS_OBJECT_MANAGER_H__

#DEFINE G_TYPE_DBUS_OBJECT_MANAGER (g_dbus_object_manager_get_type())
#DEFINE G_DBUS_OBJECT_MANAGER(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_DBUS_OBJECT_MANAGER, GDBusObjectManager))
#DEFINE G_IS_DBUS_OBJECT_MANAGER(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_DBUS_OBJECT_MANAGER))
#DEFINE G_DBUS_OBJECT_MANAGER_GET_IFACE(o) (G_TYPE_INSTANCE_GET_INTERFACE((o), G_TYPE_DBUS_OBJECT_MANAGER, GDBusObjectManagerIface))

TYPE GDBusObjectManagerIface AS _GDBusObjectManagerIface

TYPE _GDBusObjectManagerIface
  AS GTypeInterface parent_iface
  get_object_path AS FUNCTION(BYVAL AS GDBusObjectManager PTR) AS CONST gchar PTR
  get_objects AS FUNCTION(BYVAL AS GDBusObjectManager PTR) AS GList PTR
  get_object AS FUNCTION(BYVAL AS GDBusObjectManager PTR, BYVAL AS CONST gchar PTR) AS GDBusObject PTR
  get_interface AS FUNCTION(BYVAL AS GDBusObjectManager PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR) AS GDBusInterface PTR
  object_added AS SUB(BYVAL AS GDBusObjectManager PTR, BYVAL AS GDBusObject PTR)
  object_removed AS SUB(BYVAL AS GDBusObjectManager PTR, BYVAL AS GDBusObject PTR)
  interface_added AS SUB(BYVAL AS GDBusObjectManager PTR, BYVAL AS GDBusObject PTR, BYVAL AS GDBusInterface PTR)
  interface_removed AS SUB(BYVAL AS GDBusObjectManager PTR, BYVAL AS GDBusObject PTR, BYVAL AS GDBusInterface PTR)
END TYPE

DECLARE FUNCTION g_dbus_object_manager_get_type() AS GType
DECLARE FUNCTION g_dbus_object_manager_get_object_path(BYVAL AS GDBusObjectManager PTR) AS CONST gchar PTR
DECLARE FUNCTION g_dbus_object_manager_get_objects(BYVAL AS GDBusObjectManager PTR) AS GList PTR
DECLARE FUNCTION g_dbus_object_manager_get_object(BYVAL AS GDBusObjectManager PTR, BYVAL AS CONST gchar PTR) AS GDBusObject PTR
DECLARE FUNCTION g_dbus_object_manager_get_interface(BYVAL AS GDBusObjectManager PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR) AS GDBusInterface PTR

#ENDIF ' __G_DBUS_OBJECT_MANAGER_H__

#IFNDEF __G_DBUS_OBJECT_MANAGER_CLIENT_H__
#DEFINE __G_DBUS_OBJECT_MANAGER_CLIENT_H__

#DEFINE G_TYPE_DBUS_OBJECT_MANAGER_CLIENT (g_dbus_object_manager_client_get_type ())
#DEFINE G_DBUS_OBJECT_MANAGER_CLIENT(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_DBUS_OBJECT_MANAGER_CLIENT, GDBusObjectManagerClient))
#DEFINE G_DBUS_OBJECT_MANAGER_CLIENT_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_DBUS_OBJECT_MANAGER_CLIENT, GDBusObjectManagerClientClass))
#DEFINE G_DBUS_OBJECT_MANAGER_CLIENT_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), G_TYPE_DBUS_OBJECT_MANAGER_CLIENT, GDBusObjectManagerClientClass))
#DEFINE G_IS_DBUS_OBJECT_MANAGER_CLIENT(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_DBUS_OBJECT_MANAGER_CLIENT))
#DEFINE G_IS_DBUS_OBJECT_MANAGER_CLIENT_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), G_TYPE_DBUS_OBJECT_MANAGER_CLIENT))

TYPE GDBusObjectManagerClientClass AS _GDBusObjectManagerClientClass
TYPE GDBusObjectManagerClientPrivate AS _GDBusObjectManagerClientPrivate

TYPE _GDBusObjectManagerClient
  AS GObject parent_instance
  AS GDBusObjectManagerClientPrivate PTR priv
END TYPE

TYPE _GDBusObjectManagerClientClass
  AS GObjectClass parent_class
  interface_proxy_signal AS SUB(BYVAL AS GDBusObjectManagerClient PTR, BYVAL AS GDBusObjectProxy PTR, BYVAL AS GDBusProxy PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GVariant PTR)
  interface_proxy_properties_changed AS SUB(BYVAL AS GDBusObjectManagerClient PTR, BYVAL AS GDBusObjectProxy PTR, BYVAL AS GDBusProxy PTR, BYVAL AS GVariant PTR, BYVAL AS CONST gchar CONST PTR PTR)
  AS gpointer padding(7)
END TYPE

DECLARE FUNCTION g_dbus_object_manager_client_get_type() AS GType
DECLARE SUB g_dbus_object_manager_client_new(BYVAL AS GDBusConnection PTR, BYVAL AS GDBusObjectManagerClientFlags, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GDBusProxyTypeFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_dbus_object_manager_client_new_finish(BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GDBusObjectManager PTR
DECLARE FUNCTION g_dbus_object_manager_client_new_sync(BYVAL AS GDBusConnection PTR, BYVAL AS GDBusObjectManagerClientFlags, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GDBusProxyTypeFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GDBusObjectManager PTR
DECLARE SUB g_dbus_object_manager_client_new_for_bus(BYVAL AS GBusType, BYVAL AS GDBusObjectManagerClientFlags, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GDBusProxyTypeFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify, BYVAL AS GCancellable PTR, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
DECLARE FUNCTION g_dbus_object_manager_client_new_for_bus_finish(BYVAL AS GAsyncResult PTR, BYVAL AS GError PTR PTR) AS GDBusObjectManager PTR
DECLARE FUNCTION g_dbus_object_manager_client_new_for_bus_sync(BYVAL AS GBusType, BYVAL AS GDBusObjectManagerClientFlags, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GDBusProxyTypeFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GDBusObjectManager PTR
DECLARE FUNCTION g_dbus_object_manager_client_get_connection(BYVAL AS GDBusObjectManagerClient PTR) AS GDBusConnection PTR
DECLARE FUNCTION g_dbus_object_manager_client_get_flags(BYVAL AS GDBusObjectManagerClient PTR) AS GDBusObjectManagerClientFlags
DECLARE FUNCTION g_dbus_object_manager_client_get_name(BYVAL AS GDBusObjectManagerClient PTR) AS CONST gchar PTR
DECLARE FUNCTION g_dbus_object_manager_client_get_name_owner(BYVAL AS GDBusObjectManagerClient PTR) AS gchar PTR

#ENDIF ' __G_DBUS_OBJECT_MANAGER_CLIENT_H__

#IFNDEF __G_DBUS_OBJECT_MANAGER_SERVER_H__
#DEFINE __G_DBUS_OBJECT_MANAGER_SERVER_H__

#DEFINE G_TYPE_DBUS_OBJECT_MANAGER_SERVER (g_dbus_object_manager_server_get_type ())
#DEFINE G_DBUS_OBJECT_MANAGER_SERVER(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), G_TYPE_DBUS_OBJECT_MANAGER_SERVER, GDBusObjectManagerServer))
#DEFINE G_DBUS_OBJECT_MANAGER_SERVER_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), G_TYPE_DBUS_OBJECT_MANAGER_SERVER, GDBusObjectManagerServerClass))
#DEFINE G_DBUS_OBJECT_MANAGER_SERVER_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), G_TYPE_DBUS_OBJECT_MANAGER_SERVER, GDBusObjectManagerServerClass))
#DEFINE G_IS_DBUS_OBJECT_MANAGER_SERVER(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), G_TYPE_DBUS_OBJECT_MANAGER_SERVER))
#DEFINE G_IS_DBUS_OBJECT_MANAGER_SERVER_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), G_TYPE_DBUS_OBJECT_MANAGER_SERVER))

TYPE GDBusObjectManagerServerClass AS _GDBusObjectManagerServerClass
TYPE GDBusObjectManagerServerPrivate AS _GDBusObjectManagerServerPrivate

TYPE _GDBusObjectManagerServer
  AS GObject parent_instance
  AS GDBusObjectManagerServerPrivate PTR priv
END TYPE

TYPE _GDBusObjectManagerServerClass
  AS GObjectClass parent_class
  AS gpointer padding(7)
END TYPE

DECLARE FUNCTION g_dbus_object_manager_server_get_type() AS GType
DECLARE FUNCTION g_dbus_object_manager_server_new(BYVAL AS CONST gchar PTR) AS GDBusObjectManagerServer PTR
DECLARE FUNCTION g_dbus_object_manager_server_get_connection(BYVAL AS GDBusObjectManagerServer PTR) AS GDBusConnection PTR
DECLARE SUB g_dbus_object_manager_server_set_connection(BYVAL AS GDBusObjectManagerServer PTR, BYVAL AS GDBusConnection PTR)
DECLARE SUB g_dbus_object_manager_server_export(BYVAL AS GDBusObjectManagerServer PTR, BYVAL AS GDBusObjectSkeleton PTR)
DECLARE SUB g_dbus_object_manager_server_export_uniquely(BYVAL AS GDBusObjectManagerServer PTR, BYVAL AS GDBusObjectSkeleton PTR)
DECLARE FUNCTION g_dbus_object_manager_server_unexport(BYVAL AS GDBusObjectManagerServer PTR, BYVAL AS CONST gchar PTR) AS gboolean

#ENDIF ' __G_DBUS_OBJECT_MANAGER_SERVER_H__

#IFNDEF __G_DBUS_ACTION_GROUP_H__
#DEFINE __G_DBUS_ACTION_GROUP_H__

#DEFINE G_TYPE_DBUS_ACTION_GROUP (g_dbus_action_group_get_type ())
#DEFINE G_DBUS_ACTION_GROUP(inst) (G_TYPE_CHECK_INSTANCE_CAST ((inst), _
                                                             G_TYPE_DBUS_ACTION_GROUP, GDBusActionGroup))
#DEFINE G_DBUS_ACTION_GROUP_CLASS(class) (G_TYPE_CHECK_CLASS_CAST ((class), _
                                                             G_TYPE_DBUS_ACTION_GROUP, GDBusActionGroupClass))
#DEFINE G_IS_DBUS_ACTION_GROUP(inst) (G_TYPE_CHECK_INSTANCE_TYPE ((inst), _
                                                             G_TYPE_DBUS_ACTION_GROUP))
#DEFINE G_IS_DBUS_ACTION_GROUP_CLASS(class) (G_TYPE_CHECK_CLASS_TYPE ((class), _
                                                             G_TYPE_DBUS_ACTION_GROUP))
#DEFINE G_DBUS_ACTION_GROUP_GET_CLASS(inst) (G_TYPE_INSTANCE_GET_CLASS ((inst), _
                                                             G_TYPE_DBUS_ACTION_GROUP, GDBusActionGroupClass))

DECLARE FUNCTION g_dbus_action_group_get_type() AS GType
DECLARE FUNCTION g_dbus_action_group_get(BYVAL AS GDBusConnection PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR) AS GDBusActionGroup PTR

#ENDIF ' __G_DBUS_ACTION_GROUP_H__

#IFNDEF __G_MENU_MODEL_H__
#DEFINE __G_MENU_MODEL_H__

#DEFINE G_MENU_ATTRIBUTE_ACTION !"action"
#DEFINE G_MENU_ATTRIBUTE_TARGET !"target"
#DEFINE G_MENU_ATTRIBUTE_LABEL !"label"
#DEFINE G_MENU_LINK_SUBMENU !"submenu"
#DEFINE G_MENU_LINK_SECTION !"section"
#DEFINE G_TYPE_MENU_MODEL (g_menu_model_get_type ())
#DEFINE G_MENU_MODEL(inst) (G_TYPE_CHECK_INSTANCE_CAST ((inst), _
                                                             G_TYPE_MENU_MODEL, GMenuModel))
#DEFINE G_MENU_MODEL_CLASS(class) (G_TYPE_CHECK_CLASS_CAST ((class), _
                                                             G_TYPE_MENU_MODEL, GMenuModelClass))
#DEFINE G_IS_MENU_MODEL(inst) (G_TYPE_CHECK_INSTANCE_TYPE ((inst), _
                                                             G_TYPE_MENU_MODEL))
#DEFINE G_IS_MENU_MODEL_CLASS(class) (G_TYPE_CHECK_CLASS_TYPE ((class), _
                                                             G_TYPE_MENU_MODEL))
#DEFINE G_MENU_MODEL_GET_CLASS(inst) (G_TYPE_INSTANCE_GET_CLASS ((inst), _
                                                             G_TYPE_MENU_MODEL, GMenuModelClass))

TYPE GMenuModelPrivate AS _GMenuModelPrivate
TYPE GMenuModelClass AS _GMenuModelClass
TYPE GMenuAttributeIterPrivate AS _GMenuAttributeIterPrivate
TYPE GMenuAttributeIterClass AS _GMenuAttributeIterClass
TYPE GMenuAttributeIter AS _GMenuAttributeIter
TYPE GMenuLinkIterPrivate AS _GMenuLinkIterPrivate
TYPE GMenuLinkIterClass AS _GMenuLinkIterClass
TYPE GMenuLinkIter AS _GMenuLinkIter

TYPE _GMenuModel
  AS GObject parent_instance
  AS GMenuModelPrivate PTR priv
END TYPE

TYPE _GMenuModelClass
  AS GObjectClass parent_class
  is_mutable AS FUNCTION(BYVAL AS GMenuModel PTR) AS gboolean
  get_n_items AS FUNCTION(BYVAL AS GMenuModel PTR) AS gint
  get_item_attributes AS SUB(BYVAL AS GMenuModel PTR, BYVAL AS gint, BYVAL AS GHashTable PTR PTR)
  iterate_item_attributes AS FUNCTION(BYVAL AS GMenuModel PTR, BYVAL AS gint) AS GMenuAttributeIter PTR
  get_item_attribute_value AS FUNCTION(BYVAL AS GMenuModel PTR, BYVAL AS gint, BYVAL AS CONST gchar PTR, BYVAL AS CONST GVariantType PTR) AS GVariant PTR
  get_item_links AS SUB(BYVAL AS GMenuModel PTR, BYVAL AS gint, BYVAL AS GHashTable PTR PTR)
  iterate_item_links AS FUNCTION(BYVAL AS GMenuModel PTR, BYVAL AS gint) AS GMenuLinkIter PTR
  get_item_link AS FUNCTION(BYVAL AS GMenuModel PTR, BYVAL AS gint, BYVAL AS CONST gchar PTR) AS GMenuModel PTR
END TYPE

DECLARE FUNCTION g_menu_model_get_type() AS GType
DECLARE FUNCTION g_menu_model_is_mutable(BYVAL AS GMenuModel PTR) AS gboolean
DECLARE FUNCTION g_menu_model_get_n_items(BYVAL AS GMenuModel PTR) AS gint
DECLARE FUNCTION g_menu_model_iterate_item_attributes(BYVAL AS GMenuModel PTR, BYVAL AS gint) AS GMenuAttributeIter PTR
DECLARE FUNCTION g_menu_model_get_item_attribute_value(BYVAL AS GMenuModel PTR, BYVAL AS gint, BYVAL AS CONST gchar PTR, BYVAL AS CONST GVariantType PTR) AS GVariant PTR
DECLARE FUNCTION g_menu_model_get_item_attribute(BYVAL AS GMenuModel PTR, BYVAL AS gint, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, ...) AS gboolean
DECLARE FUNCTION g_menu_model_iterate_item_links(BYVAL AS GMenuModel PTR, BYVAL AS gint) AS GMenuLinkIter PTR
DECLARE FUNCTION g_menu_model_get_item_link(BYVAL AS GMenuModel PTR, BYVAL AS gint, BYVAL AS CONST gchar PTR) AS GMenuModel PTR
DECLARE SUB g_menu_model_items_changed(BYVAL AS GMenuModel PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint)

#DEFINE G_TYPE_MENU_ATTRIBUTE_ITER (g_menu_attribute_iter_get_type ())
#DEFINE G_MENU_ATTRIBUTE_ITER(inst) (G_TYPE_CHECK_INSTANCE_CAST ((inst), _
                                                             G_TYPE_MENU_ATTRIBUTE_ITER, GMenuAttributeIter))
#DEFINE G_MENU_ATTRIBUTE_ITER_CLASS(class) (G_TYPE_CHECK_CLASS_CAST ((class), _
                                                             G_TYPE_MENU_ATTRIBUTE_ITER, GMenuAttributeIterClass))
#DEFINE G_IS_MENU_ATTRIBUTE_ITER(inst) (G_TYPE_CHECK_INSTANCE_TYPE ((inst), _
                                                             G_TYPE_MENU_ATTRIBUTE_ITER))
#DEFINE G_IS_MENU_ATTRIBUTE_ITER_CLASS(class) (G_TYPE_CHECK_CLASS_TYPE ((class), _
                                                             G_TYPE_MENU_ATTRIBUTE_ITER))
#DEFINE G_MENU_ATTRIBUTE_ITER_GET_CLASS(inst) (G_TYPE_INSTANCE_GET_CLASS ((inst), _
                                                             G_TYPE_MENU_ATTRIBUTE_ITER, GMenuAttributeIterClass))

TYPE _GMenuAttributeIter
  AS GObject parent_instance
  AS GMenuAttributeIterPrivate PTR priv
END TYPE

TYPE _GMenuAttributeIterClass
  AS GObjectClass parent_class
  get_next AS FUNCTION(BYVAL AS GMenuAttributeIter PTR, BYVAL AS CONST gchar PTR PTR, BYVAL AS GVariant PTR PTR) AS gboolean
END TYPE

DECLARE FUNCTION g_menu_attribute_iter_get_type() AS GType
DECLARE FUNCTION g_menu_attribute_iter_get_next(BYVAL AS GMenuAttributeIter PTR, BYVAL AS CONST gchar PTR PTR, BYVAL AS GVariant PTR PTR) AS gboolean
DECLARE FUNCTION g_menu_attribute_iter_next(BYVAL AS GMenuAttributeIter PTR) AS gboolean
DECLARE FUNCTION g_menu_attribute_iter_get_name(BYVAL AS GMenuAttributeIter PTR) AS CONST gchar PTR
DECLARE FUNCTION g_menu_attribute_iter_get_value(BYVAL AS GMenuAttributeIter PTR) AS GVariant PTR

#DEFINE G_TYPE_MENU_LINK_ITER (g_menu_link_iter_get_type ())
#DEFINE G_MENU_LINK_ITER(inst) (G_TYPE_CHECK_INSTANCE_CAST ((inst), _
                                                             G_TYPE_MENU_LINK_ITER, GMenuLinkIter))
#DEFINE G_MENU_LINK_ITER_CLASS(class) (G_TYPE_CHECK_CLASS_CAST ((class), _
                                                             G_TYPE_MENU_LINK_ITER, GMenuLinkIterClass))
#DEFINE G_IS_MENU_LINK_ITER(inst) (G_TYPE_CHECK_INSTANCE_TYPE ((inst), _
                                                             G_TYPE_MENU_LINK_ITER))
#DEFINE G_IS_MENU_LINK_ITER_CLASS(class) (G_TYPE_CHECK_CLASS_TYPE ((class), _
                                                             G_TYPE_MENU_LINK_ITER))
#DEFINE G_MENU_LINK_ITER_GET_CLASS(inst) (G_TYPE_INSTANCE_GET_CLASS ((inst), _
                                                             G_TYPE_MENU_LINK_ITER, GMenuLinkIterClass))

TYPE _GMenuLinkIter
  AS GObject parent_instance
  AS GMenuLinkIterPrivate PTR priv
END TYPE

TYPE _GMenuLinkIterClass
  AS GObjectClass parent_class
  get_next AS FUNCTION(BYVAL AS GMenuLinkIter PTR, BYVAL AS CONST gchar PTR PTR, BYVAL AS GMenuModel PTR PTR) AS gboolean
END TYPE

DECLARE FUNCTION g_menu_link_iter_get_type() AS GType
DECLARE FUNCTION g_menu_link_iter_get_next(BYVAL AS GMenuLinkIter PTR, BYVAL AS CONST gchar PTR PTR, BYVAL AS GMenuModel PTR PTR) AS gboolean
DECLARE FUNCTION g_menu_link_iter_next(BYVAL AS GMenuLinkIter PTR) AS gboolean
DECLARE FUNCTION g_menu_link_iter_get_name(BYVAL AS GMenuLinkIter PTR) AS CONST gchar PTR
DECLARE FUNCTION g_menu_link_iter_get_value(BYVAL AS GMenuLinkIter PTR) AS GMenuModel PTR

#ENDIF ' __G_MENU_MODEL_H__

#IFNDEF __G_MENU_H__
#DEFINE __G_MENU_H__

#DEFINE G_TYPE_MENU (g_menu_get_type ())
#DEFINE G_MENU(inst) (G_TYPE_CHECK_INSTANCE_CAST ((inst), _
                              G_TYPE_MENU, GMenu))
#DEFINE G_IS_MENU(inst) (G_TYPE_CHECK_INSTANCE_TYPE ((inst), _
                              G_TYPE_MENU))
#DEFINE G_TYPE_MENU_ITEM (g_menu_item_get_type ())
#DEFINE G_MENU_ITEM(inst) (G_TYPE_CHECK_INSTANCE_CAST ((inst), _
                              G_TYPE_MENU_ITEM, GMenuItem))
#DEFINE G_IS_MENU_ITEM(inst) (G_TYPE_CHECK_INSTANCE_TYPE ((inst), _
                              G_TYPE_MENU_ITEM))

TYPE GMenuItem AS _GMenuItem
TYPE GMenu AS _GMenu

DECLARE FUNCTION g_menu_get_type() AS GType
DECLARE FUNCTION g_menu_new() AS GMenu PTR
DECLARE SUB g_menu_freeze(BYVAL AS GMenu PTR)
DECLARE SUB g_menu_insert_item(BYVAL AS GMenu PTR, BYVAL AS gint, BYVAL AS GMenuItem PTR)
DECLARE SUB g_menu_prepend_item(BYVAL AS GMenu PTR, BYVAL AS GMenuItem PTR)
DECLARE SUB g_menu_append_item(BYVAL AS GMenu PTR, BYVAL AS GMenuItem PTR)
DECLARE SUB g_menu_remove(BYVAL AS GMenu PTR, BYVAL AS gint)
DECLARE SUB g_menu_insert(BYVAL AS GMenu PTR, BYVAL AS gint, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB g_menu_prepend(BYVAL AS GMenu PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB g_menu_append(BYVAL AS GMenu PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB g_menu_insert_section(BYVAL AS GMenu PTR, BYVAL AS gint, BYVAL AS CONST gchar PTR, BYVAL AS GMenuModel PTR)
DECLARE SUB g_menu_prepend_section(BYVAL AS GMenu PTR, BYVAL AS CONST gchar PTR, BYVAL AS GMenuModel PTR)
DECLARE SUB g_menu_append_section(BYVAL AS GMenu PTR, BYVAL AS CONST gchar PTR, BYVAL AS GMenuModel PTR)
DECLARE SUB g_menu_insert_submenu(BYVAL AS GMenu PTR, BYVAL AS gint, BYVAL AS CONST gchar PTR, BYVAL AS GMenuModel PTR)
DECLARE SUB g_menu_prepend_submenu(BYVAL AS GMenu PTR, BYVAL AS CONST gchar PTR, BYVAL AS GMenuModel PTR)
DECLARE SUB g_menu_append_submenu(BYVAL AS GMenu PTR, BYVAL AS CONST gchar PTR, BYVAL AS GMenuModel PTR)
DECLARE FUNCTION g_menu_item_get_type() AS GType
DECLARE FUNCTION g_menu_item_new(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR) AS GMenuItem PTR
DECLARE FUNCTION g_menu_item_new_submenu(BYVAL AS CONST gchar PTR, BYVAL AS GMenuModel PTR) AS GMenuItem PTR
DECLARE FUNCTION g_menu_item_new_section(BYVAL AS CONST gchar PTR, BYVAL AS GMenuModel PTR) AS GMenuItem PTR
DECLARE SUB g_menu_item_set_attribute_value(BYVAL AS GMenuItem PTR, BYVAL AS CONST gchar PTR, BYVAL AS GVariant PTR)
DECLARE SUB g_menu_item_set_attribute(BYVAL AS GMenuItem PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, ...)
DECLARE SUB g_menu_item_set_link(BYVAL AS GMenuItem PTR, BYVAL AS CONST gchar PTR, BYVAL AS GMenuModel PTR)
DECLARE SUB g_menu_item_set_label(BYVAL AS GMenuItem PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB g_menu_item_set_submenu(BYVAL AS GMenuItem PTR, BYVAL AS GMenuModel PTR)
DECLARE SUB g_menu_item_set_section(BYVAL AS GMenuItem PTR, BYVAL AS GMenuModel PTR)
DECLARE SUB g_menu_item_set_action_and_target_value(BYVAL AS GMenuItem PTR, BYVAL AS CONST gchar PTR, BYVAL AS GVariant PTR)
DECLARE SUB g_menu_item_set_action_and_target(BYVAL AS GMenuItem PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, ...)
DECLARE SUB g_menu_item_set_detailed_action(BYVAL AS GMenuItem PTR, BYVAL AS CONST gchar PTR)

#ENDIF ' __G_MENU_H__

#IFNDEF __G_MENU_EXPORTER_H__
#DEFINE __G_MENU_EXPORTER_H__

DECLARE FUNCTION g_dbus_connection_export_menu_model(BYVAL AS GDBusConnection PTR, BYVAL AS CONST gchar PTR, BYVAL AS GMenuModel PTR, BYVAL AS GError PTR PTR) AS guint
DECLARE SUB g_dbus_connection_unexport_menu_model(BYVAL AS GDBusConnection PTR, BYVAL AS guint)

#ENDIF ' __G_MENU_EXPORTER_H__

' 002 start from: glib-2.31.4/gio/gio.h ==> glib-2.31.4/gio/gmenumarkup.h

#IFNDEF __G_MENU_MARKUP_H__
#DEFINE __G_MENU_MARKUP_H__

DECLARE SUB g_menu_markup_parser_start(BYVAL AS GMarkupParseContext PTR, BYVAL AS CONST gchar PTR, BYVAL AS GHashTable PTR)
DECLARE FUNCTION g_menu_markup_parser_end(BYVAL AS GMarkupParseContext PTR) AS GHashTable PTR
DECLARE SUB g_menu_markup_parser_start_menu(BYVAL AS GMarkupParseContext PTR, BYVAL AS CONST gchar PTR, BYVAL AS GHashTable PTR)
DECLARE FUNCTION g_menu_markup_parser_end_menu(BYVAL AS GMarkupParseContext PTR) AS GMenu PTR
DECLARE SUB g_menu_markup_print_stderr(BYVAL AS GMenuModel PTR)
DECLARE FUNCTION g_menu_markup_print_string(BYVAL AS GString PTR, BYVAL AS GMenuModel PTR, BYVAL AS gint, BYVAL AS gint) AS GString PTR

#ENDIF ' __G_MENU_MARKUP_H__

#IFNDEF __G_DBUS_MENU_MODEL_H__
#DEFINE __G_DBUS_MENU_MODEL_H__

#DEFINE G_TYPE_DBUS_MENU_MODEL (g_dbus_menu_model_get_type ())
#DEFINE G_DBUS_MENU_MODEL(inst) (G_TYPE_CHECK_INSTANCE_CAST ((inst), _
                                         G_TYPE_DBUS_MENU_MODEL, GDBusMenuModel))
#DEFINE G_IS_DBUS_MENU_MODEL(inst) (G_TYPE_CHECK_INSTANCE_TYPE ((inst), _
                                         G_TYPE_DBUS_MENU_MODEL))

TYPE GDBusMenuModel AS _GDBusMenuModel

DECLARE FUNCTION g_dbus_menu_model_get_type() AS GType
DECLARE FUNCTION g_dbus_menu_model_get(BYVAL AS GDBusConnection PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR) AS GDBusMenuModel PTR

#ENDIF ' __G_DBUS_MENU_MODEL_H__

#UNDEF __GIO_GIO_H_INSIDE__
#ENDIF ' __G_IO_H__

END EXTERN

#IFDEF __FB_WIN32__
#PRAGMA pop(msbitfields)
#ENDIF
