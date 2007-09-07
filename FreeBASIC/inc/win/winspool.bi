''
''
'' winspool -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_winspool_bi__
#define __win_winspool_bi__

#inclib "winspool"

#define DI_CHANNEL 1
#define DI_CHANNEL_WRITE 2
#define DI_READ_SPOOL_JOB 3
#define FORM_BUILTIN 1
#define JOB_CONTROL_PAUSE 1
#define JOB_CONTROL_RESUME 2
#define JOB_CONTROL_CANCEL 3
#define JOB_CONTROL_RESTART 4
#define JOB_CONTROL_DELETE 5
#define JOB_STATUS_PAUSED 1
#define JOB_STATUS_ERROR 2
#define JOB_STATUS_DELETING 4
#define JOB_STATUS_SPOOLING 8
#define JOB_STATUS_PRINTING 16
#define JOB_STATUS_OFFLINE 32
#define JOB_STATUS_PAPEROUT &h40
#define JOB_STATUS_PRINTED &h80
#define JOB_STATUS_DELETED &h100
#define JOB_STATUS_BLOCKED_DEVQ &h200
#define JOB_STATUS_USER_INTERVENTION &h400
#define JOB_POSITION_UNSPECIFIED 0
#define JOB_NOTIFY_TYPE 1
#define JOB_NOTIFY_FIELD_PRINTER_NAME 0
#define JOB_NOTIFY_FIELD_MACHINE_NAME 1
#define JOB_NOTIFY_FIELD_PORT_NAME 2
#define JOB_NOTIFY_FIELD_USER_NAME 3
#define JOB_NOTIFY_FIELD_NOTIFY_NAME 4
#define JOB_NOTIFY_FIELD_DATATYPE 5
#define JOB_NOTIFY_FIELD_PRINT_PROCESSOR 6
#define JOB_NOTIFY_FIELD_PARAMETERS 7
#define JOB_NOTIFY_FIELD_DRIVER_NAME 8
#define JOB_NOTIFY_FIELD_DEVMODE 9
#define JOB_NOTIFY_FIELD_STATUS 10
#define JOB_NOTIFY_FIELD_STATUS_STRING 11
#define JOB_NOTIFY_FIELD_SECURITY_DESCRIPTOR 12
#define JOB_NOTIFY_FIELD_DOCUMENT 13
#define JOB_NOTIFY_FIELD_PRIORITY 14
#define JOB_NOTIFY_FIELD_POSITION 15
#define JOB_NOTIFY_FIELD_SUBMITTED 16
#define JOB_NOTIFY_FIELD_START_TIME 17
#define JOB_NOTIFY_FIELD_UNTIL_TIME 18
#define JOB_NOTIFY_FIELD_TIME 19
#define JOB_NOTIFY_FIELD_TOTAL_PAGES 20
#define JOB_NOTIFY_FIELD_PAGES_PRINTED 21
#define JOB_NOTIFY_FIELD_TOTAL_BYTES 22
#define JOB_NOTIFY_FIELD_BYTES_PRINTED 23
#define JOB_ACCESS_ADMINISTER 16
#define JOB_ALL_ACCESS (&hF0000 or 16)
#define JOB_READ (&h20000 or 16)
#define JOB_WRITE (&h20000 or 16)
#define JOB_EXECUTE (&h20000 or 16)
#define PRINTER_NOTIFY_OPTIONS_REFRESH 1
#define PRINTER_ACCESS_ADMINISTER 4
#define PRINTER_ACCESS_USE 8
#define PRINTER_ERROR_INFORMATION &h80000000
#define PRINTER_ERROR_WARNING &h40000000
#define PRINTER_ERROR_SEVERE &h20000000
#define PRINTER_ERROR_OUTOFPAPER 1
#define PRINTER_ERROR_JAM 2
#define PRINTER_ERROR_OUTOFTONER 4
#define PRINTER_CONTROL_PAUSE 1
#define PRINTER_CONTROL_RESUME 2
#define PRINTER_CONTROL_PURGE 3
#define PRINTER_CONTROL_SET_STATUS 4
#define PRINTER_STATUS_PAUSED 1
#define PRINTER_STATUS_ERROR 2
#define PRINTER_STATUS_PENDING_DELETION 4
#define PRINTER_STATUS_PAPER_JAM 8
#define PRINTER_STATUS_PAPER_OUT &h10
#define PRINTER_STATUS_MANUAL_FEED &h20
#define PRINTER_STATUS_PAPER_PROBLEM &h40
#define PRINTER_STATUS_OFFLINE &h80
#define PRINTER_STATUS_IO_ACTIVE &h100
#define PRINTER_STATUS_BUSY &h200
#define PRINTER_STATUS_PRINTING &h400
#define PRINTER_STATUS_OUTPUT_BIN_FULL &h800
#define PRINTER_STATUS_NOT_AVAILABLE &h1000
#define PRINTER_STATUS_WAITING &h2000
#define PRINTER_STATUS_PROCESSING &h4000
#define PRINTER_STATUS_INITIALIZING &h8000
#define PRINTER_STATUS_WARMING_UP &h10000
#define PRINTER_STATUS_TONER_LOW &h20000
#define PRINTER_STATUS_NO_TONER &h40000
#define PRINTER_STATUS_PAGE_PUNT &h80000
#define PRINTER_STATUS_USER_INTERVENTION &h100000
#define PRINTER_STATUS_OUT_OF_MEMORY &h200000
#define PRINTER_STATUS_DOOR_OPEN &h400000
#define PRINTER_STATUS_SERVER_UNKNOWN &h800000
#define PRINTER_STATUS_POWER_SAVE &h1000000
#define PRINTER_ATTRIBUTE_QUEUED 1
#define PRINTER_ATTRIBUTE_DIRECT 2
#define PRINTER_ATTRIBUTE_DEFAULT 4
#define PRINTER_ATTRIBUTE_SHARED 8
#define PRINTER_ATTRIBUTE_NETWORK &h10
#define PRINTER_ATTRIBUTE_HIDDEN &h20
#define PRINTER_ATTRIBUTE_LOCAL &h40
#define PRINTER_ATTRIBUTE_ENABLE_DEVQ &h80
#define PRINTER_ATTRIBUTE_KEEPPRINTEDJOBS &h100
#define PRINTER_ATTRIBUTE_DO_COMPLETE_FIRST &h200
#define PRINTER_ATTRIBUTE_WORK_OFFLINE &h400
#define PRINTER_ATTRIBUTE_ENABLE_BIDI &h800
#define PRINTER_ATTRIBUTE_RAW_ONLY &h1000
#define PRINTER_ATTRIBUTE_PUBLISHED &h2000
#define PRINTER_ENUM_DEFAULT 1
#define PRINTER_ENUM_LOCAL 2
#define PRINTER_ENUM_CONNECTIONS 4
#define PRINTER_ENUM_FAVORITE 4
#define PRINTER_ENUM_NAME 8
#define PRINTER_ENUM_REMOTE 16
#define PRINTER_ENUM_SHARED 32
#define PRINTER_ENUM_NETWORK &h40
#define PRINTER_ENUM_EXPAND &h4000
#define PRINTER_ENUM_CONTAINER &h8000
#define PRINTER_ENUM_ICONMASK &hff0000
#define PRINTER_ENUM_ICON1 &h10000
#define PRINTER_ENUM_ICON2 &h20000
#define PRINTER_ENUM_ICON3 &h40000
#define PRINTER_ENUM_ICON4 &h80000
#define PRINTER_ENUM_ICON5 &h100000
#define PRINTER_ENUM_ICON6 &h200000
#define PRINTER_ENUM_ICON7 &h400000
#define PRINTER_ENUM_ICON8 &h800000
#define PRINTER_NOTIFY_TYPE 0
#define PRINTER_NOTIFY_FIELD_SERVER_NAME 0
#define PRINTER_NOTIFY_FIELD_PRINTER_NAME 1
#define PRINTER_NOTIFY_FIELD_SHARE_NAME 2
#define PRINTER_NOTIFY_FIELD_PORT_NAME 3
#define PRINTER_NOTIFY_FIELD_DRIVER_NAME 4
#define PRINTER_NOTIFY_FIELD_COMMENT 5
#define PRINTER_NOTIFY_FIELD_LOCATION 6
#define PRINTER_NOTIFY_FIELD_DEVMODE 7
#define PRINTER_NOTIFY_FIELD_SEPFILE 8
#define PRINTER_NOTIFY_FIELD_PRINT_PROCESSOR 9
#define PRINTER_NOTIFY_FIELD_PARAMETERS 10
#define PRINTER_NOTIFY_FIELD_DATATYPE 11
#define PRINTER_NOTIFY_FIELD_SECURITY_DESCRIPTOR 12
#define PRINTER_NOTIFY_FIELD_ATTRIBUTES 13
#define PRINTER_NOTIFY_FIELD_PRIORITY 14
#define PRINTER_NOTIFY_FIELD_DEFAULT_PRIORITY 15
#define PRINTER_NOTIFY_FIELD_START_TIME 16
#define PRINTER_NOTIFY_FIELD_UNTIL_TIME 17
#define PRINTER_NOTIFY_FIELD_STATUS 18
#define PRINTER_NOTIFY_FIELD_STATUS_STRING 19
#define PRINTER_NOTIFY_FIELD_CJOBS 20
#define PRINTER_NOTIFY_FIELD_AVERAGE_PPM 21
#define PRINTER_NOTIFY_FIELD_TOTAL_PAGES 22
#define PRINTER_NOTIFY_FIELD_PAGES_PRINTED 23
#define PRINTER_NOTIFY_FIELD_TOTAL_BYTES 24
#define PRINTER_NOTIFY_FIELD_BYTES_PRINTED 25
#define PRINTER_CHANGE_ADD_PRINTER 1
#define PRINTER_CHANGE_SET_PRINTER 2
#define PRINTER_CHANGE_DELETE_PRINTER 4
#define PRINTER_CHANGE_FAILED_CONNECTION_PRINTER 8
#define PRINTER_CHANGE_PRINTER &hFF
#define PRINTER_CHANGE_ADD_JOB &h100
#define PRINTER_CHANGE_SET_JOB &h200
#define PRINTER_CHANGE_DELETE_JOB &h400
#define PRINTER_CHANGE_WRITE_JOB &h800
#define PRINTER_CHANGE_JOB &hFF00
#define PRINTER_CHANGE_ADD_FORM &h10000
#define PRINTER_CHANGE_SET_FORM &h20000
#define PRINTER_CHANGE_DELETE_FORM &h40000
#define PRINTER_CHANGE_FORM &h70000
#define PRINTER_CHANGE_ADD_PORT &h100000
#define PRINTER_CHANGE_CONFIGURE_PORT &h200000
#define PRINTER_CHANGE_DELETE_PORT &h400000
#define PRINTER_CHANGE_PORT &h700000
#define PRINTER_CHANGE_ADD_PRINT_PROCESSOR &h1000000
#define PRINTER_CHANGE_DELETE_PRINT_PROCESSOR &h4000000
#define PRINTER_CHANGE_PRINT_PROCESSOR &h7000000
#define PRINTER_CHANGE_ADD_PRINTER_DRIVER &h10000000
#define PRINTER_CHANGE_SET_PRINTER_DRIVER &h20000000
#define PRINTER_CHANGE_DELETE_PRINTER_DRIVER &h40000000
#define PRINTER_CHANGE_PRINTER_DRIVER &h70000000
#define PRINTER_CHANGE_TIMEOUT &h80000000
#define PRINTER_CHANGE_ALL &h7777FFFF
#define PRINTER_NOTIFY_INFO_DISCARDED 1
#define PRINTER_ALL_ACCESS (&hF0000 or 4 or 8)
#define PRINTER_READ (&h20000 or 8)
#define PRINTER_WRITE (&h20000 or 8)
#define PRINTER_EXECUTE (&h20000 or 8)
#define NO_PRIORITY 0
#define MAX_PRIORITY 99
#define MIN_PRIORITY 1
#define DEF_PRIORITY 1
#define PORT_TYPE_WRITE 1
#define PORT_TYPE_READ 2
#define PORT_TYPE_REDIRECTED 4
#define PORT_TYPE_NET_ATTACHED 8
#define SERVER_ACCESS_ADMINISTER 1
#define SERVER_ACCESS_ENUMERATE 2
#define SERVER_ALL_ACCESS (&hF0000 or 1 or 2)
#define SERVER_READ (&h20000 or 2)
#define SERVER_WRITE (&h20000 or 1 or 2)
#define SERVER_EXECUTE (&h20000 or 2)
#define PORT_STATUS_TYPE_ERROR 1
#define PORT_STATUS_TYPE_WARNING 2
#define PORT_STATUS_TYPE_INFO 3
#define PORT_STATUS_OFFLINE 1
#define PORT_STATUS_PAPER_JAM 2
#define PORT_STATUS_PAPER_OUT 3
#define PORT_STATUS_OUTPUT_BIN_FULL 4
#define PORT_STATUS_PAPER_PROBLEM 5
#define PORT_STATUS_NO_TONER 6
#define PORT_STATUS_DOOR_OPEN 7
#define PORT_STATUS_USER_INTERVENTION 8
#define PORT_STATUS_OUT_OF_MEMORY 9
#define PORT_STATUS_TONER_LOW 10
#define PORT_STATUS_WARMING_UP 11
#define PORT_STATUS_POWER_SAVE 12


