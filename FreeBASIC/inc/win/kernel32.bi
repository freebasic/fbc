#ifndef KERNEL32_BI
#define KERNEL32_BI
'-----------
'KERNEL32.BI
'-----------
'
'This header defines every obtainable user32 Function and related data types and structures.

'VERSION: 1.01

'Changelog:
'  1.01: INT64 moved to winbase.bi and renamed to the original name: LARGE_INTEGER, as shown by the Platform Api docs
'        A few previously disabled functions were enabled and Type MEMORY_BASIC_INFORMATION was added.
'        Resource Types moved to user32.bi

'This inclusion was originally built from fsw's kernel32_new.bi file.

'$include once: "win\winbase.bi"

'----------------------
'| REQUIRED CONSTANTS |
'----------------------

Const DELETE       			= &H10000
Const READ_CONTROL 			= &H20000
Const WRITE_DAC    			= &H40000
Const WRITE_OWNER  			= &H80000
Const SYNCHRONIZE  			= &H100000

Const STANDARD_RIGHTS_READ     		= &H20000
Const STANDARD_RIGHTS_WRITE    		= &H20000
Const STANDARD_RIGHTS_EXECUTE  		= &H20000
Const STANDARD_RIGHTS_REQUIRED 		= &HF0000
Const STANDARD_RIGHTS_ALL      		= &H1F0000

Const SPECIFIC_RIGHTS_ALL      		= &HFFFF

'FILE_READ_DATA and FILE_WRITE_DATA constants

Const FILE_READ_DATA      		= &H1           '  file pipe
Const FILE_LIST_DIRECTORY 		= &H1           '  directory

Const FILE_WRITE_DATA 			= &H2           '  file pipe
Const FILE_ADD_FILE   			= &H2           '  directory

Const FILE_APPEND_DATA          	= &H4           '  file
Const FILE_ADD_SUBDIRECTORY     	= &H4           '  directory
Const FILE_CREATE_PIPE_INSTANCE 	= &H4           '  named pipe

Const FILE_READ_EA         		= &H8           '  file directory
Const FILE_READ_PROPERTIES 		= &H8

Const FILE_WRITE_EA         		= &H10          '  file directory
Const FILE_WRITE_PROPERTIES 		= &H10

Const FILE_EXECUTE  			= &H20          '  file
Const FILE_TRAVERSE 			= &H20          '  directory

Const FILE_DELETE_CHILD 		= &H40          '  directory

Const FILE_READ_ATTRIBUTES  		= &H80          '  all
Const FILE_WRITE_ATTRIBUTES 		= &H100         '  all

Const FILE_ALL_ACCESS      		= &H1F01FF      ' (STANDARD_RIGHTS_REQUIRED Or SYNCHRONIZE Or &H1FF)
Const FILE_GENERIC_READ    		= &H120089      ' (STANDARD_RIGHTS_READ Or FILE_READ_DATA Or FILE_READ_ATTRIBUTES Or FILE_READ_EA Or SYNCHRONIZE)
Const FILE_GENERIC_WRITE   		= &H120116      ' (STANDARD_RIGHTS_WRITE Or FILE_WRITE_DATA Or FILE_WRITE_ATTRIBUTES Or FILE_WRITE_EA Or FILE_APPEND_DATA Or SYNCHRONIZE)
Const FILE_GENERIC_EXECUTE 		= &H1200A0	' (STANDARD_RIGHTS_EXECUTE Or FILE_READ_ATTRIBUTES Or FILE_EXECUTE Or SYNCHRONIZE)

Const FILE_SHARE_NONE           	= &H0
Const FILE_SHARE_READ               	= &H1
Const FILE_SHARE_WRITE              	= &H2

Const FILE_ATTRIBUTE_READONLY       	= &H1
Const FILE_ATTRIBUTE_HIDDEN         	= &H2
Const FILE_ATTRIBUTE_SYSTEM         	= &H4
Const FILE_ATTRIBUTE_DIRECTORY      	= &H10
Const FILE_ATTRIBUTE_ARCHIVE        	= &H20
Const FILE_ATTRIBUTE_NORMAL         	= &H80
Const FILE_ATTRIBUTE_TEMPORARY      	= &H100
Const FILE_ATTRIBUTE_ATOMIC_WRITE   	= &H200
Const FILE_ATTRIBUTE_XACTION_WRITE  	= &H400
Const FILE_ATTRIBUTE_COMPRESSED     	= &H800

Const FILE_NOTIFY_CHANGE_FILE_NAME  	= &H1
Const FILE_NOTIFY_CHANGE_DIR_NAME   	= &H2
Const FILE_NOTIFY_CHANGE_ATTRIBUTES 	= &H4
Const FILE_NOTIFY_CHANGE_SIZE       	= &H8
Const FILE_NOTIFY_CHANGE_LAST_WRITE 	= &H10
Const FILE_NOTIFY_CHANGE_SECURITY   	= &H100

Const MAILSLOT_NO_MESSAGE           	= (-1)
Const MAILSLOT_WAIT_FOREVER         	= (-1)

Const FILE_CASE_SENSITIVE_SEARCH    	= &H1
Const FILE_CASE_PRESERVED_NAMES     	= &H2
Const FILE_UNICODE_ON_DISK          	= &H4
Const FILE_PERSISTENT_ACLS          	= &H8
Const FILE_FILE_COMPRESSION         	= &H10
Const FILE_VOLUME_IS_COMPRESSED     	= &H8000

Const IO_COMPLETION_MODIFY_STATE    	= &H2
Const IO_COMPLETION_ALL_ACCESS      	= &H1F0003	' (STANDARD_RIGHTS_REQUIRED Or SYNCHRONIZE Or &H3)

Const DUPLICATE_CLOSE_SOURCE        	= &H1
Const DUPLICATE_SAME_ACCESS         	= &H2

'  Access Rights

'  AccessSystemAcl access Type

Const ACCESS_SYSTEM_SECURITY 		= &H1000000

'  MaximumAllowed access Type

Const MAXIMUM_ALLOWED 			= &H2000000

'  These are the generic rights

Const GENERIC_READ    			= &H80000000
Const GENERIC_WRITE   			= &H40000000
Const GENERIC_EXECUTE 			= &H20000000
Const GENERIC_ALL     			= &H10000000

Const FILE_BEGIN   			= 0
Const FILE_CURRENT 			= 1
Const FILE_End     			= 2

Const FILE_FLAG_WRITE_THROUGH    	= &H80000000
Const FILE_FLAG_OVERLAPPED       	= &H40000000
Const FILE_FLAG_NO_BUFFERING     	= &H20000000
Const FILE_FLAG_RANDOM_ACCESS    	= &H10000000
Const FILE_FLAG_SEQUENTIAL_SCAN  	= &H08000000
Const FILE_FLAG_DELETE_ON_CLOSE  	= &H04000000
Const FILE_FLAG_BACKUP_SEMANTICS 	= &H02000000
Const FILE_FLAG_POSIX_SEMANTICS  	= &H01000000

Const CREATE_NEW        		= 1
Const CREATE_ALWAYS     		= 2
Const OPEN_EXISTING     		= 3
Const OPEN_ALWAYS       		= 4
Const TRUNCATE_EXISTING 		= 5

'  Define the dwOpenMode values for CreateNamedPipe

Const PIPE_ACCESS_INBOUND  		= &H1
Const PIPE_ACCESS_OUTBOUND 		= &H2
Const PIPE_ACCESS_DUPLEX   		= &H3

' Define the Named Pipe End flags for GetNamedPipeInfo

Const PIPE_CLIENT_End 			= &H0
Const PIPE_SERVER_End 			= &H1

' Define the dwPipeMode values for CreateNamedPipe

Const PIPE_WAIT             		= &H0
Const PIPE_NOWAIT           		= &H1
Const PIPE_READMODE_BYTE    		= &H0
Const PIPE_READMODE_MESSAGE 		= &H2
Const PIPE_Type_BYTE        		= &H0
Const PIPE_Type_MESSAGE     		= &H4

' Define the well known values for CreateNamedPipe nMaxInstances

Const PIPE_UNLIMITED_INSTANCES 		= 255

' Define the Security Quality of Service bits to be passed into CreateFile

Const SECURITY_ANONYMOUS             	= &H0
Const SECURITY_IDENTIFICATION        	= &H10000
Const SECURITY_IMPERSONATION         	= &H20000
Const SECURITY_DELEGATION            	= &H30000
Const SECURITY_CONTEXT_TRACKING      	= &H40000
Const SECURITY_EFFECTIVE             	= &H80000
Const SECURITY_EFFECTIVE_ONLY        	= &H80000

Const SECURITY_SQOS_PRESENT          	= &H100000
Const SECURITY_VALID_SQOS_FLAGS      	= &H1F0000

'  Code Page Default Values

Const CP_ACP   				= 0       	'  default to ANSI code page
Const CP_OEMCP 				= 1             '  default to OEM  code page

Const DRIVE_UNKNOWN	  		= 0
Const DRIVE_NO_ROOT_DIR   		= 1
Const DRIVE_REMOVABLE	  		= 2
Const DRIVE_FIXED	  		= 3
Const DRIVE_REMOTE	  		= 4
Const DRIVE_CDROM	  		= 5
Const DRIVE_RAMDISK	  		= 6

' Global Memory Flags

Const GMEM_FIXED                        = &H0
Const GMEM_MOVEABLE                     = &H2
Const GMEM_NOCOMPACT                    = &H10
Const GMEM_NODISCARD                    = &H20
Const GMEM_ZEROINIT                     = &H40
Const GMEM_MODIFY                       = &H80
Const GMEM_DISCARDABLE                  = &H100
Const GMEM_NOT_BANKED                   = &H1000
Const GMEM_SHARE                        = &H2000
Const GMEM_DDESHARE                     = &H2000
Const GMEM_NOTIFY                       = &H4000
Const GMEM_LOWER                        = &H1000
Const GMEM_VALID_FLAGS                  = &H7F72
Const GMEM_INVALID_HANDLE               = &H8000

Const GHND 				= &H42		'  (GMEM_MOVEABLE Or GMEM_ZEROINIT)
Const GPTR 				= &H40		'  (GMEM_FIXED Or GMEM_ZEROINIT)

' Flags returned by GlobalFlags (in addition to GMEM_DISCARDABLE)

Const GMEM_DISCARDED 			= &H4000
Const GMEM_LOCKCOUNT 			= &HFF

'  Local Memory Flags

Const LMEM_FIXED          		= &H0
Const LMEM_MOVEABLE       		= &H2
Const LMEM_NOCOMPACT      		= &H10
Const LMEM_NODISCARD      		= &H20
Const LMEM_ZEROINIT       		= &H40
Const LMEM_MODIFY         		= &H80
Const LMEM_DISCARDABLE    		= &HF00
Const LMEM_VALID_FLAGS    		= &HF72
Const LMEM_INVALID_HANDLE 		= &H8000

Const LHND 				= 66		'  (LMEM_MOVEABLE + LMEM_ZEROINIT)
Const LPTR 				= 64		'  (LMEM_FIXED + LMEM_ZEROINIT)

Const NONZEROLHND 			= &H2
Const NONZEROLPTR 			= &H0

' Flags returned by LocalFlags (in addition to LMEM_DISCARDABLE)

Const LMEM_DISCARDED 			= &H4000
Const LMEM_LOCKCOUNT 			= &HFF

'  dwCreationFlag values

Const DEBUG_PROCESS 			= &H1
Const DEBUG_ONLY_THIS_PROCESS 		= &H2

Const CREATE_SUSPENDED 			= &H4
Const DETACHED_PROCESS 			= &H8
Const CREATE_NEW_CONSOLE 		= &H10

Const NORMAL_PRIORITY_CLASS 		= &H20
Const IDLE_PRIORITY_CLASS 		= &H40
Const HIGH_PRIORITY_CLASS 		= &H80
Const REALTIME_PRIORITY_CLASS 		= &H100

Const CREATE_NEW_PROCESS_GROUP 		= &H200
Const CREATE_NO_WINDOW 			= &H8000000

Const STARTF_USESHOWWINDOW 		= &H1
Const STARTF_USESIZE 			= &H2
Const STARTF_USEPOSITION 		= &H4
Const STARTF_USECOUNTCHARS 		= &H8
Const STARTF_USEFILLATTRIBUTE 		= &H10
Const STARTF_RUNFULLSCREEN 		= &H20        '  ignored for non-x86 platforms
Const STARTF_FORCEONFEEDBACK 		= &H40
Const STARTF_FORCEOFFFEEDBACK 		= &H80
Const STARTF_USESTDHANDLES 		= &H100

Const PROFILE_USER 			= &H10000000
Const PROFILE_KERNEL 			= &H20000000
Const PROFILE_SERVER 			= &H40000000

Const MAlong 				= &H7FFFFFFF
Const THREAD_BASE_PRIORITY_MIN 		= (-2)
Const THREAD_BASE_PRIORITY_MAX 		= 2
Const THREAD_BASE_PRIORITY_LOWRT 	= 15
Const THREAD_BASE_PRIORITY_IDLE 	= (-15)
Const THREAD_PRIORITY_LOWEST 		= (-2)
Const THREAD_PRIORITY_BELOW_NORMAL 	= (-1)
Const THREAD_PRIORITY_NORMAL 		= 0
Const THREAD_PRIORITY_HIGHEST 		= 2
Const THREAD_PRIORITY_ABOVE_NORMAL 	= 1
Const THREAD_PRIORITY_ERROR_RETURN 	= &H7FFFFFFF

Const THREAD_PRIORITY_TIME_CRITICAL 	= 15
Const THREAD_PRIORITY_IDLE 		= (-15)

'  DllMain reason flags

Const DLL_PROCESS_DETACH  		= 0
Const DLL_PROCESS_ATTACH  		= 1
Const DLL_THREAD_ATTACH   		= 2
Const DLL_THREAD_DETACH   		= 3

'  standard io handles

Const STD_ERR_HANDLE    		= (-12)
Const STD_ERROR_HANDLE  		= (-12)
Const STD_OUTPUT_HANDLE 		= (-11)
Const STD_INPUT_HANDLE  		= (-10)

Const INVALID_HANDLE_VALUE 		= (-1)

Const FORMAT_MESSAGE_ALLOCATE_BUFFER 	= &H100
Const FORMAT_MESSAGE_IGNORE_INSERTS  	= &H200
Const FORMAT_MESSAGE_FROM_STRING     	= &H400
Const FORMAT_MESSAGE_FROM_HMODULE    	= &H800
Const FORMAT_MESSAGE_FROM_SYSTEM     	= &H1000
Const FORMAT_MESSAGE_ARGUMENT_ARRAY  	= &H2000
Const FORMAT_MESSAGE_MAX_WIDTH_MASK  	= &HFF

'  dwPlatformId defines

Const VER_PLATFORM_WIN32s 		= 0
Const VER_PLATFORM_WIN32_WINDOWS 	= 1
Const VER_PLATFORM_WIN32_NT 		= 2

'  Serial provider Type

Const SP_SERIALCOMM 			= &H1

'  Provider SubTypes

Const PST_UNSPECIFIED 			= &H0
Const PST_RS232 			= &H1
Const PST_PARALLELPORT 			= &H2
Const PST_RS422 			= &H3
Const PST_RS423 			= &H4
Const PST_RS449 			= &H5
Const PST_FAX 				= &H21
Const PST_SCANNER 			= &H22
Const PST_NETWORK_BRIDGE 		= &H100
Const PST_LAT 				= &H101
Const PST_TCPIP_TELNET 			= &H102
Const PST_X25 				= &H103

'  Provider capabilities flags

Const PCF_DTRDSR 			= &H1
Const PCF_RTSCTS 			= &H2
Const PCF_RLSD 				= &H4
Const PCF_PARITY_CHECK 			= &H8
Const PCF_XONXOFF 			= &H10
Const PCF_SETXCHAR 			= &H20
Const PCF_TOTALTIMEOUTS 		= &H40
Const PCF_INTTIMEOUTS 			= &H80
Const PCF_SPECIALCHARS 			= &H100
Const PCF_16BITMODE 			= &H200

'  Comm provider settable parameters

Const SP_PARITY 			= &H1
Const SP_BAUD 				= &H2
Const SP_DATABITS 			= &H4
Const SP_STOPBITS 			= &H8
Const SP_HANDSHAKING 			= &H10
Const SP_PARITY_CHECK 			= &H20
Const SP_RLSD 				= &H40

'  Settable baud rates in the provider

Const BAUD_075 				= &H1
Const BAUD_110 				= &H2
Const BAUD_134_5 			= &H4
Const BAUD_150 				= &H8
Const BAUD_300 				= &H10
Const BAUD_600 				= &H20
Const BAUD_1200 			= &H40
Const BAUD_1800 			= &H80
Const BAUD_2400 			= &H100
Const BAUD_4800 			= &H200
Const BAUD_7200 			= &H400
Const BAUD_9600 			= &H800
Const BAUD_14400 			= &H1000
Const BAUD_19200 			= &H2000
Const BAUD_38400 			= &H4000
Const BAUD_56K 				= &H8000
Const BAUD_128K 			= &H10000
Const BAUD_115200 			= &H20000
Const BAUD_57600 			= &H40000
Const BAUD_USER 			= &H10000000

'  Settable Data Bits

Const DATABITS_5 			= &H1
Const DATABITS_6 			= &H2
Const DATABITS_7 			= &H4
Const DATABITS_8 			= &H8
Const DATABITS_16 			= &H10
Const DATABITS_16X 			= &H20

'  Settable Stop and Parity bits.

Const STOPBITS_10 			= &H1
Const STOPBITS_15 			= &H2
Const STOPBITS_20 			= &H4
Const PARITY_NONE 			= &H100
Const PARITY_ODD 			= &H200
Const PARITY_EVEN 			= &H400
Const PARITY_MARK 			= &H800
Const PARITY_SPACE 			= &H1000

Const NOPARITY 				= 0
Const ODDPARITY 			= 1
Const EVENPARITY 			= 2
Const MARKPARITY 			= 3
Const SPACEPARITY 			= 4

Const ONESTOPBIT 			= 0
Const ONE5STOPBITS 			= 1
Const TWOSTOPBITS 			= 2

Const IGNORE 				= 0 		'  Ignore signal
Const INFINITE 				= &HFFFFFFFF  	'  Infinite timeout

'  Comm Baud Rate indices

Const CBR_110 				= 110
Const CBR_300 				= 300
Const CBR_600 				= 600
Const CBR_1200 				= 1200
Const CBR_2400 				= 2400
Const CBR_4800 				= 4800
Const CBR_9600 				= 9600
Const CBR_14400 			= 14400
Const CBR_19200 			= 19200
Const CBR_38400 			= 38400
Const CBR_56000 			= 56000
Const CBR_57600 			= 57600
Const CBR_115200 			= 115200
Const CBR_128000 			= 128000
Const CBR_256000 			= 256000

'  DTR Control Flow Values.

Const DTR_CONTROL_DISABLE 		= &H0
Const DTR_CONTROL_ENABLE 		= &H1
Const DTR_CONTROL_HANDSHAKE 		= &H2

'  RTS Control Flow Values

Const RTS_CONTROL_DISABLE 		= &H0
Const RTS_CONTROL_ENABLE 		= &H1
Const RTS_CONTROL_HANDSHAKE 		= &H2
Const RTS_CONTROL_TOGGLE 		= &H3

'  Escape Functions

Const SETXOFF 				= 1  		'  Simulate XOFF received
Const SETXON 				= 2 		'  Simulate XON received
Const SETRTS 				= 3 		'  Set RTS high
Const CLRRTS 				= 4 		'  Set RTS low
Const SETDTR 				= 5 		'  Set DTR high
Const CLRDTR 				= 6 		'  Set DTR low
Const RESETDEV 				= 7       	'  Reset device if possible
Const SETBREAK 				= 8  		'  Set the device break line
Const CLRBREAK 				= 9 		'  Clear the device break line

'  PURGE function flags.	

