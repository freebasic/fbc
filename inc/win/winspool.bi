#pragma once

#inclib "winspool"

#include once "_mingw_unicode.bi"
#include once "prsht.bi"

extern "Windows"

#define _WINSPOOL_

type _PRINTER_INFO_1A
	Flags as DWORD
	pDescription as LPSTR
	pName as LPSTR
	pComment as LPSTR
end type

type PRINTER_INFO_1A as _PRINTER_INFO_1A
type PPRINTER_INFO_1A as _PRINTER_INFO_1A ptr
type LPPRINTER_INFO_1A as _PRINTER_INFO_1A ptr

type _PRINTER_INFO_1W
	Flags as DWORD
	pDescription as LPWSTR
	pName as LPWSTR
	pComment as LPWSTR
end type

type PRINTER_INFO_1W as _PRINTER_INFO_1W
type PPRINTER_INFO_1W as _PRINTER_INFO_1W ptr
type LPPRINTER_INFO_1W as _PRINTER_INFO_1W ptr

#ifdef UNICODE
	type PRINTER_INFO_1 as PRINTER_INFO_1W
	type PPRINTER_INFO_1 as PPRINTER_INFO_1W
	type LPPRINTER_INFO_1 as LPPRINTER_INFO_1W
#else
	type PRINTER_INFO_1 as PRINTER_INFO_1A
	type PPRINTER_INFO_1 as PPRINTER_INFO_1A
	type LPPRINTER_INFO_1 as LPPRINTER_INFO_1A
#endif

type _PRINTER_INFO_2A
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

type PRINTER_INFO_2A as _PRINTER_INFO_2A
type PPRINTER_INFO_2A as _PRINTER_INFO_2A ptr
type LPPRINTER_INFO_2A as _PRINTER_INFO_2A ptr

type _PRINTER_INFO_2W
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

type PRINTER_INFO_2W as _PRINTER_INFO_2W
type PPRINTER_INFO_2W as _PRINTER_INFO_2W ptr
type LPPRINTER_INFO_2W as _PRINTER_INFO_2W ptr

#ifdef UNICODE
	type PRINTER_INFO_2 as PRINTER_INFO_2W
	type PPRINTER_INFO_2 as PPRINTER_INFO_2W
	type LPPRINTER_INFO_2 as LPPRINTER_INFO_2W
#else
	type PRINTER_INFO_2 as PRINTER_INFO_2A
	type PPRINTER_INFO_2 as PPRINTER_INFO_2A
	type LPPRINTER_INFO_2 as LPPRINTER_INFO_2A
#endif

type _PRINTER_INFO_3
	pSecurityDescriptor as PSECURITY_DESCRIPTOR
end type

type PRINTER_INFO_3 as _PRINTER_INFO_3
type PPRINTER_INFO_3 as _PRINTER_INFO_3 ptr
type LPPRINTER_INFO_3 as _PRINTER_INFO_3 ptr

type _PRINTER_INFO_4A
	pPrinterName as LPSTR
	pServerName as LPSTR
	Attributes as DWORD
end type

type PRINTER_INFO_4A as _PRINTER_INFO_4A
type PPRINTER_INFO_4A as _PRINTER_INFO_4A ptr
type LPPRINTER_INFO_4A as _PRINTER_INFO_4A ptr

type _PRINTER_INFO_4W
	pPrinterName as LPWSTR
	pServerName as LPWSTR
	Attributes as DWORD
end type

type PRINTER_INFO_4W as _PRINTER_INFO_4W
type PPRINTER_INFO_4W as _PRINTER_INFO_4W ptr
type LPPRINTER_INFO_4W as _PRINTER_INFO_4W ptr

#ifdef UNICODE
	type PRINTER_INFO_4 as PRINTER_INFO_4W
	type PPRINTER_INFO_4 as PPRINTER_INFO_4W
	type LPPRINTER_INFO_4 as LPPRINTER_INFO_4W
#else
	type PRINTER_INFO_4 as PRINTER_INFO_4A
	type PPRINTER_INFO_4 as PPRINTER_INFO_4A
	type LPPRINTER_INFO_4 as LPPRINTER_INFO_4A
#endif

type _PRINTER_INFO_5A
	pPrinterName as LPSTR
	pPortName as LPSTR
	Attributes as DWORD
	DeviceNotSelectedTimeout as DWORD
	TransmissionRetryTimeout as DWORD
end type

type PRINTER_INFO_5A as _PRINTER_INFO_5A
type PPRINTER_INFO_5A as _PRINTER_INFO_5A ptr
type LPPRINTER_INFO_5A as _PRINTER_INFO_5A ptr

type _PRINTER_INFO_5W
	pPrinterName as LPWSTR
	pPortName as LPWSTR
	Attributes as DWORD
	DeviceNotSelectedTimeout as DWORD
	TransmissionRetryTimeout as DWORD
end type

type PRINTER_INFO_5W as _PRINTER_INFO_5W
type PPRINTER_INFO_5W as _PRINTER_INFO_5W ptr
type LPPRINTER_INFO_5W as _PRINTER_INFO_5W ptr

#ifdef UNICODE
	type PRINTER_INFO_5 as PRINTER_INFO_5W
	type PPRINTER_INFO_5 as PPRINTER_INFO_5W
	type LPPRINTER_INFO_5 as LPPRINTER_INFO_5W
#else
	type PRINTER_INFO_5 as PRINTER_INFO_5A
	type PPRINTER_INFO_5 as PPRINTER_INFO_5A
	type LPPRINTER_INFO_5 as LPPRINTER_INFO_5A
#endif

type _PRINTER_INFO_6
	dwStatus as DWORD
end type

type PRINTER_INFO_6 as _PRINTER_INFO_6
type PPRINTER_INFO_6 as _PRINTER_INFO_6 ptr
type LPPRINTER_INFO_6 as _PRINTER_INFO_6 ptr

type _PRINTER_INFO_7A
	pszObjectGUID as LPSTR
	dwAction as DWORD
end type

type PRINTER_INFO_7A as _PRINTER_INFO_7A
type PPRINTER_INFO_7A as _PRINTER_INFO_7A ptr
type LPPRINTER_INFO_7A as _PRINTER_INFO_7A ptr

type _PRINTER_INFO_7W
	pszObjectGUID as LPWSTR
	dwAction as DWORD
end type

type PRINTER_INFO_7W as _PRINTER_INFO_7W
type PPRINTER_INFO_7W as _PRINTER_INFO_7W ptr
type LPPRINTER_INFO_7W as _PRINTER_INFO_7W ptr

#ifdef UNICODE
	type PRINTER_INFO_7 as PRINTER_INFO_7W
	type PPRINTER_INFO_7 as PPRINTER_INFO_7W
	type LPPRINTER_INFO_7 as LPPRINTER_INFO_7W
#else
	type PRINTER_INFO_7 as PRINTER_INFO_7A
	type PPRINTER_INFO_7 as PPRINTER_INFO_7A
	type LPPRINTER_INFO_7 as LPPRINTER_INFO_7A
#endif

#define DSPRINT_PUBLISH &h00000001
#define DSPRINT_UPDATE &h00000002
#define DSPRINT_UNPUBLISH &h00000004
#define DSPRINT_REPUBLISH &h00000008
#define DSPRINT_PENDING &h80000000

type _PRINTER_INFO_8A
	pDevMode as LPDEVMODEA
end type

type PRINTER_INFO_8A as _PRINTER_INFO_8A
type PPRINTER_INFO_8A as _PRINTER_INFO_8A ptr
type LPPRINTER_INFO_8A as _PRINTER_INFO_8A ptr

type _PRINTER_INFO_8W
	pDevMode as LPDEVMODEW
end type

type PRINTER_INFO_8W as _PRINTER_INFO_8W
type PPRINTER_INFO_8W as _PRINTER_INFO_8W ptr
type LPPRINTER_INFO_8W as _PRINTER_INFO_8W ptr

#ifdef UNICODE
	type PRINTER_INFO_8 as PRINTER_INFO_8W
	type PPRINTER_INFO_8 as PPRINTER_INFO_8W
	type LPPRINTER_INFO_8 as LPPRINTER_INFO_8W
#else
	type PRINTER_INFO_8 as PRINTER_INFO_8A
	type PPRINTER_INFO_8 as PPRINTER_INFO_8A
	type LPPRINTER_INFO_8 as LPPRINTER_INFO_8A
#endif

type _PRINTER_INFO_9A
	pDevMode as LPDEVMODEA
end type

type PRINTER_INFO_9A as _PRINTER_INFO_9A
type PPRINTER_INFO_9A as _PRINTER_INFO_9A ptr
type LPPRINTER_INFO_9A as _PRINTER_INFO_9A ptr

type _PRINTER_INFO_9W
	pDevMode as LPDEVMODEW
end type

type PRINTER_INFO_9W as _PRINTER_INFO_9W
type PPRINTER_INFO_9W as _PRINTER_INFO_9W ptr
type LPPRINTER_INFO_9W as _PRINTER_INFO_9W ptr

#ifdef UNICODE
	type PRINTER_INFO_9 as PRINTER_INFO_9W
	type PPRINTER_INFO_9 as PPRINTER_INFO_9W
	type LPPRINTER_INFO_9 as LPPRINTER_INFO_9W
#else
	type PRINTER_INFO_9 as PRINTER_INFO_9A
	type PPRINTER_INFO_9 as PPRINTER_INFO_9A
	type LPPRINTER_INFO_9 as LPPRINTER_INFO_9A
#endif

#define PRINTER_CONTROL_PAUSE 1
#define PRINTER_CONTROL_RESUME 2
#define PRINTER_CONTROL_PURGE 3
#define PRINTER_CONTROL_SET_STATUS 4
#define PRINTER_STATUS_PAUSED &h00000001
#define PRINTER_STATUS_ERROR &h00000002
#define PRINTER_STATUS_PENDING_DELETION &h00000004
#define PRINTER_STATUS_PAPER_JAM &h00000008
#define PRINTER_STATUS_PAPER_OUT &h00000010
#define PRINTER_STATUS_MANUAL_FEED &h00000020
#define PRINTER_STATUS_PAPER_PROBLEM &h00000040
#define PRINTER_STATUS_OFFLINE &h00000080
#define PRINTER_STATUS_IO_ACTIVE &h00000100
#define PRINTER_STATUS_BUSY &h00000200
#define PRINTER_STATUS_PRINTING &h00000400
#define PRINTER_STATUS_OUTPUT_BIN_FULL &h00000800
#define PRINTER_STATUS_NOT_AVAILABLE &h00001000
#define PRINTER_STATUS_WAITING &h00002000
#define PRINTER_STATUS_PROCESSING &h00004000
#define PRINTER_STATUS_INITIALIZING &h00008000
#define PRINTER_STATUS_WARMING_UP &h00010000
#define PRINTER_STATUS_TONER_LOW &h00020000
#define PRINTER_STATUS_NO_TONER &h00040000
#define PRINTER_STATUS_PAGE_PUNT &h00080000
#define PRINTER_STATUS_USER_INTERVENTION &h00100000
#define PRINTER_STATUS_OUT_OF_MEMORY &h00200000
#define PRINTER_STATUS_DOOR_OPEN &h00400000
#define PRINTER_STATUS_SERVER_UNKNOWN &h00800000
#define PRINTER_STATUS_POWER_SAVE &h01000000
#define PRINTER_ATTRIBUTE_QUEUED &h00000001
#define PRINTER_ATTRIBUTE_DIRECT &h00000002
#define PRINTER_ATTRIBUTE_DEFAULT &h00000004
#define PRINTER_ATTRIBUTE_SHARED &h00000008
#define PRINTER_ATTRIBUTE_NETWORK &h00000010
#define PRINTER_ATTRIBUTE_HIDDEN &h00000020
#define PRINTER_ATTRIBUTE_LOCAL &h00000040
#define PRINTER_ATTRIBUTE_ENABLE_DEVQ &h00000080
#define PRINTER_ATTRIBUTE_KEEPPRINTEDJOBS &h00000100
#define PRINTER_ATTRIBUTE_DO_COMPLETE_FIRST &h00000200
#define PRINTER_ATTRIBUTE_WORK_OFFLINE &h00000400
#define PRINTER_ATTRIBUTE_ENABLE_BIDI &h00000800
#define PRINTER_ATTRIBUTE_RAW_ONLY &h00001000
#define PRINTER_ATTRIBUTE_PUBLISHED &h00002000
#define PRINTER_ATTRIBUTE_FAX &h00004000
#define PRINTER_ATTRIBUTE_TS &h00008000
#define NO_PRIORITY 0
#define MAX_PRIORITY 99
#define MIN_PRIORITY 1
#define DEF_PRIORITY 1

type _JOB_INFO_1A
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

type JOB_INFO_1A as _JOB_INFO_1A
type PJOB_INFO_1A as _JOB_INFO_1A ptr
type LPJOB_INFO_1A as _JOB_INFO_1A ptr

type _JOB_INFO_1W
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

type JOB_INFO_1W as _JOB_INFO_1W
type PJOB_INFO_1W as _JOB_INFO_1W ptr
type LPJOB_INFO_1W as _JOB_INFO_1W ptr

#ifdef UNICODE
	type JOB_INFO_1 as JOB_INFO_1W
	type PJOB_INFO_1 as PJOB_INFO_1W
	type LPJOB_INFO_1 as LPJOB_INFO_1W
#else
	type JOB_INFO_1 as JOB_INFO_1A
	type PJOB_INFO_1 as PJOB_INFO_1A
	type LPJOB_INFO_1 as LPJOB_INFO_1A
#endif

type _JOB_INFO_2A
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

type JOB_INFO_2A as _JOB_INFO_2A
type PJOB_INFO_2A as _JOB_INFO_2A ptr
type LPJOB_INFO_2A as _JOB_INFO_2A ptr

type _JOB_INFO_2W
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

type JOB_INFO_2W as _JOB_INFO_2W
type PJOB_INFO_2W as _JOB_INFO_2W ptr
type LPJOB_INFO_2W as _JOB_INFO_2W ptr

#ifdef UNICODE
	type JOB_INFO_2 as JOB_INFO_2W
	type PJOB_INFO_2 as PJOB_INFO_2W
	type LPJOB_INFO_2 as LPJOB_INFO_2W
