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

#include once "win\winbase.bi"

#inclib "kernel32"

'----------------------
'| REQUIRED CONSTANTS |
'----------------------

#define DELETE  &H10000
#define READ_CONTROL  &H20000
#define WRITE_DAC  &H40000
#define WRITE_OWNER  &H80000
#define SYNCHRONIZE  &H100000

#define STANDARD_RIGHTS_READ  &H20000
#define STANDARD_RIGHTS_WRITE  &H20000
#define STANDARD_RIGHTS_EXECUTE  &H20000
#define STANDARD_RIGHTS_REQUIRED  &HF0000
#define STANDARD_RIGHTS_ALL  &H1F0000

#define SPECIFIC_RIGHTS_ALL  &HFFFF

'FILE_READ_DATA and FILE_WRITE_DATA constants

#define FILE_READ_DATA  &H1           '  file pipe
#define FILE_LIST_DIRECTORY  &H1           '  directory

#define FILE_WRITE_DATA  &H2           '  file pipe
#define FILE_ADD_FILE  &H2           '  directory

#define FILE_APPEND_DATA  &H4           '  file
#define FILE_ADD_SUBDIRECTORY  &H4           '  directory
#define FILE_CREATE_PIPE_INSTANCE  &H4           '  named pipe

#define FILE_READ_EA  &H8           '  file directory
#define FILE_READ_PROPERTIES  &H8

#define FILE_WRITE_EA  &H10          '  file directory
#define FILE_WRITE_PROPERTIES  &H10

#define FILE_EXECUTE  &H20          '  file
#define FILE_TRAVERSE  &H20          '  directory

#define FILE_DELETE_CHILD  &H40          '  directory

#define FILE_READ_ATTRIBUTES  &H80          '  all
#define FILE_WRITE_ATTRIBUTES  &H100         '  all

#define FILE_ALL_ACCESS  &H1F01FF      ' (STANDARD_RIGHTS_REQUIRED Or SYNCHRONIZE Or &H1FF)
#define FILE_GENERIC_READ  &H120089      ' (STANDARD_RIGHTS_READ Or FILE_READ_DATA Or FILE_READ_ATTRIBUTES Or FILE_READ_EA Or SYNCHRONIZE)
#define FILE_GENERIC_WRITE  &H120116      ' (STANDARD_RIGHTS_WRITE Or FILE_WRITE_DATA Or FILE_WRITE_ATTRIBUTES Or FILE_WRITE_EA Or FILE_APPEND_DATA Or SYNCHRONIZE)
#define FILE_GENERIC_EXECUTE  &H1200A0	' (STANDARD_RIGHTS_EXECUTE Or FILE_READ_ATTRIBUTES Or FILE_EXECUTE Or SYNCHRONIZE)

#define FILE_SHARE_NONE  &H0
#define FILE_SHARE_READ  &H1
#define FILE_SHARE_WRITE  &H2

#define FILE_ATTRIBUTE_READONLY  &H1
#define FILE_ATTRIBUTE_HIDDEN  &H2
#define FILE_ATTRIBUTE_SYSTEM  &H4
#define FILE_ATTRIBUTE_DIRECTORY  &H10
#define FILE_ATTRIBUTE_ARCHIVE  &H20
#define FILE_ATTRIBUTE_NORMAL  &H80
#define FILE_ATTRIBUTE_TEMPORARY  &H100
#define FILE_ATTRIBUTE_ATOMIC_WRITE  &H200
#define FILE_ATTRIBUTE_XACTION_WRITE  &H400
#define FILE_ATTRIBUTE_COMPRESSED  &H800

#define FILE_NOTIFY_CHANGE_FILE_NAME  &H1
#define FILE_NOTIFY_CHANGE_DIR_NAME  &H2
#define FILE_NOTIFY_CHANGE_ATTRIBUTES  &H4
#define FILE_NOTIFY_CHANGE_SIZE  &H8
#define FILE_NOTIFY_CHANGE_LAST_WRITE  &H10
#define FILE_NOTIFY_CHANGE_SECURITY  &H100

#define MAILSLOT_NO_MESSAGE  (-1)
#define MAILSLOT_WAIT_FOREVER  (-1)

#define FILE_CASE_SENSITIVE_SEARCH  &H1
#define FILE_CASE_PRESERVED_NAMES  &H2
#define FILE_UNICODE_ON_DISK  &H4
#define FILE_PERSISTENT_ACLS  &H8
#define FILE_FILE_COMPRESSION  &H10
#define FILE_VOLUME_IS_COMPRESSED  &H8000

#define IO_COMPLETION_MODIFY_STATE  &H2
#define IO_COMPLETION_ALL_ACCESS  &H1F0003	' (STANDARD_RIGHTS_REQUIRED Or SYNCHRONIZE Or &H3)

#define DUPLICATE_CLOSE_SOURCE  &H1
#define DUPLICATE_SAME_ACCESS  &H2

'  Access Rights

'  AccessSystemAcl access Type

#define ACCESS_SYSTEM_SECURITY  &H1000000

'  MaximumAllowed access Type

#define MAXIMUM_ALLOWED  &H2000000

'  These are the generic rights

#define GENERIC_READ  &H80000000
#define GENERIC_WRITE  &H40000000
#define GENERIC_EXECUTE  &H20000000
#define GENERIC_ALL  &H10000000

#define FILE_BEGIN  0
#define FILE_CURRENT  1
#define FILE_End  2

#define FILE_FLAG_WRITE_THROUGH  &H80000000
#define FILE_FLAG_OVERLAPPED  &H40000000
#define FILE_FLAG_NO_BUFFERING  &H20000000
#define FILE_FLAG_RANDOM_ACCESS  &H10000000
#define FILE_FLAG_SEQUENTIAL_SCAN  &H08000000
#define FILE_FLAG_DELETE_ON_CLOSE  &H04000000
#define FILE_FLAG_BACKUP_SEMANTICS  &H02000000
#define FILE_FLAG_POSIX_SEMANTICS  &H01000000

#define CREATE_NEW  1
#define CREATE_ALWAYS  2
#define OPEN_EXISTING  3
#define OPEN_ALWAYS  4
#define TRUNCATE_EXISTING  5

'  Define the dwOpenMode values for CreateNamedPipe

#define PIPE_ACCESS_INBOUND  &H1
#define PIPE_ACCESS_OUTBOUND  &H2
#define PIPE_ACCESS_DUPLEX  &H3

' Define the Named Pipe End flags for GetNamedPipeInfo

#define PIPE_CLIENT_End  &H0
#define PIPE_SERVER_End  &H1

' Define the dwPipeMode values for CreateNamedPipe

#define PIPE_WAIT  &H0
#define PIPE_NOWAIT  &H1
#define PIPE_READMODE_BYTE  &H0
#define PIPE_READMODE_MESSAGE  &H2
#define PIPE_Type_BYTE  &H0
#define PIPE_Type_MESSAGE  &H4

' Define the well known values for CreateNamedPipe nMaxInstances

#define PIPE_UNLIMITED_INSTANCES  255

' Define the Security Quality of Service bits to be passed into CreateFile

#define SECURITY_ANONYMOUS  &H0
#define SECURITY_IDENTIFICATION  &H10000
#define SECURITY_IMPERSONATION  &H20000
#define SECURITY_DELEGATION  &H30000
#define SECURITY_CONTEXT_TRACKING  &H40000
#define SECURITY_EFFECTIVE  &H80000
#define SECURITY_EFFECTIVE_ONLY  &H80000

#define SECURITY_SQOS_PRESENT  &H100000
#define SECURITY_VALID_SQOS_FLAGS  &H1F0000

'  Code Page Default Values

#define CP_ACP  0       	'  default to ANSI code page
#define CP_OEMCP  1             '  default to OEM  code page

#define DRIVE_UNKNOWN  0
#define DRIVE_NO_ROOT_DIR  1
#define DRIVE_REMOVABLE  2
#define DRIVE_FIXED  3
#define DRIVE_REMOTE  4
#define DRIVE_CDROM  5
#define DRIVE_RAMDISK  6

' Global Memory Flags

#define GMEM_FIXED  &H0
#define GMEM_MOVEABLE  &H2
#define GMEM_NOCOMPACT  &H10
#define GMEM_NODISCARD  &H20
#define GMEM_ZEROINIT  &H40
#define GMEM_MODIFY  &H80
#define GMEM_DISCARDABLE  &H100
#define GMEM_NOT_BANKED  &H1000
#define GMEM_SHARE  &H2000
#define GMEM_DDESHARE  &H2000
#define GMEM_NOTIFY  &H4000
#define GMEM_LOWER  &H1000
#define GMEM_VALID_FLAGS  &H7F72
#define GMEM_INVALID_HANDLE  &H8000

#define GHND  &H42		'  (GMEM_MOVEABLE Or GMEM_ZEROINIT)
#define GPTR  &H40		'  (GMEM_FIXED Or GMEM_ZEROINIT)

' Flags returned by GlobalFlags (in addition to GMEM_DISCARDABLE)

#define GMEM_DISCARDED  &H4000
#define GMEM_LOCKCOUNT  &HFF

'  Local Memory Flags

#define LMEM_FIXED  &H0
#define LMEM_MOVEABLE  &H2
#define LMEM_NOCOMPACT  &H10
#define LMEM_NODISCARD  &H20
#define LMEM_ZEROINIT  &H40
#define LMEM_MODIFY  &H80
#define LMEM_DISCARDABLE  &HF00
#define LMEM_VALID_FLAGS  &HF72
#define LMEM_INVALID_HANDLE  &H8000

#define LHND  66		'  (LMEM_MOVEABLE + LMEM_ZEROINIT)
#define LPTR  64		'  (LMEM_FIXED + LMEM_ZEROINIT)

#define NONZEROLHND  &H2
#define NONZEROLPTR  &H0

' Flags returned by LocalFlags (in addition to LMEM_DISCARDABLE)

#define LMEM_DISCARDED  &H4000
#define LMEM_LOCKCOUNT  &HFF

'  dwCreationFlag values

#define DEBUG_PROCESS  &H1
#define DEBUG_ONLY_THIS_PROCESS  &H2

#define CREATE_SUSPENDED  &H4
#define DETACHED_PROCESS  &H8
#define CREATE_NEW_CONSOLE  &H10

#define NORMAL_PRIORITY_CLASS  &H20
#define IDLE_PRIORITY_CLASS  &H40
#define HIGH_PRIORITY_CLASS  &H80
#define REALTIME_PRIORITY_CLASS  &H100

#define CREATE_NEW_PROCESS_GROUP  &H200
#define CREATE_NO_WINDOW  &H8000000

#define STARTF_USESHOWWINDOW  &H1
#define STARTF_USESIZE  &H2
#define STARTF_USEPOSITION  &H4
#define STARTF_USECOUNTCHARS  &H8
#define STARTF_USEFILLATTRIBUTE  &H10
#define STARTF_RUNFULLSCREEN  &H20        '  ignored for non-x86 platforms
#define STARTF_FORCEONFEEDBACK  &H40
#define STARTF_FORCEOFFFEEDBACK  &H80
#define STARTF_USESTDHANDLES  &H100

#define PROFILE_USER  &H10000000
#define PROFILE_KERNEL  &H20000000
#define PROFILE_SERVER  &H40000000

#define MAlong  &H7FFFFFFF
#define THREAD_BASE_PRIORITY_MIN  (-2)
#define THREAD_BASE_PRIORITY_MAX  2
#define THREAD_BASE_PRIORITY_LOWRT  15
#define THREAD_BASE_PRIORITY_IDLE  (-15)
#define THREAD_PRIORITY_LOWEST  (-2)
#define THREAD_PRIORITY_BELOW_NORMAL  (-1)
#define THREAD_PRIORITY_NORMAL  0
#define THREAD_PRIORITY_HIGHEST  2
#define THREAD_PRIORITY_ABOVE_NORMAL  1
#define THREAD_PRIORITY_ERROR_RETURN  &H7FFFFFFF

#define THREAD_PRIORITY_TIME_CRITICAL  15
#define THREAD_PRIORITY_IDLE  (-15)

'  DllMain reason flags

#define DLL_PROCESS_DETACH  0
#define DLL_PROCESS_ATTACH  1
#define DLL_THREAD_ATTACH  2
#define DLL_THREAD_DETACH  3

'  standard io handles

#define STD_ERR_HANDLE  (-12)
#define STD_ERROR_HANDLE  (-12)
#define STD_OUTPUT_HANDLE  (-11)
#define STD_INPUT_HANDLE  (-10)

#define INVALID_HANDLE_VALUE  (-1)

#define FORMAT_MESSAGE_ALLOCATE_BUFFER  &H100
#define FORMAT_MESSAGE_IGNORE_INSERTS  &H200
#define FORMAT_MESSAGE_FROM_STRING  &H400
#define FORMAT_MESSAGE_FROM_HMODULE  &H800
#define FORMAT_MESSAGE_FROM_SYSTEM  &H1000
#define FORMAT_MESSAGE_ARGUMENT_ARRAY  &H2000
#define FORMAT_MESSAGE_MAX_WIDTH_MASK  &HFF

'  dwPlatformId defines

#define VER_PLATFORM_WIN32s  0
#define VER_PLATFORM_WIN32_WINDOWS  1
#define VER_PLATFORM_WIN32_NT  2

'  Serial provider Type

#define SP_SERIALCOMM  &H1

'  Provider SubTypes

#define PST_UNSPECIFIED  &H0
#define PST_RS232  &H1
#define PST_PARALLELPORT  &H2
#define PST_RS422  &H3
#define PST_RS423  &H4
#define PST_RS449  &H5
#define PST_FAX  &H21
#define PST_SCANNER  &H22
#define PST_NETWORK_BRIDGE  &H100
#define PST_LAT  &H101
#define PST_TCPIP_TELNET  &H102
#define PST_X25  &H103

'  Provider capabilities flags

#define PCF_DTRDSR  &H1
#define PCF_RTSCTS  &H2
#define PCF_RLSD  &H4
#define PCF_PARITY_CHECK  &H8
#define PCF_XONXOFF  &H10
#define PCF_SETXCHAR  &H20
#define PCF_TOTALTIMEOUTS  &H40
#define PCF_INTTIMEOUTS  &H80
#define PCF_SPECIALCHARS  &H100
#define PCF_16BITMODE  &H200

'  Comm provider settable parameters

#define SP_PARITY  &H1
#define SP_BAUD  &H2
#define SP_DATABITS  &H4
#define SP_STOPBITS  &H8
#define SP_HANDSHAKING  &H10
#define SP_PARITY_CHECK  &H20
#define SP_RLSD  &H40

'  Settable baud rates in the provider

#define BAUD_075  &H1
#define BAUD_110  &H2
#define BAUD_134_5  &H4
#define BAUD_150  &H8
#define BAUD_300  &H10
#define BAUD_600  &H20
#define BAUD_1200  &H40
#define BAUD_1800  &H80
#define BAUD_2400  &H100
#define BAUD_4800  &H200
#define BAUD_7200  &H400
#define BAUD_9600  &H800
#define BAUD_14400  &H1000
#define BAUD_19200  &H2000
#define BAUD_38400  &H4000
#define BAUD_56K  &H8000
#define BAUD_128K  &H10000
#define BAUD_115200  &H20000
#define BAUD_57600  &H40000
#define BAUD_USER  &H10000000

'  Settable Data Bits

#define DATABITS_5  &H1
#define DATABITS_6  &H2
#define DATABITS_7  &H4
#define DATABITS_8  &H8
#define DATABITS_16  &H10
#define DATABITS_16X  &H20

'  Settable Stop and Parity bits.

#define STOPBITS_10  &H1
#define STOPBITS_15  &H2
#define STOPBITS_20  &H4
#define PARITY_NONE  &H100
#define PARITY_ODD  &H200
#define PARITY_EVEN  &H400
#define PARITY_MARK  &H800
#define PARITY_SPACE  &H1000

#define NOPARITY  0
#define ODDPARITY  1
#define EVENPARITY  2
#define MARKPARITY  3
#define SPACEPARITY  4

#define ONESTOPBIT  0
#define ONE5STOPBITS  1
#define TWOSTOPBITS  2

#define IGNORE  0 		'  Ignore signal
#define INFINITE  &HFFFFFFFF  	'  Infinite timeout

'  Comm Baud Rate indices

#define CBR_110  110
#define CBR_300  300
#define CBR_600  600
#define CBR_1200  1200
#define CBR_2400  2400
#define CBR_4800  4800
#define CBR_9600  9600
#define CBR_14400  14400
#define CBR_19200  19200
#define CBR_38400  38400
#define CBR_56000  56000
#define CBR_57600  57600
#define CBR_115200  115200
#define CBR_128000  128000
#define CBR_256000  256000

'  DTR Control Flow Values.

#define DTR_CONTROL_DISABLE  &H0
#define DTR_CONTROL_ENABLE  &H1
#define DTR_CONTROL_HANDSHAKE  &H2

'  RTS Control Flow Values

#define RTS_CONTROL_DISABLE  &H0
#define RTS_CONTROL_ENABLE  &H1
#define RTS_CONTROL_HANDSHAKE  &H2
#define RTS_CONTROL_TOGGLE  &H3

'  Escape Functions

#define SETXOFF  1  		'  Simulate XOFF received
#define SETXON  2 		'  Simulate XON received
#define SETRTS  3 		'  Set RTS high
#define CLRRTS  4 		'  Set RTS low
#define SETDTR  5 		'  Set DTR high
#define CLRDTR  6 		'  Set DTR low
#define RESETDEV  7       	'  Reset device if possible
#define SETBREAK  8  		'  Set the device break line
#define CLRBREAK  9 		'  Clear the device break line