#ifndef UNICODE
type ADDJOB_INFO_1A
	Path as LPSTR
	JobId as DWORD
end type

type PADDJOB_INFO_1A as ADDJOB_INFO_1A ptr
type LPADDJOB_INFO_1A as ADDJOB_INFO_1A ptr

type DATATYPES_INFO_1A
	pName as LPSTR
end type

type PDATATYPES_INFO_1A as DATATYPES_INFO_1A ptr
type LPDATATYPES_INFO_1A as DATATYPES_INFO_1A ptr

type JOB_INFO_1A
	JobId as DWORD
	pPrinterName as LPSTR
	pMachineName as LPSTR
	pUserName as LPSTR
	pDocument as LPSTR
	pDatatype as LPSTR
	pStatus as LPSTR
	Status as DWORD
	Priority as DWORD
	Position as DWORD
	TotalPages as DWORD
	PagesPrinted as DWORD
	Submitted as SYSTEMTIME
end type

type PJOB_INFO_1A as JOB_INFO_1A ptr
type LPJOB_INFO_1A as JOB_INFO_1A ptr

type JOB_INFO_2A
	JobId as DWORD
	pPrinterName as LPSTR
	pMachineName as LPSTR
	pUserName as LPSTR
	pDocument as LPSTR
	pNotifyName as LPSTR
	pDatatype as LPSTR
	pPrintProcessor as LPSTR
	pParameters as LPSTR
	pDriverName as LPSTR
	pDevMode as LPDEVMODEA
	pStatus as LPSTR
	pSecurityDescriptor as PSECURITY_DESCRIPTOR
	Status as DWORD
	Priority as DWORD
	Position as DWORD
	StartTime as DWORD
	UntilTime as DWORD
	TotalPages as DWORD
	Size as DWORD
	Submitted as SYSTEMTIME
	Time as DWORD
	PagesPrinted as DWORD