#else
	type JOB_INFO_2 as JOB_INFO_2A
	type PJOB_INFO_2 as PJOB_INFO_2A
	type LPJOB_INFO_2 as LPJOB_INFO_2A
#endif

type _JOB_INFO_3
	JobId as DWORD
	NextJobId as DWORD
	Reserved as DWORD
end type

type JOB_INFO_3 as _JOB_INFO_3
type PJOB_INFO_3 as _JOB_INFO_3 ptr
type LPJOB_INFO_3 as _JOB_INFO_3 ptr

#define JOB_CONTROL_PAUSE 1
#define JOB_CONTROL_RESUME 2
#define JOB_CONTROL_CANCEL 3
#define JOB_CONTROL_RESTART 4
#define JOB_CONTROL_DELETE 5
#define JOB_CONTROL_SENT_TO_PRINTER 6
#define JOB_CONTROL_LAST_PAGE_EJECTED 7
#define JOB_STATUS_PAUSED &h00000001
#define JOB_STATUS_ERROR &h00000002
#define JOB_STATUS_DELETING &h00000004
#define JOB_STATUS_SPOOLING &h00000008
#define JOB_STATUS_PRINTING &h00000010
#define JOB_STATUS_OFFLINE &h00000020
#define JOB_STATUS_PAPEROUT &h00000040
#define JOB_STATUS_PRINTED &h00000080
#define JOB_STATUS_DELETED &h00000100
#define JOB_STATUS_BLOCKED_DEVQ &h00000200
#define JOB_STATUS_USER_INTERVENTION &h00000400
#define JOB_STATUS_RESTART &h00000800
#define JOB_STATUS_COMPLETE &h00001000
#define JOB_POSITION_UNSPECIFIED 0

type _ADDJOB_INFO_1A
	Path as LPSTR
	JobId as DWORD
end type

type ADDJOB_INFO_1A as _ADDJOB_INFO_1A
type PADDJOB_INFO_1A as _ADDJOB_INFO_1A ptr
type LPADDJOB_INFO_1A as _ADDJOB_INFO_1A ptr

type _ADDJOB_INFO_1W
	Path as LPWSTR
	JobId as DWORD
end type

type ADDJOB_INFO_1W as _ADDJOB_INFO_1W
type PADDJOB_INFO_1W as _ADDJOB_INFO_1W ptr
type LPADDJOB_INFO_1W as _ADDJOB_INFO_1W ptr

#ifdef UNICODE
	type ADDJOB_INFO_1 as ADDJOB_INFO_1W
	type PADDJOB_INFO_1 as PADDJOB_INFO_1W
	type LPADDJOB_INFO_1 as LPADDJOB_INFO_1W
#else
	type ADDJOB_INFO_1 as ADDJOB_INFO_1A
	type PADDJOB_INFO_1 as PADDJOB_INFO_1A
	type LPADDJOB_INFO_1 as LPADDJOB_INFO_1A
#endif

type _DRIVER_INFO_1A
	pName as LPSTR
end type

type DRIVER_INFO_1A as _DRIVER_INFO_1A
type PDRIVER_INFO_1A as _DRIVER_INFO_1A ptr
type LPDRIVER_INFO_1A as _DRIVER_INFO_1A ptr

type _DRIVER_INFO_1W
	pName as LPWSTR
end type

type DRIVER_INFO_1W as _DRIVER_INFO_1W
type PDRIVER_INFO_1W as _DRIVER_INFO_1W ptr
type LPDRIVER_INFO_1W as _DRIVER_INFO_1W ptr

#ifdef UNICODE
	type DRIVER_INFO_1 as DRIVER_INFO_1W
	type PDRIVER_INFO_1 as PDRIVER_INFO_1W
	type LPDRIVER_INFO_1 as LPDRIVER_INFO_1W
#else
	type DRIVER_INFO_1 as DRIVER_INFO_1A
	type PDRIVER_INFO_1 as PDRIVER_INFO_1A
	type LPDRIVER_INFO_1 as LPDRIVER_INFO_1A
#endif

type _DRIVER_INFO_2A
	cVersion as DWORD
	pName as LPSTR
	pEnvironment as LPSTR
	pDriverPath as LPSTR
	pDataFile as LPSTR
	pConfigFile as LPSTR
end type

type DRIVER_INFO_2A as _DRIVER_INFO_2A
type PDRIVER_INFO_2A as _DRIVER_INFO_2A ptr
type LPDRIVER_INFO_2A as _DRIVER_INFO_2A ptr

type _DRIVER_INFO_2W
	cVersion as DWORD
	pName as LPWSTR
	pEnvironment as LPWSTR
	pDriverPath as LPWSTR
	pDataFile as LPWSTR
	pConfigFile as LPWSTR
end type

type DRIVER_INFO_2W as _DRIVER_INFO_2W
type PDRIVER_INFO_2W as _DRIVER_INFO_2W ptr
type LPDRIVER_INFO_2W as _DRIVER_INFO_2W ptr

#ifdef UNICODE
	type DRIVER_INFO_2 as DRIVER_INFO_2W
	type PDRIVER_INFO_2 as PDRIVER_INFO_2W
	type LPDRIVER_INFO_2 as LPDRIVER_INFO_2W
#else
	type DRIVER_INFO_2 as DRIVER_INFO_2A
	type PDRIVER_INFO_2 as PDRIVER_INFO_2A
	type LPDRIVER_INFO_2 as LPDRIVER_INFO_2A
#endif

type _DRIVER_INFO_3A
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

type DRIVER_INFO_3A as _DRIVER_INFO_3A
type PDRIVER_INFO_3A as _DRIVER_INFO_3A ptr
type LPDRIVER_INFO_3A as _DRIVER_INFO_3A ptr

type _DRIVER_INFO_3W
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

type DRIVER_INFO_3W as _DRIVER_INFO_3W
type PDRIVER_INFO_3W as _DRIVER_INFO_3W ptr
type LPDRIVER_INFO_3W as _DRIVER_INFO_3W ptr

#ifdef UNICODE
	type DRIVER_INFO_3 as DRIVER_INFO_3W
	type PDRIVER_INFO_3 as PDRIVER_INFO_3W
	type LPDRIVER_INFO_3 as LPDRIVER_INFO_3W
#else
	type DRIVER_INFO_3 as DRIVER_INFO_3A
	type PDRIVER_INFO_3 as PDRIVER_INFO_3A
	type LPDRIVER_INFO_3 as LPDRIVER_INFO_3A
#endif

type _DRIVER_INFO_4A
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
	pszzPreviousNames as LPSTR
end type

type DRIVER_INFO_4A as _DRIVER_INFO_4A
type PDRIVER_INFO_4A as _DRIVER_INFO_4A ptr
type LPDRIVER_INFO_4A as _DRIVER_INFO_4A ptr

type _DRIVER_INFO_4W
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
	pszzPreviousNames as LPWSTR
end type

type DRIVER_INFO_4W as _DRIVER_INFO_4W
type PDRIVER_INFO_4W as _DRIVER_INFO_4W ptr
type LPDRIVER_INFO_4W as _DRIVER_INFO_4W ptr

#ifdef UNICODE
	type DRIVER_INFO_4 as DRIVER_INFO_4W
	type PDRIVER_INFO_4 as PDRIVER_INFO_4W
	type LPDRIVER_INFO_4 as LPDRIVER_INFO_4W
#else
	type DRIVER_INFO_4 as DRIVER_INFO_4A
	type PDRIVER_INFO_4 as PDRIVER_INFO_4A
	type LPDRIVER_INFO_4 as LPDRIVER_INFO_4A
#endif

type _DRIVER_INFO_5A
	cVersion as DWORD
	pName as LPSTR
	pEnvironment as LPSTR
	pDriverPath as LPSTR
	pDataFile as LPSTR
	pConfigFile as LPSTR
	dwDriverAttributes as DWORD
	dwConfigVersion as DWORD
	dwDriverVersion as DWORD
end type

type DRIVER_INFO_5A as _DRIVER_INFO_5A
type PDRIVER_INFO_5A as _DRIVER_INFO_5A ptr
type LPDRIVER_INFO_5A as _DRIVER_INFO_5A ptr

type _DRIVER_INFO_5W
	cVersion as DWORD
	pName as LPWSTR
	pEnvironment as LPWSTR
	pDriverPath as LPWSTR
	pDataFile as LPWSTR
	pConfigFile as LPWSTR
	dwDriverAttributes as DWORD
	dwConfigVersion as DWORD
	dwDriverVersion as DWORD
end type

type DRIVER_INFO_5W as _DRIVER_INFO_5W
type PDRIVER_INFO_5W as _DRIVER_INFO_5W ptr
type LPDRIVER_INFO_5W as _DRIVER_INFO_5W ptr

#ifdef UNICODE
	type DRIVER_INFO_5 as DRIVER_INFO_5W
	type PDRIVER_INFO_5 as PDRIVER_INFO_5W
	type LPDRIVER_INFO_5 as LPDRIVER_INFO_5W
#else
	type DRIVER_INFO_5 as DRIVER_INFO_5A
	type PDRIVER_INFO_5 as PDRIVER_INFO_5A
	type LPDRIVER_INFO_5 as LPDRIVER_INFO_5A
#endif

type _DRIVER_INFO_6A
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
	pszzPreviousNames as LPSTR
	ftDriverDate as FILETIME
	dwlDriverVersion as DWORDLONG
	pszMfgName as LPSTR
	pszOEMUrl as LPSTR
	pszHardwareID as LPSTR
	pszProvider as LPSTR
end type

type DRIVER_INFO_6A as _DRIVER_INFO_6A
type PDRIVER_INFO_6A as _DRIVER_INFO_6A ptr
type LPDRIVER_INFO_6A as _DRIVER_INFO_6A ptr

type _DRIVER_INFO_6W
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
	pszzPreviousNames as LPWSTR
	ftDriverDate as FILETIME
	dwlDriverVersion as DWORDLONG
	pszMfgName as LPWSTR
	pszOEMUrl as LPWSTR
	pszHardwareID as LPWSTR
	pszProvider as LPWSTR
end type

type DRIVER_INFO_6W as _DRIVER_INFO_6W
type PDRIVER_INFO_6W as _DRIVER_INFO_6W ptr
type LPDRIVER_INFO_6W as _DRIVER_INFO_6W ptr

#ifdef UNICODE
	type DRIVER_INFO_6 as DRIVER_INFO_6W
	type PDRIVER_INFO_6 as PDRIVER_INFO_6W
	type LPDRIVER_INFO_6 as LPDRIVER_INFO_6W
#else
	type DRIVER_INFO_6 as DRIVER_INFO_6A
	type PDRIVER_INFO_6 as PDRIVER_INFO_6A
	type LPDRIVER_INFO_6 as LPDRIVER_INFO_6A
#endif

#define DRIVER_KERNELMODE &h00000001
#define DRIVER_USERMODE &h00000002
#define DPD_DELETE_UNUSED_FILES &h00000001
#define DPD_DELETE_SPECIFIC_VERSION &h00000002
#define DPD_DELETE_ALL_FILES &h00000004
#define APD_STRICT_UPGRADE &h00000001
#define APD_STRICT_DOWNGRADE &h00000002
#define APD_COPY_ALL_FILES &h00000004
#define APD_COPY_NEW_FILES &h00000008
#define APD_COPY_FROM_DIRECTORY &h00000010

type _DOC_INFO_1A
	pDocName as LPSTR
	pOutputFile as LPSTR
	pDatatype as LPSTR
end type

type DOC_INFO_1A as _DOC_INFO_1A
type PDOC_INFO_1A as _DOC_INFO_1A ptr
type LPDOC_INFO_1A as _DOC_INFO_1A ptr

type _DOC_INFO_1W
	pDocName as LPWSTR
	pOutputFile as LPWSTR
	pDatatype as LPWSTR
end type

type DOC_INFO_1W as _DOC_INFO_1W
type PDOC_INFO_1W as _DOC_INFO_1W ptr
type LPDOC_INFO_1W as _DOC_INFO_1W ptr

#ifdef UNICODE
	type DOC_INFO_1 as DOC_INFO_1W
	type PDOC_INFO_1 as PDOC_INFO_1W
	type LPDOC_INFO_1 as LPDOC_INFO_1W
#else
	type DOC_INFO_1 as DOC_INFO_1A
	type PDOC_INFO_1 as PDOC_INFO_1A
	type LPDOC_INFO_1 as LPDOC_INFO_1A
#endif

type _FORM_INFO_1A
	Flags as DWORD
	pName as LPSTR
	Size as SIZEL
	ImageableArea as RECTL
end type

type FORM_INFO_1A as _FORM_INFO_1A
type PFORM_INFO_1A as _FORM_INFO_1A ptr
type LPFORM_INFO_1A as _FORM_INFO_1A ptr

type _FORM_INFO_1W
	Flags as DWORD
	pName as LPWSTR
	Size as SIZEL
	ImageableArea as RECTL
end type

type FORM_INFO_1W as _FORM_INFO_1W
type PFORM_INFO_1W as _FORM_INFO_1W ptr
type LPFORM_INFO_1W as _FORM_INFO_1W ptr

#ifdef UNICODE
	type FORM_INFO_1 as FORM_INFO_1W
	type PFORM_INFO_1 as PFORM_INFO_1W
	type LPFORM_INFO_1 as LPFORM_INFO_1W
#else
	type FORM_INFO_1 as FORM_INFO_1A
	type PFORM_INFO_1 as PFORM_INFO_1A
	type LPFORM_INFO_1 as LPFORM_INFO_1A
#endif

type _DOC_INFO_2A
	pDocName as LPSTR
	pOutputFile as LPSTR
	pDatatype as LPSTR
	dwMode as DWORD
	JobId as DWORD
end type

type DOC_INFO_2A as _DOC_INFO_2A
type PDOC_INFO_2A as _DOC_INFO_2A ptr
type LPDOC_INFO_2A as _DOC_INFO_2A ptr

type _DOC_INFO_2W
	pDocName as LPWSTR
	pOutputFile as LPWSTR
	pDatatype as LPWSTR
	dwMode as DWORD
	JobId as DWORD