'  PURGE function flags.	

#define PURGE_TXABORT  &H1     	'  Kill the pending/current writes to the comm port.
#define PURGE_RXABORT  &H2     	'  Kill the pending/current reads to the comm port.
#define PURGE_TXCLEAR  &H4     	'  Kill the transmit queue if there.
#define PURGE_RXCLEAR  &H8     	'  Kill the Typeahead buffer if there.

'  Locale Types.
'  These Types are used for the GetLocaleInfoW NLS API routine.

#define LOCALE_SYSTEM_DEFAULT  &H800
#define LOCALE_USER_DEFAULT  &H400

'  LOCALE_NOUSEROVERRIDE is also used in GetTimeFormatW and GetDateFormatW.

#define LOCALE_NOUSEROVERRIDE  &H80000000  	'  do not use user overrides

#define LOCALE_ILANGUAGE  &H1         	'  language id
#define LOCALE_SLANGUAGE  &H2         	'  localized name of language
#define LOCALE_SENGLANGUAGE  &H1001      	'  English name of language
#define LOCALE_SABBREVLANGNAME  &H3         	'  abbreviated language name
#define LOCALE_SNATIVELANGNAME  &H4         	'  native name of language
#define LOCALE_ICOUNTRY  &H5         	'  country code
#define LOCALE_SCOUNTRY  &H6         	'  localized name of country
#define LOCALE_SENGCOUNTRY  &H1002      	'  English name of country
#define LOCALE_SABBREVCTRYNAME  &H7         	'  abbreviated country name
#define LOCALE_SNATIVECTRYNAME  &H8         	'  native name of country
#define LOCALE_IDEFAULTLANGUAGE  &H9         	'  default language id
#define LOCALE_IDEFAULTCOUNTRY  &HA         	'  default country code
#define LOCALE_IDEFAULTCODEPAGE  &HB         	'  default code page

#define LOCALE_SLIST  &HC         	'  list item separator
#define LOCALE_IMEASURE  &HD         	'  0 = metric, 1 = US

#define LOCALE_SDECIMAL  &HE         	'  decimal separator
#define LOCALE_STHOUSAND  &HF         	'  thousand separator
#define LOCALE_SGROUPING  &H10        	'  digit grouping
#define LOCALE_IDIGITS  &H11       	'  number of fractional digits
#define LOCALE_ILZERO  &H12        	'  leading zeros for decimal
#define LOCALE_SNATIVEDIGITS  &H13        	'  native ascii 0-9

#define LOCALE_SCURRENCY  &H14        	'  local monetary symbol
#define LOCALE_SINTLSYMBOL  &H15        	'  intl monetary symbol
#define LOCALE_SMONDECIMALSEP  &H16        	'  monetary decimal separator
#define LOCALE_SMONTHOUSANDSEP  &H17        	'  monetary thousand separator
#define LOCALE_SMONGROUPING  &H18        	'  monetary grouping
#define LOCALE_ICURRDIGITS  &H19        	'  * local monetary digits
#define LOCALE_IINTLCURRDIGITS  &H1A        	'  * intl monetary digits
#define LOCALE_ICURRENCY  &H1B        	'  positive currency mode
#define LOCALE_INEGCURR  &H1C        	'  negative currency mode

#define LOCALE_SDATE  &H1D        	'  date separator
#define LOCALE_STIME  &H1E        	'  time separator
#define LOCALE_SSHORTDATE  &H1F        	'  short date format string
#define LOCALE_integerDATE  &H20        	'  long date format string
#define LOCALE_STIMEFORMAT  &H1003      	'  time format string
#define LOCALE_IDATE  &H21        	'  short date format ordering
#define LOCALE_ILDATE  &H22        	'  long date format ordering
#define LOCALE_ITIME  &H23        	'  time format specifier
#define LOCALE_ICENTURY  &H24        	'  century format specifier
#define LOCALE_ITLZERO  &H25        	'  leading zeros in time field
#define LOCALE_IDAYLZERO  &H26        	'  leading zeros in day field
#define LOCALE_IMONLZERO  &H27        	'  leading zeros in month field
#define LOCALE_S1159  &H28        	'  AM designator
#define LOCALE_S2359  &H29        	'  PM designator

#define LOCALE_SDAYNAME1  &H2A        	'  long name for Monday
#define LOCALE_SDAYNAME2  &H2B        	'  long name for Tuesday
#define LOCALE_SDAYNAME3  &H2C        	'  long name for Wednesday
#define LOCALE_SDAYNAME4  &H2D        	'  long name for Thursday
#define LOCALE_SDAYNAME5  &H2E        	'  long name for Friday
#define LOCALE_SDAYNAME6  &H2F        	'  long name for Saturday
#define LOCALE_SDAYNAME7  &H30        	'  long name for Sunday
#define LOCALE_SABBREVDAYNAME1  &H31        	'  abbreviated name for Monday
#define LOCALE_SABBREVDAYNAME2  &H32        	'  abbreviated name for Tuesday
#define LOCALE_SABBREVDAYNAME3  &H33        	'  abbreviated name for Wednesday
#define LOCALE_SABBREVDAYNAME4  &H34        	'  abbreviated name for Thursday
#define LOCALE_SABBREVDAYNAME5  &H35        	'  abbreviated name for Friday
#define LOCALE_SABBREVDAYNAME6  &H36        	'  abbreviated name for Saturday
#define LOCALE_SABBREVDAYNAME7  &H37        	'  abbreviated name for Sunday
#define LOCALE_SMONTHNAME1  &H38        	'  long name for January
#define LOCALE_SMONTHNAME2  &H39        	'  long name for February
#define LOCALE_SMONTHNAME3  &H3A        	'  long name for March
#define LOCALE_SMONTHNAME4  &H3B        	'  long name for April
#define LOCALE_SMONTHNAME5  &H3C        	'  long name for May
#define LOCALE_SMONTHNAME6  &H3D        	'  long name for June
#define LOCALE_SMONTHNAME7  &H3E        	'  long name for July
#define LOCALE_SMONTHNAME8  &H3F        	'  long name for August
#define LOCALE_SMONTHNAME9  &H40        	'  long name for September
#define LOCALE_SMONTHNAME10  &H41        	'  long name for October
#define LOCALE_SMONTHNAME11  &H42        	'  long name for November
#define LOCALE_SMONTHNAME12  &H43        	'  long name for December
#define LOCALE_SABBREVMONTHNAME1  &H44        	'  abbreviated name for January
#define LOCALE_SABBREVMONTHNAME2  &H45        	'  abbreviated name for February
#define LOCALE_SABBREVMONTHNAME3  &H46        	'  abbreviated name for March
#define LOCALE_SABBREVMONTHNAME4  &H47        	'  abbreviated name for April
#define LOCALE_SABBREVMONTHNAME5  &H48        	'  abbreviated name for May
#define LOCALE_SABBREVMONTHNAME6  &H49        	'  abbreviated name for June
#define LOCALE_SABBREVMONTHNAME7  &H4A        	'  abbreviated name for July
#define LOCALE_SABBREVMONTHNAME8  &H4B        	'  abbreviated name for August
#define LOCALE_SABBREVMONTHNAME9  &H4C        	'  abbreviated name for September
#define LOCALE_SABBREVMONTHNAME10  &H4D        	'  abbreviated name for October
#define LOCALE_SABBREVMONTHNAME11  &H4E        	'  abbreviated name for November
#define LOCALE_SABBREVMONTHNAME12  &H4F        	'  abbreviated name for December
#define LOCALE_SABBREVMONTHNAME13  &H100F

#define LOCALE_SPOSITIVESIGN  &H50        	'  positive sign
#define LOCALE_SNEGATIVESIGN  &H51        	'  negative sign
#define LOCALE_IPOSSIGNPOSN  &H52        	'  positive sign position
#define LOCALE_INEGSIGNPOSN  &H53        	'  negative sign position
#define LOCALE_IPOSSYMPRECEDES  &H54        	'  mon sym precedes pos amt
#define LOCALE_IPOSSEPBYSPACE  &H55        	'  mon sym sep by space from pos amt
#define LOCALE_INEGSYMPRECEDES  &H56        	'  mon sym precedes neg amt
#define LOCALE_INEGSEPBYSPACE  &H57        	'  mon sym sep by space from neg amt

'  Time Flags for GetTimeFormatW.

#define TIME_NOMINUTESORSECONDS  &H1         	'  do not use minutes or seconds
#define TIME_NOSECONDS  &H2         	'  do not use seconds
#define TIME_NOTIMEMARKER  &H4         	'  do not use time marker
#define TIME_FORCE24HOURFORMAT  &H8         	'  always use 24 hour format

'  Date Flags for GetDateFormatW.

#define DATE_SHORTDATE  &H1         	'  use short date picture
#define DATE_LONGDATE  &H2         	'  use long date picture

#define TIME_ZONE_ID_INVALID  &HFFFFFFFF
#define TIME_ZONE_ID_UNKNOWN  0
#define TIME_ZONE_ID_STANDARD  1
#define TIME_ZONE_ID_DAYLIGHT  2

#define HEAP_NO_SERIALIZE  &H1
#define HEAP_GROWABLE  &H2
#define HEAP_GENERATE_EXCEPTIONS  &H4
#define HEAP_ZERO_MEMORY  &H8

'  ControlKeyState flags

#define RIGHT_ALT_PRESSED  &H1     	'  the right alt key is pressed.
#define LEFT_ALT_PRESSED  &H2     	'  the left alt key is pressed.
#define RIGHT_CTRL_PRESSED  &H4     	'  the right ctrl key is pressed.
#define LEFT_CTRL_PRESSED  &H8     	'  the left ctrl key is pressed.
#define SHIFT_PRESSED  &H10    	'  the shift key is pressed.
#define NUMLOCK_ON  &H20    	'  the numlock light is on.
#define SCROLLLOCK_ON  &H40    	'  the scrolllock light is on.
#define CAPSLOCK_ON  &H80    	'  the capslock light is on.
#define ENHANCED_KEY  &H100   	'  the key is enhanced.

'  ButtonState flags

#define FROM_LEFT_1ST_BUTTON_PRESSED  &H1
#define RIGHTMOST_BUTTON_PRESSED  &H2
#define FROM_LEFT_2ND_BUTTON_PRESSED  &H4
#define FROM_LEFT_3RD_BUTTON_PRESSED  &H8
#define FROM_LEFT_4TH_BUTTON_PRESSED  &H10

'  EventFlags

#define MOUSE_MOVED  &H1
#define DOUBLE_CLICK  &H2

'  EventType flags

#define EVT_KEY_EVENT  &H1     	'  Event contains key event record
#define EVT_MOUSE_EVENT  &H2     	'  Event contains mouse event record
#define EVT_WINDOW_BUFFER_SIZE_EVENT  &H4     	'  Event contains window change event record
#define EVT_MENU_EVENT  &H8     	'  Event contains menu event record
#define EVT_FOCUS_EVENT  &H10    	'  event contains focus change

'  Attributes flags

#define FOREGROUND_BLUE  &H1     	'  text color contains blue.
#define FOREGROUND_GREEN  &H2     	'  text color contains green.
#define FOREGROUND_RED  &H4     	'  text color contains red.
#define FOREGROUND_INTENSITY  &H8     	'  text color is intensified.
#define BACKGROUND_BLUE  &H10    	'  background color contains blue.
#define BACKGROUND_GREEN  &H20    	'  background color contains green.
#define BACKGROUND_RED  &H40    	'  background color contains red.
#define BACKGROUND_INTENSITY  &H80    	'  background color is intensified.
#define CONSOLE_BLACKONWHITE  &HF0    	'  black text on white background
#define CONSOLE_WHITEONBLACK  &H7     	'  white text on black background

#define CTRL_C_EVENT  0
#define CTRL_BREAK_EVENT  1
#define CTRL_CLOSE_EVENT  2
'  3 is reserved!
'  4 is reserved!
#define CTRL_LOGOFF_EVENT  5
#define CTRL_SHUTDOWN_EVENT  6

'  Input Mode flags

#define ENABLE_PROCESSED_INPUT  &H1
#define ENABLE_LINE_INPUT  &H2
#define ENABLE_ECHO_INPUT  &H4
#define ENABLE_WINDOW_INPUT  &H8
#define ENABLE_MOUSE_INPUT  &H10

'  Output Mode flags

#define ENABLE_PROCESSED_OUTPUT  &H1
#define ENABLE_WRAP_AT_EOL_OUTPUT  &H2

#define CONSOLE_TEXTMODE_BUFFER  1

#define WAIT_FAILED  &HFFFFFFFF
#define WAIT_OBJECT_0  &H0
#define WAIT_ABANDONED  &H00000080
#define WAIT_ABANDONED_0  &H00000080
#define WAIT_IO_COMPLETION  &H000000C0

#define STILL_ACTIVE  &H00000103

#define HINSTANCE_ERROR  32

#define NORM_CURSOR_SIZE  10
#define SOLID_CURSOR_SIZE  99
#define NOCURSOR  0
#define SOLIDCURSOR  1
#define NORMALCURSOR  2

' for EnumSystemLocales()

#define LCID_INSTALLED  1  ' Enumerate only installed locale identifiers
#define LCID_SUPPORTED  2  ' Enumerate all supported locale identifiers

' Exception Constants

' Most or all of the following are sometimes referred to As STATUS_
' codes rather than EXCEPTION_ codes - eg., STATUS_ACCESS_VIOLATION, etc.

#define EXCEPTION_ACCESS_VIOLATION  &HC0000005
#define EXCEPTION_ARRAY_BOUNDS_EXCEEDED  &HC000008C
#define EXCEPTION_BREAKPOINT  &H80000003
#define EXCEPTION_CONTROL_C_EXIT  &HC000013A
#define EXCEPTION_DATAType_MISALIGNMENT  &H80000002
#define EXCEPTION_FLOAT_DENORMAL_OPERAND  &HC000008D
#define EXCEPTION_FLOAT_DIVIDE_BY_ZERO  &HC000008E
#define EXCEPTION_FLOAT_INEXACT_RESULT  &HC000008F
#define EXCEPTION_FLOAT_INVALID_OPERATION  &HC0000090
#define EXCEPTION_FLOAT_OVERFLOW  &HC0000091
#define EXCEPTION_FLOAT_STACK_CHECK  &HC0000092
#define EXCEPTION_FLOAT_UNDERFLOW  &HC0000093
#define EXCEPTION_GUARD_PAGE  &H80000001
#define EXCEPTION_ILLEGAL_INSTRUCTION  &HC000001D
#define EXCEPTION_IN_PAGE_ERROR  &HC0000006
#define EXCEPTION_INT_DIVIDE_BY_ZERO  &HC0000094
#define EXCEPTION_INT_OVERFLOW  &HC0000095
#define EXCEPTION_INVALID_DISPOSITION  &HC0000026
#define EXCEPTION_NONCONTINUABLE_EXCEPTION  &HC0000025
#define EXCEPTION_PRIV_INSTRUCTION  &HC0000096
#define EXCEPTION_SINGLE_STEP  &H80000004
#define EXCEPTION_STACK_OVERFLOW  &HC00000FD

#define EXCEPTION_FLT_DENORMAL_OPERAND  &HC000008D
#define EXCEPTION_FLT_DIVIDE_BY_ZERO  &HC000008E
#define EXCEPTION_FLT_INEXACT_RESULT  &HC000008F
#define EXCEPTION_FLT_INVALID_OPERATION  &HC0000090
#define EXCEPTION_FLT_OVERFLOW  &HC0000091
#define EXCEPTION_FLT_STACK_CHECK  &HC0000092
#define EXCEPTION_FLT_UNDERFLOW  &HC0000093

'CONTEXT record .ContextFlags member

#define CONTEXT_CONTROL  &H10001
#define CONTEXT_INTEGER  &H10002
#define CONTEXT_SEGMENTS  &H10004
#define CONTEXT_FLOATING_POINT  &H10008
#define CONTEXT_DEBUG_REGISTERS  &H10010
#define CONTEXT_FULL  &H10007

#define SIZE_OF_80387_REGISTERS  80
#define CONTEXT_i386  &H10000
#define CONTEXT_i486  &H10000

#define EXCEPTION_MAXIMUM_PARAMETERS  15 		'maximum number of elements in EXCEPTION_RECORD.ExceptionInformation[]

#define EXCEPTION_CONTINUABLE  0		'flag for EXCEPTION_RECORD .ExceptionFlags
#define EXCEPTION_NONCONTINUABLE  1		'flag for EXCEPTION_RECORD .ExceptionFlags

#define EXCEPTION_CONTINUE_SEARCH   0
#define EXCEPTION_EXECUTE_HANDLER   1
#define EXCEPTION_CONTINUE_EXECUTION  (-1)

'  Operating System Error Constants

