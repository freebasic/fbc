''
''
'' winbase -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_winbase_bi__
#define __win_winbase_bi__

#define SP_SERIALCOMM 1
#define PST_UNSPECIFIED 0
#define PST_RS232 1
#define PST_PARALLELPORT 2
#define PST_RS422 3
#define PST_RS423 4
#define PST_RS449 5
#define PST_MODEM 6
#define PST_FAX &h21
#define PST_SCANNER &h22
#define PST_NETWORK_BRIDGE &h100
#define PST_LAT &h101
#define PST_TCPIP_TELNET &h102
#define PST_X25 &h103
#define BAUD_075 1
#define BAUD_110 2
#define BAUD_134_5 4
#define BAUD_150 8
#define BAUD_300 16
#define BAUD_600 32
#define BAUD_1200 64
#define BAUD_1800 128
#define BAUD_2400 256
#define BAUD_4800 512
#define BAUD_7200 1024
#define BAUD_9600 2048
#define BAUD_14400 4096
#define BAUD_19200 8192
#define BAUD_38400 16384
#define BAUD_56K 32768
#define BAUD_128K 65536
#define BAUD_115200 131072
#define BAUD_57600 262144
#define BAUD_USER &h10000000
#define PCF_DTRDSR 1
#define PCF_RTSCTS 2
#define PCF_RLSD 4
#define PCF_PARITY_CHECK 8
#define PCF_XONXOFF 16
#define PCF_SETXCHAR 32
#define PCF_TOTALTIMEOUTS 64
#define PCF_INTTIMEOUTS 128
#define PCF_SPECIALCHARS 256
#define PCF_16BITMODE 512
#define SP_PARITY 1
#define SP_BAUD 2
#define SP_DATABITS 4
#define SP_STOPBITS 8
#define SP_HANDSHAKING 16
#define SP_PARITY_CHECK 32
#define SP_RLSD 64
#define DATABITS_5 1
#define DATABITS_6 2
#define DATABITS_7 4
#define DATABITS_8 8
#define DATABITS_16 16
#define DATABITS_16X 32
#define STOPBITS_10 1
#define STOPBITS_15 2
#define STOPBITS_20 4
#define PARITY_NONE 256
#define PARITY_ODD 512
#define PARITY_EVEN 1024
#define PARITY_MARK 2048
#define PARITY_SPACE 4096
#define EXCEPTION_DEBUG_EVENT 1
#define CREATE_THREAD_DEBUG_EVENT 2
#define CREATE_PROCESS_DEBUG_EVENT 3
#define EXIT_THREAD_DEBUG_EVENT 4
#define EXIT_PROCESS_DEBUG_EVENT 5
#define LOAD_DLL_DEBUG_EVENT 6
#define UNLOAD_DLL_DEBUG_EVENT 7
#define OUTPUT_DEBUG_STRING_EVENT 8
#define RIP_EVENT 9
#define HFILE_ERROR (-1)
#define FILE_BEGIN 0
#define FILE_CURRENT 1
#define FILE_END 2
#define INVALID_SET_FILE_POINTER	(-1)
#define OF_READ 0
#define OF_READWRITE 2
#define OF_WRITE 1
#define OF_SHARE_COMPAT 0
#define OF_SHARE_DENY_NONE 64
#define OF_SHARE_DENY_READ 48
#define OF_SHARE_DENY_WRITE 32
#define OF_SHARE_EXCLUSIVE 16
#define OF_CANCEL 2048
#define OF_CREATE 4096
#define OF_DELETE 512
#define OF_EXIST 16384
#define OF_PARSE 256
#define OF_PROMPT 8192
#define OF_REOPEN 32768
#define OF_VERIFY 1024
#define NMPWAIT_NOWAIT 1
#define NMPWAIT_WAIT_FOREVER	cuint(-1)
#define NMPWAIT_USE_DEFAULT_WAIT 0
#define CE_BREAK 16
#define CE_DNS 2048
#define CE_FRAME 8
#define CE_IOE 1024
#define CE_MODE 32768
#define CE_OOP 4096
#define CE_OVERRUN 2
#define CE_PTO 512
#define CE_RXOVER 1
#define CE_RXPARITY 4
#define CE_TXFULL 256
#define PROGRESS_CONTINUE 0
#define PROGRESS_CANCEL 1
#define PROGRESS_STOP 2
#define PROGRESS_QUIET 3
#define CALLBACK_CHUNK_FINISHED 0
#define CALLBACK_STREAM_SWITCH 1
#define COPY_FILE_FAIL_IF_EXISTS 1
#define COPY_FILE_RESTARTABLE 2
#define OFS_MAXPATHNAME 128
#define FILE_MAP_ALL_ACCESS &hf001f
#define FILE_MAP_READ 4
#define FILE_MAP_WRITE 2
#define FILE_MAP_COPY 1
#define MUTEX_ALL_ACCESS &h1f0001
#define MUTEX_MODIFY_STATE 1
#define SEMAPHORE_ALL_ACCESS &h1f0003
#define SEMAPHORE_MODIFY_STATE 2
#define EVENT_ALL_ACCESS &h1f0003
#define EVENT_MODIFY_STATE 2
#define PIPE_ACCESS_DUPLEX 3
#define PIPE_ACCESS_INBOUND 1
#define PIPE_ACCESS_OUTBOUND 2
#define PIPE_TYPE_BYTE 0
#define PIPE_TYPE_MESSAGE 4
#define PIPE_READMODE_BYTE 0
#define PIPE_READMODE_MESSAGE 2
#define PIPE_WAIT 0
#define PIPE_NOWAIT 1
#define PIPE_CLIENT_END 0
#define PIPE_SERVER_END 1
#define PIPE_UNLIMITED_INSTANCES 255
#define DEBUG_PROCESS &h00000001
#define DEBUG_ONLY_THIS_PROCESS &h00000002
#define CREATE_SUSPENDED &h00000004
#define DETACHED_PROCESS &h00000008
#define CREATE_NEW_CONSOLE &h00000010
#define NORMAL_PRIORITY_CLASS &h00000020
#define IDLE_PRIORITY_CLASS &h00000040
#define HIGH_PRIORITY_CLASS &h00000080
#define REALTIME_PRIORITY_CLASS &h00000100
#define CREATE_NEW_PROCESS_GROUP &h00000200
#define CREATE_UNICODE_ENVIRONMENT &h00000400
#define CREATE_SEPARATE_WOW_VDM &h00000800
#define CREATE_SHARED_WOW_VDM &h00001000
#define CREATE_FORCEDOS &h00002000
#define BELOW_NORMAL_PRIORITY_CLASS &h00004000
#define ABOVE_NORMAL_PRIORITY_CLASS &h00008000
#define CREATE_BREAKAWAY_FROM_JOB &h01000000
#define CREATE_WITH_USERPROFILE &h02000000
#define CREATE_DEFAULT_ERROR_MODE &h04000000
#define CREATE_NO_WINDOW &h08000000
#define PROFILE_USER &h10000000
#define PROFILE_KERNEL &h20000000
#define PROFILE_SERVER &h40000000
#define CONSOLE_TEXTMODE_BUFFER 1
#define CREATE_NEW 1
#define CREATE_ALWAYS 2
#define OPEN_EXISTING 3
#define OPEN_ALWAYS 4
#define TRUNCATE_EXISTING 5
#define FILE_FLAG_WRITE_THROUGH &h80000000
#define FILE_FLAG_OVERLAPPED 1073741824
#define FILE_FLAG_NO_BUFFERING 536870912
#define FILE_FLAG_RANDOM_ACCESS 268435456
#define FILE_FLAG_SEQUENTIAL_SCAN 134217728
#define FILE_FLAG_DELETE_ON_CLOSE 67108864
#define FILE_FLAG_BACKUP_SEMANTICS 33554432
#define FILE_FLAG_POSIX_SEMANTICS 16777216
#define FILE_FLAG_OPEN_REPARSE_POINT 2097152
#define FILE_FLAG_OPEN_NO_RECALL 1048576
#define FILE_FLAG_FIRST_PIPE_INSTANCE	524288
#define CLRDTR 6
#define CLRRTS 4
#define SETDTR 5
#define SETRTS 3
#define SETXOFF 1
#define SETXON 2
#define SETBREAK 8
#define CLRBREAK 9
#define STILL_ACTIVE &h103
#define FIND_FIRST_EX_CASE_SENSITIVE 1
#define SCS_32BIT_BINARY 0
#define SCS_DOS_BINARY 1
#define SCS_OS216_BINARY 5
#define SCS_PIF_BINARY 3
#define SCS_POSIX_BINARY 4
#define SCS_WOW_BINARY 2
#define MAX_COMPUTERNAME_LENGTH 15
#define HW_PROFILE_GUIDLEN 39
#define MAX_PROFILE_LEN 80
#define DOCKINFO_UNDOCKED 1
#define DOCKINFO_DOCKED 2
#define DOCKINFO_USER_SUPPLIED 4
#define DOCKINFO_USER_UNDOCKED (4 or 1)
#define DOCKINFO_USER_DOCKED (4 or 2)
#define DRIVE_REMOVABLE 2
#define DRIVE_FIXED 3
#define DRIVE_REMOTE 4
#define DRIVE_CDROM 5
#define DRIVE_RAMDISK 6
#define DRIVE_UNKNOWN 0
#define DRIVE_NO_ROOT_DIR 1
#define FILE_TYPE_UNKNOWN 0
#define FILE_TYPE_DISK 1
#define FILE_TYPE_CHAR 2
#define FILE_TYPE_PIPE 3
#define FILE_TYPE_REMOTE &h8000
#define HANDLE_FLAG_INHERIT &h01
#define HANDLE_FLAG_PROTECT_FROM_CLOSE &h02
#define STD_INPUT_HANDLE &hfffffff6UL
#define STD_OUTPUT_HANDLE &hfffffff5UL
#define STD_ERROR_HANDLE &hfffffff4UL
#define INVALID_HANDLE_VALUE (-1)
#define GET_TAPE_MEDIA_INFORMATION 0
#define GET_TAPE_DRIVE_INFORMATION 1
#define SET_TAPE_MEDIA_INFORMATION 0
#define SET_TAPE_DRIVE_INFORMATION 1
#define THREAD_PRIORITY_ABOVE_NORMAL 1
#define THREAD_PRIORITY_BELOW_NORMAL (-1)
#define THREAD_PRIORITY_HIGHEST 2
#define THREAD_PRIORITY_IDLE (-15)
#define THREAD_PRIORITY_LOWEST (-2)
#define THREAD_PRIORITY_NORMAL 0
#define THREAD_PRIORITY_TIME_CRITICAL 15
#define THREAD_PRIORITY_ERROR_RETURN 2147483647
#define TIME_ZONE_ID_UNKNOWN 0
#define TIME_ZONE_ID_STANDARD 1
#define TIME_ZONE_ID_DAYLIGHT 2
#define TIME_ZONE_ID_INVALID &hFFFFFFFF
#define FS_CASE_IS_PRESERVED 2
#define FS_CASE_SENSITIVE 1
#define FS_UNICODE_STORED_ON_DISK 4
#define FS_PERSISTENT_ACLS 8
#define FS_FILE_COMPRESSION 16
#define FS_VOL_IS_COMPRESSED 32768
#define GMEM_FIXED 0
#define GMEM_MOVEABLE 2
#define GMEM_MODIFY 128
#define GPTR_ 64
#define GHND_ 66
#define GMEM_DDESHARE 8192
#define GMEM_DISCARDABLE 256
#define GMEM_LOWER 4096
#define GMEM_NOCOMPACT 16
#define GMEM_NODISCARD 32
#define GMEM_NOT_BANKED 4096
#define GMEM_NOTIFY 16384
#define GMEM_SHARE 8192
#define GMEM_ZEROINIT 64
#define GMEM_DISCARDED 16384
#define GMEM_INVALID_HANDLE 32768
#define GMEM_LOCKCOUNT 255
#define GMEM_VALID_FLAGS 32626
#define STATUS_WAIT_0 0
#define STATUS_ABANDONED_WAIT_0 &h80
#define STATUS_USER_APC &hC0
#define STATUS_TIMEOUT &h102
#define STATUS_PENDING &h103
#define STATUS_SEGMENT_NOTIFICATION &h40000005
#define STATUS_GUARD_PAGE_VIOLATION &h80000001
#define STATUS_DATATYPE_MISALIGNMENT &h80000002
#define STATUS_BREAKPOINT &h80000003
#define STATUS_SINGLE_STEP &h80000004
#define STATUS_ACCESS_VIOLATION &hC0000005
#define STATUS_IN_PAGE_ERROR &hC0000006
#define STATUS_INVALID_HANDLE &hC0000008L
#define STATUS_NO_MEMORY &hC0000017
#define STATUS_ILLEGAL_INSTRUCTION &hC000001D
#define STATUS_NONCONTINUABLE_EXCEPTION &hC0000025
#define STATUS_INVALID_DISPOSITION &hC0000026
#define STATUS_ARRAY_BOUNDS_EXCEEDED &hC000008C
#define STATUS_FLOAT_DENORMAL_OPERAND &hC000008D
#define STATUS_FLOAT_DIVIDE_BY_ZERO &hC000008E
#define STATUS_FLOAT_INEXACT_RESULT &hC000008F
#define STATUS_FLOAT_INVALID_OPERATION &hC0000090
#define STATUS_FLOAT_OVERFLOW &hC0000091
#define STATUS_FLOAT_STACK_CHECK &hC0000092
#define STATUS_FLOAT_UNDERFLOW &hC0000093
#define STATUS_INTEGER_DIVIDE_BY_ZERO &hC0000094
#define STATUS_INTEGER_OVERFLOW &hC0000095
#define STATUS_PRIVILEGED_INSTRUCTION &hC0000096
#define STATUS_STACK_OVERFLOW &hC00000FD
#define STATUS_CONTROL_C_EXIT &hC000013A
#define EXCEPTION_ACCESS_VIOLATION &hC0000005
#define EXCEPTION_DATATYPE_MISALIGNMENT &h80000002
#define EXCEPTION_BREAKPOINT &h80000003
#define EXCEPTION_SINGLE_STEP &h80000004
#define EXCEPTION_ARRAY_BOUNDS_EXCEEDED &hC000008C
#define EXCEPTION_FLT_DENORMAL_OPERAND &hC000008D
#define EXCEPTION_FLT_DIVIDE_BY_ZERO &hC000008E
#define EXCEPTION_FLT_INEXACT_RESULT &hC000008F
#define EXCEPTION_FLT_INVALID_OPERATION &hC0000090
#define EXCEPTION_FLT_OVERFLOW &hC0000091
#define EXCEPTION_FLT_STACK_CHECK &hC0000092
#define EXCEPTION_FLT_UNDERFLOW &hC0000093
#define EXCEPTION_INT_DIVIDE_BY_ZERO &hC0000094
#define EXCEPTION_INT_OVERFLOW &hC0000095
#define EXCEPTION_PRIV_INSTRUCTION &hC0000096
#define EXCEPTION_IN_PAGE_ERROR &hC0000006
#define EXCEPTION_ILLEGAL_INSTRUCTION &hC000001D
#define EXCEPTION_NONCONTINUABLE_EXCEPTION &hC0000025
#define EXCEPTION_STACK_OVERFLOW &hC00000FD
#define EXCEPTION_INVALID_DISPOSITION &hC0000026
#define EXCEPTION_GUARD_PAGE &h80000001
#define EXCEPTION_INVALID_HANDLE &hC0000008L
#define CONTROL_C_EXIT &hC000013A
#define PROCESS_HEAP_REGION 1
#define PROCESS_HEAP_UNCOMMITTED_RANGE 2
#define PROCESS_HEAP_ENTRY_BUSY 4
#define PROCESS_HEAP_ENTRY_MOVEABLE 16
#define PROCESS_HEAP_ENTRY_DDESHARE 32
#define DONT_RESOLVE_DLL_REFERENCES 1
#define LOAD_LIBRARY_AS_DATAFILE 2
#define LOAD_WITH_ALTERED_SEARCH_PATH 8
#define LMEM_FIXED 0
#define LMEM_MOVEABLE 2
#define LMEM_NONZEROLHND 2
#define LMEM_NONZEROLPTR 0
#define LMEM_DISCARDABLE 3840
#define LMEM_NOCOMPACT 16
#define LMEM_NODISCARD 32
#define LMEM_ZEROINIT 64
#define LMEM_DISCARDED 16384
#define LMEM_MODIFY 128
#define LMEM_INVALID_HANDLE 32768
#define LMEM_LOCKCOUNT 255
#define LPTR_ 64
#define LHND_ 66
#define NONZEROLHND 2
#define NONZEROLPTR 0
#define LOCKFILE_FAIL_IMMEDIATELY 1
#define LOCKFILE_EXCLUSIVE_LOCK 2
#define LOGON32_PROVIDER_DEFAULT 0
#define LOGON32_PROVIDER_WINNT35 1
#define LOGON32_LOGON_INTERACTIVE 2
#define LOGON32_LOGON_BATCH 4
#define LOGON32_LOGON_SERVICE 5
#define MOVEFILE_REPLACE_EXISTING 1
#define MOVEFILE_COPY_ALLOWED 2
#define MOVEFILE_DELAY_UNTIL_REBOOT 4
#define MOVEFILE_WRITE_THROUGH 8
#define MAXIMUM_WAIT_OBJECTS 64
#define MAXIMUM_SUSPEND_COUNT &h7F
#ifndef WAIT_TIMEOUT
#define WAIT_TIMEOUT 258
#endif
#define WAIT_OBJECT_0 0
#define WAIT_ABANDONED_0 128
#define WAIT_IO_COMPLETION &hC0
#define WAIT_ABANDONED 128
#define WAIT_FAILED &hFFFFFFFFUL
#define PURGE_TXABORT 1
#define PURGE_RXABORT 2
#define PURGE_TXCLEAR 4
#define PURGE_RXCLEAR 8
#define EVENTLOG_SUCCESS 0
#define EVENTLOG_FORWARDS_READ 4
#define EVENTLOG_BACKWARDS_READ 8
#define EVENTLOG_SEEK_READ 2
#define EVENTLOG_SEQUENTIAL_READ 1
#define EVENTLOG_ERROR_TYPE 1
#define EVENTLOG_WARNING_TYPE 2
#define EVENTLOG_INFORMATION_TYPE 4
#define EVENTLOG_AUDIT_SUCCESS 8
#define EVENTLOG_AUDIT_FAILURE 16
#define FORMAT_MESSAGE_ALLOCATE_BUFFER 256
#define FORMAT_MESSAGE_IGNORE_INSERTS 512
#define FORMAT_MESSAGE_FROM_STRING 1024
#define FORMAT_MESSAGE_FROM_HMODULE 2048
#define FORMAT_MESSAGE_FROM_SYSTEM 4096
#define FORMAT_MESSAGE_ARGUMENT_ARRAY 8192
#define FORMAT_MESSAGE_MAX_WIDTH_MASK 255
#define EV_BREAK 64
#define EV_CTS 8
#define EV_DSR 16
#define EV_ERR 128
#define EV_EVENT1 2048
#define EV_EVENT2 4096
#define EV_PERR 512
#define EV_RING 256
#define EV_RLSD 32
#define EV_RX80FULL 1024
#define EV_RXCHAR 1
#define EV_RXFLAG 2
#define EV_TXEMPTY 4
#define SEM_FAILCRITICALERRORS &h0001
#define SEM_NOGPFAULTERRORBOX &h0002
#define SEM_NOALIGNMENTFAULTEXCEPT &h0004
#define SEM_NOOPENFILEERRORBOX &h8000
#define SLE_ERROR 1
#define SLE_MINORERROR 2
#define SLE_WARNING 3
#define SHUTDOWN_NORETRY 1
#define EXCEPTION_EXECUTE_HANDLER 1
#define EXCEPTION_CONTINUE_EXECUTION (-1)
#define EXCEPTION_CONTINUE_SEARCH 0
#define MAXINTATOM &hC000
#define INVALID_ATOM (0)
#define IGNORE 0
#define INFINITE &hFFFFFFFF
#define NOPARITY 0
#define ODDPARITY 1
#define EVENPARITY 2
#define MARKPARITY 3
#define SPACEPARITY 4
#define ONESTOPBIT 0
#define ONE5STOPBITS 1
#define TWOSTOPBITS 2
#define CBR_110 110
#define CBR_300 300
#define CBR_600 600
#define CBR_1200 1200
#define CBR_2400 2400
#define CBR_4800 4800
#define CBR_9600 9600
#define CBR_14400 14400
#define CBR_19200 19200
#define CBR_38400 38400
#define CBR_56000 56000
#define CBR_57600 57600
#define CBR_115200 115200
#define CBR_128000 128000
#define CBR_256000 256000
#define BACKUP_INVALID 0
#define BACKUP_DATA 1
#define BACKUP_EA_DATA 2
#define BACKUP_SECURITY_DATA 3
#define BACKUP_ALTERNATE_DATA 4
#define BACKUP_LINK 5
#define BACKUP_PROPERTY_DATA 6
#define BACKUP_OBJECT_ID 7
#define BACKUP_REPARSE_DATA 8
#define BACKUP_SPARSE_BLOCK 9
#define STREAM_NORMAL_ATTRIBUTE 0
#define STREAM_MODIFIED_WHEN_READ 1
#define STREAM_CONTAINS_SECURITY 2
#define STREAM_CONTAINS_PROPERTIES 4
#define STARTF_USESHOWWINDOW 1
#define STARTF_USESIZE 2
#define STARTF_USEPOSITION 4
#define STARTF_USECOUNTCHARS 8
#define STARTF_USEFILLATTRIBUTE 16
#define STARTF_RUNFULLSCREEN 32
#define STARTF_FORCEONFEEDBACK 64
#define STARTF_FORCEOFFFEEDBACK 128
#define STARTF_USESTDHANDLES 256
#define STARTF_USEHOTKEY 512
#define TC_NORMAL 0
#define TC_HARDERR 1
#define TC_GP_TRAP 2
#define TC_SIGNAL 3
#define AC_LINE_OFFLINE 0
#define AC_LINE_ONLINE 1
#define AC_LINE_BACKUP_POWER 2
#define AC_LINE_UNKNOWN 255
#define BATTERY_FLAG_HIGH 1
#define BATTERY_FLAG_LOW 2
#define BATTERY_FLAG_CRITICAL 4
#define BATTERY_FLAG_CHARGING 8
#define BATTERY_FLAG_NO_BATTERY 128
#define BATTERY_FLAG_UNKNOWN 255
#define BATTERY_PERCENTAGE_UNKNOWN 255
#define BATTERY_LIFE_UNKNOWN &hFFFFFFFF
#define DDD_RAW_TARGET_PATH 1
#define DDD_REMOVE_DEFINITION 2
#define DDD_EXACT_MATCH_ON_REMOVE 4
#define HINSTANCE_ERROR 32
#define MS_CTS_ON 16
#define MS_DSR_ON 32
#define MS_RING_ON 64
#define MS_RLSD_ON 128
#define DTR_CONTROL_DISABLE 0
#define DTR_CONTROL_ENABLE 1
#define DTR_CONTROL_HANDSHAKE 2
#define RTS_CONTROL_DISABLE 0
#define RTS_CONTROL_ENABLE 1
#define RTS_CONTROL_HANDSHAKE 2
#define RTS_CONTROL_TOGGLE 3
#define SECURITY_ANONYMOUS (SecurityAnonymous shl 16)
#define SECURITY_IDENTIFICATION (SecurityIdentification shl 16)
#define SECURITY_IMPERSONATION (SecurityImpersonation shl 16)
#define SECURITY_DELEGATION (SecurityDelegation shl 16)
#define SECURITY_CONTEXT_TRACKING &h40000
#define SECURITY_EFFECTIVE_ONLY &h80000
#define SECURITY_SQOS_PRESENT &h100000
#define SECURITY_VALID_SQOS_FLAGS &h1F0000
#define INVALID_FILE_SIZE &hFFFFFFFF
#define TLS_OUT_OF_INDEXES &hFFFFFFFFUL
#define ACTCTX_FLAG_PROCESSOR_ARCHITECTURE_VALID &h00000001
#define ACTCTX_FLAG_LANGID_VALID &h00000002
#define ACTCTX_FLAG_ASSEMBLY_DIRECTORY_VALID &h00000004
#define ACTCTX_FLAG_RESOURCE_NAME_VALID &h00000008
#define ACTCTX_FLAG_SET_PROCESS_DEFAULT &h00000010
#define ACTCTX_FLAG_APPLICATION_NAME_VALID &h00000020
#define ACTCTX_FLAG_HMODULE_VALID &h00000080
#define DEACTIVATE_ACTCTX_FLAG_FORCE_EARLY_DEACTIVATION &h00000001
#define FIND_ACTCTX_SECTION_KEY_RETURN_HACTCTX &h00000001
#define QUERY_ACTCTX_FLAG_USE_ACTIVE_ACTCTX &h00000004
#define QUERY_ACTCTX_FLAG_ACTCTX_IS_HMODULE &h00000008
#define QUERY_ACTCTX_FLAG_ACTCTX_IS_ADDRESS &h00000010
#define REPLACEFILE_WRITE_THROUGH &h00000001
#define REPLACEFILE_IGNORE_MERGE_ERRORS &h00000002
#define WRITE_WATCH_FLAG_RESET 1