end type

type PJOB_INFO_2A as JOB_INFO_2A ptr
type LPJOB_INFO_2A as JOB_INFO_2A ptr

type DOC_INFO_1A
	pDocName as LPSTR
	pOutputFile as LPSTR
	pDatatype as LPSTR
end type

type PDOC_INFO_1A as DOC_INFO_1A ptr
type LPDOC_INFO_1A as DOC_INFO_1A ptr

type DOC_INFO_2A
	pDocName as LPSTR
	pOutputFile as LPSTR
	pDatatype as LPSTR
	dwMode as DWORD
	JobId as DWORD
end type

type PDOC_INFO_2A as DOC_INFO_2A ptr
type LPDOC_INFO_2A as DOC_INFO_2A ptr

type DRIVER_INFO_1A
	pName as LPSTR
end type

type PDRIVER_INFO_1A as DRIVER_INFO_1A ptr
type LPDRIVER_INFO_1A as DRIVER_INFO_1A ptr

type DRIVER_INFO_2A
	cVersion as DWORD
	pName as LPSTR
	pEnvironment as LPSTR
	pDriverPath as LPSTR
	pDataFile as LPSTR
	pConfigFile as LPSTR
end type

type PDRIVER_INFO_2A as DRIVER_INFO_2A ptr
type LPDRIVER_INFO_2A as DRIVER_INFO_2A ptr

type DRIVER_INFO_3A
	cVersion as DWORD
	pName as LPSTR
	pEnvironment as LPSTR
	pDriverPath as LPSTR
	pDataFile as LPSTR
	pConfigFile as LPSTR
	pHelpFile as LPSTR
	pDependentFiles as LPSTR
	pMonitorName as LPSTR
	pDefaultDataType as LPSTR
end type

type PDRIVER_INFO_3A as DRIVER_INFO_3A ptr
type LPDRIVER_INFO_3A as DRIVER_INFO_3A ptr

type MONITOR_INFO_1A
	pName as LPSTR
end type

type PMONITOR_INFO_1A as MONITOR_INFO_1A ptr
type LPMONITOR_INFO_1A as MONITOR_INFO_1A ptr

type PORT_INFO_1A
	pName as LPSTR
end type

type PPORT_INFO_1A as PORT_INFO_1A ptr
type LPPORT_INFO_1A as PORT_INFO_1A ptr

type MONITOR_INFO_2A
	pName as LPSTR
	pEnvironment as LPSTR
	pDLLName as LPSTR
end type

type PMONITOR_INFO_2A as MONITOR_INFO_2A ptr
type LPMONITOR_INFO_2A as MONITOR_INFO_2A ptr

type PORT_INFO_2A
	pPortName as LPSTR
	pMonitorName as LPSTR
	pDescription as LPSTR
	fPortType as DWORD
	Reserved as DWORD
end type

type PPORT_INFO_2A as PORT_INFO_2A ptr
type LPPORT_INFO_2A as PORT_INFO_2A ptr

type PORT_INFO_3A
	dwStatus as DWORD
	pszStatus as LPSTR
	dwSeverity as DWORD
end type

type PPORT_INFO_3A as PORT_INFO_3A ptr
type LPPORT_INFO_3A as PORT_INFO_3A ptr

type PRINTER_INFO_1A
	Flags as DWORD
	pDescription as LPSTR
	pName as LPSTR
	pComment as LPSTR
end type

type PPRINTER_INFO_1A as PRINTER_INFO_1A ptr
type LPPRINTER_INFO_1A as PRINTER_INFO_1A ptr

type PRINTER_INFO_2A
	pServerName as LPSTR
	pPrinterName as LPSTR
	pShareName as LPSTR
	pPortName as LPSTR
	pDriverName as LPSTR
	pComment as LPSTR
	pLocation as LPSTR
	pDevMode as LPDEVMODEA
	pSepFile as LPSTR
	pPrintProcessor as LPSTR
	pDatatype as LPSTR
	pParameters as LPSTR
	pSecurityDescriptor as PSECURITY_DESCRIPTOR
	Attributes as DWORD
	Priority as DWORD
	DefaultPriority as DWORD
	StartTime as DWORD
	UntilTime as DWORD
	Status as DWORD
	cJobs as DWORD
	AveragePPM as DWORD
end type

type PPRINTER_INFO_2A as PRINTER_INFO_2A ptr
type LPPRINTER_INFO_2A as PRINTER_INFO_2A ptr

#else ''UNICODE
type ADDJOB_INFO_1W
	Path as LPWSTR
	JobId as DWORD
end type

type PADDJOB_INFO_1W as ADDJOB_INFO_1W ptr
type LPADDJOB_INFO_1W as ADDJOB_INFO_1W ptr

type DATATYPES_INFO_1W
	pName as LPWSTR
end type

type PDATATYPES_INFO_1W as DATATYPES_INFO_1W ptr
type LPDATATYPES_INFO_1W as DATATYPES_INFO_1W ptr

type JOB_INFO_1W
	JobId as DWORD
	pPrinterName as LPWSTR
	pMachineName as LPWSTR
	pUserName as LPWSTR
	pDocument as LPWSTR
	pDatatype as LPWSTR
	pStatus as LPWSTR
	Status as DWORD
	Priority as DWORD
	Position as DWORD
	TotalPages as DWORD
	PagesPrinted as DWORD
	Submitted as SYSTEMTIME
end type

type PJOB_INFO_1W as JOB_INFO_1W ptr
type LPJOB_INFO_1W as JOB_INFO_1W ptr

type JOB_INFO_2W
	JobId as DWORD
	pPrinterName as LPWSTR
	pMachineName as LPWSTR
	pUserName as LPWSTR
	pDocument as LPWSTR
	pNotifyName as LPWSTR
	pDatatype as LPWSTR
	pPrintProcessor as LPWSTR
	pParameters as LPWSTR
	pDriverName as LPWSTR
	pDevMode as LPDEVMODEW
	pStatus as LPWSTR
	pSecurityDescriptor as PSECURITY_DESCRIPTOR
	Status as DWORD
	Priority as DWORD
	Position as DWORD
	StartTime as DWORD
	UntilTime as DWORD
	TotalPages as DWORD
	Size as DWORD
	Submitted as SYSTEMTIME
	Time as DWORD
	PagesPrinted as DWORD