#define ERROR_SUCCESS     0
#define ERROR_INVALID_FUNCTION     1
#define ERROR_FILE_NOT_FOUND     2
#define ERROR_PATH_NOT_FOUND     3
#define ERROR_TOO_MANY_OPEN_FILES     4
#define ERROR_ACCESS_DENIED     5
#define ERROR_INVALID_HANDLE     6
#define ERROR_ARENA_TRASHED     7
#define ERROR_NOT_ENOUGH_MEMORY     8
#define ERROR_INVALID_BLOCK     9
#define ERROR_BAD_ENVIRONMENT    10
#define ERROR_BAD_FORMAT    11
#define ERROR_INVALID_ACCESS    12
#define ERROR_INVALID_DATA    13
#define ERROR_OUTOFMEMORY    14
#define ERROR_INVALID_DRIVE    15
#define ERROR_CURRENT_DIRECTORY    16
#define ERROR_NOT_SAME_DEVICE    17
#define ERROR_NO_MORE_FILES    18
#define ERROR_WRITE_PROTECT    19
#define ERROR_BAD_UNIT    20
#define ERROR_NOT_READY    21
#define ERROR_BAD_COMMAND    22
#define ERROR_CRC    23
#define ERROR_BAD_LENGTH    24
#define ERROR_SEEK    25
#define ERROR_NOT_DOS_DISK    26
#define ERROR_SECTOR_NOT_FOUND    27
#define ERROR_OUT_OF_PAPER    28
#define ERROR_WRITE_FAULT    29
#define ERROR_READ_FAULT    30
#define ERROR_GEN_FAILURE    31
#define ERROR_SHARING_VIOLATION    32
#define ERROR_LOCK_VIOLATION    33
#define ERROR_WRONG_DISK    34
#define ERROR_SHARING_BUFFER_EXCEEDED    36
#define ERROR_HANDLE_EOF    38
#define ERROR_HANDLE_DISK_FULL    39
#define ERROR_NOT_SUPPORTED    50
#define ERROR_REM_NOT_LIST    51
#define ERROR_DUP_NAME    52
#define ERROR_BAD_NETPATH    53
#define ERROR_NETWORK_BUSY    54
#define ERROR_DEV_NOT_EXIST    55
#define ERROR_TOO_MANY_CMDS    56
#define ERROR_ADAP_HDW_ERR    57
#define ERROR_BAD_NET_RESP    58
#define ERROR_UNEXP_NET_ERR    59
#define ERROR_BAD_REM_ADAP    60
#define ERROR_PRINTQ_FULL    61
#define ERROR_NO_SPOOL_SPACE    62
#define ERROR_PRINT_CANCELLED    63
#define ERROR_NETNAME_DELETED    64
#define ERROR_NETWORK_ACCESS_DENIED    65
#define ERROR_BAD_DEV_Type    66
#define ERROR_BAD_NET_NAME    67
#define ERROR_TOO_MANY_NAMES    68
#define ERROR_TOO_MANY_SESS    69
#define ERROR_SHARING_PAUSED    70
#define ERROR_REQ_NOT_ACCEP    71
#define ERROR_REDIR_PAUSED    72
#define ERROR_FILE_EXISTS    80
#define ERROR_CANNOT_MAKE    82
#define ERROR_FAIL_I24    83
#define ERROR_OUT_OF_STRUCTURES    84
#define ERROR_ALREADY_ASSIGNED    85
#define ERROR_INVALID_PASSWORD    86
#define ERROR_INVALID_PARAMETER    87
#define ERROR_NET_WRITE_FAULT    88
#define ERROR_NO_PROC_SLOTS    89
#define ERROR_TOO_MANY_SEMAPHORES   100
#define ERROR_EXCL_SEM_ALREADY_OWNED   101
#define ERROR_SEM_IS_SET   102
#define ERROR_TOO_MANY_SEM_REQUESTS   103
#define ERROR_INVALID_AT_INTERRUPT_TIME   104
#define ERROR_SEM_OWNER_DIED   105
#define ERROR_SEM_USER_LIMIT   106
#define ERROR_DISK_CHANGE   107
#define ERROR_DRIVE_LOCKED   108
#define ERROR_BROKEN_PIPE   109
#define ERROR_OPEN_FAILED   110
#define ERROR_BUFFER_OVERFLOW   111
#define ERROR_DISK_FULL   112
#define ERROR_NO_MORE_SEARCH_HANDLES   113
#define ERROR_INVALID_TARGET_HANDLE   114
#define ERROR_INVALID_CATEGORY   117
#define ERROR_INVALID_VERIFY_SWITCH   118
#define ERROR_BAD_DRIVER_LEVEL   119
#define ERROR_CALL_NOT_IMPLEMENTED   120
#define ERROR_SEM_TIMEOUT   121
#define ERROR_INSUFFICIENT_BUFFER   122
#define ERROR_INVALID_NAME   123
#define ERROR_INVALID_LEVEL   124
#define ERROR_NO_VOLUME_LABEL   125
#define ERROR_MOD_NOT_FOUND   126
#define ERROR_PROC_NOT_FOUND   127
#define ERROR_WAIT_NO_CHILDREN   128
#define ERROR_CHILD_NOT_COMPLETE   129
#define ERROR_DIRECT_ACCESS_HANDLE   130
#define ERROR_NEGATIVE_SEEK   131
#define ERROR_SEEK_ON_DEVICE   132
#define ERROR_IS_JOIN_TARGET   133
#define ERROR_IS_JOINED   134
#define ERROR_IS_SUBSTED   135
#define ERROR_NOT_JOINED   136
#define ERROR_NOT_SUBSTED   137
#define ERROR_JOIN_TO_JOIN   138
#define ERROR_SUBST_TO_SUBST   139
#define ERROR_JOIN_TO_SUBST   140
#define ERROR_SUBST_TO_JOIN   141
#define ERROR_BUSY_DRIVE   142
#define ERROR_SAME_DRIVE   143
#define ERROR_DIR_NOT_ROOT   144
#define ERROR_DIR_NOT_EMPTY   145
#define ERROR_IS_SUBST_PATH   146
#define ERROR_IS_JOIN_PATH   147
#define ERROR_PATH_BUSY   148
#define ERROR_IS_SUBST_TARGET   149
#define ERROR_SYSTEM_TRACE   150
#define ERROR_INVALID_EVENT_COUNT   151
#define ERROR_TOO_MANY_MUXWAITERS   152
#define ERROR_INVALID_LIST_FORMAT   153
#define ERROR_LABEL_TOO_LONG   154
#define ERROR_TOO_MANY_TCBS   155
#define ERROR_SIGNAL_REFUSED   156
#define ERROR_DISCARDED   157
#define ERROR_NOT_LOCKED   158
#define ERROR_BAD_THREADID_ADDR   159
#define ERROR_BAD_ARGUMENTS   160
#define ERROR_BAD_PATHNAME   161
#define ERROR_SIGNAL_PENDING   162
#define ERROR_MAX_THRDS_REACHED   164
#define ERROR_LOCK_FAILED   167
#define ERROR_BUSY   170
#define ERROR_CANCEL_VIOLATION   173
#define ERROR_ATOMIC_LOCKS_NOT_SUPPORTED   174
#define ERROR_INVALID_SEGMENT_NUMBER   180
#define ERROR_INVALID_ORDINAL   182
#define ERROR_ALREADY_EXISTS   183
#define ERROR_INVALID_FLAG_NUMBER   186
#define ERROR_SEM_NOT_FOUND   187
#define ERROR_INVALID_STARTING_CODESEG   188
#define ERROR_INVALID_STACKSEG   189
#define ERROR_INVALID_MODULEType   190
#define ERROR_INVALID_EXE_SIGNATURE   191
#define ERROR_EXE_MARKED_INVALID   192
#define ERROR_BAD_EXE_FORMAT   193
#define ERROR_ITERATED_DATA_EXCEEDS_64k   194
#define ERROR_INVALID_MINALLOCSIZE   195
#define ERROR_DYNLINK_FROM_INVALID_RING   196
#define ERROR_IOPL_NOT_ENABLED   197
#define ERROR_INVALID_SEGDPL   198
#define ERROR_AUTODATASEG_EXCEEDS_64k   199
#define ERROR_RING2SEG_MUST_BE_MOVABLE   200
#define ERROR_RELOC_CHAIN_XEEDS_SEGLIM   201
#define ERROR_INFLOOP_IN_RELOC_CHAIN   202
#define ERROR_ENVVAR_NOT_FOUND   203
#define ERROR_NO_SIGNAL_SENT   205
#define ERROR_FILENAME_EXCED_RANGE   206
#define ERROR_RING2_STACK_IN_USE   207
#define ERROR_META_EXPANSION_TOO_LONG   208
#define ERROR_INVALID_SIGNAL_NUMBER   209
#define ERROR_THREAD_1_INACTIVE   210
#define ERROR_LOCKED   212
#define ERROR_TOO_MANY_MODULES   214
#define ERROR_NESTING_NOT_ALLOWED   215
#define ERROR_BAD_PIPE   230
#define ERROR_PIPE_BUSY   231
#define ERROR_NO_DATA   232
#define ERROR_PIPE_NOT_CONNECTED   233
#define ERROR_MORE_DATA   234
#define ERROR_VC_DISCONNECTED   240
#define ERROR_INVALID_EA_NAME   254
#define ERROR_EA_LIST_INCONSISTENT   255
#define WAIT_TIMEOUT   258
#define ERROR_NO_MORE_ITEMS   259
#define ERROR_CANNOT_COPY   266
#define ERROR_DIRECTORY   267
#define ERROR_EAS_DIDNT_FIT   275
#define ERROR_EA_FILE_CORRUPT   276
#define ERROR_EA_TABLE_FULL   277
#define ERROR_INVALID_EA_HANDLE   278
#define ERROR_EAS_NOT_SUPPORTED   282
#define ERROR_NOT_OWNER   288
#define ERROR_TOO_MANY_POSTS   298
#define ERROR_MR_MID_NOT_FOUND   317
#define ERROR_INVALID_ADDRESS   487
#define ERROR_ARITHMETIC_OVERFLOW   534
#define ERROR_PIPE_CONNECTED   535
#define ERROR_PIPE_LISTENING   536
#define ERROR_EA_ACCESS_DENIED   994
#define ERROR_OPERATION_ABORTED   995
#define ERROR_IO_INCOMPLETE   996
#define ERROR_IO_PENDING   997
#define ERROR_NOACCESS   998
#define ERROR_SWAPERROR   999
#define ERROR_STACK_OVERFLOW  1001
#define ERROR_INVALID_MESSAGE  1002
#define ERROR_CAN_NOT_COMPLETE  1003
#define ERROR_INVALID_FLAGS  1004
#define ERROR_UNRECOGNIZED_VOLUME  1005
#define ERROR_FILE_INVALID  1006
#define ERROR_FULLSCREEN_MODE  1007
#define ERROR_NO_TOKEN  1008
#define ERROR_BADDB  1009
#define ERROR_BADKEY  1010
#define ERROR_CANTOPEN  1011
#define ERROR_CANTREAD  1012
#define ERROR_CANTWRITE  1013
#define ERROR_REGISTRY_RECOVERED  1014
#define ERROR_REGISTRY_CORRUPT  1015
#define ERROR_REGISTRY_IO_FAILED  1016
#define ERROR_NOT_REGISTRY_FILE  1017
#define ERROR_KEY_DELETED  1018
#define ERROR_NO_LOG_SPACE  1019
#define ERROR_KEY_HAS_CHILDREN  1020
#define ERROR_CHILD_MUST_BE_VOLATILE  1021
#define ERROR_NOTIFY_ENUM_DIR  1022
#define ERROR_DEPENDENT_SERVICES_RUNNING  1051
#define ERROR_INVALID_SERVICE_CONTROL  1052
#define ERROR_SERVICE_REQUEST_TIMEOUT  1053
#define ERROR_SERVICE_NO_THREAD  1054
#define ERROR_SERVICE_DATABASE_LOCKED  1055
#define ERROR_SERVICE_ALREADY_RUNNING  1056
#define ERROR_INVALID_SERVICE_ACCOUNT  1057
#define ERROR_SERVICE_DISABLED  1058
#define ERROR_CIRCULAR_DEPENDENCY  1059
#define ERROR_SERVICE_DOES_NOT_EXIST  1060
#define ERROR_SERVICE_CANNOT_ACCEPT_CTRL  1061
#define ERROR_SERVICE_NOT_ACTIVE  1062
#define ERROR_FAILED_SERVICE_CONTROLLER_CONNECT  1063
#define ERROR_EXCEPTION_IN_SERVICE  1064
#define ERROR_DATABASE_DOES_NOT_EXIST  1065
#define ERROR_SERVICE_SPECIFIC_ERROR  1066
#define ERROR_PROCESS_ABORTED  1067
#define ERROR_SERVICE_DEPENDENCY_FAIL  1068
#define ERROR_SERVICE_LOGON_FAILED  1069
#define ERROR_SERVICE_START_HANG  1070
#define ERROR_INVALID_SERVICE_LOCK  1071
#define ERROR_SERVICE_MARKED_FOR_DELETE  1072
#define ERROR_SERVICE_EXISTS  1073
#define ERROR_ALREADY_RUNNING_LKG  1074
#define ERROR_SERVICE_DEPENDENCY_DELETED  1075
#define ERROR_BOOT_ALREADY_ACCEPTED  1076
#define ERROR_SERVICE_NEVER_STARTED  1077
#define ERROR_DUPLICATE_SERVICE_NAME  1078
#define ERROR_END_OF_MEDIA  1100
#define ERROR_FILEMARK_DETECTED  1101
#define ERROR_BEGINNING_OF_MEDIA  1102
#define ERROR_SETMARK_DETECTED  1103
#define ERROR_NO_DATA_DETECTED  1104
#define ERROR_PARTITION_FAILURE  1105
#define ERROR_INVALID_BLOCK_LENGTH  1106
#define ERROR_DEVICE_NOT_PARTITIONED  1107
#define ERROR_UNABLE_TO_LOCK_MEDIA  1108
#define ERROR_UNABLE_TO_UNLOAD_MEDIA  1109
#define ERROR_MEDIA_CHANGED  1110
#define ERROR_BUS_RESET  1111
#define ERROR_NO_MEDIA_IN_DRIVE  1112
#define ERROR_NO_UNICODE_TRANSLATION  1113
#define ERROR_DLL_INIT_FAILED  1114
#define ERROR_SHUTDOWN_IN_PROGRESS  1115
#define ERROR_NO_SHUTDOWN_IN_PROGRESS  1116
#define ERROR_IO_DEVICE  1117
#define ERROR_SERIAL_NO_DEVICE  1118
#define ERROR_IRQ_BUSY  1119
#define ERROR_MORE_WRITES  1120
#define ERROR_COUNTER_TIMEOUT  1121
#define ERROR_FLOPPY_ID_MARK_NOT_FOUND  1122
#define ERROR_FLOPPY_WRONG_CYLINDER  1123
#define ERROR_FLOPPY_UNKNOWN_ERROR  1124
#define ERROR_FLOPPY_BAD_REGISTERS  1125
#define ERROR_DISK_RECALIBRATE_FAILED  1126
#define ERROR_DISK_OPERATION_FAILED  1127
#define ERROR_DISK_RESET_FAILED  1128
#define ERROR_EOM_OVERFLOW  1129
#define ERROR_NOT_ENOUGH_SERVER_MEMORY  1130
#define ERROR_POSSIBLE_DEADLOCK  1131
#define ERROR_MAPPED_ALIGNMENT  1132
#define ERROR_BAD_USERNAME  2202
#define ERROR_NOT_CONNECTED  2250
#define ERROR_OPEN_FILES  2401
#define ERROR_DEVICE_IN_USE  2404
#define ERROR_BAD_DEVICE  1200
#define ERROR_CONNECTION_UNAVAIL  1201
#define ERROR_DEVICE_ALREADY_REMEMBERED  1202
#define ERROR_NO_NET_OR_BAD_PATH  1203
#define ERROR_BAD_PROVIDER  1204
#define ERROR_CANNOT_OPEN_PROFILE  1205
#define ERROR_BAD_PROFILE  1206
#define ERROR_NOT_CONTAINER  1207
#define ERROR_EXTENDED_ERROR  1208
#define ERROR_INVALID_GROUPNAME  1209
#define ERROR_INVALID_COMPUTERNAME  1210
#define ERROR_INVALID_EVENTNAME  1211
#define ERROR_INVALID_DOMAINNAME  1212
#define ERROR_INVALID_SERVICENAME  1213
#define ERROR_INVALID_NETNAME  1214
#define ERROR_INVALID_SHARENAME  1215
#define ERROR_INVALID_PASSWORDNAME  1216
#define ERROR_INVALID_MESSAGENAME  1217
#define ERROR_INVALID_MESSAGEDEST  1218
#define ERROR_SESSION_CREDENTIAL_CONFLICT  1219
#define ERROR_REMOTE_SESSION_LIMIT_EXCEEDED  1220
#define ERROR_DUP_DOMAINNAME  1221
#define ERROR_NO_NETWORK  1222
#define ERROR_NOT_ALL_ASSIGNED  1300
#define ERROR_SOME_NOT_MAPPED  1301
#define ERROR_NO_QUOTAS_FOR_ACCOUNT  1302
#define ERROR_LOCAL_USER_SESSION_KEY  1303
#define ERROR_NULL_LM_PASSWORD  1304
#define ERROR_UNKNOWN_REVISION  1305
#define ERROR_REVISION_MISMATCH  1306
#define ERROR_INVALID_OWNER  1307
#define ERROR_INVALID_PRIMARY_GROUP  1308
#define ERROR_NO_IMPERSONATION_TOKEN  1309
#define ERROR_CANT_DISABLE_MANDATORY  1310
#define ERROR_NO_LOGON_SERVERS  1311
#define ERROR_NO_SUCH_LOGON_SESSION  1312
#define ERROR_NO_SUCH_PRIVILEGE  1313
#define ERROR_PRIVILEGE_NOT_HELD  1314
#define ERROR_INVALID_ACCOUNT_NAME  1315
#define ERROR_USER_EXISTS  1316
#define ERROR_NO_SUCH_USER  1317
#define ERROR_GROUP_EXISTS  1318
#define ERROR_NO_SUCH_GROUP  1319
#define ERROR_MEMBER_IN_GROUP  1320
#define ERROR_MEMBER_NOT_IN_GROUP  1321
#define ERROR_LAST_ADMIN  1322
#define ERROR_WRONG_PASSWORD  1323
#define ERROR_ILL_FORMED_PASSWORD  1324
#define ERROR_PASSWORD_RESTRICTION  1325
#define ERROR_LOGON_FAILURE  1326
#define ERROR_ACCOUNT_RESTRICTION  1327
#define ERROR_INVALID_LOGON_HOURS  1328
#define ERROR_INVALID_WORKSTATION  1329
#define ERROR_PASSWORD_EXPIRED  1330
#define ERROR_ACCOUNT_DISABLED  1331
#define ERROR_NONE_MAPPED  1332
#define ERROR_TOO_MANY_LUIDS_REQUESTED  1333
#define ERROR_LUIDS_EXHAUSTED  1334
#define ERROR_INVALID_SUB_AUTHORITY  1335
#define ERROR_INVALID_ACL  1336
#define ERROR_INVALID_SID  1337
#define ERROR_INVALID_SECURITY_DESCR  1338
#define ERROR_BAD_INHERITANCE_ACL  1340
#define ERROR_SERVER_DISABLED  1341
#define ERROR_SERVER_NOT_DISABLED  1342
#define ERROR_INVALID_ID_AUTHORITY  1343
#define ERROR_ALLOTTED_SPACE_EXCEEDED  1344
#define ERROR_INVALID_GROUP_ATTRIBUTES  1345
#define ERROR_BAD_IMPERSONATION_LEVEL  1346
#define ERROR_CANT_OPEN_ANONYMOUS  1347
#define ERROR_BAD_VALIDATION_CLASS  1348
#define ERROR_BAD_TOKEN_Type  1349
#define ERROR_NO_SECURITY_ON_OBJECT  1350
#define ERROR_CANT_ACCESS_DOMAIN_INFO  1351
#define ERROR_INVALID_SERVER_STATE  1352
#define ERROR_INVALID_DOMAIN_STATE  1353
#define ERROR_INVALID_DOMAIN_ROLE  1354
#define ERROR_NO_SUCH_DOMAIN  1355
#define ERROR_DOMAIN_EXISTS  1356
#define ERROR_DOMAIN_LIMIT_EXCEEDED  1357
#define ERROR_INTERNAL_DB_CORRUPTION  1358
#define ERROR_INTERNAL_ERROR  1359
#define ERROR_GENERIC_NOT_MAPPED  1360
#define ERROR_BAD_DESCRIPTOR_FORMAT  1361
#define ERROR_NOT_LOGON_PROCESS  1362
#define ERROR_LOGON_SESSION_EXISTS  1363
#define ERROR_NO_SUCH_PACKAGE  1364
#define ERROR_BAD_LOGON_SESSION_STATE  1365
#define ERROR_LOGON_SESSION_COLLISION  1366
#define ERROR_INVALID_LOGON_Type  1367
#define ERROR_CANNOT_IMPERSONATE  1368
#define ERROR_RXACT_INVALID_STATE  1369
#define ERROR_RXACT_COMMIT_FAILURE  1370
#define ERROR_SPECIAL_ACCOUNT  1371
#define ERROR_SPECIAL_GROUP  1372
#define ERROR_SPECIAL_USER  1373
#define ERROR_MEMBERS_PRIMARY_GROUP  1374
#define ERROR_TOKEN_ALREADY_IN_USE  1375
#define ERROR_NO_SUCH_ALIAS  1376
#define ERROR_MEMBER_NOT_IN_ALIAS  1377
#define ERROR_MEMBER_IN_ALIAS  1378
#define ERROR_ALIAS_EXISTS  1379
#define ERROR_LOGON_NOT_GRANTED  1380
#define ERROR_TOO_MANY_SECRETS  1381
#define ERROR_SECRET_TOO_LONG  1382
#define ERROR_INTERNAL_DB_ERROR  1383
#define ERROR_TOO_MANY_CONTEXT_IDS  1384
#define ERROR_LOGON_Type_NOT_GRANTED  1385
#define ERROR_NT_CROSS_ENCRYPTION_REQUIRED  1386
#define ERROR_NO_SUCH_MEMBER  1387
#define ERROR_INVALID_MEMBER  1388
#define ERROR_TOO_MANY_SIDS  1389
#define ERROR_LM_CROSS_ENCRYPTION_REQUIRED  1390
#define ERROR_NO_INHERITANCE  1391
#define ERROR_FILE_CORRUPT  1392
#define ERROR_DISK_CORRUPT  1393
#define ERROR_NO_USER_SESSION_KEY  1394
#define ERROR_INVALID_WINDOW_HANDLE  1400
#define ERROR_INVALID_MENU_HANDLE  1401
#define ERROR_INVALID_CURSOR_HANDLE  1402
#define ERROR_INVALID_ACCEL_HANDLE  1403
#define ERROR_INVALID_HOOK_HANDLE  1404
#define ERROR_INVALID_DWP_HANDLE  1405
#define ERROR_TLW_WITH_WSCHILD  1406
#define ERROR_CANNOT_FIND_WND_CLASS  1407
#define ERROR_WINDOW_OF_OTHER_THREAD  1408
#define ERROR_HOTKEY_ALREADY_REGISTERED  1409
#define ERROR_CLASS_ALREADY_EXISTS  1410
#define ERROR_CLASS_DOES_NOT_EXIST  1411
#define ERROR_CLASS_HAS_WINDOWS  1412
#define ERROR_INVALID_INDEX  1413
#define ERROR_INVALID_ICON_HANDLE  1414
#define ERROR_PRIVATE_DIALOG_INDEX  1415
#define ERROR_LISTBOX_ID_NOT_FOUND  1416
#define ERROR_NO_WILDCARD_CHARACTERS  1417
#define ERROR_CLIPBOARD_NOT_OPEN  1418
#define ERROR_HOTKEY_NOT_REGISTERED  1419
#define ERROR_WINDOW_NOT_DIALOG  1420
#define ERROR_CONTROL_ID_NOT_FOUND  1421
#define ERROR_INVALID_COMBOBOX_MESSAGE  1422
#define ERROR_WINDOW_NOT_COMBOBOX  1423
#define ERROR_INVALID_EDIT_HEIGHT  1424
#define ERROR_DC_NOT_FOUND  1425
#define ERROR_INVALID_HOOK_FILTER  1426
#define ERROR_INVALID_FILTER_PROC  1427
#define ERROR_HOOK_NEEDS_HMOD  1428
#define ERROR_GLOBAL_ONLY_HOOK  1429
#define ERROR_JOURNAL_HOOK_SET  1430
#define ERROR_HOOK_NOT_INSTALLED  1431
#define ERROR_INVALID_LB_MESSAGE  1432
#define ERROR_SETCOUNT_ON_BAD_LB  1433
#define ERROR_LB_WITHOUT_TABSTOPS  1434
#define ERROR_DESTROY_OBJECT_OF_OTHER_THREAD  1435
#define ERROR_CHILD_WINDOW_MENU  1436
#define ERROR_NO_SYSTEM_MENU  1437
#define ERROR_INVALID_MSGBOX_STYLE  1438
#define ERROR_INVALID_SPI_VALUE  1439
#define ERROR_SCREEN_ALREADY_LOCKED  1440
#define ERROR_HWNDS_HAVE_DIFF_PARENT  1441
#define ERROR_NOT_CHILD_WINDOW  1442
#define ERROR_INVALID_GW_COMMAND  1443
#define ERROR_INVALID_THREAD_ID  1444
#define ERROR_NON_MDICHILD_WINDOW  1445
#define ERROR_POPUP_ALREADY_ACTIVE  1446
#define ERROR_NO_SCROLLBARS  1447
#define ERROR_INVALID_SCROLLBAR_RANGE  1448
#define ERROR_INVALID_SHOWWIN_COMMAND  1449
#define ERROR_EVENTLOG_FILE_CORRUPT  1500
#define ERROR_EVENTLOG_CANT_START  1501
#define ERROR_LOG_FILE_FULL  1502
#define ERROR_EVENTLOG_FILE_CHANGED  1503
#define ERROR_INVALID_USER_BUFFER  1784
#define ERROR_UNRECOGNIZED_MEDIA  1785
#define ERROR_NO_TRUST_LSA_SECRET  1786
#define ERROR_NO_TRUST_SAM_ACCOUNT  1787
#define ERROR_TRUSTED_DOMAIN_FAILURE  1788
#define ERROR_TRUSTED_RELATIONSHIP_FAILURE  1789
#define ERROR_TRUST_FAILURE  1790
#define ERROR_NETLOGON_NOT_STARTED  1792
#define ERROR_ACCOUNT_EXPIRED  1793
#define ERROR_REDIRECTOR_HAS_OPEN_HANDLES  1794
#define ERROR_PRINTER_DRIVER_ALREADY_INSTALLED  1795
#define ERROR_UNKNOWN_PORT  1796
#define ERROR_UNKNOWN_PRINTER_DRIVER  1797
#define ERROR_UNKNOWN_PRINTPROCESSOR  1798
#define ERROR_INVALID_SEPARATOR_FILE  1799
#define ERROR_INVALID_PRIORITY  1800
#define ERROR_INVALID_PRINTER_NAME  1801
#define ERROR_PRINTER_ALREADY_EXISTS  1802
#define ERROR_INVALID_PRINTER_COMMAND  1803
#define ERROR_INVALID_DATAType  1804
#define ERROR_INVALID_ENVIRONMENT  1805
#define ERROR_NOLOGON_INTERDOMAIN_TRUST_ACCOUNT  1807
#define ERROR_NOLOGON_WORKSTATION_TRUST_ACCOUNT  1808
#define ERROR_NOLOGON_SERVER_TRUST_ACCOUNT  1809
#define ERROR_DOMAIN_TRUST_INCONSISTENT  1810
#define ERROR_SERVER_HAS_OPEN_HANDLES  1811
#define ERROR_RESOURCE_DATA_NOT_FOUND  1812
#define ERROR_RESOURCE_Type_NOT_FOUND  1813
#define ERROR_RESOURCE_NAME_NOT_FOUND  1814
#define ERROR_RESOURCE_LANG_NOT_FOUND  1815
#define ERROR_NOT_ENOUGH_QUOTA  1816
#define ERROR_INVALID_TIME  1901
#define ERROR_INVALID_FORM_NAME  1902
#define ERROR_INVALID_FORM_SIZE  1903
#define ERROR_ALREADY_WAITING  1904
#define ERROR_PRINTER_DELETED  1905
#define ERROR_INVALID_PRINTER_STATE  1906
#define ERROR_NO_BROWSER_SERVERS_FOUND  6118
#define ERROR_LAST_OS_ERROR  8191