type FILETIME
	dwLowDateTime as DWORD
	dwHighDateTime as DWORD
end type

type PFILETIME as FILETIME ptr
type LPFILETIME as FILETIME ptr

type BY_HANDLE_FILE_INFORMATION
	dwFileAttributes as DWORD
	ftCreationTime as FILETIME
	ftLastAccessTime as FILETIME
	ftLastWriteTime as FILETIME
	dwVolumeSerialNumber as DWORD
	nFileSizeHigh as DWORD
	nFileSizeLow as DWORD
	nNumberOfLinks as DWORD
	nFileIndexHigh as DWORD
	nFileIndexLow as DWORD
end type

type LPBY_HANDLE_FILE_INFORMATION as BY_HANDLE_FILE_INFORMATION ptr

type DCB
	DCBlength as DWORD
	BaudRate as DWORD
	fBinary:1 as DWORD
	fParity:1 as DWORD
	fOutxCtsFlow:1 as DWORD
	fOutxDsrFlow:1 as DWORD
	fDtrControl:2 as DWORD
	fDsrSensitivity:1 as DWORD
	fTXContinueOnXoff:1 as DWORD
	fOutX:1 as DWORD
	fInX:1 as DWORD
	fErrorChar:1 as DWORD
	fNull:1 as DWORD
	fRtsControl:2 as DWORD
	fAbortOnError:1 as DWORD
	fDummy2:17 as DWORD
	wReserved as WORD
	XonLim as WORD
	XoffLim as WORD
	ByteSize as UBYTE
	Parity as UBYTE
	StopBits as UBYTE
	XonChar as byte
	XoffChar as byte
	ErrorChar as byte
	EofChar as byte
	EvtChar as byte
	wReserved1 as WORD
end type

type LPDCB as DCB ptr

type COMM_CONFIG
	dwSize as DWORD
	wVersion as WORD
	wReserved as WORD
	dcb as DCB
	dwProviderSubType as DWORD
	dwProviderOffset as DWORD
	dwProviderSize as DWORD
	wcProviderData as wstring * 1
end type

type LPCOMMCONFIG as COMM_CONFIG ptr

type COMMPROP
	wPacketLength as WORD
	wPacketVersion as WORD
	dwServiceMask as DWORD
	dwReserved1 as DWORD
	dwMaxTxQueue as DWORD
	dwMaxRxQueue as DWORD
	dwMaxBaud as DWORD
	dwProvSubType as DWORD
	dwProvCapabilities as DWORD
	dwSettableParams as DWORD
	dwSettableBaud as DWORD
	wSettableData as WORD
	wSettableStopParity as WORD
	dwCurrentTxQueue as DWORD
	dwCurrentRxQueue as DWORD
	dwProvSpec1 as DWORD
	dwProvSpec2 as DWORD
	wcProvChar as wstring * 1
end type

type LPCOMMPROP as COMMPROP ptr

type COMMTIMEOUTS
	ReadIntervalTimeout as DWORD
	ReadTotalTimeoutMultiplier as DWORD
	ReadTotalTimeoutConstant as DWORD
	WriteTotalTimeoutMultiplier as DWORD
	WriteTotalTimeoutConstant as DWORD
end type

type LPCOMMTIMEOUTS as COMMTIMEOUTS ptr

type COMSTAT
	fCtsHold:1 as DWORD
	fDsrHold:1 as DWORD
	fRlsdHold:1 as DWORD
	fXoffHold:1 as DWORD
	fXoffSent:1 as DWORD
	fEof:1 as DWORD
	fTxim:1 as DWORD
	fReserved:25 as DWORD
	cbInQue as DWORD
	cbOutQue as DWORD
end type

type LPCOMSTAT as COMSTAT ptr
type LPTHREAD_START_ROUTINE as function (byval as LPVOID) as DWORD

type CREATE_PROCESS_DEBUG_INFO
	hFile as HANDLE
	hProcess as HANDLE
	hThread as HANDLE
	lpBaseOfImage as LPVOID
	dwDebugInfoFileOffset as DWORD
	nDebugInfoSize as DWORD
	lpThreadLocalBase as LPVOID
	lpStartAddress as LPTHREAD_START_ROUTINE
	lpImageName as LPVOID
	fUnicode as WORD
end type

type LPCREATE_PROCESS_DEBUG_INFO as CREATE_PROCESS_DEBUG_INFO ptr

type CREATE_THREAD_DEBUG_INFO
	hThread as HANDLE
	lpThreadLocalBase as LPVOID
	lpStartAddress as LPTHREAD_START_ROUTINE
end type

type LPCREATE_THREAD_DEBUG_INFO as CREATE_THREAD_DEBUG_INFO ptr

type EXCEPTION_DEBUG_INFO
	ExceptionRecord as EXCEPTION_RECORD
	dwFirstChance as DWORD
end type

type LPEXCEPTION_DEBUG_INFO as EXCEPTION_DEBUG_INFO ptr

type EXIT_THREAD_DEBUG_INFO
	dwExitCode as DWORD
end type

type LPEXIT_THREAD_DEBUG_INFO as EXIT_THREAD_DEBUG_INFO ptr

type EXIT_PROCESS_DEBUG_INFO
	dwExitCode as DWORD
end type

type LPEXIT_PROCESS_DEBUG_INFO as EXIT_PROCESS_DEBUG_INFO ptr

type LOAD_DLL_DEBUG_INFO
	hFile as HANDLE
	lpBaseOfDll as LPVOID
	dwDebugInfoFileOffset as DWORD
	nDebugInfoSize as DWORD
	lpImageName as LPVOID
	fUnicode as WORD
end type

type LPLOAD_DLL_DEBUG_INFO as LOAD_DLL_DEBUG_INFO ptr

type UNLOAD_DLL_DEBUG_INFO
	lpBaseOfDll as LPVOID
end type

type LPUNLOAD_DLL_DEBUG_INFO as UNLOAD_DLL_DEBUG_INFO ptr

type OUTPUT_DEBUG_STRING_INFO
	lpDebugStringData as LPSTR
	fUnicode as WORD
	nDebugStringLength as WORD
end type

type LPOUTPUT_DEBUG_STRING_INFO as OUTPUT_DEBUG_STRING_INFO ptr

type RIP_INFO
	dwError as DWORD
	dwType as DWORD
end type

type LPRIP_INFO as RIP_INFO ptr

type DEBUG_EVENT
	dwDebugEventCode as DWORD
	dwProcessId as DWORD
	dwThreadId as DWORD
	union
		Exception as EXCEPTION_DEBUG_INFO
		CreateThread as CREATE_THREAD_DEBUG_INFO
		CreateProcessInfo as CREATE_PROCESS_DEBUG_INFO
		ExitThread as EXIT_THREAD_DEBUG_INFO
		ExitProcess as EXIT_PROCESS_DEBUG_INFO
		LoadDll as LOAD_DLL_DEBUG_INFO
		UnloadDll as UNLOAD_DLL_DEBUG_INFO
		DebugString as OUTPUT_DEBUG_STRING_INFO
		RipInfo as RIP_INFO
	end union
end type

type LPDEBUG_EVENT as DEBUG_EVENT ptr

type OVERLAPPED
	Internal as DWORD
	InternalHigh as DWORD
	Offset as DWORD
	OffsetHigh as DWORD
	hEvent as HANDLE
end type

type POVERLAPPED as OVERLAPPED ptr
type LPOVERLAPPED as OVERLAPPED ptr

#ifndef UNICODE
type STARTUPINFOA
	cb as DWORD
	lpReserved as LPSTR
	lpDesktop as LPSTR
	lpTitle as LPSTR
	dwX as DWORD
	dwY as DWORD
	dwXSize as DWORD
	dwYSize as DWORD
	dwXCountChars as DWORD
	dwYCountChars as DWORD
	dwFillAttribute as DWORD
	dwFlags as DWORD
	wShowWindow as WORD
	cbReserved2 as WORD
	lpReserved2 as PBYTE
	hStdInput as HANDLE
	hStdOutput as HANDLE
	hStdError as HANDLE
end type

type LPSTARTUPINFOA as STARTUPINFOA ptr

#else ''UNICODE
type STARTUPINFOW
	cb as DWORD
	lpReserved as LPWSTR
	lpDesktop as LPWSTR
	lpTitle as LPWSTR
	dwX as DWORD
	dwY as DWORD
	dwXSize as DWORD
	dwYSize as DWORD
	dwXCountChars as DWORD
	dwYCountChars as DWORD
	dwFillAttribute as DWORD
	dwFlags as DWORD
	wShowWindow as WORD
	cbReserved2 as WORD
	lpReserved2 as PBYTE
	hStdInput as HANDLE
	hStdOutput as HANDLE
	hStdError as HANDLE
end type

type LPSTARTUPINFOW as STARTUPINFOW ptr
#endif ''UNICODE

type PROCESS_INFORMATION
	hProcess as HANDLE
	hThread as HANDLE
	dwProcessId as DWORD
	dwThreadId as DWORD
end type

type LPPROCESS_INFORMATION as PROCESS_INFORMATION ptr

type PCRITICAL_SECTION_DEBUG as CRITICAL_SECTION_DEBUG ptr

type CRITICAL_SECTION
	DebugInfo as PCRITICAL_SECTION_DEBUG
	LockCount as LONG
	RecursionCount as LONG
	OwningThread as HANDLE
	LockSemaphore as HANDLE
	SpinCount as DWORD
end type

type PCRITICAL_SECTION as CRITICAL_SECTION ptr
type LPCRITICAL_SECTION as CRITICAL_SECTION ptr

type CRITICAL_SECTION_DEBUG
	Type as WORD
	CreatorBackTraceIndex as WORD
	CriticalSection as CRITICAL_SECTION ptr
	ProcessLocksList as LIST_ENTRY
	EntryCount as DWORD
	ContentionCount as DWORD
	Spare(0 to 2-1) as DWORD
end type

type SYSTEMTIME
	wYear as WORD
	wMonth as WORD
	wDayOfWeek as WORD
	wDay as WORD
	wHour as WORD
	wMinute as WORD
	wSecond as WORD
	wMilliseconds as WORD
end type

type LPSYSTEMTIME as SYSTEMTIME ptr

type WIN32_FILE_ATTRIBUTE_DATA
	dwFileAttributes as DWORD
	ftCreationTime as FILETIME
	ftLastAccessTime as FILETIME
	ftLastWriteTime as FILETIME
	nFileSizeHigh as DWORD
	nFileSizeLow as DWORD
end type

type LPWIN32_FILE_ATTRIBUTE_DATA as WIN32_FILE_ATTRIBUTE_DATA ptr