Const PURGE_TXABORT 			= &H1     	'  Kill the pending/current writes to the comm port.
Const PURGE_RXABORT 			= &H2     	'  Kill the pending/current reads to the comm port.
Const PURGE_TXCLEAR 			= &H4     	'  Kill the transmit queue if there.
Const PURGE_RXCLEAR 			= &H8     	'  Kill the Typeahead buffer if there.

'  Locale Types.
'  These Types are used for the GetLocaleInfoW NLS API routine.

Const LOCALE_SYSTEM_DEFAULT 		= &H800
Const LOCALE_USER_DEFAULT 		= &H400

'  LOCALE_NOUSEROVERRIDE is also used in GetTimeFormatW and GetDateFormatW.

Const LOCALE_NOUSEROVERRIDE 		= &H80000000  	'  do not use user overrides

Const LOCALE_ILANGUAGE 			= &H1         	'  language id
Const LOCALE_SLANGUAGE 			= &H2         	'  localized name of language
Const LOCALE_SENGLANGUAGE 		= &H1001      	'  English name of language
Const LOCALE_SABBREVLANGNAME 		= &H3         	'  abbreviated language name
Const LOCALE_SNATIVELANGNAME 		= &H4         	'  native name of language
Const LOCALE_ICOUNTRY 			= &H5         	'  country code
Const LOCALE_SCOUNTRY 			= &H6         	'  localized name of country
Const LOCALE_SENGCOUNTRY 		= &H1002      	'  English name of country
Const LOCALE_SABBREVCTRYNAME 		= &H7         	'  abbreviated country name
Const LOCALE_SNATIVECTRYNAME 		= &H8         	'  native name of country
Const LOCALE_IDEFAULTLANGUAGE 		= &H9         	'  default language id
Const LOCALE_IDEFAULTCOUNTRY 		= &HA         	'  default country code
Const LOCALE_IDEFAULTCODEPAGE 		= &HB         	'  default code page

Const LOCALE_SLIST 			= &HC         	'  list item separator
Const LOCALE_IMEASURE 			= &HD         	'  0 = metric, 1 = US

Const LOCALE_SDECIMAL 			= &HE         	'  decimal separator
Const LOCALE_STHOUSAND 			= &HF         	'  thousand separator
Const LOCALE_SGROUPING 			= &H10        	'  digit grouping
Const LOCALE_IDIGITS 			= &H11       	'  number of fractional digits
Const LOCALE_ILZERO 			= &H12        	'  leading zeros for decimal
Const LOCALE_SNATIVEDIGITS 		= &H13        	'  native ascii 0-9

Const LOCALE_SCURRENCY 			= &H14        	'  local monetary symbol
Const LOCALE_SINTLSYMBOL 		= &H15        	'  intl monetary symbol
Const LOCALE_SMONDECIMALSEP 		= &H16        	'  monetary decimal separator
Const LOCALE_SMONTHOUSANDSEP 		= &H17        	'  monetary thousand separator
Const LOCALE_SMONGROUPING 		= &H18        	'  monetary grouping
Const LOCALE_ICURRDIGITS 		= &H19        	'  * local monetary digits
Const LOCALE_IINTLCURRDIGITS 		= &H1A        	'  * intl monetary digits
Const LOCALE_ICURRENCY 			= &H1B        	'  positive currency mode
Const LOCALE_INEGCURR 			= &H1C        	'  negative currency mode

Const LOCALE_SDATE 			= &H1D        	'  date separator
Const LOCALE_STIME 			= &H1E        	'  time separator
Const LOCALE_SSHORTDATE 		= &H1F        	'  short date format string
Const LOCALE_integerDATE		= &H20        	'  long date format string
Const LOCALE_STIMEFORMAT 		= &H1003      	'  time format string
Const LOCALE_IDATE 			= &H21        	'  short date format ordering
Const LOCALE_ILDATE 			= &H22        	'  long date format ordering
Const LOCALE_ITIME 			= &H23        	'  time format specifier
Const LOCALE_ICENTURY 			= &H24        	'  century format specifier
Const LOCALE_ITLZERO 			= &H25        	'  leading zeros in time field
Const LOCALE_IDAYLZERO 			= &H26        	'  leading zeros in day field
Const LOCALE_IMONLZERO 			= &H27        	'  leading zeros in month field
Const LOCALE_S1159 			= &H28        	'  AM designator
Const LOCALE_S2359 			= &H29        	'  PM designator

Const LOCALE_SDAYNAME1 			= &H2A        	'  long name for Monday
Const LOCALE_SDAYNAME2 			= &H2B        	'  long name for Tuesday
Const LOCALE_SDAYNAME3 			= &H2C        	'  long name for Wednesday
Const LOCALE_SDAYNAME4 			= &H2D        	'  long name for Thursday
Const LOCALE_SDAYNAME5 			= &H2E        	'  long name for Friday
Const LOCALE_SDAYNAME6 			= &H2F        	'  long name for Saturday
Const LOCALE_SDAYNAME7 			= &H30        	'  long name for Sunday
Const LOCALE_SABBREVDAYNAME1 		= &H31        	'  abbreviated name for Monday
Const LOCALE_SABBREVDAYNAME2 		= &H32        	'  abbreviated name for Tuesday
Const LOCALE_SABBREVDAYNAME3 		= &H33        	'  abbreviated name for Wednesday
Const LOCALE_SABBREVDAYNAME4 		= &H34        	'  abbreviated name for Thursday
Const LOCALE_SABBREVDAYNAME5 		= &H35        	'  abbreviated name for Friday
Const LOCALE_SABBREVDAYNAME6 		= &H36        	'  abbreviated name for Saturday
Const LOCALE_SABBREVDAYNAME7 		= &H37        	'  abbreviated name for Sunday
Const LOCALE_SMONTHNAME1 		= &H38        	'  long name for January
Const LOCALE_SMONTHNAME2 		= &H39        	'  long name for February
Const LOCALE_SMONTHNAME3 		= &H3A        	'  long name for March
Const LOCALE_SMONTHNAME4		= &H3B        	'  long name for April
Const LOCALE_SMONTHNAME5 		= &H3C        	'  long name for May
Const LOCALE_SMONTHNAME6 		= &H3D        	'  long name for June
Const LOCALE_SMONTHNAME7 		= &H3E        	'  long name for July
Const LOCALE_SMONTHNAME8 		= &H3F        	'  long name for August
Const LOCALE_SMONTHNAME9 		= &H40        	'  long name for September
Const LOCALE_SMONTHNAME10		= &H41        	'  long name for October
Const LOCALE_SMONTHNAME11 		= &H42        	'  long name for November
Const LOCALE_SMONTHNAME12 		= &H43        	'  long name for December
Const LOCALE_SABBREVMONTHNAME1 		= &H44        	'  abbreviated name for January
Const LOCALE_SABBREVMONTHNAME2 		= &H45        	'  abbreviated name for February
Const LOCALE_SABBREVMONTHNAME3 		= &H46        	'  abbreviated name for March
Const LOCALE_SABBREVMONTHNAME4 		= &H47        	'  abbreviated name for April
Const LOCALE_SABBREVMONTHNAME5 		= &H48        	'  abbreviated name for May
Const LOCALE_SABBREVMONTHNAME6 		= &H49        	'  abbreviated name for June
Const LOCALE_SABBREVMONTHNAME7 		= &H4A        	'  abbreviated name for July
Const LOCALE_SABBREVMONTHNAME8 		= &H4B        	'  abbreviated name for August
Const LOCALE_SABBREVMONTHNAME9 		= &H4C        	'  abbreviated name for September
Const LOCALE_SABBREVMONTHNAME10		= &H4D        	'  abbreviated name for October
Const LOCALE_SABBREVMONTHNAME11 	= &H4E        	'  abbreviated name for November
Const LOCALE_SABBREVMONTHNAME12 	= &H4F        	'  abbreviated name for December
Const LOCALE_SABBREVMONTHNAME13 	= &H100F

Const LOCALE_SPOSITIVESIGN 		= &H50        	'  positive sign
Const LOCALE_SNEGATIVESIGN 		= &H51        	'  negative sign
Const LOCALE_IPOSSIGNPOSN 		= &H52        	'  positive sign position
Const LOCALE_INEGSIGNPOSN 		= &H53        	'  negative sign position
Const LOCALE_IPOSSYMPRECEDES 		= &H54        	'  mon sym precedes pos amt
Const LOCALE_IPOSSEPBYSPACE 		= &H55        	'  mon sym sep by space from pos amt
Const LOCALE_INEGSYMPRECEDES 		= &H56        	'  mon sym precedes neg amt
Const LOCALE_INEGSEPBYSPACE 		= &H57        	'  mon sym sep by space from neg amt

'  Time Flags for GetTimeFormatW.

Const TIME_NOMINUTESORSECONDS 		= &H1         	'  do not use minutes or seconds
Const TIME_NOSECONDS 			= &H2         	'  do not use seconds
Const TIME_NOTIMEMARKER 		= &H4         	'  do not use time marker
Const TIME_FORCE24HOURFORMAT 		= &H8         	'  always use 24 hour format

'  Date Flags for GetDateFormatW.

Const DATE_SHORTDATE 			= &H1         	'  use short date picture
Const DATE_LONGDATE 			= &H2         	'  use long date picture

Const TIME_ZONE_ID_INVALID         	= &HFFFFFFFF
Const TIME_ZONE_ID_UNKNOWN         	= 0
Const TIME_ZONE_ID_STANDARD        	= 1
Const TIME_ZONE_ID_DAYLIGHT        	= 2

Const HEAP_NO_SERIALIZE            	= &H1
Const HEAP_GROWABLE                	= &H2
Const HEAP_GENERATE_EXCEPTIONS     	= &H4
Const HEAP_ZERO_MEMORY             	= &H8

'  ControlKeyState flags

Const RIGHT_ALT_PRESSED 		= &H1     	'  the right alt key is pressed.
Const LEFT_ALT_PRESSED 			= &H2     	'  the left alt key is pressed.
Const RIGHT_CTRL_PRESSED 		= &H4     	'  the right ctrl key is pressed.
Const LEFT_CTRL_PRESSED 		= &H8     	'  the left ctrl key is pressed.
Const SHIFT_PRESSED 			= &H10    	'  the shift key is pressed.
Const NUMLOCK_ON 			= &H20    	'  the numlock light is on.
Const SCROLLLOCK_ON 			= &H40    	'  the scrolllock light is on.
Const CAPSLOCK_ON 			= &H80    	'  the capslock light is on.
Const ENHANCED_KEY 			= &H100   	'  the key is enhanced.

'  ButtonState flags

Const FROM_LEFT_1ST_BUTTON_PRESSED 	= &H1
Const RIGHTMOST_BUTTON_PRESSED 		= &H2
Const FROM_LEFT_2ND_BUTTON_PRESSED 	= &H4
Const FROM_LEFT_3RD_BUTTON_PRESSED 	= &H8
Const FROM_LEFT_4TH_BUTTON_PRESSED 	= &H10

'  EventFlags

Const MOUSE_MOVED 			= &H1
Const DOUBLE_CLICK 			= &H2

'  EventType flags

Const EVT_KEY_EVENT                		= &H1     	'  Event contains key event record
Const EVT_MOUSE_EVENT              		= &H2     	'  Event contains mouse event record
Const EVT_WINDOW_BUFFER_SIZE_EVENT 		= &H4     	'  Event contains window change event record
Const EVT_MENU_EVENT               		= &H8     	'  Event contains menu event record
Const EVT_FOCUS_EVENT              		= &H10    	'  event contains focus change

'  Attributes flags

Const FOREGROUND_BLUE      		= &H1     	'  text color contains blue.
Const FOREGROUND_GREEN     		= &H2     	'  text color contains green.
Const FOREGROUND_RED       		= &H4     	'  text color contains red.
Const FOREGROUND_INTENSITY 		= &H8     	'  text color is intensified.
Const BACKGROUND_BLUE      		= &H10    	'  background color contains blue.
Const BACKGROUND_GREEN     		= &H20    	'  background color contains green.
Const BACKGROUND_RED       		= &H40    	'  background color contains red.
Const BACKGROUND_INTENSITY 		= &H80    	'  background color is intensified.
Const CONSOLE_BLACKONWHITE 		= &HF0    	'  black text on white background
Const CONSOLE_WHITEONBLACK 		= &H7     	'  white text on black background

Const CTRL_C_EVENT 			= 0
Const CTRL_BREAK_EVENT 			= 1
Const CTRL_CLOSE_EVENT 			= 2
'  3 is reserved!
'  4 is reserved!
Const CTRL_LOGOFF_EVENT 		= 5
Const CTRL_SHUTDOWN_EVENT 		= 6

'  Input Mode flags

Const ENABLE_PROCESSED_INPUT 		= &H1
Const ENABLE_LINE_INPUT 		= &H2
Const ENABLE_ECHO_INPUT 		= &H4
Const ENABLE_WINDOW_INPUT 		= &H8
Const ENABLE_MOUSE_INPUT 		= &H10

'  Output Mode flags

Const ENABLE_PROCESSED_OUTPUT 		= &H1
Const ENABLE_WRAP_AT_EOL_OUTPUT 	= &H2

Const CONSOLE_TEXTMODE_BUFFER 		= 1

Const WAIT_FAILED        		= &HFFFFFFFF
Const WAIT_OBJECT_0      		= &H0
Const WAIT_ABANDONED     		= &H00000080
Const WAIT_ABANDONED_0   		= &H00000080
Const WAIT_IO_COMPLETION 		= &H000000C0

Const STILL_ACTIVE       		= &H00000103

Const HINSTANCE_ERROR			= 32

Const NORM_CURSOR_SIZE 			= 10
Const SOLID_CURSOR_SIZE 		= 99
Const NOCURSOR 				= 0
Const SOLIDCURSOR 			= 1
Const NORMALCURSOR 			= 2

' for EnumSystemLocales()

Const LCID_INSTALLED 			= 1  ' Enumerate only installed locale identifiers
Const LCID_SUPPORTED 			= 2  ' Enumerate all supported locale identifiers

' Exception Constants

' Most or all of the following are sometimes referred to As STATUS_
' codes rather than EXCEPTION_ codes - eg., STATUS_ACCESS_VIOLATION, etc.

Const EXCEPTION_ACCESS_VIOLATION          = &HC0000005
Const EXCEPTION_ARRAY_BOUNDS_EXCEEDED     = &HC000008C
Const EXCEPTION_BREAKPOINT                = &H80000003
Const EXCEPTION_CONTROL_C_EXIT            = &HC000013A
Const EXCEPTION_DATAType_MISALIGNMENT     = &H80000002
Const EXCEPTION_FLOAT_DENORMAL_OPERAND    = &HC000008D
Const EXCEPTION_FLOAT_DIVIDE_BY_ZERO      = &HC000008E
Const EXCEPTION_FLOAT_INEXACT_RESULT      = &HC000008F
Const EXCEPTION_FLOAT_INVALID_OPERATION	  = &HC0000090
Const EXCEPTION_FLOAT_OVERFLOW            = &HC0000091
Const EXCEPTION_FLOAT_STACK_CHECK         = &HC0000092
Const EXCEPTION_FLOAT_UNDERFLOW           = &HC0000093
Const EXCEPTION_GUARD_PAGE                = &H80000001
Const EXCEPTION_ILLEGAL_INSTRUCTION       = &HC000001D
Const EXCEPTION_IN_PAGE_ERROR             = &HC0000006
Const EXCEPTION_INT_DIVIDE_BY_ZERO        = &HC0000094
Const EXCEPTION_INT_OVERFLOW              = &HC0000095
Const EXCEPTION_INVALID_DISPOSITION       = &HC0000026
Const EXCEPTION_NONCONTINUABLE_EXCEPTION  = &HC0000025
Const EXCEPTION_PRIV_INSTRUCTION          = &HC0000096
Const EXCEPTION_SINGLE_STEP               = &H80000004
Const EXCEPTION_STACK_OVERFLOW            = &HC00000FD

Const EXCEPTION_FLT_DENORMAL_OPERAND      = &HC000008D
Const EXCEPTION_FLT_DIVIDE_BY_ZERO        = &HC000008E
Const EXCEPTION_FLT_INEXACT_RESULT        = &HC000008F
Const EXCEPTION_FLT_INVALID_OPERATION     = &HC0000090
Const EXCEPTION_FLT_OVERFLOW              = &HC0000091
Const EXCEPTION_FLT_STACK_CHECK           = &HC0000092
Const EXCEPTION_FLT_UNDERFLOW             = &HC0000093

'CONTEXT record .ContextFlags member

Const CONTEXT_CONTROL        	= &H10001
Const CONTEXT_INTEGER        	= &H10002
Const CONTEXT_SEGMENTS       	= &H10004
Const CONTEXT_FLOATING_POINT 	= &H10008
Const CONTEXT_DEBUG_REGISTERS	= &H10010
Const CONTEXT_FULL            	= &H10007

Const SIZE_OF_80387_REGISTERS	= 80
Const CONTEXT_i386 		= &H10000
Const CONTEXT_i486 		= &H10000

Const EXCEPTION_MAXIMUM_PARAMETERS 	= 15 		'maximum number of elements in EXCEPTION_RECORD.ExceptionInformation[]

Const EXCEPTION_CONTINUABLE	    	= 0		'flag for EXCEPTION_RECORD .ExceptionFlags
Const EXCEPTION_NONCONTINUABLE		= 1		'flag for EXCEPTION_RECORD .ExceptionFlags

Const EXCEPTION_CONTINUE_SEARCH     =  0
Const EXCEPTION_EXECUTE_HANDLER     =  1
Const EXCEPTION_CONTINUE_EXECUTION	= (-1)

'  Operating System Error Constants