end type

type PJOB_INFO_2W as JOB_INFO_2W ptr
type LPJOB_INFO_2W as JOB_INFO_2W ptr

type DOC_INFO_1W
	pDocName as LPWSTR
	pOutputFile as LPWSTR
	pDatatype as LPWSTR
end type

type PDOC_INFO_1W as DOC_INFO_1W ptr
type LPDOC_INFO_1W as DOC_INFO_1W ptr

type DOC_INFO_2W
	pDocName as LPWSTR
	pOutputFile as LPWSTR
	pDatatype as LPWSTR
	dwMode as DWORD
	JobId as DWORD
end type

type PDOC_INFO_2W as DOC_INFO_2W ptr
type LPDOC_INFO_2W as DOC_INFO_2W ptr

type DRIVER_INFO_1W
	pName as LPWSTR
end type

type PDRIVER_INFO_1W as DRIVER_INFO_1W ptr
type LPDRIVER_INFO_1W as DRIVER_INFO_1W ptr

type DRIVER_INFO_2W
	cVersion as DWORD
	pName as LPWSTR
	pEnvironment as LPWSTR
	pDriverPath as LPWSTR
	pDataFile as LPWSTR
	pConfigFile as LPWSTR
end type

type PDRIVER_INFO_2W as DRIVER_INFO_2W ptr
type LPDRIVER_INFO_2W as DRIVER_INFO_2W ptr

type DRIVER_INFO_3W
	cVersion as DWORD
	pName as LPWSTR
	pEnvironment as LPWSTR
	pDriverPath as LPWSTR
	pDataFile as LPWSTR
	pConfigFile as LPWSTR
	pHelpFile as LPWSTR
	pDependentFiles as LPWSTR
	pMonitorName as LPWSTR
	pDefaultDataType as LPWSTR
end type

type PDRIVER_INFO_3W as DRIVER_INFO_3W ptr
type LPDRIVER_INFO_3W as DRIVER_INFO_3W ptr

type MONITOR_INFO_1W
	pName as LPWSTR
end type

type PMONITOR_INFO_1W as MONITOR_INFO_1W ptr
type LPMONITOR_INFO_1W as MONITOR_INFO_1W ptr

type PORT_INFO_1W
	pName as LPWSTR
end type

type PPORT_INFO_1W as PORT_INFO_1W ptr
type LPPORT_INFO_1W as PORT_INFO_1W ptr

type MONITOR_INFO_2W
	pName as LPWSTR
	pEnvironment as LPWSTR
	pDLLName as LPWSTR
end type

type PMONITOR_INFO_2W as MONITOR_INFO_2W ptr
type LPMONITOR_INFO_2W as MONITOR_INFO_2W ptr

type PORT_INFO_2W
	pPortName as LPWSTR
	pMonitorName as LPWSTR
	pDescription as LPWSTR
	fPortType as DWORD
	Reserved as DWORD
end type

type PPORT_INFO_2W as PORT_INFO_2W ptr
type LPPORT_INFO_2W as PORT_INFO_2W ptr

type PORT_INFO_3W
	dwStatus as DWORD
	pszStatus as LPWSTR
	dwSeverity as DWORD
end type

type PPORT_INFO_3W as PORT_INFO_3W ptr
type LPPORT_INFO_3W as PORT_INFO_3W ptr

type PRINTER_INFO_1W
	Flags as DWORD
	pDescription as LPWSTR
	pName as LPWSTR
	pComment as LPWSTR
end type

type PPRINTER_INFO_1W as PRINTER_INFO_1W ptr
type LPPRINTER_INFO_1W as PRINTER_INFO_1W ptr

type PRINTER_INFO_2W
	pServerName as LPWSTR
	pPrinterName as LPWSTR
	pShareName as LPWSTR
	pPortName as LPWSTR
	pDriverName as LPWSTR
	pComment as LPWSTR
	pLocation as LPWSTR
	pDevMode as LPDEVMODEW
	pSepFile as LPWSTR
	pPrintProcessor as LPWSTR
	pDatatype as LPWSTR
	pParameters as LPWSTR
	pSecurityDescriptor as PSECURITY_DESCRIPTOR
	Attributes as DWORD
	Priority as DWORD
	DefaultPriority as DWORD
	StartTime as DWORD
	UntilTime as DWORD
	Status as DWORD
	cJobs as DWORD
	AveragePPM as DWORD
end type

type PPRINTER_INFO_2W as PRINTER_INFO_2W ptr
type LPPRINTER_INFO_2W as PRINTER_INFO_2W ptr

#endif ''UNICODE

type PRINTER_INFO_3
	pSecurityDescriptor as PSECURITY_DESCRIPTOR
end type

type PPRINTER_INFO_3 as PRINTER_INFO_3 ptr
type LPPRINTER_INFO_3 as PRINTER_INFO_3 ptr

#ifndef UNICODE
type PRINTER_INFO_4A
	pPrinterName as LPSTR
	pServerName as LPSTR
	Attributes as DWORD
end type

type PPRINTER_INFO_4A as PRINTER_INFO_4A ptr
type LPPRINTER_INFO_4A as PRINTER_INFO_4A ptr

type PRINTER_INFO_5A
	pPrinterName as LPSTR
	pPortName as LPSTR
	Attributes as DWORD
	DeviceNotSelectedTimeout as DWORD
	TransmissionRetryTimeout as DWORD
end type

type PPRINTER_INFO_5A as PRINTER_INFO_5A ptr
type LPPRINTER_INFO_5A as PRINTER_INFO_5A ptr

#else ''UNICODE
type PRINTER_INFO_4W
	pPrinterName as LPWSTR
	pServerName as LPWSTR
	Attributes as DWORD
end type

type PPRINTER_INFO_4W as PRINTER_INFO_4W ptr
type LPPRINTER_INFO_4W as PRINTER_INFO_4W ptr

type PRINTER_INFO_5W
	pPrinterName as LPWSTR
	pPortName as LPWSTR
	Attributes as DWORD
	DeviceNotSelectedTimeout as DWORD
	TransmissionRetryTimeout as DWORD
end type

type PPRINTER_INFO_5W as PRINTER_INFO_5W ptr
type LPPRINTER_INFO_5W as PRINTER_INFO_5W ptr

#endif ''UNICODE

type PRINTER_INFO_6
	dwStatus as DWORD
end type

type PPRINTER_INFO_6 as PRINTER_INFO_6 ptr
type LPPRINTER_INFO_6 as PRINTER_INFO_6 ptr

#ifndef UNICODE
type PRINTPROCESSOR_INFO_1A
	pName as LPSTR
end type

type PPRINTPROCESSOR_INFO_1A as PRINTPROCESSOR_INFO_1A ptr
type LPPRINTPROCESSOR_INFO_1A as PRINTPROCESSOR_INFO_1A ptr

#else ''UNICODE
type PRINTPROCESSOR_INFO_1W
	pName as LPWSTR
end type

type PPRINTPROCESSOR_INFO_1W as PRINTPROCESSOR_INFO_1W ptr
type LPPRINTPROCESSOR_INFO_1W as PRINTPROCESSOR_INFO_1W ptr
#endif ''UNICODE