end type

type DOC_INFO_2W as _DOC_INFO_2W
type PDOC_INFO_2W as _DOC_INFO_2W ptr
type LPDOC_INFO_2W as _DOC_INFO_2W ptr

#ifdef UNICODE
	type DOC_INFO_2 as DOC_INFO_2W
	type PDOC_INFO_2 as PDOC_INFO_2W
	type LPDOC_INFO_2 as LPDOC_INFO_2W
#else
	type DOC_INFO_2 as DOC_INFO_2A
	type PDOC_INFO_2 as PDOC_INFO_2A
	type LPDOC_INFO_2 as LPDOC_INFO_2A
#endif

#define DI_CHANNEL 1
#define DI_READ_SPOOL_JOB 3

type _DOC_INFO_3A
	pDocName as LPSTR
	pOutputFile as LPSTR
	pDatatype as LPSTR
	dwFlags as DWORD
end type

type DOC_INFO_3A as _DOC_INFO_3A
type PDOC_INFO_3A as _DOC_INFO_3A ptr
type LPDOC_INFO_3A as _DOC_INFO_3A ptr

type _DOC_INFO_3W
	pDocName as LPWSTR
	pOutputFile as LPWSTR
	pDatatype as LPWSTR
	dwFlags as DWORD
end type

type DOC_INFO_3W as _DOC_INFO_3W
type PDOC_INFO_3W as _DOC_INFO_3W ptr
type LPDOC_INFO_3W as _DOC_INFO_3W ptr

#ifdef UNICODE
	type DOC_INFO_3 as DOC_INFO_3W
	type PDOC_INFO_3 as PDOC_INFO_3W
	type LPDOC_INFO_3 as LPDOC_INFO_3W
#else
	type DOC_INFO_3 as DOC_INFO_3A
	type PDOC_INFO_3 as PDOC_INFO_3A
	type LPDOC_INFO_3 as LPDOC_INFO_3A
#endif

#define DI_MEMORYMAP_WRITE &h00000001
#define FORM_USER &h00000000
#define FORM_BUILTIN &h00000001
#define FORM_PRINTER &h00000002

type _PRINTPROCESSOR_INFO_1A
	pName as LPSTR
end type

type PRINTPROCESSOR_INFO_1A as _PRINTPROCESSOR_INFO_1A
type PPRINTPROCESSOR_INFO_1A as _PRINTPROCESSOR_INFO_1A ptr
type LPPRINTPROCESSOR_INFO_1A as _PRINTPROCESSOR_INFO_1A ptr

type _PRINTPROCESSOR_INFO_1W
	pName as LPWSTR
end type

type PRINTPROCESSOR_INFO_1W as _PRINTPROCESSOR_INFO_1W
type PPRINTPROCESSOR_INFO_1W as _PRINTPROCESSOR_INFO_1W ptr
type LPPRINTPROCESSOR_INFO_1W as _PRINTPROCESSOR_INFO_1W ptr

#ifdef UNICODE
	type PRINTPROCESSOR_INFO_1 as PRINTPROCESSOR_INFO_1W
	type PPRINTPROCESSOR_INFO_1 as PPRINTPROCESSOR_INFO_1W
	type LPPRINTPROCESSOR_INFO_1 as LPPRINTPROCESSOR_INFO_1W
#else
	type PRINTPROCESSOR_INFO_1 as PRINTPROCESSOR_INFO_1A
	type PPRINTPROCESSOR_INFO_1 as PPRINTPROCESSOR_INFO_1A
	type LPPRINTPROCESSOR_INFO_1 as LPPRINTPROCESSOR_INFO_1A
#endif

type _PRINTPROCESSOR_CAPS_1
	dwLevel as DWORD
	dwNupOptions as DWORD
	dwPageOrderFlags as DWORD
	dwNumberOfCopies as DWORD
end type

type PRINTPROCESSOR_CAPS_1 as _PRINTPROCESSOR_CAPS_1
type PPRINTPROCESSOR_CAPS_1 as _PRINTPROCESSOR_CAPS_1 ptr
#define NORMAL_PRINT &h00000000
#define REVERSE_PRINT &h00000001

type _PORT_INFO_1A
	pName as LPSTR
end type

type PORT_INFO_1A as _PORT_INFO_1A
type PPORT_INFO_1A as _PORT_INFO_1A ptr
type LPPORT_INFO_1A as _PORT_INFO_1A ptr

type _PORT_INFO_1W
	pName as LPWSTR
end type

type PORT_INFO_1W as _PORT_INFO_1W
type PPORT_INFO_1W as _PORT_INFO_1W ptr
type LPPORT_INFO_1W as _PORT_INFO_1W ptr

#ifdef UNICODE
	type PORT_INFO_1 as PORT_INFO_1W
	type PPORT_INFO_1 as PPORT_INFO_1W
	type LPPORT_INFO_1 as LPPORT_INFO_1W
#else
	type PORT_INFO_1 as PORT_INFO_1A
	type PPORT_INFO_1 as PPORT_INFO_1A
	type LPPORT_INFO_1 as LPPORT_INFO_1A
#endif

type _PORT_INFO_2A
	pPortName as LPSTR
	pMonitorName as LPSTR
	pDescription as LPSTR
	fPortType as DWORD
	Reserved as DWORD
end type

type PORT_INFO_2A as _PORT_INFO_2A
type PPORT_INFO_2A as _PORT_INFO_2A ptr
type LPPORT_INFO_2A as _PORT_INFO_2A ptr

type _PORT_INFO_2W
	pPortName as LPWSTR
	pMonitorName as LPWSTR
	pDescription as LPWSTR
	fPortType as DWORD
	Reserved as DWORD
end type

type PORT_INFO_2W as _PORT_INFO_2W
type PPORT_INFO_2W as _PORT_INFO_2W ptr
type LPPORT_INFO_2W as _PORT_INFO_2W ptr

#ifdef UNICODE
	type PORT_INFO_2 as PORT_INFO_2W
	type PPORT_INFO_2 as PPORT_INFO_2W
	type LPPORT_INFO_2 as LPPORT_INFO_2W
#else
	type PORT_INFO_2 as PORT_INFO_2A
	type PPORT_INFO_2 as PPORT_INFO_2A
	type LPPORT_INFO_2 as LPPORT_INFO_2A
#endif

#define PORT_TYPE_WRITE &h0001
#define PORT_TYPE_READ &h0002
#define PORT_TYPE_REDIRECTED &h0004
#define PORT_TYPE_NET_ATTACHED &h0008

type _PORT_INFO_3A
	dwStatus as DWORD
	pszStatus as LPSTR
	dwSeverity as DWORD
end type

type PORT_INFO_3A as _PORT_INFO_3A
type PPORT_INFO_3A as _PORT_INFO_3A ptr
type LPPORT_INFO_3A as _PORT_INFO_3A ptr

type _PORT_INFO_3W
	dwStatus as DWORD
	pszStatus as LPWSTR
	dwSeverity as DWORD
end type

type PORT_INFO_3W as _PORT_INFO_3W
type PPORT_INFO_3W as _PORT_INFO_3W ptr
type LPPORT_INFO_3W as _PORT_INFO_3W ptr

#ifdef UNICODE
	type PORT_INFO_3 as PORT_INFO_3W
	type PPORT_INFO_3 as PPORT_INFO_3W
	type LPPORT_INFO_3 as LPPORT_INFO_3W
#else
	type PORT_INFO_3 as PORT_INFO_3A
	type PPORT_INFO_3 as PPORT_INFO_3A
	type LPPORT_INFO_3 as LPPORT_INFO_3A
#endif

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

type _MONITOR_INFO_1A
	pName as LPSTR
end type

type MONITOR_INFO_1A as _MONITOR_INFO_1A
type PMONITOR_INFO_1A as _MONITOR_INFO_1A ptr
type LPMONITOR_INFO_1A as _MONITOR_INFO_1A ptr

type _MONITOR_INFO_1W
	pName as LPWSTR
end type

type MONITOR_INFO_1W as _MONITOR_INFO_1W
type PMONITOR_INFO_1W as _MONITOR_INFO_1W ptr
type LPMONITOR_INFO_1W as _MONITOR_INFO_1W ptr

#ifdef UNICODE
	type MONITOR_INFO_1 as MONITOR_INFO_1W
	type PMONITOR_INFO_1 as PMONITOR_INFO_1W
	type LPMONITOR_INFO_1 as LPMONITOR_INFO_1W
#else
	type MONITOR_INFO_1 as MONITOR_INFO_1A
	type PMONITOR_INFO_1 as PMONITOR_INFO_1A
	type LPMONITOR_INFO_1 as LPMONITOR_INFO_1A
#endif

type _MONITOR_INFO_2A
	pName as LPSTR
	pEnvironment as LPSTR
	pDLLName as LPSTR
end type

type MONITOR_INFO_2A as _MONITOR_INFO_2A
type PMONITOR_INFO_2A as _MONITOR_INFO_2A ptr
type LPMONITOR_INFO_2A as _MONITOR_INFO_2A ptr

type _MONITOR_INFO_2W
	pName as LPWSTR
	pEnvironment as LPWSTR
	pDLLName as LPWSTR
end type

type MONITOR_INFO_2W as _MONITOR_INFO_2W
type PMONITOR_INFO_2W as _MONITOR_INFO_2W ptr
type LPMONITOR_INFO_2W as _MONITOR_INFO_2W ptr

#ifdef UNICODE
	type MONITOR_INFO_2 as MONITOR_INFO_2W
	type PMONITOR_INFO_2 as PMONITOR_INFO_2W
	type LPMONITOR_INFO_2 as LPMONITOR_INFO_2W
#else
	type MONITOR_INFO_2 as MONITOR_INFO_2A
	type PMONITOR_INFO_2 as PMONITOR_INFO_2A
	type LPMONITOR_INFO_2 as LPMONITOR_INFO_2A
#endif

type _DATATYPES_INFO_1A
	pName as LPSTR
end type

type DATATYPES_INFO_1A as _DATATYPES_INFO_1A
type PDATATYPES_INFO_1A as _DATATYPES_INFO_1A ptr
type LPDATATYPES_INFO_1A as _DATATYPES_INFO_1A ptr

type _DATATYPES_INFO_1W
	pName as LPWSTR
end type

type DATATYPES_INFO_1W as _DATATYPES_INFO_1W
type PDATATYPES_INFO_1W as _DATATYPES_INFO_1W ptr
type LPDATATYPES_INFO_1W as _DATATYPES_INFO_1W ptr

#ifdef UNICODE
	type DATATYPES_INFO_1 as DATATYPES_INFO_1W
	type PDATATYPES_INFO_1 as PDATATYPES_INFO_1W
	type LPDATATYPES_INFO_1 as LPDATATYPES_INFO_1W
#else
	type DATATYPES_INFO_1 as DATATYPES_INFO_1A
	type PDATATYPES_INFO_1 as PDATATYPES_INFO_1A
	type LPDATATYPES_INFO_1 as LPDATATYPES_INFO_1A
#endif

type _PRINTER_DEFAULTSA
	pDatatype as LPSTR
	pDevMode as LPDEVMODEA
	DesiredAccess as ACCESS_MASK
end type

type PRINTER_DEFAULTSA as _PRINTER_DEFAULTSA
type PPRINTER_DEFAULTSA as _PRINTER_DEFAULTSA ptr
type LPPRINTER_DEFAULTSA as _PRINTER_DEFAULTSA ptr

type _PRINTER_DEFAULTSW
	pDatatype as LPWSTR
	pDevMode as LPDEVMODEW
	DesiredAccess as ACCESS_MASK
end type

type PRINTER_DEFAULTSW as _PRINTER_DEFAULTSW
type PPRINTER_DEFAULTSW as _PRINTER_DEFAULTSW ptr
type LPPRINTER_DEFAULTSW as _PRINTER_DEFAULTSW ptr

#ifdef UNICODE
	type PRINTER_DEFAULTS as PRINTER_DEFAULTSW
	type PPRINTER_DEFAULTS as PPRINTER_DEFAULTSW
	type LPPRINTER_DEFAULTS as LPPRINTER_DEFAULTSW
#else
	type PRINTER_DEFAULTS as PRINTER_DEFAULTSA
	type PPRINTER_DEFAULTS as PPRINTER_DEFAULTSA
	type LPPRINTER_DEFAULTS as LPPRINTER_DEFAULTSA
#endif

type _PRINTER_ENUM_VALUESA
	pValueName as LPSTR
	cbValueName as DWORD
	dwType as DWORD
	pData as LPBYTE
	cbData as DWORD
end type

type PRINTER_ENUM_VALUESA as _PRINTER_ENUM_VALUESA
type PPRINTER_ENUM_VALUESA as _PRINTER_ENUM_VALUESA ptr
type LPPRINTER_ENUM_VALUESA as _PRINTER_ENUM_VALUESA ptr

type _PRINTER_ENUM_VALUESW
	pValueName as LPWSTR
	cbValueName as DWORD
	dwType as DWORD
	pData as LPBYTE
	cbData as DWORD
end type

type PRINTER_ENUM_VALUESW as _PRINTER_ENUM_VALUESW
type PPRINTER_ENUM_VALUESW as _PRINTER_ENUM_VALUESW ptr
type LPPRINTER_ENUM_VALUESW as _PRINTER_ENUM_VALUESW ptr

#ifdef UNICODE
	type PRINTER_ENUM_VALUES as PRINTER_ENUM_VALUESW
	type PPRINTER_ENUM_VALUES as PPRINTER_ENUM_VALUESW
	type LPPRINTER_ENUM_VALUES as LPPRINTER_ENUM_VALUESW
	#define EnumPrinters EnumPrintersW
#else
	type PRINTER_ENUM_VALUES as PRINTER_ENUM_VALUESA
	type PPRINTER_ENUM_VALUES as PPRINTER_ENUM_VALUESA
	type LPPRINTER_ENUM_VALUES as LPPRINTER_ENUM_VALUESA
	#define EnumPrinters EnumPrintersA
#endif