#define SEVERITY_SUCCESS  0
#define SEVERITY_ERROR  1
#define FACILITY_NT_BIT  &H10000000
#define NOERROR  0
#define E_UNEXPECTED  &H8000FFFF
#define E_NOTIMPL  &H80004001
#define E_OUTOFMEMORY  &H8007000E
#define E_INVALIDARG  &H80070057
#define E_NOINTERFACE  &H80004002
#define E_POINTER  &H80004003
#define E_HANDLE  &H80070006
#define E_ABORT  &H80004004
#define E_FAIL  &H80004005
#define E_ACCESSDENIED  &H80070005

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

Declare Function AddAtom Alias "AddAtomA" (ByVal lpString As String) As Integer
Declare Function AllocConsole Alias "AllocConsole" () As Integer
Declare Function AreFileApisANSI Alias "AreFileApisANSI" () As Integer

Declare Function BackupRead Alias "BackupRead" (ByVal hFile As Integer, byref lpBuffer As BYTE, ByVal nNumberOfBytesToRead As Integer, byref lpNumberOfBytesRead As Integer, ByVal bAbort As Integer, ByVal bProcessSecurity As Integer, byref lpContext As ANY) As Integer
Declare Function BackupSeek Alias "BackupSeek" (ByVal hFile As Integer, ByVal dwLowBytesToSeek As Integer, ByVal dwHighBytesToSeek As Integer, byref lpdwLowByteSeeked As Integer, byref lpdwHighByteSeeked As Integer, byref lpContext As Integer) As Integer
Declare Function BackupWrite Alias "BackupWrite" (ByVal hFile As Integer, byref lpBuffer As BYTE, ByVal nNumberOfBytesToWrite As Integer, ByRef lpNumberOfBytesWritten As Integer, ByVal bAbort As Integer, ByVal bProcessSecurity As Integer, ByRef lpContext As Integer) As Integer
'Declare Function Beep Alias "Beep" (ByVal dwFreq As Integer, ByVal dwDuration As Integer) As Integer
Declare Function BeginUpdateResource Alias "BeginUpdateResourceA" (ByVal pFileName As String, ByVal bDeleteExistingResources As Integer) As Integer
Declare Function BuildCommDCB Alias "BuildCommDCBA" (ByVal lpDef As String, ByRef lpDCB As DCB) As Integer
Declare Function BuildCommDCBAndTimeouts Alias "BuildCommDCBAndTimeoutsA" (ByVal lpDef As String, ByRef lpDCB As DCB, ByRef lpCommTimeouts As COMMTIMEOUTS) As Integer

Declare Function CallNamedPipe Alias "CallNamedPipeA" (ByVal lpNamedPipeName As String, ByRef lpInBuffer As ANY, ByVal nInBufferSize As Integer, ByRef lpOutBuffer As ANY, ByVal nOutBufferSize As Integer, ByRef lpBytesRead As Integer, ByVal nTimeOut As Integer) As Integer
Declare Function ClearCommBreak Alias "ClearCommBreak" (ByVal nCid As Integer) As Integer
Declare Function ClearCommError Alias "ClearCommError" (ByVal hFile As Integer, ByRef lpErrors As Integer, ByRef lpStat As COMSTAT) As Integer
Declare Function CloseHandle Alias "CloseHandle" (ByVal hObject As Integer) As Integer
Declare Function CommConfigDialog Alias "CommConfigDialogA" (ByVal lpszName As String, ByVal hwnd As Integer, ByRef lpCC As COMMCONFIG) As Integer
Declare Function CompareFileTime Alias "CompareFileTime" ( ByRef lpFileTime1 As FILETIME, ByRef lpFileTime2 As FILETIME) As Integer
Declare Function CompareString Alias "CompareStringA" (ByVal Locale As Integer, ByVal dwCmpFlags As Integer, ByVal lpString1 As String, ByVal cchCount1 As Integer, ByVal lpString2 As String, ByVal cchCount2 As Integer) As Integer
Declare Function ConnectNamedPipe Alias "ConnectNamedPipe" (ByVal hNamedPipe As Integer, ByRef lpOverlapped As OVERLAPPED) As Integer
Declare Function ContinueDebugEvent Alias "ContinueDebugEvent" (ByVal dwProcessId As Integer, ByVal dwThreadId As Integer, ByVal dwContinueStatus As Integer) As Integer
Declare Function ConvertDefaultLocale Alias "ConvertDefaultLocale" (ByVal Locale As Integer) As Integer
Declare Function CopyFile Alias "CopyFileA" (ByVal lpExistingFileName As String, ByVal lpNewFileName As String, ByVal bFailIfExists As Integer) As Integer
Declare Function CreateConsoleScreenBuffer Alias "CreateConsoleScreenBuffer" (ByVal dwDesiredAccess As Integer, ByVal dwShareMode As Integer, ByRef lpSecurityAttributes As SECURITY_ATTRIBUTES, ByVal dwFlags As Integer, ByVal lpScreenBufferData As Integer) As Integer
Declare Function CreateDirectory Alias "CreateDirectoryA" (ByVal lpPathName As String, ByRef lpSecurityAttributes As SECURITY_ATTRIBUTES) As Integer
Declare Function CreateDirectoryEx Alias "CreateDirectoryExA" (ByVal lpTemplateDirectory As String, ByVal lpNewDirectory As String, ByRef lpSecurityAttributes As SECURITY_ATTRIBUTES) As Integer
Declare Function CreateEvent Alias "CreateEventA" ( ByRef lpEventAttributes As SECURITY_ATTRIBUTES, ByVal bManualReset As Integer, ByVal bInitialState As Integer, ByVal lpName As String) As Integer
Declare Function CreateFile Alias "CreateFileA" (ByVal lpFileName As String, ByVal dwDesiredAccess As Integer, ByVal dwShareMode As Integer, ByRef lpSecurityAttributes As SECURITY_ATTRIBUTES, ByVal dwCreationDisposition As Integer, ByVal dwFlagsAndAttributes As Integer, ByVal hTemplateFile As Integer) As Integer
Declare Function CreateFileMapping Alias "CreateFileMappingA" (ByVal hFile As Integer, ByRef lpFileMappigAttributes As SECURITY_ATTRIBUTES, ByVal flProtect As Integer, ByVal dwMaximumSizeHigh As Integer, ByVal dwMaximumSizeLow As Integer, ByVal lpName As String) As Integer
Declare Function CreateIoCompletionPort Alias "CreateIoCompletionPort" (ByVal FileHandle As Integer, ByVal ExistingCompletionPort As Integer, ByVal CompletionKey As Integer, ByVal NumberOfConcurrentThreads As Integer) As Integer
Declare Function CreateMailslot Alias "CreateMailslotA" (ByVal lpName As String, ByVal nMaxMessageSize As Integer, ByVal lReadTimeout As Integer, ByRef lpSecurityAttributes As SECURITY_ATTRIBUTES) As Integer
Declare Function CreateMutex Alias "CreateMutexA" ( ByRef lpMutexAttributes As SECURITY_ATTRIBUTES, ByVal bInitialOwner As Integer, ByVal lpName As String) As Integer
Declare Function CreateNamedPipe Alias "CreateNamedPipeA" (ByVal lpName As String, ByVal dwOpenMode As Integer, ByVal dwPipeMode As Integer, ByVal nMaxInstances As Integer, ByVal nOutBufferSize As Integer, ByVal nInBufferSize As Integer, ByVal nDefaultTimeOut As Integer, ByRef lpSecurityAttributes As SECURITY_ATTRIBUTES) As Integer
Declare Function CreatePipe Alias "CreatePipe" ( ByRef phReadPipe As Integer, ByRef phWritePipe As Integer, ByRef lpPipeAttributes As SECURITY_ATTRIBUTES, ByVal nSize As Integer) As Integer
Declare Function CreateProcess Alias "CreateProcessA" (ByVal lpApplicationName As String, ByVal lpCommandLine As String, ByRef lpProcessAttributes As SECURITY_ATTRIBUTES, ByRef lpThreadAttributes As SECURITY_ATTRIBUTES, ByVal bInheritHandles As Integer, ByVal dwCreationFlags As Integer, ByRef lpEnvironment As ANY, ByVal lpCurrentDriectory As String, ByRef lpStartupInfo As STARTUPINFO, ByRef lpProcessInformation As PROCESS_INFORMATION) As Integer
Declare Function CreateProcessAsUser Alias "CreateProcessAsUserA" (ByVal hToken As Integer, ByVal lpApplicationName As String, ByVal lpCommandLine As String, ByRef lpProcessAttributes As SECURITY_ATTRIBUTES, ByRef lpThreadAttributes As SECURITY_ATTRIBUTES, ByVal bInheritHandles As Integer, ByVal dwCreationFlags As Integer, ByVal lpEnvironment As String, ByVal lpCurrentDirectory As String, ByRef lpStartupInfo As STARTUPINFO, ByRef lpProcessInformation As PROCESS_INFORMATION) As Integer
Declare Function CreateRemoteThread Alias "CreateRemoteThread" (ByVal hProcess As Integer, ByRef lpThreadAttributes As SECURITY_ATTRIBUTES, ByVal dwStackSize As Integer, ByVal lpStartAddress As Integer, ByRef lpParameter As ANY, ByVal dwCreationFlags As Integer, ByRef lpThreadId As Integer) As Integer
Declare Function CreateSemaphore Alias "CreateSemaphoreA" ( ByRef lpSemaphoreAttributes As SECURITY_ATTRIBUTES, ByVal lInitialCount As Integer, ByVal lMaximumCount As Integer, ByVal lpName As String) As Integer
Declare Function CreateTapePartition Alias "CreateTapePartition" (ByVal hDevice As Integer, ByVal dwPartitionMethod As Integer, ByVal dwCount As Integer, ByVal dwSize As Integer) As Integer
Declare Function CreateThread Alias "CreateThread" ( ByRef lpThreadAttributes As SECURITY_ATTRIBUTES, ByVal dwStackSize As Integer, ByVal StartAddress As Integer, ByVal lpParameter As Integer, ByVal dwCreationFlags As Integer, ByRef lpThreadId As Integer) As Integer