Const ERROR_SUCCESS                           =    0
Const ERROR_INVALID_FUNCTION                  =    1
Const ERROR_FILE_NOT_FOUND                    =    2
Const ERROR_PATH_NOT_FOUND                    =    3
Const ERROR_TOO_MANY_OPEN_FILES               =    4
Const ERROR_ACCESS_DENIED                     =    5
Const ERROR_INVALID_HANDLE                    =    6
Const ERROR_ARENA_TRASHED                     =    7
Const ERROR_NOT_ENOUGH_MEMORY                 =    8
Const ERROR_INVALID_BLOCK                     =    9
Const ERROR_BAD_ENVIRONMENT                   =   10
Const ERROR_BAD_FORMAT                        =   11
Const ERROR_INVALID_ACCESS                    =   12
Const ERROR_INVALID_DATA                      =   13
Const ERROR_OUTOFMEMORY                       =   14
Const ERROR_INVALID_DRIVE                     =   15
Const ERROR_CURRENT_DIRECTORY                 =   16
Const ERROR_NOT_SAME_DEVICE                   =   17
Const ERROR_NO_MORE_FILES                     =   18
Const ERROR_WRITE_PROTECT                     =   19
Const ERROR_BAD_UNIT                          =   20
Const ERROR_NOT_READY                         =   21
Const ERROR_BAD_COMMAND                       =   22
Const ERROR_CRC                               =   23
Const ERROR_BAD_LENGTH                        =   24
Const ERROR_SEEK                              =   25
Const ERROR_NOT_DOS_DISK                      =   26
Const ERROR_SECTOR_NOT_FOUND                  =   27
Const ERROR_OUT_OF_PAPER                      =   28
Const ERROR_WRITE_FAULT                       =   29
Const ERROR_READ_FAULT                        =   30
Const ERROR_GEN_FAILURE                       =   31
Const ERROR_SHARING_VIOLATION                 =   32
Const ERROR_LOCK_VIOLATION                    =   33
Const ERROR_WRONG_DISK                        =   34
Const ERROR_SHARING_BUFFER_EXCEEDED           =   36
Const ERROR_HANDLE_EOF                        =   38
Const ERROR_HANDLE_DISK_FULL                  =   39
Const ERROR_NOT_SUPPORTED                     =   50
Const ERROR_REM_NOT_LIST                      =   51
Const ERROR_DUP_NAME                          =   52
Const ERROR_BAD_NETPATH                       =   53
Const ERROR_NETWORK_BUSY                      =   54
Const ERROR_DEV_NOT_EXIST                     =   55
Const ERROR_TOO_MANY_CMDS                     =   56
Const ERROR_ADAP_HDW_ERR                      =   57
Const ERROR_BAD_NET_RESP                      =   58
Const ERROR_UNEXP_NET_ERR                     =   59
Const ERROR_BAD_REM_ADAP                      =   60
Const ERROR_PRINTQ_FULL                       =   61
Const ERROR_NO_SPOOL_SPACE                    =   62
Const ERROR_PRINT_CANCELLED                   =   63
Const ERROR_NETNAME_DELETED                   =   64
Const ERROR_NETWORK_ACCESS_DENIED             =   65
Const ERROR_BAD_DEV_Type                      =   66
Const ERROR_BAD_NET_NAME                      =   67
Const ERROR_TOO_MANY_NAMES                    =   68
Const ERROR_TOO_MANY_SESS                     =   69
Const ERROR_SHARING_PAUSED                    =   70
Const ERROR_REQ_NOT_ACCEP                     =   71
Const ERROR_REDIR_PAUSED                      =   72
Const ERROR_FILE_EXISTS                       =   80
Const ERROR_CANNOT_MAKE                       =   82
Const ERROR_FAIL_I24                          =   83
Const ERROR_OUT_OF_STRUCTURES                 =   84
Const ERROR_ALREADY_ASSIGNED                  =   85
Const ERROR_INVALID_PASSWORD                  =   86
Const ERROR_INVALID_PARAMETER                 =   87
Const ERROR_NET_WRITE_FAULT                   =   88
Const ERROR_NO_PROC_SLOTS                     =   89
Const ERROR_TOO_MANY_SEMAPHORES               =  100
Const ERROR_EXCL_SEM_ALREADY_OWNED            =  101
Const ERROR_SEM_IS_SET                        =  102
Const ERROR_TOO_MANY_SEM_REQUESTS             =  103
Const ERROR_INVALID_AT_INTERRUPT_TIME         =  104
Const ERROR_SEM_OWNER_DIED                    =  105
Const ERROR_SEM_USER_LIMIT                    =  106
Const ERROR_DISK_CHANGE                       =  107
Const ERROR_DRIVE_LOCKED                      =  108
Const ERROR_BROKEN_PIPE                       =  109
Const ERROR_OPEN_FAILED                       =  110
Const ERROR_BUFFER_OVERFLOW                   =  111
Const ERROR_DISK_FULL                         =  112
Const ERROR_NO_MORE_SEARCH_HANDLES            =  113
Const ERROR_INVALID_TARGET_HANDLE             =  114
Const ERROR_INVALID_CATEGORY                  =  117
Const ERROR_INVALID_VERIFY_SWITCH             =  118
Const ERROR_BAD_DRIVER_LEVEL                  =  119
Const ERROR_CALL_NOT_IMPLEMENTED              =  120
Const ERROR_SEM_TIMEOUT                       =  121
Const ERROR_INSUFFICIENT_BUFFER               =  122
Const ERROR_INVALID_NAME                      =  123
Const ERROR_INVALID_LEVEL                     =  124
Const ERROR_NO_VOLUME_LABEL                   =  125
Const ERROR_MOD_NOT_FOUND                     =  126
Const ERROR_PROC_NOT_FOUND                    =  127
Const ERROR_WAIT_NO_CHILDREN                  =  128
Const ERROR_CHILD_NOT_COMPLETE                =  129
Const ERROR_DIRECT_ACCESS_HANDLE              =  130
Const ERROR_NEGATIVE_SEEK                     =  131
Const ERROR_SEEK_ON_DEVICE                    =  132
Const ERROR_IS_JOIN_TARGET                    =  133
Const ERROR_IS_JOINED                         =  134
Const ERROR_IS_SUBSTED                        =  135
Const ERROR_NOT_JOINED                        =  136
Const ERROR_NOT_SUBSTED                       =  137
Const ERROR_JOIN_TO_JOIN                      =  138
Const ERROR_SUBST_TO_SUBST                    =  139
Const ERROR_JOIN_TO_SUBST                     =  140
Const ERROR_SUBST_TO_JOIN                     =  141
Const ERROR_BUSY_DRIVE                        =  142
Const ERROR_SAME_DRIVE                        =  143
Const ERROR_DIR_NOT_ROOT                      =  144
Const ERROR_DIR_NOT_EMPTY                     =  145
Const ERROR_IS_SUBST_PATH                     =  146
Const ERROR_IS_JOIN_PATH                      =  147
Const ERROR_PATH_BUSY                         =  148
Const ERROR_IS_SUBST_TARGET                   =  149
Const ERROR_SYSTEM_TRACE                      =  150
Const ERROR_INVALID_EVENT_COUNT               =  151
Const ERROR_TOO_MANY_MUXWAITERS               =  152
Const ERROR_INVALID_LIST_FORMAT               =  153
Const ERROR_LABEL_TOO_LONG                    =  154
Const ERROR_TOO_MANY_TCBS                     =  155
Const ERROR_SIGNAL_REFUSED                    =  156
Const ERROR_DISCARDED                         =  157
Const ERROR_NOT_LOCKED                        =  158
Const ERROR_BAD_THREADID_ADDR                 =  159
Const ERROR_BAD_ARGUMENTS                     =  160
Const ERROR_BAD_PATHNAME                      =  161
Const ERROR_SIGNAL_PENDING                    =  162
Const ERROR_MAX_THRDS_REACHED                 =  164
Const ERROR_LOCK_FAILED                       =  167
Const ERROR_BUSY                              =  170
Const ERROR_CANCEL_VIOLATION                  =  173
Const ERROR_ATOMIC_LOCKS_NOT_SUPPORTED        =  174
Const ERROR_INVALID_SEGMENT_NUMBER            =  180
Const ERROR_INVALID_ORDINAL                   =  182
Const ERROR_ALREADY_EXISTS                    =  183
Const ERROR_INVALID_FLAG_NUMBER               =  186
Const ERROR_SEM_NOT_FOUND                     =  187
Const ERROR_INVALID_STARTING_CODESEG          =  188
Const ERROR_INVALID_STACKSEG                  =  189
Const ERROR_INVALID_MODULEType                =  190
Const ERROR_INVALID_EXE_SIGNATURE             =  191
Const ERROR_EXE_MARKED_INVALID                =  192
Const ERROR_BAD_EXE_FORMAT                    =  193
Const ERROR_ITERATED_DATA_EXCEEDS_64k         =  194
Const ERROR_INVALID_MINALLOCSIZE              =  195
Const ERROR_DYNLINK_FROM_INVALID_RING         =  196
Const ERROR_IOPL_NOT_ENABLED                  =  197
Const ERROR_INVALID_SEGDPL                    =  198
Const ERROR_AUTODATASEG_EXCEEDS_64k           =  199
Const ERROR_RING2SEG_MUST_BE_MOVABLE          =  200
Const ERROR_RELOC_CHAIN_XEEDS_SEGLIM          =  201
Const ERROR_INFLOOP_IN_RELOC_CHAIN            =  202
Const ERROR_ENVVAR_NOT_FOUND                  =  203
Const ERROR_NO_SIGNAL_SENT                    =  205
Const ERROR_FILENAME_EXCED_RANGE              =  206
Const ERROR_RING2_STACK_IN_USE                =  207
Const ERROR_META_EXPANSION_TOO_LONG           =  208
Const ERROR_INVALID_SIGNAL_NUMBER             =  209
Const ERROR_THREAD_1_INACTIVE                 =  210
Const ERROR_LOCKED                            =  212
Const ERROR_TOO_MANY_MODULES                  =  214
Const ERROR_NESTING_NOT_ALLOWED               =  215
Const ERROR_BAD_PIPE                          =  230
Const ERROR_PIPE_BUSY                         =  231
Const ERROR_NO_DATA                           =  232
Const ERROR_PIPE_NOT_CONNECTED                =  233
Const ERROR_MORE_DATA                         =  234
Const ERROR_VC_DISCONNECTED                   =  240
Const ERROR_INVALID_EA_NAME                   =  254
Const ERROR_EA_LIST_INCONSISTENT              =  255
Const WAIT_TIMEOUT                            =  258
Const ERROR_NO_MORE_ITEMS                     =  259
Const ERROR_CANNOT_COPY                       =  266
Const ERROR_DIRECTORY                         =  267
Const ERROR_EAS_DIDNT_FIT                     =  275
Const ERROR_EA_FILE_CORRUPT                   =  276
Const ERROR_EA_TABLE_FULL                     =  277
Const ERROR_INVALID_EA_HANDLE                 =  278
Const ERROR_EAS_NOT_SUPPORTED                 =  282
Const ERROR_NOT_OWNER                         =  288
Const ERROR_TOO_MANY_POSTS                    =  298
Const ERROR_MR_MID_NOT_FOUND                  =  317
Const ERROR_INVALID_ADDRESS                   =  487
Const ERROR_ARITHMETIC_OVERFLOW               =  534
Const ERROR_PIPE_CONNECTED                    =  535
Const ERROR_PIPE_LISTENING                    =  536
Const ERROR_EA_ACCESS_DENIED                  =  994
Const ERROR_OPERATION_ABORTED                 =  995
Const ERROR_IO_INCOMPLETE                     =  996
Const ERROR_IO_PENDING                        =  997
Const ERROR_NOACCESS                          =  998
Const ERROR_SWAPERROR                         =  999
Const ERROR_STACK_OVERFLOW                    = 1001
Const ERROR_INVALID_MESSAGE                   = 1002
Const ERROR_CAN_NOT_COMPLETE                  = 1003
Const ERROR_INVALID_FLAGS                     = 1004
Const ERROR_UNRECOGNIZED_VOLUME               = 1005
Const ERROR_FILE_INVALID                      = 1006
Const ERROR_FULLSCREEN_MODE                   = 1007
Const ERROR_NO_TOKEN                          = 1008
Const ERROR_BADDB                             = 1009
Const ERROR_BADKEY                            = 1010
Const ERROR_CANTOPEN                          = 1011
Const ERROR_CANTREAD                          = 1012
Const ERROR_CANTWRITE                         = 1013
Const ERROR_REGISTRY_RECOVERED                = 1014
Const ERROR_REGISTRY_CORRUPT                  = 1015
Const ERROR_REGISTRY_IO_FAILED                = 1016
Const ERROR_NOT_REGISTRY_FILE                 = 1017
Const ERROR_KEY_DELETED                       = 1018
Const ERROR_NO_LOG_SPACE                      = 1019
Const ERROR_KEY_HAS_CHILDREN                  = 1020
Const ERROR_CHILD_MUST_BE_VOLATILE            = 1021
Const ERROR_NOTIFY_ENUM_DIR                   = 1022
Const ERROR_DEPENDENT_SERVICES_RUNNING        = 1051
Const ERROR_INVALID_SERVICE_CONTROL           = 1052
Const ERROR_SERVICE_REQUEST_TIMEOUT           = 1053
Const ERROR_SERVICE_NO_THREAD                 = 1054
Const ERROR_SERVICE_DATABASE_LOCKED           = 1055
Const ERROR_SERVICE_ALREADY_RUNNING           = 1056
Const ERROR_INVALID_SERVICE_ACCOUNT           = 1057
Const ERROR_SERVICE_DISABLED                  = 1058
Const ERROR_CIRCULAR_DEPENDENCY               = 1059
Const ERROR_SERVICE_DOES_NOT_EXIST            = 1060
Const ERROR_SERVICE_CANNOT_ACCEPT_CTRL        = 1061
Const ERROR_SERVICE_NOT_ACTIVE                = 1062
Const ERROR_FAILED_SERVICE_CONTROLLER_CONNECT = 1063
Const ERROR_EXCEPTION_IN_SERVICE              = 1064
Const ERROR_DATABASE_DOES_NOT_EXIST           = 1065
Const ERROR_SERVICE_SPECIFIC_ERROR            = 1066
Const ERROR_PROCESS_ABORTED                   = 1067
Const ERROR_SERVICE_DEPENDENCY_FAIL           = 1068
Const ERROR_SERVICE_LOGON_FAILED              = 1069
Const ERROR_SERVICE_START_HANG                = 1070
Const ERROR_INVALID_SERVICE_LOCK              = 1071
Const ERROR_SERVICE_MARKED_FOR_DELETE         = 1072
Const ERROR_SERVICE_EXISTS                    = 1073
Const ERROR_ALREADY_RUNNING_LKG               = 1074
Const ERROR_SERVICE_DEPENDENCY_DELETED        = 1075
Const ERROR_BOOT_ALREADY_ACCEPTED             = 1076
Const ERROR_SERVICE_NEVER_STARTED             = 1077
Const ERROR_DUPLICATE_SERVICE_NAME            = 1078
Const ERROR_END_OF_MEDIA                      = 1100
Const ERROR_FILEMARK_DETECTED                 = 1101
Const ERROR_BEGINNING_OF_MEDIA                = 1102
Const ERROR_SETMARK_DETECTED                  = 1103
Const ERROR_NO_DATA_DETECTED                  = 1104
Const ERROR_PARTITION_FAILURE                 = 1105
Const ERROR_INVALID_BLOCK_LENGTH              = 1106
Const ERROR_DEVICE_NOT_PARTITIONED            = 1107
Const ERROR_UNABLE_TO_LOCK_MEDIA              = 1108
Const ERROR_UNABLE_TO_UNLOAD_MEDIA            = 1109
Const ERROR_MEDIA_CHANGED                     = 1110
Const ERROR_BUS_RESET                         = 1111
Const ERROR_NO_MEDIA_IN_DRIVE                 = 1112
Const ERROR_NO_UNICODE_TRANSLATION            = 1113
Const ERROR_DLL_INIT_FAILED                   = 1114
Const ERROR_SHUTDOWN_IN_PROGRESS              = 1115
Const ERROR_NO_SHUTDOWN_IN_PROGRESS           = 1116
Const ERROR_IO_DEVICE                         = 1117
Const ERROR_SERIAL_NO_DEVICE                  = 1118
Const ERROR_IRQ_BUSY                          = 1119
Const ERROR_MORE_WRITES                       = 1120
Const ERROR_COUNTER_TIMEOUT                   = 1121
Const ERROR_FLOPPY_ID_MARK_NOT_FOUND          = 1122
Const ERROR_FLOPPY_WRONG_CYLINDER             = 1123
Const ERROR_FLOPPY_UNKNOWN_ERROR              = 1124
Const ERROR_FLOPPY_BAD_REGISTERS              = 1125
Const ERROR_DISK_RECALIBRATE_FAILED           = 1126
Const ERROR_DISK_OPERATION_FAILED             = 1127
Const ERROR_DISK_RESET_FAILED                 = 1128
Const ERROR_EOM_OVERFLOW                      = 1129
Const ERROR_NOT_ENOUGH_SERVER_MEMORY          = 1130
Const ERROR_POSSIBLE_DEADLOCK                 = 1131
Const ERROR_MAPPED_ALIGNMENT                  = 1132
Const ERROR_BAD_USERNAME                      = 2202
Const ERROR_NOT_CONNECTED                     = 2250
Const ERROR_OPEN_FILES                        = 2401
Const ERROR_DEVICE_IN_USE                     = 2404
Const ERROR_BAD_DEVICE                        = 1200
Const ERROR_CONNECTION_UNAVAIL                = 1201
Const ERROR_DEVICE_ALREADY_REMEMBERED         = 1202
Const ERROR_NO_NET_OR_BAD_PATH                = 1203
Const ERROR_BAD_PROVIDER                      = 1204
Const ERROR_CANNOT_OPEN_PROFILE               = 1205
Const ERROR_BAD_PROFILE                       = 1206
Const ERROR_NOT_CONTAINER                     = 1207
Const ERROR_EXTENDED_ERROR                    = 1208
Const ERROR_INVALID_GROUPNAME                 = 1209
Const ERROR_INVALID_COMPUTERNAME              = 1210
Const ERROR_INVALID_EVENTNAME                 = 1211
Const ERROR_INVALID_DOMAINNAME                = 1212
Const ERROR_INVALID_SERVICENAME               = 1213
Const ERROR_INVALID_NETNAME                   = 1214
Const ERROR_INVALID_SHARENAME                 = 1215
Const ERROR_INVALID_PASSWORDNAME              = 1216
Const ERROR_INVALID_MESSAGENAME               = 1217
Const ERROR_INVALID_MESSAGEDEST               = 1218
Const ERROR_SESSION_CREDENTIAL_CONFLICT       = 1219
Const ERROR_REMOTE_SESSION_LIMIT_EXCEEDED     = 1220
Const ERROR_DUP_DOMAINNAME                    = 1221
Const ERROR_NO_NETWORK                        = 1222
Const ERROR_NOT_ALL_ASSIGNED                  = 1300
Const ERROR_SOME_NOT_MAPPED                   = 1301
Const ERROR_NO_QUOTAS_FOR_ACCOUNT             = 1302
Const ERROR_LOCAL_USER_SESSION_KEY            = 1303
Const ERROR_NULL_LM_PASSWORD                  = 1304
Const ERROR_UNKNOWN_REVISION                  = 1305
Const ERROR_REVISION_MISMATCH                 = 1306
Const ERROR_INVALID_OWNER                     = 1307
Const ERROR_INVALID_PRIMARY_GROUP             = 1308
Const ERROR_NO_IMPERSONATION_TOKEN            = 1309
Const ERROR_CANT_DISABLE_MANDATORY            = 1310
Const ERROR_NO_LOGON_SERVERS                  = 1311
Const ERROR_NO_SUCH_LOGON_SESSION             = 1312
Const ERROR_NO_SUCH_PRIVILEGE                 = 1313
Const ERROR_PRIVILEGE_NOT_HELD                = 1314
Const ERROR_INVALID_ACCOUNT_NAME              = 1315
Const ERROR_USER_EXISTS                       = 1316
Const ERROR_NO_SUCH_USER                      = 1317
Const ERROR_GROUP_EXISTS                      = 1318
Const ERROR_NO_SUCH_GROUP                     = 1319
Const ERROR_MEMBER_IN_GROUP                   = 1320
Const ERROR_MEMBER_NOT_IN_GROUP               = 1321
Const ERROR_LAST_ADMIN                        = 1322
Const ERROR_WRONG_PASSWORD                    = 1323
Const ERROR_ILL_FORMED_PASSWORD               = 1324
Const ERROR_PASSWORD_RESTRICTION              = 1325
Const ERROR_LOGON_FAILURE                     = 1326
Const ERROR_ACCOUNT_RESTRICTION               = 1327
Const ERROR_INVALID_LOGON_HOURS               = 1328
Const ERROR_INVALID_WORKSTATION               = 1329
Const ERROR_PASSWORD_EXPIRED                  = 1330
Const ERROR_ACCOUNT_DISABLED                  = 1331
Const ERROR_NONE_MAPPED                       = 1332
Const ERROR_TOO_MANY_LUIDS_REQUESTED          = 1333
Const ERROR_LUIDS_EXHAUSTED                   = 1334
Const ERROR_INVALID_SUB_AUTHORITY             = 1335
Const ERROR_INVALID_ACL                       = 1336
Const ERROR_INVALID_SID                       = 1337
Const ERROR_INVALID_SECURITY_DESCR            = 1338
Const ERROR_BAD_INHERITANCE_ACL               = 1340
Const ERROR_SERVER_DISABLED                   = 1341
Const ERROR_SERVER_NOT_DISABLED               = 1342
Const ERROR_INVALID_ID_AUTHORITY              = 1343
Const ERROR_ALLOTTED_SPACE_EXCEEDED           = 1344
Const ERROR_INVALID_GROUP_ATTRIBUTES          = 1345
Const ERROR_BAD_IMPERSONATION_LEVEL           = 1346
Const ERROR_CANT_OPEN_ANONYMOUS               = 1347
Const ERROR_BAD_VALIDATION_CLASS              = 1348
Const ERROR_BAD_TOKEN_Type                    = 1349
Const ERROR_NO_SECURITY_ON_OBJECT             = 1350
Const ERROR_CANT_ACCESS_DOMAIN_INFO           = 1351
Const ERROR_INVALID_SERVER_STATE              = 1352
Const ERROR_INVALID_DOMAIN_STATE              = 1353
Const ERROR_INVALID_DOMAIN_ROLE               = 1354
Const ERROR_NO_SUCH_DOMAIN                    = 1355
Const ERROR_DOMAIN_EXISTS                     = 1356
Const ERROR_DOMAIN_LIMIT_EXCEEDED             = 1357
Const ERROR_INTERNAL_DB_CORRUPTION            = 1358
Const ERROR_INTERNAL_ERROR                    = 1359
Const ERROR_GENERIC_NOT_MAPPED                = 1360
Const ERROR_BAD_DESCRIPTOR_FORMAT             = 1361
Const ERROR_NOT_LOGON_PROCESS                 = 1362
Const ERROR_LOGON_SESSION_EXISTS              = 1363
Const ERROR_NO_SUCH_PACKAGE                   = 1364
Const ERROR_BAD_LOGON_SESSION_STATE           = 1365
Const ERROR_LOGON_SESSION_COLLISION           = 1366
Const ERROR_INVALID_LOGON_Type                = 1367
Const ERROR_CANNOT_IMPERSONATE                = 1368
Const ERROR_RXACT_INVALID_STATE               = 1369
Const ERROR_RXACT_COMMIT_FAILURE              = 1370
Const ERROR_SPECIAL_ACCOUNT                   = 1371
Const ERROR_SPECIAL_GROUP                     = 1372
Const ERROR_SPECIAL_USER                      = 1373
Const ERROR_MEMBERS_PRIMARY_GROUP             = 1374
Const ERROR_TOKEN_ALREADY_IN_USE              = 1375
Const ERROR_NO_SUCH_ALIAS                     = 1376
Const ERROR_MEMBER_NOT_IN_ALIAS               = 1377
Const ERROR_MEMBER_IN_ALIAS                   = 1378
Const ERROR_ALIAS_EXISTS                      = 1379
Const ERROR_LOGON_NOT_GRANTED                 = 1380
Const ERROR_TOO_MANY_SECRETS                  = 1381
Const ERROR_SECRET_TOO_LONG                   = 1382
Const ERROR_INTERNAL_DB_ERROR                 = 1383
Const ERROR_TOO_MANY_CONTEXT_IDS              = 1384
Const ERROR_LOGON_Type_NOT_GRANTED            = 1385
Const ERROR_NT_CROSS_ENCRYPTION_REQUIRED      = 1386
Const ERROR_NO_SUCH_MEMBER                    = 1387
Const ERROR_INVALID_MEMBER                    = 1388
Const ERROR_TOO_MANY_SIDS                     = 1389
Const ERROR_LM_CROSS_ENCRYPTION_REQUIRED      = 1390
Const ERROR_NO_INHERITANCE                    = 1391
Const ERROR_FILE_CORRUPT                      = 1392
Const ERROR_DISK_CORRUPT                      = 1393
Const ERROR_NO_USER_SESSION_KEY               = 1394
Const ERROR_INVALID_WINDOW_HANDLE             = 1400
Const ERROR_INVALID_MENU_HANDLE               = 1401
Const ERROR_INVALID_CURSOR_HANDLE             = 1402
Const ERROR_INVALID_ACCEL_HANDLE              = 1403
Const ERROR_INVALID_HOOK_HANDLE               = 1404
Const ERROR_INVALID_DWP_HANDLE                = 1405
Const ERROR_TLW_WITH_WSCHILD                  = 1406
Const ERROR_CANNOT_FIND_WND_CLASS             = 1407
Const ERROR_WINDOW_OF_OTHER_THREAD            = 1408
Const ERROR_HOTKEY_ALREADY_REGISTERED         = 1409
Const ERROR_CLASS_ALREADY_EXISTS              = 1410
Const ERROR_CLASS_DOES_NOT_EXIST              = 1411
Const ERROR_CLASS_HAS_WINDOWS                 = 1412
Const ERROR_INVALID_INDEX                     = 1413
Const ERROR_INVALID_ICON_HANDLE               = 1414
Const ERROR_PRIVATE_DIALOG_INDEX              = 1415
Const ERROR_LISTBOX_ID_NOT_FOUND              = 1416
Const ERROR_NO_WILDCARD_CHARACTERS            = 1417
Const ERROR_CLIPBOARD_NOT_OPEN                = 1418
Const ERROR_HOTKEY_NOT_REGISTERED             = 1419
Const ERROR_WINDOW_NOT_DIALOG                 = 1420
Const ERROR_CONTROL_ID_NOT_FOUND              = 1421
Const ERROR_INVALID_COMBOBOX_MESSAGE          = 1422
Const ERROR_WINDOW_NOT_COMBOBOX               = 1423
Const ERROR_INVALID_EDIT_HEIGHT               = 1424
Const ERROR_DC_NOT_FOUND                      = 1425
Const ERROR_INVALID_HOOK_FILTER               = 1426
Const ERROR_INVALID_FILTER_PROC               = 1427
Const ERROR_HOOK_NEEDS_HMOD                   = 1428
Const ERROR_GLOBAL_ONLY_HOOK                  = 1429
Const ERROR_JOURNAL_HOOK_SET                  = 1430
Const ERROR_HOOK_NOT_INSTALLED                = 1431
Const ERROR_INVALID_LB_MESSAGE                = 1432
Const ERROR_SETCOUNT_ON_BAD_LB                = 1433
Const ERROR_LB_WITHOUT_TABSTOPS               = 1434
Const ERROR_DESTROY_OBJECT_OF_OTHER_THREAD    = 1435
Const ERROR_CHILD_WINDOW_MENU                 = 1436
Const ERROR_NO_SYSTEM_MENU                    = 1437
Const ERROR_INVALID_MSGBOX_STYLE              = 1438
Const ERROR_INVALID_SPI_VALUE                 = 1439
Const ERROR_SCREEN_ALREADY_LOCKED             = 1440
Const ERROR_HWNDS_HAVE_DIFF_PARENT            = 1441
Const ERROR_NOT_CHILD_WINDOW                  = 1442
Const ERROR_INVALID_GW_COMMAND                = 1443
Const ERROR_INVALID_THREAD_ID                 = 1444
Const ERROR_NON_MDICHILD_WINDOW               = 1445
Const ERROR_POPUP_ALREADY_ACTIVE              = 1446
Const ERROR_NO_SCROLLBARS                     = 1447
Const ERROR_INVALID_SCROLLBAR_RANGE           = 1448
Const ERROR_INVALID_SHOWWIN_COMMAND           = 1449
Const ERROR_EVENTLOG_FILE_CORRUPT             = 1500
Const ERROR_EVENTLOG_CANT_START               = 1501
Const ERROR_LOG_FILE_FULL                     = 1502
Const ERROR_EVENTLOG_FILE_CHANGED             = 1503
Const ERROR_INVALID_USER_BUFFER               = 1784
Const ERROR_UNRECOGNIZED_MEDIA                = 1785
Const ERROR_NO_TRUST_LSA_SECRET               = 1786
Const ERROR_NO_TRUST_SAM_ACCOUNT              = 1787
Const ERROR_TRUSTED_DOMAIN_FAILURE            = 1788
Const ERROR_TRUSTED_RELATIONSHIP_FAILURE      = 1789
Const ERROR_TRUST_FAILURE                     = 1790
Const ERROR_NETLOGON_NOT_STARTED              = 1792
Const ERROR_ACCOUNT_EXPIRED                   = 1793
Const ERROR_REDIRECTOR_HAS_OPEN_HANDLES       = 1794
Const ERROR_PRINTER_DRIVER_ALREADY_INSTALLED  = 1795
Const ERROR_UNKNOWN_PORT                      = 1796
Const ERROR_UNKNOWN_PRINTER_DRIVER            = 1797
Const ERROR_UNKNOWN_PRINTPROCESSOR            = 1798
Const ERROR_INVALID_SEPARATOR_FILE            = 1799
Const ERROR_INVALID_PRIORITY                  = 1800
Const ERROR_INVALID_PRINTER_NAME              = 1801
Const ERROR_PRINTER_ALREADY_EXISTS            = 1802
Const ERROR_INVALID_PRINTER_COMMAND           = 1803
Const ERROR_INVALID_DATAType                  = 1804
Const ERROR_INVALID_ENVIRONMENT               = 1805
Const ERROR_NOLOGON_INTERDOMAIN_TRUST_ACCOUNT = 1807
Const ERROR_NOLOGON_WORKSTATION_TRUST_ACCOUNT = 1808
Const ERROR_NOLOGON_SERVER_TRUST_ACCOUNT      = 1809
Const ERROR_DOMAIN_TRUST_INCONSISTENT         = 1810
Const ERROR_SERVER_HAS_OPEN_HANDLES           = 1811
Const ERROR_RESOURCE_DATA_NOT_FOUND           = 1812
Const ERROR_RESOURCE_Type_NOT_FOUND           = 1813
Const ERROR_RESOURCE_NAME_NOT_FOUND           = 1814
Const ERROR_RESOURCE_LANG_NOT_FOUND           = 1815
Const ERROR_NOT_ENOUGH_QUOTA                  = 1816
Const ERROR_INVALID_TIME                      = 1901
Const ERROR_INVALID_FORM_NAME                 = 1902
Const ERROR_INVALID_FORM_SIZE                 = 1903
Const ERROR_ALREADY_WAITING                   = 1904
Const ERROR_PRINTER_DELETED                   = 1905
Const ERROR_INVALID_PRINTER_STATE             = 1906
Const ERROR_NO_BROWSER_SERVERS_FOUND          = 6118
Const ERROR_LAST_OS_ERROR                     = 8191