declare function EnumPrintersA(byval Flags as DWORD, byval Name as LPSTR, byval Level as DWORD, byval pPrinterEnum as LPBYTE, byval cbBuf as DWORD, byval pcbNeeded as LPDWORD, byval pcReturned as LPDWORD) as WINBOOL
declare function EnumPrintersW(byval Flags as DWORD, byval Name as LPWSTR, byval Level as DWORD, byval pPrinterEnum as LPBYTE, byval cbBuf as DWORD, byval pcbNeeded as LPDWORD, byval pcReturned as LPDWORD) as WINBOOL
#define PRINTER_ENUM_DEFAULT &h00000001
#define PRINTER_ENUM_LOCAL &h00000002
#define PRINTER_ENUM_CONNECTIONS &h00000004
#define PRINTER_ENUM_FAVORITE &h00000004
#define PRINTER_ENUM_NAME &h00000008
#define PRINTER_ENUM_REMOTE &h00000010
#define PRINTER_ENUM_SHARED &h00000020
#define PRINTER_ENUM_NETWORK &h00000040
#define PRINTER_ENUM_EXPAND &h00004000
#define PRINTER_ENUM_CONTAINER &h00008000
#define PRINTER_ENUM_ICONMASK &h00ff0000
#define PRINTER_ENUM_ICON1 &h00010000
#define PRINTER_ENUM_ICON2 &h00020000
#define PRINTER_ENUM_ICON3 &h00040000
#define PRINTER_ENUM_ICON4 &h00080000
#define PRINTER_ENUM_ICON5 &h00100000
#define PRINTER_ENUM_ICON6 &h00200000
#define PRINTER_ENUM_ICON7 &h00400000
#define PRINTER_ENUM_ICON8 &h00800000
#define PRINTER_ENUM_HIDE &h01000000
#define SPOOL_FILE_PERSISTENT &h00000001
#define SPOOL_FILE_TEMPORARY &h00000002

#ifdef UNICODE
	#define OpenPrinter OpenPrinterW
	#define ResetPrinter ResetPrinterW
	#define SetJob SetJobW
	#define GetJob GetJobW
	#define EnumJobs EnumJobsW
	#define AddPrinter AddPrinterW
	#define SetPrinter SetPrinterW
	#define GetPrinter GetPrinterW
	#define AddPrinterDriver AddPrinterDriverW
	#define AddPrinterDriverEx AddPrinterDriverExW
	#define EnumPrinterDrivers EnumPrinterDriversW
	#define GetPrinterDriver GetPrinterDriverW
	#define GetPrinterDriverDirectory GetPrinterDriverDirectoryW
	#define DeletePrinterDriver DeletePrinterDriverW
	#define DeletePrinterDriverEx DeletePrinterDriverExW
	#define AddPrintProcessor AddPrintProcessorW
	#define EnumPrintProcessors EnumPrintProcessorsW
	#define GetPrintProcessorDirectory GetPrintProcessorDirectoryW
	#define EnumPrintProcessorDatatypes EnumPrintProcessorDatatypesW
	#define DeletePrintProcessor DeletePrintProcessorW
	#define StartDocPrinter StartDocPrinterW
	#define AddJob AddJobW
	#define DocumentProperties DocumentPropertiesW
	#define AdvancedDocumentProperties AdvancedDocumentPropertiesW
	#define GetPrinterData GetPrinterDataW
	#define GetPrinterDataEx GetPrinterDataExW
	#define EnumPrinterData EnumPrinterDataW
	#define EnumPrinterDataEx EnumPrinterDataExW
	#define EnumPrinterKey EnumPrinterKeyW
	#define SetPrinterData SetPrinterDataW
	#define SetPrinterDataEx SetPrinterDataExW
	#define DeletePrinterData DeletePrinterDataW
	#define DeletePrinterDataEx DeletePrinterDataExW
	#define DeletePrinterKey DeletePrinterKeyW
#else
	#define OpenPrinter OpenPrinterA
	#define ResetPrinter ResetPrinterA
	#define SetJob SetJobA
	#define GetJob GetJobA
	#define EnumJobs EnumJobsA
	#define AddPrinter AddPrinterA
	#define SetPrinter SetPrinterA
	#define GetPrinter GetPrinterA
	#define AddPrinterDriver AddPrinterDriverA
	#define AddPrinterDriverEx AddPrinterDriverExA
	#define EnumPrinterDrivers EnumPrinterDriversA
	#define GetPrinterDriver GetPrinterDriverA
	#define GetPrinterDriverDirectory GetPrinterDriverDirectoryA
	#define DeletePrinterDriver DeletePrinterDriverA
	#define DeletePrinterDriverEx DeletePrinterDriverExA
	#define AddPrintProcessor AddPrintProcessorA
	#define EnumPrintProcessors EnumPrintProcessorsA
	#define GetPrintProcessorDirectory GetPrintProcessorDirectoryA
	#define EnumPrintProcessorDatatypes EnumPrintProcessorDatatypesA
	#define DeletePrintProcessor DeletePrintProcessorA
	#define StartDocPrinter StartDocPrinterA
	#define AddJob AddJobA
	#define DocumentProperties DocumentPropertiesA
	#define AdvancedDocumentProperties AdvancedDocumentPropertiesA
	#define GetPrinterData GetPrinterDataA
	#define GetPrinterDataEx GetPrinterDataExA
	#define EnumPrinterData EnumPrinterDataA
	#define EnumPrinterDataEx EnumPrinterDataExA
	#define EnumPrinterKey EnumPrinterKeyA
	#define SetPrinterData SetPrinterDataA
	#define SetPrinterDataEx SetPrinterDataExA
	#define DeletePrinterData DeletePrinterDataA
	#define DeletePrinterDataEx DeletePrinterDataExA
	#define DeletePrinterKey DeletePrinterKeyA
#endif

declare function OpenPrinterA(byval pPrinterName as LPSTR, byval phPrinter as LPHANDLE, byval pDefault as LPPRINTER_DEFAULTSA) as WINBOOL
declare function OpenPrinterW(byval pPrinterName as LPWSTR, byval phPrinter as LPHANDLE, byval pDefault as LPPRINTER_DEFAULTSW) as WINBOOL
declare function ResetPrinterA(byval hPrinter as HANDLE, byval pDefault as LPPRINTER_DEFAULTSA) as WINBOOL
declare function ResetPrinterW(byval hPrinter as HANDLE, byval pDefault as LPPRINTER_DEFAULTSW) as WINBOOL
declare function SetJobA(byval hPrinter as HANDLE, byval JobId as DWORD, byval Level as DWORD, byval pJob as LPBYTE, byval Command as DWORD) as WINBOOL
declare function SetJobW(byval hPrinter as HANDLE, byval JobId as DWORD, byval Level as DWORD, byval pJob as LPBYTE, byval Command as DWORD) as WINBOOL
declare function GetJobA(byval hPrinter as HANDLE, byval JobId as DWORD, byval Level as DWORD, byval pJob as LPBYTE, byval cbBuf as DWORD, byval pcbNeeded as LPDWORD) as WINBOOL
declare function GetJobW(byval hPrinter as HANDLE, byval JobId as DWORD, byval Level as DWORD, byval pJob as LPBYTE, byval cbBuf as DWORD, byval pcbNeeded as LPDWORD) as WINBOOL
declare function EnumJobsA(byval hPrinter as HANDLE, byval FirstJob as DWORD, byval NoJobs as DWORD, byval Level as DWORD, byval pJob as LPBYTE, byval cbBuf as DWORD, byval pcbNeeded as LPDWORD, byval pcReturned as LPDWORD) as WINBOOL
declare function EnumJobsW(byval hPrinter as HANDLE, byval FirstJob as DWORD, byval NoJobs as DWORD, byval Level as DWORD, byval pJob as LPBYTE, byval cbBuf as DWORD, byval pcbNeeded as LPDWORD, byval pcReturned as LPDWORD) as WINBOOL
declare function AddPrinterA(byval pName as LPSTR, byval Level as DWORD, byval pPrinter as LPBYTE) as HANDLE
declare function AddPrinterW(byval pName as LPWSTR, byval Level as DWORD, byval pPrinter as LPBYTE) as HANDLE
declare function DeletePrinter(byval hPrinter as HANDLE) as WINBOOL
declare function SetPrinterA(byval hPrinter as HANDLE, byval Level as DWORD, byval pPrinter as LPBYTE, byval Command as DWORD) as WINBOOL
declare function SetPrinterW(byval hPrinter as HANDLE, byval Level as DWORD, byval pPrinter as LPBYTE, byval Command as DWORD) as WINBOOL
declare function GetPrinterA(byval hPrinter as HANDLE, byval Level as DWORD, byval pPrinter as LPBYTE, byval cbBuf as DWORD, byval pcbNeeded as LPDWORD) as WINBOOL
declare function GetPrinterW(byval hPrinter as HANDLE, byval Level as DWORD, byval pPrinter as LPBYTE, byval cbBuf as DWORD, byval pcbNeeded as LPDWORD) as WINBOOL
declare function AddPrinterDriverA(byval pName as LPSTR, byval Level as DWORD, byval pDriverInfo as LPBYTE) as WINBOOL
declare function AddPrinterDriverW(byval pName as LPWSTR, byval Level as DWORD, byval pDriverInfo as LPBYTE) as WINBOOL
declare function AddPrinterDriverExA(byval pName as LPSTR, byval Level as DWORD, byval pDriverInfo as LPBYTE, byval dwFileCopyFlags as DWORD) as WINBOOL
declare function AddPrinterDriverExW(byval pName as LPWSTR, byval Level as DWORD, byval pDriverInfo as LPBYTE, byval dwFileCopyFlags as DWORD) as WINBOOL
declare function EnumPrinterDriversA(byval pName as LPSTR, byval pEnvironment as LPSTR, byval Level as DWORD, byval pDriverInfo as LPBYTE, byval cbBuf as DWORD, byval pcbNeeded as LPDWORD, byval pcReturned as LPDWORD) as WINBOOL
declare function EnumPrinterDriversW(byval pName as LPWSTR, byval pEnvironment as LPWSTR, byval Level as DWORD, byval pDriverInfo as LPBYTE, byval cbBuf as DWORD, byval pcbNeeded as LPDWORD, byval pcReturned as LPDWORD) as WINBOOL
declare function GetPrinterDriverA(byval hPrinter as HANDLE, byval pEnvironment as LPSTR, byval Level as DWORD, byval pDriverInfo as LPBYTE, byval cbBuf as DWORD, byval pcbNeeded as LPDWORD) as WINBOOL
declare function GetPrinterDriverW(byval hPrinter as HANDLE, byval pEnvironment as LPWSTR, byval Level as DWORD, byval pDriverInfo as LPBYTE, byval cbBuf as DWORD, byval pcbNeeded as LPDWORD) as WINBOOL
declare function GetPrinterDriverDirectoryA(byval pName as LPSTR, byval pEnvironment as LPSTR, byval Level as DWORD, byval pDriverDirectory as LPBYTE, byval cbBuf as DWORD, byval pcbNeeded as LPDWORD) as WINBOOL
declare function GetPrinterDriverDirectoryW(byval pName as LPWSTR, byval pEnvironment as LPWSTR, byval Level as DWORD, byval pDriverDirectory as LPBYTE, byval cbBuf as DWORD, byval pcbNeeded as LPDWORD) as WINBOOL
declare function DeletePrinterDriverA(byval pName as LPSTR, byval pEnvironment as LPSTR, byval pDriverName as LPSTR) as WINBOOL
declare function DeletePrinterDriverW(byval pName as LPWSTR, byval pEnvironment as LPWSTR, byval pDriverName as LPWSTR) as WINBOOL
declare function DeletePrinterDriverExA(byval pName as LPSTR, byval pEnvironment as LPSTR, byval pDriverName as LPSTR, byval dwDeleteFlag as DWORD, byval dwVersionFlag as DWORD) as WINBOOL
declare function DeletePrinterDriverExW(byval pName as LPWSTR, byval pEnvironment as LPWSTR, byval pDriverName as LPWSTR, byval dwDeleteFlag as DWORD, byval dwVersionFlag as DWORD) as WINBOOL
declare function AddPrintProcessorA(byval pName as LPSTR, byval pEnvironment as LPSTR, byval pPathName as LPSTR, byval pPrintProcessorName as LPSTR) as WINBOOL
declare function AddPrintProcessorW(byval pName as LPWSTR, byval pEnvironment as LPWSTR, byval pPathName as LPWSTR, byval pPrintProcessorName as LPWSTR) as WINBOOL
declare function EnumPrintProcessorsA(byval pName as LPSTR, byval pEnvironment as LPSTR, byval Level as DWORD, byval pPrintProcessorInfo as LPBYTE, byval cbBuf as DWORD, byval pcbNeeded as LPDWORD, byval pcReturned as LPDWORD) as WINBOOL
declare function EnumPrintProcessorsW(byval pName as LPWSTR, byval pEnvironment as LPWSTR, byval Level as DWORD, byval pPrintProcessorInfo as LPBYTE, byval cbBuf as DWORD, byval pcbNeeded as LPDWORD, byval pcReturned as LPDWORD) as WINBOOL
declare function GetPrintProcessorDirectoryA(byval pName as LPSTR, byval pEnvironment as LPSTR, byval Level as DWORD, byval pPrintProcessorInfo as LPBYTE, byval cbBuf as DWORD, byval pcbNeeded as LPDWORD) as WINBOOL
declare function GetPrintProcessorDirectoryW(byval pName as LPWSTR, byval pEnvironment as LPWSTR, byval Level as DWORD, byval pPrintProcessorInfo as LPBYTE, byval cbBuf as DWORD, byval pcbNeeded as LPDWORD) as WINBOOL
declare function EnumPrintProcessorDatatypesA(byval pName as LPSTR, byval pPrintProcessorName as LPSTR, byval Level as DWORD, byval pDatatypes as LPBYTE, byval cbBuf as DWORD, byval pcbNeeded as LPDWORD, byval pcReturned as LPDWORD) as WINBOOL
declare function EnumPrintProcessorDatatypesW(byval pName as LPWSTR, byval pPrintProcessorName as LPWSTR, byval Level as DWORD, byval pDatatypes as LPBYTE, byval cbBuf as DWORD, byval pcbNeeded as LPDWORD, byval pcReturned as LPDWORD) as WINBOOL
declare function DeletePrintProcessorA(byval pName as LPSTR, byval pEnvironment as LPSTR, byval pPrintProcessorName as LPSTR) as WINBOOL
declare function DeletePrintProcessorW(byval pName as LPWSTR, byval pEnvironment as LPWSTR, byval pPrintProcessorName as LPWSTR) as WINBOOL
declare function StartDocPrinterA(byval hPrinter as HANDLE, byval Level as DWORD, byval pDocInfo as LPBYTE) as DWORD
declare function StartDocPrinterW(byval hPrinter as HANDLE, byval Level as DWORD, byval pDocInfo as LPBYTE) as DWORD
declare function StartPagePrinter(byval hPrinter as HANDLE) as WINBOOL
declare function WritePrinter(byval hPrinter as HANDLE, byval pBuf as LPVOID, byval cbBuf as DWORD, byval pcWritten as LPDWORD) as WINBOOL
declare function FlushPrinter(byval hPrinter as HANDLE, byval pBuf as LPVOID, byval cbBuf as DWORD, byval pcWritten as LPDWORD, byval cSleep as DWORD) as WINBOOL
declare function EndPagePrinter(byval hPrinter as HANDLE) as WINBOOL
declare function AbortPrinter(byval hPrinter as HANDLE) as WINBOOL
declare function ReadPrinter(byval hPrinter as HANDLE, byval pBuf as LPVOID, byval cbBuf as DWORD, byval pNoBytesRead as LPDWORD) as WINBOOL
declare function EndDocPrinter(byval hPrinter as HANDLE) as WINBOOL
declare function AddJobA(byval hPrinter as HANDLE, byval Level as DWORD, byval pData as LPBYTE, byval cbBuf as DWORD, byval pcbNeeded as LPDWORD) as WINBOOL
declare function AddJobW(byval hPrinter as HANDLE, byval Level as DWORD, byval pData as LPBYTE, byval cbBuf as DWORD, byval pcbNeeded as LPDWORD) as WINBOOL
declare function ScheduleJob(byval hPrinter as HANDLE, byval JobId as DWORD) as WINBOOL
declare function PrinterProperties(byval hWnd as HWND, byval hPrinter as HANDLE) as WINBOOL
declare function DocumentPropertiesA(byval hWnd as HWND, byval hPrinter as HANDLE, byval pDeviceName as LPSTR, byval pDevModeOutput as PDEVMODEA, byval pDevModeInput as PDEVMODEA, byval fMode as DWORD) as LONG
declare function DocumentPropertiesW(byval hWnd as HWND, byval hPrinter as HANDLE, byval pDeviceName as LPWSTR, byval pDevModeOutput as PDEVMODEW, byval pDevModeInput as PDEVMODEW, byval fMode as DWORD) as LONG
declare function AdvancedDocumentPropertiesA(byval hWnd as HWND, byval hPrinter as HANDLE, byval pDeviceName as LPSTR, byval pDevModeOutput as PDEVMODEA, byval pDevModeInput as PDEVMODEA) as LONG
declare function AdvancedDocumentPropertiesW(byval hWnd as HWND, byval hPrinter as HANDLE, byval pDeviceName as LPWSTR, byval pDevModeOutput as PDEVMODEW, byval pDevModeInput as PDEVMODEW) as LONG
declare function ExtDeviceMode cdecl(byval hWnd as HWND, byval hInst as HANDLE, byval pDevModeOutput as LPDEVMODEA, byval pDeviceName as LPSTR, byval pPort as LPSTR, byval pDevModeInput as LPDEVMODEA, byval pProfile as LPSTR, byval fMode as DWORD) as LONG
declare function GetPrinterDataA(byval hPrinter as HANDLE, byval pValueName as LPSTR, byval pType as LPDWORD, byval pData as LPBYTE, byval nSize as DWORD, byval pcbNeeded as LPDWORD) as DWORD
declare function GetPrinterDataW(byval hPrinter as HANDLE, byval pValueName as LPWSTR, byval pType as LPDWORD, byval pData as LPBYTE, byval nSize as DWORD, byval pcbNeeded as LPDWORD) as DWORD
declare function GetPrinterDataExA(byval hPrinter as HANDLE, byval pKeyName as LPCSTR, byval pValueName as LPCSTR, byval pType as LPDWORD, byval pData as LPBYTE, byval nSize as DWORD, byval pcbNeeded as LPDWORD) as DWORD
declare function GetPrinterDataExW(byval hPrinter as HANDLE, byval pKeyName as LPCWSTR, byval pValueName as LPCWSTR, byval pType as LPDWORD, byval pData as LPBYTE, byval nSize as DWORD, byval pcbNeeded as LPDWORD) as DWORD
declare function EnumPrinterDataA(byval hPrinter as HANDLE, byval dwIndex as DWORD, byval pValueName as LPSTR, byval cbValueName as DWORD, byval pcbValueName as LPDWORD, byval pType as LPDWORD, byval pData as LPBYTE, byval cbData as DWORD, byval pcbData as LPDWORD) as DWORD
declare function EnumPrinterDataW(byval hPrinter as HANDLE, byval dwIndex as DWORD, byval pValueName as LPWSTR, byval cbValueName as DWORD, byval pcbValueName as LPDWORD, byval pType as LPDWORD, byval pData as LPBYTE, byval cbData as DWORD, byval pcbData as LPDWORD) as DWORD
declare function EnumPrinterDataExA(byval hPrinter as HANDLE, byval pKeyName as LPCSTR, byval pEnumValues as LPBYTE, byval cbEnumValues as DWORD, byval pcbEnumValues as LPDWORD, byval pnEnumValues as LPDWORD) as DWORD
declare function EnumPrinterDataExW(byval hPrinter as HANDLE, byval pKeyName as LPCWSTR, byval pEnumValues as LPBYTE, byval cbEnumValues as DWORD, byval pcbEnumValues as LPDWORD, byval pnEnumValues as LPDWORD) as DWORD
declare function EnumPrinterKeyA(byval hPrinter as HANDLE, byval pKeyName as LPCSTR, byval pSubkey as LPSTR, byval cbSubkey as DWORD, byval pcbSubkey as LPDWORD) as DWORD
declare function EnumPrinterKeyW(byval hPrinter as HANDLE, byval pKeyName as LPCWSTR, byval pSubkey as LPWSTR, byval cbSubkey as DWORD, byval pcbSubkey as LPDWORD) as DWORD
declare function SetPrinterDataA(byval hPrinter as HANDLE, byval pValueName as LPSTR, byval Type as DWORD, byval pData as LPBYTE, byval cbData as DWORD) as DWORD
declare function SetPrinterDataW(byval hPrinter as HANDLE, byval pValueName as LPWSTR, byval Type as DWORD, byval pData as LPBYTE, byval cbData as DWORD) as DWORD
declare function SetPrinterDataExA(byval hPrinter as HANDLE, byval pKeyName as LPCSTR, byval pValueName as LPCSTR, byval Type as DWORD, byval pData as LPBYTE, byval cbData as DWORD) as DWORD
declare function SetPrinterDataExW(byval hPrinter as HANDLE, byval pKeyName as LPCWSTR, byval pValueName as LPCWSTR, byval Type as DWORD, byval pData as LPBYTE, byval cbData as DWORD) as DWORD
declare function DeletePrinterDataA(byval hPrinter as HANDLE, byval pValueName as LPSTR) as DWORD
declare function DeletePrinterDataW(byval hPrinter as HANDLE, byval pValueName as LPWSTR) as DWORD
declare function DeletePrinterDataExA(byval hPrinter as HANDLE, byval pKeyName as LPCSTR, byval pValueName as LPCSTR) as DWORD
declare function DeletePrinterDataExW(byval hPrinter as HANDLE, byval pKeyName as LPCWSTR, byval pValueName as LPCWSTR) as DWORD
declare function DeletePrinterKeyA(byval hPrinter as HANDLE, byval pKeyName as LPCSTR) as DWORD
declare function DeletePrinterKeyW(byval hPrinter as HANDLE, byval pKeyName as LPCWSTR) as DWORD