#ifndef UNICODE
type WIN32_FIND_DATAA
	dwFileAttributes as DWORD
	ftCreationTime as FILETIME
	ftLastAccessTime as FILETIME
	ftLastWriteTime as FILETIME
	nFileSizeHigh as DWORD
	nFileSizeLow as DWORD
	dwReserved0 as DWORD
	dwReserved1 as DWORD
	cFileName as zstring * 260
	cAlternateFileName as zstring * 14
end type

type PWIN32_FIND_DATAA as WIN32_FIND_DATAA ptr
type LPWIN32_FIND_DATAA as WIN32_FIND_DATAA ptr

#else ''UNICODE
type WIN32_FIND_DATAW
	dwFileAttributes as DWORD
	ftCreationTime as FILETIME
	ftLastAccessTime as FILETIME
	ftLastWriteTime as FILETIME
	nFileSizeHigh as DWORD
	nFileSizeLow as DWORD
	dwReserved0 as DWORD
	dwReserved1 as DWORD
	cFileName as wstring * 260
	cAlternateFileName as wstring * 14
end type

type PWIN32_FIND_DATAW as WIN32_FIND_DATAW ptr
type LPWIN32_FIND_DATAW as WIN32_FIND_DATAW ptr
#endif ''UNICODE

type WIN32_STREAM_ID
	dwStreamId as DWORD
	dwStreamAttributes as DWORD
	Size as LARGE_INTEGER
	dwStreamNameSize as DWORD
	cStreamName as wstring * 1
end type

enum FINDEX_INFO_LEVELS
	FindExInfoStandard
	FindExInfoMaxInfoLevel
end enum

enum FINDEX_SEARCH_OPS
	FindExSearchNameMatch
	FindExSearchLimitToDirectories
	FindExSearchLimitToDevices
	FindExSearchMaxSearchOp
end enum

enum ACL_INFORMATION_CLASS
	AclRevisionInformation = 1
	AclSizeInformation
end enum

#ifndef UNICODE
type HW_PROFILE_INFOA
	dwDockInfo as DWORD
	szHwProfileGuid as zstring * 39
	szHwProfileName as zstring * 80
end type

type LPHW_PROFILE_INFOA as HW_PROFILE_INFOA ptr

#else ''UNICODE
type HW_PROFILE_INFOW
	dwDockInfo as DWORD
	szHwProfileGuid as wstring * 39
	szHwProfileName as wstring * 80
end type

type LPHW_PROFILE_INFOW as HW_PROFILE_INFOW ptr
#endif ''UNICODE

enum GET_FILEEX_INFO_LEVELS
	GetFileExInfoStandard
	GetFileExMaxInfoLevel
end enum

type SYSTEM_INFO
	union
		dwOemId as DWORD
		type
			wProcessorArchitecture as WORD
			wReserved as WORD
		end type
	end union
	dwPageSize as DWORD
	lpMinimumApplicationAddress as PVOID
	lpMaximumApplicationAddress as PVOID
	dwActiveProcessorMask as DWORD
	dwNumberOfProcessors as DWORD
	dwProcessorType as DWORD
	dwAllocationGranularity as DWORD
	wProcessorLevel as WORD
	wProcessorRevision as WORD
end type

type LPSYSTEM_INFO as SYSTEM_INFO ptr

type SYSTEM_POWER_STATUS
	ACLineStatus as UBYTE
	BatteryFlag as UBYTE
	BatteryLifePercent as UBYTE
	Reserved1 as UBYTE
	BatteryLifeTime as DWORD
	BatteryFullLifeTime as DWORD
end type

type LPSYSTEM_POWER_STATUS as SYSTEM_POWER_STATUS ptr

type TIME_ZONE_INFORMATION
	Bias as LONG
	StandardName as wstring * 32
	StandardDate as SYSTEMTIME
	StandardBias as LONG
	DaylightName as wstring * 32
	DaylightDate as SYSTEMTIME
	DaylightBias as LONG
end type

type LPTIME_ZONE_INFORMATION as TIME_ZONE_INFORMATION ptr

type MEMORYSTATUS
	dwLength as DWORD
	dwMemoryLoad as DWORD
	dwTotalPhys as DWORD
	dwAvailPhys as DWORD
	dwTotalPageFile as DWORD
	dwAvailPageFile as DWORD
	dwTotalVirtual as DWORD
	dwAvailVirtual as DWORD
end type

type LPMEMORYSTATUS as MEMORYSTATUS ptr

type MEMORYSTATUSEX
	dwLength as DWORD
	dwMemoryLoad as DWORD
	ullTotalPhys as DWORDLONG
	ullAvailPhys as DWORDLONG
	ullTotalPageFile as DWORDLONG
	ullAvailPageFile as DWORDLONG
	ullTotalVirtual as DWORDLONG
	ullAvailVirtual as DWORDLONG
	ullAvailExtendedVirtual as DWORDLONG
end type

type LPMEMORYSTATUSEX as MEMORYSTATUSEX ptr

type LDT_ENTRY_HighWord_Bits
	BaseMid:8 as DWORD
	Type:5 as DWORD
	Dpl:2 as DWORD
	Pres:1 as DWORD
	LimitHi:4 as DWORD
	Sys:1 as DWORD
	Reserved_0:1 as DWORD
	Default_Big:1 as DWORD
	Granularity:1 as DWORD
	BaseHi:8 as DWORD
end type

type LDT_ENTRY_HighWord_Bytes
	BaseMid as UBYTE
	Flags1 as UBYTE
	Flags2 as UBYTE
	BaseHi as UBYTE
end type

union LDT_ENTRY_HighWord
	Bytes as LDT_ENTRY_HighWord_Bytes
	Bits as LDT_ENTRY_HighWord_Bits
end union

type LDT_ENTRY
	LimitLow as WORD
	BaseLow as WORD
	HighWord as LDT_ENTRY_HighWord
end type

type PLDT_ENTRY as LDT_ENTRY ptr
type LPLDT_ENTRY as LDT_ENTRY ptr

type PROCESS_HEAP_ENTRY_Block
	hMem as HANDLE
	dwReserved(0 to 3-1) as DWORD
end type

type PROCESS_HEAP_ENTRY_Region
	dwCommittedSize as DWORD
	dwUnCommittedSize as DWORD
	lpFirstBlock as LPVOID
	lpLastBlock as LPVOID
end type

type PROCESS_HEAP_ENTRY
	lpData as PVOID
	cbData as DWORD
	cbOverhead as UBYTE
	iRegionIndex as UBYTE
	wFlags as WORD
	union
		Block as PROCESS_HEAP_ENTRY_Block
		Region as PROCESS_HEAP_ENTRY_Region
	end union
end type

type LPPROCESS_HEAP_ENTRY as PROCESS_HEAP_ENTRY ptr

type OFSTRUCT
	cBytes as UBYTE
	fFixedDisk as UBYTE
	nErrCode as WORD
	Reserved1 as WORD
	Reserved2 as WORD
	szPathName as zstring * 128
end type

type LPOFSTRUCT as OFSTRUCT ptr
type POFSTRUCT as OFSTRUCT ptr

type WIN_CERTIFICATE
	dwLength as DWORD
	wRevision as WORD
	wCertificateType as WORD
	bCertificate(0 to 1-1) as UBYTE
end type

type LPWIN_CERTIFICATE as WIN_CERTIFICATE ptr

#ifndef UNICODE
type ACTCTXA
	cbSize as ULONG
	dwFlags as DWORD
	lpSource as LPCSTR
	wProcessorArchitecture as USHORT
	wLangId as LANGID
	lpAssemblyDirectory as LPCSTR
	lpResourceName as LPCSTR
	lpApplicationName as LPCSTR
	hModule as HMODULE
end type

type PACTCTXA as ACTCTXA ptr
type PCACTCTXA as ACTCTXA ptr

#else
type ACTCTXW
	cbSize as ULONG
	dwFlags as DWORD
	lpSource as LPCWSTR
	wProcessorArchitecture as USHORT
	wLangId as LANGID
	lpAssemblyDirectory as LPCWSTR
	lpResourceName as LPCWSTR
	lpApplicationName as LPCWSTR
	hModule as HMODULE
end type

type PACTCTXW as ACTCTXW ptr
type PCACTCTXW as ACTCTXW ptr
#endif

type ACTCTX_SECTION_KEYED_DATA
	cbSize as ULONG
	ulDataFormatVersion as ULONG
	lpData as PVOID
	ulLength as ULONG
	lpSectionGlobalData as PVOID
	ulSectionGlobalDataLength as ULONG
	lpSectionBase as PVOID
	ulSectionTotalLength as ULONG
	hActCtx as HANDLE
	ulAssemblyRosterIndex as HANDLE
end type

type PACTCTX_SECTION_KEYED_DATA as ACTCTX_SECTION_KEYED_DATA ptr
type PCACTCTX_SECTION_KEYED_DATA as ACTCTX_SECTION_KEYED_DATA ptr

enum MEMORY_RESOURCE_NOTIFICATION_TYPE
	LowMemoryResourceNotification
	HighMemoryResourceNotification
end enum

enum COMPUTER_NAME_FORMAT
	ComputerNameNetBIOS
	ComputerNameDnsHostname
	ComputerNameDnsDomain
	ComputerNameDnsFullyQualified
	ComputerNamePhysicalNetBIOS
	ComputerNamePhysicalDnsHostname
	ComputerNamePhysicalDnsDomain
	ComputerNamePhysicalDnsFullyQualified
	ComputerNameMax
end enum

type EXECUTION_STATE as DWORD

type LPPROGRESS_ROUTINE as function (byval as LARGE_INTEGER, byval as LARGE_INTEGER, byval as LARGE_INTEGER, byval as LARGE_INTEGER, byval as DWORD, byval as DWORD, byval as HANDLE, byval as HANDLE, byval as LPVOID) as DWORD
type LPFIBER_START_ROUTINE as sub (byval as PVOID)
type ENUMRESLANGPROC as function (byval as HMODULE, byval as LPCTSTR, byval as LPCTSTR, byval as WORD, byval as LONG) as BOOL
type ENUMRESNAMEPROC as function (byval as HMODULE, byval as LPCTSTR, byval as LPTSTR, byval as LONG) as BOOL
type ENUMRESTYPEPROC as function (byval as HMODULE, byval as LPTSTR, byval as LONG) as BOOL
type LPOVERLAPPED_COMPLETION_ROUTINE as sub (byval as DWORD, byval as DWORD, byval as LPOVERLAPPED)
type PTOP_LEVEL_EXCEPTION_FILTER as function (byval as LPEXCEPTION_POINTERS) as LONG
type LPTOP_LEVEL_EXCEPTION_FILTER as PTOP_LEVEL_EXCEPTION_FILTER
type PAPCFUNC as sub (byval as DWORD)
type PTIMERAPCROUTINE as sub (byval as PVOID, byval as DWORD, byval as DWORD)

#define MAKEINTATOM(i) cptr(zstring ptr, cuint(i))

extern "windows" lib "kernel32"