Const SEVERITY_SUCCESS = 0
Const SEVERITY_ERROR = 1
Const FACILITY_NT_BIT = &H10000000
Const NOERROR = 0
Const E_UNEXPECTED = &H8000FFFF
Const E_NOTIMPL = &H80004001
Const E_OUTOFMEMORY = &H8007000E
Const E_INVALIDARG = &H80070057
Const E_NOINTERFACE = &H80004002
Const E_POINTER = &H80004003
Const E_HANDLE = &H80070006
Const E_ABORT = &H80004004
Const E_FAIL = &H80004005
Const E_ACCESSDENIED = &H80070005

'------------------
'| REQUIRED TYPES |
'------------------

Type SMALL_RECT
  Left   As ushort
  Top    As ushort
  Right  As ushort
  Bottom As ushort
End Type

Type COMMPROP
  wPacketLength       As ushort
  wPacketVersion      As ushort
  dwServiceMask       As uinteger
  dwReserved1         As uinteger
  dwMaxTxQueue        As uinteger
  dwMaxRxQueue        As uinteger
  dwMaxBaud           As uinteger
  dwProvSubType       As uinteger
  dwProvCapabilities  As uinteger
  dwSettableParams    As uinteger
  dwSettableBaud      As uinteger
  wSettableData       As ushort
  wSettableStopParity As ushort
  dwCurrentTxQueue    As uinteger
  dwCurrentRxQueue    As uinteger
  dwProvSpec1         As uinteger
  dwProvSpec2         As uinteger
  wcProvChar          As BYTE PTR ' array size may vary
End Type

Type COMSTAT
  fbits    As uinteger ' fCtsHold,  fDsrHold,  fRlsdHold,  fXoffHold,  fXoffSent,  fEof,  fTxim
  cbInQue  As uinteger
  cbOutQue As uinteger
End Type

Type DCB Field = 1 ' 28 bytes
  DCBlength  As uinteger ' SIZE (DCB)
  BaudRate   As uinteger
  fBits      As uinteger
  wReserved  As ushort
  XonLim     As ushort
  XoffLim    As ushort
  ByteSize   As ubyte
  Parity     As ubyte
  StopBits   As ubyte
  XonChar    As ubyte
  XoffChar   As ubyte
  ErrorChar  As ubyte
  EofChar    As ubyte
  EvtChar    As ubyte
  wReserved1 As ushort
End Type

Type COMMTIMEOUTS
	ReadIntervalTimeout		As uinteger
	ReadTotalTimeoutMultiplier	As uinteger
	ReadTotalTimeoutConstant	As uinteger
	WriteTotalTimeoutMultiplier	As uinteger
	WriteTotalTimeoutConstant	As uinteger
End Type

Type GUIDAPI
	Data1	As uinteger
	Data2	As ushort
	Data3	As ushort
	Data4	As String * 8 - 1
End Type

Type COMMCONFIG
	dwSize		    	As uinteger
	wVersion	    	As ushort
	wReserved	    	As ushort
	dcb			        As DCB
	dwProviderSubType	As uinteger
	dwProviderOffset	As uinteger
	dwProviderSize		As uinteger
	wcProviderData		As uinteger
End Type

Type OVERLAPPED
	Internal    	As uinteger
	InternalHigh	As uinteger
	offset		    As uinteger
	OffsetHigh	    As uinteger
	hEvent		    As uinteger
End Type

Type SECURITYATTRIBUTES
	nLength			        As uinteger
	lpSecurityDescriptor	As uinteger
	bInheritHandle	    	As uinteger
End Type

Type STARTUPINFO                ' CreateProcess()
    cb As Integer        
    lpReserved          As Integer        
    lpDesktop           As Integer        
    lpTitle             As Integer        
    dwX                 As Integer        
    dwY                 As Integer        
    dwXSize             As Integer        
    dwYSize             As Integer        
    dwXCountChars       As Integer        
    dwYCountChars       As Integer        
    dwFillAttribute     As Integer        
    dwFlags             As Integer        
    wShowWindow         As ushort       
    cbReserved2         As ushort       
    lpReserved2         As Integer        
    hStdInput           As Integer        
    hStdOutput          As Integer        
    hStdError           As Integer        
End Type

Type PROCESS_INFORMATION        ' CreateProcess()
    hProcess    As Integer        
    hThread     As Integer        
    dwProcessId As Integer        
    dwThreadId  As Integer        
End Type


Type CRITICAL_SECTION
    DebugInfo       As Integer	
    LockCount       As Integer	
    RecursionCount  As Integer	
    OwningThread    As Integer	
    LockSemaphore   As Integer	
    Reserved        As Integer	
End Type

Type FILETIME
    dwLowDateTime   As uinteger  
    dwHighDateTime  As uinteger  
End Type

Type WIN32_FIND_DATA
    dwFileAttributes    As uinteger  
    ftCreationTime      As FILETIME  
    ftLastAccessTime    As FILETIME  
    ftLastWriteTime     As FILETIME  
    nFileSizeHigh       As uinteger  
    nFileSizeLow        As uinteger  
    dwReserved0         As uinteger  
    dwReserved1         As uinteger  
    cFileName           As String * 260 - 1
    cAlternate          As String * 14 - 1
End Type

Type CPINFO
    MaxCharSize   	As uinteger	'max length [bytes] of a char   
	DefaultChar(0)  As ubyte  
    LeadByte(0 to 10)	As ubyte  
End Type

Type CHAR_INFO
	UNION
        UnicodeChar As ushort  	
        AsciiChar   As ubyte		
	End UNION
    Attributes      As ushort  
End Type

Type COORD
  x As ushort  
  y As ushort  
End Type

Type CONSOLE_SCREEN_BUFFER_INFO
  dwSize              As COORD       
  dwCursorPosition    As COORD       
  wAttributes         As ushort      
  srWindow            As SMALL_RECT  
  dwMaximumWindowSize As COORD       
End Type

Type CONSOLE_CURSOR_INFO
  dwSize  As Integer  
  bVisible As Integer  
End Type

Type SYSTEM_INFO
  dwOemID                     As uinteger  
  dwPageSize                  As uinteger  
  lpMinimumApplicationAddress As uinteger  
  lpMaximumApplicationAddress As uinteger  
  dwActiveProcessorMask       As uinteger  
  dwNumberOfProcessors        As uinteger  
  dwProcessorType             As uinteger  
  dwAllocationGranularity     As uinteger  
  wProcessorLevel             As ushort  
  wProcessorRevision          As ushort  
End Type

Type HW_PROFILE_INFO
  dwDockInfo      As uinteger        
  szHwProfileGuid As String * 39 - 1
  szHwProfileName As String * 80 - 1
End Type

Type NUMBERFMT
  NumDigits     As uinteger       'number of decimal digits       
  LeadingZero   As uinteger       'if leading zero in decimal fields
  Grouping      As uinteger       'group size left of decimal
  lpDecimalSep  As byte ptr       'ptr to decimal separator string
  lpThousandSep As byte ptr       'ptr to thousand separator string
  NegativeOrder As uinteger       'negative number ordering
End Type

Type CURRENCYFMT
  NumDigits           As uinteger       'number of decimal digits
  LeadingZero         As uinteger       'if leading zero in decimal fields
  Grouping            As uinteger       'group size left of decimal
  lpDecimalSep        As byte ptr       'ptr to decimal separator string
  lpThousandSep       As byte ptr       'ptr to thousand separator string
  NegativeOrder       As uinteger       'negative currency ordering
  PositiveOrder       As uinteger       'positive currency ordering
  lpCurrencySymbol    As uinteger       'ptr to currency symbol string
End Type

Type SYSTEM_POWER_STATUS
  ACLineStatus        As ubyte  
  BatteryFlag         As ubyte  
  BatteryLifePercent  As ubyte  
  Reserved1           As ubyte  
  BatteryLifeTime     As uinteger  
  BatteryFullLifeTime As uinteger  
End Type

Type SYSTEMTIME
  year    As ushort  
  month   As ushort  
  weekDay As ushort  
  day     As ushort  
  hour    As ushort  
  minute  As ushort  
  second  As ushort  
  msec    As ushort  
End Type

Type TIME_ZONE_INFORMATION
  Bias                    As Integer  		
  StandardName(0 to 30)   As ushort  	
  StandardDate            As SYSTEMTIME  	
  StandardBias            As Integer  		
  DaylightName(0 to 30)   As ushort  	
  DaylightDate            As SYSTEMTIME  	
  DaylightBias            As Integer  		
End Type

Type LDT_ENTRY
    LimitLow    As ushort  
    BaseLow     As ushort  
    HighWord    As uinteger     'Can use LDT_ubyteS Type    
End Type

Type OSVERSIONINFO
  dwOSVersionInfoSize As uinteger  
  dwMajorVersion      As uinteger  
  dwMinorVersion      As uinteger  
  dwBuildNumber       As uinteger  
  dwPlatformId        As uinteger  
  szCSDVersion        As String  * 128 - 1   'Maintenance string for PSS usage
End Type

Type MEMORYSTATUS
  dwLength        As uinteger  
  dwMemoryLoad    As uinteger  
  dwTotalPhys     As uinteger  
  dwAvailPhys     As uinteger  
  dwTotalPageFile As uinteger  
  dwAvailPageFile As uinteger  
  dwTotalVirtual  As uinteger  
  dwAvailVirtual  As uinteger  
End Type

Type MEMORYSTATUSEX
  dwLength                As uinteger
  dwMemoryLoad            As uinteger
  ullTotalPhys            As Int64
  ullAvailPhys            As Int64
  ullTotalPageFile        As Int64
  ullAvailPageFile        As Int64
  ullTotalVirtual         As Int64
  ullAvailVirtual         As Int64
  ullAvailExtendedVirtual As Int64
End Type

Type OFSTRUCT
  cBytes      As ubyte   
  fFixedDisk  As ubyte   
  nErrCode    As ushort  
  Reserved1   As ushort  
  Reserved2   As ushort  
  szPathName  As String * 128 - 1
End Type

Type KEY_EVENT_RECORD
  bKeyDown            As Integer		
  wRepeatCount        As ushort	
  wVirtualKeyCode     As ushort	
  wVirtualScanCode    As ushort	
    UNION
      UnicodeChar     As ushort	
      AsciiChar       As ubyte		
    End UNION
  dwControlKeyState   As Integer	