#define PRINTER_NOTIFY_TYPE &h00
#define JOB_NOTIFY_TYPE &h01
#define PRINTER_NOTIFY_FIELD_SERVER_NAME &h00
#define PRINTER_NOTIFY_FIELD_PRINTER_NAME &h01
#define PRINTER_NOTIFY_FIELD_SHARE_NAME &h02
#define PRINTER_NOTIFY_FIELD_PORT_NAME &h03
#define PRINTER_NOTIFY_FIELD_DRIVER_NAME &h04
#define PRINTER_NOTIFY_FIELD_COMMENT &h05
#define PRINTER_NOTIFY_FIELD_LOCATION &h06
#define PRINTER_NOTIFY_FIELD_DEVMODE &h07
#define PRINTER_NOTIFY_FIELD_SEPFILE &h08
#define PRINTER_NOTIFY_FIELD_PRINT_PROCESSOR &h09
#define PRINTER_NOTIFY_FIELD_PARAMETERS &h0A
#define PRINTER_NOTIFY_FIELD_DATATYPE &h0B
#define PRINTER_NOTIFY_FIELD_SECURITY_DESCRIPTOR &h0C
#define PRINTER_NOTIFY_FIELD_ATTRIBUTES &h0D
#define PRINTER_NOTIFY_FIELD_PRIORITY &h0E
#define PRINTER_NOTIFY_FIELD_DEFAULT_PRIORITY &h0F
#define PRINTER_NOTIFY_FIELD_START_TIME &h10
#define PRINTER_NOTIFY_FIELD_UNTIL_TIME &h11
#define PRINTER_NOTIFY_FIELD_STATUS &h12
#define PRINTER_NOTIFY_FIELD_STATUS_STRING &h13
#define PRINTER_NOTIFY_FIELD_CJOBS &h14
#define PRINTER_NOTIFY_FIELD_AVERAGE_PPM &h15
#define PRINTER_NOTIFY_FIELD_TOTAL_PAGES &h16
#define PRINTER_NOTIFY_FIELD_PAGES_PRINTED &h17
#define PRINTER_NOTIFY_FIELD_TOTAL_BYTES &h18
#define PRINTER_NOTIFY_FIELD_BYTES_PRINTED &h19
#define PRINTER_NOTIFY_FIELD_OBJECT_GUID &h1A
#define JOB_NOTIFY_FIELD_PRINTER_NAME &h00
#define JOB_NOTIFY_FIELD_MACHINE_NAME &h01
#define JOB_NOTIFY_FIELD_PORT_NAME &h02
#define JOB_NOTIFY_FIELD_USER_NAME &h03
#define JOB_NOTIFY_FIELD_NOTIFY_NAME &h04
#define JOB_NOTIFY_FIELD_DATATYPE &h05
#define JOB_NOTIFY_FIELD_PRINT_PROCESSOR &h06
#define JOB_NOTIFY_FIELD_PARAMETERS &h07
#define JOB_NOTIFY_FIELD_DRIVER_NAME &h08
#define JOB_NOTIFY_FIELD_DEVMODE &h09
#define JOB_NOTIFY_FIELD_STATUS &h0A
#define JOB_NOTIFY_FIELD_STATUS_STRING &h0B
#define JOB_NOTIFY_FIELD_SECURITY_DESCRIPTOR &h0C
#define JOB_NOTIFY_FIELD_DOCUMENT &h0D
#define JOB_NOTIFY_FIELD_PRIORITY &h0E
#define JOB_NOTIFY_FIELD_POSITION &h0F
#define JOB_NOTIFY_FIELD_SUBMITTED &h10
#define JOB_NOTIFY_FIELD_START_TIME &h11
#define JOB_NOTIFY_FIELD_UNTIL_TIME &h12
#define JOB_NOTIFY_FIELD_TIME &h13
#define JOB_NOTIFY_FIELD_TOTAL_PAGES &h14
#define JOB_NOTIFY_FIELD_PAGES_PRINTED &h15
#define JOB_NOTIFY_FIELD_TOTAL_BYTES &h16
#define JOB_NOTIFY_FIELD_BYTES_PRINTED &h17

type _PRINTER_NOTIFY_OPTIONS_TYPE
	as WORD Type
	Reserved0 as WORD
	Reserved1 as DWORD
	Reserved2 as DWORD
	Count as DWORD
	pFields as PWORD
end type

type PRINTER_NOTIFY_OPTIONS_TYPE as _PRINTER_NOTIFY_OPTIONS_TYPE
type PPRINTER_NOTIFY_OPTIONS_TYPE as _PRINTER_NOTIFY_OPTIONS_TYPE ptr
type LPPRINTER_NOTIFY_OPTIONS_TYPE as _PRINTER_NOTIFY_OPTIONS_TYPE ptr
#define PRINTER_NOTIFY_OPTIONS_REFRESH &h01

type _PRINTER_NOTIFY_OPTIONS
	Version as DWORD
	Flags as DWORD
	Count as DWORD
	pTypes as PPRINTER_NOTIFY_OPTIONS_TYPE
end type

type PRINTER_NOTIFY_OPTIONS as _PRINTER_NOTIFY_OPTIONS
type PPRINTER_NOTIFY_OPTIONS as _PRINTER_NOTIFY_OPTIONS ptr
type LPPRINTER_NOTIFY_OPTIONS as _PRINTER_NOTIFY_OPTIONS ptr
#define PRINTER_NOTIFY_INFO_DISCARDED &h01

type _PRINTER_NOTIFY_INFO_DATA_NotifyData_Data
	cbBuf as DWORD
	pBuf as LPVOID
end type

union _PRINTER_NOTIFY_INFO_DATA_NotifyData
	adwData(0 to 1) as DWORD
	Data as _PRINTER_NOTIFY_INFO_DATA_NotifyData_Data
end union

type _PRINTER_NOTIFY_INFO_DATA
	as WORD Type
	Field as WORD
	Reserved as DWORD
	Id as DWORD
	NotifyData as _PRINTER_NOTIFY_INFO_DATA_NotifyData
end type

type PRINTER_NOTIFY_INFO_DATA as _PRINTER_NOTIFY_INFO_DATA
type PPRINTER_NOTIFY_INFO_DATA as _PRINTER_NOTIFY_INFO_DATA ptr
type LPPRINTER_NOTIFY_INFO_DATA as _PRINTER_NOTIFY_INFO_DATA ptr