Declare Function DebugActiveProcess Alias "DebugActiveProcess" (ByVal dwProcessId As Integer) As Integer
Declare Sub DebugBreak Alias "DebugBreak" ()
Declare Function DefineDosDevice Alias "DefineDosDeviceA" (ByVal dwFlags As Integer, ByVal lpDeviceName As String, ByVal lpTargetPath As String) As Integer
Declare Function DeleteAtom Alias "DeleteAtom" (ByVal nAtom As Integer) As Integer
Declare Sub DeleteCriticalSection Alias "DeleteCriticalSection" ( ByRef lpCriticalSection As CRITICAL_SECTION)
Declare Function DeleteFile Alias "DeleteFileA" (ByVal lpFileName As String) As Integer
Declare Function DeviceIoControl Alias "DeviceIoControl" (ByVal hDevice As Integer, ByVal dwIoControlCode As Integer, ByRef lpInBuffer As ANY, ByVal nInBufferSize As Integer, ByRef lpOutBuffer As ANY, ByVal nOutBufferSize As Integer, ByRef lpBytesReturned As Integer, ByRef lpOverlapped As OVERLAPPED) As Integer
Declare Function DisableThreadLibraryCalls Alias "DisableThreadLibraryCalls" (ByVal hLibModule As Integer) As Integer
Declare Function DisconnectNamedPipe Alias "DisconnectNamedPipe" (ByVal hNamedPipe As Integer) As Integer
Declare Function DosDateTimeToFileTime Alias "DosDateTimeToFileTime" (ByVal wFatDate As Integer, ByVal wFatTime As Integer, ByRef lpFileTime As FILETIME) As Integer
Declare Function DuplicateHandle Alias "DuplicateHandle" (ByVal hSourceProcessHandle As Integer, ByVal hSourceHandle As Integer, ByVal hTargetProcessHandle As Integer, ByRef lpTargetHandle As Integer, ByVal dwDesiredAccess As Integer, ByVal bInheritHandle As Integer, ByVal dwOptions As Integer) As Integer

Declare Function EndUpdateResource Alias "EndUpdateResourceA" (ByVal hUpdate As Integer, ByVal fDiscard As Integer) As Integer
Declare Sub EnterCriticalSection Alias "EnterCriticalSection" ( ByRef lpCriticalSection As CRITICAL_SECTION)
Declare Function EnumCalendarInfo Alias "EnumCalendarInfoA" (ByVal lpCalInfoEnumProc As Integer, ByVal Locale As Integer, ByVal Calendar As Integer, ByVal CalType As Integer) As Integer
Declare Function EnumDateFormats Alias "EnumDateFormats" (ByVal lpDateFmtEnumProc As Integer, ByVal Locale As Integer, ByVal dwFlags As Integer) As Integer
Declare Function EnumResourceLanguages Alias "EnumResourceLanguagesA" (ByVal hModule As Integer, ByVal lpType As String, ByVal lpName As String, ByVal lpEnumFunc As Integer, ByVal lParam As Integer) As Integer
Declare Function EnumResourceNames Alias "EnumResourceNamesA" (ByVal hModule As Integer, ByVal lpType As String, ByVal lpEnumFunc As Integer, ByVal lParam As Integer) As Integer
Declare Function EnumResourceTypes Alias "EnumResourceTypesA" (ByVal hModule As Integer, ByVal lpEnumFunc As Integer, ByVal lParam As Integer) As Integer
Declare Function EnumSystemCodePages Alias "EnumSystemCodePages" (ByVal lpCodePageEnumProc As Integer, ByVal dwFlags As Integer) As Integer
Declare Function EnumSystemLocales Alias "EnumSystemLocales" (ByVal lpLocaleEnumProc As Integer, ByVal dwFlags As Integer) As Integer
Declare Function EnumTimeFormats Alias "EnumTimeFormats" (ByVal lpTimeFmtEnumProc As Integer, ByVal Locale As Integer, ByVal dwFlags As Integer) As Integer
Declare Function EraseTape Alias "EraseTape" (ByVal hDevice As Integer, ByVal dwEraseType As Integer, ByVal bimmediate As Integer) As Integer
Declare Function EscapeCommFunction Alias "EscapeCommFunction" (ByVal nCid As Integer, ByVal nFunc As Integer) As Integer
Declare Sub ExitProcess Alias "ExitProcess" (ByVal uExitCode As Integer)
Declare Sub ExitThread Alias "ExitThread" (ByVal dwExitCode As Integer)
Declare Function ExpandEnvironmentStrings Alias "ExpandEnvironmentStringsA" (ByVal lpSrc As String, ByVal lpDst As String, ByVal nSize As Integer) As Integer

Declare Sub FatalAppExit Alias "FatalAppExitA" (ByVal uAction As Integer, ByVal lpMessageText As String)
Declare Sub FatalExit Alias "FatalExit" (ByVal code As Integer)
Declare Function FileTimeToDosDateTime Alias "FileTimeToDosDateTime" ( ByRef lpFileTime As FILETIME, ByRef lpFatDate As SHORT, ByRef lpFatTime As SHORT) As Integer
Declare Function FileTimeToLocalFileTime Alias "FileTimeToLocalFileTime" ( ByRef lpFileTime As FILETIME, ByRef lpLocalFileTime As FILETIME) As Integer
Declare Function FileTimeToSystemTime Alias "FileTimeToSystemTime" ( ByRef lpFileTime As FILETIME, ByRef lpSystemTime As SYSTEMTIME) As Integer
Declare Function FillConsoleOutputAttribute Alias "FillConsoleOutputAttribute" (ByVal hConsoleOutput As Integer, ByVal dwAttribute As Integer, ByVal nLength As Integer, ByVal dwWriteCoord As Integer, ByRef lpNumberOfAttrsWritten As Integer) As Integer
Declare Function FillConsoleOutputCharacter Alias "FillConsoleOutputCharacterA" (ByVal hConsoleOutput As Integer, ByVal szCharacter As String, ByVal nLength As Integer, ByVal dwWriteCoord As Integer, ByRef lpNumberOfCharsWritten As Integer) As Integer
Declare Function FindAtom Alias "FindAtomA" (ByVal lpString As String) As Integer
Declare Function FindClose Alias "FindClose" (ByVal hFindFile As Integer) As Integer
Declare Function FindCloseChangeNotification Alias "FindCloseChangeNotification" (ByVal hChangeHandle As Integer) As Integer
Declare Function FindFirstChangeNotification Alias "FindFirstChangeNotificationA" (ByVal lpPathName As String, ByVal bWatchSubtree As Integer, ByVal dwNotifyFilter As Integer) As Integer
Declare Function FindFirstFile Alias "FindFirstFileA" (ByVal lpFileName As String, ByRef lpFindFileData As WIN32_FIND_DATA) As Integer
Declare Function FindNextChangeNotification Alias "FindNextChangeNotification" (ByVal hChangeHandle As Integer) As Integer
Declare Function FindNextFile Alias "FindNextFileA" (ByVal hFindFile As Integer, ByRef lpFindFileData As WIN32_FIND_DATA) As Integer
Declare Function FindResource Alias "FindResourceA" (ByVal hInstance As Integer, ByVal lpName As String, ByVal lpType As String) As Integer
Declare Function FindResourceEx Alias "FindResourceExA" (ByVal hModule As Integer, ByVal lpType As String, ByVal lpName As String, ByVal wLanguage As Integer) As Integer
Declare Function FlushConsoleInputBuffer Alias "FlushConsoleInputBuffer" (ByVal hConsoleInput As Integer) As Integer
Declare Function FlushFileBuffers Alias "FlushFileBuffers" (ByVal hFile As Integer) As Integer
Declare Function FlushInstructionCache Alias "FlushInstructionCache" (ByVal hProcess As Integer, ByRef lpBaseAddress As ANY, ByVal dwSize As Integer) As Integer
Declare Function FlushViewOfFile Alias "FlushViewOfFile" ( ByRef lpBaseAddress As ANY, ByVal dwNumberOfBytesToFlush As Integer) As Integer
Declare Function FoldString Alias "FoldStringA" (ByVal dwMapFlags As Integer, ByVal lpSrcStr As String, ByVal cchSrc As Integer, ByVal lpDestStr As String, ByVal cchDest As Integer) As Integer
Declare Function FormatMessage Alias "FormatMessageA" (ByVal dwFlags As Integer, ByRef lpSource As ANY, ByVal dwMessageId As Integer, ByVal dwLanguageId As Integer, ByVal lpBuffer As String, ByVal nSize As Integer, ByRef Arguments As Integer) As Integer
Declare Function FreeConsole Alias "FreeConsole" () As Integer
Declare Function FreeEnvironmentStrings Alias "FreeEnvironmentStringsA" (ByVal lpsz As String) As Integer
Declare Function FreeLibrary Alias "FreeLibrary" (ByVal hLibModule As Integer) As Integer
Declare Sub FreeLibraryAndExitThread Alias "FreeLibraryAndExitThread" (ByVal hLibModule As Integer, ByVal dwExitCode As Integer)
Declare Function FreeResource Alias "FreeResource" (ByVal hResData As Integer) As Integer