type PRINTER_NOTIFY_INFO_DATA_NotifyData_Data
	cbBuf as DWORD
	pBuf as PVOID
end type

union PRINTER_NOTIFY_INFO_DATA_NotifyData
	adwData(0 to 2-1) as DWORD
	Data as PRINTER_NOTIFY_INFO_DATA_NotifyData_Data
end union

type PRINTER_NOTIFY_INFO_DATA
	Type as WORD
	Field as WORD
	Reserved as DWORD
	Id as DWORD
	NotifyData as PRINTER_NOTIFY_INFO_DATA_NotifyData
end type

type PPRINTER_NOTIFY_INFO_DATA as PRINTER_NOTIFY_INFO_DATA ptr
type LPPRINTER_NOTIFY_INFO_DATA as PRINTER_NOTIFY_INFO_DATA ptr

type PRINTER_NOTIFY_INFO
	Version as DWORD
	Flags as DWORD
	Count as DWORD
	aData(0 to 1-1) as PRINTER_NOTIFY_INFO_DATA
end type

type PPRINTER_NOTIFY_INFO as PRINTER_NOTIFY_INFO ptr
type LPPRINTER_NOTIFY_INFO as PRINTER_NOTIFY_INFO ptr

#ifndef UNICODE
type FORM_INFO_1A
	Flags as DWORD
	pName as LPSTR
	Size as SIZEL
	ImageableArea as RECTL
end type

type PFORM_INFO_1A as FORM_INFO_1A ptr
type LPFORM_INFO_1A as FORM_INFO_1A ptr

type PRINTER_DEFAULTSA
	pDatatype as LPSTR
	pDevMode as LPDEVMODE
	DesiredAccess as ACCESS_MASK
end type

type PPRINTER_DEFAULTSA as PRINTER_DEFAULTSA ptr
type LPPRINTER_DEFAULTSA as PRINTER_DEFAULTSA ptr

#else ''UNICODE
type FORM_INFO_1W
	Flags as DWORD
	pName as LPWSTR
	Size as SIZEL
	ImageableArea as RECTL
end type

type PFORM_INFO_1W as FORM_INFO_1W ptr
type LPFORM_INFO_1W as FORM_INFO_1W ptr

type PRINTER_DEFAULTSW
	pDatatype as LPWSTR
	pDevMode as LPDEVMODE
	DesiredAccess as ACCESS_MASK
end type

type PPRINTER_DEFAULTSW as PRINTER_DEFAULTSW ptr
type LPPRINTER_DEFAULTSW as PRINTER_DEFAULTSW ptr

#endif ''UNICODE

declare function AbortPrinter alias "AbortPrinter" (byval as HANDLE) as BOOL
declare function ClosePrinter alias "ClosePrinter" (byval as HANDLE) as BOOL
declare function ConnectToPrinterDlg alias "ConnectToPrinterDlg" (byval as HWND, byval as DWORD) as HANDLE
declare function DeletePrinter alias "DeletePrinter" (byval as HANDLE) as BOOL
declare function EndDocPrinter alias "EndDocPrinter" (byval as HANDLE) as BOOL
declare function EndPagePrinter alias "EndPagePrinter" (byval as HANDLE) as BOOL
declare function FindClosePrinterChangeNotification alias "FindClosePrinterChangeNotification" (byval as HANDLE) as BOOL
declare function FindFirstPrinterChangeNotification alias "FindFirstPrinterChangeNotification" (byval as HANDLE, byval as DWORD, byval as DWORD, byval as PVOID) as HANDLE
declare function FindNextPrinterChangeNotification alias "FindNextPrinterChangeNotification" (byval as HANDLE, byval as PDWORD, byval as PVOID, byval as PVOID ptr) as HANDLE
declare function FreePrinterNotifyInfo alias "FreePrinterNotifyInfo" (byval as PPRINTER_NOTIFY_INFO) as BOOL
declare function PrinterProperties alias "PrinterProperties" (byval as HWND, byval as HANDLE) as BOOL
declare function ReadPrinter alias "ReadPrinter" (byval as HANDLE, byval as PVOID, byval as DWORD, byval as PDWORD) as BOOL
declare function ScheduleJob alias "ScheduleJob" (byval as HANDLE, byval as DWORD) as BOOL
declare function StartPagePrinter alias "StartPagePrinter" (byval as HANDLE) as BOOL
declare function WaitForPrinterChange alias "WaitForPrinterChange" (byval as HANDLE, byval as DWORD) as DWORD
declare function WritePrinter alias "WritePrinter" (byval as HANDLE, byval as PVOID, byval as DWORD, byval as PDWORD) as BOOL