End Type

Type MOUSE_EVENT_RECORD
  dwMousePosition     As COORD	
  dwButtonState       As Integer	
  dwControlKeyState   As Integer	
  dwEventFlags        As Integer	
End Type

Type WINDOW_BUFFER_SIZE_RECORD
  dwSize As COORD	
End Type

Type MENU_EVENT_RECORD
    dwCommandId As uinteger	
End Type

Type FOCUS_EVENT_RECORD
    bSetFocus As Integer	
End Type

Type INPUT_RECORD
    EventType As ushort	
	UNION
        KeyEvent                As KEY_EVENT_RECORD			
        MouseEvent              As MOUSE_EVENT_RECORD		
        WindowBufferSizeEvent   As WINDOW_BUFFER_SIZE_RECORD	
        MenuEvent               As MENU_EVENT_RECORD			
        FocusEvent              As FOCUS_EVENT_RECORD		
	End UNION
End Type


Type EXCEPTION_RECORD
    ExceptionCode			        As Integer 'code for exception (see Win32 Exception Constants in this include file)	
	ExceptionFlags	                As Integer	
    pExceptionRecord                As Integer	
    ExceptionAddress                As Integer 'value of instruction pointer when exception occurred	
	NumberParameters                As Integer	
    ExceptionInformation(0 to 13)   As Integer	
End Type
'.NumberParameters = number of elements in .ExceptionInformation[]. Under some (all?)
'   conditions, the .ExceptionInformation[] array is just big enough to contain the
'   required parameters, and does not exist if .NumberParameters = 0
'Size of .ExceptionInformation[] varies; .NumberParameters = number of elements
' (maximum Const EXCEPTION_MAXIMUM_PARAMETERS)



Type EXCEPTION_POINTERS
    lpExceptionRecord   As Integer 
    lpContextRecord     As Integer 
End Type

Type FLOATING_SAVE_AREA '112 bytes, saves the state of the FPU
    ControlWord             As Integer 
    StatusWord              As Integer 
    TagWord                 As Integer 
    ErrorOffset             As Integer 
    ErrorSelector           As Integer 
    DataOffset              As Integer 
    DataSelector            As Integer 
    RegisterArea(0 to 78)   As ubyte 
    Cr0NpxState             As Integer 
End Type

Type CONTEXT  '204 bytes                  dec  hex offsets from beginning of structure
  ContextFlags    As Integer             '000, &H00 	
  Dr0             As Integer             '004, &H04	
  Dr1             As Integer             '008, &H08
  Dr2             As Integer             '012, &H0C
  Dr3             As Integer             '016, &H10
  Dr6             As Integer             '020, &H14
  Dr7             As Integer             '024, &H18
  FloatSave       As FLOATING_SAVE_AREA  '028, &H1C
  SegGs           As Integer		 '140, &H8C
  SegFs           As Integer	         '144, &H90
  SegEs           As Integer	         '148, &H94
  SegDs           As Integer	         '152, &H98
  Edi             As Integer	         '156, &H9C
  Esi             As Integer	         '160, &HA0
  Ebx             As Integer	         '164, &HA4
  Edx             As Integer	         '168, &HA8
  Ecx             As Integer	         '172, &HAC
  Eax             As Integer	         '176, &HB0
  Ebp             As Integer	         '180, &HB4
  Eip             As Integer	         '184, &HB8
  SegCs           As Integer		 '188, &HBC
  EFlags          As Integer             '192, &HC0
  Esp             As Integer             '196, &HC4
  SegSs           As Integer             '200, &HC8
End Type

Type BY_HANDLE_FILE_INFORMATION
  dwFileAttributes     As Integer
  ftCreationTime       As FILETIME
  ftLastAccessTime     As FILETIME
  ftLastWriteTime      As FILETIME
  dwVolumeSerialNumber As Integer
  nFileSizeHigh        As Integer
  nFileSizeLow         As Integer
  nNumberOfLinks       As Integer
  nFileIndexHigh       As Integer
  nFileIndexLow        As Integer
End Type

'The following is used by the WaitForDebugEvent API call.

Type EXCEPTION_DEBUG_INFO
  pExceptionRecord As EXCEPTION_RECORD
  dwFirstChance As Integer
End Type

Type CREATE_THREAD_DEBUG_INFO
  hThread           As Integer
  lpThreadLocalBase As Integer
  lpStartAddress    As Integer
End Type

Type CREATE_PROCESS_DEBUG_INFO
  hFile                 As Integer
  hProcess              As Integer
  hThread               As Integer
  lpBaseOfImage         As Integer
  dwDebugInfoFileOffset As Integer
  nDebugInfoSize        As Integer
  lpThreadLocalBase     As Integer
  lpStartAddress        As Integer
  lpImageName           As Integer
  fUnicode              As Short
End Type

Type EXIT_THREAD_DEBUG_INFO
  dwExitCode As Integer
End Type

Type EXIT_PROCESS_DEBUG_INFO
  dwExitCode As Integer
End Type

Type LOAD_DLL_DEBUG_INFO
  hFile                 As Integer
  lpBaseOfDll           As Integer
  dwDebugInfoFileOffset As Integer
  nDebugInfoSize        As Integer
  lpImageName           As Integer
  fUnicode              As Short
End Type

Type UNLOAD_DLL_DEBUG_INFO
  lpBaseOfDll As Integer
End Type

Type OUTPUT_DEBUG_STRING_INFO
  lpDebugStringData  As byte ptr
  fUnicode           As Short
  nDebugStringLength As Short
End Type

Type RIP_INFO
  dwError As Integer
  dwType  As Integer
End Type

Type DEBUG_EVENT
  dwDebugEventCode As Integer
  dwProcessId As Integer
  dwThreadId As Integer
  Union
    Exception         As EXCEPTION_DEBUG_INFO
    CreateThread      As CREATE_THREAD_DEBUG_INFO
    CreateProcessInfo As CREATE_PROCESS_DEBUG_INFO
    ExitThread        As EXIT_THREAD_DEBUG_INFO
    ExitProcess       As EXIT_PROCESS_DEBUG_INFO
    LoadDll           As LOAD_DLL_DEBUG_INFO
    UnloadDll         As UNLOAD_DLL_DEBUG_INFO
    DebugString       As OUTPUT_DEBUG_STRING_INFO
    RipInfo           As RIP_INFO
  End Union
End Type  

Type MEMORY_BASIC_INFORMATION
  BaseAddress       As Integer
  AllocationBase    As Integer
  AllocationProtect As Integer
  RegionSize        As Integer
  State             As Integer
  Protect           As Integer
  lType             As Integer
End Type

'-----------------
'| API FunctionS |
'-----------------

Declare Function AddAtom Lib "kernel32" Alias "AddAtomA" (ByVal lpString As String) As Integer
Declare Function AllocConsole Lib "kernel32" () As Integer
Declare Function AreFileApisANSI Lib "kernel32" () As Integer

Declare Function BackupRead Lib "kernel32" (ByVal hFile As Integer, lpBuffer As BYTE, ByVal nNumberOfBytesToRead As Integer, lpNumberOfBytesRead As Integer, ByVal bAbort As Integer, ByVal bProcessSecurity As Integer, lpContext As ANY) As Integer
Declare Function BackupSeek Lib "kernel32" (ByVal hFile As Integer, ByVal dwLowBytesToSeek As Integer, ByVal dwHighBytesToSeek As Integer, lpdwLowByteSeeked As Integer, lpdwHighByteSeeked As Integer, lpContext As Integer) As Integer
Declare Function BackupWrite Lib "kernel32" (ByVal hFile As Integer, lpBuffer As BYTE, ByVal nNumberOfBytesToWrite As Integer, lpNumberOfBytesWritten As Integer, ByVal bAbort As Integer, ByVal bProcessSecurity As Integer, lpContext As Integer) As Integer
'Declare Function Beep Lib "kernel32" (ByVal dwFreq As Integer, ByVal dwDuration As Integer) As Integer
Declare Function BeginUpdateResource Lib "kernel32" Alias "BeginUpdateResourceA" (ByVal pFileName As String, ByVal bDeleteExistingResources As Integer) As Integer
Declare Function BuildCommDCB Lib "kernel32" Alias "BuildCommDCBA" (ByVal lpDef As String, lpDCB As DCB) As Integer
Declare Function BuildCommDCBAndTimeouts Lib "kernel32" Alias "BuildCommDCBAndTimeoutsA" (ByVal lpDef As String, lpDCB As DCB, lpCommTimeouts As COMMTIMEOUTS) As Integer

Declare Function CallNamedPipe Lib "kernel32" Alias "CallNamedPipeA" (ByVal lpNamedPipeName As String, lpInBuffer As ANY, ByVal nInBufferSize As Integer, lpOutBuffer As ANY, ByVal nOutBufferSize As Integer, lpBytesRead As Integer, ByVal nTimeOut As Integer) As Integer
Declare Function ClearCommBreak Lib "kernel32" (ByVal nCid As Integer) As Integer
Declare Function ClearCommError Lib "kernel32" (ByVal hFile As Integer, lpErrors As Integer, lpStat As COMSTAT) As Integer
Declare Function CloseHandle Lib "kernel32" (ByVal hObject As Integer) As Integer
Declare Function CommConfigDialog Lib "kernel32" Alias "CommConfigDialogA" (ByVal lpszName As String, ByVal hwnd As Integer, lpCC As COMMCONFIG) As Integer
Declare Function CompareFileTime Lib "kernel32" (lpFileTime1 As FILETIME, lpFileTime2 As FILETIME) As Integer
Declare Function CompareString Lib "kernel32" Alias "CompareStringA" (ByVal Locale As Integer, ByVal dwCmpFlags As Integer, ByVal lpString1 As String, ByVal cchCount1 As Integer, ByVal lpString2 As String, ByVal cchCount2 As Integer) As Integer
Declare Function ConnectNamedPipe Lib "kernel32" (ByVal hNamedPipe As Integer, lpOverlapped As OVERLAPPED) As Integer
Declare Function ContinueDebugEvent Lib "kernel32" (ByVal dwProcessId As Integer, ByVal dwThreadId As Integer, ByVal dwContinueStatus As Integer) As Integer
Declare Function ConvertDefaultLocale Lib "kernel32" (ByVal Locale As Integer) As Integer
Declare Function CopyFile Lib "kernel32" Alias "CopyFileA" (ByVal lpExistingFileName As String, ByVal lpNewFileName As String, ByVal bFailIfExists As Integer) As Integer
Declare Function CreateConsoleScreenBuffer Lib "kernel32" (ByVal dwDesiredAccess As Integer, ByVal dwShareMode As Integer, lpSecurityAttributes As SECURITY_ATTRIBUTES, ByVal dwFlags As Integer, ByVal lpScreenBufferData As Integer) As Integer
Declare Function CreateDirectory Lib "kernel32" Alias "CreateDirectoryA" (ByVal lpPathName As String, lpSecurityAttributes As SECURITY_ATTRIBUTES) As Integer
Declare Function CreateDirectoryEx Lib "kernel32" Alias "CreateDirectoryExA" (ByVal lpTemplateDirectory As String, ByVal lpNewDirectory As String, lpSecurityAttributes As SECURITY_ATTRIBUTES) As Integer
Declare Function CreateEvent Lib "kernel32" Alias "CreateEventA" (lpEventAttributes As SECURITY_ATTRIBUTES, ByVal bManualReset As Integer, ByVal bInitialState As Integer, ByVal lpName As String) As Integer
Declare Function CreateFile Lib "kernel32" Alias "CreateFileA" (ByVal lpFileName As String, ByVal dwDesiredAccess As Integer, ByVal dwShareMode As Integer, lpSecurityAttributes As SECURITY_ATTRIBUTES, ByVal dwCreationDisposition As Integer, ByVal dwFlagsAndAttributes As Integer, ByVal hTemplateFile As Integer) As Integer
Declare Function CreateFileMapping Lib "kernel32" Alias "CreateFileMappingA" (ByVal hFile As Integer, lpFileMappigAttributes As SECURITY_ATTRIBUTES, ByVal flProtect As Integer, ByVal dwMaximumSizeHigh As Integer, ByVal dwMaximumSizeLow As Integer, ByVal lpName As String) As Integer
Declare Function CreateIoCompletionPort Lib "kernel32" (ByVal FileHandle As Integer, ByVal ExistingCompletionPort As Integer, ByVal CompletionKey As Integer, ByVal NumberOfConcurrentThreads As Integer) As Integer
Declare Function CreateMailslot Lib "kernel32" Alias "CreateMailslotA" (ByVal lpName As String, ByVal nMaxMessageSize As Integer, ByVal lReadTimeout As Integer, lpSecurityAttributes As SECURITY_ATTRIBUTES) As Integer
Declare Function CreateMutex Lib "kernel32" Alias "CreateMutexA" (lpMutexAttributes As SECURITY_ATTRIBUTES, ByVal bInitialOwner As Integer, ByVal lpName As String) As Integer
Declare Function CreateNamedPipe Lib "kernel32" Alias "CreateNamedPipeA" (ByVal lpName As String, ByVal dwOpenMode As Integer, ByVal dwPipeMode As Integer, ByVal nMaxInstances As Integer, ByVal nOutBufferSize As Integer, ByVal nInBufferSize As Integer, ByVal nDefaultTimeOut As Integer, lpSecurityAttributes As SECURITY_ATTRIBUTES) As Integer
Declare Function CreatePipe Lib "kernel32" (phReadPipe As Integer, phWritePipe As Integer, lpPipeAttributes As SECURITY_ATTRIBUTES, ByVal nSize As Integer) As Integer
Declare Function CreateProcess Lib "kernel32" Alias "CreateProcessA" (ByVal lpApplicationName As String, ByVal lpCommandLine As String, lpProcessAttributes As SECURITY_ATTRIBUTES, lpThreadAttributes As SECURITY_ATTRIBUTES, ByVal bInheritHandles As Integer, ByVal dwCreationFlags As Integer, lpEnvironment As ANY, ByVal lpCurrentDriectory As String, lpStartupInfo As STARTUPINFO, lpProcessInformation As PROCESS_INFORMATION) As Integer
Declare Function CreateProcessAsUser Lib "kernel32" Alias "CreateProcessAsUserA" (ByVal hToken As Integer, ByVal lpApplicationName As String, ByVal lpCommandLine As String, lpProcessAttributes As SECURITY_ATTRIBUTES, lpThreadAttributes As SECURITY_ATTRIBUTES, ByVal bInheritHandles As Integer, ByVal dwCreationFlags As Integer, ByVal lpEnvironment As String, ByVal lpCurrentDirectory As String, lpStartupInfo As STARTUPINFO, lpProcessInformation As PROCESS_INFORMATION) As Integer
Declare Function CreateRemoteThread Lib "kernel32" (ByVal hProcess As Integer, lpThreadAttributes As SECURITY_ATTRIBUTES, ByVal dwStackSize As Integer, ByVal lpStartAddress As Integer, lpParameter As ANY, ByVal dwCreationFlags As Integer, lpThreadId As Integer) As Integer
Declare Function CreateSemaphore Lib "kernel32" Alias "CreateSemaphoreA" (lpSemaphoreAttributes As SECURITY_ATTRIBUTES, ByVal lInitialCount As Integer, ByVal lMaximumCount As Integer, ByVal lpName As String) As Integer
Declare Function CreateTapePartition Lib "kernel32" (ByVal hDevice As Integer, ByVal dwPartitionMethod As Integer, ByVal dwCount As Integer, ByVal dwSize As Integer) As Integer
Declare Function CreateThread Lib "kernel32" (lpThreadAttributes As SECURITY_ATTRIBUTES, ByVal dwStackSize As Integer, ByVal StartAddress As Integer, ByVal lpParameter As Integer, ByVal dwCreationFlags As Integer, lpThreadId As Integer) As Integer

Declare Function DebugActiveProcess Lib "kernel32" (ByVal dwProcessId As Integer) As Integer
Declare Sub DebugBreak Lib "kernel32" ()
Declare Function DefineDosDevice Lib "kernel32" Alias "DefineDosDeviceA" (ByVal dwFlags As Integer, ByVal lpDeviceName As String, ByVal lpTargetPath As String) As Integer
Declare Function DeleteAtom Lib "kernel32" (ByVal nAtom As Integer) As Integer
Declare Sub DeleteCriticalSection Lib "kernel32" (lpCriticalSection As CRITICAL_SECTION)
Declare Function DeleteFile Lib "kernel32" Alias "DeleteFileA" (ByVal lpFileName As String) As Integer
Declare Function DeviceIoControl Lib "kernel32" (ByVal hDevice As Integer, ByVal dwIoControlCode As Integer, lpInBuffer As ANY, ByVal nInBufferSize As Integer, lpOutBuffer As ANY, ByVal nOutBufferSize As Integer, lpBytesReturned As Integer, lpOverlapped As OVERLAPPED) As Integer
Declare Function DisableThreadLibraryCalls Lib "kernel32" (ByVal hLibModule As Integer) As Integer
Declare Function DisconnectNamedPipe Lib "kernel32" (ByVal hNamedPipe As Integer) As Integer
Declare Function DosDateTimeToFileTime Lib "kernel32" (ByVal wFatDate As Integer, ByVal wFatTime As Integer, lpFileTime As FILETIME) As Integer
Declare Function DuplicateHandle Lib "kernel32" (ByVal hSourceProcessHandle As Integer, ByVal hSourceHandle As Integer, ByVal hTargetProcessHandle As Integer, lpTargetHandle As Integer, ByVal dwDesiredAccess As Integer, ByVal bInheritHandle As Integer, ByVal dwOptions As Integer) As Integer

Declare Function EndUpdateResource Lib "kernel32" Alias "EndUpdateResourceA" (ByVal hUpdate As Integer, ByVal fDiscard As Integer) As Integer
Declare Sub EnterCriticalSection Lib "kernel32" (lpCriticalSection As CRITICAL_SECTION)
Declare Function EnumCalendarInfo Lib "kernel32" Alias "EnumCalendarInfoA" (ByVal lpCalInfoEnumProc As Integer, ByVal Locale As Integer, ByVal Calendar As Integer, ByVal CalType As Integer) As Integer
Declare Function EnumDateFormats Lib "kernel32" (ByVal lpDateFmtEnumProc As Integer, ByVal Locale As Integer, ByVal dwFlags As Integer) As Integer
Declare Function EnumResourceLanguages Lib "kernel32" Alias "EnumResourceLanguagesA" (ByVal hModule As Integer, ByVal lpType As String, ByVal lpName As String, ByVal lpEnumFunc As Integer, ByVal lParam As Integer) As Integer
Declare Function EnumResourceNames Lib "kernel32" Alias "EnumResourceNamesA" (ByVal hModule As Integer, ByVal lpType As String, ByVal lpEnumFunc As Integer, ByVal lParam As Integer) As Integer
Declare Function EnumResourceTypes Lib "kernel32" Alias "EnumResourceTypesA" (ByVal hModule As Integer, ByVal lpEnumFunc As Integer, ByVal lParam As Integer) As Integer
Declare Function EnumSystemCodePages Lib "kernel32" (ByVal lpCodePageEnumProc As Integer, ByVal dwFlags As Integer) As Integer
Declare Function EnumSystemLocales Lib "kernel32" (ByVal lpLocaleEnumProc As Integer, ByVal dwFlags As Integer) As Integer
Declare Function EnumTimeFormats Lib "kernel32" Alias "EnumTimeFormats" (ByVal lpTimeFmtEnumProc As Integer, ByVal Locale As Integer, ByVal dwFlags As Integer) As Integer
Declare Function EraseTape Lib "kernel32" Alias "EraseTape" (ByVal hDevice As Integer, ByVal dwEraseType As Integer, ByVal bimmediate As Integer) As Integer
Declare Function EscapeCommFunction Lib "kernel32" (ByVal nCid As Integer, ByVal nFunc As Integer) As Integer
Declare Sub ExitProcess Lib "kernel32" (ByVal uExitCode As Integer)
Declare Sub ExitThread Lib "kernel32" (ByVal dwExitCode As Integer)
Declare Function ExpandEnvironmentStrings Lib "kernel32" Alias "ExpandEnvironmentStringsA" (ByVal lpSrc As String, ByVal lpDst As String, ByVal nSize As Integer) As Integer