declare function aWinMain (byval as HINSTANCE, byval as HINSTANCE, byval as LPSTR, byval as integer) as integer
declare function wWinMain (byval as HINSTANCE, byval as HINSTANCE, byval as LPWSTR, byval as integer) as integer
declare function _hread (byval as HFILE, byval as LPVOID, byval as integer) as integer
declare function _hwrite (byval as HFILE, byval as LPCSTR, byval as integer) as integer
declare function _lclose (byval as HFILE) as HFILE
declare function _lcreat (byval as LPCSTR, byval as integer) as HFILE
declare function _llseek (byval as HFILE, byval as LONG, byval as integer) as LONG
declare function _lopen (byval as LPCSTR, byval as integer) as HFILE
declare function _lread (byval as HFILE, byval as LPVOID, byval as UINT) as UINT
declare function _lwrite (byval as HFILE, byval as LPCSTR, byval as UINT) as UINT
declare function AccessCheck (byval as PSECURITY_DESCRIPTOR, byval as HANDLE, byval as DWORD, byval as PGENERIC_MAPPING, byval as PPRIVILEGE_SET, byval as PDWORD, byval as PDWORD, byval as PBOOL) as BOOL
declare function ActivateActCtx (byval as HANDLE, byval as ULONG_PTR ptr) as BOOL
declare function AddAccessAllowedAce (byval as PACL, byval as DWORD, byval as DWORD, byval as PSID) as BOOL
declare function AddAccessDeniedAce (byval as PACL, byval as DWORD, byval as DWORD, byval as PSID) as BOOL
declare function AddAccessAllowedAceEx (byval as PACL, byval as DWORD, byval as DWORD, byval as DWORD, byval as PSID) as BOOL
declare function AddAccessDeniedAceEx (byval as PACL, byval as DWORD, byval as DWORD, byval as DWORD, byval as PSID) as BOOL
declare function AddAce (byval as PACL, byval as DWORD, byval as DWORD, byval as PVOID, byval as DWORD) as BOOL
declare function AddAuditAccessAce (byval as PACL, byval as DWORD, byval as DWORD, byval as PSID, byval as BOOL, byval as BOOL) as BOOL
declare sub AddRefActCtx (byval as HANDLE)
declare function AddVectoredExceptionHandler (byval as ULONG, byval as PVECTORED_EXCEPTION_HANDLER) as PVOID
declare function AdjustTokenGroups (byval as HANDLE, byval as BOOL, byval as PTOKEN_GROUPS, byval as DWORD, byval as PTOKEN_GROUPS, byval as PDWORD) as BOOL
declare function AdjustTokenPrivileges (byval as HANDLE, byval as BOOL, byval as PTOKEN_PRIVILEGES, byval as DWORD, byval as PTOKEN_PRIVILEGES, byval as PDWORD) as BOOL
declare function AllocateAndInitializeSid (byval as PSID_IDENTIFIER_AUTHORITY, byval as UBYTE, byval as DWORD, byval as DWORD, byval as DWORD, byval as DWORD, byval as DWORD, byval as DWORD, byval as DWORD, byval as DWORD, byval as PSID ptr) as BOOL
declare function AllocateLocallyUniqueId (byval as PLUID) as BOOL
declare function AreAllAccessesGranted (byval as DWORD, byval as DWORD) as BOOL
declare function AreAnyAccessesGranted (byval as DWORD, byval as DWORD) as BOOL
declare function AreFileApisANSI () as BOOL
declare function BackupRead (byval as HANDLE, byval as LPBYTE, byval as DWORD, byval as LPDWORD, byval as BOOL, byval as BOOL, byval as LPVOID ptr) as BOOL
declare function BackupSeek (byval as HANDLE, byval as DWORD, byval as DWORD, byval as LPDWORD, byval as LPDWORD, byval as LPVOID ptr) as BOOL
declare function BackupWrite (byval as HANDLE, byval as LPBYTE, byval as DWORD, byval as LPDWORD, byval as BOOL, byval as BOOL, byval as LPVOID ptr) as BOOL
declare function Beep_ alias "Beep" (byval as DWORD, byval as DWORD) as BOOL
declare function CancelDeviceWakeupRequest (byval as HANDLE) as BOOL
declare function CancelIo (byval as HANDLE) as BOOL
declare function CancelWaitableTimer (byval as HANDLE) as BOOL
declare function CheckRemoteDebuggerPresent (byval as HANDLE, byval as PBOOL) as BOOL
declare function ClearCommBreak (byval as HANDLE) as BOOL
declare function ClearCommError (byval as HANDLE, byval as PDWORD, byval as LPCOMSTAT) as BOOL
declare function CloseEventLog (byval as HANDLE) as BOOL
declare function CloseHandle (byval as HANDLE) as BOOL
declare function CompareFileTime (byval as FILETIME ptr, byval as FILETIME ptr) as LONG
declare function ConnectNamedPipe (byval as HANDLE, byval as LPOVERLAPPED) as BOOL
declare function ContinueDebugEvent (byval as DWORD, byval as DWORD, byval as DWORD) as BOOL
declare function ConvertFiberToThread () as BOOL
declare function ConvertThreadToFiber (byval as PVOID) as PVOID
declare function CopySid (byval as DWORD, byval as PSID, byval as PSID) as BOOL
declare function CreateFiber (byval as SIZE_T, byval as LPFIBER_START_ROUTINE, byval as LPVOID) as LPVOID
declare function CreateFiberEx (byval as SIZE_T, byval as SIZE_T, byval as DWORD, byval as LPFIBER_START_ROUTINE, byval as LPVOID) as LPVOID
declare function CreateIoCompletionPort (byval as HANDLE, byval as HANDLE, byval as DWORD, byval as DWORD) as HANDLE
declare function CreatePipe (byval as PHANDLE, byval as PHANDLE, byval as LPSECURITY_ATTRIBUTES, byval as DWORD) as BOOL
declare function CreatePrivateObjectSecurity (byval as PSECURITY_DESCRIPTOR, byval as PSECURITY_DESCRIPTOR, byval as PSECURITY_DESCRIPTOR ptr, byval as BOOL, byval as HANDLE, byval as PGENERIC_MAPPING) as BOOL
declare function CreateRemoteThread (byval as HANDLE, byval as LPSECURITY_ATTRIBUTES, byval as DWORD, byval as LPTHREAD_START_ROUTINE, byval as LPVOID, byval as DWORD, byval as LPDWORD) as HANDLE
declare function CreateTapePartition (byval as HANDLE, byval as DWORD, byval as DWORD, byval as DWORD) as DWORD
declare function CreateTimerQueue () as HANDLE
declare function CreateTimerQueueTimer (byval as PHANDLE, byval as HANDLE, byval as WAITORTIMERCALLBACKFUNC, byval as PVOID, byval as DWORD, byval as DWORD, byval as ULONG) as BOOL
declare function CreateThread (byval as LPSECURITY_ATTRIBUTES, byval as DWORD, byval as LPTHREAD_START_ROUTINE, byval as PVOID, byval as DWORD, byval as PDWORD) as HANDLE
declare function DeactivateActCtx (byval as DWORD, byval as ULONG_PTR) as BOOL
declare function DebugActiveProcess (byval as DWORD) as BOOL
declare function DebugActiveProcessStop (byval as DWORD) as BOOL
declare sub DebugBreak ()
declare function DebugBreakProcess (byval as HANDLE) as BOOL
declare function DebugSetProcessKillOnExit (byval as BOOL) as BOOL
declare function DeleteAce (byval as PACL, byval as DWORD) as BOOL
declare function DeleteAtom (byval as ATOM) as ATOM
declare sub DeleteCriticalSection (byval as PCRITICAL_SECTION)
declare sub DeleteFiber (byval as PVOID)
declare function DeregisterEventSource (byval as HANDLE) as BOOL
declare function DestroyPrivateObjectSecurity (byval as PSECURITY_DESCRIPTOR ptr) as BOOL
declare function DeviceIoControl (byval as HANDLE, byval as DWORD, byval as PVOID, byval as DWORD, byval as PVOID, byval as DWORD, byval as PDWORD, byval as POVERLAPPED) as BOOL
declare function DisableThreadLibraryCalls (byval as HMODULE) as BOOL
declare function DisconnectNamedPipe (byval as HANDLE) as BOOL
declare function DosDateTimeToFileTime (byval as WORD, byval as WORD, byval as LPFILETIME) as BOOL
declare function DuplicateHandle (byval as HANDLE, byval as HANDLE, byval as HANDLE, byval as PHANDLE, byval as DWORD, byval as BOOL, byval as DWORD) as BOOL
declare function DuplicateToken (byval as HANDLE, byval as SECURITY_IMPERSONATION_LEVEL, byval as PHANDLE) as BOOL
declare function DuplicateTokenEx (byval as HANDLE, byval as DWORD, byval as LPSECURITY_ATTRIBUTES, byval as SECURITY_IMPERSONATION_LEVEL, byval as TOKEN_TYPE, byval as PHANDLE) as BOOL
declare sub EnterCriticalSection (byval as LPCRITICAL_SECTION)
declare function EqualPrefixSid (byval as PSID, byval as PSID) as BOOL
declare function EqualSid (byval as PSID, byval as PSID) as BOOL
declare function EraseTape (byval as HANDLE, byval as DWORD, byval as BOOL) as DWORD
declare function EscapeCommFunction (byval as HANDLE, byval as DWORD) as BOOL
declare sub ExitProcess (byval as UINT)
declare sub ExitThread (byval as DWORD)
declare sub FatalExit (byval as integer)
declare function FileTimeToDosDateTime (byval as FILETIME ptr, byval as LPWORD, byval as LPWORD) as BOOL
declare function FileTimeToLocalFileTime (byval as FILETIME ptr, byval as LPFILETIME) as BOOL
declare function FileTimeToSystemTime (byval as FILETIME ptr, byval as LPSYSTEMTIME) as BOOL
declare function FindClose (byval as HANDLE) as BOOL
declare function FindCloseChangeNotification (byval as HANDLE) as BOOL
declare function FindFirstFreeAce (byval as PACL, byval as PVOID ptr) as BOOL
declare function FindNextChangeNotification (byval as HANDLE) as BOOL
declare function FlushFileBuffers (byval as HANDLE) as BOOL
declare function FlushInstructionCache (byval as HANDLE, byval as PCVOID, byval as DWORD) as BOOL
declare function FlushViewOfFile (byval as PCVOID, byval as DWORD) as BOOL
declare function FreeLibrary (byval as HMODULE) as BOOL
declare sub FreeLibraryAndExitThread (byval as HMODULE, byval as DWORD)
declare function FreeResource (byval as HGLOBAL) as BOOL
declare function FreeSid (byval as PSID) as PVOID
declare function GetAce (byval as PACL, byval as DWORD, byval as LPVOID ptr) as BOOL
declare function GetAclInformation (byval as PACL, byval as PVOID, byval as DWORD, byval as ACL_INFORMATION_CLASS) as BOOL
declare function GetCommConfig (byval as HANDLE, byval as LPCOMMCONFIG, byval as PDWORD) as BOOL
declare function GetCommMask (byval as HANDLE, byval as PDWORD) as BOOL
declare function GetCommModemStatus (byval as HANDLE, byval as PDWORD) as BOOL
declare function GetCommProperties (byval as HANDLE, byval as LPCOMMPROP) as BOOL
declare function GetCommState (byval as HANDLE, byval as LPDCB) as BOOL
declare function GetCommTimeouts (byval as HANDLE, byval as LPCOMMTIMEOUTS) as BOOL
declare function GetCurrentActCtx (byval as HANDLE ptr) as BOOL
declare function GetCurrentProcess () as HANDLE
declare function GetCurrentProcessId () as DWORD
declare function GetCurrentThread () as HANDLE
declare function GetCurrentThreadId () as DWORD
declare function GetExitCodeProcess (byval as HANDLE, byval as PDWORD) as BOOL
declare function GetExitCodeThread (byval as HANDLE, byval as PDWORD) as BOOL
declare function GetFileInformationByHandle (byval as HANDLE, byval as LPBY_HANDLE_FILE_INFORMATION) as BOOL
declare function GetFileSize (byval as HANDLE, byval as PDWORD) as DWORD
declare function GetFileSizeEx (byval as HANDLE, byval as PLARGE_INTEGER) as BOOL
declare function GetFileTime (byval as HANDLE, byval as LPFILETIME, byval as LPFILETIME, byval as LPFILETIME) as BOOL
declare function GetFileType (byval as HANDLE) as DWORD
declare function GetHandleInformation (byval as HANDLE, byval as PDWORD) as BOOL
declare function GetKernelObjectSecurity (byval as HANDLE, byval as SECURITY_INFORMATION, byval as PSECURITY_DESCRIPTOR, byval as DWORD, byval as PDWORD) as BOOL
declare function GetLastError () as DWORD
declare function GetLengthSid (byval as PSID) as DWORD
declare sub GetLocalTime (byval as LPSYSTEMTIME)
declare function GetLogicalDrives () as DWORD
declare function GetMailslotInfo (byval as HANDLE, byval as PDWORD, byval as PDWORD, byval as PDWORD, byval as PDWORD) as BOOL
declare function GetNamedPipeInfo (byval as HANDLE, byval as PDWORD, byval as PDWORD, byval as PDWORD, byval as PDWORD) as BOOL
declare sub GetNativeSystemInfo (byval as LPSYSTEM_INFO)
declare function GetNumberOfEventLogRecords (byval as HANDLE, byval as PDWORD) as BOOL
declare function GetOldestEventLogRecord (byval as HANDLE, byval as PDWORD) as BOOL
declare function GetOverlappedResult (byval as HANDLE, byval as LPOVERLAPPED, byval as PDWORD, byval as BOOL) as BOOL
declare function GetPriorityClass (byval as HANDLE) as DWORD
declare function GetPrivateObjectSecurity (byval as PSECURITY_DESCRIPTOR, byval as SECURITY_INFORMATION, byval as PSECURITY_DESCRIPTOR, byval as DWORD, byval as PDWORD) as BOOL
declare function GetProcAddress (byval as HINSTANCE, byval as LPCSTR) as FARPROC
declare function GetProcessAffinityMask (byval as HANDLE, byval as PDWORD, byval as PDWORD) as BOOL
declare function GetProcessHandleCount (byval as HANDLE, byval as PDWORD) as BOOL
declare function GetProcessHeap () as HANDLE
declare function GetProcessHeaps (byval as DWORD, byval as PHANDLE) as DWORD
declare function GetProcessId (byval as HANDLE) as DWORD
declare function GetProcessIoCounters (byval as HANDLE, byval as PIO_COUNTERS) as BOOL
declare function GetProcessPriorityBoost (byval as HANDLE, byval as PBOOL) as BOOL
declare function GetProcessShutdownParameters (byval as PDWORD, byval as PDWORD) as BOOL
declare function GetProcessTimes (byval as HANDLE, byval as LPFILETIME, byval as LPFILETIME, byval as LPFILETIME, byval as LPFILETIME) as BOOL
declare function GetProcessVersion (byval as DWORD) as DWORD
declare function GetProcessWindowStation () as HWINSTA
declare function GetProcessWorkingSetSize (byval as HANDLE, byval as PSIZE_T, byval as PSIZE_T) as BOOL
declare function GetQueuedCompletionStatus (byval as HANDLE, byval as PDWORD, byval as PDWORD, byval as LPOVERLAPPED ptr, byval as DWORD) as BOOL
declare function GetSecurityDescriptorControl (byval as PSECURITY_DESCRIPTOR, byval as PSECURITY_DESCRIPTOR_CONTROL, byval as PDWORD) as BOOL
declare function GetSecurityDescriptorDacl (byval as PSECURITY_DESCRIPTOR, byval as LPBOOL, byval as PACL ptr, byval as LPBOOL) as BOOL
declare function GetSecurityDescriptorGroup (byval as PSECURITY_DESCRIPTOR, byval as PSID ptr, byval as LPBOOL) as BOOL
declare function GetSecurityDescriptorLength (byval as PSECURITY_DESCRIPTOR) as DWORD
declare function GetSecurityDescriptorOwner (byval as PSECURITY_DESCRIPTOR, byval as PSID ptr, byval as LPBOOL) as BOOL
declare function GetSecurityDescriptorSacl (byval as PSECURITY_DESCRIPTOR, byval as LPBOOL, byval as PACL ptr, byval as LPBOOL) as BOOL
declare function GetSidIdentifierAuthority (byval as PSID) as PSID_IDENTIFIER_AUTHORITY
declare function GetSidLengthRequired (byval as UCHAR) as DWORD
declare function GetSidSubAuthority (byval as PSID, byval as DWORD) as PDWORD
declare function GetSidSubAuthorityCount (byval as PSID) as PUCHAR
declare function GetStdHandle (byval as DWORD) as HANDLE
declare sub GetSystemInfo (byval as LPSYSTEM_INFO)
declare function GetSystemPowerStatus (byval as LPSYSTEM_POWER_STATUS) as BOOL
declare function GetSystemRegistryQuota (byval as PDWORD, byval as PDWORD) as BOOL
declare sub GetSystemTime (byval as LPSYSTEMTIME)
declare function GetSystemTimes (byval as LPFILETIME, byval as LPFILETIME, byval as LPFILETIME) as BOOL
declare function GetSystemTimeAdjustment (byval as PDWORD, byval as PDWORD, byval as PBOOL) as BOOL
declare sub GetSystemTimeAsFileTime (byval as LPFILETIME)
declare function GetTapeParameters (byval as HANDLE, byval as DWORD, byval as PDWORD, byval as PVOID) as DWORD
declare function GetTapePosition (byval as HANDLE, byval as DWORD, byval as PDWORD, byval as PDWORD, byval as PDWORD) as DWORD
declare function GetTapeStatus (byval as HANDLE) as DWORD
declare function GetThreadContext (byval as HANDLE, byval as LPCONTEXT) as BOOL
declare function GetThreadIOPendingFlag (byval as HANDLE, byval as PBOOL) as BOOL
declare function GetThreadPriority (byval as HANDLE) as integer
declare function GetThreadPriorityBoost (byval as HANDLE, byval as PBOOL) as BOOL
declare function GetThreadSelectorEntry (byval as HANDLE, byval as DWORD, byval as LPLDT_ENTRY) as BOOL
declare function GetThreadTimes (byval as HANDLE, byval as LPFILETIME, byval as LPFILETIME, byval as LPFILETIME, byval as LPFILETIME) as BOOL
declare function GetTickCount () as DWORD
declare function GetTimeZoneInformation (byval as LPTIME_ZONE_INFORMATION) as DWORD
declare function GetTokenInformation (byval as HANDLE, byval as TOKEN_INFORMATION_CLASS, byval as PVOID, byval as DWORD, byval as PDWORD) as BOOL
declare function GetVersion () as DWORD
declare function GetWindowThreadProcessId (byval as HWND, byval as PDWORD) as DWORD
declare function GetWriteWatch (byval as DWORD, byval as PVOID, byval as SIZE_T, byval as PVOID ptr, byval as PULONG_PTR, byval as PULONG) as UINT
declare function GlobalAlloc (byval as UINT, byval as DWORD) as HGLOBAL
declare function GlobalCompact (byval as DWORD) as SIZE_T
declare function GlobalDeleteAtom (byval as ATOM) as ATOM
declare function GlobalDiscard (byval as HGLOBAL) as HGLOBAL
declare sub GlobalFix (byval as HGLOBAL)
declare function GlobalFlags (byval as HGLOBAL) as UINT
declare function GlobalFree (byval as HGLOBAL) as HGLOBAL
declare function GlobalHandle (byval as PCVOID) as HGLOBAL
declare function GlobalLock (byval as HGLOBAL) as LPVOID
declare sub GlobalMemoryStatus (byval as LPMEMORYSTATUS)
declare function GlobalMemoryStatusEx (byval as LPMEMORYSTATUSEX) as BOOL
declare function GlobalReAlloc (byval as HGLOBAL, byval as DWORD, byval as UINT) as HGLOBAL
declare function GlobalSize (byval as HGLOBAL) as DWORD
declare sub GlobalUnfix (byval as HGLOBAL)
declare function GlobalUnlock (byval as HGLOBAL) as BOOL
declare function GlobalUnWire (byval as HGLOBAL) as BOOL
declare function GlobalWire (byval as HGLOBAL) as PVOID
#define HasOverlappedIoCompleted(lpOverlapped) ((lpOverlapped)->Internal <> STATUS_PENDING)
declare function HeapAlloc (byval as HANDLE, byval as DWORD, byval as DWORD) as PVOID
declare function HeapCompact (byval as HANDLE, byval as DWORD) as SIZE_T
declare function HeapCreate (byval as DWORD, byval as DWORD, byval as DWORD) as HANDLE
declare function HeapDestroy (byval as HANDLE) as BOOL
declare function HeapFree (byval as HANDLE, byval as DWORD, byval as PVOID) as BOOL
declare function HeapLock (byval as HANDLE) as BOOL
declare function HeapQueryInformation (byval as HANDLE, byval as HEAP_INFORMATION_CLASS, byval as PVOID, byval as SIZE_T, byval as PSIZE_T) as BOOL
declare function HeapReAlloc (byval as HANDLE, byval as DWORD, byval as PVOID, byval as DWORD) as PVOID
declare function HeapSetInformation (byval as HANDLE, byval as HEAP_INFORMATION_CLASS, byval as PVOID, byval as SIZE_T) as BOOL
declare function HeapSize (byval as HANDLE, byval as DWORD, byval as PCVOID) as DWORD
declare function HeapUnlock (byval as HANDLE) as BOOL
declare function HeapValidate (byval as HANDLE, byval as DWORD, byval as PCVOID) as BOOL
declare function HeapWalk (byval as HANDLE, byval as LPPROCESS_HEAP_ENTRY) as BOOL
declare function ImpersonateLoggedOnUser (byval as HANDLE) as BOOL
declare function ImpersonateNamedPipeClient (byval as HANDLE) as BOOL
declare function ImpersonateSelf (byval as SECURITY_IMPERSONATION_LEVEL) as BOOL
declare function InitAtomTable (byval as DWORD) as BOOL
declare function InitializeAcl (byval as PACL, byval as DWORD, byval as DWORD) as BOOL
declare sub InitializeCriticalSection (byval as LPCRITICAL_SECTION)
declare function InitializeCriticalSectionAndSpinCount (byval as LPCRITICAL_SECTION, byval as DWORD) as BOOL
declare function SetCriticalSectionSpinCount (byval as LPCRITICAL_SECTION, byval as DWORD) as DWORD
declare function InitializeSecurityDescriptor (byval as PSECURITY_DESCRIPTOR, byval as DWORD) as BOOL
declare function InitializeSid (byval as PSID, byval as PSID_IDENTIFIER_AUTHORITY, byval as UBYTE) as BOOL
declare sub InitializeSListHead (byval as PSLIST_HEADER)
declare function InterlockedCompareExchange (byval as LPLONG, byval as LONG, byval as LONG) as LONG
declare function InterlockedDecrement (byval as LPLONG) as LONG
declare function InterlockedExchange (byval as LPLONG, byval as LONG) as LONG
declare function InterlockedExchangeAdd (byval as LPLONG, byval as LONG) as LONG
declare function InterlockedFlushSList (byval as PSLIST_HEADER) as PSINGLE_LIST_ENTRY
declare function InterlockedIncrement (byval as LPLONG) as LONG
#define InterlockedCompareExchangePointer(d,e,c) cptr(PVOID, InterlockedCompareExchange( cptr(LPLONG, d),cint(e),cint(c) ))
#define InterlockedExchangePointer(t,v) cptr(PVOID, InterlockedExchange( cptr(LPLONG,t),cint(v) ))
declare function IsBadCodePtr (byval as FARPROC) as BOOL
declare function IsBadHugeReadPtr (byval as PCVOID, byval as UINT) as BOOL
declare function IsBadHugeWritePtr (byval as PVOID, byval as UINT) as BOOL
declare function IsBadReadPtr (byval as PCVOID, byval as UINT) as BOOL
declare function IsBadWritePtr (byval as PVOID, byval as UINT) as BOOL
declare function IsDebuggerPresent () as BOOL
declare function IsProcessInJob (byval as HANDLE, byval as HANDLE, byval as PBOOL) as BOOL
declare function IsProcessorFeaturePresent (byval as DWORD) as BOOL
declare function IsSystemResumeAutomatic () as BOOL
declare function IsTextUnicode (byval as PCVOID, byval as integer, byval as LPINT) as BOOL
declare function IsValidAcl (byval as PACL) as BOOL
declare function IsValidSecurityDescriptor (byval as PSECURITY_DESCRIPTOR) as BOOL
declare function IsValidSid (byval as PSID) as BOOL
declare function IsWow64Process (byval as HANDLE, byval as PBOOL) as BOOL
declare sub LeaveCriticalSection (byval as LPCRITICAL_SECTION)
declare function LoadModule (byval as LPCSTR, byval as PVOID) as DWORD
declare function LoadResource (byval as HINSTANCE, byval as HRSRC) as HGLOBAL
declare function LocalAlloc (byval as UINT, byval as SIZE_T) as HLOCAL
declare function LocalCompact (byval as UINT) as SIZE_T
declare function LocalDiscard (byval as HLOCAL) as HLOCAL
declare function LocalFileTimeToFileTime (byval as FILETIME ptr, byval as LPFILETIME) as BOOL
declare function LocalFlags (byval as HLOCAL) as UINT
declare function LocalFree (byval as HLOCAL) as HLOCAL
declare function LocalHandle (byval as LPCVOID) as HLOCAL
declare function LocalLock (byval as HLOCAL) as PVOID
declare function LocalReAlloc (byval as HLOCAL, byval as SIZE_T, byval as UINT) as HLOCAL
declare function LocalShrink (byval as HLOCAL, byval as UINT) as SIZE_T
declare function LocalSize (byval as HLOCAL) as UINT
declare function LocalUnlock (byval as HLOCAL) as BOOL
declare function LockFile (byval as HANDLE, byval as DWORD, byval as DWORD, byval as DWORD, byval as DWORD) as BOOL
declare function LockFileEx (byval as HANDLE, byval as DWORD, byval as DWORD, byval as DWORD, byval as DWORD, byval as LPOVERLAPPED) as BOOL
declare function LockResource (byval as HGLOBAL) as PVOID
declare function MakeAbsoluteSD (byval as PSECURITY_DESCRIPTOR, byval as PSECURITY_DESCRIPTOR, byval as PDWORD, byval as PACL, byval as PDWORD, byval as PACL, byval as PDWORD, byval as PSID, byval as PDWORD, byval as PSID, byval as PDWORD) as BOOL
declare function MakeSelfRelativeSD (byval as PSECURITY_DESCRIPTOR, byval as PSECURITY_DESCRIPTOR, byval as PDWORD) as BOOL
declare sub MapGenericMask (byval as PDWORD, byval as PGENERIC_MAPPING)
declare function MapViewOfFile (byval as HANDLE, byval as DWORD, byval as DWORD, byval as DWORD, byval as DWORD) as PVOID
declare function MapViewOfFileEx (byval as HANDLE, byval as DWORD, byval as DWORD, byval as DWORD, byval as DWORD, byval as PVOID) as PVOID
declare function MulDiv (byval as integer, byval as integer, byval as integer) as integer
declare function NotifyChangeEventLog (byval as HANDLE, byval as HANDLE) as BOOL
declare function OpenFile (byval as LPCSTR, byval as LPOFSTRUCT, byval as UINT) as HFILE
declare function OpenProcess (byval as DWORD, byval as BOOL, byval as DWORD) as HANDLE
declare function OpenProcessToken (byval as HANDLE, byval as DWORD, byval as PHANDLE) as BOOL
declare function OpenThread (byval as DWORD, byval as BOOL, byval as DWORD) as HANDLE
declare function OpenThreadToken (byval as HANDLE, byval as DWORD, byval as BOOL, byval as PHANDLE) as BOOL
declare function PeekNamedPipe (byval as HANDLE, byval as PVOID, byval as DWORD, byval as PDWORD, byval as PDWORD, byval as PDWORD) as BOOL
declare function PostQueuedCompletionStatus (byval as HANDLE, byval as DWORD, byval as DWORD, byval as LPOVERLAPPED) as BOOL
declare function PrepareTape (byval as HANDLE, byval as DWORD, byval as BOOL) as DWORD
declare function PrivilegeCheck (byval as HANDLE, byval as PPRIVILEGE_SET, byval as PBOOL) as BOOL
declare function ProcessIdToSessionId (byval as DWORD, byval as DWORD ptr) as BOOL
declare function PulseEvent (byval as HANDLE) as BOOL
declare function PurgeComm (byval as HANDLE, byval as DWORD) as BOOL
declare function QueryMemoryResourceNotification (byval as HANDLE, byval as PBOOL) as BOOL
declare function QueryPerformanceCounter (byval as PLARGE_INTEGER) as BOOL
declare function QueryPerformanceFrequency (byval as PLARGE_INTEGER) as BOOL
declare function QueueUserAPC (byval as PAPCFUNC, byval as HANDLE, byval as DWORD) as DWORD
declare function QueueUserWorkItem (byval as LPTHREAD_START_ROUTINE, byval as PVOID, byval as ULONG) as BOOL
declare sub RaiseException (byval as DWORD, byval as DWORD, byval as DWORD, byval as DWORD ptr)
declare function ReadFile (byval as HANDLE, byval as PVOID, byval as DWORD, byval as PDWORD, byval as LPOVERLAPPED) as BOOL
declare function ReadFileEx (byval as HANDLE, byval as PVOID, byval as DWORD, byval as LPOVERLAPPED, byval as LPOVERLAPPED_COMPLETION_ROUTINE) as BOOL
declare function ReadFileScatter (byval as HANDLE, byval as FILE_SEGMENT_ELEMENT ptr, byval as DWORD, byval as LPDWORD, byval as LPOVERLAPPED) as BOOL
declare function ReadProcessMemory (byval as HANDLE, byval as PCVOID, byval as PVOID, byval as DWORD, byval as PDWORD) as BOOL
declare function RegisterWaitForSingleObject (byval as PHANDLE, byval as HANDLE, byval as WAITORTIMERCALLBACKFUNC, byval as PVOID, byval as ULONG, byval as ULONG) as BOOL
declare function RegisterWaitForSingleObjectEx (byval as HANDLE, byval as WAITORTIMERCALLBACKFUNC, byval as PVOID, byval as ULONG, byval as ULONG) as HANDLE
declare sub ReleaseActCtx (byval as HANDLE)
declare function ReleaseMutex (byval as HANDLE) as BOOL
declare function ReleaseSemaphore (byval as HANDLE, byval as LONG, byval as LPLONG) as BOOL
declare function RemoveVectoredExceptionHandler (byval as PVOID) as ULONG
declare function ResetEvent (byval as HANDLE) as BOOL
declare function ResetWriteWatch (byval as LPVOID, byval as SIZE_T) as UINT
declare sub RestoreLastError (byval as DWORD)
declare function ResumeThread (byval as HANDLE) as DWORD
declare function RevertToSelf () as BOOL
declare function SetAclInformation (byval as PACL, byval as PVOID, byval as DWORD, byval as ACL_INFORMATION_CLASS) as BOOL
declare function SetCommBreak (byval as HANDLE) as BOOL
declare function SetCommConfig (byval as HANDLE, byval as LPCOMMCONFIG, byval as DWORD) as BOOL
declare function SetCommMask (byval as HANDLE, byval as DWORD) as BOOL
declare function SetCommState (byval as HANDLE, byval as LPDCB) as BOOL
declare function SetCommTimeouts (byval as HANDLE, byval as LPCOMMTIMEOUTS) as BOOL
declare function SetEndOfFile (byval as HANDLE) as BOOL
declare function SetErrorMode (byval as UINT) as UINT
declare function SetEvent (byval as HANDLE) as BOOL
declare sub SetFileApisToANSI ()
declare sub SetFileApisToOEM ()
declare function SetFilePointer (byval as HANDLE, byval as LONG, byval as PLONG, byval as DWORD) as DWORD
declare function SetFilePointerEx (byval as HANDLE, byval as LARGE_INTEGER, byval as PLARGE_INTEGER, byval as DWORD) as BOOL
declare function SetFileTime (byval as HANDLE, byval as FILETIME ptr, byval as FILETIME ptr, byval as FILETIME ptr) as BOOL
declare function SetFileValidData (byval as HANDLE, byval as LONGLONG) as BOOL
declare function SetHandleCount (byval as UINT) as UINT
declare function SetHandleInformation (byval as HANDLE, byval as DWORD, byval as DWORD) as BOOL
declare function SetKernelObjectSecurity (byval as HANDLE, byval as SECURITY_INFORMATION, byval as PSECURITY_DESCRIPTOR) as BOOL
declare sub SetLastError (byval as DWORD)
declare sub SetLastErrorEx (byval as DWORD, byval as DWORD)
declare function SetLocalTime (byval as SYSTEMTIME ptr) as BOOL
declare function SetMailslotInfo (byval as HANDLE, byval as DWORD) as BOOL
declare function SetNamedPipeHandleState (byval as HANDLE, byval as PDWORD, byval as PDWORD, byval as PDWORD) as BOOL
declare function SetPriorityClass (byval as HANDLE, byval as DWORD) as BOOL
declare function SetPrivateObjectSecurity (byval as SECURITY_INFORMATION, byval as PSECURITY_DESCRIPTOR, byval as PSECURITY_DESCRIPTOR ptr, byval as PGENERIC_MAPPING, byval as HANDLE) as BOOL
declare function SetProcessAffinityMask (byval as HANDLE, byval as DWORD) as BOOL
declare function SetProcessPriorityBoost (byval as HANDLE, byval as BOOL) as BOOL
declare function SetProcessShutdownParameters (byval as DWORD, byval as DWORD) as BOOL
declare function SetProcessWorkingSetSize (byval as HANDLE, byval as DWORD, byval as DWORD) as BOOL
declare function SetSecurityDescriptorControl (byval as PSECURITY_DESCRIPTOR, byval as SECURITY_DESCRIPTOR_CONTROL, byval as SECURITY_DESCRIPTOR_CONTROL) as BOOL
declare function SetSecurityDescriptorDacl (byval as PSECURITY_DESCRIPTOR, byval as BOOL, byval as PACL, byval as BOOL) as BOOL
declare function SetSecurityDescriptorGroup (byval as PSECURITY_DESCRIPTOR, byval as PSID, byval as BOOL) as BOOL
declare function SetSecurityDescriptorOwner (byval as PSECURITY_DESCRIPTOR, byval as PSID, byval as BOOL) as BOOL
declare function SetSecurityDescriptorSacl (byval as PSECURITY_DESCRIPTOR, byval as BOOL, byval as PACL, byval as BOOL) as BOOL
declare function SetStdHandle (byval as DWORD, byval as HANDLE) as BOOL
declare function SetSystemPowerState (byval as BOOL, byval as BOOL) as BOOL
declare function SetSystemTime (byval as SYSTEMTIME ptr) as BOOL
declare function SetSystemTimeAdjustment (byval as DWORD, byval as BOOL) as BOOL
declare function SetTapeParameters (byval as HANDLE, byval as DWORD, byval as PVOID) as DWORD
declare function SetTapePosition (byval as HANDLE, byval as DWORD, byval as DWORD, byval as DWORD, byval as DWORD, byval as BOOL) as DWORD
declare function SetThreadAffinityMask (byval as HANDLE, byval as DWORD) as DWORD
declare function SetThreadContext (byval as HANDLE, byval as CONTEXT ptr) as BOOL
declare function SetThreadExecutionState (byval as EXECUTION_STATE) as EXECUTION_STATE
declare function SetThreadIdealProcessor (byval as HANDLE, byval as DWORD) as DWORD
declare function SetThreadPriority (byval as HANDLE, byval as integer) as BOOL
declare function SetThreadPriorityBoost (byval as HANDLE, byval as BOOL) as BOOL
declare function SetThreadToken (byval as PHANDLE, byval as HANDLE) as BOOL
declare function SetTimeZoneInformation (byval as TIME_ZONE_INFORMATION ptr) as BOOL
declare function SetTokenInformation (byval as HANDLE, byval as TOKEN_INFORMATION_CLASS, byval as PVOID, byval as DWORD) as BOOL
declare function SetUnhandledExceptionFilter (byval as LPTOP_LEVEL_EXCEPTION_FILTER) as LPTOP_LEVEL_EXCEPTION_FILTER
declare function SetupComm (byval as HANDLE, byval as DWORD, byval as DWORD) as BOOL
declare function SetWaitableTimer (byval as HANDLE, byval as LARGE_INTEGER ptr, byval as LONG, byval as PTIMERAPCROUTINE, byval as PVOID, byval as BOOL) as BOOL
declare function SignalObjectAndWait (byval as HANDLE, byval as HANDLE, byval as DWORD, byval as BOOL) as DWORD
declare function SizeofResource (byval as HINSTANCE, byval as HRSRC) as DWORD
declare sub Sleep_ alias "Sleep" (byval as DWORD)
declare function SleepEx (byval as DWORD, byval as BOOL) as DWORD
declare function SuspendThread (byval as HANDLE) as DWORD
declare sub SwitchToFiber (byval as PVOID)
declare function SwitchToThread () as BOOL
declare function SystemTimeToFileTime (byval as SYSTEMTIME ptr, byval as LPFILETIME) as BOOL
declare function SystemTimeToTzSpecificLocalTime (byval as LPTIME_ZONE_INFORMATION, byval as LPSYSTEMTIME, byval as LPSYSTEMTIME) as BOOL
declare function TerminateProcess (byval as HANDLE, byval as UINT) as BOOL
declare function TerminateThread (byval as HANDLE, byval as DWORD) as BOOL
declare function TlsAlloc () as DWORD
declare function TlsFree (byval as DWORD) as BOOL
declare function TlsGetValue (byval as DWORD) as PVOID
declare function TlsSetValue (byval as DWORD, byval as PVOID) as BOOL
declare function TransactNamedPipe (byval as HANDLE, byval as PVOID, byval as DWORD, byval as PVOID, byval as DWORD, byval as PDWORD, byval as LPOVERLAPPED) as BOOL
declare function TransmitCommChar (byval as HANDLE, byval as byte) as BOOL
declare function TryEnterCriticalSection (byval as LPCRITICAL_SECTION) as BOOL
declare function UnhandledExceptionFilter (byval as LPEXCEPTION_POINTERS) as LONG
declare function UnlockFile (byval as HANDLE, byval as DWORD, byval as DWORD, byval as DWORD, byval as DWORD) as BOOL
declare function UnlockFileEx (byval as HANDLE, byval as DWORD, byval as DWORD, byval as DWORD, byval as LPOVERLAPPED) as BOOL
declare function UnmapViewOfFile (byval as PVOID) as BOOL
declare function UnregisterWaitEx (byval as HANDLE, byval as HANDLE) as BOOL
declare function VirtualAlloc (byval as PVOID, byval as DWORD, byval as DWORD, byval as DWORD) as PVOID
declare function VirtualAllocEx (byval as HANDLE, byval as PVOID, byval as DWORD, byval as DWORD, byval as DWORD) as PVOID
declare function VirtualFree (byval as PVOID, byval as DWORD, byval as DWORD) as BOOL
declare function VirtualFreeEx (byval as HANDLE, byval as PVOID, byval as DWORD, byval as DWORD) as BOOL
declare function VirtualLock (byval as PVOID, byval as DWORD) as BOOL
declare function VirtualProtect (byval as PVOID, byval as DWORD, byval as DWORD, byval as PDWORD) as BOOL
declare function VirtualProtectEx (byval as HANDLE, byval as PVOID, byval as DWORD, byval as DWORD, byval as PDWORD) as BOOL
declare function VirtualQuery (byval as LPCVOID, byval as PMEMORY_BASIC_INFORMATION, byval as DWORD) as DWORD
declare function VirtualQueryEx (byval as HANDLE, byval as LPCVOID, byval as PMEMORY_BASIC_INFORMATION, byval as DWORD) as DWORD
declare function VirtualUnlock (byval as PVOID, byval as DWORD) as BOOL
declare function WaitCommEvent (byval as HANDLE, byval as PDWORD, byval as LPOVERLAPPED) as BOOL
declare function WaitForDebugEvent (byval as LPDEBUG_EVENT, byval as DWORD) as BOOL
declare function WaitForMultipleObjects (byval as DWORD, byval as HANDLE ptr, byval as BOOL, byval as DWORD) as DWORD
declare function WaitForMultipleObjectsEx (byval as DWORD, byval as HANDLE ptr, byval as BOOL, byval as DWORD, byval as BOOL) as DWORD
declare function WaitForSingleObject (byval as HANDLE, byval as DWORD) as DWORD
declare function WaitForSingleObjectEx (byval as HANDLE, byval as DWORD, byval as BOOL) as DWORD
declare function WinLoadTrustProvider (byval as GUID ptr) as BOOL
declare function WriteFile (byval as HANDLE, byval as PCVOID, byval as DWORD, byval as PDWORD, byval as LPOVERLAPPED) as BOOL
declare function WriteFileEx (byval as HANDLE, byval as PCVOID, byval as DWORD, byval as LPOVERLAPPED, byval as LPOVERLAPPED_COMPLETION_ROUTINE) as BOOL
declare function WriteFileGather (byval as HANDLE, byval as FILE_SEGMENT_ELEMENT ptr, byval as DWORD, byval as LPDWORD, byval as LPOVERLAPPED) as BOOL
declare function WriteProcessMemory (byval as HANDLE, byval as LPVOID, byval as LPCVOID, byval as SIZE_T, byval as SIZE_T ptr) as BOOL
declare function WriteTapemark (byval as HANDLE, byval as DWORD, byval as DWORD, byval as BOOL) as DWORD
declare function TerminateJobObject (byval as HANDLE, byval as UINT) as BOOL
declare function AssignProcessToJobObject (byval as HANDLE, byval as HANDLE) as BOOL
declare function CreateMemoryResourceNotification (byval as MEMORY_RESOURCE_NOTIFICATION_TYPE) as HANDLE
declare function DeleteTimerQueue (byval as HANDLE) as BOOL
declare function DeleteTimerQueueEx (byval as HANDLE, byval as HANDLE) as BOOL
declare function DeleteTimerQueueTimer (byval as HANDLE, byval as HANDLE, byval as HANDLE) as BOOL
declare function FindActCtxSectionGuid (byval as DWORD, byval as GUID ptr, byval as ULONG, byval as GUID ptr, byval as PACTCTX_SECTION_KEYED_DATA) as BOOL
declare function FindVolumeClose (byval as HANDLE) as BOOL
declare function FindVolumeMountPointClose (byval as HANDLE) as BOOL
declare function ZombifyActCtx (byval as HANDLE) as BOOL
declare function AllocateUserPhysicalPages (byval as HANDLE, byval as PULONG_PTR, byval as PULONG_PTR) as BOOL
declare function FreeUserPhysicalPages (byval as HANDLE, byval as PULONG_PTR, byval as PULONG_PTR) as BOOL
declare function MapUserPhysicalPages (byval as PVOID, byval as ULONG_PTR, byval as PULONG_PTR) as BOOL
declare function MapUserPhysicalPagesScatter (byval as PVOID ptr, byval as ULONG_PTR, byval as PULONG_PTR) as BOOL