#ifdef UNICODE
declare function AddForm alias "AddFormW" (byval as HANDLE, byval as DWORD, byval as PBYTE) as BOOL
declare function AddJob alias "AddJobW" (byval as HANDLE, byval as DWORD, byval as PBYTE, byval as DWORD, byval as PDWORD) as BOOL
declare function AddMonitor alias "AddMonitorW" (byval as LPWSTR, byval as DWORD, byval as PBYTE) as BOOL
declare function AddPort alias "AddPortW" (byval as LPWSTR, byval as HWND, byval as LPWSTR) as BOOL
declare function AddPrinter alias "AddPrinterW" (byval as LPWSTR, byval as DWORD, byval as PBYTE) as HANDLE
declare function AddPrinterConnection alias "AddPrinterConnectionW" (byval as LPWSTR) as BOOL
declare function AddPrinterDriver alias "AddPrinterDriverW" (byval as LPWSTR, byval as DWORD, byval as PBYTE) as BOOL
declare function AddPrintProcessor alias "AddPrintProcessorW" (byval as LPWSTR, byval as LPWSTR, byval as LPWSTR, byval as LPWSTR) as BOOL
declare function AddPrintProvidor alias "AddPrintProvidorW" (byval as LPWSTR, byval as DWORD, byval as PBYTE) as BOOL
declare function AdvancedDocumentProperties alias "AdvancedDocumentPropertiesW" (byval as HWND, byval as HANDLE, byval as LPWSTR, byval as PDEVMODE, byval as PDEVMODEW) as LONG
declare function ConfigurePort alias "ConfigurePortW" (byval as LPWSTR, byval as HWND, byval as LPWSTR) as BOOL
declare function DeleteForm alias "DeleteFormW" (byval as HANDLE, byval as LPWSTR) as BOOL
declare function DeleteMonitor alias "DeleteMonitorW" (byval as LPWSTR, byval as LPWSTR, byval as LPWSTR) as BOOL
declare function DeletePort alias "DeletePortW" (byval as LPWSTR, byval as HWND, byval as LPWSTR) as BOOL
declare function DeletePrinterConnection alias "DeletePrinterConnectionW" (byval as LPWSTR) as BOOL
declare function DeletePrinterData alias "DeletePrinterDataW" (byval as HANDLE, byval as LPWSTR) as DWORD
declare function DeletePrinterDriver alias "DeletePrinterDriverW" (byval as LPWSTR, byval as LPWSTR, byval as LPWSTR) as BOOL
declare function DeletePrintProcessor alias "DeletePrintProcessorW" (byval as LPWSTR, byval as LPWSTR, byval as LPWSTR) as BOOL
declare function DeletePrintProvidor alias "DeletePrintProvidorW" (byval as LPWSTR, byval as LPWSTR, byval as LPWSTR) as BOOL
declare function DocumentProperties alias "DocumentPropertiesW" (byval as HWND, byval as HANDLE, byval as LPWSTR, byval as PDEVMODEW, byval as PDEVMODEW, byval as DWORD) as LONG
declare function EnumForms alias "EnumFormsW" (byval as HANDLE, byval as DWORD, byval as PBYTE, byval as DWORD, byval as PDWORD, byval as PDWORD) as BOOL
declare function EnumJobs alias "EnumJobsW" (byval as HANDLE, byval as DWORD, byval as DWORD, byval as DWORD, byval as PBYTE, byval as DWORD, byval as PDWORD, byval as PDWORD) as BOOL
declare function EnumMonitors alias "EnumMonitorsW" (byval as LPWSTR, byval as DWORD, byval as PBYTE, byval as DWORD, byval as PDWORD, byval as PDWORD) as BOOL
declare function EnumPorts alias "EnumPortsW" (byval as LPWSTR, byval as DWORD, byval as PBYTE, byval as DWORD, byval as PDWORD, byval as PDWORD) as BOOL
declare function EnumPrinterData alias "EnumPrinterDataW" (byval as HANDLE, byval as DWORD, byval as LPWSTR, byval as DWORD, byval as PDWORD, byval as PDWORD, byval as PBYTE, byval as DWORD, byval as PDWORD) as DWORD
declare function EnumPrinterDrivers alias "EnumPrinterDriversW" (byval as LPWSTR, byval as LPWSTR, byval as DWORD, byval as PBYTE, byval as DWORD, byval as PDWORD, byval as PDWORD) as BOOL
declare function EnumPrinters alias "EnumPrintersW" (byval as DWORD, byval as LPWSTR, byval as DWORD, byval as PBYTE, byval as DWORD, byval as PDWORD, byval as PDWORD) as BOOL
declare function EnumPrintProcessorDatatypes alias "EnumPrintProcessorDatatypesW" (byval as LPWSTR, byval as LPWSTR, byval as DWORD, byval as PBYTE, byval as DWORD, byval as PDWORD, byval as PDWORD) as BOOL
declare function EnumPrintProcessors alias "EnumPrintProcessorsW" (byval as LPWSTR, byval as LPWSTR, byval as DWORD, byval as PBYTE, byval as DWORD, byval as PDWORD, byval as PDWORD) as BOOL
declare function GetDefaultPrinter alias "GetDefaultPrinterW" (byval as LPWSTR, byval as LPDWORD) as BOOL
declare function GetForm alias "GetFormW" (byval as HANDLE, byval as LPWSTR, byval as DWORD, byval as PBYTE, byval as DWORD, byval as PDWORD) as BOOL
declare function GetJob alias "GetJobW" (byval as HANDLE, byval as DWORD, byval as DWORD, byval as PBYTE, byval as DWORD, byval as PDWORD) as BOOL
declare function GetPrinter alias "GetPrinterW" (byval as HANDLE, byval as DWORD, byval as PBYTE, byval as DWORD, byval as PDWORD) as BOOL
declare function GetPrinterData alias "GetPrinterDataW" (byval as HANDLE, byval as LPWSTR, byval as PDWORD, byval as PBYTE, byval as DWORD, byval as PDWORD) as DWORD
declare function GetPrinterDriver alias "GetPrinterDriverW" (byval as HANDLE, byval as LPWSTR, byval as DWORD, byval as PBYTE, byval as DWORD, byval as PDWORD) as DWORD
declare function GetPrinterDriverDirectory alias "GetPrinterDriverDirectoryW" (byval as LPWSTR, byval as LPWSTR, byval as DWORD, byval as PBYTE, byval as DWORD, byval as PDWORD) as DWORD
declare function GetPrintProcessorDirectory alias "GetPrintProcessorDirectoryW" (byval as LPWSTR, byval as LPWSTR, byval as DWORD, byval as PBYTE, byval as DWORD, byval as PDWORD) as DWORD
declare function OpenPrinter alias "OpenPrinterW" (byval as LPWSTR, byval as PHANDLE, byval as LPPRINTER_DEFAULTSW) as BOOL
declare function PrinterMessageBox alias "PrinterMessageBoxW" (byval as HANDLE, byval as DWORD, byval as HWND, byval as LPWSTR, byval as LPWSTR, byval as DWORD) as DWORD
declare function ResetPrinter alias "ResetPrinterW" (byval as HANDLE, byval as LPPRINTER_DEFAULTSW) as BOOL
declare function SetForm alias "SetFormW" (byval as HANDLE, byval as LPWSTR, byval as DWORD, byval as PBYTE) as BOOL
declare function SetJob alias "SetJobW" (byval as HANDLE, byval as DWORD, byval as DWORD, byval as PBYTE, byval as DWORD) as BOOL
declare function SetPrinter alias "SetPrinterW" (byval as HANDLE, byval as DWORD, byval as PBYTE, byval as DWORD) as BOOL
declare function SetPrinterData alias "SetPrinterDataW" (byval as HANDLE, byval as LPWSTR, byval as DWORD, byval as PBYTE, byval as DWORD) as BOOL
declare function StartDocPrinter alias "StartDocPrinterW" (byval as HANDLE, byval as DWORD, byval as PBYTE) as DWORD