Declare Sub FatalAppExit Lib "kernel32" Alias "FatalAppExitA" (ByVal uAction As Integer, ByVal lpMessageText As String)
Declare Sub FatalExit Lib "kernel32" (ByVal code As Integer)
Declare Function FileTimeToDosDateTime Lib "kernel32" (lpFileTime As FILETIME, lpFatDate As SHORT, lpFatTime As SHORT) As Integer
Declare Function FileTimeToLocalFileTime Lib "kernel32" (lpFileTime As FILETIME, lpLocalFileTime As FILETIME) As Integer
Declare Function FileTimeToSystemTime Lib "kernel32" (lpFileTime As FILETIME, lpSystemTime As SYSTEMTIME) As Integer
Declare Function FillConsoleOutputAttribute Lib "kernel32" (ByVal hConsoleOutput As Integer, ByVal dwAttribute As Integer, ByVal nLength As Integer, ByVal dwWriteCoord As Integer, lpNumberOfAttrsWritten As Integer) As Integer
Declare Function FillConsoleOutputCharacter Lib "kernel32" Alias "FillConsoleOutputCharacterA" (ByVal hConsoleOutput As Integer, ByVal szCharacter As String, ByVal nLength As Integer, ByVal dwWriteCoord As Integer, lpNumberOfCharsWritten As Integer) As Integer
Declare Function FindAtom Lib "kernel32" Alias "FindAtomA" (ByVal lpString As String) As Integer
Declare Function FindClose Lib "kernel32" (ByVal hFindFile As Integer) As Integer
Declare Function FindCloseChangeNotification Lib "kernel32" (ByVal hChangeHandle As Integer) As Integer
Declare Function FindFirstChangeNotification Lib "kernel32" Alias "FindFirstChangeNotificationA" (ByVal lpPathName As String, ByVal bWatchSubtree As Integer, ByVal dwNotifyFilter As Integer) As Integer
Declare Function FindFirstFile Lib "kernel32" Alias "FindFirstFileA" (ByVal lpFileName As String, lpFindFileData As WIN32_FIND_DATA) As Integer
Declare Function FindNextChangeNotification Lib "kernel32" (ByVal hChangeHandle As Integer) As Integer
Declare Function FindNextFile Lib "kernel32" Alias "FindNextFileA" (ByVal hFindFile As Integer, lpFindFileData As WIN32_FIND_DATA) As Integer
Declare Function FindResource Lib "kernel32" Alias "FindResourceA" (ByVal hInstance As Integer, ByVal lpName As String, ByVal lpType As String) As Integer
Declare Function FindResourceEx Lib "kernel32" Alias "FindResourceExA" (ByVal hModule As Integer, ByVal lpType As String, ByVal lpName As String, ByVal wLanguage As Integer) As Integer
Declare Function FlushConsoleInputBuffer Lib "kernel32" (ByVal hConsoleInput As Integer) As Integer
Declare Function FlushFileBuffers Lib "kernel32" (ByVal hFile As Integer) As Integer
Declare Function FlushInstructionCache Lib "kernel32" (ByVal hProcess As Integer, lpBaseAddress As ANY, ByVal dwSize As Integer) As Integer
Declare Function FlushViewOfFile Lib "kernel32" (lpBaseAddress As ANY, ByVal dwNumberOfBytesToFlush As Integer) As Integer
Declare Function FoldString Lib "kernel32" Alias "FoldStringA" (ByVal dwMapFlags As Integer, ByVal lpSrcStr As String, ByVal cchSrc As Integer, ByVal lpDestStr As String, ByVal cchDest As Integer) As Integer
Declare Function FormatMessage Lib "kernel32" Alias "FormatMessageA" (ByVal dwFlags As Integer, lpSource As ANY, ByVal dwMessageId As Integer, ByVal dwLanguageId As Integer, ByVal lpBuffer As String, ByVal nSize As Integer, Arguments As Integer) As Integer
Declare Function FreeConsole Lib "kernel32" () As Integer
Declare Function FreeEnvironmentStrings Lib "kernel32" Alias "FreeEnvironmentStringsA" (ByVal lpsz As String) As Integer
Declare Function FreeLibrary Lib "kernel32" (ByVal hLibModule As Integer) As Integer
Declare Sub FreeLibraryAndExitThread Lib "kernel32" (ByVal hLibModule As Integer, ByVal dwExitCode As Integer)
Declare Function FreeResource Lib "kernel32" (ByVal hResData As Integer) As Integer

Declare Function GenerateConsoleCtrlEvent Lib "kernel32" (ByVal dwCtrlEvent As Integer, ByVal dwProcessGroupId As Integer) As Integer
Declare Function GetACP Lib "kernel32" () As Integer
Declare Function GetAtomName Lib "kernel32" Alias "GetAtomNameA" (ByVal nAtom As Integer, ByVal lpBuffer As String, ByVal nSize As Integer) As Integer
Declare Function GetBinaryType Lib "kernel32" Alias "GetBinaryTypeA" (ByVal lpApplicationName As String, lpBinaryType As Integer) As Integer
Declare Function GetCPInfo Lib "kernel32" (ByVal CodePage As Integer, lpCPInfo As CPINFO) As Integer
Declare Function GetCommConfig Lib "kernel32" (ByVal hCommDev As Integer, lpCC As COMMCONFIG, lpdwSize As Integer) As Integer
Declare Function GetCommMask Lib "kernel32" (ByVal hFile As Integer, lpEvtMask As Integer) As Integer
Declare Function GetCommModemStatus Lib "kernel32" (ByVal hFile As Integer, lpModemStat As Integer) As Integer
Declare Function GetCommProperties Lib "kernel32" (ByVal hFile As Integer, lpCommProp As COMMPROP) As Integer
Declare Function GetCommState Lib "kernel32" (ByVal nCid As Integer, lpDCB As DCB) As Integer
Declare Function GetCommTimeouts Lib "kernel32" (ByVal hFile As Integer, lpCommTimeouts As COMMTIMEOUTS) As Integer
Declare Function GetCommandLine Lib "kernel32" Alias "GetCommandLineA" () As Integer
Declare Function GetCompressedFileSize Lib "kernel32" Alias "GetCompressedFileSizeA" (ByVal lpFileName As String, lpFileSizeHigh As Integer) As Integer
Declare Function GetComputerName Lib "kernel32" Alias "GetComputerNameA" (ByVal lpBuffer As String, nSize As Integer) As Integer
Declare Function GetConsoleCP Lib "kernel32" () As Integer
Declare Function GetConsoleCursorInfo Lib "kernel32" (ByVal hConsoleOutput As Integer, lpConsoleCursorInfo As CONSOLE_CURSOR_INFO) As Integer
Declare Function GetConsoleMode Lib "kernel32" (ByVal hConsoleHandle As Integer, lpMode As Integer) As Integer
Declare Function GetConsoleOutputCP Lib "kernel32" () As Integer
Declare Function GetConsoleScreenBufferInfo Lib "kernel32" (ByVal hConsoleOutput As Integer, lpConsoleScreenBufferInfo As CONSOLE_SCREEN_BUFFER_INFO) As Integer
Declare Function GetConsoleTitle Lib "kernel32" Alias "GetConsoleTitleA" (ByVal lpConsoleTitle As String, ByVal nSize As Integer) As Integer
Declare Function GetCurrencyFormat Lib "kernel32" Alias "GetCurrencyFormatA" (ByVal Locale As Integer, ByVal dwFlags As Integer, ByVal lpValue As String, lpFormat As CURRENCYFMT, ByVal lpCurrencyStr As String, ByVal cchCurrency As Integer) As Integer
Declare Function GetCurrentDirectory Lib "kernel32" Alias "GetCurrentDirectoryA" (ByVal nBufferLength As Integer, ByVal lpBuffer As String) As Integer
Declare Function GetCurrentProcess Lib "kernel32" () As Integer
Declare Function GetCurrentProcessId Lib "kernel32" () As Integer
Declare Function GetCurrentThread Lib "kernel32" () As Integer
Declare Function GetCurrentThreadId Lib "kernel32" () As Integer
Declare Function GetDateFormat Lib "kernel32" Alias "GetDateFormatA" (ByVal Locale As Integer, ByVal dwFlags As Integer, lpDate As SYSTEMTIME, ByVal lpFormat As String, ByVal lpDateStr As String, ByVal cchDate As Integer) As Integer
Declare Function GetDefaultCommConfig Lib "kernel32" Alias "GetDefaultCommConfigA" (ByVal lpszName As String, lpCC As COMMCONFIG, lpdwSize As Integer) As Integer
Declare Function GetDiskFreeSpace Lib "kernel32" Alias "GetDiskFreeSpaceA" (ByVal lpRootPathName As String, lpSectorsPerCluster As Integer, lpBytesPerSector As Integer, lpNumberOfFreeClusters As Integer, lpTotalNumberOfClusters As Integer) As Integer
Declare Function GetDiskFreeSpaceEx Lib "kernel32" Alias "GetDiskFreeSpaceExA" (ByVal lpPathName As String, lpFreeBytesAvailableToCaller As INT64, lpTotalNumberOfBytes As INT64, lpTotalNumberOfFreeBytes As INT64) As Integer
Declare Function GetDriveType Lib "kernel32" Alias "GetDriveTypeA" (ByVal nDrive As String) As Integer
Declare Function GetEnvironmentStrings Lib "kernel32" Alias "GetEnvironmentStringsA" () As Integer
Declare Function GetEnvironmentVariable Lib "kernel32" Alias "GetEnvironmentVariableA" (ByVal lpName As String, ByVal lpBuffer As String, ByVal nSize As Integer) As Integer
Declare Function GetExitCodeProcess Lib "kernel32" (ByVal hProcess As Integer, lpExitCode As Integer) As Integer
Declare Function GetExitCodeThread Lib "kernel32" (ByVal hThread As Integer, lpExitCode As Integer) As Integer
Declare Function GetFileAttributes Lib "kernel32" Alias "GetFileAttributesA" (ByVal lpFileName As String) As Integer
Declare Function GetFileInformationByHandle Lib "kernel32" Alias "GetFileInformationByHandle" (ByVal hFile As Integer, lpFileInformation As BY_HANDLE_FILE_INFORMATION) As Integer
Declare Function GetFileSize Lib "kernel32" (ByVal hFile As Integer, lpFileSizeHigh As Integer) As Integer
Declare Function GetFileTime Lib "kernel32" (ByVal hFile As Integer, lpCreationTime As FILETIME, lpLastAccessTime As FILETIME, lpLastWriteTime As FILETIME) As Integer
Declare Function GetFileType Lib "kernel32" (ByVal hFile As Integer) As Integer
Declare Function GetFullPathName Lib "kernel32" Alias "GetFullPathNameA" (ByVal lpFileName As String, ByVal nBufferLength As Integer, ByVal lpBuffer As String, ByVal lpFilePart As Integer) As Integer
Declare Function GetHandleInformation Lib "kernel32" (ByVal hObject As Integer, lpdwFlags As Integer) As Integer
Declare Function GetLargestConsoleWindowSize Lib "kernel32" (ByVal hConsoleOutput As Integer) As Integer
Declare Function GetLastError Lib "kernel32" () As Integer
Declare Function GetLocaleInfo Lib "kernel32" Alias "GetLocaleInfoA" (ByVal Locale As Integer, ByVal LCType As Integer, ByVal lpLCData As String, ByVal cchData As Integer) As Integer
Declare Sub GetLocalTime Lib "kernel32" (lpSystemTime As SYSTEMTIME)
Declare Function GetLogicalDriveStrings Lib "kernel32" Alias "GetLogicalDriveStringsA" (ByVal nBufferLength As Integer, lpBuffer As ANY) As Integer
Declare Function GetLogicalDrives Lib "kernel32" () As Integer
Declare Function GetMailslotInfo Lib "kernel32" (ByVal hMailslot As Integer, lpMaxMessageSize As Integer, lpNextSize As Integer, lpMessageCount As Integer, lpReadTimeout As Integer) As Integer
Declare Function GetModuleFileName Lib "kernel32" Alias "GetModuleFileNameA" (ByVal hModule As Integer, ByVal lpFileName As String, ByVal nSize As Integer) As Integer
Declare Function GetModuleHandle Lib "kernel32" Alias "GetModuleHandleA" (ByVal lpModuleName As String) As Integer
Declare Function GetNamedPipeHandleState Lib "kernel32" Alias "GetNamedPipeHandleStateA" (ByVal hNamedPipe As Integer, lpState As Integer, lpCurInstances As Integer, lpMaxCollectionCount As Integer, lpCollectDataTimeout As Integer, ByVal lpUserName As String, ByVal nMaxUserNameSize As Integer) As Integer
Declare Function GetNamedPipeInfo Lib "kernel32" (ByVal hNamedPipe As Integer, lpFlags As Integer, lpOutBufferSize As Integer, lpInBufferSize As Integer, lpMaxInstances As Integer) As Integer
Declare Function GetNumberFormat Lib "kernel32" Alias "GetNumberFormatA" (ByVal Locale As Integer, ByVal dwFlags As Integer, ByVal lpValue As String, lpFormat As NUMBERFMT, ByVal lpNumberStr As String, ByVal cchNumber As Integer) As Integer
Declare Function GetNumberOfConsoleInputEvents Lib "kernel32" (ByVal hConsoleInput As Integer, lpNumberOfEvents As Integer) As Integer
Declare Function GetNumberOfConsoleMouseButtons Lib "kernel32" (lpNumberOfMouseButtons As Integer) As Integer
Declare Function GetOEMCP Lib "kernel32" () As Integer
Declare Function GetOverlappedResult Lib "kernel32" (ByVal hFile As Integer, lpOverlapped As OVERLAPPED, lpNumberOfBytesTransferred As Integer, ByVal bWait As Integer) As Integer
Declare Function GetPriorityClass Lib "kernel32" (ByVal hProcess As Integer) As Integer
Declare Function GetPrivateProfileInt Lib "kernel32" Alias "GetPrivateProfileIntA" (ByVal lpApplicationName As String, ByVal lpKeyName As String, ByVal nDefault As Integer, ByVal lpFileName As String) As Integer
Declare Function GetPrivateProfileSection Lib "kernel32" Alias "GetPrivateProfileSectionA" (ByVal lpAppName As String, ByVal lpReturnedString As String, ByVal nSize As Integer, ByVal lpFileName As String) As Integer
Declare Function GetPrivateProfileSectionNames Lib "kernel32" Alias "GetPrivateProfileSectionNamesA" (ByVal lpszReturnBuffer As String, ByVal nSize As Integer, ByVal lpFileName As String) As Integer
Declare Function GetPrivateProfileString Lib "kernel32" Alias "GetPrivateProfileStringA" (ByVal lpApplicationName As String, ByVal lpKeyName As String, ByVal lpDefault As String, ByVal lpReturnedString As String, ByVal nSize As Integer, ByVal lpFileName As String) As Integer
Declare Function GetProcAddress Lib "kernel32" (ByVal hModule As Integer, ByVal lpProcName As String) As Integer
Declare Function GetProcessAffinityMask Lib "kernel32" (ByVal hProcess As Integer, lpProcessAffinityMask As Integer, SystemAffinityMask As Integer) As Integer
Declare Function GetProcessHeap Lib "kernel32" () As Integer
Declare Function GetProcessHeaps Lib "kernel32" (ByVal NumberOfHeaps As Integer, ProcessHeaps As Integer) As Integer
Declare Function GetProcessShutdownParameters Lib "kernel32" (lpdwLevel As Integer, lpdwFlags As Integer) As Integer
Declare Function GetProcessTimes Lib "kernel32" (ByVal hProcess As Integer, lpCreationTime As FILETIME, lpExitTime As FILETIME, lpKernelTime As FILETIME, lpUserTime As FILETIME) As Integer
Declare Function GetProcessWorkingSetSize Lib "kernel32" (ByVal hProcess As Integer, lpMinimumWorkingSetSize As Integer, lpMaximumWorkingSetSize As Integer) As Integer
Declare Function GetProfileInt Lib "kernel32" Alias "GetProfileIntA" (ByVal lpAppName As String, ByVal lpKeyName As String, ByVal nDefault As Integer) As Integer
Declare Function GetProfileSection Lib "kernel32" Alias "GetProfileSectionA" (ByVal lpAppName As String, ByVal lpReturnedString As String, ByVal nSize As Integer) As Integer
Declare Function GetProfileString Lib "kernel32" Alias "GetProfileStringA" (ByVal lpAppName As String, ByVal lpKeyName As String, ByVal lpDefault As String, ByVal lpReturnedString As String, ByVal nSize As Integer) As Integer
Declare Function GetQueuedCompletionStatus Lib "kernel32" (ByVal CompletionPort As Integer, lpNumberOfBytesTransferred As Integer, lpCompletionKey As Integer, lpOverlapped As Integer, ByVal dwMilliseconds As Integer) As Integer
Declare Function GetShortPathName Lib "kernel32" Alias "GetShortPathNameA" (ByVal lpszLongPath As String, ByVal lpszShortPath As String, ByVal cchBuffer As Integer) As Integer
Declare Sub GetStartupInfo Lib "kernel32" Alias "GetStartupInfoA" (lpStartupInfo As STARTUPINFO)
Declare Function GetStdHandle Lib "kernel32" (ByVal nStdHandle As Integer) As Integer
Declare Function GetStringTypeA Lib "kernel32" (ByVal lcid As Integer, ByVal dwInfoType As Integer, ByVal lpSrcStr As String, ByVal cchSrc As Integer, lpCharType As Integer) As Integer
Declare Function GetStringTypeEx Lib "kernel32" (ByVal Locale As Integer, ByVal dwInfoType As Integer, ByVal lpSrcStr As String, ByVal cchSrc As Integer, lpCharType As Integer) As Integer
Declare Function GetStringTypeW Lib "kernel32" (ByVal dwInfoType As Integer, ByVal lpSrcStr As String, ByVal cchSrc As Integer, lpCharType As Integer) As Integer
Declare Function GetSystemDefaultLCID Lib "kernel32" () As Integer
Declare Function GetSystemDefaultLangID Lib "kernel32" () As Integer
Declare Function GetSystemDirectory Lib "kernel32" Alias "GetSystemDirectoryA" (ByVal lpBuffer As String, ByVal nSize As Integer) As Integer
Declare Sub GetSystemInfo Lib "kernel32" (lpSystemInfo As SYSTEM_INFO)
Declare Function GetSystemPowerStatus Lib "kernel32" (lpSystemPowerStatus As SYSTEM_POWER_STATUS) As Integer
Declare Sub GetSystemTime Lib "kernel32" (lpSystemTime As SYSTEMTIME)
Declare Function GetSystemTimeAdjustment Lib "kernel32" (lpTimeAdjustment As Integer, lpTimeIncrement As Integer, lpTimeAdjustmentDisabled As Integer) As Integer
Declare Sub GetSystemTimeAsFileTime Lib "kernel32" (lpFileTime As FILETIME)
Declare Function GetTapeParameters Lib "kernel32" (ByVal hDevice As Integer, ByVal dwOperation As Integer, lpdwSize As Integer, lpTapeInformation As ANY) As Integer
Declare Function GetTapePosition Lib "kernel32" (ByVal hDevice As Integer, ByVal dwPositionType As Integer, lpdwPartition As Integer, lpdwOffsetLow As Integer, lpdwOffsetHigh As Integer) As Integer
Declare Function GetTapeStatus Lib "kernel32" (ByVal hDevice As Integer) As Integer
Declare Function GetTempFileName Lib "kernel32" Alias "GetTempFileNameA" (ByVal lpszPath As String, ByVal lpPrefixString As String, ByVal wUnique As Integer, ByVal lpTempFileName As String) As Integer
Declare Function GetTempPath Lib "kernel32" Alias "GetTempPathA" (ByVal nBufferLength As Integer, ByVal lpBuffer As String) As Integer
Declare Function GetThreadContext Lib "kernel32" (ByVal hThread As Integer, lpContext As CONTEXT) As Integer
Declare Function GetThreadLocale Lib "kernel32" () As Integer
Declare Function GetThreadPriority Lib "kernel32" (ByVal hThread As Integer) As Integer
Declare Function GetThreadSelectorEntry Lib "kernel32" (ByVal hThread As Integer, ByVal dwSelector As Integer, lpSelectorEntry As LDT_ENTRY) As Integer
Declare Function GetThreadTimes Lib "kernel32" (ByVal hThread As Integer, lpCreationTime As FILETIME, lpExitTime As FILETIME, lpKernelTime As FILETIME, lpUserTime As FILETIME) As Integer
Declare Function GetTickCount Lib "kernel32" () As Integer
Declare Function GetTimeFormat Lib "kernel32" Alias "GetTimeFormatA" (ByVal Locale As Integer, ByVal dwFlags As Integer, lpTime As SYSTEMTIME, ByVal lpFormat As String, ByVal lpTimeStr As String, ByVal cchTime As Integer) As Integer
Declare Function GetTimeZoneInformation Lib "kernel32" (lpTimeZoneInformation As TIME_ZONE_INFORMATION) As Integer
Declare Function GetUserDefaultLCID Lib "kernel32" () As Integer
Declare Function GetUserDefaultLangID Lib "kernel32" () As Integer
Declare Function GetVersion Lib "kernel32" () As Integer
Declare Function GetVersionEx Lib "kernel32" Alias "GetVersionExA" (lpVersionInformation As OSVERSIONINFO) As Integer
Declare Function GetVolumeInformation Lib "kernel32" Alias "GetVolumeInformationA" (ByVal lpRootPathName As String, ByVal lpVolumeNameBuffer As String, ByVal nVolumeNameSize As Integer, lpVolumeSerialNumber As Integer, lpMaximumComponentLength As Integer, lpFileSystemFlags As Integer, ByVal lpFileSystemNameBuffer As String, ByVal nFileSystemNameSize As Integer) As Integer
Declare Function GetWindowsDirectory Lib "kernel32" Alias "GetWindowsDirectoryA" (ByVal lpBuffer As String, ByVal nSize As Integer) As Integer
Declare Function GlobalAddAtom Lib "kernel32" Alias "GlobalAddAtomA" (ByVal lpString As String) As Integer
Declare Function GlobalAlloc Lib "kernel32" (ByVal wFlags As Integer, ByVal dwBytes As Integer) As Integer
Declare Function GlobalCompact Lib "kernel32" (ByVal dwMinFree As Integer) As Integer
Declare Function GlobalDeleteAtom Lib "kernel32" (ByVal nAtom As Integer) As Integer
Declare Function GlobalFindAtom Lib "kernel32" Alias "GlobalFindAtomA" (ByVal lpString As String) As Integer
Declare Sub GlobalFix Lib "kernel32" (ByVal hMem As Integer)
Declare Function GlobalFlags Lib "kernel32" Alias "GlobalFlags" (ByVal hMem As Integer) As Integer
Declare Function GlobalFree Lib "kernel32" (ByVal hMem As Integer) As Integer
Declare Function GlobalGetAtomName Lib "kernel32" Alias "GlobalGetAtomNameA" (ByVal nAtom As Integer, ByVal lpBuffer As String, ByVal nSize As Integer) As Integer
Declare Function GlobalHandle Lib "kernel32" (wMem As ANY) As Integer
Declare Function GlobalLock Lib "kernel32" (ByVal hMem As Integer) As Integer
Declare Sub GlobalMemoryStatus Lib "kernel32" (lpBuffer As MEMORYSTATUS)
Declare Function GlobalMemoryStatusEx Lib "kernel32" (lpBuffer As MEMORYSTATUSEX) As Integer
Declare Function GlobalReAlloc Lib "kernel32" (ByVal hMem As Integer, ByVal dwBytes As Integer, ByVal wFlags As Integer) As Integer
Declare Function GlobalSize Lib "kernel32" (ByVal hMem As Integer) As Integer
Declare Sub GlobalUnfix Lib "kernel32" (ByVal hMem As Integer)
Declare Function GlobalUnWire Lib "kernel32" (ByVal hMem As Integer) As Integer
Declare Function GlobalUnlock Lib "kernel32" (ByVal hMem As Integer) As Integer
Declare Function GlobalWire Lib "kernel32" (ByVal hMem As Integer) As Integer