#ifdef UNICODE
type STARTUPINFO as STARTUPINFOW
type LPSTARTUPINFO as STARTUPINFOW ptr
type WIN32_FIND_DATA as WIN32_FIND_DATAW
type LPWIN32_FIND_DATA as WIN32_FIND_DATAW ptr
type HW_PROFILE_INFO as HW_PROFILE_INFOW
type LPHW_PROFILE_INFO as HW_PROFILE_INFOW ptr

declare function AccessCheckAndAuditAlarm alias "AccessCheckAndAuditAlarmW" (byval as LPCWSTR, byval as LPVOID, byval as LPWSTR, byval as LPWSTR, byval as PSECURITY_DESCRIPTOR, byval as DWORD, byval as PGENERIC_MAPPING, byval as BOOL, byval as PDWORD, byval as PBOOL, byval as PBOOL) as BOOL
declare function AddAtom alias "AddAtomW" (byval as LPCWSTR) as ATOM
declare function BackupEventLog alias "BackupEventLogW" (byval as HANDLE, byval as LPCWSTR) as BOOL
declare function BeginUpdateResource alias "BeginUpdateResourceW" (byval as LPCWSTR, byval as BOOL) as HANDLE
declare function BuildCommDCB alias "BuildCommDCBW" (byval as LPCWSTR, byval as LPDCB) as BOOL
declare function BuildCommDCBAndTimeouts alias "BuildCommDCBAndTimeoutsW" (byval as LPCWSTR, byval as LPDCB, byval as LPCOMMTIMEOUTS) as BOOL
declare function CallNamedPipe alias "CallNamedPipeW" (byval as LPCWSTR, byval as PVOID, byval as DWORD, byval as PVOID, byval as DWORD, byval as PDWORD, byval as DWORD) as BOOL
declare function ClearEventLog alias "ClearEventLogW" (byval as HANDLE, byval as LPCWSTR) as BOOL
declare function CommConfigDialog alias "CommConfigDialogW" (byval as LPCWSTR, byval as HWND, byval as LPCOMMCONFIG) as BOOL
declare function CopyFile alias "CopyFileW" (byval as LPCWSTR, byval as LPCWSTR, byval as BOOL) as BOOL
declare function CopyFileEx alias "CopyFileExW" (byval as LPCWSTR, byval as LPCWSTR, byval as LPPROGRESS_ROUTINE, byval as LPVOID, byval as LPBOOL, byval as DWORD) as BOOL
declare function CreateDirectory alias "CreateDirectoryW" (byval as LPCWSTR, byval as LPSECURITY_ATTRIBUTES) as BOOL
declare function CreateDirectoryEx alias "CreateDirectoryExW" (byval as LPCWSTR, byval as LPCWSTR, byval as LPSECURITY_ATTRIBUTES) as BOOL
declare function CreateEvent alias "CreateEventW" (byval as LPSECURITY_ATTRIBUTES, byval as BOOL, byval as BOOL, byval as LPCWSTR) as HANDLE
declare function CreateFile alias "CreateFileW" (byval as LPCWSTR, byval as DWORD, byval as DWORD, byval as LPSECURITY_ATTRIBUTES, byval as DWORD, byval as DWORD, byval as HANDLE) as HANDLE
declare function CreateFileMapping alias "CreateFileMappingW" (byval as HANDLE, byval as LPSECURITY_ATTRIBUTES, byval as DWORD, byval as DWORD, byval as DWORD, byval as LPCWSTR) as HANDLE
declare function CreateMailslot alias "CreateMailslotW" (byval as LPCWSTR, byval as DWORD, byval as DWORD, byval as LPSECURITY_ATTRIBUTES) as HANDLE
declare function CreateMutex alias "CreateMutexW" (byval as LPSECURITY_ATTRIBUTES, byval as BOOL, byval as LPCWSTR) as HANDLE
declare function CreateNamedPipe alias "CreateNamedPipeW" (byval as LPCWSTR, byval as DWORD, byval as DWORD, byval as DWORD, byval as DWORD, byval as DWORD, byval as DWORD, byval as LPSECURITY_ATTRIBUTES) as HANDLE
declare function CreateProcess alias "CreateProcessW" (byval as LPCWSTR, byval as LPWSTR, byval as LPSECURITY_ATTRIBUTES, byval as LPSECURITY_ATTRIBUTES, byval as BOOL, byval as DWORD, byval as PVOID, byval as LPCWSTR, byval as LPSTARTUPINFOW, byval as LPPROCESS_INFORMATION) as BOOL
declare function CreateProcessAsUser alias "CreateProcessAsUserW" (byval as HANDLE, byval as LPCWSTR, byval as LPWSTR, byval as LPSECURITY_ATTRIBUTES, byval as LPSECURITY_ATTRIBUTES, byval as BOOL, byval as DWORD, byval as PVOID, byval as LPCWSTR, byval as LPSTARTUPINFOW, byval as LPPROCESS_INFORMATION) as BOOL
declare function CreateSemaphore alias "CreateSemaphoreW" (byval as LPSECURITY_ATTRIBUTES, byval as LONG, byval as LONG, byval as LPCWSTR) as HANDLE
declare function CreateWaitableTimer alias "CreateWaitableTimerW" (byval as LPSECURITY_ATTRIBUTES, byval as BOOL, byval as LPCWSTR) as HANDLE
declare function DefineDosDevice alias "DefineDosDeviceW" (byval as DWORD, byval as LPCWSTR, byval as LPCWSTR) as BOOL
declare function DeleteFile alias "DeleteFileW" (byval as LPCWSTR) as BOOL
declare function EncryptFile alias "EncryptFileW" (byval as LPCWSTR) as BOOL
declare function EndUpdateResource alias "EndUpdateResourceW" (byval as HANDLE, byval as BOOL) as BOOL
declare function EnumResourceLanguages alias "EnumResourceLanguagesW" (byval as HMODULE, byval as LPCWSTR, byval as LPCWSTR, byval as ENUMRESLANGPROC, byval as LONG_PTR) as BOOL
declare function EnumResourceNames alias "EnumResourceNamesW" (byval as HMODULE, byval as LPCWSTR, byval as ENUMRESNAMEPROC, byval as LONG_PTR) as BOOL
declare function EnumResourceTypes alias "EnumResourceTypesW" (byval as HMODULE, byval as ENUMRESTYPEPROC, byval as LONG_PTR) as BOOL
declare function ExpandEnvironmentStrings alias "ExpandEnvironmentStringsW" (byval as LPCWSTR, byval as LPWSTR, byval as DWORD) as DWORD
declare sub FatalAppExit alias "FatalAppExitW" (byval as UINT, byval as LPCWSTR)
declare function FileEncryptionStatus alias "FileEncryptionStatusW" (byval as LPCWSTR, byval as LPDWORD) as BOOL
declare function FindAtom alias "FindAtomW" (byval as LPCWSTR) as ATOM
declare function FindFirstChangeNotification alias "FindFirstChangeNotificationW" (byval as LPCWSTR, byval as BOOL, byval as DWORD) as HANDLE
declare function FindFirstFile alias "FindFirstFileW" (byval as LPCWSTR, byval as LPWIN32_FIND_DATAW) as HANDLE
declare function FindFirstFileEx alias "FindFirstFileExW" (byval as LPCWSTR, byval as FINDEX_INFO_LEVELS, byval as PVOID, byval as FINDEX_SEARCH_OPS, byval as PVOID, byval as DWORD) as HANDLE
declare function FindNextFile alias "FindNextFileW" (byval as HANDLE, byval as LPWIN32_FIND_DATAW) as BOOL
declare function FindResource alias "FindResourceW" (byval as HINSTANCE, byval as LPCWSTR, byval as LPCWSTR) as HRSRC
declare function FindResourceEx alias "FindResourceExW" (byval as HINSTANCE, byval as LPCWSTR, byval as LPCWSTR, byval as WORD) as HRSRC
declare function FormatMessage alias "FormatMessageW" (byval as DWORD, byval as PCVOID, byval as DWORD, byval as DWORD, byval as LPWSTR, byval as DWORD, byval as any ptr) as DWORD
declare function FreeEnvironmentStrings alias "FreeEnvironmentStringsW" (byval as LPWSTR) as BOOL
declare function GetAtomName alias "GetAtomNameW" (byval as ATOM, byval as LPWSTR, byval as integer) as UINT
declare function GetBinaryType alias "GetBinaryTypeW" (byval as LPCWSTR, byval as PDWORD) as BOOL
declare function GetCommandLine alias "GetCommandLineW" () as LPWSTR
declare function GetCompressedFileSize alias "GetCompressedFileSizeW" (byval as LPCWSTR, byval as PDWORD) as DWORD
declare function GetComputerName alias "GetComputerNameW" (byval as LPWSTR, byval as PDWORD) as BOOL
declare function GetComputerNameEx alias "GetComputerNameExW" (byval as COMPUTER_NAME_FORMAT, byval as LPWSTR, byval as LPDWORD) as BOOL
declare function GetCurrentDirectory alias "GetCurrentDirectoryW" (byval as DWORD, byval as LPWSTR) as DWORD
declare function GetCurrentHwProfile alias "GetCurrentHwProfileW" (byval as LPHW_PROFILE_INFOW) as BOOL
declare function GetDefaultCommConfig alias "GetDefaultCommConfigW" (byval as LPCWSTR, byval as LPCOMMCONFIG, byval as PDWORD) as BOOL
declare function GetDiskFreeSpace alias "GetDiskFreeSpaceW" (byval as LPCWSTR, byval as PDWORD, byval as PDWORD, byval as PDWORD, byval as PDWORD) as BOOL
declare function GetDiskFreeSpaceEx alias "GetDiskFreeSpaceExW" (byval as LPCWSTR, byval as PULARGE_INTEGER, byval as PULARGE_INTEGER, byval as PULARGE_INTEGER) as BOOL
declare function GetDriveType alias "GetDriveTypeW" (byval as LPCWSTR) as UINT
declare function GetEnvironmentStrings alias "GetEnvironmentStringsW" () as LPWSTR
declare function GetEnvironmentVariable alias "GetEnvironmentVariableW" (byval as LPCWSTR, byval as LPWSTR, byval as DWORD) as DWORD
declare function GetFileAttributes alias "GetFileAttributesW" (byval as LPCWSTR) as DWORD
declare function GetFileAttributesEx alias "GetFileAttributesExW" (byval as LPCWSTR, byval as GET_FILEEX_INFO_LEVELS, byval as PVOID) as BOOL
declare function GetFileSecurity alias "GetFileSecurityW" (byval as LPCWSTR, byval as SECURITY_INFORMATION, byval as PSECURITY_DESCRIPTOR, byval as DWORD, byval as PDWORD) as BOOL
declare function GetFullPathName alias "GetFullPathNameW" (byval as LPCWSTR, byval as DWORD, byval as LPWSTR, byval as LPWSTR ptr) as DWORD
declare function GetLogicalDriveStrings alias "GetLogicalDriveStringsW" (byval as DWORD, byval as LPWSTR) as DWORD
declare function GetModuleFileName alias "GetModuleFileNameW" (byval as HINSTANCE, byval as LPWSTR, byval as DWORD) as DWORD
declare function GetModuleHandle alias "GetModuleHandleW" (byval as LPCWSTR) as HMODULE
declare function GetNamedPipeHandleState alias "GetNamedPipeHandleStateW" (byval as HANDLE, byval as PDWORD, byval as PDWORD, byval as PDWORD, byval as PDWORD, byval as LPWSTR, byval as DWORD) as BOOL
declare function GetPrivateProfileInt alias "GetPrivateProfileIntW" (byval as LPCWSTR, byval as LPCWSTR, byval as INT_, byval as LPCWSTR) as UINT
declare function GetPrivateProfileSection alias "GetPrivateProfileSectionW" (byval as LPCWSTR, byval as LPWSTR, byval as DWORD, byval as LPCWSTR) as DWORD
declare function GetPrivateProfileSectionNames alias "GetPrivateProfileSectionNamesW" (byval as LPWSTR, byval as DWORD, byval as LPCWSTR) as DWORD
declare function GetPrivateProfileString alias "GetPrivateProfileStringW" (byval as LPCWSTR, byval as LPCWSTR, byval as LPCWSTR, byval as LPWSTR, byval as DWORD, byval as LPCWSTR) as DWORD
declare function GetPrivateProfileStruct alias "GetPrivateProfileStructW" (byval as LPCWSTR, byval as LPCWSTR, byval as LPVOID, byval as UINT, byval as LPCWSTR) as BOOL
declare function GetProfileInt alias "GetProfileIntW" (byval as LPCWSTR, byval as LPCWSTR, byval as INT_) as UINT
declare function GetProfileSection alias "GetProfileSectionW" (byval as LPCWSTR, byval as LPWSTR, byval as DWORD) as DWORD
declare function GetProfileString alias "GetProfileStringW" (byval as LPCWSTR, byval as LPCWSTR, byval as LPCWSTR, byval as LPWSTR, byval as DWORD) as DWORD
declare function GetShortPathName alias "GetShortPathNameW" (byval as LPCWSTR, byval as LPWSTR, byval as DWORD) as DWORD
declare sub GetStartupInfo alias "GetStartupInfoW" (byval as LPSTARTUPINFOW)
declare function GetSystemDirectory alias "GetSystemDirectoryW" (byval as LPWSTR, byval as UINT) as UINT
declare function GetTempFileName alias "GetTempFileNameW" (byval as LPCWSTR, byval as LPCWSTR, byval as UINT, byval as LPWSTR) as UINT
declare function GetTempPath alias "GetTempPathW" (byval as DWORD, byval as LPWSTR) as DWORD
declare function GetUserName alias "GetUserNameW" (byval as LPWSTR, byval as PDWORD) as BOOL
declare function GetVersionEx alias "GetVersionExW" (byval as LPOSVERSIONINFOW) as BOOL
declare function GetVolumeInformation alias "GetVolumeInformationW" (byval as LPCWSTR, byval as LPWSTR, byval as DWORD, byval as PDWORD, byval as PDWORD, byval as PDWORD, byval as LPWSTR, byval as DWORD) as BOOL
declare function GetWindowsDirectory alias "GetWindowsDirectoryW" (byval as LPWSTR, byval as UINT) as UINT
declare function GlobalAddAtom alias "GlobalAddAtomW" (byval as LPCWSTR) as ATOM
declare function GlobalFindAtom alias "GlobalFindAtomW" (byval as LPCWSTR) as ATOM
declare function GlobalGetAtomName alias "GlobalGetAtomNameW" (byval as ATOM, byval as LPWSTR, byval as integer) as UINT
declare function IsBadStringPtr alias "IsBadStringPtrW" (byval as LPCWSTR, byval as UINT) as BOOL
declare function LoadLibraryEx alias "LoadLibraryExW" (byval as LPCWSTR, byval as HANDLE, byval as DWORD) as HINSTANCE
declare function LoadLibrary alias "LoadLibraryW" (byval as LPCWSTR) as HINSTANCE
declare function LogonUser alias "LogonUserW" (byval as LPWSTR, byval as LPWSTR, byval as LPWSTR, byval as DWORD, byval as DWORD, byval as PHANDLE) as BOOL
declare function LookupAccountName alias "LookupAccountNameW" (byval as LPCWSTR, byval as LPCWSTR, byval as PSID, byval as PDWORD, byval as LPWSTR, byval as PDWORD, byval as PSID_NAME_USE) as BOOL
declare function LookupAccountSid alias "LookupAccountSidW" (byval as LPCWSTR, byval as PSID, byval as LPWSTR, byval as PDWORD, byval as LPWSTR, byval as PDWORD, byval as PSID_NAME_USE) as BOOL
declare function LookupPrivilegeDisplayName alias "LookupPrivilegeDisplayNameW" (byval as LPCWSTR, byval as LPCWSTR, byval as LPWSTR, byval as PDWORD, byval as PDWORD) as BOOL
declare function LookupPrivilegeName alias "LookupPrivilegeNameW" (byval as LPCWSTR, byval as PLUID, byval as LPWSTR, byval as PDWORD) as BOOL
declare function LookupPrivilegeValue alias "LookupPrivilegeValueW" (byval as LPCWSTR, byval as LPCWSTR, byval as PLUID) as BOOL
declare function lstrcat alias "lstrcatW" (byval as LPWSTR, byval as LPCWSTR) as LPWSTR
declare function lstrcmpi alias "lstrcmpiW" (byval as LPCWSTR, byval as LPCWSTR) as integer
declare function lstrcmp alias "lstrcmpW" (byval as LPCWSTR, byval as LPCWSTR) as integer
declare function lstrcpyn alias "lstrcpynW" (byval as LPWSTR, byval as LPCWSTR, byval as integer) as LPWSTR
declare function lstrcpy alias "lstrcpyW" (byval as LPWSTR, byval as LPCWSTR) as LPWSTR
declare function lstrlen alias "lstrlenW" (byval as LPCWSTR) as integer
declare function MoveFileEx alias "MoveFileExW" (byval as LPCWSTR, byval as LPCWSTR, byval as DWORD) as BOOL
declare function MoveFile alias "MoveFileW" (byval as LPCWSTR, byval as LPCWSTR) as BOOL
declare function ObjectCloseAuditAlarm alias "ObjectCloseAuditAlarmW" (byval as LPCWSTR, byval as PVOID, byval as BOOL) as BOOL
declare function ObjectDeleteAuditAlarm alias "ObjectDeleteAuditAlarmW" (byval as LPCWSTR, byval as PVOID, byval as BOOL) as BOOL
declare function ObjectOpenAuditAlarm alias "ObjectOpenAuditAlarmW" (byval as LPCWSTR, byval as PVOID, byval as LPWSTR, byval as LPWSTR, byval as PSECURITY_DESCRIPTOR, byval as HANDLE, byval as DWORD, byval as DWORD, byval as PPRIVILEGE_SET, byval as BOOL, byval as BOOL, byval as PBOOL) as BOOL
declare function ObjectPrivilegeAuditAlarm alias "ObjectPrivilegeAuditAlarmW" (byval as LPCWSTR, byval as PVOID, byval as HANDLE, byval as DWORD, byval as PPRIVILEGE_SET, byval as BOOL) as BOOL
declare function OpenBackupEventLog alias "OpenBackupEventLogW" (byval as LPCWSTR, byval as LPCWSTR) as HANDLE
declare function OpenEventLog alias "OpenEventLogW" (byval as LPCWSTR, byval as LPCWSTR) as HANDLE
declare function OpenEvent alias "OpenEventW" (byval as DWORD, byval as BOOL, byval as LPCWSTR) as HANDLE
declare function OpenFileMapping alias "OpenFileMappingW" (byval as DWORD, byval as BOOL, byval as LPCWSTR) as HANDLE
declare function OpenMutex alias "OpenMutexW" (byval as DWORD, byval as BOOL, byval as LPCWSTR) as HANDLE
declare function OpenSemaphore alias "OpenSemaphoreW" (byval as DWORD, byval as BOOL, byval as LPCWSTR) as HANDLE
declare function OpenWaitableTimer alias "OpenWaitableTimerW" (byval as DWORD, byval as BOOL, byval as LPCWSTR) as HANDLE
declare sub OutputDebugString alias "OutputDebugStringW" (byval as LPCWSTR)
declare function PrivilegedServiceAuditAlarm alias "PrivilegedServiceAuditAlarmW" (byval as LPCWSTR, byval as LPCWSTR, byval as HANDLE, byval as PPRIVILEGE_SET, byval as BOOL) as BOOL
declare function QueryDosDevice alias "QueryDosDeviceW" (byval as LPCWSTR, byval as LPWSTR, byval as DWORD) as DWORD
declare function ReadDirectoryChanges alias "ReadDirectoryChangesW" (byval as HANDLE, byval as PVOID, byval as DWORD, byval as BOOL, byval as DWORD, byval as PDWORD, byval as LPOVERLAPPED, byval as LPOVERLAPPED_COMPLETION_ROUTINE) as BOOL
declare function ReadEventLog alias "ReadEventLogW" (byval as HANDLE, byval as DWORD, byval as DWORD, byval as PVOID, byval as DWORD, byval as DWORD ptr, byval as DWORD ptr) as BOOL
declare function RegisterEventSource alias "RegisterEventSourceW" (byval as LPCWSTR, byval as LPCWSTR) as HANDLE
declare function RemoveDirectory alias "RemoveDirectoryW" (byval as LPCWSTR) as BOOL
declare function ReportEvent alias "ReportEventW" (byval as HANDLE, byval as WORD, byval as WORD, byval as DWORD, byval as PSID, byval as WORD, byval as DWORD, byval as LPCWSTR ptr, byval as PVOID) as BOOL
declare function SearchPath alias "SearchPathW" (byval as LPCWSTR, byval as LPCWSTR, byval as LPCWSTR, byval as DWORD, byval as LPWSTR, byval as LPWSTR ptr) as DWORD
declare function SetComputerName alias "SetComputerNameW" (byval as LPCWSTR) as BOOL
declare function SetCurrentDirectory alias "SetCurrentDirectoryW" (byval as LPCWSTR) as BOOL
declare function SetDefaultCommConfig alias "SetDefaultCommConfigW" (byval as LPCWSTR, byval as LPCOMMCONFIG, byval as DWORD) as BOOL
declare function SetEnvironmentVariable alias "SetEnvironmentVariableW" (byval as LPCWSTR, byval as LPCWSTR) as BOOL
declare function SetFileAttributes alias "SetFileAttributesW" (byval as LPCWSTR, byval as DWORD) as BOOL
declare function SetFileSecurity alias "SetFileSecurityW" (byval as LPCWSTR, byval as SECURITY_INFORMATION, byval as PSECURITY_DESCRIPTOR) as BOOL
declare function SetVolumeLabel alias "SetVolumeLabelW" (byval as LPCWSTR, byval as LPCWSTR) as BOOL
declare function UpdateResource alias "UpdateResourceW" (byval as HANDLE, byval as LPCWSTR, byval as LPCWSTR, byval as WORD, byval as PVOID, byval as DWORD) as BOOL
declare function VerifyVersionInfo alias "VerifyVersionInfoW" (byval as LPOSVERSIONINFOEXW, byval as DWORD, byval as DWORDLONG) as BOOL
declare function WaitNamedPipe alias "WaitNamedPipeW" (byval as LPCWSTR, byval as DWORD) as BOOL
declare function WritePrivateProfileSection alias "WritePrivateProfileSectionW" (byval as LPCWSTR, byval as LPCWSTR, byval as LPCWSTR) as BOOL
declare function WritePrivateProfileString alias "WritePrivateProfileStringW" (byval as LPCWSTR, byval as LPCWSTR, byval as LPCWSTR, byval as LPCWSTR) as BOOL
declare function WritePrivateProfileStruct alias "WritePrivateProfileStructW" (byval as LPCWSTR, byval as LPCWSTR, byval as LPVOID, byval as UINT, byval as LPCWSTR) as BOOL
declare function WriteProfileSection alias "WriteProfileSectionW" (byval as LPCWSTR, byval as LPCWSTR) as BOOL
declare function WriteProfileString alias "WriteProfileStringW" (byval as LPCWSTR, byval as LPCWSTR, byval as LPCWSTR) as BOOL
declare function CreateActCtx alias "CreateActCtxW" (byval as PCACTCTXW) as HANDLE
declare function CreateHardLink alias "CreateHardLinkW" (byval as LPCWSTR, byval as LPCWSTR, byval as LPSECURITY_ATTRIBUTES) as BOOL
declare function CreateJobObject alias "CreateJobObjectW" (byval as LPSECURITY_ATTRIBUTES, byval as LPCWSTR) as HANDLE
declare function CreateProcessWithLogon alias "CreateProcessWithLogonW" (byval as LPCWSTR, byval as LPCWSTR, byval as LPCWSTR, byval as DWORD, byval as LPCWSTR, byval as LPWSTR, byval as DWORD, byval as LPVOID, byval as LPCWSTR, byval as LPSTARTUPINFOW, byval as LPPROCESS_INFORMATION) as BOOL
declare function DeleteVolumeMountPoint alias "DeleteVolumeMountPointW" (byval as LPCWSTR) as BOOL
declare function DnsHostnameToComputerName alias "DnsHostnameToComputerNameW" (byval as LPCWSTR, byval as LPWSTR, byval as LPDWORD) as BOOL
declare function FindActCtxSectionString alias "FindActCtxSectionStringW" (byval as DWORD, byval as GUID ptr, byval as ULONG, byval as LPCWSTR, byval as PACTCTX_SECTION_KEYED_DATA) as BOOL
declare function FindNextVolume alias "FindNextVolumeW" (byval as HANDLE, byval as LPWSTR, byval as DWORD) as BOOL
declare function FindNextVolumeMountPoint alias "FindNextVolumeMountPointW" (byval as HANDLE, byval as LPWSTR, byval as DWORD) as BOOL
declare function GetFirmwareEnvironmentVariable alias "GetFirmwareEnvironmentVariableW" (byval as LPCWSTR, byval as LPCWSTR, byval as PVOID, byval as DWORD) as DWORD
declare function GetDllDirectory alias "GetDllDirectoryW" (byval as DWORD, byval as LPWSTR) as DWORD
declare function GetLongPathName alias "GetLongPathNameW" (byval as LPCWSTR, byval as LPWSTR, byval as DWORD) as DWORD
declare function GetModuleHandleEx alias "GetModuleHandleExW" (byval as DWORD, byval as LPCWSTR, byval as HMODULE ptr) as BOOL
declare function GetSystemWow64Directory alias "GetSystemWow64DirectoryW" (byval as LPWSTR, byval as UINT) as UINT
declare function GetVolumeNameForVolumeMountPoint alias "GetVolumeNameForVolumeMountPointW" (byval as LPCWSTR, byval as LPWSTR, byval as DWORD) as BOOL
declare function GetVolumePathName alias "GetVolumePathNameW" (byval as LPCWSTR, byval as LPWSTR, byval as DWORD) as BOOL
declare function GetVolumePathNamesForVolumeName alias "GetVolumePathNamesForVolumeNameW" (byval as LPCWSTR, byval as LPWSTR, byval as DWORD, byval as PDWORD) as BOOL
declare function QueryActCtx alias "QueryActCtxW" (byval as DWORD, byval as HANDLE, byval as PVOID, byval as ULONG, byval as PVOID, byval as SIZE_T, byval as SIZE_T ptr) as BOOL
declare function SetComputerNameEx alias "SetComputerNameExW" (byval as COMPUTER_NAME_FORMAT, byval as LPCWSTR) as BOOL
declare function SetDllDirectory alias "SetDllDirectoryW" (byval as LPCWSTR) as BOOL
declare function SetFileShortName alias "SetFileShortNameW" (byval as HANDLE, byval as LPCWSTR) as BOOL
declare function SetFirmwareEnvironmentVariable alias "SetFirmwareEnvironmentVariableW" (byval as LPCWSTR, byval as LPCWSTR, byval as PVOID, byval as DWORD) as BOOL
declare function SetVolumeMountPoint alias "SetVolumeMountPointW" (byval as LPCWSTR, byval as LPCWSTR) as BOOL