type _PRINTER_NOTIFY_INFO
	Version as DWORD
	Flags as DWORD
	Count as DWORD
	aData(0 to 0) as PRINTER_NOTIFY_INFO_DATA
end type

type PRINTER_NOTIFY_INFO as _PRINTER_NOTIFY_INFO
type PPRINTER_NOTIFY_INFO as _PRINTER_NOTIFY_INFO ptr
type LPPRINTER_NOTIFY_INFO as _PRINTER_NOTIFY_INFO ptr

type _BINARY_CONTAINER
	cbBuf as DWORD
	pData as LPBYTE
end type

type BINARY_CONTAINER as _BINARY_CONTAINER
type PBINARY_CONTAINER as _BINARY_CONTAINER ptr

union _BIDI_DATA_u
	bData as WINBOOL
	iData as LONG
	sData as LPWSTR
	fData as FLOAT
	biData as BINARY_CONTAINER
end union

type _BIDI_DATA
	dwBidiType as DWORD
	u as _BIDI_DATA_u
end type

type BIDI_DATA as _BIDI_DATA
type PBIDI_DATA as _BIDI_DATA ptr
type LPBIDI_DATA as _BIDI_DATA ptr

type _BIDI_REQUEST_DATA
	dwReqNumber as DWORD
	pSchema as LPWSTR
	data as BIDI_DATA
end type

type BIDI_REQUEST_DATA as _BIDI_REQUEST_DATA
type PBIDI_REQUEST_DATA as _BIDI_REQUEST_DATA ptr
type LPBIDI_REQUEST_DATA as _BIDI_REQUEST_DATA ptr

type _BIDI_REQUEST_CONTAINER
	Version as DWORD
	Flags as DWORD
	Count as DWORD
	aData(0 to 0) as BIDI_REQUEST_DATA
end type

type BIDI_REQUEST_CONTAINER as _BIDI_REQUEST_CONTAINER
type PBIDI_REQUEST_CONTAINER as _BIDI_REQUEST_CONTAINER ptr
type LPBIDI_REQUEST_CONTAINER as _BIDI_REQUEST_CONTAINER ptr

type _BIDI_RESPONSE_DATA
	dwResult as DWORD
	dwReqNumber as DWORD
	pSchema as LPWSTR
	data as BIDI_DATA
end type

type BIDI_RESPONSE_DATA as _BIDI_RESPONSE_DATA
type PBIDI_RESPONSE_DATA as _BIDI_RESPONSE_DATA ptr
type LPBIDI_RESPONSE_DATA as _BIDI_RESPONSE_DATA ptr

type _BIDI_RESPONSE_CONTAINER
	Version as DWORD
	Flags as DWORD
	Count as DWORD
	aData(0 to 0) as BIDI_RESPONSE_DATA
end type

type BIDI_RESPONSE_CONTAINER as _BIDI_RESPONSE_CONTAINER
type PBIDI_RESPONSE_CONTAINER as _BIDI_RESPONSE_CONTAINER ptr
type LPBIDI_RESPONSE_CONTAINER as _BIDI_RESPONSE_CONTAINER ptr

#define BIDI_ACTION_ENUM_SCHEMA wstr("EnumSchema")
#define BIDI_ACTION_GET wstr("Get")
#define BIDI_ACTION_SET wstr("Set")
#define BIDI_ACTION_GET_ALL wstr("GetAll")

type BIDI_TYPE as long
enum
	BIDI_NULL = 0
	BIDI_INT = 1
	BIDI_FLOAT = 2
	BIDI_BOOL = 3
	BIDI_STRING = 4
	BIDI_TEXT = 5
	BIDI_ENUM = 6
	BIDI_BLOB = 7
end enum

#define BIDI_ACCESS_ADMINISTRATOR &h1
#define BIDI_ACCESS_USER &h2
#define ERROR_BIDI_STATUS_OK 0
#define ERROR_BIDI_NOT_SUPPORTED ERROR_NOT_SUPPORTED
#define ERROR_BIDI_ERROR_BASE 13000
#define ERROR_BIDI_STATUS_WARNING (ERROR_BIDI_ERROR_BASE + 1)
#define ERROR_BIDI_SCHEMA_READ_ONLY (ERROR_BIDI_ERROR_BASE + 2)
#define ERROR_BIDI_SERVER_OFFLINE (ERROR_BIDI_ERROR_BASE + 3)
#define ERROR_BIDI_DEVICE_OFFLINE (ERROR_BIDI_ERROR_BASE + 4)
#define ERROR_BIDI_SCHEMA_NOT_SUPPORTED (ERROR_BIDI_ERROR_BASE + 5)

declare function WaitForPrinterChange(byval hPrinter as HANDLE, byval Flags as DWORD) as DWORD
declare function FindFirstPrinterChangeNotification(byval hPrinter as HANDLE, byval fdwFlags as DWORD, byval fdwOptions as DWORD, byval pPrinterNotifyOptions as LPVOID) as HANDLE
declare function FindNextPrinterChangeNotification(byval hChange as HANDLE, byval pdwChange as PDWORD, byval pPrinterNotifyOptions as LPVOID, byval ppPrinterNotifyInfo as LPVOID ptr) as WINBOOL
declare function FreePrinterNotifyInfo(byval pPrinterNotifyInfo as PPRINTER_NOTIFY_INFO) as WINBOOL
declare function FindClosePrinterChangeNotification(byval hChange as HANDLE) as WINBOOL

#define PRINTER_CHANGE_ADD_PRINTER &h00000001
#define PRINTER_CHANGE_SET_PRINTER &h00000002
#define PRINTER_CHANGE_DELETE_PRINTER &h00000004
#define PRINTER_CHANGE_FAILED_CONNECTION_PRINTER &h00000008
#define PRINTER_CHANGE_PRINTER &h000000FF
#define PRINTER_CHANGE_ADD_JOB &h00000100
#define PRINTER_CHANGE_SET_JOB &h00000200
#define PRINTER_CHANGE_DELETE_JOB &h00000400
#define PRINTER_CHANGE_WRITE_JOB &h00000800
#define PRINTER_CHANGE_JOB &h0000FF00
#define PRINTER_CHANGE_ADD_FORM &h00010000
#define PRINTER_CHANGE_SET_FORM &h00020000
#define PRINTER_CHANGE_DELETE_FORM &h00040000
#define PRINTER_CHANGE_FORM &h00070000
#define PRINTER_CHANGE_ADD_PORT &h00100000
#define PRINTER_CHANGE_CONFIGURE_PORT &h00200000
#define PRINTER_CHANGE_DELETE_PORT &h00400000
#define PRINTER_CHANGE_PORT &h00700000
#define PRINTER_CHANGE_ADD_PRINT_PROCESSOR &h01000000
#define PRINTER_CHANGE_DELETE_PRINT_PROCESSOR &h04000000
#define PRINTER_CHANGE_PRINT_PROCESSOR &h07000000
#define PRINTER_CHANGE_ADD_PRINTER_DRIVER &h10000000
#define PRINTER_CHANGE_SET_PRINTER_DRIVER &h20000000
#define PRINTER_CHANGE_DELETE_PRINTER_DRIVER &h40000000
#define PRINTER_CHANGE_PRINTER_DRIVER &h70000000
#define PRINTER_CHANGE_TIMEOUT &h80000000
#define PRINTER_CHANGE_ALL &h7777FFFF

#ifdef UNICODE
	#define PrinterMessageBox PrinterMessageBoxW
	#define AddForm AddFormW
	#define DeleteForm DeleteFormW
	#define GetForm GetFormW
	#define SetForm SetFormW
	#define EnumForms EnumFormsW
	#define EnumMonitors EnumMonitorsW
	#define AddMonitor AddMonitorW
	#define DeleteMonitor DeleteMonitorW
	#define EnumPorts EnumPortsW
	#define AddPort AddPortW
	#define ConfigurePort ConfigurePortW
	#define DeletePort DeletePortW
	#define GetDefaultPrinter GetDefaultPrinterW
	#define SetDefaultPrinter SetDefaultPrinterW
	#define SetPort SetPortW
	#define AddPrinterConnection AddPrinterConnectionW
	#define DeletePrinterConnection DeletePrinterConnectionW
#else
	#define PrinterMessageBox PrinterMessageBoxA
	#define AddForm AddFormA
	#define DeleteForm DeleteFormA
	#define GetForm GetFormA
	#define SetForm SetFormA
	#define EnumForms EnumFormsA
	#define EnumMonitors EnumMonitorsA
	#define AddMonitor AddMonitorA
	#define DeleteMonitor DeleteMonitorA
	#define EnumPorts EnumPortsA
	#define AddPort AddPortA
	#define ConfigurePort ConfigurePortA
	#define DeletePort DeletePortA
	#define GetDefaultPrinter GetDefaultPrinterA
	#define SetDefaultPrinter SetDefaultPrinterA
	#define SetPort SetPortA
	#define AddPrinterConnection AddPrinterConnectionA
	#define DeletePrinterConnection DeletePrinterConnectionA
#endif

declare function PrinterMessageBoxA(byval hPrinter as HANDLE, byval Error as DWORD, byval hWnd as HWND, byval pText as LPSTR, byval pCaption as LPSTR, byval dwType as DWORD) as DWORD
declare function PrinterMessageBoxW(byval hPrinter as HANDLE, byval Error as DWORD, byval hWnd as HWND, byval pText as LPWSTR, byval pCaption as LPWSTR, byval dwType as DWORD) as DWORD
#define PRINTER_ERROR_INFORMATION &h80000000
#define PRINTER_ERROR_WARNING &h40000000
#define PRINTER_ERROR_SEVERE &h20000000
#define PRINTER_ERROR_OUTOFPAPER &h00000001
#define PRINTER_ERROR_JAM &h00000002
#define PRINTER_ERROR_OUTOFTONER &h00000004

declare function ClosePrinter(byval hPrinter as HANDLE) as WINBOOL
declare function AddFormA(byval hPrinter as HANDLE, byval Level as DWORD, byval pForm as LPBYTE) as WINBOOL
declare function AddFormW(byval hPrinter as HANDLE, byval Level as DWORD, byval pForm as LPBYTE) as WINBOOL
declare function DeleteFormA(byval hPrinter as HANDLE, byval pFormName as LPSTR) as WINBOOL
declare function DeleteFormW(byval hPrinter as HANDLE, byval pFormName as LPWSTR) as WINBOOL
declare function GetFormA(byval hPrinter as HANDLE, byval pFormName as LPSTR, byval Level as DWORD, byval pForm as LPBYTE, byval cbBuf as DWORD, byval pcbNeeded as LPDWORD) as WINBOOL
declare function GetFormW(byval hPrinter as HANDLE, byval pFormName as LPWSTR, byval Level as DWORD, byval pForm as LPBYTE, byval cbBuf as DWORD, byval pcbNeeded as LPDWORD) as WINBOOL
declare function SetFormA(byval hPrinter as HANDLE, byval pFormName as LPSTR, byval Level as DWORD, byval pForm as LPBYTE) as WINBOOL
declare function SetFormW(byval hPrinter as HANDLE, byval pFormName as LPWSTR, byval Level as DWORD, byval pForm as LPBYTE) as WINBOOL
declare function EnumFormsA(byval hPrinter as HANDLE, byval Level as DWORD, byval pForm as LPBYTE, byval cbBuf as DWORD, byval pcbNeeded as LPDWORD, byval pcReturned as LPDWORD) as WINBOOL
declare function EnumFormsW(byval hPrinter as HANDLE, byval Level as DWORD, byval pForm as LPBYTE, byval cbBuf as DWORD, byval pcbNeeded as LPDWORD, byval pcReturned as LPDWORD) as WINBOOL
declare function EnumMonitorsA(byval pName as LPSTR, byval Level as DWORD, byval pMonitor as LPBYTE, byval cbBuf as DWORD, byval pcbNeeded as LPDWORD, byval pcReturned as LPDWORD) as WINBOOL
declare function EnumMonitorsW(byval pName as LPWSTR, byval Level as DWORD, byval pMonitor as LPBYTE, byval cbBuf as DWORD, byval pcbNeeded as LPDWORD, byval pcReturned as LPDWORD) as WINBOOL
declare function AddMonitorA(byval pName as LPSTR, byval Level as DWORD, byval pMonitorInfo as LPBYTE) as WINBOOL
declare function AddMonitorW(byval pName as LPWSTR, byval Level as DWORD, byval pMonitorInfo as LPBYTE) as WINBOOL
declare function DeleteMonitorA(byval pName as LPSTR, byval pEnvironment as LPSTR, byval pMonitorName as LPSTR) as WINBOOL
declare function DeleteMonitorW(byval pName as LPWSTR, byval pEnvironment as LPWSTR, byval pMonitorName as LPWSTR) as WINBOOL
declare function EnumPortsA(byval pName as LPSTR, byval Level as DWORD, byval pPorts as LPBYTE, byval cbBuf as DWORD, byval pcbNeeded as LPDWORD, byval pcReturned as LPDWORD) as WINBOOL
declare function EnumPortsW(byval pName as LPWSTR, byval Level as DWORD, byval pPorts as LPBYTE, byval cbBuf as DWORD, byval pcbNeeded as LPDWORD, byval pcReturned as LPDWORD) as WINBOOL
declare function AddPortA(byval pName as LPSTR, byval hWnd as HWND, byval pMonitorName as LPSTR) as WINBOOL
declare function AddPortW(byval pName as LPWSTR, byval hWnd as HWND, byval pMonitorName as LPWSTR) as WINBOOL
declare function ConfigurePortA(byval pName as LPSTR, byval hWnd as HWND, byval pPortName as LPSTR) as WINBOOL
declare function ConfigurePortW(byval pName as LPWSTR, byval hWnd as HWND, byval pPortName as LPWSTR) as WINBOOL
declare function DeletePortA(byval pName as LPSTR, byval hWnd as HWND, byval pPortName as LPSTR) as WINBOOL
declare function DeletePortW(byval pName as LPWSTR, byval hWnd as HWND, byval pPortName as LPWSTR) as WINBOOL
declare function XcvDataW(byval hXcv as HANDLE, byval pszDataName as PCWSTR, byval pInputData as PBYTE, byval cbInputData as DWORD, byval pOutputData as PBYTE, byval cbOutputData as DWORD, byval pcbOutputNeeded as PDWORD, byval pdwStatus as PDWORD) as WINBOOL
#define XcvData XcvDataW
declare function GetDefaultPrinterA(byval pszBuffer as LPSTR, byval pcchBuffer as LPDWORD) as WINBOOL
declare function GetDefaultPrinterW(byval pszBuffer as LPWSTR, byval pcchBuffer as LPDWORD) as WINBOOL
declare function SetDefaultPrinterA(byval pszPrinter as LPCSTR) as WINBOOL
declare function SetDefaultPrinterW(byval pszPrinter as LPCWSTR) as WINBOOL
declare function SetPortA(byval pName as LPSTR, byval pPortName as LPSTR, byval dwLevel as DWORD, byval pPortInfo as LPBYTE) as WINBOOL
declare function SetPortW(byval pName as LPWSTR, byval pPortName as LPWSTR, byval dwLevel as DWORD, byval pPortInfo as LPBYTE) as WINBOOL
declare function AddPrinterConnectionA(byval pName as LPSTR) as WINBOOL
declare function AddPrinterConnectionW(byval pName as LPWSTR) as WINBOOL
declare function DeletePrinterConnectionA(byval pName as LPSTR) as WINBOOL
declare function DeletePrinterConnectionW(byval pName as LPWSTR) as WINBOOL
declare function ConnectToPrinterDlg(byval hwnd as HWND, byval Flags as DWORD) as HANDLE