type JOB_INFO_1 as JOB_INFO_1W
type PJOB_INFO_1 as JOB_INFO_1W ptr
type LPJOB_INFO_1 as JOB_INFO_1W ptr
type JOB_INFO_2 as JOB_INFO_2W
type PJOB_INFO_2 as JOB_INFO_2W ptr
type LPJOB_INFO_2 as JOB_INFO_2W ptr
type ADDJOB_INFO_1 as ADDJOB_INFO_1W
type PADDJOB_INFO_1 as ADDJOB_INFO_1W ptr
type LPADDJOB_INFO_1 as ADDJOB_INFO_1w ptr
type DATATYPES_INFO_1 as DATATYPES_INFO_1W
type PDATATYPES_INFO_1 as DATATYPES_INFO_1W ptr
type LPDATATYPES_INFO_1 as DATATYPES_INFO_1W ptr
type MONITOR_INFO_1 as MONITOR_INFO_1W
type PMONITOR_INFO_1 as MONITOR_INFO_1W ptr
type LPMONITOR_INFO_1 as MONITOR_INFO_1W ptr
type MONITOR_INFO_2 as MONITOR_INFO_2W
type PMONITOR_INFO_2 as MONITOR_INFO_2W ptr
type LPMONITOR_INFO_2 as MONITOR_INFO_2W ptr
type DOC_INFO_1 as DOC_INFO_1W
type PDOC_INFO_1 as DOC_INFO_1W ptr
type LPDOC_INFO_1 as DOC_INFO_1W ptr
type DOC_INFO_2 as DOC_INFO_2W
type PDOC_INFO_2 as DOC_INFO_2W ptr
type LPDOC_INFO_2 as DOC_INFO_2W ptr
type PORT_INFO_1 as PORT_INFO_1W
type PPORT_INFO_1 as PORT_INFO_1W ptr
type LPPORT_INFO_1 as PORT_INFO_1W ptr
type PORT_INFO_2 as PORT_INFO_2W
type PPORT_INFO_2 as PORT_INFO_2W ptr
type LPPORT_INFO_2 as PORT_INFO_2W ptr
type PORT_INFO_3 as PORT_INFO_3W
type PPORT_INFO_3 as PORT_INFO_3W ptr
type LPPORT_INFO_3 as PORT_INFO_3W ptr
type DRIVER_INFO_2 as DRIVER_INFO_2W
type PDRIVER_INFO_2 as DRIVER_INFO_2W ptr
type LPDRIVER_INFO_2 as DRIVER_INFO_2W ptr
type PRINTER_INFO_1 as PRINTER_INFO_1W
type PPRINTER_INFO_1 as PRINTER_INFO_1W ptr
type LPPRINTER_INFO_1 as PRINTER_INFO_1W ptr
type PRINTER_INFO_2 as PRINTER_INFO_2W
type PPRINTER_INFO_2 as PRINTER_INFO_2W ptr
type LPPRINTER_INFO_2 as PRINTER_INFO_2W ptr
type PRINTER_INFO_4 as PRINTER_INFO_4W
type PPRINTER_INFO_4 as PRINTER_INFO_4W ptr
type LPPRINTER_INFO_4 as PRINTER_INFO_4W ptr
type PRINTER_INFO_5 as PRINTER_INFO_5W
type PPRINTER_INFO_5 as PRINTER_INFO_5W ptr
type LPPRINTER_INFO_5 as PRINTER_INFO_5W ptr
type PRINTPROCESSOR_INFO_1 as PRINTPROCESSOR_INFO_1W
type PPRINTPROCESSOR_INFO_1 as PRINTPROCESSOR_INFO_1W ptr
type LPPRINTPROCESSOR_INFO_1 as PRINTPROCESSOR_INFO_1W ptr
type FORM_INFO_1 as FORM_INFO_1W
type PFORM_INFO_1 as FORM_INFO_1W ptr
type LPFORM_INFO_1 as FORM_INFO_1W ptr
type PRINTER_DEFAULTS as PRINTER_DEFAULTSW
type PPRINTER_DEFAULTS as PRINTER_DEFAULTSW ptr
type LPPRINTER_DEFAULTS as PRINTER_DEFAULTSW ptr

#else ''UNICODE
declare function AddForm alias "AddFormA" (byval as HANDLE, byval as DWORD, byval as PBYTE) as BOOL
declare function AddJob alias "AddJobA" (byval as HANDLE, byval as DWORD, byval as PBYTE, byval as DWORD, byval as PDWORD) as BOOL
declare function AddMonitor alias "AddMonitorA" (byval as LPSTR, byval as DWORD, byval as PBYTE) as BOOL
declare function AddPort alias "AddPortA" (byval as LPSTR, byval as HWND, byval as LPSTR) as BOOL
declare function AddPrinter alias "AddPrinterA" (byval as LPSTR, byval as DWORD, byval as PBYTE) as HANDLE
declare function AddPrinterConnection alias "AddPrinterConnectionA" (byval as LPSTR) as BOOL
declare function AddPrinterDriver alias "AddPrinterDriverA" (byval as LPSTR, byval as DWORD, byval as PBYTE) as BOOL
declare function AddPrintProcessor alias "AddPrintProcessorA" (byval as LPSTR, byval as LPSTR, byval as LPSTR, byval as LPSTR) as BOOL
declare function AddPrintProvidor alias "AddPrintProvidorA" (byval as LPSTR, byval as DWORD, byval as PBYTE) as BOOL
declare function AdvancedDocumentProperties alias "AdvancedDocumentPropertiesA" (byval as HWND, byval as HANDLE, byval as LPSTR, byval as PDEVMODE, byval as PDEVMODEA) as LONG
declare function ConfigurePort alias "ConfigurePortA" (byval as LPSTR, byval as HWND, byval as LPSTR) as BOOL
declare function DeleteForm alias "DeleteFormA" (byval as HANDLE, byval as LPSTR) as BOOL
declare function DeleteMonitor alias "DeleteMonitorA" (byval as LPSTR, byval as LPSTR, byval as LPSTR) as BOOL
declare function DeletePort alias "DeletePortA" (byval as LPSTR, byval as HWND, byval as LPSTR) as BOOL
declare function DeletePrinterConnection alias "DeletePrinterConnectionA" (byval as LPSTR) as BOOL
declare function DeletePrinterData alias "DeletePrinterDataA" (byval as HANDLE, byval as LPSTR) as DWORD
declare function DeletePrinterDriver alias "DeletePrinterDriverA" (byval as LPSTR, byval as LPSTR, byval as LPSTR) as BOOL
declare function DeletePrintProcessor alias "DeletePrintProcessorA" (byval as LPSTR, byval as LPSTR, byval as LPSTR) as BOOL
declare function DeletePrintProvidor alias "DeletePrintProvidorA" (byval as LPSTR, byval as LPSTR, byval as LPSTR) as BOOL
declare function DocumentProperties alias "DocumentPropertiesA" (byval as HWND, byval as HANDLE, byval as LPSTR, byval as PDEVMODEA, byval as PDEVMODEA, byval as DWORD) as LONG
declare function EnumForms alias "EnumFormsA" (byval as HANDLE, byval as DWORD, byval as PBYTE, byval as DWORD, byval as PDWORD, byval as PDWORD) as BOOL
declare function EnumJobs alias "EnumJobsA" (byval as HANDLE, byval as DWORD, byval as DWORD, byval as DWORD, byval as PBYTE, byval as DWORD, byval as PDWORD, byval as PDWORD) as BOOL
declare function EnumMonitors alias "EnumMonitorsA" (byval as LPSTR, byval as DWORD, byval as PBYTE, byval as DWORD, byval as PDWORD, byval as PDWORD) as BOOL
declare function EnumPorts alias "EnumPortsA" (byval as LPSTR, byval as DWORD, byval as PBYTE, byval as DWORD, byval as PDWORD, byval as PDWORD) as BOOL
declare function EnumPrinterData alias "EnumPrinterDataA" (byval as HANDLE, byval as DWORD, byval as LPSTR, byval as DWORD, byval as PDWORD, byval as PDWORD, byval as PBYTE, byval as DWORD, byval as PDWORD) as DWORD
declare function EnumPrinterDrivers alias "EnumPrinterDriversA" (byval as LPSTR, byval as LPSTR, byval as DWORD, byval as PBYTE, byval as DWORD, byval as PDWORD, byval as PDWORD) as BOOL
declare function EnumPrinters alias "EnumPrintersA" (byval as DWORD, byval as LPSTR, byval as DWORD, byval as PBYTE, byval as DWORD, byval as PDWORD, byval as PDWORD) as BOOL
declare function EnumPrintProcessorDatatypes alias "EnumPrintProcessorDatatypesA" (byval as LPSTR, byval as LPSTR, byval as DWORD, byval as PBYTE, byval as DWORD, byval as PDWORD, byval as PDWORD) as BOOL
declare function EnumPrintProcessors alias "EnumPrintProcessorsA" (byval as LPSTR, byval as LPSTR, byval as DWORD, byval as PBYTE, byval as DWORD, byval as PDWORD, byval as PDWORD) as BOOL
declare function GetDefaultPrinter alias "GetDefaultPrinterA" (byval as LPSTR, byval as LPDWORD) as BOOL
declare function GetForm alias "GetFormA" (byval as HANDLE, byval as LPSTR, byval as DWORD, byval as PBYTE, byval as DWORD, byval as PDWORD) as BOOL
declare function GetJob alias "GetJobA" (byval as HANDLE, byval as DWORD, byval as DWORD, byval as PBYTE, byval as DWORD, byval as PDWORD) as BOOL
declare function GetPrinter alias "GetPrinterA" (byval as HANDLE, byval as DWORD, byval as PBYTE, byval as DWORD, byval as PDWORD) as BOOL
declare function GetPrinterData alias "GetPrinterDataA" (byval as HANDLE, byval as LPSTR, byval as PDWORD, byval as PBYTE, byval as DWORD, byval as PDWORD) as DWORD
declare function GetPrinterDriver alias "GetPrinterDriverA" (byval as HANDLE, byval as LPSTR, byval as DWORD, byval as PBYTE, byval as DWORD, byval as PDWORD) as DWORD
declare function GetPrinterDriverDirectory alias "GetPrinterDriverDirectoryA" (byval as LPSTR, byval as LPSTR, byval as DWORD, byval as PBYTE, byval as DWORD, byval as PDWORD) as DWORD
declare function GetPrintProcessorDirectory alias "GetPrintProcessorDirectoryA" (byval as LPSTR, byval as LPSTR, byval as DWORD, byval as PBYTE, byval as DWORD, byval as PDWORD) as DWORD
declare function OpenPrinter alias "OpenPrinterA" (byval as LPSTR, byval as PHANDLE, byval as LPPRINTER_DEFAULTSA) as BOOL
declare function PrinterMessageBox alias "PrinterMessageBoxA" (byval as HANDLE, byval as DWORD, byval as HWND, byval as LPSTR, byval as LPSTR, byval as DWORD) as DWORD
declare function ResetPrinter alias "ResetPrinterA" (byval as HANDLE, byval as LPPRINTER_DEFAULTSA) as BOOL
declare function SetForm alias "SetFormA" (byval as HANDLE, byval as LPSTR, byval as DWORD, byval as PBYTE) as BOOL
declare function SetJob alias "SetJobA" (byval as HANDLE, byval as DWORD, byval as DWORD, byval as PBYTE, byval as DWORD) as BOOL
declare function SetPrinter alias "SetPrinterA" (byval as HANDLE, byval as DWORD, byval as PBYTE, byval as DWORD) as BOOL
declare function SetPrinterData alias "SetPrinterDataA" (byval as HANDLE, byval as LPSTR, byval as DWORD, byval as PBYTE, byval as DWORD) as BOOL
declare function StartDocPrinter alias "StartDocPrinterA" (byval as HANDLE, byval as DWORD, byval as PBYTE) as DWORD