#define LOGON_WITH_PROFILE &h00000001
#define LOGON_NETCREDENTIALS_ONLY &h00000002

#else ''UNICODE
type STARTUPINFO as STARTUPINFOA
type LPSTARTUPINFO as STARTUPINFOA ptr
type WIN32_FIND_DATA as WIN32_FIND_DATAA
type LPWIN32_FIND_DATA as WIN32_FIND_DATAA ptr
type HW_PROFILE_INFO as HW_PROFILE_INFOA
type LPHW_PROFILE_INFO as HW_PROFILE_INFOA ptr

declare function AccessCheckAndAuditAlarm alias "AccessCheckAndAuditAlarmA" (byval as LPCSTR, byval as LPVOID, byval as LPSTR, byval as LPSTR, byval as PSECURITY_DESCRIPTOR, byval as DWORD, byval as PGENERIC_MAPPING, byval as BOOL, byval as PDWORD, byval as PBOOL, byval as PBOOL) as BOOL
declare function AddAtom alias "AddAtomA" (byval as LPCSTR) as ATOM
declare function BackupEventLog alias "BackupEventLogA" (byval as HANDLE, byval as LPCSTR) as BOOL
declare function BeginUpdateResource alias "BeginUpdateResourceA" (byval as LPCSTR, byval as BOOL) as HANDLE
declare function BuildCommDCB alias "BuildCommDCBA" (byval as LPCSTR, byval as LPDCB) as BOOL
declare function BuildCommDCBAndTimeouts alias "BuildCommDCBAndTimeoutsA" (byval as LPCSTR, byval as LPDCB, byval as LPCOMMTIMEOUTS) as BOOL
declare function CallNamedPipe alias "CallNamedPipeA" (byval as LPCSTR, byval as PVOID, byval as DWORD, byval as PVOID, byval as DWORD, byval as PDWORD, byval as DWORD) as BOOL
declare function ClearEventLog alias "ClearEventLogA" (byval as HANDLE, byval as LPCSTR) as BOOL
declare function CommConfigDialog alias "CommConfigDialogA" (byval as LPCSTR, byval as HWND, byval as LPCOMMCONFIG) as BOOL
declare function CopyFile alias "CopyFileA" (byval as LPCSTR, byval as LPCSTR, byval as BOOL) as BOOL
declare function CopyFileEx alias "CopyFileExA" (byval as LPCSTR, byval as LPCSTR, byval as LPPROGRESS_ROUTINE, byval as LPVOID, byval as LPBOOL, byval as DWORD) as BOOL
declare function CreateDirectory alias "CreateDirectoryA" (byval as LPCSTR, byval as LPSECURITY_ATTRIBUTES) as BOOL
declare function CreateDirectoryEx alias "CreateDirectoryExA" (byval as LPCSTR, byval as LPCSTR, byval as LPSECURITY_ATTRIBUTES) as BOOL
declare function CreateEvent alias "CreateEventA" (byval as LPSECURITY_ATTRIBUTES, byval as BOOL, byval as BOOL, byval as LPCSTR) as HANDLE
declare function CreateFile alias "CreateFileA" (byval as LPCSTR, byval as DWORD, byval as DWORD, byval as LPSECURITY_ATTRIBUTES, byval as DWORD, byval as DWORD, byval as HANDLE) as HANDLE
declare function CreateFileMapping alias "CreateFileMappingA" (byval as HANDLE, byval as LPSECURITY_ATTRIBUTES, byval as DWORD, byval as DWORD, byval as DWORD, byval as LPCSTR) as HANDLE
declare function CreateMailslot alias "CreateMailslotA" (byval as LPCSTR, byval as DWORD, byval as DWORD, byval as LPSECURITY_ATTRIBUTES) as HANDLE
declare function CreateMutex alias "CreateMutexA" (byval as LPSECURITY_ATTRIBUTES, byval as BOOL, byval as LPCSTR) as HANDLE
declare function CreateNamedPipe alias "CreateNamedPipeA" (byval as LPCSTR, byval as DWORD, byval as DWORD, byval as DWORD, byval as DWORD, byval as DWORD, byval as DWORD, byval as LPSECURITY_ATTRIBUTES) as HANDLE
declare function CreateProcess alias "CreateProcessA" (byval as LPCSTR, byval as LPSTR, byval as LPSECURITY_ATTRIBUTES, byval as LPSECURITY_ATTRIBUTES, byval as BOOL, byval as DWORD, byval as PVOID, byval as LPCSTR, byval as LPSTARTUPINFOA, byval as LPPROCESS_INFORMATION) as BOOL
declare function CreateProcessAsUser alias "CreateProcessAsUserA" (byval as HANDLE, byval as LPCSTR, byval as LPSTR, byval as LPSECURITY_ATTRIBUTES, byval as LPSECURITY_ATTRIBUTES, byval as BOOL, byval as DWORD, byval as PVOID, byval as LPCSTR, byval as LPSTARTUPINFOA, byval as LPPROCESS_INFORMATION) as BOOL
declare function CreateSemaphore alias "CreateSemaphoreA" (byval as LPSECURITY_ATTRIBUTES, byval as LONG, byval as LONG, byval as LPCSTR) as HANDLE
declare function CreateWaitableTimer alias "CreateWaitableTimerA" (byval as LPSECURITY_ATTRIBUTES, byval as BOOL, byval as LPCSTR) as HANDLE
declare function DefineDosDevice alias "DefineDosDeviceA" (byval as DWORD, byval as LPCSTR, byval as LPCSTR) as BOOL
declare function DeleteFile alias "DeleteFileA" (byval as LPCSTR) as BOOL
declare function EncryptFile alias "EncryptFileA" (byval as LPCSTR) as BOOL
declare function EndUpdateResource alias "EndUpdateResourceA" (byval as HANDLE, byval as BOOL) as BOOL
declare function EnumResourceLanguages alias "EnumResourceLanguagesA" (byval as HMODULE, byval as LPCSTR, byval as LPCSTR, byval as ENUMRESLANGPROC, byval as LONG_PTR) as BOOL
declare function EnumResourceNames alias "EnumResourceNamesA" (byval as HMODULE, byval as LPCSTR, byval as ENUMRESNAMEPROC, byval as LONG_PTR) as BOOL
declare function EnumResourceTypes alias "EnumResourceTypesA" (byval as HMODULE, byval as ENUMRESTYPEPROC, byval as LONG_PTR) as BOOL
declare function ExpandEnvironmentStrings alias "ExpandEnvironmentStringsA" (byval as LPCSTR, byval as LPSTR, byval as DWORD) as DWORD
declare sub FatalAppExit alias "FatalAppExitA" (byval as UINT, byval as LPCSTR)
declare function FileEncryptionStatus alias "FileEncryptionStatusA" (byval as LPCSTR, byval as LPDWORD) as BOOL
declare function FindAtom alias "FindAtomA" (byval as LPCSTR) as ATOM
declare function FindFirstChangeNotification alias "FindFirstChangeNotificationA" (byval as LPCSTR, byval as BOOL, byval as DWORD) as HANDLE
declare function FindFirstFile alias "FindFirstFileA" (byval as LPCSTR, byval as LPWIN32_FIND_DATAA) as HANDLE
declare function FindFirstFileEx alias "FindFirstFileExA" (byval as LPCSTR, byval as FINDEX_INFO_LEVELS, byval as PVOID, byval as FINDEX_SEARCH_OPS, byval as PVOID, byval as DWORD) as HANDLE
declare function FindNextFile alias "FindNextFileA" (byval as HANDLE, byval as LPWIN32_FIND_DATAA) as BOOL
declare function FindResource alias "FindResourceA" (byval as HMODULE, byval as LPCSTR, byval as LPCSTR) as HRSRC
declare function FindResourceEx alias "FindResourceExA" (byval as HINSTANCE, byval as LPCSTR, byval as LPCSTR, byval as WORD) as HRSRC
declare function FormatMessage alias "FormatMessageA" (byval as DWORD, byval as PCVOID, byval as DWORD, byval as DWORD, byval as LPSTR, byval as DWORD, byval as any ptr) as DWORD
declare function FreeEnvironmentStrings alias "FreeEnvironmentStringsA" (byval as LPSTR) as BOOL
declare function GetAtomName alias "GetAtomNameA" (byval as ATOM, byval as LPSTR, byval as integer) as UINT
declare function GetBinaryType alias "GetBinaryTypeA" (byval as LPCSTR, byval as PDWORD) as BOOL
declare function GetCommandLine alias "GetCommandLineA" () as LPSTR
declare function GetCompressedFileSize alias "GetCompressedFileSizeA" (byval as LPCSTR, byval as PDWORD) as DWORD
declare function GetComputerName alias "GetComputerNameA" (byval as LPSTR, byval as PDWORD) as BOOL
declare function GetComputerNameEx alias "GetComputerNameExA" (byval as COMPUTER_NAME_FORMAT, byval as LPSTR, byval as LPDWORD) as BOOL
declare function GetCurrentDirectory alias "GetCurrentDirectoryA" (byval as DWORD, byval as LPSTR) as DWORD
declare function GetCurrentHwProfile alias "GetCurrentHwProfileA" (byval as LPHW_PROFILE_INFOA) as BOOL
declare function GetDefaultCommConfig alias "GetDefaultCommConfigA" (byval as LPCSTR, byval as LPCOMMCONFIG, byval as PDWORD) as BOOL
declare function GetDiskFreeSpace alias "GetDiskFreeSpaceA" (byval as LPCSTR, byval as PDWORD, byval as PDWORD, byval as PDWORD, byval as PDWORD) as BOOL
declare function GetDiskFreeSpaceEx alias "GetDiskFreeSpaceExA" (byval as LPCSTR, byval as PULARGE_INTEGER, byval as PULARGE_INTEGER, byval as PULARGE_INTEGER) as BOOL
declare function GetDriveType alias "GetDriveTypeA" (byval as LPCSTR) as UINT
declare function GetEnvironmentStrings alias "GetEnvironmentStringsA" () as LPSTR
declare function GetEnvironmentVariable alias "GetEnvironmentVariableA" (byval as LPCSTR, byval as LPSTR, byval as DWORD) as DWORD
declare function GetFileAttributes alias "GetFileAttributesA" (byval as LPCSTR) as DWORD
declare function GetFileAttributesEx alias "GetFileAttributesExA" (byval as LPCSTR, byval as GET_FILEEX_INFO_LEVELS, byval as PVOID) as BOOL
declare function GetFileSecurity alias "GetFileSecurityA" (byval as LPCSTR, byval as SECURITY_INFORMATION, byval as PSECURITY_DESCRIPTOR, byval as DWORD, byval as PDWORD) as BOOL
declare function GetFullPathName alias "GetFullPathNameA" (byval as LPCSTR, byval as DWORD, byval as LPSTR, byval as LPSTR ptr) as DWORD
declare function GetLogicalDriveStrings alias "GetLogicalDriveStringsA" (byval as DWORD, byval as LPSTR) as DWORD
declare function GetModuleFileName alias "GetModuleFileNameA" (byval as HINSTANCE, byval as LPSTR, byval as DWORD) as DWORD
declare function GetModuleHandle alias "GetModuleHandleA" (byval as LPCSTR) as HMODULE
declare function GetNamedPipeHandleState alias "GetNamedPipeHandleStateA" (byval as HANDLE, byval as PDWORD, byval as PDWORD, byval as PDWORD, byval as PDWORD, byval as LPSTR, byval as DWORD) as BOOL
declare function GetPrivateProfileInt alias "GetPrivateProfileIntA" (byval as LPCSTR, byval as LPCSTR, byval as INT_, byval as LPCSTR) as UINT
declare function GetPrivateProfileSection alias "GetPrivateProfileSectionA" (byval as LPCSTR, byval as LPSTR, byval as DWORD, byval as LPCSTR) as DWORD
declare function GetPrivateProfileSectionNames alias "GetPrivateProfileSectionNamesA" (byval as LPSTR, byval as DWORD, byval as LPCSTR) as DWORD
declare function GetPrivateProfileString alias "GetPrivateProfileStringA" (byval as LPCSTR, byval as LPCSTR, byval as LPCSTR, byval as LPSTR, byval as DWORD, byval as LPCSTR) as DWORD
declare function GetPrivateProfileStruct alias "GetPrivateProfileStructA" (byval as LPCSTR, byval as LPCSTR, byval as LPVOID, byval as UINT, byval as LPCSTR) as BOOL
declare function GetProfileInt alias "GetProfileIntA" (byval as LPCSTR, byval as LPCSTR, byval as INT_) as UINT
declare function GetProfileSection alias "GetProfileSectionA" (byval as LPCSTR, byval as LPSTR, byval as DWORD) as DWORD
declare function GetProfileString alias "GetProfileStringA" (byval as LPCSTR, byval as LPCSTR, byval as LPCSTR, byval as LPSTR, byval as DWORD) as DWORD
declare function GetShortPathName alias "GetShortPathNameA" (byval as LPCSTR, byval as LPSTR, byval as DWORD) as DWORD
declare sub GetStartupInfo alias "GetStartupInfoA" (byval as LPSTARTUPINFOA)
declare function GetSystemDirectory alias "GetSystemDirectoryA" (byval as LPSTR, byval as UINT) as UINT
declare function GetTempFileName alias "GetTempFileNameA" (byval as LPCSTR, byval as LPCSTR, byval as UINT, byval as LPSTR) as UINT
declare function GetTempPath alias "GetTempPathA" (byval as DWORD, byval as LPSTR) as DWORD
declare function GetUserName alias "GetUserNameA" (byval as LPSTR, byval as PDWORD) as BOOL
declare function GetVersionEx alias "GetVersionExA" (byval as LPOSVERSIONINFOA) as BOOL
declare function GetVolumeInformation alias "GetVolumeInformationA" (byval as LPCSTR, byval as LPSTR, byval as DWORD, byval as PDWORD, byval as PDWORD, byval as PDWORD, byval as LPSTR, byval as DWORD) as BOOL
declare function GetWindowsDirectory alias "GetWindowsDirectoryA" (byval as LPSTR, byval as UINT) as UINT
declare function GlobalAddAtom alias "GlobalAddAtomA" (byval as LPCSTR) as ATOM
declare function GlobalFindAtom alias "GlobalFindAtomA" (byval as LPCSTR) as ATOM
declare function GlobalGetAtomName alias "GlobalGetAtomNameA" (byval as ATOM, byval as LPSTR, byval as integer) as UINT
declare function IsBadStringPtr alias "IsBadStringPtrA" (byval as LPCSTR, byval as UINT) as BOOL
declare function LoadLibrary alias "LoadLibraryA" (byval as LPCSTR) as HINSTANCE
declare function LoadLibraryEx alias "LoadLibraryExA" (byval as LPCSTR, byval as HANDLE, byval as DWORD) as HINSTANCE
declare function LogonUser alias "LogonUserA" (byval as LPSTR, byval as LPSTR, byval as LPSTR, byval as DWORD, byval as DWORD, byval as PHANDLE) as BOOL
declare function LookupAccountName alias "LookupAccountNameA" (byval as LPCSTR, byval as LPCSTR, byval as PSID, byval as PDWORD, byval as LPSTR, byval as PDWORD, byval as PSID_NAME_USE) as BOOL
declare function LookupAccountSid alias "LookupAccountSidA" (byval as LPCSTR, byval as PSID, byval as LPSTR, byval as PDWORD, byval as LPSTR, byval as PDWORD, byval as PSID_NAME_USE) as BOOL
declare function LookupPrivilegeDisplayName alias "LookupPrivilegeDisplayNameA" (byval as LPCSTR, byval as LPCSTR, byval as LPSTR, byval as PDWORD, byval as PDWORD) as BOOL
declare function LookupPrivilegeName alias "LookupPrivilegeNameA" (byval as LPCSTR, byval as PLUID, byval as LPSTR, byval as PDWORD) as BOOL
declare function LookupPrivilegeValue alias "LookupPrivilegeValueA" (byval as LPCSTR, byval as LPCSTR, byval as PLUID) as BOOL
declare function lstrcat alias "lstrcatA" (byval as LPSTR, byval as LPCSTR) as LPSTR
declare function lstrcmp alias "lstrcmpA" (byval as LPCSTR, byval as LPCSTR) as integer
declare function lstrcmpi alias "lstrcmpiA" (byval as LPCSTR, byval as LPCSTR) as integer
declare function lstrcpy alias "lstrcpyA" (byval as LPSTR, byval as LPCSTR) as LPSTR
declare function lstrcpyn alias "lstrcpynA" (byval as LPSTR, byval as LPCSTR, byval as integer) as LPSTR
declare function lstrlen alias "lstrlenA" (byval as LPCSTR) as integer
declare function MoveFile alias "MoveFileA" (byval as LPCSTR, byval as LPCSTR) as BOOL
declare function MoveFileEx alias "MoveFileExA" (byval as LPCSTR, byval as LPCSTR, byval as DWORD) as BOOL
declare function ObjectCloseAuditAlarm alias "ObjectCloseAuditAlarmA" (byval as LPCSTR, byval as PVOID, byval as BOOL) as BOOL
declare function ObjectDeleteAuditAlarm alias "ObjectDeleteAuditAlarmA" (byval as LPCSTR, byval as PVOID, byval as BOOL) as BOOL
declare function ObjectOpenAuditAlarm alias "ObjectOpenAuditAlarmA" (byval as LPCSTR, byval as PVOID, byval as LPSTR, byval as LPSTR, byval as PSECURITY_DESCRIPTOR, byval as HANDLE, byval as DWORD, byval as DWORD, byval as PPRIVILEGE_SET, byval as BOOL, byval as BOOL, byval as PBOOL) as BOOL
declare function ObjectPrivilegeAuditAlarm alias "ObjectPrivilegeAuditAlarmA" (byval as LPCSTR, byval as PVOID, byval as HANDLE, byval as DWORD, byval as PPRIVILEGE_SET, byval as BOOL) as BOOL
declare function OpenBackupEventLog alias "OpenBackupEventLogA" (byval as LPCSTR, byval as LPCSTR) as HANDLE
declare function OpenEvent alias "OpenEventA" (byval as DWORD, byval as BOOL, byval as LPCSTR) as HANDLE
declare function OpenEventLog alias "OpenEventLogA" (byval as LPCSTR, byval as LPCSTR) as HANDLE
declare function OpenFileMapping alias "OpenFileMappingA" (byval as DWORD, byval as BOOL, byval as LPCSTR) as HANDLE
declare function OpenMutex alias "OpenMutexA" (byval as DWORD, byval as BOOL, byval as LPCSTR) as HANDLE
declare function OpenSemaphore alias "OpenSemaphoreA" (byval as DWORD, byval as BOOL, byval as LPCSTR) as HANDLE
declare function OpenWaitableTimer alias "OpenWaitableTimerA" (byval as DWORD, byval as BOOL, byval as LPCSTR) as HANDLE
declare sub OutputDebugString alias "OutputDebugStringA" (byval as LPCSTR)
declare function PrivilegedServiceAuditAlarm alias "PrivilegedServiceAuditAlarmA" (byval as LPCSTR, byval as LPCSTR, byval as HANDLE, byval as PPRIVILEGE_SET, byval as BOOL) as BOOL
declare function QueryDosDevice alias "QueryDosDeviceA" (byval as LPCSTR, byval as LPSTR, byval as DWORD) as DWORD
declare function ReadEventLog alias "ReadEventLogA" (byval as HANDLE, byval as DWORD, byval as DWORD, byval as PVOID, byval as DWORD, byval as DWORD ptr, byval as DWORD ptr) as BOOL
declare function RegisterEventSource alias "RegisterEventSourceA" (byval as LPCSTR, byval as LPCSTR) as HANDLE
declare function RemoveDirectory alias "RemoveDirectoryA" (byval as LPCSTR) as BOOL
declare function ReportEvent alias "ReportEventA" (byval as HANDLE, byval as WORD, byval as WORD, byval as DWORD, byval as PSID, byval as WORD, byval as DWORD, byval as LPCSTR ptr, byval as PVOID) as BOOL
declare function SearchPath alias "SearchPathA" (byval as LPCSTR, byval as LPCSTR, byval as LPCSTR, byval as DWORD, byval as LPSTR, byval as LPSTR ptr) as DWORD
declare function SetComputerName alias "SetComputerNameA" (byval as LPCSTR) as BOOL
declare function SetCurrentDirectory alias "SetCurrentDirectoryA" (byval as LPCSTR) as BOOL
declare function SetDefaultCommConfig alias "SetDefaultCommConfigA" (byval as LPCSTR, byval as LPCOMMCONFIG, byval as DWORD) as BOOL
declare function SetEnvironmentVariable alias "SetEnvironmentVariableA" (byval as LPCSTR, byval as LPCSTR) as BOOL
declare function SetFileAttributes alias "SetFileAttributesA" (byval as LPCSTR, byval as DWORD) as BOOL
declare function SetFileSecurity alias "SetFileSecurityA" (byval as LPCSTR, byval as SECURITY_INFORMATION, byval as PSECURITY_DESCRIPTOR) as BOOL
declare function SetVolumeLabel alias "SetVolumeLabelA" (byval as LPCSTR, byval as LPCSTR) as BOOL
declare function UpdateResource alias "UpdateResourceA" (byval as HANDLE, byval as LPCSTR, byval as LPCSTR, byval as WORD, byval as PVOID, byval as DWORD) as BOOL
declare function VerifyVersionInfo alias "VerifyVersionInfoA" (byval as LPOSVERSIONINFOEXA, byval as DWORD, byval as DWORDLONG) as BOOL
declare function WaitNamedPipe alias "WaitNamedPipeA" (byval as LPCSTR, byval as DWORD) as BOOL
declare function WritePrivateProfileSection alias "WritePrivateProfileSectionA" (byval as LPCSTR, byval as LPCSTR, byval as LPCSTR) as BOOL
declare function WritePrivateProfileString alias "WritePrivateProfileStringA" (byval as LPCSTR, byval as LPCSTR, byval as LPCSTR, byval as LPCSTR) as BOOL
declare function WritePrivateProfileStruct alias "WritePrivateProfileStructA" (byval as LPCSTR, byval as LPCSTR, byval as LPVOID, byval as UINT, byval as LPCSTR) as BOOL
declare function WriteProfileSection alias "WriteProfileSectionA" (byval as LPCSTR, byval as LPCSTR) as BOOL
declare function WriteProfileString alias "WriteProfileStringA" (byval as LPCSTR, byval as LPCSTR, byval as LPCSTR) as BOOL
declare function CreateActCtx alias "CreateActCtxA" (byval as PCACTCTXA) as HANDLE
declare function CreateHardLink alias "CreateHardLinkA" (byval as LPCSTR, byval as LPCSTR, byval as LPSECURITY_ATTRIBUTES) as BOOL
declare function CreateJobObject alias "CreateJobObjectA" (byval as LPSECURITY_ATTRIBUTES, byval as LPCSTR) as HANDLE
declare function DeleteVolumeMountPoint alias "DeleteVolumeMountPointA" (byval as LPCSTR) as BOOL
declare function DnsHostnameToComputerName alias "DnsHostnameToComputerNameA" (byval as LPCSTR, byval as LPSTR, byval as LPDWORD) as BOOL
declare function FindActCtxSectionString alias "FindActCtxSectionStringA" (byval as DWORD, byval as GUID ptr, byval as ULONG, byval as LPCSTR, byval as PACTCTX_SECTION_KEYED_DATA) as BOOL
declare function FindNextVolume alias "FindNextVolumeA" (byval as HANDLE, byval as LPCSTR, byval as DWORD) as BOOL
declare function FindNextVolumeMountPoint alias "FindNextVolumeMountPointA" (byval as HANDLE, byval as LPSTR, byval as DWORD) as BOOL
declare function GetFirmwareEnvironmentVariable alias "GetFirmwareEnvironmentVariableA" (byval as LPCSTR, byval as LPCSTR, byval as PVOID, byval as DWORD) as DWORD
declare function GetDllDirectory alias "GetDllDirectoryA" (byval as DWORD, byval as LPSTR) as DWORD
declare function GetLongPathName alias "GetLongPathNameA" (byval as LPCSTR, byval as LPSTR, byval as DWORD) as DWORD
declare function GetModuleHandleEx alias "GetModuleHandleExA" (byval as DWORD, byval as LPCSTR, byval as HMODULE ptr) as BOOL
declare function GetSystemWow64Directory alias "GetSystemWow64DirectoryA" (byval as LPSTR, byval as UINT) as UINT
declare function GetVolumeNameForVolumeMountPoint alias "GetVolumeNameForVolumeMountPointA" (byval as LPCSTR, byval as LPSTR, byval as DWORD) as BOOL
declare function GetVolumePathName alias "GetVolumePathNameA" (byval as LPCSTR, byval as LPSTR, byval as DWORD) as BOOL
declare function GetVolumePathNamesForVolumeName alias "GetVolumePathNamesForVolumeNameA" (byval as LPCSTR, byval as LPSTR, byval as DWORD, byval as PDWORD) as BOOL
declare function SetComputerNameEx alias "SetComputerNameExA" (byval as COMPUTER_NAME_FORMAT, byval as LPCSTR) as BOOL
declare function SetDllDirectory alias "SetDllDirectoryA" (byval as LPCSTR) as BOOL
declare function SetFileShortName alias "SetFileShortNameA" (byval as HANDLE, byval as LPCSTR) as BOOL
declare function SetFirmwareEnvironmentVariable alias "SetFirmwareEnvironmentVariableA" (byval as LPCSTR, byval as LPCSTR, byval as PVOID, byval as DWORD) as BOOL
declare function SetVolumeMountPoint alias "SetVolumeMountPointA" (byval as LPCSTR, byval as LPCSTR) as BOOL

#endif ''UNICODE

declare function RtlMoveMemory cdecl alias "memmove" (byval as any ptr, byval as any ptr, byval as integer) as any ptr
declare function RtlCopyMemory cdecl alias "memcpy" (byval as any ptr, byval as any ptr, byval as integer) as any ptr
declare function RtlFillMemory cdecl alias "memset" (byval as any ptr, byval as integer, byval as integer) as any ptr

#define RtlZeroMemory(d,l) RtlFillMemory((d),(l),0)
#define MoveMemory RtlMoveMemory
#define CopyMemory RtlCopyMemory
#define FillMemory RtlFillMemory
#define ZeroMemory RtlZeroMemory

end extern

#endif