Declare Function HeapAlloc Lib "kernel32" (ByVal hHeap As Integer, ByVal dwFlags As Integer, ByVal dwBytes As Integer) As Integer
Declare Function HeapCompact Lib "kernel32" (ByVal hHeap As Integer, ByVal dwFlags As Integer) As Integer
Declare Function HeapCreate Lib "kernel32" (ByVal flOptions As Integer, ByVal dwInitialSize As Integer, ByVal dwMaximumSize As Integer) As Integer
Declare Function HeapDestroy Lib "kernel32" (ByVal hHeap As Integer) As Integer
Declare Function HeapFree Lib "kernel32" (ByVal hHeap As Integer, ByVal dwFlags As Integer, ByRef lpMem As Any) As Integer
Declare Function HeapLock Lib "kernel32" (ByVal hHeap As Integer) As Integer
Declare Function HeapReAlloc Lib "kernel32" (ByVal hHeap As Integer, ByVal dwFlags As Integer, ByRef lpMem As Any, ByVal dwBytes As Integer) As Integer
Declare Function HeapSize Lib "kernel32" (ByVal hHeap As Integer, ByVal dwFlags As Integer, ByRef lpMem As Any) As Integer
Declare Function HeapUnlock Lib "kernel32" (ByVal hHeap As Integer) As Integer
Declare Function HeapValidate Lib "kernel32" (ByVal hHeap As Integer, ByVal dwFlags As Integer, ByRef lpMem As Any) As Integer
Declare Function hread Lib "kernel32" Alias "_hread" (ByVal hFile As Integer, ByRef lpBuffer As Any, ByVal lBytes As Integer) As Integer
Declare Function hwrite Lib "kernel32" Alias "_hwrite" (ByVal hFile As Integer, ByVal lpBuffer As String, ByVal lBytes As Integer) As Integer

Declare Function ImpersonateLoggedOnUser Lib "kernel32" (ByVal hToken As Integer) As Integer
Declare Function InitAtomTable Lib "kernel32" (ByVal nSize As Integer) As Integer
Declare Sub InitializeCriticalSection Lib "kernel32" (lpCriticalSection As CRITICAL_SECTION)
Declare Function InitializeCriticalSectionAndSpinCount Lib "kernel32" (lpCriticalSection As CRITICAL_SECTION, ByVal dwSpinCount As Integer) As Integer
Declare Function InterlockedDecrement Lib "kernel32" (lpAddend As Integer) As Integer
Declare Function InterlockedExchange Lib "kernel32" (xTarget As Integer, ByVal xValue As Integer) As Integer
Declare Function InterlockedIncrement Lib "kernel32" (lpAddend As Integer) As Integer
Declare Function IsBadCodePtr Lib "kernel32" (ByVal lpfn As Integer) As Integer
Declare Function IsBadHugeReadPtr Lib "kernel32" (lp As ANY, ByVal ucb As Integer) As Integer
Declare Function IsBadHugeWritePtr Lib "kernel32" (lp As ANY, ByVal ucb As Integer) As Integer
Declare Function IsBadReadPtr Lib "kernel32" (ByVal lp As Integer, ByVal ucb As Integer) As Integer
Declare Function IsBadStringPtr Lib "kernel32" Alias "IsBadStringPtrA" (ByVal lpsz As String, ByVal ucchMax As Integer) As Integer
Declare Function IsBadWritePtr Lib "kernel32" (ByVal lp As Integer, ByVal ucb As Integer) As Integer
Declare Function IsDBCSLeadByte Lib "kernel32" (ByVal bTestChar As BYTE) As Integer
Declare Function IsValidCodePage Lib "kernel32" (ByVal CodePage As Integer) As Integer
Declare Function IsValidLocale Lib "kernel32" (ByVal Locale As Integer, ByVal dwFlags As Integer) As Integer

Declare Function lclose Lib "kernel32" Alias "_lclose" (ByVal hFile As Integer) As Integer
Declare Function LCMapString Lib "kernel32" Alias "LCMapStringA" (ByVal Locale As Integer, ByVal dwMapFlags As Integer, ByVal lpSrcStr As String, ByVal cchSrc As Integer, ByVal lpDestStr As String, ByVal cchDest As Integer) As Integer
Declare Function lcreat Lib "kernel32" Alias "_lcreat" (ByVal lpPathName As String, ByVal iAttribute As Integer) As Integer
Declare Function llseek Lib "kernel32" Alias "_llseek" (ByVal hFile As Integer, ByVal lOffset As Integer, ByVal iOrigin As Integer) As Integer
Declare Sub LeaveCriticalSection Lib "kernel32" (lpCriticalSection As CRITICAL_SECTION)
Declare Function LoadLibrary Lib "kernel32" Alias "LoadLibraryA" (ByVal lpLibFileName As String) As Integer
Declare Function LoadLibraryEx Lib "kernel32" Alias "LoadLibraryExA" (ByVal lpLibFileName As String, ByVal hFile As Integer, ByVal dwFlags As Integer) As Integer
Declare Function LoadModule Lib "kernel32" (ByVal lpModuleName As String, lpParameterBlock As ANY) As Integer
Declare Function LoadResource Lib "kernel32" (ByVal hInstance As Integer, ByVal hResInfo As Integer) As Integer
Declare Function LocalAlloc Lib "kernel32" (ByVal wFlags As Integer, ByVal wBytes As Integer) As Integer
Declare Function LocalCompact Lib "kernel32" (ByVal uMinFree As Integer) As Integer
Declare Function LocalFileTimeToFileTime Lib "kernel32" (lpLocalFileTime As FILETIME, lpFileTime As FILETIME) As Integer
Declare Function LocalFlags Lib "kernel32" (ByVal hMem As Integer) As Integer
Declare Function LocalFree Lib "kernel32" (ByVal hMem As Integer) As Integer
Declare Function LocalHandle Lib "kernel32" (wMem As ANY) As Integer
Declare Function LocalLock Lib "kernel32" (ByVal hMem As Integer) As Integer
Declare Function LocalReAlloc Lib "kernel32" (ByVal hMem As Integer, ByVal wBytes As Integer, ByVal wFlags As Integer) As Integer
Declare Function LocalShrink Lib "kernel32" (ByVal hMem As Integer, ByVal cbNewSize As Integer) As Integer
Declare Function LocalSize Lib "kernel32" (ByVal hMem As Integer) As Integer
Declare Function LocalUnlock Lib "kernel32" (ByVal hMem As Integer) As Integer
Declare Function LockFile Lib "kernel32" (ByVal hFile As Integer, ByVal dwFileOffsetLow As Integer, ByVal dwFileOffsetHigh As Integer, ByVal nNumberOfBytesToLockLow As Integer, ByVal nNumberOfBytesToLockHigh As Integer) As Integer
Declare Function LockFileEx Lib "kernel32" (ByVal hFile As Integer, ByVal dwFlags As Integer, ByVal dwReserved As Integer, ByVal nNumberOfBytesToLockLow As Integer, ByVal nNumberOfBytesToLockHigh As Integer, lpOverlapped As OVERLAPPED) As Integer
Declare Function LockResource Lib "kernel32" (ByVal hResData As Integer) As Integer
Declare Function LogonUser Lib "kernel32" Alias "LogonUserA" (ByVal lpszUsername As String, ByVal lpszDomain As String, ByVal lpszPassword As String, ByVal dwLogonType As Integer, ByVal dwLogonProvider As Integer, phToken As Integer) As Integer
Declare Function lopen Lib "kernel32" Alias "_lopen" (ByVal lpPathName As String, ByVal iReadWrite As Integer) As Integer
Declare Function lread Lib "kernel32" Alias "_lread" (ByVal hFile As Integer, lpBuffer As ANY, ByVal wBytes As Integer) As Integer
Declare Function lstrcat Lib "kernel32" Alias "lstrcatA" (ByVal lpString1 As String, ByVal lpString2 As String) As Integer
Declare Function lstrcmp Lib "kernel32" Alias "lstrcmpA" (ByVal lpString1 As String, ByVal lpString2 As String) As Integer
Declare Function lstrcmpi Lib "kernel32" Alias "lstrcmpiA" (ByVal lpString1 As String, ByVal lpString2 As String) As Integer
Declare Function lstrcpy Lib "kernel32" Alias "lstrcpyA" (ByVal lpString1 As String, ByVal lpString2 As String) As Integer
Declare Function lstrcpyn Lib "kernel32" Alias "lstrcpynA" (ByVal lpString1 As String, ByVal lpString2 As String, ByVal iMaxLength As Integer) As Integer
Declare Function lstrlen Lib "kernel32" Alias "lstrlenA" (ByVal lpString As String) As Integer
Declare Function lwrite Lib "kernel32" Alias "_lwrite" (ByVal hFile As Integer, ByVal lpBuffer As String, ByVal wBytes As Integer) As Integer

Declare Function MapViewOfFile Lib "kernel32" Alias "MapViewOfFile" (ByVal hFileMappingObject As Integer, ByVal dwDesiredAccess As Integer, ByVal dwFileOffsetHigh As Integer, ByVal dwFileOffsetLow As Integer, ByVal dwNumberOfBytesToMap As Integer) As Integer
Declare Function MapViewOfFileEx Lib "kernel32" (ByVal hFileMappingObject As Integer, ByVal dwDesiredAccess As Integer, ByVal dwFileOffsetHigh As Integer, ByVal dwFileOffsetLow As Integer, ByVal dwNumberOfBytesToMap As Integer, lpBaseAddress As ANY) As Integer
Declare Function MoveFile Lib "kernel32" Alias "MoveFileA" (ByVal lpExistingFileName As String, ByVal lpNewFileName As String) As Integer
Declare Function MoveFileEx Lib "kernel32" Alias "MoveFileExA" (ByVal lpExistingFileName As String, ByVal lpNewFileName As String, ByVal dwFlags As Integer) As Integer
Declare Sub MoveMemory Lib "kernel32" Alias "RtlMoveMemory" (pDestination As ANY, pSource As ANY, ByVal cbLength As Integer)
Declare Function MulDiv Lib "kernel32" (ByVal nNumber As Integer, ByVal nNumerator As Integer, ByVal nDenominator As Integer) As Integer
Declare Function MultiByteToWideChar Lib "kernel32" (ByVal CodePage As Integer, ByVal dwFlags As Integer, ByVal lpMultiByteStr As String, ByVal cchMultiByte As Integer, ByVal lpWideCharStr As String, ByVal cchWideChar As Integer) As Integer

'Declare Function ObjectOpenAuditAlarm Lib "kernel32" Alias "ObjectOpenAuditAlarmA" (ByVal SubsystemName As String, ByRef HandleId As Any, ByVal ObjectTypeName As String, ByVal ObjectName As String, pSecurityDescriptor As SECURITY_DESCRIPTOR, ByVal ClientToken As Integer, ByVal DesiredAccess As Integer, ByVal GrantedAccess As Integer, Privileges As PRIVILEGE_SET, ByVal ObjectCreation As Integer, ByVal AccessGranted As Integer, ByVal GenerateOnClose As Integer) As Integer
Declare Function OpenEvent Lib "kernel32" Alias "OpenEventA" (ByVal dwDesiredAccess As Integer, ByVal bInheritHandle As Integer, ByVal lpName As String) As Integer
Declare Function OpenFile Lib "kernel32" (ByVal lpFileName As String, lpReOpenBuff As OFSTRUCT, ByVal wStyle As Integer) As Integer
Declare Function OpenFileMapping Lib "kernel32" Alias "OpenFileMappingA" (ByVal dwDesiredAccess As Integer, ByVal bInheritHandle As Integer, ByVal lpName As String) As Integer
Declare Function OpenMutex Lib "kernel32" Alias "OpenMutexA" (ByVal dwDesiredAccess As Integer, ByVal bInheritHandle As Integer, ByVal lpName As String) As Integer
Declare Function OpenProcess Lib "kernel32" (ByVal dwDesiredAccess As Integer, ByVal bInheritHandle As Integer, ByVal dwProcessId As Integer) As Integer
Declare Function OpenSemaphore Lib "kernel32" Alias "OpenSemaphoreA" (ByVal dwDesiredAccess As Integer, ByVal bInheritHandle As Integer, ByVal lpName As String) As Integer
Declare Sub OutputDebugString Lib "kernel32" Alias "OutputDebugStringA" (ByVal lpOutputString As String)

Declare Function PeekNamedPipe Lib "kernel32" (ByVal hNamedPipe As Integer, lpBuffer As ANY, ByVal nBufferSize As Integer, lpBytesRead As Integer, lpTotalBytesAvail As Integer, lpBytesLeftThisMessage As Integer) As Integer
Declare Function PrepareTape Lib "kernel32" (ByVal hDevice As Integer, ByVal dwOperation As Integer, ByVal bimmediate As Integer) As Integer
Declare Function PulseEvent Lib "kernel32" (ByVal hEvent As Integer) As Integer
Declare Function PurgeComm Lib "kernel32" (ByVal hFile As Integer, ByVal dwFlags As Integer) As Integer

Declare Function PeekConsoleInput alias "PeekConsoleInputA" ( byval hConsoleInput as integer, byref pirBuffer as INPUT_RECORD, byval cInRecords as integer, byref lpcRead as integer ) as integer

Declare Function QueryDosDevice Lib "kernel32" Alias "QueryDosDeviceA" (ByVal lpDeviceName As String, ByVal lpTargetPath As String, ByVal ucchMax As Integer) As Integer
Declare Function QueryPerformanceCounter Lib "kernel32" (lpPerformanceCount As INT64) As Integer
Declare Function QueryPerformanceFrequency Lib "kernel32" (lpFrequency As INT64) As Integer

Declare Sub RaiseException Lib "kernel32" (ByVal dwExceptionCode As Integer, ByVal dwExceptionFlags As Integer, ByVal nNumberOfArguments As Integer, lpArguments As Integer)
Declare Function ReadConsole Lib "kernel32" Alias "ReadConsoleA" (ByVal hConsoleInput As Integer, lpBuffer As ANY, ByVal nNumberOfCharsToRead As Integer, lpNumberOfCharsRead As Integer, lpReserved As ANY) As Integer
Declare Function ReadConsoleInput Lib "kernel32" Alias "ReadConsoleInputA" (ByVal hConsoleInput As Integer, byref lpBuffer As INPUT_RECORD, ByVal nNumberOfCharsToRead As Integer, lpNumberOfCharsRead As Integer) As Integer
Declare Function ReadConsoleOutput Lib "kernel32" Alias "ReadConsoleOutputA" (ByVal hConsoleOutput As Integer, ByVal lpBuffer As Integer, ByVal dwBufferSize As Integer, ByVal dwBufferCoord As Integer, lpReadRegion As SMALL_RECT) As Integer
Declare Function ReadConsoleOutputAttribute Lib "kernel32" (ByVal hConsoleOutput As Integer, lpdwAttribute As Integer, ByVal nLength As Integer, ByVal dwReadCoord As Integer, lpNumberOfAttrsRead As Integer) As Integer
Declare Function ReadConsoleOutputCharacter Lib "kernel32" Alias "ReadConsoleOutputCharacterA" (ByVal hConsoleOutput As Integer, ByVal szCharacter As String, ByVal nLength As Integer, ByVal dwReadCoord As Integer, lpNumberOfCharsRead As Integer) As Integer
Declare Function ReadFile Lib "kernel32" (ByVal hFile As Integer, lpBuffer As ANY, ByVal nNumberOfBytesToRead As Integer, lpNumberOfBytesRead As Integer, lpOverlapped As OVERLAPPED) As Integer
Declare Function ReadFileEx Lib "kernel32" (ByVal hFile As Integer, lpBuffer As ANY, ByVal nNumberOfBytesToRead As Integer, lpOverlapped As OVERLAPPED, ByVal lpCompletionRoutine As Integer) As Integer
Declare Function ReadProcessMemory Lib "kernel32" (ByVal hProcess As Integer, ByVal lpBaseAddress As Integer, lpBuffer As ANY, ByVal nSize As Integer, lpNumberOfBytesWritten As Integer) As Integer
Declare Function ReleaseMutex Lib "kernel32" (ByVal hMutex As Integer) As Integer
Declare Function ReleaseSemaphore Lib "kernel32" (ByVal hSemaphore As Integer, ByVal lReleaseCount As Integer, lpPreviousCount As Integer) As Integer
Declare Function RemoveDirectory Lib "kernel32" Alias "RemoveDirectoryA" (ByVal lpPathName As String) As Integer
Declare Function ResetEvent Lib "kernel32" (ByVal hEvent As Integer) As Integer
Declare Function ResumeThread Lib "kernel32" (ByVal hThread As Integer) As Integer

