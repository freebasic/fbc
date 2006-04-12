''
''
'' winperf -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_winperf_bi__
#define __win_winperf_bi__

#define PERF_DATA_VERSION 1
#define PERF_DATA_REVISION 1
#define PERF_NO_INSTANCES -1
#define PERF_SIZE_DWORD 0
#define PERF_SIZE_LARGE 256
#define PERF_SIZE_ZERO 512
#define PERF_SIZE_VARIABLE_LEN 768
#define PERF_TYPE_NUMBER 0
#define PERF_TYPE_COUNTER 1024
#define PERF_TYPE_TEXT 2048
#define PERF_TYPE_ZERO &hC00
#define PERF_NUMBER_HEX 0
#define PERF_NUMBER_DECIMAL &h10000
#define PERF_NUMBER_DEC_1000 &h20000
#define PERF_COUNTER_VALUE 0
#define PERF_COUNTER_RATE &h10000
#define PERF_COUNTER_FRACTION &h20000
#define PERF_COUNTER_BASE &h30000
#define PERF_COUNTER_ELAPSED &h40000
#define PERF_COUNTER_QUEUELEN &h50000
#define PERF_COUNTER_HISTOGRAM &h60000
#define PERF_TEXT_UNICODE 0
#define PERF_TEXT_ASCII &h10000
#define PERF_TIMER_TICK 0
#define PERF_TIMER_100NS &h100000
#define PERF_OBJECT_TIMER &h200000
#define PERF_DELTA_COUNTER &h400000
#define PERF_DELTA_BASE &h800000
#define PERF_INVERSE_COUNTER &h1000000
#define PERF_MULTI_COUNTER &h2000000
#define PERF_DISPLAY_NO_SUFFIX 0
#define PERF_DISPLAY_PER_SEC &h10000000
#define PERF_DISPLAY_PERCENT &h20000000
#define PERF_DISPLAY_SECONDS &h30000000
#define PERF_DISPLAY_NOSHOW &h40000000
#define PERF_COUNTER_HISTOGRAM_TYPE &h80000000
#define PERF_NO_UNIQUE_ID (-1)
#define PERF_DETAIL_NOVICE 100
#define PERF_DETAIL_ADVANCED 200
#define PERF_DETAIL_EXPERT 300
#define PERF_DETAIL_WIZARD 400
#define PERF_COUNTER_COUNTER (0 or 1024 or &h10000 or 0 or &h400000 or &h10000000)
#define PERF_COUNTER_TIMER (256 or 1024 or &h10000 or 0 or &h400000 or &h20000000)
#define PERF_COUNTER_QUEUELEN_TYPE (0 or 1024 or &h50000 or 0 or &h400000 or 0)
#define PERF_COUNTER_BULK_COUNT (256 or 1024 or &h10000 or 0 or &h400000 or &h10000000)
#define PERF_COUNTER_TEXT (768 or 2048 or 0 or 0)
#define PERF_COUNTER_RAWCOUNT (0 or 0 or &h10000 or 0)
#define PERF_COUNTER_LARGE_RAWCOUNT (256 or 0 or &h10000 or 0)
#define PERF_COUNTER_RAWCOUNT_HEX (0 or 0 or 0 or 0)
#define PERF_COUNTER_LARGE_RAWCOUNT_HEX (256 or 0 or 0 or 0)
#define PERF_SAMPLE_FRACTION (0 or 1024 or &h20000 or &h400000 or &h800000 or &h20000000)
#define PERF_SAMPLE_COUNTER (0 or 1024 or &h10000 or 0 or &h400000 or 0)
#define PERF_COUNTER_NODATA (512 or &h40000000)
#define PERF_COUNTER_TIMER_INV (256 or 1024 or &h10000 or 0 or &h400000 or &h1000000 or &h20000000)
#define PERF_SAMPLE_BASE (0 or 1024 or &h30000 or &h40000000 or 1)
#define PERF_AVERAGE_TIMER (0 or 1024 or &h20000 or &h30000000)
#define PERF_AVERAGE_BASE (0 or 1024 or &h30000 or &h40000000 or 2)
#define PERF_AVERAGE_BULK (256 or 1024 or &h20000 or &h40000000)
#define PERF_100NSEC_TIMER (256 or 1024 or &h10000 or &h100000 or &h400000 or &h20000000)
#define PERF_100NSEC_TIMER_INV (256 or 1024 or &h10000 or &h100000 or &h400000 or &h1000000 or &h20000000)
#define PERF_COUNTER_MULTI_TIMER (256 or 1024 or &h10000 or &h400000 or 0 or &h2000000 or &h20000000)
#define PERF_COUNTER_MULTI_TIMER_INV (256 or 1024 or &h10000 or &h400000 or &h2000000 or 0 or &h1000000 or &h20000000)
#define PERF_COUNTER_MULTI_BASE (256 or 1024 or &h30000 or &h2000000 or &h40000000)
#define PERF_100NSEC_MULTI_TIMER (256 or 1024 or &h400000 or &h10000 or &h100000 or &h2000000 or &h20000000)
#define PERF_100NSEC_MULTI_TIMER_INV (256 or 1024 or &h400000 or &h10000 or &h100000 or &h2000000 or &h1000000 or &h20000000)
#define PERF_RAW_FRACTION (0 or 1024 or &h20000 or &h20000000)
#define PERF_RAW_BASE (0 or 1024 or &h30000 or &h40000000 or 3)
#define PERF_ELAPSED_TIME (256 or 1024 or &h40000 or &h200000 or &h30000000)