Declare Function GenerateConsoleCtrlEvent Alias "GenerateConsoleCtrlEvent" (ByVal dwCtrlEvent As Integer, ByVal dwProcessGroupId As Integer) As Integer
Declare Function GetACP Alias "GetACP" () As Integer
Declare Function GetAtomName Alias "GetAtomNameA" (ByVal nAtom As Integer, ByVal lpBuffer As String, ByVal nSize As Integer) As Integer
Declare Function GetBinaryType Alias "GetBinaryTypeA" (ByVal lpApplicationName As String, ByRef lpBinaryType As Integer) As Integer
Declare Function GetCPInfo Alias "GetCPInfo" (ByVal CodePage As Integer, ByRef lpCPInfo As CPINFO) As Integer
Declare Function GetCommConfig Alias "GetCommConfig" (ByVal hCommDev As Integer, ByRef lpCC As COMMCONFIG, ByRef lpdwSize As Integer) As Integer
Declare Function GetCommMask Alias "GetCommMask" (ByVal hFile As Integer, ByRef lpEvtMask As Integer) As Integer
Declare Function GetCommModemStatus Alias "GetCommModemStatus" (ByVal hFile As Integer, ByRef lpModemStat As Integer) As Integer
Declare Function GetCommProperties Alias "GetCommProperties" (ByVal hFile As Integer, ByRef lpCommProp As COMMPROP) As Integer
Declare Function GetCommState Alias "GetCommState" (ByVal nCid As Integer, ByRef lpDCB As DCB) As Integer
Declare Function GetCommTimeouts Alias "GetCommTimeouts" (ByVal hFile As Integer, ByRef lpCommTimeouts As COMMTIMEOUTS) As Integer
Declare Function GetCommandLine Alias "GetCommandLineA" () As Integer
Declare Function GetCompressedFileSize Alias "GetCompressedFileSizeA" (ByVal lpFileName As String, ByRef lpFileSizeHigh As Integer) As Integer
Declare Function GetComputerName Alias "GetComputerNameA" (ByVal lpBuffer As String, ByRef nSize As Integer) As Integer
Declare Function GetConsoleCP Alias "GetConsoleCP" () As Integer
Declare Function GetConsoleCursorInfo Alias "GetConsoleCursorInfo" (ByVal hConsoleOutput As Integer, ByRef lpConsoleCursorInfo As CONSOLE_CURSOR_INFO) As Integer
Declare Function GetConsoleMode Alias "GetConsoleMode" (ByVal hConsoleHandle As Integer, ByRef lpMode As Integer) As Integer
Declare Function GetConsoleOutputCP Alias "GetConsoleOutputCP" () As Integer
Declare Function GetConsoleScreenBufferInfo Alias "GetConsoleScreenBufferInfo" (ByVal hConsoleOutput As Integer, ByRef lpConsoleScreenBufferInfo As CONSOLE_SCREEN_BUFFER_INFO) As Integer
Declare Function GetConsoleTitle Alias "GetConsoleTitleA" (ByVal lpConsoleTitle As String, ByVal nSize As Integer) As Integer
Declare Function GetCurrencyFormat Alias "GetCurrencyFormatA" (ByVal Locale As Integer, ByVal dwFlags As Integer, ByVal lpValue As String, ByRef lpFormat As CURRENCYFMT, ByVal lpCurrencyStr As String, ByVal cchCurrency As Integer) As Integer
Declare Function GetCurrentDirectory Alias "GetCurrentDirectoryA" (ByVal nBufferLength As Integer, ByVal lpBuffer As String) As Integer
Declare Function GetCurrentProcess Alias "GetCurrentProcess" () As Integer
Declare Function GetCurrentProcessId Alias "GetCurrentProcessId" () As Integer
Declare Function GetCurrentThread Alias "GetCurrentThread" () As Integer
Declare Function GetCurrentThreadId Alias "GetCurrentThreadId" () As Integer
Declare Function GetDateFormat Alias "GetDateFormatA" (ByVal Locale As Integer, ByVal dwFlags As Integer, ByRef lpDate As SYSTEMTIME, ByVal lpFormat As String, ByVal lpDateStr As String, ByVal cchDate As Integer) As Integer
Declare Function GetDefaultCommConfig Alias "GetDefaultCommConfigA" (ByVal lpszName As String, ByRef lpCC As COMMCONFIG, ByRef lpdwSize As Integer) As Integer
Declare Function GetDiskFreeSpace Alias "GetDiskFreeSpaceA" (ByVal lpRootPathName As String, ByRef lpSectorsPerCluster As Integer, ByRef lpBytesPerSector As Integer, ByRef lpNumberOfFreeClusters As Integer, ByRef lpTotalNumberOfClusters As Integer) As Integer
Declare Function GetDiskFreeSpaceEx Alias "GetDiskFreeSpaceExA" (ByVal lpPathName As String, ByRef lpFreeBytesAvailableToCaller As INT64, ByRef lpTotalNumberOfBytes As INT64, ByRef lpTotalNumberOfFreeBytes As INT64) As Integer
Declare Function GetDriveType Alias "GetDriveTypeA" (ByVal nDrive As String) As Integer
Declare Function GetEnvironmentStrings Alias "GetEnvironmentStringsA" () As Integer
Declare Function GetEnvironmentVariable Alias "GetEnvironmentVariableA" (ByVal lpName As String, ByVal lpBuffer As String, ByVal nSize As Integer) As Integer
Declare Function GetExitCodeProcess Alias "GetExitCodeProcess" (ByVal hProcess As Integer, ByRef lpExitCode As Integer) As Integer
Declare Function GetExitCodeThread Alias "GetExitCodeThread" (ByVal hThread As Integer, ByRef lpExitCode As Integer) As Integer
Declare Function GetFileAttributes Alias "GetFileAttributesA" (ByVal lpFileName As String) As Integer
Declare Function GetFileInformationByHandle Alias "GetFileInformationByHandle" (ByVal hFile As Integer, ByRef lpFileInformation As BY_HANDLE_FILE_INFORMATION) As Integer
Declare Function GetFileSize Alias "GetFileSize" (ByVal hFile As Integer, ByRef lpFileSizeHigh As Integer) As Integer
Declare Function GetFileTime Alias "GetFileTime" (ByVal hFile As Integer, ByRef lpCreationTime As FILETIME, ByRef lpLastAccessTime As FILETIME, ByRef lpLastWriteTime As FILETIME) As Integer
Declare Function GetFileType Alias "GetFileType" (ByVal hFile As Integer) As Integer
Declare Function GetFullPathName Alias "GetFullPathNameA" (ByVal lpFileName As String, ByVal nBufferLength As Integer, ByVal lpBuffer As String, ByVal lpFilePart As Integer) As Integer
Declare Function GetHandleInformation Alias "GetHandleInformation" (ByVal hObject As Integer, ByRef lpdwFlags As Integer) As Integer
Declare Function GetLargestConsoleWindowSize Alias "GetLargestConsoleWindowSize" (ByVal hConsoleOutput As Integer) As Integer
Declare Function GetLastError Alias "GetLastError" () As Integer
Declare Function GetLocaleInfo Alias "GetLocaleInfoA" (ByVal Locale As Integer, ByVal LCType As Integer, ByVal lpLCData As String, ByVal cchData As Integer) As Integer
Declare Sub GetLocalTime Alias "GetLocalTime" ( ByRef lpSystemTime As SYSTEMTIME)
Declare Function GetLogicalDriveStrings Alias "GetLogicalDriveStringsA" (ByVal nBufferLength As Integer, ByRef lpBuffer As ANY) As Integer
Declare Function GetLogicalDrives Alias "GetLogicalDrives" () As Integer
Declare Function GetMailslotInfo Alias "GetMailslotInfo" (ByVal hMailslot As Integer, ByRef lpMaxMessageSize As Integer, ByRef lpNextSize As Integer, ByRef lpMessageCount As Integer, ByRef lpReadTimeout As Integer) As Integer
Declare Function GetModuleFileName Alias "GetModuleFileNameA" (ByVal hModule As Integer, ByVal lpFileName As String, ByVal nSize As Integer) As Integer
Declare Function GetModuleHandle Alias "GetModuleHandleA" (ByVal lpModuleName As String) As Integer
Declare Function GetNamedPipeHandleState Alias "GetNamedPipeHandleStateA" (ByVal hNamedPipe As Integer, ByRef lpState As Integer, ByRef lpCurInstances As Integer, ByRef lpMaxCollectionCount As Integer, ByRef lpCollectDataTimeout As Integer, ByVal lpUserName As String, ByVal nMaxUserNameSize As Integer) As Integer
Declare Function GetNamedPipeInfo Alias "GetNamedPipeInfo" (ByVal hNamedPipe As Integer, ByRef lpFlags As Integer, ByRef lpOutBufferSize As Integer, ByRef lpInBufferSize As Integer, ByRef lpMaxInstances As Integer) As Integer
Declare Function GetNumberFormat Alias "GetNumberFormatA" (ByVal Locale As Integer, ByVal dwFlags As Integer, ByVal lpValue As String, ByRef lpFormat As NUMBERFMT, ByVal lpNumberStr As String, ByVal cchNumber As Integer) As Integer
Declare Function GetNumberOfConsoleInputEvents Alias "GetNumberOfConsoleInputEvents" (ByVal hConsoleInput As Integer, ByRef lpNumberOfEvents As Integer) As Integer
Declare Function GetNumberOfConsoleMouseButtons Alias "GetNumberOfConsoleMouseButtons" ( ByRef lpNumberOfMouseButtons As Integer) As Integer
Declare Function GetOEMCP Alias "GetOEMCP" () As Integer
Declare Function GetOverlappedResult Alias "GetOverlappedResult" (ByVal hFile As Integer, ByRef lpOverlapped As OVERLAPPED, ByRef lpNumberOfBytesTransferred As Integer, ByVal bWait As Integer) As Integer
Declare Function GetPriorityClass Alias "GetPriorityClass" (ByVal hProcess As Integer) As Integer
Declare Function GetPrivateProfileInt Alias "GetPrivateProfileIntA" (ByVal lpApplicationName As String, ByVal lpKeyName As String, ByVal nDefault As Integer, ByVal lpFileName As String) As Integer
Declare Function GetPrivateProfileSection Alias "GetPrivateProfileSectionA" (ByVal lpAppName As String, ByVal lpReturnedString As String, ByVal nSize As Integer, ByVal lpFileName As String) As Integer
Declare Function GetPrivateProfileSectionNames Alias "GetPrivateProfileSectionNamesA" (ByVal lpszReturnBuffer As String, ByVal nSize As Integer, ByVal lpFileName As String) As Integer
Declare Function GetPrivateProfileString Alias "GetPrivateProfileStringA" (ByVal lpApplicationName As String, ByVal lpKeyName As String, ByVal lpDefault As String, ByVal lpReturnedString As String, ByVal nSize As Integer, ByVal lpFileName As String) As Integer
Declare Function GetProcAddress Alias "GetProcAddress" (ByVal hModule As Integer, ByVal lpProcName As String) As Integer
Declare Function GetProcessAffinityMask Alias "GetProcessAffinityMask" (ByVal hProcess As Integer, ByRef lpProcessAffinityMask As Integer, SystemAffinityMask As Integer) As Integer
Declare Function GetProcessHeap Alias "GetProcessHeap" () As Integer
Declare Function GetProcessHeaps Alias "GetProcessHeaps" (ByVal NumberOfHeaps As Integer, ByRef ProcessHeaps As Integer) As Integer
Declare Function GetProcessShutdownParameters Alias "GetProcessShutdownParameters" ( ByRef lpdwLevel As Integer, ByRef lpdwFlags As Integer) As Integer
Declare Function GetProcessTimes Alias "GetProcessTimes" (ByVal hProcess As Integer, ByRef lpCreationTime As FILETIME, ByRef lpExitTime As FILETIME, ByRef lpKernelTime As FILETIME, ByRef lpUserTime As FILETIME) As Integer
Declare Function GetProcessWorkingSetSize Alias "GetProcessWorkingSetSize" (ByVal hProcess As Integer, ByRef lpMinimumWorkingSetSize As Integer, ByRef lpMaximumWorkingSetSize As Integer) As Integer
Declare Function GetProfileInt Alias "GetProfileIntA" (ByVal lpAppName As String, ByVal lpKeyName As String, ByVal nDefault As Integer) As Integer
Declare Function GetProfileSection Alias "GetProfileSectionA" (ByVal lpAppName As String, ByVal lpReturnedString As String, ByVal nSize As Integer) As Integer
Declare Function GetProfileString Alias "GetProfileStringA" (ByVal lpAppName As String, ByVal lpKeyName As String, ByVal lpDefault As String, ByVal lpReturnedString As String, ByVal nSize As Integer) As Integer
Declare Function GetQueuedCompletionStatus Alias "GetQueuedCompletionStatus" (ByVal CompletionPort As Integer, ByRef lpNumberOfBytesTransferred As Integer, ByRef lpCompletionKey As Integer, ByRef lpOverlapped As Integer, ByVal dwMilliseconds As Integer) As Integer
Declare Function GetShortPathName Alias "GetShortPathNameA" (ByVal lpszLongPath As String, ByVal lpszShortPath As String, ByVal cchBuffer As Integer) As Integer
Declare Sub GetStartupInfo Alias "GetStartupInfoA" ( ByRef lpStartupInfo As STARTUPINFO)
Declare Function GetStdHandle Alias "GetStdHandle" (ByVal nStdHandle As Integer) As Integer
Declare Function GetStringTypeA Alias "GetStringTypeA" (ByVal lcid As Integer, ByVal dwInfoType As Integer, ByVal lpSrcStr As String, ByVal cchSrc As Integer, ByRef lpCharType As Integer) As Integer
Declare Function GetStringTypeEx Alias "GetStringTypeEx" (ByVal Locale As Integer, ByVal dwInfoType As Integer, ByVal lpSrcStr As String, ByVal cchSrc As Integer, ByRef lpCharType As Integer) As Integer
Declare Function GetStringTypeW Alias "GetStringTypeW" (ByVal dwInfoType As Integer, ByVal lpSrcStr As String, ByVal cchSrc As Integer, ByRef lpCharType As Integer) As Integer
Declare Function GetSystemDefaultLCID Alias "GetSystemDefaultLCID" () As Integer
Declare Function GetSystemDefaultLangID Alias "GetSystemDefaultLangID" () As Integer
Declare Function GetSystemDirectory Alias "GetSystemDirectoryA" (ByVal lpBuffer As String, ByVal nSize As Integer) As Integer
Declare Sub GetSystemInfo Alias "GetSystemInfo" ( ByRef lpSystemInfo As SYSTEM_INFO)
Declare Function GetSystemPowerStatus Alias "GetSystemPowerStatus" ( ByRef lpSystemPowerStatus As SYSTEM_POWER_STATUS) As Integer
Declare Sub GetSystemTime Alias "GetSystemTime" ( ByRef lpSystemTime As SYSTEMTIME)
Declare Function GetSystemTimeAdjustment Alias "GetSystemTimeAdjustment" ( ByRef lpTimeAdjustment As Integer, ByRef lpTimeIncrement As Integer, ByRef lpTimeAdjustmentDisabled As Integer) As Integer
Declare Sub GetSystemTimeAsFileTime Alias "GetSystemTimeAsFileTime" ( ByRef lpFileTime As FILETIME)
Declare Function GetTapeParameters Alias "GetTapeParameters" (ByVal hDevice As Integer, ByVal dwOperation As Integer, ByRef lpdwSize As Integer, ByRef lpTapeInformation As ANY) As Integer
Declare Function GetTapePosition Alias "GetTapePosition" (ByVal hDevice As Integer, ByVal dwPositionType As Integer, ByRef lpdwPartition As Integer, ByRef lpdwOffsetLow As Integer, ByRef lpdwOffsetHigh As Integer) As Integer
Declare Function GetTapeStatus Alias "GetTapeStatus" (ByVal hDevice As Integer) As Integer
Declare Function GetTempFileName Alias "GetTempFileNameA" (ByVal lpszPath As String, ByVal lpPrefixString As String, ByVal wUnique As Integer, ByVal lpTempFileName As String) As Integer
Declare Function GetTempPath Alias "GetTempPathA" (ByVal nBufferLength As Integer, ByVal lpBuffer As String) As Integer
Declare Function GetThreadContext Alias "GetThreadContext" (ByVal hThread As Integer, ByRef lpContext As CONTEXT) As Integer
Declare Function GetThreadLocale Alias "GetThreadLocale" () As Integer
Declare Function GetThreadPriority Alias "GetThreadPriority" (ByVal hThread As Integer) As Integer
Declare Function GetThreadSelectorEntry Alias "GetThreadSelectorEntry" (ByVal hThread As Integer, ByVal dwSelector As Integer, ByRef lpSelectorEntry As LDT_ENTRY) As Integer
Declare Function GetThreadTimes Alias "GetThreadTimes" (ByVal hThread As Integer, ByRef lpCreationTime As FILETIME, ByRef lpExitTime As FILETIME, ByRef lpKernelTime As FILETIME, ByRef lpUserTime As FILETIME) As Integer
Declare Function GetTickCount Alias "GetTickCount" () As Integer
Declare Function GetTimeFormat Alias "GetTimeFormatA" (ByVal Locale As Integer, ByVal dwFlags As Integer, ByRef lpTime As SYSTEMTIME, ByVal lpFormat As String, ByVal lpTimeStr As String, ByVal cchTime As Integer) As Integer
Declare Function GetTimeZoneInformation Alias "GetTimeZoneInformation" ( ByRef lpTimeZoneInformation As TIME_ZONE_INFORMATION) As Integer
Declare Function GetUserDefaultLCID Alias "GetUserDefaultLCID" () As Integer
Declare Function GetUserDefaultLangID Alias "GetUserDefaultLangID" () As Integer
Declare Function GetVersion Alias "GetVersion" () As Integer
Declare Function GetVersionEx Alias "GetVersionExA" ( ByRef lpVersionInformation As OSVERSIONINFO) As Integer
Declare Function GetVolumeInformation Alias "GetVolumeInformationA" (ByVal lpRootPathName As String, ByVal lpVolumeNameBuffer As String, ByVal nVolumeNameSize As Integer, ByRef lpVolumeSerialNumber As Integer, ByRef lpMaximumComponentLength As Integer, ByRef lpFileSystemFlags As Integer, ByVal lpFileSystemNameBuffer As String, ByVal nFileSystemNameSize As Integer) As Integer
Declare Function GetWindowsDirectory Alias "GetWindowsDirectoryA" (ByVal lpBuffer As String, ByVal nSize As Integer) As Integer
Declare Function GlobalAddAtom Alias "GlobalAddAtomA" (ByVal lpString As String) As Integer
Declare Function GlobalAlloc Alias "GlobalAlloc" (ByVal wFlags As Integer, ByVal dwBytes As Integer) As Integer
Declare Function GlobalCompact Alias "GlobalCompact" (ByVal dwMinFree As Integer) As Integer
Declare Function GlobalDeleteAtom Alias "GlobalDeleteAtom" (ByVal nAtom As Integer) As Integer
Declare Function GlobalFindAtom Alias "GlobalFindAtomA" (ByVal lpString As String) As Integer
Declare Sub GlobalFix Alias "GlobalFix" (ByVal hMem As Integer)
Declare Function GlobalFlags Alias "GlobalFlags" (ByVal hMem As Integer) As Integer
Declare Function GlobalFree Alias "GlobalFree" (ByVal hMem As Integer) As Integer
Declare Function GlobalGetAtomName Alias "GlobalGetAtomNameA" (ByVal nAtom As Integer, ByVal lpBuffer As String, ByVal nSize As Integer) As Integer
Declare Function GlobalHandle Alias "GlobalHandle" ( ByRef wMem As ANY) As Integer
Declare Function GlobalLock Alias "GlobalLock" (ByVal hMem As Integer) As Integer
Declare Sub GlobalMemoryStatus Alias "GlobalMemoryStatus" ( ByRef lpBuffer As MEMORYSTATUS)
Declare Function GlobalMemoryStatusEx Alias "GlobalMemoryStatusEx" ( ByRef lpBuffer As MEMORYSTATUSEX) As Integer
Declare Function GlobalReAlloc Alias "GlobalReAlloc" (ByVal hMem As Integer, ByVal dwBytes As Integer, ByVal wFlags As Integer) As Integer
Declare Function GlobalSize Alias "GlobalSize" (ByVal hMem As Integer) As Integer
Declare Sub GlobalUnfix Alias "GlobalUnfix" (ByVal hMem As Integer)
Declare Function GlobalUnWire Alias "GlobalUnWire" (ByVal hMem As Integer) As Integer
Declare Function GlobalUnlock Alias "GlobalUnlock" (ByVal hMem As Integer) As Integer
Declare Function GlobalWire Alias "GlobalWire" (ByVal hMem As Integer) As Integer


Declare Function HeapAlloc Alias "HeapAlloc" (ByVal hHeap As Integer, ByVal dwFlags As Integer, ByVal dwBytes As Integer) As Integer
Declare Function HeapCompact Alias "HeapCompact" (ByVal hHeap As Integer, ByVal dwFlags As Integer) As Integer
Declare Function HeapCreate Alias "HeapCreate" (ByVal flOptions As Integer, ByVal dwInitialSize As Integer, ByVal dwMaximumSize As Integer) As Integer
Declare Function HeapDestroy Alias "HeapDestroy" (ByVal hHeap As Integer) As Integer
Declare Function HeapFree Alias "HeapFree" (ByVal hHeap As Integer, ByVal dwFlags As Integer, ByRef lpMem As Any) As Integer
Declare Function HeapLock Alias "HeapLock" (ByVal hHeap As Integer) As Integer
Declare Function HeapReAlloc Alias "HeapReAlloc" (ByVal hHeap As Integer, ByVal dwFlags As Integer, ByRef lpMem As Any, ByVal dwBytes As Integer) As Integer
Declare Function HeapSize Alias "HeapSize" (ByVal hHeap As Integer, ByVal dwFlags As Integer, ByRef lpMem As Any) As Integer
Declare Function HeapUnlock Alias "HeapUnlock" (ByVal hHeap As Integer) As Integer
Declare Function HeapValidate Alias "HeapValidate" (ByVal hHeap As Integer, ByVal dwFlags As Integer, ByRef lpMem As Any) As Integer
Declare Function hread Alias "_hread" (ByVal hFile As Integer, ByRef lpBuffer As Any, ByVal lBytes As Integer) As Integer
Declare Function hwrite Alias "_hwrite" (ByVal hFile As Integer, ByVal lpBuffer As String, ByVal lBytes As Integer) As Integer