type _PROVIDOR_INFO_1A
	pName as LPSTR
	pEnvironment as LPSTR
	pDLLName as LPSTR
end type

type PROVIDOR_INFO_1A as _PROVIDOR_INFO_1A
type PPROVIDOR_INFO_1A as _PROVIDOR_INFO_1A ptr
type LPPROVIDOR_INFO_1A as _PROVIDOR_INFO_1A ptr

type _PROVIDOR_INFO_1W
	pName as LPWSTR
	pEnvironment as LPWSTR
	pDLLName as LPWSTR
end type

type PROVIDOR_INFO_1W as _PROVIDOR_INFO_1W
type PPROVIDOR_INFO_1W as _PROVIDOR_INFO_1W ptr
type LPPROVIDOR_INFO_1W as _PROVIDOR_INFO_1W ptr

#ifdef UNICODE
	type PROVIDOR_INFO_1 as PROVIDOR_INFO_1W
	type PPROVIDOR_INFO_1 as PPROVIDOR_INFO_1W
	type LPPROVIDOR_INFO_1 as LPPROVIDOR_INFO_1W
#else
	type PROVIDOR_INFO_1 as PROVIDOR_INFO_1A
	type PPROVIDOR_INFO_1 as PPROVIDOR_INFO_1A
	type LPPROVIDOR_INFO_1 as LPPROVIDOR_INFO_1A
#endif

type _PROVIDOR_INFO_2A
	pOrder as LPSTR
end type

type PROVIDOR_INFO_2A as _PROVIDOR_INFO_2A
type PPROVIDOR_INFO_2A as _PROVIDOR_INFO_2A ptr
type LPPROVIDOR_INFO_2A as _PROVIDOR_INFO_2A ptr

type _PROVIDOR_INFO_2W
	pOrder as LPWSTR
end type

type PROVIDOR_INFO_2W as _PROVIDOR_INFO_2W
type PPROVIDOR_INFO_2W as _PROVIDOR_INFO_2W ptr
type LPPROVIDOR_INFO_2W as _PROVIDOR_INFO_2W ptr

#ifdef UNICODE
	type PROVIDOR_INFO_2 as PROVIDOR_INFO_2W
	type PPROVIDOR_INFO_2 as PPROVIDOR_INFO_2W
	type LPPROVIDOR_INFO_2 as LPPROVIDOR_INFO_2W

	#define AddPrintProvidor AddPrintProvidorW
	#define DeletePrintProvidor DeletePrintProvidorW
	#define IsValidDevmode IsValidDevmodeW
#else
	type PROVIDOR_INFO_2 as PROVIDOR_INFO_2A
	type PPROVIDOR_INFO_2 as PPROVIDOR_INFO_2A
	type LPPROVIDOR_INFO_2 as LPPROVIDOR_INFO_2A

	#define AddPrintProvidor AddPrintProvidorA
	#define DeletePrintProvidor DeletePrintProvidorA
	#define IsValidDevmode IsValidDevmodeA
#endif

declare function AddPrintProvidorA(byval pName as LPSTR, byval level as DWORD, byval pProvidorInfo as LPBYTE) as WINBOOL
declare function AddPrintProvidorW(byval pName as LPWSTR, byval level as DWORD, byval pProvidorInfo as LPBYTE) as WINBOOL
declare function DeletePrintProvidorA(byval pName as LPSTR, byval pEnvironment as LPSTR, byval pPrintProvidorName as LPSTR) as WINBOOL
declare function DeletePrintProvidorW(byval pName as LPWSTR, byval pEnvironment as LPWSTR, byval pPrintProvidorName as LPWSTR) as WINBOOL
declare function IsValidDevmodeA(byval pDevmode as PDEVMODEA, byval DevmodeSize as uinteger) as WINBOOL
declare function IsValidDevmodeW(byval pDevmode as PDEVMODEW, byval DevmodeSize as uinteger) as WINBOOL

#define SPLREG_DEFAULT_SPOOL_DIRECTORY __TEXT("DefaultSpoolDirectory")
#define SPLREG_PORT_THREAD_PRIORITY_DEFAULT __TEXT("PortThreadPriorityDefault")
#define SPLREG_PORT_THREAD_PRIORITY __TEXT("PortThreadPriority")
#define SPLREG_SCHEDULER_THREAD_PRIORITY_DEFAULT __TEXT("SchedulerThreadPriorityDefault")
#define SPLREG_SCHEDULER_THREAD_PRIORITY __TEXT("SchedulerThreadPriority")
#define SPLREG_BEEP_ENABLED __TEXT("BeepEnabled")
#define SPLREG_NET_POPUP __TEXT("NetPopup")
#define SPLREG_RETRY_POPUP __TEXT("RetryPopup")
#define SPLREG_NET_POPUP_TO_COMPUTER __TEXT("NetPopupToComputer")
#define SPLREG_EVENT_LOG __TEXT("EventLog")
#define SPLREG_MAJOR_VERSION __TEXT("MajorVersion")
#define SPLREG_MINOR_VERSION __TEXT("MinorVersion")
#define SPLREG_ARCHITECTURE __TEXT("Architecture")
#define SPLREG_OS_VERSION __TEXT("OSVersion")
#define SPLREG_OS_VERSIONEX __TEXT("OSVersionEx")
#define SPLREG_DS_PRESENT __TEXT("DsPresent")
#define SPLREG_DS_PRESENT_FOR_USER __TEXT("DsPresentForUser")
#define SPLREG_REMOTE_FAX __TEXT("RemoteFax")
#define SPLREG_RESTART_JOB_ON_POOL_ERROR __TEXT("RestartJobOnPoolError")
#define SPLREG_RESTART_JOB_ON_POOL_ENABLED __TEXT("RestartJobOnPoolEnabled")
#define SPLREG_DNS_MACHINE_NAME __TEXT("DNSMachineName")
#define SPLREG_ALLOW_USER_MANAGEFORMS __TEXT("AllowUserManageForms")
#define SPLREG_WEBSHAREMGMT __TEXT("WebShareMgmt")
#define SERVER_ACCESS_ADMINISTER &h00000001
#define SERVER_ACCESS_ENUMERATE &h00000002
#define PRINTER_ACCESS_ADMINISTER &h00000004
#define PRINTER_ACCESS_USE &h00000008
#define JOB_ACCESS_ADMINISTER &h00000010
#define JOB_ACCESS_READ &h00000020
#define SERVER_ALL_ACCESS ((STANDARD_RIGHTS_REQUIRED or SERVER_ACCESS_ADMINISTER) or SERVER_ACCESS_ENUMERATE)
#define SERVER_READ (STANDARD_RIGHTS_READ or SERVER_ACCESS_ENUMERATE)
#define SERVER_WRITE ((STANDARD_RIGHTS_WRITE or SERVER_ACCESS_ADMINISTER) or SERVER_ACCESS_ENUMERATE)
#define SERVER_EXECUTE (STANDARD_RIGHTS_EXECUTE or SERVER_ACCESS_ENUMERATE)
#define PRINTER_ALL_ACCESS ((STANDARD_RIGHTS_REQUIRED or PRINTER_ACCESS_ADMINISTER) or PRINTER_ACCESS_USE)
#define PRINTER_READ (STANDARD_RIGHTS_READ or PRINTER_ACCESS_USE)
#define PRINTER_WRITE (STANDARD_RIGHTS_WRITE or PRINTER_ACCESS_USE)
#define PRINTER_EXECUTE (STANDARD_RIGHTS_EXECUTE or PRINTER_ACCESS_USE)
#define JOB_ALL_ACCESS ((STANDARD_RIGHTS_REQUIRED or JOB_ACCESS_ADMINISTER) or JOB_ACCESS_READ)
#define JOB_READ (STANDARD_RIGHTS_READ or JOB_ACCESS_READ)
#define JOB_WRITE (STANDARD_RIGHTS_WRITE or JOB_ACCESS_ADMINISTER)
#define JOB_EXECUTE (STANDARD_RIGHTS_EXECUTE or JOB_ACCESS_ADMINISTER)
#define SPLDS_SPOOLER_KEY __TEXT("DsSpooler")
#define SPLDS_DRIVER_KEY __TEXT("DsDriver")
#define SPLDS_USER_KEY __TEXT("DsUser")
#define SPLDS_ASSET_NUMBER __TEXT("assetNumber")
#define SPLDS_BYTES_PER_MINUTE __TEXT("bytesPerMinute")
#define SPLDS_DESCRIPTION __TEXT("description")
#define SPLDS_DRIVER_NAME __TEXT("driverName")
#define SPLDS_DRIVER_VERSION __TEXT("driverVersion")
#define SPLDS_LOCATION __TEXT("location")
#define SPLDS_PORT_NAME __TEXT("portName")
#define SPLDS_PRINT_ATTRIBUTES __TEXT("printAttributes")
#define SPLDS_PRINT_BIN_NAMES __TEXT("printBinNames")
#define SPLDS_PRINT_COLLATE __TEXT("printCollate")
#define SPLDS_PRINT_COLOR __TEXT("printColor")
#define SPLDS_PRINT_DUPLEX_SUPPORTED __TEXT("printDuplexSupported")
#define SPLDS_PRINT_END_TIME __TEXT("printEndTime")
#define SPLDS_PRINTER_CLASS __TEXT("printQueue")
#define SPLDS_PRINTER_NAME __TEXT("printerName")
#define SPLDS_PRINT_KEEP_PRINTED_JOBS __TEXT("printKeepPrintedJobs")
#define SPLDS_PRINT_LANGUAGE __TEXT("printLanguage")
#define SPLDS_PRINT_MAC_ADDRESS __TEXT("printMACAddress")
#define SPLDS_PRINT_MAX_X_EXTENT __TEXT("printMaxXExtent")
#define SPLDS_PRINT_MAX_Y_EXTENT __TEXT("printMaxYExtent")
#define SPLDS_PRINT_MAX_RESOLUTION_SUPPORTED __TEXT("printMaxResolutionSupported")
#define SPLDS_PRINT_MEDIA_READY __TEXT("printMediaReady")
#define SPLDS_PRINT_MEDIA_SUPPORTED __TEXT("printMediaSupported")
#define SPLDS_PRINT_MEMORY __TEXT("printMemory")
#define SPLDS_PRINT_MIN_X_EXTENT __TEXT("printMinXExtent")
#define SPLDS_PRINT_MIN_Y_EXTENT __TEXT("printMinYExtent")
#define SPLDS_PRINT_NETWORK_ADDRESS __TEXT("printNetworkAddress")
#define SPLDS_PRINT_NOTIFY __TEXT("printNotify")
#define SPLDS_PRINT_NUMBER_UP __TEXT("printNumberUp")
#define SPLDS_PRINT_ORIENTATIONS_SUPPORTED __TEXT("printOrientationsSupported")
#define SPLDS_PRINT_OWNER __TEXT("printOwner")
#define SPLDS_PRINT_PAGES_PER_MINUTE __TEXT("printPagesPerMinute")
#define SPLDS_PRINT_RATE __TEXT("printRate")
#define SPLDS_PRINT_RATE_UNIT __TEXT("printRateUnit")
#define SPLDS_PRINT_SEPARATOR_FILE __TEXT("printSeparatorFile")
#define SPLDS_PRINT_SHARE_NAME __TEXT("printShareName")
#define SPLDS_PRINT_SPOOLING __TEXT("printSpooling")
#define SPLDS_PRINT_STAPLING_SUPPORTED __TEXT("printStaplingSupported")
#define SPLDS_PRINT_START_TIME __TEXT("printStartTime")
#define SPLDS_PRINT_STATUS __TEXT("printStatus")
#define SPLDS_PRIORITY __TEXT("priority")
#define SPLDS_SERVER_NAME __TEXT("serverName")
#define SPLDS_SHORT_SERVER_NAME __TEXT("shortServerName")
#define SPLDS_UNC_NAME __TEXT("uNCName")
#define SPLDS_URL __TEXT("url")
#define SPLDS_FLAGS __TEXT("flags")
#define SPLDS_VERSION_NUMBER __TEXT("versionNumber")
#define SPLDS_PRINTER_NAME_ALIASES __TEXT("printerNameAliases")
#define SPLDS_PRINTER_LOCATIONS __TEXT("printerLocations")
#define SPLDS_PRINTER_MODEL __TEXT("printerModel")

#if defined(UNICODE) and (_WIN32_WINNT = &h0602)
	#define AddPrinterConnection2 AddPrinterConnection2W
	#define DeletePrinterDriverPackage DeletePrinterDriverPackageW
	#define DocumentEvent DocumentEventW