Declare Function ScrollConsoleScreenBuffer Lib "kernel32" Alias "ScrollConsoleScreenBufferA" (ByVal hConsoleOutput As Integer, lpScrollRectangle As SMALL_RECT, lpClipRectangle As SMALL_RECT, ByVal dwDestinationOrigin As Integer, lpFill As CHAR_INFO) As Integer
Declare Function SearchPath Lib "kernel32" Alias "SearchPathA" (ByVal lpPath As String, ByVal lpFileName As String, ByVal lpExtension As String, ByVal nBufferLength As Integer, ByVal lpBuffer As String, ByVal lpFilePart As String) As Integer
Declare Function SetCommBreak Lib "kernel32" (ByVal nCid As Integer) As Integer
Declare Function SetCommConfig Lib "kernel32" (ByVal hCommDev As Integer, lpCC As COMMCONFIG, ByVal dwSize As Integer) As Integer
Declare Function SetCommMask Lib "kernel32" (ByVal hFile As Integer, ByVal dwEvtMask As Integer) As Integer
Declare Function SetCommState Lib "kernel32" (ByVal hCommDev As Integer, lpDCB As DCB) As Integer
Declare Function SetCommTimeouts Lib "kernel32" (ByVal hFile As Integer, lpCommTimeouts As COMMTIMEOUTS) As Integer
Declare Function SetComputerName Lib "kernel32" Alias "SetComputerNameA" (ByVal lpComputerName As String) As Integer
Declare Function SetConsoleActiveScreenBuffer Lib "kernel32" (ByVal hConsoleOutput As Integer) As Integer
Declare Function SetConsoleCP Lib "kernel32" (ByVal wCodePageID As Integer) As Integer
Declare Function SetConsoleCtrlHandler Lib "kernel32" (ByVal HandlerRoutine As Integer, ByVal nAdd As Integer) As Integer
Declare Function SetConsoleCursorInfo Lib "kernel32" (ByVal hConsoleOutput As Integer, lpConsoleCursorInfo As CONSOLE_CURSOR_INFO) As Integer
Declare Function SetConsoleCursorPosition Lib "kernel32" (ByVal hConsoleOutput As Integer, ByVal dwCursorPosition As Integer) As Integer
Declare Function SetConsoleMode Lib "kernel32" (ByVal hConsoleHandle As Integer, ByVal dwMode As Integer) As Integer
Declare Function SetConsoleOutputCP Lib "kernel32" (ByVal wCodePageID As Integer) As Integer
Declare Function SetConsoleScreenBufferSize Lib "kernel32" (ByVal hConsoleOutput As Integer, ByVal dwSize As Integer) As Integer
Declare Function SetConsoleTextAttribute Lib "kernel32" (ByVal hConsoleOutput As Integer, ByVal dwAttributes As Integer) As Integer
Declare Function SetConsoleTitle Lib "kernel32" Alias "SetConsoleTitleA" (ByVal lpConsoleTitle As String) As Integer
Declare Function SetConsoleWindowInfo Lib "kernel32" (ByVal hConsoleOutput As Integer, ByVal bAbsolute As Integer, lpConsoleWindow As SMALL_RECT) As Integer
Declare Function SetCriticalSectionSpinCount Lib "kernel32" (lpCriticalSection As CRITICAL_SECTION, ByVal dwSpinCount As Integer) As Integer
Declare Function SetCurrentDirectory Lib "kernel32" Alias "SetCurrentDirectoryA" (ByVal lpPathName As String) As Integer
Declare Function SetDefaultCommConfig Lib "kernel32" Alias "SetDefaultCommConfigA" (ByVal lpszName As String, lpCC As COMMCONFIG, ByVal dwSize As Integer) As Integer
Declare Function SetEndOfFile Lib "kernel32" (ByVal hFile As Integer) As Integer
Declare Function SetEnvironmentVariable Lib "kernel32" Alias "SetEnvironmentVariableA" (ByVal lpName As String, ByVal lpValue As String) As Integer
Declare Function SetErrorMode Lib "kernel32" (ByVal wMode As Integer) As Integer
Declare Function SetEvent Lib "kernel32" (ByVal hEvent As Integer) As Integer
Declare Sub SetFileApisToANSI Lib "kernel32" ()
Declare Sub SetFileApisToOEM Lib "kernel32" ()
Declare Function SetFileAttributes Lib "kernel32" Alias "SetFileAttributesA" (ByVal lpFileName As String, ByVal dwFileAttributes As Integer) As Integer
Declare Function SetFilePointer Lib "kernel32" (ByVal hFile As Integer, ByVal lDistanceToMove As Integer, lpDistanceToMoveHigh As Integer, ByVal dwMoveMethod As Integer) As Integer
Declare Function SetFileTime Lib "kernel32" (ByVal hFile As Integer, lpCreationTime As FILETIME, lpLastAccessTime As FILETIME, lpLastWriteTime As FILETIME) As Integer
Declare Function SetHandleCount Lib "kernel32" (ByVal wNumber As Integer) As Integer
Declare Function SetHandleInformation Lib "kernel32" (ByVal hObject As Integer, ByVal dwMask As Integer, ByVal dwFlags As Integer) As Integer
Declare Sub SetLastError Lib "kernel32" (ByVal dwErrCode As Integer)
Declare Function SetLocalTime Lib "kernel32" (lpSystemTime As SYSTEMTIME) As Integer
Declare Function SetLocaleInfo Lib "kernel32" Alias "SetLocaleInfoA" (ByVal Locale As Integer, ByVal LCType As Integer, ByVal lpLCData As String) As Integer
Declare Function SetMailslotInfo Lib "kernel32" (ByVal hMailslot As Integer, ByVal lReadTimeout As Integer) As Integer
Declare Function SetNamedPipeHandleState Lib "kernel32" (ByVal hNamedPipe As Integer, lpMode As Integer, lpMaxCollectionCount As Integer, lpCollectDataTimeout As Integer) As Integer
Declare Function SetPriorityClass Lib "kernel32" (ByVal hProcess As Integer, ByVal dwPriorityClass As Integer) As Integer
Declare Function SetProcessShutdownParameters Lib "kernel32" Alias "SetProcessShutdownParameters" (ByVal dwLevel As Integer, ByVal dwFlags As Integer) As Integer
Declare Function SetProcessWorkingSetSize Lib "kernel32" (ByVal hProcess As Integer, ByVal dwMinimumWorkingSetSize As Integer, ByVal dwMaximumWorkingSetSize As Integer) As Integer
Declare Function SetStdHandle Lib "kernel32" (ByVal nStdHandle As Integer, ByVal nHandle As Integer) As Integer
Declare Function SetSystemPowerState Lib "kernel32" (ByVal fSuspend As Integer, ByVal fForce As Integer) As Integer
Declare Function SetSystemTime Lib "kernel32" (lpSystemTime As SYSTEMTIME) As Integer
Declare Function SetSystemTimeAdjustment Lib "kernel32" (ByVal dwTimeAdjustment As Integer, ByVal bTimeAdjustmentDisabled As Integer) As Integer
Declare Function SetTapeParameters Lib "kernel32" (ByVal hDevice As Integer, ByVal dwOperation As Integer, lpTapeInformation As ANY) As Integer
Declare Function SetTapePosition Lib "kernel32" (ByVal hDevice As Integer, ByVal dwPositionMethod As Integer, ByVal dwPartition As Integer, ByVal dwOffsetLow As Integer, ByVal dwOffsetHigh As Integer, ByVal bimmediate As Integer) As Integer
Declare Function SetThreadAffinityMask Lib "kernel32" (ByVal hThread As Integer, ByVal dwThreadAffinityMask As Integer) As Integer
Declare Function SetThreadContext Lib "kernel32" (ByVal hThread As Integer, lpContext As CONTEXT) As Integer
Declare Function SetThreadLocale Lib "kernel32" (ByVal Locale As Integer) As Integer
Declare Function SetThreadPriority Lib "kernel32" (ByVal hThread As Integer, ByVal nPriority As Integer) As Integer
Declare Function SetTimeZoneInformation Lib "kernel32" (lpTimeZoneInformation As TIME_ZONE_INFORMATION) As Integer
Declare Function SetUnhandledExceptionFilter Lib "kernel32" (ByVal lpTopLevelExceptionFilter As Integer) As Integer
Declare Function SetVolumeLabel Lib "kernel32" Alias "SetVolumeLabelA" (ByVal lpRootPathName As String, lpVolumeName As String) As Integer
Declare Function SetupComm Lib "kernel32" (ByVal hFile As Integer, ByVal dwInQueue As Integer, ByVal dwOutQueue As Integer) As Integer
Declare Function SizeofResource Lib "kernel32" (ByVal hInstance As Integer, ByVal hResInfo As Integer) As Integer
'Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Integer)
Declare Function SleepEx Lib "kernel32" (ByVal dwMilliseconds As Integer, ByVal bAlertable As Integer) As Integer
Declare Function SuspendThread Lib "kernel32" (ByVal hThread As Integer) As Integer
Declare Function SystemTimeToFileTime Lib "kernel32" (lpSystemTime As SYSTEMTIME, lpFileTime As FILETIME) As Integer
Declare Function SystemTimeToTzSpecificLocalTime Lib "kernel32" (lpTimeZoneInformation As TIME_ZONE_INFORMATION, lpUniversalTime As SYSTEMTIME, lpLocalTime As SYSTEMTIME) As Integer

Declare Function TerminateProcess Lib "kernel32" (ByVal hProcess As Integer, ByVal uExitCode As Integer) As Integer
Declare Function TerminateThread Lib "kernel32" (ByVal hThread As Integer, ByVal dwExitCode As Integer) As Integer
Declare Function TlsAlloc Lib "kernel32" () As Integer
Declare Function TlsFree Lib "kernel32" (ByVal dwTlsIndex As Integer) As Integer
Declare Function TlsGetValue Lib "kernel32" (ByVal dwTlsIndex As Integer) As Integer
Declare Function TlsSetValue Lib "kernel32" (ByVal dwTlsIndex As Integer, lpTlsValue As ANY) As Integer
Declare Function TransactNamedPipe Lib "kernel32" (ByVal hNamedPipe As Integer, lpInBuffer As ANY, ByVal nInBufferSize As Integer, lpOutBuffer As ANY, ByVal nOutBufferSize As Integer, lpBytesRead As Integer, lpOverlapped As OVERLAPPED) As Integer
Declare Function TransmitCommChar Lib "kernel32" (ByVal nCid As Integer, ByVal cChar As BYTE) As Integer

Declare Function UnhandledExceptionFilter Lib "kernel32" (ExceptionInfo As EXCEPTION_POINTERS) As Integer
Declare Function UnlockFile Lib "kernel32" (ByVal hFile As Integer, ByVal dwFileOffsetLow As Integer, ByVal dwFileOffsetHigh As Integer, ByVal nNumberOfBytesToUnlockLow As Integer, ByVal nNumberOfBytesToUnlockHigh As Integer) As Integer
Declare Function UnlockFileEx Lib "kernel32" (ByVal hFile As Integer, ByVal dwReserved As Integer, ByVal nNumberOfBytesToUnlockLow As Integer, ByVal nNumberOfBytesToUnlockHigh As Integer, lpOverlapped As OVERLAPPED) As Integer
Declare Function UnmapViewOfFile Lib "kernel32" (lpBaseAddress As ANY) As Integer
Declare Function UpdateResource Lib "kernel32" Alias "UpdateResourceA" (ByVal hUpdate As Integer, ByVal lpType As String, ByVal lpName As String, ByVal wLanguage As Integer, lpData As ANY, ByVal cbData As Integer) As Integer

Declare Function VerLanguageName Lib "kernel32" Alias "VerLanguageNameA" (ByVal wLang As Integer, ByVal szLang As String, ByVal nSize As Integer) As Integer
Declare Function VirtualAlloc Lib "kernel32" (lpAddress As ANY, ByVal dwSize As Integer, ByVal flAllocationType As Integer, ByVal flProtect As Integer) As Integer
Declare Function VirtualAllocEx Lib "kernel32" (ByVal hProcess As Integer, lpAddress As ANY, ByVal dwSize As Integer, ByVal flAllocationType As Integer, ByVal flProtect As Integer) As Integer
Declare Function VirtualFree Lib "kernel32" (lpAddress As ANY, ByVal dwSize As Integer, ByVal dwFreeType As Integer) As Integer
Declare Function VirtualFreeEx Lib "kernel32" (ByVal hProcess As Integer, lpAddress As ANY, ByVal dwSize As Integer, ByVal dwFreeType As Integer) As Integer
Declare Function VirtualLock Lib "kernel32" (lpAddress As ANY, ByVal dwSize As Integer) As Integer
Declare Function VirtualProtect Lib "kernel32" (lpAddress As ANY, ByVal dwSize As Integer, ByVal flNewProtect As Integer, lpflOldProtect As Integer) As Integer
Declare Function VirtualProtectEx Lib "kernel32" (ByVal hProcess As Integer, lpAddress As ANY, ByVal dwSize As Integer, ByVal flNewProtect As Integer, lpflOldProtect As Integer) As Integer
Declare Function VirtualQuery Lib "kernel32" (ByRef lpAddress As Any, lpBuffer As MEMORY_BASIC_INFORMATION, ByVal dwLength As Integer) As Integer
Declare Function VirtualQueryEx Lib "kernel32" (ByVal hProcess As Integer, ByRef lpAddress As Any, lpBuffer As MEMORY_BASIC_INFORMATION, ByVal dwLength As Integer) As Integer
Declare Function VirtualUnlock Lib "kernel32" (ByRef lpAddress As Any, ByVal dwSize As Integer) As Integer

Declare Function WaitCommEvent Lib "kernel32" (ByVal hFile As Integer, lpEvtMask As Integer, lpOverlapped As OVERLAPPED) As Integer
Declare Function WaitForDebugEvent Lib "kernel32" (lpde As DEBUG_EVENT, ByVal dwTimeOut As Integer) As Integer
Declare Function WaitForMultipleObjects Lib "kernel32" (ByVal nCount As Integer, lpHandles As Integer, ByVal bWaitAll As Integer, ByVal dwMilliseconds As Integer) As Integer
Declare Function WaitForMultipleObjectsEx Lib "kernel32" (ByVal nCount As Integer, lpHandles As Integer, ByVal bWaitAll As Integer, ByVal dwMilliseconds As Integer, ByVal bAlertable As Integer) As Integer
Declare Function WaitForSingleObject Lib "kernel32" (ByVal hHandle As Integer, ByVal dwMilliseconds As Integer) As Integer
Declare Function WaitForSingleObjectEx Lib "kernel32" (ByVal hHandle As Integer, ByVal dwMilliseconds As Integer, ByVal bAlertable As Integer) As Integer
Declare Function WaitNamedPipe Lib "kernel32" Alias "WaitNamedPipeA" (ByVal lpNamedPipeName As String, ByVal nTimeOut As Integer) As Integer
Declare Function WideCharToMultiByte Lib "kernel32" (ByVal CodePage As Integer, ByVal dwFlags As Integer, ByVal lpWideCharStr As String, ByVal cchWideChar As Integer, ByVal lpMultiByteStr As String, ByVal cchMultiByte As Integer, ByVal lpDefaultChar As String, ByVal lpUsedDefaultChar As Integer) As Integer
Declare Function WinExec Lib "kernel32" (ByVal lpCmdLine As String, ByVal nCmdShow As Integer) As Integer
Declare Function WriteConsole Lib "kernel32" Alias "WriteConsoleA" (ByVal hConsoleOutput As Integer, ByVal lpBuffer As String, ByVal nNumberOfCharsToWrite As Integer, lpNumberOfCharsWritten As Integer, ByVal lpReserved As Integer) As Integer
Declare Function WriteConsoleInput Lib "kernel32" Alias "WriteConsoleInputA" (ByVal hConsoleInput As Integer, lpBuffer As INPUT_RECORD, ByVal nLength As Integer, lpNumberOfEventsWritten As Integer) As Integer
Declare Function WriteConsoleOutput Lib "kernel32" Alias "WriteConsoleOutputA" (ByVal hConsoleOutput As Integer, ByVal lpBuffer As Integer, ByVal dwBufferSize As Integer, ByVal dwBufferCoord As Integer, lpWriteRegion As SMALL_RECT) As Integer
Declare Function WriteConsoleOutputAttribute Lib "kernel32"(ByVal hConsoleOutput As Integer, lpdwAttribute As Integer, ByVal nLength As Integer, ByVal dwWriteCoord As Integer, lpNumberOfAttrsWritten As Integer) As Integer
Declare Function WriteConsoleOutputCharacter Lib "kernel32" Alias "WriteConsoleOutputCharacterA" (ByVal hConsoleOutput As Integer, ByVal szCharacter As String, ByVal nLength As Integer, ByVal dwWriteCoord As Integer, lpNumberOfCharsWritten As Integer) As Integer
Declare Function WriteFile Lib "kernel32" (ByVal hFile As Integer, lpBuffer As ANY, ByVal nNumberOfBytesToWrite As Integer, lpNumberOfBytesWritten As Integer, lpOverlapped As OVERLAPPED) As Integer
Declare Function WriteFileEx Lib "kernel32" (ByVal hFile As Integer, lpBuffer As ANY, ByVal nNumberOfBytesToWrite As Integer, lpOverlapped As OVERLAPPED, ByVal lpCompletionRoutine As Integer) As Integer
Declare Function WritePrivateProfileSection Lib "kernel32" Alias "WritePrivateProfileSectionA" (ByVal lpAppName As String, ByVal lpString As String, ByVal lpFileName As String) As Integer
Declare Function WritePrivateProfileString Lib "kernel32" Alias "WritePrivateProfileStringA" (ByVal lpApplicationName As String, ByVal lpKeyName As String, ByVal lpString As String, ByVal lpFileName As String) As Integer
Declare Function WriteProcessMemory Lib "kernel32"(ByVal hProcess As Integer, lpBaseAddress As ANY, lpBuffer As ANY, ByVal nSize As Integer, lpNumberOfBytesWritten As Integer) As Integer
Declare Function WriteProfileSection Lib "kernel32" Alias "WriteProfileSectionA" (ByVal lpAppName As String, ByVal lpString As String) As Integer
Declare Function WriteProfileString Lib "kernel32" Alias "WriteProfileStringA" (ByVal lpszSection As String, ByVal lpszKeyName As String, ByVal lpszString As String) As Integer
Declare Function WriteTapemark Lib "kernel32" (ByVal hDevice As Integer, ByVal dwTapemarkType As Integer, ByVal dwTapemarkCount As Integer, ByVal bimmediate As Integer) As Integer

#endif ' KERNEL32_BI