type PERF_DATA_BLOCK
	Signature as wstring * 4
	LittleEndian as DWORD
	Version as DWORD
	Revision as DWORD
	TotalByteLength as DWORD
	HeaderLength as DWORD
	NumObjectTypes as DWORD
	DefaultObject as LONG
	SystemTime as SYSTEMTIME
	PerfTime as LARGE_INTEGER
	PerfFreq as LARGE_INTEGER
	PerfTime100nSec as LARGE_INTEGER
	SystemNameLength as DWORD
	SystemNameOffset as DWORD
end type

type PPERF_DATA_BLOCK as PERF_DATA_BLOCK ptr

type PERF_OBJECT_TYPE
	TotalByteLength as DWORD
	DefinitionLength as DWORD
	HeaderLength as DWORD
	ObjectNameTitleIndex as DWORD
	ObjectNameTitle as LPWSTR
	ObjectHelpTitleIndex as DWORD
	ObjectHelpTitle as LPWSTR
	DetailLevel as DWORD
	NumCounters as DWORD
	DefaultCounter as LONG
	NumInstances as LONG
	CodePage as DWORD
	PerfTime as LARGE_INTEGER
	PerfFreq as LARGE_INTEGER
end type

type PPERF_OBJECT_TYPE as PERF_OBJECT_TYPE ptr

type PERF_COUNTER_DEFINITION
	ByteLength as DWORD
	CounterNameTitleIndex as DWORD
	CounterNameTitle as LPWSTR
	CounterHelpTitleIndex as DWORD
	CounterHelpTitle as LPWSTR
	DefaultScale as LONG
	DetailLevel as DWORD
	CounterType as DWORD
	CounterSize as DWORD
	CounterOffset as DWORD
end type

type PPERF_COUNTER_DEFINITION as PERF_COUNTER_DEFINITION ptr

type PERF_INSTANCE_DEFINITION
	ByteLength as DWORD
	ParentObjectTitleIndex as DWORD
	ParentObjectInstance as DWORD
	UniqueID as LONG
	NameOffset as DWORD
	NameLength as DWORD
end type

type PPERF_INSTANCE_DEFINITION as PERF_INSTANCE_DEFINITION ptr

type PERF_COUNTER_BLOCK
	ByteLength as DWORD
end type

type PPERF_COUNTER_BLOCK as PERF_COUNTER_BLOCK ptr

type PM_OPEN_PROC as DWORD
type PM_COLLECT_PROC as DWORD
type PM_CLOSE_PROC as DWORD

#endif