#elseif (not defined(UNICODE)) and (_WIN32_WINNT = &h0602)
	#define AddPrinterConnection2 AddPrinterConnection2A
	#define DeletePrinterDriverPackage DeletePrinterDriverPackageA
	#define DocumentEvent DocumentEventA
#endif

#if _WIN32_WINNT = &h0602
	#define PRINTER_CONNECTION_MISMATCH &h00000020
	#define PRINTER_CONNECTION_NO_UI &h00000040

	type tagPRINTER_OPTION_FLAGS as long
	enum
		PRINTER_OPTION_NO_CACHE
		PRINTER_OPTION_CACHE
		PRINTER_OPTION_CLIENT_CHANGE
	end enum

	type PRINTER_OPTION_FLAGS as tagPRINTER_OPTION_FLAGS

	type tagEPrintXPSJobOperation as long
	enum
		kJobProduction
		kJobConsumption
	end enum

	type EPrintXPSJobOperation as tagEPrintXPSJobOperation

	type tagEPrintXPSJobProgress as long
	enum
		kAddingDocumentSequence
		kDocumentSequenceAdded
		kAddingFixedDocument
		kFixedDocumentAdded
		kAddingFixedPage
		kFixedPageAdded
		kResourceAdded
		kFontAdded
		kImageAdded
		kXpsDocumentCommitted
	end enum

	type EPrintXPSJobProgress as tagEPrintXPSJobProgress

	type _PRINTER_CONNECTION_INFO_1
		dwFlags as DWORD
		pszDriverName as LPTSTR
	end type

	type PRINTER_CONNECTION_INFO_1 as _PRINTER_CONNECTION_INFO_1
	type PPRINTER_CONNECTION_INFO_1 as _PRINTER_CONNECTION_INFO_1 ptr
	declare function AddPrinterConnection2W cdecl(byval hWnd as HWND, byval pszName as LPCWSTR, byval dwLevel as DWORD, byval pConnectionInfo as PVOID) as WINBOOL
	declare function AddPrinterConnection2A cdecl(byval hWnd as HWND, byval pszName as LPCSTR, byval dwLevel as DWORD, byval pConnectionInfo as PVOID) as WINBOOL
	declare function DeletePrinterDriverPackageA(byval pszServer as LPCSTR, byval pszInfPath as LPCSTR, byval pszEnvironment as LPCSTR) as HRESULT
	declare function DeletePrinterDriverPackageW(byval pszServer as LPCWSTR, byval pszInfPath as LPCWSTR, byval pszEnvironment as LPCWSTR) as HRESULT
	declare function DocumentEventA cdecl(byval hPrinter as HANDLE, byval hdc as HDC, byval iEsc as INT_, byval cbIn as ULONG, byval pvIn as PVOID, byval cbOut as ULONG, byval pvOut as PVOID) as HRESULT
	declare function DocumentEventW cdecl(byval hPrinter as HANDLE, byval hdc as HDC, byval iEsc as INT_, byval cbIn as ULONG, byval pvIn as PVOID, byval cbOut as ULONG, byval pvOut as PVOID) as HRESULT

	type _DRIVER_INFO_8W
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
		pszzPreviousNames as LPWSTR
		ftDriverDate as FILETIME
		dwlDriverVersion as DWORDLONG
		pszMfgName as LPWSTR
		pszOEMUrl as LPWSTR
		pszHardwareID as LPWSTR
		pszProvider as LPWSTR
		pszPrintProcessor as LPWSTR
		pszVendorSetup as LPWSTR
		pszzColorProfiles as LPWSTR
		pszInfPath as LPWSTR
		dwPrinterDriverAttributes as DWORD
		pszzCoreDriverDependencies as LPWSTR
		ftMinInboxDriverVerDate as FILETIME
		dwlMinInboxDriverVerVersion as DWORDLONG
	end type

	type DRIVER_INFO_8W as _DRIVER_INFO_8W
	type PDRIVER_INFO_8W as _DRIVER_INFO_8W ptr
	type LPDRIVER_INFO_8W as _DRIVER_INFO_8W ptr

	type _DRIVER_INFO_8A
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
		pszzPreviousNames as LPSTR
		ftDriverDate as FILETIME
		dwlDriverVersion as DWORDLONG
		pszMfgName as LPSTR
		pszOEMUrl as LPSTR
		pszHardwareID as LPSTR
		pszProvider as LPSTR
		pszPrintProcessor as LPSTR
		pszVendorSetup as LPSTR
		pszzColorProfiles as LPSTR
		pszInfPath as LPSTR
		dwPrinterDriverAttributes as DWORD
		pszzCoreDriverDependencies as LPSTR
		ftMinInboxDriverVerDate as FILETIME
		dwlMinInboxDriverVerVersion as DWORDLONG
	end type

	type DRIVER_INFO_8A as _DRIVER_INFO_8A
	type PDRIVER_INFO_8A as _DRIVER_INFO_8A ptr
	type LPDRIVER_INFO_8A as _DRIVER_INFO_8A ptr

	type _FORM_INFO_2A
		Flags as DWORD
		pName as LPSTR
		Size as SIZEL
		ImageableArea as RECTL
		pKeyword as LPCSTR
		StringType as DWORD
		pMuiDll as LPCSTR
		dwResourceId as DWORD
		pDisplayName as LPCSTR
		wLangId as LANGID
	end type

	type FORM_INFO_2A as _FORM_INFO_2A
	type PFORM_INFO_2A as _FORM_INFO_2A ptr

	type _FORM_INFO_2W
		Flags as DWORD
		pName as LPWSTR
		Size as SIZEL
		ImageableArea as RECTL
		pKeyword as LPCSTR
		StringType as DWORD
		pMuiDll as LPCWSTR
		dwResourceId as DWORD
		pDisplayName as LPCWSTR
		wLangId as LANGID
	end type

	type FORM_INFO_2W as _FORM_INFO_2W
	type PFORM_INFO_2W as _FORM_INFO_2W ptr
#endif

#if defined(UNICODE) and (_WIN32_WINNT = &h0602)
	type DRIVER_INFO_8 as DRIVER_INFO_8W
	type PDRIVER_INFO_8 as PDRIVER_INFO_8W
	type LPDRIVER_INFO_8 as LPDRIVER_INFO_8W
	type FORM_INFO_2 as FORM_INFO_2W
	type PFORM_INFO_2 as PFORM_INFO_2W
#elseif (not defined(UNICODE)) and (_WIN32_WINNT = &h0602)
	type DRIVER_INFO_8 as DRIVER_INFO_8A
	type PDRIVER_INFO_8 as PDRIVER_INFO_8A
	type LPDRIVER_INFO_8 as LPDRIVER_INFO_8A
	type FORM_INFO_2 as FORM_INFO_2A
	type PFORM_INFO_2 as PFORM_INFO_2A
#endif

#if _WIN32_WINNT = &h0602
	type _PRINTPROCESSOR_CAPS_2
		dwLevel as DWORD
		dwNupOptions as DWORD
		dwPageOrderFlags as DWORD
		dwNumberOfCopies as DWORD
		dwNupDirectionCaps as DWORD
		dwNupBorderCaps as DWORD
		dwBookletHandlingCaps as DWORD
		dwDuplexHandlingCaps as DWORD
		dwScalingCaps as DWORD
	end type

	type PRINTPROCESSOR_CAPS_2 as _PRINTPROCESSOR_CAPS_2
	type PPRINTPROCESSOR_CAPS_2 as _PRINTPROCESSOR_CAPS_2 ptr
	declare function ReportJobProcessingProgress cdecl(byval printerHandle as HANDLE, byval jobId as ULONG, byval jobOperation as EPrintXPSJobOperation, byval jobProgress as EPrintXPSJobProgress) as HRESULT

	type _CORE_PRINTER_DRIVERA
		CoreDriverGUID as GUID
		ftDriverDate as FILETIME
		dwlDriverVersion as DWORDLONG
		szPackageID as zstring * 260
	end type

	type CORE_PRINTER_DRIVERA as _CORE_PRINTER_DRIVERA
	type PCORE_PRINTER_DRIVERA as _CORE_PRINTER_DRIVERA ptr

	type _CORE_PRINTER_DRIVERW
		CoreDriverGUID as GUID
		ftDriverDate as FILETIME
		dwlDriverVersion as DWORDLONG
		szPackageID as wstring * 260
	end type

	type CORE_PRINTER_DRIVERW as _CORE_PRINTER_DRIVERW
	type PCORE_PRINTER_DRIVERW as _CORE_PRINTER_DRIVERW ptr

	type _PRINTER_OPTIONS
		cbSize as UINT
		dwFlags as DWORD
	end type

	type PRINTER_OPTIONS as _PRINTER_OPTIONS
	type PPRINTER_OPTIONS as _PRINTER_OPTIONS ptr
#endif

#if defined(UNICODE) and (_WIN32_WINNT = &h0602)
	type CORE_PRINTER_DRIVER as CORE_PRINTER_DRIVERW
	type PCORE_PRINTER_DRIVER as PCORE_PRINTER_DRIVERW
	#define GetCorePrinterDrivers GetCorePrinterDriversW
	#define GetPrinterDriver2 GetPrinterDriver2W
	#define GetPrinterDriverPackagePath GetPrinterDriverPackagePathW
	#define GetSpoolFileHandle GetSpoolFileHandleW
#elseif (not defined(UNICODE)) and (_WIN32_WINNT = &h0602)
	type CORE_PRINTER_DRIVER as CORE_PRINTER_DRIVERA
	type PCORE_PRINTER_DRIVER as PCORE_PRINTER_DRIVERA
	#define GetCorePrinterDrivers GetCorePrinterDriversA
	#define GetPrinterDriver2 GetPrinterDriver2A
	#define GetPrinterDriverPackagePath GetPrinterDriverPackagePathA
	#define GetSpoolFileHandle GetSpoolFileHandleA
#endif

#if _WIN32_WINNT = &h0602
	declare function GetCorePrinterDriversA(byval pszServer as LPCSTR, byval pszEnvironment as LPCSTR, byval pszzCoreDriverDependencies as LPCSTR, byval cCorePrinterDrivers as DWORD, byval pCorePrinterDrivers as PCORE_PRINTER_DRIVERA) as HRESULT
	declare function GetCorePrinterDriversW(byval pszServer as LPCWSTR, byval pszEnvironment as LPCWSTR, byval pszzCoreDriverDependencies as LPCWSTR, byval cCorePrinterDrivers as DWORD, byval pCorePrinterDrivers as PCORE_PRINTER_DRIVERW) as HRESULT
	declare function GetPrinterDriver2A(byval hWnd as HWND, byval hPrinter as HANDLE, byval pEnvironment as LPSTR, byval Level as DWORD, byval pDriverInfo as LPBYTE, byval cbBuf as DWORD, byval pcbNeeded as LPDWORD) as WINBOOL
	declare function GetPrinterDriver2W(byval hWnd as HWND, byval hPrinter as HANDLE, byval pEnvironment as LPWSTR, byval Level as DWORD, byval pDriverInfo as LPBYTE, byval cbBuf as DWORD, byval pcbNeeded as LPDWORD) as WINBOOL
	declare function GetPrinterDriverPackagePathA(byval pszServer as LPCSTR, byval pszEnvironment as LPCSTR, byval pszLanguage as LPCSTR, byval pszPackageID as LPCSTR, byval pszDriverPackageCab as LPSTR, byval cchDriverPackageCab as DWORD, byval pcchRequiredSize as LPDWORD) as HRESULT
	declare function GetPrinterDriverPackagePathW(byval pszServer as LPCWSTR, byval pszEnvironment as LPCWSTR, byval pszLanguage as LPCWSTR, byval pszPackageID as LPCWSTR, byval pszDriverPackageCab as LPWSTR, byval cchDriverPackageCab as DWORD, byval pcchRequiredSize as LPDWORD) as HRESULT
	declare function GetSpoolFileHandleA(byval hPrinter as HANDLE) as HANDLE
	declare function GetSpoolFileHandleW(byval hPrinter as HANDLE) as HANDLE
	declare function CommitSpoolData(byval hPrinter as HANDLE, byval hSpoolFile as HANDLE, byval cbCommit as DWORD) as HANDLE
	declare function CloseSpoolFileHandle(byval hPrinter as HANDLE, byval hSpoolFile as HANDLE) as WINBOOL
	declare function OpenPrinter2A(byval pPrinterName as LPCSTR, byval phPrinter as LPHANDLE, byval pDefault as LPPRINTER_DEFAULTS, byval pOptions as PPRINTER_OPTIONS) as WINBOOL
	declare function OpenPrinter2W(byval pPrinterName as LPCWSTR, byval phPrinter as LPHANDLE, byval pDefault as LPPRINTER_DEFAULTS, byval pOptions as PPRINTER_OPTIONS) as WINBOOL
#endif

#if defined(UNICODE) and (_WIN32_WINNT = &h0602)
	#define OpenPrinter2 OpenPrinter2W
#elseif (not defined(UNICODE)) and (_WIN32_WINNT = &h0602)
	#define OpenPrinter2 OpenPrinter2A
#endif

#if _WIN32_WINNT = &h0602
	declare function UploadPrinterDriverPackageA(byval pszServer as LPCSTR, byval pszInfPath as LPCSTR, byval pszEnvironment as LPCSTR, byval dwFlags as DWORD, byval hwnd as HWND, byval pszDestInfPath as LPSTR, byval pcchDestInfPath as PULONG) as HRESULT
	declare function UploadPrinterDriverPackageW(byval pszServer as LPCWSTR, byval pszInfPath as LPCWSTR, byval pszEnvironment as LPCWSTR, byval dwFlags as DWORD, byval hwnd as HWND, byval pszDestInfPath as LPWSTR, byval pcchDestInfPath as PULONG) as HRESULT
#endif

#if defined(UNICODE) and (_WIN32_WINNT = &h0602)
	#define UploadPrinterDriverPackage UploadPrinterDriverPackageW
#elseif (not defined(UNICODE)) and (_WIN32_WINNT = &h0602)
	#define UploadPrinterDriverPackage UploadPrinterDriverPackageA
#endif

end extern