Declare Function ImpersonateLoggedOnUser Alias "ImpersonateLoggedOnUser" (ByVal hToken As Integer) As Integer
Declare Function InitAtomTable Alias "InitAtomTable" (ByVal nSize As Integer) As Integer
Declare Sub InitializeCriticalSection Alias "InitializeCriticalSection" ( ByRef lpCriticalSection As CRITICAL_SECTION)
Declare Function InitializeCriticalSectionAndSpinCount Alias "InitializeCriticalSectionAndSpinCount" ( ByRef lpCriticalSection As CRITICAL_SECTION, ByVal dwSpinCount As Integer) As Integer
Declare Function InterlockedDecrement Alias "InterlockedDecrement" ( ByRef lpAddend As Integer) As Integer
Declare Function InterlockedExchange Alias "InterlockedExchange" ( ByRef xTarget As Integer, ByVal xValue As Integer) As Integer
Declare Function InterlockedIncrement Alias "InterlockedIncrement" ( ByRef lpAddend As Integer) As Integer
Declare Function IsBadCodePtr Alias "IsBadCodePtr" (ByVal lpfn As Integer) As Integer
Declare Function IsBadHugeReadPtr Alias "IsBadHugeReadPtr" ( ByRef lp As ANY, ByVal ucb As Integer) As Integer
Declare Function IsBadHugeWritePtr Alias "IsBadHugeWritePtr" ( ByRef lp As ANY, ByVal ucb As Integer) As Integer
Declare Function IsBadReadPtr Alias "IsBadReadPtr" (ByVal lp As Integer, ByVal ucb As Integer) As Integer
Declare Function IsBadStringPtr Alias "IsBadStringPtrA" (ByVal lpsz As String, ByVal ucchMax As Integer) As Integer
Declare Function IsBadWritePtr Alias "IsBadWritePtr" (ByVal lp As Integer, ByVal ucb As Integer) As Integer
Declare Function IsDBCSLeadByte Alias "IsDBCSLeadByte" (ByVal bTestChar As BYTE) As Integer
Declare Function IsValidCodePage Alias "IsValidCodePage" (ByVal CodePage As Integer) As Integer
Declare Function IsValidLocale Alias "IsValidLocale" (ByVal Locale As Integer, ByVal dwFlags As Integer) As Integer

Declare Function lclose Alias "_lclose" (ByVal hFile As Integer) As Integer
Declare Function LCMapString Alias "LCMapStringA" (ByVal Locale As Integer, ByVal dwMapFlags As Integer, ByVal lpSrcStr As String, ByVal cchSrc As Integer, ByVal lpDestStr As String, ByVal cchDest As Integer) As Integer
Declare Function lcreat Alias "_lcreat" (ByVal lpPathName As String, ByVal iAttribute As Integer) As Integer
Declare Function llseek Alias "_llseek" (ByVal hFile As Integer, ByVal lOffset As Integer, ByVal iOrigin As Integer) As Integer
Declare Sub LeaveCriticalSection Alias "LeaveCriticalSection" ( ByRef lpCriticalSection As CRITICAL_SECTION)
Declare Function LoadLibrary Alias "LoadLibraryA" (ByVal lpLibFileName As String) As Integer
Declare Function LoadLibraryEx Alias "LoadLibraryExA" (ByVal lpLibFileName As String, ByVal hFile As Integer, ByVal dwFlags As Integer) As Integer
Declare Function LoadModule Alias "LoadModule" (ByVal lpModuleName As String, ByRef lpParameterBlock As ANY) As Integer
Declare Function LoadResource Alias "LoadResource" (ByVal hInstance As Integer, ByVal hResInfo As Integer) As Integer
Declare Function LocalAlloc Alias "LocalAlloc" (ByVal wFlags As Integer, ByVal wBytes As Integer) As Integer
Declare Function LocalCompact Alias "LocalCompact" (ByVal uMinFree As Integer) As Integer
Declare Function LocalFileTimeToFileTime Alias "LocalFileTimeToFileTime" ( ByRef lpLocalFileTime As FILETIME, ByRef lpFileTime As FILETIME) As Integer
Declare Function LocalFlags Alias "LocalFlags" (ByVal hMem As Integer) As Integer
Declare Function LocalFree Alias "LocalFree" (ByVal hMem As Integer) As Integer
Declare Function LocalHandle Alias "LocalHandle" ( ByRef wMem As ANY) As Integer
Declare Function LocalLock Alias "LocalLock" (ByVal hMem As Integer) As Integer
Declare Function LocalReAlloc Alias "LocalReAlloc" (ByVal hMem As Integer, ByVal wBytes As Integer, ByVal wFlags As Integer) As Integer
Declare Function LocalShrink Alias "LocalShrink" (ByVal hMem As Integer, ByVal cbNewSize As Integer) As Integer
Declare Function LocalSize Alias "LocalSize" (ByVal hMem As Integer) As Integer
Declare Function LocalUnlock Alias "LocalUnlock" (ByVal hMem As Integer) As Integer
Declare Function LockFile Alias "LockFile" (ByVal hFile As Integer, ByVal dwFileOffsetLow As Integer, ByVal dwFileOffsetHigh As Integer, ByVal nNumberOfBytesToLockLow As Integer, ByVal nNumberOfBytesToLockHigh As Integer) As Integer
Declare Function LockFileEx Alias "LockFileEx" (ByVal hFile As Integer, ByVal dwFlags As Integer, ByVal dwReserved As Integer, ByVal nNumberOfBytesToLockLow As Integer, ByVal nNumberOfBytesToLockHigh As Integer, ByRef lpOverlapped As OVERLAPPED) As Integer
Declare Function LockResource Alias "LockResource" (ByVal hResData As Integer) As Integer
Declare Function LogonUser Alias "LogonUserA" (ByVal lpszUsername As String, ByVal lpszDomain As String, ByVal lpszPassword As String, ByVal dwLogonType As Integer, ByVal dwLogonProvider As Integer, ByRef phToken As Integer) As Integer
Declare Function lopen Alias "_lopen" (ByVal lpPathName As String, ByVal iReadWrite As Integer) As Integer
Declare Function lread Alias "_lread" (ByVal hFile As Integer, ByRef lpBuffer As ANY, ByVal wBytes As Integer) As Integer
Declare Function lstrcat Alias "lstrcatA" (ByVal lpString1 As String, ByVal lpString2 As String) As Integer
Declare Function lstrcmp Alias "lstrcmpA" (ByVal lpString1 As String, ByVal lpString2 As String) As Integer
Declare Function lstrcmpi Alias "lstrcmpiA" (ByVal lpString1 As String, ByVal lpString2 As String) As Integer
Declare Function lstrcpy Alias "lstrcpyA" (ByVal lpString1 As String, ByVal lpString2 As String) As Integer
Declare Function lstrcpyn Alias "lstrcpynA" (ByVal lpString1 As String, ByVal lpString2 As String, ByVal iMaxLength As Integer) As Integer
Declare Function lstrlen Alias "lstrlenA" (ByVal lpString As String) As Integer
Declare Function lwrite Alias "_lwrite" (ByVal hFile As Integer, ByVal lpBuffer As String, ByVal wBytes As Integer) As Integer

Declare Function MapViewOfFile Alias "MapViewOfFile" (ByVal hFileMappingObject As Integer, ByVal dwDesiredAccess As Integer, ByVal dwFileOffsetHigh As Integer, ByVal dwFileOffsetLow As Integer, ByVal dwNumberOfBytesToMap As Integer) As Integer
Declare Function MapViewOfFileEx Alias "MapViewOfFileEx" (ByVal hFileMappingObject As Integer, ByVal dwDesiredAccess As Integer, ByVal dwFileOffsetHigh As Integer, ByVal dwFileOffsetLow As Integer, ByVal dwNumberOfBytesToMap As Integer, ByRef lpBaseAddress As ANY) As Integer
Declare Function MoveFile Alias "MoveFileA" (ByVal lpExistingFileName As String, ByVal lpNewFileName As String) As Integer
Declare Function MoveFileEx Alias "MoveFileExA" (ByVal lpExistingFileName As String, ByVal lpNewFileName As String, ByVal dwFlags As Integer) As Integer
Declare Sub MoveMemory Alias "RtlMoveMemory" ( ByRef pDestination As ANY, ByRef pSource As ANY, ByVal cbLength As Integer)
Declare Function MulDiv Alias "MulDiv" (ByVal nNumber As Integer, ByVal nNumerator As Integer, ByVal nDenominator As Integer) As Integer
Declare Function MultiByteToWideChar Alias "MultiByteToWideChar" (ByVal CodePage As Integer, ByVal dwFlags As Integer, ByVal lpMultiByteStr As String, ByVal cchMultiByte As Integer, ByVal lpWideCharStr As String, ByVal cchWideChar As Integer) As Integer

'Declare Function ObjectOpenAuditAlarm Alias "ObjectOpenAuditAlarmA" (ByVal SubsystemName As String, ByRef HandleId As Any, ByVal ObjectTypeName As String, ByVal ObjectName As String, ByRef pSecurityDescriptor As SECURITY_DESCRIPTOR, ByVal ClientToken As Integer, ByVal DesiredAccess As Integer, ByVal GrantedAccess As Integer, ByRef Privileges As PRIVILEGE_SET, ByVal ObjectCreation As Integer, ByVal AccessGranted As Integer, ByVal GenerateOnClose As Integer) As Integer
Declare Function OpenEvent Alias "OpenEventA" (ByVal dwDesiredAccess As Integer, ByVal bInheritHandle As Integer, ByVal lpName As String) As Integer
Declare Function OpenFile Alias "OpenFile" (ByVal lpFileName As String, ByRef lpReOpenBuff As OFSTRUCT, ByVal wStyle As Integer) As Integer
Declare Function OpenFileMapping Alias "OpenFileMappingA" (ByVal dwDesiredAccess As Integer, ByVal bInheritHandle As Integer, ByVal lpName As String) As Integer
Declare Function OpenMutex Alias "OpenMutexA" (ByVal dwDesiredAccess As Integer, ByVal bInheritHandle As Integer, ByVal lpName As String) As Integer
Declare Function OpenProcess Alias "OpenProcess" (ByVal dwDesiredAccess As Integer, ByVal bInheritHandle As Integer, ByVal dwProcessId As Integer) As Integer
Declare Function OpenSemaphore Alias "OpenSemaphoreA" (ByVal dwDesiredAccess As Integer, ByVal bInheritHandle As Integer, ByVal lpName As String) As Integer
Declare Sub OutputDebugString Alias "OutputDebugStringA" (ByVal lpOutputString As String)

Declare Function PeekNamedPipe Alias "PeekNamedPipe" (ByVal hNamedPipe As Integer, ByRef lpBuffer As ANY, ByVal nBufferSize As Integer, ByRef lpBytesRead As Integer, ByRef lpTotalBytesAvail As Integer, ByRef lpBytesLeftThisMessage As Integer) As Integer
Declare Function PrepareTape Alias "PrepareTape" (ByVal hDevice As Integer, ByVal dwOperation As Integer, ByVal bimmediate As Integer) As Integer
Declare Function PulseEvent Alias "PulseEvent" (ByVal hEvent As Integer) As Integer
Declare Function PurgeComm Alias "PurgeComm" (ByVal hFile As Integer, ByVal dwFlags As Integer) As Integer

Declare Function PeekConsoleInput alias "PeekConsoleInputA" ( byval hConsoleInput as integer, byref pirBuffer as INPUT_RECORD, byval cInRecords as integer, byref lpcRead as integer ) as integer

Declare Function QueryDosDevice Alias "QueryDosDeviceA" (ByVal lpDeviceName As String, ByVal lpTargetPath As String, ByVal ucchMax As Integer) As Integer
Declare Function QueryPerformanceCounter Alias "QueryPerformanceCounter" ( ByRef lpPerformanceCount As INT64) As Integer
Declare Function QueryPerformanceFrequency Alias "QueryPerformanceFrequency" ( ByRef lpFrequency As INT64) As Integer

Declare Sub RaiseException Alias "RaiseException" (ByVal dwExceptionCode As Integer, ByVal dwExceptionFlags As Integer, ByVal nNumberOfArguments As Integer, ByRef lpArguments As Integer)
Declare Function ReadConsole Alias "ReadConsoleA" (ByVal hConsoleInput As Integer, ByRef lpBuffer As ANY, ByVal nNumberOfCharsToRead As Integer, ByRef lpNumberOfCharsRead As Integer, ByRef lpReserved As ANY) As Integer
Declare Function ReadConsoleInput Alias "ReadConsoleInputA" (ByVal hConsoleInput As Integer, byref lpBuffer As INPUT_RECORD, ByVal nNumberOfCharsToRead As Integer, ByRef lpNumberOfCharsRead As Integer) As Integer
Declare Function ReadConsoleOutput Alias "ReadConsoleOutputA" (ByVal hConsoleOutput As Integer, ByVal lpBuffer As Integer, ByVal dwBufferSize As Integer, ByVal dwBufferCoord As Integer, ByRef lpReadRegion As SMALL_RECT) As Integer
Declare Function ReadConsoleOutputAttribute Alias "ReadConsoleOutputAttribute" (ByVal hConsoleOutput As Integer, ByRef lpdwAttribute As Integer, ByVal nLength As Integer, ByVal dwReadCoord As Integer, ByRef lpNumberOfAttrsRead As Integer) As Integer
Declare Function ReadConsoleOutputCharacter Alias "ReadConsoleOutputCharacterA" (ByVal hConsoleOutput As Integer, ByVal szCharacter As String, ByVal nLength As Integer, ByVal dwReadCoord As Integer, ByRef lpNumberOfCharsRead As Integer) As Integer
Declare Function ReadFile Alias "ReadFile" (ByVal hFile As Integer, ByRef lpBuffer As ANY, ByVal nNumberOfBytesToRead As Integer, ByRef lpNumberOfBytesRead As Integer, ByRef lpOverlapped As OVERLAPPED) As Integer
Declare Function ReadFileEx Alias "ReadFileEx" (ByVal hFile As Integer, ByRef lpBuffer As ANY, ByVal nNumberOfBytesToRead As Integer, ByRef lpOverlapped As OVERLAPPED, ByVal lpCompletionRoutine As Integer) As Integer
Declare Function ReadProcessMemory Alias "ReadProcessMemory" (ByVal hProcess As Integer, ByVal lpBaseAddress As Integer, ByRef lpBuffer As ANY, ByVal nSize As Integer, ByRef lpNumberOfBytesWritten As Integer) As Integer
Declare Function ReleaseMutex Alias "ReleaseMutex" (ByVal hMutex As Integer) As Integer
Declare Function ReleaseSemaphore Alias "ReleaseSemaphore" (ByVal hSemaphore As Integer, ByVal lReleaseCount As Integer, ByRef lpPreviousCount As Integer) As Integer
Declare Function RemoveDirectory Alias "RemoveDirectoryA" (ByVal lpPathName As String) As Integer
Declare Function ResetEvent Alias "ResetEvent" (ByVal hEvent As Integer) As Integer
Declare Function ResumeThread Alias "ResumeThread" (ByVal hThread As Integer) As Integer