type JOB_INFO_1 as JOB_INFO_1A
type PJOB_INFO_1 as JOB_INFO_1A ptr
type LPJOB_INFO_1 as JOB_INFO_1A ptr
type JOB_INFO_2 as JOB_INFO_2A
type PJOB_INFO_2 as JOB_INFO_2A ptr
type LPJOB_INFO_2 as JOB_INFO_2A ptr
type ADDJOB_INFO_1 as ADDJOB_INFO_1A
type PADDJOB_INFO_1 as ADDJOB_INFO_1A ptr
type LPADDJOB_INFO_1 as ADDJOB_INFO_1A ptr
type DATATYPES_INFO_1 as DATATYPES_INFO_1A
type PDATATYPES_INFO_1 as DATATYPES_INFO_1A ptr
type LPDATATYPES_INFO_1 as DATATYPES_INFO_1A ptr
type MONITOR_INFO_1 as MONITOR_INFO_1A
type PMONITOR_INFO_1 as MONITOR_INFO_1A ptr
type LPMONITOR_INFO_1 as MONITOR_INFO_1A ptr
type MONITOR_INFO_2 as MONITOR_INFO_2A
type PMONITOR_INFO_2 as MONITOR_INFO_2A ptr
type LPMONITOR_INFO_2 as MONITOR_INFO_2A ptr
type DOC_INFO_1 as DOC_INFO_1A
type PDOC_INFO_1 as DOC_INFO_1A ptr
type LPDOC_INFO_1 as DOC_INFO_1A ptr
type DOC_INFO_2 as DOC_INFO_2A
type PDOC_INFO_2 as DOC_INFO_2A ptr
type LPDOC_INFO_2 as DOC_INFO_2A ptr
type PORT_INFO_1 as PORT_INFO_1A
type PPORT_INFO_1 as PORT_INFO_1A ptr
type LPPORT_INFO_1 as PORT_INFO_1A ptr
type PORT_INFO_2 as PORT_INFO_2A
type PPORT_INFO_2 as PORT_INFO_2A ptr
type LPPORT_INFO_2 as PORT_INFO_2A ptr
type PORT_INFO_3 as PORT_INFO_3A
type PPORT_INFO_3 as PORT_INFO_3A ptr
type LPPORT_INFO_3 as PORT_INFO_3A ptr
type DRIVER_INFO_2 as DRIVER_INFO_2A
type PDRIVER_INFO_2 as DRIVER_INFO_2A ptr
type LPDRIVER_INFO_2 as DRIVER_INFO_2A ptr
type PRINTER_INFO_1 as PRINTER_INFO_1A
type PPRINTER_INFO_1 as PRINTER_INFO_1A ptr
type LPPRINTER_INFO_1 as PRINTER_INFO_1A ptr
type PRINTER_INFO_2 as PRINTER_INFO_2A
type PPRINTER_INFO_2 as PRINTER_INFO_2A ptr
type LPPRINTER_INFO_2 as PRINTER_INFO_2A ptr
type PRINTER_INFO_4 as PRINTER_INFO_4A
type PPRINTER_INFO_4 as PRINTER_INFO_4A ptr
type LPPRINTER_INFO_4 as PRINTER_INFO_4A ptr
type PRINTER_INFO_5 as PRINTER_INFO_5A
type PPRINTER_INFO_5 as PRINTER_INFO_5A ptr
type LPPRINTER_INFO_5 as PRINTER_INFO_5A ptr
type PRINTPROCESSOR_INFO_1 as PRINTPROCESSOR_INFO_1A
type PPRINTPROCESSOR_INFO_1 as PRINTPROCESSOR_INFO_1A ptr
type LPPRINTPROCESSOR_INFO_1 as PRINTPROCESSOR_INFO_1A ptr
type FORM_INFO_1 as FORM_INFO_1A
type PFORM_INFO_1 as FORM_INFO_1A ptr
type LPFORM_INFO_1 as FORM_INFO_1A ptr
type PRINTER_DEFAULTS as PRINTER_DEFAULTSA
type PPRINTER_DEFAULTS as PRINTER_DEFAULTSA ptr
type LPPRINTER_DEFAULTS as PRINTER_DEFAULTSA ptr

#endif ''UNICODE

#endif