Declare Function ScrollConsoleScreenBuffer Alias "ScrollConsoleScreenBufferA" (ByVal hConsoleOutput As Integer, ByRef lpScrollRectangle As SMALL_RECT, ByRef lpClipRectangle As SMALL_RECT, ByVal dwDestinationOrigin As Integer, ByRef lpFill As CHAR_INFO) As Integer
Declare Function SearchPath Alias "SearchPathA" (ByVal lpPath As String, ByVal lpFileName As String, ByVal lpExtension As String, ByVal nBufferLength As Integer, ByVal lpBuffer As String, ByVal lpFilePart As String) As Integer
Declare Function SetCommBreak Alias "SetCommBreak" (ByVal nCid As Integer) As Integer
Declare Function SetCommConfig Alias "SetCommConfig" (ByVal hCommDev As Integer, ByRef lpCC As COMMCONFIG, ByVal dwSize As Integer) As Integer
Declare Function SetCommMask Alias "SetCommMask" (ByVal hFile As Integer, ByVal dwEvtMask As Integer) As Integer
Declare Function SetCommState Alias "SetCommState" (ByVal hCommDev As Integer, ByRef lpDCB As DCB) As Integer
Declare Function SetCommTimeouts Alias "SetCommTimeouts" (ByVal hFile As Integer, ByRef lpCommTimeouts As COMMTIMEOUTS) As Integer
Declare Function SetComputerName Alias "SetComputerNameA" (ByVal lpComputerName As String) As Integer
Declare Function SetConsoleActiveScreenBuffer Alias "SetConsoleActiveScreenBuffer" (ByVal hConsoleOutput As Integer) As Integer
Declare Function SetConsoleCP Alias "SetConsoleCP" (ByVal wCodePageID As Integer) As Integer
Declare Function SetConsoleCtrlHandler Alias "SetConsoleCtrlHandler" (ByVal HandlerRoutine As Integer, ByVal nAdd As Integer) As Integer
Declare Function SetConsoleCursorInfo Alias "SetConsoleCursorInfo" (ByVal hConsoleOutput As Integer, ByRef lpConsoleCursorInfo As CONSOLE_CURSOR_INFO) As Integer
Declare Function SetConsoleCursorPosition Alias "SetConsoleCursorPosition" (ByVal hConsoleOutput As Integer, ByVal dwCursorPosition As Integer) As Integer
Declare Function SetConsoleMode Alias "SetConsoleMode" (ByVal hConsoleHandle As Integer, ByVal dwMode As Integer) As Integer
Declare Function SetConsoleOutputCP Alias "SetConsoleOutputCP" (ByVal wCodePageID As Integer) As Integer
Declare Function SetConsoleScreenBufferSize Alias "SetConsoleScreenBufferSize" (ByVal hConsoleOutput As Integer, ByVal dwSize As Integer) As Integer
Declare Function SetConsoleTextAttribute Alias "SetConsoleTextAttribute" (ByVal hConsoleOutput As Integer, ByVal dwAttributes As Integer) As Integer
Declare Function SetConsoleTitle Alias "SetConsoleTitleA" (ByVal lpConsoleTitle As String) As Integer
Declare Function SetConsoleWindowInfo Alias "SetConsoleWindowInfo" (ByVal hConsoleOutput As Integer, ByVal bAbsolute As Integer, ByRef lpConsoleWindow As SMALL_RECT) As Integer
Declare Function SetCriticalSectionSpinCount Alias "SetCriticalSectionSpinCount" ( ByRef lpCriticalSection As CRITICAL_SECTION, ByVal dwSpinCount As Integer) As Integer
Declare Function SetCurrentDirectory Alias "SetCurrentDirectoryA" (ByVal lpPathName As String) As Integer
Declare Function SetDefaultCommConfig Alias "SetDefaultCommConfigA" (ByVal lpszName As String, ByRef lpCC As COMMCONFIG, ByVal dwSize As Integer) As Integer
Declare Function SetEndOfFile Alias "SetEndOfFile" (ByVal hFile As Integer) As Integer
Declare Function SetEnvironmentVariable Alias "SetEnvironmentVariableA" (ByVal lpName As String, ByVal lpValue As String) As Integer
Declare Function SetErrorMode Alias "SetErrorMode" (ByVal wMode As Integer) As Integer
Declare Function SetEvent Alias "SetEvent" (ByVal hEvent As Integer) As Integer
Declare Sub SetFileApisToANSI Alias "SetFileApisToANSI" ()
Declare Sub SetFileApisToOEM Alias "SetFileApisToOEM" ()
Declare Function SetFileAttributes Alias "SetFileAttributesA" (ByVal lpFileName As String, ByVal dwFileAttributes As Integer) As Integer
Declare Function SetFilePointer Alias "SetFilePointer" (ByVal hFile As Integer, ByVal lDistanceToMove As Integer, ByRef lpDistanceToMoveHigh As Integer, ByVal dwMoveMethod As Integer) As Integer
Declare Function SetFileTime Alias "SetFileTime" (ByVal hFile As Integer, ByRef lpCreationTime As FILETIME, ByRef lpLastAccessTime As FILETIME, ByRef lpLastWriteTime As FILETIME) As Integer
Declare Function SetHandleCount Alias "SetHandleCount" (ByVal wNumber As Integer) As Integer
Declare Function SetHandleInformation Alias "SetHandleInformation" (ByVal hObject As Integer, ByVal dwMask As Integer, ByVal dwFlags As Integer) As Integer
Declare Sub SetLastError Alias "SetLastError" (ByVal dwErrCode As Integer)
Declare Function SetLocalTime Alias "SetLocalTime" ( ByRef lpSystemTime As SYSTEMTIME) As Integer
Declare Function SetLocaleInfo Alias "SetLocaleInfoA" (ByVal Locale As Integer, ByVal LCType As Integer, ByVal lpLCData As String) As Integer
Declare Function SetMailslotInfo Alias "SetMailslotInfo" (ByVal hMailslot As Integer, ByVal lReadTimeout As Integer) As Integer
Declare Function SetNamedPipeHandleState Alias "SetNamedPipeHandleState" (ByVal hNamedPipe As Integer, ByRef lpMode As Integer, ByRef lpMaxCollectionCount As Integer, ByRef lpCollectDataTimeout As Integer) As Integer
Declare Function SetPriorityClass Alias "SetPriorityClass" (ByVal hProcess As Integer, ByVal dwPriorityClass As Integer) As Integer
Declare Function SetProcessShutdownParameters Alias "SetProcessShutdownParameters" (ByVal dwLevel As Integer, ByVal dwFlags As Integer) As Integer
Declare Function SetProcessWorkingSetSize Alias "SetProcessWorkingSetSize" (ByVal hProcess As Integer, ByVal dwMinimumWorkingSetSize As Integer, ByVal dwMaximumWorkingSetSize As Integer) As Integer
Declare Function SetStdHandle Alias "SetStdHandle" (ByVal nStdHandle As Integer, ByVal nHandle As Integer) As Integer
Declare Function SetSystemPowerState Alias "SetSystemPowerState" (ByVal fSuspend As Integer, ByVal fForce As Integer) As Integer
Declare Function SetSystemTime Alias "SetSystemTime" ( ByRef lpSystemTime As SYSTEMTIME) As Integer
Declare Function SetSystemTimeAdjustment Alias "SetSystemTimeAdjustment" (ByVal dwTimeAdjustment As Integer, ByVal bTimeAdjustmentDisabled As Integer) As Integer
Declare Function SetTapeParameters Alias "SetTapeParameters" (ByVal hDevice As Integer, ByVal dwOperation As Integer, ByRef lpTapeInformation As ANY) As Integer
Declare Function SetTapePosition Alias "SetTapePosition" (ByVal hDevice As Integer, ByVal dwPositionMethod As Integer, ByVal dwPartition As Integer, ByVal dwOffsetLow As Integer, ByVal dwOffsetHigh As Integer, ByVal bimmediate As Integer) As Integer
Declare Function SetThreadAffinityMask Alias "SetThreadAffinityMask" (ByVal hThread As Integer, ByVal dwThreadAffinityMask As Integer) As Integer
Declare Function SetThreadContext Alias "SetThreadContext" (ByVal hThread As Integer, ByRef lpContext As CONTEXT) As Integer
Declare Function SetThreadLocale Alias "SetThreadLocale" (ByVal Locale As Integer) As Integer
Declare Function SetThreadPriority Alias "SetThreadPriority" (ByVal hThread As Integer, ByVal nPriority As Integer) As Integer
Declare Function SetTimeZoneInformation Alias "SetTimeZoneInformation" ( ByRef lpTimeZoneInformation As TIME_ZONE_INFORMATION) As Integer
Declare Function SetUnhandledExceptionFilter Alias "SetUnhandledExceptionFilter" (ByVal lpTopLevelExceptionFilter As Integer) As Integer
Declare Function SetVolumeLabel Alias "SetVolumeLabelA" (ByVal lpRootPathName As String, ByRef lpVolumeName As String) As Integer
Declare Function SetupComm Alias "SetupComm" (ByVal hFile As Integer, ByVal dwInQueue As Integer, ByVal dwOutQueue As Integer) As Integer
Declare Function SizeofResource Alias "SizeofResource" (ByVal hInstance As Integer, ByVal hResInfo As Integer) As Integer
'Declare Sub Sleep Alias "Sleep" (ByVal dwMilliseconds As Integer)
Declare Function SleepEx Alias "SleepEx" (ByVal dwMilliseconds As Integer, ByVal bAlertable As Integer) As Integer
Declare Function SuspendThread Alias "SuspendThread" (ByVal hThread As Integer) As Integer
Declare Function SystemTimeToFileTime Alias "SystemTimeToFileTime" ( ByRef lpSystemTime As SYSTEMTIME, ByRef lpFileTime As FILETIME) As Integer
Declare Function SystemTimeToTzSpecificLocalTime Alias "SystemTimeToTzSpecificLocalTime" ( ByRef lpTimeZoneInformation As TIME_ZONE_INFORMATION, ByRef lpUniversalTime As SYSTEMTIME, ByRef lpLocalTime As SYSTEMTIME) As Integer

Declare Function TerminateProcess Alias "TerminateProcess" (ByVal hProcess As Integer, ByVal uExitCode As Integer) As Integer
Declare Function TerminateThread Alias "TerminateThread" (ByVal hThread As Integer, ByVal dwExitCode As Integer) As Integer
Declare Function TlsAlloc Alias "TlsAlloc" () As Integer
Declare Function TlsFree Alias "TlsFree" (ByVal dwTlsIndex As Integer) As Integer
Declare Function TlsGetValue Alias "TlsGetValue" (ByVal dwTlsIndex As Integer) As Integer
Declare Function TlsSetValue Alias "TlsSetValue" (ByVal dwTlsIndex As Integer, ByRef lpTlsValue As ANY) As Integer
Declare Function TransactNamedPipe Alias "TransactNamedPipe" (ByVal hNamedPipe As Integer, ByRef lpInBuffer As ANY, ByVal nInBufferSize As Integer, ByRef lpOutBuffer As ANY, ByVal nOutBufferSize As Integer, ByRef lpBytesRead As Integer, ByRef lpOverlapped As OVERLAPPED) As Integer
Declare Function TransmitCommChar Alias "TransmitCommChar" (ByVal nCid As Integer, ByVal cChar As BYTE) As Integer

Declare Function UnhandledExceptionFilter Alias "UnhandledExceptionFilter" ( ByRef ExceptionInfo As EXCEPTION_POINTERS) As Integer
Declare Function UnlockFile Alias "UnlockFile" (ByVal hFile As Integer, ByVal dwFileOffsetLow As Integer, ByVal dwFileOffsetHigh As Integer, ByVal nNumberOfBytesToUnlockLow As Integer, ByVal nNumberOfBytesToUnlockHigh As Integer) As Integer
Declare Function UnlockFileEx Alias "UnlockFileEx" (ByVal hFile As Integer, ByVal dwReserved As Integer, ByVal nNumberOfBytesToUnlockLow As Integer, ByVal nNumberOfBytesToUnlockHigh As Integer, ByRef lpOverlapped As OVERLAPPED) As Integer
Declare Function UnmapViewOfFile Alias "UnmapViewOfFile" ( ByRef lpBaseAddress As ANY) As Integer
Declare Function UpdateResource Alias "UpdateResourceA" (ByVal hUpdate As Integer, ByVal lpType As String, ByVal lpName As String, ByVal wLanguage As Integer, ByRef lpData As ANY, ByVal cbData As Integer) As Integer

Declare Function VerLanguageName Alias "VerLanguageNameA" (ByVal wLang As Integer, ByVal szLang As String, ByVal nSize As Integer) As Integer
Declare Function VirtualAlloc Alias "VirtualAlloc" ( ByRef lpAddress As ANY, ByVal dwSize As Integer, ByVal flAllocationType As Integer, ByVal flProtect As Integer) As Integer
Declare Function VirtualAllocEx Alias "VirtualAllocEx" (ByVal hProcess As Integer, ByRef lpAddress As ANY, ByVal dwSize As Integer, ByVal flAllocationType As Integer, ByVal flProtect As Integer) As Integer
Declare Function VirtualFree Alias "VirtualFree" ( ByRef lpAddress As ANY, ByVal dwSize As Integer, ByVal dwFreeType As Integer) As Integer
Declare Function VirtualFreeEx Alias "VirtualFreeEx" (ByVal hProcess As Integer, ByRef lpAddress As ANY, ByVal dwSize As Integer, ByVal dwFreeType As Integer) As Integer
Declare Function VirtualLock Alias "VirtualLock" ( ByRef lpAddress As ANY, ByVal dwSize As Integer) As Integer
Declare Function VirtualProtect Alias "VirtualProtect" ( ByRef lpAddress As ANY, ByVal dwSize As Integer, ByVal flNewProtect As Integer, ByRef lpflOldProtect As Integer) As Integer
Declare Function VirtualProtectEx Alias "VirtualProtectEx" (ByVal hProcess As Integer, ByRef lpAddress As ANY, ByVal dwSize As Integer, ByVal flNewProtect As Integer, ByRef lpflOldProtect As Integer) As Integer
Declare Function VirtualQuery Alias "VirtualQuery" (ByRef lpAddress As Any, ByRef lpBuffer As MEMORY_BASIC_INFORMATION, ByVal dwLength As Integer) As Integer
Declare Function VirtualQueryEx Alias "VirtualQueryEx" (ByVal hProcess As Integer, ByRef lpAddress As Any, ByRef lpBuffer As MEMORY_BASIC_INFORMATION, ByVal dwLength As Integer) As Integer
Declare Function VirtualUnlock Alias "VirtualUnlock" (ByRef lpAddress As Any, ByVal dwSize As Integer) As Integer

Declare Function WaitCommEvent Alias "WaitCommEvent" (ByVal hFile As Integer, ByRef lpEvtMask As Integer, ByRef lpOverlapped As OVERLAPPED) As Integer
Declare Function WaitForDebugEvent Alias "WaitForDebugEvent" ( ByRef lpde As DEBUG_EVENT, ByVal dwTimeOut As Integer) As Integer
Declare Function WaitForMultipleObjects Alias "WaitForMultipleObjects" (ByVal nCount As Integer, ByRef lpHandles As Integer, ByVal bWaitAll As Integer, ByVal dwMilliseconds As Integer) As Integer
Declare Function WaitForMultipleObjectsEx Alias "WaitForMultipleObjectsEx" (ByVal nCount As Integer, ByRef lpHandles As Integer, ByVal bWaitAll As Integer, ByVal dwMilliseconds As Integer, ByVal bAlertable As Integer) As Integer
Declare Function WaitForSingleObject Alias "WaitForSingleObject" (ByVal hHandle As Integer, ByVal dwMilliseconds As Integer) As Integer
Declare Function WaitForSingleObjectEx Alias "WaitForSingleObjectEx" (ByVal hHandle As Integer, ByVal dwMilliseconds As Integer, ByVal bAlertable As Integer) As Integer
Declare Function WaitNamedPipe Alias "WaitNamedPipeA" (ByVal lpNamedPipeName As String, ByVal nTimeOut As Integer) As Integer
Declare Function WideCharToMultiByte Alias "WideCharToMultiByte" (ByVal CodePage As Integer, ByVal dwFlags As Integer, ByVal lpWideCharStr As String, ByVal cchWideChar As Integer, ByVal lpMultiByteStr As String, ByVal cchMultiByte As Integer, ByVal lpDefaultChar As String, ByVal lpUsedDefaultChar As Integer) As Integer
Declare Function WinExec Alias "WinExec" (ByVal lpCmdLine As String, ByVal nCmdShow As Integer) As Integer
Declare Function WriteConsole Alias "WriteConsoleA" (ByVal hConsoleOutput As Integer, ByVal lpBuffer As String, ByVal nNumberOfCharsToWrite As Integer, ByRef lpNumberOfCharsWritten As Integer, ByVal lpReserved As Integer) As Integer
Declare Function WriteConsoleInput Alias "WriteConsoleInputA" (ByVal hConsoleInput As Integer, ByRef lpBuffer As INPUT_RECORD, ByVal nLength As Integer, ByRef lpNumberOfEventsWritten As Integer) As Integer
Declare Function WriteConsoleOutput Alias "WriteConsoleOutputA" (ByVal hConsoleOutput As Integer, ByVal lpBuffer As Integer, ByVal dwBufferSize As Integer, ByVal dwBufferCoord As Integer, ByRef lpWriteRegion As SMALL_RECT) As Integer
Declare Function WriteConsoleOutputAttribute Alias "WriteConsoleOutputAttribute"(ByVal hConsoleOutput As Integer, ByRef lpdwAttribute As Integer, ByVal nLength As Integer, ByVal dwWriteCoord As Integer, ByRef lpNumberOfAttrsWritten As Integer) As Integer
Declare Function WriteConsoleOutputCharacter Alias "WriteConsoleOutputCharacterA" (ByVal hConsoleOutput As Integer, ByVal szCharacter As String, ByVal nLength As Integer, ByVal dwWriteCoord As Integer, ByRef lpNumberOfCharsWritten As Integer) As Integer
Declare Function WriteFile Alias "WriteFile" (ByVal hFile As Integer, ByRef lpBuffer As ANY, ByVal nNumberOfBytesToWrite As Integer, ByRef lpNumberOfBytesWritten As Integer, ByRef lpOverlapped As OVERLAPPED) As Integer
Declare Function WriteFileEx Alias "WriteFileEx" (ByVal hFile As Integer, ByRef lpBuffer As ANY, ByVal nNumberOfBytesToWrite As Integer, ByRef lpOverlapped As OVERLAPPED, ByVal lpCompletionRoutine As Integer) As Integer
Declare Function WritePrivateProfileSection Alias "WritePrivateProfileSectionA" (ByVal lpAppName As String, ByVal lpString As String, ByVal lpFileName As String) As Integer
Declare Function WritePrivateProfileString Alias "WritePrivateProfileStringA" (ByVal lpApplicationName As String, ByVal lpKeyName As String, ByVal lpString As String, ByVal lpFileName As String) As Integer
Declare Function WriteProcessMemory Alias "WriteProcessMemory"(ByVal hProcess As Integer, ByRef lpBaseAddress As ANY, ByRef lpBuffer As ANY, ByVal nSize As Integer, ByRef lpNumberOfBytesWritten As Integer) As Integer
Declare Function WriteProfileSection Alias "WriteProfileSectionA" (ByVal lpAppName As String, ByVal lpString As String) As Integer
Declare Function WriteProfileString Alias "WriteProfileStringA" (ByVal lpszSection As String, ByVal lpszKeyName As String, ByVal lpszString As String) As Integer
Declare Function WriteTapemark Alias "WriteTapemark" (ByVal hDevice As Integer, ByVal dwTapemarkType As Integer, ByVal dwTapemarkCount As Integer, ByVal bimmediate As Integer) As Integer

#endif ' KERNEL32_BI